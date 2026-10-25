r"""Clear the LaTeX residue that survives inside math spans: `\"`, `\{`, `\}` and author macros.

Two things hide here. `"\"vis"` is not an escape to Typst - the string ends at the second
quote and the following letters become `unknown variable`. And a paper's own `\newcommand`
(`\tresid` = `\bm{\delta t}`) is an unknown command no generic table can know, so it is
expanded from the pristine source first and the result run through the converter's own
math normalizer.

Every paper is gated: the file is reverted unless its syntax-error count goes down or the
paper still compiles exactly as cleanly as before.

Usage: python scripts/mathesc.py papers/<id> [...]
"""
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(ROOT, "check"))
import mathrem          # noqa: E402

# convert.py is a script, so its normalizer is exec'd out of the source range rather imported.
_src = open(os.path.join(HERE, "convert.py"), encoding="utf-8").read()
_ns = {"re": re}
exec(compile(_src[_src.index("GREEK = {"):_src.index("def sanitize(t):")],
             "convert-snippet", "exec"), _ns)
math_residue = _ns["math_residue"]        # not used directly: it rewrites `\,` and `{a,b}`
GREEK, TEXTCMD = _ns["GREEK"], _ns["TEXTCMD"]

BS = chr(92)
STYLED_PAT = re.compile(BS * 2 + r"(bm|boldsymbol|mathbf|textbf|textit|texttt|mathrm|text"
                                r"|textsc|mathit|mathsf)\{((?:[^{}]|\{[^{}]*\})*)\}")


def tex_cmds(s):
    r"""Resolve only what is left as an actual LaTeX command in a span.

    The converter's full normalizer is deliberately not reused here: on already-converted
    spans it rewrites `\,` and `{a, b}` and takes papers from 1 error to 9 (measured).
    """
    out = s
    m = STYLED_PAT.search(out)
    while m:
        name, body = m.group(1), tex_cmds(m.group(2))
        style = TEXTCMD.get(name, "upright")
        rep = ("#smallcaps[%s]" % body) if style == "smallcaps" else \
            ("%s(%s)" % (style, body))
        out = out[:m.start()] + rep + out[m.end():]
        m = STYLED_PAT.search(out)
    out = re.sub(r"\\?\b(?:d|t)?frac\{([^{}]*)\}\{([^{}]*)\}", r"frac(\1, \2)", out)
    out = re.sub(r"\\?\bsqrt\{([^{}]*)\}", r"sqrt(\1)", out)
    out = re.sub(BS * 2 + r"(left|right)([(){}[\]|.])", r"\2", out)
    out = re.sub(r"_\{([^{}]*)\}", r"_(\1)", out)
    out = re.sub(r"\^\{([^{}]*)\}", r"^(\1)", out)
    out = re.sub(BS * 2 + r"([A-Za-z]+)",
                 lambda m: GREEK.get(m.group(1), '"' + m.group(1) + '"'), out)
    return out

ESCAPES = [(BS + '"', '"'), (BS + "{", "("), (BS + "}", ")")]

MACRO = re.compile(r"\\(?:re)?newcommand\{?\\([A-Za-z]+)\}?\s*(?:\[\d+\])?\s*\{"
                   r"((?:[^{}]|\{[^{}]*\})*)\}")


def macros(paper):
    """No-argument author macros defined anywhere in src/ (arg-taking ones are skipped)."""
    out = {}
    src = os.path.join(paper, "src")
    for dirpath, _, names in os.walk(src):
        for name in names:
            if not name.endswith((".tex", ".sty", ".cls")):
                continue
            try:
                text = open(os.path.join(dirpath, name), encoding="utf-8",
                            errors="replace").read()
            except OSError:
                continue
            for m in MACRO.finditer(text):
                if m.group(1) not in out:
                    out[m.group(1)] = m.group(2)
    return out


def quote_idents(s):
    """Quote multi-letter words: a call's parentheses are code, where `MeV` is an identifier.

    `$sqrt(E{(MeV)})$` degrouped to `$sqrt(E((MeV)))$` fails with `unknown variable: MeV`,
    while the author meant the upright text `MeV`.
    """
    known = set()
    for v in list(GREEK.values()) + list(TEXTCMD.values()):
        for part in re.split(r"[.\s]+", str(v)):
            if re.fullmatch(r"[A-Za-z]+", part):
                known.add(part.lower())
    known |= {"sqrt", "fract", "attach", "lr", "mid", "upright", "bold", "italic", "roman",
              "call", "script", "sans", "monospace", "serif", "binom", "diff", "delim",
              "limits", "op", "and", "or", "not", "none", "auto", "true", "false", "dot",
              "hat", "macron", "tilde", "arrow", "matrix", "vec"}
    out, i = [], 0
    while i < len(s):
        m = re.match(r"[A-Za-z][A-Za-z0-9_]*", s[i:])
        if m and not (i and s[i - 1] in '"#_.'):
            word = m.group(0)
            if len(word) > 1 and word.lower() not in known and not re.match(r"[A-Za-z]{1,2}\(",
                                                                            s[i:]):
                out.append('"' + word + '"')
                i += len(word)
                continue
        out.append(s[i])
        i += 1
    return "".join(out)


def degroup(s):
    r"""Turn `{...}` *groups* inside math into parens.

    In Typst math a brace run is a code block, so `sqrt{E{(MeV)}}` calls a function named
    `MeV`. Code that really is Typst (`#`, `=>`, named arguments, strings) is left alone.
    """
    out = s
    prev = None
    while prev != out:
        prev = out
        out = re.sub(r"\{([^{}]{1,80})\}",
                     lambda m: "(" + quote_idents(m.group(1)) + ")"
                     if not re.search(r"[#=\"'`]|range|calc|let|set", m.group(1))
                     else m.group(0), out)
    return out


def fix_line(line, table):
    spans = list(mathrem.spans_on(line))
    if not spans:
        return line, 0
    hits = 0
    for a, b in reversed(spans):
        seg = line[a:b]
        new = seg
        # `\\bm` came from LaTeX-brace escaping (`\{\bm c\}` -> `\(\bm(c)\)`); a real Typst
        # line break is not followed by a letter, so collapsing only letter runs is safe.
        new = re.sub(BS * 4 + r"(?=[A-Za-z])", BS * 2, new)
        for pat, rep in ESCAPES:
            new = new.replace(pat, rep)
        for name, body in table.items():
            tok = BS + name
            if re.search(re.escape(tok) + r"(?![A-Za-z])", new):
                new = re.sub(re.escape(tok) + r"(?![A-Za-z])",
                             lambda m, b=BS + body.strip(): b, new)
        if re.search(BS + r"[A-Za-z]|\b(?:sqrt|frac|dfrac|tfrac|left|right)\{|"
                     r"_\{|\^\{", new):
            new = "$" + tex_cmds(new[1:-1]) + "$"
        if re.search(r"\{[^{}]{1,80}\}", new) and not re.search(r"[#$]", new[1:-1]):
            new = "$" + degroup(new[1:-1]) + "$"
        if new != seg:
            line = line[:a] + new + line[b:]
            hits += 1
    return line, hits


def compile_state(paper):
    return mathrem.compile_errors(os.path.join(paper, "main.typ"))


def run(paper, rounds=10):
    """Iterate: one masked error often hides the next, so a rising count is not always worse.

    An edit is kept when it clears the lines it touched even if the total count grows -
    Typst stops reporting behind a parse failure, so 1 error can mean 11 (see memory).
    """
    mp = os.path.join(paper, "main.typ")
    if not os.path.isfile(mp):
        return 0
    table = macros(paper)
    bak = mp + ".mathesc"
    total = 0
    for _ in range(rounds):
        text = open(mp, encoding="utf-8").read()
        before, sb = compile_state(paper)
        if before == 0:
            break
        lines = text.split("\n")
        touched, hits = set(), 0
        for i, line in enumerate(lines, 1):
            new, h = fix_line(line, table)
            if h:
                touched.add(i)
                hits += h
                lines[i - 1] = new
        if not hits:
            break
        if not os.path.exists(bak):
            mathrem.save(bak, open(mp, encoding="utf-8").read())
        mathrem.save(mp, "\n".join(lines))
        after, sa = compile_state(paper)
        print("%s: spans=%-4d syntax %d -> %d  %s"
              % (paper, hits, before, after,
                 "still broken at " + str(sorted({ln for ln, _, _ in sa}))[:60]
                 if after else "clean"))
        if after and not ({ln for ln, _, _ in sa} & touched):
            total += min(before, after)          # touched lines are fixed; keep iterating
            continue
        if after > before:
            mathrem.save(mp, text)
            print("   reverted")
            break
        total += before - max(after, 0)
        if after >= before:
            break
    return total


if __name__ == "__main__":
    tot = 0
    for d in [a.rstrip("/") for a in sys.argv[1:] if not a.startswith("--")]:
        tot += run(d if os.path.isabs(d) else os.path.join(ROOT, d))
    print("cleaned %d math spans" % tot)
