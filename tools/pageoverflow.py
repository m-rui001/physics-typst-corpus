"""Flag text spans that cross the document's right text edge in a built PDF.

eqoverflow.py only sees (N) collisions. A display that spills past the margin
without touching its number is invisible there, so measure the text-block edge
from the PDF itself: justified lines pile up on the right edge, so the largest
well-supported mode of span x1 is the right boundary (works for one- and
two-column layouts; ragged bibliography pages still contribute their edge).

Usage: python tools/pageoverflow.py [papers/<id>/build/main.pdf ...]
"""
import sys
import os
import glob
import collections
import subprocess
import pymupdf

TOL = 2.5
MIN_MODE = 20
ROOT = "E:/phys"


def build(main):
    """Compile current sources; papers/*/build/main.pdf is often stale."""
    d = os.path.dirname(main)
    out = os.path.join(d, "build", "ov.pdf")
    os.makedirs(os.path.dirname(out), exist_ok=True)
    r = subprocess.run(["typst", "compile", "--no-pdf-tags", "--root", ROOT, main, out],
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return out if r.returncode == 0 else None


def right_edge(doc):
    c = collections.Counter()
    for page in doc:
        for b in page.get_text("dict")["blocks"]:
            for l in b.get("lines", []):
                for s in l["spans"]:
                    if s["bbox"][2] - s["bbox"][0] > 40:
                        c[round(s["bbox"][2] * 2) / 2] += 1
    solid = [e for e, n in c.items() if n >= MIN_MODE]
    if solid:
        return max(solid)
    return c.most_common(1)[0][0] if c else None


def scan(path):
    d = pymupdf.open(path)
    edge = right_edge(d)
    hits = []
    if edge is None:
        d.close()
        return hits
    for pno, page in enumerate(d, 1):
        for b in page.get_text("dict")["blocks"]:
            for l in b.get("lines", []):
                for s in l["spans"]:
                    x1 = s["bbox"][2]
                    txt = s["text"].strip()
                    if not txt or x1 <= edge + TOL or txt.isdigit():
                        continue
                    hits.append((pno, round(x1 - edge, 1), s["text"][:70]))
    d.close()
    return hits


if __name__ == "__main__":
    args = sys.argv[1:]
    mains = [a for a in args if a.endswith(".typ")]
    pdfs = [a for a in args if a.endswith(".pdf")]
    if not mains and not pdfs:
        mains = sorted(glob.glob("papers/*/main.typ"))
    total = 0
    for m in mains:
        f = build(m)
        if not f:
            print("%-40s COMPILE FAILED" % m)
            continue
        hits = scan(f)
        if hits:
            total += len(hits)
            print("%-40s %2d spans" % (m, len(hits)))
            seen = set()
            for pno, ov, txt in hits:
                key = (pno, txt[:25])
                if key in seen:
                    continue
                seen.add(key)
                print("    p%-4d +%-5.1f %s" % (pno, ov, txt))
    for pat in pdfs:
        for f in sorted(glob.glob(pat)):
            hits = scan(f)
            if hits:
                total += len(hits)
                print("%-40s %2d spans" % (f, len(hits)))
                seen = set()
                for pno, ov, txt in hits:
                    key = (pno, txt[:25])
                    if key in seen:
                        continue
                    seen.add(key)
                    print("    p%-4d +%-5.1f %s" % (pno, ov, txt))
    print("TOTAL %d overflowing spans" % total)
