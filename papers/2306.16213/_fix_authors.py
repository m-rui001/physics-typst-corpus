import re, shutil

s = open('src/nanograv_15yr_gwb.tex', encoding='utf-8').read()
s = s[s.index(r'\begin{document}'):]
# stream of author / affiliation commands in file order
pat = re.compile(r'\\(author|affiliation)(?:\[([^\]]*)\])?\{(.*?)\}\s*(?=\\|$)', re.S)
items = []
for m in re.finditer(r'\\(author|affiliation)(?:\[([^\]]*)\])?\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}', s):
    kind, opt, body = m.group(1), m.group(2) or '', m.group(3)
    items.append((kind, opt, re.sub(r'\s+', ' ', body).strip()))

def clean(t):
    t = t.replace('\\\\', ' ')
    t = re.sub(r'\\(?:textit|emph|textrm|text)\{([^{}]*)\}', r'\1', t)
    acc = {"'": '\u0301', '`': '\u0300', '^': '\u0302', '"': '\u0308', '~': '\u0303',
           'v': '\u030c', 'c': '\u0327', 'r': '\u030a', 'u': '\u0306', 'H': '\u030b',
           'k': '\u0328', '.': '\u0307', '=': '\u0304'}
    t = re.sub(r"\\(['`^\"~vcrHu=k])(?:\{([A-Za-z])\}|([A-Za-z]))",
               lambda m: (m.group(2) or m.group(3)) + acc[m.group(1)], t)
    t = re.sub(r'\\[A-Za-z]+\s*', '', t)
    t = t.replace('{', '').replace('}', '').replace('$', '')
    return re.sub(r'\s+', ' ', t).strip()

aff_num = {}
aff_list = []
authors = []
for kind, opt, body in items:
    if kind == 'affiliation':
        key = clean(body)
        if key not in aff_num:
            aff_num[key] = len(aff_list) + 1
            aff_list.append(key)
        if authors and authors[-1][2] != aff_num[key]:
            authors[-1][1].append(aff_num[key])
    else:
        authors.append([clean(body), [], opt])

print('authors', len(authors), 'uniq affils', len(aff_list))
print(authors[0], authors[-1])

names = []
for name, nums, opt in authors:
    sup = f"#super[{','.join(str(n) for n in sorted(set(nums)))}]" if nums else ''
    names.append(name + sup)

L = []
L.append('#align(center)[')
L.append('  #text(17pt, weight: "bold", [The NANOGrav 15-year Data Set: Evidence for a Gravitational-Wave Background])   #v(1.2em)')
L.append('  #text(10.5pt, weight: "bold")[The NANOGrav Collaboration]')
L.append('  #v(0.4em)')
L.append('  #text(8.5pt)[')
L.append(', '.join(names))
L.append('  ]')
L.append('  #v(0.8em)')
L.append('  #text(7pt)[')
for i, a in enumerate(aff_list, 1):
    L.append(f'    #super[{i}] {a} \\')
L.append('  ]')
L.append(']')
block = '\n'.join(L) + '\n'

mt = open('main.typ', encoding='utf-8').read()
a = mt.index('#align(center)[\n  #text(17pt, weight: "bold", [The NANOGrav')
b = mt.index('#v(1.2em)\n\n#align(center)[#text(11pt, weight: "bold")[Abstract]]')
old = mt[a:b + len('#v(1.2em)\n')]
assert old.count('The NANOGrav Collaboration') == 1, old[:200]
shutil.copyfile('main.typ', 'main.typ.preauthors')
mt = mt[:a] + block + mt[b + len('#v(1.2em)\n'):]
open('main.typ', 'w', encoding='utf-8').write(mt)
print('written')
