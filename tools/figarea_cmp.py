# -*- coding: utf-8 -*-
"""Compare total placed-image area per paper: source PDF vs our build."""
import os, sys
import pymupdf

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def imgarea(path):
    d = pymupdf.open(path)
    a = 0.0
    n = 0
    for p in d:
        for info in p.get_image_info():
            b = info["bbox"]
            a += max(0, b[2] - b[0]) * max(0, b[3] - b[1])
            n += 1
    return a, n, len(d)


def main():
    pids = sys.argv[1:] or sorted(os.listdir(os.path.join(ROOT, "papers")))
    for pid in pids:
        pid = os.path.basename(pid)
        sp = os.path.join(ROOT, "papers", pid, "main.pdf")
        op = os.path.join(ROOT, "papers", pid, "build", "ov.pdf")
        if not (os.path.exists(sp) and os.path.exists(op)):
            continue
        a = imgarea(sp)
        b = imgarea(op)
        if a[0] == 0 and b[0] == 0:
            continue
        ratio = b[0] / a[0] if a[0] else float("inf")
        flag = "  <-- AREA DIFF" if not (0.85 <= ratio <= 1.18) else ""
        print("%-12s src %3d imgs %9.0f  ours %3d imgs %9.0f  ratio %.2f%s"
              % (pid, a[1], a[0], b[1], b[0], ratio, flag))


if __name__ == "__main__":
    main()
