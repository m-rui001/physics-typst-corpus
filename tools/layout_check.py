# -*- coding: utf-8 -*-
"""Layout census: does the Typst build use the column model its TeX source asks for?

Two measurements, both needed:
  cols  — intended columns from \\documentclass options / \\twocolumn / \\onecolumngrid,
          compared with the Typst `columns:` setting and `#columns(N, …)` regions;
  gap   — bottom whitespace per rendered page, parsed from low-dpi greyscale PPMs, because a
          single-column body with top-floated figures leaves half-empty pages that no
          content gate can see (2408.13687 shipped that way through a clean compile).

The verdict is a screen: a wide figure or a short final section legitimately ends a column
early, so `gap` is reported as a number to look at, not a defect by itself.
"""
import io, os, re, sys, glob, subprocess, tempfile, shutil

CLASS2 = {'revtex4': 2, 'revtex4-1': 2, 'revtex4-2': 2, 'aap': 2, 'aa': 2, 'mnras': 2,
          'aastex': 2, 'aastex62': 2, 'aastex63': 2, 'aastex631': 2, 'prl': 2, 'pra': 2,
          'nature': 1,  # arXiv accepted-manuscript class: 160mm single column, figure* only 'article': 1, 'elsarticle': 1, 'svjour3': 1, 'iopart': 1,
          'emulateapj': 2, 'apj': 1, 'jcap': 1, 'jhep': 1, 'poS': 1, 'amsart': 1}
DOC = re.compile(r'\\documentclass\s*\[([^\]]*)\]\s*\{([^}]+)\}')

# Pages that are blank by design: the TeX source forces a break there (\newpage \onecolumngrid
# after a full page). They must not count toward the worst-gap statistic, or a real defect can
# hide behind a known-intentional page. Verified by reading the rendered page and the source.
FORCED_BLANK = {
    '2107.13563': [6],   # \newpage \onecolumngrid after the TOC; page 5 is completely full
}


def tex_cols(pdir):
    for f in glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True):
        s = io.open(f, encoding='utf-8', errors='replace').read()
        if '\\documentclass' not in s:
            continue
        m = DOC.search(s)
        if not m:
            continue
        opts = [o.strip() for o in m.group(1).split(',')]
        cls = m.group(2).strip()
        base = re.sub(r'[0-9.\-]+$', '', cls)
        want = CLASS2.get(cls, CLASS2.get(base, 1))
        if 'preprint' in opts or 'onecolumn' in opts or '3p' in opts or '5p' in opts:
            want = 1
        if 'reprint' in opts or 'twocolumn' in opts or '1p' in opts:
            want = 2
        # Body-level switches decide the main text; the last one wins. Switches *after* the
        # bibliography belong to the supplement/back matter (2104.04119 and 2307.16873 both go
        # one-column for their supplementary material and stay two-column for the paper).
        back = re.search(r'\\(?:bibliography\{|begin\{thebibliography\}|printbibliography)', s)
        cut = back.start() if back else len(s)
        for mo in re.finditer(r'\\(onecolumngrid|twocolumngrid|twocolumn|onecolumn)\b', s):
            if mo.start() > cut:
                break
            want = 1 if mo.group(1).startswith('one') else 2
        return want, cls + '[' + ','.join(opts[:4]) + ']'
    return None, None


def typ_cols(pdir):
    """Page-level columns only. `columns:` also appears in `table`/`grid` calls, where it is the
    number of table columns and says nothing about page layout (2104.02565 has an 11-column table
    and was flagged as an 11-column page)."""
    n = 0
    for f in glob.glob(os.path.join(pdir, '*.typ')):
        b = os.path.basename(f)
        if any(t in b for t in ('.pre', '.bak', '.orig')) or b.startswith('_'):
            continue
        s = io.open(f, encoding='utf-8', errors='replace').read()
        for m in re.finditer(r'#set\s+page\s*\(', s):
            depth, j = 0, m.end() - 1
            for j in range(m.end() - 1, len(s)):
                if s[j] == '(':
                    depth += 1
                elif s[j] == ')':
                    depth -= 1
                    if depth == 0:
                        break
            for c in re.finditer(r'columns\s*:\s*([0-9]+)', s[m.end():j]):
                n = max(n, int(c.group(1)))
        for m in re.finditer(r'#columns\s*\(\s*([0-9]+)', s):
            n = max(n, int(m.group(1)))
    return n


def gaps(pdf, pages=None):
    """Bottom whitespace ratio per page, from 30-dpi greyscale rasters."""
    tmp = tempfile.mkdtemp(prefix='lay')
    try:
        subprocess.run(['pdftoppm', '-gray', '-r', '30', pdf, os.path.join(tmp, 'p')],
                       check=False, capture_output=True)
        out = []
        for f in sorted(glob.glob(os.path.join(tmp, 'p-*.pgm')))[:pages or 9999]:
            data = io.open(f, 'rb').read()
            # P5\nW H\n255\n<raster>
            parts = data.split(b'\n', 3)
            w, h = [int(x) for x in parts[1].split()]
            px = parts[3]
            last = 0
            for y in range(h):
                row = px[y * w:(y + 1) * w]
                if min(row) < 140:
                    last = y
            out.append(1.0 - (last + 1) / h)
        return out
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def main():
    rows = []
    for pid in sorted(os.listdir('papers')):
        pdir = os.path.join('papers', pid)
        if not os.path.exists(os.path.join(pdir, 'main.typ')):
            continue
        want, cls = tex_cols(pdir)
        got = typ_cols(pdir)
        pdf = os.path.join(pdir, 'build', 'main.pdf')
        g = gaps(pdf) if os.path.exists(pdf) else []
        skip = set(FORCED_BLANK.get(pid, ()))
        mid = [(i + 1, v) for i, v in enumerate(g[:-1]) if (i + 1) not in skip]
        worst = max((v for _, v in mid), default=0.0)
        nearblank = sum(1 for _, v in mid if v > 0.7)
        verdict = '?'
        if want is not None:
            verdict = 'OK' if (want == 1 and got <= 1) or (want >= 2 and got >= 2) else 'MISMATCH'
        rows.append((verdict, pid, want, got, cls, len(g), worst, nearblank))
    print('%-9s %-12s %-4s %-4s %-5s %-5s %-5s %s' % ('verdict', 'paper', 'tex', 'typ', 'pages', 'gap', 'blank', 'class'))
    for v, pid, want, got, cls, np, worst, nb in sorted(rows):
        print('%-9s %-12s %-4s %-4s %-5d %-5.2f %-5d %s' % (v, pid, want, got, np, worst, nb, cls))
    bad = [r for r in rows if r[0] == 'MISMATCH']
    print('\n%d mismatch, %d checked' % (len(bad), len(rows)))


if __name__ == '__main__':
    main()
