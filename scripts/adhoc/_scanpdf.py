import glob
import sys

sys.stdout.reconfigure(encoding="utf-8")
import pymupdf

BS = chr(92)
for p in sorted(glob.glob("papers/*/main.pdf")):
    doc = pymupdf.open(p)
    pages = []
    qm = 0
    for i, page in enumerate(doc):
        t = page.get_text().replace("b " + BS + " a", "")
        if BS in t:
            pages.append(i + 1)
        qm += t.count("??")
    if pages or qm:
        print(p, "bs_pages", pages[:10], "n", len(pages), "??", qm)
    doc.close()
print("done")
