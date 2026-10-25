import io, os
BS = chr(92)
DBL = BS + BS
NL = chr(10)

def load(pid):
    p = "papers/%s/main.typ" % pid
    return p, open(p, encoding="utf-8").read()

def save(p, s, orig):
    if s == orig:
        return
    bak = p + ".predbl"
    if not os.path.exists(bak):
        open(bak, "w", encoding="utf-8").write(orig)
    open(p, "w", encoding="utf-8").write(s)

def rep1(s, old, new, tag):
    n = s.count(old)
    if n == 0 and new in s:
        return s
    assert n == 1, "%s: found %d" % (tag, n)
    return s.replace(old, new)

# 2102.01111: math row break
p, s0 = load("2102.01111")
s = rep1(s0, "⟺ " + DBL + NL, "⟺ " + BS + NL, "2102 rowbreak")
save(p, s, s0)

# 2111.14241: row break + 95\%
p, s0 = load("2111.14241")
s = rep1(s0, ", " + DBL + " " + NL, ", " + BS + " " + NL, "2111 rowbreak")
s = rep1(s, "95" + DBL + "%", "95%", "2111 percent")
save(p, s, s0)

# 2112.03708: 92.1(3) \\"%"
p, s0 = load("2112.03708")
s = rep1(s0, "92.1(3) " + DBL + '"%"', '92.1(3) "%"', "2112 percent")
save(p, s, s0)

# 2202.02773: URL
p, s0 = load("2202.02773")
s = rep1(s0, "https:" + DBL + "#" + DBL + "#/github.com", "https://github.com", "2202 url")
save(p, s, s0)

# 2207.06431: qubit labels
p, s0 = load("2207.06431")
s = rep1(s0, '{"q"}2' + DBL + "_5", '{"q"}2' + BS + "_5", "2207 q2_5")
s = rep1(s, '{"q"}5' + DBL + "_4", '{"q"}5' + BS + "_4", "2207 q5_4")
s = rep1(s, '{"q"}5' + DBL + "_6", '{"q"}5' + BS + "_6", "2207 q5_6")
save(p, s, s0)

# 2301.10937: affiliation line breaks
p, s0 = load("2301.10937")
s = s0.replace(DBL + " ", BS + " ")
assert s.count(DBL) == 0, "2301 leftovers"
save(p, s, s0)

# 2204.12771: rebuild mangled Band function display
p, s0 = load("2204.12771")
L = s0.split(NL)
i = next(k for k, ln in enumerate(L) if ln.startswith("    A " + DBL + "( frac(E, 100 thin"))
assert "cases(" in L[i-1]
assert L[i+2].startswith("  )" + BS + "$ respectively, where")
prefix = L[i-1][: L[i-1].index(BS + "$N")]
suffix = L[i+2][len("  )" + BS + "$"):]
block = [
    "$ N (E) = cases(",
    '  A (E \\/ (100 "keV"))^alpha exp(-E \\/ E_c), & E < (alpha - beta) E_c,',
    '  A ((alpha - beta) E_c \\/ (100 "keV"))^(alpha - beta) exp(beta - alpha) (E \\/ (100 "keV"))^beta, & E >= (alpha - beta) E_c,',
    ") $" + suffix,
]
L = L[:i-1] + [prefix + block[0]] + block[1:]
s = NL.join(L)
assert s.count(DBL) == 0, "2204 leftovers %d" % s.count(DBL)
save(p, s, s0)
print("ok")
