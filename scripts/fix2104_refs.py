import re, shutil

src = r"E:\phys\papers\2104.07036\main.typ"
shutil.copy(src, src + ".prerefs")
s = open(src, encoding="utf-8").read()
lines = s.split("\n")

PRE = '''#set math.equation(numbering: n => {
  let h = counter(heading).get()
  numbering("(1.1)", h.first(), n)
})
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [(#context counter(math.equation).at(e.location()).display())]
  } else { it }
}

// ---- theorem-like environments ----
#set figure.caption(position: top)
#show figure.where(kind: "thm"): set text(size: 10.5pt)
#show figure.where(kind: "thm"): set figure.caption(separator: [. ])
#show figure.where(kind: "statement"): set text(size: 10.5pt)
#show figure.where(kind: "statement"): set figure.caption(separator: [ ])
#show figure.where(kind: "statement"): it => block(
  width: 100%, stroke: 0.5pt + luma(160), inset: 0.6em,
  above: 1em, below: 1em, it,
)
#let thm(kind, body) = figure([], kind: "thm", supplement: kind, numbering: "1", caption: body)
#let statement(title, body) = figure(
  body, kind: "statement", supplement: [Statement], numbering: "1",
  caption: title, gap: 0.5em,
)
'''

# mapping from opening line (1-based, original) to environment
MAP = {
    42: ("statement", "Electric Completeness vs. Topological Gukov-Witten Operators"),
    60: ("statement", "Twist Vortex Completeness vs. Topological Wilson Operators"),
    176: ("Lemma", None),
    188: ("statement", "Endable Wilson Line Operators in Pure Gauge Theory"),
    201: ("statement", "Topological Gukov-Witten Operators in Pure Gauge Theory"),
    220: ("Lemma", None),
    235: ("statement", "Topological Wilson Line Operators in Pure Gauge Theory"),
    244: ("statement", "Endable Gukov-Witten Operators in Pure Gauge Theory"),
    467: ("Lemma", None),
    600: ("Theorem", None),
    694: ("Theorem", None),
    1022: ("Theorem", None),
}

# locate blocks
blocks = []
i = 0
while i < len(lines):
    if lines[i].startswith("#block["):
        j = i
        while lines[j].rstrip() not in ("]", "]."):
            j += 1
        blocks.append((i, j))
        i = j + 1
    else:
        i += 1

for (i, j) in reversed(blocks):
    start = i + 1
    if start not in MAP:
        continue
    kind, title = MAP[start]
    body = lines[i + 1:j]
    # pull label out of body
    label = None
    for k in range(len(body) - 1, -1, -1):
        m = re.search(r"<([\w:._-]+)>\s*$", body[k])
        if m:
            label = m.group(1)
            body[k] = body[k][:m.start()].rstrip()
            break
    # ambrose_singer label sits at start of body
    if body and re.match(r"\s*<ambrose_singer>", body[0]):
        label = "ambrose_singer"
        body[0] = re.sub(r"^\s*<ambrose_singer>\s*", "", body[0])
    while body and not body[0].strip():
        body.pop(0)
    while body and not body[-1].strip():
        body.pop()
    if kind == "statement":
        head = "#statement([ (%s)], [" % title
    else:
        head = "#thm([%s], [" % kind
    new = [head] + [" " + b if b.strip() else "" for b in body] + ["]"]
    new[-1] += ")"
    if label:
        new[-1] = new[-1][:-1] + ") <" + label + ">"
    lines[i:j + 1] = new

s = "\n".join(lines)

# preamble
anchor = "#show math.equation.where(block: true): set align(center)\n"
s = s.replace(anchor, anchor + PRE, 1)

# links -> refs
s = re.sub(r"#link\(<([\w:._-]+)>\)\[\\\[[^\]]*\\\]\]", r"@\1", s)

# literal supplement words before refs
s = re.sub(r"\bLemma~?\s*@", "@", s)
s = re.sub(r"\bStatement~?\s*@", "@", s)
s = re.sub(r"\bTheorem~?\s*@", "@", s)
s = s.replace("Statements @stat:ElectricCompleteness and @stat:TwistVortexCompleteness",
              "@stat:ElectricCompleteness and @stat:TwistVortexCompleteness")
s = s.replace("By (@eq:qdimfuse)", "By @eq:qdimfuse")

open(src, "w", encoding="utf-8", newline="\n").write(s)
print("blocks rewritten:", sum(1 for x in MAP))
