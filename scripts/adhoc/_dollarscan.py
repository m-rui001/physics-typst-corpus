import glob, os, sys
import pymupdf

for pdf in sorted(glob.glob(r"E:\phys\papers\*\main.pdf")):
    pid = os.path.basename(os.path.dirname(pdf))
    try:
        doc = pymupdf.open(pdf)
    except Exception as e:
        print("ERR", pid, e); continue
    hits = []
    for pno in range(len(doc)):
        t = doc[pno].get_text()
        for line in t.splitlines():
            if "$" in line:
                hits.append((pno+1, line.strip()[:140]))
    if hits:
        print("==", pid, len(hits))
        for pno, line in hits[:8]:
            print("  p%d %s" % (pno, line))
