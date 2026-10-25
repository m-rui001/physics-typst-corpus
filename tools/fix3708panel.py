import re

p = "papers/2112.03708/main.typ"
s = open(p, encoding="utf-8").read()

# undo the alias labels (Typst keeps only the last label on an element)
s = s.replace("<fig:stabilizers_state_init> <fig:stabilizers_state_inita>"
              " <fig:stabilizers_state_initb> <fig:stabilizers_state_initc>"
              " <fig:stabilizers_state_initd>", "<fig:stabilizers_state_init>")
s = s.replace(" <fig:schematic-9plus4-model> <fig:schematic-9plus4-modela>"
              " <fig:schematic-9plus4-modelc>", " <fig:schematic-9plus4-model>")

# helper: "3c" for panel <c> of a referenceable element
helper = ('#let panel(ref-lbl, letter) = context {\n'
          '  let el = query(ref-lbl).first()\n'
          '  link(el.location(), numbering(el.numbering, ..el.counter.at(el.location())) + letter)\n'
          '}\n')
anchor = '#show math.equation.where(block: true): set align(center)\n'
assert s.count(anchor) == 1
s = s.replace(anchor, anchor + helper)

# panel references: @fig:x c -> #panel(<fig:x>, "c")
# (the converter dropped the space between the label and the panel letter)
pairs = {
    "@fig:stabilizers_state_initc": "#panel(<fig:stabilizers_state_init>, \"c\")",
    "@fig:stabilizers_state_inita": "#panel(<fig:stabilizers_state_init>, \"a\")",
    "@fig:schematic-9plus4-modela": "#panel(<fig:schematic-9plus4-model>, \"a\")",
    "@fig:schematic-9plus4-modelc": "#panel(<fig:schematic-9plus4-model>, \"c\")",
}
for k, v in pairs.items():
    n = s.count(k)
    if n:
        s = s.replace(k, v)
        print("replaced", k, n)

open(p, "w", encoding="utf-8", newline="\n").write(s)
