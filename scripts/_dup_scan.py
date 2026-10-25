import glob, re, os

for f in sorted(glob.glob('papers/2*/main.typ')):
    s = open(f, encoding='utf-8').read()
    # look for a long phrase repeated inside one paragraph line
    worst = 0
    for line in s.split('\n'):
        if len(line) < 200:
            continue
        # sample: check whether the first 100 chars of a 200-char window repeat later
        for i in range(0, min(len(line) - 120, 3000), 100):
            seg = line[i:i + 90]
            if len(seg) < 90 or seg.count(' ') < 8:
                continue
            if line.count(seg) > 1:
                worst = max(worst, len(seg))
                break
    if worst:
        print(os.path.basename(os.path.dirname(f)), 'dup phrase len', worst)
