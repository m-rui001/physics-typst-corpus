#!/usr/bin/env python3
"""Repair bib entries whose title swallowed a broken CSL dump:
title = {authorAUTHORS titleTITLE journalJOURNAL volumeV, pagesP (yearY).}
"""
import re, sys

def conv_authors(raw):
    raw = raw.replace('~', ' ')
    raw = re.sub(r',\s*author', '|', raw)
    raw = re.sub(r'\s*&\s*author', '|', raw)
    toks = [t.strip() for t in raw.split('|') if t.strip()]
    names, etal = [], False
    for t in toks:
        if re.search(r'et\s*al\.?$', t):
            etal = True
            t = re.sub(r'\s*et\s*al\.?$', '', t).strip()
            if not t:
                continue
        if ', ' in t:
            last, ini = t.split(', ', 1)
            names.append(ini.strip() + ' ' + last.strip())
        elif ' ' in t or t.endswith('.'):
            names.append('{' + t.rstrip('.') + '}')
        else:
            names.append(t)
    if etal:
        return '{' + ', '.join(names) + ', et al.}'
    return ' and '.join(names)

def repair(title):
    s = title
    f = {}
    if ' title' not in s:
        m = re.match(r'^author(.*?) \(year(\d{4})\)(.*)$', s, re.S)
        if not m:
            return None
        f['author'] = conv_authors(m.group(1))
        f['year'] = m.group(2)
        f['title'] = ''
        f['volume'] = f['pages'] = f['journal'] = f['booktitle'] = f['publisher'] = ''
        dm = re.search(r'://(doi\.org/\S+?)[.\s]*$', m.group(3))
        f['url'] = 'https://' + dm.group(1) if dm else ''
        f['doi'] = dm.group(1)[len('doi.org/'):].rstrip('.') if dm else ''
        return f
    m = re.match(r'^author(.*?) title(.*)$', s, re.S)
    if not m:
        return None
    f['author'] = conv_authors(m.group(1))
    rest = m.group(2)
    f['url'] = ''
    dm = re.search(r'://(doi\.org/\S+?)[.\s]*$', s)
    if dm:
        f['url'] = 'https://' + dm.group(1)
        f['doi'] = dm.group(1)[len('doi.org/'):].rstrip('.')
        rest = rest[:rest.find('://')] if '://' in rest else rest
    ym = re.search(r'\(?year(\d{4})\)?', rest)
    f['year'] = ym.group(1) if ym else ''
    if ym:
        rest = rest[:ym.start()] + rest[ym.end():]
    pm = re.search(r'pages\s*([0-9A-Za-z\-]+)', rest)
    f['pages'] = pm.group(1) if pm else ''
    vm = re.search(r'volume\s*(\d+)', rest)
    f['volume'] = vm.group(1) if vm else ''
    f['journal'] = ''
    f['booktitle'] = ''
    f['publisher'] = ''
    bm = re.search(r'In booktitle(.*?)(?:,\s*(?:vol\.~?volume|pages|\(|organization|publisher|address|year))', rest, re.S)
    if bm:
        f['booktitle'] = bm.group(1).strip().rstrip(',')
        om = re.search(r'organization([^,)]+)', rest)
        f['publisher'] = om.group(1).strip() if om else ''
    else:
        jm = re.search(r'journal(.*?)(?:volume|pages|\(year|year|$)', rest, re.S)
        if jm:
            j = jm.group(1).strip().strip('.').strip()
            am = re.match(r'^arXiv preprint arXiv:(\d{4}\.\d{4,5})$', j)
            if am:
                f['journal'] = 'arXiv preprint'
                f['eprint'] = am.group(1)
            else:
                f['journal'] = j
    tm = re.match(r'^(.*?)(?:\.?\s*(?:journal|In booktitle|\(year).*)$', rest, re.S)
    tt = tm.group(1) if tm else rest
    f['title'] = tt.strip().rstrip('.').strip()
    return f

def esc(v):
    return v

def main(path):
    t = open(path, encoding='utf-8').read()
    pat = re.compile(r'@(\w+)\{([^,\n]+),\n((?:(?!\n@).)*?)\n\}', re.S)
    n = 0
    out = []
    last = 0
    for m in pat.finditer(t):
        typ, key, body = m.group(1), m.group(2), m.group(3)
        tm = re.search(r'^\s*title\s*=\s*\{(.*)\},?\s*$', body, re.M)
        if not tm or not tm.group(1).startswith('author'):
            continue
        f = repair(tm.group(1))
        if not f:
            continue
        nt = 'inproceedings' if f['booktitle'] else ('article' if f['journal'] else 'misc')
        lines = ['@%s{%s,' % (nt, key)]
        lines.append('  author = {%s},' % f['author'])
        if f['title']:
            lines.append('  title = {%s},' % f['title'])
        if f['journal']:
            lines.append('  journal = {%s},' % f['journal'])
        if f['booktitle']:
            lines.append('  booktitle = {%s},' % f['booktitle'])
        if f['publisher']:
            lines.append('  publisher = {%s},' % f['publisher'])
        if f['volume']:
            lines.append('  volume = {%s},' % f['volume'])
        if f['pages']:
            lines.append('  pages = {%s},' % f['pages'])
        if f['year']:
            lines.append('  year = {%s},' % f['year'])
        if f.get('doi'):
            lines.append('  doi = {%s},' % f['doi'])
        if f['url']:
            lines.append('  url = {%s},' % f['url'])
        if f.get('eprint'):
            lines.append('  eprint = {%s},' % f['eprint'])
            lines.append('  archiveprefix = {arXiv},')
        lines.append('}')
        out.append(t[last:m.start()])
        out.append('\n'.join(lines))
        last = m.end()
        n += 1
    out.append(t[last:])
    open(path, 'w', encoding='utf-8').write(''.join(out))
    print('repaired', n)

if __name__ == '__main__':
    main(sys.argv[1])
