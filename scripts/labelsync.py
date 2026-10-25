r"""Point every `@ref` at the object it was written for.

The converter labeled headings by slugifying their title (`<radius-measurement-and-implications-for-eos>`)
while the prose kept the author's own labels (`@sec:production-analysis`), so nearly every
cross-reference dangles and Typst refuses to build a file with no syntax errors at all. This stage
walks the headings of `main.typ` and of the macro-expanded source side by side, gives each heading
the label the author attached to it, rewrites every spelling of a reference to that heading
(`@sec:foo bar`, `#ref(label("sec:foo bar"))`) to the one canonical form, and finally replaces the
references whose target never made it into the document at all (tables the converter dropped,
citations absent from the paper's own .bib) with a visible placeholder instead of a build failure.

Usage: python -X utf8 scripts/labelsync.py papers/<id> [...] [--dry]
Gate: reference errors must fall and syntax errors must not rise. Backup main.typ.labelsync
"""
import os
import re
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "check"))
sys.path.insert(0, os.path.join(HERE))
import mathrem                                        # noqa: E402
import proseholes as P                                # noqa: E402

REF = re.compile(r"#ref\(\s*label\(\"([^\"]+)\"\)\s*\)|#ref\(<([^>]+)>\)|@([A-Za-z0-9_.:\-]+)")
HEAD = re.compile(r"^(=+)\s+(.*?)\s*$")
LAB = re.compile(r"\s*<([^>]+)>\s*$")
STRIP = re.compile(r"^(sec|subsec|sssec|s|section|subsection|subsubsection)-")


def norm(k):
    k = re.sub(r"[^A-Za-z0-9]+", "-", k).strip("-").lower()
    return STRIP.sub("", k)


def canon(label):
    """Author label -> Typst-legal label name (spaces become hyphens, colons kept)."""
    return re.sub(r"\s+", "-", label.strip()).strip("-")


def refs_in(text):
    """[(start, end, key)] for every reference in the file.

    `@preview/cetz:0.4.2` in the import line is a package path, not a reference, so a `@` that is
    quoted or followed by `/` is left alone.
    """
    out = []
    for m in REF.finditer(text):
        key = m.group(1) or m.group(2) or m.group(3)
        a, b = m.start(), m.end()
        while key and key[-1] in ".:-":
            key = key[:-1]
            b -= 1
        if m.group(3) is not None and (text[a - 1:a] in "\"'" or text[b:b + 1] == "/"):
            continue
        out.append((a, b, key))
    return out


def labels_in(text):
    return set(re.findall(r"<([A-Za-z0-9_:.\-]+)>", text))


def headings(text):
    """[(line_index, level, title, label_or_None)] in document order, skipping code blocks."""
    lines = text.split("\n")
    out, infig = [], 0
    for i, ln in enumerate(lines):
        s = ln.strip()
        if infig:
            infig += s.count(")") - s.count("(")
            if infig <= 0:
                infig = 0
            continue
        if s.startswith("#figure("):
            infig = s.count("(") - s.count(")")
            continue
        m = HEAD.match(s)
        if not m or s.startswith("//"):
            continue
        title = m.group(2)
        lab = LAB.search(title)
        out.append((i, len(m.group(1)), (LAB.sub("", title) if lab else title).strip(),
                    lab.group(1) if lab else None))
    return out


def align(hs, src_heads):
    """Pair main.typ headings with source headings, in order, by title words."""
    pairs, ptr = [], 0
    for h in hs:
        mt = P.toks(re.sub(r"<[^>]*>", "", h[2]))
        for j in range(ptr, len(src_heads)):
            st = P.toks(P.expand(src_heads[j]["tex"], {}))
            if not st:
                continue
            if st[:len(mt)] == mt or mt[:len(st)] == st or (mt and mt[0] == st[0] and norm(h[2]) == norm(src_heads[j]["tex"])):
                pairs.append((h, src_heads[j]))
                ptr = j + 1
                break
        else:
            pairs.append((h, None))
    return pairs


def run(d, dry=False):
    d = os.path.abspath(d)
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        return
    files = list(P.glob_tex(d))
    if not files:
        print(os.path.basename(d), "no src/")
        return
    T = P.macro_table(files)
    src = P.src_blocks(d, T)
    src_heads = [s for s in src if s["kind"] == "head"]
    text = P.read(f)
    base, bsyn, bref = P.probe(d, text)
    hs = headings(text)
    pairs = align(hs, src_heads)

    # 1. target map: canonical label -> the ref spellings that mean it
    wanted = {}
    lines = text.split("\n")
    for h, s in pairs:
        if not s or not s["label"]:
            continue
        k = canon(s["label"])
        wanted[k] = None
        if h[3]:
            wanted.setdefault(norm(h[3]), k)
    keys = refs_in(text)
    labels = labels_in(text)
    by_norm = {}
    for k in list(wanted) + list(labels):
        by_norm.setdefault(norm(k), []).append(k)

    rename = {}
    for i, ln in enumerate(lines):
        m = HEAD.match(ln.strip())
        if not m:
            continue
        p = [q for q in pairs if q[0][0] == i]
        if not p or not p[0][1] or not p[0][1]["label"]:
            continue
        k = canon(p[0][1]["label"])
        old = p[0][0][3]
        if old and norm(old) == norm(k):
            continue
        if old:
            rename[old] = k
        title = LAB.sub("", m.group(2)).strip() if old else m.group(2).rstrip()
        lines[i] = "=" * len(m.group(1)) + " " + title + " <" + k + ">"

    out = "\n".join(lines)
    keys = refs_in(out)

    # rewrite every spelling of a reference to the label the heading now carries
    for a, b, key in sorted(keys, reverse=True):
        nk = norm(key)
        hit = None
        for cand in by_norm.get(nk, []):
            if cand in out and ("<" + cand + ">") in out:
                hit = cand
                break
        if hit is None and key in rename:
            hit = rename[key]
        if hit is not None and a > 0 and out[a - 1] in ")]}\"":
            hit = None
        if hit is None:
            continue
        # rewrite #ref(label("x")) / #ref(<x>) forms to the same `@key` shorthand
        end = b
        if out[b:b + 1] == ".":
            end = b + 1
        start = a
        if out[a:a + 1] == "(":
            pass
        out = out[:start] + "@" + hit + out[end:]

    # 2. citations the paper's own .bib does not contain (the author's PDF shows the same hole)
    CIT = re.compile(r"#cite\(\s*<([^>]+)>(?:[^)]*)?\)")
    bibf = os.path.join(d, "refs.bib")
    have = set(re.findall(r"@\s*[\w-]+\s*\{\s*([^,\s{}]+)", P.read(bibf))) if os.path.exists(bibf) else set()
    if have:
        for a, b, k in sorted([(m.start(), m.end(), m.group(1)) for m in CIT.finditer(out)],
                              reverse=True):
            if k in have:
                continue
            out = out[:a] + "\\[" + k + "\\]" + out[b:]

    # 3. references whose target never reached the document become honest placeholders
    lab_now = labels_in(out)
    still = [k for a, b, k in refs_in(out) if "<" + k + ">" not in out and k not in lab_now and k not in have]
    for a, b, k in sorted([(a, b, key) for a, b, key in refs_in(out)
                           if "<" + key + ">" not in out and key not in lab_now and key not in have],
                          reverse=True):
        out = out[:a] + "\\[" + k + "\\]" + out[b:]

    n, nsyn, nref = P.probe(d, out)
    print("%s heads=%d/%d renamed=%d dangling=%d -> %d (syn %d ref %d) from %d (syn %d ref %d)"
          % (os.path.basename(d), sum(1 for p in pairs if p[1]), len(pairs), len(rename),
             len(still), n, nsyn, nref, base, bsyn, bref))
    if dry:
        open(os.path.join(P.TMP, "labelsync_preview.typ"), "w", encoding="utf-8").write(out)
        print("  preview at check/tmp/labelsync_preview.typ")
        return
    if n <= base:
        bak = f + ".labelsync"
        if not os.path.exists(bak):
            shutil.copy2(f, bak)
        mathrem.save(f, out)
        print("  WROTE")
    else:
        print("  reverted")


if __name__ == "__main__":
    dry = "--dry" in sys.argv
    for a in sys.argv[1:]:
        if a.startswith("--"):
            continue
        run(a, dry)
