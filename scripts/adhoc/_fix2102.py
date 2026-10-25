import os
BS = chr(92)
p = "papers/2102.01111/main.typ"
s0 = open(p, encoding="utf-8").read()
s = s0

def rep1(old, new, tag):
    global s
    n = s.count(old)
    assert n == 1, "%s: %d" % (tag, n)
    s = s.replace(old, new)

rep1('$"" _(5)times S^(5)' + BS + '/Gamma$',
     '$"AdS"_5 times S^5 ' + BS + '/ Gamma$', "AdS5")
rep1('$A d S_4 times bb(C) P^3$',
     '$"AdS"_4 times bb(C) P^3$', "AdS4")
rep1('admits a s structure', 'admits a spin structure', "spin1")
rep1('$Omega^(sigma)$', '$Omega^"spin"$', "spin2")
rep1('$Omega^({sigma}_c)$', '$Omega^"spin"_c$', "spin3")
rep1('preserves a s structure', 'preserves a spin structure', "spin4")
rep1('$Omega_1^(sigma)=Z_2$', '$Omega_1^"spin" = Z_2$', "spin5")
rep1('$Omega_d^("s") = 0$', '$Omega_d^"spin" = 0$', "spin6")
rep1('any s manifold', 'any spin manifold', "spin7")

bak = p + ".prespin"
if not os.path.exists(bak):
    open(bak, "w", encoding="utf-8").write(s0)
open(p, "w", encoding="utf-8").write(s)
print("ok")
