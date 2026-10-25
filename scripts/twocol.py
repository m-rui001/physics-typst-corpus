"""Match Typst layout to a two-column LaTeX source.

Usage: python -X utf8 scripts/twocol.py papers/<id> [--gutter 0.6cm]

- wraps the body (everything from the first top-level heading) in #columns(2)
- gives figures/tables that were figure*/table* in the LaTeX source
  scope: "parent" so they span both columns
"""
import io
import os
import re
import sys

FLOAT_RE = re.compile(
    r'\\begin\{(figure\*?|table\*?)\}(.*?)\\end\{\1\}', re.S)
LABEL_RE = re.compile(r'\\label\{([^}]*)\}')
IMG_RE = re.compile(r'\\includegraphics(?:\[[^\]]*\])?\{([^}]*)\}')


def norm(stem):
    stem = os.path.splitext(os.path.basename(stem))[0].lower()
    return re.sub(r'[^a-z0-9]', '', stem)


def wide_floats(paper):
    src = os.path.join(paper, 'src')
    labels, images = set(), set()
    for name in sorted(os.listdir(src)):
        if not name.endswith('.tex'):
            continue
        t = io.open(os.path.join(src, name), encoding='utf-8', errors='replace').read()
        for m in FLOAT_RE.finditer(t):
            if not m.group(1).endswith('*'):
                continue
            body = m.group(2)
            for lab in LABEL_RE.findall(body):
                labels.add(lab)
                labels.add(lab.replace(':', '-'))
            for img in IMG_RE.findall(body):
                images.add(norm(img))
    return labels, images


def span_at(t, pos):
    """Add scope: "parent" to the #figure( containing pos, unless present."""
    start = t.rfind('#figure(', 0, pos)
    if start < 0:
        return t
    close = t.find('\n)', pos)
    if close < 0:
        return t
    body = t[start:close]
    if 'scope:' in body:
        return t
    add = ''
    if 'placement:' not in body:
        add += '\n  placement: top,'
    sep = '' if t[close - 1] == ',' else ','
    return t[:close] + sep + add + '\n  scope: "parent"' + t[close:]


def span_by_label(t, lab):
    m = re.search(r'\n\)( <[^>]*%s>)' % re.escape(lab), t)
    if not m:
        return t
    return span_at(t, m.start())


def main():
    paper = sys.argv[1].rstrip('/')
    gutter = '0.6cm'
    if '--gutter' in sys.argv:
        gutter = sys.argv[sys.argv.index('--gutter') + 1]
    path = os.path.join(paper, 'main.typ')
    t = io.open(path, encoding='utf-8').read()
    if '#columns(2' in t:
        print('already two-column')
        return

    labels, images = wide_floats(paper)

    for lab in sorted(labels):
        t = span_by_label(t, lab)
    for m in list(re.finditer(r'image\("imgs/([^"]+)"', t)):
        if norm(m.group(1)) in images:
            t = span_at(t, m.start())

    t = re.sub(r'#block\[\n(#figure\()', r'\1', t)

    if '--anchor' in sys.argv:
        anchor = sys.argv[sys.argv.index('--anchor') + 1]
        pos = t.find(anchor)
        if pos < 0:
            print('anchor not found')
            return
        i = t.find('\n', pos + len(anchor)) + 1
    else:
        m = re.search(r'^= ', t, re.M)
        if not m:
            print('no heading found')
            return
        i = m.start()
    head, body = t[:i], t[i:]
    t = head + '#columns(2, gutter: %s)[\n\n' % gutter + body.rstrip() + '\n\n]\n'
    io.open(path, 'w', encoding='utf-8', newline='\n').write(t)
    print('wide images:', sorted(images))


if __name__ == '__main__':
    main()
