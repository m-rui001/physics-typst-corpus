import re

p = 'papers/2308.08546/main.typ'
s = open(p, encoding='utf-8').read()

# 1. converter left `\eqref` as a link whose body is the literal label text
s, n1 = re.subn(r'#link\(<eq:([^<>]+)>\)\[\\\[eq:[^\]]+\\\]\]', r'@eq:\1', s)
s, n2 = re.subn(r'\[\\\[eq:([^\]]+)\\\]\]', r'@eq:\1', s)

# 2. a closing display `$` followed by a stray `\$` printed a literal dollar in the prose
s, n3 = re.subn(r'\$\\\$', '$', s)

# 3. the ref target for eq:OmegaGWtoday lost its label during the block repair
needle = r'''  & approx 1.6 times 10^(-5)'''
print('label target found:', needle in s)
open(p, 'w', encoding='utf-8').write(s)
print('links', n1, 'bare', n2, 'dollars', n3, 'stray left', s.count('\\$'))
