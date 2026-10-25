import io, re, json

src = io.open(r'papers/2104.07036/src/Completeness-v2.tex', encoding='utf-8').read()
typ = io.open(r'papers/2104.07036/main.typ', encoding='utf-8').read()

def norm(s):
    return re.sub(r'[^A-Za-z0-9]', '', s)

ns = []
idx = []
for i, ch in enumerate(src):
    if ch.isalnum() and ord(ch) < 128:
        ns.append(ch); idx.append(i)
ns = ''.join(ns)

B = chr(92)
def find_cmd(pos):
    pre = typ[max(0, pos - 120):pos]
    npre = norm(pre)[-28:]
    p = ns.find(npre)
    while p < 0 and len(npre) > 12:
        npre = npre[2:]
        p = ns.find(npre)
    if p < 0:
        return None, None, pre[-60:]
    orig = idx[p + len(npre) - 1] + 1
    tail = src[orig:orig + 300]
    first = 9999; kind = None; val = None
    for kindpat, kindname in ((B+B + r'cite[a-z]*\*?(?:\[[^\]]*\])?\{([^{}]*)\}', 'cite'),
                              (B+B + r'eqref\{([^{}]*)\}', 'eqref'),
                              (B+B + r'ref\{([^{}]*)\}', 'ref')):
        mm = re.search(kindpat, tail)
        if mm and mm.start() < first:
            first = mm.start(); kind = kindname; val = mm.group(1)
    return kind, val, tail[:60].replace('\n', ' ')

holes = [(m.start(), m.end()) for m in re.finditer(r'#text\(\[\]\)', typ)]
runs = []
for s, e in holes:
    if runs and not typ[runs[-1][1]:s].strip():
        runs[-1] = (runs[-1][0], e)
    else:
        runs.append((s, e))

out = []
for s, e in runs:
    kind, val, tail = find_cmd(s)
    out.append({'start': s, 'end': e, 'line': typ.count('\n', 0, s) + 1,
                'kind': kind, 'val': val, 'tail': tail,
                'ctx': typ[max(0, s-70):s][-70:]})
json.dump(out, open(r'scripts/holes2104.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
for o in out:
    print(o['line'], o['kind'] or 'NONE', (o['val'] or '')[:60], '|', o['ctx'][-50:].replace('\n', ' '))
print('runs', len(out), 'holes', len(holes))
