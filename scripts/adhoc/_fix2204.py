import os
BS = chr(92)
DBL = BS + BS
NL = chr(10)
p = "papers/2204.12771/main.typ"
s0 = open(p, encoding="utf-8").read()
L = s0.split(NL)
i = next(k for k, ln in enumerate(L) if ln.startswith("    A " + DBL + "( frac(E, 100 thin"))
assert "cases(" in L[i-1]
assert L[i+2].startswith("  )" + BS + "$ respectively, where"), L[i+2][:60]
head = L[i-1]
cut = head.index(BS + "$N")
prefix = head[:cut]
suffix = L[i+2][len("  )" + BS + "$"):]
new = [
    prefix + "$ N (E) = cases(",
    '  A (E \\/ (100 "keV"))^alpha exp(-E \\/ E_c), & E < (alpha - beta) E_c,',
    '  A ((alpha - beta) E_c \\/ (100 "keV"))^(alpha - beta) exp(beta - alpha) (E \\/ (100 "keV"))^beta, & E >= (alpha - beta) E_c,',
    ") $" + suffix,
]
L = L[:i-1] + new + L[i+3:]
s = NL.join(L)
assert s.count(DBL) == 0, "leftovers %d" % s.count(DBL)
open(p, "w", encoding="utf-8").write(s)
print("lines", len(L), "orig", len(s0.split(NL)))
