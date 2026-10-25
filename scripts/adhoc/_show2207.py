p = r"E:\phys\papers\2207.06431\main.typ"
s = open(p, encoding="utf-8").read()
for key in ['s={"q"}2', 's={"q"}5']:
    i = s.find(key)
    while i >= 0:
        print(repr(s[i-60:i+90]))
        i = s.find(key, i+1)
