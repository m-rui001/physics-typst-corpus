import io, re
p = r"papers/2112.03923/main.typ"
lines = io.open(p, encoding="utf-8").read().split("\n")
out = []
i = 0
n = 0
while i < len(lines):
    ln = lines[i]
    if ln.startswith("#edfig("):
        out.append('#place(top + center, scope: "parent", float: true)[')
        out.append(ln)
        i += 1
        while i < len(lines):
            out.append(lines[i])
            if re.match(r'^\) <fig:[^>]+>', lines[i]):
                out.append("]")
                i += 1
                n += 1
                break
            i += 1
    else:
        out.append(ln)
        i += 1
io.open(p, "w", encoding="utf-8").write("\n".join(out))
print("wrapped", n)
