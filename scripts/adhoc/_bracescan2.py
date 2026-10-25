import glob, re, sys
sys.stdout.reconfigure(encoding="utf-8")
pats = {
    "sub-brace": re.compile(r"[_^]\{"),
    "esc-sub-brace": re.compile(r"\\[_^]\{"),
    'quote-brace': re.compile(r'\{"'),
}
for p in sorted(glob.glob("papers/*/main.typ")):
    s = open(p, encoding="utf-8").read()
    out = []
    for name, pat in pats.items():
        for m in pat.finditer(s):
            i = m.start()
            line = s.count(chr(10), 0, i) + 1
            frag = s[max(0, i-40):i+50].replace(chr(10), " ")
            out.append((line, name, frag))
    if out:
        print("=== %s %d" % (p, len(out)))
        seen = set()
        for line, name, frag in out[:14]:
            print("  L%-5d %-13s %s" % (line, name, frag))
