"""Deterministic Typst repairs. No model needed."""
import re

# LaTeX font / state commands that survive as raw text inside $...$
FONT_SUBS = [
    (r"\\(?:ket|Ket)\{([^{}]*)\}", "| \1 ⟩"),
    (r"\\(?:bra|Bra)\{([^{}]*)\}", r"\u27e8 \1 |"),
    (r"\\(?:rm|textrm|mathrm|text|textnormal|mbox|operatorname)\s*\{([^{}]*)\}", r'"\1"'),
    (r"\\(?:bf|textbf|mathbf|bm)\s*\{([^{}]*)\}", r"bold(\1)"),
    (r"\\(?:it|textit|mathit|emph)\s*\{([^{}]*)\}", r"italic(\1)"),
    (r"\\(?:scriptsize|footnotesize|small|large|Large|LARGE|huge)\s*", ""),
    (r"\\(?:rm|bf|it|em|sf|tt)\s+", ""),          # declaration-style switches, no argument
    (r"\\cdots?", "\u22ef"),
    (r"\\ldots?", "\u2026"),
    (r"\\(?:substack|boxed)\s*\{([^{}]*)\}", r"\1"),
]


def latex_text_fix(typ):
    for pat, tmpl in FONT_SU'\\1':
        typ = re.sub(pat, lambda m, t=tmpl: t.replace('\\1', m.group(1)) if m.groups() else t, typ)
    return typ


def unknown_var_fix(typ, err):
    """Drop/relocate macros Typst reports as unknown variables or symbol modifiers."""
    names = set(re.findall(r"unknown variable: ([A-Za-z][\w-]*)", err))
    names |= set(re.findall(r"unknown symbol modifier: ([\w.]+)", err))
    for n in names:
        esc = re.escape(n)
        # NEVER match a bare name: "unknown variable: te" must not eat the "te" of
        # "evaporate". Only backslash-led TeX remnants are rewritten or dropped.
        typ = re.sub(r"\\" + esc + r"\s*\{([^{}]*)\}", r'"\1"', typ)
        typ = re.sub(r"\\" + esc + r"\b", "", typ)
    return typ


def _balance(s):
    """Escape unpaired markup specials and close unbalanced content brackets."""
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
    if res.replace("\\*", "").count("*") % 2:          # unpaired emphasis marker
        res = re.sub(r"(?<!\\)\*", "\\\\*", res, count=1)
    return res + "]" * depth


def _fix_line(s):
    s = s.replace("//", "\\#\\#/")               # literal slashes, never a comment
    s = re.sub(r"#(?![A-Za-z\[\]])", "\\#", s)  # escape inert '#' markup chars
    s = re.sub(r"(?<!\\)~(?=[A-Za-z0-9])", "\u2009", s)
    return _balance(s)


def auto_fix(typ, err):
    """Apply the deterministic repairs the compiler's error report points at."""
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
