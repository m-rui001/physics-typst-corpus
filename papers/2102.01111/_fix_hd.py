s = open('main.typ', encoding='utf-8').read()
old = '\n\\_\n'
new = '\n$ cal(Q)/M >= (cal(Q)/M)|_"ext" . $ <hd>\n'
print(s.count(old))
assert s.count(old) == 1
s = s.replace(old, new)
open('main.typ', 'w', encoding='utf-8', newline='\n').write(s)
print('done')
