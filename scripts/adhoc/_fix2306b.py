import io
p = r"papers/2306.16227/main.typ"
s = io.open(p, encoding="utf-8").read()
n = 0

# eq:hch2  break after the first "times"
old = 'frac("d"t_r, "d""ln" f_("K",r)) times h^2 (f_("K",r))'
new = 'frac("d"t_r, "d""ln" f_("K",r)) times \\\n  h^2 (f_("K",r))'
assert s.count(old) == 1
s = s.replace(old, new); n += 1

# eq:infspectrum -> two aligned lines
old = '  Omega_"GW" (f) = frac(3, 128) Omega_"rad" r cal(P)^("*")_(cal(R)) (f \\/ f_("*"))^(n_T) [1\\/2 (f_"eq" \\/ f)^2 + 16\\/9] approx 1.5 times 10^(-16) (r \\/ 0.032) (f \\/ f_("*"))^(n_T)'
new = '  Omega_"GW" (f) &= frac(3, 128) Omega_"rad" r cal(P)^("*")_(cal(R)) (f \\/ f_("*"))^(n_T) [1\\/2 (f_"eq" \\/ f)^2 + 16\\/9] \\\n  &approx 1.5 times 10^(-16) (r \\/ 0.032) (f \\/ f_("*"))^(n_T)'
assert s.count(old) == 1, s.count(old)
s = s.replace(old, new); n += 1

# full SGWB multline
old = 'sum_b frac(N_b Gamma^(b), zeta(q_b)) times sum_(n=1)^(+oo)'
new = 'sum_b frac(N_b Gamma^(b), zeta(q_b)) \\\n  times sum_(n=1)^(+oo)'
assert s.count(old) == 1
s = s.replace(old, new); n += 1

io.open(p, "w", encoding="utf-8").write(s)
print("patched", n)
