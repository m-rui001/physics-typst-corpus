"""`{\\rm PBH}` converts to `upright(P B H)`, which Typst sets as three spaced variables.
Join runs of single-letter identifiers into one upright string: `upright("PBH")`.
Only runs of 2+ separated single letters are touched; `upright(x)` stays.
"""
import glob, io, os, re, shutil, subprocess, sys

PAT = re.compile(r'upright\(\s*([A-Za-z](?:[ ]+[A-Za-z]){1,})\s*\)')

def fix(path, apply=True):
    s = io.open(path, encoding='utf-8').read()
    hits = {}
    def rep(m):
        word = ''.join(m.group(1).split())
        hits[word] = hits.get(word, 0) + 1
        return 'upright("%s")' % word
    t = PAT.sub(rep, s)
    if not hits:
        return {}
    if apply:
        shutil.copy2(path, path + '.preupright')
        io.open(path, 'w', encoding='utf-8', newline=chr(10)).write(t)
    return hits

def build(pid):
    with io.open('papers/%s/build/compile.log' % pid, 'w', encoding='utf-8') as fh:
        subprocess.run(['typst', 'compile', '--root', '.', 'papers/%s/main.typ' % pid,
                        'papers/%s/build/main.pdf' % pid], stderr=fh)
    s = io.open('papers/%s/build/compile.log' % pid, encoding='utf-8', errors='replace').read()
    return s.count('error:')

if __name__ == '__main__':
    apply = '--apply' in sys.argv
    ids = [a for a in sys.argv[1:] if re.match(r'^\d{4}\.\d{4,5}$', a)]
    if not ids:
        ids = [os.path.basename(os.path.dirname(p)) for p in sorted(glob.glob('papers/*/main.typ'))]
    total = 0
    for pid in ids:
        main = 'papers/%s/main.typ' % pid
        if not os.path.exists(main):
            continue
        hits = fix(main, apply)
        if not hits:
            continue
        total += sum(hits.values())
        print('%-12s %3d sites  %s' % (pid, sum(hits.values()),
              ', '.join('%s:%d' % kv for kv in sorted(hits.items(), key=lambda kv: -kv[1])[:6])))
        if apply:
            e = build(pid)
            if e:
                shutil.copy2(main + '.preupright', main)
                print('%-12s REVERTED E=%d' % (pid, e))
            else:
                print('%-12s E=0' % pid)
    print('total sites', total)
