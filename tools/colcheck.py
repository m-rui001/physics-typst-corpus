# -*- coding: utf-8 -*-
"""Detect column-model mismatch: source vs our build, by span x0 clustering."""
import os, sys
import pymupdf

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def sig(path):
    d = pymupdf.open(path)
    n2 = 0
    n1 = 0
    for p in d:
        w = p.rect.width
        for b in p.get_text("dict")["blocks"]:
            for l in b.get("lines", []):
                for s in l["spans"]:
                    if len(s["text"].strip()) < 25:
                        continue
                    x = s["bbox"][0]
                    if 0.45 * w < x < 0.55 * w:
                        n2 += 1
                    elif x > 0.55 * w:
                        n2 += 1
                    elif x < 0.45 * w:
                        n1 += 1
    return n1, n2


def main():
    pids = sys.argv[1:] or sorted(os.listdir(os.path.join(ROOT, "papers")))
    for pid in pids:
        pid = os.path.basename(pid)
        sp = os.path.join(ROOT, "papers", pid, "main.pdf")
        op = os.path.join(ROOT, "papers", pid, "build", "ov.pdf")
        if not (os.path.exists(sp) and os.path.exists(op)):
            continue
        a = sig(sp)
        b = sig(op)
        ca = 2 if a[1] > 0.15 * (a[0] + a[1]) else 1
        cb = 2 if b[1] > 0.15 * (b[0] + b[1]) else 1
        mark = "  <-- MISMATCH" if ca != cb else ""
        print("%-12s src %d cols (%d/%d)  ours %d cols (%d/%d)%s" % (pid, ca, a[0], a[1], cb, b[0], b[1], mark))


if __name__ == "__main__":
    main()
