import re, sys
p = r"E:\phys\papers\2111.14241\refs_body.typ"
s = open(p, encoding="utf-8").read()
n = 0
for m in re.finditer(r"\\\$(.{0,80}?)\\\$", s):
    print(repr(m.group(0)))
    n += 1
print("count", n)
