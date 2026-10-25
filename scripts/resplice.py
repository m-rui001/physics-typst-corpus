r"""Re-convert the spans of main.typ that shattered into one-token-per-line wreckage.

A display equation that pandoc could not parse came out as a stream of isolated `~`, `\_`,
`\(`, `,` lines, and the sentence carrying it was cut off mid-word. Those spans are not
repairable by hand-editing the Typst; the intact LaTeX paragraph in _work/body.tex (else
src/) is re-converted with pandoc and spliced back over the damaged lines.

Nothing is deleted: the replacement is the same source paragraph, converted again.

Usage: python -X utf8 scripts/resplice.py [papers/...] [--dry] [--only N]
Writes main.typ.resplished before touching main.typ.
"""
import glob, os, re, shutil, subprocess, sys, tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import junkscan
from typrepair import latex_text_fix

B = chr(92)
WORD = re.compile(r"[A-Za-z][A-Za-z0-9'-]*")


def repair_tex(s):
    r"""Put back the `}` that letter-eating bugs deleted from \begin{equation} / \end{...}.

    _work/body.tex in places reads `\begin{equation` at end of line, which makes pandoc
    abort the whole chunk with "unexpected end of input" - the reason those equations
    originally came out shattered.
    """
    return re.sub(r"(" + B * 2 + r"(?:begin|end)\{[A-Za-z*\-]+)$", r"\1}", s, flags=re.M)


def pad(tex):
    """Close unbalanced braces/environments so pandoc can parse a truncated chunk."""
    envs, depth, i = [], 0, 0
    while i < len(tex):
        ch = tex[i]
        if ch == B and i + 1 < len(tex):
            m = re.match(r"\\(begin|end)\{([^{}]*)\}", tex[i:])
            if m:
                if m.group(1) == "begin":
                    envs.append(m.group(2))
                elif envs and envs[-1] == m.group(2):
                    envs.pop()
                i += m.end()
                continue
            i += 2
            continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth = max(0, depth - 1)
        i += 1
    return tex + "}" * depth + "".join("\\end{%s}" % e for e in reversed(envs))


def _conv(tex, work):
    """One pandoc run: return (typst text, stderr)."""
    tf = tempfile.NamedTemporaryFile("w", suffix=".tex", delete=False, dir=work, encoding="utf-8")
    tf.write(tex)
    tf.close()
    of = tf.name + ".typ"
    r = subprocess.run(["pandoc", tf.name, "-f", "latex", "-t", "typst", "--wrap=none", "-o", of],
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    out = open(of, encoding="utf-8").read() if os.path.exists(of) else ""
    os.unlink(tf.name)
    if os.path.exists(of):
        os.unlink(of)
    return out, (r.stderr or "") + (r.stdout or "")


# Valid in LaTeX math, rejected by pandoc's TeX math reader ("unexpected control sequence"),
# which then dumps the whole equation into main.typ as escaped raw LaTeX.
MATH_REPAIR = {"S": "\\text{§}", "P": "\\text{¶}", "dag": "\\text{†}", "ddag": "\\text{‡}",
               "pounds": "\\text{£}", "mathsection": "\\text{§}",
               # undefined in the preamble these are LaTeX's own glyphs, not Greek letters
               "L": "\\text{Ł}"}


def pandoc(tex, work):
    tex = repair_tex(tex)
    out, err = _conv(tex, work)
    if not out.strip():
        out, err = _conv(pad(tex), work)
    for _ in range(8):
        bad = set(re.findall(r"unexpected control sequence " + B * 2 + r"([A-Za-z]+)", err or ""))
        if not bad or "Could not convert TeX math" not in (err or ""):
            break
        applied = False
        for b in bad & set(MATH_REPAIR):
            tex = re.sub(B * 2 + b + r"(?![A-Za-z])", lambda m, r=MATH_REPAIR[b]: r, tex)
            applied = True
        if not applied:
            break
        nout, nerr = _conv(tex, work)
        if not nout.strip():
            break
        out, err = nout, nerr
    return out.strip()


def math_thin(t):
    r"""`\,` reaches Typst as a bare `thin` identifier, which renders as the word "thin".

    Only inside `$...$`: `thin` is a normal English word in the prose.
    """
    def fix(m):
        inner = m.group(1)
        if not re.search(r"(?<![A-Za-z.#])thin(?![A-Za-z.])", inner):
            return m.group(0)
        return "$" + re.sub(r"(?<![A-Za-z.#])thin(?![A-Za-z.])", "#h(0.17em)", inner) + "$"
    return re.sub(r"\$([^$\n]*)\$", fix, t)


def clean(t):
    t = re.sub(r"\\(?:eq)?ref\{([^}]*)\}", lambda m: "@" + m.group(1).strip(), t)
    t = re.sub(r"\\cite[tp]?\{([^}]*)\}", lambda m: " ".join("@" + k.strip() for k in m.group(1).split(",")), t)
    t = re.sub(r"~(?=[A-Za-z0-9@])", " ", t)
    t = re.sub("\\" + B + r"(?:label|nonumber|notag)\*?\{[^{}]*\}", "", t)
    # LaTeX escapes Typst reads as errors: \| \( \) \[ \] \, \; \: \/
    t = re.sub("\\" + B + r"([()\[\]|])", r"\1", t)
    t = re.sub("\\" + B + r"[,;:! ]", " ", t)
    # `\/` is LaTeX's italic correction: nothing to render, and Typst reads it as a bad escape
    t = re.sub(B * 2 + r"/", "", t)
    # Typst's `\langle`/`\rangle` are `angle.l`/`angle.r`; `chevron.l` is the ◁ triangle
    t = re.sub(r"chevron\.(l|r)", lambda m: "angle." + m.group(1), t)
    t = latex_text_fix(t)
    t = math_thin(t)

    # Walk math spans once, left to right: a `<label>` either inside the span or sitting right
    # after it belongs to that equation, and a labeled equation is only legal as a *displayed*
    # one - `$` alone on its line - so it leaves the prose paragraph it was inlined into.
    def span(m):
        inner, tail = m.group(1), m.group(2)
        labs = re.findall(r"<[A-Za-z0-9:_\-]+>", inner)
        if tail:
            labs.append(tail.strip())
        if not labs:
            return m.group(0)
        body = re.sub(r"<[A-Za-z0-9:_\-]+>", " ", inner).strip()
        body = re.sub(r"\s{2,}", " ", body)
        # a label is *markup*: inside `$...$` Typst parses it as `<` + identifier
        return "\n$\n  %s\n$ %s\n" % (body, " ".join(labs))

    t = re.sub(r"\$([^$\n]*)\$( <[A-Za-z0-9:_\-]+>)?", span, t)
    # `<Def. flux>`: Typst label ids cannot contain spaces
    t = re.sub(r"<([A-Za-z0-9_\-]+ [^<>\n]{0,40})>",
               lambda m: "<" + re.sub(r"[^A-Za-z0-9:_\-]", "-", m.group(1)) + ">", t)
    t = re.sub(r"[ \t]+", " ", t)
    return t.strip()


DEF = re.compile(B * 2 + "def" + B * 2 + r"([A-Za-z]+)(?:#[0-9]+)?\s*(\{(?:[^{}]|\{[^{}]*\})*\})")


def macro_defs(s):
    r"""Author macros from both `\newcommand{...}{...}` and `\def\name{...}`.

    `\def` is the common form in these LaTeX sources (`\def\f{\phi}`, `\def\be{\begin{equation}}`),
    and pandoc abandons any formula that still contains one, leaving escaped raw LaTeX in main.typ.
    """
    defs = [(n, macro_body(b)) for n, b in MACRO.findall(s)]
    defs += [(n, macro_body(b)) for n, b in DEF.findall(s)]
    return defs


def expand_defs(s, names):
    r"""Anchored expansion: the backslash is mandatory, and `\alpha` is never `\a`+`lpha`.

    A body without `#1` still keeps the group it is called with: `\def\te{\text}` used as
    `\te{gravity}` must become `\text{gravity}`, not `\text`.
    """
    for name, body in names:
        # `(?![A-Za-z])`, not `\b`: `\f_{i}` is the common use form and `_` is a word character,
        # so a `\b` guard left those macros unexpanded and pandoc abandoned the formula.
        s = re.sub(B * 2 + name + r"(?![A-Za-z])", lambda m, r=body: r, s)
        if "#1" in body:
            s = re.sub(B * 2 + name + r"\{([^{}]*)\}", lambda m, r=body: r.replace("#1", m.group(1)), s)
        else:
            s = re.sub(B * 2 + name + r"\{", lambda m, r=body: r + "{", s)
    return s


MACRO = re.compile(r"\\" + r"(?:re)?newcommand\*?\{?\\" + r"(\w+)\}?(?:\[\d+\])?\s*(\{(?:[^{}]|\{[^{}]*\})*\})")


def macro_body(repl):
    r"""Drop exactly ONE brace pair: `\end{equation}` ends in `}}`, and strip("{}") ate both."""
    return repl[1:-1] if repl[:1] == "{" and repl[-1:] == "}" else repl


def strip_comments(s):
    out = []
    for line in s.split("\n"):
        cut, i = None, 0
        while i < len(line):
            if line[i] == B:
                # any control/space sequence: \% \& \\ are data, not an escape of the next token
                i += 2
                continue
            if line[i] == "%":
                cut = i
                break
            i += 1
        out.append(line if cut is None else line[:cut])
    return "\n".join(out)


def expand_macros(s):
    """Anchored \\name expansion (convert.py's rule): the backslash is mandatory."""
    return expand_defs(s, macro_defs(s))


def latex_source(d):
    r"""Pristine author LaTeX. _work/body.tex is NOT usable: the same letter-eating bug
    that broke main.typ had already eaten the backslashes of \frac / \bar there."""
    files = sorted(glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True))
    if not files:
        bt = os.path.join(d, "_work", "body.tex")
        return open(bt, encoding="utf-8", errors="replace").read() if os.path.exists(bt) else ""
    parts = []
    # the root is the file that starts the document, not any file that happens to
    # mention the word "input" (a style or subfile can, and then main.tex is skipped)
    def has(f, *pats):
        t = open(f, encoding="utf-8", errors="replace").read()
        return any(p in t for p in pats)
    root = ([f for f in files if has(f, B + "documentclass")]
            or [f for f in files if has(f, B + "begin{document}")] or files)
    for f in root:
        parts.append(expand_inputs(f))
    s = strip_comments("\n".join(parts))
    return expand_macros(s)


INPUT = re.compile(B + B + r"(?:input|subfile|include)\{([^{}]+)\}")


def expand_inputs(path, seen=None):
    """Inline \\input/\\subfile/\\include so a paper split across files is read whole."""
    seen = seen or set()
    path = os.path.normpath(path)
    if path in seen or not os.path.isfile(path) or len(seen) > 40:
        return ""
    seen.add(path)
    try:
        text = open(path, encoding="utf-8", errors="replace").read()
    except OSError:
        return ""
    base = os.path.dirname(path)

    def rep(m):
        name = m.group(1).strip()
        for cand in (name, name + ".tex"):
            p = os.path.join(base, cand)
            if os.path.isfile(p):
                return expand_inputs(p, seen)
        return ""

    return INPUT.sub(rep, text)


def paragraphs(src):
    """(word list, raw text) per blank-line chunk of the LaTeX source."""
    out = []
    for chunk in re.split(r"\n[ \t]*\n", src):
        if len(chunk.strip()) < 20:
            continue
        out.append(([w.lower() for w in WORD.findall(re.sub(B * 2 + r"[a-zA-Z@]+\*?", " ", chunk))], chunk))
    return out


def build_index(paras):
    """word -> [(chunk, position)] so anchor lookup is O(hits), not O(corpus x anchor)."""
    idx = {}
    for ci, (words, chunk) in enumerate(paras):
        for pi, w in enumerate(words):
            idx.setdefault(w, []).append((ci, pi))
    return idx


def find_chunk(paras, idx, anchor):
    """Chunk whose word stream contains the anchor run (majority of words equal)."""
    a = [w.lower() for w in anchor]
    an = len(a)
    best, bl = None, 0
    for ci, pi in idx.get(a[0], []):
        words = paras[ci][0]
        if pi + an > len(words):
            continue
        hit = sum(1 for x, y in zip(words[pi:pi + an], a) if x == y)
        if hit > bl:
            bl, best = hit, paras[ci][1]
    return best if bl >= max(3, int(0.8 * an)) else None


def errors(d):
    """Compile error count, used to gate every rewrite."""
    p = subprocess.run(["typst", "compile", "main.typ", "_rs.pdf"], cwd=d, capture_output=True,
                       text=True, encoding="utf-8", errors="replace")
    n = len(re.findall(r"^error:", (p.stderr or "") + (p.stdout or ""), re.M))
    sp = os.path.join(d, "_rs.pdf")
    if os.path.exists(sp):
        os.unlink(sp)
    return n


def run(d, dry=False, only=None):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    text = open(mp, encoding="utf-8", errors="replace").read()
    lines = text.split("\n")
    regions, _ = junkscan.scan(d)
    # a region is repairable when it is shattered wreckage (>=3 lines) or a single line
    # that still carries escaped LaTeX
    regions = [r for r in regions if r[1] - r[0] >= 2 or junkscan.is_raw(lines[r[0] - 1])]
    # A `$` that only closes after a paragraph break means the equation shattered and the
    # prose after it was swallowed: seed a region at each such line.
    inside = set()
    for a, b in regions:
        inside.update(range(a, b + 1))
    for ln, _why in junkscan.paragraph_math(text):
        if ln not in inside:
            regions.append((ln, ln))
    if only:
        regions = regions[:only]
    src = latex_source(d)
    if len(src.strip()) < 500:
        return 0
    paras = paragraphs(src)
    idx = build_index(paras)
    done, edits = 0, []
    for a, b in regions:
        anchor_line = None
        for i in range(a - 1, max(0, a - 8), -1):
            ws = WORD.findall(lines[i - 1]) if i - 1 < len(lines) else []
            if len(ws) >= 6:
                anchor_line = i
                anchor = ws[-12:]
                break
        if not anchor_line:
            continue
        chunk = find_chunk(paras, idx, anchor)
        if not chunk:
            continue
        new = clean(pandoc(chunk, work))
        if not new or len(WORD.findall(new)) < 0.5 * len(WORD.findall(chunk)):
            continue
        if junkscan.is_raw(new):
            continue  # conversion failed again: keep the current text rather than churn
        # The source chunk runs past the wreckage: swallow the following main.typ lines
        # whose opening words already appear in it, so nothing is duplicated.
        cw = [w.lower() for w in WORD.findall(chunk)]
        e = b
        while e + 1 <= min(len(lines), b + 40):
            nxt = WORD.findall(lines[e])
            if len(nxt) < 6:
                break
            head = [w.lower() for w in nxt[:8]]
            joined = " ".join(cw)
            if " ".join(head) not in joined and sum(1 for x in head if x in cw) < 7:
                break
            e += 1
        edits.append((anchor_line, e, new))
        done += 1
    # never let two replacements overlap
    edits.sort()
    kept, prev = [], 0
    for a, b, new in edits:
        if a <= prev:
            continue
        kept.append((a, b, new))
        prev = b
    edits = kept
    for a, b, new in sorted(edits, reverse=True):
        if dry:
            print("--- would replace lines %d-%d with:\n%s" % (a, b, new[:700]))
            continue
        lines[a - 1:b] = [new]
    if edits and not dry:
        base = errors(d)
        shutil.copyfile(mp, mp + ".resplished")
        open(mp, "w", encoding="utf-8").write("\n".join(lines))
        after = errors(d)
        if after > base:
            shutil.copyfile(mp + ".resplished", mp)
            print("RESPICE ROLLED BACK: errors %d -> %d" % (base, after))
            return 0
    return done


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--") and not a.isdigit()]
    dry = "--dry" in sys.argv[1:]
    only = int(sys.argv[sys.argv.index("--only") + 1]) if "--only" in sys.argv[1:] else None
    for a in args or sorted(glob.glob("papers/2*")):
        try:
            n = run(a, dry, only)
        except Exception as e:
            print(os.path.basename(a), "skip", type(e).__name__, e)
            continue
        print("%-14s respliced %d regions" % (os.path.basename(a), n))
