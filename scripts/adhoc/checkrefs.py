import os, re, sys

pat = re.compile(r'"([^"\n]+)"')
out = []
for pid in sorted(os.listdir('papers')):
    d = os.path.join('papers', pid)
    m = os.path.join(d, 'main.typ')
    if not os.path.exists(m):
        continue
    txt = open(m, encoding='utf-8', errors='replace').read()
    for ref in pat.findall(txt):
        if ref.startswith(('http://', 'https://', 'ftp://', '@')):
            continue
        if ' ' in ref or '\n' in ref or len(ref) > 120:
            continue
        if not re.search(r'\.[A-Za-z0-9]{1,5}$', ref):
            continue
        if not os.path.exists(os.path.join(d, ref)):
            out.append((pid, ref))
with open('tmp/missing_refs.txt', 'w', encoding='utf-8') as f:
    for pid, ref in out:
        f.write(pid + ' ' + ref + '\n')
print(len(out), 'missing')
