import io, glob, re, os, sys
sys.stdout.reconfigure(encoding='utf-8')
noun = re.compile(r'\b(?:Figs?\.|Figures?|Tabs?\.|Tables?|Eqs?\.|Equations?|Section|Sec\.)\s*~?\s*'
                  r'(?=(?:@\w+|#ref\(<[^>]+>\)))')
tok = re.compile(r'@([\w:.\-]+)|#ref\(<([^>]+)>\)')
total = 0
for p in sorted(glob.glob('papers/*/main.typ')):
    s = io.open(p, encoding='utf-8').read()
    labels = set(re.findall(r'<([^<>\s]+)>', s))
    bibf = os.path.join(os.path.dirname(p), 'refs.bib')
    keys = set()
    if os.path.exists(bibf):
        keys = {k.strip().lower() for k in re.findall(r'@\w+\{\s*([^,\s]+)\s*,', io.open(bibf, encoding='utf-8', errors='ignore').read())}
    out, i, n = [], 0, 0
    for m in noun.finditer(s):
        out.append(s[i:m.start()])
        rest = s[m.end():]
        t = tok.match(rest)
        drop = False
        if t:
            name = (t.group(1) or t.group(2)).strip()
            if t.group(2) is not None:
                drop = True                      # #ref always carries its own supplement
            elif name in labels and name.lower() not in keys:
                drop = True
        if drop:
            i = m.end(); n += 1
        else:
            out.append(m.group(0)); i = m.end()
    out.append(s[i:])
    if n:
        io.open(p + '.prenounref', 'w', encoding='utf-8').write(s)
        io.open(p, 'w', encoding='utf-8').write(''.join(out))
    print(os.path.dirname(p).split(os.sep)[-1], n)
    total += n
print('total', total)
