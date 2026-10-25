# -*- coding: utf-8 -*-
import io, re
from collections import Counter

B = chr(92)
t = io.open('arXiv_v2.tex', encoding='utf-8', errors='replace').read()
t = '\n'.join(re.sub(r'(?<!' + B * 2 + ')' + B + '%.*', '', ln) for ln in t.split('\n'))
cb = Counter(re.findall(B * 2 + r'begin\{([^}]+)\}', t))
ce = Counter(re.findall(B * 2 + r'end\{([^}]+)\}', t))
print('brace delta', t.count('{') - t.count('}'), 'dollar parity', t.count('$') % 2)
for k in set(cb) | set(ce):
    if cb[k] != ce[k]:
        print('  ENV', k, cb[k], ce[k])
# report line numbers where each unmatched env begins
for k in set(cb) | set(ce):
    if cb[k] != ce[k]:
        for m in re.finditer(B * 2 + r'begin\{' + re.escape(k) + r'\}', t):
            ln = t[:m.start()].count('\n') + 1
            print('   begin', k, 'line', ln)
