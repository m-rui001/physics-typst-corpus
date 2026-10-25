L = open('main.typ', encoding='utf-8').read().split('\n')
for i in range(14, 104):
    l = L[i]
    flags = []
    if '$' in l: flags.append('dollar')
    if '"' in l: flags.append('quote')
    if l.count('(') != l.count(')'): flags.append('paren')
    if flags:
        print(i + 1, flags, repr(l[:200]))
