p = "papers/2112.03708/main.typ"
s = open(p, encoding="utf-8").read()

# 1. leakage table: restore caption + label, drop stray " table"
old1 = (" )]\n , kind: table\n )\n\n table\n\n= Decoding and weight extraction")
new1 = (" )],\n caption: [\n   Extracted logical error per cycle "
        "$epsilon_(\"L\")$ for the experiment preserving eigenstates of "
        "$⟨ hat(Z)_(upright(\"L\")) ⟩$ and of $⟨ hat(X)_(upright(\"L\")) ⟩$ "
        "using the indicated leakage rejection schemes. The retained data "
        "fraction per cycle $r_c$ after leakage rejection is also indicated.\n"
        " ], kind: table\n) <tab:leakage_schemes>\n\n= Decoding and weight extraction")
assert s.count(old1) == 1, ("t1", s.count(old1))
s = s.replace(old1, new1)

# 2. 9+4 model figure: restore its three labels
old2 = ('imgs/9plus4_vs_17_model.png", width: 100%),')
assert s.count(old2) == 1
i = s.index(old2)
j = s.index("\n\nTo introduce", i)
seg = s[i:j]
assert seg.rstrip().endswith(")"), seg[-40:]
s = s[:i] + seg.rstrip() + (" <fig:schematic-9plus4-model> <fig:schematic-9plus4-modela>"
                            " <fig:schematic-9plus4-modelc>") + s[j:]

# 3. sub-panel labels on the state-initialization figure
old3 = "<fig:stabilizers_state_init>\n"
assert s.count(old3) == 1
s = s.replace(old3, "<fig:stabilizers_state_init> <fig:stabilizers_state_inita>"
                    " <fig:stabilizers_state_initb> <fig:stabilizers_state_initc>"
                    " <fig:stabilizers_state_initd>\n")
open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")
