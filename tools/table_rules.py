import sys, re, shutil
from pathlib import Path

BS = chr(92)

def match_close(s, i):
    open_c = s[i]
    close_c = {'(': ')', '[': ']', '{': '}'}[open_c]
    d = 0
    k = i
    while k < len(s):
        c = s[k]
        if c == BS:
            k += 2
            continue
        if c == '"':
            k += 1
            while k < len(s) and s[k] != '"':
                k += 2 if s[k] == BS else 1
            k += 1
            continue
        if c == open_c:
            d += 1
        elif c == close_c:
            d -= 1
            if d == 0:
                return k
        k += 1
    raise ValueError('unbalanced at %d' % i)

def split_items(inner):
    items = []
    d = 0
    start = 0
    k = 0
    while k < len(inner):
        c = inner[k]
        if c == BS:
            k += 2
            continue
        if c == '"':
            k += 1
            while k < len(inner) and inner[k] != '"':
                k += 2 if inner[k] == BS else 1
            k += 1
            continue
        if c in '([{':
            d += 1
        elif c in ')]}':
            d -= 1
        elif c == ',' and d == 0:
            items.append((start, k, inner[start:k]))
            start = k + 1
        k += 1
    if inner[start:].strip():
        items.append((start, len(inner), inner[start:]))
    return items

def colspan_of(item):
    m = re.search(r'colspan\s*:\s*(\d+)', item)
    return int(m.group(1)) if m else 1

def is_rule(item):
    return re.match(r'\s*table\.(hline|vline)\s*\(', item) is not None

def is_named(item):
    return re.match(r'\s*[A-Za-z_][A-Za-z0-9_-]*\s*:', item) is not None and not item.lstrip().startswith('table.')

def cell_empty(item):
    return item.strip() in ('[]', '[ ]')

def bar_positions(spec):
    """Return (ncol, xs) where xs are vertical-rule x indices in the TeX column spec."""
    s = spec
    # drop @{...}, >{...}, <{...} decorations
    s = re.sub(r'[@<>]\{[^{}]*\}', '', s)
    cols = 0
    xs = []
    k = 0
    while k < len(s):
        c = s[k]
        if c in 'lcrX':
            cols += 1
        elif c in 'pmb':
            cols += 1
            if k + 1 < len(s) and s[k+1] == '{':
                k = match_close(s, k+1)
        elif c == '|':
            xs.append(cols)
        elif c == '*':
            m = re.match(r'\*\{(\d+)\}', s[k:])
            if m:
                n = int(m.group(1))
                k = match_close(s, k+1)
                # spec inside braces counts n times
                inner_spec = s[k-len(m.group(0))+len(m.group(0))-2:]
                cols += n
        k += 1
    xs = sorted(set(x for x in xs if 0 <= x <= cols))
    return cols, xs

def transform_table(inner, add_stroke=True, vlines=None):
    items = split_items(inner)
    ncol = None
    content = []
    for i, (a, b, t) in enumerate(items):
        m = re.match(r'\s*columns\s*:\s*(\d+)', t)
        if m:
            ncol = int(m.group(1))
        if not is_named(t):
            content.append((i, a, b, t))
    if ncol is None or not content:
        return None
    first = content[0]
    last = content[-1]
    inserts = []
    if not is_rule(first[3]):
        inserts.append((first[1], '\n    table.hline(stroke: 0.8pt),'))
    if vlines:
        have = any('table.vline' in t for _, _, _, t in content)
        if not have:
            txt = '\n    ' + '\n    '.join(
                'table.vline(x: %d, stroke: 0.4pt),' % x for x in vlines)
            inserts.append((first[1], txt))
    has_header = any('table.header' in t for _, _, _, t in content)
    if has_header:
        hdr_idx = next(i for i, it in enumerate(content) if 'table.header' in it[3])
        nxt = content[hdr_idx+1] if hdr_idx+1 < len(content) else None
        if nxt is None or not is_rule(nxt[3]):
            at = content[hdr_idx]
            inserts.append((at[2], ',\n    table.hline(stroke: 0.5pt)'))
    else:
        rows = []
        acc = 0; empties = False
        for (i, a, b, t) in content:
            if is_rule(t):
                continue
            if acc == 0:
                empties = False
            if cell_empty(t):
                empties = True
            acc += colspan_of(t)
            if acc >= ncol:
                rows.append((b, empties))
                acc = 0
            if len(rows) >= 3:
                break
        if rows:
            hrows = 1
            while hrows < len(rows) and rows[hrows-1][1]:
                hrows += 1
            if not any(is_rule(t) for _, _, _, t in content[:2]):
                inserts.append((rows[hrows-1][0], ',\n    table.hline(stroke: 0.5pt)'))
    if not is_rule(last[3]):
        cut = last
        for (i, a, b, t) in reversed(content):
            if is_rule(t):
                continue
            if colspan_of(t) < ncol:
                cut = (i, a, b, t)
                break
        inserts.append((cut[2], ',\n    table.hline(stroke: 0.8pt)'))
    out = inner
    for pos, txt in sorted(inserts, key=lambda x: -x[0]):
        out = out[:pos] + txt + out[pos:]
    return out

def tex_label_specs(src_dir):
    """Map normalized \\label names to tabular column specs."""
    out = {}
    for tx in sorted(Path(src_dir).glob('*.tex')):
        s = tx.read_text(encoding='utf-8', errors='replace')
        for m in re.finditer(re.escape(BS + 'begin{tabular') + r'\*?\}\s*(\[[^\]]*\])?\s*\{', s):
            j = m.end(); dd = 1; k = j
            while k < len(s) and dd:
                if s[k] == '{': dd += 1
                elif s[k] == '}': dd -= 1
                k += 1
            spec = s[j:k-1]
            tail = s[k:k+1600]
            lm = re.search(re.escape(BS + 'label{') + r'([^{}]+)\}', tail)
            if not lm:
                continue
            key = lm.group(1).strip().lower()
            key = re.sub(r'^(tab|table)[:-]', '', key)
            out[key] = spec
    return out

def typ_label(typ, close):
    m = re.search(r'\n\s*<([A-Za-z][^<>\n]{1,60})>\s*\n', typ[close+1:close+1500])
    if not m:
        return None
    key = m.group(1).strip().lower()
    return re.sub(r'^(tab|table)[:-]', '', key)

def process_typ(typ, labelmap, paper_has_bars, vlines_only=False):
    changed = 0
    out = []
    i = 0
    while True:
        j = typ.find('#table(', i)
        if j < 0:
            out.append(typ[i:])
            break
        close = match_close(typ, j + len('#table'))
        inner = typ[j+len('#table('):close]
        if 'stroke: none' in inner:
            out.append(typ[i:close+1]); i = close + 1; continue
        if re.search(r'\bstroke\s*:', inner):
            out.append(typ[i:close+1]); i = close + 1; continue
        label = typ_label(typ, close)
        spec = labelmap.get(label) if label else None
        xs = None
        if spec is not None:
            ncol_spec, pos = bar_positions(spec)
            if pos:
                xs = pos
        elif paper_has_bars:
            # unknown label in a paper that uses vertical rules: leave untouched
            out.append(typ[i:close+1]); i = close + 1; continue
        if vlines_only:
            if xs and 'table.vline' not in inner:
                first = next(((a, b, t) for (a, b, t) in split_items(inner) if not is_named(t)), None)
                if first:
                    txt = '\n    ' + '\n    '.join('table.vline(x: %d, stroke: 0.4pt),' % x for x in xs)
                    new_inner = inner[:first[0]] + txt + inner[first[0]:]
                    out.append(typ[i:j+len('#table(')])
                    out.append(new_inner)
                    out.append(')')
                    changed += 1
                    i = close + 1
                    continue
            out.append(typ[i:close+1]); i = close + 1; continue
        new_inner = transform_table(inner, vlines=xs)
        if new_inner is not None and new_inner != inner:
            out.append(typ[i:j+len('#table(')])
            out.append('\n    stroke: none,')
            out.append(new_inner)
            out.append(')')
            changed += 1
        else:
            out.append(typ[i:close+1])
        i = close + 1
    return ''.join(out), changed

def main():
    p = Path(sys.argv[1])
    apply = '--apply' in sys.argv
    vlines_only = '--vlines-only' in sys.argv
    src = p.parent / 'src'
    labelmap = tex_label_specs(src) if src.is_dir() else {}
    s = p.read_text(encoding='utf-8')
    paper_has_bars = any(bar_positions(v)[1] for v in labelmap.values())
    new, n = process_typ(s, labelmap, paper_has_bars, vlines_only)
    print('tables changed:', n, 'labels:', len(labelmap), 'paper_has_bars:', paper_has_bars)
    if apply and n:
        shutil.copy2(p, str(p) + '.bak_tbl')
        p.write_text(new, encoding='utf-8')

if __name__ == '__main__':
    main()
