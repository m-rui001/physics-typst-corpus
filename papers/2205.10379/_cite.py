import re
typ = open('E:/phys/papers/2205.10379/main.typ', encoding='utf-8').read()
bib = open('E:/phys/papers/2205.10379/refs.bib', encoding='utf-8').read()
# labels defined in typst (figures/equations)
labels = set(re.findall(r'<([\w:\-]+)>', typ))
# citation keys used as @key (not heading/figure labels which are also @)
used = set(re.findall(r'@([\w:\-]+)', typ))
bibkeys = set(re.findall(r'@\w+\{([\w:\-]+),', bib))
# cross-reference targets like @fig1 @windingnumber are labels not bibkeys
print('MISSING (used but neither bibkey nor label):')
for k in sorted(used - bibkeys - labels):
    print('  @' + k)
