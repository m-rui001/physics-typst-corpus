// ---- document setup ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set math.equation(numbering: (n) => "S(" + str(n) + ")")
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#set figure(numbering: (n) => "S" + str(n))
#show figure.caption: set align(left)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(15pt, weight: "bold")[SUPPLEMENTARY MATERIAL]
  #v(0.6em)
  #text(11pt)[for "Thermalization dynamics of a gauge theory on a quantum simulator"]
]
#v(1.4em)

= Details on the gauge theory Hamiltonian
<sec:hamiltonian-details>

In the main text, we have used a particle-hole transformation to express the spin-1/2 U(1) quantum link model (QLM) in a "charge basis" where excitations of the fermion fields on matter sites relate to the presence of electric charges. Here, we outline this particle-hole transformation in detail. We start with the Hamiltonian of the spin-1/2 U(1) QLM with staggered fermions @Kogut1983
$
  hat(H)_"gauge" = sum_l [ frac(kappa, 2) lr(hat(psi)_l^dagger hat(S)^(+)_(l,l+1) hat(psi)_(l+1) + "H.c.") + m (-1)^l hat(psi)_l^dagger hat(psi)_l ]
$ <eq:qed>
Here, the generators of the U(1) gauge symmetry are the Gauss operators $hat(G)_l = hat(psi)_l^dagger hat(psi)_l + ((-1)^(l+1) - 1)/2 - hat(S)^z_(l-1,l) + hat(S)^z_(l,l+1)$, with eigenvalues $g_l$ that locally determine the gauge-invariant sector. In our work, we choose the target sector as $g_l = 0$, $forall l$. The Hamiltonian Eq.~#ref(<eq:qed>, supplement: none) is invariant under the transformation $hat(H) = hat(V)_l^dagger hat(H) hat(V)_l$, $forall l$ with the unitary operator $hat(V)_l = "exp"(i alpha_l hat(G)_l)$, where $alpha_l$ is a continuous angle $in (0, 2 pi]$ which may depend on the lattice site index $l$.

To employ the particle-hole transformation, we replace for even matter sites
$
  &hat(psi)^dagger_(2l) hat(psi)_(2l) -> 1 - hat(psi)^dagger_(2l) hat(psi)_(2l), quad hat(psi)_(2l) -> hat(psi)^dagger_(2l), \
  &hat(S)^z_(2l,2l+1) -> (-1) hat(S)^z_(2l,2l+1), quad hat(S)^(plus.minus)_(2l,2l+1) -> hat(S)^(minus.plus)_(2l,2l+1). \
$
The Hamiltonian of the spin-1/2 U(1) QLM now becomes Eq.~(1) of the main text, where we additionally drop an irrelevant constant. The generator of the U(1) gauge symmetry is replaced by
$
  hat(G)_l ->& (-1)^(l+1) lr(hat(S)^z_(l-1,l) + hat(S)^z_(l,l+1) + hat(psi)_l^dagger hat(psi)_l). \
$
Locally, it allows for a set of three states as illustrated in Fig.~#ref(<fig:gauss>, supplement: none)~#strong[a], which in an extended lattice are coupled to gauge-invariant many-body states. The gauge-invariant interaction term can now be readily connected to the creation and annihilation of a pair of electric charges, see Fig.~#ref(<fig:gauss>, supplement: none)~#strong[b]. Furthermore, the staggering in the mass term has been removed through the particle-hole transformation.

#figure(image("figures/Fig-S1.pdf", width: 52%),
  caption: [
    Details on the mapping of the gauge theory. (a)~We display the locally allowed configurations in our quantum simulator and their analogs in the gauge theory according to Gauss law. (b)~We show the frequently used initial state with $⟨ hat(n)_"matter" ⟩$ in both gauge theory and quantum simulator and illustrate the transport of fermions in the subsequent dynamics.
  ]
) <fig:gauss>

= Mapping the Bose–Hubbard simulator onto the U(1) gauge theory
<sec:mapping>

The experiment is governed by the Bose–Hubbard Hamiltonian
$
  hat(H)_"exp" = sum_j [ J lr(hat(b)^dagger_j hat(b)_(j+1) + "H.c.") + epsilon_j hat(n)_j + frac(U, 2) hat(n)_j (hat(n)_j - 1) ]
$ <eq:hexp>
where $epsilon_j = j Delta + (-1)^j delta / 2$ encodes the potentials from the staggered superlattice and the gravitational gradient, and $hat(n)_j = hat(b)^dagger_j hat(b)_j$ is the number operator.
For $J << delta, U$ and $U ∼ 2 delta$, we derive the effective Hamiltonian (valid in the bosonic occupation subspace defined below)
$
  hat(H)_"eff" = sum_{j in e} [ frac(kappa, 2 sqrt(2)) lr(hat(b)^dagger_j hat(b)^dagger_(j+2) hat(b)^2_(j+1) + "H.c.") + m hat(b)^dagger_j hat(b)_j ]
$ <eq:eff>
at second order in perturbation theory, where $m = delta - U/2$, and the sum runs over all even ($j in e$) optical lattice wells corresponding to the matter sites $l$. The correlated hopping interaction $kappa$ is given by
$
  kappa = 2 sqrt(2) J^2 [ frac(delta, delta^2 - Delta^2) + frac(U - delta, (U - delta)^2 - Delta^2) ] \
$
Here, we have also considered the condition $Delta >> kappa$, to suppress second-order tunneling over two sites. Close to resonance, i.e., $U approx 2 delta$, and using $Delta << delta, U$ as realized in our experiment, we have $kappa approx 8 sqrt(2) J^2 / U$.

For the considered lattice parameters and initial state, the system is effectively constrained to the site occupations $| 0 ⟩$ and $| 1 ⟩$ for the even sites of the superlattice (matter sites), and $| 0 ⟩$ and $| 2 ⟩$ for the odd sites of the superlattice (gauge links). The Hamiltonian Eq.~#ref(<eq:eff>, supplement: none) as well as the following operator identifications are valid in this occupation subsector of the Hilbert space and should be interpreted with the corresponding projection operators $cal(P)_j$ onto the associated local subspace.
To make direct contact to the lattice gauge theory Hamiltonian Eq.~(1), we identify the bosonic creation operators on odd superlattice wells ($2l + 1 = j in o$) as the gauge fields on the gauge links $(l, l + 1)$
$
  &hat(b)^2_(j in o) = sqrt(2) hat(S)^(-)_(l,l+1), \
  &hat(n)_(j in o) = 2 hat(S)^z_(l,l+1) + 1. \
$
Further, using a Jordan–Wigner transformation, we map the bosonic creation operators on even superlattice wells, $2l = j in e$, to fermionic matter field operators $hat(psi)_l$
$
  &hat(b)_(j in e)^"(†)" = (-1)^l e^(-) i pi sum_(l' < l) hat(psi)^dagger_(l') hat(psi)_(l') hat(psi)_l^"(†)", \
  &hat(n)_(j in e) = hat(psi)_l^dagger hat(psi)_l, \
$
These mappings yield the lattice gauge theory Hamiltonian Eq.~(1).

= State preparation and detection
<sec:state-prep>

The experiment begins with a single layer of quasi-2D $⟨ hat(n) ⟩ = 1$ Mott insulator of $""^(87)"Rb"$ atoms prepared in the hyperfine state $| F = 1, m_F = -1 ⟩$. We employ the staggered-immersion cooling technique with an optical superlattice along the $x$-axis to reach a filling rate of $99.2%$ @Yang2020. The optical superlattice consists of two standing waves with laser frequencies $lambda_s = 767$ nm and $lambda_l = 1534$ nm, forming the potential
$
  V(x) = V_s "cos"^2(k x) - V_l "cos"^2(k x / 2 + phi),
$ <eq:superlattice>
where $k = 2 pi / lambda_"s"$ is the wave number of short lattice, and $V_s$ and $V_l$ are the depths of the short and long lattices, respectively. The relative phase $phi$ controlled by the relative frequency of these lasers determines the superlattice structure. The quench dynamics is observed at $phi = pi / 4$, forming the staggered potential with equal hopping $J$ between neighboring sites, while the site-selective addressing is performed at $phi = 0$, indicating a balanced condition for the double well.

To perform the site-selective addressing, we first set the bias magnetic field along the $x$-axis, then by tuning the polarization of the short lattice along the $x$-axis with an electro-optical modulator, the hyperfine transition frequency between the hyperfine states $| F = 1, m_F = -1 ⟩$ and $| F = 2, m_F = -2 ⟩$ of odd and even sites are split by $28$ kHz. Atoms on the odd or even sites can then be adiabatically transferred to $| F = 2, m_F = -2 ⟩$, which is resonant with the imaging laser. The initial state with $⟨ hat(n)_"matter" ⟩ = 1$ and $⟨ hat(n)_"gauge" ⟩ = 0$ is prepared by simply transferring and removing all atoms on odd sites with the imaging laser. On the other hand, for detecting atom number density, we transfer and then extract $⟨ hat(n)_"gauge" ⟩$ and $⟨ hat(n)_"matter" ⟩$ with in-situ absorption imaging of odd and even sites successively in one experimental sequence.

To access various gauge-invariant initial states with $⟨ hat(n)_"matter" ⟩ < 1$ in Fig.~4, we start with the $⟨ hat(n)_"matter" ⟩ = 1$ state, and using an optimized version of the adiabatic ramp described in Ref.~@Yang2020, we can prepare states ranging from $⟨ hat(n)_"matter" ⟩ = 1$ to $⟨ hat(n)_"matter" ⟩ = 0.21$ by stopping the ramp at certain time $tau$ (see Fig.~4#strong[b]).

To obtain the gauge violation $eta$ during the quench dynamics, we measure the density of odd-number of atoms occupying the gauge sites, which is done by parity projection with the photoassociation (PA) laser. The PA laser excites pairs of atoms to molecular states which quickly decay to free channels by emitting photons, thereby imparting atoms with the kinetic energy required to escape from the lattice potential. After a certain evolution time, a $20$ ms PA laser pulse was applied with the intensity of $0.67$ $text("W"/"cm"^2)$. An efficiency of $98%$ was reached for removing doublons.

= Identifying the resonance condition
<sec:resonance>

#figure(image("figures/Fig-S2.pdf", width: 54%),
  caption: [
    Late-time parameter space. The average atom population on gauge sites after $120$ ms evolution, scanned over the parameters $delta / J$. The peaks in the figure correspond to the resonance condition of the correlated second-order hopping, $delta = U / 2$.
  ]
) <fig:deltascan>

We first perform a 2D parameter scan to find the resonance condition of correlated second-order tunneling that realizes the gauge theory (see Fig.~2#strong[c]). Starting from the initial state with $⟨ hat(n)_"matter" ⟩ = 1$, which is the ground state of Hamiltonian Eq.~(1) at $m -> -oo$, we bring the system out-of-equilibrium by turning on the gauge coupling $kappa$ while quenching the effective mass from $m -> -oo$ to $m approx 0$ with $m = delta - U / 2$. By setting the relative phase $phi = pi / 4$, we configure the superlattice in the form of a #emph[staggered] potential (see Fig.~1#strong[b]), where $delta$ is mainly determined by the long lattice depth while $J$ is set by the short lattice depth. The on-site interaction $U$ is then determined by the trapping frequency of the short lattice along the $x$, $y$, and $z$ axes. Each data point in the parameter scan is obtained with $120$ ms of quench evolution during which the system roughly relaxes to a steady state. The scans are done by fixing $U$ and $J$ while changing $delta$ for each quench evolution, where Fig.~#ref(<fig:deltascan>, supplement: none) shows three examples of the scans. The suppression of direct tunneling can be seen as $⟨ hat(n)_"matter" ⟩$ goes to 1 with increasing $delta / J$. At $delta approx U / 2$, a resonance peak can be observed corresponding to $m approx 0$ in the gauge theory. We perform our further studies in the vicinity of these resonance peaks.

= Approaching the gauge theory
<sec:approaching>

#figure(image("figures/Fig-S3.pdf", width: 54%),
  caption: [
    Damped-sine fitting for different staggering. (a) We extract the oscillation frequency ($f_"exp" = 21$ Hz) at large staggering $delta / J = 16$. (b) At staggering $delta / J = 6.5$, two oscillation frequencies ($f_1 = 507$ Hz, $f_2 = 172$ Hz) are extracted from the data. The solid blue curves result from the damped-sine fitting with Eq.~#ref(<eq:dualsine>, supplement: none). They extend over the times considered for the fit.
  ]
) <fig:dampsine>

For cases in Fig.~2#strong[b] where we have the strongest quench from $m -> -oo$ to $m = delta - U / 2 = 0$, the many-body oscillation frequency of the gauge theory solely depends on the coupling strength $kappa$. We associate the correlated second-order tunneling $8 sqrt(2) J^2 / U$ in the Bose–Hubbard simulator with $kappa$ through perturbation theory, and gauge violations introduced by direct tunneling $J$ leads the Bose–Hubbard simulator to deviate from the gauge theory. With large $U / J$, gauge violation is suppressed and the frequency of the Bose–Hubbard simulator approaches the gauge theory. To quantitatively identify this approach to the gauge theory, we extract the oscillation frequency $f_"exp"$ in experiment with a damped-sine fitting, and calculate its ratio with the gauge-theory frequency $f_"gauge"$. And to capture both first and second-order tunneling in the Bose–Hubbard simulator, we use the dual-frequency damped sine-wave function for the fitting:
$
  n = n_0 + A_1 e^(- gamma_1 t) sin(2 pi f_1 t + b_1) + A_2 e^(- gamma_2 t) sin(2 pi f_2 t + b_2). \
$ <eq:dualsine>
where $omega_(1,2)$ represent the two angular frequencies extracted from the oscillations and $gamma_(1(2))$ indicates the damping rate for each frequency. For quench dynamics in the gauge-invariant regime ($delta / J > 10$, case 1 in Fig.~2#strong[a]) and the "nongauge" regime ($delta / J < 2$, case 3 in Fig.~2#strong[a]), oscillations are dominated by one of the tunneling processes and fitting gives identical $f_1$ and $f_2$, whence we take the average $f_"exp" = (f_1 + f_2) / 2$. However, in the "cross-over" regime ($2 < delta / J < 10$, case 2 in Fig.~2#strong[a]), a clear beating of two frequencies can be seen, and both frequencies are extracted. As the higher frequency comes from direct tunneling $J$, we take the slower frequency which captures the second-order tunneling $f_"exp" = min(f_1, f_2)$. To avoid turning-on effects, we start the fit from the first minimum, see Fig.~#ref(<fig:dampsine>, supplement: none).

The numerical data shown in Fig.~2#strong[b] (solid curve) is obtained from $t$-DMRG with $L = 32$ sites. We calculated 129 sets of $t$-DMRG data with increasing staggering at different conditions ($delta - U / 2 = 0$, $delta - U / 2 = plus.minus 3$ Hz) and applied the damped sine-wave function on the data. The solid curve in Fig.~2#strong[b] represents the result at the resonance condition ($delta - U / 2 = 0$) while the grey area describes the boundary of off-resonance conditions ($delta - U / 2 = plus.minus 3$ Hz).

= Quantifying the gauge violation
<sec:violation>

#figure(image("figures/Fig-S4.pdf", width: 54%),
  caption: [
    #strong[Gauge violation measure.] We numerically compare our experimentally accessible local violation measure $eta$ (thick red line) to a global measure $epsilon$ (thin green line, see text). We find reasonable agreement for both the regime close to (case 1) and far away from the gauge theory (cases 2 and 3). In the second, non-gauge regime, the system quickly reaches the maximum global violation $1 / L_"g"$. Here, the system size is $L_"g" = 5$.
  ]
) <fig:vio>

Overall, our results show a faithful implementation of the gauge theory for the considered quench dynamics starting from far-from-equilibrium initial states. We achieve this by strongly suppressing processes that violate the gauge symmetry. To further quantify this, in the following we consider the direct tunneling for the quench dynamics starting from the "fully filled" initial state. In Fig.~#ref(<fig:vio>, supplement: none), we show the average gauge-violation per site $eta$, as defined in the main text, and compare it to the global measure $epsilon = (1 - ⟨ hat(P)_G ⟩) / L_"g"$, where $hat(P)_G$ is the projector onto the exact gauge-invariant subsector of the full Hilbert space.

In panel #strong[a], we see that for the employed evolution parameters and initial state, the two measures agree in the gauge regime (case 1). Close to the gauge regime, the quantitative agreement can be understood from a simple error model assuming that gauge errors appear at every site independently and at the same rate. Suppose this rate is given by our experimentally accessible measure $eta$, then the probability of remaining in the gauge-invariant subsector is approximately given by $⟨ hat(P)_G ⟩ ∼ (1 - eta)^(L_"g") approx 1 - L_"g" eta$, such that $epsilon ∼ eta$. While this is strictly only valid for $L_"g" eta << 1$, our numerical results in Fig.~#ref(<fig:vio>, supplement: none) suggest reasonable agreement even away from the gauge-invariant regime (cases 2 and 3 in panels #strong[b] and #strong[c]).

= Thermal ensembles for the U(1) quantum link model
<sec:ensembles>

For the calculation of the thermal values for the steady states in our quench dynamics, we utilize the diagonal, canonical, and microcanonical ensembles. When the long-time average of the unitary dynamics agrees with the expectation value predicted by the diagonal ensemble, this indicates that the system has equilibrated. Furthermore, when this expectation value additionally agrees with those obtained from the microcanonical and canonical ensembles, this implies thermalization @rigol2008thermalization.

In exact diagonalization, we work in an effective subspace of the total Hilbert space of the U(1) quantum link model, such that only gauge-invariant states within the physical sector are accounted for. We employ open boundary conditions, even though at sufficiently large system sizes, there is little difference from the case with periodic boundary conditions.

== Diagonal ensemble
<sec:diagonal>

Quenching the initial state $| Psi_0 ⟩$ with the U(1) quantum link model Hamiltonian $hat(H)$ leads to the dynamics
$
  hat(rho)(t)
  &= e^(-i hat(H) t) | Psi_0 ⟩ ⟨ Psi_0 | e^(i hat(H) t) \
  &= sum_(m,n) e^(-i (E_m - E_n) t) | E_m ⟩ ⟨ Psi_0 | Psi_0 ⟩ ⟨ E_n | E_m ⟩ ⟨ E_n | \
  &= sum_(m != n) e^(-i (E_m - E_n) t) | E_m ⟩ ⟨ Psi_0 | Psi_0 ⟩ ⟨ E_n | E_m ⟩ ⟨ E_n | \
  &+ sum_m | ⟨ E_m | Psi_0 ⟩ |^2 | E_m ⟩ ⟨ E_m | , \
$ <eq:rho>
where ${ | E_m ⟩ }$ is the eigenbasis of $hat(H)$. The long-time average of any observable will be dominated by the second term of the last equality in Eq.~#ref(<eq:rho>, supplement: none). This gives rise to the diagonal ensemble
$
  hat(rho)_("DE") = sum_m | ⟨ E_m | Psi_0 ⟩ |^2 | E_m ⟩ ⟨ E_m | , \
$
which describes the steady state to which the system equilibrates at late times.

== Canonical ensemble
<sec:canonical>

Quenching the initial state $| Psi_0 ⟩$ with the U(1) quantum link model Hamiltonian $hat(H)$ gives rise to the energy
$
  E_0 = ⟨ Psi_0 | hat(H) | Psi_0 ⟩ . \
$
This is a conserved quantity throughout the whole unitary time evolution of our isolated system. As such, if there is a canonical ensemble,
$
  hat(rho)_("CE") = frac(e^(- beta hat(H)), "Tr"[e^(- beta hat(H))]) , \
$
to which the system thermalizes, then it must satisfy
$
  E_0 = "Tr"[hat(H) hat(rho)_("CE")] . \
$
This is a single equation with the only unknown being the inverse temperature $beta$ of the thermal steady state, and it can be numerically solved using, e.g., Newton's method. If thermalization does occur, then the temporal average of the unitary dynamics of any local observable $hat(O)$ over sufficiently long evolution times should be equivalent to the prediction by the canonical ensemble,
$
  lim_(t -> oo) frac(1, t) integral_0^t "d"s ⟨ Psi_0 | e^(i hat(H) s) hat(O) e^(-i hat(H) s) | Psi_0 ⟩ equiv "Tr"[hat(O) hat(rho)_("CE")] . \
$ <eq:CE>
Moreover, in case of thermalization, then the system must have also equilibrated, meaning additionally to Eq.~#ref(<eq:CE>, supplement: none) that
$
  "Tr"[hat(O) hat(rho)_("CE")] equiv "Tr"[hat(O) hat(rho)_("DE")] , \
$
i.e., that the expectation value of a local observable should be the same when obtained through the canonical or diagonal ensemble.

#figure(image("figures/Fig-S5.pdf", width: 88%),
  caption: [
    Nonequilibrium thermalization dynamics for quench parameter $m = -0.8 kappa$. (a) Initial-state energy densities for $m = -0.8 kappa$. We choose two initial states with unequal energy density to perform the dynamics. (b) Here we show the nonequilibrium thermalization dynamics for the initial states shown in panel #strong[a], and without the same energy density, they do not converge to a common steady state. The dashed line in panel #strong[b] are thermal values calculated from the gauge theory thermal ensemble with corresponding energies.
  ]
) <fig:thermal2>

== Microcanonical ensemble
<sec:microcanonical>

The microcanonical ensemble is constructed from the eigenstates of the quench Hamiltonian $hat(H)$ that lie within the energy shell $[E_0 - Delta E, E_0 + Delta E]$. Formally, this ensemble is
$
  hat(rho)_("ME") = frac(1, cal(N)_(E_0, Delta E)) sum_{m; \ abs(E_m - E_0) <= Delta E} | E_m ⟩ ⟨ E_m | , \
$
where $cal(N)_(E_0, Delta E)$ is the number of eigenstates in the energy shell $[E_0 - Delta E, E_0 + Delta E]$. We have chosen the half-width to be $Delta E = 0.05 kappa$, although the thermal value predicted by the microcanonical ensemble is robust to the exact value of $Delta E$.

In case of thermalization, different thermal ensembles will give the same expectation value for a given observable $hat(O)$. Given that thermalization also indicates equilibration, this leads to
$
  "Tr"[hat(O) hat(rho)_("ME")] equiv "Tr"[hat(O) hat(rho)_("CE")] equiv "Tr"[hat(O) hat(rho)_("DE")] . \
$ <eq:finale>

== Infinite-temperature state
<sec:infinite-temp>

We consider the fully filled initial state with $⟨ hat(n)_("matter") ⟩ = 1$ in the gauge theory, which corresponds to $| psi_0 ⟩ = | "...10101..." ⟩$ as depicted in the first line of Fig.~#ref(<fig:gauss>, supplement: none). For $m = 0$, we have
$
  E_0 = ⟨ psi_0 | hat(H)_("gauge") | psi_0 ⟩ = 0 \ . \
$
The operator
$
  hat(V) = product_ell hat(S)^z_(ell, ell+1) \
$
anti-commutes with the Hamiltonian, ${hat(V), hat(H)_("gauge")} = 0$, such that for any eigenstate $| e ⟩$ with $hat(H)_("gauge") | e ⟩ = E | e ⟩$ there is an associated state $| tilde(e) ⟩ = hat(V) | e ⟩$ with eigenvalue $hat(H)_("gauge") | tilde(e) ⟩ = -E | tilde(e) ⟩$. Hence, the spectrum is symmetric around $E_0 = 0$. Since $| psi_0 ⟩$ is an eigenstate of $hat(V)$ with eigenvalue $plus.minus 1$ it is symmetrically distributed in the spectrum which is in conflict with a thermal state except for $T = oo$.

= Sensitivity of thermal value to the conserved quantity
<sec:sensitivity>

The thermal value of a thermal ensemble is determined by its conserved quantities. In Fig.~4#strong[d], we show that starting in initial states with the same energy density leads to quench dynamics that converge to steady states with the same thermal value for quench parameters $m = 0$ and $m = -0.8 kappa$. To further investigate the role of the energy density in thermalization dynamics, we choose two initial states with unequal energy density for quench parameter $m = -0.8 kappa$, as shown in Fig.~#ref(<fig:thermal2>, supplement: none)~#strong[a]. We apply the preparation ramp to initialize the states with different energy densities at ramp times $tau = 0$ and $13$ ms. In Fig.~#ref(<fig:thermal2>, supplement: none)~#strong[b], the quench dynamics due to these two initial states show a clear deviation from each other in their long-time steady states, which agrees well with our predictions.

#pagebreak()
#bibliography("refs.bib", style: "american-physics-society")
