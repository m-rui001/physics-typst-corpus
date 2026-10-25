import io
import re

p = r"E:\phys\papers\2112.04515\main.typ"
s = io.open(p, encoding="utf-8").read()
s2, n = re.subn(r'#cite\(label\("([^"]+)"\)\)', lambda m: "#cite(<%s>)" % m.group(1), s)
print("replaced", n)
io.open(p, "w", encoding="utf-8", newline="\n").write(s2)
