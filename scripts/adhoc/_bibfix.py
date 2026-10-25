import sys

sys.stdout.reconfigure(encoding="utf-8")

fixes = {
    "papers/2106.16243/refs.bib": [
        ('author = "S. Agostinelli and others"}\n}',
         'author = "S. Agostinelli and others"\n}'),
        ('author = "J. Allison and others"}\n}',
         'author = "J. Allison and others"\n}'),
        ('Vacuum ultraviolet, Scintillation}}\n}',
         'Vacuum ultraviolet, Scintillation}\n}'),
    ],
    "papers/2206.11528/refs.bib": [
        ('Elisa Ercolessi},\n},\n  \n\tjournal = {Quantum}\n}',
         'Elisa Ercolessi},\n  journal = {Quantum}\n}'),
    ],
}

for path, pairs in fixes.items():
    s = open(path, encoding="utf-8").read()
    for old, new in pairs:
        n = s.count(old)
        assert n == 1, (path, n, old[:50])
        s = s.replace(old, new)
    open(path, "w", encoding="utf-8", newline="").write(s)
    print(path, "balance", s.count("{") - s.count("}"))
