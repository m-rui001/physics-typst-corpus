import os, re, sys, shutil, json

ROOT = r'E:\phys'
PAPERS = os.path.join(ROOT, 'papers')
ARCH = r'E:\phys_archive'
APPLY = '--apply' in sys.argv

ASSET_EXT = ('.png', '.jpg', '.jpeg', '.svg', '.pdf', '.eps', '.gif', '.webp',
             '.typ', '.bib', '.csv', '.dat', '.txt', '.csl', '.yml', '.yaml')
META_EXT = ('.typ', '.bib', '.yml', '.yaml', '.csl', '.json', '.md', '.py', '.sh')
REF_RE = re.compile(r'"([^"\n\\]+\.(?:' + '|'.join(e[1:] for e in ASSET_EXT) + r'))"')
KEEP_DIRS = {'imgs', 'figures'}

stats = {'archive': 0, 'bytes': 0, 'keep': 0, 'keepbytes': 0}
moved = []


def scan_typ(paper_dir, typ_path, keep):
    stack = [typ_path]
    seen = set()
    while stack:
        t = stack.pop()
        if t in seen or not os.path.exists(t):
            continue
        seen.add(t)
        keep.add(os.path.normpath(t))
        txt = open(t, encoding='utf-8', errors='replace').read()
        for ref in REF_RE.findall(txt):
            if ref.startswith(('http://', 'https://')):
                continue
            cand = os.path.normpath(os.path.join(os.path.dirname(t), ref))
            if os.path.isfile(cand):
                if cand not in keep:
                    keep.add(cand)
                    if ref.lower().endswith('.typ'):
                        stack.append(cand)


def archive(path, paper_dir):
    rel = os.path.relpath(path, paper_dir)
    dest = os.path.join(ARCH, 'papers', os.path.basename(paper_dir), rel)
    if not APPLY:
        if os.path.isdir(path):
            n = sum(os.path.getsize(os.path.join(r, f))
                    for r, _, fs in os.walk(path) for f in fs)
        else:
            n = os.path.getsize(path)
        stats['archive'] += n
        return
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    if os.path.exists(dest):
        base, ext = os.path.splitext(dest)
        i = 1
        while os.path.exists(f'{base}.{i}{ext}'):
            i += 1
        dest = f'{base}.{i}{ext}'
    shutil.move(path, dest)


for pid in sorted(os.listdir(PAPERS)):
    pdir = os.path.join(PAPERS, pid)
    if not os.path.isdir(pdir):
        continue
    main = os.path.join(pdir, 'main.typ')
    if not os.path.exists(main):
        continue
    keep = set()
    scan_typ(pdir, main, keep)
    for f in os.listdir(pdir):
        fp = os.path.join(pdir, f)
        if os.path.isfile(fp) and f.lower().endswith(META_EXT) and not f.startswith(('main.typ.', 'refs.bib.')):
            keep.add(os.path.normpath(fp))

    # never touch figure dirs that exist; everything inside may be loaded dynamically
    for top in os.listdir(pdir):
        tp = os.path.join(pdir, top)
        if top in KEEP_DIRS and os.path.isdir(tp):
            continue
        if os.path.isfile(tp) and os.path.normpath(tp) in keep:
            continue
        if os.path.isdir(tp):
            has_keep = any(os.path.normpath(os.path.join(r, f)) in keep
                           for r, _, fs in os.walk(tp) for f in fs)
            if not has_keep and top not in ('imgs', 'figures'):
                archive(tp, pdir)
                continue
            for r, ds, fs in os.walk(tp, topdown=False):
                for f in fs:
                    fp = os.path.normpath(os.path.join(r, f))
                    if fp not in keep:
                        archive(fp, pdir)
                for dn in ds:
                    dp = os.path.join(r, dn)
                    if os.path.isdir(dp) and not os.listdir(dp):
                        if APPLY:
                            os.rmdir(dp)
        else:
            archive(tp, pdir)

print(json.dumps({'apply': APPLY, 'moved_entries_bytes': stats['archive'],
                  'MB': round(stats['archive'] / 1048576, 1)}))
