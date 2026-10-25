import re, shutil

auth = open('src/authorlist.tex', encoding='utf-8').read()
inst = open('src/institutes.tex', encoding='utf-8').read()

def strip_cond(s):
    s = re.sub(r'\\ifnum\\wm(?:>1|=5|>0|=2)\s*', '', s)
    s = s.replace(r'\fi', '')
    return s

auth, inst = strip_cond(auth), strip_cond(inst)

# institute label -> text
labels = {}
for m in re.finditer(r'\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\\label\{([A-Za-z0-9_]+)\}\}', inst):
    labels[m.group(2)] = m.group(1)

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

body = auth[auth.index(r'\author{') + len(r'\author{'):]
# each author entry ends with \inst{...},
entries = re.findall(r'((?:[^{}]|\{[^{}]*\})+?)\\orcidlink\{[^}]*\}\\inst\{((?:[^{}]|\{[^{}]*\})*)\}', body)
print('entries', len(entries))
authors, loose = [], []
for name, refs in entries:
    name = clean(name).strip(', ')
    if not name:
        continue
    nums = []
    for lab in re.findall(r'\\ref\{([A-Za-z0-9_]+)\}', refs):
        if lab in labels:
            t = clean(labels[lab])
            if t not in loose:
                loose.append(t)
            nums.append(loose.index(t) + 1)
    authors.append((name, nums))
print('authors', len(authors), 'insts', len(loose))
assert len(authors) > 50, len(authors)

names = [n + (f"#super[{','.join(map(str, sorted(set(s))))}]" if s else '') for n, s in authors]
L = ['  #text(8.5pt)[', ', '.join(names), '  ]', '  #v(0.6em)', '  #text(7pt)[']
for i, a in enumerate(loose, 1):
    L.append(f'    #super[{i}] {a} \\')
L += ['  ]']
block = '\n'.join(L) + '\n'

mt = open('main.typ', encoding='utf-8').read()
old = '  #text(10.5pt)[J.~Antoniadis#super[#link("https://orcid.org/0000-0003-4453-776")[iD]]]\n'
assert mt.count(old) == 1, mt.count(old)
shutil.copyfile('main.typ', 'main.typ.preauthors')
mt = mt.replace(old, block)
open('main.typ', 'w', encoding='utf-8').write(mt)
print(names[:3])
