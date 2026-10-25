import os

def patch(path, pairs):
    s = open(path, encoding="utf-8").read(); orig = s
    for old, new in pairs:
        n = s.count(old)
        if n == 0 and new in s:
            continue
        assert n >= 1, "missing %r" % old
        s = s.replace(old, new)
    if s != orig:
        bak = path + ".prebraces"
        if not os.path.exists(bak):
            open(bak, "w", encoding="utf-8").write(orig)
        open(path, "w", encoding="utf-8").write(s)
        print("patched", path)

patch(r"E:\phys\papers\2104.04119\main.typ", [
    (r"sum_{i < j}", r"sum_(i < j)"),
    (r"product_{i in S}", r"product_(i in S)"),
    (r"sum_{i in cal(D)}", r"sum_(i in cal(D))"),
])

Q = '"'
patch(r"E:\phys\papers\2207.06431\main.typ", [
    (r'$s={"q"}2\_5({"Z"})$', r'$s = "q2_5(Z)"$'),
    (r'$s={"q"}5\_4$', r'$s = "q5_4"$'),
    ("$s\\'={" + Q + "q" + Q + "}5\\_6$", "$s' = " + Q + "q5_6" + Q + "$"),
])
