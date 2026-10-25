import os
import pymupdf

OUT = r"E:\phys\_t\rcheck"
os.makedirs(OUT, exist_ok=True)

jobs = [
    ("2112.03708", ["state preservation", "logical coherence time"], [5, 6]),
    ("2212.13969", ["recover the solution to the heat"], [3]),
    ("2306.03903", ["important difference between the two effects", "Poisson fluctuation scales"], [5, 6]),
    ("2308.07915", ["Hamming weight of a vector"], []),
    ("2207.06431", ["qubit labels such as"], [37]),
    ("2104.11260", [], [1]),
    ("2111.14241", [], [71, 74]),
    ("2104.04119", ["dimer covering sector"], []),
]

for pid, needles, pages in jobs:
    pdf = r"E:\phys\papers\%s\main.pdf" % pid
    doc = pymupdf.open(pdf)
    found = []
    for nd in needles:
        for i in range(len(doc)):
            if nd in doc[i].get_text():
                found.append((nd, i+1))
                break
    todo = sorted(set(pages) | {p for _, p in found})
    print(pid, "pages", todo)
    for p in todo:
        pix = doc[p-1].get_pixmap(matrix=pymupdf.Matrix(2, 2))
        out = os.path.join(OUT, "fix2_%s_p%d.png" % (pid, p))
        pix.save(out)
        print("  saved", out)
