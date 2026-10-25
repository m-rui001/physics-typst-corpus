"""Repair `\\$...\\$` spans that print literal LaTeX tokens instead of math.

The converter occasionally escapes a whole display span (`\\$ ... \\$`) when the
LaTeX inside could not be translated; Typst then prints the TeX tokens as text
(curly-quoted ``"left"``, ``less.eq``, a literal ``$``).  This tool rewrites the
spans that are mechanically recoverable:

  * norm delimiters   ``"left""lVert O "right""rVert"``  ->  ``norm(O)``
  * relations         ``less.eq / greater.eq``             ->  ``lt.eq / gt.eq``
  * font wrappers     ``"mathbb"{Z}``, ``"mathcal"{O}``    ->  ``bb(Z)``, ``cal(O)``
  * escaped TeX       ``\\_  \\{  \\}  \\ ``              ->  ``_  {  }  (space)``
  * complexity class  ``$"N" P$``                          ->  ``$bold("NP")$``

Spans that contain qcircuit commands (``\\gate``, ``\\Qcircuit`` ...) or raw
``\\begin{...}`` environments are reported as MANUAL and left untouched.

Usage:
  python -X utf8 tools/unescape_math.py            # report only
  python -X utf8 tools/unescape_math.py --apply    # rewrite every SAFE span
  python -X utf8 tools/unescape_math.py --apply --paper 2106.12627
"""
import argparse
import glob
import os
import re
import shutil
import sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SPAN = re.compile(r'\\\$(.*?)\\\$', re.S)
QCIRCUIT = re.compile(r'\\(gate|Qcircuit|lstick|multigate|qw|ghost|meter|gategroup)\b')
ENV = re.compile(r'\\begin\{')
PARTICLES = {'left', 'right'}


def unescape(body):
    b = body
    b = b.replace('\\\\{', '{').replace('\\\\}', '}')
    b = b.replace('\\_', '_')
    b = b.replace('\\{', '{').replace('\\}', '}')
    b = b.replace('\\(', '(').replace('\\)', ')')
    b = b.replace('\\ ', ' ')
    b = b.replace('\\^', '^')
    b = b.replace('\\%', '%')
    b = b.replace('\\&', '&')

    # norms: "left""lVertX" ... "right""rVert"
    b = re.sub(r'"left"\s*"lVert([A-Za-z]*)"?', lambda m: 'norm(' + m.group(1), b)
    b = re.sub(r'"lVert([A-Za-z]*)"', lambda m: 'norm(' + m.group(1), b)
    b = re.sub(r'"rVert"', ')', b)
    b = re.sub(r'"left"', '', b)
    b = re.sub(r'"right"', '', b)

    # relations
    b = re.sub(r'\bless\.eq\b', ' lt.eq ', b)
    b = re.sub(r'\bgreater\.eq\b', ' gt.eq ', b)
    b = re.sub(r'\bless\.eqslant\b', ' lt.eqslant ', b)
    b = re.sub(r'\bgreater\.eqslant\b', ' gt.eqslant ', b)

    # fonts
    b = re.sub(r'(?<=[A-Za-z])(?="mathbb")', ' ', b)
    b = b.replace('xtilde', 'x tilde')
    b = re.sub(r'"mathbb"\s*\{([^{}]*)\}', lambda m: 'bb(' + m.group(1) + ')', b)
    b = re.sub(r'"mathcal"\s*\{([^{}]*)\}', lambda m: 'cal(' + m.group(1) + ')', b)
    b = re.sub(r'"upright"\s*\(', 'upright(', b)
    b = re.sub(r'"textup"\s*\{([^{}]*)\}', lambda m: 'op("' + m.group(1) + '")', b)
    b = re.sub(r'"operatorname"\s*\{\s*\{\s*(bb\([A-Za-z]+\))\s*\}\s*\}',
               lambda m: m.group(1), b)
    b = re.sub(r'"operatorname"\s*\{\s*tr\s*\}', 'op("tr")', b)
    b = re.sub(r'"Tilde"\s*\{([^{}]*)\}', lambda m: 'tilde(' + m.group(1) + ')', b)
    b = re.sub(r'"tilde"\s*\(', 'tilde(', b)
    b = re.sub(r'"langle([A-Za-z]*)"', lambda m: '⟨' + m.group(1), b)
    b = re.sub(r'"rangle([A-Za-z]*)"', lambda m: m.group(1) + '⟩', b)
    b = re.sub(r'(?<=[A-Za-z0-9_)\]])angle\.r\b', '⟩', b)
    b = re.sub(r'angle\.l\b', '⟨', b)
    b = b.replace('"dagger"', 'dagger')

    b = re.sub(r'[ \t]+', ' ', b)
    return b.strip()


def merge_classes(body):
    """`"N" P O` -> `bold("NPO")`; the whole span is set in bold as TeX did."""
    b = body.replace('"', '')
    if re.search(r'sharp', b):
        b = re.sub(r'\bsharp\s*P\b', '♯P', b)
    b = re.sub(r'(?<=[A-Z])\s+(?=[A-Z](?:\s|$|\^|\)))', '', b)
    b = re.sub(r'(?<![A-Za-z])subset(?:eq)?(?![A-Za-z])', ' subset ', b)
    b = re.sub(r'[A-Za-z][A-Za-z]*',
               lambda m: m.group(0) if m.group(0) in
               ('subset', 'subseteq', 'in', 'set') else '"' + m.group(0) + '"', b)
    b = re.sub(r'\s+', ' ', b)
    return 'bold(' + b.strip() + ')'


def classify(body):
    if QCIRCUIT.search(body):
        return 'MANUAL-qcircuit'
    if ENV.search(body):
        return 'MANUAL-env'
    if re.search(r'(?<![A-Za-z])("left"|"lVert|less\.eq|greater\.eq|"mathbb"|"mathcal"|'
                 r'"upright"|"textup"|"operatorname"|"langle|"Tilde"|"tilde"|'
                 r'\\_|\\\{|\\\}|\\ )', body):
        return 'SAFE'
    rest = re.sub(r'"[^"]*"', '', body)
    rest = re.sub(r'\b(subset|subseteq)\b', '', rest)
    if re.fullmatch(r'[\sA-Z^()\-.,|+]*', rest):
        return 'SAFE-class'
    return 'KEEP'


def fix_span(m, kind):
    body = m.group(1)
    if kind == 'SAFE-class':
        new = merge_classes(body)
    else:
        new = unescape(body)
    return '$' + new + '$'


def process(path, apply):
    s = open(path, encoding='utf-8').read()
    out = []
    last = 0
    changed = 0
    manual = 0
    for m in SPAN.finditer(s):
        if not m.group(1).strip():
            manual += 1
            continue
        kind = classify(m.group(1))
        if kind.startswith('MANUAL'):
            manual += 1
            print('  %s line %d: %s -> %s' % (os.path.basename(os.path.dirname(path)),
                                              s[:m.start()].count('\n') + 1, kind,
                                              re.sub(r'\s+', ' ', m.group(0))[:120]))
            continue
        if kind == 'KEEP':
            continue
        new = fix_span(m, kind)
        out.append(s[last:m.start()])
        out.append(new)
        last = m.end()
        changed += 1
        if not apply:
            print('  %s line %d: %s -> %s' % (os.path.basename(os.path.dirname(path)),
                                              s[:m.start()].count('\n') + 1,
                                              re.sub(r'\s+', ' ', m.group(0))[:90],
                                              re.sub(r'\s+', ' ', new)[:90]))
    if apply and changed:
        out.append(s[last:])
        shutil.copy2(path, path + '.preunescape')
        open(path, 'w', encoding='utf-8').write(''.join(out))
    return changed, manual


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--apply', action='store_true')
    ap.add_argument('--paper')
    a = ap.parse_args()
    if a.paper:
        paths = ['papers/%s/main.typ' % a.paper]
    else:
        paths = sorted(glob.glob('papers/*/main.typ'))
    total = man = 0
    for p in paths:
        c, m = process(p, a.apply)
        if c or m:
            print('%s: fixed=%d manual=%d' % (p, c, m))
        total += c
        man += m
    print('TOTAL fixed=%d manual=%d%s' % (total, man, ' (applied)' if a.apply else ''))


if __name__ == '__main__':
    main()
