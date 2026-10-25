# -*- coding: utf-8 -*-
"""Find TeX macros that never got expanded: their name survives as a word in main.typ.

usage: python tools/macro_leak.py [paperid ...]
"""
import io, os, re, sys, glob

BS = chr(92)
NEWCMD = re.compile(BS * 2 + r'(?:re)?newcommand\{?' + BS * 2 + r'([a-zA-Z][a-zA-Z0-9]*)\}?')
SKIP = {'text', 'ref', 'cite', 'label', 'frac', 'sqrt', 'theta', 'alpha',
        'fig', 'sec', 'eq', 'tab'}

ids = [a for a in sys.argv[1:] if not a.startswith('-')]
for pid in (ids or sorted(os.listdir('papers'))):
    p = os.path.join('papers', pid)
    mt = os.path.join(p, 'main.typ')
    if not os.path.isfile(mt):
        continue
    names = set()
    for f in glob.glob(os.path.join(p, 'src', '**', '*.tex'), recursive=True):
        names |= set(NEWCMD.findall(io.open(f, encoding='utf-8', errors='replace').read()))
    names = {n for n in names if len(n) > 2 and n not in SKIP and not n.startswith('color')}
    s = io.open(mt, encoding='utf-8', errors='replace').read()
    # comment lines hold prose (figvision annotations) and code, not the paper text
    scan = '\n'.join('' if ln.lstrip().startswith('//') else ln for ln in s.split('\n'))
    # a token that also occurs as a word in the reference PDF is legitimate prose
    # (e.g. \red when the text really says "red"), not an unexpanded macro
    ref = os.path.join('_t', 'txtcmp', pid + '.txt')
    refwords = set()
    if os.path.isfile(ref):
        refwords = {w.lower() for w in re.findall(r'[A-Za-z]+', io.open(ref, encoding='utf-8', errors='replace').read())}
    hits = []
    for n in names:
        if n.lower() in refwords:
            continue
        for m in re.finditer(r'(?<!\S)' + n + r'(?=\s|[.,;:!?]|$)', scan):
            if BS + n in scan[max(0, m.start() - 1):m.end()]:
                continue
            ln = scan[:m.start()].count('\n') + 1
            hits.append((ln, n, scan[max(0, m.start() - 70):m.end() + 40].replace('\n', ' ')))
    if hits:
        print('%s: %d leaks of %d macros' % (pid, len(hits), len(names)))
        for ln, n, ctx in sorted(hits)[:8]:
            print('   %4d %-14s %s' % (ln, n, ctx))
