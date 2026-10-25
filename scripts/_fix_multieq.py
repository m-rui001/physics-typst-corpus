import re, sys

p = sys.argv[1] + '/main.typ'
s = open(p, encoding='utf-8').read()
labels = set(re.findall(r'<eq:([^<>]+)>', s))
pat = re.compile(r'\[\s*\\?\[?\s*((?:eq:[A-Za-z0-9_\\-]+)(?:\s*,\s*eq:[A-Za-z0-9_\\-]+)+)\s*\\?\]?\s*\]')


def repl(m):
    keys = [k.strip().replace('\\_', '_').rstrip('\\') for k in m.group(1).split(',')]
    if all(k.split(':', 1)[1] in labels for k in keys):
        return ', '.join('@' + k for k in keys)
    print('MISSING', keys)
    return m.group(0)


s, n = pat.subn(repl, s)
open(p, 'w', encoding='utf-8').write(s)
print('multi refs', n)
