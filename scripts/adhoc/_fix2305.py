import re, sys

P = r"E:\phys\papers\2305.18541\main.typ"
t = open(P, encoding="utf-8").read()
orig = t
BS = chr(92)
D = "$"
RAW_START = BS + D + BS + D + BS + BS + "begin{equation}"
RAW_END = BS + BS + "end{equation}" + BS + D + BS + D

blocks = [
# 1 eq:SRE_def
r"""$ M_n (rho) = 1/(1-n) log { sum_(P in cal(P)_N) (|"Tr" (rho P)|^(2n)) / d^N } $
<eq:SRE_def>""",
# 2 eq:Xi
r"""$ Xi_P = |"Tr" (rho P)|^2 \/ d^N . $
<eq:Xi>""",
# 3 eq:sre_mixed
r"""$ tilde(M)_2 = -log ( (sum_(P in cal(P)_N) |"Tr" (rho P)|^4) / (sum_(P in cal(P)_N) |"Tr" (rho P)|^2) ) , $
<eq:sre_mixed>""",
# 4 eq:Xi_Tilde
r"""$ tilde(Xi)_P = |"Tr" (rho P)|^2 \/ (sum_(P in cal(P)_N) |"Tr" (rho P)|^2) , $
<eq:Xi_Tilde>""",
# 5 eq:lr_magic
r"""$ L (rho_(A B)) = tilde(M)_2 (rho_(A B)) - tilde(M)_2 (rho_A) - tilde(M)_2 (rho_B) , $
<eq:lr_magic>""",
# 6 eq:estimator_n
r"""$ M_n = 1/(1-n) log angle.l |"Tr" (rho P)|^(2(n-1)) angle.r_(Xi_P) $
<eq:estimator_n>""",
# 7 eq:estimator_1
r"""$ M_1 = angle.l -log (|"Tr" (rho P)|^2) angle.r_(Xi_P) $
<eq:estimator_1>""",
# 8 eq:estimator_n<1 -> eq:estimator_nlt1
r"""$ M_n = -1/(1-n) log angle.l |"Tr" (rho P)|^(2(1-n)) angle.r_(Pi_(P,n)) $
<eq:estimator_nlt1>""",
# 9 W (label-less)
r"""$ W (rho_(A B)) = -log ( (sum_(P_A in cal(P)_A) |"Tr" (rho_A P_A)|^4 sum_(P in cal(P)_B) |"Tr" (rho_B P_B)|^4) / (sum_(P_(A B) in cal(P)_(A B)) |"Tr" (rho_(A B) P_(A B))|^4) ) $""",
# 10 eq:estimator_w
r"""$ W (rho_(A B)) = -log angle.l (|"Tr" (rho_A P_A)|^4 |"Tr" (rho_B P_B)|^4) / (|"Tr" (rho_(A B) P_(A B))|^4) angle.r_(Pi_(P_(A B))) , $
<eq:estimator_w>""",
# 11 eq:estimator_i2
r"""$ I_2 (rho_(A B)) = -log angle.l (|"Tr" (rho_A P_A)|^2 |"Tr" (rho_B P_B)|^2) / (|"Tr" (rho_(A B) P_(A B))|^2) angle.r_(Xi_(P_(A B))) . $
<eq:estimator_i2>""",
# 12 eq:subleading
r"""$ c_N = log angle.l (|"Tr" (rho_(N/2) P^((1)))|^(2n) |"Tr" (rho_(N/2) P^((2)))|^(2n)) / (|"Tr" (rho_N P)|^(2n)) angle.r_(Pi_(P,n)) $
<eq:subleading>""",
]

# substitute raw equation blocks sequentially
out = []
i = 0
k = 0
while True:
    a = t.find(RAW_START, i)
    if a < 0:
        out.append(t[i:])
        break
    b = t.find(RAW_END, a)
    if b < 0:
        print("UNMATCHED RAW START at", a)
        sys.exit(1)
    out.append(t[i:a])
    out.append(blocks[k])
    k += 1
    i = b + len(RAW_END)
t = "".join(out)
assert k == len(blocks), f"expected {len(blocks)} blocks, found {k}"

# ---- refs ----
t = re.sub(r"#link\(<([^>]+)>\)\[\\\[(.+?)\\\]\]", r"@\1", t)
t = re.sub(r"\[\\\[(.+?)\\\]\]", lambda m: "@" + m.group(1).replace("\\_", "_"), t)

# ---- variance block 1: eq:var ----
a = t.find('is given by $  & upright("Var")')
assert a > 0
a = t.find("$  &", a)
b = t.find("$<eq:var>", a) + 1
t = t[:a] + r"""$ "Var" (|"Tr" (rho P)|^(2(n-1))) &= angle.l |"Tr" (rho P)|^(4(n-1)) angle.r_(Xi_P) - angle.l |"Tr" (rho P)|^(2(n-1)) angle.r_(Xi_P)^2 \
&= exp[-2 (n-1) M_(2n-1)] - exp[-2 (n-1) M_n] . $""" + t[b:]

# variance block 2 (Var M_n, n>1)
a = t.find('we have $  & upright("Var") ( M_n )')
assert a > 0
a = t.find("$  &", a)
b = t.find("$ For $n < 1$,", a) + 1
t = t[:a] + r"""$ "Var" (M_n) &approx (exp[-2 (n-1) M_(2n-1)] - exp[-2 (n-1) M_n]) / (|n-1| exp[-2 (n-1) M_n]) \
&= (exp[2 (n-1) (M_n - M_(2n-1))] - 1) / (|n-1|) . $""" + t[b:]

# variance block 3 (Var, n<1) + label
a = t.find('For $n < 1$, $  & upright("Var")')
assert a > 0
a = t.find("$  &", a)
b = t.find("$ <eq:varn<1>", a)
assert b > 0
t = t[:a] + r"""$ "Var" (|"Tr" (rho P)|^(2(1-n))) &= angle.l |"Tr" (rho P)|^(4(1-n)) angle.r_(Pi_(P,n)) - angle.l |"Tr" (rho P)|^(2(1-n)) angle.r_(Pi_(P,n))^2 \
&= exp[(n-1)(M_(2-n) + M_n)] - exp[2 (n-1) M_n] . $""" + t[b + 1:]
t = t.replace("<eq:varn<1>", "<eq:varn1>")

# variance block 4 (Var M_n, n<1)
a = t.find('Then, $  & upright("Var") ( M_n )')
assert a > 0
a = t.find("$  &", a)
b = t.find("$ In both cases", a) + 1
t = t[:a] + r"""$ "Var" (M_n) &approx (exp[(n-1)(M_(2-n) + M_n)] - exp[2 (n-1) M_n]) / (|n-1| exp[2 (n-1) M_n]) \
&= (exp[(1-n)(M_n - M_(2-n))] - 1) / (|n-1|) . $""" + t[b:]

# line 243: relation and inline formula -> block equation
a = t.find("Using the relation#text([])")
assert a > 0
b = t.find(" we see that", a)
t = t[:a] + r"""Using the relation @deboer2019:
$ "Var" (M_1) = (dif^2 [(1-alpha) M_alpha]) / (dif alpha^2) bar.v|_(alpha = 1) , $""" + t[b:]

# duality transformation block (eq:ising_var)
a = t.find("is defined with the following transformation, $  & sigma_i^x")
assert a > 0
a = t.find("$  &", a)
b = t.find("$<eq:ising_var>", a) + 1
t = t[:a] + r"""is defined with the following transformation,
$ sigma_i^x sigma_j^x &= tau_(chevron.l i j chevron.r)^z \
sigma_i^z &= product_(i in square.stroked.tiny) tau_i^x . $""" + t[b:]

# ---- algorithm float ----
a = t.find("#block[\n]\n\n\n#block[\n#strong[Input]")
assert a > 0
b = t.find("\n\n== Algorithm theory", a)
alg = r"""#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  numbering: "1",
  caption: [Monte Carlo sampling of Pauli strings],
  block(
    width: 100%,
    inset: (x: 10pt, y: 8pt),
    stroke: 0.5pt,
    [
      #strong[Input]: a quantum state $rho$ and number of sampling $N_S$
      #v(0.6em)
      + Initialize the Pauli string $P$.
      + Compute $"Tr" (rho P)$ and $Pi_P$.
      + *for* $i = 1$ to $N_S$ *do*
        + Propose a candidate Pauli string $P'$.
        + Compute $"Tr" (rho P')$ and $Pi_(P')$.
        + Accept the move with probability: $min (1, Pi_(P') \/ Pi_P)$.
        + Measure the estimators.
      #v(0.6em)
      #strong[Output]: a Markov chain of $P$ with probability $Pi_P$.
    ]
  )
) <alg:QA_TTN>
"""
t = t[:a] + alg + t[b:]

# ---- text holes ----
t = t.replace("it at all#text([]) a fundamental", "it at all~@liu2022: a fundamental")
t = t.replace("is summarized in the Algorithm#text([]).", "is summarized in @alg:QA_TTN.")
t = t.replace("following Algorithm#text([]).", "following @alg:QA_TTN.")
t = t.replace("introduced in #text([]) would be", "introduced in @kadowasa2023 would be")
assert "#text([])" not in t, "remaining #text([])"

# ---- escaped dollar residue ----
t = re.sub(r'\\\$"Tilde"\{M\\_2\}\\\$', '$tilde(M)_2$', t)
t = t.replace('propto', 'prop')
# any remaining escaped dollar -> plain dollar
t = t.replace(BS + D, D)

open(P, "w", encoding="utf-8", newline="\n").write(t)
print("ok, blocks:", k, "remaining esc:", t.count(BS + D))
