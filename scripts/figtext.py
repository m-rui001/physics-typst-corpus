"""Turn leftover `\includegraphics` text into real images.

The converter sometimes leaves the raw command as literal prose inside a figure block
(`figures/foo.pdf (-9,1)`), so the paper renders a file path instead of the plot. This
finds those bare paths, rasterises the source PDF/EPS with PyMuPDF into imgs/, and puts a
proper `image()` call in their place."""
import glob, io, os, re, sys

import pymupdf

PATH = re.compile(r"(?<![\"\w/])([A-Za-z0-9_][A-Za-z0-9_./\-]*\.(?:pdf|png|jpe?g))(?![\w(])")


def find(paper, rel):
    cand = [os.path.join(paper, "src", rel), os.path.join(paper, rel),
            os.path.join(paper, "src", os.path.basename(rel))]
    for c in cand:
        if os.path.exists(c):
            return c
    hits = glob.glob(os.path.join(paper, "src", "**", os.path.basename(rel)), recursive=True)
    return hits[0] if hits else None


def process(paper):
    typ = os.path.join(paper, "main.typ")
    if not os.path.exists(typ):
        return
    body = io.open(typ, encoding="utf-8").read()
    os.makedirs(os.path.join(paper, "imgs"), exist_ok=True)
    done, miss = 0, 0
    for m in set(PATH.findall(body)):
        if 'image("%s"' % m in body or 'image("%s' % m in body:
            continue
        srcf = find(paper, m)
        if not srcf:
            miss += 1
            continue
        base = os.path.splitext(os.path.basename(m))[0]
        png = "imgs/%s.figr.png" % base
        out = os.path.join(paper, png)
        if srcf.lower().endswith(".pdf"):
            try:
                doc = pymupdf.open(srcf)
                doc[0].get_pixmap(dpi=160).save(out)
                doc.close()
            except Exception:
                miss += 1
                continue
        else:
            import shutil
            shutil.copyfile(srcf, out)
        if not os.path.exists(out):
            miss += 1
            continue
        body = re.sub(re.escape(m) + r"(?:\s*\([^)]*\))?",
                      lambda mm: '#image("%s", width: 100%%)' % png, body, count=1)
        done += 1
    if done:
        io.open(typ, "w", encoding="utf-8").write(body)
    print(os.path.basename(paper), "figures wired", done, "unresolved", miss, flush=True)


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    for d in sys.argv[1:]:
        try:
            process(d)
        except Exception as e:
            print("FAIL", d, repr(e)[:150], flush=True)
