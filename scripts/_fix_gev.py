p = 'papers/2308.08546/main.typ'
s = open(p, encoding='utf-8').read()
n = s.count('0.67 GeV')
s = s.replace('0.67 GeV', '0.67 upright("GeV")')
s = s.replace('0.34 GeV', '0.34 upright("GeV")')
s = s.replace('0.85 GeV', '0.85 upright("GeV")')
open(p, 'w', encoding='utf-8').write(s)
print('replaced', n)
