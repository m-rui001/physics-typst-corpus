s = open('main.typ', encoding='utf-8').read()
pairs = [
 (r'[\[Aj\]]', '@Aj', 1),
 (r'[\[gMp\]]', '@gMp', 2),
 (r'[\[hd\]]', '@hd', 1),
 (r'[\[inequality-tension-charge\]]', '@inequality-tension-charge', 2),
 (r'[\[Ntower\]]', '@Ntower', 1),
]
for old, new, want in pairs:
    n = s.count(old)
    print(n, old)
    assert n == want, old
    s = s.replace(old, new)
open('main.typ', 'w', encoding='utf-8', newline='\n').write(s)
print('done')
