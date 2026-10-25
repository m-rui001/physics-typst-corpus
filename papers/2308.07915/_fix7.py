# -*- coding: utf-8 -*-
import io, re
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()
BS = chr(92)
AP = BS + chr(39)
s = s.replace('p^("$d_sans("circ")$"/2)', 'p^(d_sans("circ")/2)')
s = s.replace('(1' + BS + '/N_c)', '(1/N_c)')
s = s.replace('P_L ( N_c )' + BS + '/N_c', 'P_L ( N_c )/N_c')
s = re.sub(r'"\$d_sans\("circ"\)\$"', 'd_sans("circ")', s)
s = re.sub(r'"\$d_sans\("circ"\)' + re.escape(AP) + r'\$"', 'd_sans("circ")' + AP, s)
s = s.replace('Data reported in A)', 'Data reported in @fig:numerics A)')
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('bad quotes left:', s.count('"$'))
