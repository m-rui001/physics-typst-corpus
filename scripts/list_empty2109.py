import io, re, sys
sys.stdout.reconfigure(encoding='utf-8')
s = io.open('papers/2109.00548/main.typ', encoding='utf-8').read()
for m in re.finditer(r'(?:Eqs?\.|Equations?|Figs?\.|Figures?|Sec\.|Sections?)\s*~?\s*\(\)', s):
    a = max(0, m.start() - 90)
    print('@%d  ...%s[[%s]]' % (m.start(), s[a:m.start()].replace('\n', ' '), m.group(0)))
