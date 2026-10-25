import os, subprocess, json, sys, re
import pymupdf

ROOT = r'E:\phys'
T = r'C:\Users\hp\AppData\Local\Microsoft\WinGet\Packages\Typst.Typst_Microsoft.Winget.Source_8wekyb3d8bbwe\typst-x86_64-pc-windows-msvc\typst.exe'
OUT = os.path.join(ROOT, 'tmp', 'verify')
os.makedirs(OUT, exist_ok=True)
base = json.load(open(os.path.join(ROOT, 'tmp', 'baseline_pages.json')))
rows = []
for pid in sorted(os.listdir(os.path.join(ROOT, 'papers'))):
    p = os.path.join(ROOT, 'papers', pid, 'main.typ')
    if not os.path.exists(p):
        rows.append((pid, 0, base.get(pid), 'NO_MAIN'))
        continue
    pdf = os.path.join(OUT, pid + '.pdf')
    r = subprocess.run([T, 'compile', '--no-pdf-tags', '--diagnostic-format', 'short',
                        '--root', ROOT, p, pdf], capture_output=True, text=True)
    errs = [l for l in (r.stdout + r.stderr).splitlines() if l.strip()]
    errs = [l for l in errs if 'unknown font family' not in l and 'deprecated' not in l]
    try:
        pages = pymupdf.open(pdf).page_count
    except Exception:
        pages = 0
    rows.append((pid, pages, base.get(pid), '; '.join(errs)[:160]))
    print(f'{pid} pages={pages} base={base.get(pid)} errs={len(errs)}', flush=True)
json.dump(rows, open(os.path.join(ROOT, 'tmp', 'verify_report.json'), 'w'), indent=0)
