import io
import os
import re
import subprocess
import sys

B = chr(92)
ROOT = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(ROOT, 'src', 'nicer_pulse_profile_modeling.tex')


def strip_comments(t):
    out = []
    for line in t.split('\n'):
        j = line.find('%')
        while j != -1:
            nb = 0
            k = j - 1
            while k >= 0 and line[k] == B:
                nb += 1
                k -= 1
            if nb % 2 == 0:
                line = line[:j]
                break
            j = line.find('%', j + 1)
        out.append(line)
    return '\n'.join(out)


def expand_macros(t, src=None):
    src = src if src is not None else t
    # zero-argument macros
    defs = dict(re.findall(re.escape(B) + r'newcommand\*?\{?' + re.escape(B) + r'([A-Za-z]+)\}?\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}', src))
    # one-argument macros: substitute the argument into #1
    argdefs = re.findall(re.escape(B) + r'newcommand\*?\{?' + re.escape(B) + r'([A-Za-z]+)\}?\s*\[1\]\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}', src)
    for _ in range(8):
        changed = False
        for name, body in argdefs:
            pat = re.escape(B) + name + r'\s*\{([^{}]*)\}'
            if re.search(pat, t):
                t = re.sub(pat, lambda m, b=body: b.replace('#1', m.group(1)), t)
                changed = True
        for name, body in defs.items():
            pat = re.escape(B) + name + r'(?![A-Za-z])'
            if re.search(pat, t):
                t = re.sub(pat, lambda m, b=body: b, t)
                changed = True
        if not changed:
            break
    return t


def preprocess(t):
    t = re.sub(re.escape(B) + r'rm\s*\{([^{}]*)\}', lambda m: B + 'mathrm{' + m.group(1) + '}', t)
    t = re.sub(re.escape(B) + r'rm\s+([A-Za-z])', lambda m: B + 'mathrm{' + m.group(1) + '}', t)
    t = t.replace(B + 'textsuperscript{' + B + 'textregistered}', '(R)')
    t = t.replace(B + 'textsc{nicer}', 'NICER').replace(B + 'textsc{xmm}', 'XMM')
    t = t.replace(B + 'xspace', '').replace(B + 'coloneqq', B + 'equiv')
    t = t.replace(B + 'lesssim', B + 'leq').replace(B + 'gtrsim', B + 'geq')
    return t


def pandoc(text, tmp):
    tf = os.path.join(ROOT, 'check', tmp + '.tex')
    of = os.path.join(ROOT, 'check', tmp + '.typ')
    io.open(tf, 'w', encoding='utf-8', newline='').write(text)
    subprocess.run(['pandoc', tf, '-f', 'latex', '-t', 'typst', '--wrap=none', '-o', of],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    return io.open(of, encoding='utf-8', errors='replace').read()


def slug(s):
    s = s.strip().replace(' ', '-')
    return re.sub(r'[^A-Za-z0-9_.:-]', '', s)


def fix_cites(t):
    K = r'[A-Za-z0-9_.:-]+'
    t = re.sub(r'@(' + K + r')\[([^\]]*)\]', lambda m: '#cite(<%s>, supplement: [%s])' % (m.group(1), m.group(2)), t)
    for _ in range(20):
        n = t
        t = re.sub(r'@(' + K + r')@(' + K + r')', r'[@\1; @\2]', t)
        t = re.sub(r'(\[@' + K + r'(?:; @' + K + r')*\])@(' + K + r')',
                   lambda m: m.group(1)[:-1] + '; @' + m.group(2) + ']', t)
        t = re.sub(r'@(' + K + r')(\[@' + K + r'(?:; @' + K + r')*\])',
                   lambda m: '[' + m.group(0)[:-1] + ']', t)
        if t == n:
            break
    # IEEE renders a group as "[[1]; [2]]"; adjacent refs render as "[1], [2]"
    t = re.sub(r'\[(@[A-Za-z0-9_.:-]+(?:; @[A-Za-z0-9_.:-]+)*)\]', lambda m: m.group(1).replace('; ', ''), t)
    t = re.sub(r'\)\[(?=@)', ') [', t)
    return t


def fix_keys(t):
    bib = io.open(os.path.join(ROOT, 'refs.bib'), encoding='utf-8', errors='replace').read()
    keys = set(re.findall(r'@[A-Za-z]+\{([^,\s]+)', bib))
    low = {k.lower(): k for k in keys}
    labels = set(re.findall(r'(?<!\()<([A-Za-z0-9_.:-]+)>', t))

    def resolve(tok):
        if tok in keys or tok in labels:
            return tok, ''
        if tok.lower() in low:
            return low[tok.lower()], ''
        best = None
        for n in range(1, len(tok) - 2):
            head, tail = tok[:-n], tok[-n:]
            if head in keys or head in labels:
                best = (head, tail)
            elif head.lower() in low:
                best = (low[head.lower()], tail)
        return best if best else (None, '')

    def group(m):
        body = m.group(1)
        items = [x.strip() for x in body.split(';')]
        good, tail = [], ''
        for it in items:
            if not it.startswith('@'):
                return m.group(0)
            k, rest = resolve(it[1:])
            if k is None:
                return m.group(0)
            good.append('@' + k)
            if rest:
                tail = rest
        return '[' + '; '.join(good) + ']' + tail

    t = re.sub(r'\[(@[^\[\]]*)\]', group, t)

    def single(m):
        tok = m.group(1)
        k, rest = resolve(tok)
        if k is None:
            return m.group(0)
        if k in labels:
            return '#ref(<%s>)%s' % (k, rest) if rest else '@' + k
        if rest:
            return '#cite(<%s>)%s' % (k, rest)
        return '@' + k

    t = re.sub(r'@([A-Za-z0-9_.:-]+)', single, t)

    def cite_fn(m):
        k, rest = resolve(m.group(1))
        return '#cite(<%s>%s' % (k, rest) if k else m.group(0)
    t = re.sub(r'#cite\(<([A-Za-z0-9_.:-]+)>', cite_fn, t)
    # tables emitted by pandoc are not labeled; keep the reference readable but unnumbered
    t = re.sub(r'@(?:table|tab):[A-Za-z0-9_.:-]+', '', t)
    t = re.sub(r'Table~(\s*[,.;)])', r'Table\1', t)
    return t


def fix_math(t):
    t = t.replace('""_dot.circle', '""_⊙').replace('_dot.circle', '_⊙')
    t = t.replace('" "', '"')
    t = re.sub(r'upright\(((?:[A-Z] )*[A-Z])\)', lambda m: '"' + m.group(1).replace(' ', '') + '"', t)
    t = t.replace(B + ',', ',').replace(B + ';', ';').replace(B + ':', '')
    t = t.replace(B + '[', '[').replace(B + ']', ']')
    t = t.replace(B + '/', '/').replace(B + '(', '(').replace(B + ')', ')')
    return t


def fix_labels(t):
    labels = set(re.findall(r'((?:sec|fig|eqn|tab):[^>")\n]*)', t))
    m = {}
    for l in labels:
        s = slug(l)
        if s:
            m[l] = s
    for l, s in sorted(m.items(), key=lambda kv: -len(kv[0])):
        t = t.replace('#label("%s")' % l, '<%s>' % s)
        t = t.replace('<%s>' % l, '<%s>' % s)
        t = t.replace('#ref(label("%s"))' % l, '@' + s)
    # #ref(label) with no preceding #label emitted
    t = re.sub(r'#ref\(label\("([^"]*)"\)\)', lambda mm: '@' + slug(mm.group(1)), t)
    return t


def fix_figures(t):
    def repl(mm):
        name = mm.group(1)
        base = os.path.splitext(name)[0]
        for cand in ('figs_%s.wired.png' % base, '%s.png' % base, '%s.png' % name):
            if os.path.exists(os.path.join(ROOT, 'imgs', cand)):
                return mm.group(0).replace(name, 'imgs/' + cand)
        return mm.group(0)
    t = re.sub(r'image\("([^"]+)"', repl, t)
    return t


def main():
    raw = strip_comments(io.open(SRC, encoding='utf-8', errors='replace').read())
    body = raw.split(B + 'begin{document', 1)[1].lstrip('}')
    body = body.lstrip()
    abstract = ''
    m = re.search(re.escape(B) + r'begin\{abstract\}(.*?)' + re.escape(B) + r'end\{abstract\}', body, re.S)
    if m:
        abstract = m.group(1)
    keywords = ''
    m = re.search(re.escape(B) + r'keywords\{(.*?)\}', body)
    if m:
        keywords = m.group(1)
    body = re.sub(re.escape(B) + r'begin\{abstract\}.*?' + re.escape(B) + r'end\{abstract\}', '', body, flags=re.S)
    body = re.sub(re.escape(B) + r'keywords\{.*?\}', '', body, flags=re.S)
    body = body.split(B + 'end{document}')[0]
    body = expand_macros(preprocess(body), raw).replace(B + 'xspace', '')
    abs_txt = expand_macros(preprocess(abstract), raw).replace(B + 'xspace', '')
    typ = pandoc(body, 'fresh_body')
    abs_typ = pandoc(abs_txt, 'fresh_abs')
    typ = fix_cites(fix_math(typ))
    abs_typ = fix_cites(fix_math(abs_typ))
    typ = fix_labels(typ)
    abs_typ = fix_labels(abs_typ)
    typ = fix_figures(typ)
    typ = fix_keys(typ)
    abs_typ = fix_keys(abs_typ)
    # drop pandoc's section numbering prefix artefacts and stray label lines
    typ = re.sub(r'\n{3,}', '\n\n', typ).strip()
    k = typ.find('= ')
    if k > 0:
        typ = typ[k:]
    title = 'A NICER VIEW OF THE MASSIVE PULSAR PSR~J0740$+$6620 INFORMED BY RADIO TIMING AND #emph[XMM-NEWTON] SPECTROSCOPY'
    authors = re.findall(re.escape(B) + r'author(?:\[[^\]]*\])?\{(.*?)\}\s*\n', raw)
    names = []
    for a in authors:
        a = re.sub(re.escape(B) + r'[A-Za-z]+\*?', '', a)
        a = a.replace('{', '').replace('}', '').replace('~', ' ').strip()
        if a:
            names.append(a)
    auth_block = ', '.join(names)
    head = '''#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(17pt, weight: "bold", [%s])
  #v(1em)
  #text(10.5pt)[%s]
]
#v(1em)

#align(center)[
  #text(9.5pt)[*Abstract.* %s]
]

#text(9.5pt)[*Keywords:* %s]
#v(1em)

''' % (title, auth_block, abs_typ.strip(), keywords)
    out = head + typ + '\n\n#bibliography("refs.bib", style: "ieee")\n'
    io.open(os.path.join(ROOT, 'main.typ.new'), 'w', encoding='utf-8', newline='').write(out)
    print('authors', len(names), 'body lines', typ.count('\n'), 'chars', len(out))


main()
