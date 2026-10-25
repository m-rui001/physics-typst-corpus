import glob, os, sys

for d in sys.argv[1:]:
    f = os.path.join(d, 'main.typ')
    s = open(f, encoding='utf-8').read()
    for line in s.split('\n'):
        if len(line) < 200:
            continue
        for i in range(0, min(len(line) - 120, 3000), 100):
            seg = line[i:i + 90]
            if seg.count(' ') < 8:
                continue
            n = line.count(seg)
            if n > 1:
                print('==', d, 'x%d' % n, repr(seg))
                j = line.find(seg, line.find(seg) + 1)
                print('   second at', j, repr(line[j:j + 120]))
                break
