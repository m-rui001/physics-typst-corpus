import os, sys
sys.stdout.reconfigure(encoding="utf-8")
p = "papers/2112.03708/main.typ"
s0 = open(p, encoding="utf-8").read()
s = s0
def rep(old, new, expect=None, tag=""):
    global s
    n = s.count(old)
    if expect is not None:
        assert n == expect, "%s: %d != %d" % (tag, n, expect)
    s = s.replace(old, new)
    print("%-8s %d" % (tag, n))

rep('"macron"(z)_"L"', 'macron(z)_L', 1, "macronz")
rep('"macron"(x)_"L"', 'macron(x)_L', 1, "macronx")
rep('"hat"(Z)_("upright"("L"))', 'hat(Z)_L', 1, "hatZL")
rep('"hat"(X)_("upright"("L"))', 'hat(X)_L', 1, "hatXL")
rep('epsilon_("upright"("L"))', 'epsilon_"L"', 2, "epsL")
rep('"left"[1-{"rm" exp}"left"(', '[1 - exp(', 2, "left")
rep('"right")"right"]/2', ']/2', 2, "right")
rep('T_(1,"upright"("L"))', 'T_(1,"L")', 2, "T1L")
rep('T_(2,"upright"("L"))', 'T_(2,"L")', 2, "T2L")
rep('{"rm" d}', 'd', 4, "rmd")
s = s.replace('${z}_"L"', '$z_"L"')
rep('"hat"(', 'hat(', None, "hat")
assert '"macron"' not in s and '"left"' not in s and '"right"' not in s
assert '{"rm"' not in s and '"upright"' not in s
bak = p + ".previsdef"
if not os.path.exists(bak):
    open(bak, "w", encoding="utf-8").write(s0)
open(p, "w", encoding="utf-8").write(s)
print("ok")
