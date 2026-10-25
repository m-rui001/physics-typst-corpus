import shutil
p = "papers/2207.06431/main.typ"
shutil.copy(p, p + ".prekraus2")
s = open(p, encoding="utf-8").read()
B = chr(92)
start = s.index("#eqnn($\n  K_j^(macron(u), macron(d), macron(dotless.i) arrow.r macron(f))")
end = s.index("$)", start) + 2
new = (
    "#eqnn($\n"
    "  K_j^(macron(u), macron(d), macron(dotless.i) arrow.r macron(f)) = "
    "& chevron.l macron(f)[U]|_U \u2297 chevron.l macron(d)|_D \u2297 chevron.l macron(f)[L]|_L " + B + "\n"
    "  & quad K_j quad " + B + "\n"
    "  & |macron(u)\u27e9_U \u2297 |macron(dotless.i)[D]\u27e9_D \u2297 |macron(dotless.i)[L]\u27e9_L\n"
    "$)"
)
s = s[:start] + new + s[end:]
open(p, "w", encoding="utf-8", newline="\n").write(s)
print("done")
