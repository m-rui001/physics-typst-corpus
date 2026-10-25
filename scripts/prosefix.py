r"""Repair mis-paired math delimiters by deleting the one `$` that shifts the pairing.

`mathbal`'s padding left lines where a whole English clause sits inside `$…$`. The clause is not
the defect: one extra `$` before it makes Typst pair the delimiters one step early, so prose
falls inside a span and the real equation falls outside. For every candidate the stage compiles
the file into `_probe.typ` - dropping the span's opener, its closer, both, or any single `$` on
a line Typst blamed - and keeps the change that lowers the syntax-error count the most, so
nothing is guessed and a change that does not help is never written.

Usage: python scripts/prosefix.py papers/<id> [...]   (gate: errors must fall; backup .prosefix)
"""
import os
import re
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "check"))
import mathrem          # noqa: E402

STOP = set("""the and or but nor for yet so of in on at to from by with without into onto over
under between within upon that this these those it its as if then than when while where which
who whom whose we our us you your they them their he she his her is are was were be been being
one two three four five six such let thus hence therefore moreover furthermore however also
again once here there all any both each few more most other some not only own same too very
just now may might can could will would shall should defining equation value values state
term terms which where given yields giving above""".split())
WORD = re.compile(r"[A-Za-z]+")


def prose_spans(line):
    """`(open, close)` dollar indices for spans that hold an English clause."""
    out = []
    if line.lstrip().startswith("//"):
        return out
    for a, b in mathrem.spans_on(line):
        seg = line[a:b]
        run = best = 0
        for m in WORD.finditer(seg):
            if m.group(0).lower() in STOP:
                run += 1
                best = max(best, run)
            else:
                run = 0
        words = [t for t in re.split(r"[^A-Za-z]+", seg) if len(t) >= 3]
        if best >= 3 or len(words) >= 5:
            out.append((a, b))
    return out


def variants(line, a, b):
    yield "drop-opener", line[:a] + line[a + 1:]
    yield "drop-closer", line[:b - 1] + line[b:]
    yield "drop-both", line[:a] + line[a + 1:b - 1] + line[b:]


def count(d, text):
    probe = os.path.join(d, "_probe.typ")
    open(probe, "w", encoding="utf-8").write(text)
    try:
        return mathrem.compile_errors(probe)
    finally:
        try:
            os.remove(probe)
        except OSError:
            pass


def trials(lines, width):
    """Candidate `(label, line-index, new-line)` edits from spans that hold English prose."""
    out = []
    spans = 0
    for i, ln in enumerate(lines):
        for a, b in prose_spans(ln):
            for name, newline in variants(ln, a, b):
                out.append((name, i, newline))
            spans += 1
        if spans >= width:
            break
    return out


def run(d, rounds=10, width=4, dollar_width=2):
    mp = os.path.join(d, "main.typ")
    if not os.path.isfile(mp):
        return 0
    text = open(mp, encoding="utf-8").read()
    base, errs = mathrem.compile_errors(mp)
    fixed = 0
    for _ in range(rounds):
        lines = text.split("\n")
        cand = trials(lines, width)
        # also try dropping each `$` on the lines Typst actually blamed
        for i in sorted({e[0] - 1 for e in errs})[:dollar_width]:
            if not (0 <= i < len(lines)) or lines[i].lstrip().startswith("//"):
                continue
            for m in list(re.finditer(r"[\$]", lines[i]))[:14]:
                p = m.start()
                cand.append(("drop-dollar", i, lines[i][:p] + lines[i][p + 1:]))
        if not cand:
            break
        best = None
        seen = set()
        for name, i, newline in cand:
            if newline == lines[i] or newline in seen:
                continue
            seen.add(newline)
            old = lines[i]
            lines[i] = newline
            n, e2 = count(d, "\n".join(lines))
            lines[i] = old
            if best is None or n < best[0]:
                best = (n, name, i, newline, e2)
            if n == 0:
                break
        if not best or best[0] >= base:
            break
        n, name, i, newline, e2 = best
        lines[i] = newline
        text = "\n".join(lines)
        print("  L%-5d %-12s syntax %d -> %d" % (i + 1, name, base, n), flush=True)
        base, errs, fixed = n, e2, fixed + 1
        if base == 0:
            break
    if not fixed:
        print("%s: no improvement (%d)" % (d, base), flush=True)
        return 0
    shutil.copyfile(mp, mp + ".prosefix")
    mathrem.save(mp, text)
    print("%s: %d delimiter fix(es), syntax %d -> %d"
          % (d, fixed, mathrem.compile_errors(mp + ".prosefix")[0], base), flush=True)
    return fixed


if __name__ == "__main__":
    tot = 0
    for a in sys.argv[1:]:
        d = os.path.abspath(a)
        try:
            tot += run(d)
        except Exception as e:
            print(a, "skip", type(e).__name__, str(e)[:120])
    print("total fixes", tot)
