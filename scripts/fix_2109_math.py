import io, re, sys
sys.stdout.reconfigure(encoding='utf-8')
p = 'papers/2109.00548/main.typ'
s = io.open(p, encoding='utf-8').read()
orig = s

def close(s, i):
    """s[i]=='(' ; return index just after matching ')'."""
    d = 0
    for j in range(i, len(s)):
        if s[j] == '(': d += 1
        elif s[j] == ')':
            d -= 1
            if d == 0: return j + 1
    raise ValueError('unbalanced')

def strip_wrap(a):
    while a.startswith('('):
        k = close(a, 0)
        if k == len(a): a = a[1:-1]
        else: break
    return a

out, i, n = [], 0, 0
key = 'attach(sum, b: '
while True:
    j = s.find(key, i)
    if j < 0:
        out.append(s[i:]); break
    out.append(s[i:j])
    a = j + len(key)
    k = close(s, a)
    barg = strip_wrap(s[a:k])
    out.append('sum_(' + barg + ')')
    # drop a following top-level parenthesised body (it is juxtaposition, so its
    # parens would print) and keep the body contents
    if k < len(s) and s[k] == '(':
        e = close(s, k)
        out.append(' ' + s[k+1:e-1])
        k = e
    i = k; n += 1
s = ''.join(out)

s = re.sub(r'\bvec\((S|eta)\)', r'arrow(\1)', s)
# subscripts whose macro-expanded site symbol closed the group early
s = re.sub(r'_\(bold\(r\)\),\s*(?=\(bold\(r\)\)′)', '_(bold(r), ', s)
s = re.sub(r'_\(bold\(r\)\),\s*(sigma|↑|↓)', lambda m: '_(bold(r), %s)' % m.group(1), s)
s = re.sub(r'_\(bold\(r\)\)′,\s*sigma', '_(bold(r)′, sigma)', s)
# redundant grouping parens around \mathbf{r}; keep an immediately preceding _ ^ or (
s = re.sub(r'(?<![_^(])\(bold\(r\)\)', 'bold(r)', s)
s = s.replace('((bold(r)))', '(bold(r))')
s = re.sub(r'\(bold\(r\)\)(?=′⟩)', 'bold(r)', s)
io.open(p, 'w', encoding='utf-8').write(s)
print('attach', n, 'vec', len(re.findall(r'arrow\((?:S|eta)\)', s)))
print('left bold(r) parens:', re.findall(r'.{6}\(bold\(r\)\).{6}', s)[:8])
