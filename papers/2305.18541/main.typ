#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "a4", margin: (left: 1.90cm, right: 1.17cm, top: 1.91cm, bottom: 4.14cm), columns: 2)
#set figure(placement: auto)
#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show figure.where(kind: "algorithm"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9.5pt)
#set math.equation(numbering: "(1)", supplement: none)


#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#place(top + center, scope: "parent", float: true)[
#align(center)[
  #text(12pt, weight: "bold", [Many-body magic via Pauli-Markov chains - from criticality to gauge theories])   #v(1.2em)
  #text(10.5pt)[Poetri Sonya Tarabunga#super[1], Emanuele Tirrito#super[1], Titas Chanda#super[1], Marcello Dalmonte#super[1]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] The Abdus Salam International Centre for Theoretical Physics (ICTP), Strada Costiera 11, 34151 Trieste, Italy] \
  #text(9pt)[#super[2] SISSA, Via Bonomea 265, 34136 Trieste, Italy] \
  #text(9pt)[#super[3] INFN, Sezione di Trieste, Via Valerio 2, 34127 Trieste, Italy] \
  #text(9pt)[#super[4] Pitaevskii BEC Center, CNR-INO and Dipartimento di Fisica, Università di Trento, Via Sommarive 14, Trento, I-38123, Italy] \
  #text(9pt)[#super[5] Department of Physics, Indian Institute of Technology Indore, Khandwa Road, Simrol, Indore 453552, India] \
]
#v(1.2em)











#block(width: 85%)[
We introduce a method to measure many-body magic in quantum systems based on a statistical exploration of Pauli strings via Markov chains. We demonstrate that sampling such Pauli-Markov chains gives ample flexibility in terms of partitions where to sample from: in particular, it enables to efficiently extract the magic contained in the correlations between widely-separated subsystems, which characterizes the nonlocality of magic. Our method can be implemented in a variety of situations. We describe an efficient sampling procedure using Tree Tensor Networks, that exploits their hierarchical structure leading to a modest $O ( log N )$ computational scaling with system size. To showcase the applicability and efficiency of our method, we demonstrate the importance of magic in many-body systems via the following discoveries: (a) for one dimensional systems, we show that long-range magic displays strong signatures of conformal quantum criticality (Ising, Potts, and Gaussian), overcoming the limitations of full state magic; (b) in two-dimensional $bb(Z)_2$ lattice gauge theories, we provide conclusive evidence that magic is able to identify the confinement-deconfinement transition, and displays critical scaling behavior even at relatively modest volumes. Finally, we discuss an experimental implementation of the method, which only relies on measurements of Pauli observables.
]
]





= INTRODUCTION
<introduction>


Over the last two decades, quantum information concepts have revolutionized the way we understand and approach the many-body problem @nielsen2002quantum. Remarkable insights on quantum matter have been obtained under the lens of entanglement, a measure of separability that has found applications over a wide range of phenomena, from real time dynamics @Calabrese2005, to topological order @kitaev2006 @levin2006 and classification of states @chen2011 @schuh2011. A pivotal role in establishing these applications has been played by the development of trustful entanglement measures~@RevModPhys.81.865, in combination with efficient theoretical methods to explore that in the context of many-body systems~@amico2008 - one paradigmatic example being tensor networks @SCHOLLWOCK201196 @ORUS2014117.


On par with entanglement, another quantum information concept that is receiving increasing attention is that of non-stabilizerness, also known as magic @bravyi2005UniversalQuantumComputation @campbell2017roads @bravyi2012magic. In the context of quantum computing, magic is now understood as a fundamental resource that would be required to outperform classical simulations, and its concrete role in digital simulations has been widely addressed @veitch2014resource @Wootters1987 @Gross2006 @Veitch2012 @wang2019quantifying @wang2020efficiently. However, differently from entanglement, there is presently limited understanding of how magic reflects many-body phenomena, and even if it does it at all~@liu2022: a fundamental limiting factor is that, oppositely to entanglement, we lack an array of scalable, efficient methods to actually compute magic - a shortage that severely limits our capability of identifying situations where there can be a direct connection between magic and physical phenomena.


In this work, we present a theoretical framework to measure many-body magic that leverages on a stochastic sampling of the system wave function. Our work builds upon recent developments in the field, in particular, on the recognition of stabilizer Renyi entropies (SREs) as measures of magic (including an experimental demonstration with 4 qubits) @leone2022stabilizer @Oliviero_2022 @leone2023 @odavi2022complexity. While a direct measure of the former is extremely challenging as it requires a number of measurements that grows exponentially with the size of the partition, we introduce a Markov chain on Pauli strings as a tool to distill the most relevant contribution to magic. We show that our protocol returns an unbiased estimator of SREs of all orders, and that it is efficient under several important scenarios: those include both full state magic (that is relevant, e.g., to quantify the overall difference from a stabilizer state), and long-range magic - a quantity that is akin to mutual information and that, crucially, is not plagued by any UV-divergences when applied to field theory.


The estimation of magic via Pauli-Markov chain is a general construction, that is broadly applicable to computations as well as experiments. We explore in detail its capabilities in the context of tree tensor networks (TTN) ~@gerster2014 @Silvi2019. At first, we perform extensive methodological checks, in particular, on the efficiency of Markov sampling and autocorrelations. We then showcase the flexibility of our approach with several applications, to understand advantages and overall comparison with recently introduced direct sampling methods that constitute the state of the art in terms of measuring many-body magic in numerical computations~@haug2023quantifying @haug2023stabilizer @lami2023quantum.


Firstly, we consider one-dimensional systems. There, by considering both Ising, Potts and Heisenberg models, we show that full-state magic is not always indicative of quantum critical behavior. In particular, while it works for the conceptually simple cases of Ising (as already observed in Ref. @oliviero2022ising @haug2023quantifying @haug2023stabilizer @lami2023quantum) and Potts models, it spectacularly fails detecting any criticality in the case of spin-1 XXZ models. Oppositely, long-range magic (whose computation was not accessible before our algorithm, to the best of our knowledge) displays sharp signatures of critical behavior in all models considered. Our work thus clarifies how, in the context of critical behavior, it is fundamental to construct - and to compute - UV-divergence free estimators to understand the role of magic.


Secondly, we consider two-dimensional interacting systems, where the connection between magic and many-body phenomena is uncharted territory. We focus on the $bb(Z)_2$ lattice gauge theory, for two reasons: its importance as a paradigmatic model for more complicated lattice field theories, as it displays a confinement-deconfinement transition, as well as topological order; and its direct connection to the toric code, an epitome example of quantum memory based on the stabilizer language @gottesman1997stabilizer @vedral1997quantifying @gottesman1998heisenberg @gottesman1998theory @aaronson2004improved @smith2006typical @horodecki2009quantum @gutschow2010entanglement @preskill2012quantum @harrow2017quantum. Thanks to the very modest $O ( ln N )$ size-scaling of our algorithm versus system size $N$, we are able to consider systems up to 100 spins. Our results show how both confined and deconfined phase have volume-law magic: most remarkably, magic features striking signatures of critical behavior. Close to the transition point, its behavior is akin to that of a Binder cumulant, as magic density displays a crossing as a function of volume, whose functional form is dictated by finite-size scaling theory. Even more remarkably, universal collapses are not only evident at modest volumes, but even at relatively small bond dimensions, signalling that magic might be considerably less affected than other observables by tensor network truncations. At the physical level, our results point out that magic may serve as an order parameter for confinement-deconfinement transitions, even at volumes where other quantities (e.g., order parameters) are of very limited use.


Finally, we give a glimpse of the applicability of our approach to experiments. In that context, we discuss in detail experimental errors as a function of finite sampling, size, and autocorrelations. Our results indicate that the sampling needed to scale to large systems requires very fast repetition rates, which are available in solid state settings, but constitute a challenge for atomic experiments.


The rest of the paper is structured as follows. In @sec:magic, we review the basic properties of magic, as well as SREs. In @sec:monte_carlo, we describe how to sample Pauli strings via Markov chains, discuss the efficiency of various estimators, and detail our implementation with tree tensor networks. In @sec:results, we present our results on both one- and two-dimensional spin systems. In @sec:exp_protocol, we detail our experimental protocol, and then conclude in @sec:concl.


= NON-STABILIZERNESS: CHALLENGES IN MANY-BODY PHYSICS
<sec:magic>


== Quick overview of resource theory for magic
<quick-overview-of-resource-theory-for-magic>


Quantum resource theories aim to capture the fundamental aspects inherent in quantum technology. For instance, entanglement is a crucial resource for quantum cryptography and communication. The resource framework for entanglement finds practical application by providing bounds on the efficiency of entanglement distillation protocols. Error-correcting codes play a fundamental role in achieving fault-tolerant quantum computation. These codes enable the storage of quantum information while protecting it from the detrimental effects of noise.


The development of error correcting codes based on the stabilizer formalism - e.g., the toric code - has motivated a resource theory of non-stabilizerness, or magic. Here, we briefly review it, and summarize the main challenges in addressing magic in the context of many-body theory.


We first formally define the notation. We consider a system of $N$ qubits (generalizations to larger Hilbert spaces will be discussed below), with Hilbert space $cal(H) = ⊗_(j = 1)^N cal(H)_j$. The $N$-qubit Pauli group $cal(P)_N$ encompasses all Pauli string operators with an overall phase of $plus.minus i$ or $plus.minus 1$. Mathematically, we define $cal(P)_N$ as follows: $ cal(P)_N = (e^(frac(i theta pi, 2)) sigma_(j_1) ⊗ dots.h ⊗ sigma_(j_N) \| theta , j_k = 0 , 1 , 2 , 3) thin thin . $ Moving on to stabilizer states, we can establish that a pure $N$-qubit state falls into this category if it satisfies certain conditions. Specifically, a stabilizer state is associated with an abelian subgroup $cal(S) subset cal(P)_N$ that contains $2^N$ elements. For every $S in cal(S)$, the stabilizer state $|psi chevron.r$ remains unchanged under the action of $S$, expressed as $S \| psi chevron.r = \| psi chevron.r$. Alternatively, we can define stabilizers using Clifford unitaries, which are unitary transformations preserving the Pauli group when conjugated with it, i.e. $ cal(C)_N = {U upright(" s.t. ") U P U^dagger in cal(P)_N thin upright("for all") quad P in cal(P)_N} thin . $ The Clifford set $cal(C)_N$ can be generated using the Hadamard gate, the $pi / 4$-phase gate, and the CNOT gate. Notably, stabilizer states are pure quantum states that can be prepared by applying Clifford operations to a canonical trivial state $\| 0 chevron.r^(⊗ N)$.


In the framework of resource theory, stabilizer states are considered free states while Clifford unitaries and Pauli measurements constitute free operations. The computation using only free states and free operations can be efficiently classically simulated, whereas universal quantum computation can be achieved through supplying magic (non-free) states. Therefore to enable successful quantum computations, additional techniques are necessary to ensure the fault-tolerant implementation of a universal set of quantum gates. This can be achieved by augmenting the Clifford group with the Toffoli gate or the $pi / 8$ phase gate, thus unlocking the potential for universal quantum computation.


In this context, a central task is the quantification of the amount of non-Clifford operations needed to prepare a given quantum state. The properties required to a good measure $cal(M)$ of non-stabilizerness are (i) $cal(M) ( \| psi chevron.r ) = 0$ $arrow.l.r.double$ $\| psi chevron.r$ is a stabilizer, (ii) non-increasing under Clifford operations: $cal(M) ( Gamma \| psi chevron.r ) lt.eq cal(M) ( \| psi chevron.r )$ if $Gamma in cal(C)_N$, and (iii) $cal(M) ( \| psi chevron.r ⊗ \| phi.alt chevron.r ) = cal(M) ( \| psi chevron.r ) + cal(M) ( \| phi.alt chevron.r )$.


For many-body systems, previous investigations into magic measures have primarily concentrated on small or weakly correlated systems, leading to a limited understanding of magic in entangled many-body systems. An inherent challenge arises due to the exponential growth of stabilizer states and their increasingly intricate geometric structures as the system size expands. Consequently, the general calculation or numerical analysis of magic measures for large states becomes arduous. In order to enhance our understanding of this phenomenon, several fundamental questions require attention. These include comprehending the extent to which many-body quantum states can exhibit magic, determining the typical amount of magic found in generic states, and developing methodologies for computing the magic associated with many-body states.


From a quantum information viewpoint, the main motivation in understanding and measuring many-body magic stems from its relevance as a resource towards quantum advantage. Recent studies have shed light on the fact that the computational power of a state cannot be solely attributed to its magic density; other characteristics of magic may also play significant roles @liu2022. These properties encompass not only the primary aspect of magic density but also the subleading terms, nonlocal components, topological aspects, and more. Consequently, it is crucial to develop a numerical scheme capable of accessing and analyzing the various features of magic in many-body systems. Such a scheme would facilitate a comprehensive exploration and understanding of the intricate interplay between magic and computational power. This would constitute a major step forward in our endeavor to fully characterize the role played by magic in many-body systems.


Notwithstanding such practical importance, understanding the connection between quantum correlations and physical phenomena is interesting from a broader perspective~@liu2022 - especially, given the importance and impact such a connection has had in the case of entanglement. The connection between magic and physical phenomena is presently poorly understood, due to the combined lack of computable measures of magic, and of methods to attack them.


From the point of view of observables, the key result we will exploit is Ref.~@leone2022stabilizer, that demonstrated SREs as a measure of magic (at least in the case of coherent dynamics; in more complicated scenarios, such quantities are not necessarily measures, see Ref.~@haug2023stabilizer). From the point of view of connection between magic and physical phenomena, three works are serving as a key motivation in this direction~@haug2023quantifying @lami2023quantum @haug2023stabilizer. Thanks to the development of novel techniques based on direct sampling of matrix-product states (MPSs), these works have pointed out strong connections between critical behavior and magic in the context of one-dimensional systems, at precision and volumes never attained before. We will discuss this in more detail over the next section.


== Stabilizer Renyi entropy
<sec:sre>


Stabilizer Rényi Entropies (SREs) are a measure of nonstabilizerness recently introduced in Ref.~@leone2022stabilizer. For a pure quantum state $rho$, SREs are expressed in terms of the expectation values of all Pauli strings in $cal(P)_N$:


$ M_n (rho) = 1/(1-n) log { sum_(P in cal(P)_N) (|"Tr" (rho P)|^(2n)) / d^N } $
<eq:SRE_def> with $d$ is the local dimension of the Hilbert space of $N$ qudits and $cal(P)_N$ is the generalized Pauli group of $N$ qudits @Gheorghiu2014. The SREs have the following properties: @leone2022stabilizer (i) faithfulness: $M_n ( rho ) = 0$ iff $rho in upright("STAB")$, (ii) stability under Clifford unitaries $C in cal(C)_N$: $M_n ( C rho C^dagger ) = M_n ( rho )$ , and (iii) additivity: $M_n ( rho_A ⊗ rho_B ) = M_n ( rho_A ) + M_n ( rho_B )$. The SREs are thus a good magic measure in the point of view of resource theory, where the free states are defined as the stabilizer states while the free operations are the Clifford unitaries. This definition is a straightforward generalization to general local dimension $d$ from the one given in Ref. @leone2022stabilizer. For $d > 2$, the Pauli operators are no longer Hermitian, and thus the expectation values can be complex. In @eq:SRE_def, we take the absolute values of the expectation values $|"Tr" (rho P)|$. @eq:SRE_def can be seen as the Rényi-$n$ entropy of the classical probability distribution: $ Xi_P = |"Tr" (rho P)|^2 \/ d^N . $
<eq:Xi> It has the following properties: @leone2022stabilizer (i) faithfulness: $M_n ( rho ) = 0$ iff $rho in upright("STAB")$, (ii) stability under Clifford unitaries $C in cal(C)_N$: $M_n ( C rho C^dagger ) = M_n ( rho )$ , and (iii) additivity: $M_n ( rho_A ⊗ rho_B ) = M_n ( rho_A ) + M_n ( rho_B )$. The SREs are thus a good magic measure in the point of view of resource theory, where the free states are defined as the stabilizer states while the free operations are the Clifford unitaries.


Moreover, the definition of SREs can be extended to mixed states by properly normalizing $Xi_P$. For example, for $n = 2$, the mixed state SRE is given by @leone2022stabilizer $ tilde(M)_2 = -log ( (sum_(P in cal(P)_N) |"Tr" (rho P)|^4) / (sum_(P in cal(P)_N) |"Tr" (rho P)|^2) ) , $
<eq:sre_mixed> which can be seen as the Rényi-$2$ entropy of $ tilde(Xi)_P = |"Tr" (rho P)|^2 \/ (sum_(P in cal(P)_N) |"Tr" (rho P)|^2) , $
<eq:Xi_Tilde> apart from some offset. Here, the free states are defined as the mixed states that can be obtained from pure stabilizer states by partial tracing @leone2022stabilizer.


Furthermore, the long-range magic can be quantified by $ L (rho_(A B)) = tilde(M)_2 (rho_(A B)) - tilde(M)_2 (rho_A) - tilde(M)_2 (rho_B) , $
<eq:lr_magic> where $A$ and $B$ are two separated subsystems (see @fig:schematic (a)- (b)). A similar quantity has been considered previously in the context of mana @white2021 @Fliss2021 and robustness of magic @Sarkar2020 @bao2022. $L ( rho_(A B) )$ measures how magic is contained in the correlation between the subsystems, and thus it quantifies the degree to which magic cannot be removed by finite-depth quantum circuits @white2021. Indeed, due to the additivity of SRE, $L ( rho_(A B) )$ vanishes for a product state $rho_A ⊗ rho_B$. On the other hand, a non-vanishing value of $L ( rho_(A B) )$ effectively quantifies the extent of deviation from the additivity in the case of entangled subsystems.


The long-range magic is directly reminiscent of mutual information, that has played a major role in characterizing the distribution of both classical information and quantum correlations in many-body systems @nielsen2002quantum @matsuda1996mutual @PhysRevB.82.100409 @PhysRevLett.106.135701 @wilms2011mutual @wilms2012finite @PhysRevLett.100.070502 @casini2007mutual @PhysRevResearch.4.033212 @PhysRevLett.130.021603 @calabrese2004entanglement @caraglio2008entanglement @furukawa2009mutual. On the lattice, the main motivation for looking at functionals such as in @eq:lr_magic is that they are much more meaningful than simple bipartition properties from a field theory standpoint. Indeed, these quantities are expected to be free of UV divergences, and thus solely dominated by infrared, universal properties of the lattice theory. This parallels the f-functions used in field theory~@casini2004finite.


As discussed above, SREs have attracted recent interest due to their computability. The first technique was introduced in @haug2023quantifying, which expressed the SREs of integer index $n > 1$ as the norm of a "$2 n$-replica" MPS. Although this technique yields an exact value of $M_n$ within a given MPS, its computational cost scales as a large power of the bond dimension $chi$, specifically $O ( N chi^(6 n) )$. Thus, although the method is efficient in principle, in practice it can only access bond dimension up to $chi = 12$, which limits its applicability to investigate many-body physics.


A different approach based on sampling of Pauli strings according to the probability distribution $Xi_P$ was proposed very recently in @lami2023quantum @haug2023stabilizer. In those works, the Pauli strings are sampled directly via the perfect sampling scheme with Matrix Product State (MPS) introduced in @ferris2012. For the case of open boundary conditions (OBCs), the cost scales as $O ( N chi^3 )$, thus enabling access to larger bond dimensions, which opens the door for investigating magic in entangled states. However, as we discuss in more detail in the next section, this method provides only an efficient estimation of $M_1$. It has been demonstrated that for $0 < n < 2$, $M_n$ violates monotonicity under measurements followed by conditioned Clifford transformations @haug2023stabilizer. Thus, it is important to develop an efficient scheme to efficiently compute $M_2$, which also has the nice property of being experimentally measurable @leone2023 @haug2023. Furthermore, $M_2$ is directly linked to the average over the Clifford orbit of entanglement spectrum flatness in an arbitrary bipartition @tirrito2023 and participation entropy flatness @turkeshi2023measuring.


We also note that the aforementioned two methods have inherent limitations when it comes to evaluating magic within a subsystem of a state - for instance, none can access long-range magic. As a result, the existing techniques are unable to provide insights into how magic is distributed within a given state.


// [figvision-cn] imgs/SRE_example.png
// 本图为上下排列的两个曲线子图，分别标记为(a)和(b)，展示
// 不同参数n下稳定子熵密度（纵轴标注为m_n）随角度参数（横
// 轴标注为θ/π）的变化关系。 子图(a)：曲线图。横轴为θ/π，
// 刻度范围从0.0到1.0，主刻度间隔为0.2。纵轴为m_n，刻度范
// 围从0.0到0.3，主刻度间隔为0.1。图中有两条实线曲线：绿
// 色带圆点标记的曲线对应n=1，橙色带方块标记的曲线对应n=2。
// 两条曲线均呈现双峰振荡形态，在θ/π为0.0、0.5和1.0处取最
// 小值0.0，在约0.25和0.75处取峰值。n=1曲线的峰值约为0.36，
// n=2曲线的峰值约为0.29。图中无其他文字标注，仅右上角有
// 包含n=1和n=2图例的方框。 子图(b)：曲线图。横轴为θ/π，
// 刻度范围从0.0到2.0，主刻度间隔为0.5。纵轴为m_n，刻度范
// 围从0.0到0.6，主刻度间隔为0.2。图中有两条实线曲线：绿
// 色带圆点标记的曲线对应n=1，橙色带方块标记的曲线对应n=2。
// 两条曲线均呈现周期性振荡，在θ/π为0.0、约0.67和约1.33、
// 2.0处取最小值0.0，在约0.33、0.5和1.0、1.17以及1.67、
// 1.83处形成双峰结构。n=1曲线的峰值约为0.74，n=2曲线的峰
// 值约为0.60。图例位于下方中央偏右，包含n=1和n=2的标识。
// 图中无其他文字标注。 整体趋势表明，m_n随θ/π呈周期性振
// 荡，n=1时的振幅始终高于n=2时的振幅，且子图(b)的振荡频
// 率高于子图(a)。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure(image("imgs/SRE_example.png", width: 90.0%),
  caption: [
    #strong[Stabilizer entropies for qubit and qutrit.] The SRE density $m_1$ and $m_2$ for single qubit state (a) defined in the @eq:single_qubit_state, and for single qutrit state defined in @eq:single_qutrit_state (b).
  ]
)
<fig:SREs_examples>



=== Examples
<examples>
To familiarize with the behavior of SREs in many-body systems, here we provide some examples of SREs in simple wave functions. First of all, we stress that the SREs are basis-dependent, i.e., it is not invariant under local basis change. In particular, the SREs of a single-qubit state may be non-trivial. For example, consider the following one-parameter family of single-qubit states $ \| psi ( theta ) chevron.r = 1 / sqrt(2) [\| 0 chevron.r + e^(i theta) \| 1 chevron.r] thin . $<eq:single_qubit_state> Note that $\| psi ( pi / 4 ) chevron.r$ corresponds to the canonical T-state. The SREs can be computed easily by evaluating the expectation values of $P in ( I , X , Y , Z )$, and then plugging it in @eq:SRE_def. The result is shown in @fig:SREs_examples (a). As can be seen, the SREs are non-zero apart from some special points $theta = m pi / 2$ with integer $m$.


Now, the SREs of a product state of $N$ copies of $\| psi ( theta ) chevron.r$ can also be computed straightforwardly, utilizing the additivity property of SRE, $M_n ( rho_A ⊗ rho_B ) = M_n ( rho_A ) + M_n ( rho_B )$. The SREs are then just given by $M_n ( \| psi ( theta ) chevron.r^(⊗ N) ) = N M_n ( \| psi ( theta ) chevron.r )$.


For an example of qudit states, we consider the following family of single-qutrit states $ \| phi.alt ( theta ) chevron.r = 1 / sqrt(3) [\| 0 chevron.r + e^(i theta) \| 1 chevron.r + e^(- i theta) \| 2 chevron.r] thin . $<eq:single_qutrit_state> Here, $\| phi.alt ( 2 pi / 9 ) chevron.r$ corresponds to the canonical qutrit T-state. We now need to compute the expectation values of $3^2$ single-qutrit Pauli operators. To define the Pauli operators, we first define the shift and clock operators for $d$-level system as $ X = sum_(k = 0)^(d - 1) \| k + 1 chevron.r chevron.l k \| quad upright("and") quad Z = sum_(k = 0)^(d - 1) omega_d^k \| k chevron.r chevron.l k \| , $<eq:clock_shift> where $omega_d = e^(2 pi i / d)$, and the addition is defined modulo $d$. For qutrits, we have $d = 3$. The qudit Pauli operators are defined as $ T_(a a') = omega^(- 2^(- 1) a a') Z^a X^(a') $<eq:pauli_qudit> for $a , a' in bb(Z)_d$. Here, $2^(- 1)$ is the inverse element of $2$ in $bb(Z)_d$.


Computing the expectation values of the Pauli operators in @eq:pauli_qudit, we can compute the SREs of $\| phi.alt ( theta ) chevron.r$ using @eq:SRE_def. The result is shown in @fig:SREs_examples (b). In this case, the SREs are non-trivial apart from some special points $theta = m 2 pi / 3$ with integer $m$.


= MARKOV CHAIN MONTE CARLO SAMPLING OF PAULI STRINGS
<sec:monte_carlo>
In this work, we investigate the SREs using Monte Carlo sampling of Pauli strings according to some probability distribution $Pi_P$, which only depends explicitly on the expectation values of Pauli strings. For example, for the calculation of $M_n$, we get $Pi_P = Xi_P$ (@eq:Xi), while for $tilde(M)_2$ we have $Pi_P = tilde(Xi)_P$ (@eq:Xi_Tilde). Here we focus on Metropolis algorithm, although other sampling methods, such as heat bath, may also be employed. Since $Pi_P$ only depends on the expectation value of $P$, this method is applicable to any numerical methods in which expectation values of (non-local) operators can be accessed, such as exact diagonalization and tensor network methods. Furthermore, this method can also be utilized to experimentally measure SREs (see @sec:exp_protocol).


#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  numbering: "1",
  caption: [Monte Carlo sampling of Pauli strings],
  block(
    width: 100%,
    inset: (x: 10pt, y: 8pt),
    stroke: 0.5pt,
    [
      #strong[Input]: a quantum state $rho$ and number of sampling $N_S$
      #v(0.6em)
      + Initialize the Pauli string $P$.
      + Compute $"Tr" (rho P)$ and $Pi_P$.
      + *for* $i = 1$ to $N_S$ *do*
        - Propose a candidate Pauli string $P'$.
        - Compute $"Tr" (rho P')$ and $Pi_(P')$.
        - Accept the move with probability: $min (1, Pi_(P') \/ Pi_P)$.
        - Measure the estimators.
      #v(0.6em)
      #strong[Output]: a Markov chain of $P$ with probability $Pi_P$.
    ]
  )
) <alg:QA_TTN>


== Algorithm theory
<algorithm-theory>


The scheme is summarized in @alg:QA_TTN. If we sample according to $Xi_P$, $M_n$ can be estimated using the unbiased estimators $ M_n = 1/(1-n) log chevron.l |"Tr" (rho P)|^(2(n-1)) chevron.r_(Xi_P) $
<eq:estimator_n> for $n > 1$ and $ M_1 = chevron.l -log (|"Tr" (rho P)|^2) chevron.r_(Xi_P) $
<eq:estimator_1> for $n = 1$, where $chevron.l . . . chevron.r_(Xi_P)$ is the average over $Xi_P$ obtained with sampling. For $n < 1$, a better estimation can be done by reversing @eq:estimator_n, i.e., $ M_n = -1/(1-n) log chevron.l |"Tr" (rho P)|^(2(1-n)) chevron.r_(Pi_(P,n)) $
<eq:estimator_nlt1> where $Pi_(P,n) prop |"Tr"(rho_(A B) P)|^(2n)$. Let us analyze the efficiency of these estimators.


#heading(level: 4, numbering: none)[ SRE with $n = 1$.--]
<sre-with-n1.>
For $n = 1$, the variance of $M_1$ is shown to be at most quadratic in $N$ in Ref. @lami2023quantum. Thus, the estimator for $M_1$ is efficient. Actually, we can even make a stronger statement, if we make the assumption that the SREs are linear in $N$, i.e., $M_alpha = N f ( alpha ) + O ( 1 )$, where $f ( alpha )$ is a function that does not depend on $N$. Using the relation @deboer2019:
$ "Var" (M_1) = (dif^2 [(1-alpha) M_alpha]) / (dif alpha^2) bar.v|_(alpha = 1) , $ we see that $upright("Var") ( M_1 )$ is linear in $N$. It follows that the variance (standard deviation) of the SRE density, $m_1 = M_1 / N$, scales as $1 / N$ ($1 / sqrt(N)$).


#heading(level: 4, numbering: none)[ SRE with $n eq.not 1$.--]
<sre-with-n-neq-1.>
For $n > 1$, the variance of @eq:estimator_n is given by $ "Var" (|"Tr" (rho P)|^(2(n-1))) &= chevron.l |"Tr" (rho P)|^(4(n-1)) chevron.r_(Xi_P) - chevron.l |"Tr" (rho P)|^(2(n-1)) chevron.r_(Xi_P)^2 \
&= exp[-2 (n-1) M_(2n-1)] - exp[-2 (n-1) M_n] . $<eq:var> Now, by second-order approximation $upright("Var") (log x) approx upright("Var") (x) / x^2$, we have $ "Var" (M_n) &approx (exp[-2 (n-1) M_(2n-1)] - exp[-2 (n-1) M_n]) / (|n-1| exp[-2 (n-1) M_n]) \
&= (exp[2 (n-1) (M_n - M_(2n-1))] - 1) / (|n-1|) . $ For $n < 1$, $ "Var" (|"Tr" (rho P)|^(2(1-n))) = chevron.l |"Tr" (rho P)|^(4(1-n)) chevron.r_(Pi_(P,n)) \
- chevron.l |"Tr" (rho P)|^(2(1-n)) chevron.r_(Pi_(P,n))^2 \
= exp[(n-1)(M_(2-n) + M_n)] - exp[2 (n-1) M_n] . $ <eq:varn1> Then, $ "Var" (M_n) &approx (exp[(n-1)(M_(2-n) + M_n)] - exp[2 (n-1) M_n]) / (|n-1| exp[2 (n-1) M_n]) \
&= (exp[(1-n)(M_n - M_(2-n))] - 1) / (|n-1|) . $ In both cases, if the SREs grow at most logarithmically in $N$, the variance grows at most polynomially. Thus, by Chebyshev's inequality, the number of samples needed for a fixed error $epsilon.alt$ is polynomial in $N$, i.e, the estimator is efficient. On the other hand, if the SREs are linear in $N$, as is typically the case in many-body systems @oliviero2022ising @white2021 @haug2023quantifying, the variance grows exponentially with $N$ when $n eq.not 1$. Thus, the estimator for $M_n , n eq.not 1$ is efficient only if the SREs are at most $O ( log N )$. One can also see this intuitively by noting that the quantity being estimated is exponentially small in $N$ when $M_n$ is linear, and thus we need exponentially small precision. We note in passing that states with logarithmically growing SREs can arise in many-body systems in the frustrated regime @odavi2022complexity.


Note, however, that the SREs are typically linear in $N$. Therefore, using the estimators in @eq:estimator_n, the estimation of $M_n , n eq.not 1$ will almost always be exponentially costly. Nevertheless, the cost typically grows much more slowly than $d^(2 N)$ which is the cost for exact computation. Thus, in practice, using this estimator is still beneficial to extend the system sizes we can study, as we shall illustrate in @sec:results. Importantly, using Monte Carlo sampling, we are not restricted to sample the Pauli strings according to $Xi_P$. An alternative approach is to sample Pauli strings according to the probability distribution $Pi_(P,n) prop "Tr"(rho P)^(2n)$. We then need to estimate the normalization constant of $Pi_(P , n)$ to estimate $M_n$. This is a non-trivial task, equivalent to estimating the partition function, for which a wealth of sophisticated methods have been put forward @Zwanzig1954 @Bennett1976 @Chib1995 @Gelfand1994 @Diciccio1997 @Neal2001 @Meng1996SIMULATINGRO @Meng1996 @Gelman1998 @Chen2000 @wang2001 @troyer2003.


// [figvision-cn] imgs/schematic_M.png
// 该插图由三个子图（a、b、c）组成，均为示意图，用于展示
// 环状自旋链（或粒子环）上的分区（partition）方案。所有
// 子图共享相同的视觉元素：蓝色球形粒子（带黑边）通过黑色
// 实线连接成闭合圆环，黄色半透明色带表示被选中的分区区域。
// 子图 (a)：展示“完整分区”（Full partition）。一个由16个
// 蓝色粒子组成的圆环（位于图中央），整个圆环及其连线被一
// 层连续的黄色半透明圆环带完全包裹。该黄色带宽度大致覆盖
// 粒子及其连线，形成无断点的闭合环。图中无坐标轴、刻度或
// 比例尺。该子图传达的概念是：分区包含环上的所有粒子，作
// 为一个整体单元。 子图 (b)：展示“两个广泛分离的分区”（
// Two widely-separated partitions），用于计算长程魔法（
// long-range magic）。一个由16个蓝色粒子组成的圆环。黄色
// 半透明区域仅覆盖圆环左右两侧的两段弧，形成两个互不连接
// 的黄色带。左侧黄色带覆盖约4个连续粒子及其连接线，右侧
// 黄色带覆盖约4个连续粒子及其连接线。两个黄色带之间在圆
// 环顶部和底部各有一段未被黄色覆盖的粒子（各约4个粒子）。
// 图中无坐标轴、刻度或比例尺。该子图传达的概念是：将环分
// 割为两个空间上分离的局部区域，以研究非局域关联。 子图
// (c)：展示“次领头项”（Subleading term）以及主文中讨论的
// 增量技巧（increment trick）的卡通示意图。该子图包含两
// 组等式，每组由“2 ×（小环） −（大环）”构成，具体如下：
// 第一组等式：左侧为 c₈ = 2 ×（一个由4个蓝色粒子组成的正
// 方形环，被黄色带完全包裹） −（一个由8个蓝色粒子组成的
// 八边形环，被黄色带完全包裹）。该等式表示 c₈ 等于两个4
// 粒子环的贡献减去一个8粒子环的贡献。 第二组等式：左侧为
// c₁₆ = 2 ×（一个由8个蓝色粒子组成的八边形环，被黄色带完
// 全包裹） −（一个由16个蓝色粒子组成的十六边形环，被黄色
// 带完全包裹）。该等式表示 c₁₆ 等于两个8粒子环的贡献减去
// 一个16粒子环的贡献。 所有环均为闭合结构，粒子均匀分布，
// 黄色带完全覆盖对应环的所有粒子及连接线。图中无坐标轴、
// 刻度或比例尺。该子图传达的趋势是：通过“2倍小环减去大环
// ”的增量方式，可以逐级构建出更大环的次领头项系数（c₈、c
// ₁₆），体现了从局部分区到全局分区的递推关系。
#figure(image("imgs/schematic_M.png", width: 90.0%),
  caption: [
    #strong[Schematics of partitions.] (a) Full partition. (b) Two widely-separated partitions for the calculation of long-range magic in @eq:lr_magic. (c) Subleading term as in @eq:subleading, as well as a cartoon depicting the increment trick discussed in the main text.
  ]
)
<fig:schematic>



#heading(level: 4, numbering: none)[ Long-range magic.--]
<long-range-magic.>
In addition, we are interested to estimate the long-range magic as quantified by $L (rho_(A B))$ in @eq:lr_magic. While we can in principle compute the individual $tilde(M)_2$ for $rho_C$, $C in {A, B, A B}$, this is not optimal, as we have seen that the estimation for $tilde(M)_2$ is not efficient when $tilde(M)_2$ grows linearly with $N$. Moreover, we expect that the leading term of $tilde(M)_2$ will be canceled out in $L (rho_(A B))$. In this case, it is more desirable to estimate $L (rho_(A B))$ directly, without having to resort to inefficient estimation of $tilde(M)_2$. To do this, we first rewrite @eq:lr_magic as follows:

$ L (rho_(A B)) = I_2 (rho_(A B)) - W (rho_(A B)) , $

where

#block[#set text(size: 8.5pt)
$ W (rho_(A B)) = -log ( (sum_(P_A in cal(P)_A) |"Tr" (rho_A P_A)|^4 sum_(P in cal(P)_B) |"Tr" (rho_B P_B)|^4) / (sum_(P_(A B) in cal(P)_(A B)) |"Tr" (rho_(A B) P_(A B))|^4) ) $
]

and $I_2 (rho_(A B)) = S_2 (rho_A) + S_2 (rho_B) - S_2 (rho_(A B))$ is the Rényi-2 mutual information. If one is to sample according to $Pi_(P_(A B)) prop "Tr"(rho_(A B) P_(A B))^4$, we can estimate $W (rho_(A B))$ by

$ W (rho_(A B)) = -log chevron.l (|"Tr" (rho_A P_A)|^4 |"Tr" (rho_B P_B)|^4) / (|"Tr" (rho_(A B) P_(A B))|^4) chevron.r_(Pi_(P_(A B))) , $
<eq:estimator_w>

where $P_(A B)$ is decomposed as $P_(A B) = P_A ⊗ P_B$. Similarly, we have

$ I_2 (rho_(A B)) = -log chevron.l (|"Tr" (rho_A P_A)|^2 |"Tr" (rho_B P_B)|^2) / (|"Tr" (rho_(A B) P_(A B))|^2) chevron.r_(Xi_(P_(A B))) . $
<eq:estimator_i2>

Therefore, as a byproduct, our scheme can be applied to compute the Rényi mutual information for disjoint subsystems.


#heading(level: 4, numbering: none)[ Subleading term.--]
<subleading-term.>
The previous scheme can be straightforwardly modified to extract the subleading term in the expansion $M_n ( N ) = D_N N + c_N$ @haug2023quantifying. Here we consider 1D systems for simplicity. Specifically, the subleading term is approximated by the quantity $c_N = 2 M_n ( N / 2 ) - M_n ( N )$ (see @fig:schematic (c)),

#block[#set text(size: 9pt)
$ c_N = log chevron.l (|"Tr" (rho_(N/2) P^((1)))|^(2n) |"Tr" (rho_(N/2) P^((2)))|^(2n)) / (|"Tr" (rho_N P)|^(2n)) chevron.r_(Pi_(P,n)) $
<eq:subleading>
]

for $n eq.not 1$, where $rho_(N , N / 2)$ is the density matrix for a 1D system of size $N$ and $N / 2$, respectively. For simplicity, we have assumed translational invariance in @eq:subleading, but the procedure can be straightforwardly generalized to any system. Here, denoting $P = P_1 P_2 . . . P_N$, where $P_i$ is a Pauli operator acting on site $i$ in the $N -$site system, we choose $P^(( 1 )) = P_1 P_2 . . . P_(N / 2)$ and $P^(( 2 )) = P_(N / 2 + 1) P_(N / 2 + 2) . . . P_N$. Note that, differently from @eq:estimator_w, here we consider two pure states of different sizes $N$ and $N / 2$. For the subleading term in 1D systems, the term inside the log in @eq:subleading does not decay exponentially, and thus the estimation can be done more efficiently than the estimation of the leading term in @eq:estimator_n.


#heading(level: 4, numbering: none)[ Increment trick for SRE.--]
<increment-trick-for-sre.>
The extraction of the subleading term in @eq:subleading presents an alternative strategy to estimate $M_n$, which circumvents the problem of exponential variance for the estimator in @eq:estimator_n. The key idea is that, if the estimation in @eq:subleading is efficient, then we can estimate $c_N , c_(N / 2) , . . . , $ until the size is small enough that $M_n$ can be evaluated exactly. The number of $c_M$'s that needs to be computed scales as $O ( log N )$ (assuming translational invariance). Then, we can determine $M_n ( N )$ by considering a proper linear combination of $c_M$'s. This strategy is reminiscent of the increment trick employed in estimation of Rényi entanglement entropies in Quantum Monte Carlo simulations @hastings2010 @humeniuk2012 @Zhao2022, which considers the difference of Rényi entropies of smaller and smaller regions, to compute the Rényi entropy of a large entangling region with high precision. However, in this case, the form of $c_N$ is specifically designed to cancel out the volume-law term of $M_n$, differently from entanglement entropy which exhibits area law.


The above strategy is effective in 1D systems because the subleading term $c_N$ is expected to either remain independent of system size or exhibit at most logarithmic growth. However, in higher-dimensional systems, $c_N$ may exhibit area-law scaling, leading to growth with size. In this case, more complicated linear combination of $M_n$'s shall be considered to eliminate the area-law term (while, at the same time, also keeping the volume law one vanishing). For example, in 2D systems, the form of linear combination used in extracting the topological entanglement entropy with Kitaev-Preskill @kitaev2006 or Levin-Wen scheme @levin2006 will cancel both the volume-law and area-law term. It is convenient to partition the system into four subsystems as proposed in @gerster2017, which is also suitable with 2D TTN geometry. With this scheme, the estimation of $M_n ( L times L )$ is reduced to $M_n ( L / 2 times L ) , M_n ( L / 2 times L / 2 ) , . . .$, such that only $O ( log N )$ computations are required, as in 1D case#footnote[In each computation, one estimates the linear combination $gamma_(M_n) = M_n ( L times L ) - 4 M_n ( L / 2 times L ) + 4 M_n ( L / 2 times L / 2 )$, and similar form for $L / 2 times L$ geometry. This quantity can be recast into a form suitable for Monte Carlo estimation in a similar way as the subleading term in @eq:subleading.].


// [figvision-cn] imgs/TTN_schem.png
// 该图由四个子图组成，整体展示了一种基于树张量网络（Tree
// Tensor Network, TTN）的蒙特卡洛采样方法及其算符粗粒化
// 与约化过程。 子图 (a) 为二叉树型 TTN 示意图。图中圆形
// 节点表示张量，圆圈间用黑色实线连接。节点分为四层：第 0
// 层只有一个红色节点，标注为 [0,0]，代表根张量；第 1 层
// 有两个蓝色节点，分别标注 [1,0] 和 [1,1]；第 2 层有四个
// 蓝色节点，标注从 [2,0] 至 [2,3]；第 3 层有八个黄色节点，
// 未标注具体索引。图示为完全二叉树布局，每两个子节点连接
// 至其上一层的一个父节点。 子图 (b) 为主体计算流程示意。
// 左侧展示一个类似周期边界条件的 TTN 结构，八个黄色张量
// O₁ 至 O₈ 呈环形排列，环上方由五个蓝色节点和中心红色根
// 节点连接，环下方由五个蓝色节点和中心红色根节点连接。公
// 式 ⟨O₁O₂…Oᵢ…O_N⟩ = O₁ O₂ O₃ O₄ O₅ O₆ O₇ O₈ 位于其左。
// 中间方框内展示粗粒化链接算符（Coarse-graining Link
// Operators）过程，两个相邻的方形节点通过箭头映射为一个
// 方形节点，标注为 O_{[l+1,2n]} 和 O_{[l+1,2n+1]} 合并为
// O_{[l,n]}。右侧展示应用链接算符（Link Operator）后的新
// TTN 结构，黄色张量 O₁ 至 O₈ 作为底层的物理指标，顶部由
// 单层方形张量作为链接算符连接。右侧箭头表示该变换方向。
// 子图 (c) 为小型 TTN 示意图，包含一个红色根节点 [0,0]
// 及其下方两个方形子节点，整体呈倒 V 形。左侧有公式 ⟨O₁O
// ₂…Oᵢ…O_N⟩ = 。两个子节点下方各自连接红色节点 [0,0] 代
// 表指标。 子图 (d) 展示局域算符替换与约化过程。左侧的周
// 期 TTN 结构类似子图 (b)，但中间张量 Oᵢ 被替换为绿色张
// 量 O'_i，公式变为 ⟨O₁O₂…O'_i…O_N⟩ = O₁ O₂ O₃ O₄ O'_i O
// ₆ O₇ O₈。白色箭头指向右侧。中间部分展示变换后的 TTN 结
// 构，底层为黄色张量 O₁ 至 O₈，其中 O'_i 也为绿色，位于
// 中间位置，上方由红绿相间的链接算符连接。上方有文字 "
// Link Operator" 和 "New Link Operator"。第二个白色箭头
// 指向最右侧的约化 TTN，结构类似子图 (c)，包含一个红色根
// 节点 [0,0] 和两个下方子节点（一黄一绿），旁边有公式 ⟨O
// ₁O₂…O'_i…O_N⟩ = 与两侧的红色 [0,0] 指标。
#figure(scope: "parent", placement: top, image("imgs/TTN_schem.png", width: 100.0%),
  caption: [
    #strong[Efficient Monte Carlo sampling using Tree Tensor Network.] (a) Tree Tensor Network (TTN) representation of a many-body wavefunction $\| psi chevron.r$, where tensors are depicted as circles arranged in a binary-tree structure. Each tensor is identified by a pair of zero-indexed integers $\[ l , n \]$, representing its layer index $l$ and tensor index $n$ at that layer. The red circle at the top-most layer represents the root tensor having index $\[ 0 , 0 \]$, where the isometry center of the TTN is taken. (b) To evaluate the expectation value of a tensor-product of single-site operators $chevron.l O_1 O_2 dots.h O_N chevron.r$, we first place each operator $O_i$ at the physical site it acts on in the TTN representation. Then, we compute the effective link operators which live at the virtual links by the coarse-graining procedure as shown in the figure. The coarse-graining is performed iteratively from the physical sites to the top-most virtual links, which are directly connected to the root tensor. At each step, the link operators $O_(\[ l + 1 , 2 n \])$ and $O_(\[ l + 1 , 2 n + 1 \])$ are combined into $O_(\[ l , n \])$ by the $\[ l , n \]$-tensor. The resulting link operator $O_(\[ l , n \])$ acts on the $\[ l - 1 , floor.l n / 2 floor.r \]$-tensor one layer above in the TTN structure. (c) The expectation value $chevron.l O_1 O_2 dots.h O_N chevron.r$ is calculated from the contraction of the root $\[ 0 , 0 \]$-tensor and the top-lost link operators as shown in the figure. (d) Considering a modified operator which differs only at a single site from the previous one, $O_1 O_2 . . . O'_i . . . O_N$, we only need to recompute the link operators in the path from the modified physical site $i$ to the topmost link.
  ]
)
<fig:ttn>



== Efficient sampling with tensor networks: the example of tree tensor networks
<sec:ttn_sampling>


The probability $Pi_P$ of a given Pauli string $P$ only depends on the expectation value of $P$, and thus it is efficiently computable in TTN (or any loopless tensor network @Silvi2019). Following the convention introduced in Ref.~@gerster2014, each tensor in the TTN structure is denoted by the pair of zero-indexed integers $\[ l , n \]$, where $l$ corresponds to the layer index (starting from the top root tensor) and $n$ denotes the tensor at a particular layer $l$ counted from the left (see @fig:ttn\(a)). Obviously, in this notation, the top root tensor is represented by $\[ l , n \] = \[ 0 , 0 \]$.


The algorithm to sample Pauli strings for the ground state of a quantum many-body system is described below.

- After performing the adaptive variational ground-state search~@gerster2014 for a many-body Hamiltonian, we arrive at the TTN representation of the many-body ground state wavefunction $|psi chevron.r$. We start by bringing the TTN into the central canonical form, where the $\[ 0 , 0 \]$-tensor is the orthogonality center (see @fig:ttn\(a)).

- Given the initial Pauli string $P = P_1 P_2 dots.h P_N$, where $P_i$ is a Pauli operator at site $i$, we construct the coarse-grained effective "link" operators $O_(\[ l , n \])$ at each link iteratively from the physical sites to the top-most links, where at the bottom-most (i.e., the physical) layer these link operators are identified with the Pauli operators (see @fig:ttn\(b)). At each step, the link operators $O_(\[ l + 1 , 2 n \])$ and $O_(\[ l + 1 , 2 n + 1 \])$ are coarse-grained into $O_(\[ l , n \])$ by $\[ l , n \]$-tensor. The new link operator $O_(\[ l , n \])$ acts on the $\[ l - 1 , floor.l n / 2 floor.r \]$-tensor a layer above in the TTN structure. We keep all the link operators in memory for future uses.

- The expectation value $chevron.l psi \| P \| psi chevron.r$ now only involves the root $\[ 0 , 0 \]$-tensor and top-most link operators $O_(\[ 1 , 0 \])$ and $O_(\[ 1 , 1 \])$ as seen in @fig:ttn\(c).

- At each sampling step, we either propose a single-site update $P' = P_1 dots.h P'_i dots.h P_N$, or a two-site update $P' = P_1 dots.h P'_i dots.h P'_j dots.h P_N$, following @alg:QA_TTN. The updated sites $i$ and $j$ are chosen randomly.

- We observe (@fig:ttn\(d)) that the effective link operators for $P'$ only differ with those of $P$ on the links that lie on the path from the site $i$ (or $j$) to the root $\[ 0 , 0 \]$-tensor. The number of such links scales only logarithmically in system size. This implies that computing $chevron.l psi \| P' \| psi chevron.r$ can be done very efficiently with a computational cost of $O ( log ( N ) chi^4 )$, as opposed to $O ( N chi^4 )$ for a generic many-body operator for the TTN.


The heart of our efficient sampling procedure lies within the above observation for TTN. We exploit this scaling property to perform efficient Monte Carlo sampling of Pauli strings by standard Metropolis algorithm, where the candidate Pauli string for the next configuration only differs at a few sites with the previous Pauli string configuration. Crucially, the sites can be chosen arbitrarily, and this does not change the $log N$ scaling of the TTN sampling, provided that the number of modified sites does not scale with system size. This allows for flexible sampling strategy, which can be designed by taking into account our knowledge about the state that we want to sample -- very much like Monte Carlo methods are designed to probe partition functions.


The final step for calculating the expectation value of a proposed candidate Pauli string at each Metropolis iteration is the following.

- The link operators, that reside in the path from the updated site $i$ (or $j$) to the root $\[ 0 , 0 \]$-tensor, are updated by the coarse-graining step. The expectation value $chevron.l psi \| P' \| psi chevron.r$ is now calculated by tensor contractions of the root tensor and top-most (updated) link operators (see @fig:ttn\(d)).




At this stage, it is important to discuss the efficiency of the more widely used MPS tensor network structure in relation to our sampling strategy. The computational cost for direct sampling of Pauli strings using MPS with OBCs scales as $O ( N chi^3 )$~@lami2023quantum @haug2023stabilizer @ferris2012, that also holds for Monte Carlo sampling using MPS#footnote[Using the MPS structure, the cost of each iteration in Monte Carlo sampling using single-site update can be reduced from $O ( N )$ to $O ( 1 )$ in $N$ using sequential left $arrow.l.r$ right sweeps of updates, but this strategy trivially induces exploding autocorrelation time, making it unusable for practical purposes. Moreover, this sequential strategy becomes a real problem for two-site updates that are required for systems that preserves some symmetries (see @sec:results).], as opposed to the $O ( log ( N ) chi^4 )$ that we get utilizing TTN. Consequently, our method with TTN for obtaining SREs becomes increasingly efficient as the number of qudits $N$ grows large, particularly when $N / log N gt.tilde chi$. Specifically, since the MPS or the TTN bond dimension $chi$ saturates to a constant value with $N$ in 1D quantum systems with gapped spectrum due to the area-law of entanglement entropy, our approach involving TTN vastly outperforms MPS based methods in terms of efficiency for large $N$. Most importantly, the enhanced connectedness inherent in the TTN structure allows for efficient exploration of higher-dimensional (2D and even 3D) many-body systems (see e.g.,~@tagliacozzo2009 @Cataldi2021 @Felser2020 @Magnifico2021 @Felser2021). This paves the way to investigate SREs in higher-dimensional systems, as we present in @sec:results.


Finally, we mention that our scheme can also be used to compute the SREs of any partition of the system. To do this, we only need to restrict the Pauli strings to have support on the sites in the partition. Using the estimator for $n = 2$, the same Monte Carlo procedure will yield $tilde(M)_2$ in @eq:sre_mixed. Moreover, the algorithm is easily generalized to Tree Tensor Operator (TTO) @Arceci2022, which represents many-body density operator for mixed states.


We note that the use of Monte Carlo techniques in tensor network has been considered before @Schuh2008 @Sandvik2007 @ferris2012_2 to compute the expectation value of a local operator. Instead, here the expectation values are computed exactly, while the sampling is done at the level of operators being computed.


= APPLICATION TO QUANTUM MANY-BODY SYSTEMS
<sec:results>


We apply the TTN based sampling method in @sec:ttn_sampling using the estimators in @eq:estimator_n and @eq:estimator_1 to investigate the SREs in various many-body systems, especially near quantum critical points, both in 1D and 2D geometries. Unlike MPS, the structure of TTN allows for efficient exploration of systems under periodic boundary conditions (PBC) with similar computational cost as the open boundary conditions~@gerster2014. Therefore, we consider the periodic many-body systems, i.e., ring and torus geometry in 1D and 2D, respectively, to avoid boundary effects. For the analysis of statistical errors and the autocorrelation times in the Markov chain samples, we refer to the @sec:auto_corr, whereas for the analysis of convergence with bond dimension of the TTN, we refer to the @sec:bond_dim.


To obtain the TTN representation of the ground state of many-body systems we perform variational minimization with TTN sweeping algorithm @gerster2014 @Silvi2019, and then employ the sampling scheme in @sec:ttn_sampling to estimate the SREs of the ground state. In particular, since the SREs are generally linear in the number of qudits $N$, we focus on the SRE densities $m_n = M_n / N$.


All of the models we consider possess $bb(Z)_n$ symmetry, with $n = 2$ or $3$, and thus, a two-site update scheme is required to sample only the Pauli strings that preserve the symmetry. The Pauli strings that preserve the $bb(Z)_n$ symmetry, generated by $product_i Z_i$, are generated by $Z_i$ and $X_i^dagger X_j$ (up to a phase constant). Here, $X$ and $Z$ are the shift and clock operators defined in @eq:clock_shift To ensure that only the Pauli strings that obey the $bb(Z)_n$ symmetry are considered, we generate the candidate Pauli string $P'$ by randomly multiplying the current Pauli string $P$ with either $Z_i$ or $X_i^dagger X_j$. It is easy to see that the update scheme is ergodic. For $d = 3$, we set the probability to multiply with $Z_i$ or $Z_i^dagger$ to be equal, so as to satisfy detailed balance. For $d = 2$, when there is time-reversal-symmetry, the Pauli strings are additionally constrained to those with even numbers of $Y = i Z X$. As such, the Pauli strings with odd numbers of $Y$ can be directly rejected.


== Non-stabilizerness in 1D many-body systems
<non-stabilizerness-in-1d-many-body-systems>


// [figvision-cn] imgs/ising_M2_subleading.png
// 这是由两个上下排列的子图组成的科学论文插图，整体呈现了
// 在一维量子伊辛链中，不同系统尺寸下特定物理量随横场参数
// 变化的趋势。 子图 (a)： 图类型为带误差棒的离散点折线图。
// 横坐标轴标签为“h”，代表一维量子伊辛链的横场参数，数值
// 范围大致从 0.75 到 1.25，刻度间隔为 0.1，未标明具体单
// 位。纵坐标轴标签为“2M₂(L/2) - M₂(L)”，代表 Rényi-2 SRE
// 的次领头项，数值范围从 -0.5 到 0.2，刻度间隔为 0.1。图
// 中包含四组不同颜色的折线，每条折线由带有水平与垂直误差
// 棒的散点连接而成，各曲线通过不同符号和颜色区分。根据图
// 例，绿色圆形点对应系统尺寸 L=16，紫色方形点对应 L=32，
// 粉色倒三角形点对应 L=64，黄色正三角形点对应 L=128。所
// 有曲线的走势高度一致：在 h 远离 1.0 的区域（如 h<0.9
// 或 h>1.1），曲线趋于平缓，其中 L=16 的曲线数值较高（约
// 0.1 以上），L=32、64、128 的曲线在平缓区接近或略低于 0；
// 在 h 趋近于 1.0 时，所有曲线急剧下降，形成一个尖锐的 V
// 型极小值凹陷，且最小值随 L 的增大而向下延伸，L=128 的
// 最低点达到 -0.5 左右。图注显示，该子图展示了使用高效策
// 略直接估计的次领头项。此子图传达的结论是，次领头项在临
// 界点 h=1.0 附近表现出强烈的尺寸依赖性，并存在显著的凹
// 陷特征。 子图 (b)： 图类型为带误差棒的离散点折线图，主
// 图内包含一个小插图。主图横坐标轴标签为“h”，数值范围与
// (a) 相同，从 0.75 到 1.25。纵坐标轴标签为“m₂”，代表
// SRE 密度，数值范围从 0.15 到 0.30，刻度间隔为 0.05。图
// 中包含五组不同颜色的折线，带有误差棒，符号与颜色对应关
// 系为：绿色圆形对应 L=8，紫色方形对应 L=16，粉色倒三角
// 对应 L=32，黄色正三角对应 L=64，黑色右向三角对应 L=128。
// 所有曲线呈对称的钟形峰状分布：在 h 偏离 1.0 的两侧（h<
// 0.9 或 h>1.1），所有尺寸的曲线几乎重合，数值逐渐下降至
// 0.15 附近；在 h=1.0 附近，曲线达到峰值。峰值高度表现出
// 尺寸效应：L=8 时峰值最低（约 0.26），随着 L 增大，峰值
// 升高，L=32、64、128 的曲线在峰值处几乎完全重合，最高点
// 位于 0.30 以上。图注说明，该子图是使用不同的次领头项通
// 过增量法计算的临界点附近的 SRE 密度，插图展示了采样误
// 差。此子图传达的结论是，SRE 密度在临界点 h=1.0 处出现
// 峰值，且随系统尺寸增大峰值趋于饱和。 子图 (b) 的插图（
// Inset）： 位于主图右下角的曲线图。横坐标轴标签为“L”，
// 为对数近似刻度，标注了 16、32、64、128 四个数值。纵坐
// 标轴标签为“σ_{m₂}”，代表采样误差，数值范围从 0.0006 到
// 0.0010，刻度间隔为 0.0002。图中包含一条由橙色圆形数据
// 点与实线连接的单条折线。数据点显示，随着系统尺寸 L 从
// 16 增大到 128，采样误差 σ_{m₂} 从约 0.0006 逐渐上升至
// 0.0010 以上，呈单调递增趋势。此插图传达的结论是，在较
// 大系统尺寸下，该方法的采样误差随尺寸增加而增大。
#figure(image("imgs/ising_M2_subleading.png", width: 100%),
  caption: [
    #strong[Efficient estimation of Rényi-2 SRE density in 1D quantum Ising chain.] (a) The subleading term for the Rényi-2 SRE, $c_L = 2 M_2 ( L / 2 ) - M_2 ( L )$, directly estimated using the efficient scheme specified in @sec:monte_carlo, for various system-sizes in 1D quantum Ising chain. (b) The SRE density $m_2$ for the 1D quantum Ising chain near the critical point $h_c = 1$ computed using the increment method using different subleading terms. (Inset) The sampling errors for $m_2$ at $h_c = 1$ for various system-sizes $L$ (in log-scale). Clearly, the errors show even slower than than logarithmic growth for the efficient sampling scheme. Here we consider TTN bond dimension $chi = 30$ and the number of sample is $N_S = 10^6$. Error bars represent $95 "%"$ confidence interval.
  ]
)
<fig:ising_m2_subleading>



The behavior of SREs in quantum Ising chain in 1D, i.e, $ H_(upright("1D-Ising")) = - sum_(chevron.l i , j chevron.r) sigma_i^x sigma_j^x - h sum_i sigma_i^z , $<eq:1dising> with $sigma^(x , z)$ being the spin-1/2 Pauli matrices, has been studied in Refs.~@oliviero2022ising @haug2023quantifying, where it has been shown that the SRE densities peak at the critical point $h_c = 1$, and follow universal critical finite-size scaling hypothesis. In @fig:ising_m2_subleading, we show the results for Rényi-2 SRE $M_2$, estimated efficiently using the subleading term $c_L = 2 M_2 ( L / 2 ) - M_2 ( L )$ as described in @sec:monte_carlo. Surprisingly, the sampling errors of the SRE density $m_2$ scales slower than $log L$, with $L$ being the system-size, even at the critical point $h_c = 1$. Therefore, unlike the MPS-based $2 n$-replica method employed in Ref.~@haug2023quantifying that suffers from a computational cost of $O ( chi^12 )$, our Monte Carlo method for estimating $m_2$ provides accurate results without being severely limited by $chi$. Moreover, the computation of $m_2$ using the perfect sampling of MPS~@lami2023quantum @haug2023stabilizer will necessarily incur statistical errors that are exponential in system-size as the direct estimation of the subleading term $c_L = 2 M_2 ( L / 2 ) - M_2 ( L )$ is not feasible by perfect sampling.


In the following, we extend the studies of SREs in 1D quantum many-body systems to qutrit systems by considering the three-state Clock model and the spin-1 XXZ model in 1D.


=== Three-state Clock model
<sec:clock>


The quantum Clock model is a generalization of the quantum Ising model with $d$ states per site. Here we focus on the case $d = 3$, where the Hamiltonian is given by $ H_(upright("1D-Clock")) = - sum_(chevron.l i , j chevron.r) ( X_i X_j^dagger + X_i^dagger X_j ) - h sum_i ( Z_i + Z_i^dagger ) , $<eq:clock> where $X$, $Z$ are the shift and clock operators in @eq:clock with $d = 3$. The model is equivalent to the three-state Potts model @Wu1982. There is a transition from the ferromagnetic phase to the paramagnetic phase at $h_c = 1$, as in the quantum Ising model. The critical point is described by $Z_3$ parafermion CFT, with central charge $c = 4 / 5$. The exact correlation length exponent is $nu_(upright("Potts")) = 5 / 6$ @Wu1982. It is to be noted that, since the system obeys $bb(Z)_3$ symmetry, a two-site update scheme (see @sec:ttn_sampling) is required to sample the Pauli strings that preserve the symmetry. Indeed, the Pauli strings that preserve the $bb(Z)_3$ symmetry, generated by $product_i Z_i$, are generated by $Z_i$ and $X_i^dagger X_j$ (up to a phase constant).


// [figvision-cn] imgs/M1_clock.png
// 图由上下排列的两个子图组成，分别标记为(a)和(b)。 子图(
// a)为散点曲线图，展示一维量子三态Clock模型基态中的SRE密
// 度随参数h的变化。横轴为h，范围从0.7到1.3，无单位；纵轴
// 为m1（即SRE密度），范围从0.3到0.7，无单位。图中包含五
// 组数据，分别对应系统尺寸L=8（青色实心圆点，误差棒为青
// 色）、L=16（橙色方形，误差棒为橙色）、L=32（品红色倒三
// 角，误差棒为品红色）、L=64（橄榄绿色正三角，误差棒为橄
// 榄绿色）和L=128（棕色左三角，误差棒为棕色）。所有数据
// 点均带有垂直误差棒。曲线整体呈单峰结构，峰值出现在h=
// 1.0附近。L=8的曲线最平缓，峰值约0.60；随着L增大，峰值
// 升高且峰形变锐，L=128的峰值达到约0.68。在h<0.95和h>
// 1.05区域，不同L的曲线逐渐靠拢。 子图(b)为有限尺寸标度
// 塌缩图，横轴为标度变量(h - hc)L^(1/ν)，范围从-15到15，
// 无单位；纵轴为标度后的SRE密度(m1 - m1,m)L^(γ/ν)，范围
// 从-5到0，无单位。图中数据点对应L=24（青色圆点，误差棒
// 为青色）、L=32（橙色方形，误差棒为橙色）、L=48（品红色
// 倒三角，误差棒为品红色）、L=64（橄榄绿色正三角，误差棒
// 为橄榄绿色）和L=96（棕色左三角，误差棒为棕色）。所有数
// 据点塌缩到一条以横轴0为峰、向两侧近似线性下降的单一曲
// 线上，峰值处纵轴约为0。每个数据点均带有误差棒，图注说
// 明误差棒代表置信区间。该子图传达的结论是：通过标度分析
// 提取出的临界指数γ/ν和1/ν使得不同尺寸的数据重合，且关联
// 长度指数接近已知值。
#figure(image("imgs/M1_clock.png", width: 100.0%),
  caption: [
    #strong[Magic density in 1D quantum three-state Clock model.] (a) The SRE density $m_1$ in the ground-state of the three-state Clock model as a function of $h$. (b) Finite-size scaling for $m_1$. Here. $m_(1 , m)$ is the maximum $m_1$ at $h_c = 1$. We extract the critical exponent $nu approx 0.844$ and $gamma approx 0.66$. The correlation-length exponent $nu$ is close to the known $nu_(P o t t s) = 5 / 6$. We used bond dimension up to $chi = 36$ and the number of sample is $N_S = 10^6$. Error bars represent $95 "%"$ confidence interval.
  ]
)
<fig:magic_density_clock>



In the three-state Clock model, the magic density displays similar behavior as in the quantum Ising model @oliviero2022ising @haug2023quantifying, as shown in @fig:magic_density_clock\(a). Namely, $m_1$ displays maximum at the critical point $h_c = 1$. We further investigate the finite-size scaling of $m_1$, that has been done for the quantum Ising chain @haug2023quantifying, using the finite-size scaling hypothesis: $ m_1 - m_(1 , m) = L^(- gamma / nu) f (L^(1 / nu) ( h - h_c )) , $<eq:fss> where $m_(1 , m)$ is the maximum SRE density at $h_c = 1$. In @fig:magic_density_clock\(b), we show the data collapse corresponding to the finite-size scaling relation of @eq:fss, where we obtain the critical exponent $nu approx 0.844$, close to the expected theoretical value $nu_(upright("Potts")) = 5 / 6$.


=== Spin-1 XXZ chain
<sec:xxz>


Next, we consider a spin-1 XXZ chain with single-ion anisotropy, whose Hamiltonian reads $ H_(upright("XXZ")) = - sum_(chevron.l i , j chevron.r) [S_i^x S_j^x + S_i^y S_j^y + Delta S_i^z S_j^z] \
  + D sum_i ( S_i^z )^2 , $ where $S^alpha$'s, $alpha = x , y , z$, are the spin-1 operators, $Delta$ is the easy-axis anisotropy, and $D$ is the single-ion anisotropy. The model has a global $U ( 1 )$ symmetry corresponding to the conservation of total magnetization $sum_i S_i^z$, and here we consider the scenario of zero total magnetization.


The phase diagram of the model has been studied in previous works @chen2003 @Tzeng2008 @hu2011 @Langari2013. For $Delta > 0$, the model hosts three phases (with increasing $D$): the antiferromagnetic Néel order, the symmetry-protected topological (SPT) Haldane phase, and the large-$D$ trivial phase. The Néel to Haldane transition is an Ising transition, while the Haldane to large-$D$ transition is a Gaussian transition.


// [figvision-cn] imgs/M1_s1.png
// 本图由上下排列的两个子图组成，分别标记为(a)和(b)。两个
// 子图共享相同的横轴物理量D，横轴范围均为-0.5至2.0，刻度
// 间隔为0.5。两个子图中均包含两条贯穿整个绘图区的黑色垂
// 直虚线，分别位于D约为-0.36和D=1.0处。 子图(a)为曲线图，
// 展示magic density随D的变化。纵轴标签为m1，范围从0.65到
// 0.90，刻度间隔为0.05。图中包含五组离散数据点及连线，代
// 表不同系统尺寸L，图例显示：绿色圆形对应L=8，紫色方形对
// 应L=16，浅绿色倒三角对应L=32，黄色正三角对应L=64，灰色
// 左三角对应L=128。每组数据点均带有垂直误差棒，表示置信
// 区间。数据整体趋势如下：在D=-0.5时，m1值约为0.67；随后
// 在D=-0.36附近急剧上升至0.73左右；在D=0至0.5区间，曲线
// 趋于平缓，其中L=8的曲线平台值最低，约为0.78，而L≥32的
// 曲线平台值较高，约为0.87至0.88；所有曲线在D=1.0附近开
// 始下降，至D=2.0时降至0.68左右。值得注意的是，L=8的曲线
// 在D>1后下降幅度较小，且在D=1.0至1.5区间与其他尺寸的曲
// 线存在明显差异。 子图(b)为曲线图，展示long-range magic
// 随D的变化。纵轴标签为L(ρ4B)，范围从-0.4到0.4，刻度间隔
// 为0.2。图例显示三条曲线，分别对应L=32（绿色圆形）、L=
// 48（黄色方形）和L=64（灰色倒三角）。每组数据点同样带有
// 垂直误差棒。曲线在D=-0.5时接近0；在D=-0.36附近出现一个
// 明显的负谷值，约为-0.4；随后迅速回升，在D=0附近接近0；
// 在D=0至0.9区间，曲线逐渐上升形成一个峰值，峰值出现在D=
// 0.9附近，L=32的峰值最高，约为0.35，L=48和L=64的峰值略
// 低，约为0.33；在D=1.0处，曲线出现轻微的不连续或转折；
// 之后曲线逐渐下降，至D=2.0时趋近于0。所有曲线在D=1.0处
// 均显示出峰值后的快速衰减趋势。
#figure(image("imgs/M1_s1.png", width: 100.0%),
  caption: [
    #strong[Magic density and long-range magic in spin-1 XXZ chain.] (a) the magic density $m_1$ and (b) long-range magic $L ( rho_(A B) )$ of the ground-state of the spin-1 XXZ model with $Delta = 1$ as a function of $D$. We consider bond dimension up to $chi = 60$ and the number of sample is $N_S = 10^6$. Error bars represent $95 "%"$ confidence interval. The dashed vertical lines represent the best estiamtes available for the transition points.
  ]
)
<fig:magic_density_xxz>



Here, we focus on the isotropic case, i.e., $Delta = 1$. In this case, the transition is known to be at $D tilde - 0.3$ and $D tilde 0.97$ for Néel-Haldane and Haldane-large $D$ transitions, respectively @Tzeng2008 @hu2011 @Langari2013. @fig:magic_density_xxz\(a) shows the SRE density $m_1$. We observe that $m_1$ is large and rather constant in the topological Haldane phase, while it becomes smaller in the neighboring phases. Note that the maximum value of $m_1$ for a product state is $2 / 3 log ( 4 ) approx 0.92$, achieved by the tensor product of single-qutrit states, each of which has $chevron.l P chevron.r^2 = 1 / 4$ for all $P eq.not I$. Thus, it is seen that the magic in the SPT Haldane phase almost saturates the maximum value.


=== Long-range SRE
<long-range-sre>


In the spin-1 XXZ chain, while the onset of the topological Haldane phase is rather apparent from the magic density, there is no clear peak at the transitions, rendering the determination of the critical point difficult. Here we show that, unlike the magic density, the long-range magic $L_(A B)$ (see @eq:lr_magic), using the estimators in @eq:estimator_w and @eq:estimator_i2, can be used as a faithful indicator of quantum phase transitions. For the analysis of $L_(A B)$, we consider the spatially separated, extended subsystems $A = ( 1 , 2 , . . . , L / 4 )$ and $B = ( L / 2 + 1 , . . . , 3 L / 4 )$ in a perioidic chain of $L$ sites, as depicted in #ref(<fig:schematic>)b.


The long-range magic, for the the spin-1 XXZ chain, as plotted in @fig:magic_density_xxz\(b) shows clear extremums at the two transitions. Although $L ( rho_(A B) )$ is still non-zero for small $L$ away from criticality, it quickly decays to zero as the system size is increased. The peak at the Gaussian transition is very close to $D tilde 0.97$, as obtained with DMRG up to $L = 20000$ spins~@hu2011. Notably, our results are obtained with only moderate sizes, and without any prior knowledge of the order parameter. At the Ising transition, the extremum occurs at a negative value as a minimum. Unlike entanglement, the SRE is not known to satisfy subadditivity, meaning that it is not always the case that $L ( rho_(A B) ) gt.eq 0$. Nevertheless, the non-trivial value at criticality is a useful indicator for detecting criticality.


The decay of long-range SRE away from criticality can be understood through a simple physical argument. Within a gapped phase characterized by a finite correlation length, when considering two subsystems $A$ and $B$ separated by a distance exceeding the correlation length, $A$ and $B$ are approximately uncorrelated. More formally, $rho_(A B) approx rho_A ⊗ rho_B$, which implies $L ( rho_(A B) ) approx 0$. In contrast, at criticality, the correlation length becomes infinite, such that $A$ and $B$ are always correlated regardless of their distance. This results in a non-trivial value of $L ( rho_(A B) )$.


// [figvision-cn] imgs/mutualM.png
// 这是一张折线图，主图展示了一维量子伊辛链基态中的长程
// magic 随横场 h 的变化关系，并在右上角包含一个插图。主
// 图的横轴为 h，取值范围 0.00 至 2.00，刻度间隔 0.25；纵
// 轴为 L(ρ_AB)，取值范围 -0.025 至 0.175，刻度间隔 0.025。
// 图例包含四组数据，分别对应系统尺寸 L=8（青色圆点连线）、
// L=16（蓝色方块连线）、L=32（橙色倒三角连线）、L=64（灰
// 色正三角连线）。所有曲线在 h<0.5 时近乎为零，在 h 接近
// 1.0 时出现峰值，且峰值随 L 增大而升高并变尖；对于 L=8
// 和 L=16，峰值位于 h=1.0 右侧（约 1.05），而对于 L=32
// 和 L=64，峰值向 h=1.0 逼近；当 h>1.25 时，曲线单调衰减
// 趋于零，且 L 越大衰减越快。每条曲线均带有误差棒，表示
// 置信区间。插图为横轴 L（对数坐标，范围 8 至 128，刻度
// 有 8、16、32、64、128）和纵轴（范围 0.1 至 0.2，刻度
// 0.1、0.15、0.2）的曲线图，展示 h=1 时的 L(ρ_AB) 随系统
// 尺寸 L 的变化，数据点为橙色圆点连线，带有误差棒，显示
// L(ρ_AB) 随 L 增大而单调递增，从 L=8 时的约 0.12 增至 L
// =128 时的约 0.17。图中未提供比例尺，因无显微图像。该图
// 传达的核心趋势是：长程 magic 在临界点 h=1 附近达到峰值，
// 且该峰值随系统尺寸 L 的增大而增大，印证了临界点处的长
// 程特性。
#figure(image("imgs/mutualM.png", width: 100.0%),
  caption: [
    #strong[Long-range magic in 1D quantum Ising chain.] The long-range magic $L ( rho_(A B) )$ as in @eq:lr_magic in the ground state of 1D quantum Ising chain as a function of the transverse field $h$. It peaks at the critical point $h_c = 1$. (Inset) $L ( rho_(A B) )$ at $h_c = 1$ for various system sizes $L$ (in log-scale). We consider TTN bond dimension up to $chi = 30$ and the number of sample is $N_S = 10^6$. Error bars represent $95 "%"$ confidence interval.
  ]
)
<fig:lr_magic_ising>



We also come back to the quantum Ising chain (@eq:1dising), and investigate the long-range magic across the Ising transition. We observe that $L ( rho_(A B) )$ peaks at the critical point, as shown in @fig:lr_magic_ising. Furthermore, we plot $L ( rho_(A B) )$ at $h_c = 1$ in the inset of @fig:lr_magic_ising, where we see that the long-range magic grows logarithmically in $L$. In contrast, $L ( rho_(A B) )$ quickly decays away from criticality (not shown). We note that, at the critical point, we observe long autocorrelation times between samples, which is the reason for the growing errors for larger sizes. This is reminiscent of the problem of critical slowing-down in the Monte Carlo simulations at criticality @Wolff1990. It is thus interesting to develop a cluster update, akin to Wolff cluster update @Wolff1989, that may overcome this issue, which we leave for future studies.


== SRE density in 2D many-body systems: $bb(Z)_2$ lattice gauge theory
<sec:z2gauge>


Based on the favourable scaling of our scheme with system size, we investigate the non-stabilizerness in 2D systems, which so far have not been properly explored in the literature. In particular, we consider a $bb(Z)_2$ lattice gauge theory, with Hamiltonian: $ H_(bb(Z)_2 upright("-Gauge")) = - h sum_square.stroked.tiny product_(i in square.stroked.tiny) tau_i^x - sum_i tau_i^z , $<eq:z2> where the spin-1/2 Pauli operators, $tau^alpha$, $alpha = x , z$, live on the links of the square lattice. The first term is the plaquette term that flips the four spins on an elementary square plaquette of the lattice. We are interested in the charge-free sector, that satisfies the Gauss' law $ product_(i in +) tau_i^z = 1 , $<eq:gauss> on each vertices of the lattice. It is well known that the Hamiltonian in @eq:z2 is dual to the 2D transverse-field Ising model on the square lattice $ H_(upright("2D-Ising")) = - sum_(chevron.l i , j chevron.r) sigma_i^x sigma_j^x - h sum_i sigma_i^z . $<eq:ising> by Wegner duality @Wegner. Here, the spin-1/2 Pauli operators, $sigma^alpha$, $alpha = x , z$, live on the lattice sites of the dual square lattice. It can be shown that the duality transformation preserves SREs (see @sec:equivalence). This enables us to compute the SREs of the the $bb(Z)_2$ gauge theory @eq:z2 by considering the ground state of the transverse-field Ising model, which is computationally more convenient for TTNs. At the same time, our results also shed light on the transition point of the Ising model: there. the transition from ferromagnetic phase to the paramagnetic phase is known to be at $h_c tilde.eq 3.04$, as obtained with Quantum Monte Carlo @Blote2002. In the lattice gauge theory framework, such transition corresponds to confined to deconfined transition, where the behavior of Wilson loops turns from area to perimeter law.


The results for magic density for $n = 1 , 2$ are presented in @fig:magic_density_ising. It is seen that both quantities detect the transition. However, the observed behavior is very different from the 1D quantum Ising chain, which exhibits a peak at the transition. Instead, here we observe that the curves exhibit crossings at the transition.


// [figvision-cn] imgs/M1_ising.png
// 该图由两个上下排列的曲线子图组成，分别标记为(a)和(b)，
// 展示了二维规范理论在正方晶格上基态的SRE密度随参数h的变
// 化关系。 子图(a)为曲线图。横轴标注为h，范围从2.00到
// 4.00；纵轴标注为m1，范围从0.06到0.38。图例位于右上角，
// 包含四条带误差棒的曲线，分别对应不同的晶格尺寸L：绿色
// 正方形标记表示L=4，紫色倒三角形标记表示L=6，粉色正三角
// 形标记表示L=8，黄色左向三角形标记表示L=10。所有曲线在h
// =2.00处起点约为0.30，随h增大先上升，在h接近2.6附近达到
// 峰值（m1约0.36-0.37），随后下降。在下降阶段，不同L的曲
// 线发生分离，L=4的曲线下降最慢，L=10的曲线下降最快。当h
// =4.00时，m1值降至0.10至0.12之间。所有数据点均带有垂直
// 误差棒。 子图(b)为曲线图。横轴标注为h，范围从2.00到
// 4.00；纵轴标注为m2，范围从0.03到0.32。图例与(a)相同，
// 同样包含四条对应L=4、6、8、10的曲线。曲线趋势与(a)类似：
// 在h=2.00处起点约为0.22，在h接近2.6处达到峰值（m2约
// 0.28-0.29），随后下降。在下降阶段，不同L曲线的分离现象
// 比(a)更明显，L=4的曲线位于最上方，L=10的曲线位于最下方。
// 当h=4.00时，m2值降至0.04至0.05之间。所有数据点均带有垂
// 直误差棒。 图注说明使用了高达一定数值的TTN键维数以及特
// 定数量的样本，误差棒代表置信区间。两图共同传达了SRE密
// 度随h变化的非单调趋势，以及有限尺寸效应在h较大区域的影
// 响。
#figure(image("imgs/M1_ising.png", width: 100.0%),
  caption: [
    #strong[Magic densities in 2D $bb(Z)_2$ gauge theory.] The SRE desnities (a) $m_1$ and (b) $m_2$ of the ground-state of $bb(Z)_2$ gauge theory on $L times L$ square lattice as a function of $h$. We use TTN bond dimension up to $chi = 60$ and the number of sample is $N_S = 10^6$. Error bars represent $95 "%"$ confidence interval.
  ]
)
<fig:magic_density_ising>



// [figvision-cn] imgs/M1_fit.png
// 本图由上下排列的两个子图（a）和（b）组成，均为带有误差
// 棒的散点连线图，展示了二维规范理论中 SRE 密度在临界点
// 附近的有限尺寸临界标度行为。两图共享同一套图例，代表不
// 同晶格尺寸 L 的数据，具体符号与颜色对应如下：L = 4 为
// 绿色正方形，L = 5 为紫色倒三角形，L = 6 为洋红色正三角
// 形，L = 7 为黄色左向三角形，L = 8 为黑色右向三角形。每
// 个数据点均附有垂直误差棒，图例中也绘制了典型的误差棒样
// 式。 子图（a）： 横轴标签为 h，范围从 2.80 到 3.15，主
// 刻度间隔为 0.05。纵轴标签为 m₁，范围从 0.20 到 0.35，
// 主刻度间隔为 0.05。图中展示了五条随 h 增大而单调递减的
// 曲线，每条曲线对应一个系统尺寸 L。在 h 较小时（约 2.80），
// 不同 L 的 m₁ 值差异明显，L 越大 m₁ 越高（L=8 的曲线位
// 于最上方，L=4 位于最下方）。随着 h 增加，各曲线逐渐靠
// 拢，并在 h ≈ 3.00 至 3.05 之间相互交叉，交叉点附近所有
// 曲线的 m₁ 值约为 0.25。在 h 较大时（约 3.15），曲线顺
// 序反转，L 越大 m₁ 越低。该子图表明，即使使用较小的 TTN
// 键维数，SRE 密度也能很好地捕捉到相变，所有曲线在已知临
// 界点附近交汇。 子图（b）： 横轴标签为 (h - h_c)L^(1/ν)，
// 范围从 -5 到 2，主刻度间隔为 1。纵轴标签为 (m₁ - m₁,c)
// L^(γ/ν)，范围从 -0.1 到 0.2，主刻度间隔为 0.1。图中展
// 示了由不同 L 的数据经过标度变换后得到的五组数据点，所
// 有数据点均落在一条单一的、斜率为负的直线附近，从左上（
// 约 -0.1, 0.2）延伸至右下（约 2, -0.1）。该子图展示了有
// 限尺寸标度坍缩，表明通过选取临界指数 ν 和 γ，不同尺寸
// 的数据可以折叠到同一条标度曲线上。根据图注，拟合得到的
// 关联长度临界指数 ν 与已知的三维 Ising 模型值非常接近。
#figure(image("imgs/M1_fit.png", width: 100.0%),
  caption: [
    #strong[Finite-size critical scaling of SRE density in 2D $bb(Z)_2$ gauge theory.] (a) The SRE density $m_1$ near the critical point at the $bb(Z)_2$ gauge theory. Even with small TTN bond dimension $chi = 30$, $m_1$ captures the transition very well: all the curves cross near the known critical point $h_c = 3.04$. (b) Finite-size scaling of $m_1$. Here, $m_(1 , c r)$ is $m_1$ at $h = 3.04$. We find the correlation length critical exponent $nu = 0.64 plus.minus 0.05$. The extracted $nu$ is remarkably close to the known $nu_(3 D) tilde.eq 0.63$ for 3D Ising universality class. Here, the number of samples is $N_S = 10^7$.
  ]
)
<fig:magic_crit>



In @fig:magic_crit\(a), we depict $m_1$ close to the critical point, using a fixed bond dimension $chi = 30$. Remarkably, we observe that $m_1$ detects the transition point very well: all the curves cross near the critical point at $h_c = 3.04 ( 1 )$. We should highlight at this point that the TTN ansatz with such a low bond dimension of $chi = 30$ can not approximate the ground state wave function accurately near the critical point, particularly in 2D critical systems. Consequently, the standard phase transition detectors, such as the Binder cumulant, calculated from the TTN state with $chi = 30$, do not exhibit the expected critical crossing behavior -- see @sec:binderIsing2D for a direct comparison in the present case. Therefore, the remarkable observation of the perfectly crossing behavior in $m_1$ near the critical point underscores the significant value of magic in detecting and characterizing quantum phase transitions. This is particularly relevant in situations where other quantities are prone to significant errors, e.g., due to limited bond dimensions in tensor network states. While we believe that a further characterization of what the scaling resources (e.g., size and bond dimension) to detect a transition point are is outside the scope of our paper, this would be very much worth pursuing based on the Ising model results we presented.


Furthermore, we show excellent data collapse for $m_1$ in @fig:magic_crit\(b), using the finite-size scaling relation of @eq:fss, from which we extract the correlation length exponent $nu = 0.64 plus.minus 0.05$, that is close to the known $nu_(3 D) = 0.63$ for 3D (classical) Ising universality~@Blote2002.


= EXPERIMENTAL PROTOCOL
<sec:exp_protocol>


The numerical method described above can be easily adapted for experimental measurements of SREs. In particular, we can sample Pauli strings according to $Xi_P$ using Monte Carlo sampling. We note that, although the probability distribution $Xi_P$ can be sampled directly through measurements in the Bell basis @montanaro2017 @haug2023, the method requires preparation of two copies of a state and joint operations on them. In practice, this may not be feasible in some experimental platforms, or difficult to scale up to larger sizes and higher-dimensional systems. Moreover, the method only works for real wavefunctions @Gross2021. Instead, our proposal relies solely on measurements in the computational basis on a single instance of a state, and it is applicable to generic quantum states.


In experiments, the Pauli strings are measured from $N_M$ copies of $rho$ where the measurement outcomes are $A_i in ( + 1 , - 1 )$. The expectation value is then given by the average taken over the random measurement outcomes. The sampling of Pauli strings can be performed with Metropolis algorithm, similar to our numerical calculations. However, it is important to note that in experimental setups, the candidate Pauli string is not restricted to few-site updates, as is the case of TTN. This flexibility allows for multi-site updates and can potentially reduce the autocorrelation time associated with the sampling process enormously.


For a finite number of measurements $N_M$, we have that $ macron(P) = 1 / N_M sum_(i = 1)^(N_M) A_i $<eq:estimator_p> is an estimate for $chevron.l P chevron.r$. The total number of resources is thus $N_M times N_S$, where $N_S$ is the number of sampled Pauli strings. In view of @eq:var, when the SREs are at most $O ( log N )$, the required $N_S$ is polynomial in $N$. Note that $N_M$ may still be exponential, but it is expected to be no larger than $O ( d^N )$, with $d$ being the local dimension. As a result, the number of resource required in our protocol is significantly lower than the protocol in Ref. @leone2023 when the SREs are at most $O ( log N )$. Moreover, our protocol offers a possibility to measure $M_1$, in which case $N_S$ is always polynomial#footnote[It is to be noted that the measurement of $M_n$ with $n eq.not 1$ in experiments by employing the increment scheme with subleading terms, as discussed in @sec:monte_carlo, can be challenging. This procedure necessitates the simultaneous sampling from two distinct physical systems, something that is easily achievable on some platforms (optical lattices, circuit QED, tweezer arrays) but not immediately on others (e.g., ion chains). Furthermore, in experimental measurements, the obtained expectation values are only approximations of the true values. Consequently, computing ratios of these approximate values, as in @eq:subleading, introduces errors into the calculations.].


The variance of the estimator in @eq:estimator_p is given by $upright("Var") ( P ) = 1 - chevron.l P chevron.r^2$. Thus, the standard error reads


$ Delta P = sqrt(frac(1 - chevron.l P chevron.r^2, N_M)) . $ For large $N_M$, the random variable $macron(P)$ approximately has a Gaussian distribution with average $chevron.l P chevron.r$ and standard deviation $Delta P$. Note that this will introduce bias to the estimators in @eq:estimator_n and @eq:estimator_1. This bias can be made smaller by increasing $N_M$, where the estimators become unbiased in the limit $N_M arrow.r oo$.


Here, we simulate this situation numerically by perturbing the computed $chevron.l P chevron.r$ with $epsilon.alt$, where $epsilon.alt$ is a random number chosen from a Gaussian distribution centered at zero and with standard deviation $Delta P$. We would like to investigate the effects of taking finite $N_M$ and $N_S$. Here, we consider the ground state of 1D transverse-field Ising chain at $h = 1$ for concreteness. An example of the results of such a protocol is shown in @fig:exp_ising for $L = 8$ with $N_M = 500$ and $N_S = 10000$.


Next, we compute the deviation $delta m_n = \| m_(n , upright("Sim.Exp.")) - m_(n , upright("exact")) \|$ for $n = 1 , 2$, where $m_(n , upright("Sim.Exp."))$ denotes the SRE density in simulated experiments. The results are shown in @fig:exp_error. We see that, for fixed $N_S$, the error first increases for small $N_M$, before it eventually decreases. We expect this is due to the bias with finite number of Pauli measurements, as mentioned above. Indeed, as shown in @fig:exp_error\(b), we see that increasing $N_S$ while fixing $N_M$ does not result in vanishing $delta m_n$.


// [figvision-cn] imgs/M2L8.png
// 该图为一张单一坐标系的二维曲线散点图，用于展示一维量子
// 伊辛链基态中 SRE（推测为某种纠缠或关联度量）随横场参数
// h 的变化情况。横坐标为 h，取值范围从 0.4 到 1.6，无单
// 位；纵坐标为 mn，取值范围从 0.0 到 0.4，无单位。图中包
// 含两组对比数据：n=1 和 n=2 的模拟实验值（Simulated
// Exp.）与精确值（Exact）。 图例标明：橙色向上三角形代表
// n=2 的模拟实验值，橙色实线代表 n=2 的精确值；绿色向下
// 三角形代表 n=1 的模拟实验值，绿色实线代表 n=1 的精确值。
// 对于 n=1 组（绿色），精确值曲线从 h=0.4 时约 0.09 开始，
// 平滑上升至 h=1.0 附近的峰值约 0.33，随后缓慢下降至 h=
// 1.6 时的约 0.18。对应的绿色模拟实验散点分布在 h=0.4,
// 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5,
// 1.6 处，其数值系统性地高于精确值曲线，在峰值附近高出约
// 0.04 至 0.05，整体趋势与精确曲线一致但缺乏精确的定量重
// 合。 对于 n=2 组（橙色），精确值曲线从 h=0.4 时约 0.04
// 开始，上升至 h=1.0 附近的峰值约 0.26，随后下降至 h=1.6
// 时的约 0.10。对应的橙色模拟实验散点同样分布在上述 h 值
// 处，其数值在 h=0.4 至 1.2 区间内接近精确值曲线，但在 h
// =1.3 至 1.6 区间内略低于精确值曲线。图中所有散点均带有
// 黑色边框，线宽较粗，曲线平滑无标记。该图传达的趋势是：
// SRE 随 h 变化呈现先升后降的单峰结构，峰值出现在 h=1.0
// 附近；n=1 的模拟实验值整体偏高，而 n=2 的模拟实验值在
// 低 h 区吻合较好、高 h 区偏低，表明模拟实验在定量重建精
// 确值方面存在系统性偏差。
#figure(image("imgs/M2L8.png", width: 100.0%),
  caption: [
    #strong[Simulated experiment to measure SREs.] Simulation of experimental measurement of SREs in the ground state of 1D quantum Ising chain for $L = 8$. Here, $N_M = 500$ and $N_S = 10^4$.
  ]
)
<fig:exp_ising>



// [figvision-cn] imgs/M2_Nm.png
// 本图由上下排列的两个散点图子图组成，分别标记为(a)和(b)，
// 用于展示一维量子伊辛链临界点基态下SRE密度的模拟实验误
// 差随不同参数的变化。 子图(a)位于上方。横轴为 \(N_M\)，
// 采用对数刻度，范围从 \(10^2\) 到 \(10^6\)；纵轴为 \(\
// delta m_n\)，采用线性刻度，范围从 0.00 到 0.12，刻度间
// 隔为 0.02。图中共包含两组数据点：橙色向上三角形代表 \(
// n = 2\) 的情况，绿色向下三角形代表 \(n = 1\) 的情况。
// 在参数固定方面，子图(a)固定了 \(N_S\)（具体数值未在图
// 中直接标出）而改变 \(N_M\)。数据趋势显示，对于 \(n=1\)
// （绿色点），误差 \(\delta m_n\) 在 \(N_M\) 从 \(10^2\)
// 增加到约 \(10^3\) 时急剧下降至接近 0，随后在 \(N_M\)
// 继续增大时迅速上升，在 \(N_M\) 约 \(10^4\) 处达到峰值
// （超过 0.12），之后呈现震荡下降趋势，在 \(N_M\) 接近 \
// (10^6\) 时降至约 0.02。对于 \(n=2\)（橙色点），误差在
// \(N_M\) 较小时也存在一个低谷，随后上升至 \(N_M\) 约 \(
// 3\times10^3\) 时的峰值（约 0.10），之后同样呈下降趋势，
// 并在 \(N_M\) 较大时稳定在接近 0 的极低水平。 子图(b)位
// 于下方。横轴为 \(N_S\)，采用线性刻度，范围从约 1000 到
// 20000，主要刻度标记为 2500, 5000, 7500, 10000, 12500,
// 15000, 17500, 20000；纵轴同样为 \(\delta m_n\)，线性刻
// 度范围从 0.00 到 0.08，刻度间隔为 0.02。图例显示两组数
// 据均对应 \(n = 2\)：橙色向上三角形代表 \(N_M = 10^3\)，
// 绿色向下三角形代表 \(N_M = 10^5\)。子图(b)固定了 \(n=2
// \) 而改变 \(N_S\)。数据趋势表明，当 \(N_M = 10^3\)（橙
// 色点）时，随着 \(N_S\) 从 1000 增加到 5000，误差 \(\
// delta m_n\) 从约 0.07 略微下降至约 0.06，此后随 \(N_S\
// ) 继续增大，误差基本保持平稳，维持在 0.06 至 0.07 之间。
// 当 \(N_M = 10^5\)（绿色点）时，误差随 \(N_S\) 的增加而
// 显著单调下降，从 \(N_S\) 约 1000 时的 0.04 降至 \(N_S\
// ) 超过 10000 后的接近 0 的水平（约 0.005 左右），并在
// 后续 \(N_S\) 范围内保持在该低误差水平。图注指出该图展
// 示的是模拟实验中 SRE 密度的误差，偏差针对一维量子伊辛
// 链在临界点处基态的 \(\delta m_n\)。
#figure(image("imgs/M2_Nm.png", width: 100.0%),
  caption: [
    #strong[The errors in SRE density for simulated experiments.] The deviation $delta m_n = \| m_(n , upright("Sim.Exp.")) - m_(n , upright("exact")) \|$ for $n = 1 , 2$ in the ground state of 1D quantum Ising chain at the critical point $h = 1$ for $L = 16$. In (a), we fix $N_S = 10000$ and vary $N_M$, while in (b), we fix $N_M = ( 10^3 , 10^5 )$ and vary $N_S$.
  ]
)
<fig:exp_error>



= CONCLUSIONS AND OUTLOOK
<sec:concl>
We have proposed a Markov chain Monte Carlo approach to compute magic in many-body systems. We have discussed how the full state magic $M_n$ can be estimated for different values of $n$, and demonstrated the corresponding efficiency in several scenarios. Moreover, long-range magic can be estimated efficiently in general. The implementation of our algorithm is flexible and compatible with various wave-function based methods. Specifically, we have provided detailed insights into the efficiency and flexibility of our method when applied to tree tensor networks.


Through our algorithm's flexibility, we have gained valuable insights into the role of magic in many-body systems. In one-dimensional systems, we observed that full state magic is not universally associated with critical behavior. While it displays criticality signatures in certain cases like Ising and Potts models, it does not in others. However, long-range magic overcomes this limitation and consistently exhibits indications of critical behavior across all scenarios we investigated. We speculate that the functional form of long-range magic, similar to mutual information, is free of potential UV-divergences in a field theory framework.


The very mild volume scaling cost of our sampling has also enabled us the exploration of two-dimensional $bb(Z)_2$ lattice gauge theories. There, we have found that magic displays finite-volume crossings in correspondence of the confined-deconfined phase transition, and it also follows universal scaling behavior up to the volumes (100 spins) we were able to treat. Remarkably, magic was well converged even at modest bond dimensions.


Our numerical results suggest a deep connection between (long-range) magic and many-body properties, highlighting the direct links between stabilizer Renyi entropies and physical phenomena such as quantum critical behavior and confinement-deconfinement transitions. To complement our theoretical findings, we have proposed an experimental protocol for measuring stabilizer Renyi entropies solely using measurements in the computational basis.


In terms of future investigations, our technique can be extended to explore nonstabilizerness in finite-temperature scenarios by generalizing it to tree-tensor operators that efficiently represent low-temperature many-body states. In particular, it would be interesting to study the behavior of stabilizer Renyi entropies at finite-temperature phase-transition and compare it with other information-theoretic quantities, such as entanglement @Lu2020 @Lu_2019_2 @Wald_2020 @Arceci2022, quantum discord @Tarabunga2022, and quantum coherence @frerot2022. Along the same lines, another possible scenario would be applying our tools to faulty quantum circuits, recently discussed in the context of magic in Ref.~@niroula2023phase. It would also be instructive to perform a systematic investigation of magic within topological phases, extending our analysis of the Haldane phase. Another interesting perspective is to understand the role of magic in many-body quantum dynamics of closed quantum systems, whose investigation in the context of Ising models has been the subject of recent works @rattacaso2023stabilizer. In particular, our method allows for the investigation of genuine long-distance magic, that might be instrumental in establishing the presence or absence of propagation bounds for magic.


At the methodological level, our work opens a series of questions. The Markov chain Monte carlo approach could be extended to investigate other magic measures that depend only on expectation values, such as mana. Moreover, so far, we have only employed very basic sampling strategies. It would be worth exploring how different ones, such as heatbath or non-local updates, can be used to design better magic estimators since, in terms of experimental applicability, having shorter autocorrelations could considerably improve realistic implementations. In terms of efficiency of the increment trick in 2D models, it would be interesting to study whether a one-dimensional projection of 2D systems such as the one introduced in @kadowasa2023 would be beneficial. Finally, it would be interesting to understand the finer structure of sampling Pauli strings in many-body systems, that could reveal both useful insights into novel algorithms, and potentially deeper connections between many-body properties and magic.


We are indebted to M. Collura, A. Hamma, G. Lami, L. Leone, and S. F. E. Oliviero for fruitful discussions and collaborations on related topics. We thank G. Magnifico, S. Montangero, S. Notarnicola and P. Silvi for discussions on tree tensor networks. We thank L. Piroli and C. Castelnovo for comments on the manuscript. P.S.T. acknowledges support from the Simons Foundation through Award 284558FY19 to the ICTP. M.D. and E.T. acknowledge support from the MIUR Programme FARE (MEPH), and from QUANTERA DYNAMITE PCI2022-132919. M.D. work was also supported by the PNRR MUR project PE0000023-NQSTI, and by the EU-Flagship programme Pasquans2. E.T. is also funded by the European Union under Horizon Europe Programme - Grant Agreement 101080086 --- NeQST. Our TTN codes have been implemented using C++ Itensor library~@itensor22.





= AUTOCORRELATIONS AND STATISTICAL ERRORS
<sec:auto_corr>


Here, we analyzed the integrated autocorrelation time of $m_1$ and $m_2$ close to the critical point of the 2D transverse-field Ising model at $h = 3$. The integrated autocorrelation time is defined as $tau_I = 1 + 2 sum_(t = 1)^oo rho ( t )$, where $rho ( t )$ is the autocorrelation function. The integrated autocorrelation time affects the statistical errors of the averages obtained from Monte Carlo sampling @Sandvik2010. We observe that $tau_I$ is linear for $M_1$, while it saturates for $M_2$, as shown in @fig:auto_time\(a). We have also checked that $tau_I$ does not show much variation with respect to bond dimension.


Moreover, the standard deviation $sigma$ for various system sizes is shown in @fig:auto_time\(b). For $n = 2$, it is seen that $sigma$ grows exponentially, confirming the analysis in @sec:monte_carlo. On the other hand, for $n = 1$, $sigma$ is decreasing with power-law behavior (see inset). The power-law exponent is found to be compatible with $1 / 2$, again as anticipated in @sec:monte_carlo. We note here that the behavior of the integrated autocorrelation time and the standard deviations remains qualitatively similar near the critical points for other many-body systems considered here.


// [figvision-cn] imgs/auto_time.png
// 本图由上下排列的两个子图组成，分别标记为(a)和(b)，它们
// 共享横轴变量N。 子图(a)是一个折线图。横轴标记为N，表示
// 系统尺寸，范围从约10到100，主要刻度标记为20、40、60、
// 80和100。纵轴标记为τ_I，表示积分自相关时间，刻度范围从
// 0到2000，主要刻度标记为500、1000、1500和2000。图中包含
// 两条数据曲线：一条为橙色虚线连接的正三角形标记，图例中
// 标注为m_1；另一条为绿色虚线连接的倒三角形标记，图例中
// 标注为m_2。两条曲线在N约为16时均起始于约200的值。橙色
// m_1曲线随N增加呈线性上升趋势，在N=100时达到约2000。绿
// 色m_2曲线在N从16增加到约40时略有上升，随后趋于饱和，在
// N=40至80之间稳定在约400，并在N=100时略微下降至约300。
// 左下角标有“(a)”。 子图(b)也是一个折线图，下方带有嵌入
// 图。主图的横轴标记为N，范围从约10到100，主要刻度标记为
// 20、40、60、80和100。纵轴标记为σ，表示标准差，刻度范围
// 从0.075到0.150，主要刻度标记为0.075、0.100、0.125和
// 0.150。图中包含两条数据曲线：橙色虚线连接的正三角形标
// 记（m_1）和绿色虚线连接的倒三角形标记（m_2）。橙色m_1
// 曲线随N增加呈单调递减趋势，从N=16时的约0.17下降至N=100
// 时的约0.075。绿色m_2曲线在N=16到40之间从约0.08略微下降
// 至约0.075，随后随N增加而上升，在N=100时达到约0.12。两
// 条曲线在N约为64、σ约为0.1处相交。左下角标有“(b)”。 子
// 图(b)的嵌入图位于主图右上方，是一个双对数坐标图。横轴
// 为N，采用对数刻度，刻度标记为16、32、64和100。纵轴范围
// 从0.08到0.2，刻度标记为0.08、0.12、0.16和0.2。图中为橙
// 色正三角形标记的数据点，并有一条黑色实线穿过这些点，表
// 示对m_1数据的拟合。数据点随N增加而下降，在双对数坐标下
// 呈线性关系。
#figure(image("imgs/auto_time.png", width: 100.0%),
  caption: [
    #strong[Autocorrelation time and statistical errors in Monte Carlo sampling of SREs.] (a) Integrated autocorrelation time $tau_I$ at the ground state of 2D transverse-field Ising model with $h = 3$ for various system sizes $N = L times L$. It is linear for $m_1$ and saturates for $m_2$. (b) Standard deviation $sigma$ for various system sizes. Inset shows $sigma$ for $m_1$ in log-log scale. The solid line denotes a fit $sigma = a N^(- b)$ for $L gt.eq 6$, with $b = 0.503$. The standard deviation is obtained by error propagation.
  ]
)
<fig:auto_time>



= CONVERGENCE WITH BOND DIMENSION
<sec:bond_dim>
In our simulations, we have ensured that the SREs have converged with bond dimensions of the TTN in each models. To this end, we carried out simulations with different bond dimensions and verified that the SREs have sufficiently converged within statistical accuracy, which is typically on the order of $10^(- 3)$. @fig:bond_dim illustrates an example of the dependence of the SREs $m_1$ and $m_2$ for the ground state of the 2D transverse-field Ising model with linear size $L = 10$. We see that as the bond dimension $chi$ is increased, the SREs eventually converge to a constant within error bars.


// [figvision-cn] imgs/chivs.png
// 这是一张单面板折线图（子图类型：曲线图）。横轴标注为希
// 腊字母χ（键维数），范围约从5到60，刻度分别为10、20、30、
// 40、50、60，无量纲单位。纵轴标注为m_n，范围约从0.12到
// 0.34，刻度分别为0.15、0.20、0.25、0.30，无量纲单位。
// 图中共有两条带误差棒的折线，均呈现随χ增大而下降并趋于
// 饱和的趋势。右上角有图例：橙色圆点代表n=1，绿色方块代
// 表n=2。 橙线（n=1）：数据点为橙色实心圆，黑色边框，误
// 差棒为深橙色，水平短横线表示误差范围。线条为橙色实线连
// 接各点。数据点从χ≈5处m_n≈0.335开始，随χ增大缓慢下降，
// 在χ=10处约0.320，χ=20处约0.305，χ=30处约0.295，χ=40处
// 约0.290，χ=50至60处趋于平缓，最终稳定在约0.283。误差棒
// 较小，且随χ增大略为减小。 绿线（n=2）：数据点为绿色实
// 心方块，黑色边框，误差棒为深绿色，水平短横线表示误差范
// 围。线条为绿色实线连接各点。数据点从χ≈5处m_n≈0.245开始，
// 随χ增大快速下降，在χ=10处约0.200，χ=15处约0.150，χ=20
// 处约0.140，之后下降变缓，χ=30处约0.135，χ=40处约0.128，
// χ=50至60处趋于平缓，最终稳定在约0.120。误差棒在低χ处较
// 大，随χ增大逐渐减小。 该图传达的趋势是：对于n=1和n=2，
// m_n均随键维数χ的增大而收敛，在χ≥40后基本饱和；n=2的收
// 敛值（约0.120）显著低于n=1的收敛值（约0.283），且n=2在
// 低χ时的下降速率更快。
#figure(image("imgs/chivs.png", width: 100.0%),
  caption: [
    #strong[Convergence of SRE with respect to bond dimension.] SREs $m_1$ and $m_2$ at the ground state of 2D transverse-field Ising model with $h = 3$ and $L = 10$ for various bond dimension $chi$.
  ]
)
<fig:bond_dim>



= EQUIVALENCE BETWEEN 2D $bb(Z)_2$ GAUGE THEORY AND THE 2D TRANSVERSE-FIELD ISING MODEL
<sec:equivalence>


The duality transformation between @eq:z2 and @eq:ising is defined with the following transformation,
$ sigma_i^x sigma_j^x &= tau_(chevron.l i j chevron.r)^z \
sigma_i^z &= product_(i in square.stroked.tiny) tau_i^x . $<eq:ising_var> More precisely, the transformation maps the charge-free sector of @eq:z2 to the even sector of @eq:ising.


It is easy to see that the mapping in @eq:ising_var maps Pauli strings in the Ising model to Pauli strings in $bb(Z)_2$ gauge theory, because the Pauli operators on both sides of the equation generate the Pauli group in the corresponding models. Since the SREs depend only on the expectation values of Pauli strings, it follows that the SREs are preserved by the duality transformation. Therefore, the SREs in the Ising model are identical to the SREs in $bb(Z)_2$ gauge theory. It should be, however, noted that equivalence relation in case of the subsystem mixed-state SRE (e.g., $tilde(M)_2$ defined in @eq:sre_mixed), and the long-range magic thereof, is non-trivial because of the non-local nature of the transformation @eq:ising_var. Consequently, the distribution of magic within the subsystems may differ in these two theories.


It is worth nothing that the same conclusion evidently holds for other dualities that map Pauli strings to Pauli strings, such as the Kramers-Wannier duality which maps $h arrow.r h^(- 1)$ in @eq:1dising and @eq:clock. As previously discussed, the long-range magic is not preserved under the duality. This is reflected in the distinct behavior of $L ( rho_(A B) )$ for $h > 1$ and $h < 1$ in @fig:lr_magic_ising.


= BINDER CUMULANT IN 2D QUANTUM ISING MODEL WITH TTN
<sec:binderIsing2D>


// [figvision-cn] imgs/binder_2dising.png
// 这是一张单面板曲线图，展示二维量子伊辛模型中Binder累积
// 量随横场参数变化的趋势。横轴标注为h，范围从2.80至3.15，
// 主刻度间隔0.05，无单位；纵轴标注为U，范围约0.25至0.62，
// 主刻度为0.3、0.4、0.5、0.6，无单位。图中包含五条带标记
// 的实线曲线，右上角图例说明它们对应不同线性尺寸L：L=4为
// 青绿色实线配实心方块，L=5为紫色实线配向下空心三角，L=6
// 为洋红色实线配向上空心三角，L=7为金色实线配向左空心三
// 角，L=8为深灰色实线配向右空心三角。所有曲线均随h增大而
// 单调下降：在h=2.80处，U值随L增大而升高，从L=4的约0.47
// 依次升至L=8的约0.60；在h约3.04至3.06之间，五条曲线相互
// 交叉并汇聚到约0.36至0.38，交叉点附近曲线斜率随L增大而
// 变陡；在h=3.15处，U值随L增大而降低，从L=4的约0.34依次
// 降至L=8的约0.27。这一交叉行为表明该处存在临界点，不同
// 尺寸的有限尺度效应在交叉点附近最小。
#figure(image("imgs/binder_2dising.png", width: 100%),
  caption: [
    #strong[The Binder cumulant across the critical point in the 2D quantum Ising model.] Here we approximate the ground state of 2D quantum Ising model with TTN having bond dimension $chi = 30$, in parity with @fig:magic_crit.
  ]
)
<fig:binder_2dising>



In @sec:z2gauge, we have demonstrated the ability of the magic density to accurately detect and characterize the quantum critical point in the 2D $bb(Z)_2$ gauge theory, and thereby in 2D quantum Ising model. Notably, the curves of $m_1$ for different linear system-sizes exhibit a clear critical crossing behavior near the critical point $h_c = 3.04$, even with a modest TTN bond dimension of $chi = 30$. However, the same level of accuracy is not achieved when utilizing the Binder cumulant, defined as $ U = 1 - frac(chevron.l s_x^4 chevron.r, 3 chevron.l s_x^2 chevron.r^2) , quad upright("with ") s_x = 1 / L^2 sum_i sigma_i^x , $ for the 2D Ising model @eq:ising. Due to the inability of the TTN state with a small bond dimension of $chi = 30$ to faithfully represent the ground state in the vicinity of the critical point, the calculation of the Binder cumulant $U$ yields erroneous results. Consequently, the curves of $U$ for different linear system-sizes $L$ do not exhibit a clear crossing behavior near the critical point (@fig:binder_2dising). For instance, while the curves for $L = 4$ and $5$ intersect at $h = 2.98$, the intersection for $L = 7$ and $8$ occurs around $h = 3.14$. As such, if one attempts to perform finite size scaling on the Binder cumulant data, the resulting critical point and the correlation-length critical exponent $nu$ will be erroneous.

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", title: none)