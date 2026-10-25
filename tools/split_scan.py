import re, io, glob, os

rows = []
for f in sorted(glob.glob("papers/*/main.typ")):
    s = io.open(f, encoding="utf-8", errors="ignore").read()
    paras = s.split("\n\n")
    hits = []
    for i in range(len(paras) - 1):
        a = paras[i].strip()
        b = paras[i + 1].strip()
        if not a or not b:
            continue
        if a[0] in "#=$-<>" or b[0] in "#=$-<>":
            continue
        ma = re.search(r"([A-Za-z]{2,})$", a)
        mb = re.match(r"([a-z]{1,6})\b", b)
        if ma and mb and a[-1].islower() and b[0].islower():
            hits.append((ma.group(1), mb.group(1), re.sub(r"\s+", " ", a[-50:])))
    if hits:
        rows.append((len(hits), os.path.basename(os.path.dirname(f)), hits))

for n, pid, hits in sorted(rows, reverse=True):
    print(f"{pid}: {n}")
    for w1, w2, tail in hits[:4]:
        print(f"    split? ...{tail}  ||  {w2}...")
