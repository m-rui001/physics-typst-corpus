import re, pathlib

p = pathlib.Path(r"E:\phys\papers\2306.16213\main.typ")
s = p.read_text(encoding="utf-8")
orig = s

old1 = '$Phi_(upright(C U R N) \\, i) & = "fractions"(A_(upright(C U R N))^2, 12 pi^2) 1 / T #h(-1em) (f_i / f_(upright("ref")))^(#h(-1em) - gamma_(upright(C U R N))) #h(-1em) #h(-1em) #h(-1em) f_(upright("ref"))^(- 3) \\,\\'
old2 = 'Phi_(upright(H D) \\, i) & = "fractions"(A_(upright(H D))^2, 12 pi^2) 1 / T #h(-1em) (f_i / f_(upright("ref")))^(#h(-1em) - gamma_(upright(H D))) #h(-1em) #h(-1em) #h(-1em) f_(upright("ref"))^(- 3) \\, $'

new1 = '$Phi_(upright("CURN"), i) &= frac(A_(upright("CURN"))^2, 12 pi^2) 1 / T (f_i / f_(upright("ref")))^(-gamma_(upright("CURN"))) f_(upright("ref"))^(-3) \\'
new2 = 'Phi_(upright("HD"), i) &= frac(A_(upright("HD"))^2, 12 pi^2) 1 / T (f_i / f_(upright("ref")))^(-gamma_(upright("HD"))) f_(upright("ref"))^(-3), $'

assert old1 in s, "line1 not found"
assert old2 in s, "line2 not found"
s = s.replace(old1, new1).replace(old2, new2)

# split letter-spaced identifiers
for a, b in [('upright(C U R N)', 'upright("CURN")'),
             ('upright(H D)', 'upright("HD")'),
             ('upright(n H z)', 'upright("nHz")'),
             ('upright(f r e e)', 'upright("free")')]:
    s = s.replace(a, b)

# restore comma between label and index inside subscripts
s = re.sub(r'upright\("(CURN|HD)"\) i\)', r'upright("\1"), i)', s)

p.write_text(s, encoding="utf-8")
print("changed", orig != s, "| remaining fractions:", s.count('"fractions"'))
