import re, pathlib

for f in sorted(pathlib.Path(r"E:\phys\papers").glob("*/main.typ")):
    s = f.read_text(encoding="utf-8")
    hits = []
    for m in re.finditer(r"\$([^$\n]+)\$", s):
        body = m.group(1)
        if "   " in body:
            for mm in re.finditer(r"\S {3,}\S", body):
                hits.append((s[: m.start()].count("\n") + 1, mm.group(0)))
    if hits:
        print(f.parent.name, len(hits), hits[:4])
