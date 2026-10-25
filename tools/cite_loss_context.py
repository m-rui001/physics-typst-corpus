# -*- coding: utf-8 -*-
"""For each paper, list citations that exist in src/*.tex but never reach main.typ,
with the TeX line that carried them. Output is the worklist for prose/citation repair.
"""
import io, os, re, sys, glob, collections
sys.path.insert(0, os.path.dirname(__file__))
from cite_census import norm, CITE, AT, CITEFUNC, BIBKEY, tex_groups  # noqa: E402


def contexts(pdir, wanted, bib):
    hits = []
    for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True):
        lines = io.open(f, encoding='utf-8', errors='replace').read().split('\n')
        for ln, s in enumerate(lines, 1):
            if re.sub(r'(?<!\\)%.*', '', s).strip() == '':
                continue
            for m in CITE.finditer(s):
                for k in [x.strip() for x in m.group(1).split(',')]:
                    if norm(k) in wanted:
                        hits.append((norm(k), os.path.relpath(f, pdir), ln, s.strip()[:400]))
    return hits


def main():
    for pid in sorted(os.listdir('papers')):
        p = os.path.join('papers', pid)
        mt, bf = os.path.join(p, 'main.typ'), os.path.join(p, 'refs.bib')
        if not (os.path.isdir(p) and os.path.exists(mt) and os.path.exists(bf)):
            continue
        s = io.open(mt, encoding='utf-8', errors='replace').read()
        if '#bibliography' not in s:
            continue
        bib = set()
        for f in glob.glob(os.path.join(p, '**', '*.bib'), recursive=True):
            for m in BIBKEY.finditer(io.open(f, encoding='utf-8', errors='replace').read()):
                bib.add(norm(m.group(1)))
        groups = tex_groups(p, bib)
        texc = collections.Counter()
        for g in groups:
            for k in g:
                texc[norm(k)] += 1
        typc = collections.Counter()
        for rx in (AT, CITEFUNC):
            for m in rx.finditer(s):
                n = norm(m.group(1))
                if n in bib:
                    typc[n] += 1
        missing = {k for k in texc if k not in typc}
        if not missing:
            continue
        print('#### %s  (%d keys lost)' % (pid, len(missing)))
        seen = set()
        for k, f, ln, ctx in contexts(p, missing, bib):
            sig = (f, ln)
            if sig in seen:
                continue
            seen.add(sig)
            print('  %-28s %s:%d  %s' % (k, f, ln, ctx))
        sys.stdout.flush()


main()
