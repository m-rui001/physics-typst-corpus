"""Give two-column LaTeX papers the matching Typst page layout.

Sets `columns: 2`, turns figures into floats, and lifts the title/authors/
abstract block into a page-wide float (the revtex/AAS/PRL first page).
Falls back to columns-only when the front matter cannot live in a float
(e.g. footnotes that Typst refuses to place there).
"""
import glob
import io
import os
import re
import subprocess
import sys


def src_two_cols(path):
    """Two-column as declared by the LaTeX source. None when undecidable."""
    d = os.path.join(os.path.dirname(path), "src")
    for f in sorted(glob.glob(os.path.join(d, "**", "*.tex"), recursive=True)):
        t = io.open(f, encoding="utf-8", errors="replace").read()
        m = re.search(r"(?m)^[^%\n]*\\documentclass\s*\[([^\]]*)\]", t)
        if not m:
            continue
        toks = {x.strip() for x in re.sub(r"\s+", "", m.group(1)).lower().split(",")}
        if "twocolumn" in toks:
            return True
        if "onecolumn" in toks or "preprint" in toks:
            return False
        if "reprint" in toks:
            return True
        cls = re.search(r"\\documentclass\s*(?:\[[^\]]*\])?\s*\{([\w-]+)\}", t)
        cls = cls.group(1).lower() if cls else ""
        if cls.startswith("revtex"):
            # revtex4's default layout is not reliably one- or two-column
            return None
        if cls == "aa":
            # aa.cls sets twocolumn via ExecuteOptions
            return True
        if cls in ("aastex631", "aastex62", "aastex63", "mnras"):
            return True
        # plain article/book: single column unless multicols is used
        return bool(re.search(r"\\begin\{multicols\}\s*\{2\}", t))
    return None


def unwrap_float(L, path):
    """Undo the page-wide front-matter float (keeps the text, drops the float)."""
    a = next((i for i, l in enumerate(L) if l.startswith("#place(top + center, scope: \"parent\", float: true)[")), None)
    if a is None:
        return L
    b = next((i for i in range(a + 1, len(L)) if L[i] == "]"), None)
    if b is None:
        return L
    block = [x[2:] if x.startswith("  ") else x for x in L[a + 1:b]]
    return L[:a] + block + L[b + 1:]


COLUMNS_OPEN = re.compile(r"^#columns\(2, gutter: [\d.]+cm\)\[$")


def strip_stray_columns(L):
    """Drop converter-emitted `#columns(...)[` whose closer is stranded at EOF.

    The base converter wraps the whole body in a columns container but leaves
    the closing bracket at the end of the file. Inside a page-wide float that
    swallows the body, so both ends go when the brackets do not balance.
    """
    opens = [i for i, l in enumerate(L) if COLUMNS_OPEN.match(l)]
    if not opens:
        return L, 0
    delta = sum(l.count("[") - l.count("]") for l in L)
    if delta <= 0:
        return L, 0
    for i in reversed(opens):
        del L[i]
    # The converter's stranded closer is a bare `]` at EOF; drop as many as
    # there were openers (bracket arithmetic is unreliable around math).
    popped = 0
    idx = len(L) - 1
    while idx >= 0 and not L[idx].strip():
        idx -= 1
    while popped < len(opens) and idx >= 0 and L[idx].strip() == "]":
        del L[idx]
        idx -= 1
        popped += 1
    return L, len(opens)


def front_span(L):
    a = next((i for i, l in enumerate(L) if l.startswith("#align(center)[")), None)
    if a is None:
        return None
    # The front matter ends at the first body heading. Run-in headings
    # (`#strong[Introduction.--]`) count: a paper written that way has no `= `
    # until its appendices, and wrapping to that would float the whole body.
    b = next((i for i in range(a + 1, min(len(L), a + 90))
              if L[i].startswith("= ") or L[i].startswith("#strong[")
              or L[i].startswith("#underline[")), None)
    if b is None:
        return None
    b -= 1
    while b > a and not L[b].strip():
        b -= 1
    return a, b


def compile_ok(path):
    d = os.path.dirname(path)
    os.makedirs(os.path.join(d, "_work"), exist_ok=True)
    out = os.path.join(d, "_work", "_cols.pdf")
    r = subprocess.run(["typst", "compile", path, out],
                       capture_output=True, text=True, errors="replace")
    return r.returncode == 0, (r.stderr or "").strip().splitlines()[:4]


def apply(path):
    src = io.open(path, encoding="utf-8").read()
    L = src.split("\n")
    L, nstray = strip_stray_columns(L)
    if nstray:
        src = "\n".join(L)
        io.open(path, "w", encoding="utf-8", newline="\n").write(src)
    pi = next((i for i, l in enumerate(L) if l.startswith("#set page(")), None)
    if pi is None:
        return "no page"
    two = src_two_cols(path)
    if two is False:
        if "columns: 2" not in L[pi]:
            return "onecol"
        L[pi] = L[pi].replace(", columns: 2", "")
        L = unwrap_float(L, path)
        io.open(path, "w", encoding="utf-8", newline="\n").write("\n".join(L))
        ok, err = compile_ok(path)
        return "unwrapped" if ok else "FAIL " + str(err)
    if "columns: 2" in L[pi]:
        return "already"
    line = L[pi].replace("margin: (x: 2.2cm, y: 2.5cm)", "margin: (x: 1.7cm, y: 2.0cm)")
    if line.rstrip().endswith(")"):
        line = line.rstrip()[:-1] + ", columns: 2)"
    L[pi] = line
    if not any(l.startswith("#set figure(placement: auto)") for l in L):
        hi = next((i for i, l in enumerate(L) if l.startswith("#set heading")), pi)
        L.insert(hi + 1, "#set figure(placement: auto)")
    span = front_span(L)
    io.open(path + ".precol", "w", encoding="utf-8", newline="\n").write(
        "\n".join(L) if span is None else src)
    if span is not None:
        a, b = span
        head, block, tail = L[:a], L[a:b + 1], L[b + 1:]
        L[a:b + 1] = (["#place(top + center, scope: \"parent\", float: true)[",
                       "  " + block[0]] +
                      ["  " + x if x.strip() else x for x in block[1:]] + ["]"])
    io.open(path, "w", encoding="utf-8", newline="\n").write("\n".join(L))
    ok, err = compile_ok(path)
    if not ok and span is not None:
        # float rejected (usually a footnote); keep the columns, drop the wrap
        io.open(path, "w", encoding="utf-8", newline="\n").write(
            "\n".join(head + block + tail))
        ok2, err2 = compile_ok(path)
        return ("cols-only" if ok2 else "FAIL " + str(err2))
    return "ok" if ok else "FAIL " + str(err)


if __name__ == "__main__":
    for p in sys.argv[1:]:
        print(p, apply(os.path.join("papers", p, "main.typ")))
