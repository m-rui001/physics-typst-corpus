import io, re, sys, glob
sys.stdout.reconfigure(encoding='utf-8')
src = ''
for f in glob.glob('papers/2109.00548/src/**/*.tex', recursive=True):
    src += io.open(f, encoding='utf-8', errors='ignore').read()
src = re.sub(r'%[^\n]*', '', src)
s = io.open('papers/2109.00548/main.typ', encoding='utf-8').read()

for m in re.finditer(r'(?:Eqs?\.|Equations?)\s*~?\s*\(\)', s):
    before = s[max(0, m.start() - 120):m.start()]
    before = re.sub(r'\$[^$]*\$', ' ', before)
    before = re.sub(r'#[a-zA-Z]+(?:\([^)]*\)|\[[^\]]*\])?', ' ', before)
    before = re.sub(r'@[^\s]+', ' ', before)
    bw = re.findall(r"[A-Za-z][A-Za-z'-]*", before)[-2:]
    pat = r'\s+'.join(re.escape(w) for w in bw)
    pat = r'\b' + pat + r'\s+(?:Eq\.?\s*~?\s*)?(?:\(\s*)?\\(?:eq)?ref\{([^}]+)\}'
    hits = list(re.finditer(pat, src))
    labels = [h.group(1) for h in hits]
    print('%-22s -> %s' % (' '.join(bw), labels if labels else 'NONE'))
