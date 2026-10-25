"""Report papers whose figures never made it into the Typst output.

A converted paper with 10 figure environments but 0 `image()` calls has lost its figures;
the assets are still in `src/` as PDF/EPS/PNG and only need wiring + rasterising.
"""
import glob, os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

ASSET = re.compile(r"\.(pdf|png|jpe?g|eps|gif|svg)$", re.I)

for d in sorted(glob.glob("papers/2*")):
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        continue
    s = open(f, encoding="utf-8", errors="replace").read()
    nfig = len(re.findall(r"#figure\(", s))
    nimg = len(re.findall(r"\bimage\(", s))
    ncetz = s.count("cetz.canvas")
    srcs = [p for p in glob.glob(os.path.join(d, "src", "**", "*"), recursive=True)
            if ASSET.search(p) and os.path.isfile(p)]
    wired = os.path.isdir(os.path.join(d, "imgs")) and len(os.listdir(os.path.join(d, "imgs")))
    pdf = os.path.join(d, "out.pdf")
    kb = os.path.getsize(pdf) // 1024 if os.path.exists(pdf) else 0
    flag = "  <-- FIGURES MISSING" if nfig > 2 and (nimg + ncetz) == 0 else (
        "  <-- few wired" if len(srcs) > 4 and (nimg + ncetz) < len(srcs) // 2 else "")
    print("%-12s pdf=%6dKB fig=%3d img=%3d cetz=%2d src_assets=%3d imgs_dir=%3d%s" % (
        os.path.basename(d), kb, nfig, nimg, ncetz, len(srcs), wired or 0, flag))
