import re, sys
B = chr(92)
t = open(sys.argv[1], encoding='utf-8', errors='replace').read()
print('count', t.count(B + 'bibitem'))
print('split1', len(re.split(B + 'bibitem', t)))
i = t.find(B + 'bibitem')
print(repr(t[i:i+120]))
pat = B + r'bibitem(?:\[(?:\{.*?\}|[^\]]*?)\])?\{'
print('pat match at', i, re.match(pat, t[i:], re.S))
