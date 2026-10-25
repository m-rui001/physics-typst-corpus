#!/usr/bin/env python3
"""Repair full-citation titles: title = {AUTHORS, “TITLE,” REST} into proper fields."""
import re, sys

YEAR = re.compile(r'\b((?:19|20)\d{2})\b')

def conv_authors(raw):
    raw = raw.replace('~', ' ')
    toks = [re.sub(r'^and\s+', '', t.strip()) for t in raw.split(',') if t.strip()]
    return ' and '.join(toks)

def repair(title):
    m = re.match(r'^(.*?), \u201c(.*?),\u201d\s*(.*)$', title, re.S)
    if not m:
        return None
    f = {'author': conv_authors(m.group(1)), 'title': m.group(2).strip().rstrip(','),
         'journal': '', 'booktitle': '', 'publisher': '', 'volume': '', 'number': '',
         'pages': '', 'year': '', 'doi': '', 'url': '', 'eprint': ''}
    rest = m.group(3).replace('~', ' ').strip()
    ys = YEAR.findall(rest)
    if ys:
        f['year'] = ys[-1]
    pm = re.search(r'pp?\.\s*([0-9A-Za-z]+(?:--[0-9A-Za-z]+)?)', rest)
    if pm:
        f['pages'] = pm.group(1)
    vm = re.search(r'vol\.\s*(\d+)', rest)
    if vm:
        f['volume'] = vm.group(1)
    nm = re.search(r'no\.\s*(\d+)', rest)
    if nm:
        f['number'] = nm.group(1)
    dm = re.search(r'https?://(?:dx\.)?doi\.org/(\S+)', rest)
    if dm:
        f['doi'] = dm.group(1).rstrip('.')

    head = re.split(r',\s*(?:vol\.|no\.|pp?\.|\b(?:19|20)\d{2}\b)', rest)[0].strip().rstrip(',').strip()
    am = re.match(r'^(?:arXiv preprint )?arXiv:\s*(\d{4}\.\d{4,5})', head)
    if am:
        f['eprint'] = am.group(1)
        f['journal'] = 'arXiv preprint'
        return f
    if 'arXiv:' in head:
        f['eprint'] = re.search(r'arXiv:\s*(\d{4}\.\d{4,5})', head).group(1)
        j = re.split(r',?\s*(?:To Appear|to appear|Preprint|preprint)', head)[0].strip().rstrip(',').strip()
        f['journal'] = j if j and not j.lower().startswith('preprint') else 'arXiv preprint'
        return f
    if head.lower().startswith('in '):
        f['booktitle'] = head[3:].strip()
        return f
    if re.search(r'\b(?:Press|Publishers?|Media|Ltd\.?|Wiley|Springer|Elsevier)\b', head):
        f['publisher'] = re.sub(r',\s*(?:Ltd\.?)?.*$', '', head).strip().rstrip(',')
        f['journal'] = ''
        return f
    if re.search(r'\bConference\b', head):
        b = head.split('.')[0]
        f['booktitle'] = b
        return f
    if head.startswith('Technical Report'):
        f['journal'] = 'Technical Report'
        return f
    f['journal'] = head
    return f

def main(path):
    t = open(path, encoding='utf-8').read()
    out, last, n = [], 0, 0
    pat = re.compile(r'@(\w+)\{([^,\n]+),\n((?:(?!\n@).)*?)\n\}', re.S)
    for m in pat.finditer(t):
        typ, key, body = m.group(1), m.group(2), m.group(3)
        tm = re.search(r'^\s*title\s*=\s*\{(.*)\},?\s*$', body, re.M)
        if not tm or '\u201c' not in tm.group(1):
            continue
        f = repair(tm.group(1))
        if not f or not (f['journal'] or f['booktitle'] or f['publisher']):
            continue
        nt = ('inproceedings' if f['booktitle'] else
              'book' if f['publisher'] else
              'article' if f['journal'] and f['journal'] != 'arXiv preprint' else 'misc')
        lines = ['@%s{%s,' % (nt, key), '  author = {%s},' % f['author'], '  title = {%s},' % f['title']]
        if f['journal']:
            lines.append('  journal = {%s},' % f['journal'])
        if f['booktitle']:
            lines.append('  booktitle = {%s},' % f['booktitle'])
        if f['publisher']:
            lines.append('  publisher = {%s},' % f['publisher'])
        if f['volume']:
            lines.append('  volume = {%s},' % f['volume'])
        if f['number']:
            lines.append('  number = {%s},' % f['number'])
        if f['pages']:
            lines.append('  pages = {%s},' % f['pages'])
        if f['year']:
            lines.append('  year = {%s},' % f['year'])
        if f['doi']:
            lines.append('  doi = {%s},' % f['doi'])
        if f['eprint']:
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
