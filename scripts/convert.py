"""LaTeX -> Typst pipeline for arXiv physics papers.
Usage: python convert.py <paper_dir>
paper_dir contains src/ (extracted latex). Produces main.typ, build/main.pdf.
Deterministic conversion via Python + pandoc; TikZ->CeTZ and compile-error fixing
are delegated to the codebuddy free-model sub-agent (guided by local cetz skill docs).
"""
import os, re, sys, glob, subprocess, shutil, json, tempfile
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from typrepair import auto_fix
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")

PAPER = os.path.abspath(sys.argv[1])
SRC = os.path.join(PAPER, "src")
FIG = os.path.join(PAPER, "figures")
WORK = os.path.join(PAPER, "_work")
SKILLS = r"E:\phys\skills"
for d in (FIG, WORK):
    os.makedirs(d, exist_ok=True)

def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True,
                          encoding="utf-8", errors="replace", **kw)

def read(f):
    return open(f, encoding="utf-8", errors="replace").read()

def find_main_tex():
    cands = []
    for f in glob.glob(os.path.join(SRC, "**", "*.tex"), recursive=True):
        t = read(f)
        score = 0
        if r"\documentclass" in t: score += 100
        if r"\begin{document}" in t: score += 100
        score += min(len(t) // 1000, 50)
        cands.append((score, f))
    if not cands:
        raise RuntimeError("no tex files in " + SRC)
    return max(cands)[1]

def strip_comments(s):
    out = []
    for line in s.split("\n"):
        i = 0
        res = []
        while i < len(line):
            if line[i] == "%":
                nb, j = 0, i - 1
                while j >= 0 and line[j] == "\\":
                    nb += 1; j -= 1
                if nb % 2 == 0:
                    break
            res.append(line[i]); i += 1
        out.append("".join(res))
    return "\n".join(out)

def repair_braces(s):
    """Drop unmatched '}' and append missing '}' so parsers don't hit EOF."""
    out, depth, i, esc = [], 0, 0, False
    while i < len(s):
        ch = s[i]
        if esc:
            out.append(ch); esc = False; i += 1; continue
        if ch == "\\":
            out.append(ch); esc = True; i += 1; continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            if depth == 0:
                i += 1; continue
            depth -= 1
        out.append(ch); i += 1
    return "".join(out) + "}" * depth

def inline_one(name, maindir):
    for cand in (name, name + ".tex"):
        p = os.path.join(maindir, cand)
        if os.path.isfile(p):
            inner = strip_comments(read(p))
            return inline_inputs(inner, os.path.dirname(p))
    return ""

def inline_inputs(s, maindir):
    for _ in range(5):
        # path macros such as \ProjectRoot are defined in the preamble, which is
        # itself inlined on the first pass, so collect definitions each round
        defs = dict(re.findall(r"\\newcommand\*?\{\\(\w+)\}\{(.*?)\}", s))
        defs.update(dict(re.findall(r"\\(?:def|renewcommand\*?)\{\\(\w+)\}\{(.*?)\}", s)))

        def repl(m):
            name = m.group(1)
            for k, v in defs.items():
                name = name.replace("\\" + k, v)
            if "\\" in name:
                return m.group(0)
            return inline_one(name.strip(), maindir)

        new = re.sub(r"\\(?:input|include|subfile)\*?\{([^}]+)\}", repl, s)
        if new == s:
            break
        s = new
    return s

def _arg(s, i):
    """Balanced `{...}` argument starting at the `{` at index i."""
    d = 0
    for j in range(i, len(s)):
        c = s[j]
        if c == "\\":
            continue
        if c == "{":
            d += 1
        elif c == "}":
            d -= 1
            if d == 0:
                return s[i + 1:j], j + 1
    return "", i


def deluxetable_to_table(s):
    """AASTeX `deluxetable` is not a LaTeX float pandoc knows; it drops the table
    (and every `\\ref` to its label) silently. Rebuild it as table+tabular."""
    pat = re.compile(r"\\begin\{(deluxetable\*?)\}\s*\{([^}]*)\}(.*?)\\end\{\1\}", re.S)

    def conv(m):
        cols, body = m.group(2), m.group(3)
        cap = ""
        cm = re.search(r"\\tablecaption\s*\{", body)
        if cm:
            cap, end = _arg(body, cm.end() - 1)
            body = body[:cm.start()] + body[end:]
        note = ""
        nm = re.search(r"\\tablecomments\s*\{", body)
        if nm:
            note, end = _arg(body, nm.end() - 1)
            body = body[:nm.start()] + body[end:]
        head = ""
        hm = re.search(r"\\tablehead\s*\{", body)
        if hm:
            head, end = _arg(body, hm.end() - 1)
            body = body[:hm.start()] + body[end:]
        dm = re.search(r"\\startdata(.*?)(?:\\enddata|$)", body, re.S)
        data = dm.group(1) if dm else ""
        strip = lambda t: re.sub(r"\\(?:tabletypesize|tablewidth|startlongtable|"
                                 r"tablealignment|tablecolumns)\b\s*(?:\{[^{}]*\})?", "",
                                 re.sub(r"\\colhead\b\s*", "", t))
        head, data, cap = strip(head), strip(data), strip(cap)
        # the last `\tablehead` row has no trailing `\\`; pandoc's tabular reader
        # then aborts and dumps the whole environment as raw text.
        if head.strip() and not head.rstrip().endswith("\\\\"):
            head = head.rstrip() + " \\\\\n"
        # pandoc ends a table caption at the first `\\`, so a note merged into the
        # caption with a line break leaks into the float body as bare paragraphs.
        note_tail = ""
        if note:
            note_tail = "\\par\\noindent{\\footnotesize %s\\par}" % note
        mid = r"\hline" if head.strip() else ""
        return ("\\begin{table}\n\\caption{%s}\n\\begin{tabular}{%s}\n%s\n%s\n%s\n"
                "\\end{tabular}\n\\end{table}\n%s" % (cap, cols, head, mid, data, note_tail))

    return re.sub(r"\\startlongtable\s*", "", pat.sub(conv, s))


def tabularx_to_tabular(s):
    """pandoc has no tabularx reader: a `Y`/`X` column makes it dump the whole
    environment as raw text into a `#block[]`, which then eats the document."""
    out, pos = [], 0
    while True:
        i = s.find("\\begin{tabularx}", pos)
        if i < 0:
            out.append(s[pos:])
            break
        out.append(s[pos:i])
        j = i + len("\\begin{tabularx}")
        while j < len(s) and s[j] in " \t\n":
            j += 1
        if j < len(s) and s[j] == "[":
            j = s.find("]", j) + 1
        while j < len(s) and s[j] in " \t\n":
            j += 1
        _, j = _arg(s, j)                      # width argument
        while j < len(s) and s[j] in " \t\n":
            j += 1
        spec, j = _arg(s, j)
        spec = re.sub(r"[XY]", "l", spec)
        out.append("\\begin{tabular}{%s}" % spec)
        pos = j
    return "".join(out).replace("\\end{tabularx}", "\\end{tabular}")


def extract_blocks(s, begin, end, tag):
    pics = []
    while True:
        a = s.find(begin)
        if a < 0:
            break
        b = s.find(end, a)
        if b < 0:
            break
        b += len(end)
        pics.append(s[a:b])
        s = s[:a] + f"ZZ{tag}{len(pics)-1}ZZ" + s[b:]
    return pics, s

CB = shutil.which("codebuddy") or "codebuddy"

def oc2a(prompt, cwd, timeout=420):
    """opencode2api local proxy sub-agent (free opencode models, bash-denied: it only edits files)."""
    import tempfile, uuid
    f = tempfile.NamedTemporaryFile("w", suffix=".txt", delete=False, encoding="utf-8")
    f.write(prompt + "\n\nAll relative paths above are under " + cwd + " — read and edit them by absolute path inside that directory. Do not run commands; only read/write/edit files.")
    f.close()
    env = dict(os.environ, PYTHONIOENCODING="utf-8")
    for model in ("opencode/glm-5.3-flash-free", "opencode/deepseek-v4-flash-free"):
        r = run([sys.executable, "-X", "utf8", r"E:\tools\oc2a_ask.py",
                 "--model", model, "--session", uuid.uuid4().hex[:8], f.name],
                cwd=cwd, timeout=timeout, env=env)
        if r.returncode == 0 and (r.stdout or "").strip():
            return r
    return r

def cb(prompt, cwd, timeout=600):
    """codebuddy sub-agent on free models (credit-free), non-interactive."""
    if os.environ.get("ENGINE") == "oc2a":
        r = oc2a(prompt, cwd, min(timeout, 540))
        if r.returncode == 0:
            return r
    for model in ("deepseek-v4.1-flash", "hy3"):
        r = run([CB, "-p", prompt, "-y", "--model", model,
                 "--tools", "Read,Write,Edit,Bash,Glob,Grep", "--add-dir", SKILLS],
                cwd=cwd, timeout=timeout)
        out = (r.stdout or "") + (r.stderr or "")
        if "Credits exhausted" in out or "429" in out:
            continue
        return r
    return r

def process_graphics(s):
    """Resolve \\includegraphics paths; convert pdf/eps figures to PNG under imgs/."""
    IMGSDIR = os.path.join(PAPER, "imgs")
    os.makedirs(IMGSDIR, exist_ok=True)
    def find_img(path):
        base = os.path.basename(path)
        for cand in (os.path.join(SRC, path) + e for e in ("", ".pdf", ".png", ".jpg", ".jpeg", ".eps", ".ps")):
            if os.path.isfile(cand):
                return cand
        stem0 = os.path.splitext(base)[0]
        g = (glob.glob(os.path.join(SRC, "**", base), recursive=True)
             or glob.glob(os.path.join(SRC, "**", base + ".*"), recursive=True)
             or glob.glob(os.path.join(SRC, "**", stem0 + ".*"), recursive=True))
        return g[0] if g else None
    def repl(m):
        opts, path = m.group(1) or "", m.group(2)
        f = find_img(path)
        if not f:
            return m.group(0)
        stem = re.sub(r"\W+", "_", os.path.splitext(os.path.basename(path))[0])
        ext = os.path.splitext(f)[1].lower()
        if ext in (".pdf", ".eps", ".ps"):
            out = os.path.join(IMGSDIR, stem + ".png")
            if not os.path.exists(out):
                try:
                    import pymupdf
                    doc = pymupdf.open(f)
                    pix = doc[0].get_pixmap(dpi=200)
                    pix.save(out)
                except Exception as e:
                    print("imgconv fail", f, str(e)[:80])
                    return "MISSINGFIG(" + stem + ")"
            return f"\\includegraphics{opts}{{imgs/{stem}.png}}"
        shutil.copy(f, os.path.join(IMGSDIR, stem + ext))
        return f"\\includegraphics{opts}{{imgs/{stem}{ext}}}"
    return re.sub(r"\\includegraphics(\[[^\]]*\])?\{([^}]+)\}", repl, s)

# ============ load & flatten ============
mainf = find_main_tex()
tex = tabularx_to_tabular(deluxetable_to_table(
    inline_inputs(read(mainf), os.path.dirname(mainf))))
# The author list loses the braces around ORCID ids during macro flattening, so
# `\orcidlink{0000-...}` survives as `\orcidlink0000-...`; Typst reads `\o` as an
# escape and prints the rest of the string as visible junk.
tex = re.sub(r"\\orcidlink\s*\{?[0-9X-]*\}?", "", tex)
if r"\begin{document}" in tex and r"\end{document}" in tex:
    preamble = tex[:tex.index(r"\begin{document}")]
    body = tex[tex.index(r"\begin{document}"):tex.rindex(r"\end{document}") + len(r"\end{document}")]
else:
    preamble, body = "", tex
body = strip_comments(body)
# `\!` and `\kern-2em` are pure TeX spacing; texmath has no mapping, rejects the
# whole display and pandoc dumps it as escaped source (leaving a dangling `$` that
# later turns prose into math).
body = re.sub(r"\\!(?![A-Za-z])", "", body)
body = re.sub(r"\\kern\s*-?[\d.]+\s*(?:em|ex|pt|mu|mm|cm|in)?", "", body)
# The same goes for the display-only layout commands texmath refuses; one of them
# rejects the whole environment and pandoc prints the equation as LaTeX source.
body = re.sub(r"\\(?:hspace|vspace)\*?\s*\{[^{}]*\}", "", body)
body = re.sub(r"\\(?:nonumber|notag|hfill|hfil)\b", "", body)
# `\begingroup`/`\allowdisplaybreaks` around an `eqnarray` hides the environment
# from pandoc, which then dumps the raw LaTeX (double-escaped) into main.typ.
body = re.sub(r"\\(?:begingroup|endgroup|allowdisplaybreaks)\b", "", body)
_MATH_ENVS = r"equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?|displaymath|math"
# `{\rm GW}` uses \rm as a switch; texmath only knows `\mathrm{GW}` and rejects the
# display otherwise (pandoc then prints the whole equation as LaTeX source). Do this
# inside math only: in prose `\underline{\mathit{...}}` is dropped by pandoc entirely.
_RM = {"rm": "mathrm", "it": "mathit", "bf": "mathbf", "sf": "mathsf",
       "tt": "mathtt", "cal": "mathcal"}


def _brace_end(s, i):
    depth = 0
    for j in range(i, len(s)):
        if s[j] == "{":
            depth += 1
        elif s[j] == "}":
            depth -= 1
            if depth == 0:
                return j
    return -1


def _rm_groups(t):
    """`{\\rm Eq.~\\eqref{x}}` nests braces, so the flat regex misses it and texmath
    aborts the display. Convert any `{\\rm ...}` group (balanced) to `{\\mathrm{...}}`."""
    out, i = [], 0
    while True:
        m = re.search(r"\{\\(rm|it|bf|sf|tt|cal)\s", t[i:])
        if not m:
            out.append(t[i:])
            return "".join(out)
        s = i + m.start()
        e = _brace_end(t, s)
        if e < 0:
            out.append(t[i:])
            return "".join(out)
        name = m.group(1)
        inner = t[s + len(name) + 3:e]
        out.append(t[i:s])
        # A ref marker nested in the group is stringified by texmath; keep it as a
        # sibling argument instead (`{\rm Eq.~\eqref{x}}` -> `{\rm Eq.}~\text{...}`).
        mref = re.search(r"~?\s*\\text\{(QQR\d+QQ)\}$", inner)
        if mref:
            out.append("{\\%s{%s}}" % (_RM[name], inner[:mref.start()]))
            out.append("~\\text{%s}" % mref.group(1))
        else:
            out.append("{\\%s{%s}}" % (_RM[name], inner))
        i = e + 1


_REF_KEYS = []


def _fix_math_switches(s):
    def conv(t):
        # texmath has no `\ref`/`\eqref` reader; a numeric marker survives conversion
        # (underscores in the key would be read as subscripts) and is rewritten to
        # `#ref(<key>)` once the document is Typst.
        def refmark(m):
            _REF_KEYS.append(m.group(1))
            return r"\text{QQR%dQQ}" % (len(_REF_KEYS) - 1)
        t = re.sub(r"\\(?:eq)?ref\{([^{}]*)\}", refmark, t)
        t = _rm_groups(t)
        return re.sub(r"\^\{\\(rm|it|bf)\s*\(([^{}]*)\)\}",
                      lambda m: "^{\\%s{(%s)}}" % (_RM[m.group(1)], m.group(2)), t)
    s = re.sub(r"\\begin\{(%s)\}(.*?)\\end\{\1\}" % _MATH_ENVS,
               lambda m: "\\begin{%s}%s\\end{%s}"
               % (m.group(1), conv(m.group(2)), m.group(1)), s, flags=re.S)
    return re.sub(r"\$\$.*?\$\$|\$[^$\n]*\$", lambda m: conv(m.group(0)), s, flags=re.S)


body = _fix_math_switches(body)
# `\iffalse ... \fi` is dead source; pandoc ignores the TeX conditional and would
# typeset (and fail to find images for) content the compiled paper never shows.
body = re.sub(r"\\iffalse\b.*?\\fi\b", "", body, flags=re.S)
# `\cite{` followed by a newline and `%` comments (common in long key lists) leaves
# a citation whose braces span blank lines; pandoc then prints the keys as prose.
body = re.sub(r"\\(cite[a-zA-Z]*\*?)\{([^}]*)\}",
              lambda m: "\\" + m.group(1) + "{" + re.sub(r"\s+", "", m.group(2)) + "}", body)
# `\cite{a,b}and` (no space in the source) glues the next word onto the last key, so
# the key lookup fails and the citation is blanked.
body = re.sub(r"(\\cite[a-zA-Z]*\*?\{[^}]*\})(?=[A-Za-z])", r"\1 ", body)
body = body.replace(r"\begin{document}", "").replace(r"\end{document}", "")
# A&A sources often redefine `\.` from an accent to a thin space and then use it as
# the only separator between numbers and units. pandoc still reads it as an accent
# and abandons the whole display, so spell the spacing out before pandoc sees it.
if re.search(r"\\(?:re)?newcommand\s*\{?\\\.\}?|\\def\\\.", preamble):
    body = body.replace(r"\.", r"\,")
# the reference list becomes refs.bib (below); leaving it in the body duplicates every
# entry as unconvertible prose (`\bibitem` has no pandoc mapping)
body = re.sub(r"\\begin\{thebibliography\}.*?\\end\{thebibliography\}", "", body, flags=re.S)
body = re.sub(r"\\begin\{references\}.*?\\end\{references\}", "", body, flags=re.S)
# layout-only wrappers: `\begin{spacing}{1.15}` leaks its numeric argument as text
body = re.sub(r"\\begin\{spacing\}\s*\{[^{}]*\}", "", body).replace(r"\end{spacing}", "")
body = re.sub(r"\\(?:begin|end)\{singlespace\*?\}", "", body)
body = re.sub(r"\\(?:begin|end)\{onehalfspacing\}", "", body)
# a table of contents has no static equivalent; the headings below carry the structure
body = re.sub(r"\\tableofcontents\b", "", body)
# the paragraph split below isolates `\begin{abstract}` into its own chunk, and pandoc
# turns that lone token into a printed "abstract" line - drop the delimiters, keep text
body = body.replace(r"\begin{abstract}", "").replace(r"\end{abstract}", "")
body = process_graphics(body)
# pandoc's LaTeX reader has no \subfloat: it discards the ENTIRE float, panels and caption.
# The parent \caption already names the panels ((a), (b), …), so unwrap to a plain include.
body = re.sub(r"\\subfloat\s*(\[[^\]]*\])?\s*", "", body)
body = repair_braces(body)
if len(body.strip()) < 300:
    json.dump({"paper": os.path.basename(PAPER), "empty_source": True, "compiled": False},
              open(os.path.join(PAPER, "report.json"), "w", encoding="utf-8"), indent=1)
    print("EMPTY SOURCE - no convertible LaTeX (arXiv e-print is likely a direct PDF submission)")
    sys.exit(0)
# ============ extract TikZ pictures ============
tikzs, body = extract_blocks(body, r"\begin{tikzpicture}", r"\end{tikzpicture}", "TIKZ")
for i, tk in enumerate(tikzs):
    open(os.path.join(FIG, f"tikz_{i}.tex"), "w", encoding="utf-8").write(tk)

# ============ simple macro expansion ============
def _balanced(s, i):
    """s[i] == '{'; return (argument, index after the closing brace) or (None, i)."""
    depth, j = 0, i
    while j < len(s):
        ch = s[j]
        if ch == "\\":
            j += 2
            continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
        j += 1
    return None, i


def _in_math(s, pos):
    """True when s[pos] sits inside inline or display math."""
    head = s[:pos]
    begins = len(re.findall(r"\\begin\{(?:%s)\}" % _MATH_ENVS, head))
    ends = len(re.findall(r"\\end\{(?:%s)\}" % _MATH_ENVS, head))
    if begins > ends:
        return True
    return re.sub(r"\\\$", "", head).count("$") % 2 == 1


def _macro_arity(repl):
    return max([int(x) for x in re.findall(r"#([1-9])", repl)] or [0])


def _macro_args(s, i, n):
    r"""Read n brace (or one optional bracket) arguments starting at s[i]."""
    args, j = [], i
    while len(args) < n:
        while j < len(s) and s[j] in " \t\n":
            j += 1
        if j >= len(s):
            return None
        if s[j] == "[" and not args:
            k = s.find("]", j)
            if k < 0:
                return None
            args.append(s[j + 1:k])
            j = k + 1
        elif s[j] == "{":
            arg, end = _balanced(s, j)
            if arg is None:
                return None
            args.append(arg)
            j = end
        else:
            # TeX also accepts a single token as an undelimited argument; a control
            # sequence is one token, not just its backslash (`\bs \rho`).
            if s[j] == "\\" and j + 1 < len(s):
                k = j + 1
                if s[k].isalpha():
                    while k < len(s) and s[k].isalpha():
                        k += 1
                else:
                    k += 1
                args.append(s[j:k])
                j = k
            else:
                args.append(s[j])
                j += 1
    return args, j


def expand_macros(s, macros, rounds=4):
    """Expand preamble macros (any arity) with balance-aware argument matching.

    A regex `\\edit\\{([^{}]*)\\}` cannot see `\\edit{... \\citet{k} ...}`; pandoc then
    treats \\edit as unknown and DROPS the whole argument, silently removing sentences.
    Multi-argument `\\def\\aut#1#2{...}` is just as fatal inside a display: texmath
    rejects the unknown command and pandoc escapes the whole equation as text.
    """
    for _ in range(rounds):
        changed = False
        for name, repl in macros.items():
            pat = re.compile(r"\\" + re.escape(name) + r"(?![A-Za-z])")
            n = _macro_arity(repl)
            out, pos, any_hit = [], 0, False
            for m in pat.finditer(s):
                if m.start() < pos:
                    continue
                got = _macro_args(s, m.end(), n) if n else ([], m.end())
                if got is None:
                    continue
                args, end = got
                rep = repl
                for k, a in enumerate(args, 1):
                    rep = rep.replace("#%d" % k, a)
                if _in_math(s, m.start()):
                    rep = rep.replace(EM_OPEN, "").replace(EM_CLOSE, "")
                else:
                    rep = rep.replace(EM_OPEN, "$").replace(EM_CLOSE, "$")
                # `\pi\mpl` must become `\pi M_...`: gluing a letter-leading body
                # onto a preceding control word makes `\piM`, an unknown command
                # that makes texmath drop the whole display.
                if m.start() > 0 and s[m.start() - 1].isalpha() and rep[:1].isalpha():
                    rep = " " + rep
                out.append(s[pos:m.start()])
                out.append(rep)
                pos = end
                any_hit = True
            if any_hit:
                out.append(s[pos:])
                s = "".join(out)
                changed = True
        if not changed:
            break
    return s


EM_OPEN, EM_CLOSE = "\ue000", "\ue001"


def _ensuremath_to_markers(s):
    r"""`\ensuremath{X}` is unknown to pandoc, which drops the whole group.
    Replace it with neutral markers: expand_macros turns them into `$X$` for a use
    in prose (what keeps `\nu_{e}` from reading as an underscore) and drops them
    inside math. Emitting real dollars here would flip the parity that `_in_math`
    uses, which silently turns the following prose into math."""
    out, pos = [], 0
    while True:
        i = s.find("\\ensuremath{", pos)
        if i < 0:
            out.append(s[pos:])
            return "".join(out)
        arg, end = _balanced(s, i + len("\\ensuremath"))
        if arg is None:
            out.append(s[pos:])
            return "".join(out)
        out.append(s[pos:i])
        out.append(EM_OPEN + arg + EM_CLOSE)
        pos = end


def _macro_body_fixup(v):
    # `%` at end of a definition line is TeX's line-join, but once the body is
    # spliced into prose it survives as a literal percent sign.
    v = re.sub(r"(?<!\\)%\s*\n?", "", v)
    v = _ensuremath_to_markers(v).replace("\\xspace", "")
    # `\oset[shift]{\textbf{--}}{#1}` is a hand-rolled TeX overbar built from
    # \mathop/\vbox; pandoc has no mapping for it and silently drops the symbol.
    v = re.sub(r"\\oset\s*(?:\[[^\]]*\])?\s*\{\\textbf\{\s*--\s*\}\}\s*\{", r"\\bar{", v)
    return v


_macros = {}
_macro_hdr = re.compile(r"\\(?:re)?newcommand\*?\{?\\(\w+)\}?(?:\[\d+\])?\s*")
# Hand-rolled TeX primitives (AMS sqrt sizing, rule boxes) have no pandoc mapping;
# expanding them into prose dumps `\setbox`/`\dimen` internals into the page, and
# leaving the original command (`\sqrt`) lets pandoc handle it natively.
_PRIMITIVES = re.compile(r"\\(?:mathpalette|setbox|dimen|vrule|vbox|hbox|hskip|kern|raise|lower)\b")
for m in _macro_hdr.finditer(preamble):
    pos = m.end()
    if pos >= len(preamble) or preamble[pos] != "{":
        continue
    # A regex `\{(?:[^{}]|\{[^{}]*\})*\}` stops at depth 2, which silently drops
    # every macro whose body nests twice (`\ensuremath{E_{\nu}}`); scan instead.
    body_txt, _ = _balanced(preamble, pos)
    if body_txt is not None and not _PRIMITIVES.search(body_txt):
        _macros[m.group(1)] = body_txt
# `\def\Msun{M_\odot}` is just as common as \newcommand in A&A sources; an
# unexpanded macro makes pandoc abandon the whole equation it appears in.
# Parameterized `\def\aut#1#2{...}` is worse: texmath rejects the command inside
# a display outright, so pandoc emits the whole equation as escaped text.
for m in re.finditer(r"\\def\s*\\([A-Za-z]+)\s*((?:#\d)*)\s*(?=\{)", preamble):
    body_txt, _ = _balanced(preamble, m.end())
    if body_txt is not None and not _PRIMITIVES.search(body_txt):
        _macros.setdefault(m.group(1), body_txt)
# `\DeclareMathOperator{\Tr}{Tr}` never reaches the body as text, so texmath sees an
# unknown command and pandoc escapes every display that contains it.
for m in re.finditer(r"\\DeclareMathOperator\*?\s*\{\\(\w+)\}", preamble):
    body_txt, _ = _balanced(preamble, m.end())
    if body_txt is not None:
        _macros.setdefault(m.group(1), r"\operatorname{%s}" % body_txt.strip())
for m in re.finditer(r"\\DeclarePairedDelimiter\s*\{\\(\w+)\}\s*\{([^{}]*)\}\s*\{([^{}]*)\}", preamble):
    _macros.setdefault(m.group(1), m.group(2) + "#1" + m.group(3))
# The physics package is a package-level dependency, not a preamble definition, so
# `\ket{+}` reaches texmath as an unknown control sequence and pandoc escapes the
# whole display (silently, as literal TeX text in the PDF).
for _name, _body in (
        ("ket", r"|#1\rangle"),
        ("bra", r"\langle#1|"),
        ("braket", r"\langle #1 | #2 \rangle"),
        ("ketbra", r"|#1\rangle\langle#2|"),
        ("dyad", r"|#1\rangle\langle#2|")):
    _macros.setdefault(_name, _body)
_macros = {k: _macro_body_fixup(v) for k, v in _macros.items()}
# `\blfootnote` is a hand-rolled "unnumbered footnote" wrapper (\begingroup
# \renewcommand\thefootnote{}\footnote{...}\addtocounter...\endgroup). Expanding
# it leaves the layout scaffolding in the prose, and a real Typst footnote cannot
# live inside the placed title cover (its text is dropped silently), so route the
# note through a marker and render it as the small print line it is.
def _blfootnote_to_marker(s):
    out, pos = [], 0
    while True:
        m = re.compile(r"\\blfootnote\b").search(s, pos)
        if not m:
            out.append(s[pos:])
            return "".join(out)
        arg, end = _balanced(s, m.end())
        if arg is None:
            out.append(s[pos:])
            return "".join(out)
        out.append(s[pos:m.start()])
        out.append("\n\nQQBLNOTEQQ" + arg.strip().replace("*", "\u2217") + "QQBLNENDQQ\n\n")
        pos = end
body = _blfootnote_to_marker(body)


def _despan_math(s):
    r"""`\ensuremath`-derived macro bodies carry `$` that expand_macros only strips
    when it can tell they sit in math. That check fails when the enclosing display is
    opened by a macro (`\beq`) that expands later in the same pass, and a lone `$`
    inside math makes pandoc reject the display and dump it as escaped source."""
    pat = re.compile(r"(\\begin\{(%s)\})(.*?)(\\end\{\2\})" % _MATH_ENVS, re.S)
    s = pat.sub(lambda m: m.group(1) + m.group(3).replace("$", "") + m.group(4), s)
    s = re.sub(r"\$\$(.*?)\$\$",
               lambda m: "$$" + m.group(1).replace("$", "") + "$$", s, flags=re.S)
    return re.sub(r"\\\[(.*?)\\\]",
                  lambda m: "\\[" + m.group(1).replace("$", "") + "\\]", s, flags=re.S)


body = _despan_math(expand_macros(body, _macros))
body = body.replace(EM_OPEN, "").replace(EM_CLOSE, "")
body = re.sub(r"\\(?:begingroup|endgroup)\b", "", body)
body = re.sub(r"\\(?:add|set|step|refstep)to?counter\s*\{[^{}]*\}\s*\{[^{}]*\}", "", body)
body = re.sub(r"\\(?:re)?newcommand\s*\{?\s*\\?\w+\s*\}?(?:\s*\[[^\]]*\])?\s*\{[^{}]*\}", "", body)
body = re.sub(r"\\thefootnote\b", "", body)

SWITCH = {"cal": "mathcal", "rm": "mathrm", "bf": "mathbf", "it": "mathit",
          "sf": "mathsf", "tt": "mathtt"}
_ACCENT = ("tilde|hat|bar|vec|dot|ddot")

_PHYS_BIG = r"(?:(?:\\big|\\Big|\\bigg|\\Bigg)[lrm]?)?"
_DELIMS = {"(": ")", "[": "]", "\\{": "\\}"}


def _delim_arg(s, i):
    r"""s[i] starts a delimiter `(`, `[` or `\{`; return (inner, end, open, close)."""
    for op in ("\\{", "(", "["):
        if s.startswith(op, i):
            break
    else:
        return None, i, "", ""
    cl = _DELIMS[op]
    depth, j = 1, i + len(op)
    while j < len(s):
        if s.startswith(op, j):
            depth += 1
            j += len(op)
        elif s.startswith(cl, j):
            depth -= 1
            if depth == 0:
                return s[i + len(op):j], j + len(cl), op, cl
            j += len(cl)
        else:
            j += 1
    return None, i, "", ""


def expand_physics_cmds(s):
    r"""Expand physics-package commands texmath cannot parse.

    `\qty(...)`, `\dv{f}{x}`, `\dd`, `\abs{}` etc. are not built into pandoc's
    math reader; one of them makes it abandon the whole display and emit escaped
    TeX text, which silently deletes the equation from the document.

    `\mathinner` (what many sources' `\ket` expands to) and `\textcolor` are in
    the same class: texmath rejects them and pandoc escapes the whole span.
    """
    s = re.sub(r"\\(?:mathinner|mathopen|mathclose|mathpunct|mathord|mathrel|mathop)\s*(?=\{)", "", s)
    s = re.sub(r"\\textcolor\s*\{[^{}]*\}\s*(?=\{)", "", s)
    s = re.sub(r"\\color\s*\{[^{}]*\}", "", s)
    # texmath has no `\xmapsto` / `\xhookrightarrow`; one of them makes it drop the
    # display, so map the extensible arrows onto ones it knows.
    s = re.sub(r"\\xmapsto(?![A-Za-z])", r"\\xrightarrow", s)
    s = re.sub(r"\\xhookrightarrow(?![A-Za-z])", r"\\xrightarrow", s)
    s = re.sub(r"\\xhookleftarrow(?![A-Za-z])", r"\\xleftarrow", s)
    # `\Tr` (a source macro) is not a texmath operator; `\left\[` is also invalid.
    s = re.sub(r"\\Tr(?![A-Za-z])", r"\\operatorname{Tr}", s)
    s = s.replace("\\left\\[", "\\left[").replace("\\right\\]", "\\right]")
    # `\vphantom` only reserves height and `\mathbbm` is bbm's blackboard font.
    s = re.sub(r"\\vphantom(?![A-Za-z])", r"\\phantom", s)
    # The old `\{?...\}?` form ate the closing brace of the *enclosing* group when
    # the digit was unbraced (`\bs {\mathbbm 1}_e`), leaving every brace after it
    # shifted; pandoc then failed the paragraph and the fallback split it mid-math.
    s = re.sub(r"\\mathbbm\s*\{\s*(\d+)\s*\}", r"\\mathbb{\1}", s)
    s = re.sub(r"\\mathbbm\s+(\d)", r"\\mathbb{\1}", s)
    s = re.sub(r"\\mathbbm(?![A-Za-z])", r"\\mathbb", s)
    # `\textrm{{quasi-}FDLU{\qquad}}` (a space built from nested groups) makes
    # texmath mis-count the group and reject the whole surrounding equation.
    # Flatten spacing-only groups inside text commands.
    def flat_text(s):
        out, pos = [], 0
        for m in re.finditer(r"\\(textrm|text|mathrm|textbf|textit|textsf|texttt)\s*(?=\{)", s):
            if m.start() < pos:
                continue
            body, end = _balanced(s, m.end())
            if body is None or ("\\qquad" not in body and "\\quad" not in body):
                continue
            body = re.sub(r"\{\\(?:qquad|quad)\}", " ", body)
            body = body.replace("\\qquad", "  ").replace("\\quad", " ")
            body = body.replace("{", "").replace("}", "")
            out.append(s[pos:m.start()])
            out.append("\\" + m.group(1) + "{" + body + "}")
            pos = end
        out.append(s[pos:])
        return "".join(out)
    s = flat_text(s)
    def splice(s, pat, fn):
        r"""Replace `pat` matches with fn's (replacement, consumed_end).

        The physics commands carry their arguments outside the matched span, so a
        plain re.sub leaves `{f}{x}` behind and prints the content twice.
        """
        pos = 0
        while True:
            m = pat.search(s, pos)
            if not m:
                return s
            got = fn(s, m)
            if got is None:
                pos = m.end()
                continue
            rep, end = got
            s = s[:m.start()] + rep + s[end:]

    def qty(s, m):
        inner, end, op, cl = _delim_arg(s, m.end())
        if inner is None:
            return None
        return "\\left" + op + inner + "\\right" + cl, end
    s = splice(s, re.compile(r"\\qty\*?\s*" + _PHYS_BIG + r"\s*"), qty)

    def deriv(cmd, d):
        def fn(s, m):
            j = m.end()
            n = ""
            if j < len(s) and s[j] == "[":
                k = s.find("]", j)
                if k < 0:
                    return None
                n, j = s[j + 1:k].strip(), k + 1
            while j < len(s) and s[j] == " ":
                j += 1
            if j >= len(s) or s[j] != "{":
                return None
            a, j = _balanced(s, j)
            if a is None:
                return None
            while j < len(s) and s[j] == " ":
                j += 1
            sup = ("^{" + n + "}") if n else ""
            if j < len(s) and s[j] == "{":
                b, j = _balanced(s, j)
                if b is None:
                    return None
                num = d + sup + " " + a
                den = d + sup + " " + b
            else:
                num, den = d + sup, d + sup + " " + a
            return "\\frac{" + num + "}{" + den + "}", j
        return fn
    for cmd, d in (("dv", "d"), ("pdv", "\\partial"), ("ddv", "\\mathrm{d}")):
        s = splice(s, re.compile(r"\\" + cmd + r"(?![A-Za-z])"), deriv(cmd, d))

    def abslike(s, m):
        inner, end = _balanced(s, m.end())
        if inner is None:
            return None
        bars = {"abs": "|", "norm": "\\|", "order": None}[m.group(1)]
        if bars is None:
            return "\\mathcal{O}\\left(" + inner + "\\right)", end
        return "\\left" + bars + inner + "\\right" + bars, end
    s = splice(s, re.compile(r"\\(abs|norm|order)(?![A-Za-z])\s*"), abslike)

    def comm(s, m):
        a, j = _balanced(s, m.end())
        if a is None:
            return None
        k = j
        while k < len(s) and s[k] == " ":
            k += 1
        b, j2 = _balanced(s, k) if k < len(s) and s[k] == "{" else (None, k)
        if b is None:
            return None
        o, c = ("[", "]") if m.group(1) == "comm" else ("\\{", "\\}")
        return "\\left" + o + a + "," + b + "\\right" + c, j2
    s = splice(s, re.compile(r"\\(comm|acomm)(?![A-Za-z])\s*"), comm)
    s = re.sub(r"\\(vb|va|vu|vq)(?![A-Za-z])\s*", r"\\mathbf", s)
    for a, b in ((r"\\dd", r"\\mathrm{d}"), (r"\\grad", r"\\nabla"),
                 (r"\\laplacian", r"\\nabla^2"), (r"\\curl", r"\\nabla\\times")):
        s = re.sub(a + r"(?![A-Za-z])", b, s)
    return s


def _arrays_to_cases(s):
    r"""`\left\{\begin{array}{ll}...\end{array}\right.` -> `\begin{cases}...`.

    texmath cannot parse a bare `array` inside a display, and pandoc then escapes
    the whole equation to literal text (`\left` becomes `"left"`), losing it.
    """
    out = []
    i = 0
    while True:
        m = re.compile(r"\\left\s*\\\{\s*\\begin\{array\}\{[lcr|]*\}").search(s, i)
        if not m:
            out.append(s[i:])
            return "".join(out)
        endm = re.compile(r"\\end\{array\}\s*\\right\s*\.").search(s, m.end())
        if not endm:
            out.append(s[i:])
            return "".join(out)
        out.append(s[i:m.start()])
        out.append("\\begin{cases}" + s[m.end():endm.start()] + "\\end{cases}")
        i = endm.end()


def rewrite_over(s):
    r"""`{a \over b}` is plain-TeX, and texmath rejects `\over` outright.

    Any display containing it is dropped back to escaped text, deleting the whole
    equation. Rebuild the enclosing group as `\frac{a}{b}` at any nesting depth.
    """
    while True:
        # `\overline` and `\overbrace` start with `\over` but are ordinary commands;
        # matching that prefix would destroy every overlined symbol.
        om = re.compile(r"\\over(?![A-Za-z])").search(s)
        if not om:
            return s
        i = om.start()
        depth, start = 0, None
        for j in range(i - 1, -1, -1):
            if s[j] == "}":
                depth += 1
            elif s[j] == "{":
                if depth == 0:
                    start = j
                    break
                depth -= 1
        depth, end = 0, None
        for j in range(i + 5, len(s)):
            if s[j] == "{":
                depth += 1
            elif s[j] == "}":
                if depth == 0:
                    end = j
                    break
                depth -= 1
        if start is None or end is None:
            s = s[:i] + "\\div" + s[i + 5:]
            continue
        num = s[start + 1:i].strip()
        den = s[i + 5:end].strip()
        s = s[:start] + "\\frac{" + num + "}{" + den + "}" + s[end + 1:]


def normalize_math_macros(s):
    r"""Rewrite TeX math switches pandoc cannot parse.

    `{\cal L}`, `{\rm CS}` and `\tilde F` make pandoc's LaTeX reader bail out: it
    drops the whole span back to escaped TeX, which then renders as literal text.
    Turning them into `\mathcal{L}` / `\mathrm{CS}` / `\tilde{F}` before pandoc
    fixes most physics papers, whose preambles are full of the old switch syntax.
    """
    s = rewrite_over(s)
    s = _arrays_to_cases(s)
    s = expand_physics_cmds(s)
    def group(m):
        # keep the surrounding braces: `{\rm pc}` is often a braced argument
        # (`\frac{r}{{\rm pc}}`), and dropping them changes the argument boundary
        return "{\\" + SWITCH[m.group(1).lstrip("\\")] + "{" + m.group(2).strip() + "}}"
    # `{\rm\gamma,iso}`: a switch directly followed by a control sequence
    s = re.sub(r"\{(\\cal|\\rm|\\bf|\\it|\\sf|\\tt)\s*(\\[A-Za-z]+[^{}]*)\}",
               lambda m: "{\\" + SWITCH[m.group(1).lstrip("\\")] + "{" + m.group(2) + "}}", s)
    # `\rm\,G`: the switch is redundant once a spacing command follows
    s = re.sub(r"\\(cal|rm|bf|it|sf|tt)(?=\s*\\[,;:!])", "", s)
    s = re.sub(r"\{(\\cal|\\rm|\\bf|\\it|\\sf|\\tt)\s+([^{}]*)\}", group, s)
    s = re.sub(r"\\(cal|rm|bf|it|sf|tt)\s*\{([^{}]*)\}",
               lambda m: "\\" + SWITCH[m.group(1)] + "{" + m.group(2) + "}", s)
    # `\rm flat` is a switch applying to the whole following letter run: wrapping
    # only the first letter leaves "lat" as three italic variables.
    s = re.sub(r"\\(cal|rm|bf|it|sf|tt)\s+([A-Za-z]+)",
               lambda m: "\\" + SWITCH[m.group(1)] + "{" + m.group(2) + "}", s)
    # `\textsc{nicer}` inside a display makes pandoc abandon the whole equation
    s = re.sub(r"\\text(?:sc|sf|sl|tt)\{([^{}]*)\}", r"\\mathrm{\1}", s)
    s = re.sub(r"\\(%s)\s+([A-Za-z0-9])" % _ACCENT,
               lambda m: "\\" + m.group(1) + "{" + m.group(2) + "}", s)
    # `\underset{G}{\rm min}` becomes `\underset{G}\mathrm{min}` once the switch
    # rewrite runs. pandoc only accepts a braced group as the second argument and
    # gives up on the whole display when it finds a bare control sequence, so put
    # the rewritten argument back in braces.
    s = re.sub(r"\\(underset|overset|stackrel)(\s*\{[^{}]*\})\s*"
               r"(\\(?:mathrm|mathbf|mathcal|mathit|mathsf|mathtt)\{[^{}]*\})",
               r"\\\1\2{\3}", s)
    # `\vphantom` content is invisible by definition, but pandoc's math reader
    # rejects it and escapes the whole display to literal TeX. Drop the argument
    # (it nests braces arbitrarily deep, so count them).
    for cmd in ("vphantom", "hphantom", "phantom"):
        while True:
            m = re.search(r"\\" + cmd + r"\s*(?=\{)", s)
            if not m:
                break
            arg, end = _balanced(s, m.end())
            if arg is None:
                break
            s = s[:m.start()] + s[end:]
    # A span that held nothing but a phantom is now empty; `$ $` alone would open
    # and close display math around the rest of the paragraph.
    s = re.sub(r"\$\s*\$", "", s)
    return s


# Outside math these declarations are text switches (`{\it The Fermi ...}`).
# Rewriting them to \mathit there makes pandoc drop the whole argument, since
# \mathit is unknown in text mode.
TEXT_SWITCH = {"it": "textit", "bf": "textbf", "rm": "textrm",
               "sf": "textsf", "tt": "texttt", "em": "emph", "sl": "textsl"}


def normalize_text_switches(s):
    def group(m):
        return "\\" + TEXT_SWITCH[m.group(1).lstrip("\\")] + "{" + m.group(2).strip() + "}"
    s = re.sub(r"\{(\\it|\\bf|\\rm|\\sf|\\tt|\\em|\\sl)\s+([^{}]*)\}", group, s)
    s = re.sub(r"\\(it|bf|rm|sf|tt|em|sl)\s*\{([^{}]*)\}",
               lambda m: "\\" + TEXT_SWITCH[m.group(1)] + "{" + m.group(2) + "}", s)
    s = re.sub(r"\\(it|bf|rm|sf|tt|em|sl)\s+([A-Za-z0-9])",
               lambda m: "\\" + TEXT_SWITCH[m.group(1)] + "{" + m.group(2) + "}", s)
    return s


MATH_TOKEN = re.compile(
    r"(\\begin\{(?:equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?|displaymath|math)\}.*?"
    r"\\end\{(?:equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?|displaymath|math)\}"
    r"|\\\[.*?\\\]|(?<!\\)\$\$.*?(?<!\\)\$\$|(?<!\\)\$[^$]*\$)", re.S)


def normalize_switches_by_mode(s):
    out, pos = [], 0
    for m in MATH_TOKEN.finditer(s):
        out.append(normalize_text_switches(s[pos:m.start()]))
        out.append(normalize_math_macros(m.group(0)))
        pos = m.end()
    out.append(normalize_text_switches(s[pos:]))
    return "".join(out)


body = normalize_switches_by_mode(body)

# ============ metadata ============
def meta(pat, *ss):
    for s in ss:
        m = re.search(pat, s, re.S)
        if m:
            return m.group(1).strip()
    return ""
def bal_group(s, cmd):
    """Argument of `cmd{...}` counted with brace depth (titles/authors contain braces).

    The command name must end here: `\\title` alone would otherwise match
    `\\titleformat{\\section}` in a preamble and return `\\section` as the title.
    """
    m = re.search(re.escape(cmd) + r"(?![A-Za-z@])", s)
    if not m:
        return ""
    j = s.find("{", m.end())
    if j < 0:
        return ""
    depth = 0
    for k in range(j, len(s)):
        c = s[k]
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return s[j + 1:k]
    return ""


def all_groups(s, cmd):
    out = []
    for m in re.finditer(re.escape(cmd) + r"(?![A-Za-z@])", s):
        j = s.find("{", m.end())
        if j < 0:
            continue
        depth, k = 0, j
        while k < len(s):
            c = s[k]
            if c == "\\":
                k += 2
                continue
            if c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
                if depth == 0:
                    out.append((m.start(), s[j + 1:k]))
                    break
            k += 1
    return out

title = bal_group(preamble, r"\title") or bal_group(body, r"\title") or "Untitled"
author = bal_group(preamble, r"\author") or bal_group(body, r"\author")
date = bal_group(preamble, r"\date")
ACCENTS = {"'": dict(zip("aeiouycn", "áéíóúýćń")),
           '"': dict(zip("aeiouy", "äëïöüÿ")),
           "`": dict(zip("aeiou", "àèìòù")),
           "^": dict(zip("aeiou", "âêîôû")),
           "~": dict(a="ã", e="ẽ", i="ĩ", o="õ", u="ũ", n="ñ"),
           ".": dict(z="ż", c="ċ", e="ė", g="ġ"),
           "=": dict(zip("aeiou", "āēīōū"))}
def deaccent(s):
    return re.sub(r"\\(['\"`\^~.=])\s*\{?([A-Za-z])\}?",
                  lambda m: ACCENTS.get(m.group(1), {}).get(m.group(2), m.group(2)), s)

def fmt_author(raw):
    s = re.sub(r"\\thanks\{(?:[^{}]|\{[^{}]*\})*\}", "", raw)
    s = re.sub(r"\\and\b", ", ", s)
    s = deaccent(s)
    s = re.sub(r"\$?\^\{([^{}]*)\}\$?", r"#super[\1]", s)
    # `$^*$` / `\ast` marks the corresponding author; a bare `*` in markup opens
    # strong emphasis and never closes, and `^*` would print a literal caret.
    s = re.sub(r"\$?\^\s*(?:\*|\\ast)\$?", r"#super[\\*]", s)
    s = re.sub(r"[\u00a0~]", " ", s)
    s = re.sub(r"[{}$]", "", s)
    s = re.sub(r"(?<!\\)\*", r"\\*", s)
    s = re.sub(r"\s*,\s*", ", ", re.sub(r"\s+", " ", s)).strip()
    return s

def plain(s):
    # Any \textXX switch must go as a unit: stripping only the backslash turns
    # `\textsl{NICER}` into the literal word "textslNICER" in the title.
    return re.sub(r"\\(?:text[a-z]{2}|thanks|footnote|and|emph|mbox|hbox|noindent)\b\*?", " ",
                  re.sub(r"[{}$\\&^_%#]", lambda m: "" if m.group(0) not in "&_" else "\\" + m.group(0), s)).strip()


def rich_title(latex):
    """Render the LaTeX title block as Typst markup, keeping math and emphasis.

    `plain()` drops every `$...$` group, so a title like
    `$t$-$J$-$J_\\perp$ ... $\\rm La_3Ni_2O_7$` used to come out as
    "t-J-J_perp ... La_3Ni_2O_7" with literal underscores.
    """
    s = normalize_text_switches(expand_macros(latex, _macros))
    s = normalize_math_macros(s)
    tf = tempfile.NamedTemporaryFile("w", suffix=".tex", delete=False, dir=WORK, encoding="utf-8")
    tf.write(s)
    tf.close()
    of = tf.name + ".typ"
    try:
        r = run(["pandoc", tf.name, "-f", "latex", "-t", "typst", "--wrap=none", "-o", of])
        if r.returncode == 0 and os.path.exists(of):
            out = read(of).strip()
            if out:
                return out
    finally:
        os.unlink(tf.name)
        if os.path.exists(of):
            os.unlink(of)
    return plain(latex)
def aff_text(x):
    x = re.sub(r"\\(?:vphantom|hphantom|phantom)\s*\{(?:[^{}]|\{[^{}]*\})*\}", "", x)
    x = deaccent(x)
    x = re.sub(r"\\[a-zA-Z]+\*?\s*", " ", x)
    x = re.sub(r"[{}$\\]", "", x).replace("~", " ")
    x = re.sub(r"\s+", " ", x)
    return re.sub(r"[#_&%]", lambda m: "\\" + m.group(0), x).strip(" ,;")

aff_m = re.search(r"\\begin\{affiliations\}(.*?)\\end\{affiliations\}", body, re.S)
aff_p, authors_p = "", ""
if aff_m:
    items = [deaccent(x).strip() for x in re.split(r"\\item\b", aff_m.group(1)) if x.strip()]
    items = [re.sub(r"\s+", " ", re.sub(r"[{}$\\]", "", x)) for x in items]
    aff_p = "\n".join("  #text(9pt)[#super[%d] %s] \\" % (i + 1, x)
                      for i, x in enumerate(items))
    body = body.replace(aff_m.group(0), "")
else:
    # REVTeX: `\author` lines followed by `\affiliation`; an affiliation applies
    # to every author listed since the previous one.
    events = sorted([(p, "a", g) for p, g in all_groups(body, r"\author")] +
                    [(p, "f", g) for p, g in all_groups(body, r"\affiliation")])
    if events:
        affs, auth_rows, pending = [], [], []
        for _, kind, g in events:
            if kind == "a":
                pending.append(g)
            else:
                txt = aff_text(g)
                if not txt:
                    continue
                if txt not in affs:
                    affs.append(txt)
                idx = affs.index(txt) + 1
                for a in pending:
                    auth_rows.append((a, [idx]))
                pending = []
        for a in pending:
            auth_rows.append((a, []))
        if auth_rows:
            authors_p = ", ".join(
                fmt_author(a) + "".join("#super[%d]" % i for i in sups)
                for a, sups in auth_rows)[:1600]
            if affs:
                aff_p = "\n".join("  #text(9pt)[#super[%d] %s] \\" % (i + 1, x)
                                  for i, x in enumerate(affs))
title_p = rich_title(title)[:600]
author_p = authors_p or fmt_author(author)[:600]
# `\mbox{\!\!...}` is a title-spacing hack, not content.
title_p = re.sub(r"\b(?:mbox|hbox|hspace\*?)\b", " ", title_p)
title_p = re.sub(r"\!", "", title_p)
title_p = re.sub(r"\s+", " ", title_p).strip()
# `\date{\today}` / `\formatdate{\day}...` expand to build-dependent text we cannot
# evaluate; a rendered "1.15" in the title block is worse than no date at all.
if re.search(r"\\[A-Za-z]", date):
    date = ""

# ============ pandoc (chunked, fault-tolerant) ============
def pad_latex(text):
    """Close unbalanced braces and environments so pandoc can parse a truncated chunk."""
    envs, depth, prev = [], 0, ""
    i = 0
    while i < len(text):
        ch = text[i]
        if ch == "\\" and i + 1 < len(text):
            m = re.match(r"\\(begin|end)\{([^{}]*)\}", text[i:])
            if m:
                if m.group(1) == "begin":
                    envs.append(m.group(2))
                elif envs and envs[-1] == m.group(2):
                    envs.pop()
                i += m.end(); continue
            i += 2; prev = "\\"; continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth = max(0, depth - 1)
        i += 1; prev = ch
    return text + "}" * depth + "".join("\\end{%s}" % e for e in reversed(envs))

def pandoc_chunk(text):
    # a literal `@` in prose (`ReSearch@University`) reads as a citation key to
    # pandoc; `\@` is silently dropped, so swap it for a token and restore after.
    at_text = re.sub(r"(?<=[A-Za-z])@(?=[A-Z][a-z])", "QQATQQ", text)
    text = at_text
    if os.environ.get("DUMPCHUNKS"):
        n = len(glob.glob(os.path.join(WORK, "chunk*.tex")))
        open(os.path.join(WORK, "chunk%04d.tex" % n), "w", encoding="utf-8").write(text)
    tf = tempfile.NamedTemporaryFile("w", suffix=".tex", delete=False, dir=WORK, encoding="utf-8")
    tf.write(text); tf.close()
    of = tf.name + ".typ"
    r = run(["pandoc", tf.name, "-f", "latex", "-t", "typst", "--wrap=none", "-o", of])
    out = None
    if r.returncode != 0:
        # retry with braces/environments closed, and with macros left raw
        os.unlink(tf.name)
        tf = tempfile.NamedTemporaryFile("w", suffix=".tex", delete=False, dir=WORK, encoding="utf-8")
        tf.write(pad_latex(text)); tf.close()
        of2 = tf.name + ".typ"
        r2 = run(["pandoc", tf.name, "-f", "latex", "-t", "typst", "--wrap=none", "-o", of2])
        if r2.returncode == 0 and os.path.exists(of2):
            out = read(of2)
        os.unlink(tf.name)
        if os.path.exists(of2):
            os.unlink(of2)
        if out is not None:
            return out.replace("QQATQQ", "\\@")
    if r.returncode == 0 and os.path.exists(of):
        out = read(of)
    for f in (tf.name, of):
        try:
            os.unlink(f)
        except OSError:
            pass
    return out.replace("QQATQQ", "\\@") if out else out

def plain_fallback(p):
    """Last resort: readable Typst text, math kept in $...$, specials escaped outside math."""
    def conv_math(m):
        t = _math_typst(m.group(1))
        if not t:
            t = re.sub(r"\\[a-zA-Z]+\*?", " ", m.group(1))
            t = t.replace("{", "").replace("}", "")
        return "$" + t + "$"

    def esc(t):
        # Math was already spliced back above; escaping `_` there would turn a
        # subscript into a literal underscore and break the span.
        t = re.sub(r"\\[a-zA-Z]+\*?(\[[^\]]*\])?", " ", t)
        return re.sub(r"([#<>@_~])", r"\\\1", re.sub(r"[{}\\]{2,}", " ", t).replace("\\\\", "\\"))

    parts, pos = [], 0
    for m in re.finditer(r"\$([^$]*)\$", p):
        parts.append(esc(p[pos:m.start()]))
        parts.append(conv_math(m))
        pos = m.end()
    parts.append(esc(p[pos:]))
    return "\n" + "".join(parts).replace("{", "").replace("}", "") + "\n"

def _rm_to_mathrm(m):
    """`$\\rm s$` is a TeX declaration: pandoc leaves it as raw TeX. Wrap the rest of the
    span. `\\rm` inside the span would otherwise print as the letters `m s`."""
    s = m.group(1)
    if "\\rm" not in s and "\\bf" not in s:
        return m.group(0)
    for cmd, f in (("\\rm", "mathrm"), ("\\bf", "mathbf")):
        if cmd in s:
            pre, post = s.split(cmd, 1)
            s = pre + "\\%s{%s}" % (f, post.strip())
    return "$" + s + "$"


FLOAT_ENV = re.compile(r"\\begin\{(table\*?|figure\*?|longtable|tabular\*?)\}")


TAB_BEGIN = re.compile(r"\\begin\{tabular\}(\[[^\]]*\])?\s*\{")
TAB_END = "\\end{tabular}"


def _brace_end(s, i):
    d = 0
    for j in range(i, len(s)):
        if s[j] == "{":
            d += 1
        elif s[j] == "}":
            d -= 1
            if d == 0:
                return j + 1
    return -1


def flatten_nested_tabulars(src):
    # A tabular nested in a cell is only there to break lines (`\begin{tabular}[c]
    # {@{}c@{}}A\\ B\end{tabular}`), but pandoc turns every tabular it meets into a
    # figure, so each such cell becomes a figure carrying the outer caption and
    # label: one table becomes twenty tables and the label is defined repeatedly.
    # Join the inner rows into plain cell text before pandoc sees it.
    for _ in range(6):
        begins = []
        for m in TAB_BEGIN.finditer(src):
            se = _brace_end(src, m.end() - 1)
            if se > 0:
                begins.append((m.start(), se))
        events = sorted([(p, 0) for p, _ in begins] +
                        [(m.start(), 1) for m in re.finditer(re.escape(TAB_END), src)])
        stack, pairs = [], []
        for pos, kind in events:
            if kind == 0:
                stack.append(pos)
            elif stack:
                pairs.append((stack.pop(), pos))
        nested = [(b, e) for b, e in pairs
                  if any(b0 < b and e < e0 for b0, e0 in pairs)]
        inner = [(b, e) for b, e in nested
                 if not any(b < b2 < e for b2, _ in begins)]
        if not inner:
            break
        for b, e in sorted(inner, reverse=True):
            se = next(x for bb, x in begins if bb == b)
            body = src[se:e]
            body = re.sub(r"\\(?:hline|toprule|midrule|bottomrule|cline\{[^}]*\})", " ", body)
            body = re.sub(r"\s*\\\\\s*", " ", body)
            body = re.sub(r"\s+", " ", body.replace("&", " ")).strip()
            src = src[:b] + "{" + body + "}" + src[e + len(TAB_END):]
    return src


def longtable_to_table(src):
    """pandoc has no longtable reader; it dumps the rows as raw `&`/`\\\\` text.

    Rewrite the environment as `table`+`tabular` (which pandoc does parse), keeping
    only the first page's header and dropping the repeated continuation blocks.
    """
    m = re.search(r"\\begin\{longtable\}(\{[^{}]*\})", src)
    if not m:
        return src
    spec = m.group(1)
    cap = bal_group(src, "\\caption")
    labels = re.findall(r"\\label\{([^{}]*)\}", src)
    em = re.search(r"\\end\{longtable\}", src[m.end():])
    body = src[m.end():m.end() + em.start()] if em else src[m.end():]
    if cap:
        body = body.replace("\\caption{%s}" % cap, "", 1)
    body = re.sub(r"\\label\{[^{}]*\}", "", body)
    body = re.sub(r"\\endfirsthead.*?\\endlastfoot", "", body, flags=re.S)
    body = re.sub(r"\\(?:endhead|endfirsthead|endfoot|endlastfoot)\b", "", body)
    body = body.replace("\\hline\\hline", "\\hline")
    body = re.sub(r"\\(?:newpage|clearpage|pagebreak)\b", "", body)
    body = re.sub(r"^\s*\\\\", "", body)
    labs = "".join("\n\\label{%s}" % l for l in labels)
    return ("\\begin{table}\n\\caption{%s}%s\n\\begin{tabular}%s\n%s\n\\end{tabular}\n\\end{table}\n"
            % (cap, labs, spec, body))


def _strip_dup_caption_labels(out):
    """`\\caption{...\\label{x}}` comes back with `<x>` both inside the caption text
    and as a standalone label; the caption copy prints as text and duplicates it."""
    spans = []
    for m in re.finditer(r"caption:\s*\[", out):
        i, d = m.end() - 1, 0
        for j in range(i, len(out)):
            if out[j] == "[":
                d += 1
            elif out[j] == "]":
                d -= 1
                if d == 0:
                    spans.append((i, j))
                    break
    if not spans:
        return out
    def inside(p):
        return any(a <= p <= b for a, b in spans)
    outside = {m.group(1) for m in re.finditer(r"<([A-Za-z][\w:.\-]*)>", out)
               if not inside(m.start())}
    return re.sub(r"\s*<([A-Za-z][\w:.\-]*)>",
                  lambda m: "" if m.group(1) in outside and inside(m.start()) else m.group(0),
                  out)


def convert_float(src):
    # pandoc's LaTeX reader drops the caption of a *starred* float env
    src = longtable_to_table(src)
    src = re.sub(r"\\begin\{(table|figure|tabular)\*\}", r"\\begin{\1}", src)
    src = re.sub(r"\\end\{(table|figure|tabular)\*\}", r"\\end{\1}", src)
    src = flatten_nested_tabulars(src)
    # pandoc drops the size switches, so a 12-column `\tiny` table is re-set at body
    # size and its columns collide. The size the author chose is part of the layout.
    size = next((pt for cmd, pt in (("tiny", "5pt"), ("scriptsize", "7pt"),
                                    ("footnotesize", "8pt"), ("small", "9pt"))
                 if re.search(r"\\" + cmd + r"\b", src)), None)
    # `\centering` makes pandoc's reader swallow the caption; `\arraystretch` is noise
    src = re.sub(r"\\centering\b", "", src)
    src = re.sub(r"\\renewcommand\s*\{?\\arraystretch\}?\s*\{[^{}]*\}", "", src)
    # partial rules carry no row data; pandoc prints the cline span as text
    src = re.sub(r"\\cline\{[^}]*\}|\\cmidrule(?:\([^)]*\))?\{[^}]*\}(?:\[[^\]]*\])?", "", src)
    src = re.sub(r"\\(?:small|footnotesize|scriptsize|tiny|large|Large)\b", "", src)
    src = re.sub(r"\$([^$]*)\$", _rm_to_mathrm, src)
    out = pandoc_chunk(src)
    if out is None:
        return plain_fallback(re.sub(r"\\rm\b|\\bf\b", " ", src))
    out = _strip_dup_caption_labels(out)
    # pandoc puts the float in `#block[...]`, sometimes nested, and each closer may
    # carry a label. A label on a block cannot be cross-referenced ("cannot reference
    # block"), and a leftover closer prints a stray bracket; unwrap every opener, drop
    # closer-only lines and move their labels after the figure content.
    labels = re.findall(r"<([A-Za-z][\w:.\-]*)>", out)
    # pandoc hangs a table's `\label` on the block-closer line as `] #label("x")`;
    # `#<x>` is not valid, and a label after a blank line attaches to nothing.
    out = re.sub(r"(?m)^[ \t]*\\?\][ \t]*#label\(\"([^\"]+)\"\)[ \t]*$",
                 lambda m: "<" + re.sub(r"[^\w:.\-]", "-", m.group(1)) + ">", out)
    out = re.sub(r"\A(?:\s*#block\[\s*\n)+", "", out)
    # Only column-0 closers belong to the wrapper; a caption's `]` is indented, and
    # deleting it would leave `caption: [` unclosed.
    out = re.sub(r"(?m)^\](?:[ \t]*<[A-Za-z][\w:.\-]*>[ \t]*)*$", "", out)
    out = out.rstrip()
    for k in labels:
        if "<" + k + ">" not in out:
            out += "\n<" + k + ">"
    out += "\n"
    i = out.find("#figure(")
    cap = out.find(", caption:", i) if i >= 0 else -1
    if i >= 0 and cap > 0:
        body = out[i + len("#figure("):cap].strip()
        tail = out[cap:]
        # A figure never breaks, so a table taller than the text block is silently cut
        # at the page boundary and its remaining rows are lost. Estimate the height
        # from the text that actually has to wrap: a row is as tall as its longest
        # cell, and narrow columns hold few characters. Row counts alone miss tables
        # whose cells are paragraphs (16 rows can still be a full page).
        rows_src = [r for r in re.split(r"\\\\", src) if r.strip()]
        coln = max((r.count("&") + 1 for r in rows_src), default=1)
        pt = int(size[:-2]) if size else 10.5
        cpl = max(4, int(58 / coln * 10.5 / pt))
        est = 0
        for r in rows_src:
            longest = max(len(re.sub(r"\\[A-Za-z]+|[{}$]", "", c))
                          for c in r.split("&"))
            est += max(1, longest // cpl + 1)
        line = {"5pt": 0.33, "7pt": 0.38, "8pt": 0.40, "9pt": 0.42}.get(size, 0.45)
        if est * line + 2 > 21.5:
            if not body.startswith("#"):
                body = "#" + body
            if size:
                body = "#text(size: %s)[%s]" % (size, body)
            out = "#figure([]" + tail + "\n\n" + body + "\n"
        elif size:
            out = "#figure(text(size: %s, %s)" % (size, body) + tail
    # A `table*` float can come back as `#block[ <label> #block[ ... ] ]`; the inner
    # closers survive as a bare `\]` plus a repeat of the label, which prints a literal
    # bracket. Strip the closers and keep one label per label-only line (labels inside
    # `#link(<...>)` or `@<...>` must never be touched).
    out = re.sub(r"(?m)^[ \t]*\\\][ \t]*", "", out)
    out = re.sub(r"(?m)^[ \t]*((?:<[A-Za-z][\w:.\-]*>[ \t]*)+)[ \t]*$",
                 lambda m: m.group(1).split()[0] + "\n", out)
    return out


CASES_ENV = re.compile(r"\\begin\{(cases|array)\}(\{[^}]*\})?(.*?)\\end\{\1\}", re.S)
DISPLAY_ENV = re.compile(r"\\begin\{(equation\*?|displaymath)\}(.*?)\\end\{\1\}", re.S)


def _math_typst(tex):
    tex = rewrite_over(tex)
    tex = re.sub(r"\\(?:left|right|big|Big|bigg|Bigg)[lr]?\s*([\[\](){}|.])",
                 lambda m: "" if m.group(1) == "." else m.group(1), tex)
    out = pandoc_chunk("$" + tex + "$")
    if not out:
        return None
    m = re.fullmatch(r"\s*\$(.*)\$\s*", out, re.S)
    if not m:
        return None
    t = m.group(1).strip()
    # pandoc's writer escapes balanced delimiters as `\(` ... `\)` and writes `\/`
    # for a literal slash. These fragments are spliced back as final Typst, where
    # `\(` opens an unbalanced group, so undo the escaping here.
    t = t.replace("\\(", "(").replace("\\)", ")")
    t = t.replace("\\[", "[").replace("\\]", "]")
    t = t.replace("\\/", "/").replace("dot.circle", "\u2299")
    t = re.sub(r"\bupright\(([A-Za-z](?: [A-Za-z])*)\)",
               lambda x: 'upright("%s")' % x.group(1).replace(" ", ""), t)
    return t


def _split_top(s, sep=","):
    parts, cur, depth = [], "", 0
    for ch in s:
        if ch in "{([":
            depth += 1
        elif ch in "})]":
            depth -= 1
        if ch == sep and depth == 0:
            parts.append(cur)
            cur = ""
        else:
            cur += ch
    parts.append(cur)
    return parts


CASE_SLOTS = {}


def rewrite_cases_displays(s):
    r"""pandoc cannot read `\begin{array}`/`cases` inside display math: it drops
    the body into a broken raw block. Emit Typst `cases(...)` ourselves.

    The emitted math is final Typst, so it cannot be handed back to pandoc: the
    writer escapes `$`, `_` and `\` and the equation becomes literal text. Park each
    block behind a marker and splice it in after the paragraph has been converted.
    """
    def conv_disp(m):
        inner = m.group(2)
        if not CASES_ENV.search(inner):
            return m.group(0)
        label = ""
        lm = re.search(r"\\label\{([^}]*)\}", inner)
        if lm:
            label = " <%s>" % lm.group(1)
            inner = inner.replace(lm.group(0), "")
        em = CASES_ENV.search(inner)
        if not em:
            return m.group(0)
        pre, post = inner[:em.start()], inner[em.end():]
        # The array usually sits inside `aligned` (the `\bea` macro). pandoc needs
        # the wrapper itself, but these fragments are converted standalone, where an
        # unmatched `\begin{aligned}` makes it give up on the math.
        pre = re.sub(r"\\begin\{(?:aligned|split|gathered)\}|\\end\{(?:aligned|split|gathered)\}", "", pre)
        post = re.sub(r"\\begin\{(?:aligned|split|gathered)\}|\\end\{(?:aligned|split|gathered)\}", "", post)
        # `cases` always draws the left brace; `array` only when the author did.
        braced = em.group(1) == "cases" or "\\left\\{" in pre
        pre = re.sub(r"\\left\\\{|\\right\.|\\left\.", "", pre)
        post = re.sub(r"\\left\\\{|\\right\.|\\left\.|\\right\\\}", "", post)
        # `\\[1mm]` is a row break plus vertical spacing, not a display-math opener.
        rows = [r.strip() for r in re.split(r"\\\\\s*(?:\[[^\]]*\])?", em.group(3))
                if r.strip()]
        trows = []
        for r in rows:
            tparts = []
            for c in r.split("&"):
                c = c.strip()
                if braced:
                    halves = [_math_typst(h.strip()) for h in _split_top(c, ",")]
                    if all(halves):
                        tparts.append(" & ".join(halves))
                        continue
                t = _math_typst(c)
                tparts.append(t if t is not None else c)
            trows.append(" & ".join(tparts))
        pre_t = _math_typst(pre.strip()) if pre.strip() else ""
        if pre_t is None:
            pre_t = pre.strip()
        if braced:
            math = "$ " + pre_t + " cases(\n    " + ",\n    ".join(trows) + "\n  )"
        else:
            math = "$ " + pre_t + " " + " \\\n    ".join("& " + t.lstrip("& ") for t in trows)
        post_s = post.strip(" ,")
        if post_s:
            pt = _math_typst(post_s)
            math += " " + (pt if pt is not None else post_s)
        key = str(len(CASE_SLOTS))
        CASE_SLOTS[key] = math.rstrip() + " $" + label
        return " ZZMATH" + key + "ZZ "
    return DISPLAY_ENV.sub(conv_disp, s)


LIST_BEGIN = re.compile(r"\\begin\{(itemize|enumerate|description)\}")
LIST_END = re.compile(r"\\end\{(itemize|enumerate|description)\}")


def collapse_list_blanks(text):
    # The paragraph split below cuts a list at its first blank line; pandoc then sees
    # an orphaned `\end{itemize}` on its own and prints the literal word "ditemize".
    # Lists are single pandoc chunks, so drop blank lines while inside one.
    out, depth = [], 0
    for line in text.split("\n"):
        if depth > 0 and not line.strip():
            continue
        out.append(line)
        depth = max(0, depth + len(LIST_BEGIN.findall(line)) - len(LIST_END.findall(line)))
    return "\n".join(out)


_FOOT_DISPLAY = re.compile(
    r"\\begin\{(equation\*?|align\*?|gather\*?|multline\*?|displaymath)\}(.*?)"
    r"\\end\{\1\}", re.S)


def flatten_footnote_displays(text):
    r"""Pandoc closes a footnote at a display inside it and dumps the rest as body.

    A display in a footnote becomes inline math so the whole note survives.
    """
    def flat(m):
        b = re.sub(r"\\label\{[^}]*\}", "", m.group(2))
        b = re.sub(r"\\begin\{(?:aligned|split|gathered)\}|\\end\{(?:aligned|split|gathered)\}", "", b)
        b = b.replace("&", "").replace("\\\\", " ").strip()
        return "$" + b + "$"
    out, pos = [], 0
    while True:
        i = text.find("\\footnote{", pos)
        if i < 0:
            out.append(text[pos:])
            return "".join(out)
        inner, end = _balanced(text, i + len("\\footnote"))
        if inner is None:
            out.append(text[pos:i + len("\\footnote{")])
            pos = i + len("\\footnote{")
            continue
        out.append(text[pos:i])
        out.append("\\footnote{" + _FOOT_DISPLAY.sub(flat, inner) + "}")
        pos = end


def theorem_envs(preamble):
    """env -> (title, family) for every \\newtheorem declaration in the preamble."""
    decl = {}
    for m in re.finditer(r"\\newtheorem(\*?)\s*\{(\w+)\}\s*(?:\[(\w+)\])?\s*\{([^{}]*)\}", preamble):
        star, env, shared, title = m.groups()
        if star:
            continue  # unnumbered: nothing to reference
        decl[env] = (title.strip(), shared or env)
    return decl


def wrap_theorems(text, decl):
    r"""Wrap theorem-like environments so pandoc keeps the body and Typst can reference it.

    pandoc's LaTeX reader has no mapping for `theorem`/`lemma`/`shaded`: it drops the
    whole environment, body included, while refs to it survive as `@thm:...`. Emitting a
    marker the converter turns into `#thmbox(family, title)[...] <label>` keeps the text
    and makes `\ref` print "Theorem 3" exactly like LaTeX.
    """
    if not decl:
        return text
    pat = re.compile(r"\\begin\{(" + "|".join(map(re.escape, sorted(decl, key=len, reverse=True))) + r")\}")
    counters = {}
    out, pos = [], 0
    while True:
        m = pat.search(text, pos)
        if not m:
            out.append(text[pos:])
            break
        env = m.group(1)
        end = text.find("\\end{%s}" % env, m.end())
        if end < 0:
            out.append(text[pos:m.end()])
            pos = m.end()
            continue
        body_start = m.end()
        title, fam = decl[env]
        opt = ""
        mm = re.match(r"\s*\[([^\]]*)\]", text[body_start:end])
        if mm:
            opt = mm.group(1).strip()
            body_start += mm.end()
        inner = text[body_start:end]
        inner = re.sub(r"\\(?:begin|end)\{shaded\*?\}", "", inner)
        # The theorem's own \label sits right after \begin (thm2) or at the very end of
        # the body (most others); equation labels inside the body stay untouched.
        lab = ""
        lm = re.search(r"^\s*\\label\{([^}]*)\}", inner)
        if lm:
            lab = lm.group(1)
            inner = inner[lm.end():]
        else:
            tm = re.search(r"\\label\{([^}]*)\}\s*$", inner)
            if tm:
                lab = tm.group(1)
                inner = inner[:tm.start()]
        counters[fam] = counters.get(fam, 0) + 1
        out.append(text[pos:m.start()])
        out.append("\n\nQQTHMBQQ%s|%s|%sQQENDQQ\n%s\nQQTHMEQQ%sQQENDQQ\n\n"
                   % (fam, title, (" (" + opt + ")") if opt else "", inner, lab))
        pos = end + len("\\end{%s}" % env)
    return "".join(out)


def footnote_numbers(text):
    """label -> printed number, from the order of \\footnote in the source."""
    nums = {}
    for i, m in enumerate(re.finditer(r"\\footnote\s*\{", text)):
        inner, _ = _balanced(text, m.end() - 1)
        if not inner:
            continue
        lm = re.search(r"\\label\{([^}]*)\}", inner)
        if lm:
            nums[lm.group(1)] = i + 1
    return nums


def convert_body(text):
    text = flatten_footnote_displays(text)
    # `text.$` at a line end followed by a lone `$` line is an empty math span the
    # author left behind; pandoc fails the whole paragraph on it and the fallback
    # then splits the prose mid-word.
    text = re.sub(r"\$[ \t]*\n[ \t]*\$", "", text)
    text = re.sub(r"(?<!\$)\$[ \t]+(?<!\$)\$(?!\$)", "", text)
    # A blank line left inside a display (a stripped `%` comment line, an empty
    # row) makes the paragraph splitter cut the display in two; the first half is
    # then read as text and the equation survives only as literal `\begin{equation}`.
    text = re.sub(r"(\\begin\{(?:equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?|displaymath)\}.*?\\end\{(?:equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?|displaymath)\})",
                  lambda m: re.sub(r"\n[ \t]*\n+", "\n", m.group(0)), text, flags=re.S)
    # A display environment glued to the surrounding sentence (no blank line) is
    # read by pandoc as text: `\begin{equation}` survives as literal words and the
    # equation vanishes from the output. Isolate every display.
    text = re.sub(r"[ \t]*\\begin\{(equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?|displaymath)\}",
                  r"\n\n\\begin{\1}", text)
    text = re.sub(r"\\end\{(equation\*?|align\*?|eqnarray\*?|gather\*?|multline\*?|displaymath)\}[ \t]*",
                  r"\\end{\1}\n\n", text)
    # The isolation above reopens blank lines inside a list; collapse them now so the
    # paragraph splitter keeps each list whole (an orphaned \end{description} makes
    # pandoc fail the chunk and the fallback splits the prose).
    text = collapse_list_blanks(text)
    # A blank line inside a long table splits it in two; the second half then starts
    # mid-`tabular`, pandoc rejects it and plain_fallback dumps raw `&` rows into the
    # page. Protect float environments from the paragraph split.
    floats, pieces, pos = [], [], 0
    while True:
        m = FLOAT_ENV.search(text, pos)
        if not m:
            break
        env = m.group(1)
        end = text.find("\\end{%s}" % env, m.end())
        if end < 0:
            break
        end += len("\\end{%s}" % env)
        pieces.append(text[pos:m.start()])
        pieces.append("\n\n@@FLOAT%d@@\n\n" % len(floats))
        floats.append(text[m.start():end])
        pos = end
    pieces.append(text[pos:])
    text = "".join(pieces)

    parts = re.split(r"\n\s*\n", text)
    results = []
    def restore_math(t):
        return re.sub(r"ZZMATH(\d+)ZZ", lambda m: CASE_SLOTS.get(m.group(1), ""), t)
    def conv(p):
        outs = []
        stack = [p]
        while stack:
            q = stack.pop()
            if not q.strip():
                continue
            fm = re.fullmatch(r"@@FLOAT(\d+)@@", q.strip())
            if fm:
                outs.append(convert_float(floats[int(fm.group(1))]))
                continue
            out = pandoc_chunk(q)
            if out is not None:
                outs.append(restore_math(out))
                continue
            if len(q) < 20 or "\n\n" not in q and len(q.split("\n")) < 2:
                outs.append(restore_math(plain_fallback(q)))
                continue
            mid = len(q) // 2
            # Never split inside `$...$`: the half then carries an unbalanced dollar,
            # pandoc dumps the sentence as escaped text, and `plain_fallback` cannot
            # find the span either. Only a boundary outside math is a legal split.
            nl = None
            # A boundary at index 0 or len-1 leaves one half equal to q, so the
            # stack never shrinks and the same failing chunk is retried forever.
            for cand in sorted((i for i, ch in enumerate(q) if ch == "\n" and 0 < i < len(q) - 1),
                               key=lambda x: abs(x - mid)):
                if not _in_math(q, cand):
                    nl = cand
                    break
            if nl is None:
                for sp in sorted((i for i, ch in enumerate(q) if ch == " " and 0 < i < len(q) - 1),
                                 key=lambda x: abs(x - mid)):
                    if not _in_math(q, sp):
                        nl = sp
                        break
            if nl is None:
                # No safe boundary: convert the whole chunk with the math-aware
                # fallback rather than splitting a formula in half.
                outs.append(restore_math(plain_fallback(q)))
                continue
            stack.append(q[nl:])
            stack.append(q[:nl])
        return "\n\n".join(outs)
    for p in parts:
        results.append(conv(p))
    return "\n\n".join(results)

body = rewrite_cases_displays(body)

# Nature extended-data sections reset the float counters and rename the caption
# prefix. Typst gives each figure kind its own counter, so switch kind at the
# boundary and let `supplement` supply the renamed prefix.
ed_names = dict(re.findall(r"\\captionsetup\[(figure|table)\]\{name=\{?(?:\\bf\s*)?(?:\\textbf\{)?([^}]*)\}+", body))
if ed_names:
    body = re.sub(r"\\captionsetup\[[^\]]*\]\{name=.*?\}\}\s*", "", body)
    m = re.search(r"\\setcounter\{figure\}\{0\}", body)
    if m:
        head, tail = body[:m.start()], body[m.end():]
        k = head.rfind(r"\clearpage")
        if k >= 0:
            head = head[:k] + r"\newpage" + head[k + len(r"\clearpage"):]
        tail = re.sub(r"\\setcounter\{(?:figure|table)\}\{0\}\s*", "", tail)
        body = head + "\n\nZZEDSTARTZZ\n\n" + tail
open(os.path.join(WORK, "body.tex"), "w", encoding="utf-8").write(body)
thm_decl = theorem_envs(preamble)
FOOTNOTE_NUMS = footnote_numbers(body)
body = wrap_theorems(body, thm_decl)
typ = convert_body(body)

if "ZZEDSTARTZZ" in typ:
    pre, post = typ.split("ZZEDSTARTZZ", 1)
    post = post.replace("ZZEDSTARTZZ", "")
    if ed_names.get("figure"):
        post = post.replace("#figure(image(", '#figure(kind: "edfig", supplement: [%s], image(' % plain(ed_names["figure"]))
    if ed_names.get("table"):
        post = post.replace(", kind: table", ', kind: "edtable", supplement: [%s]' % plain(ed_names["table"]))
    typ = pre + post
CIRCLED = {"circle.times": "\u2297", "times.circle": "\u2297", "circle.plus": "\u2295",
           "plus.circle": "\u2295", "circle.minus": "\u2296", "circle.dot": "\u2299",
           "circle.stroked.r": "\u2298", "circle.plus.arrow.t": "\u2295",
           "square.c": "\u25a1", "triangle.t": "\u25b3"}
# pandoc's typst writer names n-ary operators with a `.big` modifier that Typst's
# symbol namespace does not define: `times.circle.big` is an unknown variable, so the
# equation fails to compile. Spell them as the operator's Unicode code point instead.
BIG_OPERATORS = {"times.circle.big": "\u2a02", "plus.circle.big": "\u2a01",
                 "union.big": "\u22c3", "union.sq.big": "\u2a06", "sect.big": "\u22c2",
                 "or.big": "\u22c1", "and.big": "\u22c0", "dot.circle.big": "\u2a00",
                 "times.big": "\u2a2f"}
GREEK = {"alpha": "alpha", "beta": "beta", "gamma": "gamma", "delta": "delta",
         "epsilon": "epsilon", "varepsilon": "epsilon", "zeta": "zeta", "eta": "eta",
         "theta": "theta", "vartheta": "theta", "iota": "iota", "kappa": "kappa",
         "lambda": "lambda", "mu": "mu", "nu": "nu", "xi": "xi", "pi": "pi", "rho": "rho",
         "sigma": "sigma", "tau": "tau", "upsilon": "upsilon", "phi": "phi",
         "varphi": "phi", "chi": "chi", "psi": "psi", "omega": "omega",
         "Gamma": "Gamma", "Delta": "Delta", "Theta": "Theta", "Lambda": "Lambda",
         "Xi": "Xi", "Pi": "Pi", "Sigma": "Sigma", "Upsilon": "Upsilon", "Phi": "Phi",
         "Psi": "Psi", "Omega": "Omega", "partial": "diff", "infty": "infinity",
         "langle": "angle.l", "rangle": "angle.r", "mid": "|", "colon": ":",
         "sqrt": "sqrt", "int": "integral", "iint": "integral.double",
         "iiint": "integral.triple", "oint": "integral.cont", "sum": "sum",
         "prod": "prod", "pm": "plus.minus", "mp": "minus.plus", "cdot": "dot.op",
         "ast": "star.op", "star": "star", "circ": "compose", "bullet": "bullet",
         "dots": "dots.h", "ldots": "dots.h", "cdots": "dots.h.c", "vdots": "dots.v",
         "to": "arrow.r", "rightarrow": "arrow.r", "leftarrow": "arrow.l",
         "gets": "arrow.l", "Rightarrow": "arrow.r.double",
         "Leftarrow": "arrow.l.double", "leftrightarrow": "arrow.l.r",
         "le": "less.eq", "leq": "less.eq", "ge": "greater.eq", "geq": "greater.eq",
         "ne": "eq.not", "neq": "eq.not", "approx": "approx", "equiv": "equiv",
         "sim": "tilde", "simeq": "approx", "propto": "propto", "in": "in",
         "notin": "in.not", "subset": "subset", "cup": "union", "cap": "inter",
         "setminus": "without", "forall": "forall", "exists": "exists",
         "quad": " ", "qquad": "  ", ";": " ", ",": " ", ":": " ", " ": " "}
# Multi-letter names Typst parses as a single identifier (function or symbol); a
# `_{ij}`-style subscript must not be split when it names one of them.
MATH_WORDS = {"max", "min", "lim", "sup", "inf", "det", "dim", "ker", "deg", "gcd",
              "lcm", "mod", "log", "ln", "exp", "sin", "cos", "tan", "cot", "sec",
              "csc", "sinh", "cosh", "tanh", "arg", "rank", "tr", "diag", "sgn",
              "erf", "res", "im", "re", "id", "op", "cal", "bb", "fr", "sf", "tt"}
TEXTCMD = {"text": "upright", "textrm": "upright", "mathrm": "upright", "rm": "upright",
           "textbf": "bold", "mathbf": "bold", "bm": "bold", "boldsymbol": "bold",
           "textit": "italic", "textsc": "smallcaps", "t": "tt", "mathtt": "tt",
           "textsf": "sans", "mathsf": "sans", "hat": "hat", "tilde": "tilde",
           "bar": "macron", "overline": "macron", "vec": "arrow.v", "dot": "dot"}


UPRIGHT_OPS = {"=", "<", ">", "+", "-", "/", "approx", "prop", "tilde", "times",
               "plus.minus", "pm", "sim", "less.sim", "greater.sim", "less.eq",
               "greater.eq", "equiv", "approx"}


def _merge_letters(toks):
    """Rejoin the letters pandoc spaced apart: `R M` -> `RM`, `r a d` -> `rad`."""
    merged, prev = [], None
    for tok in toks:
        single = len(tok) == 1 and tok.isalnum()
        if prev is not None and (
                (single and prev[1] and tok.isalnum())
                or (prev[0].isalpha() and prev[0].isupper()
                    and (tok.isdigit() or (single and tok.isupper())))):
            merged[-1] = (merged[-1][0] + tok, single)
        else:
            merged.append((tok, single))
        prev = merged[-1]
    return [m[0] for m in merged]


def _upright_clean(t):
    t = t.replace('"', "")
    t = re.sub(r"\\([^A-Za-z])", r"\1", t)
    t = re.sub(r"\\[A-Za-z]+", "", t)
    t = re.sub(r"(?<![A-Za-z0-9)])-\s+", "-", t)
    return " ".join(_merge_letters(t.split()))


def _upright_text(body):
    """Turn the body of a multi-token `upright(...)` into text runs plus scripts.

    Pandoc writes `\\mathrm{RM = -36.9\\,rad\\,m^{-2}}` as `upright(R M = - 36.9
    thin r a d thin m^(- 2))`. Typst parses the spaces as separate arguments and
    aborts. Quoting the words keeps the literal glyphs the author drew; relations
    and the `^`/`_` scripts stay outside the string so they still typeset as math.
    """
    atoms, cur, i, n = [], [], 0, len(body)
    while i < n:
        c = body[i]
        if c in "^_":
            if cur:
                atoms.append(("t", "".join(cur)))
                cur = []
            j = i + 1
            if j < n and body[j] == "(":
                depth, k = 1, j + 1
                while k < n and depth:
                    depth += {"(": 1, ")": -1}.get(body[k], 0)
                    k += 1
                inner, j = body[j + 1:k - 1], k
            else:
                k = j
                while k < n and body[k] not in " \t^_":
                    k += 1
                inner, j = body[j:k], k
            t = _upright_clean(inner)
            if re.fullmatch(r"[A-Za-z0-9]+", t):
                t = '"%s"' % t
            atoms.append(("s", c + "(" + t + ")"))
            i = j
            continue
        cur.append(c)
        i += 1
    if cur:
        atoms.append(("t", "".join(cur)))

    pieces = []
    for kind, val in atoms:
        if kind == "s":
            pieces.append(("s", val))
            continue
        for seg in re.split(r"\bthin\b", val):
            for tok in _merge_letters(seg.split()):
                if tok in UPRIGHT_OPS or re.fullmatch(r"[a-z]+(\.[a-z]+)+", tok):
                    pieces.append(("o", tok))
                else:
                    pieces.append(("w", tok))

    out = []
    for idx, (kind, val) in enumerate(pieces):
        if kind == "w":
            piece = 'upright("%s")' % _upright_clean(val)
        elif kind == "s":
            piece = val
        else:
            piece = val
        if idx:
            if kind == "s":
                out.append("")
            elif "o" in (kind, pieces[idx - 1][0]):
                out.append(" ")
            else:
                out.append(" thin ")
        out.append(piece)
    if out and pieces[0][0] == "s":
        out.insert(0, '""')
    return "".join(out) or 'upright("")'


def fix_uprights(s):
    """Repair pandoc's unquoted multi-token `upright(...)` calls inside math."""
    out, i, n, instr = [], 0, len(s), False
    while i < n:
        c = s[i]
        if c == '"':
            instr = not instr
            out.append(c)
            i += 1
            continue
        if not instr and s.startswith("upright(", i):
            j, k, depth, q = i + 8, i + 8, 1, False
            while k < n and depth:
                ch = s[k]
                if ch == '"':
                    q = not q
                elif not q:
                    if ch == "(":
                        depth += 1
                    elif ch == ")":
                        depth -= 1
                k += 1
            if depth:
                out.append(s[i:])
                break
            body = s[j:k - 1]
            probe = re.sub(r'"[^"]*"', "", body)
            if "\\" in probe or re.search(r"\s", probe):
                out.append(_upright_text(body))
            else:
                out.append(s[i:k])
            i = k
            continue
        out.append(c)
        i += 1
    return "".join(out)


def math_residue(s):
    s = s.replace("lt.tri", "lt.closed").replace("gt.tri", "gt.closed")
    s = s.replace("sect ", "inter ")
    r"""Resolve LaTeX that pandoc leaves verbatim inside `$...$`.

    Three shapes cost real content. `\\cmd` (a row break glued to a macro, or an
    over-escaped one) makes Typst read `\` + an unknown identifier and abort the span.
    A bare `%` opens a comment, silently eating the rest of the line including the closing
    `$`, so the equation renders as prose and the next `$` mis-pairs. `\text{vis}` and
    friends would otherwise become an unknown variable. Greek, operators and spacing map
    onto Typst names, text commands become their Typst style, and an unrecognised command
    degrades to a quoted string, which always renders as its own name.
    """
    def styled(m):
        body = m.group(2)
        name = max((k for k in TEXTCMD if m.group(0) == "\\" + k + "{" + body + "}"), key=len)
        style = TEXTCMD[name]
        if style == "smallcaps":
            return "#smallcaps[%s]" % body               # math has no smallcaps variable
        if style in ("upright", "bold", "italic", "tt", "sans"):
            return "%s(\"%s\")" % (style, body)          # words are text, not identifiers
        return "%s(%s)" % (style, body)                  # accents take math content

    s = re.sub(r"\\((?:text|textrm|mathrm|textbf|textit|textsc|mathtt|mathbf|mathsf|"
               r"boldsymbol|bm|hat|tilde|overline|vec)\{([^{}]*)\})", styled, s)
    # pandoc's typst writer emits `\/` for a literal slash: `F^{\mu\nu}/4` arrives as
    # `F^(mu nu) \/ 4`. Typst renders `\/` as `/`, so deleting it (the old behaviour)
    # silently dropped every division sign: `1/\sqrt{2}` became `1 \sqrt(2)`.
    s = s.replace("\\/", "/")
    # `3\%$/\sqrt{E}$`: the span opens with the division sign, and Typst math has no
    # left operand for `/` there ("unexpected slash"). The escaped form is plain text.
    s = re.sub(r"^(\s*)/", r"\1\\/", s)
    # pandoc writes \left( ... \right) as `\( ... \)`; Typst reads `\(` as a call
    # with an argument and aborts. The plain parens are what the author drew anyway.
    s = s.replace("\\(", "(").replace("\\)", ")")
    # pandoc's Typst writer wraps \left( ... \right) delimiters in
    # `#scale(x: N%, y: N%)[X]`; inside math that is a function call with a stray
    # argument and aborts the span. Keep the delimiter, drop the wrapper. Vertical
    # bars (`\big\|`) arrive the same way and must be kept as `\|`.
    s = re.sub(r'#scale\([^()]*\)\s*\[(\\[\[\](){}|]|[\[\](){}|])\]', r"\1", s)
    # pandoc's typst writer turns a math comma into `\,` (so `$d=0,1,2,3$` arrives as
    # `0 \, 1 \, 2 \, 3`). Typst has no `\,` command, and mapping it to a plain space
    # silently deletes every separator: the page then reads "d = 0123". A comma is both
    # valid Typst and what the author wrote.
    s = re.sub(r"\\,", ",", s)

    # `_{\rm FG,o}` arrives as `upright(F G , o)`: the comma is content, but Typst
    # reads it as a second argument to a one-argument function and aborts the span.
    # Keep each piece in its own upright group and let the math comma sit between them.
    def upright_csv(m):
        pieces = []
        for part in m.group(1).split(","):
            part = part.strip()
            if not part:
                continue
            if re.fullmatch(r"[A-Za-z]{2,}", part) or re.fullmatch(r"[A-Za-z]+(?: [A-Za-z]+)+", part):
                part = '"%s"' % part.replace(" ", "")
            pieces.append("upright(%s)" % part)
        return ", ".join(pieces)

    s = re.sub(r'\bupright\(([^()]*,[^()]*)\)', upright_csv, s)
    s = re.sub(r"\\[;:]|\\ +", " ", s)                   # remaining TeX spacing hints
    s = re.sub(r"\\+([A-Za-z]+)", lambda m: GREEK.get(m.group(1), '"' + m.group(1) + '"'), s)
    # `{0,1,2,3}` inside math is a Typst *code block*, which silently renders as `0123`;
    # as a group it has to be parentheses
    # `{0,1,2,3}` inside math is a Typst *code block*, which silently renders as `0123`.
    # Only a comma-separated list is a set literal; a plain `{a+b}` group is left alone,
    # since rewriting every brace broke papers whose math legitimately carries `#{...}`.
    s = re.sub(r"(?<![#A-Za-z])\{([^{},]*(?:,[^{},]*)+)\}", r"(\1)", s)
    s = re.sub(r"_\{([^{}]*)\}", r"_(\1)", s)
    s = re.sub(r"\^\{([^{}]*)\}", r"^(\1)", s)
    # pandoc writes \\odot as `dot.circle`, but Typst 0.15 has no such symbol: math reads
    # `dot` then the unknown modifier `.circle`. The literal sign is unambiguous.
    s = s.replace("dot.circle", "⊙")
    s = fix_uprights(s)
    out, i, instr = [], 0, False
    while i < len(s):
        c = s[i]
        if c == '"':
            instr = not instr
        elif c == "%" and not instr:
            out.append('"%"')
            i += 1
            continue
        out.append(c)
        i += 1
    return "".join(out)


def quote_math_percents(t):
    """Rewrite only math spans, never a `#figure(...)` code block that merely has a %.

    Scan left to right instead of pairing dollars with a regex: a display block is
    written `$ ... $` (whitespace inside), and a regex that pairs across it steals the
    next inline opener, so every following span on that line is treated as text.
    """
    out, i = [], 0
    instr = False
    while i < len(t):
        c = t[i]
        if c == '"':
            instr = not instr
        # pandoc's typst writer leaves a LaTeX `\%` as a bare `%`, which Typst reads
        # as a line comment: every following sentence on that line disappears.
        if c == "%" and not instr and (i == 0 or t[i - 1] != "\\"):
            out.append("\\%")
            i += 1
            continue
        if c == "$":
            if i + 1 < len(t) and t[i + 1] in " \n\t":
                j = t.find("$", i + 1)
                while j != -1 and j > 0 and t[j - 1] not in " \n\t":
                    j = t.find("$", j + 1)
                if j != -1:
                    out.append("$" + math_residue(t[i + 1:j]) + "$")
                    i = j + 1
                    continue
            j = t.find("$", i + 1)
            nl = t.find("\n", i + 1)
            if j != -1 and (nl == -1 or j < nl):
                out.append("$" + desplit(math_residue(t[i + 1:j])) + "$")
                i = j + 1
                continue
        out.append(c)
        i += 1
    return "".join(out)


UNITS = {"ev", "kev", "mev", "gev", "tev", "pev", "erg", "cm", "mm", "nm", "pm",
         "km", "ms", "ns", "ps", "fs", "hz", "khz", "mhz", "ghz", "yr", "kyr",
         "myr", "gyr", "kpc", "mpc", "gpc", "pc", "au", "kg", "kelvin"}
MATHWORDS = set(GREEK) | UNITS | {"sqrt", "upright", "bold", "italic", "sans", "tt", "cal",
                          "script", "fraktur", "double_struck", "bb", "hat", "macron",
                          "arrow", "tilde", "dot", "ddot", "accent", "limits", "sum",
                          "prod", "integral", "cont", "double", "triple", "Radical"}
SPACERS = {"thin", "med", "thick", "quad", "wide", "space"}


def desplit(s):
    r"""Rejoin identifiers the converter split across spaces, the way TeX tokenises.

    `\text{vis}` reached Typst as `upright(v i s)`: three separate variables multiplied
    together, which compiles and renders as gibberish - a silent defect no error count
    catches. Inside a style function the letters are always a `\text{...}`-style word, so
    they are joined and quoted; elsewhere a run of single letters is rejoined only when the
    join is a real Typst name, so legitimate `$x y$` products are never touched.
    """
    def arg(m):
        body = m.group(2).strip()
        if m.group(1) in ("upright", "sans", "tt", "smallcaps") and '"' not in body:
            # letter runs are one word each, the named symbols between them are real.
            # Typst parses a style argument as code, so a bare word is an unknown
            # variable - it has to be quoted.
            merged = re.sub(r"\b([A-Za-z])(?: ([A-Za-z]))+\b",
                            lambda x: x.group(0).replace(" ", ""), body)
            words = lambda x: x.group(0) if (x.group(0) in SPACERS or x.group(0) in GREEK) \
                              else '"%s"' % x.group(0)
            merged = re.sub(r"\b[A-Za-z]{2,}\b", words, merged)
            if merged != body:
                return "%s(%s)" % (m.group(1), merged)
        if re.fullmatch(r"[A-Za-z](?: [A-Za-z])+", body):
            return '%s("%s")' % (m.group(1), body.replace(" ", ""))
        return m.group(0)

    # pandoc splits `\mathrm{keV}` into `upright(k) e V`; the tail letters belong to the
    # same word, not to a product of variables
    s = re.sub(r"\bupright\(([A-Za-z])\)((?: [A-Za-z])+)\b",
               lambda x: 'upright("%s")' % (x.group(1) + x.group(2).replace(" ", "")), s)
    s = re.sub(r"\b(upright|cal|sans|tt|bold|italic|script|fraktur|double_struck|smallcaps)"
               r"\(([^()]*?)\)", arg, s)

    def rep(m):
        joined = m.group(0).replace(" ", "")
        if joined.lower() in UNITS:
            return '"%s"' % joined          # a unit is text, not a product of variables
        return joined if joined.lower() in MATHWORDS or joined in GREEK else m.group(0)

    return re.sub(r"\b[A-Za-z](?: [A-Za-z])+\b", rep, s)


def _split_caps(seg):
    """`$XI$` glues two variables into one unknown identifier; quote strings first."""
    strs = []
    seg = re.sub(r'"[^"]*"', lambda m: strs.append(m.group(0)) or "\x00S%d\x00" % (len(strs) - 1), seg)
    seg = re.sub(r"\b[A-Z]{2,3}\b", lambda m: " ".join(m.group(0)), seg)
    return re.sub(r"\x00S(\d+)\x00", lambda m: strs[int(m.group(1))], seg)


_CALLS = re.compile(r"\b(cal|bb|frak|scr)\(")


def _wrap_math_calls(t):
    """`cal(a, b)` is a Typst two-argument call; the comma is TeX punctuation.
    Parentheses inside the argument (`upright("flat")`) must not end the scan."""
    out, i = [], 0
    while True:
        m = _CALLS.search(t, i)
        if not m:
            out.append(t[i:])
            break
        out.append(t[i:m.end()])
        depth, j = 1, m.end()
        while j < len(t) and depth:
            depth += {"(": 1, ")": -1}.get(t[j], 0)
            j += 1
        inner, d, comma = t[m.end():j - 1], 0, False
        for c in inner:
            if c == "(":
                d += 1
            elif c == ")":
                d -= 1
            elif c == "," and d == 0:
                comma = True
        out.append("(" + inner + ")" if comma else inner)
        out.append(")")
        i = j
    return "".join(out)


def sanitize(t):
    # `.big` first: CIRCLED would otherwise turn `times.circle.big` into `⊗.big`.
    for k, v in BIG_OPERATORS.items():
        t = t.replace(k, v)
    for k, v in CIRCLED.items():
        t = t.replace(k, v)
    t = re.sub(r"(?<=[\u2200-\u22ff\u2a00-\u2a2f])\.big\b", "", t)
    # pandoc writes every plain `|` in math as `\|`, which Typst reads as the double
    # bar (‖). TeX's own `\|` never survives as `\|` (pandoc maps it to `parallel`),
    # so inside a math span the escape can be undone.
    t = re.sub(r"\$[^$]*\$", lambda m: m.group(0).replace("\\|", "|"), t, flags=re.S)
    # `\left|` / `\right\rangle` inside a cases row reach the writer as quoted words.
    t = re.sub(r"\$[^$]*\$",
               lambda m: re.sub(r'"(?:left|right|big|Big|bigg|Bigg)"', "", m.group(0)),
               t, flags=re.S)
    # Pauli strings (`$XI$`) stay one glued identifier that Typst reads as an
    # unknown variable; TeX prints two letters.
    t = re.sub(r"\$[^$]*\$", lambda m: _split_caps(m.group(0)), t, flags=re.S)
    # `cal(R , upright("flat"))` reads as a two-argument call; the comma is
    # punctuation in TeX. Group the list so Typst sees one argument.
    t = _wrap_math_calls(t)
    # `\delta_{lL}` becomes `delta_(lL)`, which Typst reads as one undefined variable;
    # TeX prints two italic variables. Only mixed-case runs are variables: a
    # lowercase word (`(flat)`, `(tot)`) must stay whole.
    t = re.sub(r"(?<=[_^])\(([A-Za-z]{2,})\)",
               lambda m: "(" + " ".join(m.group(1)) + ")"
               if re.search(r"[A-Z]", m.group(1)) and re.search(r"[a-z]", m.group(1))
               and m.group(1).lower() not in MATH_WORDS and m.group(1) not in GREEK
               else m.group(0), t)
    # A `width: 100%` argument whose `$...$` pairing went astray gets its % "quoted"
    # into `100"%"` (invalid Typst). Hide width percentages from the math scanner.
    widths = {}

    def _hide(m):
        key = "\x00W%d\x00" % len(widths)
        widths[key] = m.group(0)
        return key

    t = re.sub(r"width:\s*[\d.]+\s*%", _hide, t)
    t = quote_math_percents(t)
    for k, v in widths.items():
        t = t.replace(k, v)
    t = re.sub(r"tilde\.op\b", "tilde", t)
    # pandoc emits `cite(..., formal: "prose")`; Typst's argument is `form`
    t = re.sub(r"\bformal:", "form:", t)
    # `coordinates,$z^I$` sets without the space the author wrote (pandoc drops it)
    t = re.sub(r"([,;:])\$", r"\1 $", t)
    # \$\\ket{+}\$  ->  $|+⟩$
    t = re.sub(r"\\\$\\\\ket\{([^{}]*)\}\\\$", lambda m: "$|" + m.group(1) + "\u27e9$", t)
    t = re.sub(r"QQTHMBQQ([^Q|]*)\|([^|]*)\|([^Q|]*)QQENDQQ",
               lambda m: '#thmbox("%s", "%s")[' % (m.group(1), (m.group(2) + m.group(3)).strip()), t)
    t = re.sub(r"QQTHMEQQ(.*?)QQENDQQ",
               lambda m: "]" + (" <%s>" % m.group(1).strip() if m.group(1).strip() else ""), t)
    # A label cannot attach to a footnote (or to bare text); refs were already rewritten
    # to the printed number, so the dangling anchor is removed.
    t = re.sub(r"<footnote:[^>]+>", "", t)
    # consecutive citations @a@b@ -> spaced
    for _ in range(6):
        new = re.sub(r"(@[\w:\-.]+)@", r"\1 @", t)
        if new == t:
            break
        t = new
    t = re.sub(r'image\("(imgs/[^"]+)"\)', r'image("\1", width: 100%)', t)
    return t
typ = sanitize(typ)
# an unpaired `$` in one table cell can throw off the span pairing inside sanitize;
# catch what is left once the whole document is assembled
typ = re.sub(r"\$[^$]*\$", lambda m: _split_caps(m.group(0)), typ, flags=re.S)

# ============ bib & images ============
def _real_bib_entries(txt):
    """Count `@type{key` records that are not REVTeX's @CONTROL stubs."""
    return len([m for m in re.finditer(r"@(\w+)\s*\{\s*[^,\s]+", txt)
                if m.group(1).lower() != "control"])


bibs = glob.glob(os.path.join(SRC, "**", "*.bib"), recursive=True)
bibname = ""
if bibs and _real_bib_entries(read(max(bibs, key=lambda p: read(p).count("@")))) >= 2:
    # RevTeX leaves several .bib files in src (its notes file holds only @CONTROL
    # stubs); take the one with the most entries instead of glob order.
    best = max(bibs, key=lambda p: read(p).count("@"))
    shutil.copy(best, os.path.join(PAPER, "refs.bib"))
    bibname = "refs.bib"
else:
    tex = read(find_main_tex())
    blk = re.search(r"\\begin\{thebibliography\}.*?\\end\{thebibliography\}", tex, re.S)
    if blk:
        sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "tools"))
        import thebib2bib
        keys = thebib2bib.convert(tex, os.path.join(PAPER, "refs.bib"))
        if keys:
            bibname = "refs.bib"
            print("built refs.bib from thebibliography:", len(keys), "entries")
    if not bibname:
        # revtex-style sources keep the authoritative list in the generated .bbl
        import bblmerge
        n = bblmerge.build_from_bbl(PAPER, text=blk.group(0) if blk else None)
        if n:
            bibname = "refs.bib"
            print("built refs.bib from .bbl:", n, "entries")
if bibname:
    # Dumps from ADS/INSPIRE mix quoting styles and repeat keys; BibLaTeX
    # rejects the whole file for any single defect, so normalize it wholesale.
    import importlib.util
    _spec = importlib.util.spec_from_file_location(
        "scriptbibfix", os.path.join(os.path.dirname(os.path.abspath(__file__)), "bibfix.py"))
    bibfix = importlib.util.module_from_spec(_spec)
    _spec.loader.exec_module(bibfix)
    bibfix.main(os.path.join(PAPER, "refs.bib"))

def localize_snippet_images(snippet):
    """CeTZ snippets embed rasters as `image("../src/...")`, which escapes the
    project root. Rewrite every such path to one Typst may read."""
    IMGSDIR = os.path.join(PAPER, "imgs")
    os.makedirs(IMGSDIR, exist_ok=True)

    def repl(m):
        p = m.group(1)
        cands = [os.path.normpath(os.path.join(PAPER, p)),
                 os.path.normpath(os.path.join(SRC, p)),
                 os.path.normpath(os.path.join(SRC, p.replace("../src/", "")))]
        cands += glob.glob(os.path.join(SRC, "**", os.path.basename(p)), recursive=True)
        f = next((c for c in cands if os.path.isfile(c)), None)
        if not f:
            return m.group(0)
        ap, root = os.path.abspath(f), os.path.abspath(PAPER)
        if os.path.commonpath([ap, root]) == root:
            rel = os.path.relpath(ap, root).replace("\\", "/")
            return 'image("%s"' % rel
        dest = os.path.join(IMGSDIR, os.path.basename(f))
        if not os.path.exists(dest):
            shutil.copy(f, dest)
        return 'image("imgs/%s"' % os.path.basename(f)

    return re.sub(r'image\(\s*"([^"]+)"', repl, snippet)


# ============ TikZ -> CeTZ via codebuddy ============
cetz_map = {}
for i, tk in enumerate(tikzs):
    out_typ = os.path.join(FIG, f"cetz_{i}.typ")
    if os.path.exists(out_typ) and os.path.getsize(out_typ) > 50:
        cetz_map[i] = localize_snippet_images(read(out_typ))
        continue
    # A picture whose only content is an \includegraphics plus panel labels has no
    # geometry to redraw; a CeTZ canvas would just re-embed the same raster.
    inc = re.search(r"\\includegraphics(?:\[[^\]]*\])?\{([^}]+)\}", tk)
    if inc and not re.search(r"\\(?:draw|fill|filldraw|shade|clip|path|pic)\b", tk):
        cetz_map[i] = 'image("%s")' % inc.group(1).strip()
        continue
    prompt = (
        "You convert one TikZ picture to CeTZ (Typst drawing library). "
        f"First read the skill docs: {os.path.join(SKILLS, 'typst-cetz-skills-main', 'cetz', 'SKILL.md')} and the files it references (canvas.md, primitives.md, marks.md, styling.md, transforms.md). "
        f"Then read {os.path.join(FIG, f'tikz_{i}.tex')} and rewrite the SAME figure using #import \"@preview/cetz:0.4.2\" and cetz.canvas with `import cetz.draw: *` INSIDE the canvas. "
        "Preserve geometry, labels (keep math in $...$), arrow tips (mark: end: \">\"), dashed styles, colors, fills. "
        "Ignore pgfplots/axis environments: if the picture uses \\begin{axis} data plotting, instead draw approximate axes+curve with cetz.draw primitives from the visible data. "
        f"Write ONLY the typst code (a #figure(...) wrapper containing the cetz.canvas call, no import line, no markdown fences) to {out_typ}. Do not print anything else."
    )
    try:
        cb(prompt, PAPER, timeout=420)
    except Exception as e:
        print("cb fail", i, e)
    if os.path.exists(out_typ):
        snippet = localize_snippet_images(read(out_typ))
        test = os.path.join(PAPER, "_cetzz_test.typ")
        open(test, "w", encoding="utf-8").write('#import "@preview/cetz:0.4.2"\n' + snippet)
        c = run(["typst", "compile", test, os.path.join(WORK, "cetzz_test.pdf")])
        if c.returncode == 0:
            cetz_map[i] = snippet
        else:
            fixp = f"The typst snippet in {test} fails to compile:\n{(c.stderr or '')[:3000]}\nFix it in place. Consult {os.path.join(SKILLS, 'typst-cetz-skills-main', 'cetz')} docs. Keep it as a single #figure containing a cetz.canvas."
            try:
                cb(fixp, PAPER, timeout=300)
            except Exception:
                pass
            snippet = localize_snippet_images(read(test).split("\n", 1)[-1]) if os.path.exists(test) else ""
            c2 = run(["typst", "compile", test, os.path.join(WORK, "cetzz_test.pdf")])
            cetz_map[i] = snippet if c2.returncode == 0 and snippet.strip() else f"// TikZ figure {i} (kept source at figures/tikz_{i}.tex)\n#figure(text(\u2039TikZ source: figures/tikz_{i}.tex\u203a), caption: [Figure converted from TikZ; source in figures/tikz_{i}.tex])"
    else:
        cetz_map[i] = f"#figure(text(\u2039TikZ source: figures/tikz_{i}.tex\u203a), caption: [TikZ figure {i}])"

for i in range(len(tikzs)):
    typ = typ.replace(f"ZZTIKZ{i}ZZ", "\n" + cetz_map[i] + "\n")

# ============ schematic figures -> CeTZ redrawing (when few/no TikZ) ============
if os.environ.get("CETZ_SCHEMATIC", "1") == "1":
    KEYWORDS = ("schematic", "illustrat", "overview", "setup", "architecture", "concept", "cartoon", "diagram")
    figcaps = re.findall(r'image\("imgs/([^"]+)"[^)]*\)(?:\s*\[[^\]]*\])?\s*#figure', typ)  # not reliable
    caps = re.findall(r'#figure\(\s*image\("imgs/([^"]+)"[^)]*\),?\s*(?:width:[^,]+,?\s*)?caption:\s*\[(.*?)\]\s*\)', typ, re.S)
    done = 0
    for stem, cap in caps:
        if done >= 2:
            break
        if not any(k in cap.lower() for k in KEYWORDS):
            continue
        out_typ = os.path.join(FIG, f"schematic_{stem}.typ")
        if not os.path.exists(out_typ):
            prompt = (
                "Redraw a physics paper figure as an elegant vector schematic using CeTZ in Typst. "
                f"First read the skill docs: {os.path.join(SKILLS, 'typst-cetz-skills-main', 'cetz', 'SKILL.md')} (and primitives.md/marks.md/styling.md as needed). "
                "The figure caption is: [" + cap[:1500] + "]. The original is a raster image you cannot see; recreate a clean SCHEMATIC version based ONLY on the caption description: labeled boxes, arrows, axes, devices, waveforms as described. "
                f"Write ONLY typst code: a #figure(...) whose body is a cetz.canvas call (import cetz.draw inside canvas; no import line) to {out_typ}. Keep it under 80 lines. Nothing else."
            )
            try:
                cb(prompt, PAPER, timeout=420)
            except Exception as e:
                print("cb schematic fail", stem, e)
        if os.path.exists(out_typ):
            snippet = localize_snippet_images(read(out_typ))
            test = os.path.join(PAPER, "_sch_test.typ")
            open(test, "w", encoding="utf-8").write('#import "@preview/cetz:0.4.2"\n' + snippet)
            c = run(["typst", "compile", test, os.path.join(WORK, "sch_test.pdf")])
            if c.returncode != 0:
                continue
            newcap = cap.rstrip() + " \u2039redrawn schematic in CeTZ of original figure " + stem + "\u203a"
            typ = typ.replace(
                f'#figure(\n  image("imgs/{stem}',
                snippet.rstrip() + "\n#figure(\n  image(\"imgs/" + stem, 1)
            # simpler: prefix the CeTZ redraw before the original figure is left above; keep original image untouched
            done += 1

# ============ assemble elegant main.typ ============
abstract = ""
m = re.search(r"#quote\[(.*?)\]\n#align\(left\)", typ, re.S)  # pandoc renders abstract oddly; detect below instead
is_nature = bool(re.search(r"\\documentclass(\[[^\]]*\])?\{nature\}", preamble))
cap_sep = "#set figure.caption(separator: [ | ])\n" if is_nature else ""
# With no numbering rule Typst refuses `@eq` ("cannot reference equation without
# numbering"). Only papers whose displays are numbered environments get one, so the
# numbers match the source; `supplement: none` leaves the word "equation" to the prose.
eqnum = ""
if re.search(r"\\begin\{(?:equation|align|gather|eqnarray)\}", body):
    eqnum = '#set math.equation(numbering: "(1)", supplement: none)\n'
thmbox = ""
if thm_decl:
    # One counter per numbering family, so `\newtheorem{lemma}[theorem]` continues the
    # theorem sequence exactly like LaTeX.
    thmbox = '''#let thmbox(fam, name, body) = figure(
  kind: fam,
  supplement: name,
  numbering: "1",
  block(width: 100%, {
    context [*#name #counter(figure.where(kind: fam)).display().*]
    h(0.4em)
    set text(style: "italic")
    body
  }),
)
'''
head = f'''#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
{cap_sep}#show math.equation.where(block: true): set align(center)
{eqnum}{thmbox}

#align(center)[
  #text(17pt, weight: "bold", [{title_p}]) \
  #v(1.2em)
  #text(10.5pt)[{author_p}]
  {('#v(0.4em)\n  #text(9.5pt, fill: gray)[' + plain(date) + ']') if date else ''}
]
{('#block(spacing: 0.45em)[\n' + aff_p + '\n]') if aff_p else ''}
#v(1.2em)
'''
open(os.path.join(WORK, "premain.typ"), "w", encoding="utf-8").write(typ)
doc = head + typ.rstrip() + "\n"
# resolve dangling references: keep those matching bib keys or typst labels, drop others
bibkeys = set()
if bibname:
    bibkeys = set(re.findall(r"@\w+\{([^,]+),", read(os.path.join(PAPER, "refs.bib"))))
# Typst cannot parse `&` in a citation key and `@` cannot express `/`: DOI-style
# keys are renamed in the .bib and at every use site.
bibpath = os.path.join(PAPER, "refs.bib")
doc = re.sub(r'#cite\(label\("([\w:.\- &/]+)"\)\)', r"@\1", doc)
if bibname:
    raw = read(bibpath)
    def rename_key(k):
        return k.replace("&", "and").replace("/", "-")
    keys0 = [m.group(1) for m in re.finditer(r"@\w+\{([^,]*)", raw)]
    if any(k != rename_key(k) for k in keys0):
        raw = re.sub(r"(@\w+\{)([^,]*)",
                     lambda m: m.group(1) + rename_key(m.group(2)), raw)
        open(bibpath, "w", encoding="utf-8").write(raw)
        for k in keys0:
            if k != rename_key(k):
                doc = doc.replace("@" + k, "@" + rename_key(k))
        bibkeys = {rename_key(k) for k in bibkeys}
    # BibLaTeX keys are case-sensitive; sources routinely cite `bogdanov19c` for
    # `Bogdanov19c`. Re-spell every use site to the key the .bib actually holds.
    actual = {}
    for k in bibkeys:
        actual.setdefault(k.lower(), k)
    def recase(k):
        return actual.get(k.lower(), k)
    doc = re.sub(r"#cite\(\s*<([\w:.\-]+)>",
                 lambda m: "#cite(<" + recase(m.group(1)) + ">", doc)
    doc = re.sub(r"(?<![\w@])@([A-Za-z0-9_][\w:.\-]*)",
                 lambda m: "@" + recase(m.group(1)), doc)
# `#label("a/b")` is a value, not a registered label; pandoc uses that form because
# `<a/b>` is not valid label syntax. Rewrite both sides with a safe name.
doc = re.sub(r"label\(\"([^\"]+)\"\)",
             lambda m: "<" + re.sub(r"[^\w:.\-]", "-", m.group(1)) + ">", doc)
defined = set(m.group(1) for m in re.finditer(r"(?<!\()<([\w:.\-]+)>", doc)) | bibkeys
# `STARS@UNIPD` is an at-sign in prose, not a reference; pandoc turns it into a
# citation that deref then blanks out. Escape it where the key does not exist.
doc = re.sub(r"(?<=[\w)])@([A-Za-z][\w:.\-]*)",
             lambda m: m.group(0) if m.group(1) in defined else "\\@" + m.group(1), doc)
def deref(m):
    k = m.group(1)
    if k.startswith("preview"):
        return m.group(0)
    if k in FOOTNOTE_NUMS:
        return str(FOOTNOTE_NUMS[k])
    if k in defined:
        return m.group(0)
    # `\ref{fig:x}b` reaches here as `@fig:xb`: the panel letter belongs after the ref
    if len(k) > 4 and k[-3].isalpha() and k[-2] == "-" and k[-1].isalpha() and k[:-3] in defined:
        return "#ref(<%s>)%s-%s" % (k[:-3], k[-3], k[-1])
    if len(k) > 2 and k[-1].isalpha() and k[:-1] in defined:
        return "#ref(<%s>)%s" % (k[:-1], k[-1])
    # A source `\cite{x}:` reaches us as `@x:` because ':' is a legal label character;
    # the colon is prose, so emit an explicit call and let it stand as text.
    if k.endswith(":") and k[:-1] in defined:
        return ("#cite(<%s>)" if k[:-1] in bibkeys else "#ref(<%s>)") % k[:-1] + ":"
    return "#text([])"
# `\ref{x}---for` reaches us as `@x---for`: '-' is legal in a Typst label, so the
# em dash and the following word get swallowed into the key (and then lost).
# Emit an explicit `#ref` so the dash run stays outside the reference.
def _deref_before_dashes(m):
    # m.group(0) keeps the leading `~` and the dash run; strip both before
    # deciding whether the reference itself survived.
    core = deref(m).rstrip("-")
    if core.lstrip("~").startswith("@"):
        return "#ref(<%s>)%s" % (m.group(1), m.group(2))
    return core + m.group(2)
if os.environ.get("DUMP_DOC"):
    open(os.environ["DUMP_DOC"], "w", encoding="utf-8").write(doc)
# `\ref{fig:x}-(A)` arrives as `@fig:x-(A)`: the parens are not label chars, so
# the key swallows the `-(A` prefix and resolves to nothing.
def _panel_paren(m):
    k = m.group(1)
    return "#ref(<%s>)-(%s)" % (k, m.group(2)) if k in defined else m.group(0)
doc = re.sub(r"~?@([\w:]+(?:[-.][\w:]+)*)-\(([A-Za-z])\)", _panel_paren, doc)
doc = re.sub(r"~?@([\w:.\-]*[\w:])(-{2,})(?=\w)", _deref_before_dashes, doc)
doc = re.sub(r"(?<!\\)~?@([\w:.\-]*[\w:\-])", deref, doc)
# Typst already prints "Figure 1" / "Table 2" / "Section 3" for a ref, so the
# literal prefix the LaTeX source put in front of \ref would double it. Equations are
# left alone: with `supplement: none` Typst prints only "(3)", and the prose word
# "equation" is the only thing naming it.
doc = re.sub(r"(?i)(?:(?:Extended\s+Data|Supplementary|Supplemental)\s+)?"
             r"(?:Figures?|Figs?\.|Tables?|Sections?)\s*~?\s*"
             r"(?=(?:@|#ref\(<)(?:fig|tab|sec)(?:[:_\-]|\d))", "", doc)
# `\eqref{eq:x}` reaches the writer as `#link(<eq:x>)[\[eq:x\]]`: the display text
# is only the label, while Typst prints the number for `@eq:x`. Left as is, the
# page shows "[eq:x]" instead of "(3)".
doc = re.sub(r"#link\(<([\w:.\-]+)>\)\[\\\[[^\[\]]*\\\]\]",
             lambda m: "@" + m.group(1) if m.group(1) in defined else m.group(0), doc)
# `\eqref`/`\ref` inside a display survived pandoc as a marker; Typst math accepts a
# code expression, and `#ref` prints the number the same way `\eqref` did.
doc = re.sub(r'(?:upright\()?"QQR(\d+)QQ"\)?',
             lambda m: "#ref(<%s>)" % _REF_KEYS[int(m.group(1))]
             if int(m.group(1)) < len(_REF_KEYS) else m.group(0), doc)
# `$\eqref{eq:x}$` (a ref used as math) reaches the writer as `$"eqref"{eq:x}$`,
# which Typst parses as an unknown variable and refuses to compile.
doc = re.sub(r'\$"eqref"\s*\{\s*([\w:.\-]+)\s*\}\$',
             lambda m: "(#ref(<%s>))" % m.group(1), doc)
# pandoc escapes balanced delimiters as `\(`/`\[` even inside math, where Typst reads
# the backslash as an escape; inside a math span the brackets stand for themselves.
doc = re.sub(r"\$[^$\n]*\$",
             lambda m: m.group(0).replace("\\(", "(").replace("\\)", ")")
             .replace("\\[", "[").replace("\\]", "]"), doc)
# A `\label{}` inside a deluxetable caption reaches the writer as
# `#label("tab: FRB properties")`; Typst labels may not contain spaces.
doc = re.sub(r'#label\("([^"]*)"\)',
             lambda m: "<" + re.sub(r"[^A-Za-z0-9_.:\-]", "-", m.group(1)) + ">", doc)
# A `\label` that followed the closing `$` of a display is written as `#<x>`, which
# Typst parses as a code expression and then chokes on every following math group
# ("unclosed delimiter" cascades). It is a plain label.
doc = re.sub(r"#<([\w:.\-]+)>", r"<\1>", doc)
def _close_unterminated_display(t):
    """A display whose closing `$` went missing swallows every following
    paragraph into math (cascading "unclosed delimiter" errors). The tell is a
    line that opens with `$`, ends in a label, and still has an odd `$` count."""
    def fix(m):
        line, lab = m.group(1), m.group(2)
        if line.count("$") % 2:
            return line.rstrip() + " $\n" + lab
        return m.group(0)
    return re.sub(r"(?m)^(\$[^\n]*?)[ \t]*(<[\w:.\-]+>)[ \t]*$", fix, t)
doc = _close_unterminated_display(doc)
def delink(m):
    return m.group(0) if m.group(1) in defined else re.sub(r"[{}]", "", m.group(2) or "")
doc = re.sub(r"#link\(<([\w:.\-]+)>\)(\[[^\[\]]*\])?", delink, doc)# bind stray labels after closed equations: '$ <label>' -> '$<label>'
doc = re.sub(r"\$\s+<([\w:.+\-]+)>", r"$<\1>", doc)
# Title-block notes (see _blfootnote_to_marker): small print, left aligned.
doc = re.sub(r"QQBLNOTEQQ(.*?)QQBLNENDQQ",
             lambda m: "#align(left)[#text(8pt)[%s]]" % m.group(1).strip(), doc, flags=re.S)


def _dedupe_heading_labels(t):
    """A heading that keeps the source \\label and is followed by the slug label
    labels the same content twice; Typst keeps only the last one and refs to
    the first stop resolving. Re-point refs at the retained label."""
    lines = t.split("\n")
    alias = {}
    for i in range(len(lines) - 1):
        m1 = re.fullmatch(r"(=+ .*?)\s*<([\w:.\-]+)>", lines[i].strip())
        m2 = re.fullmatch(r"<([\w:.\-]+)>", lines[i + 1].strip())
        if m1 and m2 and m1.group(2) != m2.group(1):
            lines[i] = m1.group(1)
            alias[m1.group(2)] = m2.group(1)
    if not alias:
        return t
    t = "\n".join(lines)
    for old, new in alias.items():
        t = re.sub(r"@%s\b" % re.escape(old), "@" + new, t)
        t = t.replace("#ref(<%s>)" % old, "#ref(<%s>)" % new)
    return t


doc = _dedupe_heading_labels(doc)


def _dedupe_marks(t):
    """pandoc writes a caption's `\\label` as `#<label>` and the float's own label
    follows as a `<label>` line; Typst registers the same label twice and errors."""
    defs = set(re.findall(r"(?m)^<([\w:.\-]+)>\s*$", t))
    return re.sub(r"#<([\w:.\-]+)>", lambda m: "" if m.group(1) in defs else m.group(0), t)


doc = _dedupe_marks(doc)
if bibname:
    csl = ""
    if re.search(r"\\documentclass(\[[^\]]*\])?\{nature\}", preamble):
        src_csl = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "tools", "nature.csl")
        if os.path.exists(src_csl):
            shutil.copy(src_csl, os.path.join(PAPER, "nature.csl"))
            csl = ', style: "nature.csl"'
    title = ', title: [References]' if csl else ""   # nature.cls heads the list "References"
    doc += f'\n#bibliography("{bibname}"{csl}{title})\n'
open(os.path.join(PAPER, "main.typ"), "w", encoding="utf-8").write(doc)

def _localize_images():
    """`image("figs/x.pdf")` is paper-relative, but arXiv sources keep figs under
    src/; copy each missing target to the path the document expects."""
    t = read(os.path.join(PAPER, "main.typ"))
    for p in sorted(set(re.findall(r'image\("([^"]+)"', t))):
        if p.startswith("../") or os.path.isfile(os.path.join(PAPER, p)):
            continue
        cands = glob.glob(os.path.join(SRC, "**", os.path.basename(p)), recursive=True)
        f = next((c for c in cands if os.path.isfile(c)), None)
        if f:
            dst = os.path.join(PAPER, p)
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            shutil.copy(f, dst)
_localize_images()

# Dumps are incomplete: rebuild cited entries missing from refs.bib out of the
# paper's own .bbl before the first compile.
if bibname:
    import bblmerge
    n = bblmerge.merge(PAPER, bblmerge.keys_in_typ(os.path.join(PAPER, "main.typ")))
    if n:
        print("bblmerge: added", n, "entries")


# ============ compile + fix loop ============
report = {"paper": os.path.basename(PAPER), "tikz": len(tikzs), "bib": bool(bibname)}
os.makedirs(os.path.join(PAPER, "build"), exist_ok=True)
pdf = os.path.join(PAPER, "build", "main.pdf")
for attempt in range(4):
    c = run(["typst", "compile", os.path.join(PAPER, "main.typ"), pdf])
    if c.returncode == 0 and os.path.getsize(pdf) > 20000:
        report["compiled"] = True
        break
    if c.returncode == 0:
        c.returncode = 1
        c.stderr = "compiled to a near-empty PDF (%d bytes) - document body is missing or broken" % os.path.getsize(pdf)
    errs = (c.stderr or "")[:2500]
    report["last_errors"] = errs
    print(f"--- compile errors (attempt {attempt+1}) ---\n{errs[:1500]}")
    # deterministic repair first: balance brackets / escape stray specials on error lines
    doc = read(os.path.join(PAPER, "main.typ"))
    fixed = auto_fix(doc, (c.stderr or ""))
    if fixed != doc:
        open(os.path.join(PAPER, "main.typ"), "w", encoding="utf-8").write(fixed)
        c = run(["typst", "compile", os.path.join(PAPER, "main.typ"), pdf])
        if c.returncode == 0 and os.path.getsize(pdf) > 20000:
            report["compiled"] = True
            report["auto_fixed"] = True
            break
        errs = (c.stderr or "")[:2500]
        report["last_errors"] = errs
    if os.environ.get("NOFIX") == "1":
        break
    fix_prompt = (
        f"The Typst file main.typ in the current directory fails to compile. Compiler output:\n{errs}\n\n"        f"Consult the Typst skill at {os.path.join(SKILLS, 'claude-skill-typst-main', 'skills', 'typst', 'SKILL.md')} and cetz skill at {os.path.join(SKILLS, 'typst-cetz-skills-main', 'cetz', 'SKILL.md')} if needed. "
        "Edit main.typ IN PLACE to fix ALL errors minimally (you may delete broken leftover LaTeX artifacts, fix imports, correct cetz code). Keep the document content intact - do not rewrite sections wholesale. Open only main.typ in the given directory; do not explore other files and do not run any commands. "
    )
    try:
        cb(fix_prompt, PAPER, timeout=600)
    except Exception as e:
        print("cb fix fail", e)
        continue

# elegance polish pass (only if we have a compiling doc)
if report.get("compiled") and os.environ.get("POLISH", "1") == "1":
    polish = (
        "Polish main.typ in the current directory for ELEGANT idiomatic Typst: "
        "1) replace escaped literal constructs like \\$\\\\ket{+}\\$ with proper typst math ($|+\\u27e9$); "
        "2) convert `#heading(level: 2, numbering: none)[X]` calls into `=== X` heading syntax where safe; "
        "3) fix awkward `$\"\"^87$Rb` isotope superscripts to `$\"\"^\"87\"$Rb` or `^87 Rb` text; "
        "4) ensure figures use caption: [...] consistently and labels are meaningful (<fig-x> style anchors for cross-refs used in text); "
        "5) keep content identical, do not remove sections. "
        f"Reference the typst skill docs at {os.path.join(SKILLS, 'claude-skill-typst-main', 'skills', 'typst')}. "
        "After editing, run: typst compile main.typ build/main.pdf ; iterate until it compiles with zero errors. Do not finish while compilation fails."
    )
    try:
        cb(polish, PAPER, timeout=900)
    except Exception as e:
        print("polish fail", e)
    c = run(["typst", "compile", os.path.join(PAPER, "main.typ"), pdf])
    report["after_polish"] = c.returncode == 0 and os.path.getsize(pdf) > 20000
json.dump(report, open(os.path.join(PAPER, "report.json"), "w", encoding="utf-8"), indent=1)
print("RESULT:", json.dumps(report)[:400])
