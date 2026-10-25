r"""Splice one passage of main.typ back from the author's LaTeX, keeping it only if the
paper then compiles with fewer errors.

The letter-eating bug and pandoc's giving up on unknown macros left whole passages as
escaped LaTeX (`\\begin{equation}`, `\\$\\$`) followed by one-token-per-line fragments. This
converts the exact src lines again - expanding the shorthand macros the authors defined for
single letters - and swaps the result in over the damaged Typst lines. A backup is written
first, and the swap is rolled back automatically if `typst` reports more errors afterwards.

Usage: python -X utf8 scripts/passagesplice.py papers/2102.01111 SRC START END LO HI
"""
import io, os, re, shutil, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import resplice

B = chr(92)


def errors(d):
    p = subprocess.run(["typst", "compile", "main.typ", "_ps.pdf"], cwd=d, capture_output=True,
                       text=True, encoding="utf-8", errors="replace")
    return len(re.findall(r"^error:", (p.stderr or "") + (p.stdout or ""), re.M))


def expand_paper_macros(full, chunk):
    r"""Apply the authors' own macro definitions (`\newcommand` and `\def`) to the chunk.

    No invented mappings: a hardcoded single-letter table silently rewrote flux `f` into
    `\phi` here. Unknown macros are exactly what makes pandoc abandon an equation, so the
    definitions in the paper's preamble are the only legitimate source of expansion.
    """
    defs = resplice.macro_defs(full)
    for _ in range(2):
        chunk = resplice.expand_defs(chunk, defs)
    return chunk


def main(d, srcfile, start, end, lo, hi, force=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    base = errors(d)
    src = io.open(os.path.join(d, srcfile), encoding="utf-8", errors="replace").read().split("\n")
    chunk = expand_paper_macros("\n".join(src), "\n".join(src[start - 1:end]))
    print("=== latex:\n", chunk[:220].replace("\n", " "), "\n")
    new = resplice.clean(resplice.pandoc(chunk, os.path.join(d, "_work")))
    print("=== typst:\n", new[:300].replace("\n", " "), "\n")
    if not new or new.count("$") % 2 or B * 2 in new or B + "$" in new:
        print("REFUSED: empty, odd dollars or raw LaTeX left")
        return 1
    lines = io.open(mp, encoding="utf-8").read().split("\n")
    shutil.copyfile(mp, mp + ".passagespliced")
    lines[lo - 1:hi] = [l for l in new.split("\n") if l.strip()]
    io.open(mp, "w", encoding="utf-8").write("\n".join(lines))
    after = errors(d)
    print("spliced lines %d-%d   errors %d -> %d" % (lo, hi, base, after))
    if after > base and not force:
        shutil.copyfile(mp + ".passagespliced", mp)
        print("rolled back")
        return 1
    return 0


if __name__ == "__main__":
    a = sys.argv[1:]
    sys.exit(main(a[0], a[1], int(a[2]), int(a[3]), int(a[4]), int(a[5]), "force" in a))
