import re, shutil, pathlib

def backup(p):
    bk = p.parent / "_work" / ("main.pre_nullfloat.typ")
    if not bk.exists():
        shutil.copy2(p, bk)

# ---- 2204.12771: Extended Data Table uvoniobs ----
p = pathlib.Path("papers/2204.12771/main.typ")
s = p.read_text(encoding="utf-8")
backup(p)
start = s.index("#figure([], caption: [#strong[Ultraviolet, optical, and near-infrared observations of GRB 211211A.]]")
endmark = "  )]]\n"
end = s.index(endmark, start) + len(endmark)
block = s[start:end]
m = re.search(r"#text\(size: 5pt\)\[#align\(center\)\[#table\(\n(.*)\n  \)\]\]\n?$", block, re.S)
assert m, "2204 table wrapper not matched"
tbl = m.group(1)
# tbl ends with "\n  )" -> close table then align
new = ("#figure(\n"
       "  text(size: 5pt, align(center, table(\n"
       + tbl.rstrip() + "\n"
       "  ))),\n"
       "  caption: [#strong[Ultraviolet, optical, and near-infrared observations of GRB 211211A.]],\n"
       "  kind: \"edtable\", supplement: [Extended Data Table]\n"
       ") <tab:uvoniobs>\n")
s = s[:start] + new + s[end:]
p.write_text(s, encoding="utf-8", newline="\n")
print("2204 ok")

# ---- 2301.10937: tab1 ----
p = pathlib.Path("papers/2301.10937/main.typ")
s = p.read_text(encoding="utf-8")
backup(p)
start = s.index("#figure([], caption: [Representative studies on machine-learning-based super-resolution")
endmark = "  )]\n"
end = s.index(endmark, start) + len(endmark)
block = s[start:end]
m = re.search(r"#align\(center\)\[#table\(\n(.*)\n  \)\]\n?$", block, re.S)
assert m, "2301 table wrapper not matched"
print(repr(block[-80:]))
tbl = m.group(1)
new = ("#figure(\n"
       "  align(center, table(\n"
       + tbl.rstrip() + "\n"
       "  )),\n"
       "  caption: [Representative studies on machine-learning-based super-resolution reconstruction methods for fluid flows.],\n"
       "  kind: table,\n"
       ") <tab1>\n")
s = s[:start] + new + s[end:]
p.write_text(s, encoding="utf-8", newline="\n")
print("2301 ok")
