p = 'papers/2308.08546/main.typ'
s = open(p, encoding='utf-8').read()
old = '$ where $T$ denotes the temperature'
assert s.count(old) == 1
s = s.replace(old, '$<eq:OmegaGWtoday> where $T$ denotes the temperature')
open(p, 'w', encoding='utf-8').write(s)
print('label attached')
