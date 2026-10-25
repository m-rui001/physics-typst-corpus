import os
p = r"E:\phys\papers\2112.03708\main.typ"
s = open(p, encoding="utf-8").read()
orig = s

def rep(old, new, expect=None, tag=""):
    global s
    n = s.count(old)
    if n == 0:
        if new in s:
            return
        raise AssertionError("%s: missing %r" % (tag or new, old))
    if expect is not None:
        assert n == expect, "%s: expected %d got %d" % (tag or old, expect, n)
    s = s.replace(old, new)

# ket holes
rep(r"|0\_", r'$|0 angle_"L"$', tag="ket0")
rep(r"|1\_", r'$|1 angle_"L"$', tag="ket1")
rep(r"|+\_", r'$|+ angle_"L"$', tag="ket+")
rep(r"|-\_", r'$|- angle_"L"$', tag="ket-")
# operator / projector / fidelity holes
rep(r"the \_ (filled circles) and #strong[d] the \_ (filled triangles)",
    r'the $hat(Z)_"L"$ (filled circles) and #strong[d] the $hat(X)_"L"$ (filled triangles)', 1, "caption c/d")
rep(r"logical operators \_ (\_)",
    r'logical operators $hat(Z)_"L"$ ($hat(X)_"L"$)', 1, "logical ops")
rep(r"all stabilizers and of \_)",
    r'all stabilizers and of $hat(Z)_"L"$)', 1, "trivial eigen")
rep(r"logical subspace \_.",
    r'logical subspace $hat(cal(P))_"L"$.', 1, "projector")
rep(r"fidelity \_ of the prepared",
    r'fidelity $cal(F)_"c"$ of the prepared', 1, "correctable fid")
rep(r"application of \_ and thus",
    r'application of $hat(Z)_"L"$ and thus', 1, "application")
# caption operator names
rep(r"expectation value of the \_ operator for prepared",
    r'expectation value of the $hat(Z)_"L"$ operator for prepared', 1, "cap a")
rep(r"Corresponding data sets for \_,",
    r'Corresponding data sets for $hat(X)_"L"$,', 1, "cap b")
# delta phase hole
rep(r"measuring the phase \_j induced",
    r'measuring the phase $phi_j$ induced', 1, "delta phase")
# crosstalk matrix
rep(r"element of the flux crosstalk matrix .",
    r'element of the flux crosstalk matrix $bold(C)$.', 1, "crosstalk")
# lost division slash
rep(r"|) 2$ (solid symbols", r"|) \/ 2$ (solid symbols", 1, "E_L /2")
rep(r"fit to $1 x^2$", r"fit to $1 \/ x^2$", 1, "fit slash cap")
rep(r"as $1 x^2$", r"as $1 \/ x^2$", 1, "fit slash body")
# units glued to math close
rep(r"= 18.2 ( 5 ) $µs", r"= 18.2(5)$ µs", 1, "T2 unit")
rep(r"= 16.4 ( 8 ) $µs", r"= 16.4(8)$ µs", 1, "T1 unit")
rep(r"$t_c = 1.1 $µs", r"$t_c = 1.1$ µs", None, "tc unit")
rep(r"about $150 $ns", r"about $150$ ns", 1, "150 ns")

assert r"\_" not in s, "underscore holes remain"
if s != orig:
    bak = p + ".preholes"
    if not os.path.exists(bak):
        open(bak, "w", encoding="utf-8").write(orig)
    open(p, "w", encoding="utf-8").write(s)
    print("patched", p)
else:
    print("no change")
