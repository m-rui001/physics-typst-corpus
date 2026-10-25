import re

# 2204.13249: `$^+$` is not a valid math body in Typst
p = 'papers/2204.13249/main.typ'
s = open(p, encoding='utf-8').read()
s = s.replace('EC PRISMA$^+$', 'EC PRISMA#super[+]')
open(p, 'w', encoding='utf-8').write(s)

# 2205.13540: \gtrsim came through as raw HTML-ish residue
p = 'papers/2205.13540/main.typ'
s = open(p, encoding='utf-8').read()
bad = r'$10^(-4)\,{"upright"("Mpc")}^(-1) "mathrel"{"raise".3ex"hbox"{\<"kern"-.75em"lower"1ex"hbox"{similar}}} k "mathrel"{"raise".3ex"hbox"{\<"kern"-.75em"lower"1ex"hbox"{similar}}} 1\,{"upright"("Mpc")}^(-1)$'
good = r'$10^(-4) upright("Mpc")^(-1) gt.tilde k gt.tilde 1 upright("Mpc")^(-1)$'
assert bad in s
s = s.replace(bad, good)
open(p, 'w', encoding='utf-8').write(s)

# 2503.14744: \SI{...}{...} residue
p = 'papers/2503.14744/main.typ'
s = open(p, encoding='utf-8').read()
b1 = r'$("SI"\[parse-numbers=false\]{3h^(-1)}{\#2}{"Gpc"})^3$'
g1 = r'$(3 h^(-1) "Gpc")^3$'
b2 = r'$m\_p="SI"\[parse-numbers=false\]{10^(10)h^(-1)}{\#2}{M\_"odot"}$'
g2 = r'$m_p = 10^(10) h^(-1) M_"odot"$'
assert b1 in s and b2 in s
s = s.replace(b1, g1).replace(b2, g2)
open(p, 'w', encoding='utf-8').write(s)
print('ok')
