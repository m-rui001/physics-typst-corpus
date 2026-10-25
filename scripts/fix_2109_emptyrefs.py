import io, re, sys
sys.stdout.reconfigure(encoding='utf-8')
p = 'papers/2109.00548/main.typ'
s = io.open(p, encoding='utf-8').read()
io.open(p + '.preemptyref', 'w', encoding='utf-8').write(s)

labels = ['eq:MCtimeavg', 'eq:su2syms', 'eq:psi0tower', 'eq:FermiHubbard',
          'eq:AKLTHamiltonian', 'eq:HubbardQP', 'eq:fidelity', 'eq:manifoldSGA',
          'eq:Hparams', 'eq:RSGA2cond', 'eq:su2syms', 'eq:Hparams', 'eq:Hparams',
          'eq:SGA', 'eq:Hparams', 'eq:FermiHubbard', 'eq:HubbardSGA', 'eq:Hparams',
          'eq:GIHamil', 'eq:QSTTrelation', 'eq:Hparams', 'eq:Hilbertsplitting',
          'eq:Hilbertsplitting']
pat = re.compile(r'(?:Eqs?\.|Equations?)\s*~?\s*\(\)')
ms = list(pat.finditer(s))
assert len(ms) == len(labels), (len(ms), len(labels))
out = []
last = 0
for m, lab in zip(ms, labels):
    out.append(s[last:m.start()])
    out.append('Eq.~(#ref(<%s>, supplement: none))' % lab)
    last = m.end()
out.append(s[last:])
s = ''.join(out)

mal = [
    ('Eq.~( @moudgalya2020eta)', 'Eq.~(#ref(<eq:Int>, supplement: none))'),
    ('Eq.~(@fig:symmetrybased)', 'Eq.~(#ref(<eq:shiraishimori>, supplement: none))'),
    ('Eq.~(@eq:GIHamil)', 'Eq.~(#ref(<eq:GIHamil>, supplement: none))'),
]
for a, b in mal:
    print('mal', s.count(a), a)
    s = s.replace(a, b)
io.open(p, 'w', encoding='utf-8').write(s)
print('ok', len(ms))
