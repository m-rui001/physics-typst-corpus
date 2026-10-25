p = 'papers/2308.08546/main.typ'
s = open(p, encoding='utf-8').read()
anchor = '#set math.equation(numbering: "(1)", supplement: none)'
assert s.count(anchor) == 1
rule = anchor + '''
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [(#context counter(math.equation).at(e.location()).first())]
  } else { it }
}'''
s = s.replace(anchor, rule, 1)
open(p, 'w', encoding='utf-8').write(s)
print('rule added')
