"""Deterministic Typst repairs. No model needed."""
import re

LANG = "⟨"
RANG = "⟩"
CDOTS = "⋯"
LDOTS = "…"


def _ket(m):
    return "| " + m.group(1) + " " + RANG


def _bra(m):
    return LANG + " " + m.group(1) + " |"


def _upright(m):
    return '"' + m.group(1) + '"'


def _bold(m):
    return "bold(" + m.group(1) + ")"


def _italic(m):
    return "italic(" + m.group(1) + ")"


def _drop(m):
    return ""


def _ket2(m):
    """`⟨ rangle(...)` -> `⟨...⟩`, matching the paren that closes the group."""
    s, i = m.string, m.end() - 1
    d, j = 0, i
    while j < len(s):
        if s[j] == "(":
            d += 1
        elif s[j] == ")":
            d -= 1
            if d == 0:
                break
        j += 1
    return "⟨" + s[i + 1:j] + "⟩"


# bare TeX-ish names Typst reports as unknown variables -> unicode, never deleted
SYMS = {
    "neq": "≠", "leq": "≤", "geq": "≥", "approx": "≈", "equiv": "≡",
    "cdots": CDOTS, "ldots": LDOTS, "dots": LDOTS, "infty": "∞",
    "propto": "∝", "otimes": "⊗", "oplus": "⊕", "partial": "∂",
    "langle": LANG, "rangle": RANG, "pm": "±", "mp": "∓",
}


RULES = [
    (re.compile(r"\\(?:ket|Ket)\s*\{([^{}]*)\}"), _ket),
    (re.compile(r"\\(?:bra|Bra)\s*\{([^{}]*)\}"), _bra),
    (re.compile(r"\\(?:rm|textrm|mathrm|text|textnormal|mbox|operatorname)\s*\{([^{}]*)\}"), _upright),
    (re.compile(r"\\(?:bf|textbf|mathbf|bm)\s*\{([^{}]*)\}"), _bold),
    (re.compile(r"\\(?:it|textit|mathit|emph)\s*\{([^{}]*)\}"), _italic),
    (re.compile(r"\\(?:scriptsize|footnotesize|small|large|Large|LARGE|huge)\s*"), _drop),
    (re.compile(r"\\(?:rm|bf|it|em|sf|tt)\s+"), _drop),
    (re.compile(r"\\cdots?"), lambda m: CDOTS),
    (re.compile(r"\\ldots?"), lambda m: LDOTS),
    (re.compile(r"\\(?:substack|boxed)\s*\{([^{}]*)\}"), lambda m: m.group(1)),
]

RULES += [
    (re.compile(r"#show\s+math\.equation\.\(([^)]*)\)"),
     lambda m: "#show math.equation.where(" + m.group(1) + ")"),
    (re.compile(r"\bangle\.l\b"), lambda m: "⟨"),
    (re.compile(r"\bangle\.r\b"), lambda m: "⟩"),
    (re.compile(r"⟨\s*rangle\s*\("), _ket2),
    (re.compile(r"#set\s+figure(?:\.caption)?\(\s*(?:caption-pos\s*:\s*)?:?\s*(bottom|top)\s*\)?"),
     lambda m: "#set figure(placement: " + m.group(1) + ")"),
    (re.compile(r"#cite\(label\(\s*\"([^\"]+)\"\s*\)\)"), lambda m: "@" + m.group(1)),
    (re.compile(r"#label\(\s*(?:\"[^\"]*\"|[A-Za-z0-9_.:-]+)\s*\)"), lambda m: ""),
    (re.compile(r"[_^]\(\s*\)"), lambda m: ""),
    (re.compile(r"\bquad\s+implies\b"), lambda m: "quad ⇒"),
    (re.compile(r"(?<![A-Za-z])(?:tsim|gtrsim)(?![A-Za-z])"), lambda m: "≳"),
    (re.compile(r"(?<![A-Za-z])lesssim(?![A-Za-z])"), lambda m: "≲"),
    (re.compile(r"[_^]\(\"\"\s*\)"), lambda m: ""),
    (re.compile(r"\bbra\s*\(([^()]*)\)\s*rangle"), lambda m: "⟨" + m.group(1) + "⟩"),
    (re.compile(r"([\^_])\s+(\$)"), lambda m: " " + m.group(2)),
    # A run of three or more dollars is damaged display math; two adjacent
    # inline spans (`$a$$b$`) are valid Typst and must keep both delimiters.
    (re.compile(r"(?<!\\)\$\$\$+(?:\\\$)*\$?"), lambda m: "$"),
]


def latex_text_fix(typ):
    for pat, fn in RULES:
        typ = pat.sub(fn, typ)
    return typ


def unknown_var_fix(typ, err):
    """Turn names Typst reports as unknown variables into operators, never delete them."""
    names = set(re.findall(r"unknown variable: ([A-Za-z][\w-]*)", err))
    names |= set(re.findall(r"unknown symbol modifier: ([\w.]+)", err))
    for n in names:
        esc = re.escape(n)
        # roman sub/superscript words (`_ef`, `^max`) are text, not variables
        typ = re.sub(r"([_^])\{?" + esc + r"\b\}?", lambda m, s=n: m.group(1) + '("' + s + '")', typ)
        sym = SYMS.get(n)
        if sym:
            typ = re.sub(r"\\" + esc + r"\s*\{([^{}]*)\}", lambda m, s=sym: s + " " + m.group(1), typ)
            typ = re.sub(r"(?<![\w\\])" + esc + r"\b", sym, typ)
            continue
        # A name Typst rejected is only ever removed where it is still a TeX macro.
        # Bare-name matching ate letters of English words ("evaporate" -> "evapora").
        typ = re.sub(r"\\" + esc + r"\s*\{([^{}]*)\}", _upright, typ)
        typ = re.sub(r"(?<![\w\\])\\" + esc + r"\b", "", typ)
    return typ


def _balance(s):
    """Escape unpaired emphasis markers and close unbalanced content brackets."""
    out, depth = [], 0
    prev = ""
    for ch in s:
        if prev == "\\":
            out.append(ch)
            prev = ""
            continue
        if ch == "[":
            depth += 1
        elif ch == "]":
            if depth == 0:
                out.append("\\]")
                continue
            depth -= 1
        out.append(ch)
        prev = ch
    res = "".join(out)
    if res.replace("\\*", "").count("*") % 2:
        res = res.replace("*", "\\*", 1)
    return res + "]" * depth


def _fix_line(s):
    s = s.replace("//", "\\#\\#/")               # literal slashes, never a comment
    s = re.sub(r"#(?![A-Za-z\[\]])", "\\#", s)  # escape inert '#' markup chars
    s = re.sub(r"(?<!\\)~(?=[A-Za-z0-9])", " ", s)
    return _balance(s)


def auto_fix(typ, err):
    """Apply the deterministic repairs the compiler's error report points at."""
    typ = latex_text_fix(typ)
    typ = unknown_var_fix(typ, err)
    lines = typ.split("\n")
    todo = sorted(set(int(m) for m in re.findall(r"main\.typ:(\d+):", err)), reverse=True)
    for ln in todo:
        i = ln - 1
        if not (0 <= i < len(lines)):
            continue
        s = lines[i]
        if s.lstrip().startswith("//"):
            lines[i] = ""
            continue
        lines[i] = _fix_line(s)
    return "\n".join(lines)
