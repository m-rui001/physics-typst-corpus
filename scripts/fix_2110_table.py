import io, sys
sys.stdout.reconfigure(encoding='utf-8')
p = 'papers/2110.02085/main.typ'
s = io.open(p, encoding='utf-8').read()
io.open(p + '.pretable', 'w', encoding='utf-8').write(s)

start = s.find('#figure(\n  table(\n    columns: 4,')
assert start > 0
endmark = ('#strong[Summary of applications of ML to enhance CFD.] We show options to accelerate '
           'direct numerical simulations (DNSs), improvement of turbulence models for large-eddy simula\n\n'
           'tions (LESs) and Reynolds-averaged Navier--Stokes (RANS) simulations, development of '
           'reduced-order models (ROMs) and possible future developments.')
end = s.find(endmark, start)
assert end > start
end += len(endmark)

rows = [
    ('Deep learning for correction between coarse and fine simulations',
     'Deep learning / reinforcement learning for more general subgrid-scale models',
     'Proper-orthogonal decomposition for improved linear subspaces to represent dynamics',
     'Deep learning for prediction and control of turbulent flows'),
    ('Deep learning for accelerating the solution of the Poisson equation',
     'Deep learning / reinforcement learning for more robust wall models',
     'Autoencoders to learn manifolds to represent dynamics',
     'Better interpretability of deep learning for computational-fluid-dynamics models'),
    ('Domain reduction: deep learning for inflow generation; Gaussian processes for '
     'pressure-gradient distributions',
     'Deep learning / symbolic regression for more accurate and general RANS models',
     'Deep learning for representing temporal system dynamics',
     'More efficient operation of high-performance-computing facilities facilitated by ML'),
    ('Deep learning for improved accuracy of finite-difference / finite-volume schemes',
     'Deep learning / symbolic regression for interpretable RANS models',
     'Sparse identification of nonlinear dynamics for learning efficient and interpretable ROMs',
     'ML-enabled more advanced computational architectures'),
]

def cell(t):
    return '[' + t.replace('[', '\\[').replace(']', '\\]') + ']'

lines = ['#figure(',
         '  table(',
         '    columns: 4,',
         '    align: center,',
         '    table.header(' + ', '.join('[*%s*]' % h for h in
             ['Accelerate DNS', 'Improve LES/RANS', 'Develop ROMs', 'Future developments']) + '),',
         '    table.hline(),']
for r in rows:
    lines.append('    ' + ', '.join(cell(c) for c in r) + ',')
    lines.append('    table.hline(),')
lines += [
    '  ),',
    '  caption: [*Summary of applications of ML to enhance CFD.* We show options to accelerate '
    'direct numerical simulations (DNSs), improvement of turbulence models for large-eddy '
    'simulations (LESs) and Reynolds-averaged Navier--Stokes (RANS) simulations, development of '
    'reduced-order models (ROMs) and possible future developments.],',
    ') <table:summary>',
]
new = '\n'.join(lines)
s = s[:start] + new + s[end:]
io.open(p, 'w', encoding='utf-8').write(s)
print('rebuilt table, removed', end - start - len(new))
