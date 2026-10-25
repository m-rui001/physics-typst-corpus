r"""Convert the escaped inline-LaTeX math fragments that pandoc left inside good Typst prose.

The paragraphs of a converted paper read fine, except every piece of math that survived as
`\$\...\$` - backslash-escaped dollars holding raw LaTeX (`\\_`, `\\^`, `\\frac`, undefined
single-letter macros). Re-converting the whole paragraph mangles the Typst around it, so
only the fragment between a matched pair of `\$` delimiters is handed to pandoc, after the
paper's own `\newcommand` definitions from src/ have been expanded. The surrounding prose,
references and footnotes are untouched.

Usage: python -X utf8 scripts/inlinetex.py [papers/...] [--dry]
Writes main.typ.inlinetexed before touching main.typ.
"""
import glob, os, re, shutil, subprocess, sys, tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import resplice

B = chr(92)
MACRODEF = re.compile(r"\\(?:re)?newcommand\*?\s*\{?\\([A-Za-z@]+)\}?(?:\s*\[\d+\])?\s*")


def _braced(s, i):
    """s[i] == '{'; return (inner, index_after_closing_brace) or (None, i)."""
    if i >= len(s) or s[i] != "{":
        return None, i
    depth = 0
    for j in range(i, len(s)):
        if s[j] == "{":
            depth += 1
        elif s[j] == "}":
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
    return None, i


def macro_map(d):
    m = {}
    for f in sorted(glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True)):
        s = resplice.strip_comments(open(f, encoding="utf-8", errors="replace").read())
        for mo in MACRODEF.finditer(s):
            body, _ = _braced(s, mo.end())
            if body is not None:
                m.setdefault(mo.group(1), body.strip())
    return m


def _balanced(s, i):
    if i >= len(s) or s[i] != "{":
        return None, i
    depth = 0
    for j in range(i, len(s)):
        if s[j] == "{":
            depth += 1
        elif s[j] == "}":
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
    return None, i


def _sub(frag, name, body):
    key = B + name
    out, i = [], 0
    while True:
        a = frag.find(key, i)
        if a < 0:
            out.append(frag[i:])
            break
        end = a + len(key)
        if end < len(frag) and frag[end].isalpha():
            out.append(frag[i:end])
            i = end
            continue
        out.append(frag[i:a])
        if "#1" in body:
            j = end
            while j < len(frag) and frag[j].isspace():
                j += 1
            arg, j2 = _balanced(frag, j)
            if arg is not None:
                out.append(body.replace("#1", arg))
                i = j2
            else:
                out.append(body.replace("#1", ""))
                i = end
        else:
            out.append(body)
            i = end
    return "".join(out)


def expand(frag, mm):
    for _ in range(3):
        for name, body in mm.items():
            frag = _sub(frag, name, body)
        # undefined single-letter macros: keep the letters, drop the macro
        frag = re.sub(B*2 + r"([A-Za-z])(?![A-Za-z])", lambda mo: mo.group(1), frag)
    return frag


def dollar_pairs(line):
    """[(start,end)] of the 2-char sequences \\$ ... \\$ on this line."""
    hits = [i for i in range(len(line) - 1) if line[i] == B and line[i + 1] == "$"]
    return [(hits[i], hits[i + 1]) for i in range(0, len(hits) - 1, 2)]


def convert(frag_latex, work):
    tf = tempfile.NamedTemporaryFile("w", suffix=".tex", delete=False, dir=work, encoding="utf-8")
    tf.write("$" + frag_latex + "$\n")
    tf.close()
    of = tf.name + ".typ"
    subprocess.run(["pandoc", tf.name, "-f", "latex", "-t", "typst", "--wrap=none", "-o", of],
                   capture_output=True, text=True, encoding="utf-8", errors="replace")
    out = open(of, encoding="utf-8").read().strip() if os.path.exists(of) else ""
    os.unlink(tf.name)
    if os.path.exists(of):
        os.unlink(of)
    return out


def fix_line(line, mm, work):
    pairs = dollar_pairs(line)
    if not pairs:
        return line, 0
    out, pos, n = [], 0, 0
    for a, b in pairs:
        out.append(line[pos:a])
        frag = line[a + 2:b]                                   # text between the \$ pairs
        frag = re.sub(B * 2, lambda mo: B, frag)                # \\ -> \
        frag = re.sub(B * 2 + r"([_^{}%&#$])", r"\1", frag)      # \_ -> _
        frag = expand(frag.strip(), mm)
        new = resplice.clean(convert(frag, work)) if len(frag) > 1 else ""
        if new.startswith("$") and new.count("$") == 2 and "error" not in new:
            out.append(new)
            n += 1
        else:
            out.append(B + "$" + frag + B + "$")               # leave it visible, unescaped
            n += 1
        pos = b + 2
    out.append(line[pos:])
    return "".join(out), n


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    mm = macro_map(d)
    lines = open(mp, encoding="utf-8", errors="replace").read().split("\n")
    total, done = 0, []
    for i, l in enumerate(lines):
        if B + "$" not in l:
            continue
        nl, k = fix_line(l, mm, work)
        if k and nl.count("$") % 2 == 0:
            done.append((i, nl))
            total += k
    for i, nl in done:
        lines[i] = nl
    if done and not dry:
        shutil.copyfile(mp, mp + ".inlinetexed")
        open(mp, "w", encoding="utf-8").write("\n".join(lines))
    return total


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv[1:]
    for a in args or sorted(glob.glob("papers/2*")):
        if not os.path.isdir(a):
            continue
        try:
            n = run(a, dry)
        except Exception as e:
            print(os.path.basename(a), "skip", type(e).__name__, e)
            continue
        print("%-14s inline-math fragments converted %d" % (os.path.basename(a), n), flush=True)
