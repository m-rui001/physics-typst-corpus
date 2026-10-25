p = 'papers/2503.14744/main.typ'
s = open(p, encoding='utf-8').read()
old = 'See [\\[eq:solar\\_split,eq:atm\\_split\\]] for the values'
assert s.count(old) == 1
# both splittings share one display in the Typst conversion, so both point at it
s = s.replace(old, 'See @eq:solar_split for the values')
open(p, 'w', encoding='utf-8').write(s)
print('ok')
