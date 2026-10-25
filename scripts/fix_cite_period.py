import os, re, shutil

ROOT = 'E:/phys/papers'
pat = re.compile(r'(#cite\(<[^>]+>\)|@[A-Za-z0-9_:+-][A-Za-z0-9_.:+-]*)([ \t]+)([A-Z][a-z])')

total = 0
for paper in sorted(os.listdir(ROOT)):
    path = os.path.join(ROOT, paper, 'main.typ')
    if not os.path.exists(path):
        continue
    s = open(path, encoding='utf-8').read()
    n = 0
    def repl(m):
        global n
        tok = m.group(1)
        if tok.endswith('.'):
            return m.group(0)
        n += 1
        return tok + '. ' + m.group(2)[1:] + m.group(3) if len(m.group(2)) > 1 else tok + '. ' + m.group(3)
    out = pat.sub(repl, s)
    if n:
        b = path + '.preciteperiod'
        if not os.path.exists(b):
            shutil.copy2(path, b)
        open(path, 'w', encoding='utf-8', newline='').write(out)
        print(paper, n)
    total += n
print('TOTAL', total)
