import glob, os, re

pat = re.compile(r"[_^]\{")
for p in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    pid = os.path.basename(os.path.dirname(p))
    txt = open(p, encoding="utf-8").read()
    hits = []
    for ln, line in enumerate(txt.splitlines(), 1):
        if line.lstrip().startswith("//"):
            continue
        for m in pat.finditer(line):
            hits.append((ln, line[max(0, m.start()-40):m.start()+45]))
    if hits:
        print("==", pid, len(hits))
        for ln, ctx in hits[:10]:
            print("  L%d %s" % (ln, ctx))
