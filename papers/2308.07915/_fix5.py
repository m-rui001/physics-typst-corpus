# -*- coding: utf-8 -*-
import io
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()
AP = chr(39)


def rep(a, b, n=1):
    global s
    c = s.count(a)
    if c != n:
        print('COUNT', c, 'for', a[:70])
    s = s.replace(a, b)


rep("achieved by a code we introduce\n\nSM circuits",
    "achieved by a code we introduce SM circuits")
rep("see for details. We emphasize",
    "see @sec:syndrome_circuit for details. We emphasize")
rep("beyond those listed in . The circuit",
    "beyond those listed in @table:codes_intro. The circuit")
rep("see for the upper bounds on",
    "see @table:codes_intro for the upper bounds on")
rep("is unlikely to be tight ).",
    "is unlikely to be tight and this affects the fit and extrapolations).")
rep("Here we show how to extend BP-OSD to the circuit-based noise model. We also show",
    "Here we show how to extend BP-OSD to the circuit-based noise model. Our approach "
    "closely follows Refs.~@delfosse2023spacetime @mcewen2023relaxing "
    "@higgott2023improved @geher2023tangling. We also show")
rep("of a quantum LDPC code, see for details.",
    "of a quantum LDPC code, see @sec:decoder for details.")
rep("( 1 - P_L ( N_c ) )^(1 N_c) approx P_L ( N_c ) N_c",
    "( 1 - P_L ( N_c ) )^(1\/N_c) approx P_L ( N_c )\/N_c")
rep("for a distance-$d$ code. A) shows the logical error rate achieved by codes from .",
    "for a distance-$d$ code. @fig:numerics A) shows the logical error rate "
    "achieved by codes from @table:codes_intro.")
rep('$p_L=p^("dcirc"' + AP + '/2)',
    '$p_L=p^(d_sans("circ")' + AP + '/2)')
rep('$"dcirc"' + AP + '$ is an upper bound on $"dcirc"$ from .',
    '$d_sans("circ")' + AP + '$ is an upper bound on $d_sans("circ")$ from @table:codes_intro.')
rep('The observed pseudo-threshold , which',
    'The observed pseudo-threshold for the $144$-qubit and $288$-qubit codes '
    'is close to $0.007$, which')
s = s.replace('<fig:nume>', '<fig:numerics>')
s = s.replace('$"dcirc"' + AP + '$', '$d_sans("circ")' + AP + '$')
s = s.replace('$"dcirc"$', '$d_sans("circ")$')
s = s.replace('$"dcirc"/2$', '$d_sans("circ")\/2$')
s = s.replace('distance $"dcirc"$', 'distance $d_sans("circ")$')
s = s.replace('dcirc', '$d_sans("circ")$')
s = s.replace('$$d_sans("circ")$$', '$d_sans("circ")$')
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('written')
