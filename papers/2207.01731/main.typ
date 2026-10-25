#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.92cm, bottom: 2.40cm))
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
#set par(justify: true, spacing: 0.46em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.46em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set figure(placement: none)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)

#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#align(center)[
  #text(12pt, weight: "bold", [Preparations for Quantum Simulations of Quantum Chromodynamics in $1 + 1$ Dimensions: (I) Axial Gauge])   #v(1.2em)
  #text(10.5pt)[Roland C. Farrell\,#super[1], Ivan A. Chernyshev\,#super[1], Sarah J. M. Powell\,#super[2], Nikita A. Zemlevskiy\,#super[1], Marc Illa\,#super[1], Martin J. Savage\,#super[1]]

]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] InQubator for Quantum Simulation (IQuS), Department of Physics, University of Washington, Seattle, WA 98195, USA.] \
  #text(9pt)[#super[2] Department of Physics and Astronomy, York University, Toronto, ON M3J 1P3, Canada.] \
]
#v(1.2em)

#align(left)[#image("src/Figs/IQuSLogo.png", width: 76pt)]

// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: April 12, 2023)]]

Tools necessary for quantum simulations of $1 + 1$ dimensional quantum chromodynamics are developed. When formulated in axial gauge and with two flavors of quarks, this system requires 12 qubits per spatial site with the gauge fields included via non-local interactions. Classical computations and D-Wave's quantum annealer `Advantage` are used to determine the hadronic spectrum, enabling a decomposition of the masses and a study of quark entanglement. Color “edge” states confined within a screening length of the end of the lattice are found. IBM's 7-qubit quantum computers, `ibmq_jakarta` and `ibm_perth`, are used to compute dynamics from the trivial vacuum in one-flavor QCD with one spatial site. More generally, the Hamiltonian and quantum circuits for time evolution of $1 + 1$ dimensional $S U ( N_c )$ gauge theory with $N_f$ flavors of quarks are developed, and the resource requirements for large-scale quantum simulations are estimated.

  

= INTRODUCTION
<introduction>
Simulations of the real-time dynamics of out-of-equilibrium, finite density quantum systems is a major goal of Standard Model (SM)~@Glashow:1961tr @Higgs:1964pj @Weinberg:1967tq @Salam:1968rm @Politzer:1973fx @Gross:1973id physics research and is expected to be computed efficiently~@Lloyd1073 with ideal quantum computers~@5392446 @5391327 @Benioff1980 @Manin1980 @Feynman1982 @Fredkin1982 @Feynman1986 @doi:10.1063-1.881299 @williamsNASAconference/1.881299 @williamsNASAconference. For recent reviews, see Refs.~@Preskill:2021apy @Klco:2021lap @Bauer:2022hpo. Developing such capabilities would enable precision predictions of particle production and fragmentation in beam-beam collisions at the LHC and RHIC, of the matter-antimatter asymmetry production in the early universe, and of the structure and dynamics of dense matter in supernova and the neutrino flavor dynamics therein. They would also play a role in better understanding protons and nuclei, particularly their entanglement structures and dynamics, and in exploring exotic strong-interaction phenomena such as color transparency. First steps are being taken toward simulating quantum field theories (QFTs) using currently available, NISQ-era (Noisy Intermediate Scale Quantum) quantum devices~@Preskill2018quantumcomputingin, by studying low-dimensional and truncated many-body systems (see for example, Refs.~@Hauke:2013jga @Banuls:2013jaa @Zohar:2016iic @Muschik:2016tws @Martinez:2016yna @Buyens:2016hhu @Banuls:2016lkq @Gonzalez-Cuadra:2017lvz @Dumitrescu:2018njn @PhysRevA.98.032331 @Lu:2018pjk @Kaplan:2018vnj @Stryker:2018efp @Yeter-Aydeniz:2018mix @PhysRevD.101.074512 @Avkhadiev:2019niu @Bauer:2019qxa @Klco:2019xro @Klco:2019yrb @Banuls:2019bmf @Luo:2019vmi @Funcke:2019zna @Davoudi:2019bhy @Magnifico:2019kyj @Mishra:2019xbh @Shehab:2019gfn @Yang_2020 @Kharzeev:2020kgc @Shaw2020quantumalgorithms @PhysRevD.103.094501 @Halimeh:2020ecg @Halimeh:2020djb @VanDamme:2020rur @Haase:2020kaj @Yeter-Aydeniz:2020jte @Davoudi:2021ney @ARahman:2021ktn @PhysRevLett.122.050403 @Stryker:2021asy @aidelsburger2021cold @Bauer:2021gup @VanDamme:2021njp @Halimeh:2021lnv @Knaute:2021xna @Halimeh:2021vzf @Thompson:2021eze @Yeter-Aydeniz:2021mol @Yeter-Aydeniz:2021olz @Funcke:2021aps @Zhang:2021bjq @Rahman:2022rlg @Deliyannis:2022uyh @Bauer:2021gek @Illa:2022jqb @Mildenberger:2022jqr @Milsted:2020jmf ). These studies are permitting first quantum resource estimates to be made for more realistic simulations.

There has already been a number of quantum simulations of latticized $1 + 1$D quantum electrodynamics (QED, the lattice Schwinger model), starting with the pioneering work of Martinez #emph[et al.]~@Martinez:2016yna. The Schwinger model shares important features with quantum chromodynamics (QCD), such as charge screening, a non-zero fermion condensate, nontrivial topological charge sectors and a $theta$-term. Quantum simulations of the Schwinger model have been performed using quantum computers~@Martinez:2016yna @Klco:2018kyo @Lu:2018pjk @Kokail:2018eiw @Nguyen:2021hyk @Thompson:2021eze, and there is significant effort being made to extend this progress to higher dimensional QED~@Zohar:2011cw @Zohar:2012ay @Tagliacozzo:2012vg @Zohar:2012ts @Wiese:2013uua @Marcos:2014lda @Kuno:2014npa @Bazavov:2015kka @Kasper:2015cca @Brennen:2015pgn @Kuno:2016xbf @Zohar:2016iic @Kasper:2016mzj @Gonzalez-Cuadra:2017lvz @Ott:2020ycj @Paulson:2020zjd @Kan:2021nyu @aidelsburger2021cold @Bauer:2021gek. These, of course, build upon far more extensive and detailed classical simulations of this model and analytic solutions of the continuum theory. There is also a rich portfolio of classical and analytic studies of $1 + 1$D $S U ( N_c )$ gauge theories~@Wilson:1994fk @Heinzl:1995jn @PhysRevD.31.2020 @LIGTERINK2000983c @LIGTERINK2000215, with some seminal papers preparing for quantum simulations~@PhysRevD.11.395 @PhysRevA.73.022328 @Zohar:2012xf @PhysRevLett.110.125303 @Tagliacozzo:2012vg @Banuls:2017ena @PhysRevD.101.074512 @PhysRevD.103.094501 @Paulson:2020zjd, with the recent appearance of quantum simulations of a 1-flavor ($N_f = 1$) $1 + 1$D $S U ( 2 )$ lattice gauge theory~@Atas:2021ext. An attribute that makes such calculations attractive for early quantum simulations is that the gauge field(s) are uniquely constrained by Gauss's law at each lattice site. However, this is also a limitation for understanding higher dimensional theories where the gauge field is dynamical. After pioneering theoretical works developing the formalism and also end-to-end simulation protocols nearly a decade ago, it is only recently that first quantum simulations of the dynamics of a few plaquettes of gauge fields have been performed~@PhysRevD.101.074512 @PhysRevD.103.094501 @Atas:2021ext @Rahman:2022rlg.

Due to its essential features, quantum simulations of the Schwinger model provide benchmarks for QFTs and quantum devices for the foreseeable future. Moving toward simulations of QCD requires including non-Abelian local gauge symmetry and multiple flavors of dynamical quarks. Low-energy, static and near-static observables in the continuum theory in $1 + 1$D are well explored analytically and numerically, with remarkable results demonstrated, particularly in the 't Hooft model of large-$N_c$~@tHooft:1973alw @tHooft:1974pnl where the Bethe-Salpeter equation becomes exact. For a detailed discussion of $1 + 1$D $U ( 1 )$ and $S U ( N_c )$ gauge theories, see Refs.~@Frishman:2010tc @Frishman2014book. Extending such calculations to inelastic scattering to predict, for instance, exclusive processes in high-energy hadronic collisions is a decadal challenge.

In $3 + 1$D QCD, the last 50 years have seen remarkable progress in using classical high-performance computing to provide robust numerical results using lattice QCD, e.g., Refs.~@Joo:2019byq @Aoki:2021kgd, where the quark and gluon fields are discretized in spacetime. Lattice QCD is providing complementary and synergistic results to those obtained in experimental facilities, moving beyond what is possible with analytic techniques alone. However, the scope of classical computations, even with beyond-exascale computing platforms~@osti_1369223 @Habib:2016sce @Joo:2019byq, is limited by the use of a less fundamental theory (classical) to simulate a more fundamental theory (quantum).

Building upon theoretical progress in identifying candidate theories for early exploration (e.g., Ref.~@Sala:2018dui), quantum simulations of $1 + 1$D non-Abelian gauge theories including matter were recently performed~@Atas:2021ext for a $N_c = 2$ local gauge symmetry with one flavor of quark, $N_f = 1$. The Jordan-Wigner (JW) mapping~@Jordan:1928wi was used to define the lattice theory, and Variational Quantum Eigensolver (VQE)~@Peruzzo_2014 quantum circuits were developed and used on IBM's quantum devices~@IBMQ to determine the vacuum energy, along with meson and baryon masses. Further, there have been previous quantum simulations of 1- and 2-plaquette systems in $N_c = 2 , 3$ Yang-Mills lattice gauge theories~@Klco:2019evd @Ciavarella:2021nmj @Ciavarella:2021lel @ARahman:2021ktn @Illa:2022jqb that did not include quarks. Simulations of such systems are developing rapidly~@Ciavarella:2021lel @Rahman:2022rlg due to algorithmic and hardware advances. In addition, distinct mappings of these theories are being pursued~@Brower:1997ha @Banerjee:2012xg @Tagliacozzo:2012df @Alexandru:2019nsa @Ji:2020kjk @Wiese:2021djl @Caspar:2022llo.

This work focuses on the quantum simulation of $1 + 1$D $S U ( N_c )$ lattice gauge theory for arbitrary $N_c$ and $N_f$. Calculations are primarily done in $A_x^(( a )) = 0$ axial (Arnowitt-Fickler) gauge,#footnote[For a discussion of Yang-Mills in axial gauge, see, for example, Ref.~@Reinhardt:1996dy.] which leads to non-local interactions in order to define the chromo-electric field contributions to the energy density via Gauss's law. This is in contrast to Weyl gauge, $A_t^(( a )) = 0$, where contributions remain local. The resource estimates for asymptotic quantum simulations of the Schwinger model in Weyl gauge have been recently performed~@Shaw:2020udc, and also for Yang-Mills gauge theory based upon the Byrnes-Yamamoto mapping~@Kan:2021xfc. Here, the focus is on near-term, and hence non-asymptotic, quantum simulations to better assess the resource requirements for quantum simulations of non-Abelian gauge theories with multiple flavors of quarks. For concreteness, $N_f = 2$ QCD is studied in detail, including the mass decomposition of the low-lying hadrons (the $sigma$- and $pi$-meson, the single baryon and the two-baryon bound state), color edge-states, entanglement structures within the hadrons and quantum circuits for time evolution. Further, results are presented for the quantum simulation of a $N_f = 1$, single-site system, using IBM's quantum computers~@IBMQ. Such quantum simulations will play a critical role in evolving the functionality, protocols and workflows to be used in $3 + 1$D simulations of QCD, including the preparation of scattering states, time evolution and subsequent particle detection. As a step in this direction, in a companion to the present paper, the results of this work have been applied to the quantum simulation of $beta$-decay of a single baryon in $1 + 1$D QCD~@PhysRevD.107.054513. Motivated by the recent successes in co-designing efficient multi-qubit operations in trapped-ion systems~@Andrade:2021pil @Katz:2022czu, additional multi-qubit or qudit operations are identified, specific to lattice gauge theories, that would benefit from being native operations on quantum devices.

= QCD WITH THREE COLORS AND TWO FLAVORS IN $1 + 1$D
<sec:Nc3Nf2>
In $3 + 1$D, the low-lying spectrum of $N_f = 2$ QCD is remarkably rich. The lightest hadrons are the $pi$s, which are identified as the pseudo-Goldstone bosons associated with the spontaneous breaking of the approximate global $S U ( 2 )_L ⊗ S U ( 2 )_R$ chiral symmetry, which becomes exact in the chiral limit where the $pi$s are massless. At slightly higher mass are the broad $I = 0$ spinless resonance, $sigma$, and the narrow $I = 0$, $omega$, and $I = 1$, $rho$, vector resonances as well as the multi-meson continuum. The proton and neutron, which are degenerate in the isospin limit and the absence of electromagnetism, are the lightest baryons, forming an $I = J = 1 / 2$ iso-doublet. The next lightest baryons, which become degenerate with the nucleons in the large-$N_c$ limit (as part of a large-$N_c$ tower), are the four $I = J = 3 / 2 Delta$ resonances. The nucleons bind together to form the periodic table of nuclei, the lightest being the deuteron, an $I = 0$, $J = 1$ neutron-proton bound state with a binding energy of $tilde 2.2 med upright("MeV")$, which is to be compared to the mass of the nucleon $M_N tilde 940 med upright("MeV")$. In nature, the low-energy two-nucleon systems have S-wave scattering lengths that are much larger than the range of their interactions, rendering them unnatural. Surprisingly, this unnaturalness persists for a sizable range of light-quark masses, e.g., Refs.~@Beane:2002xf @Epelbaum:2012iu @Berengut:2013nh @Wagman:2017tmp @NPLQCD:2020lxg. In addition, this unnaturalness, and the nearby renormalization-group fixed point~@Kaplan:1998tg @Kaplan:1998we, provides the starting point for a systematic effective field theory expansion about unitarity~@Kaplan:1998tg @Kaplan:1998we @vanKolck:1998bw @Chen:1999tn. Much of this complexity is absent in a theory with only one flavor of quark.

As a first step toward $3 + 1$D QCD simulations of real-time dynamics of nucleons and nuclei, we will focus on preparing to carry out quantum simulations of $1 + 1$D QCD with $N_f = 2$ flavors of quarks. While the isospin structure of the theory is the same as in $3 + 1$D, the lack of spin and orbital angular momentum significantly reduces the richness of the hadronic spectrum and S-matrix. However, many of the relevant features and processes of $3 + 1$D QCD that are to be addressed by quantum simulation in the future are present in $1 + 1$D QCD. Therefore, quantum simulations in $1 + 1$D are expected to provide inputs to the development of quantum simulations of QCD.

== Mapping $1 + 1$D QCD onto Qubits
<mapping-11d-qcd-onto-qubits>
The Hamiltonian describing non-Abelian lattice gauge field theories in arbitrary numbers of spatial dimensions was first given by Kogut and Susskind (KS) in the 1970s~@Kogut:1974ag @Banks:1975gq. For $1 + 1$D QCD with $N_f = 2$ discretized onto $L$ spatial lattice sites, which are mapped to 2L $q$, $overline(q)$ sites to separately accommodate quarks and antiquarks, the KS lattice Hamiltonian is

$ H_(upright("KS")) = & sum_(f = u , d) [frac(1, 2 a) sum_(n = 0)^(2 L - 2) (phi.alt_n^(( f ) dagger) U_n phi.alt_(n + 1)^(( f )) med + med upright("h") thin upright(".") thin upright("c") thin upright(".")) med + med m_f sum_(n = 0)^(2 L - 1) ( - 1 )^n phi.alt_n^(( f ) dagger) phi.alt_n^(( f ))] med + med frac(a g^2, 2) sum_(n = 0)^(2 L - 2) sum_(a = 1)^8 | upright(bold(E))_n^(( a )) |^2\
 & - med mu_B / 3 sum_(f = u , d) sum_(n = 0)^(2 L - 1) phi.alt_n^(( f ) dagger) phi.alt_n^(( f )) med - med mu_I / 2 sum_(n = 0)^(2 L - 1) (phi.alt_n^(( u ) dagger) phi.alt_n^(( u )) med - med phi.alt_n^(( d ) dagger) phi.alt_n^(( d ))) med . $<eq:KSHam>

The masses of the $u$- and $d$-quarks are $m_(u , d)$, $g$ is the strong coupling constant at the spatial lattice spacing $a$, $U_n$ is the spatial link operator in Weyl gauge $A_t^(( a )) = 0$, $phi.alt_n^(( u , d ))$ are the $u$- and $d$-quark field operators which transform in the fundamental representation of $S U ( 3 )$ and $upright(bold(E))_n^(( a ))$ is the chromo-electric field associated with the $S U ( 3 )$ generator, $T^a$. For convention, we write, for example, $phi.alt_n^(( u )) = ( u_(n , r) , u_(n , g) , u_(n , b) )^T$ to denote the $u$-quark field(s) at the $n^(upright("th"))$ site in terms of 3 colors $r , g , b$. With an eye toward simulations of dense matter systems, chemical potentials for baryon number, $mu_B$, and the third component of isospin, $mu_I$, are included. For most of the results presented in this work, the chemical potentials will be set to zero, $mu_B = mu_I = 0$, and there will be exact isospin symmetry, $m_u = m_d equiv m$. In Weyl gauge and using the chromo-electric basis of the link operator $| upright(bold(R)) , alpha , beta chevron.r_n$, the contribution from the energy in the chromo-electric field from each basis state is proportional to the Casimir of the irrep $upright(bold(R))$.#footnote[For an irrep, $upright(bold(R))$, represented by a tensor with $p$ upper indices and $q$ lower indices, $T_(b_1 dots.h.c b_q)^(a_1 dots.h.c a_p)$, the Casimir provides]

$ sum_(b = 1)^8 | upright(bold(E))_n^(( a )) |^2 med | upright(bold(R)) , alpha , beta chevron.r_n = 1 / 3 (p^2 + q^2 + p q + 3 p + 3 q) med | upright(bold(R)) , alpha , beta chevron.r_n med . $

The indices $alpha$ and $beta$ specify the color state in the left (L) and right (R) link Hilbert spaces respectively.

States of a color irrep #strong[R] are labelled by their total color isospin $T$, third component of color isospin $T^z$ and color hypercharge $Y$, i.e., $alpha = ( T_L , T_L^z , Y_L )$ and $beta = ( T_R , T_R^z , Y_R )$.

 foot:irrep 

The fields have been latticized such that the quarks reside on even-numbered sites, $n = 0 , 2 , 4 , 6 , dots.h$, and antiquarks reside on odd-numbered sites, $n = 1 , 3 , 5 , dots.h$. Open boundary conditions (OBCs) are employed in the spatial direction, with a vanishing background chromo-electric field. For simplicity, the lattice spacing will be set equal to $1$.

The KS Hamiltonian in @eq:KSHam is constructed in Weyl gauge. A unitary transformation can be performed on @eq:KSHam to eliminate the gauge links~@Sala:2018dui, with Gauss's Law uniquely providing the energy in the chromo-electric field in terms of a non-local sum of products of charges, i.e., the Coulomb energy. This is equivalent to formulating the system in axial gauge~@PhysRev.127.1821 @weinberg1995quantum, $A_x^(( a )) = 0$, from the outset. The Hamiltonian in @eq:KSHam, when formulated with $A_x^(( a )) = 0$, becomes

$ H = & sum_(f = u , d) [1 / 2 sum_(n = 0)^(2 L - 2) (phi.alt_n^(( f ) dagger) phi.alt_(n + 1)^(( f )) med + med upright("h") thin upright(".") thin upright("c") thin upright(".")) med + med m_f sum_(n = 0)^(2 L - 1) ( - 1 )^n phi.alt_n^(( f ) dagger) phi.alt_n^(( f ))] med + med g^2 / 2 sum_(n = 0)^(2 L - 2) sum_(a = 1)^8 (sum_(m lt.eq n) Q_m^(( a )))^2\
 & - med mu_B / 3 sum_(f = u , d) sum_(n = 0)^(2 L - 1) phi.alt_n^(( f ) dagger) phi.alt_n^(( f )) med - med mu_I / 2 sum_(n = 0)^(2 L - 1) (phi.alt_n^(( u ) dagger) phi.alt_n^(( u )) med - med phi.alt_n^(( d ) dagger) phi.alt_n^(( d ))) med , $<eq:GFHam>

where the color charge operators on a given lattice site are the sum of contributions from the $u$- and $d$-quarks,

$ Q_m^(( a )) med = med phi.alt_m^(( u ) dagger) T^a phi.alt_m^(( u )) med + med phi.alt_m^(( d ) dagger) T^a phi.alt_m^(( d )) med . $<eq:SU3charges>

To define the fields, boundary conditions with $A_0^(( a )) ( x ) = 0$ at spatial infinity and zero background chromo-electric fields are used, with Gauss's law sufficient to determine them at all other points on the lattice,

$ upright(bold(E))_n^(( a )) = sum_(m lt.eq n) Q_m^(( a )) med . $

In this construction, a state is completely specified by the fermionic occupation at each site. This is to be contrasted with the Weyl gauge construction where both fermionic occupation and the $S U ( 3 )$ multiplet defining the chromo-electric field are required.

There are a number of ways that this system, with the Hamiltonian given in @eq:GFHam, could be mapped onto the register of a quantum computer. In this work, both a staggered discretization and a JW transformation~@1928ZPhy...47..631J are chosen to map the $N_c = 3$ and $N_f = 2$ quarks to 6 qubits, with ordering $d_b , d_g , d_r , u_b , u_g , u_r$, and the antiquarks associated with the same spatial site adjacent with ordering $overline(d)_b , overline(d)_g , overline(d)_r , overline(u)_b , overline(u)_g , overline(u)_r$. This is illustrated in @fig:2flavLayout and requires a total of 12 qubits per spatial lattice site (see App.~@app:hamConst for more details).

// [figvision-cn] imgs/2FlavorLattice.png
// 该图像为一幅垂直分层布局的示意图，展示量子色动力学（
// QCD）在自旋格点上的编码过程，共分为四个水平层级，由上
// 至下依次对应“交错夸克”、“分布颜色与味自由度”、“JW变换
// 与轴规范”三个阶段。整个图以黑色线条、彩色圆点和文字标
// 注构成，无坐标轴或比例尺。 顶层：两个独立三角形结构并
// 列排布。左侧三角形顶点标记为“Site 1”，从该点引出两条向
// 下倾斜的黑色实线箭头，分别指向下方虚线上的两个黑点；右
// 侧三角形顶点标记为“Site 0”，同样引出两条向下倾斜的黑色
// 实线箭头，指向其下方虚线上的两个黑点。这两个三角形结构
// 共同被一个右侧大括号括起，并标注“Staggered Quarks”。
// 第二层：一条贯穿全图的水平黑色虚线，线上从左至右均匀分
// 布四个实心黑点，分别标注为“q̄₃”、“q₂”、“q̄₁”、“q₀”。相
// 邻两点之间用带标签的黑色短横线连接：q̄₃与q₂之间标注“E₂
// ⁽ᵃ⁾”，q₂与q̄₁之间标注“E₁⁽ᵃ⁾”，q̄₁与q₀之间标注“E₀⁽ᵃ⁾”。
// 这些E项代表色电场，位于夸克与反夸克之间的链上。此层整
// 体被右侧大括号括起，标注“Distribute Color and Flavor”。
// 第三层：在第二层每个黑点正下方，通过黑色实线分支结构连
// 接到一组六个彩色小圆点，每组六点对应一个夸克/反夸克位
// 点。具体而言： q̄下方分支出六点，从左至右颜色依次为蓝、
// 绿、红、蓝、绿、红，下方标注“d̄”（覆盖前三点）和“ū”（
// 覆盖后三点）。 q₂下方分支出六点，颜色同上，但未标注。
// q̄₁下方分支出六点，颜色同上，下方标注“d”（覆盖前三点）
// 和“u”（覆盖后三点）。 q₀下方分支出六点，颜色同上，但未
// 标注。 所有彩色圆点均为实心圆形，蓝色、绿色、红色各出
// 现两次，代表不同颜色自由度；每组内前三个点与后三个点分
// 别对应不同味自由度（如d̄/d 和 ū/u）。此层整体被右侧大
// 括号括起，标注“JW Transformation and Axial Gauge”。 底
// 层：在第三层每对味组（如d̄与ū）对应的六个彩色圆点正下
// 方，排列十二个带箭头的空心圆圈，分为左右两组，每组六个。
// 左侧组对应q̄₃下方的六点，右侧组对应q̄₁下方的六点（q₂与
// q₀下方无底层符号）。每个空心圆圈颜色与其上方彩色圆点一
// 致，内部有一个垂直箭头：向上箭头表示自旋向上态，向下箭
// 头表示自旋向下态。最左侧标注量子态符号“|ū_b d_b⟩”，其
// 中b为下标，表明这是特定基态。箭头方向如下： 对于q̄₃下
// 方六点（左三为d̄，右三为ū）：对应底层六个圈中，第一个
// （蓝）、第三个（红）、第五个（绿）为向上箭头；第二个（
// 绿）、第四个（蓝）、第六个（红）为向下箭头。 对于q̄₁下
// 方六点（左三为d，右三为u）：对应底层六个圈中，第一个（
// 蓝）、第三个（红）、第五个（绿）为向上箭头；第二个（绿）、
// 第四个（蓝）、第六个（红）为向下箭头。 底层整体被右侧
// 大括号括起，标注“JW Transformation and Axial Gauge”。
// 整幅图传达的核心趋势是：通过将QCD中的夸克场进行交错离
// 散化（staggering），使夸克与反夸克交替占据格点；随后将
// 每个夸克/反夸克的颜色与味自由度映射到六个量子比特（即
// 六个彩色圆点）；最后通过Jordan-Wigner变换与轴规范选择，
// 将这些自由度转化为具有明确自旋方向的量子比特状态（带箭
// 头空心圆），从而完成从连续场论到离散量子比特系统的编码。
// 图中所有元素均按空间位置严格对齐，体现数据流的逐级转换
// 关系。
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

#figure(image("imgs/2FlavorLattice.png", width: 15cm),
  caption: [
    The encoding of $N_f = 2$ QCD onto a lattice of spins describing $L = 2$ spatial sites. Staggering is used to discretize the quark fields, which doubles the number of lattice sites, with (anti)quarks on (odd) even sites. The chromo-electric field resides on the links between quarks and antiquarks. Color and flavor degrees of freedom of each quark and antiquark site are distributed over six qubits with a JW mapping, and axial gauge along with Gauss's law are used to remove the chromo-electric fields. A quark (antiquark) site is occupied if it is spin up (down), and the example spin configuration corresponds to the state $| overline(u)_b thin d_b chevron.r$.
  ]
)
<fig:2flavLayout>

The resulting JW-mapped Hamiltonian is the sum of the following five terms:

$ H = &med H_(k i n) med + med H_m med + med H_(e l) med + med H_(mu_B) med + med H_(mu_I) med , $<eq:H2flav>
$ H_(k i n) = & med - 1 / 2 sum_(n = 0)^(2 L - 2) sum_(f = 0)^1 sum_(c = 0)^2 [sigma_(6 n + 3 f + c)^(+) (⨂_(i = 1)^5 sigma_(6 n + 3 f + c + i)^z) sigma_(6 ( n + 1 ) + 3 f + c)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".")] med ,\
H_m = & med 1 / 2 sum_(n = 0)^(2 L - 1) sum_(f = 0)^1 sum_(c = 0)^2 m_f [( - 1 )^n sigma_(6 n + 3 f + c)^z + 1] med ,\
H_(e l) = & med g^2 / 2 sum_(n = 0)^(2 L - 2) ( 2 L - 1 - n ) (sum_(f = 0)^1 Q_(n , f)^(( a )) thin Q_(n , f)^(( a )) med + med 2 Q_(n , 0)^(( a )) thin Q_(n , 1)^(( a )))\
 & + g^2 sum_(n = 0)^(2 L - 3) sum_(m = n + 1)^(2 L - 2) ( 2 L - 1 - m ) sum_(f = 0)^1 sum_(f' = 0)^1 Q_(n , f)^(( a )) thin Q_(m , f')^(( a )) med ,\
H_(mu_B) = & med - mu_B / 6 sum_(n = 0)^(2 L - 1) sum_(f = 0)^1 sum_(c = 0)^2 sigma_(6 n + 3 f + c)^z med ,\
H_(mu_I) = & med - mu_I / 4 sum_(n = 0)^(2 L - 1) sum_(f = 0)^1 sum_(c = 0)^2 ( - 1 )^f sigma_(6 n + 3 f + c)^z med , $<eq:Hkin2flav>

where now repeated adjoint color indices, $( a )$, are summed over, the flavor indices, $f = 0 , 1$, correspond to $u$- and $d$-quark flavors and $sigma^plus.minus = ( sigma^x plus.minus i sigma^y ) / 2$. Products of charges are given in terms of spin operators as

$ Q_(n , f)^(( a )) thin Q_(n , f)^(( a )) = & 1 / 3 ( 3 - sigma_(6 n + 3 f)^z sigma_(6 n + 3 f + 1)^z - sigma_(6 n + 3 f)^z sigma_(6 n + 3 f + 2)^z - sigma_(6 n + 3 f + 1)^z sigma_(6 n + 3 f + 2)^z ) med ,\
Q_(n , f)^(( a )) thin Q_(m , f')^(( a )) = & 1 / 4 \[ 2 ( sigma_(6 n + 3 f)^(+) sigma_(6 n + 3 f + 1)^(-) sigma_(6 m + 3 f')^(-) sigma_(6 m + 3 f' + 1)^(+) + sigma_(6 n + 3 f)^(+) sigma_(6 n + 3 f + 1)^z sigma_(6 n + 3 f + 2)^(-) sigma_(6 m + 3 f')^(-) sigma_(6 m + 3 f' + 1)^z sigma_(6 m + 3 f' + 2)^(+)\
 & + sigma_(6 n + 3 f + 1)^(+) sigma_(6 n + 3 f + 2)^(-) sigma_(6 m + 3 f' + 1)^(-) sigma_(6 m + 3 f' + 2)^(+) + upright(h) . c . ) + 1 / 6 sum_(c = 0)^2 sum_(c' = 0)^2 ( 3 delta_(c c') - 1 ) sigma_(6 n + 3 f + c)^z sigma_(6 m + 3 f' + c')^z \] med . $<eq:QnfQmfp>

A constant has been added to $H_m$ to ensure that all basis states contribute positive mass. The Hamiltonian for $S U ( N_c )$ gauge theory with $N_f$ flavors in the fundamental representation is presented in @sec:NcNf. Note that choosing $A_x^(( a )) = 0$ gauge and enforcing Gauss's law has resulted in all-to-all interactions, the double lattice sum in $H_(e l)$.

For any finite lattice system, there are color non-singlet states in the spectrum, which are unphysical and have infinite energy in the continuum and infinite-volume limits. For a large but finite system, OBCs can also support finite-energy color non-singlet states which are localized to the end of the lattice (color edge-states).#footnote[Low-energy edge-states that have global charge in a confining theory can also be found in the simpler setting of the Schwinger model. Through exact and approximate tensor methods, we have verified that these states exist on lattices up to length $L = 13$, and they are expected to persist for larger $L$.] The existence of such states in the spectrum is independent of the choice of gauge or fermion mapping. The naive ways to systematically examine basis states and preclude such configurations is found to be impractical due to the non-Abelian nature of the gauge charges and the resulting entanglement between states required for color neutrality. A practical way to deal with this problem is to add a term to the Hamiltonian that raises the energy of color non-singlet states. This can be accomplished by including the energy density in the chromo-electric field beyond the end of the lattice with a large coefficient $h$. This effectively adds the energy density in a finite chromo-electric field over a large spatial extent beyond the end of the lattice. In the limit $h arrow.r oo$, only states with a vanishing chromo-electric field beyond the end of the lattice remain at finite energy, rendering the system within the lattice to be a color singlet. This new term in the Hamiltonian is

$ H_(upright(bold(1))) = h^2 / 2 sum_(n = 0)^(2 L - 1) (sum_(f = 0)^1 Q_(n , f)^(( a )) thin Q_(n , f)^(( a )) med + med 2 Q_(n , 0)^(( a )) thin Q_(n , 1)^(( a ))) med + med h^2 sum_(n = 0)^(2 L - 2) sum_(m = n + 1)^(2 L - 1) sum_(f = 0)^1 sum_(f' = 0)^1 Q_(n , f)^(( a )) thin Q_(m , f')^(( a )) med , $<eq:Hpen>

which makes a vanishing contribution when the sum of charges over the whole lattice is zero; otherwise, it makes a contribution $tilde h^2$.

== Spectra for $L = 1 , 2$ Spatial Sites
<sec:Exact>
The spectra and wavefunctions of systems with a small number of lattice sites can be determined by diagonalization of the Hamiltonian. In terms of spin operators, the $N_f = 2$ Hamiltonian in @eq:H2flav decomposes into sums of tensor products of Pauli matrices. The tensor product factorization can be exploited to perform an exact diagonalization relatively efficiently. This is accomplished by first constructing a basis by projecting onto states with specific quantum numbers, and then building the Hamiltonian in that subspace. There are four mutually commuting symmetry generators that allow states to be labelled by $( r , g , b , I_3 )$: redness, greenness, blueness and the third component of isospin. In the computational (occupation) basis, states are represented by bit strings of $0$s and $1$s. For example, the $L = 1$ state with no occupation is $| 000000111111 chevron.r$.#footnote[Qubits are read from right to left, e.g., $| q_11 thin q_10 thin dots.h thin q_1 thin q_0 chevron.r$. Spin up is $| 0 chevron.r$ and spin down is $| 1 chevron.r$.] Projecting onto eigenstates of $( r , g , b , I_3 )$ amounts to fixing the total number of $1$s in a substring of a state. The Hamiltonian is formed by evaluating matrix elements of Pauli strings between states in the basis, and only involves $2 times 2$ matrix multiplication. The Hamiltonian matrix is found to be sparse, as expected, and the low energy eigenvalues and eigenstates can be found straightforwardly. As the dimension of the Hamiltonian grows exponentially with the spatial extent of the lattice, this method becomes intractable for large system sizes, as is well known.

=== Exact Diagonalizations, Color Edge-States and Mass Decompositions of the Hadrons
<exact-diagonalizations-color-edge-states-and-mass-decompositions-of-the-hadrons>
For small enough systems, an exact diagonalization of the Hamiltonian matrix in the previously described basis can be performed. Without chiral symmetry and its spontaneous breaking, the energy spectrum in $1 + 1$D does not contain a massless isovector state (corresponding to the QCD pion) in the limit of vanishing quark masses. In the absence of chemical potentials for baryon number, $mu_B = 0$, or isospin, $mu_I = 0$, the vacuum, $| Omega chevron.r$, has $B = 0$ (baryon number zero) and $I = 0$ (zero total isospin). The $I = 0 sigma$-meson is the lightest meson, while the $I = 1 pi$-meson is the next lightest. The lowest-lying eigenstates in the $B = 0$ spectra for $L = 1 , 2$ (obtained from exact diagonalization of the Hamiltonian) are given in @tab:specB0. The masses are defined by their energy gap to the vacuum, and all results in this section are for $m_u = m_d = m = 1$.

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,left,left,),
    table.header(table.cell(align: center, colspan: 4)[$L = 1$],),
    table.hline(),
    [$g^2$], [$E_Omega$], [$M_sigma$], [$M_pi$],
    [8], [-0.205], [5.73], [5.82],
    [4], [-0.321], [4.37], [4.47],
    [2], [-0.445], [3.26], [3.30],
    [1], [-0.549], [2.73], [2.74],
    [1/2], [-0.619], [2.48], [2.48],
    [1/4], [-0.661], [2.35], [2.36],
    [1/8], [-0.684], [2.29], [2.30],
  )]
  , caption: [ The vacuum energy and the masses of the $sigma$- and $pi$-mesons for $1 + 1$D QCD with $N_f = 2$ for systems with $L = 1 , 2$ spatial sites. These results are insensitive to $h$ as they are color singlets.]
  , kind: table
  )

#block[]
#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,left,left,),
    table.header(table.cell(align: center, colspan: 4)[$L = 2$],),
    table.hline(),
    [$g^2$], [$E_Omega$], [$M_sigma$], [$M_pi$],
    [8], [-0.611], [5.82], [5.92],
    [4], [-0.949], [4.41], [4.49],
    [2], [-1.30], [3.27], [3.31],
    [1], [-1.58], [2.72], [2.74],
    [1/2], [-1.77], [2.45], [2.46],
    [1/4], [-1.88], [2.30], [2.31],
    [1/8], [-1.94], [2.22], [2.22],
  )]
  , caption: [ The vacuum energy and the masses of the $sigma$- and $pi$-mesons for $1 + 1$D QCD with $N_f = 2$ for systems with $L = 1 , 2$ spatial sites. These results are insensitive to $h$ as they are color singlets.]
  , kind: table
  )
<tab:specB0>

By examining the vacuum energy density $E_Omega / L$, it is clear that, as expected, this number of lattice sites is insufficient to fully contain hadronic correlation lengths. While @tab:specB0 shows the energies of color-singlet states, there are also non-singlet states in the spectra with similar masses, which become increasingly localized near the end of the lattice, as discussed in the previous section.

It is informative to examine the spectrum of the $L = 1$ system as both $g$ and $h$ are slowly increased and, in particular, take note of the relevant symmetries. For $g = h = 0$, with contributions from only the hopping and mass terms, the system exhibits a global $S U ( 12 )$ symmetry where the spectrum is that of free quasi-particles; see App.~@app:freeSym. The enhanced global symmetry at this special point restricts the structure of the spectrum to the $upright(bold(1))$ and $upright(bold(12))$ of $S U ( 12 )$ as well as the antisymmetric combinations of fundamental irreps, $upright(bold(66)) , upright(bold(220)) , dots.h$. For $g > 0$, these $S U ( 12 )$ irreps split into irreps of color $S U ( 3 )_c$ and flavor $S U ( 2 )_f$. The $upright(bold(12))$ corresponds to single quark ($q$) or antiquark ($overline(q)$) excitations (with fractional baryon number), and splits into $upright(bold(3))_c ⊗ upright(bold(2))_f$ for quarks and $overline(upright(bold(3)))_c ⊗ upright(bold(2))_f$ for antiquarks. In the absence of OBCs, these states would remain degenerate, but the boundary condition of vanishing background chromo-electric field is not invariant under $q arrow.l.r overline(q)$ and the quarks get pushed to higher mass. As there is no chromo-electric energy associated with exciting an antiquark at the end of the lattice in this mapping, the $overline(upright(bold(3)))_c ⊗ upright(bold(2))_f$ states remains low in the spectrum until $h gt.double 0$. The $upright(bold(66))$ corresponds to two-particle excitations, and contains all combinations of $q q$, $overline(q) q$ and $overline(q) overline(q)$ excitations. The mixed color symmetry (i.e., neither symmetric or antisymmetric) of $overline(q) q$ excitations allows for states with $upright(bold(1))_c ⊗ upright(bold(1))_f xor upright(bold(1))_c ⊗ upright(bold(3))_f xor upright(bold(8))_c ⊗ upright(bold(1))_f xor upright(bold(8))_c ⊗ upright(bold(3))_f$, while the $q q$ excitations with definite color symmetry allow for $upright(bold(6))_c ⊗ upright(bold(1))_f xor overline(upright(bold(3)))_c ⊗ upright(bold(3))_f$ and $overline(q) overline(q)$ excitations allow for $overline(upright(bold(6)))_c ⊗ upright(bold(1))_f xor upright(bold(3))_c ⊗ upright(bold(3))_f$, saturating the $66$ states in the multiplet. When $g > 0$, these different configurations split in energy, and when $h gt.double 0$, only color-singlet states are left in the low-lying spectrum. @fig:specDegenh shows the evolution of the spectrum as $g$ and $h$ increase. The increase in mass of non-singlet color states with $h$ is proportional to the Casimir of the $S U ( 3 )_c$ representation which is evident in @fig:specDegenh where, for example, the increase in the mass of the $upright(bold(3))_c$s and $overline(upright(bold(3)))_c$s between $h^2 = 0$ and $h^2 = 0.64$ are the same.

// [figvision-cn] imgs/SpectrumDegeneracyh.png
// 该图像标题为“L = 1时的低能谱”，展示了随着耦合常数变化，
// 哈密顿量本征值（质量）的演化。纵轴表示“Mass”（质量），
// 方向向上递增，左侧中部有双斜线断开符号，表示坐标轴存在
// 不连续或尺度跳跃。横轴分为三个区域，分别对应不同的对称
// 性破缺阶段：左侧为SU(12)对称相，中间为SU(3)_c ⊗ SU(2)
// _f对称相，右侧为SU(3)_singlet ⊗ SU(2)对称相。图中包含
// 四组参数设置框，从左至右依次为：g² = h² = 0；g² = 0.64
// , h² = 0；g² = h² = 0.64；g² = 0.64, h² = 100。 第一列
// （最左侧，对应 g² = h² = 0）： 在底部有一条蓝色水平线
// 段，标注为“1_{SU(12)}”。 其上方有一条绿色水平线段，标
// 注为“12_{SU(12)}”。 再上方有一条红色水平线段，标注为“
// 66_{SU(12)}”。 此列无箭头连接，仅显示初始简并态。 第二
// 列（中间偏左，对应 g² = 0.64, h² = 0）： 底部蓝色线段
// 延续自第一列，标注为“1_c ⊗ 1_f”。 绿色部分分裂为两条平
// 行绿线：下方一条标注“\bar{3}_c ⊗ 2_f”，上方一条标注“
// 3_c ⊗ 2_f”。 红色部分分裂为多条红线：从下至上依次标注“
// 3_c ⊗ 3_f”、“\bar{6}_c ⊗ 1_f”、“1_c ⊗ 1_f”、“1_c ⊗ 3_f
// ”、“\bar{3}_c ⊗ 3_f”、“8_c ⊗ 3_f”、“8_c ⊗ 1_f”、“6_c ⊗
// 1_f”。其中，“1_c ⊗ 1_f”、“1_c ⊗ 3_f”、“\bar{3}_c ⊗ 3_f
// ”、“8_c ⊗ 3_f”、“8_c ⊗ 1_f”五条线紧密聚集在同一高度，
// 用黑色双向箭头指向它们，表明这些态在此阶段仍近似简并。
// 从第一列到第二列，各态之间由黑色实线箭头连接，表示能级
// 演化路径。例如，“1_{SU(12)}”→“1_c ⊗ 1_f”；“12_{SU(12)}
// ”→“\bar{3}_c ⊗ 2_f”和“3_c ⊗ 2_f”；“66_{SU(12)}”→所有上
// 述红/绿/蓝态中的多个分支。 第三列（中间偏右，对应 g² =
// h² = 0.64）： 底部蓝色线段继续存在，未标注新名称。 绿
// 色部分保持两条平行绿线：“\bar{3}_c ⊗ 2_f”和“3_c ⊗ 2_f”，
// 位置与第二列相同。 红色部分发生显著重排：原“1_c ⊗ 1_f”、
// “1_c ⊗ 3_f”、“\bar{3}_c ⊗ 3_f”、“8_c ⊗ 3_f”、“8_c ⊗
// 1_f”等态中，部分向上移动，部分向下移动。具体地： “1_c
// ⊗ 1_f” → 上升至较高位置； “1_c ⊗ 3_f” → 上升至更高位置；
// “\bar{3}_c ⊗ 3_f” → 上升至最高位置之一； “8_c ⊗ 3_f” →
// 上升至次高位置； “8_c ⊗ 1_f” → 上升至另一高位； “6_c ⊗
// 1_f” → 上升至顶部； “3_c ⊗ 3_f” → 下降至较低位置； “\
// bar{6}_c ⊗ 1_f” → 保持在中下部。 所有连接线均为黑色实
// 线箭头，清晰标示每个态从第二列到第三列的能量变化轨迹。
// 整体趋势是：非单态色态（如含8_c、6_c、\bar{6}_c的态）
// 被推高，而某些单态或混合态相对降低。 第四列（最右侧，
// 对应 g² = 0.64, h² = 100）： 仅保留三条水平线： 底部蓝
// 色线段，标注为“|Ω⟩”； 中间绿色线段，无额外标注； 顶部
// 红色线段，标注为“|π⟩”和“|σ⟩”，两者几乎重合，用两个短箭
// 头分别指向同一水平线，表示这两个态在此极限下简并。 其
// 他所有态均已移出可视范围（即能量远高于当前窗口）。 从
// 第三列到第四列，只有少数几条线延伸至此：主要是底部的蓝
// 色线和顶部的红色线（对应|π⟩和|σ⟩），其余红线均终止于第
// 三列或未延伸至第四列，暗示它们已被推至高能区。 颜色编
// 码说明： 蓝色：代表SU(12)单态或其演化产物，最终对应|Ω⟩
// 态。 绿色：代表SU(3)_c三重态与SU(2)_f二重态组合，如3_c
// ⊗2_f和\bar{3}_c⊗2_f，在h增大时保持稳定。 红色：代表其
// 他色多重态，包括色单态和非单态，随h增加大部分被推高，
// 仅剩|π⟩和|σ⟩留在低能区。 关键结论： 当g²=0.64且h²从0增
// 至100时，系统经历对称性破缺：从SU(12) → SU(3)_c⊗SU(2)
// _f → SU(3)_singlet⊗SU(2)。在此过程中，色非单态（color
// non-singlet）态逐渐被推离低能谱，最终仅剩色单态|π⟩和|σ
// ⟩以及基态|Ω⟩保留在低能区。特别指出，|π⟩和|σ⟩的质量对h
// 的变化不敏感，即在h²=0.64到h²=100区间内基本不变。
#figure(image("imgs/SpectrumDegeneracyh.png", width: 14cm),
  caption: [
    The spectrum of the Hamiltonian as the couplings $g$ and $h$ increase. For $g = h = 0$ there is an exact $S U ( 12 )$ symmetry and the color-singlet $sigma$- and $pi$-mesons are a part of the antisymmetric $upright(bold(66))$ irrep. When $g > 0$ and $h = 0$, the spectrum splits into irreps of global $S U ( 3 )_c ⊗ S U ( 2 )_f$ with color non-singlet states among the low-lying states. Increasing $h > 0$ pushes non-singlet color states out of the low-lying spectrum. Notice that the $sigma$ and $pi$ masses are insensitive to $h$, as expected.
  ]
)
<fig:specDegenh>

The antiquark states are particularly interesting as they correspond to edge states that are not “penalized” in energy by the chromo-electric field when $h = 0$. These states have an approximate $S U ( 6 )$ symmetry where the $6$ antiquarks transform in the fundamental. This is evident in the spectrum shown in @fig:specDegeng by the presence of a $overline(upright(bold(3)))_c ⊗ upright(bold(2))_f$ and nearly degenerate $overline(upright(bold(6)))_c ⊗ upright(bold(1))_f$ and $upright(bold(3))_c ⊗ upright(bold(3))_f$ which are identified as states of a $upright(bold(15))$ (an antisymmetric irrep of $S U ( 6 )$) that do not increase in mass as $g$ increases. This edge-state $S U ( 6 )$ symmetry is not exact due to interactions from the hopping term that couple the edge $overline(q)$s to the rest of the lattice. These colored edge states are artifacts of OBCs and will persist in the low-lying spectrum for larger lattices.

// [figvision-cn] imgs/SpectrumDegeneracyg.png
// 这是一张展示哈密顿量谱随参数变化的能级演化示意图，标题
// 为“L=1时的低能谱”。图像左侧纵轴标记为“Mass”（质量），
// 箭头向上表示质量增加；横轴无刻度，但通过三个并列区域展
// 示不同参数下的谱结构。图像底部标注两个对称性破缺阶段：
// 左侧为SU(12)对称性，右侧为SU(3)_c ⊗ SU(2)_f对称性。 左
// 起第一个区域顶部有圆角矩形框标注“g² = h² = 0”，对应SU(
// 12)对称性未破缺情形。该区域内有三条水平线，从上至下分
// 别为： 红色水平线，左侧标注“66_{SU(12)}”，代表一个66维
// 不可约表示的能级； 绿色水平线，左侧标注“12_{SU(12)}”，
// 代表一个12维不可约表示的能级； 蓝色水平线，左侧标注“1_
// {SU(12)}”，代表一个1维不可约表示的能级。 三条线之间用
// 双斜杠符号断开纵轴，表示中间省略了部分能级范围。 第二
// 个区域顶部标注“g² = 0.64, h² = 0”，对应SU(12)破缺为SU(
// 3)_c ⊗ SU(2)_f的情形。此区域中，原SU(12)能级分裂为多个
// 子能级，由左侧标签指向具体组合态： 最上方红色组：包含
// 五条紧密排列的红色水平线，左侧标签依次为“6_c ⊗ 1_f”、“
// 8_c ⊗ 1_f”、“8_c ⊗ 3_f”、“3̄_c ⊗ 3_f”、“1_c ⊗ 3_f”、“
// 1_c ⊗ 1_f”，其中后五个标签共同指向这五条红线，表明它们
// 属于同一能级簇； 中间红色组：两条红色水平线，左侧标签
// 为“6̄_c ⊗ 1_f”和“3_c ⊗ 3_f”，分别指向这两条线； 下方绿
// 色组：一条绿色水平线，左侧标签为“3_c ⊗ 2_f”； 更下方绿
// 色组：一条绿色水平线，左侧标签为“3̄_c ⊗ 2_f”； 最底部
// 蓝色组：一条蓝色水平线，左侧标签为“1_c ⊗ 1_f”，右侧标
// 注“|Ω⟩”。 第三个区域顶部标注“g² = 1.5, h² = 0”，显示随
// 着g²增大，能级进一步移动或重组： 最上方红色组：仍为五
// 条红色水平线，但整体位置比前一区域更高，右侧标注“|π⟩”
// 和“|σ⟩”，分别指向最上两条线； 中间红色组：两条红色水平
// 线，位置略高于前一区域，右侧均标注“|edge⟩”； 绿色组：
// 原“3_c ⊗ 2_f”对应的绿色线消失，仅保留“3̄_c ⊗ 2_f”对应
// 的绿色线，其位置基本不变，右侧标注“|edge⟩”； 蓝色组：“
// 1_c ⊗ 1_f”对应的蓝色线保持原位，右侧仍标注“|Ω⟩”。 各区
// 域间用黑色箭头连接，指示能级演化路径： 从第一区域的“
// 66_{SU(12)}”红线上引出多条箭头，分别指向第二区域中“6_c
// ⊗ 1_f”及下方四个组合态所对应的五条红线； 从第一区域的“
// 12_{SU(12)}”绿线上引出一条箭头，指向第二区域中“3_c ⊗
// 2_f”对应的绿线； 从第一区域的“1_{SU(12)}”蓝线上引出一
// 条箭头，指向第二区域中“1_c ⊗ 1_f”对应的蓝线； 在第二到
// 第三区域之间，“6_c ⊗ 1_f”等五条红线整体向上平移并略有
// 分散；“6̄_c ⊗ 1_f”和“3_c ⊗ 3_f”对应的两条红线也向上平
// 移；“3_c ⊗ 2_f”对应的绿线消失；“3̄_c ⊗ 2_f”对应的绿线
// 位置不变；“1_c ⊗ 1_f”对应的蓝线位置不变。 图中所有线条
// 均为实线，颜色编码如下：红色代表含夸克-反夸克对的激发
// 态（如介子态），绿色代表边缘态（edge states），蓝色代
// 表基态或单重态（如Ω粒子）。所有文本标注使用正体拉丁字
// 母与数学符号，字体大小统一，布局清晰。 该图传达的核心
// 趋势是：当g²从零增加到1.5时，原本简并的SU(12)多重态发
// 生分裂，形成SU(3)_c ⊗ SU(2)_f下的不同不可约表示；除反
// 夸克主导的态（如|Ω⟩）外，其余所有态的质量随g²增大而升
// 高；同时，某些态（如|π⟩、|σ⟩、|edge⟩）在高g²极限下被明
// 确标识，暗示其在物理上的重要性或稳定性。
#figure(image("imgs/SpectrumDegeneracyg.png", width: 12cm),
  caption: [
    The spectrum of the Hamiltonian as $g$ increases for $h = 0$. When $g = h = 0$ there is an exact $S U ( 12 )$ symmetry and the $sigma$- and $pi$-mesons are a part of the antisymmetric $upright(bold(66))$ irrep. When $g > 0$ but $h = 0$ the spectrum splits into irreps of global $S U ( 3 )_c ⊗ S U ( 2 )_f$, and non-singlet color states remain in the low-lying spectrum. Increasing $g$ shifts all but the antiquark $| upright("edge") chevron.r$ (states) to higher mass.
  ]
)
<fig:specDegeng>

@fig:specDegenh and @fig:specDegeng reveal the near-degeneracy of the $sigma$- and $pi$-mesons throughout the range of couplings $g$ and $h$, suggesting another approximate symmetry, which can be understood in the small and large $g$ limits. For small $g^2$, the effect of $H_(e l) = g^2 / 2 ( Q_(0 , u)^(( a )) + Q_(0 , d)^(( a )) )^2$ on the the $S U ( 12 )$-symmetric spectrum can be obtained through perturbation theory. To first order in $g^2$, the shift in the energy of any state is equal to the expectation value of $H_(e l)$. The $sigma$- and $pi$-meson states are both quark-antiquark states in the #strong[66] irrep of $S U ( 12 )$, and therefore, both have a $upright(bold(3))_c$ color charge on the quark site and receive the same mass shift.#footnote[This also explains why there are three other states nearly degenerate with the mesons, as seen in @fig:specDegenh. Each of these states carry a $upright(bold(3))_c$ or $overline(upright(bold(3)))_c$ color charge on the quark site and consequently have the same energy at first order in perturbation theory.] For large $g^2$, the only finite-energy excitations of the trivial vacuum (all sites unoccupied) are bare baryons and antibaryons, and the spectrum is one of non-interacting color-singlet baryons. Each quark (antiquark) site hosts $4$ distinct baryons (antibaryons) in correspondence with the multiplicity of the $I = 3 / 2$ irrep. As a result, the $sigma$, $pi$, $I = 2 , 3$ mesons, deuteron and antideuteron are all degenerate.

The $sigma$- and $pi$-meson mass splitting is shown in @fig:PiSigSplit and has a clear maxima for $g tilde 2.4$. Intriguingly, this corresponds to the maximum of the linear entropy between quark and antiquarks (as discussed in @sec:eigenent), and suggests a connection between symmetry, via degeneracies in the spectrum, and entanglement. This shares similarities with the correspondence between Wigner's $S U ( 4 )$ spin-flavor symmetry~@PhysRev.51.106 @PhysRev.51.947 @PhysRev.56.519, which becomes manifest in low-energy nuclear forces in the large-$N_c$ limit of QCD~@Kaplan:1995yg @Kaplan:1996rk, and entanglement suppression in nucleon-nucleon scattering found in Ref.~@Beane:2018oxh (see also Refs.~@Beane:2021zvo @Low:2021ufv @Beane:2020wjl).

// [figvision-cn] imgs/PiSigSplit.png
// 该图像包含两个并排的子图，分别标记为左侧面板和右侧面板。
// 左侧子图： 子图类型：二维曲线图。 顶部标题文字：“L = 1
// ”。 纵坐标轴名称：“M_π - M_σ”，表示π介子与σ介子的质量
// 差；刻度范围从0到0.15，主刻度线及标签位于0、0.05、0.10
// 和0.15处，无明确单位标注（通常默认为GeV或无量纲化后的
// 相对质量单位）。 横坐标轴名称：“g”，表示耦合常数；刻度
// 范围从0到4，主刻度线及标签位于1、2、3、4处，原点0未标
// 出但可见。 曲线特征：一条连续平滑的蓝色实线，起始于g≈
// 0.5时接近零的位置，随g增大而上升，在g≈2.5处达到峰值约
// 0.15，随后下降，在g=4处降至约0.035。 图中无其他符号、
// 色标或多条曲线。 趋势说明：当轨道角动量量子数L=1时，π
// 介子与σ介子的质量差随耦合常数g先增后减，在g≈2.5附近出
// 现最大值，表明在此耦合强度下两种介子的质量分裂最显著。
// 右侧子图： 子图类型：二维曲线图。 顶部标题文字：“L = 2
// ”。 纵坐标轴名称：“M_π - M_σ”，含义同左图；刻度范围、
// 主刻度位置及标签完全相同（0至0.15，间隔0.05）。 横坐标
// 轴名称：“g”，含义同左图；刻度范围、主刻度位置及标签完
// 全相同（0至4，整数标记）。 曲线特征：一条连续平滑的蓝
// 色实线，形状与左图高度相似——起始于g≈0.5时接近零，上升
// 至g≈2.5处达峰值约0.15，再下降至g=4处约0.035。 图中无其
// 他符号、色标或多条曲线。 趋势说明：当轨道角动量量子数L
// =2时，π介子与σ介子的质量差同样随g呈现先增后减的非单调
// 行为，峰值位置和幅度与L=1情形几乎一致，暗示在该模型中
// 质量分裂对L值不敏感或在所绘范围内变化极小。 整体结论：
// 两张子图共同展示在不同轨道角动量态（L=1和L=2）下，π介
// 子与σ介子的质量差作为耦合常数g的函数均表现出相同的非单
// 调依赖关系，且在g≈2.5时达到最大分裂值~0.15，说明该质量
// 分裂现象主要由耦合强度驱动，而非由轨道角动量主导。
#figure(image("imgs/PiSigSplit.png", width: 14cm),
  caption: [
    The mass splitting between the $sigma$- and $pi$-mesons for $L = 1$ (left panel) and $L = 2$ (right panel).
  ]
)
<fig:PiSigSplit>

Color singlet baryons are also present in this system, formed by contracting the color indices of three quarks with a Levi-Civita tensor (and antibaryons are formed from three antiquarks). A baryon is composed of three $I = 1 / 2$ quarks in the (symmetric) $I = 3 / 2$ configuration and in a (antisymmetric) color singlet. It will be referred to as the $Delta$, highlighting its similarity to the $Delta$-resonance in $3 + 1$D QCD. Interestingly, there is an isoscalar $Delta Delta$ bound state, which will be referred to as the deuteron. The existence of a deuteron makes this system valuable from the standpoint of quantum simulations of the formation of nuclei in a model of reduced complexity. The mass of the $Delta$, $M_Delta$, and the binding energy of the deuteron, $B_(Delta Delta) = 2 M_Delta - M_(Delta Delta)$, are shown in @tab:specBneq0 for a range of strong couplings.

#figure(
  align(center)[#table(
    columns: 3,
    align: (center,left,left,),
    table.header(table.cell(align: center, colspan: 3)[$L = 1$],),
    table.hline(),
    [$g^2$], [$M_Delta$], [$B_(Delta Delta)$],
    [8], [3.10], [$2.61 times 10^(- 4)$],
    [4], [3.16], [$5.48 times 10^(- 4)$],
    [2], [3.22], [$6.12 times 10^(- 4)$],
    [1], [3.27], [$3.84 times 10^(- 4)$],
    [1/2], [3.31], [$1.61 times 10^(- 4)$],
    [1/4], [3.33], [$5.27 times 10^(- 5)$],
    [1/8], [3.34], [$1.52 times 10^(- 5)$],
  )]
  , caption: [ The mass of the $Delta$ and the binding energy of the deuteron in $1 + 1$D QCD with $N_f = 2$ for systems with $L = 1 , 2$ spatial sites.]
  , kind: table
  )

#block[]
#figure(
  align(center)[#table(
    columns: 3,
    align: (center,left,left,),
    table.header(table.cell(align: center, colspan: 3)[$L = 2$],),
    table.hline(),
    [$g^2$], [$M_Delta$], [$B_(Delta Delta)$],
    [8], [3.10], [$2.50 times 10^(- 4)$],
    [4], [3.16], [$4.95 times 10^(- 4)$],
    [2], [3.21], [$5.07 times 10^(- 4)$],
    [1], [3.24], [$4.60 times 10^(- 4)$],
    [1/2], [3.25], [$1.53 times 10^(- 3)$],
    [1/4], [3.23], [$3.91 times 10^(- 3)$],
    [1/8], [3.20], [$3.35 times 10^(- 3)$],
  )]
  , caption: [ The mass of the $Delta$ and the binding energy of the deuteron in $1 + 1$D QCD with $N_f = 2$ for systems with $L = 1 , 2$ spatial sites.]
  , kind: table
  )
<tab:specBneq0>

Understanding and quantifying the structure of the lowest-lying hadrons is a priority for nuclear physics research~@LongRangePlan. Great progress has been made, experimentally, analytically and computationally, in dissecting the mass and angular momentum of the proton (see, for example, Refs.~@deFlorian:2009vb @Nocera:2014gqa @COMPASS:2015mhb @Yang:2018nqn @Alexandrou:2020sml @Ji:2021mtz @Wang:2021vqy @Lorce:2021xku). This provides, in part, the foundation for anticipated precision studies at the future electron-ion collider (EIC)~@Boer:2011fh @Accardi:2012qut at Brookhaven National Laboratory. Decompositions of the vacuum energy and the masses of the $sigma$, $pi$ and $Delta$ are shown in @fig:massdeco where, for example, the chromo-electric contribution to the $sigma$ is $chevron.l H_(e l) chevron.r = chevron.l sigma | H_(e l) | sigma chevron.r - chevron.l Omega | H_(e l) | Omega chevron.r$. These calculations demonstrate the potential of future quantum simulations in being able to quantify decompositions of properties of the nucleon, including in dense matter. For the baryon states, it is $H_(e l)$ that is responsible for the system coalescing into localized color singlets in order to minimize the energy in the chromo-electric field (between spatial sites).

// [figvision-cn] imgs/L2MassBreakdown.png
// 该图像由四个并列的垂直条形图组成，从左到右依次排列，每
// 个子图代表一种不同的物理系统或粒子状态。所有子图共享相
// 同的纵坐标轴，横坐标为类别轴，未标注具体刻度。 纵坐标
// 轴（Y轴）： 名称：Energy（能量） 范围：从 -3 到 +3 单
// 位：未明确标出，但根据上下文应为无量纲化后的能量单位（
// 如以某基准质量归一化） 刻度标记：整数刻度 -3, -2, -1,
// 0, 1, 2, 3，每格间隔为1 每个子图中包含多个彩色矩形条，
// 代表哈密顿量中不同项对总能量的贡献。各颜色与符号对应关
// 系如下： 蓝色条：⟨Hₘ⟩ —— 质量项贡献 绿色条：⟨Hₖᵢₙ⟩ ——
// 动能项贡献 黄色条：⟨Hₑₗ⟩ —— 色电场项贡献 红色条：总能
// 量值（E_Ω、M_σ、M_π、M_Δ），即上述三项之和 子图 a（最
// 左侧）： 类型：堆叠条形图（非堆叠，独立柱状表示各项贡
// 献及总和） 内容：真空能量分解（E_Ω） 标注文字： 蓝色条
// 上方标注 ⟨Hₘ⟩ 绿色条下方标注 ⟨Hₖᵢₙ⟩ 黄色条上方标注 ⟨Hₑ
// ₗ⟩ 红色条右侧标注 E_Ω 数值近似： ⟨Hₘ⟩ ≈ +1.0 （蓝色条
// 高度至+1） ⟨Hₖₙ⟩ ≈ -2.8 （绿色条底部接近-3，顶部在-2.8
// 左右） ⟨Hₑ⟩ ≈ +0.6 （黄色条高度约+0.6） E_Ω ≈ -1.2 （
// 红色条底部约-1.2，顶部在0以下） 结论：真空能量主要由负
// 的动能项主导，质量项和色电场项为正贡献，三者相加得负总
// 能量。 子图 b（左二）： 类型：独立条形图 内容：σ介子质
// 量 M_σ 的分解 标注文字： 蓝色条上方标注 ⟨Hₘ⟩ 绿色条下
// 方标注 ⟨Hₖᵢₙ⟩ 黄色条上方标注 ⟨Hₑ⟩ 红色条右侧标注 M_σ
// 数值近似： ⟨Hₘ⟩ ≈ +2.2 ⟨Hₖᵢₙ⟩ ≈ +0.2 ⟨Hₑ⟩ ≈ +0.7 M_σ ≈
// +3.1 结论：σ介子质量主要来源于质量项，动能和色电场项均
// 为正的小幅贡献，总质量为正且较大。 子图 c（右二）： 类
// 型：独立条形图 内容：π介子质量 M_π 的分解 标注文字：
// 蓝色条上方标注 ⟨Hₘ⟩ 绿色条下方标注 ⟨Hₖᵢₙ⟩ 黄色条上方标
// 注 ⟨Hₑₗ⟩ 红色条右侧标注 M_π 数值近似： ⟨Hₘ⟩ ≈ +2.1 ⟨Hₖ
// ₙ⟩ ≈ +0.2 ⟨Hₑ⟩ ≈ +0.5 M_π ≈ +2.8 结论：π介子质量同样以
// 质量项为主，动能和色电场项贡献较小但为正，总质量略低于
// σ介子。 子图 d（最右侧）： 类型：独立条形图 内容：Δ重
// 子质量 M_Δ 的分解 标注文字： 蓝色条上方标注 ⟨Hₘ⟩ 绿色
// 条下方标注 ⟨Hₖᵢₙ⟩ 黄色条上方标注 ⟨Hₑₗ⟩ 红色条右侧标注
// M_Δ 数值近似： ⟨Hₘ⟩ ≈ +2.2 ⟨Hₖₙ⟩ ≈ +0.3 ⟨Hₑ⟩ ≈ +0.4 M_
// Δ ≈ +2.9 结论：Δ重子质量结构与π类似，质量项占主导，动
// 能和色电场项贡献微小，总质量介于π与σ之间。 整体趋势：
// 在所有强子态（σ、π、Δ）中，质量项 ⟨Hₘ⟩ 是主要正贡献源，
// 动能项 ⟨Hₖᵢₙ⟩ 和色电场项 ⟨Hₑ⟩ 贡献较小且为正。 真空态
// （子图a）是唯一具有显著负动能贡献的系统，导致其总能量
// 为负。 各强子质量大小顺序为：M_σ > M_Δ > M_π，反映其内
// 部结构差异。 所有计算基于轴向规范下的D QCD模型，参数设
// 定为特定耦合常数与夸克质量组合（原文提及“for D QCD
// with and ”，但未给出具体数值，故此处不补充）。 注：图
// 中无比例尺、无成像通道信息（因非显微图）、无流程图或相
// 图元素；所有图形均为定量条形图，用于展示能量分项构成。
#figure(image("imgs/L2MassBreakdown.png", width: 100%),
  caption: [
    The decomposition of vacuum energy ($E_Omega$) and the masses of the lightest hadrons ($M_sigma$, $M_pi$ and $M_Delta$) into contributions from the mass, the kinetic and the chromo-electric field terms in the Hamiltonian, defined in axial gauge, for $1 + 1$D QCD with $N_f = L = 2$ and $m = g = 1$.
  ]
)
<fig:massdeco>

The deuteron binding energy is shown in the left panel of @fig:deutBE as a function of $g$. While the deuteron is unbound at $g = 0$ for obvious reasons, it is also unbound at large $g$ because the spectrum is that of non-interacting color-singlet (anti)baryons. Therefore, the non-trivial aspects of deuteron binding for these systems is for intermediate values of $g$. The decomposition of $B_(Delta Delta)$ is shown in the right panel of @fig:deutBE, where, for example, the chromo-electric contribution is

$ chevron.l H_(e l) chevron.r = 2 ( chevron.l Delta | H_(e l) | Delta chevron.r - chevron.l Omega | H_(e l) | Omega chevron.r ) - ( chevron.l Delta Delta | H_(e l) | Delta Delta chevron.r - chevron.l Omega | H_(e l) | Omega chevron.r ) med . $<eq:deutBEdec>

The largest contribution to the binding energy is $chevron.l H_(k i n) chevron.r$, which is the term responsible for creating $q overline(q)$ pairs. This suggests that meson-exchange may play a significant role in the attraction between baryons, as is the case in $3 + 1$D QCD, but larger systems will need to be studied before definitive conclusions can be drawn. One consequence of the lightest baryon being $I = 3 / 2$ is that, for $L = 1$, the $I_3 = + 3 / 2$ state completely occupies the up-quark sites. Thus the system factorizes into an inert up-quark sector and a dynamic down-quark sector, and the absolute energy of the lowest-lying baryon state can be written as $E_Delta = M_Delta + E_Omega^(2 f) = 3 m + E_Omega^(1 f)$, where $E_Omega^(1 , 2 f)$ is the vacuum energy of the $N_f = 1 , 2$ flavor systems. Analogously, the deuteron absolute energy is $E_(Delta Delta) = 6 m$, and therefore the deuteron binding energy can be written as $B_(Delta Delta) = 2 ( 3 m + E_Omega^(1 f) - E_Omega^(2 f) ) - ( 6 m - E_Omega^(2 f) ) = 2 E_Omega^(1 f) - E_Omega^(2 f)$. This is quite a remarkable result because, in this system, the deuteron binding energy depends only on the difference between the $N_f = 1$ and $N_f = 2$ vacuum energies, being bound when $2 E_Omega^(1 f) - E_Omega^(2 f) > 0$. As has been discussed previously, it is the $q overline(q)$ contribution from this difference that dominates the binding.

// [figvision-cn] imgs/BECombined.png
// 该图由左右两个面板组成，分别展示氘核结合能随耦合常数的
// 变化及其在特定参数下的能量分解。 左面板为曲线图，标题
// 为“L = 2”。横轴标记为g，范围从0到3.0，刻度间隔为0.5；
// 纵轴标记为B_ΔΔ，范围从0到0.004，刻度间隔为0.001。图中
// 有一条蓝色实线，表示在轨道角动量量子数L=2条件下，氘核
// 结合能B_ΔΔ随无量纲耦合常数g的变化关系。曲线从g=0处接近
// 零开始迅速上升，在g≈0.5附近达到峰值约0.0042，随后急剧
// 下降至g=1.0时约为0.0006，之后缓慢衰减，在g=3.0时降至约
// 0.0003。该曲线表明结合能在中等耦合强度下出现显著共振增
// 强效应。 右面板为柱状图，标题为“B_ΔΔ for g = 1”，用于
// 展示当g=1时总结合能B_ΔΔ的哈密顿量贡献分解。纵轴标记为
// Energy，范围从-0.001到+0.002，以0.000为基准线。图中包
// 含四个垂直条形：第一个为深蓝色向下延伸的矩形，标注为⟨
// H_m⟩，其值约为-0.0015，代表质量项贡献；第二个为绿色向
// 上延伸的矩形，标注为⟨H_kin⟩，高度约0.0023，代表动能项
// 贡献；第三个为黄色向下延伸的矩形，标注为⟨H_el⟩，深度约
// -0.0008，代表电磁相互作用项贡献；第四个为红色向上延伸
// 的矩形，标注为B_ΔΔ，高度约0.0005，代表最终净结合能。所
// 有条形均从y=0基线出发，正负方向分别表示能量增加或减少。
// 该图传达出在g=1时，尽管存在负的静质量和电磁修正，但巨
// 大的正动能项主导了系统行为，最终形成微弱的正结合能。
#figure(image("imgs/BECombined.png", width: 14cm),
  caption: [
    The left panel shows the deuteron binding energy, $B_(Delta Delta)$, for $m = 1$ and $L = 2$. The right panel shows the decomposition of $B_(Delta Delta)$ into contributions from the Hamiltonian for $g = 1$.
  ]
)
<fig:deutBE>

=== The Low-Lying Spectrum Using D-Wave's Quantum Annealers
<sec:dwave_spectrum>
The low-lying spectrum of this system can also be determined through annealing by using D-Wave's quantum annealer (QA) `Advantage`~@DwaveLeap, a device with 5627 superconducting flux qubits, with a 15-way qubit connectivity via Josephson junctions rf-SQUID couplers~@PhysRevB.80.052506. Not only did this enable the determination of the energies of low-lying states, but it also assessed the ability of this quantum device to isolate nearly degenerate states. The time-dependent Hamiltonian of the device, which our systems are to be mapped, are of the form of an Ising model, with the freedom to specify the single- and two-qubit coefficients. Alternatively, the Ising model can be rewritten in a quadratic unconstrained binary optimization (QUBO) form, $f_Q ( x ) = sum_(i j) Q_(i j) x_i x_j$, where $x_i$ are binary variables and $Q_(i j)$ is a QUBO matrix, which contains the coefficients of single-qubit ($i = j$) and two-qubit ($i eq.not j$) terms. The QUBO matrix is the input that is submitted to `Advantage`, with the output being a bit-string that minimizes $f_Q$. Due to the qubit connectivity of `Advantage`, multiple physical qubits are chained together to recover the required connectivity, limiting the system size that can be annealed.

The QA `Advantage` was used to determine the lowest three states in the $B = 0$ sector of the $L = 1$ system, with $m = g = 1$ and $h = 2$, following techniques presented in Ref.~@Illa:2022jqb. In that work, the objective function to be minimized is defined as $F = chevron.l Psi | tilde(H) | Psi chevron.r - eta chevron.l Psi | Psi chevron.r$ @doi:10.1021-acs.jctc.9b00402, where $eta$ is a parameter that is included to avoid the null solution, and its optimal value can be iteratively tuned to be as close to the ground-state energy as possible. The wavefunction is expanded in a finite dimensional orthonormal basis $psi_alpha$, $| Psi chevron.r = sum_alpha^(n_s) a_alpha | psi_alpha chevron.r$, which in this case reduces the dimensionality of $H$ to $88$, defining $tilde(H)$, thus making it feasible to study with `Advantage`. The procedure to write the objective function in a QUBO form can be found in Ref.~@Illa:2022jqb (and briefly described in App.~@app:dwave), where the coefficients $a_alpha$ are digitized using $K$ binary variables@app:dwave/acs.jctc.9b00402, and the adaptive QA eigenvalue solver is implemented by using the zooming method~@Chang:2019 @ARahman:2021ktn. To reduce the uncertainty in the resulting energy and wavefunction, due to the noisy nature of this QA, the iterative procedure described in Ref.~@Illa:2022jqb was used, where the (low-precision) solution obtained from the machine after several zooming steps constituted the starting point of a new anneal. This led to a reduction of the uncertainty by an order of magnitude (while effectively only doubling the resources used).

Results obtained using `Advantage` are shown in @fig:QAresults, where the three panels show the convergence of the energy of the vacuum state (left), the mass of the $sigma$-meson (center) and the mass of the $pi$-meson (right) as a function of zoom steps, as well as comparisons to the exact wavefunctions. The bands in the plot correspond to 68% confidence intervals determined from 20 independent runs of the annealing workflow, where each corresponds to $10^3$ anneals with an annealing time of $t_A = 20 mu$s, and the points correspond to the lowest energy found by the QA. The parameter $K$ in the digitization of $a_alpha$ is set to $K = 2$. The parameter $eta$ is first set close enough to the corresponding energy (e.g., $eta = 0$ for the ground-state), and for the subsequent iterative steps it is set to the lowest energy found in the previous step. The first two excited states are nearly degenerate, and after projecting out the ground-state state, `Advantage` finds both states in the first step of the iterative procedure (as shown by the yellow lines in the $pi$ wavefunction of @fig:QAresults). However, after one iterative step, the QA converges to one of the two excited states. It first finds the second excited state (the $pi$-meson), and once this state is known with sufficient precision, it can be projected out to study the other excited state. The converged values for the energies and masses of these states are shown in @tab:QAresults, along with the exact results. The uncertainties in these values should be understood as uncertainties on an upper bound of the energy (as they result from a variational calculation). For more details see App.~@app:dwave.

// [figvision-cn] imgs/AdvantageConvergence_2.png
// 该图由三个水平排列的子图组成，分别标记为左、中、右，对
// 应于不同的物理态。所有子图共享相同的横轴定义和颜色编码
// 方案。 左侧子图（a）： 类型：双Y轴曲线图。 标题：顶部
// 中央标注为 $|\Omega\rangle$。 左上角图标：一个立方体示
// 意图，其中一个顶点被高亮并标记为 $\alpha$。 横轴：名称
// 为“zoom steps”，范围从0到80，刻度标记为0, 10, 20, 40,
// 60, 80。在横坐标20处有一条垂直的灰色分隔线，将图表分为
// 左右两个区域。 左纵轴：名称为 $E_{\pi}^{\text{dev}} -
// E_{\pi}^{\text{exact}}$，采用对数标度，范围从 $10^{-5}
// $ 到 $10^{1}$，主刻度标记为 $10^{-5}, 10^{-3}, 10^{-1}
// , 10^{1}$。 右纵轴：名称为 $a_{\sigma}$，采用线性标度，
// 范围从-0.2到0.8，主刻度标记为-0.2, 0.0, 0.2, 0.4, 0.6,
// 0.8。 数据曲线与色标：图中包含一系列离散点构成的曲线，
// 颜色从底部的深紫色渐变至顶部的黄色。这些颜色代表迭代过
// 程中的不同步数（步骤）。 趋势描述：在横轴0到20的区间内，
// 左侧Y轴对应的能量差值随“zoom steps”增加而呈指数级下降。
// 深紫色曲线位于最底部，数值最低；黄色曲线位于最顶部，数
// 值最高。在横轴大于20的区域，数据表现为围绕0上下剧烈波
// 动的杂乱线条，对应右侧Y轴的 $a_{\sigma}$ 值。 中间子图
// （b）： 类型：双Y轴曲线图。 标题：顶部中央标注为 $|\
// sigma\rangle$。 左上角图标：与左图相同，为一个标记有 $
// \alpha$ 的立方体。 横轴：名称为“zoom steps”，范围从0到
// 80，刻度标记为0, 10, 20, 40, 60, 80。同样在横坐标20处
// 有一条垂直的灰色分隔线。 左纵轴：名称为 $M_{\sigma}^{\
// text{dev}} - M_{\sigma}^{\text{exact}}$，采用对数标度，
// 范围从 $10^{-5}$ 到 $10^{1}$，主刻度标记为 $10^{-5},
// 10^{-3}, 10^{-1}, 10^{1}$。 右纵轴：名称为 $a_{\sigma}
// $，采用线性标度，范围从-0.4到0.4，主刻度标记为-0.4,
// -0.2, 0.0, 0.2, 0.4。 数据曲线与色标：颜色编码与左图一
// 致，从深紫到黄。 趋势描述：在横轴0到20区间，左侧Y轴对
// 应的质量差值随“zoom steps”增加而迅速下降，呈现阶梯状收
// 敛特征。在横轴大于20的区域，数据表现为围绕0上下大幅振
// 荡的线条，对应右侧Y轴的 $a_{\sigma}$ 值，振幅较左图更
// 大。 右侧子图（c）： 类型：双Y轴曲线图。 标题：顶部中
// 央标注为 $|\pi\rangle$。 左上角图标：与前两图相同。 横
// 轴：名称为“zoom steps”，范围从0到80，刻度标记为0, 10,
// 20, 40, 60, 80。在横坐标20处有一条垂直的灰色分隔线。
// 左纵轴：名称为 $M_{\pi}^{\text{dev}} - M_{\pi}^{\text{
// exact}}$，采用对数标度，范围从 $10^{-6}$ 到 $10^{0}$，
// 主刻度标记为 $10^{-6}, 10^{-4}, 10^{-2}, 10^{0}$。 右
// 纵轴：名称为 $a_{\sigma}$，采用线性标度，范围从-0.4到
// 0.4，主刻度标记为-0.4, -0.2, 0.0, 0.2, 0.4。 数据曲线
// 与色标：颜色编码与前两图一致。 趋势描述：在横轴0到20区
// 间，左侧Y轴对应的质量差值随“zoom steps”增加而下降。值
// 得注意的是，在横轴约15附近，部分曲线出现明显的波动或震
// 荡行为。在横轴大于20的区域，数据表现为围绕0上下剧烈振
// 荡的线条，对应右侧Y轴的 $a_{\sigma}$ 值。
#figure(image("imgs/AdvantageConvergence_2.png", width: 100%),
  caption: [
    Iterative convergence of the energy, masses and wavefunctions for the three lowest-lying states in the $B = 0$ sector of $1 + 1$D QCD with $N_f = 2$ and $m = g = L = 1$: vacuum (left), $sigma$-meson (center) and $pi$-meson (right). The different colors correspond to different steps of the iterative procedure that is described in the main text. The oscillatory behavior seen in the right panel around the 15th zoom step is discussed in App.~@app:dwave. The blue icons in the upper right indicate that this calculation was done on a quantum device~@Klco:2019xro.
  ]
)
<fig:QAresults>

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: (center, left, right, right, right),
    inset: (x: 6pt, y: 3pt),
    stroke: none,
    table.cell(colspan: 5, align: center)[$L = 1$],
    table.hline(),
    [], [], table.cell(align: center)[$|Omega chevron.r$], table.cell(align: center)[$|sigma chevron.r$], table.cell(align: center)[$|pi chevron.r$],
    table.hline(),
    [Exact], [Energy], [$-0.5491067$], [$2.177749$], [$2.1926786$],
    table.hline(start: 1),
    [], [Mass], [-], [$2.726855$], [$2.7417853$],
    table.hline(),
    [#raw("Advantage")], [Energy], [$-0.5491051(6)$], [$2.177760(4)$], [$2.1926809(7)$],
    table.hline(start: 1),
    [], [Mass], [-], [$2.726865(4)$], [$2.7417860(9)$],
    table.hline(),
  )],
  caption: [Energies and masses of the three lowest-lying states in the $B = 0$ sector of $1 + 1$D QCD with $N_f = 2$ and $m = g = L = 1$. Shown are the exact results from diagonalization of the Hamiltonian matrix and those obtained from D-Wave's #raw("Advantage").],
  kind: table,
) <tab:QAresults>

=== Quark-Antiquark Entanglement in the Spectra via Exact Diagonalization
<sec:eigenent>
With $h gt.double g$, the eigenstates of the Hamiltonian are color singlets and irreps of isospin. As these are global quantum numbers (summed over the lattice) the eigenstates are generically entangled among the color and isospin components at each lattice site. With the hope of gaining insight into $3 + 1$D QCD, aspects of the entanglement structure of the $L = 1$ wavefunctions are explored via exact methods. An interesting measure of entanglement for these systems is the linear entropy between quarks and antiquarks, defined as

$ S_L = 1 - "Tr" [ rho_q^2 ] med , $

where $rho_q = "Tr"_(overline(q)) [ rho ]$ and $rho$ is a density matrix of the system. Shown in @fig:m1N2Linent is the linear entropy between quarks and antiquarks in $| Omega chevron.r$, $| sigma chevron.r$, $| pi_(I_3 = 1) chevron.r$ and $| Delta_(I_3 = 3 / 2) chevron.r$ as a function of $g$.

// [figvision-cn] imgs/m1B1LinearEntCombined.png
// 该图由四个独立的二维曲线子图组成，排列成两行两列的网格
// 布局。所有子图共享相同的坐标轴定义：横轴表示参数 g，范
// 围从 0 到 6，刻度标记为整数 1, 2, 3, 4, 5, 6；纵轴表示
// 夸克与反夸克之间的线性熵 S_L，数值范围因图而异。每个子
// 图中均绘制了一条蓝色实线，代表在特定量子态下 S_L 随 g
// 变化的函数关系。 左上角子图（a）： 子图类型：曲线图 标
// 题标注：|Ω⟩ 纵轴范围：S_L 从 0.00 至约 0.48，刻度标记
// 为 0.10, 0.20, 0.30, 0.40 曲线行为：当 g=0 时，S_L ≈
// 0.47；随着 g 增大，S_L 单调递减，在 g≈3 后趋于平缓，g=
// 6 时 S_L < 0.05。整体呈光滑下降趋势，无局部极值。 结论：
// 在 |Ω⟩ 态下，线性熵随耦合强度 g 增加而持续降低，表明系
// 统纠缠度减弱。 右上角子图（b）： 子图类型：曲线图 标题
// 标注：|ΔI₃=3/2⟩ 纵轴范围：S_L 从 0.00 至 0.25，刻度标
// 记为 0.05, 0.10, 0.15, 0.20, 0.25 曲线行为：g=0 时 S_L
// ≈ 0.26；随 g 增大迅速下降，g=2 时降至约 0.08，g≥4 后接
// 近零。下降速率较左上图更快。 结论：在 |ΔI₃=3/2⟩ 态下，
// 线性熵对 g 更敏感，快速衰减至近零，暗示强耦合下几乎无
// 纠缠。 左下角子图（c）： 子图类型：曲线图 标题标注：|σ
// ⟩ 纵轴范围：S_L 从 0.75 至 0.95，刻度标记为 0.80, 0.85
// , 0.90, 0.95 曲线行为：g=0 时 S_L ≈ 0.91；缓慢上升至 g
// ≈2.2 处达到峰值约 0.945；随后急剧下降，g=3 时跌至 0.80，
// g=6 时稳定于约 0.76。存在一个明显局部最大值。 结论：在
// |σ⟩ 态下，线性熵先增后减，表明中等耦合强度下纠缠最强，
// 之后被抑制。 右下角子图（d）： 子图类型：曲线图 标题标
// 注：|π_{I₃=1}⟩ 纵轴范围：S_L 从 0.65 至 0.90，刻度标记
// 为 0.70, 0.75, 0.80, 0.85, 0.90 曲线行为：g<2 时 S_L
// 基本恒定在 0.78；g≈2.5 处出现尖锐峰值，达 0.89；之后陡
// 降，g=4 时已低于 0.70，g=6 时趋近 0.67。峰形窄而高。
// 结论：在 |π_{I₃=1}⟩ 态下，线性熵在 g≈2.5 附近发生共振
// 式增强，显示该态在此耦合强度下具有显著量子关联。 所有
// 子图均未使用图例或符号区分多条曲线，仅含单条蓝色实线。
// 各图标题位于绘图区顶部中央，字体略大于坐标轴标签。坐标
// 轴线为黑色细线，无网格线。图中无比例尺、颜色映射或显微
// 成像元素。
#figure(image("imgs/m1B1LinearEntCombined.png", width: 14cm),
  caption: [
    The linear entropy between quarks and antiquarks in $| Omega chevron.r$, $| Delta_(I_3 = 3 / 2) chevron.r$, $| sigma chevron.r$ and $| pi_(I_3 = 1) chevron.r$ for $m = L = 1$.
  ]
)
<fig:m1N2Linent>

The deuteron is not shown as there is only one basis state contributing for $L = 1$.

The scaling of the linear entropy in the vacuum and baryon with $g$ can be understood as follows. As $g$ increases, color singlets on each site have the least energy density. The vacuum becomes dominated by the unoccupied state and the $Delta$ becomes dominated by the “bare” $Delta$ with all three quarks located on one site in a color singlet. As the entropy generically scales with the number of available states, the vacuum and baryon have decreasing entropy for increasing $g$. The situation for the $pi$ and $sigma$ is somewhat more interesting. For small $g$, their wavefunctions are dominated by $q overline(q)$ excitations on top of the trivial vacuum, which minimizes the contributions from the mass term. However, color singlets are preferred as $g$ increases, and the mesons become primarily composed of baryon-antibaryon ($B overline(B)$) excitations. There are more $q overline(q)$ states than $B overline(B)$ states with a given $I_3$, and therefore there is more entropy at small $g$ than large $g$. The peak at intermediate $g$ occurs at the crossover between these two regimes where the meson has a sizable contribution from both $q overline(q)$ and $B overline(B)$ excitations. To illustrate this, the expectation value of total quark occupation (number of quarks plus the number of antiquarks) is shown in @fig:m1N2Occ. For small $g$, the occupation is near $2$ since the state is mostly composed of $q overline(q)$, while for large $g$ it approaches $6$ as the state mostly consists of $B overline(B)$. This is a transition from the excitations being “color-flux tubes” between quark and antiquark of the same color to bound states of color-singlet baryons and antibaryons.

// [figvision-cn] imgs/m1N2pisigOcc.png
// 该图包含两个并排排列的子图，分别标记为左侧的 $|\sigma\
// rangle$ 和右侧的 $|\pi_{I_3=1}\rangle$。 左侧子图展示
// 的是态 $|\sigma\rangle$ 下的夸克占据数期望值随耦合常数
// 变化的曲线图。 横坐标轴标记为 $g$，代表耦合常数，刻度
// 范围从0到6，标有整数刻度1、2、3、4、5、6。纵坐标轴标记
// 为 Quark Occupation（夸克占据数），刻度范围从1到6，标
// 有整数刻度1至6。图中绘制了一条蓝色实线曲线。当 $g$ 值
// 在0到约1.5之间时，曲线保持平坦，Quark Occupation 的值
// 约为2.5；当 $g$ 值从约1.5增加到约2.8时，曲线呈现陡峭的
// S型上升趋势；当 $g$ 值大于约3时，曲线再次趋于平坦，数
// 值稳定在6左右。这表明随着 $g$ 的增加，该态下的夸克占据
// 数发生了从低值到高值的相变式跃迁。 右侧子图展示的是态
// $|\pi_{I_3=1}\rangle$ 下的夸克占据数期望值随耦合常数变
// 化的曲线图。 其坐标轴设置与左侧子图完全一致：横坐标轴
// 为 $g$，范围0到6；纵坐标轴为 Quark Occupation，范围1到
// 6。图中同样绘制了一条蓝色实线曲线。曲线的走势与左侧子
// 图高度相似：在 $g$ 小于约1.5时，数值维持在约2.5；在 $g
// $ 介于约1.5至2.8之间时迅速上升；在 $g$ 大于约3后，数值
// 饱和于6。这表明对于这两个不同的量子态，夸克占据数随耦
// 合常数 $g$ 的变化表现出相同的行为模式，即在特定的临界
// 耦合强度附近发生急剧变化。
#figure(image("imgs/m1N2pisigOcc.png", width: 14cm),
  caption: [
    The expectation value of quark occupation in the $| sigma chevron.r$ and $| pi_(I_3 = 1) chevron.r$ for $m = L = 1$.
  ]
)
<fig:m1N2Occ>

== Digital Quantum Circuits
<sec:Circuits>
The Hamiltonian for $1 + 1$D QCD with arbitrary $N_c$ and $N_f$, when written in terms of spin operators, can be naturally mapped onto a quantum device with qubit registers. In this section the time evolution for systems with $N_c = 3$ and $N_f = 2$ are developed.

=== Time Evolution
<time-evolution>
To perform time evolution on a quantum computer, the operator $U ( t ) = exp ( - i H t )$ is reproduced by a sequence of gates applied to the qubit register. Generally, a Hamiltonian cannot be directly mapped to such a sequence efficiently, but each of the elements in a Trotter decomposition can, with systematically reducible errors. Typically, the Hamiltonian is divided into Pauli strings whose unitary evolution can be implemented with quantum circuits that are readily constructed. For a Trotter step of size $t$, the circuit that implements the time evolution from the mass term, $U_m ( t ) = exp ( - i H_m t )$, is shown in @circ:Um.

// [figvision-cn] imgs/Nf2CircMass.png
// 该图像为量子电路图，展示了实现质量项时间演化的量子线路
// 结构。图中包含多条水平排列的量子比特线，每条线上放置一
// 个量子门操作框。所有门均为单量子比特旋转门，具体为绕Z
// 轴旋转的门（Rz），其参数根据位置不同分为两种：+mt 和
// -mt。 从顶部开始，第一条量子比特线上的门标注为 Rz(mt)；
// 第二条同样为 Rz(mt)。随后出现三个垂直排列的黑点，表示
// 中间省略了若干条具有相同结构的量子比特线，这些线上均放
// 置 Rz(mt) 门。接着是一条新的量子比特线，其上放置 Rz(
// -mt) 门；下一条也为 Rz(-mt)。再之后是三个垂直黑点，表
// 示又省略了一组具有相同结构的量子比特线，这些线上均放置
// Rz(-mt) 门。最后一条可见的量子比特线上再次放置 Rz(mt)
// 门，其下方仍有三个垂直黑点，暗示电路在底部继续延伸，可
// 能重复某种模式或终止于未显示部分。 所有量子门均以矩形
// 框表示，内部文字清晰标注为 “Rz(mt)” 或 “Rz(-mt)”，其中
// m 代表质量参数，t 代表时间演化时长。正负号表明旋转方向
// 相反，对应于哈密顿量中质量项的不同符号贡献。整个电路呈
// 纵向堆叠布局，无交叉连线或多比特门，说明各量子比特独立
// 演化，仅受各自局部质量项影响。该图传达的核心结论是：质
// 量项的时间演化可通过在每个量子比特上施加特定方向的Z轴
// 旋转来实现，且旋转角度与质量m和时间t成正比，符号由物理
// 模型决定。
#figure(image("imgs/Nf2CircMass.png", height: 30.0%),
  caption: [
    The quantum circuit that implements time evolution by the mass term, $U_m ( t ) = exp ( - i H_m t )$.
  ]
)
<circ:Um>

The staggered mass leads to quarks being rotated by a positive angle and antiquarks being rotated by a negative angle. Only single qubit rotations about the z-axis are required for its implementation, with $R_Z ( theta ) = exp ( - i theta Z / 2 )$. The circuit that implements the evolution from the baryon chemical potential, $mu_B$, $U_(mu_B) ( t ) = exp ( - i H_(mu_B) t )$, is similar to $U_m ( t )$ with $m arrow.r mu_B / 3$, and with both quarks and antiquarks rotated by the same angle. Similarly, the circuit that implements the evolution from the isospin chemical potential, $mu_I$, $U_(mu_I) ( t ) = exp ( - i H_(mu_I) t )$, is similar to $U_m ( t )$ with $m arrow.r mu_I / 2$ and up (down) quarks rotated by a negative (positive) angle.

The kinetic piece of the Hamiltonian, @eq:Hkin2flav, is composed of hopping terms of the form

$ H_(k i n) med tilde med sigma^(+) Z Z Z Z Z sigma^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") med . $<eq:hop>

The $sigma^(+)$ and $sigma^(-)$ operators enable quarks and antiquarks to move between sites with the same color and flavor (create $overline(q)_i^alpha q_alpha^i$ pairs) and the string of $Z$ operators incorporates the signs from Pauli statistics. The circuits for Trotterizing these terms are based on circuits in Ref.~@Stetina:2020abi. We introduce an ancilla to accumulate the parity of the JW string of $Z$s. This provides a mechanism for the different hopping terms to re-use previously computed (partial-)parity.#footnote[An ancilla was used similarly in Ref.~@Qchem2014.] The circuit for the first two hopping terms is shown in @circ:UkinAnc.

// [figvision-cn] imgs/UkinAnc.png
// 这是一张量子电路示意图，展示了用于实现两个连续跃迁项时
// 间演化的量子线路结构。图中包含8条水平排列的量子比特线，
// 从上至下依次标记为：anc（辅助量子比特）、|q0⟩、|q1⟩、|
// q2⟩、|q3⟩、|q4⟩、|q5⟩、|q6⟩、|q7⟩。所有量子门按时间顺
// 序从左到右排列在相应的时间轴上。 子图a（整体电路图）：
// 类型：量子电路示意图。 布局：共9条水平量子比特线，每条
// 线代表一个量子比特或辅助位，垂直方向表示时间演化顺序。
// 左侧区域标注“Initialize ancilla”，覆盖从anc线到|q7⟩线
// 的初始操作部分，用蓝色花括号括起。 中间偏左区域由红色
// 花括号标注表达式：e^(-i t/2 (σ₆⁺ Z₅Z₄Z₃Z₂Z₁ σ₀⁻ + h.c.
// ))，对应一组控制门序列。 右侧区域同样由红色花括号标注
// 表达式：e^(-i t/2 (σ₇⁺ Z₆Z₅Z₄Z₃Z₂ σ₁⁻ + h.c.))，对应另
// 一组控制门序列。 具体门操作： 在anc线上，最左侧有五个
// CNOT门，目标分别为|q0⟩至|q4⟩，控制端均为anc，形成级联
// 结构。 |q0⟩至|q4⟩各有一条黑点连接至下方对应位置的黑点，
// 构成多控非门结构的一部分。 在|q6⟩线上，从左至右依次为：
// Hadamard门（H）、受控Z旋转门R_z(t/2)、受控Z旋转门R_z(
// -t/2)、三个CNOT门（分别作用于|q6⟩与|q5⟩、|q6⟩与|q4⟩、|
// q6⟩与|q3⟩）、另一个Hadamard门（H），最后是一个黑点（可
// 能表示测量或结束）。 在|q7⟩线上，结构与|q6⟩类似：
// Hadamard门（H）、R_z(t/2)、R_z(-t/2)、三个CNOT门（分别
// 作用于|q7⟩与|q6⟩、|q7⟩与|q5⟩、|q7⟩与|q4⟩）、Hadamard门
// （H），最后是一个黑点。 两处浅蓝色高亮框分别包围了右侧
// 两组CNOT门组合：第一组位于|q3⟩和|q4⟩之间，第二组位于|
// q5⟩和|q6⟩之间，每组包含两个CNOT门，控制端在上，目标端
// 在下。 符号说明： “•”表示控制比特，“⊕”表示目标比特上的
// X门（即CNOT门）。 “H”表示Hadamard门。 “R_z(θ)”表示绕Z
// 轴旋转角度θ的单量子比特门。 “+h.c.”表示加上厄米共轭项。
// 结论传达：该电路通过引入辅助量子比特anc并执行特定门序
// 列，实现了两个不同跃迁算符的时间演化，其中第一个涉及σ₆
// ⁺与σ₀⁻之间的相互作用，第二个涉及σ₇⁺与σ₁⁻之间的相互作用，
// 且均耦合多个Z泡利算符链。 无其他子图（b、c等），仅此一
// 图。
#figure(image("imgs/UkinAnc.png", width: 17cm),
  caption: [
    A circuit that implements the time evolution from two sequential hopping terms. Implementing $exp ( - i H_(k i n) t )$ in @eq:Hkin2flav is a straightforward extension of this circuit.
  ]
)
<circ:UkinAnc>

The first circuit operations initialize the ancilla to store the parity of the string of $Z$s between the first and last qubit of the string. Next, the system is evolved by the exponential of the hopping term. After the exponential of each hopping term, the ancilla is modified for the parity of the subsequent hopping term (the CNOTs highlighted in blue). Note that the hopping of quarks, or antiquarks, of different flavors and colors commute, and the Trotter decomposition is exact (without Trotterization errors) over a single spatial site.

Implementation of the time-evolution induced by the energy density in the chromo-electric field, $H_(e l)$, given in @eq:QnfQmfp, is the most challenging due to its inherent non-locality in axial gauge. There are two distinct types of contributions: One is from same-site interactions and the other from interactions between different sites. For the same-site interactions, the operator is the product of charges $Q_(n , f)^(( a )) thin Q_(n , f)^(( a ))$, which contains only $Z Z$ operators, and is digitized with the standard two CNOT circuit.#footnote[Using the native $Z X$ gate on IBM's devices allows this to be done with a single two-qubit entangling gate~@Kim2021ScalableEM.] The $Q_(n , f)^(( a )) thin Q_(m , f')^(( a ))$ operators contain 4-qubit interactions of the form $( sigma^(+) sigma^(-) sigma^(-) sigma^(+) + med upright("h") thin upright(".") thin upright("c") thin upright(".") )$ and 6-qubit interactions of the form $( sigma^(+) Z sigma^(-) sigma^(-) Z sigma^(+) + med upright("h") thin upright(".") thin upright("c") thin upright(".") )$, in addition to $Z Z$ contributions. The manipulations required to implement the 6-qubit operators parallel those required for the 4-qubit operators, and here only the latter is discussed in detail. These operators can be decomposed into eight mutually commuting terms,

$ sigma^(+) sigma^(-) sigma^(-) sigma^(+) + upright("h") thin upright(".") thin upright("c") thin upright(".") = 1 / 8 ( X X X X + Y Y X X + Y X Y X - Y X X Y - X Y Y X + X Y X Y + X X Y Y + Y Y Y Y ) med . $<eq:pmmp>

The strategy for identifying the corresponding time evolution circuit is to first apply a unitary that diagonalizes every term, apply the diagonal rotations, and finally, act with the inverse unitary to return to the computational basis. By only applying diagonal rotations, many of the CNOTs can be arranged to cancel. Each of the eight Pauli strings in @eq:pmmp takes a state in the computational basis to the corresponding bit-flipped state (up to a phase). This suggests that the desired eigenbasis pairs together states with their bit-flipped counterpart, which is an inherent property of the GHZ basis~@Stetina:2020abi. In fact, any permutation of the GHZ state-preparation circuit diagonalizes the interaction. The two that will be used, denoted by $G$ and $tilde(G)$, are shown in @circ:GHZ.

// [figvision-cn] imgs/GHZCirc.png
// 该图包含两个并列的量子电路示意图，分别标记为 G 和 G̃，
// 用于展示两种不同的 GHZ 态制备电路。 左侧子图： 类型：
// 量子电路图（流程图） 布局：四条水平线代表四个量子比特，
// 从上到下编号为 q0, q1, q2, q3。时间从左向右推进。 元件
// 与连接： 在第二条线路（q1）上，最左侧有一个标有“H”的方
// 框，表示对 q1 施加 Hadamard 门。 在 q1 和 q2 之间，有
// 一条垂直连线，起点是 q1 上的实心黑点（控制位），终点是
// q2 上的带加号的圆圈（目标位），表示以 q1 为控制、q2 为
// 目标的 CNOT 门。 在 q1 和 q0 之间，有一条垂直连线，起
// 点是 q1 上的实心黑点，终点是 q0 上的带加号的圆圈，表示
// 以 q1 为控制、q0 为目标的 CNOT 门。 在 q1 和 q3 之间，
// 有一条垂直连线，起点是 q1 上的实心黑点，终点是 q3 上的
// 带加号的圆圈，表示以 q1 为控制、q3 为目标的 CNOT 门。
// 标注文字：左侧写有 “G =”，表明此电路对应算符 G。 物理
// 含义：该电路通过一个 Hadamard 门作用于中间量子比特，随
// 后三个 CNOT 门将纠缠传播至其他三个量子比特，从而制备四
// 粒子 GHZ 态 |0000⟩ + |1111⟩（归一化后）。 右侧子图：
// 类型：量子电路图（流程图） 布局：同样四条水平线代表四
// 个量子比特，从上到下编号为 q0, q1, q2, q3。 元件与连接：
// 在第一条线路（q0）上，最左侧有一个标有“H”的方框，表示
// 对 q0 施加 Hadamard 门。 在 q0 和 q3 之间，有一条垂直
// 连线，起点是 q0 上的实心黑点，终点是 q3 上的带加号的圆
// 圈，表示以 q0 为控制、q3 为目标的 CNOT 门。 在 q0 和
// q1 之间，有一条垂直连线，起点是 q0 上的实心黑点，终点
// 是 q1 上的带加号的圆圈，表示以 q0 为控制、q1 为目标的
// CNOT 门。 在 q1 和 q2 之间，有一条垂直连线，起点是 q1
// 上的实心黑点，终点是 q2 上的带加号的圆圈，表示以 q1 为
// 控制、q2 为目标的 CNOT 门。 标注文字：左侧写有 “G̃ =”，
// 表明此电路对应算符 G̃。 物理含义：该电路先对第一个量子
// 比特施加 Hadamard 门，然后依次用 CNOT 门将纠缠链式传递：
// q0→q3，q0→q1，再 q1→q2，最终也生成四粒子 GHZ 态，但纠
// 缠路径不同。 两个电路均无坐标轴、颜色映射或比例尺，属
// 于纯符号化的量子逻辑门序列图示。所有门均为标准量子门：
// H 为单比特 Hadamard 门，CNOT 由控制点（●）和目标点（⊕）
// 组成。图中未出现任何数值范围或单位，仅表达拓扑结构和操
// 作顺序。
#figure(image("imgs/GHZCirc.png", width: 10cm),
  caption: [
    Two GHZ state-preparation circuits.
  ]
)
<circ:GHZ>

In the diagonal bases, the Pauli strings in @eq:pmmp become

$ G^dagger med ( sigma^(+) sigma^(-) sigma^(-) sigma^(+) + upright("h") thin upright(".") thin upright("c") thin upright(".") ) med G = & med 1 / 8 (I I Z I - Z I Z Z - Z Z Z Z + Z I Z I + I Z Z I - I I Z Z - I Z Z Z + Z Z Z I) med ,\
tilde(G)^dagger med ( sigma^(+) sigma^(-) sigma^(-) sigma^(+) + upright("h") thin upright(".") thin upright("c") thin upright(".") ) med tilde(G) = & med 1 / 8 (I I I Z - I Z Z Z - I I Z Z + Z I I Z + I Z I Z - Z Z Z Z - Z I Z Z + Z Z I Z) med . $<eq:pmmpdiag>

Another simplification comes from the fact that $Z Z$ in the computational basis becomes a single $Z$ in a GHZ basis if the GHZ state-preparation circuit has a CNOT connecting the two $Z$s. For the case at hand, this implies

$ G^dagger med ( I Z Z I + I Z I Z + Z I I Z ) med G = & med I Z I I + I I I Z + Z I I I med ,\
tilde(G)^dagger med ( Z I Z I + I Z Z I + Z I I Z ) med tilde(G) = & med I I Z I + I Z I I + Z I I I med . $<eq:ZZGHZ>

As a consequence, all nine $Z Z$ terms in $Q_(n , f)^(( a )) thin Q_(m , f')^(( a ))$ become single $Z$s in a GHZ basis, thus requiring no additional CNOT gates to implement. Central elements of the circuits required to implement time evolution of the chromo-electric energy density are shown in @circ:UpmmpZZ, which extends the circuit presented in Fig.~4 of Ref.~@Stetina:2020abi to non-Abelian gauge theories.

// [figvision-cn] imgs/pmmpZZ.png
// 该图像包含两个垂直排列的量子电路图，分别展示了实现特定
// 时间演化的两种不同电路结构。 上图： 子图类型：量子电路
// 图。 布局与连接：电路由四条水平平行线组成，代表四个量
// 子比特（从上至下依次编号为0, 1, 2, 3）。时间演化方向从
// 左向右。 左侧部分：标记为 $G^\dagger$。最左端是一个三
// 比特控制门，其中第0、1、3号量子比特作为控制端（空心圆
// 圈），第2号量子比特作为目标端（带加号的圆圈）。紧接着，
// 第1号量子比特上依次作用一个Hadamard门（方框内标有“H”）
// 和三个连续的 $R_z(\alpha)$ 旋转门（方框内标有“$R_z(\
// alpha)$”）。这些单比特门之间穿插着受控非门（CNOT），其
// 控制端在第1号线，目标端分别在第0、2、3号线。 中间部分：
// 标记为 $(\sigma^+\sigma^-\sigma^-\sigma^+ + \text{h.c.
// })$ rotations。这一长段包含一系列交替的 $R_z(\alpha)$
// 和 $R_z(-\alpha)$ 门作用于第1号量子比特，以及相应的
// CNOT门网络。具体序列为：第1号线上的 $R_z(-\alpha)$ 后
// 接CNOT（控制1，目标0），接着是 $R_z(-\alpha)$ 后接CNOT
// （控制1，目标2），然后是 $R_z(-\alpha)$ 后接CNOT（控制
// 1，目标3），最后是 $R_z(\alpha)$ 后接CNOT（控制1，目标
// 0）。 右侧部分：标记为 ZZ rotations 和 $G$。这部分包含
// 三个并排的单比特旋转门，分别作用于第0、2、3号线，参数
// 依次为 $R_z(4\alpha/3)$、$R_z(-2\alpha/3)$ 和 $R_z(-2\
// alpha/3)$。随后是第1号线上的Hadamard门，以及一个三比特
// 控制门，结构与左侧 $G^\dagger$ 相反（第0、1、3号线为目
// 标端，第2号线为控制端，但根据图示符号，实际上是第0、1、
// 3号线上的空心圈连接到第2号线的加号圈，表示多控非门，这
// 里描述为与左侧对称的结构）。 标注文字：底部有三个大括
// 号标注。蓝色大括号括起左侧部分，标注为 $G^\dagger$；红
// 色大括号括起中间部分，标注为 $(\sigma^+\sigma^-\sigma^
// -\sigma^+ + \text{h.c.})$ rotations；绿色大括号括起右
// 侧的三个 $R_z$ 门，标注为 ZZ rotations；最右侧蓝色大括
// 号括起末尾部分，标注为 $G$。 颜色与高亮：图中所有CNOT
// 门的控制点和连线均为黑色，无特殊颜色高亮。但在图注中提
// 到“highlighted in red”，在此图中并未实际显示红色高亮，
// 可能是指代中间红色大括号所涵盖的区域内的CNOTs。 趋势或
// 结论：该电路实现了算符 $\sigma^+\sigma^-\sigma^-\sigma
// ^+$ 及其厄米共轭的时间演化，通过特定的单比特旋转和多比
// 特纠缠门组合完成。 下图： 子图类型：量子电路图。 布局
// 与连接：同样由四条水平平行线组成，代表四个量子比特。
// 左侧部分：标记为 $\tilde{G}^\dagger$。结构与上图类似，
// 但细节不同。最左端是一个两比特CNOT门（控制0，目标2）和
// 一个两比特CNOT门（控制1，目标2）的组合。紧接着第1号线
// 上是Hadamard门，然后是一系列 $R_z(\alpha)$ 和 $R_z(-\
// alpha)$ 门，参数序列为 $\alpha, -\alpha, -\alpha, -\
// alpha, -\alpha, \alpha, \alpha, \alpha$。这些门之间穿
// 插着CNOT门，控制端始终在第1号线，目标端轮流在第0、2、3
// 号线。 中间部分：标记为 $(\sigma^+ Z \sigma^- \sigma^-
// Z \sigma^+ + \text{h.c.})$ rotations。这一部分包含了上
// 述的 $R_z$ 门序列和CNOT网络。特别地，在第1号线上的第一
// 个和最后一个 $R_z$ 门（即最左和最右的 $R_z(\alpha)$ 和
// $R_z(\alpha)$）被淡粉色矩形框高亮显示。 右侧部分：标记
// 为 ZZ rotations 和 $\tilde{G}$。与上图相同，包含三个 $
// R_z$ 门，参数为 $R_z(4\alpha/3)$、$R_z(-2\alpha/3)$、$
// R_z(-2\alpha/3)$，分别作用于第0、2、3号线。随后是第1号
// 线上的Hadamard门，以及一个两比特CNOT门（控制0，目标2）
// 和一个两比特CNOT门（控制1，目标2）的组合。 标注文字：
// 底部标注同上，分别为 $\tilde{G}^\dagger$、$(\sigma^+ Z
// \sigma^- \sigma^- Z \sigma^+ + \text{h.c.})$ rotations、
// ZZ rotations 和 $\tilde{G}$。 颜色与高亮：中间部分的两
// 个 $R_z(\alpha)$ 门被淡粉色矩形框包围，以示强调。 趋势
// 或结论：该电路实现了算符 $\sigma^+ Z \sigma^- \sigma^-
// Z \sigma^+$ 及其厄米共轭的时间演化，与上图的区别在于引
// 入了额外的Z算符，并通过修改初始和末态的门序列来实现。
// 整体说明： 两张图对比展示了两种不同的量子电路设计，用
// 于实现含时演化算符。上图对应于简单的四体相互作用项，而
// 下图则对应于包含额外Z算符的修正项。两者都使用了类似的
// 分解策略，即将复杂的多体相互作用分解为单比特旋转和CNOT
// 门的序列。图中的 $G$ 和 $\tilde{G}$ 表示基变换或预处理
// 步骤，而中间的旋转部分则是核心的动力学演化。
#figure(image("imgs/pmmpZZ.png", width: 15cm),
  caption: [
    The circuits that implement the time evolution of $exp ( - 8 i alpha Q_(n , f)^(( a )) thin Q_(m , f')^(( a )) )$. Specifically, the upper circuit implements $exp - i 4 alpha [ ( sigma^(+) sigma^(-) sigma^(-) sigma^(+) + upright("h") thin upright(".") thin upright("c") thin upright(".") ) + 1 / 12 ( 2 I Z I Z - I Z Z I - Z I I Z ) ]$, while the lower circuit implements $exp - i 4 alpha [ ( sigma^(+) Z sigma^(-) sigma^(-) Z sigma^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") ) + 1 / 12 ( 2 Z I I Z I I - I I Z Z I I - Z I I I I Z ) ]$. The CNOTs highlighted in red account for the $Z$s in $sigma^(+) Z sigma^(-) sigma^(-) Z sigma^(+)$. For $S U ( 3 )$ with $N_f = 2$ and $L = 1$, the required evolution operators have $alpha = t g^2 / 8$.
  ]
)
<circ:UpmmpZZ>

More details on these circuits can be found in App.~@app:circ.

=== Trotterization, Color Symmetry and Color Twirling
<sec:colorBreak>
After fixing the gauge, the Hamiltonian is no longer manifestly invariant under local $S U ( 3 )$ gauge transformations. However, as is well known, observables of the theory are correctly computed from such a gauge-fixed Hamiltonian, which possesses a remnant global $S U ( 3 )$ symmetry. This section addresses the extent to which this symmetry is preserved by Trotterization of the time-evolution operator. The focus will be on the $N_f = 1$ theory as including additional flavors does not introduce new complications.

Trotterization of the mass and kinetic parts of the Hamiltonian, while having non-zero commutators between some terms, preserves the global $S U ( 3 )$ symmetry. The time evolution of $Q_n^(( a )) thin Q_n^(( a ))$ can be implemented in a unitary operator without Trotter errors, and, therefore, does not break $S U ( 3 )$. On the other hand, the time evolution induced by $Q_n^(( a )) thin Q_m^(( a ))$ is implemented by the operator being divided into four terms: $( Q_n^(( 1 )) thin Q_m^(( 1 )) + Q_n^(( 2 )) thin Q_m^(( 2 )) )$, $( Q_n^(( 4 )) thin Q_m^(( 4 )) + Q_n^(( 5 )) thin Q_m^(( 5 )) )$, $( Q_n^(( 6 )) thin Q_m^(( 6 )) + Q_n^(( 7 )) thin Q_m^(( 7 )) )$ and $( Q_n^(( 3 )) thin Q_m^(( 3 )) + Q_n^(( 8 )) thin Q_m^(( 8 )) )$. In order for global $S U ( 3 )$ to be unbroken, the sum over the entire lattice of each of the 8 gauge charges must be unchanged under time evolution. Therefore, the object of interest is the commutator

$ cal(C) = [sum_(n = 0)^(2 L - 1) Q_n^(( a )) med , med Q_m^(( tilde(b) )) dot.op Q_l^(( tilde(b) ))] med , $<eq:Qcomm>

where $tilde(b)$ is summed over the elements of one of the pairs in $( ( 1 , 2 ) , thin ( 4 , 5 ) , thin ( 6 , 7 ) , thin ( 3 , 8 ) )$. It is found that this commutator only vanishes if $a = 3$ or $a = 8$, or if $tilde(b)$ is summed over all $8$ values (as is the case for the exact time evolution operator). Therefore, Trotter time evolution does not preserve the global off-diagonal $S U ( 3 )$ charges and, for example, color singlets can evolve into non-color singlets. Equivalently, the Trotterized time evolution operator is not in the trivial representation of $S U ( 3 )$. To understand this point in more detail, consider the transformation of $(T^a)_j^i med (T^a)_l^k$ for any given $a$. Because of the symmetry of this product of operators, each transforming as an $upright(bold(8))$, the product must decompose into $upright(bold(1)) xor upright(bold(8)) xor upright(bold(27))$, where the elements of each of the irreps can be found from

$ (T^a)_j^i med (T^a)_l^k = (hat(cal(O))_27^a)_(j l)^(i k) - 2 / 5 [delta_j^i (hat(cal(O))_8^a)_l^k + delta_l^k (hat(cal(O))_8^a)_j^i] + 3 / 5 [delta_l^i (hat(cal(O))_8^a)_j^k + delta_j^k (hat(cal(O))_8^a)_l^i] + 1 / 8 (delta_l^i delta_j^k med - med 1 / 3 delta_j^i delta_l^k) hat(cal(O))_1^a med , $

where

$ (hat(cal(O))_27^a)_(j l)^(i k) = & med 1 / 2 [(T^a)_j^i (T^a)_l^k + (T^a)_l^i (T^a)_j^k] - 1 / 10 [delta_j^i (hat(cal(O))_8^a)_l^k + delta_l^i (hat(cal(O))_8^a)_j^k + delta_j^k (hat(cal(O))_8^a)_l^i + delta_l^k (hat(cal(O))_8^a)_j^i]\
 & - 1 / 24 (delta_j^i delta_l^k + delta_l^i delta_j^k) hat(cal(O))_1^a med ,\
(hat(cal(O))_8^a)_j^i = & med (T^a)_beta^i (T^a)_j^beta med - med 1 / 3 delta_j^i hat(cal(O))_1^a med , med med hat(cal(O))_1^a med = med (T^a)_beta^alpha (T^a)_alpha^beta med = med 1 / 2 med . $

When summed over $a = 1 , dots.h , 8$, the contributions from the $upright(bold(8))$ and $upright(bold(27))$ vanish, leaving the familiar contribution from the $upright(bold(1))$. When only partials sums are available, as is the situation with individual contributions to the Trotterized evolution, each of the contributions is the exponential of $upright(bold(1)) xor upright(bold(8)) xor upright(bold(27))$, with only the singlet contributions leaving the lattice a color singlet. The leading term in the expansion of the product of the four pairs of Trotterized evolution operators sum to leave only the singlet contribution. In contrast, higher-order terms do not cancel and non-singlet contributions are present.

This is a generic problem that will be encountered when satisfying Gauss's law leads to non-local charge-charge interactions. This is not a problem for $U ( 1 )$, and surprisingly, is not a problem for $S U ( 2 )$ because $( Q_n^(( 1 )) thin Q_m^(( 1 )) , Q_n^(( 2 )) thin Q_m^(( 2 )) , Q_n^(( 3 )) thin Q_m^(( 3 )) )$ are in the Cartan sub-algebra of $S U ( 4 )$ and therefore mutually commuting. However, it is a problem for $N_c > 2$. One way around the breaking of global $S U ( N_c )$ is through the co-design of unitaries that directly (natively) implement $exp ( i alpha Q_n^(( a )) thin Q_m^(( a )) )$\; see @sec:codesign. Without such a native unitary, the breaking of $S U ( N_c )$ appears as any other Trotter error, and can be systematically reduced in the same way. A potential caveat to this is if the time evolution operator took the system into a different phase, but our studies of $L = 1$ show no evidence of this.

It is interesting to note that the terms generated by the Trotter commutators form a closed algebra. In principle, a finite number of terms could be included to define an effective Hamiltonian whose Trotterization exactly maps onto the desired evolution operator (without the extra terms). It is straightforward to work out the terms generated order-by-order in the Baker-Campbell-Hausdorff formula. Aside from re-normalizing the existing charges, there are $9$ new operator structures produced. For example, the leading-order commutators generate the three operators, $cal(O)_i$, in @eq:BCHOp,

$ cal(O)_i = {( sigma^(+) I sigma^(-) sigma^(-) Z sigma^(+) - sigma^(+) Z sigma^(-) sigma^(-) I sigma^(+) ) - upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
( I sigma^(-) sigma^(+) Z sigma^(+) sigma^(-) - Z sigma^(-) sigma^(+) I sigma^(+) sigma^(-) ) - upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
( sigma^(+) sigma^(-) Z sigma^(-) sigma^(+) I - sigma^(+) sigma^(-) I sigma^(-) sigma^(+) Z ) - upright("h") thin upright(".") thin upright("c") thin upright(".") med . $<eq:BCHOp>

In general, additional operators are constrained only by (anti)hermiticity, symmetry with respect to $n arrow.l.r m$ and preservation of $( r , g , b )$, and should generically be included in the same spirit as terms in the Symanzik-action~@Symanzik:1983dc @Symanzik:1983gh for lattice QCD.

With Trotterization of the gauge field introducing violations of gauge symmetry, and the presence of bit- and phase-flip errors within the device register, it is worth briefly considering a potential mitigation strategy. A single bit-flip error will change isospin by $| Delta I_3 | = 1 / 2$ and color charge by one unit of red or green or blue. After each Trotter step on a real quantum device, such errors will be encountered and a mitigation or correction scheme is required. Without the explicit gauge-field degrees of freedom and local charge conservation checks enabled by Gauss's law, such errors can only be detected globally, and hence, cannot be actively corrected during the evolution.#footnote[When local gauge fields are present, previous works have found that including a quadratic “penalty-term” in the Hamiltonian is effective in mitigating violation of Gauss's law~@Hauke:2013jga @Zohar:2015hwa @Dalmonte:2016alw @Halimeh:2019svu. See also Refs.~@PhysRevLett.112.120406 @Kasper:2020owz.] Motivated by this, consider introducing a twirling phase factor into the evolution, $exp ( - i theta^a cal(Q)^(( a )) )$, where $cal(Q)^(( a ))$ is the total charge on the lattice. If applied after each Trotter step, with a randomly selected set of eight angles, $theta^a$, the phases of color-nonsinglet states become random for each member of an ensemble, mitigating errors in some observables. Similar twirling phase factors could be included for the other charges that are conserved or approximately conserved.

=== Quantum Resource Requirements for Time Evolution
<quantum-resource-requirements-for-time-evolution>
It is straightforward to extend the circuits presented in the previous section to arbitrary $N_c$ and $N_f$. The quantum resources required for time evolution can be quantified for small, modest and asymptotically large systems. As discussed previously, a quantum register with $N_q = 2 L N_c N_f$ qubits#footnote[The inclusion of an ancilla for the kinetic term increases the qubit requirement to $N_q = 2 L N_c N_f + 1$.] is required to encode one-dimensional $S U ( N_c )$ gauge theory with $N_f$ flavors on $L$ spatial lattice sites using the JW transformation. For $S U ( 3 )$ gauge theory, this leads to, for example, $N_q = 6 L$ with only $u$-quarks and $N_q = 18 L$ with $u , d , s$-quarks. The five distinct contributions to the resource requirements, corresponding to application of the unitary operators providing a single Trotter step associated with the quark mass, $U_m$, the baryon chemical potential, $U_(mu_B)$, the isospin chemical potential, $U_(mu_I)$, the kinetic term, $U_(k i n)$, and the chromo-electric field, $U_(e l)$, are given in terms of the number of single-qubit rotations, denoted by "$R_Z$", the number of Hadamard gates, denoted by "Hadamard", and the number of CNOT gates, denoted by "CNOT". It is found that#footnote[For $N_c = 2$ only three of the $Z Z$ terms can be combined into $Q_(n , f)^(( a )) thin Q_(m , f')^(( a ))$ and the number of CNOTs for one Trotter step of $U_(e l)$ is]

$ U_(e l) med : med ( 2 L - 1 ) N_f [ 9 ( 2 L - 1 ) N_f - 7 ] med med med | med upright("CNOT") med . $

Additionally, for $N_c N_f < 4$, the Trotterization of $U_(upright("kin"))$ is more efficient without an ancilla and the number of CNOTs required is

$ U_(k i n) med : med 2 ( 2 L - 1 ) N_c ( N_c + 1 ) med med med | med upright("CNOT") med . $ <eq:UkinNoanc>

The construction of the circuit that implements the time evolution of the hopping term for $N_c = 3$

and $N_f = 1$

is shown in @fig:Ukin1flavTrot.

$ U_m med : & med med 2 N_c N_f L med med med | med R_Z med ,\
U_(mu_B) med : & med med 2 N_c N_f L med med med | med R_Z med ,\
U_(mu_I) med : & med med 2 N_c N_f L med med med | med R_Z med ,\
U_(k i n) med : & med med 2 N_c N_f ( 2 L - 1 ) med med med | med R_Z med ,\
 & med med 2 N_c N_f ( 2 L - 1 ) med med med | med upright("Hadamard") med ,\
 & med med 2 N_c N_f ( 8 L - 3 ) - 4 med med med | med upright("CNOT") med ,\
U_(e l) med : & med med 1 / 2 ( 2 L - 1 ) N_c N_f [3 - 4 N_c + N_f ( 2 L - 1 ) ( 5 N_c - 4 )] med med med | med R_Z med ,\
 & med med 1 / 2 ( 2 L - 1 ) ( N_c - 1 ) N_c N_f [N_f ( 2 L - 1 ) - 1] med med med | med upright("Hadamard") med ,\
 & med med 1 / 6 ( 2 L - 1 ) ( N_c - 1 ) N_c N_f \[ ( 2 L - 1 ) ( 2 N_c + 17 ) N_f - 2 N_c - 11 \] med med med | med upright("CNOT") med . $<eq:RHCN>

It is interesting to note the scaling of each of the contributions. The mass, chemical potential and kinetic terms scale as $cal(O) ( L^1 )$, while the non-local gauge-field contribution is $cal(O) ( L^2 )$. As anticipated from the outset, using Gauss's law to constrain the energy in the gauge field via the quark occupation has given rise to circuit depths that scale quadratically with the lattice extent, naively violating one of the criteria for quantum simulations at scale~@Feynman:1981tf @DiVincenzo2000ThePI. This volume-scaling is absent for formulations that explicitly include the gauge-field locally, but with the trade-off of requiring a volume-scaling increase in the number of qubits or qudits or bosonic modes.#footnote[The local basis on each link is spanned by the possible color irreps and the states of the left and right Hilbert spaces (see footnote[foot:irrep]). The possible irreps are built from the charges of the preceding fermion sites, and therefore the dimension of the link basis grows polynomially in $L$. This can be encoded in $cal(O) ( log L )$ qubits per link and $cal(O) ( L log L )$ qubits in total. The hopping and chromo-electric terms in the Hamiltonian are local, and therefore one Trotter step will require $cal(O) ( L )$ gate operations up to logarithmic corrections.] We expect that the architecture of quantum devices used for simulation and the resource requirements for the local construction will determine the selection of local versus non-local implementations.

For QCD with $N_f = 2$, the total requirements are

$ R_Z med : & med med ( 2 L - 1 ) (132 L - 63) + 18 med ,\
upright("Hadamard") med : & med med ( 2 L - 1 ) (24 L - 6) med ,\
upright("CNOT") med : & med med ( 2 L - 1 ) (184 L - 78) + 8 med , $

and further, the CNOT requirements for a single Trotter step of $S U ( 2 )$ and $S U ( 3 )$ for $N_f = 1 , 2 , 3$ are shown in @tab:cnotA.

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,left,left,),
    table.header(table.cell(align: center, colspan: 4)[Number of CNOT gates for one Trotter step of $S U ( 2 )$],),
    table.hline(),
    [$L$], [$N_f = 1$], [$N_f = 2$], [$N_f = 3$],
    [1], [14], [58], [116],
    [2], [96], [382], [818],
    [5], [774], [3,082], [6,812],
    [10], [3,344], [13,342], [29,762],
    [100], [357,404], [1,429,222], [3,213,062],
  )]
  , caption: [The CNOT requirements to perform one Trotter step of time evolution for a selection of simulation parameters.]
  , kind: table
  )

~~

#block[]
#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,left,left,),
    table.header(table.cell(align: center, colspan: 4)[Number of CNOT gates for one Trotter step of $S U ( 3 )$],),
    table.hline(),
    [$L$], [$N_f = 1$], [$N_f = 2$], [$N_f = 3$],
    [1], [30], [114], [242],
    [2], [228], [878], [1,940],
    [5], [1,926], [7,586], [16,970],
    [10], [8,436], [33,486], [75,140],
    [100], [912,216], [3,646,086], [8,201,600],
  )]
  , caption: [The CNOT requirements to perform one Trotter step of time evolution for a selection of simulation parameters.]
  , kind: table
  )
<tab:cnotA>

These resource requirements suggest that systems with up to $L = 5$ could be simulated, with appropriate error mitigation protocols, using this non-local framework in the near future. Simulations beyond $L = 5$ appear to present a challenge in the near term.

The resource requirements in @tab:cnotA do not include those for a gauge-link beyond the end of the lattice. As discussed previously, such additions to the time evolution could be used to move color-nonsinglet contributions to high frequency, allowing the possibility that they are filtered from observables. Such terms contribute further to the quadratic volume scaling of resources. Including chemical potentials in the time evolution does not increase the number of required entangling gates per Trotter step. Their impact upon resource requirements may arise in preparing the initial state of the system.

=== Elements for Future Co-Design Efforts
<sec:codesign>
Recent work has shown the capability of creating many-body entangling gates natively~@Andrade:2021pil @Katz:2022czu which have similar fidelity to two qubit gates. This has multiple benefits. First, it allows for (effectively) deeper circuits to be run within coherence times. Second, it can eliminate some of the Trotter errors due to non-commuting terms. The possibility of using native gates for these calculations is particularly interesting from the standpoint of eliminating or mitigating the Trotter errors that violate the global $S U ( 3 )$ symmetry, as discussed in @sec:colorBreak. Specifically, it would be advantageous to have a “black box” unitary operation of the form,

$ e^(- i alpha Q_n^(( a )) thin Q_m^(( a ))) = & med exp { - i alpha / 2 \[ sigma_n^(+) sigma_(n + 1)^(-) sigma_m^(-) sigma_(m + 1)^(+) + sigma_n^(-) sigma_(n + 1)^(+) sigma_m^(+) sigma_(m + 1)^(-) + sigma_(n + 1)^(+) sigma_(n + 2)^(-) sigma_(m + 1)^(-) sigma_(m + 2)^(+) + sigma_(n + 1)^(-) sigma_(n + 2)^(+) sigma_(m + 1)^(+) sigma_(m + 2)^(-)\
 & + sigma_n^(+) sigma_(n + 1)^z sigma_(n + 2)^(-) sigma_m^(-) sigma_(m + 1)^z sigma_(m + 2)^(+) + sigma_n^(-) sigma_(n + 1)^z sigma_(n + 2)^(+) sigma_m^(+) sigma_(m + 1)^z sigma_(m + 2)^(-) + 1 / 6 ( sigma_n^z sigma_m^z + sigma_(n + 1)^z sigma_(m + 1)^z + sigma_(n + 2)^z sigma_(m + 2)^z )\
 & - 1 / 12 ( sigma_n^z sigma_(m + 1)^z + sigma_n^z sigma_(m + 2)^z + sigma_(n + 1)^z sigma_m^z + sigma_(n + 1)^z sigma_(m + 2)^z + sigma_(n + 2)^z sigma_m^z + sigma_(n + 2)^z sigma_(m + 1)^z ) \] } med , $

for arbitrary $alpha$ and pairs of sites, $n$ and $m$ (sum on $a$ is implied). A more detailed discussion of co-designing interactions for quantum simulations of these theories is clearly warranted.

== Results from Quantum Simulators
<results-from-quantum-simulators>
The circuits laid out in @sec:Circuits are too deep to be executed on currently available quantum devices, but can be readily implemented with quantum simulators such as `cirq` and `qiskit`. This allows for an estimate of the number of Trotter steps required to achieve a desired precision in the determination of any given observable as a function of time. @fig:VacTo shows results for the trivial vacuum-to-vacuum and trivial vacuum-to-$d_r overline(d)_r$ probabilities as a function of time for $L = 1$. See App.~@app:Nf1SU3circs for the full circuit which implements a single Trotter step, and App.~@app:MDTD for the decomposition of the energy starting in the trivial vacuum.

// [figvision-cn] imgs/VacToProbabilities.png
// 该图由两个并排的子图（左图和右图）组成，展示量子色动力
// 学（QCD）中平凡真空到真空及平凡真空到反夸克-夸克对态的
// 概率随时间的演化。 左侧子图： 类型为离散数据点与连续曲
// 线叠加的散点图。横坐标为时间 t，范围从 0 到 5，无单位
// 标注但根据上下文应为无量纲时间或归一化时间单位；纵坐标
// 为概率 Probability，范围从 0.0 到 1.0，刻度间隔为 0.2。
// 图中包含一条黑色虚线曲线，代表哈密顿量精确指数化的理论
// 结果；另有五组彩色实心圆点数据系列，分别对应不同
// Trotter 步数下的模拟结果：蓝色点表示 1 步、橙色点表示
// 2 步、红色点表示 3 步、紫色点表示 5 步、绿色点表示 10
// 步。所有数据点均沿时间轴分布，在 t=0 处起始于概率 1.0，
// 随后振荡衰减。随着 Trotter 步数增加，数据点更紧密地贴
// 合黑色虚线曲线，尤其在 t>3 区域，10 步（绿色）几乎完全
// 重合于理论曲线，而 1 步（蓝色）在 t≈2 后迅速降至接近零
// 并保持平坦。右上角有一个紫色菱形图标，内含字母“c”，旁
// 边标注“Trivial Vacuum-to-Vacuum”。 右侧子图： 类型同左
// 图为离散数据点与连续曲线叠加的散点图。横坐标同样为时间
// t，范围 0 至 5；纵坐标为概率 Probability，范围 0.00 至
// 0.08，刻度间隔为 0.02。图中黑色虚线仍代表精确解，五条
// 彩色数据系列含义与左图一致（蓝:1步, 橙:2步, 红:3步, 紫
// :5步, 绿:10步）。所有曲线从原点 (t=0, P=0) 开始，在 t≈
// 1 和 t≈3 附近出现两个主峰，峰值概率约 0.06–0.07。
// Trotter 步数越少，数据点偏离理论曲线越明显，尤其 1 步
// （蓝色）在第一个峰后即快速衰减至近零，后续波动剧烈且幅
// 度小；10 步（绿色）最贴近理论曲线，但在第二个峰后略有
// 低估。右上角有相同紫色菱形图标“c”及标题“Trivial
// Vacuum-to-d_r d̄_r”。 共享图例位于右图右侧，以矩形框包
// 围，列明：黑色虚线 —— Exact；蓝色实心圆 —— 1 step；橙
// 色实心圆 —— 2 steps；红色实心圆 —— 3 steps；紫色实心圆
// —— 5 steps；绿色实心圆 —— 10 steps。图注说明这些数据来
// 自使用 cirq 和 qiskit 经典量子模拟器实现的 Trotter 化
// 方案，参数为 N_s = 4, N_t = 4, g^2 = 0.5，并指定了
// Trotter 步数。整体趋势表明：Trotter 步数越多，数值模拟
// 越逼近精确解，误差随步数增加显著减小，尤其在长时间演化
// 区域更为明显。
#figure(image("imgs/VacToProbabilities.png", width: 100%),
  caption: [
    The trivial vacuum-to-vacuum and trivial vacuum-to-$d_r overline(d)_r$ probabilities in QCD with $N_f = 2$ for $m = g = L = 1$. Shown are the results obtained from exact exponentiation of the Hamiltonian (dashed black curve) and from the Trotterized implementation with $1$, $2$, $3$, $5$ and $10$ Trotter steps using the (classical) quantum simulators in `cirq` and `qiskit` (denoted by the purple icons~@Klco:2019xro).
  ]
)
<fig:VacTo>

The number of Trotter steps, $N_(upright("Trott"))$, required to evolve out to a given $t$ within a specified (systematic) error, $epsilon.alt_(upright("Trott"))$, was also investigated. $epsilon.alt_(upright("Trott"))$ is defined as the maximum fractional error between the Trotterized and exact time evolution in two quantities, the vacuum-to-vacuum persistence probability and the vacuum-to-$d_r overline(d)_r$ transition probability. For demonstrative purposes, an analysis at leading order in the Trotter expansion is sufficient. Naive expectations based upon global properties of the Hamiltonian defining the evolution operators indicate that an upper bound for $epsilon.alt_(upright("Trott"))$ scales as

$ | | e^(- i H t) - [U_1 (t / N_(upright("Trott")))]^(N_(upright("Trott"))) | | med lt.eq med 1 / 2 sum_i sum_(j > i) | | [H_i , H_j] | | t^2 / N_(upright("Trott")) med , $<eq:LOTrottbound>

where the Hamiltonian has been divided into sets of mutually commuting terms, $H = sum_i H_i$. This upper bound indicates that the required number of Trotter steps to maintain a fixed error scales as $N_(upright("Trott")) tilde t^2$~@Childs_2021.

To explore the resource requirements for simulation based upon explicit calculations between exclusive states, as opposed to upper bounds for inclusive processes, given in @eq:LOTrottbound, a series of calculations was performed requiring $epsilon.alt_(upright("Trott")) lt.eq 0.1$ for a range of times, $t$. @fig:TrotErrorB shows the required $N_(upright("Trott"))$ as a function of $t$ for $m = g = L = 1$.

// [figvision-cn] imgs/TrotError.png
// 该图由左右两个并列的子图组成，分别标记为左面板和右面板。
// 左面板： 子图类型：散点拟合曲线图。 标题文字：“Trivial
// Vacuum-to-Vacuum”。 坐标轴名称及范围与单位：横轴标签为
// “t”，表示时间，数值范围从0到200，主刻度线标注在50、100、
// 150、200处；纵轴标签为“Required N_Trott”，表示所需的
// Trotter步数，数值范围从0到2000以上，主刻度线标注在500、
// 1000、1500、2000处。 数据点与曲线描述：图中包含一系列
// 蓝色实心圆点，代表直接计算得到的结果。这些点分布在一条
// 向上弯曲的轨迹上，随着横轴t值的增加，纵轴N_Trott值呈非
// 线性增长趋势。在这些蓝色数据点之上覆盖有一条深灰色的实
// 线，代表数据的拟合曲线。此外，还有两条较细的橙色线条分
// 别位于灰色拟合曲线的上方和下方，形成一个包络带，表示拟
// 合的不确定度或误差范围。 标注文字：在图表区域的左上部
// 分（大约对应t=50, N_Trott=1200的位置）有一行数学公式文
// 本：“N_Trott^(fit) = 0.0393(5)t^2 + 4.13(10)t - 22(5)”。
// 传达的趋势或结论：该子图展示了在QCD理论中，为了达到特
// 定的系统分数误差，计算平凡真空到真空概率所需的Trotter
// 步数随时间t的增加而显著增加，且这种增加关系符合二次多
// 项式函数特征。 右面板： 子图类型：阶梯状散点图。 标题
// 文字：“Trivial Vacuum-to-d_r d_bar_r”。 坐标轴名称及范
// 围与单位：横轴标签为“t”，表示时间，数值范围从0到100，
// 主刻度线标注在20、40、60、80、100处；纵轴标签为“
// Required N_Trott”，表示所需的Trotter步数，数值范围从0
// 到2500以上，主刻度线标注在500、1000、1500、2000、2500
// 处。 数据点与曲线描述：图中包含一系列蓝色的水平短线段
// （或扁平的点簇），代表直接计算的结果。这些数据呈现阶梯
// 状分布，即随着横轴t值的增加，纵轴N_Trott值以离散的跳跃
// 方式上升。例如，在t约为20时，N_Trott约为300；在t约为40
// 时，N_Trott跃升至约700；在t接近100时，N_Trott超过2500。
// 标注文字：除坐标轴和标题外，图中无其他特定公式标注。
// 传达的趋势或结论：该子图展示了计算平凡真空到夸克-反夸
// 克对概率所需的Trotter步数随时间t的增加而呈阶梯式急剧上
// 升，表明随着演化时间的延长，计算复杂度显著增加。
#figure(image("imgs/TrotError.png", width: 100%),
  caption: [
    The number of Trotter steps, $N_(upright("Trott"))$, required to achieve a systematic fractional error of $epsilon.alt_(upright("Trott")) lt.eq 0.1$ at time $t$ in the trivial vacuum-to-vacuum probability (left panel) and the trivial vacuum-to-$d_r overline(d)_r$ probability (right panel) for QCD with $N_f = 2$ and $m = g = L = 1$. The blue points are results obtained by direct calculation.
  ]
)
<fig:TrotErrorB>

The plateaus observed in @fig:TrotErrorB arise from resolving upper bounds from oscillating functions, and introduce a limitation in fitting to extract scaling behavior. This is less of a limitation for the larger vacuum-to-vacuum probabilities which are fit well by a quadratic polynomial, starting from $t = 1$, with coefficients,

$ N_(upright("Trott")) = 0.0393 ( 5 ) t^2 + 4.13 ( 10 ) t - 22 ( 5 ) med . $<eq:TrotErrorFit>

The uncertainty represents a 95% confidence interval in the fit parameters and corresponds to the shaded orange region in @fig:TrotErrorB. The weak quadratic scaling with $t$ implies that, even out to $t tilde 100$, the number of Trotter steps scales approximately linearly, and a constant error in the observables can be achieved with a fixed Trotter step size. We have been unable to distinguish between fits with and without logarithmic terms.

These results can be contrasted with those obtained for the Schwinger model in Weyl gauge. The authors of Ref.~@Shaw:2020udc estimate a resource requirement, as quantified by the number of $T$-gates, that scales as $tilde ( L t )^(3 / 2) log L t$, increasing to $tilde L^(5 / 2) t^(3 / 2) log L t log L$ if the maximal value of the gauge fields is accommodated within the Hilbert space. The results obtained in this section suggest that resource requirements in axial gauge, as quantified by the number of CNOTs, effectively scale as $tilde L^2 t$ up to intermediate times and as $tilde L^2 t^2$ asymptotically. In a scattering process with localized wave-packets, it is appropriate to take $L tilde t$ (for the speed of light taken to be $c = 1$), as the relevant non-trivial time evolution is bounded by the light cone. This suggests that the required resources scale asymptotically as $tilde t^4$, independent of the chosen gauge to define the simulation. This could have been anticipated at the outset by assuming that the minimum change in complexity for a process has physical meaning@doi:10.48550-arxiv-quant-ph-0701004 @doi:10.1126-science.1121541 @doi:10.48550-arxiv-quant-ph-0502070 @Jefferson:2017sdb.

= SIMULATING $1 + 1$D QCD WITH $N_f = 1$ AND $L = 1$<sec:Nc3Nf1>
With the advances in quantum devices, algorithms and mitigation strategies, quantum simulations of $1 + 1$D QCD can now begin, and this section presents results for $N_f = 1$ and $L = 1$. Both state preparation and time evolution will be discussed.

== State Preparation with VQE
<state-preparation-with-vqe>
Restricting the states of the lattice to be color singlets reduces the complexity of state preparation significantly. Transformations in the quark sector are mirrored in the antiquark sector. A circuit that prepares the most general state with $r = g = b = 0$ is shown in @circ:GeneralVQE.

// [figvision-cn] imgs/VQEGeneral.png
// 该图像为一个量子电路示意图，展示了6条水平排列的量子比
// 特线，从上至下依次标记为 |r⟩、|g⟩、|b⟩、|r̄⟩、|ḡ⟩、|b̄
// ⟩。所有操作按从左到右的时间顺序排列。 子图类型：量子电
// 路图（流程图）。 坐标轴：无传统坐标轴；横向表示时间演
// 化方向，纵向表示不同量子比特线路。 各量子比特线上的元
// 件及连接关系如下： 第一行 |r⟩： 最左侧有一个标有“X”的
// 方框，代表泡利-X门。 向右延伸后，在中间偏右位置出现一
// 个带圆圈的加号（⊕），这是CNOT门的靶点（target），其控
// 制端位于第四行 |r̄⟩ 上对应位置的实心黑点。 第二行 |g⟩：
// 最左侧有一个标有“X”的方框，代表泡利-X门。 向右延伸后，
// 在更靠右的位置出现另一个带圆圈的加号（⊕），是CNOT门的
// 靶点，其控制端位于第五行 |ḡ⟩ 上对应位置的实心黑点。 第
// 三行 |b⟩： 最左侧有一个标有“X”的方框，代表泡利-X门。
// 向右延伸后，在最右侧出现第三个带圆圈的加号（⊕），是
// CNOT门的靶点，其控制端位于第六行 |b̄⟩ 上对应位置的实心
// 黑点。 第四行 |r̄⟩： 最左侧有一个标有“θ”的方框，代表单
// 量子比特旋转门 R_y(θ) 或类似参数化旋转。 接着是一个半
// 填充圆形符号（左半边实心黑点，右半边空白），下方标注“θ
// _i”，表示以该行为控制、作用于下一行 |ḡ⟩ 的受控旋转门（
// control on |r̄⟩, target on |ḡ⟩）。 再往右是一个相同的
// 半填充圆形符号，同样下方标注“θ_i”，但此处控制仍在 |r̄⟩，
// 靶点在 |ḡ⟩ —— 注意图中实际显示的是两个独立的控制-靶点
// 对，均从 |r̄⟩ 指向 |ḡ⟩，且都标记为 θ_i。 继续向右，出
// 现一个实心黑点，作为CNOT门的控制端，靶点在第一行 |r⟩
// 上的 ⊕。 此行无其他元件。 第五行 |ḡ⟩： 最左侧无元件。
// 第一个半填充圆形符号（来自 |r̄⟩ 的控制）作用于此行的靶
// 点，标记为 θ_i。 第二个半填充圆形符号（也来自 |r̄⟩）再
// 次作用于此行的靶点，标记也为 θ_i —— 表明有两个连续的受
// 控旋转门作用于同一对量子比特。 再往右，出现一个实心黑
// 点，作为CNOT门的控制端，靶点在第二行 |g⟩ 上的 ⊕。 此行
// 无其他元件。 第六行 |b̄⟩： 最左侧无元件。 在中间偏右位
// 置出现一个标有“θ_ij”的方框，代表双量子比特参数化门（如
// 受控相位或交换类门），其输入来自 |ḡ⟩ 和 |b̄⟩？但根据图
// 示，该方框仅画在 |b̄⟩ 线上，且上方有一条垂直线连接到 |
// ḡ⟩ 线上的一个半填充圆形符号（控制端在 |ḡ⟩，靶点在 |b̄⟩），
// 该符号未单独标注角度，而是与 θ_ij 方框共同构成一个复合
// 门结构。 实际上，图中显示：在 |ḡ⟩ 线上有一个半填充圆形
// 符号（控制端），向下引出一条竖线连接到 |b̄⟩ 线上的一个
// 标有“θ_ij”的方框——这应解释为一个受控旋转门，控制位在 |
// ḡ⟩，靶位在 |b̄⟩，旋转角为 θ_ij。 再往右，出现一个实心
// 黑点，作为CNOT门的控制端，靶点在第三行 |b⟩ 上的 ⊕。 所
// 有CNOT门均由一条垂直线连接控制端（实心黑点）与靶点（⊕），
// 共三个CNOT门，分别连接： |r̄⟩ → |r⟩ |ḡ⟩ → |g⟩ |b̄⟩ → |
// b⟩ 所有受控旋转门由半填充圆形符号表示，其中： 两个 θ_i
// 门：控制位均为 |r̄⟩，靶位均为 |ḡ⟩，连续作用。 一个 θ
// _ij 门：控制位为 |ḡ⟩，靶位为 |b̄⟩。 图中所有文字标注包
// 括： 量子比特标签：|r⟩, |g⟩, |b⟩, |r̄⟩, |ḡ⟩, |b̄⟩ 门参
// 数：θ, θ_i, θ_ij 特殊符号说明：“X”表示泡利-X门，“⊕”表
// 示CNOT靶点，“●”表示CNOT控制点，“半填充圆”表示受控旋转
// 门的控制端。 趋势与结论： 该电路首先在三条辅助线 |r̄⟩,
// |ḡ⟩, |b̄⟩ 上初始化任意实数波函数（通过7个独立旋转角实
// 现，尽管图中只显式标出θ, θ_i, θ_ij，其余可能隐含或未画
// 出），然后通过三个CNOT门将此状态镜像复制到主系统 |r⟩,
// |g⟩, |b⟩。初始的X门用于将真空态翻转至所需基矢。整个电
// 路构建了一个从平凡真空出发、生成最一般实波函数并复制其
// 对称分量的量子过程。 比例尺：无物理尺寸比例尺，因属抽
// 象电路图。 颜色映射：全图为黑白线条图，无彩色通道或灰
// 度映射。 总结：本图描绘了一个六量子比特电路，前三个量
// 子比特经X门初始化，后三个经参数化旋转门编码7自由度实波
// 函数，再通过三组CNOT完成跨子系统镜像，体现量子态制备与
// 对称性复制的核心思想。
#figure(image("imgs/VQEGeneral.png", width: 6cm),
  caption: [
    Building upon the trivial vacuum, this circuit initializes the most general real wavefunction (with 7 independent rotation angles for 3 qubits) in the $overline(q)$-sector, which is subsequently mirrored into the $q$-sector by 3 CNOTs. Gates labelled by “$theta$” are shorthand for $R_Y ( theta )$ and half-filled circles denote a control on $0$ and a different control on $1$.
  ]
)
<circ:GeneralVQE>

The (multiply-)controlled $theta$ gates are short-hand for (multiply-)controlled $R_Y ( theta )$ gates with half-filled circles denoting a control on $0$ and a different control on $1$. The subscripts on $theta_(i j)$ signify that there are different angles for each controlled rotation. For example, $theta_i$ has two components, $theta_0$ and $theta_1$, corresponding to a rotation controlled on $0$ and $1$, respectively. The CNOTs at the end of the circuit enforce that there are equal numbers of quarks and antiquarks with the same color, i.e., that $r = g = b = 0$. This circuit can be further simplified by constraining the angles to only parameterize color singlet states. The color singlet subspace is spanned by#footnote[The apparent asymmetry between $q_r , q_g , q_b$ is due to the charge operators generating hops over different numbers of quarks or antiquarks. For example, $Q^(( 1 ))$ hops $q_r$ to $q_g$ without passing over any intermediate quarks, but $Q^(( 4 ))$ hops $q_r$ to $q_b$ passing over $q_g$. Also note that when $m = 0$ the $bb(Z)_2$ spin-flip symmetry reduces the space of states to be two-dimensional.]

$ | Omega_0 chevron.r med & , med med 1 / sqrt(3) (| q_r overline(q)_r chevron.r - | q_g overline(q)_g chevron.r + | q_b overline(q)_b chevron.r) med ,\
| q_r overline(q)_r thin q_g overline(q)_g thin q_b overline(q)_b chevron.r med & , med med 1 / sqrt(3) (| q_r overline(q)_r thin q_g overline(q)_g chevron.r - | q_r overline(q)_r thin q_b overline(q)_b chevron.r + | q_g overline(q)_g thin q_b overline(q)_b chevron.r) med , $<eq:vacBasis>

where $| Omega_0 chevron.r = | 000111 chevron.r$ is the trivial vacuum. This leads to the following relations between angles,

$ theta_10 & = theta_01 med , & theta_00 & = - 2 sin^(- 1) [tan ( theta_0 / 2 ) thin cos ( theta_01 / 2 )] med ,\
theta_01 & = - 2 sin^(- 1) [cos ( theta_11 / 2 ) thin tan ( theta_1 / 2 )] med , & theta_0 & = - 2 sin^(- 1) [tan ( theta / 2 ) thin cos ( theta_1 / 2 )] med . $<eq:angleconst>

The circuit in @circ:GeneralVQE can utilize the strategy outlined in Ref.~@Atas:2021ext to separate into a “variational” part and a “static” part. If the VQE circuit can be written as $U_(v a r) ( theta ) U_s$, where $U_s$ is independent of the variational parameters, then $U_s$ can be absorbed by a redefinition of the Hamiltonian. Specifically, matrix elements of the Hamiltonian can be written as

$ chevron.l Omega_0 | U_(v a r)^dagger ( theta ) tilde(H) U_(v a r) ( theta ) | Omega_0 chevron.r med , $

where $tilde(H) = U_s^dagger H U_s$. @tab:PUHU shows the transformations of various Pauli strings under conjugation by a CNOT controlled on the smaller index qubit. Note that the $bb(Z)_2$ nature of this transformation is manifest.

#figure(
  align(center)[#table(
    stroke: none,
    columns: 8,
    align: (center,center,center,center,center,center,center,center,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.vline(x: 4, stroke: 0.4pt),
    table.vline(x: 5, stroke: 0.4pt),
    table.vline(x: 6, stroke: 0.4pt),
    table.vline(x: 7, stroke: 0.4pt),
    table.vline(x: 8, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header([$X X arrow.r I X$], [$X Y arrow.r I Y$], [$Y X arrow.r Z Y$], [$X Z arrow.r X Z$], [$Z Z arrow.r Z I$], [$Y Z arrow.r Y I$], [$Z Y arrow.r Y X$], [$Y Y arrow.r ( - ) Z X$],),
    table.hline(),
    [$I X arrow.r X X$], [$I Y arrow.r X Y$], [$X I arrow.r X I$], [$I Z arrow.r I Z$], [$Z I arrow.r Z Z$], [$Y I arrow.r Y Z$], [$Z X arrow.r ( - ) Y Y$], [$I I arrow.r I I$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [The transformation of Pauli strings under conjugation by a CNOT controlled on the smaller index qubit.]
  , kind: table
  )
<tab:PUHU>

In essence, entanglement is traded for a larger number of correlated measurements. Applying the techniques in Ref.~@Klco:2019xro, the VQE circuit of @circ:GeneralVQE can be put into the form of @circ:VQEImp, which requires $5$ CNOTs along with all-to-all connectivity between the three $overline(q)$s.

// [figvision-cn] imgs/VQEImp.png
// 该图展示了一个用于初始化最一般颜色单态态的量子电路示意
// 图，适用于 $N_c=3$ 和 $N_f=3$ 的情况。图中包含六条水平
// 排列的量子线（qubit lines），从上至下依次标记为 $|r\
// rangle$、$|g\rangle$、$|b\rangle$、$|\bar{r}\rangle$、
// $|\bar{g}\rangle$、$|\bar{b}\rangle$，分别代表红、绿、
// 蓝三种颜色的夸克及其对应的反夸克。 (a) 整个图像是一个
// 单一子图，无分栏结构，整体为一个从左到右展开的量子电路
// 图。所有量子门按时间顺序从左向右排列在六条量子线上。左
// 侧部分为参数化旋转门和受控非门（CNOT）构成的纠缠生成网
// 络；右侧蓝色背景区域标记为“Static”，表示固定不变的初始
// 化操作模块。 具体元素如下： 第一条线 $|r\rangle$：无任
// 何门操作，保持恒等通道。 第二条线 $|g\rangle$：无任何
// 门操作，保持恒等通道。 第三条线 $|b\rangle$：无任何门
// 操作，保持恒等通道。 第四条线 $|\bar{r}\rangle$： 最左
// 侧有一个单比特旋转门，标记为 $\theta$，作用于该线。 随
// 后有三个控制点（黑点），分别位于第2、4、6个CNOT门的控
// 制端，对应下方三条线的目标位。 第五条线 $|\bar{g}\
// rangle$： 第一个门是单比特旋转门，标记为 $(\theta_0 +
// \theta_1)/2$。 接着是一个CNOT门，控制端来自 $|\bar{r}\
// rangle$ 的第一个控制点，目标端在此线。 第二个单比特旋
// 转门，标记为 $(\theta_0 - \theta_1)/2$。 第三个CNOT门，
// 控制端来自 $|\bar{r}\rangle$ 的第二个控制点，目标端在
// 此线。 之后有两个控制点（黑点），分别作为后续两个CNOT
// 门的控制端，作用于第六条线。 第六条线 $|\bar{b}\rangle
// $： 第一个单比特旋转门，标记为 $(\theta_{00} + \theta_
// {11} + 2\theta_{01})/4$。 第一个CNOT门，控制端来自 $|\
// bar{g}\rangle$ 的第一个控制点，目标端在此线。 第二个单
// 比特旋转门，标记为 $(\theta_{00} - \theta_{11})/4$。
// 第二个CNOT门，控制端来自 $|\bar{g}\rangle$ 的第二个控
// 制点，目标端在此线。 第三个单比特旋转门，标记为 $(\
// theta_{00} + \theta_{11} - 2\theta_{01})/4$。 第三个
// CNOT门，控制端来自 $|\bar{r}\rangle$ 的第三个控制点，
// 目标端在此线。 第四个单比特旋转门，标记为 $(\theta_{00
// } - \theta_{11})/4$。 第四个CNOT门，控制端来自 $|\bar{
// r}\rangle$ 的第四个控制点（实际未画出，但根据对称性推
// 断存在），目标端在此线。 注意：原文描述中提到“Gates
// labelled by “ ” are shorthand for and the s at the end
// are to initialize the trivial vacuum.” —— 此处可能指代
// 某些省略符号或默认门，但在当前图中并未出现空白标签门，
// 因此可理解为所有显式标注的门均已完整呈现。此外，“the
// color singlet constraint, , has been used” 表明电路设
// 计已满足颜色单态条件 $\sum_i |i\rangle \otimes |\bar{i
// }\rangle = 0$（即总色荷为零），而角度参数之间通过此约
// 束相互关联。 右侧蓝色矩形区域标记为“Static”，内含以下
// 固定操作： 对于 $|r\rangle$ 线：一个X门（泡利-X，即比
// 特翻转），后接一个CNOT门，控制端来自 $|\bar{b}\rangle$
// 的最终输出，目标端在此线。 对于 $|g\rangle$ 线：一个X
// 门，后接一个CNOT门，控制端来自 $|\bar{g}\rangle$ 的最
// 终输出，目标端在此线。 对于 $|b\rangle$ 线：一个X门，
// 后接一个CNOT门，控制端来自 $|\bar{r}\rangle$ 的最终输
// 出，目标端在此线。 对于 $|\bar{r}\rangle$、$|\bar{g}\
// rangle$、$|\bar{b}\rangle$ 线：各自末端各有一个CNOT门
// 的目标端，分别与上述三个X门后的CNOT门相连，形成反馈回
// 路以初始化平凡真空态。 所有连接线均为直线，垂直连线表
// 示CNOT门的控制-目标关系，黑点表示控制位，圆圈加十字表
// 示目标位。整个电路旨在构造任意参数化的颜色单态叠加态，
// 其中角度参数 $\theta, \theta_0, \theta_1, \theta_{00},
// \theta_{01}, \theta_{11}$ 可通过外部输入调节，从而覆盖
// 所有可能的颜色单态空间。最终状态由左侧参数化部分与右侧
// 静态初始化部分共同决定，确保系统处于物理允许的颜色中性
// 基态之上的一般叠加态。
#figure(image("imgs/VQEImp.png", width: 100%),
  caption: [
    A circuit that initializes the most general $B = 0$ color singlet state for $N_f = 1$ and $L = 1$. Gates labelled by “$theta$” are shorthand for $R_Y ( theta )$ and the $X$s at the end are to initialize the trivial vacuum. The color singlet constraint, $theta_10 = theta_01$, has been used and the other angles are related by @eq:angleconst.
  ]
)
<circ:VQEImp>

== Time Evolution Using IBM's 7-Qubit Quantum Computers
<time-evolution-using-ibms-7-qubit-quantum-computers>
A single leading-order Trotter step of $N_f = 1$ QCD with $L = 1$ requires 28 CNOTs.#footnote[By evolving with $U_(e l)$ before $U_(k i n)$ in the Trotterized time evolution, two of the CNOTs become adjacent in the circuit and can be canceled.] A circuit that implements one Trotter step of the mass term is shown in @circ:Um1flav.

// [figvision-cn] imgs/Nf1CircMass.png
// 该图像为一幅量子电路示意图，由六个水平排列的矩形框垂直
// 堆叠而成。每个矩形框代表一个作用于独立量子比特线路上的
// 量子门操作，左侧有一条水平短线作为输入线延伸至矩形框左
// 边缘，右侧有一条水平短线从矩形框右边缘延伸出去作为输出
// 线。从上至下，前三个矩形框内的文字标注完全相同，均为“
// R_Z(m t)”，表示绕Z轴旋转角度为m乘以t的量子门；后三个矩
// 形框内的文字标注也完全相同，均为“R_Z(-m t)”，表示绕Z轴
// 旋转角度为负m乘以t的量子门。图中所有线条均为黑色实线，
// 背景为白色，无坐标轴、色标、比例尺或图例。该子图传达的
// 结构是：一个包含六条并行量子比特线路的电路模块，其中前
// 三条线路执行正向Z旋转操作，后三条线路执行反向Z旋转操作，
// 参数均由变量m和t共同决定。
#figure(image("imgs/Nf1CircMass.png", height: 25.0%),
  caption: [
    A circuit that implements $U_m ( t ) = exp ( - i H_m t )$ for $N_f = 1$ and $L = 1$.
  ]
)
<circ:Um1flav>

As discussed around #ref(<eq:UkinNoanc>), it is more efficient to not use an ancilla qubit in the Trotterization of the kinetic part of the Hamiltonian. A circuit that implements one Trotter step of a single hopping term is shown in @fig:Ukin1flavTrot~@Stetina:2020abi.

// [figvision-cn] imgs/Ukin1FlavTrot.png
// 该图为一幅量子电路示意图，展示了实现特定量子门或算法的
// 线路结构。图中包含四条水平排列的量子比特线，时间流向从
// 左至右。各量子逻辑门通过符号表示，并标注了具体参数。
// 子图 a（整体电路图）： 类型：量子电路示意图。 布局：四
// 条平行横线代表四个量子比特，从上到下依次编号为 q0, q1,
// q2, q3（虽未显式标注，但按惯例如此）。所有操作沿时间轴
// 从左到右展开。 左侧起始部分： 最上方量子比特（q0）在左
// 端有一个控制点（实心黑圆），连接一条垂直线向下至第三条
// 量子比特（q2）上的目标点（带叉圆圈），构成一个受控非门
// （CNOT），其中 q0 为控制位，q2 为目标位。 第二条量子比
// 特（q1）无初始操作。 第三条量子比特（q2）在左端无独立
// 操作，仅作为上述 CNOT 的目标。 第四条量子比特（q3）在
// 左端有一个控制点（实心黑圆），连接一条垂直线向上至第一
// 条量子比特（q0）上的目标点（带叉圆圈），构成另一个
// CNOT，其中 q3 为控制位，q0 为目标位。 中间区域： 在 q3
// 线上，从左数第二个位置有一个 Hadamard 门，标记为“H”，
// 位于矩形框内。 紧接着其后，在 q3 线上是一个单量子比特
// 旋转门，标记为“Rz(t/2)”，位于矩形框内，表示绕 Z 轴旋转
// 角度 t/2。 再往后是另一个单量子比特旋转门，标记为“Rz(
// -t/2)”，同样位于矩形框内，表示绕 Z 轴旋转角度 -t/2。
// 在这两个 Rz 门之间及之后，存在多个多量子比特门： 在 q1
// 和 q2 之间：q1 上有控制点（实心黑圆），垂直连线至 q2
// 上的目标点（带叉圆圈），构成 CNOT（q1→q2）。 在 q2 和
// q3 之间：q2 上有控制点（实心黑圆），垂直连线至 q3 上的
// 目标点（带叉圆圈），构成 CNOT（q2→q3）。 在 q0 和 q3
// 之间：q0 上有控制点（实心黑圆），垂直连线至 q3 上的目
// 标点（带叉圆圈），构成 CNOT（q0→q3）。 在 q1 和 q3 之
// 间：q1 上有控制点（实心黑圆），垂直连线至 q3 上的目标
// 点（带叉圆圈），构成 CNOT（q1→q3）。 在 q2 和 q3 之间
// 再次出现：q2 上有控制点（实心黑圆），垂直连线至 q3 上
// 的目标点（带叉圆圈），构成第二个 CNOT（q2→q3）。 注意：
// 某些控制点与目标点在空间上重叠或邻近，需根据垂直连线判
// 断实际连接关系。例如，在中间偏右区域，q0、q1、q2 的控
// 制点分别连接到 q3 的不同目标点，形成级联控制结构。 右
// 侧结束部分： 在 q3 线上，最后一个操作是一个 Hadamard
// 门，标记为“H”。 在最右侧，q0 和 q3 之间又有一个 CNOT
// 门：q0 为控制点（实心黑圆），q3 为目标点（带叉圆圈）。
// 同时，q3 在最右端还有一个控制点（实心黑圆），但未显示
// 其目标，可能暗示后续测量或其他未画出的操作；但在本图中，
// 它似乎只是终点标记或与外部系统交互的接口。 所有符号说
// 明： “H” 表示 Hadamard 门。 “Rz(θ)” 表示绕 Z 轴的相位
// 旋转门，θ 为旋转角度，此处分别为 t/2 和 -t/2。 实心黑
// 圆表示控制位。 带叉圆圈表示目标位（通常用于 CNOT 或类
// 似受控门）。 垂直实线表示控制-目标之间的耦合。 趋势与
// 结论：该电路通过一系列 Hadamard 门、Z 轴旋转门以及多个
// 受控非门的组合，构建了一个复杂的干涉路径，常用于量子相
// 位估计、振幅放大或模拟哈密顿量演化等任务。特别地，Rz(t
// /2) 和 Rz(-t/2) 的对称放置可能用于抵消误差或实现特定幺
// 正变换。整个电路设计旨在利用量子叠加和纠缠来高效计算某
// 个物理量或执行特定算法步骤。 注：由于原图无子图划分（
// 如 a,b,c），此处将整个图像视为单一子图 a 进行描述。若
// 原意有多个子图，则需提供更多信息以拆分描述。当前基于给
// 定图片内容，仅能作为一个完整电路进行解析。
#figure(image("imgs/Ukin1FlavTrot.png", width: 12cm),
  caption: [
    A circuit that implements $exp [ - i t / 2 ( sigma^(+) Z Z sigma^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") ) ]$.
  ]
)
<fig:Ukin1flavTrot>

Similarly, for this system, the only contribution to $H_(e l)$ is $Q_n^(( a )) thin Q_n^(( a ))$, which contains three $Z Z$ terms that are Trotterized using the standard two CNOT implementation. The complete set of circuits required for Trotterized time evolution are given in App.~@app:Nf1SU3circs.

To map the system onto a quantum device, it is necessary to understand the required connectivity for efficient simulation. Together, the hopping and chromo-electric terms require connectivity between nearest neighbors as well as between $q_r$ and $q_b$ and $q$s and $overline(q)$s of the same color. The required device topology is planar and two embedding options are shown in @fig:TrotTopo.

// [figvision-cn] imgs/1FlavConnectivity.png
// 该图包含两个并列的子图，分别展示了用于实现 Trotterized
// 时间演化的两种潜在量子器件拓扑结构。 子图（左）： 类型：
// 示意图（网络拓扑图）。 物体与布局：该图由六个节点和连
// 接它们的直线组成。节点以蓝色实心圆点表示，并标记为数字
// 0至5。 具体连接关系如下： 节点0位于顶部，通过黑色直线
// 连接到节点1、节点2和节点3。 节点1位于左侧中间，除了连
// 接节点0外，还连接到节点2和节点4。 节点3位于右侧中间，
// 除了连接节点0外，还连接到节点2和节点4。 节点2位于中心
// 位置，处于一条垂直线上，向上连接节点0，向下连接节点5，
// 向左连接节点1，向右连接节点3。 节点5位于中心下方，处于
// 同一条垂直线上，向上连接节点2，向下连接节点4。 节点4位
// 于底部，向上连接节点5，向左上连接节点1，向右上连接节点
// 3。 整体几何形状呈现为一个菱形（顶点为0, 1, 4, 3），内
// 部包含一个十字交叉结构（节点1-2-3水平线，节点0-2-5-4垂
// 直线）。 子图（右）： 类型：示意图（网络拓扑图）。 物
// 体与布局：该图同样由六个节点和连接它们的直线组成。节点
// 以蓝色实心圆点表示，并标记为数字0至5。 具体连接关系如
// 下： 节点0位于顶部，连接到节点1、节点2和节点3。 节点1
// 位于左侧，连接到节点0、节点2和节点4。 节点3位于右侧，
// 连接到节点0、节点2和节点5。 节点2位于中心位置，呈星形
// 辐射状连接到所有其他五个节点（0, 1, 3, 4, 5）。 节点4
// 位于左下角，连接到节点1和节点2，并通过一条水平黑线连接
// 到节点5。 节点5位于右下角，连接到节点3和节点2，并通过
// 一条水平黑线连接到节点4。 整体几何形状呈现为一个五边形
// （顶点为0, 1, 4, 5, 3），其中每个外部顶点都通过直线连
// 接到中心节点2，且底边4-5直接相连。
#figure(image("imgs/1FlavConnectivity.png", width: 12cm),
  caption: [
    Two potential quantum device topologies for the implementation of Trotterized time evolution.
  ]
)
<fig:TrotTopo>

The "kite" topology follows from the above circuits, while the "wagon wheel" topology makes use of the identities $C X ( q_a , q_b ) dot.op C X ( q_b , q_c ) = C X ( q_a , q_c ) dot.op C X ( q_b , q_c ) = C X ( q_b , q_a ) dot.op C X ( q_a , q_c )$ where $C X ( q_a , q_b )$ denotes a CNOT controlled on qubit $q_a$. Both topologies can be employed on devices with all-to-all connectivity, such as trapped-ion systems, but neither topology exists natively on available superconducting-qubit devices.

We performed leading-order Trotter evolution to study the trivial vacuum persistence and transition probability using IBM's quantum computers `ibmq_jakarta` and `ibm_perth`, each a `r5.11H` quantum processor with 7 qubits and “H”-connectivity. The circuits developed for this system require a higher degree of connectivity than available with these devices, and so SWAP-gates were necessary for implementation. The IBM `transpiler` was used to first compile the circuit for the H-connectivity and then again to compile the Pauli twirling (discussed next). An efficient use of SWAP-gates allows for a single Trotter step to be executed with 34 CNOTs.

A number of error-mitigation techniques were employed to minimize associated systematic uncertainties in our calculations: randomized compiling of the CNOTs (Pauli twirling)~@PhysRevA.94.052325 combined with decoherence renormalization~@Urbanek:2021oej @Rahman:2022rlg, measurement error mitigation, post-selecting on physical states and dynamical decoupling~@PhysRevA.58.2733 @DUAN1999139 @ZANARDI199977 @PhysRevLett.82.2417.#footnote[A recent detailed study of the stability of some of IBM's quantum devices using a system of physical interest can be found in Ref.~@Yeter-Aydeniz:2022vuy.] The circuits were randomly complied with each CNOT Pauli-twirled as a mechanism to transform coherent errors in the CNOT gates into statistical noise in the ensemble. This has been shown to be effective in improving the quality of results in other simulations, for example, Refs.~@Kim2021ScalableEM @Rahman:2022rlg. Pauli twirling involves multiplying the right side of each CNOT by a randomly chosen element of the two-qubit Pauli group, $G_2$, and the left side by $G'_2$ such that $G'_2 thin C X thin G_2 = C X$ (up to a phase). For an ideal CNOT gate, this would have no effect on the circuit. A table of required CNOT identities is given, for example, in an appendix in Ref.~@Rahman:2022rlg. Randomized Pauli-twirling is combined with performing measurements of a “non-physics”, mitigation circuit, which is the time evolution circuit evaluated at $t = 0$, and is the identity in the absence of noise. Assuming that the randomized-compiling of the Pauli-twirled CNOTs transforms coherent noise into depolarizing noise, the fractional deviation of the noiseless and computed results from the asymptotic limit of complete decoherence are expected to be approximately equal for both the physics and mitigation ensembles. Assuming linearity, it follows that

$ (P_(upright("pred"))^(( upright("phys") )) - 1 / 8) = (P_(upright("meas"))^(( upright("phys") )) - 1 / 8) times (frac(1 - 1 / 8, P_(upright("meas"))^(( upright("mit") )) - 1 / 8)) med , $<eq:mit>

where $P_(upright("meas"))^(( upright("phys") ))$ and $P_(upright("meas"))^(( upright("mit") ))$ are post-processed probabilities and $P_(upright("pred"))^(( upright("phys") ))$ is an estimate of the probability once the effects of depolarizing noise have been removed. The “$1 / 8$” represents the fully decohered probability after post-selecting on physical states (described next) and the “$1$” is the probability of measuring the initial state from the mitigation circuit in the absence of noise.

The computational basis of 6 qubits contains $2^6$ states but time evolution only connects those with the same $r$, $g$ and $b$. Starting from the trivial vacuum, this implies that only the $8$ states with $r = g = b = 0$ are accessible through time evolution. The results off the quantum computer were post-processed to only select events that populated 1 of the 8 physically allowed states, discarding outcomes that were unphysical. Typically, this resulted in a retention rate of $tilde 30 "%"$. The workflow interspersed physics and mitigation circuits to provide a correlated calibration of the quantum devices. This enabled the detection (and removal) of out-of-specs device performance during post-processing. We explored using the same twirling sequences for both physics and mitigation circuits and found that it had no significant impact. The impact of dynamical decoupling of idle qubits using `qiskit`'s built in functionality was also investigated and found to have little effect. The results of each run were corrected for measurement error using IBM's available function, `TensoredMeasFitter`, and associated downstream operations.

The results obtained for the trivial vacuum-to-vacuum and trivial vacuum-to-$q_r overline(q)_r$ probabilities from one step of leading-order Trotter time evolution are shown in @fig:IBMresults. For each time, 447 Pauli-twirled physics circuits and 447 differently twirled circuits with zeroed angles (mitigation) were analyzed using $10^3$ shots on both `ibmq_jakarta` and `ibm_perth` (to estimate device systematics). After post-selecting on physical states, correlated Bootstrap Resampling was used to form the final result.#footnote[As the mitigation and physics circuits were executed as adjacent jobs on the devices, the same Bootstrap sample was used to select results from both ensembles to account for temporal correlations.]

// [figvision-cn] imgs/VacToDevice.png
// 该图包含两个并排的散点曲线子图，分别标记为左图和右图，
// 均展示概率随时间变化的关系。 左图标题为“Trivial
// Vacuum-to-Vacuum”。纵坐标轴名称为“Probability”，范围从
// 0.0到1.0，刻度间隔为0.2。横坐标轴名称为“t”，范围从0到5，
// 刻度标记为1, 2, 3, 4, 5。图中有一条黑色虚线曲线，代表
// 理论预期值（Theory），即一阶Trotter演化的结果。该曲线
// 从t=0时的概率1.0开始下降，在t=1处约为0.45，在t=2处接近
// 0，在t=3处再次接近0，随后缓慢上升，在t=5处约为0.25。数
// 据点包括红色实心圆点和蓝色实心圆点，分别代表使用IBM量
// 子计算机`ibmq_jakarta`和`ibm_perth`的实验结果。这些点
// 紧密分布在黑色虚线周围。图中有两个椭圆形的放大区域：左
// 侧放大圈位于t约等于1.5处，显示红蓝数据点与虚线几乎重合；
// 右侧放大圈位于t约等于3.5处，同样显示红蓝数据点聚集在虚
// 线附近，且误差棒极小。右上角有一个IBM Quantum的标志。
// 右图标题为“Trivial Vacuum-to-q_r q_bar_r”。纵坐标轴名
// 称为“Probability”，范围从0.0到0.15以上，刻度标记为0.05
// , 0.10, 0.15。横坐标轴名称为“t”，范围从0到5，刻度标记
// 为1, 2, 3, 4, 5。图中同样有一条黑色虚线曲线，代表理论
// 预期值。该曲线呈周期性振荡，在t=0时为0，在t约等于1.2处
// 达到峰值约0.15，在t约等于2.4处降至接近0，在t约等于3.6
// 处再次接近0，在t=5处再次上升至约0.15。数据点包括红色实
// 心圆点（`ibmq_jakarta`）和蓝色实心圆点（`ibm_perth`），
// 它们大致跟随黑色虚线的趋势，但在某些位置（如t=3附近）
// 显示出较大的离散或负值偏差。右上角有一个方框图例，标明
// 黑色虚线为“Theory”，红色圆点为“ibmq_jakarta”，蓝色圆点
// 为“ibm_perth”。右上角同样有IBM Quantum的标志。
#figure(image("imgs/VacToDevice.png", width: 100%),
  caption: [
    The trivial vacuum-to-vacuum (left panel) and trivial vacuum-to-$q_r overline(q)_r$ (right panel) probabilities for $N_f = 1$ QCD and $m = g = L = 1$. The dashed-black curve shows the expected result from one step of leading-order Trotter evolution. The results, given in @tab:IBMvacresultsLO and~@tab:IBMrrbresultsLO, were obtained by using $10^3$ shots for 447 Pauli-twirled circuits using IBM's quantum computers `ibmq_jakarta` (red) and `ibm_perth` (blue).
  ]
)
<fig:IBMresults>

@tab:IBMvacresultsLO and~@tab:IBMrrbresultsLO display the results of the calculations performed using `ibmq_jakarta` and `ibm_perth` quantum computers. The same mitigation data was used for both the trivial vacuum-to-vacuum and trivial vacuum-to-$q_r overline(q)_r$ calculations, and is provided in columns 2 and 4 of @tab:IBMvacresultsLO. See App.~@app:LOTrott for an extended discussion of leading-order Trotter. Note that the negative probabilities seen in @fig:IBMresults indicate that additional non-linear terms are needed in @eq:mit.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 8,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 8)[Vacuum-to-Vacuum Probabilities for $N_f = 1$ QCD from IBM's `ibmq_jakarta` and `ibm_perth`],),
  table.hline(),
  [$t$], [Mitigation #linebreak() `ibmq_jakarta`], [Physics #linebreak() `ibmq_jakarta`], [Mitigation #linebreak() `ibm_perth`], [Physics #linebreak() `ibm_perth`], [Results #linebreak() `ibmq_jakarta`], [Results #linebreak() `ibm_perth`], [Theory],
  table.hline(),
  [0], [-], [-], [-], [-], [-], [-], [1],
  [0.5], [0.9176(10)], [0.7607(24)], [0.8744(23)], [0.7310(42)], [0.8268(27)], [0.8326(52)], [0.8274],
  [1.0], [0.9059(12)], [0.4171(32)], [0.9118(16)], [0.4211(39)], [0.4523(36)], [0.4543(43)], [0.4568],
  [1.5], [0.9180(12)], [0.1483(16)], [0.9077(17)], [0.1489(23)], [0.1507(17)], [0.1518(25)], [0.1534],
  [2.0], [0.8953(15)], [0.0292(08)], [0.8953(21)], [0.0324(10)], [0.0162(09)], [0.0198(11)], [0.0249],
  [2.5], [0.9169(12)], [0.0020(01)], [0.8938(21)], [0.0032(02)], [-0.0109(03)], [-0.0136(04)], [0.0010],
  [3.0], [0.9282(13)], [0.00010(2)], [0.9100(13)], [0.00017(3)], [-0.0111(02)], [-0.0140(02)], [$1.3 times 10^(- 7)$],
  [3.5], [0.9357(10)], [0.00017(3)], [0.9109(14)], [0.00037(4)], [-0.0097(02)], [-0.0138(02)], [$3.2 times 10^(- 5)$],
  [4.0], [0.9267(13)], [0.0081(03)], [0.9023(14)], [0.0076(03)], [-0.0026(04)], [-0.0072(04)], [0.0052],
  [4.5], [0.9213(12)], [0.0653(10)], [0.8995(16)], [0.0619(11)], [0.0594(11)], [0.0537(13)], [0.0614],
  [5.0], [0.9105(12)], [0.2550(26)], [0.9031(14)], [0.2405(21)], [0.2698(29)], [0.2550(23)], [0.2644],
  
  )],
  caption: [ The trivial vacuum-to-vacuum probabilities for $m = g = L = 1$ using `ibmq_jakarta` and `ibm_perth`, the underlying distributions of which are displayed in @fig:IBMhistos. The 2nd through 5th columns are the results after selecting only physical states and columns $6$ and $7$ are the results after using the mitigation circuit to account for depolarizing noise. ], kind: table
  )
<tab:IBMvacresultsLO>

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 6,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 6)[Vacuum-to-$q_r overline(q)_r$ Probabilities for $N_f = 1$ QCD from IBM's `ibmq_jakarta` and `ibm_perth`],),
  table.hline(),
  [$t$], [Physics #linebreak() `ibmq_jakarta`], [Physics #linebreak() `ibm_perth`], [Results #linebreak() `ibmq_jakarta`], [Results #linebreak() `ibm_perth`], [Theory],
  table.hline(),
  [0], [-], [-], [-], [-], [0],
  [0.5], [0.0760(12)], [0.0756(22)], [0.0709(13)], [0.0673(26)], [0.0539],
  [1.0], [0.1504(19)], [0.1253(32)], [0.1534(22)], [0.1254(36)], [0.1363],
  [1.5], [0.1364(15)], [0.1144(21)], [0.1376(17)], [0.1131(23)], [0.1332],
  [2.0], [0.0652(11)], [0.0611(15)], [0.0571(13)], [0.0525(17)], [0.0603],
  [2.5], [0.0136(04)], [0.0137(06)], [0.0019(05)], [-0.0017(07)], [0.0089],
  [3.0], [0.0017(01)], [0.0011(01)], [-0.0093(02)], [-0.0132(02)], [$2.5 times 10^(- 5)$],
  [3.5], [0.0024(01)], [0.0032(02)], [-0.0073(02)], [-0.0107(03)], [0.0010],
  [4.0], [0.0314(07)], [0.0288(07)], [0.0228(08)], [0.0167(08)], [0.0248],
  [4.5], [0.0971(12)], [0.0929(14)], [0.0943(13)], [0.0887(16)], [0.0943],
  [5.0], [0.1534(20)], [0.1546(19)], [0.1566(22)], [0.1583(21)], [0.1475],
  
  )],
  caption: [ The trivial vacuum-to-$q_r overline(q)_r$ probabilities for $m = g = L = 1$ using `ibmq_jakarta` and `ibm_perth`. The 2nd and 3rd columns are the results after selecting only physical states and columns 4 and 5 are the results after using the mitigation circuit to account for depolarizing noise. ], kind: table
  )
<tab:IBMrrbresultsLO>

It is interesting to consider the distributions of events obtained from the Pauli-twirled circuits, as shown in @fig:IBMhistos.

// [figvision-cn] imgs/IBMhistos.png
// 该图由四个直方图和右侧一个共享图例组成，分为上下两行排
// 列。 左上子图（a）：标题为“ibmq_jakarta”的直方图。横轴
// 名为“Physics Probability”，范围从0.0到1.0，刻度标记为
// 0.2、0.4、0.6、0.8、1.0。纵轴名为“log(counts)”，采用对
// 数标度，数值范围从0.5到500，主刻度标记为0.5、1、5、10、
// 50、100、500。图中包含多个重叠的彩色柱状条，代表不同演
// 化时间t下的分布。颜色与时间的对应关系见右侧图例：浅橙
// 色(t=0.5)、浅蓝色(t=1.0)、浅绿色(t=1.5)、粉红色(t=2.0)、
// 紫色(t=2.5)、棕色(t=3.0)、青色(t=3.5)、黄色(t=4.0)、紫
// 红色(t=4.5)、橄榄绿(t=5.0)。数据趋势显示，随着演化时间
// t增加，概率分布逐渐向左侧移动，即物理概率值变小；例如t
// =0.5时峰值位于约0.7-0.8区间，而t=5.0时峰值移至约
// 0.1-0.2区间。右上角有一个量子芯片图标及字母“q”。 右上
// 子图（b）：标题为“ibm_perth”的直方图。坐标轴设置与左上
// 子图完全相同：横轴“Physics Probability”（0.0-1.0），纵
// 轴“log(counts)”（对数标度，0.5-500）。使用相同的颜色编
// 码表示不同t值。分布形态与左上图相似，也呈现随t增大向左
// 漂移的趋势，但具体峰值位置和宽度略有差异。同样在右上角
// 有量子芯片图标及“q”。 右下子图（c）：标题为“ibm_perth”
// 的直方图。横轴名为“Mitigation Probability”，范围0.0到
// 1.0，刻度同上。纵轴名为“log(counts)”，对数标度，范围
// 0.5到100，主刻度标记为0.5、1、5、10、50、100。图中柱状
// 条主要集中在0.7至1.0之间，且所有颜色的分布高度重叠，表
// 明经过误差缓解处理后，不同t值的概率分布趋于一致并集中
// 在高概率区域。右上角有量子芯片图标及“q”。 左下子图（d）：
// 标题为“ibmq_jakarta”的直方图。坐标轴设置与右下子图相同：
// 横轴“Mitigation Probability”（0.0-1.0），纵轴“log(
// counts)”（对数标度，0.5-100）。分布特征与右下子图类似，
// 柱状条密集分布在0.7以上，各颜色曲线几乎重合，说明误差
// 缓解有效提升了结果的一致性并抑制了噪声导致的分散。右上
// 角有量子芯片图标及“q”。 右侧图例：垂直排列，列出10种颜
// 色及其对应的演化时间t值，从上到下依次为：浅橙色 t=0.5；
// 浅蓝色 t=1.0；浅绿色 t=1.5；粉红色 t=2.0；紫色 t=2.5；
// 棕色 t=3.0；青色 t=3.5；黄色 t=4.0；紫红色 t=4.5；橄榄
// 绿 t=5.0。每个条目左侧为小方块色块，右侧为文字标注。
// 整体结论：上排子图展示原始物理电路输出随演化时间延长而
// 退化（概率分布左移），下排子图显示经误差缓解处理后，无
// 论演化时间长短，真空态概率均被恢复并集中接近1.0，证明
// 所提方法能有效校正噪声影响。
#figure(image("imgs/IBMhistos.png", width: 100%),
  caption: [
    Histograms of the post-processed vacuum-to-vacuum results obtained using `ibmq_jakarta` and `ibm_perth`. The horizontal axes show the value of the vacuum-to-vacuum probability, and the vertical axes show bin counts on a log-scale. The top panels display the results obtained from the physics circuits for the range of evolution times and the bottom panels display the results obtained for the corresponding mitigation circuits.
  ]
)
<fig:IBMhistos>

The distributions are not Gaussian and, in a number of instances, exhibit heavy tails particularly near the boundaries.#footnote[For a study of heavy-tailed distributions in Euclidean-space lattice QCD calculations, see Refs.~@Wagman:2016bam @Wagman:2017gqi.] The spread of the distributions, associated with non-ideal CNOT gates, is seen to reach a maximum of $tilde 0.4$, but with a full-width at half-max that is $tilde 0.2$. These distributions are already broad with a 34 CNOT circuit, and we probed the limit of these devices by time-evolving with two first-order Trotter steps,#footnote[Under a particular ordering of terms, two steps of first- and second-order Trotter time evolution are equivalent.] which requires 91 CNOTs after accounting for SWAPs. Using the aforementioned techniques, this was found to be beyond the capabilities of `ibmq_jakarta`, `ibmq_lagos` and `ibm_perth`.

= ARBITRARY $N_c$ AND $N_f$<sec:NcNf>
In this section, the structure of the Hamiltonian for $N_f$ flavors of quarks in the fundamental representation of $S U ( N_c )$ is developed. The mapping to spins has the same structure as for $N_f = 2$ QCD, but now, there are $N_c times N_f q$s and $N_c times N_f overline(q)$s per spatial lattice site. While the mass and kinetic terms generalize straightforwardly, the energy in the chromo-electric field is more tricky. After enforcing Gauss's law, it is

$ H_(e l) = g^2 / 2 sum_(n = 0)^(2 L - 2) (sum_(m lt.eq n) Q_m^(( a )))^2 med , med med Q_m^(( a )) = phi.alt_m^dagger T^a phi.alt_m med , $

where $T^a$ are now the generators of $S U ( N_c )$. The Hamiltonian, including chemical potentials for baryon number (chemical potentials for other flavor combinations can be included as needed), is found to be

<eq:HNfNc>

$ H = & med H_(k i n) med + med H_m med + med H_(e l) med + med H_(mu_B) med ,\
H_(k i n) = & med 1 / 2 sum_(n = 0)^(2 L - 2) sum_(f = 0)^(N_f - 1) sum_(c = 0)^(N_c - 1) [sigma_(i ( n , f , c ))^(+) (⨂_(j = 1)^(N_c N_f - 1) ( - sigma_(i ( n , f , c ) + j)^z )) sigma_(i ( n , f , c ) + N_c N_f)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".")] med ,\
H_m = & med 1 / 2 sum_(n = 0)^(2 L - 1) sum_(f = 0)^(N_f - 1) sum_(c = 0)^(N_c - 1) m_f [( - 1 )^n sigma_(i ( n , f , c ))^z + 1] med ,\
H_(e l) = & med g^2 / 2 sum_(n = 0)^(2 L - 2) ( 2 L - 1 - n ) (sum_(f = 0)^(N_f - 1) Q_(n , f)^(( a )) thin Q_(n , f)^(( a )) med med + med med 2 sum_(f = 0)^(N_f - 2) sum_(f' = f + 1)^(N_f - 1) Q_(n , f)^(( a )) thin Q_(n , f')^(( a )))\
 & + g^2 sum_(n = 0)^(2 L - 3) sum_(m = n + 1)^(2 L - 2) ( 2 L - 1 - m ) sum_(f = 0)^(N_f - 1) sum_(f' = 0)^(N_f - 1) Q_(n , f)^(( a )) thin Q_(m , f')^(( a )) med ,\
H_(mu_B) = & med - frac(mu_B, 2 N_c) sum_(n = 0)^(2 L - 1) sum_(f = 0)^(N_f - 1) sum_(c = 0)^(N_c - 1) sigma_(i ( n , f , c ))^z med , $<eq:HkinN>

where, $i ( n , f , c ) = ( N_c N_f n + N_f f + c )$, and the products of the charges are

$ 4 Q_(n , f)^(( a )) thin Q_(n , f)^(( a )) = & med frac(N_c^2 - 1, 2) - (1 + 1 / N_c) sum_(c = 0)^(N_c - 2) sum_(c' = c + 1)^(N_c - 1) sigma_(i ( n , f , c ))^z sigma_(i ( n , f , c' ))^z med ,\
8 Q_(n , f)^(( a )) thin Q_(m , f')^(( a )) = & med 4 sum_(c = 0)^(N_c - 2) sum_(c' = c + 1)^(N_c - 1) [sigma_(i ( n , f , c ))^(+) med (⊗ Z)_(( n , f , c , c' )) med sigma_(i ( n , f , c' ))^(-) sigma_(i ( m , f' , c ))^(-) med (⊗ Z)_(( m , f' , c , c' )) med sigma_(i ( m , f' , c' ))^(+) + upright("h") thin upright(".") thin upright("c") thin upright(".")] med\
 & + sum_(c = 0)^(N_c - 1) sum_(c' = 0)^(N_c - 1) (delta_(c c') - 1 / N_c) sigma_(i ( n , f , c ))^z sigma_(i ( m , f' , c' ))^z med ,\
(⊗ Z)_(( n , f , c , c' )) equiv & med ⨂_(k = 1)^(c' - c - 1) sigma_(i ( n , f , c ) + k)^z med . $<eq:QnfQmfpN>

The resource requirements for implementing Trotterized time evolution using generalizations of the circuits in @sec:Circuits are given in @eq:RHCN.

It is interesting to consider the large-$N_c$ limit of the Hamiltonian, where quark loops are parametrically suppressed and the system can be described semi-classically~@tHooft:1973alw @tHooft:1974pnl @Witten:1979kh @RevModPhys.54.407. Unitarity requires rescaling the strong coupling, $g^2 arrow.r g^2 / N_c$ and leading terms in the Hamiltonian scale as $cal(O) ( N_c )$. The leading order contribution to the product of charges is

$ 4 Q_(n , f)^(( a )) thin Q_(n , f)^(( a )) = & med sum_(c = 0)^(N_c - 2) sum_(c' = c + 1)^(N_c - 1) (1 - sigma_(i ( n , f , c ))^z sigma_(i ( n , f , c' ))^z) med ,\
8 Q_(n , f)^(( a )) thin Q_(m , f')^(( a )) = & med 4 sum_(c = 0)^(N_c - 2) sum_(c' = c + 1)^(N_c - 1) [sigma_(i ( n , f , c ))^(+) med (⊗ Z)_(( n , f , c , c' )) med sigma_(i ( n , f , c' ))^(-) sigma_(i ( m , f' , c ))^(-) med (⊗ Z)_(( m , f' , c , c' )) med sigma_(i ( m , f' , c' ))^(+) + upright("h") thin upright(".") thin upright("c") thin upright(".")] med . $

Assuming that the number of $q overline(q)$ pairs that contribute to the meson wavefunctions do not scale with $N_c$, as expected in the large-$N_c$ limit, $H_(e l) prop N_c$ and mesons are non-interacting, a well known consequence of the large-$N_c$ limit~@tHooft:1973alw @tHooft:1974pnl. Baryons on the other hand are expected to have strong interactions at leading order in $N_c$~@Witten:1979kh. This is a semi-classical limit and we expect that there exists a basis where states factorize into localized tensor products, and the time evolution operator is non-entangling. The latter result has been observed in the large-$N_c$ limit of hadronic scattering~@Beane:2018oxh @Beane:2021zvo @Low:2021ufv @Aoude:2020mlg @Cervera-Lierta:2017tdt.

= SUMMARY AND DISCUSSION
<sec:SandC>
Important for future quantum simulations of processes that can be meaningfully compared to experiment, the real-time dynamics of strongly-interacting systems are predicted to be efficiently computable with quantum computers of sufficient capability. Building upon foundational work in quantum chemistry and in low-dimensional $U ( 1 )$ and $S U ( 2 )$ gauge theories, this work has developed the tools necessary for the quantum simulation of $1 + 1$D QCD (in axial gauge) using open boundary conditions, with arbitrary numbers of quark flavors and colors and including chemical potentials for baryon number and isospin. Focusing largely on QCD with $N_f = 2$, which shares many of the complexities of QCD in $3 + 1$D, we have performed a detailed analysis of the required quantum resources for simulation of real-time dynamics, including efficient quantum circuits and associated gate counts, and the scaling of the number of Trotter steps for a fixed-precision time evolution. The structure and dynamics of small systems, with $L = 1 , 2$ for $N_c = 3$ and $N_f = 1 , 2$ have been detailed using classical computation, quantum simulators, D-Wave's `Advantage` and IBM's 7-qubit devices `ibmq_jakarta` and `ibm_perth`. Using recently developed error mitigation strategies, relatively small uncertainties were obtained for a single Trotter step with $34$ CNOT gates after transpilation onto the QPU connectivity.

Through a detailed study of the low-lying spectrum, both the relevant symmetries and the color-singlets in the mesonic and baryonic sectors, including a bound two-baryon nucleus, have been identified. Open boundary conditions also permit low-lying color edge-states that penetrate into the lattice volume by a distance set by the confinement scale. By examining quark entanglement in the hadrons, a transition from the mesons being primarily composed of quark-antiquarks to baryon-antibaryons was found. We have presented the relative contributions of each of the terms in the Hamiltonian to the energy of the vacuum, mesons and baryons.

This work has provided an estimate for the number of CNOT-gates required to implement one Trotter step in $N_f = 2$, $1 + 1$D axial-gauge QCD. For $L = 10$ spatial sites, $tilde 3 times 10^4$ CNOTs are required, while $tilde 4 times 10^6$ CNOTs are required for $L = 100$. Realistically, quantum simulations with $L = 10$ are a beginning toward providing results with a complete quantification of uncertainties, including lattice-spacing and finite-volume artifacts, and $L = 100$ will likely yield high-precision results. It was found that, in the axial-gauge formulation, resources for time evolution effectively scale as $L^2 t$ for intermediate times and $L^2 t^2$ for asymptotic times. With $L tilde t$, this asymptotic scaling is the same as in the Schwinger model, suggesting no differences in scaling between Weyl and axial gauges.

#heading(numbering: none)[Acknowledgments]

#block[
We would like to thank Fabio Anza, Anthony Ciavarella, Stephan Caspar, David B.~Kaplan, Natalie Klco, Sasha Krassovsky and Randy Lewis for very helpful discussions and insightful comments. We would also like to thank Christian Bauer, Ewout van den Berg, Alaina Green, Abhinav Kandala, Antonio Mezzacapo, Mohan Sarovar and Prasanth Shyamsundar for very helpful discussions during the IQuS-INT workshop on #emph[Quantum Error Mitigation for Particle and Nuclear Physics], May 9-13, 2022 (#link("https://iqus.uw.edu/events/iqus-workshop-22-1b")).

]

This work was supported, in part, by the U.S. Department of Energy grant DE-FG02-97ER-41014 (Farrell), the U.S. Department of Energy, Office of Science, Office of Nuclear Physics, InQubator for Quantum Simulation (IQuS) (#link("https://iqus.uw.edu")) under Award Number DOE (NP) Award DE-SC0020970 (Chernyshev, Farrell, Powell, Savage, Zemlevskiy), and the Quantum Science Center (QSC) (#link("https://qscience.org")), a National Quantum Information Science Research Center of the U.S. Department of Energy (DOE) (Illa). This work is also supported, in part, through the Department of Physics (#link("https://phys.washington.edu")) and the College of Arts and Sciences (#link("https://www.artsci.washington.edu")) at the University of Washington.

We acknowledge the use of IBM Quantum services~@IBMQ for this work. The views expressed are those of the authors, and do not reflect the official policy or position of IBM or the IBM Quantum team. In this paper we used `ibm_lagos`, `ibm_perth` and `ibmq_jakarta`, which are three of the IBM's r5.11H Quantum Processors. All calculations performed on D-Wave's QAs were through cloud access~@DwaveLeap. We have made extensive use of Wolfram `Mathematica`~@Mathematica, `python`~@python3 @Hunter:2007, `julia`~@Julia-2017, `jupyter` notebooks~@PER-GRA:2007 in the `Conda` environment~@anaconda, and the quantum programming environments: Google's `cirq`~@cirq_developers_2022_6599601 and IBM's `qiskit`~@gadi_aleksandrowicz_2019_2562111.

This work was enabled, in part, by the use of advanced computational, storage and networking infrastructure provided by the Hyak supercomputer system at the University of Washington

\(#link("https://itconnect.uw.edu/research/hpc")).

= MAPPING TO QUBITS
<app:hamConst>
This appendix outlines how the qubit Hamiltonian in @eq:H2flav is obtained from the lattice Hamiltonian in @eq:GFHam. For this system, the constraint of Gauss's law is sufficient to uniquely determine the chromo-electric field carried by the links between lattice sites in terms of a background chromo-electric field and the distribution of color charges. The difference between adjacent chromo-electric fields at a site with charge $Q^(( a ))$ is

$ upright(bold(E))_(n + 1)^(( a )) - upright(bold(E))_n^(( a )) = Q_n^(( a )) med , $<eq:GaussLaw>

for $a = 1$ to $8$, resulting in a chromo-electric field

$ upright(bold(E))_n^(( a )) = upright(bold(F))^(( a )) med + med sum_(i lt.eq n) Q_i^(( a )) med . $<eq:GaussLawSol>

In general, there can be a non-zero background chromo-electric field, $upright(bold(F))^(( a ))$, which in this paper has been set to zero. Inserting the chromo-electric field in terms of the charges into @eq:KSHam yields @eq:GFHam.

The color and flavor degrees of freedom of each $q$ and $overline(q)$ are then distributed over $6$ ($= N_c N_f$) sites as illustrated in Fig.~(@fig:2flavLayout). There are now creation and annihilation operators for each quark, and the Hamiltonian is

$ H = & med sum_(n = 0)^(2 L - 1) sum_(f = 0)^1 sum_(c = 0)^2 [m_f ( - 1 )^n psi_(6 n + 3 f + c)^dagger psi_(6 n + 3 f + c) med - med mu_B / 3 psi_(6 n + 3 f + c)^dagger psi_(6 n + 3 f + c) med - med mu_I / 2 ( - 1 )^f psi_(6 n + 3 f + c)^dagger psi_(6 n + 3 f + c)]\
 & + 1 / 2 sum_(n = 0)^(2 L - 2) sum_(f = 0)^1 sum_(c = 0)^2 (psi_(6 n + 3 f + c)^dagger psi_(6 ( n + 1 ) + 3 f + c) + med upright("h") thin upright(".") thin upright("c") thin upright(".")) med + med g^2 / 2 sum_(n = 0)^(2 L - 2) (sum_(m lt.eq n) sum_(f = 0)^1 Q_(m , f)^(( a )))^2 med , $<eq:FockHam>

where the color charge is evaluated over three $( r , g , b )$ occupation sites with the same flavor,

$ Q_(m , f)^(( a )) = sum_(c = 0)^2 sum_(c' = 0)^2 psi_(6 m + 3 f + c)^dagger med T_(c c')^a med psi_(6 m + 3 f + c') med , $

and the $T^a$ are the eight generators of $S U ( 3 )$. The fermionic operators in Fock space are mapped onto spin operators via the JW transformation,

$ psi_n = ⨂_(l < n) ( - sigma_l^z ) sigma_n^(-) med , med med psi_n^dagger = ⨂_(l < n) ( - sigma_l^z ) sigma_n^(+) med . $<eq:JW>

In terms of spins, the eight $S U ( 3 )$ charge operators become#footnote[Calculations of quadratics of the gauge charges are simplified by the Fierz identity,]

$ ( T^(( a )) )_beta^alpha thin ( T^(( a )) )_delta^gamma = 1 / 2 ( delta_delta^alpha delta_beta^gamma - 1 / N_c delta_beta^alpha delta_delta^gamma ) med . $

$ Q_(m , f)^(( 1 )) = & med 1 / 2 sigma_(6 m + 3 f)^(+) sigma_(6 m + 3 f + 1)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
Q_(m , f)^(( 2 )) = & med - i / 2 sigma_(6 m + 3 f)^(+) sigma_(6 m + 3 f + 1)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
Q_(m , f)^(( 3 )) = & med 1 / 4 ( sigma_(6 m + 3 f)^z - sigma_(6 m + 3 f + 1)^z ) med ,\
Q_(m , f)^(( 4 )) = & med - 1 / 2 sigma_(6 m + 3 f)^(+) sigma_(6 m + 3 f + 1)^z sigma_(6 m + 3 f + 2)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
Q_(m , f)^(( 5 )) = & med i / 2 sigma_(6 m + 3 f)^(+) sigma_(6 m + 3 f + 1)^z sigma_(6 m + 3 f + 2)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
Q_(m , f)^(( 6 )) = & med 1 / 2 sigma_(6 m + 3 f + 1)^(+) sigma_(6 m + 3 f + 2)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
Q_(m , f)^(( 7 )) = & med - i / 2 sigma_(6 m + 3 f + 1)^(+) sigma_(6 m + 3 f + 2)^(-) + upright("h") thin upright(".") thin upright("c") thin upright(".") med ,\
Q_(m , f)^(( 8 )) = & med frac(1, 4 sqrt(3)) ( sigma_(6 m + 3 f)^z + sigma_(6 m + 3 f + 1)^z - 2 sigma_(6 m + 3 f + 2)^z ) med . $<eq:SU3chargesFull>

Substituting @eq:JW and~@eq:SU3chargesFull into @eq:FockHam gives the Hamiltonian in @eq:H2flav. For reference, the expanded Hamiltonian for $L = 1$ is

<eq:H2flavL1>

$ H = & med H_(k i n) med + med H_m med + med H_(e l) med + med H_(mu_B) med + med H_(mu_I) med ,\
H_(k i n) = & med - 1 / 2 ( sigma_6^(+) sigma_5^z sigma_4^z sigma_3^z sigma_2^z sigma_1^z sigma_0^(-) + sigma_6^(-) sigma_5^z sigma_4^z sigma_3^z sigma_2^z sigma_1^z sigma_0^(+) + sigma_7^(+) sigma_6^z sigma_5^z sigma_4^z sigma_3^z sigma_2^z sigma_1^(-) + sigma_7^(-) sigma_6^z sigma_5^z sigma_4^z sigma_3^z sigma_2^z sigma_1^(+)\
 & + thin sigma_8^(+) sigma_7^z sigma_6^z sigma_5^z sigma_4^z sigma_3^z sigma_2^(-) + sigma_8^(-) sigma_7^z sigma_6^z sigma_5^z sigma_4^z sigma_3^z sigma_2^(+) + sigma_9^(+) sigma_8^z sigma_7^z sigma_6^z sigma_5^z sigma_4^z sigma_3^(-) + sigma_9^(-) sigma_8^z sigma_7^z sigma_6^z sigma_5^z sigma_4^z sigma_3^(+)\
 & + thin sigma_10^(+) sigma_9^z sigma_8^z sigma_7^z sigma_6^z sigma_5^z sigma_4^(-) + sigma_10^(-) sigma_9^z sigma_8^z sigma_7^z sigma_6^z sigma_5^z sigma_4^(+) + sigma_11^(+) sigma_10^z sigma_9^z sigma_8^z sigma_7^z sigma_6^z sigma_5^(-) + sigma_11^(-) sigma_10^z sigma_9^z sigma_8^z sigma_7^z sigma_6^z sigma_5^(+) ) med ,\
H_m = & med 1 / 2 [m_u (sigma_0^z + sigma_1^z + sigma_2^z - sigma_6^z - sigma_7^z - sigma_8^z + 6) + m_d (sigma_3^z + sigma_4^z + sigma_5^z - sigma_9^z - sigma_10^z - sigma_11^z + 6)] med ,\
H_(e l) = & med g^2 / 2 \[ 1 / 3 ( 3 - sigma_1^z sigma_0^z - sigma_2^z sigma_0^z - sigma_2^z sigma_1^z ) + sigma_4^(+) sigma_3^(-) sigma_1^(-) sigma_0^(+) + sigma_4^(-) sigma_3^(+) sigma_1^(+) sigma_0^(-) + sigma_5^(+) sigma_4^z sigma_3^(-) sigma_2^(-) sigma_1^z sigma_0^(+) + sigma_5^(-) sigma_4^z sigma_3^(+) sigma_2^(+) sigma_1^z sigma_0^(-)\
 & + thin sigma_5^(+) sigma_4^(-) sigma_2^(-) sigma_1^(+) + sigma_5^(-) sigma_4^(+) sigma_2^(+) sigma_1^(-)\
 & + thin 1 / 12 (2 sigma_3^z sigma_0^z + 2 sigma_4^z sigma_1^z + 2 sigma_5^z sigma_2^z - sigma_5^z sigma_0^z - sigma_5^z sigma_1^z - sigma_4^z sigma_2^z - sigma_4^z sigma_0^z - sigma_3^z sigma_1^z - sigma_3^z sigma_2^z) \] med ,\
H_(mu_B) = & med - mu_B / 6 (sigma_0^z + sigma_1^z + sigma_2^z + sigma_3^z + sigma_4^z + sigma_5^z - sigma_6^z + sigma_7^z + sigma_8^z + sigma_9^z + sigma_10^z + sigma_11^z) med ,\
H_(mu_I) = & med - mu_I / 4 (sigma_0^z + sigma_1^z + sigma_2^z - sigma_3^z - sigma_4^z - sigma_5^z + sigma_6^z + sigma_7^z + sigma_8^z - sigma_9^z - sigma_10^z - sigma_11^z) med . $<eq:Hkin2flavL1>

= SYMMETRIES OF THE FREE-QUARK HAMILTONIAN
<app:freeSym>
Here the symmetries of the free-quark Hamiltonian are identified to better understand the degeneracies observed in the spectrum of $1 + 1$D QCD with $N_f = 2$ and $L = 1$ as displayed in @fig:specDegenh and~@fig:specDegeng. Specifically, the Hamiltonian with $g = h = mu_B = mu_I = 0$, leaving only the hopping and mass terms ($m = m_u = m_d$), is

$ H = sum_(f = 0)^1 sum_(c = 0)^2 [m sum_(n = 0)^(2 L - 1) ( - 1 )^n psi_(6 n + 3 f + c)^dagger psi_(6 n + 3 f + c) med + med 1 / 2 sum_(n = 0)^(2 L - 2) (psi_(6 n + 3 f + c)^dagger psi_(6 ( n + 1 ) + 3 f + c) + med upright("h") thin upright(".") thin upright("c") thin upright("."))] med . $

The mapping of degrees of freedom is taken to be as shown in @fig:2flavLayout, but it will be convenient to work with Fock-space quark operators instead of spin operators. In what follows the focus will be on $L = 1$, and larger systems follow similarly.

The creation operators can be assembled into a 12-component vector, $Psi_i^dagger = ( psi_0^dagger , thin psi_1^dagger , dots.h , psi_10^dagger , thin psi_11^dagger )$, in terms of which the Hamiltonian becomes

$ H = Psi_i^dagger M_(i j) Psi_j med , $

where $M$ is a $12 times 12$ block matrix of the form,

$ M = [ & m & 1 / 2 \
    & "hline"
    1/2 & - m ] med , $

with each block a $6 times 6$ diagonal matrix. Diagonalizing $M$, gives rise to

$ tilde(M) = [ & lambda & 0 \
    & "hline"
    0 & - lambda ] med , med med lambda = 1 / 2 sqrt(1 + 4 m^2) med , $

with associated eigenvectors,

$ tilde(psi)_i = 1 / sqrt(2) (sqrt(1 + lambda / m) thin psi_i med + med sqrt(1 - lambda / m) thin psi_(6 + i)) med , med tilde(psi)_(6 + i) = 1 / sqrt(2) (- sqrt(1 - lambda / m) thin psi_i med + med sqrt(1 + lambda / m) thin psi_(6 + i)) med , $

where $tilde(psi)_i$ ($tilde(psi)_(6 + i)$) corresponds to the positive (negative) eigenvalue and the index $i$ takes values $0$ to $5$. These eigenvectors create superpositions of quarks and antiquarks with the same color and flavor, which are the OBC analogs of momentum plane-waves. In this basis, the Hamiltonian becomes

$ H = sum_(i = 0)^5 lambda (tilde(psi)_i^dagger tilde(psi)_i - tilde(psi)_(6 + i)^dagger tilde(psi)_(6 + i)) med , $<eq:Hamifree0>

which has a vacuum state,

$ | Omega_0 chevron.r = product_(i = 0)^(i = 5) tilde(psi)_(6 + i)^dagger | omega_0 chevron.r med , $

where $| omega_0 chevron.r$ is the unoccupied state, and $| Omega_0 chevron.r$ corresponds to $| 000000111111 chevron.r$ (in binary) in this transformed basis. Excited states are formed by acting with either $tilde(psi)_i^dagger$ or $tilde(psi)_(6 + i)$ on $| Omega_0 chevron.r$ which raises the energy of the system by $lambda$. A further transformation is required for the $S U ( 12 )$ symmetry to be manifest. In terms of the 12-component vector, $tilde(Psi)^dagger = ( tilde(psi)_0^dagger , thin dots.h , thin tilde(psi)_5^dagger , thin tilde(psi)_6 , thin dots.h , thin tilde(psi)_11 )$, the Hamiltonian in @eq:Hamifree0 becomes,

$ H = sum_(i = 0)^5 lambda (tilde(psi)_i^dagger tilde(psi)_i - tilde(psi)_(6 + i)^dagger tilde(psi)_(6 + i)) med = med lambda (tilde(Psi)^dagger tilde(Psi) - 6) med , $

where the canonical anticommutation relations have been used to obtain the final equality. This is invariant under a $S U ( 12 )$ symmetry, where $tilde(Psi)$ transforms in the fundamental representation. The free-quark spectrum ($g = h = 0$) is therefore described by states with degeneracies corresponding to the $upright(bold(1))$ and $upright(bold(12))$ of $S U ( 12 )$ as well as the antisymmetric combinations of fundamental irreps, $upright(bold(66)) , upright(bold(220)) , dots.h$ as illustrated in @fig:specDegenh and~@fig:specDegeng. The vacuum state corresponds to the singlet of $S U ( 12 )$. The lowest-lying #strong[12] corresponds to single quark or antiquark excitations, which are color $upright(bold(3))_c$s for quarks and $overline(upright(bold(3)))_c$s for antiquarks and will each appear as isodoublets, i.e., $upright(bold(12)) arrow.r upright(bold(3))_c ⊗ upright(bold(2))_f xor overline(upright(bold(3)))_c ⊗ upright(bold(2))_f$. The #strong[66] arises from double excitations of quarks and antiquarks. The possible color-isospin configurations are, based upon totally-antisymmetric wavefunctions for $q q$, $overline(q) overline(q)$ and $overline(q) q$, $upright(bold(66)) = upright(bold(1))_c ⊗ upright(bold(1))_f xor upright(bold(1))_c ⊗ upright(bold(3))_f xor upright(bold(8))_c ⊗ upright(bold(1))_f xor upright(bold(8))_c ⊗ upright(bold(3))_f xor upright(bold(6))_c ⊗ upright(bold(1))_f xor overline(upright(bold(6)))_c ⊗ upright(bold(1))_f xor upright(bold(3))_c ⊗ upright(bold(3))_f xor overline(upright(bold(3)))_c ⊗ upright(bold(3))_f$. The OBCs split the naive symmetry between quarks and antiquarks and, for $g eq.not 0$, the lowest-lying color edge-states are from the antiquark sector with degeneracies $6$ from a single excitation and $6 , 9$ from double excitations. Larger lattices possess an analogous global $S U ( 12 )$ symmetry, coupled between spatial sites by the hopping term, and the spectrum is again one of non-interacting quasi-particles.

= DETAILS OF THE D-WAVE IMPLEMENTATIONS
<app:dwave>
In this appendix, additional details are provided on the procedure used in @sec:dwave_spectrum to extract the lowest three eigenstates and corresponding energies using D-Wave's `Advantage`, (a more complete description can be found in Ref.~@Illa:2022jqb). The objective function $F$ to be minimized can be written in terms of binary variables and put into QUBO form. Defining $F = chevron.l Psi | tilde(H) | Psi chevron.r - eta chevron.l Psi | Psi chevron.r$ @doi:10.1021-acs.jctc.9b00402, and expanding the wavefunction with a finite dimensional orthonormal basis $psi_alpha$, $| Psi chevron.r = sum_alpha^(n_s) a_alpha | psi_alpha chevron.r$, it is found

$ F = chevron.l Psi | tilde(H) | Psi chevron.r - eta chevron.l Psi | Psi chevron.r = sum_(alpha beta)^(n_s) a_alpha a_beta [ chevron.l psi_alpha | tilde(H) | psi_beta chevron.r - eta chevron.l psi_alpha | psi_beta chevron.r ] = sum_(alpha beta)^(n_s) a_alpha a_beta ( tilde(H)_(alpha beta) - eta delta_(alpha beta) ) = sum_(alpha beta)^(n_s) a_alpha a_beta h_(alpha beta) med , $

where $h_(alpha beta)$ are the matrix elements of the Hamiltonian that can be computed classically. The coefficients $a_alpha$ are then expanded in a fixed-point representation using $K$ bits@doi:10.1021-acs.jctc.9b00402 @Chang:2019 @ARahman:2021ktn/acs.jctc.9b00402 @ARahman:2021ktn, $a_alpha^(( z + 1 )) = a_alpha^(( z )) + sum_(i = 1)^K 2^(i - K - z) ( - 1 )^(delta_(i K)) q_i^alpha med ,$

where $z$ is the zoom parameter. The starting point is $a_alpha^(( z = 0 )) = 0$, and for each consecutive value of $z$, the range of values that $a_alpha^(( z + 1 ))$ is allowed to explore is reduced by a factor of $2$, centered around the previous solution $a_alpha^(( z ))$. Now $F$ takes the following form,

$ F = sum_(alpha , beta)^(n_s) sum_(i , j)^K Q_(alpha , i beta , j) q_i^alpha q_j^beta med , med Q_(alpha , i beta , j) = 2^(i + j - 2 K - 2 z) ( - 1 )^(delta_(i K) + delta_(j K)) h_(alpha beta) + 2 delta_(alpha beta) delta_(i j) 2^(i - K - z) ( - 1 )^(delta_(i K)) sum_gamma^(n_s) a_gamma^(( z )) h_(gamma beta) med . $

The iterative procedure used to improve the precision of the results is based on the value $a_alpha^(( z ))$ obtained after $14$ zoom steps (starting from $a_alpha^(( z_0 = 0 )) = 0$), and then launching a new annealing workflow with $z_1 eq.not 0$ (e.g., $z_1 = 4$), with $a_alpha^(( z = z_0 + 14 ))$ as the starting point. After another 14 zoom steps, the final value $a_alpha^(( z = z_1 + 14 ))$ can be used as the new starting point for $a_alpha^(( z = z_2 ))$, with $z_2 > z_1$. This process can be repeated until no further improvement is seen in the convergence of the energy and wavefunction.

In @tab:QAresults2, the difference between the exact energy of the vacuum and masses of the $sigma$- and $pi$-mesons and the ones computed with the QA, for each iteration of this procedure after 14 zoom steps, are given, together with the overlap of the wavefunctions $1 - | chevron.l Psi^(upright("exact")) | Psi^(mono(A d v .)) chevron.r |^2$. See also @fig:QAresults.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 7,
  inset: (y: 1.5pt),
  align: (center,right,right,right,right,right,right,),
  table.header([], table.cell(align: center, colspan: 2)[$| Omega chevron.r$], table.cell(align: center, colspan: 2)[$| sigma chevron.r$], table.cell(align: center, colspan: 2)[$| pi chevron.r$],),
  table.hline(),
  [Step], table.cell(align: center)[$delta E_Omega$], table.cell(align: center)[$1 - | chevron.l Psi_Omega^(upright("exact")) | Psi_Omega^(mono(A d v .)) chevron.r |^2$], table.cell(align: center)[$delta M_sigma$], table.cell(align: center)[$1 - | chevron.l Psi_sigma^(upright("exact")) | Psi_sigma^(mono(A d v .)) chevron.r |^2$], table.cell(align: center)[$delta M_pi$], table.cell(align: center)[$1 - | chevron.l Psi_pi^(upright("exact")) | Psi_pi^(mono(A d v .)) chevron.r |^2$],
  [0], [$4_(thin - 2)^(thin + 2) times 10^(- 1)$], [$10_(thin - 5)^(thin + 3) times 10^(- 2)$], [$4_(thin - 2)^(thin + 2) times 10^(- 1)$], [$11_(thin - 5)^(thin + 7) times 10^(- 2)$], [$3_(thin - 1)^(thin + 1) times 10^(- 1)$], [$11_(thin - 4)^(thin + 71) times 10^(- 2)$],
  [1], [$9_(thin - 3)^(thin + 4) times 10^(- 3)$], [$2_(thin - 5)^(thin + 6) times 10^(- 3)$], [$3_(thin - 1)^(thin + 1) times 10^(- 2)$], [$7_(thin - 2)^(thin + 2) times 10^(- 3)$], [$9_(thin - 3)^(thin + 4) times 10^(- 3)$], [$3_(thin - 1)^(thin + 3) times 10^(- 3)$],
  [2], [$6_(thin - 2)^(thin + 2) times 10^(- 4)$], [$12_(thin - 5)^(thin + 3) times 10^(- 5)$], [$4_(thin - 1)^(thin + 1) times 10^(- 3)$], [$12_(thin - 4)^(thin + 3) times 10^(- 4)$], [$7_(thin - 3)^(thin + 2) times 10^(- 4)$], [$3_(thin - 2)^(thin + 2) times 10^(- 4)$],
  [3], [$4_(thin - 2)^(thin + 1) times 10^(- 5)$], [$9_(thin - 4)^(thin + 3) times 10^(- 6)$], [$2_(thin - 1)^(thin + 1) times 10^(- 4)$], [$6_(thin - 2)^(thin + 1) times 10^(- 5)$], [$4_(thin - 2)^(thin + 2) times 10^(- 5)$], [$12_(thin - 3)^(thin + 6) times 10^(- 6)$],
  [4], [$16_(thin - 6)^(thin + 6) times 10^(- 7)$], [$3_(thin - 1)^(thin + 2) times 10^(- 7)$], [$10_(thin - 3)^(thin + 6) times 10^(- 6)$], [$9_(thin - 1)^(thin + 1) times 10^(- 6)$], [$7_(thin - 5)^(thin + 9) times 10^(- 7)$], [$8_(thin - 2)^(thin + 2) times 10^(- 6)$],
  
  )],
  caption: [Convergence of the energy, masses and wavefunctions of the three lowest-lying states in the $B = 0$ sector of $1 + 1$D QCD with $N_f = 2$ and $m = g = L = 1$, between exact results from diagonalization of the Hamiltonian and those obtained from D-Wave's `Advantage`.], kind: table
  )
<tab:QAresults2>

Focusing on the lowest line of the last panel of @fig:QAresults, which shows the convergence as a function of zoom steps for the pion mass, it can be seen that it displays some oscillatory behavior compared to the rest, which are smooth. This is expected, since the wavefunctions used to project out the lower eigenstates from the Hamiltonian are known with a finite precision (obtained from previous runs). For example, the vacuum state is extracted at the $10^(- 6)$ precision level. Then, when looking at the excited states with increased precision (like for the pion, around $10^(- 7)$), the variational principle might not hold, and the computed energy level might be below the "true" one (and not above). To support this argument, the same calculation has been pursued, but using the exact wavefunctions when projecting the Hamiltonian to study the excited states (instead of the ones computed using `Advantage`), and no oscillatory behavior is observed, as displayed in @fig:QAresults_exact.

// [figvision-cn] imgs/AdvantageConvergence_2_exact.png
// 该图包含三个并列的子图，分别对应真空态、σ介子态和π介子
// 态。每个子图在结构上均分为左右两个区域：左侧区域展示能
// 量或质量随迭代步数的收敛过程，右侧区域展示波函数随参数
// α的变化。 子图a（左侧）： 类型：双Y轴曲线图与折线图组
// 合。 标题：顶部标注为“|Ω⟩”。 左半部分： 横坐标：名称为
// “zoom steps”，范围从0到约25，无单位刻度标记。 左纵坐标：
// 名称为“E_Ω^iter - E_Ω^exact”，对数标度，范围从10⁻⁶到10
// ¹。 右纵坐标：名称为“a₀”，线性标度，范围从-0.2到0.8。
// 数据系列：共六条带误差带的曲线，颜色从上到下依次为黄色、
// 浅绿、中绿、青色、深蓝、紫色，代表不同初始条件或激发态
// 的迭代过程。每条曲线显示误差随zoom steps增加而指数下降，
// 最终稳定在10⁻至10⁶量级。 右上角图标：一个立方体网格内
// 含蓝色球体和红色箭头，旁边标注“Q”，表示量子蒙特卡洛模
// 拟中的格点构型示意。 右半部分： 横坐标：名称为“α”，范
// 围从0到80，无单位。 纵坐标：共用右侧“a₀”轴，范围同上。
// 数据系列：两条折线，一条黑色实线连接实心圆点，另一条黄
// 色虚线连接空心方块。两者在α=0附近剧烈振荡，随后趋于平
// 稳，波动幅度减小并围绕零值上下起伏。 趋势结论：能量差
// 随迭代快速收敛；波函数系数a₀在投影后仍保留高频噪声，但
// 整体趋势稳定。 子图b（中间）： 类型：双Y轴曲线图与折线
// 图组合。 标题：顶部标注为“|σ⟩”。 左半部分： 横坐标：“
// zoom steps”，范围0–25。 左纵坐标：“M_σ^iter - M_σ^
// exact”，对数标度，10⁻⁶至10¹。 右纵坐标：“a₀”，线性标度，
// -0.4至0.4。 数据系列：同样六条彩色曲线（黄→紫），显示
// 质量差随迭代收敛，速率略慢于子图a，最终稳定在10⁻⁴至10⁻
// 量级。 右上角图标：同子图a，“Q”标识。 右半部分： 横坐
// 标：“α”，0–80。 纵坐标：共用右侧“a₀”轴。 数据系列：黑
// 色实线+实心圆点，黄色虚线+空心方块。振荡幅度更大，尤其
// 在α<20区间出现多个尖峰，之后逐渐衰减但仍保持显著波动。
// 趋势结论：质量收敛较能量稍慢；波函数系数a₀受激发态影响
// 更明显，噪声更强，反映σ介子态对哈密顿量投影更敏感。 子
// 图c（右侧）： 类型：双Y轴曲线图与折线图组合。 标题：顶
// 部标注为“|π⟩”。 左半部分： 横坐标：“zoom steps”，0–25。
// 左纵坐标：“M_π^iter - M_π^exact”，对数标度，10⁻⁶至10⁰
// （即1）。 右纵坐标：“a₀”，线性标度，-0.4至0.6。 数据系
// 列：六条彩色曲线（黄→紫），收敛速度介于a与b之间，最终
// 稳定在10⁻³至10⁻量级。 右上角图标：同前，“Q”标识。 右半
// 部分： 横坐标：“α”，0–80。 纵坐标：共用右侧“a₀”轴。 数
// 据系列：黑色实线+实心圆点，黄色虚线+空心方块。振荡模式
// 与前两图类似，但在α>40后波动幅度最小，接近水平直线。
// 趋势结论：π介子态的质量收敛性能优于σ态但劣于真空态；其
// 波函数系数a₀在大α区域最稳定，表明该态在投影下具有较好
// 的数值鲁棒性。 三子图共同传达的核心信息：通过迭代优化
// 算法，三种低能态的能量/质量误差均随zoom steps单调递减
// 并收敛至机器精度附近；同时，使用精确波函数进行哈密顿量
// 投影时，各态对应的波函数系数a₀虽存在高频噪声，但整体行
// 为可控，且不同态表现出不同的收敛速率与稳定性特征——真空
// 态最快最稳，σ态最慢最噪，π态居中。所有子图均采用相同配
// 色方案区分不同初始路径或激发阶次，便于横向比较。
#figure(image("imgs/AdvantageConvergence_2_exact.png", width: 100%),
  caption: [
    Iterative convergence of the energy, masses and wavefunctions for the three lowest-lying states in the $B = 0$ sector of $1 + 1$D QCD with $N_f = 2$ and $m = g = L = 1$: vacuum (left), $sigma$-meson (center) and $pi$-meson (right). Compared to @fig:QAresults, the exact wavefunctions are used when projecting the Hamiltonian to study the excited states.
  ]
)
<fig:QAresults_exact>

= QUANTUM CIRCUITS REQUIRED FOR TIME EVOLUTION BY THE GAUGE-FIELD INTERACTION
<app:circ>
This appendix provides more detail about the construction of the quantum circuits which implement the Trotterized time evolution of the chromo-electric terms of the Hamiltonian. It closely follows the presentation in the appendix of Ref.~@Stetina:2020abi. The four-qubit interaction in $H_(e l)$ has the form

$ sigma^(+) sigma^(-) sigma^(-) sigma^(+) + upright("h") thin upright(".") thin upright("c") thin upright(".") = 1 / 8 ( X X X X + X X Y Y + X Y X Y - X Y Y X + Y X Y X - Y X X Y + Y Y X X + Y Y Y Y ) med . $<eq:pmmpApp>

Since the 8 Pauli strings are mutually commuting, they can be simultaneously diagonalized by a unitary transformation. The strategy for identifying the quantum circuit(s) to implement this term will be to first change to a basis where every term is diagonal, then apply the diagonal unitaries and finally return back to the computational basis. The GHZ state-preparation circuits, shown in @circ:GHZ, diagonalize all 8 of the Pauli strings, for example,

$ G^dagger med & ( X X X X + Y Y X X + Y X Y X - Y X X Y - X Y Y X + X Y X Y + X X Y Y + Y Y Y Y ) med G med =\
 & I I Z I - Z I Z Z - Z Z Z Z + Z I Z I + I Z Z I - I I Z Z - I Z Z Z + Z Z Z I med . $<eq:GHZDiag>

This can be verified by using the identities that are shown in @circ:XZError to simplify the circuits formed by conjugating each Pauli string by $G$. As an example, the diagonalization of $X X Y Y$ is displayed in @fig:XXYYDiag.

// [figvision-cn] imgs/XZIdentites.png
// 该图像包含两个并列的量子电路恒等式，分别展示在图的左侧
// 和右侧，中间由一个逗号分隔。所有元素均为黑白线条绘制，
// 背景为白色。 第一个恒等式位于左侧。它由左、右两个量子
// 电路图通过一个等号连接构成。 左侧电路图包含两条平行的
// 水平线，代表两个量子比特线路。上方线路从左至右依次是一
// 个标有字母“X”的正方形门（泡利-X门），紧接着是一个实心
// 黑点（控制位）。下方线路对应位置是一个带加号的圆圈门（
// 受控非门的目标位）。从上方线路的黑点引出一条垂直实线向
// 下连接到下方线路的圆圈门上。 右侧电路图同样包含两条平
// 行的水平线。上方线路从左至右依次是一个实心黑点，紧接着
// 是一个标有字母“X”的正方形门。下方线路对应位置是一个带
// 加号的圆圈门，紧接着是另一个标有字母“X”的正方形门。从
// 上方线路的黑点引出一条垂直实线向下连接到下方线路的圆圈
// 门上。 这两个电路图之间有一个标准的数学等号，表示它们
// 在量子计算逻辑上是等效的。 第二个恒等式位于右侧。它同
// 样由左、右两个量子电路图通过一个等号连接构成。 左侧电
// 路图包含两条平行的水平线。上方线路上有两个实心黑点，分
// 别位于线路的左侧和右侧部分。下方线路对应位置有两个带加
// 号的圆圈门，且在这两个圆圈门之间夹着一个标有字母“Z”的
// 正方形门（泡利-Z门）。从上方线路的左侧黑点引出一条垂直
// 实线向下连接到下方线路的左侧圆圈门上；从上方线路的右侧
// 黑点引出另一条垂直实线向下连接到下方线路的右侧圆圈门上。
// 右侧电路图包含两条平行的水平线。上方线路仅包含一个标有
// 字母“Z”的正方形门。下方线路也仅包含一个标有字母“Z”的正
// 方形门，且与上方门在同一垂直位置对齐。 这两个电路图之
// 间也有一个标准的数学等号，表示它们的等效性。
#figure(image("imgs/XZIdentites.png", width: 8cm),
  caption: [
    The $X$ and $Z$ circuit identities.
  ]
)
<circ:XZError>

The first equality uses $Y = i Z X$ and the second equality uses the $X$ circuit identity to move all $X$s past the CNOTs. The third equality moves the $Z$s past the controls of the CNOTs and uses the $Z$ circuit identity. The other Pauli strings are diagonalized in a similar manner.

// [figvision-cn] imgs/XXYYDiag.png
// 该图由四个量子电路图和两个数学表达式组成，从左至右依次
// 排列，通过等号连接，展示了一个多步的量子电路简化过程。
// 所有电路图均包含三条平行的水平线，代表三个量子比特（从
// 上到下依次为第0、1、2号量子比特）。 第一部分（最左侧电
// 路图）： 这是一个三量子比特的量子电路图。 第0号线（顶
// 部）：依次经过一个受控非门（CNOT）的控制端（黑点），其
// 目标端在第2号线；随后是一个Y门；接着是另一个CNOT门的控
// 制端，目标端在第2号线。 第1号线（中间）：依次经过一个
// Hadamard门（H）；随后是两个CNOT门的目标端（⊕符号），分
// 别来自第0号和第2号线的控制端；接着是一个Y门；然后是一
// 个X门；最后是另一个CNOT门的目标端，来自第0号线的控制端；
// 末尾是一个Hadamard门（H）。 第2号线（底部）：依次经过
// 第一个CNOT门的目标端；随后是一个X门；接着是第二个CNOT
// 门的目标端；最后是一个CNOT门的目标端。 此部分右侧有一
// 个等号“=”。 第二部分（左二电路图）： 这是第一步化简后
// 的电路图。 第0号线：依次经过一个CNOT门的控制端（目标在
// 第2号线）；随后是一个iZ门；接着是一个X门；然后是另一个
// CNOT门的控制端（目标在第2号线）。 第1号线：依次经过一
// 个Hadamard门（H）；随后是两个CNOT门的目标端（⊕符号），
// 分别来自第0号和第2号线的控制端；接着是一个iZ门；然后是
// 一个X门；最后是另一个CNOT门的目标端，来自第0号线的控制
// 端；末尾是一个Hadamard门（H）。 第2号线：依次经过第一
// 个CNOT门的目标端；随后是一个X门；接着是第二个CNOT门的
// 目标端；最后是一个CNOT门的目标端。 此部分右侧有一个等
// 号“=”。 第三部分（右二电路图）： 这是第二步化简后的电
// 路图。 第0号线：依次经过一个CNOT门的控制端（目标在第2
// 号线）；随后是一个iZ门；接着是另一个CNOT门的控制端（目
// 标在第2号线）。 第1号线：依次经过一个Hadamard门（H）；
// 随后是两个CNOT门的目标端（⊕符号），分别来自第0号和第2
// 号线的控制端；接着是一个iZ门；然后是一个CNOT门的目标端，
// 来自第0号线的控制端；末尾依次是一个X门和一个Hadamard门
// （H）。 第2号线：依次经过第一个CNOT门的目标端；随后是
// 第二个CNOT门的目标端；最后是一个CNOT门的目标端。 此部
// 分右侧有一个等号“=”。 第四部分（右一电路图）： 这是第
// 三步化简后的电路图，结构变得非常稀疏。 第0号线：仅包含
// 一个iZ门。 第1号线：依次包含一个Hadamard门（H）、一个X
// 门和一个Hadamard门（H）。 第2号线：仅包含一个iZ门。 此
// 部分右侧有一个等号“=”。 最终结果（最右侧文本）： 显示
// 为数学表达式“-IZZZ”。这表示整个电路序列等效于在三个量
// 子比特上分别作用一个泡利Z算符，并整体乘以系数-1（即全
// 局相位因子和单比特算符的直积）。
#figure(image("imgs/XXYYDiag.png", width: 17cm),
  caption: [
    The diagonalization of $X X Y Y$ via a GHZ state-preparation circuit.
  ]
)
<fig:XXYYDiag>

It is also straightforward to show that, for example,

$ G^dagger ( I Z Z I + I Z I Z + Z I I Z ) G = I Z I I + I I I Z + Z I I I med . $<eq:ZZGHZG>

In general, a $Z Z$ in the computational basis becomes a single $Z$ in the GHZ basis if the state-preparation circuit has a CNOT that connects the original two $Z$s. The two GHZ state-preparation circuits, $G$ and $tilde(G)$, were chosen so that all $9$ of the $Z Z$ terms in @eq:QnfQmfp are mapped to single qubit rotations. Once in the GHZ basis, the diagonal unitaries are performed, e.g., $exp ( - i I Z Z Z )$. They are arranged to minimize the number of CNOTs required, and the optimal circuit layouts are shown in @circ:UpmmpZZ.

= COMPLETE CIRCUITS FOR $N_f = 1 , 2$ QCD WITH $L = 1$<app:Nf1SU3circs>
This appendix provides the complete set of circuits required to implement one Trotter step for $N_f = 1$ and $N_f = 2$ QCD with $L = 1$. The composite circuit for $N_f = 1$ is shown in @fig:Nf1Trot where, by ordering $U_(e l)$ before $U_(k i n)$, the CNOTs highlighted in blue cancel. The composite circuit for $N_f = 2$ is shown in @fig:Nf2Trot, where the ordering in the Trotterization is $U_m$ followed by $U_(k i n)$ and then by $U_(e l)$.

// [figvision-cn] imgs/Nf1CircFull.png
// 该图像为一张量子电路示意图，展示了实现量子色动力学（
// QCD）中单步Trotter演化的完整量子线路。图中包含多条水平
// 线代表量子比特，以及从左至右排列的各种量子逻辑门符号，
// 整体布局分为三个功能区域，分别标记为 $U_m$、$U_{el}$
// 和 $U_{kin}$。 子图类型：量子电路示意图（无坐标轴或比
// 例尺）。 共有七条水平量子比特线，从上到下依次标注如下：
// 第一条：$R_\theta(m\tau)$ 第二条：$R_\phi(m\tau)$ 第三
// 条：$R_\theta(-m\tau)$ 第四条：$R_\phi(-m\tau)$ 第五条：
// $R_\theta(m\tau)$ 第六条：$R_\phi(m\tau)$ 第七条：$R_\
// theta(-m\tau)$ 每条线上分布有不同类型的量子门，包括单
// 比特旋转门（矩形框内标有参数）、Hadamard门（标有“H”的
// 方框）、受控非门（CNOT，由控制点●与目标⊕连接表示）、以
// 及多比特纠缠门（如蓝色高亮的双圈符号，可能表示特定耦合
// 操作）。 在顶部四条线中，前两个门分别为 $R_\theta(m\
// tau)$ 和 $R_\phi(m\tau)$，随后是多个串联的 $R_\phi(\pm
// g^2/3)$ 门，部分被蓝色椭圆圈出，暗示其为关键相互作用项。
// 中间三条线包含 H 门、$R_\theta(\pm t/2)$ 门及若干 CNOT
// 门，构成动量演化部分。底部两条线结构类似，但起始于 H
// 门并结束于另一个 H 门，形成对称结构。 整个电路下方用大
// 括号划分三个区域： 左侧区域标记为 $U_m$，对应质量项演
// 化； 中间区域标记为 $U_{el}$，对应电势或规范场相互作用；
// 右侧区域标记为 $U_{kin}$，对应动能项演化。 所有门按时
// 间顺序从左到右排列，表示量子态随 Trotter步骤逐步演化。
// 蓝色高亮部分强调某些特定的两体相互作用门，可能是用于模
// 拟夸克-胶子耦合的关键环节。 该图传达的核心结论是：通过
// 组合单比特旋转、Hadamard变换、受控非门及特定双比特门，
// 可以构造一个完整的量子线路来近似实现 QCD 哈密顿量的单
// 步 Trotter分解，其中各子单元分别对应物理模型中的不同能
// 量项（质量、电势、动能），且电路结构设计体现了对规范不
// 变性和离散时空演化的编码方式。
#figure(image("imgs/Nf1CircFull.png", width: 100%),
  caption: [
    The complete circuit that implements a single Trotter step for $N_f = 1$ QCD with $L = 1$.
  ]
)
<fig:Nf1Trot>

// [figvision-cn] imgs/Nf2CircFull.png
// 该图像为一张量子电路图，展示了实现量子色动力学（QCD）
// 中单个Trotter步的完整电路。整个图由两条平行的主时间线
// 构成，分别标记为“U_m”和“U_L”，代表两个不同的演化算符或
// 阶段。图中包含多条水平线代表量子比特（qubits），从左至
// 右表示时间演化方向。 子图类型：示意图（量子电路图）。
// 布局与结构： 左侧部分标记为“U_m”，右侧部分标记为“U_L”。
// 两部分在空间上并列，但逻辑上可能代表同一电路的不同阶段
// 或不同算符的作用。 每条水平线代表一个量子比特，从上到
// 下依次编号或隐含顺序。根据图示，共有约16条量子比特线（
// 具体数量需依实际计数，此处按典型QCD Trotter化电路推断）。
// 垂直连接线表示门操作作用于多个量子比特之间；符号如圆圈、
// 叉号、矩形框等代表不同类型的量子门。 详细元素说明： 【
// 左侧 U_m 部分】 坐标轴：无传统坐标轴，横轴为时间演化方
// 向（左→右），纵轴为量子比特索引（上→下）。 量子比特线：
// 共16条水平实线，每条线上分布若干门操作符号。 门操作符
// 号： 单量子比特门：用小圆圈内含字母或符号表示，例如“H”
// 代表Hadamard门，“X”代表Pauli-X门，“Z”代表Pauli-Z门，“
// R_z(θ)”代表绕z轴旋转门（参数θ未标出，但在某些位置有标
// 注如“π/4”、“π/2”等）。 双量子比特门：用垂直连线连接两
// 个量子比特线上的点，中间带符号如“CNOT”（控制非门）、“
// CZ”（控制相位门）、“SWAP”等。部分门带有参数，如“e^{iθ}
// ”形式。 多量子比特门：部分区域出现三个或以上量子比特通
// 过垂直线连接，并标注如“Toffoli”或“CCNOT”等复合门。 特
// 殊标注： 在某些门上方或下方标注角度值，如“π/4”、“π/2”、
// “3π/4”等，用于指定旋转门的参数。 部分门被方框包围，内
// 部写有“exp(-iHΔt)”或类似表达式，表示哈密顿量演化项。
// 在电路末端（最右侧），部分量子比特线终止于测量符号（米
// 字形图标），表示对该比特进行投影测量。 趋势与结论：此
// 部分展示了对动量空间或质量项相关的哈密顿量 H_m 的近似
// 演化，通过分解为一系列基本量子门实现，体现
// Trotter-Suzuki分解的思想。 【右侧 U_L 部分】 结构与左
// 侧相似，同样包含16条量子比特线，从左至右排列。 门操作
// 密度更高，尤其在中间区域，大量使用受控旋转门和交换门。
// 特别之处： 存在多个“ladder-like”结构，即相邻量子比特间
// 反复进行CNOT或CZ门操作，形成链式传播。 多处出现“phase
// kickback”结构，即一个目标比特作为控制位影响其他比特的
// 相位。 部分门标注为“e^{-igA·ψ}”或“e^{-ig²A²}”，暗示这
// 是规范场相互作用项 L_g 的实现。 在底部几条线上，有重复
// 出现的“swap network”结构，用于重新排列量子比特顺序以匹
// 配后续门的需求。 测量符号：同样在最右侧对部分比特进行
// 测量，但测量模式与左侧略有不同，可能对应可观测量 O_L。
// 趋势与结论：此部分实现了拉格朗日量中的动能项或规范耦合
// 项 L_g 的演化，强调局域相互作用和规范不变性的保持。 整
// 体连接关系： “U_m”和“U_L”并非串联而是并联展示，意味着
// 它们可能是同一个Trotter步中先后执行的两个子步骤（先执
// 行U_m再执行U_L，或反之），也可能是两种不同哈密顿量分量
// 的独立实现方案对比。 图中所有门均严格按时间顺序从左到
// 右排列，符合量子电路的标准绘制规范。 无任何颜色映射或
// 灰度变化，全图为黑白线条图，仅靠符号形状和文字标注区分
// 功能。 比例尺与单位： 无物理尺度比例尺，因是抽象电路图。
// 所有角度参数以弧度制给出（如 π/4, π/2 等），时间步长 Δ
// t 未在图中标注数值，仅在公式中出现。 总结： 该图完整描
// 绘了一个用于模拟QCD动力学的量子算法核心模块——单个
// Trotter步的电路实现。通过将连续时间演化离散化为有限个
// 量子门序列，分别处理质量项（U_m）和规范相互作用项（U_L），
// 体现了当前量子模拟领域处理非阿贝尔规范理论的技术路径。
// 读者可根据此描述重建出具有精确门类型、参数、连接拓扑及
// 测量配置的量子电路图。
#figure(image("imgs/Nf2CircFull.png", height: 95.0%),
  caption: [
    The complete circuit that implements a single Trotter step for $N_f = 2$ QCD with $L = 1$.
  ]
)
<fig:Nf2Trot>

= ENERGY DECOMPOSITION ASSOCIATED WITH TIME EVOLUTION FROM THE TRIVIAL VACUUM
<app:MDTD>
This appendix shows, in @fig:Hanim, the time evolution of the decomposition of the expectation value of the Hamiltonian starting with the trivial vacuum at $t = 0$ for $N_f = 2$ QCD with $m = g = L = 1$. Notice that the sum of all three terms equals zero for all times as required by energy conservation and that the period of oscillations is the same as the period of the persistence amplitude shown in @fig:VacTo.

// [figvision-cn] imgs/Animation.png
// 该图像由16个独立的条形图子图组成，以4行4列的网格形式排
// 列，展示了量子色动力学（QCD）中能量随时间演化的分解情
// 况。所有子图共享相同的纵轴定义和物理量含义。 整体布局
// 与坐标系统： 每个子图均为条形图类型。纵轴标记为“Energy
// ”（能量），刻度范围从-2到2，主刻度间隔为1（即-2, -1, 0
// , 1, 2）。横轴无具体数值刻度，仅作为三个不同能量分量条
// 形的排列基线。一条水平黑线贯穿每个子图的纵坐标0处，作
// 为零能基准线。 每个子图包含三个垂直矩形条，从左至右分
// 别代表三种能量分量的期望值： 蓝色条形：代表磁能 $\
// langle H_m \rangle$。位于左侧，始终在零能线上方或紧贴
// 零能线（正值或零）。 橄榄绿色条形：代表动能 $\langle
// H_{kin} \rangle$。位于中间，始终在零能线下方（负值）。
// 红色条形：代表电场能 $\langle H_{el} \rangle$。位于右
// 侧，始终在零能线上方或紧贴零能线（正值或零）。 每个条
// 形正上方均标注其对应的物理量符号：$\langle H_m \rangle
// $、$\langle H_{kin} \rangle$、$\langle H_{el} \rangle$。
// 子图按时间顺序从左到右、从上到下排列，标题标明时刻 $t$
// （无量纲单位）： 第一行：t = 0, t = 0.3, t = 0.6, t =
// 0.9 第二行：t = 1.2, t = 1.5, t = 1.8, t = 2.1 第三行：
// t = 2.4, t = 2.7, t = 3.0, t = 3.3 第四行：t = 3.6, t
// = 3.9, t = 4.2, t = 4.5 各子图详细数据描述（基于视觉估
// 算）： t = 0: $\langle H_m \rangle$: 高度约0.05（极小
// 正值） $\langle H_{kin} \rangle$: 高度约-0.05（极小负
// 值） $\langle H_{el} \rangle$: 高度约0.05（极小正值）
// 趋势：初始时刻所有能量分量接近零，系统处于平凡真空态。
// t = 0.3: $\langle H_m \rangle$: 约0.1 $\langle H_{kin}
// \rangle$: 约-0.3 $\langle H_{el} \rangle$: 约0.1 趋势：
// 动能开始显著下降（负值增大），磁能和电场能小幅上升。 t
// = 0.6: $\langle H_m \rangle$: 约0.7 $\langle H_{kin} \
// rangle$: 约-1.0 $\langle H_{el} \rangle$: 约0.3 趋势：
// 磁能快速增长，动能持续下降，电场能缓慢增长。 t = 0.9:
// $\langle H_m \rangle$: 约1.4 $\langle H_{kin} \rangle$
// : 约-1.8 $\langle H_{el} \rangle$: 约0.4 趋势：磁能达
// 到峰值附近，动能达到最低点之一，电场能继续缓慢增加。 t
// = 1.2: $\langle H_m \rangle$: 约1.6 $\langle H_{kin} \
// rangle$: 约-1.7 $\langle H_{el} \rangle$: 约0.4 趋势：
// 磁能略增后趋于稳定，动能略有回升（绝对值减小），电场能
// 基本持平。 t = 1.5: $\langle H_m \rangle$: 约1.4 $\
// langle H_{kin} \rangle$: 约-1.6 $\langle H_{el} \
// rangle$: 约0.3 趋势：磁能开始下降，动能继续回升，电场
// 能小幅下降。 t = 1.8: $\langle H_m \rangle$: 约0.7 $\
// langle H_{kin} \rangle$: 约-0.8 $\langle H_{el} \
// rangle$: 约0.2 趋势：磁能大幅下降，动能大幅回升（负值
// 变小），电场能下降。 t = 2.1: $\langle H_m \rangle$:
// 约0.2 $\langle H_{kin} \rangle$: 约-0.3 $\langle H_{el
// } \rangle$: 约0.05 趋势：所有能量分量均接近零，系统趋
// 向弛豫。 t = 2.4: $\langle H_m \rangle$: 约0.05 $\
// langle H_{kin} \rangle$: 约-0.05 $\langle H_{el} \
// rangle$: 约0.05 趋势：完全回归初始状态，能量几乎为零。
// t = 2.7: $\langle H_m \rangle$: 约0.2 $\langle H_{kin}
// \rangle$: 约-0.4 $\langle H_{el} \rangle$: 约0.1 趋势：
// 新一轮振荡开始，动能再次下降，磁能和电场能小幅上升。 t
// = 3.0: $\langle H_m \rangle$: 约0.8 $\langle H_{kin} \
// rangle$: 约-1.0 $\langle H_{el} \rangle$: 约0.3 趋势：
// 重复t=0.6时的模式，但幅度略低。 t = 3.3: $\langle H_m
// \rangle$: 约1.4 $\langle H_{kin} \rangle$: 约-1.7 $\
// langle H_{el} \rangle$: 约0.4 趋势：接近t=0.9的状态，
// 振幅稍弱。 t = 3.6: $\langle H_m \rangle$: 约1.4 $\
// langle H_{kin} \rangle$: 约-1.6 $\langle H_{el} \
// rangle$: 约0.3 趋势：类似t=1.5，进入衰减阶段。 t = 3.9
// : $\langle H_m \rangle$: 约1.0 $\langle H_{kin} \
// rangle$: 约-1.2 $\langle H_{el} \rangle$: 约0.2 趋势：
// 能量进一步衰减。 t = 4.2: $\langle H_m \rangle$: 约0.5
// $\langle H_{kin} \rangle$: 约-0.6 $\langle H_{el} \
// rangle$: 约0.1 趋势：继续向零收敛。 t = 4.5: $\langle
// H_m \rangle$: 约0.2 $\langle H_{kin} \rangle$: 约-0.2
// $\langle H_{el} \rangle$: 约0.05 趋势：最终趋于平衡，
// 能量分量极小。 总体趋势与结论： 图像展示了一个周期性振
// 荡并逐渐衰减的能量演化过程。系统在t≈0.9时首次达到最大
// 能量分离（磁能最高、动能最负），随后在t≈2.4时几乎完全
// 弛豫回初始状态。之后在t≈3.3出现第二次较小幅度的振荡峰，
// 最后在t=4.5时再次趋近于零。这表明系统经历阻尼振荡行为，
// 总能量守恒（三者之和恒为零），但能量在不同自由度间反复
// 转移并因耗散而衰减。颜色编码清晰区分三种能量分量：蓝色
// （磁能）、橄榄绿（动能）、红色（电场能），便于追踪各自
// 动态。
#figure(image("imgs/Animation.png", width: 100%),
  caption: [
    The time evolution of the decomposition of the energy starting from the trivial vacuum starting at $t = 0$ for $N_f = 2$ QCD with $m = g = L = 1$.
  ]
)
<fig:Hanim>

= DETAILS ON ONE FIRST-ORDER TROTTER STEP OF $N_f = 1$ QCD WITH $L = 1$<app:LOTrott>
This appendix discusses the theoretical expectations for one step of first-order Trotter time evolution for $N_f = 1$ QCD with $L = 1$. The time evolution operator is decomposed into $U_1 ( t ) = U_(k i n) ( t ) U_(e l) ( t ) U_m ( t )$ where the subscript "$1$" is to denote first-order Trotter. Both the trivial vacuum-to-vacuum and trivial vacuum-to-$q_r overline(q)_r$ probabilities involve measurements in the computational basis where $U_m ( t )$ and $U_(e l) ( t )$ are diagonal and have no effect. Thus, the time-evolution operator is effectively $U_1 ( t ) = U_(k i n) ( t )$, which is exact (no Trotter errors) over a single spatial site. The trivial vacuum-to-vacuum, trivial vacuum-to-$q_r overline(q)_r$ and trivial vacuum-to-$B overline(B)$ probabilities are found to be,

$ | chevron.l Omega_0 | e^(- i H_(k i n) t) | Omega_0 chevron.r |^2 = cos^6 ( t / 2 ) med , med | chevron.l q_r overline(q)_r | e^(- i H_(k i n) t) | Omega_0 chevron.r |^2 = cos^4 ( t / 2 ) sin^2 ( t / 2 ) med , med | chevron.l B overline(B) | e^(- i H_(k i n) t) | Omega_0 chevron.r |^2 = sin^6 ( t / 2 ) med . $

For large periods of the evolution, the wavefunction is dominated by $B overline(B)$ as shown in @fig:VacToBBbar. Exact time evolution, on the other hand, has a small probability of $B overline(B)$ which suggests that detecting $B overline(B)$ could lead to an additional way to mitigate Trotter errors.

// [figvision-cn] imgs/VacToBBbarNf1.png
// 这是一张二维散点与曲线混合图，标题为“Trivial
// Vacuum-to-BB̄”，位于图表顶部中央。右上角有一个小型图标，
// 显示一个紫色三角形内部包含灰色几何结构及数条斜线，旁边
// 标有字母“c”。 纵坐标轴标签为“Probability”（概率），刻
// 度范围从0到1.0，主刻度标记为0、0.2、0.4、0.6、0.8、1.0。
// 横坐标轴标签为“t”，代表时间或演化步数，刻度范围从0到5，
// 主刻度标记为1、2、3、4、5。 图例位于右上角的方框内，包
// 含四项内容： “Exact”：对应红色虚线，表示哈密顿量精确指
// 数化得到的结果。 “1 step”：对应蓝色实心圆点，表示使用1
// 个Trotter步骤的模拟结果。 “2 steps”：对应橙色实心圆点，
// 表示使用2个Trotter步骤的模拟结果。 “3 steps”：对应绿色
// 实心圆点，表示使用3个Trotter步骤的模拟结果。 图中数据
// 分布如下： 红色虚线（Exact）在整个t∈[0,5]区间内几乎完
// 全贴合横轴，数值接近于0，表明在精确计算下，真空态到BB̄
// 态的跃迁概率极低或为零。 蓝色圆点（1 step）在t≈1.2处开
// 始上升，在t=3.0至3.2之间达到峰值约1.0，随后下降，在t=5
// 时降至约0.05。该曲线呈现明显的单峰振荡行为。 橙色圆点
// （2 steps）整体幅度较小，在t≈3.8处出现小峰，最大值约为
// 0.1，之后缓慢下降，在t=5时接近0.02。 绿色圆点（3 steps）
// 在t<3.5时基本贴近横轴，在t>3.5后迅速上升，在t=5时达到
// 约0.38，呈持续上升趋势，未出现回落。 趋势与结论：随着
// Trotter步数增加，模拟结果偏离精确解的程度先减小后增大；
// 1步模拟产生最大幅度的虚假振荡，2步有所抑制但仍有小幅波
// 动，3步则在后期出现显著增长，可能反映累积误差或离散化
// 效应导致的非物理行为。所有近似方法均未能复现精确解中近
// 乎零的概率值，说明在此参数设置下，Trotter分解引入较大
// 偏差。
#figure(image("imgs/VacToBBbarNf1.png", width: 100%),
  caption: [
    The trivial vacuum-to-$B overline(B)$ probability for $1 + 1$D QCD with $m = g = L = 1$. Shown are the results obtained from exact exponentiation of the Hamiltonian (dashed red curve) and from the Trotterized implementation with $1$, $2$ and $3$ Trotter steps.
  ]
)
<fig:VacToBBbar>

It is interesting that the kinetic term alone favors transitioning the trivial vacuum into color singlets on each site. This same behavior holds for $N_f = 2$ where the dominant transition is to $Delta Delta overline(Delta) overline(Delta)$.

= SUPPLEMENTARY DATA
<app:SuppData>
This appendix contains the tabulated data used to produce the figures in the text. The splitting between the $pi$- and $sigma$-meson is given in @tab:MpiMsigSplitData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 6,
  inset: (y: 1.5pt),
  align: (center,left,left,center,left,left,),
  table.header(table.cell(align: center, colspan: 6)[$M_pi - M_sigma$],),
  table.hline(),
  [$g$], [], [], [$g$], [], [],
  [0], [0.0], [0.0], [2.1], [0.1085], [0.09954],
  [0.1], [$2.373 times 10^(- 6)$], [$1.364 times 10^(- 6)$], [2.2], [0.1227], [0.1133],
  [0.2], [0.0000374], [0.00002335], [2.3], [0.1374], [0.1287],
  [0.3], [0.0001847], [0.0001285], [2.4], [0.1482], [0.1431],
  [0.4], [0.0005637], [0.0004306], [2.5], [0.1468], [0.1475],
  [0.5], [0.001317], [0.001066], [2.6], [0.1321], [0.1352],
  [0.6], [0.002589], [0.002163], [2.7], [0.1131], [0.1156],
  [0.7], [0.004508], [0.00383], [2.8], [0.09662], [0.09813],
  [0.8], [0.007173], [0.006158], [2.9], [0.08372], [0.08456],
  [0.9], [0.01064], [0.009207], [3.0], [0.07375], [0.07422],
  [1.0], [0.01493], [0.01301], [3.1], [0.06592], [0.06617],
  [1.1], [0.02002], [0.01755], [3.2], [0.05961], [0.05975],
  [1.2], [0.02586], [0.02281], [3.3], [0.05442], [0.05448],
  [1.3], [0.0324], [0.02874], [3.4], [0.05005], [0.05008],
  [1.4], [0.03956], [0.03529], [3.5], [0.04631], [0.04632],
  [1.5], [0.04731], [0.04243], [3.6], [0.04307], [0.04306],
  [1.6], [0.05562], [0.05011], [3.7], [0.04022], [0.04021],
  [1.7], [0.0645], [0.05837], [3.8], [0.0377], [0.03769],
  [1.8], [0.07405], [0.06725], [3.9], [0.03545], [0.03543],
  [1.9], [0.0844], [0.0769], [4.0], [0.03342], [0.0334],
  [2.0], [0.0958], [0.08755], [], [], [],
  
  )],
  caption: [The mass splitting between the $sigma$- and $pi$-mesons for $m = 1$ and $L = 1 , 2$. ], kind: table
  )
<tab:MpiMsigSplitData>

The decomposition of the vacuum energy, hadronic masses and deuteron binding energy is given in @tab:SpecBreakdownData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 6,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 6)[Decomposition of the vacuum energy, hadronic masses and deuteron binding energy],),
  table.hline(),
  table.hline(),
  [$chevron.l H_m chevron.r$], [1.0566], [2.056], [2.032], [2.855], [-0.001596],
  [$chevron.l H_(k i n) chevron.r$], [-2.975], [0.1271], [0.1425], [0.4182], [0.002399],
  [$chevron.l H_(e l) chevron.r$], [0.3374], [0.5401], [0.5609], [-0.03099], [-0.0003429],
  
  )],
  caption: [The decomposition of vacuum energy ($E_Omega$), the masses of the lightest hadrons ($M_sigma$, $M_pi$ and $M_Delta$) and the deuteron binding energy ($B_(Delta Delta)$) into contributions from the mass, kinetic and chromo-electric field terms in the Hamiltonian for $L = 2$ and $m = g = 1$. ], kind: table
  )
<tab:SpecBreakdownData>

The binding energy of the deuteron is given in @tab:deutBE.

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,center,left,),
    table.header([$g$], [], [$g$], [],),
    table.hline(),
    [0], [0.0], [1.6], [0.0005388],
    [0.1], [0.00005099], [1.7], [0.000541],
    [0.2], [0.0006768], [1.8], [0.0005332],
    [0.3], [0.002351], [1.9], [0.0005172],
    [0.4], [0.003947], [2.0], [0.0004948],
    [0.5], [0.003905], [2.1], [0.0004677],
    [0.6], [0.002716], [2.2], [0.0004378],
    [0.7], [0.001592], [2.3], [0.0004063],
    [0.8], [0.0009178], [2.4], [0.0003745],
    [0.9], [0.0005902], [2.5], [0.0003432],
    [1.0], [0.0004599], [2.6], [0.0003129],
    [1.1], [0.000429], [2.7], [0.0002842],
    [1.2], [0.000443], [2.8], [0.0002574],
    [1.3], [0.0004727], [2.9], [0.0002324],
    [1.4], [0.0005029], [3.0], [0.0002095],
    [1.5], [0.000526], [], [],
  )]
  , caption: [The binding energy of the deuteron, $B_(Delta Delta)$, for $m = 1$ and $L = 2$. ]
  , kind: table
  )
<tab:deutBE>

The linear entropy between quarks and antiquarks in the vacuum, the $sigma$- and $pi$-meson and the $Delta$ are given in @tab:linentData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 5,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 5)[The linear entropy between quarks and antiquarks],),
  table.hline(),
  [$g$], [], [], [], [],
  [0.1], [0.4668], [0.9115], [0.7786], [0.2698],
  [0.2], [0.4617], [0.9124], [0.7786], [0.2663],
  [0.3], [0.4532], [0.9137], [0.7786], [0.2605],
  [0.4], [0.4416], [0.9154], [0.7786], [0.2527],
  [0.5], [0.4271], [0.9174], [0.7787], [0.243],
  [0.6], [0.41], [0.9194], [0.7787], [0.2318],
  [0.7], [0.3908], [0.9214], [0.7789], [0.2194],
  [0.8], [0.3699], [0.9232], [0.7791], [0.206],
  [0.9], [0.3478], [0.9248], [0.7794], [0.1921],
  [1.0], [0.3248], [0.926], [0.7798], [0.1779],
  [1.1], [0.3015], [0.9269], [0.7803], [0.1638],
  [1.2], [0.2784], [0.9274], [0.7811], [0.15],
  [1.3], [0.2557], [0.9277], [0.7821], [0.1367],
  [1.4], [0.2339], [0.9277], [0.7834], [0.1241],
  [1.5], [0.213], [0.9277], [0.7851], [0.1123],
  [1.6], [0.1935], [0.9278], [0.7875], [0.1014],
  [1.7], [0.1752], [0.928], [0.7906], [0.0913],
  [1.8], [0.1584], [0.9287], [0.7949], [0.0821],
  [1.9], [0.1429], [0.93], [0.801], [0.07375],
  [2.0], [0.1288], [0.9322], [0.8097], [0.06622],
  [2.1], [0.116], [0.9355], [0.8225], [0.05944],
  [2.2], [0.1045], [0.9398], [0.8416], [0.05337],
  [2.3], [0.09411], [0.9434], [0.8675], [0.04794],
  [2.4], [0.08479], [0.9402], [0.8889], [0.04309],
  [2.5], [0.07643], [0.9212], [0.8731], [0.03876],
  [2.6], [0.06896], [0.8872], [0.8209], [0.03491],
  [2.7], [0.06227], [0.8526], [0.7729], [0.03148],
  [2.8], [0.05629], [0.8263], [0.7414], [0.02842],
  [2.9], [0.05095], [0.8081], [0.7216], [0.02569],
  [3.0], [0.04617], [0.7956], [0.7086], [0.02326],
  [3.1], [0.0419], [0.7867], [0.6994], [0.02108],
  [3.2], [0.03807], [0.7803], [0.6928], [0.01914],
  [3.3], [0.03464], [0.7754], [0.6877], [0.01741],
  [3.4], [0.03157], [0.7716], [0.6837], [0.01586],
  [3.5], [0.02881], [0.7686], [0.6805], [0.01446],
  [3.6], [0.02633], [0.7662], [0.6779], [0.01321],
  [3.7], [0.02409], [0.7642], [0.6757], [0.01209],
  [3.8], [0.02208], [0.7625], [0.6739], [0.01107],
  [3.9], [0.02027], [0.7611], [0.6723], [0.01016],
  [4.0], [0.01863], [0.7599], [0.671], [0.009334],
  [4.1], [0.01714], [0.7588], [0.6699], [0.008589],
  [4.2], [0.0158], [0.7579], [0.6689], [0.007913],
  [4.3], [0.01458], [0.7572], [0.668], [0.007301],
  [4.4], [0.01347], [0.7565], [0.6673], [0.006745],
  [4.5], [0.01246], [0.7559], [0.6666], [0.006239],
  [4.6], [0.01154], [0.7553], [0.666], [0.005779],
  [4.7], [0.01071], [0.7549], [0.6655], [0.005359],
  [4.8], [0.00994], [0.7545], [0.665], [0.004975],
  [4.9], [0.00924], [0.7541], [0.6646], [0.004625],
  [5.0], [0.0086], [0.7538], [0.6642], [0.004304],
  [5.1], [0.008012], [0.7535], [0.6639], [0.004009],
  [5.2], [0.007473], [0.7532], [0.6636], [0.003739],
  [5.3], [0.006978], [0.753], [0.6633], [0.003491],
  [5.4], [0.006522], [0.7527], [0.6631], [0.003263],
  [5.5], [0.006101], [0.7525], [0.6629], [0.003052],
  [5.6], [0.005714], [0.7524], [0.6627], [0.002858],
  [5.7], [0.005356], [0.7522], [0.6625], [0.002679],
  [5.8], [0.005026], [0.752], [0.6623], [0.002514],
  [5.9], [0.00472], [0.7519], [0.6621], [0.002361],
  [6.0], [0.004436], [0.7518], [0.662], [0.002219],
  
  )],
  caption: [The linear entropy between quarks and antiquarks in the vacuum, $| Delta_(I_3 = 3 / 2) chevron.r$, $| sigma chevron.r$ and $| pi_(I_3 = 1) chevron.r$ for $m = L = 1$.], kind: table
  )
<tab:linentData>

The quark occupation (total number of quarks plus antiquarks) in the $sigma$- and $pi$-mesons is given in @tab:qoccData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 6,
  inset: (y: 1.5pt),
  align: (center,left,left,center,left,left,),
  table.header(table.cell(align: center, colspan: 6)[The quark occupation],),
  table.hline(),
  [$g$], [], [], [$g$], [], [],
  [~~0 ~~], [2.422], [2.422], [~3.1~], [5.884], [5.915],
  [0.1], [2.422], [2.422], [3.2], [5.913], [5.936],
  [0.2], [2.422], [2.422], [3.3], [5.934], [5.95],
  [0.3], [2.423], [2.422], [3.4], [5.948], [5.961],
  [0.4], [2.424], [2.423], [3.5], [5.959], [5.968],
  [0.5], [2.426], [2.423], [3.6], [5.967], [5.974],
  [0.6], [2.429], [2.423], [3.7], [5.973], [5.979],
  [0.7], [2.434], [2.424], [3.8], [5.978], [5.982],
  [0.8], [2.44], [2.425], [3.9], [5.981], [5.985],
  [0.9], [2.449], [2.427], [4.0], [5.984], [5.988],
  [1.0], [2.46], [2.43], [4.1], [5.987], [5.989],
  [1.1], [2.473], [2.434], [4.2], [5.989], [5.991],
  [1.2], [2.489], [2.439], [4.3], [5.99], [5.992],
  [1.3], [2.507], [2.445], [4.4], [5.992], [5.993],
  [1.4], [2.529], [2.454], [4.5], [5.993], [5.994],
  [1.5], [2.555], [2.466], [4.6], [5.994], [5.995],
  [1.6], [2.586], [2.483], [4.7], [5.995], [5.996],
  [1.7], [2.626], [2.505], [4.8], [5.995], [5.996],
  [1.8], [2.676], [2.537], [4.9], [5.996], [5.997],
  [1.9], [2.744], [2.584], [5.0], [5.996], [5.997],
  [2.0], [2.839], [2.655], [5.1], [5.997], [5.997],
  [2.1], [2.979], [2.769], [5.2], [5.997], [5.998],
  [2.2], [3.193], [2.966], [5.3], [5.997], [5.998],
  [2.3], [3.524], [3.318], [5.4], [5.998], [5.998],
  [2.4], [4.004], [3.911], [5.5], [5.998], [5.998],
  [2.5], [4.579], [4.66], [5.6], [5.998], [5.999],
  [2.6], [5.091], [5.249], [5.7], [5.998], [5.999],
  [2.7], [5.439], [5.577], [5.8], [5.999], [5.999],
  [2.8], [5.646], [5.743], [5.9], [5.999], [5.999],
  [2.9], [5.766], [5.832], [6.0], [5.999], [5.999],
  [3.0], [5.838], [5.883], [], [], [],
  
  )],
  caption: [The expectation value of quark occupation in the $| sigma chevron.r$ and $| pi_(I_3 = 1) chevron.r$ for $m = L = 1$.], kind: table
  )
<tab:qoccData>

The trivial vacuum-to-vacuum probabilities, as obtained by `circ` and `qiskit`, are given in @tab:vactovacData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 6,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 6)[The trivial vacuum-to-vacuum probabilities],),
  table.hline(),
  [$t$], [], [], [], [], [],
  [~~0 ~~], [1], [1], [1], [1], [1],
  [0.1], [0.9851], [0.9852], [0.9852], [0.9852], [0.9852],
  [0.2], [0.9417], [0.9427], [0.9429], [0.943], [0.943],
  [0.3], [0.8733], [0.878], [0.8789], [0.8793], [0.8795],
  [0.4], [0.7854], [0.799], [0.8014], [0.8027], [0.8032],
  [0.5], [0.6846], [0.7141], [0.7193], [0.7219], [0.723],
  [0.6], [0.5779], [0.6309], [0.6401], [0.6447], [0.6466],
  [0.7], [0.4721], [0.5554], [0.5697], [0.5769], [0.5799],
  [0.8], [0.3728], [0.4914], [0.5118], [0.522], [0.5263],
  [0.9], [0.2841], [0.4405], [0.4678], [0.4815], [0.4872],
  [1.0], [0.2087], [0.4032], [0.438], [0.4556], [0.4629],
  [1.1], [0.1474], [0.3787], [0.422], [0.4438], [0.4529],
  [1.2], [0.0999], [0.3658], [0.4188], [0.4454], [0.4565],
  [1.3], [0.0648], [0.3634], [0.4275], [0.4596], [0.4729],
  [1.4], [0.0401], [0.3699], [0.4473], [0.4855], [0.5012],
  [1.5], [0.0235], [0.3843], [0.4775], [0.5225], [0.5408],
  [1.6], [0.0131], [0.4053], [0.5174], [0.5696], [0.5904],
  [1.7], [0.0068], [0.4316], [0.566], [0.6252], [0.6483],
  [1.8], [0.0033], [0.4616], [0.6218], [0.6873], [0.712],
  [1.9], [0.0015], [0.4935], [0.6827], [0.7529], [0.7782],
  [2.0], [0.0006], [0.5253], [0.7458], [0.8179], [0.8423],
  [2.1], [0.0002], [0.5546], [0.8075], [0.8775], [0.8992],
  [2.2], [0.0001], [0.579], [0.8634], [0.9262], [0.9433],
  [2.3], [0.0000], [0.5965], [0.9084], [0.9583], [0.9691],
  [2.4], [0.0000], [0.6055], [0.9374], [0.969], [0.9727],
  [2.5], [0.0000], [0.6055], [0.9453], [0.9549], [0.9518],
  [2.6], [0.0000], [0.5965], [0.9281], [0.915], [0.907],
  [2.7], [0.0000], [0.5798], [0.8839], [0.8513], [0.8418],
  [2.8], [0.0000], [0.5571], [0.8129], [0.7688], [0.7624],
  [2.9], [0.0000], [0.5305], [0.7187], [0.6748], [0.6766],
  [3.0], [0.0000], [0.5026], [0.6077], [0.5778], [0.5925],
  [3.1], [0.0000], [0.4756], [0.4886], [0.4865], [0.5176],
  [3.2], [0.0000], [0.4518], [0.3708], [0.408], [0.4581],
  [3.3], [0.0000], [0.4329], [0.2629], [0.3477], [0.4179],
  [3.4], [0.0000], [0.4204], [0.1713], [0.3087], [0.3991],
  [3.5], [0.0000], [0.4152], [0.0997], [0.2921], [0.4017],
  [3.6], [0.0000], [0.4179], [0.0488], [0.2967], [0.424],
  [3.7], [0.0000], [0.4283], [0.0175], [0.3196], [0.4626],
  [3.8], [0.0000], [0.4457], [0.0035], [0.3561], [0.5133],
  [3.9], [0.0000], [0.4689], [0.0039], [0.4009], [0.5714],
  [4.0], [0.0000], [0.4964], [0.0158], [0.4485], [0.6323],
  [4.1], [0.0001], [0.5265], [0.0363], [0.4947], [0.6925],
  [4.2], [0.0003], [0.5578], [0.062], [0.5373], [0.7496],
  [4.3], [0.0007], [0.5891], [0.0893], [0.576], [0.8015],
  [4.4], [0.0017], [0.6198], [0.1144], [0.6125], [0.8467],
  [4.5], [0.0038], [0.6498], [0.1339], [0.6489], [0.8833],
  [4.6], [0.0077], [0.6794], [0.1454], [0.687], [0.909],
  [4.7], [0.0145], [0.709], [0.148], [0.7269], [0.9213],
  [4.8], [0.0258], [0.7389], [0.1422], [0.7671], [0.9177],
  [4.9], [0.0436], [0.7689], [0.1295], [0.8042], [0.8969],
  [5.0], [0.0699], [0.7986], [0.1125], [0.8339], [0.8586],
  
  )],
  caption: [The trivial vacuum-to-vacuum probabilities for $N_f = 2$ and $m = g = L = 1$. Results are shown for 1, 2, 3, 5 and 10 Trotter steps.], kind: table
  )
<tab:vactovacData>

The trivial vacuum-to-$d_r overline(d)_r$ probabilities, as obtained by `circ` and `qiskit`, are given in @tab:vactodrdrbData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 6,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 6)[The trivial vacuum-to-$d_r overline(d)_r$ probabilities],),
  table.hline(),
  [$t$], [], [], [], [], [],
  [~~0~~], [0], [0], [0], [0], [0],
  [0.1], [0.0025], [0.0025], [0.0025], [0.0025], [0.0025],
  [0.2], [0.0095], [0.0093], [0.0093], [0.0093], [0.0093],
  [0.3], [0.0199], [0.0192], [0.0191], [0.019], [0.019],
  [0.4], [0.0323], [0.0304], [0.0301], [0.0299], [0.0298],
  [0.5], [0.0446], [0.0411], [0.0405], [0.0401], [0.04],
  [0.6], [0.0553], [0.05], [0.049], [0.0486], [0.0483],
  [0.7], [0.0629], [0.0565], [0.0553], [0.0546], [0.0543],
  [0.8], [0.0666], [0.0605], [0.0591], [0.0583], [0.058],
  [0.9], [0.0663], [0.0625], [0.061], [0.0601], [0.0597],
  [1.0], [0.0623], [0.0629], [0.0614], [0.0605], [0.0601],
  [1.1], [0.0554], [0.0623], [0.0608], [0.0598], [0.0594],
  [1.2], [0.0468], [0.0612], [0.0597], [0.0586], [0.058],
  [1.3], [0.0374], [0.0599], [0.0581], [0.0567], [0.0561],
  [1.4], [0.0284], [0.0585], [0.0561], [0.0543], [0.0535],
  [1.5], [0.0204], [0.0569], [0.0537], [0.0512], [0.0501],
  [1.6], [0.0139], [0.0552], [0.0505], [0.0472], [0.0458],
  [1.7], [0.0088], [0.0531], [0.0464], [0.0422], [0.0403],
  [1.8], [0.0053], [0.0505], [0.0414], [0.0361], [0.0339],
  [1.9], [0.0029], [0.0473], [0.0353], [0.029], [0.0265],
  [2.0], [0.0015], [0.0434], [0.0283], [0.0213], [0.0188],
  [2.1], [0.0007], [0.039], [0.0208], [0.0137], [0.0113],
  [2.2], [0.0003], [0.0341], [0.0134], [0.007], [0.0051],
  [2.3], [0.0001], [0.0291], [0.0069], [0.0022], [0.0012],
  [2.4], [0.0000], [0.0239], [0.0024], [0.0005], [0.0006],
  [2.5], [0.0000], [0.0189], [0.0008], [0.0025], [0.0036],
  [2.6], [0.0000], [0.0142], [0.0031], [0.0085], [0.0105],
  [2.7], [0.0000], [0.0099], [0.0098], [0.0183], [0.0206],
  [2.8], [0.0000], [0.0061], [0.0204], [0.0308], [0.0326],
  [2.9], [0.0000], [0.0031], [0.0339], [0.0444], [0.0452],
  [3.0], [0.0000], [0.0011], [0.0482], [0.0574], [0.0568],
  [3.1], [0.0000], [0.0001], [0.061], [0.0686], [0.0663],
  [3.2], [0.0000], [0.0002], [0.0701], [0.0768], [0.073],
  [3.3], [0.0000], [0.0012], [0.0741], [0.0818], [0.0766],
  [3.4], [0.0000], [0.003], [0.0728], [0.0834], [0.0769],
  [3.5], [0.0000], [0.0052], [0.0673], [0.082], [0.0741],
  [3.6], [0.0000], [0.0074], [0.0594], [0.0777], [0.0687],
  [3.7], [0.0000], [0.0094], [0.0508], [0.0712], [0.0613],
  [3.8], [0.0000], [0.0108], [0.0429], [0.0632], [0.0527],
  [3.9], [0.0000], [0.0117], [0.0366], [0.0546], [0.0439],
  [4.0], [0.0001], [0.0121], [0.0315], [0.0467], [0.0356],
  [4.1], [0.0003], [0.0122], [0.0275], [0.0401], [0.0283],
  [4.2], [0.0008], [0.0121], [0.024], [0.0351], [0.0221],
  [4.3], [0.0017], [0.0121], [0.0209], [0.0316], [0.0167],
  [4.4], [0.0033], [0.0123], [0.0183], [0.0289], [0.012],
  [4.5], [0.0058], [0.0126], [0.0166], [0.0262], [0.008],
  [4.6], [0.0096], [0.013], [0.0162], [0.0229], [0.0049],
  [4.7], [0.0149], [0.0132], [0.0169], [0.0188], [0.003],
  [4.8], [0.0217], [0.0131], [0.0185], [0.0142], [0.003],
  [4.9], [0.0299], [0.0127], [0.0207], [0.0097], [0.0052],
  [5.0], [0.039], [0.0119], [0.0228], [0.0062], [0.0099],
  
  )],
  caption: [The trivial vacuum-to-$d_r overline(d)_r$ probabilities for $N_f = 2$ and $m = g = L = 1$. Results are shown for 1, 2, 3, 5 and 10 Trotter steps.], kind: table
  )
<tab:vactodrdrbData>

The required $N$#sub[Trott] for a $epsilon.alt_(upright("Trott")) < 0.1$ in the trivial vacuum-to-vacuum probability is given in @tab:vacNTrottData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 20,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 16)[Required number of Trotter steps, $N$#sub[Trott]], [], [], [], [],),
  table.hline(),
  [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [], [], [], [],
  [0], [1], [25], [95], [50], [271], [75], [521], [100], [740], [125], [1080], [150], [1417], [175], [1967], [], [], [], [],
  [0.5], [1], [25.5], [95], [50.5], [271], [75.5], [521], [100.5], [740], [125.5], [1080], [150.5], [1598], [175.5], [1967], [], [], [], [],
  [1], [3], [26], [103], [51], [271], [76], [521], [101], [740], [126], [1113], [151], [1598], [176], [1967], [], [], [], [],
  [1.5], [4], [26.5], [103], [51.5], [302], [76.5], [521], [101.5], [740], [126.5], [1113], [151.5], [1598], [176.5], [1967], [], [], [], [],
  [2], [4], [27], [114], [52], [302], [77], [521], [102], [794], [127], [1113], [152], [1598], [177], [1967], [], [], [], [],
  [2.5], [4], [27.5], [114], [52.5], [302], [77.5], [521], [102.5], [794], [127.5], [1224], [152.5], [1598], [177.5], [1967], [], [], [], [],
  [3], [4], [28], [114], [53], [302], [78], [521], [103], [868], [128], [1224], [153], [1598], [178], [1967], [], [], [], [],
  [3.5], [10], [28.5], [121], [53.5], [302], [78.5], [521], [103.5], [868], [128.5], [1224], [153.5], [1598], [178.5], [1967], [], [], [], [],
  [4], [10], [29], [130], [54], [302], [79], [535], [104], [868], [129], [1224], [154], [1598], [179], [2023], [], [], [], [],
  [4.5], [10], [29.5], [130], [54.5], [335], [79.5], [535], [104.5], [868], [129.5], [1224], [154.5], [1598], [179.5], [2023], [], [], [], [],
  [5], [10], [30], [130], [55], [335], [80], [597], [105], [868], [130], [1224], [155], [1598], [180], [2023], [], [], [], [],
  [5.5], [10], [30.5], [130], [55.5], [335], [80.5], [597], [105.5], [868], [130.5], [1224], [155.5], [1598], [180.5], [2023], [], [], [], [],
  [6], [19], [31], [130], [56], [335], [81], [597], [106], [868], [131], [1224], [156], [1598], [181], [2023], [], [], [], [],
  [6.5], [19], [31.5], [159], [56.5], [335], [81.5], [597], [106.5], [868], [131.5], [1224], [156.5], [1598], [181.5], [2023], [], [], [], [],
  [7], [19], [32], [159], [57], [363], [82], [597], [107], [868], [132], [1224], [157], [1598], [182], [2023], [], [], [], [],
  [7.5], [19], [32.5], [159], [57.5], [363], [82.5], [597], [107.5], [868], [132.5], [1224], [157.5], [1598], [182.5], [2023], [], [], [], [],
  [8], [19], [33], [159], [58], [363], [83], [597], [108], [868], [133], [1224], [158], [1598], [183], [2023], [], [], [], [],
  [8.5], [27], [33.5], [159], [58.5], [363], [83.5], [597], [108.5], [868], [133.5], [1224], [158.5], [1598], [183.5], [2023], [], [], [], [],
  [9], [27], [34], [167], [59], [363], [84], [597], [109], [896], [134], [1224], [159], [1598], [184], [2023], [], [], [], [],
  [9.5], [27], [34.5], [167], [59.5], [363], [84.5], [613], [109.5], [896], [134.5], [1224], [159.5], [1598], [184.5], [2023], [], [], [], [],
  [10], [27], [35], [167], [60], [363], [85], [613], [110], [896], [135], [1224], [160], [1598], [185], [2137], [], [], [], [],
  [10.5], [29], [35.5], [167], [60.5], [363], [85.5], [613], [110.5], [896], [135.5], [1224], [160.5], [1598], [185.5], [2137], [], [], [], [],
  [11], [34], [36], [167], [61], [363], [86], [631], [111], [896], [136], [1224], [161], [1598], [186], [2137], [], [], [], [],
  [11.5], [34], [36.5], [167], [61.5], [370], [86.5], [631], [111.5], [896], [136.5], [1279], [161.5], [1598], [186.5], [2137], [], [], [], [],
  [12], [34], [37], [167], [62], [370], [87], [631], [112], [896], [137], [1279], [162], [1719], [187], [2137], [], [], [], [],
  [12.5], [34], [37.5], [182], [62.5], [370], [87.5], [631], [112.5], [896], [137.5], [1279], [162.5], [1719], [187.5], [2203], [], [], [], [],
  [13], [42], [38], [182], [63], [397], [88], [631], [113], [896], [138], [1279], [163], [1719], [188], [2203], [], [], [], [],
  [13.5], [42], [38.5], [186], [63.5], [397], [88.5], [631], [113.5], [975], [138.5], [1279], [163.5], [1719], [188.5], [2203], [], [], [], [],
  [14], [42], [39], [186], [64], [397], [89], [650], [114], [975], [139], [1356], [164], [1719], [189], [2203], [], [], [], [],
  [14.5], [42], [39.5], [186], [64.5], [397], [89.5], [650], [114.5], [975], [139.5], [1356], [164.5], [1747], [189.5], [2203], [], [], [], [],
  [15], [42], [40], [197], [65], [397], [90], [650], [115], [975], [140], [1356], [165], [1747], [190], [2203], [], [], [], [],
  [15.5], [51], [40.5], [197], [65.5], [397], [90.5], [692], [115.5], [975], [140.5], [1356], [165.5], [1747], [190.5], [2203], [], [], [], [],
  [16], [51], [41], [197], [66], [453], [91], [692], [116], [1000], [141], [1356], [166], [1747], [191], [2203], [], [], [], [],
  [16.5], [51], [41.5], [197], [66.5], [453], [91.5], [705], [116.5], [1000], [141.5], [1356], [166.5], [1747], [191.5], [2203], [], [], [], [],
  [17], [51], [42], [197], [67], [453], [92], [705], [117], [1000], [142], [1356], [167], [1747], [192], [2203], [], [], [], [],
  [17.5], [67], [42.5], [197], [67.5], [453], [92.5], [705], [117.5], [1000], [142.5], [1356], [167.5], [1798], [192.5], [2203], [], [], [], [],
  [18], [67], [43], [248], [68], [453], [93], [707], [118], [1000], [143], [1356], [168], [1798], [193], [2203], [], [], [], [],
  [18.5], [67], [43.5], [248], [68.5], [475], [93.5], [707], [118.5], [1000], [143.5], [1356], [168.5], [1798], [193.5], [2203], [], [], [], [],
  [19], [67], [44], [248], [69], [475], [94], [707], [119], [1000], [144], [1356], [169], [1798], [194], [2203], [], [], [], [],
  [19.5], [67], [44.5], [248], [69.5], [475], [94.5], [707], [119.5], [1000], [144.5], [1417], [169.5], [1798], [194.5], [2203], [], [], [], [],
  [20], [85], [45], [248], [70], [475], [95], [707], [120], [1000], [145], [1417], [170], [1798], [195], [2203], [], [], [], [],
  [20.5], [85], [45.5], [264], [70.5], [475], [95.5], [707], [120.5], [1000], [145.5], [1417], [170.5], [1798], [195.5], [2203], [], [], [], [],
  [21], [85], [46], [264], [71], [475], [96], [707], [121], [1000], [146], [1417], [171], [1798], [196], [2203], [], [], [], [],
  [21.5], [85], [46.5], [264], [71.5], [475], [96.5], [707], [121.5], [1075], [146.5], [1417], [171.5], [1798], [196.5], [2273], [], [], [], [],
  [22], [85], [47], [264], [72], [475], [97], [707], [122], [1075], [147], [1417], [172], [1798], [197], [2273], [], [], [], [],
  [22.5], [95], [47.5], [264], [72.5], [475], [97.5], [735], [122.5], [1075], [147.5], [1417], [172.5], [1798], [197.5], [2273], [], [], [], [],
  [23], [95], [48], [264], [73], [475], [98], [735], [123], [1075], [148], [1417], [173], [1798], [198], [2273], [], [], [], [],
  [23.5], [95], [48.5], [264], [73.5], [475], [98.5], [740], [123.5], [1075], [148.5], [1417], [173.5], [1967], [198.5], [2273], [], [], [], [],
  [24], [95], [49], [264], [74], [475], [99], [740], [124], [1075], [149], [1417], [174], [1967], [199], [2352], [], [], [], [],
  [24.5], [95], [49.5], [264], [74.5], [521], [99.5], [740], [124.5], [1075], [149.5], [1417], [174.5], [1967], [199.5], [2352], [], [], [], [],
  
  )],
  caption: [The required $N$#sub[Trott] for a $epsilon.alt_(upright("Trott")) < 0.1$ in the trivial vacuum-to-vacuum probability.], kind: table
  )
<tab:vacNTrottData>

The required $N$#sub[Trott] for a $epsilon.alt_(upright("Trott")) < 0.1$ in the trivial vacuum-to-$d_r overline(d)_r$ probability is given in @tab:drdrbNTrottData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 8,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 8)[Required number of Trotter steps, $N$#sub[Trott]],),
  table.hline(),
  [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]], [$t$], [$N$#sub[Trott]],
  [0], [1], [25], [243], [50], [945], [75], [1706],
  [0.5], [2], [25.5], [337], [50.5], [945], [75.5], [1706],
  [1], [2], [26], [337], [51], [945], [76], [1739],
  [1.5], [3], [26.5], [337], [51.5], [945], [76.5], [1739],
  [2], [7], [27], [337], [52], [945], [77], [1739],
  [2.5], [10], [27.5], [337], [52.5], [945], [77.5], [1739],
  [3], [10], [28], [337], [53], [945], [78], [1739],
  [3.5], [10], [28.5], [337], [53.5], [945], [78.5], [1739],
  [4], [12], [29], [337], [54], [945], [79], [1739],
  [4.5], [24], [29.5], [337], [54.5], [945], [79.5], [1739],
  [5], [24], [30], [337], [55], [945], [80], [1739],
  [5.5], [24], [30.5], [337], [55.5], [945], [80.5], [1739],
  [6], [24], [31], [337], [56], [945], [81], [1739],
  [6.5], [32], [31.5], [337], [56.5], [945], [81.5], [1739],
  [7], [32], [32], [384], [57], [945], [82], [1739],
  [7.5], [32], [32.5], [384], [57.5], [1168], [82.5], [1739],
  [8], [32], [33], [384], [58], [1168], [83], [2064],
  [8.5], [33], [33.5], [384], [58.5], [1168], [83.5], [2064],
  [9], [72], [34], [384], [59], [1168], [84], [2064],
  [9.5], [72], [34.5], [709], [59.5], [1168], [84.5], [2064],
  [10], [72], [35], [709], [60], [1285], [85], [2064],
  [10.5], [72], [35.5], [709], [60.5], [1285], [85.5], [2064],
  [11], [72], [36], [709], [61], [1285], [86], [2064],
  [11.5], [98], [36.5], [709], [61.5], [1285], [86.5], [2064],
  [12], [98], [37], [709], [62], [1285], [87], [2064],
  [12.5], [98], [37.5], [709], [62.5], [1285], [87.5], [2064],
  [13], [98], [38], [709], [63], [1285], [88], [2064],
  [13.5], [98], [38.5], [709], [63.5], [1285], [88.5], [2064],
  [14], [148], [39], [709], [64], [1285], [89], [2064],
  [14.5], [148], [39.5], [709], [64.5], [1285], [89.5], [2064],
  [15], [148], [40], [709], [65], [1285], [90], [2064],
  [15.5], [148], [40.5], [709], [65.5], [1285], [90.5], [2064],
  [16], [148], [41], [709], [66], [1285], [91], [2064],
  [16.5], [148], [41.5], [709], [66.5], [1285], [91.5], [2064],
  [17], [148], [42], [709], [67], [1285], [92], [2064],
  [17.5], [148], [42.5], [709], [67.5], [1285], [92.5], [2064],
  [18], [148], [43], [709], [68], [1285], [93], [2064],
  [18.5], [148], [43.5], [709], [68.5], [1285], [93.5], [2064],
  [19], [148], [44], [709], [69], [1285], [94], [2064],
  [19.5], [148], [44.5], [709], [69.5], [1285], [94.5], [2590],
  [20], [148], [45], [709], [70], [1285], [95], [2590],
  [20.5], [233], [45.5], [709], [70.5], [1285], [95.5], [2590],
  [21], [233], [46], [709], [71], [1285], [96], [2590],
  [21.5], [233], [46.5], [709], [71.5], [1706], [96.5], [2590],
  [22], [233], [47], [709], [72], [1706], [97], [2590],
  [22.5], [233], [47.5], [709], [72.5], [1706], [97.5], [2590],
  [23], [243], [48], [709], [73], [1706], [98], [2590],
  [23.5], [243], [48.5], [945], [73.5], [1706], [98.5], [2590],
  [24], [243], [49], [945], [74], [1706], [99], [2780],
  [24.5], [243], [49.5], [945], [74.5], [1706], [99.5], [2780],
  
  )],
  caption: [The required $N$#sub[Trott] for a $epsilon.alt_(upright("Trott")) < 0.1$ in the trivial vacuum-to-$d_r overline(d)_r$ probability.], kind: table
  )
<tab:drdrbNTrottData>

The decomposition of the energy, starting from trivial vacuum at $t = 0$, is given in @tab:vacAnimData.

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,left,left,),
    table.header(table.cell(align: center, colspan: 4)[Decomposition of the energy starting from the trivial vacuum],),
    table.hline(),
    [$t$], [$chevron.l H_m chevron.r$], [$chevron.l H_(k i n) chevron.r$], [$chevron.l H_(e l) chevron.r$],
    [~~0 ~~], [0], [0], [0],
    [0.3], [0.254], [-0.3369], [0.08281],
    [0.6], [0.8455], [-1.104], [0.2584],
    [0.9], [1.393], [-1.781], [0.3879],
    [1.2], [1.575], [-1.974], [0.3997],
    [1.5], [1.31], [-1.625], [0.3151],
    [1.8], [0.769], [-0.9532], [0.1842],
    [2.1], [0.2684], [-0.3282], [0.05983],
    [2.4], [0.1081], [-0.1256], [0.01747],
    [2.7], [0.3939], [-0.5129], [0.119],
    [3.0], [0.9349], [-1.245], [0.31],
    [3.3], [1.359], [-1.788], [0.4285],
    [3.6], [1.401], [-1.788], [0.3873],
    [3.9], [1.079], [-1.335], [0.2565],
    [4.2], [0.6237], [-0.7542], [0.1305],
    [4.5], [0.3094], [-0.3586], [0.0492],
  )]
  , caption: [Decomposition of the energy starting from the trivial vacuum at $t = 0$.]
  , kind: table
  )
<tab:vacAnimData>

The trivial vacuum to $B overline(B)$ probabilities are given in @tab:BBarprobData.

#figure(
  block(breakable: false)[#set text(size: 8pt)
  #table(
  columns: 5,
  inset: (y: 1.5pt),
  align: (center,left,left,left,left,),
  table.header(table.cell(align: center, colspan: 5)[Trivial vacuum to $B overline(B)$ probability],),
  table.hline(),
  [$t$], [1 Step], [2 Steps], [3 Steps], [Exact],
  [~~0 ~~], [0], [0], [0], [0],
  [0.1], [0.0000], [0.0000], [0.0000], [0.0000],
  [0.2], [0.0000], [0.0000], [0.0000], [0.0000],
  [0.3], [0.0000], [0.0000], [0.0000], [0.0000],
  [0.4], [0.0001], [0.0001], [0.0001], [0.0001],
  [0.5], [0.0002], [0.0002], [0.0002], [0.0002],
  [0.6], [0.0007], [0.0005], [0.0005], [0.0005],
  [0.7], [0.0016], [0.0011], [0.001], [0.001],
  [0.8], [0.0035], [0.0021], [0.0019], [0.0018],
  [0.9], [0.0068], [0.0036], [0.0032], [0.0029],
  [1.0], [0.0121], [0.0055], [0.0047], [0.0042],
  [1.1], [0.0204], [0.0079], [0.0064], [0.0055],
  [1.2], [0.0324], [0.0104], [0.0081], [0.0067],
  [1.3], [0.0491], [0.013], [0.0095], [0.0075],
  [1.4], [0.0715], [0.0154], [0.0105], [0.0079],
  [1.5], [0.1003], [0.0175], [0.0109], [0.0078],
  [1.6], [0.1363], [0.0192], [0.0108], [0.0072],
  [1.7], [0.1798], [0.0206], [0.0101], [0.0062],
  [1.8], [0.231], [0.0218], [0.0092], [0.0052],
  [1.9], [0.2897], [0.023], [0.008], [0.0041],
  [2.0], [0.355], [0.0241], [0.0069], [0.0033],
  [2.1], [0.426], [0.0252], [0.0059], [0.0025],
  [2.2], [0.501], [0.026], [0.005], [0.002],
  [2.3], [0.5783], [0.0263], [0.0042], [0.0015],
  [2.4], [0.6555], [0.0257], [0.0036], [0.0011],
  [2.5], [0.7304], [0.0239], [0.003], [0.0007],
  [2.6], [0.8003], [0.0208], [0.0026], [0.0004],
  [2.7], [0.8629], [0.0166], [0.0024], [0.0001],
  [2.8], [0.9158], [0.0116], [0.0025], [0.0000],
  [2.9], [0.9571], [0.0066], [0.0029], [0.0000],
  [3.0], [0.9851], [0.0025], [0.0036], [0.0002],
  [3.1], [0.9987], [0.0002], [0.0045], [0.0005],
  [3.2], [0.9974], [0.0005], [0.0057], [0.0008],
  [3.3], [0.9813], [0.0037], [0.007], [0.0011],
  [3.4], [0.951], [0.01], [0.0087], [0.0014],
  [3.5], [0.9077], [0.0189], [0.0111], [0.0016],
  [3.6], [0.853], [0.0295], [0.0148], [0.0019],
  [3.7], [0.789], [0.0409], [0.0205], [0.0023],
  [3.8], [0.7181], [0.0517], [0.0293], [0.0027],
  [3.9], [0.6427], [0.061], [0.042], [0.0032],
  [4.0], [0.5652], [0.0677], [0.0592], [0.0036],
  [4.1], [0.4882], [0.0714], [0.0814], [0.004],
  [4.2], [0.4137], [0.0719], [0.1085], [0.0043],
  [4.3], [0.3436], [0.0693], [0.14], [0.0045],
  [4.4], [0.2793], [0.0641], [0.1749], [0.0046],
  [4.5], [0.2219], [0.057], [0.2117], [0.0047],
  [4.6], [0.172], [0.0488], [0.2489], [0.0049],
  [4.7], [0.1297], [0.0401], [0.2848], [0.005],
  [4.8], [0.095], [0.0317], [0.3178], [0.0051],
  [4.9], [0.0673], [0.024], [0.3464], [0.0051],
  [5.0], [0.0459], [0.0174], [0.3695], [0.0048],
  
  )],
  caption: [Trivial vacuum to $B overline(B)$ probability for $m = g = L = N_f = 1$.], kind: table
  )
<tab:BBarprobData>

#show bibliography: set text(size: 9pt)
#show bibliography: set par(leading: 0.45em, spacing: 1em)
#bibliography("refs.bib", style: "../../typst-refs/jhep.csl", title: [References])