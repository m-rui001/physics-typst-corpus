import re, io, os
os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'src'))
bib = io.open('frbrev2.bib', encoding='utf-8', errors='replace').read()
# find all field lines containing a backslash, report field name
names = {}
for m in re.finditer(r'([a-zA-Z]+)\s*=\s*[{"](.*?)[}"]\s*,?\s*(?=\n\s*[a-zA-Z]|\n\})', bib, re.S):
    pass
for line in bib.split('\n'):
    if '\\' in line:
        f = line.strip().split('=')[0].strip()
        names[f] = names.get(f, 0) + 1
print(names)
