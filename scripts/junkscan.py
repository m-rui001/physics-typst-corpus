r"""Report 'wreckage' regions: display equations that shattered into one-token-per-line.

Such a region compiles fine (the stray `$` just opens math that swallows the next
paragraph, which is why a page renders nearly blank), so the compiler cannot find it.
A line is wreckage when it carries no real word: 1-2 characters, or only punctuation and
TeX leftovers. Consecutive wreckage lines (blank lines allowed between) form a region,
which is what a repair pass has to reconstitute from src/.

Usage: python -X utf8 scripts/junkscan.py [papers/...] [--min 3]
"""
import glob, os, re, sys

sys.stdout.reconfigure(encoding="utf-8")

B = chr(92)
PUNCT = re.compile(r"^[^\w\s]{1,6}$")
SHORT = re.compile(r"^(?:" + B + r"[A-Za-z]{0,3}|\d{1,2}|[A-Za-z]{1,2}[" + re.escape("()[]{}^_~$\\,.%&*/+-") + r"]{0,3})$")
WRECK = re.compile(r"^(?:" + B + r"?[$~^_&%#.\-/+=|])$|^\s*$")

# Pandoc gave up on a formula and left the LaTeX in, escaped: `$\\mu= \\partial\_{\\f}m$`,
# `\$\$\\begin{equation}`, `\\frach`. Such a line breaks $-parity and blanks a page.
BS = r"\\{1,2}"
RAW = re.compile(BS + r"\$"
                 + r"|" + BS + r"begin\{"
                 + r"|" + BS + r"(?:frac|dfrac|tfrac|partial|int|sum|prod|mu|nu|ell|BH|QG|lvert|rvert"
                 + r"|langle|rangle|mathcal|mathbb|mathrm|mathit|hat|bar|tilde|vec|leq|leqslant|geq|sim"
                 + r"|approx|cdot|times|infty|alpha|beta|gamma|delta|epsilon|phi|psi|omega|lim)"
                 + r"|" + BS + r"_[A-Za-z{]")


def is_raw(line):
    s = line.strip()
    if not s or len(s) < 4:
        return None
    m = RAW.search(s)
    return m.group(0) if m else None


def is_wreck(line):
    s = line.strip()
    if not s:
        return None
    if PUNCT.match(s) or SHORT.match(s):
        return s
    if len(s) <= 8 and not re.search(r"[A-Za-z]{3}", s) and re.search(r"[$\\^_~|]", s):
        return s
    return None


def dollars(line):
    s = re.sub(r"\\\$", "", line)
    return s.count("$") - 2 * s.count("$$")


def scan(d):
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return None
    lines = open(mp, encoding="utf-8", errors="replace").read().split("\n")
    regions, cur = [], None
    for i, l in enumerate(lines, 1):
        w = is_wreck(l) or is_raw(l)
        if w is not None:
            if cur:
                cur[1] = i
            else:
                cur = [i, i]
        elif l.strip() == "" and cur:
            continue
        else:
            if cur and cur[1] - cur[0] + 1 >= 3:
                regions.append(tuple(cur))
            cur = None
    if cur and cur[1] - cur[0] + 1 >= 3:
        regions.append(tuple(cur))
    return regions, lines


def paragraph_math(text):
    """Lines where a `$` opens math that only closes after a paragraph break.

    That is how a shattered equation swallows the following prose and blanks a page.
    """
    hits = []
    pos = 0
    for m in re.finditer(r"(?<!\\)\$", text):
        if pos % 2:
            continue
        seg = text[m.end():]
        close = seg.find("$")
        if close < 0:
            hits.append((text[:m.start()].count("\n") + 1, "unclosed to EOF"))
            pos += 1
            continue
        if "\n\n" in seg[:close] or re.search(r"\n\s*\n", seg[:close]):
            hits.append((text[:m.start()].count("\n") + 1, "spans a paragraph break"))
            pos += 1
    return hits


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    mins = 3
    for a in sys.argv[1:]:
        if a.startswith("--min"):
            mins = int(a.split("=")[1]) if "=" in a else int(sys.argv[sys.argv.index(a) + 1])
    tot = 0
    for a in args or sorted(glob.glob("papers/2*")):
        r = scan(a)
        if not r:
            continue
        regions, lines = r
        text = "\n".join(lines)
        regions = [x for x in regions if x[1] - x[0] >= mins - 1]
        pmb = paragraph_math(text)
        tot += len(regions)
        print("%-14s regions=%-3d swallowing-$=%-3d %s" % (os.path.basename(a), len(regions),
              len(pmb), " ".join("%d-%d" % x for x in regions[:12])))
        for ln, why in pmb[:8]:
            print("       $@%-5d %s  %s" % (ln, why, lines[ln - 1].strip()[:70]))
    print("total regions", tot)
