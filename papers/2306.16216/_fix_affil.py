import re, shutil

s = open('src/ms.tex', encoding='utf-8').read()

def strip_c(s):
    return re.sub(r'\\ifnum[^\\]*?(\\fi|$)', '', s)

a0 = s.index(r'\author{')
a1 = s.index(r'\institute{')
author_block = s[a0 + len(r'\author{'):a1]
inst_start = a1 + len(r'\institute{')
# institute block ends at matching closing brace
depth, i = 0, inst_start
while True:
    ch = s[i]
    if ch == '{':
        depth += 1
    elif ch == '}':
        if depth == 0:
            break
        depth -= 1
    i += 1
inst_block = s[inst_start:i]

def clean(t):
    t = t.replace('\\\\', ' ')
    t = re.sub(r'\{\\it\s*([^{}]*)\}', r'\1', t)
    t = re.sub(r'\\(?:textit|emph|textrm|text|it|sc)\{([^{}]*)\}', r'\1', t)
    acc = {"'": '\u0301', '`': '\u0300', '^': '\u0302', '"': '\u0308', '~': '\u0303'}
    t = re.sub(r"\\(['`^\"~])(?:\{([A-Za-z])\}|([A-Za-z]))",
               lambda m: (m.group(2) or m.group(3)) + acc[m.group(1)], t)
    t = re.sub(r'\\[A-Za-z]+\s*', '', t)
    t = t.replace('{', '').replace('}', '').replace('~', ' ')
    t = t.replace('@', '\\@')
    return re.sub(r'\s+', ' ', t).strip()

affs = [clean(x) for x in re.split(r'\\and', inst_block) if clean(x)]
print('affs', len(affs))

def split_top(s, sep=','):
    out, depth, cur = [], 0, ''
    for ch in s:
        if ch == '{':
            depth += 1
        elif ch == '}':
            depth -= 1
        if ch == sep and depth == 0:
            out.append(cur); cur = ''
        else:
            cur += ch
    out.append(cur)
    return out

authors = []
for part in split_top(author_block):
    m = re.search(r'\\inst\{([^}]*)\}', part)
    name = clean(part[:m.start()] if m else part).strip(' ,')
    if not name:
        continue
    nums = [x.strip() for x in re.split(r'[,*]', m.group(1))] if m else []
    nums = [n for n in nums if n.isdigit()]
    authors.append((name, nums))
print('authors', len(authors))
assert len(authors) == 27, len(authors)
assert len(affs) >= 14, len(affs)

names = [n + (f"#super[{','.join(x)}]" if x else '') for n, x in authors]
L = ['  #v(0.4em)', '  #text(8.8pt)[' + ', '.join(names) + ']', '  #v(0.6em)', '  #text(7.2pt)[']
for i, a in enumerate(affs, 1):
    L.append(f'    #super[{i}] {a} \\')
L.append('  ]')
block = '\n'.join(L) + '\n'

mt = open('main.typ', encoding='utf-8').read()
anchor = '#v(1em)\n\n#align(center)[\n  #text(9.5pt)[*Abstract.*'
assert mt.count(anchor) == 1
shutil.copyfile('main.typ', 'main.typ.preaffil')
mt = mt.replace(anchor, block + '\n#align(center)[\n  #text(9.5pt)[*Abstract.*')
open('main.typ', 'w', encoding='utf-8').write(mt)
print(names[:3], affs[:2])
