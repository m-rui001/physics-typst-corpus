import io, re

bbl = io.open(r'papers/2104.07036/src/Completeness-v2.bbl', encoding='utf-8').read()
body = bbl.split(r'\begin{thebibliography}', 1)[1]
body = body.split(r'\end{thebibliography}', 1)[0]

def untex(s):
    s = re.sub(r'\\href\{[^}]*\}\{([^{}]*)\}', r'\1', s)
    s = re.sub(r'\\href\{[^}]*\}', '', s)
    for cmd in ('em', 'bfseries', 'ttfamily', 'it', 'bf', 'rm'):
        s = re.sub(r'\{\\' + cmd + r'\s+([^{}]*)\}', r'\1', s)
        s = re.sub(r'\\' + cmd + r'\{([^{}]*)\}', r'\1', s)
    s = re.sub(r'\\[a-zA-Z]+\s*', '', s)
    s = re.sub(r'\{\\"([a-zA-Z])\}', r'\1', s)
    s = s.replace('~', ' ')
    s = s.replace('\\&', '&').replace('\\{', '').replace('\\}', '')
    s = s.replace('{', '').replace('}', '')
    s = re.sub(r'\s+', ' ', s).strip()
    return s.replace('"', '')

parts = re.split(r'\\bibitem(?:\[[^\]]*\])?\{([^}]*)\}', body)
entries = []
for i in range(1, len(parts), 2):
    key = parts[i].strip()
    raw = re.sub(r'%%CITATION.*', '', parts[i + 1], flags=re.S).strip()

    eprint = ''
    em = re.search(r'arXiv:([\w./-]+)', raw)
    if em:
        eprint = em.group(1)
    clean = re.sub(r'\\href\{[^}]*\}\{', '{', raw)
    clean = re.sub(r'\\href\{[^}]*\}', '', clean)

    m = re.match(r"(.*?)[,;]?\s*``\{(.*?)\}?,''", clean, re.S) or re.match(r"(.*?)``(.*?)''", clean, re.S)
    if m:
        authors = untex(m.group(1)).rstrip(',').strip()
        title = untex(m.group(2))
        rest = clean[m.end():]
    else:
        bm = re.match(r"(.*?)[,;]\s*\{\\em\s+(.*?)\}", clean, re.S)
        if bm:
            authors = untex(bm.group(1)).rstrip(',').strip()
            title = untex(bm.group(2))
            rest = clean[bm.end():]
        else:
            authors, title, rest = '', untex(clean[:150]), ''

    journal = ''
    jm = re.search(r'\{\\em\s+([^{}]+)\}', rest)
    if jm:
        journal = untex(jm.group(1))
    vol = ''
    vm = re.search(r'\{\\bfseries\s+([^{}]+)\}', rest)
    if vm:
        vol = untex(vm.group(1))
    year = ''
    ym = re.search(r'\((\d{4})\)', rest)
    if ym:
        year = ym.group(1)
    pages = ''
    pm = re.search(r'\)\s*(\d+\s*[-–]{1,2}\s*\d+)', rest)
    if pm:
        pages = pm.group(1).replace(' ', '')
    entries.append(dict(key=key, author=authors, title=title, journal=journal,
                        volume=vol, year=year, pages=pages, eprint=eprint))

out = []
for e in entries:
    fields = []
    for k in ('author', 'title', 'journal', 'volume', 'year', 'pages', 'eprint'):
        if e[k]:
            fields.append('  %s = {%s}' % (k, e[k]))
    out.append('@article{%s,\n%s\n}' % (e['key'], ',\n'.join(fields)))
io.open(r'papers/2104.07036/refs.bib', 'w', encoding='utf-8', newline='\n').write('\n\n'.join(out) + '\n')
print(len(entries), 'entries')
for e in entries[:6]:
    print(e)
