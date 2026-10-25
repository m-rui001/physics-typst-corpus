import re, io, difflib
BS = chr(92)
tex = io.open('papers/2308.07915/src/supplemental_v2.tex', encoding='utf-8', errors='replace').read()
typ = io.open('papers/2308.07915/main.typ', encoding='utf-8').read()
REFMAC = 'fig|tab|lem|sec|ssec|propos|thm|alg'
EV = re.compile(BS * 2 + '(' + REFMAC + r')\{([^{}]+)\}')

def tex_words(s):
    s = re.sub(r'(?<!' + BS * 2 + r')' + BS + r'%.*', '', s)
    s = re.sub(r'\$[^$]*\$', ' ', s)
    s = re.sub(re.escape(BS) + r'begin\{[^}]*\}.*?' + re.escape(BS) + r'end\{[^}]*\}', ' ', s, flags=re.S)
    s = EV.sub(' ', s)
    s = re.sub(BS * 2 + r'[a-zA-Z]+\*?(\[[^\]]*\])?', ' ', s)
    s = re.sub(r'[{}]', ' ', s)
    s = re.sub(r'[^A-Za-z ]', ' ', s)
    return re.findall(r'[A-Za-z]{2,}', s.lower())

def typ_words(s):
    s = re.sub(r'@[A-Za-z0-9_.:\-]+', ' ', s)
    s = re.sub(r'#\w+\([^)]*\)', ' ', s)
    s = re.sub(r'#\w+\[([^\]]*)\]', r' \1 ', s)
    s = re.sub(r'\$[^$]*\$', ' ', s)
    s = re.sub(r'<[A-Za-z0-9_.:\-]+>', ' ', s)
    s = re.sub(r'[^A-Za-z ]', ' ', s)
    return re.findall(r'[A-Za-z]{2,}', s.lower())

para = re.search(r'Fault tolerant implementation of the permutation.*?simultaneously\.', tex).group(0)
evs = [(m.start(), m.group(1), m.group(2)) for m in EV.finditer(para)]
chunks = []
last = 0
for st, k, l in evs:
    chunks.append(para[last:st])
    last = st
chunks.append(para[last:])
total = tex_words(' '.join(chunks))
cum = []
acc = 0
for c in chunks[:-1]:
    acc += len(tex_words(c))
    cum.append(acc)
typseg = re.search(r'Fault tolerant implementation[\s\S]*?simultaneously\.', typ).group(0)
twy = typ_words(typseg)
sm = difflib.SequenceMatcher(None, total, twy, autojunk=False)
print('nwords tex', len(total), 'typ', len(twy), 'ratio', sm.ratio())
t2y = {}
for a, b, n in sm.get_matching_blocks():
    for k in range(n):
        t2y[a + k] = b + k
ypos = [m.start() for m in re.finditer(r'[A-Za-z]{2,}', typseg)]
for en, k, l in zip(cum, [e[1] for e in evs], [e[2] for e in evs]):
    anchor = en - 1
    yi = None
    for back in range(4):
        if anchor - back in t2y:
            yi = t2y[anchor - back]
            break
    if yi is None:
        print(k, l, 'NO ANCHOR'); continue
    wend = re.compile(r'[A-Za-z]{2,}').search(typseg, ypos[yi]).end()
    nxt = typseg[wend:wend + 12].lstrip()
    nw = re.compile(r'[A-Za-z]{2,}').search(typseg, wend)
    print(k, l, 'en', en, 'anchor', total[anchor], 'yi', yi, 'word@yi', twy[yi],
          'nwtyp', nw.group(0) if nw else None, 'nwtex', total[en] if en < len(total) else None,
          'nxt', repr(nxt[:25]))
