import io, re, sys, glob
sys.stdout.reconfigure(encoding='utf-8')
src = ''
for f in glob.glob('papers/2109.00548/src/**/*.tex', recursive=True):
    src += io.open(f, encoding='utf-8', errors='ignore').read()
src = re.sub(r'%[^\n]*', '', src)
qs = ['energy window $[\\bar{E} - \\Delta, \\bar{E} + \\Delta]$',
      'fidelity $\\mathcal{F}(t)$ of Eq',
      'full Hilbert space, Eq',
      'of $\\mathcal{T}$ of Eq',
      'eigenstates in $\\mathcal{T}$ of Eq',
      'states in $\\mathcal{T}$ of Eq',
      'scar}$ of Eq',
      'SM formalism of Eq']
for q in qs:
    print('##', q)
    for m in list(re.finditer(re.escape(q), src))[:4]:
        print('  ', repr(src[m.start():m.start() + 170]))
