import io, sys, shutil
p = 'papers/2308.07915/main.typ'
s = io.open(p, encoding='utf-8').read()
shutil.copy(p, p + '.bak7')

FIX = [
    ("BB codes in . The Tanner graph", "BB codes in @sec:codedefinition. The Tanner graph"),
    ("See ~B) an example Tanner graph", "See @fig:2Dlayout~B) an example Tanner graph"),
    ("spanning the Tanner graph, see . B)", "spanning the Tanner graph, see @sec:codedefinition. B)"),
    ("thickness-2 implementation, see .", "thickness-2 implementation, see @sec:logicals."),
    ("the proof of .", "the proof of @lem:toric_layout."),
    ("circuit defined in enacts", "circuit defined in @table:syndromecircuit enacts"),
    ("$sans(\"CNOT\")$ in as $", "$sans(\"CNOT\")$ in @table:syndromecircuit as $"),
    ("In we derive that there are two blocks", "In @ssec:logical_pauli_operators we derive that there are two blocks"),
    ("In we show that there are fault tolerant logical gates", "In @ssec:automorphisms we show that there are fault tolerant logical gates"),
    ("in we give a fault tolerant gate based on a ZX-duality", "in @ssec:ZX_duality we give a fault tolerant gate based on a ZX-duality"),
    ("in we show that there exists an ancilla system", "in @ssec:logical_measurements we show that there exists an ancilla system"),
    ("in @sec:decoder .", "in @sec:decoder."),
    ("in @ssec:logical_measurements , we can", "in @ssec:logical_measurements, we can"),
    ("in @sec:logicals .", "in @sec:logicals."),
    ("in @table:syndromecircuit .", "in @table:syndromecircuit."),
    ("See @table:automorphisms .", "See @table:automorphisms."),
    ("in @table:duality_implementations .", "in @table:duality_implementations."),
]
for old, new in FIX:
    n = s.count(old)
    if n != 1:
        print('SKIP (%d occurrences): %r' % (n, old[:60]))
        continue
    s = s.replace(old, new)
    print('OK', old[:50])
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
