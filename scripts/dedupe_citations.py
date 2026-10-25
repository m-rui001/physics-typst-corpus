import os, re, shutil

ROOT = 'E:/phys/papers'
TOK = re.compile(r'#cite\(<([^>]+)>\)|@([A-Za-z0-9_:+-][A-Za-z0-9_.:+-]*)')
GAP = re.compile(r'^[~ \t]*(?:[,.;])?[~ \t]*$')

def run_dedup(s):
    toks = list(TOK.finditer(s))
    edits = []
    i = 0
    while i < len(toks):
        j = i + 1
        while j < len(toks):
            gap = s[toks[j-1].end():toks[j].start()]
            if '\n' in gap.replace('\t', '') or not GAP.match(gap):
                break
            j += 1
        run = toks[i:j]
        if len(run) >= 2:
            keys = [(m.group(1) or m.group(2)) for m in run]
            if len(set(keys)) < len(keys):
                parts = [run[0].group(0)]
                seen = {keys[0]}
                changed = False
                for k in range(1, len(run)):
                    gap = s[run[k-1].end():run[k].start()]
                    if keys[k] in seen:
                        changed = True
                        continue
                    seen.add(keys[k])
                    if '.' in gap or ';' in gap:
                        gap = ', '
                    parts.append(gap + run[k].group(0))
                if changed:
                    edits.append((run[0].start(), run[-1].end(), ''.join(parts)))
        i = j
    for a, b, r in reversed(edits):
        s = s[:a] + r + s[b:]
    return s, len(edits)

total = 0
for paper in sorted(os.listdir(ROOT)):
    path = os.path.join(ROOT, paper, 'main.typ')
    if not os.path.exists(path):
        continue
    s = open(path, encoding='utf-8').read()
    out, n = run_dedup(s)
    if n:
        b = path + '.precitededupe'
        if not os.path.exists(b):
            shutil.copy2(path, b)
        open(path, 'w', encoding='utf-8', newline='').write(out)
        print(paper, n)
    total += n
print('TOTAL', total)
