import glob, re, sys
from collections import Counter
pat = re.compile(r"\\[A-Za-z]+")
total = 0
for f in sorted(glob.glob("papers/*/main.typ")):
    hits = []
    for i, l in enumerate(open(f, encoding="utf-8"), 1):
        for m in pat.finditer(l):
            hits.append((i, m.group(0), l.strip()[:100]))
    if hits:
        total += len(hits)
        print(f, len(hits), Counter(h[1] for h in hits).most_common(6))
        for h in hits[:6]:
            print("   ", h)
print("TOTAL", total)
