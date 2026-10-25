import glob, io, os, re, pymupdf
from collections import Counter

def words(t):
    t = re.sub(r'\s+', ' ', t)
    return Counter(re.findall(r'[A-Za-z]{4,}', t))

bad = 0
for pdf in sorted(glob.glob(r'E:\phys\papers\*\main.pdf')):
    pid = os.path.basename(os.path.dirname(pdf))
    base = io.open(r'E:\phys\_t\txtcmp\%s.txt' % pid, encoding='utf-8').read()
    cur = ''.join(p.get_text() for p in pymupdf.open(pdf))
    a, b = words(base), words(cur)
    miss, extra = a - b, b - a
    if sum(miss.values()) + sum(extra.values()) > 40:
        bad += 1
        print(pid, 'missing', sum(miss.values()), miss.most_common(5))
        print('   extra', sum(extra.values()), extra.most_common(5))
print('papers with >40 word delta:', bad)
