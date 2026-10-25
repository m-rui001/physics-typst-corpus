r"""Repair spans of main.typ that are still raw LaTeX instead of Typst.

junkscan catches one-token-per-line wreckage (short fragments). This stage catches the
other class: long lines that are *untouched LaTeX* (`\\begin{equation}`, `\\frac{}`,
`\\_{}`, `\\$\\$`) which pandoc passed through verbatim because a macro in the preamble
was unknown to it. Such a span neither compiles nor reads as anything, so it is
re-converted from its own text (backslashes unescaped, lines joined) with pandoc, and the
result spliced back over it. If the span alone cannot be parsed, the matching paragraph is
taken from the pristine `src/**/*.tex` instead. Nothing is deleted.

Usage: python -X utf8 scripts/texleft.py [papers/...] [--dry]
Writes main.typ.texlefted before touching main.typ.
"""
import glob, os, re, shutil, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import resplice

B = chr(92)
CMD = set("""frac dfrac tfrac cfrac binom begin end left right bigg Bigg bigg Bigg bigl bigr
Bigl Bigr big Big partial sum prod int oint iint simeq sim approx equiv propto leq geq neq
subset subseteq supset cap cup setminus in notin not forall exists wedge vee oplus otimes
cdot times div pm mp infty hbar ell
alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi pi rho sigma tau
upsilon phi chi psi omega Gamma Delta Theta Lambda Xi Pi Sigma Upsilon Phi Psi Omega
varphi varepsilon varpi hat bar overline underline tilde vec dot ddot mathrm mathbf mathit
mathcal mathbb mathsf mathfrak operatorname text textrm textbf textit footnote
label ref eqref pageref cite bibliographystyle bibliography bibitem item itemize enumerate
section subsection subsubsection paragraph chapter caption includegraphics graphicspath
documentclass document usepackage newcommand renewcommand providecommand def centering
flushleft noindent indent quad qquad nonumber notag dagger ddagger langle rangle underbrace
overbrace limsup liminf arccos arcsin argdeg gcd deg emph boldseries itshape rmfamily
sffamily tiny scriptsize footnotesize small normalsize large Large""".split())

# Typst-side constructs that must never be rewritten.
SKIP = re.compile(r"^#(canvas|import|show|set|let|figure|table|image|link|text|strong)")


def n_ctrl(s):
    """Backslash-led TeX control words on this line that Typst has no business containing."""
    return sum(1 for m in re.finditer(r"\\" + r"([A-Za-z]{2,})\*?", s) if m.group(1) in CMD)


def is_remnant(line):
    if SKIP.match(line.strip()):
        return False
    t = re.sub(r'"[^"]*"', " ", line)          # keep "literal strings" out of the vote
    if n_ctrl(t) == 0:
        # escaped Typst punctuation left by the double-escape bug, or a `\\` line break
        return bool(re.search("\\" + B + r"\$", t) or re.search(r"\\" + B * 2 + r"[_^{}]", t))
    return n_ctrl(t) >= 2 or (n_ctrl(t) == 1 and len(t.strip()) > 40)


def regions(lines):
    out, i, n = [], 0, len(lines)
    while i < n:
        if is_remnant(lines[i]):
            j = i
            last = i
            while j < n and (is_remnant(lines[j]) or (lines[j].strip() == ""
                             and j + 1 < n and is_remnant(lines[j + 1]) and j + 1 - last <= 2)):
                if is_remnant(lines[j]):
                    last = j
                j += 1
            # a single short line is usually a legitimate math remnant residue.py owns
            if last - i >= 1 or len(lines[i].strip()) > 60:
                out.append((i + 1, last + 1))
            i = j
        else:
            i += 1
    return out


def unescape(s):
    s = re.sub(r"\\" + B * 2, lambda m: B, s)                    # \\ -> \
    s = re.sub("\\" + B + r"([$%&#_{}])", lambda m: m.group(1), s)   # \$ -> $
    return s


def as_latex(lines):
    """Rejoin a span into LaTeX: a trailing lone backslash is a line break, not content."""
    parts = []
    for l in lines:
        l = unescape(l).rstrip()
        if l.endswith(B):
            l = l[:-1]
        parts.append(l)
    return " ".join(p.strip() for p in parts if p.strip())


def relabel(text, labels):
    """$<some-label-name>$ remnants become real Typst refs when the label exists."""
    def rep(m):
        name = m.group(1)
        return ("@" + name) if name in labels else m.group(0)
    return re.sub(r"\$" + r"<([A-Za-z0-9:_./-]+)>\$" + r"", rep, text)


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    text = open(mp, encoding="utf-8", errors="replace").read()
    lines = text.split("\n")
    labels = set(re.findall(r"<([A-Za-z0-9:_./-]+)>", text))
    src = resplice.latex_source(d)
    paras = resplice.paragraphs(src) if len(src.strip()) > 500 else []
    idx = resplice.build_index(paras) if paras else None
    regs = regions(lines)
    edits, done = [], 0
    for a, b in regs:
        span = lines[a - 1:b]
        tex = as_latex(span)
        new = ""
        if len(tex) > 3:
            new = resplice.clean(resplice.pandoc(tex, work))
        if not new or new.count("$") % 2:
            # span is a truncated equation: convert the intact paragraph from src instead
            anchor = [w for l in span for w in re.findall(r"[A-Za-z]{5,}", unescape(l))][:8]
            chunk = resplice.find_chunk(paras, idx, anchor) if anchor and idx else None
            if chunk:
                cand = resplice.clean(resplice.pandoc(chunk, work))
                if cand and cand.count("$") % 2 == 0:
                    new, done_src = cand, True
        if not new or new.count("$") % 2:
            continue
        new = relabel(new, labels)
        edits.append((a, b, new))
        done += 1
    for a, b, new in sorted(edits, reverse=True):
        if dry:
            print("--- lines %d-%d ->\n%s" % (a, b, new[:300]))
            continue
        lines[a - 1:b] = [new]
    if edits and not dry:
        shutil.copyfile(mp, mp + ".texlefted")
        open(mp, "w", encoding="utf-8").write("\n".join(lines))
    return done


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv[1:]
    tot = 0
    for a in args or sorted(glob.glob("papers/2*")):
        if not os.path.isdir(a):
            continue
        try:
            n = run(a, dry)
        except Exception as e:
            print(os.path.basename(a), "skip", type(e).__name__, e)
            continue
        print("%-14s retex'd %d spans" % (os.path.basename(a), n), flush=True)
        tot += n
    print("TEX REMNANTS RECONVERTED", tot)
