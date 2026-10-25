import glob, sys
sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)

def math_spans(s):
    spans = []
    i = 0
    n = len(s)
    while i < n:
        if s[i] == "$" and (i == 0 or s[i-1] != BS):
            j = i + 1
            while j < n:
                if s[j] == "$" and s[j-1] != BS:
                    break
                j += 1
            if j < n:
                spans.append((i+1, j, s[i+1:j]))
            i = j + 1
        else:
            i += 1
    return spans

tot = 0
for p in sorted(glob.glob("papers/*/main.typ")):
    s = open(p, encoding="utf-8").read()
    hits = []
    for a, b, m in math_spans(s):
        if "{" in m or "}" in m:
            hits.append((a, m))
    if hits:
        print("=== %s  %d math spans with braces" % (p, len(hits)))
        tot += len(hits)
        for a, m in hits[:4]:
            line = s.count(chr(10), 0, a) + 1
            print("  L%d: %s" % (line, m[:100].replace(chr(10), " ")))
print("total", tot)
