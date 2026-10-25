import re, io, sys
p = 'papers/2202.13919/main.typ'
s = io.open(p, encoding='utf-8').read()
B = chr(92)
D = re.escape(B + B)
pat = re.compile(r'\$\$' + D + r'begin\{(align\*?|equation\*?|eqnarray\*?|gather\*?)\}(.*?)' + D + r'end\{\1\}\$\$', re.S)

REPL = [
    # 0: CS Lagrangian (line 222)
    r'''$
  cal(L)_A + cal(L)_"CS" &= 1/2 (bold(E) dot.op bold(E) - bold(B) dot.op bold(B)) + alpha/f chi (bold(B) dot.op bold(E)) \
  &= 1/2 [(bold(E) + alpha/(2 f) chi bold(B))^2 - (bold(B) - alpha/(2 f) chi bold(E))^2] + cal(O)(alpha^2),
$''',
    # 1: E/B solutions (line 258), two labelled equations
    r'''$
  Delta_(E, ell) (eta_0, q) &= 3/4 sqrt(((ell + 2)!)/((ell - 2)!)) integral_0^(eta_0) d eta cal(V) Pi frac(j_ell (x), x^2) cos(2 beta (eta)),
$ <eq:boltzmannsolutionE> $
  Delta_(B, ell) (eta_0, q) &= 3/4 sqrt(((ell + 2)!)/((ell - 2)!)) integral_0^(eta_0) d eta cal(V) Pi frac(j_ell (x), x^2) sin(2 beta (eta)),
$ <eq:boltzmannsolutionB>''',
    # 2: observed E/B after foreground + CMB rotation (line 302)
    r'''$
  E_(ell m)^"o" &= E_(ell m)^"FG" cos(2 alpha) - B_(ell m)^"FG" sin(2 alpha) \
  &quad + E_(ell m)^"CMB" cos(2 alpha + 2 beta) - B_(ell m)^"CMB" sin(2 alpha + 2 beta), \
  B_(ell m)^"o" &= E_(ell m)^"FG" sin(2 alpha) + B_(ell m)^"FG" cos(2 alpha) \
  &quad + E_(ell m)^"CMB" sin(2 alpha + 2 beta) + B_(ell m)^"CMB" cos(2 alpha + 2 beta),
$''',
    # 3: EB after alpha and beta (line 310)
    r'''$
  C_ell^(E B, "o") &= frac(tan(4 alpha), 2) (C_ell^(E E, "o") - C_ell^(B B, "o")) \
  &quad + frac(sin(4 beta), 2 cos(4 alpha)) (C_ell^(E E, "CMB") - C_ell^(B B, "CMB")) \
  &quad + frac(1, cos(4 alpha)) C_ell^(E B, "FG") + frac(cos(4 beta), cos(4 alpha)) C_ell^(E B, "CMB").
$''',
    # 4: chiral GW spectra (line 481)
    r'''$
  cal(P)_("t,R") &simeq frac(4, M_"pl"^2) (frac(H, 2 pi))^2 [1 + 8.6 times 10^(-7) frac(H^2, M_"pl"^2) frac(e^(4 pi xi), xi^6)],
$ <eq:PRu1> $
  cal(P)_("t,L") &simeq frac(4, M_"pl"^2) (frac(H, 2 pi))^2 [1 + 1.8 times 10^(-9) frac(H^2, M_"pl"^2) frac(e^(4 pi xi), xi^6)],
$ <eq:PLu1>''',
    # 5: chirality in spectator model (line 555)
    r'''$
  cal(P)_"t,R/L" simeq frac(4, M_"pl"^2) (frac(H, 2 pi))^2 [1 + frac(Q^2, 2 M_"pl"^2) |cal(G)_(R/L)(m_Q)|^2 e^(pi (m_Q + xi))],
$''',
    # 6: source spectrum (line 570)
    r'''$
  cal(P)^"source"_"t,R"(k) = r_(* ) cal(P)_"s"(k) exp(-frac(1, 2 Sigma^2) ln^2 (frac(k, k_"p"))),
$''',
]

ms = list(pat.finditer(s))
assert len(ms) == len(REPL), (len(ms), len(REPL))
out = []
last = 0
for m, rep in zip(ms, REPL):
    out.append(s[last:m.start()])
    out.append(rep)
    last = m.end()
out.append(s[last:])
io.open(p, 'w', encoding='utf-8', newline='\n').write(''.join(out))
print('spliced', len(ms))
