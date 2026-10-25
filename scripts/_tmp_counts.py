import re
s = open(r"E:\phys\papers\2203.02139\main.typ", encoding="utf-8").read().split("\n")
for i in (25, 29, 33, 53, 55, 59, 111, 116, 118):
    l = s[i-1]
    print(i, "@count", len(re.findall(r"@[A-Za-z]", l)), "holes", l.count("#text([])"))
