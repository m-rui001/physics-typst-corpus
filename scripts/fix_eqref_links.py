r"""Turn converter-made equation references into real Typst refs.

The converter emitted `#link(<eq:key>)[\[eq:key\]]` (and bare `[\[eq:key\]]`)
wherever the LaTeX had \eqref, so the PDF prints a raw label instead of a number.
Each link target is an existing equation label.

Usage: python -X utf8 scripts/fix_eqref_links.py papers/<id> [...]
"""
import glob, os, re, sys

LINK = re.compile(r'#link\(<eq:([^<>]+)>\)\[\s*\\?\[?eq:[^\]]*?\\?\]?\s*\]')
BARE = re.compile(r'\[\s*\\?\[?\s*eq:([A-Za-z0-9_\\-]+)\s*\\?\]?\s*\]')


def run(d):
    p = os.path.join(d, 'main.typ')
    if not os.path.exists(p):
        return 0
    s = open(p, encoding='utf-8').read()
    labels = set(re.findall(r'<eq:([^<>]+)>', s))
    n = 0
    out, pos = [], 0
    for m in LINK.finditer(s):
        out.append(s[pos:m.start()])
        key = m.group(1)
        if key in labels:
            out.append('@eq:' + key)
            n += 1
        else:
            out.append(m.group(0))
        pos = m.end()
    out.append(s[pos:])
    s = ''.join(out)
    out, pos = [], 0
    for m in BARE.finditer(s):
        out.append(s[pos:m.start()])
        key = m.group(1).replace('\\_', '_')
        if key in labels:
            out.append('@eq:' + key)
            n += 1
        else:
            out.append(m.group(0))
        pos = m.end()
    out.append(s[pos:])
    s = ''.join(out)
    if n:
        open(p, 'w', encoding='utf-8').write(s)
    return n


if __name__ == '__main__':
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    for a in args or sorted(glob.glob('papers/2*')):
        try:
            print('%-14s fixed %d' % (os.path.basename(a.rstrip('/\\')), run(a)))
        except Exception as e:
            print(a, 'skip', type(e).__name__, e)
