# -*- coding: utf-8 -*-
"""Per-page fill of our build vs the paper's own compiled PDF.

For each papers/<id>/main.pdf (source) and build/ov.pdf (our current source compiled by
pageoverflow.py), report the page count delta and any page whose text bottom differs by more
than TOL points. Because a one-page float shift makes every later page look wrong, the
comparison picks the best global alignment in [-3, 3] first and reports that offset. Both
counts exclude blocks below y=780 (page numbers / captions that bleed into the bottom margin).
"""
import os, sys
import pymupdf

TOL = 60
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def bottoms(path):
    d = pymupdf.open(path)
    out = []
    for p in d:
        out.append(max((b[3] for b in p.get_text("blocks") if b[1] < 780), default=0))
    return out


def align(a, b):
    best = None
    for off in range(-3, 4):
        pairs = []
        for i, x in enumerate(a):
            j = i + off
            if 0 <= j < len(b):
                pairs.append((i + 1, j + 1, x, b[j]))
        if not pairs:
            continue
        bad = [p for p in pairs if abs(p[2] - p[3]) > TOL]
        score = (len(bad), sum(abs(p[2] - p[3]) for p in pairs) / len(pairs), abs(off))
        if best is None or score < best[0]:
            best = (score, off, bad)
    return best


def run(pid):
    d = os.path.join(ROOT, "papers", pid)
    src = os.path.join(d, "main.pdf")
    ours = os.path.join(d, "build", "ov.pdf")
    if not (os.path.exists(src) and os.path.exists(ours)):
        return None
    a, b = bottoms(src), bottoms(ours)
    r = align(a, b)
    if r is None:
        return len(a), len(b), [], 0
    (_, _, _), off, badpairs = r
    return len(a), len(b), badpairs, off


def main():
    pids = sys.argv[1:] or sorted(os.listdir(os.path.join(ROOT, "papers")))
    total = 0
    for pid in pids:
        r = run(os.path.basename(pid))
        if r is None:
            continue
        ns, no, bad, off = r
        total += len(bad)
        flag = "  %d pages differ" % len(bad) if bad else ""
        offt = "  (page offset %+d)" % off if off else ""
        print("%-12s src=%-3d ours=%-3d%s%s" % (pid, ns, no, offt, flag))
        for p, q, x, y in bad[:6]:
            print("    src p%-3d %.0f  ours p%-3d %.0f" % (p, x, q, y))
    print("pages differing by >%dpt: %d" % (TOL, total))


if __name__ == "__main__":
    main()
