import re, shutil

auth = open('src/authorlist.tex', encoding='utf-8').read()
inst = open('src/institutes.tex', encoding='utf-8').read()

def strip_cond(s):
    s = re.sub(r'\\ifnum\\wm[<>=]?\d*\s*', '', s)
    s = s.replace(r'\fi', '')
    s = re.sub(r'\\thanks\{[^{}]*\}', '', s)
    return s

auth, inst = strip_cond(auth), strip_cond(inst)

labels = {}
for m in re.finditer(r'\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\\label\{([A-Za-z0-9_]+)\}\}', inst):
    labels[m.group(2)] = m.group(1)

def clean(t):
    t = re.sub(r'\\(?:textit|emph|textrm|text|mathrm|it)\{([^{}]*)\}', r'\1', t)
    t = t.replace(r'{\ss}', 'ß').replace(r'{\o}', 'ø').replace(r'{\aa}', 'å')
    acc = {"'": '\u0301', '`': '\u0300', '^': '\u0302', '"': '\u0308', '~': '\u0303',
           'v': '\u030c', 'c': '\u0327', 'r': '\u030a', 'u': '\u0306', 'H': '\u030b',
           'k': '\u0328', '.': '\u0307', '=': '\u0304'}
    t = re.sub(r"\\(['`^\"~vcrHu=k])(?:\{([A-Za-z])\}|([A-Za-z]))",
               lambda m: (m.group(2) or m.group(3)) + acc[m.group(1)], t)
    t = re.sub(r'\\[A-Za-z]+\s*', '', t)
    t = t.replace('{', '').replace('}', '').replace('$', '').replace('~', ' ')
    return re.sub(r'\s+', ' ', t).strip()

body = auth[auth.index(r'\author{') + len(r'\author{'):]
body = re.sub(r'\\orcidlink\{[^}]*\}', '', body)

def split_commas(s):
    out, depth, cur = [], 0, ''
    for ch in s:
        if ch == '{':
            depth += 1
        elif ch == '}':
            depth -= 1
        if ch == ',' and depth == 0:
            out.append(cur)
            cur = ''
        else:
            cur += ch
    out.append(cur)
    return out

authors, loose = [], []
for p in split_commas(body):
    m = re.search(r'\\inst\{((?:[^{}]|\{[^{}]*\})*)\}', p)
    name = clean(p[:m.start()] if m else p).strip(' ,')
    if not name:
        continue
    nums = []
    for lab in re.findall(r'\\ref\{([A-Za-z0-9_]+)\}', m.group(1) if m else ''):
        if lab in labels:
            t = clean(labels[lab])
            if t not in loose:
                loose.append(t)
            nums.append(loose.index(t) + 1)
    authors.append((name, nums))
print('authors', len(authors), 'insts', len(loose))
assert len(authors) >= 80, len(authors)

names = [n + (f"#super[{','.join(map(str, sorted(set(s))))}]" if s else '') for n, s in authors]
L = ['  #text(8.5pt)[', ', '.join(names), '  ]', '  #v(0.6em)', '  #text(7pt)[']
for i, a in enumerate(loose, 1):
    L.append(f'    #super[{i}] {a} \\')
L += ['  ]']
block = '\n'.join(L) + '\n'

mt = open('main.typ', encoding='utf-8').read()
old = '  #text(10.5pt)[J.~Antoniadis#super[#link("https://orcid.org/0000-0003-4453-776")[iD]]]\n'
if old in mt:
    assert mt.count(old) == 1
    shutil.copyfile('main.typ', 'main.typ.preauthors')
    mt = mt.replace(old, block)
    open('main.typ', 'w', encoding='utf-8').write(mt)
    print('written')
else:
    print('anchor missing')
print([n for n in names if 'Grie' in n])
