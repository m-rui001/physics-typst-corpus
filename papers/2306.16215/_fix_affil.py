import re, shutil

s_full = open('src/ppta_sgwb_arxiv.tex', encoding='utf-8').read()
defs = {}
for m in re.finditer(r'\\newcommand\s*\{?\\([A-Za-z]+)\}?\s*\{((?:[^{}]|\{[^{}]*\})*)\}', s_full):
    defs[m.group(1)] = m.group(2)
s = s_full[s_full.index(r'\begin{document}'):]
for _ in range(3):
    s = re.sub(r'\\([A-Za-z]+)', lambda m: '{' + defs[m.group(1)] + '}' if m.group(1) in defs else m.group(0), s)

def clean(t):
    t = re.sub(r'\\(?:textit|emph|textrm|text|mathrm|it)\{([^{}]*)\}', r'\1', t)
    acc = {"'": '\u0301', '`': '\u0300', '^': '\u0302', '"': '\u0308', '~': '\u0303',
           'v': '\u030c', 'c': '\u0327', 'r': '\u030a', 'u': '\u0306', 'H': '\u030b',
           'k': '\u0328', '.': '\u0307', '=': '\u0304'}
    t = re.sub(r"\\(['`^\"~vcrHu=k])(?:\{([A-Za-z])\}|([A-Za-z]))",
               lambda m: (m.group(2) or m.group(3)) + acc[m.group(1)], t)
    t = re.sub(r'\\[A-Za-z]+\s*', '', t)
    t = t.replace('{', '').replace('}', '').replace('$', '').replace('~', ' ')
    return re.sub(r'\s+', ' ', t).strip()

pat = re.compile(r'\\(author|affiliation)(?:\[[^\]]*\])?\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}')
aff_num, aff_list, authors = {}, [], []
for m in pat.finditer(s):
    kind, body = m.group(1), clean(m.group(2))
    if kind == 'affiliation':
        if body not in aff_num:
            aff_num[body] = len(aff_list) + 1
            aff_list.append(body)
        if authors:
            n = aff_num[body]
            if n not in authors[-1][1]:
                authors[-1][1].append(n)
    else:
        authors.append([body, [], ''])
print('authors', len(authors), 'affils', len(aff_list))
assert len(authors) == 29, len(authors)

names = []
for name, nums, _ in authors:
    names.append(name + (f"#super[{','.join(map(str, nums))}]" if nums else ''))

L = ['  #v(0.5em)', '  #text(8.8pt)[' + ', '.join(names) + ']', '  #v(0.6em)', '  #text(7.5pt)[']
for i, a in enumerate(aff_list, 1):
    L.append(f'    #super[{i}] {a} \\')
L += ['  ]', '  #v(0.5em)',
      '  #text(8pt)[E-mail: andrew.zic\\@csiro.au, dreardon\\@swin.edu.au]']
block = '\n'.join(L) + '\n'

mt = open('main.typ', encoding='utf-8').read()
lines = mt.split('\n')
dropped = [l for l in lines if l.startswith('  #text(10.5pt)[Daniel J. Reardon')]
assert len(dropped) == 1, len(dropped)
mt = '\n'.join(l for l in lines if not l.startswith('  #text(10.5pt)[Daniel J. Reardon'))
anchor = '#v(1em)\n\n#align(center)[\n  #text(9.5pt)[*Abstract.*'
assert mt.count(anchor) == 1, mt.count(anchor)
shutil.copyfile('main.typ', 'main.typ.preaffil')
mt = mt.replace(anchor, '#v(1em)\n' + block + '\n#align(center)[\n  #text(9.5pt)[*Abstract.*')
open('main.typ', 'w', encoding='utf-8').write(mt)
print('written; sample:', names[:3])
