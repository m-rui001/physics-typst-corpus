r"""Wire figures that pandoc left empty: `#figure([], caption: [])`.

Pandoc drops `\includegraphics` when it rejects a figure chunk, so main.typ ends up with
a caption (sometimes not even that) while the asset sits unused in `src/`. Each empty
figure is matched to its source `figure` environment by, in order:
  1. the `[figure: NAME]` placeholder pandoc left behind (NAME is the asset basename),
  2. its `<fig:...>` label, looked up against `\label{fig:...}` in the source,
  3. caption wording,
  4. document order among the still-unmatched figures.
PDF/EPS assets are rasterised to PNG because Typst's `image()` cannot embed them.

Usage: python -X utf8 scripts/figwire.py papers/<dir> [...]
"""
import glob, os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

FIGENV = re.compile(r"\\begin\{figure\*?\}", re.I)
ENDENV = re.compile(r"\\end\{figure\*?\}", re.I)
CAP = re.compile(r"\\caption\*?\s*(?:\[[^\]]*\])?\s*\{")
GRAPH = re.compile(r"\\includegraphics\s*(?:\[[^\]]*\])?\s*\{([^}]*)\}")
LBL = re.compile(r"\\label\{([^}]*)\}")
WORD = re.compile(r"[a-zA-Z]{4,}")


def strip_tex(t):
    t = re.sub(r"\$[^$]*\$", " ", t)
    t = re.sub(r"\\[a-zA-Z@]+\*?(?:\[[^\]]*\])?", " ", t)
    return re.sub(r"[{}&\\%~_^]", " ", t)


def key(t):
    return " ".join(WORD.findall(t.lower())[:6])


def brace_end(s, i):
    d = 0
    while i < len(s):
        if s[i] == "{":
            d += 1
        elif s[i] == "}":
            d -= 1
            if d == 0:
                return i + 1
        i += 1
    return len(s)


def find_asset(d, name):
    name = name.strip().replace("\\", "/")
    base = os.path.basename(re.sub(r"\.\w+$", "", name))
    groups = [glob.glob(os.path.join(d, "src", "**", name + ".*"), recursive=True),
              glob.glob(os.path.join(d, "src", "**", base + ".*"), recursive=True),
              glob.glob(os.path.join(d, "imgs", base + ".*"), recursive=True),
              glob.glob(os.path.join(d, "src", "**", base), recursive=True)]
    for group in groups:
        for c in sorted(group):
            if os.path.isfile(c) and re.search(r"\.(pdf|png|jpe?g|eps|gif)$", c, re.I):
                return c
    return None


def to_png(d, asset):
    if re.search(r"\.(png|jpe?g|gif)$", asset, re.I):
        return os.path.relpath(asset, d).replace("\\", "/")
    os.makedirs(os.path.join(d, "imgs"), exist_ok=True)
    out = "imgs/" + re.sub(r"[\\/]", "_", os.path.relpath(asset, os.path.join(d, "src"))) + ".wired.png"
    p = os.path.join(d, out)
    if not os.path.exists(p):
        import pymupdf
        pymupdf.open(asset)[0].get_pixmap(dpi=160).save(p)
    return out


def src_blocks(d):
    """Source figure environments in document order: labels, graphic paths, caption key."""
    out = []
    for tf in sorted(glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True)):
        try:
            s = open(tf, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        for m in FIGENV.finditer(s):
            e = ENDENV.search(s, m.end())
            blk = s[m.end():e.start()] if e else s[m.end():m.end() + 6000]
            gfx = GRAPH.findall(blk)
            if not gfx:
                continue
            c = CAP.search(blk)
            ck = key(strip_tex(blk[c.end():brace_end(blk, c.end() - 1)])) if c else ""
            out.append({"labels": [l.strip() for l in LBL.findall(blk)], "gfx": gfx,
                        "ckey": ck, "used": False})
    return out


def body_empty(b):
    b = b.strip()
    return b in ("[]", "[[]]", "") or re.fullmatch(r"\[\s*figure:[^\]]*\]", b)


def figure_spans(s):
    for m in re.finditer(r"#figure\(", s):
        depth, i = 1, m.end()
        while i < len(s) and depth:
            if s[i] in "[{(":
                depth += 1
            elif s[i] in "]})":
                depth -= 1
            elif s[i] == "," and depth == 1:
                break
            i += 1
        yield m.end() - 1, i, s[m.end():i]


def caption_of(s, i):
    ce = re.search(r"caption:\s*\[", s[i:i + 900])
    if not ce:
        return "", ""
    cs = i + ce.end()
    cb, dd = cs, 1
    while cb < len(s) and dd:
        cb += 1
        dd += (s[cb - 1] == "[") - (s[cb - 1] == "]")
    cap = s[cs:cb - 1]
    lab = re.search(r"<([A-Za-z0-9_.:\-]+)>", s[i:i + 900])
    return key(strip_tex(cap)), (lab.group(1) if lab else "")


def run(d):
    d = os.path.abspath(d)
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        return
    s = open(f, encoding="utf-8", errors="replace").read()
    blocks = src_blocks(d)
    by_lbl, by_ckey = {}, {}
    for b in blocks:
        for l in b["labels"]:
            by_lbl.setdefault(l, b)
            by_lbl.setdefault(re.sub(r"[^A-Za-z0-9_.:\-]", "-", l), b)
        if b["ckey"]:
            by_ckey.setdefault(b["ckey"], b)

    hits = []
    for start, end, body in figure_spans(s):
        if not body_empty(body):
            continue
        # convert.py splits an over-tall table into a caption-only `#figure([],
        # caption: [...], kind: table)` plus the table body after it; wiring source
        # figure assets into that caption placeholder steals the next figure's panels.
        if re.search(r"kind:\s*table", s[end:end + 3000]):
            continue
        cap, lab = caption_of(s, end)
        ph = re.search(r"figure:\s*([A-Za-z0-9_./\- ]+)", body)
        hits.append({"start": start, "end": end, "ph": ph.group(1).strip() if ph else "",
                     "lab": lab, "cap": cap})

    for h in hits:                        # 1: placeholder asset name
        if h["ph"]:
            a = find_asset(d, h["ph"])
            if a:
                h["gfx"] = [a]
    for h in hits:                        # 2/3: label then caption wording
        if "gfx" in h:
            continue
        b = by_lbl.get(h["lab"]) if h["lab"] else None
        if b is None and h["cap"]:
            b = by_ckey.get(h["cap"])
        if b is not None and not b["used"]:
            h["blk"] = b
            b["used"] = True
    left = [h for h in hits if "gfx" not in h and "blk" not in h]
    free = [b for b in blocks if not b["used"]]
    if len(left) <= len(free):            # 4: document order, only when unambiguous
        for h, b in zip(left, free):
            h["blk"] = b

    wired = 0
    for h in hits:
        gfx = h.get("gfx")
        if not gfx and h.get("blk"):
            gfx = [g for g in (find_asset(d, p) for p in h["blk"]["gfx"]) if g]
        if not gfx:
            continue
        try:
            paths = [to_png(d, g) for g in gfx]
        except Exception as e:
            print("  rasterise failed:", e)
            continue
        imgs = ", ".join('image("%s", width: 100%%)' % p for p in paths)
        if len(paths) > 1:      # `figure` takes one positional arg, so group the panels
            imgs = "[\\n" + "\\n".join('#image("%s", width: 100%%)' % p for p in paths) + "\\n]"
        h["new"] = "(\n  " + imgs
        wired += 1
    for h in sorted(hits, key=lambda x: x["start"], reverse=True):
        if "new" in h:
            s = s[:h["start"]] + h["new"] + s[h["end"]:]
    if wired:
        open(f, "w", encoding="utf-8").write(s)
    print("%-12s wired %d of %d empty figures" % (os.path.basename(d), wired, len(hits)))


if __name__ == "__main__":
    for a in sys.argv[1:]:
        run(a)
