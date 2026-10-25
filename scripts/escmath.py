r"""Convert double-escaped LaTeX math that pandoc left as `\$\\alpha \\geq \\frac12\$`.

When a chunk failed to convert, its math survived into main.typ with every special
character escaped (`\$`, `\\`, `\\_`), which Typst then prints as literal backslashes and
dollars - and, worse, parses as code, producing "unknown variable" errors. Each such span
is un-escaped and re-converted through pandoc, so the equation renders as real Typst math.

Usage: python -X utf8 scripts/escmath.py [papers/...] [--dry]
Writes main.typ.escmathed first.
"""
import glob, os, re, shutil, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import resplice

B = chr(92)


def unesc(s):
    s = re.sub(B * 2 + B + "*", B * 2, s)      # any run of escaped backslashes -> one
    s = s.replace(B + "%", "%").replace(B + "&", "&")
    return s


def esc_dollar_pairs(line):
    """(start, end, inner) for each `\\$ ... \\$` pair, found by scanning, not regex."""
    d = B + "$"
    out, i = [], 0
    while True:
        a = line.find(d, i)
        if a < 0:
            return out
        b = line.find(d, a + 2)
        if b < 0:
            return out
        out.append((a, b + 2, line[a + 2:b]))
        i = b + 2


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    text = open(mp, encoding="utf-8", errors="replace").read()
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    lines = text.split("\n")
    n = 0
    for i, line in enumerate(lines):
        if B + "$" not in line:
            continue
        pairs = esc_dollar_pairs(line)
        if not pairs:
            continue
        out, pos, changed = [], 0, 0
        for a, b, inner in pairs:
            raw = unesc(inner)
            conv = ""
            if re.search(B + r"[a-zA-Z]", raw):
                conv = resplice.clean(resplice.pandoc("$" + raw + "$", work))
                conv = re.sub(r"^\$|\$$", "", conv.strip()).strip()
            out.append(line[pos:a])
            if conv and "$" not in conv and B + "$" not in conv:
                out.append("$" + conv + "$")
            else:
                # pandoc could not handle it (usually an unexpanded macro): at least stop
                # printing literal backslashes, and let the compile loop fix the math.
                out.append("$" + raw.strip() + "$")
            pos = b
            changed += 1
        if changed:
            out.append(line[pos:])
            lines[i] = "".join(out)
            n += changed
    if n and not dry:
        shutil.copyfile(mp, mp + ".escmathed")
        open(mp, "w", encoding="utf-8").write("\n".join(lines))
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
        print("%-14s converted %d escaped spans" % (os.path.basename(a), k))
    print("total", tot)
