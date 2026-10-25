import re, glob
words = ("The This These It We In For However Here There While Although Since Thus Therefore "
         "Furthermore Moreover Finally First Second To By On At If Because Such Our Their Its "
         "Both Each Most Many Some All After Before During With Without From When Where Which What "
         "As").split()
wset = set(words)
pat = re.compile(r"(#ref\(<[^<>]+>(?:,\s*supplement:\s*\[[^\]]*\])?\)|@[^\s]+?)( +)(\w+)")
tot = 0
for p in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    s = open(p, encoding="utf-8", errors="replace").read()
    hits = []
    for m in pat.finditer(s):
        if m.group(1)[-1] in ".,:;)]" or m.group(3) not in wset:
            continue
        hits.append(m)
    if hits:
        print("==", p.split("\\")[-2], len(hits))
        for m in hits[:6]:
            print("   ", repr(s[max(0, m.start()-30):m.end()+10]))
        tot += len(hits)
print("TOTAL", tot)
