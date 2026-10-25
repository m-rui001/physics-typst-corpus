# -*- coding: utf-8 -*-
"""Citation census: does every TeX \\cite key survive into the Typst document?

Norm keys by deleting every non-alphanumeric character, which absorbs the converter's
sanitising (& -> -, . -> -, / -> -). Only keys present in refs.bib are counted, so
@eq:/@fig:/@sec: labels never enter. Papers without #bibliography (literal [n] lists)
are reported as SKIP.
"""
import io, os, re, sys, glob, collections

BS = chr(92)
CITE = re.compile(r'\\(?:text|nocite|parens|brackets|autocite|online|fullcite|footcite|'
                  + r'citeauthor|citeyear|alwaystextcite)?'
                  + r'cite[a-zA-Z]*'
                  + r'(?:\[[^\]\n]*\]){0,2}\{([^{}]+)\}')
AT = re.compile(r'@([A-Za-z0-9_.:\-]+)')
CITEFUNC = re.compile(r'#cite\s*\(\s*<([A-Za-z0-9_.:\\-]+)>')
CITELABEL = re.compile(r'#cite\s*\(\s*label\s*\(\s*"([^"]+)"\s*\)\s*\)')
BIBKEY = re.compile(r'(?m)^\s*@[a-zA-Z]+\s*\{\s*([^,\s]+)\s*,')


def norm(k):
    # Typst resolves keys case-sensitively, so a wrong case would fail the compile gate;
    # lowercasing here only hides nothing and absorbs ADS keys that differ only in case.
    n = re.sub(r'[^A-Za-z0-9]', '', k).lower()
    # same journal keyed as A&A in the TeX and AandA in the rebuilt bib
    n = n.replace('aanda', 'aa')
    return n[3:] if n.startswith('doi') and len(n) > 12 else n


COMMENTENV = re.compile(r'\\begin\{comment\}.*?\\end\{comment\}', re.S)


def strip_macro(s, name):
    """Remove \\name[opt]{...} with balanced braces (the argument contains \\cite{...})."""
    pat = re.compile(r'\\' + name + r'\s*(?:\[[^\]]*\])?\s*\{')
    out, i = [], 0
    while True:
        m = pat.search(s, i)
        if not m:
            out.append(s[i:])
            return ''.join(out)
        out.append(s[i:m.start()])
        j, depth = m.end(), 1
        while j < len(s) and depth:
            if s[j] == '{':
                depth += 1
            elif s[j] == '}':
                depth -= 1
            j += 1
        i = j


def tex_groups(pdir, bib):
    out = []
    for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True):
        s = io.open(f, encoding='utf-8', errors='replace').read()
        s = re.sub(r'(?<!' + BS * 2 + r')' + BS + r'%.*', '', s)
        # the authors' own commented-out drafts still "cite" things
        s = COMMENTENV.sub('', s)
        s = strip_macro(s, 'author')
        # aastex back-matter; 2105.06980's published PDF does not print these blocks
        s = strip_macro(s, 'software')
        s = strip_macro(s, 'facility')
        for m in CITE.finditer(s):
            ks = [k.strip() for k in m.group(1).split(',') if k.strip()]
            ks = [k for k in ks if norm(k) in bib]
            if ks:
                out.append(ks)
    return out


def typst_body(p):
    """Every live Typst file of the paper: an article body and its supplement split the
    citation set, so scanning only main.typ reports the supplement's cites as lost.
    Scratch and probe files are relocated into _work/ rather than deleted, so that tree
    plus build/ are excluded -- a dead probe's @keys otherwise inflate keys/N."""
    parts = []
    for f in sorted(glob.glob(os.path.join(p, '**', '*.typ'), recursive=True)):
        if any(t in os.path.basename(f) for t in ('.pre', '.bak', '.orig')):
            continue
        if any(d in f.replace('\\', '/') for d in ('/_work/', '/build/', '/check/')):
            continue
        parts.append(io.open(f, encoding='utf-8', errors='replace').read())
    return '\n'.join(parts)


def run(pid):
    p = os.path.join('papers', pid)
    mt = os.path.join(p, 'main.typ')
    bf = os.path.join(p, 'refs.bib')
    if not (os.path.isdir(p) and os.path.exists(mt) and os.path.exists(bf)):
        return None
    s = typst_body(p)
    if '#bibliography' not in s:
        return ('SKIP', pid, 'no #bibliography (literal reference list)')
    bib = set()
    for f in glob.glob(os.path.join(p, '**', '*.bib'), recursive=True):
        for m in BIBKEY.finditer(io.open(f, encoding='utf-8', errors='replace').read()):
            bib.add(norm(m.group(1)))
    groups = tex_groups(p, bib)
    tex = collections.Counter()
    for g in groups:
        for k in g:
            tex[norm(k)] += 1
    typ = collections.Counter()
    for m in AT.finditer(s):
        n = norm(m.group(1))
        if n in bib:
            typ[n] += 1
    for m in CITEFUNC.finditer(s):
        n = norm(m.group(1))
        if n in bib:
            typ[n] += 1
    for m in CITELABEL.finditer(s):
        n = norm(m.group(1))
        if n in bib:
            typ[n] += 1
    # a typst @key run of adjacent refs shares one scan; count distinct positions per line
    missing = sorted(set(tex) - set(typ))
    uncited = sorted(set(typ) - set(tex))
    if not tex:
        return ('SKIP', pid, 'no resolvable \\cite keys in src/')
    return ('OK' if not missing else 'LOSS', pid,
            'groups=%d keys=%d/%d missing=%d typst-only=%d uncited_in_bib=%d'
            % (len(groups), len(typ), len(tex), len(missing), len(uncited),
               len(bib - set(tex) - set(typ))), missing)


def main():
    for pid in sorted(os.listdir('papers')):
        r = run(pid)
        if r is None:
            continue
        st, pid, msg = r[0], r[1], r[2]
        print('%-5s %-12s %s' % (st, pid, msg))
        if st == 'LOSS':
            print('        missing:', ', '.join(r[3][:14]))
        sys.stdout.flush()


if __name__ == '__main__':
    main()
