# -*- coding: utf-8 -*-
"""Rebuild the table floats of 2104.07634 (APPEC report) from its TeX source.

- 9 SWOT tabulars (currently flattened to bullet text)
- the axion/ALP/hidden-photon experiment table (currently raw TeX residue)

Run: python -P tools/rebuild2104.py [--dry]
"""
import re, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import raw2typst

raw2typst.SYM.update({
    'lesssim': 'lt.eq.slant',
    'gtrsim': 'gt.eq.slant',
    'varnothing': 'emptyset',
    'odot': '\u2299',
})
raw2typst.TEXTUAL.add('rm')

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PAP = os.path.join(BASE, 'papers', '2104.07634')
TEX = os.path.join(PAP, 'src', 'main_archives_v1.tex')
MAIN = os.path.join(PAP, 'main.typ')

# ---------- unit / text macros ----------
UNIT_MATH = [
    (r'\eVnr', r'\,\mathrm{eV}_{\mathrm{nr}}'),
    (r'\eVee', r'\,\mathrm{eV}_{\mathrm{ee}}'),
    (r'\keVnr', r'\,\mathrm{keV}_{\mathrm{nr}}'),
    (r'\keVee', r'\,\mathrm{keV}_{\mathrm{ee}}'),
    (r'\mueV', r'\,\mu\mathrm{eV}'),
    (r'\milieV', r'\,\mathrm{meV}'),
    (r'\neV', r'\,\mathrm{neV}'),
    (r'\keV', r'\,\mathrm{keV}'),
    (r'\MeV', r'\,\mathrm{MeV}'),
    (r'\GeV', r'\,\mathrm{GeV}'),
    (r'\TeV', r'\,\mathrm{TeV}'),
    (r'\eV', r'\,\mathrm{eV}'),
    (r'\muev', r'\,\mu\mathrm{eV}'),
    (r'\miliev', r'\,\mathrm{meV}'),
    (r'\nev', r'\,\mathrm{neV}'),
    (r'\kev', r'\,\mathrm{keV}'),
    (r'\mev', r'\,\mathrm{MeV}'),
    (r'\gev', r'\,\mathrm{GeV}'),
    (r'\tev', r'\,\mathrm{TeV}'),
    (r'\ev', r'\,\mathrm{eV}'),
    (r'\gram', r'\,\mathrm{g}'),
    (r'\kgram', r'\,\mathrm{kg}'),
    (r'\tonne', r'\,\mathrm{t}'),
    (r'\tesla', r'\,\mathrm{T}'),
    (r'\meter', r'\,\mathrm{m}'),
    (r'\cmeter', r'\,\mathrm{cm}'),
    (r'\second', r'\,\mathrm{s}'),
    (r'\musecond', r'\,\mu\mathrm{s}'),
    (r'\msecond', r'\,\mathrm{ms}'),
    (r'\years', r'\,\mathrm{year}'),
]

TEXT_M = [
    (r'\eVnr', 'eV#sub[nr]'), (r'\eVee', 'eV#sub[ee]'),
    (r'\keVnr', 'keV#sub[nr]'), (r'\keVee', 'keV#sub[ee]'),
    (r'\mueV', '\u00b5eV'), (r'\milieV', 'meV'), (r'\neV', 'neV'),
    (r'\keV', 'keV'), (r'\MeV', 'MeV'), (r'\GeV', 'GeV'), (r'\TeV', 'TeV'),
    (r'\eV', 'eV'), (r'\muev', '\u00b5eV'), (r'\miliev', 'meV'), (r'\nev', 'neV'),
    (r'\kev', 'keV'), (r'\mev', 'MeV'), (r'\gev', 'GeV'), (r'\tev', 'TeV'), (r'\ev', 'eV'),
    (r'\gram', 'g'), (r'\kgram', 'kg'), (r'\tonne', 't'), (r'\tesla', 'T'),
    (r'\meter', 'm'), (r'\cmeter', 'cm'), (r'\second', 's'), (r'\musecond', '\u00b5s'),
    (r'\msecond', 'ms'), (r'\years', 'years'),
    (r'\eg', 'e.g.'), (r'\ie', 'i.e.'), (r'\etc', 'etc.'), (r'\vs', 'vs.'),
    (r'\etal', 'et al.'), (r'\dots', '\u2026'), (r'\S', '\u00a7'),
    (r'\sim\!\!', '\u223c'), (r'\sim', '\u223c'),
    (r'\gtrsim', '\u2273'), (r'\lesssim', '\u2272'),
    (r'\LAr', 'LAr'), (r'\GADM', 'GADM'), (r'\DSf', 'DarkSide-50'),
    (r'\DSk', 'DarkSide-20k'), (r'\DEAP', 'DEAP-3600'),
]

SPECIAL = {
    '\\': '', '#': r'\#', '$': r'\$', '@': r'\@', '_': r'\_', '*': r'\*',
    '`': r'\`', '[': r'\[', ']': r'\]', '<': r'\<', '>': r'\>',
    '{': '', '}': '',
}

SUP = {'\\dagger': '\u2020', '\\ddagger': '\u2021', '\\star': '\u22c6', '\\ast': '\u2217'}
UNKNOWN = set()
MATH_RE = re.compile(r'\$(.+?)\$', re.S)

MATH_TOKENS = ('cal bb frak sans mono bold arrow hat tilde overline underline dot sqrt root '
               'frac upright op quad thin med space emptyset lt gt eq times plus chevron angle '
               'integral sum product log ln exp sin cos tan det dim lim max min sup inf arg mod tr '
               'alpha beta gamma delta Delta epsilon varepsilon zeta eta theta Theta iota kappa '
               'lambda Lambda mu nu xi Xi pi Pi rho sigma Sigma tau upsilon phi varphi Phi chi psi '
               'Psi omega Omega ell hbar infinity partial nabla pm mp cdot otimes oplus odot dagger '
               'star circ bullet leq geq neq approx sim simeq propto ll gg equiv in notin subset '
               'subseteq supset cup cap setminus to rightarrow leftarrow Rightarrow Leftarrow '
               'leftrightarrow mapsto uparrow downarrow longrightarrow forall exists neg land lor '
               'langle rangle lvert rvert vert lVert rVert Vert mid colon ldots dots cdots vdots '
               'ddots prime Re Im AA ZZ RR NN CC QQ PP diff ee ii order cO poly iint oint '
               'bigcup bigcap').split()


def _tok(kind, payload):
    return '\x02' + chr(0xE000 + payload[0]) + '\x03'


class Toks:
    def __init__(self):
        self.store = []

    def keep(self, s):
        self.store.append(s)
        return '\x02' + chr(0xE000 + len(self.store) - 1) + '\x03'

    def restore(self, s):
        return re.sub('\x02([\ue000-\uf8ff])\x03',
                      lambda m: self.store[ord(m.group(1)) - 0xE000], s)


def finish_math(txt):
    txt = re.sub(r'(?<=[A-Za-z)0-9])-(?=[A-Za-z(])', ' - ', txt)
    txt = re.sub(r'(?<=[A-Za-z0-9)])"(?=[A-Za-z])', r' "', txt)
    t = Toks()
    txt = re.sub(r'"[^"]*"', lambda m: t.keep(m.group(0)), txt)
    txt = re.sub(r'\b[a-z]+\.[a-z.]+\b', lambda m: t.keep(m.group(0)), txt)
    for w in sorted(MATH_TOKENS, key=len, reverse=True):
        txt = re.sub(r'(?<![A-Za-z.])' + w + r'(?![A-Za-z.])', lambda m, w=w: t.keep(w) + ' ', txt)
    txt = re.sub(r'[A-Za-z]{2,}', lambda m: ' '.join(m.group(0)), txt)
    return t.restore(txt)


def conv_math(inner):
    c = raw2typst.Conv()
    out = c.conv(inner)
    out = re.sub(r'[ \t]+', ' ', out).strip()
    out = re.sub(r'(?<=[A-Za-z0-9)"])(thin|med|quad|space)\b', r' \1 ', out)
    out = re.sub(r'\b(thin|med|quad|space)(?=[A-Za-z0-9"(])', r'\1 ', out)
    out = re.sub(r'(?<!["A-Za-z])(neV|meV|keV|MeV|GeV|TeV|eV)(?!["A-Za-z])', r'"\1"', out)
    out = finish_math(out)
    out = re.sub(r'\s+', ' ', out).strip()
    if re.match(r'^[\^_]', out):
        out = '""' + out
    UNKNOWN.update(c.unknown)
    return out


def expand_units(s, table, keep=None):
    for a, b in table:
        pat = re.escape(a) + r'(?![A-Za-z])'
        if keep is None:
            s = re.sub(pat, lambda m, b=b: b, s)
        else:
            s = re.sub(pat, lambda m, b=b: keep(b), s)
    return s


def math_span_raw(m):
    inner = m.group(1)
    inner = expand_units(inner, UNIT_MATH)
    return '$ ' + conv_math(inner) + ' $'


def markup(s):
    s = re.sub(r'(?m)(?<!\\)%[^\n]*', '', s)
    s = s.strip()
    if re.match(r'^\\bf\s+', s):
        s = '{\\bf ' + re.sub(r'^\\bf\s+', '', s) + '}'
    if re.match(r'^\\it\s+', s):
        s = '{\\it ' + re.sub(r'^\\it\s+', '', s) + '}'
    t = Toks()

    # escaped dollar marker from LaTeX
    s = s.replace(r'\$', t.keep(r'\$'))

    # superscript markers
    def sup(m):
        k = m.group(1)
        return t.keep('#super[' + SUP.get(k, k) + ']')
    s = re.sub(r'\$\^\{\\bf\s*(\\dagger|\\ddagger|\\star|\\ast|[a-g])\}\s*\$?', sup, s)
    s = re.sub(r'\^\{\\bf\s*(\\dagger|\\ddagger|\\star|\\ast|[a-g])\}', sup, s)
    s = re.sub(r'\$\^\{([a-g])\}\s*\$?', lambda m: t.keep('#super[' + m.group(1) + ']'), s)

    # spacing commands outside math
    s = re.sub(r'\\[,;:]', ' ', s)
    s = s.replace(r'\!', '')

    # math spans
    s = MATH_RE.sub(lambda m: t.keep(math_span_raw(m)), s)

    # refs
    s = re.sub(r'\\ref\{([^}]*)\}', lambda m: t.keep('@' + m.group(1)), s)

    # size declarations (drop the declaration and its grouping braces)
    s = re.sub(r'\{\\(?:small|footnotesize|scriptsize|tiny|normalsize)\s+([^{}]*)\}', r'\1', s)
    s = re.sub(r'\\(?:small|footnotesize|scriptsize|tiny|normalsize|bfseries|itshape)\b\s*', '', s)

    # bold / italic (recursive)
    s = re.sub(r'\{\\bf\\it\s+([^{}]*)\}', lambda m: t.keep('*' + markup(m.group(1)) + '*'), s)
    s = re.sub(r'\{\\bf\s+([^{}]*)\}', lambda m: t.keep('*' + markup(m.group(1)) + '*'), s)
    s = re.sub(r'\{\\it\s+([^{}]*)\}', lambda m: t.keep('_' + markup(m.group(1)) + '_'), s)
    s = re.sub(r'\\textbf\s*\{([^{}]*)\}', lambda m: t.keep('*' + markup(m.group(1)) + '*'), s)
    s = re.sub(r'\\textit\s*\{([^{}]*)\}', lambda m: t.keep('_' + markup(m.group(1)) + '_'), s)
    s = re.sub(r'\\emph\s*\{([^{}]*)\}', lambda m: t.keep('_' + markup(m.group(1)) + '_'), s)
    s = re.sub(r'\\texttt\s*\{([^{}]*)\}', lambda m: t.keep('`' + m.group(1) + '`'), s)

    # units & text macros
    s = expand_units(s, TEXT_M, t.keep)

    s = s.replace('``', '"').replace("''", '"')
    s = s.replace('~', ' ')

    out = []
    for ch in s:
        if ch in '\x02\x03' or 0xE000 <= ord(ch) <= 0xF8FF:
            out.append(ch)
        elif ch in SPECIAL:
            out.append(SPECIAL[ch])
        else:
            out.append(ch)
    s = ''.join(out)
    s = t.restore(s)
    s = re.sub(r'[ \t\r\n]+', ' ', s).strip()
    return s


def split_cells(row):
    """split a tabular row on top-level & (no nested braces with &)"""
    cells, cur, depth = [], [], 0
    i = 0
    while i < len(row):
        ch = row[i]
        if ch == '\\' and i + 1 < len(row):
            cur.append(row[i:i + 2]); i += 2; continue
        if ch == '{':
            depth += 1
        elif ch == '}':
            depth -= 1
        if ch == '&' and depth == 0:
            cells.append(''.join(cur)); cur = []
        else:
            cur.append(ch)
        i += 1
    cells.append(''.join(cur))
    return [c.strip() for c in cells]


def strip_hline(s):
    s = re.sub(r'\\hline\s*', '', s)
    s = re.sub(r'\\cline\{[^}]*\}', '', s)
    return s.strip()


def rows_of(body):
    body = strip_hline(body)
    rows = []
    for r in re.split(r'\\\\', body):
        r = strip_hline(r)
        if not r.strip():
            continue
        rows.append(r)
    return rows


# ---------- SWOT ----------
def items(cell):
    cell = re.sub(r'\\begin\{itemize\}', '', cell)
    cell = re.sub(r'\\end\{itemize\}', '', cell)
    cell = re.sub(r'(?m)(?<!\\)%[^\n]*', '', cell)
    parts = re.split(r'\\item\b', cell)
    return [p.strip() for p in parts if p.strip()]


def swot_table(title, rows, caption, label):
    def two_col(row):
        c = split_cells(row)
        return (c + ['', ''])[:2]

    i = 0
    while i < len(rows) and 'SWOT' in rows[i]:
        i += 1
    pairs = []
    while i < len(rows):
        r = rows[i]
        if 'Weaknesses' in r or 'Threats' in r:
            head = split_cells(r)
            i += 1
            if i >= len(rows):
                break
            body = two_col(rows[i])
            i += 1
            pairs.append((head, body))
        else:
            i += 1
    if not pairs:
        raise SystemExit('swot parse failed: ' + title)

    def cell_typ(body):
        lis = items(body)
        return '\n'.join('- ' + markup(x) for x in lis)

    lines = ['#figure(', '  table(',
             '    columns: (1fr, 1fr),',
             '    stroke: 0.5pt,',
             '    inset: 7pt,',
             '    align: left,',
             '    table.cell(colspan: 2, align: center)[*%s*],' % markup(title)]
    for head, body in pairs:
        h0 = markup(head[0]) if len(head) > 0 else ''
        h1 = markup(head[1]) if len(head) > 1 else ''
        lines.append('    [*%s*], [*%s*],' % (h0, h1))
        lines.append('    [%s],' % cell_typ(body[0]))
        lines.append('    [%s],' % cell_typ(body[1]))
    lines += ['  ),', '  caption: [%s],' % markup(caption),
              '  kind: table,', ') <%s>' % label]
    return '\n'.join(lines)


def parse_swot(src, start, end):
    m = re.search(r'\\begin\{tabular\}\{\s*\|p\{7\.6cm\}\|p\{7\.6cm\}\|\}', src[start:end])
    if not m:
        return None
    b0 = start + m.end()
    m2 = re.search(r'\\end\{tabular\}', src[b0:])
    body = src[b0:b0 + m2.start()]
    after = src[b0 + m2.end():end]
    cap = re.search(r'\\caption\{(.*?)\}\s*\\label\{([^}]*)\}', after, re.S)
    if cap:
        caption, label = cap.group(1), cap.group(2)
    else:
        cap = re.search(r'\\caption\{(.*?)\}', after, re.S)
        caption, label = (cap.group(1) if cap else ''), ''
    title_m = re.search(r'\\multicolumn\{2\}\{\|c\|\}\{\\bf\s+(.*?)\}', body, re.S)
    title = title_m.group(1) if title_m else 'SWOT'
    return swot_table(title, rows_of(body), caption, label)


# ---------- axion table ----------
def axion_table(src):
    start = src.index(r'\begin{tabular}{| m{2.0cm}')
    body = src[start:src.index(r'\end{tabular}', start)]
    after = src[src.index(r'\end{tabular}', start):]
    cap_m = re.search(r'\\caption\{(.*?)\}\s*\\label\{tab:axion_experiments\}', after, re.S)
    caption = cap_m.group(1)
    caption = re.sub(r'in sec\s*\\ref\{sec:axiondetection\}', r'in \\ref{sec:axiondetection}', caption)
    fn_m = re.search(r'\{\\footnotesize(.*?)\n\}', after, re.S)
    fn_text = fn_m.group(1) if fn_m else ''
    body = re.sub(r'(?m)(?<!\\)%.*$', '', body)
    body = re.sub(r'\\begin\{tabular\}[^\n]*', '', body)
    rows = [r for r in re.split(r'\\\\', strip_hline(body)) if r.strip()]
    out_rows = []
    for r in rows:
        r = strip_hline(r)
        if not r.strip():
            continue
        m = re.match(r'\\multicolumn\{9\}\{\|\s*l\s*\|\}\{(.*)\}', r.strip(), re.S)
        if m:
            out_rows.append(('section', m.group(1)))
            continue
        out_rows.append(('row', split_cells(r)))
    assert out_rows and out_rows[0][0] == 'row'
    out_rows = out_rows[1:]  # drop the TeX header row (emitted explicitly)

    def gcell(s):
        s = s.replace('$', '')
        s = expand_units(s, UNIT_MATH)
        if s.startswith('_{') or s.startswith('_'):
            s = 'g' + s
        return '$ ' + conv_math(s) + ' $'

    def mcell(s):
        s = s.replace('$', '')
        s = expand_units(s, UNIT_MATH)
        return '$ ' + conv_math(s) + ' $'

    lines = ['#figure(', '  text(size: 8pt, table(',
             '    columns: (2.0cm, 0.5cm, 1.1cm, 0.75cm, 2.85cm, 1.25cm, 0.8cm, 1.4cm, 1.35cm),',
             '    stroke: 0.5pt,', '    inset: 3pt,', '    align: left,',
             '    [*Experiment*], [*Type*], [*Techn.*], [*g*], [*Mass range*], [*Status*], [*Limits*], [*Location*], [*Timescale*],']
    for kind, val in out_rows:
        if kind == 'section':
            lines.append('    table.cell(colspan: 9, align: left)[%s],' % markup(val))
            continue
        c = (val + [''] * 9)[:9]
        exp = markup(c[0])
        typ = mcell(c[1]) if c[1].strip() else ''
        tech = markup(c[2])
        g = gcell(c[3]) if c[3].strip() else ''
        mass = mcell(c[4]) if c[4].strip() else ''
        rest = [markup(x) for x in c[5:9]]
        lines.append('    [%s], [%s], [%s], [%s], [%s], [%s], [%s], [%s], [%s],' %
                     (exp, typ, tech, g, mass, *rest))
    lines += ['  )),', '  caption: [%s],' % markup(caption),
              '  kind: table,', ') <tab:axion_experiments>']

    fn_lines = []
    parts = re.split(r'\$\^\{\\bf\s*(\\dagger|\\ddagger|\\star|\\ast|[a-g])\}\$?\s*\{',
                     fn_text)
    i = 1
    while i + 1 < len(parts):
        mark = SUP.get(parts[i], parts[i])
        body = parts[i + 1].rstrip()
        if body.endswith('}'):
            body = body[:-1]
        fn_lines.append('#text(8pt)[#super[%s] %s]' % (mark, markup(body)))
        i += 2
    return '\n'.join(lines), '\n\n'.join(fn_lines)


def main():
    src = open(TEX, encoding='utf-8', errors='replace').read()
    L = open(MAIN, encoding='utf-8').read().split('\n')

    starts = [i for i, l in enumerate(L) if l.startswith('|p7.6cm|p7.6cm|')]
    assert len(starts) == 9, starts

    def next_heading(idx):
        j = idx + 1
        while j < len(L) and not re.match(r'^=+ ', L[j]):
            j += 1
        return j

    bounds = [(starts[k], starts[k + 1]) for k in range(4)]
    bounds.append((starts[4], next_heading(starts[4])))
    bounds += [(starts[k], starts[k + 1]) for k in range(5, 8)]
    bounds.append((starts[8], next_heading(starts[8])))
    assert len(bounds) == 9

    tex_tab = [m.start() for m in re.finditer(
        r'\\begin\{tabular\}\{\s*\|p\{7\.6cm\}\|p\{7\.6cm\}\|\}', src)]
    assert len(tex_tab) == 9, len(tex_tab)
    swot_tex = []
    for k, s0 in enumerate(tex_tab):
        end = tex_tab[k + 1] if k + 1 < len(tex_tab) else len(src)
        swot_tex.append(parse_swot(src, s0, end))

    newL, cursor = [], 0
    for bi, (a, b) in enumerate(bounds):
        newL.extend(L[cursor:a])
        tbl = swot_tex[bi]
        if tbl is None:
            newL.extend(L[a:b])
        else:
            newL.extend(tbl.split('\n'))
            newL.append('')
        cursor = b
    newL.extend(L[cursor:])
    L = newL

    try:
        a0 = next(i for i, l in enumerate(L) if l.strip() == 'table[]')
        a1 = next(i for i, l in enumerate(L) if i > a0 and l.strip() == 'table')
        tbl, notes = axion_table(src)
        L = L[:a0] + tbl.split('\n') + [''] + notes.split('\n') + [''] + L[a1 + 1:]
    except StopIteration:
        print('axion table markers not found')

    out = '\n'.join(L)
    print('unknown macros:', sorted(UNKNOWN).__repr__().encode('ascii', 'backslashreplace').decode())
    if '--dry' in sys.argv:
        open(MAIN + '.dry', 'w', encoding='utf-8').write(out)
        print('dry written')
    else:
        open(MAIN, 'w', encoding='utf-8').write(out)
        print('written', len(L), 'lines')


if __name__ == '__main__':
    main()
