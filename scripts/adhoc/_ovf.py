import sys, fitz, glob, os

def scan(path, pad=8.0):
    doc = fitz.open(path)
    hits = []
    for pno, page in enumerate(doc, 1):
        w = page.rect.width
        d = page.get_text("dict")
        for b in d["blocks"]:
            if b.get("type") != 0:
                continue
            for l in b["lines"]:
                for s in l["spans"]:
                    x0, y0, x1, y1 = s["bbox"]
                    if x1 > w - pad or x0 < pad:
                        t = s["text"].strip()
                        if t:
                            hits.append((pno, round(x0, 1), round(x1, 1), w, t[:90]))
    return hits

targets = sys.argv[1:] or sorted(glob.glob("papers/*/main.pdf"))
for p in targets:
    if p.endswith(".typ"):
        p = p[:-4] + ".pdf"
    h = scan(p)
    if h:
        print("==", p, len(h))
        for r in h[:40]:
            print("  p%d x0=%.1f x1=%.1f w=%.0f | %s" % r)
