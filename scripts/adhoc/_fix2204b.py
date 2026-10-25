import os
BS = chr(92)
p = "papers/2204.12771/main.typ"
s0 = open(p, encoding="utf-8").read()
old = ('$ L_(upright("sd), upright(m")) = frac(eta B_(upright("p"))^2'
       ' R_(upright("s"))^6 Omega^4, 6 c^3) approx 10^46 thin upright("e")'
       ' r g med s^(- 1) med eta_(- 3) B_(upright("p), upright(15"))^2'
       ' R_(upright("s), upright(6"))^6 P_(0 , - 3)^(- 4) , $')
new = ('$ L_("sd,m") = frac(eta B_\"p\"^2 R_\"s\"^6 Omega^4, 6 c^3)'
       ' approx 10^46 "erg s"^(-1) eta_(-3) B_("p,15")^2 R_("s,6")^6'
       ' P_(0,-3)^(-4) $')
assert s0.count(old) == 1
s = s0.replace(old, new)
bak = p + ".prelsd"
if not os.path.exists(bak):
    open(bak, "w", encoding="utf-8").write(s0)
open(p, "w", encoding="utf-8").write(s)
print("ok")
