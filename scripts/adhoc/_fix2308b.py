import os
p = r"E:\phys\papers\2308.07915\main.typ"
s = open(p, encoding="utf-8").read(); orig = s
pairs = [
    (r'$v {in} "FF"_2^n$', r'$v in bb(F)_2^n$', 3),
    (r'see . Here', r'see #ref(<lem:kd>). Here', 1),
    (r'\ sans("rs") \( H^Z \)', r'without sans("rs")(H^Z)', 1),
    (r'$"FF"_2=\(0,1\)$', r'$bb(F)_2 = (0,1)$', 1),
    (r'sans("QC") \( A , B \)', r'sans("QC")(A,B)', 2),
]
for item in pairs:
    old, new = item[0], item[1]
    n = s.count(old)
    if n == 0 and new in s:
        continue
    assert n >= 1, "missing %r" % old
    s = s.replace(old, new)
if s != orig:
    bak = p + ".pre2308b"
    if not os.path.exists(bak):
        open(bak, "w", encoding="utf-8").write(orig)
    open(p, "w", encoding="utf-8").write(s)
    print("patched")
