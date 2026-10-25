# -*- coding: utf-8 -*-
import io
p = 'main.typ'
s = io.open(p, encoding='utf-8').read()
subs = [
    ("In we show how to use methods from", "In @sec:logicals we show how to use methods from"),
    ("The rest of this paper is organized as follows. formally defines BB LDPC codes",
     "The rest of this paper is organized as follows. @sec:codedefinition formally defines BB LDPC codes"),
    ("The construction of the syndrome measurement circuit is detailed in .",
     "The construction of the syndrome measurement circuit is detailed in @sec:syndrome_circuit."),
    ("are discussed in with some implementation details deferred to .",
     "are discussed in @sec:decoder with some implementation details deferred to @sec:numerics."),
    ("We describe fault tolerant memory capabilities in .",
     "We describe fault tolerant memory capabilities in @sec:logicals."),
    ("some open questions can be found in .",
     "some open questions can be found in @sec:conclusions."),
]
for a, b in subs:
    if s.count(a) != 1:
        print('COUNT', s.count(a), a[:60])
    s = s.replace(a, b)
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('sec refs done')
