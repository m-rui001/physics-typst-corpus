# -*- coding: utf-8 -*-
"""Rebuild 2107.13563's supplementary section, which the old main.typ dropped after its TOC.

usage: python tools/add13563supp.py [--apply]
"""
import io, os, re, shutil, subprocess, sys

BS = chr(92)
p = 'papers/2107.13563'
src = io.open(p + '/src/main.tex', encoding='utf-8', errors='replace').read().split('\n')
i = next(k for k, l in enumerate(src) if 'Supplementary materials' in l and k > 300)
j = next(k for k, l in enumerate(src) if BS + 'end{document}' in l)
frag = '\n'.join(src[i:j])
frag = re.sub(BS * 2 + r'(makeatletter|makeatother|onecolumngrid|twocolumngrid|newpage|clearpage)\b', '', frag)
frag = re.sub(BS * 2 + r'vspace\*?\{[^{}]*\}', '', frag)
frag = re.sub(BS * 2 + r'setcounter\{[^{}]*\}\{[^{}]*\}', '', frag)
frag = re.sub(BS * 2 + r'renewcommand\{[^{}]*\}\{[^{}]*\}', '', frag)
frag = frag.replace(BS + r'\begin{center}', '').replace(BS + r'\end{center}', '')
frag = frag.replace(BS + r'\textbf{SUPPLEMENTARY MATERIAL}', 'SUPPLEMENTARY MATERIAL')
frag = re.sub(BS * 2 + r'ket\{([^{}]*)\}', lambda m: '|' + m.group(1) + BS + 'rangle', frag)
frag = re.sub(BS * 2 + r'bra\{([^{}]*)\}', lambda m: BS + 'langle' + m.group(1) + '|', frag)
frag = re.sub(BS * 2 + r'(nonumber|label\{[^{}]*\}|tag\{[^{}]*\})', '', frag)
io.open('tmp/13563supp.tex', 'w', encoding='utf-8', newline='\n').write(frag)
r = subprocess.run(['pandoc', 'tmp/13563supp.tex', '-f', 'latex', '-t', 'typst',
                    '--wrap=none', '-o', 'tmp/13563supp.typ'],
                   capture_output=True, text=True, encoding='utf-8', errors='replace')
print('pandoc rc', r.returncode)
err = r.stderr
open('tmp/13563supp.err', 'w', encoding='utf-8').write(err)
print('unconverted math:', err.count('Could not convert'))
typ = io.open('tmp/13563supp.typ', encoding='utf-8').read()
print('lines', typ.count(chr(10)), 'chars', len(typ))
# pandoc turns \left( into `#scale(...)[\(]`, leaves `\(` inside math, and emits
# `\` line breaks in split displays -- all illegal or pointless in Typst.
typ = re.sub(r'#scale\([^)]*\)\[\\\(\]', '(', typ)
typ = re.sub(r'#scale\([^)]*\)\[\\\)\]', ')', typ)
typ = re.sub(r'#scale\([^)]*\)\[\\\[\]', '[', typ)
typ = re.sub(r'#scale\([^)]*\)\[\\\]\]', ']', typ)


def fix_math(m):
    s = m.group(1).replace(BS + '(', '(').replace(BS + ')', ')')
    s = s.replace(BS + ', thin', '').replace(BS + 'thin', '')
    s = re.sub(BS * 2 + r'\s*\n', ' ', s)
    return '$' + s + '$'


typ = re.sub(r'\$([^$\n]*)\$', fix_math, typ)
typ = re.sub(r'#link\(<[^>]+>\)\[([^\]]*)\]', r'\1', typ)
io.open('tmp/13563supp.typ', 'w', encoding='utf-8', newline='\n').write(typ)
if '--apply' in sys.argv:
    mp = p + '/main.typ'
    m = io.open(mp, encoding='utf-8').read()
    if 'Details on the gauge theory' in m:
        print('already applied')
        sys.exit()
    typ = typ.replace('"Fig-S1"', '"figures/Fig-S1"').replace('"Fig-S2.pdf"', '"figures/Fig-S2.pdf"')
    typ = typ.replace('"Fig-S3.pdf"', '"figures/Fig-S3.pdf"').replace('"Fig-S4.pdf"', '"figures/Fig-S4.pdf"')
    typ = typ.replace('"Fig-S5.pdf"', '"figures/Fig-S5.pdf"')
    anchor = '#pagebreak(weak: true)'
    k = m.index(anchor)
    shutil.copy(mp, mp + '.presupp')
    m = m[:k] + typ + '\n\n' + m[k:]
    io.open(mp, 'w', encoding='utf-8', newline='\n').write(m)
    print('inserted before pagebreak')
