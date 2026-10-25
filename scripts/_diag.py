import io, re, subprocess
P = r'E:\phys\papers\2104.02565\main.typ.new'
L = io.open(P, encoding='utf-8').read().split('\n')
for ln in (172, 195, 356, 360, 384):
    s = L[ln - 1]
    d = len(re.findall(r'(?<!\\)\$', s))
    print('line', ln, 'dollars', d, 'parity', d % 2)
    if d % 2:
        # show tail after the last paired span
        print('  tail:', repr(s[-160:]))
# test the exact problematic fragments
for frag in ['$" "^8$He/$" "^9$Li',
             '$ chi_("REA")^2 = sum_(i = 1)^(N_(upright(b i n))) frac([ M_i - T_i ( 1 + sum_k alpha_(i k) epsilon.alt_k ) ]^2, M_i) $']:
    io.open(r'E:\phys\tmpmath.typ', 'w', encoding='utf-8').write(frag)
    r = subprocess.run(['typst', 'compile', r'E:\phys\tmpmath.typ', r'E:\phys\tmpmath.pdf'],
                       capture_output=True, text=True, encoding='utf-8', errors='replace')
    print('FRAG', frag[:40], '->', r.stdout.strip().split('\n')[0] if r.returncode else 'OK')
