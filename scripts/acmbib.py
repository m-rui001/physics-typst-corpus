import re, sys, os

ACC = {
    'o': 'ø', 'O': 'Ø', 'ss': 'ß', 'ae': 'æ', 'AE': 'Æ', 'oe': 'œ', 'l': 'ł',
    'L': 'Ł', 'aa': 'å', 'AA': 'Å', 'i': 'ı', 'j': 'ȷ',
}
ACCENTS = {
    "'": {'a': 'á', 'e': 'é', 'i': 'í', 'o': 'ó', 'u': 'ú', 'y': 'ý', 'c': 'ć',
          'n': 'ń', 's': 'ś', 'z': 'ź', 'A': 'Á', 'E': 'É', 'I': 'Í', 'O': 'Ó',
          'U': 'Ú', 'C': 'Ć', 'N': 'Ń', 'S': 'Ś', 'Z': 'Ź'},
    '`': {'a': 'à', 'e': 'è', 'i': 'ì', 'o': 'ò', 'u': 'ù', 'A': 'À', 'E': 'È'},
    '^': {'a': 'â', 'e': 'ê', 'i': 'î', 'o': 'ô', 'u': 'û', 'A': 'Â', 'E': 'Ê'},
    '"': {'a': 'ä', 'e': 'ë', 'i': 'ï', 'o': 'ö', 'u': 'ü', 'y': 'ÿ',
          'A': 'Ä', 'E': 'Ë', 'I': 'Ï', 'O': 'Ö', 'U': 'Ü'},
    '~': {'a': 'ã', 'n': 'ñ', 'o': 'õ', 'A': 'Ã', 'N': 'Ñ', 'O': 'Õ'},
    'v': {'c': 'č', 's': 'š', 'z': 'ž', 'r': 'ř', 'e': 'ě', 'C': 'Č', 'S': 'Š', 'Z': 'Ž'},
    'c': {'c': 'ç', 's': 'ş', 't': 'ţ', 'C': 'Ç', 'S': 'Ş'},
    'u': {'a': 'ă', 'g': 'ğ', 'G': 'Ğ'},
    'H': {'o': 'ő', 'u': 'ű'},
}


def clean(s):
    if not s:
        return ''
    s = re.sub(r'\\url\{([^{}]*)\}', r'\1', s)
    s = re.sub(r'\\(emph|textbf|textit|textsc|mathrm|text|mbox|showarticletitle|bibinfo|bibfield|natexlab)\s*\{([^{}]*)\}', r'\2', s)
    # accents like {\"u}, \'{e}, {\c{c}}
    def acc(m):
        kind, ch = m.group(1), m.group(2)
        return ACCENTS.get(kind, {}).get(ch, ch)
    s = re.sub(r'\\[\'"`^~vcuH]\s*\{?([A-Za-z])\}?', lambda m: ACCENTS.get(m.group(0)[1], {}).get(m.group(1), m.group(1)), s)
    for k, v in ACC.items():
        s = re.sub(r'\{\\?' + k + r'\}', v, s)
        s = re.sub(r'\\' + k + r'(?![A-Za-z])', v, s)
    s = s.replace('~', ' ').replace('--', '–').replace('---', '—').replace('\,', ' ').replace('\;', ' ').replace('\ ', ' ')
    s = s.replace('\\&', '&').replace('\\%', '%').replace('\\_', '_').replace('\\$', '$').replace('\\#', '#')
    s = re.sub(r'\\([A-Za-z]+)', r'\1', s)
    s = s.replace('{', '').replace('}', '')
    s = re.sub(r'\s+', ' ', s).strip()
    s = s.replace(' .', '.').replace(' ,', ',').replace('..', '.')
    return s


def field(body, name):
    m = re.search(r'\\bibinfo\{' + name + r'\}\{((?:[^{}]|\{[^{}]*\})*)\}', body)
    return clean(m.group(1)) if m else ''


def esc(v):
    return v.replace('\\', '\\\\').replace('{', '\\{').replace('}', '\\}')


def parse(tex):
    start = tex.index('\\begin{thebibliography}')
    end = tex.index('\\end{thebibliography}')
    region = tex[start:end]
    parts = re.split(r'\\bibitem\[', region)[1:]
    out = []
    for p in parts:
        m = re.match(r'([\s\S]*?)\]%\s*\n\s*\{([^}]+)\}', p)
        if not m:
            continue
        opt, key = m.group(1), m.group(2).strip()
        body = p[m.end():]
        auth_opt = clean(opt.split('}{')[0].lstrip('\\protect\\citeauthoryear{')) if 'citeauthoryear' in opt else ''
        persons = [clean(x) for x in re.findall(r'\\bibinfo\{person\}\{((?:[^{}]|\{[^{}]*\}|\{\{[^{}]*\}\})*)\}', body)]
        persons = [x for x in persons if x]
        author = ' and '.join(persons) if persons else auth_opt
        year = field(body, 'year')
        title = ''
        m = re.search(r'\\showarticletitle\{', body)
        if m:
            rest = body[m.end():]
            depth, buf = 1, ''
            for ch in rest:
                if ch == '{':
                    depth += 1
                elif ch == '}':
                    depth -= 1
                    if depth == 0:
                        break
                buf += ch
            title = clean(buf)
        if not title:
            title = field(body, 'title')
        journal = field(body, 'journal')
        booktitle = field(body, 'booktitle')
        publisher = field(body, 'publisher')
        volume = field(body, 'volume')
        number = field(body, 'number')
        pages = field(body, 'pages')
        doi = ''
        md = re.search(r'\\url\{(https?://doi\.org/[^}]+)\}', body)
        if md:
            doi = md.group(1).split('doi.org/')[-1]
        if not doi:
            md = re.search(r'\\showDOI\{[^{}]*\\url\{([^}]+)\}', body)
            if md:
                doi = md.group(1)
        url = ''
        mu = re.search(r'\\url\{(https?://(?!doi\.org)[^}]+)\}', body)
        if mu:
            url = mu.group(1)
        if journal:
            typ, fields = 'article', {'journal': journal}
        elif booktitle:
            typ, fields = 'inproceedings', {'booktitle': booktitle}
        elif publisher:
            typ, fields = 'book', {'publisher': publisher}
        else:
            typ, fields = 'misc', {}
        if author and author.strip('? ') != '':
            fields['author'] = author
        if title:
            fields['title'] = title
        if year and any(c.isdigit() for c in year):
            fields['year'] = year
        for k, v in (('volume', volume), ('number', number), ('pages', pages), ('doi', doi), ('url', url)):
            if v:
                fields[k] = v
        lines = [f'@{typ}{{{key},'] + [f'  {k} = {{{esc(v)}}},' for k, v in fields.items()] + ['}']
        out.append('\n'.join(lines))
    return out


if __name__ == '__main__':
    src = open(sys.argv[1], encoding='utf-8').read()
    entries = parse(src)
    dst = sys.argv[2]
    with open(dst, 'w', encoding='utf-8') as f:
        f.write('\n\n'.join(entries) + '\n')
    print(f'{len(entries)} entries -> {dst}')
