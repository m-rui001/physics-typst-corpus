import io, shutil
p = r"papers/2104.04119/main.typ"
shutil.copyfile(p + ".presplit", p)
s = io.open(p, encoding="utf-8").read()
mark = "#figure(\n  box(width: 16.6cm, height: 7.6cm, ["
assert s.count(mark) == 1
s = s.replace(mark, "]\n" + mark, 1)
end = ") <fig:state_prep_DMRG>"
assert s.count(end) == 1
s = s.replace(end, end + "\n#columns(2, gutter: 0.62em)[", 1)
io.open(p, "w", encoding="utf-8").write(s)
print("split ok")
