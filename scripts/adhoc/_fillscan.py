import glob
import sys

sys.stdout.reconfigure(encoding="utf-8")
import pymupdf

for pdf in sorted(glob.glob(r"E:\phys\papers\*\main.pdf")):
    pid = pdf.split("\\")[-2]
    doc = pymupdf.open(pdf)
    n = doc.page_count
    hits = []
    for i, page in enumerate(doc):
        if i == n - 1:
            continue
        H = page.rect.height
        y1 = 0
        for b in page.get_text("blocks"):
            if b[3] < H - 20:
                y1 = max(y1, b[3])
        for d in page.get_drawings():
            r = d["rect"]
            if r.y1 < H - 20:
                y1 = max(y1, r.y1)
        for img in page.get_image_info():
            r = pymupdf.Rect(img["bbox"])
            if r.y1 < H - 20:
                y1 = max(y1, r.y1)
        blank = (H - 40) - y1
        if blank > 0.30 * H:
            hits.append((i + 1, round(blank)))
    if hits:
        print(pid, "n=%d" % n, hits[:8], "total", len(hits))
    doc.close()
print("done")
