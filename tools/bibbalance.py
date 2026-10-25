import re, sys, io

path = sys.argv[1]
apply = "--apply" in sys.argv
s = io.open(path, encoding="utf-8", errors="ignore").read()
idx = [m.start() for m in re.finditer(r"(?m)^@", s)]
out = []
last = 0
fixed = 0
for k, i in enumerate(idx):
    if i > last:
        out.append(s[last:i])
    j = idx[k + 1] if k + 1 < len(idx) else len(s)
    part = s[i:j]
    d = 0
    for ch in part:
        if ch == "{":
            d += 1
        elif ch == "}":
            d -= 1
    if d > 0:
        part = part.rstrip() + "}" * d + "\n"
        fixed += 1
    out.append(part)
    last = j
if last < len(s):
    out.append(s[last:])
if apply:
    io.open(path, "w", encoding="utf-8").write("".join(out))
print(path, "appended-close:", fixed)
