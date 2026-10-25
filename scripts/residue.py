r"""Clean LaTeX escape residue inside Typst math, and delete runs of empty `$` pairs.

Verified corpus classes that make Typst fail or print garbage: `\|`, `\(`, `\)`, `\[`,
`\]`, `\,`, `\;`, `\:`, `\/`, `\ `, `\~`, `\>`, `\<`, `\_`, and the empty-math runs pandoc
leaves behind (`$x$$$$$$$$$$$$$$$$$ y`). Math spans only: prose backslashes are untouched.

Usage: python -X utf8 scripts/residue.py [papers/...] [--dry]
Writes main.typ.residuefixed first.
"""
import glob, os, re, shutil, sys

sys.stdout.reconfigure(encoding="utf-8")

B = chr(92)
MATH = re.compile(r"\$([^$\n]+?)\$")
DROP = re.compile(B * 2 + r"[,;:! ]")                    # thin spaces: become a space
PAREN = re.compile(B * 2 + r"([()\[\]|])")               # escapes: become the bare char
OTHER = re.compile(B * 2 + r"([~<>*&#%])")               # markup specials: become the char


def fix_math(m):
    s = m.group(1)
    s = PAREN.sub(r"\1", s)
    s = DROP.sub(" ", s)
    s = OTHER.sub(r"\1", s)
    s = re.sub(B * 2 + r"_", "_", s)
    s = re.sub(r"  +", " ", s).strip()
    if s[:1] in ("_", "^"):                   # a subscript whose base was eaten
        s = '"" ' + s
    return "$" + s + "$" if s else ""


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    text = open(mp, encoding="utf-8", errors="replace").read()
    n = len(re.findall(r"\${3,}", text))
    # Collapse runs of empty math pairs, keeping one `$` when the run length is odd so the
    # line's dollar parity - and therefore its math balance - is preserved exactly.
    out = re.sub(r"\${3,}", lambda m: "$" * (len(m.group(0)) % 2), text)
    lines = out.split("\n")
    for i, line in enumerate(lines):
        if line.lstrip().startswith("//") or "#" in line[:1]:
            continue
        lines[i] = MATH.sub(fix_math, line)
    res = "\n".join(lines)
    ch = sum(1 for a, b in zip(out.split("\n"), res.split("\n")) if a != b) + n
    if ch and not dry:
        shutil.copyfile(mp, mp + ".residuefixed")
        open(mp, "w", encoding="utf-8").write(res)
    return ch


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv[1:]
    tot = 0
    for a in args or sorted(glob.glob("papers/2*")):
        try:
            k = run(a, dry)
        except Exception as e:
            print(os.path.basename(a), "skip", type(e).__name__, e)
            continue
        tot += k
        if k:
            print("%-14s cleaned %d residue sites" % (os.path.basename(a), k))
    print("total", tot)
