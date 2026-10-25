r"""Restore letters that autofix's bare-name deletion ate out of prose words.

autofix.unknown_var_fix ran re.sub(r"\\?" + name + r"\b", "") with names harvested from
Typst's "unknown variable:" errors, so macro names like \te, \in, \de, \no, \AdS deleted
those letters wherever they occurred: "evaporate"->"evapora", "state"->"sta",
"increases"->"creases", "definition"->"finition", "Note"->"No", "AdS/CFT"->"/CFT".

The intact LaTeX in _work/body.tex (else src/) is the authority. Both files are reduced
to the same lowercase word-token sequence and aligned; where one damaged token sits where
one source token belongs and is a strict prefix of it, the source spelling is written back
at the real character position in main.typ. Nothing else is ever changed, and markup,
citation keys, labels, quoted paths and math ranges are skipped.

Usage: python -X utf8 scripts/restore.py [papers/...]      (default: every paper)
       --dry to report without writing.  Rewrites main.typ after main.typ.prerestore.
"""
import difflib, glob, os, re, shutil, sys

sys.stdout.reconfigure(encoding="utf-8")

B = chr(92)
WORD = re.compile(r"[A-Za-z][A-Za-z0-9'-]*")
STOP = {"typst", "cetz", "image", "figure", "table", "stroke", "inset", "paint",
        "dash", "line", "text", "rect", "circle", "content", "caption", "label"}


def src_text(d):
    r"""Pristine author LaTeX; _work/body.tex is only a fallback (it is itself damaged)."""
    out = []
    for tf in sorted(glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True)):
        out.append(open(tf, encoding="utf-8", errors="replace").read())
    if out:
        return "\n".join(out)
    bt = os.path.join(d, "_work", "body.tex")
    if os.path.exists(bt):
        return open(bt, encoding="utf-8", errors="replace").read()
    return ""


def tokens(s):
    """Lowercase word tokens of a LaTeX/Typst string, commands and markup stripped."""
    return [w.lower() for w in tokens_raw(s)]


def tokens_raw(s):
    s = re.sub(r"(?<!%)" + B + r"%.*", " ", s)
    s = re.sub(r"\\" + r"[a-zA-Z@]+\*?", " ", s)
    return [w for w in WORD.findall(s)]


def protect_spans(line):
    spans = []
    for pat in (r"@[A-Za-z0-9_:\-.]+", r"<[A-Za-z0-9_:.\-]+>", r'"[^"]*"',
                r"#[a-zA-Z][\w.]*", r"\$[^$]*\$", r"\{[^{}]*\}",
                r"[A-Za-z0-9_\-.]+\.(png|pdf|jpg|jpeg|eps|typ|tex|bib|svg)"):
        for m in re.finditer(pat, line):
            spans.append((m.start(), m.end()))
    return spans


def collect(text):
    """(token list, [(line_no, start, end, token)]) over the whole file, markup skipped."""
    toks, meta = [], []
    for ln, line in enumerate(text.split("\n"), 1):
        spans = protect_spans(line)
        for m in WORD.finditer(line):
            t = m.group(0)
            if any(m.start() < hi and m.end() > lo for lo, hi in spans):
                continue
            if t.lower() in STOP:
                continue
            toks.append(t.lower())
            meta.append((ln, m.start(), m.end(), t))
    return toks, meta


def looks_like_code(line, a, b):
    r"""A Typst identifier used as a function or field (`mat(`, `.inset`, `#figure`) is
    code, not prose: re-lengthening `mat` to `material` breaks the document, so such
    tokens are never repaired.
    """
    if b < len(line) and line[b] in "(.":
        return True
    if a and line[a - 1] in "#@<\\$":
        return True
    return False


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    st = src_text(d)
    if len(st.strip()) < 500:
        return 0
    typ_text = open(mp, encoding="utf-8", errors="replace").read()
    stoks_raw = tokens_raw(st)
    stoks = [w.lower() for w in stoks_raw]
    ttoks, meta = collect(typ_text)
    if not ttoks:
        return 0
    sm = difflib.SequenceMatcher(None, stoks, ttoks, autojunk=False)
    fixes = {}
    typ_lines = typ_text.split("\n")
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == "equal" or tag == "insert":
            continue
        if i2 - i1 != j2 - j1:
            continue
        for si, tj in zip(range(i1, i2), range(j1, j2)):
            srcw, dstw = stoks[si], ttoks[tj]
            if srcw == dstw or not srcw.startswith(dstw) or not 1 <= len(srcw) - len(dstw) <= 6:
                continue
            if len(dstw) < 2:
                continue
            ln, a, b, raw = meta[tj]
            if looks_like_code(typ_lines[ln - 1], a, b):
                continue
            new = srcw.capitalize() if raw[:1].isupper() else srcw
            if new == raw:
                continue
            fixes[(ln, a, b)] = new
    lines = typ_text.split("\n")
    byline = {}
    for (ln, a, b), new in fixes.items():
        byline.setdefault(ln, []).append((a, b, new))
    for ln, edits in byline.items():
        out, pos = [], 0
        for a, b, new in sorted(edits):
            out.append(lines[ln - 1][pos:a])
            out.append(new)
            pos = b
        out.append(lines[ln - 1][pos:])
        lines[ln - 1] = "".join(out)

    # Phase 1b: autofix did not only shorten words, it deleted some of them outright
    # ("the neutrino mass" -> "the  mass"). A single source token with no counterpart at
    # all is written back only when the two neighbouring Typst tokens sit on one line and
    # the stretch between them is bare whitespace of two or more characters, i.e. the hole
    # the deletion left behind. Anything else (markup, math or a reference in the gap) is
    # left alone.
    inserts = []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag != "delete" or i2 - i1 != 1 or j1 != j2:
            continue
        w, low = stoks_raw[i1], stoks[i1]
        if not w.isalpha() or len(w) < 4 or low in STOP:
            continue
        if not 0 < j1 < len(ttoks):
            continue
        ln, _, b1, prev_raw = meta[j1 - 1]
        ln2, a2, _, next_raw = meta[j1]
        if ln2 != ln or low == ttoks[j1 - 1] or low == ttoks[j1]:
            continue
        line = lines[ln - 1]
        if line[a2:a2 + len(next_raw)] != next_raw:
            continue
        if not re.fullmatch(r"\s{2,}", line[b1:a2]):
            continue
        if low in [t.lower() for t in WORD.findall(line)]:
            continue
        inserts.append((ln, b1, a2, w))
    byline = {}
    for ln, b1, a2, w in inserts:
        byline.setdefault(ln, []).append((b1, a2, w))
    for ln, edits in byline.items():
        out = lines[ln - 1]
        for b1, a2, w in sorted(edits, reverse=True):
            out = out[:b1] + " " + w + " " + out[a2:]
        lines[ln - 1] = out
    if inserts and dry:
        for ln, b1, a2, w in inserts[:10]:
            print("   %d +%r  %s" % (ln, w, lines[ln - 1][max(0, b1 - 40):a2 + 40]))

    # still recoverable when exactly one source word extends them in the same context.
    stoks = tokens(st)
    prev, nxt = {}, {}
    for i, w in enumerate(stoks):
        if i:
            prev.setdefault(w, set()).add(stoks[i - 1])
        if i + 1 < len(stoks):
            nxt.setdefault(w, set()).add(stoks[i + 1])
    svocab = set(stoks)
    ext = {}
    for w in svocab:
        for cut in range(2, len(w)):
            ext.setdefault(w[:cut], []).append(w)
    more = 0
    for i, line in enumerate(lines):
        spans = protect_spans(line)
        ws = [(m.start(), m.end(), m.group(0)) for m in WORD.finditer(line)]
        edits = []
        for k, (a, b, t) in enumerate(ws):
            low = t.lower()
            if low in svocab or len(t) < 3 or any(a < hi and b > lo for lo, hi in spans):
                continue
            if looks_like_code(line, a, b):
                continue
            ctx = ws[k - 1][2].lower() if k else None
            nm = ws[k + 1][2].lower() if k + 1 < len(ws) else None
            ok = [w for w in ext.get(low, []) if 1 <= len(w) - len(low) <= 6
                  and ((ctx and ctx in prev.get(w, ())) or (nm and nm in nxt.get(w, ())))]
            if len(ok) == 1:
                new = ok[0].capitalize() if t[:1].isupper() else ok[0]
                if new != t:
                    edits.append((a, b, new))
        if edits:
            out, pos = [], 0
            for a, b, new in edits:
                out.append(line[pos:a])
                out.append(new)
                pos = b
            out.append(line[pos:])
            lines[i] = "".join(out)
            more += len(edits)
    if (fixes or inserts or more) and not dry:
        bak = mp + ".prerestore"
        if os.path.exists(bak):
            bak = mp + ".prerestore2"
        shutil.copyfile(mp, bak)
        open(mp, "w", encoding="utf-8", newline="\n").write("\n".join(lines))
    return len(fixes) + len(inserts) + more


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if a != "--dry"]
    dry = "--dry" in sys.argv[1:]
    tot = 0
    for a in args or sorted(glob.glob("papers/2*")):
        try:
            n = run(a, dry)
        except Exception as e:
            print(os.path.basename(a), "skip", type(e).__name__, e)
            continue
        tot += n
        print("%-14s %s%d words" % (os.path.basename(a), "dry: " if dry else "restored ", n))
    print("total", tot)
