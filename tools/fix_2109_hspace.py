import re, pathlib

p = pathlib.Path(r"E:\phys\papers\2109.00548\main.typ")
s = p.read_text(encoding="utf-8")

pat = re.compile(r"#h\(0\.17em\)")
out, n = [], 0
for m in pat.finditer(s):
    # look ahead to next non-space char
    j = m.end()
    while j < len(s) and s[j] == " ":
        j += 1
    nxt = s[j] if j < len(s) else ""
    if nxt in "#$[].),;:\\" or nxt == "":
        out.append(m.group(0))
        continue
    out.append(", ")
    n += 1
res = ""
prev = 0
for m, rep in zip(pat.finditer(s), out):
    res += s[prev:m.start()] + rep
    prev = m.end()
res += s[prev:]

# braces around a two-element list are code in Typst math
res = res.replace("{ arrow.t, arrow.b }", "(arrow.t, arrow.b)")

p.write_text(res, encoding="utf-8")
print("replaced", n, "| remaining", res.count("#h(0.17em)"))
