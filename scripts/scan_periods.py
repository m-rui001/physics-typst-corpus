import re, glob
pat = re.compile(r"(@[A-Za-z0-9][\w:.\-]*|#ref\(<[^<>]+>(?:,\s*supplement:\s*\[[^\]]*\])?\)) +(?=[A-Z][a-z])")
for p in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    s = open(p, encoding="utf-8", errors="replace").read()
    ms = list(pat.finditer(s))
    if ms:
        print(len(ms), p.split("\\")[-2], [s[max(0,m.start()-25):m.end()+12].replace("\n"," ") for m in ms[:3]])
