import os, re, shutil, sys

ROOT = 'E:/phys/papers'

def backup(path, tag):
    b = path + '.' + tag
    if not os.path.exists(b):
        shutil.copy2(path, b)

def load_keys(paper):
    bib = os.path.join(ROOT, paper, 'refs.bib')
    keys = {}
    if os.path.exists(bib):
        txt = open(bib, encoding='utf-8', errors='replace').read()
        for m in re.findall(r'@\w+\s*\{\s*([^,\s]+)\s*,', txt):
            keys.setdefault(m.strip().lower(), m.strip())
    return keys

# A. drop literal Section/Sec./§ before a heading reference (Typst already prints "Section N")
secdup = re.compile(r'(?:\bSection\b|\bSec\.|§)[~ ]*(?=(?:@(?:sub)?sec\b|#ref\(<sec))')

# B. targeted repairs: paper -> list of (old, new)
targeted = {
    '2306.16213': [
        ('#smallcaps @holodeck    package #cite(<holodeck>)',
         '#smallcaps[holodeck] package #cite(<holodeck>)'),
        ('#smallcaps @holodeck    #cite(<holodeck>)',
         '#smallcaps[holodeck] #cite(<holodeck>)'),
        ('#emph @hasasia    #cite(<hasasia>)', '#emph[hasasia] #cite(<hasasia>)'),
        ('#emph @holodeck    #cite(<holodeck>)', '#emph[holodeck] #cite(<holodeck>)'),
        ('#emph @libstempo    #cite(<libstempo>)', '#emph[libstempo] #cite(<libstempo>)'),
        ('#emph @matplotlib    #cite(<matplotlib>)', '#emph[matplotlib] #cite(<matplotlib>)'),
        ('In we established', 'In @abb-20 we established'),
        ('and . In models', 'and @aaa-23_noise. In models'),
        ('Following , we fit', 'Following @abb-20, we fit'),
        ('App.@sec:bayesapp More', 'App.@sec:bayesapp. More'),
    ],
    '2306.16227': [
        ('many studies      In particular',
         'many studies, e.g., @2011ApJ...732L..26P, @2012ApJ...749..147K, '
         '@2016ApJ...828...73K, @2021MNRAS.502.4794N and @2022mnras.511.4753g. In particular'),
    ],
}

brk = re.compile(r'\\\[([^\[\]\n]{1,60})\\\]')
bibcode = re.compile(r'^\d{4}[A-Za-z&.]{3,}$')
keyish = re.compile(r'^[A-Za-z][A-Za-z0-9_.:+\-]*$')

report = {}
for paper in sorted(os.listdir(ROOT)):
    path = os.path.join(ROOT, paper, 'main.typ')
    if not os.path.exists(path):
        continue
    s = open(path, encoding='utf-8').read()
    orig = s
    stats = []
    n_sec = 0
    s2, n_sec = secdup.subn('', s)
    s = s2
    for old, new in targeted.get(paper, []):
        c = s.count(old)
        if c:
            s = s.replace(old, new)
            stats.append('targeted x%d' % c)
        else:
            stats.append('MISS %r' % old[:30])
    n_br = 0
    if paper == '2306.16227':
        keys = load_keys(paper)
        def repl(m):
            k = m.group(1).strip()
            lk = k.lower()
            if lk in keys:
                return '@' + keys[lk]
            if bibcode.match(k):
                return ''
            return m.group(0)
        s, n_br = brk.subn(repl, s)
    if s != orig:
        backup(path, 'pre_batch3')
        open(path, 'w', encoding='utf-8', newline='').write(s)
    report[paper] = 'secdup=%d brackets=%d %s' % (n_sec, n_br, ' '.join(stats))

for k, v in report.items():
    print(k, v)
