import io, glob, re, sys
sys.stdout.reconfigure(encoding='utf-8')

eqpat = re.compile(r'\$\s*<([^<>\s]+)>')
pat = re.compile(r'\(@([A-Za-z][A-Za-z0-9:._-]*)\)')
total = 0
for path in sorted(glob.glob('papers/*/main.typ')):
    s = io.open(path, encoding='utf-8').read()
    eqlabs = set(eqpat.findall(s))

    def sub(m):
        global total
        lab = m.group(1)
        if lab in eqlabs or lab.startswith('eq:') or lab.startswith('eqn:'):
            total += 1
            return '(#ref(<%s>, supplement: none))' % lab
        return m.group(0)

    s2 = pat.sub(sub, s)
    if s2 != s:
        io.open(path + '.preparenref', 'w', encoding='utf-8').write(s)
        io.open(path, 'w', encoding='utf-8').write(s2)
        print('rewrote', path)
print('total', total)
