r"""Second-pass recovery of `#text([])` citation holes, matched on the FOLLOWING words.

holes.py anchors on the words before a hole, which fails whenever that context is maths
(`ranges between $2 sigma$ and $4 sigma$ #text([])`). This pass anchors on the prose after
the hole instead, requires the window to be unique in the source, and then reads the
`\cite` that precedes that spot. Consecutive holes are treated as one site and any key
already cited there is not duplicated.

Usage: python -X utf8 scripts/holes2.py papers/<dir> [...]
"""
import glob, os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

CITE = re.compile(r"\\(?:cite[a-z]*|parencite|textcite|autocite)\s*(?:\[[^\]]*\])?\{([^}]*)\}")
WORD = re.compile(r"[A-Za-z][A-Za-z'’\-]{2,}")
HOLE = re.compile(r"(?:\s*#text\(\[\]\))+")
NEAR = re.compile(r"@[A-Za-z0-9_.:\-]+")


def src_tokens(d):
    """Source text with comments and math masked out *in place*, so offsets stay valid."""
    parts = []
    for tf in glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True):
        try:
            s = open(tf, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        s = re.sub(r"(?<!\\)%.*", lambda m: " " * len(m.group(0)), s)
        s = re.sub(r"\$\$.*?\$\$", lambda m: " " * len(m.group(0)), s, flags=re.S)
        s = re.sub(r"\$[^$]*\$", lambda m: " " * len(m.group(0)), s)
        parts.append(s)
    joined = "\n".join(parts)
    offs = [m.start() for m in WORD.finditer(joined)]
    toks = [m.group(0).lower() for m in WORD.finditer(joined)]
    return joined, toks, offs


def find_windows(toks, win):
    n = len(win)
    hits = []
    for i in range(len(toks) - n + 1):
        if toks[i:i + n] == win:
            hits.append(i)
            if len(hits) > 1:
                return hits
    return hits


def run(d):
    d = os.path.abspath(d)
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        return
    body = open(f, encoding="utf-8", errors="replace").read()
    if "#text([])" not in body:
        print(os.path.basename(d), "no holes")
        return
    joined, toks, offs = src_tokens(d)
    bib = ""
    rb = os.path.join(d, "refs.bib")
    if os.path.exists(rb):
        bib = open(rb, encoding="utf-8", errors="replace").read()
    bibkeys = set(re.findall(r"^@\w+\{\s*([^,\s]+)", bib, re.M))
    out, pos, filled, sites = [], 0, 0, 0
    for m in HOLE.finditer(body):
        if m.start() < pos:
            continue
        nxt = " ".join(w.lower() for w in WORD.findall(body[m.end():m.end() + 260])[:6])
        words = nxt.split()
        for n in (5, 4, 3):
            if len(words) < n:
                continue
            hits = find_windows(toks, words[:n])
            if len(hits) != 1:
                continue
            off = offs[hits[0]]
            cm = None
            for c in CITE.finditer(joined, max(0, off - 400), off + 60):
                cm = c
            if not cm:
                continue
            before = body[max(0, m.start() - 160):m.start()]
            have = set(NEAR.findall(before))
            keys = [k.strip() for k in cm.group(1).split(",") if k.strip()]
            keys = [re.sub(r"[^A-Za-z0-9_.:\-]", "-", k) for k in keys]
            new = [k for k in keys if "@" + k not in have and (not bibkeys or k in bibkeys)]
            if not new:
                continue
            sites += 1
            filled += len(new)
            out.append(body[pos:m.start()])
            out.append(" " + " ".join("@" + k for k in new))
            pos = m.end()
            break
    if not out:
        print(os.path.basename(d), "0 recovered")
        return
    out.append(body[pos:])
    open(f, "w", encoding="utf-8").write("".join(out))
    print("%-12s recovered %d keys at %d hole sites" % (os.path.basename(d), filled, sites))


if __name__ == "__main__":
    for a in sys.argv[1:]:
        run(a)
