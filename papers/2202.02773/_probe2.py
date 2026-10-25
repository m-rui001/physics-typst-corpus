import re
L = open('main.typ', encoding='utf-8').read().split('\n')
for i in range(16, 104):
    l = L[i]
    rest = re.sub(r'#super\[\d+(,\s*\d+)*\]|#text\([^)]*\)\[', '', l)
    if '#' in rest:
        print(i + 1, repr(l[:220]))
