r"""Rebuild display equations the converter left as escaped LaTeX blocks.

In the raw conversion a display equation appears as

    prose ... \$\$\\begin{equation}\n
    <escaped LaTeX body>\n
    \\label{eq:x}\n
    \\end{equation}\$\$ prose continues

The body can be un-escaped, macro-expanded from src/ and handed to pandoc; the
result replaces the whole block, with the label attached to the equation.

Usage: python -X utf8 scripts/deshatter.py [papers/...] [--dry]
Writes main.typ.deshattered before touching main.typ.
"""
import glob, os, re, shutil, subprocess, sys, tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import inlinetex as it

B = chr(92)
D = B + "$"
ENV = r"(?:equation\*?|eqnarray\*?|align\*?|gather\*?|multline\*?|displaymath)"
OPENER = re.compile(r"(?P<esc>" + re.escape(D + D + B + B) + r")begin\{" + ENV + r"\}")
CLOSER = re.compile(re.escape(B + B) + r"end\{" + ENV + r"\}(?:" + re.escape(D + D) + r")?")


def _fix_macro(body, name):
    if name in ("cal", "rm", "bf", "it", "sf", "tt", "bold", "bm"):
        target = {"cal": "mathcal", "rm": "mathrm", "bf": "mathbf",
                  "it": "mathit", "sf": "mathsf", "tt": "mathtt",
                  "bold": "mathbf", "bm": "boldsymbol"}[name]
        return body, lambda m, t=target: B + t
    if name.isalpha():
        return body, lambda m, t=name: B + "text{" + t + "}"
    return body, lambda m: m.group(0)[1:]


def pandoc_math(body, work):
    tmp = os.path.join(work, "_pop.tex")
    out = stderr = ""
    for _ in range(24):
        with open(tmp, "w", encoding="utf-8") as f:
            f.write("$" + body + "$\n")
        p = subprocess.run(["pandoc", tmp, "-f", "latex", "-t", "typst",
                            "--wrap=none"], capture_output=True, text=True,
                           encoding="utf-8", errors="replace")
        out, stderr = p.stdout.strip(), p.stderr or ""
        bad = re.search(r"unexpected control sequence \\(\S+)", stderr)
        if "Could not convert" not in stderr or not bad:
            break
        name = bad.group(1)
        pat = re.compile(re.escape(B) + re.escape(name) + r"(?![A-Za-z])")
        if not pat.search(body):
            break
        body, repl = _fix_macro(body, name)
        body = pat.sub(repl, body)
    try:
        os.unlink(tmp)
    except OSError:
        pass
    if "Could not convert" in stderr:
        return None
    if out.startswith("$") and out.endswith("$") and out.count("$") == 2:
        out = out[1:-1]
    return out.replace(B + "(", "(").replace(B + ")", ")")


def unescape(body):
    body = re.sub(re.escape(B + B) + r"label\{[^}]*\}", "", body)
    body = re.sub(re.escape(B) + r"label\{[^}]*\}", "", body)
    # \mkern spacing is used only to balance \overline; pandoc rejects it
    body = re.sub(re.escape(B) + r"mkern\s*-?[\d.]+\s*mu", "", body)
    body = body.replace(B + B, B)
    for a, b in ((B + "_", "_"), (B + "[", "["), (B + "]", "]"),
                 (B + "{", "{"), (B + "}", "}"), (B + '"', '"')):
        body = body.replace(a, b)
    body = re.sub(B + r"rm(?![A-Za-z])", lambda m: B + "mathrm", body)
    body = re.sub(r'"([A-Za-z][A-Za-z ]*)"',
                  lambda m: B + "text{" + m.group(1) + "}", body)
    return body


def convert_display(raw, mm, work):
    label = re.search(r"label\{([^}]*)\}", raw)
    label = label.group(1).strip().replace(B + "_", "_") if label else ""
    body = unescape(raw).strip()
    body = it.expand(body, mm)
    math = pandoc_math(body, work)
    if math is None:
        return None
    rep = "$\n  " + math + "\n$" + (" <" + label + ">" if label else "")
    return rep


def fix_inline(line, mm, work):
    """Convert \\$...\\$ pairs and double-escaped $...$ spans on one line."""
    out, i, n = [], 0, 0
    while True:
        a = line.find(D, i)
        if a < 0:
            out.append(line[i:])
            break
        b = line.find(D, a + 2)
        if b < 0:
            out.append(line[i:])
            break
        inner = it.expand(unescape(line[a + 2:b]).strip(), mm)
        out.append(line[i:a])
        m = pandoc_math(inner, work) if re.search(r"[\\^_]", inner) else None
        out.append("$" + (m if m is not None else inner) + "$")
        n += 1
        i = b + 2
    line = "".join(out)

    def repl(mo):
        inner = mo.group(1)
        if not re.search(r"\\\\|\\_|\\\{|\\\}", inner):
            return mo.group(0)
        body = it.expand(unescape(inner).strip(), mm)
        conv = pandoc_math(body, work)
        return "$" + (conv if conv is not None else body) + "$"

    line, k = re.subn(r"\$([^$\n]+)\$", repl, line)
    return line, n


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0, 0
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    mm = it.macro_map(d)
    s = open(mp, encoding="utf-8", errors="replace").read()
    n = bad = 0
    out, pos = [], 0
    for m in OPENER.finditer(s):
        if m.start() < pos:
            continue
        close = CLOSER.search(s, m.end())
        if not close:
            continue
        block = s[m.end():close.start()]
        rep = convert_display(block, mm, work)
        if rep is None:
            bad += 1
            continue
        out.append(s[pos:m.start()])
        out.append(rep)
        pos = close.end()
        n += 1
    out.append(s[pos:])
    text = "".join(out)
    lines, inline = [], 0
    for line in text.split("\n"):
        nl, k = fix_inline(line, mm, work)
        lines.append(nl)
        inline += k
    text = "\n".join(lines)
    if n and not dry:
        shutil.copyfile(mp, mp + ".deshattered")
        open(mp, "w", encoding="utf-8").write(text)
    return n, bad, inline


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv[1:]
    for a in args:
        k, bad, inline = run(a, dry)
        print("%-14s displays rebuilt %d, pandoc failures %d, inline %d"
              % (os.path.basename(a), k, bad, inline))
