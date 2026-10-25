#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 12pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.74cm, right: 2.75cm, top: 3.88cm, bottom: 3.60cm))
#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 17.28pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14.4pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")
#set par(justify: true, leading: 1.34em, spacing: 1.34em, first-line-indent: (amount: 1.46em, all: true))
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#v(1.41cm)
#align(center)[
  #set par(justify: false)
  #set par(leading: 0.62em)
  #text(size: 19.7pt)[Is there evidence for exponential quantum advantage in quantum chemistry?]
  #v(0.72em)
  #text(size: 14.3pt)[
    Seunghoon Lee#super(size: 10pt)[1], Joonho Lee#super(size: 10pt)[2], Huanchen Zhai#super(size: 10pt)[1], Yu Tong#super(size: 10pt)[3], Alexander M. Dalzell#super(size: 10pt)[4], Ashutosh Kumar#super(size: 10pt)[5,9], Phillip Helms#super(size: 10pt)[1], Johnnie Gray#super(size: 10pt)[1], Zhi-Hao Cui#super(size: 10pt)[1], Wen-Yuan Liu#super(size: 10pt)[1], Michael Kastoryano#super(size: 10pt)[4,6], Ryan Babbush#super(size: 10pt)[7], John Preskill#super(size: 10pt)[10,4], David R. Reichman#super(size: 10pt)[2], Earl T. Campbell#super(size: 10pt)[11], Edward F. Valeev#super(size: 10pt)[5], Lin Lin#super(size: 10pt)[3,8], Garnet Kin-Lic Chan \*#super(size: 10pt)[1]
  ]
  #v(0.45em)
  #text(size: 11pt, style: "italic")[
    #set par(leading: 1.05em)
    #super(size: 7.7pt)[1]Division of Chemistry and Chemical Engineering, California Institute of Technology, Pasadena, California 91125, USA \
    #super(size: 7.7pt)[2]Department of Chemistry, Columbia University, New York, New York 10027, USA \
    #super(size: 7.7pt)[3]Department of Mathematics, University of California, Berkeley, California 94720, USA \
    #super(size: 7.7pt)[4]AWS Center for Quantum Computing, Pasadena, California 91125, USA \
    #super(size: 7.7pt)[5]Department of Chemistry, Virginia Tech, Blacksburg, Virginia 24061, USA \
    #super(size: 7.7pt)[6]Amazon Quantum Solutions Lab, Seattle, Washington 98170, USA \
    #super(size: 7.7pt)[7]Google Quantum AI, 340 Main Street, Venice, CA 90291, USA \
    #super(size: 7.7pt)[8]Computational Research Division, Lawrence Berkeley National Laboratory, Berkeley, California 94720, USA \
    #super(size: 7.7pt)[9]Theoretical Division, Los Alamos National Laboratory, Los Alamos, New Mexico 87545, USA \
    #super(size: 7.7pt)[10]Institute for Quantum Information and Matter, California Institute of Technology, Pasadena, California 91125, USA \
    #super(size: 7.7pt)[11]Riverlane, Cambridge, UK
  ]
]

#v(1fr)
#text(size: 10pt)[\*gkc1000\@gmail.com]

#pagebreak()
#block(width: 100%, inset: (top: 36pt, bottom: 20pt), align(center)[#text(size: 10.9pt, weight: "bold")[Abstract]])
#pad(left: 29.2pt, right: 29.2pt)[
  #set text(size: 10.9pt)
  #set par(first-line-indent: 0em)
  #set par(leading: 1.53em)
  The idea to use quantum mechanical devices to simulate other quantum systems is commonly ascribed to Feynman. Since the original suggestion, concrete proposals have appeared for simulating molecular and materials chemistry through quantum computation, as a potential "killer application"~@reiher2017elucidating @cen @bauer2020quantum @cao2019quantum @mcardle2020quantum. Indications of potential exponential quantum advantage in artificial tasks~@arute2019quantum @zhong2020quantum @wu2021strong @hangleiter2022computational have increased interest in this application, thus, it is critical to understand the basis for potential exponential quantum advantage in quantum chemistry. Here we gather the evidence for this case in the most common task in quantum chemistry, namely, ground-state energy estimation. We conclude that evidence for such an exponential advantage across chemical space has yet to be found. While quantum computers may still prove useful for quantum chemistry, it may be prudent to assume exponential speedups are not generically available for this problem.
]
= Main
<main>
The most common task in quantum chemistry is computing the ground electronic energy. The exponential quantum advantage hypothesis for this task is that for a large set of relevant ("generic") chemical problems, this may be completed exponentially more quickly (as a function of system size) on a quantum versus classical computer~@EQAQC. Here we examine this hypothesis.


We proceed using numerical experiments supported by theoretical analysis.


To limit scope, we focus on fault-tolerant quantum algorithms --- the most advantageous setting for quantum computing, not limited by noise or hardware. Rigorously, computing the ground-state of even simple Hamiltonians can be exponentially hard on a quantum computer~@kempe2006complexity. However, such Hamiltonians might not be relevant to generic chemistry, and thus the specific exponential quantum advantage (EQA) hypothesis considered here, is that generic chemistry involves Hamiltonians which are polynomially easy for quantum algorithms (with respect to ground-state preparation) and simultaneously still exponentially hard classically, even using the best classical heuristics. Numerically, we thus focus on the evidence for quantum state preparation being exponentially easier than classical heuristic solution in typical problems; and whether the cost of classical heuristics in such problems scales exponentially with system size.


We stress that we do not attempt a rigorous proof or disproof of the EQA hypothesis, or other classes of quantum advantage. Such proofs cannot be obtained, not least because what is "generic" chemistry is not precisely defined. Our goal is to provide a coherent examination of the evidence for whether exponential quantum speedup for ground-state determination in quantum chemistry should be considered likely in typical cases of interest --- or, instead, very fine-tuned.


= Theoretical background
<theoretical-background>


== Statement of the problem
<statement-of-the-problem>


We compute the ground-state eigenvalue $E$ of the electronic Schrödinger operator (Hamiltonian) of a chemical system discretized with a basis set, and the problem size is the basis size $L$. We consider the case where increasing $L$ corresponds to increasing physical system size (i.e.~number of atoms) with basis size proportional to system size (other scenarios are discussed in the SI S1.1). The absolute ground-state energy $E$ increases with $L$, and in physical problems we expect extensivity (i.e.~$lim_(L arrow.r oo) E ( L ) prop L$ for a chemically uniform system); in this limit, the energy density $macron(E) = E / L$ may be the quantity of interest. Thus depending on the setting, the relevant error can be $epsilon.alt$ (error in $E$) or $macron(epsilon.alt)$ (error in $macron(E)$).


== Fault tolerant quantum algorithms for ground-state quantum chemistry
<fault-tolerant-quantum-algorithms-for-ground-state-quantum-chemistry>


Fault tolerant quantum algorithms are ones which employ deep circuits (e.g.~depth is a function of $1 / epsilon.alt$). The most famous one in quantum chemistry is quantum phase estimation (QPE)~@kitaev1995quantum @aspuru2005simulated. We focus on QPE for simplicity; qualitative features of the complexity remain similar in "post-QPE" algorithms~@lin2021heisenberg. Phase estimation approximately measures the energy with approximate projection onto an eigenstate. The cost has 3 components (i) preparing an initial state $Phi$, (ii) the phase estimation circuit, and (iii) the number of repetitions (to produce the ground-state $Psi_0$ rather than any eigenstate). The cost to obtain $E$ to precision $epsilon.alt$ is


$ upright("poly") ( 1 / S ) [ upright("poly") ( L ) upright("poly") ( 1 / epsilon.alt ) + C ] $


where $C$ corresponds to (i), $upright("poly") ( L ) upright("poly") ( 1 / epsilon.alt )$ corresponds to (ii), and $upright("poly") ( 1 / S )$ ($= 1 / S^2$ for QPE) with $S = | chevron.l Phi | Psi_0 chevron.r |$ corresponds to (iii). We term $S$ overlap and $S^2$ weight.


Motivated by the $upright("poly") ( L )$ cost of (ii), and assuming an $exp ( L )$ cost for classical solution, it is often informally stated that QPE yields EQA for the ground-state quantum chemistry task~@EQAQC. However, the number of repetitions ($upright("poly") ( 1 / S )$) may also depend on $L$: this stems from the quality of state preparation. The restriction to generic chemistry effectively means we assume that good state preparation is not exponentially hard due to unspecified additional structure. But such additional structure could also aid classical heuristics, and for EQA, the state preparation cost must be exponentially less than the classical solution cost.


== State preparation
<state-preparation>


=== Ansatz state preparation
<ansatz-state-preparation>
We can prepare a state specified by an approximate classical ansatz. (We assume once an ansatz solution is specified, it is easy to prepare on the quantum device). Often,


simple states, such as the Hartree-Fock or Kohn-Sham ground-state (single Slater determinants) are considered in ansatz state preparation, as they are hoped to have good overlap with $Psi_0$~@o2019quantum @o2016scalable\; the $upright("poly") ( 1 / S )$ cost is then not further quantitatively considered. But while good overlap with such simple states can be observed in small molecules, EQA is an asymptotic statement, thus we should consider the limit of large $L$.


The orthogonality catastrophe~@kohn1999nobel @chan2012low has previously been discussed in the context of state preparation in the large $L$ limit~@mcclean2014exploiting. For a set of $O ( L )$ non-interacting subsystems, the global ground-state is the product of the subsystem ground-states, thus if the local overlap between the approximate classical ansatz and ground-state for each subsystem is $tilde s < 1$, then the global overlap is $s^(O ( L ))$ i.e. it decreases exponentially. This is sometimes viewed as an obstacle to ansatz state preparation, but in fact it does not rule it out; the issue is more subtle, because the above analysis assumes that both the ansatz and the actual ground-state have some product structure. But one need not consider a classical ansatz with (approximate) product structure; and, at least in principle, ground-state correlations could mean that the global overlap is not guaranteed to be well approximated by a product of local overlaps. Also, even if one uses a product-like ansatz to approximate a ground-state of near-product form, one can improve the local overlap as a function of $L$, such that the global overlap is $1 / upright("poly") ( L )$ or better.


The relevant consideration for EQA however, is that if classical heuristics can efficiently prepare states with such good overlap for large $L$ (for some systems), they may also efficiently obtain the ground-state energy to the desired precision.



 


=== Adiabatic state preparation (ASP)
<adiabatic-state-preparation-asp>
Alternatively, we can evolve slowly from the ground-state of a solvable initial Hamiltonian to that of the desired Hamiltonian~@farhi2000quantum @albash2018adiabatic @veis2014adiabatic @aspuru2005simulated. This requires that the ground-state gap along the path be not too small; for paths where the smallest minimum gap $Delta_(upright("min")) gt.eq 1 / upright("poly") ( L )$ (which we will term "protected"), ASP plus QPE provides a polynomial cost quantum algorithm. Since a protected gap is not guaranteed using an arbitrary initial Hamiltonian and path, ASP is a heuristic quantum algorithm. An extreme problem that expresses the difficulty of finding a good path is unstructured search, where $Delta_(upright("min"))$ acquires a strong dependence on the ground-state $Upsilon_0$ of the initial Hamiltonian, $Delta_(upright("min")) tilde | chevron.l Upsilon_0 | Psi_0 chevron.r |$~@roland2003adiabatic, yielding exponential cost when using adiabatic algorithms.


The above raises several issues. First, in correlated quantum systems with competing ground-states, different phases could be separated by first-order phase transitions (where the gap is not protected) requiring ASP to start in the correct phase. Assuming one uses classical heuristics to prepare such a starting point and choice of path, one encounters similar questions to those raised in the discussion of ansatz state preparation. Second, one might ask how common the above situation is in generic chemistry, i.e. whether interesting chemical problems allow for initial Hamiltonians and paths with a protected gap to be trivially found.


== The power of classical heuristics
<the-power-of-classical-heuristics>


"Exact" classical methods for ground state determination, such as exact diagonalization, are exponentially expensive on a classical computer (see SI S1.3). Thus the typical methods used in quantum chemistry are classical heuristics, which come in a wide variety for different problems (see SI S1.2). The critical questions for EQA are (i) do these heuristics require $exp ( L )$ cost for given $epsilon.alt$ or $macron(epsilon.alt)$ in their application domain, (ii) does the patchwork of heuristics cover chemical space, and (iii) if there are gaps in coverage in practice, do we require classical methods of $exp ( L )$ cost to cover them?


EQA assumes exponential-scaling cost of classical heuristic algorithms for given $epsilon.alt$ (or $macron(epsilon.alt)$) across generic problems. We will examine this assumption in our numerical experiments. However, as actually employed in calculations, classical heuristics are often executed with $upright("poly") ( L )$ cost without necessarily achieving a specific accuracy, complicating the comparison with rigorous quantum algorithms. In particular, the error dependence can impact the EQA comparison, for example, a $upright("poly") ( L ) exp ( macron(epsilon.alt)^(- 1) )$ classical algorithm implies $exp ( L )$ cost for given $epsilon.alt$. Thus we will also examine the empirical precision dependence of classical heuristics with respect to $epsilon.alt$ or $macron(epsilon.alt)$.


= Numerical experiments
<numerical-experiments>


== Fe-S clusters and metalloclusters of nitrogenase
<fe-s-clusters-and-metalloclusters-of-nitrogenase>


Iron-sulfur (Fe-S) clusters are amongst the most common bioinorganic motifs in Nature~@beinert1997iron, and the Fe-S clusters of nitrogenase have become a poster child problem for quantum chemistry on quantum devices~@reiher2017elucidating @li2019electronic. In the current context, they provide a concrete setting to assess the EQA hypothesis, in particular, the behaviour of quantum state preparation strategies.


Specifically, we consider iron-sulfur clusters containing 2, 4, 8 transition metal atoms (the latter includes the famous FeMo-cofactor) in Figure 1. The 2, 4 metal clusters will be referred to as \[2Fe-2S\], \[4Fe-4S\] clusters, while the 8 metal clusters include the P-cluster (8Fe) and the FeMo-cofactor (7Fe, 1Mo). We note that the P-cluster and FeMo-cofactor are the largest Fe-S clusters found in Nature. We represent the electronic structure in active spaces with Fe 3d/S 3p character constructed from Kohn-Sham orbitals. Within the occupation number to qubit mapping, this corresponds to up to $40$ qubits (\[2Fe-2S\]), up to $72$ qubits (\[4Fe-4S\]), and up to $154$ qubits (P-cluster and FeMo-co) (see SI S3.1). For \[2Fe-2S\], exact solutions can be obtained using exact full configuration interaction (FCI). For all clusters, we obtain a range of approximate solutions using the quantum chemistry density matrix renormalization group (DMRG) @white1999ab @chan2011density @baiardi2020density @sharma2014low @li2019electronic2 with a matrix product state (MPS) bond dimension $D$\; increasing $D$ improves the approximation, allowing extrapolation to the exact result (see SI S3.3). Note that the classical calculations in this section are of interest mainly to provide data to understand quantum state preparation.


=== Nature of the ground-state and cost of ansatz state preparation
<nature-of-the-ground-state-and-cost-of-ansatz-state-preparation>


We first examine the nature of the ground-state $Psi_0$ and the cost of ansatz state preparation. For this, we compute the weight of a Slater determinant $S^2 = | chevron.l Phi_D | Psi_0 chevron.r |^2$, shown in Figure 1#strong[B]. $Phi_D$ is parametrized by its orbitals ${ phi.alt }$, and we choose a priori, or optimize, ${ phi.alt }$ to maximize this weight (for a best-case scenario that uses information from the solution $Psi_0$, see SI S3.4). The weights decrease exponentially over a small number of metal centers, and are already very small in FeMo-co ($tilde 10^(- 7)$). The number of QPE repetitions is $upright("poly") ( 1 / S )$, yielding a large prefactor even for an "optimized" Slater determinant.


// [figvision-cn] imgs/Fig1_lowresolution.png
// 该图像包含两个子图，分别标记为A和B。 子图A 类型：分子
// 结构示意图（球棍模型）。 布局与内容：此子图展示了四种
// 铁硫簇的结构模型，按照从上到下、从左到右的顺序排列。左
// 上角提供了一个图例，定义了不同颜色球体代表的原子元素：
// 橙色代表铁（Fe），黄色代表硫（S），紫色代表钼（Mo），
// 绿色代表碳（C），红色代表氧（O），蓝色代表氮（N）。 第
// 一个结构（左上）：[2Fe-2S]簇。由两个橙色铁原子和两个黄
// 色硫原子交替连接形成一个菱形核心。每个铁原子还连接有两
// 个黄色的硫原子，这些硫原子上标有化学式“(CH3)S”。 第二
// 个结构（右上）：[4Fe-4S]簇。由四个橙色铁原子和四个黄色
// 硫原子构成一个立方烷状的笼形结构。外围连接有三个标有“(
// CH3)S”的基团和一个标有“S(CH3)”的基团。 第三个结构（中）：
// P簇（P-cluster）。这是一个较大的双核笼状结构，由八个橙
// 色铁原子和七个黄色硫原子组成。外围连接有六个标有“S(Cys
// )”的基团，其中一个位于顶部的基团被特别标注为“S(Cys)”和
// “S(ε-Cys)”。 第四个结构（下）：FeMo-co（铁钼辅因子）。
// 这是一个复杂的笼状结构，中心包含一个绿色的碳原子，周围
// 环绕着七个橙色铁原子和一个紫色钼原子，以及多个黄色硫原
// 子。右侧的紫色钼原子通过蓝色的氮原子连接到红色的组氨酸
// 配体（标记为“N(His)”），并进一步连接到一个红色的草酸根
// /柠檬酸根类配体（标记为“Homo Citrate”）。左侧连接有一
// 个标有“(Cys)S”的基团。 子图B 类型：散点图（对数坐标）。
// 坐标轴： 横轴（X轴）：名称为“Number of metal centers”
// （金属中心数量），单位为无因次数值。刻度标记为2, 4, 6,
// 8。 纵轴（Y轴）：名称为“|<Φ|Ψ0>|^2”，表示态权重或重叠
// 积分的平方。采用对数标度，范围从10^-8到10^-1，主刻度间
// 隔为一个数量级（10^-8, 10^-7, ..., 10^-1）。 数据系列
// 与符号： 图中有两组主要的数据点，根据形状区分物理含义：
// 实心圆点和实心方块/三角形/星号/菱形：代表最大权重行列
// 式的权重 |<ΦD|Ψ0>|^2，颜色为紫色。 空心圆点和空心星号/
// 叉号/菱形：代表最大权重构型态函数的权重 |<ΦCSF|Ψ0>|^2，
// 颜色为橙色。 具体数据点分布如下（按横轴数值分组）： 横
// 轴x=2处： 紫色实心圆点：y值约为2×10^-2。 橙色空心圆点：
// y值约为5×10^-2。 紫色实心正三角形：y值约为4×10^-3。 横
// 轴x=4处： 紫色实心正方形：y值约为2×10^-5。 橙色空心星
// 号：y值约为5×10^-3。 紫色实心五角星：y值约为4×10^-4。
// 橙色空心正方形：y值约为2×10^-4。 横轴x=8处： 紫色实心
// 倒三角形：y值约为3×10^-6。 橙色空心五角星：y值约为3×10
// ^-5。 紫色实心菱形：y值约为6×10^-8。 橙色空心菱形：y值
// 约为1×10^-7。 紫色实心叉号：y值约为8×10^-6。 橙色空心
// 叉号：y值约为8×10^-6。 图例说明： 右上角图例说明了形状
// 对应的物理量：紫色实心圆对应 |<ΦD|Ψ0>|^2，橙色空心圆对
// 应 |<ΦCSF|Ψ0>|^2。 右下角图例说明了不同符号对应的具体
// 化学体系及氧化态： 实心圆点 (●): (FeII, FeIII) —— 对应
// [2Fe-2S]簇。 实心正三角形 (▲): (FeIII, FeIII) —— 对应[
// 2Fe-2S]簇的另一种氧化态。 实心正方形 (■): (2FeII,
// 2FeIII) —— 对应[4Fe-4S]簇。 实心叉号 (※): (4FeIII) ——
// 对应[4Fe-4S]簇的另一种氧化态。 实心五角星 (★): Psyn ——
// 对应P簇的一种状态。 实心加号 (+): pN —— 对应P簇的另一
// 种状态。 实心星号 (*): pox —— 对应P簇的氧化态。 实心菱
// 形 (◆): FeMo-co —— 对应FeMo-co簇。 趋势结论：随着金属
// 中心数量的增加（从2增加到8），两种ansatz态（行列式和构
// 型态函数）的权重总体呈下降趋势，跨度达到数个数量级。在
// 大多数情况下，橙色数据点（构型态函数权重）高于同组的紫
// 色数据点（行列式权重），表明构型态函数能更好地描述基态
// 波函数。
#figure(image("imgs/Fig1_lowresolution.png", width: 86%),
  caption: [
    #strong[Ansatz state preparation and ansatz weights for model Fe-S clusters.] #strong[A,] Structural models of \[2Fe-2S\], \[4Fe-4S\], P-cluster, and FeMo-co. #strong[B,] Weight of two different types of ansatz state: largest weight determinant ($Phi_D$) (purple) and largest weight configuration state function ($Phi_(upright("CSF"))$) (orange) as a function of the number of metal centers in each cluster (using split-localized orbitals). P$""^(upright("N"))$, P$""^(upright("syn"))$, P$""^(upright("ox"))$ here refer to different oxidation states of the metal ions in the P-cluster. Both types of ansatz state show an exponential decrease in weight with the number of metal centers. For the \[2Fe-2S\] clusters, we also show results for the largest weight determinant using natural orbitals (empty symbols).
  ]
)
<fig:structure_overlap>



We next prepare more complex states with better overlap. We use a single configuration state function (a linear combination of Slater determinants that is an eigenfunction of total spin~@helgaker2014molecular). The weights improve but still show exponential decay to small values.


These results indicate that the magnitude of the ansatz overlap can become a relevant concern even in systems of modest size when using ansatz state preparation, thus we should consider improved state preparation. Assuming the ground-state is of approximately product form, we can obtain some rough insight into improved global ansatz state preparation (e.g. for 8 metal clusters) from the behaviour of improving the state locally (i.e. for the 2 metal clusters); we require $upright("poly") ( 1 / I )$ cost for the \[2Fe-2S\] fragment ($I$ is the infidelity $1 - S^2$) for efficient global state preparation. In SI S2.1 we show that this cost is indeed $upright("poly") ( 1 / I )$, but also that the energy error is $upright("poly") ( I )$. Thus under these assumptions, improving the local overlap sufficiently also implies efficient classical solution for the global energy. For any finite system, it may be possible to engineer a practical quantum advantage for some target precision from a sufficiently good ansatz overlap and a favourable ratio of classical and quantum costs.


But the problem of finding a classical heuristic that efficiently yields $1 / upright("poly") ( L )$ overlap but which cannot also efficiently reach the target precision remains.




 


=== Adiabatic state preparation
<adiabatic-state-preparation>


We next compute the ASP cost for a simplified $n_(upright("act")) = 12$ active space (24 qubit) \[2Fe-2S\] model (see SI S4.1). The path is a heuristic input, and we use one which linearly interpolates the Hamiltonian $H ( s )$ (with ground-state $Upsilon_0 ( s )$) between an initial Hamiltonian ($s = 0$, with ground-state $Upsilon_0 ( 0 )$) and the true Hamiltonian ($s = 1$, with ground-state $Upsilon_0 ( 1 ) equiv Psi_0$); the path preserves spin symmetry. We consider two families of $H ( 0 )$\; a set of mean-field Hamiltonians (with different Slater determinant ground-states) and a set of interacting Hamiltonians (these retain interactions among $q$ active spin-orbitals (qubits), definitions in SI S4.2).


Tight bounds on the ASP time ($T_(upright("ASP"))$) are difficult to obtain (see SI S1.5). However, we have verified that the adiabatic estimate $T_(upright("ASP"))^(upright("est")) tilde max_s tau ( s )$, with $tau ( s ) = | chevron.l Upsilon_0 ( s ) | d H ( s ) / d s | Upsilon_1 ( s ) chevron.r | / Delta^2 ( s )$ with $Delta ( s )$ the ground-state gap and $Upsilon_1 ( s )$ the first excited state of $H ( s )$, is a reasonable estimate for the desired preparation fidelity (here assumed 75\% final weight) by carrying out time-dependent simulations of ASP for simple instances to compute $T_(upright("ASP")) / T_(upright("ASP"))^(upright("est"))$ (Figure 2#strong[B]); for a range of examples, this ratio is $O ( 1 )$. Thus we use $T_(upright("ASP"))^(upright("est"))$ as the ASP time below.


Figure 2#strong[C] shows $T_(upright("ASP"))$ across the sets of $H ( 0 )$\; it varies over 8 orders of magnitude depending on the choice of $H ( 0 )$. We see a trend $1 / ( min_s Delta ( s ) ) tilde upright("poly") ( 1 / | chevron.l Upsilon_0 | Psi_0 chevron.r | )$ and thus $T_(upright("ASP")) tilde upright("poly") ( 1 / | chevron.l Upsilon_0 | Psi_0 chevron.r | )$ reminiscent of unstructured search. The practical consequence is that an a priori good choice of initial Hamiltonian is non-trivial; the mean-field Hamiltonian with the lowest ground state energy gives a large $T_(upright("ASP")) > T_(upright("QPE"))$ (an estimate of the total coherent QPE evolution time for 90\% confidence, $epsilon.alt$=$10^(- 3) E_h$, see analysis in SI S2.5), while out of the interacting $H ( 0 )$'s, we need to include almost all the interactions when diagonalizing $H ( 0 )$ for the initial state (20 out of 24 qubits) before $T_(upright("ASP")) < T_(upright("QPE"))$. Although these results are for the smallest FeS cluster, the dependence of $T_(upright("ASP"))$ on $S$ is problematic for EQA should it scale to larger interesting problems, and it illustrates the importance of heuristics to find a good initial starting point for ASP in relevant chemical problems. As discussed above, if classical heuristics are used for this task, this raises the question of whether they are exponentially advantageous over the classical heuristics for solution.



// [figvision-cn] imgs/Fig2_lowresolution.png
// 子图A为[2Fe-2S]簇的结构示意图及其简化活性空间模型。图
// 中中心是两个橙色的球体，代表铁（Fe）原子，它们之间通过
// 两个黄色的球体连接，代表硫（S）原子，形成一个菱形的
// Fe-S核心结构。每个铁原子向外延伸出两条黄绿色的键，连接
// 到末端的基团（显示为蓝白相间的哑铃状或锥形结构）。图的
// 右侧有一个垂直向上的箭头，标注为“z”，指示坐标轴方向。
// 图的下方有一行文字标注：“n_act=12 (10 Fe 3d and 2 S
// 3p_z)”，说明该模型选取了12个活性轨道，具体包括10个铁的
// 3d轨道和2个硫的3p_z轨道。 子图B是一个散点图，展示了ASP
// 时间与绝热估计值之间的比值关系。横坐标为“T_ASP^est / (
// Hartree)^-1”，采用对数刻度，范围从2^6到2^14；纵坐标为“
// T_ASP / T_ASP^est”，采用线性刻度，范围从1到5。图中包含
// 约18个黑色的实心圆点数据点。这些点整体呈现出下降趋势：
// 随着横坐标数值（绝热估计时间）的增加，纵坐标数值（实际
// 时间与估计时间的比值）逐渐减小，表明当估计的时间越长时，
// 实际运行时间与估计值的比率越接近1（即估计越准确）。 子
// 图C是一个双对数坐标散点图，展示了绝热估计值与初始基态
// 在最终基态中权重的关系。横坐标为“|<Psi_0 | Gamma_0>|^2
// ”，表示初始基态在最终基态中的权重，采用对数刻度，范围
// 从10^-14到10^0；纵坐标为“Adiabatic estimate T_ASP^est
// / (Hartree)^-1”，采用对数刻度，范围从10^0到10^8。 图中
// 包含三种视觉元素： 空心圆圈（o）：代表“Mean Field”（平
// 均场）结果，主要分布在图的左侧和中间区域，且大部分位于
// 一条水平虚线上方。 红色实心圆点（•）：代表“Interacting
// (Dyall)”（相互作用/Dyall模型）结果，主要集中在图的右侧。
// 部分红点旁有红色文字标注，分别标记为“n_act=9”、“n_act=
// 7”、“n_act=5”、“n_act=2,3,4,6”、“n_act=8”以及右下角的“
// n_act=11”和“n_act=10”。 黑色水平虚线：图例中标注为“
// Quantum Phase Estimation”（量子相位估计），位置大约在
// 纵坐标10^5处。 此外，图中有一条黑色的实线斜线，指向左
// 下方的一个空心圆圈区域，并附有文字说明“Lowest-energy
// mean-field state”（最低能量平均场态）。 整体趋势显示，
// 对于相互作用的系统（红点），绝热估计值（纵坐标）与初始
// 权重（横坐标）呈现反比关系：随着初始权重的增加，所需的
// 绝热估计时间显著减少。
#figure(image("imgs/Fig2_lowresolution.png", width: 80%),
  caption: [
    #strong[Adiabatic state preparation for a model \[2Fe-2S\] cluster.] #strong[A,] Structure and simplified active space model of \[2Fe-2S\] cluster. #strong[B,] ASP time and the adiabatic estimate. We see that the ratio $T_(upright("ASP")) / T_(upright("ASP"))^(upright("est"))$ is $O ( 1 )$. #strong[C,] Adiabatic estimates ($T_(upright("ASP"))^(upright("est"))$) for two families of initial Hamiltonians against the weight of the initial ground state ($Upsilon_0$) in the final ground state ($Psi_0$) ($| chevron.l Upsilon_0 | Psi_0 chevron.r |^2 )$, showing an inverse dependence on the initial weight. The mean-field Hamiltonians are constructed to have different Slater determinants as their ground-state, while the interacting Hamiltonians contain the full electron interaction amongst $n_(upright("act"))$ orbitals. Additional discussion in SI S4 and S2.3.
  ]
)
<fig:asp>


== The scaling of classical heuristics
<the-scaling-of-classical-heuristics>


The Fe-S cluster simulations raise questions as to whether high quality quantum state preparation can be assumed to be exponentially easier than classical heuristic solution. We now consider if classical heuristics in fact display $exp ( L )$ cost for fixed $epsilon.alt$ or $macron(epsilon.alt)$, as is required to establish EQA. We do so by considering examples that arguably represent much of chemical space, which are evidence of classical heuristics scaling to large problems and high accuracy at polynomial cost for fixed $macron(epsilon.alt)$. (If the error scaling is $upright("poly") ( 1 / macron(epsilon.alt) )$ independent of $L$, this further implies $upright("poly") ( L )$ cost overhead to achieve fixed $epsilon.alt$). We note that the calculations below represent only a small slice of relevant evidence from classical calculations; related calculations can be found in the literature, although our focus here is on characterizing the calculations e.g. with respect to cost and precision in a way useful for understanding EQA. Some further discussion of these systems and other calculations relevant to EQA is in SI S2.6.


For "single-reference" chemical problems (see SI S5) coupled cluster (CC) wavefunctions are often described as the gold-standard. The heuristic assumes that correlations of many excitations can be factorized into clusters of fewer excitations; if the maximal cluster excitation level is independent of $L$, the cost is $upright("poly") ( L )$ (assuming a non-exponential number of iterations for solution) without guaranteed error. To establish the error dependence, Figure 3#strong[A] shows the empirical convergence of error as a function of cost, consistent with $upright("poly") ( 1 / epsilon.alt )$ scaling, for a small molecule ($upright("N")_2$). By the extensivity of the coupled cluster wavefunction, this translates to $upright("poly") ( L ) upright("poly") ( 1 / macron(epsilon.alt) )$ cost for a gas of non-interacting $"N"_2$ molecules, and thus $upright("poly") ( L ) upright("poly") ( 1 / epsilon.alt )$ given the error convergence above. We can take this as a conjectured complexity of coupled cluster in single-reference problems. To practically test this scaling form on larger systems, we introduce another heuristic. CC methods can be formulated to exploit locality, a commonly observed and widely conjectured feature of physical ground-states (including gapless systems, see SI S1.4). This yields the local CC heuristic that has cost linear in $L$ in gapped systems~@VRG:riplinger:2016:JCP @yang2014ab. Figure 3#strong[B] illustrates the application of local CC to $n$-alkanes, a set of organic molecules, with the associated computational timing. This suggests the cost is $O ( L )$, while the computed enthalpy of formation per carbon achieves constant error versus~experimental data, reflecting constant $macron(epsilon.alt)$ as a function of $L$, consistent with the conjectured complexity. Many biomolecules are single-reference problems, allowing local coupled cluster methods to be applied to protein-fragment-scale simulations (Figure 3#strong[C]).


// [figvision-cn] imgs/Fig3_lowresolution.png
// 该图包含三个子图（A、B、C），展示了分子体系经典启发式
// 算法的计算复杂度。 子图 A 是一个双对数坐标下的散点连线
// 图，标题为“Computational complexity of classical
// heuristics for molecular systems”的一部分，展示氮分子
// 能量误差随耦合簇（CC）近似级别和计算时间的变化。横轴为
// “Computational effort”，范围从 $10^0$ 到 $10^{10}$，无
// 单位；纵轴为“Energy error / Hartree”，范围从 $10^{-6}$
// 到 $10^{-2}$，单位为哈特里（Hartree）。图中有一条紫色
// 实线连接六个数据点，每个点对应一种 CC 近似方法：从左到
// 右依次为 CCSD、CCSDT、CCSDTQ、CCSDTQP、CCSDTQPH，最后
// 一个点未标注但位于最右下。各点旁有黑色文字标注其对应的
// CC 方法名称。在左下方有一个化学结构简写 “N ≡ N”，表示
// 研究对象为氮气分子。整体趋势显示，随着计算投入增加，能
// 量误差呈指数下降，表明精度提升以计算成本急剧增长为代价。
// 子图 B 是一个主图加内嵌图的复合曲线图，展示最先进的降
// 阶耦合簇（CCSD(T)）实现的成本。主图横轴为“Number of
// carbon atoms (m)”，范围从 20 到 120，单位为碳原子数；
// 纵轴为“Computational time / min”，范围从 0 到 600，单
// 位为分钟。图中有一条蓝色实线连接五个蓝色实心圆点，分别
// 对应 m=20,40,60,80,100,120 时的计算时间，数值约为 35,
// 105, 190, 275, 405, 510 分钟。右下角附有一个聚烯烃链段
// 的化学结构示意图，标记为 “[CH₂–CH₂]_{m-2}”，两端为 CH₃
// 基团，用于说明所研究的分子体系。内嵌图位于主图右上角，
// 横轴为“Number of carbon atoms”，范围 2 到 18；纵轴左侧
// 为“Error in ΔfH⁰ per carbon”，范围 -1.0 到 3.0 kcal/
// mol；右侧无刻度。内嵌图中有一条红色实线连接九个红色实
// 心圆点，表示每碳原子的生成焓误差随碳原子数变化的趋势，
// 误差值稳定在约 0.5–0.8 kcal/mol 之间，略高于零基准线（
// 黑色水平线）。整体传达结论：CCSD(T) 计算时间随碳原子数
// 近似线性增长，而每碳原子能量误差保持相对恒定。 子图 C
// 是一张分子体系的球棍模型显微照片或渲染图，展示一个大型
// 生物大分子复合物。图像中可见多种颜色的原子球体通过棒状
// 键连接构成三维结构：绿色代表碳原子，白色代表氢原子，红
// 色代表氧原子，蓝色代表氮原子，橙色可能代表硫或其他杂原
// 子。结构呈现复杂的折叠与交联形态，具有多个环状和螺旋区
// 域。图像右侧有四行黑色文本标注定量信息：“# of atoms:
// 565”、“# of electrons: 2170”、“# of basis functions:
// 5420”、“Computational time: 70 hours”。这些数字表明该
// 体系包含 565 个原子、2170 个电子、使用 5420 个基函数进
// 行量子化学计算，总耗时 70 小时。此图旨在直观展示大规模
// 分子体系及其对应的计算资源需求，强调实际应用中计算成本
// 的巨大性。
#figure(image("imgs/Fig3_lowresolution.png", width: 85%),
  caption: [
    #strong[Computational complexity of classical heuristics for molecular systems.] #strong[A,] Energy error of a nitrogen molecule (equilibrium geometry) as a function of the level of CC approximation, against a computational time metric. Data taken from Ref.~@chan2004state, time metric defined in SI S2.7. The observed precision cost is like $upright("poly") ( 1 / epsilon.alt )$. #strong[B,] Cost of a state-of-the-art reduced-scaling coupled cluster (CCSD(T)) implementation scales nearly-linearly with the system size in gapped systems, as demonstrated here for $n$-alkanes (C$""_m$H$""_(2 m + 2)$) with with $m = [ 20 dots.h 120 ]$. Size-extensivity of the coupled-cluster ansatz ensures constant error per system subunit, as illustrated in the subfigure for the error of explicitly-correlated reduced-scaling CCSD(T)@VRG:kumar:2020:JCP (see SI S5.1 for details) with respect to the available experimental gas-phase enthalpy of formation in the standard state for $n$-alkanes with $m = [ 2 dots.h 20 ]$. #strong[C,] Reduced-scaling CCSD(T) implementations can be routinely applied to systems with thousands of electrons on a few computer cores, as demonstrated here for a small fragment of photosystem II. @VRG:muh:2013:PR
  ]
)
<fig:lccsd>



// [figvision-cn] imgs/Fig4_lowresolution.png
// 图A展示三维海森堡立方模型中张量网络（PEPS）的相对能量
// 误差与系统尺寸的关系，以及计算时间与站点数的关系。上半
// 部分为曲线图：横坐标为“Number of sites (L)”，对数刻度，
// 范围从约30到1000；纵坐标为“Relative energy error (ε̄)”，
// 线性刻度，范围0.0至0.05。图中仅一条紫色实线连接五个数
// 据点，每个点对应一个系统尺寸标注：L=3³、4³、6³、8³、10
// ³，各点旁配有对应尺寸的三维立方晶格示意图（由小圆圈和
// 连线构成），随L增大网格密度增加。趋势显示相对能量误差
// 随站点数增加而缓慢下降，从L≈27时的约0.014降至L=1000时
// 的约0.003。下半部分为另一曲线图：横坐标同上，“Number
// of sites (L)”；纵坐标为“Total time per site / second”，
// 对数刻度，范围10⁰至10²。三条曲线分别代表不同键维D值：
// 紫色线（D=2）、绿色线（D=3）、橙色线（D=4），均带实心
// 圆点标记。所有曲线呈近似线性增长趋势（在对数-对数坐标
// 系中斜率接近1），表明单位站点计算时间随系统规模近线性
// 增长。D越大，耗时越高，例如在L=1000处，D=4时约为50秒/
// 站点，D=2时约为1.5秒/站点。 图B包含两个子图，均为相对
// 能量误差随PEPS键维D变化的曲线图，用于比较不同掺杂条件
// 下的收敛行为。左上子图标题为“L=4×4 at half-filling”，
// 横坐标为“PEPS bond dimension (D)”，线性刻度，范围4至10；
// 纵坐标为“Relative energy error (ε̄)”，对数刻度，范围10
// ⁻³至10⁻¹。图中一条紫色实线连接四个数据点（D=4,6,8,10），
// 误差从D=4时的约4.5×10⁻²单调递减至D=10时的约2.5×10⁻³。
// 图中嵌入一个4×4二维方格晶格示意图（黑点表示站点，灰线
// 表示连接）。右下子图标题为“at 1/8 doping”，横坐标同为“
// PEPS bond dimension (D)”，范围3至14；纵坐标“Relative
// energy error (ε̄)”，对数刻度，范围10⁻²至10⁰。三条曲线
// 分别对应三种系统尺寸：紫色线（L=4×4）、绿色线（L=8×4）、
// 橙色线（L=16×4），每条线旁附有其对应的二维矩形晶格示意
// 图（站点数分别为16、32、64）。所有曲线均随D增大而下降，
// 但下降速率不同：L=4×4在D=9后趋于平缓，L=16×4则持续下降
// 至D=14时达约1.5×10⁻²。整体趋势表明，在有限掺杂下，增大
// 键维可显著降低能量误差，且大系统需要更高键维才能达到相
// 同精度。
#figure(image("imgs/Fig4_lowresolution.png", width: 85%),
  caption: [
    #strong[Computational complexity of classical heuristics for models of strongly correlated material systems.] #strong[A,] Relative energy error of a tensor network (PEPS) with respect to system sizes $3^3$ to $10^3$ for the 3D Heisenberg cube model with a bond dimension ($D$) of 4. In bottom panel: total computational time in seconds, divided by number of sites, as a function of system size, demonstrating $upright("poly") ( L )$ (close to linear) computational effort. #strong[B,] Energy convergence of PEPS with respect to the bond dimension for 2D Hubbard models at half filling ($4 times 4$ lattice, in top panel) and the challenging 1/8 doping point ($4 times 4$, $8 times 4$ and $16 times 4$ lattice, in bottom panel). The plots are consistent with $1 / macron(epsilon.alt) tilde upright("poly") ( D )$ with a weak dependence on $L$.
  ]
)
<fig:tns>



Strongly correlated materials (e.g.~bulk analogs of the Fe-S clusters) remain challenging to treat with ab initio quantum chemistry (although there has been considerable progress in recent years~@motta2017towards @cui2021systematic). To obtain insight into the computational complexity, it is more practical to study simpler models of correlated materials (e.g.~the Heisenberg and Hubbard models, often used to study quantum magnets and high temperature superconductors~@arovas2021hubbard @zheng2017stripe). Many methods can now access large parts of these model phase diagrams to reasonable accuracy without $exp ( L )$ cost. The use of locality is common to several heuristics for strongly correlated problems; tensor networks are an example of such a class of heuristics and we examine illustrative applications below. (Note that this is not an exhaustive study of tensor networks, nor of other heuristics (such as quantum embedding); for additional discussion see SI S2.6).


Figure 4 shows results from a tensor network ansatz~@orus2019tensor, where the expressiveness of the ansatz is controlled by the bond dimension $D$. The contraction here is explicitly performed with $upright("poly") ( D )$ (typically a high polynomial) cost, thus for given $D$ (assuming the number of iterations is not exponential in $D$ or $L$ (see SI S6)), the algorithm cost is $upright("poly") ( L ) upright("poly") ( D )$, without guaranteed error. $macron(epsilon.alt)$ and computational cost are shown as a function of $L$ in the 3D cubic Heisenberg model, and $macron(epsilon.alt)$ as a function of $D$ and $L$ in the 2D Hubbard model. (Note: these examples were chosen for ease of generating exact data, rather than representing the limits of classical methods in size, accuracy, or complexity of physics; see SI S2.6 for other examples). Figure 4#strong[A] shows that the cost is close to $O ( L )$ in the 3D Heisenberg model for up to 1000 sites, while achieving close to constant $macron(epsilon.alt)$. Less data is available for the error scaling as accessible $D$ remain small; in particular it is currently too expensive to reach large enough $D$ to meaningfully study the $macron(epsilon.alt)$ scaling in 3D. However in the 2D Hubbard model (Figure 4#strong[B]) we see $macron(epsilon.alt) tilde 1 / upright("poly") ( D )$ (or slightly better) across a range of studied $D$, (with a weak dependence on $L$) even at the challenging 1/8 doped point of the model. Assuming this error form holds asymptotically, the observed empirical cost is $upright("poly") ( L ) upright("poly") ( D ) upright("poly") ( 1 / macron(epsilon.alt) )$, which corresponds to $upright("poly") ( L ) upright("poly") ( D ) upright("poly") ( 1 / epsilon.alt )$ for the assumed error scaling, and we can conjecture that this holds also in 3D.


Although the Hubbard and Heisenberg models are believed to contain the basic physics of many strongly correlated materials, moving from such simplified models to more detailed quantum chemistry models (i.e. #emph[ab initio] Hamiltonians) will certainly increase complexity. But establishing EQA requires evidence that adding the polynomial number of terms in the Hamiltonian causes the classical heuristic to fail or become exponentially expensive. The history of development of classical heuristics does not support this, as methods originally developed on simpler models routinely graduate to #emph[ab initio] simulations. For example, the coupled cluster methods described above were first developed for use in model simulations, as were simpler tensor networks such as the density matrix renormalization group and tree tensor networks now used in #emph[ab initio] calculations~@white1999ab @nakatani2013efficient @mayhall2017using\; SI S2.6 provides more discussion of this point as well as shows the performance of a quantum embedding heuristic for the 2D and 3D hydrogen lattices, #emph[ab initio] analogs of the 2D Hubbard and 3D Heisenberg systems in Figure 4. Further examples in the literature consider the application of many different classical heuristics to ab initio or model chemical ground-states of complex systems including strongly correlated materials~@motta2017towards @cui2021systematic @li2019electronic2 @williams2020direct @yang2014ab @VRG:kumar:2020:JCP @brandenburg2019physisorption @zheng2017stripe @qin2020absence. Although the computational complexity is not formally analyzed, the success of such studies of large and complex problems is compatible with the view that the ground-state quantum chemistry problem is often soluble with classical heuristics, to an energy density error $macron(epsilon.alt)$ relevant to physical problems, with $upright("poly") ( L )$ cost. Thus, while there are many chemistry problems that cannot currently be addressed by classical methods and further study can be expected, the barrier to solution may be of polynomial (even if impractically large) rather than exponential cost.


= Conclusions
<conclusions>
We have examined the case for the exponential quantum advantage (EQA) hypothesis for the central task of ground-state determination in quantum chemistry. The specific version of EQA that we examined required quantum state preparation to be exponentially easy compared to classical heuristics, and for classical heuristics to be exponentially hard. Our numerical simulations highlight that heuristics are necessary to achieve efficient quantum ground-state preparation. At the same time, we do not find evidence for the exponential scaling of classical heuristics in a set of relevant problems. The latter suggests that quantum state preparation can be made efficient for the same problems. However, as EQA is based on the ratio of costs, this does not lead to EQA.


Numerical calculations are not mathematical proof of asymptotics with respect to size and error, nor can we exclude EQA in specific problems. However, our results suggest that without new and fundamental insights, there may be a lack of generic EQA in this task. Identifying a relevant quantum chemical system with strong evidence of EQA remains an open question.


We did not consider tasks other than ground-state determination, nor do we rule out polynomial speedups. Depending on the precise form, polynomial quantum speedups could be associated with useful quantum advantage, as even a polynomial classical algorithm does not mean that solutions can be obtained in a practical time. Both aspects may prove important in the further development of quantum algorithms in quantum chemistry. For further discussion, we refer to the FAQ (see Sec.~#ref(<sec:FAQ>, supplement: none)).


= Acknowledgement
<acknowledgement>
Work by SL, HZ, GKC was funded by the US Department of Energy, Office of Science, via Award DE-SC0019374. Work by PH was funded by the Simons Collaboration on the Many-Electron Problem, and support from the Simons Investigator Award to GKC. Work by ZC was funded by the US Department of Energy, Office of Science, via Award DE-SC0019390. Work by JP was funded by the US Department of Energy, Office of Science, via Awards DE-NA0003525, DE-SC0020290, and by the National Science Foundation via Award PHY-1733907. Work by YT was funded by the US Department of Energy, Office of Science via Award DE-SC0017867. Work by LL was funded by the National Science Foundation via Award OMA-2016245, and by the Simons Investigator Award. Research by AK and EV was funded by the US Department of Energy, Office of Science, via Award DE-SC0019374, and the associated software development efforts were supported by the US National Science Foundation via Award OAC-1550456. Some of the discussions and collaboration for this project occurred while using facilities at the Kavli Institute for Theoretical Physics, supported in part by the National Science Foundation under Grant No. NSF PHY-1748958. RB thanks members of the Google Quantum AI team for helpful feedback on earlier drafts.


= Frequently asked questions (FAQ)
<sec:FAQ>
+ #emph[Are there any published papers which suggest exponential quantum advantage for ground-state quantum chemistry?] Statements of this kind can be found in various settings, and range from direct statements of EQA for ground-state problems, to more implicit statements where the expectation of EQA could reasonably be inferred by the reader. Some representative papers and further discussion can be found in Ref.~@EQAQC.

+ #emph[Does this mean that quantum computers are not useful for generic ground-state quantum chemistry?] Even if EQA is not found in the ground-state problem, quantum computers may still be useful for this task, since polynomial advantage (or even large constant factor advantage) can be very useful. In such cases, the details (e.g. degree of polynomial, size of constant) for both the classical heuristic and quantum algorithm are important. It is difficult to tie generic statements about advantage to other characteristics, such as strength of correlation; for example, in more strongly correlated systems, state preparation must be more carefully considered due to possible competing phases. However, in terms of assessing the suitability of ground-state quantum chemistry as an early target application for quantum computers, one should compare the degree of available polynomial advantage in quantum chemistry to that in other applications.

+ #emph[We do not have answers to a certain problem by classical heuristics, and exact classical solution is exponentially expensive, doesn't this mean that there should be EQA?] As our work indicates, this is a subtle question. First, one can definitely construct artificial ground-state problems which, for certain precision requirements, can be solved efficiently quantumly but not classically. See e.g. SI S1.3 as well as Refs.~@gharibian2021dequantizing @cade2022complexity. The open question there is whether such problems are related to the generic molecules and materials studied in quantum chemistry. Second, there are relevant chemical problems which are too large to treat with current classical heuristics with the desired precision. However, for EQA, one must establish that e.g. to reach the desired precision, the classical heuristic requires exponential effort as a function of system size, and also that quantum algorithms are capable of reaching the desired precision without exponential effort.

+ #emph[What about potential improvements to quantum algorithms?] We cannot anticipate future improvements to quantum algorithms, for example, in the area of quantum heuristics. However, to change the situation regarding EQA it is critical for an improvement to change the ratio of the quantum to classical costs. For example, when introducing locality into a quantum heuristic, we should understand whether classical heuristics that also use locality are efficient for the same problems.

+ #emph[What about other classes of problems such as quantum dynamics for chemical systems?] We cannot conclude anything about other simulation tasks based on this work. However, we note that other tasks, such as the simulation of chemical dynamics, may also be amenable to heuristics because of the particular chemical setting and question of interest; for example, dynamics of heavier atoms can often be treated classically, or certain phenomena may take place with strong dissipation. Thus heuristics should always be carefully considered in claims of EQA and other types of quantum advantage.

#show bibliography: set par(spacing: 1.95em)
#bibliography("refs.bib", style: "../../typst-refs/aps-numeric.csl", title: [References and Notes])

// ---- Supplementary Information ----
// The SI ships only as a compiled PDF in the arXiv source (arXiv_SI.pdf, included
// there with \includepdf). Its 53 pages are embedded here as vector PDF pages so the
// rendered output reproduces the original combined manuscript page for page while
// keeping the SI text selectable.
#set page(margin: 0pt, numbering: none)
#set par(first-line-indent: 0em)
#for i in range(1, 54) {
  page(image("src/figure/figs_for_manuscript/initial_submission/arXiv_SI.pdf", page: i, width: 100%, height: 100%))
}
