import io
import os
import re
import subprocess
import sys

B = chr(92)
ROOT = os.path.abspath(sys.argv[1]) if len(sys.argv) > 1 else os.path.dirname(os.path.abspath(__file__))


def pick_src():
    if len(sys.argv) > 2:
        return sys.argv[2]
    main = os.path.join(ROOT, 'src', 'main.tex')
    if os.path.exists(main):
        return main
    best = None
    for f in sorted(os.listdir(os.path.join(ROOT, 'src'))):
        if not f.endswith('.tex'):
            continue
        p = os.path.join(ROOT, 'src', f)
        try:
            txt = io.open(p, encoding='utf-8', errors='replace').read()
        except OSError:
            continue
        if B + 'begin{document}' in txt and (best is None or os.path.getsize(p) > os.path.getsize(best)):
            best = p
    return best


SRC = pick_src()

ACCENTS = {
    '"': {'a': 'ä', 'e': 'ë', 'i': 'ï', 'o': 'ö', 'u': 'ü', 'y': 'ÿ', 'A': 'Ä', 'E': 'Ë', 'I': 'Ï', 'O': 'Ö', 'U': 'Ü'},
    "'": {'a': 'á', 'e': 'é', 'i': 'í', 'o': 'ó', 'u': 'ú', 'y': 'ý', 'c': 'ć', 'n': 'ń', 's': 'ś', 'z': 'ź',
          'A': 'Á', 'E': 'É', 'I': 'Í', 'O': 'Ó', 'U': 'Ú'},
    '`': {'a': 'à', 'e': 'è', 'i': 'ì', 'o': 'ò', 'u': 'ù', 'A': 'À', 'E': 'È', 'I': 'Ì', 'O': 'Ò', 'U': 'Ù'},
    '^': {'a': 'â', 'e': 'ê', 'i': 'î', 'o': 'ô', 'u': 'û', 'A': 'Â', 'E': 'Ê', 'I': 'Î', 'O': 'Ô', 'U': 'Û'},
    '~': {'a': 'ã', 'n': 'ñ', 'o': 'õ', 'A': 'Ã', 'N': 'Ñ', 'O': 'Õ'},
}


def deaccent(t):
    for mark, m in ACCENTS.items():
        t = re.sub(re.escape(B + mark) + r'(?:\{([A-Za-z])\}|([A-Za-z]))',
                   lambda mm, m=m: m.get(mm.group(1) or mm.group(2), mm.group(1) or mm.group(2)), t)
    t = re.sub(re.escape(B) + r'c\{([cCsS])\}', lambda m: {'c': 'ç', 'C': 'Ç', 's': 'ş', 'S': 'Ş'}[m.group(1)], t)
    return t


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


def expand_inputs(t, base, depth=0):
    if depth > 6:
        return t
    def rep(m):
        p = m.group(1).strip()
        for cand in (p, p + '.tex'):
            fp = os.path.join(base, cand)
            if os.path.exists(fp):
                txt = io.open(fp, encoding='utf-8', errors='replace').read()
                return expand_inputs(txt, os.path.dirname(fp), depth + 1)
        return ''
    return re.sub(re.escape(B) + r'(?:input|include)\{([^}]+)\}', rep, t)


def _group_bounds(t, i):
    """Return (open, close) of the brace group containing index i, or None."""
    depth, j = 0, i - 1
    while j >= 0:
        c = t[j]
        if c == '}':
            depth += 1
        elif c == '{':
            if depth == 0:
                break
            depth -= 1
        j -= 1
    if j < 0:
        return None
    depth, m = 0, i
    while m < len(t):
        c = t[m]
        if c == '{':
            depth += 1
        elif c == '}':
            if depth == 0:
                return j, m
            depth -= 1
        m += 1
    return None


def expand_over(t):
    """TeX a \\over b (whole group) -> \\frac{a}{b}, innermost first."""
    for _ in range(200):
        i = t.find(B + 'over')
        while i >= 0 and i + 5 < len(t) and t[i + 5].isalpha():
            i = t.find(B + 'over', i + 5)
        if i < 0:
            break
        gb = _group_bounds(t, i)
        if gb is None:
            break
        j, m = gb
        a = t[j + 1:i].strip()
        b = t[i + 5:m].strip()
        t = t[:j] + B + 'frac{' + a + '}{' + b + '}' + t[m + 1:]
    return t


def expand_rm(t):
    """Legacy \\rm switch: wrap the rest of its group in \\mathrm{}."""
    for _ in range(400):
        i = t.find(B + 'rm')
        while i >= 0 and i + 3 < len(t) and t[i + 3].isalpha():
            i = t.find(B + 'rm', i + 3)
        if i < 0:
            break
        gb = _group_bounds(t, i)
        if gb is None:
            t = t[:i] + t[i + 3:]
            continue
        j, m = gb
        rest = t[i + 3:m].strip()
        t = t[:i] + B + 'mathrm{' + rest + '}' + t[m:]
    return t


def preprocess(t):
    # \def macros that fake \lsim/\gsim with \hbox hacks break pandoc's math parser
    t = re.sub(re.escape(B) + r'def' + re.escape(B) + r'(?:lsim|gsim)\s*\{[^}]*\{[^}]*\}[^}]*\}',
               '', t)
    t = re.sub(re.escape(B) + r'(?:lsim|gsim)(?![A-Za-z])', lambda m: B + ('lesssim' if m.group(0)[1] == 'l' else 'gtrsim'), t)
    t = re.sub(re.escape(B) + r'rm\s*\{([^{}]*)\}', lambda m: B + 'mathrm{' + m.group(1) + '}', t)
    # legacy \rm switch inside a math group: {\,\rm kpc} -> {\,\mathrm{kpc}}
    t = re.sub(r'\{([^{}]*?)' + re.escape(B) + r'rm(?![A-Za-z])\s*([^{}]*?)\}',
               lambda m: '{' + m.group(1) + B + 'mathrm{' + m.group(2) + '}}', t)
    t = re.sub(r'\{' + re.escape(B) + r'rm\s+([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}',
               lambda m: '{' + B + 'mathrm{' + m.group(1) + '}}', t)
    t = re.sub(re.escape(B) + r'rm\s+([A-Za-z])', lambda m: B + 'mathrm{' + m.group(1) + '}', t)
    t = t.replace(B + 'textsuperscript{' + B + 'textregistered}', '(R)')
    t = t.replace(B + 'textsc{nicer}', 'NICER').replace(B + 'textsc{xmm}', 'XMM')
    t = t.replace(B + 'xspace', '').replace(B + 'coloneqq', B + 'equiv')
    t = t.replace(B + 'lesssim', B + 'leq').replace(B + 'gtrsim', B + 'geq')
    t = re.sub(re.escape(B + 'cal') + r'\s+([A-Za-z])', lambda m: B + 'mathcal{' + m.group(1) + '}', t)
    arg = r'\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}'
    t = re.sub(re.escape(B + 'ket') + arg, lambda m: '|' + m.group(1) + B + 'rangle', t)
    t = re.sub(re.escape(B + 'braket') + arg, lambda m: B + 'langle ' + m.group(1) + B + 'rangle', t)
    t = re.sub(re.escape(B + 'bra') + arg, lambda m: B + 'langle ' + m.group(1) + '|', t)
    t = expand_over(t)
    t = expand_rm(t)
    return t


def pandoc(text, tmp):
    # write beside the source so \input{chapter/...} still resolves
    d = os.path.dirname(os.path.abspath(SRC))
    tf = os.path.join(d, '_' + tmp + '.tex')
    of = os.path.join(ROOT, 'check', tmp + '.typ')
    io.open(tf, 'w', encoding='utf-8', newline='').write(text)
    subprocess.run(['pandoc', os.path.basename(tf), '-f', 'latex', '-t', 'typst', '--wrap=none', '-o', of],
                   cwd=d, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        os.remove(tf)
    except OSError:
        pass
    return io.open(of, encoding='utf-8', errors='replace').read()


def slug(s):
    s = s.strip().replace(' ', '-')
    return re.sub(r'[^A-Za-z0-9_.:+-]', '', s)


def fix_cites(t):
    K = r'[A-Za-z0-9_.:+-]+'
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
    t = re.sub(r'\[(@[A-Za-z0-9_.:+-]+(?:; @[A-Za-z0-9_.:+-]+)*)\]', lambda m: m.group(1).replace('; ', ''), t)
    t = re.sub(r'\)\[(?=@)', ') [', t)
    return t


def fix_keys(t):
    bib = io.open(os.path.join(ROOT, 'refs.bib'), encoding='utf-8', errors='replace').read()
    keys = set(re.findall(r'@[A-Za-z]+\{([^,\s]+)', bib))
    low = {k.lower(): k for k in keys}
    labels = set(re.findall(r'(?<!\()<([A-Za-z0-9_.:+-]+)>', t))

    def resolve(tok):
        if tok in keys or tok in labels:
            return tok, ''
        alt = tok.replace('+', '-')
        if alt in keys:
            return alt, ''
        if tok.lower() in low:
            return low[tok.lower()], ''
        for n in range(1, len(tok) - 2):
            head, tail = tok[:-n], tok[-n:]
            if head in keys or head in labels:
                return head, tail
            if head.lower() in low:
                return low[head.lower()], tail
        return None, ''

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
            if rest[:1].isalnum():
                return '#ref(<%s>)%s' % (k, rest)
            return '@' + k + rest
        if rest:
            return '#cite(<%s>)%s' % (k, rest)
        return '@' + k

    t = re.sub(r'@([A-Za-z0-9_.:+-]+)', single, t)

    def cite_fn(m):
        k, rest = resolve(m.group(1))
        return '#cite(<%s>%s' % (k, rest) if k else m.group(0)
    t = re.sub(r'#cite\(<([A-Za-z0-9_.:+-]+)>', cite_fn, t)
    # tables emitted by pandoc are not labeled; keep the reference readable but unnumbered
    t = re.sub(r'@(?:table|tab):[A-Za-z0-9_.:+-]+', '', t)
    t = re.sub(r'Table~(\s*[,.;)])', r'Table\1', t)
    return t


def fix_math(t):
    t = t.replace('""_dot.circle', '""_⊙').replace('_dot.circle', '_⊙')
    t = t.replace('times.circle', '⊗').replace('plus.circle', '⊕')
    t = re.sub(r'(⊗|⊕|⊙)\.(big|small)', r'\1', t)
    t = t.replace('" "', '"')
    t = re.sub(r'upright\(((?:[A-Z] )*[A-Z])\)', lambda m: '"' + m.group(1).replace(' ', '') + '"', t)
    t = t.replace(B + ',', ',').replace(B + ';', ';').replace(B + ':', '')
    t = t.replace(B + '[', '[').replace(B + ']', ']')
    t = t.replace(B + '/', '/').replace(B + '(', '(').replace(B + ')', ')')
    for ch in '=+/-':
        t = t.replace('bold(%s)' % ch, ch)
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
    t = re.sub(r'#cite\(label\("([^"]+)"\)((?:,\s*[^)]*)?)\)', r'#cite(<\1>\2)', t)
    # #ref(label) with no preceding #label emitted
    t = re.sub(r'#ref\(label\("([^"]*)"\)\)', lambda mm: '@' + slug(mm.group(1)), t)
    return t


def fix_figures(t):
    def repl(mm):
        name = mm.group(1)
        base = os.path.splitext(os.path.basename(name))[0]
        for cand in ('figs_%s.wired.png' % base, '%s.png' % base,
                     '%s.png' % base.replace('.', '_'), '%s.png' % name):
            if os.path.exists(os.path.join(ROOT, 'imgs', cand)):
                return mm.group(0).replace(name, 'imgs/' + cand)
        if not os.path.exists(os.path.join(ROOT, name)) and os.path.exists(os.path.join(ROOT, 'src', name)):
            return mm.group(0).replace(name, 'src/' + name)
        return mm.group(0)
    t = re.sub(r'image\("([^"]+)"', repl, t)
    return t


def fix_footnote_labels(t):
    """Labels inside footnote bodies cannot be referenced; attach them after."""
    out, i = [], 0
    while True:
        j = t.find('#footnote[<', i)
        if j < 0:
            out.append(t[i:])
            break
        out.append(t[i:j])
        k = t.find('>', j)
        key = t[j + len('#footnote[<'):k]
        depth, m, math = 0, j + len('#footnote'), False
        while m < len(t):
            c = t[m]
            if c == '$':
                math = not math
            elif not math and c == '[':
                depth += 1
            elif not math and c == ']':
                depth -= 1
                if depth == 0:
                    break
            m += 1
        if m >= len(t):
            out.append(t[j:])
            break
        out.append('#footnote[' + t[k + 1:m] + '] <' + key + '>')
        i = m + 1
    return ''.join(out)


def collapse_upright(t):
    """pandoc writes \\mathrm{GeV} as upright(G e V); merge the split letters."""
    out, i = [], 0
    while True:
        j = t.find('upright(', i)
        if j < 0:
            out.append(t[i:])
            break
        out.append(t[i:j])
        k = j + len('upright(')
        depth, m = 1, k
        while m < len(t) and depth:
            if t[m] == '(':
                depth += 1
            elif t[m] == ')':
                depth -= 1
            m += 1
        if depth:
            out.append(t[j:])
            break
        inner = t[k:m - 1]
        parts = []
        for p in inner.split('/'):
            toks = p.split()
            ok = len(toks) >= 1 and all(re.fullmatch(r'[A-Za-z](?:[_^].*)?', x) for x in toks)
            if ok:
                word = ''.join(re.sub(r'[_^].*$', '', x) for x in toks)
                tail = ''.join(re.findall(r'[_^].*$', toks[-1]))
                parts.append('upright("' + word + '")' + tail)
            else:
                parts.append(p)
        out.append(' / '.join(parts))
        i = m
    return ''.join(out)


FIG_LAB = re.compile(r'\n[ \t]*<([A-Za-z0-9_.:+-]+)>[ \t]*(?=\n)')


def float_figures(t):
    """Tall images push whole pages when unplaced; let them float to the top."""
    out = []
    i = 0
    while True:
        j = t.find('#figure(', i)
        if j < 0:
            out.append(t[i:])
            break
        depth, k, instr = 0, j + len('#figure'), False
        while k < len(t):
            c = t[k]
            if c == '"' and t[k - 1] != B:
                instr = not instr
            elif not instr and c == '(':
                depth += 1
            elif not instr and c == ')':
                depth -= 1
                if depth == 0:
                    break
            k += 1
        body = t[j:k + 1]
        out.append(t[i:j])
        if 'image(' in body and 'placement:' not in body:
            body = body[:-1].rstrip()
            if not body.endswith(','):
                body += ','
            body += '\n  placement: top,\n)'
        out.append(body)
        i = k + 1
    return ''.join(out)


def fix_figure_labels(t):
    out = []
    i = 0
    while True:
        j = t.find('#figure(', i)
        if j < 0:
            out.append(t[i:])
            break
        out.append(t[i:j])
        depth, k, instr = 0, j, False
        while k < len(t):
            c = t[k]
            if c == '"' and t[k - 1] != B:
                instr = not instr
            elif not instr and c == '(':
                depth += 1
            elif not instr and c == ')':
                depth -= 1
                if depth == 0:
                    break
            k += 1
        block = t[j:k + 1]
        labs = []

        def rm(mm):
            labs.append(mm.group(1))
            return ''

        block = re.sub(r'(?<!#ref\()<([A-Za-z0-9_.:+-]+)>', rm, block)
        out.append(block)
        rest = t[k + 1:]
        m = re.match(r'\s*\n?[ \t]*<([A-Za-z0-9_.:+-]+)>', rest)
        if labs and not m:
            out.append('\n' + '\n'.join('<%s>' % l for l in labs))
        i = k + 1
    return ''.join(out)


def main():
    os.makedirs(os.path.join(ROOT, 'check'), exist_ok=True)
    raw = expand_inputs(strip_comments(io.open(SRC, encoding='utf-8', errors='replace').read()),
                        os.path.dirname(os.path.abspath(SRC)))
    body = raw.split(B + 'begin{document', 1)[1].lstrip('}')
    body = body.lstrip()
    abstract = ''
    m = re.search(re.escape(B) + r'begin\{abstract\}(.*?)' + re.escape(B) + r'end\{abstract\}', body, re.S)
    if m:
        abstract = m.group(1)
    else:
        m = re.search(re.escape(B) + r'abstract\{((?:[^{}]|\{[^{}]*\})*)\}', body, re.S)
        if m:
            abstract = m.group(1)
            body = body.replace(m.group(0), '')
    keywords = ''
    m = re.search(re.escape(B) + r'keywords\{(.*?)\}', body)
    if m:
        keywords = m.group(1)
    body = re.sub(re.escape(B) + r'begin\{abstract\}.*?' + re.escape(B) + r'end\{abstract\}', '', body, flags=re.S)
    body = re.sub(re.escape(B) + r'keywords\{.*?\}', '', body, flags=re.S)
    body = body.split(B + 'end{document}')[0]
    if B + 'maketitle' in body:
        body = body.split(B + 'maketitle', 1)[1]
    body = re.sub(re.escape(B) + r'begin\{thebibliography\}.*?' + re.escape(B) + r'end\{thebibliography\}', '', body, flags=re.S)
    body = re.sub(re.escape(B) + r'bibliography\{[^}]*\}', '', body)
    body = re.sub(re.escape(B) + r'bibliographystyle\{[^}]*\}', '', body)
    body = expand_macros(preprocess(body), raw).replace(B + 'xspace', '')
    abs_txt = expand_macros(preprocess(abstract), raw).replace(B + 'xspace', '')
    typ = pandoc(body, 'fresh_body')
    abs_typ = pandoc(abs_txt, 'fresh_abs')
    typ = collapse_upright(fix_cites(fix_math(typ)))
    abs_typ = fix_cites(fix_math(abs_typ))
    typ = fix_labels(typ)
    abs_typ = fix_labels(abs_typ)
    typ = fix_figures(typ)
    typ = fix_keys(typ)
    abs_typ = fix_keys(abs_typ)
    typ = fix_figure_labels(typ)
    typ = fix_footnote_labels(typ)
    typ = float_figures(typ)
    typ = re.sub(r'(?m)^#footnote\[E-?mail:[^\]]*\]\s*\n?', '', typ)
    typ = re.sub(r'~?#cite\(\s*\)', '', typ)
    typ = re.sub(r'#cite\(\s*,\s*form:\s*"[^"]*"\s*\)', '', typ)
    typ = typ.replace(B + '/', '/')
    # e-mail addresses must not parse as labels
    typ = re.sub(r'([A-Za-z0-9._%+-])@([A-Za-z0-9-]+\.[A-Za-z0-9.-]+)',
                 lambda m: m.group(1) + B + '@' + m.group(2), typ)
    # drop pandoc's section numbering prefix artefacts and stray label lines
    typ = re.sub(r'\n{3,}', '\n\n', typ).strip()
    mt = re.search(re.escape(B) + r'title\{(.*?)\}\s*\n', raw, re.S)
    title = mt.group(1) if mt else 'Untitled'
    title = title.replace('``', '"').replace("''", '"').replace('\\\\', ' ')
    title = re.sub(re.escape(B) + r'[vh]space\*?\{[^}]*\}', '', title)
    title = re.sub(re.escape(B) + r'[A-Za-z]+\*?', '', title).replace(B, '')
    title = ' '.join(title.replace('{', '').replace('}', '').split())
    authors = re.findall(re.escape(B) + r'author(?:\[[^\]]*\])?\{(.*?)\}\s*\n', raw, re.S)
    names = []
    for a in authors:
        a = re.sub(r'E-?mail:?\s*\S+', '', a)
        a = deaccent(a)
        a = re.sub(re.escape(B) + r'(?:cite|ref|footnote)\{[^}]*\}', '', a)
        a = re.sub(re.escape(B) + r'inst\{[^}]*\}', '', a)
        a = re.sub(re.escape(B) + r'[A-Za-z]+\*?', '', a)
        a = re.sub(r'\$\^\{[^}]*\}\$', '', a)
        a = re.sub(r'\^\{[^}]*\}', '', a)
        a = a.replace('{', '').replace('}', '').replace('~', ' ')
        a = re.sub(re.escape(B) + r'[ ,;!]', ' ', a)
        for n in a.split(','):
            n = ' '.join(n.split()).replace('@', B + '@')
            if n and n not in ('and',):
                names.append(n)
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
%s%s
''' % (title, auth_block,
       ('\n#text(9.5pt)[*Abstract.* %s]\n\n' % abs_typ.strip()) if abs_typ.strip() else '',
       ('\n#text(9.5pt)[*Keywords:* %s]\n' % keywords) if keywords else '')
    bib = ''
    if os.path.exists(os.path.join(ROOT, 'refs.bib')):
        bib = '\n\n#bibliography("refs.bib", style: "ieee")\n'
    out = head + typ + bib
    io.open(os.path.join(ROOT, 'main.typ.new'), 'w', encoding='utf-8', newline='').write(out)
    print('authors', len(names), 'body lines', typ.count('\n'), 'chars', len(out))


main()
