import re, sys, glob, os

def skim_value(t, i):
    # t[i] is first char of value ('{' or '"')
    q = t[i]
    if q == '"':
        j = i + 1
        while j < len(t) and t[j] != '"':
            j += 1
        return t[i + 1:j], i, j + 1
    depth = 0
    j = i
    while j < len(t):
        c = t[j]
        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1
            if depth == 0:
                return t[i + 1:j], i, j + 1
        j += 1
    return t[i + 1:], i, len(t)

def split_names(s):
    out, cur, depth = [], '', 0
    i = 0
    while i < len(s):
        c = s[i]
        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1
        if depth == 0 and s.startswith(' and ', i):
            out.append(cur)
            cur = ''
            i += 5
            continue
        cur += c
        i += 1
    out.append(cur)
    return [x.strip() for x in out if x.strip()]

def display(name):
    fam = re.match(r'^\{?([^{},]+)\}?,\s*(.*)$', name)
    if fam:
        last, given = fam.group(1).strip(), fam.group(2).strip()
        return (given + ' ' + last).strip()
    return name

def is_others(n):
    return re.match(r'^(?:\{?others?\}?)(?:,\s*others?)?$', n.strip(), re.I) is not None

def clean_authors(val):
    names = split_names(val)
    others = any(is_others(n) for n in names)
    names = [n for n in names if not is_others(n)]
    if not others:
        return None
    if len(names) >= 7:
        return '{' + ' and '.join(names) + '}'
    shown = [display(n) for n in names]
    return '{{%s, et al.}}' % ', '.join(shown)

def process(path):
    t = open(path, encoding='utf-8').read()
    t = t.replace('~', ' ')
    n = 0
    pos = 0
    while True:
        m = re.search(r'\bauthor\s*=\s*', t[pos:])
        if not m:
            break
        start = pos + m.end()
        while start < len(t) and t[start] in ' \t':
            start += 1
        if start >= len(t) or t[start] not in '{"':
            pos = start
            continue
        val, vs, ve = skim_value(t, start)
        new = clean_authors(val)
        if new is not None:
            t = t[:vs] + new + t[ve:]
            pos = vs + len(new)
            n += 1
        else:
            pos = ve
    open(path, 'w', encoding='utf-8').write(t)
    return n

if __name__ == '__main__':
    for p in sorted(glob.glob('papers/*/refs.bib')):
        k = process(p)
        if k:
            print(os.path.basename(os.path.dirname(p)), k)
