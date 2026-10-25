import os, re, shutil

ROOT = 'E:/phys/papers'
pat = re.compile(
    r'(?<!ED )(?<!Extended Data )\b(?i:Figure|Figs\.|Fig\.|Table|Tabs\.|Tab\.|Equation|Eqs\.|Eq\.)'
    r'[~ ]+(?=@(?:fig|tab|eq)\b|#ref\(<(?:fig|tab|eq))')

total = 0
for paper in sorted(os.listdir(ROOT)):
    path = os.path.join(ROOT, paper, 'main.typ')
    if not os.path.exists(path):
        continue
    s = open(path, encoding='utf-8').read()
    out, n = pat.subn('', s)
    if n:
        b = path + '.prelabeldup'
        if not os.path.exists(b):
            shutil.copy2(path, b)
        open(path, 'w', encoding='utf-8', newline='').write(out)
        print(paper, n)
    total += n
print('TOTAL', total)
