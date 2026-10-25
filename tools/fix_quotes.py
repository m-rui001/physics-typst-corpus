import sys, os
for path in sys.argv[1:]:
    t = open(path, encoding='utf-8').read()
    if '``' not in t:
        continue
    bak = path + '.prequote'
    if not os.path.exists(bak):
        open(bak, 'w', encoding='utf-8').write(t)
    t = t.replace('``', '\u201c').replace("''", '\u201d')
    open(path, 'w', encoding='utf-8').write(t)
    print(path, 'ok')
