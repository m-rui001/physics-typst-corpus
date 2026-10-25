#!/usr/bin/env python3
"""Convert AAS-style .bbl (\\bibitem[key]{key} Authors Year, Journal, Vol, Page) to .bib.

Unlike revtex bbl (title in \\emph{{...}}), AAS bbl often carries no title at all:
the entry body is "Authors YEAR, Journal, Volume, Page, \\dodoi{...}".
"""
import re, sys

B = chr(92)
BI = B + B + 'bibitem'

JMAP = {
    'apj': 'Astrophys. J.', 'apjl': 'Astrophys. J. Lett.', 'apjs': 'Astrophys. J. Suppl.',
    'mnras': 'Mon. Not. R. Astron. Soc.', 'prd': 'Phys. Rev. D', 'prl': 'Phys. Rev. Lett.',
    'araa': 'Annu. Rev. Astron. Astrophys.', 'aap': 'Astron. Astrophys.', 'jcap': 'J. Cosmol. Astropart. Phys.',
    'physrep': 'Phys. Rep.', 'cqg': 'Class. Quantum Grav.', 'nat': 'Nature', 'science': 'Science',
    'aj': 'Astron. J.', 'pasp': 'Publ. Astron. Soc. Pac.', 'icarus': 'Icarus', 'aaps': 'Astron. Astrophys. Suppl.',
    'ssr': 'Space Sci. Rev.', 'solphys': 'Sol. Phys.', 'gafd': 'Geophys. Astrophys. Fluid Dyn.',
    'nar': 'New Astron. Rev.', 'newast': 'New Astron.', 'apss': 'Astrophys. Space Sci.', 'universe': 'Universe',
    'galax': 'Galaxies', 'rmxaa': 'Rev. Mex. Astron. Astrofis.', 'mpc': 'Mon. Not. R. Astron. Soc.',
    'aapr': 'Astron. Astrophys. Rev.', 'aaps': 'Astron. Astrophys. Suppl.', 'ap': 'Astropart. Phys.',
    'jhep': 'J. High Energy Phys.', 'epjc': 'Eur. Phys. J. C', 'npb': 'Nucl. Phys. B', 'plb': 'Phys. Lett. B',
    'pasa': 'Publ. Astron. Soc. Aust.', 'sovast': 'Sov. Astron.', 'aap': 'Astron. Astrophys.',
    'procspie': 'Proc. SPIE', 'baas': 'Bull. Am. Astron. Soc.', 'aipconf': 'AIP Conf. Proc.',
}

ACC = {'v':'\u030c',"'":'\u0301','`':'\u0300','"':'\u0308','^':'\u0302','~':'\u0303','c':'\u0327','.':'\u0307','u':'\u0306','=':'\u0304','H':'\u030b','k':'\u0328','r':'\u030a'}

def dec_tex(t):
    t = t.replace('~', ' ')
    t = re.sub(B + r'{\\ss}', 'ss', t)
    def acc(m):
        return m.group(2) + ACC.get(m.group(1), '')
    t = re.sub(B + r"\{?([\'`\"^~.])\{?([A-Za-z])\}?\}?", acc, t)
    t = re.sub(B + r'\{?\\([vcuHk=r])\{?([A-Za-z])\}?\}?', acc, t)
    t = re.sub(r'\\(?:emph|textit|textbf|textrm|textsc|mathrm|mathbf|mathit|text|scshape|it|bf|rm|sc)\s*\{([^{}]*)\}', r'\1', t)
    t = re.sub(r'\\(?:etal|et~al\.)', 'et al.', t)
    t = t.replace('{', '').replace('}', '')
    t = re.sub(B + B + r'&', 'and', t)
    t = re.sub(r'\\([A-Za-z]+)', lambda m: JMAP.get(m.group(1), ''), t)
    t = t.replace(B, '')
    t = t.replace('--', '\u2013').replace('``', '\u201c').replace("''", '\u201d')
    return re.sub(r'\s+', ' ', t).strip()

def braced(s, i):
    assert s[i] == '{', (i, s[i:i+20])
    d = 0
    for j in range(i, len(s)):
        if s[j] == '{': d += 1
        elif s[j] == '}':
            d -= 1
            if d == 0:
                return s[i+1:j], j+1
    return s[i+1:], len(s)

INIT = re.compile(r'^[A-Z]\.(?:[\s-]*[A-Z]\.)*$')

def parse_authors(raw):
    s = raw.replace(B + '&', ' and ')
    toks = [x.strip() for x in s.split(',') if x.strip()]
    toks = [re.sub(r'^and\s+', '', x) for x in toks]
    names = []
    i = 0
    while i < len(toks):
        t = toks[i]
        if i + 1 < len(toks) and INIT.match(dec_tex(toks[i+1])):
            names.append(t + ', ' + toks[i+1]); i += 2
        else:
            names.append(t); i += 1
    return [dec_tex(n) for n in names]

def parse(path):
    t = open(path, encoding='utf-8', errors='replace').read().replace('\r\n', '\n')
    out = []
    pos = 0
    prev_author = ''
    prev_names = []
    while True:
        i = t.find(B + 'bibitem', pos)
        if i < 0: break
        j = i + len(B + 'bibitem')
        if j < len(t) and t[j] == '[':
            # label: match to the closing ] (labels here contain no brackets inside)
            k = t.index(']', j)
            j = k + 1
        while j < len(t) and t[j] in ' \t\n': j += 1
        key, j2 = braced(t, j)
        nxt = t.find(B + 'bibitem', j2)
        body = ' '.join(t[j2:nxt if nxt >= 0 else len(t)].split())
        body = body.replace('~', ' ')
        body = re.sub(B + B + r'natexlab\{[a-z]\}', '', body)
        e = parse_entry(key, body)
        if not e['author'] and prev_author:
            e['author'] = prev_author
            e['names'] = list(prev_names)
        if e['author']:
            prev_author = e['author']
            prev_names = e['names']
        out.append(e)
        pos = nxt if nxt >= 0 else len(t)
    return out

def parse_entry(key, body):
    e = {'key': key, 'author': '', 'names': [], 'title': '', 'journal': '', 'booktitle': '', 'volume': '', 'pages': '', 'year': '', 'doi': '', 'eprint': '', 'url': '', 'note': ''}
    def take(cmd):
        m = re.search(B + B + cmd + r'\{([^{}]*)\}', body)
        return m
    for cmd, field in [('dodoi','doi'), ('doarXiv','eprint'), ('doeprint','eprint'), ('url','url')]:
        m = take(cmd)
        while m:
            e[field] = m.group(1) if not e[field] else e[field]
            body = body[:m.start()] + ' ' + body[m.end():]
            m = take(cmd)
    nb = body.find(B + 'newblock')
    head = body[:nb] if nb >= 0 else body
    tail = body[nb + len(B + 'newblock'):].strip() if nb >= 0 else ''
    ym = re.search(r'(?:^|[ ,])((?:19|20)\d{2})(?=[,.{\s]|$)', head)
    if not ym:
        e['title'] = dec_tex(head)
        return e
    e['year'] = ym.group(1)
    authors_raw = head[:ym.start(1)].strip().rstrip(',').strip()
    if re.fullmatch(r'[-\u2013\u2014. ]+', authors_raw or ''):
        authors_raw = ''
    if authors_raw:
        e['names'] = parse_authors(authors_raw)
        e['author'] = ' and '.join(e['names'])
    rest = head[ym.end(1):].strip()
    rest = rest.lstrip(',.').strip()
    if rest.startswith('{'):
        title, end = braced(rest, 0)
        e['title'] = dec_tex(title)
        rest = rest[end:].lstrip('.').strip()
    journal_block = (rest.rstrip(' ,.') + ', ' + tail).strip(' ,.')
    journal_block = re.sub(r'\s*,\s*', ', ', journal_block)
    # strip trailing "doi" remnants
    journal_block = journal_block.strip(' ,.')
    am = re.search(r'arXiv:(\d{4}\.\d{4,5})', journal_block)
    if am:
        e['eprint'] = e['eprint'] or am.group(1)
        journal_block = re.sub(r'arXiv e-prints\s*,?\s*arXiv:\d{4}\.\d{4,5}', '', journal_block).strip(' ,.')
        if e['doi'].startswith('10.48550/arXiv'):
            e['doi'] = ''
    vol_hint = ''
    mv = re.search(r'Vol\.?\s*(\d+)', journal_block)
    if mv:
        vol_hint = mv.group(1)
        journal_block = (journal_block[:mv.start()] + journal_block[mv.end():]).strip(' ,.')
    if journal_block:
        parts = [x.strip() for x in journal_block.split(',') if x.strip()]
        # last one or two trailing tokens are page/volume
        pages = ''
        vol = ''
        if parts and re.fullmatch(r'[A-Za-z]?\d+[A-Za-z]?|[A-Z]{1,3}\d+', parts[-1]):
            pages = parts.pop()
        if parts and re.fullmatch(r'\d+', parts[-1]):
            vol = parts.pop()
        if parts and parts[0].lower().startswith('in '):
            parts[0] = parts[0][3:].strip()
            jn = dec_tex(parts[0])
            e['journal'] = ('in ' + jn) if jn.lower() in ('preparation', 'press') else jn
            if len(parts) > 1:
                e['booktitle'] = dec_tex(', '.join(parts[1:]))
        else:
            e['journal'] = dec_tex(', '.join(parts))
        e['volume'] = vol_hint or vol
        e['pages'] = pages
    if e['eprint'] and re.fullmatch(r'\d{4}\.\d{4,5}', e['eprint']):
        e['note'] = 'arXiv:' + e['eprint']
    return e

def write_bib(entries, path):
    def f(v):
        return v.replace('{', '').replace('}', '')
    with open(path, 'w', encoding='utf-8') as h:
        for e in entries:
            if e['booktitle']:
                typ = 'inproceedings'
                if e['journal']:
                    e['booktitle'] = e['journal'] + ', ' + e['booktitle']
                    e['journal'] = ''
            else:
                typ = 'article' if (e['journal'] or e['volume']) else 'misc'
            h.write('@%s{%s,\n' % (typ, e['key'].replace('+', '-')))
            if e['names']:
                if 'et al.' in e['names']:
                    shown = []
                    for n in e['names']:
                        if n == 'et al.':
                            continue
                        if ', ' in n:
                            last, ini = n.split(', ', 1)
                            shown.append(ini + ' ' + last)
                        else:
                            shown.append(n)
                    h.write('  author = {{%s, et al.}},\n' % ', '.join(shown))
                else:
                    names = []
                    for n in e['names']:
                        if 'Collaboration' in n:
                            names.append('{{%s}}' % n)
                        else:
                            names.append(n)
                    h.write('  author = {%s},\n' % ' and '.join(names))
            if e['title']:
                h.write('  title = {%s},\n' % f(e['title']))
            if e['journal']:
                h.write('  journal = {%s},\n' % f(e['journal']))
            if e['booktitle']:
                h.write('  booktitle = {%s},\n' % f(e['booktitle']))
            if e['volume']:
                h.write('  volume = {%s},\n' % e['volume'])
            if e['pages']:
                h.write('  pages = {%s},\n' % e['pages'])
            if e['year']:
                h.write('  year = {%s},\n' % e['year'])
            if e['doi']:
                h.write('  doi = {%s},\n' % e['doi'])
            if e['eprint']:
                h.write('  eprint = {%s},\n' % e['eprint'])
                h.write('  archiveprefix = {arXiv},\n')
            if e['url']:
                h.write('  url = {%s},\n' % e['url'])
            if e['note']:
                h.write('  note = {%s},\n' % e['note'])
            h.write('}\n')

if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8')
    es = parse(sys.argv[1])
    print('entries', len(es))
    n = int(sys.argv[2]) if len(sys.argv) > 2 else 10
    for e in es[:n]:
        print(e['key'], '|', e['year'], '|', e['author'][:80], '|', e['title'][:60], '|', e['journal'][:60], '|', e['volume'], '|', e['pages'], '|', e['doi'][:40], '|', e['url'][:40])
    if len(sys.argv) > 3:
        write_bib(es, sys.argv[3])
        print('wrote', sys.argv[3])
