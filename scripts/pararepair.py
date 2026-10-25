r"""Re-convert damaged paragraphs from the author's LaTeX, keeping only what compiles better.

A paragraph that Typst cannot parse (trapped prose inside `$…$`, escaped LaTeX left in the
line, a reference swallowed into a label) is not repairable by moving delimiters around. Its
intact LaTeX paragraph is found in src/ by matching the sentence's own leading words,
sanitized so pandoc can read it, converted, and swapped in - but only if the paper then
reports fewer errors. Every rejected candidate is rolled back, so this stage can never make
a file worse than it found it.

Sanitizing does two things the first pandoc pass in this repo never did: it drops the
author's macros that no converter can know (`\comr{...}` comments, `\label{...}`) and it
replaces any *undefined* control sequence by its plain letters, which is what the reader of
the Typst file expects to see.

Usage: python -X utf8 scripts/pararepair.py papers/2102.01111 [--dry] [--limit N]
"""
import glob, io, os, re, shutil, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import parascan, resplice

B = chr(92)
WORD = re.compile(r"[A-Za-z][A-Za-z'-]{4,}")
DROPENV = re.compile(B * 2 + r"(?:comr|note|TODO|todo|jl|mr|bx|rev|comment)\b(?:\s*\{(?:[^{}]|\{[^{}]*\})*\})?")
UNKNOWN = re.compile(B * 2 + r"([A-Za-z]{2,})")
KNOWN = set(r"""frac dfrac text rm bf mathrm mathbf mathit mathcal mathbb hat bar tilde vec sum int
partial infty alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi pi rho sigma
tau upsilon phi chi psi omega Gamma Delta Theta Lambda Xi Pi Sigma Upsilon Phi Psi Omega varphi
leq geq neq sim simeq approx propto subset cup cap in notin times cdot pm mp quad qquad begin end
left right bigg big Big bigl bigr bracket equiv approx label ref eqref cite footnote section
subsection subsubsection paragraph caption figure table item includegraphics underline
overline operatorname langle rangle circ oplus otimes to rightarrow rightarrow leftarrow
longmapsto prime dagger bullet dot ldots cdots mathematically""".split())


def dollars(line):
    s = re.compile('"[^"]*"').sub(lambda m: " " * len(m.group(0)), line)
    s = re.sub("(?:" + B + B + ")*" + B + "$", lambda m: " " * len(m.group(0)), s)
    return [i for i, c in enumerate(s) if c == "$"]


def sanitize(tex):
    tex = DROPENV.sub(" ", tex)
    tex = re.sub(B * 2 + r"label\*?\{[^{}]*\}", " ", tex)
    # any control word pandoc does not know: keep its letters, drop the backslash
    return re.sub(B * 2 + r"([A-Za-z]+)",
                  lambda m: m.group(0) if m.group(1) in KNOWN else m.group(1), tex)


def unresolved_lines(text):
    """Lines whose `$` count is odd: Typst loses the paragraph at those."""
    lines = text.split("\n")
    bad = []
    for i, l in enumerate(lines, 1):
        if len(l.strip()) < 40 or l.strip() == "$":
            continue
        if len(dollars(l)) % 2 == 1:
            bad.append(i)
    return bad


def errors(d):
    p = subprocess.run(["typst", "compile", "main.typ", "_pr.pdf"], cwd=d, capture_output=True,
                       text=True, encoding="utf-8", errors="replace")
    return len(re.findall(r"^error:", (p.stderr or "") + (p.stdout or ""), re.M))


def run(d, dry=False, limit=None):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    src = resplice.latex_source(d)
    if len(src.strip()) < 500:
        return 0
    paras = resplice.paragraphs(src)
    idx = resplice.build_index(paras)
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    base = errors(d)
    text = io.open(mp, encoding="utf-8").read()
    lines = text.split("\n")
    targets = unresolved_lines(text)
    if dry:
        print("%s: %d damaged paragraphs, errors=%d" % (os.path.basename(d), len(targets), base))
        return 0
    shutil.copyfile(mp, mp + ".pararepaired")
    fixed = 0
    for ln in targets:
        ws = WORD.findall(lines[ln - 1])
        if len(ws) < 6:
            continue
        chunk = resplice.find_chunk(paras, idx, ws[:10])
        if not chunk:
            continue
        cand = resplice.clean(resplice.pandoc(sanitize(chunk), work))
        if not cand or cand.count("$") % 2 or len(WORD.findall(cand)) < 4:
            continue
        if B + "$" in cand or re.search(B + r"(?:\\)?begin", cand):
            continue                      # pandoc still bailed: would inject raw LaTeX
        trial = list(lines)
        trial[ln - 1] = cand
        io.open(mp, "w", encoding="utf-8").write("\n".join(trial))
        e = errors(d)
        if e < base:
            print("  line %d reconverted  errors %d -> %d" % (ln, base, e))
            lines, base, fixed = trial, e, fixed + 1
            if limit and fixed >= limit:
                break
        else:
            io.open(mp, "w", encoding="utf-8").write("\n".join(lines))
    io.open(mp, "w", encoding="utf-8").write("\n".join(lines))
    return fixed


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv[1:]
    lim = int(sys.argv[sys.argv.index("--limit") + 1]) if "--limit" in sys.argv[1:] else None
    for a in args or sorted(glob.glob("papers/2*")):
        if not os.path.isdir(a):
            continue
        try:
            n = run(a, dry, lim)
        except Exception as e:
            print(os.path.basename(a), "skip", type(e).__name__, e, flush=True)
            continue
        print("%-14s paragraphs reconverted %d" % (os.path.basename(a), n), flush=True)
