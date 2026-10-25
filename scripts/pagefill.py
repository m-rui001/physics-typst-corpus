import glob, sys
import pymupdf

def content_bbox(page):
    xs0, ys0, xs1, ys1 = [], [], [], []
    d = page.get_text('dict')
    for b in d['blocks']:
        if b.get('type') == 0:
            for l in b['lines']:
                for s in l['spans']:
                    if s['text'].strip():
                        x0, y0, x1, y1 = s['bbox']
                        xs0.append(x0); ys0.append(y0); xs1.append(x1); ys1.append(y1)
    for info in page.get_image_info():
        x0, y0, x1, y1 = info['bbox']
        xs0.append(x0); ys0.append(y0); xs1.append(x1); ys1.append(y1)
    if not xs0:
        return None
    return min(xs0), min(ys0), max(xs1), max(ys1)

rows = []
for pdf in sorted(glob.glob('papers/*/main.pdf')):
    doc = pymupdf.open(pdf)
    n = doc.page_count
    for i, page in enumerate(doc, 1):
        r = page.rect
        bb = content_bbox(page)
        if not bb:
            rows.append((1.0, 0, i, n, pdf, 0, 0))
            continue
        x0, y0, x1, y1 = bb
        tail = (r.height - y1) / r.height
        head = y0 / r.height
        left = x0 / r.width
        right = (r.width - x1) / r.width
        rows.append((tail, head, i, n, pdf, left, right, y1 / r.height))
    doc.close()

print('== bottom whitespace > 0.30 (non-final pages)')
cnt = 0
for tail, head, p, n, pdf, left, right, ym in sorted(rows, reverse=True):
    if p == n:
        continue
    if tail > 0.30:
        print('tail=%.2f head=%.2f L=%.2f R=%.2f p=%d/%d %s' % (tail, head, left, right, p, n, pdf))
        cnt += 1
print('count', cnt)
print('== text/images near/over bottom edge (ymax>0.96)')
cnt = 0
for r in sorted(rows, key=lambda r: -r[-1]):
    tail, head, p, n, pdf, left, right, ym = r
    if ym > 0.96 and p != n:
        print('ymax=%.3f p=%d/%d %s' % (ym, p, n, pdf))
        cnt += 1
print('count', cnt)
