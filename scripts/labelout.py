r"""Move equation labels that sit inside a `$…$` span to just outside it.

Typst parses `<eq:foo>` inside math as a comparison chain (`eq` then `foo`), so a label that the
converter left in the middle of a span aborts the span and everything after it - "unclosed
delimiter" reported lines away from the cause. Outside the span the very same label is legal and
keeps its meaning, so the fix is to slide it past the closing `$`.

Usage: python -X utf8 scripts/labelout.py papers/<id> [...]
Gate: syntax errors must fall. Backup main.typ.labelout
"""
import os
import re
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, ROOT)
sys.path.insert(0, os.path.join(ROOT, "check"))
import mathrem                                   # noqa: E402

NAME = re.compile(r"<[A-Za-z0-9_:.\-]{2,80}>")


def moves(line):
    """[(label, span_end)] for every `<name>` that lies inside a `$…$` span."""
    out = []
    spans = mathrem.spans_on(line)
    for m in NAME.finditer(line):
        for a, b in spans:
            if a < m.start() < b:
                out.append((m.group(0), b))
                break
    return out


def run(d):
    d = os.path.abspath(d)
    f = os.path.join(d, "main.typ")
    if not os.path.exists(f):
        return
    text = open(f, encoding="utf-8", errors="replace").read()
    lines = text.split("\n")
    base, _ = mathrem.compile_errors(f)
    if base == 0:
        print(os.path.basename(d), "clean")
        return
    bak = f + ".labelout"
    if not os.path.exists(bak):
        shutil.copy2(f, bak)
    done = 0
    for i in range(len(lines) - 1, -1, -1):
        mv = moves(lines[i])
        if not mv:
            continue
        trial = list(lines)
        ln = trial[i]
        for lab, end in sorted(mv, key=lambda x: -x[1]):
            j = ln.index(lab)
            ln = ln[:j] + ln[j + len(lab):] + lab
        trial[i] = ln
        mathrem.save(f, "\n".join(trial))
        n, _ = mathrem.compile_errors(f)
        print("  L%d %d->%d %s" % (i + 1, base, n,
              " ".join(m[0] for m in mv)[:70].encode("ascii", "replace").decode()))
        if n < base:
            lines, base = trial, n
            done += 1
        else:
            mathrem.save(f, "\n".join(lines))
    print(os.path.basename(d), "moved %d, errors now %d" % (done, base))


if __name__ == "__main__":
    for a in sys.argv[1:]:
        if not a.startswith("--"):
            run(a)
