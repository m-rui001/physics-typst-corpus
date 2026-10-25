r"""Convert multi-line double-escaped LaTeX display math left by pandoc.

pandoc failed on some whole paragraphs; the display equations inside them reached
main.typ with every character escaped (`\$\$\\begin{equation} ... \\end{equation}\$\$`).
escmath.py only handles single-line spans, so those blocks still print raw TeX.
This script pairs `\$` markers across newlines, unescapes, and re-converts with pandoc.

Usage: python -X utf8 scripts/escmath2.py papers/<id> [...] [--dry]
"""
import glob, os, re, shutil, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import resplice

B = chr(92)


def unesc(s):
    s = s.replace(B * 2, B)                    # one escape layer: `\\` -> `\`
    s = re.sub(B + B + r'''([_%&#{}"'\[\]~^])''', r"\1", s)
    return s


ENV = re.compile(r"^[ \t]*\\begin\{(equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?)\}")
ENVEND = re.compile(r"\\end\{(equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?)\}[ \t]*$")


def textify(content):
    """`"if \\rho follows"` -> `\\text{if } \\rho \\text{ follows}` (pandoc rejects
    macros inside \\text)."""
    parts = [p for p in re.split(r"(\\(?:[A-Za-z]+))", content) if p]
    if not any(p.startswith("\\") for p in parts):
        return r"\text{" + content + "}"
    return " ".join(p if p.startswith("\\") else r"\text{" + p + "}" for p in parts)


def convert(raw, work):
    raw = ENV.sub(r"\\begin{aligned}", raw)
    raw = ENVEND.sub(r"\\end{aligned}", raw)
    raw = re.sub(r"\\label\{[^}]*\}", "", raw)
    # converter residue: \text{th} was escaped to {"th"} or bare "th"; pandoc's math reader
    # rejects a double quote inside math, so put the text command back
    raw = re.sub(r'\{"([^{}"]*)"\}', r"{\\text{\1}}", raw)
    raw = re.sub(r'"([^"{}]*)"', lambda m: textify(m.group(1)), raw)
    # packages define these; pandoc's math reader does not know them
    raw = re.sub(r"\\openone(?![A-Za-z])", r"\\mathbb{1}", raw)
    raw = re.sub(r"\\id(?![A-Za-z])", r"\\mathbb{1}", raw)
    # `_\*` (star subscript) is invalid TeX math; the source means a plain asterisk
    raw = raw.replace("\\*", "*")
    if "\\\\" not in raw and "&" in raw:
        raw = r"\begin{aligned}" + raw + r"\end{aligned}"
    out = resplice.clean(resplice.pandoc("$" + raw + "$", work))
    out = out.strip()
    if out.startswith("$"):
        out = out[1:]
    if out.endswith("$"):
        out = out[:-1]
    return out.strip()


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    text = open(mp, encoding="utf-8", errors="replace").read()
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    dmark = B + "$" + B + "$"
    n = 0
    out, pos = [], 0
    while True:
        a = text.find(dmark, pos)
        if a < 0:
            break
        b = text.find(dmark, a + len(dmark))
        if b < 0:
            break
        inner = text[a + len(dmark):b]
        if B + "begin{" not in inner and B * 2 + "begin{" not in inner:
            out.append(text[pos:b + len(dmark)])
            pos = b + len(dmark)
            continue
        raw = unesc(inner)
        conv = convert(raw, work)
        if conv and "$" not in conv and not re.search(r"[^\x00-\x7f]{0,0}" + B + "[a-zA-Z]", conv):
            out.append(text[pos:a])
            out.append("$\n" + conv + "\n$")
            n += 1
        else:
            out.append(text[pos:b + 2])
        pos = b + 2
    out.append(text[pos:])
    if n and not dry:
        shutil.copyfile(mp, mp + ".escmath2")
        open(mp, "w", encoding="utf-8").write("".join(out))
    return n


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
        print("%-14s converted %d escaped blocks" % (os.path.basename(a), k))
    print("total", tot)
