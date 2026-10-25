import re, io, os
os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'src'))
BS = chr(92)
bib = io.open('frbrev2.bib', encoding='utf-8', errors='replace').read()
pats = [BS + r'[' + BS + r']?[a-zA-Z]{1,2}[{]?[a-zA-Z]?[}]?[}]?', ]
# find all sequences starting with a backslash plus following 12 chars
for m in sorted(set(re.findall(BS + r'[a-zA-Z]{1,2}[^a-zA-Z]{0,4}', bib))):
    print(repr(m))
