# -*- coding: utf-8 -*-
"""Restore the full abstract (converter kept only its last sentences, fragmented)."""
import io
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()
start = s.index('As a concrete example, we show that 12 logical qubits can be preserved')
end = s.index('e reach of near-term quantum processors.') + len('e reach of near-term quantum processors.')
new = '''Quantum error correction becomes a practical possibility only if the physical error rate is below a threshold value that depends on a particular quantum code, syndrome measurement circuit, and decoding algorithm. Here we present an end-to-end quantum error correction protocol that implements fault-tolerant memory based on a family of LDPC codes with a high encoding rate that achieves an error threshold of $0.8%$ for the standard circuit-based noise model. This is on par with the surface code which has remained an uncontested leader in terms of its high error threshold for nearly 20 years. The full syndrome measurement cycle for a length-$n$ code in our family requires $n$ ancillary qubits and a depth-7 circuit composed of nearest-neighbor CNOT gates. The required qubit connectivity is a degree-6 graph that consists of two edge-disjoint planar subgraphs.

As a concrete example, we show that 12 logical qubits can be preserved for nearly one million syndrome cycles using 288 physical qubits in total, assuming the physical error rate of $0.1%$. We argue that achieving the same level of error suppression on 12 logical qubits with the surface code would require nearly 3000 physical qubits. Our findings bring demonstrations of a low-overhead fault-tolerant quantum memory within the reach of near-term quantum processors.'''
s = s[:start] + new + s[end:]
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('abstract restored')
