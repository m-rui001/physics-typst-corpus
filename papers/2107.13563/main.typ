// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set math.equation(numbering: "(1)", supplement: [Eq.])
#let sup-eq = ("eq:QED", "eq:effective-Hamiltonian", "eq:dual-sine", "eq:rho", "eq:CE")
#let sup-fig = ("fig:app-Gauss-law", "fig:app-delta-scan", "fig:app-damp-sine", "fig:app-vio")
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    context {
      let n = counter(math.equation).at(e.location()).first()
      if str(it.target) in sup-eq { [Eq. (S#n)] } else { [Eq. (#n)] }
    }
  } else if e != none and e.func() == figure and str(it.target) in sup-fig {
    context [Figure S#counter(figure.where(kind: image)).at(e.location()).first()]
  } else { it }
}
#set heading(numbering: "1.1")
#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#show math.equation.where(block: true): set align(center)

#place(top, float: true, scope: "parent", clearance: 1.2em)[
#align(center)[
    #text(17pt, weight: "bold")[Thermalization dynamics of a gauge theory on a quantum simulator]
    #v(1.1em)
    #text(10.5pt)[
      Zhao-Yu Zhou#super[1,2,3,4]#super[∗], Guo-Xian Su#super[1,2,3,4]#super[∗], Jad C.~Halimeh#super[5],
      Robert Ott#super[6], Hui Sun#super[1,2,3,4], Philipp Hauke#super[5], Bing Yang#super[3,7],
      Zhen-Sheng Yuan#super[1,2,3,4,8], Jürgen Berges#super[6], and Jian-Wei Pan#super[1,2,3,4,8]
    ]
    #v(0.8em)
    #text(8.5pt, fill: gray.darken(20%))[
      #super[1] Hefei National Research Center for Physical Sciences at Microscale, University of Science and Technology of China, Hefei, China\
      #super[2] School of Physics, University of Science and Technology of China, Hefei, China\
      #super[3] Physikalisches Institut, Ruprecht-Karls-Universität Heidelberg, Heidelberg, Germany\
      #super[4] CAS Centre for Excellence and Synergetic Innovation Centre in Quantum Information and Quantum Physics, University of Science and Technology of China, Hefei, China\
      #super[5] INO-CNR BEC Center and Department of Physics, University of Trento, Trento, Italy\
      #super[6] Institute for Theoretical Physics, Ruprecht-Karls-Universität Heidelberg, Heidelberg, Germany\
      #super[7] Institut für Experimentalphysik, Universität Innsbruck, Innsbruck, Austria\
      #super[8] Hefei National Laboratory, Hefei, China
    ]
    #v(0.5em)
    #text(8.5pt, fill: gray.darken(20%))[
      #super[∗]~Z.-Y.Z. and G.-X.S. contributed equally to this work.
    ]
  ]
  #v(1.2em)

// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: July 18, 2022)]]

  #strong[Abstract.] Gauge theories form the foundation of modern physics, with applications ranging from elementary particle physics and early-universe cosmology to condensed matter systems. We perform quantum simulations of the unitary dynamics of a U(1) symmetric gauge field theory and demonstrate emergent irreversible behavior. The highly constrained gauge theory dynamics is encoded in a one-dimensional Bose–Hubbard simulator, which couples fermionic matter fields through dynamical gauge fields. We investigate global quantum quenches and the equilibration to a steady state well approximated by a thermal ensemble. Our work may enable the investigation of elusive phenomena, such as Schwinger pair production and string-breaking, and paves the way for simulating more complex higher-dimensional gauge theories on quantum synthetic matter devices.
]
  #v(1.2em)

  Gauge theories provide a fundamental description of quantum dynamics in the Standard Model of particle physics. However, unitary quantum evolution admits no loss of information on a fundamental level; thus, describing from first principles the emergence of phenomena such as thermalization in gauge theories is an outstanding challenge in physics. No general method exists that can simulate the time evolution of the underlying complex quantum many-body theory on classical computers @banuls2020simulating @kasper2014fermion. Much progress on emergent phenomena has been achieved for simpler systems @berges2001thermalization @rigol2008thermalization. For gauge fields, however, the direct connection of far-from-equilibrium behavior at early evolution times with the possible late-time approach to thermal equilibrium, as for instance indicated in collisions of heavy nuclei, remains elusive @berges2020thermalization.

  Quantum simulators open up a way forward to address this long-standing question. In recent years, there has been much progress in the engineering of gauge theories using various quantum resources such as trapped ions @Martinez2016 @Kokail2019, cold atomic gases @Yang2020 @Mil2020 @Schweizer2019 @Gorg2019 @Dai2017, arrays of Rydberg atoms @bernien2017probing @Surace2019a, and superconducting qubits @klco2018quantum @dejong2021quantum. Such table-top platforms can give access to a plethora of observables with high resolution in time and space. However, the simulation requires a large-scale system to incorporate the many degrees of freedom required for the complex quantum field dynamics. In addition, because gauge theories are governed by local symmetries, the engineering of the many gauge constraints at each point in space and time during a nonequilibrium evolution provides a major challenge.

  Here we perform quantum simulations of the far-from-equilibrium dynamics of a U(1) symmetric gauge field theory and demonstrate the emergence of thermal equilibrium properties at late times. To achieve this, we utilize a large-scale Bose–Hubbard quantum simulator @Yang2020 and precisely control the highly excited states relevant for the nonequilibrium dynamics of the gauge theory. The system couples fermionic matter through dynamical gauge fields in one spatial dimension, and employs a discrete "quantum-link" @Chandrasekharan1997 representation, discussed also in condensed matter physics @Levin2005 @Hermele2004 as well as in the context of particle physics @Kogut1983 @Brower1999.

// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [Figure #context it.counter.display(it.numbering). #it.body]
}

  #figure(image("figures/Fig1.pdf", width: 55%),
    caption: [
      #strong[Quantum simulation of gauge-theory quench dynamics.] #strong[(A)]~Schematic nonequilibrium evolution to the steady state. Under the constrained (gauge) condition, we find that different initial states with the same energy density evolve towards a common thermal state of the gauge theory. #strong[(B)]~Quantum simulator for the gauge theory. Matter and gauge fields are represented by occupations of bosonic atoms in an optical superlattice. Charges are illustrated as red (positive) and blue (negative) circles and electric flux is shown as yellow arrows. On matter sites, the presence of an atom signals a corresponding charge in the gauge theory. To illustrate Gauss's law, we indicate locally gauge-invariant configurations around even (green boxes) and odd matter sites (blue boxes), see also Fig.~S1. #strong[(C)]~Evolution of the matter density measured by in-situ imaging. Top: Starting from the initial state with unity-filled matter sites $⟨ hat(n)_"matter" ⟩ = 1$ (see inset), we observe a fast decay of the matter density $⟨ hat(n)_"matter" ⟩$ for "violent" quenches ($m / kappa = 0$) in our 71-site quantum simulator. Bottom: Evolution of matter density (averaged over 36 matter sites of the superlattice). Error bars denote the standard deviations.
    ]
  ) <fig:map>

  Exploiting the full experimental tunability of the Bose–Hubbard model parameters, we explore the influence of the gauge-symmetry constraints on the evolution and establish the thermalization dynamics of the U(1) gauge theory. Following quenching from gauge-invariant initial states far from equilibrium, we observe emergent many-body oscillations through the dynamical annihilation and creation of fermion pairs. We demonstrate an effective loss of information about the system's initial state by starting from different initial conditions with the same conserved quantities and observing relaxation towards a common steady state at longer times. This thermalization dynamics is illustrated in #ref(<fig:map>, supplement: none)A.

  The unitary dynamics of the one-dimensional lattice gauge theory is governed by the Hamiltonian
  $
    hat(H)_"gauge" = sum_l [ frac(kappa, 2) lr(hat(psi)_l hat(S)^(+)_(l,l+1) hat(psi)_(l+1) + "H.c.") + m hat(psi)_l^dagger hat(psi)_l ]
  $ <eq:qlm>
  where $hat(psi)_l^"(†)"$ are fermionic field operators @kogut1975hamiltonian on matter site $l$ with mass $m$. $hat(S)^(+(-))_(l,l+1)$ are spin-1/2 raising (lowering) operators for the gauge fields on the link between matter sites $l$ and $l + 1$. The interaction $∼ kappa$ represents the annihilation (or creation) of a pair of fermionic charges on neighboring sites with a concomitant change of electric flux $hat(E)_(l,l+1) = (-1)^(l+1) hat(S)^z_(l,l+1)$ on the gauge link in-between, such that gauge invariance is retained. The model is realized within a subspace of our quantum simulator, which is described by a tilted Bose–Hubbard Hamiltonian with a staggered potential; see Eq.~S5 for details. It is characterized by direct tunneling strength $J$, staggering potential parameter $delta$, linear potential $Delta$, and on-site interaction $U$, as indicated in #ref(<fig:map>, supplement: none)B. We employ a Jordan–Wigner transformation to replace the fermionic fields in Eq.~1 with bosonic atoms (see @supp for derivational details).

  We keep matter and gauge fields as dynamical degrees of freedom each represented by appropriate site occupations of atoms in an optical superlattice. Gauge symmetry is enforced by suitable energy penalties constraining the system to a gauge-invariant subspace of the quantum simulator @Zohar2013gauge @halimeh2020reliability @halimeh2020gauge. For $J << delta, U$, and a linear potential $Delta = 57$ Hz we suppress both direct and long-range tunneling and realize the gauge theory at second-order in perturbation theory @supp. We identify the gauge-invariant interaction with a correlated annihilation of two atoms on neighboring matter sites to form a doublon on the gauge link in between (and reverse), see #ref(<fig:map>, supplement: none)B. The mass of the fermion pair is set by the energy balance of this process as $2m = 2 delta - U$ and the interaction strength is given by $kappa approx 8 sqrt(2) J^2 / U$ close to resonance ($m ∼ 0$).

  To describe the nonequilibrium evolution of a gauge theory, it is essential to also respect the gauge symmetry in the initial state. In #ref(<fig:map>, supplement: none), we show examples of such initial states, which can be prepared in the present apparatus @Yang2020. We start the experiment with an array of $36$ near unity-filling chains of $""^(87)"Rb"$ atoms in the hyperfine state $| F = 1, m_F = -1 ⟩$. The individual chains extend over $71$ sites of an optical superlattice, which is formed by the superposition of a short lattice (spacing $a_s = 383.5$ nm) and a long lattice (spacing $a_l = 767$ nm). Employing the full tunability of superlattice configurations and the recently developed spin-dependent addressing technique @Yang2017, we remove all atoms on odd (gauge) sites, rendering only the even (matter) sites singly occupied in the initial state. The resulting state corresponds to the ground state of Eq.~1 for $kappa = 0$ and $m < 0$, and is characterized by empty gauge sites and unity filling on the matter sites $⟨ hat(n)_"matter" ⟩ = 1$, where $⟨ hat(n)_"matter" ⟩ = sum_(j in m) ⟨ hat(n)_j ⟩ / L_"m"$ is the average number of bosonic atoms over the $L_"m"$ even sites.

  After the initial-state preparation, the atoms are isolated in deep lattice wells ($J, kappa approx 0$). To initiate the dynamics, we first tune the superlattice configuration such that potential minima of the two lattices are aligned, creating the staggered potential. The quench is then initiated by tuning the laser intensities to realize the desired values of $kappa$ and $m$, which can be chosen from a broad range.
  Subsequently, the system undergoes coherent many-body oscillations. After a certain evolution time, we rapidly ramp up the lattice depth along the $x$-axis to $60 E_r$ within $0.1$ ms to freeze the dynamics, where $E_r = h^2 / (8 m_"Rb" a_s^2)$ is the recoil energy with $m_"Rb"$ the atom mass and $h$ Planck's constant. We then employ the same site-selective addressing technique and read out $⟨ hat(n)_"matter" ⟩$ with in-situ absorption imaging. Each data point is measured by averaging over $6$ realizations of the experiment. We show corresponding in-situ experimental data in #ref(<fig:map>, supplement: none)C for evolution times $t <= 150$ ms, with $kappa = 14.5$ Hz and $m = 0$. For a broad range of model parameters, we observe that the system relaxes towards a steady state after only a few oscillations. The oscillation frequency is mildly affected by the inhomogeneous Gaussian profile of the optical trap towards the edges ($Delta U ∼ 10$ Hz). Overall, the system retains a high degree of homogeneity throughout the tractable evolution times, as demonstrated in #ref(<fig:map>, supplement: none)C.

  #figure(scope: "parent", placement: auto, image("figures/Fig2.pdf", width: 100%),
    caption: [
      #strong[Controlled approach to gauge-theory dynamics.] #strong[(A)] Time evolution in the quantum simulator with and without gauge-theory constraint. The experiment describes the ideal gauge-theory dynamics (top panel) well for case 1 ($U, delta >> J$), whereas cases 2 and 3 deviate from these dynamics. The gauge violation, defined as a forbidden odd occupation of gauge sites, decreases from case 3 to case 1 and remains bounded throughout the tractable evolution dynamics. Solid curves are numerical $t$-DMRG results @supp. #strong[(B)] Frequency of many-body oscillations. The experiment ($f_"exp"$) shows a fast approach towards the gauge theory ($f_"gauge"$) for increasing staggering strength $delta$. The oscillation frequency is extracted as the lower frequency of a fitted dual-frequency damped sine function (see @supp for details). #strong[(C)] 2D parameter space. The late-time ($t = 120$ ms) matter density is independently scanned over two Hubbard parameters. The dashed white line indicates the resonance condition ($m = 0 <-> U = 2 delta$), applied to all the quench evolution data in the figure. #strong[(D)] Steady-state gauge violation. The time-averaged gauge violation $macron(eta)$ falls off towards zero for the strongly constrained system with $U / J >> 1$.
    ]
  ) <fig:freq>

  In #ref(<fig:freq>, supplement: none), we show the system evolution for the most "violent" quench to $m / kappa = 0$, corresponding to $U approx 2 delta$. In #ref(<fig:freq>, supplement: none)A, the real-time dynamics at various microscopic Bose–Hubbard parameters, which all map to the same $m / kappa$ but with different strengths of the gauge constraint (cases 1-3), is compared to theoretical estimates. The top panel shows a result for the ideal gauge field dynamics obtained through exact diagonalization of the Hamiltonian in Eq.~1 for a smaller system with $18$ matter sites. The lower panels give the experimental results for the observable along with numerical estimates based on the time-dependent density matrix renormalization group ($t$-DMRG) @Schollwoeck_review @mptoolkit for a Bose–Hubbard chain of 32 sites, which show good agreement. In the gauge-theory regime (case 1), we employ the damped-sine fitting at later times @supp to extract the damping rate $gamma$, which is found to be $gamma^(- 1) = 63 plus.minus 9$ ms (experiment) and $64.4 plus.minus 0.4$ ms ($t$-DMRG). Earliest times can be sensitive to small differences in initial conditions.

  The different levels of constrained dynamics are realized by tuning the Bose–Hubbard parameters from $delta / J = 1$ (case 3) to $delta / J = 16$ (case 1). This is reflected in the gauge violation $eta$, which tends to zero in the gauge-theory regime (case 1). It is defined as the odd atom number expectation value on gauge sites, $eta = sum_(j in g) ⟨ hat(n)_j mod 2 ⟩ / L_"g"$, where $L_"g"$ is the number of odd (gauge) sites @supp. We measure this probability by removing pairs of atoms in the same well with a photo-association laser, followed by selectively addressing the gauge links for imaging. We use $eta$ as a measure to validate our quantum simulation of the gauge theory, finding a controlled decrease from large violations in case 3 towards $eta approx 0$ in case 1 (Fig.~2, A-D). To characterize the dynamics as a function of the staggering parameter $delta / J$, which is used to enforce the gauge constraint, we extract the oscillation frequency of the matter density with a damped-sine fit. In Fig.~2B, our results show a fast approach towards the gauge theory upon increasing $delta / J$.

  #figure(image("figures/Fig3.pdf", width: 55%),
    caption: [
      #strong[Thermalization dynamics with and without gauge-symmetry constraint]. We investigate the real-time evolution of two data sets towards a late-time steady state for constrained (blue) and unconstrained (red) dynamics. Dashed lines show exact-diagonalization predictions from canonical thermal ensembles for the gauge theory (blue) and the Bose–Hubbard model (red) with the same energy density @supp. Insets show relevant processes with (top) and without (bottom) the gauge-symmetry constraint.
    ]
  ) <fig:thermal>

  We further investigate the role of the gauge constraint in the relaxation dynamics of the gauge theory by considering quenches to nonzero values of the mass $m$. This amounts to regions away from the resonance line characterized by $U = 2 delta$ (#ref(<fig:freq>, supplement: none)C), where the annihilation of fermion pairs is strongest. For $m = -0.8 kappa$, the resulting time evolution is displayed in #ref(<fig:thermal>, supplement: none) with both weakly ($delta / J ∼ 2$) and strongly constrained ($delta / J ∼ 11$) dynamics shown. Here and in the following, we focus on a region of interest of 50 chains each with an extent of 50 sites. This mitigates the effects of a slightly inhomogeneous trap. We compare the strongly constrained dynamics with the thermal prediction of the gauge theory, finding agreement within experimental precision at late times. In contrast, the unconstrained system evolves towards a very different state, characterized by a thermal ensemble of the Bose–Hubbard system away from the gauge-theory regime. In Fig.~3, the thermal predictions have been obtained from a numerical evaluation of the corresponding microcanonical and canonical ensembles. We extract the temperatures from the latter as shown in #ref(<fig:thermal>, supplement: none) by fixing their (conserved) energy density to that of the pure initial state @supp.

  #figure(scope: "parent", placement: auto, image("figures/Fig4.pdf", width: 100%),
    caption: [
      #strong[Effective loss of initial-state information]. #strong[(A)] State preparation. Evolution of the matter density from the "fully matter-filled" state ($⟨ hat(n)_"matter" ⟩ = 1$, blue box left) to almost "matter-empty" state ($⟨ hat(n)_"matter" ⟩ approx 0.21$, yellow box right) for the adiabatic ramp with preparation time $tau$ and corresponding mass parameter $m_"Pre" / kappa$ as shown in the inset. #strong[(B)] Schematic of the evolution towards thermal equilibrium. For each of two sets of quench parameters ($m = 0$ and $m = -0.8 kappa$) we choose two initial states with equal energy density. The resulting steady states in the wake of the quenches starting in these two initial states are then compared to a canonical thermal ensemble whose temperature is determined from the energy density @supp. Here, all energy densities are plotted with respect to the ground state of the evolution Hamiltonian. #strong[(C, D)] Relaxation. We show the thermalization dynamics for the chosen quench parameters and initial states (shown in (B)). Experimental data are compared to predictions from corresponding gauge theory thermal ensembles (dashed lines) at temperatures $k_B T = oo$ (top) and $k_B T = 4.6 kappa$ (bottom). The insets show the energy density evolution during state preparation, the circles mark the chosen initial states.
    ]
  ) <fig:initialcond>

  As a next step, we investigate the role of the initial state in the thermalization dynamics of the gauge theory. If the system approaches thermal equilibrium, then the late-time behavior is entirely characterized by conserved quantities. The tunability of the Hubbard parameters allows us to access a broad range of gauge-symmetric initial states with an adiabatic ramp, ranging from the fully filled state ($⟨ hat(n)_"matter" ⟩ = 1$) to states where a large fraction fermion pairs have annihilated ($⟨ hat(n)_"matter" ⟩ approx 0.21$) @Yang2020, see #ref(<fig:initialcond>, supplement: none)A. For the quench dynamics, we compare initial states with the same energy density with respect to the quench Hamiltonian (#ref(<fig:initialcond>, supplement: none)B). To achieve this, we numerically follow the experimental sequence and determine suitable ramp times as outlined Fig.~4A for two values of $m / kappa = -0.8$ and $m / kappa = 0$ @supp. For $m / kappa = 0$, the initial states with the same energy density are prepared with the ramp times 1.2 ms and 20 ms, corresponding to $⟨ hat(n)_"matter" ⟩ = 1$ and $⟨ hat(n)_"matter" ⟩ approx 0.21$ respectively. For $m / kappa = -0.8$, the ramp times are 0 ms and 6.8 ms, corresponding to the initial states of $⟨ hat(n)_"matter" ⟩ = 1$ and $⟨ hat(n)_"matter" ⟩ approx 0.71$. The ensuing dynamics is characterized by transient many-body oscillations, where the different initial states relax to a common steady state at long times (Fig.~4, C and D). During the evolution, the information about initially different matter densities is seen to be effectively lost in the quantum many-body system. We again find the long-time steady states to be well-described by gauge-invariant thermal ensembles with the same conserved charges as the initial state. We observe this thermalization dynamics for different values of couplings in the gauge theory. Specifically for $m = 0$ our initial states are distributed symmetrically around the center of the energy spectrum @supp. In this case one observes a fast effective loss of initial-state memory, and the experiment relaxes to the steady-state value of the infinite-temperature state (#ref(<fig:initialcond>, supplement: none) B and C.)

  Effectively irreversible behavior, such as thermalization from an underlying reversible time evolution, emerges in general in nonintegrable models for local observables and typical initial states @Rigol2008thermalization. Despite the nonintegrability of the U(1) quantum link model @turner2018weak @Surace2019a @Zache2021, certain fine-tuned quenches give rise to weak ergodicity breaking owing to the presence of special eigenstates in the spectrum of the quench Hamiltonian @turner2018weak @Surace2019a. This could manifest in persistent oscillations around the thermal-ensemble prediction @bernien2017probing. Currently, the level of control in our experiment limits us from probing such possible behavior in part because of an inherent residual inhomogeneity across the lattice. Thus, in our experiment we observe equilibration to close to the thermal equilibrium value for all quenches we performed.

  Our work creates a pathway for addressing emergent dynamical phenomena in gauge theories, such as the Schwinger effect @zache2018quantum, dynamical topological quantum phase transitions @Huang2019, and string-breaking @Banerjee2012 @hebenstreit2013real in strong fields @Narozhny2014. The approach lays also the foundations for the exploration of more complex higher-dimensional gauge theories using state-of-the-art quantum technology @zohar2021quantum. An important next step towards applications for gauge theories such as quantum electrodynamics, or maybe even quantum chromodynamics, is a faithful extension of the discrete quantum-link representation towards continuous variables @Mil2020 @prufer2020experimental @Zache:2019xkx. To this end, current implementation schemes should be extended to higher spin representations and scalable higher-dimensional set-ups @ott2020scalable.

  #heading(level: 1, numbering: none)[Acknowledgments]
  <acknowledgments>

  The authors are grateful to D.~Banerjee, A.~Sen, J.-Y.~Desaules, M.~Gärttner, A.~Hudomal, F.~Jendrzejewski, A.~Lazarides, M.~Oberthaler, Z.~Papić, J.~Schmiedmayer, C.~J.~Turner, and T.~V.~Zache for discussions. #strong[Fundings:] This work is part of and supported by NNSFC grant 12125409, Innovation Program for Quantum Science and Technology 2021ZD0302000, the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) - Project-ID 273811115 - SFB 1225 and under Germany's Excellence Strategy EXC 2181/1-390900948 (the Heidelberg STRUCTURES Excellence Cluster), the Anhui Initiative in Quantum Information Technologies, the Chinese Academy of Sciences, Provincia Autonoma di Trento, the ERC Starting Grant StrEnQTh (project ID 804305), the Google Research Scholar Award ProGauge, and Q\@TN — Quantum Science and Technology in Trento. #strong[Author contributions:] Z.-Y.Z. and G.-X.S. contributed equally to this work. Z.-Y.Z., G.-X.S., and H.S. performed the experiments and analyzed the data; J.C.H. and R.O. performed the numerical calculations and comparisons to experimental data; H.S., B.Y., Z.-S.Y., and J.-W.P. developed relevant experimental techniques; P.H., B.Y., and J.B. initiated early discussions on this topic; J.B., P.H., J.C.H., and R.O. developed the theory; Z.-S.Y. and J.-W.P. conceived and supervised the experimental research; all authors contributed to the writing of the manuscript. #strong[Competing interests:] The authors declare no competing financial interests. #strong[Data and materials availability:] All experimental data and code are available in the database @zhaoyu2022data.

  #heading(level: 1, numbering: none)[Supplementary materials]
  <supplementary-materials>

  Supplementary Text \
  Figs. S1 to S5 \
  References (43-44)

  #counter(math.equation).update(0)
  #counter(figure.where(kind: image)).update(0)
  #set math.equation(numbering: "(S1)")
  #set figure(numbering: "S1")
  #set heading(numbering: "S1.1")

  #align(center)[#strong[SUPPLEMENTARY MATERIAL]]
= Details on the gauge theory Hamiltonian
<details-on-the-gauge-theory-hamiltonian>
In the main text, we have used a particle-hole transformation to express the spin-$1 \/ 2$ $upright(U)(1)$ quantum link model (QLM) in a "charge basis" where excitations of the fermion fields on matter sites relate to the presence of electric charges. Here, we outline this particle-hole transformation in detail. We start with the Hamiltonian of the spin-$1 \/ 2$ $upright(U)(1)$ QLM with staggered fermions~@Kogut1983
$
  hat(H)_"gauge" = sum_l [kappa / 2 ( hat(psi)_l^dagger hat(S)_(l, l + 1)^(+) hat(psi)_(l + 1) + "H.c." ) + m (-1)^l hat(psi)_l^dagger hat(psi)_l] .
$ <eq:QED>
Here, the generators of the $upright(U)(1)$ gauge symmetry are the Gauss operators $hat(G)_l = hat(psi)_l^dagger hat(psi)_l + ((-1)^(l + 1) - 1)\/2 - hat(S)_(l - 1, l)^z + hat(S)_(l, l + 1)^z$, with eigenvalues $g_l$ that locally determine the gauge-invariant sector. In our work, we choose the target sector as $g_l = 0 forall l$. The Hamiltonian @eq:QED is invariant under the transformation $hat(H) = hat(V)_l^dagger hat(H) hat(V)_l forall l$ with the unitary operator $hat(V)_l = exp(i alpha_l hat(G)_l)$, where $alpha_l$ is a continuous angle $in (0, 2 pi]$ which may depend on the lattice site index $l$.

To employ the particle-hole transformation, we replace for even matter sites
$
  hat(psi)_(2 l)^dagger hat(psi)_(2 l) &arrow.r 1 - hat(psi)_(2 l)^dagger hat(psi)_(2 l), quad hat(psi)_(2 l) arrow.r hat(psi)_(2 l)^dagger, \
  hat(S)_(2 l, 2 l + 1)^z &arrow.r (-1) hat(S)_(2 l, 2 l + 1)^z, quad hat(S)_(2 l, 2 l + 1)^(plus.minus) arrow.r hat(S)_(2 l, 2 l + 1)^(minus.plus) .
$
The Hamiltonian of the spin-$1 \/ 2$ $upright(U)(1)$ QLM now becomes @eq:qlm of the main text, where we additionally drop an irrelevant constant. The generator of the $upright(U)(1)$ gauge symmetry is replaced by
$
  hat(G)_l arrow.r (-1)^(l + 1) (hat(S)_(l - 1, l)^z + hat(S)_(l, l + 1)^z + hat(psi)_l^dagger hat(psi)_l) .
$
Locally, it allows for a set of three states as illustrated in #strong[a], which in an extended lattice are coupled to gauge-invariant many-body states. The gauge-invariant interaction term can now be readily connected to the creation and annihilation of a pair of electric charges, see #strong[b]. Furthermore, the staggering in the mass term has been removed through the particle-hole transformation.

#figure(placement: auto, image("figures/Fig-S1.pdf", width: 80mm),
  caption: [
    Details on the mapping of the gauge theory. (a)~We display the locally allowed configurations in our quantum simulator and their analogs in the gauge theory according to Gauss law. (b)~We show the frequently used initial state with $chevron.l hat(n)_(upright("matter")) chevron.r$ in both gauge theory and quantum simulator and illustrate the transport of fermions in the subsequent dynamics.
  ]
) <fig:app-Gauss-law>

= Mapping the Bose--Hubbard simulator onto the $upright(U) ( 1 )$ gauge theory
<mapping-the-bosehubbard-simulator-onto-the-mathrmu1-gauge-theory>
The experiment is governed by the Bose--Hubbard Hamiltonian $ hat(H)_(upright("exp")) = sum_j [ J ( hat(b)_j^dagger hat(b)_(j + 1) + "H.c." ) + epsilon.alt_j hat(n)_j + U / 2 hat(n)_j ( hat(n)_j - 1 ) ]  thin  $ where $epsilon.alt_j = j Delta + ( - 1 )^j delta \/ 2$ encodes the potentials from the staggered superlattice and the gravitational gradient, and $hat(n)_j = hat(b)_j^dagger hat(b)_j$ is the number operator. For $J lt.double delta  thin  U$ and $U tilde.op 2 delta$, we derive the effective Hamiltonian (valid in the bosonic occupation subspace defined below) $
  hat(H)_(upright("eff")) = sum_(j in e) [frac(kappa, 2 sqrt(2)) ( hat(b)_j^dagger hat(b)_(j + 2)^dagger hat(b)_(j + 1)^2 + "H.c." ) + m hat(b)_j^dagger hat(b)_j]  thin  $
<eq:effective-Hamiltonian>
at second order in perturbation theory, where $m = delta - U \/ 2$, and the sum runs over all even ($j in e$) optical lattice wells corresponding to the matter sites $l$. The correlated hopping interaction $kappa$ is given by $ kappa = 2 sqrt(2) J^2 [frac(delta, delta^2 - Delta^2) + frac(U - delta, ( U - delta )^2 - Delta^2)] . $ Here, we have also considered the condition $Delta gt.double kappa$, to suppress second-order tunneling over two sites. Close to resonance, i.e., $U approx 2 delta$, and using $Delta lt.double delta  thin  U$ as realized in our experiment, we have $kappa approx 8 sqrt(2) J^2 \/ U$.

For the considered lattice parameters and initial state, the system is effectively constrained to the site occupations $|0 chevron.r$ and $|1 chevron.r$ for the even sites of the superlattice (matter sites), and $|0 chevron.r$ and $|2 chevron.r$ for the odd sites of the superlattice (gauge links). The Hamiltonian @eq:effective-Hamiltonian as well as the following operator identifications are valid in this occupation subsector of the Hilbert space and should be interpreted with the corresponding projection operators $cal(P)_j$ onto the associated local subspace. To make direct contact to the lattice gauge theory Hamiltonian @eq:qlm, we identify the bosonic creation operators on odd superlattice wells ($2 l + 1 = j in o$) as the gauge fields on the gauge links $(l, l + 1)$
$
  hat(b)_(j in o)^2 &= sqrt(2) hat(S)_(l, l + 1)^(-), \
  hat(n)_(j in o) &= 2 hat(S)_(l, l + 1)^z + 1 .
$
Further, using a Jordan--Wigner transformation, we map the bosonic creation operators on even superlattice wells, $2 l = j in e$, to fermionic matter field operators $hat(psi)_l$
$
  hat(b)_(j in e)^((dagger)) &= (-1)^l e^((-i) pi sum_(l' < l) hat(psi)_(l')^dagger hat(psi)_(l')) hat(psi)_l^((dagger)), \
  hat(n)_(j in e) &= hat(psi)_l^dagger hat(psi)_l,
$
These mappings yield the lattice gauge theory Hamiltonian @eq:qlm.

= State preparation and detection
<state-preparation-and-detection>
The experiment begins with a single layer of quasi-2D $chevron.l hat(n) chevron.r = 1$ Mott insulator of $""^87$Rb atoms prepared in the hyperfine state $|F=1, m_F=-1 chevron.r$. We employ the staggered-immersion cooling technique with an optical superlattice along the $x$-axis to reach a filling rate of $99.2 %$ @Yang2020. The optical superlattice consists of two standing waves with laser frequencies $lambda_s = 767$ nm and $lambda_l = 1534$ nm, forming the potential $ med V ( x ) = V_s "cos"^2 ( k x ) - V_l "cos"^2 ( k x \/ 2 + phi )  thin  $ where $k = 2 pi \/ lambda_"s"$ is the wave number of short lattice, and $V_s$ and $V_l$ are the depths of the short and long lattices, respectively. The relative phase $phi$ controlled by the relative frequency of these lasers determines the superlattice structure. The quench dynamics is observed at $phi = pi \/ 4$, forming the staggered potential with equal hopping $J$ between neighboring sites, while the site-selective addressing is performed at $phi = 0$, indicating a balanced condition for the double well.

To perform the site-selective addressing, we first set the bias magnetic field along the $x$-axis, then by tuning the polarization of the short lattice along the $x$-axis with an electro-optical modulator, the hyperfine transition frequency between the hyperfine states $| F = 1  thin  m_F = - 1 chevron.r$ and $| F = 2  thin  m_F = - 2 chevron.r$ of odd and even sites are split by $28$ kHz. Atoms on the odd or even sites can then be adiabatically transferred to $| F = 2  thin  m_F = - 2 chevron.r$, which is resonant with the imaging laser. The initial state with $chevron.l hat(n)_"matter" chevron.r = 1$ and $chevron.l hat(n)_"gauge" chevron.r = 0$ is prepared by simply transferring and removing all atoms on odd sites with the imaging laser. On the other hand, for detecting atom number density, we transfer and then extract $chevron.l hat(n)_"gauge" chevron.r$ and $chevron.l hat(n)_"matter" chevron.r$ with in-situ absorption imaging of odd and even sites successively in one experimental sequence.

To access various gauge-invariant initial states with $chevron.l hat(n)_"matter" chevron.r < 1$ in @fig:initialcond, we start with the $chevron.l hat(n)_"matter" chevron.r = 1$ state, and using an optimized version of the adiabatic ramp described in @Yang2020, we can prepare states ranging from $chevron.l hat(n)_"matter" chevron.r = 1$ to $chevron.l hat(n)_"matter" chevron.r = 0.21$ by stopping the ramp at certain time $tau$ (see #strong[b]).

To obtain the gauge violation $eta$ during the quench dynamics, we measure the density of odd-number of atoms occupying the gauge sites, which is done by parity projection with the photoassociation (PA) laser. The PA laser excites pairs of atoms to molecular states which quickly decay to free channels by emitting photons, thereby imparting atoms with the kinetic energy required to escape from the lattice potential. After a certain evolution time, a $20$ ms PA laser pulse was applied with the intensity of $0.67$ $"W/cm"^2$. An efficiency of $98 %$ was reached for removing doublons.

= Identifying the resonance condition
<identifying-the-resonance-condition>
#figure(placement: auto, image("figures/Fig-S2.pdf", width: 83mm),
  caption: [
    Late-time parameter space. The average atom population on gauge sites after $120$ ms evolution, scanned over the parameters $delta \/ J$. The peaks in the figure correspond to the resonance condition of the correlated second-order hopping, $delta = U \/ 2$.
  ]
) <fig:app-delta-scan>

We first perform a 2D parameter scan to find the resonance condition of correlated second-order tunneling that realizes the gauge theory (see #strong[c]). Starting from the initial state with $chevron.l hat(n)_"matter" chevron.r = 1$, which is the ground state of Hamiltonian @eq:qlm at $m arrow.r - oo$, we bring the system out-of-equilibrium by turning on the gauge coupling $kappa$ while quenching the effective mass from $m arrow.r - oo$ to $m approx 0$ with $m = delta - U \/ 2$. By setting the relative phase $phi = pi \/ 4$, we configure the superlattice in the form of a #emph[staggered] potential (see #strong[b]), where $delta$ is mainly determined by the long lattice depth while $J$ is set by the short lattice depth. The on-site interaction $U$ is then determined by the trapping frequency of the short lattice along the $x$, $y$, and $z$ axes. Each data point in the parameter scan is obtained with $120$ ms of quench evolution during which the system roughly relaxes to a steady state. The scans are done by fixing $U$ and $J$ while changing $delta$ for each quench evolution, where @fig:app-delta-scan shows three examples of the scans. The suppression of direct tunneling can be seen as $chevron.l hat(n)_"matter" chevron.r$ goes to 1 with increasing $delta \/ J$. At $delta approx U \/ 2$, a resonance peak can be observed corresponding to $m approx 0$ in the gauge theory. We perform our further studies in the vicinity of these resonance peaks.

= Approaching the gauge theory
<approaching-the-gauge-theory>
#figure(placement: auto, image("figures/Fig-S3.pdf", width: 83mm),
  caption: [
    Damped-sine fitting for different staggering. (a) We extract the oscillation frequency ($f_"exp" = 21$ Hz) at large staggering $delta \/ J = 16$. (b) At staggering $delta \/ J = 6.5$, two oscillation frequencies ($f_"1" = 507$ Hz, $f_"2" = 172$ Hz) are extracted from the data. The solid blue curves result from the damped-sine fitting with @eq:dual-sine. They extend over the times considered for the fit.
  ]
) <fig:app-damp-sine>

For cases in #strong[b] where we have the strongest quench from $m arrow.r - oo$ to $m = delta - U \/ 2 = 0$, the many-body oscillation frequency of the gauge theory solely depends on the coupling strength $kappa$. We associate the correlated second-order tunneling $8 sqrt(2) J^2 \/ U$ in the Bose--Hubbard simulator with $kappa$ through perturbation theory, and gauge violations introduced by direct tunneling $J$ leads the Bose--Hubbard simulator to deviate from the gauge theory. With large $U \/ J$, gauge violation is suppressed and the frequency of the Bose--Hubbard simulator approaches the gauge theory. To quantitatively identify this approach to the gauge theory, we extract the oscillation frequency $f_"exp"$ in experiment with a damped-sine fitting, and calculate its ratio with the gauge-theory frequency $f_"gauge"$. And to capture both first and second-order tunneling in the Bose--Hubbard simulator, we use the dual-frequency damped sine-wave function for the fitting:

$ med n = n_0 + A_1 e^(- gamma_1 t) "sin" ( 2 pi f_1 t + b_1 ) + A_2 e^(- gamma_2 t) "sin" ( 2 pi f_2 t + b_2 ) . $
<eq:dual-sine>
where $omega_(1  thin  2)$ represent the two angular frequencies extracted from the oscillations and $gamma_(1 ( 2 ))$ indicates the damping rate for each frequency. For quench dynamics in the gauge-invariant regime ($delta \/ J > 10$, case 1 in #strong[a]) and the "nongauge" regime ($delta \/ J < 2$, case 3 in #strong[a]), oscillations are dominated by one of the tunneling processes and fitting gives identical $f_1$ and $f_2$, whence we take the average $f_"exp" = ( f_1 + f_2 ) \/ 2$. However, in the "cross-over" regime ($2 < delta \/ J < 10$, case 2 in #strong[a]), a clear beating of two frequencies can be seen, and both frequencies are extracted. As the higher frequency comes from direct tunneling $J$, we take the slower frequency which captures the second-order tunneling $f_"exp" = min ( f_1  thin  f_2 )$. To avoid turning-on effects, we start the fit from the first minimum, see @fig:app-damp-sine.

The numerical data shown in #strong[b] (solid curve) is obtained from $t$-DMRG with $L = 32$ sites. We calculated 129 sets of $t$-DMRG data with increasing staggering at different conditions ($delta - U \/ 2 = 0$, $delta - U \/ 2 = plus.minus 3$ Hz) and applied the damped sine-wave function on the data. The solid curve in #strong[b] represents the result at the resonance condition ($delta - U \/ 2 = 0$) while the grey area describes the boundary of off-resonance conditions ($delta - U \/ 2 = plus.minus 3$ Hz).

= Quantifying the gauge violation
<quantifying-the-gauge-violation>
#figure(placement: auto, image("figures/Fig-S4.pdf", width: 83mm),
  caption: [
    #strong[Gauge violation measure.] We numerically compare our experimentally accessible local violation measure $eta$ (thick red line) to a global measure $epsilon$ (thin green line, see text). We find reasonable agreement for both the regime close to (case 1) and far away from the gauge theory (cases 2 and 3). In the second, non-gauge regime, the system quickly reaches the maximum global violation $1 \/ L_"g"$. Here, the system size is $L_"g" = 5$.
  ]
) <fig:app-vio>

Overall, our results show a faithful implementation of the gauge theory for the considered quench dynamics starting from far-from-equilibrium initial states. We achieve this by strongly suppressing processes that violate the gauge symmetry. To further quantify this, in the following we consider the direct tunneling for the quench dynamics starting from the \"fully filled\" initial state. In @fig:app-vio, we show the average gauge-violation per site $eta$, as defined in the main text, and compare it to the global measure $epsilon = ( 1 - chevron.l hat(P)_G chevron.r ) \/ L_"g"$, where $hat(P)_G$ is the projector onto the exact gauge-invariant subsector of the full Hilbert space.

In panel #strong[a], we see that for the employed evolution parameters and initial state, the two measures agree in the gauge regime (case 1). Close to the gauge regime, the quantitative agreement can be understood from a simple error model assuming that gauge errors appear at every site independently and at the same rate. Suppose this rate is given by our experimentally accessible measure $eta$, then the probability of remaining in the gauge-invariant subsector is approximately given by $chevron.l hat(P)_G chevron.r tilde.op ( 1 - eta )^(L_"g") approx 1 - L_"g" eta$, such that $epsilon tilde.op eta$. While this is strictly only valid for~$L_"g" eta lt.double 1$, our numerical results in suggest reasonable agreement even away from the gauge-invariant regime (cases 2 and 3 in panels #strong[b] and #strong[c]).

= Thermal ensembles for the $upright(U) ( 1 )$ quantum link model
<thermal-ensembles-for-the-mathrmu1-quantum-link-model>
For the calculation of the thermal values for the steady states in our quench dynamics, we utilize the diagonal, canonical, and microcanonical ensembles. When the long-time average of the unitary dynamics agrees with the expectation value predicted by the diagonal ensemble, this indicates that the system has equilibrated. Furthermore, when this expectation value additionally agrees with those obtained from the microcanonical and canonical ensembles, this implies thermalization @rigol2008thermalization.

In exact diagonalization, we work in an effective subspace of the total Hilbert space of the $upright(U) ( 1 )$ quantum link model, such that only gauge-invariant states within the physical sector are accounted for. We employ open boundary conditions, even though at sufficiently large system sizes, there is little difference from the case with periodic boundary conditions.

== Diagonal ensemble
<diagonal-ensemble>
Quenching the initial state $|Psi_0 chevron.r$ with the $upright(U)(1)$ quantum link model Hamiltonian $hat(H)$ leads to the dynamics
$
  hat(rho)(t) &= e^(-i hat(H) t) |Psi_0 chevron.r chevron.l Psi_0| e^(i hat(H) t) \
  &= sum_(m,n) e^(-i (E_m - E_n) t) chevron.l E_m | Psi_0 chevron.r chevron.l Psi_0 | E_n chevron.r |E_m chevron.r chevron.l E_n| \
  &= sum_(m != n) e^(-i (E_m - E_n) t) chevron.l E_m | Psi_0 chevron.r chevron.l Psi_0 | E_n chevron.r |E_m chevron.r chevron.l E_n| \
  &+ sum_m abs(chevron.l E_m | Psi_0 chevron.r)^2 |E_m chevron.r chevron.l E_m|,
$ <eq:rho>
where ${|E_m chevron.r}$ is the eigenbasis of $hat(H)$. The long-time average of any observable will be dominated by the second term of the last equality in @eq:rho. This gives rise to the diagonal ensemble
$
  hat(rho)_"DE" = sum_m abs(chevron.l E_m | Psi_0 chevron.r)^2 |E_m chevron.r chevron.l E_m|,
$
which describes the steady state to which the system equilibrates at late times.

== Canonical ensemble
<canonical-ensemble>
Quenching the initial state $|Psi_0 chevron.r$ with the $upright(U)(1)$ quantum link model Hamiltonian $hat(H)$ gives rise to the energy
$
  E_0 = chevron.l Psi_0 | hat(H) | Psi_0 chevron.r .
$
This is a conserved quantity throughout the whole unitary time evolution of our isolated system. As such, if there is a canonical ensemble,
$
  hat(rho)_"CE" = frac(e^(-beta hat(H)), op("Tr") e^(-beta hat(H))),
$ <eq:CE>
to which the system thermalizes, then it must satisfy
$
  E_0 = op("Tr")(hat(H) hat(rho)_"CE").
$
This is a single equation with the only unknown being the inverse temperature $beta$ of the thermal steady state, and it can be numerically solved using, e.g., Newton's method. If thermalization does occur, then the temporal average of the unitary dynamics of any local observable $hat(O)$ over sufficiently long evolution times should be equivalent to the prediction by the canonical ensemble,
$
  lim_(t -> oo) frac(1, t) integral_0^t dif s chevron.l Psi_0 | e^(i hat(H) s) hat(O) e^(-i hat(H) s) | Psi_0 chevron.r equiv op("Tr")(hat(O) hat(rho)_"CE").
$
Moreover, in case of thermalization, then the system must have also equilibrated, meaning additionally to @eq:CE that
$
  op("Tr")(hat(O) hat(rho)_"CE") equiv op("Tr")(hat(O) hat(rho)_"DE"),
$
i.e., that the expectation value of a local observable should be the same when obtained through the canonical or diagonal ensemble.

#figure(scope: "parent", placement: auto, image("figures/Fig-S5.pdf", width: 140mm),
  caption: [
    Nonequilibrium thermalization dynamics for quench parameter $m = - 0.8 kappa$. (a) Initial-state energy densities for $m = - 0.8 kappa$. We choose two initial states with unequal energy density to perform the dynamics. (b) Here we show the nonequilibrium thermalization dynamics for the initial states shown in panel #strong[a], and without the same energy density, they do not converge to a common steady state. The dashed line in panel #strong[b] are thermal values calculated from the gauge theory thermal ensemble with corresponding energies.
  ]
)

== Microcanonical ensemble
<microcanonical-ensemble>
The microcanonical ensemble is constructed from the eigenstates of the quench Hamiltonian $hat(H)$ that lie within the energy shell $[E_0 - Delta E, E_0 + Delta E]$. Formally, this ensemble is
$
  hat(rho)_"ME" = frac(1, cal(N)_(E_0, Delta E)) sum_(m; abs(E_m - E_0) <= Delta E) |E_m chevron.r chevron.l E_m|,
$
where $cal(N)_(E_0, Delta E)$ is the number of eigenstates in the energy shell $[E_0 - Delta E, E_0 + Delta E]$. We have chosen the half-width to be $Delta E = 0.05 kappa$, although the thermal value predicted by the microcanonical ensemble is robust to the exact value of $Delta E$.

In case of thermalization, different thermal ensembles will give the same expectation value for a given observable $hat(O)$. Given that thermalization also indicates equilibration, this leads to
$
  op("Tr")(hat(O) hat(rho)_"ME") equiv op("Tr")(hat(O) hat(rho)_"CE") equiv op("Tr")(hat(O) hat(rho)_"DE").
$

== Infinite-temperature state
<infinite-temperature-state>
We consider the fully filled initial state with $chevron.l hat(n)_(upright("matter")) chevron.r = 1$ in the gauge theory, which corresponds to $| psi_0 chevron.r = | . . .10101 . . . chevron.r$ as depicted in the first line of @fig:app-Gauss-law. For $m = 0$, we have $ E_0 = chevron.l psi_0 | hat(H)_(upright("gauge")) | psi_0 chevron.r = 0 #h(0em) . $ The operator $ hat(V) = product_ell hat(S)_(ell  thin  ell + 1)^z $ anti-commutes with the Hamiltonian, ${ hat(V)  thin  hat(H)_(upright("gauge")) } = 0$, such that for any eigenstate $| e chevron.r$ with $hat(H)_(upright("gauge")) | e chevron.r = E | e chevron.r$ there is an associated state $|tilde(e) chevron.r = hat(V) |e chevron.r$ with eigenvalue $hat(H)_"gauge" |tilde(e) chevron.r = -E |tilde(e) chevron.r$. Hence, the spectrum is symmetric around $E_0 = 0$. Since $| psi_0 chevron.r$ is an eigenstate of $hat(V)$ with eigenvalue $plus.minus 1$ it is symmetrically distributed in the spectrum which is in conflict with a thermal state except for $T = oo$.

= Sensitivity of thermal value to the conserved quantity
<sensitivity-of-thermal-value-to-the-conserved-quantity>
The thermal value of a thermal ensemble is determined by its conserved quantities. In #strong[d], we show that starting in initial states with the same energy density leads to quench dynamics that converge to steady states with the same thermal value for quench parameters $m = 0$ and $m = - 0.8 kappa$. To further investigate the role of the energy density in thermalization dynamics, we choose two initial states with unequal energy density for quench parameter $m = - 0.8 kappa$, as shown in #strong[a]. We apply the preparation ramp to initialize the states with different energy densities at ramp times $tau = 0$ and $13$ ms. In #strong[b], the quench dynamics due to these two initial states show a clear deviation from each other in their long-time steady states, which agrees well with our predictions.



#bibliography("refs.bib", style: "american-physics-society", title: [References])
