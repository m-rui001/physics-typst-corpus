"""Deterministic converter for raw LaTeX blocks that pandoc left verbatim in main.typ.

Handles math environments (equation/align/gather/split/cases/matrices), brace-aware
macro rewriting (frac/sqrt/text/hat/...), figure floats and simple tabulars.
Then runs a compile loop using typrepair without deleting content.
"""
import os, re, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from typrepair import auto_fix

MATH_ENVS = {"equation", "equation*", "align", "align*", "gather", "gather*",
             "multline", "multline*", "flalign", "flalign*", "eqnarray", "eqnarray*",
             "split", "cases", "matrix", "pmatrix", "bmatrix", "vmatrix", "Vmatrix",
             "smallmatrix", "array", "aligned", "gathered"}
DELIM = {"pmatrix": '"("', "bmatrix": '"["', "Bmatrix": '"{"', "vmatrix": '"|"',
         "Vmatrix": '"||"', "smallmatrix": "#none", "matrix": "#none", "array": "#none"}
SUB = {"cases": "cases", "aligned": "aligned", "gathered": "cases", "split": "aligned"}


def run(cmd, cwd, timeout=180):
    return subprocess.run(cmd, cwd=cwd, capture_output=True, text=True,
                          encoding="utf-8", errors="replace", timeout=timeout)


def grab(s, i):
    """Balanced {...} starting at s[i]=='{'; return (inner, index_after)."""
    d, j = 0, i
    while j < len(s):
        if s[j] == "\\":
            j += 2
            continue
        if s[j] == "{":
            d += 1
        elif s[j] == "}":
            d -= 1
            if d == 0:
                return s[i + 1:j], j + 1
        j += 1
    return s[i + 1:], len(s)


def arg_after(s, i):
    """Read the next argument (braced, single char, or optional [..]) after index i."""
    while i < len(s) and s[i] in " \t":
        i += 1
    if i >= len(s):
        return "", i
    if s[i] == "{":
        return grab(s, i)
    if s[i] == "[":
        k = s.find("]", i)
        return s[i + 1:k], (k + 1 if k > 0 else i + 1)
    if s[i] == "\\":
        m = re.match(r"\\[A-Za-z]+", s[i:])
        if m:
            return m.group(0), i + m.end()
    return s[i], i + 1


def macros(s):
    """Brace-aware LaTeX macro -> Typst math rewriting."""
    REP = [
        (r"\\left\s*([.|\[\](){}<>])", lambda m: "" if m.group(1) == "." else m.group(1)),
        (r"\\right\s*([.|\[\](){}<>])", lambda m: "" if m.group(1) == "." else m.group(1)),
        (r"\\(?:nonumber|notag|displaystyle|textstyle|limits|nolimits|,|;|:|!|quad|qquad)", " "),
        (r"\\(?:bm|boldsymbol|mathbf|bfseries)\s*", "bold "),
        (r"\\(?:mathcal|mathscr)\s*", "cal "),
        (r"\\(?:mathtt|texttt|verb)\s*", "mono "),
        (r"\\(?:mbox|textrm|mathrm|rm)\s*", ""),
        (r"\\operatorname\s*", ""),
        (r"\\hline|\\toprule|\\midrule|\\bottomrule", " "),
        (r"\\bigl|\\bigr|\\Bigl|\\Bigr|\\biggl|\\biggr|\\Biggl|\\Biggr|\\big|\\Big|\\bigg|\\Bigg", ""),
        (r"\\dddot", "dddot"), (r"\\dotdot", "ddot"),
    ]
    for pat, r in REP:
        s = re.sub(pat, r, s)
    names = {"frac": "frac", "dfrac": "frac", "tfrac": "frac", "cfrac": "frac",
             "binom": "binom", "dbinom": "binom", "sqrt": "sqrt", "overline": "overline",
             "underline": "underline", "hat": "hat", "widehat": "hat", "tilde": "tilde",
             "widetilde": "tilde", "bar": "overline", "vec": "vec", "dot": "dot",
             "ddot": "ddot", "check": "check", "acute": "acute", "breve": "breve",
             "overrightarrow": "vec", "stackrel": "stackrel", "sideset": ""}
    text = {"text": '"', "textit": '"', "emph": '"', "mbox": '"', "hbox": '"'}
    i, out = 0, []
    while i < len(s):
        m = re.compile(r"\\([A-Za-z]+)").search(s, i)
        if not m:
            out.append(s[i:])
            break
        out.append(s[i:m.start()])
        name = m.group(1)
        j = m.end()
        if name in text:
            a, j2 = arg_after(s, j)
            out.append('"' + a.replace('"', "'") + '"')
        elif name in names:
            fn = names[name]
            a, j = arg_after(s, j)
            if fn == "sqrt":
                out.append("sqrt(" + a + ")")
            elif fn == "stackrel":
                b, j = arg_after(s, j)
                out.append(b + " over " + a)
            else:
                b, j = arg_after(s, j)
                out.append("%s(%s, %s)" % (fn, a, b))
        elif name in ("int", "oint", "iint", "sum", "prod", "coprod", "bigcup",
                      "bigcap", "lim", "max", "min", "limsup", "liminf"):
            pre, post = "", ""
            while True:
                k = j
                while k < len(s) and s[k] in " \t":
                    k += 1
                if k < len(s) and s[k] in "_^" and k + 1 < len(s) and s[k + 1] == "{":
                    a, k2 = grab(s, k + 1)
                    if s[k] == "_":
                        pre = pre + "_(" + a + ")"
                    else:
                        post = post + "^(" + a + ")"
                    j = k2
                    continue
                if k < len(s) and s[k] in "_^" and k + 1 < len(s) and re.match(r"\\[A-Za-z]|\d", s[k + 1:]):
                    m2 = re.match(r"(\\[A-Za-z]+|\d)", s[k + 1:])
                    a = m2.group(1).lstrip("\\")
                    j = k + 1 + m2.end()
                    if s[k] == "_":
                        pre += "_(" + a + ")"
                    else:
                        post += "^(" + a + ")"
                    continue
                break
            out.append(name + pre + post)
        else:
            out.append(m.group(0))
        i = j
    s = "".join(out)
    s = re.sub(r"\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|ell|hbar|partial|nabla|infty|forall|exists|emptyset|varnothing|cdot|cdots|ldots|dots|times|div|pm|mp|leq|le|geq|ge|neq|ne|approx|equiv|sim|simeq|cong|propto|in|notin|ni|subset|subseteq|supset|supseteq|cup|cap|setminus|rightarrow|longrightarrow|leftarrow|longrightarrow|leftrightarrow|Rightarrow|Leftarrow|Leftrightarrow|mapsto|uparrow|downarrow|oplus|ominus|otimes|odot|perp|parallel|wedge|vee|neg|lnot|langle|rangle|dagger|Re|Im|deg|log|ln|exp|sin|cos|tan|arctan|sinh|cosh|tanh|arg|det|dim|gcd|hom|ker|sup|inf|max|min|tr|Tr|Var|Cov|corr|unit|SI)\b",
              lambda m: " " + m.group(1) + " ", s)
    s = re.sub(r"\s{3,}", "  ", s)
    return s.strip()


def innermost_env(t):
    """Return (start, end, env, body) of the first innermost LaTeX environment."""
    best = None
    for m in re.finditer(r"\\begin\{([^{}]+)\}", t):
        e = m.end()
        depth, i = 1, e
        while i < len(t):
            m2 = re.compile(r"\\(begin|end)\{[^{}]+\}").search(t, i)
            if not m2:
                break
            if m2.group(1) == "begin":
                depth += 1
            else:
                depth -= 1
                if depth == 0:
                    if best is None or m2.start() < best[1]:
                        cand = (m.start(), m2.end(), m.group(1), t[e:m2.start()])
                        best = cand
                    break
            i = m2.end()
        else:
            break
    return best


def conv_env(env, body):
    star = env.endswith("*")
    base = env.rstrip("*")
    if base == "cases":
        rows = [macros(r) for r in re.split(r"\\\\", body) if r.strip()]
        return "cases(" + ", ".join(rows) + ")"
    if base in ("aligned", "gathered", "split"):
        rows = [macros(r) for r in re.split(r"\\\\", body) if r.strip()]
        return " \\\n  ".join(rows)
    if base in DELIM:
        rows = [r for r in re.split(r"\\\\", body) if r.strip()]
        cells = []
        for r in rows:
            for c in r.split("&"):
                if c.strip():
                    cells.append(macros(c))
        cols = max((len(r.split("&")) for r in rows if r.strip()), default=1)
        extra = "cols: %d, " % cols if cols > 1 and base in ("array", "smallmatrix") else ""
        return "mat(delim: %s, %s%s)" % (DELIM[base], extra, ", ".join(cells))
    # display math environments
    lab = ""
    for m in re.finditer(r"\\label\{([^{}]*)\}", body):
        lab = "<" + m.group(1) + ">"
    body = re.sub(r"\\label\{[^{}]*\}", " ", body)
    body = re.sub(r"\\tag\{[^{}]*\}", " ", body)
    body = re.sub(r"\\intertext\{([^{}]*)\}", lambda m: ' "\1" ', body)
    body = re.sub(r"\\(?:noalign|caption)\s*\{[^{}]*\}", " ", body)
    multi = base in ("align", "gather", "multline", "flalign", "eqnarray")
    rows = [r for r in re.split(r"\\\\", body) if r.strip()]
    if not rows:
        return "$ $%s" % lab
    out = []
    for r in rows:
        if multi and base.startswith(("align", "eqnarray", "flalign")):
            r = "&".join(c.strip() for c in r.split("&"))
        out.append(macros(r))
    return "$ " + " \\\n  ".join(out) + " $" + lab


def convert_text(t):
    for _ in range(400):
        e = innermost_env(t)
        if not e:
            break
        st, en, env, body = e
        if env in MATH_ENVS:
            t = t[:st] + conv_env(env, body) + t[en:]
        elif env in ("figure", "table", "tabular", "center", "array"):
            t = t[:st] + conv_float(env, body) + t[en:]
        elif env in ("tabularx", "array", "matrix"):
            t = t[:st] + conv_env(env, body) + t[en:]
        else:
            t = t[:st] + macros(body) + t[en:]
    t = re.sub(r"\\caption\s*\{", "caption: [", t)
    t = re.sub(r"\\includegraphics(\[[^\]]*\])?\{([^{}]*)\}",
               lambda m: 'image("imgs/%s.png")' % os.path.basename(m.group(2)), t)
    t = re.sub(r"\\centering", " ", t)
    return t


def conv_float(env, body):
    if env == "figure":
        lab = ""
        m = re.search(r"\\label\{([^{}]*)\}", body)
        if m:
            lab = "<" + m.group(1) + ">"
        inner = re.sub(r"\\label\{[^{}]*\}", " ", body)
        inner = re.sub(r"\\caption\s*\{([^{}]*)\}", lambda x: "caption: [" + x.group(1) + "]", inner)
        inner = re.sub(r"\\centering|\\vspace\[[^\]]*\]|\\vspace\{[^{}]*\}|\\hspace\{[^{}]*\}", " ", inner)
        inner = re.sub(r"\\begin\{(subfigure|minipage)\}(\[[^\]]*\])?(\{[^{}]*\})?", " ", inner)
        inner = re.sub(r"\\end\{(subfigure|minipage)\}", " ", inner)
        inner = re.sub(r"\\subcaptionbox\s*\{([^{}]*)\}", lambda x: "caption: [" + x.group(1) + "]", inner)
        inner = re.sub(r"\\caption\s*\{([^{}]*)\}", lambda x: "caption: [" + x.group(1) + "]", inner)
        return "#figure(" + inner.strip() + ")" + lab
    if env == "tabular":
        rows = [r for r in re.split(r"\\\\", body) if r.strip()]
        cells, cols = [], 1
        for r in rows:
            r = re.sub(r"\\hline|\\cline\{[^{}]*\}|\\multicolumn\{(\d+)\}\{[^{}]*\}", " ", r)
            cs = [c.strip() for c in r.split("&") if c.strip()]
            cols = max(cols, len(cs))
            cells += ["[" + macros(c) + "]" for c in cs]
        return "#table(columns: %d, rows: auto, column-gutter: 1em, %s)" % (cols, ", ".join(cells))
    inner = re.sub(r"\\caption\s*\{([^{}]*)\}", lambda x: "caption: [" + x.group(1) + "]", body)
    inner = re.sub(r"\\label\{([^{}]*)\}", "", inner)
    return inner


def _insert_numbering(t):
    """Number display equations so the `<label>`s we create are referenceable."""
    rule = '#set math.equation(numbering: "(1)", supplement: [Equation])\n'
    lines = t.split("\n")
    for i, l in enumerate(lines):
        s = l.strip()
        if s and not (s.startswith("#") or s.startswith("//") or s.startswith("@")):
            lines.insert(i, rule)
            return "\n".join(lines)
    return t + "\n" + rule


def process(paper):
    typ = os.path.join(paper, "main.typ")
    pdf = os.path.join(paper, "build", "main.pdf")
    os.makedirs(os.path.join(paper, "build"), exist_ok=True)
    t = open(typ, encoding="utf-8").read()
    n0 = len(re.findall(r"\\begin\{", t)) + t.count("\\frac") + t.count("\\label{")
    t2 = convert_text(t)
    if re.search(r"\$[^$]{0,2000}\$<[A-Za-z]", t2, re.S) and "math.equation(numbering" not in t2:
        t2 = _insert_numbering(t2)
    if t2 != t:
        open(typ + ".preblock", "w", encoding="utf-8").write(t)
        open(typ, "w", encoding="utf-8").write(t2)
    last = None
    for _ in range(14):
        c = run(["typst", "compile", "main.typ", pdf], paper)
        if c.returncode == 0 and os.path.exists(pdf) and os.path.getsize(pdf) > 20000:
            break
        err = (c.stderr or "")[:4000]
        if err == last:
            break
        last = err
        t3 = auto_fix(open(typ, encoding="utf-8").read(), err)
        if t3 == open(typ, encoding="utf-8").read():
            break
        open(typ, "w", encoding="utf-8").write(t3)
    t = open(typ, encoding="utf-8").read()
    left = len(re.findall(r"\\begin\{|\\frac|\\label\{|\\to |\\partial", t))
    ok = os.path.exists(pdf) and os.path.getsize(pdf) > 20000
    import json
    rp = os.path.join(paper, "report.json")
    j = {}
    if os.path.exists(rp):
        try:
            j = json.load(open(rp, encoding="utf-8"))
        except Exception:
            j = {}
    j["compiled"] = bool(ok)
    j["latexblock"] = {"before": n0, "after": left}
    json.dump(j, open(rp, "w", encoding="utf-8"), indent=1)
    return dict(paper=os.path.basename(paper), latex_before=n0, latex_after=left,
                pdf_kb=os.path.getsize(pdf) // 1024 if os.path.exists(pdf) else 0, ok=ok,
                last_err=(last or "").splitlines()[:2])


if __name__ == "__main__":
    import glob
    args = sys.argv[1:] or sorted(glob.glob(r"E:\phys\papers\2*"))
    for p in args:
        try:
            print(process(p), flush=True)
        except Exception as e:
            print("FAIL", p, repr(e)[:200], flush=True)
