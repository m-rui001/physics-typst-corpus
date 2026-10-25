p = "papers/2201.09478/main.typ"
s = open(p, encoding="utf-8").read()

# the hand-written header lost its hashes: "set ..." / "show ..." were never code
for a, b in [
    ("\nset page(numbering", "\n#set page(numbering"),
    ("\nset par(justify", "\n#set par(justify"),
    ("\nset math.equation(numbering", "\n#set math.equation(numbering"),
    ("\nset figure.caption(", "\n#set figure.caption("),
    ("\nshow figure.caption:", "\n#show figure.caption:"),
    ("\nshow math.equation.where", "\n#show math.equation.where"),
    ("wyiz@ustc.edu.cn", "wyiz\\@ustc.edu.cn"),
    ("yanbohang@zju.edu.cn", "yanbohang\\@zju.edu.cn"),
]:
    n = s.count(a)
    print(repr(a), n)
    s = s.replace(a, b)
open(p, "w", encoding="utf-8", newline="\n").write(s)
