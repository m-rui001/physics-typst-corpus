import io, os, re, sys, glob

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
try:
    from tex_decode import decode as texdecode
except Exception:
    def texdecode(s):
        return s


def pick_bbl(root):
    cands = glob.glob(os.path.join(root, 'src', '**', '*.bbl'), recursive=True)
    best = None
    for f in cands:
        t = io.open(f, encoding='utf-8', errors='replace').read()
        n = t.count('\\bibitem')
        if n and (best is None or n > best[0]):
            best = (n, f)
    return best[1] if best else None


def braced(t, i):
    """i points at '{'; return (content, index after matching '}')."""
    depth, j = 0, i
    while j < len(t):
        if t[j] == '{':
            depth += 1
        elif t[j] == '}':
            depth -= 1
            if depth == 0:
                return t[i + 1:j], j + 1
        j += 1
    return t[i + 1:], len(t)


BIBINFO = re.compile(r'\\bibinfo\{(\w+)\}\s*\{')


def fields_of(item):
    out = {}
    pos = 0
    while True:
        m = BIBINFO.search(item, pos)
        if not m:
            break
        val, end = braced(item, m.end() - 1)
        out.setdefault(m.group(1), []).append(val)
        pos = end
    return out


def clean(s):
    s = re.sub(r'\\href\{[^}]*\}\{([^{}]*)\}', r'\1', s)
    s = re.sub(r'\\url\{([^}]*)\}', r'\1', s)
    s = re.sub(r'\\(?:emph|textit|textbf|textsc|textrm|bibinfo\w*)\s*\{([^{}]*)\}', r'\1', s)
    s = re.sub(r'\$([^$]*)\$', r'\1', s)
    s = s.replace('~', ' ')
    s = texdecode(s)
    s = re.sub(r'\\[A-Za-z]+\s*', '', s)
    s = s.replace('{', '').replace('}', '').replace('\\', '')
    return re.sub(r'\s+', ' ', s).strip()


def sanitize_key(k):
    k = k.strip()
    return re.sub(r'[^A-Za-z0-9_.:+-]', '-', k)


def parse_plain(item):
    """Plain \\bibitem body: 'Author et al. Title. \\textit{Journal} vol, pages (year).'"""
    txt = item.replace('\\newblock', ' ').strip()
    year = ''
    ym = re.findall(r'\((\d{4})[a-z]?\)', txt)
    if ym:
        year = ym[-1]
    italics = re.findall(r'\\textit\{([^{}]*)\}', txt)
    journal = ''
    for it in reversed(italics):
        if it.strip().lower() not in ('et al.', 'ab initio'):
            journal = it.strip()
            break
    pages = ''
    pm = re.search(r'\$\s*\\mathbf\{[^}]*\}\s*\$\s*,?\s*([0-9]+(?:\s*[-–]+\s*[0-9]+)?)', txt)
    if pm:
        pages = pm.group(1).replace(' ', '')
    vol = ''
    vm = re.search(r'\$\s*\\mathbf\{([^}]*)\}\s*\$', txt)
    if vm:
        vol = vm.group(1)
    body = re.sub(r'\$[^$]*\$', '', txt)
    body = re.sub(r'\\textit\{[^{}]*\}', ' ', body)
    body = re.sub(r'\((\d{4})[a-z]?\)\s*\.?\s*$', '', body)
    body = re.sub(r'\s+', ' ', body).strip()
    parts = body.split('. ', 1)
    if len(parts) == 2:
        author, title = parts[0], parts[1]
    else:
        author, title = '', body
    title = title.rstrip('. ')
    return {
        'author': clean(author),
        'title': clean(title),
        'journal': clean(journal),
        'year': year,
        'volume': vol,
        'pages': pages,
    }


def convert(bbl_path, out_path):
    t = io.open(bbl_path, encoding='utf-8', errors='replace').read()
    body = t
    if '\\begin{thebibliography}' in body:
        body = body.split('\\begin{thebibliography}', 1)[1]
        body = body.split('\\end{thebibliography}', 1)[0]
    parts = re.split(r'\\bibitem(?:\[[^\]]*\])?\{([^}]*)\}', body)
    entries, seen = [], set()
    for i in range(1, len(parts), 2):
        key = sanitize_key(parts[i])
        item = parts[i + 1]
        if not key or key in seen:
            continue
        seen.add(key)
        f = {k: [clean(v) for v in vs] for k, vs in fields_of(item).items()}
        authors = ' and '.join(f.get('author', []))
        title = ' '.join(f.get('title', []))
        journal = ' '.join(f.get('journal', f.get('journaltitle', [])))
        year = ' '.join(f.get('year', []))
        vol = ' '.join(f.get('volume', []))
        pages = ' '.join(f.get('pages', []))
        doi = ' '.join(f.get('doi', []))
        eprint = ' '.join(f.get('eprint', []))
        pub = ' '.join(f.get('publisher', []))
        if not title and not authors:
            raw = clean(re.sub(r'\\newblock', ' ', item))
            title = raw[:300]
        kind = 'article' if journal else ('book' if pub else 'misc')
        fields = []
        if authors:
            fields.append('author = {%s}' % authors)
        fields.append('title = {%s}' % (title or key))
        if journal:
            fields.append('journal = {%s}' % journal)
        if year:
            fields.append('year = {%s}' % year)
        if vol:
            fields.append('volume = {%s}' % vol)
        if pages:
            fields.append('pages = {%s}' % pages)
        if doi:
            fields.append('doi = {%s}' % doi)
        if eprint:
            fields.append('eprint = {%s}' % eprint)
            fields.append('archivePrefix = {arXiv}')
        if pub:
            fields.append('publisher = {%s}' % pub)
        entries.append('@%s{%s,\n  %s\n}' % (kind, key, ',\n  '.join(fields)))

    # inline thebibliography in the sources may hold keys the .bbl lacks
    for tex in glob.glob(os.path.join(os.path.dirname(bbl_path), '**', '*.tex'), recursive=True):
        t2 = io.open(tex, encoding='utf-8', errors='replace').read()
        if '\\begin{thebibliography}' not in t2:
            continue
        body2 = t2.split('\\begin{thebibliography}', 1)[1].split('\\end{thebibliography}', 1)[0]
        parts2 = re.split(r'\\bibitem(?:\[[^\]]*\])?\{([^}]*)\}', body2)
        for i in range(1, len(parts2), 2):
            key = sanitize_key(parts2[i])
            if not key or key in seen:
                continue
            seen.add(key)
            f = parse_plain(parts2[i + 1])
            fields = []
            if f['author']:
                fields.append('author = {%s}' % f['author'])
            fields.append('title = {%s}' % (f['title'] or key))
            for name in ('journal', 'year', 'volume', 'pages'):
                if f[name]:
                    fields.append('%s = {%s}' % (name, f[name]))
            kind = 'article' if f['journal'] else 'misc'
            entries.append('@%s{%s,\n  %s\n}' % (kind, key, ',\n  '.join(fields)))
    io.open(out_path, 'w', encoding='utf-8', newline='\n').write(
        '\n\n'.join(entries) + '\n')
    print('%s: %d entries -> %s' % (bbl_path, len(entries), out_path))


if __name__ == '__main__':
    root = sys.argv[1]
    bbl = pick_bbl(root)
    if not bbl:
        print('no bbl in', root)
        sys.exit(1)
    convert(bbl, os.path.join(root, 'refs_bbl.bib'))
