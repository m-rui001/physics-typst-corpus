# -*- coding: utf-8 -*-
"""Float-integrity screen: which TeX captions have no Typst counterpart, and which differ.

STATUS: a screen, not a verdict. Every `lost_float` it prints must be confirmed by rendering
the page before anyone restores content, because two of its signals are known to be artefacts:

* `inversions` (Typst float order != TeX float order) is NOT a defect. Authors place floats
  wherever LaTeX lets them float, and Typst re-numbers consistently from its own order, so a
  re-ordered document still prints prose that matches its captions. It is reported only as
  context. What would be a defect is a label attached to the *wrong* float -- and this tool
  cannot see that, because it compares captions, not reference binding.
* `lost_float` fires when the caption text similarity falls under the threshold, which happens
  for captions whose TeX form is dominated by citation macros (`Ref.~\citeonline{x}`) that the
  normaliser strips. 2111.08640 screens 12/15 lost and renders with every figure present.

The class this tool did usefully surface is the `autoNN` label drift in 2111.14241, which was
found by hand: the converter numbered labels in TeX order while emitting floats in Typst order,
so prose points one figure off. That is only detectable by reading a reference sentence against
the figure it names.
"""
import io, os, re, sys, glob

STOP = set('a an the of for in to and or by is are as we us fig figure table with from that'.split())

# Converted papers call figure() bare inside content blocks, so the leading # is optional;
# the delimiter is captured so the scan resumes after it instead of looping on a bad group.
FIGCALL = re.compile(r'(?<![\w#])#?figure\s*([(\[])')


def norm(s):
    s = re.sub(r'\\[a-zA-Z]+', ' ', s)
    s = re.sub(r'[{}$\\&%#~_^]', ' ', s)
    toks = [t for t in re.findall(r'[a-z0-9]+', s.lower()) if t not in STOP and len(t) > 2]
    return toks


def jac(a, b):
    if not a or not b:
        return 0.0
    A, B = set(a), set(b)
    return len(A & B) / float(len(A | B))


def balanced(text, start, open_ch, close_ch):
    """Return the inner text of a balanced open_ch/close_ch run beginning at index start.

    Backslash escapes and quoted strings are skipped: converted papers name images after the
    TeX panels they show, so `image("Fig2(a)_final.pdf")` contains a closing paren that is
    not a delimiter, and trusting it truncates the float and fakes a lost caption.
    """
    depth, i = 0, start
    while i < len(text):
        c = text[i]
        if c == '\\' and i + 1 < len(text):
            i += 2
            continue
        if c in '"`':
            q, i = c, i + 1
            while i < len(text):
                if text[i] == '\\':
                    i += 2
                    continue
                if text[i] == q:
                    i += 1
                    break
                i += 1
            continue
        if c == open_ch:
            depth += 1
        elif c == close_ch:
            depth -= 1
            if depth == 0:
                return text[start + 1:i], i + 1
        i += 1
    return None, start


def tex_floats(pdir):
    """(label, caption) for every figure/table environment, in document order."""
    out = []
    for f in sorted(glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True)):
        s = io.open(f, encoding='utf-8', errors='replace').read()
        s = re.sub(r'(?<!\\)\\%.*', '', s)
        s = re.sub(r'\\begin\{comment\}.*?\\end\{comment\}', '', s, flags=re.S)
        for m in re.finditer(r'\\begin\{(figure\*?|table\*?)\}', s):
            body_start = m.end()
            env = m.group(1)
            e = s.find('\\end{' + env + '}', body_start)
            body = s[body_start:e if e > 0 else len(s)]
            caps = []
            i = 0
            while True:
                j = body.find('\\caption', i)
                if j < 0:
                    break
                k = body.find('{', j)
                if k < 0:
                    break
                cap, i = balanced(body, k, '{', '}')
                if cap is None:
                    break
                caps.append(re.sub(r'\s+', ' ', cap).strip())
            labs = re.findall(r'\\label\{([^}]*)\}', body)
            for c in caps:
                out.append((labs[0] if labs else '', c))
    return out


def typst_floats(pdir):
    """(label, caption) for every #figure(...) with a caption, in file order.

    Files are ordered main.typ first, then any included body, then everything under figures/
    (CeTZ redraws), because a CeTZ file is only reached through an #include from main.typ.
    """
    files = [os.path.join(pdir, 'main.typ')]
    for f in sorted(glob.glob(os.path.join(pdir, '*.typ'))):
        b = os.path.basename(f).lower()
        if f == files[0] or any(t in b for t in ('.pre', '.bak', '.orig', '_title')):
            continue
        files.append(f)
    out = []
    for path in files:
        if not os.path.exists(path):
            continue
        s = io.open(path, encoding='utf-8', errors='replace').read()
        i = 0
        while True:
            m = FIGCALL.search(s, i)
            if not m:
                break
            j = m.start()
            k = m.end() - 1  # points at the opening delimiter
            while k < len(s) and s[k] in ' \t':
                k += 1
            if k >= len(s) or s[k] not in '([':
                i = m.end()
                continue
            open_ch = s[k]
            close_ch = ')' if open_ch == '(' else ']'
            grp, nxt = balanced(s, k, open_ch, close_ch)
            if grp is None:
                # A raw `[` inside math ( `$[k_0]$` ) or an unescaped delimiter breaks the
                # balance walk. Falling back to a bounded window keeps a float from being
                # reported as dropped just because its caption is hard to parse.
                grp, nxt = s[k + 1:k + 1 + 2000], m.end()
            i = nxt
            cpos = re.search(r'caption\s*:', grp)
            if not cpos:
                continue
            k = grp.find('[', cpos.end())
            if k < 0:
                continue
            cap, _ = balanced(grp, k, '[', ']')
            if cap is None:
                nxt_cap = grp.find('caption', k)
                cap = grp[k + 1:nxt_cap] if nxt_cap > k else grp[k + 1:k + 900]
            tail = s[nxt:nxt + 200]
            lab = ''
            ml = re.match(r'\s*<([^>]*)>', tail)
            if ml:
                lab = ml.group(1)
            if not lab:
                mi = re.search(r'<([^>]*)>', grp)
                if mi:
                    lab = mi.group(1)
            out.append((lab, re.sub(r'\s+', ' ', cap).strip()))
    return out


def main():
    only = set(sys.argv[1:])
    for pid in sorted(os.listdir('papers')):
        if only and pid not in only:
            continue
        p = os.path.join('papers', pid)
        if not os.path.isdir(p):
            continue
        tf, yf = tex_floats(p), typst_floats(p)
        if not tf or not yf:
            print('%-12s SKIP  tex=%d typst=%d' % (pid, len(tf), len(yf)))
            continue
        # Greedy caption pairing, not positional alignment: floats legitimately move between
        # the TeX source and the rendered document, so index order proves nothing. What must
        # survive is the caption *set* -- a TeX caption with no Typst counterpart is a float
        # that was dropped or reduced to an uncaptioned image.
        pairs = []
        for i, (tl, tc) in enumerate(tf):
            tn = set(norm(tc))
            best, bs = -1, 0.0
            for j, (yl, yc) in enumerate(yf):
                yn = set(norm(yc))
                if not tn or not yn:
                    continue
                s = len(tn & yn) / float(len(tn | yn))
                if s > bs:
                    best, bs = j, s
            if best >= 0 and bs >= 0.45:
                pairs.append((i, best, bs))
        ti = {a for a, _, _ in pairs}
        yi = {b for _, b, _ in pairs}
        lost = [i for i in range(len(tf)) if i not in ti]
        orphan = [j for j in range(len(yf)) if j not in yi]
        # Among matched pairs, an inversion means the Typst float order differs from TeX's.
        # If labels were assigned in TeX order but floats emitted in another order, every
        # reference after the crossing can point one float off while still compiling.
        seq = [b for _, b, _ in sorted(pairs, key=lambda t: t[0])]
        inv = sum(1 for x in range(len(seq)) for y in range(x + 1, len(seq)) if seq[x] > seq[y])
        status = ('CLEAN' if not lost and not orphan and not inv
                  else 'LOST' if lost else 'DRIFT' if inv or orphan else '?')
        print('%-12s %-6s tex=%-3d typst=%-3d paired=%-3d lost_float=%-3d orphan_float=%-3d '
              'inversions=%-3d' % (pid, status, len(tf), len(yf), len(pairs), len(lost),
                                   len(orphan), inv))
        for i in lost[:6]:
            print('        TEX FLOAT WITH NO TYPEST MATCH: [%s] %s' % (tf[i][0], tf[i][1][:78]))
        for j in orphan[:6]:
            print('        TYPEST FLOAT MATCHING NO TEX CAPTION: [%s] %s'
                  % (yf[j][0], yf[j][1][:78]))


if __name__ == '__main__':
    main()
