import re, shutil, sys
p = "papers/2111.14241/main.typ"
mode = sys.argv[1] if len(sys.argv) > 1 else "dry"
s = open(p, encoding="utf-8").read()
pat = re.compile(r"([A-Za-z0-9\)\]\}\'’])( {3,})([A-Za-z0-9\(\[\{\\\\'’])")
count = 0
samples = []

def fix_span(m):
    global count
    sp = m.group(0)
    def r(mm):
        global count
        count += 1
        if len(samples) < 12:
            samples.append(sp[max(0, mm.start() - 25):mm.end() + 25])
        return mm.group(1) + ", " + mm.group(3)
    return pat.sub(r, sp)

new = re.sub(r"\$[^$]{1,4000}\$", fix_span, s)
for x in samples:
    print(repr(x))
print("replacements", new.count(", ") - s.count(", "))
if mode == "write":
    shutil.copy(p, p + ".premathcommas")
    open(p, "w", encoding="utf-8", newline="\n").write(new)
    print("written")
