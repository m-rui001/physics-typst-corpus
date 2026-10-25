r"""Give back prose the converter truncated at macros it did not know.

Symptom: a `main.typ` paragraph that stops mid-sentence - "...based on a sequence of exposures
with", "...X-ray Pulse Simulation and Inference] (", a paragraph that is just "The" - while
`src/` goes on right after an author-defined macro (`\NICER`, `\XPSI`). The converter handed
pandoc a chunk pandoc could not parse and kept only its head, so everything after the macro was
dropped, headings included (`===` with no title).

This stage expands the paper's own `\newcommand` table, matches each truncated paragraph against
the source paragraph that begins with exactly its surviving words, converts the missing tail with
pandoc the way the converter should have, and splices it back. Heading lines left empty get their
title from the source heading list, aligned through the headings that surround them. Every edit is
compiled on its own and dropped again unless it adds words without adding compile errors.

Usage: python -X utf8 scripts/proseholes.py papers/<id> [...] [--dry]
Gate: content restored; syntax errors and dangling references must not rise. Backup main.typ.proseholes
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "check"))
import mathrem                                    # noqa: E402

TMP = os.path.join(ROOT, "check", "tmp")
WORD = re.compile(r"[A-Za-z0-9]+")
# A paragraph is intact when it ends on a sentence terminator (or a footnote-ish closer).
DONE = set('.!?"”]`')
CUT = re.compile(r"\\begin\{|\\end\{|\\bibitem|(?<!\\)%")


def read(f):
    return open(f, encoding="utf-8", errors="replace").read()


def toks(s):
    return [m.group(0).lower() for m in WORD.finditer(s)]


def strip_comments(s):
    return re.sub(r"(?<!\\)%.*", "", s)


def match_brace(s, i):
    """Index just past the `}` that closes the `{` at s[i]."""
    d, k, esc = 0, i, False
    while k < len(s):
        c = s[k]
        if esc:
            esc = False
        elif c == "\\":
            esc = True
        elif c == "{":
            d += 1
        elif c == "}":
            d -= 1
            if d == 0:
                return k + 1
        k += 1
    return len(s)


def macro_table(files):
    r"""Author macros from the paper's own preamble, in both `\newcommand\X{..}` and
    `\newcommand{\X}[n]{..}` spellings."""
    T = {}
    for f in files:
        s = strip_comments(read(f))
        for pat in (r"\\(?:re|provide)?newcommand\*?\s*\{\s*\\([A-Za-z@]+)\s*\}",
                    r"\\(?:re|provide)?newcommand\*?\s*\\([A-Za-z@]+)",
                    r"\\def\s*\\([A-Za-z@]+)"):
            for m in re.finditer(pat, s):
                k = m.end()
                if k < len(s) and s[k] == "*":
                    k += 1
                ar = re.match(r"\s*\[(\d)\]", s[k:])
                n = int(ar.group(1)) if ar else 0
                k += ar.end() if ar else 0
                while k < len(s) and s[k] in " \t\n":
                    k += 1
                if s[k:k + 1] != "{":
                    continue
                e = match_brace(s, k)
                T[m.group(1)] = (n, s[k + 1:e - 1])
    return T


def expand(s, T, depth=0):
    if depth > 6:
        return s
    out, i = [], 0
    while i < len(s):
        m = WORDSTART.match(s, i)
        if m and m.group(1) in T:
            name = m.group(1)
            k = m.end()
            n, body = T[name]
            args = []
            for _ in range(n):
                while k < len(s) and s[k] in " \t\n":
                    k += 1
                if s[k:k + 1] == "{":
                    e = match_brace(s, k)
                    args.append(s[k + 1:e - 1])
                    k = e
                elif s[k:k + 1] == "[":
                    e = s.find("]", k)
                    args.append(s[k + 1:e] if e > k else "")
                    k = e + 1
                else:
                    args.append("1")
            for j, a in enumerate(args, 1):
                body = body.replace("#%d" % j, a)
            out.append(expand(body, T, depth + 1))
            i = k
            continue
        out.append(s[i])
        i += 1
    return "".join(out).replace("\\xspace", "")


WORDSTART = re.compile(r"\\([A-Za-z@]+)\*?")


SYM = {"dot.circle": "⊙", "circle.dot": "⊙", "times.circle": "⊗",
       "circle.times": "⊗", "plus.circle": "⊕", "circle.plus": "⊕",
       "minus.circle": "⊖", "circle.minus": "⊖", "square.c": "□", "triangle.t": "△"}


def normalize(t):
    """Typst reads `dot.circle` as a symbol modifier and rejects it; the operand itself is the
    unicode relation that the rest of the corpus already uses."""
    for k, v in SYM.items():
        t = re.sub(r"(?<![A-Za-z.])" + k + r"(?![A-Za-z.])", v, t)
    return t


def mask_math(s):
    """Blank out `$…$` in place so the remaining words can be compared with offsets intact."""
    s = re.sub(r"\$\$.*?\$\$", lambda m: " " * len(m.group(0)), s, flags=re.S)
    return re.sub(r"\$[^$]*\$", lambda m: " " * len(m.group(0)), s)


def main_words(s):
    """Typst markup -> the bare words a reader sees, so it can be matched against the source."""
    s = re.sub(r"#cite\(\s*<([^>]+)>[^)]*\)", r"  \1  ", s)
    s = re.sub(r"#ref\(\s*(?:label\()?<?([^>()<]+)>?\)?\s*\)", r"  \1  ", s)
    s = re.sub(r"#(?:emph|strong|smallcaps|text)\s*(?:\([^)]*\))?\s*\[([^\]]*)\]", r"  \1  ", s)
    s = re.sub(r"//[^\n]*", lambda m: " " * len(m.group(0)), s)
    return mask_math(s.replace("@", " "))


def src_words(s):
    """LaTeX -> the same bare words: commands that only decorate or cross-reference go away."""
    s = re.sub(r"\\(?:cite[a-z]*|parencite|textcite|autocite|ref|eqref|Cref|cref|pageref)\*?"
               r"(?:\[[^\]]*\])*\{([^{}]*)\}", r"  \1  ", s)
    s = re.sub(r"\\(?:textit|emph|textbf|texttt|textsc|text|textsl|underline|mbox|textrm)"
               r"\{([^{}]*)\}", r"  \1  ", s)
    s = re.sub(r"\\label\{[^{}]*\}", " ", s)
    s = re.sub(r"\\(?:footnotesize|small|noindent|xspace)", " ", s)
    return mask_math(s)


def _keep(m):
    """Blank the command and its braces but leave the captured group exactly where it was, so the
    string keeps its length and offsets still index the original text."""
    pad = " " * len(m.group(0))
    g = m.group(1)
    st = m.start(1) - m.start(0)
    return pad[:st] + g + pad[st + len(g):]


def src_words(s):
    """LaTeX -> the same bare words, length-preserving: commands that only decorate or
    cross-reference lose their wrapper and keep their argument in place."""
    s = re.sub(r"\\(?:cite[a-z]*|parencite|textcite|autocite|ref|eqref|Cref|cref|pageref)\*?"
               r"(?:\[[^\]]*\])*\{([^{}]*)\}", _keep, s)
    s = re.sub(r"\\(?:textit|emph|textbf|texttt|textsc|text|textsl|underline|mbox|textrm)"
               r"\{([^{}]*)\}", _keep, s)
    s = re.sub(r"\\label\{[^{}]*\}", lambda m: " " * len(m.group(0)), s)
    s = re.sub(r"\\(?:footnotesize|small|noindent|xspace)", lambda m: " " * len(m.group(0)), s)
    return mask_math(s)


def cut_pos(word_text, k):
    """Offset just past the k-th word of a paragraph."""
    hits = list(WORD.finditer(word_text))
    return hits[k - 1].end() if 0 < k <= len(hits) else 0


def to_paras(tex):
    """Convert a LaTeX fragment to Typst paragraphs, or None."""
    if tex.strip() == "":
        return None
    tf = os.path.join(TMP, "ph.tex")
    of = os.path.join(TMP, "ph.typ")
    open(tf, "w", encoding="utf-8").write(tex)
    for pad in (False, True):
        src = tf
        if pad:
            src = tf + ".pad.tex"
            open(src, "w", encoding="utf-8").write(mathrem_pad(tex))
        r = subprocess.run(["pandoc", src, "-f", "latex", "-t", "typst",
                            "--wrap=none", "-o", of],
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if r.returncode == 0 and os.path.exists(of):
            t = read(of).replace("\r\n", "\n").strip()
            ps = [re.sub(r"\s+", " ", p).strip() for p in re.split(r"\n\s*\n", t)]
            ps = [p for p in ps if p]
            if ps:
                return ps
    return None


def mathrem_pad(s):
    """Close braces and open environments so pandoc can parse a fragment."""
    envs, depth, i = [], 0, 0
    while i < len(s):
        if s[i] == "\\":
            m = re.match(r"\\(begin|end)\{([^{}]*)\}", s[i:])
            if m:
                if m.group(1) == "begin":
                    envs.append(m.group(2))
                elif envs and envs[-1] == m.group(2):
                    envs.pop()
                i += m.end()
                continue
            i += 2
            continue
        if s[i] == "{":
            depth += 1
        elif s[i] == "}":
            depth = max(0, depth - 1)
        i += 1
    return s + "}" * depth + "".join("\\end{%s}" % e for e in reversed(envs))


def src_blocks(d, T):
    """Source paragraphs and headings, macro-expanded, in document order."""
    out = []
    files = sorted(glob_tex(d))
    for f in files:
        s = expand(strip_comments(read(f)), T)
        for m in re.finditer(r"\\(?:sub)*section\*?\{", s):
            e = match_brace(s, m.end() - 1)
            lvl = s[m.start():m.start() + 40].count("sub")
            tail = s[e:e + 80]
            lab = re.match(r"\s*\\label\{([^}]*)\}", tail)
            out.append({"kind": "head", "level": lvl, "tex": s[m.end():e - 1],
                        "label": lab.group(1) if lab else "", "text": s[m.start():e]})
        for piece in re.split(r"\n\s*\n", s):
            if len(piece.strip()) < 20:
                continue
            if re.match(r"\s*\\(?:documentclass|usepackage|newcommand|title|author|begin\{document)", piece):
                continue
            out.append({"kind": "para", "text": piece.strip()})
    return out


def glob_tex(d):
    import glob
    return glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True)


def main_blocks(lines):
    """Runs of consecutive markup lines, with the ones that are code or headings excluded."""
    runs, i = [], 0
    while i < len(lines):
        if not lines[i].strip():
            i += 1
            continue
        j = i
        while j < len(lines) and lines[j].strip():
            j += 1
        chunk = lines[i:j]
        first = chunk[0].strip()
        body = "\n".join(chunk)
        ok = (first and first[0].isalnum()
              and not re.search(r"^\s*[#=//\-+*]", body, re.M)
              and "#figure(" not in body and "image(" not in body
              and "caption:" not in body and "#box(" not in body
              and not body.rstrip().endswith(("]", ")")))
        if ok:
            runs.append((i, j, body))
        i = j
    return runs


def tail_after(block, wt, k):
    """Source characters after the k-th token of a paragraph, cut at the next environment."""
    hits = list(WORD.finditer(wt))
    if k > len(hits):
        return ""
    rest = block[hits[k - 1].end():] if k else block
    m = CUT.search(rest)
    if m and m.start() < len(rest) - 5:
        rest = rest[:m.start()]
    return rest


def holes(lines, blocks, src, cursor):
    """Match each truncated markup paragraph to the source paragraph it came from."""
    edits = []
    for (a, b, body) in blocks:
        if body.rstrip()[-1:] in DONE:
            continue
        mt = toks(main_words(body))
        if len(mt) < 2:
            continue
        best = None
        for idx in range(cursor, len(src)):
            s = src[idx]
            if s["kind"] != "para":
                continue
            st = toks(src_words(s["text"]))
            n = len(mt)
            if len(st) > n and st[:n] == mt:
                best = (idx, s, len(st) - n)
                break
        if best is None:
            for idx, s in enumerate(src):
                if s["kind"] != "para":
                    continue
                st = toks(src_words(s["text"]))
                n = len(mt)
                if len(st) > n >= 4 and st[:n] == mt:
                    best = (idx, s, len(st) - n)
                    break
        if best:
            edits.append((a, b, body, best))
            cursor = best[0] + 1
    return edits, cursor


def fill_headings(lines, src, T):
    """Give empty `===` heading lines the title their source heading lost.

    Main and source headings are walked together: a filled main heading consumes the source
    heading whose title it matches, so an empty one can only take a source heading that sits
    between its already-matched neighbours - and must be at the same depth.
    """
    heads = [s for s in src if s["kind"] == "head"]
    out, ptr = [], 0
    for i, ln in enumerate(lines):
        m = re.match(r"=+((\s+)(.*))?$", ln.strip())
        if not m or not ln.strip().startswith("="):
            continue
        want = len(re.match(r"=+", ln.strip()).group(0))
        title = m.group(3) or ""
        mt = toks(re.sub(r"<[^>]*>", "", title))
        if mt:
            for j in range(ptr, len(heads)):
                if toks(heads[j]["tex"])[:len(mt)] == mt or toks(heads[j]["tex"]) == mt:
                    ptr = j + 1
                    break
            continue
        target = None
        for j in range(ptr, len(heads)):
            h = heads[j]
            if h["level"] + 1 != want:
                continue
            ps = to_paras(expand(h["tex"], T))
            t = normalize(ps[0]) if ps else ""
            if not t or len(t.split()) > 12:
                continue
            target = (h, t)
            ptr = j + 1
            break
        if target is None:
            continue
        h, title = target
        lab = ""
        if h["label"]:
            lab = " <" + re.sub(r"[^A-Za-z0-9_:.\-]", "-", h["label"]).strip("-") + ">"
        out.append((i, "=" * want + " " + title + lab))
    return out


def probe(d, text):
    p = os.path.join(d, "_probe.typ")
    open(p, "w", encoding="utf-8").write(text)
    n, spots = mathrem.compile_errors(p)
    err = subprocess.run(["typst", "compile", "--root", ROOT, p,
                          os.path.join(ROOT, "check", "nul.pdf")],
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE
                         ).stderr.decode("utf-8", "replace")
    ref = sum(1 for ln in err.split("\n")
              if "cannot reference" in ln or "does not exist in the document" in ln
              or "unknown label" in ln)
    try:
        os.unlink(p)
    except OSError:
        pass
    return n + ref, n, ref


def run(d, dry=False):
    d = os.path.abspath(d)
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        return
    files = list(glob_tex(d))
    if not files:
        print(os.path.basename(d), "no src/")
        return
    T = macro_table(files)
    src = src_blocks(d, T)
    text = read(f)
    lines = text.split("\n")
    base, bsyn, bref = probe(d, text)
    edits, cur = holes(lines, main_blocks(lines), src, 0)
    hfill = fill_headings(lines, src, T)
    print(os.path.basename(d), "paras=%d heads=%d base_err=%d (syn %d ref %d)"
          % (len(edits), len(hfill), base, bsyn, bref))
    if dry:
        for (a, b, body, (idx, s, n)) in edits:
            print("  L%d  -%s-" % (a + 1, body[-60:].encode("ascii", "replace").decode()))
            print("     +%s+" % tail_after(s["text"], src_words(s["text"]), len(toks(main_words(body))))[:200].encode("ascii", "replace").decode())
        for (i, ln) in hfill:
            print("  H%d %s" % (i + 1, ln.encode("ascii", "replace").decode()))
        return
    bak = f + ".proseholes"
    if not os.path.exists(bak):
        shutil.copy2(f, bak)
    acc = 0
    # Apply heading fills first (they are line-local), then paragraph splices from the bottom up.
    for (i, ln) in hfill:
        trial = list(lines)
        trial[i] = ln
        t = "\n".join(trial)
        n, _, _ = probe(d, t)
        print("  head L%d -> %d/%d %s" % (i + 1, n, base, ln.strip()[:60].encode("ascii", "replace").decode()))
        if n <= base:
            lines = trial
            base = n
            acc += 1
    for (a, b, body, (idx, s, n)) in reversed(edits):
        k = len(toks(body))
        rem = tail_after(s["text"], src_words(s["text"]), k)
        if not rem.strip():
            continue
        ps = to_paras(expand(rem, T))
        ps = [normalize(x) for x in ps] if ps else None
        if not ps:
            print("  skip L%d (pandoc failed)" % (a + 1))
            continue
        new = [body.rstrip() + " " + ps[0]] + ps[1:]
        trial = lines[:a] + new + lines[b:]
        t = "\n".join(trial)
        cnt, n, _ = probe(d, t)
        grew = len(toks(t)) > len(toks("\n".join(lines)))
        print("  para L%d +%d words -> %d/%d%s" % (a + 1, len(toks(ps[0])), cnt, base,
                                                   "" if grew else " (no growth)"))
        if cnt <= base and grew:
            lines = trial
            base = cnt
            acc += 1
    if acc:
        mathrem.save(f, "\n".join(lines))
        print("  WROTE %d edits" % acc)
    else:
        print("  nothing accepted")


if __name__ == "__main__":
    dry = "--dry" in sys.argv
    for a in sys.argv[1:]:
        if a.startswith("--"):
            continue
        run(a, dry)
