import glob, re, os
pat = re.compile(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}')
for d in sorted(glob.glob('papers/*/main.typ')):
    tid = d.split(os.sep)[1]
    src = []
    for root, _, files in os.walk(os.path.join('papers', tid, 'src')):
        for f in files:
            if f.endswith(('.tex',)):
                src.append(os.path.join(root, f))
    emails = set()
    for f in src:
        try:
            txt = open(f, encoding='utf-8', errors='ignore').read()
        except Exception:
            continue
        emails |= set(pat.findall(txt))
    if not emails:
        continue
    mt = open(d, encoding='utf-8').read()
    missing = [e for e in emails if e not in mt]
    if missing:
        print(tid, len(missing), sorted(missing)[:6])
