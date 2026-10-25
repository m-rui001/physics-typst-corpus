# -*- coding: utf-8 -*-
"""Build refs.bib for 2107.10113 from the paper's own src/frbrev2.bib.

* keeps every entry with its own key (182 entries, 162 of them cited by the article)
* expands the document's ADS journal macros into standard abbreviations
* decodes LaTeX accent/quote/math escapes into Unicode so Typst's bibtex reader
  prints them instead of showing the raw TeX
"""
import io, os, re, unicodedata

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(HERE, 'src', 'frbrev2.bib')
OUT = os.path.join(HERE, 'refs.bib')
BS = chr(92)

JOURNALS = {
    'aj': 'AJ', 'araa': 'ARA&A', 'apj': 'ApJ', 'apjl': 'ApJL',
    'apjs': 'ApJS', 'apss': 'Ap&SS', 'aap': 'A&A', 'aapr': 'A&ARv',
    'aaps': 'A&AS', 'mnras': 'MNRAS', 'nat': 'Nature', 'pasp': 'PASP',
    'pasa': 'PASA', 'aplett': 'ApLett', 'nar': 'New A&Rev',
    'prl': 'Phys. Rev. Lett.', 'prd': 'Phys. Rev. D', 'jcap': 'JCAP',
    'icarus': 'Icarus', 'physrep': 'Phys. Rep.',
}

ACCENT = {
    '`': '\u0300', "'": '\u0301', '^': '\u0302', '~': '\u0303',
    'c': '\u0327', '"': '\u0308', 'v': '\u030C', 'u': '\u0306',
    'r': '\u030A', 'H': '\u030B', 'd': '\u0323', 'k': '\u0328',
    'b': '\u0332',
}

GREEK = {'Lambda': '\u039b', 'gamma': '\u03b3', 'alpha': '\u03b1',
         'pi': '\u03c0', 'mu': '\u03bc'}


def compose(cmd, ch):
    return unicodedata.normalize('NFC', ch + ACCENT[cmd])


def decode_accents(text):
    # {\'e}, {\'{e}}, \'{e}, \'e  forms
    pat = re.compile(
        r'\{?' + BS + BS + r'([' + ''.join(ACCENT) + r'])'
        r'(?:\{([A-Za-z])\}|([A-Za-z]))\}?')

    def rep(m):
        cmd = m.group(1)
        ch = m.group(2) or m.group(3)
        return compose(cmd, ch)
    prev = None
    while prev != text:
        prev = text
        text = pat.sub(rep, text)
    return text


def clean(text):
    # \ensuremath{...} -> its content (one level, repeated)
    prev = None
    while prev != text:
        prev = text
        text = re.sub(BS + BS + r'ensuremath\{([^{}]*)\}', r'\1', text)
    text = decode_accents(text)
    for name, rep in GREEK.items():
        text = text.replace(BS + name, rep)
    text = text.replace(BS + '%', '%').replace(BS + '&', '&')
    text = text.replace(BS + 'textemdash', '--')
    text = text.replace(BS + 'textendash', '--')
    text = text.replace(BS + 'textquotedblleft', '"').replace(BS + 'textquotedblright', '"')
    text = text.replace(BS + 'textquoteright', "'").replace(BS + 'textquoteleft', "'")
    text = text.replace(BS + 'textasciitilde', '~')
    text = text.replace('{`' + BS + 'a}', 'a')
    for name, rep in {'sim': '\u223c', 'pm': '\u00b1', 'mp': '\u2213',
                      'deg': '\u00b0', 'times': '\u00d7', 'mu': '\u03bc',
                      'ast': '*', 'ldots': '\u2026'}.items():
        text = text.replace(BS + name, rep)
    for key, rep in JOURNALS.items():
        pat = BS + key
        text = text.replace('{' + pat + '}', '{' + rep + '}')
    return text


def main():
    src = io.open(SRC, encoding='utf-8', errors='replace').read()
    entries = [e for e in re.split(r'(?m)(?=^@)', src) if e.strip()]
    out = [clean(e.rstrip()) + '\n' for e in entries]
    res = '\n'.join(out)
    io.open(OUT, 'w', encoding='utf-8', newline='\n').write(res)
    keys = re.findall(r'(?m)^\s*@[a-zA-Z]+\s*\{\s*([^,\s]+)\s*,', res)
    print('entries:', len(keys), 'unique:', len(set(keys)))
    left = sorted(set(re.findall(BS + r'[^ \n]?', res)))
    print('remaining backslash seqs:', left)
    print('journal tally:', sorted(set(re.findall(r'journal = \{([^}]*)\}', res))))


if __name__ == '__main__':
    main()
