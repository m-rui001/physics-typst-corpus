#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("1.", p.at(0)) } else { numbering("1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set par(justify: true, first-line-indent: 0em)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: auto)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9.5pt)

// ---- helpers ----

#place(top + center, scope: "parent", float: true)[
  #align(center)[#text(15pt, weight: "bold")[Probing Topological Spin Liquids on a Programmable Quantum Simulator]]

  #v(0.8em)
  #align(center)[
    #text(11pt)[
      G. Semeghini#super[1], H. Levine#super[1], A. Keesling#super[1], S. Ebadi#super[1], T. T. Wang#super[1], D. Bluvstein#super[1], R. Verresen#super[1], H. Pichler#super[2,3], M. Kalinowski#super[1], R. Samajdar#super[1], A. Omran#super[1,4], S. Sachdev#super[1], A. Vishwanath#super[1], M. Greiner#super[1], V. Vuletić#super[5], M. D. Lukin#super[1]
    ]
    #v(0.6em)
    #text(8.5pt)[
      #super[1] Department of Physics, Harvard University, Cambridge, MA 02138, USA \
      #super[2] Institute for Theoretical Physics, University of Innsbruck, Innsbruck A-6020, Austria \
      #super[3] Institute for Quantum Optics and Quantum Information, Austrian Academy of Sciences, Innsbruck A-6020, Austria \
      #super[4] QuEra Computing Inc., Boston, MA 02135, USA \
      #super[5] Department of Physics and Research Laboratory of Electronics, Massachusetts Institute of Technology, Cambridge, MA 02139, USA
    ]
  ]

  #v(0.6em)
]
#strong[Abstract.] Quantum spin liquids, exotic phases of matter with topological order, have been a major focus of explorations in physical science for the past several decades. Such phases feature long-range quantum entanglement that can potentially be exploited to realize robust quantum computation. We use a 219-atom programmable quantum simulator to probe quantum spin liquid states. In our approach, arrays of atoms are placed on the links of a kagome lattice and evolution under Rydberg blockade creates frustrated quantum states with no local order. The onset of a quantum spin liquid phase of the paradigmatic toric code type is detected by evaluating topological string operators that provide direct signatures of topological order and quantum correlations. Its properties are further revealed by using an atom array with nontrivial topology, representing a first step towards topological encoding. Our observations enable the controlled experimental exploration of topological quantum matter and protected quantum information processing.

#set figure(placement: auto)

Motivated by visionary theoretical work carried out over the past five decades, a broad search is currently underway to identify signatures of quantum spin liquids (QSL) in novel materials @WenReview2017 @SachdevReview2018. Moreover, inspired by the intriguing predictions of quantum information theory @Kitaev2003fault, techniques to engineer such systems for topological protection of quantum information are being actively explored @Nayak2008. Systems with frustration @savary2016quantum caused by the lattice geometry or long-range interactions constitute a promising avenue in the search for QSLs. In particular, such systems can be used to implement a class of so-called dimer models @Rokhsar88 @Read91 @SachdevPRB1992 @Moessner01 @Misguich02, which are among the most promising candidates to host quantum spin liquid states. However, realizing and probing such states is challenging since they are often surrounded by other competing phases. Moreover, in contrast to topological systems involving time-reversal symmetry breaking, such as in the fractional quantum Hall effect @Halperin20, these states cannot be easily probed via, e.g., quantized conductance or edge states. Instead, to diagnose spin liquid phases, it is essential to access nonlocal observables, such as topological string operators @WenReview2017 @SachdevReview2018. While some indications of QSL phases in correlated materials have been previously reported @YoungLee2012 @Imai2015, thus far, these exotic states of matter have evaded direct experimental detection.

Programmable quantum simulators are well suited for the controlled exploration of these strongly correlated quantum phases @Gross2017 @weimer_rydberg_2010 @Hermele2009 @Yao2013 @Glaetzle14 @Celi20 @BrowaeysSSH. In particular, recent work showed that various phases of quantum dimer models can be efficiently implemented using Rydberg atom arrays @Rhine2020a and that a dimer spin liquid state of the toric code type could be potentially created in a specific frustrated lattice @Ruben2020. We note that toric code states have been dynamically created in small systems using quantum circuits @JWPanPRL2018 @Wallraff2020. However, some of the key properties, such as topological robustness, are challenging to realize in such systems. Spin liquids have also been explored using quantum annealers, but the lack of coherence in these systems has precluded the observation of quantum features @Zhou20.

#strong[Dimer Models in Rydberg Atom Arrays.] The key idea of our approach is based on a correspondence @Ruben2020 between Rydberg atoms placed on the links of a kagome lattice (or equivalently the #emph[sites] of a ruby lattice), as shown in Fig. 1A, and dimer models on the kagome lattice @SachdevPRB1992 @Misguich02. The Rydberg excitations can be viewed as "dimer bonds" connecting the two adjacent vertices of the lattice (Fig. 1B). Due to the Rydberg blockade @Saffman2010, strong and properly tuned interactions constrain the density of excitations such that each vertex is touched by a maximum of one dimer. At 1/4 filling, each vertex is touched by exactly one dimer, resulting in a perfect dimer covering of the lattice. Smaller filling fractions result in a finite density of vertices with no proximal dimers, which are referred to as #emph[monomers]. A quantum spin liquid can emerge within this dimer-monomer model close to 1/4 filling @Ruben2020, and can be viewed as a coherent superposition of exponentially many degenerate dimer coverings with a small admixture of monomers @Misguich02 (Fig. 1C). This corresponds to the resonating valence bond (RVB) state @Anderson73 @Rokhsar88, predicted long ago but so far still unobserved in any experimental system.

// [figvision] figures/Fig1.png
// Panel A: This is a fluorescence image and two schematics. The left image shows 219 green dots arranged on a
// hexagonal lattice with links forming a kagome pattern. The middle schematic shows a zoomed-in view of the
// lattice with green dots and a red and blue box labeled U(t). The right schematic shows the same lattice with
// red dimers marking bonds. The trend shows the initial and final state of atoms in a many-body dynamics
// experiment. Panel B: This is a schematic of a kagome lattice. Pink triangles represent unit cells, and bonds
// are marked with pink lines. Green dots are arranged on the lattice links. A circular pattern of pink lines and
// green dots is shown on the left. The trend shows the structure of the kagome lattice. Panel C: This is a
// diagram showing a mathematical expression for |ψ QSL ⟩ and three schematics. The expression describes a
// quantum spin liquid state. The schematics show the kagome lattice with pink lines and green dots, and red
// triangles with different orientations. The trend shows the quantum spin liquid state. Panel D: This is a plot
// of a time-dependent function. The x-axis ranges from 0 to 2.5 μs, and the y-axis ranges from 0 to 1. There are
// three series: a blue line, a red line, and an orange dashed line. The trend shows an increase in the function
// over time. Panel E: This is a plot with two sections. The top section has a y-axis ranging from -0.2 to 0.4
// and an x-axis ranging from 0 to 6. The bottom section has a y-axis ranging from 0 to 0.6 and an x-axis ranging
// from -2 to 6. There are four series: a gray line, a red line, a blue line, and a green line. The trend shows
// the probability of different states versus Δ/Ω.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure(scope: "parent", placement: auto, 
  image("figures/Fig1.png", width: 100%),
  caption: [
    #strong[Dimer model in Rydberg atoms arrays.] (#strong[A]) Fluorescence image of 219 atoms arranged on the links of a kagome lattice. The atoms, initially in the ground state $|g⟩$, evolve according to the many-body dynamics $U(t)$. The final state of the atoms is determined via fluorescence imaging of ground state atoms. Rydberg atoms are marked with red dimers on the bonds of the kagome lattice. (#strong[B]) We adjust the blockade radius to $R_b / a = 2.4$, by choosing $Omega = 2 pi times 1.4$ MHz and $a = 3.9$ µm, such that all six nearest neighbors of an atom in $|r⟩$ are within the blockade radius $R_b$. A state consistent with the Rydberg blockade at maximal filling can then be viewed as a dimer covering of the kagome lattice, where each vertex is touched by exactly one dimer. (#strong[C]) The quantum spin liquid state corresponds to a coherent superposition of exponentially many dimer coverings. (#strong[D]) Detuning $Delta(t)$ and Rabi frequency $Omega(t)$ used for quasi-adiabatic state preparation. (#strong[E]) (Top) Average density of Rydberg excitations $⟨n⟩$ in the bulk of the system, excluding the outer three layers @Supplement. (Bottom) Probabilities of empty vertices in the bulk (monomers), vertices attached to a single dimer, or to double dimers (weakly violating blockade). After $Delta / Omega ∼ 3$, the system reaches $∼ 1/4$ filling, where most vertices are attached to a single dimer, consistent with an approximate dimer phase.
  ]
) <fig1>

To create and study such states experimentally, we utilize two-dimensional arrays of 219 $""^87 "Rb"$ atoms individually trapped in optical tweezers @Ebadi2020 @Scholl2020 and positioned on the links of a kagome lattice, as shown in Fig. 1A. The atoms are initialized in an electronic ground state $|g⟩$ and coupled to a Rydberg state $|r⟩$ via a two-photon optical transition with Rabi frequency $Omega$. The atoms in the Rydberg state $|r⟩$ interact via a strong van der Waals potential $V = V_0 / d^6$, with $d$ the interatomic distance. This strong interaction prevents the simultaneous excitation of two atoms within a blockade radius $R_b = (V_0 / Omega)^(1/6)$ @Saffman2010. We adjust the lattice spacing $a$ and the Rabi frequency $Omega$ such that, for each atom in $|r⟩$, its six nearest neighbors are all within the blockade radius (Fig. 1B), resulting in a maximum filling fraction of 1/4. The resulting dynamics corresponds to unitary evolution $U(t)$ governed by the Hamiltonian

$ H / ℏ = (Omega(t) / 2) sum_i sigma^x_i - Delta(t) sum_i n_i + sum_(i < j) V_"ij" n_i n_j $ <eq:ryd_ham>

where $ℏ$ is the reduced Planck constant, $n_i = |r_i⟩⟨r_i|$ is the Rydberg state occupation at site $i$, $sigma^x_i = |g_i⟩⟨r_i| + |r_i⟩⟨g_i|$ and $Delta(t)$ is the time-dependent two-photon detuning. After the evolution, the state is analyzed by projective readout of ground state atoms (Fig. 1A, right panel) @Ebadi2020.

To explore many-body phases in this system, we utilize quasi-adiabatic evolution, in which we slowly turn on the Rydberg coupling $Omega$ and subsequently change the detuning $Delta$ from negative to positive values using a cubic frequency sweep over about 2 µs (Fig. 1D). We stop the cubic sweep at different endpoints and first measure the density of Rydberg excitations $⟨n⟩$. Away from the array boundaries (which result in edge effects permeating just two layers into the bulk), we observe that the average density of Rydberg atoms is uniform across the array (see Fig.~S3 and @Supplement). Focusing on the bulk density, we find that for $Delta / Omega ≥ 3$, the system reaches the desired filling fraction $⟨n⟩ ∼ 1/4$ (Fig. 1E, top panel). The resulting state does not have any obvious spatial order (Fig. 1A) and appears as a different configuration of Rydberg atoms in each experimental repetition (see Fig.~S4 and @Supplement). From the single-shot images, we evaluate the probability for each vertex of the kagome lattice to be attached to: one dimer (as in a perfect dimer covering), zero dimers (i.e. a monomer), or two dimers (representing weak blockade violations). Around $Delta / Omega ∼ 4$ we observe an approximate plateau where $∼ 80%$ of the vertices are connected to a single dimer (Fig. 1E), indicating an approximate dimer covering.

#strong[Measuring topological string operators.] A defining property of a phase with topological order is that it cannot be probed locally. Hence, to investigate the possible presence of a QSL state, it is essential to measure topological string operators, analogous to those used in the toric code model @Kitaev2003fault. For the present model, there are two such string operators, the first of which characterizes the effective dimer description, while the second probes quantum coherence between dimer states @Ruben2020. We first focus on the diagonal operator $Z = product_(i in S) sigma^z_i$, with $sigma^z_i = 1 - 2 n_i$, that measures the parity of Rydberg atoms along a string $S$ perpendicular to the bonds of the kagome lattice (Fig. 2A). For the smallest closed $Z$ loop, which encloses a single vertex of the kagome lattice, $⟨Z⟩ = -1$ for any perfect dimer covering. Larger loops can be decomposed into a product of small loops around all the enclosed vertices, resulting in $⟨Z⟩ = (-1)^( "# enclosed vertices")$ (Fig. 2B). Note that the presence of monomers or double-dimers reduces the effective contribution of each vertex, resulting in a reduced $⟨Z⟩$.

// [figvision] figures/Fig2.png
// A. This panel is a schematic. It shows a triangle with a red dashed line across it, labeled Z, mapped to a
// triangle with a red half-disk shape across it, and four examples of the latter with different configurations
// of the half-disk shape, each mapped to +1 or -1. The trend or message is that the string operator measures the
// parity of dimers along a string, with different configurations corresponding to different parity values. B.
// This panel is also a schematic. It shows a honeycomb lattice with red half-disk shapes representing dimers,
// and green and blue dashed lines and numbers indicating the parity measurements. The trend or message is that a
// perfect dimer covering always has exactly one dimer touching each vertex of the array, and the parity
// measurements following a quasi-adiabatic sweep. The objects are the lattice vertices and dimers, with the
// layout showing how the dimers connect to the vertices. C. This panel is a plot. The axes are Δ/Ω, ranging from
// 0 to 7, on the x-axis, and 〈Z〉, ranging from -0.05 to 0.15, on the y-axis. There are five series, each with a
// different color: red, blue, orange, green, and black. The red series has solid lines and dots, while the
// others have various line styles and dots. The trend or message is that the parity measurements following the
// quasi-adiabatic sweep have a peak at around Δ/Ω = 3-4, with the red series showing the largest signal. The
// inset shows a honeycomb lattice with colored dashed lines indicating the strings used for the parity
// measurements.
#figure(placement: auto, 
  image("figures/Fig2.png", width: 100%),
  caption: [
    #strong[Detecting a dimer phase via diagonal string operator.] (#strong[A]) The $Z$ string operator measures the parity of dimers along a string. (#strong[B]) A perfect dimer covering always has exactly one dimer touching each vertex of the array, so that $⟨Z⟩ = -1$ around a single vertex and $⟨Z⟩ = (-1)^( "# enclosed vertices")$ for larger loops. (#strong[C]) $Z$ parity measurements following the quasi-adiabatic sweep of Fig. 1D, with the addition of a 200 ns ramp-down of $Omega$ at the end to optimize preparation. At different endpoints of the sweep and for different loop sizes (inset), we measure a finite $⟨Z⟩$, consistent with an approximate dimer phase.
  ]
) <fig2>

To measure $⟨Z⟩$ for different loops (Fig. 2C), we evaluate the string observables directly from single-shot images, averaging over many experimental repetitions and over all loops of the same shape in the bulk of the lattice @Supplement. In the range of detunings where $⟨n⟩ ∼ 1/4$, we clearly observe the emergence of a finite $⟨Z⟩$ for all loops, with the sign matching the parity of enclosed vertices, as expected for dimer states (Fig. 2B). The measured values are generally $abs(⟨Z⟩) < 1$ and decrease with the loop size, suggesting the presence of a finite density of defects, as discussed below. Nevertheless, these observations indicate that the state we prepare is consistent with an approximate dimer phase.

We next explore quantum coherence properties of the prepared state. To this end, we consider the off-diagonal $X$ operator, which acts on strings along the bonds of the kagome lattice. It is defined in Fig. 3A by its action on a single triangle @Ruben2020. Applying $X$ on any closed string maps a dimer covering to another valid dimer covering (see e.g. Fig. 3B for a loop around a single hexagon). A finite expectation value for $X$ therefore implies that the state contains a coherent superposition of one or more pairs of dimer states coupled by that specific loop, a prerequisite for a #emph[quantum] spin liquid. The measurement of $X$ can be implemented by performing a collective basis rotation @Ruben2020 illustrated in Fig. 3C. This rotation is implemented by time-evolution under the Rydberg Hamiltonian @eq:ryd_ham with $Delta = 0$ and reduced blockade radius $R_b / a = 1.53$, such that only the atoms within the same triangle are subject to the Rydberg blockade constraint. Under these conditions, it is sufficient to consider the evolution of individual triangles separately, where each triangle can be described as a 4-level system (see @fig:basis). Within this subspace, after a time $tau = 4 pi / (3 Omega sqrt(3))$, the collective 3-atom dynamics realizes a unitary $U_q$ which implements the basis rotation that transforms an $X$ string into a dual $Z$ string @Supplement.

// [figvision] figures/Fig3.png
// A. This schematic shows a string operator on a single triangle of the kagome lattice. The operator X is
// represented by a blue wavy line on the bottom side of the triangle. Two configurations are shown: one with a
// red diagonal line and one without. An arrow indicates that these configurations are related by the operator,
// with a phase factor of (-1). B. This schematic shows the action of the string operator on a closed loop. The
// operator maps any dimer covering into another valid dimer covering. The left-hand side shows the operator as a
// blue loop on a star-shaped arrangement of triangles. The right-hand side shows the result of applying the
// operator as a sum of products of local operators, represented by red ellipses, on different dimer coverings.
// C. This schematic shows how the operator X is measured. The initial state is evolved under Hamiltonians Uq(τ)
// and Uq†(τ), represented by green circles and blue lines. The operator X is sandwiched between these
// evolutions, and the result is measured. D. This plot shows the time evolution of two parameters, Ω and Δ,
// during a quench process. The x-axis represents time, and the y-axis represents the values of Ω and Δ. The red
// line represents Ω, and the blue line represents Δ. Two values of Rb/a are shown: 2.4 and 1.53. E. This plot
// shows the parity of the string operator as a function of quench time. The x-axis ranges from 0 to 45 ns, and
// the y-axis ranges from -0.02 to 0.10. The plot shows a peak at around 15 ns and a dip at around 30 ns. The
// inset shows a schematic of the string operator on a larger lattice. F. This plot shows the expectation value
// of the string operator X as a function of Δ/Ω. The x-axis ranges from 1.5 to 6, and the y-axis ranges from
// 0.00 to 0.20. Four series are shown, each with a different color: red, green, blue, and orange. The inset
// shows a schematic of the string operator on a larger lattice, with different loops highlighted in different
// colors.
#figure(scope: "parent", placement: auto, 
  image("figures/Fig3.png", width: 100%),
  caption: [
    #strong[Probing coherence between dimer states via off-diagonal string operator.] (#strong[A]) Definition of $X$ string operator on a single triangle of the kagome lattice. (#strong[B]) On any closed loop, the $X$ operator maps any dimer covering into another valid dimer covering, such that $⟨X⟩$ measures the coherence between pairs of dimer configurations. (#strong[C]) The $X$ operator is measured by evolving the initial state under Hamiltonian @eq:ryd_ham with $Delta = 0$ and reduced blockade radius to encompass only atoms within each individual triangle, implementing a basis rotation that maps $X$ into $Z$. (#strong[D]) In the experiment, after the state preparation, we set the laser detuning to $Delta_q = 0$ and we increase $Omega$ to $2 pi times 20$ MHz to reach $R_b / a = 1.53$. (#strong[E]) By measuring the $Z$ parity on the dual string (red) of a target $X$ loop (blue) after a variable quench time, we identify the time $tau$ for which the mapping in (#strong[C]) is implemented. (#strong[F]) We measure $⟨X⟩$ for different final detunings of the cubic sweep and for different loop sizes (inset), and find that the prepared state has long-range coherence that extends over a large fraction of the array @Supplement.
  ]
) <fig3>

Experimentally, the basis rotation is implemented following the state preparation by quenching the laser detuning to $Delta_q = 0$ and increasing the laser intensity by a factor of $∼ 200$ to reduce the blockade radius to $R_b / a = 1.53$ (Fig. 3D and @Supplement). We calibrate $tau$ by preparing the state at $Delta / Omega = 4$ and evolving under the quench Hamiltonian for a variable time. We measure the parity of a $Z$ string that is dual to a target $X$ loop, and observe a sharp revival of the parity signal at $tau ∼ 30$ ns (Fig. 3E) @Ruben2020. Fixing the quench time $tau$, we measure $⟨X⟩$ for different values of the detuning $Delta$ at the end of the cubic sweep (Fig. 3F) and observe a finite $X$ parity signal for loops that extend over a large fraction of the array. We emphasize that, in light of experimental imperfections @Supplement, the observation of finite parities for string observables of up to 28 atoms within µs-long experiments is rather remarkable. These observations clearly indicate the presence of long-range coherence in the prepared state.

#strong[Probing spin liquid properties.] The study of closed string operators shows that we prepare an approximate dimer phase with quantum coherence between dimer coverings. While these closed loops are indicative of topological order, it is important to compare their properties to those of open strings to distinguish topological effects from trivial ordering---the former being sensitive to the topology of the loop @BF1983 @FM1983 @Gregor11. This comparison is shown in Fig. 4D,E, indicating several distinct regimes. For small $Delta$, we find that both $Z$ and $X$ loop parities factorize into the product of the parities on the half-loop open strings---in particular, the finite $⟨Z⟩$ is a trivial result of the low density of Rydberg excitations. In contrast, loop parities no longer factorize in the dimer phase ($3 ≤ Delta / Omega ≤ 5$). Instead, the expectation values for both open string operators vanish in the dimer phase, indicating the nontrivial nature of the correlations measured by the closed loops (see also @Supplement). More specifically, topological ordering in the dimer-monomer model can break down either due to a high density of monomers, corresponding to the trivial disordered phase at small $Delta / Omega$, or due to the lack of long-range resonances, corresponding to a valence bond solid (VBS) @Ruben2020. Open $Z$ and $X$ strings distinguish the target QSL phase from these proximal phases: when normalized according to the definition from Bricmont, Fröhlich, Fredenhagen and Marcu @BF1983 @FM1983 (BFFM) (Fig. 4B,C), these open strings can be considered as order parameters for the QSL. In particular, open $Z$ strings have a finite expectation value when the dimers form an ordered spatial arrangement, as in the VBS phase. At the same time, open $X$ strings create pairs of monomers at their endpoints (Fig. 4A), so a finite $⟨X⟩$ can be achieved in the trivial phase where there is a high density of monomers. Therefore, the QSL can be identified as the unique phase where both order parameters vanish for long strings @Ruben2020.

// [figvision] figures/Fig4.png
// A. This schematic shows an open string operator acting on a dimer state. The dimer state is shown as a
// honeycomb lattice with red ellipses representing dimers. The open string operator is shown as a purple line.
// The action of the operator creates two monomers (e-anyon) at its endpoints. B. This schematic defines the
// string order parameter . It shows a honeycomb lattice with gray dots representing atoms. The blue line
// represents the string. The string order parameter is defined as the expectation value of the operator Z, shown
// as a blue ellipse, along the string. C. This schematic defines the string order parameter . It shows a
// honeycomb lattice with gray dots representing atoms. The purple line represents the string. The string order
// parameter is defined as the expectation value of the operator X, shown as a purple wavy line, along the
// string. D. This plot compares the string order parameters and measured on strings. The x-axis represents Δ/Ω,
// ranging from -2 to 7. The y-axis represents the expectation value, ranging from 0 to 0.3. There are two
// series: one for the open string (green) and one for the closed string (red). E. This plot compares the string
// order parameters and measured on strings. The x-axis represents Δ/Ω, ranging from -2 to 7. The y-axis
// represents the expectation value, ranging from 0 to 0.2. There are two series: one for the open string (green)
// and one for the closed string (red). F. This plot shows the string order parameter as a function of Δ/Ω. The
// x-axis ranges from 3 to 6, and the y-axis ranges from 0 to 0.3. There are several series with different colors
// and line styles. G. This plot shows the string order parameter as a function of Δ/Ω. The x-axis ranges from
// 2.5 to 5.5, and the y-axis ranges from 0 to 0.4. There are several series with different colors and line
// styles. H. This plot shows the relationship between the number of enclosed vertices and the string order
// parameter. The x-axis represents the number of enclosed vertices, ranging from 6 to 22. The y-axis represents
// the string order parameter, ranging from 0.7 to 0.85. I. This plot shows the relationship between the number
// of enclosed hexagons and the string order parameter. The x-axis represents the number of enclosed hexagons,
// ranging from 1 to 5. The y-axis represents the string order parameter, ranging from 0.15 to 0.35.
#figure(placement: auto, 
  image("figures/Fig4.png", width: 100%),
  caption: [
    #strong[String order parameters and quasiparticle excitations.] (#strong[A]) An open string operator $X_"open"$ acting on a dimer state $|D⟩$ creates two monomers ($e$-anyons) at its endpoints (see Fig.~S9 for $m$-anyons). (#strong[B,C]) Definition of the string order parameters $⟨Z⟩_"BFFM"$ and $⟨X⟩_"BFFM"$. (#strong[D]) Comparison between $⟨Z_"closed"⟩$ and $⟨Z_"open"⟩^2$ measured on the strings shown in the inset. The expectation value shown for the open string is squared to account for the different length of the strings. (#strong[E]) Analogous comparison for $X$. (#strong[F,G]) Zooming in on the range with finite closed loop parities we measure the BFFM order parameters for different open strings (insets). We find that $⟨Z⟩_"BFFM"$ is consistent with zero on the entire range of $Delta$, while $⟨X⟩_"BFFM"$ vanishes for $Delta / Omega ≥ 3.3$, allowing us to identify a range of detunings consistent with the onset of a QSL phase (shaded area). (#strong[H]) Rescaled parities $⟨Z⟩^(1/"area")$ and $⟨Z⟩^(1/"perim")$ evaluated for $Delta / Omega = 3.6$, where area and perimeter are defined as the number of vertices enclosed by the loop and the number of atoms on the loop, respectively. For small loops, $Z$ scales with an area law, while it deviates from this behavior for larger loops, converging towards a perimeter law. (#strong[I]) $⟨X⟩^(1/"area")$ (the area, in this case, is the number of enclosed hexagons) and $⟨X⟩^(1/"perim")$ evaluated for $Delta / Omega = 3.5$, indicating an excellent agreement with a perimeter-law scaling.
  ]
) <fig4>

Fig. 4F,G show the measured values of these order parameters. We find that $⟨Z⟩_"BFFM"$ is compatible with zero on the entire range of $Delta / Omega$ where we observed a finite $Z$ parity on closed loops, indicating the absence of a VBS phase (Fig. 4F), consistent with our analysis of density-density correlations (Fig.~S5 and @Supplement). At the same time, $⟨X⟩_"BFFM"$ converges towards zero on the longest strings for $Delta / Omega ≥ 3.3$ (Fig. 4G), indicating a transition out of the disordered phase. By combining these two measurements with the regions of non-vanishing parity for the closed $Z$ and $X$ loops (@fig2,@fig3), we conclude that for $3.3 ≤ Delta / Omega ≤ 4.5$ our results constitute a direct detection of the onset of a quantum spin liquid phase (shaded area in Fig. 4F,G).

The measurements of the closed loop operators in @fig2,@fig3 show that $abs(⟨Z⟩), abs(⟨X⟩) < 1$ and that the amplitude of the signal decreases with the loop size, which results from a finite density of quasiparticle excitations. Specifically, defects in the dimer covering such as monomers and double-dimers can be interpreted as #emph[electric] ($e$) anyons in the language of lattice gauge theory @Ruben2020. Since the presence of a defect inside a closed loop changes the sign of $Z$, the parity on the loop is reduced according to the number of enclosed $e$-anyons as $abs(⟨Z⟩) = abs(⟨(-1)^( "# enclosed e-anyons")⟩)$. The average number of defects inside a loop is expected to scale with the number of enclosed vertices, i.e. with the #emph[area] of the loop, and indeed we observe an approximate #emph[area-law] scaling of $abs(⟨Z⟩)$ for small loop sizes (Fig. 4H). However, for larger loops we notice a deviation towards a #emph[perimeter-law] scaling, which can emerge if pairs of anyons are correlated over a characteristic length scale smaller than the loop size (see @Supplement for a discussion of the expected scaling). Pairs of correlated anyons which are both inside the loop do not change its parity since their contributions cancel out; they only affect $⟨Z⟩$ when they sit across the loop, leading to a scaling with the length of the perimeter. These pairs can be viewed as resulting from the application of $X$ string operators to a dimer covering (Fig. 4A), originating, e.g., from virtual excitations in the dimer-monomer model @Supplement or from errors due to state preparation and detection. Note that state preparation with larger Rabi frequency (improved adiabaticity) results in larger $Z$ parity signals and reduced $e$-anyon density (see Fig.~S7).

A second type of quasiparticle excitation that could arise in this model is the so-called #emph[magnetic] ($m$) anyon. Analogous to $e$-anyons which live at the endpoints of open $X$ strings (Fig. 4A), $m$-anyons are created by open $Z$ strings and they correspond to phase errors between dimer coverings (Fig.~S9 and @Supplement). These excitations cannot be directly identified from individual snapshots, but they are detected by the measurement of closed $X$ loop operators. The remarkable perimeter law scaling observed in Fig. 4I indicates that $m$-anyons only appear in pairs with short correlation lengths @Supplement. These observations highlight the prospects for using topological string operators to detect and probe quasiparticle excitations in the system.

#strong[Towards a topological qubit.] To further explore the topological properties of the spin liquid state, we create an atom array with a small hole by removing three atoms on a central triangle, which creates an effective inner boundary (@fig5). This results in two distinct topological sectors for the dimer coverings, where states belonging to different sectors can be transformed into each other only via large $X$ loops which enclose the hole, constituting a highly nonlocal process (involving at least a 16-atom resonance) (Fig.~S11). We define the logical states $|0_L⟩$ and $|1_L⟩$ as the superpositions of all dimer coverings from the topological sectors 0 and 1, respectively. One can define @Ruben2020 the logical operator $sigma^z_L$ as proportional to any $Z_L$ string operator that connects the hole with the outer boundary, since these have a well-defined eigenvalue $± 1$ for all dimer states in the same sector but opposite for the two sectors. The logical $sigma^x_L$ is instead proportional to $X_L$, which is any $X$ loop around the hole. This operator anticommutes with $Z_L$ and has eigenstates $|+⟩ ∼ (|0_L⟩ + |1_L⟩) / sqrt(2)$ and $|-⟩ ∼ (|0_L⟩ - |1_L⟩) / sqrt(2)$.

// [figvision] figures/Fig5.png
// Panel A is a vertical schematic sequence showing three dimer states on a hexagonal lattice with a central
// triangular hole. The top state |D1> displays red oval dimers, a grey central hole, and dashed blue and cyan
// strings extending to the boundary, labeled <Z> = -1 and <Z1 Z2> = +1, in the same topological sector. A
// downward arrow leads to |D2>, the opposite sector, with identical lattice layout but labeled -1 and +1.
// Another arrow leads to |D3>, labeled +1 and +1. The dashed strings represent paths from the hole to the edge
// whose expectation values fix the sector. Panel B is a line plot with an inset schematic. The main panel plots
// expectation values <Z_L> in purple and <X_L> in red-orange versus Δ/Ω on the x-axis from about 1.5 to 6.5.
// Purple circles start near 0.05 at Δ/Ω = 1.5, fall sharply to zero near Δ/Ω = 3, and remain near zero.
// Red-orange circles rise from 0.02 to about 0.04 near Δ/Ω = 2.8, then decay toward zero with error bars. A grey
// vertical band spans Δ/Ω roughly 3.2 to 4.2. The upper-right inset shows the lattice hole with a red wavy X_L
// loop and a blue dashed Z_L string. Panel C plots the absolute correlator |<Z1 Z2>| versus Δ/Ω from 2 to 6.
// Four series are shown: dark teal circles peak at about 0.105 near Δ/Ω = 4 before declining; medium teal
// circles reach about 0.04 near Δ/Ω = 4.5; pink circles stay below 0.02; yellow circles remain near zero. All
// curves rise from low values at Δ/Ω = 1.5, with the dark teal series showing the strongest non-monotonic
// dependence. The lower-right inset depicts the lattice hole overlaid with multiple dashed string operators:
// blue diagonal lines, cyan and pink horizontal lines, and yellow diagonal dashed segments.
#figure(scope: "parent", placement: auto, 
  image("figures/Fig5.png", width: 100%),
  caption: [
    #strong[Topological properties in array with a hole.] (#strong[A]) A lattice with nontrivial topology is obtained by removing three atoms at the center to create a small hole. The dimer states can be divided into two distinct topological sectors 0 and 1. $Z$ strings connecting the hole to the boundary always have a well-defined expectation value within each sector and opposite sign between the two sectors, while the correlations between two such strings $Z_1 Z_2$ are identical for both sectors. (#strong[B]) Measured expectation values for the operators $Z_L$ and $X_L$ defined in the inset, indicate that in the QSL region (shaded area) we prepare a superposition state of the two topological sectors ($⟨Z_L⟩ = 0$) with a finite overlap with the $|+⟩$ state ($⟨X_L⟩ > 0$). (#strong[C]) Finite expectation values for the correlations between pairs of hole-to-boundary $Z$ strings (inset), consistent with (#strong[A]).
  ]
) <fig5>

We measure $Z_L$ and $X_L$ on the strings defined in the inset of Fig. 5B, following the same quasi-adiabatic preparation as in Fig. 1D. We find that in the range of $Delta / Omega$ associated with the onset of a QSL phase, $⟨Z_L⟩ = 0$, and $⟨X_L⟩ > 0$, indicating that the system is in a superposition of the two topological sectors, with a finite overlap with the $|+⟩$ state (Fig. 5B). To further support this conclusion, we evaluate correlations $⟨Z_1 Z_2⟩$ between hole-to-boundary strings, which are expected to have the same expectation values for both topological sectors (Fig. 5A). In agreement with this prediction, we find that the correlations between different pairs of strings have finite expectation values, with amplitudes decreasing with the distance between the strings (Fig. 5C) due to imperfect state preparation. These measurements represent the first steps towards initialization and measurement of a topological qubit.

#strong[Discussion and outlook.] Noting that it is not possible to classically simulate quantum dynamics for the full experimental system, we compare our results with several theoretical approaches. We first note that our observations qualitatively disagree with the ground state phase diagram obtained from density-matrix-renormalization-group (DMRG) @White92 @Hauschild18 simulations on infinitely-long cylinders. For the largest accessible system sizes, including van der Waals interactions only up to intermediate distances ($∼ 4a$), we find a $ℤ_2$ spin liquid in the ground state. However, unlike in deformed lattices @Ruben2020, longer-range couplings destabilize the spin liquid in the ground state of the Hamiltonian @eq:ryd_ham on the specific ruby lattice used in the experiment, leading to a direct first-order transition from the disordered phase to the VBS phase @Supplement. In contrast, we experimentally observe the onset of the QSL phase in a relatively large parameter range, while no signatures of a VBS phase are detected.

To develop additional insight, we perform time-dependent DMRG calculations @White92 @Zaletel15 @Hauschild18 simulating the same state preparation protocol as in the experiment on an infinitely-long cylinder with a seven-atom-long circumference @Supplement. The results of these simulations are in good qualitative agreement with our experimental observations (see Fig.~S17). Specifically, similar to the results in @fig4, we find that the region $Delta / Omega ∼ 3.5–4.5$ hosts nonzero signals for closed $Z$ and $X$ loops which cannot be factorized into open strings, a characteristic fingerprint of spin liquid correlations. In addition, exact diagonalization studies of a simplified blockade model reveal how the dynamical state preparation creates an approximate equal-weight and equal-phase superposition of many dimer states, instead of the VBS ground state @Supplement. We conclude that quasi-adiabatic state preparation occurring over a few microseconds is insensitive to longer-range couplings and generates states that retain the QSL character @Supplement. While this phenomenon deserves further theoretical studies, these considerations point towards the creation of a novel #emph[metastable] state with key characteristic properties of a quantum spin liquid.

Our experiments offer unprecedented insights into elusive topological quantum matter, and open up a number of new directions in which these studies can be extended, including: improving the robustness of the QSL by using modified lattice geometries and boundaries @Rhine2020a @Ruben2020, as well as optimizing the state preparation to minimize quasiparticle excitations; understanding and mitigating environmental effects associated, e.g., with dephasing and spontaneous emission @Supplement; optimizing string operator measurements using quasi-local transformations @HastingsWen2005, potentially with the help of quantum algorithms @Cong2019. At the same time, hardware-efficient techniques for robust manipulation and braiding of topological qubits can be explored. Furthermore, methods for anyon trapping and annealing can be investigated, with eventual applications towards fault-tolerant quantum information processing @KitaevPreskill4D. With improved programmability and control, a broader class of topological quantum matter and lattice gauge theories can be efficiently implemented @CiracLGT2020 @Lewenstein2013, opening the door to their detailed exploration under controlled experimental conditions, and providing a novel route for the design of quantum materials that can supplement exactly solvable models @Kitaev2003fault @KitaevHoneycomb and classical numerical methods @White92 @Hauschild18.

#v(0.6em)
#emph[Note added]: During the completion of this manuscript we became aware of related work demonstrating the preparation of toric code states on a 32-qubit superconducting quantum processor @Google2021.

#v(0.6em)
#strong[Acknowledgments] \
We thank many members of the Harvard AMO community, particularly E. Urbach, S. Dakoulas, and J. Doyle for their efforts enabling operation of our laboratories during 2020-2021. We thank S. Choi, I. Cong, E. Demler, X. Gao, G. Giudici, W. W. Ho, N. Maskara, K. Najafi, N. Yao and S. Yelin for stimulating discussions. #strong[Funding:] We acknowledge financial support from the Center for Ultracold Atoms, the National Science Foundation, the U.S. Department of Energy (DE-SC0021013 & LBNL QSA Center), the Army Research Office, ARO MURI, and the DARPA ONISQ program. G.S. acknowledges support from a fellowship from the Max Planck/Harvard Research Center for Quantum Optics. H.L. acknowledges support from the National Defense Science and Engineering Graduate (NDSEG) fellowship. T.T.W. acknowledges support from Gordon College. D.B. acknowledges support from the NSF Graduate Research Fellowship Program (grant DGE1745303) and The Fannie and John Hertz Foundation. R.V. acknowledges support from the Harvard Quantum Initiative Postdoctoral Fellowship in Science and Engineering. R.V., A.V. and S.S. acknowledge support from the Simons Collaboration on Ultra-Quantum Matter, which is a grant from the Simons Foundation (651440, A.V., S.S.). R.S. and S.S. were supported by the U.S. Department of Energy under Grant DE-SC0019030. The DMRG simulations were performed using the Tensor Network Python (TeNPy) package developed by Johannes Hauschild and Frank Pollmann @Hauschild18, and they were run on the FASRC Cannon and Odyssey clusters supported by the FAS Division of Science Research Computing Group at Harvard University. #strong[Author contributions:] G.S., H.L., A.K., S.E., T.T.W., D.B., and A.O. contributed to building the experimental setup, performed the measurements, and analyzed the data. R.V., H.P. and A.V. contributed to developing methods for detecting QSL correlations, performed numerical simulations and contributed to the theoretical interpretation of the results. M.K. and R.S. contributed to the theoretical interpretation of the results. All work was supervised by S.S., M.G., V.V., and M.D.L. All authors discussed the results and contributed to the manuscript. #strong[Competing interests:] M.G., V.V., and M.D.L. are co-founders and shareholders of QuEra Computing. A.O. is a shareholder of QuEra Computing.

#pagebreak()
#align(center)[#text(14pt, weight: "bold")[Supplementary Materials]]

#v(1em)

#counter(math.equation).update(0)
#set figure(numbering: n => "S" + str(n - 5))
#set math.equation(numbering: "(S1)")

= EXPERIMENTAL SYSTEM <sec:expt>

Our experiments make use of the second generation of the atom array setup, described previously in @Ebadi2020. In our experiments, atoms are excited to Rydberg states using a two-photon excitation scheme, consisting of a 420 nm laser from the ground state $5S_(1/2)$ to the intermediate state $6P_(3/2)$, and a 1013 nm laser from the intermediate state to the Rydberg state $70S_(1/2)$. Details of both laser systems are presented in Ref.~@Ebadi2020.

In the present work, we tune the lasers to have a detuning of $delta = 2 pi times -450$ MHz from the intermediate $6P_(3/2)$ state, where the 420 nm laser is red-detuned from the intermediate state. The 1013 nm laser is always applied at maximum optical power ($∼ 3$ W total on the atoms), and results in a single-photon Rabi frequency $Omega_"1013" = 2 pi times 50$ MHz. The 420 nm laser power varies depending on the protocol. During the quasi-adiabatic preparation of the dimer phase, we apply the 420 nm light at low power, which reduces the two-photon Rabi frequency and therefore increases the blockade radius to the target $R_b / a = 2.4$. This low power setting consists of a total of $∼ 0.5$ mW on the atoms, with a single-photon Rabi frequency $Omega_"420" = 2 pi times 25$ MHz. During the quasi-adiabatic preparation, we therefore have a two-photon Rabi frequency of $Omega = Omega_"420" Omega_"1013" / (2 delta) = 2 pi times 1.4$ MHz (details of $Omega(t)$ and $Delta(t)$ used for state preparation are reported in @fig:CubicSweep). Under these conditions, we estimate the rate of off-resonant scattering from $|g⟩$ due to the 420 nm laser to be $∼ 1 / (150 "µs")$, and the decay rate of $|r⟩$ to be $1 / (80 "µs")$ (including radiative decay, blackbody stimulated transitions, and off-resonant scattering from the 1013 nm laser). State detection fidelity for both ground state and Rydberg atoms is $99%$ @Ebadi2020.

// [figvision] figures/cubic_sweep.png
// The panel is a line plot with time from 0.0 to 2.5 microseconds on the horizontal axis. The left blue axis
// plots Delta over 2 pi from minus 9 to plus 9 megahertz. The right red axis plots Omega over 2 pi from 0.0 to
// 1.5 megahertz. The blue detuning trace stays at minus 9 MHz until 0.5 microseconds, then rises smoothly in an
// S shape to plus 9 MHz at 2.5 microseconds. The red Rabi-frequency trace ramps linearly from zero to 1.5 MHz
// over the first 0.5 microseconds and remains constant thereafter. The curves depict the quasi-adiabatic control
// sequence for state preparation.
#figure(placement: auto, 
  image("figures/cubic_sweep.png", width: 70%),
  caption: [
    #strong[Quasi-adiabatic state preparation.] $Omega(t)$ and $Delta(t)$ used for state preparation. To probe the phase diagram at different $Delta$, we stop the cubic sweep at different endpoints and correspondingly turn off $Omega$.
  ]
) <fig:CubicSweep>

To measure the $X$ operator, following the dimer phase preparation, we apply short quenches at significantly higher blue power. This high power setting consists of a maximum power of $∼ 100$ mW on the atoms, corresponding to a single-photon Rabi frequency $Omega_"420" = 2 pi times 360$ MHz. The corresponding two-photon Rabi frequency is $Omega = 2 pi times 20$ MHz, and $R_b / a = 1.53$. In this configuration, the 420 nm laser introduces a substantially larger light shift on the Rydberg transition of $2 pi times 36$ MHz. To avoid systematic offsets in the effective detuning from resonance, we separately calibrate the resonance condition at both low power and high power. The 420 nm laser amplitude is controlled using a double-pass AOM with a rise time of $∼ 10$ ns. In the ideal model for the quench, the optimal quench time would be $tau = 4 pi / (3 Omega sqrt(3)) = 19$ ns for the high-power Rabi frequency. However, the $10$ ns rise time extends the necessary quench time to the experimentally optimized $∼ 30$ ns. We note that during the rise time, the laser power is increasing to its maximum value, leading to deviations from the ideal model for the quench; this may contribute to a reduction in the measured value of $X$-string parities.

Throughout this work, measurements of $Z$ and $X$ parities are averaged over identical loops, including reflection and rotation symmetries, across the system. However, loops which touch the edge of the system are excluded to avoid boundary effects. Error bars are calculated as the standard error of the mean as $sigma(P) / sqrt(R)$, where $R$ is the number of repetitions and $sigma(P)$ is the standard deviation of the parity $P$, which is the average over all identical loops for each repetition.

= BASIS ROTATION FOR $X$ AND $Z$ PARITY LOOPS <sec:basis>

The basis rotation used to measure $X$ parity loops is applied with a reduced blockade radius which, in the ideal limit, removes interactions between separate triangles while maintaining a hard blockade constraint on Rydberg excitations within single triangles. The rotation can therefore be understood by its action on individual fully-blockaded triangles. The Hilbert space for each triangle is four-dimensional, allowing for either zero Rydberg excitations, or one Rydberg excitation on any of the three links. Taking the four basis states $T_0, T_1, T_2, T_3$ shown in @fig:basis, the Hamiltonian for the quench in the limit of perfect intra-triangle blockade is described by the following matrix:

$ H = (Omega / 2) mat(0, -i, -i, -i; i, 0, 0, 0; i, 0, 0, 0; i, 0, 0, 0) $ <eq:QuenchHamiltonianMatrix>

#figure(
  [#include "figures/basis-states.cetz.typ"],
  caption: [
    The four basis states of a fully-blockaded triangle: no Rydberg excitation ($T_0$), or a single Rydberg excitation (dimer, highlighted in red) on the bottom ($T_1$), left ($T_2$), or right ($T_3$) link.
  ]
) <fig:basis>

The basis rotation shown in Fig. 3C of the main text, which relates $X$ and $Z$ parity under evolution through this quench Hamiltonian @eq:QuenchHamiltonianMatrix, was proven in Ref.~@Ruben2020 by direct computation. Here we provide an alternative derivation. Firstly, we note that the $Z$ operator, acting on the upper two edges of a triangle, and the $X$ operator, acting on the lower edge of a triangle, defined in Figs. 2, 3 of the main text and illustrated in @fig:zx, are given by:

#figure(
  [#include "figures/zx-operator.cetz.typ"],
  caption: [
    The diagonal $Z$ parity operator (a dashed string crossing the two upper edges of a triangle) and the off-diagonal $X$ parity operator (a wavy string along the lower edge).
  ]
) <fig:zx>

$ Z &= mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1) \
  X &= mat(0, -1, 0, 0; -1, 0, 0, 0; 0, 0, 0, 1; 0, 0, 1, 0) $

The $X$ and $Z$ parity operators can be mutually diagonalized by changing to an appropriate symmetrized basis:

#align(center)[
  #table(
    columns: 3,
    align: center,
    table.header[
      [$"Basis state"$], [$Z$], [$X$],
    ],
    [$|0⟩ = T_0 + T_1$], [$+1$], [$-1$],
    [$|1⟩ = T_2 + T_3$], [$-1$], [$+1$],
    [$|2⟩ = T_0 - T_1$], [$+1$], [$+1$],
    [$|3⟩ = T_2 - T_3$], [$-1$], [$-1$],
  )
]

In this basis, the quench Hamiltonian @eq:QuenchHamiltonianMatrix is expressed as:

$ H = (Omega / 2) mat(0, i, -i, 0; -i, 0, -i, 0; i, i, 0, 0; 0, 0, 0, 0) $ <eq:rot>

This Hamiltonian generates cyclic permutations among the basis states $|0⟩$, $|1⟩$, and $|2⟩$, while leaving $|3⟩$ invariant. The permutation $|0⟩ -> |1⟩ -> |2⟩ -> |0⟩$ maps the $X$ eigenvalue to the $Z$ eigenvalue for each initial state. Moreover, the invariant state $|3⟩$ has both $X = Z = -1$, so it automatically satisfies the target eigenvalue mapping. Thus, after an appropriate evolution time corresponding to a single cyclic permutation ($tau = 4 pi / (3 sqrt(3) Omega)$), all $X$ eigenvalues have been mapped to $Z$ eigenvalues, which is diagonal in the measurement basis. Formally, this can be expressed as:

$ X = e^(i H tau) Z e^(-i H tau) $

We further note that this relationship holds also for parity operators defined on other sides of the triangle, e.g., $X' = e^(i H tau) Z' e^(-i H tau)$. Large $X$ parity strings or loops can be decomposed in terms of their action on individual triangles, and since the basis rotation acts on each triangle individually, this extends the mapping from $X$ strings to corresponding dual $Z$ strings in the rotated basis, as illustrated in @fig:DualLoops.

// [figvision] figures/X_dual_loops.png
// The figure has one panel. It is a schematic diagram showing a network with dual and closed loops. The network
// consists of grey lines forming triangles and hexagons with grey dots at the intersections. There are four
// series of loops: a dashed blue loop and a wiggly blue loop on the left, and a dashed red loop and a wiggly
// orange loop on the right. The loops are centered on the hexagons and have no specific axes or units. The trend
// or message is that dual loops (dashed lines) and closed loops (solid wiggly lines) can coexist in the same
// network. The objects are the network lines and dots, and the loops with different colors and line styles. The
// layout shows the loops embedded within the network structure.
#figure(placement: auto, 
  image("figures/X_dual_loops.png", width: 75%),
  caption: [
    #strong[Dual $Z$ and $X$ loops.] Examples of dual $Z$ loops (dashed lines) to closed $X$ loops (solid wiggly lines).
  ]
) <fig:DualLoops>

= SUPPLEMENTAL EXPERIMENTAL DATA <sec:suppdata>

== Mean Rydberg density and boundary effects <sec:meandens>

After preparing the dimer phase for $Delta / Omega ∼ 1/4$, we observe a Rydberg excitation density in the bulk of $⟨n⟩ ∼ 1/4$. The sites close to the boundary of the system, however, are dominated by edge effects. In @fig:MeanRydbergDensities, we show the Rydberg excitation density site-by-site, and demonstrate that the edge effects only permeate two to three layers into the bulk before the $⟨n⟩ ∼ 1/4$ plateau is reached. In arrays with a topological defect, the hole forms an inner boundary and similarly induces edge effects (@fig:MeanRydbergDensities C,D). These observations allow us to determine the minimum system sizes that may be used such that the physics of the system is not dominated by boundary effects, resulting in our choice of the 219-atom arrays used in this work.

// [figvision] figures/MeanRydbergDensities.png
// A. This is a two-dimensional schematic coloured by site-by-site mean Rydberg density. The plot shows a full
// array of sites in a circular pattern. Each site is represented by two overlapping circles, with the colour of
// the filled part indicating the Rydberg density, ranging from 0.0 (white) to 0.5 (dark brown). The sites are
// arranged in a honeycomb-like structure. There are no axes or numerical labels. C. This is similar to panel A,
// but the array has a hole in the centre. The sites are arranged in the same honeycomb-like structure, but with
// a circular gap in the middle. B. This is a line plot of mean Rydberg density versus layer distance from the
// outer boundary. The y-axis ranges from 0.0 to 0.6, and the x-axis ranges from 1 to 9. There is one series of
// data points connected by lines, shown in orange. Two insets show schematics of a full array and an array with
// a hole, with red filled circles indicating Rydberg excitations. A horizontal grey dashed line indicates a mean
// density of 1/4. D. This is similar to panel B, but for an array with a hole. The y-axis and x-axis have the
// same ranges as panel B. There is one series of data points connected by lines, shown in orange. An inset shows
// a schematic of an array with a hole, with red filled circles indicating Rydberg excitations. A horizontal grey
// dashed line indicates a mean density of 1/4.
#figure(scope: "parent", placement: auto, 
  image("figures/MeanRydbergDensities.png", width: 75%),
  caption: [
    #strong[Site-by-site mean Rydberg density]. We measure the mean Rydberg excitation density $⟨n⟩$ site-by-site in the dimer phase with $Delta / Omega = 4$ for both full arrays (#strong[A]) as well as arrays with a hole (#strong[C]). (#strong[B,D]) We then plot the corresponding mean density layer-by-layer as a cross-section from the edge into the bulk, showing that within the outer two to three layers, the bulk settles into the $⟨n⟩ ∼ 1/4$ phase.
  ]
) <fig:MeanRydbergDensities>

== Lack of spatial order within spin-liquid phase <sec:spatialorder>

The lack of spatial order in the spin-liquid phase is a key feature that separates this phase from possible nearby solid phases. At the simplest level, spatial order can be assessed by looking at individual projective measurements of the atomic states in the ensemble. We show three examples of such snapshots in @fig:Snapshots, where the measured states of individual atoms are represented as small circles on the links of the kagome lattice, filled or unfilled indicating a Rydberg state or a ground state, respectively. In the mapping to a monomer-dimer model, we can alternatively consider the vertices of the kagome lattice in terms of how many adjacent Rydberg excitations (dimers) are present. In practice, vertices can have zero attached dimers (so-called monomers), a single attached dimer (corresponding to an ideal dimer covering), or more attached dimers (violating the long-range blockade constraint). In @fig:Snapshots, we additionally color each vertex according to the number of such attached dimers. The widespread abundance of vertices connected to a single dimer (Fig. 1E and snapshots from @fig:Snapshots) signifies occupation of the dimer phase.

// [figvision] figures/Snapshots.png
// A. This is a schematic diagram of a kagome lattice with binarized atom readout shown by small circles on the
// links. The vertices of the lattice are colored according to the number of adjacent atoms: monomer (blue),
// dimer (red), and double-dimer (green). The x and y axes are not explicitly labeled but appear to represent the
// lattice structure. The series shown are: small open and filled circles for atom readout, and colored large
// circles for vertex types. There are no line styles, but the colors and symbols convey the information. The
// trend shows a mostly uniform distribution of dimers with some monomers and a few double-dimers. B. This panel
// is similar to A, with the same lattice structure, vertex coloring, and atom readout. The distribution of
// monomers, dimers, and double-dimers appears different from A, with more double-dimers present. The same colors
// and symbols are used, with no line styles. The trend shows a different configuration of the dimer phase with
// more double-dimers than A. C. This panel shows another configuration of the kagome lattice with a different
// distribution of monomers, dimers, and double-dimers compared to A and B. There are more double-dimers present,
// arranged in a horizontal line. The same colors and symbols are used, with no line styles. The trend shows a
// distinct pattern of double-dimers, indicating a variation within the dimer phase.
#figure(scope: "parent", placement: auto, 
  image("figures/Snapshots.png", width: 100%),
  caption: [
    #strong[Snapshots in the dimer phase.] Three sample experimental realizations within the dimer phase at $Delta / Omega = 4.3$. The binarized atom readout is shown by small circles on the links of the kagome lattice, with open circles denoting $|g⟩$ and filled circles denoting $|r⟩$. Vertices of the kagome lattice (large circles) are colored according to the number of adjacent atoms in $|r⟩$ to visually accentuate which parts of the system are properly covered with dimers.
  ]
) <fig:Snapshots>

// [figvision] figures/Correlations2.png
// The figure shows a two-dimensional map of correlations. The plot is a schematic diagram with a hexagonal
// lattice of circles connected by gray lines, with some colored circles overlaid. There are no axes, but the
// colorbar ranges from -0.10 to 0.10 with units of n_i n_j - n_i n_j . The grey lines represent connections
// between atoms and the black circles represent individual atoms. The colored circles represent the correlation
// between the central atom and all other atoms, with red indicating positive correlation and blue indicating
// negative correlation. The trend shows anticorrelations between the central atom and the other two atoms in the
// same triangle, as well as with atoms in the adjacent triangles.
#figure(
  image("figures/Correlations2.png", width: 65%),
  caption: [
    #strong[Density correlations between individual Rydberg excitations.] We directly measure the Rydberg density-density correlator $⟨n_i n_j⟩ - ⟨n_i⟩ ⟨n_j⟩$ between a central atom and all other atoms in the system. We observe anticorrelations between the central atom and the other two atoms in the same triangle, as well as with atoms in the adjacent triangles, given by the choice of blockade radius $R_b$. Longer range correlations vanish. This data was taken at $Delta / Omega = 4.3$.
  ]
) <fig:Correlations>

Moreover, spatial correlations can be used to look for solid-type spatial order (@fig:Correlations). We measure Rydberg density-density correlations on the atomic array and find non-vanishing correlations for atoms within a single triangle or between adjacent triangles, with vanishing correlations over longer distances. This observation confirms the lack of spatial order in the dimer phase we prepare.

== Phase dependence of quench <sec:phasedep>

The quench which induces the basis rotation for measuring $X$ parity is implemented by rapidly switching the laser detuning to $Delta_q = 0$ following the preparation of the dimer phase, and simultaneously changing the phase of the laser field by $pi / 2$. This choice of phase approximately maximizes the $X$ parity signal, as measured by applying the same quench duration but with variable phase (@fig:PhaseDependence A).

// [figvision] figures/X_phase_dependence.png
// A. This panel shows a plot. The x-axis represents ϕ and ranges from -π/2 to π/2. The y-axis represents ⟨X⟩ and
// ranges from 0.04 to 0.11. There is one series with teal circles and vertical error bars. The series starts at
// approximately (ϕ,⟨X⟩) = (-π/2, 0.045), decreases to a minimum of approximately 0.04 at ϕ = -π/3, then
// increases to a maximum of approximately 0.11 at ϕ = π/2. The trend shows that ⟨X⟩ increases with ϕ. B. This
// panel shows a plot. The x-axis represents Δ/Ω2 and ranges from 1.5 to 6. The y-axis represents ⟨X⟩ and ranges
// from 0.00 to 0.20. There are two series: one with red filled circles for ϕ = π/2 and one with pink open
// circles for ϕ = 0. The series for ϕ = π/2 starts at approximately (Δ/Ω2,⟨X⟩) = (2, 0.15), increases to a
// maximum of approximately 0.20 at Δ/Ω2 = 2.9, then decreases to approximately 0.02 at Δ/Ω2 = 6. The series for
// ϕ = 0 starts at approximately (Δ/Ω2,⟨X⟩) = (2, 0.00), increases to approximately 0.07 at Δ/Ω2 = 3, then
// decreases to approximately 0.00 at Δ/Ω2 = 6. The trend shows that ⟨X⟩ has a peak for ϕ = π/2 and a smaller
// increase for ϕ = 0.
#figure(placement: auto, 
  image("figures/X_phase_dependence.png", width: 100%),
  caption: [
    #strong[Phase dependence of quench.] (#strong[A]) After preparing the dimer phase at $Delta / Omega = 4$, we quench for the pre-calibrated time $tau$ with a variable quench phase and measure the resulting $X$ loop parity around a single hexagon. (#strong[B]) For fixed quench phase $phi = pi / 2$ or $phi = 0$, we measure the $X$ parity after the pre-calibrated quench time as a function of the final detuning of the cubic sweep. The data for $phi = pi / 2$ is reproduced from Fig. 3F of the main text.
  ]
) <fig:PhaseDependence>

The phase change can be understood by interpreting it as evolution under $sum_i n_i$ for time $phi$, followed by a fixed-phase quench. Since the quench ultimately measures coherences between different components of the wavefunction, this phase change only matters insofar as it changes the relative phases between components. We note here that coherences between perfect dimer coverings will be unchanged by the phase change, since all perfect dimer coverings have the same number of Rydberg excitations. A wavefunction which is the superposition of all perfect dimer coverings, then, would be insensitive to the choice of phase for the quench. However, in our system there is a finite density of both monomers and vertices with two attached dimers. An $X$ loop crossing through a monomer creates a double-dimer at that vertex, and these types of component pairs are additionally included in our $X$ parity measurements. Since the coupled states with a monomer and a double-dimer have different numbers of Rydberg excitations, these coherences #emph[are] phase-sensitive. Comparing the measured $X$ parity for $phi = pi / 2$ and $phi = 0$ as we scan across the phase diagram (@fig:PhaseDependence B), we find that the first has larger amplitude and extends more strongly into the trivial phase, consistent with the expectation from theoretical calculations @Ruben2020.

== $Z$ parity measurements with improved state preparation <sec:zimp>

All data shown in the main text is taken with intermediate detuning $delta = 2 pi times -450$ MHz (see @sec:expt) for the two-photon Rydberg excitation. This choice is to enable our largest dynamic range of Rabi frequencies, which is crucial for being able to perform state preparation at low $Omega$ and then apply the quench at large $Omega$ with reduced blockade radius. Larger intermediate detuning would require performing state preparation at an even lower initial Rabi frequency, where we observe worse results. However, the small intermediate detuning introduces stronger decoherence due to increased spontaneous emission from the intermediate state. To supplement these results, we additionally perform state-preparation and measure $Z$ parity at an increased intermediate detuning of $delta = 2 pi times 1$ GHz. To further optimize this state preparation, we use a larger Rabi frequency $Omega = 2 pi times 1.7$ MHz and a smaller lattice spacing $a = 3.7$ µm, which should improve adiabaticity during the preparation. In this configuration, we indeed observe larger $Z$ loop parities (@fig:Z_1GHz), but we cannot measure corresponding $X$ loop parities. This highlights that the large dynamical range required for the measurement of the $X$ operator is one of the main technical challenges of this experimental work. At the same time, it shows that with more available laser power for Rydberg excitation, the quality of state preparation can be improved by working at this increased intermediate detuning and higher Rabi frequencies (and with smaller lattice spacings to achieve the same blockade radius).

// [figvision] figures/Z_1GHz.png
// ## Panel a This is a plot showing Z versus /. The y-axis ranges from -0.05 to 0.20 and the x-axis from 1.5 to
// 7. There are four series: red circles, blue circles, green circles, and orange circles. Each series consists
// of solid lines connecting the circles. The red series starts at Z = 0.02 and / = 1.5, increases to a maximum
// of Z = 0.20 at / = 4.5, then decreases to Z = 0.08 at / = 7. The other series have smaller amplitudes. The
// trend shows that the red series has a peak at / = 4.5. ## Panel b This is a schematic diagram of a hexagonal
// lattice. The lattice has gray dots connected by gray lines, forming a honeycomb pattern. Superimposed on the
// lattice are four closed loops: red dashed, blue dashed, green dashed, and orange dashed. Each loop encircles a
// set of gray dots. The loops are centered at different locations on the lattice and have different radii. The
// layout shows the relative positions and sizes of the loops on the lattice.
#figure(placement: auto, 
  image("figures/Z_1GHz.png", width: 75%),
  caption: [
    #strong[$Z$ loop parity with improved state preparation.] We measure $Z$ on closed loops with a larger intermediate state detuning for the two-photon Rydberg excitation to reduce spontaneous emission rates, and with a larger Rabi frequency during the state preparation. We observe larger parities than in the comparable Fig. 2 of the main text.
  ]
) <fig:Z_1GHz>

== Correlations between parity loops <sec:loopcorr>

String operators are used in this work to assess long-range topological order. However, the large loops which are studied can be decomposed into the product of smaller loops around sub-regions: for example, $X$ loops can be decomposed into the product of enclosed hexagons. To demonstrate that the parity measured on large loops is indeed indicative of long-range order, rather than emerging from the ordering of each hexagon individually, we extract correlations between the separate parity loops which comprise larger loops.

We first study parity loops which enclose adjacent hexagons of the kagome lattice. The minimal such $X$ parity loop is exactly equal to the product of the parity around the two enclosed hexagons. Denoting by $X_i$ the $X$-parity loop around hexagon $i$, the connected correlator of the parity around these two inner hexagons is

$ G^((2))_X = ⟨X_1 X_2⟩ - ⟨X_1⟩ ⟨X_2⟩ $

Similarly, $Z$ loops which enclose two hexagons decompose into the product of $Z$ parity around the two hexagons, multiplied additionally by the parity around the central interior vertex (which should always be -1 in a dimer covering). We define the analogous two-hexagon connected correlator for $Z$, with $Z_i$ the corresponding two-hexagon $Z$ loop, as

$ G^((2))_Z = ⟨Z_1 Z_2⟩ - ⟨Z_1⟩ ⟨Z_2⟩ $

Higher-order connected correlations between three adjacent hexagons which form a triangle further highlight nonlocal correlations in this system. We define the connected three-point correlator @rispoli_quantum_2019 which subtracts away contributions from underlying two-point correlations as

$ G^((3))_X = ⟨X_1 X_2 X_3⟩ - G^((2))_(X,12) ⟨X_3⟩ \
  quad - G^((2))_(X,23) ⟨X_1⟩ - G^((2))_(X,31) ⟨X_2⟩ - ⟨X_1⟩ ⟨X_2⟩ ⟨X_3⟩ $ <eq:g3>

where $G^((2))_(X, i j)$ is the connected correlator for hexagons $i, j$. Third order connected correlators for $Z$ parity are analogously defined.

As shown in @fig:Loops_correlators, we observe nonzero two-hexagon and three-hexagon connected correlations within the dimer phase region, indicating that the parity measured on double-hexagon and triple-hexagon loops does not emerge from independently determined parity around each interior subregion, but instead emerges due to nontrivial correlations over longer length scales.

// [figvision] figures/connected_correlators.png
// A. This panel contains a plot and two schematics. The plot has G_Z^{(n)} on the y-axis, ranging from 0.00 to
// 0.02, and / on the x-axis, ranging from 1 to 7. There are two series: n=2 in blue with circles and n=3 in
// green with diamonds. Both have lines connecting the points with error bars. The trend shows a peak around / =
// 4 for both series, then decreases. The schematics show hexagons with adjacent hexagons; one is blue and
// encloses a pair, the other is green and encloses a triplet. B. This panel also contains a plot and two
// schematics. The plot has G_X^{(n)} on the y-axis, ranging from 0.00 to 0.03, and / on the x-axis, ranging from
// 2 to 6. The series are n=2 in blue with circles and n=3 in green with diamonds, both with lines connecting
// points. The trend shows a peak around / = 2 then decreases for both. The schematics show star-like shapes; one
// is blue and corresponds to pairs, the other is green and corresponds to triplets of adjacent hexagons.
#figure(placement: auto, 
  image("figures/connected_correlators.png", width: 100%),
  caption: [
    #strong[Correlations between parity loops.] We measure two-point and three-point connected correlations between parity around adjacent hexagons. (#strong[A]) $Z$ parity correlations between loops which enclose pairs and triplets of adjacent hexagons. (#strong[B]) $X$ parity correlations between pairs and triplets of adjacent hexagons.
  ]
) <fig:Loops_correlators>

== Quasiparticle excitations <sec:quasipart>

Within the dimer-monomer model, quasiparticle excitations of two types are created by the application of open $X$ and $Z$ strings: these are the electric ($e$) and magnetic ($m$) anyons, respectively. Open $X$ strings create monomers (or double-dimers) at their endpoints, and thus $e$-anyons are identified as defects in the dimer covering.

// [figvision] figures/m-anyons.png
// Panel a: A schematic diagram showing a hexagonal lattice with red ellipses representing dimers. The layout of
// the lattice and the connections between the dimers are shown. There are no axes or units. The red ellipses
// represent the dimer states. There are no symbols or line styles other than the black lines forming the lattice
// and the red ellipses. There are no annotations or labels. The trend or message is that this is a
// representation of a quantum spin liquid (QSL) state. Panel b: A schematic diagram showing a hexagonal lattice
// with red ellipses representing dimers and a green loop labeled X1. The layout of the lattice and the
// connections between the dimers are shown. There are no axes or units. The red ellipses represent the dimer
// states, and the green loop represents an open string. The green loop is labeled X1. There are no other symbols
// or line styles other than the black lines forming the lattice, the red ellipses, and the green loop. There are
// no annotations or labels other than X1. The trend or message is that the open string acts on the superposition
// of dimer states. Panel c: A schematic diagram showing a hexagonal lattice with red ellipses representing
// dimers and a blue loop labeled X2. The layout of the lattice and the connections between the dimers are shown.
// There are no axes or units. The red ellipses represent the dimer states, and the blue loop represents another
// open string. The blue loop is labeled X2. There are no other symbols or line styles other than the black lines
// forming the lattice, the red ellipses, and the blue loop. There are no annotations or labels other than X2.
// The trend or message is that another open string acts on the superposition of dimer states. Panel bottom left:
// A schematic diagram showing a hexagonal lattice with red ellipses representing dimers and yellow dashed lines.
// The layout of the lattice and the connections between the dimers are shown. There are no axes or units. The
// red ellipses represent the dimer states, and the yellow dashed lines represent the action of an open string on
// the superposition. There are no symbols or line styles other than the black lines forming the lattice, the red
// ellipses, and the yellow dashed lines. There are no annotations or labels. The trend or message is that the
// open string acts on the superposition of dimer states, resulting in a change in the dimer configuration. Panel
// middle left: A schematic diagram showing a hexagonal lattice with red ellipses representing dimers, yellow
// dashed lines, and an orange "m". The layout of the lattice and the connections between the dimers are shown.
// There are no axes or units. The red ellipses represent the dimer states, the yellow dashed lines represent the
// action of an open string on the superposition, and the orange "m" represents a specific configuration. There
// are no symbols or line styles other than the black lines forming the lattice, the red ellipses, the yellow
// dashed lines, and the orange "m". There are no annotations or labels other than the orange "m". The trend or
// message is that the open string acts on the superposition of dimer states, resulting in a change in the dimer
// configuration. Panel right: A series of schematic diagrams showing hexagonal lattices with red ellipses
// representing dimers and orange "m". The layout of the lattice and the connections between the dimers are
// shown. There are no axes or units. The red ellipses represent the dimer states, and the orange "m" represents
// specific configurations. The diagrams show a series of configurations with plus and minus signs. There are no
// symbols or line styles other than the black lines forming the lattice, the red ellipses, and the orange "m".
// There are no annotations or labels other than the orange "m" and the plus and minus signs. The trend or
// message is that the open string acts on the superposition of dimer states, resulting in a change in the dimer
// configuration with specific phases.
#figure(placement: auto, 
  image("figures/m-anyons.png", width: 100%),
  caption: [
    #strong[Magnetic anyons.] The dimer states contained in $|ψ_"QSL"⟩$ are connected to each other by the application of $X$ on closed loops. When an open $Z$ string acts on the superposition, the dimer states connected by an open loop that encloses one end of the string ($X_1$) acquire opposite signs. The $m$-anyons generated at the endpoints of the string are then detected by $X$ loops that enclose one of them, e.g. $⟨X_1⟩ = -1$, while $⟨X_2⟩ = +1$ is unperturbed.
  ]
) <fig:m_anyons>

Open $Z$ strings on the other hand impart a relative phase between various dimer configurations, corresponding to $m$-anyons. To understand $m$-anyons, we first note that all dimer coverings in the QSL superposition are related to one another by the application of properly chosen closed $X$ loops (first row of @fig:m_anyons). An open $Z$ string applied to the QSL state, then, results in different dimer coverings acquiring $±$ phase factors according to the number of dimers crossed by the string. Whenever two dimer configurations are related by a closed $X$ loop which encloses one of the endpoints of the $Z$ string, they acquire opposite signs (@fig:m_anyons). After the application of the open $Z$ string, then, $⟨X⟩$ is inverted for any closed loop around one endpoint of the $Z$ string, analogous to how $⟨Z⟩$ around the endpoint of an open $X$ string (a defect) is inverted. Since open $Z$ strings terminate in the hexagons of the kagome lattice, we associate the resulting magnetic ($m$) anyons as living on these hexagons, and the $X$ parity around hexagons therefore detects the presence of $m$-anyon excitations.

In @fig:Loops_scaling we report the $Z$ and $X$ loop parities rescaled with area and perimeter law for different values of $Delta$ in the relevant range of detunings. We observe that the excellent perimeter law scaling of $X$ reported in Fig. 4I of the main text extends over the entire range of $Delta$. For $Z$ instead we find that the initial approximate area law scaling converges towards a perimeter law for large loops.

// [figvision] figures/Area_perim_collapse.png
// Panel A is a schematic diagram of a finite hexagonal lattice formed by grey triangular bonds. Five closed
// loops are drawn over the lattice in dashed lines of different colours: a small red loop near the upper left, a
// large yellow loop near the upper right, a light blue loop on the left, a green loop on the right, and a yellow
// loop along the bottom edge. The loops enclose different numbers of sites and illustrate the loop geometries
// analysed later. The panel contains no axes. Panel B is a line plot with circular markers showing the rescaled
// parity ⟨Z⟩ divided by area on the vertical axis, ranging from 0.6 to 0.9, against detuning Δ/Ω on the
// horizontal axis from 3.0 to 5.0. Four series in red, blue, green and yellow are plotted. The yellow series
// starts near 0.72 at 3.0 with a large error bar, peaks around 0.80 at 3.75, and falls to about 0.74 at 5.0. The
// red series remains lowest near 0.70 to 0.71. Blue and green lie between them, rising to a maximum near 3.75
// before slightly decreasing. Panel C is a line plot with circular markers plotting the rescaled parity ⟨Z⟩
// divided by perimeter on the vertical axis, from 0.6 to 0.9, versus detuning Δ/Ω from 3.0 to 5.0. Four series
// in red, blue, green and yellow are shown. The red series is highest and flattest, staying around 0.81 to 0.85.
// The blue series rises from about 0.76 to roughly 0.81 and levels off. The green series climbs from
// approximately 0.73 to about 0.80. The yellow series begins near 0.70 with a large downward error bar, rises to
// roughly 0.77, then drops to about 0.73 at 5.0 with another large error bar. Panel D is a line plot with
// circular markers showing the rescaled parity ⟨X⟩ divided by perimeter on the vertical axis, ranging from 0.75
// to 0.90, against detuning Δ/Ω on the horizontal axis from 3.00 to 4.00. Four series in yellow, green, blue and
// red are plotted but overlap closely throughout. All points begin near 0.86 to 0.87 at 3.00 and gradually
// decrease to roughly 0.82 to 0.83 at 4.00. The curves are nearly monotonic and almost indistinguishable,
// indicating consistent perimeter law scaling for the X operator across the displayed detuning range. No large
// error bars are visible.
#figure(placement: auto, 
  image("figures/Area_perim_collapse.png", width: 100%),
  caption: [
    #strong[Scaling of $Z$ and $X$ parities with the loop size.] We calculate the rescaled parities $⟨Z⟩^(1/"area")$ (#strong[B]), $⟨Z⟩^(1/"perim")$ (#strong[C]) and $⟨X⟩^(1/"perim")$ (#strong[D]) for the different loop sizes in (#strong[A]). While for the $X$ operator we observe a very good perimeter law scaling on the entire range of detunings, for $Z$ we observe an approximate area law scaling for small loop sizes that finally converges towards a perimeter law scaling.
  ]
) <fig:Loops_scaling>

We can shed light on the scaling behavior observed in the experiment by comparing it with the expected scaling from theory. Let us first note that the generic equilibrium expectation for both string operators is a perimeter law scaling @Gregor11. This can be seen as a consequence of the mutual statistics of $e$- and $m$-anyons: since there will be virtual fluctuations of both anyons, these will induce correlations#super[\*] for anyons of the other type, leading to a perimeter law. This generic expectation of a perimeter law is well-known in the (lattice) gauge theory community, and can be related to the phenomenon of string breaking @Fradkin79. Experimentally, we observe a perimeter law for $X$-loops and an (approximate) area law for $Z$-loops (with substantial deviations for larger loop sizes). This can be understood by noting that we enter the QSL-like state from the trivial phase, which can be interpreted as a condensate of $e$-anyons (i.e., both closed and open $X$-strings give nonzero correlations): the perimeter law for closed $X$ strings is thus already present in the trivial phase and naturally persists into the QSL-like state (while correlations for the #emph[open] $X$-strings vanish). In contrast, the $Z$-correlations are absent in the trivial phase proximate to the QSL: these are only developed at the quantum critical point, and since we sweep through this at a finite rate, the $Z$-loop correlations are only developed over a characteristic length scale, implying an area law. Numerically, we indeed confirm that $Z$-loop correlations are significantly enhanced upon increasing preparation time (see @sec:theory), consistent with our observations in @fig:Z_1GHz. We note that this imperfect generation of $Z$-loop correlations can be equivalently interpreted as generating a density of $e$-anyon excitations. Dynamically inducing the onset of a QSL and possible meta-stable states are rich phenomena which deserve further detailed study.

#v(0.4em)
#text(8.5pt)[#super[\*] To clarify this further, we note that the monomers (and double-dimers) visible in the experimental snapshots need not to directly correspond to physical excitations, since the ground state will have so-called 'virtual' fluctuations when it is not in an idealized fixed-point state. These can be interpreted as correlated $e$-anyons. In contrast, in an ideal $ℤ_2$ spin liquid, #emph[physical] $e$-anyons will be uncorrelated---since this is a defining property of the deconfined phase where $e$-anyons move independently at sufficiently large distances.]

== Additional data for arrays with nontrivial topology <sec:topodata>

The distinction between two distinct topological sectors can be better understood by looking at the transition graphs between pairs of dimer states @Sutherland88. These are built by superimposing two dimer coverings and removing the overlapping dimers (@fig:TopSectors). The dimer states belong to opposite topological sectors if the remaining dimers form an odd number of closed loops around the hole, indicating the set of non-local moves required to transform one into the other.

// [figvision] figures/TopologicalSectors.png
// Top left panel, labeled |D₁⟩ under the heading TOPOLOGICAL SECTOR 0. This schematic depicts a finite hexagonal
// lattice patch enclosed in a hexagonal boundary, with a solid gray upward-pointing triangle at the center
// denoting a hole. Red ellipses are placed on selected lattice bonds to represent occupied dimers, while
// unoccupied bonds are thin black lines. No coordinate axes, ranges, or units are shown. The dimer configuration
// covers the lattice but does not contain a closed loop winding around the central hole. Top middle panel,
// labeled |D₂⟩, also under TOPOLOGICAL SECTOR 0. It uses the identical hexagonal lattice geometry and central
// gray triangular hole as the previous panel. Red ellipses mark a different subset of bonds as occupied dimers,
// representing an alternative covering in the same sector. Plain black lines indicate unoccupied lattice edges.
// There are no axes or numerical labels. Compared with |D₁⟩, the local dimer positions change, but the global
// topological class remains sector 0. Top right panel, labeled |D₃⟩ under the heading TOPOLOGICAL SECTOR 1. It
// shows the same finite hexagonal lattice and central gray triangular hole as the other two states. Red ellipses
// indicate the dimer occupations for this covering, which belongs to the opposite topological sector from |D₁⟩
// and |D₂⟩. Unoccupied bonds remain thin black lines. No axes, scales, or units appear in the panel. The label
// explicitly assigns this state to sector 1 rather than sector 0. Bottom left panel, labeled |D₁⟩ ∪ |D₂⟩ and
// connected by a curly brace underneath the first two top diagrams. It superimposes the red dimers from |D₁⟩ and
// |D₂⟩ onto one hexagonal lattice with the central gray hole still visible. Multiple disjoint red loops and
// chains appear, clustered near the top edge, the right side, and the bottom boundary, but none forms a
// continuous closed loop around the central triangle. No axes or units are present. Bottom right panel, labeled
// |D₂⟩ ∪ |D₃⟩ and linked by a curly brace under the second and third top diagrams. It superimposes the dimers
// from |D₂⟩ and |D₃⟩ on the same hexagonal lattice with the central gray triangular hole. The red ellipses join
// together to form a single closed loop that encircles the central hole completely, while other red segments
// appear nearby. This loop around the defect visually signals that |D₂⟩ and |D₃⟩ belong to opposite topological
// sectors. No axes or numerical scales are shown.
#figure(placement: auto, 
  image("figures/TopologicalSectors.png", width: 75%),
  caption: [
    #strong[Distinction between topological sectors.] To determine if the three dimer coverings $|D_1⟩$, $|D_2⟩$ and $|D_3⟩$ belong to the same or opposite topological sectors, we build the transitions graphs $|D_1⟩ union |D_2⟩$ and $|D_2⟩ union |D_3⟩$. In the latter we see that the dimers form a closed loop around the hole, highlighting that the two states belong to opposite sectors.
  ]
) <fig:TopSectors>

To demonstrate that the removal of three atoms at the center of the array creates an actual inner boundary, we measure the $Z$ and $X$ operators on strings with both endpoints on the inner or outer boundaries (@fig:SuppHole). In the relevant range of detunings ($3.3 ≤ Delta / Omega ≤ 4.5$) we measure a finite $⟨Z⟩$ and a vanishing $⟨X⟩$ in both cases, indicating that the central hole also generates an effective boundary. This also confirms that the boundaries that are naturally created in our system are of the $m$-type, i.e. $m$-anyons localize on it (hence the finite $⟨Z⟩$) @Ruben2020.

// [figvision] figures/Hole_ZX.png
// Panel A. A schematic on a hexagonal array of gray dots forming a triangular lattice inside a hexagonal outer
// boundary. A central gray inverted triangle marks a hole. A green dashed curve traces an open string around the
// left side of the central hole. A pale green dashed small loop sits near the center-right. A red dashed segment
// runs along the lower-right edge and exits the array. No axes or numerical labels are present. Panel B. The
// same hexagonal lattice with central gray triangle. Solid lines replace the dashed schematics: a green wiggly
// path encircles the left side of the central hole; a pale green small solid loop sits near center-right; a
// thick red solid wiggly line rises from the lower center toward the right edge; a thick orange solid wiggly
// line runs along the bottom-right exterior. No axes. Panel C. A line plot of ⟨Z⟩ versus Δ/Ω. The y-axis spans
// 0.00 to 0.03, the x-axis spans 1 to 7. A red curve with circular markers and vertical error bars follows a
// dashed horizontal line at zero. The series begins near 0.025 at Δ/Ω=1, dips slightly below zero around 2,
// rises to a peak of about 0.025 near 5, then falls to roughly 0.006 at 7. The trend indicates an oscillatory
// response with a minimum near resonance. Panel D. A line plot of ⟨X⟩ versus Δ/Ω. The y-axis spans 0.00 to 0.06,
// the x-axis spans roughly 1.5 to 6. Two series are shown: orange circles start near 0.063 and decay to zero by
// Δ/Ω≈4; red circles start near 0.018 and likewise approach zero by Δ/Ω≈4. Both curves flatten near zero for
// larger detuning, indicating suppression of the X operator away from resonance. Panel E. A line plot of ⟨Z⟩
// versus Δ/Ω. The y-axis spans 0.00 to 0.15, the x-axis spans 1 to 7. Two green series with circular markers are
// plotted. The light green upper curve rises from near zero to a peak of about 0.16 at Δ/Ω≈4.5, then decreases
// to about 0.06 at 7. The dark green lower curve remains small, staying below 0.03 across the range. A dashed
// horizontal line marks zero. Panel F. A line plot of ⟨X⟩ versus Δ/Ω. The y-axis spans 0.00 to 0.15, the x-axis
// spans roughly 1.5 to 6. Two green series with circular markers are shown. The light green upper curve starts
// near 0.16 at low detuning and decays to near zero by Δ/Ω≈4. The dark green lower curve stays around 0.02 and
// also falls to zero by Δ/Ω≈4. A dashed horizontal line marks zero, showing both operators vanish at large
// detuning.
#figure(placement: auto, 
  image("figures/Hole_ZX.png", width: 75%),
  caption: [
    #strong[Boundary-to-boundary string operators.] We measure the $Z$ (#strong[A]) and $X$ (#strong[B]) operators on open strings connecting two points on the outer (#strong[C,D]) or inner (#strong[E,F]) boundaries of the array. Observing the same features for both, we confirm that the small central hole does indeed create an effective inner boundary.
  ]
) <fig:SuppHole>

= NUMERICAL STUDIES <sec:theory>

Below, we report on numerical studies of the Rydberg atom array. We first discuss the zero temperature equilibrium phase diagram, established using density-matrix-renormalization-group (DMRG). Next, we directly simulate the quasi-adiabatic sweep, using both exact diagonalization and dynamical DMRG calculations. To minimize boundary effects due to limitations of numerically accessible system sizes, these calculations are performed on a torus (exact diagonalization) or on an infinite cylinder (DMRG).

== Ground state phase diagram <sec:gs>

To a first approximation, the Hamiltonian in the main text can be described by an effective 'PXP' model @Turner18.

$ H_"PXP" = sum_i ((Omega / 2) P sigma^x_i P - Delta n_i). $ <eq:PXP>

Here, $P$ is a projector onto $|g⟩$ for all sites within the blockade radius $R_b$ of the site $i$. This model approximates the Rydberg Hamiltonian by treating all pairwise interaction energies as either infinite, if within the blockade radius, or zero if beyond. For $R_b = 2.4 a$ (as in the main text), this corresponds to blockading the first three interaction distances. In Ref.~@Ruben2020, it was shown that this 'blockade model' hosts a $ℤ_2$ spin liquid for $1.5 ≤ Delta / Omega ≤ 2$.

To include the full van der Waals interactions, we incorporate $V(r) = Omega (R_b / r)^6$ in the microscopic model within a truncation distance $R_"trunc"$ (beyond which $V(r) = 0$), with $R_b = 2.4 a$. On a technical note, we replace the very strong nearest-neighbor repulsion $V(a) / Omega = (R_b / a)^6 ≈ 191$ by $V(a) = +∞$ by working in an effectively constrained model where any triangle can host at most one dimer. The DMRG @White92 @White93 simulations on cylinder geometries @Stoudenmire12 were performed using the Tensor Network Python (TeNPy) package developed by Johannes Hauschild and Frank Pollmann @Hauschild18. A bond dimension $chi = 1000$ was sufficient to guarantee convergence for the systems and parameters considered.

// [figvision] figures/methods_fig1.png
// Panel (a) is a line plot with dual vertical axes. The left red axis labeled xi runs from 0 to above 10, and
// the right blue axis labeled S runs from 0 to 2. The horizontal axis is Delta/Omega spanning 3.0 to 4.0. Red
// circular markers trace xi, rising to a sharp peak at the left boundary of a gray shaded band, dipping inside,
// forming a smaller secondary bump near the right boundary, then falling. Blue circular markers trace S,
// climbing gradually to a high plateau across the gray band bounded by two vertical dotted lines, then dropping
// steeply after the right boundary. The gray region marks a spin-liquid phase between trivial and
// valence-bond-solid phases. Panel (b) is a line plot with left red axis labeled angle bracket X angle bracket
// BFFM and right blue axis labeled angle bracket Z angle bracket BFFM, both ranging from 0.0 to 1.0. Red
// circular markers begin near 0.4 and decay to zero inside the gray shaded region between two vertical dotted
// lines. Blue circular markers remain near zero through the gray band, then rise sharply to about 0.9 beyond the
// right dotted line. The shaded area denotes the intervening spin-liquid phase. Panel (c) is a line plot with
// left red axis labeled angle bracket X angle bracket circ and right blue axis labeled angle bracket Z angle
// bracket circ, each from 0.0 to 1.0. Red circular markers hover around 0.5 before falling to near zero after
// the right dotted line of the gray band. Blue circular markers stay near zero until entering the gray region,
// then increase sigmoidally to roughly 0.8 within and beyond the band. The gray shaded area indicates the
// spin-liquid phase between two vertical dotted lines. Panel (d) is a line plot with horizontal axis Delta/Omega
// explicitly marked from 3.0 to 4.0. The left red axis xi spans 0 to roughly 12, and the right blue axis S spans
// 0 to 2. Red circular markers peak sharply at a single vertical dotted line near 3.5 then decline. Blue
// circular markers peak at the same line then fall toward zero. No gray shading is present; only one critical
// transition is marked. Panel (e) is a line plot with left red axis angle bracket X angle bracket BFFM and right
// blue axis angle bracket Z angle bracket BFFM, both ranging from 0.0 to 1.0. Red circular markers decrease from
// about 0.5 to zero at the vertical dotted line near 3.5. Blue circular markers remain near zero until the
// dotted line, then jump abruptly to unity afterward. A single vertical dotted line marks the phase boundary.
// Panel (f) is a line plot with left red axis angle bracket X angle bracket circ and right blue axis angle
// bracket Z angle bracket circ, both from 0.0 to 1.0. Red circular markers stay near 0.5 then drop sharply to
// zero at the vertical dotted line near 3.5. Blue circular markers stay near zero until the dotted line, then
// rise to about 0.8 at the right edge. A single vertical dotted line indicates the transition.
#figure(scope: "parent", 
  box(width: 16.4cm, height: 6.4cm, [
    // [figvision] figures/methods_fig1.png
    // Six panels. Top-left: correlation length xi (red, left axis) and entropy S (blue, right axis) against
    // Delta/Omega from -2 to 3: xi peaks sharply at 0.56 and again near 2, while S saturates at 2.5 in the
    // grey band between the two dotted guides. Bottom-left: a single sweep with xi peaking at 3.5 and S
    // dropping there. Top-middle and bottom-middle: <X>_BFFM (red) and <Z>_BFFM (blue) against Delta/Omega;
    // red falls from 0.45 to zero and blue rises from zero to 0.7-1.0, with a grey band marking the
    // transition. Top-right and bottom-right: <X>_circ (red) and <Z>_circ (blue) likewise crossing near
    // 3.5, red falling from 0.5 to 0.05 and blue rising to 0.65.
    #image("figures/methods_fig1.png", width: 16cm)
    #place(top+left, dx: 0.1cm, dy: 0.1cm, [#text(11pt, weight: "bold")[A]])
    #place(top+left, dx: 5.26cm, dy: 0.1cm, [#text(11pt, weight: "bold")[B]])
    #place(top+left, dx: 10.53cm, dy: 0.1cm, [#text(11pt, weight: "bold")[C]])
    #place(top+left, dx: 0.1cm, dy: 3.05cm, [#text(11pt, weight: "bold")[D]])
    #place(top+left, dx: 5.26cm, dy: 3.05cm, [#text(11pt, weight: "bold")[E]])
    #place(top+left, dx: 10.53cm, dy: 3.05cm, [#text(11pt, weight: "bold")[F]])
  ]),
  caption: [
    #strong[Ground state phase diagram of the link-kagome model for two truncation distances.] All data is for the van der Waals model with blockade radius $R_b = 2.4 a$ on an XC-8 cylinder. (#strong[A-C]) For truncation distance $R_"trunc" = sqrt(7) a$, we observe a spin liquid (gray shaded area) in between the trivial phase and valence bond solid (VBS). In particular, it is characterized by a large entanglement plateau ($S$ is the entanglement entropy upon bipartitioning the cylinder and $xi$ is the correlation length), vanishing of the BFFM string order parameters (darker lines correspond to larger strings) and nonzero loop variables ($⟨Z⟩_"circ"$ and $⟨X⟩_"circ"$) around the circumference---the signs of the latter label topologically degenerate ground states, as explained in Ref.~@Ruben2020. (#strong[D-F]) By increasing the truncation distance to $R_"trunc" = 6 a$, the intermediate spin liquid has vanished: there is now a direct first order transition from the trivial phase to a VBS.
  ]
) <fig:phasediagram>

#figure(
  [#include "figures/gsphasediagram.cetz.typ"],
  caption: [
    #strong[Ground state phase diagram of the link-kagome model.] Upon including all $V(r) ∼ 1 / r^6$ interactions (represented by the gray dashed line), we find that there is a direct phase transition from the trivial disordered phase to a crystalline-symmetry-breaking valence bond solid (VBS). However, the model is very close to a spin liquid phase: in fact, if we truncate the interactions to a distance $R_"trunc"$, we see that a $ℤ_2$ spin liquid can arise in the ground state phase diagram (black dots denote phase transitions obtained via DMRG on the XC-8 cylinder). It is conceivable that dynamical state preparation is not sensitive to the longer-range couplings which destabilize the spin liquid; indeed, in @fig:state_prep_DMRG we confirm that finite-time state preparation gives a state with properties characteristic of a spin liquid.
  ]
) <fig:gsphasediagram>

For intermediate truncation distances, we find a spin liquid in the ground state phase diagram. In particular, taking $R_"trunc" = sqrt(7) a ≈ 2.65 a$, we include four nearest neighbor interactions (i.e., one more than the blockade model): every site is coupled to 10 other sites. The resulting phase diagram is shown in @fig:phasediagram (A-C). This is obtained using the DMRG method applied to an infinitely-long cylinder XC-8 (see Ref.~@Ruben2020 for details about cylinder geometries of the kagome lattice). The presence of a spin liquid is determined based on the behavior of the string observables, as in the experiment. Moreover, we observe topologically degenerate ground states on the cylinder @Ruben2020.

However, we find that the spin liquid is destabilized upon including even longer range interactions: for $R_"trunc" = sqrt(7) a$ we find a spin liquid for $3.4 ≤ Delta / Omega ≤ 3.62$, for $R_"trunc" = 4 a$ we find that this has shrunken down to $3.45 ≤ Delta / Omega ≤ 3.52$, and for $R_"trunc" = 6 a$ there is no intervening spin liquid. @fig:phasediagram (D-F) shows a direct first order phase transition at $Delta / Omega ≈ 3.47$ from the trivial phase to a valence bond solid (VBS). These results are summarized in @fig:gsphasediagram. We note that these conclusions are strictly valid for the Hamiltonian in @eq:ryd_ham of the main text and might be affected by additional terms, associated, e.g., with multi-body Rydberg interactions. Moreover, other modified ruby lattice geometries still support a ground state spin liquid phase even in the presence of these long range interactions @Ruben2020. At the same time, we find that quasi-adiabatic state preparation used in the experiment is far more robust to these effects. In particular, as we will now show, such state preparation avoids the first order transition to the VBS and instead results in a state reflecting correlations characteristic of a quantum spin liquid.

== Numerical simulations of dynamical state preparation <sec:dynsim>

// [figvision] figures/FigED.png
// A. This plot shows the lowest instantaneous eigenstates of the Hamiltonian. The x-axis ranges from -2 to 3 and
// represents Δ/Ω. The y-axis ranges from -10 to 2 and represents (En - E ground state)/Ω0. The colors of the
// lines indicate the populations of the state generated in the real-time quench dynamics, with a color bar
// showing the range from ≤ 10-2 to 1. The lines are various shades of blue and purple. There is an inset plot
// showing Δ(t)/Ω0 versus t/T, with a red line and a gray line. The trend shows the eigenstates versus Δ/Ω. B.
// This plot has two parts. The main plot shows populations |ci|^2 versus dimer covering index i. The y-axis
// ranges from 0 to 0.02. There are four series of points: black for the ground state, and red for |ψ(T) = ∑ci|i
// with Ω0T = 30, 60, 120. The inset plot shows arg(ci/c1) versus an unspecified x-axis, with a red line. The
// trend shows that the populations are small and relatively constant, while the argument of the ratio of
// coefficients is approximately 0.
#figure(scope: "parent", placement: auto, 
  image("figures/FigED.png", width: 100%),
  caption: [
    #strong[Dynamical state preparation in PXP model.] (#strong[A]) Lowest instantaneous eigenstates of the Hamiltonian in @eq:PXP for 36 atoms on a torus. Colors indicate the populations of the state generated in the real time quench dynamics with Hamiltonian parameters given in the inset (data is shown for total sweep time $T = 60 / Omega_0$). (#strong[B]) Decomposition of the ground state and the dynamically generated state at the end of the parameter sweep ($Delta / Omega_0 = 5$) over all dimer covering configurations for various sweep durations $T$. The total population in the dimer covering sector is $sum_(i in cal(D)) |c_i|^2 = 0.27, 0.60, 0.82$ for $Omega_0 T = 30, 60, 120$, respectively. For the ground state at $Delta / Omega = 5$ the population in the dimer covering sector is 0.89. The inset shows the phase of each amplitude. For comparison, the experimental state preparation occurs over $Omega_0 T = 18$.
  ]
) <fig:state_prep_ED>

The detuning ramps, $Delta(t)$, which are employed to generate various states, are motivated by the adiabatic principle. For sufficiently slow ramps, the system follows the instantaneous ground state adiabatically @katoAdiabaticTheoremQuantum1950. In practice, finite coherence times limit the maximum evolution times, and require faster-than-adiabatic sweeps. This is expected to induce non-adiabatic processes, in particular close to the critical point, where the finite size gap is minimal @zurekDynamicsQuantumPhase2005 @dziarmagaDynamicsQuantumPhase2005a @polkovnikovUniversalAdiabaticDynamics2005.

// [figvision] figures/methods_fig3_v2.png
// Panel (a) is a line plot
#figure(scope: "parent", 
  box(width: 16.6cm, height: 7.6cm, [
    // [figvision] figures/methods_fig3_v2.png
    // Eight panels in two rows, ground state (blue dash-dotted) against state preparation (red solid, with
    // pale red uncertainty bands), all versus Delta/Omega from 0 to 7. First column, <Z>_hex: ground state
    // jumps from zero to 0.65 near Delta/Omega ~ 3 and stays high, while the prepared state rises only to
    // 0.3. Second, <X>_hex: ground state peaks sharply at 0.8 near 2.5 then falls to 0.1, prepared state
    // follows a broad peak of 0.6. Third, <Z>_BFFM: both fall from 1 to zero near 1 and stay near zero.
    // Fourth, <X>_BFFM: both start near 0.7 and decay to zero by 4, the ground state dropping abruptly at
    // 2.5. Dotted vertical guides mark the transition point in each panel.
    #place(top+left, dx: 3.4cm, [#image("figures/methods_fig3_v2.png", width: 13.2cm)])
    #place(top+left, dx: 0.0cm, dy: 2.2cm, [$R_"trunc" = sqrt(7) a$ $arrow.r$])
    #place(top+left, dx: 0.0cm, dy: 5.9cm, [$R_"trunc" = sqrt(12) a$ $arrow.r$])
  ]),
  caption: [
    #strong[Dynamical state preparation in the van der Waals model.] Results are for the XC-4 cylinder for $R_b = 2.4 a$. The two rows correspond to two different truncation distances, as shown. For each panel, we show both the ground state result (blue dashed, obtained by DMRG) as well as the dynamical state preparation using the protocol in @fig:CubicSweep (red solid, obtained by time-dependent DMRG; lighter solid line is for a sweep at half the speed). For the shorter truncation distance, the ground state hosts a spin liquid (blue shaded region). The diagonal loop around a hexagon is denoted by $⟨Z⟩_"hex"$; the off-diagonal loop by $⟨X⟩_"hex"$. The BFFM order parameters are evaluated for the open strings that correspond to half of these closed loops. Despite being short strings, due to the small system size, they already show a clear signature of a spin liquid where they both approximately vanish. Note that the ground state data for $R_"trunc" = sqrt(7) a$ has a vanishing $⟨Z⟩_"BFFM"$, even in the VBS phase: this is a finite-size artefact where the VBS phase consists of local resonances around the circumference. As a check, we also directly calculated the two-point correlator $⟨n_i n_j⟩ - ⟨n_i⟩ ⟨n_j⟩$, which clearly shows the VBS order in the ground state, yet these correlations vanish in the time-evolved states (not shown). We conclude that dynamic state preparation is not sensitive to $R_"trunc"$, and the resulting state has properties which are similar to those of the ground state spin liquid (at $R_"trunc" = sqrt(7) a$) albeit smeared out over a larger region.
  ]
) <fig:state_prep_DMRG>

To develop an understanding for the quantum many-body states that are generated in such quasi-adiabatic sweeps, we numerically solve the corresponding Schrödinger equation to obtain the wavefunction $|ψ(t)⟩ = U(t) |ψ(0)⟩$. We first discuss results from exact numerics on small system sizes of 36 atoms on a torus with $3 times 2$ unit cells, using the simplified PXP-model @eq:PXP. @fig:state_prep_ED A shows the excitation spectrum of the instantaneous Hamiltonian throughout the sweep. Even though the system size is relatively small, the spectrum distinguishes a disordered region with a unique ground state at $Delta / Omega ≤ 1.5$, and a region whose ground state physics is governed by the dimer covering configurations at $Delta / Omega ≥ 1.5$. Note that the small system size does not allow to distinguish a spin liquid phase from a VBS phase in this second regime. The color of each individual instantaneous energy eigenvalue in @fig:state_prep_ED A reflects the population of the wavefunction in the corresponding instantaneous eigenstate, $|⟨E_n | ψ(t)⟩|^2$. We observe that non-adiabatic processes lead to finite population in states with energy $∼ Delta$ outside the dimer covering subspace. This corresponds to the creation of pairs of monomers, consistent with the experimentally observed generation of a finite density of $e$-anyons. For the sweep profile shown in the inset, the total population in the dimer covering subspace, $cal(D)$, at the end of the sweep is $sum_(i in cal(D)) |⟨i | ψ(T)⟩|^2 ≈ 0.27, 0.60, 0.82$ for total sweep times $Omega_0 T = 30, 60, 120$ respectively, showing that the defect density can be controlled and reduced by decreasing the sweep rate. In @fig:state_prep_ED B, we resolve the state $|ψ(t)⟩$ within $cal(D)$ at the end of the detuning sweep. At this point, the instantaneous ground state consists of a superposition of a subset of dimer covering configurations, akin to a VBS state. Nevertheless, the projection of the dynamically prepared state $|ψ(t)⟩$ onto $cal(D)$ consists of a superposition of all dimer coverings with nearly equal modulus and phase. This indicates that the system cannot resolve the slow dynamics within the dimer covering subspace during these finite-time sweeps, and instead 'freezes' into a state that shares the essential features of the spin liquid state. This is consistent with our experimental observation of QSL characteristics in the dynamically prepared states over a relatively large parameter range, without any signatures of a VBS.

To further corroborate this picture, we also performed dynamical DMRG calculations for state preparation in the realistic model with van der Waals ($1 / r^6$) interactions using the matrix product operator-based approach developed in Ref.~@Zaletel15. We consider the infinitely-long XC-4 cylinder. As for the XC-8 results reported above, there is an intermediate spin liquid between the trivial phase and VBS phase for small truncation distance $R_"trunc" = sqrt(7) a$: this ground state data is shown as the dashed blue lines in the top row of @fig:state_prep_DMRG (the shaded region highlights the intermediate spin liquid). For larger truncation distance $R_"trunc" = sqrt(12) a$, the spin liquid is replaced by a direct first order phase transition (blue dashed lines in bottom row of @fig:state_prep_DMRG). The dynamical state preparation data is shown as a solid red line: dark solid lines corresponds to the same protocol as the experimental data (see @fig:CubicSweep); light solid line is twice as slow as the experiment.

The results in @fig:state_prep_DMRG imply a few salient points. Firstly, as far as dynamical state preparation is concerned, the results for the two truncation distances are very similar: the state preparation seems insensitive to longer-range interactions destroying the intermediate spin liquid in the ground state. Secondly, in both cases, the properties of the time-evolved state are qualitatively very similar to those of the ground state for $R_"trunc" = sqrt(7) a$ in the spin liquid regime. The two main differences are: (a) the spin liquid-like state is spread out over a larger region and shifted to the right (minimum of the BFFM order parameters is achieved near $Delta / Omega ≈ 5$), and (b) the observables are slightly suppressed compared to their equilibrium values. With regard to the latter, we observe that the state which was prepared twice as slowly (light red line) gives improved results, in agreement with experimental observations, @fig:Z_1GHz. This is consistent with the picture that already emerged from the dynamical simulations for the PXP model in @fig:state_prep_ED: even if the ground state is not a spin liquid due to a first order transition to a VBS phase, the dynamically prepared state effectively exhibits spin liquid-like properties, presumably due to the freezing-out of $m$-anyons (which would need to condense to form the VBS phase). @fig:ExpvsTh demonstrates that the results of these dynamical simulations, despite different system sizes and geometry used, are in a good qualitative agreement with experimental observations.

// [figvision] figures/Exp_vs_th_comparison.png
// A. This is a plot with two sections. The top section has a single series of grey circles, with a horizontal
// dashed line at 0.25. The x-axis ranges from -2 to 7 and has no units specified, and the y-axis ranges from
// 0.05 to 0.30 and is labeled n . The bottom section has four series of circles in blue, red, green, and no
// points. The x-axis is shared and ranges from -2 to 7, and the y-axis ranges from 0.0 to 1.0 and is labeled
// "Probability". The trend shows an increasing grey series and intersecting colored series. B. This plot has the
// same layout as A. The top section has a single grey line and a dashed line at 0.25. The colored series in the
// bottom section are lines, not circles. The trend shows similar behavior to A. C. This plot shows two series of
// points, green and red, with the green series labeled Z_{open} ^2 and the red series labeled Z_{closed} . The
// x-axis ranges from -2 to 7 and is labeled / . The y-axis ranges from 0.0 to 0.3. The trend shows both series
// decreasing as / increases. D. This plot shows two series of lines, green and red, with the red series labeled
// Z_{closed} . The x-axis ranges from -2 to 7 and is labeled / . The y-axis ranges from 0.0 to 0.3. The trend
// shows a peak in the red series. E. This plot shows two series of points, green and red, with the green series
// labeled X_{open} ^2 and the red series labeled X_{closed} . The x-axis ranges from -2 to 7 and is labeled / .
// The y-axis ranges from 0.0 to 0.2. The trend shows a peak in the red series. F. This plot shows two series of
// lines, green and red, with the red series peaking at around 0.6. The x-axis ranges from -2 to 7 and is labeled
// / . The y-axis ranges from 0.0 to 0.6 and is labeled X_{closed} . The trend shows a peak in the red series.
#figure(scope: "parent", placement: auto, 
  image("figures/Exp_vs_th_comparison.png", width: 100%),
  caption: [
    #strong[Comparison between experimental results and numerical simulations of dynamical state preparation.] The experimental data (#strong[A,C,E]) is reproduced from Figs. 1, 4 of the main text, while in (#strong[B,D,F]) we show the results of the time-dependent DMRG simulations for $R_"trunc" = sqrt(7) a$, performed on the infinitely-long cylinder with a seven-atom-long circumference (XC-4).
  ]
) <fig:ExpvsTh>

#bibliography("refs.bib", style: "ieee", title: none)
