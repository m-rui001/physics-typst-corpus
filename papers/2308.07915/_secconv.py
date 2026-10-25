# -*- coding: utf-8 -*-
"""Splice a clean pandoc conversion of the 'Decoder' section into 2308.07915/main.typ.

The converter left raw TeX in this section (\\mat(delim: #none, ...), $$\\left[ ... $$),
which cannot compile. Convert the source section on its own instead.
"""
import io, re, subprocess, os

B = chr(92)
SRC = 'src/supplemental_v2.tex'
src = io.open(SRC, encoding='utf-8', errors='replace').read()
i = src.find(B + 'section{Decoder for the circuit-based noise model}')
j = src.find(B + 'section{Proof of Lemma 1}')
sec = src[i:j]

# macros that live in the (missing) packages.tex
pre = '\n'.join([
    B + 'newcommand{' + B + 'cnotgate}{' + B + 'text{CNOT}}',
    B + 'newcommand{' + B + 'qc}{' + B + 'text{QC}' + B + '(A,B)}',
    B + 'newcommand{' + B + 'qcd}{' + B + 'text{QC}' + B + '(A,B)}',
    B + 'newcommand{' + B + 'ra}{' + B + 'rangle}',
    B + 'newcommand{' + B + 'la}{' + B + 'langle}',
    B + 'newcommand{' + B + 'be}{' + B + 'begin{equation}}',
    B + 'newcommand{' + B + 'ee}{' + B + 'end{equation}}',
    B + 'newcommand{' + B + 'ba}[1]{' + B + 'begin{array}{#1}}',
    B + 'newcommand{' + B + 'ea}{' + B + 'end{array}}',
    B + 'newcommand{' + B + 'calU}{' + B + 'mathcal{U}}',
    B + 'newcommand{' + B + 'calZ}{' + B + 'mathcal{Z}}',
    B + 'newcommand{' + B + 'qc}{' + B + 'text{QC}(A,B)}',
    B + 'newcommand{' + B + 'rs}[1]{' + B + 'mathrm{rs}(#1)}',
    B + 'newcommand{' + B + 'non}{' + B + 'nonumber}',
])
text = pre + '\n' + sec
text = text.replace(B + 'begin{equation*', B + 'begin{equation')
text = re.sub(r'\\' + B + '?label\{[^}]*\}', '', text)
text = re.sub(r'\\' + B + '?nonumber', '', text)
io.open('_sec.tex', 'w', encoding='utf-8', newline='').write(text)
r = subprocess.run(['pandoc', '_sec.tex', '-f', 'latex', '-t', 'typst', '--wrap=none'],
                   capture_output=True, text=True, encoding='utf-8')
if r.returncode != 0:
    print(r.stderr[:2000])
    raise SystemExit(1)
out = r.stdout
print('pandoc warnings:', r.stderr.count('WARNING'))
# pandoc emits a phantom `; #none` row for \left[...\right] with an empty last row
out = re.sub(r';\s*#none\s*\)', ')', out)
# stray TeX delimiters that survived as prose
out = out.replace('\$\$', '')
out = out.replace(B + '(', '(').replace(B + ')', ')')
out = out.replace(B + '\\[', '[').replace(B + '\\]', ']')
io.open('_sec.typ', 'w', encoding='utf-8').write(out)
print(out[:300])

