import os, pymupdf
OUT = r"E:\phys\_t\rcheck"
jobs = {
    "2112.03708": [5, 6],
    "2212.13969": [3],
    "2308.07915": [7],
}
for pid, pages in jobs.items():
    doc = pymupdf.open(r"E:\phys\papers\%s\main.pdf" % pid)
    for p in pages:
        pix = doc[p-1].get_pixmap(matrix=pymupdf.Matrix(2, 2))
        out = os.path.join(OUT, "fix3_%s_p%d.png" % (pid, p))
        pix.save(out)
        print("saved", out)
