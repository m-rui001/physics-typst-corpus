import glob, re

print("=== multi-space inside math (possible lost commas) ===")
for f in sorted(glob.glob("papers/*/main.typ")):
    text = open(f, encoding="utf-8").read()
    # collect math spans crudely
    spans = re.findall(r"\$[^$]{1,4000}\$", text)
    hits = []
    for sp in spans:
        for m in re.finditer(r"([A-Za-z0-9\)\]\}\'’])( {3,})([A-Za-z0-9\(\[\{\\\\'’])", sp):
            hits.append((sp[max(0,m.start()-40):m.end()+40].replace("\n"," "),))
    if hits:
        print(f, len(hits))
        for h in hits[:3]:
            print("   ", h[0])

print()
print("=== bare 'Section'/'Sec.' with no ref ===")
pat = re.compile(r"\b(?:Section|Sec\.)\s+(?![~@#\[])([A-Z][a-z]+)")
for f in sorted(glob.glob("papers/*/main.typ")):
    lines = open(f, encoding="utf-8").read().split("\n")
    hits = [(i+1, pat.search(l).group(0)) for i, l in enumerate(lines) if pat.search(l)]
    if hits:
        print(f, len(hits), hits[:6])
