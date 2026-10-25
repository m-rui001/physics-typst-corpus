p = "papers/2201.09478/main.typ"
s = open(p, encoding="utf-8").read()
reps = [
    ("#super[1,*]", "#super[1,\\*]"),
    ("#super[*]", "#super[\\*]"),
    ("$^87$", "#super[87]"),
]
for a, b in reps:
    n = s.count(a)
    print(repr(a), n)
    s = s.replace(a, b)
open(p, "w", encoding="utf-8", newline="\n").write(s)
