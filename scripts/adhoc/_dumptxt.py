import glob, os
import pymupdf
out = r"E:\phys\_t\txtcmp"
os.makedirs(out, exist_ok=True)
for pdf in sorted(glob.glob(r"E:\phys\papers\*\main.pdf")):
    pid = os.path.basename(os.path.dirname(pdf))
    doc = pymupdf.open(pdf)
    parts = []
    for p in doc:
        parts.append(p.get_text())
    open(os.path.join(out, pid + ".txt"), "w", encoding="utf-8").write("\n\f\n".join(parts))
print("dumped", len(glob.glob(os.path.join(out, "*.txt"))))
