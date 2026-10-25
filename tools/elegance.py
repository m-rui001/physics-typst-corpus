# -*- coding: utf-8 -*-
"""Elegance census: rank converted papers by how much converter junk survived in their Typst.

A clean compile and a full citation census say nothing about whether the output reads like
hand-written Typst. This counts the constructs that make converted code ugly or fragile:
spacing hacks, TeX remnants, defensive wrappers, and the empty-text holes the converter leaves.
"""
import io, os, re, sys, glob

CHECKS = [
    ('holes',      r'#text\(\s*\[\s*\]\s*\)',        'empty #text([]) left by a dropped macro'),
    ('hackspace',  r'#h\(\s*[0-9.]+\s*em',           'manual kern instead of real spacing'),
    ('vspace',     r'#v\(\s*-?[0-9.]+\s*(em|pt)',    'manual vertical glue'),
    ('texesc',     r'\\[a-zA-Z]',                    'surviving TeX control word'),
    ('upright',    r'upright\(',                     'upright() wrapper, often redundant'),
    ('boxwrap',    r'#box\[',                        'defensive #box wrapper'),
    ('inlinefig',  r'#image\(',                      'inline #image instead of #figure'),
    ('gluedlabel', r'\$\s*<[A-Za-z0-9_.:\-]+>',     'equation label glued to the closing $ (fragile)'),
    ('escspace',   r'\\[,;!]|\\quad|\\qquad',        'TeX spacing command inside Typst'),
    ('rawtext',    r'text\(\s*[0-9.]+\s*pt',         'hardcoded font size instead of #set'),
    ('setlocal',   r'#set (font|text|par)\(',        'per-element #set that belongs in the preamble'),
    ('longline',   r'^.{600,}$',                     'unbroken >600-char line, unreadable source'),
]

SKIPDIR = ('.pre', '.bak', '.orig', '_work', 'build')


def main():
    rows = []
    for pid in sorted(os.listdir('papers')):
        files = [f for f in glob.glob(os.path.join('papers', pid, '*.typ'))
                 if not any(s in os.path.basename(f) for s in SKIPDIR)]
        if not files:
            continue
        src = '\n'.join(io.open(f, encoding='utf-8', errors='replace').read() for f in files)
        counts = {}
        for name, pat, _ in CHECKS:
            flags = re.M if name == 'longline' else 0
            counts[name] = len(re.findall(pat, src, flags))
        score = sum(counts.values())
        rows.append((score, pid, counts, len(files)))
    rows.sort(reverse=True)
    hdr = 'score %-12s lines ' % 'files' + ' '.join('%-10s' % n for n, _, _ in CHECKS)
    print(hdr)
    for score, pid, c, nf in rows:
        print('%5d %-12s %4d  ' % (score, pid, nf) +
              ' '.join('%-10d' % c[n] for n, _, _ in CHECKS))
    print('\nwhat each column means:')
    for name, pat, why in CHECKS:
        print('  %-10s %s' % (name, why))


if __name__ == '__main__':
    main()
