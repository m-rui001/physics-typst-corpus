"""Detect rendered-layout defects in built PDFs: colliding baselines, clipped text,
block overflow past the body edge.

Usage: python tools/pdf_defects.py "papers/*/build/main.pdf"
"""
import sys, glob
import pymupdf

COLLISION = 0.9   # baseline gap / font size below this = overlapping lines
OVERFLOW = 4.0    # pt allowed past the body-text right edge
BOTTOM = 18.0     # pt allowed below the page's bottom text edge


def check(path):
    doc = pymupdf.open(path)
    issues = []
    right_edges = []
    for pno, page in enumerate(doc, 1):
        width, height = page.rect.width, page.rect.height
        lines = []
        for blk in page.get_text("dict")["blocks"]:
            if blk["type"] != 0:
                continue
            for ln in blk["lines"]:
                text = "".join(s["text"] for s in ln["spans"]).strip()
                if not text:
                    continue
                main_span = max(ln["spans"], key=lambda s: len(s["text"]))
                lines.append((ln["bbox"], main_span["origin"][1],
                              main_span["size"], text))
        lines.sort(key=lambda z: (z[1], z[0][0]))
        for a, b in zip(lines, lines[1:]):
            (ax0, ay0, ax1, ay1), ab, asz, at = a
            (bx0, by0, bx1, by1), bb, bsz, bt = b
            gap = bb - ab
            if gap <= 0:
                continue
            if min(ax1, bx1) - max(ax0, bx0) < 20:
                continue
            if gap < 10.5 and gap / max(asz, bsz) < COLLISION:
                issues.append((pno, "collide", round(ab, 1), round(gap, 2),
                               at[:38], bt[:38]))
        body = [l for l in lines if l[0][0] > width * 0.08 and l[0][2] < width * 0.97]
        if body:
            right_edges.append(max(l[0][2] for l in body))
        for bbox, base, size, text in lines:
            if bbox[3] > height - BOTTOM:
                issues.append((pno, "clip", round(bbox[1], 1), round(bbox[3], 1),
                               text[:38]))
                break
    if right_edges:
        limit = max(right_edges)
        for pno, page in enumerate(doc, 1):
            for blk in page.get_text("dict")["blocks"]:
                if blk["type"] != 0:
                    continue
                x1 = blk["bbox"][2]
                if x1 > limit + OVERFLOW and x1 < page.rect.width - 10:
                    text = "".join(s["text"] for ln in blk["lines"] for s in ln["spans"])
                    issues.append((pno, "overflow", round(x1, 1), round(limit, 1),
                                   text[:38]))
    return len(doc), issues


def main():
    paths = []
    for a in sys.argv[1:]:
        paths.extend(glob.glob(a))
    for p in paths:
        try:
            n, issues = check(p)
        except Exception as e:
            print(f"{p}: ERROR {e}")
            continue
        print(f"{p}: {n} pages, {len(issues)} issues")
        for it in issues[:8]:
            print("   ", it)


main()
