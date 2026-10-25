import glob
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)
pat = re.compile(re.escape(BS + BS))
for p in sorted(glob.glob("papers/*/main.typ")):
    s = open(p, encoding="utf-8").read()
    ms = list(pat.finditer(s))
    if not ms:
        continue
    kinds = {}
    for m in ms:
        nxt = s[m.end():m.end() + 2]
        kinds[nxt] = kinds.get(nxt, 0) + 1
    print(p, len(ms), sorted(kinds.items(), key=lambda x: -x[1])[:10])
