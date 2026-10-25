p = 'papers/2308.08546/main.typ'
s = open(p, encoding='utf-8').read()
s = s.replace('@eq:Delta2\\_Omega', '@eq:Delta2_Omega')
old = '$ where the step size $delta f$'
assert s.count(old) == 1
s = s.replace(old, '$<eq:Delta2_Omega> where the step size $delta f$')
open(p, 'w', encoding='utf-8').write(s)
print('ok')
