import re, sys
s = open(r"E:\phys\papers\2203.02139\src\DoubleBeta.tex", encoding="utf-8", errors="replace").read()
lines = s.split("\n")
for i in (234, 236, 240, 303, 309, 311):
    l = lines[i-1]
    print(i, [m.group(1) for m in re.finditer(r"\\cite\{([^}]*)\}", l)])
