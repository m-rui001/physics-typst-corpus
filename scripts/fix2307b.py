# -*- coding: utf-8 -*-
p = r"E:\phys\papers\2307.16873\main.typ"
lines = open(p, encoding="utf-8").read().split("\n")
assert lines[63].startswith("To see that,"), lines[63][:40]
assert "model as usual." in lines[79], lines[79][-40:]

block = r"""To see that, we start with the model $H = H_(t - J) + H_(upright("AF")) + H_(upright("Hund")) ,$ where $H_(t - J)$ is the intralayer $t$-$J$ model of $d_(x^2 - y^2)$ electrons, and $H_(upright("AF"))$ denotes the AF exchange $H_(upright("AF")) = J_perp sum_i bold(S)^d_(i,mu=1) dot.c bold(S)^d_(i,mu=-1)$ between the two layers. The index $mu = plus.minus 1$ labels the upper(lower) layer, and $bold(S)^d$ denotes the localized $d_(z^2)$ moment. $H_(upright("Hund")) = -J_(upright("H")) sum_(i,mu) bold(S)^c_(i,mu) dot.c bold(S)^d_(i,mu)$ is the on-site Hund's coupling, with $bold(S)^c$ the spin of $d_(x^2 - y^2)$ electron. To further simplify the two-orbital model, it is noted that the density functional theory calculations suggest $t tilde.eq 0.5$~eV ($d_(x^2 - y^2)$), $t_perp^z tilde.eq 0.64$~eV ($d_(z^2)$)~@Luo2023bilayer @Zhang2023electronic, placing the nickelate in the strong coupling regime by taking Hubbard $U tilde.eq 5$~eV (i.e., $U \/ t tilde 10$) @Cao2023flat @Werner2023correlated. As an intra-atomic exchange, the FM Hund's rule coupling is about $J_(upright(H)) tilde 1$~eV @Cao2023flat @Werner2023correlated, clearly greater than the spin exchanges $J tilde 4 t^2 \/ U tilde.eq 0.2$~eV and $J_perp tilde.eq 0.32$~eV, which is sufficiently strong to transfer the AF couplings between the two $e_g$ orbitals~@Qu2023Orb. It is therefore sensible to take the large $J_(upright(H))$ limit and symmetrize the spins $bold(S)^(d)_(i,mu)$ and $bold(S)^(c)_(i,mu)$ of the two orbitals. The AF interlayer coupling between $d_(z^2)$ moments can be effectively expressed as $bold(S)^(c)_(i,mu=1) dot.c bold(S)^c_(i,mu=-1)$ in the symmetrized spin-triplet space. With this, an effective single-band bilayer $t$-$J$-$J_perp$ model can be obtained~@Lu2023interlayer

$
  H_(upright("bilayer")) & = & -t sum_(angle.l i,j angle.r, mu, sigma) (c^dagger_(i, mu, sigma) c_(j, mu, sigma) + H.c.) \
  & + & J sum_(angle.l i,j angle.r, mu) (bold(S)^c_(i,mu) dot.c bold(S)^c_(j,mu) - 1/4 n_(i,mu) n_(j,mu)) \
  & + & J_perp sum_(i) bold(S)^c_(i,mu=1) dot.c bold(S)^c_(i,mu=-1),
$ <eq:b-t-J>
where $sigma = { arrow.t \, arrow.b }$ is the spin orientation, and the vector operator $bold(S)^c_(i,mu) = 1/2 \, c^dagger_(i,mu,sigma) \, (bold(sigma)_(sigma,sigma')) \, c_(i,mu,sigma')$ denotes the spin of the itinerant $d_(x^2 - y^2)$ electron with the Pauli matrices $bold(sigma) = { sigma_x \, sigma_y \, sigma_z }$. Note the double occupancy is projected out in the $t$-$J$-$J_perp$ model as usual."""

out = lines[:63] + block.split("\n") + lines[80:]
open(p, "w", encoding="utf-8", newline="\n").write("\n".join(out))
print("replaced lines 64-80")
