import re, glob, sys
p = sys.argv[1] if len(sys.argv) > 1 else 'papers/2209.06202'
tex = open(p + '/src/main.tex', encoding='utf-8', errors='replace').read()
keys = set()
for m in re.finditer(r'\\cite[a-zA-Z]*\*?(?:\[[^\]]*\])*\{([^}]*)\}', tex, re.S):
    for k in m.group(1).split(','):
        k = k.strip()
        if k:
            keys.add(k)
bibs = ''.join(open(f, encoding='utf-8', errors='replace').read()
               for f in glob.glob(p + '/refs*.bib') + glob.glob(p + '/src/*.bib'))
bkeys = set(re.findall(r'@\w+\s*\{\s*([^,\s]+)', bibs))
miss = sorted(keys - bkeys)
print('tex cites', len(keys), 'bib keys', len(bkeys), 'missing', len(miss))
print(miss[:40])
