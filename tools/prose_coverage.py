# -*- coding: utf-8 -*-
"""Prose coverage: what fraction of the TeX's words actually reached the Typst body?

The citation census only counts keys; a converter can drop whole sentences (a nested
\\edit with a cite, a figure caption) and still score 0E/0W.  This aligns the TeX word
stream against the Typst word stream and prints every run of words that exists in the
TeX but not in the Typst, longest first.  Runs are reported, not auto-repaired: a wide
math display or a table legitimately diverges, so a human decides.

usage: python tools/prose_coverage.py <paper_id> [--min-words 8] [--show 15]
"""
import io, glob, os, re, sys, difflib

BS = chr(92)


def strip_tex(s):
    s = re.sub(r'(?<!' + BS * 2 + r')' + BS + r'%.*', '', s)
    s = re.sub(r'\\begin\{comment\}.*?\\end\{comment\}', ' ', s, flags=re.S)
    s = re.sub(r'\\begin\{(equation|align|eqnarray|table|tabular|thebibliography)\*?\}.*?'
               r'\\end\{\1\*?\}', ' ', s, flags=re.S)
    s = re.sub(r'\$[^$]*\$', ' ', s)
    s = re.sub(r'\\[a-zA-Z]+\*?(\[[^\]]*\])?', ' ', s)
    s = re.sub(r'\{[^{}]*\}', lambda m: ' ' + m.group(0)[1:-1] + ' ', s)
    s = re.sub(r'[^A-Za-z ]', ' ', s)
    return s


def strip_typ(s):
    s = re.sub(r'^#import.*$', ' ', s, flags=re.M)
    s = re.sub(r'^#set .*$', ' ', s, flags=re.M)
    s = re.sub(r'^#show .*$', ' ', s, flags=re.M)
    s = re.sub(r'#figure\([^)]*\)', ' ', s)
    s = re.sub(r'#image\([^)]*\)', ' ', s)
    s = re.sub(r'\$[^$]*\$', ' ', s)
    s = re.sub(r'#\w+', ' ', s)
    s = re.sub(r'[@<>=/*_\[\](){}#~^\\]', ' ', s)
    s = re.sub(r'[^A-Za-z ]', ' ', s)
    return s


def toks(s):
    return [w.lower() for w in re.findall(r'[A-Za-z]{2,}', s)]


def main():
    pid = sys.argv[1]
    minw = int(sys.argv[sys.argv.index('--min-words') + 1]) if '--min-words' in sys.argv else 8
    show = int(sys.argv[sys.argv.index('--show') + 1]) if '--show' in sys.argv else 15
    pdir = pid if os.path.isdir(pid) else os.path.join('papers', pid)
    pid = os.path.basename(pdir.rstrip('/\\'))
    tex = ''
    for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True):
        t = io.open(f, encoding='utf-8', errors='replace').read()
        if '\\documentclass' in t:
            tex = t
            break
    if not tex:
        tex = max((io.open(f, encoding='utf-8', errors='replace').read()
                   for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True)),
                  key=len, default='')
    body = io.open(os.path.join(pdir, 'main.typ'), encoding='utf-8', errors='replace').read()
    a, b = toks(strip_tex(tex)), toks(strip_typ(body))
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    runs = []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag in ('delete', 'replace') and i2 - i1 >= minw:
            runs.append((i2 - i1, i1, i2, a[i1:i2]))
    runs.sort(reverse=True)
    print('%s: tex words %d, typst words %d, coverage %.3f'
          % (pid, len(a), len(b), sm.ratio()))
    print('%d missing runs >= %d words' % (len(runs), minw))
    for n, i1, i2, w in runs[:show]:
        print('\n-- %d words @tex word %d' % (n, i1))
        print('   ' + ' '.join(w[:40]))


if __name__ == '__main__':
    main()
