#!/usr/bin/env python
"""Rewrite LaTeX residue in BibTeX field values into plain Unicode.

Typst/hayagriva renders raw LaTeX from .bib literally (and mangles \\mu into
invalid glyphs), so titles such as "Search ... of mass m$_a=43~\\mu$eV" come
out as "m_a=43~\\mueV" in the PDF bibliography.
"""
import re
import sys
import unicodedata
from pathlib import Path

GREEK = {
    'alpha': 'α', 'beta': 'β', 'gamma': 'γ', 'delta': 'δ', 'epsilon': 'ϵ',
    'varepsilon': 'ε', 'zeta': 'ζ', 'eta': 'η', 'theta': 'θ', 'iota': 'ι',
    'kappa': 'κ', 'lambda': 'λ', 'mu': 'µ', 'nu': 'ν', 'xi': 'ξ', 'pi': 'π',
    'rho': 'ρ', 'sigma': 'σ', 'tau': 'τ', 'upsilon': 'υ', 'phi': 'ϕ',
    'varphi': 'φ', 'chi': 'χ', 'psi': 'ψ', 'omega': 'ω',
    'Gamma': 'Γ', 'Delta': 'Δ', 'Theta': 'Θ', 'Lambda': 'Λ', 'Xi': 'Ξ',
    'Pi': 'Π', 'Sigma': 'Σ', 'Upsilon': 'Υ', 'Phi': 'Φ', 'Psi': 'Ψ',
    'Omega': 'Ω',
}

SYMBOLS = {
    'times': '×', 'cdot': '·', 'pm': '±', 'mp': '∓', 'approx': '≈',
    'sim': '∼', 'lesssim': '≲', 'gtrsim': '≳', 'le': '≤', 'leq': '≤',
    'ge': '≥', 'geq': '≥', 'ne': '≠', 'neq': '≠', 'to': '→',
    'rightarrow': '→', 'leftarrow': '←', 'infty': '∞', 'hbar': 'ℏ',
    'ell': 'ℓ', 'partial': '∂', 'nabla': '∇', 'sum': '∑', 'prod': '∏',
    'sqrt': '√', 'dagger': '†', 'star': '*', 'ast': '*', 'odot': '⊙',
    'otimes': '⊗', 'oplus': '⊕', 'propto': '∝', 'equiv': '≡',
    'textendash': '–', 'textemdash': '—', 'ldots': '…', 'dots': '…',
    'prime': '′', 'circ': '∘', 'degree': '°', 'angle': '∠',
    'mathrm': '', 'mathbf': '', 'mathit': '', 'mathcal': '', 'mathsf': '',
    'text': '', 'textrm': '', 'textit': '', 'textbf': '', 'hbox': '',
    'mbox': '', 'textnormal': '', 'operatorname': '', 'rm': '',
    'left': '', 'right': '', 'big': '', 'Big': '', 'bigl': '', 'bigr': '',
    'relax': '', 'displaystyle': '', 'textstyle': '', 'nonumber': '',
    'quad': ' ', 'qquad': '  ', 'enspace': ' ', 'thinspace': ' ',
    'textsuperscript': '', 'textsubscript': '', 'i': 'ı', 'j': 'ȷ',
}

SUP = str.maketrans('0123456789+-−=()n', '⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁻⁼⁽⁾ⁿ')
SUB = str.maketrans('0123456789+-−=aehijklmnoprstuvx',
                    '₀₁₂₃₄₅₆₇₈₉₊₋₋₌ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ')

ACCENTS = {
    "'": '\u0301', '`': '\u0300', '^': '\u0302', '"': '\u0308',
    '~': '\u0303', '=': '\u0304', '.': '\u0307', 'u': '\u0306',
    'v': '\u030c', 'H': '\u030b', 'c': '\u0327', 'k': '\u0328',
    'r': '\u030a', 'b': '\u0331', 'd': '\u0323',
}

BASE_LETTERS = {'i': 'i', 'j': 'j', 'o': 'o', 'O': 'O', 'aa': 'a',
                'AA': 'A', 'ae': 'æ', 'AE': 'Æ', 'oe': 'œ', 'OE': 'Œ',
                'ss': 'ß', 'l': 'l', 'L': 'L', 'dh': 'ð', 'DH': 'Ð',
                'th': 'þ', 'TH': 'Þ'}


def _accent(m):
    acc, base = m.group(1), BASE_LETTERS.get(m.group(2), m.group(2))
    return unicodedata.normalize('NFC', base + ACCENTS[acc])


def _deaccent(s):
    s = re.sub(r'\{\\([`\'^"~=.])\s*\{\\?([A-Za-z]+)\}\}', _accent, s)
    s = re.sub(r'\\([`\'^"~=.])\s*\{\\?([A-Za-z]+)\}', _accent, s)
    s = re.sub(r'\{\\([`\'^"~=.])\s*\\?([A-Za-z]+)\}', _accent, s)
    s = re.sub(r'\\([`\'^"~=.])\s*\\?([A-Za-z]+)', _accent, s)
    s = re.sub(r'\\([cvuHkrbd])\{([A-Za-z])\}', _accent, s)
    return s


SPECIAL = {'o': 'ø', 'O': 'Ø', 'ae': 'æ', 'AE': 'Æ', 'oe': 'œ', 'OE': 'Œ',
           'ss': 'ß', 'aa': 'å', 'AA': 'Å', 'l': 'ł', 'L': 'Ł',
           'dh': 'ð', 'DH': 'Ð', 'th': 'þ', 'TH': 'Þ'}


def _special(s):
    return re.sub(r'\{?\\(' + '|'.join(SPECIAL) + r')(?![A-Za-z])\s*\}?',
                  lambda m: SPECIAL[m.group(1)], s)


def _scripts(s):
    out = []
    i = 0
    while i < len(s):
        c = s[i]
        if c in '^_' and i + 1 < len(s):
            table = SUP if c == '^' else SUB
            if s[i + 1] == '{':
                depth = 0
                j = i + 1
                while j < len(s):
                    if s[j] == '{':
                        depth += 1
                    elif s[j] == '}':
                        depth -= 1
                        if depth == 0:
                            break
                    j += 1
                inner = s[i + 2:j]
                i = j + 1
            else:
                inner = s[i + 1]
                i += 2
            conv = inner.translate(table)
            if inner.strip() == 'TM':
                out.append('™')
            elif all(ch in '0123456789+-−=aehijklmnoprstuvxn' for ch in inner):
                out.append(conv)
            else:
                out.append(inner)
            continue
        out.append(c)
        i += 1
    return ''.join(out)


def _math(s):
    s = s.replace('\\\\', ' ')
    s = re.sub(r'\\([A-Za-z]+)\s*', lambda m: GREEK.get(m.group(1), SYMBOLS.get(m.group(1), m.group(1))), s)
    s = s.replace('\\,', ' ').replace('\\;', ' ').replace('\\:', ' ')
    s = s.replace('\\!', '').replace('\\ ', ' ')
    s = s.replace('\\{', '{').replace('\\}', '}').replace('\\_', '_')
    s = s.replace('&', '').replace('~', ' ')
    s = re.sub(r'\\(.)', r'\1', s)
    s = re.sub(r'\{\s*\}', '', s)
    s = _scripts(s)
    s = s.replace('{', '').replace('}', '')
    s = re.sub(r' {2,}', ' ', s)
    return s.strip()


def clean(s):
    # math spans first, so their braces survive the outer pass
    s = re.sub(r'\$([^$]*)\$', lambda m: _math(m.group(1)), s)
    s = re.sub(r'\\url\s*\{([^{}]*)\}', r'\1', s)
    s = re.sub(r'\\href\s*\{[^{}]*\}\s*\{([^{}]*)\}', r'\1', s)
    s = _deaccent(s)
    s = _special(s)
    s = s.replace('\\\\', ' ')
    s = re.sub(r'\\([A-Za-z]+)\s*', lambda m: SYMBOLS.get(m.group(1), GREEK.get(m.group(1), m.group(1))), s)
    s = s.replace('\\,', ' ').replace('\\;', ' ').replace('\\:', ' ')
    s = s.replace('\\!', '').replace('\\ ', ' ')
    s = s.replace('\\&', '&').replace('\\%', '%').replace('\\_', '_')
    s = s.replace('\\#', '#').replace('\\$', '$')
    s = s.replace('\\{', '{').replace('\\}', '}')
    s = re.sub(r'\\(.)', r'\1', s)
    s = re.sub(r'\{\s*\}', '', s)
    s = _scripts(s)
    s = s.replace('---', '—').replace('--', '–')
    s = s.replace('~', ' ')
    s = s.replace('$', '')
    s = re.sub(r' {2,}', ' ', s)
    return s.strip()


FIELDS = ('title', 'author', 'editor', 'journal', 'booktitle', 'publisher',
          'school', 'institution', 'series', 'note', 'howpublished',
          'address', 'edition', 'month', 'organization', 'collaboration')
RAW_FIELDS = ('doi', 'url', 'eprint', 'file', 'pdf')

FIELD_RE = re.compile(r'(?m)^([ \t]*)([A-Za-z]+)([ \t]*=[ \t]*)\{')


def _field_end(s, start):
    """Index just past the brace matching the one that opened at start-1."""
    depth = 1
    i = start
    while i < len(s):
        c = s[i]
        if c == '\\':
            i += 2
            continue
        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def _repair_braces(val):
    """Drop stray `}` left after an accented letter by earlier cleaning passes."""
    depth = 0
    for c in val:
        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1
    while depth < 0:
        last = None
        for m in re.finditer(r'(?<=[^\x00-\x7f])\}', val):
            last = m
        if last is None:
            break
        val = val[:last.start()] + val[last.end():]
        depth += 1
    return val


def process(path):
    text = Path(path).read_text(encoding='utf-8', errors='replace')
    out = []
    pos = 0
    changed = 0
    while True:
        m = FIELD_RE.search(text, pos)
        if not m:
            out.append(text[pos:])
            break
        out.append(text[pos:m.end()])
        end = _field_end(text, m.end())
        if end < 0:
            out.append(text[m.end():])
            break
        name = m.group(2).lower()
        val = text[m.end():end]
        if name in FIELDS:
            new = re.sub(r'\s*\n\s*', ' ', _repair_braces(clean(val)))
            if new != val:
                changed += 1
            out.append(new)
        elif name in RAW_FIELDS:
            raw = re.sub(r'\s*\n\s*', '', val)
            raw = _repair_braces(raw)
            if raw != val:
                changed += 1
            out.append(re.sub(r'\\([_%&#$])', r'\1', raw))
        else:
            out.append(val)
        out.append('}')
        pos = end + 1
        if pos < len(text) and text[pos] == '}':
            pos += 1
            changed += 1
    return ''.join(out), changed


def main():
    for arg in sys.argv[1:]:
        p = Path(arg)
        new, changed = process(p)
        old = p.read_text(encoding='utf-8', errors='replace')
        if new != old:
            p.with_suffix(p.suffix + '.bak').write_text(old, encoding='utf-8')
            p.write_text(new, encoding='utf-8')
            print('%s: %d fields rewritten' % (p.name, changed))
        else:
            print('%s: unchanged' % p.name)


if __name__ == '__main__':
    main()
