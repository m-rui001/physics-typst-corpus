import re, io, sys
s = io.open(sys.argv[1], encoding='utf-8').read()
B = chr(92)
D = re.escape(B + B)
pat = re.compile(r'\$\$' + D + r'begin\{(align\*?|equation\*?|eqnarray\*?|gather\*?)\}(.*?)' + D + r'end\{\1\}\$\$', re.S)
ms = list(pat.finditer(s))
print('blocks', len(ms))
for i, m in enumerate(ms):
    body = m.group(2).replace(B + B, B)
    print('=' * 20, 'BLOCK', i, m.group(1), 'line', s[:m.start()].count('\n') + 1)
    print(body)
