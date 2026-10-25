import glob, os, re
import pymupdf

def norm(t):
    return re.sub(r"\s+", " ", t).strip()

base = r"E:\phys\_t\txtcmp"
diff = 0
for pdf in sorted(glob.glob(r"E:\phys\papers\*\main.pdf")):
    pid = os.path.basename(os.path.dirname(pdf))
    old = open(os.path.join(base, pid + ".txt"), encoding="utf-8").read()
    doc = pymupdf.open(pdf)
    new = "\n\f\n".join(p.get_text() for p in doc)
    if norm(old) != norm(new):
        diff += 1
        # first difference
        a, b = norm(old), norm(new)
        i = 0
        while i < min(len(a), len(b)) and a[i] == b[i]:
            i += 1
        print("DIFF", pid)
        print("  old:", a[max(0,i-50):i+80])
        print("  new:", b[max(0,i-50):i+80])
print("diff papers", diff)
