import re, sys

BS = chr(92)


def convert(f):
    s = open(f, encoding="utf-8").read()
    if re.search(r'^=+ ', s, re.M):
        return None
    pat = re.compile(r'#heading\(level: (\d+), numbering: none\)\[')
    out, i, n = [], 0, 0
    while True:
        m = pat.search(s, i)
        if not m:
            break
        lvl = int(m.group(1))
        j, depth = m.end(), 1
        while j < len(s) and depth:
            c = s[j]
            if c == BS:
                j += 2
                continue
            if c == '[':
                depth += 1
            elif c == ']':
                depth -= 1
            j += 1
        out.append(s[i:m.start()])
        out.append('=' * lvl + ' ' + s[m.end():j - 1])
        n += 1
        i = j
    out.append(s[i:])
    s2 = ''.join(out).replace('#set heading(numbering: "1.1")',
                              '#set heading(numbering: none)', 1)
    open(f, "w", encoding="utf-8").write(s2)
    return n


for p in sys.argv[1:]:
    print(p, convert(f"papers/{p}/main.typ"))
