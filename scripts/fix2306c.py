# -*- coding: utf-8 -*-
import io, os, shutil

d = r"E:\phys\papers\2306.03903"
p = os.path.join(d, "main.typ")
bak = os.path.join(d, "_work", "main.pre_mathfix3.typ")
if not os.path.exists(bak):
    shutil.copy(p, bak)

s = io.open(p, encoding="utf-8").read()

old_clust = r"""$ R_(upright(c l u s t)) & = frac(2 pi thin delta^(upright(l o c a l)) thin Omega_(upright(M))^2 thin rho_(upright(c)) thin G, c) (frac(85 thin pi, 6 sqrt(2)))^(#h(-1em) 2 / 7) #h(-1em) (frac(c, sqrt(2) thin v_(upright(v i r))))^(#h(-1em) 11 / 7) #h(-1em) upright(y) r^(- 1) thin G p c^(- 3) thin . $"""
new_clust = r"""$
  R_("clust") = (2 pi thin delta^("local") thin Omega_"M"^2 thin rho_"c" thin G)/c ( (85 thin pi)/(6 sqrt(2)) )^(2/7) ( c/(sqrt(2) thin v_"vir") )^(11/7) "yr"^(-1) "Gpc"^(-3).
$"""
assert s.count(old_clust) == 1
s = s.replace(old_clust, new_clust)

old_cite = "era#text([])&A....37..225M but grow"
assert s.count(old_cite) == 1
s = s.replace(old_cite, "era~@1974AandA....37..225M but grow")

io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
