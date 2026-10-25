import re, io, os
os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'src'))
bib = io.open('frbrev2.bib', encoding='utf-8', errors='replace').read()
BS = chr(92)
seq = re.compile(BS + BS + '|' + BS + r'[a-zA-Z]+|' + BS + r'.')
for line in bib.split('\n'):
    s = line.strip()
    if (s.startswith('author') or s.startswith('title')) and BS in s:
        print(sorted(set(m.group(0) for m in seq.finditer(s))), '|', s[:110])
