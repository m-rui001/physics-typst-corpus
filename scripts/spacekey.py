"""Sanitise label/citation keys that contain spaces or other illegal characters.

Pandoc keeps `\label{subsec: statistics of data}` verbatim, and Typst then reports
`label `label("subsec: statistics of data")` does not exist in the document` — keys may
only contain [A-Za-z0-9_.:-]. Spaces become '-', and every reference to the key is
rewritten the same way so cross-references keep working.
Usage: python -X utf8 scripts/spacekey.py papers/<dir> [...]
"""
import os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

OK = re.compile(r"[A-Za-z0-9_.:\-]+$")
FORMS = [
    re.compile(r'label\(\s*"([^"]*)"\s*\)'),
    re.compile(r"<([^<>\s][^<>]*)>"),
]


def san(k):
    k = re.sub(r"[^A-Za-z0-9_.:\-]+", "-", k.strip()).strip("-")
    return k


def math_spans(s):
    """Character ranges that sit inside `$...$`, where '<' and '>' are operators."""
    spans, start = [], None
    i = 0
    while i < len(s):
        if s[i] == "$" and (i == 0 or s[i - 1] != "\\"):
            if start is None:
                start = i + 1
            else:
                spans.append((start, i))
                start = None
        i += 1
    if start is not None:
        spans.append((start, len(s)))
    return spans


def run(d):
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        return
    s = open(f, encoding="utf-8", errors="replace").read()
    spans = math_spans(s)
    keys = set()
    for rx in FORMS:
        for m in rx.finditer(s):
            if any(a <= m.start() < b for a, b in spans):
                continue
            k = m.group(1)
            if k and not OK.fullmatch(k) and len(k) < 90 and "\n" not in k:
                keys.add(k)
    n = 0
    for k in sorted(keys, key=len, reverse=True):
        t = san(k)
        if not t or t == k:
            continue
        new, c = re.subn(r'(?<![\\A-Za-z0-9_.:@<-])' + re.escape(k), t, s)
        if c:
            s = new
            n += c
    if n:
        open(f, "w", encoding="utf-8").write(s)
    print(os.path.basename(d), "rewrote", n, "key occurrences")


if __name__ == "__main__":
    for a in sys.argv[1:]:
        run(os.path.abspath(a))
