# -*- coding: utf-8 -*-
import io, re, os, shutil

d = r"E:\phys\papers\2306.03903"
p = os.path.join(d, "main.typ")
bak = os.path.join(d, "_work", "main.pre_mathfix2.typ")
if not os.path.exists(bak):
    shutil.copy(p, bak)

s = io.open(p, encoding="utf-8").read()

if "#let eqnn" not in s:
    s = s.replace(
        "#set math.equation(numbering: \"(1)\", supplement: none)\n",
        "#set math.equation(numbering: \"(1)\", supplement: none)\n#let eqnn(body) = { set math.equation(numbering: none); body }\n",
        1,
    )

align_blocks = [
r"""#eqnn[$
  f_"sup" approx 2.3 times 10^(-3) f_"PBH"^(-0.65),
$]""",
r"""$
  f_"PBH" & lt.tilde (2 M H_0 Phi_"res")/(rho_"DM" Gamma_0 tilde(N)_gamma (m_chi)) \
  & approx cases(
    2 times 10^(-9) (m_chi / "TeV")^(1.1), & M gt.tilde M_*,
    1.1 times 10^(-12) (m_chi / "TeV")^(-5.0) (M / 10^(-10) thin M_⊙)^(-2), & M lt.tilde M_*,
  ),
$ <eq:egbound>""",
r"""$
  Delta K & = (1/gamma - 1) thin M_"H" = (1 - gamma)/(gamma^2) thin M,
$""",
]

eqnarray_blocks = [
r"""$
  R^"early" (m_1, m_2) & = 1.6 times 10^6 thin f_"sup" (m_1, m_2, z) thin f_"PBH"^(53/37) thin f(m_1) thin f(m_2) [ (t(z))/t_0 ]^(-34/37) \
  & quad times ( (m_1 + m_2)/M_⊙ )^(-32/37) [ (m_1 m_2)/((m_1 + m_2)^2) ]^(-34/37) "Gpc"^(-3) thin "yr"^(-1).
$ <eq:cosmomerg>""",
r"""$
  R^"late" (m_1, m_2) & = R_"clust" thin f_"PBH"^2 thin f(m_1) thin f(m_2) thin ((m_1 + m_2)^(10/7))/((m_1 m_2)^(5/7)) thin "yr"^(-1) "Gpc"^(-3),
$ <eq:ratescatpure2>""",
]

def replace_all_blocks(s, env, blocks):
    pat = re.compile(r"\\\$\\\$\\\\begin\{" + env + r"\}.*?\\\\end\{" + env + r"\}\\\$\\\$", re.S)
    n = len(pat.findall(s))
    assert n == len(blocks), (env, n)
    for b in blocks:
        s = pat.sub(lambda m, b=b: b, s, count=1)
    return s

s = replace_all_blocks(s, "align", align_blocks)
s = replace_all_blocks(s, "eqnarray", eqnarray_blocks)

s, n1 = re.subn(r"#link\(<eq:([A-Za-z0-9-]+)>\)\[\\\[eq:\1\\\]\]", r"(#ref(<eq:\1>))", s)
assert n1 == 2, n1
s, n2 = re.subn(r"Eq\.~\[\\\[eq:([A-Za-z0-9-]+)\\\]\]", r"Eq. (#ref(<eq:\1>))", s)
assert n2 == 6, n2

io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
