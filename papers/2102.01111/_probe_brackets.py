import re, shutil, sys

s = open('main.typ', encoding='utf-8').read()
pat = re.compile(r'\[\\\[([^\]]*)\\\]\]')
for m in pat.finditer(s):
    print(repr(m.group(0)), 'at', s.count('\n', 0, m.start()) + 1)

reps = [
 ("with $L$ the  radius.", "with $L$ the AdS radius."),
 ("== Implications of  Instability Conjecture", "== Implications of AdS Instability Conjecture"),
 ("two implications of the  instability conjecture.", "two implications of the AdS instability conjecture."),
 ("using  Hence, it implies", "using @speciesm. Hence, it implies"),
]
for old, new in reps:
    n = s.count(old)
    print(n, repr(old))
    if n != 1:
        sys.exit('count mismatch ' + old)
    s = s.replace(old, new)

n1 = s.count(r'[\[Nsepcies\]]')
n2 = s.count(r'[\[species\]]')
print('bracket counts', n1, n2)
s = s.replace(r'[\[Nsepcies\]]', '@Nsepcies')
s = s.replace(r'[\[species\]]', '@species')

shutil.copy('main.typ', 'main.typ.prebrackets')
open('main.typ', 'w', encoding='utf-8', newline='\n').write(s)
print('done')
