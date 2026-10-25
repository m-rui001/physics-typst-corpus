#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 12pt, lang: "en")
#set page(
  numbering: none,
  paper: "us-letter",
  margin: (left: 2.54cm, right: 3.36cm, top: 3.25cm, bottom: 1.13cm),
  header: context {
    if counter(page).get().first() > 1 {
      v(9pt)
      set text(size: 12pt)
      grid(columns: (1fr, auto), [#emph[Scars and Fragmentation: Exact Results]], counter(page).display())
    }
  },
)
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.35em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.645em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(17pt, weight: "bold")[Quantum Many-Body Scars and Hilbert Space Fragmentation: A Review of Exact Results] \
  #v(1.1em)
  #set text(11.5pt)
  #strong[Sanjay Moudgalya #super[1,2]], #strong[B. Andrei Bernevig #super[3,4,5]] and #strong[Nicolas Regnault #super[3,6]] \
  #v(0.7em)
  #set text(9pt, style: "italic")
  #super[1] Institute for Quantum Information and Matter, California Institute of Technology, Pasadena, CA 91125, USA \
  #super[2] Walter Burke Institute for Theoretical Physics, California Institute of Technology, Pasadena, California 91125, USA \
  #super[3] Department of Physics, Princeton University, Princeton, NJ 08544, USA \
  #super[4] Donostia International Physics Center, P. Manuel de Lardizabal 4, 20018 Donostia-San Sebastian, Spain \
  #super[5] IKERBASQUE, Basque Foundation for Science, Bilbao, Spain \
  #super[6] Laboratoire de Physique de l'Ecole normale supérieure, ENS, Université PSL, CNRS, Sorbonne Université, Université Paris-Diderot, Sorbonne Paris Cité, 75005 Paris, France
]
#v(1.6em)

#block(width: 88%, inset: (x: 6%), above: 0.4em, below: 1.4em)[
  #set text(size: 9.5pt)
  #align(center)[#strong[Abstract]]

  The discovery of Quantum Many-Body Scars (QMBS) both in Rydberg atom simulators and in the Affleck-Kennedy-Lieb-Tasaki (AKLT) spin-1 chain model, have shown that a weak violation of ergodicity can still lead to rich experimental and theoretical physics.
  In this review, we provide a pedagogical introduction to and an overview of the exact results on weak ergodicity breaking via QMBS in isolated quantum systems with the help of simple examples such as the fermionic Hubbard model.
  We also discuss various mechanisms and unifying formalisms that have been proposed to encompass the plethora of systems exhibiting QMBS.
  We cover examples of equally-spaced towers that lead to exact revivals for particular initial states, as well as isolated examples of QMBS.
  Finally, we review Hilbert Space Fragmentation, a related phenomenon where systems exhibit a richer variety of ergodic and non-ergodic behaviors, and discuss its connections to QMBS.
]

#outline(title: [Contents], depth: 2)

= Introduction <sec:intro>

The advent of quantum simulators, implemented for example in ultracold atomic setups or superconducting circuits, has put at the forefront the question of out-of-equilibrium quantum many-body systems.
The Eigenstate Thermalization Hypothesis (ETH)@deutsch1991quantum @srednicki1994chaos has long been thought to describe the properties of #emph[all] finite-energy density eigenstates, i.e., excited states in the middle of the energy spectrum, of any generic non-integrable quantum many-body system.
ETH has been tested experimentally, analytically and numerically in various systems (however, mostly in one dimension), and it forms the pillar of our understanding of phenomena such as many-body quantum chaos and thermalization.

While the formulation of ETH sounds general, it is nevertheless a hypothesis, and thus immediately raises the question of potential counter-examples.
Among them, quantum integrable models are the simplest cases where violations of ETH are known.
Such systems exhibit an extensive number of conserved quantities that in principle determine every eigenstate in the system, which exhibit features that might strongly deviate from a typical thermal eigenstates.
While non-interacting integrable models such as free fermion models are ubiquitous in physics, interacting ones are usually considered as fine-tuned and are harder to experimentally implement.
The search for more generic violations of ETH beyond integrable systems began with the discovery of many-body localization (MBL), where the alliance of strong disorder and interaction leads to emergent integrability (see for example the two review articles @nandkishore2015many and @abanin2018review), although the existence and stability of MBL is currently being debated @abanin2018review @suntajs2020quantum @abanin2021distinguishing.

The intermediate situation, a weak or partial violation of ETH by a small number (exponentially smaller than the Hilbert space dimension) of eigenstates, might be considered at first sight as too non-generic to be interesting or experimentally relevant.
Indeed, any such non-thermal eigenstate would not have an energy gap protecting its nature, and would be exponentially close in energy to thermal eigenstates that would quickly hybridize with it under small perturbations.
However, an experimental observation of anomalously long-lived revivals in a Rydberg atom quantum simulator @bernien2017probing showed the opposite; the revivals were attributed to a small set of non-thermal eigenstates, dubbed Quantum Many-Body Scars (QMBS), in the otherwise non-integrable PXP model that captured the experiment @turner2017quantum @turner2018quantum.

These results on Rydberg atoms also led to numerous further theoretical investigations of the PXP model @ho2018periodic, @khemani2019int @choi2018emergent, aspects of which have been summarized in the recent review @SerbynReview (see @papic2021weak for a longer version).

The typical spectrum of a system exhibiting QMBS is depicted in @fig:main(a): a discrete number of non-ETH eigenstates that “scar” the spectrum of an apparently ergodic system.
With a proper choice of an experimentally motivated initial state, the time-evolution of the quantum many-body system would then show a strong departure from the typical behavior of thermal non-integrable models.

In parallel to this experimental breakthrough, QMBS were independently discovered using a purely theoretical approach in a different context.

@moudgalya2018a derived in the Affleck-Kennedy-Lieb-Tasaki (AKLT) spin-1 model @aklt1987rigorous a series of energetically equally-spaced exact excited eigenstates, i.e., a tower of states, that provably violates ETH in an otherwise non-integrable model.
This led to a flurry of analytical results that provided a complementary perspective on QMBS and attempted to establish a rigorous understanding of its emergence based on either brute force analytical derivation of excited states, or an underlying algebraic structure or symmetry.
This should be put in contrast with some other forms of ergodicity breaking, e.g., MBL, where analytical progress has been hindered by the scarcity of exact results.
Beyond the AKLT model, QMBS have been found in a variety of systems, sometime giving the opportunity to revisit some of the most celebrated condensed-matter interacting models such as the Hubbard model, in the search for analytical expression of exact excited states.
QMBS are also closely related to the broader phenomenon of Hilbert space fragmentation @sala2019ergodicity (also referred to as Hilbert space shattering @khemani2019local, Krylov fracture @moudgalya2019thermalization, or jamming @zadnik2021foldedxxz1), which refers to the existence of exponentially many dynamically disconnected subspaces that are not captured by conventional symmetries.
There, a physically motivated basis choice unveils a rich structure within the Hamiltonian of dynamically disconnected subspaces with different thermalization and entanglement properties, as sketched in @fig:main.

Akin to QMBS, analytically tractable models offer an invaluable playground to understand the nature of Hilbert space fragmentation and their effects on dynamics.

In this review, we focus on exact analytical results about QMBS which already provide a wealth of interesting models, analytical derivations and formalisms.
We refer the readers leaning towards direct experimental implications of QMBS or in the approximate QMBS of PXP and related models to @SerbynReview.

The review is organized as follows.

In @sec:ergodicity, we provide, for pedagogical purposes, a short overview on ergodicity and its breakdown in isolated quantum systems, introducing notations and concepts used in QMBS literature.

 @sec:towers focuses on towers of QMBS and explicitly illustrates the towers derived from the spectrum generating algebra or dynamical symmetry in the fermionic Hubbard model.
We also survey other examples of towers of QMBS in the literature, discuss their entanglement properties, and demonstrate how they lead to revivals from simple initial states.

 @sec:unifiedformalism gives an overview of the different known mechanisms inducing towers of QMBS, namely the eigenstate embedding, the spectrum generating algebra and their generalizations, and the symmetry-based formalisms.

We dedicate @sec:isolated to reviewing several examples of isolated QMBS, due to its connection to some exact results in the PXP model, as well as a highly general formalism for embedding exact QMBS into the spectrum of any non-integrable Hamiltonian.

In @sec:fragmentation we review ergodicity breaking via the broader phenomenon of Hilbert space fragmentation, exemplified through dipole-conserving systems, and discuss their dynamical implications and connections to QMBS.
Finally we discuss some major questions still open in the field in @sec:outlook.

// [figvision] imgs/scarskrylov_mod.png
// Panel (a) displays a vertical stack of closely spaced horizontal lines representing an energy spectrum within
// a tall black outline. A large right-facing curly brace on the right brackets most of the stack and is labeled
// ETH. A smaller brace at the bottom brackets the lowest lines and is labeled GS-like GS. Three arrows labeled
// Solvable point from the left toward selected isolated lines in the upper portion of the stack, marking rare
// ETH-violating eigenstates. The dense background lines denote ETH-satisfying volume-law states, while
// ground-state-like levels are crowded at the lower edge of the spectrum. Panel (b) shows a schematic sequence
// enclosed by tall vertical black braces on both sides. Four squares form a descending diagonal: two green
// squares followed by two red squares, connected by a black dotted line. An upward arrow labeled Integrable
// points toward the green squares, while a downward arrow labeled Non-Integrable (ETH) points to the red
// squares. The dotted line continues past the red squares as a series of shrinking blue squares toward the
// bottom right, where a rightward arrow marks Finite-dimensional. The layout contrasts integrable dynamics,
// chaotic many-body thermalization, and finite-size truncation.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering).* #it.body]
}

// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [*Table #context it.counter.display(it.numbering).* #it.body]
}

#figure(placement: top, [#figure(
    align(center)[#table(
      columns: 1,
      align: (center,),
      // [figvision] imgs/scarskrylov_mod.png
      // Panel (a): a vertical "eigenstate ladder". A black column of horizontal spectral
      // lines (dense in the middle) is bracketed as "ETH" in the centre; toward the bottom
      // the same column splits into sparse, widely spaced levels with a bracket
      // "GS-like" and a single line marked "GS"; three arrows on the left labelled
      // "Solvable" point to isolated levels in the upper sparse part.
      // Panel (b): schematic classification in a triangular wedge (two black boundaries).
      // Green squares at the upper-left = Integrable levels (two shown), red squares =
      // Non-Integrable (ETH) levels (two shown) connected by a dotted line, and blue
      // squares at the lower-right = Finite-dimensional levels. Arrows annotate the
      // Integrable and ETH regions; the wedge widens towards the lower right.
      [#box(image("imgs/scarskrylov_mod.png", width: 427pt))],
    )]
    , kind: table
    )

  ],
  caption: [
    (Color online) Two types of ergodicity breaking that we study in this review. (a) Quantum Many-Body Scars (QMBS): typical example of an energy spectrum with solvable ETH-violating eigenstates that show sub-volume law entanglement and exist amidst a sea of ETH-satisfying states that show volume-law entanglement. States close to the edges of the spectrum such as the ground state (GS) or low-energy excitations (GS-like) show area-law entanglement and are not expected to satisfy ETH. (b) Hilbert Space Fragmentation: Hamiltonian matrix represented consists of several dynamically disconnected Krylov subspaces, i.e. it is block-diagonal in a certain simple basis (e.g., the product state basis). The size of the Krylov subspaces can grow with system size or stay finite-dimensional, and the Hamiltonian restricted to the Krylov subspaces can be integrable (green) or non-integrable (red). The Hamiltonian in non-integrable Krylov subspaces is expected to satisfy Krylov-Restricted ETH.
  ],
  kind: image,
) <fig:main>

= Ergodicity in Isolated Quantum Systems <sec:ergodicity>

We begin by reviewing aspects of dynamics of isolated quantum systems.
For the sake of concreteness, we focus on a system with $L$ spins and Hamiltonian $H$.
We are typically interested in the dynamics of a simple wavefunction $|psi(0)⟩$ under the Hamiltonian $H$, where simple wavefunctions are those that are experimentally accessible, for example, product states or ground states of simple local Hamiltonians.
The system evolves the state unitarily, and the wavefunction of the full system at time $t$ is given by $|psi(t)⟩ = e^(-i H t)|psi(0)⟩$.

An isolated quantum system without any other symmetries is said to be ergodic or thermal if the reduced density matrix of any small subsystem $(cal(A))$ of $L_(cal(A)) << L$ spins, defined as $rho_(cal(A))(t) equiv "Tr"_(cal(B))(|psi(t)⟩⟨psi(t)|)$ evolves to a Gibbs density matrix.

$
  lim_(t arrow infinity) rho_(cal(A))(t) = "Tr"_(cal(B))(rho^(eq)) approx rho^(eq)_(cal(A)), #h(0.28em) #h(0.28em) #h(0.28em) rho^(eq) = frac(1, Z) e^(-beta H)
$<eq:thermalization>
 where $Z$ is the partition function for the subsystem, $beta$ is an inverse-temperature associated with the initial state.

In particular, @eq:thermalization implies that the rest of the system acts as a thermal bath for the small subsystem $(cal(A))$@nandkishore2015many, and as a consequence, the late-time expectation values of (sums of) local operators $hat(O)$ that are supported on a small number of sites should match their thermal expectation values.
In the presence of additional symmetries, @eq:thermalization is suitably modified to include a grand canonical ensemble formed by the symmetries, and we refer the readers to detailed reviews on this subject in @polkovnikov2011colloquium @d2016quantum.

These conditions on the dynamics of states have a direct implication on the structure of eigenstates of the system, which we now discuss.

== Eigenstate Thermalization Hypothesis (ETH) <subsec:ETH>

The definition of thermalization in @eq:thermalization naturally leaves open the question of which initial states $|psi(0)⟩$ thermalize.

Informally speaking, if #emph[any] initial state at some energy density of a system thermalizes under a Hamiltonian $H$, the eigenstates of $H$ at that energy density should also thermalize.
Since we expect such initial state behavior generically, we arrive at the Eigenstate Thermalization Hypothesis (ETH), which loosely states that any eigenstate of the Hamiltonian at a finite energy density is thermal.
That is, the reduced density matrix of an eigenstate with energy $E_alpha$ over a small subsystem $(cal(A))$ should also be the Gibbs density matrix over the subsystem with an inverse-temperature $beta_alpha$ that depends on $E_alpha$.

Indeed, we expect $beta_alpha arrow.r oo$ when $E_alpha$ is close to the ground state energy, and $beta_alpha arrow.r 0$ when $E_alpha$ corresponds to the middle of the spectrum.
A more accurate form of ETH is motivated in terms of expectation values of local operators as follows.
For a system of volume $V$ and a local Hamiltonian $H$, typical initial product states $|psi(0)⟩$ have energy variances $Delta tilde sqrt(V)$, which, in the thermodynamic limit, is much smaller than the energy bandwidth $W$ which scales as $tilde V$, i.e.

$
  ⟨psi(0)|H|psi(0)⟩ = macron(E), #h(0.28em) #h(0.28em) #h(0.28em) sqrt(⟨psi(0)|H^2|psi(0)⟩ - macron(E)^2) = Delta << W.
$<eq:initstateconditions>

Hence, when any product state is expressed in the energy eigenbasis $"{" |E_alpha⟩ "}"$ of a local Hamiltonian $H$ as $|psi(0)⟩ = sum_(alpha) c_alpha |E_alpha⟩$, the magnitudes of the coefficients $( ‖ c_alpha ‖ ^2 )$ turn out to be significant only in an energy window $E_alpha in [ macron(E) - Delta ,  macron(E) + Delta ]$.

The expectation value of a local operator $hat(O)$ as a function of time then reads

$
  ⟨hat(O)(t)⟩ equiv ⟨psi(t)| hat(O) |psi(t)⟩ = sum_(alpha) |c_alpha|^2 O_(alpha alpha) + sum_(alpha != beta) c_alpha^∗ c_beta O_(alpha beta) e^(i(E_alpha - E_beta)t),
$<eq:Otdefn>
 where $O_(alpha beta) = ⟨E_alpha| hat(O) |E_beta⟩$.

Assuming there are no degeneracies in the spectrum, the time-averaged expectation value cancels the off-diagonal terms in @eq:Otdefn, the long-time average is determined only by the average in the “diagonal ensemble”:
$
  lim_(T arrow infinity) frac(1, T) integral_0^T d t #h(0.25em) ⟨hat(O)(t)⟩ = sum_(alpha) |c_alpha|^2 O_(alpha alpha).
$

In a thermalizing system, we expect the long-time average to be equal to the expectation value of a local operator in a microcanonical ensemble around energy $macron(E)$ of the initial state, requiring
$
  sum_(E_alpha in [macron(E) - Delta, macron(E) + Delta]) O_(alpha alpha) = sum_(alpha) |c_alpha|^2 O_(alpha alpha).
$<eq:MCtimeavg>

Using the fact that magnitudes $‖ c_alpha ‖ ^2$ are significant only in the energy window $[ macron(E) - Delta ,  macron(E) + Delta ]$, @eq:MCtimeavg suggests that $O_(alpha alpha)$ on the RHS is only a function of the energy $macron(E)$ rather than the eigenstate energy $E_alpha$.

These arguments, along with many other motivations @srednicki1994chaos, led to a formal conjecture on the matrix elements of local operators in the energy eigenstates of a non-integrable model take the form @d2016quantum.

$
  ⟨E_m|hat(O)|E_n⟩ = macron(O)(E)delta_(m, n) + R_(m, n) #h(0.25em) Omega(E)^(-1\/2) f_O (E, omega ),
$<eq:ethmatrixel>
 where $hat(O)$ is a local operator, $E = (E_m + E_n)\/2$, $omega = E_m - E_n$, $R_(m ,  n)$ is a pseudorandom variable such that the distribution of $( R_(m ,  n) )$ (over all values of $m$ and $n$) has zero mean and unit variance, $macron(O) (E)$ is a smooth function of $E$ and represents the thermal expectation value of $hat(O)$ at energy $E$, $f_O (E ,  omega)$ is a smooth function of $E$ and $omega$ which do not scale with the system size @d2016quantum, and $Omega (E)$ is the density of states at energy $E$.

Note that the thermal value is typically determined in practice by computing the microcanonical average, i.e. averaging the eigenstate expectation values $⟨E| hat(O) |E⟩$ over a small energy window $Delta$ that corresponds to the Thouless energy scale @beugeling2014finite.

In @eq:ethmatrixel, for a system with Hilbert space dimension $cal(D)$, we expect $Omega ( E ) tilde.op 1 \/cal(D)$ for states in the middle of the spectrum.
Hence, the standard deviation of expectation values of operators in the eigenstates in the middle of the spectrum within the Thouless energy window $Delta$ is expected to scale as $tilde.op 1 \/sqrt(cal(D))$, which forms a standard numerical diagnostic of ETH @beugeling2014finite (although this scaling is debated @huang2022finite).

We refer to @eq:ethmatrixel restricted to the cases $m = n$ and $m eq.not n$ as diagonal ETH and off-diagonal ETH respectively @shiraishimorireply.

In this review, we are primarily interested in the behavior of expectation values of local operators in eigenstates of the system, and hence in diagonal ETH.
Note that for systems with additional symmetries such as particle number conservation, @eq:ethmatrixel is expected to hold for eigenstates within a particular quantum number sector @rigol2008thermalization @d2016quantum @mondaini2018comment.

The question of which initial states thermalize under time-evolution leads to two notions of diagonal ETH: #emph[strong] ETH and #emph[weak] ETH.

Strong ETH states that #emph[all] eigenstates obey diagonal ETH as stated in @eq:ethmatrixel, which implies that all initial states thermalize.
Evidence for the validity of strong ETH in typical non-integrable models has been found in @kim2014testing @garrison2018does.

On the other hand, weak ETH states that #emph[almost all] eigenstates obey diagonal ETH.
In particular, this implies that there could be a small set (of fraction going to zero with increasing system size) of eigenstates violating diagonal ETH.
Such a scenario can in principle lead to the non-thermalization of a few special initial states amidst the thermalization of most initial states.
We will discuss this scenario in more detail in @subsec:ergodicitybreaking.

== Level Statistics <subsec:levelstats>

Ergodicity in isolated quantum systems is typically considered synonymous with quantum chaos, a widely studied subject @stockmann2000quantumchaos.

A system is said to be quantum chaotic if its correlation functions under time-evolution by the Hamiltonian at late times resembles correlations under time-evolution by a Random Matrix with the same symmetries.
These considerations lead to defining features of quantum chaotic systems, such as the repulsion of nearest-neighbor eigenvalues @bgs1984chaos and the linear ramp in the Spectral Form Factor (SFF) of such systems @brezin1997sff.

Random Matrix Theory also provides remarkably accurate predictions of these quantities, and in particular for the statistics of nearest-neighboring energy differences $s_n = ( E_(n + 1) - E_n )\/macron(E)$, where $E_n$'s are the sorted energy levels and $macron(E)$ is the mean energy level spacing in the vicinity of $E_n$@dyson1962brownian.

It has been numerically verified for several non-integrable models that $s_n$ follows a Wigner-Dyson distribution @poilblanc1993poisson @rigol2008thermalization @nandkishore2015many whereas $s_n$ in systems with several symmetries (e.g. integrable systems) follows a Poisson distribution @giraud2020probing.

This distribution can also be directly detected using the mean level spacing ratio $chevron.l r chevron.r$, which is the average of $r_n = min ( s_n ,  s_(n + 1) )\/max ( s_n ,  s_(n + 1) )$@oganesyan2007localization @atas2013distribution.

 $chevron.l r chevron.r approx 0.53$ and $chevron.l r chevron.r approx 0.6$ for Wigner-Dyson ensembles with and without time-reversal symmetry, and $chevron.l r chevron.r approx 0.38$ for the Poisson distribution.

Note that for non-integrable Hamiltonians with a few additional symmetries (e.g. particle number), signatures of ergodicity and its breaking are expected to appear in the distribution of energy levels within a symmetry sector @rigol2008thermalization @d2016quantum @mondaini2018comment.

One common signature of the breakdown of ergodicity is hence the change in the distribution of level statistics after resolving known symmetries, as we will discuss in @subsec:ergodicitybreaking.

== Entanglement <subsec:entanglement>

#figure(cetz.canvas(length: 1.0cm, {
  import cetz.draw: *
  let yc = 0
  let half = 0.5
  let bs = (thickness: 1.1pt, paint: black)
  let hline(x1, x2) = line((x1, yc), (x2, yc), stroke: bs)
  let vline(x, y1, y2) = line((x, y1), (x, y2), stroke: bs)
  let tbox(cx, m) = {
    rect((cx - half, yc - half), (cx + half, yc + half), stroke: bs, fill: none)
    content((cx, yc), text(size: 15pt, m))
    vline(cx, yc - half, yc - half - 0.62)
  }
  let circ(cx, m) = {
    circle((cx, yc), radius: 0.45, stroke: bs, fill: none)
    content((cx, yc), text(size: 7pt, m))
  }
  let dots(cx) = content((cx, yc), text(size: 11pt)[....])

  // (a)
  content((-0.3, 0.95), anchor: "west", text(size: 11pt)[(a)])
  tbox(1.0, $A$)
  hline(0.5, 0.0); hline(1.5, 2.0)
  content((0.05, 0.34), $chi$)
  content((1.95, 0.34), $chi$)
  content((1.0, -1.3), $d$)

  // (b)
  content((2.5, 0.95), anchor: "west", text(size: 11pt)[(b)])
  content((3.3, 0), anchor: "west", $|psi⟩ =$)
  circ(5.0, $b_A^l$)
  tbox(6.2, $A$); hline(5.45, 5.7)
  hline(6.7, 7.0); dots(7.4); hline(7.8, 8.1)
  tbox(8.6, $A$); tbox(9.8, $A$); hline(9.1, 9.3)
  line((10.6, 1.15), (10.6, -1.5), stroke: (thickness: 1pt, paint: black, dash: "dotted"))
  content((10.75, 1.2), anchor: "west", $S <= log chi$)
  hline(10.3, 10.5); hline(10.7, 10.9)
  tbox(11.4, $A$); tbox(12.6, $A$); hline(11.9, 12.1)
  hline(13.1, 13.4); dots(13.8); hline(14.2, 14.5)
  tbox(15.0, $A$); hline(15.5, 15.75)
  circ(16.2, $b_A^r$)
}),
  caption: [
    (a) $d times chi times chi$ tensor representing an MPS. $d$ is the physical dimension and $chi$ is the bond-dimension (b) Wavefunction $|psi⟩$ represented in MPS form, $b_A^l$ and $b_A^r$ are $chi$-dimensional boundary vectors. The entanglement entropy of an MPS state is bounded by $S lt.eq log chi$.
  ]
) <fig:MPS>

The concepts of entanglement and entropy (as one of its measure) are widely used in several contexts in physics @eisert2010colloquium, @nishioka2009entanglement, and are also crucial in the study of quantum dynamics as well as QMBS.
The entanglement of a wavefunction $|psi⟩$ is defined via its Schmidt decomposition about a bipartition into regions $(cal(A))$ and $(cal(B))$, given by

$
  |psi⟩ = sum_(alpha = 1)^(chi) lambda_alpha |psi_alpha⟩_(cal(A)) |psi_alpha⟩_(cal(B)),
$<eq:bipartition>
 where $"{" |psi_alpha⟩_(cal(A)) "}"$ and $"{" |psi_alpha⟩_(cal(B)) "}"$ are orthonormal sets of wavefunctions on the subsystems $(cal(A))$ and $(cal(B))$ respectively, $lambda_alpha$'s are non-negative real numbers, and $chi$ is known as the Schmidt rank of the wavefunction.

For a normalized state $|psi⟩$, we always have $sum_(alpha = 1)^(chi) lambda_alpha^2 = 1$.

The (von Neumann) Entanglement Entropy (EE) $S$ of the state $|psi⟩$ over this bipartition is defined as

$
  S equiv -sum_(alpha = 1)^(chi) lambda_alpha^2 log lambda_alpha^2 = -"Tr"_(cal(A))(rho_(cal(A)) log rho_(cal(A)))
$<eq:EEdefn>
 where $rho_(cal(A))$ is the reduced density matrix over subsystem $(cal(A))$.

Ground states of gapped quantum many-body systems are known to exhibit a so-called “area-law” scaling of the EE, where $S$ scales proportionally to the area of the subsystem $(cal(A))$, which, in one-dimension implies that $S$ is independent of the subsystem size.
On the other hand, the EE in ground states of critical gapless systems typically exhibit logarithmic violations of the area-law, i.e., $S$ scales with the area times the logarithm of the volume of the subsystem $(cal(A))$@calabrese2009entanglement @eisert2010colloquium.

For highly excited states of non-integrable models, ETH predicts a “volume law” scaling of $S$ i.e. it scales proportionally to the volume of the subsystem $(cal(A))$.

This is a direct consequence of the reduced density matrix discussed in @eq:thermalization.

In fact, for states in the middle of the spectrum, $beta = 0$ in @eq:thermalization, and thus their EE is typically observed to be close to $S_"th"$, the mean EE of states in the Hilbert space @page1993, also known as the Page entropy, which is close to the maximum possible entropy $S_"max"$.

For a one-dimensional system with $L$ spin-$1\/2$'s and $L_(cal(A)) = L\/2$ spin-$1\/2$'s in subsystem $(cal(A))$, these values are known to be

$
  S_"th" = frac(L log 2 - 1, 2) #h(0.17em) #h(0em) #h(0em) #h(0em) S_"max" = frac(L log 2, 2) .
$<thermalent>

Note that when $L_(cal(A))\/L$ is kept constant, $S_"th"$ and $S_"max"$ typically differ by an $L$-independent constant that only depends on the fraction $L_(cal(A))\/L$ and the properties of (e.g., the constraints on) the full Hilbert space @page1993, @morampudi2020universal; hence eigenstates in the middle of the spectrum are almost always maximally entangled.

Entanglement also plays an important role in understanding the structure of QMBS eigenstates.
For example, most of the QMBS eigenstates that we review have exact Matrix Product States (MPS) representations @schollwock2011density @verstraete2008matrix @orus2014practical @perezgarcia2007matrix.

An MPS wavefunction $|psi⟩$ (with open boundary conditions) can be written as
$
  |psi⟩ = sum_("{" m_1 m_2 … m_L "}") [(b^l_A)^T A^([m_1]) … A^([m_L]) b^r_A] |m_1 … m_L⟩,
$
 where $|m_1 … m_L⟩$ denotes the many-body basis states where $( m_j )$ can take $d$ values, the dimension of the local physical Hilbert space.

 $( A^([ m_j ]) )$'s are $chi times chi$ matrices, where $chi$ is referred to the bond-dimension of the MPS, and $b_A^l$ and $b_A^r$ are $chi$-dimensional left and right boundary vectors that determine the boundary conditions for the wavefunction.

Diagrammatically, $A$ can be visualized as a $d times chi times chi$ tensor as shown in @fig:MPS and the state $|psi⟩$ as contractions of these tensors shown in @fig:MPS.

Note that although any state can have multiple MPS representations, there is a canonical form of the MPS which has bond dimension $chi$ that is the same as the number of non-zero Schmidt values of the state in @eq:EEdefn.

The EE for an MPS wavefunction then satisfies the bound

$ S lt.eq log chi . $<eq:MPSEEbound>

Hence the growth of the bond-dimension $chi$ of an MPS representation of the state is sufficient to determine the scaling of EE with system-size.
For example, it is well-known that area-law ground states of gapped systems in one dimension admit approximate/exact MPS representations of bond dimension $chi$ that is system-size independent @hastings2007area.

In @sec:towers, we will apply these results to QMBS eigenstates and obtain the scaling of their EEs.

== Ergodicity Breaking <subsec:ergodicitybreaking>

Most local interacting Hamiltonians are believed to be non-integrable and fully ergodic, i.e. their eigenstates obey strong ETH.
Indeed, the spectrum of a generic local Hamiltonian exhibits level repulsion and Wigner-Dyson level statistics, signalling the presence of quantum chaos.
Nevertheless, as discussed in @sec:intro, systems with various degrees of ergodicity breaking have been found.
A complete breakdown of ergodicity, i.e. a breakdown of strong and weak ETH, is known in two types of systems: Integrable and Many-Body Localized (MBL).
In addition, two types of partial breakdowns of ergodicity have been found, and the phenomena go by the names Quantum Many Body Scars (QMBS) and Hilbert space fragmentation.
We now provide a brief overview these types of ergodicity breaking in isolated quantum systems, and a summary of their properties is provided in @tab:taxonomy.

=== Integrability <integrability>

Integrability occurs in the presence of an extensive number of conserved quantities, which leads to the complete solvability of the energy spectrum, at least in principle.
The simplest examples of integrable systems are non-interacting systems, where the many-body spectrum is completely determined by the single-particle spectrum.
Interacting examples of integrable models include ones with commuting projector Hamiltonians, such as the toric code @kitaev2003fault, @kitaev2010topological, being a celebrated example, and Bethe ansatz solvable models such as the one-dimensional XXZ and the one-dimensional Hubbard models @faddeev1996algebraic.

Quantum integrability is not stable under generic perturbations, and moreover no analogues of the Kolmogorov-Arnold-Moser (KAM) theorem for classical integrability, that establishes some degree of stability under perturbations, have been rigorously established for quantum systems.
Hence it is believed that a high degree of fine-tuning is required in the space of all local Hamiltonians in order to see signatures of quantum integrability.

=== Many-Body Localization <many-body-localization>

On the other hand, MBL, the generalization of Anderson localization to interacting systems, is believed to occur more generically in the presence of strong disorder or quasiperiodicity @nandkishore2015many, @abanin2018review, although its stability in the thermodynamic limit has been a subject of active debate @deroeck2017stability @suntajs2020quantum @sels2020dynamical @crowley2020constructive.

In both cases, the existence of an extensive number of conserved quantities can be constructed, which leads to the absence of level repulsion that is reflected in the Poisson level statistics shown by these Hamiltonians.
From the point of view of entanglement, MBL systems possess eigenstates with area-law entanglement that are easy to identify @huse2014phenomenology.

On the other hand, quantum integrable systems mostly possess volume-law entangled eigenstates with a few exceptions @alba2009excited, @vidmar2017entanglement, and their eigenstates are hence harder to distinguish from thermal eigenstates @alba2015eigenstate @khemani2014eigenstate.

=== Quantum Many-Body Scars (QMBS) <quantum-many-body-scars-qmbs>

A distinct type of ergodicity breaking, termed as #emph[weak ergodicity breaking] in @turner2017quantum can occur in systems that violate strong ETH but still obey weak ETH.
Such systems exhibit a few highly excited eigenstates that violate diagonal ETH, i.e. they possess atypical features compared to most other eigenstates at the same energy density.
These ETH-violating eigenstates in the middle of the spectrum are referred to as #emph[Quantum Many-Body Scars] (QMBS).
The term originates from the analogy to quantum scars in single-particle systems such as a Bunimovich stadium @heller1984scars or quantum maps @backer2003numerical, where a small set of single-particle eigenstates with anomalous wavefunctions distributed on rare classical periodic orbits co-exist with generic eigenstates with wavefunctions distributed uniformly.
Such systems are said to violate the Quantum Unique Ergodicity (QUE) conjecture, which is, roughly speaking, the analogue of strong ETH for single-particle systems.
Typically, the number of QMBS grows exponentially slower than the Hilbert space dimension (either polynomially in system size or exponentially with a smaller base), and they constitute a measure-zero set in the thermodynamic limit.
Since most of the spectrum exhibits level repulsion, systems with QMBS show level repulsion on average, as well as many other standard signatures of quantum chaos.
We might expect that signatures of QMBS buried in the middle of the spectrum would be hard to experimentally access.
Nevertheless, systems in which QMBS appear as equally spaced towers in the spectrum are of particular interest since equal spacings result in perfect revivals from particular initial states, a phenomenon that has been observed in Rydberg atom experiments @bernien2017probing @bluvstein2020controlling.

We discuss systems with equally spaced towers of QMBS in @sec:towers and associated unified formalisms in @sec:unifiedformalism, and systems with isolated QMBS in @sec:unifiedformalism.

=== Hilbert Space Fragmentation <hilbert-space-fragmentation>

Another type of ergodicity breaking of a different origin can occur in constrained systems, where the Hilbert space splits into exponentially many dynamically disconnected parts, such that large parts of it are inaccessible to particular initial states.

The term #emph[Hilbert space fragmentation] was coined in @sala2019ergodicity to refer to such systems.
Fragmentation was divided into two main categories: #emph[weak] and #emph[strong], depending on whether the fraction of states violating the conventional form of ETH are a set of measure zero or not in the thermodynamic limit.
Weakly fragmented systems are also sometimes regarded as examples of QMBS @sala2019ergodicity, @khemani2019local, since they obey weak ETH since the ETH-violating states form a set of measure-zero.
However, strongly fragmented systems also violate conventional forms of weak ETH, and should be regarded as a distinct form of ergodicity breaking.
Fragmented systems possess eigenstates that can show any scaling of EE from area-law to volume-law, depending on the size of the dynamically disconnected part of the Hilbert space they belong to.
Moreover, as we discuss in more detail in @sec:fragmentation, while weakly fragmented systems exhibit Wigner-Dyson level statistics, strongly fragmented systems typically consist of a large number of degeneracies in the spectrum, and can exhibit unconventional level statistics @giraud2020probing @herviou2021manybody.

#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (center,center,center,center,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.vline(x: 4, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header([], [#strong[Strong/Weak ETH]], [#strong[Entanglement]], [#strong[Level Statistics]],),
    table.hline(),
    [#strong[Ergodic]], [Yes/Yes], [Volume], [Wigner-Dyson],
    [#strong[Integrable]], [No/No], [Volume/Sub-Volume], [Poisson],
    [#strong[MBL]], [No/No], [Area], [Poisson],
    [#strong[Quantum Scarred]], table.cell(rowspan: 2)[No/Yes], table.cell(rowspan: 2)[Volume/Sub-Volume], table.cell(rowspan: 2)[Wigner-Dyson],
    [#strong[Weakly Fragmented]],
    [#strong[Strongly Fragmented]], [No/No], [Volume/Sub-Volume], [Poisson],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Taxonomy of Ergodicity and various types of its breaking in Isolated Quantum Systems. They can be distinguished based on whether they satisfy strong/weak ETH, the entanglement entropy scaling of typical eigenstates in the middle of the spectrum, and their energy level statistics.]
  , kind: table
  )

<tab:taxonomy>

= Towers of QMBS <sec:towers>

Since the ETH-violating eigenstates in quantum scarred systems constitute a measure-zero set in the thermodynamic limit, it is natural to wonder whether they would influence the dynamics of any experimentally accessible initial states.
As we discuss now, in cases where the spectrum includes an extensive number of non-thermal eigenstates in an equally spaced tower with energies $"{" E_0, E_0 + (cal(E)), E_0 + 2(cal(E)) , ⋯, E_0 + (N-1) (cal(E)) "}"$, novel dynamical phenomena are possible.
For example, the presence of such a tower in the spectrum leads to perfect revivals in the systems under dynamics from particular initial states.
Revivals can be probed by computing the fidelity $(cal(F))(t)$ (also known as Loschmidt echo) of an initial state $|psi(0)⟩ = sum_(n) c_n |E_n⟩$, defined as

$
  (cal(F))(t) = |⟨psi(0) | psi(t)⟩|^2 = |sum_(n) |c_n|^2 e^(-i E_n t)|^2 = sum_(m, n) |c_n c_m|^2 e^(i (E_m - E_n) t).
$<eq:fidelity>

For any initial state $|psi(0)⟩$ that lies completely within the subspace spanned by the tower of eigenstates, all of the energy differences $( E_m - E_n )$ that appear in the sum of @eq:fidelity are integer multiples of the spacing $(cal(E))$, and hence the system exhibits perfect revivals with time-period of at most $T = frac(2 pi, (cal(E)))$ (i.e., $(cal(F))(t + T) = (cal(F))(t)$).

While this is obvious if $|psi(0)⟩$ is explicitly chosen to be a superposition of a few eigenstates $"{" |E_n⟩ "}"$, it is not always clear that a product state or any physically relevant state can be constructed that way.
Nevertheless, as we will discuss in @subsec:revivals, for models exhibiting QMBS, it is possible to construct states $|psi(0)⟩$ with area law entanglement that have overlap with an extensive number of eigenstates, and lie completely within the QMBS subspace.
Conversely, it has been shown on general grounds @alhambra2020revivals that the existence of perfect revivals from a low-entanglement and short-range correlated state implies the presence of equally-spaced (or commensurately-spaced) eigenstates in the middle of the spectrum having low entanglement entropy, i.e., towers of QMBS.

The first exact, i.e., analytical, example of such a tower of eigenstates was found in the integer spin AKLT models @moudgalya2018a, @moudgalya2018b, well-known in the context of ground state and low-energy physics @aklt1987rigorous @arovas1988extended @arovas1989two.

Subsequently, numerous works found similar towers in simpler models such as the spin-1 XY model @iadecola2018exact, and connections were established to the phenomenon of $eta$-pairing known in the context of Hubbard models @yang1989eta.

In all these examples, the states in the tower are composed of multiple quasiparticles of a given energy and momentum dispersing on top of a fixed low-entanglement eigenstate such as the ground state.
Several examples bear a direct resemblance to $eta$-pairing in Hubbard models, and we discuss them in @subsec:SGAtowers.

We survey other examples of towers of states, some that appear to have a more complicated origin such as the AKLT model, as well as other miscellaneous examples in @subsec:othertowers.

== Simple examples: Spectrum Generating Algebras <subsec:SGAtowers>

In the following, we discuss some simple examples of models that exhibit exact QMBS, based on structures referred to as Spectrum Generating Algebras (SGA).
These examples form the foundation for systematic approaches to construct models with towers of exact QMBS.
They capture several examples of towers that have been discussed in the literature, which we will present in @sec:unifiedformalism.

=== Hubbard model <hubbard-model>

For pedagogical purposes, we explicitly illustrate the towers of exact eigenstates in the celebrated Hubbard model, known as $eta$-pairing eigenstates @yang1989eta @yang1990so.

The Hamiltonian for the Hubbard model on a hypercubic lattice in $d$-dimensions is given by

$
  H_("Hub") = sum_(sigma in "{" ↑, ↓ "}") [-sum_(⟨bold(r), bold(r)′⟩) t_(bold(r), bold(r)′) (c^dagger_(bold(r), sigma) c_(bold(r)′, sigma) + h.c.) -mu sum_(bold(r)) hat(n)_(bold(r), sigma)] + U sum_(bold(r)) hat(n)_(bold(r), ↑) hat(n)_(bold(r), ↓),
$<eq:FermiHubbard>
 where $"{" bold(r) "}"$ labels the sites of a lattice, $⟨bold(r), bold(r)′⟩$ denotes neighboring sites, and $t_(bold(r), bold(r)′)$ denotes the corresponding hopping strength, which is typically chosen to be site-independent.

 $c^dagger_(bold(r), sigma)$ and $c_(bold(r), sigma)$ denote the fermion creation and annihilation operators on site $bold(r)$, and the on-site fermion number operator is defined as $hat(n)_(bold(r), sigma) equiv c^dagger_(bold(r), sigma) c_(bold(r), sigma)$.

The Hubbard model on any bipartite lattice has spin and pseudospin symmetries, which are examples of conventional and dynamical $S U ( 2 )$ symmetries respectively, as we discuss below.
The spin $S U ( 2 )$ symmetry is composed of the operators $( S^(+) ,  S^(-) ,  S^z )$ and the corresponding quadratic Casimir operator $arrow(S)^2$, which are defined as

$
  S^+ = sum_(bold(r)) c^dagger_(bold(r), ↑) c_(bold(r), ↓), #h(0.28em) #h(0.28em) S^- = (S^+)^dagger, #h(0.28em) #h(0.28em) S^z = frac(1, 2)sum_(bold(r)) (hat(n)_(bold(r), ↑) - hat(n)_(bold(r), ↓)) \
  arrow(S)^2 = frac(1, 2)(S^+ S^- + S^- S^+) + (S^z)^2.
$<eq:spinsu2>

Similarly, the pseudospin $S U ( 2 )$ symmetry is composed of the operators $"{" eta^dagger, eta, eta^z "}"$ and the corresponding quadratic Casimir $arrow(eta)^2$, which are defined on a bipartite hypercubic lattice with $L$ sites (and even number sites in directions with periodic boundary conditions) as

$
  eta^dagger = sum_(bold(r)) e^(i bold(pi)∙bold(r)) c^dagger_(bold(r), ↑) c^dagger_(bold(r), ↓), #h(0.28em) #h(0.28em) eta = (eta^dagger)^dagger, #h(0.28em) #h(0.28em) eta^z = frac(1, 2)(sum_(bold(r), sigma) hat(n)_(bold(r), sigma) - L) \
  arrow(eta)^2 equiv frac(1, 2)(eta^dagger eta + eta eta^dagger) + (eta^z)^2.
$<eq:etaops>

The spin and pseudospin are examples of $S U ( 2 )$ symmetries since they obey the usual $frak(s u) ( 2 )$ commutation relations

$
  [S^z, S^+] = S^+, #h(0.28em) #h(0.28em) [S^z, S^-] = -S^-, #h(0.28em) #h(0.28em) [eta^z, eta^dagger] = eta^dagger, #h(0.28em) #h(0.28em) [eta^z, eta] = -eta.
$ <eq:su2comm>

Further, they are symmetries of the Hubbard model of @eq:FermiHubbard on a bipartite lattice since they satisfy

$
  [H_("Hub"), eta^z] = 0, #h(0.28em) #h(0.28em) [H_("Hub"), arrow(eta)^2] = 0, #h(0.28em) #h(0.28em) [H_("Hub"), S^z] = 0, #h(0.28em) #h(0.28em) [H_("Hub"), arrow(S)^2] = 0.
$<eq:su2syms>

As a consequence of @eq:su2syms, the eigenstates of the Hubbard model can be labelled by quantum numbers corresponding to two $S U ( 2 )$ symmetries –$( arrow(eta)^2 ,  eta^z )$ and $( arrow(S)^2 ,  S^z )$, although these quantum numbers are not completely independent of each other @essler2005one.

A crucial difference between the two $S U ( 2 )$ symmetries lies in the commutation relation of $H_("Hub")$ with $eta^dagger$ and $S^(+)$, which read

$
  [H_("Hub"), S^+] = 0, #h(0.28em) #h(0.28em) #h(0.28em) [H_("Hub"), eta^dagger] = (U - 2 mu)eta^dagger.
$ <eq:HubbardSGA>

While the spin-$S U ( 2 )$ is an example of a conventional $S U ( 2 )$ symmetry, the latter is referred to as a #emph[Spectrum Generating Algebra] (SGA) or a #emph[Dynamical Symmetry] @barut1965dynamical, @dothan1965series @buca2019nonstationary @medenjak2020isolated, when for a Hamiltonian $H$ an operator $eta^dagger$ satisfies

$
  [H, eta^dagger] = (cal(E)) eta^dagger.
$<eq:SGA>

The conventional $S U ( 2 )$ symmetry is a special case of @eq:SGA where $(cal(E)) = 0$.

While a conventional $S U ( 2 )$ symmetry results in the existence of degenerate multiplets of states in the spectrum (which are related by the action of raising and lowering operators $eta^dagger$ and $eta$), an SGA with $(cal(E)) != 0$ leads to the existence of a tower of equally spaced energy eigenstates, i.e. if $|psi_0⟩$ is an eigenstate of $H$ with energy $E_0$, $eta^dagger |psi_0⟩$ is also an eigenstate with energy $E_0 + (cal(E))$.

Choosing $|psi_0⟩$ to be an eigenstate of the Casimir operator $arrow(eta)^2$ and $eta^z$ with eigenvalues $J ( J + 1 )$ and $- J$ respectively for some $J$, we obtain a multiplet of $( 2 J + 1 )$ eigenstates
$
  "{" |psi_0⟩, eta^dagger |psi_0⟩, ⋯, (eta^dagger)^(2J) |psi_0⟩ "}"
$ <eq:psi0tower>
 with equally spaced energies given by
$
  "{" E_0, E_0 + (cal(E)), E_0 + 2 (cal(E)), ⋯, E_0 + 2 J (cal(E)) "}" .
$

Provided the state $|psi_0⟩$ is a solvable eigenstate, @eq:psi0tower denotes an exact tower of eigenstates.
A special set of solvable eigenstates of the Hubbard model are spin-polarized states that consist of only one type of spin $arrow.t$ or $arrow.b$.

The interaction term in @eq:FermiHubbard acts trivially on these states, which enables the construction of subspaces in which the action of the Hubbard model reduces to a quadratic Hamiltonian that can be solved exactly.
The simplest example of a solvable state is the vacuum state $|Omega⟩$ with no particles, and it can be used to construct a simple exact tower of states of the form @eq:psi0tower @vafek2017entanglement.

For example, such a tower in one dimension has the following form

$
  |Omega⟩ = |(0 #h(0.25em) 0 #h(0.25em) ⋯ #h(0.25em) 0 #h(0.25em) 0)⟩, #h(0.28em) #h(0.28em) eta^dagger |Omega⟩ =sum_(j) (-1)^j #h(0.25em) attach(|(0 #h(0.25em) ⋯ #h(0.25em) 0 #h(0.25em) ↕ #h(0.25em) 0 #h(0.25em) ⋯ #h(0.25em) 0)⟩, t: (j)), \
  #h(0.28em) #h(0.28em) (eta^dagger)^2|Omega⟩ = sum_(j,k) (-1)^(j+k)attach(|0 ⋯ 0 ↕ 0 ⋯ 0 ↕ 0 ⋯ 0⟩, t: (j k)), #h(0.28em) #h(0.28em) ⋯ \
  ⋯, #h(0.28em) #h(0.28em) (eta^dagger)^L|Omega⟩ = |(↕ #h(0.25em) ↕ #h(0.25em) ⋯ #h(0.25em) ↕ #h(0.25em) ↕)⟩,
$<eq:HubbardQP>
 where $0$ denotes an empty site, $arrow.t$ and $arrow.b$ denote sites with one of the two types of spins, and $arrow.t.b$ denotes a doubly occupied site, which we refer to as a doublon.

As evident from @eq:HubbardQP, the state $(eta^dagger)^n|Omega⟩$ consists of $n$ momentum $pi$ doublon “quasiparticles” dispersing around the system, so that the full state has momentum $n pi$.

As we will discuss later in @subsec:othertowers and @sec:unifiedformalism, the quasiparticle nature of eigenstates is a general feature of towers of QMBS.

Several of the analytically tractable towers of states in the Hubbard model, including the ones of @eq:HubbardQP do not exhibit a volume-law scaling of EE @eq:HubbardQP, owing to their quasiparticle nature.
While some of these towers are also in the middle of the full many-body energy spectrum, to really qualify as examples of QMBS, they should be in the middle of the spectrum #emph[after] resolving symmetries of the system @d2016quantum @mondaini2018comment.

However, for the simplest tractable towers such as @eq:HubbardQP, it turns out that they are the only states within their quantum number sector after resolving the spin and pseudospin $S U ( 2 )$ symmetries of @eq:su2syms @vafek2017entanglement, hence they are not considered as examples of QMBS in the Hubbard model.#footnote[There are other analytically tractable towers in $H_("Hub")$ obtained by the repeated action of $eta^dagger$ on certain spin-polarized eigenstate of $H_("Hub")$, which are not the only ones in their quantum number sector, are in the middle of the spectrum, and have a sub-volume law scaling of EE @vafek2017entanglement.  These should be considered examples of QMBS in the Hubbard model.]

Nevertheless, @moudgalya2020eta @mark2020eta showed that local terms can be added to the Hubbard model that break either one of the two $S U ( 2 )$ symmetries and translation symmetry while preserving some of the analytically tractable towers as eigenstates.
Such models are said to exhibit a Restricted Spectrum Generating Algebra (RSGA) @moudgalya2020eta, and we will discuss its precise statement in @moudgalya2020eta.

The remaining towers of states in such models are generically in the middle of the spectrum after resolving all the conventional symmetries of the model, and hence are examples of towers of QMBS.
For example, the states of the vacuum tower $"{" (eta^dagger)^n |Omega⟩ "}"$ are exact eigenstates for the Hubbard model with additional electrostatic terms, i.e.,

$
  H_("scar") = H_("Hub") + sum_(⟨bold(r), bold(r)′⟩)) V_(bold(r)),bold(r)′ S^z_(bold(r)) S^z_(bold(r))′,
$<eq:Int>
 where $V_(bold(r), bold(r)′)$'s are arbitrary real coefficients.

This Hamiltonian $H_("scar")$ breaks the $S U ( 2 )$ symmetries of $H_("Hub")$, and hence the states of the tower of @eq:HubbardQP are examples of QMBS eigenstates of $H_("scar")$.

An exhaustive search of such nearest-neighbor terms that preserve $"{" (eta^dagger)^n |Omega⟩ "}"$ as exact eigenstates was performed in @mark2020eta, which includes the Hamiltonian of @eq:HInt.

Further, @moudgalya2020eta identified some such terms and provided sufficient conditions for the preservation of such towers originating from an SGA, a formalism we will briefly discuss in @sec:unifiedformalism.

=== Ferromagnetic Towers <ferromagnetic-towers>

Notice that the SGA or dynamical symmetry is similar to systems where an $S U ( 2 )$ symmetry is “broken” by a constant magnetic field.
Indeed, starting with an $S U ( 2 )$-symmetric Hamiltonian $H_0$, adding magnetic field $B$ results in an SGA for the usual spin $S U ( 2 )$ symmetry

$ H_B = H_0 + B S^z #h(0.17em) #h(0em) #h(0em) [ H_B ,  S^(+) ] = B S^(+) #h(0.17em) #h(0em) #h(0em) [ H_B ,  arrow(S)^2 ] = 0 #h(0.17em) #h(0em) #h(0em) [ H_B ,  S^z ] = 0 . $<eq:magneticSGA>

For example, $H_0$ can be the Hubbard model of @eq:FermiHubbard, or the one-dimensional spin-1/2 Heisenberg model given by

$
  H_0 = sum_(j) J_j arrow(S)_j∙ arrow(S)_(j+1).
$<eq:heisenberg>

These Hamiltonians admit an exactly solvable “ferromagnetic” states of the form $|psi_0⟩ = |↓ ⋯ ↓⟩$, say with energy $E_0$.

The SGA condition of @eq:magneticSGA ensures the existence of a “ferromagnetic tower” of eigenstates $"{" (S^+)^n |psi_0⟩ "}"$, which are exact eigenstates of the Hamiltonian $H_B$ with energies $( E_0 + B n )$ for $0 lt.eq n lt.eq L + 1$.

While the states in this ferromagnetic tower of $H_B$ are not considered scars of the Hamiltonian, local perturbations that break the SGA of @eq:magneticSGA (for example, ones that that do not commute with $arrow(S)^2$) can be added that preserved the eigenstates of the ferromagnetic tower, leading to the features we discussed for the vacuum tower of the Hubbard model of @eq:FermiHubbard.

An exhaustive search for such types of terms was performed in @mark2020eta.

This led to the discovery of physically relevant models with the ferromagnetic tower as QMBS, including some terms $H_"DMI"$ with a Dzyaloshinskii-Moriya Interaction (DMI) @dzyaloshinsky1958thermodynamic, @moriya1960anisotropic @dooley2021robust, e.g.,

$
  H_("DMI") = sum_(j) hat(z)∙(arrow(S)_j times arrow(S)_(j+1)) = sum_(j) (S^x_j S^y_(j+1) - S^y_j S^x_(j+1)).
$ <eq:DMIexample>

=== Spin-1 XY Model <spin-1-xy-model>

Similar towers of QMBS are found in the spin-1 XY model @schecter2019weak, given by the Hamiltonian

$
  H_("XY") = J sum_(⟨bold(r), bold(r)′⟩) (S^x_(bold(r)) S^x_(bold(r))′ + S^y_(bold(r)) S^y_(bold(r))′) + h sum_(bold(r)) S^z_(bold(r)) + D sum_(bold(r)) (S^z_(bold(r)))^2,
$<eq:spin1XY>
 where $⟨bold(r), bold(r)′⟩$ denote nearest-neighboring sites on a lattice, $"{" S^alpha_(bold(r)) "}"$, $alpha in ( x ,  y ,  z )$ denote the spin-1 operators on site $bold(r)$.

On a general lattice, $H_"XY"$ only has a conventional $U ( 1 )$ symmetry generated by the total spin operator $sum_(bold(r))(S^z_(bold(r)))$, but it possesses simple spin-polarized such as $|Omega⟩ = |- ⋯ -⟩$ and $|macron(Omega)⟩ = |+ ⋯ +⟩$, where $-$ and $+$ denote on-site spin configurations with $S^z = - 1$ and $S^z = + 1$ respectively.

@schecter2019weak showed the existence of a tower of QMBS that connects the states $|Omega⟩$ and $|macron(Omega)⟩$, of the form $"{" (Q^dagger)^n |Omega⟩ "}"$ with energies $( 2 h n )$, where $Q^dagger equiv sum_(bold(r)) e^(i bold(pi)∙ bold(r)) (S^+_(bold(r)))^2$ is the quasiparticle creation operator, similar to $eta^dagger$ of @eq:etaops.

Indeed, in one dimension, the tower of states consists of multiple quasiparticles with momentum $pi$, similar to @eq:HubbardQP
$
  |Omega⟩ = |(- #h(0.25em) - #h(0.25em) ⋯ #h(0.25em) - #h(0.25em) -)⟩, #h(0.28em) #h(0.28em) Q^dagger |Omega⟩ =sum_(j) (-1)^j #h(0.25em) attach(|(- #h(0.25em) ⋯ #h(0.25em) - #h(0.25em) + #h(0.25em) - #h(0.25em) ⋯ #h(0.25em) -)⟩, t: (j)), \
  #h(0.28em) #h(0.28em) (Q^dagger)^2|Omega⟩ = sum_(j,k) (-1)^(j+k)attach(|- ⋯ - + - ⋯ - + - ⋯ -⟩, t: (j k)), #h(0.28em) #h(0.28em) ⋯ \
  ⋯, #h(0.28em) #h(0.28em) (Q^dagger)^L|Omega⟩ = |macron(Omega)⟩ = |(+ #h(0.25em) + #h(0.25em) ⋯ #h(0.25em) + #h(0.25em) +)⟩,
$<eq:spin1XYQP>

As discussed in @schecter2019weak, the states of this tower are generically in the middle of the spectrum of the $H_"XY"$ after resolving all the conventional symmetries of the model, and they have a sub-volume scaling of the entanglement entropy, (as we also discuss in @subsec:QPentanglement), hence they form examples of QMBS.
These features are also evident in @fig:scarproperties_ent, where we show the entanglement entropy of the eigenstates of the spin-1 XY model within a quantum number sector along with those for the QMBS eigenstates.
These QMBS are similar to those in $H_("scar")$ of @eq:HInt, and the $D = 0$ limit of the Hamiltonian of @eq:HInt admits an SGA with the operator $Q^dagger$, similar to the Hubbard model (see @eq:HubbardSGA).

In fact, @mark2020eta established an exact correspondence between the tower of QMBS of @eq:HubbardQP in the Hubbard and related models and tower of QMBS in the spin-1 XY model of @eq:HubbardQP.

In particular, the lowest and highest eigenstates of the towers are respectively identified (i.e., $|- ⋯ -⟩$ and $|+ ⋯ +⟩$ correspond to $|0 ⋯ 0⟩$ and $|↕ ⋯ ↕⟩$), and the raising operator $Q^dagger$ in the spin-1 XY model was identified with the $eta^dagger$ in the Hubbard model.

== Survey of other towers in the literature <subsec:othertowers>

// [figvision] imgs/spin1_xy_EE.png
// Panel a is a scatter plot showing bipartite entanglement entropy on the vertical axis versus eigenstate energy
// on the horizontal axis for a spin-one XY model. The energy axis ranges from minus one point five to plus one
// point five, while the entropy axis ranges from zero to two point five. A dense cloud of black points forms a
// broad band representing thermal eigenstates. Scattered above this thermal band are distinct red dots,
// depicting the quantum many-body scar eigenstates. A single red dot near zero energy is encircled, indicating
// the only scar state within the zero total spin sector. The trend shows scar states exhibit anomalously high
// entanglement.
#figure(placement: top, image("imgs/spin1_xy_EE.png", width: 246pt),
  caption: [
    (Color online) Bipartite Entanglement Entropy (EE) $S_A$ as a function of eigenstate energy $E$ of the one-dimensional spin-1 XY model of @eq:spin1XY(figure reproduced from @schecter2019weak). Data shown for a system of size $L = 10$ with the parameters $( h ,  D ,  J ) = ( 1 ,  0.1 ,  0.1 )$ with OBC within the sector zero total spin.

    The red dots depict the EE for the QMBS eigenstates, which lie in other quantum number sectors (apart from the circled state at $E = 1$), but nevertheless are clear outliers among other eigenstates in the spectrum.
    Inset: Logarithmic scaling of the EE of the circled QMBS eigenstate as a function of the system size.
  ]
) <fig:scarproperties_ent>

=== AKLT Model <aklt-model>

The examples of towers of QMBS discussed in @subsec:SGAtowers share the property that the raising and lowering operators for the towers of states were Hermitian conjugates of each other, a property that is a direct consequence of the underlying SGA of @eq:SGA.

However, not all towers of QMBS in the literature have this property.
In fact the first example of a tower of QMBS, found in the spin-1 AKLT model in @moudgalya2018a, violates this condition.

The AKLT model consists of $L$ spin-1's, and its Hamiltonian reads

$
  (H_("AKLT")) = sum_(j)(P^(2)_(j, j+1)) = sum_(j)((frac(1, 3) + frac(1, 2)(arrow(S)_j∙ arrow(S)_(j+1)) + frac(1, 6)(arrow(S)_j∙ arrow(S)_(j+1))^2)),
$<eq:AKLTHamiltonian>
 where the nearest-neighbor terms $P_(j ,  j + 1)^( 2 )$ are projectors of two neighboring spin-1's on sites $j$ and $j + 1$ into total angular momentum spin-$2$ state, the sum over $j$ runs from $1$ to $L$ or $L - 1$ for periodic boundary conditions (PBC) or open boundary conditions (OBC) respectively, and the position subscripts are modulo $L$ for PBC.

The ground state $|G⟩$ of $(H_("AKLT"))$ of @eq:AKLTHamiltonian, also sometimes referred to as the AKLT state, is a frustration-free ground state, i.e. $P^(2)_(j, j+1)|G⟩ = 0$ for any $j$, and it can be elegantly expressed in terms of Schwinger bosons and dimers @aklt1987rigorous.

Exact expressions for several excited states in $(H_("AKLT"))$ were first constructed in the language of dimers in @moudgalya2018a, following the construction of two exact low-energy eigenstates in @moudgalya2018a.

While many such excited states are energetically close to the edge of the spectrum, an equally-spaced tower of exact eigenstates with energies in the bulk of the spectrum was obtained for even system sizes with PBC and for all system sizes with OBC.

The states of this tower are composed of multiple non-interacting quasiparticles dispersing with momentum $k = pi$ (for PBC) on top of the ground state $|G⟩$, similar to the tower of @eq:HubbardQP in the Hubbard model $H_("Hub")$.

The quasiparticle creation operator for this tower in $(H_("AKLT"))$ reads $Q^dagger = sum_j ( - 1 )^j ( S_j^(+) )^2$, and the states $"{" (Q^dagger)^n |G⟩ "}"$ are eigenstates of $(H_("AKLT"))$ with energies $( E = 2 n )$, total spin $( s = 2 n )$, and its $z$-projection $( S_z = 2 n )$.
Hence they form an extensive tower of states starting from the ground state $|G⟩$ with energy $E = 0$ to the highest excited “ferromagnetic” state $|F⟩$ with energy $E = L$.
These eigenstates reside in the bulk of the spectrum #emph[after] resolving all known symmetries of $(H_("AKLT"))$, which include translation (for PBC), inversion, and $S U ( 2 )$@moudgalya2018a.

Moreover, these states obey a sub-volume-law scaling of their entanglement entropy, owing to their quasiparticle structure @moudgalya2018b, as we will show in @moudgalya2018b.

Note that as a consequence of the $S U ( 2 )$ symmetry of $(H_("AKLT"))$, there is a multiplet of $( 4 n + 1 )$ eigenstates associated with each “highest-weight” state $(Q^dagger)^n|G⟩$.

The “lowest-weight” states of the multiplet read $Q^n|G⟩$, where $Q = sum_j ( - 1 )^j ( S_j^(-) )^2$, and these are eigenstates of $(H_("AKLT"))$ with energies $( E = 2 n )$, total spin $( s = 2 n )$, and its $z$-projection $( S_z = - 2 n )$.
Hence, unlike the towers discussed in @subsec:SGAtowers, the $Q$ operator is not a lowering operator for the tower created by the action of the $Q^dagger$ operator, but they create the lowest and highest states of a multiplet.
The lowering operator for the tower created by $Q^dagger$ is believed to be a distinct (possibly non-local) operator $Q'$, as shown in @fig:towerpyramid.

=== General Structure of QMBS Towers <general-structure-of-qmbs-towers>

We now comment on some general features of QMBS towers that appear in the literature.
As evident from the above examples, towers of QMBS are comprised of “non-interacting” quasiparticles on top a product state (or more generally, on an MPS eigenstate with finite bond-dimension).
Heuristically, the interaction between quasiparticles can be forbidden in two distinct ways, which is one distinguishing feature between the QMBS in the AKLT model and those discussed in @subsec:SGAtowers.

First, interactions can be forbidden when there are no terms in the Hamiltonian that energetically penalize configurations of nearest-neighbor quasiparticles, which occurs in the examples discussed in @subsec:SGAtowers.

For example, in the $eta$-pairing tower of @eq:HubbardQP, the energy of the configuration $|↕ #h(0.25em) ↕⟩$ with quasiparticles beside each other is not affected by any of the terms in the Hamiltonian $H_("scar")$.

On the other hand, the quasiparticles can have “emergent kinetic constraint”@iadecola2020quantum, where configurations with quasiparticles beside each other do not appear in the wavefunctions of states of the tower.
Such a scenario occurs, for example, in the quasiparticle in the QMBS of the AKLT model, where the quasiparticle creation operator satisfies $(S^+_j)^2 (S^+_(j+1))^2|G⟩ = 0$, implicitly disallowing any configuration where quasiparticles are beside each other.
Towers of QMBS with this phenomenology were also found in the spin-$S$ $S O ( 3 )$-symmetric AKLT models @moudgalya2018a, @moudgalya2018b, spin-$S$ $S O ( 2 S + 1 )$-symmetric AKLT models in @moudgalya2018a @moudgalya2018b, and the towers of states in certain Domain-Wall-Conserving (DWC) models studied in @iadecola2020quantum, which share several features with the QMBS in the AKLT models.

These microscopic properties of quasiparticles can be used to systematically construct Hamiltonians with QMBS.
For examples, such properties were utilized in @moudgalya2020large to systematically construct scarred models based on parent Hamiltonians of Matrix Product States (MPS) @perezgarcia2007matrix.

In particular, this led to the discovery of a 6-parameter family of Hamiltonians with $"{" (Q^dagger)^n|G⟩ "}"$ as QMBS, of which $(H_("AKLT"))$ was a special case (The same family was independently discovered in @mark2020unified using a different approach, which we will discuss in @subsec:SGAbased).

Similar approaches can be used to systematically construct families of Hamiltonians with the same tower of QMBS as the spin-1 XY model (see @eq:spin1XY) or families of Hamiltonians with $eta$-pairing states of @eq:spin1XY)

=== Miscellaneous Examples <miscellaneous-examples>

#figure(cetz.canvas(length: 1.0cm, {
  import cetz.draw: *
  let bs = (thickness: 1pt, paint: black)
  let ms = (thickness: 0.9pt, paint: black)
  let ds = (thickness: 1pt, paint: black, dash: "dotted")

  // ---------- Panel (a): tower ----------
  content((-4.2, 7.45), anchor: "west", text(size: 11pt)[(a)])
  let xL = -3.0
  let xR = -1.8
  let xm = -2.4
  let rung(y) = line((xL, y), (xR, y), stroke: bs)
  let upArr(y1, y2) = {
    bezier((xL, y1), (xL, y2), (xL - 0.5, (y1 + y2) / 2), stroke: bs, mark: (end: (symbol: "stealth", fill: black)))
    content((xL - 0.6, (y1 + y2) / 2), anchor: "east", $Q^dagger$)
  }
  let dnArr(y1, y2) = {
    bezier((xR, y2), (xR, y1), (xR + 0.5, (y1 + y2) / 2), stroke: bs, mark: (end: (symbol: "stealth", fill: black)))
    content((xR + 0.6, (y1 + y2) / 2), anchor: "west", $Q'$)
  }
  content((xm, 7.3), $0$)
  rung(6); rung(5)
  upArr(6, 7.0); dnArr(6, 7.0)
  upArr(5, 6); dnArr(5, 6)
  circle((xm, 4.2), radius: 0.045, fill: black, stroke: none)
  circle((xm, 3.6), radius: 0.045, fill: black, stroke: none)
  circle((xm, 3.0), radius: 0.045, fill: black, stroke: none)
  rung(2); rung(1)
  upArr(1, 2); dnArr(1, 2)
  upArr(2, 3)
  dnArr(0.0, 1)
  content((xm, -0.3), $0$)

  // ---------- Panel (b): pyramid ----------
  content((0.1, 7.3), anchor: "west", text(size: 11pt)[(b)])
  let ux = 1.05
  let uy = 0.72
  let bx = 1.4
  let by = 0.0
  let P(dx, dy) = (bx + dx * ux, by + dy * uy)
  let dot(dx, dy) = circle(P(dx, dy), radius: 0.13, fill: black, stroke: none)

  // axes
  line((bx, by), (bx, by + 8.7 * uy), stroke: bs, mark: (end: (symbol: "stealth", fill: black)))
  line((bx, by), (bx + 8.8 * ux, by), stroke: bs, mark: (end: (symbol: "stealth", fill: black)))
  content((bx + 0.2, by + 8.75 * uy), anchor: "west", text(size: 12pt)[$N_(D W) = 2 n$])
  content((bx + 8.8 * ux, by - 1.02), anchor: "east", text(size: 12pt)[$m + n = sum_j P_j^1$])
  for i in range(0, 9) {
    line((bx + i * ux, by - 0.09), (bx + i * ux, by + 0.09), stroke: bs)
    content((bx + i * ux, by - 0.22), anchor: "north", text(size: 11pt)[#str(i)])
  }
  for j in (2, 4, 6, 8) {
    line((bx - 0.09, by + j * uy), (bx + 0.09, by + j * uy), stroke: bs)
    content((bx - 0.2, by + j * uy), anchor: "east", text(size: 11pt)[#str(j)])
  }

  // dotted triangle outline
  line(P(0, 0), P(4, 8), stroke: ds)
  line(P(4, 8), P(8, 0), stroke: ds)

  // dots
  dot(0, 0); dot(8, 0)
  for i in range(1, 8) { dot(i, 2) }
  for i in range(2, 8) { dot(i, 4) }
  for i in range(3, 6) { dot(i, 6) }
  dot(4, 8)

  // horizontal double arrows
  let hArr(dx1, dx2, dy) = line((bx + (dx1 + 0.3) * ux, by + dy * uy), (bx + (dx2 - 0.3) * ux, by + dy * uy), stroke: ms, mark: (start: (symbol: "stealth", fill: black), end: (symbol: "stealth", fill: black)))
  hArr(3, 4, 6); hArr(4, 5, 6)
  for i in range(2, 7) { hArr(i, i + 1, 4) }
  for i in range(1, 7) { hArr(i, i + 1, 2) }

  // diagonal arrows
  let dArr(dx1, dy1, dx2, dy2) = line(P(dx1 + 0.12 * (dx2 - dx1), dy1 + 0.15 * (dy2 - dy1)), P(dx1 + 0.82 * (dx2 - dx1), dy1 + 0.82 * (dy2 - dy1)), stroke: ms, mark: (end: (symbol: "stealth", fill: black)))
  // left edge (R dagger, up-right)
  dArr(0, 0, 1, 2); dArr(1, 2, 2, 4); dArr(2, 4, 3, 6); dArr(3, 6, 4, 8)
  // right edge (R prime dagger, up-left)
  dArr(8, 0, 7, 2); dArr(7, 2, 6, 4); dArr(6, 4, 5, 6); dArr(5, 6, 4, 8)
  // interior
  dArr(2, 2, 3, 4); dArr(3, 4, 4, 6); dArr(5, 4, 4, 6); dArr(6, 2, 5, 4)
  content(P(2.15, 5.2), anchor: "east", text(size: 13pt)[$R^dagger$])
  content(P(2.15, 3.0), anchor: "east", text(size: 13pt)[$R^dagger$])
  content(P(5.85, 5.2), anchor: "west", text(size: 13pt)[$R'^dagger$])
  content(P(5.85, 3.0), anchor: "west", text(size: 13pt)[$R'^dagger$])

  // P / P' labels
  content(P(3.5, 4.55), text(size: 12pt)[$cal(P)^dagger$])
  content(P(3.5, 3.45), text(size: 12pt)[$cal(P)'^dagger$])
  content(P(4.5, 6.55), text(size: 12pt)[$cal(P)^dagger$])
  content(P(4.5, 5.45), text(size: 12pt)[$cal(P)'^dagger$])
  content(P(4.5, 2.55), text(size: 12pt)[$cal(P)^dagger$])
  content(P(4.5, 1.45), text(size: 12pt)[$cal(P)'^dagger$])

  // state labels
  content(P(4, 8.7), $|ZZ_2⟩$)
  content(P(1.4, 4), anchor: "east", $|cal(S)_n^"IS"⟩$)
  content(P(7.6, 4), anchor: "west", $|cal(S)_n'^"IS"⟩$)
  content(P(3, 1.2), $|cal(S)_(1,2)^"pyr."⟩$)
  content(P(0.15, 0.55), anchor: "west", box(fill: white, inset: 1.5pt)[$|Omega⟩$])
  content(P(7.85, 0.55), anchor: "east", box(fill: white, inset: 1.5pt)[$|Omega'⟩$])
}),
  caption: [
    Various structures of QMBS. (a) Equally spaced tower of QMBS with a raising operator $Q^dagger$ and a lowering operator $Q'$, which might or might not be the Hermitian conjugate of $Q^dagger$.

    The raising operator is usually a sum of single-site operators, although there are examples where it is a sum of multi-site operators or completely non-local.

    $Q^dagger$ and $Q'$ annihilate the highest and lowest states of the tower respectively.

    (b) Figure reproduced from @mark2020unified showing a pyramid of QMBS in a certain domain-wall conserving model.
    Each dot represents a QMBS eigenstate labelled by certain quantum numbers $N_(D W)$ and $sum_j P_j^1$.

    The various QMBS eigenstates are related ladder operators such as $(cal(P))^dagger$, $(cal(P))′^dagger$, $R^dagger$, etc.

    This shows the wide variety of structures of QMBS that can occur in physically relevant Hamiltonians.
  ]
) <fig:towerpyramid>

All of the examples of QMBS discussed above consist of towers of single-site quasiparticles, i.e., the states are obtained by the multiple action of a quasiparticle creation operator that is a sum of on-site terms.
A different class of models with towers of QMBS are those with raising operators that are multi-site quasiparticles, i.e., the quasiparticle creation operator is a sum of multi-site but local terms.
These include the second tower of the spin-1 XY model discovered in @schecter2019weak and subsequently studied in @chattopadhyay2019quantum, where the origin of towers of eigenstates was traced to the existence of “virtual entanglement pairs”.
Large classes of models with multi-site quasiparticle QMBS were constructed based on the Onsager algebra in @shibata2020onsager, @vanvoorden2021disorder, and also systematically constructed from parent Hamiltonians of MPS in @moudgalya2020large.

Finally, we note that equally spaced eigenstates and revivals in non-integrable models are known to appear in several other systems and lattices @hudomal2020quantum, @lee2020exact @hart2020compact @chertkov2021motif, sometimes without a quasiparticle structure of the eigenstates.
In addition, examples of QMBS where the “raising operator” $Q^dagger$ is non-local were constructed in the context of systems with quantum group symmetries @odea2020from, as well as in the DWC model @mark2020unified.

A tower of QMBS created by a non-local operator also appears in models constructed to embed “rainbow states” in the spectrum @langlett2021rainbow, which, unlike most examples of QMBS, obey a volume-law scaling of EE under most choices of the bipartition while still violating ETH.
Another example of a tower of QMBS and associated revivals with volume-law scaling of EE was shown to exist in a certain multi-component system @zhao2021orthogonal.

Apart from simple towers of states, @zhao2021orthogonal @mark2020unified @odea2020from construct examples of “pyramids” of QMBS created by the actions of multiple raising and lowering operators on a simple eigenstate, e.g., as shown in @fig:towerpyramid.

== Entanglement of quasiparticle towers of states <subsec:QPentanglement>

#figure(cetz.canvas(length: 1.0cm, {
  import cetz.draw: *
  let half = 0.42
  let bs = (thickness: 1.0pt, paint: black)
  let dstroke = (thickness: 1pt, paint: black, dash: "dotted")
  let hl(cy, x1, x2) = line((x1, cy), (x2, cy), stroke: bs)
  let vl(cx, y1, y2) = line((cx, y1), (cx, y2), stroke: bs)
  let mbox(cx, cy, m, top, bot) = {
    rect((cx - half, cy - half), (cx + half, cy + half), stroke: bs, fill: none)
    content((cx, cy), text(size: 13pt, m))
    if top { vl(cx, cy + half, cy + half + 0.5) }
    if bot { vl(cx, cy - half, cy - half - 0.5) }
  }
  let mcirc(cx, cy, m) = { circle((cx, cy), radius: 0.4, stroke: bs, fill: none); content((cx, cy), text(size: 6.5pt, m)) }
  let dots(cx, cy) = content((cx, cy), text(size: 10pt)[....])
  let yt = 1.4
  let yb = -1.5

  // (a)
  content((-0.25, yt + 0.75), anchor: "west", text(size: 10pt)[(a)])
  mbox(1.15, yt, $M$, true, true)
  hl(yt, 0.73, 0.35); content((0.3, yt + 0.18), anchor: "east", $chi_m$)
  hl(yt, 1.57, 1.95); content((2.0, yt + 0.18), anchor: "west", $chi_m$)
  content((1.15, yt + 0.92), anchor: "south", $d$)
  content((1.15, yt - 0.92), anchor: "north", $d$)

  // (b)
  content((2.6, yt + 0.75), anchor: "west", text(size: 10pt)[(b)])
  content((3.2, yt), anchor: "west", $cal(O) =$)
  mcirc(4.7, yt, $b_M^l$)
  mbox(5.8, yt, $M$, true, true); hl(yt, 5.1, 5.38)
  hl(yt, 6.22, 6.55); dots(6.95, yt); hl(yt, 7.35, 7.68)
  mbox(8.1, yt, $M$, true, true); hl(yt, 8.52, 8.63)
  mbox(9.05, yt, $M$, true, true); hl(yt, 9.47, 9.58)
  mbox(10.0, yt, $M$, true, true); hl(yt, 10.42, 10.53)
  mbox(10.95, yt, $M$, true, true); hl(yt, 11.37, 11.7); dots(12.1, yt); hl(yt, 12.5, 12.83)
  mbox(13.25, yt, $M$, true, true); hl(yt, 13.67, 14.0)
  mcirc(14.4, yt, $b_M^r$)

  // (c)
  content((-0.25, yb + 1.15), anchor: "west", text(size: 10pt)[(c)])
  mbox(1.0, yb + 0.62, $A$, false, false)
  hl(yb + 0.62, 0.58, 0.2); content((0.15, yb + 0.8), anchor: "east", $chi$)
  hl(yb + 0.62, 1.42, 1.8); content((1.85, yb + 0.8), anchor: "west", $chi$)
  vl(1.0, yb + 0.2, yb - 0.2); content((1.18, yb), $d$)
  mbox(1.0, yb - 0.62, $M$, false, true)
  hl(yb - 0.62, 0.58, 0.2); content((0.15, yb - 0.44), anchor: "east", $chi_m$)
  hl(yb - 0.62, 1.42, 1.8); content((1.85, yb - 0.44), anchor: "west", $chi_m$)
  content((1.0, yb - 1.52), anchor: "north", $d$)
  content((2.5, yb), anchor: "west", $=$)
  mbox(3.5, yb, $B$, false, true)
  hl(yb, 3.08, 2.75); content((2.7, yb + 0.18), anchor: "east", $chi chi_m$)
  hl(yb, 3.92, 4.25); content((4.3, yb + 0.18), anchor: "west", $chi chi_m$)
  content((3.5, yb - 0.92), anchor: "north", $d$)

  // (d)
  content((5.0, yb + 1.15), anchor: "west", text(size: 10pt)[(d)])
  content((5.55, yb), anchor: "west", $cal(O) |psi⟩ =$)
  mcirc(7.35, yb, $b_B^l$)
  mbox(8.3, yb, $B$, false, true); hl(yb, 7.75, 7.88)
  hl(yb, 8.72, 9.0); dots(9.35, yb); hl(yb, 9.7, 9.98)
  mbox(10.4, yb, $B$, false, true); hl(yb, 10.82, 10.93)
  mbox(11.35, yb, $B$, false, true)
  hl(yb, 11.77, 11.9); hl(yb, 12.0, 12.13)
  line((11.95, yb + 1.0), (11.95, yb - 1.3), stroke: dstroke)
  content((12.05, yb + 1.05), anchor: "west", $S <= log (chi chi_m)$)
  mbox(12.55, yb, $B$, false, true); hl(yb, 12.97, 13.08)
  mbox(13.5, yb, $B$, false, true); hl(yb, 13.92, 14.2); dots(14.55, yb); hl(yb, 14.9, 15.0)
  mbox(15.4, yb, $B$, false, true); hl(yb, 15.82, 16.05)
  mcirc(16.45, yb, $b_B^r$)
}),
  caption: [
    (a) $d times d times chi_m times chi_m$ tensor representing an MPO. $d$ is the physical dimension, and $chi_m$ is the bond dimension (b) Operator $(cal(O))$ represented in MPO form (c) Action of an MPO $M$ with bond dimension $chi_m$ on an MPS $A$ with bond dimension $chi$ gives an MPS $B$ with bond dimension $chi chi_m$ (d) MPS representation of the state $(cal(O)) |psi⟩$. The entanglement entropy of the state $(cal(O))|psi⟩$ is bounded by $log (chi chi_m)$.
  ]
) <fig:MPO>

We now turn to the EE of states composed of multiple quasiparticles on a fixed background MPS, which form the towers of QMBS eigenstates in several models in @subsec:SGAtowers and

For pedagogical reasons, we restrict ourselves to one-dimensional systems and states of the form

$
  |psi_n⟩ = (Q^dagger)^n |psi_0⟩, #h(0.28em) #h(0.28em) Q^dagger = sum_(j) e^(i k j) q^dagger_j,
$<eq:psinform>
 where $q_j^dagger$ is a single-site operator and $|psi_0⟩$ is a MPS.

These properties hold for the raising operators in several models with towers of QMBS, including the $eta^dagger$ and $Q^dagger$ operators in the Hubbard and AKLT models respectively.
A simple way to bound the entanglement entropy of states $"{" |psi_n⟩ "}"$ is to study its MPS form, which can be derived using the Matrix Product Operator (MPO) form @pirvu2010matrix @schollwock2011density @mcculloch2007density @verstraete2008matrix @moudgalya2018b of the creation operators $( Q^dagger )^n$ and the MPS form for $|psi_0⟩$.

Simple translation invariant operators $cal(O)$ typically admit an exact MPO representation in terms of a $d times d times chi_m times chi_m$ tensors $M$ shown in @fig:MPO.

Such an operator $cal(O)$ is depicted diagrammatically in @fig:MPO(b).

 $d$ and $chi_m$ are referred to as physical and bond dimensions of the MPO respectively, and the diagrammatic notation is analogous to that for MPS, shown in @fig:MPS(b) and discussed in @subsec:entanglement.

A state defined by the action of an MPO on an MPS has a natural MPS description in terms of the tensor $B$ depicted diagrammatically in @fig:MPO.

 $B$ is sometimes referred to as an MPO $times$ MPS @fig:MPO, and it has a bond dimension of $chi_m chi$, where $chi_m$ and $chi$ are the bond dimensions of the MPO and MPS respectively.

Hence, according to @eq:MPSEEbound, the EE of the state $B$ represents is bounded by $S lt.eq log (chi_m chi)$ (see @moudgalya2018b).

In the following, we use this bound to provide a simple proof for the sub-volume law EE scaling of the towers of QMBS eigenstates discussed in @subsec:SGAtowers and

Using standard methods @crosswhite2008fsa, @motruk2016density @moudgalya2018b, we can construct an efficient MPO of bond dimension $chi_m = n + 1$ for the operator $( Q^dagger )^n$ ($n$ being an integer).

Although a general expression is complicated (see Appendix A of @odea2020from),#footnote[The elements $M_(alpha ,  beta)$ of the MPO tensor and the boundary vectors $( b_M^l )_alpha$ and $( b_M^r )_alpha$ in the general case read $M_(alpha beta) = e^(i (n - alpha + 1) k) (q^dagger)^(beta - alpha) times frac((n!)^(beta - alpha)\/n, (beta - alpha)!) delta_(beta >= alpha), space (b_M^l)_alpha = delta_(alpha 1), space (b_M^r)_alpha = delta_(alpha, n + 1)$]

in the simple case when $( q_j^dagger )^2 = 0$ and $k = pi$, which happens in several QMBS models including the Hubbard and AKLT model, the MPO tensor and the boundary vectors read:

$
  M = mat(delim: paren, (-1)^n 𝟙 & (-1)^n q^dagger & 0 & … & 0; 0 & (-1)^(n-1) 𝟙 & (-1)^(n-1) q^dagger & ⋱ & ⋮; ⋮ & ⋱ & ⋱ & ⋱ & 0; ⋮ & ⋱ & ⋱ & -𝟙 & -q^dagger; 0 & … & … & 0 & 𝟙) \
  (b_M^l)_alpha = mat(delim: paren, 1 & 0 & ⋯ & 0), space space space (b_M^r)_alpha = mat(delim: paren, 0 & ⋯ & 0 & 1)
$<eq:towerMPO>

If the bond dimension of the MPS representation of $|psi_0⟩$ is $D$, the state $|psi_n⟩$ has an MPS representation with bond dimension $chi = D ( n + 1 )$.

This establishes an upper bound on the EE of the states of the tower to grow as $S lt.eq log [ D ( n + 1 ) ]$.

For $D$ that is independent of system size (since $|psi_0⟩$ is typically the ground state), and for a state $|psi_n⟩$ with an extensive number of quasiparticles (meaning $n prop L$), the EE thus grows with system size $L$ as $S tilde log L$, a sub-volume scaling.

These results are consistent with the sub-volume law scaling found in states with multiple identical quasiparticles on top of a product state, which has been studied in a variety of settings @vafek2017entanglement, @castro2018entanglement @schecter2019weak, including the scaling depicted in the inset of @fig:scarproperties_ent.

Further, exact results for the EE of certain quasiparticle eigenstates that appear as QMBS in various systems, including those where the raising operators do not exactly obey the precise properties of @eq:psinform, have been obtained in @vafek2017entanglement, @schecter2019weak @chattopadhyay2019quantum @odea2020from, and they all follow a similar sub-volume law scaling.

Indeed, MPOs with bond dimension $chi_m prop n$ can also be obtained for operators $( Q^dagger )^n$ when the quasiparticle creation operators $q_j^dagger$ have supports over multiple sites or sometimes also when they are non-local @odea2020from, although writing out their explicit form can be tedious.

These results show that towers of QMBS exhibit an EE scaling that is inconsistent with ETH predictions.

On a different note, the MPS forms of the QMBS can also be used to identify “topological” properties such as projective representations of the MPS or degeneracies in their entanglement spectrum, as shown for the AKLT model in @moudgalya2018b.

== Revivals from simple initial states <subsec:revivals>

// [figvision] imgs/fidelity_own_wide.png
// No figure image was included with the request, so I cannot describe its panels, axes, series, colours, or
// annotations. Please attach the image (or provide its visual details) and I will produce a panel-by-panel
// reconstruction in plain prose following the requested format, with concrete axis ranges, line styles, labels,
// and trends.
#figure(placement: top, image("imgs/fidelity_own_wide.png", width: 252pt),
  caption: [
    (Color online) Fidelity of initial states of the form of $|psi_("in")(xi)⟩$ of @eq:specialinitialstates for the one-dimensional spin-1 XY Hamiltonian of @eq:specialinitialstates with OBC and $h = 1$ and system size $L = 10$.

    The revivals occur due to the equal spacing of the QMBS eigenstates, hence the nature of the plot does not depend on the precise scarred Hamiltonian.

    The time period of the revivals is $2 pi\/(cal(E))$, where $(cal(E))$ is the energy spacing between the states of the tower.
  ]
) <fig:scarproperties_dyn>

Given a quasiparticle tower of equally-spaced QMBS of the form $"{" ((Q^dagger))^n |psi_0⟩ "}"$ with $0 lt.eq n lt.eq N - 1$ such that $((Q^dagger))^N|psi_0⟩ = 0$, it is natural to ask what kinds of simple initial states can be constructed within the QMBS subspace.

The first example of such a construction was demonstrated in @iadecola2020quantum in the context of the DWC model mentioned in @iadecola2020quantum.

We illustrate this construction, focusing on one-dimensional systems where the quasiparticle creation operator $(Q^dagger)$ has the form $(Q^dagger) = sum_(j = 1)^(L)(e^(i k j)q^dagger_j)$, where $q_j^dagger$ is a strictly local operator in the vicinity of site $j$, possibly with support over multiple sites.

For simplicity, we further assume that the quasiparticle creation operators on different sites commute, i.e. $[ q_l^dagger ,  q_m^dagger ] = 0$, a feature that is true for several examples of QMBS.

A simple family of initial states that is in the scarred subspace is then given by @iadecola2020quantum @mark2020eta @ren2021deformed.

$
  |psi_("in")(xi)⟩ = product_(j = 1)^(L) exp(xi e^(i k j) q^dagger_j)|psi_0⟩ = exp(xi Q^dagger)|psi_0⟩ = sum_(n = 0)^(N) frac(xi^n, n!) ((Q^dagger))^n |psi_0⟩,
$<eq:specialinitialstates>
 where we have excluded the normalization factor that depends on the precise details of $q_j^dagger$.

Note that in several common examples of QMBS discussed in @sec:towers, $k = pi$ and $( q_j^dagger )^2 = 0$, hence $exp ( xi e^(i k j) q_j^dagger ) = ( 1 + ( - 1 )^j xi q_j^dagger )$.

The fidelity $cal(F) ( t )$ of @eq:fidelity can be directly computed starting from the states of @eq:fidelity.

If the QMBS states $"{" (Q^dagger)^n |psi_0⟩ "}"$ have energies $"{" E_0 + n(cal(E)) "}"$ under a scarred Hamiltonian $H_("scar")$, the expression for the fidelity (after including the normalization factor) reads

$
  (cal(F))(t) = frac(|⟨psi_("in")(xi)| e^(-i H_("scar") t) |psi_("in")(xi)⟩|^2, |⟨psi_("in")(xi) | psi_("in")(xi)⟩|^2) = frac(|sum_(n = 0)^(N) frac(xi^(2n) e^(-i n cal(E)t), (n!)^2)cal(N)_n|^2, |sum_(n = 0)^(N) frac(xi^(2n), (n!)^2)cal(N)_n|^2), #h(0.28em) #h(0.28em) #h(0.28em) cal(N)_n equiv ⟨psi_0|(Q)^n (Q^dagger)^n|psi_0⟩,
$<eq:scarfidelity>
 where $cal(N)_n$'s are the normalization factor of the QMBS eigenstate $(Q^dagger)^n|psi_0⟩$.

While the normalization factors $cal(N)_n$ might be in general hard to compute analytically in general, they can be explicitly evaluated in some cases, e.g., in the spin-1 XY model @iadecola2019quantum or the Hubbard model @vafek2017entanglement, which leads to dramatic simplifications in @eq:scarfidelity.

Using the expression of @eq:scarfidelity, it is easy to see that $(cal(F))(t + frac(2 pi, (cal(E)))) = (cal(F))(t)$, hence fidelity of the initial states $|psi_("in")(xi)⟩$ exhibits revivals with a time period given by $2 pi\/(cal(E))$.

In @vafek2017entanglement, we show the fidelity revivals for various values of $xi$ for the spin-1 XY model.

This periodicity is in stark contrast to the fidelity of a random state with the same energy expectation value as $|psi_("in")(xi)⟩$, which typically quickly decays to a value exponentially small in system size.

Since $|psi_("in")(xi)⟩$ is constructed by the action of $L$ one-site or two-site (depending on the number of sites $q_j^dagger$ has support on) operators $( exp ( xi e^(i k j) q_j^dagger ) )$ on $|psi_0⟩$, the bond-dimension of its MPS representation is $cal(O) ( 1 )$ more than the bond-dimension of the MPS for $|psi_0⟩$.

Hence, if $|psi_0⟩$ obeys area-law entanglement (i.e., if it admits an MPS representation of finite bond dimension), the family of states $|psi_("in")(xi)⟩$ also obeys area-law entanglement, even though some of the states $(Q^dagger)^n|psi_0⟩$ are not area-law entangled as discussed in @subsec:QPentanglement.

Due to the MPS structure of $|psi_("in")(xi)⟩$, we can construct its local parent Hamiltonian @perezgarcia2007matrix @moudgalya2020large $H_"in" ( xi )$ for which $|psi_("in")(xi)⟩$ is an exact ground state, although not necessarily unique.
An explicit construction of such a family of gapped parent Hamiltonians $H_"in" ( xi )$ is provided in @iadecola2020quantum, where they turn out to be closely related to the Rokhsar-Kivelson type Hamiltonians studied in @lesanovsky2011many.

This construction of initial states within the QMBS subspace that are gapped ground states of different Hamiltonians is highly desirable, since it provides an experimentally feasible method to build initial states that show anomalous dynamics.

= Unified Formalisms <sec:unifiedformalism>

Given the large number of models exhibiting QMBS, there have been several attempts to unify them into systematic formalisms @mori2017eth @mark2020unified @moudgalya2020eta @pakrouski2020many @ren2020quasisymmetry @odea2020from.

In spite of these works, it is not clear to date whether any of these are exhaustive, and the precise relations between these formalisms are yet to be carefully worked out.
Nevertheless, we now give a broad overview of the different approaches to unify QMBS, which roughly fall into three categories.
Throughout this section, we use $H_("scar")$ to denote the Hamiltonian of interest, i.e., the one with QMBS eigenstates, $cal(T)$ to denote the subspace spanned by the QMBS eigenstates, and $Q^dagger$ to refer to the raising operator.
In particular, we will frequently refer back to the example of the Hubbard model discussed in @subsec:SGAtowers, where $H_("scar")$ is given by @eq:Int.

For convenience of illustration, we rewrite $H_("scar")$ here and split it into three parts

$
  H_("scar") &= hat(T) + hat(U) + hat(V), \
  hat(T) &= - sum_(⟨bold(r), bold(r)′⟩) t_(bold(r), bold(r)′) hat(T)_(bold(r), bold(r)′) \
         &= - sum_(⟨bold(r), bold(r)′⟩) t_(bold(r), bold(r)′) sum_(sigma in {↑, ↓}) (c^dagger_(bold(r), sigma) c_(bold(r)′, sigma) + h.c.) \
  hat(U) &= sum_(bold(r)) (U hat(n)_(bold(r), ↑) hat(n)_(bold(r), ↓) - mu sum_(sigma in {↑, ↓}) hat(n)_(bold(r), sigma)), \
  hat(V) &= sum_(⟨⟨bold(r), bold(r)′⟩⟩) V_(bold(r), bold(r)′) S^z_(bold(r)) S^z_(bold(r)′),
$ <eq:HInt>
 where we have used the same notation as @eq:Int.

The subspace $cal(T)$ and the raising operator $Q^dagger$ corresponding to this model are given by

$
  Q^dagger equiv eta^dagger = sum_(bold(r)) e^(i bold(pi) ∙ bold(r)) c^dagger_(bold(r), ↑) c^dagger_(bold(r), ↓), quad cal(T) equiv "span" { |Omega⟩, eta^dagger |Omega⟩, dots, (eta^dagger)^L |Omega⟩ }.
$ <eq:Hparams>

== Shiraishi-Mori embedding formalism <subsec:SMformalism>

The first systematic method of “embedding” exact eigenstates into the spectrum of non-integrable Hamiltonians was introduced by Shiraishi and Mori (SM) in @mori2017eth.

The SM formalism uses a set of strictly local (generically multi-site) projectors $( "P_i" )$ that need not commute with each other, and a target space $cal(T)$ defined as the common subspace of states annihilated by all the projectors, i.e. $cal(T) = "{" |psi⟩ : P_i|psi⟩ = 0 #h(0.28em) #h(0.28em) forall i "}"$.

Given a target space $cal(T)$, any term $H_0$ that commutes with all of the $P_i$'s leaves the target space invariant (i.e, $H_0|psi⟩ in cal(T)$ if $|psi⟩ in cal(T)$ since $P_i H_0|psi⟩ = H_0 P_i|psi⟩ = 0$).

Hence, $H_0$ can be diagonalized within $cal(T)$, and the corresponding eigenstates are the eigenstates of any Hamiltonian $H_("scar")$ of the form

$
  H_("scar") = sum_(i) P_i h_i P_i + H_0, #h(0.28em) #h(0.28em) #h(0.28em) [H_0, P_i] = 0 #h(0.28em) #h(0.28em) #h(0.28em) forall i.
$<eq:shiraishimori>
 where $h_i$ is an arbitrary local operator.

For generic choices of $h_i$, $H_("scar")$ is non-integrable, and the states in $cal(T)$ are eigenstates in the middle of the spectrum.
Provided the states have sub-volume-law EE scaling, they are violations of strong ETH of the Hamiltonian $H_("scar")$, and thus examples of QMBS of $H_("scar")$.

While the original examples in @mori2017eth only included “isolated” QMBS that are not equally spaced towers of states (we discuss these in @sec:isolated), it was later realized that towers of QMBS in several models can also be captured by this formalism.
Examples include the QMBS towers in the spin-1 XY model (see Appendix C of @schecter2019weak), $eta$-pairing in the Hubbard model @mark2020eta and $H_("scar")$ of @eq:HInt, the toy model studied in @choi2018emergent, although recasting these Hamiltonians in the form of @eq:shiraishimori can be tedious.

== SGA-based formalism <subsec:SGAbased>

=== MLM Framework <mlm-framework>

A different unified framework was introduced by Mark-Lin-Motrunich (MLM) in @mark2020unified, generalizing the idea of SGAs discussed in @mark2020unified.

They consider a manifold of states $cal(W)$, and impose the following SGA condition restricted to $cal(W)$

$
  [H_("scar"), Q^dagger] cal(W) = cal(E) Q^dagger cal(W), quad quad Q^dagger cal(W) subset.eq cal(W),
$ <eq:manifoldSGA>
 where $Q^dagger$ is the QMBS tower creation operator, and $hat(O) cal(W)$ is an abuse of notation that refers to the subspace obtained by the action of an operator $hat(O)$ onto states in $cal(W)$.

Note that when $cal(W)$ is the full Hilbert space, @eq:manifoldSGA reduces to the SGA condition of @eq:SGA.

Consequently, given an eigenstate $|psi_0⟩$ of $H_("scar")$ within the subspace $cal(W)$, we obtain a tower of eigenstates of $H_("scar")$ of the form $"{" (Q^dagger)^n |psi_0⟩ "}"$.

However, note that unless $cal(W)$ is the full Hilbert space, @eq:manifoldSGA does not imply that the lowering operator of the tower is the Hermitian conjugate of $Q^dagger$; hence in general it can be a different operator $Q'$, as shown in @fig:towerpyramid.

For example, for the deformations of the Hubbard model such as $H_("scar")$ of @eq:HInt, the subspace $cal(W)$ is equal to the subspace $cal(T)$ spanned by the tower of states in @eq:Hparams.

Similarly, this formalism was demonstrated to capture all the QMBS in the spin-1 XY model of @eq:spin1XY, all the spin-$S$ $S O ( 3 )$-symmetric AKLT models, and the DWC model discussed in @sec:towers.

Insights from the MLM formalism also led to the discovery of large families of nearest-neighbor Hamiltonians that share the same QMBS eigenstates as these models.
Note that although the subspace $cal(W)$ is the same as the QMBS subspace $cal(T)$ in simple examples, it was sometimes observed to be larger than the subspace $cal(T)$, for example in the case of the AKLT model @mark2020unified.

=== RSGA formalism <rsga-formalism>

A closely related formalism was independently introduced in @moudgalya2020eta, where, instead of working with manifolds of states $cal(W)$, sufficient conditions for the existence of towers of eigenstates of the form $"{" (Q^dagger)^n|psi_0⟩ "}"$ were provided in terms of the state $|psi_0⟩$, the Hamiltonian $H_("scar")$, and the operator $Q^dagger$.

In particular, defining $H_0 equiv H_("scar"), #h(0.28em) #h(0.28em) H_(n+1) equiv [H_n, Q^dagger], #h(0.28em) #h(0.28em) forall n >= 0$, examples of QMBS were said to exhibit a Restricted Spectrum Generating Algebra of order $M$ (RSGA-$M$) if the following conditions are satisfied

$
  &&"(i)" #h(0.25em) H_("scar")|{psi_0}⟩ = E_0|{psi_0}⟩, #h(0.28em) #h(0.28em) #h(0.28em) "(ii)" #h(0.25em) H_1|{psi_0}⟩ = cal(E) Q^dagger|{psi_0}⟩ \
  &&"(iii)" #h(0.25em) H_n|{psi_0}⟩ = 0 #h(0.28em) #h(0.28em) forall #h(0.25em) n, #h(0.25em) 2 <= n <= M, #h(0.28em) #h(0.28em) #h(0.28em) "(iv)" #h(0.25em) cases(H_n != 0 & "if" n <= M, H_n = 0 & "if" n = M+1).
$ <eq:RSGA2cond>

Explicit examples of QMBS in Hubbard-like models exhibiting an RSGA-$M$ for any $M$ were constructed in @moudgalya2020eta.

For example, $H_("scar")$ of @eq:Int can be shown to satisfy @eq:RSGA2cond with $|psi_0⟩ = |Omega⟩$, $cal(E) = (U - 2 mu)$, $Q^dagger = eta^dagger$, $E_0 = 0$ for $M = 1$, hence it falls into the category of RSGA-1.
The RSGA formalism provides a finer classification of QMBS that are part of the MLM formalism.
For example, the spin-1 XY model exhibits an RSGA-1, while the spin-1 AKLT model exhibits an RSGA-2.

Recently, @tang2021multimagnon connected the conditions of @eq:RSGA2cond to the properties of spherical tensor operators, which were then used to systematically construct families of QMBS Hamiltonians satisfying the RSGA conditions.
Note that similar to the MLM formalism, @eq:RSGA2cond does not restrict the form of the lowering operator of the tower to be the Hermitian conjugate of $Q^dagger$; hence in general it can be a different operator $Q'$, as shown in @fig:towerpyramid.

== Symmetry-based formalisms <subsec:symmetrybased>

// [figvision] imgs/scars_unified.png
// Panel a is a schematic energy level diagram for a symmetric Hamiltonian. The vertical axis represents energy
// E, increasing upwards without specified units or numerical range, and there is no horizontal axis. Horizontal
// lines represent energy eigenstates, with several lines overlapping to form a degenerate manifold. A bracket
// annotates this cluster, labeling it as the eigenstates of interest that form the QMBS. Text annotations
// explain this degeneracy from two perspectives: one identifies it as a consequence of non-Abelian symmetry,
// corresponding to the TT formalism, while the other attributes it to being singlets of the group generated by
// Hamiltonian terms, corresponding to the GI formalism.
#figure(placement: top, image("imgs/scars_unified.png", width: 298pt),
  caption: [
    Schematic overview of the symmetry-based unified formalisms for QMBS, discussed in @subsec:symmetrybased. The figure only shows the eigenstates of interest, which eventually form the QMBS of $H_("scar")$.

    (a) Spectrum of a symmetric Hamiltonian $H_("sym")$. The degeneracy can either be viewed to be a consequence of the non-Abelian symmetry (TT formalism) or due to the fact that they are singlets of the group generated by terms of $H_("sym")$ (GI formalism). The eigenstates are uniquely specified by certain symmetry quantum numbers of $H_("sym")$.

    (b) Spectrum of the Hamiltonian $H_("SGA") = H_("sym") + H_("lift")$ that appears in the TT formalism. While the degeneracy of these eigenstates is lifted, the eigenstates are still uniquely specified by certain symmetry quantum numbers of the $H_("SGA")$.

    (c) Spectrum of the Hamiltonian $H_("q-sym") = H_("sym") + H_("ann")$ that appears in the QS and GI formalisms, showing a manifold of exactly degenerate eigenstates.

    The symmetry of $H_("sym")$ is broken by the addition of $H_("ann")$, but the degeneracy of the eigenstates is preserved.
    (d) Spectrum of the Hamiltonian $H_("scar") = H_("q-sym") + H_("lift") = H_("SGA") + H_("ann")$.

    Here the eigenstates are referred to as towers of QMBS, since they are typically in the middle of the spectrum, and are not distinguished by any symmetry quantum number of $H_("scar")$.
  ]
) <fig:symmetrybased>

The SGA-based formalisms discussed in @subsec:SGAbased were subsequently extended in @subsec:SGAbased @ren2020quasisymmetry @odea2020from @pakrouski2020many.

We refer to these as symmetry-based formalisms since the starting points for the construction of $H_("scar")$ are highly symmetric Hamiltonians for which the the QMBS are degenerate eigenstates, and the raising and lowering operators $Q$ and $Q^dagger$ are symmetries.

The search for such symmetric Hamiltonians was already initiated in @mark2020eta, which employed similar ingredients as the symmetry-based formalisms we discuss below, along with the MLM framework to systematically search for Hamiltonians with QMBS.
The symmetry-based formalisms are summarized in @fig:symmetrybased, and can be broadly classified into two categories.

=== Quasisymmetry and Tunnels to Towers Formalisms <quasisymmetry-and-tunnels-to-towers-formalisms>

To construct the appropriate symmetric Hamiltonian, @ren2020quasisymmetry @odea2020from focus on the symmetry algebra generated by the raising and lowering operators $Q$ and $Q^dagger$, which is $S U ( 2 )$ in the case of $eta$-pairing discussed in @subsec:SGAtowers (see @eq:su2syms).

In @ren2020quasisymmetry, the Hamiltonian $H_("scar")$ exhibiting towers of QMBS is decomposed into two parts
$
  H_("scar") = H_("q-sym") + H_("lift"),
$<eq:QSHamil>
 where the QMBS eigenstates are degenerate in $H_"q-sym"$, and $H_("lift")$ lifts their degeneracy into an equally spaced tower of states, analogous to a magnetic field (see @fig:symmetrybased and ).

The degeneracy of the QMBS eigenstates in $H_"q-sym"$ is shown to be a consequence of their invariance under a “Quasisymmetry” (QS), which is defined to be a usual on-site symmetry restricted to a particular subspace of the full Hilbert space.
In particular, given any group element $g$ of a symmetry group $G$ with the on-site unitary action $hat(u) ( g )$, a subspace $cal(W)$ is referred to as having a quasisymmetry if it is invariant under the action of the symmetry group, i.e., if $hat(u)(g) cal(W) subset.eq cal(W)$ for all $g in G$.

For example, in the Hubbard model, the subspace $cal(T)$ of @eq:Hparams is said to possess an $S U ( 2 )$ quasisymmetry, since it is invariant under the action of the pseudospin $S U ( 2 )$ unitary operators $hat(u) ( arrow(alpha) ) = exp ( i arrow(alpha) dot.op arrow(eta) )$.

 @ren2020quasisymmetry provides a systematic method, similar to the Shiraishi-Mori construction of @subsec:SMformalism, to construct Hamiltonians $H_"q-sym"$ with the desired quasisymmetric subspace as a degenerate eigenspace.
In fact, in the cases where the SM formalism and the QS formalisms overlap, the first term in @eq:shiraishimori is an example of $H_("q-sym")$.

For example, given the quasisymmetric subspace $cal(T)$ of @eq:Hparams, one such Hamiltonian is $H_("q-sym") = hat(T) + hat(V)$.

Further, in the case where the quasisymmetry is a Lie group, @ren2020quasisymmetry shows that there are natural candidates for $H_("lift")$ that lifts the degeneracy of the quasisymmetric subspace in $H_"q-sym"$.

In the case of the subspace $cal(T)$, one such Hamiltonian is $H_("lift") = hat(U)$, which lifts the degeneracy into equally spaced towers of states with $cal(E) = (U - 2 mu)$.

In all, this provides a systematic approach to construct Hamiltonians with towers of QMBS, which have the form of @eq:QSHamil.

As illustrated in @ren2020quasisymmetry, this quasisymmetry formalism captures several examples of QMBS in the literature.
Further, the notion of quasisymmetries and the associated formalism were recently generalized to include many additional examples of QMBS @ren2021deformed.

On the other hand, @odea2020from exemplified a “Tunnels to Towers” (TT) approach to systematically construct models with towers of states, where Hamiltonians $H_("scar")$ exhibiting QMBS is decomposed into three parts
$
  H_("scar") = H_("sym") + H_("lift") + H_("ann").
$ <eq:TTHamil>

 $H_("sym")$ is a Hamiltonian with a conventional non-Abelian symmetry such as $S U ( 2 )$ that protects the degeneracy of a multiplet of eigenstates that eventually become the tower of QMBS of $H_("scar")$ (see @fig:symmetrybased).

In this construction, the eigenstates that are part of the chosen multiplet are uniquely specified by their quantum numbers under symmetries of $H_("sym")$, and are related by the actions of raising and lowering operators associated with the non-Abelian symmetry (e.g. by $S^(+)$ and $S^(-)$ in the case of $S U ( 2 )$)

 $H_("lift")$ is a term that can be systematically added to lift the degeneracy of these eigenstates of $H_("sym")$ into an equally spaced tower (see @fig:symmetrybased), such that the resulting Hamiltonian, given by

$
  H_("SGA") = H_("sym") + H_("lift"),
$<eq:SGAHamil>
 exhibits an SGA property of @eq:SGA.

Nevertheless, these eigenstates are still not referred to as examples of QMBS of $H_("SGA")$ since they can still be uniquely specified by quantum numbers under symmetries of $H_("SGA")$ (see @fig:symmetrybased).

Finally $H_("ann")$ contains terms that annihilate the tower of states and can be systematically added to break the SGA property of $H_("SGA")$ while preserving (typically annihilating) the tower of states as eigenstates, arriving at $H_("scar")$ (see @fig:symmetrybased and ).

For example, in the case of $H_("scar")$ of @eq:shiraishimori, the symmetric Hamiltonian is $H_("sym") = hat(T)$, which possess the pseudospin $S U ( 2 )$ symmetry, and the multiplet of degenerate eigenstates (with the degeneracy protected by the pseudospin $S U ( 2 )$ symmetry) is the subspace $cal(T)$ of @eq:Hparams.

Further, the term that lifts the degeneracy of this multiplet of states is $H_("lift") = hat(U)$.

 $H_("SGA")$ is thus the usual Hubbard model ${H_("Hub")}$ of @eq:FermiHubbard, which exhibits an SGA of @eq:HubbardSGA, as discussed in Sec.

Finally, the term that breaks the SGA property while annihilating the eigenstates in $cal(T)$ is $H_("ann") = hat(V)$, and thus the decomposition of $H_("scar")$ in @eq:HInt is directly the TT decomposition.

As evident from the example of $H_("scar")$ of @eq:HInt, the QS and TT constructions of @ren2020quasisymmetry @odea2020from reproduce the SGA-based construction of scars discussed in @ren2020quasisymmetry @odea2020from @mark2020eta @moudgalya2020eta when the symmetry group is restricted to $S U ( 2 )$.
Further, these formalisms are also closely related to each other, and in the cases they overlap, the $H_"q-sym"$ in the QS formalism can be decomposed as (see @fig:symmetrybased and @mark2020eta @moudgalya2020eta)
$
  H_("q-sym") = H_("sym") + H_("ann"),
$<eq:QSTTrelation>
 and can be interpreted in the language of the TT formalism and vice-versa.
Apart from towers of states, both mechanisms were also demonstrated for $S U ( 3 )$ groups, where two independent raising operators lead to “pyramids” of QMBS instead of towers.
However, they differ in certain aspects.
While the QS formalism applies only to groups protecting the degeneracy in $H_("sym")$, the TT mechanism was also demonstrated for $S U ( 2 )_q$, a quantum group protecting the degeneracy, in which case the raising and lowering operators for the towers of states are non-local in nature.
On the other hand, for the TT formalism to work, it requires $H_("sym")$ to already possess analytically tractable eigenstates, which is a built-in feature in the QS formalism.

=== Group Invariant Formalism <group-invariant-formalism>

A complementary understanding of towers of QMBS was provided in a Group-Invariant (GI) formalism introduced in @pakrouski2020many.

The starting points are symmetric Hamiltonians $H_("sym")$ that are quadratic fermionic hopping terms of the form $T_A = sum_((b"old"(r)), (b"old"(r))′, sigma){A_((b"old"(r)), (b"old"(r))′) (c^"dagger")_((b"old"(r)), sigma) c_((b"old"(r))′,sigma)}$ on $L$ sites where $A$ is a Hermitian matrix, and the indices $(b"old"(r))$ and $sigma$ label the lattice site and the spin respectively.
Instead of studying the symmetry group of such Hamiltonians, @pakrouski2020many focuses on the algebra generated by individual terms in $H_("sym")$.

For example, for $H_("scar")$ in @eq:HInt, the corresponding $H_("sym")$ is $hat(T)$, and the object of interest in the GI formalism is the algebra generated by the individual nearest-neighbor hopping terms $"{" hat(T)_((b"old"(r)), (b"old"(r))′) "}"$.

Such quadratic hopping terms $( "T_A" )$ are shown to be the generators of a Lie group, e.g., $S O ( L )$ in the case of $"{" hat(T)_((b"old"(r)), (b"old"(r))′) "}"$.

The associated symmetry group (i.e., the group of all unitary operators that commute with all these quadratic terms $( "T_A" )$) is a different Lie group, e.g., $S O ( 4 ) approx ( S U ( 2 ) times S U ( 2 ) )\/Z_2$ in the case of $"{" hat(T)_((b"old"(r)), (b"old"(r))′) "}"$, which is usually referred to as the “symmetry group” of the system.
While QS and TT formalisms use the properties of the latter symmetry group to construct Hamiltonians with towers of QMBS, the GI formalism constructs Hamiltonians with QMBS using the properties of the former group (e.g., $S O ( L )$).
In particular, they show that several examples of QMBS states are “invariant” under the action of the Lie group generated by the quadratic terms.
These states are referred to as one-dimensional representations or “singlets” of corresponding Lie groups.
For example, the QMBS eigenstates in $cal(T)$ of @eq:Hparams are all annihilated by individual hopping terms $"{" hat(T)_((b"old"(r)), (b"old"(r))′) "}"$, and hence are invariant under the action of the $S O ( L )$ group generated by these terms (i.e., the states are referred to as singlets of $S O ( L )$).
Hence the degeneracy of the QMBS eigenstates under $H_("sym")$ shown in @fig:symmetrybased is viewed to be a consequence of the states being annihilated by the terms of $H_("sym")$ (i.e., they are singlets of the group generated by the terms of $H_("sym")$).

Using the fact that the singlets are annihilated by the quadratic terms, @pakrouski2020many provides a systematic construction for $H_("scar")$, similar to the Shiraishi-Mori construction of @subsec:SMformalism, which can be written in the form

$
  H_("scar") = sum_(A) O_A T_A + H_("lift"),
$<eq:GIHamil>
 where $( "O_A" )$ are arbitrary operators, the summation runs over some set of matrices $A$, and $H_("lift")$ is some Hamiltonian that leaves the singlet space (i.e., the QMBS space) invariant, which guarantees that singlets of the group generated by $( "T_A" )$ are generically non-degenerate eigenstates of $H_("scar")$.

Further, note that the first term in @eq:GIHamil is equivalent to $H_"q-sym"$ in the QS construction (see @eq:GIHamil) and also to the first term in the SM formalism of @eq:shiraishimori.

Note that @eq:GIHamil can also be related to the TT construction by decomposing the first term in @eq:GIHamil according to @eq:QSTTrelation.

An advantage of the GI formalism is that it reveals large symmetries of the QMBS eigenstates that are not evident in the QS and TT formalisms.
For example, since the states in $cal(T)$ of @eq:Hparams are invariant under the action of the group $S O ( L )$, they can be viewed as being $S O ( L )$-symmetric, which in particular implies that they are invariant under a permutation of the sites of the lattice (since the permutation group $S_L$ is a subgroup of $S O ( L )$).
Note that this formalism was recently extended to include additional examples of QMBS in fermionic Hamiltonians @pakrouski2021group.

= Isolated QMBS <sec:isolated>

While QMBS are commonly associated with revivals and the existence of towers of equally-spaced eigenstates in the spectrum, several examples of QMBS that do not involve a exactly solvable tower of states.
Such examples consist of any number of states embedded in the middle of the spectrum, ranging from an $cal(O) ( 1 )$ number to exponentially many.
Some examples of isolated QMBS are shown in @fig:isolatedQMBS.

== Survey of isolated QMBS <subsec:SMformalismisolated>

// [figvision] imgs/sm_figures.png
// Panel a is a scatter plot with an inset. The horizontal axis is energy density ranging from approximately
// minus two to two, and the vertical axis is the expectation value of a local operator, ranging from zero to
// one. Black dots represent all eigenstates, which form a continuous, smooth curve indicating thermalization.
// Red open circles highlight the isolated quantum many-body scarred states. These red circles deviate strongly
// from the black curve, indicating a violation of the eigenstate thermalization hypothesis. The inset plots the
// same expectation value but isolates the scarred states, emphasizing their anomalous deviation from the typical
// spectrum. Panel b is a scatter plot showing entanglement entropy of eigenstates as a function of energy. The
// horizontal axis is energy density, ranging from roughly minus two to two, while the vertical axis is the
// half-chain entanglement entropy, ranging from zero to five. The majority of eigenstates, plotted as blue dots,
// form a dense, horizontal band across the spectrum, indicating volume-law entanglement consistent with
// thermalization. In contrast, the isolated quantum many-body scarred states, plotted as red diamonds, dip far
// below this dense band. This trend demonstrates that scarred eigenstates possess anomalously low entanglement
// compared to typical thermal states.
#figure(placement: top, image("imgs/sm_figures.png", width: 363pt),
  caption: [
    (Color online) Examples of Isolated QMBS. (a) Figure reproduced from @mori2017eth shows the ETH violation in an isolated QMBS via the expectation value of a certain local operator. The inset shows the expectation value in an isolated QMBS, which strongly deviates from that of typical states in the spectrum. (b) Figure reproduced from @ok2019topological shows the EE of the eigenstates as a function of energy in a certain Hamiltonian exhibiting isolated QMBS that show topological order. The circled point is the QMBS eigenstate.
  ]
) <fig:isolatedQMBS>

The Shiraishi-Mori (SM) formalism discussed in @subsec:SMformalism was introduced in @subsec:SMformalism to systematically embed QMBS eigenstates in the middle of the spectrum of non-integrable Hamiltonians of the form of @eq:shiraishimori.

This formalism was explicitly demonstrated in @eq:shiraishimori by constructing such a non-integrable Hamiltonian with two Majumdar-Ghosh Hamiltonian ground states @majumdarghosh1969    as QMBS eigenstates in the middle of its spectrum.
This construction utilized the frustration-free property of the Majumdar-Ghosh Hamiltonian ground states, i.e., they are annihilated by individual three-site projectors $P_i$'s, and as discussed in @subsec:SMformalism, they form the target subspace $cal(T)$.

This procedure can be applied to other Valence Bond States including AKLT state, which have the property that they are annihilated by an appropriate choice of local operators $P_i$@aklt1987rigorous @majumdarghosh1969.

In fact, a larger class of states can be a part of the target space $cal(T)$.

For example, in the case of states with MPS representation in one-dimension (or PEPS in higher dimensions), the appropriate $P_i$'s can be derived using the parent Hamiltonian construction @perezgarcia2007matrix @moudgalya2020large or via Eigenstate-to-Hamiltonian construction algorithms @perezgarcia2007matrix @moudgalya2020large @qi2019determininglocal @chertkov2018computational.

Other examples of isolated QMBS in the literature include Hamiltonians with QMBS possessing (symmetry-protected) topological order @ok2019topological, @srivatsa2020quantum @jeyaretnam2021quantum, certain QMBS that appear in frustrated models @lee2020exact, @mcclarty2020disorder @chertkov2021motif, “dimerized” states in lattice models with supersymmetry in arbitrary dimensions @surace2020weakergodicity, exact localized states in Hubbard-like models @iadecola2018exact, and certain eigenstates in transverse field Ising ladders @vanvoorden2021disorder or Abelian lattice gauge theory on small ladders @banerjee2021quantum.

We note that many of these examples of isolated QMBS appear to be special cases of the SM formalism, although the connection is not always immediately obvious.

Finally, we note that @mori2017eth also illustrated an example of embedding where the subspace $cal(T)$ has an exponentially large dimension (while being a measure-zero set in the thermodynamic limit).
Although eigenstates within that subspace are not solvable, they nevertheless violate the conventional form of ETH @mori2017eth @shiraishimorireply.

However, the subspace can also be thought of as an exponentially large “Krylov subspace” distinguished by a non-local symmetry @mondaini2018comment, @moudgalya2021hilbert, which makes it closer to examples of fragmentation that we will discuss in @sec:fragmentation.

== PXP models <subsec:PXPmodels>

An important class of isolated exact QMBS eigenstates appear in the context of PXP models, an effective model for the dynamics of Rydberg atoms @lesanovsky2011many @turner2017quantum on arbitrary lattices or graphs.
As discussed in @sec:intro, the experimental realization and the approximate QMBS in the PXP model played an important role in the emergence of QMBS as a field.
For convenience and due to its importance, we briefly describe the system here and refer readers to the reviews on the subject for more details @SerbynReview @papic2021weak.

=== Model and Approximate QMBS <model-and-approximate-qmbs>

In a certain limit where the nearest neighbor van-der-Walls interaction between Rydberg atoms is much larger than the detuning and the Rabi frequency, the Rydberg atoms can be modelled by two-level systems, either in its ground state or excited state, which we denote by $arrow.b$ and $arrow.t$ respectively @lesanovsky2012interacting @turner2017quantum.

Furthermore, in this limit, the interactions between excited Rydberg atoms effectively forbid the simultaneous excitation of nearest-neighbor atoms, hence the effective low-energy Hilbert space consists of all configurations without nearest neighbor excitations (i.e. configurations of the form $|⋯ ↑ ↑ ⋯⟩$ are absent), which is sometimes referred to as the Fibonacci Hilbert space @lesanovsky2012interacting.

The effective Hamiltonian $H_"PXP"$ within this low-energy subspace allows Rydberg atoms to freely transition between their ground and excited states provided neighboring atoms are excited @lesanovsky2012interacting.

Its expression reads (with PBC)

$
  H_("PXP") = cases(
    sum_j (P_(j-1) X_j P_(j+1)) & "if in one dimension",
    sum_j (X_j product_(i in N(j)) P_i) & "if on arbitrary lattices",
  ) #h(0.28em) #h(0.28em) \
$<eq:PXPdefn>
 where $j$ runs over the sites of the lattice, $P_j = (|↓⟩⟨↓|)_j$ is a projector onto the ground state of the atom on site $j$ that and $N ( j )$ denotes the set of neighbors of site $j$.

Note that the PXP Hamiltonian of @eq:PXPdefn cannot create any nearest-neighbor excitations, and hence preserves the Fibonacci Hilbert space.
The PXP model in any dimension admits a particle-hole symmetry generated by the operator $product_j Z_j$@turner2018quantum, where $Z_j$ is the Pauli-$Z$ matrix acting on site $j$, hence their energy spectra are symmetric around $E = 0$.
In addition, on lattices on which the PXP model has an inversion symmetry (e.g. the 1d PXP model), exhibit an exponentially large manifold of zero energy ($E = 0$) eigenstates that can be shown to be a consequence of the inversion and particle-hole symmetries @turner2017quantum @turner2018quantum @schecter2018many @moudgalya2020quantum.

Note that the 1d PXP model also appears as an effective Hamiltonian in a variety of different contexts, including Fibonacci anyon chains @trebst2008fibonacci, @lesanovsky2012interacting @chandran2020absence, Ising models on dimer ladders @moessner2001ising, @laumann2012quantum, lattice gauge theories @surace2020lattice, @chen2021emergent, as well as in models with dipole moment conservation @surace2020lattice @chen2021emergent @fendley2004competing @sala2019ergodicity, in particular the quantum Hall effect on a thin torus @moudgalya2020quantum.

The 1d PXP model has been observed to host an approximate tower of QMBS that leads to anomalously long revivals @bernien2017probing @turner2017quantum @turner2018quantum.

These approximate QMBS in the PXP model have been studied using a wide variety of techniques that yield several insights into their origin @khemani2019int, @ho2018periodic @choi2018emergent @michailidis2020slow @bull2019systematic @turner2021correspondence @bull2020quantum, which are reviewed in more detail in @SerbynReview @papic2021weak.

However, we emphasize that this tower of QMBS in the PXP model @turner2017quantum or in its deformations with almost perfect revivals @choi2018emergent are not examples of exact QMBS, and are hence beyond the scope of this review.

=== Exact QMBS in 1d <exact-qmbs-in-1d>

Beyond the tower of approximate QMBS, exact eigenstates of the 1d PXP model with area-law entanglement and simple MPS expressions were constructed in @lin2019exact, which are examples of exact QMBS.
Two exact states with $E = 0$ were obtained for OBC and PBC, whereas two additional exact states with $E = plus.minus sqrt(2)$ were obtained for OBC, which differ from the $E = 0$ exact states at the boundaries.
The OBC eigenstates at non-zero energy are certainly in the middle of the energy spectrum and should be considered as examples of QMBS.
The case is slightly different for the exact states with $E = 0$, which are examples of QMBS only if typical eigenstates in the exponentially large zero energy state manifold satisfy ETH, numerical evidence for which was found in @schecter2018many.

These exact eigenstates also appear to be base states for variational quasiparticle constructions of the approximate towers of QMBS in the PXP model @lin2019exact, complementary to other approximations for the tower of QMBS in the PXP models @iadecola2019quantum @mark2019new.

More examples of such exact eigenstates in PXP-like models were obtained in @surace2021exactstability @karle2021arealaw.

Furthermore, numerical observations in @karle2021arealaw also suggest that some low-entanglement states similar to the exact states in the PXP model exist within the exponentially large manifold of $E = 0$ eigenstates of #emph[all] local Hamiltonians with inversion and particle-hole symmetries, although they might not have an MPS form with finite bond-dimension.
Finally, we note that @shiraishi2019connection connected these exact states in the PXP model to the Shiraishi-Mori formalism discussed in @subsec:SMformalism.

=== Exact QMBS in Higher Dimensions <exact-qmbs-in-higher-dimensions>

PXP models in higher dimensions also admit exact QMBS eigenstates.

@lin2020quantum constructed exponentially many exact $E = 0$ “dimerized” eigenstates (similar to the ones in @surace2020lattice) in the 2d PXP model on square and rotated-square lattices, which can also be generalized to the 3d PXP model on cubic lattices.
As demonstrated there, these eigenstates also have direct implications for dynamics of states on Rydberg arrays.
However, since they all have zero energy, they are different from the approximate towers of equally-spaced eigenstates that lead to revivals observed in the deformed 2d PXP model studied in @michailidis2020stabilizing.

== Other exact eigenstates <other-exact-eigenstates>

To complete our discussion on exact results on excited states, we briefly survey some examples of exact excited states that are not considered examples of QMBS due to their position in the energy spectrum (i.e., they are typically not in the bulk of the spectrum).
However, in many cases we expect that these eigenstates are QMBS of appropriately modified Hamiltonians where such states are “embedded” into the middle of the spectrum following ideas similar to the Shiraishi-Mori formalism discussed in @subsec:SMformalism.

One class of exact excited states are single quasiparticle excited states above a frustration-free ground state of a Hamiltonian, which have an area-law entanglement @moudgalya2018b @pizorn2012universality.

Examples of such eigenstates close to the edges of the spectrum date back to early works in the Majumdar-Ghosh model @caspers1982some, @caspers1984majumdar, as well as two exact low-energy excited “Arovas” states in the spin-1 AKLT model @arovas1989two, which were later generalized to any integer spin-$S$@arovas1989two.

More recently, @lesanovsky2011many @mark2019new solved for quasiparticle exact excited states in a frustration-free Hamiltonian modelling Rydberg interactions similar to the PXP model, and @mark2019new also used the nature of these states to obtain better variational expressions for the approximate towers of QMBS in the PXP model.
Similarly, exact expressions for several families of one or two quasiparticle eigenstates close to the ferromagnetic state of certain $S U ( 2 )$-symmetric models have been obtained.
The simplest of these are the well-known spin-waves on top of the ferromagnet, and more involved examples of such states can be found in the spin-1 AKLT model @moudgalya2018a.

Finally, we note that examples of quasiparticle states also exist in the literature in higher dimensions, particularly in the $U ( 1 )$-symmetric XY model (also known as the XX model) on hypercubic lattices @bibikov2017bethe, and in the Hubbard model on square lattices @bibikov2017bethe @ren2018slater @ye2018exact.

These eigenstates have $cal(O) ( L )$ quasiparticles in an $L times L$ system, and the quasiparticle number density (and hence their energy density) goes to zero in the thermodynamic limit.
Hence we do not expect them to be direct examples of QMBS in their respective models.

= Hilbert Space Fragmentation and Krylov Subspaces <sec:fragmentation>

Hilbert space fragmentation is a related phenomenon of ergodicity breaking.
In this section, we discuss this phenomenon, as well as its similarities and differences with QMBS.

Given a quantum system with Hilbert space $cal(H)$ and Hamiltonian $H$, we can decompose the Hilbert space into dynamically disconnected subspaces, referred to as #emph[Krylov subspaces] (or sometimes as #emph[fragments] or #emph[subsectors]), as follows

$
  cal(H) = ⨁_(j = 1)^K{cal(K)_j}, #h(0.28em) #h(0.28em) #h(0.28em) cal(K)_j = "span"_t "{" e^(-i H t)|{psi_j}⟩ "}" ,
$<eq:Hilbertsplitting>
 where $"span"_t "{" e^(-i H t)|psi_j⟩ "}" equiv "span" "{" |psi_j⟩, H|psi_j⟩, H^2|psi_j⟩, ⋯, "}"$ denotes the subspace spanned by time-evolution of the state $|psi_j⟩$, and $K$ is the number of Krylov subspaces.

Note that the $|psi_j⟩$'s in @eq:Hilbertsplitting are chosen such that the subspaces $cal(K)_j$'s are distinct.

As discussed in @subsec:ergodicitybreaking, Hilbert space fragmentation referred to the phenomenon where the system possesses exponentially many Krylov subspaces, i.e. $K tilde exp ( L )$ for a system of size $L$.
The decomposition of @eq:Hilbertsplitting is trivial if $|psi_j⟩$'s are eigenstates of $H$, and is expected if the Hamiltonian $H$ possesses certain symmetries such that different $|psi_j⟩$'s in @eq:Hilbertsplitting have different symmetry quantum numbers.
However, the decomposition for fragmented systems is different in two ways.

First, $|psi_j⟩$'s are typically chosen to be product states, usually motivated by their more straightforward experimental preparation.
For a non-integrable Hamiltonian, such a choice usually leads the subspace $cal(K)_j$ to be generically the #emph[full] Hilbert space after resolving symmetries of the system.
However, the different Krylov subspaces $cal(K)_j$ in fragmented systems are not distinguished by quantum numbers corresponding to any obvious local symmetries of $H$.
Second, for generic systems with conventional symmetries such as $bb(Z)_2$, $U ( 1 )$, or $S U ( 2 )$, the number of Krylov subspaces $K$ either stays constant or grows polynomially with increasing system size, whereas it grows exponentially in fragmented systems @sala2019ergodicity @khemani2019local @moudgalya2021hilbert.

Furthermore, the dimensions of the Krylov subspaces in fragmented systems typically have a wide range, from one-dimensional “frozen” product states where all terms of Hamiltonian act trivially, to subspaces with exponentially large dimension that can be studied in terms of a Krylov-restricted effective Hamiltonian.
Fragmentation was explicitly pointed out in the context of dipole-moment or center-of-mass conserving systems @pai2018localization, @sala2019ergodicity @khemani2019local @moudgalya2019thermalization, although similar phenomena have been discussed in several works @ritort2003glassy @bergholtz2005half @bergholtz2006one @olmos2010thermalization @sikora2011extended @nakamura2012exactly @gopalakrishnan2018facilitated @lan2018quantum @moudgalya2020quantum @subsec:dipoleconservation.

In @subsec:dipoleconservation we discuss a simple example of Hilbert space fragmentation in a dipole-moment conserving system, which illustrates several essential features of fragmented systems.

In @subsec:miscfrag, we survey some other models in the literature that demonstrate fragmentation and comment on some general features of fragmented systems.

In @subsec:fragmentationdynamics, we discuss the implications of fragmentation to dynamics and connections to QMBS.

Finally, we dedicate @autocorrelation-functions to the discussion of autocorrelation functions, an important diagnostic in the context of fragmentation, and discuss its properties.

== Simple example: Pair-hopping model <subsec:dipoleconservation>

We start with a simple example of Hilbert space fragmentation that occurs in an interacting model of electrons that conserves the total dipole moment of the system in addition to the total charge.
Systems conserving dipole moment or center-of-mass were first discussed in @seidel2005incompressible, in the quest to build featureless Mott insulators.
They naturally arise in physical systems in two different contexts.
First, in quantum Hall effect on a thin cylinder, where the effective Hamiltonian with translation invariant interactions projected onto a single Landau level @bergholtz2006one @bergholtz2008quantum @moudgalya2020quantum @lee2015geometric @papic2014solvable @rezayi1994 @nakamura2012exactly exhibits dipole moment conservation.
Second, they also appear as effective Hamiltonians within resonant subspaces in the interacting Wannier-Stark problem, i.e., interacting fermions hopping on a finite one-dimensional lattice, subject to a strong electric field @van2018bloch @schulz2019stark @moudgalya2019thermalization @taylor2019experimental.

Such a system has been probed in many recent experiments @guardado2020subdiffusion, @scherg2020observing @kohlert2021experimental, and Hilbert space fragmentation is believed to contribute to the observed slow dynamics @taylor2019experimental @doggen2021stark.

=== Model and symmetries <model-and-symmetries>

We now illustrate Hilbert space fragmentation in dipole-moment conserving systems with the help of a simple one-dimensional spinless fermionic “pair-hopping model”@seidel2005incompressible @moudgalya2020quantum @moudgalya2019thermalization ${H_("PH")}$ with OBC, which is the “quantum part” (i.e., neglecting electrostatic terms) of the pseudopotential Hamiltonian in the $nu = 1\/3$ Fractional Quantum Hall effect @lee2015geometric    in the thin torus limit @lee2015geometric @moudgalya2020quantum:

$
  {H_("PH")} = sum_(j = 1)^(L-3){H_j} = sum_(j = 1)^(L-3){({c^dagger}_j {c^dagger}_(j+3) c_(j + 2) c_(j + 1) + h.c.)}.
$<eq:pairhopping>

The terms $H_j$ implement the transitions $|1 0 0 1⟩ -> |0 1 1 0⟩$, where $|a b c d⟩$ denote the occupancies of four consecutive sites on the chain, and the model preserves the dipole moment (i.e. center-of-mass position) @seidel2005incompressible, given by the operator $hat(D) equiv sum_(j = 1)^L j hat(n)_j #h(0.17em)$ where $hat(n)_j$ is the fermion number operator on site $j$.

Given the set of allowed transitions by the terms $( "H_j" )$, we can study its dynamically disconnected Krylov subspaces $"{" cal(K)_j "}"$ of @eq:Hilbertsplitting.

We are only interested in the dynamics of initial product states, which are more easily accessible to experiments, and hence we consider Krylov subspaces $cal(K)_j$ generated by product states $|psi_j⟩$.

Although we will only consider the translation invariant model of @eq:pairhopping, note that the Krylov subspaces we study only depend on the structure of the transitions of $( "H_j" )$, hence the Krylov subspaces of the entire family of models of the form $sum_j J_j H_j$ for arbitrary couplings $J_j$ are the same.

=== Frozen configurations and small Krylov subspaces <frozen-configurations-and-small-krylov-subspaces>

Exponentially many of these Krylov subspaces are one-dimensional #emph[frozen] configurations---product states that are eigenstates of $H$.
This is a direct consequence of the “sparsity” of transitions that the terms $( "H_j" )$ implement, i.e. the Hamiltonian vanishes on any product state not containing the patterns $“⋯ 0110 ⋯”$ or $“⋯ 1001 ⋯”$ on four consecutive sites.

Since there are #emph[exponentially] many such patterns, there are equally many one-dimensional Krylov subspaces.
Further, Krylov subspaces can be constructed by embedding finite #emph[active] blocks, i.e. regions where the Hamiltonian acts non-trivially, into any frozen configuration, thereby leading to exponentially many Krylov subspaces with dimension of $cal(O) ( 1 )$@sala2019ergodicity @khemani2019local.

For example, the following configurations $|psi_plus.minus⟩$

$
  &|{psi_plus.minus}⟩ = frac(1, sqrt(2))(|{111000⋯ 111000#rect(inset: 2pt)[1001]111000⋯ 111000}⟩ \
  &plus.minus |{111000⋯ 111000#rect(inset: 2pt)[0110]111000⋯ 111000}⟩)
$
 are composed of one active block (boxed) sandwiched between frozen configurations, and they span a two-dimensional Krylov subspace.

The presence of exponentially many frozen states and states with frozen regions within each symmetry sector in the Hilbert space has direct implications to the dynamics of such systems: time-evolution starting from a random product state looks very different from the behavior expected for typical thermal non-integrable models.

=== Exponentially large Krylov subspaces <exponentially-large-krylov-subspaces>

Apart from frozen configurations and Krylov subspaces of small dimension, the pair-hopping model also exhibits Krylov subspaces with exponentially large dimensions that scale with system-size as $tilde alpha^L$ as $L arrow.r oo$ and $1 < alpha < 2$.

As discussed in @moudgalya2019thermalization, these subspaces can be highly non-locally constrained, and certain Krylov subspaces in ${H_("PH")}$ are characterized by a certain non-local string order.
Furthermore, the properties of these subspaces can be vastly different, demonstrating the rich dynamical structure inherent to systems with Hilbert space fragmentation.
For example, the Hamiltonian restricted to a given subspace can be either integrable or non-integrable (either satisfying a restricted form of ETH or MBL), and subspaces of different types can coexist.
We now provide one example of an integrable Krylov subspace with exponentially large dimension in the pair-hopping model ${H_("PH")}$ of @eq:pairhopping via a spin mapping demonstrated in @eq:pairhopping @bergholtz2005half @bergholtz2006one @bergholtz2008quantum @moudgalya2019thermalization.

The Hamiltonian ${H_("PH")}$ with even system size $L = 2 N$ has an additional symmetry: sublattice particle number conservation @moudgalya2019thermalization, and we group sites $2 j - 1$, $2 j$ of the original lattice into a new site $j$ so as to form a new chain with $N = L\/2$ sites.
It is convenient to work in terms of new degrees of freedom for these composite sites defined as $|↑⟩ equiv |0 1⟩$ $|↓⟩ equiv |1 0⟩$.

The action of the terms $H_j$ of @eq:pairhopping, when written in terms of the composite spins, is simply given by $|{ #h(0.25em) #rect(inset: 2pt)[01] #h(0.25em) #rect(inset: 2pt)[10] #h(0.25em) }⟩ -> |{ #h(0.25em) #rect(inset: 2pt)[10] #h(0.25em) #rect(inset: 2pt)[01] #h(0.25em) }⟩ <=> |{↑ ↓}⟩ -> |{↓↑}⟩$.

Hence for any Krylov subspace generated by a product state $|psi_0⟩$ with only composite spin degrees of freedom $arrow.t$ and $arrow.b$, the action of the Hamiltonian restricted to the Krylov subspace interchanges the spins, and hence exactly maps onto a spin-1/2 XX model:

$ H_(X X) [N] equiv sum_(j = 1)^N (sigma_j^(+) sigma_(j + 1)^(-) + sigma_j^(-) sigma_(j + 1)^(+)) #h(0.17em) #h(0.17em) $<eq:hamilXX>

where $( "sigma_j"^(+) )$ and $( "sigma_j"^(-) )$ are Pauli matrices on site $j$.
As is well known, the Hamiltonian @eq:hamilXX can be solved using a Jordan-Wigner transformation @lieb1963exact, upon which it maps onto a non-interacting fermion problem.
However, as can be readily shown, these are #emph[not] the only states within the same charge and dipole moment sector, providing evidence for Hilbert space fragmentation in the pair-hopping Hamiltonian ${H_("PH")}$.

=== Krylov subspaces due to blockades <krylov-subspaces-due-to-blockades>

Additional integrable or non-integrable Krylov subspaces can be systematically constructed by inserting #emph[blockades] in the system, i.e., frozen configurations on a part of the system that remain unchanged under the action of the Hamiltonian.
For example, consider Krylov subspaces generated by product states of the $|⋯ 111 ⋯⟩$ or $|⋯ 000 ⋯⟩$, where $dots.h.c$ denotes active regions where the terms $( "H_j" )$ of ${H_("PH")}$ act non-trivially.

Configurations such as $111$ or $000$ embedded in the middle of the chain do not change under the action of the local terms $H_j$.
Hence they can be used to separate active regions of the chain, leading to exponentially many new Krylov subspaces.
The Hamiltonian restricted to such Krylov subspaces with multiple active regions separated by blockades is simply the sum of commuting terms that act on different active regions of the chain.

=== Strong v/s weak fragmentation <strong-vs-weak-fragmentation>

In addition to the “‘minimal-range” dipole conserving model of @eq:pairhopping, we can introduce longer-range dipole moment conserving terms such as $((c^"dagger")_j (c^"dagger")_(j + 5) c_(j+1) c_(j+4) + h.c.)$, which connect several of the Krylov subspaces of the minimal-range model @sala2019ergodicity @moudgalya2019thermalization.

Nevertheless, @sala2019ergodicity @khemani2019local showed that Hamiltonians with dipole moment conservation and terms of any finite range is guaranteed to exhibit Hilbert space fragmentation.
A simple proof relies on building exponentially many frozen patterns that are annihilated by dipole moment conserving terms of any finite range.
For example, states of the form $|0 ⋯ 0, 1 ⋯ 1, 0 ⋯ 0, 1 ⋯ 1⟩$, where $0 dots.h.c 0$ and $1 dots.h.c 1$ are clusters of at least $m$ sites with identical occupation, are frozen under the action of any dipole conserving term acting on less than or equal to $m$ consecutive sites.
However, as discussed in @sala2019ergodicity, adding longer range terms to the minimal dipole conserving model changes the nature of fragmentation in the system from “strong” to “weak”, which are defined as follows.
Referring to the dimension of the largest Krylov subspace as $D_("max") = "max"_j "{" "dim"(cal(K)_j) "}"$, and full Hilbert space dimension (after resolving all conventional symmetries) as $D$, @sala2019ergodicity classified fragmented systems into two types: #emph[strongly fragmented] when $D_max\/D arrow.r 0$ and #emph[weakly fragmented] when $D_max\/D arrow.r 1$ respectively in the thermodynamic limit.
Note that these notions of strong and weak fragmentation only apply usual (e.g., charge and dipole) symmetry sectors @moudgalya2021hilbert.

Indeed, @morningstar2020kinetically provided an example of a dipole moment conserving Hamiltonian that exhibits strong fragmentation within certain quantum number sectors while exhibiting weak fragmentation in other sectors.

== Survey of other examples in the literature <subsec:miscfrag>

We now survey several other examples of Hilbert space fragmentation in the literature, including those that do not involve dipole moment conserving models.

=== Spin-1 Dipole Conserving Model <spin-1-dipole-conserving-model>

Apart from dipole conserving systems of spinless fermions that we have discussed in @subsec:dipoleconservation, spin-1 dipole conserving model, given by the Hamiltonian

 $ H_3 equiv sum_j ( S_(j - 1)^(-) ( S_j^(+) )^2 S_(j + 1)^(-) + h . c . ) #h(0.17em) $<eq:H3hamil>

where $S_j^plus.minus$'s are the spin-1 raising and lowering operators on site $j$.
This Hamiltonian, and its Floquet version, have been studied in detail in @pai2018localization @sala2019ergodicity @khemani2019local @rakovszky2019statistical.

They show that the model possesses several similar features as ${H_("PH")}$, i.e., it hosts exponentially many frozen eigenstates and Krylov subspaces, most of which feature blockades, as well as exponentially large non-locally constrained Krylov subspaces.

As shown in @rakovszky2019statistical, the model also exhibits integrable subspaces that map onto spin-1/2 XX models.
While the minimal spin-1 dipole conserving model exhibits strong fragmentation in all charge and dipole quantum number sectors, longer range spin-1 dipole-conserving model were numerically observed to exhibit weak fragmentation @sala2019ergodicity in the largest quantum number sector.

However, @sala2019ergodicity observed a “freezing transition” from weak to strong fragmentation as a function of filling factor (i.e., charge quantum number) in the longer range spin-1 dipole-conserving systems with three and four site terms.

=== $t - J_z$ Model <t-j_z-model>

A simple example is the $t - J_z$ model in one dimension, which appears in the large-$U$ limit of the Hubbard model @zhang1997tJz @batista2000tJz.

The model describes the nearest-neighboring hopping of spin-1/2 fermions on a chain, within the constrained Hilbert space that forbids a double occupancy of sites.

Denoting spins by $sigma in { arrow.t ,  arrow.b }$ and the corresponding fermion creation and annihilation operators by $(c^"dagger")_(j, sigma)$ and $c_(j ,  sigma)$, the explicit Hamiltonian in one dimension can be expressed in terms of constrained fermion operators $tilde(c)_(j,sigma) equiv c_(j,sigma) (1 - (c^"dagger")_(j,-sigma) c_(j,-sigma))$ as

$
  H_(t-J_z) equiv sum_(j) [-t_(j) sum_(sigma in "{" ↑, ↓ "}") (tilde(c)_(j,sigma) tilde(c)^dagger_(j+1,sigma) + h.c.) + J^z_(j) S^z_j S^z_(j+1)],
$<eq:tJzhamil>
 where $t_j$, $J_j^z$ are arbitrary constants, $S_j^z = ( tilde(c)_(j ,  arrow.t)^dagger tilde(c)_(j ,  arrow.t) - tilde(c)_(j ,  arrow.b)^dagger tilde(c)_(j ,  arrow.b) )$, and $tilde(c)_(j ,  sigma)$.

In other words, denoting the fermions by $arrow.t$ and $arrow.b$ and vacant sites by $0$, the Hamiltonian only allows the transitions $|↑ 0⟩ -> |0 ↑⟩$ and $|↓ 0⟩ -> |0 ↓⟩$.
Given these transitions, it is easy to show that the $t - J_z$ model is fragmented in one dimension.

Since an $arrow.t$ cannot cross over a $arrow.b$ and vice-versa, the full pattern of fermion spins along the chain is conserved @rakovszky2019statistical, resulting in exponentially many dynamically disconnected Krylov subspaces that appear within quantum number sectors labelled by the total numbers of $arrow.t$ and $arrow.b$ fermions, the two $U ( 1 )$ symmetries of the system.

=== Miscellaneous Examples <miscellaneous-examples>

Other notable examples of fragmentation typically appear in the presence of hard constraints that naturally arise in effective Hamiltonians obtained by a truncation of the Schrieffer-Wolff transformation @bravyi2011SW in the presence of a large parameter, e.g. the dipole-conserving models in the presence of a large electric field.
For example, fragmentation similar to that in the $t - J_z$ model also occurs in the $t - V$ model in the strong coupling regime, which is illustrated in @detomasi2019dynamics.

Other such examples include certain one-dimensional models with strict confinement @yang2019hilbertspace, @chen2021emergent @bastianello2021fragmentation, where the Hamiltonian restricted to a Krylov subspace was shown to be the integrable XXZ model, models within the Fibonacci Hilbert space of the Rydberg blockade @mukherjee2021minimal, @mukherjee2021constraint, in the presence of frustration @lee2020frustrationinduced @hahn2021information or dipolar interactions @li2021hilbert.

In addition, several one-dimensional models introduced in earlier literature in various contexts have been shown to exhibit fragmentation, including the Fredkin @langlett2021hilbert, Motzkin @richter2021anomalous, Pair-Flip @moudgalya2021hilbert, folded XXZ @zadnik2021foldedxxz1 @zadnik2021foldedxxz2 @pozsgay2021integrable @bidzhiev2021macroscopic, and Temperley-Lieb spin chains @readsaleur2007 @moudgalya2021hilbert.

While most examples of fragmentation are in the product state basis, @moudgalya2021hilbert recently showed that one-dimensional models based on the Temperley-Lieb algebra, including the spin-1 biquadratic spin chains, are fragmented in an entangled basis constructed using spin singlets.

=== Higher Dimensional Systems <higher-dimensional-systems>

Relatively fewer models are known to exhibit fragmentation in dimensions higher than 1.
Several models that are fragmented in one dimension, for example the $t - J_z$ model of @eq:tJzhamil, are no longer fragmented in higher dimensions @eq:tJzhamil.

Nevertheless, @khemani2019local argued that the conservation of dipole moment in all directions on hypercubic lattices is sufficient to guarantee the existence of exponentially many frozen eigenstates.
In addition, they showed that the conservation of dipole and quadrupole moments in two dimensions is sufficient for the existence of several other features of fragmentation, including blockades that dynamically disconnect different parts of the system.

Meanwhile @khudorozhkov2021hilbert studied fragmentation in two-dimensional ring-exchange models, which in addition to conserving dipole and quadrupole moments, also possess certain subsystem symmetries.

=== General features of fragmented systems <subsubsec:genfeatures>

We now comment on a few general features that occur in fragmented systems.
However, note that the nature and consequences of fragmentation differ from model to model, and so far there is no universally accepted defining feature of fragmentation (see @moudgalya2021hilbert for a proposed definition).

Three common features of systems exhibiting fragmentation are: (i) Multiple types of Krylov subspaces where all parts of the system are “active”, (ii) Exponentially many product states that are completely frozen, (iii) Frozen regions that lead to blockades in the system that effectively disconnect “active” regions of the system.

As discussed in @subsec:dipoleconservation, the dipole-conserving systems possess all three features.
Other examples of fragmentation in the literature typically possess some of these features, although not necessarily all of them.
For example, several models discussed in the previous paragraph, including the $t - J_z$ model, do not possess feature (iii), i.e., it is not possible to construct frozen regions that disconnect regions of the system.
On the other hand, the PXP model discussed in @subsec:PXPmodels, from the point of view of the full spin-1/2 Hilbert space, can possess nearest-neighboring excitations $|⋯ ↑ ↑ ⋯⟩$ that are examples of “frozen regions” unaffected by the action of the Hamiltonian of @eq:PXPdefn.

These frozen regions dynamically disconnect different parts of the system, leading to exponentially many Krylov subspaces;#footnote[The experimentally relevant Krylov subspace among these is the Fibonacci Hilbert space, the one without any nearest-neighbor excitations, which is the focus of studies on the PXP model @SerbynReview. ] hence the PXP model is a trivial example of fragmentation that only possesses feature (iii).

== Implications to dynamics and connections to QMBS <subsec:fragmentationdynamics>

// [figvision] imgs/fragmentation_EE_figs.png
// Panel a is a scatter plot showing the bipartite entanglement entropy of eigenstates as a function of energy.
// The horizontal axis represents energy, while the vertical axis represents the entanglement entropy. Both axes
// are dimensionless and lack specific numerical ranges in the provided context. Data points are represented by
// scattered symbols, such as blue dots, corresponding to eigenstates in a specific quantum number sector defined
// by fixed total spin and domain wall number. No connecting lines are present. The plot displays a broad
// vertical spread of entropy values at any given energy level. This wide distribution visually conveys the
// system's strong Hilbert space fragmentation, contrasting with the narrow entropy bands seen in typical
// non-integrable systems.
#figure(placement: top, image("imgs/fragmentation_EE_figs.png", width: 387pt),
  caption: [
    (Color online) Figure reproduced from @yang2019hilbertspace showing the bipartite entanglement entropy (EE) of eigenstates in a system exhibiting strong Hilbert space fragmentation.

    (a) EE as a function of energy in a particular quantum number sector specified by the total spin $S^z$ and domain wall number $n_(D W)$.
    The wide distribution of the EE at a particular energy is in stark contrast to EE of eigenstates in typical non-integrable models.
    (b) EE of eigenstates within a particular Krylov subspace of the fragmented model.
    This plot resembles the behavior of the EE within a quantum number sector of typical non-integrable models.
  ]
) <fig:fragmentationproperties_ent>

From the perspective of the full Hilbert space $cal(H)$ after resolving quantum numbers of all the conventional symmetries, fragmented systems violate either strong ETH or weak (and hence also strong) ETH @sala2019ergodicity, @khemani2019local, giving rise to richer physics than QMBS.

=== Strong Fragmentation <strong-fragmentation>

Strongly fragmented systems, depicted in @fig:main, do not have a dominant Krylov subspace in the thermodynamic limit (i.e., $D_max\/D arrow.r 0$ as $L arrow.r oo$), and hence violate the conventional form of weak ETH (w.r.t. the full Hilbert space) in addition to strong ETH.
In contrast to examples of QMBS, typical initial states in strongly fragmented systems do not thermalize with respect to the full Hilbert space.

The absence of conventional thermalization can be understood in terms of the EE of eigenstates.

As discussed in @subsec:entanglement, in the absence of fragmentation, the bipartite EE of a typical eigenstate is given by $S_"th"$ of #ref(<thermalent>, supplement: none) for spin-1/2 systems.

In the presence of fragmentation, the EE of eigenstates that belong to the Krylov subspace $cal(K)_j$ about a subsystem with $L_cal(A) <= L\/2$ spins is upper bounded by $tilde log((D_(cal(K))_j[L_(cal(A))]))$, where $D_(cal(K))_j[L_(cal(A))]$ is the dimension of the Krylov subspace $cal(K)_j$ restricted to the subsystem of size $L_(cal(A))$, similar to the EE in constrained systems @morampudi2020universal @detomasi2020entanglement.

Similar bounds hold for the EE of a late-time state obtained by time evolution of product states $|psi_j⟩$ within a Krylov subspace $cal(K)_j$.

In a Krylov subspace whose dimension restricted to a subsystem grows exponentially with subsystem size, this could still result in a volume-law behavior, although with a smaller coefficient.
For example, in a spin-1/2 fragmented system and a Krylov subspace $cal(K)_j$ where $D_(cal(K))_j[L_(cal(A))] tilde phi^(L_(cal(A)))$ for $1 < phi.alt < 2$, the EE is bounded by $S <= L_cal(A) log phi << L_cal(A) log 2$.

On the other hand, the entanglement entropy for product states that are part of $cal(O) ( 1 )$-dimensional Krylov subspaces cannot exceed a constant value, resulting in a more apparent breakdown of thermalization.
Moreover, in fragmented systems that exhibit blockades discussed in @subsubsec:genfeatures, randomly chosen product states typically consist of regions that are frozen under the action of the Hamiltonian, which could lead to a further breakdown of thermalization.
For example, the entanglement entropy of all eigenstates within a Krylov subspace with a blockaded region is zero if the bipartition cut is within the blockaded region.
This variety of Krylov subspaces in fragmented models gives rise to a large variance of the EE of eigenstates even within a conventional quantum number sectors, e.g. as shown in @fig:fragmentationproperties_ent.

However, this variance is small for eigenstates within a Krylov subspace, as shown in @fig:fragmentationproperties_ent.

The existence of large Krylov subspaces, even after resolving conventional symmetry quantum numbers, also has direct implications for the level statistics and ETH in systems that exhibit strong fragmentation.
For example, an evident lack of level repulsion is observed between energy levels that belong to different Krylov subspaces, hence systems with strong fragmentation exhibit Poisson level statistics even after resolving conventional symmetry quantum numbers.
In addition, since the eigenstates in different Krylov subspaces are “uncorrelated”, diagonal ETH is generically violated.
In particular, the eigenstate expectation values of local operators are not smooth functions of energy even within a given quantum number sector of conventional symmetry, e.g., as shown for the $t - J_z$ model is shown in @fig:fragmentationETH.

This should be contrasted with the situation for typical non-integrable models, where the eigenstate expectation values of local operators are given by the thermal value at that energy, up to finite-size corrections (see @eq:ethmatrixel).

This is also different from models with QMBS, where diagonal ETH is satisfied in almost all eigenstates, apart from a small set of QMBS eigenstates, e.g., as shown in @fig:isolatedQMBS.

=== Weak fragmentation <weak-fragmentation>

Unlike strongly fragmented systems, weakly fragmented ones have a single dominant non-integrable Krylov subspace and its dimension approaches the dimension of the full Hilbert space in the thermodynamic limit (i.e, $D_max\/D arrow.r 1$ as $L arrow.r oo$).

Hence, while they violate strong ETH due to frozen eigenstates and $cal(O) ( 1 )$-dimensional Krylov subspaces, they generically satisfy weak ETH as a consequence of the dominant block.
Thus, typical initial states thermalize with respect to the full Hilbert space in weakly fragmented systems, although particular initial states that have large weight on the small Krylov subspaces do not thermalize.
This is also evident from conventional diagnostics such as the energy level statistics and entanglement entropy in weakly fragmented systems, which obey the same behavior as models with QMBS, summarized in @tab:taxonomy.

Indeed, weakly fragmented systems share a lot of their phenomenology with QMBS depicted in @fig:main, and the exponentially many eigenstates that do not belong to the dominant Krylov subspace should be considered examples of QMBS, according to the definitions discussed in @subsec:ergodicitybreaking.

Most of these eigenstates are generically not equally spaced in energy, hence they are examples of isolated QMBS discussed in @sec:isolated as opposed to towers of QMBS discussed in @sec:isolated#footnote[Note that as demonstrated in @sec:towers @detomasi2019dynamics @hudomal2020quantum @desaules2021proposal, it is possible to construct equally spaced eigenstates in some fragmented systems, particularly if the system can possess blockades. The existence of such eigenstates leads to revivals from particular initial states, giving rise to phenomenology of towers of QMBS in some fragmented systems. However, this is not generically the case.]

// [figvision] imgs/fragmentation_ETH_figs.png
// Panel (a) is a scatter plot of ⟨S^z_{L/2} S^z_{L/2+1}⟩ versus energy density E/L. The x-axis spans −0.6 to 0.6
// and the y-axis spans −0.4 to 0.4. Red dots mark L=16, green dots L=12, and orange dots L=8, as listed in the
// upper legend. The three datasets overlap heavily, forming a dense cloud centered near zero with large vertical
// scatter at almost every energy density, indicating broad fluctuations in eigenstate expectation values rather
// than a narrow thermal band. Panel (b) is a line plot of ⟨Q̂_j⟩_α versus site index j. The x-axis runs from 1
// to 15 with major ticks at even integers, and the y-axis runs from 0.00 to 0.20. A solid red line denotes the
// Krylov-restricted thermal value, while a dashed blue line denotes the late-time expectation value. Both curves
// begin near 0.12 at j=1, fall to about 0.045 at j=2, remain flat through j=7, spike sharply to roughly 0.17 at
// j=8, return to 0.045 at j=9, stay flat until j=14, and rise again to about 0.12 at j=15. The traces overlap
// except at the central peak, where the red line sits slightly higher.
#figure(placement: top, image("imgs/fragmentation_ETH_figs.png", width: 413pt),
  caption: [
    (Color online) ETH in fragmented systems. (a) Figure reproduced from @rakovszky2019statistical showing the expectation value of a certain local operator within eigenstates of the $t - J_z$ model of @eq:tJzhamil. The large variance in the distribution of the expectation values at a particular energy is in stark contrast to behaviour expected in generic non-integrable models. (b) Figure reproduced from @moudgalya2019thermalization showing the infinite-temperature thermalization of the charge density within a Krylov subspace of the pair-hopping model of @eq:pairhopping.
  ]
) <fig:fragmentationETH>

=== Krylov-Restricted Thermalization <krylov-restricted-thermalization>

In spite of ETH violation with respect to the full Hilbert space in fragmented systems, expectation values of local operators within eigenstates of sufficiently large (with dimension $cal(D)_(cal(K)) [ L ] arrow.r oo$ as $L arrow.r oo$) Krylov subspaces $cal(K)_j$ do show signatures of ETH, even in strongly fragmented systems.
This phenomenon was referred to as Krylov-Restricted Thermalization in @moudgalya2019thermalization, and evidence for its validity has been found in various fragmented systems @moudgalya2019thermalization @moudgalya2020quantum @yang2019hilbertspace @hahn2021information.

In strongly fragmented systems, the Krylov-Restricted Thermalization within the non-locally constrained Krylov subspaces $cal(K)_j$ can lead to many surprising consequences, including atypical late-time expectation values of local operators @moudgalya2019thermalization, @hahn2021information @feng2021hilbert, and an apparent Casimir effect @feng2021hilbert.

For example, the infinite-temperature charge density profile within a Krylov subspace of the pair-hopping model of @eq:pairhopping has been shown in @feng2021hilbert.

While Krylov-Restricted ETH is novel, @fig:fragmentationETH @detomasi2019dynamics @herviou2021manybody also showed the existence of an ETH-MBL transition within certain non-integrable Krylov subspaces of a spin-1/2 dipole conserving model, which should constitute a novel form of non-locally constrained MBL in fragmented systems that might be different from locally constrained MBL @chen2018localize @mondragonshem2020fate.

In addition, @bastianello2021fragmentation found the emergence of ballistic transport and phenomenology associated with integrable systems, in a fragmented model possessing some integrable Krylov subspaces.

=== Labelling Krylov Subspaces <labelling-krylov-subspaces>

The results on Krylov-restricted thermalization show that large enough Krylov subspaces in fragmented systems closely resemble quantum number sectors corresponding to conventional symmetries, and calls for a characterization of Krylov subspaces in the same language as conventional symmetries.
Such a question was first explored in @rakovszky2019statistical, where operators referred to as “Statistically Localized Integrals of Motion” (SLIOMs) were introduced for the $t - J_z$ model and the minimal-range spin-1 dipole moment conserving model with OBC.
Remarkably, the full set of eigenvalues under all the SLIOMs uniquely label the Krylov subspaces.
However, unlike operators corresponding to conventional symmetries, these SLIOMs are highly non-local operators, although they are “localized” in a sense defined in @rakovszky2019statistical and can be used to explain the anomalous late-time behavior of autocorrelation functions @rakovszky2019statistical @moudgalya2021hilbert.

In particular, for certain models of fragmentation, the existence of SLIOMs implies boundary localization and analogues of strong zero modes @fendley2012parafermionic @fendley2016strong @alicea2016topological for non-integrable models.
Apart from the $t - J_z$ model, the SLIOMs have also proved useful in explaining dynamical phenomena in other models of fragmentation, e.g., in the context of dimer models @feldmeier2021emergent.

While it is not clear if SLIOMs can be constructed in all examples of fragmentation, more recently, @moudgalya2021hilbert approached the question of labelling Krylov subspaces using the language of so-called “commutant algebras”, which generalizes the notion of the symmetry algebra for systems with conventional symmetries.
In particular, the commutant algebra is defined for a family of systems (e.g. for $sum_j J_j H_j$ in the case of the pair-hopping model of @eq:pairhopping, and it is the algebra of operators that commute with that family.
Equivalently, it is the algebra of all operators that commute with each term of the Hamiltonian, e.g. with all the $H_j$ in the pair-hopping model.

@eq:pairhopping showed that the irreducible representations of this commutant algebra uniquely define the Krylov subspaces corresponding to a family of systems.
Further, the algebra also contains all the local and non-local conserved quantities of that family of systems, including the SLIOMs, which uniquely label the Krylov subspaces.

@moudgalya2021hilbert full commutant algebras and the corresponding Krylov subspaces were explicitly constructed for several fragmented models, including systems where the definition of SLIOMs is not straightforward.

Finally, we note that fragmentation in certain models occurs due to the presence of strictly localized integrals of motion, i.e., operators with support on a small number of consecutive sites.
For example, in the PXP model discussed in @subsubsec:genfeatures, the projector $|↑ ↑⟩⟨↑↑|$ onto a nearest-neighbor configuration with excited Rydberg atoms is a strictly local conserved quantity.
Such conserved quantities are analogous to Local Integrals of Motion (LIOMs) that occur in systems exhibiting many-body localization @nandkishore2015many.

Such examples were recently referred to as “local fragmentation” in @buca2021local, and it is then straightforward to label the Krylov subspaces using the LIOMs.
This systems should be contrasted with systems such as dipole conserving models, that exhibit “true fragmentation”, where it is not clear if strictly local conserved quantities exist.

== Autocorrelation Functions <autocorrelation-functions>

// [figvision] imgs/fragmentation_autocorr2.png
// Panel (a) is a line plot of ⟨S^z_i(t)S^z_i(0)⟩ − 2/(3N) versus time t on a logarithmic x-axis spanning 10^-2
// to 10^2, with a y-axis from 0.0 to roughly 0.65. A solid red curve labeled H_3 and a solid blue curve labeled
// H_3 + H_4 appear in a legend at the upper right. Both curves start near 0.62. The red curve drops around t =
// 10^-1, oscillates about a dashed black horizontal line at y = 0.2, and stays noisy near that plateau for t ≳
// 1. The blue curve falls earlier, dips below the dashed line to a minimum near 0.1 around t ≈ 0.3, rebounds
// slightly, and decays toward zero by t = 10^2. The label (a) is in the lower left.
#figure(placement: top, image("imgs/fragmentation_autocorr2.png", width: 236pt),
  caption: [
    (Color online) Figure reproduced from @yang2019hilbertspace showing the autocorrelation function of the local spin operator in a spin-1 dipole-moment-conserving system exhibiting strong (red) and weak (blue) fragmentation for several system sizes $N$.

    While autocorrelation functions of local operators in generic non-integrable systems are expected to decay to zero at large times for system sizes , the strongly fragmented dipole-conserving Hamiltonian $H_3$ of @eq:H3hamil.
  ]
) <fig:fragmentationproperties_auto>

Similar to QMBS, some of the key diagnostics used in the literature to identify Hilbert space fragmentation are the bipartite EE, the energy level statistics, and the expectation values of local operators in eigenstates to test ETH, diagnostics discussed in @sec:ergodicity.

In addition to these conventional measures, operator spreading (or lack thereof) has played a key role in diagnosing and understanding fragmented systems @pai2018localization.

In particular, the spreading of a local operator can be characterized by its autocorrelation function, and we discuss its properties below.

=== Definition and Properties <definition-and-properties>

The infinite-temperature autocorrelation function of a local operator $hat(O)$ under the Hamiltonian $H$ is defined as

$
  cal(A)_L (t) equiv ⟨hat(O)(t) hat(O)(0)⟩ = frac(1, D)"Tr"{(e^(i H t) hat(O) e^(-i H t) hat(O))},
$<eq:autocorr>
 where $D$ is the Hilbert space dimension and $L$ is the system size.

The behavior of autocorrelation functions of local operators, both as a function of time and system size, contain a lot of information about the system, including its symmetries and the nature of transport.
In the infinite-time limit, the saturation value of the autocorrelation function, or more precisely the infinite-time average defined as $macron(cal(A))_L equiv lim_(T arrow infinity){frac(1, T)integral_0^T{d t #h(0.25em) cal(A)_L (t)}}$, is an indicator of the symmetries of the Hamiltonian $H$.
Indeed, the Mazur bound that provides a lower bound on $macron(cal(A))_L$ is stated in terms of the overlap of the operator $hat(O)$ on the various conserved quantities of the system @mazurbound1969, @suzukiequality1971 @dhar2020revisiting @rakovszky2019statistical @moudgalya2021hilbert, and this bound is generically saturated.
For example, in a system with $U ( 1 )$ charge conservation, $macron(cal(A))_L$ is expected to decay with system size as $macron(cal(A))_L tilde.op 1 \/L$, a scaling that can be understood in terms of Mazur bounds @rakovszky2019statistical @moudgalya2021hilbert.

In the infinite-size limit, where the quantity of interest is $cal(A)_infinity(t) equiv lim_(L arrow infinity)cal(A)_L (t)$, the decay of the autocorrelation function with time reveals the nature of transport in the system.
For example, in diffusive systems, this autocorrelation function in the thermodynamic limit is expected to decays with time $cal(A)_(infinity)(t) tilde.op 1 \/sqrt(t)$, which also forms a numerical diagnostic of the nature of transport in the system.
Similarly, the system is said to be subdiffusive if $cal(A)_(infinity)(t) tilde.op 1 \/t^beta$ for $beta < 1\/2$, which is observed in several constrained systems, including ones that conserve dipole moment @feldmeier2020anomalous @morningstar2020kinetically @iaconis2019anomalous @iaconis2021multipole @moudgalya2021spectral.

Below we discuss some of aspects of these diagnostics in fragmented systems.

=== Strong Fragmentation <strong-fragmentation>

Strong fragmentation is also usually associated with an anomalous saturation of the infinite-time autocorrelation function $macron(cal(A))_L$ of local operators as a function of system size.
For example, strongly fragmented dipole-moment conserving systems, e.g., the pair-hopping model of @eq:pairhopping or the spin-1 model of @eq:H3hamil, are known to exhibit “operator localization”@eq:H3hamil.

That is, when $hat(O)$ is chosen to be a strictly local operator on a site $j$, the weight the time-evolved operator on the original site $j$ is finite even at infinite times, which is reflected in the finite value of $macron(cal(A))_L$ even in the the thermodynamic limit, e.g., as shown in the red curve in @fig:fragmentationproperties_auto.

This is contrast to systems with conventional symmetries, where local operators are expected to spread uniformly throughout the system at late times, and $macron(cal(A))_L$ is expected to decay with system size.
This operator localization in dipole-conserving systems can be understood to be a consequence of the abundance of Krylov subspaces with blockades @rakovszky2019statistical, @moudgalya2021hilbert, closely related to strong fragmentation.
Similar effects are also observed in the autocorrelation functions of local operators in the $t - J_z$ model @rakovszky2019statistical, @moudgalya2021hilbert, where certain operators on the boundary are localized.
In addition, the autocorrelation functions of local operators in the bulk exhibit a decay of $macron(cal(A))_L tilde.op 1 \/sqrt(L)$, whereas a decay of $macron(cal(A))_L tilde.op 1 \/L$ is expected from conventional symmetry considerations.

=== Weak fragmentation <weak-fragmentation>

In addition, unlike strongly fragmented systems, the effect of weak fragmentation can safely be ignored in the context of infinite-temperature properties of the system, e.g., in the autocorrelation functions $cal(A)_L (t)$ of local operators.

This is the case in dipole-moment conserving systems, for example, where there has been a large interest in its sub-diffusive transport at infinite-temperature @feldmeier2020anomalous @guardado2020subdiffusion @zhang2020subdiffusion @moudgalya2021spectral.

Even though dipole-moment conserving systems with finite-range terms are always fragmented, the fragmentation is weak beyond a certain range (e.g., in the pair-hopping model discussed in @subsec:dipoleconservation) and the autocorrelation functions of local operators decay as $macron(cal(A))_infinity(t) tilde.op 1 \/t^(frac(1, 4))$, which can be understood without taking fragmentation into consideration.
Furthermore, the infinite-time autocorrelation function $macron(cal(A))_L$ also decays with system-size, e.g., as shown in the blue curve in @fig:fragmentationproperties_auto, indicating the absence of operator localization.
This distinction in the behavior of autocorrelation functions (as well as out-of-time-ordered correlation functions (OTOCs)) between strongly and weakly fragmentated systems has also been used to study the “freezing transition” from weak to strong fragmentation @morningstar2020kinetically  @feldmeier2021critically.

= Discussion and Outlook <sec:outlook>

// [figvision] imgs/pxp_improved_bottom.png
// This panel is a scatter plot overlaid with a density heatmap. The horizontal axis is labeled E and runs from
// -20 to 20, while the vertical axis is labeled S and runs from 0 to above 6. Black points densely populate an
// arch centered at E=0 that peaks near S=6.5, with an additional sparse band of points around S=2. A color
// gradient spans from black and purple at the periphery to bright yellow-white at the apex near E=0, S≈6.2,
// indicating the greatest density of states. The panel shows a broad thermalizing spectrum with an arch-shaped
// upper region and a weaker lower band. This panel is a scatter plot with E on the horizontal axis from -20 to
// 20 and S on the vertical axis from 0 to above 6. Black points form a lower curved band roughly between S=1 and
// S=3.5 across the energy range. Above this band, a colored density region extends from about S=3 to S=6, shaded
// dark purple near the bottom and bright yellow at the center top around E=0, S≈5.5. A few scattered black dots
// appear within and above the colored region. The panel suggests a clearer separation between low-entropy states
// below and a thermal bulk above. This panel is a scatter plot with E on the horizontal axis from -20 to 20 and
// S on the vertical axis from 0 to above 6. Black points trace an upper arch filled with color grading from
// purple to yellow-orange, reaching a maximum at E=0 and S≈6.2. Beneath this arch, isolated black dots form a
// nearly flat, sparse distribution around S=1 to S=2 extending from roughly E=-15 to E=15, with endpoints near
// S≈1.5. The panel highlights a distinct low-entropy band separated from the colored thermal arch above.
#figure(placement: top, image("imgs/pxp_improved_bottom.png", width: 454pt),
  caption: [
    (Color online) Figure reproduced from @yang2019hilbertspace showing the “enhancement” of the QMBS in the PXP model with the addition of a particular perturbation. This result, among many others (e.g., those discussed in @lin2019exact @iadecola2019quantum), hints towards a connection between examples of exact towers of QMBS discussed in this review and the approximate QMBS in the PXP model.
  ]
) <fig:outlook_pxp>

Despite being a relatively new field, QMBS has already attracted a large attention as exemplified in this review.
Nevertheless, several major open questions remain, and we summarize a few of those in the following.

#heading(level: 3, numbering: none)[Unified framework for QMBS]
<unified-framework-for-qmbs>

An immediate question is the development of a unified language to describe and understand known examples of QMBS, which might lead to a finer classifications of QMBS.
As discussed in @sec:unifiedformalism, some progress in this direction has been made with the introduction of embedding, SGA-based, and symmetry-based formalisms to explain several examples of towers of QMBS.
However, the precise relations between the various formalisms are not yet clear.
Several examples of towers of QMBS discussed in @subsec:othertowers, including the QMBS in the spin-1 AKLT model, fall outside the Shiraishi-Mori (SM) embedding and symmetry-based formalisms.
On the other hand, unlike the embedding and symmetry-based formalisms, the SGA-based formalisms lack a precise prescription for constructing models with QMBS.
Furthermore, many examples have not been explicitly shown to be captured by any of the formalisms, for example the second tower of QMBS in the spin-1 XY model @eq:HubbardQP @schecter2019weak @chattopadhyay2019quantum, which are not expressed as a repeated action of a raising operator on a simple eigenstate.
For isolated examples of QMBS discussed in @sec:isolated, the SM formalism captures several examples in the literature, although the connection is not always immediately apparent.
Yet there are examples of isolated QMBS such as the exact eigenstates in 2d and higher-dimensional PXP models discussed in @subsec:PXPmodels that are yet to be understood in this approach.
A better understanding of the QMBS formalisms will also help extend examples of QMBS, many of which are restricted to one-dimensional systems, to higher dimensions.
Moreover, higher dimensions might also reveal qualitatively different types of QMBS, such as the exponentially many QMBS in the 2D PXP model discussed in @subsec:PXPmodels, which have no 1D counterparts.

#heading(level: 3, numbering: none)[Stability of QMBS]
<stability-of-qmbs>

Another important question that requires further investigation is the stability of exact QMBS to perturbations.
One aspect of stability is whether the QMBS eigenstates survive perturbations in the thermodynamic limit.

@lin2020slow and @surace2021exactstability explored this question for the exact QMBS in the 1d PXP model @lin2019exact    and the tower of QMBS in the spin-1 XY model @schecter2019weak, and found evidence that in the thermodynamic limit, QMBS are unstable to generic perturbations, i.e., they hybridize with thermal eigenstates for arbitrary small perturbation strengths.
Nevertheless, the thermalization times for local observables in the perturbed model was found to be finite and parametrically large (i.e., diverging as the perturbation strength goes to zero) even in the thermodynamic limit @lin2020slow, and the QMBS eigenstates displayed anomalous robustness at first order perturbation theory @surace2021exactstability.

These results show that the exact QMBS in the PXP model do have some degree of stability under perturbations even in the thermodynamic limit, and it would be interesting to systematically probe this question for other examples of QMBS, particularly for exact towers discussed in @sec:towers.

Irrespective of their stability in the thermodynamic limit, a more experimentally relevant question in the current era of quantum simulators and Noisy Intermediate Scale Quantum (NISQ) devices @preskill2018quantumcomputing is the stability of QMBS signatures in finite-size systems.
For example, we can ask whether signatures of QMBS such as anomalous dynamics on unexpectedly long time-scales persist under perturbations, or if for finite system sizes, approximate QMBS survive in models that are proximate to those with exact QMBS.
A classic example is the PXP model, where approximate QMBS seem rather robust to perturbations @choi2018emergent, @mondragonshem2020fate @turner2021correspondence @bull2020quantum @surace2021quantum, and experimentally show slowly-decaying revivals @bernien2017probing @bluvstein2020controlling.

These experimental setups consist of 51-200 Rydberg atoms, far from the thermodynamic limit, which motivates the study of the stability of QMBS at finite system-sizes.
The QMBS in the PXP model have been studied using a wide variety of techniques that yield several insights into the origin of the approximate QMBS @SerbynReview, @ho2018periodic @michailidis2020slow @turner2021correspondence @bull2020quantum, and several phenomenological results are known about the PXP models, and their deformations @khemani2019int @choi2018emergent @bull2019systematic @yao2021quantum.

Nevertheless, a major open question in this field is to precisely connect these results on the approximate QMBS in the PXP to exact QMBS in various other systems.
In particular, can these approximate QMBS be understood due to its proximity to a model with exact QMBS?
Evidence supporting this was shown in @lin2019exact, @mark2019new @iadecola2019quantum, which found approximate momentum $pi$ multi-quasiparticle descriptions of the PXP QMBS.

Moreover, @khemani2019int found a Hamiltonian proximate to the PXP model that shows an atypical behavior of level statistics with system size, which they conjectured to be an integrable point.

Later, @choi2018emergent found a different Hamiltonian proximate to the PXP model that exhibits almost perfect revivals and a greatly enhanced decoupling of the QMBS subspace from the rest of the spectrum (see @fig:outlook_pxp).

These works reveal that the phenomenology of the approximate QMBS in the PXP model resembles that of exact towers of QMBS discussed in @sec:towers, and suggest that exact QMBS might have more stability than currently believed, at least for present-day experimentally accessible system-sizes.

#heading(level: 3, numbering: none)[Floquet QMBS]
<floquet-qmbs>

The exploration of QMBS beyond Hamiltonian systems, for example in Floquet systems, is also an interesting direction of study.
Exact QMBS in the PXP model @lin2019exact were extended to Floquet-PXP Hamiltonians in @mizuta2020exact, and some of them were shown to be intrinsic to Floquet systems, arising only at particular drive frequencies @sugiura2021manybody.

A related result is the construction of exact eigenstates based on short orbits in a cellular automaton that is obtained in an appropriate limit of the Floquet-PXP Hamiltonian in @iadecola2020nonergodic.

Moreover, it should be possible to generalize some of unified formalisms, particularly the SM formalism to Floquet systems, which might lead to Floquet analogues of some of the QMBS discussed in this review.
The exploration of QMBS in Floquet systems is particularly interesting since recent experimental and numerical results suggest that QMBS in the PXP model can be stabilized under periodic driving @bluvstein2020controlling @maskara2021discrete.

Furthermore, obtaining more analytically tractable examples might shed light on the many numerical results on QMBS in driven systems @pai2019dynamical @mukherjee2020collapse @pizzi2020timecrystal @yarloo2020homogeneous @zhao2020quantum @haldar2021dynamical.

#heading(level: 3, numbering: none)[Fragmentation and symmetries]
<fragmentation-and-symmetries>

// [figvision] imgs/Fragmentation_figures.png
// Panel (a) is a schematic diagram, not a plot, with no axes or units. It shows a block diagonal matrix enclosed
// in large square brackets. Grey squares of varying sizes lie along the diagonal: a medium square at top left, a
// larger square below and right, a vertical ellipsis, and two squares at bottom right. Curved brackets on the
// right group blocks and are labeled "Regular Quantum Number Sectors." The diagram conveys that conventional
// symmetries split the Hilbert space into several dynamically disconnected Krylov subspaces. Panel (b) is a
// schematic diagram with no axes, illustrating Hilbert space fragmentation. Grey squares of different sizes
// appear along a bracketed diagonal: a top-left square, a larger square beneath it, a tiny square to the right,
// a vertical ellipsis, and a bottom-right cluster of three small squares. Curved brackets on the right are
// annotated "~ exp(L)," indicating an exponentially large number of sectors. Compared with panel (a), the many
// fragmented blocks show that the Hilbert space splits into a vastly larger set of disconnected Krylov
// subspaces. Panel (c) is a schematic diagram with no axes, depicting QMBS. A single very large light-grey
// square labeled "Thermal" fills nearly the entire bracketed matrix. In the bottom right corner, a small
// separate grey square is labeled "QMBS." The layout implies that almost the whole Hilbert space forms one
// thermalizing Krylov subspace, while a tiny dynamically disconnected sector hosts non-thermalizing quantum
// many-body scar states.
#figure(placement: top, image("imgs/Fragmentation_figures.png", width: 410pt),
  caption: [
    Schematic depiction of the block diagonal structure of the Hamiltonian showing the dynamically disconnected “Krylov subspaces” in systems with (a) conventional symmetries (b) Hilbert space fragmentation (c) QMBS.
  ]
) <fig:outlook_QMBS_fragmentation>

Turning to Hilbert space fragmentation, several open questions are still looming.
Firstly, the phenomenon of Hilbert space fragmentation clearly demonstrates the need to sharpen the definition of “symmetry” in a quantum many-body system @moudgalya2021hilbert.

The Krylov subspaces that occur in fragmented systems are strongly reminiscent of quantum number sectors of conventional symmetry, e.g., as shown in @fig:outlook_QMBS_fragmentation.

Conserved quantities associated with conventional symmetries are typically sums of local terms, or products of on-site unitary operators, and the dynamically disconnected subspaces in such systems are the different eigenspaces of such quantities.
However, in fragmented systems, the Krylov subspaces are labeled by the eigenvalues of certain non-local conserved quantities @rakovszky2019statistical, @moudgalya2021hilbert, which could be considered as “non-local symmetries”; however, unlike non-local symmetries that appear in the literature (e.g., in the context of topological systems), these do not have obvious on-site actions.
If arbitrary non-local operators are considered valid conserved quantities, any finite-dimensional Hamiltonian trivially has exponentially many conserved quantities – the eigenstate projectors; hence the necessity of a better definition, or a more practical and experimentally motivated one.
This might also help settle debates @mondaini2018comment @shiraishimorireply about which symmetries/Krylov subspaces are needed to be resolved in order to test ETH.
Understanding the precise nature of ETH-violation in fragmented systems is important, since restricted versions of ETH and MBL have been found to hold within sufficiently large Krylov subspaces, leading to notions of Krylov-Restricted Thermalization and its breakdown.

#heading(level: 3, numbering: none)[Analytical examples of fragmentation]
<analytical-examples-of-fragmentation>

A different direction that needs to be pursued is the search for additional analytically tractable examples of fragmentation, which might also help better understand the necessary and sufficient conditions for fragmentation to occur.

As discussed in @subsec:dipoleconservation, an experimentally relevant example that is well understood is the case with dipole moment conservation in one dimension.
While a general characterization of all the Krylov subspaces was obtained in the minimal-range spin-1 dipole-conserving model in @moudgalya2021hilbert, a more general understanding of the longer-range dipole-conserving model apart from the minimal-range ones @moudgalya2019thermalization @rakovszky2019statistical @moudgalya2021hilbert is lacking, and many of the results, such as the nature of fragmentation (strong or weak), rely on numerical observations.
The exploration of fragmentation in higher dimensions is also important, particularly since two-dimensional systems are sometimes easier to simulate using optical lattices.
Multipole moment conservation laws can be imposed by subjecting systems to particular electric potentials, and while @khemani2019local showed that these are sufficient to guarantee fragmentation, several questions, such as the structure of larger Krylov subspaces, have not been explored.
Hilbert space fragmentation might also be related to several earlier examples of ergodicity breaking due to the formation of dynamical subsectors, such as dynamical localization in gauge theories @smith2018dynamical, or localization due to superselection sectors @kim2016localization, and it would be interesting to make the connections more precise.
On a different note, several aspects of fragmentation might be relevant in the study of equilibrium physics close to the ground state.
For example, as a consequence of fragmentation, the ground state and some low-lying excited states of some dipole-conserving models that appear in the thin-torus limit of fractional Quantum Hall systems were found to have simple expressions in terms of fragmented Matrix Product States @nachtergaele2020lowcomplexity, @nachtergaele2021spectral, which proved useful in addressing questions on the gap of such systems @warzel2021bulk @warzel2021spectral.

#heading(level: 3, numbering: none)[Classical versus Quantum fragmentation]
<classical-versus-quantum-fragmentation>

Finally, most examples of Hilbert space fragmentation consist of Hamiltonians that are fragmented in the product state basis (“classical fragmentation”), and the Krylov subspaces are completely determined by the transitions between product states allowed by terms of the Hamiltonian, which is essentially a classical process.
The possibility of fragmentation in a more entangled basis (“quantum fragmentation”) was recently pointed out in the spin-1 biquadratic model @moudgalya2021hilbert, but the dynamics in such systems is relatively unexplored, and it remains to be understood whether such fragmentation leads to qualitatively new dynamical phenomena absent in simpler models.
Exploring fragmentation and Krylov subspaces in different bases might also help distinguish between or establish a relation between QMBS discussed in @sec:towers and @sec:unifiedformalism and the phenomenon of weak Hilbert space fragmentation, which share several common features.
In particular, can towers of QMBS be understood in the same language as Hilbert space fragmentation, since the subspace spanned by the QMBS can be viewed as an small Krylov subspace within the full Hilbert space @bull2020quantum (see @fig:outlook_QMBS_fragmentation)?

QMBS and Hilbert space fragmentation have already attracted a large attention thanks to their experimental realization in quantum simulators and the existence of an abundance of exact results and toy models, a rarity in the realm of strongly correlated quantum systems.
However the number of open challenges that we have tried to expose here will undoubtedly be a source of rich discussions and physics, and guarantees a bright and exciting future for this field.

#emph[Note added] — While this review was in preparation, @papic2021weak appeared, which provides a complementary pedagogical review of aspects of quantum many-body scars and Hilbert space fragmentation.

We are particularly grateful to Lesik Motrunich for enlightening discussions.
We also acknowledge useful discussions with Berislav Buca, Dumitru Calugaru, Paul Fendley, David Huse, Tom Iadecola, Frank Pollmann, and Pablo Sala.
We thank Stephan Rachel, Abhinav Prem, Rahul Nandkishore, Ana Hudomal, Ivana Vasic, Zlatko Papic, Loic Herviou, Jens Bardarson, Edward O'Brien, Paul Fendley, and Lesik Motrunich for previous collaborations on related topics.
We are grateful to Yichen Huang, Tom Iadecola, Igor Klebanov, Kiryl Pakrouski, Zlatko Papic, Fedor Popov, Frank Pollmann, Lesik Motrunich, Pablo Sala, and Lenart Zadnik for their comments and feedback on an earlier version of this review.
This work is part of a project that has received funding from the European Research Council (ERC) under the European Union's Horizon 2020 research and innovation programme (grant agreement no. 101020833).
This work is supported by the Walter Burke Institute for Theoretical Physics at Caltech and the Institute for Quantum Information and Matter.
S.M. acknowledges the hospitality of the Aspen Center for Physics, where a part of this work was completed.
The Aspen Center for Physics is supported by National Science Foundation grant PHY-1607611.
This work was also partially supported by a grant from the Simons Foundation.

#heading(level: 1, numbering: none)[References]
<references>

#{
  set text(size: 10pt)
  set par(leading: 0.61em)
  bibliography("refs.bib", style: "../../typst-refs/iop-num.csl", title: none)
}