import io, re, json, sys
src = io.open('papers/2202.13919/src/main_v5.tex', encoding='utf-8').read()
typ = io.open('papers/2202.13919/main.typ', encoding='utf-8').read()

def norm(s):
    return re.sub(r'[^A-Za-z0-9]', '', s)

# normalize source once; keep index map to original
ns = []
idx = []
for i, ch in enumerate(src):
    if ch.isalnum() and ord(ch) < 128:
        ns.append(ch); idx.append(i)
ns = ''.join(ns)

def keytex(k):
    k = k.replace('_', '-').replace('/', '-')
    return k

out = []
for m in re.finditer(r'#text\(\[\]\)', typ):
    pre = typ[max(0, m.start()-90):m.start()]
    npre = norm(pre)[-28:]
    p = ns.find(npre)
    # try shorter if not found
    while p < 0 and len(npre) > 12:
        npre = npre[2:]
        p = ns.find(npre)
    if p < 0:
        out.append((m.start(), None, pre[-50:])); continue
    orig = idx[p + len(npre) - 1] + 1
    tail = src[orig:orig+260]
    B = chr(92)
    first = 9999; kind=None; val=None
    for kindpat, kindname in ((B+B + r'cite[a-z]*\{([^{}]*)\}','cite'), (B+B + r'ref\{([^{}]*)\}','ref')):
        mm = re.search(kindpat, tail)
        if mm and mm.start() < first:
            first = mm.start(); kind=kindname; val=mm.group(1)
    out.append((typ.count('\n',0,m.start())+1, kind, val, tail[:90].replace('\n',' ')))
for o in out:
    print(o[0], o[1], o[2] if o[1] else '', '|', o[3][:70] if len(o)>3 else '')
