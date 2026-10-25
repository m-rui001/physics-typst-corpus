#!/usr/bin/env python
"""Remove duplicated reference supplements.

The TeX converter kept the literal ``Table~/\\ref{x}`` / ``Sec.~\\ref{x}`` wording
while Typst already prints "Table 1" / "Section 4.2" for ``@x``.  Rewrite each
prefixed label ref as ``Table~#ref(<x>, supplement: none)`` so the literal word
stays and the number comes from the label alone.  Chained refs in the same list
("Secs. 4.1 and 4.2") are converted too.
"""
import re
import sys
from pathlib import Path

PREFIX = (r'Tables?|Figs?\.|Figures?|Figure|Sect\.|Sects\.|Sections?|Sec\.|'
          r'Chapter|Ch\.|Appendix|App\.')
LAB = r'[A-Za-z0-9_:\-]+(?:\.[A-Za-z0-9_:\-]+)*'
FIRST = re.compile(r'(?P<pre>' + PREFIX + r')\s*~?\s*@(?P<lab>' + LAB + r')')
CHAIN = re.compile(r'(\s*(?:,\s*(?:and\s*~?\s*)?|and\s*~?\s*|&\s*|(?:--|–|-)\s*)@)(' + LAB + r')')


def fix_text(s, labels):
    out = []
    pos = 0
    n = 0
    for m in FIRST.finditer(s):
        if m.group('lab') not in labels:
            continue
        out.append(s[pos:m.start()])
        out.append('%s~#ref(<%s>, supplement: none)' % (m.group('pre'), m.group('lab')))
        pos = m.end()
        n += 1
        # extend over chained refs that directly follow the list
        while True:
            cm = CHAIN.match(s, pos)
            if not cm or cm.group(2) not in labels:
                break
            out.append(cm.group(1) + '<%s>' % cm.group(2))
            out[-1] = cm.group(1).replace('@', '#ref(<') + '%s>, supplement: none)' % cm.group(2)
            pos = cm.end()
            n += 1
    out.append(s[pos:])
    return ''.join(out), n


def main():
    for arg in sys.argv[1:]:
        p = Path(arg)
        s = p.read_text(encoding='utf-8')
        labels = set(re.findall(r'<([^<>\s]+)>', s))
        new, n = fix_text(s, labels)
        if new != s:
            p.with_suffix(p.suffix + '.prepref').write_text(s, encoding='utf-8')
            p.write_text(new, encoding='utf-8')
        print('%s: %d refs' % (p.parent.name, n))


if __name__ == '__main__':
    main()
