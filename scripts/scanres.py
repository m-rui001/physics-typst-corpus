r"""Scan converted papers for conversion residue that a compile cannot see.

`typst compile` returning 0 errors only means the file parses. It does not notice a LaTeX
macro left as prose, a `\dagger` split across a chunk boundary, a line containing nothing
but `_`, or a word truncated mid-syllable. This walks every main.typ and counts those
classes per paper so the damage is comparable between papers.

Usage: python -X utf8 scripts/scanres.py papers/<dir> [...]
"""
import os, re, sys
sys.stdout.reconfigure(encoding="utf-8")
B = chr(92)

CHECKS = [
    ("tex-macro",   re.compile(B * 2 + "[a-zA-Z@]+")),          # \frac, \cite, \begin ...
    ("caret-paren", re.compile(r"\^\(")),                        # mangled ^{...}
    ("bare-dagger", re.compile(B * 2 + "dagger|" + B * 2 + r"\|")),  # split \dagger / \|
    ("sub-pipe",    re.compile(r"\|_|_\||\^\w+\|")),             # X^j_|z residue
    ("tilde-dot",   re.compile(r"~\.|\bR\.\s*\.")),              # deleted \cite residue
    ("junk-line",   re.compile(r"^[ \t]*[-_)(\[\].]{1,2}[ \t]*$")),
    ("empty-cite",  re.compile(r"#text\(\[\]\)")),
    ("raw-dollar",  re.compile(r"\$\$")),
]


def run(d):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return
    body = open(mp, encoding="utf-8", errors="replace").read()
    lines = body.splitlines()
    counts = {}
    for name, pat in CHECKS:
        if name == "junk-line":
            counts[name] = sum(1 for l in lines if pat.match(l))
        else:
            counts[name] = len(pat.findall(body))
    tot = sum(counts.values())
    hits = " ".join("%s=%d" % (k, v) for k, v in counts.items() if v)
    print("%-12s lines=%-6d %-4d %s" % (os.path.basename(d), len(lines), tot, hits))


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("-")]
    if not args:
        args = sorted("papers/" + p for p in os.listdir("papers") if os.path.isdir("papers/" + p))
    for a in args:
        run(a)
