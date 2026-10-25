import sys, glob
from collections import Counter
import pymupdf

def cols(page):
    d = page.get_text("dict")
    xs = []
    for b in d["blocks"]:
        if b.get("type") != 0: continue
        for l in b["lines"]:
            for s in l["spans"]:
                if s["text"].strip():
                    xs.append(s["bbox"][0])
    if not xs: return None
    w = page.rect.width
    left = min(xs)
    rights = [x for x in xs if x > w * 0.42]
    if not rights: return (left, None)
    c = Counter(round(x) for x in rights)
    right = c.most_common(1)[0][0]
    if right - left < w * 0.25: return (left, None)
    return (left, right)

def scan(path, pad=8.0):
    doc = pymupdf.open(path)
    hits = []
    for pno, page in enumerate(doc, 1):
        w = page.rect.width
        c = cols(page)
        if not c: continue
        left, right = c
        d = page.get_text("dict")
        for b in d["blocks"]:
            if b.get("type") != 0: continue
            for l in b["lines"]:
                for s in l["spans"]:
                    x0, y0, x1, y1 = s["bbox"]
                    t = s["text"].strip()
                    if not t: continue
                    bad = None
                    if x1 > w - pad or x0 < pad:
                        bad = "page"
                    elif right and x0 < right - 30 and x1 > right - 2:
                        bad = "gutter"
                    if bad:
                        hits.append((pno, bad, round(x0,1), round(x1,1), right, t[:80]))
    return hits

targets = sys.argv[1:] or sorted(glob.glob("papers/*/main.pdf"))
for p in targets:
    h = scan(p)
    if h:
        print("==", p, len(h))
        for r in h[:25]:
            print("  p%d %s x0=%.1f x1=%.1f R=%s | %s" % r)
