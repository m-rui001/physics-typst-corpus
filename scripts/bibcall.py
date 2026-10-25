r"""Give a paper a working reference list.

Papers converted from arXiv sources sometimes lost their bibliography: either main.typ
has no `#bibliography` call at all (so every `@key` is an unresolved label and the ref
list never prints), or refs.bib is the *whole* upstream database rather than the cited
subset. Typst renders every entry in the file, so the second case needs trimming.

Usage: python -X utf8 scripts/bibcall.py papers/<dir> [--trim]
"""
import os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

ENTRY = re.compile(r"^@(\w+)\s*\{\s*([^,\s]+)\s*,", re.M)


def entries(bib):
    """[(key, start, end)] with end = start of next entry or EOF."""
    spans = [(m.start(), m.group(2)) for m in ENTRY.finditer(bib)]
    out = []
    for i, (a, key) in enumerate(spans):
        b = spans[i + 1][0] if i + 1 < len(spans) else len(bib)
        out.append((key, a, b))
    return out


def run(d, trim=False):
    d = os.path.abspath(d)
    mp, bp = os.path.join(d, "main.typ"), os.path.join(d, "refs.bib")
    if not (os.path.exists(mp) and os.path.exists(bp)):
        print(os.path.basename(d), "missing main.typ or refs.bib")
        return
    body = open(mp, encoding="utf-8", errors="replace").read()
    bib = open(bp, encoding="utf-8", errors="replace").read()
    ents = entries(bib)
    if trim and len(ents) > 200:
        cited = set()
        for m in re.finditer(r"(?<!\\)@([A-Za-z0-9_.:\-]+)", body):
            cited.add(m.group(1))
        keep = [t for t in ents if t[1] in cited]
        # a preamble-only key with no definition would break the run, so never
        # trim down to nothing
        if keep and len(keep) < len(ents):
            open(bp, "w", encoding="utf-8").write(
                "".join(bib[a:b] for _, a, b in keep))
            print("%-12s trimmed refs.bib %d -> %d entries (%d cited)"
                  % (os.path.basename(d), len(ents), len(keep), len(cited)))
    if "#bibliography" in body:
        print("%-12s %d entries, bibliography call present"
              % (os.path.basename(d), len(entries(open(bp, encoding='utf-8', errors='replace').read()))))
        return
    if not entries(open(bp, encoding="utf-8", errors="replace").read()):
        print("%-12s no refs.bib entries; not appending call" % os.path.basename(d))
        return
    if not body.endswith("\n"):
        body += "\n"
    body += '\n#bibliography("refs.bib", style: "ieee")\n'
    open(mp, "w", encoding="utf-8").write(body)
    print("%-12s appended #bibliography call" % os.path.basename(d))


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("-")]
    trim = "--trim" in sys.argv
    for a in args:
        run(a, trim)
