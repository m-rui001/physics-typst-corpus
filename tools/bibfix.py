"""Repair structurally broken BibTeX: orphan field blocks and stray trailing fields.

Orphan fields (a field list with no `@type{key,` header) make BibLaTeX abort with
"expected comma". These appear in arXiv-supplied .bib files where an entry was
commented out by hand. We drop them rather than invent a key.
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding='utf-8', errors='backslashreplace')

FIELD = re.compile(r'^\s*[A-Za-z]+\s*=')


def _depth_event(lines):
    d = 0
    for i, l in enumerate(lines):
        if l.lstrip().startswith('%'):
            continue
        for c in l:
            if c == '{':
                d += 1
            elif c == '}':
                d -= 1
            if d < 0:
                return i
    return None


def _revive(lines):
    """Entries left with only commented-out fields were damaged by an earlier
    pass: un-comment those fields."""
    out = list(lines)
    n = len(out)
    i = 0
    revived = 0
    while i < n:
        if out[i].startswith('@'):
            j = i + 1
            body = []
            while j < n and not out[j].startswith('@'):
                body.append(j)
                j += 1
            real = [k for k in body
                    if out[k].strip() and out[k].strip() != '}'
                    and not out[k].lstrip().startswith('%')]
            if not real:
                for k in body:
                    s = out[k].lstrip()
                    if s.startswith('%ORPHAN '):
                        out[k] = s[len('%ORPHAN '):]
                        revived += 1
            i = j
        else:
            i += 1
    return out, revived


def fix(text):
    lines = text.split('\n')
    lines, revived = _revive(lines)
    dropped = 0
    merged = 0
    for _ in range(200):
        i = _depth_event(lines)
        if i is None:
            break
        line = lines[i]
        if line.lstrip().startswith(','):
            # stray field tail belonging to the entry that just closed
            j = i - 1
            while j >= 0 and not lines[j].strip().endswith('}'):
                j -= 1
            if j >= 0:
                body = line.strip().lstrip(',').rstrip()
                assert body.endswith('}'), line
                body = body[:-1].rstrip().rstrip(',')
                lines[j] = '  ' + body + ','
                lines[i] = '}'
                merged += 1
                continue
        # orphan block: walk back to the previous entry end / blank / comment
        j = i - 1
        while j >= 0:
            s = lines[j].strip()
            if s == '' or s == '}' or s.startswith('%') or s.startswith('@'):
                break
            j -= 1
        for k in range(j + 1, i + 1):
            if lines[k].strip() and not lines[k].lstrip().startswith('%'):
                lines[k] = '%ORPHAN ' + lines[k]
                dropped += 1
    # stray closers / lone commas left after an entry already closed
    d = 0
    strays = 0
    kept = []
    for l in lines:
        if l.lstrip().startswith('%'):
            kept.append(l)
            continue
        if d == 0 and l.strip() in ('}', '},', ',', ',}', '},,'):
            kept.append('%STRAY ' + l)
            strays += 1
            continue
        d += l.count('{') - l.count('}')
        kept.append(l)
    lines = kept
    # entries whose closing brace was lost now swallow the next entry
    d = 0
    out = []
    closed = 0
    for l in lines:
        if l.lstrip().startswith('%'):
            out.append(l)
            continue
        if d == 1 and re.match(r'@[A-Za-z]+\s*\{', l):
            out.append('}')
            d = 0
            closed += 1
        for c in l:
            if c == '{':
                d += 1
            elif c == '}':
                d -= 1
        out.append(l)
    if d != 0:
        out.append('}')
        closed += 1
    return '\n'.join(out), dropped + strays + revived, merged, closed


def main():
    for arg in sys.argv[1:]:
        p = Path(arg)
        old = p.read_text(encoding='utf-8', errors='replace')
        new, dropped, merged, closed = fix(old)
        if new != old:
            p.with_suffix(p.suffix + '.bakfix').write_text(old, encoding='utf-8', newline='')
            p.write_text(new, encoding='utf-8', newline='')
        print('%s: %d orphan lines, %d merged tails, %d entries closed'
              % (p, dropped, merged, closed))


if __name__ == '__main__':
    main()
