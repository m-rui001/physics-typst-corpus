r"""Close the math block before `#box(...[$ answer $])`.

Dataset/benchmark papers converted from LaTeX carry inline answer boxes, and pandoc
emits them *inside* the surrounding `$ ... $` math block:

    $ n = #box(stroke: black, inset: 3pt, [$ 121 $])$.

Typst then reads the inner `[$` as the end of the outer block and reports
`unclosed delimiter`. The box's own content is already a content block, so the fix is to
end the outer math just before the box: `... n $ #box(stroke: black, inset: 3pt, [$121$]).`

Usage: python -X utf8 scripts/boxfix.py papers/<dir> [...]
"""
import os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

BOX = re.compile(
    r"[ \t]*#box\(stroke: black, inset: 3pt, \[\s*\$[ \t]*(.*?)[ \t]*\$[ \t]*\]\)"
    r"([ \t]*\.?)[ \t]*\$?")
# once the box sits outside math, a `$` right after it opens a block nothing closes
ORPHAN = re.compile(r"(\]\))([ \t]*\.?[ \t]*)\$")


def run(d, boxes=True):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return
    body = open(mp, encoding="utf-8", errors="replace").read()
    n = len(BOX.findall(body)) if boxes else 0
    m0 = len(ORPHAN.findall(body))
    if not n and not m0:
        print("%-12s no answer boxes" % os.path.basename(d))
        return
    new = body
    if boxes:
        new = BOX.sub(lambda m: " $ #box(stroke: black, inset: 3pt, [$%s$])%s"
                      % (m.group(1).strip(), m.group(2).strip()), body)
    m2 = len(ORPHAN.findall(new))
    new = ORPHAN.sub(r"\1\2", new)
    open(mp, "w", encoding="utf-8").write(new)
    print("%-12s rewrote %d answer boxes, dropped %d orphan $"
          % (os.path.basename(d), n, m2))


if __name__ == "__main__":
    boxes = "--orphans" not in sys.argv
    for a in sys.argv[1:]:
        if a.startswith("-"):
            continue
        run(a, boxes)
