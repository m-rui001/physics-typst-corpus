import shutil, sys

p = 'main.typ'
s = open(p, encoding='utf-8').read()
shutil.copy(p, p + '.preholes2')

reps = [
 ("quantum simulator @bernien2017probing    showed",
  "quantum simulator @bernien2017probing showed"),
 ("model @moudgalya2018a    a series",
  "model @aklt1987rigorous a series"),
 ("fragmentation @sala2019ergodicity    (also referred to as Hilbert space shattering @sala2019ergodicity, Krylov fracture, or jamming @zadnik2021foldedxxz1)",
  "fragmentation @sala2019ergodicity (also referred to as Hilbert space shattering @khemani2019local, Krylov fracture @moudgalya2019thermalization, or jamming @zadnik2021foldedxxz1)"),
 ("ETH @beugeling2014finite    (although this scaling is debated @beugeling2014finite   ).",
  "ETH @beugeling2014finite (although this scaling is debated @huang2022finite)."),
 ("@iadecola2019quantum    or the Hubbard model",
  "@iadecola2019quantum or the Hubbard model"),
 ("$eta$-pairing in the Hubbard model @schecter2019weak    and $H_(\"scar\")$",
  "$eta$-pairing in the Hubbard model @mark2020eta and $H_(\"scar\")$"),
 ("the toy model studied in @mark2020eta, although",
  "the toy model studied in @choi2018emergent, although"),
 ("Hubbard-like models @surace2020weakergodicity, and certain eigenstates in transverse field Ising ladders @iadecola2018exact    or Abelian lattice gauge theory on small ladders @vanvoorden2021disorder.",
  "Hubbard-like models @iadecola2018exact, and certain eigenstates in transverse field Ising ladders @vanvoorden2021disorder or Abelian lattice gauge theory on small ladders @banerjee2021quantum."),
 ("PXP model @turner2017quantum    or in its deformations with almost perfect revivals @turner2017quantum    are not",
  "PXP model @turner2017quantum or in its deformations with almost perfect revivals @choi2018emergent are not"),
 ("thin torus limit @lee2015geometric :",
  "thin torus limit @lee2015geometric @moudgalya2020quantum:"),
 ("@sala2019ergodicity    in the largest quantum number sector.",
  "@sala2019ergodicity in the largest quantum number sector."),
 ("@mukherjee2021constraint  or dipolar",
  "@mukherjee2021constraint or dipolar"),
 ("spin-1 XY model @eq:HubbardQP, and found",
  "spin-1 XY model @schecter2019weak, and found"),
 ("@bull2020quantum    (see @fig:outlook_QMBS_fragmentation)?",
  "@bull2020quantum (see @fig:outlook_QMBS_fragmentation)?"),
]

for old, new in reps:
    n = s.count(old)
    print(n, repr(old[:60]))
    if n != 1:
        sys.exit('count mismatch')
    s = s.replace(old, new)

open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('done')
