#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.75cm, top: 1.92cm, bottom: 2.14cm), columns: 2)
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
#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)

#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Magic in twisted transition metal dichalcogenide bilayers])   #v(1.2em)
    #text(10.5pt)[Trithep Devakul#super[1\*#sym.dagger], Valentin Crépel#super[1], Yang Zhang#super[1#sym.dagger], Liang Fu#super[1\*]]
  
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] ^1 Department of Physics, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, USA] \
  ]
  #v(1.2em)

  #align(left)[#text(8pt)[$""^dagger$ These authors contributed equally: Trithep Devakul, Yang Zhang.]]

  #align(left)[#text(8pt)[$""^convolve$ Correspondence should be addressed to Trithep Devakul (email:tdevakul\@mit.edu) or Liang Fu (email:liangfu\@mit.edu).]]

  The long wavelength moiré superlattices in twisted 2D structures have emerged as a highly tunable platform for strongly correlated electron physics. We study the moiré bands in twisted transition metal dichalcogenide homobilayers, focusing on WSe$""_2$, at small twist angles using a combination of first principles density functional theory, continuum modeling, and Hartree-Fock approximation. We reveal the rich physics at small twist angles $theta < 4^compose$, and identify a particular magic angle at which the top valence moiré band achieves almost perfect flatness. In the vicinity of this magic angle, we predict the realization of a generalized Kane-Mele model with a topological flat band, interaction-driven Haldane insulator, and Mott insulators at the filling of one hole per moiré unit cell. The combination of flat dispersion and uniformity of Berry curvature near the magic angle holds promise for realizing fractional quantum anomalous Hall effect at fractional filling. We also identify twist angles favorable for quantum spin Hall insulators and interaction-induced quantum anomalous Hall insulators at other integer fillings.
]

= INTRODUCTION
<introduction>
In condensed matter physics, simple and elegant models have often brought new ideas and started new paradigms. Celebrated examples include the Hubbard model for strongly correlated electron system~@Hubbard, the Tomonaga-Luttinger model for one-dimensional electron liquid~@Tomonaga @Luttinger, and the Kitaev model for non-Abelian quantum spin liquid~@Kitaev, to name a few. As toy models are designed to illustrate key concepts in the simplest form, they are rarely realized directly in real materials, whose atomic-scale electronic structures are inevitably more complex. The recent advent of long-wavelength moiré superlattices based on 2D van der Waals structures provides a new and promising venue for physical realization and quantum simulation of model Hamiltonians. In magic-angle twisted bilayer graphene~@Bistritzer2011 (TBG), experiments have discovered a variety of correlated electron states~@Cao2018 @Cao2018a @Yankowitz2019 @Lu2019 @Cao2020 @Sharpe2019 @Serlin2020 facilitated by flat moiré bands.

More recently, moiré superlattices of semiconducting transition metal dichalcogenides (TMD) have attracted interest as a potentially simpler and more robust platform for simulating the Hubbard model on an emergent lattice ~@Wu2018 @Wu2019 @Tang2020 @Regan2020 @Shabani2021 @Jin2021 @Zhang2020 @Zhang2021 @Slagle2020 @Xu2020 @Bi2021 @Pan2020 @MoralesDuran2020 @Zang2021 @padhi2021generalized @zhai2020theory @Cazalilla2014 @Zhang2020flat @magorrian2021multifaceted @tang2021geometric. Each lattice site represents a low-energy electronic orbital in the moiré unit cell that spreads over many atoms. These semiconductor moiré systems can thus be viewed as artificial 2D solids---a periodic array of "magnified atoms" @Zhang2020. The atomic potential depth and interatomic bonding are highly tunable by the choice of TMD materials, the twist angle @Wu2018 and the displacement field @Bi2021 @Zhang2021. Thus, TMD based moiré materials provide a favorable platform for simulating idealized models in two dimensions.

In this work, we predict the realization of generalized Kane-Mele models with topological flat band, interaction-driven Haldane insulator and Mott insulators in twisted TMD homobilayers at small twist angles. Contrary to current thoughts, we show by band structure calculation and analytical derivation that a magic twist angle exists in twisted TMD homobilayers, where the topmost valence miniband from the $plus.minus K$-valleys is almost perfectly flat and well separated from other bands. This band carries a spin/valley Chern number and is well described by a generalized Kane-Mele model~@Kane2005.

At half filling of this topological flat band, we show that repulsive interactions drives spontaneous spin/valley polarization leading to Haldane's quantum anomalous Hall insulator~@Haldane1988. We further find an out-of-plane displacement field drives a transition from the Haldane insulator into a Mott insulator. Depending on the twist angle, this Mott state is either a spin/valley polarized ferromagnet or features intervalley coherence that spontaneously breaks the spin/valley $U ( 1 )$ symmetry. Thus our work reveals a rich phase diagram of topological, correlated and broken-symmetry insulators enabled by the flat band in TMD homobilayers at small twist angles below the $4^compose$--$5^compose$ range in current experimental studies ~@Wang2020 @Bi2021.

Due to spin-valley locking~@Di2012, monolayer TMDs such as WSe$""_2$ and MoTe$""_2$ feature top valence bands with spin-$arrow.t$ at $+ K$ valley and spin-$arrow.b$ at $- K$. We study TMD homobilayers with a small twist angle $theta$ starting from AA stacking, where every metal (M) or chalcogen (X) atom on the top layer is aligned with the same type of atom on the bottom layer. In such twisted structure, the $K$ points of the two layers are slightly displaced and form the two corners of the moiré Brillouin zone, denoted as $kappa_plus.minus$. A set of spin-$arrow.t$ ($arrow.b$) moiré bands is formed from hybridized $+ K$ ($- K$) valley bands of the two layers. The complete filling of a single moiré band including spin degeneracy thus requires 2 holes per moiré unit cell.

= RESULTS
<results>

In order to obtain accurate moiré band structures, we perform large-scale density functional theory calculations with the SCAN+rVV10 van der Waals density functional ~@peng2016versatile, which captures the intermediate-range vdW interaction through its semilocal exchange term. Focusing on twisted bilayer WSe$""_2$, we find that lattice relaxation has a dramatic effect on moiré bands. Our DFT calculations at $theta = 5.08^compose$ with 762 atoms per unit cell show a significant variation of the layer distance $d$ in different regions on the moiré superlattice, as shown in #ref(<fig:bzdft>)b. $d = 6.7$Å is smallest in MX and XM stacking regions, where the metal atom on top layer is aligned with chalcogen atom on the bottom layer and vice versa, while $d = 7.1$Å is largest in MM region where metal atoms of both layers are aligned. With the fully relaxed structure, the low-energy moiré valence bands of twisted bilayer WSe$""_2$ are found to come from the $plus.minus K$ valley (shown in Fig.1c), as opposed to the $Gamma$ valley in previous computational studies~@naik2018ultraflatbands and consistent with recent works @Wang2020 @vitale2021flat @kundu2021flat.

At small twist angles, the large size of moiré unit cell makes it difficult to perform DFT calculations directly on twisted TMD homobilayers. An alternative and complementary approach, introduced by Wu et al. @Wu2019, is the continuum model based on an effective mass description, which models the formation of moiré bands using spatially-modulated interlayer tunneling $Delta_T ( bold("r") )$ and layer-dependent potential $Delta_(1 , 2) ( bold("r") )$. The continuum model Hamiltonian for $plus.minus K$ valley bands is given by

$ cal(H)_arrow.t = mat(delim: "(", - frac(ℏ^2 ( bold("k") - bold(kappa)_(+) )^2, 2 m^(*)) + Delta_1 ( bold("r") ), Delta_T ( bold("r") ); Delta_T^dagger ( bold("r") ), - frac(ℏ^2 ( bold("k") - bold(kappa)_(-) )^2, 2 m^(*)) + Delta_2 ( bold("r") )) $<eq:Hcont>

and $cal(H)_arrow.b$ as its time-reversal conjugate.

The continuum model approach is valid at small twist angle where the moiré wavelength is large enough. In this case, the atom configuration within any local region of a twisted bilayer is identical to that of an untwisted bilayer with one layer laterally shifted relative to the other by a corresponding displacement vector $bold("d")_0$. For example, $bold("d")_0 = 0 , - (bold("a")_1 + bold("a")_2) / 3 , (bold("a")_1 + bold("a")_2) / 3$, with $bold("a")_(1 , 2)$ the primitive lattice vector of a monolayer, correspond to the MM, MX and XM regions respectively. Therefore the moiré potentials for twisted TMD bilayers $Delta_T ( bold("r") )$ and $Delta_(1 , 2) ( bold("r") )$ as a function of coordinate on the moiré superlattice can be determined from the valence band edges of the untwisted bilayer as a function of the corresponding shift vector @Zhang2021. In the lowest harmonic approximation, $Delta_T ( bold("r") )$ and $Delta_(1 , 2) ( bold("r") )$ are sinusoids that interpolate between MM, MX and XM regions#cite(<Wu2019>):

$ Delta_(1 , 2) ( bold("r") ) & = & 2 V sum_(j = 1 , 3 , 5) cos ( bold("g")_j dot.op bold("r") plus.minus psi )\
Delta_T ( bold("r") ) & = & w ( 1 + e^(- i bold("g")_2 dot.op bold("r")) + e^(- i bold("g")_3 dot.op bold("r")) ) $

where $bold("g")_j$ are $( j - 1 ) pi / 3$ counter-clockwise rotations of the moiré reciprocal lattice vector $bold("g")_1 = ( 4 pi theta / sqrt(3) a_0 , 0 )$, and $a_0$ is the monolayer lattice constant. Up to an overall energy scale, the continuum model depends only on the dimensionless parameters $alpha equiv V theta^2 / ( m^(*) a_0^2 )$, $w / V$ and $psi$.

From our DFT calculation for untwisted bilayers with relaxed layer distance and using the vacuum level as an absolute reference energy for the band edge, we obtain the continuum model parameters $V = 9.0$meV, $psi = 128^compose$ and $w = 18$meV. Importantly, the interlayer tunneling strength $w$ is twice larger than previously reported @Wu2019. To demonstrate the accuracy of the continuum model method, we compare in #ref(<fig:bzdft>)c the band structures computed by large-scale DFT directly at $theta = 5.08^compose$ and by the continuum model with the above parameters, finding excellent agreement. Details on the DFT calculation can be found in Supplementary Note 1~@supp.

We remark that different approaches~@magorrian2021multifaceted @tang2021geometric @kundu2021flat can lead to different conclusions on topology. Thus, we utilize a method to determine band topology directly from our large-scale DFT band structure based on symmetry eigenvalues. As detailed in Supplementary Note 2~@supp, we are able to isolate bands from the $plus.minus K$ valley and compute their $C_(3 z)$ eigenvalue at the high symmetry momenta $gamma$, $kappa_plus.minus$, which determine their Chern number (mod 3)~@Fang2012. The $C_(3 z)$ eigenvalues for the first two bands, summarized in @table1, are consistent with the first two bands having non-trivial valley Chern number $cal(C)_(K , 1) = cal(C)_(K , 2) = 1$.

// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [TABLE #context it.counter.display(it.numbering). #it.body]
}

#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (left,left,left,left,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.vline(x: 4, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header([Band, Valley], [$kappa_(+)$], [$kappa_(-)$], [$gamma$],),
    table.hline(),
    [1, $K$], [$e^(i pi / 3)$], [$e^(i pi / 3)$], [$e^(i pi)$],
    [1, $K'$], [$e^(- i pi / 3)$], [$e^(- i pi / 3)$], [$e^(i pi)$],
    [2, $K$], [$e^(- i pi / 3)$], [$e^(- i pi / 3)$], [$e^(i pi / 3)$],
    [2, $K'$], [$e^(i pi / 3)$], [$e^(i pi / 3)$], [$e^(- i pi / 3)$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [$C_(3 z)$ eigenvalues of the first two bands from each valley, computed from large-scale DFT wavefunctions at high symmetry momentum points.]
  , kind: table
  )
<table1>

// [figvision] imgs/Fig1f.png
// Panel a is a schematic diagram illustrating the Brillouin zone of a moiré superlattice. It displays two
// overlapping hexagonal outlines representing reciprocal lattices, rotated relative to each other by an angle
// labeled theta. The vertices of the larger hexagon are marked with K and negative K. A smaller inset hexagon on
// the right defines the mini-Brillouin zone, labeling its high-symmetry points as gamma, m, kappa-plus, and
// kappa-minus. This layout visualizes the momentum space folding that generates the electronic band structure
// shown in subsequent panels. Panel b presents a heatmap map of layer distance overlaid with a real-space
// lattice schematic. The background color gradient ranges from white to dark blue, quantifying the vertical
// separation between atomic layers from 6.7 Angstroms to 7.1 Angstroms according to the vertical color bar on
// the right. Dark blue regions indicate maximum layer proximity. Superimposed is a black hexagonal outline
// connecting six nodes: three green dots labeled XM and three blue dots labeled MX. Two black dots labeled MM
// sit at the centers of adjacent hexagons, identifying specific stacking configurations within the moiré unit
// cell. Panel c plots the electronic band structure showing energy E in meV on the y-axis versus momentum along
// the gamma-K-plus-m-gamma path on the x-axis. The energy range spans from negative 200 to 0 meV. Blue
// continuous curves represent theoretical calculations, while discrete black dots correspond to large-scale DFT
// data points. Vertical dashed grey lines mark the K-plus and m symmetry points. The plot demonstrates excellent
// agreement between theory and simulation, revealing flat bands near negative 50 meV and dispersive bands below
// negative 100 meV.
#figure(image("imgs/Fig1f.png", width: 100%),
  caption: [
    Comparison with large scale DFT calculations. $a )$ The $kappa_plus.minus$ points of the moiré Brillouin zone are formed from the $K$ points of the monolayer Brillouin zones, which are rotated by $plus.minus theta / 2$. $b )$ The interlayer distance of the twisted WSe$""_2$ structure obtained from DFT is shown, demonstrating a large variation between the MM and XM/MX regions. $c )$ The continuum band structure (blue lines) is plotted in comparison with large scale DFT calculations (black dots) at twist angle $theta = 5.08^compose$, showing excellent agreement.
  ]
)
<fig:bzdft>

// [figvision] imgs/Fig2.png
// Panel a consists of four side-by-side line plots showing energy band structures at twist angles of 1, 1.43,
// 1.67, and 2.5 degrees. The vertical axis represents Energy in meV from 0 to 40, while the horizontal axis maps
// momentum along the Gamma-K-M-Gamma path. Solid blue lines denote bands with Chern numbers labeled as +1 or -1.
// As the angle increases, the number of visible bands decreases significantly, simplifying the structure. Grey
// dashed vertical lines mark high-symmetry points K and M. Panel b displays four square heatmaps representing
// Berry curvature distributions across the kx-ky plane. Each map features a grey hexagonal outline indicating
// the first Brillouin zone boundary. Vertical color bars on the right quantify the magnitude of the squared
// Berry curvature, ranging from 0 to 20 for the leftmost plot, decreasing to a maximum of 12 for the rightmost
// plot. The visualizations transition from distinct localized peaks near zone corners at low angles to a single
// concentrated peak at the center as the twist angle increases.
#figure(image("imgs/Fig2.png", width: 100%),
  caption: [
    Continuum model band structure and Berry curvature at various twist angles. $a )$ The band structure $E_i ( bold("k") )$ along with the Chern numbers of the first two bands and $b )$ the (scaled) Berry curvature $| kappa_(+) |^2 cal(F) ( bold("k") )$ of the first band is shown for the continuum model at $theta = 1^compose , 1.43^compose , 1.67^compose ,$ and $2.5^compose$. At $theta = 2.5^compose$, the first band maxima is located at the $kappa_plus.minus$ points and the Berry curvature is peaked at $gamma$. At $theta = 1^compose$, the band maximum is instead at $gamma$ and $cal(F)$ is peaked at $kappa_plus.minus$. During the crossover region between these angles, $E_1 ( bold("k") )$ and $cal(F) ( bold("k") )$ both become very flat. We find that the band dispersion $E_1 ( bold("k") )$ is flattest at $theta approx 1.43^compose$ and the Berry curvature $cal(F) ( bold("k") )$ is most uniform at $theta approx 1.67^compose$, both shown.
  ]
)
<fig:BandBerry>

Using the new continuum model parameters established above, along with the lattice constant $a_0 = 3.317 upright("Å")$~@mounet2018two and the effective mass $m^(*) = 0.43 m_e$ @fallahazad2016shubnikov @rasmussen2015computational, we calculate the band structure of twisted bilayer WSe$""_2$, $E_i ( bold("k") )$, at various twist angles, as shown in #ref(<fig:BandBerry>)a. The bandwidth of the first band, $W = max_(bold("k")) E_1 ( bold("k") ) - min_(bold("k")) E_1 ( bold("k") )$, as well as the (direct or indirect) band gaps $epsilon_(i j)$ between pairs of bands $( i , j ) = ( 1 , 2 )$ and $( 2 , 3 )$, $epsilon_(i j) = min_(bold("k")) E_i ( bold("k") ) - max_(bold("k")) E_j ( bold("k") )$, is shown in @fig:gaps. Focusing on topological features of the first two valence bands, we can divide the moiré band structure into three main regimes divided by $theta_1 approx 1.5^compose$ and $theta_2 approx 3.3^compose$.

First, for $theta < theta_1$, the top two bands are well separated from the rest of the spectrum, and carry opposite Chern number $[ cal(C)_(K , 1) , cal(C)_(K , 2) ] = [ + 1 , - 1 ]$. The bandwidth of the first band $W < 1 upright("meV")$ remains very small throughout. In this regime of very small twist angles, the character of the top two valence bands can be understood from an effective tight binding model on a moiré honeycomb lattice that takes the form of a Kane-Mele model, as suggested in the insightful work of Wu et al.~@Wu2019 As we will later show, the original Kane-Mele description with up to second nearest neighbor hopping terms only describes the band structure well for very small angles $theta lt.tilde 1^compose$. As $theta$ increases towards $theta_1$, longer range hopping terms become more important.

At $theta = theta_1$, the band gap $epsilon_23$ closes and the Chern number of the top two bands changes to $[ + 1 , + 1 ]$. In this second regime, $theta_1 < theta < theta_2$, both top bands have same Chern number $[ + 1 , + 1 ]$ and are still all separated by a sizable gap $epsilon_12 , epsilon_23 > 0$. The bandwidth of the first band increases rapidly with $theta$, reaching around $W approx 20 upright("meV")$ at $theta_2$ (not shown). Finally, in the third regime, $theta_2 < theta lt.tilde 5.4^compose$, the indirect gap $epsilon_12$ vanishes, but the direct gap remains open. The Chern number of the top two bands remains well defined at $[ + 1 , + 1 ]$, but the bands now overlap in energy and are highly dispersive. In both the second and third regimes, $epsilon_23 > 0$, thus the top two bands together form a gapped $cal(C) = 2$ manifold. Beyond $theta gt.tilde 5.4^compose$, the gap $epsilon_23$ also vanishes and the top two bands are no longer isolated (Supplementary Note 3)@supp. Topology of the continuum model at $theta approx 5^compose$ is consistent with that determined directly from large-scale DFT in @table1, further strengthening our confidence in the continuum model description even up to larger angles.

For $theta < theta_2$, especially near $theta_2$ where the first band is more dispersive, the spin Chern number $cal(C) = 1$ and $epsilon_12 > 0$ is favorable for a quantum spin Hall insulator at a filling of $n = 2$ holes per moiré unit cell. Also, for the wide range of angles $theta_1 < theta lt.tilde 5.4^compose$, $epsilon_23 > 0$ and the top two bands both carry spin Chern number $cal(C) = 1$, giving rise to a double quantum spin Hall state with two sets of counter-propagating spin-polarized edge modes at $n = 4$.

We now address the bandwidth $W$, which shows a sharp minimum at $theta = theta_m approx 1.43^compose$ reminiscent of the magic angle in TBG. To understand this, notice that the top band, shown in #ref(<fig:BandBerry>)a, has two qualitatively different behaviors in the small and large $theta$ limit. For $theta gt.tilde 2.5^compose$, $E_1 ( bold("k") )$ reaches its maximum at $bold(kappa)_plus.minus$ and minimum at $gamma$, which can be understood from the weak moiré effects at small $alpha$. For small $theta lt.tilde 1^compose$, the opposite holds and $E_1 ( bold("k") )$ is maximum is at $gamma$ and minimum at $kappa_plus.minus$, which can be understood from the effective Kane-Mele model, which we will derive explicitly. At the crossover between these two limits, the band maxima and minima must switch locations in the moiré Brillouin zone, potentially leading to a flat band. As can be clearly seen, $W$ achieves a minimum at a particular magic angle $theta_m$ during this crossover. At $theta_m$ the gap to the next state $epsilon_12 approx 3.7 upright("meV")$ is much larger than the bandwidth $W approx 0.1 upright("meV")$. The band structure at $theta_m$ is shown in #ref(<fig:BandBerry>)a, which shows that the first band is almost completely flat and separated from the next band. For even smaller $theta$, both $epsilon_12$ and $W$ vanish, but the ratio $W / epsilon_12$ diverges. Thus, we may view $theta_m$ as the angle at which the top band is flattest while still being well isolated from the rest of the spectrum.

Analytic progress can be made in estimating the magic angle by considering the dispersion near $bold(gamma)$. Assuming that the bandwidth will be minimized near the angle at which $E_1 ( bold(gamma) )$ changes from minima to maxima, expanding $E_1 ( bold(gamma) + bold("k") ) approx E_1 ( bold(gamma) ) + frac(bold("k")^2, 2 m_gamma) + cal(O) ( bold("k")^3 )$, the effective mass $m_gamma$ should diverge near the crossover. Let $tilde(theta)_m$ to be the angle at which $m_gamma^(- 1) = 0$. Then, considering only the $6$ most relevant states at $bold(gamma)$, we have (Supplementary Note 4~@supp)

$ tilde(theta)_m^(- 2) = frac(8 pi^2, 9 m^(*) a_0^2) (frac(1, cal(E)_(n_0) - cal(E)_(n_0 + 1)) + frac(1, cal(E)_(n_0) - cal(E)_(n_0 - 1))) $<eq:tildetheta>

where $cal(E)_n = 2 w cos ( pi n / 3 ) + 2 V cos ( 2 pi n / 3 - psi )$, and $n_0$ is the integer (mod 6) which maximizes $cal(E)_n$ ($n_0 = 1$ for WSe$""_2$ parameters). We find that @eq:tildetheta provides a decent estimate for $theta_m$ in the cases considered. In WSe$""_2$, we have $tilde(theta)_m = 1.47^compose$, compared to $theta_m = 1.43^compose$ at which the bandwidth is minimized.

// [figvision] imgs/Fig3.png
// This line plot displays three energy quantities as a function of the angle theta. The horizontal axis
// represents theta in degrees, ranging from 0 to 3.5 with major ticks at intervals of 0.5. The vertical axis
// denotes bandwidth W and band gaps epsilon_12 and epsilon_23 in millielectronvolts (meV), spanning 0 to 10. A
// solid blue curve for W starts near zero, peaks slightly below 1 meV, drops to exactly 0 at theta_m
// (approximately 1.45 degrees), then rises steeply off the chart past 10 meV by 2.4 degrees. A dashed red curve
// for epsilon_12 increases to a peak of roughly 6 meV near 2.3 degrees before declining to zero at theta_2
// (approximately 3.3 degrees). A dashed orange curve for epsilon_23 decreases from over 8 meV to a minimum at
// theta_1 (approximately 1.55 degrees) before rising again. Annotations mark the Chern number pairs [+1,-1] on
// the left and [+1,+1] on the right.
#figure(image("imgs/Fig3.png", width: 100%),
  caption: [
    The bandwidth of the first band $W$, and indirect band gap between the first two pairs of bands $epsilon_12$ and $epsilon_23$. The bandwidth is minimized at $theta_m$, while being well separated from the remaining bands. The Chern numbers of the first two bands, $[ cal(C)_(K , 1) , cal(C)_(K , 2) ]$, is shown before and after the $epsilon_23$ gap closing at $theta = theta_1$. For $theta gt.eq theta_2$, $epsilon_12$ vanishes.
  ]
)
<fig:gaps>

Next, we turn to the Berry curvature $cal(F) ( bold("k") )$ of the top band, shown in #ref(<fig:BandBerry>)b. In all cases, the first band has Chern number $cal(C)_(K , 1) = frac(1, 2 pi) integral_(upright("BZ")) cal(F) d bold("k") = 1$\; however, the distribution changes very drastically as $theta$ is varied. At $theta gt.tilde 2^compose$, $cal(F)$ is peaked around the band minimum at $bold(gamma)$. At $theta lt.tilde 1^compose$, $cal(F)$ is instead sharply peaked at the $bold(kappa)_plus.minus$ points. Near the crossover region, the distribution of $cal(F)$ shifts from $bold(gamma)$ to $bold(kappa)_plus.minus$, and can become very evenly distributed. We find that $cal(F)$ is most evenly distributed near $theta = 1.67^compose$, shown in #ref(<fig:BandBerry>)b, where $cal(F)$ becomes almost uniform in the Brillouin zone. The uniform distribution of $cal(F)$ is reminiscent to that of Landau levels. Time reversal symmetry forces the corresponding spin-$arrow.b$ bands from the $- K$ valley to have opposite Chern number.

We emphasize that the physics of the magic angle arises due to the crossover between two qualitatively different behaviors of the first band at low and high angles. Additional factors unaccounted for by the continuum model may result in, for example, angle-dependent model parameters. However, as long as the qualitative behaviors at small and large angles are unchanged, there will still be crossover regime at which the band becomes flat. Even when the bands are not perfectly flat, a diverging mass can still give rise to a diverging higher-order van Hove singularity~@Bi2021.

Recall that for $theta < theta_1$, the top two bands carry opposite Chern number and are separated from the rest of the spectrum, suggesting a description in terms of an effective tight binding model. We now focus on $theta < theta_1$ and directly derive an effective tight binding model for the first two moiré bands by explicitly constructing a basis of localized Wannier states. These Wannier states are constructed via a simple procedure which manifestly preserves the symmetries of the twisted homobilayer. Given the single particle eigenstates $( | phi.alt_(n , bold("k")) chevron.r )$ of the continuum Hamiltonian~@eq:Hcont for each $bold("k")$ in the mBZ, we first construct a superposition of the first two $( n = 1 , 2 )$ eigenstates, $| tilde(phi.alt)_(n , bold("k")) chevron.r = sum_(m = 1 , 2) U_("nm")^(( bold("k") )) | phi.alt_(m bold("k")) chevron.r$ using a $2 times 2$ unitary matrix $U_("nm")^(( bold("k") ))$, which maximizes the layer polarization at every $bold("k")$:

$ P_(bold("k")) = sum_(n = 1 , 2) ( - 1 )^n chevron.l tilde(phi.alt)_(n , bold("k")) | ( cal(P)_(-) - cal(P)_(+) ) | tilde(phi.alt)_(n , bold("k")) | , chevron.r $

where $cal(P)_plus.minus$ is the projector on to the top/bottom layer, so that $| tilde(phi.alt)_(1 , bold("k")) chevron.r$ is chosen to mostly consist of states in the top layer, and similarly for $| tilde(phi.alt)_(2 , bold("k")) chevron.r$ on the bottom layer. This uniquely specifies $| tilde(phi.alt)_(n , bold("k")) chevron.r$ up to a phase, which we choose to be real and positive at the XM ($n = 1$) or MX ($n = 2$) stacking regions (Supplementary Note 5~@supp). The Wannier states at moiré lattice vector $bold("R")$ is then defined $| W_(bold("R"))^n chevron.r = 1 / sqrt(N_k) sum_(bold("k")) e^(- i bold("k") dot.op bold("R")) | tilde(phi.alt)_(n bold("k")) chevron.r$. They are localized about their centers with a root-mean-square distance $a_W approx 5 upright("nm")$, and are also mostly composed of states in one layer: $chevron.l W_(bold("R"))^1 | cal(P)_(+) | W_(bold("R"))^1 | approx chevron.r 0.83$ is mostly in the top layer, and vice versa for $| W_(bold("R"))^2 chevron.r$.

It is straightforward to obtain the hopping matrix elements of the effective tight binding model in the Wannier basis for the top two bands as a function of $theta$. #ref(<fig:Wannier>)b shows the $n$th nearest neighbor hopping matrix elements $t_n$ obtained in this way, up to $n = 5$. As anticipated, the effective tight binding model at $theta < theta_1$, including the spin/valley degrees of freedom, is a generalized Kane-Mele model with sites centered on the honeycomb lattice formed by MX and XM stacking regions~@Wu2019.

The tight binding Hamiltonian is found to be

$ cal(H)_(upright("TB")) = t_1 sum_(chevron.l i , j chevron.r , sigma) c_(i sigma)^dagger c_(j sigma) + | t_2 | sum_(chevron.l chevron.l i , j chevron.r chevron.r , sigma) e^(i phi.alt sigma nu_(i j)) c_(i sigma)^dagger c_(j sigma) + dots.h.c $<eq_effKaneMele>

where $c_(i sigma)^dagger , c_(i sigma)$ are fermionic creation/annihilation operators, $sigma = plus.minus$ is the spin/valley degree of freedom, the sum $chevron.l i , j chevron.r$ ($chevron.l chevron.l i , j chevron.r chevron.r$) is over (next) nearest neighboring sites $i , j$ of the honeycomb lattice, and $nu_(i j) = plus.minus 1$ depending on whether the path $i arrow.r j$ turns right $( + )$ or left $( - )$. The parameter $t_1$ is real, while $t_2 equiv | t_2 | e^(i phi.alt)$ is complex, and $dots.h.c$ contain longer range hopping terms. We find that $| t_n |$ quickly reduce in magnitude with hopping distance $n$, and only the 2nd neighbor hopping has a significant imaginary component. In #ref(<fig:Wannier>)c, we show the bandwidth of the top band, $W$, in the effective tight binding model TB$""_n$ including up to $t_n$ hopping terms, compared to that of the continuum model. For $theta lt.tilde 1^compose$, TB$""_2$ already captures the band structure very well. Near the magic angle, higher range hoppings become more important in capturing the flatness of the band.

// [figvision] imgs/Fig4.png
// Panel a displays two heatmaps on a black background, each overlaid with gray dashed hexagonal grid lines. The
// vertical axis is labeled r_y and the horizontal r_x, both ranging from -10 to 10. The top map, labeled XM,
// shows a bright yellow-red Gaussian-like peak centered near (-5, 2), indicating high intensity; text below
// reads “83% top, 17% bottom”. The bottom map, labeled MX, has its peak shifted rightward near (5, 2) and reads
// “17% top, 83% bottom”. A vertical color bar on the right maps values from 0 (black) to max (yellow). These
// visualize Wannier function localization in twisted bilayer graphene for different stacking configurations.
// Panel b plots hopping parameters t_h (meV) versus angle θ (deg), though θ is not shown on x-axis here — likely
// shared with panel c. Five series are plotted: Re[t] (solid black), Im[t] (dotted black), t₁ (solid blue), t₂
// (solid red), t₃ (solid orange), t₄ (solid purple), t₅ (solid green). Blue line (t₁) decreases linearly from
// ~-0.2 to -1.5 meV. Red (t₂) slightly declines. Orange (t₃) rises gently. Purple (t₄) and green (t₅) remain
// near zero. Dotted black (Im[t]) stays flat at zero. Legend inside plot identifies all. Shows angular
// dependence of tight-binding model hoppings. Panel c plots bandwidth W (meV) vs twist angle θ (deg) from 0.8°
// to 1.5°. Four datasets: Cont. (solid black line), TB₂ (red circles, dashed line), TB₄ (purple circles, dotted
// line), TB₅ (green circles, dash-dotted line). All start near 0.6 meV at 0.8°, rise to peak ~0.9–1.0 meV around
// 1.0°, then fall sharply after 1.2°. At 1.4°, Cont. drops to ~0.1 meV while TB₂ jumps to >1.2 meV. TB₄ and TB₅
// stay between 0.3–0.5 meV. Demonstrates how including more orbitals (TB₂ to TB₅) affects predicted bandwidth
// evolution with twist angle compared to continuum model.
#figure(image("imgs/Fig4.png", width: 100%),
  caption: [
    Wannier functions and tight binding model parameters. $a )$ Wannier functions at the magic angle, $b )$ tight binding parameters as a function of $theta$, and $c )$ the bandwidth of the top band in the effective tight binding model TB$""_n$ keeping up to $n$th nearest neighbor hopping terms, compared to that of the continuum model.
  ]
)
<fig:Wannier>

For the small twist angles $theta < theta_1$ considered, since the size of the Wannier orbitals are small compared to the moiré unit cell, the dominant interaction is a simple on-site Hubbard term $cal(H)_U = U sum_i n_(i arrow.t) n_(i arrow.b)$. We also estimate $U tilde e^2 / ( epsilon.alt a_W ) approx 70 upright("meV")$ at $theta_m$, using a realistic relative dielectric constant $epsilon.alt = 4$ and $a_W = 5 upright("nm")$, which is significantly larger than the tight binding parameters $t_n$. Therefore at such small twist angle, twisted WSe$""_2$ homobilayers are in the strong-coupling regime, in contrast with $theta tilde 4^compose$--$5^compose$ where the bandwidth is comparable to the interaction strength @Wang2020 @Bi2021.

In the following, we shall focus on the strongly correlated regime $theta < theta_1$ at a filling of $n = 1$ holes per moiré unit cell, where we expect the flat bands will favor the quantum anomalous Hall (QAH) insulator due to spontaneous spin/valley polarization. The reason is as follows. First, spin/valley polarized states filling the top band of $cal(H)_(upright("TB"))$ with $sigma = plus.minus$ are exact eigenstates of our interacting model, because the spin-orbit coupling in $cal(H)_(upright("TB"))$ conserves the $z$-spin/valley component. Then, these spin/valley polarized states avoid the Hubbard interaction, and also minimize the kinetic energy in the case of a completely flat top band. Minimizing both parts of the Hamiltonian, they necessarily are many body ground states of the model at $n = 1$ filling. The complete polarization of $cal(H)_(upright("TB"))$ exactly corresponds to Haldane's model for QAH insulator.

// [figvision] imgs/Fig5.png
// Panel a. A two-dimensional phase diagram as a heatmap with horizontal axis the twist angle θ from 0.55 to
// about 1.5 degrees (ticks 0.6–1.4) and vertical axis interaction strength U/|t1| from 0 to about 10.5 (ticks 0,
// 2, 4, 6, 8, 10), at fixed displacement field Δ = 0, stated in the top title. Colour encodes the Hartree-Fock
// gap divided by |t1| on a discrete colourbar to the right, running 0 to 3, white at zero through orange, dark
// red, to near-black at 3; the colourbar is titled Gap/|t1|. Below a dashed blue boundary curve labelled "Magnon
// instability" the phase is a white Metal region (zero gap); the curve descends monotonically from about U/|t1|
// = 6.5 at θ = 0.6° to a minimum near U/|t1| ≈ 0.6 at θ ≈ 1.37°, then turns slightly upward to ≈ 0.9 at θ =
// 1.5°. Above it lies the gapped QAH phase (labelled in white in the dark upper-right region), whose gap grows
// with increasing U and increasing θ. Panel b. An analogous heatmap with horizontal axis θ again 0.55–1.5
// degrees and vertical axis displacement field Δ/|t1| from 0 to 5.2 (ticks 0–5), at fixed U = 10|t1| from the
// top title. The colourbar, also titled Gap/|t1|, now spans 0 to 5 with the same white–orange–red–black
// progression. Three phases appear. Lower-left is FMz (black label), a light-coloured small-gap region extending
// across low Δ and, at larger θ, up to moderate Δ. Lower-right is QAH (white label), separated from FMz by a
// rising thick grey curve starting near (θ = 0.58°, Δ ≈ 0.1) and reaching (θ ≈ 1.3°, Δ ≈ 2.7); above θ ≈ 1.3°
// the QAH region extends up to Δ ≈ 3. Upper-left is AFMXY 120° (black label), and to its right FMXY (black
// label); these two are separated by a thick white curve that rises from (0.58°, Δ ≈ 2.55) steeply, tilting
// rightward to exit near (1.0°, Δ ≈ 5.1). A dashed blue curve tracks just above the white curve at low θ and
// bends right, ending near (1.5°, Δ ≈ 3.3), crossing into the QAH region at high θ — consistent with the
// magnon-instability boundary from panel a. Overall gap magnitude increases with Δ within each gapped phase
// (darker red at top and right), and white pixels along some boundaries mark unresolved cells.
#figure(image("imgs/Fig5.png", width: 100%),
  caption: [
    Numerical solution of the self-consistent Hartree-Fock approximation. The phase diagram is shown as a function of the twist angle and (a) interaction strength at fixed displacement field $Delta = 0$, or (b) displacement field at fixed interaction strength $U = 10 | t_1 |$ , including up to 5th nearest neighbor hopping terms. The insulating phases denoted by QAH, FM$""_z$, 120$""^compose$ AFM$""_(x y)$, and FM$""_(x y)$ are described in the main text. The dashed blue line shows the boundary of the FM$""_z$ phases determined by the first magnon instability. The colors indicate the charge gap. Hartree-Fock calculations were done with a $sqrt(3) times sqrt(3)$ unit cell of $6$ atom sites, and a $30 times 30$ grid of $bold("k")$ points.
  ]
)
<fig:AddingU>

To include corrections coming from the finite bandwidth $W$ of the flat band, we solve our interacting problem within the Hartree-Fock (HF) approximation, where the Hubbard interaction is decoupled as $n_(i arrow.t) n_(i arrow.b) tilde.eq chevron.l n_(i arrow.t) chevron.r n_(i arrow.b) + chevron.l n_(i arrow.b) chevron.r n_(i arrow.t) - chevron.l c_(i arrow.t)^dagger c_(i arrow.b) chevron.r c_(i arrow.b)^dagger c_(i arrow.t) - chevron.l c_(i arrow.b)^dagger c_(i arrow.t) chevron.r c_(i arrow.t)^dagger c_(i arrow.b)$, up to a constant term, and where the expectation values for the spin and density at each site are determined self-consistently by iteration. Our numerical solutions of the HF equations are shown in #ref(<fig:AddingU>)a as a function of twist angle and interaction strength. As expected, we observe a transition from a metallic state to a ferromagnetic QAH insulator polarized along $z$ when $U$ increases. Within HF, this transition can be understood as follows. The fully polarized states yield a rigid shift of the bands by $sigma U / 2$. When $U$ is larger than the non-interacting bandwidth $W$, a full gap opens and the ferromagnetic state fully fills one of Chern bands of $cal(H)_(upright("TB"))$, which leads to a QAH phase. We remark that the appearance of the QAH phase relies on both the non-trivial Chern number as well as the fact that the band is flat and isolated, features which are maximized at the magic angle, as illustrated by a dip of the insulating phase above $theta tilde.eq 1.4^compose$.

To precisely locate the transition between QAH insulator and the metallic phase, we compute the magnon excitation spectrum above the fully ferromagnetic state by exact diagonalization (ED) of the interacting Hamiltonian projected on the spin-1 excitation subspace~@EDMagnons. For large $U$, this spectrum is gapped and the QAH is robust against spin flips. Decreasing $U$ eventually brings one magnon at zero energy, which destabilizes the ferromagnetic states and drives the transition to a metal. As shown in #ref(<fig:AddingU>)a, the ED results almost perfectly agrees with the HF boundaries, putting them on firmer grounds.

For the large values of $U$ relevant to WSe$""_2$, the magnons have a large gap, and the lowest excitation corresponds to an interband transition between two bands with same spin. The QAH phase is thus protected by a gap $epsilon_12 approx 3.7$meV near the magic angle, leading to quantum Hall effect at elevated temperature.

We also highlight that the QAH may also be observed for larger twist angles, where the first band still carries a non-zero Chern number (@fig:BandBerry), and its bandwidth remain small compared to the estimated $U$ (@fig:gaps). Likewise, the second band is topological and quite flat for $theta tilde 2^compose upright("–") 3^compose$ (Supplementary Note 3), and therefore QAH may also be observed at a filling of $n = 3$. Twisted TMD bilayers with $plus.minus K$-valley bands are thus expected to be an intrinsically robust platform for interaction-induced QAH phases.

It is interesting and worthwhile to compare the QAH phase in twisted TMD and graphene bilayers. Anomalous Hall effect and its quantization have been experimentally observed in magic-angle TBG @Sharpe2019 @Serlin2020, where the alignment with hBN substrate is likely the origin of valley Chern number~@Song2015 and both spin and valley degeneracy are lifted due to repulsive interaction in the flat band~@Zhang2019 @xie2020nature @liu2021nematic @liu2021theories @Bultinck2020 Due to the presence of $S U ( 2 )$-invariant spin degrees of freedom, QAH in TBG is subject to the adverse effect of gapless thermal fluctuation, which forbids long-range order at finite temperature in the thermodynamic limit. In contrast, spin-valley locking in TMD systems enables robust Ising-type spin/valley order that leads to QAH effect at lower temperature.

Another great advantage of twisted TMD bilayer is their high degree of tunability, in particular with respect to applied electric fields~@ElectricallytunableValley @Wang2020 @Zhang2020. Due to the layer polarization of the Wannier basis states, the displacement field can be modeled as a sublattice symmetry breaking term $cal(H)_Delta = Delta / 2 sum_i s_i c_(i sigma)^dagger c_(i sigma)$, where $s_i$ is $( - ) 1$ for $i$ in the $A$ ($B$) sublattice. Including this term in our HF treatment, we can investigate which phases should neighbour the QAH ferromagnet in experiments. We present our solutions of the HF equations as a function of twist angle and displacement field in #ref(<fig:AddingU>)b. There, we fix $U = 10 | t_1 |$, a tradeoff between the large $U$ of the homobilayer system and the convergence rate of the HF self-consistent iteration algorithm. We find it necessary to consider an enlarged $sqrt(3) times sqrt(3)$ unit cell in order to describe all ordered phases of the model.

At small displacement fields, the topmost moiré band remain relatively flat and our earlier arguments for spin/valley polarization still apply. This is confirmed by our HF solutions for $Delta lt.tilde 2 t_1$ (#ref(<fig:AddingU>)b), which exhibit full spin polarization along the $z$ axis. In this region, a transition nevertheless occurs at $Delta = 6 sqrt(3) | t_2 | sin phi.alt$ (up to $t_(n gt.eq 3)$ terms), where the single-particle gap between the two moiré bands closes, and their Chern numbers change from $[ + 1 , - 1 ]$ to $[ 0 , 0 ]$. This gap closing line marks the transition between a QAH insulator and a topologically trivial ferromagnet with spin/valley polarization (FM$""_z$)~@Haldane1988. As the displacement field further increases, the bandwidth $W$ also grows, which decreases the magnon gap (see discussion above). The spin/valley polarized phases eventually become unstable when the magnon gap closes, which can be seen with the very good agreement between the phase boundaries determined with HF and ED (#ref(<fig:AddingU>)b).

Beyond this spin-wave instability line, our results show the emergence of two new Mott insulating phases, where holes are mostly localized on the $A$ sublattice, and their spin either form an antiferromagnetic pattern (120$""^compose$ AFM$""_(x y)$), or ferromagnetically align in the $x y$ plane (FM$""_(x y)$). Their appearance is most easily understood for large displacement fields, where the physics becomes analogous to that of localized moments on the triangular $A$ sublattice. In the regime $t_2 lt.tilde t_1 lt.double Delta , U$ relevant for our system, their coupling is described by an effective XXZ model with Dzyaloshinskii-Moriya (DM) interactions

$ cal(H)_S = sum_(chevron.l i , j chevron.r_B) J_parallel s_i^z s_j^z + J_perp ( s_i^x s_j^x + s_i^y s_j^y ) + D [( bold("s")_i times bold("s")_j ) dot.op bold("z")] , $<eq_effectivespinmodel>

which is derived in Supplementary Note 6~@supp. The parameters of this effective spin model are given by #ref(<eq_parametereffectivespin>)

$ J_parallel & = & frac(4 | tilde(t) |^2, U) + upright("Re") (frac(4 t_1^2 t_2, Delta^2)) ,\
J_perp & = & upright("Re") (frac(4 tilde(t)^2, U) + frac(4 t_1^2 t_2, Delta^2)) ,\
D & = & upright("Im") (frac(4 tilde(t)^2, U) + frac(4 t_1^2 t_2, Delta^2)) , $ <eq_parametereffectivespin>

with $tilde(t) = t_2 + t_1^2 / Delta$. In #ref(<eq_parametereffectivespin>), we have separated exchange terms coming from different physical processes. The first ones $prop tilde(t)^2 / U$ arise from nearest neighbor tunneling on the triangular $A$ sublattice, while the others $prop t_2 ( t_1 / Delta )^2$ originate from loop-exchange on the honeycomb lattice that do not involve any double occupancy.

For twist angles $theta lt.tilde 1^compose$, $t_2 lt.double t_1$ and @eq_effectivespinmodel reduces to an antiferromagnetic (AFM) Heisenberg model, where $J_parallel = J_perp > 0$ are dominated by the nearest neighbor tunneling on the triangular lattice. This simplified triangular lattice description, valid for very small twist angles, has been proposed in earlier studies of Mott insulators in twisted TMDs~@SchradeFu @Pan2020 @Zang2021. It was shown to yield an antiferromagnetic phase that the small residual DM interaction pins in the $x y$ plane. This is the origin of the AFM$""_(x y)$ phase observed in #ref(<fig:AddingU>)b. We also note that the weak-coupling version of AFM$""_(x y)$ phase---an intervalley-coherent $sqrt(3) times sqrt(3)$ density wave #ref(<Bi2021>)---has been proposed for the correlated insulating state at $n = 1$ in twisted bilayer WSe$""_2$ at $theta tilde 4^compose$--$5^compose$ @Wang2020.

For larger twist angles, $t_2$ becomes substantial and we observe that $J_perp$ becomes negative for the realistic parameter $U gt.double Delta$, dominated by a third-order exchange process $prop t_1^2 t_2$ on the honeycomb lattice without double occupancy. Then, the FM$""_(x y)$ phase is favored as shown in #ref(<fig:AddingU>)b. The competition between AFM$""_(x y)$ and FM$""_(x y)$ phases can be analyzed by solving @eq_effectivespinmodel for classical spins. This approach, detailed in the Supplementary Note 6~@supp, gives a transition between the two phases when $| D | = - sqrt(3) J_perp$. For $Delta = 5 t_1$, this criterion yields a critical twist angle $theta = 0.95^compose$, which roughly agrees with our HF results. We note that the ferromagnetic phase due to $J_perp < 0$ does not appear in twisted TMDs based on simplified triangular lattice descriptions.

Finally, we comment on the effect of nearest neighbor repulsion $V sum_(chevron.l i , j chevron.r) n_i n_j$ to our HF phase diagram. This term favors the layer polarized phases, such as the FM$""_(x y)$ and AFM$""_(x y)$ which appear at large $| Delta |$. Small $V$ therefore narrows the range in $Delta$ at which the QAH phase appears. For large $V$, there is a sharp transition at $Delta = 0$ between layer polarized Mott insulating phases, which can lead to the strong hysteretic behavior of Mott ferroelectricity~@Zheng2020 @Zhang2021. The long range component of interactions can be controlled by screening from nearby metallic layers. Multiple recent experiments~@gu2021dipolar @zhang2021correlated on twisted WSe$""_2$ homobilayers in the presence of a nearby WSe$""_2$ monolayer report strong screening effects when the monolayer is doped. This raises the interesting possibility of a screening-induced transition between the QAH and Mott insulating phases.

= DISCUSSION
<discussion>
Our phase diagram demonstrates the high experimental tunability of TMD twisted homobilayers, where the applied displacement field can tune between quantum anomalous Hall phase and Mott insulators involving three types of magnetic orders: FM$""_z$, FM$""_(x y)$ and AFM$""_(x y)$. Despite being electrically insulating, the $x y$-ordered Mott insulators support coherent magnon transport @Bi2021, which can be detected by optical spin injection and spatial-temporal mapping recently developed for TMD bilayers~@Jin2018. The experimental feasibility of tuning and distinguishing between topologically different insulators at the same filling adds to the attractiveness and desirability of TMD based moiré systems.

In parallel to our work on twisted TMD homobilayers, a breakthrough experiment led by Kin Fai Mak and Jie Shan discovered unexpectedly a QAH phase with spontaneous spin/valley polarization in a TMD heterobilayer MoTe$""_2$/WSe$""_2$ at the filling of $n = 1$ tuned by displacement field~@fai2021 @ZhangPNAS. Large-scale DFT calculation and wavefunction analysis reveal two dispersive moiré bands forming the Kane-Mele model, suggestive of a similar origin of QAH as described here.

Looking forward, the remarkable flat Chern band we found, combined with the uniformity of Berry curvature, suggests that twisted TMD homobilayers near magic angle may be an ideal setting for observing a fractional quantum anomalous Hall state at zero magnetic field.

= DATA AVAILABILITY
<data-availability>
The data needed to evaluate the conclusions in the paper are present in the paper and the Supplementary Material. The full dataset generated during this study, including relaxed lattice structure and band structure obtained from DFT, tight binding model parameters, and self-consistent HF solutions, have been deposited in the Zenodo database~@data. Additional data related to this paper is available from the corresponding author upon reasonable request.

= ACKNOWLEDGMENT
<acknowledgment>
We thank Kin Fai Mak, Jie Shan, Tingxin Li and Shengwei Jiang for ongoing collaborations on MoTe$""_2$/WSe$""_2$, Bi Zhen and Constantin Schrade for previous collaborations on related topics. We thank Pablo Jarillo-Herrero, Kenji Yasuda, Cory Dean, Abhay Pasupathy, Qianhui Shi, Augusto Ghiotto and En-Min Shih for helpful discussions.

This work is primarily supported by DOE Office of Basic Energy Sciences, Division of Materials Sciences and Engineering under Award DE-SC0020149 (band structure calculation), DE-SC0018945 (theoretical modeling) and Simons Investigator award from the Simons Foundation (numerical analysis). LF is partly supported by the David and Lucile Packard Foundation.

= AUTHOR CONTRIBUTIONS
<author-contributions>

T.D., V.C., Y.Z. and L.F. performed research, analyzed data, and wrote the manuscript.

= COMPETING INTERESTS
<competing-interests>

The authors declare no competing interests.

#bibliography("refs.bib", title: none)


#pagebreak()
#counter(page).update(1)
#counter(heading).update(0)
#counter(math.equation).update(0)
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)
#set page(columns: 2, numbering: "1", margin: (x: 1.9cm, y: 2.0cm))
#set text(size: 10pt)
#set par(justify: true, leading: 0.2em, spacing: 0.35em, first-line-indent: (amount: 1.2em, all: true))
#set heading(numbering: (..nums) => {
  let p = nums.pos()
  if p.len() == 1 { numbering("I.", p.at(0)) } else { numbering("A.", p.at(1)) }
})
#show heading: set block(above: 1.1em, below: 0.6em)
#show heading.where(level: 1): set text(size: 10pt)
#show heading.where(level: 2): set text(size: 10pt)
#set figure(supplement: "Supplementary Figure", numbering: n => str(n))
#set figure(placement: none)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#set math.equation(numbering: "(1)", supplement: none)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set block(above: 1.1em, below: 0.7em)

#figure(placement: top, scope: "parent", kind: "title", numbering: none,
  block(width: 100%)[
    #align(center)[
      #text(12pt, weight: "bold")[Supplementary Information for “Magic in twisted transition metal dichalcogenide bilayers”]
      #v(0.7em)
      Trithep Devakul, Valentin Crépel, Yang Zhang, and Liang Fu \
      #emph[Department of Physics, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, USA]
    ]
  ],
)

// The SI bibliography restarts at [1] in the original (separate bibliography);
// Typst numbers citeproc entries document-wide, so shift the SI range back.
#show regex("\[[0-9]+\]"): m => {
  let n = int(m.text.slice(1, -1))
  if n > 61 { "[" + str(n - 61) + "]" } else { m }
}

= SUPPLEMENTARY METHODS
<supplementary-methods>

== Supplementary Note 1
<supplementary-note-1>
#emph[Density functional theory calculation and continuum model] --- We study TMD homobilayers with a small twist angle starting from AA stacking, where every metal (M) or chalcogen (X) atom on the top layer is aligned with the same type of atom on the bottom layer (AB stacking can be viewed as a $180 degree$ rotation of top layer). Within a local region of a twisted bilayer, the atom configuration is identical to that of an untwisted bilayer, where one layer is laterally shifted relative to the other layer by a corresponding displacement vector $bold(d)_0$. For this reason, the moiré band structures of twisted TMD bilayers can be constructed from a family of untwisted bilayers at various $bold(d)_0$, all having $1 times 1$ unit cell. Our analysis thus starts from untwisted bilayers.


In particular, $bold(d)_0 = 0 , (- bold(a)_1 + bold(a)_2) / 3 , (bold(a)_1 + bold(a)_2) / 3$, where $bold(a)_(1 , 2)$ is the primitive lattice vector for untwisted bilayers, correspond to three high-symmetry stacking configurations of untwisted TMD bilayers, which we refer to as MM, XM, MX. In MM (MX) stacking, the M atom on the top layer is locally aligned with the M (X) atom on the bottom layer, likewise for XM. The bilayer structure in these stacking configurations is invariant under three-fold rotation around the $z$ axis.


Density functional calculations are performed using generalized gradient approximation with SCAN+rVV10 Van der Waals density functional, as implemented in the Vienna Ab initio Simulation Package. Pseudopotentials are used to describe the electron-ion interactions. We first construct the zero-twisted angle $"WSe"_2$/$"WSe"_2$ bilayer at MM and MX lateral configurations with vacuum spacing larger than 20Å to avoid artificial interaction between the periodic images along the z direction. The structure relaxation is performed with force on each atom less than 0.01 eV/A. We use $12 times 12 times 1$ for structure relaxation and self-consistent calculation. The more accurate SCAN+rVV10 van der Waals density functional gives the relaxed layer distances as 6.6Å and 7.15Å for MX and MM stacking structures, respectively. By calculating the work function from electrostatic energy of converged charge density, we plot in @fig-s1 the band structure of MM and MX-stacked bilayers, with reference energy $E = 0$ chosen to be the absolute vacuum level.


// [figvision] imgs/FigS1.png
// Panel (a) is a line plot displaying the electronic band structure for an MM stacking configuration. The
// vertical axis represents Energy in electron-volts (eV), with labeled ticks at -4 and -5 eV, while the
// horizontal axis maps high-symmetry points in reciprocal space: Gamma, M, K, and Gamma. Multiple black curves
// depict energy bands. A set of three flat bands appears near -5 eV at the Gamma point. At the K point, a
// cluster of dispersive bands rises from below -5 eV to a peak around -4.9 eV, while other bands curve downward
// from the top frame edge near -3.8 eV. Panel (b) presents a line plot of the band structure for an MX(XM)
// stacking arrangement, sharing the same axes as panel (a). The vertical axis spans Energy in eV, and the
// horizontal axis follows the Gamma-M-K-Gamma path. Black lines trace the energy levels. Similar to the previous
// panel, bands exist near -5 eV at Gamma and rise toward -4.9 eV at K. However, the curvature and specific
// spacing of the upper bands near -3.8 eV differ slightly from the MM case, indicating structural variation
// effects on the electronic states.
#figure(
  image("imgs/FigS1.png", width: 100%),
  caption: [
    Band structure with reference energy $E_0$ set as the absolute vacuum level in (a) MM stacking structure; (b) MX (XM) stacking structure.
  ],
) <fig-s1>


To compare with moiré band structure, we further construct the commensurate structures with twist angle $5.08 degree$ with 762 atoms, and perform large scale DFT calculation to relax the moiré superlattice. The spacial dependent layer distance profile has been discussed in the main text, and fits nicely with the untwisted MM and MX stacking structures. The moiré band structure with spin orbital coupling agrees remarkably well with the continuum model derived from untwisted calculations, and the effective mass is chosen as $0.38 m_e$, close to the experimental value $0.4 tilde 0.45 m_e$. To reveal the real space localization of moiré flat band, the $gamma$ point Kohn-Sham wavefunction for the top-most moiré valence band is calculated and projected to bottom and top layer, respectively. As shown in @fig-s2, we find that the charge are localized at MX and XM region, consistent with previous Wannier function.


// [figvision] imgs/FigS2.png
// Panel (a) displays a heat map of the Kohn-Sham wavefunction projected onto the top layer, presented as a
// rhombus-shaped 2D plane. The color scale ranges from blue at zero intensity to red at maximum values. The plot
// reveals a periodic pattern where high-intensity regions form distinct clusters shaped like six-petaled flowers
// or hexagons. These bright spots are centered around specific lattice points marked with green dots labeled XM
// and MX. Conversely, the areas corresponding to MM sites, indicated by black dots, show minimal intensity. A
// black hexagonal outline connects the XM and MX sites, emphasizing the moiré unit cell structure where the
// electron density is localized on the top layer. Panel (b) shows the corresponding wavefunction projection for
// the bottom layer, maintaining the identical rhombus geometry and labeling scheme as panel (a). In contrast to
// the top layer, the high-intensity signal here appears as a dense, uniform grid of small white dots distributed
// across the entire area, rather than large clusters. The background remains deep blue, indicating low amplitude
// between these discrete points. The spatial distribution highlights that while the top layer concentrates
// charge in specific moiré potential minima, the bottom layer exhibits a more delocalized or finely structured
// presence of the valence band electrons throughout the unit cell.
#figure(
  image("imgs/FigS2.png", width: 78%),
  caption: [
    $gamma$ point Kohn-Sham Wavefunction of the topmost moiré valence band projected at (a) top layer, (b) bottom layer.
  ],
) <fig-s2>


For $"MoTe"_2$, the $Gamma$ pockets appears to be the valence band maximum at MX stacking structure when using lattice constant 3.52Å from bulk structures (The relaxed layer distance is 6.95Å, close to the bulk layer distance 6.98Å in 2H structures). Experimentally, AB stacked bilayer $"MoTe"_2$ has been shown to be a indirect band gap semiconductor from optical measurements @lezama2015indirect @ruppert2014optical. We thus believe $Gamma$ pockets would enter in the moiré valence bands for twisted homobilayer $"MoTe"_2$ even for AA stacking. At $theta = 5.08 degree$, we calculate the moiré band structure of fully relaxed AA stacked homobilayer $"MoTe"_2$. As shown in @fig-mote2-bands, the narrow Dirac like $Gamma$ valley moire bands intersect with topmost dispersive $K$ valley moire bands. In transport measurements under zero displacement field, these two type of charge carriers would both enter, causing further complications.


// [figvision] imgs/FigS_MoTe2.png
// This panel displays a line plot of the electronic band structure for a fully relaxed AA stacked homobilayer.
// The vertical axis represents Energy in millielectronvolts (meV), ranging from -200 to 0, while the horizontal
// axis denotes momentum space along the path connecting high-symmetry points labeled gamma, m, kappa, and gamma.
// Multiple black lines depict the energy dispersion curves across these paths. On the right side, text labels
// distinguish two specific sets of bands: the "Gamma valley" located near the top of the plot around -50 meV,
// and the "K valley" situated lower near -100 meV. A red dashed circle highlights the Dirac points within the
// Gamma valley bands at the kappa point, indicating where these bands are very close in energy.
#figure(
  image("imgs/FigS_MoTe2.png", width: 78%),
  caption: [
    Moiré band structure of fully relaxed AA stacked homobilayer $"MoTe"_2$ at $theta = 5.08 degree$. $Gamma$ valley moire bands and $K$ valley moire bands are very close in energy, and we circle the Dirac points from $Gamma$ valley moire bands.
  ],
) <fig-mote2-bands>


== Supplementary Note 2
<supplementary-note-2>
#emph[Moiré topology criteria] --- We determine the Chern number of top two moiré valence bands from their $C_(3 z)$ eigenvalues. Computationally, the Kohn-Sham wavefunctions in plane-wave basis

$ |Psi_(n bold(k)) chevron.r = sum_(bold(G)) C_(n bold(k)) (bold(G)) |bold(k) + bold(G) chevron.r $

are extracted at three $C_(3 z)$ invariant momentum $gamma$, $kappa$, and $kappa'$ with energy cutoff as $E_upright("cut") = 100$ eV and $ℏ^2 ( bold(k) + bold(G) )^2 / 2 m_e < E_upright("cut")$. And we compute their $C_(3 z)$ eigenvalue as:


$ ⟨Psi_(n k) | C_(3 z) | Psi_(n k)⟩ = sum_(tau tau') S_(sigma sigma') ( C_(3 z) ) ⟨Psi_(n k)^sigma | C_(3 z) | Psi_(n k)^(sigma')⟩ $


where $sigma , sigma' = arrow.t$ or $arrow.b$, $⟨Psi_(n k)^sigma | C_(3 z) | Psi_(n k)^(sigma')⟩$ calculated from the transformation relation of plane-waves, and $S_(sigma sigma') ( C_(3 z) )$ is the $C_(3 z)$ spin rotation matrix.


As there is a valley time reversal symmetry within the moire superlattice, the energy bands between $gamma$, $kappa$ and $kappa'$ are enforced to be double degenerate from $K$ and $- K$ valley. Therefore, to determine the valley index of moiré bands, we add a small gating field $D = 0.005$ V/nm to introduce a less than 2 meV splitting at $kappa$ and $kappa'$. The $K$ and $- K$ indexes are then diagnosed by spin resolved wavefunction. At $gamma$ point where bands are still double degenerate with gating field, we extracted the $C_(3 z)$ eigenvalues and valley indexes from finite momentum perturbation along $gamma$ to $kappa$ direction.


== Supplementary Note 3
<supplementary-note-3>
#emph[Continuum model at higher angles] --- @fig-sm-bands show the band structure for the continuum model at larger twist angles than discussed in the main text, as well as the band gaps and bandwidth. The bandwidth of the first band $W_1$ increases rapidly for $theta > theta_1 approx 1.5 degree$, reaching $W tilde 100 upright("meV")$ for $theta tilde 5 degree$--$6 degree$. The bandwidth of the second band $W_2$ has a minima at $theta approx 2.2 degree$, and remains quite small throughout the angle range $theta tilde 2 degree$--$3 degree$, with a bandwidth $W_2 approx 5 upright("meV")$. Although $epsilon_12$ vanishes at $theta_2 approx 3.3 degree$, $epsilon_23$ remains positive until $theta approx 5.4 degree$. For $1.5 degree < theta < 5.4 degree$, the top two bands are thus separated from the rest of the spectrum and form a combined $cal(C) = 2$ manifold.


// [figvision] imgs/SMBandsFig.png
// Panel a consists of five adjacent vertical subplots displaying the electronic band structure of a continuum
// model at twist angles of 3, 3.5, 4, 4.5, and 5 degrees, labeled sequentially from left to right. Each subplot
// features energy E in meV on the y-axis ranging from -200 to 25, and crystal momentum along the path Y to K+ to
// m to Y on the x-axis. The bands are rendered as solid blue curves. A vertical gray dashed line marks the K+
// point in each panel. As the angle increases, the flatness of the lowest bands near the Fermi level diminishes,
// and the overall bandwidth expands significantly, indicating that the moiré potential weakens with increasing
// twist angle. Panel b is a dual-axis line plot showing how bandwidths and indirect energy gaps vary with twist
// angle theta from 1 to 6 degrees. The left y-axis represents epsilon_12 and epsilon_23 in meV (0 to 10), while
// the right y-axis shows W_1 and W_2 in meV (0 to 100). Solid blue indicates W_1, dashed blue W_2, solid red
// epsilon_12, and dashed red epsilon_23. W_1 rises monotonically to 100 meV by 5 degrees. W_2 increases slowly
// then accelerates after 3 degrees. Both energy gaps peak around 2.5 degrees before dropping to zero by 3.5
// degrees, signaling the closure of the insulating gap as the system becomes metallic.
#figure(
  image("imgs/SMBandsFig.png", width: 100%),
  placement: top, scope: "parent",
  caption: [
    (left) Band structure of the continuum model at twist angles $theta = 3 degree$--$5 degree$, larger than shown in the main text. (right) The bandwidth $W_1 , W_2$ of the first and second bands and the indirect energy gaps between the first two bands, $epsilon_12$, and between the second and third bands $epsilon_23$.
  ],
) <fig-sm-bands>


== Supplementary Note 4
<supplementary-note-4>
#emph[Analytic magic angle] --- In this section, we analytically estimate the magic angle by consider the effective mass of the top band near $gamma$.


At $k = gamma$, when $w = V = 0$, the highest energy states are sixfold degenerate plane wave states at energy $e_0 = - frac(| gamma - kappa_(plus.minus) |^2, 2 m^(*)) = - frac(8 pi^2 theta^2, 9 m^(*) a_0^2)$, which is separated from the next set of eigenstates at $e_1 = - frac(32 pi^2 theta^2, 9 m^(*) a_0^2)$. Incorporating the effect of $w$ and $V$ will introduce coupling between these states at $e_0$, as well as with those at $e_1$ and beyond. For the purposes obtaining an analytic estimate for the magic angle, we include only this set of 6 highest energy states. This approximation is valid for $w , V lt.double e_0 - e_1$: as a rough estimate of the validity, $e_0 - e_1 approx 130 upright("meV")$ at $theta = 1.5 degree$ is an order of magnitude greater than $( V , w ) = ( 9 , 18 ) upright("meV")$ for $"WSe"_2$.


These six states consist of the plane waves at $bold(k)_j$ for $j = 1 dots.h 6$, where $ bold(k)_j = cases(
    bold(kappa)_(+) + ( cal(R)_(pi / 3) )^(j - 1) bold(delta) & upright("if j odd"),
    bold(kappa)_(-) + ( cal(R)_(pi / 3) )^(j - 1) bold(delta) & upright("if j even")
  ) $ and the $j$ odd (even) states are on the top (bottom) layer, which we label by $| j chevron.r$. Here, $bold(delta) = [ 2 pi theta / ( 3 a_0 ) ] ( sqrt(3) , - 1 )$ and $R_theta$ is a $theta$ counter-clockwise rotation matrix. The continuum Hamiltonian acts on these states as


$ cal(H)_arrow.t | j chevron.r = e_0 | j chevron.r & + V (e^(i psi) | j + 2 chevron.r + e^(- i psi) | j - 2 chevron.r)\
 & + w (| j + 1 chevron.r + | j - 1 chevron.r) + dots.h.c $


where $| j plus.minus 6 chevron.r equiv | j chevron.r$, and $dots.h.c$ contain states outside of ${ | j chevron.r }$, which we have ignored due to the large energy gap $e_1 - e_0$. Utilizing the emergent $C_6$ symmetry which sends $| j chevron.r arrow.r | j + 1 chevron.r$, $cal(H)_arrow.t$ is easily diagonalized (in the restricted subspace) by eigenstates


$ | n chevron.r = 1 / sqrt(6) sum_(j = 1)^6 e^(i n pi j / 3) | j chevron.r $


with eigenvalue $e_0 + cal(E)_n$, where


$ cal(E)_n = 2 w cos ( pi n / 3 ) + 2 V cos ( 2 pi n / 3 - psi ) . $


In the absence of any accidental degeneracy, there is a unique highest energy eigenstate $| n_0 chevron.r$.


Next, in order to estimate when $bold(gamma)$ transitions from band maxima to minima, we consider a small momentum shift about $bold(gamma)$. The $C_3$ symmetry of the microscopic model restricts the lowest order momentum dependence to be simply $frac(1, 2 m_gamma) | bold(k) - bold(gamma) |^2$ for some effective mass $m_gamma$. Thus, we consider a momentum shift $epsilon.alt hat(x)$ away from $bold(gamma)$ and work perturbatively in $epsilon.alt$. Expanding the energy $E = E^(( 0 )) + epsilon.alt^2 E^(( 2 ))$, we have that $E^(( 2 )) = 1 / ( 2 m_gamma )$, and the magic angle $tilde(theta)_m$ is where $E^(( 2 ))$ changes sign.


We expand $cal(H)_arrow.t$ as $cal(H)_arrow.t = H_0 + epsilon.alt H_1 + epsilon.alt^2 H_2$, which act on $| j chevron.r$ as


$ H_1 | j chevron.r = - frac(hat(x) dot.op ( cal(R)_(pi / 3) )^(j - 1) bold(delta), m^(*)) | j chevron.r $


and $H_2 = - frac(1, 2 m^(*))$. We have


$ hat(x) dot.op ( cal(R)_(pi / 3) )^(j - 1) bold(delta) = frac(4 pi theta, 3 a_0) sin ( j pi / 3 ) $


hence, acting on $| n chevron.r$,


$ H_1 | n chevron.r = frac(2 pi theta, 3 m^(*) a_0) (| n + 1 chevron.r + | n - 1 chevron.r) . $


Applying standard perturbation theory in the $| n chevron.r$ basis, the second order correction to the energy is


$ E^(( 2 )) = & chevron.l n_0 | H_2 | n_0 chevron.r + sum_(n eq.not n_0) frac(chevron.l n_0 | H_1 | n chevron.r chevron.l n | H_1 | n_0 chevron.r, cal(E)_(n_0) - cal(E)_n)\
= & - frac(1, 2 m^(*)) + frac(4 pi^2 theta^2, 9 m^(* 2) a_0^2) (frac(1, cal(E)_(n_0) - cal(E)_(n_0 + 1)) + frac(1, cal(E)_(n_0) - cal(E)_(n_0 - 1))) $


Solving for where $E^(( 2 )) = 0$ gives the magic angle condition from the main text,


$ tilde(theta)_m^(- 2) = frac(8 pi^2, 9 m^(*) a_0^2) (frac(1, cal(E)_(n_0) - cal(E)_(n_0 + 1)) + frac(1, cal(E)_(n_0) - cal(E)_(n_0 - 1))) $


== Supplementary Note 5
<app_wanniers>
#emph[Localized Wannier functions and tight binding model] --- In this section, we provide additional details on the construction of the Wannier states shown in the main text. We numerically diagonalize the Hamiltonian $cal(H)_arrow.t$ on an $N_k = 30 times 30$ discretization of the moiré Brillouin zone, corresponding to a system of $30 times 30$ moiré unit cells. For each $bold(k)$, the eigenstates $( | phi.alt_(n , bold(k)) chevron.r )_n$ is obtained in the plane wave basis, expressed as $| phi.alt_(n bold(k)) chevron.r = sum_(bold(g) , l) c_(bold(g) l)^(( n bold(k) )) | bold(k) + bold(g) , l chevron.r$, where $bold(g)$ are reciprocal moiré lattice vectors, $l = plus.minus$ is the layer, and $c_(bold(g) l)^(( n bold(k) ))$ are complex numbers obtained from exact diagonalization. The diagonalization is done by truncating to some maximum $| bold(k) + bold(g) |$ which is sufficiently far from the valence band top at $bold(kappa)_(plus.minus)$ so as to have negligible effect on the first few moiré bands.


Constructing Wannier states for the top two bands involves finding the appropriate $2 times 2$ unitary matrices $U_("nm")^(( bold(k) ))$ at each $bold(k)$. For convenience, we shall suppress all $bold(k)$ labels. We parameterize the unitary matrix as


$ U = mat(delim: "(", e^(i psi_1) cos ( chi / 2 ), e^(i psi_1 + i delta) sin ( chi / 2 ); e^(i psi_2 - i delta) sin ( chi / 2 ), - e^(i psi_2) cos ( chi / 2 )) , $


where $chi in [ 0 , pi ]$, and $delta , psi_1 , psi_2 in [ 0 , 2 pi ]$. As stated in the main text, $U$ is chosen to maximize the layer polarization of $| tilde(phi.alt)_n chevron.r = sum_m U_("nm") | phi.alt_m chevron.r$,


$ P = sum_(n = 1 , 2) ( - 1 )^n chevron.l tilde(phi.alt)_n | ( cal(P)_(-) - cal(P)_(+) ) | tilde(phi.alt)_n chevron.r , $


where $cal(P)_(plus.minus)$ projects to the $plus.minus$ layer. Using $cal(P)_(-) = 1 - cal(P)_(+)$, this can be simplified to


$ P & = - 2 sum_(n = 1 , 2) ( - 1 )^n chevron.l tilde(phi.alt)_n | cal(P)_(+) | tilde(phi.alt)_n chevron.r\
& = - 2 sum_(n , m , l) ( - 1 )^n chevron.l phi.alt_m | U_(m n)^dagger cal(P)_(+) U_(n l) | phi.alt_l chevron.r\
& = 2 [cos ( chi ) ( P_11 - P_22 ) + sin ( chi ) ( e^(i delta) P_12 + e^(- i delta) P_21 )] $


where $P_(n m) = chevron.l phi_n | cal(P)_+ | phi_m chevron.r = P_(m n)^*$.


It is straightforward to maximize $P$ with respect to $chi$ and $delta$. First, setting $partial_delta P = 0$ gives $delta = arg P_21 + s pi$, where $s in ( 0 , 1 )$. Then, setting $partial_chi P = 0$ gives


$ chi_s = arctan (frac(2 ( - 1 )^s | P_12 |, P_11 - P_22)) in [ 0 , pi ] $


(notice the range of $arctan$ is taken to be $[ 0 , pi ]$). The two solutions for $s = 0 , 1$ correspond to the maximum and minimum of $P$. To find the maximum, we simply compare the value of $P$ for these two solutions and take the larger one.


To determine the phase factor $psi_(1 , 2)$, we take the real space component of the wavefunction at the MX/XM stacking regions. Define $bold(r)_1 = ( a_0 / 2 theta ) [ - 1 / sqrt(3) , 1 ]$ and $bold(r)_2 = ( a_0 / 2 theta ) [ 1 / sqrt(3) , 1 ]$ to be the locations of the XM and MX stacking region. We then take the phase factors $psi_(1 , 2)$ such that $chevron.l bold(r)_n , l_n | tilde(phi.alt)_1 chevron.r$ is real and positive, where $l_(1 ( 2 )) = + ( - )$ (here, $| bold(r) , l chevron.r$ is the usual real space state at $bold(r)$ on layer $l$, satisfying $chevron.l bold(r) , l | bold(k) + bold(g) , l' chevron.r = e^(i ( bold(k) + bold(g) ) dot.op bold(r)) delta_(l l')$). This fixes the phase factors $psi_n = - arg chevron.l bold(r)_n , l_n | tilde(phi.alt)_n chevron.r$.


Finally, the Wannier functions localized at $bold(R) + bold(r)_n$, for a moiré lattice vector $bold(R)$, are defined


$ | W_(bold(R))^n chevron.r = 1 / sqrt(N_k) sum_(bold(k)) e^(- i bold(k) dot.op bold(R)) | tilde(phi.alt)_(n , bold(k)) chevron.r . $


The Wannier centers $bold(R) + bold(r)_n$ form a moiré honeycomb lattice on the XM and MX stacking regions.


The hopping matrix elements between Wannier states on the site $bold(R) + bold(r)_n$ and $bold(R)' + bold(r)_(n')$ can be obtained from the continuum Hamiltonian and $U$ matrices. We have


$ chevron.l W_(bold(R)')^(n') | cal(H)_arrow.t | W_(bold(R))^n chevron.r = 1 / N_k sum_(bold(k)) e^(i bold(k) dot.op ( bold(R)' - bold(R) )) sum_m U_(m n')^(( bold(k) ) dagger) E_m ( bold(k) ) U_(n m)^(( bold(k) )) $


where $E_m ( bold(k) )$ is the energy of $| phi.alt_(m bold(k)) chevron.r$ under $cal(H)_arrow.t$. Using this method, we compute the hopping matrix elements between $n$th nearest neighbor sites up to $n = 5$ as illustrated in @fig-hopping, and shown in the main text. We find that $t_n$ are mostly real with the exception of $t_2$, which we define (see @fig-hopping) to be the 2nd nearest neighbor hopping term along right-turning path. From the symmetries of the model, it follows that the hopping term along a left-turning path is $t_2^(*)$. The $- K$ valley produces a similar tight binding model of spin-$arrow.b$ electrons related to this one by time reversal symmetry. As a final remark, we note that the Wannier states obtained through this method are not maximally localized, thus our tight binding model has the potential to be further improved.


// [figvision] imgs/5nnHoppings.png
// Panel a: This schematic diagram illustrates hopping matrix elements on a honeycomb lattice, composed of seven
// hexagons outlined in black. A central vertex serves as the origin for five curved blue arrows representing
// electron hopping paths to neighboring vertices. The nearest-neighbor hops are labeled t1 (up-left) and t2
// (up-right). Longer-range hops extend further out: t3 points right, t4 points down-right, and t5 points
// straight down. These labels denote the specific interaction strengths within the effective tight-binding
// model.
#figure(
  image("imgs/5nnHoppings.png", width: 50%),
  caption: [
    Illustration of the hopping matrix elements $t_n$ in the effective tight binding model for spin-$arrow.t$ electrons.
  ],
) <fig-hopping>


== Supplementary Note 6
<supplementary-note-6>
#emph[Effective Spin Hamiltonian] --- The derivation of an effective spin Hamiltonian from a perturbative expansion of Eq.~6 in the limit $| t_1 | , | t_2 | lt.double Delta , U$ is rather complicated when no clear scale separation exists between $Delta$ and $U$. Fortunately in our model, the interaction scale $U$ largely dominates over the tunneling terms of $cal(H)_(upright("TB"))$, and all experimentally relevant applied displacement fields $Delta$. As a consequence, we may first eliminate all doubly occupied configurations, and then use $t_1 lt.double Delta$ to obtain the effective spin Hamiltonian given in the main text.


=== Strong coupling expansion
<strong-coupling-expansion>

Let us first fix some notations. We write the interacting Kane-Mele model as


$ cal(H)_(upright("tot")) = cal(H)_U + cal(T)_(-) + cal(T)_0 + cal(T)_(+) , $


where $cal(T)_u$ gathers all single-particle terms which change the number of doubly occupied by $u$. To get their explicit expression, we gather in $T_(delta , u)^(( 1 ))$ the nearest neighbor tunneling processes changing the number of occupied $A$ site by $delta$ and the number of doubly occupied sites by $u$, where $delta = plus.minus$ and $u = 0 , plus.minus$. A similar definition $T_(0 , u)^(( 2 ))$ applies for next-nearest neighbor hoppings. These definition yield


$ cal(T)_0 & = cal(H)_Delta + T_(0 , 0)^(( 2 )) + T_(+ , 0)^(( 1 )) + T_(- , 0)^(( 1 )) ,\
cal(T)_plus.minus & = T_(0 , plus.minus)^(( 2 )) + T_(+ , plus.minus)^(( 1 )) + T_(- , plus.minus)^(( 1 )) . $


Elimination of doubly occupied configurations is achieved by standard perturbation theory techniques, see for instance Ref.~@stein1997flow, and gives


$ cal(H)_(upright("tot"))^U & = cal(T)_0 - 1 / U cal(T)_(-) cal(T)_(+)\
 & = cal(H)_Delta + tilde(cal(T))_(- 2) + tilde(cal(T))_(- 1) + tilde(cal(T))_0 + tilde(cal(T))_(+ 1) + tilde(cal(T))_(+ 2) , $ <appeq_EliminateU>


that we have recast in a form more amenable to perturbative expansion in $Delta$ by introducing


$ tilde(cal(T))_0 & = T_(0 , 0)^(( 2 )) - 1 / U [T_(0 , -)^(( 2 )) T_(0 , +)^(( 2 )) + T_(+ , -)^(( 1 )) T_(- , +)^(( 1 )) + T_(- , -)^(( 1 )) T_(+ , +)^(( 1 ))] ,\
tilde(cal(T))_(plus.minus 1) & = T_(plus.minus , 0)^(( 1 )) - 1 / U [T_(0 , -)^(( 2 )) T_(plus.minus , +)^(( 1 )) + T_(plus.minus , -)^(( 1 )) T_(0 , +)^(( 2 ))] ,\
tilde(cal(T))_(plus.minus 2) & = - 1 / U T_(plus.minus , -)^(( 1 )) T_(plus.minus , +)^(( 1 )) . $


Similar to the previous case, $tilde(cal(T))_delta$ changes the number of occupied $A$ sites by $delta$. When their potential energy is large $t_1 lt.double Delta$, these $A$-sites can be eliminated in a similar way as before, see Ref.~@knetter2000perturbation for details. This leads to the following effective Hamiltonian in the physical subspace with no double occupations and no occupied $A$ sites:


$  & cal(H)_(upright("tot"))^(U Delta) = tilde(cal(T))_0 - 1 / Delta tilde(cal(T))_(- 1) tilde(cal(T))_(+ 1) - frac(1, 2 Delta) tilde(cal(T))_(- 2) tilde(cal(T))_(+ 2)\
 & + frac(1, 8 Delta^2) [8 tilde(cal(T))_(- 1) tilde(cal(T))_0 tilde(cal(T))_(+ 1) + 4 (tilde(cal(T))_(- 1) tilde(cal(T))_(- 1) tilde(cal(T))_(+ 2) + tilde(cal(T))_(- 2) tilde(cal(T))_(+ 1) tilde(cal(T))_(+ 1))\
 & #h(2em) quad - 4 (tilde(cal(T))_(- 1) tilde(cal(T))_(+ 1) tilde(cal(T))_0 + tilde(cal(T))_0 tilde(cal(T))_(- 1) tilde(cal(T))_(+ 1)) + 2 tilde(cal(T))_(- 2) tilde(cal(T))_0 tilde(cal(T))_(+ 2)\
 & #h(2em) quad - (tilde(cal(T))_(- 2) tilde(cal(T))_(+ 2) tilde(cal(T))_0 + tilde(cal(T))_0 tilde(cal(T))_(- 2) tilde(cal(T))_(+ 2))] + dots.h.c $


This expression can be greatly simplified by noticing that the direct action of $T_(plus.minus , plus.minus)^(( 1 ))$ and $T_(0 , 0)^(( 2 ))$ is zero on the physical space with no double occupancy and no occupied $A$ sites. Furthermore, all terms of order $U^(- 2)$ should be discarded for consistency with our first expansion #ref(<appeq_EliminateU>). Using these insights, we obtain


$ cal(H)_(upright("tot"))^(U Delta) & = - 1 / U T_(0 , -)^(( 2 )) T_(0 , +)^(( 2 )) - 1 / Delta T_(- , 0)^(( 1 )) T_(+ , 0)^(( 1 )) + 1 / Delta^2 T_(- , 0)^(( 1 )) T_(0 , 0)^(( 2 )) T_(+ , 0)^(( 1 ))\
 & + frac(1, U Delta) [T_(- , 0)^(( 1 )) T_(+ , -)^(( 1 )) T_(0 , +)^(( 2 )) + T_(0 , -)^(( 2 )) T_(- , +)^(( 1 )) T_(+ , 0)^(( 1 ))]\
 & - frac(1, U Delta^2) T_(- , 0)^(( 1 )) T_(+ , -)^(( 1 )) T_(- , +)^(( 1 )) T_(+ , 0)^(( 1 )) + P $


where we have isolated the contribution


$ P = frac(1, U Delta^2) [frac(T_(- , 0)^(( 1 )) T_(+ , 0)^(( 1 )) T_(0 , -)^(( 2 )) T_(0 , +)^(( 2 )), 2) - T_(- , 0)^(( 1 )) T_(0 , 0)^(( 2 )) T_(+ , -)^(( 1 )) T_(0 , +)^(( 2 )) + h c] $


that we from now on neglect since its magnitude $| t_1 t_2 |^2 / ( U Delta^2 )$ is much smaller than the other terms appearing in $cal(H)_(upright("tot"))^(U Delta)$ when $| t_2 | lt.double | t_1 |$, as is the case for our effective tight-binding model (see~@app_wanniers).


Discarding an overall energy shift, we can rewrite the Hamiltonian derived above as


$ cal(H)_S = & - 1 / U [T_(0 , -)^(( 2 )) - 1 / Delta T_(- , 0)^(( 1 )) T_(+ , -)^(( 1 ))] [T_(0 , +)^(( 2 )) - 1 / Delta T_(- , +)^(( 1 )) T_(+ , 0)^(( 1 ))]\
 & + 1 / Delta^2 T_(- , 0)^(( 1 )) T_(0 , 0)^(( 2 )) T_(+ , 0)^(( 1 )) . $ <appeq_brutspinhamiltonian>


The first line simply describes the virtual occupation of a doubly excited state using the bare or an effective next-nearest tunneling, while the second line corresponds to a particle exchange process where particle turn around a small loop of the honeycomb lattice to avoid double occupations. They are sketched in @fig-tunneling-processes.


It is worth noting here that the terms obtained in $cal(H)_S$ are simply those one would have guessed without decoupling the $U$ and $Delta$ expansions. This is however only due to the facts that the operators $tilde(cal(T))_(plus.minus 2)$ are zero in the physical space considered in our model. This is why we have preferred the more lengthy, but more reliable, method presented here.


// [figvision] imgs/TunnelingProcesses.png
// Panel a) is a schematic diagram illustrating a first-order perturbation process labeled t. It features a
// hexagonal lattice outline with gray circles at three vertices: top-left, mid-right, and bottom-center. A black
// arrow points outward from the top vertex. Two blue curved arrows represent hopping events labeled t1; the
// first connects the mid-right site to the bottom-right corner, and the second connects the top vertex to the
// mid-right site. A red straight arrow labeled t2 extends diagonally from the top vertex to the bottom-right
// corner. Numbered circles indicate the sequence of steps. Panel b) is a schematic diagram representing a
// second-order process labeled t^2/U on the same hexagonal lattice structure. The gray circles and the initial
// black arrow at the top remain consistent with panel a). This panel depicts two magenta curved arrows forming a
// loop between the top vertex and the bottom-right corner. The downward path is labeled with a tilde-t symbol,
// while the upward return path is labeled with a tilde-t-star symbol. Both paths terminate or originate at black
// arrows indicating directionality at the respective vertices. Panel c) is a schematic diagram showing a third
// multi-tunneling process labeled t1^2*t2/Delta^2. The layout mirrors previous panels with the hexagon and
// specific gray circle positions. A red diagonal arrow labeled t2-star connects the top vertex to the
// bottom-right corner. Two blue curved arrows labeled t1 follow the perimeter edges, connecting the top vertex
// to the mid-right site and then to the bottom-right corner. Black arrows indicate flow directions at the start
// and end points. Numbered circles denote the order of the tunneling events.
#figure(
  image("imgs/TunnelingProcesses.png", width: 88%),
  caption: [
    Multi-tunneling processes appearing in the perturbation expansion for large displacement field and large interaction scale. a) Effective tunneling $tilde(t) = t_2 + t_1^2 / Delta$ on the $B$ triangular lattice after elimination of the $A$ site with large potential energy. b) Spin exchange $prop tilde(t)^2 / U$ between localized spins. c) Additional loop exchange $prop t_1^2 t_2 / U$ process which does not involve any double occupations. The choice of $t_2$/$t_2^(*)$ in the diagrams applies to spin-up electrons. Grey circles denote doubly occupied $B$ sites, while arrows represents the spin of the holes on $A$ sites.
  ],
) <fig-tunneling-processes>


=== Rewriting with spin operators
<rewriting-with-spin-operators>

Introducing the effective tunneling $tilde(t) = t_2 + t_1^2 / Delta$, we can rewrite the first line of #ref(<appeq_brutspinhamiltonian>) as


$ 4 / U sum_(chevron.l i , j chevron.r_B) | tilde(t) |^2 s_i^z s_j^z + upright("Re") thin ( tilde(t)^2 ) ( s_i^x s_j^x + s_i^y s_j^y ) + upright("Im") thin ( tilde(t)^2 ) ( bold(s)_i times bold(s)_j ) dot.op bold(z) $


which corresponds to the processes sketched in #ref(<fig-tunneling-processes>)a and #ref(<fig-tunneling-processes>)b. With a similar calculation, we can recast the second line as


$ frac(4 t_1^2, Delta^2) sum_(chevron.l i , j chevron.r_B) upright("Re") thin ( t_2 ) bold(s)_i dot.op bold(s)_j + upright("Im") thin ( t_2 ) ( bold(s)_i times bold(s)_j ) dot.op bold(z) , $


which is sketched in #ref(<fig-tunneling-processes>)c. Putting everything together, we obtain an XXZ model with Dzyaloshinskii--Moriya interactions for the spin localized on the triangular $B$ lattice:


$ cal(H)_S = sum_(chevron.l i , j chevron.r_B) J_parallel s_i^z s_j^z + J_perp ( s_i^x s_j^x + s_i^y s_j^y ) + D [( bold(s)_i times bold(s)_j ) dot.op bold(z)] , $ <appeq_spinmodels>


where the coefficients read


$ J_parallel & = frac(4 | tilde(t) |^2, U) + upright("Re") (frac(4 t_1^2 t_2, Delta^2)) ,\
J_perp & = upright("Re") (frac(4 tilde(t)^2, U) + frac(4 t_1^2 t_2, Delta^2)) ,\
D & = upright("Im") (frac(4 tilde(t)^2, U) + frac(4 t_1^2 t_2, Delta^2)) . $


This is the form used in the main text.


=== Classical phase diagram
<classical-phase-diagram>

The phases appearing for large displacement fields in our Hartree-Fock study (Fig. 5 in the main text) can be rationalized by studying the classical version of #ref(<appeq_spinmodels>). Treating the spins as classical vectors of fixed lengths and imposing the 'weak constraint' of Luttinger-Tisza~@LuttingerTisza, the spin model can be exactly solved in momentum space.


We find spin eigenstates with spin polarized along $bold(z)$ with the dispersion


$ E_z ( bold(k) ) = J_parallel C ( bold(k) ) , $


and two other with spins pined in the $x y$ plane


$ E_(x y)^plus.minus ( bold(k) ) = J_perp C ( bold(k) ) plus.minus | D S ( bold(k) ) | , $


where we have introduced the two auxiliary functions


$ C ( bold(k) ) = sum_(j = 1)^3 cos ( bold(k) dot.op bold(a)_j ) , quad S ( bold(k) ) = sum_(j = 1)^3 sin ( bold(k) dot.op bold(a)_j ) , $


with $bold(a)_3 = - ( bold(a)_1 + bold(a)_2 )$. The competition between the out of plane and in-plane modes was studied beyond the classical approximation with the ED spin-wave analysis (see main text). Thus, we discard the $E_z$ eigenstates and look for spin patterns that minimize $E_(x y)^plus.minus$.


Depending on $J_perp$ and $D$, the minimum of $E_(x y)^(-)$ is either at the $gamma$ point or at $kappa_(plus.minus)$, which respectively describe the $"FM"_(x y)$ and $"AFM"_(x y)$ phases of the main text, after reintroduction of Luttinger-Tisza's 'strong constraint'~@LuttingerTisza. Comparison of the energies at these three momenta give the conditions


$ cases(
    upright("FM")_(x y) : & | D | + sqrt(3) J_perp < 0 ,,
    upright("AFM")_(x y) : & | D | + sqrt(3) J_perp > 0 .
  ) $

#bibliography("refs_supp.bib", title: none)