# -*- coding: utf-8 -*-
"""Re-bind citations the converter mis-bound or dropped.

For every TeX \\cite{K} whose key never reaches main.typ, locate the Typst line by the
words immediately before the cite. Then either replace a wrong @token sitting there
(the converter's "nearest label" bug) or insert the missing @K. Dry run by default.

usage: python tools/cite_rebind.py <paperid> [--apply]
"""
import io, os, re, sys, glob, collections
sys.path.insert(0, os.path.dirname(__file__))
from cite_census import norm, CITE, AT, CITEFUNC, BIBKEY, tex_groups

BS = chr(92)
APPLY = '--apply' in sys.argv
IDS = [a for a in sys.argv[1:] if not a.startswith('-')]


def anchor(texline, start):
    """Last few words before the \\cite brace, as a literal search key."""
    pre = re.sub(r'~', ' ', texline[:start])
    pre = re.sub(r'\\[a-zA-Z]+(\[[^\]]*\])?(\{[^{}]*\})?', ' ', pre)
    words = [w for w in pre.split() if re.search(r'[A-Za-z]', w)]
    return ' '.join(w.rstrip('}~') for w in words[-4:])


def slotkey(txt):
    m = re.search(r'<([A-Za-z0-9_.:-]+)>', txt)
    return norm(m.group(1) if m else txt[1:])


SLOT = re.compile(r'(@[A-Za-z0-9_.:\-]+|#cite\s*\(\s*<[A-Za-z0-9_.:\-]+>\s*\))')


def apply_anchor(lines, key, ks, typ, bibmap):
    """Bind every lost key of one anchor to its own citation slot, in TeX order.

    Slots are read from the ORIGINAL line and edits applied right-to-left, so a
    multi-key cite never overwrites the key just inserted for its sibling.
    """
    words = key.split()
    trial, cand = key, []
    for n in (len(words), 3, 2):
        t = ' '.join(w for w in words[-n:] if w not in ('et', 'al.', 'al'))
        if not t:
            continue
        cand = [i for i, ln in enumerate(lines) if t in ln or t in ln.replace('~', ' ')]
        if len(cand) == 1:
            trial, keypos = t, t
            break
    if cand and len(cand) == 1:
        i = cand[0]
    else:
        # author-style cite: "Li et al.~\cite{k}" -> Typst "Li~#emph[et~al.]" with no cite
        surname = next((w for w in words if w[:1].isupper() and len(w) > 3), '')
        emph = re.compile(re.escape(surname) + r'[~\s]*#emph\[et[^\]]*\]', re.I) if surname else None
        alt = [i for i, ln in enumerate(lines) if emph and emph.search(ln)
               and not SLOT.search(ln[emph.search(ln).end():emph.search(ln).end() + 60])]
        if len(alt) == 1:
            i = alt[0]
            cur = lines[i]
            p = emph.search(cur).end()
            for k in ks:
                kk = bibmap.get(norm(k), k)
                cur = cur[:p] + ' @' + kk + cur[p:]
                p += len(' @' + kk)
                print('  EMPH     %-26s line %d  after "%s"' % (k, i + 1, surname))
            lines[i] = cur
            return len(ks)
        for k in ks:
            print('  %s %-26s "%s"' % ('NOANCHOR' if not cand else 'MULTILINE', k, key))
        return 0
    if True:
        cur = lines[i]
    p = cur.find(trial) + len(trial)
    raw = [(m.start(), m.end(), m.group(1)) for m in SLOT.finditer(cur[p:])]
    # a sentence-final '.' is punctuation, not part of the citation key
    slots = [(a, b - 1, t[:-1]) if t.endswith('.') else (a, b, t) for a, b, t in raw]
    edits, n, claimed = [], 0, 0
    for k in ks:
        if claimed >= len(slots):
            pos = slots[-1][1] if slots else p
            edits.append((pos, pos, ' @' + k))
            print('  INSERT   %-26s line %d  after "%s"' % (k, i + 1, key[-30:]))
            n += 1
            continue
        st, en, txt = slots[claimed]
        if slotkey(txt) == norm(k):
            claimed += 1
            continue
        # Re-binding is only safe when the wrong token is cited again elsewhere,
        # so overwriting this slot cannot be the loss of that key.
        if typ[slotkey(txt)] > 1:
            edits.append((p + st, p + en, '@' + k))
            print('  REBIND   %-26s line %d  %s -> @%s' % (k, i + 1, txt, k))
        else:
            edits.append((p + st, p + st, '@' + k + ' '))
            print('  INSERT   %-26s line %d  before %s' % (k, i + 1, txt))
        n += 1
        claimed += 1
    for st, en, rep in sorted(edits, key=lambda e: -e[0]):
        cur = cur[:st] + rep + cur[en:]
    lines[i] = cur
    return n


def process(pid):
    p = os.path.join('papers', pid)
    mt = os.path.join(p, 'main.typ')
    if not os.path.exists(mt):
        return
    s = io.open(mt, encoding='utf-8', errors='replace').read()
    bib = set()
    bibmap = {}
    for f in glob.glob(os.path.join(p, '**', '*.bib'), recursive=True):
        for m in BIBKEY.finditer(io.open(f, encoding='utf-8', errors='replace').read()):
            raw = m.group(1)
            bibmap.setdefault(norm(raw), raw)
    bib = set(bibmap)
    typ = collections.Counter()
    for rx in (AT, CITEFUNC):
        for m in rx.finditer(s):
            n = norm(m.group(1))
            if n in bib:
                typ[n] += 1
    groups = collections.OrderedDict()
    for f in glob.glob(os.path.join(p, 'src', '**', '*.tex'), recursive=True):
        tlines = io.open(f, encoding='utf-8', errors='replace').read().split('\n')
        for tln, texline in enumerate(tlines, 1):
            for m in CITE.finditer(texline):
                ks = [x.strip() for x in m.group(1).split(',') if x.strip()]
                lost = [k for k in ks if norm(k) in bib and norm(k) not in typ]
                if not lost:
                    continue
                groups.setdefault((anchor(texline, m.start()), tln), []).extend(lost)
    lines = s.split('\n')
    done = sum(apply_anchor(lines, key, ks, typ, bibmap) for (key, tln), ks in groups.items())
    nlost = sum(len(ks) for ks in groups.values())
    print('%s: %d lost keys in %d groups, %d edits proposed' % (pid, nlost, len(groups), done))
    if APPLY and done:
        io.open(mt + '.precirebind', 'w', encoding='utf-8', newline=chr(10)).write(s)
        io.open(mt, 'w', encoding='utf-8', newline=chr(10)).write('\n'.join(lines))
        print('  applied (backup .precirebind)')


for pid in IDS:
    process(pid)
