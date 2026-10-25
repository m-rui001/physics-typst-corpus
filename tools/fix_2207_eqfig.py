import pathlib

p = pathlib.Path(r"E:\phys\papers\2207.06431\main.typ")
s = p.read_text(encoding="utf-8")

old_sx = '''  p_(i j)^("SX-edge," "mean") = 3.4 times 10^(-2) \\
  & "Pauli+ sim" = 3.3 times 10^(-2), \\
  &"Pauli sim" = 3.1 times 10^(-2)
$)'''
new_sx = '''  p_(i j)^("SX-edge, mean") = 3.4 times 10^(-2) [&"Pauli"^+ "sim" = 3.3 times 10^(-2), \\
  &"Pauli sim" = 3.1 times 10^(-2) ],
$)'''

old_sz = '''  p_(i j)^("SZ-edge," "mean") = 3.2 times 10^(-2) \\
  & "Pauli+ sim" = 3.0 times 10^(-2) \\
  &"Pauli sim" = 2.9 times 10^(-2)
$)'''
new_sz = '''  p_(i j)^("SZ-edge, mean") = 3.2 times 10^(-2) [&"Pauli"^+ "sim" = 3.0 times 10^(-2), \\
  &"Pauli sim" = 2.9 times 10^(-2) ],
$)'''

for a, b in [(old_sx, new_sx), (old_sz, new_sz)]:
    assert a in s, a[:40]
    s = s.replace(a, b)

s = s.replace('image("imgs/st_edges_heatmap_expt.png", height: 3.8in)',
              'image("imgs/st_edges_heatmap_expt.png", height: 3.1in)')
s = s.replace('image("imgs/st_edges_heatmap_diff.png", height: 3.95in)',
              'image("imgs/st_edges_heatmap_diff.png", height: 3.1in)')

p.write_text(s, encoding="utf-8")
print("ok", s.count("3.1in"))
