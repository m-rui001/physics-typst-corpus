import io
p = r"papers/2312.03982/main.typ"
s = io.open(p, encoding="utf-8").read()
s = s.replace('#set math.equation(numbering: "(1)", supplement: [Eq.])',
              '#set math.equation(numbering: none)', 1)
n = 0
for old in ('& forall i = 1, dots, N \\',
            '& forall j = 1, dots, M \\',
            '& forall i = 1, dots, N $'):
    new = old.replace('& ', '& #h(-30pt) ', 1)
    if old in s:
        s = s.replace(old, new, 1)
        n += 1
io.open(p, "w", encoding="utf-8").write(s)
print("h", n, "numbering", 'numbering: none' in s)
