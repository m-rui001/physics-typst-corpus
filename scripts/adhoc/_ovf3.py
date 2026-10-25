import sys
from collections import Counter
import pymupdf

def edges(page):
    d = page.get_text("dict")
    w = page.rect.width
    mid = w / 2
    lefts = Counter(); rights = Counter()
    for b in d["blocks"]:
        if b.get("type") != 0: continue
        for l in b["lines"]:
            for s in l["spans"]:
                if not s["text"].strip(): continue
                x0, x1 = s["bbox"][0], s["bbox"][2]
                if x0 < mid - 20 and x1 < mid + 30:
                    rights[round(x1)] += 1
                if x0 > mid - 30 and x1 > mid:
                    lefts[round(x0)] += 1
    if not rights or not lefts: return None
    return rights.most_common(1)[0][0], lefts.most_common(1)[0][0]

def scan(path, pages=None):
    doc = pymupdf.open(path)
    w = doc[0].rect.width
    for pno, page in enumerate(doc, 1):
        if pages and pno not in pages: continue
        e = edges(page)
        if not e: continue
        c1, c2 = e
        out = []
        for b in page.get_text("dict")["blocks"]:
            if b.get("type") != 0: continue
            for l in b["lines"]:
                for s in l["spans"]:
                    t = s["text"].strip()
                    if not t: continue
                    x0, y0, x1, y1 = s["bbox"]
                    if x0 < 30: continue
                    if x1 > c1 + 3 and x1 < c2 - 5:
                        out.append((round(x0), round(x1), t[:70]))
                    elif x1 > w - 20:
                        out.append((round(x0), round(x1), "PAGE:" + t[:60]))
        if out:
            print("== p%d c1=%d c2=%d" % (pno, c1, c2))
            for o in out[:15]: print("   ", o)

args = sys.argv[1:]
path = args[0]
pages = set(int(x) for x in args[1:]) if len(args) > 1 else None
scan(path, pages)
