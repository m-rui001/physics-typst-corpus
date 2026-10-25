import sys

sys.stdout.reconfigure(encoding="utf-8")
import pymupdf

BS = chr(92)
doc = pymupdf.open("papers/2105.06980/main.pdf")
print("pages", len(doc))
hits = []
for pno in range(len(doc)):
    t = doc[pno].get_text()
    if BS in t:
        hits.append(pno + 1)
print("pages with backslash:", hits)
for pno in range(28, min(len(doc), 34)):
    t = doc[pno].get_text()
    print("---- page", pno + 1, "----")
    print(t[:1200])
