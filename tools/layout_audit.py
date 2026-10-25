import os, sys, glob
import pymupdf

ROOT = r"E:\phys\papers"

def page_content_bottom(page):
    h = page.rect.height
    ymax = 0.0
    for b in page.get_text("blocks"):
        text = b[4].strip()
        if b[1] > 0.93 * h and text.isdigit():
            continue
        if text:
            ymax = max(ymax, b[3])
    for img in page.get_images(full=True):
        try:
            for r in page.get_image_rects(img[0]):
                ymax = max(ymax, r.y1)
        except Exception:
            pass
    for d in page.get_drawings():
        ymax = max(ymax, d["rect"].y1)
    return ymax, h

rows = []
for pdir in sorted(glob.glob(os.path.join(ROOT, "*"))):
    pdf = os.path.join(pdir, "build", "main.pdf")
    if not os.path.isfile(pdf):
        continue
    try:
        doc = pymupdf.open(pdf)
    except Exception as e:
        rows.append((os.path.basename(pdir), "OPEN_FAIL", str(e)))
        continue
    n = len(doc)
    gaps = []
    for i, page in enumerate(doc):
        ymax, h = page_content_bottom(page)
        gap = (h - ymax) / h
        gaps.append((i + 1, gap))
    # ignore the last two pages (references often end mid-page)
    body = [g for g in gaps if g[0] <= n - 2]
    if not body:
        body = gaps
    worst = max(body, key=lambda g: g[1])
    big = [g for g in body if g[1] > 0.18]
    rows.append((os.path.basename(pdir), n, worst[0], round(worst[1] * 100, 1), len(big),
                 [f"p{g[0]}:{round(g[1]*100)}" for g in big][:8]))
    doc.close()

print(f"{'paper':<13}{'pp':>4}{'worst':>7}{'gap%':>6}{'n>18%':>6}  pages")
for r in sorted(rows, key=lambda x: -(x[3] if isinstance(x[3], float) else 0)):
    if len(r) == 3:
        print(r)
    else:
        print(f"{r[0]:<13}{r[1]:>4}{r[2]:>7}{r[3]:>6}{r[4]:>6}  {' '.join(r[5])}")
