# -*- coding: utf-8 -*-
"""Annotate raster figures with a multimodal description, as Typst comments at the figure site.

The description is a `// [figvision] …` comment block placed directly before the `#figure(`
call, so it never reaches the compiled PDF. Everything else is left untouched; after
annotating a paper the tool rebuilds it and compares the text layer with the pre-edit build,
so a changed rendering is caught instead of assumed.

Usage:
  python tools/fig_annotate.py 2408.13687 2306.16213 --apply
  python tools/fig_annotate.py --all --apply --workers 4
  python tools/fig_annotate.py 2408.13687            # list figures, no API calls

Cache: tools/figvision_cache.json, keyed by image content hash, so re-runs are free.
"""
import io, os, re, sys, glob, json, hashlib, base64, subprocess, threading, queue, time
import urllib.request, urllib.error
import pymupdf

CFG = r'E:\tools\OpenCode2API-main\config.json'
BASE = os.environ.get('FIGVISION_BASE', 'http://127.0.0.1:10000')
MODEL = os.environ.get('FIGVISION_MODEL', 'opencode/nemotron-3.5-super-vl-free')
MODEL2 = os.environ.get('FIGVISION_MODEL2', '')
TIMEOUT = float(os.environ.get('FIGVISION_TIMEOUT', '120'))
WORKERS = int(os.environ.get('FIGVISION_WORKERS', '4'))
# reasoning models spend the budget thinking first; 900 yields finish_reason=length, empty content
MAXTOK = int(os.environ.get('FIGVISION_MAXTOK', '4000'))
KEY = os.environ.get('FIGVISION_KEY', '')
CACHE = 'tools/figvision_cache.json'
MARK = '// [figvision]'
RASTER = ('.png', '.jpg', '.jpeg', '.gif', '.webp', '.bmp', '.tif', '.tiff')
SKIP = ('.pre', '.bak', '.orig', '_work', '/build/', '/check/')

FIGCALL = re.compile(r'(?<![\w#])#figure\s*([(\[])')
IMG = re.compile(r'image\(\s*"([^"]+)"')
CAPTION = re.compile(r'caption\s*:\s*\[([\s\S]{0,1200})')

PROMPT = (
    'You are annotating a scientific figure for a text-to-Typst archive. Describe the figure '
    'so a reader who cannot see it can reconstruct it. Work panel by panel (a, b, c…). For each '
    'panel state: what is drawn (plot / schematic / micrograph / diagram), the axes and their '
    'ranges and units, every series or colour with its meaning, symbols and line styles, '
    'annotations and labels, and the trend or message. For schematics name the objects and '
    'their connections or layout. Be concrete and quantitative when the image shows numbers. '
    'Plain prose, about 60-110 words per panel, no markdown, no preamble. Caption for context: '
)

_cache_lock = threading.Lock()
_fail_lock = threading.Lock()
_consec_fail = [0]
_stop = threading.Event()
FAIL_LIMIT = int(os.environ.get('FIGVISION_FAIL_LIMIT', '8'))


def load_cache():
    if os.path.exists(CACHE):
        return json.load(io.open(CACHE, encoding='utf-8'))
    return {}


def save_cache(c):
    io.open(CACHE, 'w', encoding='utf-8', newline='\n').write(
        json.dumps(c, ensure_ascii=False, indent=0))


def balanced(s, start, open_ch, close_ch):
    depth = 0
    i = start
    in_str = False
    while i < len(s):
        ch = s[i]
        if in_str:
            if ch == '"' and s[i - 1] != '\\':
                in_str = False
        elif ch == '"':
            in_str = True
        elif ch == '\\':
            i += 1
        elif ch == open_ch:
            depth += 1
        elif ch == close_ch:
            depth -= 1
            if depth == 0:
                return s[start + 1:i], i + 1
        i += 1
    return None, None


def live_typ(pdir):
    out = []
    for f in sorted(glob.glob(os.path.join(pdir, '**', '*.typ'), recursive=True)):
        n = f.replace('\\', '/')
        if any(t in os.path.basename(f) for t in ('.pre', '.bak', '.orig')):
            continue
        if any(d in n for d in SKIP):
            continue
        out.append(f)
    return out


def figures(path):
    """[(insert_pos, images, caption_text)] for every #figure with a raster image."""
    s = io.open(path, encoding='utf-8', errors='replace').read()
    out = []
    i = 0
    while True:
        m = FIGCALL.search(s, i)
        if not m:
            break
        k = m.end() - 1
        grp, nxt = balanced(s, k, s[k], ')' if s[k] == '(' else ']')
        if grp is None:
            i = m.end()
            continue
        i = nxt
        imgs = [p for p in IMG.findall(grp) if os.path.splitext(p)[1].lower() in RASTER]
        if not imgs:
            continue
        cap = CAPTION.search(grp)
        text = re.sub(r'#\w+\[|\]|@[\w:.\-]+|<[^>]+>|\$[^$]*\$', ' ', cap.group(1)) if cap else ''
        text = re.sub(r'\s+', ' ', text).strip()[:400]
        line_start = s.rfind('\n', 0, m.start()) + 1
        out.append((line_start, imgs, text))
    return s, out


def png_bytes(path, workdir):
    ext = os.path.splitext(path)[1].lower()
    if ext in RASTER:
        return io.open(path, 'rb').read()
    if ext == '.pdf':
        base = os.path.join(workdir, 'figvision_' + hashlib.md5(path.encode()).hexdigest()[:10])
        subprocess.run(['pdftoppm', '-png', '-r', '120', '-f', '1', '-l', '1', path, base],
                       check=False, capture_output=True)
        cand = sorted(glob.glob(base + '*.png'))
        return io.open(cand[0], 'rb').read() if cand else None
    return None


def shrink(data, max_side=1500):
    """Re-encode figures to a small JPEG: the gateway stalls on multi-megabyte payloads."""
    from PIL import Image
    try:
        im = Image.open(io.BytesIO(data))
        im.load()
    except Exception:
        return data, 'image/png'
    if im.mode in ('RGBA', 'LA', 'P'):
        im = im.convert('RGBA')
        bg = Image.new('RGB', im.size, 'white')
        bg.paste(im, mask=im.split()[-1])
        im = bg
    elif im.mode != 'RGB':
        im = im.convert('RGB')
    if max(im.size) > max_side:
        im.thumbnail((max_side, max_side), Image.LANCZOS)
    buf = io.BytesIO()
    im.save(buf, 'JPEG', quality=88)
    return buf.getvalue(), 'image/jpeg'


def describe(img_path, caption, cache):
    data = png_bytes(img_path, 'tmp')
    if not data:
        return None
    key = hashlib.md5(data).hexdigest()
    with _cache_lock:
        if key in cache:
            return cache[key]
    cfg = json.load(io.open(CFG, encoding='utf-8'))
    key = KEY or cfg['API_KEY']
    send, mime = shrink(data)
    # the proxy pins a session per `user`; without a distinct one every worker queues behind
    # the same backend conversation and the pool degrades to serial. Retry once on a fresh
    # session: a stuck backend conversation otherwise times out every later image.
    txt = None
    # A wedged backend answers nothing at all, so a long retry ladder just burns the
    # run. Two rounds over the model list bounds the cost at 4 timeouts per image.
    models = [MODEL] + ([MODEL2] if MODEL2 and MODEL2 != MODEL else [])
    for rnd in range(2):
        for model in models:
            body = {'model': model, 'max_tokens': MAXTOK,
                    'user': 'figvision-%d-%d-%s' % (threading.get_ident(), rnd, model),
                    'messages': [{'role': 'user', 'content': [
                {'type': 'text', 'text': PROMPT + (caption or '(none)')},
                {'type': 'image_url', 'image_url': {
                    'url': 'data:' + mime + ';base64,' + base64.b64encode(send).decode()}}]}]}
            req = urllib.request.Request(BASE + '/v1/chat/completions',
                                         data=json.dumps(body).encode(),
                                         headers={'Authorization': 'Bearer ' + key,
                                                  'Content-Type': 'application/json'})
            try:
                d = json.load(urllib.request.urlopen(req, timeout=TIMEOUT))
                txt = (d['choices'][0]['message'].get('content') or '').strip()
                if txt:
                    break
                sys.stderr.write('  ! %s: %s empty content, next\n'
                                 % (os.path.basename(img_path), model))
            except urllib.error.HTTPError as e:
                if e.code in (429, 500, 502, 503, 504):
                    sys.stderr.write('  ! %s: %s HTTP %d, next\n'
                                     % (os.path.basename(img_path), model, e.code))
                    time.sleep((20 if e.code == 429 else 5) * (rnd + 1))
                    continue
                sys.stderr.write('  ! %s: %s\n' % (os.path.basename(img_path), e))
                break
            except Exception as e:
                sys.stderr.write('  ! %s: %s %s\n'
                                 % (os.path.basename(img_path), model, type(e).__name__))
        if txt:
            break
    if not txt:
        return None
    txt = re.sub(r'\s+', ' ', txt)
    txt = re.sub(r'\$|\\[a-zA-Z]+|\*\*', '', txt)
    with _cache_lock:
        cache[key] = txt
        save_cache(cache)
    return txt


def wrap(text, width=110):
    words, lines, cur = text.split(' '), [], ''
    for w in words:
        if len(cur) + len(w) + 1 > width:
            lines.append(cur)
            cur = w
        else:
            cur = (cur + ' ' + w).strip()
    if cur:
        lines.append(cur)
    return lines


def comment_block(rel, desc):
    head = '%s %s' % (MARK, rel)
    return '\n'.join([head] + ['// ' + l for l in wrap(desc)])


def annotate(pid, apply, cache):
    pdir = os.path.join('papers', pid)
    jobs = []
    for typ in live_typ(pdir):
        s, figs = figures(typ)
        for pos, imgs, cap in figs:
            for rel in imgs:
                img_path = os.path.normpath(os.path.join(os.path.dirname(typ), rel))
                jobs.append((typ, pos, rel, img_path, cap))
    if not jobs:
        print('%-12s no raster figures' % pid)
        return 0
    print('%-12s %d raster figures' % (pid, len(jobs)))
    if not apply:
        for typ, pos, rel, img_path, cap in jobs:
            print('   %s  %s' % (os.path.basename(typ), rel))
        return len(jobs)
    descs = {}

    def work(q):
        while True:
            if _stop.is_set():
                return
            try:
                item = q.get_nowait()
            except queue.Empty:
                return
            key = item
            descs[key] = describe(jobs[key][3], jobs[key][4], cache)
            with _fail_lock:
                _consec_fail[0] = 0 if descs[key] else _consec_fail[0] + 1
                if _consec_fail[0] >= FAIL_LIMIT:
                    # backend is down, not this figure: stop the sweep instead of
                    # spending a full timeout ladder on every remaining image
                    sys.stderr.write('  !! %d consecutive failures, aborting sweep\n'
                                     % _consec_fail[0])
                    _stop.set()

    q = queue.Queue()
    for i in range(len(jobs)):
        q.put(i)
    nthreads = min(WORKERS, len(jobs))
    ts = [threading.Thread(target=work, args=(q,)) for _ in range(nthreads)]
    [t.start() for t in ts]
    [t.join() for t in ts]
    if _stop.is_set():
        _stop.clear()
        _consec_fail[0] = 0
        return -1

    by_file = {}
    for i, (typ, pos, rel, img_path, cap) in enumerate(jobs):
        by_file.setdefault(typ, []).append((pos, rel, descs.get(i)))
    for typ, items in by_file.items():
        s = io.open(typ, encoding='utf-8').read()
        lines = s.split('\n')
        # offsets are only valid on the pristine text: convert once, then edit bottom-up
        edits = [(s.count('\n', 0, pos), rel, desc) for pos, rel, desc in items if desc]
        for li, rel, desc in sorted(edits, reverse=True):
            j = k = li
            while k - 1 >= 0 and lines[k - 1].startswith('//'):
                k -= 1
            old = next((m for m in range(li - 1, k - 1, -1)
                        if lines[m].startswith(MARK)), None)
            if old is not None:
                del lines[old:li]
                j = old
            lines[j:j] = comment_block(rel, desc).split('\n')
        io.open(typ, 'w', encoding='utf-8', newline='\n').write('\n'.join(lines))
    return len(jobs)


def pdf_text(pdir):
    pdf = os.path.join(pdir, 'build', 'main.pdf')
    if not os.path.exists(pdf):
        return None
    r = subprocess.run(['pdftotext', '-enc', 'UTF-8', pdf, '-'], capture_output=True)
    return r.stdout.decode('utf-8', 'replace')


def compile_paper(pid):
    log = os.path.join('papers', pid, 'build', 'compile.log')
    os.makedirs(os.path.dirname(log), exist_ok=True)
    with io.open(log, 'w', encoding='utf-8') as fh:
        subprocess.run(['typst', 'compile', '--root', '.', 'papers/%s/main.typ' % pid,
                        'papers/%s/build/main.pdf' % pid], stderr=fh)
    s = io.open(log, encoding='utf-8', errors='replace').read()
    return s.count('\nerror') + s.startswith('error'), s.count('\nwarning') + s.startswith('warning')


def main():
    argv = sys.argv[1:]
    apply = '--apply' in argv
    workers = int(argv[argv.index('--workers') + 1]) if '--workers' in argv else 1
    ids = [a for a in argv if re.match(r'^\d{4}\.\d{4,5}$', a)]
    if '--all' in argv:
        ids = [d for d in sorted(os.listdir('papers'))
               if os.path.exists(os.path.join('papers', d, 'main.typ'))]
    cache = load_cache()
    for pid in ids:
        before = pdf_text(os.path.join('papers', pid))
        n = annotate(pid, apply, cache)
        if apply and n > 0:
            e, w = compile_paper(pid)
            after = pdf_text(os.path.join('papers', pid)) or ''
            same = 'identical' if before and before == after else 'CHANGED'
            leak = 'LEAK' if 'figvision' in after else 'clean'
            print('%-12s E=%d W=%d text=%s %s' % (pid, e, w, same, leak))


if __name__ == '__main__':
    main()
