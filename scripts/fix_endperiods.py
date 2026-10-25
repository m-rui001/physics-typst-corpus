import re, glob, shutil
pat = re.compile(r"(@[A-Za-z0-9][\w:.\-]*|#ref\(<[^<>]+>(?:,\s*supplement:\s*\[[^\]]*\])?\))$")
tot = nfiles = 0
for p in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    lines = open(p, encoding="utf-8", errors="replace").read().split("\n")
    changed = 0
    for i, l in enumerate(lines):
        nxt = lines[i + 1] if i + 1 < len(lines) else ""
        if not l or l[0].isspace() or len(l) < 80 or nxt.strip() != "":
            continue
        if l.strip().startswith("#") or "\\@" in l:
            continue
        m = pat.search(l)
        if not m:
            continue
        tok = m.group(1)
        if tok[-1] in ".,:;?!":
            continue
        lines[i] = l + "."
        changed += 1
    if changed:
        shutil.copyfile(p, p.replace("main.typ", "_work/main.pre_endperiods.typ"))
        open(p, "w", encoding="utf-8", newline="\n").write("\n".join(lines))
        print(changed, p)
        tot += changed; nfiles += 1
print("total", tot, "files", nfiles)
