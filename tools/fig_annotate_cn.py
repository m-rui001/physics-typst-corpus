# -*- coding: utf-8 -*-
"""Annotate raster figures with a Chinese multimodal description, as Typst comments.

Description goes directly before each `#figure(...)` call, marked `// [figvision-cn]`,
so it never reaches the compiled PDF. After editing, the paper is rebuilt and the PDF
text layer is compared with the pre-edit build (must be byte-identical), and checked
for leaked marker text.

Usage:
  python tools/fig_annotate_cn.py 2105.07507 --apply
  python tools/fig_annotate_cn.py --all --apply --workers 6
  python tools/fig_annotate_cn.py 2105.07507          # list figures only

Cache: tools/figvision_cn_cache.json (content-hash keyed).
"""
import io, os, re, sys, glob, json, hashlib, base64, subprocess, threading, queue, time
import urllib.request, urllib.error

BASE = os.environ.get('FIGVISION_CN_BASE', 'https://cssmapi.fun')
MODEL = os.environ.get('FIGVISION_CN_MODEL', 'deepseek-v4.1-flash')
SESSION = os.environ.get('FIGVISION_CN_SESSION', '')
KEY = os.environ.get('FIGVISION_CN_KEY', '')
UA = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/124.0 Safari/537.36')
TIMEOUT = float(os.environ.get('FIGVISION_CN_TIMEOUT', '120'))
WORKERS = int(os.environ.get('FIGVISION_CN_WORKERS', '6'))
MAXTOK = int(os.environ.get('FIGVISION_CN_MAXTOK', '4000'))
CACHE = os.environ.get('FIGVISION_CN_CACHE', 'tools/figvision_cn_cache.json')
MARK = '// [figvision-cn]'
RASTER = ('.png', '.jpg', '.jpeg', '.gif', '.webp', '.bmp', '.tif', '.tiff')
SKIP = ('.pre', '.bak', '.orig', '_work', '/build/', '/check/')

TYPST = ('C:/Users/hp/AppData/Local/Microsoft/WinGet/Packages/'
         'Typst.Typst_Microsoft.Winget.Source_8wekyb3d8bbwe/typst-x86_64-pc-windows-msvc/typst.exe')

FIGCALL = re.compile(r'(?<![\w#])#figure\s*([(\[])')
IMG = re.compile(r'image\(\s*"([^"]+)"')
CAPTION = re.compile(r'caption\s*:\s*\[([\s\S]{0,1200})')

PROMPT = (
    '请为一张科学论文插图撰写供无法看到图片的读者重建图像的详细中文描述。'
    '逐个子图（a、b、c…）说明：子图类型（曲线图/示意图/显微照片/相图/流程图）、'
    '坐标轴名称及其范围与单位、每条曲线或每个色标的物理含义、符号与线型、'
    '图中所有标注文字、以及该子图传达的趋势或结论；示意图需说明物体及其连接与布局；'
    '显微图需说明成像通道、颜色映射与比例尺。语言具体、定量，避免空泛形容，'
    '不要使用 Markdown，不要开场白，直接输出正文。图注参考：'
)

_cache_lock = threading.Lock()
_fail_lock = threading.Lock()
_consec_fail = [0]
_stop = threading.Event()
FAIL_LIMIT = int(os.environ.get('FIGVISION_CN_FAIL_LIMIT', '10'))
INTERVAL = float(os.environ.get('FIGVISION_CN_INTERVAL', '4'))
_req_lock = threading.Lock()
_last_req = [0.0]


def throttle():
    with _req_lock:
        wait = _last_req[0] + INTERVAL - time.time()
        if wait > 0:
            time.sleep(wait)
        _last_req[0] = time.time()


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
        if any(t in os.path.basename(f) for t in ('.pre', '.bak', '.orig', '_old', '_debug')):
            continue
        if any(d in n for d in SKIP):
            continue
        rel = os.path.relpath(f, pdir).replace('\\', '/')
        if any(part.startswith('_') for part in rel.split('/')):
            continue
        out.append(f)
    return out


def figures(path):
    """[(insert_pos, images, caption_text)] for every #figure with a raster image."""
    s = io.open(path, encoding='utf-8', errors='replace', newline='').read()
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


def png_bytes(path):
    ext = os.path.splitext(path)[1].lower()
    if ext in RASTER:
        return io.open(path, 'rb').read()
    if ext == '.pdf':
        import pymupdf
        doc = pymupdf.open(path)
        pix = doc[0].get_pixmap(dpi=150)
        return pix.tobytes('png')
    return None


def shrink(path, data, max_side=None):
    if max_side is None:
        max_side = int(os.environ.get('FIGVISION_CN_MAXSIDE', '1024'))
    from PIL import Image
    Image.MAX_IMAGE_PIXELS = None
    im = None
    try:
        im = Image.open(io.BytesIO(data))
        w, h = im.size
    except Exception:
        return data, 'image/png'
    if w * h > 60_000_000:
        # very large PNGs (up to 300 Mpx here) blow up PIL; MuPDF shrinks cheaply
        import pymupdf, math
        pm = pymupdf.Pixmap(path)
        factor = max(0, math.ceil(math.log2(max(pm.width, pm.height) / max_side)))
        if factor:
            pm.shrink(factor)
        im = Image.open(io.BytesIO(pm.tobytes('png')))
    im.load()
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
    try:
        data = png_bytes(img_path)
    except Exception:
        return None
    if not data:
        return None
    key = hashlib.md5(data).hexdigest()
    with _cache_lock:
        if key in cache:
            return cache[key]
    send, mime = shrink(img_path, data)
    txt = None
    for rnd in range(5):
        body = {'model': MODEL, 'max_tokens': MAXTOK,
                'messages': [{'role': 'user', 'content': [
                    {'type': 'text', 'text': PROMPT + (caption or '(无)')},
                    {'type': 'image_url', 'image_url': {
                        'url': 'data:' + mime + ';base64,' + base64.b64encode(send).decode()}}]}]}
        throttle()
        req = urllib.request.Request(
            BASE + '/v1/chat/completions', data=json.dumps(body).encode(),
            headers={'Authorization': 'Bearer ' + KEY,
                     'Content-Type': 'application/json',
                     'Accept': 'application/json', 'User-Agent': UA, 'Connection': 'close'})
        try:
            d = json.load(urllib.request.urlopen(req, timeout=TIMEOUT))
            txt = (d['choices'][0]['message'].get('content') or '').strip()
            if txt:
                break
            sys.stderr.write('  ! %s empty content, retry\n' % os.path.basename(img_path))
        except urllib.error.HTTPError as e:
            sys.stderr.write('  ! %s HTTP %d\n' % (os.path.basename(img_path), e.code))
            if e.code in (429, 500, 502, 503, 504):
                ra = e.headers.get('Retry-After') if e.headers else None
                time.sleep(int(ra) if ra and ra.isdigit() else (30 if e.code == 429 else 5 * (rnd + 1)))
                continue
            break
        except Exception as e:
            sys.stderr.write('  ! %s %s\n' % (os.path.basename(img_path), type(e).__name__))
            time.sleep(3 * (rnd + 1))
    if not txt:
        return None
    txt = re.sub(r'(?m)^\s*(?:[-*\u2022]|\d+[.)])\s+', '', txt)
    txt = re.sub(r'(?m)^\s*-{3,}\s*$', '', txt)
    txt = re.sub(r'\*\*', '', txt)
    txt = re.sub(r'(?m)^#{1,6}\s*', '', txt)
    txt = re.sub(r'\s+', ' ', txt).strip()
    with _cache_lock:
        cache[key] = txt
        save_cache(cache)
    return txt


def wrap_cn(text, width=54):
    """Wrap mixed CJK/latin text by display width (CJK counts 2), keeping ASCII words whole."""
    import unicodedata
    def w(ch):
        return 2 if unicodedata.east_asian_width(ch) in 'WF' else 1
    def word(ch):
        return ch.isascii() and (ch.isalnum() or ch in "_-'.")
    units, i = [], 0
    while i < len(text):
        ch = text[i]
        if word(ch):
            j = i
            while j < len(text) and word(text[j]):
                j += 1
            units.append(text[i:j])
            i = j
        else:
            units.append(ch)
            i += 1
    no_lead = '，。；：、）》」！？%'
    lines, cur, cw = [], [], 0
    for u in units:
        uw = sum(w(c) for c in u)
        if cw + uw > width and cur and u not in no_lead:
            lines.append(''.join(cur).rstrip())
            cur, cw = ([], 0) if u == ' ' else ([u], uw)
        else:
            cur.append(u)
            cw += uw
    if ''.join(cur).strip():
        lines.append(''.join(cur).strip())
    return lines


def comment_block(rel, desc):
    head = '%s %s' % (MARK, rel)
    return '\n'.join([head] + ['// ' + l for l in wrap_cn(desc)])


def annotate(pid, apply, cache):
    pdir = os.path.join('papers', pid)
    jobs = []
    for typ in live_typ(pdir):
        s, figs = figures(typ)
        lines = s.split('\n')
        for pos, imgs, cap in figs:
            li = s.count('\n', 0, pos)
            k = li
            while k - 1 >= 0 and lines[k - 1].startswith('//'):
                k -= 1
            blk = lines[k:li]
            # an English vision block already documents this figure: user said keep it
            if any(l.startswith('// [figvision]') for l in blk) and \
               not any(l.startswith(MARK) for l in blk):
                continue
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
                key = q.get_nowait()
            except queue.Empty:
                return
            descs[key] = describe(jobs[key][3], jobs[key][4], cache)
            with _fail_lock:
                _consec_fail[0] = 0 if descs[key] else _consec_fail[0] + 1
                if _consec_fail[0] >= FAIL_LIMIT:
                    sys.stderr.write('  !! %d consecutive failures, aborting sweep\n'
                                     % _consec_fail[0])
                    _stop.set()

    q = queue.Queue()
    for i in range(len(jobs)):
        q.put(i)
    ts = [threading.Thread(target=work, args=(q,)) for _ in range(min(WORKERS, len(jobs)))]
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
        s = io.open(typ, encoding='utf-8', newline='').read()
        lines = s.split('\n')
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
        io.open(typ, 'w', encoding='utf-8', newline='').write('\n'.join(lines))
    return len(jobs)


def pdf_text(pdir):
    import pymupdf
    pdf = os.path.join(pdir, 'build', 'main.pdf')
    if not os.path.exists(pdf):
        return None
    return ''.join(p.get_text() for p in pymupdf.open(pdf))


def compile_paper(pid):
    log = os.path.join('papers', pid, 'build', 'compile.log')
    os.makedirs(os.path.dirname(log), exist_ok=True)
    with io.open(log, 'w', encoding='utf-8') as fh:
        subprocess.run([TYPST, 'compile', '--no-pdf-tags', '--diagnostic-format', 'short',
                        '--root', 'E:/phys', '--font-path', 'E:/phys/fonts',
                        'papers/%s/main.typ' % pid, 'papers/%s/build/main.pdf' % pid],
                       stderr=fh, stdout=subprocess.DEVNULL)
    s = io.open(log, encoding='utf-8', errors='replace').read()
    return (s.count('error:'), s.count('warning:'))


def main():
    global WORKERS
    argv = sys.argv[1:]
    apply = '--apply' in argv
    if '--workers' in argv:
        WORKERS = int(argv[argv.index('--workers') + 1])
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
