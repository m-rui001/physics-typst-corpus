import re, io, os
os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'src'))
BS = chr(92)
tex = io.open('article_springer.tex', encoding='utf-8', errors='replace').read()
tex = re.sub(BS + '%.*', '', tex)
tex = re.sub(r'\\begin\{comment\}.*?\\end\{comment\}', '', tex, flags=re.S)
CITE = re.compile(r'\\(?:text|nocite|parens|brackets|autocite)?cite[a-zA-Z]*'
                  + r'(?:\[[^\]\n]*\])?\{([^{}]+)\}')
cited = set()
for m in CITE.finditer(tex):
    for k in m.group(1).split(','):
        k = k.strip()
        if k:
            cited.add(k)
bib = io.open('frbrev2.bib', encoding='utf-8', errors='replace').read()
bibkeys = set(re.findall(r'(?m)^\s*@[a-zA-Z]+\s*\{\s*([^,\s]+)\s*,', bib))
bbl = io.open('article_springer.bbl', encoding='utf-8', errors='replace').read()
bblkeys = set(re.findall(r'\\bibitem(?:\[[^\]]*\])?\{([^}]+)\}', bbl))
print("cited in tex:", len(cited))
print("bib keys:", len(bibkeys), "bbl keys:", len(bblkeys))
print("cited NOT in bib:", sorted(cited - bibkeys))
print("cited NOT in bbl:", sorted(cited - bblkeys))
print("bib-only (uncited):", sorted(bibkeys - cited))
print("bbl-only (uncited):", sorted(bblkeys - cited))
