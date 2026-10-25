r"""Quality board for the converted corpus: pages, citations, bibliography bloat.

Typst renders *every* entry of a BibTeX file, so a refs.bib that carries the whole
upstream database silently turns a 20-page paper into a 300-page one. This reports the
page count next to the number of cited keys vs. the number of entries actually present,
so bloat and unresolved citations are both visible.

Usage: python -X utf8 scripts/qc.py papers/<dir> [...]
"""
import os, re, sys, glob
import pymupdf
sys.stdout.reconfigure(encoding="utf-8")

CITE = re.compile(r"(?<![\w.])@([A-Za-z0-9_:\-][A-Za-z0-9_.:\-]*)")
# `@fig:x` / `@sec:x` ... are cross-references, not bibliography keys; so is any
# @token matching a <label> defined in the document.
LABEL = re.compile(r"<([A-Za-z0-9_.:\-]+)>")
EMAIL = re.compile(
    r"\.(?:com|edu|org|net|cn|uk|de|fr|jp|au|es|nl|ca|ch|se|cz|il|it|ru|kr|in|br|pl|eu|"
    r"hk|sg|tw|at|dk|fi|no|ie|pt|gr|be|co|ac|gov|mil|int|io)$")
ENT = re.compile(r"^\s*@\w+\s*\{\s*([^,\s]+)", re.M)


def cited_keys(body, labels=()):
    out = set()
    for m in CITE.finditer(body):
        k = m.group(1)
        if k == "preview" or k.rstrip(".:") in labels or k in labels:
            continue
        if EMAIL.search(k.rstrip(".")):
            continue
        out.add(k.rstrip(".:"))
    return out


def run(d):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    bp = os.path.join(d, "refs.bib")
    if not os.path.exists(mp):
        return
    body = open(mp, encoding="utf-8", errors="replace").read()
    labels = set(LABEL.findall(body))
    sup = os.path.join(d, "supplement.typ")
    if os.path.exists(sup):
        s = open(sup, encoding="utf-8", errors="replace").read()
        labels |= set(LABEL.findall(s))
        body += "\n" + s
    cited = cited_keys(body, labels)
    ents = set()
    for bp in sorted(glob.glob(os.path.join(d, "*.bib"))):
        ents |= set(ENT.findall(open(bp, encoding="utf-8", errors="replace").read()))
    pdf = os.path.join(d, "out.pdf")
    if not os.path.exists(pdf):
        pdf = os.path.join(d, "build", "main.pdf")
    pages = "?"
    if os.path.exists(pdf):
        pages = pymupdf.open(pdf).page_count
    missing = sorted(cited - ents)
    dead = len(ents - cited)
    flag = "  <-- BLOAT" if dead > 3 * max(len(cited), 1) and dead > 200 else ""
    print("%-12s pages=%-4s cited=%-5d entries=%-5d unresolved=%-4d uncited=%-5d%s"
          % (os.path.basename(d), pages, len(cited), len(ents), len(missing), dead, flag))
    if missing:
        print("    missing:", ", ".join(missing[:10]))


if __name__ == "__main__":
    for a in sys.argv[1:]:
        run(a)
