import io, sys
sys.stdout.reconfigure(encoding='utf-8')
p = 'papers/2111.14241/main.typ'
s = io.open(p, encoding='utf-8').read()
orig = s

cap = ("Phase space depiction of (a) isotropic ferromagnetic ground state, corresponding to the "
       "magnon vacuum, and (b) a magnon coherent state. The shaded region represents the quantum "
       "fluctuations due to the Heisenberg uncertainty principle with its area $prop hbar$. In the "
       "coherent state, depicted in (b), the uncertainty region center undergoes precession along a "
       "circular trajectory, shown as a dotted curve. For macroscopically large amplitude of the "
       "precession, the Heisenberg uncertainty region appears as an infinitesimal point and the "
       "classical spin precession picture is recovered.")

old_fig = '#figure([#block[\n ]],\n caption: [\n ]\n) <fig:auto3>'
new_fig = ('#figure(image("imgs/phase_space_coherent_state.png", width: 100.0%),\n'
           ' caption: [' + cap + ']\n) <fig:auto3>')
assert s.count(old_fig) == 1
s = s.replace(old_fig, new_fig)
box = '\n\n\n#box(image("imgs/phase_space_coherent_state.png", width: 100.0%))'
assert s.count(box) == 1
s = s.replace(box, '')

# caption fragment that escaped into the body
a = s.find('\n\n\nrtainty region center')
b = s.find('\n\n\n', a + 3)
assert a > 0 and b > a
s = s[:a] + s[b:]

# the comment environment's contents leaked; the source still has it commented out
a = s.find('From the theoretical perspective')
assert a > 0
b = s.find('\n comment\n', a)
assert b > a
s = s[:a] + s[b + len('\n comment\n'):]

assert s.count('in Fig. (a)') == 1 and s.count('in Fig. (b)') == 1
s = s.replace('in Fig. (a)', 'in @fig:auto3(a)').replace('in Fig. (b)', 'in @fig:auto3(b)')

io.open(p + '.prefigcap', 'w', encoding='utf-8').write(orig)
io.open(p, 'w', encoding='utf-8').write(s)
print('removed', len(orig) - len(s), 'chars')
print(s[s.find('Equipped with the analysis'):s.find('Equipped with the analysis') + 300])
