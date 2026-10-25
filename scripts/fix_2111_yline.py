import io, sys
sys.stdout.reconfigure(encoding='utf-8')
p = 'papers/2111.14241/main.typ'
s = io.open(p, encoding='utf-8').read()
i = s.find('Delta cal(S)_y')
print(repr(s[i - 200:i]))
# find line start
ls = s.rfind('\n', 0, i) + 1
print('linestart', repr(s[ls:ls + 12]))
if s[ls] != '$':
    s = s[:ls] + '$ ' + s[ls:]
io.open(p, 'w', encoding='utf-8').write(s)
print('patched')
