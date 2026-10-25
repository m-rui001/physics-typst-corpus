import io
p = r"papers/2312.03982/main.typ"
s = io.open(p, encoding="utf-8").read()
old = "$ {I I I I, Z Z I I, I Z Z I, I I Z Z} $ $ {Z I I Z, I Z I Z, Z I Z I, Z Z Z Z} $, $ {X X X X, X Y Y X, Y X X Y, X X Y Y} $ $ {Y Y X X, Y X Y X, X Y X Y, Y Y Y Y} $"
new = "$ {I I I I, Z Z I I, I Z Z I, I I Z Z}$ $ {Z I I Z, I Z I Z, Z I Z I, Z Z Z Z}$, $ {X X X X, X Y Y X, Y X X Y, X X Y Y}$ $ {Y Y X X, Y X Y X, X Y X Y, Y Y Y Y}$"
assert s.count(old) == 1, s.count(old)
io.open(p, "w", encoding="utf-8").write(s.replace(old, new))
print("ok")
