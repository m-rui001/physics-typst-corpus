"""Re-insert in-text citations dropped by the converter.

For every \\cite in the LaTeX source, take the 40 alphanumeric characters that
precede it (LaTeX commands stripped), locate that run in main.typ (unique match
only), and insert a citation at the end of the match.

Modes:
  numeric - `[n]` using .bbl item order (reference list rebuilt by bbl2typ.py)
  cite    - `@key` / `[@a; @b]` (real refs.bib plus a #bibliography call)
  auto    - cite when main.typ has #bibliography, else numeric

Writes main.typ.cited; never edits main.typ in place.

Usage: python -X utf8 scripts/recite.py papers/<id> [--mode=auto|numeric|cite] [--dry]
"""
import glob
import io
import os
import re
import sys

B = chr(92)
VALID = re.compile(r'^[A-Za-z0-9_.:-]+$')


def norm_map(s):
    buf = []
    idx = []
    for i, c in enumerate(s):
        if c.isalnum():
            buf.append(c.lower())
            idx.append(i)
    return ''.join(buf), idx


def strip_comments(t):
    out = []
    for line in t.split('\n'):
        j = line.find('%')
        while j != -1:
            nb = 0
            k = j - 1
            while k >= 0 and line[k] == B:
                nb += 1
                k -= 1
            if nb % 2 == 0:
                line = line[:j]
                break
            j = line.find('%', j + 1)
        out.append(line)
    return '\n'.join(out)


def detex(s):
    """Rough LaTeX -> plain text for anchor matching."""
    s = re.sub(re.escape(B) + r'(?:ref|eqref|label|cite[a-z]*)\*?(?:\[[^\]]*\])*\{[^}]*\}', '', s)
    s = re.sub(re.escape(B) + r'(?:textbf|textit|emph|text|mathrm|mathbf|cal|hat|vec|upright|textsc|textrm|mbox)\s*', '', s)
    s = s.replace('~', ' ').replace('{', '').replace('}', '')
    s = re.sub(re.escape(B) + r'[A-Za-z]+', ' ', s)
    return re.sub(r'\s+', ' ', s)


def main_tex(src):
    best = None
    for f in glob.glob(os.path.join(src, '**', '*.tex'), recursive=True):
        t = io.open(f, encoding='utf-8', errors='replace').read()
        score = 100 * (B + 'documentclass' in t) + 100 * (B + 'begin{document}' in t) + min(len(t) // 1000, 50)
        if best is None or score > best[0]:
            best = (score, f)
    return best[1]


def bbl_order(src, tex_keys):
    best = None
    for f in glob.glob(os.path.join(src, '**', '*.bbl'), recursive=True):
        t = io.open(f, encoding='utf-8', errors='replace').read()
        keys = re.findall(re.escape(B) + r'bibitem\{([^}]*)\}', t)
        hit = len(set(keys) & tex_keys)
        if best is None or hit > best[0]:
            best = (hit, keys)
    return best[1] if best else []


def run(paper, mode='auto', dry=False):
    paper = os.path.abspath(paper)
    src = os.path.join(paper, 'src')
    body = io.open(os.path.join(paper, 'main.typ'), encoding='utf-8', errors='replace').read()
    tex = strip_comments(io.open(main_tex(src), encoding='utf-8', errors='replace').read())

    if mode == 'auto':
        mode = 'cite' if re.search(r'#bibliography\(', body) else 'numeric'

    cites = []
    for m in re.finditer(re.escape(B) + r'cite[a-z]*\*?(?:\[[^\]]*\])*\{([^}]*)\}', tex):
        keys = [k.strip() for k in m.group(1).split(',') if k.strip()]
        keys = [k for k in keys if VALID.match(k)]
        if not keys:
            continue
        pre = detex(tex[max(0, m.start() - 160):m.start()])
        pc = ''.join(c for c in pre if c.isalnum()).lower()
        if len(pc) < 20:
            continue
        cites.append((pc[-40:], keys, pre[-60:]))

    seen = set()
    uniq = []
    for a, k, p in cites:
        t = (a, tuple(k))
        if t not in seen:
            seen.add(t)
            uniq.append((a, k, p))

    num = {}
    if mode == 'numeric':
        keys = {k for _, ks, _ in uniq for k in ks}
        order = bbl_order(src, keys)
        if not order:
            print('no usable .bbl')
            return False
        num = {k: i + 1 for i, k in enumerate(order)}

    labels = set(re.findall(r'<([A-Za-z0-9_.:-]+)>', body))
    mc, midx = norm_map(body)
    ins = []
    miss = amb = 0
    for a, keys, preview in uniq:
        n = mc.count(a)
        if n == 0:
            miss += 1
            continue
        if n > 1:
            amb += 1
            continue
        q = mc.find(a)
        pos = midx[q + len(a) - 1] + 1

        if mode == 'numeric':
            ns = sorted({num[k] for k in keys if k in num})
            if not ns:
                miss += 1
                continue
            label = '[' + ','.join(str(x) for x in ns) + ']'
        else:
            ks = [k for k in keys if k not in labels]
            if not ks:
                miss += 1
                continue
            label = '@' + ks[0] if len(ks) == 1 else '[@' + '; @'.join(ks) + ']'

        ins.append((pos, label, preview, keys))

    ins.sort()
    out = body
    for pos, label, preview, keys in reversed(ins):
        out = out[:pos] + label + out[pos:]

    if not dry:
        io.open(os.path.join(paper, 'main.typ.cited'), 'w', encoding='utf-8', newline='').write(out)
    print('%s mode=%s cites=%d inserted=%d miss=%d ambiguous=%d' %
          (os.path.basename(paper), mode, len(uniq), len(ins), miss, amb))
    for pos, label, preview, keys in ins[:6]:
        print('  ', label, '|', preview[-48:])
    return True


if __name__ == '__main__':
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    dry = '--dry' in sys.argv
    mode = 'auto'
    for a in sys.argv[1:]:
        if a.startswith('--mode='):
            mode = a.split('=', 1)[1]
    for p in args:
        run(p, mode, dry)
