# -*- coding: utf-8 -*-
import io, re
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()
BS = chr(92)
AP = BS + chr(39)  # typst escaped prime
s = s.replace('$"' + '$d_sans("circ")$' + '"', '$d_sans("circ")$')
s = s.replace('$"' + '$d_sans("circ")$' + AP + '"', '$d_sans("circ")' + AP + '$')
# any remaining quoted dcirc forms with spaces
s = re.sub(r'\$\s*"\s*d_sans\("circ"\)\s*"\s*\$', '$d_sans("circ")$', s)
s = re.sub(r'\$\s*"\s*d_sans\("circ"\)\s*' + re.escape(AP) + r'\s*"\s*\$',
           '$d_sans("circ")' + AP + '$', s)
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('nested left:', s.count('$"$d_sans'))
