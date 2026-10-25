import re

p = 'papers/2308.08546/main.typ'
s = open(p, encoding='utf-8').read()

keys = {}
for m in re.finditer(r'<eq:[^<>]+>', s):
    key = m.group(0)
    before = s[max(0, m.start() - 8):m.start()]
    attached = before.rstrip().endswith('$')
    keys.setdefault(key, []).append(attached)

for k, v in keys.items():
    print(k, 'total', len(v), 'attached', sum(v))
