import re, sys
p = sys.argv[1]
t = open(p, encoding='utf-8').read()
ent = re.compile(r'(@\w+\{[^,\n]+,\n)((?:(?!\n@).)*?)(\n\})', re.S)
n = 0
def fix(m):
    global n
    head, body, tail = m.group(1), m.group(2), m.group(3)
    jm = re.search(r'journal = \{([^}]*)\}', body)
    vm = re.search(r'volume = \{([A-Z])(\d+)\}', body)
    if not jm or not vm:
        return m.group(0)
    j = jm.group(1)
    if j not in ('Phys. Rev.', 'Phys. Lett.', 'Nucl. Phys.'):
        return m.group(0)
    nj = j + ' ' + vm.group(1)
    body = body.replace(jm.group(0), 'journal = {%s}' % nj, 1)
    body = body.replace(vm.group(0), 'volume = {%s}' % vm.group(2), 1)
    n += 1
    return head + body + tail
t = ent.sub(fix, t)
open(p, 'w', encoding='utf-8').write(t)
print('split', n)
