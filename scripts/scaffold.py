"""Drop LaTeX-scaffolding residue blocks that pandoc turned into junk paragraphs.

`\begin{minipage}\centering` survives conversion as a block whose lines are the single
word "minipage" followed by the letters c e n t e r on separate lines. Such blocks carry
no content; they just print garbage in the PDF.
Usage: python -X utf8 scripts/scaffold.py papers/...   (default: every paper)
"""
import glob, os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

VOCAB = {
    "minipage", "centering", "vspace", "hspace", "quad", "qquad", "hfill", "hfil",
    "noindent", "raggedright", "raggedleft", "small", "large", "footnotesize",
    "scriptsize", "normalsize", "baselineskip", "arraystretch", "newline", "linebreak",
    "center", "par", "thanks", "address", "affiliation", "and", "renewcommand",
    "providecommand", "newcommand", "setlength", "arrayrulewidth", "tabcolsep",
    "cline", "hline", "multicolumn", "multirow", "textwidth", "linewidth", "columnwidth",
}
SAFE = re.compile(r"^[A-Za-z]{1,14}$")


def junk_block(b):
    lines = [l.strip() for l in b.splitlines() if l.strip()]
    if len(b) > 220:
        return False
    if any(c in b for c in "$#@<>{}[]\\|_"):
        return False
    letters = 0
    for l in lines:
        if not SAFE.match(l):
            return False
        if len(l) > 1 and l.lower() not in VOCAB:
            return False
        letters += len(l)
    return letters <= 14


def run(d):
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        return 0
    s = open(f, encoding="utf-8", errors="replace").read()
    parts = re.split(r"\n\s*\n", s)
    keep = [p for p in parts if not junk_block(p)]
    if len(keep) == len(parts):
        return 0
    open(f, "w", encoding="utf-8").write("\n\n".join(keep))
    return len(parts) - len(keep)


if __name__ == "__main__":
    args = sys.argv[1:] or sorted(glob.glob("papers/2*"))
    tot = 0
    for a in args:
        n = run(a)
        tot += n
        if n:
            print(a, "dropped", n, "junk blocks")
    print("total", tot)
