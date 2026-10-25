import io, glob, os, re, sys
sys.stdout.reconfigure(encoding='utf-8')

for path in sorted(glob.glob('papers/*/main.typ')):
    s = io.open(path, encoding='utf-8').read()
    # empty refs in text: Eq./Equation/Fig./Section followed by ()
    empty = [(m.start(), s[max(0, m.start() - 55):m.end() + 5].replace('\n', ' '))
             for m in re.finditer(r'(?:Eqs?\.|Equations?|Figs?\.|Figures?|Sec\.|Sections?|Tabs?\.|Tables?)\s*~?\s*\(\)', s)]
    # literal noun directly before an @ref
    nou = [(m.start(), s[max(0, m.start() - 35):m.start() + 30].replace('\n', ' '))
           for m in re.finditer(r'(?:Eqs?\.|Equations?|Figs?\.|Figures?|Sec\.|Sections?|Tabs?\.|Tables?)\s*~?\s*@[\w:.\-]+', s)]
    if empty or nou:
        print('####', path, 'empty', len(empty), 'noun', len(nou))
        for p, t in empty[:12]:
            print('  E @%d %r' % (p, t))
        for p, t in nou[:12]:
            print('  N @%d %r' % (p, t))
