import io, re
P = r'E:\phys\papers\2104.02565\main.typ.new'
s = io.open(P, encoding='utf-8').read()
# strip math spans, strings and line comments to a mask of same length
mask = list(s)
i, n = 0, len(s)
in_math = False
while i < n:
    c = s[i]
    if c == '$' and (i == 0 or s[i - 1] != '\\'):
        in_math = not in_math
        mask[i] = ' '
    elif in_math:
        mask[i] = ' '
    elif c == '"':
        j = i + 1
        while j < n and not (s[j] == '"' and s[j - 1] != '\\'):
            mask[j] = ' '
            j += 1
        if j < n:
            mask[j] = ' '
        i = j
    i += 1
m = ''.join(mask)
bal = {'[': 0, '(': 0, '{': 0}
pair = {']': '[', ')': '(', '}': '{'}
line = 1
for k, c in enumerate(m):
    if c == '\n':
        line += 1
    elif c in bal:
        bal[c] += 1
    elif c in pair:
        bal[pair[c]] -= 1
        if bal[pair[c]] < 0:
            print('NEGATIVE', c, 'line', line)
            bal[pair[c]] = 0
print('final balance', bal)
