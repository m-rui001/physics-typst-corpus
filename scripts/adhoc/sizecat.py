import os, collections, sys
base = sys.argv[1] if len(sys.argv) > 1 else 'papers'
cat = collections.Counter(); n = collections.Counter()
for p in sorted(os.listdir(base)):
    d = os.path.join(base, p)
    if not os.path.isdir(d):
        continue
    for root, dirs, files in os.walk(d):
        for f in files:
            fp = os.path.join(root, f)
            try:
                s = os.path.getsize(fp)
            except OSError:
                continue
            rel = os.path.relpath(fp, d).replace(os.sep, '/')
            if '/' in rel:
                top = rel.split('/')[0]
            elif f.endswith(('.typ', '.bib', '.yml', '.yaml', '.json', '.csl', '.py', '.sh')):
                top = '<src>'
            elif f.endswith('.pdf'):
                top = '<root-pdf>'
            elif f.startswith(('main.typ.', 'refs.bib.', 'main.bak')):
                top = '<backup>'
            else:
                top = '<root-other>'
            cat[top] += s; n[top] += 1
for k, v in cat.most_common(30):
    print('%9.1f MB %5d  %s' % (v / 1048576, n[k], k))
