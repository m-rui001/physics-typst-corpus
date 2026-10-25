import glob
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)
pat = re.compile(BS + BS)
for p in sorted(glob.glob("papers/*/main.typ")):
    s = open(p, encoding="utf-8").read()
    ms = list(pat.finditer(s))
    if not ms:
        continue
    kinds = {}
    for m in ms:
        nxt = s[m.end():m.end() + 3]
        kinds[nxt[:2]] = kinds.get(nxt[:2], 0) + 1
    print(p, len(ms), sorted(kinds.items(), key=lambda x: -x[1])[:8])
