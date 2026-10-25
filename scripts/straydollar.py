r"""Close the stray `$` that traps prose inside math, verified by compiling.

Lines whose `$` count is odd are where Typst loses its way: the run it opens swallows the
rest of the paragraph and it then reports "unclosed delimiter" hundreds of lines away
(2102.01111: errors at 834/1563/1781 all trace back to odd-`$` lines such as
`$This gives rise to the exponential behaviour ...` and `$<IR-gauge-coupling...>$ where`).

For every such line two candidate repairs exist - drop the first delimiter, or drop the
last one. Each candidate is applied and the paper is recompiled; the candidate that lowers
the error count is kept, the others are rolled back. Only delimiter characters change.

Usage: python -X utf8 scripts/straydollar.py papers/2102.01111 [--dry] [--limit N]
"""
import glob, io, os, re, shutil, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
B = chr(92)

STR = re.compile(r'"[^"\n]*"')
ESCD = re.compile(r"(?:" + B + B + r")*" + B + r"\$")
LABELRUN = re.compile(r"\$<([A-Za-z0-9][A-Za-z0-9:_./-]*)>\$")


def dollars(line):
    s = STR.sub(lambda m: " " * len(m.group(0)), line)
    s = ESCD.sub(lambda m: " " * len(m.group(0)), s)
    return [i for i, c in enumerate(s) if c == "$"]


def errors(d, f="main.typ"):
    p = subprocess.run(["typst", "compile", f, "_sd.pdf"], cwd=d, capture_output=True,
                       text=True, encoding="utf-8", errors="replace")
    return len(re.findall(r"^error:", (p.stderr or "") + (p.stdout or ""), re.M))


def run(d, dry=False, limit=None):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    base = errors(d)
    lines = io.open(mp, encoding="utf-8").read().split("\n")
    defined = set(re.findall(r"<([A-Za-z0-9][A-Za-z0-9:_./-]*)>", "\n".join(lines)))
    fixed = 0
    if not dry:
        shutil.copyfile(mp, mp + ".strayfixed")
    for i, l in enumerate(lines):
        pos = dollars(l)
        if not pos or len(l.strip()) < 20:
            continue
        # a label remnant is unambiguous: `$<name>$` is a reference, not math
        if LABELRUN.search(l) and any(x in defined for x in LABELRUN.findall(l)):
            new = LABELRUN.sub(lambda m: "@" + m.group(1) if m.group(1) in defined
                               else m.group(0), l)
            if new != l:
                lines[i] = new
                fixed += 1
                continue
        if len(pos) % 2 == 0:
            continue
        for which in ("last", "first"):
            k = pos[-1] if which == "last" else pos[0]
            cand = l[:k] + l[k + 1:]
            if not cand.strip():
                continue
            trial = list(lines)
            trial[i] = cand
            io.open(mp, "w", encoding="utf-8").write("\n".join(trial))
            e = errors(d)
            if e < base:
                print("  line %d: dropped %s `$`  errors %d -> %d" % (i + 1, which, base, e))
                lines, base, fixed = trial, e, fixed + 1
                break
            lines[i] = l
            io.open(mp, "w", encoding="utf-8").write("\n".join(lines))
        if limit and fixed >= limit:
            break
    if not dry:
        io.open(mp, "w", encoding="utf-8").write("\n".join(lines))
    else:
        io.open(mp, "w", encoding="utf-8").write("\n".join(lines))
    return fixed


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv[1:]
    lim = int(sys.argv[sys.argv.index("--limit") + 1]) if "--limit" in sys.argv[1:] else None
    for a in args or sorted(glob.glob("papers/2*")):
        if not os.path.isdir(a):
            continue
        n = run(a, dry, lim)
        print("%-14s delimiters repaired %d" % (os.path.basename(a), n), flush=True)
