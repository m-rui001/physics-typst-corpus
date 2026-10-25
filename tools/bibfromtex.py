"""Build refs.bib from a `thebibliography` environment (BibTeX/ACM output).

Used for papers whose arXiv bundle ships no .bib: the printed bibliography is
the only source of truth left.
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding='utf-8', errors='backslashreplace')

KEEP = ('person', 'title', 'year', 'journal', 'booktitle', 'publisher',
        'volume', 'number', 'pages', 'date', 'note', 'edition', 'series',
        'organization', 'howpublished', 'address', 'school', 'institution',
        'eprint')


def _clean(s):
    s = re.sub(r'\\url\s*\{([^{}]*)\}', r'\1', s)
    s = re.sub(r'\\(?:showURL|showDOI|showarticletitle|emph|bibinfo|bibfield)'
               r'\s*\{[^{}]*\}\s*\{', '{', s)
    s = re.sub(r'\\natexlab\s*\{[^{}]*\}', '', s)
    s = re.sub(r'\\newblock', ' ', s)
    s = re.sub(r'\\urldef\s*\\tempurl%?', '', s)
    s = re.sub(r'\\tempurl', '', s)
    s = re.sub(r'\\mbox\s*\{([^{}]*)\}', r'\1', s)
    s = s.replace('{and}', 'and').replace('~', ' ')
    s = s.replace('\\&', '&').replace('\\%', '%').replace('\\_', '_')
    s = re.sub(r'---', '—', s)
    s = re.sub(r'--', '–', s)
    s = re.sub(r'\\[A-Za-z]+\s*', '', s)
    s = re.sub(r'\\(.)', r'\1', s)
    s = s.replace('{', '').replace('}', '')
    return re.sub(r'\s+', ' ', s).strip()


def _field(body, name):
    m = re.search(r'\\bibinfo\s*\{' + name + r'\}\s*\{', body)
    if not m:
        return ''
    depth = 1
    i = m.end()
    while i < len(body) and depth:
        if body[i] == '{':
            depth += 1
        elif body[i] == '}':
            depth -= 1
        i += 1
    return body[m.end():i - 1]


def _title(body):
    t = _field(body, 'title')
    if t:
        return _clean(t)
    m = re.search(r'\\showarticletitle\s*\{', body)
    if not m:
        return ''
    depth = 1
    i = m.end()
    while i < len(body) and depth:
        if body[i] == '{':
            depth += 1
        elif body[i] == '}':
            depth -= 1
        i += 1
    return _clean(body[m.end():i - 1])


def _authors(body):
    raw = re.findall(r'\\bibinfo\s*\{person\}\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}',
                     body)
    names = [_clean(r) for r in raw]
    return ' and '.join(n for n in names if n)


def parse(text):
    start = text.find('\\begin{thebibliography}')
    end = text.find('\\end{thebibliography}')
    if start < 0 or end < 0:
        raise SystemExit('no thebibliography environment')
    chunks = re.split(r'\\bibitem\[', text[start:end])[1:]
    out = []
    for ch in chunks:
        m = re.match(r'(?s).*?\]%\s*\{([^}\s]+)\}', ch)
        if not m:
            continue
        key = m.group(1)
        body = ch[m.end():]
        author = _authors(body)
        title = _title(body)
        journal = _clean(_field(body, 'journal'))
        booktitle = _clean(_field(body, 'booktitle'))
        year = _clean(_field(body, 'year'))
        ym = re.search(r'\b(?:19|20)\d\d\b', year)
        year = ym.group(0) if ym else ''
        volume = _clean(_field(body, 'volume'))
        number = _clean(_field(body, 'number'))
        pages = _clean(_field(body, 'pages'))
        publisher = _clean(_field(body, 'publisher'))
        urls = re.findall(r'\\url\s*\{([^{}]*)\}', body)
        url = urls[-1] if urls else ''
        fields = []
        if author:
            fields.append(('author', author))
        if title:
            fields.append(('title', title))
        if journal:
            fields.append(('journal', journal))
        if booktitle:
            fields.append(('booktitle', booktitle))
        if publisher:
            fields.append(('publisher', publisher))
        if year:
            fields.append(('year', year))
        if volume:
            fields.append(('volume', volume))
        if number:
            fields.append(('number', number))
        if pages:
            fields.append(('pages', pages))
        if url:
            fields.append(('url', url))
        kind = 'article' if journal else ('inproceedings' if booktitle else 'misc')
        entry = '@%s{%s,\n' % (kind, key)
        entry += ''.join('  %s = {%s},\n' % kv for kv in fields)
        entry += '}\n\n'
        out.append(entry)
    return ''.join(out)


def main():
    src, dst = sys.argv[1], sys.argv[2]
    bib = parse(Path(src).read_text(encoding='utf-8', errors='replace'))
    Path(dst).write_text(bib, encoding='utf-8', newline='')
    print('%s: %d entries' % (dst, bib.count('@')))


if __name__ == '__main__':
    main()
