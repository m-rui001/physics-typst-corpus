# -*- coding: utf-8 -*-
"""Rebuild the shattered fig:numerics region and its follow-up paragraph."""
import io
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()

start = s.index('#figure(\n  [\\n#image("imgs/small_ldpc.pdf.wired.png"')
end = s.index('For example, suppose that the physical error rate', start)
new = '''#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align(center)[#image("imgs/small_ldpc.png", width: 100%)],
    align(center)[#image("imgs/ldpc_vs_surface.png", width: 100%)],
  ),
  caption: [
    A) Logical vs physical error rate for small examples of Bivariate Bicycle LDPC codes. A numerical estimate of $p_L$ (diamonds) was obtained by simulating $d$ syndrome cycles for a distance-$d$ code. Most of the data points have error bars $approx p_L\/10$ due to sampling errors. B) Comparison between the Bivariate Bicycle LDPC code $[ [ 144 , 12 , 12 ] ]$ and surface codes with $12$ logical qubits and distance $d in {9 , 11 , 13 , 15}$. The distance-$d$ surface code with $12$ logical qubits has length $n = 12 d^2$ since each logical qubit is encoded into a separate $d times d$ patch of the surface code lattice.
  ],
) <fig:numerics>

'''
s = s[:start] + new + s[end:]

subs = [
    ("Encoding $12$ logical qubits using the distance-$12$ code from would offer the logical error rate which is enough to preserve $12$ logical qubits for .",
     "Encoding $12$ logical qubits using the distance-$12$ code from @table:codes_intro would offer the logical error rate $2 times 10^(-7)$ which is enough to preserve $12$ logical qubits for nearly one million syndrome cycles."),
    ("The distance-$18$ code from would require $576$ physical qubits while suppressing the error rate from $10^(- 3)$ to enabling roughly hundred billion syndrome cycles.",
     "The distance-$18$ code from @table:codes_intro would require $576$ physical qubits while suppressing the error rate from $10^(-3)$ to $2 times 10^(-12)$ enabling roughly hundred billion syndrome cycles."),
    ("would require physical qubits to suppress the error rate from $10^(- 3)$ to $10^(- 6)$, see ~B).",
     "would require nearly $3000$ physical qubits to suppress the error rate from $10^(-3)$ to $10^(-6)$, see @fig:numerics~B)."),
    ("offers saving in the number of physical qubits",
     "offers more than $10$X saving in the number of physical qubits"),
    ("Data reported in Figure A) was generated",
     "Data reported in @fig:numerics A) was generated"),
    ("Figure A) shows the logical error rate",
     "@fig:numerics A) shows the logical error rate"),
]
for a, b in subs:
    if s.count(a) != 1:
        print('COUNT', s.count(a), a[:60])
    s = s.replace(a, b)

io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('region rebuilt')
