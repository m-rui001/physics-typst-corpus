"""Point every image() call at a real raster file: rasterise PDF/EPS figures from src/."""
import os, glob, re, sys

sys_stdout = sys.stdout

import pymupdf


def find_src(paper, rel):
    base = os.path.basename(rel)
    for stem in {os.path.splitext(base)[0], base}:
        for ext in ("", ".pdf", ".png", ".jpg", ".jpeg", ".eps", ".gif"):
            f = stem + ext
            hits = glob.glob(os.path.join(paper, "**", f), recursive=True)
            if hits:
                return hits[0]
    return None


def raster(pdf, out):
    d = pymupdf.open(pdf)
    p = d[0]
    pix = p.get_pixmap(dpi=200)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    pix.save(out)
    d.close()
    return out


n = 0
dirs = sys.argv[1:] or [r"E:\phys\papers\2104.02565", r"E:\phys\papers\2111.08640",
                        r"E:\phys\papers\2207.06431", r"E:\phys\papers\2102.01111"]
for paper in sorted(dirs):
    typ = os.path.join(paper, "main.typ")
    if not os.path.exists(typ):
        continue
    t = open(typ, encoding="utf-8", errors="replace").read()

    def fix(m):
        global n
        path = m.group(1) or m.group(2)
        if not path or path.startswith("http"):
            return m.group(0)
        ap = path if os.path.isabs(path) else os.path.join(paper, path)
        if os.path.exists(ap) and ap.lower().endswith((".png", ".jpg", ".jpeg")):
            return m.group(0)
        src = find_src(paper, path)
        if not src:
            return "#text([])" + "  %% missing figure: %s" % os.path.basename(path)
        out = os.path.join(paper, "imgs", os.path.splitext(os.path.basename(src))[0] + ".png")
        if not os.path.exists(out):
            try:
                if src.lower().endswith((".pdf", ".eps")):
                    raster(src, out)
                else:
                    return m.group(0).replace(path, os.path.relpath(src, paper).replace("\\", "/"))
            except Exception as e:
                print("rasterise fail", src, repr(e)[:80])
                return m.group(0)
        n += 1
        return 'image("%s")' % os.path.relpath(out, paper).replace("\\", "/")

    t2 = re.sub(r'image\(\s*(?:"([^"]*)"|path\("([^"]*)"\))', fix, t)
    if t2 != t:
        open(typ, "w", encoding="utf-8").write(t2)
        print("fixed images in", os.path.basename(paper), flush=True)
print("RASTERISED", n)
