#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "a4", margin: (left: 1.90cm, right: 1.17cm, top: 1.91cm, bottom: 4.17cm), columns: 2)
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
#show figure.caption: set text(size: 8pt)
#show figure.caption: set par(leading: 0.5em)
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
    #text(12pt, weight: "bold", [Simulating 2D lattice gauge theories on a qudit quantum computer])   #v(1.2em)
    #text(10.5pt)[Michael Meth#super[1], Jan F. Haase#super[2], Jinglei Zhang#super[2], Claire Edmunds#super[1], Lukas Postler#super[1], Andrew J. Jena#super[2], Alex Steiner#super[1], Luca Dellantonio#super[2], Rainer Blatt#super[1], Peter Zoller#super[8], Thomas Monz#super[1], Philipp Schindler#super[1], Christine Muschik#super[\*]#super[2], Martin Ringbauer#super[\*]#super[1]]
  
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Universität Innsbruck, Institut für Experimentalphysik, Technikerstraße 25a, Innsbruck, Austria] \
    #text(9pt)[#super[2] Institute for Quantum Computing, University of Waterloo, Waterloo, Ontario, N2L 3G1, Canada] \
    #text(9pt)[#super[3] Department of Physics \& Astronomy, University of Waterloo, Waterloo, Ontario, N2L 3G1, Canada] \
    #text(9pt)[#super[4] Institut für Theoretische Physik und IQST, Universität Ulm, Albert-Einstein-Allee 11, D-89069 Ulm, Germany] \
    #text(9pt)[#super[5] Department of Physics and Astronomy, University of Exeter, Stocker Road, Exeter EX4 4QL, United Kingdom] \
    #text(9pt)[#super[6] Institute for Quantum Optics and Quantum Information of the Austrian Academy of Sciences, Technikerstraße 21a, Innsbruck, Austria] \
    #text(9pt)[#super[7] Alpine Quantum Technologies GmbH, Innsbruck, Austria] \
    #text(9pt)[#super[8] Universität Innsbruck, Institut für Theoretische Physik, Technikerstraße 21a, Innsbruck, Austria] \
    #text(9pt)[#super[9] Perimeter Institute for Theoretical Physics, Waterloo, Ontario, N2L 2Y5, Canada] \
  ]
  #v(1.2em)

  #align(left)[#text(8pt)[∗ These authors jointly supervised the work.]]

  Particle physics underpins our understanding of the world at a fundamental level by describing the interplay of matter and forces through gauge theories. Yet, despite their unmatched success, the intrinsic quantum nature of gauge theories makes important problem classes notoriously difficult for classical computational techniques~@Banuls:2019rao @creutz1983monte. A promising way to overcome these roadblocks is offered by quantum computers, which are based on the same laws that make the classical computations so difficult~@feynmanQS @banuls2019simulating @Dalmonte_2016 @funcke2023review @dimeglio2023quantum @beck2023quantum. Here we demonstrate two essential requirements for gauge theory calculations with quantum computers. Firstly, we perform a quantum computation of the properties of the basic building block of two-dimensional lattice quantum electrodynamics, involving both gauge fields and matter ~@paulson_simulating_2021 @zohar_quantum_2021. Secondly, we show how to refine the gauge field discretization beyond its minimal representation. These computations are made possible by the use of a trapped-ion qudit quantum processor~@Ringbauer2022A-universal, where quantum information is encoded in $d$ different states per ion, rather than in two states as in qubits. Such qudits are ideally suited for describing gauge fields, which are naturally high-dimensional, leading to a dramatic reduction in the register size and circuit complexity. Using a variational quantum eigensolver~@Farhi2014 @PeruzzoVQE @OMalley2016 @McClean2016 @Moll2018 we prepare the ground state of the model. We then observe the effect of dynamical matter on quantized magnetic fields and show how to seamlessly observe the effect of different gauge field truncations by controlling the qudit dimension. Our results open the door for hardware-efficient quantum simulations with qudits in near-term quantum devices.
]

= INTRODUCTION
<sec:introduction>

Computing today is almost exclusively based on binary information encoding. This holds true for classical computers operating with bits, as well as for the emerging area of quantum computing that uses qubits to exploit quantum superposition and entanglement for information processing. However, quantum systems underpinning today's quantum computers offer the possibility to process information in several different energy levels~@Ahn2000 @Godfrin2017 @Anderson2015 @Morvan2020 @Senko2015 @Wang2018 @Chen_2021, so-called qudits. A key to unlocking the potential of this approach, and to realizing qudit algorithms~@wang_qudits_2020 in practice is the availability of programmable, high-fidelity qudit entangling gates. We realize this capability in a linear ion-trap quantum processor with all-to-all connectivity~@Ringbauer2022A-universal by extending qubit entangling gates~@Cirac1995 @Kuzmin2020 @Meth2022 to mixed-dimensional qudit systems. These resources open up exciting avenues for native quantum simulation of $d$-level systems (e.g.~in chemistry~@Cao2019Quantum @MacDonell2020 @maskara_quantum_2023 or condensed matter physics~@Haldane1983 @Sawaya2020) with smaller registers and reduced gate depth compared to a qubit approach.

A natural application for qudit quantum hardware is lattice gauge theory (LGT) calculations, where qudits naturally represent high-dimensional gauge fields. Gauge theories are the backbone of the standard model of particle physics. Studying them on a lattice through computer simulations has been key in the quest for a more complete understanding of the phenomenology within the standard model and for discovering physics beyond it. Yet, despite the tremendous success of LGT classical simulations~@aoki_flag_2022, this endeavor is increasingly hindered by the fact that important problem classes, such as real-time evolutions and problems involving high matter densities, are plagued by sign problems~@Gattringer:2016kco, which are believed to be classically intractable~@Troyer:2004ge @jordan_bqp-completeness_2018. Quantum computations, on the other hand, are by design not affected by sign problems and thus offer a unique scientific opportunity for advancing the frontier of gauge theory simulations (see~@dimeglio2023quantum @beck2023quantum @bauer_quantum_2023 for an in-depth discussion and @Sec:Supp:Advantage for key points). While LGT quantum simulations for particle physics have seen impressive advances, experimental demonstrations were limited to either one spatial dimension (1D), or targeted theories beyond 1D where either gauge fields or matter are trivial~@klco20192 @Trailhead @Rahman2021 @Ciavarella2022 @Rahman2022A @Rahman2022B @Ciavarella2023.

Here we address two major challenges in quantum computing for gauge theory calculations: The realization of LGT quantum computations beyond one spatial dimension (1D) including both gauge fields and matter and the ability to control the gauge field dimension. Both of these essential ingredients demand the efficient representation of the formally infinite-dimensional gauge fields on quantum computers, which requires discretization and truncation to a finite number of levels~@Digitization2019 @PhysRevD.100.114501 @paper1 @davoudi_search_2021 @Trailhead @Bauer2023 @jakobs_canonical_2023. Importantly, however, truncated gauge fields must remain sufficiently high-dimensional to capture the relevant physics, which is most naturally achieved by encoding them into qudits~@yang_analog_2016 @Mil:2019pbt @gonzalez-cuadra_hardware_2022 @zache2023.

Specifically, we consider quantum electrodynamics in two spatial dimensions (2D-QED) and simulate the basic building block of the lattice---a single plaquette---on a qudit quantum computer~@Ringbauer2022A-universal. We observe the ground state plaquette expectation value~@creutz1983monte, which is a central quantity in LGT calculations related to magnetic fields that are a defining feature of 2D and 3D physics and have no analog in 1D. The plaquette expectation value is also relevant for the so-called running coupling~@aoki2017review @aoki2020flag in gauge theories, which is absent in 1D-QED. Notably, our approach is directly adaptable to digital quantum simulations of real-time dynamics, offering an intriguing perspective for the quantum simulations of LGT dynamics. In all demonstrated cases, our qudit-encodings with high-fidelity entangling gates natively allow for gate sequences with fewer entangling gates, smaller register sizes, and improved simulation accuracy compared to conventional qubit devices. Providing an order of magnitude improvement in circuit complexity already in the simplest instance, our work highlights a new path towards highly efficient quantum simulations of gauge theories and beyond.

= LGT SIMULATIONS WITH QUDITS
<sec:hardware>

We simulate lattice QED, defined on a two-dimensional discretization of space, where matter (electrons and positrons) reside on the sites of the lattice, and gauge bosons (photons) on the links, see #ref(<fig:1>)a. Matter is described by fermionic field operators, where we use a staggered formulation~@kogut1975hamiltonian in which lattice sites can either be in the vacuum state or host electrons (positrons) residing on even (odd) lattice sites, as depicted in @fig:encoding_si in the Appendix. The gauge fields residing on the links between each pair of sites are each described by electric field operators $hat(E)$ that possess an infinite, but discrete, spectrum $hat(E) | E chevron.r = E | E chevron.r$, where $E = 0 , thin plus.minus 1 , thin plus.minus 2 , dots.h$

The total Hamiltonian is then given by the sum~@kogut1975hamiltonian

$ hat(H) = g^2 hat(H)_E + 1 / g^2 hat(H)_B + m hat(H)_m + Omega hat(H)_k , $<eq:Hamiltonian>

which describes the free electric (E), magnetic (B), and matter (m) field energy and the kinetic energy term (k) responsible for pair creation processes, see @eq:Hamiltonian_terms in the Appendix.

The bare coupling strength $g$ is determined by the charge of the elementary particles with bare mass $m$. Both parameters enter into the energy cost associated with the creation of an electron-positron pair and the associated electromagnetic field. The rate of these pair- and field-creation processes is characterized by $Omega$. We employed here the Kogut-Susskind Hamiltonian formulation~@kogut1975hamiltonian in natural units $ℏ = c = 1$, and with lattice spacing $a = 1$.

Importantly, not all quantum states in the considered Hilbert space are physical. In particular, the gauge field and charge configurations of physical states $| Psi_(upright("phys")) chevron.r$ have to fulfill Gauss' law at each site. Here, the familiar law from classical electrodynamics $nabla upright(bold(E)) ( upright(bold(r)) ) - rho ( upright(bold(r)) ) = 0$, where $rho ( upright(bold(r)) )$ is the charge density at point $upright(bold(r))$, takes the form $hat(G)_(upright(bold(n))) | Psi_(upright("phys")) chevron.r = 0$, with the Gauss operator $hat(G)_(upright(bold(n)))$ at lattice site $upright(bold(n))$ given in @eq:gauss_operator in the Appendix.

To observe 2D effects in this model, we study the local plaquette operator $hat(square.stroked.tiny) = - 1 / V hat(H)_B$, where $V$ is the number of plaquettes. The plaquette operator involves four gauge fields forming a closed loop along a single plaquette, see @eq:P_op and #ref(<fig:encoding_si>)b in the Appendix. Since this observable is related to the curl of the vector potential, it is defined in at least two spatial dimensions and has no analogue in 1D-QED. The dependence of the plaquette ground state (i.e.~vacuum) expectation value $chevron.l hat(square.stroked.tiny) chevron.r$ on $g^(- 2)$ can be related to the running of the coupling~@Clemente2022, which is a fundamental feature of gauge theories in particle physics that captures the dependence of the charge on the distance (energy scale) on which it is probed.

// [figvision-cn] imgs/Fig1.png
// 子图a为二维量子电动力学晶格示意图。蓝色椭圆表示位于格
// 点上的物质粒子，相邻蓝色椭圆之间由红色矩形连杆连接，红
// 色连杆代表规范场。图中标注有Gauge field（规范场）和
// Matter（物质）。图下方虚线框内展示单个连杆上规范场的离
// 散能谱：横轴为能量E，纵轴为离散能级，能级标记为…、|−2⟩、
// |−1⟩、|0⟩、|1⟩、|2⟩、…，红色双向箭头连接相邻能级。该子
// 图说明规范场具有无限但离散的能谱，可通过截断表示进行模
// 拟。 子图b为规范场截断示意图。标注“Gauge field
// truncation”和“d-levels qudit = d”。左侧给出⁴⁰Ca⁺的能级
// 项符号P₁/₂、D₅/₂、S₁/₂及对应的量子数，红色双向箭头连接
// P₁/₂与D₅/₂，表示二者构成一个d能级量子比特（qudit），红
// 色圆圈内数字3表示d=3。 子图c为⁴⁰Ca⁺能级示意图，标注“⁴⁰
// Ca⁺ level scheme”。水平线表示能级，左侧标注S₁/₂、P₁/₂、
// D₅/₂，右侧标注对应能级差，红色圆圈数字3再次强调三能级
// 结构。 子图d为混合量子比特-量子特里特变分电路示意图。
// 顶部为四个初始态|0⟩。左侧为规范量子特里特（Gauge qudit），
// 包含三个红色椭圆标记θ₄、θ₅、θ₆，通过受控门与物质量子比
// 特耦合。右侧为四个物质量子比特，标记为i、ii、iii、iv，
// 每个物质量子比特包含蓝色矩形标记θ₁、θ₂、θ₃及上方对应的
// θ₇、θ₈、θ₉。电路中有多条竖直连线表示量子门操作，连线交
// 叉处有控制点。右侧虚线框内标有θ，并有箭头指向经典计算
// 机图标，表示参数优化循环。底部标注Gauge qudit和Matter
// qubits。 子图e为量子计算结果曲线图，标题“Quantum
// computation results”。横轴为迭代次数Iteration，范围0到
// 约450；纵轴为能量Energy (a.u.)，范围约−75到25。黑色散
// 点表示每次迭代的能量测量值，红色实线表示能量随迭代下降
// 的趋势。图中用竖直虚线分为三个区域，分别标记(1)、(2)、
// (3)，左侧标注Initial exploration（初始探索）。曲线显示
// 能量从约0逐步下降至约−65，并在区域(2)和(3)附近趋于平台。
// 子图f为能量随耦合常数变化的曲线图。横轴为g²，采用对数
// 坐标，范围10⁻²到10²；纵轴为能量⟨H⟩，范围0.0到0.6。图例
// 包括：黑色带误差棒的点表示Experiment（实验），灰色方块
// 表示Noise model（噪声模型），灰色实线表示Exact（精确值），
// 灰色虚线表示Pure gauge（纯规范场）。曲线显示⟨H⟩随g²增
// 大而上升，在g²≈10⁰附近急剧上升，随后趋于饱和约0.65。精
// 确曲线与噪声模型曲线接近，纯规范场曲线在低g²区域明显偏
// 低。图中左上角插图显示四个格点i、ii、iii、iv，蓝色椭圆
// 位于格点，红色连杆连接i与ii、iii与iv，虚线框表示所研究
// 的局部区域。
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

#figure(scope: "parent", image("imgs/Fig1.png", width: 98.0%),
  caption: [
    #strong[Simulating two-dimensional lattice QED with matter fields.] #strong[a], The lattice of 2D-QED is comprised of vertices containing matter particles (blue) connected by links carrying the associated gauge field (red). The local gauge field at a particular link possesses an infinite, yet discrete spectrum that can be simulated using a truncated representation. #strong[b], The truncated gauge fields are naturally represented by $d$-level qudits. #strong[c], In our experiment these qudits (red) are encoded in different Zeeman levels of the S$""_(1 / 2)$ ground state and D$""_(5 / 2)$ excited state of trapped $""^40 upright("Ca")^(+)$ ions. Matter particles, on the other hand, are faithfully represented by qubits (blue), marking their presence or absence. #strong[d], Our variational ansatz for simulating a single plaquette with open boundary conditions is thus a mixed-dimensional qubit-qudit quantum circuit, see @sec:open. Employing Gauss' law to eliminate three of the four gauge fields, we truncate the remaining field to contain at most one energy quantum, hence our quantum register contains one qutrit (red) for the gauge field and four qubits (blue) representing the matter vertices of the plaquette. A fanning-out of the qudit circuit line is used to illustrate the coupling of the qudit entangling gates to certain subspaces, see also @sec:circuit_gates. Note that the all-to-all connectivity of the ion trap quantum processor enables a highly efficient circuit realization. During the variational optimization, a classical optimizer varies the gate angles $theta_j$ in order to minimize the energy of the produced quantum state, as measured by the quantum computer. #strong[e], An exemplary optimization run for $Omega = 5$, $m = 0.1$, and $g^(- 2) = 10^2$. As a guide for the eye, the red line highlights the current lowest energy found by the algorithm. The first block of 130 evaluations explores generally the variational landscape. Subsequent blocks of up to 300 evaluations ((1), (2), (3), ... not all shown) optimize each for decreasing values of the coupling starting from $g^(- 2) = 10^2$. During the whole optimization process, measurement data acquired at each iteration is used also to further explore the energy landscape for previously analysed values of the coupling. See @sec:vqe for details. One standard deviation of statistical uncertainty is given by the shaded region. Once an optimal set of parameters $upright(bold(theta))^(*)$ is found, the properties of the so-created approximate (ground) state can be studied. #strong[f], The expectation value of the plaquette operator $chevron.l hat(square.stroked.tiny) chevron.r$ as defined in the main text. The triangular data points are measured on the VQE optimized state, with error bars representing one standard deviation of statistical noise. The squares are obtained from a numerical simulation of an ideal VQE, with an experimentally motivated noise model applied to the final state, see @sec:noise_model. The line is obtained from a classical calculation of the exact ground state, using exact diagonalization. The dashed line is obtained from the corresponding pure gauge model $g^2 hat(H)_E + 1 / g^2 hat(H)_B$: the presence of dynamical matter noticeably affects the slope of the plaquette expectation value when varying the coupling.
  ]
)
<fig:1>

Quantum simulations of 2D-LGTs face the difficulty of finding an adequate representation for the gauge field operators $hat(E)$. While the fermionic field can be straightforwardly transformed to qubits~@jordan1928pauli, whose states either represent the presence or absence of a particle (see @sec:Methods_EncodedHamiltonian and #ref(<fig:encoding_si>)c), the gauge field requires a truncation of its spectrum and a description containing at least three quantum states, representing positive, zero, and negative flux values.

In principle, such a representation could be constructed from qubits. However, in practice, using qubits drastically increases the quantum register size and immediately results in complex many-body interactions~@paulson_simulating_2021, see @Sec:Supp:Advantage for details. For example, encoding $d$-level gauge fields requires at least $ceil.l upright("log")_2 ( d ) ceil.r$ qubits and even the application of local gauge field operators involves $cal(O) ( d^2 )$ two-qubit gates~@Sawaya2020. Gauss' law requires that the creation or annihilation of particles occurs with the corresponding change in flux, which necessitates the application of gauge-field rising or lowering operators that are controlled by the state of the matter configuration. Implementing such controlled gauge-field operations requires an even higher qubit gate count than the local gauge-field operators.

We circumvent this issue by representing each gauge field directly with a qudit system, containing exactly as many levels as required for the chosen truncation. As a consequence, local operations on the gauge fields remain local in the quantum computer, and the coupling between a matter site and a gauge field is realized as a two-body qubit-qudit interaction. We achieve an efficient implementation of these interactions through the use of explicit entanglement between the ion's internal state and the common motional mode in the spirit of the Cirac-Zoller gate~@Cirac1995. Conditional on the state of one ion (regardless of qudit dimension) a phonon is injected into the motional mode. If the phonon is present, a local operation is performed on the second ion, otherwise not. In the end, the phonon is deterministically removed from the motional mode and the internal states of the two ions are left entangled, see @sec:experimetal_details for details.

We realize the qubits for the matter fields and qudits for the gauge fields within the $4 S_(1 / 2)$ ground state and the $3 D_(5 / 2)$ excited state manifolds of trapped $""^40 upright("Ca")^(+)$ ions~@Ringbauer2022A-universal, and thereby demonstrate quantum computations with tailored mixed-dimensional quantum systems. As shown in #ref(<fig:1>)d and @sec:vqe, we perform a variational ground-state search, using a suitable ansatz in the form of a quantum circuit with gates that are parameterized by a set $upright(bold(theta))$ (see @sec:open below). A classical optimizer then varies the gate parameters to minimize the energy $chevron.l hat(H) chevron.r$ of the prepared states, which serves here as a cost function and is measured by the quantum computer. This optimization loop is repeated until the energy is minimized and one obtains a parameter set $upright(bold(theta))^(*)$, such that the ansatz approximates the ground state of $hat(H)$.

= SIMULATING GAUGE FIELDS AND MATTER
<sec:open>

In our first experiment, we study 2D-QED on a lattice with open boundary conditions, crucially including both matter and gauge fields. In contrast to previous experiments (simulating LGTs in 1D or without matter) we observe the effects of virtual pair-creation, electromagnetic fields, and their interplay~@paulson_simulating_2021 by studying the ground state expectation value of the plaquette operator $chevron.l hat(square.stroked.tiny) chevron.r = - 1 / V chevron.l hat(H)_B chevron.r$.

Specifically, we consider the basic building block of the two-dimensional lattice, i.e.~a single plaquette with open boundary conditions, consisting of four matter sites and four gauge fields, see inset in #ref(<fig:1>)f. These gauge and matter degrees of freedom are constrained by Gauss' law in @eq:gausslaw at each vertex. These constraints can be encoded explicitly into the Hamiltonian by eliminating redundant gauge degrees of freedom as shown in @sec:Methods_EncodedHamiltonian. As a result, the resource requirements for our quantum computation are significantly reduced, while at the same time, the simulated states are guaranteed to be physical, i.e.~obey Gauss' law. Using this formulation, the Hamiltonian per plaquette then involves only one gauge field. Employing the minimal gauge field truncation using three levels (i.e.~$d = 3$), our VQE ansatz is then given by a hybrid qudit-qubit approach with one qutrit representing the gauge degree of freedom, and four qubits representing electrons and positrons residing on the four vertices, see #ref(<fig:1>)d. We note that these requirements for 2D connectivity and two different constituents are most easily satisfied in an all-to-all connected mixed-dimensional digital quantum processor as opposed to analog Ising-type simulators~@kokail2019self.

Our VQE ansatz is based on the Hamiltonian given in @eq:openplaq_qubit and reflects the underlying physics of pair creation processes: the qubit states $| arrow.b chevron.r / | arrow.t chevron.r$ represent vacuum/electrons on even lattice sites and positrons/vacuum on odd lattice sites, as shown in @fig:encoding_si in the Appendix. The qutrit states $( | - 1 chevron.r , | 0 chevron.r , | + 1 chevron.r )$ represent the electric field eigenstates of the gauge field. The circuit is initialized in the qudit-qubit state $| arrow.b arrow.t arrow.b arrow.t , 0 chevron.r$, representing the bare vacuum $| v v v v , 0 chevron.r$, where no particles (first four entries) or gauge field excitations (last entry) are present.

As shown in #ref(<fig:1>)d, the two-qubit gates on the matter qubits (blue) at the beginning of the circuit populate the plaquette with electrons and positrons. When the two lattice sites directly next to the remaining gauge field are populated (see inset of #ref(<fig:1>)f), Gauss' law requires the excitation of the gauge field to change accordingly, which is achieved by the qubit-qutrit controlled-rotation gates (red). In the final part of the circuit, four two-qubit gates (blue) adjust the matter state. This last step can be done without modifying the state of the qutrit, since the matter fields also have gauge-field-independent free dynamics. The described Hamiltonian-based VQE circuit design is extendable to larger lattices as explained in Ref.~@paulson_simulating_2021.

#ref(<fig:1>)e shows a typical experimental run of the variational circuit. The resulting measured plaquette expectation values as a function of the parameter $g^(- 2)$ are shown in #ref(<fig:1>)f for $Omega = 5$ and $m = 0.1$ (see @sec:methods_open_plaquette for details on the parameter choice).The experimental data approximate the ideal result well and agree with our theoretical predictions using a simple error model, as explained in @sec:noise_model.

In the large coupling regime ($g^(- 2) lt.double 1$) the electric field energy term $hat(H)_E$ dominates the Hamiltonian of @eq:Hamiltonian, favoring the ground state $| v v v v , 0 chevron.r$ with $chevron.l hat(square.stroked.tiny) chevron.r = 0$. In the weak coupling regime, on the other hand, the magnetic field energy term $hat(H)_B$ dominates the Hamiltonian, favoring a positive vacuum plaquette expectation value ($chevron.l hat(square.stroked.tiny) chevron.r = 1 / sqrt(2) approx 0.707$ for the chosen truncation). In the intermediate regime where $g^(- 2) approx 1$, there is a competition between the field-energy terms and $hat(H)_k$. The ground state of the kinetic term has a positive plaquette expectation value. The presence of dynamical matter and the pair creation effect described by $hat(H)_k$ leads therefore to an increase of $chevron.l hat(square.stroked.tiny) chevron.r$ in the intermediate coupling regime, as shown in #ref(<fig:1>)f\; this effect results in a change of the slope of the plaquette expectation value as a function of $g^(- 2)$. An alternative lattice QED model~@paper1 @zohar_digital_2017 @raychowdhury_loop_2020 @Magnifico_2021 @Clemente2022 @bender_variational_2023 is studied in @sec:model_cm. In both cases, the relevant physics is already captured for the minimal truncation of $d = 3$. In general, however, realizing LGT quantum computations beyond 1D will require the ability to control the gauge field dimension. We will study this key requirement in the next section.

// [figvision-cn] imgs/Fig2.png
// 子图a为示意图，展示二维量子电动力学在周期性边界条件下
// 的环面几何。左侧为灰色线圈成的甜甜圈形环面，表面绘制有
// 网格线，表示离散化的空间格点。右侧为放大视图，环面上分
// 布若干白色圆圈表示的格点，格点之间以黑色线段连接表示规
// 范场链，环面中央有一个灰色矩形框标出局部区域。该子图说
// 明规范场定义在环面格点的链上，格点本身为空。 子图b为示
// 意图，标题为“Single plaquette”，展示单个方格（
// plaquette）的规范场结构。左上为灰色环面局部放大，红色
// 粗线勾勒出一个由四条链围成的闭合方格。左下包含三个较小
// 的环面示意图，分别用蓝色、黄色和绿色圆圈标记不同的规范
// 场链，并分别标注蓝色、黄色和绿色字母。这些子图表示单个
// 方格中不同链上的规范场变量，用于说明变分量子电路的构造
// 单元。 子图c为量子电路示意图，标题为“Variational
// quantum circuit”。左侧标注“Gauge qudits”，底部有五个圆
// 形节点，分别标记为蓝色5、黄色5、绿色5、黄色5、绿色5，
// 表示五能级量子比特（qudit）。电路由多个虚线框组成，每
// 个虚线框内包含若干量子门操作。顶部有三个测量符号，分别
// 对应三个量子比特的读出。电路中的门包括：蓝色框标注θ₀、
// θ₁、θ₂、θ₃，黄色框标注θ₀、θ₁、θ₂、θ₃，绿色框标注θ₀、θ₁、
// θ₂、θ₃，以及带负号的蓝色框标注-θ₃、-θ₂、-θ₁、-θ₀。电路
// 中间有垂直连线表示多量子比特门，连接不同颜色的量子比特。
// 电路右侧有标注“5”的箭头，表示五能级系统的维度。该子图
// 展示用于模拟规范场理论的变分量子电路结构，包含单量子比
// 特旋转门和多量子比特纠缠门。 子图d为曲线图，标题为“
// Quantum computation results”。横轴为g⁻²，采用对数坐标，
// 范围从10⁻²到10²。纵轴为⟨O⟩，范围从0.0到1.0。图例包含：
// 蓝色方块表示“Magnetic representation”，橙色方块表示“
// Electric representation”，灰色三角形表示“Qubit
// experiment (VQE)”，灰色菱形表示“Qubit experiment (VQE)
// ”，蓝色虚线表示“Exact (d=3, d=5)”，灰色实线表示“Exact
// (d=21)”。图中蓝色虚线在g⁻²较小时约为0.6，随g⁻²增大逐渐
// 上升至1.0附近；橙色虚线在g⁻²较小时接近0.0，随g⁻²增大上
// 升至0.8附近。灰色三角形和菱形数据点分别对应蓝色和橙色
// 曲线的实验值，在g⁻²较大时与精确曲线存在偏差。该图展示
// 磁表示和电表示的期望值随耦合强度的变化趋势，并比较变分
// 量子实验与精确对角化结果。 子图e为三维柱状图，包含六个
// 子图，分为两行三列。每行三个子图分别对应不同的截断维度。
// 横轴标注“Eigenvalues”，纵轴标注“Population”，范围从0.0
// 到1.0。柱状图颜色包括蓝色、橙色和灰色，分别对应不同的
// 本征态。第一行三个子图展示不同截断下的本征值分布，第二
// 行类似。柱状图高度表示布居数，不同颜色柱并排排列表示不
// 同本征态的概率分布。该子图展示不同截断维度下本征态布居
// 数的分布情况，用于说明截断对量子模拟结果的影响。
#figure(scope: "parent", image("imgs/Fig2.png", width: 98.0%),
  caption: [
    #strong[Refining the gauge field discretization] #strong[a], We consider pure gauge QED in two spatial dimensions with periodic boundary conditions, i.e.~on a lattice on the surface of a torus. As before, the gauge field resides on the links of the lattice, while here the vertices remain empty. #strong[b], We consider the smallest instance of such a torus, containing four empty sites and eight gauge field links. The ground state of this particular system can be described via three separate circulation-paths of the gauge field, called rotators as discussed in @sec:periodic_plaquette. Each rotator fulfills an eigenvalue equation equivalent to a single link gauge field and can thus be subject to the same truncation rules as discussed in the main text by employing a $d$-level qudit. Here, we demonstrate the difference between a realization employing qutrits and ququints. #strong[c], The variational circuit in the electric representation (see main text) for the qutrit (solid lines) and the ququint (all, except shaded box marked with qutrit symbol) truncation. The explicit form of the gates employed is given in @sec:circuit_gates. #strong[d], Experimentally measured expectation values of the plaquette operator $hat(square.stroked.tiny)$ in the VQE-optimized ground states using qutrits (light blue and orange triangles), compared to ququints (dark blue and red pentagons). The error bars indicate one sigma statistical uncertainty. The black line represents numerical results obtained for $d = 21$, using the electric (magnetic) representation for small (large) values of $g^(- 2)$, while the dashed lines are exact numerical results for qutrits and ququints. #strong[e], The duality between the electric (all orange bars) and magnetic (all blue bars) representations is clearly seen in the experimentally measured populations of the eigenvectors of the yellow rotator from panel b for the qutrit VQE experiment and ququint experiment. The grey bars are results obtained via exact diagonalization. In the regime dominated by the electric Hamiltonian (small $g^(- 2)$) a qutrit (light orange) representation is enough to approximate the correct ground state, while for larger $g^(- 2)$ truncation errors become more relevant and a ququint representation (dark orange) becomes advantageous. A complementary argument applies to the magnetic qutrit (light blue) and ququint (dark blue) representation.
  ]
)
<fig:2>

= TOWARDS REFINING THE GAUGE FIELD DISCRETIZATION
<sec:periodic>

The hardware-efficient representation of gauge fields allows us to experimentally address a second prerequisite on the path towards simulating Nature through LGT quantum computations: controlling the number of gauge field levels. More specifically, we demonstrate how our qudit platform allows us to seamlessly improve the gauge field discretization from qutrits ($d = 3$) to ququints ($d = 5$). As a concrete example, we study the dependence of the plaquette expectation value on the bare coupling at different discretizations, as a first important step towards quantum computations of the running of the coupling. To this end, we consider QED on a 2D lattice with periodic boundary conditions, which takes the form of a torus, see #ref(<fig:2>)a.

For our proof-of-concept demonstration, we consider a pure gauge theory $hat(H) = g^2 hat(H)_E + ( 1 / g^2 ) hat(H)_B$, see @eq:Hamiltonian_terms. #ref(<fig:2>)b shows the minimal system consisting of four vertices and eight gauge fields (one per link). Using Gauss' law we reduce the number of independent gauge fields to five, and it can be shown that three of these are sufficient to describe ground state properties~@paper1. Instead of describing the gauge degrees of freedom in terms of the fields associated with the individual links of the lattice as before, we switch to a more convenient description in terms of operators called "rotators". As explained in Ref.~@paper1, each of the three rotators in our simulation can be visualized as loops around a different plaquette, see #ref(<fig:2>)b.

So far, we truncated the gauge field directly in the electric field eigenbasis, i.e.~in our first experiment we included eigenstates $| E chevron.r$ of the electric field operator $hat(E)$ with $hat(E) | E chevron.r = E | E chevron.r$ and $E = 0 , plus.minus 1$. However, to determine the plaquette expectation value resource-efficiently across all values of the coupling, we now employ a more suitable truncation scheme that we introduced in Ref.~@paper1. Our method is based on a Fourier transformation: for large couplings (where $g^(- 2) lt.double 1$), the Hamiltonian is dominated by the electric field contribution $hat(H)_E$, and a gauge field truncation in the electric (E-) field basis is suitable, which we refer to as the electric representation. For small couplings (where $g^(- 2) gt.double 1$), the magnetic field term dominates, and accordingly, a magnetic (B-) field basis (using B-field eigenstates) is more efficient. The VQE circuits for the E- and B- representations are shown in the @sec:periodic_circuit and in #ref(<fig:2>)c respectively. As explained in more detail in the Appendix, their construction is inspired by the form of the Hamiltonian.

#ref(<fig:2>)d shows the resulting ground-state plaquette expectation values versus $g^(- 2)$, along with our theoretical predictions that include a simple noise model, as described in @sec:noise_model. For qutrits and ququints, we perform the full VQE as in @fig:1. Note that we show the results for both representations across all values of the coupling $g^(- 2)$, even though the validity of the electric (magnetic) representation is restricted to the large (small) coupling regime, where $g^(- 2) lt.double 1$ ($g^(- 2) gt.double 1$). The gap between the curves in the intermediate region $g^(- 2) approx 1$, where the electric and magnetic representations perform equally, stems from the truncation of the gauge fields, see Ref.~@paper1. As the truncation is increased, the two curves rapidly approach each other and eventually agree for some intermediate value of $g^(- 2)$, as indicated by the experimental data and confirmed by a numerical simulation at $d = 21$, see #ref(<fig:2>)d. The value of $g^(- 2)$ where the curves are closest indicates the point at which the representation should be switched.

This effect can also be observed in #ref(<fig:2>)e, where we depict the measured populations of the gauge fields in the ground state. In the large coupling regime (where $g^(- 2) lt.double 1$), the distribution of electric field states is narrow, which allows for an efficient truncation in the E-basis. By contrast, this distribution becomes very broad in the small coupling regime, where it tends to an equally weighted superposition of infinitely many E-field levels in the limit $g^(- 2) gt.double 1$. As a result, the accurate approximation of the ground state in the E-basis implies exploding resource costs without a basis change~@paper1. The behavior of the B-representation is complementary. The aforementioned closing of the gap between the plaquette expectation values in the E-representation (red) and the B-representation (blue) in #ref(<fig:2>)d thus corresponds to a better representation of the ground state in #ref(<fig:2>)e. The closing gap for intermediate values of $g^(- 2)$ provides an indication of how well LGT quantum computations with finite $d$ approximate the untruncated results~@paper1.

Similarly, the so-called “freezing” of the truncated plaquette expectation value in the weak coupling regime $g^(- 2) gt.double 1$ serves as an indicator for how well the ground state is approximated. Freezing occurs in both classical and quantum computations if the number of levels $d$ is too small to accurately reflect the spread of the ground state wave function: since there are too few "bins" for the population of the gauge field, the truncated state cannot capture the fact that the ground state still changes with increasing $g^(- 2)$, which is visible as a premature flattening of the plaquette expectation value vs $g$ (the dashed blue lines for $d = 3 , 5$ in Fig. 2d flatten out earlier than the solid black line for $d = 21$).

A detailed explanation and analysis are provided in Ref.~@paper1, showing fast convergence of the plaquette expectation value to the true value already for $d lt.eq 10$. In general, different problems will permit different degrees of truncation. Yet, the moderate values of $d$ available in typical atomic systems are expected to be sufficient for addressing a range of interesting problems, particularly those involving local observables and the ground state sector of the theory~@dimeglio2023quantum @beck2023quantum. Notably, in our experimental setup improving the gauge field discretization is achieved with only minor modifications, involving the same number of ions and entangling gates, see @sec:periodic_circuit.

= TOWARDS REAL-TIME DYNAMICS
<towards-real-time-dynamics>

// [figvision-cn] imgs/time_evolution.png
// 该图由上下两个共享横轴的子图组成，展示二维量子电动力学
// （2D-QED）中含物质场时，粒子数密度（ν）与元格算符期望
// 值（⟨◻⟩）随时间演化的曲线图。横轴为无量纲时间 Ω t，范
// 围从 0 到约 1.4π（标注刻度依次为 0、π/4、π/2、3π/4、π、
// 5π/4，最大延伸至 6π/4 附近）。 顶部图例标注四种数据系
// 列：实验数据用黑色方块表示，并带有表示一倍标准差统计不
// 确定度的误差棒；数值模拟的 Trotter 步数 N_T=1 用点线表
// 示；N_T=10 用虚线表示；精确演化用灰色实线表示。该图例
// 同时适用于上下两个子图。 子图 a（上图）：纵轴为粒子数
// 密度 ν，范围 0.0 至 0.6，刻度间隔 0.2。四条曲线均呈现
// 阻尼振荡特征。实验数据点（黑色方块带误差棒）在 Ω t = 0
// 至约 3π/4 区间内与 N_T=10 虚线及精确实线吻合较好，峰值
// 约在 ν = 0.55 附近（Ω t ≈ π/3 处），随后下降并在 Ω t ≈
// 3π/4 处达到约 0.05 的极小值，之后再次上升。N_T=1 点线
// 的振幅明显偏小，且在 Ω t ≈ 0.6π 处出现一个异常低谷（约
// 0.02）。精确实线在 Ω t > 3π/4 后继续上升至约 0.48（Ω t
// ≈ 1.1π），随后下降，而 N_T=10 虚线在后期略微偏离实线。
// 图中还嵌有两个示意性插图：左侧插图标记了态 |0⟩，显示一
// 个由四个格点组成的方框，中心有一个红色椭圆连接两个蓝色
// 圆点（分别标记为 |v⟩），上下格点标记为 |v⟩；右侧插图标
// 记了态 |+1⟩，结构类似，但中心红色椭圆上方的蓝色圆点标
// 记为 |e⟩，下方为 |v⟩，上方格点标记为 |p⟩，下方为 |v⟩。
// 子图 b（下图）：纵轴为元格算符期望值 ⟨◻⟩，范围 -0.1 至
// 0.3，刻度间隔 0.1，零线有水平细线标记。实验数据点（黑
// 色方块带误差棒）在 Ω t = 0 至 π/2 区间内呈现先上升后下
// 降的趋势，峰值约在 0.21（Ω t ≈ 0.4π 处），随后在 Ω t ≈
// 0.6π 处降至约 -0.06。N_T=10 虚线在 Ω t < π/2 时与实验
// 数据及精确实线趋势一致，但在 Ω t > π/2 后出现明显偏差：
// 虚线在 Ω t ≈ 1.1π 处有一个约 -0.08 的深谷，而精确实线
// 在该处约为 0.0 并随后上升至约 0.3 的峰值（Ω t ≈ 1.15π）。
// N_T=1 点线在整个区间内振幅极小，基本在 0.0 附近波动，
// 仅在 Ω t ≈ 0.6π 处有一个约 0.07 的小峰。实验数据在 Ω t
// > π/2 后误差棒较大，且数据点较少，无法清晰分辨与各理论
// 曲线的吻合程度。
#figure(image("imgs/time_evolution.png", width: 100%),
  caption: [
    #strong[Time evolution for 2D-QED with matter.] Expectation values of the particle number density $nu$ and plaquette operator $chevron.l hat(square.stroked.tiny) chevron.r$ for $Omega = 5$, $m = 0.1$, and $g^(- 2) = 10^(- 1.4)$. We show the numerical values for $N_T = 1$ (dotted) and $N_T = 10$ (dashed) Trotter steps, with the solid line representing the exact evolution. Experimental data (squares) is presented with error bars indicating one sigma statistical uncertainty. The data is obtained by post-selection on the zero magnetization sub-sector on the matter sites. Insets show examples of the dominant states at different times of the evolution.
  ]
)
<fig:long_trotter>

We complete our study of qudit LGT quantum computations by investigating the prospect of simulating real-time evolutions. We take a first step in this direction by using mixed-dimensional entangling gates to realize a digital quantum simulation (in the form of a Trotter protocol~@Lloyd1996) for the model used in @sec:open, i.e.~a plaquette with open boundary conditions including both gauge fields and dynamical matter.

As in the case of the VQE demonstration in @fig:1, we study this model with a hybrid qubit-qutrit system. Starting from the bare vacuum $| v v v v , 0 >$ as the initial state, we study the dynamics of the system under the Hamiltonian given in @eq:openplaq_qubit using a single Trotter step of varying length, see @sec:realtime for details. This time evolution can be interpreted as a quench from the strong coupling regime ($g^(- 2) lt.double 1$), where the bare vacuum is the ground state, to an intermediate coupling value. In the latter regime, the kinetic term of the Hamiltonian drives the creation and subsequent annihilation of particle-antiparticle pairs, leading to an increase of the mean particle number density $nu$, followed by oscillatory behavior. Due to Gauss' law, the creation of charged particles also affects the electromagnetic fields present in the system, which is observed as corresponding dynamics of the plaquette expectation value in #ref(<fig:long_trotter>)b.

= OUTLOOK
<sec:outlook>

Qudits provide a hardware-efficient approach to quantum-simulating gauge theories. Using a universal trapped-ion qudit quantum computer with all-to-all connectivity enables us to simulate arbitrary geometries, and thus perform quantum simulations of 2D-LGTs. In contrast to 1D models, gauge fields must be included explicitly, and in contrast to condensed matter models, the gauge fields in particle physics are described by more complicated gauge groups and must have more than two states. In particular, we are able to simulate a basic building block of 2D-QED with both dynamical matter and gauge fields (@fig:1), and to study different gauge fields discretizations (@fig:2). These complex computations are rendered possible by high-fidelity qudit control, combined with VQE circuits that are much shallower than comparable qubit-based implementations of gauge theory calculations. While we exploit native qudit circuits to study equilibrium properties, the techniques we developed are directly adaptable to digital quantum simulations of real-time dynamics (@fig:long_trotter).

The ultimate goal are LGT quantum simulations in three spatial dimensions. Importantly, there is a dramatic change in the simulation requirements from 1D to 2D, while there is little change going from 2D to the full 3D model~@Kan2021Investigating @zohar_quantum_2021. In particular, while the high-dimensional gauge fields can be integrated out in 1D models, they are dynamic degrees of freedom in 2D and 3D and must be simulated explicitly.

Our results on QED simulations beyond 1D thus represent a major step towards simulating 3D LGTs. In particular, our protocol based on eliminating redundant gauge degrees of freedom employed here can be directly extended to 3D (in the case of QED shown in Ref.~@Kan2021Investigating). Our qudit techniques can be applied to virtually all other quantum computing architectures and hardware platforms. For all of them, the remaining major task is scaling up the system sizes, which makes an efficient gauge field representation even more important. Beyond just programmable local dimensions, qudit-based systems enjoy larger freedom for designing interactions to optimally match the target problem. Notably, quantum error correction schemes, which are making great progress in conventional qubit systems~@bluvstein_logical_2024 @da_silva_demonstration_2024 @campbell_series_2024 are compatible~@watson_fast_2015 with our hardware-efficient qudit approach. Our demonstration of a qudit-based quantum simulation of high-energy physics phenomena thus paves the way to a new generation of qudit-based applications in all areas of quantum technology.

#heading(level: 1, numbering: none)[Acknowledgements]
<acknowledgements>

We thank Karl Jansen and Arianna Crippa for helpful discussions on various lattice QED models. This research was funded by the European Union under the Horizon Europe Programme---Grant Agreements 101080086---NeQST and 101113690---PASQuanS2.1, by the European Research Council (ERC, QUDITS, 101080086), and by the European Union's Horizon Europe research and innovation programme under grant agreement No 101114305 ("MILLENION-SGA1" EU Project). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council Executive Agency. Neither the European Union nor the granting authority can be held responsible for them. We also acknowledge support by the Austrian Science Fund (FWF) through the SFB BeyondC (FWF Project No. F7109) and the EU-QUANTERA project TNiSQ (N-6001), by the Austrian Research Promotion Agency (FFG) through contracts 897481 and 877616, and by the IQI GmbH. We further received support by the ERC Synergy Grant HyperQ (grant number 856432), the BMBF project SPINNING (FKZ:13N16215) and the EPSRC grant EP/W028301/1.

This research was also supported by the Natural Sciences and Engineering Research Council of Canada (NSERC), the Canada First Research Excellence Fund (CFREF, Transformative Quantum Technologies), New Frontiers in Research Fund (NFRF), Ontario Early Researcher Award, and the Canadian Institute for Advanced Research (CIFAR). \
#strong[Author contributions] JZ, JFH, AJJ, LD, PZ, and CM developed the theory results. MM, CE, LP, AS, RB, TM, PS, and MR performed the experiments. MM and JZ analyzed the data and performed numerical simulations. CM and MR supervised the project. All authors contributed to writing the manuscript. \
#strong[Competing Interests] The authors declare no competing interests. \
#strong[Data availability] The data underlying this work are available at #link("https://doi.org/"). \
#strong[Code availability] Code used for data analysis is available from the corresponding author upon reasonable request.

= REALIZING CONTROLLED ROTATIONS IN QUDITS
<sec:experimetal_details>

We encode each qudit in Zeeman states of trapped $""^40 upright("Ca")^(+)$ ions and manipulate their quantum state by sequences of laser pulses. Doppler cooling and state detection is performed by driving the short-lived $S_{1/2}arrow.l.r P_{1/2}$ transition, monitoring the fluorescence of the individual ions on a CCD camera; a simplified level scheme of the relevant states is shown in @fig:exp_ca40_scheme. Quantum gate operations are implemented by selectively addressing single -- or arbitrary pairs of -- ions via a high numerical aperture objective, coupling the $D\_ {5/2}$ manifold with the $S_{1/2}$ ground states @AddressingKim_2008. Due to the geometry of our ion trap, the beam is aligned at an angle of $22.5^compose$ with respect to the trap axis, leading to a Lamb-Dicke factor of $eta = 0.041$ for an axial trap frequency of $omega_z = 0.77 med upright("MHz")$. We measure a heating rate of $2.7 ( 2 )$ phonons per second and a motional coherence time $tau$ of $27.4 ( 4 ) med upright("ms")$.

// [figvision-cn] imgs/fig_methods_ca40.png
// 本图为一张原子能级与跃迁示意图，展示量子比特与量子多比
// 特的编码方式及冷却、探测、激发相关的能级路径。图中没有
// 坐标轴、比例尺或显微成像通道，属于能级示意图。 主要能
// 级与布局如下。左侧垂直方向绘制三条能级：最上方为 P1/2
// 能级，中间为 D5/2 能级，最下方为 S1/2 能级。P1/2 与 S1
// /2 之间用一条蓝色双向波浪箭头连接，表示短寿命跃迁，用
// 于多普勒冷却和状态探测。S1/2 与 D5/2 之间用一条红色斜
// 向箭头连接，箭头由 S1/2 指向 D5/2，表示窄带激光激发的
// 上转换路径。 S1/2 能级分裂为两个塞曼子能级，用括号标出：
// 上方的短横线标注为 +1/2，下方的长黑实线标注为 −1/2。D5
// /2 能级分裂为六个塞曼子能级，用括号标出，自上而下依次
// 为：+5/2、+3/2、+1/2、−3/2、−5/2 和 −1/2。其中 +5/2、+
// 3/2、+1/2、−3/2、−5/2 五个能级用短黑实线表示，且被一个
// 淡红色椭圆阴影覆盖；−1/2 能级用长黑实线表示，并被一个
// 淡蓝色椭圆阴影覆盖。S1/2 的 −1/2 能级同样用长黑实线表
// 示，也处于该淡蓝色椭圆阴影内。能级之间的虚线表示塞曼分
// 裂的间隔。 图中有两个用圆形标注的符号，表示激光作用。
// 右上角淡红色椭圆上方有一个圆圈，内标字母 d，并画有正弦
// 波形符号，表示作用于红色阴影内五个 D5/2 子能级（+5/2
// 至 −5/2）的激光。右下角淡蓝色椭圆上方有一个圆圈，内标
// 数字 2，并画有正弦波形符号，表示作用于蓝色阴影内的 D5/
// 2 的 −1/2 能级和 S1/2 的 −1/2 能级。 图中标注的文字包
// 括：P1/2、D5/2、S1/2、+1/2、−1/2、+5/2、+3/2、+1/2、−3
// /2、−5/2、−1/2，以及带正弦波的圆圈内的 d 和 2。图中未
// 给出具体数值范围、单位或比例尺。 该图传达的核心内容是：
// 量子比特编码在 S1/2 的 +1/2 与 −1/2 两个塞曼态上；量子
// 多比特仅编码在 D5/2 的六个塞曼子能级上（+5/2 至 −5/2
// 共五个，以及 −1/2）。多普勒冷却与状态探测利用 P1/2 与
// S1/2 之间的短寿命跃迁；任何 D5/2 态的激发都会通过该短
// 寿命跃迁衰减到基态；S1/2 与 D5/2 之间的跃迁由相干时间
// 较长的窄带激光驱动。
#figure(image("imgs/fig_methods_ca40.png", width: 100%),
  caption: [
    Simplified level scheme of $""^40 upright("Ca")^(+)$. Doppler cooling and state detection is performed on the short-lived $S_{1/2}arrow.l.r P_{1/2}$ transition with a life time of $approx 9 med upright("ns")$. #emph[Qubits] are encoded in the Zeeman states $|0 chevron.r = S_{m = -1/2}$ and $|1 chevron.r = D_{m = -1/2}$, while #emph[qudits] are encoded only in the $D_{5/2}$ manifold. Any excitation of a $D_{5/2}$ state decays in $T_1 approx 1.1 med upright(s)$ to the $S_{1/2}$ ground states; this transition is addressed by a narrow-band laser with a coherence time of $T_2 = 92 ( 9 ) med upright("ms")$.
  ]
)
<fig:exp_ca40_scheme>

Qudits with dimension $d = 2$ (i.e.~#emph[qubits]) are encoded, such that $|0 chevron.r = S_{1/2}(m = -1/2)$ and $|1 chevron.r = D_{5/2}(m = -1/2)$ as shown in @fig:exp_ca40_scheme. For $d > 2$ only the $D_{5/2}$ manifold of $""^40 upright("Ca")^(+)$ is used for encoding the qudit, while the $S_(1 / 2)$ ground states act as auxilliary levels $| g chevron.r$, which are only populated during gate operations and readout.

Mixed-dimensional qudit-qudit interactions are engineered by controllably coupling qudits to a single phonon mode, effectively, using an Anti-Jaynes-Cummings Hamiltonian described by

$ hat(H)_j = i eta Omega_j (hat(a)^dagger hat(sigma)_j^(+) + hat(a) hat(sigma)_j^(-))^(| g chevron.r arrow.l.r | k chevron.r) , $<eq:AJC_hamiltonian>

on the $j$-th ion with Rabi frequency $Omega_j$. Here, $hat(a)^dagger hat(sigma)_j^(+)$ excites the qudit from the (auxilliary) ground state $| g chevron.r$ from the $S_{1/2}$ manifold to a state $| k chevron.r$ in the $D_{5/2}$ manifold, simultaneously injecting a phonon into the motional mode; $hat(a) hat(sigma)_j^(-)$ has the opposite effect. In our setup, we realize this interaction by driving controlled laser pulses $B ( theta , phi.alt )$ tuned to the first (#emph[blue]) sideband (BSB) of the axial center-of-mass (COM) motional mode. This mode is favorable due to the homogenous coupling for all ions in the string and the reduced calibration effort, as all laser pulses have close to identical parameters for all qudits.

Envisioned to realize the Cirac-Zoller controlled-NOT (CNOT) quantum gate in trapped ions @Cirac1995, sequences of local $B ( theta , phi.alt )$ pulses are well suited to implement mixed-dimensional controlled rotations (C-ROTs) in qudits as shown in @fig:exp_crot_sequence. Here, we consider a two-level subspace of a qudit, described by the states $| 0 chevron.r$ and $| 1 chevron.r$, which can be coupled to the motional mode $| n chevron.r$ via the auxiliary ground state $| g chevron.r$. Conditioned on the control state -- here $| 1 chevron.r$ -- the #emph[control] qudit is entangled with the motion by the interaction in @eq:AJC_hamiltonian, creating a phonon as indicated by the upward triangle in @fig:exp_crot_sequence. To test the control state, a resonant $pi$-pulse transfers the population in $| 1 chevron.r$ to $| g chevron.r$, before a second $pi$-pulse on the blue sideband is applied. It is evident that this operation has no effect if the #emph[control qudit] is initially not in the state $| 1 chevron.r$. On the #emph[target] qudit, we apply a sequence of three sideband pulses (blue boxes), namely

$ B ( pi , 0 )^(| g chevron.r arrow.r | 1 chevron.r) B ( theta , phi.alt )^(| g chevron.r arrow.l.r | 0 chevron.r) B ( - pi , 0 )^(| 1 chevron.r arrow.r | g chevron.r) , $

where the superscripts indicate the respective coupling between the state $| g chevron.r$ and the states $| 0 chevron.r , | 1 chevron.r$. Crucially, these operations affect the #emph[target] qudit only if the phonon mode is excited. In the final step, the operations on the #emph[control] qudit are applied in reverse order, disentangling the #emph[control] qudit from the COM mode, annihilating a phonon depicted by the downward facing triangle.

// [figvision-cn] imgs/fig_methods_crot_sequence.png
// 这是科学论文中展示混合维度受控旋转门（C-ROT）的量子线
// 路示意图。图像采用线路图布局，分为左侧主体线路与右侧说
// 明框两部分，并使用虚线框局部放大了一个关键操作区域。
// 主体线路（左侧）： 横向水平线条表示不同量子能级和模式。
// 最上方有一条标记为 |n⟩ 的青色水平线，代表声子模式，线
// 两端分别标注红色的 “+1” 和 “−1”。下方是两条平行水平线，
// 分别标记为 |1⟩_t 和 |0⟩_t，代表目标量子位的两个逻辑态；
// 紧靠 |1⟩_t 下方有一条标记为 |g⟩_t 的辅助基态线。再往下
// 有一条标记为 |1⟩_c 的线，代表控制量子位。这些横向线在
// 垂直方向上对齐，并通过垂直竖线相连，表示量子比特间的耦
// 合。 竖直方向插入三个蓝色矩形框作为量子操作门。第一个
// 和第三个框内容为 “π”。中间一个框位于虚线局部放大区域内，
// 内容为 “θ, ϕ”。这些门通过垂直竖线与上下方的能级线交叉：
// 每个蓝色框底部通过竖线连至控制线 |1⟩_c（交点处有实心圆
// 点）；顶部通过竖线连至声子模式线 |n⟩。在声子模式线与蓝
// 色框的交叉点附近，有红色三角形符号：左侧三角形尖端向上，
// 标记为 “+1”；右侧三角形尖端向下，标记为 “−1”。红色三角
// 与蓝色框连接的竖线之间用红色虚线水平连接，表明这些相互
// 作用对应声子模式的产生或湮灭。在 |1⟩_t 和 |g⟩_t 线之间，
// 中间蓝色门（θ, ϕ）通过垂直实线短接，表示该门作用于目标
// 量子位的这两个能级。同时，在两个 π 门下方，从 |0⟩_t 到
// |1⟩_t 之间的水平线也通过垂直竖线连到控制线 |1⟩_c 上，
// 交点同样以实心圆点表示。所有竖直连接线均精准对齐。 局
// 部放大虚线框（左上）： 虚线框将中间蓝色门（θ, ϕ）部分
// 放大。框内显示两组水平能级：左侧标记为 |g⟩、|0⟩、|1⟩，
// 右侧标记为 |n=0⟩、|n=1⟩。一条青色斜箭头从 |g⟩ 指向右侧
// 上方的虚线能级，箭头方向由左下至右上，旁附标注 “B(θ, ϕ
// )”。在右侧 |n=0⟩ 和 |n=1⟩ 下方的水平短虚线代表虚能级，
// 表示与声子模式的耦合跃迁过程。 右侧说明框： 一个带圆角
// 的黑色矩形框，内部标题为 “CROT(θ, ϕ)”。框内分为上下两
// 个区域，分别标注 “target” 和 “control”。每个区域内有一
// 个代表量子位的符号：上方标注 “2” 的带圈图标（示意图标）
// 通过一条横线连接到一个波浪线形符号，该波浪线内包含一个
// 粉色圆角矩形；下方 control 区域采用相同图标，但波浪线
// 内相应位置是一个实心黑点。连接线上方有一条垂直竖线，表
// 示两个量子位之间的耦合。这对应整幅图所展示的物理过程：
// 通过声子模式的辅助，在控制量子位 |1⟩_c 和目标量子位 {|
// 0⟩_t, |1⟩_t} 之间实现混合维度的受控旋转操作。
#figure(image("imgs/fig_methods_crot_sequence.png", width: 100%),
  caption: [
    Qudit circuit for implementing a mixed-dimensional controlled rotation (C-ROT) gate. For each 5-dimensional qudit, we consider a two-level subspace, containing the states $| 0 chevron.r$ and $| 1 chevron.r$, coupled to an auxiliary ground state $| g chevron.r$. The conditional interaction with the phonon mode (blue) depending on the control state is shown by the red triangles, with its orientation indicating the creation / annihilation of a phonon. If the motional mode is excited, three BSB pulses act locally on the target qudit, realizing the rotation. At the end of the sequence, the qudits are again disentangled from the motion. In the inset on the right, we introduce a symbol for the C-ROT operation $C R O T ( theta , phi.alt )$, which allows us to draw controlled qudit operations in quantum circuits in a similar manner to qubit gates, see e.g.~#ref(<fig:1>)d.
  ]
)
<fig:exp_crot_sequence>

We extend the well-established circuit representation of quantum gates in qubits by introducing a way to draw interactions in qudits in a similar manner. As shown in the inset in @fig:exp_crot_sequence, we expand the line representing each qudit into $d$ individual rails, allowing us to draw gates acting on subspaces of the qudit unambiguously, and contract the rails back to a single line after the subspace gate. In the case of C-ROTs, the control state is indicated in the usual fashion.

As the Rabi frequency on the BSB is proportional to the Lamb-Dicke factor $eta$, driving the blue sideband requires substantially more laser power than carrier transitions. Each $B ( theta , phi.alt )$ will thus introduce unwanted AC Stark shifts $Delta_(upright("AC"))$ on the order of a few $upright("kHz")$~@Ringbauer2022A-universal, which must be carefully taken into account for achieving high-fidelity C-ROT gates. We compensate these shifts using a two-fold approach: (1) shifts on the actively driven BSB transition are compensated by an off-resonant second-beam technique~@Haeffner_2003 @Meth2022, while (2) additional shifts on spectator #emph[carrier] transitions $| l eq.not k chevron.r$ are measured and compensated in software by frame updates on subsequent operations. An example of shifted spectator states is shown in @fig:exp_stark_shifts_spectators for $B ( theta , phi.alt )$ on the blue sideband of the transition $S_(- 1 / 2) arrow.l.r D_(- 1 / 2)$ with a Rabi frequency $2 pi dot.op 4 med upright("kHz")$. For each state $Delta_(upright("AC"))$ is obtained by a Ramsey measurement.

// [figvision-cn] imgs/fig_methods_crot_stark_shifts.png
// 这是一张能级示意图，展示在激发跃迁蓝边带时，旁观能级（
// spectator levels）上产生的交流斯塔克频移（AC Stark
// shifts）。图中以水平横线表示能级，位置越高表示能量越高；
// 黑色实线表示发生移动后的实际能级，浅灰色实线表示未受微
// 扰的参考能级。图中央有两个竖直的黑色箭头，一个向上、一
// 个向下，分隔开两组能级，引导视线从左侧的基态与激发态区
// 域指向右侧的频移测量结果。 图的左侧展示了自旋量子数 \(
// m_F\) 标记的能级结构，从下到上分别标有 \(-1/2\)、\(-5/
// 2\)、\(-3/2\)、\(-1/2\)、\(+1/2\)、\(+3/2\)、\(+5/2\)。
// 其中底部第一条黑色实线标注为 \(-1/2\)，其上方对应一条
// 浅灰色参考线，标注为 \(+1/2\)。在 \(-1/2\) 与 \(-3/2\)
// 能级之间有一个浅蓝色的双向箭头，旁边标注了 \(B(\theta,
// \phi)\)，表示该跃迁受磁场矢量控制。在左侧偏上的位置，\
// (-1/2\) 能级附近有一条黑色实线，对应的浅灰色参考线位于
// 其上方。 图的右侧展示了三个旁观能级的频移测量结果，每
// 个能级旁都用蓝色圆点标出测量数据，蓝色圆点带有竖直误差
// 棒，表示多次实验运行的统计分布。对应的频移值标注在浅灰
// 色参考线的右侧或上方：最上方能级的频移标注为 \(\Delta_
// {\text{AC}} = 5.3(5)\,\text{kHz}\)，蓝色圆点较高，明显
// 偏上；中间能级的频移标注为 \(\Delta_{\text{AC}} = 1.4(
// 1)\,\text{kHz}\)，蓝色圆点略低于参考线；下方能级的频移
// 标注为 \(\Delta_{\text{AC}} = 1.9(2)\,\text{kHz}\)，蓝
// 色圆点位于参考线下方。在底部 \(-1/2\) 能级处，实际黑色
// 实线与浅灰色参考线几乎重合，图中未标注频移值，说明该能
// 级未测量到显著频移。 整体趋势表明：在蓝边带跃迁被第二
// 个非共振激光束直接补偿的同时，旁观能级相对于基态仍存在
// 几 kHz 量级的交流斯塔克频移，且不同磁子能级的频移量不
// 同（5.3 kHz、1.4 kHz、1.9 kHz），而 \(-1/2\) 能级的频
// 移为零。
#figure(image("imgs/fig_methods_crot_stark_shifts.png", width: 100%),
  caption: [
    AC stark shifts on spectator levels for an excitation of the blue sideband of the $S_(- 1 / 2) arrow.l.r D_(- 1 / 2)$ transition. While the AC Stark shift on this transition is directly compensated by a second, off-resonant laser beam, the spectator levels $D_(- 5 / 2)$, $D_(+ 1 / 2)$ and $D_(+ 3 / 2)$ remain shifted by a few $upright("kHz")$ with respect to the $S_(- 1 / 2)$ ground state; we measure no shift for the $D_(- 3 / 2)$ state. The individual blue dots correspond to different runs over the course of several days and the uncertainty represents one standard deviation of the fit uncertainty. These spectator shifts are compensated in software by storing a phase register for each qudit state and phase-shifting the subsequent operations on the affected qudit transitions by an appropriate amount.
  ]
)
<fig:exp_stark_shifts_spectators>

= 2D-QED HAMILTONIAN
<sec:Methods_Hamiltonian>
The models we simulate are instances of lattice QED and are defined on a two-dimensional discretization of space. Matter (electrons and positrons) and gauge bosons (photons) are defined on the sites and on the links of this lattice respectively, as shown in #ref(<fig:1>)a.

// [figvision-cn] imgs/lattice_p_table.png
// 这幅图由三个子图组成，分别标记为 a、b 和 c，共同说明了
// 二维格子量子电动力学（QED）的构成要素。子图 a 是二维方
// 格子的示意图，水平方向为 x 轴，垂直方向为 y 轴。格点用
// 圆形表示，分为两种：空心圆圈和实心圆圈。实心圆圈中，纯
// 蓝色填充的圆点代表电子，带有斜条纹的蓝色圆点代表正电子。
// 图中展示了三个格点，分别标记为 n、n+ey 以及它们之间的
// 一个点。格点之间通过带有箭头的连线相连，沿着 x 方向的
// 连线标记为 e_x，沿着 y 方向的连线标记为 e_y。在格点 n
// 处，有三个算符标记：E_n,e_y 表示沿 y 方向的电场算符，
// E_n,e_x 表示沿 x 方向的电场算符，q_n 表示该格点的电荷。
// 此外，在格点 n 和其下方格点之间，标记了 E_n-e_y,e_y。
// 图中还包含虚线，表示晶格的周期性延伸。 子图 b 是另一个
// 示意图，聚焦于一个由四个格点组成的方形单元（plaquette）。
// 四个顶点用虚线圆圈表示，分别位于四个角上。四条边分别标
// 记为 U_n,e_x、U_n+ex,e_y、U_n+ey,e_x 和 U_n,e_y，其中
// U 算符带有上标 † 表示厄米共轭。在方形单元的中心，有一
// 个方框，内部标记为 P_n，代表 plaquette 算符。箭头表示
// 这些 U 算符的连接方向，形成一个闭合回路。 子图 c 是图
// 例说明，分为左右两列，分别对应“偶数 n_x + n_y 格点”和“
// 奇数 n_x + n_y 格点”。左列中，第一行展示一个虚线空心圆
// 圈，标记为 ≅ |↓⟩ ≅ |v⟩，并注明 q_n = 0；第二行展示一个
// 纯蓝色实心圆圈，标记为 ≅ |↑⟩ ≅ |e⟩，并注明 q_n = +1。
// 右列中，第一行展示一个虚线空心圆圈，标记为 ≅ |↓⟩ ≅ |p⟩，
// 并注明 q_n = -1；第二行展示一个带有斜条纹的蓝色实心圆
// 圈，标记为 ≅ |↑⟩ ≅ |v⟩，并注明 q_n = 0。该图例明确了不
// 同格点状态与量子态、电荷的对应关系，并区分了奇偶格点上
// 的电子和正电子表示。
#figure(image("imgs/lattice_p_table.png", width: 100%),
  caption: [
    #strong[Elements of two-dimensional lattice QED.] #strong[a], 2D lattice for the Kogut-Susskind Hamiltonian formulation. On each site $upright(bold(n)) = ( n_x , n_y )$ resides a fermionic field operator $hat(phi.alt)_(upright(bold(n)))$ that represents the presence or absence of particles. Each site can either be in the vacuum state or occupied by an electron (positron) for even (odd) sites. Electrons (positrons) are shown as filled circles with solid (striped) color, see panel c. The gauge bosons are described by operators on the links of the lattice. #strong[b], The operator $hat(P)_(upright(bold(n)))$ is defined around a counterclockwise path around the plaquette with origin in $upright(bold(n))$. For every link, $hat(P)_(upright(bold(n)))$ acquires a factor $hat(U)$ if the path goes towards the positive directions $upright(bold(e))_mu$, with $mu in ( x , y )$, and a factor $hat(U)^dagger$ otherwise. #strong[c], Mapping between fermionic states, qubit states (obtained via a Jordan-Wigner transformation), and physical states, including associated charges.
  ]
)
<fig:encoding_si>

Here, matter is described by fermionic field operators $hat(phi.alt)_(upright(bold(n)))$ with spatial label $upright(bold(n)) = ( n_x , n_y )$. We employ the staggered formulation~@kogut1975hamiltonian, in which lattice sites can either be in the vacuum state or host electrons (positrons) residing on even (odd) lattice sites, carrying a $+ 1$ ($- 1$) charge. The charge in terms of the fermionic field is given by $hat(q)_(upright(bold(n))) = hat(phi.alt)_(upright(bold(n)))^dagger hat(phi.alt)_(upright(bold(n))) - frac(1 - ( - 1 )^(n_x + n_y), 2)$.

The gauge field residing on the links between each pair of sites is described by an electric field operator $hat(E)_(upright(bold(n)) , upright(bold(e))_mu)$ ($mu in ( x , y )$) that possesses an infinite but discrete spectrum $hat(E)_(upright(bold(n)) , upright(bold(e))_mu) | E_(upright(bold(n)) , upright(bold(e))_mu) chevron.r = E_(upright(bold(n)) , upright(bold(e))_mu) | E_(upright(bold(n)) , upright(bold(e))_mu) chevron.r$, where $E_(upright(bold(n)) , upright(bold(e))_mu) = 0 , thin plus.minus 1 , thin plus.minus 2 , dots.h$. The link operator $hat(U)_(upright(bold(n)) , upright(bold(e))_mu)$ acts as a lowering operator for the electric field:

$ hat(U)_(upright(bold(n)) , upright(bold(e))_mu) | E_(upright(bold(n)) , upright(bold(e))_mu) chevron.r = | E_(upright(bold(n)) , upright(bold(e))_mu) - 1 chevron.r . $<eq:link_operator>

The total Hamiltonian

$ hat(H) = g^2 hat(H)_E + 1 / g^2 hat(H)_B + m hat(H)_m + Omega hat(H)_k $

is then given by a sum of four parts as shown in @eq:Hamiltonian. Note that compared to the convention used in~@paper1 @paulson_simulating_2021 we have opted to redefine the four Hamiltonians such that they are independent of the mass and coupling constant. Moreover, we consider here another formulation of lattice QED~@wiese2013ultracold @crippa_jansen_2024, in which the signs in the kinetic term are different from the ones used in ~@paper1 @paulson_simulating_2021. For a discussion of the experimental results for the model employed in~@paper1 @paulson_simulating_2021 see App.~@sec:model_cm. By employing the Kogut-Susskind formulation in natural units $ℏ = c = 1$, and with lattice spacing $a = 1$, the terms in the Hamiltonian read~@crippa_towards_2024 $  $<eq:Hamiltonian_terms>

$ hat(H)_E & = 1 / 2 sum_(upright(bold(n))) (hat(E)_(upright(bold(n)) , upright(bold(e))_x)^2 + hat(E)_(upright(bold(n)) , upright(bold(e))_y)^2) ,\
hat(H)_B & = - 1 / 2 sum_(upright(bold(n))) (hat(P)_(upright(bold(n))) + hat(P)_(upright(bold(n)))^dagger) ,\
hat(H)_m & = sum_(upright(bold(n))) ( - 1 )^(n_x + n_y) hat(phi.alt)_(upright(bold(n)))^dagger hat(phi.alt)_(upright(bold(n))) ,\
hat(H)_k & = sum_(upright(bold(n))) ( i hat(phi.alt)_(upright(bold(n)))^dagger hat(U)_(upright(bold(n)) , upright(bold(e))_x)^dagger hat(phi.alt)_(upright(bold(n)) + upright(bold(e))_x) +\
 & quad ( - 1 )^(n_x + n_y + 1) hat(phi.alt)_(upright(bold(n)))^dagger hat(U)_(upright(bold(n)) , upright(bold(e))_y)^dagger hat(phi.alt)_(upright(bold(n)) + upright(bold(e))_y) + upright("H") thin upright(".") thin upright("c") thin upright(".") ) . $

$hat(H)_E$ and $hat(H)_B$ represent the free electric and magnetic field, while $hat(H)_m$ and $hat(H)_k$ describe the free matter field and its interaction with the gauge field. The operator $hat(P)_(upright(bold(n)))$ is defined on a counter-clockwise closed loop around the plaquette with origin $upright(bold(n))$ (see #ref(<fig:encoding_si>)b) as

$ hat(P)_(upright(bold(n))) = hat(U)_(upright(bold(n)) , upright(bold(e))_x) hat(U)_(upright(bold(n)) + upright(bold(e))_x , upright(bold(e))_y) hat(U)_(upright(bold(n)) + upright(bold(e))_y , upright(bold(e))_x)^dagger hat(U)_(upright(bold(n)) , upright(bold(e))_y)^dagger . $<eq:P_op>

Noting that the link operator $hat(U)_(upright(bold(n)) , upright(bold(e))_mu)$ is expressed in terms of the gauge fields' vector potential $hat(A)_(upright(bold(n)) , upright(bold(e))_mu)$, i.e.~$hat(U)_(upright(bold(n)) , upright(bold(e))_mu) tilde upright("exp") ( i g hat(A)_(upright(bold(n)) , upright(bold(e))_mu) )$, one observes that the exponent of $hat(P)_(upright(bold(n)))$ forms a discrete lattice curl of the vector potential. The plaquette operator $hat(square.stroked.tiny) = frac(1, 2 V) sum_(upright(bold(n))) (hat(P)_(upright(bold(n))) + hat(P)_(upright(bold(n)))^dagger)$, where $V$ is the number of plaquettes, is therefore proportional to the magnetic field energy and a true multi-dimensional quantity which has no analog in 1D-QED. In quantum field theories the spontaneous creation of particle/antiparticle pairs in vacuum means that, when measuring the strength of a charge, the result can depend on the distance and energy scale at which it is probed. Since the coupling is proportional to the charge~@hamer1997series, this means that the physical coupling, which is an important parameter in phenomenological HEP models, also depends on the energy scale. This phenomenon is known as the running of the coupling. The dependence of the ground-state plaquette expectation value $chevron.l hat(square.stroked.tiny) chevron.r$ on $g^(- 2)$, where $g$ is the bare coupling, can be related to the running of the coupling and it is discussed more in detail in~@Clemente2022.

Importantly, not all quantum states in the considered Hilbert space are physical. The gauge field and charge configurations of physical states $| Psi_(upright("phys")) chevron.r$ have to fulfill Gauss' law at every site. Here, the familiar law from classical electrodynamics $nabla upright(bold(E)) ( upright(bold(r)) ) - rho ( upright(bold(r)) ) = 0$, where $rho ( upright(bold(r)) )$ is the charge density at point $upright(bold(r))$, takes the form

$ hat(G)_(upright(bold(n))) | Psi_(upright("phys")) chevron.r = 0 , $<eq:gausslaw>

where the Gauss' operator is defined as

$ hat(G)_(upright(bold(n))) = sum_mu ( hat(E)_(upright(bold(n)) , upright(bold(e))_mu) - hat(E)_(upright(bold(n)) - upright(bold(e))_mu , upright(bold(e))_mu) ) - hat(q)_(upright(bold(n))) . $<eq:gauss_operator>

In general, Gauss' law requires physical states to be eigenvectors of the Gauss operator; we have made the choice in @eq:gausslaw to consider the eigenvalues to be zero, which describes a model with no external charges. The total charge $sum_(upright(bold(n))) hat(q)_(upright(bold(n)))$ can be shown to also be a symmetry of the Hamiltonian. In this work, we choose to study states that have zero total charge.

= ENCODED HAMILTONIAN
<sec:Methods_EncodedHamiltonian>
In the following, we provide the Hamiltonians studied via the VQE circuits given in #ref(<fig:1>)d and #ref(<fig:2>)c. \

== 2D-QED with Matter
<sec:methods_open_plaquette>
Let us consider a single plaquette with open boundary conditions with origin in $upright(bold(n)) = ( 0 , 0 )$ and extending in the positive directions, as shown in the inset of #ref(<fig:1>)f. As was discussed in @paulson_simulating_2021, Gauss' law given in @eq:gausslaw can be used to eliminate three gauge fields, resulting in an Hamiltonian that contains four fermionic fields and one gauge field, which we choose to be the one between sites $( 0 , 0 )$ and $( 0 , 1 )$. We encode the fermions i$, dots.h , $ iv (conventionally ordered clockwise around the plaquette starting from $( 0 , 0 )$) into a chain of qubits indexed by $1 , dots.h , 4$ respectively by applying the following Jordan-Wigner transformation

$ hat(phi.alt)_i = product_(j < i) ( e^(i alpha_j) hat(sigma)_j^z ) hat(sigma)_i^(-) , quad hat(phi.alt)_i^dagger = product_(j < i) ( e^(- i alpha_j) hat(sigma)_j^z ) hat(sigma)_i^(+) , $<eq:JW_transformation>

with $alpha_1 = alpha_3 = 0$, and $alpha_2 = pi / 2$\; note that this choice of phases generates a qubit Hamiltonian with all real coefficients.

In particular, the charge associated to each site is now given by $hat(q)_i = frac(hat(sigma)_i^z + ( - 1 )^(i + 1), 2)$. A table summarizing how the spin states are related to the fermionic states is given in~#ref(<fig:encoding_si>)c.

The Hamiltonian

$ hat(H) = g^2 hat(H)_E + 1 / g^2 hat(H)_B + m hat(H)_m + Omega hat(H)_k , $

after the Jordan-Wigner transformation reads

$  $<eq:openplaq_qubit>

$ hat(H)_E & = 1 / 4 ( 8 hat(E)^2 + 2 hat(E) (- 2 hat(sigma)_1^z + hat(sigma)_2^z - hat(sigma)_4^z - 2)\
 & #h(2em) quad + hat(sigma)_1^z - hat(sigma)_2^z + hat(sigma)_1^z hat(sigma)_4^z + 3 ) ,\
hat(H)_B & = - 1 / 2 (hat(U) + hat(U)^dagger) ,\
hat(H)_m & = 1 / 2 (hat(sigma)_1^z - hat(sigma)_2^z + hat(sigma)_3^z - hat(sigma)_4^z) ,\
hat(H)_k & = hat(sigma)_1^(+) hat(U)^dagger hat(sigma)_2^(-) + hat(sigma)_2^(+) hat(sigma)_3^(-) - hat(sigma)_4^(+) hat(sigma)_3^(-) - hat(sigma)_1^(+) hat(sigma)_4^(-) + upright("H.c.") , $

where we have simplified terms in the kinetic Hamiltonian, by using the fact that we consider only states with zero total charge (and therefore zero total magnetization for the qubits), as discussed below @eq:gausslaw.

The gauge degree of freedom is encoded in a qutrit, and following Ref.~@paulson_simulating_2021, we truncate the gauge field operators as

$ hat(E) = mat(delim: "(", 1, 0, 0; 0, 0, 0; 0, 0, - 1) , #h(2em) hat(U) = mat(delim: "(", 0, 0, 0; 1, 0, 0; 0, 1, 0) . $

For the experiment in @fig:1 in the main text, we chose the parameter values $m = 0.1$ and $Omega = 5$. This choice positions our demonstration in the non-perturbative regime, where pair-creation has a significant effect. The definition of the different prefactors of the individual terms in the Hamiltonian can be found in App.~A of @paper1.

== Pure Gauge 2D-QED
<sec:periodic_plaquette>
The second simulated model is a pure gauge theory with periodic boundary conditions as shown in~#ref(<fig:2>)a. We consider here the minimal instance consisting of four vertices, as depicted in #ref(<fig:2>)b. As discussed in Ref.~@paper1, Gauss' law can be used to reduce the system to three independent degrees of freedom; these are described by three operators $hat(P)_i$ ($i = 1 , 2 , 3$) which are defined in @eq:P_op, and are each associated to the magnetic energy of a plaquette depicted in the lower part of #ref(<fig:2>)b. For each plaquette we define the corresponding rotator operator as the circulation of the gauge field going counterclockwise. It can be shown that the rotators have integer spectrum

$ hat(R)_i | r_i chevron.r = | r_i chevron.r , r_i in bb(Z) , $<eq:rotator_spectrum>

and that the operators $hat(P)_i$ act as lowering operators on these states, i.e.~$hat(P)_i | r_i chevron.r = | r_i - 1 chevron.r$.

In order to study this model on a quantum computer, the infinite-dimensional Hilbert spaces of the rotators need to be truncated with a strategy that allows one to systematically increase the truncation size and approach the continuum limit, as discussed in detail in Ref.~@paper1. We summarize here the essential points of the derivation. As a first step the gauge group $"U(1)"$ is substituted by the discrete group $bb(Z)_(2 L + 1)$, and the Hilbert space is then truncated for each rotator to the $2 l + 1$ eigenstates $| - l chevron.r , dots.h , | l chevron.r$, for some $l lt.eq L$. The action of the truncated $hat(P)_i$ operator is then given by $ hat(P)_i | r_i chevron.r = cases(
    | r_i - 1 chevron.r & upright("if ") r_j > - l,
    delta_(l L) | l chevron.r & upright("if ") r_j = - l .
  ) $ The Hamiltonian in terms of the rotators reads $  $<eq:elec_rep>

$ hat(H)^(upright("(e)")) & = g^2 hat(H)_E^(upright("(e)")) + 1 / g^2 hat(H)_B^(upright("(e)")) ,\
hat(H)_E^(upright("(e)")) & = 2 [hat(R)_1^2 + hat(R)_2^2 + hat(R)_3^2 - hat(R)_2 (hat(R)_1 + hat(R)_3)] ,\
hat(H)_B^(upright("(e)")) & = - 1 / 2 (hat(P)_1 + hat(P)_2 + hat(P)_3 + hat(P)_1 hat(P)_2 hat(P)_3 + upright("H.c.")) , $

where we have used the superscript (e) to indicate that we are using here the so-called electric representation, in which the electric Hamiltonian $hat(H)_E^(upright("(e)"))$ is diagonal. The parameter $g$ is the bare coupling and is proportional to the bare electric charge~@hamer1997series.

In the regime where $g lt.double 1$, it is more convenient to apply a discrete Fourier transform to the Hamiltonian, which leads to a magnetic representation, where $hat(H)_B^(upright("(b)"))$ is diagonal. For the calculations, let us define the following coefficients, defined in terms of the polygamma functions $psi_nu ( x )$ $  $

$ f_nu^s & = frac(( - 1 )^(nu + 1), 2 pi) [psi_0 #h(-1em) (frac(2 + L 1 + nu, 2 ( 2 L + 1 ))) - psi_0 #h(-1em) (frac(nu, 2 ( 2 L + 1 )))] ,\
f_nu^c & = frac(( - 1 )^nu, 4 pi^2) [psi_1 #h(-1em) (frac(nu, 2 ( 2 L + 1 ))) - psi_1 #h(-1em) (frac(2 L + 1 + nu, 2 ( 2 L + 1 )))] , $

and introduce the notation $| bold(r) chevron.r = | r_1 chevron.r | r_2 chevron.r | r_3 chevron.r$.

The Hamiltonian in the magnetic representation is then given by $  $

$ hat(H)^(upright("(b)")) & = g^2 hat(H)_E^(upright("(b)")) + 1 / g^2 hat(H)_B^(upright("(b)")) ,\
hat(H)_E^(upright("(b)")) & = sum_(nu = 1)^(2 L) \[ f_nu^c (hat(P)_1^nu + hat(P)_2^nu + hat(P)_3^nu)\
 & quad + f_nu / 2 (hat(P)_2^nu - (hat(P)_2^dagger)^nu) sum_(mu = 1)^(2 L) f_mu^s (hat(P)_1^mu + hat(P)_3^mu) \] + upright("H.c.") ,\
hat(H)_B^(upright("(b)")) & = - sum_(bold(r) = - bold(L))^(bold(L)) \[ cos #h(-1em) (frac(2 pi r_1, 2 L + 1)) + cos #h(-1em) (frac(2 pi r_2, 2 L + 1))\
 & #h(2em) + cos #h(-1em) (frac(2 pi r_3, 2 L + 1)) + cos #h(-1em) (frac(2 pi ( r_1 + r_2 + r_3 ), 2 L + 1)) \] | bold(r) chevron.r chevron.l . | $<eq:magn_rep>

For our quantum calculations shown in @fig:2 we choose $( L , l ) = ( 2 , 1 )$ for the qutrit experiment, and $( L , l ) = ( 3 , 2 )$ for the ququint experiment. Throughout the paper we use $L = l + 1$.

= A VARIATIONAL QUANTUM EIGENSOLVER FOR QUDITS
<a-variational-quantum-eigensolver-for-qudits>

== Variational Circuit
<sec:circuit_gates>
As explained in the main text, the variational circuit shown in~#ref(<fig:1>)d is designed based on the form of the target Hamiltonian given in @eq:openplaq_qubit. Since all the coefficients of the Hamiltonian are real, it is convenient to use gates in the variational circuit that rotate between states with real coefficients only. This approach also allows us to formulate a circuit that is more efficient in the number of variational parameters. In particular, the square blue gates between the qubits in #ref(<fig:1>)d are the magnetization-conserving gates studied in Ref.~@gard_efficient_2020, defined as

$ hat(A) ( theta , phi.alt ) = mat(delim: "(", 1, 0, 0, 0; 0, cos theta, e^(i phi.alt) sin theta, 0; 0, e^(- i phi.alt) sin theta, - cos theta, 0; 0, 0, 0, 1; #none) . $

We choose $phi.alt = 0$ for all gates, which results in a transformation with real coefficients, and the qubits on which $hat(A)$ acts are ordered by decreasing index.

The entangling gates in~#ref(<fig:1>)d, #ref(<fig:2>)c, @fig:open_ququint, and~@fig:periodic_magnetic_circuit marked by the rounded box are controlled rotations. When the control is active, the rotation on the target qudit is given by

$ hat(R)_y^(i , j) ( theta ) = exp (- i theta hat(sigma)_y^(i , j) / 2) , $

where $i , j$ are the levels addressed in the target qudit, and $hat(sigma)_y^(i , j)$ is the corresponding Pauli $y$ matrix; this choice ensures that the rotation has real coefficients. In the qubit-qudit configuration, the rotation is active when the control qubit is in the $| arrow.b chevron.r$ state, while for the qudit-qudit gate, the control state is explicitly marked in the corresponding circuits. The experimental implementation of these gates is discussed in more detail in @sec:experimetal_details. The last type of gate used in our variational circuit is the qudit-internal rotation shown in #ref(<fig:2>)c and~@fig:periodic_magnetic_circuit as square boxes. They are given by the $x$ rotation between the addressed states $i , j$

$ hat(R)_x^(i , j) ( theta ) = exp (- i theta hat(sigma)_x^(i , j)) . $

== Optimization Algorithm
<sec:vqe>
For our VQE experiments, we employ two optimization strategies, which are both based on Bayesian optimization (BO)@Frazier2018aa. Here, the algorithm collects evaluations of the cost function $chevron.l hat(H) ( bold(theta) ) chevron.r$ for proposed sets of $n$ input parameters $bold(theta) = { theta_i }_(i = 1 dots.h n)$ and constructs a surrogate model via a Gaussian process to represent the cost function. This allows one to quantify how likely further evaluations of the cost function are to achieve an improvement over the best-found value so far and hence reduces the overall number of evaluations to be performed. Importantly, the method does not require gradient evaluations and can tolerate noisy input data.

For the system with periodic boundary conditions in Fig.~2 of the main text, our BO strategy is very close to the one described in Ref.~@Frazier2018aa. We initialize the optimizer by evaluating $chevron.l hat(H) chevron.r$ at the corners of the parameter space, creating a $n times n$ grid. Next, the algorithm maps out the energy landscape by tuning $bold(theta)$ for up to 100 evaluations (in the qutrit case). Treating the input parameters as vectors $upright(bold(v)) ( bold(theta) )$, convergence is achieved if the norm $lr(|upright(bold(v)) ( bold(theta) ) - upright(bold(v)) ( bold(theta)' )|)$ between 5 consecutive runs does not exceed a threshold of $0.01$.

The variational optimization for the case involving matter and gauge fields is more complex. From @eq:Hamiltonian it is evident that $g^(- 2)$ only acts as a scaling factor for the individual terms contributing to the expectation value $chevron.l hat(H) ( bold(theta) ) chevron.r$. Hence, the cost function can be evaluated simultaneously for all values of $g^(- 2)$ after each measurement. This allows us to generate a data storage system and pair it with the BO algorithm. We allow the algorithm to initialize the storage by taking 130 measurements, before sampling up to 300 times or until convergence is achieved. During the optimization of the parameters for a single value of $g_i^(- 2)$, the outcomes are processed and saved for successive searches. After successful optimization for $g_i^(- 2)$, this process is repeated for $g_(i + 1)^(- 2)$, considering all previous outcomes. With the assumption, that the optimal solutions change smoothly for small variations in the bare coupling, the already found minimum for $g_i^(- 2)$ is a good candidate for an initial guess for $g_(i + 1)^(- 2)$. Consequently, the algorithm now does not require sampling the whole parameter space but can invest in refining the search around promising solutions. As the bare coupling is changed, the available #emph[knowledge] increases, in turn yielding faster convergence.

We also modify a recently proposed trust region BO @Eriksson2019Scalable to accept noisy cost function evaluations, couple it to the data storage, and perform two sweeps in the coupling ranging from $g^(- 2) = 0.01$ to $g^(- 2) = 100$. The best values are obtained after the last run.

== VQE Measurements for Qudits
<sec:measurement>
In the following, we explain the qudit measurements and basis decompositions that are performed in our VQE experiments. Contrary to qubits where one naturally chooses the Pauli product basis, there is no clear indication for the best possible basis to decompose a given qudit (possibly mixed-dimensional) Hamiltonian. This is due to the fact that the Pauli operators allow for an efficient classical determination of a circuit that diagonalizes a group of commuting Pauli operators so they can be measured simultaneously~@Shlosberg2023adaptiveestimation.

For qudits, we represent the Hamiltonian in terms of the so-called clock and shift operators, which are normalized by the generalized Clifford group comprising of the $d$-dimensional SUM (generalized CNOT), Hadamard and S gates~@gottesman1999fault @jena_future. More precisely, the clock and shift operators are respectively defined as $hat(Z) = upright("diag") ( e^(frac(2 pi i, d) k) )_(k = 0)^(d - 1)$ and $( hat(X) )_(k l) = delta_(k , j - 1) + delta_(k , d) delta_(j , d)$. By expressing the matter and gauge fields, as well as the operators $hat(P)_(upright(bold(n)))$ as linear combinations of tensor products of $hat(X)^alpha hat(Z)^beta$ ($alpha , beta in ( 0 , dots.h , d - 1 )$), we can therefore write the Hamiltonian $hat(H)$ with contributions from @eq:elec_rep and~@eq:magn_rep in terms of the clock and shift operators only, $hat(H) = sum_i c_i hat(O)_i$,~@jena_future. Here, $c_i in bb(C)$ and $hat(O)_i = ⨂_(j = 1)^m hat(X)^(alpha_j^i) hat(Z)^(beta_j^i)$ for $m$ qudits and coefficients $alpha_j^i$ and $beta_j^i$ determined by the decomposition of $hat(H)$.

Normalizing these operators with gates from the generalized Clifford group then maps a subset of the $hat(O)_i$ operators to clock operators $hat(Z)^(gamma_i)$ (with all $gamma_i$ not necessarily identical), which can subsequently be measured simultaneously.

= REAL-TIME EVOLUTION
<sec:realtime>

In this section we show how to use the qudit tools that we developed in the context of equilibrium problems (see @fig:1 and @fig:2) to study time evolutions in LGTs, an area that is inaccessible to MCMC methods due to sign-problems~@Troyer:2004ge @Gattringer:2016kco. As proof-of-concept demonstration, we consider here a single plaquette with open boundary conditions, as in @sec:open of the main text. As in the case of the VQE demonstration, we study this model with a hybrid qubit-qutrit system, which can be realized within the same trapped-ion chain. As initial state of the time evolution we choose the bare vacuum of the system $| v v v v , 0 chevron.r$, where no particles (first four entries) or gauge field excitations (last entry) are present. We study its time evolution under the Hamiltonian given in @eq:openplaq_qubit. As depicted in @fig:encoding_si, the initial state in qubit-qudit form is given by $| arrow.b arrow.t arrow.b arrow.t , 0 chevron.r$. This time evolution can be interpreted as a quench from the strong coupling regime ($g^(- 2) lt.double 1$), where the bare vacuum is the ground state, to a weaker coupling. To simulate this time evolution on our quantum hardware, we perform a Trotter protocol~@trotter_product_1959 @Lloyd1996. We decompose the Hamiltonian into a sum $hat(H) = sum_i hat(h)_i$, then the state at time $t$ calculated with $N_T$ Trotter steps is given by

$ underbrace(product_(i = 1) exp (- i t / N_T hat(h)_i) dots.h product_(i = 1) exp (- i t / N_T hat(h)_i), N_T upright("times")) | arrow.b arrow.t arrow.b arrow.t , 0 chevron.r . $

We choose the following decomposition into Trotter steps for the Hamiltonian given in @eq:openplaq_qubit: $  $<eq:trotter_decomposition>

$ hat(h)_1 & = Omega (hat(sigma)_1^(+) hat(U)^dagger hat(sigma)_2^(-) - hat(sigma)_4^(+) hat(sigma)_3^(-) + upright("H.c.")) ,\
hat(h)_2 & = Omega (hat(sigma)_2^(+) hat(sigma)_3^(-) - hat(sigma)_1^(+) hat(sigma)_4^(-) + upright("H.c.")) ,\
hat(h)_3 & = g^2 / 4 (hat(sigma)_1^z hat(sigma)_4^z + - 4 hat(E) hat(sigma)_1^z + 2 hat(E) hat(sigma)_2^z - 2 hat(E) hat(sigma)_4^z) ,\
hat(h)_4 & = m / 2 (hat(sigma)_1^z - hat(sigma)_2^z + hat(sigma)_3^z - hat(sigma)_4^z) +\
 & quad g^2 / 4 (8 hat(E)^2 - 4 hat(E) + hat(sigma)_1^z - hat(sigma)_2^z + 3) ,\
hat(h)_5 & = - 1 / g^2 (hat(U) + hat(U)^dagger) . $

We experimentally realize the above Trotter protocol for a single Trotter step $N_T = 1$. The gates appearing in the Trotter circuit (see #ref(<fig:exp_trotter>)a) are experimentally implemented as follows: All local gates, including $hat(sigma)^z$, $hat(U)$, and $hat(E)^(( 2 ))$ are realized as in the main text. Terms of the form $hat(E) hat(sigma)^z$ are (for qutrits) effectively equivalent to $hat(sigma)^z hat(sigma)^z$, and are realized by a standard Mølmer-Sørensen (MS) gate~@sorensen1999quantum that is locally rotated using (subspace) Hadamard gates on all involved ions. Gates of the form $hat(sigma)^(+) hat(sigma)^(-) + upright("H.c.")$ are realized as $hat(sigma)^x hat(sigma)^x + hat(sigma)^y hat(sigma)^y$, which corresponds to a sequence of two locally rotated MS gates. This leaves only the term $hat(sigma)_1^(+) hat(U)^dagger hat(sigma)_2^(-) + upright("H.c.")$. Extending the decomposition given in Ref.~@andrade_engineering_2022, this three-body coupling can be realized using 24 two-body MS gates:

$ e^(i theta ( hat(sigma)_i^(+) hat(U)_j^dagger hat(sigma)_k^(-) + upright("H.c.") )) = & e^(- frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(z_01)) e^(frac(i theta, 4) hat(sigma)_j^(x_01) hat(sigma)_k^x) e^(frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(z_01))\
 & e^(- frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(y_01)) e^(frac(i theta, 4) hat(sigma)_j^(z_01) hat(sigma)_k^y) e^(frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(y_01))\
 & e^(- frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(y_01)) e^(- frac(i theta, 4) hat(sigma)_j^(z_01) hat(sigma)_k^x) e^(frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(y_01))\
 & e^(- frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(x_01)) e^(- frac(i theta, 4) hat(sigma)_j^(z_01) hat(sigma)_k^y) e^(frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(x_01))\
 & e^(- frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(z_12)) e^(frac(i theta, 4) hat(sigma)_j^(x_12) hat(sigma)_k^x) e^(frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(z_12))\
 & e^(- frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(y_12)) e^(frac(i theta, 4) hat(sigma)_j^(z_12) hat(sigma)_k^y) e^(frac(i pi, 4) hat(sigma)_i^y hat(sigma)_j^(y_12))\
 & e^(- frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(y_12)) e^(- frac(i theta, 4) hat(sigma)_j^(z_12) hat(sigma)_k^x) e^(frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(y_12))\
 & e^(- frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(x_12)) e^(- frac(i theta, 4) hat(sigma)_j^(z_12) hat(sigma)_k^y) e^(frac(i pi, 4) hat(sigma)_i^x hat(sigma)_j^(x_12)) , $

where $hat(sigma)^(z_(i j))$ refers to the Pauli-Z operator acting on the subspace spanned by the states $( | i chevron.r , | j chevron.r )$. In our simple proof-of-principle experiment, for a given initial state, it is not necessary to implement the full coupling term. Instead, we only implemente the non-trivial component for the given initial state, requiring just 6 MS gates. Notably, all required interactions for the mixed-dimensional time evolution of 2D QED are already part of our toolbox in the main text.

The minimal realization using one Trotter step allows us already to observe the dynamics of the mean particle number density $nu = ⟨hat(H)_m⟩ / 4 + 1 / 2$, as shown in @fig:exp_trotter. Note that $nu = 0$ for the bare vacuum, and $nu = 1$ for a completely filled system. We can see that immediately after the quench, the kinetic part of the Hamiltonian brings pair-creation processes into play, therefore increasing the particle density of the state. After some particles and antiparticles are created, however, pairs can be annihilated, leading to a decrease in the average particle density. @fig:long_trotter shows how the dynamics of the particle number density $nu$ and the plaquette expectation value $hat(square.stroked.tiny)$ is approximated by the Trotter time evolution, with $N_T = 1$, $N_T = 10$, and $N_T arrow.r oo$ (exact result).

// [figvision-cn] imgs/exp_trotter.png
// 子图 a 是一个量子线路示意图，展示了一个包含动力学物质
// 的单 plaquette（方格）的 Trotter 时间演化线路。图左侧
// 为图例，右侧为线路主体。图例包含五个符号：灰色正方形表
// 示“Local gates”（局域门）；左粉右蓝的圆形连线段表示 \(
// \hat{E}\hat{\sigma}_i\)；两个蓝色圆形连线段表示 \(\hat
// {\sigma}_i^z \hat{\sigma}_j^z\)；蓝色长圆角矩形表示 \(
// \hat{\sigma}_i^+ \hat{\sigma}_j^- + \text{H.c.}\)；左
// 菱形右蓝色长圆角矩形表示 \(\hat{\sigma}_i^+ \hat{U} \
// hat{\sigma}_j^- + \text{H.c.}\)。 线路主体由五条垂直的
// 量子线（从左到右标记为 i、ii、iii、iv 等，底部标有 i、
// ii、iii、iv）和作用于其上的门组成。线路顶部的五条线上
// 各有一个带有斜线的方框，随后依次出现，右侧用大括号标注。
// 第一个大括号对应 \(\hat{H}_B\) (magnetic energy，磁能)，
// 包含作用于每条线上的单个灰色正方形局域门；第二个大括号
// 对应 \(\hat{H}_m\) (particle mass，粒子质量)，包含相邻
// 量子线之间的四个灰色正方形门（作用于 i-ii、ii-iii、
// iii-iv、iv-v）；第三个大括号对应 \(\hat{H}_E\) (
// electric energy，电能)，包含多组门：首先在 i 线上有一
// 个粉色圆点，然后 i 与 v 线上各一个粉色/蓝色圆点由竖直
// 线连接，接着是 i 与 iii、ii 与 iv 的粉蓝圆点对连接，形
// 成一个复杂的连接网络，其中涉及粉色和蓝色圆点作为端点。
// 第四个大括号对应 \(\hat{H}_k\) (pair creation，对产生)，
// 最上方是一个跨越所有线的蓝色长圆角矩形，其下方是连接
// ii-iii 和 iii-iv 的较短蓝色长圆角矩形，再下方是连接
// i-ii 和 iii-iv 的蓝色长圆角矩形。线路的最底部，i 线上
// 有一个带有数字“3”的粉色圆点，ii 到 v 线上各有一个带有
// 数字“2”的蓝色圆点，且每个圆点旁都有一个类似电阻符号的
// 折线标记。整个线路通过垂直的黑色实线连接各个门。 子图
// b 是一个示意图，用灰色虚线框出，展示动能项引起的跃迁示
// 例。虚线框内左侧有四个标记为 \(|v\rangle\)、\(|0\
// rangle\)、\(|v\rangle\) 的状态（上下排列），中间有一个
// 粗灰色双向箭头，右侧有四个标记为 \(|p\rangle\)、\(|+1\
// rangle\)、\(|e\rangle\) 的状态（上下排列）。左侧 \(|v\
// rangle\) 到右侧 \(|p\rangle\) 的箭头上有一个蓝色圆圈内
// 含黑色斜线；左侧 \(|v\rangle\) 到右侧 \(|e\rangle\) 的
// 箭头上有一个黑色虚线圆圈；左侧 \(|0\rangle\) 到右侧 \(
// |+1\rangle\) 的箭头上有一个实心蓝色圆点。这三条箭头均
// 从左侧指向右侧。子图 a 中线路最下方的 i 线粉色圆点（标
// 记 3）处，有一条灰色虚线引出指向子图 b 的虚线框。
#figure(image("imgs/exp_trotter.png", width: 100%),
  caption: [
    #strong[Time evolution circuit for 2D-QED with matter.] #strong[a], Circuit for the Trotter time evolution of a plaquette with dynamical matter, following the decomposition given in @eq:trotter_decomposition. For details on the model see @sec:realtime. #strong[b], An example of the transitions induced by the kinetic term of the Hamiltonian.
  ]
)
<fig:exp_trotter>

= QUANTUM COMPUTING FOR PARTICLE PHYSICS
<Sec:Roadmap>

Predictions in particle physics that involve the strong force can in general not be performed with perturbative methods and require therefore computer simulations. So far, lattice gauge theory (LGT) is the only general solution available in this endeavor. The standard approach of performing LGT simulations using the action formalism and Markov Chain Monte Carlo (MCMC) calculations has proven to be extremely successful but breaks down in situations that involve, for example, finite fermionic chemical potentials (i.e.~finite matter densities) and real-time dynamics~@Gattringer:2016kco. This limitation motivates an intensive ongoing search for new computational methods. Since quantum computing does not face the sign-problems that currently impede MCMC-based approaches, LGT quantum simulations offer an exciting opportunity to explore new avenues for gauge theory calculations in high energy physics~@dimeglio2023quantum @beck2023quantum @bauer_quantum_2023. In particular, quantum computers could allow making inroads into the two big problem areas outlined below.

#strong[Equilibrium physics] -- A concrete example of a problem that is out of reach for current MCMC-based methods is the phase diagram of quantum chromodynmics (QCD), which describes quarks and gluons at different fermionic chemical potentials and temperatures~@bogdanov_snowmass_2022. Forming the basis for understanding which states of matter are possible in Nature, the QCD phase diagram informs important open questions in nuclear physics, particle physics and cosmology, and could be explored by future LGT quantum simulations at finite densities.

#strong[Dynamics] -- Another specific example of a problem area that is currently inaccessible to MCMC calculations is the real-time evolution in collider physics~@banuls2019simulating. Since there is no fundamental roadblock to study dynamics with quantum computers, LGT quantum simulations could open the door to a better understanding of particle collisions, i.e. the modelling and simulation of how the different degrees of freedom evolve in time during scattering processes observed at collider experiments at CERN and other facilities.

Traditional methods cannot even begin addressing the problem areas outlined above, as MCMC calculations do not converge and the method is unsuitable from the outset. Using quantum computers as a new tool for investigating the above examples, will involve a number of challenges including the following two key steps:

+ Simulating LGTs in 3D, which requires representing gauge degrees of freedom with three and more levels.

+ Simulating LGTs with non-Abelian symmetry groups, i.e.~including color-degrees of freedom.

= QUDIT ADVANTAGE
<Sec:Supp:Advantage>
We are now comparing our native qudit implementation to a standard #emph[qubit] implementation of the circuits presented in the main text. Here we follow the efficient paradigm outlined in Ref.~@paper1, where high-dimensional gauge fields are encoded into qubits using a one-hot encoding: we map each $d$-level gauge field onto $d$ qubits. All qubits are in the up state, except for one; which qubit is in the down state indicates which of the $d$ levels is occupied. This has the advantage of greatly simplifying the required entangling gates and thus reducing the circuit depth, at the cost of an increase in qubit number. One may also consider a binary encoding, where we map a qudit onto $ceil.l log_2 d ceil.r$ qubits. This optimizes the required register size at the cost of more complicated entangling gates. For the qudit platform, we make the assumption that an embedded CNOT gate (i.e.~a CNOT gate acting on a qubit subspace of the qudit Hilbert space) can be performed with roughly equal fidelity as the same gate in a pure qubit system. This is the case for the trapped-ion platform used here.

We now consider the scaling of circuit complexity with increasing gauge-field truncation to capture the physics more accurately. Starting with the full gauge theory of one plaquette in 2D, as shown in the main text @fig:1, we propose a physically motivated generalization of the VQE circuit, which requires a linear increase in gate count with gauge field dimension. In particular, we show in @fig:open_ququint the generalization of the circuit when using a ququint truncation for the gauge field. More generally the qudit implementation of the circuit requires three CNOT for each of the qubit $A$ gates, and two CNOT for each of the C-ROT for a total of $18 + 4 ( d - 1 )$ CNOT gates. In the case of the qubit implementation studied in Ref.~@paulson_simulating_2021 $18 + 36 ( d - 1 )$, since the implementation of a control-rotation, in this case, requires six CNOT. This shows that the scaling of the qudit platform is about an order of magnitude better than a comparable qubit platform, already in this simplest instance of the problem. Note that we use the CNOT-based gate count for cross-platform comparability, while our experiment is using a different decomposition of the gates, specific to trapped ions. The results are summarized in @tab:open.

#figure(scope: "parent", [#table(
    stroke: none,
    columns: 7,
    align: (center, center, center, center, center, center, center),
    table.hline(stroke: 0.8pt),
    table.header(
      table.cell(colspan: 3)[Qudit encoding],
      table.cell(colspan: 3)[Qubit encoding],
    ),
    table.hline(),
    [Dimension $d$], [3], [5], [7], [3], [5], [7],
    [Register size], [5], [5], [5], [7], [9], [11],
    [CNOT count], [26], [34], [42], [90], [162], [234],
    [CNOT fidelity], table.cell(colspan: 6)[99%],
    [Approx. circ. fid.], [77%], [71%], [66%], [40%], [20%], [10%],
    [CNOT fidelity], table.cell(colspan: 6)[99.5%],
    [Approx. circ. fid.], [88%], [84%], [81%], [64%], [44%], [31%],
    table.hline(stroke: 0.8pt),
  
  )], caption: [#strong[Circuit complexity of a single plaquette of the full gauge theory in 2D]. The complexity is measured in a hardware-agnostic way by the gate count when all entangling gates (qubit and qudit) are decomposed into two-level CNOT gates under the assumption that these gates work equally well in qudit as in qubit systems. More efficient decompositions might exist by using custom hardware-efficient gates.]
  , kind: table
  )
<tab:open>



// [figvision-cn] imgs/open_plaqutte_ququint.png
// 这是一张量子线路示意图，用于展示在规范场由五能级系统（
// ququint）表示时，模拟具有开放边界条件的单个格面（
// plaquette）的变分拟设。图中没有坐标轴、色标或比例尺，
// 所有信息通过线路拓扑、量子门符号和文字标注表达。 图中
// 从左到右共排列 5 条垂直的量子线（代表五个量子比特或量
// 子单元），顶部和底部标注了各自的状态或测量结果。左侧第
// 一条线代表 ququint 子空间，其余四条线代表辅助量子比特。
// 左侧第一条垂直线的顶部标注为 0，其下方依次标注了 −2、−
// 1、1、2，分布在一组由虚线包围的竖列旁；这条线顶部还有
// 一个量子门，输入为 0 和 0 的弧线标记。该线底部有一个实
// 心圆，内部标有数字 5，代表对该五能级系统进行测量，测量
// 基或结果对应数字 5。这条线从上到下的门排列依次为：粉色
// 椭圆门 θ10、θ9、θ8、θ7、θ6、θ5、θ4、θ3。这些粉色门均为
// 单量子比特旋转门，从左到右呈阶梯状分布。 其余四条垂直
// 线，从左到右依次记为第 2、3、4、5 条线，每条线的顶部都
// 有一个输入态标注，但没有左侧 ququint 那样详细的能级标
// 签；这四条线的底部各有一个蓝色实心圆，内部均标注数字 2，
// 代表每个辅助量子比特进行测量，测量结果对应 2。这四条线
// 之间包含蓝色矩形门和粉色矩形门：其中第 2 和第 3 条线之
// 间连接了蓝色门 θ12；第 3 和第 4 条线之间连接了蓝色门 θ
// 11；第 3 和第 5 条线之间连接了蓝色门 θ13；在第 2 到第
// 5 条线之间横跨了一个大型蓝色门 θU。右侧下方，第 2 和第
// 3 条线之间有一个较小的蓝色门 θ2，第 3 和第 4 条线之间
// 有一个较小的蓝色门 θ1。 图中网络连接呈现典型的星形耦合
// 布局：左侧 ququint 线通过多个多量子比特门与右侧四个辅
// 助量子比特耦合。具体来说，粉色门 θ10 位于第一条线上，
// 并通过一条水平线连接到第 2 条线上的一个黑色控制点（实
// 心圆点）；θ9 连接至第 3 条线；θ8 连接至第 4 条线；θ7、
// θ6、θ5、θ4、θ3 也各通过一条水平线连接至第 2 条线上的不
// 同控制点，这些水平线在图中呈现为多个交叉或平行的连线。
// 蓝色门 θ12、θ11、θ13 和 θU 主要作用于辅助量子比特之间，
// 其中 θU 横跨第 2 到第 5 条线，为多比特联合门。 该子图
// 传达的核心趋势是：通过将 ququint 的五个能级映射到一条
// 量子线上，并利用一系列单比特旋转（粉色椭圆门）与多比特
// 受控门（水平连接线和蓝色矩形门）的组合，构建一个变分量
// 子线路，用于模拟格面规范场的动力学。左下方的测量结果 5
// 和右侧的四个测量结果 2 表明该线路包含测量阶段，可能用
// 于提取期望值或进行态制备验证。图中所有门参数（θ1、θ2、
// θ3…θ13、θU、θ10 等）均为变分参数，需要在优化过程中调整。
#figure(image("imgs/open_plaqutte_ququint.png", width: 50%),
  caption: [
    Variational ansatz for simulating a single plaquette with open boundary conditions when the gauge field is represented by a ququint. The gates used in the circuit are defined in @sec:circuit_gates.
  ]
)
<fig:open_ququint>

The results are even more striking in the case of a pure gauge theory as discussed in @fig:2 of the main text. Here, the qudit platform shows no scaling with gauge field truncation, as the added complexity is only in the local qudit operations. In the qubit platform, on the other hand, the gate count scales as $48 + 12 d$, and the register size scales as $3 d$, see @tab:periodic. Considering an encoding optimized for register size, this growth can be reduced to $3 ceil.l log_2 ( d ) ceil.r$, at the cost of a gate count that scales in general quadratically with the dimension.

#figure(scope: "parent", [#table(
    stroke: none,
    columns: 7,
    align: (center, center, center, center, center, center, center),
    table.hline(stroke: 0.8pt),
    table.header(
      table.cell(colspan: 3)[Qudit encoding],
      table.cell(colspan: 3)[Qubit encoding],
    ),
    table.hline(),
    [Dimension $d$], [3], [5], [7], [3], [5], [7],
    [Register size], [3], [3], [3], [9], [15], [21],
    [CNOT count], [8], [8], [8], [84], [108], [132],
    [CNOT fidelity], table.cell(colspan: 6)[99%],
    [Approx. circ. fid.], [92%], [92%], [92%], [43%], [34%], [27%],
    [CNOT fidelity], table.cell(colspan: 6)[99.5%],
    [Approx. circ. fid.], [96%], [96%], [96%], [66%], [58%], [52%],
    table.hline(stroke: 0.8pt),
  
  )], caption: [#strong[Circuit complexity of a pure gauge plaquette with periodic boundary conditions]. The complexity is measured in a hardware-agnostic way by the gate count when all entangling gates (qubit and qudit) are decomposed into two-level CNOT gates under the assumption that these gates work equally well in qudit as in qubit systems. More efficient decompositions might exist by using custom hardware-efficient gates.]
  , kind: table
  )
<tab:periodic>



Finally, one might suspect that the price to pay for the reduced circuit complexity in the qudit approach is a less favorable runtime. While it is generally true that the qudit circuits take longer due to long readout times, we show in @tab:runtimes that even the tradeoff between qudit readout ($( d - 2 ) 4$ ms) and qubit gate complexity ($0.2$ ms per gate) is slightly in favor of the qudit system for the problems studied here.

#figure(
  align(center)[#table(
    stroke: none,
    columns: 7,
    align: (center, center, center, center, center, center, center),
    table.hline(stroke: 0.8pt),
    table.header(
      table.cell(colspan: 3)[Qudit encoding],
      table.cell(colspan: 3)[Qubit encoding],
    ),
    table.hline(),
    [Dimension $d$], [3], [5], [7], [3], [5], [7],
    [Register size], [3], [3], [3], [9], [15], [21],
    [Rel. runtime open], [1], [1.52], [2.04], [1.48], [2.26], [3.04],
    [Rel. runtime periodic], [1], [1.54], [2.08], [1.76], [2.08], [2.41],
    table.hline(stroke: 0.8pt),
    )]
  , caption: [#strong[Runtimes of one execution of the qubit and qudit implementations]. These times are calculated for the device used in the main text and may differ in other architectures.]
  , kind: table
  )
<tab:runtimes>

= VQE CIRCUIT FOR PURE-GAUGE QED WITH PERIODIC BOUNDARY CONDITIONS
<sec:periodic_circuit>
We explain here the essential points of the design of the circuit used to study the pure-gauge QED model producing the results shown in #ref(<fig:2>)d. A more detailed discussion is found in Ref.~@paulson_simulating_2021.

As for the case of 2D-QED with matter discussed in the main text, the form of the circuit is inspired by the Hamiltonian that the VQE solves, providing us with a scalable strategy that works also for higher truncations of the gauge field, and also with two different variational circuits for the electric and magnetic representation respectively. Let us consider the electric Hamiltonian given in @eq:elec_rep, its ground state is found via the variational ansatz given by the circuit in~#ref(<fig:2>)c. After creating superpositions of all states for rotator $hat(R)_2$, there is a layer of C-ROT gates that reflects the coupling between rotators given by $hat(H)_E^(( e ))$, where we have used the symmetry between rotator $hat(R)_1$ and $hat(R)_3$ to reduce the number of independent variational parameters. For larger values of $g^(- 2)$, the system tends to occupy states where the three rotators occupy the same electric field eigenstate, therefore we spread the population of rotators 1 and 3 controlling suitably on the corresponding state of rotator 2.

The circuit for the magnetic Hamiltonian given in @eq:magn_rep and depicted in @fig:periodic_magnetic_circuit is designed with similar arguments.

// [figvision-cn] imgs/periodic_magnetic_circuit.png
// 该图是一张量子变分电路示意图，包含三个并排的垂直子电路
// （从左至右依次为蓝色、黄色、绿色），每个子电路均由五条
// 平行竖线构成，代表一个五能级量子系统（ququint）的量子
// 线。右侧标注“5”的灰色背景区域对应五能级截断，“3”的灰色
// 背景区域对应三能级截断（qutrit）。每个子电路顶部均有一
// 个标有“|ψ⟩”的矩形，表示初态。子电路最下方为五边形测量
// 符号，内部标有“5”。三列量子线之间用虚线框分隔。量子线
// 底部从左到右分别标有能级“|−2⟩”、“|−1⟩”、“|0⟩”、“|1⟩”、
// “|2⟩”。各子电路的横向操作门由矩形框表示，内部文字标注
// 旋转门及其角度。每个子电路中，所有量子线在顶部 |ψ⟩ 之
// 后均先经过一个两比特门 RZ(π/2)。之后，各列在五条量子线
// 上执行角度为 ±θ6、θ5、θ4、θ3、θ2、θ1 的受控旋转门，具
// 体连接方式由从门框引出的水平控制线及实心圆点（控制位）
// 表示。 左侧蓝色子电路：RZ(π/2) 门之后，在五条量子线上
// 分别执行角度为 −θ6 和 θ6 的旋转门；接着在下方对五条线
// 依次施加 θ5、θ5；继续向下，从最右侧量子线开始，依次以
// 最右侧量子线为控制位，分别控制施加 θ3 到相邻左侧线，以
// 及更多层叠的受控 θ3 门（控制线向左延伸，终点为实心圆点），
// 总计五个受控 θ3 门。之后，对五条线施加 θ2、θ2，最后对
// 底部三条线依次施加 θ1、θ1。 中间黄色子电路：RZ(π/2) 之
// 后，对五条线分别施加 −θ4、θ4、−θ4、θ4 层叠门。随后，从
// 最右侧量子线开始，依次以最右侧和/或相邻线为控制位，施
// 加五个受控 −θ3 门，再施加四个受控 θ3 门（控制线和实心
// 圆点位置交替排列）。最下方未见 θ2 和 θ1 门。 右侧绿色
// 子电路：RZ(π/2) 之后，对五条线施加 −θ6、θ6；接着对五条
// 线施加 −θ5、θ5；随后施加 θ2、θ2；最后对底部三条线施加
// θ1、θ1。 图中所有门框文字均使用数学符号，例如“RZ(π/2)”、
// “−θ6”、“θ6”、“θ5”、“−θ4”、“θ4”、“−θ3”、“θ3”、“θ2”、“θ1
// ”。所有受控门的水平控制线均以实心圆点表示控制位，受控
// 门框位于目标线上。子图未给出坐标轴数值、曲线、色标或比
// 例尺，纯为电路布局与门顺序示意图。该图传达的趋势是：三
// 能级截断（qutrit）的子电路对应于只保留最下方三条量子线
// 及其门操作（蓝色和绿色列中的底部三个门），而五能级截断
// （ququint）则使用全部五条量子线及其上所有门操作（黄色
// 列包含全部五线的中间层门，三列共用顶部 RZ(π/2) 和底部
// θ1/θ2 结构）。
#figure(image("imgs/periodic_magnetic_circuit.png", width: 94%),
  caption: [
    Variational circuit for the magnetic representation for the qutrit (solid lines) and the ququint (all, except box marked with qutrit) truncation. The explicit form of the gates employed is given in @sec:circuit_gates. The last gate in the circuit is defined as $hat(R)_Z ( theta ) = exp (- i theta hat(Z))$, where $hat(Z) = "diag" ( - 1 , 0 , 1 )$ for the qutrit, and $hat(Z) = "diag" ( - 2 , - 1 , 0 , 1 , 2 )$ for the ququint truncation.
  ]
)
<fig:periodic_magnetic_circuit>

= EXPERIMENTAL DETAILS
<sec:more_experimental_details>

== Optimal Encoding and Cross-Talk Suppression
<optimal-encoding-and-cross-talk-suppression>
Employing embedded C-ROTs requires careful treatment of the frequency spectrum and the structure of the quantum circuit to optimize the encoding of qudits in trapped ions. From the pure gauge variational ququint circuit shown in~#ref(<fig:2>)c, it is evident that only few states participate in the C-ROTs, namely the states $| plus.minus 2 chevron.r$ of control ququint and $| 0 chevron.r$, $| plus.minus 1 chevron.r$ of the two target qudits. Optimal encoding yields the strongest coupling of the qudit states with the auxiliary ground state $| g chevron.r$ on the blue sideband while simultaneously minimizing accumulating phase errors as a consequence of imperfect AC Stark shift compensation. The latter is achieved by restricting transitions, which lead to large Stark shifts, to static angles of $plus.minus pi$, making the shift constant and easier to compensate. @fig:exp_optimal_encoding shows the chosen encodings for control and target qudits for the ququint circuit shown in~#ref(<fig:2>)c for the electric representation. The states with the largest coupling to $| g chevron.r$ are highlighted in blue. Note, that in the magnetic representation, a different encoding is chosen.

// [figvision-cn] imgs/fig_methods_quint_encoding.png
// 本图由两个并排的矩形子图组成，左图左上角标注“control”，
// 右图左上角标注“targets”。两图均为能级示意图，展示纯规
// 范 ququint 电路中控制量子位与目标量子位的能级选择及耦
// 合路径。能级用水平短线段表示，每个能级带有黑色主标签和
// 其下方灰色的辅助标签（形如分数，代表磁量子数或超精细能
// 级）。蓝色双向箭头表示允许的跃迁。 子图 a（左，control）：
// 能级由下至上排列。最下方为基态 |g⟩，其下灰色标注 −1/2。
// 向上第二能级为 |−1⟩，下灰色标注 −5/2。第三能级为 |0⟩，
// 下灰色标注 −3/2。第四能级为 |+2⟩，下灰色标注 −1/2。第
// 五能级为 |−2⟩，下灰色标注 +1/2。最上方能级为 |+1⟩，下
// 灰色标注 +3/2。此外，在 |g⟩ 右上方、第四能级下方、以及
// 最上方能级右侧各有一个淡灰色能级，分别标注 +1/2、+1/2、
// +5/2（灰色能级为旁观能级，不参与跃迁）。蓝色箭头从 |g⟩
// 出发，分别连接至 |+2⟩ 和 |−2⟩，表示控制量子位的编码选
// 择使得 C-ROT 相关态对蓝边带具有最强耦合。 子图 b（右，
// targets）： 能级排列与左图类似但量子数不同。最下方为 |
// g⟩，下灰色标注 −1/2。向上第二能级为 |−2⟩，下灰色标注 −
// 5/2。第三能级为 |0⟩，下灰色标注 −3/2。第四能级为 |−1⟩，
// 下灰色标注 −1/2。第五能级为 |+1⟩，下灰色标注 +1/2。最
// 上方能级为 |+2⟩，下灰色标注 +3/2。同样存在三个淡灰色旁
// 观能级，分别标注 +1/2、+1/2、+5/2。蓝色箭头从 |g⟩ 出发，
// 分别连接至 |0⟩、|−1⟩ 和 |+1⟩，表示目标量子位的三个耦合
// 跃迁路径。 两图共同传达：通过选择特定的能级编码（控制
// 位使用 |g⟩↔|+2⟩ 与 |g⟩↔|−2⟩，目标位使用 |g⟩↔|0⟩、|g⟩↔|
// −1⟩、|g⟩↔|+1⟩），使相关态对蓝边带耦合最强，同时仅允许
// 在这些跃迁上旋转，以最小化对旁观能级的斯塔克频移，从而
// 减小相位误差。
#figure(image("imgs/fig_methods_quint_encoding.png", width: 100%),
  caption: [
    Optimal encodings of control and target qudits in the $D_{5/2}$ manifold of $""^40 upright("Ca")^(+)$ applied for the pure gauge ququint circuit in~#ref(<fig:2>)c -- the encoding is chosen such that relevant states for the C-ROTs have the strongest coupling to the blue sideband. We seek to minimize phase errors by allowing only $pi$ rotations on all transitions, which induce large Stark shifts on the spectator levels.
  ]
)
<fig:exp_optimal_encoding>

The pure-gauge qutrit circuit can be constructed in such a way that spatially neighboring ions store the qutrit in different sets of Zeeman levels, with each set separated by frequencies of a few $upright("MHz")$. Assigning integers to each ions in the string from left to right, ions with even indices encode the qutrit in Zeeman states with positive magnetic quantum numbers $|-1' chevron.r = D_{+1/2}$, $|0' chevron.r = D_{+3/2}$ and $|+1' chevron.r = D_{+5/2}$, coupled via the second ground state $|g' chevron.r = S_{+1/2}$ as shown in @fig:exp_qutrit_even_odd. With this spectroscopic decoupling scheme, next-neighbor cross-talk is effectively eliminated~@Meth2022 and higher axial trap frequencies can be used. However, spectroscopic decoupling is not possible for ququints, as no bi-partition of the $D_{5/2}$ manifold exists in $""^40 upright("Ca")^(+)$ for qudits of dimension $d > 3$\; here one would require different ion species or isotopes to apply this scheme.

// [figvision-cn] imgs/fig_methods_qutrit_decoupling.png
// 这是一幅由量子态能级标注构成的示意图，不含坐标轴、曲线
// 或色标，用于说明相邻离子采用不同三联态（qutrit）编码以
// 抑制串扰的方案。图像由左侧能级标签区、中间两个椭圆分组
// 区和右下方的离子链示意区组成。 左侧能量标注区表示两类
// 离子的基态。第一类离子的基态记为竖线g，括号内为g，右上
// 方标注+1/2，右下方标注−1/2。其上方为三个编码态：竖线−1，
// 右上方标注−3/2，右下方标注−5/2；竖线0，右上方标注−1/2；
// 竖线+1，右上方标注+1/2。这三个态被一个淡蓝色椭圆包围并
// 分组。第二类离子的基态记为竖线g′，右上方标注+1/2，右下
// 方标注−1/2。其上方为三个编码态：竖线−1′，右上方标注+1/
// 2；竖线0′，右上方标注+3/2；竖线+1′，右上方标注+5/2。这
// 三个态被一个淡粉色椭圆包围并分组。每个态均采用分数形式：
// 分子为带竖线的量子态符号，分母为对应的磁量子数，表示塞
// 曼子能级。 两个椭圆沿右上方向错开排列，粉色组整体高于
// 蓝色组，表明两类离子各自的三联态集合在塞曼子能级上相对
// 偏移约几个单位。该偏移设计使两个集合的能量间隔不同，从
// 而降低相邻离子间的串扰。 右下方为一条向下弯曲的黑色弧
// 线，示意一维离子链的轴向势阱。弧线上方沿曲线自左向右排
// 列四个黑色圆圈，前三个圆圈内部标注数字3，第四个圆圈前
// 有省略号“⋯”，表示离子链可延续。每个黑色圆圈代表一个被
// 囚禁的离子，圈内数字3表示该离子编码为三联态。所有圆圈
// 大小一致，沿弧线等间距排列。 该图传达的结论是：空间相
// 邻的离子通过将三联态编码在相隔几个塞曼子能级的不同态集
// 合中（蓝色与粉色两组），可有效抑制最近邻串扰；这种编码
// 方式允许采用更高的轴向囚禁频率，从而减小离子间距。
#figure(image("imgs/fig_methods_qutrit_decoupling.png", width: 100%),
  caption: [
    Next-neighbor cross-talk suppression in qutrits by proper choice of encoding -- spatially neighboring ions encode the qutrit in different sets of Zeeman states with each set separated by a few $upright("MHz")$. This encoding pattern is well suited to suppress cross-talk~@Meth2022, allowing higher axial trap frequencies, reducing the inter-ion distance.
  ]
)
<fig:exp_qutrit_even_odd>

A second approach to reduce next-neighbor cross-talk is to increase the spatial separation between ions encoding the qudits. This can be achieved in two ways, either lowering the axial confinement by reducing the end-cap voltage of the ion trap or by introducing additional #emph[buffer] ions, which are transferred to a #emph[hidden] state which does not couple with the laser pulses driving the actual quantum circuit. The former strategy is less suited for our specific circuits due to significant #emph[crowding] of the mode spectrum, making it difficult to faithfully implement the C-ROT operations. Thus, for the $d = 5$ pure gauge circuit as well as the gauge-matter circuit we chose the second method and introduced a pair of extra ions - in the pure gauge circuits, these buffers are located between each qudit, while the open plaquette circuit requires a buffer between each of the matter qubits, while we order the ion string in such a way that the gauge field qudit is physically located in the center of the string as shown in @fig:exp_buffer_ions. This re-ordering ensures optimal performance of the Mølmer-Sørensen gates on the matter qubits at the very end of the circuit.

// [figvision-cn] imgs/fig_methods_buffer_ions.png
// 该图由左右两个并排的示意图子图组成，未标注子图字母。两
// 图均为离子串排列示意图，展示通过引入缓冲离子增大 qudit
// 间距的策略。 左图：一条水平排列的离子串，从左至右由灰
// 色箭头指示方向。串中包含三个有色圆形离子（qudit）与两
// 个无色半透明圆形离子（缓冲离子）交替排列。具体顺序为：
// 浅蓝色圆（内部标注数字 5）、灰色半透明圆、金黄色圆（标
// 注 5）、灰色半透明圆、浅绿色圆（标注 5）。每个有色圆底
// 部带有一个小钩状符号，灰色圆无此符号。箭头位于串两端，
// 指向内侧。该图对应 pure gauge system 的排列，缓冲离子
// 不参与电路且不与控制光场耦合，仅用于增大 qudit 间距。
// 右图：同样为水平离子串，顺序为：浅蓝色圆（标注 2）、灰
// 色半透明圆、浅蓝色圆（标注 2）、浅红色圆（标注 3）、浅
// 蓝色圆（标注 2）、灰色半透明圆、浅蓝色圆（标注 2）。每
// 个有色圆底部同样带小钩状符号。灰色缓冲离子将部分 qudit
// 隔开，且 qudit 在串中的顺序经过重排以提升性能，对应
// dynamical matter 电路的情形。 两图共同传达：在离子串中
// 插入不参与计算的缓冲离子，可人为增大 qudit 间距离，同
// 时通过重排 qudit 顺序优化动态物质电路的表现。图中未出
// 现坐标轴、色标、比例尺或定量数值。
#figure(image("imgs/fig_methods_buffer_ions.png", width: 100%),
  caption: [
    Artificially increasing the inter-qudit distance by introducing #emph[buffer] ions. Buffer ions do not contribute to the circuit and do not couple with the light fields used to control the qudits. This strategy is employed for the $d = 5$ pure gauge system, as well as for the circuits describing dynamical matter. For the latter case, we also chose to re-order the qudits inside the ion string to enhance the performance of the Mølmer-Sørensen entangling gates on the qubits.
  ]
)
<fig:exp_buffer_ions>

Additionally to the two approaches presented in this section, we also employ composite rotations @Meth2022 when transferring the buffer ions to their hidden state.

== Gate Count Optimization
<gate-count-optimization>
The structure of the quantum circuits enables us to implement shortcuts, reducing the number of entangling gates; these shortcuts are best explained by the circuit in~#ref(<fig:1>)d. First, if the input state of one of the qudits is known, the number of interactions with the phonon mode $B ( theta , phi.alt )$ can be reduced to $n_(upright("B") thin upright("(") thin upright("theta") thin upright(",") phi.alt upright(")")) = 2$ compared to the general case of a C-ROT being composed of $n_(B ( theta , phi.alt )) = 5$ BSB pulses. This strategy is applied to the matter #emph[qubits] in the gauge-matter-circuit for the angles $theta_1$, $theta_2$ and $theta_7$, where the state of the #emph['left'] qubit entering each operation is exactly known. Second, if two C-ROTs are executed successively on the same control state as it would be for the pairs $( theta_3 , theta_4 )$ and $( theta_5 , theta_6 )$ in~#ref(<fig:1>)d, two successive $B ( theta , phi.alt )$ cancel out as it can be imagined by extending the sequence in @fig:exp_crot_sequence by a second C-ROT. Third, we implement the SWAP operations with angles $theta_7$, $theta_8$ and $theta_9$ by sequences of three Mølmer-Sørensen (MS) gates~@sorensen1999quantum and local single-qubit rotations, which, in this case, is more favorable than the blue-sideband approach in terms of gate count.

== Measurement and Readout of Qudits
<measurement-and-readout-of-qudits>
Measurements on a qudit with dimension $d$ are implemented by a series of single-qudit operations followed by a sequence of $d - 1$ detection events and local $pi$ rotations. Our optimal encoding of the qudits requires an additional reordering of the quantum states to match a $W$-pattern as shown in @fig:exp_measurement_scheme. In this arrangement any state $| i chevron.r$ directly couples with $| i plus.minus 1 chevron.r$, which enables a straightforward QR-decomposition-based compilation of the measurement operator into a sequence of single qudit rotations~@Ringbauer2022A-universal.

// [figvision-cn] imgs/fig_methods_detection_scheme.png
// 本图由上下两个子图组成，分别为子图a（能级与脉冲序列示
// 意图）和子图b（量子态重排示意图）。 子图a为量子操作时
// 序示意图，包含能级、量子态编码、脉冲序列与操作阶段标注。
// 图左侧展示能级结构：上方为D5/2能级，下方为S1/2能级。D5
// /2能级分裂为六个能级，分别为|+1⟩、|−2⟩、|+2⟩、|0⟩、|−1
// ⟩以及一个未标注的辅助能级。S1/2能级分裂为两个能级，分
// 别为|+1/2⟩和|−1/2⟩。图中标注了从D5/2能级各态到S1/2能级
// 的失谐量，从上至下依次为+5/2、+3/2、+1/2、−1/2、−3/2、
// −5/2。图中央从D5/2的五个能级（|+1⟩、|−2⟩、|+2⟩、|0⟩、|
// −1⟩）引出五条水平线，表示量子比特的五个能级，最低的一
// 条为|−1⟩。这五条水平线从左向右延伸，穿越不同操作阶段。
// 操作阶段自左向右依次标注为“reorder”、“measure”、“hide”、
// “readout”。在“reorder”阶段，有三组脉冲：第一组为两个π
// 脉冲，分别作用于|+2⟩和|0⟩对应的水平线；第二组为一个π脉
// 冲，作用于|−1⟩对应的水平线；第三组为一个π脉冲，作用于
// 最高能级|+1⟩对应的水平线。在“measure”阶段，有一个绿色
// 矩形脉冲，标注为U，同时作用于五条水平线，表示量子态之
// 间的耦合操作。在“hide”阶段，有一个π脉冲，作用于中间的
// 三条水平线（|−2⟩、|+2⟩、|0⟩）。在“readout”阶段，从|−1⟩
// 水平线开始，依次有八个π脉冲，分别作用于不同水平线，脉
// 冲之间用波浪线连接，表示读出序列。整体趋势为：量子比特
// 最初编码在类似的量子态流形中（左），通过一系列π脉冲进
// 行重排（reorder），使量子态排列成字母W的形状（右），在
// “measure”阶段通过绿色U操作实现测量，随后在“hide”阶段隐
// 藏于流形中，最后执行读出序列。 子图b为重排后的量子态排
// 列示意图，展示重排后的能级分布。左侧为一组能级，从上至
// 下依次为|+1⟩、|−2⟩、|+2⟩、|0⟩、|−1⟩，能级间距不等。右
// 侧为另一组能级，呈不规则排列：顶部水平线标注|+2⟩，下方
// 左侧为|−2⟩，下方中部为|0⟩，下方右侧为|+1⟩，底部最下方
// 为|−1⟩。图中用红色双向箭头连接不同的量子态：|−2⟩与|+2⟩
// 之间有双向箭头，|−2⟩与|+1⟩之间有双向箭头，|0⟩与|+2⟩之
// 间有双向箭头，|0⟩与|+1⟩之间有双向箭头，|−1⟩与|+1⟩之间
// 有双向箭头。这些箭头表示量子态之间的耦合关系。整体趋势
// 为：通过重排操作，量子态被重新排列成字母W的形状，并形
// 成特定的耦合关系，以忠实地实现测量操作。
#figure(image("imgs/fig_methods_detection_scheme.png", width: 100%),
  caption: [
    Measurement and readout of ququints -- the ququint is initially encoded in the $D_{5/2}$ manifold of $""^40 upright("Ca")^(+)$ similar to @fig:exp_optimal_encoding (left). It is then reordered by a sequence of $pi$-pulses, such that the states are arranged in the shape of the letter W (right). The coupling between states $| i plus.minus 1 chevron.r arrow.l.r | i chevron.r$ is required to faithfully implement the measurement operation $U$ in green. After hiding $| + 1 chevron.r$ in the $D_{5/2}$ manifold, the readout sequence is executed as a series of detection and re-cooling & optical pumping pulses indicated by blue arrows. Additional $pi$-pulses rotate the desired state to the ground state manifold, such that photons can be scattered on the short-lived $S_{1/2}arrow.l.r P_{1/2}$ transition (see @fig:exp_ca40_scheme).
  ]
)
<fig:exp_measurement_scheme>

After the measurement operation has been applied, the readout is implemented by a sequence of $d - 2$ local $pi$-flips and $d - 1$ detection events. Each event is composed of a $1 med upright("ms")$ window, during which the fluorescence of each ion is recorded on a sensitive EMCCD camera, followed by $2 med upright("ms")$ of Doppler cooling and $0.5 med upright("ms")$ of polarization gradient cooling; this re-cooling pattern is not required after the last detection. We mention, that the duration of the readout in our experiment scales as $approx ( d - 2 ) dot.op 3.5 med upright("ms") + 1 med upright("ms")$ for any qudit dimension $d$ -- this is on the order of the duration of the ground state cooling sequence at the beginning of each experiment run.

= NOISE MODEL
<sec:noise_model>
While systems consisting of qubits only can often be accurately described by generic noise models such as simple depolarising noise, we found that for our qudit systems this is too reductive. Therefore, we construct a more realistic noise model based on the physics of how the gates of our circuits are realized. In particular, our heuristic model includes imperfect precision in the variational parameters and dephasing of the prepared quantum state. We find good agreement between the experimental results and the simulated data.

#strong[Amplitude Fluctuations.] We expect that the precision in the gate angles we aim to apply throughout the experiment suffers from fluctuations of the addressing laser amplitude. A gate $hat(U) ( theta )$ is hence replaced by $hat(U) ( theta + delta theta )$, where $delta theta$ is a stochastic variable extracted from a Gaussian $cal(N) ( 0 , sigma_(upright("a"))^2 )$ with mean $mu = 0$ and variance $sigma_(upright("a"))^2$. Given the higher fidelity with which single qudit gates can be realized compared to entangling gates, we use in our model a variance $sigma_(upright("a"))^2$ for parametrized entangling gate, and a variance $sigma_(upright("a"))^2 / 10$ for single qudit gates.

#strong[Phase Errors.] In trapped ion systems, while single qudit operations can be carried out with a fidelity close to unity, two-qudit entangling gates and controlled excitation of the ions' motion are the dominant sources of errors. C-ROT operations in qudits introduce phase noise due to AC Stark shifts of different magnitude (see Methods~@sec:experimetal_details): (1) exciting the motion on a chosen control state $| i chevron.r$ introduces a (small) phase error $phi.alt_i$ on that state due to imperfect compensation and (2) spectator states that are not involved in the interaction ($| j chevron.r$, with $j eq.not i$) accumulate a phase $Phi_j$ due to imperfect compensation of AC stark shifts. Each C-ROT is a composition of single qudit operations as shown in #ref(<fig:exp_crot_sequence>)---for any blue sideband operation exciting the motion via the state $| i chevron.r$, we identify the mapping $c_i | i chevron.r + sum_(j eq.not i) c_j | j chevron.r mapsto e^(i phi.alt_i) c_i | i chevron.r + sum_(j eq.not i) e^(i Phi_j) c_j | j chevron.r$. As can be deduced by counting how many times each level in @fig:exp_crot_sequence is involved in a sideband pulse, the control qudit is mapped to the state in @eq:app_phase_errors_control, while the target acquires phases according to @eq:app_phase_errors_target.

$ c_i | i chevron.r + sum_(j eq.not i) c_j | j chevron.r mapsto e^(i 2 phi.alt_i) c_i | i chevron.r + sum_(j eq.not i) e^(i 2 Phi_j) c_j | j chevron.r , $<eq:app_phase_errors_control>

$  & c_i | i chevron.r + c_j | j chevron.r + sum_(k eq.not i , j) c_k | k chevron.r mapsto\
 & e^(i ( 2 phi.alt_i + Phi_i )) c_i | i chevron.r + e^(i ( 2 Phi_j + phi.alt_j )) c_j | j chevron.r + sum_(k eq.not i , j) c_k e^(i 3 Phi_k) | k chevron.r . $<eq:app_phase_errors_target>

The second-beam technique~@haffner2008quantum applied to cancel the AC Stark shift on the #emph[actively] driven transition $| g chevron.r arrow.l.r | i chevron.r$ is robust to intensity noise, as both beams are affected equally by fluctuations. Thus, the phase error $phi.alt_i$ is considered to be small compared to $Phi_j$ and can be neglected for simplicity. Furthermore, we make the simplifying assumption that the passively (in software) compensated spectator shifts yield the same phase error for all levels $Phi_j mapsto Phi$, and thus the mappings simplify to @eq:app_phase_errors_control_phi and @eq:app_phase_errors_target_phi.

$ c_i | i chevron.r + sum_(j eq.not i) c_j | j chevron.r mapsto c_i | i chevron.r + e^(i 2 Phi) sum_(j eq.not i) c_j | j chevron.r , $<eq:app_phase_errors_control_phi>

$  & c_i | i chevron.r + c_j | j chevron.r + sum_(k eq.not i , j) c_k | k chevron.r mapsto\
 & e^(i Phi) c_i | i chevron.r + e^(i 2 Phi) c_j | j chevron.r + e^(i 3 Phi) sum_(k eq.not i , j) c_k | k chevron.r . $<eq:app_phase_errors_target_phi>

Consecutive C-ROTs controlled by the same qudit and same state (see for example circuit in~#ref(<fig:1>)d) can be contracted, reducing the number of blue sideband pulses. In this specific case, the pattern on the target #emph[qutrit] is then given by

$ sum_(j in ( - 1 , 0 , + 1 )) c_j | j chevron.r mapsto e^(i 3 Phi) c_(- 1) | - 1 chevron.r + e^(i 2 Phi) c_0 | 0 chevron.r + e^(i 3 Phi) c_(+ 1) | + 1 chevron.r , $

while the control qudit acquires $e^(i Phi)$ on all spectator levels.

We model the phase error $Phi$ with a Gaussian distribution $cal(N) ( 0 , sigma_(upright("p"))^2 )$ with mean $mu = 0$ and variance $sigma_(upright("p"))^2$.

#strong[Results.] In @fig:simulated_noise we compare the experimental VQE results with simulated data for the open plaquette (first row) and for the pure gauge theory (second and third row). In the latter case the blue (orange) markers correspond to the electric (magnetic) representation. For the simulation, we consider variational parameters obtained without noise, and we calculate the expectation values of the relevant observables when the variational circuit is affected by the noise with parameters estimated as $sigma_(upright("a"))^2 = 0.0 .047$, $sigma_(upright("p"))^2 = 0.073$. We can see good qualitative agreement between the experimental and the simulated data.

// [figvision-cn] imgs/simulated_noise.png
// 该图由三行两列共六个子图组成，按行分为三个物理模型，按
// 列分为能量和 plaquette 期望值。所有子图的横轴均为 \(g^
// {-2}\)，采用对数刻度，范围从 \(10^{-2}\) 到 \(10^{2}\)。
// 第一行对应“QED with matter”模型。 子图 (a)（左上）是能
// 量随 \(g^{-2}\) 变化的曲线图，纵轴 Energy 范围约 \(-90
// \) 到 \(10\)。图例标明黑色菱形带误差棒为 Experiment，
// 黑色空心方块为 Noise model，灰色实线为 ED。数据点从 \(
// g^{-2}=10^{-2}\) 处约 \(0\) 开始，随 \(g^{-2}\) 增大缓
// 慢下降，在 \(10^{2}\) 处骤降至约 \(-70\) 至 \(-80\)。
// 灰色 ED 曲线与噪声模型方块高度吻合。 子图 (b)（右上）
// 是 plaquette 期望值随 \(g^{-2}\) 变化的曲线图，纵轴 \(
// \langle \Box \rangle\) 范围约 \(-0.2\) 到 \(0.7\)。符
// 号含义同 (a)。数据从 \(g^{-2}=10^{-2}\) 处约 \(0\) 开
// 始，在 \(g^{-2}\) 从 \(10^{-1}\) 到 \(10^{0}\) 区间迅
// 速上升至约 \(0.6\)，随后趋于平缓。灰色 ED 曲线呈 S 型，
// 与实验点和噪声模型点一致。 第二行对应“Pure gauge QED (
// qutrit)”模型。 子图 (c)（左中）是能量曲线图，纵轴
// Energy 范围约 \(-1100\) 到 \(100\)。图例显示蓝色和橙色
// 分别代表两组不同的参数或截断。蓝色菱形/方块/实线在 \(g
// ^{-2}\) 较小时接近 \(0\)，在 \(10^{2}\) 处降至约 \(
// -200\)；橙色菱形/方块/实线在 \(g^{-2}=10^{-2}\) 处约 \
// (-900\) 至 \(-1000\)，随 \(g^{-2}\) 增大迅速上升至接近
// \(0\)，在 \(10^{2}\) 处降至约 \(-400\)。ED 实线与噪声
// 模型方块吻合良好。 子图 (d)（右中）是 plaquette 期望值
// 曲线图，纵轴 \(\langle \Box \rangle\) 范围约 \(-0.1\)
// 到 \(1.0\)。蓝色数据点在 \(g^{-2}\) 较小时接近 \(0\)，
// 在 \(10^{0}\) 附近上升至约 \(0.6\) 并保持；橙色数据点
// 在 \(g^{-2}=10^{-2}\) 处约 \(0.6\)，在 \(10^{0}\) 附近
// 上升至约 \(1.0\) 并保持。ED 实线呈阶梯状上升，与噪声模
// 型方块一致。 第三行对应“Pure gauge QED (ququint)”模型。
// 子图 (e)（左下）是能量曲线图，纵轴 Energy 范围约 \(
// -2200\) 到 \(200\)。蓝色数据点在 \(g^{-2}\) 较小时接近
// \(0\)，在 \(10^{2}\) 处降至约 \(-300\)；橙色数据点在 \
// (g^{-2}=10^{-2}\) 处约 \(-2000\)，随 \(g^{-2}\) 增大迅
// 速上升至接近 \(0\)，在 \(10^{2}\) 处降至约 \(-400\)。
// ED 实线与噪声模型方块吻合。 子图 (f)（右下）是
// plaquette 期望值曲线图，纵轴 \(\langle \Box \rangle\)
// 范围约 \(-0.1\) 到 \(1.0\)。蓝色数据点在 \(g^{-2}\) 较
// 小时接近 \(0\)，在 \(10^{0}\) 附近上升至约 \(0.8\) 并
// 保持；橙色数据点在 \(g^{-2}=10^{-2}\) 处约 \(0.6\)，在
// \(10^{0}\) 附近上升至约 \(1.0\) 并保持。ED 实线呈阶梯
// 状上升，与噪声模型方块一致。 整体趋势表明，噪声模型（
// 空心方块）与实验数据（带误差棒的菱形）以及精确对角化（
// ED，实线）在三个模型中均表现出良好的一致性，验证了噪声
// 模型的有效性。
#figure(image("imgs/simulated_noise.png", width: 100%),
  caption: [
    #strong[Simulated noise model for the experiment.] Energy (first column) and plaquette expectation value (second column) for the two models studied via experimental VQE, namely 2D-QED with matter (first row), and an instance of pure gauge 2D-QED (second and third row, corresponding to qutrit and ququint truncations respectively). For the pure gauge model, blue (orange) lines and markers correspond to the simulations performed with the electric (magnetic) representation. After obtaining variational parameters in the absence of noise, the simulated noisy data (squares) is obtained via the noise model detailed in the text, which includes amplitude fluctuations and phase errors. The results from experimental quantum computations (dots) show good agreement with the simulated noisy data.
  ]
)
<fig:simulated_noise>

= RESULTS FOR ALTERNATIVE LATTICE QED MODEL
<sec:model_cm>

In this work, we consider compact lattice QED (cQED) with staggered fermions~@kogut1975hamiltonian. There are two different models that are both referred to as cQED and that are both currently discussed in the recent literature.

The main text of this paper focuses on the first of these two models. As explained in Methods~@sec:Methods_Hamiltonian, this model is obtained by discretising space in two-dimensional QED~@crippa_towards_2024 @wiese2013ultracold. In this section, we focus on the second version of cQED. This model has been studied in the literature on quantum simulations of lattice gauge theories~@zohar_digital_2017 @Magnifico_2021 @paulson_simulating_2021 @Clemente2022, especially in condensed matter physics~@bender_variational_2023 @affleck_large-n_1988 @rantner_electron_2001. Both models respect a local U(1) gauge symmetry, but the kinetic parts of the Hamiltonian have different phases, which leads to different theories in the continuum limit.

The Hamiltonian in the second case is given by~@zohar_digital_2017

$  $<eq:Hamiltonian_terms_cm>

$ hat(H)_E & = 1 / 2 sum_(upright(bold(n))) (hat(E)_(upright(bold(n)) , upright(bold(e))_x)^2 + hat(E)_(upright(bold(n)) , upright(bold(e))_y)^2) ,\
hat(H)_B & = - 1 / 2 sum_(upright(bold(n))) (hat(P)_(upright(bold(n))) + hat(P)_(upright(bold(n)))^dagger) ,\
hat(H)_m & = sum_(upright(bold(n))) ( - 1 )^(n_x + n_y) hat(phi.alt)_(upright(bold(n)))^dagger hat(phi.alt)_(upright(bold(n))) ,\
hat(H)_k & = sum_(upright(bold(n))) sum_(mu = x , y) (hat(phi.alt)_(upright(bold(n))) hat(U)_(upright(bold(n)) , upright(bold(e))_mu)^dagger hat(phi.alt)_(upright(bold(n)) + upright(bold(e))_mu)^dagger + upright("H") thin upright(".") thin upright("c") thin upright(".")) . $

Since the two models only differ by sign choice in the kinetic term (compare #ref(<eq:openplaq_qubit>)d), they coincide for a pure gauge theory, as considered in @sec:periodic of the main text. After eliminating the gauge fields as shown in Ref.~@paulson_simulating_2021 and applying the Jordan-Wigner transformation given in @eq:JW_transformation the resulting qubit Hamiltonian is given by:

$  $<eq:openplaq_qubit_cm>

$ hat(H)_E & = 1 / 4 ( 8 hat(E) + 2 hat(E) (- hat(sigma)_1^z - 2 hat(sigma)_2^z + 3 hat(sigma)_3^z + 2)\
 & #h(2em) quad - hat(sigma)_2^z + hat(sigma)_3^z + hat(sigma)_1^z hat(sigma)_2^z + 3 ) ,\
hat(H)_B & = - 1 / 2 (hat(U) + hat(U)^dagger) ,\
hat(H)_m & = 1 / 2 (hat(sigma)_1^z - hat(sigma)_2^z + hat(sigma)_3^z - hat(sigma)_4^z) ,\
hat(H)_k & = hat(sigma)_1^(+) hat(sigma)_2^(-) + hat(sigma)_2^(+) hat(U)^dagger hat(sigma)_3^(-) + hat(sigma)_4^(+) hat(sigma)_3^(-) - hat(sigma)_1^(+) hat(sigma)_4^(-) + upright("H.c.") , $

We studied this model experimentally using the same VQE circuit structure as in #ref(<fig:1>)d (see Ref.~@paulson_simulating_2021). The gates that entangle the qubits and the qudit are still controlled on the qubits adjacent to the dynamical gauge field, which in this case are qubits ii and iii, as shown in the inset of @fig:open_plaquette_cm. The experimentally measured plaquette expectation values in the ground state found via VQE as a function of $g^(- 2)$ are displayed in @fig:open_plaquette_cm for $Omega = 5$ and $m = 0.1$, and show good agreement with the theoretical prediction.

In the large coupling regime ($g^(- 2) lt.double 1$) the electric field energy term $hat(H)_E$ dominates the Hamiltonian of @eq:openplaq_qubit_cm, favoring the ground state $| v v v v , 0 chevron.r$ with $chevron.l hat(square.stroked.tiny) chevron.r = 0$. In the weak coupling regime, on the other hand, the magnetic field energy term $hat(H)_B$ dominates the Hamiltonian, favoring a positive vacuum plaquette expectation value ($chevron.l hat(square.stroked.tiny) chevron.r = 1 / sqrt(2) approx 0.707$ for the chosen truncation). In the intermediate regime where $g^(- 2) approx 1$, we encounter a competition between the two field-energy terms and $hat(H)_k$. The presence of the kinetic term $hat(H)_k$ makes it energetically favorable to create pairs, which in turn produce a background magnetic flux that opposes the flux present in the ground state preferred by the term $hat(H)_B$. On its own, the term $hat(H)_k$ leads to a ground state with a negative plaquette expectation value ($chevron.l hat(square.stroked.tiny) chevron.r approx - 0.642$ in the considered case). The presence of dynamical matter, therefore, results in a reduction of the plaquette expectation value in the ground state, as shown in @fig:open_plaquette_cm. Notably, even with our small system size we already clearly observe the dip in the plaquette expectation value that originates from pair creation processes in the ground state, see Ref.~@paulson_simulating_2021 for details.

// [figvision-cn] imgs/cm_phase_exp_results.png
// 这是一张单幅科学曲线图，没有标注子图编号。图的纵轴标签
// 为“□”（方框符号），表示方框（plaquette）期望值，刻度范
// 围从约−0.45到0.7，主要刻度为−0.4、−0.2、0.0、0.2、0.4、
// 0.6；横轴标签为“g⁻²”，采用对数坐标，标注的刻度为10⁻¹、
// 10⁰、10¹、10²，数据点从左端约3×10⁻²延伸到右端约2×10²，
// 整个横轴范围约为10⁻²到3×10²。图例位于右下角，包含三项：
// 黑色向上三角形标记“Experiment”（实验）、灰色实心方块标
// 记“Noise model”（噪声模型）、浅灰色实线“Exact”（精确值）。
// 精确值曲线从g⁻²≈3×10⁻²处约0.0开始，随g⁻²增大缓慢下降，
// 在g⁻²≈0.4处降至最低点约−0.38，随后迅速上升，在g⁻²≈2处
// 过零，在g⁻²≈5到10之间出现近垂直的阶跃上升，g⁻²>10后趋
// 于平缓，在g⁻²≈10²处渐近于约0.7。实验数据（黑色三角形，
// 带垂直误差棒）在低g⁻²区（约5×10⁻²至2×10⁻¹）分布在−0.25
// 到0.15之间，与精确曲线在0.05至0.2区间存在明显偏离（最
// 左端约0.15，其次约−0.05、0.0、−0.2）；在g⁻²≈0.7至1.2区
// 间集中在约−0.2至−0.3，与精确曲线谷底附近接近；在g⁻²≈2
// 至5区间数据点由约0.25迅速升至0.5，对应精确曲线的阶跃上
// 升段；g⁻²>10后实验点分布在0.5至0.65之间，略低于精确曲
// 线渐近值。噪声模型数据（灰色方块）在g⁻²≈0.3至1.0区间约
// 为−0.3至−0.35，在g⁻²≈2处约−0.2，在g⁻²≈5处约0.2，在g⁻²≈
// 10处约0.55，其趋势与精确曲线一致，但在阶跃区略偏低、在
// 低g⁻²区偏离较小。 图左上角有一虚线圆角矩形插图，为示意
// 图：四个蓝色圆圈分别标注罗马数字i（左上）、ii（右上）、
// iii（右下）、iv（左下），四个圆圈按正方形四角布局并用
// 灰色虚线连接成方框（plaquette）；左侧边（i与iv之间）和
// 右侧边（ii与iii之间）各有一小段红色短棒标记，红色短棒
// 与蓝色圆圈之间用细灰线连接，红色短棒位于边中部。该插图
// 示意方框上的耦合或相互作用位置，与纵轴“□”符号对应。图
// 中没有显微照片、色标或比例尺。整体传达的趋势是：实验与
// 噪声模型均能复现精确曲线由负到正的S形阶跃转变，但在低g
// ⁻²区实验值系统性偏高，在阶跃区实验点上升略早于精确曲线。
#figure(image("imgs/cm_phase_exp_results.png", width: 100%),
  caption: [
    Experimental VQE results for the plaquette expectation value for the model described in @eq:openplaq_qubit_cm.
  ]
)
<fig:open_plaquette_cm>

#bibliography("refs.bib", title: none)