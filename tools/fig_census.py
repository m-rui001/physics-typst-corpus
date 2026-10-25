# -*- coding: utf-8 -*-
"""Figure census: every live \\includegraphics in the TeX should end up in the Typst,
either as an image() with the same basename or as a CeTZ redraw with the same caption.

Reports REAL missing floats with the float's caption head, so a dropped float (pandoc
chokes on \\subfloat or on a nested brace group) is visible without reading every page.

usage: python tools/fig_census.py <paper_id|dir> [-v]
"""
import difflib, glob, io, os, re, sys

BS = chr(92)
verbose = '-v' in sys.argv
args = [a for a in sys.argv[1:] if a != '-v']
arg = args[0]
pdir = arg if os.path.isdir(arg) else os.path.join('papers', arg)


def read(f):
    return io.open(f, encoding='utf-8', errors='replace').read()


def norm(s):
    return re.sub(r'[^a-z0-9]+', ' ', s.lower()).strip()


def balanced(s, i, open_ch='{', close_ch='}'):
    """s[i] == open_ch; return (body, index after close) or (None, i)."""
    depth, j = 0, i
    while j < len(s):
        ch = s[j]
        if ch == BS:
            j += 2
            continue
        if ch == open_ch:
            depth += 1
        elif ch == close_ch:
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
        j += 1
    return None, i


# ---------------------------------------------------------------- source side
tex = ''
texdir = ''
for f in sorted(glob.glob(os.path.join(pdir, 'src', '**', '*.tex'), recursive=True)):
    t = read(f)
    if BS + 'documentclass' in t:
        tex = t
        texdir = os.path.dirname(f)
        break


def expand(s, base, depth=0):
    if depth > 6:
        return s

    def rep(m):
        name = m.group(1).strip()
        cand = [os.path.join(base, name), os.path.join(base, name + '.tex'),
                os.path.join(texdir, name), os.path.join(texdir, name + '.tex')]
        for c in cand:
            if os.path.isfile(c):
                return expand(read(c), os.path.dirname(c), depth + 1)
        return m.group(0)
    return re.sub(BS * 2 + r'(?:input|include)\s*\{([^}]+)\}', rep, s)


tex = expand(tex, texdir)
# drop commented-out material: line comments and comment/iffalse environments
tex = '\n'.join(re.sub(r'(?<!' + BS * 2 + r')' + BS + r'%.*', '', ln) for ln in tex.split('\n'))
tex = re.sub(BS*2 + r'begin\{comment\}.*?' + BS*2 + r'end\{comment\}', ' ', tex, flags=re.S)
tex = re.sub(BS*2 + r'iffalse.*?' + BS*2 + r'fi', ' ', tex, flags=re.S)

MACRO = re.compile(BS * 2 + r'(?:re)?newcommand|' + BS * 2 + r'def(?![A-Za-z])')
INC = re.compile(BS * 2 + r'includegraphics(\[[^\]]*\])?\{([^}]+)\}')


def is_inline(m):
    """Inline icons in prose (a tiny image inside a formula) are not floats: they have
    valign=c or a width well under a third of the column, and no caption of their own."""
    opt = m.group(1) or ''
    if 'valign' in opt:
        return True
    w = re.search(r'width\s*=\s*([\d.]*)\s*(?:' + BS + r'?textwidth|' + BS + r'?columnwidth)', opt)
    if w:
        try:
            return float(w.group(1) or 1) < 0.35
        except ValueError:
            return False
    return False


def in_macro(pos):
    back = tex[max(0, pos - 160):pos]
    return bool(MACRO.search(back))
CAP = re.compile(BS*2 + r'caption\s*\{')
# float ranges: give each include the caption of the float that encloses it
ranges = []
for m in re.finditer(BS*2 + r'begin\{(figure\*?)\}', tex):
    end = tex.find(BS + 'end{' + m.group(1) + '}', m.end())
    if end < 0:
        end = len(tex)
    body = tex[m.end():end]
    cm = CAP.search(body)
    cap = ''
    if cm:
        cap, _ = balanced(body, cm.end() - 1, '{', '}')
        cap = cap or ''
    ranges.append((m.start(), end, cap))


def cap_at(pos):
    for st, en, cap in ranges:
        if st <= pos <= en:
            return cap
    return ''

# ---------------------------------------------------------------- typst side
typ = ''
for f in glob.glob(os.path.join(pdir, '*.typ')):
    b = os.path.basename(f)
    if any(x in b for x in ('.pre', '.bak', '.orig')) or b.startswith('_'):
        continue
    typ += read(f)
if not typ:
    print('%s: no .typ (not converted), skipped' % pdir)
    sys.exit(0)
def stem_of(u):
    st = re.sub(r'\W+', '_', os.path.basename(u).rsplit('.', 1)[0]).lower()
    return re.sub(r'_(figr|crop|wired|annotated)$', '', st)


used = {stem_of(u) for u in re.findall(r'image\(\s*"([^"]+)"', typ)}
canv = len(re.findall(r'cetz\.canvas|\.cetz\.typ', typ))

# captions: every `caption:` followed by a bracket group (balanced, so nested #emph[...]
# and math brackets are fine); parsing #figure( ... ) by parens is unreliable because
# Typst content contains unbalanced-looking parens inside strings.
typcaps = []
for cm in re.finditer(r'caption\s*:', typ):
    k = typ.find('[', cm.end())
    if k < 0 or k > cm.end() + 40:
        continue
    cap, _ = balanced(typ, k, '[', ']')
    if cap:
        typcaps.append(norm(cap))

miss, ok_ce = [], 0
seen = set()
for m in INC.finditer(tex):
    path = m.group(2)
    if in_macro(m.start()) or is_inline(m):
        continue
    cap = cap_at(m.start())
    stem = stem_of(path)
    if stem in used or stem.lower() in seen:
        continue
    seen.add(stem.lower())
    n = norm(cap)
    best = 0.0
    if len(n) > 15:
        for tc in typcaps:
            r = difflib.SequenceMatcher(None, n[:300], tc[:300], autojunk=False).ratio()
            best = max(best, r)
    if best >= 0.72:
        ok_ce += 1
        if verbose:
            print('  CETZ-redrawn %-36s r=%.2f  %s' % (path, best, cap[:60]))
    else:
        miss.append((path, cap[:110] if cap else '(no caption)'))

print('%s: %d includegraphics, %d image() refs, %d CeTZ canvases, '
      '%d redrawn(CeTZ caption match), %d MISSING'
      % (pdir, len(INC.findall(tex)), len(used), canv, ok_ce, len(miss)))
for p, c in miss:
    print('  MISSING %-40s %s' % (p, c))
