import io, re

P = 'papers/2202.13919/main.typ'
t = io.open(P, encoding='utf-8').read()
orig = t

def sub(pat, rep, n=None, label=''):
    global t
    t2, k = re.subn(pat, rep, t)
    print('%-28s %d' % (label or pat[:26], k))
    t = t2

# --- split EB relation into two labeled displays ---
old = ("or $ E_(ell m)^(upright(o)) & = E_(ell m) cos ( 2 beta ) - B_(ell m) sin ( 2 beta ) thin \\,\\\n"
       "B_(ell m)^(upright(o)) & = E_(ell m) sin ( 2 beta ) + B_(ell m) cos ( 2 beta ) thin . $<eq:EBrelation1>")
new = ("or\n"
       "$ E_(ell m)^\"o\" = E_(ell m) cos ( 2 beta ) - B_(ell m) sin ( 2 beta ) thin , $ <eq:EBrelation1>\n"
       "$ B_(ell m)^\"o\" = E_(ell m) sin ( 2 beta ) + B_(ell m) cos ( 2 beta ) thin . $ <eq:EBrelation2>")
assert old in t, 'EB relation block not found'
t = t.replace(old, new)

# --- visibility function ---
sub(r'\$cal\(V\) \( eta \) equiv_"T" n_e e\^\(\(\) - tau \( eta \) \)\$',
    '$cal(V)(eta) equiv a sigma_"T" n_e e^(-tau(eta))$', label='visibility fn')

# --- legacy fragments ---
t = t.replace('h_(() p , upright("bold") ( upright("k") ) ) = "" "constant"',
              'h_(p, bold(k)) = "constant"')
t = t.replace('"" C M B', '"CMB"')
sub(r'd\^4 x/sqrt\(- g\)', 'd^4 x sqrt(- g)', label='d4x sqrt')
sub(r'i\^\(- ell\)/sqrt\(4 pi', 'i^(- ell) sqrt(4 pi', label='i^-ell sqrt')
sub(r'Omega\^4/sqrt\(- g\)', 'Omega^4 sqrt(- g)', label='Omega^4 sqrt')
sub(r'tilde\.eq/sqrt\(2\) a H', 'tilde.eq sqrt(2) a H', label='meff')
sub(r'\) 6 = rho_A 3', ')/6 = rho_A/3', label='P_A /6')
sub(r'\$P = rho 3\$', '$P = rho/3$', label='P=rho/3')
sub(r'R 2 - \( partial phi \)\^2 2 - lambda phi\^4 4',
    'R/2 - ( partial phi )^2/2 - lambda phi^4/4', label='scalar action /2')
sub(r'dot\.double\(H\) \( 2 H dot\(H\) \)', 'dot.double(H)/(2 H dot(H))', label='delta_H')
sub(r'd o t \. o p', 'dot.op', label='dot.op')
sub(r'F_\(i m u \)', 'F_(i mu)', label='F_i mu')
sub(r'F_\(j n u \)', 'F_(j nu)', label='F_j nu')
sub(r'minus\.plus/2 k xi \( - eta \)', 'minus.plus 2 k xi / ( - eta )', label='omega^2')
sub(r'plus\.minus/2 ', 'plus.minus 2 ', label='e^{+-2i}')
sub(r'minus\.plus/2 ', 'minus.plus 2 ', label='e^{-+2i}')

# --- upright cleanup ---
sub(r'upright\("bold"\)\s*\(\s*upright\("([A-Za-z])"\)\s*\)',
    lambda m: 'bold(' + m.group(1) + ')', label='bold(X)')
sub(r'upright\("([^"]+)"\)', lambda m: '"' + m.group(1) + '"', label='upright("x")')
sub(r'upright\(([A-Za-z ]+)\)',
    lambda m: '"' + re.sub(r'\s+', '', m.group(1)) + '"', label='upright(x)')

# --- holes: figure refs ---
t = t.replace('Fig.#text([])', '#text([])')
sub(r'Fig\.@fig:', ' @fig:', label='Fig. prefix')

holes = ['@weinberg:2008', '@angle:2017', '@BICEP:2021', '@fig:cl',
         '@gardner:2008', '@eskilt:prep', '(@eq:EBrelation2)',
         '@zaldarriaga:1997', '(@eq:EBrelation2)', '(@eq:EBrelation2)',
         '(@eq:boltzmannsolutionE)', '(@eq:boltzmannsolutionB)',
         '@PlanckIntLVII', '@Planck2018II', '@eskilt:prep',
         '@mukhanov:2016', '@seljak:1997', '@BICEP:2021',
         '@weinberg:2004', '@maldacena:2003', '@weinberg:2008',
         '@lozanov:2019', '(@eq:vacuum-predictions)', '(@eq:PRu1)',
         '(@eq:PLu1)', '@fig:omega_gw', '@fig:cl', '@Planck2018IX',
         '@LiteBIRD:2022', '@fig:gw']
parts = t.split('#text([])')
assert len(parts) - 1 == len(holes), (len(parts) - 1, len(holes))
out = parts[0]
for rep, rest in zip(holes, parts[1:]):
    out += rep + rest
t = out
print('holes filled', len(holes))

# --- equation ref dedupe ---
sub(r'equations?~?\((@eq:[A-Za-z0-9_-]+)\)', r' \1', label='equation~(@eq)')
sub(r'\((@eq:[A-Za-z0-9_-]+)\)', r' \1', label='(@eq) parens')
sub(r'  +', ' ', label='collapse spaces')
sub(r' \.', '.', label='space period')

io.open(P + '.preinlinefix', 'w', encoding='utf-8', newline='\n').write(orig)
io.open(P, 'w', encoding='utf-8', newline='\n').write(t)
print('changed', sum(1 for a, b in zip(orig.splitlines(), t.splitlines()) if a != b))
