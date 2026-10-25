r"""Repair unbalanced braces in a refs.bib so Typst's BibLaTeX parser accepts it.

Hand-maintained / scraped .bib files often carry a stray `}` on one field line (e.g.
`keywords = {a,b}}`), which closes the entry early and makes the *whole* file fail with
`failed to parse BibLaTeX (unexpected end of file)`. Each entry is walked independently:
excess closing braces are dropped from the offending line, and an entry that ends
under-closed gets its `}` appended.

Usage: python -X utf8 scripts/bibrepair.py papers/<dir> [...]
"""
import os, re, sys
sys.stdout.reconfigure(encoding="utf-8")


def drop_field(lines, name):
    """Remove `name = {...}` fields, swallowing continuation lines while unbalanced."""
    out, i, n = [], 0, len(lines)
    pat = re.compile(r"^\s*" + name + r"\s*=")
    while i < n:
        if pat.match(lines[i]):
            d = lines[i].count("{") - lines[i].count("}")
            i += 1
            while d > 0 and i < n:
                d += lines[i].count("{") - lines[i].count("}")
                i += 1
            continue
        out.append(lines[i])
        i += 1
    return out


def run(d, drop=()):
    d = os.path.abspath(d)
    bp = os.path.join(d, "refs.bib")
    if not os.path.exists(bp):
        return
    lines = open(bp, encoding="utf-8", errors="replace").read().splitlines()
    orig = list(lines)
    for name in drop:
        lines = drop_field(lines, name)
    depth, fixed, cur = 0, 0, None
    for i, l in enumerate(lines):
        if re.match(r"^\s*@", l):
            if cur is not None and depth > 0:
                lines[i - 1] = lines[i - 1].rstrip() + "}" * depth
                fixed += 1
            cur, depth = i, 0
        if re.match(r"^\s*}}?\s*$", l) and depth == 0:
            lines[i] = ""          # stray closer at entry level
            fixed += 1
            continue
        op, cl = l.count("{"), l.count("}")
        if depth + op - cl < 0:
            keep = op + depth      # allowed closers on this line
            cut = cl - keep
            lines[i] = re.sub(r"\}(?=\s*[,}]*\s*$)", "", l, count=cut) if cut else l
            if lines[i].count("}") != keep:
                lines[i] = l.replace("}", "", cut)
            fixed += 1
            cl = keep
        depth += op - cl
    if cur is not None and depth > 0:
        lines[-1] = lines[-1].rstrip() + "}" * depth
        fixed += 1
    if lines != orig:
        bak = bp + ".prebrace"
        if not os.path.exists(bak):
            open(bak, "w", encoding="utf-8").write("\n".join(orig) + "\n")
        open(bp, "w", encoding="utf-8").write("\n".join(l for l in lines if l != "") + "\n")
    n = len([l for l in lines if l.lstrip().startswith("@")])
    print("%-12s %d entries, %d brace fixes%s" % (
        os.path.basename(d), n, fixed,
        "; dropped " + ",".join(drop) if drop else ""))


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("-")]
    drop = []
    for a in sys.argv[1:]:
        if a.startswith("--drop="):
            drop = a.split("=", 1)[1].split(",")
    for a in args:
        run(a, drop)
