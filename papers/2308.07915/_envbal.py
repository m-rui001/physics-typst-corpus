# -*- coding: utf-8 -*-
import io, re
from collections import Counter

B = chr(92)
for f in ('arXiv_v2.tex', 'supplemental_v2.tex'):
    t = io.open(f, encoding='utf-8', errors='replace').read()
    cb = Counter(re.findall(B*2 + r'begin\{([^}]+)\}', t))
    ce = Counter(re.findall(B*2 + r'end\{([^}]+)\}', t))
    print(f, len(t), 'brace delta', t.count('{') - t.count('}'))
    for k in set(cb) | set(ce):
        if cb[k] != ce[k]:
            print('   ', k, cb[k], ce[k])
