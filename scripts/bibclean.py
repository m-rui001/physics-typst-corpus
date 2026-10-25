"""Drop empty/blank-valued BibLaTeX fields, which Typst's parser rejects.

`year = {},` and `pages = {},` raise "failed to parse BibLaTeX (wrong number of digits)"
and abort the whole bibliography, so every citation in the paper disappears.
Usage: python -X utf8 scripts/bibclean.py papers/...   (or a refs.bib path)
"""
import glob, re, sys
sys.stdout.reconfigure(encoding="utf-8")

FIELD = re.compile(r"^\s*[A-Za-z]+\s*=\s*\{\s*\},?\s*$", re.M)
TRAIL = re.compile(r",\s*\n\s*}", re.M)


def clean(path):
    s = open(path, encoding="utf-8", errors="replace").read()
    n = len(FIELD.findall(s))
    if n:
        s = FIELD.sub("", s)
        s = TRAIL.sub("\n}", s)
        open(path, "w", encoding="utf-8").write(s)
    return n


def target(a):
    if a.endswith(".bib"):
        return [a]
    f = glob.glob(a.rstrip("/\\") + os_sep + "refs.bib")
    return f


os_sep = "/"


if __name__ == "__main__":
    for a in sys.argv[1:]:
        for f in target(a):
            print(f, "removed", clean(f))
