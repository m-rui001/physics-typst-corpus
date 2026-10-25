import os, sys
sys.stdout.reconfigure(encoding="utf-8")
jobs = []

# 2202.02773: quoted "bold"
p = "papers/2202.02773/main.typ"
jobs.append((p, [(
    '$Omega_b = integral_(4 pi) gamma ( "bold" ( r ) ) thin "d" Omega$',
    '$Omega_b = integral_(4 pi) gamma (bold(r)) thin "d" Omega$')]))

# 2308.07915: sans/quoted subseteq/bb(F)
p = "papers/2308.07915/main.typ"
jobs.append((p, [(
    '$"sans"("rs"){(H)}"subseteq" "FF"_2^n$, $"sans"("cs"){(H)}"subseteq" "FF"_2^s$, and $"sans"("ker"){(H)}"subseteq" "FF"_2^n$',
    '$sans("rs")(H) subseteq bb(F)_2^n$, $sans("cs")(H) subseteq bb(F)_2^s$, and $sans("ker")(H) subseteq bb(F)_2^n$')]))

# 2206.11528: reduced density matrix
p = "papers/2206.11528/main.typ"
jobs.append((p, [(
    '$r h o_A = upright("upright") ( upright("tr") )_(() B ) upright("left") \\| a l p h a med < upright("right") \\| a l p h a$',
    '$rho_A = "tr"_B |alpha⟩ ⟨alpha|$')]))

for p, reps in jobs:
    s0 = open(p, encoding="utf-8").read()
    s = s0
    for old, new in reps:
        n = s.count(old)
        assert n == 1, "%s: %d" % (p, n)
        s = s.replace(old, new)
    bak = p + ".previsdef"
    if not os.path.exists(bak):
        open(bak, "w", encoding="utf-8").write(s0)
    open(p, "w", encoding="utf-8").write(s)
    print("ok", p)
