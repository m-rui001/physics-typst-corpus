# -*- coding: utf-8 -*-
import io, re, shutil, os

d = r"E:\phys\papers\2306.03903"
p = os.path.join(d, "main.typ")
bak = os.path.join(d, "_work", "main.pre_mathfix.typ")
os.makedirs(os.path.join(d, "_work"), exist_ok=True)
if not os.path.exists(bak):
    shutil.copy(p, bak)

s = io.open(p, encoding="utf-8").read()

new_eqs = [
r"""$
  P_"Poisson" = 2 times 10^(-3) thin (f_"PBH")/(g(z)^2) (m/(3 thin M_odot)) thin "Mpc"^3,
$""",
r"""$
  z_c + 1 = 3.7 times 10^(-3) k^(-3/2) ( (m f_"PBH")/M_odot )^(-1/2) = 39 times [ (10^6 m f_"PBH")/M_c ]^(1/2)
$""",
r"""$
  r_c = 135 thin "pc" ( (m f_"PBH")/M_odot )^(-1/2) (M_c/(10^6 thin M_odot))^(5/6) .
$ <eq:rM>""",
]

pat = re.compile(r"\\\$\\\$\\\\begin\{equation\}.*?\\\\end\{equation\}\\\$\\\$", re.S)
hits = pat.findall(s)
assert len(hits) == 3, len(hits)
for blk in new_eqs:
    s = pat.sub(lambda m: blk, s, count=1)

# visible raw-label links -> real refs
s, n1 = re.subn(r"#link\(<eq:([A-Za-z0-9]+)>\)\[\\\[eq:\1\\\]\]", r"(#ref(<eq:\1>))", s)
assert n1 == 25, n1

# orphan bracket ref
s2, n2 = re.subn(r"Eqs\.~\[\\\[eq:rM\\\]\]", "Eqs. (#ref(<eq:rM>))", s)
assert n2 == 1, n2
s = s2

# flattened Press-Schechter displays
old = r"""is given by $ F_(upright(c)) ( M_(upright(c)) , thin z_(upright(c)) ) = upright(e r f c) #h(-1em) [frac(delta_(upright(c)), sqrt(2) thin sigma ( M_(upright(c)) , z_(upright(c)) ))] , $ where $ sigma^2 ( M_(upright(c)) , z_(upright(c)) ) = integral #h(-1em) upright(d) ln k #h(0em) frac(k^3, 2 pi^2) thin P ( k , z_(upright(c)) ) thin W ( k ) thin . $ Here $W ( k )$"""
new = r"""is given by
$ F_(upright(c)) ( M_(upright(c)), thin z_(upright(c)) ) = "erfc" [ (delta_(upright(c)))/(sqrt(2) thin sigma ( M_(upright(c)), z_(upright(c)) )) ], $
where
$ sigma^2 ( M_(upright(c)), z_(upright(c)) ) = integral (dif ln k) (k^3)/(2 pi^2) thin P ( k, z_(upright(c)) ) thin W ( k ). $
Here $W ( k )$"""
assert s.count(old) == 1
s = s.replace(old, new)

io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
