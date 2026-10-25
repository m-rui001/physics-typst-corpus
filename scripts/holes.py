"""Recover the citation/reference holes left by the pandoc stage.

The converter replaces an unparseable `\cite`/`\ref` with the placeholder `#text([])`,
which silently blanks ~3000 references corpus-wide. Each hole's surrounding prose is
verbatim from the paper, so locate that prose in src/*.tex and read the citation command
that follows it in the source."""
import glob, io, os, re, sys

HOLE = "#text([])"
CITE = re.compile(r"\\(?:cite[a-z]*|parencite|textcite|autoref|ref|eqref)\s*(?:\[[^\]]*\])?\{([^}]*)\}")
TAG = re.compile(r"\\(?:label|ref|eqref|autoref|cite[a-z]*)\s*(?:\[[^\]]*\])?\{[^}]*\}")


def words(s):
    s = re.sub(r"#text\(\[\]\)", " ", s)
    s = re.sub(r"#(?:emph|strong|text|footnote|cite)\s*\(", " ", s)
    s = re.sub(r"[{}()\[\]$<>,;:.\-!?\*_/\\|+=~^\"]+", " ", s)
    return re.sub(r"\s+", " ", s).strip().lower()


def src_text(paper):
    out = []
    for f in glob.glob(os.path.join(paper, "src", "**", "*.tex*"), recursive=True):
        try:
            t = io.open(f, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        t = "\n".join(l for l in t.split("\n") if not l.lstrip().startswith("%"))
        out.append(t)
    return "\n".join(out)


def norm(w):
    return re.sub(r"[^a-z]", "", w.lower())


def index(src):
    """Alphabetic-word stream of the LaTeX source, mapped back to source offsets."""
    toks, offs = [], []
    for m in re.finditer(r"[A-Za-z]{3,}", src):
        toks.append(norm(m.group(0)))
        offs.append(m.start())
    return " ".join(toks), offs


def process(paper, limit=4000):
    typ = os.path.join(paper, "main.typ")
    body = io.open(typ, encoding="utf-8").read()
    if HOLE not in body:
        return
    src = src_text(paper)
    srct, offs = index(src)
    pos = [m.start() for m in re.finditer(re.escape(HOLE), body)][:limit]
    fixed, miss = 0, 0
    out, last = [], 0
    for p in pos:
        out.append(body[last:p])
        ctx = [m.group(0).lower() for m in re.finditer(r"[A-Za-z]{3,}", body[max(0, p - 300):p])]
        win = ""
        for n in (5, 4, 3):
            if len(ctx) >= n:
                win = " ".join(ctx[-n:])
                break
        hit, done = srct.find(win), False
        # a short window is only trustworthy when it occurs exactly once in the source
        if len(win.split()) < 5 and srct.count(win) != 1:
            hit, done = -1, False
        while hit >= 0:
            i = offs[srct[:hit].count(" ")] if hit > 0 else 0
            m = CITE.search(src, max(0, i - 60))
            if not m or m.start() - i > 160:
                m = CITE.search(src, i)
            if m and m.start() - i <= 160:
                keys = [re.sub(r"[^A-Za-z0-9_.:\-]", "-", k.strip())
                        for k in m.group(1).split(",") if k.strip()]
                if keys:
                    out.append(" ".join("@" + k for k in keys))
                    fixed += 1
                    done = True
                    break
            hit = srct.find(win, hit + 1)
        if not done:
            out.append(HOLE)
            miss += 1
        last = p + len(HOLE)
    out.append(body[last:])
    if fixed:
        io.open(typ, "w", encoding="utf-8").write("".join(out))
    print(os.path.basename(paper), "holes filled", fixed, "left", miss, flush=True)


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    for d in sys.argv[1:] or sorted(glob.glob(r"E:\phys\papers\2*")):
        try:
            process(d)
        except Exception as e:
            print("FAIL", d, repr(e)[:160], flush=True)
