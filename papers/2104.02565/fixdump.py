import io
p = r'E:\phys\papers\2104.02565\main.typ.new'
s = io.open(p, encoding='utf-8').read()
L = s.split('\n')
i = next(j for j, l in enumerate(L) if l.startswith('The energy spectrum of DSNB events in JUNO is given by'))
assert L[i + 3].startswith('\\\\end{equation}'), L[i + 3][:40]
tail = L[i + 3].split('\\\\end{equation}\\\\$\\\\$ where ', 1)
rest = tail[1] if len(tail) > 1 else L[i + 3]
L[i] = 'The energy spectrum of DSNB events in JUNO is given by'
L[i + 1] = r'$ (dif N_nu)/(dif E_nu) = N_p times sigma_nu (E_nu) times c integral_0^infinity (dif N(E\'_nu))/(dif E\'_nu) times (dif E\'_nu)/(dif E_nu) times R_("SN")(z) times abs((dif t)/(dif z)) dif z, $'
L[i + 2] = '<Eq:DSNBSpectrum>'
L[i + 3] = 'where ' + rest
s = '\n'.join(L)
s = s.replace('( 10 upright(") upright(k t o n) )', '(10 "kton")')
s = s.replace("\\$\\\\dv{ N}{E\\'\\_{\\\\nu}}\\$", "$ (dif N)/(dif E'_nu) $")
s = s.replace('\\$|\\\\dv{t}{z}|\\$', '$ abs((dif t)/(dif z)) $')
s = s.replace('$3%$/ sqrt(E ( upright(M e V) ))$', '$3% / sqrt(E ("MeV"))$')
io.open(p, 'w', encoding='utf-8', newline='').write(s)
print('dumps left', s.count('\\$'))
