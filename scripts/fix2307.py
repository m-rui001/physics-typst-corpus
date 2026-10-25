# -*- coding: utf-8 -*-
p = r"E:\phys\papers\2307.16873\main.typ"
s = open(p, encoding="utf-8").read()

a = s.index(r"\$F(r)")
b = s.index(r"\rangle\$", a) + len(r"\rangle\$")
s = s[:a] + r"$F(r) = 1/2 sum_mu chevron.l bold(S)^c_(i,mu) dot.c bold(S)^c_(j,mu) chevron.r$" + s[b:]

a = s.index(r"\$F^{(1)}")
b = s.index(" in @Fig4(d),(e)", a)
s = s[:a] + r"$F^((1)) = 2/N sum_i chevron.l bold(S)_(i, mu=1) dot.c bold(S)_(i, mu=-1) chevron.r_beta$" + s[b:]

s = s.replace(r"$F^(\( 1 \))$", r"$F^((1))$")
open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
