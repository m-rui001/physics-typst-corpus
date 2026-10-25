import re, glob, shutil
words = ("The This These It We In For However Here There While Although Since Thus Therefore "
         "Furthermore Moreover Finally First Second To By On At If Because Such Our Their Its "
         "Both Each Most Many Some All After Before During With Without From When Where Which What As").split()
wset = set(words)
pat = re.compile(r"(#ref\(<[^<>]+>(?:,\s*supplement:\s*\[[^\]]*\])?\)|@[^\s]+?)( +)(\w+)")

def fix(m):
    if m.group(1)[-1] in ".,:;)]?" or m.group(3) not in wset:
        return m.group(0)
    return m.group(1) + ". " + m.group(3)

tot = 0
for p in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    s = open(p, encoding="utf-8", errors="replace").read()
    s2, n = pat.subn(fix, s)
    if n:
        shutil.copyfile(p, p.replace("main.typ", "_work/main.pre_periods.typ"))
        open(p, "w", encoding="utf-8", newline="\n").write(s2)
        print(n, p)
        tot += n
print("total", tot)
