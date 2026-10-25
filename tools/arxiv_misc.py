import re, sys
p = sys.argv[1]
t = open(p, encoding='utf-8').read()
ent = re.compile(r'@misc\{([^,\n]+),\n((?:(?!\n@).)*?)\n\}', re.S)
n = 0
def fix(m):
    global n
    key, body = m.group(1), m.group(2)
    e = re.search(r'eprint = \{([^}]*)\}', body)
    if not e:
        return m.group(0)
    eid = e.group(1)
    lines = [ln.rstrip(',') for ln in body.split('\n')]
    lines = [ln for ln in lines if not re.match(r'\s*(eprint|archiveprefix|journal)\s*=', ln)]
    lines.append('  journal = {arXiv preprint arXiv:%s},' % eid)
    n += 1
    return '@article{%s,\n%s\n}' % (key, ',\n'.join(lines))
t = ent.sub(fix, t)
open(p, 'w', encoding='utf-8').write(t)
print('arxiv converted', n)
