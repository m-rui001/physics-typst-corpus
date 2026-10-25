import io, re, sys
sys.stdout.reconfigure(encoding='utf-8')
p = 'papers/2109.00548/main.typ'
s = io.open(p, encoding='utf-8').read()

def close(s, i):
    o = s[i]; c = {'(': ')', '{': '}', '[': ']'}[o]
    d = 0
    for j in range(i, len(s)):
        if s[j] == o: d += 1
        elif s[j] == c:
            d -= 1
            if d == 0: return j + 1
    raise ValueError('unbalanced at %d' % i)

def expr(s, i):
    start = i; d = 0
    while i < len(s):
        ch = s[i]
        if ch in '([{': d += 1
        elif ch in ')]}':
            if d == 0: break
            d -= 1
        elif ch == ',' and d == 0: break
        i += 1
    return s[start:i], i

def unwrap(a):
    for o, c in (('(', ')'), ('{', '}')):
        while a.startswith(o) and close(a, 0) == len(a):
            a = a[1:-1]
    return a.strip()

def parse_attach(s, i):
    assert s.startswith('attach(', i)
    j = i + len('attach(')
    first, j = expr(s, j)
    named = {}
    while j < len(s) and s[j] == ',':
        j += 1
        k = s.index(':', j)
        name = s[j:k].strip(); j = k + 1
        while s[j] == ' ': j += 1
        val, j = expr(s, j)
        named[name] = val
    if j >= len(s) or s[j] != ')':
        raise ValueError('no close at %d: %r' % (j, s[j:j+20]))
    j += 1
    body = None
    if j < len(s) and s[j] in '({':
        e = close(s, j)
        body = s[j+1:e-1]
        j = e
    return first.strip(), named, body, j

def rewrite(s):
    out, i, n = [], 0, 0
    while True:
        j = s.find('attach(', i)
        if j < 0:
            out.append(s[i:]); break
        out.append(s[i:j])
        first, named, body, k = parse_attach(s, j)
        if first.startswith('attach('):
            f2, n2, b2, _ = parse_attach(first, 0)
            named = dict(n2, **named)
            first = f2
            assert b2 is None
        base = first.strip()
        if base not in ('sum', 'product'):
            print('SKIP base', base, 'at', j, file=sys.stderr)
            out.append(s[j:k]); i = k; continue
        out.append(base)
        if 'b' in named:
            out.append('_(' + unwrap(named['b']) + ')')
        if 't' in named:
            out.append('^(' + unwrap(named['t']) + ')')
        if body is not None:
            out.append(' ' + body)
        i = k; n += 1
    return ''.join(out), n

s, n = rewrite(s)
torch = s

# --- math cleanups visible in the rendered equations ---
s = re.sub(r'\bvec\(([A-Za-z]+)\)', r'arrow(\1)', s)

s = s.replace('⟨⟨)', '⟨').replace('(⟩⟩', '⟩')
# macro-expanded \mathbf{r} losing its braces on the way into a subscript
s = s.replace('_(bold(r)), (bold(r))′', '_(bold(r), bold(r)′)')
s = re.sub(r'_\(bold\(r\)\),\s*(sigma|↑|↓)', lambda m: '_(bold(r), %s)' % m.group(1), s)
s = re.sub(r'_\(bold\(r\)\)′,\s*sigma', '_(bold(r)′, sigma)', s)
s = re.sub(r'(?<![_^(])\(bold\(r\)\)', 'bold(r)', s)
io.open(p, 'w', encoding='utf-8').write(s)
print('rewrote', n, 'attach calls; arrow', len(re.findall(r'arrow\(', s)))
