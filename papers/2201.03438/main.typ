#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.75cm, top: 1.92cm, bottom: 2.40cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: "1.1")
#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(separator: [.])
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none, number-align: bottom)


#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#figure(
  placement: top, scope: "parent", kind: "title", numbering: none,
  block(width: 100%)[
    #align(center)[
      #text(17pt, weight: "bold")[Many-body Hilbert space scarring on a superconducting processor]
      #v(1.2em)
      #text(10.5pt)[Pengfei Zhang#super[1], Hang Dong#super[1], Yu Gao#super[1], Liangtian Zhao#super[2], Jie Hao#super[2], Jean-Yves Desaules#super[3], Qiujiang Guo#super[1], Jiachen Chen#super[1], Jinfeng Deng#super[1], Bobo Liu#super[1], Wenhui Ren#super[1], Yunyan Yao#super[1], Xu Zhang#super[1], Shibo Xu#super[1], Ke Wang#super[1], Feitong Jin#super[1], Xuhao Zhu#super[1], Bing Zhang#super[4], Hekang Li#super[1], Chao Song#super[1], Zhen Wang#super[1], Fangli Liu#super[5], Zlatko Papić#super[3], Lei Ying#super[1], H. Wang#super[1], Ying-Cheng Lai#super[6]]
    ]
    #v(0.6em)
    #block(spacing: 0.45em)[
  #text(9pt)[#super[1] Department of Physics, ZJU-Hangzhou Global Scientific and Technological Innovation Center, Interdisciplinary Center for Quantum Information, and Zhejiang Province Key Laboratory of Quantum Technology and Device, Zhejiang University, Hangzhou 310027, China] \
  #text(9pt)[#super[2] Institute of Automation, Chinese Academy of Sciences, Beijing 100190, China] \
  #text(9pt)[#super[3] School of Physics and Astronomy, University of Leeds, Leeds LS2 9JT, UK] \
  #text(9pt)[#super[4] Alibaba-Zhejiang University Joint Research Institute of Frontier Technologies, Hangzhou 310027, China] \
  #text(9pt)[#super[5] QuEra Computing Inc., Boston, Massachusetts 02135, USA] \
  #text(9pt)[#super[6] School of Electrical, Computer and Energy Engineering, and Department of Physics, Arizona State University, Tempe, Arizona 85287, USA] \
    ]
    #v(1.2em)
    #block(inset: (left: 2.5em, right: 2.5em))[
// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: March 22, 2022)]]

      Quantum many-body scarring (QMBS) -- a recently discovered form of weak ergodicity breaking in strongly-interacting quantum systems -- presents opportunities for mitigating thermalization-induced decoherence in quantum information processsing. However, the existing experimental realizations of QMBS are based on kinetically-constrained systems where an emergent dynamical symmetry “shields” such states from the thermalizing bulk of the spectrum. Here, we experimentally realize a distinct kind of QMBS phenomena by approximately decoupling a part of the many-body Hilbert space in the computational basis. Utilizing a programmable superconducting processor with 30 qubits and tunable couplings, we realize Hilbert space scarring in a non-constrained model in different geometries, including a linear chain as well as a quasi-one-dimensional comb geometry. By performing full quantum state tomography on 4-qubit subsystems, we provide strong evidence for QMBS states by measuring qubit population dynamics, quantum fidelity and entanglement entropy following a quench from initial product states. Our experimental findings broaden the realm of QMBS mechanisms and pave the way to exploiting correlations in QMBS states for applications in quantum information technology.
    ]
  ],
)





#figure(placement: top, scope: "parent", [#image("figures/fig1.pdf", width: 100%)],
  caption: [
    #strong[Experimental setup and identification of QMBS states via quantum state tomography.] (a) Experimental superconducting circuit with qubits and couplers in a square geometry. Light gray dashed rectangles represent dimers that constitute the chain with intra coupling $J_(upright(a))$, inter coupling $J_(upright(e))$, and small cross coupling $J_(upright(x))$. (b) Left upper: A schematic illustration of the dynamics of the collective dimer states $| Pi chevron.r$ and $| Pi' chevron.r$. Left lower: The ratio $Delta / Gamma$ as a function of the system size $L$ for different ratios of $J_(upright(a)) / J_(upright(e))$ and for a fixed value of $J_(upright(x))$ listed in @sfig:Jx of the Supplementary Material. Right: a $4$-dimensional hypercube in the Hilbert space. (c)-(d): Quantum state tomography for the four-qubit fidelity and entanglement entropy in a $30$-qubit chain for initial thermalizing states (red and orange) and a QMBS state (green). Blue dot-dashed curves stand for the dynamics of state $| Pi' chevron.r$ with $L = 20$ and a higher coupling ratio $J_(upright(a)) / J_(upright(e)) = 2.5$. (c) Fidelity of the subsystem $A$ as a function of interaction time. The upper left inset illustrates the partition of the many-body system into subsystems $A$ and $B$, where the former contains $4$ qubits for measuring the entanglement entropy. The right inset shows the Fourier transformation amplitude of the four-qubit fidelity and $omega_1 / 2 pi approx 21$ MHz. (d) Time evolution of the entanglement entropy $S_A$. The dotted grey line represents the thermal value $4 ln 2$.
  ]
)
<fig:schematic>



#heading(level: 1, numbering: none)[Introduction]
<introduction>


Strongly-coupled quantum systems provide a wealth of opportunities for fundamental physics as well as practical applications that utilise quantum entanglement, which is naturally abundant in them~@LJLN:2010 @GAN:2014 @MRQM:2021 @AABR:2019. However, the majority of such systems, even if they are perfectly isolated from the external world, undergo chaotic dynamics which gives rise to quantum information scrambling~@SBSH:2016 @XCZZ:2018 @LFSL:2019 @MRQM:2021 @MLBC:2021. The scrambling invariably results in quantum thermalization -- the process described by the so-called Eigenstate Thermalization Hypothesis (ETH)~@Deutsch:1991 @Srednicki:1994 @RDO:2008 @KTLR:2016. Thermalization represents a major challenge that needs to be overcome when such systems are used for practical applications. Thus, developing methods to defy the ETH so as to achieve long-lived-dynamic states, thereby preserving quantum information, has become an important goal of quantum sciences~@BOLK:2021.


Recent discovery of mechanisms for weakly breaking the ETH, such as quantum many-body scarring (QMBS)~@SAP:2021 @MoudgalyaReview, have opened the door to delaying thermalization by preparing the system in special initial states. This route offers more flexibility for designing non-ergodic dynamics than, for example, fine tuning the couplings of the systems to make it integrable, and it avoids the need to strongly disorder the system to drive it into a many-body localized phase~@NH:2015 @AABS:2019 @GCLX:2021 @GCSS:2021. Because of their ability to suppress thermalization, QMBS states are expected to be useful for storing quantum information~@SAP:2021, generating Greenberger--Horne--Zeilinger (GHZ) entangled state~@OLKS:2019 and in quantum-enhanced sensing~@Dooley:2021. However, while there has been a proliferation of theoretical studies of QMBS in a variety of models~@SM:2017 @MRB:2018 @OCMC:2019 @SI:2019 @SYK:2020 @MM:2018 @MB:2020 @MHSR:2020 @MRB:2020 @VMS:2020 @LCH:2020 @HDGC:2020 @LMPC:2020 @Zhao2020 @KMH:2020 @MNSS:2020 @ODea2020 @SVLSDG:2021 @WSSN:2021 @DHTP:2021 @RLF:2021, the experimental realizations of QMBS remain in short supply. The existing QMBS experiments remain focused on a single model with kinetic constraints -- the so-called PXP model~@FendleySachdev @Lesanovsky2012, which has been effectively realized using Rydberg atoms~@BSKL:2017 @BOLK:2021 and ultracold bosons in optical lattices~@Su2022. More recently, ultracold lithium-7 atoms in an optical lattice, which realize the Heisenberg spin model, have been explored as a host of non-thermalizing helix states, reminiscent of QMBS~@Jepsen2021.


In this article, we report the experimental observation of a new class of QMBS states on a superconducting (SC) processor. In contrast to previous realizations in kinetically constrained Rydberg atom arrays, we design QMBS by weakly decoupling one part of the Hilbert space in the computational basis. Our approach is inspired by the topological structure of the Su-Schrieffer-Heeger model of polyacetylene~@SSHModel, which we utilise to create a nearly decoupled subspace with the structure of the hypercube graph. This subspace gives rise to emergent QMBS phenomena, including many-body revivals from special initial states residing in the hypercube, as well as the band of scarred eigenstates. At the same time, the entire system thermalizes due to weaker cross couplings between neighboring qubits. One of the advantages of our SC platform is the tunable $X Y$ coupling between qubits (see Methods section for more details) on a 6 by 6 square lattice configuration, which enables us to emulate many-body systems with both one-dimensional (1D) and quasi-1D systems with comb shape. We investigate circuits of up to $30$ qubits and $29$ couplers, with the Hilbert space dimension $C ( 30 , 15 ) = 155 , 117 , 520$ -- far beyond the limits of classical simulation. Measurements of population dynamics and quantum state tomography for entanglement entropy and quantum fidelity provide strong evidence of the emergence of robust QMBS states, as we demonstrate by directly comparing their slow dynamics against conventional thermalizing states. Our realization of a new QMBS paradigm in a solid state SC platform paves the way to a systematic exploration of scarring and other forms of ergodicity breaking in systems with highly tunable interactions extending beyond one spatial dimension.


#heading(level: 1, numbering: none)[Experimental setup and observation of many-body scar states via quantum state tomography]
<experimental-setup-and-observation-of-many-body-scar-states-via-quantum-state-tomography>


Our experiment utilizes a two-dimensional SC qubit array~@AABR:2019 @WBCC:2021, shown in @fig:schematic\(a), which features high density integration and high degree of controllability over local couplings~@KKYO:2019 @BGGW:2021, allowing to emulate different models in a single device.


We first consider the “snake”-like qubit layout in @fig:schematic\(a). This layout exploits the structure of the Su-Schrieffer-Heeger chain~@SSHModel, where the intra-dimer coupling $J_(i , i + 1) / 2 pi = J_(upright(a)) / 2 pi tilde.eq - 9$ MHz with $i in upright("odd")$ is slightly stronger than the inter-dimer coupling $J_(i , i + 1) / 2 pi = J_(upright(e)) / 2 pi tilde.eq - 6$ MHz with $i in upright("even")$.


In the limit $J_(upright(a)) gt.double J_(upright(e))$, each dimer behaves as a nearly free two-level system, hence the Hilbert space of the SC qubit system has the structure of the hypercube graph -- see @fig:schematic\(b). Such a system supports quantum revivals but they are essentially of a single-particle origin. When $J_(upright(a))$ and $J_(upright(e))$ are comparable in magnitude, we are in the regime of the SSH model where quench dynamics from fully polarized and Néel initial states has recently been investigated in Refs.~@Jafari2017 @Najafi2019. While the Néel state does not display persistent revivals, we will show below that it is possible to identify, based on the hypercube structure, other initial states that #emph[do] exhibit quantum revivals in moderate systems with $10$-$20$ qubits. In order to show that these are #emph[bona fide] QMBS states, we will confirm they are robust to both the increase in system size as well as the breaking of integrability that allows the system to thermalize from most other initial states. Thermalization is our experimental setup is naturally driven by the cross couplings $J_(upright(x)) / 2 pi in \[ 0.3 , 1.2 \]$ MHz -- the couplings between two next nearest neighbor qubits with a physical separation distance $a_(i j) = sqrt(2) a_0$, where $a_0 approx 0.8$ mm is the separation distance of two nearest neighbor qubits. These couplings break the reflection symmetries of the circuit and make the system thermalize. For example, exact diagonalization confirms that the energy level spacings follow the Wigner-Dyson distribution with the level-statistics parameter $chevron.l r chevron.r approx 0.53$ for large symmetry-resolved sectors -- see Supplementary Material (SM).


Now we identify QMBS states based on their special location in the hypercube. Recall that each dimer has four states: $| upright(d)_0 chevron.r = | 00 chevron.r$, $| upright(d)_1 chevron.r = | 11 chevron.r$, $| upright(d)_(+) chevron.r = | 10 chevron.r$, and $| upright(d)_(-) chevron.r = | 01 chevron.r$. At half filling, i.e., with the number of photons $N$ equal to half the total number of qubits $L$, a special class of dimerized states in the computational basis states can be identified. These states all have a single photon in each dimer (i.e they only have $| upright(d)_(+) chevron.r$ or $| upright(d)_(-) chevron.r$), and the connectivity between them in the Hamiltonian forms $N = L / 2$-dimensional hypercube with equal weight edges. Among these, a pair of collective states $| Pi chevron.r = | upright(d)_(+) upright(d)_(-) upright(d)_(+) upright(d)_(-) dots.h.c chevron.r$ and $| Pi' chevron.r = | upright(d)_(-) upright(d)_(+) upright(d)_(-) upright(d)_(+) dots.h.c chevron.r$, illustrated in @fig:schematic\(b), play a special role. These are located on opposite corners of the hypercube and have the unique property of only having intra-dimer couplings (with the exception of the small $J_(upright(x))$ couplings). This helps prevent the information in states $| Pi chevron.r$ and $| Pi' chevron.r$ from rapidly leaking into the thermalizing part of the Hilbert space, with the other product states in the hypercube playing the role of a "buffer" area. The robustness of $| Pi chevron.r$ and $| Pi' chevron.r$ is due to the collective many-body effect and enhanced by the structure-induced potential ($J_(upright(a)) > J_(upright(e))$). The hypercubic structure is robust and naturally it does not contain any cross coupling. Indeed, while the other parts of the Hilbert space are frustrated by the irregular $J_(upright(x))$ couplings, no two states within the hypercube are linked by them. They contribute to the leakage of the wavefunction out of the hypercube but do not affect the dynamics within it.


The sum of the hypercubic thermal couplings (inter dimer and cross couplings) gives the decay rate $Gamma$ of the hypercube to the thermalized parts. The summation of intra hypercubic couplings $Delta$ is given by the number of hypercubic edges, i.e., $Delta = N 2^(N - 1) J_(upright(a))$. The ratio between the sums of the inter and intra hypercubic couplings $Delta / Gamma$ converges to a finite value for different values of $J_(upright(a)) / J_(upright(e))$ (see in @fig:evolution (b)), which shows that the hypercube is not trivially disconnected from the rest of the Hilbert space.


With the high-precision control and readouts of our SC processor, we are able to perform tomography measurements to obtain the non-diagonal elements of the reduced density matrix $rho_A$, which determine the time evolution of the fidelity of the subsystem $F_A ( t )$ and the entanglement entropy $S_A ( t )$. The complexity of such measurements grows rapidly with the size of the subsystem $A$ and below we consider $A$ to be four qubits, as schematically illustrated in the inset of @fig:schematic\(c). The data points in @fig:schematic\(c) give, for a $30$-qubit chain, the time evolution of the first four-quit fidelity for a collective state $| Pi' chevron.r$ and that of a typical thermalizing state. The fidelity of the QMBS state exhibits remarkable revivals with the period of about $50$ ns and the peak value of the first revival can be as high as $0.5$, while no such revivals occur for the thermalizing state.


We emphasize that although we consider a relatively small subsystem of fixed size here, numerical simulations confirm that the behavior of the subsystem fidelity closely mirrors that of the fidelity for the pure state $| Psi ( t ) chevron.r$ of the entire system (see SM). The revivals are enhanced by increasing the ratio $J_(upright(a)) / J_(upright(e))$, which controls the coupling of the hypercube to the rest of the Hilbert space. As we emphasized above, in the extreme limit $J_(upright(a)) gt.double J_(upright(e))$, the dimers are only weakly interacting with each other and the revival dynamics has a single-particle origin. Furthermore, the revivals of the states $| Pi chevron.r$ and $| Pi' chevron.r$ become weak if $L / 2$ is an odd integer with a periodic boundary condition, which is experimentally confirmed (see SM).


In @fig:schematic\(d) we measure the time evolution of the entanglement entropy for both QMBS and conventional thermalizing states. The entanglement entropy is defined as the von Neumann entropy $S_(upright(A)) = - upright("Tr") \[ rho_A upright("log") rho_A \]$, where $rho_A$ is the reduced density matrix of the subsystem $A$.


@fig:schematic\(d) shows the time evolution of $S_A$ for the state $| Pi chevron.r$ as well as a random thermalizing state. The scarred dynamics leads to a slow growth of entanglement entropy, superposed with oscillations whose frequency is twice that of fidelity revivals in @fig:schematic\(c). By contrast, for the thermalizing initial state, the entropy rises rapidly towards the value $4 upright("ln") ( 2 )$, which is approximately the maximum Page entropy for this subsystem.


In addition, the scar features of the states $| Pi chevron.r$ and $| Pi' chevron.r$ can be enhanced by increasing the coupling ratio $J_(upright(a)) / J_(upright(e))$, as illustrated by the suppressed entropy growth in @fig:schematic\(d).


#figure(placement: top, scope: "parent", [#image("figures/fig2.pdf", width: 100%)],
  caption: [
    #strong[Experimentally observed qubit dynamics.] (a)-(b): Contour diagrams of the experimental qubit population as a function of the interaction time for a QMBS and a rapid thermalizing state, respectively. (c)-(d): Generalized imbalance $I ( t )$ extracted from plots (a)-(b) as a function of the interaction time. Insets: imbalance dynamics from experiments (dots or circles) and numerical simulations (solid curves) in a $20$-qubit chain. (e)-(f): The Fourier transformation amplitude of the imbalance in (c)-(d), which characterizes the squared overlap between the initial states and the energy eigenstates. The time window for the fast Fourier transform is extended to $4 med mu$s with zero padding. (g) Fourier peak as a function of the coupling ratio $J_(upright(a)) / J_(upright(e))$ in a chain of $L = 20$ from experimental measurements (green hexagrams) and numerical simulations (dashed curve). (h) The squared Fourier amplitude $g_alpha^2 ( omega = omega_1 )$ for $| alpha chevron.r$ for $120$ randomly chosen initial product states, including two QMBS states (green hexagrams) that are clearly stand out from the rest of thermalizing product states (yellow squares). The simulation parameter values are $J_(upright(a)) / 2 pi = - 9.3$ MHz, $J_(upright(e)) / 2 pi = - 6.1$ MHz and $J_(upright(x)) / 2 pi in \[ 0.3 , 1.2 \]$ MHz.
  ]
)
<fig:evolution>



#heading(level: 1, numbering: none)[Qubit dynamics beyond the limit of classical simulations]
<qubit-dynamics-beyond-the-limit-of-classical-simulations>


To further probe the dynamics at the level of individual qubits, we measure the generalized population imbalance defined as $I ( t ) = ( 1 / L ) sum_i^L chevron.l cal(S)_i^z ( 0 ) chevron.r chevron.l cal(S)_i^z ( t ) chevron.r$. The imbalance is determined by the overlaps $| chevron.l E_n | alpha chevron.r |^2$ of energy eigenstates $| E_n chevron.r$ with the initial state $| alpha chevron.r$ and the phase factors $exp ( - i ( E_n - E_m ) t / ℏ )$, where $m , n$ are eigenstate indices. For a thermalizing initial state, the phases are essentially random and the initial state has roughly equal support on all energy eigenstates. Thus, any imbalance present in the initial state will rapidly diffuse to a value exponentially small in the system size and it cannot be detected via local operators at late times. By contrast, a QMBS initial state has appreciable overlap only on a #emph[few] eigenstates with phases set to integer multiples of a single dominant frequency. This allows a QMBS state to display a persistent quantum revival even at relatively late times.


#figure([#image("figures/fig3.pdf", width: 3in)],
  caption: [
    #strong[Scaling behavior] of the first revival peak $F_A ( t_1 approx 52 upright("ns") )$ of the subsystem $A$, Fourier amplitude $g_Pi ( omega_1 )$, and the inverse Hilbert space dimension $1 / D$ versus the system size for $J_(upright(a)) / 2 pi approx - 9$ MHz and $J_(upright(e)) / 2 pi approx - 6$ MHz. The light blue area denotes the regime where classical simulations using the exact diagonalization method are feasible.
  ]
)
<fig:scaling>



#figure(placement: top, scope: "parent", [#image("figures/fig4.pdf", width: 100%)],
  caption: [
    #strong[QMBS states in a comb tensor system.] (a) The comb tensor topology in the superconducting processor with $L = 20$ qubits. (b) Squared Fourier amplitude $g_alpha^2 ( omega = omega_1 )$ for randomly chosen initial product states. The QMBS states (green hexagrams) are characteristically distinct from the conventional thermalizing product states. (c,d) Dynamics of the imbalance (upper), four-qubit fidelity (middle), and four-qubit entanglement entropy (lower) for the state $| Theta' chevron.r$ (c) and a randomly choose product state (d). The couplings are tuned to $J_(upright(a)) / 2 pi approx - 9$ and $J_(upright(e)) / 2 pi approx - 6$ MHz. All data from experimental measurements.
  ]
)
<fig:comb>



The evolution of population imbalance for individual qubits in a 30-qubit chain is shown in @fig:evolution\(a) and @fig:evolution\(b), which contrast the evolution of a QMBS state and a typical thermalizing state. QMBS exhibits remarkable oscillations which are absent in the thermalizing state. The total imbalance $I ( t )$ is plotted in @fig:evolution\(c) and @fig:evolution\(d), which reveal more clearly the differences between two initial states. In general, for the thermalizing state, after about $30$ ns the population is only half photon in each qubit meaning there is no imbalance.


The distinct features of QMBS states can be further highlighted through the overlap between the product states and the eigenstates $| chevron.l alpha | E_n chevron.r |^2$, which can be represented by the Fourier spectrum of the imbalance, as shown in @fig:evolution\(e) and @fig:evolution\(f) for the QMBS and thermalizing states respectively. The peak value of the squared Fourier spectrum $g_alpha ( omega )$ with the first-order domain eigenstates is $omega_1 / 2 pi approx 21$ MHz. We test 120 random initial product states and find that the squared Fourier amplitudes $g_alpha^2 ( omega = omega_1 )$ of QMBS states are unambiguously distinct from those of conventional thermalizing states, as shown in @fig:evolution\(h). The variations in the Fourier amplitude for rapidly thermalizing dynamics become suppressed as system size is increased. Note that, for the cases in @fig:evolution\(a-f), to carry out the exact simulations is computationally impractical. To validate the experimental data numerically, it is necessary to use a smaller system size, say $L = 20$, whose results are shown in the insets in @fig:evolution (c-f), where the agreement between numerical and experimental results is excellent.


The advantage of our experimental system -- the tunable effective couplings between two nearest-neighbor qubits -- allows us to systematically probe the stability of QMBS states as the ratio of intra- and inter-dimer couplings $J_(upright(a)) / J_(upright(e))$ is varied. As shown in @fig:evolution\(g), both the numerical and experimental results indicate that QMBS states emerge consistently in the regime of $J_(upright(a)) / J_(upright(e)) > 1$. Also, the finite value of $g_Pi ( omega_1 ) approx 0.008$ for $J_(upright(a)) / J_(upright(e)) = 1$ implies that the origin of the QMBS state is a many-body effect. In the regime of large coupling ($J_(upright(a), upright(e)) / 2 pi > 12$ MHz), the effective Hamiltonian in @eq:Hamiltonian is no longer accurate to describe the system due to the population leakage to couplers.


Due to the fast growth of Hilbert space dimension in this case, we did not explore such large coupling regime.


To verify the persistence of the QMBS states for different system sizes, we perform experimental measurements of chains of sizes $L = 12$, $14$, $16$, $20$, $24$, $28$, and $30$. The time evolution of the imbalance, the entanglement entropy, and the four-qubit fidelity were found to behave consistently for different system sizes, thereby establishing the robustness of scarring in collective states $| Pi chevron.r$ and $| Pi' chevron.r$. The relatively small variations between the imbalance and the entanglement entropy for different system sizes are due to the difference in the cross couplings and the couplers. The Fourier amplitude $g_Pi ( omega_1 )$ and the four-qubit fidelity $F_A ( t_1 )$ at the first revival plateaus for $L > 16$, as shown in @fig:scaling\(a), whereas the inverse of the Hilbert space dimension characterizing the scaling of a random state shows an expected rapid exponential decrease with the system size. The plateaued behavior in the scaling suggests that QMBS states persist in the regime of large system size approaching the thermodynamic limit.


#heading(level: 1, numbering: none)[Many-body scars on a comb]
<many-body-scars-on-a-comb>


The programmable feature of our SC circuit allows us to emulate topology beyond one dimension. We have experimentally studied QMBS states in a system with a more complex qubit structure illustrated in @fig:comb\(a) -- a comb geometry which consists of a 1D "backbone" decorated with linear “offshoots”. Previous studies of quantum comb systems with offshoots of random lengths were shown to exhibit localization, including “compact” localized states for which the localization length can vanish along the backbone~@Maimaiti2017 @HDGC:2020. In our realization, we take the offshoots to be of the same length, and we fix the numbers of qubits and photons to be $L = 20$ and $N = 10$. We consider each offshoot to be a dimer and, as in the 1D case, we set the inter dimer couplings to $J_(upright(e)) / 2 pi tilde.eq - 6$ MHz and the intra dimer ones to $J_(upright(a)) / 2 pi tilde.eq - 9$ MHz. In contrast to the chain geometry, the QMBS states in the comb geometry are $| Theta chevron.r = | upright(d)_(+) upright(d)_(+) dots.h.c chevron.r$ and $| Theta' chevron.r = | upright(d)_(-) upright(d)_(-) dots.h.c chevron.r$. These states are also characteristically distinct from the conventional thermalizing states, as revealed by the squared Fourier amplitude in @fig:comb\(b). The striking contrast between a QMBS state and a thermalizing state can be seen at a more detailed level from @fig:comb\(c-d), which show the time evolution of the imbalance $I ( t )$, four-qubit fidelity, and entanglement entropy for state $| Theta' chevron.r$ and a typical thermalizing state.










#heading(level: 1, numbering: none)[Discussion and Outlook]
<discussion-and-outlook>


In summary, we have experimentally realized QMBS states in a SC circuit that emulates quantum many-body systems effectively described by a non-constrained spin-$1 / 2$ XY model with both one- and quasi-one-dimensional geometries. In contrast to existing experimental realizations in ultracold atomic systems~@BSKL:2017 @Su2022, our work represents the first experimental observation of QMBS states in a solid-state device. Moreover, the underlying mechanism of scarring -- approximate decoupling of a hypercube subgraph of the Hilbert space in the computational basis -- is fundamentally distinct from other QMBS platforms. Our study provides the first in-depth characterization of QMBS using quantum state tomography on large subsystems. By observing the population dynamics and entanglement entropy, we distinguished the weak ergodicity breaking associated with QMBS initial states from the conventional thermalizing states.


According to “strong” ETH lore, large many-body systems with Hilbert dimension in the range of tens or hundreds of millions, should exhibit ergodic dynamics. Our study indicates that QMBS states can arise in the SC processor even when the system size is this large, opening the door to investigating QMBS states and other many-body phenomena with an enormous Hilbert space in a feasible way, e.g., as in classical programmable computers. Our observation and characterization of long-lived quantum states in complex and strongly interacting solid-state systems with inevitable imperfections such as cross couplings between qubits, random disorders, and environment-induced decoherence and dephasing lead to direct applications. For example, the robustness of QMBS states in solid-state systems can substantially extend the coherence time of specific quantum information operations such as the generation of GHZ states. Our work points to the need to further investigate non-thermal states in experimental platforms to generate QMBS states against quantum thermalization for quantum information and quantum metrology applications~@XZQL:2021.


#heading(level: 1, numbering: none)[Acknowledgment]
<acknowledgment>
The device was fabricated at the Micro-Nano Fabrication Center of Zhejiang University. We acknowledge the support of the National Natural Science Foundation of China (Grants No.~92065204, No.~U20A2076, No.~11725419, and No.~12174342), the National Basic Research Program of China (Grants No.~2017YFA0304300), the Zhejiang Province Key Research and Development Program (Grant No.~2020C01019), and the Key-Area Research and Development Program of Guangdong Province (Grant No.~2020B0303030001). The work at Arizona State University is supported by AFOSR through Grant No.~FA9550-21-1-0186. Z.P. and J.Y.D. acknowledge support by EPSRC grants EP/R020612/1 and EP/R513258/1, and by Leverhulme Trust Research Leadership Award RL-2019-015.


#heading(level: 1, numbering: none)[Author contributions]
<author-contributions>
L.Y. proposed the idea. L.Y., Y.-C.L., J.Y.D. and Z.P. developed the theory and numerical simulation. P.Z., H.D. and Y.G. performed the experiment, and H.L. and J.C. fabricated the device supervised by H.W.. L.Z. and J.H. developed the measurement electronics. L.Y., H.W., Y.-C.L. and Z.P. co-wrote the manuscript. All authors contributed to the experimental setup, discussions of the results and development of the manuscript.


#heading(level: 1, numbering: none)[Competing interests]
<competing-interests>


The authors declare no competing financial interests.


#heading(level: 1, numbering: none)[Data and materials availability]
<data-and-materials-availability>


The data that support the findings of this study are available from the corresponding authors upon reasonable request.


#show bibliography: set text(size: 9pt, lang: "en")
#show bibliography: set par(leading: 0.2em, spacing: 0.5em)
#bibliography("refs.bib", title: none)

#heading(level: 1, numbering: none)[Methods]
<methods>


#strong[Device--]We use a superconducting quantum processor in a flip-chip package, which hosts a square of $6 times 6$ transmon qubits ($Q_i$) with $60$ couplers ($Q_c$), each inserted in-between two neighboring qubits, as shown in @fig:schematic\(a). Each qubit (coupler) is a quantum two-level system with ground state $| 0 chevron.r$ and excited state $| 1 chevron.r$, whose energy separation can be dynamically tuned in the frequency range $4.3 - 4.8$ GHz ($4.9 - 6.0$ GHz). Each qubit has individual microwave (XY) and flux (Z) controls and it is capacitively coupled to a readout resonator for state discrimination. Each coupler has an individual flux (Z) control and remains in the ground state during the experiment. We use high-precision synchronized analog signals to control the qubits and couplers, with microwave pulses for qubit XY rotations and state readout, and square flux pulses for tuning the qubit and coupler frequencies. A complete experimental sequence consists of three stages: (1) state preparation where single-qubit $pi$ pulses are applied to half of the qubits, (2) multiqubit interaction stage where the nearest neighboring qubit couplings are programmed by adjusting the couplers' frequencies, and (3) the measurement stage where all qubits are jointly read out. The values of the relevant qubit parameters such as the qubit operation frequencies, energy relaxation times (with mean about $50 mu$s) and single-qubit randomized benchmarking fidelities (with mean about $0.993$) can be found in Table S1 of SM.


#strong[Effective model--]We derive the effective spin-$1 / 2$ XY model for our experimental superconducting processor. The full Hamiltonian of the superconducting circuit-QED system with both qubits and couplers is given by~@NRKB:2018


$ cal(H)_(upright("full")) / ℏ & = sum_(i = 1)^L ( omega_i cal(S)_i^(+) cal(S)_i^(-) + eta_i / 2 cal(S)_i^(+) cal(S)_i^(+) cal(S)_i^(-) cal(S)_i^(-) )\
 & + sum_(c = 1)^(L - 1) ( omega_c cal(S)_c^(+) cal(S)_c^(-) + eta_c / 2 cal(S)_c^(+) cal(S)_c^(+) cal(S)_c^(-) cal(S)_c^(-) )\
 & + sum_(i , j = 1)^L g_(i j) ( cal(S)_i^(-) cal(S)_j^(+) + cal(S)_j^(-) cal(S)_i^(+) ) - sum_(i , c) g_(i c) ( cal(S)_i^(+) cal(S)_c^(-) + cal(S)_i^(-) cal(S)_c^(+) ) , $<seq:hamiltionian_exact>


where $omega_i med ( omega_c )$ is the frequency of the $i$th qubit ($c$'s coupler), $cal(S)_i^(+) med ( cal(S)_i^(-) )$ is the creation (annihilation) operator of $Q_i$, $g_(i j) med ( g_(i c) )$ is the coupling strength between $Q_i$ and $Q_j$ ($Q_c$), and the rotating wave approximation is imposed on the qubit-coupler and qubit-qubit couplings. The subscripts "$i , j$" and "$c$" represent the indices of qubits and couplers respectively. In experiments, the anharmonicity $eta_i$ is much larger than the couplings between the nearest neighboring qubits (typically $eta_i / g_(i j) > 50$), so the full Hamiltonian~(@seq:hamiltionian_exact) can be reduced to the spin-$1 / 2$ XY Hamiltonian:


$ cal(H) / ℏ & = sum_(i = 1)^L omega_i cal(S)_i^(+) cal(S)_i^(-) + sum_(c = 1)^(L - 1) omega_c cal(S)_c^(+) cal(S)_c^(-)\
 & + sum_(i , j = 1)^L g_(i j) ( cal(S)_i^(-) cal(S)_j^(+) + cal(S)_j^(-) cal(S)_i^(+) ) - sum_(i , c) g_(i c) ( cal(S)_i^(+) cal(S)_c^(-) + cal(S)_i^(-) cal(S)_c^(+) ) . $<seq:hamiltionian>


We apply the Schrieffer-Wolff transformation $cal(U) = e^(cal(W))$ to the Hamiltonian with


$ cal(W) = sum_c sum_i g_(i c) / Delta_(i c) ( cal(S)_i^(+) cal(S)_c^(-) - cal(S)_i^(-) cal(S)_c^(+) ) , $


since all qubits are far detuned from the couplers with $| Delta_(i c) | = | omega_i - omega_c | gt.double | g_(i c) |$. The effective Hamiltonian can then be approximated as


$ cal(H)_(upright("eff")) / ℏ approx sum_(i , j) J_(i j) ( cal(S)_i^(-) cal(S)_j^(+) + cal(S)_i^(+) cal(S)_j^(-) ) + sum_i Omega_i cal(S)_i^(+) cal(S)_i^(-) , $<eq:Hamiltonian>


where the effective coupling strength and transition frequencies are given by


$ J_(i j) & = g_(i j) + sum_c g_(i c) g_(j c) \[ 1 / Delta_(i c) + 1 / Delta_(j c) \] ,\
Omega_i & = omega_i + sum_c g_(i c)^2 / Delta_(i c) , $


respectively. The strength of the indirect coupling can be tuned by adjusting the coupler frequency, so the net coupling strength for $Q_i$ and $Q_j$ can be dynamically tuned over a wide range, typically from $- 15 times 2 pi$~MHz to $1 times 2 pi$~MHz.


#set page(columns: 1)

#figure(placement: top, [#image("figures/Mfig1.pdf", width: 3in)],
  caption: [
    Experimental sequence with strongly interacting many-body dynamics, where injecting a $pi$ pulse (red wave pulse) serves to lift the two-level qubit from the ground state to the excited state.
  ]
)
<fig:sequence>



#strong[Experimental sequence--]Experimentally, we prepare a set of product states as initial states and measure the final states of all qubits as a function of the interaction time (see pulse sequence illustrated in Fig.~(@fig:sequence). A typical experimental session starts by preparing the initial product state of all qubits: each qubit $Q_i$ is biased from its sweet spot to the corresponding idle frequency, where we apply single-qubit $X Y$ rotations. To prepare a high-fidelity state, during this period the couplers are tuned such that the net couplings between neighboring qubits are turned off. To switch on the interactions among the qubits, we bias all qubits to the interaction frequency and tune the coupler frequencies to turn on the couplings between neighboring qubits. After the interaction process, we bias all qubits to their readout frequencies for measurements. All directly measured qubit occupation probabilities are corrected to eliminate the measurement errors.









#pagebreak()
#set page(columns: 2)
#counter(heading).update(0)
#counter(math.equation).update(0)
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)
#set heading(numbering: none)
#set math.equation(numbering: n => "(S" + str(n) + ")", supplement: none, number-align: bottom)
#set figure(supplement: "Figure", numbering: n => "S" + str(n))
#show figure.where(kind: table): set figure(supplement: "Table", numbering: n => "S" + str(n))
#show heading.where(level: 1): set text(size: 10pt)
#show heading.where(level: 1): set align(center)
#show heading: set block(above: 1.1em, below: 0.6em)

#align(center)[#strong[Supplementary Materials]]





= EXPERIMENTAL DETAILS
<experimental-details>


#strong[Device information.] The superconducting quantum processor is composed of $6 times 6$ transmon qubits with tunable couplers between adjacent qubits in rows and columns. Each qubit has individual microwave (XY) and flux (Z) controls, and is capacitively coupled to its corresponding readout resonator for state discrimination. Each coupler has an individual flux (Z) control and remains in the ground state during an experiment. All qubits and couplers are located on a sapphire substrate (top chip), and most portion of the control/readout lines and readout resonators are located on a silicon substrate (bottom chip). Both chips have lithographically defined base wirings made of tantalum, and are galvanically connected via 9 -tall indium bumps directly deposited on tantalum. The indium bumps are not only for ground connectivity, but also for passing through control signals from the bottom chip, which connects to external circuitry via aluminum bonding wires, to the top chip where the qubits and couplers are located.


Experiments are carried out using systems of up to $30$ transmon qubits and $29$ transmon-type couplers. Parameters benchmarking the single-qubit performances are listed in @tab:dev_para. The couplers are used to tune the coupling strength between two neighboring qubits, where the tunable coupling value is characterized by the pairwise one-photon swapping dynamics. @sfig:effective_coupling shows an example of adjusting this coupling by tuning the coupler's frequency.


We also measure all dominant cross couplings $J_(upright(x))$ between qubits with separation distance $sqrt(2) a_0$. Most values of $J_(upright(x)) / 2 pi$ fall in the range $\[ 0.3 , 1.2 \]$ MHz, as shown in @sfig:Jx.


= NUMERICAL PREDICTION OF QMBS IN SMALL SYSTEMS
<numerical-prediction-of-qmbs-in-small-systems>


Quantum thermalization in isolated many-body systems is associated with the properties of their energy eigenstates. If the system obeys the Eigenstate Thermalization Hypothesis (ETH), all eigenstates away from the edges of the spectrum will behave similarly to thermal ensembles. For example, the expection value of any generic observable with respect to an eigenstate will only depend on its energy, and will match the prediction of the micro-canonical ensemble in the thermodynamic limit. As a consequence, quenching from a generic quantum state will lead to fast thermalization of this observable. Integrable systems such as the 1D spin-$1 / 2$ XY model or the SSH chain strongly violates the ETH due to their extensive number of conserved quantities. However, integrability is very fragile and will be broken in our SC device due to the presence of uneven cross couplings between non-nearest-neighbor spins, even if these are much smaller in strength that nearest-neighbor couplings. Here we numerically demonstrate that this leads to thermalization of the system for the overwhelming majority of states. However, a few special eigenstates are still violating the ETH, and this causes non-ergodic dynamics from a small set of basis states. We present numerical predictions of these QMBS states in systems of chain topology with regular ($J_(upright("nn"))$) and irregular ($J_(upright(x))$) non nearest-neighbor couplings as well as a comb tensor system with irregular couplings $J_(upright(x))$.


#strong[Quantum fidelity for scarred dynamics.] The dynamical evolution of a quantum state can be written as $| Psi ( t ) chevron.r = sum_n chevron.l E_n | Psi ( 0 ) chevron.r e^(- i E_n t) | E_n chevron.r$, where $E_n$ and $| E_n chevron.r = sum_alpha c_(n , alpha) | alpha chevron.r$ are the eigenenergy and eigenvector of the $n$-th eigenstate, respectively, and $| alpha chevron.r$ labels the computational basis states.


In a conventional thermalizing system, for any physical initial state (e.g., chosen to be one of the product states $| alpha chevron.r$), its squared overlap with the energy eigenstates $| chevron.l E_n | Psi ( 0 ) chevron.r |^2$ is homogeneously distributed. Time evolution of the fidelity, defined as $F ( t ) = | chevron.l Psi ( 0 ) | Psi ( t ) chevron.r |^2 = sum_n | chevron.l Psi | E_n chevron.r |^2 e^(- i E_n t)$, will rapidly decay to zero as the phases are essentially random, with tiny fluctuations proportional to the inverse Hilbert space dimension. This means that the initial information encoded in $| Psi ( 0 ) chevron.r$ will uniformly diffuse across the entire Hilbert space and, at late times, it cannot be measured by any local operator.


On the contrary, for the slowly thermalizing QMBS state, the squared overlap $| chevron.l E_n | Psi ( 0 ) chevron.r |^2$ is appreciable only for a few special scarred eigenstates which are effectively evenly spaced in energy. In this case, the time evolution of the fidelity can be approximated by only taking into account these states as $F ( t ) approx sum_(s_k) | chevron.l E_(s_k) | Psi ( 0 ) chevron.r |^2 e^(- i E_(s_k) t)$, where $E_(s_k)$ denotes the eigenenergy of the $k$th scarred eigenstate. Due to the approximately equal energy spacing $Delta E$, the phases will be coherent again after a time $t = 2 pi / Delta E$, leading to revivals of the wavefunction.


#figure([#image("figures/sfig_graph.pdf", width: 100%)],
  caption: [
    (a) Visualizing a selected scarred eigenstate and an ergodic eigenstate in the computational basis. Each vertex represents a computational basis state $| alpha chevron.r$, with the color denoting its contribution to the given eigenstate, $| chevron.l alpha | E chevron.r |^2$. One observes that the QMBS state is strongly concentrated on a few basis states, with the highest overlap on the two QMBS states $| Pi chevron.r$ and $| Pi' chevron.r$ indicated by hexagrams. In contrast, the ergodic eigenstate is uniformly spread across all basis states. The eigenstates are obtained for the chain geometry with photon number $N = L / 2 = 4$ and coupling ratio $J_(upright(a)) / J_(upright(e)) = 1.5$. Light gray line segments represent the various inter-qubit couplings $J_(i j)$. (b) Simulated time evolution of the fidelity of the QMBS state $| Pi chevron.r$ for $N = L / 2 = 7$, where the thermalization process is much slower than that of a random initial basis state (inset). Top row: squared overlap between the initial product state and the eigenstates $| chevron.l alpha | E_n chevron.r |^2$. Coupling parameter values are $J_(upright(a)) / 2 pi = - 9$, $J_(upright(e)) / 2 pi = - 6$, and $J_(upright(x)) / 2 pi in \[ 0.3 , 1.2 \]$ MHz.
  ]
)
<fig:fidelity>



To illustrate these points, in @fig:fidelity we present exact diagonalization study of scarred eigenstates and fidelity dynamics, contrasting them with thermalizing states. We consider a linear array of $L$ qubits at half filling, $N = L / 2$, with the intra- and inter-qubit couplings in ratio $J_a / J_e = 1.5$. We also include next-nearest neighbor couplings $J_x$ which lead to the thermalization of the system. The support of energy eigenstates on product states, shown in @fig:fidelity\(a), reveals a concentration of a QMBS eigenstate on few computational basis states. In contrast, a typical thermalizing state is uniformly spread across the Hilbert space. Moreover, as explained in the main text, the QMBS eigenstates can be probed by quenching the system from the initial state $| Pi chevron.r$, which is a product state of dimers alternating between $01$ and $10$ local configurations. For such an initial state, quench dynamics leads to revivals in the quantum fidelity \[@fig:fidelity\(b)\] which are absent for thermalizing initial states \[inset of @fig:fidelity\(b)\].


#strong[QMBS states in a chain system subject to regular perturbations.] As cross couplings in our SC device are irregular in strength, in our numerical simulations we choose them to be random in value in an experimentally--relevant range. However, to show that there is no need to add randomness to break integrability and see the appearance of scarring, we will first ignore the cross coupling and a regular longer-range perturbation instead. We thus apply the next-next-nearest-neighbor couplings $J_(upright("nn")) = J_(i , i + 3)$ that preserve the reflection symmetry. We consider the chain structure of $L = 18$ and $N = 9$ with open boundary conditions for the following parameter values: $J_(upright(a)) / 2 pi = 1.5 J_(upright(a)) / 2 pi = - 6$ and $J_(upright("nn")) / 2 pi = 0.6$ MHz. The collective dimerized states $| Pi chevron.r$ and $| Pi' chevron.r$ specified in Fig.~1(b) of the main text have a large overlap with a set of special eigenstates marked by red hexagrams in @sfig:scar_ssh_Jnn_pbc\(a) and @sfig:scar_ssh_Jnn_pbc\(b). These eigenstates possess lower entanglement entropy than the conventional states whose entropy obeys the volume law. The time evolution of the fidelity, imbalance, and entanglement entropy of the state $| Pi chevron.r$ and other randomly chosen initial product states are also shown in @sfig:scar_ssh_Jnn_pbc\(c-e). It can be seen that the state $| Pi chevron.r$ is dynamically long-lived in comparison with other initial states.


On top of the $J_(upright("nn"))$ couplings, one can also add some perturbations on the frequency term $Omega_i$. These can take the form of impurities located at the end of the chain $Omega_L / 2 pi = Omega_(L - 1) / 2 pi = 3$ MHZ, or of a staircase potential $Omega_(2 n - 1) / 2 pi = Omega_(2 n) / 2 pi = 0.8 n$ MHz with $n = 1 , 2 , dots.h.c , N$. In both cases, the perturbation is constant within each dimer and we expect it to leave the $| Pi chevron.r$ state and all dimerized states unaffected. However, because of the difference between dimers, it should lead to faster thermalization in the rest of the Hilbert space. This is confirmed by our numerical simulation, as shown in @sfig:ssh_Jnn_Om.


#strong[QMBS states in a chain subject to irregular perturbations.] In the experimental superconducting circuit in Fig.~1(a) of the main text, cross couplings $J_(upright(x))$ are the ones that break the reflection symmetry as well as the integrability of the SSH chain. Due to their variability of their strengths, we consider these to be random in value within the range $2 pi times \[ 0.3 , 1.2 \]$ MHz, which matches what we measure in the actual experiment. We investigate the QMBS states in chain systems with the SSH topology based on the effective Hamiltonian -- @eq:Hamiltonian in the main text -- with the experimental parameter values $J_(upright(a)) / 2 pi = J_(upright(e)) / 2 pi = - 6$ MHz. The numerical results for $L = 18$ and $N = 9$ are summarized in @sfig:scar_ssh. The observed Wigner-Dyson distribution of the level spacing indicates the "quantum chaotic" nature of the system with a Gaussian distribution of the density of states (DOS), as shown in @sfig:scar_ssh\(a). The values of the entanglement entropy of all the eigenstates is consistent with a volume law, as it approaches the approximate Page value $L / 2 upright("ln") 2 - 1 / 2$ near the middle of the spectrum, as shown in @sfig:scar_ssh\(b). The squared overlap between the collective dimerized state $| Pi chevron.r$ and the eigenstates $| E_n chevron.r$ is shown in @sfig:scar_ssh\(c). On top of the bulk of thermal states, several towers of states with a higher overlap with the $| Pi chevron.r$ states are clearly visible. These are approximately equally spaced in energy, leading to the oscillatory dynamics that can be seen in the fidelity and imbalance when starting from the $| Pi chevron.r$ state, as shown in @sfig:scar_ssh\(d) and @sfig:scar_ssh\(e) respectively. The entanglement entropy of the scarred product state increases with time more slowly than for conventional states, as shown in @sfig:scar_ssh\(f). @sfig:scar_ssh\(g) shows the scaling of the fidelity density of the scarred state, defined as $( 1 / L ) upright("ln") F ( t = t_1 )$, where $t_1$ is the time of the first fidelity revival. The fidelity density converges to a constant value of about $- 0.09$, which is much higher than the scaling of $1 / D$ (with $D$ the dimension of the Hilbert space at half-filling) expected from random states. In addition, the revival behavior of the fidelity can be enhanced by increasing the coupling ratio $J_(upright(a)) / J_(upright(e))$. For example, for $J_(upright(a)) / J_(upright(e)) = 2$ and $2.5$, the peak values of the fidelity and imbalance become much larger than that for $J_(upright(a)) / J_(upright(e)) = 1.5$. Simultaneously, the entanglement entropy is smaller, as shown by the light green curves in @sfig:scar_ssh\(f).


#strong[QMBS states in a comb tensor system subject to irregular perturbations.] The comb tensor system has a quasi-one-dimensional topology. @sfig:scar_comb shows the simulation results for $J_(upright(a)) / 2 pi = 1.5 J_(upright(e)) / 2 pi = - 9$ MHz and $J_(upright(x)) / 2 pi in \[ 0.3 , 1.2 \]$ MHz, which are similar to those of the 1D system. A difference is that the collective dimer states in the comb tensor system are $| Theta chevron.r = | 101010 dots.h.c chevron.r$ and $| Theta' chevron.r = | 010101 dots.h.c chevron.r$. Such a system is ergodic even without cross coupling and the level-spacing distribution in each symmetry sector is of the Wigner-Dyson type.


= POPULATION DYNAMICS ASSOCIATED WITH SCARRING STATES
<population-dynamics-associated-with-scarring-states>


The revival fidelity over time can be expressed in term of the overlap between the initial state and the eigenstates of the system as,


$ F ( t ) = | chevron.l psi ( t ) | psi ( 0 ) chevron.r |^2 = sum_n | c_(psi n) |^2 e^(- i E_n t) , $


where $c_(psi n) = chevron.l psi ( 0 ) | E_n chevron.r$ and the time evolution of the wavefunction is given by


#math.equation(block: true, numbering: none, $ | psi ( t ) chevron.r = sum_n c_(psi , n) e^(- i E_n t) | E_n chevron.r . $)


Because of the difficulty in directly measuring the fidelity, we use an experimentally feasible quantity known as the imbalance $I ( t )$ to replace the fidelity, which is defined as


$ I ( t ) = 1 / L sum_(i = 1)^L chevron.l cal(S)_i^z ( 0 ) chevron.r chevron.l cal(S)_i^z ( t ) chevron.r , $


where $chevron.l cal(S)_i^z ( t ) chevron.r = 2 n_i ( t ) - 1$ with $n_i ( t )$ being the population of $Q_i$. Here, we consider for the initial states the set of basis states $| alpha chevron.r$, where $alpha = 1 , 2 , dots.h.c , D$ with $D$ being the dimension of the Hilbert space. The $n$-th eigenstate can be written in this basis as $| E_n chevron.r = c_(n alpha) | alpha chevron.r$. The time evolution of the initial product state is determined by $| alpha ( t ) chevron.r = cal(U) ( t ) | alpha chevron.r$, where


#math.equation(block: true, numbering: none, $ cal(U) ( t ) = e^(- i cal(H) t) = sum_n e^(- i E_n t) | E_n chevron.r chevron.l E_n | . $)


We get


#text(size: 9pt)[
$ chevron.l cal(S)_i^z ( t ) chevron.r & = chevron.l alpha ( t ) | cal(S)_i^z | alpha ( t ) chevron.r\
 & = sum_n sum_m c_(alpha n)^(*) c_(alpha m) e^(- i ( E_m - E_n ) t) chevron.l E_n | cal(S)_i^z | E_m chevron.r\
 & = sum_n sum_m c_(alpha n)^(*) c_(alpha m) e^(- i ( E_m - E_n ) t) sum_beta sum_gamma c_(gamma n)^(*) c_(beta m) chevron.l gamma | cal(S)_i^z | beta chevron.r\
 & = sum_n sum_m sum_beta s_(beta , i) c_(alpha n)^(*) c_(alpha m) c_(beta n)^(*) c_(beta m) e^(- i ( E_m - E_n ) t) , $
]


where $s_(beta , i) = 1$ or $- 1$ for states $| 1 chevron.r_i$ or $| 0 chevron.r_i$. The imbalance is thus given by


#text(size: 9pt)[
$ I ( t ) &= 1 / L sum_(i = 1)^L sum_n sum_m sum_beta s_(alpha , i) s_(beta , i) \
 & (c_(alpha n)^(*) c_(alpha m) c_(beta n)^(*) c_(beta m)) e^(- i ( E_m - E_n ) t) , $
]


where the subscripts $i , j$, $n , m$, and $alpha , beta , gamma$ are the qubit, eigenstate and basis state indices, respectively.


The imbalance dynamics of the scarred states is dominated by a set of specific eigenstates, such as those indicated by the red crosses in @sfig:scar_ssh\(d). As shown in @sfig:scar_ssh\(c) and @sfig:scar_ssh\(d), the squared overlap of the eigenstates with the scarred state $| Pi chevron.r$ exhibits $L / 2 + 1$ peaks with a constant energy interval $Delta E$, while a conventional thermalizing state has a uniform overlap with the eigenstates. For example, for the system of size $L = 14$ with $8$ specific eigenstates, the squared overlaps denoted as $a_1^2$, $a_2^2$, $a_3^2$, and $a_4^2$ with the respective eigenenergies $plus.minus Delta / 2$, $plus.minus 3 Delta / 2$, $plus.minus 5 Delta / 2$, and $plus.minus 7 Delta / 2$ satisfy the inequality $a_(plus.minus 1)^2 > a_(plus.minus 2)^2 > a_(plus.minus 3)^2 > dots.h.c$.


The main terms in the overlap can be estimated from the formula of imbalance that can be written as


$ I ( t ) approx I_0 + sum_(k , l = - 4)^4 a_k^2 a_l^2 e^(- i ( k - l ) Delta E t) , $


where $I_0$ is the contribution from other eigenstates. For $a_(plus.minus 1)^4 gt.double a_(plus.minus 2)^4 gt.double a_(plus.minus 3)^4 gt.double a_(plus.minus 4)^4$ and $a_k^2 = a_(- k)^2$ (with $k = 1 , 2 , 3 , 4$), we have


$ I ( t ) - I_0 & approx 2 ( 2 a_4^2 a_3^2 + 2 a_3^2 a_2^2 + 2 a_2^2 a_1^2 + a_1^4 ) cos ( Delta E t )\
 & + 2 ( 2 a_1^2 a_2^2 + 2 a_3^2 a_1^2 + 2 a_2^2 a_4^2 ) cos ( 2 Delta E t )\
 & + 2 ( 2 a_4^2 a_1^2 + 2 a_3^2 a_1^2 + a_2^4 ) cos ( 3 Delta E t )\
 & + 2 ( 2 a_4^2 a_1^2 + 2 a_3^2 a_2^2 ) cos ( 4 Delta E t )\
 & + 2 ( 2 a_4^2 a_2^2 + a_3^4 ) cos ( 5 Delta E t )\
 & + 4 a_4^2 a_3^2 cos ( 6 Delta E t ) + 2 a_4^4 cos ( 7 Delta E t )\
 & approx ( 4 a_2^2 a_1^2 + 2 a_1^4 ) cos ( Delta E t ) . $


This example shows that the Fourier transformation of the imbalance dynamics contains only one peak, as shown in Fig.~2 of the main text, whereas that of the fidelity dynamics has a set of peaks. The conventional thermalized states are uniformly distributed over the eigenstates, so their imbalance dynamics rapidly decay to zero.


= COMPARISON BETWEEN EXPERIMENTAL AND NUMERICAL RESULTS IN SYSTEMS OF VARYING SIZES
<comparison-between-experimental-and-numerical-results-in-systems-of-varying-sizes>


#strong[Population dynamics at each qubit.] @sfig:eachQ_ni\(a) shows the experimentally measured and numerically calculated imbalances versus the interaction time for a chain system of size $L = 20$, which agree with each other. The squared Fourier amplitudes of the scarred states $| Pi chevron.r$ ($| Pi' chevron.r$) are much higher than those of the conventional thermalizing states, as shown in @sfig:eachQ_ni\(b). The experimental and numerical population evolution of each qubit in a $20$-qubit chain for $J_(upright(a)) / J_(upright(e)) = 1.5$ are shown in @sfig:eachQ_ni\(c).


#strong[Size dependence of the characterizing quantities.] We measure the time evolution of the imbalance, fidelity, and four-qubit entanglement entropy for different system sizes, as shown in @sfig:scaling. For the collective dimerized states, these characterizing quantities exhibit highly consistent behaviors for sizes ranging from $L = 12$ to $30$. Note that the data here has been used to generate the synthesized results in Fig.~4 of the main text.


= QMBS STATES WITH PERIODIC BOUNDARY CONDITIONS
<qmbs-states-with-periodic-boundary-conditions>
We find scarred features of the collective dimerized states become weak with the periodic boundary condition (PBC) for $L / 2 in$ odd, which is confirmed in the experment of $30$-qubit chain with a periodic boundary condition, as shown as the fidelity and entanglement entropy in @sfig:pbc.


#figure(placement: top, scope: "parent", [
#text(size: 8pt)[#table(
    stroke: none,
    columns: 6,
    inset: (x: 4pt, y: 1.8pt),
    align: (left,center,center,center,center,center,),
    table.hline(),
    table.header([], [$omega_j^0 / 2 pi$ (GHz)], [$omega_j^(upright("i")) / 2 pi$ (GHz)], [$e_(s q)$ ($"%"$)], [$T_(1 , j)$ ($mu$s)], [$T_(2 , j)^(*)$ ($mu$s)], ),
    table.hline(),
    [$Q_1$], [4.826], [4.795], [0.26], [71.5], [2.2], 
    [$Q_2$], [4.880], [4.420], [0.18], [75.5], [2.3], 
    [$Q_3$], [5.025], [4.370], [0.62], [78.0], [2.0], 
    [$Q_4$], [4.984], [4.310], [0.69], [62.5], [1.8], 
    [$Q_5$], [4.906], [4.285], [0.61], [53.3], [1.9], 
    [$Q_6$], [4.936], [4.810], [0.58], [37.1], [2.9], 
    [$Q_7$], [4.963], [4.375], [0.80], [70.7], [1.9], 
    [$Q_8$], [4.949], [4.305], [0.69], [43.5], [2.4], 
    [$Q_9$], [4.992], [4.695], [0.60], [56.8], [2.0], 
    [$Q_10$], [4.856], [4.745], [0.40], [60.2], [2.0], 
    [$Q_11$], [4.855], [4.360], [0.70], [63.4], [2.0], 
    [$Q_12$], [4.825], [4.490], [0.48], [60.6], [2.4], 
    [$Q_13$], [4.875], [4.772], [0.55], [55.9], [2.4], 
    [$Q_14$], [4.845], [4.720], [0.70], [48.6], [2.3], 
    [$Q_15$], [4.904], [4.350], [1.94], [48.4], [1.2], 
    [$Q_16$], [5.043], [4.320], [0.74], [49.9], [2.0], 
    [$Q_17$], [5.012], [4.660], [1.31], [53.8], [2.2], 
    [$Q_18$], [5.025], [4.758], [0.43], [55.9], [1.2], 
    [$Q_19$], [4.984], [4.436], [0.73], [35.6], [1.2], 
    [$Q_20$], [4.975], [4.800], [0.49], [34.9], [1.7], 
    [$Q_21$], [4.976], [4.655], [0.48], [35.7], [1.3], 
    [$Q_22$], [4.927], [4.353], [0.71], [45.9], [1.5], 
    [$Q_23$], [4.947], [4.749], [0.74], [49.7], [1.8], 
    [$Q_24$], [4.975], [4.625], [0.73], [52.2], [2.0], 
    [$Q_25$], [4.974], [4.801], [0.76], [37.0], [1.7], 
    [$Q_26$], [4.916], [4.340], [0.92], [50.1], [1.8], 
    [$Q_27$], [4.890], [4.430], [0.56], [50.9], [1.2], 
    [$Q_28$], [4.920], [4.640], [0.72], [47.9], [1.3], 
    [$Q_29$], [4.874], [4.710], [0.40], [46.2], [1.5], 
    [$Q_30$], [4.844], [4.330], [0.40], [70.3], [2.5], 
    [Average], [-], [-], [0.66], [53.4], [1.9],
    table.hline(stroke: 0.8pt),
)]
], caption: [ Device parameters: $omega_j^0$ is the transition frequency of $Q_j$ with zero flux bias, known as the sweet spot; $omega_j^(upright("i"))$ is the idle frequency of $Q_j$ where single-qubit XY rotations are applied and the average single-qubit gate error $e_(s q)$ is measured via randomized benchmarking. All qubits are flux (Z) biased to $omega^(upright("I")) / 2 pi approx 4.375$~GHz to activate the interaction, where the energy relaxation time $T_(1 , j)$ and the Ramsey dephasing time $T_(2 , j)^(*)$ of each qubit $Q_j$ are measured. ]
  , kind: table
  )



<tab:dev_para>



#text(size: 9pt)[]


#figure(placement: top, scope: "parent", [#image("figures/sfig_qcq.pdf", width: 100%)],
  caption: [
    Effective coupling between two nearest-neighbor qubits as a function of the amplitude of the flux (Z) bias on the coupler. We start by preparing $Q_11$-$Q_12$ in $| 10 chevron.r$, then turn on the effective coupling by applying the flux (Z) bias to position the coupler at $tilde 5$~GHz (originally idling at $tilde 6$~GHz) for the interaction time, and finally measure the resulting probability $P_(| 01 chevron.r)$ for the two qubits to be in the state $| 01 chevron.r$. (a) $P_(| 01 chevron.r)$ as a function of both the Z bias amplitude and the interaction time. (b) Effective coupling strength between $Q_11$ and $Q_12$ versus the Z bias amplitude, obtained by Fourier transform of the data in (a). The schematic inset displays a qubit-coupler-qubit structure during the measurement.
  ]
)
<sfig:effective_coupling>



#figure(placement: top, scope: "parent", [#image("figures/sfig_gx.pdf", width: 92%)],
  caption: [
    The dominant cross coupling $J_(upright(x)) / 2 pi$ \[Hz\] value from experimental measurements.
  ]
)
<sfig:Jx>



#figure(placement: top, scope: "parent", [#image("figures/sfig_chain_Jnn.pdf", width: 100%)],
  caption: [
    Example of QMBS in a chain. The chain parameters are $L = 18$, $N = 9$, $J_(upright(a)) / 2 pi = - 6$, $J_(upright(e)) / 2 pi = - 4$, and $J_(upright("nn")) / 2 pi = 0.72$ MHz. (a) Level-spacing statistics after resolving the inversion symmetry. The black circles show the numerical data, while the dotted lines show the expected distributions for an integrable (Poisson) and a chaotic (Wigner-Dyson) model. The inset shows the density of states. (b) Entanglement entropy of all eigenstates, with the horizontal dashed line showing the approximate Page value $( L / 2 ) upright("ln") 2 - 1 / 2$. (c) Squared overlap between the collective dimerized state $| Pi chevron.r$ and the eigenstates $| E_n chevron.r$. In (b) and (c), the red hexagrams mark the major eigenstates that contribute to the scarring dynamics. (d-f) Time evolution of fidelity, imbalance, and entanglement entropy for the collective dimerized state (green) and other random states (light orange).
  ]
)
<sfig:scar_ssh_Jnn_pbc>



#figure(placement: top, scope: "parent", [#image("figures/sfig_Om_purt.pdf", width: 100%)],
  caption: [
    Example of QMBS in a chain. The chain parameters are $L = 18$, $N = 9$, $J_(upright(a)) / 2 pi = - 6$, and $J_(upright(e)) / 2 pi = - 4$ MHz. (a-c) Squared overlap between the collective dimerized state $| Pi chevron.r$ and the eigenstates $| E_n chevron.r$, time evolution of fidelity, and entanglement entropy for the collective dimerized state (green) and other randomly chosen product states (light orange) for $J_(upright("nn")) / 2 pi = 0.7$ MHz and impurities $Omega_L / 2 pi = Omega_(L - 1) / 2 pi = 3$ MHz. (d-f) Similar to (a-c), but with a staircase perturbation $Omega_(2 n - 1) / 2 pi = Omega_(2 n) / 2 pi = 0.8 n$ MHz with $n = 1 , 2 , dots.h.c , N$.
  ]
)
<sfig:ssh_Jnn_Om>



#figure(placement: top, scope: "parent", [#image("figures/sfig_ssh_num.pdf", width: 100%)],
  caption: [
    QMBS with random cross couplings. The chain parameters are $L = 18$, $N = 9$, $J_(upright(a)) / 2 pi = - 6$, $J_(upright(e)) / 2 pi = - 4$, and $J_(upright(x)) / 2 pi in \[ 0.3 , 1.2 \]$ MHz. (a) Level-spacing statistics, the black circles show the numerical data, while the dotted lines show the expected distributions for an integrable (Poisson) and a chaotic (Wigner-Dyson) model. The inset shows the density of states. (b) Entanglement entropy of all eigenstates, with the horizontal dashed line showing the approximate Page value $( L / 2 ) upright("ln") 2 - 1 / 2$. (c) Squared overlap between the collective dimerized state $| Pi chevron.r$ and the eigenstates $| E_n chevron.r$. In (b) and (c), the red hexagrams mark the major eigenstates that contribute to the scarring dynamics. (d-f) Time evolution of fidelity, imbalance, and entanglement entropy for the collective dimerized state (green) and other random states (light orange). (g) Fidelity density of the QMBS state $| Pi chevron.r$ and inverse Hilbert space dimension $1 / D$ as a function of $1 / L$. For the cases with coupling ratio $J_(upright(a)) / J_(upright(e)) = 2$ and $2.5$, $J_(upright(e)) / 2 pi = - 4$ MHz and $J_(upright(x)) / 2 pi in \[ 0.3 , 1.2 \]$ MHz are fixed and $J_(upright(a)) / 2 pi$ is increased to $- 8$ and $- 10$ MHz respectively.
  ]
)
<sfig:scar_ssh>



#figure(placement: top, scope: "parent", [#image("figures/sfig_comb_num.pdf", width: 100%)],
  caption: [
    QMBS in a comb tensor configuration. The system parameters are $L = 18$ and $N = 9$, $J_(upright(a)) / 2 pi = 1.5 J_(upright(e)) / 2 pi = - 9$ MHz and $J_(upright(x)) / 2 pi in \[ 0.3 , 1.2 \]$ MHz,. (a) Level-spacing statistics, the black circles show the numerical data, while the dotted lines show the expected distributions for an integrable (Poisson) and a chaotic (Wigner-Dyson) model. The inset shows the density of states. (b) Entanglement entropy of all eigenstates, with the horizontal dashed line showing the approximate Page value $( L / 2 ) upright("ln") 2 - 1 / 2$. (c) Squared overlap between the collective dimerized state $| Theta chevron.r$ and the eigenstates $| E_n chevron.r$. In (b) and (c), the red hexagrams mark the major eigenstates that contribute to the scarring dynamics. (d-f) Time evolution of fidelity, imbalance, and entanglement entropy for the collective dimerized state (green) and other random states (light orange). Inset of (d) shows the fidelity density for the $| Theta chevron.r$ state and the inverse Hilbert space dimension $1 / D$ as a function of $1 / L$.
  ]
)
<sfig:scar_comb>



#figure(placement: top, scope: "parent", [#image("figures/sfig_eachQ.pdf", width: 100%)],
  caption: [
    Behaviors of imbalance of $| Pi chevron.r$. (a) Imbalance of $| Pi chevron.r$ as a function of the interaction time for $L = 20$ from experimental measurement (green hexagrams) and numerical simulation (orange curve). (b) Squared Fourier amplitude at the revival frequency from randomly chosen initial product states. The green hexagrams show the $| Pi chevron.r$ and $| Pi' chevron.r$ states. (c) Time evolution of qubit population for the $20$-qubit chain from experimental data (green circles) and simulation results (solid orange curves). The numerical parameter values are $J_(upright(a)) / 2 pi = - 9$ MHz, $J_(upright(e)) / 2 pi = - 6$ MHz, and $J_(upright(x)) / 2 pi$ is randomly chosen from the range $\[ 0.3 , 1.2 \]$ MHz.
  ]
)
<sfig:eachQ_ni>



#figure(placement: top, scope: "parent", [#image("figures/sfig_scaling.pdf", width: 82%)],
  caption: [
    Behaviors of imbalance of $| Pi chevron.r$ at different system sizes. (a,b) Experimentally measured and numerically calculated imbalance versus interaction time for system sizes ranging from $L = 12$ to $30$. (c,d) Experimental and numerical four-qubit entanglement entropy versus interaction time for the same set of system sizes. For numerical simulations, the maximum size is $L = 20$ due to computational constraints. (e) Four-qubit fidelity as a function of interaction time near the first revival.
  ]
)
<sfig:scaling>



#figure(placement: top, scope: "parent", [#image("figures/sfig_pbc.pdf", width: 70%)],
  caption: [
    Comparison of four-qubit fidelity (upper) and entanglement entropy (lower) of scarred states for PBC and OBC.
  ]
)
<sfig:pbc>

