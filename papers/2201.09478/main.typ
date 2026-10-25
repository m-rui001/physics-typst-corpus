// Dynamic Signatures of Non-Hermitian Skin Effect and Topology in Ultracold Atoms
// Hand conversion of src/coldatomskinexp20220725.tex (revtex4-2, PRL).
// References rebuilt entry-by-entry from src/coldatomskinexp20220725.bbl.

#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#show math.equation.where(block: true): set align(center)

#place(top, float: true, scope: "parent", clearance: 1.2em)[
#block(spacing: 1em, align(center)[
  #set text(size: 16pt, weight: "bold")
  Dynamic Signatures of Non-Hermitian Skin Effect and Topology in Ultracold Atoms
])

#block(spacing: 0.6em, align(center)[
  #set text(size: 11pt)
  Qian Liang#super[1,\*], Dizhou Xie#super[1,\*], Zhaoli Dong#super[1,\*],
  Haowei Li#super[2,3], Hang Li#super[1], Bryce Gadway#super[4],
  Wei Yi#super[2,3,†], and Bo Yan#super[1,‡]
])

#block(spacing: 1em, align(center)[
  #set text(size: 8.5pt)
  #super[1] Interdisciplinary Center of Quantum Information, State Key Laboratory of Modern
  Optical Instrumentation, Zhejiang Province Key Laboratory of Quantum Technology and Device,
  Department of Physics, Zhejiang University, Hangzhou 310027, China \
  #super[2] CAS Key Laboratory of Quantum Information, University of Science and Technology of
  China, Hefei 230026, China \
  #super[3] CAS Center For Excellence in Quantum Information and Quantum Physics,
  Hefei 230026, China \
  #super[4] Department of Physics, University of Illinois at Urbana-Champaign,
  Urbana, IL 61801-3080, USA \
  #super[\*] These authors contributed equally to this work \
  #super[†] wyiz\@ustc.edu.cn \
  #super[‡] yanbohang\@zju.edu.cn
])

#block(spacing: 1em, inset: (x: 1.5em))[
  The non-Hermitian skin effect (NHSE), the accumulation of eigen wavefunctions at boundaries of
  open systems, underlies a variety of exotic properties that defy conventional wisdom. While NHSE
  and its intriguings impact on band topology and dynamics have been observed in classical or
  photonic systems, their demonstration in a quantum gas system remains elusive. Here we report the
  experimental realization of a dissipative Aharonov-Bohm chain---a non-Hermitian topological model
  with NHSE---in the momentum space of a two-component Bose-Einstein condensate. We identify
  signatures of NHSE in the condensate dynamics, and perform Bragg spectroscopy to resolve
  topological edge states against a background of localized bulk states. Our work sets the stage
  for further investigation on the interplay of many-body statistics and interactions with NHSE,
  and is a significant step forward in the quantum control and simulation of non-Hermitian
  physics.
]
]

A quantum system coupled to its environment generally suffers from particle loss and decoherence,
thus exhibiting qualitatively different phenomena from an isolated conservative system. Much
insight can be obtained of these open quantum systems by resorting to a non-Hermitian
description ~@QJ ~@uedareview, under which a wealth of intriguing features naturally emerge,
including parity-time symmetry and spectral singularity ~@ptbender ~@ptreview1 ~@ptreview2
~@ptreview3, non-reciprocal and chiral transport ~@nonrecNature, as well as non-Hermitian
topology and unconventional band theory ~@nonHtopo1 ~@nonHtopo2 ~@WZ1 ~@murakami. Within this
context, a particularly fascinating phenomenon is the recently discovered non-Hermitian skin
effect (NHSE) ~@WZ1 ~@murakami ~@WZ2 ~@ThomalePRB ~@Budich ~@mcdonald ~@alvarez
~@fangchenskin ~@kawabataskin ~@stefano ~@yzsgbz ~@tianshu ~@lli ~@Zhou2021 ~@Guo2021.
Through what transpires as the nominal bulk eigenstates undergo exponential localization at the
open boundaries, the NHSE fundamentally reshapes spectral, band, and dynamic properties of an open
system, necessitating a non-Bloch band theory to account for the non-Hermitian topology ~@WZ1
~@murakami ~@WZ2, and leaving signatures in the dynamics either driven by a non-Hermitian
effective Hamiltonian ~@stefano ~@tianyuquench or under the master equation ~@wzopen
~@stefanoopen. While the recent observation of NHSE and its rich consequences have stimulated
intense interest ~@teskin ~@photonskin ~@XDW-21 ~@metaskin ~@teskin2d ~@scienceskin, its
experimentals implementation in quantum gases remains unexplored.

In this work, we experimentally realize a non-Hermitian topological Hamiltonian with NHSE in a
momentum lattice of ultracold atoms ~@Meier2016 ~@Meier2018 ~@Lapp2019 ~@Xie2019. Specifically,
we engineer a chain of coupled Aharonov-Bohm (AB) rings along a synthetic momentum lattice with a
Bose-Einstein condensate of #super[87]Rb atoms ~@Xie2018 ~@yanring ~@Chen2021. We experimentally
implement a chain of five unit cells with open boundary condition (OBC), and identify signatures of
the NHSE through the condensate dynamics. In particular, our measurements confirm the presence of
a directional bulk flow, which drives eigenstates toward boundaries under the OBC and has been
identified as the origin of the NHSE ~@stefano ~@fangchenskin ~@kawabataskin. For our
finite-size system, the bulk dynamics is realized by initializing the condensate in a central site
and probing the dynamics before atoms propagate to the boundary. In contrast, to resolve
topological edge states amongst the similarly localized bulk modes, we perform the Bragg
spectroscopy at the edge of the AB chain to probe its eigenspectrum. The spectroscopy reveals the
emergence of in-gap edge states as the parameters are tuned, consistent with the theoretically
predicted non-Bloch topological phase transition. Given their flexible tunability and many-body
nature, cold atomic gases offer an enticing platform wherein thes impact of NHSE on a wide variety
of physical phenomena can be systematically explored in the future.

#place(top + center, scope: "parent", float: true)[
// [figvision] src/fig1.png
// (a) 3D schematic of the synthetic lattice: a grey tube labelled "Reservoir" runs above
//     a zig-zag chain of grey "omega"-shaped cavity sites. Coloured triangle clusters
//     (blue site a, red site b, green site c, plus a fourth blue site) sit on the chain;
//     red rods mark the intra-cell couplings J_t (a-b), J_s (b-c), J_p (a-c triangle side)
//     and the inter-cell coupling J_r (dotted dashed arrow). An orange arrow marks the
//     synthetic flux Phi through each triangular loop (orange ellipse drawn on the plane).
//     Black axes at lower left: "internal state dimension" F=1 to F=2; black arrow along
//     the chain: "momentum-space dimension".
// (b) Level scheme. Two sinusoidal bands versus momentum p (2 hbar k), -3..3: green
//     curve F=2, m_F=0 and blue curve F=1, m_F=0, separated by 6.8 GHz. Dotted vertical
//     lines mark the discrete momentum sites -3..3; narrow grey peaks at each site
//     indicate the Raman-Bragg coupling. Two horizontal bars at the top: 5^2P_1/2 and
//     5^2P_3/2, separated by 30 GHz; a purple arrow from the F=2 band to 5^2P_3/2 and a
//     wavy purple arrow from 5^2P_3/2 to 5^2P_1/2 indicate the 780/776 nm Raman pair.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure(
 image("src/fig1.png", width: 12cm),
  caption: [
    Topological Aharonov-Bohm chain with NHSE. (a) Schematic illustration of the Aharonov-Bohm
    chain. Each unit cell includes three sites ($a$, $b$, $c$), forming a closed triangular loop.
    Site $c$ is further coupled to a reservoir that introduces dissipation to the system. While
    hopping rates $J_(p,t,r,s)$ are induced by Raman or Bragg processes, their phases contribute to
    a synthetic magnetic flux $phi$ through each ring. (b) The momentum lattice in (a) is generated
    by multi-frequency Raman and Bragg processes that couple discrete momentum and hyperfine states
    (both with $m_F = 0$) in the $F = 1$ and $F = 2$ manifolds of #super[87]Rb atoms. Within each unit
    cell, sites $(a, c)$ and $(b, c)$ are coupled through resonant Raman processes, with a momentum
    difference $2 ℏ k$; while sites $(a, b)$ are coupled through a four-photon resonant Bragg
    process, with a momentum difference of $4 ℏ k$. Here $k$ is the wave vector of a 795 nm laser.
    Subsequently, in the $n$th unit cell ($n in ZZ$), sites $a$ and $b$ represent the momentum
    states $|p = 3n⟩$ and $|p = 3n+2⟩$ (in units of $2 ℏ k$), respectively, of the hyperfine ground
    state $|F = 1, m_F = 0⟩$ in the $""^5 S_(1/2)$ manifold. Site $c$ is encoded into the momentum
    state $|p = 3n+1⟩$ of the hyperfine ground state $|F = 2, m_F = 0⟩$. Dissipation is induced by
    a near-resonant coupling of atoms on site $c$ to the $""^5 P_(3/2)$ manifold.
  ]
) <fig:model>
]

#emph[Experimentals implementation.] Our experimental setup is illustrated in @fig:model.
Each unit cell of the AB chain consists of a triangular loop of three sublattice sites ($a$, $b$,
$c$), which are encoded in the combined synthetic dimensions of the ground-state hyperfine states
($|F = 1, m_F = 0⟩$ for sites $a$, $b$, and $|F = 2, m_F = 0⟩$ for site $c$) and atomic momentum.
While adjacent sites are coupled via Raman or Bragg transitions [see @fig:model(b)], a
synthetic magnetic flux (denoted as $phi$) through the rings can be generated and controlled
through the phases of the coupling lasers. Dissipation is introduced at the vertex of the unit
cells, as atoms on site $c$ are state-selectively coupled to electronically excited states in the
$5^2 P_(3/2)$ manifold, and subsequently lost from the system through spontaneous emission.

For atoms that remain in the dissipative AB chain, their dynamics is effectively driven by a
non-Hermitian Hamiltonian ~@supp

$ H = sum_n (Delta - i gamma) c_n^dagger c_n + sum_n [(J_p b_n^dagger a_n
  + J_t a_(n+1)^dagger b_n + J_s e^(i phi) c_n^dagger a_n\
  + J_r c_n^dagger b_n) + "H.c."], $ <eq:ham>

where $a_n^dagger$ ($a_n$), $b_n^dagger$ ($b_n$) and $c_n^dagger$ ($c_n$) are respectively the
creation (annihilation) operators for sublattice sites $a$, $b$ and $c$ of the $n$th unit cell. In
the following, we denote the corresponding states as $|n, a⟩$, $|n, b⟩$, and $|n, c⟩$,
respectively. The laser-induced hopping rates $J_(p,t,r,s)$ between adjacent sites are illustrated
in @fig:model(a), where the phase $phi$ corresponds to the synthetic magnetic flux through
the ring. The laser-induced dissipation on site $c$ is characterized by the effective loss term
$gamma$, and an on-site energy offset $Delta$ is present if the Raman-Bragg coupling to site $c$
is detuned. All these parameters are easily tunable, thanks to the flexible control afforded by
the momentum-lattice engineering ~@supp.

In each experiment, we start with a #super[87]Rb Bose-Einstein condensate in an optical dipole trap with
a typical atom number of $1 times 10^5$. The dipole trap frequencies are $approx 2 pi times
(40, 100, 115)$ Hz. The Raman-Bragg lasers ares imposed along the weak-trapping direction to
construct the momentum lattice ~@supp. For detection, we turn off the optical dipole trap and all
the Raman-Bragg lasers, and take an absorption image after a 20 ms time-of-flight. In this way,
atoms in different momentum states are separated and we can extract the atom population in
different momentum states.

#place(top + center, scope: "parent", float: true)[
// [figvision] src/fig2.png
// Four colour maps (a)-(d) of normalized atom population versus momentum index n
// (horizontal, -2.5..2.5) and time (vertical, 0..0.7 ms, increasing downwards).
// Shared colour bar at right: population 0.1 (dark blue) to 1.0 (dark red), jet scale.
// Each panel shows a set of vertical stripes (one per n) whose brightness oscillates
// with time, tracing the bulk dynamics:
// (a) non-Hermitian, initial |n=0,a>: oscillation between n=0 (brightest at t=0, fading)
//     and n=-1/-2 stripes that brighten over 0-0.3 ms, then n=0 partially revives;
//     visible n=+1,+2 stripes at early times.
// (b) non-Hermitian, initial |n=0,b>: strong n=0 stripe plus a bright n=+1 stripe and a
//     weaker n=-1; population drifts towards positive n at late times.
// (c) Hermitian, initial |n=0,a>: symmetric spreading to both +-1, +-2 with a pronounced
//     oscillation; n=0 remains dominant.
// (d) Hermitian, initial |n=0,b>: symmetric spread, n=+1 bright, n=+-1 revival near
//     t~0.5 ms. Contrast between (a)/(b) and (c)/(d) is the directional (non-Hermitian)
//     flow.
#figure(
 image("src/fig2.png", width: 12cm),
  caption: [
    Bulk dynamics along the momentum lattice, where we show the normalized atom population for each
    sublattice site. (a)(b) are the non-Hermitian cases with $gamma = h times 1.3(2)$ kHz; (c)(d)
    are the Hermitian cases with $gamma = 0$. Atoms are initially prepared in the state
    $|n = 0, a⟩$ in (a)(c), and $|n = 0, b⟩$ in (b)(d). The color bar indicates the atom population
    in each sublattice site, normalized by the initial atom number and shown in the order
    $|n, a⟩$, $|n, c⟩$, $|n, b⟩$ (from left to right) for a given unit cell $n$. The experimental
    parameters are $\{J_s, J_r, J_p, J_t\} = h times \{1.07(2), 1.07(1), 0.65(3), 0.81(1)\}$ kHz,
    $phi = -pi/2$, and $Delta = 0$.
  ]
) <fig:typical>
]

#place(top + center, scope: "parent", float: true)[
// [figvision] src/fig3.png
// Six panels (a)-(f) of the measured growth rate lambda-bar (vertical, -6..0) versus
// synthetic flux parameter v (horizontal, -5..5). Blue filled circles with vertical
// error bars = experiment; red triangles = simulation; grey solid curve = theory.
// (a) phi = -pi/2: experiment peaks near 0 at v=0, falls to about -3 at v=+5;
//     simulation follows but dips to -5.5 at v=+5 - the strongest asymmetry.
// (b) phi = -pi/3: similar asymmetric trend, experiment -2.5 -> -3, simulation
//     reaching -4.5 at v=+5.
// (c) phi = 0: symmetric parabola-like dependence, maximum ~0 at v=0, about -3 at
//     v=+-5 for data, theory slightly lower.
// (d) phi = +pi/2: mirror of (a); growth rate rises towards 0 at v=+5, -3 at v=-5;
//     simulation dips to -5.8 at v=-5.
// (e) phi = +pi/3: mirror of (b) with data between -1 and -3 and theory -2.5 at v=-5.
// (f) gamma = 0, phi = 0: nearly flat around -2.5 to -3 across v (Hermitian case), grey
//     theory curve peaking at 0. Legend at lower right (simulation triangles, experiment
//     circles).
#figure(scope: "parent", 
 image("src/fig3.png", width: 15cm),
  caption: [
    Signatures of the NHSE. (a)(b)(c)(d)(e) Measured growth rate $bar(lambda)$ with a fixed
    $gamma = h times 1.3(2)$ kHz, and varying synthetic flux $phi$. (f) $bar(lambda)(v)$ with
    $phi = 0$ and $gamma = 0$ and an evolution time of 0.4 ms. The blue dots are the experimental
    data, and the error bar represents SE of the mean. The solid lines are numerical results using
    the effective Hamiltonian for a lattice with $N = 221$ unit cells. The red triangles are
    numerical simulations using the experimental parameters. For all panels, the hopping rates are
    $\{J_s, J_r, J_p, J_t\} = h times \{1.13(2), 1.04(1), 0.62(4), 0.80(2)\}$ kHz, and
    $Delta = 0$.
  ]
) <fig:Lp>
]

#emph[Dynamic signatures of NHSE.] Hamiltonian @eq:ham hosts the NHSE, and can be topologically
non-trivial under appropriate parameters ~@supp. In our setup, NHSE can be understood as arising
from the non-reciprocity of the underlying dissipative AB rings ~@yanring. As a result of the
interplay of the synthetic flux and dissipation, a unidirectional current emerges in the bulk,
leading to the accumulation of population at boundaries under OBC, and forming the basis for the
dynamic detection of NHSE. Note that such a directional bulk current is also closely related to the
spectral topology of the Hamiltonian ~@fangchenskin ~@supp.

We begin by experimentally confirming the presence of the directional bulk current. In
@fig:typical, we fix the synthetic flux $phi = -pi/2$, and show typical bulk dynamics, in
terms of the time-evolution of the momentum-space atomic distribution, for condensates initialized
in the states $|n = 0, a⟩$ and $|n = 0, b⟩$, respectively. We focus on the condensate dynamics up
to $t = 0.7$ ms, when atoms have not yet evolved to the edges. As demonstrated in
@fig:typical(a)(b), the condensate propagates to the left in the presence of dissipation,
regardless of the initial state. By contrast, in the Hermitian case [@fig:typical(c)(d)],
the direction of propagation is dependent on the initial sublattice state. The observation above
indicates the presence of a non-reciprocal bulk flow with the onset of dissipation.

For a more quantitative characterization, we define a growth rate ~@stefano ~@lyaexp.

$ lambda(v,t) = (log |psi(n,t)|) / t, $ <eq:lambda>

where $psi(n,t)$ is the time-evolved wave function on the unit cell $n = v t$, and $v$ is the
shift velocity. Under NHSE, the growth rate peaks at a finite shift velocity $v_m$, after a finite
time of evolution. Intuitively, $v_m$ reflects the speed of propagation for the peak of a wave
packet initialized at $n = 0$. Thus, a finite $v_m$ is a clear indication of the direction and
strength of the bulk flow.

To ensure that the initial-state dependence of the condensate propagation in @fig:typical is
averaged out, we measure the mean growth rate $bar(lambda) = (lambda_a + lambda_b) / 2$, where
$lambda_(a,b)$ are the corresponding growth rates for condensates initialized in states
$|n = 0, a⟩$ and $|n = 0, b⟩$, respectively.

In @fig:Lp, we show measurements of $bar(lambda)$ for an evolution of $t = 0.4$ ms, with
varying flux $phi$. Under a finite flux, all measured growth rates peak at finite shift
velocities, where the sign of $v_m$ indicates the direction of the bulk flow. Under OBC, the flow
direction is consistent with that of the boundary where eigen wavefunctions accumulate ~@supp.
These measurements are in sharp contrast to the Hermitian case of @fig:Lp(f), where
$bar(lambda)$ peaks at $v_m = 0$, and is symmetric with respect to the peak. Note that the small
asymmetry with regard to $v = 0$, as observed in @fig:Lp(c), comes from a remnant flux due
to experimentalsimperfections. Given its dependence on the flux and loss $gamma$, the observed
directional flow serves as a clear signature for the NHSE in ours implemented model.

#place(top + center, scope: "parent", float: true)[
// [figvision] figures/fig5_d.png
// Panel (d): real part of the eigenenergy Re(E)/J_p (vertical, -1..4.5) versus
// J_t/J_p (horizontal, 0..2.5). Red solid curve = simulation with a pink band (spread
// of the simulated spectrum); blue vertical error bars with dots = experiment.
// Two branches are visible: an upper branch starting at ~2.2 that stays flat to
// J_t/J_p~1, then drops through an exceptional-point cusp to ~1.2 and becomes flat
// again; a lower branch starting near 0.2 that rises to meet it at the cusp (~1.0),
// after which both branches are near-degenerate around 1.2. The pink band pinches to
// zero width at the cusp near J_t/J_p = 1.0. Grey arrows mark parameter points b
// (J_t/J_p ~ 0.34) and c (~2.27).
// Inset: kappa (0..2, vertical) versus J_t/J_p (0..2): purple points with error bars,
// starting near 1.8 at J_t/J_p=0, falling to 0.6 at 1, and to 0 for J_t/J_p >= 1.5;
// a grey dashed line at kappa=1 guides the eye.
// [figvision] figures/fig5_bc.png
// Panels (b),(c): detected fraction P_d (vertical, 0.4..0.9) versus detuning delta (kHz,
// horizontal, -2..4.5). Grey dots with vertical error bars, blue double-Gaussian fit.
// (b) J_t/J_p = 0.34: two resolved dips, near delta ~0.2 kHz (P_d ~0.62) and
//     delta ~2.6 kHz (P_d ~0.63), with a local maximum ~0.7 between them at 1.2 kHz;
//     P_d ~0.82 away from resonance.
// (c) J_t/J_p = 2.27: a single broad dip centred at delta ~1.6 kHz reaching P_d ~0.52;
//     P_d ~0.80 at the wings.
#figure(placement: auto, 
  grid(columns: (1fr, 1fr), column-gutter: 0.6em, align: horizon,
    [#include "figures/fig5a.cetz.typ"],
    grid.cell(rowspan: 2, image("figures/fig5_d.png", width: 100%)),
    image("figures/fig5_bc.png", width: 100%),
  ),
  caption: [
    Topological edge states through the Bragg spectroscopy. (a) Schematic illustration of the
    Bragg spectroscopy. (b)(c) show typical experimental data (dots) of the Bragg spectrum, with
    $J_t / J_p = 0.34$ in (b) and $J_t / J_p = 2.27$ in (c). The solid lines are from the
    double-Gaussian fit. Other experimental parameters are $\{J_s, J_r, J_p\} = h times
    \{1.08(2), 1.02(3), 1.21(3)\}$ kHz, $gamma = h times 1.0(1)$ kHz, $phi = -pi/2$. An energy
    offset $Delta = -h times 2.0(3)$ kHz on site $|n, c⟩$ is alsos imposed to reduce itss impact on
    the topological gap. (d) Real components of the eigenspectrum (grey shaded), spectroscopic
    measurements (blue strips), and numerical simulations (red curves and shade). The band center
    is shifted from zero due to the light shift of the four-photon process ~@supp. The red curves
    and shade respectively indicate the valley location and width of the numerically simulated
    spectra. The blue strips are determined by fitting the experimental data: the length of each
    strip corresponds to $2w$, and the blue dots indicate valley locations, calculated from
    $delta_0$ and $Delta delta$ (see main text for definition). The insert of (d) shows the
    distance-to-width ratio $r$ with increasing $J_t / J_p$, where the dashed horizontal line
    indicates the location of the phase transition with $r = 1$. Error bars show the SE of the
    mean.
  ]
) <fig:energy>
]

#emph[Resolving topological edge states.] A unique challenge for non-Hermitian topological models
with NHSE is the detection of topological phase transitions. In topological models without NHSE,
the transition can be probed by detecting topological edge states. However, this becomes difficult
under NHSE, when all eigen wavefunctions are localized at the boundary along with the topological
edge states. Here we adopt a Bragg spectroscopy with simultaneous spectral and spatial resolution
to detect the topological edge states.

As shown in @fig:energy(a), we prepare the condensate in an auxiliary momentum-lattice site,
labeled $|d⟩$ and encoded in the $|F = 1, m_F = 0⟩$ manifold. We then transfer atoms into the
dissipative AB chain by switching on a weak coupling ($approx h times 0.2$ kHz) between site $|d⟩$
and one edge of the lattice for a duration of 1 ms. We measure the probability $P_d$ for atoms to
remain in $|d⟩$, while we vary the detuning $delta$ of the coupling. Here $P_d$ is obtained by
dividing the atom number of $|d⟩$ at the end of the Bragg coupling with the initial atom number.
Note that during the 1 ms probe time, the edge-most three unit cells become occupied ~@supp.
Since the average localization length under the NHSE is of the same order [for instance $approx
3.56$ under the parameters of @fig:energy(b)] ~@supp, the measurement is expected to reveal
the global spectral information.

In @fig:energy(b)(c), we show typical spectroscopic data in the topologically trivial and
non-trivial phases, respectively. A double-valley structure in the topologically trivial phase
indicates the presence of two bands, where state $|d⟩$ is resonantly coupled to the bulk states.
In comparison, only a single valley exists in the topologically non-trivial phase, where $|d⟩$ is
resonantly coupled to the topological edge states. The valley location indicates the real
eigenenergy component of the edge states. While the real energy gap between the two topological
edge states does not close in our finite-size system, the single valley appears when the gap
becomes smaller than the experimental resolution.

We fit the measured spectra using a double-Gaussian function

$ P_d = A [e^(-(delta - delta_0)^2 / (2 w^2))
  + e^(-(delta - delta_0 - Delta delta)^2 / (2 w^2))], $ <eq:fit>

In @fig:energy(d), we show the fitted widths (half the length of the blue strips) and valley
locations (blue dots) from experimental measurements. While the experimental results are consistent
with those from numerical simulations (red curves and shade), they suggest the presence of a
topological transition point, as a double-valley structure changes into a single-valley one. More
specifically, we define a distance-to-width ratio $r = Delta delta / (2 w)$, so that the transition
occurs at $r = 1$. As shown in the inset of @fig:energy(d), $r$ undergoes a rapid change and
drops from $approx 1.5$ to $0$ around $J_t / J_p approx 1$, indicative of a gap-closing transition in
the thermodynamic limit. Theoretically, the topological phase transition is predicted by the
non-Bloch band theory to occur at $J_t / J_p approx 1.04$ ~@supp. By contrast, the Bloch winding
number is not quantized close to the transition. Our observation is, therefore, consistent with
the non-Bloch bulk-boundary correspondence ~@WZ1.

To achieve a better resolution with narrower valleys, a weaker probe coupling (between $|d⟩$ and
the chain) and a longer probe time are desirable. Experimentally, however, these parameters are
constrained by the decoherence time of the system, and the inhomogeneous broadening due to the
interplay of trapping potential and interaction. As it is, the width of each valley is typically a
few hundred Hz, which sets the resolution of the Bragg spectroscopy. Finally, in our experiment,
the injected atoms propagate over three unit cells during the 1 ms probe time ~@supp, which
proves sufficient for the spectroscopy.

#emph[Discussion.] We report the first experimental identification of dynamic signatures of the
NHSE in a Bose-Einstein condensate, by engineering a dissipative AB chain in the synthetic
dimensions of hyperfine and momentum states of ultracold atoms. While we experimentally
characterize the NHSE and its consequences using a finite-size system of five unit cells, it is
desirable to further increase the experimentally achievable system size, which would reduce the
finite-size effects ~@supp, enable longer probe time and better resolutions. For this purpose,
better phase locking of the coupling lasers and an initial condensate with more atom numbers are
necessary.

For future studies, it would be fascinating to introduce the Feshbach resonance to the dissipative
AB chain, where the inter-atomic interactions can be widely tuned ~@Xie2020 ~@Wang2022. Our
experiment thus paves the way toward a systematic study of NHSE in the many-body setting of cold
atoms. Given the flexible control over atoms in momentum lattices, our scheme also has far-reaching
implications for thes immediate future. For instance, in light of recent experiments on localized
states in momentum lattices ~@Meier2018 ~@yanlocal, an experimental characterization of the
interplay between disorder, topology and NHSE is readily accessible based on our setup. Our work
thus sheds new light on the study of quantum open systems.

#block(spacing: 0.8em)[
  #emph[Acknowledgement:-] B. Y. acknowledge the support from the National Key Research and
  Development Program of China under Grant No. 2018YFA0307200, the National Natural Science
  Foundation of China under Grant No. 12074337, Natural Science Foundation of Zhejiang province
  under Grant No. LR21A040002, Zhejiang Province Plan for Science and technology No. 2020C01019 and
  the Fundamental Research Funds for the Central Universities under No. 2020XZZX002-05 and
  2021FZZX001-02. W. Y. acknowledges support from the National Natural Science Foundation of China
  under Grant Nos. 11974331, the National Key Research and Development Program of China under
  Grant Nos. 2017YFA0304100. B. G. acknowledges support by the U.S. Air Force Office of Scientific
  Research under Grant No. FA9550-21-1-0246.
]

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "american-physics-society", title: [References], full: true)
