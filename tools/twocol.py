# -*- coding: utf-8 -*-
"""Re-lay a converted paper as its TeX source asks: body in two columns, figure* floats out.

The TeX column model is read from \\documentclass options (`reprint`/`twocolumn` vs
`preprint`/`onecolumn`) and from the number of `figure*` floats. In Typst a spanning float
cannot live inside a `#columns` region, so the body region is closed around each float that
the source marks as cross-column and reopened after it — exactly what \\begin{figure*} does.

An image is treated as cross-column when the paper has any figure* and the image is wider than
60% of the (single-column) measure or at least 12 cm; a paper with no figure* keeps every image
inside its column, where a percentage is relative to the column just like \\linewidth.

Any paper that stops compiling is restored from its backup, so a failed attempt never leaves
the corpus worse than before.
"""
import io, os, re, sys, glob, shutil, subprocess

DOC = re.compile(r'\\documentclass\s*\[([^\]]*)\]\s*\{([^}]+)\}')
TWO = ('reprint', 'twocolumn', '1p', 'two')
ONE = ('preprint', 'onecolumn', '3p', '5p', 'one')


def depth_at(s):
    """Bracket depth before each character, ignoring strings, // comments and $math$."""
    d, out, i, n = 0, [], 0, len(s)
    in_str = in_math = False
    while i < n:
        out.append(d)
        ch = s[i]
        if in_str:
            if ch == '"' and s[i - 1] != '\\':
                in_str = False
        elif in_math:
            if ch == '$' and s[i - 1] != '\\':
                in_math = False
        elif ch == '"':
            in_str = True
        elif ch == '$':
            in_math = True
        elif ch == '/' and i + 1 < n and s[i + 1] == '/':
            j = s.find('\n', i)
            i = (j if j > 0 else n)
            continue
        elif ch == '[':
            d += 1
        elif ch == ']':
            d -= 1
        i += 1
    return out


def tex_stream(path, seen=None):
    """The main file plus every \\input/\\include it pulls in, in document order."""
    seen = seen or set()
    path = os.path.normpath(path)
    if path in seen or not os.path.exists(path):
        return ''
    seen.add(path)
    s = io.open(path, encoding='utf-8', errors='replace').read()
    out, cur = [], 0
    for m in re.finditer(r'\\(?:input|include)\{([^}]+)\}', s):
        out.append(s[cur:m.start()])
        name = m.group(1).strip()
        cand = os.path.join(os.path.dirname(path), name)
        for c in (cand, cand + '.tex'):
            if os.path.exists(c):
                out.append(tex_stream(c, seen))
                break
        cur = m.end()
    out.append(s[cur:])
    return ''.join(out)


def tex_model(pdir):
    for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True):
        s = io.open(f, encoding='utf-8', errors='replace').read()
        m = DOC.search(s)
        if not m:
            continue
        opts = [o.strip() for o in m.group(1).split(',')]
        base = re.sub(r'[0-9.\-]+$', '', m.group(2).strip())
        want = {'revtex4': 2, 'revtex4-1': 2, 'revtex4-2': 2, 'aap': 2, 'aa': 2,
                'mnras': 2, 'aastex': 2, 'aastex63': 2, 'aastex631': 2,
                'emulateapj': 2}.get(m.group(2).strip(), {'aa': 2, 'revtex': 2}.get(base, 1))
        if 'twocolumn' in opts or 'reprint' in opts:
            want = 2
        if 'preprint' in opts or 'onecolumn' in opts:
            want = 1
        kinds = ['star' if m.group(1) == '*' else 'fig'
                 for m in re.finditer(r'\\begin\{(figure\*?)\}', tex_stream(f))]
        return {'two': want == 2, 'star': kinds.count('star'), 'kinds': kinds,
                'a4': 'a4paper' in opts or 'a4' in m.group(2).lower()}, m.group(2)
    return None, None


def balanced(s, start, open_ch, close_ch):
    depth, i, in_str = 0, start, False
    while i < len(s):
        ch = s[i]
        if in_str:
            if ch == '"' and s[i - 1] != '\\':
                in_str = False
        elif ch == '"':
            in_str = True
        elif ch == '\\':
            i += 1
        elif ch == open_ch:
            depth += 1
        elif ch == close_ch:
            depth -= 1
            if depth == 0:
                return i + 1
        i += 1
    return None


WIDTH = re.compile(r'width\s*:\s*([0-9.]+)\s*(%|in|cm|pt)')


def spans(grp, has_star):
    if not has_star:
        return False
    for v, u in WIDTH.findall(grp):
        v = float(v)
        if (u == '%' and v >= 60) or (u == 'in' and v >= 6) or (u == 'cm' and v >= 12):
            return True
    return False


def body_parts(s, has_star):
    """[(kind, text)] over #figure blocks in the body, plus full-span flags."""
    figs, i = [], 0
    while True:
        m = re.search(r'(?<![\w#])#figure\s*\(', s[i:])
        if not m:
            break
        a = i + m.start()
        k = i + m.end() - 1
        end = balanced(s, k, '(', ')')
        if end is None:
            break
        figs.append((a, end, s[a:end]))
        i = end
    return figs


def convert(pid, apply=True):
    pdir = os.path.join('papers', pid)
    main = os.path.join(pdir, 'main.typ')
    s = io.open(main, encoding='utf-8').read()
    model, cls = tex_model(pdir)
    if not model or not model['two']:
        print('%-12s source is not two-column (%s)' % (pid, cls))
        return False
    depths = depth_at(s)
    heads = [m for m in re.finditer(r'(?m)^(= |#heading\()', s)
             if depths[m.start()] == 0]
    h = heads[0].start() if heads else None
    if h is None or h > len(s) * 0.5:
        # PRL-style letters often have no section headings at all: the body starts right after
        # the last centred title/abstract block.
        first_fig = s.find('#figure(')
        cand = [m for m in re.finditer(r'(?m)^#align\(center\)\[', s)
                if m.start() < (first_fig if first_fig > 0 else len(s))]
        if not cand:
            print('%-12s body anchor missing' % pid)
            return False
        end = balanced(s, cand[-1].end() - 1, '[', ']')
        if not end:
            print('%-12s unclosed title block' % pid)
            return False
        h = s.find('\n', end) + 1
    pre, body = s[:h], s[h:]
    figs = body_parts(body, model['star'] > 0)
    kinds = model['kinds']
    if len(kinds) == len(figs):
        full = [f for f, k in zip(figs, kinds) if k == 'star']
    else:
        full = [f for f in figs if spans(f[2], model['star'] > 0)]
    # rebuild: close the region before each spanning float or page break, reopen after
    breaks = [(m.start(), m.end(), '#pagebreak()')
              for m in re.finditer(r'(?m)^#pagebreak\(\)\s*$', body)
              if not any(a <= m.start() < b for a, b, _ in full)]
    splits = sorted([(a, b, _fit(txt)) for a, b, txt in full] + breaks)
    out, cur = ['#columns(2, gutter: 0.6cm)[\n'], 0
    for a, b, txt in splits:
        out.append(_fit(body[cur:a]))
        out.append(']\n')
        out.append(txt + '\n')
        out.append('#columns(2, gutter: 0.6cm)[\n')
        cur = b
    out.append(_fit(body[cur:]))
    out.append('\n]\n')
    nb = ''.join(out)
    paper = 'a4' if model['a4'] else 'us-letter'
    k = pre.find('#set page(')
    newpage = '#set page(paper: "%s", margin: (x: 1.6cm, y: 2.2cm))' % paper
    if k >= 0:
        open_at = pre.find('(', k)
        end = balanced(pre, open_at, '(', ')')
        if end:
            opts = _strip_margin(pre[open_at + 1:end - 1])
            newpage = ('#set page(%s, paper: "%s", margin: (x: 1.6cm, y: %s))' %
                       (opts, paper, _y_margin(pre[open_at + 1:end - 1]))).replace('(, ', '(')
            pre = pre[:k] + newpage + pre[end:]
    else:
        pre = newpage + '\n' + pre
    print('%-12s %s  figure*=%d  span-floats=%d  body=%d chars' %
          (pid, cls, model['star'], len(full), len(body)))
    if not apply:
        return True
    bak = main + '.pretwocol'
    if not os.path.exists(bak):
        shutil.copy2(main, bak)
    io.open(main, 'w', encoding='utf-8', newline='\n').write(pre + nb)
    return True


def _fit(txt):
    txt = re.sub(r'width\s*:\s*[0-9.]+\s*(in|cm|pt)', 'width: 100%', txt)
    txt = re.sub(r'image\(\s*"([^"]+)"\s*\)',
                 lambda m: 'image("%s", width: 100%%)' % m.group(1), txt)
    return txt


def _y_margin(opts):
    m = re.search(r'y\s*:\s*([^,)]+)', opts)
    return m.group(1).strip() if m else '2.2cm'


def _strip_margin(opts):
    o = re.sub(r'margin\s*:\s*\([^)]*\)', '', opts)
    o = re.sub(r'margin\s*:\s*[^,)]+', '', o)
    o = re.sub(r'paper\s*:\s*"[^"]*"', '', o)
    o = re.sub(r'columns\s*:\s*[0-9]+', '', o)
    o = re.sub(r'\s*,\s*,+', ',', o).strip(', ')
    return o


def build(pid):
    log = os.path.join('papers', pid, 'build', 'compile.log')
    os.makedirs(os.path.dirname(log), exist_ok=True)
    with io.open(log, 'w', encoding='utf-8') as fh:
        subprocess.run(['typst', 'compile', '--root', '.', 'papers/%s/main.typ' % pid,
                        'papers/%s/build/main.pdf' % pid], stderr=fh)
    s = io.open(log, encoding='utf-8', errors='replace').read()
    return s.count('error:'), s.count('warning:')


def main():
    argv = sys.argv[1:]
    apply = '--apply' in argv
    ids = [a for a in argv if re.match(r'^\d{4}\.\d{4,5}$', a)]
    for pid in ids:
        main_typ = os.path.join('papers', pid, 'main.typ')
        if not os.path.exists(main_typ):
            continue
        if not convert(pid, apply) or not apply:
            continue
        e, w = build(pid)
        if e:
            shutil.copy2(main_typ + '.pretwocol', main_typ)
            e2, _ = build(pid)
            print('%-12s REVERTED (E=%d, restored E=%d)' % (pid, e, e2))
        else:
            print('%-12s E=%d W=%d' % (pid, e, w))


if __name__ == '__main__':
    main()
