// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
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
}, supplement: "Sec.")
#set figure(placement: auto)
#set par(justify: true, spacing: 1.15em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
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

#let thmbox(fam, name, body) = figure(
  kind: fam,
  supplement: name,
  numbering: "1",
  block(width: 100%, {
    context [*#name #counter(figure.where(kind: fam)).display().*]
    h(0.4em)
    set text(style: "italic")
    body
  }),
)

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Hierarchy of topological order \ from finite-depth unitaries, measurement and feedforward])   #v(1.2em)
    #text(10.5pt)[Nathanan Tantivasadakarn#super[1], Ashvin Vishwanath#super[2], Ruben Verresen#super[2]]
  
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Walter Burke Institute for Theoretical Physics and Department of Physics, California Institute of Technology, Pasadena, CA 91125, USA] \
    #text(9pt)[#super[2] Department of Physics, Harvard University, Cambridge, MA 02138, USA] \
  ]
  #v(1.2em)

// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: June 13, 2023)]]

  Long-range entanglement---the backbone of topologically ordered states---cannot be created in finite time using local unitary circuits, or equivalently, adiabatic state preparation. Recently it has come to light that single-site measurements provide a loophole, allowing for finite-time state preparation in certain cases. Here we show how this observation imposes a complexity hierarchy on long-range entangled states based on the minimal number of measurement layers required to create the state, which we call "shots". First, similar to Abelian stabilizer states, we construct single-shot protocols for creating any non-Abelian quantum double of a group with nilpotency class two (such as $D_4$ or $Q_8$). We show that after the measurement, the wavefunction always collapses into the desired non-Abelian topological order, conditional on recording the measurement outcome. Moreover, the clean quantum double ground state can be deterministically prepared via feedforward---gates which depend on the measurement outcomes. Second, we provide the first constructive proof that a finite number of shots can implement the Kramers-Wannier duality transformation (i.e., the gauging map) for any solvable symmetry group. As a special case, this gives an explicit protocol to prepare twisted quantum double for all solvable groups. Third, we argue that certain topological orders, such as non-solvable quantum doubles or Fibonacci anyons, define non-trivial phases of matter under the equivalence class of finite-depth unitaries and measurement, which cannot be prepared by any finite number of shots. Moreover, we explore the consequences of allowing gates to have exponentially small tails, which enables, for example, the preparation of any Abelian anyon theory, including chiral ones. This hierarchy paints a new picture of the landscape of long-range entangled states, with practical implications for quantum simulators.
]

= Introduction <sec:introduction>
A fundamental notion emerging from decades of research into the ground states of many-body quantum systems is that of #emph[long-range entanglement] (LRE) @BravyiHastingsVerstraete06 @Hastings2010 @ChenGuWen11A @ChenGuWen11B @ZengWen15 @HuangChen2015 @Haah2016. A thermodynamically large quantum state is said to exhibit LRE if it #emph[cannot] be obtained by applying a finite-depth local unitary (FDLU) to a product state, which can intuitively be envisioned as a 'brick layer' of local gates. Sometimes, one allows the gates in the circuit to have exponentially decaying tails (we refer to this as a quasi-FDLU), which are the unitary transformations generated by time evolving with a local Hamiltonian. States related by such quasi-FDLU circuits, at least in the absence of symmetries, closely parallel the notion of a single phase of matter. Hence, LRE states represent distinct phases and cannot be obtained by adiabatic state preparation#footnote[However, there exists a small subclass, namely invertible LRE (such as the Kitaev chain) which can efficiently be prepared by simply preparing a double copy as we discuss later.]. This is an unfortunate situation for the burgeoning field of quantum simulators where the circuit depth is a costly resource @NISQ, since the most interesting and powerful states (e.g., for quantum computation purposes) are exactly those with LRE.

However, in addition to applying quantum gates, quantum simulators and computers can perform site-resolved #emph[measurements]. In fact, it is known that measurements allow certain LRE states to be efficiently prepared in finite time, independent of the system size @Briegel01 @Raussendorf05 @Aguado08 @Bolt16 @Piroli21 @HastingsHaah21 @measureSPT @Rydberg @Bravyi22 @Lu2022 @oneshot. More generally, measurements have been known to reduce complexity of certain computational problems and its precise limits remain an active front of exploration @Hoyer05 @GottesmanChuang99 @Jozsa06 @Browne10 @LiuGheorghiu21 @Friedman22. This suggests that it is worthwhile to consider a coarser equivalence than usual for phases of matter. Indeed, Ref. recently introduced an equivalence class for states obtainable using local unitaries of fixed depth and a #emph[sequential] (and thus linear depth) number of local operations and classical communication, which includes measurements.

In contrast, we instead consider measurement as a scarce resource in this work. We do not place a hard cutoff on the depth of the quantum circuit as long as it is finite (i.e., does not scale with the system size), and instead ask what states are obtainable using $ell$ rounds of single-site measurements interspersed with finite-depth unitaries. Note that the case $ell > 1$ typically requires feedforward#footnote[Indeed, if there is no feedforward, one could simply collapse multiple measurement rounds into one. To see this, note we consider the physically-motivated case of #emph[single-site] measurements (typically on ancilla qubits), which thus always commute (although the choice and ordering of unitary gates means they can correspond to effectively measuring non-commuting observables in a particular order). ]: an FDLU that can depend on the measurement outcomes. We denote $ell$ as the number of 'shots' we need to prepare the state.

Exploring the classification of quantum states with respect to such a number of shots has at least two important consequences. First, it gives a new conceptual and analytic tool to organize and understand interesting emergent properties of many-body quantum states. For this particular problem, using measurement as a scarce resource further organizes the already rich classification of LRE into a hierarchy of states based on the amount of resources needed to prepare it. Second, asking for the minimal number of shots is especially timely for the preparation of such states in noisy intermediate-scale quantum (NISQ) devices @NISQ. Although performing mid-circuit measurements are now possible, an unavoidable overhead is the fact that the protocols to prepare LRE states require the ability to adapt the circuit dynamically based on past measurement outcomes, a technology in active development @DynamicCircuitIBM21 @MidCircuitHoneywell21 @MidCircuitIBM22 @MidCircuitSandia22. Thus, minimizing the number of mid-circuit measurements $ell$ and feedforward can potentially lead to preparing states with higher fidelity.

// [figvision-cn] imgs/TOhierarchyv5.png
// 该图是一个示意图，展示了在包含测量的情况下，不同拓扑序
// 之间的层级关系和等价性。整个图像由多个带有虚线边框的矩
// 形框组成，这些框代表不同的长程纠缠态（即拓扑序）。图像
// 被一个大的红色实线外框包围，但在右上角有一个红色的“L”
// 形分割线，将右上角的一个框与其他部分区分开来。 子图类
// 型：示意图 布局与连接： 中心位置有一个没有边框的区域，
// 标注文字为“product state”（直积态），作为参考基准。 围
// 绕中心区域分布着多个带有黑色虚线边框的矩形框，每个框内
// 都标有一种特定的拓扑序名称。 右上角有一个独立的区域，
// 由红色实线边框界定，内部包含三个垂直排列的矩形框。 具
// 体物体及其内容： 左上角区域：包含两个水平排列的虚线框。
// 左边框内文字为“toric code”，右边框内文字为“double
// semion”。 中上区域：有一个虚线框，位于“double semion”
// 右侧，内部文字为“S_3 TO”。 左下角区域：包含两个水平排
// 列的虚线框。左边框内文字为“D_4 TO”，右边框内文字为“
// chiral Ising anyons”。 中下区域：有两个垂直堆叠的虚线
// 框。上方框内文字为“A_4 TO”，下方框内文字为“S_4 TO”。
// 右下角区域（红色外框内）：包含一列垂直排列的虚线框。从
// 上到下依次为：“Fibonacci anyons”、“A_5 TO”、“S_5 TO”、
// “SL(2,5) TO”。最底部的框内是省略号“...”，表示序列延续。
// 特殊标记： 所有代表拓扑序状态的框均使用黑色虚线边框。
// 右上角包含“Fibonacci anyons”等四个框的整体区域被一个红
// 色实线矩形框包围。 图中没有绘制连接线或箭头来表示转换
// 过程，而是通过空间布局和图注中的说明（如虚线含义、测量
// 层的作用）来传达层级结构信息。 结论与趋势： 该图通过空
// 间分组展示了不同拓扑序的分类。中心的“product state”表
// 明这些拓扑序不能仅通过有限深度的电路从直积态获得。黑色
// 虚线框内的状态代表了具有特定规范群拓扑序的长程纠缠态。
// 红色实线框可能暗示了某种特殊的分类或层级，例如那些可以
// 通过一层测量和前馈操作获得的拓扑序。整体布局反映了在引
// 入测量后，拓扑序之间形成的层级等价关系。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [Figure #context it.counter.display(it.numbering). #it.body]
}

#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [Table #context it.counter.display(it.numbering). #it.body]
}

#figure(image("imgs/TOhierarchyv5.png", width: 100%),
  caption: [
    #strong[Including measurements induces a hierarchy on the equivalence relation between topological orders.] Boxes are long-range entangled states which cannot be obtained from a product state by a finite-depth circuit (the topological order (TO) for a gauge group $G$ refers to the quantum double $cal(D) ( G )$). However, dashed lines indicate they can be obtained by using a layer of measurements and feedforward; the number of dashed lines equal the number of necessary shots. A dot-dashed line indicates the need for a quasi-FDLU rather than strictly local gates. Finally, solid (red) lines cannot be crossed by any finite number of measurement layers; these define non-trivial #emph[measurement-equivalent phases of matter] (red box). We argue that Fib is such an example, and similarly for non-solvable groups, with representatives for their measurement-equivalent phases being given by the quantum doubles of perfect centerless groups (e.g, $A_n$ with $n gt.eq 5$).
  ]
) <fig-hierarchy>

#figure(
  align(center, table(
    columns: 3,
    align: center,
    table.header(
      [resource],
      [implementable states starting from product state],
      [implementable maps],
    ),
    table.hline(),
    [quasi-FDLU], [all cohomology SPT phases], [quasi-FDLU],
    [quasi-FDLU], [all SPT phases], [? (all non-translation QCA?)],
    [quasi-FDLU + ancillas], [Kitaev chain, 3-Fermion Walker-Wang, ...], [any QCA (translation, 3F QCA, ...)],
    [quasi-FDLU + ancillas], [all invertible phases ($p + i p$, $E_8$, ...)], [?],
    [quasi-FDLU + one measurement layer],
    [all (twisted) Abelian quantum doubles (TC, DS, ...)\
     all nil-2 quantum doubles ($D_4$, $Q_8$, $B(2,3)$, ...)],
    [Abelian Kramers-Wannier (KW)\
     Jordan-Wigner in any dimension],
    [\+ two measurement layers], [all (twisted) metabelian quantum doubles ($S_3$, ...)], [KW for all metabelian groups],
    [\+ $n$ measurement layers], [all (twisted) solvable quantum doubles], [KW for all solvable groups],
    [quasi-FDLU + one measurement layer],
    [all Abelian anyon theories (Laughlin $nu = 1 \/ n$, ...)\
     Kitaev's 16-fold way (chiral Ising anyons, ...)],
    [?],
  )),
  caption: [
    #strong[Hierarchy of quantum states via unitaries and measurement.] Implementable states and maps are stated according to the allowed resources. With only FDLUs, one can only prepare SRE phases, while invertible phases can be prepared if ancillas are allowed. With measurements, the topological order that one can prepare depends on how many measurement layers are allowed, while some topological orders are not even preparable with a finite layer of measurements, and are not included in this table (see @fig-hierarchy).
  ],
  kind: table,
) <tbl-hierarchy>

Our work reveals a new hierarchy on quantum states, of which we give an example in @fig-hierarchy. In the largest red box, the number of dotted lines surrounding a particular state denotes the number of shots required in order to create the state from a product state. For example, the toric code and double semion, two of the simplest examples of Abelian topological order, can be prepared in one shot, while the $S_3$ quantum double, an example of a non-Abelian topological order, requires two shots. A natural conjecture is that to move from Abelian to non-Abelian topological orders, multi-shot protocols are essential. Surprisingly, this is not the case. A family of non-Abelian topological orders can be created with just a (carefully designed) single shot protocol, like their Abelian counterparts. A recent example was given for the quantum doubles of $D_4$ (the dihedral group of eight elements), with realistic gates amenable to quantum processors @oneshot. In this work, we provide a generalized protocol to prepare quantum doubles for any group of nilpotence class 2, which includes, for example, $D_4$ and $Q_8$ (the quaternion group), but not $S_3$ (the permutation group on a set of three elements).

On the other hand, we argue that there are certain phases of matter that are not obtainable by a finite number of shots. We substantiate this for the quantum double of non-solvable groups, and also the Fibonacci topological order. In addition to being unreachable from a product state, certain non-solvable group quantum doubles are also unreachable from other other non-solvable groups. This motivates us to introduce the notion of a #emph[measurement-equivalent phase], where in this coarser definition, two states are in the same phase (or equivalence class) if they are related to each other by a finite number of shots. Restricting to quantum doubles of finite groups, we propose a classification of such measurement-equivalent phases, shown as red boxes in @fig-hierarchy. Each measurement-equivalent phase can be labeled by the quantum double of a perfect centerless group (with the solvable case corresponding to the trivial group). Moreover, the Fibonacci anyon theory also defines a non-trivial measurement-equivalent phase.

In addition to the hierarchy on #emph[states] (in a many-body Hilbert space), we also present a hierarchy on #emph[maps] (i.e., linear functions between many-body Hilbert spaces). Indeed, similarly to LRE states, there are certain maps of interest that cannot be written as an FDLU. Two celebrated examples are the Kramers-Wannier (KW) @Wegner1971 @Kogut1979 @CobaneraOrtizNussinov2011 @Haegeman_2015 @Aasen16 @VijayHaahFu2016 @Williamson2016 @KubicaYoshida2018 @Pretko2018 @ShirleySlagleChen2019 @Radicevic2019 and Jordan-Wigner (JW) @Jordan1928 @SMLising @ChenKapustinRadicevic2018 @ChenKapustin2019 @Chen2019 @Tantivasadakarn20 @Shirley20 @Po21 @LiPo21 transformations. In particular we show that the Kramers-Wannier duality transformation of any solvable group $G$ can be constructed from an FDLU circuit with a finite number of shots. Here, the number of shots required is given by the derived length $l_G$ of the group, a quantity which measures how far the group is from being Abelian. This generalizes a previous result which was the Abelian case with $l_G = 1$ @measureSPT.

Notably, the KW map can act on any $G$-symmetric state, which need not be a fixed point state. In fact, the input state can be critical or even long-range entangled. As a special case, choosing the input state to be the symmetric product state $|"+"chevron.r_V^G$ gives an explicit scheme to construct any solvable quantum double. To the best of our knowledge, this is the first general protocol for such states; indeed, Ref. gave a general non-constructive existence argument, and Ref. gave an explicit construction for the special case where each extension is split#footnote[this excludes, for instance, the quaternion group $Q_8$, though see [#emph[Note Added]]]. An important consequence of having an explicit KW map is that this automatically gives a way to prepare twisted quantum doubles for any solvable group (some of which are not quantum doubles of any group). Namely, we can first prepare a Symmetry-Protected Topological (SPT) state for any finite group $G$ using the FDLU from group cohomology given in Ref. before applying the KW map.

== Terminology <sec:terminology>

Let us briefly disambiguate the term #emph[feedforward] used in the paper. We follow the definition that feedforward refers to the fact that the measurement is performed in one subsystem, and the adaptive circuit is performed in a different subsystem~@PhysRevApplied.9.034011. This contrasts feedback, where the measurement and adaptive circuit act on the same subsystem. Feedforward is prominent in quantum protocols such as quantum teleportation~@Teleportation @Ma2012teleportation. Indeed, the implementation of the KW duality using measurement in~@measureSPT is akin to teleportation; after applying a quantum circuit, measurements are performed on the input subsystem, and the resulting state on the output subsystem (up to gates depending on the measurement outcome) is the KW dual of the input state.

We note that the distinction between feedforward and feedback is not necessarily a fundamental one: if a measurement of an ancilla qubit is preceded by a unitary gate, one can equally well consider the #emph[combined] object as a multi-body measurement, in which case a subsequent adaptive circuit could be seen as an example of feedback. However, we prefer to emphasize the fact that we always perform single-site measurements, for two reasons: (i) most measurement capabilities in quantum devices can indeed only measure single qubits, and (ii) it makes meaningful the notion of having a single (or multiple) layers of measurement, since single-site measurement always commute (see also footnote 2).

Second, we clarify the possible scenarios one can perform after measurement

+ One discards the measurement outcome

+ One records the measurement outcome, but one does not explicitly use it to correct the state.

+ One uses the recorded measurement outcome to act on the state

Scenario 1 gives rise to a mixed state, whereas we wish to focus on pure states with long-range entanglement and/or topological order. Scenario 3 corresponds to a feedforward correction, which deterministically prepares the desired state. On the other hand, we do not call scenario 2 feedforward because the measurement outcome was not used to correct the state. Nevertheless, for the protocols we present which requires only one round of measurement, topological order can be prepared regardless of the measurement outcome#footnote[In this work, we consider the case where all measurement outcomes give rise to wavefunctions in the same phase of matter. In future work one can consider probabilistic versions, where, e.g., there is a finite probability of ending up in the desired phase.], as long as the results are not discarded. More precisely, the statement is that for any measurement outcome, the resulting pure states will all be in the same non-trivial topological phase. We note that in the case of feedforward (scenario 3), we #emph[deterministically] prepare the clean state; it would be very interesting in future work to explore the #emph[probabilistic] case.

== Outline <sec:outline>

The sections of this paper are also structured according to this very hierarchy, ordered by the hardness of their preparation, and is summarized in @tbl-hierarchy. In @sec:FDLU, for completeness, we briefly review states that can already be prepared from a product state without the need of measurements. These include not only short-range entangled states, such as SPT phases, but also certain long-range entangled states, such as the Kitaev chain, provided that we use ancillas as resources. In @sec:oneshot, we discuss states that only require one shot to prepare. This includes (twisted) Abelian quantum doubles, but also remarkably certain non-Abelian topological states, and we give an explicit protocol to construct all quantum doubles corresponding to a group of nilpotence class two. In @sec:finiteshots, we give an explicit protocol to implement the Kramers-Wannier map for all solvable groups in a finite number of shots. This gives a method to prepare all (twisted) quantum doubles based on solvable groups. Highest in the hierarchy, in @sec:nonsolvable we argue that there exists states that cannot be prepared by FDLU and a finite number of shots, namely the Fibonacci topological order, and the quantum doubles for non-solvable groups. Assuming this, we are able to derive how all quantum doubles of finite groups are organized into measurement-equivalent phases according to an associated perfect centerless group. In @sec:qFDLU we expand the allowed local unitary evolution to also include quasi-local ones (quasi-FDLU). We then reiterate through the hierarchy, showing that all invertible states can be prepared without measurement, and that certain chiral states, such as the chiral Ising topological order, can be prepared in one shot. We conclude in @sec:outlook with open questions.

= States obtainable without measurement <sec:FDLU>

Since measurements play a key role in the results of this paper, it is equally important to review what states can already be prepared #emph[without] measurements. This is to establish that measurement is a #emph[necessary] ingredient for the scalable preparation of states in the later sections of this paper. Furthermore, these states will also serve as starting points upon which measuring gives rise to interesting states.

== FDLU: SPT states <sec:spt-states>
The first layer in the hierarchy (see @tbl-hierarchy) naturally consists of states obtained by FDLU. In the landscape of phases of matter, this can prepare SPT states @Gu09 @Pollmann10 @Fidkowski_2011 @Turner11 @Schuch11 @ChenGuWen11A @ChenGuWen11B @Chen_2011 @Chen_2013 @pollmann_symmetry_2012 @LuVishwanath12 @SenthilLevin13 @Levin_2012 @VishwanathSenthil2013 @Else_2014, i.e., states that can only be prepared with FDLUs if the individual gates violate certain 'protecting' symmetries. These states are of interest due to their entanglement structure, which in the case of cluster or graph states (obtained by applying a circuit of Controlled-$Z$ gates) can be used, e.g., for measurement-based quantum computation @GottesmanChuang1999 @BriegelRaussendorf2001 @RaussendorfBriegel2001 @RaussendorfBrowneBriegel2003. In fact, we will discuss how the interesting short-range entanglement of various SPT states can be used to construct LRE via measurement @measureSPT.

== FDLU + ancillas: invertible states and QCAs <sec:qca>
The next step in the hierarchy does not yet involve measurement, but merely ancilla qubits. Remarkably, there exist states which can #emph[only] be created from FDLU if one uses such ancillas. These states are invertible LRE states, such as the Kitaev-Majorana chain, i.e., the $p$-wave superconducting chain. Indeed, an FDLU #emph[can] create #emph[two decoupled] Kitaev chains (see @app:Kitaev). If we simply remove a single copy#footnote[This is usually forbidden in the “stabilization” of a phase by ancillas: only product states can be removed. Nevertheless, see Ref. for a coarser definition of phase in fracton orders.], we have thus obtained the Kitaev-Majorana chain.

More generally, one can ask about the class of maps obtained from FDLU and ancillas. This turns out to contain all locality preserving unitaries, also called Quantum Cellular Automata (QCA). Indeed, it is known that if a QCA acts on a Hilbert space $cal(H)$, then there exists an FDLU for QCA $⊗$ QCA$""^(- 1)$ on the doubled Hilbert space $cal(H) ⊗ cal(H)$ @HaahFidkowskiHastings18. For instance, this allows the implementation of the translation operator on $cal(H)$, which is yet another way to obtain the Kitaev-Majorana chain. Other interesting QCAs in higher dimensions have emerged in the past few years @HaahFidkowskiHastings18 @Haah21 @Shirley22 @Haah22.

Similarly, while SPT states cannot be prepared using a finite depth of local gates that preserve the symmetry, they can still be prepared with the help of ancillas by first using a symmetric circuit to prepare the state SPT $⊗$ SPT$""^(- 1)$ and then removing a single copy.

= States preparable in one shot: Abelian and nil-2 non-Abelian quantum doubles <sec:oneshot>
It is known that certain (non-invertible) LRE states, including the Greenberger-Horne-Zeilinger (GHZ) state, toric code, and in fact any Calderbank-Shor-Steane (CSS) code, can be prepared by measuring cluster states @Briegel01 @Raussendorf05 @Aguado08 @Bolt16 @Piroli21. Recently, the present authors, in collaboration with Ryan Thorngren, generalized this by showing how FDLU and a single measurement layer can #emph[implement the Kramers-Wannier (KW) transformation for any Abelian symmetry] in any spatial dimension @measureSPT. This can be thought of as a protocol to 'gauge' an Abelian symmetry. We will briefly recap this in @sec:KWabelian which allows us to prepare any twisted Abelian quantum double, as already noted in Ref.~. We then point out in @sec:nil2 that beyond obtaining Abelian topological order, a single-shot protocol can even prepare a class of non-Abelian topological orders corresponding to the quantum doubles of nilpotent groups of class two, such as $D_4$ or $Q_8$.

== Twisted Abelian quantum doubles <sec:KWabelian>

Let us briefly recap this 'gauging' protocol (or Kramers-Wannier (KW) duality) for a global $bb(Z)_2$ symmetry generated by $product_v X_v$ (we denote the Pauli matrices by $X , Y , Z$) on an arbitrary cellulation of a closed spatial manifold. Starting with an #emph[arbitrary] $bb(Z)_2$ symmetric wavefunction $| psi chevron.r_V$ defined on the vertices of a lattice, we introduce product state ancillas $|"↑"chevron.r_E$ on the edges. After applying Controlled-Not gates (denoted $C N O T$ or $C X$ more briefly) to all nearest-neighbor bonds (with control on vertices and target on edges), projecting the vertices into a symmetric product state implements the KW map:

$ upright("KW")_(E V)^(bb(Z)_2) | psi chevron.r_V = chevron.l"+"|_V product_(chevron.l v , e chevron.r) C X_(v e) |"↑"chevron.r_E ⊗ | psi chevron.r_V . $<eq:KW>

Here, we use the shorthand $|"↑"chevron.r_E = ⨂_(e in E) |"↑"chevron.r_e$ and $|"+"chevron.r_V = ⨂_(v in V) |"+"chevron.r_V$. Crucially, @eq:KW does #emph[not require post-selection]: if one measures the vertices in the $X$-basis and finds $|"-"chevron.r$, these can always be paired up#footnote[Symmetry dictates these always come in pairs.] in one extra unitary layer using string operators. In particular, a pair of $|"-"chevron.r$ on two vertices can be turned into a $|"+"chevron.r$ by applying a string of $Z_e$ on all edges connecting these two vertices. This is the only step relying on the symmetry group being #emph[Abelian]: the measurement outcomes label Abelian gauge charges (anyons in 2D) which can always be paired up in finite time. Applying @eq:KW to the special case of a 2D product state deterministically prepares the toric code, whereas choosing a $bb(Z)_2$ SPT phase @Levin_2012 (which is itself preparable using FDLU, since the preparing circuit does not need to respect symmetry.) leads to double-semion (DS) topological order @measureSPT.

Let us also note two related versions of the KW map: (i) the $upright("KW")$ in @eq:KW maps the Ising interaction as $Z_v Z_(v') arrow.r Z_e$. Alternately, (ii) applying the Hadamard gate on all edges replaces $C X$ by $C Z$ (i.e., Controlled-Z) and $|"↑"chevron.r_E$ by $|"+"chevron.r_E$ giving the map $Z_v Z_(v') arrow.r X_e$, which we denote by $hat(upright("KW"))$. Specifically,

$ hat(upright("KW"))_(E V)^(bb(Z)_2) & = (product_e H_e) upright("KW")_(E V)^(bb(Z)_2) (product_e H_e)\
 & = chevron.l"+"|_V product_(chevron.l v , e chevron.r) C Z_(v e) |"+"chevron.r_E . $

in which we recover the protocol of measuring cluster states by using $|"+"chevron.r_V$ as an input.

The measurement protocol to implement the KW duality generalizes naturally to any finite Abelian group $A$, by using the corresponding generalizations of $C X$ and $C Z$. In this case, the graph must now be #emph[directed]. Each edge $e$ can be associated with an “initial” vertex $i_e$ and “final” vertex $f_e$, and reciprocally, for each vertex $v$ we denote the set of edges pointing into and out of $v$ as $e arrow.r v$ and $e arrow.l v$, respectively. The KW map is constructed as

$ upright("KW")_(E V)^A & = chevron.l"+"|_V product_v [product_(e arrow.r v) ( C X_(v e)^A )^dagger product_(e arrow.r v) C X_(v e)^A] | 1 chevron.r_E\
 & = chevron.l"+"|_V product_e C X_(i_e e)^A ( C X_(f_e e)^A )^dagger | 1 chevron.r_E $<eq:KWabelian>

where $|"+"chevron.r = frac(1, | A |) sum_(a in A) | a chevron.r$, $1$ is the identity in $A$, and the generalized $C X$ gate for the group $A$ is defined as

$ C X_(v e)^A | a_v , a_e chevron.r = | a_v , a_v a_e chevron.r $

Similarly, $hat(upright("KW"))_("EV")$ can be obtained by performing the Fourier transform on all edges, which changes $C X$ to $C Z$ and $| 1 chevron.r$ to $|"+"chevron.r$. We get

$ hat(upright("KW"))_(E V)^A & = chevron.l"+"|_V product_v [product_(e arrow.r v) ( C Z_(v e)^A )^dagger product_(e arrow.r v) C Z_(v e)^A] |"+"chevron.r_E\
 & = chevron.l"+"|_V product_e C Z_(i_e e)^A ( C Z_(f_e e)^A )^dagger |"+"chevron.r_E $<eq:KWdabelian>

where the generalized $C Z$ gate is defined as

$ C Z_(v e)^A | a_v , a_e chevron.r & = chi^(a_v) ( a_e ) | a_v , a_e chevron.r . $

Here, we use the fact that for Abelian groups, there is an isomorphism between group elements and irreps so that we can define $chi^a$, the character corresponding to the group element $a$. Again, post-selection is not required since one can always pair up the corresponding charges in finite time.

Nevertheless, the above construction does not naively apply to the KW map for non-Abelian groups (which would be a method to prepare non-Abelian topological order), since FDLU cannot pair up the non-Abelian anyons that result as measurement outcomes@Shi19 (see @sec:KWG for a full discussion on this obstruction). However, some groups are obtained by a finite number of Abelian extensions. E.g., the symmetry group of the square, $D_4$, can be obtained by extending $bb(Z)_2 times bb(Z)_2$ (the horizontal and vertical mirror symmetries) by $bb(Z)_2$ (the diagonal mirror); note that these two do not commute#footnote[Indeed, the product of the horizontal and diagonal mirror symmetries gives the $bb(Z)_4$ rotation.]. Using this observation, Ref. observed that successively applying @eq:KW can thus generate any quantum double for a #emph[solvable] gauge group; Ref. presented explicit two-step protocols for $D_4$ and $S_3$ (see also Ref.~).

The above line of reasoning strongly suggests that it is impossible to create non-Abelian topological order in a #emph[single] shot. Perhaps surprisingly, this expectation is false. In Ref.~, the present authors argued that it is in fact possible to prepare non-Abelian topological order that admits a Lagrangian subgroup in a single shot and gave explicit protocols to prepare the $D_4$ and $Q_8$ topological orders. In this work, we present an explicit protocol to prepare a class of non-Abelian topological orders, all of which can be prepared in a single shot: the quantum double for class-2 nilpotent groups.

// [figvision-cn] imgs/nilpotentprep5.png
// 该图像包含三个从左到右排列的子图，分别标记为(a)、(b)和
// (c)，展示了在二维格点上制备量子双态的电路层示意图。所
// 有子图共享相同的底层结构：一个由黑色实线构成的正方形网
// 格，网格的交叉点（顶点）用蓝色实心圆点表示，网格边的中
// 点用紫色实心圆点表示。水平边上的箭头指向右侧，垂直边上
// 的箭头指向上方。网格中心的一个顶点用红色实心圆点突出显
// 示。 子图 (a) 类型：量子电路示意图。 布局与物体：背景
// 是上述描述的网格结构。图中叠加了绿色的半透明带状区域，
// 这些区域代表第一层电路操作。 一条水平的绿色带状区域穿
// 过网格的中心行，覆盖了中心行的四个顶点及其连接的边。
// 两条垂直的绿色带状区域穿过网格的第二列和第四列（从左数），
// 覆盖了这两列的顶点及其连接的边。 标注与符号： 在左侧边
// 缘，有一个蓝色的字母“V”和一个紫色的字母“E”，分别靠近顶
// 点和边中点。 在中心红色顶点附近，有一个红色的字母“P”。
// 在中心行的绿色带状区域内，有两个椭圆圈出的部分。左边的
// 椭圆内写有文字“CZ^N”，右边的椭圆内写有文字“(CZ^N)^†”。
// 这两个椭圆分别框住了中心红色顶点与其左右相邻的紫色边中
// 点之间的相互作用。 结论：此图展示了用于纠缠初始乘积态
// 的第一层电路，涉及顶点(V)、边(E)和面(P)算符，具体操作
// 为控制非门(CZ)及其逆操作。 子图 (b) 类型：量子电路示意
// 图。 布局与物体：背景网格结构与子图(a)相同。图中叠加了
// 橙色的半透明带状区域，代表第二层电路操作。 一条水平的
// 橙色带状区域穿过网格的中心行。 两条垂直的橙色带状区域
// 穿过网格的第二列和第四列。 标注与符号： 在中心红色顶点
// 上方，有一个橙色的弧形括号，括号上方标注有希腊字母Ω及
// 下标VEV，即“Ω_VEV”。 在中心红色顶点左侧的水平边上，标
// 注有“i_e”。 在中心红色顶点右侧的水平边上，标注有“j_e”。
// 结论：此图展示了第二层电路，其作用范围由橙色区域标示，
// 并引入了新的算符或参数Ω_VEV以及索引i_e和j_e。 子图 (c)
// 类型：量子电路示意图。 布局与物体：背景网格结构与子图(
// a)和(b)相同。图中叠加了青色的半透明带状区域，代表第三
// 层电路操作。 一条水平的青色带状区域穿过网格的中心行。
// 两条垂直的青色带状区域穿过网格的第二列和第四列。 标注
// 与符号： 在中心行的青色带状区域内，有两个椭圆圈出的部
// 分。左边的椭圆内写有文字“(CX^Q)^†”，右边的椭圆内写有文
// 字“CX^Q”。这两个椭圆分别框住了中心红色顶点与其上下相邻
// 的紫色边中点之间的相互作用。 结论：此图展示了第三层电
// 路，具体操作为受控非门(CX)及其逆操作，作用于特定的边和
// 顶点组合。 综合来看，这三个子图共同描绘了一个三步量子
// 电路过程，通过依次应用不同颜色标示的电路层（绿色、橙色、
// 青色），在二维格点上制备具有拓扑序的量子双态。
#figure(scope: "parent", image("imgs/nilpotentprep5.png", width: 100%),
  caption: [
    #strong[Single-shot preparation of the quantum double for nil-2 groups.] The three circuit layers needed to entangle the product state in @eq:nil2. After measuring vertices (blue) and plaquettes (red), the resulting state on the edges (purple) exhibits $G$ topological order regardless of measurement outcome. If one desires, the exact ground state of $cal(D) ( G )$ can be recovered by a string of $X^n$ on the dual lattice and a string of $Z^q$ on the direct lattice.
  ]
) <fig-nilpotent>

== Quantum double for class-2 nilpotent $G$ in one shot <sec:nil2>
A group $G$ is class-2 nilpotent (commonly called a nil-2 group) if there exists finite Abelian groups $N$ and $Q$ such that the extension

$ 1 arrow.r N arrow.r_()^() G arrow.r_()^() Q arrow.r 1 $<eq:centralextension>

is #emph[central]. That is, $N$ is contained in the center $Z ( G )$. Such central extensions are specified by a function $omega : Q^2 arrow.r N$ called a 2-cocycle $( omega in H^2 ( Q , N ) )$, which determines how multiplication of $Q$ can give rise to elements in $N$. As a 2-cocycle, $omega$ satisfies the cocycle condition

$ omega ( q_2 , q_3 ) omega ( q_1 , q_2 q_3 ) = omega ( q_1 , q_2 ) omega ( q_1 q_2 , q_3 ) . $

Elements in $g in G$ can be denoted by the pair $( n , q )$ whose group law is given via

$ ( n_1 , q_1 ) times ( n_2 , q_2 ) = ( n_1 n_2 omega ( q_1 , q_2 ) , q_1 q_2 ) . $

As an example, consider $N = bb(Z)_2$ and $Q = bb(Z)_2^2$. Denote an element $q in Q$ as the pair $( a , b )$ where $a , b in ( 0 , 1 )$ with addition as the group multiplication. One choice of a cocycle is

$ omega ( ( a_1 , b_1 ) , ( a_2 , b_2 ) ) = a_1 b_2 $

One can check that the above cocycle condition is satisfied, and by further checking the group multiplication, one finds the resulting group is the dihedral group $G = D_4$. On the other hand, the cocycle

$ omega ( ( a_1 , b_1 ) , ( a_2 , b_2 ) ) = a_1 a_2 + a_1 b_2 + b_1 b_2 $

gives rise to the quaternion group $G = Q_8$.

In previous proposals @measureSPT @Bravyi22 such quantum double $cal(D) ( G )$ requires two rounds of measurements by sequentially performing KW on $N$ then $Q$. Conceptually, pairing up the charges in the first round before continuing is crucial to avoid creating non-Abelian charges in the second measurement round. In the current proposal, we can prepare the same state in one shot by instead gauging a particular $N times Q$ SPT state. The Abelian charges we measure by gauging this SPT can be translated into a combination of Abelian charge and fluxes of $cal(D) ( G )$, which braid trivially.

We now give the exact claim for preparing the ground state of the quantum double model for a nil-2 group $G$ on the edges $E$ (purple) of square lattice using ancillas on the vertices $V$ (blue) and plaquettes $P$ (red) as in @fig-nilpotent (though it applies to arbitrary graphs). The local Hilbert space is given by the group algebra with basis elements $| q_v chevron.r in bb(C) [ Q ]$ on $V$, $| n_p chevron.r in bb(C) [ N ]$ on $P$, and $| n_e , q_e chevron.r in bb(C) [ N ] times bb(C) [ Q ] tilde.equiv bb(C) [ G ]$ on $E$. Each edge is given two directions: one connects between vertices (black arrows) and one connects plaquettes (grey arrows).

#thmbox("theorem", "Lemma")[

The ground state for the nil-2 quantum double can be expressed as

$ | cal(D) ( G ) chevron.r_E & = chevron.l"+"|_(V P) C X_(V E)^Q Omega_(V E V) C Z_(P E)^N |"+"chevron.r_V | + , 1 chevron.r_E |"+"chevron.r_P\
 & = upright("KW")_(E V)^Q Omega_(V E V) hat(upright("KW"))_(E P)^N |"+"chevron.r_V |"+"chevron.r_P $<eq:nil2>

where the action of $Omega_(V E V)$ is defined as

$ Omega_(V E V) | { q_v } , { n_e } chevron.r & = | { q_v } , ( n_e macron(omega) ( q_(i_e) , macron(q)_(i_e) q_(f_e) ) ) chevron.r $<eq:OmegaVEV>

]

We defer the proof that the resulting state is indeed exactly the ground state of $cal(D) ( G )$ to @app:nil2prepproof, where we use properties of KW maps for normal subgroups, developed in @sec:KWNinG. Using the above result, we are able to show that

#thmbox("theorem", "Theorem")[

The protocol @eq:nil2 for preparing a nil-2 quantum double can be performed in a single shot.

]

#block[
#emph[Proof.] We postpone all measurements in the protocol until the very end. Since the KW maps act on different subspaces, it is possible to correct the measurement outcomes independently. Namely, measurement outcomes of the vertices and plaquettes correspond to charges $q in Q$ and fluxes of $n in N$, which can be paired up using solid strings of $Z_e^q$ and dotted strings of $X_e^n$, respectively.~◻

]
The interpretation of the protocol is as follows. The first layer (had the measurements on the plaquettes been immediately performed) gauges the symmetric product state on $N$, thus preparing the $N$-toric code. In the second step, $Omega_(V E V)$ turns the toric code into a Symmetry-Enriched Topological (SET) state protected by $Q$. In particular, the charges of the toric code are fractionalized by the symmetry $Q$, and the fractionalization is given precisely by the cocycle $omega in H^2 ( Q , N )$#footnote[In fact, the cocycle $omega ( q_(i_e) , macron(q)_(i_e) q_(f_e) )$ is exactly what appears in the group cohomology construction of 1+1D SPTs in Ref.~.]. Finally, the last layer along with the measurement on the vertices gauges $Q$.

A couple of remarks are in order. First, regardless of measurement outcome, the state always has $cal(D) ( G )$ topological order since the feedforward correction is pairing up Abelian anyons#footnote[To be precise, the pure state corresponding to a given measurement outcomes has topological order. On the other hand, if one discards the measurement outcomes, then the resulting mixed state cannot be said to have topological order.]. Second, it is possible to view the above protocol as gauging an $N times Q$ decorated domain wall SPT state@decorateddomainwalls, where a 1+1D $Q$-SPT state is decorated on $N$ domain walls. We elaborate on this point in @app:DDW.

Lastly, we make contact to a sufficient condition in Ref. that any anyon theory that admits a Lagrangian subgroup can be prepared in one shot. A Lagrangian subgroup $A$ is a subset of Abelian bosons in the topological order that are closed under fusion, have trivial mutual statistics, and that every other anyon braids non-trivially with at least one of the anyons in the subgroup@KS11 @Levin13. We first recall that the pure charges and fluxes of $cal(D) ( G )$ are labeled by irreps and conjugacy classes of $G$, respectively. There are two natural classes of Abelian anyons when $G$ is nil-2. First, since $Q$ is Abelian, irreps of $Q$ are all one-dimensional, thus they pullback to Abelian charges in $G$. Second, since $N$ is in the center of $G$, conjugacy classes of $N$ remain one-dimensional upon being pushed forward to $G$, giving Abelian fluxes. Moreover, these two classes of anyons have mutual braiding statistics, which follows from the exactness of the sequence @eq:centralextension: pulling irreps from $Q$ back to $N$ gives the trivial irrep. This can be interpreted physically as the fact that $Q$ charges are transparent to the $N$ fluxes. Together, these fluxes and charges together form a subgroup $A = N times Q$. Lastly, a sufficient condition to verify that the subgroup is Lagrangian is that the size of the group is equal to the total quantum dimension of the theory. Indeed, one has $| A | = | G |$. To conclude, for the quantum double of a nil-2 group, conjugacy classes of $N$ and irreps of $Q$ form a Lagrangian subgroup of $cal(D) ( G )$. These are exactly the anyons we measure to prepare the state in one shot.

#figure(
  align(center)[#text(size: 8.5pt)[#table(
    columns: (0.9fr, 1.4fr, 1.5fr, 1.8fr),
    align: center,
    table.header([Group], [Nil-2], [Metabelian], [Solvable]),
    table.hline(),
    [$upright("KW")^G$],
    [$upright("KW")^Q times Omega times upright("KW")^N$ @eq:2stepnil2],
    [$upright("KW")^Q times cal(U)^(N lt.closed G) times upright("KW")^N$ @eq:2stepfull],
    [$product_(j = l_G)^1 upright("KW")^(N_j / N_(j - 1) lt.closed G / N_(j - 1))$ @eq:sequentialgauging],
  )]],
  caption: [Decomposition of $upright("KW")^G$ in terms of unitaries and Abelian KW operators, the latter of which can be performed using unitaries and one round of measurement. For the solvable case, $N_j$ are subgroups in the derived series of $G$, and $upright("KW")^(N lt.closed G) = cal(U)^(N lt.closed G) upright("KW")^N$ is the KW map to gauge a normal subgroup $N$ of $G$ (defined in @eq:KWonstatesNG) and $cal(U)^(N lt.closed G) = Sigma^(- 1) times Omega$, where $Sigma$ and $Omega$ are unitary operators that depend on the the factor system of the group extension. When $l_G = 2$, the result reduces to the metabelian case. When the group extension of the metabelian group is central, $Sigma = bb(1)$ and the result reduces to the nil-2 case.],
  kind: table, scope: "parent", placement: top,
) <tbl-kw-summary>

#figure(
  align(center)[#text(size: 9pt)[#table(
    columns: (0.7fr, 1.2fr, 1.4fr, 1.2fr, 2.6fr),
    align: center,
    table.header([$G$], [$N$], [$Q$], [$sigma$], [$omega$]),
    table.hline(),
    [$S_3$], [$bb(Z)_3 = ( 0 , 1 , 2 )$], [$bb(Z)_2 = ( 0 , 1 )$], [$sigma^1 [ n ] = - n$], [$omega ( q_1 , q_2 ) = 1$],
    [$D_4$], [$bb(Z)_2 = ( 0 , 1 )$], [$bb(Z)_2^2 = ( 0 , 1 )^2$], [$sigma^q = 1$], [$omega ( ( a_1 , b_1 ) , ( a_2 , b_2 ) ) = a_1 b_2$],
    [$Q_8$], [$bb(Z)_2 = ( 0 , 1 )$], [$bb(Z)_2^2 = ( 0 , 1 )^2$], [$sigma^q = 1$], [$omega ( ( a_1 , b_1 ) , ( a_2 , b_2 ) ) = a_1 a_2 + a_1 b_2 + b_1 b_2$],
  )]],
  caption: [Examples of group extensions and factor systems for metabelian groups. Here, we assume addition as the group multiplication for the normal and quotient subgroups. The map $upright("KW")^G$ for such groups can be implemented using the decomposition in @eq:2stepfull],
  kind: table, scope: "parent", placement: top,
) <tbl-metabelian-examples>

= Finite-shots: Kramers-Wannier for solvable groups <sec:finiteshots>
In previous work @measureSPT, we argued that quantum doubles corresponding to solvable groups---groups that arise from recursively extending Abelian groups---can be prepared in finite time. In the present work, we show that this can be extended to the space of maps: one can implement the Kramers-Wannier map $upright("KW")^G$ for any solvable group $G$ in finite time using measurements and feedforward. Applying it to the symmetric product state then gives the $G$ quantum double, constituting the first explicit protocol for splitting-simple solvable groups. Moreover, by applying it to $G$-SPT states yields all twisted Abelian quantum doubles.

== Statement of the results <sec:results>

In this subsection, we present the results, which are then derived and explained in the remainder of this section. Rather than jumping straight to the result for arbitrary solvable groups, we offer two stepping stones where we introduce the ingredients necessary for the general case, as summarized in @tbl-kw-summary. When we write $upright("KW")^G$ for a non-Abelian group $G$, we refer to the particular gauging map which is defined by the Kramers-Wannier transformation; we review it in more detail in @sec:KWG.

=== Two-shot protocol for gauging nil-2 groups <sec:nil2-twoshot>
Let us first consider a group $G$ of nilpotency class two, as in @sec:nil2. This means that $G$ is obtained via a central extension @eq:centralextension involving the normal subgroup $N$ and quotient group $Q$. In @sec:nil2, we prepared the quantum double $cal(D) ( G )$ in a single shot using @eq:nil2. The approach used there essentially involved gauging#footnote[This is most explicit by writing @eq:centralextension as gauging $N times Q$ after applying a particular SPT-entangler (see @app:nil2); this is also called a choice of defectification class of the gauging map @BarkeshliBondersonChengWang2019.] a product group $N times Q$ and thus cannot be used to gauge $G tilde.equiv.not N times Q$ for a generic $G$-symmetry input state.

Indeed, although we could prepare the $G$ quantum double in a single shot, here we only find a two-shot protocol for gauging $G$. One way to naturally motivate this is by first considering an alternate protocol for the aforementioned quantum double. Indeed, instead of starting with measuring the plaquette term to prepare the $N$-toric code using $hat(upright("KW"))_(P E)^N$ (as in @eq:KWdabelian), we can measure the vertex terms of the toric code using $upright("KW")_("EV")^N$. This has two consequences. First, since the charges carry fractional charge under $Q$, they become non-Abelian anyons in the quantum double; this forces us to apply feedforward after this first gauging step (when charges are still Abelian), making it a two-shot protocol. Second, now the input state is $|"+"chevron.r_V^N ⊗ |"+"chevron.r_V^Q tilde.equiv |"+"chevron.r_V^G$, which can be interpreted as a $G$-symmetric state, suggesting that we can indeed interpret this approach as gauging the $G$ symmetry of the product state (which is a well-known way of producing $cal(D) ( G )$). Indeed, later in this section we will see that this protocol gauges the $G$ symmetry for any $G$-symmetric input state, i.e.:

$ upright("KW")_(E V)^G = upright("KW")_(E V)^Q Omega_(V E V) upright("KW")_(E V)^N , $<eq:2stepnil2>

where we remind the reader that $upright("KW")$ for Abelian groups is defined in @eq:KWabelian and the unitary $Omega_(V E V)$ in @eq:OmegaVEV.

=== Two-shot protocol for gauging metabelian groups <sec:metabelian-twoshot>

Next, we consider the most general type of non-Abelian groups that are obtained by a single Abelian extension of an Abelian group, called metabelian groups. In contrast to the aforementioned case of nil-2 groups (which is more restrictive), the extension @eq:centralextension defining a metabelian group need not be central.

Hence, to characterize the extension that gives rise to $G$, one must specify---in addition to the 2-cocycle $omega$---how $Q$ acts on $N$. This is given by a map $sigma : Q arrow.r upright("Aut") ( N )$. That is, for a fixed $q$, $sigma^q : N arrow.r N$ is an automorphism. The multiplication law is now

#text(size: 9.5pt)[
$ (n_1,q_1) times (n_2,q_2) = (n_1 sigma^(q_1)[n_2] omega(q_1,q_2), q_1 q_2) $<eq:multiplicationlaw>
]

and associativity demands that $omega$ satisfies the cocycle condition

$ sigma^(q_1) [omega ( q_2 , q_3 )] omega ( q_1 , q_2 q_3 ) = omega ( q_1 , q_2 ) omega ( q_1 q_2 , q_3 ) . $<eq:cocyclecondition>

The pair $sigma$ and $omega$ is together called a #emph[factor system] (see @app:factor for a derivation of the above properties). For instance, $S_3 tilde.equiv bb(Z)_3 times.r bb(Z)_2$ is a (split) extension with the normal subgroup $N = bb(Z)_3 = ( 0 , 1 , 2 )$ and quotient group $Q = bb(Z)_2 = ( 0 , 1 )$, with addition as the group multiplication in the normal and quotient subgroups. while the cocycle is trivial, the extension has a non-trivial automorphism $sigma^1 [ n ] = - n$. Examples for other metabelian groups can be found in @tbl-metabelian-examples.

Like the nil-2 case above, we present a two-shot protocol for gauging such a metabelian group, using the above data $omega$ and $sigma$. In particular, we claim that $upright("KW")^G$ can be prepared by inserting a specific FDLU $cal(U)^(N lt.closed G)$ between the two KW maps:

#thmbox("theorem", "Lemma")[

For an arbitrary group extension, we have the following identity:

$ upright("KW")_(E V)^G = upright("KW")_(E V)^Q cal(U)_(E V)^(N lt.closed G) upright("KW")_(E V)^N $<eq:2stepfull>

where $cal(U)^(N lt.closed G)$ is the FDLU

$ cal(U)_(E V)^(N lt.closed G) & = Sigma_(E V)^(- 1) Omega_(V E V) $<eq:UasFDLU>

with $Omega_(V E V)$ defined in @eq:OmegaVEV and the action of $Sigma_("EV")$ is given by

$ Sigma_(E V) | { q_v } , { n_e } chevron.r = | { q_v } , { sigma^(q_(i_e)) [ n_e ] } chevron.r . $

] <lem:metabelian>

We provide a physical intuition for the role of $cal(U)^(N lt.closed G)$ both from the point of view of a basis transformation, and as an entangler that symmetry-enriches the input state in @sec:Uphysical. The full proof is found in @app:KWN.

The above result implies that for a metabelian group $G$ where $Q$ and $N$ are Abelian, we can implement $upright("KW")^G$ using two rounds of measurement. Applying $upright("KW")^G$ to the $G$-symmetric product state prepares $cal(D) ( G )$ for any metabelian group. For $N = bb(Z)_3$ and $Q = bb(Z)_2$, the protocol matches our previous proposal to prepare $cal(D) ( S_3 )$ in Ref.~, and also agrees with Ref. (up to an appropriate inversion of group elements) which treated the case of a split extension (i.e., for a trivial cocycle $omega$). We further remark that in the special case of a central extension (where $sigma$ is trivial), we have $Sigma_("EV") = 1$ and thus recover the nil-2 protocol in @eq:2stepnil2.

In fact, for the remainder of this section, we find it convenient to define $upright("KW")^(N lt.closed G)$ as the KW map for gauging a normal subgroup $N$ of $G$#footnote[In this notation, $upright("KW")^(G lt.closed G) = upright("KW")^G$.]. Namely, it is the canonical choice for which the following property for two-step gauging holds

$ upright("KW")^G = upright("KW")^Q upright("KW")^(N lt.closed G) $<eq:2step>

Intuitively, the map $upright("KW")^(N lt.closed G)$ gauges $N$ in such a way that it leaves the action of the quotient group $Q$ untouched, which implies that $Q$ can be sequentially gauged as is (see @eq:KWonstatesNG in @sec:KWNinG for a proper definition.). Hence, the non-trivial result in @eq:2stepfull boils down to the statement that

$ upright("KW")^(N lt.closed G) = cal(U)^(N lt.closed G) upright("KW")^N . $<eq:KWNGdef>

We will use the above form for $upright("KW")^(N lt.closed G)$ moving forward.

=== Finite-shot protocol for gauging solvable groups <sec:solvable-protocol>

To state our most general result, let us first briefly review some useful notions about solvable groups. A derived series is a set of normal subgroups $tilde(N)_i lt.closed G$, defined inductively by

$ tilde(N)_0 & = G\
tilde(N)'_j & = [ tilde(N)_(j - 1) , tilde(N)_(j - 1) ] quad j > 0 $<eq:derivedseries>

where $[ tilde(N) , tilde(N) ]$ is the commutator subgroup of $tilde(N)$. The smallest natural number $l_G$ where $tilde(N)_(l_G) = bb(Z)_1$ is called the #emph[derived length] of the group. A solvable group is defined as a group where $l_G$ is finite. For example, Abelian groups, and metabelian groups correspond to $l_G = 1$ and $l_G = 2$, respectively.

To simplify the notation, we now define $N_j = tilde(N)_(l_G - j)$ so that $N_0 = bb(Z)_1$ and $N_(l_G) = G$. We also remark that using the fact that $N_j$ are commutator subgroups, one can show that for the derived series, $N_i lt.closed N_k$ for all $i < k$, and that $N_(j + 1) / N_j$ are all Abelian.

Based on the derived series, we claim that $upright("KW")^G$ can be implemented in exactly $l_G$ rounds of measurement, which we moreover expect to be optimal. Specifically:

#thmbox("theorem", "Theorem")[

The Kramers-Wannier map for any solvable group $G$ with derived length $l_G$ can be implemented using a finite-depth unitary and $l_G$ measurement layers (interspersed with feedforward) as:

$ upright("KW")^G & = product_(j = l_G)^1 upright("KW")^(N_j / N_(j - 1) lt.closed G / N_(j - 1))\
 & = upright("KW")^(G / N_(l_G - 1)) upright("KW")^(N_(l_G - 1) / N_(l_G - 2) lt.closed G / N_(l_G - 2)) dots.h.c upright("KW")^(N_2 / N_1 lt.closed G / N_1) upright("KW")^(N_1 lt.closed G) , $<eq:sequentialgauging>

where each $upright("KW")^(N lt.closed G)$ can be performed in a single shot using @eq:KWNGdef.

] <thm:Gsolvable>

Intuitively, at round $j = 1$, we begin by performing the Abelian KW for the normal subgroup $N_1$. This leaves a remaining quotient symmetry $G / N_1$. We now proceed inductively for $j = 2 , dots.h , l_G$. At round $j$, we have gauged the group $N_(j - 1)$, so we proceed to gauge the group $N_j / N_(j - 1)$ which is again an Abelian normal subgroup of the remaining symmetry $G / N_(j - 1)$. This reduces the remaining symmetry to $G / N_j$. We repeat this until the entire symmetry $G$ is gauged.

#block[
#emph[Proof.] We proceed by induction. The base case $l_G = 1$ is trivial, and for $l_G = 2$, @lem:metabelian gives the existence of a map $upright("KW")^(N lt.closed G)$ which satisfies the two-step gauging condition @eq:2step.~◻

]

Now we proceed to the induction step. Suppose that we have proven @eq:sequentialgauging for derived length $l_G$, consider a group $G'$ of derived length $l_(G') = l_G + 1$ with derived series $N'_j$. Let $G = G' / N'_1$, and $N_j = N'_(j + 1) / N'_1$. From the third isomorphism theorem, we have that

$ G / N_(j - 1) & = frac(G' / N'_1, N'_j / N'_1) = G' / N'_j , & N_j / N_(j - 1) & = frac(N'_(j + 1) / N'_1, N'_j / N'_1) = N'_(j + 1) / N'_j . $

Then,

$ product_(j = l_(G'))^1 upright("KW")^(N'_j / N'_(j - 1) lt.closed G' / N'_(j - 1)) & = [product_(j = l_G)^1 upright("KW")^(N'_(j + 1) / N'_j lt.closed G' / N'_j)] upright("KW")^(N'_1 lt.closed G')\
 & = [product_(j = l_G)^1 upright("KW")^(N_j / N_(j - 1) lt.closed G / N_(j - 1))] upright("KW")^(N'_1 lt.closed G')\
 & = upright("KW")^G upright("KW")^(N'_1 lt.closed G')\
 & = upright("KW")^(G' / N'_1) upright("KW")^(N'_1 lt.closed G') = upright("KW")^(G') $

as desired.

The remaining of this section is devoted to deriving properties of $upright("KW")^(N lt.closed G)$. Due to its length, we provide a brief summary. @sec:KWG reviews the KW map for an arbitrary finite group $G$, and discusses the subtleties of implementing the map with FDLU and measurements for non-Abelian groups. In @sec:KWNinG, we give a prescription of the $upright("KW")^(N lt.closed G)$ and show that for Abelian $N$, this map can be implemented with FDLU and a single round of measurement and feedforward. In @sec:Uphysical, we provide intuition on how and why $upright("KW")^(N lt.closed G)$ differs from $upright("KW")^N$ from the viewpoint of symmetries. As an application, we show in @sec:QDprep that inputting the symmetric product state into $upright("KW")^G$ prepares the ground state of $cal(D) ( G )$, proving that the state can be prepared with $l_G$ rounds of measurements#footnote[Though it is worth noting that to specifically prepare the ground state of $cal(D) ( G )$ (rather than implementing the map $upright("KW")^G$), it is possible for the number of shots to be lowered, as we have demonstrated for the nil-2 case where the derived length is two but the state can be prepared in a single shot.].

== Review of KW map for $G$<sec:KWG>

The Kramers-Wannier map for $G$ in $d$-spatial dimensions ($upright("KW")^G$) is defined as a non-local transformation that maps between states with $G$ 0-form symmetry to states in a $G$ gauge theory with $upright("Rep") ( G ) ( d - 1 )$-form symmetry @Yoshida17 @Lootens21Duality. Note that unlike Abelian groups, there is no natural generalization of $hat(upright("KW"))$, since there is no isomorphism between $G$ and $upright("Rep") ( G )$.

We begin with an arbitrary directed graph with $G$ degrees of freedom $bb(C) [ G ]$ on both vertices and edges with basis vectors given by group elements $| g chevron.r_v$ and $| g chevron.r_e$. At the level of states, the KW map acts by mapping vertex degrees of freedom to edge degrees of freedom by heuristically mapping spin variables on vertices to domain-wall variables on edges. The output of an edge $g_e$ is determined by the two vertices at the boundary where the initial and final vertices are denoted $i_e$ and $f_e$ respectively. That is $upright("KW")^G : bb(C) [ G ]^(⊗ N_v) arrow.r bb(C) [ G ]^(⊗ N_e)$ which acts as

$ ⨂_v | g_v chevron.r_v arrow.r_()^(upright("KW")^G) ⨂_e | macron(g)_(i_e) g_(f_e) chevron.r_e $<eq:KWonstatesG>

where $macron(g)$ denotes the inverse of $g$. Based on this definition, we can work out how operators map. First, we define the generalization of Pauli $X$ and $Z$ to finite groups@Brell2015 @Albert21. The Pauli $X$ is generalized to left and right multiplication for each group element $g$

$ L^g | h chevron.r & = | g h chevron.r , & R^g | h chevron.r = | h macron(g) chevron.r . $

Let $bold(rho)^mu$ be the matrix representation for each irrep $mu$ of $G$. The generalization of Pauli $Z$ is no longer a single site operator, but now a matrix product operator with bond dimension $d^mu$, the dimension of the irrep $mu$. Namely,

$ bold(Z)_(i j)^mu | g chevron.r = bold(rho)^mu ( g )_(i j) | g chevron.r $

where $i , j = 1 , dots.h , d^mu$ denote the bond indices of $bold(Z)$. Here notation-wise, we also use a bold font to denote that the bond indices have not been contracted, and physical operators must be defined by fully contracting such indices.

The defining property of the KW map is that it is not unitary. More specifically, it has non-trivial right and left kernels, which we denote as the “symmetry” and “dual symmetry”. respectively. From the map @eq:KWonstatesG it is apparent that performing left multiplication on all vertices will leave the output state invariant, and any product of $bold(Z)$ around a closed loop is unchanged by an arbitrary input state. In equations,

$ upright("KW")^G times (product_v L_v^g) = upright("KW")^G\
"Tr" [product_(e in l) bold(Z)_e^(mu^(O_e))] times upright("KW")^G = d^mu upright("KW")^G $<eq:G0form>

The former is precisely the $G$ 0-form symmetry, while the latter is given for an arbitrary closed loop $l$ ($partial l = 0$) and $O_e$ denotes the orientation of $e$ with respect to the loop, which conjugates a given representation if the orientation of $e$ goes against that of the loop. If $l$ is contractible, then it defines a local constraint, which can be thought of as a gauge constraint, while for non contractible loops, this defines a $upright("Rep") ( G ) ( d - 1 )$-form symmetry. For non-Abelian $G$, this symmetry operator is not unitary and not onsite if $d^mu > 1$, and is therefore a generalized notion of symmetry called a non-invertible or categorical symmetry (see @Mcgreevy22 @Cordova22Snowmass for a review and further references). In this case, the $upright("Rep") ( G )$ symmetry has an intuitive interpretation as string operators whose end points are gauge charges for the quantum double of $G$ @Bultinck17. The fusion rules for such symmetries correspond precisely to the fusion rules for irreps of $G$.

Similar to the cluster state for Abelian groups, it is possible to represent $upright("KW")^G$ as a tensor-network operator

$ upright("KW")_(E V)^G = chevron.l"+"|_V^G U_(E V)^G | 1 chevron.r_E^G $

where $U_("EV")^G$ is a unitary that generalizes the cluster state entangler to $G$ degrees of freedom@Brell2015 (see @app:Gclustestate for further details). However, we run into a problem when we try to implement the projection via measurement. In general, a complete set of measurement outcomes on each vertex is given by all irreps of the group $G$. Thus, suppose that the measurement outcome transforms under the operators $product_v L_v^g$ as some irrep $mu$ on vertex $v$ and $mu'$ on vertex $v'$, then the desired state where the measurement outcome is $|"+"chevron.r$ can be recovered if we first act with the operator $bold(Z)_v^(macron(mu)) bold(Z)_(v')^mu$. Pushing this through the KW gives the output string operator we must apply to pair-annihilate the irreps and fix the state, which is $product_(e in l) bold(Z)_e^(macron(mu))$ where $l$ is a path whose endpoints are $v$ and $v'$ (see @eq:ZZmapG for a derivation). If $d^mu = 1$, then the excitation is an Abelian anyon and the string operator factors to each edge and so it can be implemented in a single layer. However, if $d^mu > 1$, then the operator remains a matrix product operator that cannot be implemented in finite depth.

Consequently, we now address how to overcome this problem for solvable groups by sequentially apply a KW map that gauges a sequence of Abelian subgroups in $G$, as given in @eq:sequentialgauging.

== KW for gauging a normal subgroup $N$ of $G$<sec:KWNinG>

We proceed to define $upright("KW")^(N lt.closed G)$, and show it satisfies the two-step gauging property @eq:2step. Let us remark that even though $N$ can be assumed to be Abelian for the purposes of this paper, the formulas we present hold for an arbitrary (not necessarily Abelian) normal subgroup of $G$.

=== Definition of $upright("KW")^(N lt.closed G)$<sec:kwn-definition>

First, let us define the maps that gives the $N$ and $Q$ components of an element in $G$:

$ pi : & med G arrow.r Q , & pi ( g ) & = q\
t : & med G arrow.r N , & t ( g ) & = n $

Namely, $g$ can be represented as $g = ( n , q ) = ( t ( g ) , pi ( g ) )$. Note that while $pi$ is a group homomorphism, $t$ is not.

We define the $upright("KW")^(N lt.closed G)$ map by projecting to the $Q$ spins on the vertices via $pi$ and to the $N$ domain walls via $t$. That is, $upright("KW")^(N lt.closed G) : bb(C) [ G ]^(⊗ N_v) arrow.r bb(C) [ N ]^(⊗ N_e) ⊗ bb(C) [ Q ]^(⊗ N_v)$ given by

$ ⨂_v | g_v chevron.r_v arrow.r_()^(upright("KW")^(N lt.closed G)) ⨂_e | t ( macron(g)_(i_e) g_(f_e) ) chevron.r_e^N ⨂_v | pi ( g_v ) chevron.r_v^Q $<eq:KWonstatesNG>

Let us show that using this definition, the two-step gauging property~@eq:2step holds. Further applying $upright("KW")^Q$, we find

$  & ⨂_e | t ( macron(g)_(i_e) g_(f_e) ) chevron.r_e^N ⨂_v | pi ( g_v ) chevron.r_v^Q\
 & arrow.r_()^(upright("KW")^Q) ⨂_e [| t ( macron(g)_(i_e) g_(f_e) ) chevron.r_e^N | pi ( macron(g)_(i_e) g_(f_e) ) chevron.r_e^Q] = ⨂_e | macron(g)_1 g_2 chevron.r_e^G $

where we have used the fact that $pi ( macron(g)_1 ) pi ( g_2 ) = pi ( macron(g)_1 g_2 )$, and combined the $N$ and $Q$ degrees of freedom to a single $G$ degree of freedom $macron(g)_1 g_2$. Comparing to @eq:KWonstatesG, the two maps combined is exactly $upright("KW")^G$.

=== Physical derivation of $upright("KW")^(N lt.closed G)$<sec:Uphysical>

Given the above formula, a direct computation that we perform in @app:KWN shows that @eq:KWNGdef holds. Namely $upright("KW")^(N lt.closed G)$ can be implemented by $upright("KW")^N$ followed by an extra FDLU $cal(U)^(N lt.closed G)$.

Here, we opt to motivate physically why this extra unitary is needed, and why it takes the above form. First, let us see what goes wrong in the absence of this unitary. Consider implementing only the map $upright("KW")^N$

$ ⨂_v | g_v chevron.r_v arrow.r_()^(upright("KW")^N) ⨂_e | macron(n)_(i_e) n_(f_e) chevron.r_e^N ⨂_v | pi ( g_v ) chevron.r_v^Q $<eq:KWonstatesN>

Using this map, there will be a dual $upright("Rep") ( N ) ( d - 1 )$-form symmetry defined as

$ "Tr" [product_(e in l) bold(Z)_e^(nu^(O_e))] $<eq:KWNRepNsymm>

for every $nu in upright("Rep") ( N )$. However, the remaining $Q$ 0-form symmetry will not take the form $product_v L_v^q$ for a non-trivial extension. This can be confirmed explicitly by noting that performing left multiplication by $g$ on all the vertices does not leave the output state invariant because of the modified group multiplication rule @eq:multiplicationlaw. Indeed, one finds

$ ⨂_v | g g_v chevron.r_v arrow.r_()^(upright("KW")^N) ⨂_e | n' chevron.r_e^N ⨂_v | pi ( g_v ) chevron.r_v^Q $<eq:KWonstatesNGgaction>

where $n' = overline(n sigma^q [ n_1 ] omega ( q , q_1 )) n sigma^q [ n_2 ] omega ( q , q_2 ) eq.not macron(n)_1 n_2$.

In fact, the physical reason why this must be the case when the group extension is non-trivial is because end points of $upright("Rep") ( N )$ (which can be thought of as anyons formed by the end points of the symmetry lines) must transform non-trivially under $Q$ @BarkeshliBondersonChengWang2019 @Hermele2014 @TarantinoLinderFidkowski2016

+ When $sigma$ is non-trivial, $Q$ must permute the $upright("Rep") ( N ) ( d - 1 )$-form symmetry#footnote[If $omega$ is trivial, this can be thought of as a split $d$-group].

+ When $omega$ is non-trivial, $Q$ and $upright("Rep") ( N )$ have a mutual anomaly@Tachikawa_2020. (If $sigma$ is trivial, this can be detected by symmetry fractionalization: the end points of $upright("Rep") ( N )$ will carry a projective representation under $Q$)

For this reason, we need to further perform a basis transformation (in the Heisenberg picture) in order to turn $Q$ into an onsite symmetry $product_v L_v^q$ (at the cost of also modifying the form of $upright("Rep") ( N )$), so that $Q$ can be sequentially gauged in the next step.

To gain further insight into the required basis transformation, we now turn to investigate the kernels of the map $upright("KW")^(N lt.closed G)$. First, we note that left multiplication by $N$ on all vertices leaves invariant $pi ( g_v )$ on all vertices and $t ( macron(g)_(i_e) g_(f_e) )$ on all edges. It is therefore a right kernel of $upright("KW")^(N lt.closed G)$. More generally, this means that the $G$ symmetry will be reduced to a $Q$ symmetry under the $upright("KW")^(N lt.closed G)$ map

$ upright("KW")^(N lt.closed G) times product_v L_v^g = product_v L_v^q times upright("KW")^(N lt.closed G) $<eq:Q0form>

which is imperative for sequential gauging. On the other hand, the dual symmetry is not the usual $upright("Rep") ( N )$ symmetry defined in @eq:KWNRepNsymm. Instead, it is obtained by taking a product of $tilde(bold(Z))_e^nu$ operators around closed loops where

$ tilde(bold(Z))_e^nu | q_(i_e) , n_e , q_(f_e) chevron.r & = bold(rho)^nu ( tilde(n)_e ) | q_(i_e) , n_e , q_(f_e) chevron.r ,\
tilde(n)_e & = sigma^(q_(i_e)) [n_e] omega ( q_(i_e) , macron(q)_(i_e) q_(f_e) ) $<eq:tildeZ>

for irreps $nu in upright("Rep") ( N )$. Namely, we have a $( d - 1 )$-form $upright("Rep") ( N )$ symmetry

$ "Tr" [product_(e in l) tilde(bold(Z))_e^(nu^(O_e))] times upright("KW")^(N lt.closed G) = upright("KW")^(N lt.closed G) $<eq:repNd-1form>

To verify this, we note that the group element on each edge can be expressed using the factor system as

$ n_e = t ( macron(g)_(i_e) g_(f_e) ) = macron(omega) ( macron(q)_(i_e) , q_(i_e) ) sigma^(macron(q)_(i_e)) [macron(n)_(i_e) n_(f_e)] omega ( macron(q)_(i_e) , q_(f_e) ) $<eq:tgigfbar>

Inserting this into @eq:tildeZ, and simplifying using the cocycle condition @eq:cocyclecondition gives

$ tilde(n)_e = macron(n)_(i_e) n_(f_e) $

Thus, taking a product around a closed loop, the contributions from each vertex pairwise cancels.

The difference between $tilde(bold(Z))^nu$ and $bold(Z)^nu$ allows us to back out the required basis transformation. Namely, $cal(U)^(N lt.closed G)$ must be the unitary such that

$ ( cal(U)^(N lt.closed G) )^dagger | q_(i_e) chevron.r | n_e chevron.r | q_(f_e) chevron.r = | q_(i_e) chevron.r | tilde(n)_e chevron.r | q_(f_e) chevron.r $

so that $tilde(bold(Z))^nu = cal(U)^(N lt.closed G) bold(Z)^nu ( cal(U)^(N lt.closed G) )^dagger$. From the definition of $tilde(n)$ in @eq:tildeZ, we see that @eq:UasFDLU is exactly the FDLU that does the job.

Let us now offer a complimentary viewpoint of $cal(U)^(N lt.closed G)$ in terms of the Schrödinger picture. That is, as a basis transformation on states instead of the symmetry operators. Suppose we input a symmetric product state of $G$, and applied $upright("KW")^N$, but instead of declaring the $Q$ symmetry to be the result of pushing $product_v L_v^g$ through the KW map, we #emph[insisted] that the $Q$ 0-form symmetry is given by $product_v L_v^q$. Then at this point, the state we have prepared is the $N$ quantum double which is enriched #emph[trivially] by the symmetry $Q$. That is, if we now further gauge this onsite $Q$, the resulting state would be $cal(D) ( N times Q )$, which would be the same result had the group extension been trivial#footnote[this corresponds to $upright("KW")^Q upright("KW")^N = upright("KW")^(N times Q)$]. Thus, to fix this we need to entangle the state into a #emph[non-trivial] SET. This entangler is precisely $cal(U)^(N lt.closed G)$! The two layers of $cal(U)^(N lt.closed G)$ depends on the two data specifying the group extension, and serves the following roles that enrich the state:

+ $Sigma_("EV")$ has an action from the vertices to the edges, which makes the gauge charges (end points of $upright("Rep") ( N )$) permute correctly under the action of the $Q$ 0-form symmetry.

+ $Omega_(V E V)$ can be viewed as the entangler that decorates the strings of the gauge charges with a 1+1D “SPT state”#footnote[“SPT” appears in scare quotes here because the cocycles are valued in $N$ rather than $U ( 1 )$. A fractionalization class does not always correspond to a 1+1D SPT phase.] given by the cocycle $omega$ which gives the end points the correct symmetry fractionalization by $Q$.

In @app:KWN, we prove @eq:KWNGdef explicitly by showing that the right hand side has the correct kernels as shown in @eq:Q0form and @eq:repNd-1form.

== Preparation of $cal(D) ( G )$<sec:QDprep>

As an application, we can use $upright("KW")^G$ to prepare the ground state of $cal(D) ( G )$ by applying it on a symmetric product state~@Brell2015 @Yoshida17

#thmbox("theorem", "Lemma")[

For any finite group $G$, $| cal(D) ( G ) chevron.r_E = upright("KW")_(V E)^G |"+"chevron.r_V^G$.

#block[
#emph[Proof.] Recall that $|"+"chevron.r_V$ is the $+ 1$ eigenstate of the projectors~◻

]

$ R_v & = |"+"chevron.r^G chevron.l"+"|^G = frac(1, | G |) sum_g R_v^g $

For each vertex. In @app:Gclustestate, we show that

$ R_v^g arrow.r_()^(upright("KW")^G) A_v^g = product_(e arrow.r v) R_e^g product_(e arrow.l v) L_e^g . $<eq:LgtoAg>

Therefore, the output state must satisfy

$ A_v = frac(1, | G |) sum_g A_v^g = product_(e arrow.r v) R_e^g product_(e arrow.l v) L_v^g = 1 , $

which is the vertex term of the quantum double model. In addition, for each closed loop around a plaquette $p$, the left kernel of $upright("KW")^G$ tells us that the state also satisfies

$ B_p^mu = "Tr" [product_(e in partial p) bold(Z)_e^(mu^(O_e))] = d^mu $

for each irrep $mu$. Summing over all irreps weighted by their dimensions and using $frac(1, | G |) sum_mu d^mu chi^mu ( g ) = delta_(1 , g)$ and $sum_mu ( d^mu )^2 = | G |$ we have

$ B_p = frac(1, | G |) sum_mu d^mu B_p^mu = sum_({ g_e }) delta_(1 , product_(e subset p) g_e^(O_e)) | { g_e } chevron.r chevron.l { g_e } | = 1 , $

which is precisely the plaquette term of the quantum double model. This shows that the state $upright("KW")_(V E)^G |"+"chevron.r_V$ has eigenvalues $+ 1$ under both $A_v$ and $B_p$.

]

Combining this with @thm:Gsolvable, which gives an explicit protocol to implement $G$ with measurement for solvable groups, we have the following result:

#thmbox("theorem", "Corollary")[

For a solvable group $G$ with derived length $l_G$, the ground state of $cal(D) ( G )$ can be prepared with FDLU, $l_G$ rounds of measurement and feedforward

]

Similarly, one can input a $G$-SPT instead of a symmetry product state. The resulting state will be a twisted quantum double of $G$ @DijkgraafPasquierRoche91TQD @HuWanWu13TQD. Again, we remind the reader that to prepare $cal(D) ( G )$ the measurement rounds can be lowered, as we have shown for nil-$2$ groups.

= No-go for preparation by a finite number of shots: Fibonacci anyons and non-solvable quantum doubles <sec:nonsolvable>

So far, we have demonstrated that there is an interesting hierarchy of states and maps depending on the number of shots required to prepare or implement it, which is summarized in @tbl-hierarchy. It is equally valuable to know negative results, similar to how it is interesting to note that, say, the toric code #emph[cannot] be obtained from the product state by an FDLU @BravyiHastingsVerstraete06. Note that acting with an FDLU followed by measurement on a state naturally gives rise to a projected entangled pair state (PEPS) representation of the wavefunction. Thus, this automatically excludes volume law states. It is also widely believed that chiral states do not admit a PEPS representation with finite bond dimension@kitaev_anyons_2005 @DubailRead15 @FK_CommProj2019 @SK_CommProj2020 (however this restriction can sometimes be overcome by using gates with exponential tails; see @sec:qFDLU). On the other hand, there are a wide range of states in two dimensions that admit a PEPS representation. In fact, it was recently shown that even certain critical states admit such a representation, and particular ensembles of them can be efficiently prepared in this manner @Nishimoricat22 @Lee22.

In this Section, we nevertheless argue that there are certain phases---in fact, even fixed-point states which admit relatively simple PEPS representations---that #emph[cannot be prepared in finite time] using FDLU, measurement and feedforward. Namely, we argue that a finite number of shots cannot prepare non-solvable quantum doubles and the Fibonacci topological order (Fib)#footnote[To make the latter claim a non-trivial statement, one has to allow quasi-FDLU, since Fib is chiral (see @sec:qFDLU); indeed, our arguments direclty extend to the case where the unitary gates have exponentially small tails. Nevertheless, a similar argument holds analogously for the double Fibonacci phase, which admits a PEPS representation.].

== The necessity of creating nonlocal defects for measurement-prepared topological order <sec:nonlocal-defects>

Let us first recall one of the simplest cases of preparing topological order via measurement: one obtains the toric code upon measuring its stabilizers. The randomness of measurement gives us a speckle of 'anyon defects'. While these can be paired up with only a single layer of feedforward gates (to deterministically prepare the clean toric code), this is a conditional gate that depends #emph[nonlocally] on the measurement outcome. Here we formalize the intuition that this is unavoidable by proving the following theorem regarding states that can be prepared with measurement and local corrections (i.e., where one does not require nonlocal classical communication upon applying feedforward):

#thmbox("theorem", "Theorem")[

If a state $| psi_(upright("out")) chevron.r$ is deterministically obtained from an input state $| psi_(upright("in")) chevron.r$ by single-site measurements followed by local corrections implemented by an FDLU, then there exists a state $| phi chevron.r$ such that $| psi_(upright("in")) chevron.r$ is related by an FDLU to $| psi_(upright("out")) chevron.r ⊗ | phi chevron.r$.

#block[
#emph[Proof.] Denote the total Hilbert space $cal(H)$, the subspace on which the measurements are performed $cal(H)_M$, and the remaining Hilbert space $cal(H)_(overline(M))$. For each measurement outcome $| s_i chevron.r$ where $i in M$, we follow up by a local unitary $U_i ( s_i )$ that depends on $s_i$. All $U_i ( s_i )$ must commute regardless of the measurement outcome on each site, since the corrections cannot depend on the order in which they are applied. For a given measurement outcome, we can therefore write the resulting state as~◻

]

$ product_(i in M) U_i ( s_i ) | s_i chevron.r chevron.l s_i | times | psi_(upright("in")) chevron.r . $

Next, define the controlled operator

$ C U_i = sum_({ s'_i }) | s'_i chevron.r chevron.l s'_i | U_i ( s'_i ) $

which applies $U_i ( s'_i )$ depending on an orthonormal basis of measurement outcomes ${ s'_i }$. Orthonormality guarantees that $C U_i$ is unitary. Moreover, since all $U_i ( s_i )$ commute, all the control gates must also commute. We next note that

$ U_i ( s_i ) | s_i chevron.r chevron.l s_i | = | s_i chevron.r chevron.l s_i | C U_i $

Note that here $U$ does not act on the ancillas (indeed, the feedforward only needs to correct on $cal(H)_(overline(M))$ to deterministically prepare $| psi_(upright("out")) chevron.r$). Therefore, the resulting state may also be expressed as

$ product_(i in M) | s_i chevron.r chevron.l s_i | C U_i times | psi_(upright("in")) chevron.r . $

That is, this is a deterministic unitary followed by single site measurements. Now, if this always gives the state $| psi_(upright("out")) chevron.r$ on $cal(H)_(overline(M))$, this means that the measurement at the end must not affect the output state. Therefore, before the measurement, we must have

$ | psi_(upright("out")) chevron.r_(cal(H)_(overline(M))) ⊗ | phi chevron.r_(cal(H)_M) = product_(i in M) C U_i times | psi_(upright("in")) chevron.r_(cal(H)) , $

for some state $| phi chevron.r$. Since $product_(i in M) C U_i$ is an FDLU, this completes the proof.

] <thm:thm2>

#thmbox("theorem", "Corollary")[

Starting with a product state, a single-shot protocol with locally correctable outcomes can only prepare invertible states. <thm:cor3>

#block[
#emph[Proof.] Recall that invertible states $| psi_(upright("inv")) chevron.r$ are states such that there exists an “inverse state” $| psi_(upright("inv"))^(- 1) chevron.r$ such that $U | psi_(upright("inv")) chevron.r ⊗ | psi_(upright("inv"))^(- 1) chevron.r$ is a product state for some FDLU $U$. By definition, if $| psi_(upright("in")) chevron.r$ is a product state, then $| psi_(upright("out")) chevron.r$ is an invertible state.~◻

]

]

Likewise, for a finite-shot protocol, one can still prepare only invertible states from the product state if at each level the measurement results are locally correctable. Moreover, the same reasoning suggests that in the space of maps, locally-correctable protocols can implement only QCAs.

== No-go argument for the Fibonacci topological order: 'Fib' is a non-trivial measurement-equivalent phase <sec:fib-nogo>

Let us use the above result to present a plausibility argument that Fib cannot be prepared in a finite number of shots. We will assume there is a sequence of FDLU, measurements and feedforward corrections that prepares Fib, and argue a contradiction. Let us focus on the final shot of a potential multi-shot protocol.

First, let us assume that in the final shot there are measurements that are non-locally correctable. Then, the obtained wavefunction can be realized as a ground state of a alternate Hamiltonian that differs from the true Hamiltonian by terms localized near such measurement outcomes. Such a wavefunction can be said to contain “defects”. Such defects can be classified by non-trivial superselection sectors, since by definition, they cannot be removed by local corrections. Such superselection sectors are referred to as #emph[anyons] if they are zero-dimensional, and #emph[line defects] if they are one-dimensional in space. However, Fib has only one type of non-Abelian anyon $a$ with fusion rules $a times a = 1 + a$. It also does not have any line defects, since the automorphism group is trivial, and it does not permit a non-trivial symmetry fractionalization class. Therefore, if we wish to deterministically prepare the state, we are not allowed to postselect on obtaining the scenario where all measurement outcomes are locally correctable (corresponding to the trivial anyon $1$). Hence, it is possible that some measurement outcome results in a non-locally correctable error, corresponding to the anyon $a$. Since, $a$ is non-Abelian, it cannot be paired up in finite depth @Shi19 @Liu21 @Bravyi22. Thus, feedforward corrections will fail to prepare Fib.

The only remaining possible scenario is then that all measurements are locally correctable. By @thm:thm2, this is only possible if the state before the measurement is equivalent (up to an FDLU that can potentially depend on the measurement outcome of the previous round) to $| upright("Fib") chevron.r ⊗ | cal(C) chevron.r$ for some state $| cal(C) chevron.r$.

Let us now ask whether $| upright("Fib") chevron.r ⊗ | cal(C) chevron.r$ can itself be prepared by a finite number of shots. Again, measurement outcomes can correspond to anyons or line defects in the phase $upright("Fib") times.square cal(C)$. The only possible Abelian anyons are those entirely in $cal(C)$, and since the states are in a tensor product, measuring these Abelian anyons cannot help prepare $| upright("Fib") chevron.r$. Thus, we are left with the possibility that the measurements result in line defects in $| upright("Fib") chevron.r ⊗ | cal(C) chevron.r$. By a similar argument, if the line defects are non-invertible, they cannot be shrunken away with an FDLU. Therefore, we only consider the case that the measurement outcomes correspond to invertible line defects.

We now give a physical argument that measuring invertible line defects does not help prepare topologically ordered states. Since these defects correspond to charges of 1-form symmetries @generalizedglobalsymmetries, if they occur as measurement outcomes, they would come from a KW map that gauges a 1-form symmetry, which physically corresponds to anyon condensation. Thus, measuring such line defects only serves to reduce the topological order, rather than creating a more complicated one. Thus the parent state itself should be even harder to prepare. Indeed, from the category theory point of view, it is known that the Fibonacci topological order cannot be trivialized by a finite number of Abelian gauging procedures @Etingof2011weakly.

To give an explicit example, consider $cal(C)$ to be another copy of Fib. Then there is an Abelian line defect given by a $bb(Z)_2$ symmetry that swaps the two copies. However, the parent phase on which measuring would give such a line defect corresponds to the phase obtained by gauging the SWAP symmetry. Thus, this does not help us prepare Fib.

To conclude, we conjecture the following:

#thmbox("theorem", "Conjecture")[

The Fibonacci topological order cannot be prepared deterministically from the product state by a finite number of shots.

] <thm:fib>

Assuming that the above conjecture is true, this also implies that any number of copies of Fibonacci also cannot be prepared. If we were able to prepare $N$ copies, we can simply “measure away” $N - 1$ copies and we would be left with a single copy of Fib. Similarly, the double Fibonacci topological order, which admits a PEPS wavefunction@levin_string-net_2005 @GuLevinSwingleWen09 @Buerschaper09, cannot be prepared in any number of shots.

This result motivates us to define the notion of a #emph[measurement-equivalent phase].

#thmbox("theorem", "Definition")[

Two states $| psi chevron.r$ and $| psi' chevron.r$ are in the same #emph[measurement-equivalent phase] if one can deterministically prepare both $| psi chevron.r$ from $| psi' chevron.r$ and $| psi' chevron.r$ from $| psi chevron.r$ using a finite number of rounds of FDLU, measurements and (finite-depth) feedforward.

]

Our claim implies that Fib realizes a non-trivial measurement-equivalent phase,

distinct from twisted quantum doubles for $D ( G )$ for solvable groups, which lie in the trivial measurement-equivalent phase.

== Conjecture for non-solvable quantum doubles <sec:nonsolvable-conjecture>

Similarly, we can construct a similar argument for non-solvable quantum doubles. In this case, it first helps to show that certain groups are in the same measurement-equivalent phase.

#thmbox("theorem", "Lemma")[

The quantum double $cal(D) ( G )$ for any finite group $G$ is in the same measurement-equivalent phase as $cal(D) ( G_("pc") )$, where $G_("pc")$ is a perfect centerless group corresponding to the central quotient of the perfect core of $G$.

]

Here, we recall a few definitions. A perfect group is defined as a group that is equal to its own commutator subgroup $( G = [ G , G ] )$, and the perfect core $G_p$ of a group $G$ is the largest perfect subgroup of $G$. A group $G$ is centerless if its center $Z ( G )$ is trivial, and the central quotient of a group $G$ is defined as $G / Z ( G )$. An example of a perfect centerless group is $A_n$, the alternating group on the set of $n$ elements for $n gt.eq 5$.

The above lemma tells us that we can reduce the problem to showing that $cal(D) ( G_("pc") )$ realizes a non-trivial measurement-equivalent phase for each non-trivial $G_("pc")$. We note in particular that for solvable groups, their quantum doubles are in the same measurement-equivalent phase as that of the trivial group $G_("pc") = { 1 }$.

The following proof can be interpreted as the fact that one can sequentially condense Abelian anyons starting from $cal(D) ( G )$ to reach $cal(D) ( G_("pc") )$. Notably, $cal(D) ( G_("pc") )$ can be thought as a “fixed point” in the measurement-equivalent phase because it only contains non-Abelian anyons.

#block[
#emph[Proof.] To show our claim, we turn to the derived series @eq:derivedseries of an arbitrary finite group $G$. The derived series will always stabilize to the perfect core $G_p$ of $G$. Therefore, given such a group, one can always start from $cal(D) ( G_p )$ and apply the KW map to sequentially gauge appropriate groups according to the derived series in the same spirit as @eq:sequentialgauging in order to arrive at $cal(D) ( G )$.~◻

]

Specifically, we have

$ | cal(D) ( G ) chevron.r_E & = upright("KW")_(E V)^G |"+"chevron.r_V^G\
 & = upright("KW")_(E V)^(G / G_p) cal(U)_(E V)^(G_p lt.closed G) upright("KW")_(E V)^(G_p) |"+"chevron.r_V^(G_p) |"+"chevron.r_V^(G / G_p)\
 & = upright("KW")_(E V)^(G / G_p) cal(U)_(E V)^(G_p lt.closed G) | cal(D) ( G_p ) chevron.r_E |"+"chevron.r_V^(G / G_p) $

since $G / G_p$ is solvable, we can prepare $upright("KW")_("EV")^(G / G_p)$ using measurements and feedforward.

Next, we further argue that $cal(D) ( G_p )$ for any perfect group can in turn be prepared from $cal(D) ( G_("pc") )$. If $G_p$ is already centerless then we are done. Otherwise, Grün's lemma states that the quotient group $G_p / Z ( G_p )$ is centerless, and is therefore a perfect centerless group. Thus, starting from $cal(D) ( G_("pc") )$ we can turn it into an SET state where the fluxes are fractionalized by the symmetry $Z ( G_p )$ according to the 2-cocycle that determines the central extension

$ 1 arrow.r Z ( G_p ) arrow.r G_p arrow.r G_(p c) arrow.r 1 $

Then, gauging $Z ( G_p )$ using the KW map prepares $cal(D) ( G_p )$ as desired.

Reciprocally, to prepare $cal(D) ( G_("pc") )$ from $cal(D) ( G )$ it suffices to perform measurements of the hopping operators to condense the anyons that resulted from the gauging in the reverse order.

Similarly, to the Fibonacci case, let us consider the defects in $cal(D) ( G_("pc") )$. The anyons in $cal(D) ( G_("pc") )$ are all non-Abelian: since the group is perfect, it does not have (non-trivial) one dimensional irreps (corresponding to gauge charges), and since the group is centerless, all conjugacy classes except the trivial one have more than one group element (corresponding to non-Abelian fluxes and dyons). Therefore, the only way to prepare this phase comes from measuring Abelian line defects. Again, as we have argued, this does not help since the parent state must be a larger topological order. We thus conjecture:

#thmbox("theorem", "Conjecture")[

The quantum doubles $cal(D) ( G_("pc") )$ and $cal(D) ( G'_("pc") )$ for distinct perfect centerless groups $G_("pc")$ and $G'_("pc")$ are in distinct measurement-equivalent phases.

]

= Quasi-local unitaries and measurements <sec:qFDLU>
So far, our discussion has focused on states that can be prepared using (strictly) local unitaries, by which we mean finite-depth circuits consisting of finite-range gates. In this final section, we discuss what we can obtain if we instead allow for quasi-local unitaries, i.e., unitary gates with exponentially small long-range tails.

First, using ancillas, it is now possible to prepare any invertible (possibly chiral) state since the “doubled” phase (the phase along with its time-reversed partner) can always be prepared from the product state via quasi-LUs@Barbarino20. The partner can then be discarded leaving us with a single chiral state (see @app:Chern for an explicit example for the Chern insulator). More generally, on the space of maps rather than states, any quasi-local QCA can also be implemented using quasi-FDLU and ancillas. Indeed, we note that although the proof given in @HaahFidkowskiHastings18 (that QCA $⊗$ QCA$""^(- 1)$ is an FDLU) presumes the strictly local case, the proof carries over to the quasi-local case. We also note that in one dimension, quasi-local QCAs have the same classification as that of their local counterparts @Ranard20, while higher-dimensional classifications are unknown.

Adding measurements, one can then perform either KW or JW to gauge such invertible state in one shot @measureSPT. For example, the Ising topological order can be prepared with quasi-LU and one round of measurement by gauging a $p + i p$ superconductor. Similarly, all of Kitaev's 16-fold way can be similarly prepared. We note that Ref.~@LuHsieh observed that one can also obtain the 16-fold way states by locally measuring the parity operator, as a sort of measurement-induced Gutzwiller projection; this also qualifies as a single-shot protocol, although this viewpoint was not emphasized.

It is also worth noting that while Abelian anyon theories with gappable edges can be prepared with FDLU and single-site measurements (since they can be prepared by gauging an appropriate Abelian SPT phase @KS11 @Kaidi2021higher), all cases with #emph[ungappable] boundaries can be prepared using quasi-FDLU in one shot. Given such an Abelian anyon theory $cal(M)$, its “double” $cal(M) times.square overline(cal(M))$ admits a gapped boundary, and therefore can be prepared in one shot. Then, $cal(M)$ and $overline(cal(M))$ can be separated to different Hilbert spaces using a quasi-local unitary so that we can now discard $overline(cal(M))$. For example, the $nu = 1 / 3$ Laughlin state@Laughlin83 can be prepared by first preparing a $bb(Z)_3$ Toric Code, adding fermionic degrees of freedom, then performing a quasi-FDLU to the fixed point of the doubled Laughlin state.

Note the importance of quasi-FDLU in preparing states with ungappable edges. In the absence of exponentially small tails, our preparation scheme would have given a PEPS realization of such a state with finite bond dimension, which is believed to be impossible~@kitaev_anyons_2005 @DubailRead15 @FK_CommProj2019 @SK_CommProj2020.

= Outlook <sec:outlook>
In this work, we have introduced a hierarchy of long-range entangled states based on the number of shots required to prepare the state. In particular, we provided an explicit protocol that shows that nil-2 quantum double states (despite being non-Abelian) are as simple to prepare as Abelian topological states when measurement is an additional resource. In general, we have presented a hierarchy of KW maps for solvable groups $G$ based on their derived length. Moreover, for groups with an infinite derived length (i.e., non-solvable groups) we conjecture that their quantum doubles are in distinct measurement-equivalent phases of matter, and similarly for the Fibonacci topological order.

It is interesting to make a comparison to the ability for such states to be universal for quantum computation. Indeed, it is known that non-nilpotent solvable quantum doubles can only realize Clifford gates by braiding, whereas Fibonacci anyons and non-solvable quantum doubles can realize non-Clifford gates by braiding alone. Nevertheless, for non-nilpotent quantum doubles, additional ancillas and measurement can enable a universal gate set amenable for topological quantum computation@OgburnPreskill99 @Kitaev_2003 @Mochon04. It is thus worth exploring whether there is a deeper connection between the hierarchy of states from measurements and the computational power of the prepared state. Moreover, we have pointed out that that solvable but non-nilpotent quantum doubles require at least two rounds of measurement. It would be interesting to see whether if there is any further increase in computational power (such as a denser universal gate set) for such quantum doubles that require at least three or more rounds of measurement.

Moreover, it is interesting to note that while the present work argues that Fib (and in particular double Fib) cannot be prepared by a finite number of shots, a recent work has shown that string-net models #emph[can] be prepared using $cal(O) ( ln L )$ layers, where $L$ is the system size @Lu2022 (which can be compared to the known linear depth protocols involving unitary circuits @Liu21). It is thus tempting to think that perhaps using $tilde ln L$ shots is optimal, although this is unproven.

Looking forward towards the preparation of more general topological phases of matter in 2+1D, we believe our results generalize to anyon theories described by modular tensor categories (MTCs). Namely, we conjecture that all nil-2 MTCs#footnote[Nilpotence of a MTC is well-defined if we do not require the subcategories appearing in the upper central sequence to be modular.] @GelakiNikshych08 can be prepared in one shot using quasi-FDLUs. In particular, this includes anyon theories that do not have a Lagrangian subgroup, such as Ising anyons. Similarly, we conjecture that all solvable MTCs @Etingof2011weakly can be prepared using quasi-FDLUs and a finite number of shots. A step towards proving this conjecture, as well as the conjectures given in @sec:nonsolvable would be to show rigorously that performing measurements that are non-locally correctable relates the initial and final topological orders by gauging an Abelian symmetry. A further interesting question is whether all representatives of measurement-equivalent phases are given by perfect MTCs (theories that only contain non-Abelian anyons).

Regarding the preparation of solvable MTCs, it would be worthwhile to obtain rigorous results about the minimal number of shots required to prepare a given state of matter. For example, this number for quantum doubles $cal(D) ( G )$ is upper bounded by the derived length $l_G$, but can be lowered as we have shown for nil-2 groups. How does one calculate this number for general solvable MTCs and does this minimal number coincide with any interesting mathematical quantity?

Relatedly, the explicit form for $( upright("KW")^G )^dagger$ shows that $upright("Rep") ( G )$ can be gauged for any finite group $G$ (which does not need to be solvable) using only a single round of measurement. This is because the measurement outcomes correspond to domain walls of $G$, which can be paired up with $L^g$. In particular, this implies that symmetry broken phases of $G$ can be prepared for any finite $G$ in one shot. Are there other interesting non-invertible symmetries that can be gauged efficiently using measurements and feedforward?

Although the construction in the present paper applies to a system without a boundary, we believe that it is straightforward to apply the construction to the case with a boundary. First of all, applying the KW map to a system with a smooth boundary produces a particular gapped boundary, namely the boundary where all gauge fluxes condense. For example, measuring a 2D cluster state with boundary prepares the toric code where all the $m$-anyons condense. In two spatial dimensions, it is known that gapped boundaries of the quantum double of $G$ are classified by a subgroup $K$ of $G$ and a 2-cocycle $H^2 ( K , U ( 1 ) )$@beigi2011quantum @luo2022gapped. This can be physically interpreted as a particular 1D $G$-symmetric state before gauging. Namely, the boundary corresponds to a symmetry-breaking state where the subgroup $K$ is preserved, and the remaining symmetry can be put in to an SPT state. Since such symmetry breaking and SPT states can also be prepared using FDLU and measurements, this gives an explicit way to construct solvable quantum doubles with arbitrary gapped boundaries. We leave the explicit construction of twisted quantum doubles with arbitrary gapped boundaries, and gapped boundaries of topological orders in higher dimensions (itself an active line of research @zhao2022string @luo2022gapped @Ji2022boundary) to future work. The preparation of topological orders with condensation defects inserted@Bombin10Defect @KitaevKong12 @YouJianWen13 @roumpedakis2022higher would also be an interesting direction.

In higher dimensions, gauge theories of nil-2 groups naturally generalize to higher group gauge theories @KapustinThorngren2017 where Abelian $0$-form symmetries are “centrally” extended by higher-form symmetries. We give a protocol to prepare such a class of 2-group gauge theories in 3+1D in one shot in @app:2group. One can also prepare hybrid fracton phases@TJV1 @TJV2 where an Abelian 0-form symmetry is centrally extended by subsystem symmetries in one shot.

#heading(numbering: none)[Acknowledgments]

The authors thank Ryan Thorngren for collaboration on a related project @measureSPT, NT and RV thank Aaron Friedman, Andy Lucas, and Drew Potter for illuminating discussions. NT thanks Wenjie Ji for helpful discussions on $upright("Rep") ( G )$ symmetry and Julia Plavnik for helpful discussions on nilpotent and solvable categories. NT is supported by the Walter Burke Institute for Theoretical Physics at Caltech. RV is supported by the Harvard Quantum Initiative Postdoctoral Fellowship in Science and Engineering, and RV and AV by the Simons Collaboration on Ultra-Quantum Matter, which is a grant from the Simons Foundation (651440, AV).

#emph[Note added.] As this manuscript was being prepared, we learnt of an upcoming work @Li22, which provides an alternate protocol to prepare twisted quantum doubles for non-Abelian groups. In addition, the authors of Ref. have recently informed us of a refinement to their previous proof, to appear, that removes the implicit restriction to split extensions in Ref.~.

#{
  show bibliography: set text(size: 9pt)
  bibliography("refs.bib", title: [References], full: true)
}

// ---- appendices ----
#counter(heading).update(0)
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

= Invertible states from ancillas <app:ancillas>

== Preparing the Kitaev chain from FDLU and ancillas <app:Kitaev>

The Kitaev chain can be prepared by FDLU and ancillas by preparing two Kitaev chains and discarding the second copy. We start with two trivial fermionic chains with Majorana operators $gamma_n , gamma'_n$ and $eta_n , eta'_n$. The stabilizer of the trivial state (atomic insulator) with all sites unoccupied is

$ - i gamma_n gamma'_n &  & - i eta_n eta'_n $

Now we implement two layers of Majorana swap gates

$ U = exp (pi / 4 sum_n eta_(n + 1) gamma'_n) exp (pi / 4 sum_n eta_n gamma'_n) $

From this we see that

$ U gamma_n U^dagger & = gamma_n & U gamma'_n U^dagger & = - gamma'_(n - 1)\
U eta_n U^dagger & = - eta_(n + 1) & U eta'_n U^dagger & = eta'_n $

That is, all $gamma'$ are translated to the left while all $eta$ are translated to the right (up to a minus sign). The resulting stabilizers are

$ i gamma_n gamma'_(n - 1) &  & i eta_(n + 1) eta'_n $

which is exactly the stabilizer for two copies of the Kitaev chain.

== Preparing the Chern Insulator from quasi-FDLU and ancillas <app:Chern>

// [figvision-cn] imgs/Chernstackv2.png
// (a) 子图类型：二维晶格示意图。该图展示了一个由红色和蓝
// 色节点交替排列构成的矩形网格结构，整体呈3行6列布局。所
// 有相邻节点之间通过黑色直线连接，形成规则的方格网络。每
// 条连接线上均标有黑色实心箭头，指示方向。在水平方向上，
// 箭头统一指向右侧；在垂直方向上，箭头统一指向上方；在对
// 角线方向（从左下到右上）的连接线上，箭头也统一指向右上
// 方。红色节点位于奇数行与奇数列的交叉点（如第1行第1列、
// 第1行第3列等），蓝色节点位于偶数行或偶数列的交叉点（如
// 第1行第2列、第2行第1列等）。图中无坐标轴、比例尺或文字
// 标注。此图传达的物理含义是：在一个双原子晶格中，存在沿
// 三个独立方向（x、y及对角线）的定向相互作用或输运路径，
// 且两种原子位置具有不同的拓扑角色。 (b) 子图类型：三维
// 晶格示意图。该图展示了与(a)相同的红蓝节点交替排列模式，
// 但扩展为三维立方体结构，包含前后两层（共约4×6×2个节点
// 可见）。节点间仍以黑色实线连接，并带有黑色实心箭头表示
// 方向。除主层外，后方一层以浅灰色线条和半透明箭头呈现，
// 用于表现深度关系。所有箭头方向保持一致：水平向右、垂直
// 向上、以及从前下至后上的斜向（即沿z轴正方向的对角线）。
// 红色节点仍占据特定空间位置（如前层左下角为红点），蓝色
// 节点分布于其余交替位置。图中无坐标轴、单位或文字标注。
// 该图旨在说明：上述二维定向相互作用可自然推广至三维空间，
// 保持各向异性传输特性，同时体现晶格的周期性堆叠结构。
#figure(
  image("imgs/Chernstackv2.png", width: 100%),
  caption: [
    (a) 2D lattice model with nonzero Chern number (see @eq:Chern); bonds with arrows correspond to an imaginary hopping. (b) a stack of two Chern insulators with opposite Chern numbers; it can be adiabatically connected to a product state by tuning the rung couplings.
  ],
) <fig-chernstack>

Next, outline how to prepare the Chern Insulator with quasi-FDLU and ancillas. First, consider the following Hamiltonian

$ H = sum_(x , y) (i / 2 a_(x , y + 1)^dagger a_(x , y)^(#hide[dagger]) - i / 2 b_(x , y + 1)^dagger b_(x , y)^(#hide[dagger]) + a_(x , y)^dagger b_(x , y + 1)^(#hide[dagger]) + a_(x + 1 , y)^dagger b_(x , y)^(#hide[dagger]) + a_(x , y)^dagger b_(x , y)^(#hide[dagger])) + h . c . $<eq:Chern>

where the couplings are depicted in @fig-chernstack(a). The red (blue) dots are $A$ ($B$) sites, forming the two-site unit cell. It can be straightforwardly checked that this has Chern number $cal(C) = 1$. In momentum space#footnote[$a_(x , y) = frac(1, 2 pi) integral upright(d) k_x upright(d) k_y e^(i k_x x + i k_y y) a_(k_x , k_y)$]: $ H = integral.double upright("d") k_x upright("d") k_y
  ( a_(k_x , k_y)^dagger , b_(k_x , k_y)^dagger )
  mat(
    sin ( k_y ) , 1 + e^(- i k_x) + e^(i k_y) ;
    1 + e^(i k_x) + e^(- i k_y) , - sin ( k_y ) ;
  )
  vec( a_(k_x , k_y) , b_(k_x , k_y) ) $

The non-trivial Chern number implies that the ground state cannot be adiabatically connected to a product state. However, let us consider the double stack in @fig-chernstack(b). where a second copy is introduced with inverted signs of the imaginary hopping, giving $cal(C) = - 1$ to the second copy. As a whole, this non-chiral system can be adiabatically connected to a product state by simply introducing rung couplings; the momentum-space Hamiltonian is: $ cal(H)_(bold(k)) & = (1 - lambda) mat(
    sin ( k_y ) , 1 + e^(- i k_x) + e^(i k_y) , 0 , 0 ;
    1 + e^(i k_x) + e^(- i k_y) , - sin ( k_y ) , 0 , 0 ;
    0 , 0 , - sin ( k_y ) , 1 + e^(- i k_x) + e^(i k_y) ;
    0 , 0 , 1 + e^(i k_x) + e^(- i k_y) , sin ( k_y ) ;
  ) \
  & + lambda mat(
    0 , 0 , i , 0 ;
    0 , 0 , 0 , 1 ;
    - i , 0 , 0 , 0 ;
    0 , 1 , 0 , 0 ;
  ) $ For $lambda = 0$ we have the two decoupled layers, but for $lambda = 0$ we add a real (imaginary) hopping between the red (blue) sites. The case $lambda = 1$ is a trivial product state along each rung. The ground state remains gapped throughout, as shown in @fig-chernstack-gap.

// [figvision-cn] imgs/chernstackgap.png
// 子图类型：曲线图。横坐标轴标记为希腊字母λ，表示绝热演
// 化参数，数值范围从0.0到1.0，主刻度标记位于0.0、0.5和
// 1.0处。纵坐标轴标记为“gap”，表示能隙大小，数值范围从
// 0.00到1.00，主刻度标记位于0.00、0.25、0.50、0.75和1.00
// 处。图中包含一条实心红色曲线，该曲线描绘了能隙随参数λ
// 变化的轨迹。当λ=0.0时，曲线的起始点纵坐标约为0.70；随
// 着λ增加，曲线平滑下降，在λ约等于0.4至0.5之间达到最小值，
// 此时纵坐标约为0.35；随后曲线开始上升，且上升斜率逐渐增
// 大，当λ=1.0时，曲线终点纵坐标达到1.00。整条曲线始终位
// 于横轴上方，表明在该演化路径中系统始终保持非零能隙（即
// 未发生能级闭合）。该子图传达的结论是：存在一条连接两个
// 分离的陈绝缘体（对应λ=0）与直积态（对应λ=1）的绝热路径，
// 在此过程中能隙虽然减小但从未消失，证实了这两个拓扑相属
// 于同一拓扑类或可通过保持能隙打开的方式连续变形。
#figure(image("imgs/chernstackgap.png", width: 100%),
  caption: [
    Adiabatic path connecting two decoupled Chern insulators ($lambda = 0$) to a product state ($lambda = 1$). The Hamiltonian is given in @eq:Chern and the couplings are depicted in @fig-chernstack.
  ]
) <fig-chernstack-gap>

#appl.update("B")
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(B" + str(n) + ")")


= Further details on the KW maps <app:KW>
== $upright("KW")^G$ from the generalized cluster state <app:Gclustestate>
We can explicitly construct the map $upright("KW")^G$ as tensor network operator and demonstrate that it has the correct action. Denote $|"+"chevron.r^G = 1 / sqrt(| G |) sum_(g in G) | g chevron.r$ and $| 1 chevron.r^G = | 1^G chevron.r$ where $1^G$ is the identity element of $G$. Define

$ upright("KW")_(E V)^G = chevron.l"+"|_V^G U_(E V)^G | 1 chevron.r_E^G $<eq:KWGimplement>

where

$ U_(E V)^G = product_v [product_(e arrow.r v) C R_(v e)^dagger product_(e arrow.l v) C L_(v e)^dagger] = product_e C L_(i_e e)^dagger C R_(f_e e)^dagger . $<eq:UG>

The unitary $U^G$ is the generalization of the cluster state entangler for $G$ degrees of freedom, which has both $G$ symmetry and $upright("Rep") ( G ) ( d - 1 )$-form symmetry#footnote[Here, our construction differs slightly from Ref. by using $C L^dagger$ and $C R^dagger$ instead of $C L$ and $C R$. This is so that the $G$ 0-form symmetry acts as left multiplication instead of right multiplication, and is more compatible with the usual definition of a factor system where $sigma$ acts from the left. See Appendix A-B of Ref. for an example of the calculation with right multiplication.]. The Controlled-Not gates are generalized to controlled left and right multiplication operators

$ C L_(v e) | g_1 chevron.r_v | g_2 chevron.r_e & = | g_1 chevron.r_v | g_1 g_2 chevron.r_e ,\
C R_(v e) | g_1 chevron.r_v | g_2 chevron.r_e & = | g chevron.r_v | g_2 macron(g)_1 chevron.r_e $<eq:controlled-not>

An intuitive way to see the action of $U^G$ is to note that for each edge $e$, the unitary acts as

$ C L_(i_e e)^dagger C R_(f_e e)^dagger | g_(i_e) chevron.r | g_e chevron.r | g_(f_e) chevron.r = | g_(i_e) chevron.r | macron(g)_(i_e) g_e g_(f_e) chevron.r | g_(f_e) chevron.r . $<eq:clusterstateproperty>

Thus, after setting $g_e = 1$ (which is implemented by contracting with $| 1 chevron.r_E^G$), we are left with $macron(g)_(i_e) g_(f_e)$, the domain-wall variable we map to in @eq:KWonstatesG.

Let us show that $upright("KW")^G$ defined in @eq:KWGimplement has the correct kernels. The following properties of the controlled left and right multiplication operators will be useful.

$ C L_(v e)^dagger ( L_v^g ⊗ L_e^g ) C L_(v e) & = L_v^g ⊗ bb(1)_e , & C R_(v e)^dagger ( L_v^g ⊗ R_e^g ) C R_(v e) & = L_v^g ⊗ bb(1)_e ,\
C L_(v e)^dagger ( R_v^g ⊗ bb(1)_e ) C L_(v e) & = R_v^g ⊗ L_e^g , & C R_(v e)^dagger ( R_v^g ⊗ bb(1)_e ) C R_(v e) & = R_v^g ⊗ R_e^g ,\
C L_(v e) ( bold(Z)_v^mu ⊗ bold(Z)_e^mu ) C L_(v e)^dagger & = bb(1)_v ⊗ bold(Z)_e^mu , & C R_(v e) ( bold(Z)_v^(macron(mu)) ⊗ bold(Z)_e^mu ) C R_(v e)^dagger & = bb(1)_v ⊗ bold(Z)_e^mu . $<eq:CL1>

First let us show that left multiplication is a symmetry, @eq:G0form,

$ upright("KW")^G times product_v L_v^g & = chevron.l"+"|_V^G U^G product_v L_v^g | 1 chevron.r_E^G\
 & = chevron.l"+"|_V^G U^G product_v [L_v^g product_(e arrow.r v) R_e^g product_(e arrow.l v) L_e^g] | 1 chevron.r_E^G\
 & = chevron.l"+"|_V^G product_v L_v^g U^G | 1 chevron.r_E^G = chevron.l"+"|_V^G U^G | 1 chevron.r_E^G = upright("KW")^G $

where in the second line we used the fact that $product_v [product_(e arrow.r v) R_v^g product_(e arrow.l v) L_v^g] | 1 chevron.r_e^G = | 1 chevron.r_e^G$ since each edge is acted by $L_e^g R_e^g$ which leaves $1^G$ invariant, and on the third line we used @eq:CL1 to obtain $U^G [L_v^g product_(e arrow.r v) R_v^g product_(e arrow.l v) L_v^g] (U^G)^dagger = L_v^g$ and finally $chevron.l"+"|_v^G L_v^g = chevron.l"+"|_v^G$.

Next, to show the dual symmetry @eq:repNd-1form, we notice that

$ bold(Z)_e^mu times upright("KW")^G & = chevron.l"+"|_V^G bold(Z)_e^mu U^G | 1 chevron.r_E^G\
 & = chevron.l"+"|_V^G U^G bold(Z)_(i_e)^(macron(mu)) bold(Z)_e^mu bold(Z)_(f_e)^mu | 1 chevron.r_E^G\
 & = chevron.l"+"|_V^G U^G bold(Z)_(i_e)^(macron(mu)) bold(Z)_(f_e)^mu | 1 chevron.r_E^G = upright("KW")^G times bold(Z)_(i_e)^(macron(mu)) bold(Z)_(f_e)^mu $<eq:ZZmapG>

where on the second line we used @eq:CL1 to obtain $(U^G)^dagger bold(Z)_e^mu U^G = bold(Z)_(i_e)^(macron(mu)) bold(Z)_e^mu bold(Z)_(f_e)^mu$ and on the third line we used $bold(Z)_e^mu | 1 chevron.r_E^G = bold(bb(1))_e | 1 chevron.r_E^G$. Then @eq:repNd-1form follows immediately by sending through instead a product of $bold(Z)_e^mu$ around a closed loop and noticing that for each vertex along this loop we have $chevron.l"+"|_v^G bold(Z)_v^(macron(mu)) bold(Z)_v^mu = chevron.l"+"|_v^G bold(bb(1))_v$ since for each $chevron.l g |$ in the sum, we have $bold(rho)^(macron(mu)) ( g ) bold(rho)^mu ( g ) = bold(rho)^mu ( macron(g) ) bold(rho)^mu ( g ) = bold(rho)^mu ( 1^G ) = bold(bb(1))$

Lastly, we figure out the result of “gauging” $R_v^g$ @eq:LgtoAg

$ upright("KW")^G times R_v^g & = chevron.l"+"|_V^G U^G R_v^g | 1 chevron.r_E^G\
 & = chevron.l"+"|_V^G R_v^g product_(e arrow.r v) R_e^g product_(e arrow.l v) L_e^g U^G | 1 chevron.r_E^G\
 & = chevron.l"+"|_V^G product_(e arrow.r v) R_e^g product_(e arrow.l v) L_e^g U^G | 1 chevron.r_E^G = A_v^g times upright("KW")^G $

where on the second line we used @eq:CL1 to obtain $U^G L_v^g (U^G)^dagger = R_v^g product_(e arrow.r v) R_e^g product_(e arrow.l v) L_e^g$ and on the third line we used $chevron.l"+"|_V^G R_v^g = chevron.l"+"|_V^G$.

== More on factor systems <app:factor>
Here, we give a careful derivation of the properties regarding factor systems and how they determine the group extensions.

Given a group $G$ and a normal subgroup $N lt.closed G$, one has an exact sequence

$ 1 arrow.r N arrow.r_()^iota G arrow.r_()^pi Q arrow.r 1 $<eq:extension>

That is, there exists an injective map $iota : N arrow.r G$ and a surjective map $pi : G arrow.r Q$ such that $pi compose iota = 1$. Next, we pick a lift $s : Q arrow.r G$ such that $pi compose s$ is the identity map in $Q$. Note that $s$ is not a group homomorphism. The map $s$ allows us to define the two pieces of data in the factor system

+ The map $sigma : Q arrow.r upright("Aut") ( N )$ can be defined by $sigma^q ( n ) = s ( q ) ( n )$. That is for each $q in Q$, $sigma^q$ defines an automorphism on $N$ given by conjugation with $s ( q )$.

+ The cocycle $omega : Q^2 arrow.r N$ can be defined by $omega ( ( q_1 , q_2 ) ) = s ( q_1 ) s ( q_2 )$, which captures the failure of $s$ to be a group homomorphism.

Note that because $s ( 1^Q ) = 1^G$ we automatically have the following properties, assumed in the main text:

+ $sigma^1$ acts as the identity automorphism.

+ $omega$ is counital (“normalized”) i.e. $omega ( 1^Q , q ) = omega ( q , 1^Q ) = 1^N$.

We remark that $sigma$ might fail to be a group homomorphism if $N$ is non-Abelian

$ sigma^(q_1) compose sigma^(q_2) = c^(omega ( q_1 , q_2 )) compose sigma^(q_1 q_2) $

where $c^(n_1)$ is an inner automorphism which acts as conjugation: $c^(n_1) [ n_2 ] = n_1 n_2 macron(n)_1$.

Let us define the elements of the extended group $g in G$ as $g = ( n , q ) equiv iota ( n ) s ( q )$. From this, it follows that the group multiplication is given by

$ ( n_1 , q_1 ) times ( n_2 , q_2 ) = ( n_1 sigma^(q_1) [n_2] omega ( q_1 , q_2 ) , q_1 q_2 ) $<eq:multiplicationlawapp>

Furthermore, associativity of group multiplication requires $omega$ to satisfy the following cocycle condition

$ sigma^(q_1) [omega ( q_2 , q_3 )] omega ( q_1 , q_2 q_3 ) = omega ( q_1 , q_2 ) omega ( q_1 q_2 , q_3 ) . $<eq:cocycleconditionapp>

== Properties of $upright("KW")^(N lt.closed G)$<app:KWN>

We would like to show that $upright("KW")_("EV")^(N lt.closed G)$ (defined as the unique map that gauges $N$ and leaves $Q$ invariant) can be expressed as

$ upright("KW")_(E V)^(N lt.closed G) = cal(U)_(E V)^(N lt.closed G) times upright("KW")_(E V)^N $

Equivalently, it suffices to define $upright("KW")^(N lt.closed G)$ as above, and show that $upright("KW")^(N lt.closed G)$ has the correct kernels. First, it is helpful to define the unitary

$ U_(E V)^(N lt.closed G) = cal(U)_(E V)^(N lt.closed G) U_(E V)^N = Sigma_(E V)^(- 1) Omega_(V E V) U_(E V)^N $

so that the map can be expressed as

$ upright("KW")_(E V)^(N lt.closed G) = chevron.l"+"|_V^N U_(E V)^(N lt.closed G) | 1 chevron.r_E^N . $

We note that similarly to @eq:clusterstateproperty, an intuitive way to see why this map works is to note that, $U^(N lt.closed G)$ acts on each edge as

$ U_(E V)^(N lt.closed G) | g_(i_e) chevron.r | n_e chevron.r | g_(f_e) chevron.r = | g_(i_e) chevron.r | macron(omega) ( macron(q)_(i_e) , q_(i_e) ) sigma^(macron(q)_(i_e)) [macron(n)_(i_e) n_e n_(f_e)] omega ( macron(q)_(i_e) , q_(f_e) ) chevron.r | g_(f_e) chevron.r $

Therefore, after setting $n_e = 1$ (which is implemented by contracting with $| 1 chevron.r_E^N$), we are left with $t ( macron(g)_(i_e) g_(f_e) )$, the domain wall variable we map to in @eq:tgigfbar.

For calculation purposes, it is also useful to have

$ ( U_(E V)^(N lt.closed G) )^dagger | g_(i_e) chevron.r | n_e chevron.r | g_(f_e) chevron.r & = | g_(i_e) chevron.r | n_(i_e) sigma^(q_(i_e)) [n_e] omega ( q_(i_e) , macron(q)_(i_e) q_(f_e) ) macron(n)_(f_e) chevron.r | g_(f_e) chevron.r $

as well as the action of left and right multiplications in the basis $| n , q chevron.r in bb(C) [ N ] ⊗ bb(C) [ Q ]$.

$ L_v^g | n_v , q_v chevron.r & = | n sigma^q [n_v] omega ( q , q_v ) , q q_v chevron.r & R_v^g | n_v , q_v chevron.r & = | n_e macron(omega) ( q_v macron(q) , q ) sigma^(q_v macron(q)) [macron(n)] , q_v macron(q) chevron.r $

From the above, one finds the following identities

$ ( U^(N lt.closed G) )^dagger (product_v L_v^g) U^(N lt.closed G) & = product_v L_v^g product_e L_e^n R_e^n Sigma_e^q\
( U^(N lt.closed G) )^dagger tilde(bold(Z))_e^nu U^(N lt.closed G) & = bold(Z)_(i_e)^(macron(nu)) bold(Z)_e^nu bold(Z)_(f_e)^nu $<eq:conjL_N>

where $Sigma^q = sum_n | sigma^q [ n ] chevron.r chevron.l n |$

Now let us check that $upright("KW")^(N lt.closed G)$ has the correct kernels, to show @eq:Q0form,

$ upright("KW")^(N lt.closed G) times product_v L_v^g & = chevron.l"+"|_V^N U^(N lt.closed G) product_v L_v^g | 1 chevron.r_E^N\
 & = chevron.l"+"|_V^N U^(N lt.closed G) [product_v L_v^g product_e L_e^n R_e^n Sigma_e^q] | 1 chevron.r_E^N\
 & = chevron.l"+"|_V^N product_v L_v^g U^(N lt.closed G) | 1 chevron.r_E^N = chevron.l"+"|_V^N product_v L_v^q U^(N lt.closed G) | 1 chevron.r_E^N = product_v L_v^q times upright("KW")^(N lt.closed G) $

where on the second line we used the fact that $L_e^n R_e^n Sigma_e^q | 1^N chevron.r_e = | n sigma^q [ 1^N ] macron(n) chevron.r_e = | 1^N chevron.r_e$, on the third line we used @eq:conjL_N and finally $chevron.l"+"|_V^N product_v L_v^g = chevron.l"+"|_V^N product_v L_v^q$.

Next, to show the dual $upright("Rep") ( N ) ( d - 1 )$-form symmetry, consider

$ tilde(bold(Z))_e^nu times upright("KW")^(N lt.closed G) & = chevron.l"+"|_V^N tilde(bold(Z))_e^nu U^(N lt.closed G) | 1 chevron.r_E^N\
 & = cal(U) chevron.l"+"|_V^N U^(N lt.closed G) bold(Z)_(i_e)^(macron(nu)) bold(Z)_e^nu bold(Z)_(f_e)^nu | 1 chevron.r_E^N\
 & = cal(U) chevron.l"+"|_V^N U^(N lt.closed G) bold(Z)_(i_e)^(macron(nu)) bold(Z)_(f_e)^nu | 1 chevron.r_E^N = upright("KW")^(N lt.closed G) times bold(Z)_(i_e)^(macron(nu)) bold(Z)_(f_e)^nu $

where on the second line we used @eq:conjL_N, and on the third line we used $bold(Z)_e^nu | 1 chevron.r_E^N = bb(1)_e | 1 chevron.r_E^N$. Thus, by taking a product over all edges in a closed loop, the $bold(Z)_(i_e)^(macron(nu)) bold(Z)_(f_e)^nu$ terms pairwise cancel at each vertex, proving @eq:repNd-1form.

#appl.update("C")
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(C" + str(n) + ")")


= Nil-2 Quantum Doubles <app:nil2>

== Proof of preparation <app:nil2prepproof>
Let us confirm that the protocol in @eq:nil2 indeed prepares $cal(D) ( G )$. An important observation is that the intermediate state after gauging $N$ is exactly the toric code state. Therefore,

$ | cal(D) ( N ) chevron.r_E = hat(upright("KW"))_(E P)^N |"+"chevron.r_P^N = upright("KW")_(E V)^N |"+"chevron.r_V^N $

where instead of measuring the plaquette operators, we instead prepared the toric code by measuring the vertex operators. Therefore,

$ upright("KW")_(E V)^Q Omega_(V E V) hat(upright("KW"))_(E P)^N |"+"chevron.r_V^Q |"+"chevron.r_P^N & = upright("KW")_(E V)^Q Omega_(V E V) upright("KW")_(E V)^N |"+"chevron.r_V^Q |"+"chevron.r_V^N\
 & = upright("KW")_(E V)^Q upright("KW")_(E V)^(N lt.closed G) |"+"chevron.r_V^Q |"+"chevron.r_V^N\
 & = upright("KW")_(E V)^G |"+"chevron.r_V^G = | cal(D) ( G ) chevron.r_E $

where we used the definition of $upright("KW")^(N lt.closed G)$ in @eq:KWNGdef for the case of a central extension (trivial $sigma$ and therefore $Sigma_("EV") = bb(1)$) and the two-step gauging property in @eq:2step.

== One-shot preparation of nil-2 quantum double by gauging a decorated domain wall SPT state <app:DDW>
An alternative way to understand the protocol in @eq:nil2 is to treat the state preparation as gauging an SPT state protected by $N times Q$. First, note that if $Omega_(V E V)$ were absent, then we are simply applying KW to gauge the product state with symmetry $N times Q$, which will give an $N times Q$ toric code. However, as pointed out in the main text, by using $Omega_(V E V)$ we are turning the $N$-toric code phase into a non-trivial SET phase protected by $Q$. In fact, we can further push $Omega_(V E V)$ through the $hat(upright("KW"))^N$ by using the fact that it performs a right multiplication by $omega ( q_(i_e) , macron(q)_(i_e) q_(f_e) )$, thus pushing it through and using the fact that $hat(upright("KW"))^N$ turns “$X$” (in this case, right multiplication) into “$Z Z$”,

$ Omega_(V E V) hat(upright("KW"))_(E P)^N & = hat(upright("KW"))_(E P)^N Omega_(V V P P) ,\
Omega_(V V P P) | q_(i_e) , q_(f_e) , n_(i_(caron(e))) , n_(f_(caron(e))) chevron.r & = chi^(macron(omega) ( q_(i_e) , macron(q)_(i_e) q_(f_e) )) ( macron(n)_(i_(caron(e))) n_(f_(caron(e))) ) | q_(i_e) , q_(f_e) , n_(i_(caron(e))) , n_(f_(caron(e))) chevron.r $

where $i_(caron(e))$ and $f_(caron(e))$ denotes the plaquettes with dotted lines pointing into and out of the edge $e$. This is exactly the decorated domain wall wavefunction@decorateddomainwalls. For each edge $e$, a “1D SPT state” given by a 2-cocycle $omega$ whose wavefunction lives on the vertices and is given by $omega ( q_(i_e) macron(q)_(f_e) , q_(f_e) )$ is present whenever there is an $N$ domain wall, which is detected by the combination $n_(i_(caron(e))) macron(n)_(f_(caron(e)))$. To conclude, our state has been recasted into the form

$ | cal(D) ( G ) chevron.r_E & = chevron.l"+"|_V^Q C X_(V E) | 1 chevron.r_E^Q times chevron.l"+"|_P^N C Z_(P E) |"+"chevron.r_E^N times | upright("SPT") chevron.r $

where the SPT protected by $N times Q$ is given by

$ | upright("SPT") chevron.r = Omega_(V V P P) |"+"chevron.r_V^Q |"+"chevron.r_P^N . $

Hence in this viewpoint, we are preparing a twisted quantum double $cal(D)^alpha ( N times Q )$ realizing the same phase of matter as $cal(D) ( G )$#footnote[Mathematically, this follows from the fact that $upright("Vec") ( G )$ and $upright("Vec")^alpha ( N times Q )$ are Morita equivalent as fusion categories. Therefore, the topological order in the bulk are related by a circuit @Lootens22. Nevertheless, our preparation scheme here is designed such that we #emph[exactly] prepare $cal(D) ( G )$ and no extra circuit is required.]. The 3-cocycle $alpha$ corresponds to a class $[ alpha ] in H^3 ( N times Q , U ( 1 ) )$, and can be related to $omega$ using the $H^2 ( Q , H^1 ( N , U ( 1 ) ) )$ part of the Kunneth formula). The two classes are related via@HuWan20 @Tachikawa_2020

$ alpha = rho union omega $

where $rho$ is the generating class of $H^1 ( N , U ( 1 ) )$.

#appl.update("D")
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(D" + str(n) + ")")


= One shot preparation of 2-group gauge theory with Abelian 0-form symmetry <app:2group>

A 2-group#footnote[not to be confused with $p$-group used in group theory where $| G |$ is some power of $p$.] $bb(G)$ gauge theory can be specified by a $0$-form symmetry $Q$, a $1$-form symmetry $N$, an automorphism $sigma : Q arrow.r upright("Aut") ( N )$ and a certain 3-cocycle $omega in H_sigma^3 ( Q , N )$ called the Postnikov class. The natural generalization of a nil-2 group in this setting is to assume that $Q$ is Abelian, and that the automorphism $sigma$ is trivial. Similar to the 2D construction, we start with a 3D triangulation with branching structure and place $bb(C) [ Q ]$ on vertices $V$ and edges $E$, and $bb(C) [ N ]$ on plaquettes $P$ and tetrahedra $T$.

$ | bb(G) chevron.r_(E P) & = upright("KW")_(E V)^Q Omega_(V P V) hat(upright("KW"))_(P T)^N |"+"chevron.r_V^Q |"+"chevron.r_T^N\
 & = chevron.l"+"|_(V T) C X_(V E)^Q Omega_(V P V) C Z_(T P)^N |"+"chevron.r_V^Q | 1 chevron.r_E^Q |"+"chevron.r_P^N |"+"chevron.r_T^N $

To define $Omega_(V P V)$ the vertices in each plaquette $p$ can be ordered using the branching structure as $v_(p 0) , v_(p 1) , v_(p 2)$. Then,

$ Omega_(V P V) & = product_p | q_(v_(p 0)) , q_(v_(p 1)) q_(v_(p 1)) , n_p macron(omega) ( q_(v_(p 0)) , macron(q)_(v_(p 0)) q_(v_(p 1)) , macron(q)_(v_(p 1)) q_(v_(p 2)) ) chevron.r chevron.l q_(v_(p 0)) , q_(v_(p 1)) q_(v_(p 1)) , n_p | $

Similarly, this construction can be thought of as gauging a $N times Q$ SPT where both symmetries are $0$-form with 4-cocycle $alpha = rho union omega$ where $rho$ is the generating class of $H^1 ( N , U ( 1 ) )$. After commuting $Omega_(V P V)$ through $hat(upright("KW"))_(P T)^N$ we obtain

$ | bb(G) chevron.r_E & = upright("KW")_(E V)^Q hat(upright("KW"))_(P T)^N Omega_(V V V T T) |"+"chevron.r_V^Q |"+"chevron.r_T^N $

where $Omega_(V V V T T)$ is the entangler for the SPT by decorating a 2D $Q$- “SPT” on $N$ domain walls

$ Omega_(V V V T T) | q_(v_(p 0)) , q_(v_(p 1)) q_(v_(p 2)) , n_(i_p) , n_(f_e) chevron.r & = chi^(macron(omega) ( q_(v_(p 0)) , macron(q)_(v_(p 0)) q_(v_(p 1)) , macron(q)_(v_(p 1)) q_(v_(p 2)) )) ( macron(n)_(t_(i_p)) n_(t_(f_p)) ) | q_(v_(p 0)) , q_(v_(p 2)) q_(v_(p 1)) , n_(i_p) , n_(f_e) chevron.r $

Here, $i_p$ and $f_p$ are tetrahedra that point into and out of the plaquette $p$.