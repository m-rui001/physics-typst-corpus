"""Equation-number collisions: a display wider than its column makes Typst draw the "(N)"
over the formula instead of beside it. Detect by comparing span boxes on the same baseline.
"""
import glob, os, re, sys
import pymupdf

NUM = re.compile(r'\((?:\d+|[A-Z]\d+)\)$')

def spans_of(page):
    out = []
    for b in page.get_text('dict')['blocks']:
        if b['type'] != 0:
            continue
        for l in b['lines']:
            for s in l['spans']:
                if s['text'].strip():
                    out.append((pymupdf.Rect(s['bbox']), s['text']))
    return out

def scan(pdf):
    doc = pymupdf.open(pdf)
    hits = []
    for i, pg in enumerate(doc):
        sp = spans_of(pg)
        for r, t in sp:
            if not NUM.search(t) or r.width > 40:
                continue
            for r2, t2 in sp:
                if r2 is r or r2 == r:
                    continue
                vy = min(r.y1, r2.y1) - max(r.y0, r2.y0)
                vx = min(r.x1, r2.x1) - max(r.x0, r2.x0)
                if vy > 0.6 * min(r.height, r2.height) and vx > 2 and t2.strip() != t:
                    hits.append((i + 1, t, round(vx, 1), t2.strip()[:24]))
                    break
    return hits

if __name__ == '__main__':
    rows = []
    for p in sorted(glob.glob('papers/*/build/main.pdf')):
        pid = p.split(os.sep)[1]
        h = scan(p)
        if h:
            rows.append((pid, h))
    for pid, h in rows:
        print('%-12s %2d collisions  %s' % (pid, len(h),
              ' | '.join('p%d %s +%.1fpt over %s' % x for x in h[:6])))
    print('\n%d papers' % len(rows))
