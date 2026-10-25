import glob, os
import pymupdf

TOKENS = [r"\mathrm", r"\frac", r"\left", r"\right", r"\hat", r"\sigma", r"\alpha",
          r"\begin{", r"\end{", r"\cite", r"\ref{", r"\eqref", r"\label{",
          r"\text", r"\mathbb", r"\mathbf", r"\tilde", r"\overline",
          "#text([])", "{[}", "]}", "\\_", "�"]
for pdf in sorted(glob.glob(r"E:\phys\papers\*\main.pdf")):
    pid = os.path.basename(os.path.dirname(pdf))
    doc = pymupdf.open(pdf)
    hits = []
    for pno in range(len(doc)):
        t = doc[pno].get_text()
        for tok in TOKENS:
            i = t.find(tok)
            if i >= 0:
                hits.append((tok, pno+1, t[max(0,i-40):i+40].replace("\n"," ")))
    if hits:
        print("==", pid, len(hits))
        for tok, pno, ctx in hits[:6]:
            print("  %-10s p%d %s" % (tok, pno, ctx))
