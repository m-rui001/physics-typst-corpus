import glob, io, os
for f in sorted(glob.glob(r'E:\phys\papers\*\main.typ')):
    L = io.open(f, encoding='utf-8').read().split('\n')
    hits = [(i+1, l) for i, l in enumerate(L) if l.strip() in ('.', ',', ';')]
    if hits:
        print(os.path.basename(os.path.dirname(f)), hits[:6])
