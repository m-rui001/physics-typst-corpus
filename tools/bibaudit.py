import re, sys
B = chr(92)
path = sys.argv[1]
t = open(path, encoding='utf-8', errors='replace').read()
ents = re.findall(r'@(\w+)\{([^,]+),(.*?)\n\}', t, re.S)
print('entries', len(ents))
types = {}
bad = []
for typ, key, body in ents:
    types[typ] = types.get(typ, 0) + 1
    f = dict(re.findall(r'\n\s*(\w+)\s*=\s*\{(.*)\},', body))
    if not f.get('author'):
        bad.append((key, 'no-author'))
    if not f.get('journal') and not f.get('title') and not f.get('booktitle'):
        bad.append((key, 'no-journal-title', body[:80]))
print(types)
print('suspect', len(bad))
for b in bad[:40]:
    print(b)
