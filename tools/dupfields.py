import re, glob, os
ent = re.compile(r'@(\w+)\{([^,\n]+),\n((?:(?!\n@).)*?)\n\}', re.S)
for p in sorted(glob.glob('papers/*/refs.bib')):
    t = open(p, encoding='utf-8').read()
    bad = []
    for m in ent.finditer(t):
        names = re.findall(r'^\s*(\w+)\s*=', m.group(3), re.M)
        dup = sorted({n for n in names if names.count(n) > 1})
        if dup:
            bad.append((m.group(2), dup))
    if bad:
        print(os.path.basename(os.path.dirname(p)), len(bad), bad[:5])
