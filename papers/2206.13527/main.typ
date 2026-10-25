// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.88cm, bottom: 2.15cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: (..n) => {
  let p = n.pos()
  if p.len() == 1 { numbering("I.", p.at(0)) }
  else if p.len() == 2 { numbering("A.", p.at(1)) }
  else { numbering("1.", p.at(2)) }
})
#set figure(placement: auto)
#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9.5pt)
#set math.equation(numbering: "(1)", supplement: none)


#let appl = state("appl", "")

#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    context [Eq. (#appl.at(e.location())#counter(math.equation).at(e.location()).first())]
  } else if e != none and e.func() == heading {
    context {
      let a = appl.at(e.location())
      let n = counter(heading).at(e.location())
      if a != "" {
        if n.len() == 1 { [Appendix #numbering("A", n.first())] }
        else if n.len() == 2 { [Appendix #numbering("A", n.first()) #str(n.at(1))] }
        else { it }
      } else { it }
    }
  } else { it }
}

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Measurement as a shortcut to long-range entangled quantum matter])   #v(1.2em)
    #text(10.5pt)[Tsung-Cheng Lu#super[1], Leonardo A. Lessa#super[1], Isaac H. Kim#super[3], Timothy H. Hsieh#super[1]]

  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Perimeter Institute for Theoretical Physics, Waterloo, Ontario N2L 2Y5, Canada] \
    #text(9pt)[#super[2] Department of Physics and Astronomy, University of Waterloo, Waterloo, Ontario N2L 3G1, Canada] \
    #text(9pt)[#super[3] Department of Computer Science, University of California, Davis, CA 95616, USA] \
  ]
  #v(1.2em)


  The preparation of long-range entangled states using unitary circuits is limited by Lieb-Robinson bounds, but circuits with projective measurements and feedback ("adaptive circuits") can evade such restrictions. We introduce three classes of local adaptive circuits that enable low-depth preparation of long-range entangled quantum matter characterized by gapped topological orders and conformal field theories (CFTs). The three classes are inspired by distinct physical insights, including tensor-network constructions, multiscale entanglement renormalization ansatz (MERA), and parton constructions. A large class of topological orders, including chiral topological order, can be prepared in constant depth or time, and one-dimensional CFT states and non-abelian topological orders with both solvable and non-solvable groups can be prepared in depth scaling logarithmically with system size. We also build on a recently discovered correspondence between symmetry-protected topological phases and long-range entanglement to derive efficient protocols for preparing symmetry-enriched topological (SET) order and arbitrary CSS (Calderbank-Shor-Steane) codes. Our work illustrates the practical and conceptual versatility of measurement for state preparation.


  // single-column source (revtex reprint/preprint): no #columns wrapper
]
= Introduction
<introduction>


Long-range entangled (LRE) and short-range entangled (SRE) states belong to distinct quantum phases as they cannot be connected using finite-depth unitary circuits. Intriguingly, this dichotomy can vanish if one allows for non-unitary evolution incorporating measurements. This is illustrated by the constant-time preparation of Greenberger-Horne-Zeilinger (GHZ) cat states @Raussendorf_2001_ghz as well as toric code ground states @3d_cluster_state_2005 @cirac_2008_optical @cirac_2021_locc via certain measurement protocols. More recently, it was found that performing measurements on SRE states in certain symmetry-protected-topological (SPT) phases @spt_1d_2011 @spt_2011 can lead to a large class of LRE states in topologically ordered phases @ashvin_2021_measurement @verresen2021_measurement_cold_atom. All these findings suggest that, in contrast to the conventional understanding that measurement simply disentangles quantum particles, performing measurement can in fact serve as a powerful tool for efficiently preparing LRE quantum matter.


It is of great interest to explore the utility and limitations of measurements in quantum many-body systems from various perspectives. First, certain LRE systems with topological order are ideal platforms for realizing topological quantum computation @kitaev2003fault, which allows for robust information storage and operations immune to local noise. It is, therefore, desirable to develop a scheme that can realize these LRE systems efficiently, and this endeavor is timely as mid-circuit measurements are now a capability in several experimental platforms~@Chen2021 @Ryan-Anderson2021. Second, measurements can potentially lead to novel non-equilibrium states of matter that do not naturally arise from unitary evolution alone. One notable example of recent interest is hybrid quantum circuits @fisher_2018_mit @amos_mit_2019 @nahum_mit_2019, where the interplay between unitary gates and projective measurements can lead to states with fascinating entanglement structures including quantum critical points that cannot be realized in equilibrium. However, a challenge is that such properties are features of pure state trajectories defined by the measurement outcomes, and thus experimentally probing such features generally requires post-selection of the outcomes. This motivates the consideration of adaptive dynamics in which the measurement outcomes are fed forward to inform the choice of subsequent operations; then it is possible that different trajectories can converge and obviate the need for postselection.


// [figvision-cn] imgs/AdaptiveCircuit.png
// 这是一张示意图，描绘了用于制备长程纠缠态的局部自适应量
// 子电路。整个图像在二维平面上展开，左侧有一个垂直向上的
// 黑色箭头，标注为“Time”，表示时间演化方向是从下至上。
// 图像的主体由多条垂直的线条构成，代表量子比特随时间的演
// 化轨迹（世界线）。这些线条分为两种颜色：粗黑线和细灰线。
// 粗黑线代表系统的主要量子比特，细灰线穿插其间，可能代表
// 辅助量子比特或环境自由度。在图像底部，即初始时刻，有一
// 排深绿色的实心圆点，代表系统的初始状态。每个深绿色圆点
// 通过一条黑色的虚线连接到一个位于其上方的浅绿色圆点，这
// 些浅绿色圆点代表辅助副本（ancilla copies）。 从下往上
// 观察电路结构，首先是一层操作。这一层包含多个水平放置的
// 圆角矩形框，它们横跨在相邻的垂直线上。这些矩形框填充为
// 淡蓝色，并带有较深的蓝色边框，代表局部幺正门（local
// unitary gates）。在这一层的右侧末端，还有一个倾斜放置
// 的相同样式的淡蓝色矩形框。 在淡蓝色幺正门层的上方，是
// 另一层操作。这一层包含四个水平放置的灰色正方形框，同样
// 横跨在垂直线上。每个灰色方框内部都有一个黑色的符号，形
// 状类似于一个带有斜杠的半圆弧（测量符号），代表局部测量
// （local measurements）。 在灰色测量层和顶层淡蓝色幺正
// 门层之间，以及各层之间，有多条水平的锯齿状线条（类似弹
// 簧或电阻的符号）连接不同的垂直线，表示不同量子比特之间
// 的相互作用或耦合。 在图像的顶部，所有垂直线的顶端汇聚
// 成一片蓝色的波浪状网格纹理，形象地表示最终生成的长程纠
// 缠态。 在图像的右侧，有一条垂直的、带有双向箭头的粗线，
// 贯穿了整个时间轴的高度。这条线连接到两个水平的锯齿状线
// 条，分别来自下方的测量层和上方的幺正门层。这两个锯齿状
// 线条汇聚后指向一个灰色的矩形屏幕图标，屏幕内画有三个齿
// 轮，象征经典处理器。这表示测量结果被传输到经典处理器进
// 行处理，处理后的信息再反馈给电路的未来部分，体现了“自
// 适应”的特性。 在图像的右下角，写有文字“0000...”，这可
// 能表示经典寄存器的初始状态或某种编码序列。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering): #it.body]
}

#figure(
  image("imgs/AdaptiveCircuit.png", width: 100%),
  caption: [
    A schematic of a local adaptive circuit for preparing a long-range entangled state. The blue boxes and the gray boxes represent local unitary gates and local measurements, respectively. These operations may involve a finite number of ancilla copies (light green) of the system (green), and the measurement outcomes can be classically processed and communicated to every future component of the circuit.
  ],
)<fig:adaptive-circuit>


In this work, we explore the utility of measurements as a versatile tool for constructing various long-range entangled states, including both chiral and non-abelian topological orders as well as 1d gapless critical states characterized by 1+1D conformal field theories. The fast preparation of target states is made possible using "local adaptive quantum circuits", which we define to consist of local unitary gates, local projective measurements, classical information processing, and finite overhead of ancillae, i.e., at most a constant number of copies of the original system (see @fig:adaptive-circuit). The adjective "adaptive" means that the measurement outcomes are recorded as classical data that can be processed and communicated non-locally, and the choice of a local unitary gate after measurements depends on this global classical data.


The target state is thus prepared without needing to post-select on particular measurement outcomes. In this work, we introduce three distinct classes of local adaptive circuits, each of which relies on completely different physical insights and therefore, possesses different merits which we highlight below. We also build on @ashvin_2021_measurement @verresen2021_measurement_cold_atom to derive adaptive circuits preparing symmetry-enriched topological order and arbitrary CSS (Calderbank-Shor-Steane) codes. Each approach is self-contained and can be understood independently.


The first class of adaptive circuits (Sec. #ref(<sec:tensor>, supplement: none)) is inspired by the tensor network construction of quantum states (see e.g. Ref.@cirac_2021_tn_review for a review) and serves as a practical, modular approach for preparing many topologically ordered states in constant depth. After preparing copies of small entangled resource states of constant sizes, performing two-body measurements "glues" these resource states together, forming a long-range entangled many-body state. This construction applies to the abelian topological order of quantum double models @kitaev2003fault, as well as the double semion ground state @wen_string_net2005, which is a twisted quantum double. Notably, it also allows one to prepare a perturbed topologically ordered state that remains in the same phase as a fixed-point wave function. Our protocol is similar in spirit to fusion-based quantum computation @fusion_based_2021 and "quantum legos" @cao_lego_2021. This modular approach involving preparing many small states in parallel is particularly well-suited for photonics and trapped ion platforms.


The second class of adaptive circuits (Sec. #ref(<sec:mera>, supplement: none)) is inspired by "multiscale entanglement renormalization ansatz" (MERA) @vidal_2007_mera @vidal_2008_mera, a framework for real-space renormalization group (RG) transformations where short-distance entanglement is systematically removed. MERA can also be viewed as a $O (log L)$-depth (spatially non-local) unitary circuit that realizes microscopic models of size $L$ by reversing the direction of RG-flow. While the depth of a MERA circuit is relatively low, it requires non-local unitary gates to generate entanglement at various length scales. We introduce a class of local adaptive circuits to implement a MERA circuit, where any non-local gate is realized with local measurements and unitaries. This immediately leads to two notable classes of target states achievable with $O (log L)$-depth local adaptive circuits: (i) gapped topological orders in quantum double models @kitaev2003fault of any finite group and Levin-Wen string-net models @wen_string_net2005 (ii) gapless states characterized by conformal field theories (CFTs). A CFT state of size $L$ in one space dimension exhibits an $O (log L)$ entanglement scaling @wilczek_1994 @kitave_2003_entanglement @vidal_2004_entanglement @calabrese_2004 @cardy_2009_cft, and we show that preparing such a state using any local adaptive circuit requires a depth that at least scales with $O (log L)$. Our proposal, therefore, provides an optimal circuit structure for preparing 1d CFT states.


The third class of adaptive circuits (Sec. #ref(<sec:partons>, supplement: none)) is inspired by parton constructions, an approach widely used to characterize various topological orders (see e.g. @wen2004quantum). Notably, this class of circuits enables the preparation of a chiral non-abelian topological order in finite time. We introduce the circuit in the context of the Kitaev honeycomb model @kitaev_2006, where each qubit is fractionalized into four Majorana partons subject to a local constraint. The model can be mapped to a system of free Majorana fermions coupled to static $ZZ_2$ gauge fields represented by Majorana dimers, and the physical state of the honeycomb model can be obtained by projecting to the physical subspace consistent with the local gauge constraints. In certain parameter regimes, a time-reversal symmetry-breaking perturbation leads to a topological band structure for the Majorana fermions, and after projecting to the physical subspace of the spin model, one obtains the chiral topological order of Ising anyon theory. This parton-based solution motivates the construction of the following adaptive circuit: starting from a tensor product state of the free Majorana fermion state and Majorana dimers arranged on a honeycomb lattice, one can simultaneously measure certain Majorana operators to enforce local gauge constraints, thereby preparing the target chiral topological order. Crucially, the (abelian) $ZZ_2$ gauge structure allows us to enforce the correct gauge constraints by applying a finite-depth quantum circuit, despite the existence of non-abelian topological order. While we only discuss the parton-based adaptive circuit in the context of the Kitaev honeycomb model, we expect broad applicability of this method for preparing various topological phases of matter.


Finally, in Sec. #ref(<sec:disentangling>, supplement: none), we build on recent works @ashvin_2021_measurement @verresen2021_measurement_cold_atom, which point out the emergence of long-range order by measuring certain SRE states with SPT order. We adopt a wave-function perspective in which certain SRE states can be understood as two species of fluctuating topological objects with a non-trivial braiding phase @dwSPT. These topological objects are domain walls of classical models (e.g they can be point-like objects on the boundary of open strings as in 1d Ising model or loop-like objects on the boundary of open membranes as in 2d Ising model). Measuring one species "disentangles" the two species: the measured species is projected to a particular domain-wall product state, and the unmeasured species remains in a superposition of all possible domain-wall configurations, which constitutes long-range order. This wave-function perspective provides the following three advances: (i) It provides a simple physical picture demonstrating that measuring an SPT with $ZZ_2 times ZZ_2$ symmetry leads to a $ZZ_2$ long-range order, a result that has been discussed in Ref.@ashvin_2021_measurement @verresen2021_measurement_cold_atom @erez_2022_duality. (ii) Considering domain walls that result from certain classical models without spatial locality, one can construct a finite-depth adaptive circuit that prepares any CSS code @css_Steane @css_Shor. While it has been known that any CSS code can be obtained by measuring certain SRE states @stace_2016_css, we describe the construction in terms of chain complex, which provides a succinct formalism that is particularly suitable for preparing certain quantum low-density parity-check (LDPC) codes of recent interest (see Ref.@niko_2021_ldpc_review for review and recent progress). (iii) By decorating fluctuating topological objects with lower-dimensional SPTs, one can easily prepare various symmetry-enriched topological (SET) orders @wang_2019_set, where the deconfined anyonic excitations may exhibit a further symmetry fractionalization, as they live on the boundary of SPTs.


= Adaptive circuits via tensor networks
<sec:tensor>
Here we present a class of finite-depth adaptive circuits that prepares a large class of topologically ordered states by exploiting their tensor-network representations. This is applicable to abelian quantum double models @kitaev2003fault and a twisted quantum double -- the double semion model @wen_string_net2005. In addition, the adaptive circuits can also prepare non-fixed-point states with topological order. Below we will illustrate the main idea using the 2d toric code as an example.


== An example: 2d toric code
<an-example-2d-toric-code>
Consider a 2d lattice with every link accommodating a qubit. The 2d toric code Hamiltonian is $- sum_v product_(l mid v in partial l) Z_l - sum_p product_(l mid l in partial p) X_l$, where the first term is a product of four Pauli-Zs acting on links emanating from a given vertex $v$, and the second term is a product of four Pauli-Xs acting on links around the boundary of a plaquette $p$. With periodic boundary conditions for both two spatial directions (i.e. the lattice is defined on a 2-torus), we consider a (un-normalized) ground state as a superposition of all possible loops $cal(C)$, including both the contractible ones and non-contractible ones:

$ |cal(T)⟩ = sum_(cal(C))|cal(C)⟩ . $<eq:toric>

The states $|cal(C)⟩$ form the computational (Pauli-Z) basis of loop configurations, where qubits take the value $1$ (down spin), $0$ (up spin) depending on whether they belong to a loop or not. In other words, the set of states $|cal(C)⟩$ is all possible spin configurations with an even number of down spins around each vertex.


To introduce our protocol, we here provide a short review of the tensor-network construction for the toric code @wen_tnrg_2008 @tn_string_net_wen_2009. To start, one defines a three-leg tensor $g_(i, j)^s$ on every link: $ g_(i j)^s = delta_(s, i) delta_(s, j), $<eq:g_tensor> where $s in (0, 1)$ labels the state of a physical qubit and $i, j in (0, 1)$ correspond to virtual legs. Essentially, $g$ is a projector enforcing that the physical leg and two virtual leg variables take the same value. In addition, on every vertex one defines a four-leg tensor $T_(alpha beta gamma delta)$


$ T_(alpha beta gamma delta) = cases(
 1 upright(" if ") med alpha + beta + gamma + delta = 0 upright(" mod ") 2,
 0 upright(" if ") med alpha + beta + gamma + delta = 1 upright(" mod ") 2 .
) $<eq:T_2dtoric_constraint>


It follows that the toric code ground state can be expressed via the tensors $g$ and $T$ (see #ref(<fig:toric-tn>)a): $|cal(T)⟩ = sum_({ s_l }) upright("tTr") [⊗_v T ⊗_l g^(s_l)]|{ s_l }⟩ $ with tTr denoting a tensor trace that contracts all the virtual degrees of freedom. It is easy to see that such a representation exactly represents the superposition of loops as the $g$ tensor conveys the physical spin to virtual spins and the $T$ tensor enforces the rule that there must be an even number of occupied links emanating from vertices, indicating that any spin configurations must form loops.


// [figvision-cn] imgs/fig_tn.png
// 图 (a) 为张量网络结构示意图。图中包含四个蓝色正方形框，
// 每个框内标有字母 T，代表张量节点。这四个节点呈 2x2 网
// 格排列，分别位于左上、右上、左下、右下位置。每两个相邻
// 的 T 节点之间通过一条黑色直线连接，共四条连接线：上排
// 两节点间水平连接，下排两节点间水平连接，左列两节点间垂
// 直连接，右列两节点间垂直连接。每条连接线上均有一个红色
// 圆形符号，内含字母 g，表示该连接处的相互作用或门操作。
// 从每个 T 节点向外延伸出两条黑色直线：上方和下方节点各
// 向上、向下延伸；左侧和右侧节点各向左、向右延伸，形成开
// 放边界。整体布局对称，展示了一个由四个 T 张量和四个 g
// 相互作用构成的局部张量网络结构。 图 (b) 为量子态制备与
// 测量示意图。图中同样包含四个蓝色正方形框（标有 T），按
// 2x2 网格排列，与图 (a) 相同。每个 T 节点的四个端口（上、
// 下、左、右）均连接一个绿色实心圆点，代表物理量子比特。
// 在相邻 T 节点之间的连接线上，覆盖有半透明粉红色矩形区
// 域，区域内包含两个绿色圆点，表示对这两个量子比特进行联
// 合测量操作。具体而言，上排左右 T 节点间的连线、下排左
// 右 T 节点间的连线、左列上下 T 节点间的连线、右列上下 T
// 节点间的连线，均被粉红色矩形覆盖，表明在这四组相邻量子
// 比特对上执行了测量。所有绿色圆点大小一致，分布于 T 节
// 点四周及连接路径上，无其他文字标注。该图传达的是：首先
// 独立准备多个四量子比特顶点态（每个 T 对应一个顶点态），
// 然后对共享边上的两个量子比特进行联合测量，以构建全局纠
// 缠态。 图 (c) 为一维链式张量网络及其测量结果示意图。图
// 中五个蓝色正方形框（标有 T）沿水平方向线性排列，从左至
// 右依次编号为第1至第5个节点。每个 T 节点上下各连接一个
// 绿色实心圆点，左右则通过黑色直线与其他 T 节点相连（首
// 尾节点仅单侧连接）。在相邻 T 节点之间的连接线上，覆盖
// 有半透明彩色矩形区域：第1-2、第3-4节点间为浅蓝色矩形；
// 第2-3、第4-5节点间为粉红色矩形。每个矩形区域内包含两个
// 绿色圆点，代表参与测量的量子比特对。在每个矩形区域正上
// 方标注 ZZ = ±1，表示对该对量子比特进行 ZZ 算符测量所得
// 本征值：第1-2对为 ZZ = -1，第2-3对为 ZZ = 1，第3-4对为
// ZZ = 1，第4-5对为 ZZ = -1。在每个矩形区域正下方标注 X
// 或 XX，表示对应的 Pauli-X 算符作用模式：第1-2对下方标
// X，第2-3对下方标 XX，第3-4对下方标 XX，第4-5对下方标 X。
// 所有绿色圆点大小统一，分布规律。该图展示了一维链中交替
// 进行的 ZZ 测量及其结果，以及伴随的 X 型稳定子操作，用
// 于验证或构造特定拓扑序态。
#figure(
  image("imgs/fig_tn.png", width: 100%),
  caption: [
    Adaptive circuits via tensor-network representation -- ground state of 2d toric code as an example: (a) Tensor network for toric code constructed from the tensor $g$ (@eq:g_tensor) and tensor $T$ (@eq:T_2dtoric_constraint). (b) One first simultaneously prepares copies of a 4-qubit vertex state, where each vertex state is defined from tensor $T$. Measuring $Z Z$ operators for two spins on the same link with the outcomes $Z Z = 1$ (represented by red rectangles) "fuses" them to a single qubit, thereby exactly preparing the toric code state. (c) Any measurement errors ($Z Z = - 1$, represented by blue rectangles) occur in pairs and can be corrected in parallel by applying string operators of Pauli-Xs that connect them.
  ],
)<fig:toric-tn>


Exploiting this representation, we now introduce the protocol for preparing the toric code ground state from SRE states via measurements. To start, we employ the $T$ tensor to define a state of four spins associated with a vertex, i.e. $|T⟩_v = sum_(alpha, beta, gamma, delta) T_(alpha beta gamma delta)|alpha, beta, gamma, delta⟩$ so that it is a superposition of product states for four spins subjected to the constraint $Z Z Z Z = 1$ (every allowed state must have an even number of strings ($Z = - 1$) meeting at the vertex $v$). $|T⟩_v$ is a stabilizer state specified by the $Z Z Z Z$ stabilizer and three other independent $X X$ stabilizers acting on any two qubits; it is a GHZ state in the $X$-basis. Defining an SRE resource state as $⊗_v|T⟩_v$, i.e. the tensor product of $|T⟩_v$ among all vertices, we measure the two-body $Z Z$ operators for two spins associated with two vertices sharing the same link (see #ref(<fig:toric-tn>)b). When the measurement outcomes are $Z Z = 1$ on all links, measurements effectively "fuse" two spins on the same link to a single spin, in the sense that they must take the same value in the computational basis. Due to the constraint of only even number of strings ($Z = - 1$) on each vertex, the post-measurement state is a superposition of closed strings (i.e. loops), thereby realizing the exact topological order of $ZZ_2$ toric code. Our protocol relies on encoding the hard constraint on each vertex state $|T⟩_v$, and this is in a spirit similar to the construction of classical vertex models, where vertex constraints are enforced and the lattice is tiled with mismatches of bonds that need to be removed (see e.g. Ref.@color_model_castelnovo_2018 Appendix.B for details).


Formally, the post-measurement state is $|psi⟩ = [product_l frac(1 + product_(v in partial l) Z_(l, v), 2)] ⊗_v|T⟩_v, $ where $product_(v in partial l) Z_(l, v)$ is a product of two Pauli-Zs on two spins associated with the two neighboring vertices connected by the link $l$. One can also write down a parent Hamiltonian $H$ for which $|psi⟩$ is a ground state


$ H = - sum_v product_(l mid v in partial l) Z_(l, v) - sum_p product_(l mid l in partial p) X_(l, v) - sum_l product_(v in partial l) Z_(l, v) . $<eq:2dtoric_post_measurement>


Due to the constraint $product_(v in partial l) Z_(l, v) = 1$, the 4-dimensional Hilbert space of two spins on every link is restricted to 2 dimensions, and one can define an effective Pauli-X and Pauli-Z acting on this subspace: $tilde(Z)_l = Z_(l, v) = Z_(l, v')$ and $tilde(X)_l = product_(v in partial l) X_(l, v) = X_(l, v) X_(l, v')$. It follows that in the basis of $tilde(Z)$, the state $|psi⟩$ is a superposition of loop configurations as in @eq:toric.


Upon measurement, we may obtain $Z Z = - 1$ (as opposed to $Z Z = + 1$). We refer to those outcomes as measurement errors. Measurement errors


can be corrected in one time step as follows. First, we notice that the product of all $Z Z$ measurement operators is fixed at one, as it is the product of $Z Z Z Z$ stabilizers for all resource vertex states. This guarantees that the measurement errors ($Z Z = - 1$) must come in pairs. As a result, one can apply (in parallel) string operators of Pauli-Xs that connect pairs of measurement errors (see #ref(<fig:toric-tn>)c), bringing the post-measurement state into the ground state of the Hamiltonian defined in @eq:2dtoric_post_measurement. Physically one can regard the measurement errors as anyon excitations in the $ZZ_2$ topological order. Applying string operators to pair up errors can be understood as annihilating pairs of anyons, thereby giving a toric code ground state.


== More applications
<more-applications>
Here we briefly discuss several classes of models that can be prepared using our tensor network approach. We note that finite-depth adaptive protocols for preparing these states were first introduced in Ref.@ashvin_2021_measurement @verresen2021_measurement_cold_atom, albeit using a completely different approach from ours.


#strong[Topological order away from fixed point] -- As a non-trivial application, the finite-depth local adaptive circuits can realize non-fixed point states with topological order. This relies on the fact that a topological order can persist up to a finite perturbation strength when the perturbation on local tensors respects certain symmetry conditions (so that it can be mapped to local operators in the physical Hilbert space) @wen_tn_symmetry_2010. A simple example is the 2d toric code, where one considers a perturbation that breaks the $X X$ symmetry but preserves the $Z Z Z Z$ symmetry in the $T$ tensor. The $Z Z Z Z$ symmetry imposes the closed string condition so that the resulting tensor-network state remains a superposition of loops. Meanwhile, the perturbation amounts to assigning a non-zero string tension, so that the wave function for each loop configuration decays exponentially with the length of loops. As shown in Ref.@wen_tn_symmetry_2010, the topological order persists up to a finite critical string tension and the transition to a trivial phase is mapped to a thermal partition function of 2d Ising model. Based on such a tensor-network construction, the non-fixed point wave function with topological order can be prepared in constant depth using the local adaptive circuits (see #ref(<appendix:non_fixed_point>, supplement: none) for details).


#strong[Quantum double models] -- The tensor-network-based adaptive circuits allow for a constant-depth preparation for quantum double models of finite abelian group @kitaev2003fault. The scheme is similar to the case of 2d toric code, and one can apply a product of local unitaries to pair up measurement errors, thereby realizing the target states (see #ref(<appendix:qd>, supplement: none) for details). Note that if one enforces the measurement outcomes, one can also prepare a quantum double of any non-abelian group. How and whether it is possible to correct measurement outcomes efficiently for non-abelian quantum double remains an open question of our work.


#strong[Double semion] -- An interesting application is the constant-depth preparation of a twisted $ZZ_2$ topological order @twisted_qd_2013_Wu, i.e., the ground state of double semion model @wen_string_net2005. The state is defined on a honeycomb lattice, and is a superposition of loops weighted by a $plus.minus 1$ sign that depends on the number parity of loops. In #ref(<appendix:ds>, supplement: none), we provide an explicit preparation scheme for double semion by utilizing its exact tensor network representation @wen_tnrg_2008 @tn_string_net_wen_2009.


#strong[Fracton order] -- Finally, we consider the adaptive preparation of fracton topological phases of matter (see Ref.@fracton_review_2019_hermele @you_2020_fracton for review). These are long-range entangled quantum phases that feature fractionalized excitations with restricted mobility and a robust ground state degeneracy with system-size dependency, thereby beyond the scope of conventional topological field theories. Notably, our protocol allows for constant-depth preparation for certain fracton orders. As an illustration, in #ref(<sec:fracton>, supplement: none) we detail the adaptive preparation for the X-cube model @xcube_Chamon_2010 @xcube, a canonical type-I fracton model.


= Adaptive circuits via MERA
<sec:mera>


// [figvision-cn] imgs/MERAFigures.png
// 子图类型：量子线路示意图（电路网络结构图）。 图中展示
// 了一个用于多尺度纠缠重整化（MERA）态制备的自适应局部电
// 路。时间流向从上至下，即电路演化的初始态位于顶部，最终
// 态位于底部。系统由排列在一维晶格上的量子比特组成，每个
// 量子比特由一条垂直的黑线表示。 在顶部第一层，共有8条平
// 行的垂直黑线代表8个初始量子比特。这些量子比特向下延伸，
// 进入一系列门操作。 第二层包含4个浅橙色矩形框，每个框连
// 接两条相邻的输入线，代表双量子比特幺正门（isometries或
// disentanglers）。这4个门将8条输入线映射为4条输出线。
// 第三层包含2个较大的浅蓝色圆角矩形框，每个框连接来自上
// 一层的两个节点，代表更大范围的双量子比特门操作。这两个
// 门将4条输入线进一步压缩为2条输出线。 第四层包含1个更大
// 的浅蓝色圆角矩形框，连接来自上一层的两个节点，将2条输
// 入线合并为1条输出线。该框上方有一条红色短竖线标记其位
// 置，可能指示特定关注点或测量位置。 第五层再次出现一个
// 浅橙色矩形框，连接两条线（其中一条是上一级输出的延续），
// 产生两条输出线。此处右侧新增一条紫色短竖线标记另一关键
// 位置。 第六层包含两个浅蓝色圆角矩形框，分别作用于不同
// 区域，将4条输入线重新展开为6条输出线。 第七层包含三个
// 浅橙色矩形框，作用于相邻线对，将6条输入线扩展为8条输出
// 线。 第八层（最底层）包含八个独立的浅橙色矩形框，每个
// 作用于单条线，最终生成8条输出线，对应于重构后的物理态。
// 所有连接线均为黑色实线，无箭头但隐含自上而下的时序方向。
// 颜色编码如下：浅橙色矩形代表局部等距变换（isometries），
// 浅蓝色圆角矩形代表非局域解纠缠器（disentanglers）或扩
// 展操作；红色和紫色短线为标注标记，分别位于第4层和第5层
// 的关键节点处，可能用于强调误差注入、测量点或变分参数更
// 新位置。 整个电路呈现树状分层结构，体现MERA算法的核心
// 思想：通过逐级粗粒化与细粒化操作，在不同尺度上构建长程
// 纠缠态。尽管图示中仅部分门为非局域（如蓝色框跨越多个原
// 始位点），但说明文字指出此架构可推广至全自适应版本。比
// 例尺未提供，因属抽象电路而非空间图像。无坐标轴、无数值
// 标签，纯拓扑结构示意图。
#figure(scope: "parent", 
  image("imgs/MERAFigures.png", width: 100%),
  caption: [
    MERA state preparation using local adaptive circuits. (a) a MERA circuit for state preparation with isometries $w$ and disentanglers $u$ starting from the product state $⊗_i|0⟩_i$. Time goes from top to bottom and the qubits are arranged horizontally on a 1d lattice. While we present a particular architecture of MERA where only the isometries $w$ are non-local, our adaptive circuits can be straightforwardly generalized to other MERA where both isometries and unitaries are non-local. (b) Local adaptive circuit for implementing the non-local isometry indicated in the left panel. The ancilla chain starts with a series of Bell pairs (wiggly lines). They serve as a resource to teleport the state at site $A$ (in red) to the ancilla site $B'$, which is next to site $B$ (in blue). After applying the local isometry gate between $B$ and $B'$, we teleport the state in $B'$ back to $A$, and the Bell pairs return to their original positions. All isometries in a given layer of MERA can be implemented in this way in parallel.
  ],
)<fig:mera>


Our second class of adaptive circuits realizes a multiscale entanglement renormalization ansatz (MERA) @vidal_2007_mera @vidal_2008_mera using (spatially) #emph[local] unitary gates and local Bell-pair measurements. In contrast, a naive implementation of MERA circuits requires #emph[non-local] unitary gates to generate entanglement at various length scales. Since a MERA can characterize both gapped topological orders and critical states described by a conformal field theory (CFT), both of these classes of states can be prepared in $O (log L)$-depth local adaptive circuits with $L$ being the system size. In particular, the $O (log L)$-depth adaptive MERA circuit is optimal for preparing a 1d critical state with $O (log L)$ entanglement scaling (see #ref(<appendix:entanglement_bound>, supplement: none) for proof).


MERA is a framework for real-space renormalization group (RG) transformations, which systematically remove short-range entanglement at various length scales, thereby extracting the long-distance, universal structure of correlations and entanglement in quantum systems. MERA consists of alternating layers of unitary gates (dubbed disentanglers) and isometries. At each scale, unitary gates $u$ are applied to remove the short-range entanglement, followed by isometries $w$ that perform coarse graining. A schematic of MERA is presented in #ref(<fig:mera>)a, where the RG flows from the bottom (UV) to the top (IR). On the other hand, by reading the structure from top to bottom, one obtains a circuit that prepares a target state. In particular, the isometry $w$ can be regarded as a unitary that takes as input two spins, one of which is in the state $|0⟩$. However, such a circuit requires spatially non-local gates, which obstructs its implementation. Our adaptive protocol overcomes this difficulty with the aid of Bell measurement.


The main insight of our construction relies on quantum teleportation @wootters_1993_teleport. In the simplest setting, one considers three qubits labeled by $A, B, C$. Given an unknown state $|psi⟩ = m_0|0⟩ + m_1|1⟩$ on $A$, one would like to accomplish the task of teleportation, after which C is in the state $|psi⟩$. This is achieved by first preparing a Bell pair $|Psi_00⟩_(B C) = 1 / sqrt(2) (|00⟩_(B C) +|11⟩_(B C))$, followed by a Bell pair measurement on $A, B$. This projects $A B$ to one of the four possible Bell pairs: $|Psi_(alpha beta)⟩_(A B) = (II ⊗ Z^alpha X^beta)|Psi_00⟩_(A B)$ with $alpha, beta in (0, 1)$, and meanwhile, the state in $C$ becomes $Z^alpha X^beta|psi⟩_C$. Finally, applying the unitary correction $(Z^alpha X^beta)^dagger$ on $C$ achieves the desired teleportation.


Employing the above idea, we devise a local adaptive protocol for implementing non-local gates, which are essential for realizing MERA circuits. The protocol in one space dimension is summarized as follows (see also #ref(<fig:mera>)b). We consider a 1d lattice of qubits (physical chain), next to which we append a 1d lattice of ancilla qubits (ancilla chain) that form adjacent Bell pairs. To apply a unitary gate on two distant physical qubits $A$ and $B$, we perform simultaneous non-overlapping Bell measurements to teleport the information encoded in the physical qubit $A$ through the ancilla chain to an ancilla qubit $B'$ next to $B$ in constant time. We apply a desired unitary gate acting on $B$ and $B'$, and then we teleport the state encoded in $B'$ back to the physical qubit $A$. With this, a non-local unitary gate acting on two qubits $A$ and $B$ can be implemented in constant time independent of their separation. Note that the procedure above can be straightforwardly generalized to higher dimensions: given a physical system on a $d$-dim lattice, one can append a $d$-dim ancilla lattice consisting of Bell pairs. The ancilla lattice serves as a portal for teleporting a physical qubit to any qubit in the ancilla lattice in constant time, and therefore, any spatially non-local gate can be implemented analogously.


== Protocol
<sec:mera_protocol>
Now we specialize in the MERA circuits depicted in @fig:mera for preparing states of qubits arranged in a 1d lattice. Note that while the depicted MERA presents a structure where only isometries $w$ are non-local, our adaptive circuits can be easily adapted to other MERA where both unitaries $u$ and isometries $w$ are non-local.


Since any unitary $u$ is local, below we focus on the implementation of non-local isometries $w$. To start, we introduce an ancilla qubit for every qubit in the original system, yielding an ancilla chain attached to the original chain.


We would like to perform an isometry $w$ acting on two distant physical qubits - one labeled by $A$ at lattice coordinates $x = 0$ and one labeled by $B$ at lattice coordinates $x = 2 n + 1$ with $n in ZZ$. For instance, the qubits $A$ and $B$ are colored in red and blue with coordinates $0$ and $2 n + 1$ for $n = 3$ respectively in #ref(<fig:mera>)b. We will teleport the state of the physical qubit $A$ to the ancilla qubit $B'$ next to the physical qubit $B$, i.e. $B'$ has the same coordinate $2 n + 1$ but in the ancilla chain. To this end, one initializes the ancilla qubits of coordinates $x = 0, 1, dots.h, 2 n + 1$ in the tensor product of adjacent Bell pairs $⊗_(i = 0)^n|Psi_(alpha_i beta_i)⟩_(2 i, 2 i + 1)$, where $|Psi_(alpha beta)⟩ = 1 / sqrt(2) (1 ⊗ v_(alpha beta)) (|00⟩ +|11⟩)$ with $v_(alpha beta) = Z^alpha X^beta$ and $alpha, beta in (0, 1)$. We then simultaneously perform non-overlapping Bell measurements acting on (i) a pair of physical qubit $A$ and ancilla qubit $A'$ at coordinate $x = 0$, and (ii) the pairs $(2 i - 1, 2 i)$ for $i = 1, 2, dots.h, n$ in the ancilla chain. It follows that the qubits $A, A'$ are projected to a Bell pair $|Psi_(a_0 b_0)⟩_(A A')$, and the qubit pairs $(2 i - 1, 2 i)$ are projected to $|Psi_(a_i b_i)⟩_(2 i - 1, 2 i)$ for $i = 1, 2, dots.h, n$. At the same time, the state at site $A$ is teleported to site $B'$ up to a unitary correction $v = (product_(i = 0)^n v_(a_i b_i) v_(alpha_i beta_i))^dagger$.


After the above teleportation step, one applies the local isometry gate $w$ on $B'$ and $B$. Finally, we simultaneously measure the pairs of qubits $(2 i, 2 i + 1)$ for $i = 0, dots.h.c, n$ in the ancilla chain. The measurement projects those qubits to Bell pairs $⊗_(i = 0)^n|Psi_(a'_i b'_i)⟩_(2 i, 2 i + 1)$, and the state in $B'$ is teleported back to $A$ up to a unitary correction determined by the outcomes $(a'_i, b'_i)$ in a similar way to the previous teleportation. The procedure above, therefore, realizes a non-local isometry gate in constant time with the ancilla chain as a teleportation route#footnote[While we only detail the implementation of a non-local gate acting on site $0$ and site $2 n + 1$, we note that a non-local gate on any two sites $A$ and $B$ can be implemented analogously since the ancilla spin chain provides a portal to teleport the physical qubit $A$ to an ancilla qubit $B'$ that is $O (1)$ close to $B$.]. Importantly, for each layer consisting of non-local gates, the above teleportation procedures occur in different non-overlapping regions of the ancilla chain. This means that the aforementioned protocol for a single isometry gate can be applied in parallel to all isometry gates at the same time. Therefore, every layer of a MERA circuit is implemented with local unitaries and local measurements in constant time. Below we discuss two non-trivial applications of our adaptive circuit.


== Critical spin chain
<critical-spin-chain>
MERA provides a natural description for gapless spin chains characterized by 1+1D CFTs. While obtaining a MERA in general requires variational optimization over the isometries $w$ and unitaries $u$, it was found that using the wavelet theory, $w$ and $u$ can be constructed analytically for spin models that can be mapped to free-fermions. A notable example is the ground state of a critical quantum Ising chain, where a MERA of bond dimension 2 already well approximates the actual ground state and the scaling dimension of certain operators can even be exactly reproduced @white_2016_wavelet.


Furthermore, expectation values of local observables can be approximated with an error that decays exponentially with the number of layers within a fixed length scale @Haegeman2018. While the exact form of the quantum circuit in @fig:mera is different from the one introduced in Ref.~@Haegeman2018, the two are related to each other up to a local swapping of qubits. Since this is also a two-qubit gate, the circuit in Ref.~@Haegeman2018 can be reproduced by the circuit in @fig:mera up to at most a two-fold increase in the overall depth of the circuit.


== Gapped topological order
<gapped-topological-order>
While our protocol in Sec. #ref(<sec:mera_protocol>, supplement: none) focuses on implementing a MERA circuit in 1d, one can straightforwardly adopt the same idea to implement a 2d MERA circuit by appending a 2d lattice of ancilla qubits in Bell pairs as a portal for teleporting physical qubits. This enables the preparation of quantum doubles of any finite group $G$ in $O (log L)$ depth via their exact MERA construction @vidal_2008_mera_to. Remarkably, while previously known low-depth preparations for quantum doubles in adaptive circuits are limited to solvable non-abelian groups @ashvin_2021_measurement @verresen2021_measurement_cold_atom @bravyi_2022_adaptive, the group $G$ in our protocol can be any finite non-abelian group. More generally, this class of adaptive circuits can prepare in log depth any Levin-Wen string-net model @wen_string_net2005 based on its exact MERA construction @vidal_2009_mera_string_net. In these cases, the local Hilbert space corresponds to a $d$-dimensional qudit. By employing the measurement-based teleportation scheme for qudits @wootters_1993_teleport, one can implement any non-local unitary gate using local unitary gates and measurements, thereby allowing us to prepare any quantum double or string-net state in $O (log L)$-depth.


= Adaptive circuits via partons
<sec:partons>
Here we introduce a class of adaptive circuits inspired by parton constructions, a widely-used approach to characterize the emergence of topological order in various spin systems. Notably, this allows us to efficiently prepare a chiral non-abelian topological order. We will introduce this class of circuits in the context of the Kitaev honeycomb model @kitaev_2006, a paradigmatic example that is exactly solvable via parton construction. Consider a honeycomb lattice with qubits on sites and the Hamiltonian $ H = - J_x sum_(upright("x-links")) X_j X_k - J_y sum_(upright("y-links")) Y_j Y_k - J_z sum_(upright("z-links")) Z_j Z_k, $<eq:honeycomb> where $alpha$-links with $alpha = x, y, z$ label links of three different orientations. This model can be solved by fractionalizing each spin on site $j$ into four Majoranas $b_j^x, b_j^y, b_j^z, c_j$: $X_j = i b_j^x c_j$, $Y_j = i b_j^y c_j$, $Z_j = i b_j^z c_j$ subject to the constraint $D_j = b_j^x b_j^y b_j^z c_j = 1$ so that the spin operators satisfy $X_j Y_j Z_j = i$. In terms of these Majorana partons, the Hamiltonian can be written as


// [figvision-cn] imgs/fig_parton.png
// 该图像包含两个并列的示意图，分别标记为(a)和(b)，展示了
// Kitaev蜂窝模型中通过部分子构造实现自适应电路的物理机制。
// 子图(a) 类型：晶格结构示意图。 布局与物体：图中展示了
// 一个由八个节点组成的蜂窝状晶格结构。这些节点排列成上下
// 两排，每排四个，呈交错状。每个节点由一个大的空心圆圈表
// 示，代表晶格位点。在每个大圆圈内部中心位置有一个实心蓝
// 色圆点，代表定义在该位点上的量子比特（qubit）。在每个
// 大圆圈内部的边缘附近，分布着三个实心黑色小圆点，它们大
// 致呈三角形排列，代表从该位点的量子比特分数化产生的马约
// 拉纳费米子。 连接关系：相邻的大圆圈之间通过黑色的直线
// 段连接，代表晶格键或相互作用路径。 标注文字：子图左上
// 方有标签“(a)”。 物理含义：此图描绘了Kitaev蜂窝模型的初
// 始状态。根据描述，每个位点上的量子比特被分解为四个马约
// 拉纳费米子（虽然图中仅画出三个黑点，可能隐含第四个或与
// 背景场有关），且受局部约束限制。哈密顿量被映射为二次型
// 马约拉纳费米子耦合到背景规范场的模型，该规范场由马约拉
// 纳二聚体表示。 子图(b) 类型：带有特定路径高亮的晶格结
// 构示意图。 布局与物体：基础结构与子图(a)完全相同，包含
// 相同的八个位点、内部的蓝色中心点和黑色边缘点。 新增元
// 素与变化： 红色圆圈：在左上方的一个位点和右下方的一个
// 位点上，各有一个红色的细线圆圈将这两个位点圈出，以示强
// 调。 红色路径：一条由三段红色直线段组成的折线路径连接
// 了上述两个被红圈圈出的位点。这条路径并非直接连接，而是
// 经过了中间的两个位点。具体而言，路径从左上角被圈出的位
// 点出发，连接到其右侧相邻位点的一个红色小圆点（位于该位
// 点大圆圈的边缘）；接着垂直向下连接到下方相邻位点的一个
// 红色小圆点；最后向右下延伸连接到右下角被圈出的位点的一
// 个红色小圆点。 红色端点：在上述红色路径经过的三个非起
// 始/终止位点上，路径的终点处标有实心的红色小圆点，这些
// 红点覆盖或替代了原有的黑色小圆点的位置，或者紧邻原有黑
// 点，表示马约拉纳二聚体的形成或特定通道的激活。 标注文
// 字：子图右上方有标签“(b)”。 物理含义：此图展示了物理基
// 态的构建过程或某种特定的激发/关联模式。红色路径和圆圈
// 可能代表了在投影自由费米子基态以获取物理基态的过程中，
// 涉及到的规范场构型或马约拉纳费米子的配对方式（即“
// Majorana dimers”的具体体现），或者是自适应电路中信号传
// 播的路径。它直观地显示了系统如何通过局部的重排（由红色
// 元素指示）来实现全局的物理状态。
#figure(
  image("imgs/fig_parton.png", width: 100%),
  caption: [
    Adaptive circuits via parton construction. (a) Given the Kitaev honeycomb model (@eq:honeycomb) with qubits defined on sites, each qubit is fractionalized into four Majorana fermions subject to local constraints $D_j = b_j^x b_j^y b_j^z c_j = 1$. The Hamiltonian is mapped to a model of quadratic $c$ Majoranas coupled to a background $ZZ_2$ gauge field represented by $b$ Majorana dimers. The physical ground state is obtained by projecting the free-fermion solution into the physical subspace with $D_j = 1$. This motivates the adaptive circuit: preparing a free-fermion ground state, one simultaneously measures $D_j$ operators. The desired ground state of the Kitaev model is obtained when every outcome is $D_j = 1$. (b) Measurement errors ($D_j = - 1$) appear in pairs and can be corrected by applying a string operator (the product of $b$ Majoranas) that connects two errors. Any pattern of errors is corrected in a single time step by simultaneously applying string operators.
  ],
)<fig:parton>


$ H = i/4 sum_(⟨j k⟩) (2 J_(j k) u_(j k)) c_j c_k, $ where $J_(j k) = J_alpha$ and $u_(j k) = i b_j^alpha b_k^alpha$ with $alpha in (x, y, z)$ depending on the orientation of the link $⟨j k⟩$. Importantly, the operators $u_(j k)$ commute with each other and the Hamiltonian $H$, and therefore, the Hilbert space splits into the sectors organized by the eigenvalues $u_(j k) = plus.minus 1$. For each sector, the Hamiltonian is quadratic in $c$ Majoranas, whose ground state can be exactly determined. The sector with the lowest energy is the flux-free subspace where the product of $u_(j k)$ around each plaquette is one. Therefore, one may choose $u_(j k) = 1$ on all links and find the ground state $|psi_0⟩$ of the resulting quadratic $c$-Majorana Hamiltonian. Finally, $|psi_0⟩$ is projected to the physical subspace specified by $D_j = 1$ to obtain the physical ground state of spin Hamiltonian


$ |psi⟩ = product_j frac(1 + D_j, 2)|psi_0⟩ . $<eq:parton>


Using the parton construction, Ref.@kitaev_2006 found two distinct phases depending on the choice of $J_x, J_y, J_z$: gapped phase (A phase) exhibiting a $ZZ_2$ topological order and gapless phase (B phase). Importantly, applying a magnetic field, i.e. a time-reversal symmetry-breaking perturbation, opens a gap in the B phase and leads to a chiral topological order that hosts non-abelian Ising anyons. Specifically, the effective parton Hamiltonian derived from perturbation theory reads $ H_(upright("eff")) = i / 4 sum_(j k) A_(j k) c_j c_k $<eq:c_H> with $A_(j k)$ including both nearest-neighbor and next-nearest-neighbor hopping amplitudes (see Ref.@kitaev_2006 for details). The band structure of $c$ Majorana fermions is described by a $p_x plus.minus i p_y$ superconductor ($plus.minus 1$ sign depends on the direction of the applied magnetic field), which supports gapped fermionic excitations, and crucially, binds an unpaired Majorana mode to each vortex @Read_pwave_2000 @pwave_2001_Ivanov. As a result, by projecting to the physical subspace, the ground state exhibits a gapped, chiral topological order characterized by an Ising anyon theory due to the gapped fermionic excitations and gapped vortex excitations with non-abelian (Majorana) statistics.


The above parton construction immediately suggests a protocol for preparing the Ising-anyon topological order: starting from a free-fermion state consisting of neighboring b-Majorana dimers and the ground state of the c-Majorana hopping Hamiltonian (@eq:c_H), one simultaneously measures the operator $D_j = b_j^x b_j^y b_j^z c_j$ on every vertex. With the measurement outcomes $D_j = 1$ on every vertex, one exactly obtains the state in the form of @eq:parton, thereby exhibiting a non-abelian Ising anyon topological order (see #ref(<fig:parton>)a). One caveat is the following: strictly-local unitary circuits of finite depth cannot prepare c-Majoranas in a p+ip superconducting state due to its non-zero Chern number. On the other hand, being a gapped invertible phase, it can be prepared in finite time via adiabatic evolution. Specifically, given a gapped Hamiltonian $H_A$ whose gapped ground state is a p+ip superconductor, one can find a gapped Hamiltonian $H_B$ whose ground state is a p-ip superconductor. Since they are the inverse of each other, one can adiabatically turn on the interaction $H_(A B)$ to obtain a trivial state without closing the gap in finite time. This in turn implies that starting from a trivial state, one can adiabatically prepare decoupled p+ip and p-ip superconductors in finite time, and then one can take one of them as a resource to implement our aforementioned protocol.


Now we discuss how to correct the measurement outcome from $D_j = - 1$ to $D_j = 1$. We first notice that the product of all measurement operators, i.e. $product_j D_j$, is a conserved quantity solely fixed by the state before measurements (i.e.$|psi_0⟩$). This is because by reshuffling the $b$ Majoranas and expressing them in the conserved quantity $u_(i j)$, one finds $product_j D_j tilde.op product_(⟨i j⟩) u_(i j) product_i c_i$, where $tilde.op$ denotes an equal sign up to a phase, which has been exactly derived in Ref.@loss_2011_honeycomb. Since $product_i c_i$ simply measures the c fermion parity of $|psi_0⟩$, $product_j D_j$ is fixed by the initial state $|psi_0⟩$. Thus, given the initial state $|psi_0⟩$ with $product_j D_j = 1$, measurement errors ($D_j = - 1$) arise in pairs, and one can apply a string operator consisting of b Majoranas to correct a pair of errors (see #ref(<fig:parton>)b). As a result, any measurement errors can be corrected in one step to obtain the desired target state. Note that this is consistent with the fact that the gauge field represented by $b$ Majoranas is abelian (i.e. $ZZ_2$) despite the existence of non-abelian topological order.


We note that a low-depth preparation of chiral Ising topological order via measurements has been proposed in Ref.@ashvin_2021_measurement, which nevertheless differs from our protocol. The protocol in Ref.@ashvin_2021_measurement involves (1) preparing the fermions in a p+ip superconductor (2) adding bosonic spin degrees of freedom followed by a depth-1 unitary circuit that couples bosonic spins and fermions and (3) measuring fermion parity operators, and applying a depth-1 unitary to correct measurement outcomes. Finally, one obtains the chiral Ising topological order for bosonic spins. Conceptually, it can be understood as gauging the fermion parity (equivalently a higher-dimensional Jordan-Wigner transformation or bosonization) for the p+ip superconductor.


In contrast, our protocol only takes (Majorana) fermions as input without involving bosonic spins. This differs from the perspective of gauging fermion parity, in which case bosonic degrees of freedom are needed to minimally couple to fermions. However, measuring fermions projects the fermionic Hilbert space to a subspace which does allow for a bosonic description. Our approach is more akin to the "topological bootstrap" @topbootstrap, involving Kondo coupling between a parton free fermion state and a spin system, which can realize the same topological order as the projected parton state in the spin system. Here, instead of Kondo coupling, the projective measurements play the role of projecting onto an effective spin Hilbert space.


// [figvision-cn] imgs/2d_spt.png
// 该图是一幅示意图，展示了从对称保护拓扑（SPT）序到拓扑
// 序的演化过程。图像在水平方向上分为左右两个主要部分，左
// 侧标题为“SPT order”，右侧标题为“Topological order”。两
// 部分之间有一个指向右方的黑色箭头，箭头上方的文字是“
// Measure spins on sites”，表示通过对格点上的自旋进行测
// 量实现转变。 左侧部分（SPT order）： 顶部给出了SPT态的
// 数学表达式：|SPT⟩ = Σ_{α,β} (-1)^{χ(α,β)} |α, β⟩。 下
// 方是该量子态的图形化展开，由四个具体的图形项通过加号或
// 减号连接而成，末尾有省略号表示级数继续。每个图形项都包
// 含一个相同的背景结构：三条平行的黑色水平线，每条线上均
// 匀分布着若干短小的黑色斜线段，形似梯子。 第一项（左上）：
// 仅显示上述背景结构，前方无符号。 第二项（右上）：背景
// 结构之上，叠加了一个蓝色的弧形线条（拱形），以及一个位
// 于蓝色弧线下方的棕色半透明椭圆区域。椭圆内部有一条红色
// 的虚线横贯其中，虚线上带有若干红色小箭头。该项前无符号。
// 第三项（左下）：结构与第二项相同，但该项前方有一个负号
// “-”。 第四项（右下）：背景结构之上，叠加了两个分离的蓝
// 色弧形线条和一个更长的棕色半透明椭圆区域，区域内同样包
// 含带箭头的红色虚线。该项前无符号。 整体来看，左侧图示
// 描绘了SPT态中不同构型（由蓝色弧线和棕色区域代表）的叠
// 加，且存在正负号的干涉。 右侧部分（Topological order）：
// 顶部给出了转变后态的数学表达式：|ψ⟩ = |α'⟩ ⊗ Σ_{β} (-1
// )^{χ(α',β)} |β⟩。 下方同样是该态的图形化展开，由四个图
// 形项组成，布局与左侧对应。背景结构（黑线与斜线）与左侧
// 完全一致。 第一项（左上）：背景结构之上，只有一个蓝色
// 的弧形线条，没有棕色椭圆区域。该项前无符号。 第二项（
// 右上）：包含一个蓝色弧形线条和一个棕色半透明椭圆区域（
// 内含红色虚线箭头）。该项前无符号。 第三项（左下）：结
// 构与第二项相同，但该项前方有一个负号“-”。 第四项（右下）：
// 包含两个蓝色弧形线条和一个长棕色半透明椭圆区域。该项前
// 无符号。 整体来看，右侧图示描绘了拓扑序态的叠加。与左
// 侧相比，最显著的区别是第一项中缺少了棕色椭圆区域，且数
// 学表达式表明其中一个自由度（|α'⟩）已经解耦。 总结趋势
// 与结论： 该图通过对比左右两侧的图形展开式，直观地展示
// 了在对称性基底下对格点进行测量后，系统的拓扑性质发生了
// 改变。左侧的SPT态表现为两种波动畴壁（由蓝色弧线和棕色
// 区域共同表征）的非平凡编织结构；而经过测量后，系统演化
// 为右侧的拓扑态，其数学形式和图形表现均显示出一种自由度
// 的分离（解缠），即态矢量可以写成直积形式，这反映了从
// SPT序到拓扑序的相变或映射关系。图中的蓝色弧线可能代表
// 某种激发或弦算符，棕色区域代表畴壁或能量密度分布，红色
// 虚线箭头指示畴壁内的某种流或相位积累。
#figure(scope: "parent", 
  image("imgs/2d_spt.png", width: 100%),
  caption: [
    Adaptive circuits from disentangling perspective -- The schematic shows a 2d (SRE) cluster state with a $ZZ_2 times ZZ_2$ SPT order, which is understood as two species of fluctuating domain walls with non-trivial braiding sign structure in the symmetry-charge (Pauli-X) basis. The sites on the boundary of blue open strings form a domain wall of a classical Ising gauge theory, and the loops (defined in dual lattice) on the boundary of red open membranes form a domain wall of a classical Ising theory. The wave functions take the value 1 (-1) corresponding to the even (odd) number of times that blue strings pierce through red membranes. Measuring the spins on sites projects those spins into a specific product state. The unmeasured spins form a superposition of loops in the dual lattice up to a $plus.minus 1$ sign, which can be further removed by applying string operators, leading to a 2d toric code state with $ZZ_2$ topological order.
  ],
)<fig:disentangling>


= Adaptive circuits via disentangling fluctuating domain walls
<sec:disentangling>
Finally, we build on a class of local adaptive circuits in the recent works @ashvin_2021_measurement @verresen2021_measurement_cold_atom, which point out the emergence of long-range order by measuring certain SRE states with SPT order. We will discuss such correspondence using an explicit wave-function picture with a "disentangling" perspective. The central insight is as follows: wavefunctions of certain SRE states can be described by two species of fluctuating domain walls with a non-trivial braiding phase. As a result, measuring one species can disentangle the braiding between two species: the measured species is projected to a trivial product state while the un-measured species remains a wave function of fluctuating domain walls, i.e. a superposition of all domain-wall configurations, thereby exhibiting certain long-range order and entanglement.


The above idea leads to a simple understanding of the emergence of a $ZZ_2$ LRE topological order by measuring an SRE state with SPT order protected by a $ZZ_2 times ZZ_2$ symmetry. While this result has been recently pointed out in Ref.@ashvin_2021_measurement @verresen2021_measurement_cold_atom (see also Ref.@erez_2022_duality), our wavefunction perspective provides an intuitive understanding of the connection between SPT order and topological order via measurements. In addition, our idea immediately shows how to prepare certain symmetry-enriched topological (SET) orders by measuring SRE states. Finally, extending the idea to domain walls without spatial locality within the framework of the chain complex enables the preparation of any CSS code in constant depth, reproducing a result in Ref.@stace_2016_css.


== From SPT to topological order
<from-spt-to-topological-order>


#strong[2d SPT with $ZZ_2 upright(" 0-form") times ZZ_2 upright(" 1-form")$ symmetry] -- Here we consider a 2d cluster state to demonstrate our disentangling approach (see also the application to the 1d SPT cluster state in #ref(<sec:1d_spt>, supplement: none)). While the emergence of long-range order via measurement in this model has been well known @Raussendorf_2001_ghz, our perspective provides a novel insight that allows for straightforward generalization as we will discuss later.


To start, we consider a 2d square lattice with every site and link accommodating a spin. The model Hamiltonian is defined as


$ H_(upright("SPT")) = - sum_v X_v product_(l mid v in partial l) Z_l - sum_l X_l product_(v mid v in partial l) Z_v . $<eq:2d_cluster_spt> The first term is a product of a Pauli-X on the site $v$ and four Pauli-Zs on links emanating from the site, and the second term is the product of a Pauli-X on the link $l$ and two Pauli-Zs on two sites located on the boundary of the link. Assuming periodic boundary conditions, $H_(upright("SPT"))$ can be obtained from a trivial paramagnet $- sum_v X_v - sum_l X_l$ by a finite-depth local unitary $U = product_(⟨v, l⟩) "CZ"_(v, l)$, which is a product of control-Z gates $upright("CZ")$ acting on any two neighboring qubits (one on site and one on link). Correspondingly, applying $U$ to a trivial paramagnet state $⊗_v|+⟩_v ⊗_l|+⟩_l$ with $|+⟩$ labeling a $+ 1$ single-qubit Pauli-X eigenstate leads to the ground state of $H_(upright("SPT"))$:


$ |"SPT"⟩ = product_(⟨v, l⟩) "CZ"_(v, l) ⊗_v|+⟩_v ⊗_l|+⟩_l $


$|upright("SPT")⟩$ exhibits an SPT order protected by a $ZZ_2 times ZZ_2$ symmetry, where the first $ZZ_2$ is a 0-form symmetry acting on all sites, i.e. $product_v X_v$, and the second $ZZ_2$ is a 1-form symmetry acting on links that form deformable 1d closed loops $cal(C)$, i.e. $product_(l in cal(C)) X_l$. $|upright("SPT")⟩$ is a non-trivial SPT as it cannot be transformed to a trivial product state using any finite-depth unitary local circuit that respects the symmetry.


Our perspective begins by expressing the SPT in the Pauli-X basis, i.e. the symmetry-charge basis in which symmetry action is diagonal @zohar_2015_spt @zohar_2016_spt $|alpha, beta⟩ equiv|{ alpha_v }, { beta_l }⟩$ with $alpha_v = plus.minus 1$ corresponding to the $plus.minus 1$ eigenvalue of $X_v$ acting on sites (similarly for $beta_l$ defined on links). We find $|upright("SPT")⟩$ in $X$ basis can be written as (up to a normalization)


$|upright("SPT")⟩ = sum_(alpha, beta)^(') (- 1)^(chi (alpha, beta))|alpha, beta⟩ . $ Here $sum'$ indicates that only those product state bases fulfilling certain constraints are allowed. Specifically, the $ZZ_2$ 0-form symmetry $product_v X_v = 1$ imposes the constraint that the allowed $alpha$ configurations satisfy $product_v alpha_v = 1$, and therefore, the spins with $alpha_v = - 1$ must come in pairs. It is useful to regard $alpha$ as a domain wall of the 2d classical $ZZ_2$ gauge theory


with four Pauli-Zs on links emanating from a vertex as a local term. A domain wall configuration $alpha$ then corresponds to a violation of local terms, which must come in pairs on the boundary of open strings. On the other hand, the $ZZ_2$ 1-form symmetry imposes the constraint $product_(l in cal(C)) beta_l = 1$, implying that $beta$ must be a configuration of closed loops in the "dual" lattice. One can regard $beta$ as a domain wall of the 2d Ising model


with Pauli-Z interactions between neighboring spins on sites. Each domain wall is a closed loop in the dual lattice on the boundary of an open membrane. Importantly, $chi (alpha, beta)$ is the linking number between two species of domain wall configurations, i.e. it counts the number of times that a string pierces through the membrane, see @fig:disentangling.


Given the SPT state above, performing Pauli-X measurements on sites gives the following state


$ |psi⟩ =|alpha'⟩ ⊗ sum_beta^(') (- 1)^(chi (alpha', beta))|beta⟩, $<eq:2dspt_post_measure>

where the measured species is randomly projected to a particular $alpha'$ configuration, and crucially, the un-measured species $beta$ forms a superposition of closed loops in the dual lattice up to signs $(- 1)^(chi (alpha', beta))$. To remove the signs, one needs to find an operator $O$ acting on links such that $O|beta⟩ = (- 1)^(chi (alpha', beta))|beta⟩$. This is achieved by choosing $O$ to be a product of $X$ operators on open strings whose boundary is the domain wall $alpha'$ of the 2d $ZZ_2$ gauge theory. After this sign-removal procedure, one then obtains the exact $ZZ_2$ toric code ground state for spins on links, i.e. $sum'_beta|beta⟩$. Note that the post-measurement state exhibits a $ZZ_2$ topological order even without removing the sign, since the correcting unitary is a finite depth circuit. Without correction, the state can be regarded as an excited state of the toric code, and the anyon excitations live on those vertices with $X_v = - 1$ in the $alpha'$ configuration.


It is also interesting to measure Pauli-Xs on links of $|upright("SPT")⟩$. This projects those spins to a particular Ising domain-wall $beta'$. By further applying membrane operators of Pauli-Xs acting on sites whose boundary is $beta'$, the spins on sites exactly form a many-body cat (GHZ) state $sum'_alpha|alpha⟩ prop (1 + product_v X_v) sum_alpha|alpha⟩ =|arrow.t arrow.t arrow.t dots.h.c⟩ +|arrow.b arrow.b arrow.b dots.h.c⟩$, which exhibits a (spontaneous symmetry breaking) long-range order, i.e. $⟨Z_(v) Z_(v')⟩ = 1$ for any two spins.


#strong[3d SPT with $ZZ_2 times ZZ_2$ 1-form symmetry] -- Another illuminating example is the 3d (SPT) cluster state @3d_cluster_state_2005. Consider a 3d cubic lattice where each link and each plaquette (face) accommodates a qubit, with periodic boundary conditions in all space directions, the model Hamiltonian is $H_(upright("SPT")) = - sum_p X_p product_(l in partial p) Z_l - sum_l X_l product_(p, partial p in.rev l) Z_l$. The first term is a product of Pauli-X on a plaquette and four Pauli-Zs on links around the boundary of the plaquette, and the second term is a product of Pauli-X on a link and four Pauli-Zs on plaquettes adjacent to the link. $H_(upright("SPT"))$ possesses a $ZZ_2$ 1-form $times ZZ_2$ 1-form symmetry. The first symmetry action is generated by $S_c = product_(p, p in partial c) X_p$, a product of $X$s acting on faces belonging to the boundary of a cube, and the second symmetry action is generated by $S_v = product_(l, v in partial l) X_l$, a product of $X$s acting on links emanating from a vertex (i.e. it is the boundary of a cube in the dual lattice). $H_(upright("SPT"))$ can be obtained from a trivial paramagnet $- sum_p X_p - sum_l X_l$ by a depth-1 untiary $U_("CZ") = product_(⟨l, p⟩) "CZ"_(l, p)$, i.e. a product of CZ gates acting on every neighboring two qubits (one defined on a link and one defined on a plaquette). Correspondingly, $H_(upright("SPT"))$ admits a unique gapped ground state $|upright("SPT")⟩ = U_(C Z) ⊗_p|+⟩_p ⊗_l|+⟩_l$. More insightfully, in Pauli-X bases, $|upright("SPT")⟩$ can be written as two species of loop condensates with braiding structure @Chong_2015_loop

$ |upright("SPT")⟩ = sum_(cal(C)_A, cal(C)_B) (- 1)^(chi (cal(C)_A, cal(C)_B))|cal(C)_A, cal(C)_B⟩, $<eq:3d_spt>

where $cal(C)_A$ and $cal(C)_B$ are closed loops in the direct lattice (for spins on links) and the dual lattice (for spins on plaquettes), and $chi (cal(C)_A, cal(C)_B)$ counts the number of times when $cal(C)_A$ braids with $cal(C)_B$. Physically, two types of loop configurations can be regarded as the domain walls of two 3d Ising gauge theories (one defined on a direct lattice with the Hamiltonian $- sum_p product_(l in partial p) Z_l$ and the other one defined on the dual lattice with the Hamiltonian $sum_l product_(p, partial p in.rev l) Z_l$). Since the loops are product states in Pauli-X bases, performing $X$ measurement on one type of spins, say all spins on links, projects them to a product state with a particular $cal(C)'_A$ configuration. On the other hand, the un-measured spins exhibits a $ZZ_2$ topological order as it is the superposition of closed loops in the dual lattice. Specifically, the post-measurement state is


$|psi⟩ =|cal(C)'_A⟩ ⊗ sum_(cal(C)_B) (- 1)^(chi (cal(C)'_A, cal(C)_B))|cal(C)_B⟩ . $ To remove the phase $(- 1)^(chi (cal(C)'_A, cal(C)_B))$, one can apply a product of Pauli-Xs acting on faces of 2d open membranes whose boundary form the domain wall configuration $cal(C)'_A$. Applying the membrane operators leads to $|cal(C)'_A⟩ ⊗ sum_(cal(C)_B)|cal(C)_B⟩$, where the un-measured species forms an exact ground state of the 3d toric code, which exhibits a $ZZ_2$ topological order.


The above disentangling perspective can be summarized as follows. Starting from a classical model in $d$ space dimensions with $p$-form $ZZ_2$ symmetry, there is a corresponding "dual" classical model in the same space dimension with $q$-form $ZZ_2$ symmetry ($q + p = d - 1$). Braiding their domain-wall configurations leads to $|upright("SPT")⟩ = sum'_(alpha, beta) (- 1)^(chi (alpha, beta))|alpha, beta⟩$, a fixed-point SPT protected by a $p$-form $ZZ_2 times q$-form $ZZ_2$ symmetry, where the first and second symmetry acts on the species $A$ and $B$ respectively. It follows that measuring either species gives rise to a $ZZ_2$ long-range (symmetry-breaking or topological) order for the other. For instance, within this framework, there are two choices for constructing two distinct SPTs in $d = 3$ space dimensions. The first choice is $(p, q) = (1, 1)$, and the corresponding SPT is given by two species of fluctuating loops with braiding structure, i.e. @eq:3d_spt. Alternatively, one can adopt the second choice: $(p, q) = (0, 2)$, equivalent to $(p, q) = (2, 0)$, and the SPT is obtained by braiding closed 2d membranes and pairs of point-like objects. In that case, depending on which species we measure, one can obtain either a $Z_2$ spontaneous symmetry breaking order or a $ZZ_2$ topological order of 3d toric code as a membrane condensate.


#strong[Long-range order by measuring non-fixed-point SPT] -- Here we show that even after deforming the fixed-point SPT with a symmetric finite-depth unitary of the form $U_A ⊗ U_B$ with $U_A, U_B$ acting on species $A, B$, measuring one species still leads to a long-range order for the un-measured species.


We start with the following observation: $|upright("SPT")⟩$ protected by a $p$-form $ZZ_2 times q$-form $ZZ_2$ symmetry exhibits maximal entanglement between $A$ and $B$ in their symmetric subspaces. For instance, choosing $|upright("SPT")⟩$ as the ground state of the model defined in @eq:2d_cluster_spt, there are $L^2$ spins defined on sites (species $A$), but the symmetric subspace of $A$ has a dimension $d = 2^(L^2 - 1)$ due to the symmetry restriction $product_v X_v = 1$. On the other hand, there are $2 L^2$ spins defined on links (species $B$), but due to the symmetry restriction $product_(l in cal(C)) X_l = 1$ ($cal(C)$ is any closed loop), the dimension of the symmetric Hilbert space of $B$ is $d = 2^(L^2 - 1)$ as well. A straightforward calculation shows that the entanglement between $A$ and $B$ is $log d = (L^2 - 1) log 2$-- maximal entanglement between $A$ and $B$ in the symmetric subspace. This property implies that for any symmetric unitary $U_A$ acting on $A$, there always exists a symmetric unitary $V_B$ acting on $B$ such that $U_A|upright("SPT")⟩ = V_B|upright("SPT")⟩$ (see #ref(<appendix:spt_push>, supplement: none) for details). Moreover, since $U_A$ is a finite-depth local unitary, so is $V_B$. Therefore, measuring species $A$ via the projector $P_A$ onto the state $|alpha'⟩$ gives $P_A (U_A ⊗ U_B)|upright("SPT")⟩ = P_A U_B V_B|upright("SPT")⟩ =|alpha'⟩ ⊗ U_B V_B sum'_beta (- 1)^(chi (alpha', beta))|beta⟩$ because $P_A U_B V_B = U_B V_B P_A$. Since $U_B V_B$ is a symmetric finite depth circuit, $U_B V_B sum'_beta (- 1)^(chi (alpha', beta))|beta⟩$ is in the same phase as $sum'_beta (- 1)^(chi (alpha', beta))|beta⟩$ and thus exhibits the same long-range order.


== From SPT to SET
<from-spt-to-set>
The disentangling perspective provides a simple way to prepare symmetry-enriched topological (SET) order with constant-depth local adaptive circuits. As discussed in Ref.@mcgreevy_2016_snake, one can decorate the fluctuating loops in @eq:3d_spt with 1d SPTs by introducing extra spins defined on sites of the direct lattice and the dual lattice. This construction leads to the following state


$ |psi_0⟩ = sum_(cal(C)_A, cal(C)_B) (- 1)^(chi (cal(C)_A, cal(C)_B))|cal(C)_A, cal(C)_B⟩ U_(cal(C)_A)|+⟩^(⊗ v) U_(cal(C)_B)|+⟩^(⊗ tilde(v)) $<eq:decorated_spt>

where $U_(cal(C)_A)$ ($U_(cal(C)_B)$) creates a 1d SPT along the loop $cal(C)_A$ ($cal(C)_B$) for the extra spins defined on sites of the direct (dual) lattice labeled by $v$ ($tilde(v)$). Choosing $U_(cal(C)_A) = product_(⟨v, v'⟩ in cal(C)_A) "CZ"_(⟨v, v'⟩)$ creates a 1d SPT with $ZZ_2 times ZZ_2$ symmetry. Specifically, $|psi_0⟩$ can be prepared as follows: starting from @eq:3d_spt, we initiate extra spins in $|+⟩$, i.e. the $+ 1$ eigenstate of Pauli-X. For each link $l$ and its two boundary sites $(v, v')$ in the direct lattice, we consider the unitary gate $u_l = (|+⟩⟨+|)_l ⊗ II_(⟨v, v'⟩) + (|-⟩⟨-|)_l ⊗ "CZ"_(⟨v, v'⟩)$, i.e. a gate that can be obtained by conjugating a $C C Z$ gate with a Hadarmard gate on link $l$. Similarly, one can define $u_(tilde(l))$ acting on a link $tilde(l)$ and its two boundary sites in the dual lattice. Simultaneously applying $u_l$ ($u_(tilde(l))$) on every link in the direct (dual) lattice leads to $|psi_0⟩$ defined in @eq:decorated_spt. Due to the decoration, in addition to two $ZZ_2$ 1-form symmetries, $|psi_0⟩$ also respects two global $ZZ_2$ symmetries acting on sites of the direct (dual) lattice.


Measuring Pauli-X for spins on the links leads to the state $ (|cal(C)'_A⟩ ⊗ U_(cal(C)'_A)|+⟩^(⊗ v)) ⊗ (sum_(cal(C)_B) (- 1)^(chi (cal(C)'_A, cal(C)_B))|cal(C)_B⟩ U_(cal(C)_B)|+⟩^(⊗ tilde(v))) . $


By applying a product of Pauli-Xs to remove the phase factor $(- 1)^(chi (cal(C)'_A, cal(C)_B))$ as discussed in the previous section, one obtains a superposition of loops $cal(C)_B$ in the dual lattice, where each loop is further decorated by a 1d SPT with $ZZ_2 times ZZ_2$ symmetry:


$ |upright("SET")⟩ = sum_(cal(C)_B)|cal(C)_B⟩ ⊗ U_(cal(C)_B)|+⟩^(⊗ tilde(v)) . $


Notably, such a state exhibits an SET order, as (deconfined) anyonic excitations appear in conjunction with boundaries of 1d SPTs, thereby exhibiting a further symmetry fractionalization (see Ref.@mcgreevy_2016_snake for more details).


== Preparing CSS codes within chain complex description
<preparing-css-codes-within-chain-complex-description>
In the above discussion, the SRE states arise by braiding two species of fluctuating domain walls of a local classical model and its dual. In #ref(<appendix:disentangling_css>, supplement: none), we relax the geometric locality by considering the domain walls of $k$-local classical models within the framework of chain complex. This allows us to construct SRE states without spatial locality. By measuring one species of domain walls, one can obtain any CSS code characterized by a chain complex.


= Summary and discussion
<summary-and-discussion>


In this work, we exploit measurement to construct four distinct classes of local adaptive circuits. This allows for a low-depth preparation for various long-range entangled states characterized by gapped topological orders and gapless CFTs. Below we summarize each class of adaptive protocols and present open questions regarding the power of local adaptive circuits.


Our first protocol exploits the tensor network representation of topologically ordered states. By preparing copies of constant-size states, each of which respects a given local symmetry, performing measurement glues these copies into a many-body state with local gauge symmetry, thereby exhibiting certain topological orders. For preparing quantum double models of finite abelian groups, correcting measurement errors can be regarded as annihilating topological defects (i.e. abelian anyons), which can be implemented in constant time. However, anyons in non-abelian quantum double cannot be annihilated via a finite-depth circuit, and it remains to be understood whether the tensor-network-based adaptive protocol can prepare this class of states or not. Nonetheless, for preparing abelian topological orders, this modular assembly is practical for photonic and trapped ion systems.


Our second protocol provides a framework for realizing MERA circuits using local unitaries and measurements. This allows the efficient preparation of 1d gapless critical states characterized by 1+1D conformal field theories in $O (log L)$ depth. Notably, our preparation scheme is optimal since, as we proved, starting from a product state, any depth-$D$ local adaptive circuit can (Lu) #emph[at most] generate entanglement of $O (D|partial A|)$ with $|partial A|$ being the area of a subregion $A$. However, as CFTs in higher space dimensions satisfy an area-law bound of entanglement, it is natural to ask whether there exists a finite-depth adaptive circuit for preparing them. If the answer is negative, is there any fundamental obstruction?


Our third protocol is inspired by parton constructions, where physical degrees of freedom are split into partons subject to certain constraints. This motivates the protocol of first preparing a short-range entangled state of partons, and then performing measurements to enforce the parton constraints, thereby obtaining long-range entangled states. While we only provide a detailed construction for the Kitaev honeycomb model, we expect it can be readily generalized to other parton-inspired adaptive circuits. Moreover, even without correcting measurement outcomes, it would be interesting to explore the possibility of unconventional (disordered) quantum states of matter due to measurement.


Finally, building on @ashvin_2021_measurement @verresen2021_measurement_cold_atom, we consider certain short-range entangled states that describe two species of fluctuating $ZZ_2$ domain walls with non-trivial braiding structures. Performing measurement disentangles the two species; the measured species becomes a trivial product state and the other species forms a state of fluctuating domain walls, hence possessing long-range order. This idea leads to a simple understanding of emergent topological orders and their symmetry-enriched versions by measuring certain SPT fixed-point wave functions. Moreover, we prove that the emergence of topological orders upon measurements is a property shared by certain separable finite-depth symmetric unitary deformations of the fixed-point SPTs. Whether the emergence of topological order via measurement is a universal property of the SPT phase remains an open question.


In general, it is an open question to determine all constraints and bounds for local adaptive circuits, which would shed light on which states can or cannot be prepared efficiently. The Lieb-Robinson bound is clearly violated due to the measurements, but local adaptive circuits have bounded entanglement growth (@appendix:entanglement_bound); are there other restrictions? Recent progress has been made @adaptivebounds toward addressing this question. It is also interesting to compare the power of local adaptive circuits with the power of spatially non-local (but $k$-local) unitary circuits. The two classes certainly overlap (our MERA protocol illustrates this), but generally differ in the depth required to prepare states. For instance, $k$-local circuits can generate volume law entanglement in finite time (while local adaptive circuits cannot), whereas local adaptive circuits can prepare GHZ and other long-range entangled states in finite time (while $k$-local circuits require at least $O (log L)$ depth).


#heading(numbering: none)[Acknowledgments]

We thank Tarun Grover, Yin-Chen He, John McGreevy, Nathanan Tantivasadakarn, Beni Yoshida, Yi-Zhuang You, and Liujun Zou for useful discussions, and Gabriela Secara for assistance with figures. We also thank Ruben Verresen, Nathanan Tantivasadakarn, Ryan Thorngren, Ashvin Vishwanath for email correspondence. IK thanks Sergey Bravyi, Alexander Kliesch, and Robert Koenig for helpful discussions and collaboration on a related work. This work was supported by Perimeter Institute and NSERC. Research at Perimeter Institute is supported in part by the Government of Canada through the Department of Innovation, Science and Economic Development Canada and by the Province of Ontario through the Ministry of Colleges and Universities.


#counter(heading).update((0,))
#bibliography("refs.bib", title: [References])

#set heading(numbering: (..n) => {
  let p = n.pos()
  if p.len() == 1 { numbering("A", p.at(0)) }
  else if p.len() == 2 { numbering("1.", p.at(1)) }
  else { numbering("a.", p.at(2)) }
}, supplement: "Appendix")
#show heading.where(level: 1): it => {
  block(above: 1.4em, below: 0.7em, {
    set text(size: 14pt, weight: "bold")
    context {
      let n = counter(heading).at(it.location())
      [#it.supplement #numbering("A", n.first()): #it.body]
    }
  })
}
#appl.update("A")
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(A" + str(n) + ")")


= Adaptive circuits via tensor-networks
<adaptive-circuits-via-tensor-networks>


==  $ZZ_2$ topological order away from fixed point
<appendix:non_fixed_point>
Here we present the details for preparing non-fixed-point states with $ZZ_2$ topological order, motivated by the tensor-network construction in Ref.@wen_tn_symmetry_2010. Consider the same tensor-network structure as for the toric code (#ref(<fig:toric-tn>)a), one defines a perturbed $T$ tensor: $T (p)_(alpha beta gamma delta) = p^(- (alpha + beta + gamma + delta)) delta_(alpha + beta + gamma + delta, 0)$. Note that the delta function is responsible for the closed-loop condition, where $alpha + beta + gamma + delta$ is defined mod 2. While $p = 1$ gives the exact toric code state, any $p > 1$ imposes a string tension so that the weight of a string segment is reduced by a factor of $p^(- 2)$. The corresponding tensor network state is a superposition of loops with amplitudes decaying exponentially with the length of the loops:


$ |psi_0 (p)⟩ = sum_(cal(C)) p^(-2|cal(C)|)|cal(C)⟩, $<eq:perturbed_toric>

where $|cal(C)|$ is the string length of the closed loop $cal(C)$. The state $|psi_0 (p)⟩$ is a ground state of a frustration-free Hamiltonian (see below for its construction), and it exhibits the $ZZ_2$ topological order up to a finite critical $p_c$. This can be seen from the norm of the un-normalized state $⟨psi_0 (p)|psi_0 (p)⟩ = sum_(cal(C)) p^(-4|cal(C)|)$, which is exactly the thermal partition function of the 2d Ising model using a high-temperature expansion, i.e. $Z tilde.op sum_(cal(C)) tanh(beta)^(|cal(C)|)$. Alternatively, the stability of topological order has been confirmed by numerically computing the topological entanglement entropy @wen_tn_symmetry_2010.


The above tensor-network construction motivates the following local adaptive circuit. First, using the $T (p)$ tensor, we construct a local vertex state of four spins $|T (p)⟩_v = sum_(alpha, beta, gamma, delta) T (p)_(alpha beta gamma delta)|alpha, beta, gamma, delta⟩$. Notice that it can be written as


$ |T (p)⟩_v = p^(- sum^v frac(1 - Z, 2))|T (p = 1)⟩_v, $<eq:perturbed_vertex>

where $sum^v$ denotes a summation over the four spins, and $|T (p = 1)⟩_v$ is a stabilizer state with $Z Z Z Z$ stabilizer and three independent $X X$ stabilizers, say $X_1 X_2, X_2 X_3, X_3 X_4$. For $p > 1$, while $Z Z Z Z$ remains a symmetry, i.e. $Z Z Z Z|T (p)⟩ =|T (p)⟩$, $X X$ is no longer a symmetry. Preparing the vertex state $|T (p)⟩_v$ on every vertex of a 2d square lattice, we perform a two-body $Z Z$ measurement for two spins on the same link, and with the measurement outcome $Z Z = 1$ on every link, one obtains the state $|psi (p)⟩ = [product_l frac(1 + product_(v in partial l) Z_(l, v), 2)] ⊗_v|T (p)⟩_v, $ In the subspace fixed by $Z Z = 1$, one has an effective qubit on every link, and by construction, the effective qubits exactly form the state given by @eq:perturbed_toric, which therefore exhibits a topological order up to $p_c$.


Same as the exact toric code, the measurement error, i.e. $Z Z = - 1$, comes in pairs since the product of all $Z Z$ measurement operators on links is the product of all $Z Z Z Z$ stabilizers of vertex states, thereby a symmetry of the state $⊗_v|T (p)⟩_v$. To correct any two errors, one requires an operator that anticommutes with those two $Z Z$ operators, but meanwhile, acts trivially on $⊗_v|T (p)⟩_v$. It turns out such an operator is a product of $X' = p^Z X = e^(Z log p) X$ along a string that connects two errors (see @fig:perturbed-toric-correction). One caveat is that such a string operator is non-unitary (and also non-hermitian). However, we note that in the subspace fixed by a given set of measurement outcomes, the post-measurement state is equivalent to


// [figvision-cn] imgs/perturbed_toric_correction.png
// 该图为一张量子纠错或拓扑序相关的物理示意图，展示了一维
// 链状结构上非幺正弦算符（non-unitary string operator）
// 的构建方式。图中包含五个相同的蓝色方框节点，每个方框内
// 标有大写字母“T”，代表局部操作单元。这些方框沿水平方向
// 等距排列，形成一条主链。 在每个“T”方框的上下左右四个方
// 向，均连接有一个绿色实心圆点，代表格点上的自由度或测量
// 位点。相邻两个“T”方框之间通过黑色直线相连，并在连线上
// 方标注了ZZ算符的测量结果：从左至右依次为 ZZ = -1、ZZ =
// 1、ZZ = 1、ZZ = -1。这些数值表示相邻格点对之间的泡利
// Z-Z关联测量值。 在每对相邻“T”方框之间的连线上，覆盖有
// 半透明彩色椭圆区域，用于标识被修正的链路及其对应的非幺
// 正操作类型。具体分布如下： 第一个间隔（最左侧）：浅蓝
// 色椭圆，下方标注 x'，表示此处应用单个 onsite 算符 x'。
// 第二个间隔：粉红色椭圆，下方标注 x' x'，表示此处连续应
// 用两个 onsite 算符 x'。 第三个间隔：粉红色椭圆，下方标
// 注 x' x'，同上。 第四个间隔：浅蓝色椭圆，下方标注 x'，
// 表示单个 x' 操作。 所有文字标签均为黑色无衬线字体，位
// 置清晰对应其所指对象。整张图未提供比例尺，因其为抽象示
// 意而非实验图像；颜色映射仅用于区分不同操作模式（蓝 vs
// 粉），不具定量意义。该图传达的核心结论是：针对不同的ZZ
// 测量结果组合（特别是负值与正值交替出现的情况），可通过
// 在相应链路上施加特定数量和类型的onsite算符x'构成的非幺
// 正弦算符来纠正测量误差，从而恢复系统的目标态或稳定子空
// 间。
#figure(
  image("imgs/perturbed_toric_correction.png", width: 100%),
  caption: [
    The measurement outcome $Z Z = - 1$ on two links can be corrected by applying a non-unitary string operator consisting of onsite operator $X' equiv p^Z X$.
  ],
)<fig:perturbed-toric-correction>


$|psi (p)⟩ = e^(sum_l m_l tilde(Z)_l)|cal(T)⟩, $ where $|cal(T)⟩ = sum_(cal(C))|cal(C)⟩$ is the toric code state, $tilde(Z)_l$ is the Pauli-Z operator acting on the effective qubit per link, and $m_l in (- 1, 0, 1)$ is fixed by both (i) the measurement outcomes and (ii) how we define the effective qubits. Specifically, $m_l = 0$ at the location of $- 1$ measurement outcomes (i.e. errors). Since these errors occur in pairs, they correspond to the boundary of open strings $Gamma$, and one assigns $m_l = - 1$ along $Gamma$ except for their boundary. Finally, $m_l$ is $1$ for those links that are neither in the interior of those strings nor at the location of errors. Physically, $m_l = - 1, 0, 1$ corresponds respectively to assigning negative, zero, and positive string tension on the toric code. Since topological order is generically stable in the presence of weak string tension, one expects $|psi (p)⟩$ to be topologically ordered up to a certain $p_c gt.eq 1$.


#strong[Derivation of parent Hamiltonian]: Here we derive a parent Hamiltonian for the state defined in @eq:perturbed_toric using an approach analogous to Ref.@rg_mcgreevy_2016 @topo_scar_2019_chamon. Define the four-body operator around every plaquette $p$: $Q_p = p^(- 2 sum_(l in partial p) Z_l) - product_(l in partial p) X_l$, by writing $|psi_0 (p)⟩ prop p^(sum_l Z_l) sum_(cal(C))|cal(C)⟩$, it is straightforward to see that $product_(l in partial p) X_l|psi_0 (p)⟩ = p^(- 2 sum_(l in partial p) Z_l)|psi_0 (p)⟩$, namely, $Q_p|psi_0 (p)⟩ = 0$. On the other hand, $Q_p$ is a positive semi-definite operator by observing that $ Q_p^2 = Q_p (p^(2 sum_(l in partial p) Z_l) + p^(- 2 sum_(l in partial p) Z_l)) . $ Therefore, $|psi_0 (p)⟩$ lies in the zero-energy subspace of the following Hamiltonian $ sum_p Q_p = sum_p (p^(- 2 sum_(l in partial p) Z_l) - product_(l in partial p) X_l) . $ Since the state $|psi_0 (p)⟩$ satisfies the constraint that four Pauli-Z on links emanating from a vertex $v$ is fixed at one, one can impose it energetically to derive the exact Parent Hamiltonian whose unique ground state of zero energy is $|psi_0 (p)⟩$:


$ H = sum_v (1 - product_(l, partial l in.rev v) Z_l) + sum_p (p^(- 2 sum_(l in partial p) Z_l) - product_(l in partial p) X_l) . $ Notice that while the vertex terms commute with the plaquette term, neighboring plaquette terms do not commute. $H$ is therefore frustration-free but not a commuting-projector Hamiltonian.


== Quantum double models
<appendix:qd>
Here we discuss a local adaptive circuit for preparing quantum double of finite Abelian group $G$. To define a quantum double @kitaev2003fault, we consider an oriented 2d lattice, where spins are defined on links, and the Hilbert space of each spin is spanned by the orthogonal basis states $|g⟩$ with $g$ being the elements in a finite group $G$. Note that reversing the orientation of a link specified by a group element $g$ is equivalent to considering the inverse of $g$:


#align(center, image("imgs/quantum_double_local.png", width: 5cm)) The total Hilbert space is a tensor product of local Hilbert spaces on links. One defines the vertex operators $A_v (h)$ that perform the local gauge transformation and the plaquette operators $B_p$ that enforce the flux-free condition:


#align(center, image("imgs/qd_operator.png", width: 8cm)) Introducing the vertex operator $A_v = 1/|G|sum_(h in G) A_v (h)$, which is a projector to the gauge-invariant subspace, the Hamiltonian of the quantum double is $ H = - sum_v A_v - sum_p B_p, $ which is exactly solvable as all operators commute: $\[ A_v, A_(v') \] = \[ B_p, B_(p') \] = \[ A_v, B_p \] = 0$, and the ground subspace is specified by $A_v = B_p = 1$ for all vertices $v$ and plaquette $p$.


Here we discuss the finite-depth adaptive circuit for preparing a quantum double ground state $|psi⟩$. To start, since the vertex operator $A_v$ is not diagonal in the computational bases $|g⟩$, it is more convenient to consider the dual lattice so that the plaquette operator $B_p$ can be regarded as a vertex operator $tilde(A)_(tilde(v))$, which is diagonal in the computational bases:


#align(center, image("imgs/qd_vertex.png", width: 8.7cm))


In the dual lattice, one defines a local vertex state $|T⟩_(tilde(v)) = tilde(A)_(tilde(v)) sum_(g_1, g_2, g_3, g_4)|g_1, g_2, g_3, g_4⟩ = sum_(g_1, g_2, g_3, g_4) delta_(II, g_1 g_2 g_3 g_4)|g_1, g_2, g_3, g_4⟩$. Taking a tensor product over these vertex states: $⊗_(tilde(v))|T⟩_(tilde(v))$, we perform the two-body forced measurement to fuse the two spins on the same link via the projector $P_l = sum_g|g g⟩⟨ g g|$, giving the post-measurement state


$|psi⟩ = (product_l P_l) ⊗_(tilde(v))|T⟩_(tilde(v)), $ which exhibits the topological order of quantum double.


// [figvision-cn] imgs/qd_projector_correction.png
// 该图像包含两个子图(a)和(b)，均为用于描述量子纠错或拓扑
// 量子计算中算符作用的示意图。 子图(a)： 类型：示意图。
// 布局与物体：图像中心是一条水平黑线，代表一维晶格上的链
// 状结构。这条线上分布着两个正方形框，边框为粗蓝色线条，
// 内部填充为白色。这两个正方形框分别位于水平线的左侧和右
// 侧位置。在每个正方形框的中心，有一条垂直的黑线穿过水平
// 线并向上、向下延伸，形成十字交叉形状。在两个正方形框之
// 间的水平线段上，覆盖着一个淡红色的圆角矩形区域。该区域
// 内有两个黑色的箭头，均指向左方，呈重叠排列。 标注文字：
// 在淡红色圆角矩形的上方，标注有黑色数学符号“P(h)”；在其
// 下方，对应两个箭头的位置，分别标注有小写斜体字母“f”和“
// i”，其中“f”位于左侧箭头下方，“i”位于右侧箭头下方。左上
// 角有标签“(a)”。 物理含义：此图定义了一个双体投影算符 P
// (h)。蓝色方框可能代表晶格中的特定节点或测量点，中间的
// 淡红色区域及其内部的向左箭头表示作用在相邻节点（标记为
// i 和 f）上的算符操作方向或关联。 子图(b)： 类型：示意
// 图。 布局与物体：图像主体是一条更长的水平黑线，上面均
// 匀分布着五个相同的蓝色边框白色填充的正方形框，每个方框
// 同样被一条垂直黑线贯穿。在这些方框之间的间隔区域，依次
// 排列着四个不同颜色的圆角矩形区域，每个区域内都包含两个
// 指向左方的黑色重叠箭头。从左至右，这四个区域的特征如下：
// 第一个区域（最左侧）：背景色为淡蓝色，上方标注为“P(h⁻¹
// )”，下方标注为“S⁻”。 第二个区域：背景色为淡红色，上方
// 标注为“P(Ⅱ)”，下方标注为“S⁻ S⁻”。 第三个区域：背景色为
// 淡红色，上方标注为“P(Ⅱ)”，下方标注为“S⁻ S⁻”。 第四个区
// 域（最右侧）：背景色为淡蓝色，上方标注为“P(h)”，下方标
// 注为“S⁻”。 标注文字：除了上述各区域内的标注外，左上角
// 有标签“(b)”。 物理含义与趋势：此图展示了如何通过一系列
// 弦算符（string operator）来修正不需要的测量结果。图中
// 淡蓝色的区域（对应 P(h⁻¹) 和 P(h)）代表了需要被修正的“
// 不希望出现的测量结果”（根据图注提示，蓝色代表 unwanted
// outcomes）。淡红色的区域（对应 P(Ⅱ)）以及下方的 S⁻ 符
// 号共同构成了用于修正这些错误的弦算符序列。整个图示表明，
// 通过在错误发生的位置插入特定的算符串（由 P(Ⅱ) 和 S⁻ 组
// 成），可以将系统状态从错误路径（蓝色部分所示）引导回正
// 确路径。
#figure(
  image("imgs/qd_projector_correction.png", width: 100%),
  caption: [
    (a) The two-body projector $P (h)$ defined as $P (h) = sum_g (|g⟩⟨ g|)_i ⊗ (|g h⟩⟨ g h|)_f = sum_(g in G)|g, g h⟩⟨ g, g h|$. (b) Unwanted measurement outcomes (colored in blue) can be corrected by a string operator consisting of the product of $S^(-) = S^(-) (h)$.
  ],
)<fig:qd-correction>


// [figvision-cn] imgs/fig_double_semion.png
// 图(a)为张量网络示意图。图像主体由一个六边形晶格结构构
// 成，该结构包含七个完整的六边形单元，呈蜂窝状排列。晶格
// 的顶点（节点）用蓝色实心圆点表示，连接顶点的边（键）中
// 间位置标有红色实心圆点。在图像左侧，有一个独立的符号说
// 明：两条垂直的平行黑线代表量子态或索引，上方标记为α'和
// β'，下方标记为α和β；这两条线被一个红色的圆圈包围，圆圈
// 内有一个字母g，右侧标记为S，整体表示一个特定的算符或变
// 换。从左侧的独立符号引出一条紫色箭头指向晶格左上角的某
// 个键，同时从晶格右上角和右下角的键引出两条紫色箭头指向
// 右侧外部，暗示信息的输入与输出或边界条件。图像右侧展示
// 了两个T型张量的定义图：上方的图显示一个中心标有T的圆圈，
// 伸出三条腿，分别标记为α、β、γ，对应的另一端标记为α'、β
// '、γ'；下方的图类似，但连接方式不同，显示α连接到γ'，β
// 连接到β'，γ连接到α'，描述了张量的具体连接规则。整个子
// 图传达了构建双半子模型所使用的张量网络拓扑结构及基本组
// 成单元。 图(b)为电路操作示意图。图像展示了一个环形的几
// 何布局，由六个标有T的浅蓝色圆圈（代表T门或张量）通过连
// 线组成一个大的六边形环路。在每个T门之间以及内部，分布
// 着多个绿色实心圆点，代表物理量子比特或系统状态。在这些
// 绿色圆点之间，绘制了粉红色的椭圆区域，每个椭圆覆盖两个
// 相邻的绿色圆点，表示对这些两体算符进行测量。此外，图中
// 还有黑色的实线连接各个绿色圆点和T门，表示量子线路的连
// 接关系。顶部有两个向下的黑色短竖线，可能表示初始制备或
// 控制信号。该子图说明了通过准备解耦的顶点态并使用T张量，
// 同时对特定的两体算符（粉红色区域所示）进行测量，当测量
// 结果为特定值时，可以制备出双半子态。 图(c)为误差分析示
// 意图。图像的基本结构与图(b)相同，包括六个T门组成的环形
// 布局和内部的绿色圆点。不同之处在于，除了保留部分粉红色
// 椭圆外，还引入了灰色阴影区域。这些灰色区域覆盖了某些T
// 门及其附近的连接线和绿色圆点，形象地表示了测量错误发生
// 的位置。根据描述，测量错误（记为e，对应图中的某种标记，
// 虽然图中未直接画出e符号，但灰色区域即代表其影响范围）
// 成对出现在内环上。图中还特别用浅蓝色高亮显示了其中一个
// T门及其连接线，可能用于强调受影响的局部电路。该子图旨
// 在说明在实际操作中，测量错误会以成对的形式出现于内环路
// 径上，这对理解系统的容错性或稳定性至关重要。
#figure(scope: "parent", 
  image("imgs/fig_double_semion.png", width: 100%),
  caption: [
    Local adaptive circuits for preparing double semion $|upright("DS")⟩$: (a) Tensor-network representation of $|upright("DS")⟩$ built from the tensors $T$ and $g$ (defined in @eq:ds_T,@eq:ds_g). (b) By preparing decoupled vertex states using $T$ tensor, simultaneously measuring two-body $Z Z$ operators (colored in red) results in the double semion state $|upright("DS")⟩$ when the measurement outcome is $Z Z = 1$. (c) Measurement errors ($Z Z = - 1$, colored in blue) come in pairs on the inner loop of each plaquette. Errors can be corrected by simultaneously applying a product of X-type operators (defined in @eq:ds_tn_operator) that connect them, where each X-type operator (colored in gray) contains two Pauli-Xs acting on the inner loop.
  ],
)<fig:double-semion>


Now we discuss how to correct unwanted measurement outcomes, which is only applicable to quantum double with a finite Abelian group. First, we define a measurement operator $M$ that encodes all measurement outcomes and the corresponding projected subspaces. To this end, we define a projector $P (h) = sum_(g in G)|g, g h⟩⟨ g, g h|$ for $h in G$. One can check that $sum_(h in G) P (h) = 1$. Now one can introduce a set of distinct real numbers ${ lambda_h|h in G }$ for the measurement outcome, and it follows that the measurement (Hermitian) operator can be written as $ M = sum_(h in G) lambda_h P (h) = sum_h lambda_h [sum_(g in G)|g, g h⟩⟨ g, g h|] . $ The desired fusion corresponds to the measurement outcome $lambda_(II)$ with the projector $P = P (II) = sum_g|g g⟩⟨ g g|$. Due to the local gauge constraint on each vertex $tilde(A)_(tilde(v)) = 1$, the unwanted measurement outcome must come in pair with the projectors $P (h)$ and $P (h^(- 1))$. Similar to the 2d toric code, the errors on two links can be corrected by applying a string operator consisting of $S^(-) (h)$ with $S^(-) (h)|g⟩ =|g h^(- 1)⟩$ (see @fig:qd-correction).


== Double semion
<appendix:ds>
We here discuss the preparation for the double semion ground state @wen_string_net2005. Consider a honeycomb lattice with each link accommodating a qubit, the state is a superposition of product states of loops weighted by a sign that depends on the number of loops in $cal(C)$: $|upright("DS")⟩ = sum_(cal(C)) (- 1)^(N_(cal(C)))|cal(C)⟩$. $|upright("DS")⟩$ admits an exact tensor-network representations @wen_tnrg_2008 @tn_string_net_wen_2009 (see #ref(<fig:double-semion>)a):


$|upright("DS")⟩ = sum_({ s_i }) upright("tTr") [⊗_v T ⊗_l g^(s_i)]|{ s_i }⟩ $ where one defines the 6-leg tensor $T$ on vertices and the 5-leg tensor $g$ on links as follows:


$ & T_(alpha alpha' beta beta' gamma gamma') = T_(alpha beta gamma)^0 delta_(alpha alpha') delta_(beta beta') delta_(gamma gamma') \
 & T_(alpha beta gamma)^0 = cases(
 1 & "if" alpha + beta + gamma = 0 "or" 3,
 i & "if" alpha + beta + gamma = 1,
 -i & "if" alpha + beta + gamma = 2,
) $<eq:ds_T> and $ g_(alpha beta alpha' beta')^s = delta_(s, alpha + beta) delta_(alpha alpha') delta_(beta beta') . $<eq:ds_g> Essentially, every link has a structure of double lines, each of which is associated with a virtual qubit. The physical qubit on a link takes the value 0/1 when the two virtual qubits take the same/opposite value. In addition, since all the virtual qubits on a line surrounding a hexagon take the same value, one may view those virtual qubits as an Ising spin located at the center of a hexagon, and the physical qubit on a link simply measures the domain wall between two Ising spins belonging to two neighboring hexagons. On the other hand, the non-trivial phase from $T_(alpha beta gamma)^0$ provides the correct sign associated with each loop configuration in the double semion state.


The above tensor-network construction motivates the following adaptive circuit. For each vertex, we employ the $T$ tensor to define a vertex state of 6 physical spins: $|T⟩_v = sum_(alpha, alpha', beta, beta', gamma, gamma') T_(alpha alpha' beta beta' gamma gamma')|alpha, alpha', beta, beta', gamma, gamma'⟩, $ where we note that $|T⟩_v$ is the common eigenstate with eigenvalue $1$ for the following six (mutually commuting) operators $ & (Z_alpha Z_(alpha'), Z_beta Z_(beta'), Z_gamma Z_(gamma'), \
 & sqrt(Z_alpha Z_beta Z_gamma) X_alpha X_(alpha') sqrt(Z_alpha) Z_alpha Z_beta Z_gamma, \
 & sqrt(Z_alpha Z_beta Z_gamma) X_beta X_(beta') sqrt(Z_beta) Z_alpha Z_beta Z_gamma, \
 & sqrt(Z_alpha Z_beta Z_gamma) X_gamma X_(gamma') sqrt(Z_gamma) Z_alpha Z_beta Z_gamma) $<eq:ds_tn_operator> As we will soon discuss, identifying these operators is crucial for correcting measurement errors. Taking a tensor product of the vertex states gives $|psi_0⟩ = ⊗_v|T⟩_v$, where there are four spins on each link. We measure $Z Z$ operators of two spins on the same side of the double line (see #ref(<fig:double-semion>)b), and with the outcomes $Z Z = 1$ for all measurements, one obtains the state $|psi⟩ = [product_l frac(1 + Z Z, 2) frac(1 + Z Z, 2)] ⊗_v|T⟩_v . $ In the subspace fixed by $Z Z = 1$, the effective local Hilbert space on each link is 4 dimensional, corresponding to two effective qubits (one qubit on each side of a link). As in the tensor-network construction where a physical spin reflects a domain wall between two virtual spins located on two sides of a link, $|psi⟩$ exhibits the $ZZ_2$ double semion order which is encoded in the domain-wall variables from two effective qubits on links.


Any measurement errors ($Z Z = - 1$) can be corrected via a depth-1 local unitary circuit. To start, since the product of all $Z Z$ measurement operators around each inner plaquette loop is fixed at one, the measurement errors come in pairs. This suggests that these errors can be corrected by applying a string operator $S$ as in the case for 2d toric code. Such a string operator $S$ must anticommute with the $Z Z$ operators where $- 1$ outcome occurs, while acts trivially on the tensor product state $⊗_v|T⟩_v$, i.e. $S ⊗_v|T⟩_v = ⊗_v|T⟩_v$. As a result, $S$ is a product of X-type operators (i.e. those operators involving Pauli-Xs in @eq:ds_tn_operator) along a path that connects two errors (see #ref(<fig:double-semion>)c).


== X-cube fracton order
<sec:fracton>


// [figvision-cn] imgs/fig_fracton.png
// 子图(a)为示意图，展示了三维立方晶格上单个顶点的量子态
// 结构。左侧显示一个三维直角坐标系，横轴标记为x，纵轴标
// 记为y，垂直纸面向下偏左的轴标记为z。右侧展示了一个顶点
// 态的数学表达式和几何结构：公式写作|T⟩_v = x̄·T·ȳ·z̄，
// 其中T是一个浅蓝色圆圈，代表中心顶点；从圆心向六个方向
// （±x, ±y, ±z）延伸出六条黑色直线段，每条线段末端连接一
// 个绿色实心圆点，分别对应坐标轴正负方向上的相邻格点。标
// 注文字包括：在+x方向旁标有“x”，-x方向旁标有“x̄”；+y方
// 向旁标有“y”，-y方向旁标有“ȳ”；+z方向旁标有“z̄”，-z方向
// 旁标有“z”。该子图说明每个顶点初始化包含6个量子比特（位
// 于六个邻接边上），并定义了两体算符测量的作用对象——即同
// 一边上的两个量子比特。 子图(b)为线性排列的示意图，描绘
// 一维链状结构中测量误差及其校正过程。图中沿水平方向依次
// 排列四个浅蓝色圆圈，每个圆圈内写有字母“T”，代表四个连
// 续顶点。每个顶点周围辐射出六个绿色实心圆点（上下左右及
// 前后方向，但仅部分可见）。相邻顶点之间通过一条黑色直线
// 连接，线上放置两个绿色圆点表示共享边上的两个量子比特。
// 在这些连接边上叠加了两种矩形框：浅蓝色半透明矩形框覆盖
// 某些边，其上方标注字母“X”，表示实际测量结果与期望不符
// （错误）；红色半透明矩形框覆盖另一些边，同样标注“XX”，
// 表示经过校正后的理想测量结果。具体布局从左至右：第一个
// 顶点到第二个顶点间有一条带蓝色框和单“X”的边；第二个到
// 第三个顶点间有一条带红色框和双“X”的边；第三个到第四个
// 顶点间又有一条带蓝色框和单“X”的边。该子图传达的趋势是：
// 通过识别蓝色区域（错误）并应用相应操作（如施加X门或翻
// 转测量基），可将其转换为红色区域（正确），从而恢复系统
// 至目标基态。 子图(c)为二维平面投影的复杂网络示意图，展
// 示多路径交叉结构中的误差传播与联合校正机制。图中包含七
// 个浅蓝色圆圈（内含“T”），按L形与斜线组合排布：最左下角
// 一个顶点向上延伸至中间行左侧顶点，再向右延伸至中间行右
// 侧三个顶点；同时，最左下角顶点也沿对角线方向连接至另一
// 个分支顶点。所有顶点均以六辐星形结构呈现（六个绿色端点），
// 连接线为黑色直线。在各连接边上分布着彩色矩形框：浅蓝色
// 框标注“X”，红色框标注“XX”。特别地，在多个交汇节点处出
// 现重叠标注——例如，在中间行左侧顶点与其上方顶点之间的竖
// 直边上，有一个蓝色框和一个红色框部分重叠，且均标注“X”；
// 在中间行左侧顶点与其右侧顶点之间的水平边上，也有一个红
// 色框标注“XX”；此外，在对角线方向的某条边上还有一个粉色
// 渐变框（介于红蓝之间）标注“X”，暗示可能处于过渡状态或
// 多重错误叠加。比例尺未给出，但相对位置清晰反映拓扑关系。
// 该子图结论表明：在非平凡几何构型中，测量错误可能沿多条
// 路径传播，需协同处理多个关联边才能实现全局纠错，红色框
// 代表最终修正成功的边，而蓝色/粉色框代表待修正或正在修
// 正的状态。
#figure(
  image("imgs/fig_fracton.png", width: 100%),
  caption: [
    (a) We first prepare a vertex state $|T⟩_v$ of 6 qubits (@eq:x_cube_T, @eq:x_cube_vertex) on each vertex of a 3d cubic lattice, and measure the two-body $Z Z$ operators for two qubits on the same link. Measurement outcomes $Z Z = 1$ lead to a ground state of the X-cube model (@eq:x_cube). (b) and (c) show how to correct the measurement errors ($Z Z = - 1$, represented by blue rectangles). Desired outcomes $Z Z = 1$ are represented by red rectangles. In (b), one applies a product of $X$ along a 1d line to annihilate two errors. In (c), one applies a product of $X$ along three lines that meet in a vertex to annihilate three errors along distinct spatial directions.
  ],
)<fig:x-cube>


Here we discuss the constant-depth preparation of X-cube model @xcube, a canonical example of type-I fracton topological order. To define the model, we consider a 3d cubic lattice (with periodic boundary conditions in all spatial directions), where every link accommodates a qubit. The Hamiltonian is defined as


$ H = - sum_c B_c - sum_v (A_(v, x y) + A_(v, y z) + A_(v, z x)), $<eq:x_cube> The cube term $B_c$ is a product of Pauli-Xs on 12 links around a cube $c$. There are three types of vertex terms $A_(v, x y), A_(v, y z), A_(v, z x)$, each of which is a product of four Pauli-Zs around a vertex $v$ on a given x-y, y-z, or z-x plane.


As discussed in Ref.@he_2018_stabilizer, one can exactly represent a ground state of the X-cube model via tensor-network. To start, on each link, one defines a 3-leg tensor $g_(i j)^s = delta_(s, i) delta_(s, j)$, which projects the physical index $s$ to two neighboring virtual legs $i, j$. In addition, one defines a 6-(virtual) leg tensor $T$ on each vertex: $ T_(x overline(x), y overline(y), z overline(z)) = cases(
 1 & "if" cases(
 x + overline(x) + y + overline(y) = 0 mod 2,
 y + overline(y) + z + overline(z) = 0 mod 2,
 z + overline(z) + x + overline(x) = 0 mod 2,
),
 0 & "otherwise",
) $<eq:x_cube_T> It follows that a ground state of the X-cube model can be obtained by contracting all the virtual legs:


$|upright("X-cube")⟩ = sum_({ s_l }) upright("tTr") [⊗_v T ⊗_l g^(s_l)]|{ s_l }⟩ . $ Now we discuss the adaptive protocol that can prepare the above state in constant depth. First, for each vertex, one uses the $T$ tensor to construct a stabilizer state of 6 qubits in the $Z$ basis (#ref(<fig:x-cube>)a)


$ |T⟩_v = sum_(x, overline(x), y, overline(y), z, overline(z)) T_(x overline(x), y overline(y), z overline(z))|x, overline(x), y, overline(y), z, overline(z)⟩ . $<eq:x_cube_vertex>

There are three independent Z-type stabilizers, each of which is a product of four Pauli-Zs for each x-y, y-z, or z-x plane. There are eight (not all independent) X-type stabilizers, each of which takes the form $X X X$ where each $X$ lives in distinct spatial directions. It is also useful to notice that the product of those X-type stabilizers can generate the two-body X-stabilizers: $X_x X_(overline(x))$, $X_y X_(overline(y))$, and $X_z X_(overline(z))$.


We first simultaneously prepare the vertex state $⊗_v|T⟩$, and then perform the two-body ZZ measurements on all two qubits sharing the same link, leading to the following state


$|psi⟩ = [product_l frac(1 + Z Z, 2)] ⊗_v|T⟩, $ when every measurement outcome is one. Such a measurement effectively "fuses" two qubits into a single qubit on every link, thereby realizing the ground state of the X-cube model.


Now we discuss how to correct the measurement errors ($Z Z = - 1$). We notice that since the product of all $Z Z$ operators on each plane stabilizes the state $⊗_v|T⟩$, the errors come in pairs on each plane. This means that there are two following fundamental errors. The first type of error occurs on two links along the same line, which can be annihilated using a product of Pauli-Xs in between (#ref(<fig:x-cube>)b). The second type of error corresponds to three errors on three lines that intersect at a vertex, and can be corrected by a product of X emitted from the vertex (#ref(<fig:x-cube>)c). Physically these measurement errors can be understood as lineon excitations in the X-cube model, which can be annihilated by the product of X described above. In particular, the first type of error corresponds to the fact that without extra energy cost, a lineon can only move along a 1d line, whereas the second type of error reflects the fact that a lineon can change direction by paying an energy cost for creating an extra lineon.


#appl.update("B")
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(B" + str(n) + ")")


= Adaptive circuits via disentangling fluctuating domain walls
<adaptive-circuits-via-disentangling-fluctuating-domain-walls>


== 1d SPT with $ZZ_2 times ZZ_2$ symmetry
<sec:1d_spt>


On a 1d lattice of 2L lattice sites with periodic boundary conditions, we consider a cluster state Hamiltonian $ H_g = - sum_(i = 1)^(2 L) Z_(i - 1) X_i Z_(i + 1) . $ The ground state exhibits an SPT order protected by a $ZZ_2 times ZZ_2$ symmetry generated by the product of Pauli-Xs on odd sites and even sites respectively.


Using $|{ a_i }, { b_i }⟩$ to denote the computation basis with $a_i$ defined on odd sites and $b_i$ defined on even sites, the ground states can be written as $|upright("SPT")⟩ = sum_({ a_i }, { b_i }) product_(i = 1)^L (- 1)^(b_i (a_i + a_(i + 1)))|{ a_i }, { b_i }⟩, $ since it can be obtained from the product state $|+⟩^(⊗ 2 L)$ by applying control-Z gates acting on every two neighboring qubits. To observe the braiding of fluctuating domain walls, we express the state in the Pauli-X basis: $|upright("SPT")⟩ = sum_({ alpha_i }, { beta_i })^(') (- 1)^(chi (alpha, beta))|{ alpha_i }, { beta_i }⟩, $ with $alpha_i, beta_i = plus.minus 1$ corresponding to spins on odd and even sites respectively in X basis. Here, the two $Z_2$ symmetry actions on odd and even sites impose the constraints $product_(i = 1)^L alpha_i = product_(i = 1)^L beta_i = 1$. Therefore, for any allowed ${ alpha_i }$ configuration, $alpha_i = - 1$ must come in pairs, which can be connected by a string. Similarly one can use strings to enumerate all possible ${ beta_i }$ configurations. $chi (alpha, beta)$ is the number of times that $alpha$ braids with $beta$ configurations.


Now when we measure Pauli-X on every odd site, one obtains a particular ${ alpha_i }$ configuration, and crucially, the un-measured degrees of freedom $beta$ is a superposition of strings, which exhibits a long-range $ZZ_2$ order, i.e. $⟨Z_i Z_j⟩ = plus.minus 1$ for any $i, j$.


== Details on preparing CSS codes
<appendix:disentangling_css>


#strong[Chain complex description] @bravyi2014homological @kubica2018ungauging -- Given the qubits labeled by $q in B_Q$, any CSS code Hamiltonian takes the form $H = - sum_(i in cal(B)_X) S_i^X - sum_(j in cal(B)_Z) S_j^Z$, where the stabilizer $S_i^X$ and $S_j^Z$ are products of Pauli-X and Z operators respectively. These stabilizers can be expressed via the parity check matrix $H_X$ and $H_Z$: the $i$-th row of $H_X$ corresponds to the support of the X-type stabilizer $S_i^X$ with $i in B_X$, and similarly, the $j$-th row of $H_Z$ corresponds to the support of the Z-type stabilizer $S_j^Z$ with $j in B_Z$, e.g. $S_j^Z = product_(q in B_Q) Z_q^(\[ H_Z \]_(j q))$. Since every stabilizer commutes, the parity check matrix satisfies $H_Z H_X^T = 0$. This is the crucial property that enables the chain complex description of CSS codes by identifying the boundary operators $partial_X$ and $partial_Z$ as the parity check matrices, i.e. $H_X^T = partial_X$ and $H_Z = partial_Z$. The commutativity of stabilizers (i.e. $H_Z H_X^T = 0$) then translates to a topological fact that the composition of the boundary maps must be zero: $partial_Z partial_X = 0$. Equipped with the boundary maps, the chain complex associated with a CSS code reads


#align(center, image("imgs/chain_complex_map.png", width: 6.5cm)) where $C_X$, $C_Q$ and $C_Z$ are finite-dimensional $cal(F)_2$-vector spaces with bases $cal(B)_X$ = X-type stabilizers, $cal(B)_Q$ = qubits and $cal(B)_Z$ = Z-type stabilizers. Using the identification between boundary maps and the parity check matrices, we write stabilizers as $S_j^Z = product_(q in B_Q) Z_q^(\[ H_Z \]_(j q)) = product_(q in B_Q) Z_q^(\[ partial_Z \]_(j q))$ and $S_i^X = product_(q in B_Q) X_q^(\[ H_X \]_(i q)) = product_(q in B_Q) X_q^(\[ partial_X \]_(q i))$, and therefore the CSS code Hamiltonian is


$ H = - sum_(i in cal(B)_X) product_(q in B_Q) X_q^(\[ partial_X \]_(q i)) - sum_(j in cal(B)_Z) product_(q in B_Q) Z_q^(\[ partial_Z^T \]_(q j)) . $


It may also be succinctly expressed as


$ H = - sum_(i in cal(B)_X) X (partial_X i) - sum_(j in cal(B)_Z) Z (partial_Z^T j), $<eq:css> where $X (partial_X i)$ is the product of Pauli-Xs for spins on the boundary of $i in cal(B)_X$, and $Z (partial_Z^T j)$ is the product of Pauli-Zs for spins on the coboundary of $j in cal(B)_Z$.


An illuminating example is the 2d toric code, which can be obtained by associating the chain complex with a 2d lattice. In this case, $C_2$, $C_1$, and $C_0$ are associated with faces (2-cells), edges (1-cells) and vertices (0-cells). Denoting $cal(B)_X$ and $cal(B)_Z$ as the bases for $C_2$ and $C_0$, one finds the toric code Hamiltonian for qubits living on 1-cells:


$ H = - sum_(i in cal(B)_X) X X X X - sum_(j in cal(B)_Z) Z Z Z Z, $ where the first term is the product of $X$ on the boundary of a 2-cell, and the second term is the product of $Z$ on the coboundary of a 0-cell. \


#strong[Preparation protocol] -- Now we construct an SRE state that leads to the CSS code (@eq:css) upon measurements. First, in addition to the spins labeled by $q in cal(B)_Q$, we also introduce spins labeled by $j in cal(B)_Z$. Initializing all spins in the $+ 1$ eigenstate of Pauli-X, one introduces an operator $Z (partial_Z q)$ that creates a domain-wall configuration for the spins ($in cal(B)_Z$) located on the boundary of $q$. $Z (partial_Z q)$ for all $q in cal(B)_Q$ then forms a generating set to generate all possible domain-wall configurations denoted by $|alpha⟩$ for spins localized in $cal(B)_Z$. Similarly, $Z (partial_Z^T j)$ for all $j in cal(B)_Z$ forms a generating set to generate all possible dual domain-walls denoted by $|beta⟩$ for spins localized in $cal(B)_Q$.


It follows that braiding two types of fluctuating domain walls leads to the SRE state


$|psi_0⟩ = sum_(alpha, beta)^(') (- 1)^(chi (alpha, beta))|alpha, beta⟩, $ where $chi (alpha, beta)$ is a generalized braiding (linking) number. Alternatively, the state can be written as $|psi_0⟩ = product_(q in cal(B)_Q) (1 + X_q Z (partial_Z q)) product_(j in cal(B)_Z) (1 + X_j Z (partial_Z^T j)) ⊗|+⟩$. One can also write down a gapped stabilizer Hamiltonian $H_0$ for which $|psi_0⟩$ is the ground state: $ H_0 = - sum_(j in cal(B)_Z) X_j Z (partial_Z^T j) - sum_(q in B_Q) X_q Z (partial_Z q) $<eq:graphstate> $X_j Z (partial_Z^T j) = 1$ enforces the condition that $Z (partial_Z^T j)$ creates a domain wall on the coboundary of $j$ with a sign that depends on whether $X_j = plus.minus 1$, and similarly, $X_q Z (partial_Z q) = 1$ enforces the condition that $Z (partial_Z q)$ creates a domain wall on the boundary of $q$ with a sign that depends on whether $X_q = plus.minus 1$. These two rules naturally lead to an SRE state as two species of fluctuating domain walls with a braiding phase. In fact, @eq:graphstate is simply a cluster state Hamiltonian defined on a bipartite graph.


Given the SRE state $|psi_0⟩$, measuring Pauli-X for spins labeled by $j in cal(B)_Z$ projects those spins to a particular domain-wall configuration $|alpha'⟩$, which results in the state


$|alpha'⟩ ⊗ sum_beta (- 1)^(chi (alpha', beta))|beta⟩ arrow.r|upright("CSS")⟩ = sum_beta|beta⟩ . $ Here the arrow denotes the procedure: (i) getting rid of the product state $|alpha'⟩$ (ii) removing the sign $(- 1)^(chi (alpha', beta))$ by applying $X (c_q)$, i.e. a product of Pauli-Xs (acting on qubits in $cal(B)_Q$) where $c_q$ denotes the set of qubits whose boundary generates the $alpha'$ configuration via $Z (partial_Z c_q)$. Formally, $|upright("CSS")⟩$ can be written as a product state $product_(j in B_Z) [1 + Z (partial_Z^T j)] ⊗_q|+⟩_q$, which can be expanded as a sum of all possible domain-wall creation operators. This expression also manifests the fact that $|upright("CSS")⟩$ is a ground state of the CSS Hamiltonian (@eq:css).


#strong[Construction from the level of operators] -- Above we discuss the adaptive preparation of CSS codes in terms of wave functions, here we provide a complementary description in terms of operators. Given the Hamiltonian $H_0$ (@eq:graphstate), we measure Pauli-X on spins labeled by $j in cal(B)_Z$ for the ground state of $H_0$. It follows that $X_j Z (partial_Z^T j)$ is replaced by $plus.minus Z (partial_Z^T j)$ where the sign is determined by the measurement outcomes. As for the second term $X_q Z (partial_Z q)$, since $q (in cal(B)_Q)$ has a boundary belonging to $B_Z$, $Z (partial_Z q)$ would not commute with the measurement on $j$-th spins for $j in cal(B)_Z$. It follows that the measurement will induce new terms that commute with the measurement by taking a product of $X_q Z (partial_Z q)$ over various $q in cal(B)_Q$. As a result we are looking for a cycle $c = sum_((c_q in 0, 1)) c_q q in C_Q$ so that $c$ has no boundary (i.e. $partial_Z c = 0$ or equivalently, $c in upright("Ker") (partial_Z)$). The corresponding generated term is $[product_(q in cal(B)_Q) X_q^(c_q)] Z (partial_Z c) = product_(q in cal(B)_Q) X_q^(c_q)$.


To conclude, given the graph state Hamiltonian @eq:graphstate, measuring Pauli-X for spins defined on $j in cal(B)_Z$ gives the post-measurement Hamiltonian that describes the spins labeled by $q in cal(B)_q$:


$ H = sum_(j in cal(B)_Z) plus.minus Z (partial_Z^T j) - sum_(c in upright("Ker") (partial_Z)) med product_(q in cal(B)_Q) X_q^(c_q) . $ As $partial_Z partial_X = 0$, any $c$ that belongs to the image of $partial_X$ must have $partial_Z = 0$, this means one choice of $c$ would be $c = partial_X i$ for $i in cal(B)_X$. On the other hand, there can be homologically nontrivial cycle $c$ not in the image of $partial_X$, meaning $c in upright("Ker") (partial_Z) / upright("Imag") (partial_X)$. Therefore, the post-measurement Hamiltonian can be written as $H =$


$ sum_(j in cal(B)_Z) plus.minus Z (partial_Z^T j) - sum_(i in cal(B)_X) X (partial_X i) - sum_(c in upright("Ker") (partial_Z) / upright("Imag") (partial_X)) X (c) . $ The first and the second term exactly reproduces the desired CSS code Hamiltonian @eq:css (up to a sign that can be corrected by a depth-1 unitary circuit), and the last term simply gives the logical operators that specify a unique state in the ground state subspace.


#appl.update("C")
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(C" + str(n) + ")")


= Operator pushing in symmetric subspace
<appendix:spt_push>
Here we provide details on operator pushing and its generalization in the presence of symmetry. The statement of the operator pushing is the following theorem:


#strong[Theorem]: given a bipartite pure state $|psi⟩ in cal(H)_A ⊗ cal(H)_B$ where $A$ and $B$ have equal Hilbert space dimension $d$, for any unitary $U_A$ supported on $A$, there always exists a unitary $V_B$ supported on $B$ such that $U_A|psi⟩ = V_B|psi⟩$, if and only if $|psi⟩$ is maximally entangled between $A$ and $B$ (i.e the entanglement entropy is $log d$).


A motivating example is given by a Bell pair shared between two qubits: $|upright("Bell")⟩ = 1 / sqrt(2) (|00⟩ +|11⟩)$. Since $X_A X_B|upright("Bell")⟩ = Z_A Z_B|upright("Bell")⟩$ (equivalently, $|upright("Bell")⟩$ is a stabilizer state stabilized by $X_A X_B$ and $Z_A Z_B$), one finds $X_A|upright("Bell")⟩ = X_B|upright("Bell")⟩$, $Z_A|upright("Bell")⟩ = Z_B|upright("Bell")⟩$, and $Z_A X_A|upright("Bell")⟩ = X_B Z_B|upright("Bell")⟩$. Since any unitary operator $U_A$ can be expanded in the operator basis as $U_A = sum_(i, j in (0, 1)) u_(i j) X_A^i Z_A^j$, its action on $|upright("Bell")⟩$ is equivalent to $V_B = sum_(i, j in (0, 1)) u_(i j) Z_B^j X_B^i$, whose unitarity inherits from $U_A$.


#strong[Proof sketch] (see also Ref.@cresswell_2020_pusing): to start, one writes any state $|psi⟩$ in its schmidt decomposition $|psi⟩ = sum_(i = 1)^d sigma_i|i⟩_A|i⟩_B$ with $sigma_i gt.eq 0$ and $sum_(i = 1)^d sigma_i^2 = 1$. Applying an operator $U_A$ supported on $A$ gives


$ U_A|psi⟩ = sum_(i, j = 1)^d sigma_i U_(j i)|j⟩_A|i⟩_B . $ On the other hand, applying an operator $V_B$ supported on $B$ gives


$ V_B|psi⟩ = sum_(i, j = 1)^d sigma_i V_(j i)|i⟩_A|j⟩_B . $ These two actions are equivalent if and only if $U Sigma = Sigma V^T$ where $Sigma$ is a diagonal matrix with ${ sigma_i }$ being the diagonal entries. When $|psi⟩$ is maximally entangled, $Sigma$ is proportional to an identity matrix, in which case, the unitary $U$ on $A$ corresponds to a unitary $V = U^T$ on $B$. On the other hand, demanding the unitarity $V^dagger V = II$ for all $V = Sigma U^T Sigma^(- 1)$ implies $\[ U, Sigma^2 \] = 0$ for all $U$. This in turns indicates $Sigma prop II$.


#strong[Operator pushing with symmetry]: given two Hilbert spaces $cal(H)_A, cal(H)_B$, which may have unequal dimensions, we impose symmetry $S_A$ supported on $A$ and $S_B$ supported on $B$ to define the symmetric subspaces $H_(A, upright("symm"))$ and $H_(B, upright("symm"))$. In other words, any state $|psi_(upright("symm"))⟩$ in $H_(A, upright("symm")) ⊗ H_(B, upright("symm"))$ is invariant under the symmetry action by $S_A$ and $S_B$. For the case $upright("dim") (cal(H)_(A, upright("symm"))) = upright("dim") (cal(H)_(B, upright("symm"))) = d_(upright("symm"))$, we consider a symmetric state $|psi_(upright("symm"))⟩$ with maximal entanglement in the symmetric subspace, i.e. the entanglement entropy between $A$ and $B$ is $log d_(upright("symm"))$. We now consider applying a symmetric unitary $U_(A, upright("symm"))$ acting on $A$. Due to the symmetry, $U_(A, upright("symm"))$ remains a unitary when restricted in the symmetric subspace. Therefore, one can directly apply the aforementioned theorem to find that, for $U_(A, upright("symm"))$ acting on $A$, there exists a symmetric unitary $V_(B, upright("symm"))$ acting on $B$ so that $U_(A, upright("symm"))|psi_(upright("symm"))⟩ = V_(B, upright("symm"))|psi_(upright("symm"))⟩$. Namely, one can push any symmetric unitary from $A$ to $B$ through the maximally entangled state in the symmetric subspace.


#appl.update("D")
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(D" + str(n) + ")")


= Bound on entanglement growth
<appendix:entanglement_bound>


Here we provide a bound on entanglement generated by local adaptive quantum circuits. Specifically, consider a depth-$D$ adaptive quantum circuit, where each layer consists of non-overlapping local gates that can be a unitary or a projector due to measurement, we show that the increase of entanglement of a subsystem $A$ is bounded by $O (D|partial A|)$ with $|partial A|$ being the boundary area of $A$. Here the entanglement for a bipartite pure state $|psi⟩_(A B) in cal(H)_A ⊗ cal(H)_B$ is quantified by the max-entropy (also dubbed Hartley entropy) $S_0 = log chi$, where $chi$ is the rank of the subregion reduced density matrix $rho_A = "tr"_B|psi⟩⟨psi|$. Equivalently, $chi$ is the Schmidt rank in the Schmidt decomposition $|psi⟩_(A B) = sum_(i = 1)^chi sqrt(p_i)|phi.alt_i⟩_A ⊗|theta_i⟩_B$ with ${|phi.alt_i⟩_A }$ and ${|theta_i⟩_B }$ being the orthonormal basis sets for $A$ and $B$ respectively.


Note that while the above result only bounds the increase of max-entropy, one can immediately obtain the following statement: given a product state, the output state of a depth-$D$ adaptive quantum circuit can at most have $O (D|partial A|)$ Renyi entanglement entropy $S_n = 1/(1-n) log "tr"_A rho_A^n$ for any positive $n$ (including the von-Neumann entropy by the limit $n arrow.r 1$). This is because our bound on entanglement growth implies that the output state can at most has $O (D|partial A|)$ max-entropy $S_0$, and $S_0 gt.eq S_n$ for any $n > 0$.


As a non-trivial application, the result above implies starting from a product state, the preparation of a 1d CFT critical state of size $L$ via local adaptive circuits requires a depth $D gt.tilde O (log L)$ due to the logarithmic scaling of entanglement in a 1+1D CFT. Therefore, the $(log L)$-depth adaptive circuit we introduce in Sec. #ref(<sec:mera>, supplement: none) for preparing a critical state is optimal.


Below we present our proof for bounding the entanglement growth of max-entropy. The proof relies on the following two facts :


(i) #emph[A gate acting only on $A$ or $B$ cannot increase the entanglement max-entropy.] To see this, one can consider a gate $O_A$ supported on region $A$. After the application of $O_A$, a state $|psi⟩_(A B)$ in its Schmidt decomposition $|psi⟩_(A B) = sum_(i = 1)^chi sqrt(p_i)|phi.alt_i⟩_A ⊗|theta_i⟩_B$ will transform to $ (O_A ⊗ I_B)|psi⟩_(A B) = sum_(i = 1)^chi sqrt(p_i) O_A|phi.alt_i⟩_A ⊗|theta_i⟩_B . $ Under the bijective map $|theta_i⟩_B arrow.l.r⟨ theta_i|_B$, the state above can be viewed as a matrix of rank at most $chi$. By performing the singular value decomposition of this matrix, one can obtain the Schmidt decomposition of $(O_A ⊗ I_B)|psi⟩_(A B)$. Since the rank of the matrix is at most $chi$, the Schmidt rank of $O_A ⊗ I_B|psi⟩_(A B)$ is at most $chi$ as well. The same reasoning applies to an operator acting on $B$. \


(ii) #emph[A gate $O_(A B)$ acting on the bipartition boundary of $O (1)$ size (i.e. it acts on both $A$ and $B$) can at most increase entanglement max-entropy by an $O (1)$ value]. To see this, one can apply a Schmidt decomposition to express $O_(A B)$ as


$ O_(A B) = sum_(alpha = 1)^(chi') lambda_alpha O_(A, alpha) ⊗ O_(B, alpha), $ with $O_(A, alpha), O_(B, alpha)$ supported on $A, B$ respectively. Applying this operators on $|psi⟩_(A B)$ gives $ sum_(alpha = 1)^(chi') sum_(i = 1)^chi lambda_alpha sqrt(p_i) (O_(A, alpha)|phi.alt_i⟩_A) ⊗ (O_(B, alpha)|theta_i⟩_B) . $ Clearly, the Schmidt rank of the state above is at most $chi' chi$, meaning the increase of the bipartite max-entropy $S_0$ is upper bounded by $log chi'$. Since the operator $O_(A B)$ acts on a region of $O (1)$ size, $chi'$ is bounded by an $O (1)$ number, and so is $log chi'$.


Combining the above two facts leads to the conclusion that the increase of entanglement max-entropy is bounded by the number of boundary gates in a depth-$D$ adaptive circuit, independent of the measurement outcomes. Since each layer contains $O (partial A)$ boundary gates and there are $D$ layers, one finds the growth of entanglement max-entropy is upper bounded by $O (D|partial A|)$.


Finally, we remark that it is tempting to argue the increase of von-Neumann entanglement entropy obeys the same area-law bound, but this is generally false. Consider, for example, a superposition of the trivial state and a Haar random state, with amplitudes $sqrt(1 - epsilon.alt)$ and $sqrt(epsilon.alt)$ respectively. Certainly, by choosing a sufficiently small $epsilon.alt$, one can ensure that von-Neumann entanglement entropy for any bipartition takes an $O (1)$ value. However, even a local measurement can lead to a volume-law entanglement growth by post-selecting on the Haar-random state. Such an example therefore invalidates an area-law bound.