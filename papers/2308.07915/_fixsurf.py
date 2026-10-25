# -*- coding: utf-8 -*-
import io
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()
subs = [
    ("Surface code data reported in ~B) was generated",
     "Surface code data reported in @fig:numerics~B) was generated"),
    ("parameters $[ [ d^2 , 1 , d ] ]$, where , and the standard SM circuit#text([]) Let",
     "parameters $[ [ d^2 , 1 , d ] ]$, where $d in {9 , 11 , 13 , 15}$, and the standard SM circuit~@fowler2009high. Let"),
    ("~B) shows the logical error rate $p_L$",
     "@fig:numerics~B) shows the logical error rate $p_L$"),
]
for a, b in subs:
    if s.count(a) != 1:
        print('COUNT', s.count(a), a[:60])
    s = s.replace(a, b)
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('ok')
