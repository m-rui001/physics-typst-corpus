import re, os

PAPERS = r"E:\phys\papers"
targets = ["2107.00724", "2207.06431", "2306.16215", "2112.03708"]

def match_close(s, i):
    depth = 0
    while i < len(s):
        c = s[i]
        if c == "\\":
            i += 2
            continue
        if c == "[":
            depth += 1
        elif c == "]":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    raise ValueError("unbalanced")

for pid in targets:
    path = os.path.join(PAPERS, pid, "main.typ")
    s = open(path, encoding="utf-8").read()
    orig = s

    s, n = re.subn(r"(#set page\([^\n]*?), columns: 2\)", r"\1)", s, count=1)
    if n == 0:
        print(pid, "WARN: no page columns:2 removed")

    po = re.search(r"^#place\(top \+ center, scope: \"parent\", float: true\)\[", s, re.M)
    assert po, pid
    ob = s.index("[", po.start())
    cb = match_close(s, ob)

    if pid == "2112.03708":
        # body already wrapped in #columns; remove only the place wrapper
        s = s[:cb] + s[cb + 1:]
        s = s[:po.start()] + s[po.end():]
    else:
        # keep the body columns opener, drop its empty closing bracket
        m = re.search(r"^([ \t]*#columns\(2[^\n]*\)\[)\n[ \t]*\]\n", s[po.start():cb], re.M)
        assert m, (pid, "empty cols not found")
        a = po.start() + m.start()
        s = s[:a] + m.group(1) + "\n" + s[po.start() + m.end():]
        s = s[:po.start()] + s[po.end():]

    open(path, "w", encoding="utf-8").write(s)
    print(pid, "rewritten", len(orig), "->", len(s))
