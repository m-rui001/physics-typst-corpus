# -*- coding: utf-8 -*-
"""Re-insert references dropped by pandoc when it met \\fig/\\tab/\\lem/\\sec/... macros.

Pandoc's LaTeX reader silently eats unknown one-arg macros together with their
argument, leaving holes like "see ." / "listed in ." in main.typ.  This tool parses
the TeX main file, turns every such macro into a Typst @reference, aligns the TeX
paragraph word stream against the Typst paragraph word streams, and inserts the
reference after the word that precedes it in the source.

usage: python tools/refhole.py <paper_id> [--apply] [--min-ratio 0.55]
"""
import io, glob, os, re, sys, difflib, shutil

BS = chr(92)
pid = [a for a in sys.argv[1:] if not a.startswith('-')][0]
APPLY = '--apply' in sys.argv
MINR = 0.55
if '--min-ratio' in sys.argv:
    MINR = float(sys.argv[sys.argv.index('--min-ratio') + 1])

pdir = os.path.join('papers', pid)
tex = ''
for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True):
    t = io.open(f, encoding='utf-8', errors='replace').read()
    if BS + 'documentclass' in t and len(t) > len(tex):
        tex = t
typp = os.path.join(pdir, 'main.typ')
typ = io.open(typp, encoding='utf-8').read()
labels = set(re.findall(r'<([A-Za-z0-9_.:\-]+)>', typ))

REFMAC = 'fig|tab|lem|sec|ssec|propos|thm|alg'
EV = re.compile(BS * 2 + '(' + REFMAC + r')\{([^{}]+)\}')


def tex_words(s):
    """Words of a TeX paragraph, with ref macros cut out (they are events)."""
    s = re.sub(r'(?<!' + BS * 2 + r')' + BS + r'%.*', '', s)
    s = re.sub(r'\$[^$]*\$', ' ', s)
    s = re.sub(r'\\begin\{[^}]*\}.*?\\end\{[^}]*\}', ' ', s, flags=re.S)
    s = EV.sub(' ', s)
    s = re.sub(BS * 2 + r'[a-zA-Z]+\*?(\[[^\]]*\])?', ' ', s)
    s = re.sub(r'[{}]', ' ', s)
    s = re.sub(r'[^A-Za-z ]', ' ', s)
    return re.findall(r'[A-Za-z]{2,}', s.lower())


def typ_mask(s):
    """Blank out the same regions typ_words drops, preserving string length so
    word offsets computed on the mask are valid in the original text."""
    def blank(m):
        return ' ' * len(m.group(0))
    s = re.sub(r'@[A-Za-z0-9_.:\-]+', blank, s)
    s = re.sub(r'#\w+\([^)]*\)', blank, s)
    s = re.sub(r'#\w+\[([^\]]*)\]',
               lambda m: ' ' * (len(m.group(0)) - len(m.group(1))) + m.group(1), s)
    s = re.sub(r'\$[^$]*\$', blank, s)
    s = re.sub(r'<[A-Za-z0-9_.:\-]+>', blank, s)
    s = re.sub(r'[^A-Za-z ]', ' ', s)
    return s


def typ_words(s):
    return re.findall(r'[A-Za-z]{2,}', typ_mask(s).lower())


# ---- TeX paragraphs with events -------------------------------------------
body = tex
m = re.search(re.escape(BS) + r'begin\{document\}', body)
if m:
    body = body[m.end():]
ins = re.search(re.escape(BS) + r'input\{supplemental_v2\.tex\}', body)
if ins:
    sup = ''
    for f in glob.glob(os.path.join(pdir, 'src', '*supplemental*.tex')):
        sup = io.open(f, encoding='utf-8', errors='replace').read()
    m2 = re.search(re.escape(BS) + r'begin\{document\}', sup)
    if m2:
        sup = sup[m2.end():]
    body = body[:ins.start()] + '\n\n' + sup + '\n\n' + body[ins.end():]
body = body.split(re.escape(BS) + 'bibliography')[0]
texparas = []
for para in re.split(r'\n\s*\n', body):
    evs = [(mm.start(), mm.group(1), mm.group(2)) for mm in EV.finditer(para)]
    if not evs:
        continue
    # event word index: number of words before the macro in the cleaned prefix
    pre_words = []
    chunks = []
    last = 0
    for st, kind, lab in evs:
        pre_words.append(len(tex_words(para[last:st])))
        chunks.append(para[last:st])
        last = st
    chunks.append(para[last:])
    total = tex_words(' '.join(chunks))
    if len(total) < 4:
        continue
    # cumulative word index at each event
    cum = []
    acc = 0
    for c in chunks[:-1]:
        acc += len(tex_words(c))
        cum.append(acc)
    texparas.append((total, [(cum[i], evs[i][1], evs[i][2]) for i in range(len(evs))], para))

# ---- Typst paragraphs ------------------------------------------------------
tparas = []
for mm in re.finditer(r'(?:^|\n\n)([^\n][\s\S]*?)(?=\n\n|\Z)', typ):
    seg = mm.group(1)
    tw = typ_words(seg)
    if len(tw) >= 4:
        tparas.append((tw, mm.start(1), seg))

used = set()
fills = []
skipped = []
for tw_para, events, raw in texparas:
    best = None
    for i, (tw, off, seg) in enumerate(tparas):
        if i in used:
            continue
        if abs(len(tw) - len(tw_para)) > max(len(tw_para), 20):
            continue
        r = difflib.SequenceMatcher(None, tw_para, tw, autojunk=False).ratio()
        if best is None or r > best[0]:
            best = (r, i, tw, off, seg)
    if best is None or best[0] < MINR:
        for en, kind, lab in events:
            skipped.append((kind, lab, 'no-paragraph %.2f' % (best[0] if best else 0)))
        continue
    r, i, tw, off, seg = best
    used.add(i)
    # word-level alignment
    sm = difflib.SequenceMatcher(None, tw_para, tw, autojunk=False)
    # map tex word index -> typst word index
    t2y = {}
    for a, b, n in sm.get_matching_blocks():
        for k in range(n):
            t2y[a + k] = b + k
    # char offset of each typst word in seg
    ypos = [mm.start() for mm in re.finditer(r'[A-Za-z]{2,}', typ_mask(seg))]
    ins = []
    for en, kind, lab in events:
        prefix = {'fig': 'fig', 'tab': 'table', 'lem': 'lem', 'sec': 'sec',
                  'ssec': 'ssec', 'propos': 'propos', 'thm': 'thm', 'alg': 'alg'}[kind]
        cand = [prefix + ':' + lab, lab]
        target = next((c for c in cand if c in labels), None)
        if target is None:
            skipped.append((kind, lab, 'no-label'))
            continue
        # tex word en-1 is the word before the reference
        anchor = en - 1
        yi = None
        for back in range(0, 4):
            if anchor - back in t2y:
                yi = t2y[anchor - back]
                break
        if yi is None:
            skipped.append((kind, lab, 'no-anchor'))
            continue
        # insert after typst word yi; if the next source word is also the next typst
        # word, insert before it (keeps "@fig:x." glued to the period)
        wend = re.compile(r'[A-Za-z]{2,}').search(seg, ypos[yi]).end()
        if any(a <= wend <= b for a, b in
               ((m2.start(), m2.end()) for m2 in re.finditer(r'\$[^$]*\$', seg))):
            skipped.append((kind, lab, 'in-math'))
            continue
        nxt = seg[wend:wend + 12].lstrip()
        if nxt and nxt[0] not in '.,;:)]}':
            # a reference can sit mid-sentence ("circuits in \tab{x} used for").
            # Accept it when the word right after the macro in TeX is the same
            # word that follows the insertion point in Typst.
            nw_typ = re.compile(r'[A-Za-z]{2,}').search(seg, wend)
            nw_tex = total[en] if en < len(total) else ''
            if not (nw_typ and nw_tex and nw_typ.group(0).lower() == nw_tex):
                skipped.append((kind, lab, 'no-hole',
                                (total[anchor] if anchor < len(total) else '',
                                 nw_typ.group(0) if nw_typ else '',
                                 nw_tex, seg[wend:wend + 30])))
                continue
        pre = '' if wend == 0 or seg[wend - 1] in ' \n([{' else ' '
        post = '' if wend >= len(seg) or seg[wend] in ' \n.,;:)]}' else ' '
        ins.append((wend, pre + '@' + target + post, kind, lab))
    if not ins:
        continue
    seg2 = seg
    for pos, txt, kind, lab in sorted(ins, reverse=True):
        if '@' + txt.lstrip('@') in seg2[max(0, pos - 150):pos + 150]:
            continue
        # avoid double spaces: put a space after, none before when next char is punctuation
        seg2 = seg2[:pos] + txt + seg2[pos:]
        fills.append((kind, lab, r))
    typ = typ[:off] + seg2 + typ[off + len(seg):]
    # offsets shifted; recompute remaining paras lazily
    tparas = []
    for mm in re.finditer(r'(?:^|\n\n)([^\n][\s\S]*?)(?=\n\n|\Z)', typ):
        s2 = mm.group(1)
        w2 = typ_words(s2)
        if len(w2) >= 4:
            tparas.append((w2, mm.start(1), s2))

print('%s: tex paragraphs with refs %d, fills %d, skipped %d'
      % (pid, len(texparas), len(fills), len(skipped)))
for kind, lab, r in fills:
    print('  FILL %-8s %-28s ratio %.2f' % (kind, lab, r))
for sk in skipped:
    kind, lab, why = sk[0], sk[1], sk[2]
    extra = ''
    if len(sk) > 3:
        extra = '  [anchor=%r nwtyp=%r nwtex=%r next=%r]' % sk[3]
    print('  SKIP %-8s %-28s %s%s' % (kind, lab, why, extra))
if APPLY and fills:
    shutil.copy(typp, typp + '.prereffill')
    io.open(typp, 'w', encoding='utf-8', newline='\n').write(typ)
    print('applied (backup .prereffill)')
