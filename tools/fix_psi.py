import re, sys
p = sys.argv[1]
t = open(p, encoding='utf-8').read()
pat = re.compile(r'\((psi(?:_(?:\([^()]*\)(?:\([^()]*\))?|[A-Za-z0-9]+))?)\)')
t, n = pat.subn(r'\1', t)
t2 = t.replace('(psi_"in"(xi))', 'psi_("in")(xi)')
print('fixed', n, 'plus', int(t2 != t))
open(p, 'w', encoding='utf-8').write(t2)
