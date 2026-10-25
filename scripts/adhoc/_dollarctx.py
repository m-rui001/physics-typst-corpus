import re
p = r"E:\phys\papers\2111.14241\refs_body.typ"
s = open(p, encoding="utf-8").read()
for pat in [r"\\\$PT\\\$", r"\\\$pt/Hz\\\$", r"\\\$m\\_a=58ev\\\$", r"\\\$CP\\\$"]:
    for m in re.finditer(pat, s):
        a = max(0, m.start()-120); b = min(len(s), m.end()+60)
        print(repr(s[a:b]))
        print("---")
