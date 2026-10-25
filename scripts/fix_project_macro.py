r"""Restore a project-name macro (e.g. \LiteBIRD -> LiteBIRD) dropped by convert.py.

Usage: python scripts/fix_project_macro.py <paper-dir> <src.tex> <Name1,Name2,...> <TypstReplacement> [--apply]

Aligns each source paragraph containing the macro to the corresponding main.typ
block, then inserts the replacement at the aligned junction.
"""
import re, sys, difflib, os

BS = chr(92)


def strip_comments(text):
    out = []
    for line in text.split('\n'):
        k = 0
        keep = line
        while True:
            k = line.find('%', k)
            if k < 0:
                break
            if k == 0 or line[k - 1] != BS:
                keep = line[:k]
                break
            k += 1
        out.append(keep)
    return '\n'.join(out)


def src_tokens(text, macros):
    toks = []
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        if c == BS:
            j = i + 1
            if j < n and text[j].isalpha():
                k = j
                while k < n and text[k].isalpha():
                    k += 1
                name = text[j:k]
                if name in macros:
                    toks.append(('mark', None, i, k))
                    i = k
                    continue
                if name in ('cite', 'citep', 'citet', 'citeauthor', 'citeyear',
                            'citeonline', 'ref', 'eqref', 'autoref', 'label',
                            'cref', 'Cref', 'nocite'):
                    k2 = k
                    while k2 < n and text[k2] in '[ ':
                        if text[k2] == '[':
                            e = text.find(']', k2)
                            k2 = e + 1 if e >= 0 else k2 + 1
                        else:
                            k2 += 1
                    if k2 < n and text[k2] == '{':
                        e = text.find('}', k2)
                        k2 = e + 1 if e >= 0 else k2 + 1
                    toks.append(('skip', None, i, k2))
                    i = k2
                    continue
                i = k
                continue
            i = j + 1
            continue
        if c == '$':
            j = i + 1
            while j < n and text[j] != '$':
                j += 1
            if j < n:
                j += 1
                if j < n and text[j] == '$':
                    j += 1
            toks.append(('math', None, i, j))
            i = j
            continue
        if c == '%':
            j = text.find('\n', i)
            i = n if j < 0 else j
            continue
        if c in '{}':
            i += 1
            continue
        if c.isspace() or c == '~':
            i += 1
            continue
        if c.isalnum():
            k = i
            while k < n and (text[k].isalnum() or text[k] in "'\u2019"):
                k += 1
            toks.append(('word', text[i:k].lower(), i, k))
            i = k
            continue
        i += 1
    return toks


def main_tokens(text):
    toks = []
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        if c == '$':
            j = i + 1
            while j < n and text[j] != '$':
                j += 1
            if j < n:
                j += 1
            toks.append(('math', None, i, j))
            i = j
            continue
        if c == '@':
            k = i + 1
            while k < n and (text[k].isalnum() or text[k] in ':_-'):
                k += 1
            toks.append(('skip', None, i, k))
            i = k
            continue
        if c == '#':
            k = i + 1
            while k < n and (text[k].isalnum() or text[k] == '.'):
                k += 1
            name = text[i + 1:k]
            if name == 'text' and text[k:k + 3] == '([])':
                i = k + 3
                continue
            i = k
            continue
        if c == BS:
            i += 2
            continue
        if c in '[](){}*_`':
            i += 1
            continue
        if c.isspace() or c == '~':
            i += 1
            continue
        if c.isalnum():
            k = i
            while k < n and (text[k].isalnum() or text[k] in "'\u2019"):
                k += 1
            toks.append(('word', text[i:k].lower(), i, k))
            i = k
            continue
        i += 1
    return toks


def words(toks):
    return [t[1] for t in toks if t[0] == 'word']


def is_prose(block):
    s = block.lstrip()
    if not s:
        return False
    c = s[0]
    return c.isalnum() or c in '~\u201c"[' or c in '\u2014-'


def main():
    paper, srcname, macrolist, repl = sys.argv[1:5]
    apply = '--apply' in sys.argv
    macros = set(macrolist.split(','))
    src = open(srcname, encoding='utf-8', errors='replace').read()
    body_start = src.find(BS + 'begin{document}')
    src = src[max(0, body_start):]
    src = strip_comments(src)
    typ_path = os.path.join(paper, 'main.typ')
    typ = open(typ_path, encoding='utf-8').read()

    # main blocks with offsets
    blocks = []
    pos = 0
    for b in typ.split('\n\n'):
        blocks.append((b, pos))
        pos += len(b) + 2

    candidates = [(b, off) for b, off in blocks if is_prose(b)]
    cand_toks = [main_tokens(b) for b, _ in candidates]

    src_pars = [p for p in src.split('\n\n') if p.strip()]
    inserts = []
    cursor = 0
    used = set()
    unmatched = 0

    for sp in src_pars:
        st = src_tokens(sp, macros)
        if not any(t[0] == 'mark' for t in st):
            continue
        sw = words(st)
        if len(sw) < 4:
            continue
        best, bestr = None, 0.0
        for bi in range(cursor, min(len(candidates), cursor + 40)):
            mw = words(cand_toks[bi])[:14]
            r = difflib.SequenceMatcher(None, sw[:14], mw).ratio()
            if r > bestr:
                best, bestr = bi, r
        if best is None or bestr < 0.45:
            unmatched += 1
            continue
        cursor = best
        mw = words(cand_toks[best])
        sm = difflib.SequenceMatcher(None, sw, mw, autojunk=False)
        # source word index -> main word index
        smap = {}
        for a, b, size in sm.get_matching_blocks():
            for d in range(size):
                smap[a + d] = b + d
        s_to_main_idx = [t for t in range(len(sw)) if t in smap]
        wpos = 0
        mark_info = []
        for t in st:
            if t[0] == 'word':
                wpos += 1
            elif t[0] == 'mark':
                mark_info.append((wpos, t[2], t[3]))
        for (wm, a, e) in mark_info:
            prevs = [q for q in s_to_main_idx if q < wm]
            nexts = [q for q in s_to_main_idx if q >= wm]
            p = smap[prevs[-1]] if prevs else None
            q = smap[nexts[0]] if nexts else None
            block, off = candidates[best]
            bt = cand_toks[best]
            if q is None and p is None:
                unmatched += 1
                continue
            # raw offsets in the block: word index -> word token -> raw span
            tok_words = [k for k, tk in enumerate(bt) if tk[0] == 'word']

            def raw_span(idx):
                t = bt[tok_words[idx]]
                return off + t[2], off + t[3]
            qstart = raw_span(q)[0] if q is not None else raw_span(p)[1]
            src_nxt = sp[e:e + 12]
            src_prv = sp[max(0, a - 12):a]
            nxt = None
            for ch in src_nxt:
                if ch in ' \t\n' or ch == BS or ch == '~':
                    continue
                nxt = ch
                break
            prv = None
            for ch in reversed(src_prv):
                if ch in ' \t\n' or ch == BS or ch == '~':
                    continue
                prv = ch
                break
            if nxt is not None and nxt in '.,;:':
                # place before this punctuation in main
                lo = off + (bt[tok_words[p]][3] if p is not None else 0)
                seg = typ[lo:qstart]
                m = None
                for ch in nxt:
                    k = seg.rfind(ch)
                    if k >= 0:
                        m = k
                        break
                if m is None:
                    unmatched += 1
                    continue
                isr = ier = lo + m
                text = repl
            elif nxt is None:
                # marker ends the source paragraph; main kept a dangling period
                lo = off + (bt[tok_words[p]][3] if p is not None else 0)
                seg = typ[lo:qstart]
                m = max((seg.rfind(ch) for ch in '.,;:'), default=-1)
                if m >= 0:
                    isr = ier = lo + m
                    text = repl
                else:
                    isr = ier = qstart
                    text = repl + ' '
            elif nxt is not None and nxt in "'\u2019":
                isr = ier = qstart - 1 if qstart > 0 and typ[qstart - 1] in "'\u2019" else qstart
                text = repl
            elif nxt == '-':
                isr = ier = qstart - 1 if qstart > 0 and typ[qstart - 1] == '-' else qstart
                text = repl
            else:
                # the converter often leaves an nbsp / thin space where the
                # macro was; replace it rather than inserting beside it
                anchor = qstart
                if q is not None:
                    ti = tok_words[q]
                    if ti > 0 and bt[ti - 1][0] == 'math' and qstart > 0 and typ[qstart - 1] == '-':
                        anchor = off + bt[ti - 1][2]
                j = anchor
                while j > 0 and typ[j - 1] in ' \t\n~\u00a0\u2009':
                    j -= 1
                if j > 0 and typ[j - 1] == '(':
                    par = j - 1
                    if par > 0 and typ[par - 1] in '~\u00a0\u2009':
                        isr, ier = par - 1, par
                        text = repl + ' '
                    else:
                        isr = ier = par
                        text = repl + ' '
                else:
                    mk = next((k for k in range(j, anchor) if typ[k] in '~\u00a0\u2009'), None)
                    if mk is not None:
                        isr, ier = mk, anchor
                        text = repl + ' '
                    else:
                        isr = ier = anchor
                        text = repl + ' '
            if repl in typ[max(0, isr - 20):ier + 5]:
                continue
            dbg = ' '.join(sw[max(0, wm - 5):wm]) + ' [X] ' + ' '.join(sw[wm:wm + 5])
            inserts.append((isr, ier, text, dbg))

    # dedupe and sort
    inserts = sorted(set(inserts), key=lambda z: z[0])
    print('paragraphs matched, insertions:', len(inserts), 'unmatched markers:', unmatched)
    if not apply:
        for isr, ier, text, dbg in inserts[:200]:
            print('---', repr(typ[max(0, isr - 50):isr]) + ' <<' + text + '>> ' + repr(typ[ier:ier + 40]), '||SRC:', dbg)
        return
    out = typ
    for isr, ier, text, _d in reversed(inserts):
        out = out[:isr] + text + out[ier:]
    bak = typ_path + '.premacro2'
    if not os.path.exists(bak):
        open(bak, 'w', encoding='utf-8', newline='\n').write(typ)
    open(typ_path, 'w', encoding='utf-8', newline='\n').write(out)
    print('applied', len(inserts))


if __name__ == '__main__':
    main()
