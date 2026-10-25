# -*- coding: utf-8 -*-
"""Fill `#text([])` holes left by the converter with the citation/reference that vanished.

Anchor: the prose words immediately before the hole.  Walk the TeX prose in document
order (monotonic cursor) and take the event that follows the anchor, skipping as many
events as the Typst segment before the hole already renders.  Conservative -- a hole is
left untouched when the anchor is not found or the chosen event is too far away.

usage: python tools/holefill.py <paper_id> [--apply]
"""
import io, glob, os, re, sys, shutil

BS = chr(92)
pid = sys.argv[1]
APPLY = '--apply' in sys.argv
pdir = os.path.join('papers', pid)

CITE = re.compile(BS * 2 + r'[a-zA-Z]*cite[a-zA-Z]*'
                  + r'(?:\[[^\]\n]*\]){0,2}\{([^{}]+)\}')
REF = re.compile(BS * 2 + r'(eq|auto|page|name)?ref\{([^{}]+)\}')
TYP_REF = re.compile(r'@([A-Za-z0-9_.:\-]+)|#(?:cite|ref)\s*\(\s*<([A-Za-z0-9_.:\-]+)>')

tex = ''
main = ''
for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True):
    t = io.open(f, encoding='utf-8', errors='replace').read()
    if main == '' and BS + 'documentclass' in t:
        main = f
    if len(t) > len(tex):
        tex = t
if main:
    tex = io.open(main, encoding='utf-8', errors='replace').read()
typp = os.path.join(pdir, 'main.typ')
typ = io.open(typp, encoding='utf-8').read()
labels = set(re.findall(r'<([A-Za-z0-9_.:\-]+)>', typ))


def build(tex):
    """Return (list of (word, start, end), list of (start, kind, value))."""
    work = list(tex)
    events = []

    def blank(a, b):
        for k in range(a, b):
            work[k] = ' '

    for m in re.finditer(r'(?<!' + BS * 2 + r')' + BS + r'%.*', tex):
        blank(m.start(), m.end())
    for m in CITE.finditer(tex):
        events.append((m.start(), 'cite', [k.strip() for k in m.group(1).split(',') if k.strip()]))
        blank(m.start(), m.end())
    for m in REF.finditer(tex):
        events.append((m.start(), 'ref', m.group(2)))
        blank(m.start(), m.end())
    for m in re.finditer(r'\$[^$]*\$', tex):
        blank(m.start(), m.end())
    for m in re.finditer(BS * 2 + r'[A-Za-z]+\*?', tex):
        blank(m.start(), m.end())
    w = ''.join(work)
    toks = [(m.group(0).lower(), m.start(), m.end()) for m in re.finditer(r'[A-Za-z]{2,}', w)]
    events.sort()
    return toks, events


TOKS, EVENTS = build(tex)


def words(s):
    s = re.sub(r'@[A-Za-z0-9_.:\-]+', ' ', s)
    s = re.sub(r'#\w+\[([^\]]*)\]', r'\1', s)
    s = re.sub(r'\$[^$]*\$', ' ', s)
    s = re.sub(r'[^A-Za-z ]', ' ', s)
    return re.findall(r'[A-Za-z]{2,}', s.lower())


def find_anchor(anchor, start_tok):
    for n in (5, 4, 3, 2):
        seq = anchor[-n:]
        if len(seq) < 2:
            continue
        for i in range(start_tok, len(TOKS) - n):
            if [t[0] for t in TOKS[i:i + n]] == seq:
                return i + n - 1
    return None


def label_ok(l):
    return l in labels or l.replace(':', '-') in labels


def emit(kind, val):
    if kind == 'cite':
        keys = [k for k in val if k in labels or True]
        return ' '.join('@' + k for k in keys)
    lab = val if val in labels else val.replace(':', '-')
    if lab in labels:
        return '@' + lab
    return None


parts = typ.split('#text([])')
out = [parts[0]]
cur = 0
filled = skipped = 0
for k in range(1, len(parts)):
    before, after = parts[k - 1], parts[k]
    a = words(before)
    prev_seg = before[-400:]
    n_skip = len(TYP_REF.findall(prev_seg))
    idx = find_anchor(a, cur) if a else None
    repl = '#text([])'
    if idx is not None:
        cur = idx
        aend = TOKS[idx][2]
        seg = before[-220:]
        present = {re.sub(r'[^a-z0-9]', '', (m.group(1) or m.group(2)).lower())
                   for m in TYP_REF.finditer(seg)}
        evs = [(st, kind, val) for st, kind, val in EVENTS if aend <= st <= aend + 300]
        rep = None
        if evs:
            st, kind, val = evs[0]
            if kind == 'cite':
                miss = [k for k in val
                        if re.sub(r'[^a-z0-9]', '', k.lower()) not in present]
                if miss and len(miss) < len(val):
                    rep = ' '.join('@' + k for k in miss)   # sibling key of a bound group
                elif n_skip == 0 and st - aend < 120:
                    rep = ' '.join('@' + k for k in val)
            elif kind == 'ref' and n_skip == 0 and st - aend < 160:
                rep = emit('ref', val)
        if rep:
            repl = rep
            filled += 1
            print('FILL  %-55s -> %s' % (' '.join(a[-6:]), rep))
    if repl == '#text([])':
        skipped += 1
        print('KEEP  %-55s' % ' '.join(a[-6:]))
    out.append(repl)
    out.append(after)
res = ''.join(out)
print('%s: holes %d, filled %d, kept %d' % (pid, len(parts) - 1, filled, skipped))
if APPLY and filled:
    shutil.copy(typp, typp + '.preholefill')
    io.open(typp, 'w', encoding='utf-8', newline='\n').write(res)
    print('applied (backup .preholefill)')
