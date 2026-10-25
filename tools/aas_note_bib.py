#!/usr/bin/env python3
"""Build refs.bib from an AASTeX .bbl.

Each entry keeps the bbl's final printed reference text in `note`; the CSL
style `aas.csl` prints only `note` in the bibliography, so the reference list
reproduces the original PDF verbatim (including "---." repeated authors).
`author` and `year` are parsed separately so @key citations still resolve.
"""
import re, sys, os, unicodedata

BS = chr(92)
BS2 = BS + BS

JMAP = {
    'apj': 'ApJ', 'apjl': 'ApJL', 'apjs': 'ApJS', 'aj': 'AJ', 'aap': 'A&A',
    'aaps': 'A&AS', 'araa': 'ARA&A', 'mnras': 'MNRAS', 'pasp': 'PASP',
    'prd': 'PhRvD', 'prl': 'PhRvL', 'prc': 'PhRvC', 'pra': 'PhRvA',
    'pre': 'PhRvE', 'prx': 'PhRvX', 'prl': 'PhRvL', 'rmp': 'RvMP',
    'jcap': 'JCAP', 'physrep': 'Phys. Rep.', 'cqg': 'CQG', 'nat': 'Nature',
    'science': 'Science', 'icarus': 'Icarus', 'solphys': 'Sol. Phys.',
    'ssr': 'Space Sci. Rev.', 'nar': 'New A Rev.', 'newast': 'New A',
    'apss': 'Ap&SS', 'universe': 'Universe', 'galax': 'Galaxies',
    'pasa': 'PASA', 'sovast': 'Sov. Astron.', 'baas': 'BAAS',
    'procspie': 'Proc. SPIE', 'aipconf': 'AIP Conf. Proc.',
    'epjc': 'EPJ C', 'npb': 'NuPhB', 'plb': 'PhLB', 'jhep': 'JHEP',
    'aapr': 'A&ARv', 'rmxaa': 'RMxAA', 'mpc': 'MNRAS', 'ap': 'Astropart. Phys.',
    'gafd': 'GApFD', 'jgr': 'JGR', 'jgrb': 'JGRB', 'psst': 'PSST',
    'memsai': 'Mem. SAI', 'assa': 'AN', 'an': 'AN', 'jcap': 'JCAP',
}
ACC = {'v': '\u030c', "'": '\u0301', '`': '\u0300', '"': '\u0308', '^': '\u0302',
       '~': '\u0303', 'c': '\u0327', '.': '\u0307', 'u': '\u0306', '=': '\u0304',
       'H': '\u030b', 'k': '\u0328', 'r': '\u030a'}

MATH = {
    'alpha': '\u03b1', 'beta': '\u03b2', 'gamma': '\u03b3', 'delta': '\u03b4',
    'epsilon': '\u03f5', 'varepsilon': '\u03b5', 'zeta': '\u03b6', 'eta': '\u03b7',
    'theta': '\u03b8', 'iota': '\u03b9', 'kappa': '\u03ba', 'lambda': '\u03bb',
    'mu': '\u03bc', 'nu': '\u03bd', 'xi': '\u03be', 'pi': '\u03c0', 'rho': '\u03c1',
    'sigma': '\u03c3', 'tau': '\u03c4', 'upsilon': '\u03c5', 'phi': '\u03d5',
    'varphi': '\u03c6', 'chi': '\u03c7', 'psi': '\u03c8', 'omega': '\u03c9',
    'Gamma': '\u0393', 'Delta': '\u0394', 'Theta': '\u0398', 'Lambda': '\u039b',
    'Xi': '\u039e', 'Pi': '\u03a0', 'Sigma': '\u03a3', 'Upsilon': '\u03a5',
    'Phi': '\u03a6', 'Psi': '\u03a8', 'Omega': '\u03a9',
    'odot': '\u2299', 'odot': '\u2299', 'sim': '\u223c', 'lesssim': '\u2272',
    'gtrsim': '\u2273', 'simeq': '\u2243', 'approx': '\u2248', 'propto': '\u221d',
    'times': '\u00d7', 'pm': '\u00b1', 'mp': '\u2213', 'leq': '\u2264',
    'le': '\u2264', 'geq': '\u2265', 'ge': '\u2265', 'neq': '\u2260',
    'll': '\u226a', 'gg': '\u226b', 'infty': '\u221e', 'rightarrow': '\u2192',
    'to': '\u2192', 'leftarrow': '\u2190', 'leftrightarrow': '\u2194',
    'equiv': '\u2261', 'nabla': '\u2207', 'partial': '\u2202',
    'langle': '\u27e8', 'rangle': '\u27e9', 'circ': '\u00b0', 'deg': '\u00b0',
    'prime': '\u2032', 'ldots': '\u2026', 'dots': '\u2026', 'sun': '\u2609',
    'perp': '\u22a5', 'parallel': '\u2225', 'star': '\u22c6', 'ast': '*',
    'oplus': '\u2295', 'otimes': '\u2297', 'in': '\u2208', 'sub': '\u2282',
    'sim': '\u223c', 'e': 'e', 'h': 'h', 'k': 'k', 'eV': 'eV', 'keV': 'keV',
    'MeV': 'MeV', 'GeV': 'GeV', 'TeV': 'TeV', 'msun': 'M\u2609',
    'Lambda': '\u039b', 'chi': '\u03c7',
}
SUP = {'0': '\u2070', '1': '\u00b9', '2': '\u00b2', '3': '\u00b3', '4': '\u2074',
       '5': '\u2075', '6': '\u2076', '7': '\u2077', '8': '\u2078', '9': '\u2079',
       'a': '\u1d43', 'b': '\u1d47', 'c': '\u1d9c', 'd': '\u1d48', 'e': '\u1d49',
       'f': '\u1da0', 'g': '\u1d4d', 'h': '\u02b0', 'i': '\u2071', 'j': '\u02b2',
       'k': '\u1d4f', 'l': '\u02e1', 'm': '\u1d50', 'n': '\u207f', 'o': '\u1d52',
       'p': '\u1d56', 'r': '\u02b3', 's': '\u02e2', 't': '\u1d57', 'u': '\u1d58',
       'v': '\u1d5b', 'w': '\u02b7', 'x': '\u02e3', 'y': '\u02b8', 'z': '\u1dbb',
       '+': '\u207a', '-': '\u207b', '=': '\u207c', '(': '\u207d', ')': '\u207e',
       '\u2212': '\u207b', '\u00b0': '\u00b0', '*': '*'}
SUB = {'0': '\u2080', '1': '\u2081', '2': '\u2082', '3': '\u2083', '4': '\u2084',
       '5': '\u2085', '6': '\u2086', '7': '\u2087', '8': '\u2088', '9': '\u2089',
       '+': '\u208a', '-': '\u208b', '=': '\u208c', '(': '\u208d', ')': '\u208e',
       'a': '\u2090', 'e': '\u2091', 'o': '\u2092', 'x': '\u2093', '\u2212': '\u208b'}


def braced(s, i):
    """s[i] must be '{'; return (content, index_after_closing_brace)."""
    assert s[i] == '{', (i, s[i:i + 20])
    d = 0
    for j in range(i, len(s)):
        if s[j] == '{':
            d += 1
        elif s[j] == '}':
            d -= 1
            if d == 0:
                return s[i + 1:j], j + 1
    return s[i + 1:], len(s)


def math_conv(m):
    t = m.group(1)
    t = re.sub(BS2 + r'([A-Za-z]+)', lambda k: MATH.get(k.group(1), k.group(1)), t)
    t = re.sub(BS2 + r'([,;:! ])', ' ', t)
    t = t.replace('{', '').replace('}', '')
    t = t.replace('^', '^').replace('_', '_')

    def sup(mm):
        return ''.join(SUP.get(ch, ch) for ch in mm.group(1))
    def sub(mm):
        return ''.join(SUB.get(ch, ch) for ch in mm.group(1))
    t = re.sub(r'\^\{([^{}]*)\}', sup, t)
    t = re.sub(r'\^(\w)', sup, t)
    t = re.sub(r'_\{([^{}]*)\}', sub, t)
    t = re.sub(r'_(\w)', sub, t)
    t = t.replace('\\', '')
    return t


def dec_tex(t):
    t = t.replace('\r', ' ')
    out = []
    i = 0
    while i < len(t):
        m = re.match(BS2 + r'(href|url|nolinkurl)\s*\{', t[i:])
        if m:
            cmd = m.group(1)
            j = i + m.end() - 1
            a, j2 = braced(t, j)
            if cmd == 'href' and j2 < len(t) and t[j2:j2 + 1] == '{':
                b, j3 = braced(t, j2)
                out.append(b)
                i = j3
            else:
                i = j2
            continue
        out.append(t[i])
        i += 1
    t = ''.join(out)
    # macro aliases that print a prefix
    for cmd, pre in (('doi', DOI_PREFIX), ('dodoi', DOI_PREFIX), ('arxiv', 'arXiv:'),
                     ('eprint', 'arXiv:'), ('adsurl', '')):
        t = re.sub(BS2 + cmd + r'\s*\{', lambda m, p=pre: '\x01' + p + '{', t)
    t = t.replace('\x01', '')
    t = re.sub(BS2 + r'natexlab\{([a-z])\}', r'\1', t)
    t = re.sub(BS2 + r'natexlab\{([a-z])\}', r'\1', t)
    t = re.sub(BS2 + r'{\\ss}', 'ss', t)
    t = re.sub(BS2 + r'{\\i}', 'i', t)
    t = re.sub(BS2 + r'i\s*\{\}', 'i', t)
    t = re.sub(BS2 + r'j\s*\{\}', 'j', t)

    def acc(m):
        return m.group(2) + ACC.get(m.group(1), '')
    t = re.sub(BS2 + r"\{?([\'`\"^~.])\s*\{?([A-Za-z])\}?\}?", acc, t)
    t = re.sub(BS2 + r'\{?([vcuHk=r])\s*\{?\s*([A-Za-z])\}?\}?', acc, t)
    t = t.replace('~', ' ')
    t = re.sub(BS2 + r'([&%_#$])', r'\1', t)
    # journal macros (keep unknown commands intact so the next step can drop them)
    t = re.sub(BS2 + r'([A-Za-z]+)', lambda m: JMAP.get(m.group(1), m.group(0)), t)
    t = re.sub(BS2 + r'newblock', ' ', t)
    t = re.sub(BS2 + r'ensuremath\s*\{([^{}]*)\}', r'$\1$', t)
    t = re.sub(BS2 + r'(?:emph|textit|textbf|textrm|textsc|mathrm|mathbf|mathit|text|scshape|it|bf|rm|sc|protect|relax|bibinfo|etal|ensuremath)\s*', '', t)
    t = re.sub(r'\$([^$]*)\$', math_conv, t)
    t = t.replace('{', '').replace('}', '')
    t = t.replace('---', '\u2014').replace('--', '\u2013').replace('``', '\u201c').replace("''", '\u201d')
    t = t.replace(BS, '')
    t = re.sub(r'\s+', ' ', t).strip()
    return unicodedata.normalize('NFC', t)


INIT = re.compile(r'^[A-Z]\.(?:[\s-]*[A-Z]\.)*$')
DOI_PREFIX = 'doi: '


def parse_authors(raw):
    """'Abbott, B. P., Abbott, R., et al.' -> (['Abbott, B. P.', 'Abbott, R.'], True)."""
    raw = re.sub(BS2 + r'&', ' and ', raw)
    raw = dec_tex(raw)
    raw = raw.rstrip(' ')
    others = bool(re.search(r'\bet al\b\.?$', raw))
    raw = re.sub(r',?\s*\bet al\b\.?$', '', raw)
    raw = raw.rstrip(' ,')
    last = raw.rsplit(',', 1)[-1].strip()
    if last.endswith('.') and not INIT.match(last):
        raw = raw[:-1].rstrip(' ,')
    raw = re.sub(r',?\s+(?:and|&)\s+', ', ', raw)
    toks = [x.strip() for x in raw.split(',') if x.strip()]
    names = []
    i = 0
    while i < len(toks):
        t = toks[i]
        if i + 1 < len(toks) and INIT.match(toks[i + 1]):
            names.append(t + ', ' + toks[i + 1])
            i += 2
        else:
            # Springer/aa.bst style: "Aartsen MG" (surname + undotted initials)
            m2 = re.match(r'^(.+?)\s+([A-Z]{1,3}\.?)$', t)
            if m2 and not INIT.match(t):
                fam, ini = m2.group(1), m2.group(2).replace('.', '')
                names.append(fam + ', ' + ' '.join(c + '.' for c in ini))
            else:
                names.append(t)
            i += 1
    return names, others


def parse_bbl(path):
    t = open(path, encoding='utf-8', errors='replace').read().replace('\r\n', '\n')
    if t.startswith('\ufeff'):
        t = t[1:]
    entries = []
    pos = 0
    while True:
        i = t.find(BS + 'bibitem', pos)
        if i < 0:
            break
        j = i + len(BS + 'bibitem')
        while j < len(t) and t[j] in ' \t\n':
            j += 1
        if j < len(t) and t[j] == '[':
            d = 0
            k = j
            while k < len(t):
                if t[k] == '{':
                    d += 1
                elif t[k] == '}':
                    d -= 1
                elif t[k] == ']' and d == 0:
                    break
                k += 1
            j = k + 1
        while j < len(t) and t[j] in ' \t\n':
            j += 1
        if j >= len(t) or t[j] != '{':
            pos = j
            continue
        key, j = braced(t, j)
        nxt = t.find(BS + 'bibitem', j)
        body = t[j:nxt if nxt >= 0 else len(t)]
        e = body.find(BS + 'end{thebibliography}')
        if e >= 0:
            body = body[:e]
        body = re.sub(r'\s+', ' ', body).strip()
        entries.append((key.strip(), body))
        pos = nxt if nxt >= 0 else len(t)
    return entries


def body_authors_year(body):
    # year = first 19xx/20xx not part of a volume list; authors precede it
    b = re.sub(r'\{\\' + r'natexlab\{([a-z])\}\}', r'\1', body)
    m = re.search(r'(?:^|[\s,.(\[])((?:19|20)\d{2})(?:\s*[a-z])?(?:[,.)\]]|$)', b)
    if not m:
        return [], False, ''
    authors_raw = b[:m.start()].strip().rstrip(',').strip().lstrip('(').strip()
    year = m.group(1)
    if re.fullmatch(r'[-\u2013\u2014.\s]+', authors_raw):
        return None, False, year  # dash: same as previous
    names, others = parse_authors(authors_raw)
    return names, others, year


def esc_note(s):
    return s.replace('{', '').replace('}', '').replace('@', "'").replace('=', ' ')


def parse_old_bib(path):
    s = open(path, encoding='utf-8', errors='replace').read()
    out = []
    for part in re.split(r'(?m)^\s*(?=@\w+\{)', s):
        m = re.match(r'@\w+\{([^,]+),', part)
        if not m:
            continue
        key, body = m.group(1).strip(), part[m.end():]
        f = {}
        i = 0
        for fm in re.finditer(r'(\w+)\s*=\s*', body):
            if fm.start() < i:
                continue
            k = fm.group(1).strip().lower()
            p = fm.end()
            if p < len(body) and body[p] == '{':
                val, j = braced(body, p)
            elif p < len(body) and body[p] == '"':
                j = body.find('"', p + 1)
                j = len(body) if j < 0 else j + 1
                val = body[p + 1:j - 1]
            else:
                m2 = re.match(r'[^,\n]+', body[p:])
                val = m2.group(0) if m2 else ''
                j = p + len(val)
            f[k] = val.strip()
            i = j
        au = f.get('author', '')
        first = re.split(r'\s+and\s+', au)[0] if au else ''
        first = first.split(',')[0]
        first = re.sub(r'[{}]', '', first).strip()
        if ' ' in first and ',' not in au.split(' and ')[0]:
            first = first.split()[-1]  # "Giorgio Arcadi" -> "Arcadi"
        out.append({'key': key, 'first': first, 'dash': bool(re.fullmatch(r'[-—–.\s]+', au.strip())) if au.strip() else False, 'year': re.sub(r'\D', '', f.get('year', ''))[:4],
                    'volume': f.get('volume', '').strip(), 'pages': f.get('pages', '').strip(),
                    'journal': f.get('journal', '').strip(), 'title': f.get('title', '').strip(),
                    'authors': au, 'doi': f.get('doi', '')})
    for o in out:
        if not o['first'] and o['title']:
            m = re.search(r'\b((?:19|20)\d{2})\b', o['title'])
            if m:
                o['year'] = m.group(1)
            tok = [x.strip(' {}') for x in o['title'].split(',')]
            o['pages'] = tok[-1].strip(' {}')
    return out


def match_rows(rows, old):
    """rows: bbl entries (key,names,others,year,note). Return list in old-key order."""
    from collections import defaultdict
    idx = defaultdict(list)
    for j, r in enumerate(rows):
        surf = r[1][0].split(',')[0].lower() if r[1] else ''
        idx[(surf, r[3])].append(j)
    used = set()
    out = []
    miss = 0
    missed = set()
    bykey = {}
    for j, r in enumerate(rows):
        bykey.setdefault(r[0], j)
    fixed = {}
    for o in old:
        j = bykey.get(o['key'])
        if j is not None and j not in used:
            used.add(j)
            fixed[o['key']] = j
    for o in old:
        if o['key'] in fixed:
            j = fixed[o['key']]
            out.append((o['key'], rows[j][1], rows[j][2], rows[j][3], rows[j][4]))
            continue
        surf = o['first'].lower()
        dash = o.get('dash')
        if dash:
            cands = [j for j, r in enumerate(rows)
                     if j not in used and r[4].startswith('\u2014') and r[3] == o['year']]
        else:
            cands = [j for j in idx.get((surf, o['year']), []) if j not in used]
            if not cands and surf:
                cands = [j for (s, y), js in idx.items() if s == surf for j in js if j not in used]
        pick = None
        for j in cands:
            note = rows[j][4]
            if o['volume'] and re.search(r'\b' + re.escape(o['volume']) + r'\b', note):
                if not pick:
                    pick = j
                if o['pages'] and o['pages'].split('-')[0] in note:
                    pick = j
                    break
        if pick is None and cands:
            pick = cands[0]
        if pick is None:
            # second chance: unique volume+first page among unused entries
            vp = [j for j, r in enumerate(rows) if j not in used and o['volume']
                  and re.search(r'\b' + re.escape(o['volume']) + r'\b', r[4])
                  and o['pages'] and o['pages'].split('-')[0] in r[4]]
            if len(vp) == 1:
                pick = vp[0]
        if pick is None and o['pages'] and o['year']:
            pg = [j for j, r in enumerate(rows)
                  if j not in used and r[3] == o['year']
                  and r[4].rstrip(' .').endswith(o['pages'])]
            if len(pg) == 1:
                pick = pg[0]
        if pick is None:
            miss += 1
            note = synth_note(o)
            names = parse_authors(o['authors'])[0]
            others = bool(re.search(r'\bet al\b|\bothers\b', o['authors']))
            out.append((o['key'], names, others, o['year'], note))
            missed.add(o['key'])
        else:
            used.add(pick)
            r = rows[pick]
            out.append((o['key'], r[1], r[2], r[3], r[4]))
    return out, miss, missed


def clean_name(n):
    n = n.replace('~', ' ')
    n = re.sub(r"\\\\(?:['`\"^~vcHkru=])\s*\{?([A-Za-z])\}?", lambda m: m.group(1) + ACC[m.group(0)[1]], n)
    n = re.sub(r'\\ss\b', 'ss', n)
    return re.sub(r'[{}]', '', n).strip()


def fmt_name(n):
    n = clean_name(n)
    n = n.replace(' and ', ' ').strip(' ,')
    if ',' in n:
        fam, ini = [x.strip() for x in n.split(',', 1)]
        return fam + ', ' + ini if ini else fam
    toks = n.split()
    if len(toks) < 2:
        return n
    return toks[-1] + ', ' + ' '.join(x[0] + '.' for x in toks[:-1] if x)


def synth_note(o):
    raw = re.sub(r'\s+and\s+others\b', ' ', o['authors'])
    parts = [x for x in re.split(r'\s+and\s+', raw) if x.strip()]
    names = [fmt_name(x) for x in parts]
    et = 'et al.' if len(names) > 3 or ' and others' in o['authors'] else ''
    names = names[:3]
    au = ', '.join(names)
    if au and not au.endswith('.'):
        au += '.'
    if et:
        au += ', et al.'
    tail = ', '.join(x for x in [o['year'], o['journal'].strip('{}'), o['volume'],
                                 o['pages'].strip('{}')] if x)
    if o['doi']:
        tail += ', doi: ' + o['doi']
    return (au + ' ' + tail).strip()


def load_cls_jmap(path):
    s = open(path, encoding='utf-8', errors='replace').read()
    out = {}
    pat = (r'\\(?:re)?newcommand\s*\{?\\([A-Za-z]+)\}?\s*\{[^{}]*?\\ref@jnl\{([^{}]*)\}'
           r'|\\def\s*\\([A-Za-z]+)\s*\{[^{}]*?\\ref@jnl\{([^{}]*)\}')
    for m in re.finditer(pat, s.replace('\\\\', '\\')):
        name = m.group(1) or m.group(3)
        val = m.group(2) if m.group(1) else m.group(4)
        out[name] = val.replace('\\&', '&').replace('\\ ', ' ').replace('~', ' ')
    return out


def main(bbl, out, quiet=False, keys_from=None, cls=None, cites=None):
    global DOI_PREFIX
    header = open(bbl, encoding='utf-8', errors='replace').read(4000)
    if re.search(r'\\url\{https?://doi\.org/#1\}', header):
        DOI_PREFIX = 'https://doi.org/'
    for c in ([cls] if isinstance(cls, str) else (cls or [])):
        JMAP.update(load_cls_jmap(c))
    entries = parse_bbl(bbl)
    prev_names, prev_others = [], False
    rows = []
    for key, body in entries:
        note = dec_tex(body)
        names, others, year = body_authors_year(body)
        if names is None:
            names, others = list(prev_names), prev_others
        if names:
            prev_names, prev_others = list(names), others
        rows.append((key, names, others, year, note))
    if keys_from:
        old = parse_old_bib(keys_from)
        bbl_notes = {r[4] for r in rows}
        bbl_rows = list(rows)
        rows, miss, missed = match_rows(rows, old)
        # duplicate-key repair: stub entries (e.g. 2017A-A vs 2017AandA) reuse notes
        def norm(k):
            return re.sub(r'[^a-z0-9]', '', k.lower().replace('and', ''))
        good = {norm(k): (n, o, y, note) for (k, n, o, y, note) in rows if note in bbl_notes}
        fixed = 0
        for i, (k, n, o, y, note) in enumerate(rows):
            if note not in bbl_notes and norm(k) in good:
                rows[i] = (k,) + good[norm(k)]
                fixed += 1
        seen = {r[4] for r in rows}
        extra = [r for r in bbl_rows if r[4] not in seen]
        rows.extend(extra)
        if cites:
            txt = ''
            for f in cites:
                txt += open(f, encoding='utf-8', errors='replace').read()
            cited = set(re.findall(r'@([A-Za-z0-9_][A-Za-z0-9_:.\-]*)', txt))
            cited |= set(re.findall(r'cite\(\s*<([^>]+)>', txt))
            bkeys = {r[0] for r in bbl_rows}
            drop = lambda r: r[0] in missed and r[0] not in cited and r[0] not in bkeys
            dropped = [r for r in rows if drop(r)]
            rows = [r for r in rows if not drop(r)]
            if not quiet:
                print('dropped', len(dropped), 'uncited old-bib entries')
        if not quiet:
            print('matched', len(rows) - miss, 'of', len(rows), 'old keys;',
                  'norm-recovered', fixed)
    dedup = {}
    for r in rows:
        k = r[0].replace('+', '-')
        if k not in dedup or len(r[4]) > len(dedup[k][4]):
            dedup[k] = r
    rows = list(dedup.values())
    with open(out, 'w', encoding='utf-8') as h:
        for key, names, others, year, note in rows:
            h.write('@article{%s,\n' % key.replace('+', '-'))
            auth = ' and '.join(names)
            if others and names:
                auth += ' and others'
            if auth:
                h.write('  author = {%s},\n' % auth)
            if year:
                h.write('  year = {%s},\n' % year)
            h.write('  note = {%s},\n}\n' % esc_note(note))
    if not quiet:
        print(out, 'entries', len(rows), 'no-author', sum(1 for r in rows if not r[1]))
        for r in rows[:5]:
            print('  ', r[0], '|', '; '.join(r[1])[:70], '|', r[3], '|', r[4][:110])


if __name__ == '__main__':
    args = sys.argv[1:]
    opts = {}
    for flag in ('--keys',):
        if flag in args:
            i = args.index(flag)
            opts[flag] = args[i + 1]
            del args[i:i + 2]
    clss = []
    while '--cls' in args:
        i = args.index('--cls')
        clss.append(args[i + 1])
        del args[i:i + 2]
    cites = []
    while '--cites' in args:
        i = args.index('--cites')
        cites.append(args[i + 1])
        del args[i:i + 2]
    if len(args) < 2:
        sys.exit('usage: aas_note_bib.py BBL OUT.bib [--keys OLD.bib] [--cls CLASS.cls]'
                 ' [--cites MAIN.typ ...]')
    main(args[0], args[1], keys_from=opts.get('--keys'), cls=clss, cites=cites)
