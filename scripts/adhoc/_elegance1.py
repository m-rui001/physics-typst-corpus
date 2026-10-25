import glob, os, re

p1 = re.compile(r'_\s*\(\s*upright\("([^"]*)"\)\s*\)')
p2 = re.compile(r'\^\s*\(\s*upright\("([^"]*)"\)\s*\)')
p3 = re.compile(r'upright\("([^"]*)"\)')

total = 0
changed = 0
for path in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    s = open(path, encoding="utf-8").read()
    orig = s
    s, n1 = p1.subn(lambda m: '_"%s"' % m.group(1), s)
    s, n2 = p2.subn(lambda m: '^"%s"' % m.group(1), s)
    s, n3 = p3.subn(lambda m: '"%s"' % m.group(1), s)
    n = n1 + n2 + n3
    if s != orig:
        bak = path + ".preeleg"
        if not os.path.exists(bak):
            open(bak, "w", encoding="utf-8").write(orig)
        open(path, "w", encoding="utf-8").write(s)
        changed += 1
        total += n
        print(os.path.basename(os.path.dirname(path)), n1, n2, n3)
print("files", changed, "replacements", total)
