import shutil
p = "papers/2207.06431/main.typ"
shutil.copy(p, p + ".prekraus")
s = open(p, encoding="utf-8").read()
B = chr(92)
old = (
    "#eqnn($\n"
    "  K_j^(macron(u), macron(d), macron(dotless.i) arrow.r macron(f)) = "
    "(\u27e8macron(f)[U]|_U \u2297 \u27e8macron(d)|_D \u2297 \u27e8macron(f)[L]|_L) " + B + "\n"
    "  #h(2em) K_j #h(0.6em) (|macron(u)\u27e9_U \u2297 |macron(dotless.i)[D]\u27e9_D \u2297 |macron(dotless.i)[L]\u27e9_L)\n"
    "$)"
)
new = (
    "#eqnn($\n"
    "  K_j^(macron(u), macron(d), macron(dotless.i) arrow.r macron(f)) &= "
    "(\u27e8macron(f)[U]|_U \u2297 \u27e8macron(d)|_D \u2297 \u27e8macron(f)[L]|_L) " + B + "\n"
    "  & quad K_j (|macron(u)\u27e9_U \u2297 |macron(dotless.i)[D]\u27e9_D \u2297 |macron(dotless.i)[L]\u27e9_L)\n"
    "$)"
)
n = s.count(old)
print("match", n)
if n:
    s = s.replace(old, new)
    open(p, "w", encoding="utf-8", newline="\n").write(s)
