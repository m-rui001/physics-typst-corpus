import glob, io, re, sys, shutil

APPLY = 'apply' in sys.argv
pat = re.compile(r'([_^])\s*"([^"\n]*)"\(')

files = sorted(glob.glob(r'E:\phys\papers\*\*.typ'))
tot = 0
for f in files:
    s = io.open(f, encoding='utf-8').read()
    out_lines = []
    n = 0
    for line in s.split('\n'):
        if line.lstrip().startswith('//'):
            out_lines.append(line)
            continue
        def rep(m):
            return '%s("%s")(' % (m.group(1), m.group(2))
        nl, k = pat.subn(rep, line)
        if k:
            n += k
            print('%s:%s' % (f.split('\\')[-2], k))
        out_lines.append(nl)
    if n:
        tot += n
        if APPLY:
            shutil.copyfile(f, f + '.precall')
            io.open(f, 'w', encoding='utf-8', newline='\n').write('\n'.join(out_lines))
print('total', tot)
