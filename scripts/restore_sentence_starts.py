import io, glob, os, re, sys
sys.stdout.reconfigure(encoding='utf-8')
APPLY = '--apply' in sys.argv


def norm(tex):
    t = re.sub(r'%.*', '', tex)
    t = re.sub(r'\$[^$]*\$', ' MATH ', t)
    t = re.sub(r'\\begin\{(?:equation|align|gather|eqnarray|figure|table|tabular)\*?\}.*?\\end\{(?:equation|align|gather|eqnarray|figure|table|tabular)\*?\}',
               ' MATH ', t, flags=re.S)
    t = re.sub(r'\\(?:emph|textit|textbf|textrm|text|mathrm|textsc|underline|mbox|hbox)\{', '{', t)
    t = re.sub(r'\\[a-zA-Z]+\*?(?:\[[^\]]*\])?', ' ', t)
    t = t.replace('~', ' ').replace('{', ' ').replace('}', ' ')
    return re.sub(r'[ \t]+', ' ', t)


def clean_typ(t):
    t = re.sub(r'\$[^$]*\$', ' MATH ', t)
    t = re.sub(r'#\w+(?:\([^)]*\)|\[[^\]]*\])?', ' ', t)
    t = re.sub(r'@[\w:.\-]+', ' R ', t)
    return re.sub(r'<[^<>\s]+>', ' ', t)


def words(t):
    return re.findall(r"[A-Za-z][A-Za-z'-]*", t)


def collect(s, src):
    edits = []
    spans = []
    for para in re.finditer(r'(?:^|\n\s*\n)([^\n$#=<\[\]|][^\n]{25,})', s):
        spans.append(para.start(1))
    for m in re.finditer(r'(?<=[.!?])\s+([a-z][a-z]{2,})', s):
        pre = s[max(0, m.start() - 20):m.start()]
        if re.search(r'(?:[A-Z]\.|e\.g\.|i\.e\.|cf\.|al\.|Fig\.|Eq\.|Ref\.|Sec\.|vs\.|approx\.|resp\.|No\.|et)\s*$', pre):
            continue
        spans.append(m.start(1))
    seen = set()
    for p in spans:
        if p in seen:
            continue
        seen.add(p)
        cw = words(clean_typ(s[p:p + 90]))
        if len(cw) < 4:
            continue
        tp = re.search(r"[A-Za-z][A-Za-z'-]*", s[p:p + 90])
        tw = tp.group(0)
        tpat = r'\b\w*' + re.escape(tw) + r'\s+' + re.escape(cw[1]) + r'\s+' + re.escape(cw[2])
        thits = list(re.finditer(tpat, src))
        if len(thits) == 1 and len(tw) >= 4:
            full = re.search(r"[\w'-]+$", thits[0].group(0)).group(0)
            if len(full) > len(tw) and full.endswith(tw):
                edits.append((p, p + len(tw), full))
                continue
        pat = r'\b' + r'\s+'.join(re.escape(w) for w in cw[:3]) + r'\b'
        hits = list(re.finditer(pat, src))
        if len(hits) != 1:
            continue
        k = hits[0].start()
        if k > 0 and src[k - 1].isalpha():
            continue
        back = src[max(0, k - 70):k]
        cut = max(back.rfind('. '), back.rfind('? '), back.rfind('! '))
        omitted = (back[cut + 2:] if cut >= 0 else back).strip()
        ow = omitted.split()
        if not ow or len(ow) > 4:
            continue
        if not all(re.match(r"[A-Za-z'-]+$", w) for w in ow):
            continue
        if not ow[-1][0].isupper() or cw[0][0].isupper():
            continue
        edits.append((p, p, ' '.join(ow) + ' '))
    return edits


applied = 0
for paper in sorted(glob.glob('papers/*')):
    path = os.path.join(paper, 'main.typ')
    if not os.path.exists(path):
        continue
    s = io.open(path, encoding='utf-8').read()
    src = ' '.join(io.open(f, encoding='utf-8', errors='ignore').read()
                   for f in glob.glob(os.path.join(paper, 'src', '**', '*.tex'), recursive=True))
    edits = collect(s, norm(src))
    if not edits:
        continue
    print('####', paper, len(edits))
    for p, e, new in edits[:10]:
        print('   %r  <<< %s' % (s[p:p + 55].replace('\n', ' '), new))
    if APPLY:
        io.open(path + '.prestartfix', 'w', encoding='utf-8').write(s)
        for p, e, new in sorted(edits, reverse=True):
            s = s[:p] + new + s[e:]
        io.open(path, 'w', encoding='utf-8').write(s)
    applied += len(edits)
print('total', applied)
