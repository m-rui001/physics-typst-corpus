import os
BS = chr(92)
p = "papers/2306.16227/main.typ"
s0 = open(p, encoding="utf-8").read()

def rep1(s, old, new, tag):
    n = s.count(old)
    assert n == 1, "%s: %d" % (tag, n)
    return s.replace(old, new)

s = rep1(s0,
    '$"log"_(10)(M_("' + BS + '*")' + BS + '/"M"_⊙).4$',
    '$log_10 (M_("*") ' + BS + '/ M_⊙) approx 8.4$',
    "log10 normalization")
s = rep1(s,
    '$-11≲"log"_(10)-9.5$',
    '$-11 lt.eq log_10 G mu lt.eq -9.5$',
    "string tension")

bak = p + ".predef"
if not os.path.exists(bak):
    open(bak, "w", encoding="utf-8").write(s0)
open(p, "w", encoding="utf-8").write(s)
print("ok")
