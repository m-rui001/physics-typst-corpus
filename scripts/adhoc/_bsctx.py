import sys

sys.stdout.reconfigure(encoding="utf-8")
import pymupdf

BS = chr(92)
targets = {
    "papers/2102.01111/main.pdf": [52],
    "papers/2104.07036/main.pdf": [23],
    "papers/2111.14241/main.pdf": [29, 62],
    "papers/2112.03708/main.pdf": [24],
    "papers/2202.02773/main.pdf": [63],
    "papers/2204.12771/main.pdf": [8],
    "papers/2207.06431/main.pdf": [37, 40],
    "papers/2301.10937/main.pdf": [1],
    "papers/2306.16227/main.pdf": [27],
}
for p, pages in targets.items():
    doc = pymupdf.open(p)
    for pno in pages:
        t = doc[pno - 1].get_text()
        i = t.find(BS)
        print("==", p, pno, repr(t[max(0, i - 80):i + 80]))
    doc.close()
