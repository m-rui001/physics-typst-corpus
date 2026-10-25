import re, shutil
p = "papers/2410.05380/main.typ"
shutil.copy(p, p + ".pretablemath")
s = open(p, encoding="utf-8").read()
orig = s

repl = [
    (r"[\rule0pt4mm\ignorespaces]", "[]"),
    (r"[\theta_12/^\circ]", r"[$theta_12 / degree$]"),
    (r"[\theta_23/^\circ]", r"[$theta_23 / degree$]"),
    (r"[\theta_13/^\circ]", r"[$theta_13 / degree$]"),
    (r"[\delta_CP/^\circ]", r"[$delta_CP / degree$]"),
    (r"[\dfrac\Delta m^2_2110^-5~\eVq]",
     r'[$frac(Delta m_21^2, 10^(-5) "eV"^2)$]'),
    (r"[\dfrac\Delta m^2_3\ell10^-3~\eVq]",
     r'[$frac(Delta m_(3 ell)^2, 10^(-3) "eV"^2)$]'),
    ("[11*IC24 with SK atmospheric data]", "[IC24 with SK atmospheric data]"),
    (r"IceCube~\reciteIceCube:2019dqi", "IceCube~#cite(<IceCube:2019dqi>)"),
]
counts = {}
for old, new in repl:
    n = s.count(old)
    counts[old] = n
    s = s.replace(old, new)
open(p, "w", encoding="utf-8", newline="\n").write(s)
for k, v in counts.items():
    print(v, k[:60])
print("changed", s != orig)
