#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 9pt, lang: "en")
#set page(numbering: none, paper: "a4", margin: (left: 3.01cm, right: 5.12cm, top: 3.53cm, bottom: 5.25cm))
#set heading(numbering: (..n) => if n.pos().len() == 1 { numbering("1.", ..n) } else { numbering("1.1.", ..n) })
#show heading: set text(font: "CMU Sans Serif", fill: rgb("#b11116"), size: 10pt)
#set par(justify: true, spacing: 0.97em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.67em)
#set figure.caption(position: bottom)
#set math.equation(numbering: "(1)")
#show math.equation.where(block: true): set align(center)
#show ref: it => {
  let el = it.element
  if el != none and el.func() == math.equation {
    link(it.target, numbering("(1)", ..counter(math.equation).at(it.target)))
  } else { it }
}

#align(center)[
  #text(20.7pt, weight: "bold", [Quantum Many-Body Scars: A Quasiparticle Perspective])   #v(1.2em)
  #text(10.5pt)[Anushya Chandran1, Thomas Iadecola2,3]
  
]
#v(1.6em)














Weakly interacting quasiparticles play a central role in the low-energy description of many phases of quantum matter. At higher energies, however, quasiparticles cease to be well-defined in generic many-body systems due to a proliferation of decay channels. In this review, we discuss the phenomenon of quantum many-body scars, which can give rise to certain species of stable quasiparticles throughout the energy spectrum. This goes along with a set of unusual non-equilibrium phenomena including many-body revivals and non-thermal stationary states. We provide a pedagogical exposition of this physics via a simple yet comprehensive example, that of a spin-1 XY model. We place our discussion in the broader context of symmetry-based constructions of many-body scar states, projector embeddings, and Hilbert space fragmentation. We conclude with a summary of experimental progress and theoretical puzzles.











#pagebreak()
#align(left)[#set par(first-line-indent: 0em)
  #text(10.0pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 10.0pt)
  #set par(first-line-indent: 0em, leading: 0.44em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { it } else { it }
  }
  #outline(title: none, depth: 2)
]

= Introduction
<introduction>


Interacting quantum matter can exhibit excitations --- e.g.~phonons in solids or magnons in magnets --- that involve the collective motion of many particles and yet, remarkably, act like a single emergent entity. Such objects are dubbed #emph[quasiparticles]. The emergence of long-lived quasiparticles in very different types of condensed matter systems is so commonplace that one barely registers just how remarkable a phenomenon it is.


There are various well-established mechanisms for stabilizing quasiparticles at low energies as encoded, for instance, in Goldstone's theorem for broken continuous symmetries, or in Ginzburg's kinematic argument for long-lived quasi-electrons and quasi-holes in Fermi liquids~@cha95 @coleman_2015 @moessner_moore_2021. In contrast, stabilizing quasiparticles at higher energies is a different issue altogether. It is commonly believed that quasiparticles become unstable when they encounter the continuum of many-particle excited states at high energies, and decay swiftly when kinematically permitted.


The existence of long-lived quasiparticles at energies well above the single-quasiparticle bandwidth should therefore register surprise.


In fact, there exist various routes towards stabilizing quasiparticles beyond the low-energy limit. Perhaps the most straightforward of these arises in the case of noninteracting particles, where long lifetimes arise due to the complete absence of decay processes. This comprises rather important phenomena such as Anderson localization as well as any noninteracting---e.g., topological---band structures, and includes spin systems related to such models via Jordan-Wigner transformations. More elaborate are “interacting integrable” models, such as low-dimensional models soluble by the Bethe ansatz~@Bethe_1931 @Giamarchi03 @Sutherland04 @Essler05, where particles scatter without decaying. The presence of certain symmetries can also guarantee the existence of infinitely long-lived quasiparticles, as in the $eta$-pairing eigenstates of the Fermi-Hubbard model~@Yang89 Further, sufficiently strong interactions may actually impede, rather than promote, quasiparticle decay in certain energy windows~@Bhatt:1974 @Basko:2017 @Verresen:2019.


The subject of this review concerns a new mechanism of obtaining stable quasiparticles in interacting systems, which goes under the heading of “quantum many-body scars.” This term was coined in Ref.~@Turner18a by analogy to the phenomenon of wavefunction scarring in single-particle quantum mechanical systems arising from the quantization of a corresponding classical model~@Heller84. In such systems, quantum mechanical wavefunctions exhibit regions of enhanced probability, called scars, concentrated around unstable periodic trajectories of the classical system. The analogy posited in Ref.~@Turner18a defines quantum #emph[many-body] scars as the existence of special highly-excited eigenstates with atypically large weights on certain “simple” many-body states. The dynamics of the many-body system, when prepared in one of these simple states, becomes strongly nonthermal. For example, the system can exhibit finite-time revivals of the wavefunction, which generically occur only at astronomically long times (associated with Poincaré recurrence) in nonintegrable systems@CamposVenuti15. While a variety of mechanisms for quantum many-body scars have been proposed, a ubiquitous one is the emergence of a small subset of stable quasiparticles, out of which special many-particle states throughout the many-body spectrum can be constructed~@Moudgalya18a @Moudgalya18b @Schecter19 @Iadecola20 @Mark20a @Mark20 @Moudgalya20 @Chattopadhyay20@ODea20@Pakrouski20 @Pakrouski21 @Ren21 @Tang21 @Langlett22 @Omiya22. In idealized models, such quasiparticles have infinite lifetime, in contrast to the naive expectation outlined above.


These phenomena represent a deviation from the expected behavior of generic (i.e., interacting, nonintegrable) quantum many-body systems. The coherent quantum many-body dynamics of such systems has been the subject of a separate thread of investigation of much current interest. Nucleated by experimental developments---e.g., the advent of analog and digital quantum simulation platforms with low levels of environmental decoherence~@Houck12 @Langen14 @Morgado20 @Monroe21 important question has been the connection between microscopic quantum theory and macroscopic thermodynamics~@DAlessio16@Deutsch18. The eigenstate thermalization hypothesis (ETH)~@Jensen:1985aa @Deutsch91 @Srednicki94 @Rigol08 is a central concept in this context. It states that an eigenstate, $\| alpha chevron.r$, of a many-body Hamiltonian, $H \| alpha chevron.r = E_alpha \| alpha chevron.r$, exhibits the same properties as the appropriate Gibbs ensemble at the energy density $epsilon.alt_alpha = E_alpha / V$ to leading order in the volume $V$ of the system. For example, for any few-body operator $O$, the eigenstate expectation value $chevron.l alpha \| O \| alpha chevron.r$ is a smooth function of $epsilon.alt_alpha$. Similarly, if one partitions the system into two subregions $A$ and $B$ and calculates the reduced density matrix $rho_A = "tr"_B |alpha⟩ ⟨alpha|$, the entanglement entropy $S_A = - "tr" ( rho_A ln rho_A )$ scales extensively with the volume of $A$ at any finite temperature with the coefficient set by the thermal entropy density at the energy density $epsilon.alt_alpha$. In different words, the exponentially large amount of microscopic information encoded in the coefficients of the wavefunction on Hilbert space appears to be largely superfluous when determining thermodynamic observables.


A many-body eigenstate in which expectation values of few-body observables differ from the thermodynamic values


is thus at odds with eigenstate thermalization. In the aforementioned examples of noninteracting and interacting integrable systems, the ETH as stated above does not apply and must be generalized to account for an extensive number of additional conserved quantities@Vidmar16.


It is believed that the addition of a generic local perturbation of finite strength will destroy the special features associated with integrability and give way to conventional thermalizing behavior~@Santos:2004vu @Rabson:2004nx @Santos:2010va @Modak:2014 @Pandey:2020uo.


The one generic exception to the ETH is believed to be provided by many-body localization (MBL) in strongly disordered, yet interacting systems~@Nandkishore15 @Abanin19, in which extensively many #emph[local] conserved degrees of freedom preclude thermalization~@Serbyn13 @Huse14 @Swingle13. The existence of such stable emergent integrability is however still being debated~@Suntajs2020 @Sels2021 @Abanin:2021vq @Panda:2020aa @Crowley:2020 @Morningstar:2021.


Unlike systems with explicit or emergent integrability, systems with quantum many-body scars exhibit features that contrast with the ETH, but #emph[only] in a fraction of (excited) states that #emph[vanishes] in the thermodynamic limit. The vast majority of eigenstates instead look thermal. The non-thermal features may be broadly classified into three categories:

+ The existence of certain species of infinitely long-lived quasiparticles,

+ Persistent many-body revivals at finite times in the dynamics, and

+ Non-thermal stationary states (e.g., eigenstates or late-time states under time evolution) that have atypically low (#emph[i.e.], sub-thermal) entanglement and large weights on certain simple states.

All of these items signal an absence of thermalization, touching on different aspects of the phenomenon. We reiterate that these non-thermal features are found in special states sprinkled #emph[throughout] the many-body spectrum --- #emph[i.e.], at all temperatures, including infinite temperature --- and these special states coexist with typical thermal states at the same energy densities. The nomenclature of scarring has variously been used in the literature to signify the presence of any one of the above features, or of all three at the same time. In this review, we discuss quantum many-body scars from a quasiparticle perspective, and draw comparisons and contrasts with other perspectives on scarring and related phenomena.


Two other recent reviews on quantum many-body scars provide complementary perspectives to this one. The first, Ref.~@SerbynReview:2021, highlights the connections to classical periodic orbits using semi-classics, while the second, Ref.~@MoudgalyaReview:2021, presents various exact results and matrix-product-state based understanding.


The remainder of this review is organized as follows. For pedagogical simplicity and clarity, we introduce quantum many-body scars in #ref(<sec:S1XY>) via a particularly simple model which exhibits the phenomena 1.--3.~in a physically transparent way. We then discuss quasiparticle-based many-body scarring more generally, focusing on a descriptive formalism in #ref(<sec:QPDescriptive>) and constructive principles for building models with scars in #ref(<sec:QPConstructive>) In #ref(<sec:Zoology>), we explore other perspectives on scarring with the same emphasis on descriptive and constructive approaches. Finally, in #ref(<sec:Experiments>), we describe experimental observations of quantum many-body scars in various systems. We especially focus on the original experimental observation of scarring in a Rydberg system presented in Ref.~@Bernien17, and highlight theoretical attempts to explain this experiment via studies of the so-called “PXP model” and its deformations; again, we focus on various manifestations of quasiparticles in these different accounts.


= Quantum Scars from Stable Quasiparticles
<quantum-scars-from-stable-quasiparticles>


== An Illustrative Solvable Example
<sec:S1XY>
In this section, we show how the three phenomena characteristic of quantum scarring emerge in a simple model, the spin-1 XY model. We focus on this model for pedagogical clarity, but note that the phenomenon of quasiparticles emerging at finite energy density in a nonintegrable model was first predicted in Refs.~@Moudgalya18a @Moudgalya18b for the Affleck-Kennedy-Lieb-Tasaki (AKLT) chain~@Affleck87.


We follow the approach in Ref.~@Schecter19, and discuss a one-dimensional version of the model to simplify the presentation. However, many of the properties hold on the $d$-dimensional hypercubic lattice or indeed any bipartite graph. The model is given by $ H & = J thin H_(upright("XY")) + h thin S^z\
 & = J sum_r \( S_r^x S_(r + 1)^x + S_r^y S_(r + 1)^y \) + h sum_r S_r^z \, $<eq:S1XY> where $r = 1 \, dots.h \, L$ labels lattice sites. The operators $S_r^alpha$ ($alpha = x \, y \, z$) are spin-1 operators, and we choose a local basis $\|plus.minus_r med$, $\|0_r med$ whose eigenvalues under $S_r^z$ are $plus.minus 1$ and $0$, respectively. The model in Eq.~#ref(<eq:S1XY>) is nonintegrable, even in one dimension, and therefore is expected to obey the ETH upon resolving all microscopic symmetries. This can be shown numerically by computing, #emph[e.g.], the statistics of spacings between neighboring energy levels~@Mehta04, see #ref(<fig:S1XY>)\(a). Nevertheless, the model supports a tower of exact many-body eigenstates with a simple structure and atypical properties relative to other eigenstates at the same energy density. These scarred eigenstates have an appealing interpretation in terms of many-particle states of “bimagnon” quasiparticles (#emph[i.e.], bound states of two magnons), whose scattering and decay are inhibited by a destructive interference effect that is absent for other quasiparticle types, #emph[e.g.]~single magnons.


// [figvision] imgs/S1XY_fig.png
// Panel (a) is a histogram plot showing the distribution of nearest-neighbor energy level spacings, denoted as
// P(s), versus the spacing s. The x-axis ranges from 0.0 to 5.0, while the y-axis spans 0.0 to 1.0. A gray bar
// chart represents the data, which closely follows a blue curve labeled Wigner-Dyson, peaking near s equals 1.0.
// A red curve labeled Poisson decays monotonically and does not fit the data. Text annotations indicate
// parameters J3 equals 0.1, system size L equals 16, magnetization m equals negative 10, and Hilbert space
// dimension 20608. The ratio r is listed as 0.528456, confirming nonintegrability. Panel (b) displays the
// low-energy spectrum of the spin-1 XY model as a density plot of energy levels E versus momentum k divided by
// pi. The vertical axis E ranges from negative 26 to negative 16, and the horizontal axis k/pi goes from 0.0 to
// 1.0. Dense blue lines form bands, interrupted by isolated states marked with symbols. Red circles denote Scar
// states, solid red dots represent Magnon states, and red crosses indicate Bimagnon states. These special states
// appear as distinct points separated from the bulk continuum, particularly visible at specific momenta like
// 0.0, 0.5, and 1.0, highlighting their unique nature within the spectrum. Panel (c) plots the entanglement
// entropy normalized by ln 2, SA/ln 2, against energy E. The x-axis extends from negative 10.0 to positive 10.0,
// and the y-axis from roughly 0 to 7.0. Blue dots form an inverted parabola shape typical of thermal states,
// reaching a maximum near zero energy. In contrast, red dots lie significantly lower, indicating low
// entanglement for specific scarred eigenstates. An inset graph shows SA versus system size L on logarithmic
// scales, fitting a line described by one-half ln(e pi L over 8). This confirms the area-law scaling of
// entanglement for the highlighted states compared to the volume law of the thermal background. Panel (d)
// illustrates time evolution dynamics, plotting the squared overlap modulus |L(t)|^2 against scaled time ht. The
// x-axis runs from 0 to 15, and the y-axis from 0.0 to 1.0. Three curves are shown: a blue line for Nematic
// Néel, a green line for Nematic ferro, and a red line for Sz product state. The blue curve exhibits perfect
// periodic revivals, returning to unity at regular intervals around ht equals 4, 8, and 12. The other two curves
// decay rapidly near t equals 0 and remain low, demonstrating that only the Nematic Néel state retains memory of
// its initial configuration over long times due to quantum scarring.
#figure(placement: top, image("imgs/S1XY_fig.png", width: 100%),
  caption: [
    Scars in the spin-1 XY model (panels (a), (c), and (d) adapted from Ref.~@Schecter19). (a) Distribution $P ( s )$ of nearest-neighbor energy level spacings $s$ for the model defined in Eq.~#ref(<eq:S1XY>) in the presence of third-neighbor hopping terms (Eq.~#ref(<eq:H3>)). The energy-level spacings follow a Wigner-Dyson distribution (blue curve), a strong indicator of nonintegrability. (b) Low-energy spectrum of the spin-1 XY model as a function of momentum $k$, with $L = 10$ and parameters chosen such that the polarized state $\|Omega med$ is the ground state. The scar states $\|cal(S)_n med$ for $n = 0 , 1 , 2$ are marked with empty red circles, while the single-magnon states described in #ref(<sec:NonSpecial>) are marked with filled red circles. Red crosses denote the energy expectation values of single-bimagnon states for different values of $k$\; only the one with $k = pi$ is an exact eigenstate. (c) Half-chain entanglement entropy $S_A$ as a function of energy in the zero-magnetization sector for a chain with $L = 10$ sites. The scar state in the zero magnetization sector is circled in red, and the inset demonstrates that the entanglement entropy of this state scales logarithmically with $L$. The entanglement entropies of the scar states in other magnetization sectors are denoted by red points. The dashed line denotes the value of the entanglement entropy for a random state, which obeys volume-law scaling (see Ref.~@Page93). (d) Dynamics of the Loschmidt echo, Eq.~#ref(<eq:S1XYLt>), for the initial state Eq.~#ref(<eq:S1XYinit>) (blue), with the dynamics for two other initial product states (green, red) shown for comparison.
  ]
)
<fig:S1XY>


=== Exact (Non-Scarred) Eigenstates Dictated by Symmetry
<sec:NonSpecial>
The model in Eq.~#ref(<eq:S1XY>) has two bands of exact single-magnon states in its spectrum due to a symmetry. To see this, note that the polarized states $\|Omega med = ⊗_(r = 1)^L \|-_r med$ and $\|Omega' med = ⊗_(r = 1)^L \|+_r med$ are annihilated by $H_"XY"$. Single-magnon states can be built atop these polarized states using the spin raising and lowering operators $S_r^plus.minus = S_r^x plus.minus i thin S_r^y$: $ \|+ \, k med & = 1 / sqrt(2 L) sum_(r = 1)^L e^(i k r) S_r^(+) \|Omega med\
\|- \, k med & = 1 / sqrt(2 L) sum_(r = 1)^L e^(i k r) S_r^(-) \|Omega' med \, $<eq:S1XYSingleMagnon> where $k = frac(2 pi, L) p$ ($p = 0 \, dots.h \, L - 1$). These single-magnon states have energies $E_(plus.minus \, k) = minus.plus h \( L - 1 \) + 2 J thin cos k$. Their existence is guaranteed by the U(1) symmetry $\[ H \, S^z \] = 0$, and by translation invariance. Indeed, the polarized states $\|Omega med$ and $\|Omega' med$ must be eigenstates of $H$ since they are the unique states with $S^z = plus.minus L$.


There are $2 L$ spin configurations with $S^z = plus.minus ( L - 1 )$\; translation invariance organizes these states into the single-magnon plane waves of Eqs.~#ref(<eq:S1XYSingleMagnon>) #ref(<fig:S1XY>)\(b) plots the low-energy spectrum of Eq.~#ref(<eq:S1XY>) with an added third-neighbor exchange term (see Eq.~#ref(<eq:H3>)) as a function of quasi-momentum $k$, with parameters chosen such that the fully polarized state $\|Omega med$ is the ground state. The exact single-magnon eigenstates $\|k , Omega med$ with $k = 0 , dots.h , pi$ are represented with filled red circles.


Symmetry alone is not sufficient to guarantee the existence of eigenstates with more than one magnon. Indeed, one readily finds that inserting additional magnons via multiple application of the operators $S_k^plus.minus = sum_r e^(i k r) S_r^plus.minus$ does not yield exact eigenstates. (This can be seen, #emph[e.g.], by calculating the energy variance of these multimagnon states.) Physically, this arises because multi-magnon states are unstable to interaction effects (#emph[i.e.], scattering processes) that open up various decay channels. Thus, other effects must conspire to stabilize eigenstates with additional quasiparticles.


=== Bimagnon Tower of Scar States
<bimagnon-tower-of-scar-states>


We now show that Eq.~#ref(<eq:S1XY>) admits a tower of exact #emph[bimagnon] states, $ \|cal(S)_n med = cal(N) ( n ) ( J^(+) )^n \|Omega med , $<eq:S1XYTower> where $n = 0 , dots.h , L$, $cal(N) ( n ) = sqrt(frac(( L - n ) !, n ! L !))$ ensures normalization, and where $ J^plus.minus = 1 / 2 sum_(r = 1)^L e^(i pi r) ( S_r^plus.minus )^2 . $<eq:Jpmdef> The operator $J^(+)$ inserts a bimagnon with momentum $pi$ into the vacuum $\|Omega med$. The lowest-lying bimagnon state $\|cal(S)_1 med$ is marked with an empty red circle at $k = pi$ in #ref(<fig:S1XY>)\(b), as are the polarized state $\|cal(S)_0 med = \|Omega med$ and the state $\|cal(S)_2 med$. Single-bimagnon states at other momenta can also be constructed, and their energy expectation values are marked with red crosses in the same figure. However, these single-bimagnon states are not generically eigenstates for $k eq.not pi$.


The infinite lifetime of bimagnon excitations at momentum $pi$ can be understood relatively simply. Consider the one-bimagnon state, which we rewrite as $ \|cal(S)_1 med prop sum_(r = 1)^L ( - 1 )^r \|dots.h - +_r - dots.h med , $<eq:S_1> where we suppress the site indices away from site $r$ for compactness. Observe that the local XY exchange term $h_(r , r + 1)^"XY" = S_r^x S_(r + 1)^x + S_r^y S_(r + 1)^y$ acts as $ h_(r \, r + 1)^(upright("XY")) \|- - med & = h_(r \, r + 1)^(upright("XY")) \|+ + med = 0 \,\
h_(r \, r + 1)^(upright("XY")) \|+ - med & = h_(r \, r + 1)^(upright("XY")) \|- + med = \|00 med . $ <eq:hXYaction> The second line indicates that the XY exchange term dissociates the bimagnon excitation into two magnons. From Eq.~#ref(<eq:hXYaction>), we deduce that $h_(r \, r + 1)^(upright("XY"))$ annihilates $\|cal(S)_1 med$ for all $r$: $ h_(r \, r + 1)^(upright("XY")) \|cal(S)_1 med & prop h_(r \, r + 1)^(upright("XY")) \|dots.h +_r - dots.h med - h_(r \, r + 1)^(upright("XY")) \|dots.h - +_(r + 1) dots.h med = 0 . $<eq:interference> This annihilation results from the destructive interference of the bimagnon dissociation processes $\|+ - med arrow.r \|00 med$ and $\|- + med arrow.r \|00 med$, which arises due to the alternating sign $e^(i pi r) = \( - 1 \)^r$in Eq.~#ref(<eq:S_1>) In fact, the above calculation can be applied to show that$h_(r \, r + 1)^(upright("XY")) \|cal(S)_n med = 0$ for all $n$. Every spin configuration $\|L med ⊗ \|+ - med ⊗ \|R med$ in $\|cal(S)_n med$ has a partner configuration $\|L med ⊗ \|- + med ⊗ \|R med$ appearing with the opposite sign due to the fact that all of the bimagnons have momentum $pi$. We therefore conclude that $H_(upright("XY")) \|cal(S)_n med = 0$, so that $\|cal(S)_n med$ are eigenstates of Eq.~#ref(<eq:S1XY>) with energy $E_n = h \( 2 n - L \)$ set by the magnetic field.


An important feature of the states $\|cal(S)_n med$ is that they form a spin-$L / 2$ representation of an SU(2) algebra generated by the raising and lowering operators $J^plus.minus$: $
  [ J^(+) , J^(-) ] = 2 J^z , quad [ J^z , J^plus.minus ] = plus.minus J^plus.minus ,
$ <eq:S1XYSU2Alg> where $J^z = 1 / 2 sum_(r = 1)^L S_r^z = 1 / 2 S^z$. Note that the states $\|cal(S)_n med$ are eigenstates of $J^z$, which is proportional to the magnetization operator $S^z$ that couples to the magnetic field. Using the definition Eq.~#ref(<eq:S1XYTower>) of the scar states, one can show that $ [1 / 2 ( J^(+) J^(-) + "H.c." ) + ( J^z )^2] \|cal(S)_n med = j ( j + 1 ) \|cal(S)_n med quad "and" quad J^plus.minus \|cal(S)_n med = sqrt(j ( j + 1 ) - m ( m plus.minus 1 )) \|cal(S)_(n plus.minus 1) med , $<eq:S1XYSU2Rep> where $j = L / 2$ and $m = n - L / 2$. Eqs.~#ref(<eq:S1XYSU2Rep>) enable simple calculations of the expectation values of certain operators.


As might be anticipated from their simple structure (see Eq.~#ref(<eq:S1XYTower>)) and physical interpretation, the eigenstates $\|cal(S)_n med$ exhibit properties that are atypical of eigenstates nearby in energy. In particular, we should compare an eigenstate $\|cal(S)_n med$ with $n / L$ finite as $L arrow.r oo$ to expectations based on the ETH, which governs typical eigenstates at the same energy density. One property that clearly demonstrates that the ETH does not hold in these eigenstates is the presence of off-diagonal long-range order~@Yang62, as witnessed by the correlation function $
  4 / L^2 ⟨ cal(S)_n | J^(-) J^(+) | cal(S)_n ⟩ = [1 - frac(( 2 n - L )^2, L^2)] + O (1 / L) .
$ <eq:Jplusminus> This result is obtained by direct application of Eqs.~#ref(<eq:S1XYSU2Rep>) Notice that, unless $n = 0$ or $L$, the right-hand side of the above equation is finite in the thermodynamic limit. This means that the scarred eigenstates $\|cal(S)_n med$ contain long-range #emph[connected] correlations (note that $⟨ cal(S)_n | J^(plus.minus) | cal(S)_n ⟩ = 0$). In contrast, for a generic eigenstate in the middle of the energy spectrum, the expected value of this correlation function based on ETH is given by the infinite-temperature average $ 1 / 3^L "tr" (4 / L^2 J^(-) J^(+)) = frac(4, 3 L) , $ which vanishes as $L arrow.r oo$. Another atypical feature of the eigenstates $\|cal(S)_n med$ is their entanglement entropy, which can be evaluated analytically using simple combinatorics (see Ref.~@Schecter19). The scaling with $L$ of the entanglement entropy of the state $\|S_(L / 2) med$ as $L arrow.r oo$ can be shown explicitly via saddle point arguments to be $ lim_(L arrow.r oo) S_A = 1 / 2 (ln frac(pi L, 8) + 1) , $ where $S_A = - "tr" ( rho_A ln rho_A )$, where $rho_A = "tr"_B |cal(S)_(L \/ 2)⟩ ⟨cal(S)_(L \/ 2)|$ and $"tr"_B$ denotes the trace over sites $1 , dots.h , L / 2$. In contrast, the ETH predicts that finite-energy-density eigenstates of nonintegrable models like Eq.~#ref(<eq:S1XY>) obey the volume-law scaling $S_A tilde L$. Numerical results emphasizing the weakly-entangled nature of the scar states are shown in #ref(<fig:S1XY>)\(c).


Further evidence of the atypical nature of these eigenstates can be revealed by considering the dynamics from certain special initial states. In the presence of a finite magnetic field $h$, any state of the form $ \|psi_0 med = sum_(n = 0)^L c_n \|cal(S)_n med . $ <eq:Initialstate> experiences periodic revivals due to the equally spaced eigenenergies $E_n$. This is easiest to see in the so-called Loschmidt echo,
$ cal(L) ( t ) = ⟨ psi_0 | e^(-i H t) | psi_0 ⟩ = e^(i thin h L t) sum_(n = 0)^L |c_n|^2 e^(-i thin n (2 h) t) . $ <eq:S1XYLt> Up to an unimportant global phase, $cal(L) ( t )$ is a periodic function with period $pi / h$. Numerical data exhibiting these periodic revivals are shown in #ref(<fig:S1XY>)\(d). This time-periodic behavior of the Loschmidt echo should be contrasted with the expectation for quantum chaotic systems, where a rapid decay is expected for typical initial states @Gorin06 @Goussev16. Remarkably, the family of initial states in Eq.~#ref(<eq:Initialstate>) includes product states that are readily accessible experimentally. Perhaps the simplest of these is given by $ \|phi.alt_0 med & = ⊗_r [\|+_r med - ( - 1 )^r \|-_r med / sqrt(2)] , $<eq:S1XYinit> which is of the form Eq.~#ref(<eq:Initialstate>) with $c_n = ( - 1 )^n sqrt(binom(L, n) 1 / 2^L)$. Physically, the state $\|phi.alt_0 med$ corresponds to the ground state of the Hamiltonian $ H_0 & = 1 / 2 \( J^(+) + J^(-) \)\
 & = 1 / 2 sum_(r = 1)^L \( - 1 \)^r [\( S_r^x \)^2 - \( S_r^y \)^2] $ formed from the quasiparticle creation and annihilation operators. $H_0$ is nothing but the generator $J^x$ of the SU(2) algebra Eq.~#ref(<eq:S1XYSU2Alg>) As such, the periodic dynamics observed in Eq.~#ref(<eq:S1XYLt>) can be interpreted as resulting from the precession of a macroscopic spin-$L \/ 2$ object under the magnetic field term in Eq.~#ref(<eq:S1XY>), which is proportional to $J^z$. This interpretation was put forward as an approximate description of the periodic dynamics in the PXP model in Ref.~@Choi19 (see #ref(<sec:Experiments>)), but holds exactly in the case of the spin-1 XY model.


We conclude this section with a few comments regarding the model in Eq.~#ref(<eq:S1XY>) First, we note that, in one dimension, the spin-1 XY model possesses a hidden nonlocal SU(2) symmetry when defined with open boundary conditions, and a “twisted” version thereof when defined with periodic boundary conditions ~@Kitazawa03 @Chattopadhyay20. Thus, confirming the nonintegrability of this model in one dimension requires resolving this additional unexpected symmetry. However, this symmetry is not essential to the presence of the scars in this model. For example, as noted in @Schecter19, adding a third-neighbor XY exchange term of the form $ H_3 = J_3 sum_r ( S_r^x S_(r + 3)^x + S_r^y S_(r + 3)^y ) $<eq:H3> breaks the hidden SU(2) symmetry while preserving the scar states. Indeed, one readily verifies that the destructive interference effect demonstrated in Eq.~#ref(<eq:interference>) holds also for $H_3$, the key commonality being that sites $r$ and $r + 3$ belong to opposite sublattices, as do sites $r$ and $r + 1$. In fact, this reasoning can be extended to show that any odd-neighbor XY exchange term preserves the scar tower. A variety of other terms can also be added to Eq.~#ref(<eq:S1XY>) while preserving the tower of scar states. For example, in @Schecter19 it was noted that the single-site anisotropy term $sum_r ( S_r^z )^2$ preserves the tower, since the states $\|cal(S)_n med$ are superpositions of tensor products of the local states $\|plus.minus_r med$, which satisfy $( S_r^z )^2 \|plus.minus_r med = \|plus.minus_r med$. Ref.~@Mark20 presented a systematic enumeration of all nearest-neighbor terms that preserve the eigenstates $\|S_n med$.


== Algebraic Descriptions
<sec:QPDescriptive>
At a more abstract level, models with stable quasiparticles atop specific vacuum states have simple algebraic descriptions.


There are three equivalent algebraic descriptions in the literature: spectrum generating algebras (SGAs)~@Mark20a @Moudgalya20, quasi-symmetry groups~@Ren21 @Ren22, and group-invariant sectors~@Pakrouski20 @Pakrouski21. All three describe the scarred subspace using higher symmetries than those of the Hamiltonian itself, but provide different constructive principles for the Hamiltonian and for the action of the symmetry on the scarred subspace (see #ref(<sec:QPConstructive>)). The scar towers in the spin-1 XY chain discussed above, generalized Hubbard models with $eta$-pairing states~@Yang89 @Vafek17 @Mark20 @Moudgalya20, the AKLT spin-1 chain~@Moudgalya18a, transverse field Ising ladders~@Voorden:2020wo, a domain wall conserving spin-1/2 model~@Iadecola20, models with multiple magnons~@Tang21 @Mark20a, and various chiral and non-chiral fermionic models~@Martin:2022uj @Pakrouski20 @Schindler:2022 can be understood using at least one of the three descriptions. As the SGA is most closely connected to the quasiparticle perspective, we describe it below.


A quasiparticle creation operator $Q^(+)$ provides an SGA if its commutator with the Hamiltonian $H_"SG"$ satisfies: $ \[ H_"SG" , Q^(+) \] & = omega Q^(+) $<Eq:SGAAll> for $omega eq.not 0$~#footnote[Eq.~#ref(<Eq:SGAAll>) has also been referred to in the literature as a dynamical symmetry~@Buca19 @Buca20 @Buca22]. If $\|psi_0 med$ is an eigenstate of $H_"SG"$ with eigenvalue $E_0$, then $( Q^(+) )^n \|psi_0 med$ is also an eigenstate with eigenvalue $E_0 + n omega$ for any integer $n > 0$ (as long as $( Q^(+) )^n \|psi_0 med eq.not 0$). The SGA thus provides multiple towers of equally spaced eigenstates.


Often however, Eq.~#ref(<Eq:SGAAll>) asks for too much and results in special towers of states for symmetry reasons. For example, consider the SU(2) algebra defined in Eq.~#ref(<eq:S1XYSU2Alg>) that arises in the description of the scar tower in the spin-1 XY model. Suppose that we define a Hamiltonian of the form $H_"SG" = H_"sym" + omega J^z$, where $H_"sym"$ is $J$-SU(2) symmetric, i.e., it commutes with all of the generators in Eq.~#ref(<eq:S1XYSU2Alg>) (An example of such an $H_"sym"$ was found in Ref.~@Mark20a\; see Eq.~#ref(<eq:S1XYHsym>) below.) The $J$-SU(2) raising operator $J^(+)$ then defines an SGA as in Eq.~#ref(<Eq:SGAAll>), with $Q^(+) = J^(+)$. In this scenario, the tower $\|cal(S)_n med$ in Eq.~#ref(<eq:S1XYTower>) is #emph[not] quantum many-body scarred, as each $\|cal(S)_n med$ has maximal $J^2$ eigenvalue and is the only state in its symmetry sector. It is precisely because the Hamiltonian of the spin-1 XY Hamiltonian $H_"XY"$ in Eq.~#ref(<eq:S1XY>) is not $J$-SU(2) symmetric that the tower of states $\|cal(S)_n med$ qualify as bona fide many-body scar states.


It is therefore useful to define the notion of a #emph[restricted] SGA, which only requires that Eq.~#ref(<Eq:SGAAll>) holds within the scarred subspace. That is, for a given vacuum state $\|psi_0 med$, if, $ H \|psi_0 med & = E_0 \|psi_0 med \,\
\[ H \, Q^(+) \] \|psi_n med & = omega Q^(+) \|psi_n med med forall med n med "s.t." med \( Q^(+) \)^n \|psi_0 med eq.not 0 $<Eq:SGADefine> then the states with $n$ quasiparticles atop the vacuum state, $\|psi_n med = \( Q^(+) \)^n \|psi_0 med$, are exact eigenstates of a Hamiltonian $H$ with energies $E_0 + n omega$. In practice, additional terms are added to SGA Hamiltonians to deform them into Hamiltonians that only satisfy Eq.~#ref(<Eq:SGADefine>) Eq.~#ref(<eq:S1XY>) represents one such deformation for the spin-1 case.


It is often the case that the stationarity of few quasi-particle states, $\|psi_m med$ for $m lt.eq M$, guarantees the stationarity of states with any number of quasiparticles atop the vacuum state, $\|psi_n med$. For example, in the spin-1 XY chain, $M = 1$, while in the AKLT chain, $M = 2$~@Moudgalya18a A rewriting of the condition in Eq.~#ref(<Eq:SGADefine>) in terms of nested commutators then becomes useful~@Moudgalya20 $ H \|psi_0 med & = E_0 \|psi_0 med\
upright("ad")_(Q^(+)) \( H \) \|psi_0 med & = - omega Q^(+) \|psi_0 med\
upright("ad")_(Q^(+))^m \( H \) \|psi_0 med & = 0 \, thin 2 lt.eq m lt.eq M\
upright("ad")_(Q^(+))^m \( H \) & = 0 \, thin thin forall med m > M . $<Eq:nestedcommRSGA> Above $upright("ad")_X \( Y \) = \[ X \, Y \]$. Solving the operator equation for $m > M$ is much simpler than solving the restricted equation for $2 lt.eq m lt.eq M$, and provides valuable clues about the scarred states and/or the Hamiltonian $H$. For example, Ref.~@Tang21 constructed operator bases that satisfied Eq.~#ref(<Eq:nestedcommRSGA>) for a given $Q^(+)$ and $M$, while Ref.~@Moudgalya18a identified bimagnons as candidate stable quasiparticles for AKLT spin-1 chains by solving Eq.~#ref(<Eq:nestedcommRSGA>) for $M = 2$.


== Constructive Principles
<sec:QPConstructive>
There are several constructive principles that provide restricted SGAs, and thus scarred Hamiltonians with certain species of stable quasiparticles. We focus here on a principle that leverages non-Abelian symmetries, and also discuss another mechanism based on particle confinement.


Non-Abelian symmetries $G$ furnish raising and lowering operators $Q^plus.minus$ that naturally satisfy an SGA with (Cartan) generators $Q^z$ in any subspace. When coupled with $G$-symmetric Hamiltonians and symmetric base states, we can construct large families of Hamiltonians with quasiparticle scar states~@ODea20: $ H = H_"sym" + H_"SG" + H_A . $<eq:Hsymmetryformalism> We now describe each of these terms.


The first term $H_"sym"$ is $G$-symmetric, that is, $\[ H_"sym" , Q^plus.minus \] = 0$ and $\[ H_"sym" , Q^z \] = 0$. (Note that, in general, $H_"sym" = 0$ is also allowed.) Suppose the base state is an eigenstate of $H_"sym"$. Then, $\|psi_0 med$ is labelled by its eigenvalue under the Casimir operator $Q^2$ and the Cartan generator $Q^z$. Furthermore, $\|psi_n med$ is a degenerate eigenstate with the same value of $Q^2$ but a different value of $Q^z$. To guarantee that the base state is an eigenstate of $H_"sym"$, it is often chosen to be an element of a unique irreducible representation (irrep) of the group $G$. For example, in the spin-1 XY model, the scarred states span the unique maximum-spin representation of the SU(2) algebra in Eq.~#ref(<eq:S1XYSU2Alg>), to which the polarized state $\|Omega med$ belongs. The $J$-SU(2) symmetric part of the spin-1 XY exchange Hamiltonian $H_"XY"$ was found in Ref.~@Mark20 to be given by
$ H_"sym" = sum_r ( |+_r 0_(r+1)⟩ ⟨0_r +_(r+1)| - |-_r 0_(r+1)⟩ ⟨0_r -_(r+1)| + "H.c." ) . $ <eq:S1XYHsym>


The second term, $H_"SG"$, is a (linear combination of) generator(s) in the Cartan sub-algebra of $G$ so that $\[ H_"SG" , Q^plus.minus \] = plus.minus omega Q^plus.minus$. This term lifts the degenerate multiplets of $H_"sym"$ into energetically equidistant towers of states. In the spin-1 XY model, $H_"SG" = h S^z = 2 h J^z$ so that $omega = 2 h$.


The final term in Eq.~#ref(<eq:Hsymmetryformalism>) breaks the $G$-symmetry, but annihilates the scar states: $H_A \|psi_n med = 0$. In the spin-1 XY model Eq.~#ref(<eq:S1XY>), it is given by $H_A = J ( H_"XY" - H_"sym" )$, where $H_"sym"$ is given in Eq.~#ref(<eq:S1XYHsym>) Explicitly~@Mark20a,
$ H_A = J sum_r [ ( |+_r -_(r+1)⟩ + |-_r +_(r+1)⟩ ) ⟨0_r 0_(r+1)| + 2 |-_r 0_(r+1)⟩ ⟨0_r -_(r+1)| + "H.c." ] . $ <eq:HA>


The symmetry-based formalism is powerful because of its generality. First, $G$ can be any continuous non-Abelian symmetry group, or a $q$-deformed version thereof~@ODea20@Ren21 Indeed, there are examples of scarred models in the literature in which $G$ is SU(3)~@ODea20, $q$-deformed SU(2)~@ODea20, U($N$) or SO($N$) where $N$ is the number of lattice sites~@Pakrouski20, etc. Next, even when $G$ is SU(2), it need not be the spin-SU(2). Prominent examples include the Hirsch model with $eta$-pairing states as scarred states~@Mark20 and generalized AKLT models~@Moudgalya20b Third, the scar tower need not be an irrep of $G$ with maximal eigenvalue under the Casimir operators. In the SU(2) case, for example, the base state could be a single-magnon state with zero quasi-momentum and $S = L / 2 - 1$@Tang21 Indeed, the scar tower need not be an irrep of $G$ at all if $H_"sym"$ is special and multiple irreps are degenerate. The scarred bimagnon tower in the AKLT model provides such an example@Mark20a Fourth, the same symmetry group $G$ can provide multiple raising operators $J^(+)$ to embed scar pyramids~@Tang21 @Mark20a. For example, with $G =$~SU(2), single magnon excitations with multiple momenta ($k = 0$ and $k = k_0$ for any $k_0$) can be infinitely long-lived excitations atop the fully polarized state.


There are a few examples of scarred models that do not obviously fit into the symmetry-based formalism. For instance, in the domain-wall conserving model of Ref.~@Iadecola20 the quasiparticle creation operator $Q^(+)$ does not a have a clear connection to a root of a Lie algebra. Another example, surprisingly, arises in the spin-1 XY model, which hosts a second tower of so-called “bond-bimagnon” states~@Schecter19 @Chattopadhyay20. The quasiparticle creation operator for this tower of states is so far not known. However, in both of these examples, the towers of states arise from the projection of an auxiliary tower of states that #emph[do] transform as a representation of a Lie algebra~@Iadecola20 @Chattopadhyay20 @Ren22.


An interesting application of the symmetry-based formalism is to deformations of integrable points. Integrable points have extensively many continuous symmetries, and thus provide extensively many creation operators $Q^(+)$ of distinct quasiparticles. A suitable deformation $H_A$ could preserve one or several of these quasiparticles as infinitely long-lived excitations. The deformation of integrable points thus provides a systematic way to construct large families of quantum scarred models. An early study of a deformed PXP model suggested that this model is proximate to integrability~@Khemani19, which might explain the origin of scarring in it (see #ref(<sec:Experiments>) for further discussion). Integrability also played an important role in scars that were experimentally obtained in a 1D dysprosium quantum gas~@Wil:2021vr Theoretically, the connection between scars and integrability has been studied in Refs.~@Moudgalya20b @Shibata:2020 @Medenjak:2020@ODea20@Martin:2022uj @Zhang22b, but this is still largely unexplored territory.


How to construct the all-important $H_A$ that breaks the global symmetry? There are several methods discussed in the literature.


One method is to use local projectors that annihilate local patterns that appear in the scarred tower. Such projectors can be constructed using the symmetry $G$ itself. For example, Refs.~@Ren21 @Ren22 construct the subspace generated by the action of $G$ on the base state restricted to a small number of sites; the complement of this subspace provides the required local projector. The result is a frustration-free Hamiltonian, discussed further in #ref(<Sec:SMEmbed>).


Another method is to choose the group $G$ so that the scarred subspace is a singlet of the group~@Pakrouski20 @Pakrouski21. In this case, any $H_A = sum_a O_a T_a$, where $T_a$ are the generators and $O_a$ are any operators that make $H_A$ Hermitian, annihilate the scarred subspace. Note that, in this case, $H_"sym"$ need not be $G$-symmetric---it need only have the $G$-singlets as eigenstates, see Refs.~@Pakrouski20 @Pakrouski21 for more details.


Brute force computation in an operator basis is also useful. That is, we search for coefficients $c_a$ of a set of translationally invariant operators $O^a = sum_i O_i^a$ such that $H_A = sum_a c_a O^a$ annihilates all the states in the scarred manifold. When the SGA is furnished by a symmetry, choosing the operators $O^a$ to be irreducible tensor representations sets several $c_a$ to zero on symmetry grounds@Tang21. The remaining $c_a$ satisfy simple linear relations, which can be solved analytically or numerically~@Tang21 @Qi2019determininglocal@ODea20. The resulting $H_A$ generically does not annihilate the scarred states term-by-term. Such Hamiltonians are thus referred to as “as-a-sum” annihilators.


Other methods use the language of matrix product states and operators to construct nearest neighbor Hamiltonians with a quasiparticle tower of scars~@Moudgalya20b @Ren22. The starting point is to write the states with $n$ quasiparticles, $\|psi_n med = ( Q^(+) )^n \|psi_0 med$, as matrix product states using two types of matrices for each site depending on whether there is or is not a quasiparticle on that site. Enforcing that the quasiparticles cannot sit on neighboring sites results in simple algebraic conditions on parent Hamiltonians with the scarred tower $\|psi_n med$. This method was used to discover several AKLT-type models with bimagnon scars atop a spin liquid ground state~@Moudgalya20b @Mark20a, perturbed Potts models with tri-magnon scars~@Moudgalya20b, and a two-dimensional model with topologically ordered states within the scarred subspace~@Ren22.


As an aside, we note that none of the constructions described above guarantee that $H_A$ exclusively annihilates the scarred subspace. Indeed, determining the number of states annihilated by a local Hamiltonian is in general intractable, although interesting lower bounds exist@Sattath:2016.


Refs.~@James:2019 @Robinson:2019 suggest that particle confinement leads to quantum many-body scars at varying energy densities. Specifically, Refs.~@James:2019 @Robinson:2019 study the ordered phase of the Ising model in transverse and longitudinal fields in one dimension. The longitudinal field leads to confinement of domain walls, so that a pair of domain walls forms a bound state (a meson) whose energy grows with their separation. These single meson states persist as eigenstates well above the two-meson threshold; they apparently persist even when the two domain walls are macroscopically separated and the state has a finite energy density above the ground state. Whether the persistence is only a finite-size effect in the lattice model, and whether other continuum models that are in confined phases exhibit scars, are open questions.


= Generalized Scars Beyond Quasiparticles
<sec:Zoology>


In this section, we broaden our scope beyond quasiparticles and return to the connection of scars with the failure of thermalization mentioned in the introduction. The purpose of this section is, in part, to chart out the historical genesis of scars, and also to provide an overview of the richness of phenomena that have been associated with term scar, but which at times refer to some rather distinct types of underlying physics.


== Scars from Projector Embeddings
<Sec:SMEmbed>
Perhaps the earliest mention of the existence of a special eigenstate of a Hamiltonian that passes robustly, with perfectly unavoided crossings, through other states as parameters of the Hamiltonian are varied was provided by Shastry and Sutherland@Shastry:1981. In their eponymous spin model, an exactly dimerized state remains an eigenstate even when it ceases to be the ground state of the model. This kind of scar state does not come with a tower of states at all---it is #emph[a priori] just an individual very special state which happens to escape eigenstate thermalization.


The Shastry-Sutherland model is an example of an important class of Hamiltonians known as frustration-free Hamiltonians. Such Hamiltonians can be written (up to a constant energy shift) as a sum of local projection operators $P_i$, $ H_"FF" = sum_i h_i P_i , $<eq:HFF> with real coefficients $h_i gt.eq 0$. The ground state(s) of frustration-free Hamiltonians are states $\|psi_"FF" med$ that satisfy $P_i \|psi_"FF" med = 0$ for all $i$. Note that two projectors $P_i$ and $P_j$ in the Hamiltonian Eq.~#ref(<eq:HFF>) need not commute with each other, so that $H_"FF"$ may be nonintegrable. In addition to the Shastry-Sutherland model, well-known examples include the AKLT and Klein models~@Affleck87 @Chayes_1989, the Rokhsar-Kivelson model~@Rokhsar88 and its generalizations~@Castelnovo05, the toric code~@Kitaev:2003vn, and other parent~@Fannes92 @Nachtergaele96 @PerezGarcia07 and uncle~@Fernandez15 Hamiltonians for matrix product states.


It is always possible to modify a frustration-free Hamiltonian such that a ground state of the original model becomes an arbitrarily highly excited state of the modified model. For example, in Eq.~#ref(<eq:HFF>), one can modify the coefficients $h_i$ to have both positive and negative signs, in addition to varying magnitudes, or even promoting $h_i$ to arbitrary local operators. The erstwhile ground states $\|psi_"FF" med$ then remain zero-energy states of the modified Hamiltonian.


The connection of these ideas to the ETH was first drawn by Shiraishi and Mori (SM) in Refs.~@Shiraishi17 @Mori17a. The SM construction again relies on the existence of an extensive set of local projectors ${ P_i }$, and a target scarred subspace $cal(T)$ spanned by states annihilated by the local projectors: $P_i \| psi chevron.r = 0 #h(0em) forall #h(0em) i$. The SM Hamiltonian is a sum of two terms: the first is a (modified) frustration-free Hamiltonian $H_A$ that annihilates any state in the target subspace $cal(T)$, and the second term $H'$ commutes with all the projectors $P_i$ ($\[ H' , P_i \] = 0$): $ H_"SM" = underbrace(sum_i P_i h_i P_i, H_A) + H' , $ where $h_i$ are arbitrary local Hamiltonians. The Hamiltonian is constructed to be block-diagonal since $H'$ does not mix states in $cal(T)$ with those in its complement $overline(cal(T))$. Thus, $H_"SM"$ can be diagonalized in $cal(T)$ and $overline(cal(T))$ independently. The energy eigenvalues of the eigenstates ${ \|psi med_t }$ in $cal(T)$ are set entirely by $H'$. These could be interleaved anywhere within the spectrum of $H_"SM"$, including at an energy density corresponding to infinite temperature. The other states at the same energy density in $overline(cal(T))$ are however expected to reproduce thermal expectation values, as $H_A$ (and thus $H_"SM"$) should be non-integrable for generic Hermitian $h_i$. For example, the expectation value of the local projector $P_i$ in any of these states should be proportional to $"tr" ( P_i )$. The same expectation value in a scarred eigenstate is exactly zero, at odds with the ETH.


It is useful to briefly discuss the embedded states in relation to possible symmetries of $H_"SM"$. The ETH holds only within individual symmetry sectors. SM presented their embedded states as counterexamples to the ETH because $H_"SM"$ generically does not have any obvious local symmetries, and so the embedded target states need not live in a separate symmetry sector from the rest of spectrum. Crucially, the $P_i$'s do not generically form a mutually commuting set and hence are not a set of local symmetries for the Hamiltonian~#footnote[However, when the projectors do commute, the disconnected sectors can be interpreted as being distinguished by symmetry@Mondaini18].


An alternative perspective is to think of $cal(T)$ and $overline(cal(T))$ as #emph[dynamically] disconnected subspaces which do not couple to each other under the action of $H_"SM"$. In other words, $H_"SM"$ can decomposed as $ H_"SM" = H_(cal(T))^"scar" xor H_(overline(cal(T)))^"thermal" . $


Several examples of embedded towers of states with quasiparticles lie within the SM construction. Remarkably, the spin-1 XY bimagnon scar tower also falls into this class, although the model was not explicitly constructed using the SM formalism. The projection operators associated with the embedding are given by $ P_r = 1 & - 3 / 4 ( S_r^z )^2 ( S_(r + 1)^z )^2 + 1 / 8 [( S_r^(+) )^2 ( S_(r + 1)^(-) )^2 + "H.c."] - 1 / 4 S_r^z S_(r + 1)^z . $ We refer the reader to Appendix C of Ref.~@Schecter19 for a more detailed discussion. The SM method has also been used to embed a macroscopic SU(2) spin~@Choi19, multiple towers of magnon states~@Tang21 and magnon crystals~@McClarty:2020 @Kuno:2020, as well as states with no quasiparticle interpretation, #emph[e.g.] zero modes in gauge theories~@Banerjee21 @Biswas22, topologically ordered states~@Ok:2019 @Srivatsa20b @Wildeboer21 and states in geometrically frustrated systems~@Lee:2020 @McClarty:2020.


== Hilbert Space Fragmentation
<hilbert-space-fragmentation>


// [figvision] imgs/frag_fig.png
// Panel (a) is a schematic diagram illustrating the block structure of an evolution operator within large black
// parentheses. The interior shows a matrix decomposed into diagonal blocks. Large magenta squares represent
// different symmetry sectors, while smaller yellow squares along the main diagonal denote disconnected Krylov
// subspaces. Ellipses in the top-left and bottom-right corners indicate that this block-diagonal pattern
// continues for larger system sizes. Panel (b) depicts a one-dimensional chain of spin-1 sites represented by
// plus and minus signs. A red dashed rectangle encloses the entire sequence to highlight a specific
// configuration. Within this chain, certain groups of adjacent spins are shaded with light blue rounded
// rectangles, identifying them as frozen states or immobile domains. Below the central region, a horizontal
// double-headed arrow labeled with the symbol ell spans four sites, denoting a characteristic length scale.
// Panel (c) illustrates a dynamic transition between two spin configurations separated by a vertical
// double-headed arrow. The top row displays a sequence of plus signs interrupted by red zeros. The bottom row
// shows a similar sequence where the corresponding positions contain red plus and minus signs instead. Black
// dots at both ends of each row signify that the chains extend infinitely in both directions.
#figure(placement: top, image("imgs/frag_fig.png", width: 100%),
  caption: [
    A mechanism for Hilbert space fragmentation (panel (b) adapted from Ref.~@Khemani20). (a) Schematic of the block structure of the evolution operator in a system with Hilbert-space fragmentation. The pink blocks denote different symmetry sectors, while the yellow blocks denote disconnected Krylov subspaces. (b) Example of a frozen state in a one-dimensional spin-1 chain with U(1) charge and dipole-moment conservation acted upon by local gates with range at most $ell = 3$. Any gate acting on three consecutive sites (#emph[e.g.], the shaded blue regions) cannot change the state because the local configuration either has extremal charge (as in the leftmost block) or dipole moment (as in the middle and rightmost blocks). (c) Example of a two-dimensional Krylov subspace generated by an active region (red) embedded in a frozen background (blue). The transition indicated by the black arrow is the only one allowed by charge and dipole conservation.
  ]
)
<fig:fragmentation>


We now turn to a related but conceptually distinct mechanism for ergodicity breaking, which does not rely on eigenstates or even time-periodicity of the dynamics. This phenomenon is variously described as “Hilbert space shattering”~@Khemani20, “Hilbert space fragmentation”~@Sala20, or “Krylov fracture”~@Moudgalya19b and refers to the existence of an exponentially large number of dynamically disconnected sectors of Hilbert space. This fragmentation of Hilbert space can be viewed as a generalization of the emergence of dynamically disconnected subspaces discussed in the previous section.


The most familiar way to obtain dynamically disconnected sectors is through the existence of conservation laws, with different sectors labeled by the values of conserved quantities. Thermodynamically, it is the sector with the lowest free energy which determines the physical behavior, but if a system is initialized in a different symmetry sector, observables will be determined by the statistical properties of that sector.


On the other hand, interesting examples of Hilbert space fragmentation involve the existence of dynamically disconnected sectors #emph[even after resolving all microscopic symmetries] --- #emph[i.e.], states with the same symmetry quantum numbers are still forbidden from mixing under the dynamics~@Khemani20 @Sala20 (see #ref(<fig:fragmentation>)\(a)). The unitary operator governing the time-evolution thus has a block diagonal structure (in some simple basis), which reflects both the symmetries of the problem, #emph[and] further fragmentation #emph[within] symmetry sectors. Strikingly, for systems with one or a few symmetries, while the number of symmetry sectors generally scales at most polynomially with system size, the number of dynamical sectors can scale #emph[exponentially] with system size. The dimension of the individual sectors can range from one (corresponding to a single frozen state) to exponential in system size. A further distinction between #emph[strong] and #emph[weak] fragmentation can be made depending on whether the ratio of the dimension of the largest dynamical sector to that of its symmetry sector tends to zero or one in the thermodynamic limit, respectively~@Khemani20 @Sala20. In the former (strong) case, there is an exponential number of dynamically disconnected sectors, which can lead to nonthermalizing dynamics even from typical initial states. The latter (weak) case is more generic, and predicts thermalization to the appropriate thermodynamic ensemble from most initial states.


Fragmented dynamics is considered scarred because of (i) a strong initial state dependence in the dynamics, ranging from fully localized to typically thermal depending on the dynamical sector in which one starts, and (ii) anomalous or frozen dynamics from simple low-entanglement initial states which never thermalize to the equilibrium state appropriate to the symmetry quantum numbers of the initial state.


The dynamical sectors are also referred to as Krylov sectors, following standard prescriptions for constructing the Krylov subspace $cal(K)$ of a state $\| psi_0 chevron.r$ time-evolving under a Hamiltonian $H$: the state $e^(i H t) \| psi_0 chevron.r$ lives in the span of all vectors obtained by the repeated action of $H$ on $\| psi_0 chevron.r$, $cal(K) = "span" ( \| psi_0 chevron.r , H \|psi_0 med , H^2 \|psi_0 med , dots.h.c )$. In the cases of most interest, the states $\| psi_0 chevron.r$ are simple experimentally preparable states (such as product states), and the dimension of $cal(K)$ is a vanishing fraction of the full Hilbert space dimension, leading to “Krylov restricted thermalization” within $cal(K)$~@Moudgalya19b\; in certain cases, the dynamics in $cal(K)$ may be integrable even if the model as a whole is not~@Moudgalya19b @Yang20 Recent works have constructed integrals of motion that label disjoint Krylov subspaces. In systems with Hilbert space fragmentation, there are exponentially many such integrals of motion that need not be sums of local operators~@Rakovszky20 @Moudgalya22.


A transparent manifestation of Hilbert space fragmentation occurs in local systems which conserve both a global U(1) charge and its dipole moment~@Pai19 @Khemani20 @Sala20. In a one dimensional spin system, these symmetries take the form $Q = sum_x S_x^z$ and $P = sum_x x S_x^z$, where the sum is over all lattice sites. These symmetries are characteristic of “fracton” topological phases (for reviews of fractons, see Refs.~@Nand_2019 @You_2020), and their combination produces $O ( L^3 )$ symmetry sectors labeled by $( Q , P )$ quantum numbers in a system of size $L$. In contrast, these symmetries are provably sufficient to produce exponentially many dynamical subsectors, including exponentially many #emph[strictly] frozen product states which live in dynamical subspaces of dimension exactly equal to one. In addition to the frozen states, there is a wide distribution of dimensions for the emergent subsectors, leading to a strong initial state dependence in the dynamics. The fragmentation is robust to the presence of both spatial and temporal randomness as long as the symmetries and locality are maintained.


The existence of exponentially many strictly frozen states is readily verified by the following simple argument@Khemani20. It is easiest to think of random unitary circuit models in which each unitary gate has range $ell$ and each gate locally conserves $Q , P$. Let us denote by $+$/$-$ the maximum/minimum local charges on a site respectively; these could be the “top” and “bottom” states of a qudit of spin $S$ so that $S^z = plus.minus S$. Now, note that any pattern that alternates between locally “all plus” and locally “all minus,” with domain walls between “all-plus” and “all-minus” regions at least $ell$ sites apart, must be inert by local charge and dipole moment conservation. #ref(<fig:fragmentation>)\(b) shows an example of such a frozen configuration with $S = 1$ and $ell = 3$. A straightforward lower bound on the number of such frozen states can be obtained by dividing the $L$-site chain up into blocks of size $ell$. Since all spins in each block must be either $+$ or $-$, there must be at least $2^(L / ell)$ such frozen states. This is exponentially large in $L$ for finite $ell$, but such frozen states still constitute a vanishing fraction of the full Hilbert space. For a more precise counting, see, #emph[e.g.], Ref.@Khemani20.


Other sectors with dimension larger than one can be systematically built by embedding dynamically active blocks into sufficiently large frozen backgrounds so as to keep the active region localized to a finite region of space; see #ref(<fig:fragmentation>)\(c) for a simple example.


It is also easy to write down Hamiltonians with charge and dipole conservation, for instance Hamiltonians with coordinated “pair hopping” terms $\|1001 med arrow.l.r \|0110 med$. Such Hamiltonians arise when considering models of the fractional quantum Hall effect in thin cylinders, #emph[i.e.]~in a quasi-1D limit~@Tao83 @Bergholtz05 @Moudgalya19 @Moudgalya19b. Such pair hopping terms could also emerge as the leading-order description of systems placed in large electric fields~@Moudgalya19b @Khemani20 Dipole moment couples directly to electric field, so if the system is placed in a sufficiently large static electric field (or equivalently, a tilted potential) then the Hilbert space will (approximately) split into symmetry sectors labelled by dipole moment (equivalently, center of mass position), with states at different dipole moment having sharply different energies. Equivalently, such systems can be viewed as possessing an emergent prethermal conservation of dipole moment that disappears after an exponentially long timescale~@Abanin_17 @Mori_16 @Khemani20 Much recent theoretical and experimental @Guo_2021 @Wang_2021 @Morong_2021 work has focused on such tilted systems, with claims that there may be a phase transition to a so-called Stark MBL~@Schulz_2019 @Refael_2019 phase in which a disorder-free system becomes many-body localized above a critical value of the tilt strength. However, it has been argued that the numerical signatures of Stark MBL may instead be finite-size and -time effects due to apparent Hilbert space fragmentation from long-lived prethermal dipole conservation induced by the tilted potential~@Khemani20 One can also consider conservation of higher multipole moments in higher dimensions, which have been shown to be associated with slow subdiffusive hydrodynamics~@Gromov20 @Grosvenor21 @Iaconis21.


Analogous physics has been studied in various other contexts including, #emph[e.g.], interacting fermion models~@Moudgalya19b @Iadecola18 @DeTomasi19 @Nachtergaele:2020ws, models with kinetic constraints (including in classical settings)~@Lan18 @OlmosLesanovsky @Gopalakrishnan18 @Sarang_Automaton1 @Hudomal:2020 @Zhao:2020 @Yang20 and multicomponent Hilbert spaces~@Zhao21 @Buca22, and models with emergent gauge fields such as frustrated magnets and dimer models~@McClarty:2020 @dimerfracture @Zhang22c. The existence of dynamically disconnected sectors and the resulting danger of obtaining thermodynamically incorrect results by getting trapped in an atypical sector has also been appreciated for a long time by the numerical simulation community~@dimerfracture @Moessner_rvb is the flipside of using Hilbert space fragmentation to obtain non-thermal behavior. This goes along with autonomously interesting investigations of the sector structure of such models, see #emph[e.g.]~Ref.@Cepas_21. The possibility of obtaining disorder-free glassy dynamics has also been discussed in this context, see #emph[e.g.]~Ref.~@Yin_2001 @Garrahan02 @Garrahan07 @VanHorssen15 @Lan18 @Pancotti20 @Charbonneau:2017ul. However, we note although dynamics in these various other settings can be described by the existence of dynamically disconnected subsectors, there is no understanding of general (#emph[i.e.], constructive) conditions that lead to Hilbert space fracture in these models and no principled way to examine the stability of fracturing in these models to the addition of perturbations or noise. For example, the simplest kinetically constrained models comprise spin 1/2 systems in which the spin on a site can flip if certain conditions are obeyed by its neighbors, for instance if both neighbors are down. However, there is no unique or natural way to deform such models, for example, to include the effect of further neighbor spins. Likewise, the dynamics in quantum dimer models come from certain "flippable" plaquettes which are lattice dependent. While allowing for longer flippable loops decreases fracture~@dimerfracture @Moessner_rvb, there are no general results on how the number of disconnected sectors scales with such perturbations. In contrast, the dipole-conserving models discussed here provide a robust symmetry-based constructive mechanism for Hilbert space fracture.


= Experiments and the Puzzles They Inspire
<sec:Experiments>


Much of the present interest in quantum many-body scars originates from an experiment reported in Ref.~@Bernien17, which observed unexpected coherent oscillations in a system of interacting Rydberg atoms when the array was prepared in a particular initial state. (Further systematic experimental analysis of this phenomenon was undertaken in Ref.~@Bluvstein21) In this section, we summarize this experiment and the theoretical attempts to understand it, making connections and drawing contrasts with the quasiparticle-centric point of view adopted in this review. We close this section with a summary of other experiments that have been performed in this domain. Throughout, we emphasize the remaining theoretical puzzles.


== Rydberg Atom Experiment and the PXP Model
<rydberg-atom-experiment-and-the-pxp-model>


In Ref.~@Bernien17, a system of rubidium atoms trapped in optical tweezers was used to perform an analog quantum simulation of the one-dimensional Ising model in transverse and longitudinal fields. The array of atoms is driven in such a way that each atom can be either in its ground state or in a highly excited Rydberg state. The resulting system can be viewed as an array of coupled two-level systems, described by Pauli operators $Z_i$ and $X_i$, with Hamiltonian $ H = sum_(i < j) V_(i j) thin n_i n_j - Delta sum_i n_i + Omega / 2 sum_i X_i . $<eq:Ising> Here, $n_i = ( 1 + Z_i ) / 2$ is the occupation of the Rydberg state of the $i$th atom and $X_i$ couples the $i$th atom's ground and Rydberg states. The parameter $Omega$ is the Rabi frequency of the driving laser, and $Delta$ is the detuning of the driving laser from the Rydberg state. The coupling $V_(i j) > 0$ originates from van der Waals interactions between excited atoms, and falls off as $R_(i j)^(- 6)$ with the distance $R_(i j)$ between atoms $i$ and $j$. When the nearest neighbor interaction strength $V equiv V_(i , i + 1)$ is much stronger than both $V_(i , i + 2)$ and $Omega$, the system enters the so-called “Rydberg blockade” regime in which nearest-neighbor atoms cannot simultaneously be excited@Jaksch00. The leading order effective Hamiltonian in this regime can be written as $ H_"eff" = sum_i (Omega / 2 thin P_(i - 1) X_i P_(i + 1) - Delta thin n_i) , $<eq:PXP> where the projector $P_i = ( 1 - Z_i ) / 2$ ensures that the Rydberg-blockade constraint is satisfied, and where longer-range interaction terms $V_(i j)$ with $\| i - j \| > 1$ have been neglected. This effective model has a history dating at least as far back as Ref.~@Fendley04, and, when $Delta = 0$, is known as the PXP model. The model is also relevant to U(1) lattice gauge theory in its quantum link~@Surace19 and dimer model~@Moessner01 @Laumann12 @Chen17 formulations, and to the fractional quantum Hall effect at $nu = 1 / 3$ in the thin-torus limit~@Moudgalya19.


As an aside, the form of the model in Eq.~#ref(<eq:PXP>) reflects one of the central themes in the physics of (especially topological) correlated quantum matter. Demanding that the largest term in a Hamiltonian be satisfied requires the identification of, and projection onto, the resulting “physical” subspace. This is the case here with the Rydberg blockade, and appears analogously in the avoidance of double occupancy in high-temperature superconductors via a Gutzwiller projection @Gutzwiller_63 @Anderson_87, in enforcing the ice rules in spin ice yielding an emergent magnetostatics @Castelnovo_12, or in minimizing kinetic energy in quantum Hall physics by projecting onto a partially filled Landau level ~@Girvin_99.


The experiment in Ref.~@Bernien17 prepared a Néel initial state, which can be expressed in the Rydberg occupation basis as $\|bb(Z)_2 med = \|101 dots.h med$, and evolved it with the Hamiltonian in Eq.~#ref(<eq:Ising>) with $Delta = 0$ in the Rydberg blockade regime. When $Delta = 0$, the average energy $⟨ bb(Z)_2 | H_"eff" | bb(Z)_2 ⟩$ lies in the middle of the spectrum of the nonintegrable model $H_"eff"$---#emph[i.e.], $\|bb(Z)_2 med$ is effectively an infinite-temperature state in the Rydberg-blockaded subspace. Thus, the expectation based on the ETH is that the dynamics of this initial state should rapidly decohere and local observables should thermalize to their infinite temperature expectation value; nevertheless, coherent oscillations of the occupation numbers $n_i$ were observed about a non-thermal value. Concurrent theoretical work reported in Ref.~@Bernien17 found that the entanglement entropy following this quench from the Néel state grows much more slowly than for other product states and also exhibits oscillations at the same frequency.


Expanding the Néel state in the eigenbasis of Eq.~#ref(<eq:PXP>) shows that the unexpected oscillations can be traced back to a set of $( L + 1 )$ special low-entanglement eigenstates in the spectrum of the PXP model for a chain of $L$ sites. This set of eigenstates spans the entire many-body bandwidth of the PXP model in the sector with no nearest-neighbor Rydberg excitations, and includes both the ground state and the highest-energy state. These eigenstates, which were termed quantum many-body scar states in Ref.~@Turner18a, have anomalously high overlap with the $\|bb(Z)_2 med$ state and are approximately equally spaced in energy, leading to coherent oscillatory dynamics of a variety of quantities and periodic near-revivals in the Loschmidt echo $cal(L) ( t )$ \[see Eq.~#ref(<eq:S1XYLt>)\]. Followup work in Ref.~@Turner18b found that the scar states also have anomalously low entanglement relative to other eigenstates of the PXP model at the same energy density, with half-chain entanglement entropy scaling $tilde ln L$.


== Attempts to Understand Scars in the PXP Model
<attempts-to-understand-scars-in-the-pxp-model>


While the existence of low-entanglement scarred eigenstates in the PXP model provides a #emph[descriptive] explanation of the experimental observations of Ref.~@Bernien17, a complete understanding of #emph[why] this model contains scars is still lacking. We now describe various attempts to understand the origin of the scarred eigenstates in the PXP model.


One line of work originated by the authors of Refs.~@Turner18a @Turner18b, known as the forward scattering approximation (FSA), constructs the scar states using a Krylov subspace approach. In this approach, the PXP Hamiltonian, $H_"PXP" = sum_i P_(i - 1) X_i P_(i + 1)$, is broken up as $ H_"PXP" = H^(+) + H^(-) , w h e r e H^(+) = sum_(i " odd") P_(i - 1) sigma_i^(-) P_(i + 1) + sum_(i " even") P_(i - 1) sigma_i^(+) P_(i + 1) $ and $H^(+) = ( H^(-) )^dagger$. The operators $H^plus.minus$ act as raising and lowering operators for the staggered magnetization $Z_pi = 1 / 2 sum_i ( - 1 )^i Z_i$, i.e. $ \[ Z_pi , H^plus.minus \] = plus.minus H^plus.minus . $<eq:PXPSU2> The Néel state $\|bb(Z)_2 med$ is the minimum-eigenvalue eigenstate of $Z_pi$. For a chain of $L$ sites, one can therefore define a Krylov subspace $cal(K) = ( \|0 med , \|1 med , dots.h , \|L med )$ spanned by $L + 1$ states $\|k med prop ( H^(+) )^k \|bb(Z)_2 med$, so that $\|0 med = \|bb(Z)_2 med$ and $\|L med = \|bb(Z)'_2 med = \|010 dots.h med$. Approximations to the scar states are then obtained by diagonalizing the projection of $H_"PXP"$ into the subspace $cal(K)$, which is a matrix of dimension $L + 1$. The FSA thus allows one to obtain approximations to the scarred eigenstates of the PXP model at system sizes much larger than those accessible to exact diagonalization and, as shown in Ref.~@Turner18b, produces eigenstates with entanglement entropy scaling as $ln L$. More recently, Ref.~@Desaules21 found a nonlocal interacting model for which the FSA becomes exact. However, this model is not perturbatively connected to the PXP model.


Eq.~#ref(<eq:PXPSU2>) is suggestive of an SU(2) algebra generated by $H^plus.minus$ and $Z_pi$, and thus of an SGA. However, as noted in Ref.~@Choi19, this algebra is not closed, since $ \[ H^(+) , H^(-) \] = 1 / 2 Z_pi + 1 / 4 O_(Z Z Z) , $<eq:Hpm> where we have assumed periodic boundary conditions and defined $O_(Z Z Z) = sum_i ( - 1 )^i Z_(i - 1) Z_i Z_(i + 1)$. We revisit the SGA connection below.


Subsequent work in Ref.~@Turner20 unified the FSA approach with parallel works that described the oscillatory scarred dynamics in the PXP model using the time-dependent variational principle (TDVP)~@Ho19 @Michailidis20 @Michailidis20revivals. The TDVP is a semiclassical approach that projects the quantum dynamics of a system into a variational manifold of matrix product states~@Haegeman11, leading to a set of classical equations of motion that can exhibit phenomena familiar from the theory of classical chaos. In this way, the FSA can be brought into contact with the theory of quantum scars in single-particle quantum mechanical systems arising as quantizations of classical dynamical systems~@Heller84. However, while the TDVP approach captures the scarred dynamics in the space of variational matrix-product states with low bond dimension (and hence low entanglement entropy), the periodic orbits may disappear on increasing the bond dimension@Michailidis20revivals. More work is thus required to sharpen the connection to single-particle scars.


A parallel strand of works have taken inspiration from the tower-like structure of the scar states, as evidenced by their nearly constant energy spacing and logarithmically scaling entanglement entropy, to attempt to formulate a quasiparticle description of these states.


One manner in which a quasiparticle description of the scar states can arise is through proximity to an integrable model, where #emph[every] eigenstate can be described in terms of quasiparticles@Franchini:2017vz. The proximity to integrability further guarantees that the dynamical response of the integrable model survives for a parametrically long time~@Berges:2004 @Kinoshita:2006ve @Gring:2012ly @Neyenhuis:2017wi @Eckstein:2009wv @Eisert:2015aa @Vasseur:2016ub. The connection between the PXP model and integrability was first pointed out in Ref.~@Khemani19, which found that adding $ H_"XZ" = h_"XZ" sum_i P_(i - 1) X_i P_(i + 1) ( Z_(i - 2) + Z_(i + 2) ) $<eq:PXPZ> to $H_"PXP"$ with a small coefficient $h_"XZ" tilde.eq - 0.02$ both strengthened the revivals and pushed the model closer towards integrability (as measured by various diagnostics such as Poisson statistics in energy-level spacings and fluctuations of eigenstate expectation values). Intriguingly, $H_"XZ"$ and its longer-range generalizations also enhance the accuracy of the FSA@Choi19 with a different value of $h_(upright(X) Z)$---and have a simple physical origin in complete bipartite graphs@Windt21. However, whether there exists an exact integrable point in the vicinity of $H_"PXP" + H_"XZ"$ remains unknown.


Another possibility is that the PXP model is proximate to a nonintegrable model with a #emph[single] infinitely long-lived quasiparticle species atop a vacuum state, similar to the case of the spin-1 XY model discussed in #ref(<sec:S1XY>) (Of course, this tower may still be obtained by adding an appropriate $H_A$ to a parent integrable/high-symmetry model as discussed in #ref(<sec:QPConstructive>)) Ref.~@Iadecola19 constructed an approximate tower of momentum-$pi$ magnon states atop the ground state of the PXP model and showed that the scar states found in Ref.~@Turner18a have high overlap with this tower. The ground state, which we call $\|E_0 med$, is known to be paramagnetic and has an efficient variational representation given in Ref.~@Ovchinnikov03. The lowest-lying excitation atop this ground state was shown numerically in Ref.~@Iadecola19 to have high overlap with the state $S_pi^(+) \|E_0 med$, where $ S_pi^plus.minus = Z_pi minus.plus i alpha thin Y_pi , $<eq:PXPSp> where $Z_pi$ is the staggered magnetization, $Y_pi = 1 / 2 sum_i ( - 1 )^i P_(i - 1) Y_i P_(i + 1)$, and $alpha approx 2$ is a constant determined by numerical optimization. This excitation is naturally interpreted as a magnon with momentum $pi$. Similar excitations can be created atop the highest excited state of the model, $\|E_"max" med$, via $S_pi^(-) \|E_"max" med$. This observation motivates the definition of a variational subspace spanned by $pi$-magnon states, $ cal(V)_pi = "span" ( ( S_pi^(+) )^n \|E_0 med , ( S_pi^(-) )^m \|E_"max" med )_(n , m = 0)^(L / 2) , $ in which the tower of scar states have substantial weight at finite system sizes. Moreover, enlarging the variational basis with states in which magnons have nontrivial relative momenta, e.g. $( S_pi^(+) )^(n - 2) S_(pi - delta k)^(+) S_(pi + delta k)^(+) \|E_0 med$, systematically increases the weight of the scar states in the variational magnon subspace.


Let us now revisit the connection to SGAs. Setting $alpha = 2$ in Eq.~#ref(<eq:PXPSp>), one finds that~@Iadecola19 $ \[ S_pi^(+) \, S_pi^(-) \] & = 2 thin H_(upright("PXP"))\
\[ H_(upright("PXP")) \, S_pi^plus.minus \] & = plus.minus S_pi^plus.minus plus.minus O_(Z Z Z) \, $<eq:PXPSU22> where $O_(Z Z Z)$ is defined below Eq.~#ref(<eq:Hpm>) Up to the extra $O_(Z Z Z)$ term in the second line, this is an SU(2) algebra. Eq.~#ref(<eq:PXPSU22>) can be viewed as analogous to Eqs.~#ref(<eq:PXPSU2>) and #ref(<eq:Hpm>), except that the roles of $Z_pi$ and $H_(upright("PXP"))$ have been interchanged. This point of view suggests a conceptual link between the FSA and the quasiparticle picture of Ref.~@Iadecola19.


One consequence of the algebra in Eq.~#ref(<eq:PXPSU22>) is the prediction of off-diagonal long-range order in the scar states (see the discussion around Eq.~#ref(<eq:Jplusminus>)). Such eigenstate order would result in coherent oscillations of the two-time correlator $cal(C)_Y ( t ) = ⟨ bb(Z)_2 | Y_pi ( t ) Y_pi ( 0 ) | bb(Z)_2 ⟩ \/ L^2$ in the thermodynamic limit~@Iadecola19 @Chen22.


Alternative quasiparticle descriptions of the scar states in the PXP model have also been proposed. Ref.~@Pan22 constructs a quasiparticle tower of states atop the ground state, similar to Ref.~@Iadecola19, except it starts from a variational approximation to the ground state developed in Ref.~@Lesanovsky12a. In Ref.~@Lin18, several exact matrix-product-state eigenstates of the PXP model were found near the middle of the energy spectrum, including at zero energy where the model exhibits an exponentially large degeneracy~@Turner18a @Schecter18. Ref.~@Lin18 constructed variational approximations to scar states near the middle of the spectrum by acting on the exact zero-energy matrix-product eigenstates with local operators determined by numerical optimization. Note that this quasiparticle picture predicts that the scar states near the middle of the spectrum ultimately have area-law entanglement, since acting with a local operator on a finite-bond-dimension matrix product state can only increase the entanglement entropy by a finite amount in the thermodynamic limit. This would contradict the numerical finding of Ref.~@Turner18b that the scar states have entanglement entropy $tilde ln L$.


More recently, another quasiparticle picture was proposed in Ref.~@Omiya22. In that work, the PXP model is converted to an effective spin-1 chain using a mapping proposed in Ref.@Lin18 A tower of states is then constructed by acting on the fully polarized state of the effective spin-1 chain with an appropriate spin-1 lowering operator, followed by a projection operator that enforces the Rydberg blockade constraint. This tower of states has the appealing property that the Néel state $\|bb(Z)_2 med$ can be written exactly as a superposition of the states in the tower, similar to the case of the spin-1 XY model where the initial state $\|phi.alt_0 med$ (Eq.~#ref(<eq:Initialstate>)) can be written as a superposition of scar states. This work found numerically that the scar states of the PXP model have high overlap with this tower. Intriguingly, it also constructs a non-Hermitian extension of the PXP model for which the states in this tower are exact eigenstates.


One common theme that has arisen throughout the works described in this section is the hypothesis that the PXP model is proximate to a model with exact scars. The perturbation, Eq.~#ref(<eq:PXPZ>), proposed in Ref.~@Khemani19 and its longer range variants considered in Refs.~@Choi19 @Bull19b enhance revivals that are characteristic of scarred dynamics. These terms also enhance the accuracy of Ref.~@Turner18a's FSA, and of Ref.~@Iadecola19's quasiparticle tower picture. Furthermore, Ref.~@Omiya22 found that terms of this form naturally emerge when trying to make their non-Hermitian model Hermitian. Reconciling these various perspectives where possible and determining the relationship (if any) to the model with an exact FSA proposed in Ref.~@Desaules21 remains an interesting research direction.


== Other Experiments
<other-experiments>
A variety of other experiments have detected signatures of many-body scarring. First, several recent experiments have realized the PXP model in other platforms. For example, Ref.~@Su22 used a Bose-Hubbard system in a tilted optical lattice to simulate the PXP model and measured entanglement and fidelity dynamics. Ref.~@Chen22 used superconducting-qubit processors from IBM to realize the nearest-neighbor limit of the mixed-field Ising model, Eq.~#ref(<eq:Ising>), and probe the dynamics in the scarred regime, including measurements of the nontrivial correlator $cal(C)_Y ( t )$. Another extension of the work performed in Ref.~@Bernien17 is Ref.~@Bluvstein21, which studied a periodically driven version of the PXP model and found intriguing subharmonic features in the dynamics of the Néel state.


Scars have also been realized in experimental platforms simulating other models. For example, in Ref.~@Zhang22 scarred dynamics were observed in a superconducting-qubit processor performing analog quantum simulation of a spin-1/2 XY model. In this work, the integrability of the spin-1/2 XY model is broken by random longer-range cross-coupling terms arising due to experimental imperfections, and scarred dynamics are observed from certain special initial states. Ref.~@Wil:2021vr instead creates long-lived, highly excited but non-thermal states in a bosonic one-dimensional quantum gas of dysprosium using a topological pumping mechanism. Starting from the ground state, the authors cyclically vary the contact interaction strength; as the Hamiltonian of the gas is close to an integrable one (the Lieb--Liniger model~@Giamarchi:2003oq @Cazalilla:2011nx), this process maps one eigenstate to another higher up in energy instead of heating up the gas.


= Conclusion and Outlook
<conclusion-and-outlook>


In this review, we have considered the phenomenon of quantum many-body scarring through the lens of quasiparticles. We began by considering a relatively simple model of quantum many-body scars, the spin-1 XY model, where the existence of rare, nonthermal eigenstates can be shown analytically. The nonthermal eigenstates consist of a finite density of quasiparticles, known as bimagnons, with momentum $pi$, whose scattering and dissociation are prevented by a destructive interference mechanism. We then moved on to consider more general settings for the realization of such towers of quasiparticle states, which can be formally understood in terms of spectrum generating algebras and associated symmetry principles. We also reviewed a few constructive approaches to realize models with towers of many-body scar states. Subsequently, we considered a range of other contexts in which the nomenclature of scarring has been invoked, focusing in particular on projector Hamiltonians and the more extreme phenomenon of Hilbert-space fragmentation. While these mechanisms for realizing nonthermal quantum many-body states have been associated with the phenomenon of scarring, they need not be associated with a quasiparticle description. Finally, we discussed experimental realizations of many-body scars, focusing in particular on the Rydberg experiment of Ref.~@Bernien17 and on the theoretical puzzles that it presents. Quasiparticles again appear in various guises in theoretical works attempting to explain these experimental results, but are not common to all theoretical descriptions that have been offered.


A variety of open questions remain. One of these concerns the stability of scarred many-body eigenstates to perturbations, which is crucially important both theoretically and in efforts to realize many-body scars in experiments. One way to phrase this question precisely is to ask what is the timescale for an exact scarred eigenstate $\|psi_0 med$ of a nonintegrable Hamiltonian $H_0$ to thermalize under dynamics generated by $H_0 + lambda V$, where $V$ is some local perturbation and $lambda$ is a small parameter. Ref.~@Lin19 presented an analysis of this problem on general grounds using Lieb-Robinson bounds and found that the thermalization time can be lower-bounded by $t_(*) tilde O ( lambda^(- 1 / ( 1 + d )) )$, where $d$ is the spatial dimension of the system. This lower bound is extremely general and is likely not tight in many cases of interest. Whether tighter lower bounds can be obtained, and understanding the mechanisms by which the thermalization time can exceed this bound in specific cases, are important questions for future work.


Despite the large volume of theoretical work on the subject, another question that remains is to understand the origin of many-body scarring in the PXP model that is relevant to the original Rydberg experiment. Specifically, it would be desirable to understand whether there is a model, integrable or otherwise, in which the scarred eigenstates can be written down exactly. Even if such a model is found, however, there are other unusual features of the PXP model---for example, there are other spin-density-wave-like states, such as $\|bb(Z)_3 med = \|100100 dots.h med$, that exhibit approximate revivals~@Turner18b, and other eigenstates that have anomalously high overlap with the Néel state $\|bb(Z)_2 med$~@MondragonShem21. Understanding these features of the model remains an outstanding challenge.


While this review has focused on many-body scars in Hamiltonian systems, they can also occur in other contexts. For example, many-body scars can appear in periodically driven systems, which do not conserve energy and are therefore expected to heat up to infinite temperature at late times~@Lazarides14@DAlessio14. There have been various studies of how such a heat death may be avoided, at least on long timescales @Mori_16 @Abanin_17 @Haldar_21. A variety of works, including the experiment in Ref.~@Bluvstein21, have studied periodically driven variants of the PXP model~@Mukherjee19 @Mizuta:2020 @Sugiura:2021 @Maskara21 @Iadecola20b @Wilkinson20 @Rozon21 and found both exact and approximate scarring. Notably, for a particular choice of periodic driving, the PXP model can be fine-tuned to integrability~@Iadecola20b @Wilkinson20 @Rozon21 Refs.~@Bluvstein21 and @Maskara21 propose an intriguing connection between scarring and discrete time crystals~@Khemani16 @Sacha17 @Khemani19b @Else20 that deserves further exploration. Quantum scarring in the single-particle context can also occur in non-Hermitian systems~@Wisniacki08, which motivates considering the possibility of many-body scars in this setting~@Buca19. While there has been some initial progress in this direction~@Pakrouski21 @Chen22 @Omiya22, it would be interesting to consider more broadly the possibility of many-body scarring in open quantum systems. The notion of inverse scars, where thermal states are embedded in a non-thermal spectrum~@Srivatsa_20, may also be an interesting subject.


Finally, another important question concerns the range of systems in which many-body scars can be realized experimentally. So far, the vast majority of experimental efforts have focused on realizing the PXP model in different contexts. Only recently have experiments turned their attention to other models; for example, Ref.~@Jepsen:2021 realized long-lived spin-helical states in a lithium atom system simulating anisotropic Heisenberg chains, and Ref.~@Wil:2021vr obtained scars in a dysprosium gas via topological pumping. However, whether scars stemming from other models and mechanisms could be observed in other experimental platforms is largely unexplored. The question of experimental realization is closely related to the exploration of potential applications for systems realizing quantum many-body scars. For example, Refs.~@Dooley21 @Desaules21b show that systems with many-body scars can be useful in quantum sensing and metrology.


Finding other potential applications of this fascinating phenomenon in quantum information science and technology is another worthy direction for future exploration.


#heading(level: 1, numbering: none)[DISCLOSURE STATEMENT]
<disclosure-statement>
The authors are not aware of any affiliations, memberships, funding, or financial holdings that might reasonably be perceived as affecting the objectivity of this review.


#heading(level: 1, numbering: none)[ACKNOWLEDGMENTS]
<acknowledgments>
We are grateful to Nick O'Dea for preparing #ref(<fig:S1XY>)\(b) and for previous collaboration, and to Andrei Bernevig and Maksym Serbyn for providing helpful feedback on the manuscript. We also thank our collaborators on previous works on scars and related topics in quantum dynamics, including Benjamin Burdick, Fiona Burnell, I-Chi Chen, Alexey Gorshkov, Christopher Langlett, Chris Laumann, Cheng-Ju Lin, Fangli Liu, Olexei Motrunich, Anne Nielsen, Peter Orth, Michael Schecter, N. Srivatsa, Long-Hin Tang, Julia Wildeboer, Shenglong Xu, Zhicheng Yang, and Yongxin Yao. We acknowledge valuable discussions with Jean-Yves Desaules, Wen Wei Ho, Timothy Hsieh, Ana Hudomal, Benjamin Lev, Sanjay Moudgalya, Zlatko Papić, Abhinav Prem and Nicolas Regnault.


This work was supported in part by the National Science Foundation through awards DMR-1752759 (A.C.) and DMR-2143635 (T.I.), by the US Department of Energy, Office of Science, Basic Energy Sciences, under Early Career Award No. DE-SC0021111 (V.K.), and by the Deutsche Forschungsgemeinschaft under cluster of excellence ct.qmat EXC 2147 project-id 390858490 (R.M.). V.K. also acknowledges support from the Sloan Foundation through a Sloan Research Fellowship and the Packard Foundation through a Packard Fellowship.

#show bibliography: set text(size: 8pt)
#bibliography("refs.bib", style: "annual.csl", title: [LITERATURE CITED])
