import re, sys

ENT = re.compile(r'@(\w+)\{([^,\n]+),\n((?:(?!\n@).)*?)\n\}', re.S)
TITLE = re.compile(r'^\s*title\s*=\s*\{(.*)\},?\s*$', re.M)

def parse(ti):
    s = ti.strip().rstrip('.')
    s = re.sub(r'\s*,?\s*arXiv:\s*[0-9A-Za-z.\-/]+\.?$', '', s)
    ym = re.search(r'\((\d{4})\)\s*$', s)
    if not ym:
        return None
    year = ym.group(1)
    s = s[:ym.start()].rstrip().rstrip(',')
    pm = re.search(r'([A-Za-z]*\d+[A-Za-z]*(?:--[A-Za-z]*\d+[A-Za-z]*)?)\s*$', s)
    if not pm:
        return None
    pages = pm.group(1)
    s = s[:pm.start()].rstrip().rstrip(',')
    vm = re.search(r'(\d+[A-Za-z]?)(?:\((\d+)\))?\s*$', s)
    volume = number = ''
    if vm:
        volume, number = vm.group(1), vm.group(2) or ''
        s = s[:vm.start()].rstrip().rstrip(',')
    m = re.match(r'^(.*?),\s*([^,]*)$', s)
    if not m:
        return None
    authors, journal = m.group(1).strip(), m.group(2).strip()
    if not re.search(r'[A-Za-z]', authors):
        return None
    if 'In ' in journal or journal.startswith('In '):
        return None
    if re.match(r'^[A-Z]\d+$', volume):
        journal = (journal + ' ' + volume[0]).strip()
        volume = volume[1:]
    if ' et al' in authors:
        author = '{{' + authors.replace(' et al', ', et al') + '}}'
    else:
        author = authors
    return author, journal, volume, number, pages, year

def main(path):
    t = open(path, encoding='utf-8').read()
    out, last, n = [], 0, 0
    for m in ENT.finditer(t):
        body = m.group(3)
        tm = TITLE.search(body)
        if not tm or '(' not in tm.group(1) or 'arXiv' not in tm.group(1):
            continue
        r = parse(tm.group(1))
        if not r:
            continue
        author, journal, volume, number, pages, year = r
        lines = ['@%s{%s,' % ('article' if journal else 'misc', m.group(2)),
                 '  author = {%s},' % author, '  title = {},']
        # title is not recoverable from the dump: keep a placeholder-free title-less entry
        lines = [l for l in lines if 'title = {}' not in l]
        if journal:
            lines.append('  journal = {%s},' % journal)
        if volume:
            lines.append('  volume = {%s},' % volume)
        if number:
            lines.append('  number = {%s},' % number)
        if pages:
            lines.append('  pages = {%s},' % pages)
        lines.append('  year = {%s},' % year)
        lines.append('}')
        out.append(t[last:m.start()])
        out.append('\n'.join(lines))
        last = m.end()
        n += 1
    out.append(t[last:])
    if n:
        open(path, 'w', encoding='utf-8').write(''.join(out))
    print('repaired', n)

if __name__ == '__main__':
    main(sys.argv[1])
