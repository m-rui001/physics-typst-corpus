import sys
sys.stdout.reconfigure(encoding="utf-8")
p = "papers/2112.03708/main.typ"
s0 = open(p, encoding="utf-8").read()
s = s0
for i in ("1", "2"):
    old = 'exp(-t_"c"/T_(%s,"L")]/2' % i
    new = 'exp(-t_"c"/T_(%s,"L"))]/2' % i
    assert s.count(old) == 1, (i, s.count(old))
    s = s.replace(old, new)
open(p, "w", encoding="utf-8").write(s)
print("2112 ok")

p = "papers/2308.07915/main.typ"
s0 = open(p, encoding="utf-8").read()
n = s0.count(" subseteq bb(F)_2")
assert n == 3, n
s = s0.replace(" subseteq bb(F)_2", " subset.eq bb(F)_2")
open(p, "w", encoding="utf-8").write(s)
print("2308 ok")
