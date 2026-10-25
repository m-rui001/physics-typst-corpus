import glob, re, os

pats = {
    'eqref_brackets': r'\[\s*\\?eq:',
    'link_eq': r'#link\(<eq:',
    'bare_thin_word': r'(?<![.#A-Za-z])thin(?![A-Za-z.(])',
    'hash_text_empty': r'#text\(\[\]\)',
    'raw_begin': r'\\begin\{',
    'escaped_dollar': r'\\\$',
    'med_word': r'(?<![.#A-Za-z])med(?![A-Za-z.(])',
    'espace_cmd': r'\\\(',
    'raw_frac': r'\\frac',
    'cite_bracket': r'\[\\?\[?\d+(?:,\s*\d+)*\\?\]?\]',
}
for f in sorted(glob.glob('papers/2*/main.typ')):
    s = open(f, encoding='utf-8').read()
    hits = {k: len(re.findall(v, s)) for k, v in pats.items()}
    hits = {k: v for k, v in hits.items() if v}
    if hits:
        print(os.path.basename(os.path.dirname(f)), hits)
