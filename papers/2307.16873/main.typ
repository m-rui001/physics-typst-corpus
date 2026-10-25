#import "@preview/cetz:0.4.2"

// —- document setup —-
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.90cm, bottom: 2.32cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Bilayer $t$-$J$-$J_perp$ Model and Magnetically Mediated Pairing in the Pressurized Nickelate $"La"_3"Ni"_2"O"_7$])   #v(1.2em)
    #text(10.5pt)[Xing-Zhou Qu#super[1], Dai-Wei Qu#super[1], Jialin Chen#super[2], Congjun Wu#super[4], Fan Yang#super[8], Wei Li#super[2], Gang Su#super[1]]
  
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Kavli Institute for Theoretical Sciences, University of Chinese Academy of Sciences, Beijing 100190, China] \
    #text(9pt)[#super[2] CAS Key Laboratory of Theoretical Physics, Institute of Theoretical Physics, Chinese Academy of Sciences, Beijing 100190, China] \
    #text(9pt)[#super[3] Hefei National Laboratory, Hefei 230088, China] \
    #text(9pt)[#super[4] New Cornerstone Science Laboratory, Department of Physics, School of Science, Westlake University, 310024, Hangzhou, China] \
    #text(9pt)[#super[5] Institute for Theoretical Sciences, Westlake University, 310024, Hangzhou, China] \
    #text(9pt)[#super[6] Key Laboratory for Quantum Materials of Zhejiang Province, School of Science, Westlake University, Hangzhou 310024, Zhejiang, China] \
    #text(9pt)[#super[7] Institute of Natural Sciences, Westlake Institute for Advanced Study, 310024, Hangzhou, China] \
    #text(9pt)[#super[8] School of Physics, Beijing Institute of Technology, Beijing 100081, China] \
    #text(9pt)[#super[9] CAS Center for Excellence in Topological Quantum Computation, University of Chinese Academy of Sciences, Beijing 100190, China] \
  ]

  The recently discovered nickelate superconductor La$""_3$Ni$""_2$O$""_7$ has a high transition temperature near 80~K under pressure, providing an additional avenue for exploring unconventional superconductivity. Here with state-of-the-art tensor-network methods, we study a bilayer $t$-$J$-$J_perp$ model for La$""_3$Ni$""_2$O$""_7$ and find a robust $s$-wave superconductive (SC) order mediated by interlayer magnetic couplings. Large-scale density matrix renormalization group calculations find algebraic pairing correlations with Luttinger parameter $K_"SC" lt.tilde 1$. Infinite projected entangled-pair state method obtains a nonzero SC order directly in the thermodynamic limit, and estimates a strong pairing strength $macron(Delta)_z tilde cal(O) ( 0.1 )$. Tangent-space tensor renormalization group simulations elucidate the temperature evolution of SC pairing and further determine a high SC temperature $T_c^(*) / J tilde cal(O) ( 0.1 )$. Because of the intriguing orbital selective behaviors and strong Hund's rule coupling in the compound, $t$-$J$-$J_perp$ model has strong interlayer spin exchange (while negligible interlayer hopping), which greatly enhances the SC pairing in the bilayer system. Such a magnetically mediated pairing has also been observed recently in the optical lattice of ultracold atoms. Our accurate and comprehensive tensor-network calculations reveal a robust SC order in the bilayer $t$-$J$-$J_perp$ model and shed light on the pairing mechanism of the high-$T_c$ nickelate superconductor.
]

#footnote[These authors contributed equally to this work.]





#emph[Introduction.—] High-$T_c$ superconductivity, since its discovery in doped cuprates~@Cuprate1986 @LNW-HighTc-RMP2006 @Keimer2015Nature, has raised long-lasting research interests. Very recently, under a high pressure of above 14 GPa, a Ruddlesden-Popper bilayer perovskite La$""_3$Ni$""_2$O$""_7$ exhibits a high $T_c$ near 80~K @Nickelate80K. Later on, optical measurements show that the compound features strong electronic correlations that place it in the proximity of a Mott phase~@Liu2023correlation, despite certain density-wave-like order under ambient pressure. Zero resistance and strange metal behaviors have been reported under high pressure by other experimental groups~@Hou2023emergence @Zhang2023hightemperature. Currently, the electronic structure, effective model, and pairing mechanism in the pressurized nickelate La$""_3$Ni$""_2$O$""_7$~are under very active investigation~@Luo2023bilayer @Zhang2023electronic @Yang2023s-wave @Kuroki2023bilayer @Gu2023pairing @Werner2023correlated @Cao2023flat @Wu2023charge @Shen2023effective @Lu2023interlayer.


// [figvision] imgs/Fig1.png
// Panel (a) is a schematic of stacked orbital clouds rather than a data plot. It shows alternating layers of
// blue and red lobe-shaped orbitals representing d_x2-y2 and d_z2 states, separated by faint grey planes.
// Vertical double-headed arrows labeled J_perp connect orbitals between layers, while curved and straight arrows
// labeled t and J indicate intra-layer hopping and exchange within a plane. Yellow vertical lines link orbitals
// across the stack. A lower-right inset explicitly labels d_x2-y2 and d_z2 orbitals joined by a brown arrow J_H
// and encircled by orange dashed loops. A large rightward arrow annotated Large J_H bridges this panel to panel
// (b), conveying a multi-orbital lattice with interlayer coupling and strong Hund exchange. Panel (b) is a
// three-dimensional cubic lattice schematic built from blue spheres connected by grey horizontal bonds and
// yellow vertical rods. Curved arrows denote hopping t along top edges, a horizontal double arrow marks J across
// a plaquette, and a vertical double arrow on the right marks J_perp. Two vertical bonds are highlighted by pink
// shaded cylinders labeled Delta dagger on the left and Delta on the right, separated by a horizontal double
// arrow labeled r, with Phi_zz written beneath. A purple Cartesian axis triad in the lower right indicates the
// x, y, and z directions. The panel depicts an effective lattice model in which pairing amplitudes Delta are
// separated by distance r under the large J_H limit.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure(placement: top, image("imgs/Fig1.png", width: 100.0%),
  caption: [
    \(a) Two $e_g$ orbitals in the bilayer structure of the nickelate La$""_3$Ni$""_2$O$""_7$. The quarter-filled $d_(x^2 - y^2)$ orbitals form an effective $t$-$J$ model with intralayer hopping $t$ and spin exchange $J$. The $d_(z^2)$ orbital is localized and has an interlayer AF exchange through the $sigma$ bonding. The spins of $d_(x^2 - y^2)$ and $d_(z^2)$ orbitals are coupled through an on-site FM Hund's rule coupling $J_(upright(H))$. In the large $J_(upright(H))$ limit, we arrive at (b) bilayer $t$-$J$-$J_perp$ model, where the interlayer AF coupling $J_perp$ is strong while the interlayer hopping is absent. The SC pairing correlation $Phi_(z z) ( r )$ is between two interlayer pairing $Delta^(( dagger ))$ along the vertical $z$ direction and separated by a distance $r$ along the $x$ direction.
  ]
)
<Fig1>



A bilayer two-orbital Hubbard model has been proposed to describe the high-pressure phase of La$""_3$Ni$""_2$O$""_7$, where the kinetic part is determined from the density functional theory calculations~@Luo2023bilayer, and the interactions including the Hubbard $U$, Hund's rule coupling $J_(upright(H))$, etc., can be included. The SC instability and related pairing symmetry have been discussed with weak (to intermediate) coupling approaches @Yang2023s-wave @Kuroki2023bilayer @Gu2023pairing. Nevertheless, the large Coulomb interaction $U / t gt.double 1$ in La$""_3$Ni$""_2$O$""_7$~urgently calls for analysis from a strong coupling approach @Werner2023correlated @Cao2023flat @Wu2023charge. Precision many-body calculations are required to scrutinize the possible SC order in the effective model~@Shen2023effective. The tensor-network methods constitute a powerful and versatile approach for both ground-state~@White1992 @Schollwock2011MPS @Verstraete2004renorm @Cirac2021RMP @Corboz2010Simulation @Jordan2008Classical and finite-temperature properties @Li2011a @Chen2018XTRG @tanTRG2023 @Chen2021SLU @Chen2022tbg of correlated electrons. Unfortunately, the original bilayer two-orbital model poses great challenges to tensor-network calculations and a dimension reduction in local Hilbert space while retaining the essence of electron correlations in the nickelate is very necessary.


Lately it is proposed that by considering the orbital selective behaviors of localized $d_(z^2)$ and itinerant $d_(x^2 - y^2)$ electrons, together with the strong ferromagnetic (FM) Hund's rule coupling, a bilayer $t$-$J$-$J_perp$ model with strong antiferromagnetic (AF) interlayer exchange $J_perp$ may provide an adequate effective model for La$""_3$Ni$""_2$O$""_7$~@Lu2023interlayer. Here we perform high-precision ground-state and finite-temperature tensor-network calculations of this bilayer model, and reveal a robust SC order with high $T_c$ that may account for the observation in the pressurized nickelate La$""_3$Ni$""_2$O$""_7$.


#emph[Bilayer $t$-$J$-$J_perp$ model.—] As shown in @Fig1, we note the two $e_g$ orbitals in La$""_3$Ni$""_2$O$""_7$, namely, $d_(x^2 - y^2)$ and $d_(z^2)$, have distinct and orbital selective behaviors~@Zhang2023electronic. The $d_(z^2)$ orbital is almost localized with flat band structure promoted by the strong Hund's couplings~@Cao2023flat. Considering that $d_(z^2)$ orbital is only slightly doped (nearly half-filled)~@Werner2023correlated @Cao2023flat @Wu2023charge, we can freeze their charge fluctuations and regard the $d_(z^2)$ electrons as local moments~@Cao2023flat. The interlayer $sigma$ bonding through the apical oxygen @Nickelate80K renders a prominent interlayer AF coupling between the $d_(z^2)$ moments (also dubbed as the "hidden dimer"~@Zhang2023electronic). On the other hand, the $d_(x^2 - y^2)$ orbital is quarter-filled and adequately described by a $t$-$J$ model within each layer~@Yang2023s-wave @Gu2023pairing @Wu2023charge. The $d_(x^2 - y^2)$ orbital has negligible interlayer single-particle tunneling~@Luo2023bilayer @Zhang2023electronic. However, the strong FM Hund's coupling can bind the two $e_g$ orbitals and "passes" the strong interlayer AF coupling to the $d_(x^2 - y^2)$ orbital~@Lu2023interlayer, as illustrated in @Fig1\(a).


To see that, we start with the model $H = H_(t - J) + H_"AF" + H_"Hund" ,$ where $H_(t - J)$ is the intralayer $t$-$J$ model of $d_(x^2 - y^2)$ electrons, and $H_"AF"$ denotes the AF exchange $H_"AF" = J_perp sum_i bold(S)^d_(i,mu=1) dot.c bold(S)^d_(i,mu=-1)$ between the two layers. The index $mu = plus.minus 1$ labels the upper(lower) layer, and $bold(S)^d$ denotes the localized $d_(z^2)$ moment. $H_"Hund" = -J_"H" sum_(i,mu) bold(S)^c_(i,mu) dot.c bold(S)^d_(i,mu)$ is the on-site Hund's coupling, with $bold(S)^c$ the spin of $d_(x^2 - y^2)$ electron. To further simplify the two-orbital model, it is noted that the density functional theory calculations suggest $t tilde.eq 0.5$~eV ($d_(x^2 - y^2)$), $t_perp^z tilde.eq 0.64$~eV ($d_(z^2)$)~@Luo2023bilayer @Zhang2023electronic, placing the nickelate in the strong coupling regime by taking Hubbard $U tilde.eq 5$~eV (i.e., $U / t tilde 10$) @Cao2023flat @Werner2023correlated. As an intra-atomic exchange, the FM Hund's rule coupling is about $J_(upright(H)) tilde 1$~eV @Cao2023flat @Werner2023correlated, clearly greater than the spin exchanges $J tilde 4 t^2 / U tilde.eq 0.2$~eV and $J_perp tilde.eq 0.32$~eV, which is sufficiently strong to transfer the AF couplings between the two $e_g$ orbitals~@Qu2023Orb. It is therefore sensible to take the large $J_(upright(H))$ limit and symmetrize the spins $bold(S)^(d)_(i,mu)$ and $bold(S)^(c)_(i,mu)$ of the two orbitals. The AF interlayer coupling between $d_(z^2)$ moments can be effectively expressed as $bold(S)^(c)_(i,mu=1) dot.c bold(S)^c_(i,mu=-1)$ in the symmetrized spin-triplet space. With this, an effective single-band bilayer $t$-$J$-$J_perp$ model can be obtained~@Lu2023interlayer.

$
  H_"bilayer" & = & -t sum_(chevron.l i,j chevron.r, mu, sigma) (c^dagger_(i, mu, sigma) c_(j, mu, sigma) + H.c.) \
  & + & J sum_(chevron.l i,j chevron.r, mu) (bold(S)^c_(i,mu) dot.c bold(S)^c_(j,mu) - 1/4 n_(i,mu) n_(j,mu)) \
  & + & J_perp sum_(i) bold(S)^c_(i,mu=1) dot.c bold(S)^c_(i,mu=-1),
$ <eq:b-t-J>
where $sigma = { arrow.t \, arrow.b }$ is the spin orientation, and the vector operator $bold(S)^c_(i,mu) = 1/2 \, c^dagger_(i,mu,sigma) \, (bold(sigma)_(sigma,sigma')) \, c_(i,mu,sigma')$ denotes the spin of the itinerant $d_(x^2 - y^2)$ electron with the Pauli matrices $bold(sigma) = { sigma_x \, sigma_y \, sigma_z }$. Note the double occupancy is projected out in the $t$-$J$-$J_perp$ model as usual.


Below we consider the intralayer hopping $t = 3$ and spin exchange $J = 1$ (taken as energy scale henceforth), and the interlayer AF couplings $J_perp$ is varied to explore the SC and possibly competing change density wave (CDW) orders. Interlayer hopping $t_perp$ is forbidden \[except in @Fig3(c)\], different from the previously studied bilayer Hubbard-like models~@Scalapino2011bilayer. As the $d_(x^2 - y^2)$ orbitals are nearly quarter-filled, we set $n_e = 0.5$ and the hole density $n_h = 1 - n_e = 0.5$ in the pristine La$""_3$Ni$""_2$O$""_7$.


// [figvision] imgs/Fig2.png
// Panel (a) is a log-log plot of pairing correlation Φ^zz versus distance r, with r spanning 10^0 to roughly 30
// and Φ^zz from 10^-3 to 10^-1. Red squares denote W=1 with K_SC values 0.96 for J_perp=2 (filled) and 0.93 for
// J_perp=4 (open). Blue triangles show W=2, J_perp=2. Purple circles denote W=3 with K_SC 0.74 (filled,
// J_perp=2) and 0.52 (open, J_perp=4). Solid and dashed lines guide the eye. An algebraic decay with
// oscillations is visible, especially for the red series, while the blue and purple series show smoother
// power-law drops. A blue text annotation marks W=2, J_perp=2. Panel (b) is a semilog plot with linear distance
// r from roughly 2 to 22 on the horizontal axis and logarithmic magnitude from 10^-8 to 10^-2 on the vertical
// axis. It plots |G(r)| using squares and |F(r)| using circles. Red corresponds to W=1 and purple to W=3; filled
// symbols mark J_perp=2 and open symbols mark J
#figure(placement: top, image("imgs/Fig2.png", width: 100.0%),
  caption: [
    (a) Pairing correlation $Phi_(z z)$ on the $2 times W times L$ bilayer lattices with widths $1 lt.eq W lt.eq 3$ and long length $L$, namely, $2 times 1 times 128$ ($W = 1 , n_e = 0.5$), $2 times 2 times 64$ ($W = 2 , n_e approx 0.54$), and $2 times 3 times 48$ ($W = 3 , n_e = 0.5$). The SC correlations exhibit algebraic behaviors as $Phi_(z z) \( r \) tilde r^(- K_(upright("SC")))$, enhanced with interlayer coupling $J_perp$. The $W = 2$ data fall into algebraic scaling with oscillations~@SM, leading to inaccurate extraction of the Luttinger parameters. (b) Spin-spin correlation $F \( r \)$ and the single-particle Green's function $G \( r \)$ decay exponentially (see definitions in the main text) in the SC phase~@FN.
  ]
)
<Fig2>



#emph[Tensor-network methods for zero- and finite-temperature properties.—] To simulate the bilayer model in Eq. (#ref(<eq:b-t-J>)), we employ tensor-network approaches for both $T = 0$ and $T > 0$ calculations. Regarding the ground state, we exploit the density matrix renormalization group (DMRG)~@White1992 @Schollwock2011MPS for the finite-size systems and the infinite projected entangled-pair state (iPEPS) directly in the thermodynamic limit~@Verstraete2004renorm @Cirac2021RMP @Corboz2010Simulation @Jordan2008Classical. In DMRG we map the $2 times W times L$ bilayer system into a quasi-1D chain with long-range interactions~@SM, and implement the non-Abelian and Abelian symmetries with tensor libraries @Weichselbaum2012 @Weichselbaum2020 @ITensor @ITensor-r0.3. We retain up to $D^(*) = 12 thin 000$ U(1)$""_(upright("charge")) times$ SU(2)$""_(upright("spin"))$ multiplets (equivalently $D tilde.eq 30 thin 000$ individual states), which well converge the results~@SM. For iPEPS calculations, we adopt the simple update @Xiang2008SU @Li2012SU with retained bond dimension up to $D = 12$, which is extrapolated to infinite $D$ and compared to the DMRG results. Moreover, we exploit the finite-$T$ tensor networks, in particular the recently developed tangent-space tensor renormalization group~@tanTRG2023 to study the bilayer system with $W = 1$ and length up to $L = 128$. Up to $D^(*) = 1600$ U(1)$""_(upright("charge")) times$ SU(2)$""_(upright("spin"))$ multiplets (equivalently $D tilde.eq 3600$ states) render very well converged results down to a low temperature $T / J tilde.eq 0.1$~@SM.


#emph[Robust SC order and magnetically mediated interlayer pairing.—] In @Fig2 we show the DMRG results of pairing correlations $Phi_(z z) ( r ) = chevron.l Delta_i^dagger Delta_j chevron.r$ with interlayer pairing $Delta_i^dagger = 1 / sqrt(2) sum_(mu = plus.minus 1) thin c_(i , mu , arrow.t)^dagger c_(i , - mu , arrow.b)^dagger$ and distance $r equiv \| j - i \|$, where we find $Phi_(z z) ( r )$ shows algebraic scaling with the Luttinger exponent $K_"SC" lt.tilde 1$ for moderate to strong $J_perp$. In @Fig2\(b), we calculate the spin-spin correlation $F(r) = 1/2 sum_mu chevron.l bold(S)^c_(i,mu) dot.c bold(S)^c_(j,mu) chevron.r$ and the Green's function $G \( r \) = 1 / 4 sum_(mu \, sigma) chevron.l c_(i \, mu \, sigma)^dagger c_(j \, mu \, sigma) + upright(H . c .) chevron.r$, and find both correlations decay exponentially. The DMRG results in @Fig2 indicate the emergence of Luther-Emery liquid @Luther1974 with quasi-long-range SC order, as well as ﬁnite spin and single-particle gaps.


// [figvision] imgs/Fig3.png
// Panel (a) is a line plot with a shared horizontal axis labeled J_perpendicular spanning roughly 1 to 7, marked
// with ticks at 2, 4, and 6. The left vertical axis reads 2 minus K_SC from 1 to 1.6, while the right orange
// vertical axis reads E_b divided by J_perp from 0.6 at the bottom to 1 at the top. Three data series are drawn.
// Open upward triangles connected by a thin black line labeled W equals 1 remain near 1 and rise gently to about
// 1.1. Open squares connected by a thin black line labeled W equals 3 increase from roughly 1.25 to 1.6. Filled
// orange circles connected by an orange line labeled binding energy are read on the right axis, starting near
// 0.95, reaching a small maximum, then decreasing to 0.6 at the largest J_perp. Text annotations mark the two W
// values and the binding energy series, and small arrows indicate the respective axis directions. The trend
// shows that the K_SC-related quantity is nearly flat for W equals 1 but grows strongly with interchain coupling
// for W equals 3, whereas the binding energy falls monotonically as J_perp increases.
#figure(placement: top, image("imgs/Fig3.png", width: 100.0%),
  caption: [
    \(a) The Luttinger parameter $( 2 - K_"SC" )$ vs. $J_perp$ calculated on various bilayer systems. The binding energy for $W = 1$ system is also shown. (b) The SC order parameter $macron(Delta)_z$ obtained with iPEPS (dashed horizontal lines) and DMRG (solid lines) for $J_perp = 2 , 4$. In the latter, $macron(Delta)_z$ is estimated within central columns, and the error bars represent the difference between the maximal and minimal values by varying the number of columns involved. We set $n_e = 0.5$ for the $W = 1 , 3$ cases, while for the $W = 2$ case it is shifted slightly to $n_e tilde.eq 0.54$. (c) Pairing correlation $\| Phi_(z z) \|$ with various interlayer hopping $t_perp$. For the $t_perp = 0$ case, we show the pairing correlations in excellent data convergence as computed with $L_x = 64$ and 128. (d) The electron density profiles $n_e ( i ) , 1 lt.eq i lt.eq L$ for various $J_perp$ computed on the $2 times 1 times 64$ system.
  ]
)
<Fig3>



The AF exchange $J_perp$ plays an essential role in mediating the interlayer pairing and forming the rung-singlet SC phase @Wu2017DiagramQMC. In @Fig3\(a), we provide the DMRG results of the Luttinger parameter $K_"SC"$ controlling the scaling behaviors of pairing correlations. We find $( 2 - K_"SC" ) gt.tilde 1$ increases rapidly with $J_perp$ and signifies a diverging susceptibility at low temperature as $chi_"SC" tilde 1 / T^(( 2 - K_"SC" ))$. The pairing susceptibility $chi_"SC" = 2 / N partial chevron.l Delta_"tot" chevron.r_beta / partial h_p$ measures the response of SC order parameter to a small pairing field $h_p$ coupled to $Delta_"tot" = 1 / 2 sum_i ( Delta_i + Delta_i^dagger )$. To further characterize the enhancement of pairing strength, we compute the binding energy $E_b = E ( N_e + 1 ) + E ( N_e - 1 ) - 2 E ( N_e )$, where $E ( N_e )$ is the ground-state energy with $N_e$ electrons. In @Fig3\(a), we find $E_b$ increases with $J_perp$ as the ratio $E_b / J_perp gt.tilde 0.6$. However, $E_b / J_perp$ is not monotonic and has a round peak at $J_perp approx 1.5$. In the strong $J_perp$ limit the escalation of binding energy slows down its pace and the ratio converges to $E_b / J_perp tilde.eq 0.6$ .


With iPEPS calculations directly in the thermodynamic limit where symmetry breaking is allowed to occur, we evaluate the SC order parameter $macron(Delta)_z = chevron.l Delta_i^(( dagger )) chevron.r$ averaged over the two sublattices, and show the results in @Fig3\(b). We find $macron(Delta)_z$ increases with $J_perp$ and reaches about 0.11 for $J_perp = 2$ and 0.16 for $J_perp = 4$. In @Fig3\(b) we also show the DMRG estimation of the order parameter $macron(Delta)_z = sqrt(1 / N_b sum_(i , j) chevron.l Delta_i^dagger thin Delta_j chevron.r)$ where $i , j$ are restricted within $N_c$ central columns, and $N_b$ is number of the credited pairs. In practice, we vary $N_c$ from 8 to 16 for different lattice geometries, and find the DMRG and iPEPS results agree well. Notice that the order parameter $macron(Delta)_z$ of the bilayer $t$-$J$-$J_perp$ system \[$cal(O) ( 10^(- 1)$)\] is much greater than that found in the plain $t$-$J$ square lattice \[$cal(O) ( 10^(- 2)$)\]~@Corboz2014Competing.


The order parameter $macron(Delta)_z$ and pairing correlations are found to be uniform in each layer, i.e., it belongs to an $s$-wave SC order. We have also computed the intralayer pairings $Phi_(y y)$ and $Phi_(y x)$ with DMRG, and the order parameters $macron(Delta)_(x , y)$ with iPEPS~@SM, which are found to be negligibly small when compared to $Phi_(z z)$ (and $macron(Delta)_z$). Based on the results in @Fig2 and @Fig3, we conclude there exists a robust rung-singlet SC order mediated and enhanced by magnetic couplings $J_perp$ in the bilayer $t$-$J$-$J_perp$ model for La$""_3$Ni$""_2$O$""_7$.


#emph[Pauli blocking and charge density-wave instability.—] The existence of strong interlayer $J_perp$ while absence of hopping $t_perp$ is a key for the robust SC order to appear in the bilayer system. In @Fig3\(c) we artificially introduce the interlayer hopping $t_perp$, and find the SC order gets weakened and even suppressed as $t_perp$ increases. This can be ascribed to the Pauli blocking effect where the holes tend to repel each other kinetically according to their hopping amplitude @Hilker2023pairing, spoiling the interlayer pairing for strong $t_perp$. Moreover, this observation may also be relevant to the experiments: further increasing pressure in the SC phase of La$""_3$Ni$""_2$O$""_7$~does not enhance $T_c$ but decreases it~@Nickelate80K @Hou2023emergence @Zhang2023hightemperature. It is possible that high pressure enhances interlayer tunneling of the $d_(x^2 - y^2)$ orbitals and thus weakens the SC order.


In @Fig3\(d), we show the electron density distribution $n_e ( i )$ by tuning $J_perp$ to smaller values. For $J_perp = 2$, the CDW fluctuation is rather weak, consistent with a robust $s$-wave SC state. However, for smaller $J_perp$ the SC order becomes weakened, while the CDW instability turns strong. This may explain the absence of SC order in La$""_3$Ni$""_2$O$""_7$~under ambient pressure, where certain density-wave-like instability bas been observed in recent experiments~@Liu2023correlation @Hou2023emergence @Zhang2023hightemperature. The change of interlayer Ni-O-Ni bond angle \[from 168$""^compose$ (ambient) to 180$""^compose$ (pressurized)\] and length (by 1.9 Å) may sensitively influence $J_perp$, thus switching between the CDW and SC phases. Moreover, by reducing the hole density we find even clearer CDW pattern @SM, suggesting that the CDW instability or stripe phase may also be a competing order in the bilayer nickelate.


// [figvision] imgs/Fig4.png
// Panel (a) plots specific heat c_v against temperature T/J on a logarithmic horizontal axis spanning 10^-1 to
// roughly 2, with c_v ranging from 0 to 0.8. A solid red curve represents J_perp = 2, a solid green curve
// represents J_perp = 4, and an orange dashed curve shows the kinetic part for J_perp = 2. The red curve peaks
// near T/J ≈ 0.3 while the green curve peaks near T/J ≈ 0.8, with upward arrows labeling these lower
// characteristic temperatures T_l. Panel (b) shows pairing susceptibility chi_SC versus T/J from 10^-1 to above
// 10^0, with chi_SC from 0 to 3. Red circles mark J_perp = 2 with alpha ≈ 1.16 and green squares mark J_perp = 4
// with alpha ≈ 1.03, both decaying approximately as T^-alpha before dropping to zero. An inset schematic depicts
// a ladder pairing pattern with alternating triangles and circles. Labels T_c^*, T_l indicate crossover scales
// using triangles and downward arrows. Panel (c) plots the hole correlation g_h^(2) versus T/J from 10^-1 to
// about 2, ranging from 0 to 0.3. Green squares form the upper curve, remaining flat near 0.24 before dropping
// after T_l, while red circles form the lower curve decreasing from roughly 0.12. Green upward triangles and
// arrows mark T_c^* and T_l on the green curve, and corresponding red markers denote the same scales on the red
// curve. Panel (d) displays magnetic susceptibility chi_m versus T/J on a logarithmic axis from 10^-1 to beyond
// 10^0, with chi_m from 0 to 0.1. Red circles trace an upper curve
#figure(placement: top, image("imgs/Fig4.png", width: 100.0%),
  caption: [
    Finite-temperature results for $W = 1$ systems with length up to $L = 128$. In panels (a)-(e), the data for $J_perp = 2$ (red lines) and $4$ (green) are shown. In (a),(c)-(e) the hole density is fixed as $n_h equiv 1 - n_e = 0.5$, and in (b) the data are calculated with fine-tuned chemical potential that leads to $n_h tilde.eq 0.5$. (a) shows the specific heat $c_e$ with $T_l$ the lower characteristic temperature. (b) shows the pairing susceptibility $chi_"SC"$, which diverges with a power-law scaling $T^(- alpha)$ (the dashed lines) for $T lt.eq T_c^(*)$. The interlayer pairing and AF correlations are illustrated in the inset. (c) shows the interlayer hole correlations on the rungs, with $T_l$ and $T_c^(*)$ determined from (a) and (b), respectively. (d) shows the magnetic susceptibility $chi_m$ with a hump at $T_m$. (e) shows the rung spin correlations. (f) The contour plot of the pairing correlation $Phi_(z z) ( r = L / 4 )$ for various hole densities $n_h$ computed with $J_perp = 2$. The vertical red line denotes the $n_h = 0.5$ case relevant for La$""_3$Ni$""_2$O$""_7$~(LNO).
  ]
)
<Fig4>



#emph[Finite-temperature pairing and magnetic susceptibilities.—] In @Fig4 we show the temperature evolutions of spin and pairing correlations. Firstly, from @Fig4\(a) we find the electron specific heat $c_e = 1 / N_e frac(partial epsilon, partial T)$ exhibits a double-peak structure, with the higher-$T$ peak contributed by the kinetic energy, and lower-$T$ scale responsible for SC pairing labeled by $T_l$. In @Fig4\(b) we apply a uniform pairing field $- h_p Delta_"tot"$ with $h_p = 2 times 10^(- 3)$, and compute the pairing susceptibility. We find that $chi_"SC"$ is rather small for $T > T_l$ and becomes significant for $T < T_l$, making $T_l$ the SC-fluctuation onset temperature.


As temperature further lowers, we find $chi_"SC"$ exhibits an algebraic divergence $chi_"SC" tilde T^(- alpha)$ for temperature below $T_c^(*)$, when the system enters the low-temperature SC regime. The fitted exponent in @Fig4\(b) is $alpha tilde.eq 1$, consistent with the ground-state DMRG results of $K_"SC" tilde.eq 1$ for $W = 1$. Both $T_l$ and $T_c^(*)$ increase with $J_perp$, and in @Fig4\(a) we find $T_l / J tilde.eq 0.25$ for $J_perp = 2$, which is enhanced to $T_l / J tilde.eq 0.6$ for $J_perp = 4$. Similarly in @Fig4\(b) the $chi_"SC"$ curves show an overall enhancement, and the $T_c^(*) / J$ increases from $0.12$ for $J_perp = 2$ to about $0.25$ for $J_perp = 4$. In @Fig4\(c) we show the hole-hole correlation $g_h^(( 2 )) = ( 2 / N ) sum_i chevron.l h_(i , mu = 1) h_(i , mu = - 1) chevron.r_beta / ( chevron.l h_(i , mu = 1) chevron.r_beta dot.op chevron.l h_(i , mu = - 1) chevron.r_beta ) - 1$, where $N$ is the number of lattice sites with $h_(i , mu)$ the hole density operator. The positive $g_h^(( 2 ))$ indicates the attractive ("bunching") correlations between the holes. From @Fig4\(c), we find $g_h^(( 2 ))$ rapidly increases at about $T_l$ and saturates at about $T_c^(*)$ when the pairing susceptibility starts to diverge algebraically in @Fig4\(b).


To further reveal the intriguing interplay between antiferromagnetism and superconductivity in the bilayer system, we compute the magnetic susceptibility $chi_m$ and rung spin-spin correlation $F^((1)) = 2/N sum_i chevron.l bold(S)_(i, mu=1) dot.c bold(S)_(i, mu=-1) chevron.r_beta$ in @Fig4(d),(e). The magnetic susceptibility $chi_m$ becomes suppressed below $T_m$ in @Fig4(d), which can be ascribed to the rapid establishment of correlation $F^((1))$ at about the same temperature \[@Fig4(e)\].


#emph[Temperature evolution of the SC order.—] Now we summarize the temperature evolution of the pairing correlations in @Fig4(f), where the red line denotes La$""_3$Ni$""_2$O$""_7$~with hole density $n_h equiv 1 - n_e tilde.eq 0.5$. As temperature lowers, the interlayer AF correlation develops at about $T_m / J tilde.eq 0.48$, and then the hole bunching occurs at $T_l / J tilde.eq 0.25$, shortly after that the system enters the coherent regime below $T_c^(*) / J tilde.eq 0.12$, establishing eventually the quasi-long-range SC order.


As shown in @Fig4\(f), by doping electrons into the system (or via a self-doping from $d_(z^2)$ to the $d_(x^2 - y^2)$ orbitals), the SC order and its characteristic temperature can be further enhanced. For $J_perp = 2$, the optimal hole density appears at $n_h tilde 0.25$, to the electron-doping side of La$""_3$Ni$""_2$O$""_7$, as also evidenced by the enhanced pairing susceptibility and temperature scales $T_l$ and $T_c^(*)$~@SM.


#emph[Discussion and outlook.—] We exploit multiple tensor-network methods and reveal robust $s$-wave SC order in the bilayer $t$-$J$-$J_perp$ model for the recently discovered nickelate superconductor. In La$""_3$Ni$""_2$O$""_7$~the $d_(x^2 - y^2)$ orbital has a hole density of $n_h tilde.eq 0.5$ —a large value on the verge of quenching the SC in cuprates. For the latter, large hole doping may undermine the intralayer AF correlations and suppress the SC order. Surprisingly, in La$""_3$Ni$""_2$O$""_7$~ the SC order remains robust and has a high $T_c tilde.eq 80$~K even with large hole density. Based on our $t$-$J$-$J_perp$ model calculations, we ascribe it to the robust pairing mechanism mediated by strong interlayer AF exchange. In @Fig4\(f), we find indeed the SC dome can extend to a very wide regime up to $n_h tilde 0.6$ for the bilayer nickelate.


We would also point out an intriguing and rather unexpected connection between the high-$T_c$ nickelate and ultracold atom systems. Recently, the mixed dimensional (mixD) bilayer optical lattices with strong interlayer spin exchange while no interlayer single-particle tunneling has been realized~@Grusdt2022mixD @Hilker2023pairing. Remarkably, such a $t$-$J$-$J_perp$ mixD bilayer model naturally emerges in the orbital-selective nickelate La$""_3$Ni$""_2$O$""_7$: The $d_(x^2 - y^2)$ electrons are itinerant within each layer, while $d_(z^2)$ orbitals are nearly half-filled and localized. The FM Hund's coupling "glues" the spins of two $e_g$ orbitals, conveying to the $d_(x^2 - y^2)$ electrons a strong AF coupling— the driving force for the interlayer pairing. To thoroughly validate our effective model for La$""_3$Ni$""_2$O$""_7$, a detailed analysis of the two-orbital bilayer model with realistic parameters is necessary. Our preliminary results support the scenario proposed here~@Qu2023Orb.


Overall, our results provide a solid and valuable basis for understanding the unconventional SC in pressurized La$""_3$Ni$""_2$O$""_7$~from a strong coupling approach, and put various experimental observations in a coherent picture. They offer useful guidance for future studies in the nickelate superconductors and also mixD ultracold atom systems.


#block[
W.L. and F.Y. are indebted to Yang Qi and Qiaoyi Li for stimulating discussions. This work was supported by the National Natural Science Foundation of China (Grants No. 12222412, No. 11834014, No. 11974036, No. 12047503, No. 12074031, No. 12174317, and No. 12234016), Strategic Priority Research Program of CAS (Grant No.~XDB28000000), Innovation Program for Quantum Science and Technology (No. 2021ZD0301800 and No. 2021ZD0301900), the New Cornerstone Science Foundation, and CAS Project for Young Scientists in Basic Research (Grant No.~YSBR-057). We thank the HPC-ITP for the technical support and generous allocation of CPU time.

]





#block[
]

#pagebreak()
Supplemental Materials for $thin$ \
#strong[Bilayer $t$-$J$-$J_perp$ Model and Magnetically Mediated Pairing in the Pressurized Nickelate La$""_3$Ni$""_2$O$""_7$] \


Qu #emph[et al].


d





c


e


n


t


e


r












= ZERO AND FINITE-TEMPERATURE SIMULATION METHODS
<zero-and-finite-temperature-simulation-methods>
In this work, we employ the density matrix renormalization group (DMRG) and infinite projected entangled-pair state (iPEPS) for the ground state, as well as the tangent-space tensor renormalization group ($tan$TRG) for finite-temperature properties of the bilayer $t$-$J$-$J_perp$ model.


== DMRG Calculations
<dmrg-calculations>
In the DMRG calculations, two different tensor-network libraries have been employed. We exploit QSpace library~@Weichselbaum2012 @Weichselbaum2020 to implement $upright(U ( 1 ))_"charge" times thin upright(S U ( 2 ))_"spin"$ symmetry in our DMRG code. ITensors library~@ITensor @ITensor-r0.3 is also utilized to perform a $upright(U ( 1 ))_"charge" times upright(U ( 1 ))_"spin"$ DMRG as a double check. For example, in the $2 times 1 times 128$ systems we keep up to 2000 U(1)$""_"charge"$ $times$ SU(2)$""_"spin"$ multiplets, which ensures a small truncation error $lt.tilde 10^(- 11)$. In the $2 times 3 times 48$ systems we keep up to 12 000 U(1)$""_"charge"$ $times$ SU(2)$""_"spin"$ multiplets with typical truncation error $tilde 5 times 10^(- 6)$. In the calculations, $D$ represents the number of U(1)$""_"charge"$ $times$ U(1)$""_"spin"$ states and $D^(*)$ for the U(1)$""_"charge"$ $times$ SU(2)$""_"spin"$ multiplets.


// [figvision] imgs/figS1.png
// I don't see a figure image attached to your message. The caption appears to be cut off after "\(a". Could you
// please provide the figure image (or a detailed description of its visual contents) and the full caption? Once
// I have the image, I will annotate it panel by panel following your exact formatting requirements: plot type,
// axes with ranges and units, each series or colour and its meaning, symbols, line styles, annotations, labels,
// and the trend or message for every panel.
#figure(placement: top, image("imgs/figS1.png", width: 100.0%),
  caption: [
    \(a) Illustration of the zigzag path used in DMRG calculation, and the model parameters are chosen as $J_perp = 2$, $J = 1$, and $t = 3$. The DMRG results on the $t$-$J$-$J_perp$ model on the $2 times W times L_x$ lattices with longer $L_x$ are shown in (b-g). The (b,c,d) panels show the pairing correlations $Phi_(z z) ( r ) = chevron.l Delta_i^dagger Delta_j chevron.r$ and (e,f,g) show the charge correlations $D ( r ) = chevron.l n_i n_j chevron.r - chevron.l n_i chevron.r chevron.l n_j chevron.r$, with $r equiv \| i - j \|$. We show $W = 1 , 2 , 3$ systems with relatively long $L_x$ up to 128. As a comparison, the results with shorter length $L_x$ are displayed with grey lines and cross markers. Note that for $W = 1 , 3$ cases, the Luttinger parameters $K_"SC"$ and $K_"CDW"$ can be accurately extracted. On the other hand, though the $W = 2$ data fall into algebraic decay, they are highly oscillating and lead to inaccurate extractions of the Luttinger parameters.
  ]
)
<FigS1>



// [figvision] imgs/figS8.png
// Panel (a) is a log-log plot of the pairing correlation |Φzz| versus distance r. The vertical axis spans 10^-3
// to 10^-1 and the horizontal axis runs from 10^0 past 10^1. For J_perp=6, blue filled squares denote D*=2000
// and blue open squares denote 1500, annotated with K_SC=0.90. For J_perp=4, red filled circles denote 2000 and
// red open circles denote 1500, annotated with K_SC=0.93. Dashed lines indicate power-law decays. The label W=1,
// Lx=128 appears at the bottom. All series decrease monotonically with r, and the J_perp=6 data remain slightly
// above the J_perp=4 data at intermediate distances. Panel (b) shows a log-log plot of |Φzz| versus r. The
// y-axis ranges from 10^-2 to 10^-1 and the x-axis extends from 10^0 to about 30. For J_perp=6, orange filled
// squares mark D*=9000 and orange open squares mark 6000, with K_SC=0.40. For J_perp=4, purple filled circles
// mark 12000 and purple open circles mark 9000, with K_SC=0.52. The text W=3, Lx=48 is printed at the bottom.
// The orange series decays more slowly than the purple series and stays higher throughout, while both
// approximately follow straight power-law trends on the log-log scale. Panel (c) is a log-log plot of |Φzz|
// versus r for W=2, Lx=64 and filling n_e≈0.54. The y-axis runs from 10^-2 to above 10^-
#figure(placement: top, image("imgs/figS8.png", width: 90.0%),
  caption: [
    DMRG results of the $W = 1 , 2 , 3$ system with two different interlayer couplings $J_perp = 4 , 6$. (a, d) pairing correlation and charge correlation for the $W = 1 , n_e = 0.5$ system, (b, e) for $W = 3 , n_e = 0.5$ system and (c, f) for $W = 2 , n_e approx 0.54$ system.
  ]
)
<FigS2>



#emph[Data convergence.—] In #ref(<FigS1>, supplement: [Fig.]) we compare the results obtained in different system sizes and bond dimensions to confirm the convergence of our ground-state simulations. The pairing and charge correlations are presented in #ref(<FigS1>, supplement: [Fig.]) for $J_perp = 2$ and in #ref(<FigS2>, supplement: [Fig.]) for $J_perp = 4 , 6$ systems. For the $W = 1$ case \[#ref(<FigS1>, supplement: [Fig.])\(b,e) and #ref(<FigS2>, supplement: [Fig.])\(a, d)\], we find the data are fully converged by retaining $D^(*) = 2000$ (equivalently $D approx 4400$ individual states), from which we can extract the Luttinger parameters $K_"SC"$ and $K_"CDW"$ accurately. For the $W = 3$ case shown in #ref(<FigS1>, supplement: [Fig.])\(c,f), we retain up to 12 000 bond multiplets, and find that the correlations are converged for short distances. For longer distances, we perform a fitting with polynomial function $C ( 1 / D^(*) ) = C ( 0 ) + a / D^(*) + b / D^(*)^2$ and extrapolate the data to infinite $D^(*)$. With this we obtain an accurate estimation of $K_"SC"$ and $K_"CDW"$ indicated in #ref(<FigS1>, supplement: [Fig.])\(c,f). Since the DMRG simulations converge faster on $J_perp = 4 , 6$ systems, we did not extrapolate the data and rely on the well converged segment to extract the Luttinger parameters.


#emph[$W = 2$ case.—] The results of $W = 2$ case are shown in Figs.~#ref(<FigS1>, supplement: none)\(d,g) (for $J_perp = 2$) and #ref(<FigS2>, supplement: none)\(c,f) (for $J_perp = 4 , 6$). Firstly, we point out that there has a subtlety at exact quarter-filling (i.e., $n_e = 0.5$). The pair correlations computed on the $L_x = 32$ system turn out to decay exponentially when extending the calculations to longer systems \[grey lines in #ref(<FigS1>, supplement: [Fig.])\(d,g)\]. An explanation for this phenomenon could be that the system is being viewed as two coupled $t$-$J$ ladders with a finite charge gap at quarter filling, as reported in Ref.~@Lu2022tJ. Therefore, we fine tune the electron density to $n_e tilde.eq 0.51$-$0.56$ for the $W = 2$ case in Figs.~#ref(<FigS1>, supplement: none)\(d,g) and #ref(<FigS2>, supplement: none)\(c,f), in order to avoid the peculiar filling $n_e = 0.5$ for the $W = 2$ geometry. In Figs.~#ref(<FigS1>, supplement: none)\(d) and #ref(<FigS2>, supplement: none)\(c), we now observe robust superconductivity for the $W = 2$ case. It is worth noting that the chosen $n_e gt.tilde 0.5$ is actually more closely related to the realistic electron density in the $d_(x^2 - y^2)$ orbital due to the self-doping @Werner2023correlated @Lu2023interlayer, and it also leads to more consistent results for different widths $W$ \[as can be seen in Fig.~3(b) in the main text\].


#emph[CDW correlations.—] In #ref(<FigS1>, supplement: [Fig.])\(e,f,g) and #ref(<FigS2>, supplement: [Fig.])\(d,e,f) we also show results of the charge correlations. For the $W = 1$ case ($J_perp = 2$), we find in #ref(<FigS1>, supplement: [Fig.])\(e) that the density correlation $D ( r ) = chevron.l n ( i ) n ( i + r ) chevron.r - chevron.l n ( i ) chevron.r chevron.l n ( i + r ) chevron.r$ exhibits a power-law scaling with Luttinger parameter $K_"CDW" tilde.eq 1.13$. Moreover, we find the product of two Luttinger parameters $K_"SC" thin K_"CDW" = 1.08 approx 1$, which fulfills the expectation of the LE theory. Likewise, the $W = 1 , J_perp = 4 , 6$ cases shown in #ref(<FigS2>, supplement: [Fig.])\(a, d) also meet $K_"SC" thin K_"CDW" approx 1$. However, for wider systems, such as the $W = 3 , J_perp = 2$ case shown in #ref(<FigS1>, supplement: [Fig.])\(f) and $W = 3 , J_perp = 4 , 6$ case in #ref(<FigS2>, supplement: [Fig.])\(e) , we find that the extracted $K_"CDW"$ is much larger than the SC parameter $K_"SC"$. This indicates a uniform SC order with relatively weak CDW correlations in wider systems, suggestive of a robust SC order in the 2D limit. Regarding the $W = 2$ case, either for $J_perp = 2$ \[#ref(<FigS1>, supplement: [Fig.])\(g)\] or $J_perp = 4 , 6$ \[#ref(<FigS2>, supplement: [Fig.])\(f)\], we see strong oscillations and quite difficult to extract the Luttinger exponent $K_"CDW"$ there.


// [figvision] imgs/figS2.png
// Panel (a) displays a schematic lattice diagram consisting of blue circular nodes and black diamond nodes
// connected by solid black line segments. Along the bottom, nine vertical positions are labeled i1 through i9
// from left to right. The structure has an upper row of blue nodes connected vertically and diagonally to a
// lower layer containing alternating blue and black nodes. Small text labels D and d appear near central
// connections, likely denoting bond dimensions or parameters. The geometry resembles a finite segment of a
// tensor network or spin lattice used in numerical simulations. Panel (b) shows a scatter plot with horizontal
// axis 1/D ranging from 0.00 to 0.15 and vertical axis epsilon_g/t ranging from -1.100 to -0.900. Six data
// series are shown: red open squares, green open diamonds, and blue open circles represent J_perp=2 for D=8, 10,
// 12, while red filled squares, green filled diamonds, and blue filled circles represent J_perp=4 for the same D
// values. Two dashed black lines indicate linear fits for the respective open and filled marker groups. An inset
// in the lower right corner plots data against 1/chi from 0.00 to 0.02, displaying green and red open and filled
// markers clustered between -0.95 and -0.90. The overall trend shows decreasing energy as 1/D increases.
#figure(placement: top, image("imgs/figS2.png", width: 80.0%),
  caption: [
    \(a) Illustration of fermionic iPEPS ansatz used in our calculations, where the local tensors (blue solid circles) and the swap gates (black diamonds) taking care of the fermion sign are indicated. $D$ and $d$ represent the bond dimensions of the geometric and physical indices. (b) Energy per site $epsilon_(upright(g)) / t$ obtained by iPEPS as a function of the inverse bond dimension $1 / D$, the environment bond dimension is chosen as $chi = D^2$. The inset shows the convergence of $epsilon_(upright(g)) / t$ as a function of $1 / chi$ for various bond dimension $D$. Other model parameters are $J = 1$ and $t = 3$.
  ]
)
<iPEPS_Eg>



== iPEPS method
<ipeps-method>
To simulate the $t$-$J$-$J_perp$ model directly in the thermodynamic limit, we flatten the bilayer system into a single layer system with enlarged local Hilbert space and use the fermionic iPEPS method @Corboz2010Simulation @Corboz2009Fermionic @Barthel2009Contraction @Kraus2010Fermionic. The wavefunction ansatz is illustrated in #ref(<iPEPS_Eg>, supplement: [Fig.])\(a), with a $2 times 2$ unit cell consisting of two bulk tensors (see inset of #ref(<iPEPS_Delta>, supplement: [Fig.]) below). Each bulk tensor has four virtual bonds whose dimension $D$ can control the simulation accuracy (up to $D = 12$ in practice). It also has a physical bond representing $d = 9$ local electron configurations on the flattened single-layer system. We optimize the iPEPS wavefunction using simple update~@Xiang2008SU @Li2012SU @Corboz2010Simulation and the expectation values are calculated using corner transfer matrix renormalization group method~@Corboz2014Competing @Orus2009Simulation with environment bond dimension $chi = D^2$ that leads to converged results as shown in the inset of #ref(<iPEPS_Eg>, supplement: [Fig.])\(b). It also shows that the energy per site $epsilon_(upright(g)) / t$ approaches infinite-$D$ limit linearly with $1 / D$ for both $J_perp = 2$ and $J_perp = 4$ cases.


// [figvision] imgs/figS3.png
// Panel (a) displays a schematic of a finite ladder lattice with five repeating cells. Blue circular nodes mark
// the sites, each carrying a small black diagonal hatch. Grey horizontal cylinders form the upper and lower
// rails, while yellow vertical cylinders serve as rungs connecting top and bottom nodes at each column. Black
// diagonal bonds run from each bottom node upward to the top node of the next column to the right. The
// parameters d and D are labeled near the leftmost sites. The drawing illustrates a periodic strip geometry with
// vertical rungs and slanted interchain links. Panel (b) shows a line plot of c_v versus T/J with a logarithmic
// x-axis from 10^-1 to 10^1 and a linear y-axis from 0 to 0.8. A solid blue curve denotes L = 32, D* = 1000,
// while a dashed orange curve denotes L = 64, D* = 1600. The two traces nearly coincide, exhibiting two broad
// peaks near T/J approximately 0.3 and T/J approximately 2, separated by a valley around T/J approximately 0.8
// where c_v approximately 0.4. Text inside the panel reads J_perp = 2, n_e = 1/2.
#figure(placement: top, image("imgs/figS3.png", width: 75.0%),
  caption: [
    \(a) In $tan$TRG calculations, we map the $2 times 1 times L$ system to a quasi-1D one along the zigzag path. The thermal density operator is represented as an MPO, which consists of rank-4 tensors with two geometric indices with bond dimension $D$ and two physical indices with bond dimension $d = 3$. (b) Electron specific heat $c_e$ for the $2 times 1 times L$ systems with $J_perp = 2$ and electron density $n_e = 1 / 2$. Results computed with different system sizes and bond dimensions are compared, i.e., $L = 32$ and $D^(*) = 1000$ (multiples, equivalent $D tilde.eq 2200$ individual states) vs $L = 64$ and $D^(*) = 1600$ ($D tilde.eq 3600$). We find they agree with each other, showing very good convergence over the system sizes and bond dimensions.
  ]
)
<FigS:Convergence>



== $tan$TRG method
<tantrg-method>
To simulate the finite-temperature properties of the bilayer systems, we use the tangent-space tensor renormalization group ($tan$TRG) approach~@tanTRG2023, which is a state-of-the-art finite-$T$ approach for many-electron problems. In this approach, the system is mapped to quasi-one-dimensional geometry, and the thermal density operator is represented as a matrix product operator (MPO), as shown in #ref(<FigS:Convergence>, supplement: [Fig.])\(a). In practical calculations, the Abelian and non-Abelian symmetries are implemented with the QSpace library~@Weichselbaum2012 @Weichselbaum2020. To compute the specific heat, magnetic susceptibility, and various electron correlations, we implement $upright(U ( 1 ))_"charge" times upright(S U ( 2 ))_"spin"$ symmetry and keep up to $D^(*) = 1600$ multiplets on systems up to $L = 64$. To compute the pairing susceptibility $chi_"SC"$, we have added a small pairing field, which breaks the particle number conservation. Therefore, we use $bb(Z)_(2 , "charge") times upright(S U ( 2 ))_"spin"$ symmetry and retain up to $D^(*) = 1000$ multiplets, on long system up to $L = 128$. As the grand canonical ensemble is used in our thermal tensor network simulations, a chemical potential term $- mu sum_i n_i$ is added to fine tune the electron density $n_e$.


To check the convergence of our thermal data, in #ref(<FigS:Convergence>, supplement: [Fig.])\(b) we show the electron specific heat $c_e$ results for the $2 times 1 times L$ system with $J_perp = 2$ and electron density $n_e = 1 / 2$, computed on two different system sizes and bond dimensions: $L = 32$ with $D^(*) = 1000$, and $L = 64$ with $D^(*) = 1600$. We find the $c_e$ changes little for the two cases and see a very good convergence of the thermal data.


// [figvision] imgs/figS4.png
// Panel (a) is a schematic diagram showing a right-handed coordinate system with x to the right, y upward, and z
// marked by a circle with a dot at the origin. Beside it is a square lattice of open circular nodes joined by
// black bonds. Light blue ovals highlight two vertical nearest-neighbor pairs in the upper lattice, labeled Φ_yy
// in blue. Light orange ovals highlight horizontal nearest-neighbor pairs in the lower lattice, labeled Φ_yx in
// orange. The figure illustrates the spatial structure of intralayer pairing correlations. Panel (b) is a
// semilog plot of correlation magnitude versus separation r. The x-axis runs to 15 with labeled ticks at 5, 10,
// and 15; the y-axis is logarithmic with a labeled tick at 10^-5. Four series use open circles: dark red for
// |Φ_yy| at W=2, dark blue for |Φ_yx| at W=2, orange for |Φ_yy| at W=3, and light blue for |Φ_yx| at W=3. All
// decay with r. A gray dashed reference line labeled ξ = 1.42 follows the dark red curve, the slowest decay. The
// annotation J_perp = 4 appears in the lower left.
#figure(image("imgs/figS4.png", width: 60.0%),
  caption: [
    (a) Schematic of the intralayer pairing correlations $\| Phi_(y y) \|$ and $\| Phi_(y x) \|$. (b) Intralayer pairing correlations calculated in $2 times 2 times 32$ and $2 times 3 times 24$ systems, from which we can estimate the correlation length $xi tilde.eq 1.42$ for $\| Phi_(y y) \|$ on $W = 2$ lattice. Other lines have similar or even shorter correlation lengths.
  ]
)
<DMRG_interlayer>



= MORE NUMERICAL SIMULATION RESULTS
<more-numerical-simulation-results>
Below we provide supplemental results obtained with DMRG ($T = 0$, finite system), iPEPS ($T = 0$, thermodynamic limit), and the $tan$TRG ($T > 0$) calculations.


== DMRG results
<dmrg-results>
We show in #ref(<DMRG_interlayer>, supplement: [Fig.]) the intralayer pairing correlation $Phi_(y y)$ and $Phi_(y x)$ on the $2 times 2 times 32$ and $2 times 3 times 24$ systems. The exponentially decaying pairing correlations indicate the absence of intralayer pairing.


In #ref(<DMRG_CDen>, supplement: [Fig.])\(a) we find the pairing correlation $Phi_(z z)$ decreases as interlayer AF coupling $J_perp$ weakens. The rung-single SC order becomes very weak for $J_perp = 0.1$, supporting our conclusion that the interlayer pairing in the system is mediated by the interlayer AF couplings. In #ref(<DMRG_CDen>, supplement: [Fig.])\(b) we find the charge density wave (CDW) becomes stronger as the hole density $n_h$ decreases, which is stabilized and even constitutes a long-range pattern for $n_h = 1 / 16$.


// [figvision] imgs/figS5.png
// Panel (a) is a log-log line plot of _{zz} versus r for W=1. The horizontal axis spans r from 10^{0} to beyond
// 10^{1}, and the vertical axis spans _{zz} from below 10^{-4} to above 10^{-2}. Three square-marked curves
// correspond to J_=0.1 in blue, 0.5 in orange, and 2 in yellow, as shown in the legend. All three decrease with
// increasing r, with larger J_ yielding larger _{zz}. The blue curve drops steeply near r10 to values near
// 10^{-5} and fluctuates sharply at large r, while the orange and yellow curves remain higher and noisier
// throughout. Panel (b) plots n_e(i)-n_0 versus site index i for W=1. The horizontal axis runs from 0 to 60, and
// the vertical axis ranges from -0.02 to 0.06. Two series are shown: blue circles for n_h=1/16 and orange
// diamonds for n_h=1/2. The blue curve starts near 0.06 at i=0, drops to about -0.03, and exhibits strong
// oscillations that decay toward the center before rising again near i=60. The orange curve begins near -0.02,
// quickly settles around zero with small fluctuations across the bulk, and drops again at the right boundary.
// Thus density deviations are strongly localized at the edges for the blue series but remain small for the
// orange series.
#figure(image("imgs/figS5.png", width: 65.0%),
  caption: [
    \(a) The pairing correlations $Phi_(z z)$ are shown for different $J_perp = 0.1 , 0.5$ and $2$. (b) The CDW profiles for different hole densities $n_h = 1 / 2$ and $1 / 16$.
  ]
)
<DMRG_CDen>



// [figvision] imgs/figS6.png
// The single panel plots Δ̄ versus 1/D, with the x-axis ranging from 0.00 to 0.15 and the y-axis from 0.00 to
// roughly 0.22. Red filled squares denote J⊥ = 2, Δ̄_z and increase from about 0.11 at 1/D = 0.025 to about 0.19
// at 1/D = 0.135 along a red dashed fit line. Blue filled diamonds denote J⊥ = 4, Δ̄_z and increase from about
// 0.195 at 1/D = 0.085 to about 0.215 at 1/D = 0.135 along a blue dashed fit line. Open red squares and open
// blue diamonds denote intralayer Δ̄_x + Δ̄_y and lie on y = 0 at 1/D ≈ 0.085, 0.105, and 0.135, marked by a
// black dashed zero line. The inset schematic shows four circular tensors—two orange labeled A and two blue
// labeled B—arranged diagonally, each with one downward physical bond and four crossing virtual bonds.
#figure(image("imgs/figS6.png", width: 45.0%),
  caption: [
    The rung-singlet SC order parameters obtained by iPEPS are shown as a function of inverse $D$. $macron(Delta)_z$ represents the interlayer pairing along the $hat(z)$ direction, while $macron(Delta)_x$ and $macron(Delta)_y$ represent the intralayer pairing along the $hat(x)$ and $hat(y)$ directions, respectively. The inset is an illustration of the unit cell of the iPEPS ansatz with two bulk tensors: A and B. Each bulk tensor has one physical bond and four virtual bonds. The $macron(Delta)_z$ values are computed and averaged over two bulk tensors, and then extrapolated to infinite $D$ limit. $macron(Delta)_z$ has a finite and rather large value, while $\| macron(Delta)_(x ( y )) \|$ values are negligibly small.
  ]
)
<iPEPS_Delta>



== iPEPS results
<ipeps-results>
We show in #ref(<iPEPS_Delta>, supplement: [Fig.]) the SC order parameter $macron(Delta)$ obtained by the iPEPS method in the infinite systems with different $J_perp$. The amplitudes of $macron(Delta)_z = 1 / sqrt(2) chevron.l sum_(mu = plus.minus 1) thin c_(i , mu , arrow.t)^dagger c_(i , - mu , arrow.b)^dagger chevron.r$ for both $J_perp = 2$ and $J_perp = 4$ decrease with increasing bond dimensions $D$, while still have very large values when extrapolated to the infinite-$D$ limit. It indicates that the interlayer pairing persists in this limit. On the other hand, we do not find intralayer pairing as the amplitudes of $macron(Delta)_x$ and $macron(Delta)_y$ are negligible for both $J_perp$ values, where $macron(Delta)_(x ( y )) = 1 / sqrt(2) sum_(sigma = ( arrow.t , arrow.b )) chevron.l "sgn" ( sigma ) thin c_(i , mu = plus.minus 1 , sigma)^dagger c_(i + hat(x) ( hat(y) ) , mu = plus.minus 1 , macron(sigma))^dagger chevron.r$, with $"sgn" ( arrow.t ) = 1$, $"sgn" ( arrow.b ) = - 1$, and $hat(x)$\($hat(y)$) unit vector in the square-lattice plane. $macron(sigma)$ reverses the spin orientation of $sigma$. In #ref(<iPEPS_Delta>, supplement: [Fig.]) we find that $macron(Delta)_z$ is enhanced by increasing $J_perp$ from $2$ to $4$. The iPEPS results also support the conclusion that a larger $J_perp$ strengthens the interlayer pairing.


== $tan$TRG results
<tantrg-results>
In Fig.~4 of the main text, we have shown the $c_e$ and $chi_m$ for $J_perp = 2$ with hole density $n_h = 1 / 2$. Here in #ref(<FigS:Ce>, supplement: [Fig.])\(a) we show the $c_e$ and $chi_m$ results for the same $J_perp = 2$ but with smaller hole density $n_h = 1 / 4$. Now the low-temperature peak of $c_e$ is found to be located at $T_l / J tilde.eq 0.38$, and the hump of $chi_m$ is at $T_m / J tilde.eq 0.75$. Both temperature scales are higher than the corresponding values in the quarter filling ($n_h = n_e = 1 / 2$) case shown in Fig.~4 of the main text.


In #ref(<FigS:Ce>, supplement: [Fig.])\(b) we show the pairing susceptibility $chi_"SC"$ for $J_perp = 2$ and hole density $n_h = 1 / 4$, and compare it to the $n_h = 1 / 2$ case. We find there is an overall enhancement in $chi_"SC"$ when $n_h$ is lowered from $1 / 2$ to $1 / 4$. Moreover, the characteristic temperature scale $T_c^(*)$ for superconductivity increases from $T_c^(*) / J tilde.eq 0.12$ to $0.16$. Therefore, compared with quarter filling case with $n_h = 1 / 2$ (pristine La$""_3$Ni$""_2$O$""_7$), the superconductivity is enhanced by lowering hole density ($n_h = 1 / 4$).


// [figvision] imgs/figS7.png
// Panel (a) is a composite line plot with x-axis T/J logarithmic from 10^-1 to 10^1, left y-axis c_V from 0 to
// 0.8 with blue arrow, and right y-axis wχ from 0 to 0.1 with green arrow. A blue solid curve represents c_V,
// rising sharply to a peak near 0.65 at T_l around 0.3 then falling. A green line with open circles represents
// wχ, rising to a peak near 0.09 at T_m around 0.7 then declining to about 0.02 at T/J=10. Blue arrow marks T_l
// near the blue peak, green arrow marks T_m near the green peak, and side arrows indicate directions. Text
// inside reads J_perp = 2 and n_h = 1/4. Panel (b) is a log-log plot with x-axis T/J from 10^-1 to 10^0 and
// y-axis chi_QSC from 10^-1 upward. Blue open circles connected by solid line show n_h ≈ 1/4 with alpha ≈ 1.11,
// orange open circles show n_h ≈ 1/2 with alpha ≈ 1.16, and a dashed black curve indicates scaling ~T^-alpha.
// Blue downward arrow labels T_c^* on the upper blue series, orange upward arrow labels T_c^* on the orange
// series, and a blue arrow marks T_l on the descending blue branch. Text J_perp = 2 appears at lower left.
#figure(placement: top, image("imgs/figS7.png", width: 85.0%),
  caption: [
    \(a) Specific heat $c_e$ and magnetic susceptibility $chi_m$ for the $2 times 1 times 32$ system with $J_perp = 2$ and hole density $n_h = 1 / 4$. The blue upward arrow indicates the lower temperature scale in $c_e$. The green upward arrow indicates the peak temperature of $chi_m$. (b) Pairing susceptibility for the $2 times 1 times 128$ system with $J_perp = 2$ and $n_h = 1 / 4$, $1 / 2$. The $n_h = 1 / 2$ data is exactly the same one as in Fig.~4(b) of the main text, taken here as a comparison. The dashed lines denote the power-law fitting $T^(- alpha)$. The corresponding temperature scales $T_c^(*)$ and $T_l$ are indicated.
  ]
)
<FigS:Ce>

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", title: none)