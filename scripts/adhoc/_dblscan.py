import sys, io
ids = ["2102.01111","2111.14241","2112.03708","2202.02773","2204.12771","2207.06431","2301.10937"]
BS = chr(92)
DBL = BS + BS
for pid in ids:
    p = "papers/%s/main.typ" % pid
    s = open(p, encoding="utf-8").read()
    hits = []
    i = 0
    while True:
        i = s.find(DBL, i)
        if i < 0: break
        hits.append(i)
        i += 2
    print("=== %s  count=%d" % (pid, len(hits)))
    for i in hits:
        line = s.count(chr(10), 0, i) + 1
        a = max(0, i - 55); b = min(len(s), i + 55)
        frag = s[a:b].replace(chr(10), " <NL> ")
        print("  L%d: ...%s..." % (line, frag))
