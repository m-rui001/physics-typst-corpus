# -*- coding: utf-8 -*-
import io, re
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()
BS = chr(92)
AP = BS + chr(39)
s = s.replace('$d_sans("circ")$ {', '$d_sans("circ") {')
s = s.replace('$d_sans("circ")$lt.eq', '$d_sans("circ") lt.eq')
s = s.replace('$d_sans("circ")$' + AP + '$', '$d_sans("circ")' + AP + '$')
s = s.replace('is $r = k ( 2 n )$.', 'is $r = k\/(2 n)$.')
s = s.replace('$d_sans("circ")$ from .', '$d_sans("circ")$ from @table:codes_intro.')
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
