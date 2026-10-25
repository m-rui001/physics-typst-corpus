import re
from collections import Counter
tex = open(r"E:\phys\papers\2203.02139\src\DoubleBeta.tex", encoding="utf-8", errors="replace").read().split("\n")
typ = open(r"E:\phys\papers\2203.02139\main.typ", encoding="utf-8").read().split("\n")
pairs = [(111, 303), (116, 309), (118, 311)]
for ti, xi in pairs:
    t = typ[ti-1]
    keys = []
    for m in re.finditer(r"\\cite\{([^}]*)\}", tex[xi-1]):
        keys += [k.strip() for k in m.group(1).split(",")]
    refs = re.findall(r"@([A-Za-z][\w:.\-]*)", t)
    ck, cr = Counter(keys), Counter(refs)
    print("typ line", ti, "\n  missing:", list((ck - cr).elements()), "\n  extra:", list((cr - ck).elements()))
    # show neighborhood of holes
    for m in re.finditer(r"#text\(\[\]\)", t):
        print("   hole ctx:", t[max(0, m.start()-60):m.start()+10].replace("\n", " ")[-70:])
