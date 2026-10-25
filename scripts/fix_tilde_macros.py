"""Restore dropped project macros at leftover nbsp sites, verified per site.

For every word in main.typ preceded by '~', take 4 words either side and look
for the same 8-word window in the source paragraphs with a macro marker in the
middle.  Only unique matches are edited, so legitimate non-breaking spaces are
left alone.

Usage: python scripts/fix_tilde_macros.py <paper-dir> <src.tex> <Name1,...> <repl> [--apply]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fix_project_macro as F

BS = chr(92)


def main():
    paper, srcname, macrolist, repl = sys.argv[1:5]
    apply = '--apply' in sys.argv
    macros = set(macrolist.split(','))
    src = open(srcname, encoding='utf-8', errors='replace').read()
    src = src[src.find(BS + 'begin{document}'):]
    src = F.strip_comments(src)
    typ = open(os.path.join(paper, 'main.typ'), encoding='utf-8').read()

    sblocks = []
    for sp in src.split('\n\n'):
        st = F.src_tokens(sp, macros)
        if not any(t[0] == 'mark' for t in st):
            continue
        sw, marks, w = [], set(), 0
        for t in st:
            if t[0] == 'word':
                sw.append(t[1])
                w += 1
            elif t[0] == 'mark':
                marks.add(w)
        sblocks.append((sw, marks))

    edits = []
    ambiguous = 0
    pos = 0
    for b in typ.split('\n\n'):
        if F.is_prose(b):
            bt = F.main_tokens(b)
            mw = [t[1] for t in bt if t[0] == 'word']
            starts = [t[2] for t in bt if t[0] == 'word']
            for i in range(4, len(mw) - 4):
                j = starts[i] - 1
                if j < 0 or b[j] != '~':
                    continue
                before, after = mw[i - 4:i], mw[i:i + 4]
                hits = 0
                for sw, marks in sblocks:
                    for k in range(4, len(sw) - 4):
                        if k in marks and sw[k - 4:k] == before and sw[k:k + 4] == after:
                            hits += 1
                if hits != 1:
                    if hits:
                        ambiguous += 1
                    continue
                a = starts[i]
                while a > 0 and b[a - 1] == '~':
                    a -= 1
                edits.append((pos + a, pos + starts[i], repl + ' '))
        pos += len(b) + 2

    edits = sorted(set(edits), key=lambda e: e[0])
    print('source-verified edits:', len(edits), 'ambiguous skipped:', ambiguous)
    for a, c, t in edits[:15]:
        print('---', repr(typ[max(0, a - 40):a]) + '<<' + t + '>>' + repr(typ[c:c + 25]))
    if not apply:
        return
    out = typ
    for a, c, t in reversed(edits):
        out = out[:a] + t + out[c:]
    bak = os.path.join(paper, 'main.typ.pretilde')
    if not os.path.exists(bak):
        open(bak, 'w', encoding='utf-8', newline='\n').write(typ)
    open(os.path.join(paper, 'main.typ'), 'w', encoding='utf-8', newline='\n').write(out)
    print('applied', len(edits))


if __name__ == '__main__':
    main()
