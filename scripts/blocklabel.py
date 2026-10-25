r"""Move labels bound to a `#block[...]` onto the inner `#figure(...)`.

Pandoc-style conversions wrap figures/tables in nested `#block[` ... `]` and then
emit the label AFTER the block close:

    ] <table:foo>

Typst then binds `<table:foo>` to the block and `@table:foo` fails with
"cannot reference block". `#figure(...)` is referenceable, so move the label onto
the closing line of the enclosing figure (the first bare `)` line above the label).

Usage: python -X utf8 scripts/blocklabel.py papers/<dir> [...]
"""
import re, sys, os

LABEL_LINE = re.compile(r"^(\s*)\](\s*)(<[^>]+>)(\s*)$")


def run(path):
    path = os.path.join(path, "main.typ") if os.path.isdir(path) else path
    if not os.path.exists(path):
        return
    lines = open(path, encoding="utf-8").read().split("\n")
    moved = 0
    for i, ln in enumerate(lines):
        m = LABEL_LINE.match(ln)
        if not m:
            continue
        indent, label = m.group(1), m.group(3)
        # find nearest preceding line whose stripped content is exactly ")"
        j = i - 1
        while j >= 0 and lines[j].strip() not in (")", ")", "),"):
            if lines[j].strip() == "]":        # hit another block close first -> abort
                break
            j -= 1
        if j < 0 or lines[j].strip() not in (")", ")", "),"):
            continue
        lines[j] = lines[j] + " " + label
        lines[i] = indent + "]"
        moved += 1
    if moved:
        open(path, "w", encoding="utf-8").write("\n".join(lines))
    print("%-14s moved %d block label(s) onto figures" % (os.path.basename(os.path.dirname(path)), moved))


if __name__ == "__main__":
    for a in sys.argv[1:]:
        if a.startswith("-"):
            continue
        run(a)
