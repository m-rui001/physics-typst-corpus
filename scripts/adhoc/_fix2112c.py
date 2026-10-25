import os
p = r"E:\phys\papers\2112.03708\main.typ"
s = open(p, encoding="utf-8").read(); orig = s
pairs = [
    (r"$overline(T_2^(*)) = 37.5 $µs", r"$overline(T_2^(*)) = 37.5$ µs"),
    (r"$2 overline(T_1) = 65.0 $µs", r"$2 overline(T_1) = 65.0$ µs"),
    (r"approximately $26 $µs", r"approximately $26$ µs"),
    (r"data set in @fig:state_preservation Equivalently",
     r'data set in #panel(<fig:state_preservation>, "c"). Equivalently'),
]
for old, new in pairs:
    n = s.count(old)
    if n == 0 and new in s:
        continue
    assert n == 1, "found %d for %r" % (n, old)
    s = s.replace(old, new)
if s != orig:
    bak = p + ".preunits"
    if not os.path.exists(bak):
        open(bak, "w", encoding="utf-8").write(orig)
    open(p, "w", encoding="utf-8").write(s)
    print("patched")
