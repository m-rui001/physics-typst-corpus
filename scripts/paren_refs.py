import io, glob, re, sys
sys.stdout.reconfigure(encoding='utf-8')

# equation labels: <lab> immediately after a closing $ (optionally whitespace/newline)
eqpat = re.compile(r'\$\s*<([^<>\s]+)>')
pat = re.compile(r'\(@([A-Za-z][A-Za-z0-9:._-]*)\)')
for path in sorted(glob.glob('papers/*/main.typ')):
    s = io.open(path, encoding='utf-8').read()
    eqlabs = set(eqpat.findall(s))
    conv, other = [], []
    for m in pat.finditer(s):
        lab = m.group(1)
        if lab in eqlabs or lab.startswith('eq:') or lab.startswith('eqn:'):
            conv.append((m.start(), lab))
        else:
            other.append((m.start(), lab, s[max(0, m.start() - 40):m.end()].replace('\n', ' ')))
    if conv or other:
        print('####', path, 'conv', len(conv), 'other', len(other))
        for p, lab in conv[:5]:
            print('   C', lab)
        for p, lab, ctx in other[:8]:
            print('   O', lab, '|', ctx)
