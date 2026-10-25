import io, re, sys
sys.stdout.reconfigure(encoding='utf-8')
src = ''
import glob
for f in glob.glob('papers/2109.00548/src/**/*.tex', recursive=True):
    src += io.open(f, encoding='utf-8', errors='ignore').read()
src = re.sub(r'%[^\n]*', '', src)
s = io.open('papers/2109.00548/main.typ', encoding='utf-8').read()

queries = [
    'energy window',
    'As a consequence of',
    'solvable eigenstate',
    'interaction term in',
    'of the AKLT',
    'similar to the tower',
    'fidelity',
    'full Hilbert space',
    'tower of states in',
    'For example, $H_{\\text{scar}}$',
    'pairing discussed in',
    'in the Hubbard model, the subspace',
    'quasisymmetric subspace',
    'SGA property of',
    'protected by the pseudospin',
    'usual Hubbard model',
    'which exhibits an SGA of',
    'QMBS eigenstates in',
    'formalism of',
    'decomposing the first term in',
    'since the states in',
    'Krylov subspaces',
    'different $|\\psi_j\\rangle$',
]
seen = set()
for q in queries:
    hits = [m.start() for m in re.finditer(re.escape(q), src)]
    if not hits:
        print('?? NOTFOUND', q)
        continue
    k = hits[0]
    print('##', q)
    print('   SRC:', src[k:k + 230].replace('\n', ' '))
