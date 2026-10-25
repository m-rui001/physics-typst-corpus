#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show figure.where(kind: "algorithm"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation { [(#it)] } else { it }
}
#let thmbox(fam, name, body) = {
  let base = name.split(" ").first()
  let rest = name.slice(base.len())
  figure(
    kind: fam,
    supplement: base,
    numbering: "1",
    block(width: 100%, {
      context [*#base #counter(figure.where(kind: fam)).display()#rest.*]
      h(0.4em)
      set text(style: "italic")
      body
    }),
  )
}


#align(center)[
  #text(17pt, weight: "bold", [Diagnosing barren plateaus with tools from quantum optimal control])   #v(1.2em)
  #text(10.5pt)[Martín Larocca#super[1], Piotr Czarnik#super[2], Kunal Sharma#super[2], Gopikrishnan Muraleedharan#super[2], Patrick J. Coles#super[2], M. Cerezo#super[3]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Departamento de Física “J. J. Giambiagi” and IFIBA, FCEyN, Universidad de Buenos Aires, 1428 Buenos Aires, Argentina] \
  #text(9pt)[#super[2] Theoretical Division, Los Alamos National Laboratory, Los Alamos, New Mexico 87545, USA] \
  #text(9pt)[#super[3] Information Sciences, Los Alamos National Laboratory, Los Alamos, NM 87545, USA] \
  #text(9pt)[#super[4] Center for Nonlinear Studies, Los Alamos National Laboratory, Los Alamos, New Mexico 87545, USA] \
]
#v(1.2em)























Variational Quantum Algorithms (VQAs) have received considerable attention due to their potential for achieving near-term quantum advantage. However, more work is needed to understand their scalability. One known scaling result for VQAs is barren plateaus, where certain circumstances lead to exponentially vanishing gradients. It is common folklore that problem-inspired ansatzes avoid barren plateaus, but in fact, very little is known about their gradient scaling. In this work we employ tools from quantum optimal control to develop a framework that can diagnose the presence or absence of barren plateaus for problem-inspired ansatzes. Such ansatzes include the Quantum Alternating Operator Ansatz (QAOA), the Hamiltonian Variational Ansatz (HVA), and others. With our framework, we prove that avoiding barren plateaus for these ansatzes is not always guaranteed. Specifically, we show that the gradient scaling of the VQA depends on the degree of controllability of the system, and hence can be diagnosed through the dynamical Lie algebra $frak(g)$ obtained from the generators of the ansatz. We analyze the existence of barren plateaus in QAOA and HVA ansatzes, and we highlight the role of the input state, as different initial states can lead to the presence or absence of barren plateaus. Taken together, our results provide a framework for trainability-aware ansatz design strategies that do not come at the cost of extra quantum resources. Moreover, we prove no-go results for obtaining ground states with variational ansatzes for controllable system such as spin glasses. Our work establishes a link between the existence of barren plateaus and the scaling of the dimension of $frak(g)$.





= INTRODUCTION
<introduction>


Quantum computers hold the promise to achieve computational speed-ups over classical supercomputers for certain tasks~@shor1994algorithms @harrow2009quantum @berry2015simulating @georgescu2014quantum. However, despite recent tremendous progress in quantum technologies, present-day quantum devices (known as Noisy Intermediate-Scale Quantum (NISQ) devices) are constrained by the limited number of qubits, connectivity, and by the presence of quantum noise~@preskill2018quantum. Hence, it becomes crucial to determine what are the capabilities and limitations of NISQ computers to achieving a quantum advantage.


One of the most promising computational models for making use of near-term quantum computers are Variational Quantum Algorithms (VQAs) @cerezo2020variationalreview. Here, a task of interest is encoded into a parametrized cost function $C ( bold(theta) )$ that is efficiently computable on a noisy quantum computer. Part of the computational complexity is pushed onto classical computers by leveraging the power of classical optimizer that train the parameters $bold(theta)$ and minimize the cost. VQAs have been proposed for tasks such as solving linear systems of equations~@bravo2020variational @huang2019near @xu2019variational or performing dynamical quantum simulations~@mcardle2019variational @grimsley2019adaptive @cirstoiu2020variational @commeau2020variational @gibbs2021long @yao2020adaptive @endo2020variational @lau2021quantum, as well as for many others relevant applications~@peruzzo2014variational @farhi2014quantum @mcclean2016theory @khatri2019quantum @romero2017quantum @larose2019variational @arrasmith2019variational @cerezo2020variationalfidelity @li2017efficient @heya2019subspace @bharti2020quantum @cerezo2020variational @beckey2020variational.


Despite the wide application range of VQAs, their widespread use is still limited by several challenges that can hinder their success. For instance, it has been shown that the optimization task associated with minimizing the VQA cost function is in general an NP-hard non-convex optimization problem~@bittel2021training. Moreover, despite the typical difficulties encountered in classical non-convex optimization tasks, there are new challenges that arise when training the parameters of VQAs such as hardware noise, or the limited precision arising from a limited number of shots. These difficulties have then led to several quantum-aware optimizers being developed~@mitarai2018quantum @schuld2019evaluating @kubler2020adaptive @mcardle2019variational @stokes2020quantum @arrasmith2020operator.


In addition, certain VQAs have been shown to exhibit the so-called barren plateau phenomenon, where the cost function becomes untrainable due to gradients that vanish, on average, exponentially with the system size~@mcclean2018barren @cerezo2021cost @wang2020noise @cerezo2020impact @sharma2020trainability @arrasmith2020effect @holmes2020barren @marrero2020entanglement @patti2020entanglement @pesah2020absence @holmes2021connecting @arrasmith2021equivalence. Thus, barren plateaus have then been recognized as one of the main limitations to overcome in order to preserve the hope of achieving quantum advantage with VQAs. Recently, a great deal of effort has been put forward to developing methods that can mitigate the effect of barren plateaus~@cerezo2020cost @uvarov2020barren @volkoff2021large @verdon2019learning @grant2019initialization @skolik2020layerwise @bilkis2021semi, but ideally one would like to devise and employ VQA ansatzes which do not exhibit barren plateaus altogether.


For instance, it is known that one should avoid problem-agnostic ansatzes such as deep hardware efficient ansatzes, as these can exhibit barren plateaus due to their high expressibility~@mcclean2018barren @cerezo2021cost @holmes2021connecting. Hence, so-called problem-inspired ansatzes have been speculated to be able to overcome barren plateaus by encoding information about the problem at hand in the ansatz. Here, the intuition is that problem-inspired ansatzes constrain the space explored during the optimization to a space that either contains the solution to the problem, or that at least contains a good approximation to the solution, while maintaining a low expressibility.


In this work we employ tools from Quantum Optimal Control (QOC) to diagnose the presence or absence of barren plateaus in certain families of problem-inspired ansatzes with a periodic structure. QOC theory is a long standing theoretical framework developed to provide tools for the manipulation of quantum dynamical processes. As shown in @fig:VQA-QOC, we here make use of the fact that periodic VQAs and QOC systems can be considered as different level formulations of a common variational problem~@magann2021pulses, as both aim at driving a quantum system with a classical optimization loop. Most importantly, this connection allows us to understand and forecast the presence or absence of barren plateaus in problem-inspired variational ansatzes like the Quantum Alternating Operator Ansatz (QAOA)~@farhi2014quantum @hadfield2019quantum and the Hamiltonian Variational Ansatz (HVA)~@wecker2015progress @wiersema2020exploring. We note that the procedure is perfectly suitable for other periodic ansatzes like the adaptive QAOA~@hadfield2019quantum @zhu2020adaptive and the quantum optimal control ansatz~@choquette2020quantum. Moreover, our results also extend to quantum neural network architectures used in the quantum machine learning literature~@thanasilp2021subtleties. Our results indicate that problem-inspired ansatzes are not immune to barren plateaus, and hence that certain ansatz strategies in the literature need to be revised.


Our main results are organized into propositions and theorems that show that one can diagnose the existence of barren plateaus by analyzing the controllability of the system, i.e., by studying the Dynamical Lie Algebra (DLA) of the system. The DLA is the subspace of operator space spanned by the nested commutators of the elements in the set of generators of the ansatz (e.g., see~@dalessandro2010introduction for an introduction to quantum control theory). In an effort to give a comprehensive picture, our results follow the different controllability scenarios shown in @fig:Algebra_classification.


The manuscript is organized as follows. In @sec:VQA we present the theoretical framework for VQAs, which includes a description of the type of ansatz considered, as well as a basic review of concepts related to barren plateaus and ansatz expressibility. Then, in @sec:QOC we introduce the framework of QOC, and recall how in QOC theory the DLA of the ansatz generators is used to study the controllability of the system. @sec:main-results contains the main results of this work, while in @sec:results we present our numerical simulations. Finally, in @sec:discussions we present our discussions and conclusions.


= VARIATIONAL QUANTUM ALGORITHMS
<sec:VQA>


// [figvision] imgs/Fig1v2.png
// The figure has two main sections: Variational Quantum Algorithms (top) and Quantum Optimal Control (bottom).
// ### Variational Quantum Algorithms #### Panel a: Top section, purple box This is a schematic diagram showing
// the Variational Quantum Algorithms framework. - The left axis shows Qubits, and the right axis shows
// Measurements. - There are no numerical ranges or units on the axes. - A series of quantum gates are applied to
// the qubits, represented by a series of symbols including R_z() and . - The gates are connected by lines,
// indicating their sequence of application. - The trend shows how the quantum gates manipulate the qubits, and
// the measurements are used to update the parameters. #### Panel b: Middle section, yellow box This is a
// schematic diagram showing one layer of the Variational Quantum Algorithms framework. - The left and right axes
// are not labelled. - There are no numerical ranges or units on the axes. - A series of operations are applied,
// represented by e^{-i_{iK}H_K}. - These operations are connected in a sequence, indicating their order of
// application. - The trend shows how these operations manipulate the quantum system. ### Quantum Optimal Control
// #### Panel c: Bottom section, blue box This is a schematic diagram and a plot showing the Quantum Optimal
// Control framework. - The left axis shows the Quantum system, and the right axis shows Measurements. - There
// are no numerical ranges or units on the axes. - A control pulse f_i(t) is shown as a function of time t, with
// a time step t_j. - The control pulse is a red step function. - The trend shows how the control pulses
// manipulate the quantum system, and the measurements are used to update the controls.
#figure(image("imgs/Fig1v2.png", width: 100%),
  caption: [
    #strong[Framework for Variational Quantum Algorithms (VQA) and Quantum Optimal Control (QOC).] VQAs and QOCs can be regarded as two different levels of a theory that manipulate the evolution of a quantum system by training sets of parameters governing the system's dynamical evolution~@magann2021pulses. In VQAs (QOC) one applies a series of parametrized quantum gates (control pulses) to an input state. By gathering knowledge on the evolution via measurements on the resulting evolved state, the set of parameters (controls) are trained using a classical optimizer until a given task is completed. In this work we consider VQAs and QOC systems that have periodic structure ansatzes as in Eq.~@eq:ansatz.
  ]
)
<fig:VQA-QOC>



In this section we review the basic framework of Variational Quantum Algorithms (VQAs). In particular, we discuss a general form for ansatzes that have a periodic structure, which we consider throughout this work. Since our goal is to analyze the gradient scaling, we additionally provide an overview of the barren plateau phenomenon.


== General framework
<general-framework>


We consider an optimization task where the goal is to minimize a cost function of the form


$ C ( bold(theta) ) = upright("Tr") [ O U ( bold(theta) ) rho U^dagger ( bold(theta) ) ] thin . $<eq:cost>


Here, $rho$ is an input state on $n$ qubits in a $d$-dimensional Hilbert space with $d = 2^n$, $U ( bold(theta) )$ a parametrized quantum circuit, and $O$ is a Hermitian operator that defines the task at hand.


Throughout this work we consider layered parametrized quantum circuits that, as shown in @fig:VQA-QOC, have a periodic structure of the form


$ U ( bold(theta) ) = product_(l = 1)^L U_l ( bold(theta)_l ) , quad U_l ( bold(theta)_l ) = product_(k = 0)^K e^(- i H_k theta_(l k)) thin . $<eq:ansatz>


Here, the index $l$ indicates the layer, $bold(theta)_l = ( theta_(l 1) , dots.h , theta_(l K) )$ contains the parameters of such layer (such that $bold(theta) = { bold(theta)_l }_(l = 1)^L$), and $H_k$ are Hermitian traceless operators that generate the unitaries in the ansatz. For generality, one can also allow for certain layers to be unparametrized, in which case one would simply set certain $theta_(l k)$ to be constant. In what follows we refer to this type of ansatz as a Periodic Structure Ansatz (PSA). We refer the reader to Appendix~#ref(<sec:app:ansatzes>, supplement: none) for a detailed discussion of several ansatzes from the literature that are PSAs.


== Barren plateaus
<barren-plateaus>


Recently, it has been shown that the choice of ansatz can hinder the trainability of the parameters $bold(theta)$ for large problem sizes due to the existence of the so-called barren plateau phenomenon. In this context, deep unstructured problem-agnostic ansatz are known to exhibit barren plateaus~@mcclean2018barren @cerezo2020cost @holmes2021connecting. Hence, the design of ansatzes that overcome barren plateaus has been recognized as one of the most important challenges to guarantee the success of VQAs~@cerezo2020variationalreview, and problem-inspired ansatzes have been proposed as one of the most promising strategies. However, despite their promise, little is known about the existence of barren plateaus in problem-inspired ansatzes.


Let us now briefly recall that when the cost exhibits a barren plateau, the gradients are exponentially suppressed (on average) across the optimization landscape. This implies that an exponentially large precision is needed to navigate trough the flat landscape and determine a cost minimizing direction~@mcclean2018barren @cerezo2020cost @arrasmith2020effect. Hence, consider the following definition.


#thmbox("definition", "Definition (Barren Plateau)")[


A cost function $C ( bold(theta) )$ as in Eq.~@eq:cost is said to have a barren plateau when training $theta_mu equiv theta_(p q) in bold(theta)$, if the cost function partial derivative $partial C ( bold(theta) ) / partial theta_mu equiv partial_mu C ( bold(theta) )$ is such that


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] lt.eq F ( n ) thin , quad upright("with") quad F ( n ) in cal(O) (1 / b^n) thin , $<eq:BP>


for some $b > 1$. Here the variance is taken with respect to the set of parameters $bold(theta)$.


] <def:BP>


We refer the reader to Appendix~#ref(<sec:app:barren-plateaus>) for additional details on barren plateaus.


It is worth remarking that the barren plateau phenomenon has been linked to the expressibility of the ansatz, as it has been shown that circuits with large expressibility will exhibit small gradients~@holmes2021connecting. In this context, one can quantify the expressibility of an ansatz by comparing the distribution of unitaries obtained from $U ( bold(theta) )$ to the maximally expressive uniform (Haar) distribution $U_H$~@sim2019expressibility. Defining the $t$-th moment superoperator of the distribution generated by the ansatz $U ( bold(theta) )$,


$ M_(U ( bold(theta) ))^(( t )) = integral_(bold(theta)) d U ( bold(theta) ) thin U ( bold(theta) )^(⊗ t) ⊗ ( U^(*) ( bold(theta) ) )^(⊗ t) thin , $


we recall that its ordinary action on a given operator can be obtained by placing said operator into the center of the representation of $M_(U ( bold(theta) ))^(( t ))$ as~@caves1999quantum @rungta2001qudit


$ M_(U ( bold(theta) ))^(( t )) ( dot.op ) = integral_(bold(theta)) d U ( bold(theta) ) thin U ( bold(theta) )^(⊗ t) ( dot.op ) ( U ( bold(theta) )^dagger )^(⊗ t) thin . $


In our case, we will only be interested in second moments. For that reason, we will focus on the deviation of the second moments of the distribution generated by the ansatz $M_(U ( bold(theta) ))^(( 2 ))$ from $M_(U_H)^(( 2 ))$ the second moments of the Haar distribution, via the norm of the superoperator


$ med cal(A)_(U ( bold(theta) ))^(( t )) = M_(U_H)^(( t )) - M_(U ( bold(theta) ))^(( t )) thin . $<eq:superop>


For our purposes here, we find it convenient to define the expressibility as the infinity norm, $bar.v.double A bar.v.double_oo = lambda_max ( A )$, with $lambda_max ( A )$ the largest singular value of $A$~#footnote[The expressibility can also be defined in terms of other matrix norms such as the diamond norm or the Schatten $p$-norms. However, due to the matrix norm equivalence, if $bar.v.double cal(A)_(U ( bold(theta) ))^(( t )) bar.v.double = epsilon.alt$ for our definition, there always exists an $epsilon.alt'$ for other expressibility definitions such that the expressibility is equal to $epsilon.alt'$ and such that $epsilon.alt$ and $epsilon.alt'$ are related via a dimensionallity factor~@hunter2019unitary @nakata2014generating.]. Thus, the more expressible the ansatz, the smaller the norm $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo$, and the smaller the gradients of the cost partial derivatives~@holmes2021connecting. The limit $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = 0$ is reached when $U ( bold(theta) )$ forms a $2$-design, in which case the cost exhibits a barren plateau according to @def:BP~@mcclean2018barren @cerezo2020cost.


= QUANTUM OPTIMAL CONTROL
<sec:QOC>


Quantum Optimal Control (QOC) is a theoretical framework that provides tools for the systematic manipulation of quantum dynamical systems. The connection between VQAs and QOC has been previously established showing that one can use QOC tools to specify the parameters $bold(theta)$ at a device-level~@yang2017optimizing @magann2021pulses @meitei2020gate and to analyze VQA landscapes~@lee2021towards. Conversely, tools from VQAs have been employed to determine optimal control sequences ~@li2017hybrid. In particular, Ref.~@magann2021pulses notes that VQAs and QOC can be unified as formulations of variational optimization at the circuit level and pulse level, respectively. In addition, the framework of QOC has been employed to analyze the computational universality of quantum circuits~@ramakrishna1996relation @lloyd2018quantum @morales2020universality, as well as their reachability~@akshay2020reachability.


In QOC one is interested in controlling the dynamical evolution of a quantum state $| psi chevron.r$ in a complex $d$-dimensional Hilbert space $cal(H) = bb(C)^d$ (where $d = 2^n$)~@dalessandro2010introduction. In the typical setting, one has a Hamiltonian


$ H({f_(k)(t)}) = H_(0)+sum_(k=1)^(K) f_(k)(t)H_(k) $ <eq:QOC_Hamiltonian>


that is tunable through some time-dependent functions ${ f_k ( t ) }$, know as control fields or protocols. The fixed Hamiltonian $H_0$, usually called the drift, represents the natural or free evolution of the system, whereas the control Hamiltonians ${ H_i }$ are associated with interactions with external degrees of freedom (usually electromagnetic radiation). Thus, $| psi chevron.r$ evolves through the parametrized propagator $U ( t )$ as $| psi chevron.r ( t ) = | psi ( t ) chevron.r$. In turn, $U ( t )$ is the solution to the Schrödinger equation


$ frac(d U(t), d t)= -i H({f_(k)(t)}) U(t),quad "with" quad U(0)=bb(1)thin . $ <eq:schrodinger>


As shown in Appendix~#ref(<app:qoc>, supplement: none), under standard assumptions, the Trotrerized QOC propagator of Eq.~@eq:schrodinger is a PSA as in Eq.~@eq:ansatz.


The variety of different dynamics a quantum control system in the form of Eq.~@eq:QOC_Hamiltonian can undergo, upon variation of the control fields, is well understood though group theory. Since the Hamiltonian is Hermitian and traceless, $U ( bold(theta) )$ belongs to $cal(S) cal(U) ( d )$, the Lie group of unitary $d times d$ complex matrices that preserves the standard inner product on $cal(H)$. Surprisingly, the set of all unitaries $U ( bold(theta) )$ that can be accessed by such a control system forms itself a Lie group, known as the #emph[dynamical Lie group] $bb(G) subset.eq cal(U) ( d )$. Hence, a natural question which arises is: how can this group be determined?


First, let us define the set of generators.


#thmbox("definition", "Definition (Set of generators)")[ Given a parametrized quantum circuit of the form in Eq.~@eq:ansatz we define the set of generators $cal(G) = { H_k }_(k = 0)^K$ as the set (of size $| cal(G) | = K + 1$) of the (traceless) Hermitian operators that generate the unitaries in a single layer of $U ( bold(theta) )$.


] <def:generators>


Naturally, the group $bb(G)$ depends on the set of generators $cal(G)$, yet it is not sufficient to look at the individual elements of $cal(G)$. Instead, one must consider the Lie algebra that emerges from their nested commutators. Hence, consider the following definition @zeier2011symmetry.


#thmbox("definition", "Definition (Dynamical Lie Algebra)")[ Given a control system with generators $cal(G)$ (see @def:generators), the Dynamical Lie Algebra (DLA) $frak(k)$ is the subalgebra of $frak(s) frak(u) ( d )$ spanned by the repeated nested commutators of the elements in $cal(G)$, i.e.,


$ frak(k) = upright("span") ⟨i H_0 , dots.h , i H_K⟩_(upright("Lie")) thin subset.eq frak(s) frak(u) ( d ) , $


where $⟨S⟩_(upright("Lie"))$ denotes the Lie closure, i.e., the set obtained by repeatedly taking the nested commutators between the elements in $S$.


] <def:dynamical-lie-algebra>


Here, $frak(s) frak(u) ( d )$ is the special unitary algebra of degree $d$, the Lie algebra formed by the set of $d times d$ skew-Hermitian, traceless matrices. In Appendix~#ref(<app:alg>, supplement: none), we lay down the basic procedure to build DLAs (see Algorithm~#ref(<alg:lie>, supplement: none)) and provide some discussion on the complexity of such construction.


Once the DLA is obtained from the set of generators, one can determine the set of unitaries that are expressible by the control system. Specifically, one can now properly define the dynamical Lie group as follows.


#thmbox("definition", "Definition (dynamical Lie group)")[


The set unitaries $bb(G)$ that can be generated by a control system is determined by its DLA (see Definition~#ref(<def:dynamical-lie-algebra>, supplement: none)) through~#footnote[This is grounded in the fact that every possible DLA is a subalgebra of the special unitary algebra $frak(s u) ( d )$ and therefore compact. The exponential map is a function $e : frak(k) arrow.r bb(G)$. If $frak(k)$ is compact then the exponential map is surjective: every element of $bb(G)$ is the image of at least one element of $frak(k)$.]


$ bb(G) = e^(frak(k)) := ( e^V , med med V in frak(k) ) thin . $


] <def:dynamical-lie-group>


The dynamical Lie group in turn determines the set of states $| psi ( bold(theta) ) chevron.r = U ( bold(theta) ) | psi chevron.r$ that can be reached by evolving an initial state $| psi chevron.r$. Specifically, here $U ( bold(theta) )$ can attain values in the Lie group $bb(G)$. In addition, Definition~#ref(<def:dynamical-lie-group>, supplement: none) crucially shows that one can study the expressibility of a control system (i.e., the unitaries that can be generated, or the set of states that can be reached) via the DLA obtained from the set of generators. As shown in @fig:Algebra_classification, when computing $frak(k)$ there are several cases of interest that can arise and which we here consider. For the sake of clarity, in what follows we briefly recall several key concepts that will be useful throughout the manuscript. We refer the reader to~@dalessandro2010introduction for additional details.


First and foremost, we recall the concept of #emph[controllability]. A control system is said to be #emph[controllable] if its DLA is full rank, i.e., $frak(k) = frak(s u) ( d )$. This implies that $bb(G) = cal(S) cal(U) ( d )$ and hence every unitary (up to a phase) can be obtained by appropriately choosing control parameters in Eq.~@eq:QOC_propagator. In particular, this means that for any two states $| psi chevron.r$ and $| phi.alt chevron.r$, there always exists a unitary $U ( bold(theta) ) in bb(G)$ such that $U ( bold(theta) ) | psi chevron.r = | phi.alt chevron.r$.


// [figvision] imgs/Fig_ALgebras_New.png
// The figure is a flowchart with a tree-like structure. * It has one starting node at the top and branches into
// two, then further into more branches. The figure has no quantitative data. a. The top node is labeled
// "Dynamical Lie algebra g". It branches into two nodes: - The left node is labeled "Controllable g is simple
// and full rank g = su(d)", - The right node is labeled "Uncontrollable g is a proper subalgebra g ⊂ su(d)". b.
// The "Uncontrollable" node branches into two nodes: - The left node is labeled "Reducible g has symmetries → it
// is a direct sum g = g1 ⊕…⊕ gM", - The right node is labeled "Irreducible g has no symmetries". c. The
// "Reducible" node branches into two nodes: - The left node is labeled "Subspace controllable gj is full rank gj
// = su(dj)", - The right node is labeled "Subspace uncontrollable No gj is full rank gj ⊂ su(dj)".
#figure(image("imgs/Fig_ALgebras_New.png", width: 100%),
  caption: [
    #strong[Cases of interest for the Dynamical Lie Algebra.] The Dynamical Lie Algebra (DLA) $frak(k)$ determines the set of unitaries expressible, and concomitantly, the set of states reachable. In this figure we show different scenarios that can arise when computing $frak(k)$. Our main results (on gradient scaling of VQAs and QOC systems) pertain to these different scenarios.
  ]
)
<fig:Algebra_classification>



If the DLA is not full rank, then the system is said to be #emph[uncontrollable]. In this case $frak(k)$ is a #emph[proper] subalgebra of $frak(s u) ( d )$, and only a #emph[proper] subgroup $bb(G) subset cal(S) cal(U) ( d )$ is available to the control system, meaning that the set of reachable states $( U ( bold(theta) ) | psi chevron.r , quad forall thin U ( bold(theta) ) in bb(G) )$ is not the whole state space. As depicted in @fig:Algebra_classification, there are two sources of uncontrollability @polack2009uncontrollable.


On one hand, if the generators in $cal(G)$ share one or more common symmetries, i.e., there is at least one Hermitian operator $Sigma$ that commutes with every element in $cal(G)$, then every $H in frak(k)$ is block diagonal in the eigenbasis of $Sigma$. This causes the state space to break into subspaces that are invariant under the action of $frak(k)$, in which case controllability is clearly disrupted. Here, the DLA is a #emph[reducible] representation of some Lie algebra. On the other hand, even in the absence of symmetries, that is, when the DLA is #emph[irreducible], uncontrollability can arise simply because the Lie algebra is a proper subalgebra of $frak(s u) ( d )$.


Let us finally remark that, as shown in @fig:Algebra_classification, even though a reducible system cannot be controllable on the entire Hilbert space it may still be controllable on some (or all) of the invariant subspaces. Given a DLA that is a direct sum of irreducible representations, i.e., $frak(k) = x⋁_j frak(k)_j$, then the Hilbert space can be expressed as $cal(H) = x⋁_j cal(H)_j$, with $cal(H)_j$ being invariant under the action of $frak(k)$. A system is said to be #emph[subspace controllable] on subspace $cal(H)_j$ if $frak(k)_j$ is full rank, i.e., $frak(k)_j = frak(u) ( d_j )$, where $d_j = upright("dim") ( cal(H)_j )$) and $frak(u) ( d_j )$ denotes the unitary algebra of degree $d_j$.


= MAIN RESULTS
<sec:main-results>


As previously discussed, VQAs and QOC can be considered as two formulations of a common variational optimization problem that optimizes parameters controlling the dynamical evolution of a quantum system. In this section we present our main results, where we basically leverage tools from QOC to analyze the trainability and the existence of barren plateaus in VQAs. Specifically, we organize our results in term of the different controllability settings shown in @fig:Algebra_classification. In all cases, the proofs are presented in the Appendix. The main idea behind our results is that, given a PSA $U ( bold(theta) )$ as in Eq.~@eq:ansatz, the study of the DLA of the ansatz can diagnose the presence (or absence) of barren plateaus in the VQA landscapes.


== Controllable systems
<controllable-systems>


First, let us consider controllable systems. It is well known that the distribution of unitaries generated by controllable systems converges to a $2$-design in the long-time (i.e., for sufficiently deep circuits)~@banchi2017driven. However, the rate of convergence actually depends on the specific choice of generators. Hence, our first result analyzes the depth at which the expressibility $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo$ of a controllable system is $epsilon$ small.


#thmbox("theorem", "Theorem")[


Consider a controllable system. Then, the PSA $U ( bold(theta) )$ will form an $epsilon$-approximate $2$-design, i.e. $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = epsilon$ with $epsilon.alt > 0$, when the number of layers $L$ in the circuit is


$ L = frac(log ( 1 / epsilon ), log (1 / bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo)) thin . $<eq:depth>


Here $bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo$ denotes the expressibility of a single layer $U_1 ( bold(theta)_1 )$ of the ansatz according to Eqs.~@eq:ansatz and~@eq:superop.


] <theo:depth>


See Appendix~#ref(<app:proof_theo_convergence>, supplement: none) for a proof of @theo:depth.


We note that @theo:depth arises from the following expression that connects the expressibility of an $L$-layered PSA to the expressibility of a single layer of the ansatz to the $L$-th power as


$ bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = (bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo)^L thin . $


Here we can see that $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = 0$ if and only if $bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo = 0$. Hence, as expected, PSAs that have more expressible layers require less depth to have an $epsilon$-expressibility (to be $epsilon$-approximate $2$-designs). Conversely, one can also see that ansatzes with less expressible layers require more depth to become $epsilon$-approximate $2$-design.


The following corollary analyzes the scaling of $L$.


#thmbox("corollary", "Corollary")[


Let the single layer expressibility of a controllable system be $bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo = 1 - delta ( n )$, with $delta ( n )$ being at most polynomially vanishing with $n$, i.e., with $delta ( n ) in Omega ( 1 / "poly" ( n ) )$. Then, if $L ( n ) in Omega ( n / delta ( n ) )$, $U ( bold(theta) )$ will be no worse than an $epsilon ( n )$-approximate $2$-design (i.e., $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo lt.eq epsilon ( n )$) with $epsilon ( n ) in cal(O) ( 1 / 2^n )$, where we have added the $n$-dependence in $L$ and $epsilon$ for clarity.


] <cor:Lscaling>


See Appendix~#ref(<app:proof_corollary_convergence>, supplement: none) for a proof of @cor:Lscaling.


From @cor:Lscaling we have that when the single layer expressibility is (at most) polynomially vanishing with $n$, then a polynomial number of layers suffice to make the PSA $U ( bold(theta) )$ exponentially close to being a $2$-design. We note, however, that in the case where the single layer expressibility is exponentially close to $1$, one requires an exponential number of layers to form an $epsilon$-approximate $2$-design. In all the aforementioned cases it is worth remarking that an exponential number of layers will always lead to $epsilon$-approximate $2$-designs with $epsilon in cal(O) ( 1 / 2^n )$, independently of the value of $bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo$.


Once the depth of the ansatz is sufficient for the controllable system to be an $epsilon$-approximate $2$-design, then a barren plateau will arise. Hence, one can prove the following proposition from @theo:depth and @cor:Lscaling.


#thmbox("proposition", "Proposition (Controllable)")[


There exists a scaling of the depth for which controllable systems form $epsilon$-approximate $2$-designs with $epsilon in cal(O) ( 1 / 2^n )$, and hence the system exhibits a barren plateau according to @def:BP.


] <prop:controllable>


See Appendix~#ref(<app:proof_prop_controllable>, supplement: none) for a proof of @prop:controllable.


@prop:controllable rephrases the well known barren plateau results of~@mcclean2018barren @holmes2021connecting in terms of controllability. Specifically, it has been shown that when an ansatz forms a $2$-design, such randomness leads to a barren plateau. Hence, the proof of @prop:controllable simply follows the proof in~@mcclean2018barren, with the addition that the convergence to a $2$-design comes from the fact that the system is controllable.


Evidently, it becomes relevant to determine systems that are controllable as these can exhibit barren plateaus. In this work we prove that two relevant sets of generators lead to full rank DLAs, and hence to controllable systems.


#thmbox("proposition", "Proposition")[


The following two sets of generators generate full rank DLAs, and concomitantly lead to controllable systems:

- $cal(G)_(upright("HEA")) = ( X_i , Y_i )_(i = 1)^n ⋃ {sum_(i = 1)^(n - 1) Z_i Z_(i + 1)}$,

- $cal(G)_(upright("SG")) = (sum_(i = 1)^n X_i , sum_(i < j) (h_i Z_i + J_(i j) Z_i Z_j))$, with $h_i , J_(i j) in bb(R)$ sampled from a Gaussian distribution.


] <prop:controllable-gen>


See Appendix~#ref(<app:proof_of_hea_sg>, supplement: none) for a proof of @prop:controllable-gen.


The first case in @prop:controllable-gen corresponds to the generators of PSA layered Hardware Efficient Ansatz~@kandala2017hardware, and hence @prop:controllable indicates that this system can exhibit barren plateaus. While it is known that the layered Hardware Efficient Ansatz converges to a $2$-design for sufficient depth~@harrow2009random @brandao2016local @harrow2018approximate @mcclean2018barren @cerezo2020cost, the proof of existence of barren plateaus for this ansatz presented here is novel in that we show that the system is controllable.


The second result in @prop:controllable-gen pertains to determining the ground state energy of quantum spin glasses (usually configured to encode solution to combinatorial optimization problems)~@lucas2014ising @streif2020training with a PSA generated by $cal(G)_(upright("SG"))$. Hence, since the system is controllable, according to @prop:controllable, such an ansatz will also exhibit a barren plateau. This provides a no-go theorem for determining the ground state of certain spin glasses with Hamiltonians using deep PSA variational ansatzes .


== Subspace controllable systems
<subspace-controllable-systems>


Let us now consider the case of reducible DLAs, i.e., control systems with symmetries. Here we recall that in this case the DLA is a direct sum of the form $frak(k) = x⋁_j frak(k)_j$, such that any unitary $U ( bold(theta) )$ in the dynamical group $bb(G)$ preserves the subspaces $U ( bold(theta) ) cal(H)_j subset cal(H)_j$. Then, similarly to the fully controllable case, if a system is subspace controllable in a given subspace there exists a depth at which the unitaries $U ( bold(theta) )$ form $2$-designs in that subspace. In such a case, we can derive the following theorem for the variance of the cost function partial derivative with respect to a parameter $theta_mu equiv theta_(p q)$ associated to layer $p$ and generator $H_q$ (see Eq.~@eq:ansatz for a definition of the ansatz). In the following, will slightly abuse notation and denote $H_mu = H_q$.


#thmbox("theorem", "Theorem (Subspace controllable)")[


Consider a system that is reducible, i.e. so that the Hilbert space is $cal(H) = x⋁_j cal(H)_j$ with each $cal(H)_j$ invariant under the action of the dynamical Lie group $bb(G)$ (see Def.~#ref(<def:dynamical-lie-group>, supplement: none)), and controllable on some $cal(H)_k$ of dimension $d_k$ (i.e. $frak(k)_k = frak(u) ( d_k )$ or $frak(s) frak(u) ( d_k )$). Consider a cost function $C ( bold(theta) )$ in the form of Eq.~@eq:cost and suppose that the number of layers $L$ in the circuit is enough to allow the distribution of unitaries $U ( bold(theta) )$ to be $epsilon$ close to a 2-design in $cal(H)_k$. Then, if the initial state is such that $rho in cal(H)_k$, the variance of the cost function partial derivative with respect to parameter $theta_mu$ is given by


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = frac(2 d_k, ( d_k^2 - 1 )^2) Delta ( H_mu^(( k )) ) Delta ( O^(( k )) ) Delta ( rho^(( k )) ) thin , $<Eq_th2>


where $O$ is the operator whose expectation value is being minimized and $H_mu$ is the generator of the corresponding gate. Here $Delta ( A ) = D_(H S) ( A , upright("Tr") [ A ] frac(I_d, d) )$, with $D_(H S) (A , B) = upright("Tr") [ ( A - B )^2 ]$ the Hilbert-Schmidt distance, and where we defined $A^(( k ))$ as the reduction of operator $A$ onto the subspace of $cal(H)_k$. Explicitly, $A^(( k )) = Q_k A Q_k^dagger$ with $Q_k$ a matrix (of dimension $d_k times 2^n$) with columns corresponding to a basis of $cal(H)_k$.


] <Theo:subspace>


See Appendix~#ref(<app:proof_theo_subspace>, supplement: none) for a proof of @Theo:subspace.


@Theo:subspace shows that the input state $rho$ can actually play a crucial role in determining the gradient scaling of the cost function. Specifically, if $rho$ belongs to an invariant subspace where the system is controllable, then the scaling of the cost function partial derivative variance is determined by the dimension of the invariant subspace rather than by the dimension $d = 2^n$ of the Hilbert space. Hence, the cost function $C ( bold(theta) )$ might exhibit barren plateaus in some subspaces but not in others. This is formalized in the following corollary.


#thmbox("corollary", "Corollary")[


Consider an ansatz of the form in @eq:ansatz giving rise to a reducible DLA, and let $rho in cal(H)_k$, with $cal(H)_k$ some invariant subspace that is controllable (i.e. the DLA reduced to such subspace is full rank). The following bound holds


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] lt.eq frac(4 d_k^2, ( d_k^2 - 1 )^2) sqrt(upright("Tr") [ H_mu^4 ]) sqrt(upright("Tr") [ O^4 ]) thin . $


That is, provided $upright("Tr") [ ( H_mu )^4 ] , upright("Tr") [ O^4 ] in cal(O) ( 2^n )$, the cost function will exhibit a barren plateau for any subspace such that $d_k in cal(O) ( 2^n )$.


] <cor:HXXZ>


See Appendix~#ref(<app:proof_corollary_subspace>, supplement: none) for a proof of @cor:HXXZ. In addition, in this appendix, we also note relevant cases for which $upright("Tr") [ ( H_mu )^4 ] , upright("Tr") [ O^4 ] in cal(O) ( 2^n )$ holds.


// [figvision] imgs/Matrix.png
// Panel a) is a schematic diagram showing the structure of a Hamiltonian {H} and its subspaces. The diagram
// depicts {H} as a direct sum of subspaces {H}_0, {H}_1, , {H}_{n/2}, , {H}_{n-1}, {H}_n. Each subspace {H}_i
// has a corresponding dimension d_i. The subspaces are arranged in a hierarchical structure with {H} on the left
// and a colorbar representing "Trainability" on the right. The trend shows that trainability decreases as you
// move down the hierarchy. Panel b) contains two plots. The left plot shows a green curve with a single minimum,
// with the x-axis labeled {H}_1 and the caption "No barren plateau". The y-axis is not labeled but appears to
// represent some cost or loss function. The curve decreases and then increases, indicating a well-behaved
// optimization landscape. The right plot shows a red curve with a deep minimum, labeled {H}_{n/2}, and the
// caption "Barren plateau". This curve has a narrow and deep minimum, indicating a difficult optimization
// problem. The trend shows that the optimization landscape becomes increasingly difficult as you move from {H}_1
// to {H}_{n/2}.
#figure(image("imgs/Matrix.png", width: 100%),
  caption: [
    #strong[Trainability analysis for a PSA used to prepare the ground state of a Heisenberg $X X Z$ Hamiltonian.] a) Due to the symmetries in the $X X Z$ Hamiltonian of Eq.~@eq:HXXZ, the Hilbert space spanned by the PSA can be expressed as a direct sum of invariant subspaces $cal(H)_k$ (of dimension $d_k = binom(n, k)$) composed of states with $k$ excitations. Hence both $H_(X X Z)$ and $U ( bold(theta) )$ generated by Eq.~@eq:genHVAXXZ will be block diagonal. Since the system is subspace controllable in each invariant subspace, the gradient scaling of the PSA can be analyzed via @Theo:subspace. b) The existence or absence of barren plateaus is directly determined by the dimension of the invariant subspace to which the input state $rho$ belongs. For instance, the cost can be trainable for $rho in cal(H)_1$, but will exhibit a barren plateau if $rho in cal(H)_(n / 2)$, as in the latter case the dimension $d_(n / 2)$ is exponentially large.
  ]
)
<fig:HXXZ>



For example, let us consider the problem of preparing the ground state of a Heisenberg $X X Z$ spin chain


$ H_(X X Z) = sum_(i = 1)^(n - 1) (X_i X_(i + 1) + Y_i Y_(i + 1) + J Z_i Z_(i + 1)) $<eq:HXXZ>


with a PSA generated by $cal(G) = cal(G)_(X X Z_U) ⋃ { Z_1 }$. Here, the XXZ generators


$ cal(G)_(X X Z_U) = (sum_i X_i X_(i + 1) + Y_i Y_(i + 1) , sum_i Z_i Z_(i + 1))_(i : e v e n , o d d) $<eq:genHVAXXZ>


are accompanied by a #emph[control] generator $Z_1$, which is introduced precisely to make the system (subspace) controllable. We remark that we here employ a $U$ subindex in $cal(G)_(X X Z_U)$ to indicate that this set of generators is uncontrollable. Since all elements in $cal(G)_(X X Z_U)$ commute with $M_z = sum_(i = 1)^n Z_i$, the Hilbert space fractures into $n + 1$ invariant subspaces of fixed excitation~#footnote[We recall that a state $| psi chevron.r$ has $m$ excitations if it can be expressed as a linear combination of computational basis states with Hamming weight $m$] $cal(H) = x⋁_(m = 0)^n cal(H)_m$, of dimension $d_m = upright("dim") ( cal(H)_m ) = binom(n, m)$ @cerezo2017factorization.


Because the example set $cal(G)$ has a DLA that is full rank on every subspace~@wang2016subspace, we can analyze the trainability of such a PSA using @Theo:subspace. The implications of @cor:HXXZ for such a VQA are schematically shown in @fig:HXXZ. Here we find that the presence, or absence, of barren plateaus for the PSA $U ( bold(theta) )$ generated by Eq.~@eq:genHVAXXZ is completely determined by the scaling of the invariant subspace to which the input state belongs. For instance, the cost may not exhibit a barren plateau if $rho$ has a number of excitations that does not scale with $n$, while it will have a barren plateau for $k = n / 2$ (as in this case the dimension $d_(n / 2)$ scales exponentially with the number of qubits).


== Uncontrollable and reducible systems
<uncontrollable-and-reducible-systems>


Analyzing the scaling of the gradients in the case of uncontrollable systems becomes much more intricate than in the controllable or subspace controllable cases, mainly because integrating over the Haar measure of proper subgroups of the unitary group is not so straightforward~@collins2006integration. As shown in this (and the next) section, one can still obtain a few analytical results for these cases. In particular, one can derive an upper bound for the variance of partial derivatives in terms of the degree of expressibility on the invariant subspaces, in a spirit similar to that of~@holmes2021connecting.


Before presenting our main results for uncontrollable and reducible systems, it is convenient to introduce some notation. We will use $U_B$ and $U_A$, respectively, to address the portions of the circuit that come before and after a given parameter $theta_mu equiv theta_(p q) in bold(theta)$. That is,


$ U_B = product_(m = 0)^q e^(- i H_m theta_(p m)) (product_(l = 1)^(p - 1) product_(k = 0)^K e^(- i H_k theta_(l k))) thin , $<eq:UB>


and


$ U_A = product_(l = p + 1)^L product_(k = 0)^K e^(- i H_k theta_(p k)) (product_(k = q + 1)^K e^(- i H_k theta_(p k))) thin , $<eq:UA>


where we have omitted the $bold(theta)$ dependency for simplicity.


Then, the following theorem holds.


#thmbox("theorem", "Theorem")[


Consider a system that is reducible and let $rho in cal(H)_k$ with $cal(H)_k$ an invariant subspace of dimension $d_k$. Then, the variance of the cost function partial derivative is upper bounded by


$ upright("Var")_theta [ partial_mu C ( bold(theta) ) ] lt.eq min ( G_A ( rho^(( k )) ) , G_B ( O^(( k )) ) ) thin , $<eq:expressibility>


with


$ G_B ( rho^(( k )) ) & = (lr(bar.v.double cal(A)_(U_B^(( k ))) (( rho^(( k )) )^(⊗ 2)) bar.v.double)_2 - frac(Delta ( rho^(( k )) ), d_k^2 - 1)) upright("Tr") [⟨X^2⟩_(U_A^(( k )))]\
G_A ( O^(( k )) ) & = (lr(bar.v.double cal(A)_(U_A^(( k ))) (( O^(( k )) )^(⊗ 2)) bar.v.double)_2 - frac(Delta ( O^(( k )) ), d_k^2 - 1)) upright("Tr") [⟨Y^2⟩_(U_B^(( k )))] . $


Here we defined $X = [ H_mu^(( k )) , ( U_A^(( k )) thin )^dagger O thin U_A^(( k )) ]$ and $Y = [ H_mu^(( k )) , ( U_B^(( k )) ) rho^(( k )) ( U_B^(( k )) )^dagger ]$. For simplicity, we here employed the short-hand notation $chevron.l dot.op chevron.r_(U_x^(( k )))$ (with $x = A , B$) indicates the expectation value over the distribution of unitaries obtained from $U_x^(( k ))$ in the $k$-th subsystem. Finally, $bar.v.double M bar.v.double_2 = sqrt(upright("Tr") [ M^dagger M ])$ is the Frobenius norm, and $Delta ( dot.op )$ was defined in @Theo:subspace.


] <theo:express-subspace2>


See Appendix~#ref(<app:proof_theo_express>, supplement: none) for a proof of @theo:express-subspace2.


@theo:express-subspace2 generalizes the expressibility results in~@holmes2021connecting to invariant subspaces. More specifically, @theo:express-subspace2 provides a bound on the variance of the cost function partial derivative $partial_mu C ( bold(theta) )$ as a function of the ansatz expressibility on the relevant invariant subspace. Hence, similar to the results observed in~@holmes2021connecting, the more expressible an ansatz is in a subspace, the smaller the gradients will be. Moreover, ansatzes that are very expressible in subspaces with exponentially large dimensions can exhibit barren plateaus as the variance of the cost function partial derivative will vanish exponentially, according to Eq.~@eq:expressibility.


== Uncontrollable and irreducible systems
<sec:Irre>


Here, we analyze a case where the DLA is an irreducible representation of some proper subalgebra of $frak(s u) ( d )$. Specifically, we consider a toy model ansatz $U ( bold(theta) ) = product_(l = 1)^L e^(- i theta_(l x) S_y) e^(- i theta_(l y) S_x)$ with generators $cal(G) = ( S_x , S_y )$, where $frak(k) = ( i S_x , i S_y , i S_z )$ is the spin $S = ( d - 1 ) / 2$ irreducible representation of $frak(s u)(2)$. That is, $[ S_j , S_k ] = 2 i epsilon.alt_(j k l) S_l$ with $epsilon.alt$ the Levi-Civita symbol and $j , k , l in ( x , y , z )$. We address the task of minimizing a cost function of the form


$ C ( bold(theta) ) = chevron.l m #h(0em) | U^dagger ( bold(theta) ) ( S_x + S_y + S_z ) U ( bold(theta) ) | #h(0em) m chevron.r thin , $<eq:costsu2>


where $| m chevron.r$ is an eigenstate of $S_z$, i.e., $S_z | m chevron.r = m | m chevron.r$ with $m in ( - S , - S + 1 , dots.h , S - 1 , S )$.


Let us analyze the variance of partial derivative with respect to parameter $theta_mu = theta_(j x)$, i.e., the one corresponding to the generator $S_x$ on the $j$-th layer. Assuming a depth $p$ such that that the distributions $U_A ( bold(theta) )$ and $U_B ( bold(theta) )$ converge to $epsilon$-approximate $2$-designs on the dynamical Lie group $bb(G)$ (which in this case is the $d$-dimensional irreducible representation of $cal(S) cal(U) ( 2 )$), we are able to explicitly integrate over the Haar measure on $bb(G)$ and find the following proposition to hold.


#thmbox("proposition", "Proposition")[


Consider the cost function of Eq.~@eq:costsu2. Let $theta_mu = theta_(j , x)$, and let us assume that the circuit is deep enough to allow for the distribution of unitaries $U_A$ and $U_B$ to converge to $2$-designs on $bb(G) = cal(S) cal(U)$\(2). Then variance of the cost function partial derivative $partial_mu C ( bold(theta) ) = partial C ( bold(theta) ) / partial theta_mu$ is


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = frac(2 m^2, 3) thin . $<eq:varsu2>


] <prop:varsu2>


See Appendix~#ref(<app:proof_su2>, supplement: none) for a proof of @prop:varsu2.


@prop:varsu2 shows that the variance of the cost function again depends on the input state $| m chevron.r$, which is a similar result to the one obtained in @Theo:subspace. Moreover, here $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ can in fact be as large as $d^2$. This is due to the fact that the "size" (the difference between maxima and minima) of the landscape also grows with $d$. One can get rid of this effect by considering a normalized cost instead, $tilde(C) ( bold(theta) ) = C ( bold(theta) ) / S$, where the #emph[ad-hoc] factor $1 / S$ guarantees that the landscape is $| C ( bold(theta) ) | lt.eq 1$ for all values of $d$. The variance of such normalized landscape is $upright("Var")_(bold(theta)) [ partial_mu tilde(C) ( bold(theta) ) ] = 2 / 3 m^2 / S^2 = 8 / 3 frac(m^2, ( d - 1 )^2)$, that is, vanishes exponentially for initial states with $| m | in cal(O) ( "poly" ( log ( d ) ) )$. Similar to the subspace controllable results in @cor:HXXZ, here the choice of initial state is again crucial as it can lead to the cost function exhibiting barren plateaus.


== General case: linking gradient scaling to the dimension of the Lie algebra
<sec:conjecture>


In this section we note that the dimension of the DLA can be linked to the scaling of the variance of the cost function partial derivatives. This opens up the possibility of diagnosing the existence of barren plateaus of uncontrollable systems by analyzing the scaling of their DLAs. First, let us remark that a key aspect of the toy model in @sec:Irre is that the dimension of the DLA is $upright("dim") ( frak(k) ) = 3$. This is independent of the dimension $d$ of the Hilbert space it acts on. Moreover, as shown in Eq.~@eq:varsu2 the variance is also independent of $d$ as it does not present the typical dimensional-dependent factor in the denominator that one usually obtains when integrating over unitary 2-designs (see Eq.~@Eq_th2 in @Theo:subspace).


For instance, when the system is controllable, $upright("dim") ( frak(k) ) = d^2 - 1 = 2^(2 n) - 1$, and thus the dimension of the DLA is exponentially growing with the system size $n$. Concomitantly, one finds that $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = frac(2 d, ( d^2 - 1 )^2) thin thin g ( H_mu , O , rho )$~@mcclean2018barren @cerezo2020cost, and hence the variance is exponentially vanishing with the system size. A similar result is obtained in the subspace controllable case (see @Theo:subspace) where the variance is of the form $frac(2 d_k, ( d_k^2 - 1 )^2) g ( H_mu^(( k )) , O^(( k )) , rho^(( k )) )$.


These facts have led us to conjecture that the dimension of the DLA plays a key role in determining the presence or absence of barren plateaus in the cost function landscape. More specifically, for PSAs with sufficient depth (i.e., with a depth such that the distribution of unitaries generated by $U ( bold(theta) )$ has converged to the Haar measure in the Lie group $bb(G)$), we have noted that the following conjecture appears to hold.


#thmbox("conjecture", "Conjecture")[


Let the state $rho$ belong to a subspace $cal(H)_k$ associated with a subspace DLA $frak(k)_k$ (or sub-DLA, the subrepresentation in $frak(k)$ where $rho$ has support on). Then, the scaling of the variance of the cost function partial derivative is inversely proportional to the scaling of the dimension of the DLA, i.e.


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] in cal(O) (frac(1, "poly" ( upright("dim") ( frak(k)_k ) ))) thin . $<Eq:conjecture>


] <conjecture>


The implications of @conjecture are as follows. First, it means that systems with a sub-DLA $frak(k)_k$~#footnote[Let us note that one should look at the sub-DLA instead of the full DLA, since when there are symmetries and the initial state belongs to one or multiple invariant subspaces, the dynamics is contained in those.] that is polynomially growing with the system size can exhibit gradients that vanish only polynomially, and hence may not exhibit barren plateaus. Conversely, systems with a sub-DLA that is exponentially growing with the system size would exhibit gradients that vanish exponentially with the system size, hence exhibiting barren plateaus. Here, we remark that systems with sub-DLAs that are not exponentially growing may still have barren plateaus which are not related to the dimension of the DLA. For instance, if the cost function is global, the system can still exhibit barren plateaus even with trivial ansatzes that do not a have exponentially growing dimension of the DLA~@cerezo2020cost.


Using @conjecture, one could diagnose gradient scalings by determining the size of the Lie algebra of a given ansatz $U ( bold(theta) )$. This comes at the cost of taking the set of generators $cal(G)$ and computing the DLA. While numerical methods (as in Algorithm~#ref(<alg:lie>, supplement: none)) can prove valuable insights for small system sizes, these algorithms will generally scale poorly in the number of qubits. Hence, performing a theoretical analysis of the DLA (similar to the one performed in @prop:controllable-gen) is a preferable method.


Here we remark that there are simple (yet pathological) cases that show that Eq.~@Eq:conjecture does not preclude the possibility that systems with algebras that grow polynomial with the system size may still exhibit barren plateaus. For instance, consider Eq.~@Eq_th2, where $rho$ belongs to a subspace with polynomially growing algebra: $d_k in cal(O) ( "poly" ( n ) )$. Then, note that if the input state is exponentially close to being maximally mixed on $cal(H)_k$ (i.e., if $Delta ( rho^(( k )) ) in cal(O) ( 1 / 2^n )$) one can easily verify that the system will exhibit a barren plateau according to @def:BP as the cost function partial derivative will be exponentially vanishing. Here, the barren plateau arises not from the dimension of the DLA being exponentially large but rather from trying to train a VQA on an input state that is exponentially close to being maximally mixed. A similar result can be found if $H_mu^(( k ))$ is exponentially close to the identity. Hence, we remark that @conjecture does not imply that systems with polynomially growing algebras are exempt from having barren plateaus, as cases where $rho$ ($H_mu^(( k ))$) is exponentially close to being maximally mixed (the identity) will naturally be hard to train from the definition of the cost function in Eq.~@eq:cost.


We finally note that to further support the claim in @conjecture, we present in the following section results obtained from numerically computing the scaling of the variance of the cost function partial derivatives for systems with DLAs having several different dependencies on the number of qubits. As discussed in @sec:results, we see that the the result in @conjecture holds true for all cases considered, as in these cases the scaling of the variance of the cost function partial derivative is inversely proportional to the scaling of the dimension of the DLA. In addition, based on our conjecture one can accurately make predictions regarding whether a given modification to an ansatz (adding a new generator to $cal(G)$ by introducing a new unitary in each layer) might improve or be detrimental to the trainability of the parameters.


= NUMERICAL SIMULATIONS
<sec:results>


In this section we present results obtained by numerically computing the variance of the cost function partial derivatives for systems with different PSAs, and with DLAs of dimensions with different scaling. In particular, we consider systems that are controllable, subspace controllable, and subspace uncontrollable. As we show, in all cases @conjecture is verified. Finally, we refer the reader to Appendix~#ref(<app:proof_su2>, supplement: none) for a numerical study of the toy model in @sec:Irre, where $frak(k)$ and $bb(G)$ are, respectively, the $d$-dimensional irreducible representations of $frak(s u)(2)$ and $cal(S) cal(U)$\(2).


// [figvision] imgs/HEA_conjecture.png
// The figure contains a single plot labeled "a". The plot is a log-log scatter plot. The y-axis is labeled
// "Var_03b8[2202C(03b8)]" and ranges from 10^(-5) to 10^(-1). The x-axis is labeled "1/dim(00e4)" and ranges
// from 10^(-10) to 10^(-1). The plot contains red dots representing the Hardware Efficient Ansatz for different
// values of n (2, 4, and 20). The trend shows that as 1/dim(00e4) increases, Var_03b8[2202C(03b8)] also
// increases. An inset shows a schematic of the layered Hardware Efficient Ansatz, which is a controllable system
// with generators Y, X, and ZZ. The message is that the variance of the cost function partial derivatives
// increases with the inverse of the DLA dimension for this controllable system.
#figure(image("imgs/HEA_conjecture.png", width: 100%),
  caption: [
    #strong[Variance of cost function partial derivatives versus inverse of the DLA dimension for a controllable system.] The layered Hardware Efficient Ansatz (shown in the inset for $n = 4$) is a controllable system with generators given in @prop:controllable-gen. Then, as shown in @prop:controllable, the cost function of Eq.~@eq:cost_HEA exhibits a barren plateau and hence $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] in cal(O) ( 1 / 2^n )$. Moreover, since the system is controllable one finds that $upright("dim") ( frak(k) ) = 4^n - 1$. Hence, as shown in the plot, @conjecture holds for controllable systems, since the dependence of $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ versus $1 / upright("dim") ( frak(k) )$ is linear on a log-log scale.
  ]
)
<fig:HEA>



== Controllable systems
<controllable-systems>


// [figvision] imgs/XXZ_Fig.png
// a) This is a schematic diagram showing a circuit layout. The objects are JJ and ZZ gates or blocks, and Z
// gates, which are connected in a specific pattern. There are five vertical dotted lines labeled _{l,1} to
// _{l,5} from left to right, and three horizontal lines with gates or blocks. The top and bottom lines have JJ,
// ZZ, JJ, and ZZ from left to right, while the middle line has JJ, ZZ, JJ, Z, and Z. A gray shaded area is on
// the right side. b) This is a plot of {Var}_{}[ C()] versus n. The y-axis ranges from 10^{-4} to 10^{-1} on a
// log scale, and the x-axis ranges from 4 to 20. There are five series of points with different colors and
// symbols: blue circles, orange triangles, green squares, purple diamonds, and pink crosses, corresponding to m
// = 1, 2, 3, 4, and 5. A dashed line shows the theoretical prediction. The trend is that {Var}_{}[ C()]
// decreases as n increases. c) This is a plot of {Var}_{}[ C()] versus 1/({g}). The y-axis ranges from 10^{-4}
// to 10^{-1} on a log scale, and the x-axis ranges from 10^{-9} to 10^{-3} on a log scale. There are seven
// series of points with different colors and symbols, corresponding to different m values. The trend is that
// {Var}_{}[ C()] decreases as 1/({g}) increases.
#figure(image("imgs/XXZ_Fig.png", width: 100.0%),
  caption: [
    #strong[Numerical results for the $X X Z$ model.] a) Schematic illustration of a single layer of the subspace controllable periodic structure ansatz for the set of generators $cal(G)_(X X Z)$ in Eq.~@eq:gcXXZ for $n = 4$ qubits. Removing the unitary in the shaded area leads to the uncontrollable periodic structure HVA generated by $cal(G)_(X X Z_U)$. b) Left panel: Variance of the partial derivative of the cost in Eq.~@eq:costxxz versus the number of qubits $n$. The different markers correspond to initial states with a number of excitations $m = 1 , 2 , dots.h , 5$ (left) with an ansatz generated by $cal(G)_(X X Z)$, and to $m = n / 2$ (right) with an ansatz generated by $cal(G)_(X X Z)$ and by $cal(G)_(X X Z_U)$. Here we recall that a state $| psi chevron.r$ has $m$ excitations if it can be expressed as a linear combination of computational basis states with Hamming weight $m$. The dashed lines represent the theoretical prediction of Eq.~@Eq_th2. In both cases the plot is shown in a log-linear scale. For $m = 1 , 2 , dots.h , 5$ the variance is polynomially vanishing with $n$, while for $m = n / 2$ the variance is exponentially vanishing with $n$. c) Variance of the cost function partial derivative versus $1 / upright("dim") ( frak(k) )$. The plot is shown in a log-log scale. For each value of $m$ we see a linear dependence, which verifies @conjecture.
  ]
)
<fig:dipXXZ>



First, let us remind that when the system is controllable, $U ( bold(theta) )$ forms a $2$-design (see @prop:controllable). In this case the scaling of $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ has been widely analyzed in the literature (see for instance~@mcclean2018barren @holmes2021connecting). Controllable systems, as previously discussed, satisfy @conjecture. In @fig:HEA we show the variance of cost function partial derivatives as a function of $1 / upright("dim") ( frak(k) )$ for the cost function


$ C ( bold(theta) ) = chevron.l bold(0) #h(0em) | U^dagger ( bold(theta) ) ( Z_1 ⊗ Z_2 ) U ( bold(theta) ) | #h(0em) bold(0) chevron.r thin . $<eq:cost_HEA>


Here, $U ( bold(theta) )$ is a layered Hardware Efficient ansatz (see the circuit in the inset of @fig:HEA) with $200$ layers and where $| bold(0) chevron.r = | 0 chevron.r^(⊗ n)$. For each value of $n = 2 , 4 , dots.h , 20$, the variance was computed by randomly initializing $1000$ sets of parameters. Since this system is controllable (as proved in @prop:controllable), then $upright("dim") ( frak(k) ) = d^2 - 1 = 4^n - 1$. In @fig:HEA we see that, as expected, the variance is a polynomial function of $1 / upright("dim") ( frak(k) )$ (indicated by a straight line in a log-log scale).


== Reducible systems
<reducible-systems>


=== The XXZ model
<section:XXZ>


Let us first consider the task of finding the ground state energy of the XXZ Hamiltonian $H_(X X Z)$ of Eq.~@eq:HXXZ. First, let us notice that $cal(G)_(X X Z_U)$, the uncontrollable set of generators of Eq.~@eq:genHVAXXZ, has two symmetries: magnetization and parity. Hence, the DLA is reducible, i.e. a sum of irreducible sub-representations $frak(k)_(X X Z_U) = x⋁_(m = 0\
sigma = plus.minus)^n frak(k)_(m \, sigma) subset.eq frak(u) \( d_(m \, sigma) \)$, where the indices $m$ and $sigma$ indicate number of excitations and parity, respectively (see Appendix~#ref(<App:XXZ>, supplement: none) for details). Notably, the system can be rendered subspace controllable (while preserving the invariant subspace structure) by introducing an additional generator consisting of local fields at the ends of the chain @poggi2016optimal @larocca2021krylov


$ cal(G)_(X X Z) = cal(G)_(X X Z_U) union {upright("Z")_1 + upright("Z")_N} thin . $<eq:gcXXZ>


The new set $cal(G)_(X X Z)$ generates a DLA that is full rank on each of the invariant subspaces, i.e. $frak(k)_(upright(X X Z)) = x⋁_(m = 0\
sigma = plus.minus)^n frak(u) \( d_(m \, sigma) \)$. In @fig:dipXXZ(a), we sketch a single layer of the ansatz generated by $cal(G)_(X X Z)$. Note that upon the removal of the unitary generated by $Z_1 + Z_N$ (indicated by a shaded area), one recovers the HVA ansatz with generators $cal(G)_(X X Z_U)$ proposed in Ref.~@wiersema2020exploring.


@fig:dipXXZ(b) shows numerical results obtained by computing $upright(V a r)_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ for the cost function


$ C ( bold(theta) ) = chevron.l psi_(m \, +) #h(0em) | U^dagger ( bold(theta) ) H_(X X Z) U ( bold(theta) ) | #h(0em) psi_(m \, +) chevron.r \/ n thin \, $<eq:costxxz>


with $J = 1$. Here, $U ( bold(theta) )$ is the HVA ansatz generated by $cal(G)_(X X Z)$ (see Eq.~@eq:gcXXZ) with $L = 6 n$ layers, and $| psi_(m , +) chevron.r$ is an initial state with $m$ excitations and even parity $sigma = +$ (see Appendix~#ref(<App:numerical>, supplement: none) for details). For each system system size $n = 2 , 4 , dots.h , 20$, and for each value of $m$, we computed the variance with respect to $theta_(L / 2 , 2)$ by randomly initializing each $bold(theta)_(p q) in [ 0 , 2 pi ]$ and averaging over $9500$ sets of parameters (for $n = 20$ we averaged over $2700$ sets of parameters).


In @fig:dipXXZ\(b, left) we see that for $m = 1 , 2 , dots.h , 5$ the variance of the cost function partial derivative is polynomially decreasing with $n$, indicating that the cost function does not exhibit a barren plateau for initial states with fixed number of excitations. However, in the case $m = n / 2$ (see @fig:dipXXZ\(b, right)), one can observe that $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ vanishes exponentially. In addition, in @fig:dipXXZ\(b) we also show the curves for $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ obtained from the analytical result in Eq.~@Eq_th2 of @Theo:subspace. The agreement between theoretical and numerical results indicates that, already for the linear depths used in the experiments, the ansatz is well converged to a $2$-design. Hence, the results in @Theo:subspace suggest that the system will exhibit a barren plateau when initialized on any subspace where $d_m in cal(O) ( 2^n )$, for example, in the case of $m = n / 2$ excitations.


In addition, @fig:dipXXZ\(b, right) shows the scaling of the variance for the PSA generated by $cal(G)_(X X Z_U)$, with an initial state with $m = n / 2$. As previously noted, this case is not controllable and hence @Theo:subspace does not hold. However, the gradient scaling of the cost function can still be diagnosed using the expressibility result of @theo:express-subspace2. First, we note that the variance values for the uncontrollable case are larger than the ones for the controllable case. This result is in accordance with the fact that the smallest variances are reached with the higher expressibilities. Still, despite the system not being controllable, we find that the cost function still exhibits a barren plateau as the cost vanishes exponentially with $n$.


In @fig:dipXXZ\(c) we show that for all subspace controllable cases considered, @conjecture holds. Specifically, we have shown $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ as a function of $1 / upright("dim") ( frak(k) )$, and we see a linear dependence in a log-log scale. This is true both for the exponentially growing algebras ($m = n / 2$) as well as for the polynomially growing algebras ($m = 1 , 2 , dots.h , 5$). Moreover, we see that the Conjecture is verified on the subspace uncontrollable case of $cal(G)_(X X Z_U)$ (pink stars), where the dimension of the DLA is exponentially growing, and concomitantly, the variance of the cost function partial derivative is exponentially suppressed.


=== The Ising Model
<section:Ising>


In this section we present results obtained for numerically simulating the use of a PSA to find the ground state of the Ising model. Specifically, consider the Hamiltonian of the one-dimensional Transverse Field Ising Model (TFIM)


$ H_(upright("TFIM")) = sum_(i = 1)^(n_f) Z_i Z_(i + 1) + h_x sum_(i = 1)^n X_i thin , $<eq:TFIM>


where $n_f = n - 1$ in the case of open boundary conditions, and $n_f = n$ in the periodic boundary conditions case (where $Z_(n + 1) equiv Z_1$). Then, as shown in @fig:Ising\(a, left), the ansatz is generated by the set


$ cal(G)_(upright("TFIM")) = (sum_(i = 1)^(n_f) Z_i Z_(i + 1) , sum_(i = 1)^n X_i) thin . $<eq:genTFIM>


Note that the PSA generated by $cal(G)_(upright("TFIM"))$ is in fact the QAOA employed for solving the MAXCUT problem on a 2-regular graph~@farhi2014quantum @hadfield2019quantum.


As discussed in Appendix~#ref(<App:XXZ>, supplement: none), the generators in $cal(G)_(upright("TFIM"))$ (with open boundary conditions) have two symmetries: parity symmetry $Pi$, and the so-called $bb(Z)_2$ symmetry $Pi_(bb(Z)_2)$ (representing an invariance under a global flip in the qubits). The Hilbert space is broken into four invariant subspaces, $cal(H) = x⋁_(sigma , sigma') cal(H)_(sigma , sigma')$, where $sigma , sigma' = plus.minus 1$ respectively spanning the eigenvalues of $Pi$ and $Pi_(bb(Z)_2)$, and where $upright("dim") ( cal(H)_(sigma , sigma') )$ is exponentially growing, i.e., $upright("dim") ( cal(H)_(sigma , sigma') ) in cal(O) ( 2^n )$. In turn, the DLA decomposes as $frak(k)_(upright("TFIM")) = x⋁_(sigma , sigma') frak(k)_(sigma , sigma') subset.eq frak(u) ( d_(sigma , sigma') )$. However, employing Algorithm~#ref(<alg:lie>, supplement: none) we computed the dimension of the DLA generated by $cal(G)_(upright("TFIM"))$ and we found that it only grows polynomially with $n$. That is, we obtain that


$ upright("dim") ( frak(k)_(upright("TFIM")) ) = n^2 thin . $<eq:dimTIM>


Clearly, this implies that $upright("dim") ( frak(k)_(sigma , sigma') ) lt.eq n^2$ for all $sigma , sigma'$.


Note that the set $ { I, Pi } $ constitutes a representation of $S_2$, the symmetric group of two elements, under which the open-boundary-condition TFIM generators are invariant. Instead, the TFIM generators with closed boundary conditions are invariant under a representation of $C_n$, the cyclic group of $n$ elements. As discussed in Appendix~#ref(<App:XXZ>, supplement: none), the dimension of the DLA now grows linearly instead of quadratically.


// [figvision] imgs/TFIM_Fig.png
// a) This panel contains two schematics side-by-side, one for TFIM and one for LTFIM. Each schematic consists of
// a series of boxes and lines. The boxes are labeled with "ZZ", "X", and "Z". The TFIM schematic has two columns
// of boxes, with the left column having three "ZZ" boxes stacked vertically and the right column having three
// "X" boxes. The LTFIM schematic has three columns of boxes, with the left and middle columns having three "ZZ"
// and "X" boxes respectively, and the right column having three "Z" boxes. The top and bottom boxes in each
// column are connected by lines. The highlighted boxes in both schematics are labeled with Greek letters. b)
// This panel is a plot showing the variance of the derivative of a cost function C with respect to θ, denoted as
// Varθ[∂C(θ)], against the variable n. The y-axis ranges from 10^-4 to 10^0 and is on a log scale. The x-axis
// ranges from 0 to 20. There are four series: TFIM closed (maroon circles), LTFIM closed (pink triangles), TFIM
// open (green circles), and LTFIM open (green triangles). The series show a decreasing trend as n increases. The
// TFIM series start around 10^-1 and decrease to around 10^-2, while the LTFIM series start around 10^-2 and
// decrease to around 10^-4. c) This panel is a plot showing Varθ[∂C(θ)] against the inverse of the dimension of
// g, denoted as 1/dim(g). The y-axis ranges from 10^-4 to 10^0 and is on a log scale. The x-axis ranges from
// 10^-10 to 10^-1 and is on a log scale. There are four series: TFIM closed (maroon circles), LTFIM closed (pink
// triangles), TFIM open (green circles), and LTFIM open (green triangles). The series show an increasing trend
// as 1/dim(g) increases. The points in the plot are scattered but generally increase from around 10^-4 to around
// 10^-1.
#figure(image("imgs/TFIM_Fig.png", width: 100%),
  caption: [
    #strong[Numerical results for the TFIM and LTFIM models.] a) Schematic illustration of a single layer of the PSA for the sets of generators $cal(G)_(upright("TFIM"))$ in Eq.~@eq:genTFIM (left), and $cal(G)_(upright("LTFIM"))$ in Eq.~@eq:genLTFIM (right) for $n = 4$ qubits. By adding (removing) the gates in the shaded one obtains the ansatz in Eq.~@eq:genTFIM with periodic (open) boundary conditions. b) Variance of the cost function partial derivative of the cost function in Eq.~@eq:costTFIM versus the number of qubits $n$ for each ansatz. The dashed (dotted) lines indicate the best polynomial (exponential) fit. The plot is shown in a log-linear scale. c) Variance of the cost function partial derivative versus $1 / upright("dim") ( frak(k) )$. The plot is shown in a log-log scale.
  ]
)
<fig:Ising>



Similarly to what happened in the $X X Z$ case, we can turn the TFIM model subspace controllable upon the introduction of an extra generator. Consider the set


$ cal(G)_(upright("LTFIM")) = cal(G)_(upright("TFIM")) ⋃ {sum_(i = 1)^n Z_i} , $<eq:genLTFIM>


leading to the PSA in @fig:Ising\(a, right). The set $cal(G)_(upright("LTFIM"))$ can also be regarded as being constituted by the individual terms in the one-dimensional Longitudinal and Transverse Field Ising Model (LTFIM) Hamiltonian


$ H_(upright("LTFIM")) = sum_(i = 1)^(n_f) Z_i Z_(i + 1) + h_x sum_(i = 1)^n X_i + h_z sum_(i = 1)^n Z_i thin . $<eq:LTFIM>


In addition, the ansatz generated by $cal(G)_(upright("LTFIM"))$ is also a QAOA-type ansatz where an additional mixer has been added.


In the case of open boundary conditions, the $sum_(i = 1)^n Z_i$ term breaks the $bb(Z)_2$ symmetry, and thus the set $cal(G)_(upright("LTFIM"))$ only conserves the parity symmetry, $frak(k)_(upright("LTFIM")) = x⋁_sigma frak(k)_sigma$. Using Algorithm~#ref(<alg:lie>, supplement: none) we find that the DLA is full rank on both $sigma = plus.minus 1$ parity subspaces, and hence


$ upright("dim") ( frak(k)_sigma ) in cal(O) ( 2^(2 n) ) thin . $


Similarly, in the closed boundary condition case, one can also find that the dimension of the DLA grows exponentially with $n$. This is an example where we show how a simple modification to the ansatz (adding a layer generated by $sum_(i = 1)^n Z_i$) can greatly change the dimension of the DLA, and, as discussed below, such a small change can greatly affect the trainability of the cost function.


In @fig:Ising\(b) we show results for numerically computing $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ for the cost function


$ C ( bold(theta) ) = chevron.l + |^(⊗ n) U^dagger ( bold(theta) ) H_(upright("TFIM")) U ( bold(theta) ) | + chevron.r^(⊗ n) / n thin , $<eq:costTFIM>


where $U ( bold(theta) )$ is the PSA generated by the set $cal(G)_(upright("TFIM"))$ of Eq.~@eq:genTFIM with $L = 12 n$ layers for open boundary conditions, and $L = 6 n$ for closed boundary conditions. For each value of $n = 4 , 6 , dots.h , 18$ we computed the variance by picking $4400$ random sets of parameters, while for $n = 20$ we picked $1000$ random intializations. In all cases the partial derivative was taken with respect to $theta_(L / 2 , 2)$. We see from @fig:Ising\(b) that the variance of the cost partial derivative vanishes polynomially with $n$ for both open and closed boundary conditions, and hence the system does not exhibit a barren plateau. Then, as shown in @fig:Ising\(c), once again, @conjecture holds for both open and closed boundary conditions: $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ and $upright("dim") ( frak(k)_(upright("TFIM")) )$ respectively vanish, and grow, polynomially with $n$.


Moreover, in @fig:Ising\(b) we also depict results obtained by computing $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ for the LTFIM ansatz, using the same cost function of Eq.~@eq:costTFIM. Now, $U ( bold(theta) )$ is the PSA generated by the set $cal(G)_(upright("LTFIM"))$ in Eq.~@eq:genTFIM with $L = 6 n$ layers. Using the same number of samples than for the TFIM case, we find that $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ vanishes exponentially with $n$ for both open and closed boundary conditions, and hence the cost exhibits a barren plateau. We see in @fig:Ising\(c) that @conjecture also holds for the LTFIM ansatzes with open and closed boundary conditions, as this time $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ vanishes exponentially with $n$, while $upright("dim") ( frak(k)_(upright("TFIM")) )$ grows exponentially with $n$.


It is worth noting that, as discussed before, and as shown in @fig:Ising\(a), the difference between the TFIM and the LTFIM ansatz is given by an additional unitary in each layer (parametrized by a single angle). However, despite this simple difference, we find the variance of the cost function have different scaling, as one cost exhibits a barren plateau while the other one does not exhibit a barren plateau.


===  Erdös--Rényi model
<erdösrényi-model>


// [figvision] imgs/Erdos_Fig.png
// a) This is a scatter plot showing the variance of C() versus n. The x-axis ranges from 2 to 8, and the y-axis
// is on a log scale from 10^{-3} to 10^{0}. All points are light blue circles. A black dashed line indicates the
// median. There are no other labels or annotations. The trend shows that as n increases, the variance decreases.
// b) This is another scatter plot showing the variance of C() versus 1/(q). The x-axis is on a log scale from
// 10^{-3} to 10^{-1}, and the y-axis is on a log scale from 10^{-2} to 10^{0}. Points are coloured according to
// n: n=2 are dark blue triangles, n=3 are dark green triangles, n=4 are green squares, n=5 are green crosses,
// and n=6 are black circles. There are no other labels or annotations. The trend shows that as 1/(q) increases,
// the variance increases.
#figure(image("imgs/Erdos_Fig.png", width: 100%),
  caption: [
    #strong[Numerical results for the Erdös--Rényi model.] a) Variance of the cost function partial derivative of the cost function in Eq.~@eq:costErdos versus the number of qubits $n$. The dashed line indicates the medians across graphs computed for each value of $n$. The plot is shown in a log-linear scale. b) Variance of the cost function partial derivative versus $1 / upright("dim") ( frak(k) )$. The plot is shown in a log-log scale.
  ]
)
<fig:Erdos>



Let us now consider the task of solving MAXCUT problems with a QAOA ansatz. Here, we recall that MAXCUT is specified by a graph $G = ( V , E )$ of nodes $V$ and edges $E$, such that one seeks to determine a partition of the nodes of $G$ into two sets that maximize the number of edges connecting nodes between sets. The MAXCUT Hamiltonian is given by


$ H_("ER")=-frac(1, 2)sum_(i j in E)(bb(1)-Z_(i) Z_(j))thin, $


and we consider the standard QAOA ansatz generated by


$ cal(G) = (sum_(i = 1)^n X_i , H_(upright("ER"))) . $<eq:genErdos>


Let us analyze the variance of the partial derivative of the cost


$ C ( bold(theta) ) = chevron.l + |^(⊗ n) U^dagger ( bold(theta) ) H_(upright("ER")) U ( bold(theta) ) | + chevron.r^(⊗ n) / | E | thin , $<eq:costErdos>


where we use $| E |$ (the number of edges in the graph) to normalize the cost function. For each value of $n = 2 , 3 , dots.h , 9$ we generated 90 graphs according to the Erdös--Rényi model~@erdds1959random. That is, each graph $G$ was chosen uniformly at random from the set of all graphs of $n$ nodes. Then, for each graph we sampled $3000$ random initializations with $L = 12 n$ layers and we took the partial derivative with respect to the angle in the $L / 2$-th layer associated to the (mixer) Hamiltonian $sum_(i = 1)^n X_i$. In @fig:Erdos\(a) we show results of $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ versus the number of qubits. Here we can see that, as expected, even for fixed $n$ different graphs will have different value of the variance. However, by computing the median variance for each system size we found that the scaling of the median is exponentially decaying with the system size. While this result does not preclude the possibility of generating graphs that will not have a barren plateau, it suggests that uniform sampling of graphs from the Erdös--Rényi model will lead to the landscape for a typical graph having a barren plateau. Then, as shown in @fig:Erdos\(b), we compute the dimension of the DLA for each graph, and find that @conjecture is confirmed, as the relation between $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ and $upright("dim") ( frak(k) )$ is linear in a log-log-scale.


= DISCUSSION
<sec:discussions>


In this work, we have explored a fundamental connection between VQAs and the theory of QOC with the purpose of analyzing the existence of barren plateaus in a family of periodic-structured ansatzes which contain, as special cases, the QAOA and the HVA, among other widely used ansatzes in variational quantum algorithms and quantum machine learning. Our results show that one can diagnose the presence of barren plateaus in the cost function landscape by analyzing the degree of controllability of the system, characterized by the dimension of the dynamical Lie algebra (DLA) obtained from the set of generators of the ansatz.


Our main results are the following. First, we show that if the DLA is full rank, i.e. if the system is controllable, then the cost function exhibits a barren plateau. This follows from the fact that, as we show, controllable systems converge to $2$-designs. Here, we also derive an expression relating the depth required for a given ansatz to become an $epsilon$-approximate two-design with the expressibility of one of its layers.


We then consider systems with symmetries, where the Hilbert space partitions into invariant subspaces associated with the different eigenspaces. In this context, we show that when the system is subspace controllable, the existence of barren plateaus crucially depends on the input state to the VQA. For example, the cost might be trainable for certain input states, but might exhibit a barren plateau for others. Specifically, our results connect the scaling of the variance of cost function partial derivatives to that of the dimension of the subspace in which the input state has support on. Instead, when the system is subspace uncontrollable, we show that one can still upper bound the variance of the cost function partial derivative using the expressibility of the ansatz in the relevant subspace. This indicates that larger subspace expressibilities leads to smaller gradients.


Finally, we present an conjecture that shows that one can directly study the scaling of the cost function partial derivative variance by computing the dimension of the subspace DLA to which the input state belongs. This conjecture implies that ansatzes with polynomially growing DLAs can exhibit polynomially vanishing gradients, while ansatzes with exponentially growing DLAs should exhibit exponentially vanishing gradients.


In addition, we performed numerical simulations of VQAs with the hardware efficient ansatz, QAOA, and HVA, for problems such as preparing ground states of the $X X Z$ model and of the Ising model, or solving MAXCUT problems on graphs generated from the Erdös--Rényi model. The numerical results match our theoretical predictions and hence verify our analytical results for controllable and subspace controllable systems. Moreover, in all cases considered we verify that our conjecture holds, further providing evidence that the scaling of the cost function partial derivative variance may be directly linked to the dimension of the subspace DLA.


#heading(level: 3, numbering: none)[Implications of our results to ansatz design]
<implications-of-our-results-to-ansatz-design>


The broader implication of our results is that the framework introduced here can be used to design ansatzes, as one could potentially predict if an ansatz, or a modification to the ansatz, will lead to the cost function exhibiting a barren plateau. Hence, our work can be considered as paving the way towards trainability-aware ansatz design.


For instance, we have shown how a simple change in the ansatz structure, such as adding an additional parametrized unitary per layer, can greatly affect the gradient scaling of the cost by changing the controllability of the system. This means that one should be careful when employing schemes such as the Adaptive QAOA or quantum optimal control ansatz as the addition of an operator $H$ to the set $cal(G)$ of generators of the ansatz can lead to barren plateaus if the system becomes controllable (or subspace controllable in an exponentially growing subspace). In particular, if $H$ does not commute with the elements in $cal(G)$, one should analyze how the DLA changes by such addition before proceeding to change the ansatz.


Here, we crucially remark that one of the main advantages of the aforementioned theoretical analysis is that it can be performed classically (either analytically or numerically) as it just requires the evaluation of the DLA. Hence, our methods save precious quantum resources as one does not need to run the quantum algorithm, or even access a quantum computer, to test the trainability of the ansatzes.


Finally, we remark that if our conjecture holds more generally, then one can use this additional tool to directly study the trainability of an ansatz by estimating the scaling of the variance of the cost function partial derivative through the scaling of the dimension of the DLA. For example, such results can be used to show that certain ansatzes might not have exponentially vanishing gradients. For instance, when considering a QAOA ansatz for solving MAXCUT on $2$-regular graphs, a straightforward computation of the DLA reveals its scaling is only linear in $n$. Hence, we expect (and we find) no barren plateaus. Similarly, one can use our conjecture to analyze ansatz proposals in the literature. For example, Ref.~@lee2021towards recently proposed an ansatz generated by the set of products up to $K$-body Pauli $X$ operators, i.e., $cal(G) = { X_i }_i union { X_i X_j }_(i > j) union { X_i X_j X_k }_(i > j > k) union dots.h.c$. Since the ansatz is abelian, the dimension of DLA is just the number of generators. Thus, we expect that when using a poly number of layers the ansatz should be rid barren plateaus.


#heading(level: 3, numbering: none)[Outlook]
<outlook>


In the present work, we have established a novel framework for diagnosing the presence of barren plateaus in VQAs. While here we mainly focus on the trainability of ansatzes for near-term quantum computing, our results should also be considered as useful in the broader context of QOC. For instance, while the barren plateau phenomenon has been recently widely studied in VQAs, it is clear from our manuscript that barren plateaus can (and will) also arise in QOC schemes (see also~@arenz2020drawing). Hence, we leave for future work to study how some of the results derived for the trainability of VQAs be used to analyze the trainability of QOC control pulses.


In addition, we note that since our work studies the trainability of certain families of ansatzes, we also leave for future work to show how the tools here presented can be employed to study more general ansatzes (e.g., ansatzes for quantum machine learning applications) which do not necessarily have a periodic structure. In addition, we leave as an open question how the results in our conjecture can be generalized and formally proved.


= ACKNOWLEDGMENTS
<acknowledgments>


We thank Marco Farinati and Robert Zeier for useful discussions on Lie-algebras, and we also thank Zoe Holmes and Pablo Poggi for helpful discussions. ML acknowledges partial support by CONICET (PIP 112201 50100493CO), UBACyT (20020130100406BA) and ANPCyT (PICT-2016-1056)). ML was also supported by the U.S. Department of Energy (DOE), Office of Science, Office of Advanced Scientific Computing Research, under the Quantum Computing Applications Team (QCAT) program and also under the Accelerated Research in Quantum Computing (ARQC) program. Piotr C. was supported by the Laboratory Directed Research and Development (LDRD) program of Los Alamos National Laboratory (LANL) under project numbers 20190659PRD4. KS acknowledges support from the National Science Foundation under Grant No. 2014010. GM was supported by the US Department of Energy, Office of Advanced Scientific Computing Research, under the ARQC program and by the LANL ASC Beyond Moore's Law project. PJC acknowledges initial support from the LANL ASC Beyond Moore's Law project. MC acknowledges initial support from the Center for Nonlinear Studies at LANL. KS, PJC, and MC also acknowledge support from LDRD program of LANL under project number 20190065DR.














#block[
#strong[A]ppendices

]








In the following appendices we present additional information and derive proofs for the main results in the manuscript. In Appendix~#ref(<sec:app:preliminaries>, supplement: none) we introduce preliminary notation and definitions that will be relevant for the rest of the appendices. Then, in Appendix~#ref(<sec:app:ansatzes>, supplement: none) we provide additional details on different widely known ansatzes that are Periodic Structure Ansatz (PSA). In Appendix~#ref(<sec:app:barren-plateaus>) we provide a brief review of barren plateaus. Appendices~#ref(<app:proof_theo_convergence>, supplement: none)--#ref(<app:proof_su2>, supplement: none) contain the proofs of our main Theorems, Corollaries and Propositions. Finally, in Appendix~#ref(<App:XXZ>, supplement: none) we discuss the symmetries in the $X X Z$ and Ising spin models considered in the main text, and in Appendix~#ref(<App:numerical>, supplement: none) we provide additional details on the initial state used for the numerical simulations of the $X X Z$ model.


= Preliminaries
<sec:app:preliminaries>
Let us first review some definitions and prior results that will be relevant for the rest of the appendices.





#strong[Properties of the Haar measure.] Let $cal(U) ( d )$ denote the group of $d times d$ unitary matrices. Let $d mu_H ( V ) = d mu ( V )$ be the volume element of the Haar measure, where $V in cal(U) ( d )$. Then, the Haar measure has the following properties: (1) The volume of the Haar measure is finite: $integral_(cal(U) ( d )) d mu ( V ) < oo$. (2) The Haar measure is uniquely defined up to a multiplicative constant factor. (3) Let $d zeta ( V )$ be an invariant measure. Then there exists a constant $c$ such that $d zeta ( V ) = c dot.op d mu ( V )$. (4) The Haar measure is left- and right-invariant under the action of the unitary group of degree $d$, i.e., for any integrable function $g ( V )$, the following holds:


$ integral_(cal(U) ( d )) d mu ( V ) g ( W V ) = integral_(cal(U) ( d )) d mu ( V ) g ( V W ) = integral_(cal(U) ( d )) d mu ( V ) g ( V ) , $


where $W in cal(U) ( d )$.





#strong[Symbolic integration.] Let us present formulas that allow for the symbolical integration with respect to the Haar measure on a unitary group~@puchala2017symbolic. For any $V in cal(U) ( d )$ the following expressions are valid for the first two moments:


$ integral_(cal(U) ( d )) d mu ( U ) u_(bold(i) bold(j)) u_(bold(p) bold(k))^(*) & = frac(delta_(bold(i) bold(p)) delta_(bold(j) bold(k)), d) thin ,\
integral_(cal(U) ( d )) d mu ( U ) u_(bold(i)_1 bold(j)_1) u_(bold(i)_2 bold(j)_2) u_(bold(i)'_1 bold(j)'_1)^(*) u_(bold(i)'_2 bold(j)'_2)^(*) & = frac(delta_(bold(i)_1 bold(i)'_1) delta_(bold(i)_2 bold(i)'_2) delta_(bold(j)_1 bold(j)'_1) delta_(bold(j)_2 bold(j)'_2) + delta_(bold(i)_1 bold(i)'_2) delta_(bold(i)_2 bold(i)'_1) delta_(bold(j)_1 bold(j)'_2) delta_(bold(j)_2 bold(j)'_1), d^2 - 1) - frac(delta_(bold(i)_1 bold(i)'_1) delta_(bold(i)_2 bold(i)'_2) delta_(bold(j)_1 bold(j)'_2) delta_(bold(j)_2 bold(j)'_1) + delta_(bold(i)_1 bold(i)'_2) delta_(bold(i)_2 bold(i)'_1) delta_(bold(j)_1 bold(j)'_1) delta_(bold(j)_2 bold(j)'_2), d ( d^2 - 1 )) thin , $<eq:delta>


where $u_(bold(i) bold(j))$ are the matrix elements of $U$. Assuming $d = 2^n$, we use the notation $bold(i) = ( i_1 , dots.h i_n )$ to denote a bitstring of length $n$ such that $i_1 , i_2 , dots.h , i_n in ( 0 , 1 )$.





#strong[Useful Identities.] We introduce the following identities, which can be derived using Eq.~@eq:delta (see~@cerezo2020cost for a review):


$integral_(cal(U) ( d )) d mu ( U ) "Tr" [U A U^dagger B] & = frac("Tr" \[ A \] "Tr" \[ B \], d) ,$ <Eq_lemma1>
$integral_(cal(U) ( d )) d mu ( U ) "Tr" [U A U^dagger B U C U^dagger D] & = frac("Tr" \[ A \] "Tr" \[ C \] "Tr" \[ B D \] + "Tr" \[ A C \] "Tr" \[ B \] "Tr" \[ D \], d^2 - 1) - frac("Tr" \[ A C \] "Tr" \[ B D \] + "Tr" \[ A \] "Tr" \[ B \] "Tr" \[ C \] "Tr" \[ D \], d (d^2 - 1)) ,$ <Eq_lemma2>
$integral_(cal(U) ( d )) d mu ( U ) "Tr" [U A U^dagger B] "Tr" [U C U^dagger D] & = frac("Tr" \[ A \] "Tr" \[ B \] "Tr" \[ C \] "Tr" \[ D \] + "Tr" \[ A C \] + "Tr" \[ B D \], d^2 - 1) - frac("Tr" \[ A C \] "Tr" \[ B \] "Tr" \[ D \] + "Tr" \[ A \] "Tr" \[ C \] "Tr" \[ B D \], d (d^2 - 1)) , $ <Eq_lemma3>


where $A , B , C$, and $D$ are linear operators on a $d$-dimensional Hilbert space.





#strong[Integration over parameter space]: In the next sections we will derive analytical expressions for the variance of the partial derivatives of cost functions $C ( bold(theta) )$ over parametrized circuits $U ( bold(theta) )$. In such derivations, we will have to deal with integration over the parameter space. A key step in the following analysis will be to relate the integration over parameters with integration over the ensemble of unitaries arising from different parameter choices. In this sense, we recall that given a set of parameters ${ bold(theta) }$ one can obtain an associated set of unitaries generated by the quantum circuit ${ U ( bold(theta) ) }$. Then, consider the integration of some function $f ( U ( bold(theta) ) )$ over $bold(theta)$. Defining $bb(U)$ as the distribution of unitaries generated by $U ( bold(theta) )$, the following identity holds


$ integral_(bold(theta)) d bold(theta) f ( U ( bold(theta) ) ) = integral_(bb(U)) d U f ( U ) thin . $<eq:paramstounit>


In addition, if the distribution of unitaries $bb(U)$ can be shown to converge to a $2$-design, the integration over the distibution can be further converted into an integration over the Haar measure


$ integral_(bb(U)) d U arrow.r integral_(cal(U) ( d )) d mu ( U ) $<eq:tohaar>


allowing the use of identities @Eq_lemma1, [\[Eq\_lemma2\]], and~[\[Eq\_lemma3\]].


= Ansatzes
<sec:app:ansatzes>
In general, ansatzes for parametrized quantum circuits can be divided into two primary categories: problem-agnostic and problem-inspired ansatzes. In a problem agnostic ansatz one does not have any information about the problem, or its solution, that one can encode in the ansatz. Such is the case for instance in a task of estimating the spectrum of an unknown density operator~@cerezo2020variational. On the other hand, problem-inspired ansatzes employ prior information about a given problem or task. For example, for the problem of estimating the ground state energy of a particular Hamiltonian, one can design ansatzes that preserve the symmetry of the problem Hamiltonian~@gard2020efficient.


Here we remark that several well known problem-agnostic and problem-inspired ansatzes in the literature are PSAs of the form in Eq.~@eq:ansatz. In particular, our framework allows us to study the hardware-efficient ansatz (HEA) @kandala2017hardware, quantum alternating operator ansatz (QAOA) @farhi2014quantum, Adaptive QAOA @hadfield2019quantum @zhu2020adaptive, Hamiltonian variational ansatz (HVA) @wecker2015progress, and Quantum Optimal Control Ansatz (QAOC) @choquette2020quantum.


Below we provide several examples of problem-inspired and problem-agnostic PSA and highlight their advantages in different problems.





#strong[Hardware efficient ansatz.] The Hardware Efficient Ansatz (HEA) is a problem-agnostic ansatz, which relies on gates native to a quantum hardware. In particular, an ansatz can be designed based on a gate alphabet, which depends on the architecture and the connectivity of a given quantum hardware. This procedure helps in avoiding the overhead associated with transpiling an arbitrary unitary into a sequence of native gates. For example, one can consider native gates, such as single qubit rotations $e^(- i theta / 2 Z) e^(- i gamma / 2 Y)$ and CNOTs, where $Y$ and $Z$ denote Pauli matrices, and a CNOT between the control qubit $i$ and the target qubit $j$ is given by: $e^(-i pi / 2 ((|1 chevron.r chevron.l 1|)_i ⊗ (X_j - I_j)))$. Then an ansatz of the form in @eq:ansatz can be generated as follows: one layer consists of parametrized single qubit rotations on each qubit, followed by unparametrized CNOTs acting on neighboring qubits.


The HEA has been employed to prepare the ground state of molecules @kandala2017hardware, to study Hamiltonians that are similar to the device's interactions @kokail2019self, and in several other variational quantum algorithms @khatri2019quantum @sharma2019noise @tkachenko2020correlation @cerezo2020cost. The HEA is also suitable in the near-term implementations of VQAs due to its low-depth structure which results into a lower-noise circuit in comparison to other ansatze~@tkachenko2020correlation @wang2020noise.





#strong[Quantum alternating operator ansatz.] The Quantum Alternating Operator Ansatz (QAOA) is a problem-inspired ansatz that simulates the discretized adiabatic transformations @farhi2014quantum. Consider a goal of preparing the ground state of a problem Hamiltonian $H_P$. Let $H_M$ denote a mixer Hamiltonian, with corresponding ground state $| psi chevron.r$. Then the QAOA maps $| psi chevron.r$ to the ground state of $H_P$ by sequentially applying the problem unitary $e^(- i gamma_l H_P)$, followed by the mixer unitary $e^(- i beta_l H_M)$. Let $bold(theta) = ( bold(gamma) , bold(beta) )$. Then the QAOA is given by $U ( bold(theta) ) = product_(l = 1)^L e^(- i beta_l H_M) e^(- i gamma_l H_P)$, which follows the general form of the ansatz defined in @eq:ansatz. Here, $p$ is the order of the discretized adiabatic transformation and it determines the precision of the solution @farhi2014quantum. The QAOA was originally introduced for finding approximate solutions to combinatorial optimization problems @farhi2014quantum. The QAOA has been generalized as a standalone ansatz @hadfield2019quantum and its performance has been investigated in several tasks, including the task of learning a unitary @kiani2020learning. Moreover, the QAOA has been shown to be computationally universal @lloyd2018quantum @morales2020universality, and the choice of optimal mixer is still an open debate~@wang2020x @bartschi2020grover.





#strong[Adaptive QAOA.] As a consequence of the adiabatic theorem, the QAOA should lead to good solutions for high values of $p$ @farhi2014quantum. However, for small values of $p$, the QAOA is an #emph[ad-hoc] ansatz, which is not necessarily an optimal strategy to approximate the ground state of the problem Hamiltonian. A way to improve such an #emph[ad-hoc] ansatz is to employ a variable mixer instead of a fixed mixer at each layer @hadfield2019quantum. Let ${ G_k }_(k = 1)^q$ denote a set of mixer Hamiltonians. Then an adaptive QAOA can be defined as follows: $U ( bold(theta) ) = product_(l = 1)^L e^(- i beta_l G_l) e^(- i gamma_l H_p)$, where each $G_l$ can be adaptively picked from ${ G_k }_(k = 1)^q$.


One particular adaptive approach was introduced in @zhu2020adaptive, where at each layer, $G_l$ is picked based on the largest gradient of the cost function among all ${ G_l }$. Moreover, @zhu2020adaptive observed that adaptive entangling mixers can improve performance and reduce the number of parameters and CNOTs to achieve a desired accuracy in comparison to the non-adaptive QAOA. We note that the adaptive QAOA follows the form in @eq:ansatz if adaptive mixers are learned up to a fixed layer and then the whole structure is repeated. That is, $U ( bold(theta) ) = product_(m = 1)^p product_(l = 1)^r e^(- i beta_(l , m) G_(l , m)) e^(- i gamma_(l , m) H_P)$, where $G_(l , 1)$ are learned adaptively for each $l in ( 1 , dots.h , r )$, and $G_(l , 1) = G_(l , m)$ for all $m in ( 1 , dots.h , m )$.





#strong[Hamiltonian variational ansatz.] The Hamiltonian variational ansatz is another problem-inspired ansatz, which implements time evolution under problem Hamiltonian via Trotterization @wecker2015progress. It can be understood as a generalization of the QAOA to more than two non-commuting Hamiltonians. Let $H_P = sum_l H_l$ denote a problem Hamiltonian, such that $[ H_l , H_(l') ] eq.not 0$. Then the HVA of order $p$ is given by $U ( bold(theta) ) = product_(k = 1)^p product_l e^(- i theta_(l , k) H_l)$, which is in the form of @eq:ansatz. The HVA has been investigated in studying one- and two-dimensional quantum many-body models @ho2019efficient @cade2020strategies.


A simple example where the HVA can be employed is the XXZ model to study magnetism. For a one-dimensional chain, the Hamiltonian for the XXZ model is given by $H_(X X Z) = - sum_(l = 1)^n X_l X_(l + 1) + Y_l Y_(l + 1) + g Z_l Z_(l + 1)$, where $g$ determines the phase of magnetisation. Let $H_A = sum_(l = 1)^n A_l A_(l + 1)$, where $A in ( X , Y , Z )$. Then, one way to parametrize a HVA of order $p$ is as follows: $U ( bold(theta) ) = product_(l = 1)^p e^(- i beta_l H_X) e^(- i gamma_l H_Y) e^(- i delta_l H_Z)$ for $g = 1$, and where $bold(theta) = ( bold(beta) , bold(gamma) , bold(delta) )$. Another way to parametrize a HVA is as follows: $U ( bold(theta) ) = product_(l = 1)^p e^(- i beta_l ( H_X + H_Y )) e^(- i delta_l H_Z)$, where we redefined $bold(theta) = ( bold(beta) , bold(delta) )$.





#strong[Quantum optimal control ansatz.] The HVA discussed above helps constraining the variational search to a relevant symmetric subspace of the the total Hilbert space. In general, this approach might require high values of $p$ to achieve a desired accuracy in approximating the ground state of many-body Hamiltonians. One way to avoid high values of $p$ is to introduce drive terms in addition to the problem Hamiltonian, which break the symmetry of the problem Hamiltonian $H_p$. This approach falls under the framework of quantum optimal control @choquette2020quantum. In particular, let ${ hat(H)_k }$ denote a set of drive terms. Then the update time-dependent Hamiltonian is given by $macron(H) ( t ) = H_P + sum_k c_k ( t ) H_k$, where drive terms $H_k$ are picked such that $[ H_P , H_k ] eq.not 0$ for all $k$. Here, $c_k ( t )$ are time-dependent control parameters. Let $H_P = sum_q H_q$ and let $bold(theta) = ( bold(gamma) , bold(beta) )$. Then the Quantum Optimal Control Ansatz (QOCA) of order $L$ is given by $U ( bold(theta) ) = product_(l = 1)^L product_q e^(- i beta_(l , q) H_q) product_k e^(- i gamma_(l , k) H_k)$, where $gamma_(l , k)$ denote the discrete drive amplitudes of the control parameter $c_k ( t )$.


In general, finding an optimal drive Hamiltonian terms ${ H_k }$ is a computationally challenging problem. One can employ an adaptive approach to pick drive Hamiltonians from a fixed set of Hamiltonian, similar to the adaptive QAOA @zhu2020adaptive. In @choquette2020quantum, the QOCA was shown to outperform other ansatze, including the HEA and the HVA for the task of preparation of the ground state of the half-filled Fermi Hubbard model.


= Barren Plateaus
<sec:app:barren-plateaus>


As mentioned in the main text, the barren plateau phenomenon has been recognized as one of the most important challenges to overcome to guarantee the success of VQAs. When a cost function exhibits a barren plateau, its gradients are exponentially suppressed (in average) across the optimization landscape. Consider the following mathematical definition.


#thmbox("definition", "Definition (Barren Plateau)")[


A cost function $C ( bold(theta) )$ as in Eq.~@eq:cost is said to have a barren plateau when training $theta_mu equiv theta_(p q) in bold(theta)$, if the cost function partial derivative $partial C ( bold(theta) ) / partial theta_mu equiv partial_mu C ( bold(theta) )$ is such that


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] lt.eq F ( n ) thin , quad upright("with") quad F ( n ) in cal(O) (1 / b^n) thin , $<eq:BPSM>


for some $b > 1$. Here the variance is taken with respect to the set of parameters $bold(theta)$.


] <def:BPSM>


From Chebyshev inequality we know that $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ bounds the probability that $partial_mu C ( bold(theta) )$ diverges from its average (of zero) as $P ( | ( partial_mu C ( bold(theta) ) | > c ) lt.eq upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] / c^2$ for any $c > 0$.


Equation~@eq:BPSM implies that one requires a precision (i.e., a number of shots) that grows exponentially with $n$ to navigate trough the flat landscape and determine a cost minimizing direction when optimizing the cost function. Moreover, as shown in~@cerezo2020impact @arrasmith2020effect, barren plateaus affect both gradient-based and gradient-free methods meaning that simply changing the optimization strategy does not mitigate or solve the barren plateau issues. Since the goal of VQAs is to have computational complexities that scale polynomial with $n$, such exponential scaling in the required precision destroys the hope of achieving a computational advantage with the VQA over classical methods (which usually scale exponentially with $n$).


The first result for barren plateaus was obtained in~@mcclean2018barren, where it was shown that deep unstructured ansatz that form $2$-designs have barren plateaus. This phenomenon was then generalized to layered Hardware Efficient Ansatzes in~@cerezo2020cost were it was proven that the locality of the cost function is connected to the existence of barren plateaus. That is, global cost functions (i.e., cost functions where $O$ in~@eq:cost acts non-trivially in all qubits) exhibit barren plateaus even for shallow depths, whereas local cost functions (i.e., cost functions where $O$ in~@eq:cost acts non-trivially in a small number of neighboring qubits) do not exhibit barren plateaus for short-depth ansatzes.


The barren plateaus phenomenon has also been studied in the context of quantum neural networks~@sharma2020trainability @pesah2020absence @zhao2021analyzing, and to the problem of learning scramblers~@holmes2020barren. In addition, it has been shown that circuits that generate large amounts of entanglement~@sharma2020trainability @patti2020entanglement @marrero2020entanglement are prone to suffer from barren plateaus. To circumvent or mitigate the effect of barren plateaus, several strategies have been developed~@verdon2019learning @volkoff2021large @skolik2020layerwise @grant2019initialization @pesah2020absence @zhang2020toward @bharti2020quantum @cerezo2020variational @sauvage2021flip @liao2021quantum.


= Quantum Optimal Control
<app:qoc>


Here we recall for convenience that in a standard QOC setting one is interested in controlling the dynamical evolution of a quantum state $| psi chevron.r$ in a$d$-dimensional Hilbert space $cal(H) = bb(C)^d$ (where $d = 2^n$)~@dalessandro2010introduction. Here, the system dynamics are determined by a Hamiltonian


$ H({f_(k)(t)}) = H_(0)+sum_(k=1)^(K) f_(k)(t)H_(k) $ <eq:QOC_Hamiltonian2>


that is tunable through some time-dependent control fields functions ${ f_k ( t ) }$.


At its core, the problem in QOC is to determine how to shape the control fields such that the system evolves in a desired manner. A specific set of optimal fields is usually constructed by imposing a parametrization on the functions and applying standard numerical optimization routines. The success of such optimization process depends on the structure of the underling optimization spaces, the so-called quantum control landscapes @chakrabarti2007quantum @larocca2018quantum @larocca2020exploiting.


For instance, a common choice is to consider piece-wise constant fields where the protocol duration $T$ is divided in $L$ intervals $Delta t_j = t_j - t_(j - 1)$ (such that $T = sum_(j = 1)^L Delta t_j$) at each of which the fields take a constant value, e.g., $f_k ( t ) = f_(k , j)$ if $t_(j - 1) < t < t_j$. In this case, the propagator factorizes into a product of individual sub-propagators, each of which is generated by a constant Hamiltonian and thus leads to the simple matrix exponential form


$ U ( { f_k ( t ) } ) = product_(l = 1)^L e^(- i tilde(H)_l Delta t_l) , thin thin thin tilde(H)_l = #h(-1em) H_0 + sum_(k = 1)^K f_(l , k) H_k thin . $<eq:QOC_propagator>


By Trotterizing Eq. @eq:QOC_propagator one finds


$ U ( { f_k ( t ) } ) approx product_(l = 1)^L product_(k = 0)^K e^(- i H_k Delta t_l f_(l , k)) thin , $<eq:QOC_propagatorTrot>


where $f_(l , 0) = 1$ for all $l$. Note that~@eq:QOC_propagatorTrot is a PSA of the form of Eq.~@eq:ansatz, through the identification


$ theta_(l , 0) = Delta t_0 thin , quad quad theta_(l , k) = Delta t_l f_(l , k) , quad k gt.eq 1 thin . $<eq:correspondence>


We remark that in the limit $Delta t_l arrow.r 0$, Eq.~@eq:QOC_propagatorTrot becomes exact. In the general case, the exact and Trotterized ansatzes approximately coincide, and a nontrivial correction of Eq.~@eq:correspondence is needed to make the correspondence exact. In any case, Eq.~@eq:correspondence allows us to henceforth use the notation $U ( { f_k ( t ) } ) = U ( bold(theta) )$ and indicate with $bold(theta)$ the trainable parameters in a QOC setting.


= Dynamical Lie Algebra computation
<app:alg>


First, let us recall that a Lie algebra is a vector space $frak(g)$ together with an operation $[ dot.op , dot.op ] : frak(g) arrow.r  frak(g)$ called #emph[Lie bracket] that is bilinear, #emph[alternating] (the output is zero if the inputs are linearly dependent) and satisfies the identity $[ x , [ y , z ] ] + [ y , [ z , x ] ] + [ z , [ x , y ] ] = 0$, known as the Jacobi identity. Lie algebras are vector spaces that are #emph[closed] under such Lie bracket, i.e. $[ x , y ] in frak(g)$ for all $x , y in frak(g)$. Note that this operation is not necessarily associative, i.e. $[ x [ y , z ] eq.not [ [ x , y ] , z ]$. In fact, this is precisely what the Jacobi identity captures: how the order of evaluation affects the result of the operation.


In our quantum context, Lie algebras manifest as matrix Lie algebras. For example, the space of quantum observables $frak(u) ( d )$ is a subspace of the vector space of $d times d$ complex matrices that is closed under matrix commutator (playing the role of a Lie bracket). More generally, we will encounter ourselves with Lie algebras that form Lie subalgebras of $frak(u) ( d )$. A subalgebra is a subspace of an algebra that is itself closed under the Lie bracket. For example, in a $n$ qubit quantum system, the subspace $Omega = upright("span") ( X , Y , Z )$, where $X = sum_i X_i$, $Y = sum_i Y_i$ and $Z = sum_i Z_i$ is closed under commutation and thus constitutes a 3-dimensional subalgebra of the $4^n$-dimensional operator space.


Specifically, we will be interested in the so-called #emph[dynamical Lie algebra] (DLA). This Lie algebra is the subspace of $frak(u) ( d )$ generated by the Lie closure of the generators of a paramterized quantum circuit (see Definition~#ref(<def:dynamical-lie-algebra>, supplement: none)). In general, computing the DLA is a highly nontrivial task. One possible approach to the DLA is direct construction, i.e. start with a set of generators defining a subspace of operator space (but not a subalgebra), and start commuting them, finding new elements until one obtains a basis of the DLA (see Algorithm~#ref(<alg:lie>, supplement: none)). The complexity of such approach is, in general, $cal(O) ( upright("poly") ( d ) )$ with $d = 2^n$, that is, exponential in $n$ the number of qubits. For example, a naive approach (representing operators as dense $d times d$ matrices) yields roughly $cal(O) ( d^2 d^6 )$, since, in general, one has to check linear independence $cal(O) ( d^2 )$, for example by implementing LU or QR decompositions (whose cost is $cal(O) ( N^3 )$ for $N times N$ matrices) on such $d times d$ matrices. Although such complexity can be reduced, for example, using more intelligent representations of operators, in essence direct construction is attempting to build a basis for a subalgebra of $frak(s u) ( d^2 )$, i.e. a basis with potentially as many as $d^2$ elements, and therefore it cannot generally avoid exponentiality.


Despite being exponential, direct construction of the DLA (either numerically or analitically) on small system sizes can constitute a remarkably useful tool to later extrapolate or prove the scaling (e.g. by induction) of the DLA beyond those small 'afforable' system sizes. Moreover, note that in many cases one may only be interested in checking whether the dimension of the DLA is above a certain threshold, a task with complexity linear in the size of such threshold. Of course, this is neglecting the complexity of computing new DLA elements, which, as mentioned above, can be substantially diminished by choosing efficient representations for those operators.


#figure(
  placement: top,
  kind: "algorithm",
  supplement: [Algorithm],
  numbering: "1",
  caption: [Basis for the Dynamical Lie Algebra (DLA).],
  block(width: 100%, stroke: 0.5pt, inset: 8pt)[
    #set par(justify: false)
    #set text(size: 9pt)
    #set align(left)
    #grid(columns: (auto, 1fr), column-gutter: 0.7em, row-gutter: 0.3em,
      [*Input:*], [Set of generators $cal(G)$ of the ansatz.],
      [*Output:*], [Basis $S$ of the algebra $frak(k)$ obtained from $cal(G)$],
      [*Init:*], [$S arrow.l cal(G)$, $S_"prev" arrow.l cal(G)$, $S_"new" arrow.l emptyset$, $C arrow.l "id"$, $"new" arrow.l 1$],
    )
    #v(0.5em)
    *while* $"new" > 0$: \
    #pad(left: 1.2em)[
      $S_"new" arrow.l emptyset$ \
      *for* $h_0 in cal(G)$: \
      #pad(left: 1.2em)[
        *for* $h in S_"prev"$: \
        #pad(left: 1.2em)[
          $C arrow.l [h_0, h]$ \
          *if* $S union {C}$ is linearly independent: \
          #pad(left: 1.2em)[
            $S arrow.l S union {C}$ \
            $S_"new" arrow.l S_"new" union {C}$
          ]
        ]
      ]
      $"new" arrow.l |S_"new"|$ \
      $S_"prev" arrow.l S_"new"$
    ]
    *return* $S$
  ]
) <alg:lie>



= Proof of Theorem 1: Convergence of controllable systems to 2-designs
<app:proof_theo_convergence>


In the following we provide a proof for @theo:depth, which we recall for convenience.


#thmbox("theorem", "Theorem")[


Consider a controllable system. Then, the PSA $U ( bold(theta) )$ will form an $epsilon$-approximate $2$-design, i.e. $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = epsilon$ with $epsilon.alt > 0$, when the number of layers $L$ in the circuit is


$ L = frac(log ( 1 / epsilon ), log (1 / bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo)) thin . $


Here $bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo$ denotes the expressibility of a single layer $U_1 ( bold(theta)_1 )$ of the ansatz according to Eqs.~@eq:ansatz and~@eq:superop.


] <theo:depthSM>


#block[
#emph[Proof.]~◻

]


To study the convergence of the PSA $U ( bold(theta) )$ to an approximate $2$-design we employ the tools of Harmonic analysis. The following arguments are based on Ref.~@brown2010random. This is similar to using Fourier analysis to study the convergence of a probability distribution on a real line to the normal distribution, which is also known as the central limit theorem.


The second moment operator corresponding to the distribution $bb(U)$ over unitaries $U$ can be defined as follows


$ M_U^(( 2 )) = integral_(bb(U)) d U U ⊗ U ⊗ U^(*) ⊗ U^(*) thin . $


Let $M_(U_H)^(( 2 ))$ denote the second moment operator corresponding to the Haar distribution. Our goal is to evaluate the difference between $M_U^(( 2 ))$ and $M_(U_H)^(( 2 ))$. Let us review some properties of $M_(U_H)^(( 2 ))$ before we calculate this distance operator. An important property of $M_(U_H)^(( 2 ))$ is that it is a projector onto a two-dimensional subspace, that is, $M_(U_H)^(( 2 ))$ has eigenvalues $0$ or $1$. We show this by noting that the following equations hold:


$ ( M_(U_H)^(( 2 )) )^2 & = (integral_(cal(U) ( d )) d mu ( U ) U ⊗ U ⊗ U^(*) ⊗ U^(*)) (integral_(cal(U) ( d )) d mu ( V ) V ⊗ V ⊗ V^(*) ⊗ V^(*))\
 & = integral_(cal(U) ( d )) d mu ( U ) integral_(cal(U) ( d )) d mu ( V ) (U V ⊗ U V ⊗ ( U V )^(*) ⊗ ( U V )^(*))\
 & = integral_(cal(U) ( d )) d U d W (W ⊗ W ⊗ W^(*) ⊗ W^(*))\
 & = integral_(cal(U) ( d )) d W W ⊗ W ⊗ W^(*) ⊗ W^(*)\
 & = M_(U_H)^(( 2 )) thin , $<eq:invariance>


and


$ upright("Tr") [M_(U_H)^(( 2 ))] & = upright("Tr") [integral_(cal(U) ( d )) d mu ( U ) U ⊗ U ⊗ U^(*) ⊗ U^(*)]\
 & = sum_(i , j , k , l = 1)^d integral_(cal(U) ( d )) d mu ( U ) U_(i , i) U_(j , j) U_(k , k)^(*) U_(l , l)^(*)\
 & = frac(2, d^2 - 1) sum_(i , j = 1)^d 1 - frac(2, d ( d^2 - 1 )) sum_(i = 1)^d 1\
 & = 2 thin . $<eq:wein>


In Eq.~@eq:invariance, we used the left invariance of the Haar measure, and in~@eq:wein we used the Weingarten function to explicitly evaluate the integral. The first property puts in evidence that $M_(U_H)^(( 2 ))$ is a projector and the second property shows that the eigenspace with eigenvalue 1 is a two-dimensional subspace.


Let $V = U_L dots.h.c U_2 U_1$, be an $L$-layered PSA, where each unitary $U_j$ is sampled from the same distribution $d mu = P ( U ) d U$. Then, the probability distribution and moment operator of $V$ are respectively given by


$ mu_L \[ V \] & = integral_(cal(U) ( d )) d U_1 integral_(cal(U) ( d )) d U_2 dots.h.c integral_(cal(U) ( d )) d U_L P ( U_1 ) P ( U_2 ) dots.h.c P ( U_L ) delta ( V - U_L dots.h.c U_2 U_1 ) thin ,\
M_V^(( 2 )) & = integral_(cal(U) ( d )) d mu_L \[ V \] quad V ⊗ V ⊗ V^(*) ⊗ V^(*)\
 & = integral_(cal(U) ( d )) d V integral_(cal(U) ( d )) d U_1 integral_(cal(U) ( d )) d U_2 dots.h.c integral_(cal(U) ( d )) d U_L P ( U_1 ) P ( U_2 ) dots.h.c P ( U_L ) delta ( V - U_L dots.h.c U_2 U_1 ) quad V ⊗ V ⊗ V^(*) ⊗ V^(*)\
 & = integral_(cal(U) ( d )) d U_1 integral_(cal(U) ( d )) d U_2 dots.h.c integral_(cal(U) ( d )) d U_L P ( U_1 ) P ( U_2 ) dots.h.c P ( U_L ) quad ( product_(l = 1)^L U_l ) ⊗ ( product_(l = 1)^L U_l ) ⊗ ( product_(l = 1)^L U_l^(*) ) ⊗ ( product_(l = 1)^L U_l^(*) )\
 & = product_(l = 1)^L integral_(cal(U) ( d )) d U_l P ( U_l ) U_l ⊗ U_l ⊗ U_l^(*) ⊗ U_l^(*)\
 & = (M_(U_1)^(( 2 )))^L thin . $<eq:momentV>


Equation~@eq:momentV shows that the moment operator of an $L$-layered ansatz is equal to the $L$-th power of the moment operator of a single layer. We can also calculate this formally. In our case each $U_l$ is given by $U_l = product_(k = 1)^K e^(- i theta_(l k) H_k)$, where $cal(G) = { H_k }_(k = 1)^K$ are the set of generators, and where the $theta_(l k)$ are sampled from the uniform distribution. Then, let us note that


$ M_(U_1)^(( 2 )) & = (frac(1, 2 pi))^n integral product_(k = 1)^K d theta_k product_(k = 1)^K e^(- i theta_k H_k) ⊗ product_(k = 1)^K e^(- i theta_k H_k) ⊗ product_(k = 1)^K e^(i theta_k H_k^(*)) ⊗ product_(k = 1)^K e^(i theta_k H_k^(*))\
 & = (frac(1, 2 pi))^n product_(k = 1)^K integral d theta_k e^(- i theta_k H_k) ⊗ e^(- i theta_k H_k) ⊗ e^(i theta_k H_k^(*)) ⊗ e^(i theta_k H_k^(*))\
 & = (frac(1, 2 pi))^n product_(k = 1)^K (V_k^(⊗ 2) ⊗ V_k^(* ⊗ 2)) integral d theta_k sum_(l_(1 , k) , l_(2 , k)\
l_(3 , k) , l_(4 , k)) e^(- i theta_k ( l_(1 , k) + l_(2 , k) - l_(3 , k) - l_(4 , k) )) | #h(0em) l_(1 , k) , l_(2 , k) , l_(2 , k) , l_(4 , k) chevron.r chevron.l l_(1 , k) , l_(2 , k) , l_(2 , k) , l_(4 , k) #h(0em) | (W_k^(⊗ 2) ⊗ W_k^(* ⊗ 2))^dagger\
 & = product_(k = 1)^K (W_k^(⊗ 2) ⊗ W_k^(* ⊗ 2)) sum_(l_(1 , k) , l_(2 , k)\
l_(3 , k) , l_(4 , k)) delta ( l_(1 , k) + l_(2 , k) - l_(3 , k) - l_(4 , k) ) | #h(0em) l_(1 , k) , l_(2 , k) , l_(3 , k) , l_(4 , k) chevron.r chevron.l l_(1 , k) , l_(2 , k) , l_(3 , k) , l_(4 , k) #h(0em) | (W_k^(⊗ 2) ⊗ W_k^(* ⊗ 2))^dagger thin . $





Here $H_k | l_(i , k) chevron.r = l_(i , k) | l_(i , k) chevron.r$, and $W_k$ is the unitary matrix that diagonalizes $H_k$. To calculate the distance to a $2$-design we need to prove some properties of eigenvalues and eigenvectors of $M_(U_1)^(( 2 ))$. Let $| phi.alt chevron.r$ be an eigenvector of $M_(U_1)^(( 2 ))$ with associated eigenvalue $lambda$. Then,


$ | chevron.l phi.alt | M_(U_1)^(( 2 )) | phi.alt chevron.r | = | lambda | & = | integral_(cal(U) ( d )) d U_1 med P ( U_1 ) med chevron.l phi.alt | U_1 ⊗ U_1 ⊗ U_1^(*) ⊗ U_1^(*) | phi.alt chevron.r |\
 & lt.eq integral_(cal(U) ( d )) d U_1 med P ( U_1 ) med | chevron.l phi.alt | U_1 ⊗ U_1 ⊗ U_1^(*) ⊗ U_1^(*) | phi.alt chevron.r |\
 & lt.eq 1 thin . $


The equality holds if and only if $| phi.alt chevron.r$ is an eigenvector of $U ⊗ U_1 ⊗ U_1^(*) ⊗ U_1^(*) forall U_1$, such that $P ( U_1 ) eq.not 0$. For the specific case of Haar measure, this means that $| phi.alt chevron.r$ is an eigenvector of $U ⊗ U ⊗ U^(*) ⊗ U^(*) forall U in cal(S) cal(U) ( d )$. We already showed that there are two such eigenvectors for Haar measure with eigenvalue 1.


Now, using the following argument we hope to show that those two are also the only eigenvectors of $M_(U_1)^(( 2 ))$ with eigenvalue 1, given that the set $cal(G)$ is controllable. Let $| phi.alt chevron.r$ be an eigenvector of $M_(U_1)^(( 2 ))$ with eigenvalue 1. One can now also see that $| phi.alt chevron.r$ is also an eigenvector of $M_V^(( 2 ))$ (since $M_V^(( 2 )) = ( M_(U_1)^(( 2 )) )^L$) $forall L in bb(Z)^(+)$. Then, $cal(G)$ being a controllable set implies that for all $U in cal(S) cal(U) ( d )$, there exists an $L$ for which $V = product_(l = 1)^L product_(k = 1)^K e^(- i theta_(l k) H_k) = U$ so that $P ( U ) eq.not 0$. That, is one can obtain any unitary in $cal(U) ( d )$ by tuning the parameters in $V$. It also implies that $| phi.alt chevron.r$ has to be an eigenvector of $U ⊗ U ⊗ U^(*) ⊗ U^(*)$ with eigenvalue 1. But this means that $| phi.alt chevron.r$ is an eigenvector of $U ⊗ U ⊗ U^(*) ⊗ U^(*)$ with eigenvalue 1 $forall U in cal(S) cal(U) ( d )$. So $| phi.alt chevron.r$ is also an eigenvector of $M_2 [ mu_H ]$ with eigenvalue 1, and there are two such eigenvectors. Let us call them $| phi.alt_1 chevron.r$, and $| phi.alt_2 chevron.r$. Hence, we have


$ M_(U_H)^(( 2 )) & = | #h(0em) phi.alt_1 chevron.r chevron.l phi.alt_1 #h(0em) | + | #h(0em) phi.alt_2 chevron.r chevron.l phi.alt_2 #h(0em) |\
M_(U_1)^(( 2 )) & = | #h(0em) phi.alt_1 chevron.r chevron.l phi.alt_1 #h(0em) | + | #h(0em) phi.alt_2 chevron.r chevron.l phi.alt_2 #h(0em) | + sum_(i = 1)^(d^4 - 2) lambda_i | #h(0em) psi_i chevron.r chevron.l psi_i #h(0em) |\
M_V^(( 2 )) & = | #h(0em) phi.alt_1 chevron.r chevron.l phi.alt_1 #h(0em) | + | #h(0em) phi.alt_2 chevron.r chevron.l phi.alt_2 #h(0em) | + sum_(i = 1)^(d^4 - 2) lambda_i^L | #h(0em) psi_i chevron.r chevron.l psi_i #h(0em) | thin . $


Here ${ lambda_i }$ is the set of the remaining eigenvalues such that $0 lt.eq | lambda_i | < 1$. Let $lambda_(upright("max"))$ be the eigenvalue with maximum modulus. Thus, we can now show that $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = bar.v.double M_(U_H)^(( 2 )) - M_V^(( 2 )) bar.v.double_oo = bar.v.double sum_(i = 1)^(N^4 - 2) lambda_i^k | #h(0em) psi_i chevron.r chevron.l psi_i #h(0em) | bar.v.double_oo = | lambda_(upright("max"))^L |$. Then, recalling that $| lambda_(upright("max")) | = bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo$ is also the expressibility of one layer, one can find that


$ bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = (bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo)^L thin . $<eq:explayers>


Solving for $L$ and denoting $epsilon = bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo$ leads to


$ L = frac(log ( 1 / epsilon ), log (1 / bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo)) thin . $<eq:Ldepth>



 proof


= Proof of Corollary #ref(<cor:Lscaling>): Rate of convergence of controllable systems to 2-designs
<app:proof_corollary_convergence>
Here we prove @cor:Lscaling.


#thmbox("corollary", "Corollary")[


Let the single layer expressibility of a controllable system be $bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo = 1 - delta ( n )$, with $delta ( n )$ being at most polynomially vanishing with $n$, i.e., with $delta ( n ) in Omega ( 1 / "poly" ( n ) )$. Then, if $L ( n ) in Omega ( n / delta ( n ) )$, $U ( bold(theta) )$ will be no worse than an $epsilon ( n )$-approximate $2$-design (i.e., $bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo lt.eq epsilon ( n )$) with $epsilon ( n ) in cal(O) ( 1 / 2^n )$, where we have added the $n$-dependence in $L$ and $epsilon$ for clarity.


] <cor:LscalingSM>


#block[
#emph[Proof.] Let us recall from the main text, and from Eq.~@eq:explayers, that~◻

]


$ bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = (bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo)^L thin . $


Replacing $bar.v.double cal(A)_(U_1 ( bold(theta) ))^(( 2 )) bar.v.double_oo = 1 - delta ( n )$, one finds


$ bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = (1 - delta ( n ))^L thin . $


Then, assuming that $L ( n ) in Omega ( n / delta ( n ) )$ we have, by definition, that there exists $c gt.eq 0$ and $n_0$ such that $L ( n ) gt.eq c n / delta ( n )$ for all $n gt.eq n_0$. From the previous, we find that for $n gt.eq n_0$


$ bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo = (1 - delta ( n ))^L lt.eq (1 - delta ( n ))^(frac(c n, delta ( n ))) thin , $


where we have used the fact that $(1 - delta ( n )) lt.eq 1$. Recalling that $delta ( n ) in Omega ( 1 / "poly" ( n ) )$, i.e., $delta ( n )$ vanishes no faster than a polynomial function of $n$, we find to first order that


$ (1 - delta ( n ))^(frac(c' n, delta ( n ))) approx e^(- n + cal(O) ( 1 / n )) thin . $


Then, defining $epsilon ( n ) = (1 - delta ( n ))^(frac(c n, delta ( n )))$ we prove the result in @cor:Lscaling as


$ bar.v.double cal(A)_(U ( bold(theta) ))^(( 2 )) bar.v.double_oo lt.eq epsilon ( n ) thin , quad upright("with") quad epsilon ( n ) in cal(O) ( 1 / 2^n ) . $



 proof


= Proof of Proposition #ref(<prop:controllable>): Controllability leads to barren plateaus
<app:proof_prop_controllable>


Let us now provide a proof for @prop:controllable.


#thmbox("proposition", "Proposition (Controllable)")[


There exists a scaling of the depth for which controllable systems form $epsilon$-approximate $2$-designs with $epsilon in cal(O) ( 1 / 2^n )$, and hence the system exhibits a barren plateau according to @def:BP.


] <prop:controllableSM>


#block[
#emph[Proof.] Let us start by noting that for all controllable systems one can form a $epsilon$-approximate $2$-designs with $epsilon in cal(O) ( 1 / 2^n )$ with a depth scaling obtained from Eq.~@eq:Ldepth. Then, let us recall that we have defined the expressibility superoperator as~◻

]


$ med cal(A)_(U ( bold(theta) ))^(( t )) = M_(U_H)^(( t )) - M_(U ( bold(theta) ))^(( t )) thin . $<eq:superopSM>


with its ordinary action given by


$ med cal(A)_(U ( bold(theta) ))^(( t )) ( dot.op ) = M_(U_H)^(( t )) ( dot.op ) - M_(U ( bold(theta) ))^(( t )) ( dot.op ) thin . $<eq:superopSM2>


We then have that for any quantum state $rho$


$ bar.v.double cal(A)_(U ( bold(theta) ))^(( t )) ( rho ) bar.v.double_oo lt.eq bar.v.double cal(A)_(U ( bold(theta) ))^(( t )) bar.v.double_oo thin , $<eq:ineqexpress>


which follows from the normalization of $rho$. Hence, if $bar.v.double cal(A)_(U ( bold(theta) ))^(( t )) bar.v.double_oo lt.eq epsilon$ we find from Eq.~@eq:ineqexpress that for any quantum state $rho$, the inequality $bar.v.double cal(A)_(U ( bold(theta) ))^(( t )) ( rho ) bar.v.double_oo lt.eq epsilon$ holds, which is precisely the definition of an $epsilon$-approximate state $2$-design. Finally, we can use the results from~@mcclean2018barren, which imply that since $epsilon in cal(O) ( 1 / 2^n )$, then the variance of the cost function partial derivative is given by


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = hat(F) ( n ) thin , quad upright("with") quad hat(F) ( n ) in cal(O) ( 1 / 2^n ) thin . $


Thus, the cost function exhibit a barren plateau.



 proof


= Proof of Proposition #ref(<prop:controllable-gen>): Controllability of the HEA and the Spin Glass model
<app:proof_of_hea_sg>


Let us now prove @prop:controllable-gen.


#thmbox("proposition", "Proposition")[


The following two sets of generators generate full rank DLAs, and concomitantly lead to controllable systems:

- $cal(G)_(upright("HEA")) = ( X_i , Y_i )_(i = 1)^n ⋃ {sum_(i = 1)^(n - 1) Z_i Z_(i + 1)}$,

- $cal(G)_(upright("SG")) = (sum_(i = 1)^n X_i , sum_(i < j) (h_i Z_i + J_(i j) Z_i Z_j))$, with $h_i , J_(i j) in bb(R)$ sampled from a Gaussian distribution.


] <prop:controllable-genSM>


In the following we find that by repeated nested commutators between the elements of the sets $cal(G)$ in @prop:controllable-gen. one can obtain all $2^(2 n) - 1$ Pauli strings, and hence, that the DLA $frak(k)$ obtained is full rank.


#block[
#emph[Proof.] We divide the proof into HEA and GS models.~◻

]


=== Generators of the Hardware Efficient Ansatz (HEA)
<generators-of-the-hardware-efficient-ansatz-hea>
We first start with the set $cal(G)_(upright("HEA"))$ corresponding to the set of generators of a HEA.


$ cal(G)_(upright("HEA")) = ( X_i , Y_i )_(i = 1)^n ⋃ {sum_(i = 1)^(n - 1) Z_i Z_(i + 1)} med . $<eq:gen-hea-supp>


First, let us note that from the commutation of $X_i$ with $Y_i$, we get every $Z_i$. Meaning that one can already obtain all single qubit Pauli operators. Then, the commutation of $X_i$ and $Y_i$ with $sum_(i = 1)^(n - 1) Z_i Z_(i + 1)$, respectively, gives


$ A_i = Y_i ( Z_(i + 1) + Z_(i - 1) ) thin , quad upright("and") quad B_i = X_i ( Z_(i + 1) + Z_(i - 1) ) thin . $


It then follows that the commutator of $X_(i + 1)$ with $B_i$ is


$ C_i = X_i Y_(i + 1) , med forall i in ( 1 , dots.h , n - 1 ) med . $


Then by computing the commutators of ${ X_i }_(i = 1)^n$, ${ Y_i }_(i = 1)^n$, and ${ Z_i }_(i = 1)^n$ with ${ C_i }_(i = 1)^(n - 1)$ we get all nearest-neighbour two-body Pauli operators


$ D_i = ( X_i X_(i + 1) , Y_i Y_(i + 1) , Z_i Z_(i + 1) , X_i Y_(i + 1) , Y_i X_(i + 1) , X_i Z_(i + 1) , Z_i X_(i + 1) , Y_i Z_(i + 1) , Z_i Y_(i + 1) ) , med forall i in ( 1 , dots.h , n - 1 ) med . $


Similarly, it can be readily verified that the commutators between ${ X_i }_(i = 1)^n$, ${ Y_i }_(i = 1)^n$, ${ Z_i }_(i = 1)^n$, and operators in ${ D_i }_(i = 1)^(n - 1)$ yield all "nearest-neighbour" three-body Pauli operators.


Now, let us show that $frak(k)$ also contains the remaining non-nearest-neighbour two body operators. Consider the commutator between the three-body nearest-neighbour operators


$ [ M_i N_(i + 1) O_(i + 2) , P_i N_(i + 1) Q_(i + 2) ] = [ M_i , P_i ] [ O_(i + 2) , Q_(i + 2) ] $


where $N , M , O , P , Q in ( X , Y , Z )$. Clearly, the different choices of $M , O , P$ and $Q$ will generate all next-nearest-neighbour two-body operators. Iterating this procedure we obtain all $9 binom(n, 2)$ two-body terms. Then, once we have all two-bodies we can use one-bodies ${ X_i }_(i = 1)^n$, ${ Y_i }_(i = 1)^n$ and ${ Z_i }_(i = 1)^n$ to get all three-bodies. Three-bodies with one-bodies will give four-bodies, and so on. We will get all n-body operators. Thus the DLA of the HEA is full rank, which implies that the HEA is a controllable ansatz.





=== Generators of the Spin Glass (SG)
<generators-of-the-spin-glass-sg>
The set of generators for a spin glass system is given by


$ cal(G)_(upright("SG")) = (sum_(i = 1)^n X_i , sum_(i < j) (h_i Z_i + J_(i j) Z_i Z_j)) med , $


with $h_i , J_(i j) in bb(R)$. For convenience, we define the following two operators


$ H_p = sum_(i j) h_i Z_i + J_(i j) Z_i Z_j , quad H_m = sum_i X_i med . $


The commutator of $H_p$ and $H_m$ gives


$ A_0 = [ H_p , H_m ] = sum_(i j) h_i Y_i + J_(i j) Y_i Z_j med . $


We then compute the commutator of $A_0$ and $H_m$:


$ [ H_m , A_0 ] = - H_p + sum_(i j) J_(i j) Y_i Y_j med . $


Combining $H_p$ and $[ H_m , A_0 ]$ gives


$ A_1 = sum_(i j) J_(i j) Y_i Y_j med . $


We now compute the commutator between $A_1$ and $H_m$ as follows:


$ A_3 := [ A_1 , H_m ] = sum_(r s) J_(r s) Z_r Y_s med . $


Combining $A_0$ and $A_3$, we get


$ A_4 := sum_i h_i Y_i med . $


Similarly, combining $H_m$ and $A_4$ gives


$ A_5 := sum_i h_i Z_i med . $


Finally, combining $A_5$ and $H_p$ gives


$ A_6 := sum_(i j) J_(i j) Z_i Z_j med . $


From the commutator of $A_4$ and $A_5$ we get


$ A_7 := [ A_4 , A_5 ] = sum_i h_i^2 X_i med . $


Moreover, the commutators of $A_7$ with $A_4$ and $A_5$ lead to


$ A_8 := [ A_7 , A_4 ] = sum_i h_i^3 Z_i med , quad A_9 := [ A_5 , A_7 ] = sum_i h_i^3 Y_i med . $


By repeating this procedure, we get that the set


$ macron(cal(S)) = ( sum_i h_i^(2 m) X_i , med sum_i h_i^m Y_i med , sum_i h_i^m Z_i )_(m = 1)^n $


also belongs to the Lie algebra. Now, because the $h'_i$s are sampled from a Gaussian distribution, we can safely assume them to be non-zero and different from each other. Then, using a Vandermonde determinant type of argument one can show that the $3 n$ elements in $macron(cal(S))$ are linearly independent and span the same subspace as $cal(S) = ( X_i , Y_i , Z_i )_(i = 1)^n$. Thus $cal(S)$ belongs to $frak(k)_(upright("SG"))$. Combining this with $A_6$, we essentially get the generators of $cal(G)_(upright("HEA"))$ and hence one can again generate all $n$-body Pauli operators. Thus the DLA of the spin-glass system is also of full rank, which implies that the spin-glass system is controllable.



 proof


= Proof of Theorem 2: Variance in subspace controllable systems
<app:proof_theo_subspace>


In the following, we provide a proof for @Theo:subspace by explicitly computing the variance of the cost function partial derivative in a subspace controllable setting. Consider a set of generators that share a symmetry (for simplicity we assume only one symmetry, although generalization to multiple symmetries is straightforward), i.e., there is a Hermitian operator $Sigma$ such that $[ Sigma , g ] = 0 quad forall g in frak(k)$. Assuming $Sigma$ has $N$ distinct eigenvalues, the DLA has the form $frak(k) = x⋁_(m = 1)^N frak(k)_m$. This imposes a partition of $cal(H) = x⋁_(m = 1)^N cal(H)_m$ where each subspace $cal(H)_m$ of dimension $d_m$ is invariant under $frak(k)$.


Let us introduce some notation. Consider the $d times d_m$ matrix that results from horizontally stacking the eigenvectors of $Sigma$ associated with the $m$-th eigenvalue (of degeneracy $g_m$)


$ Q_m^dagger = mat(delim: "[", dots.v, dots.v, , dots.v; | v_1 chevron.r ,, | v_2 chevron.r ,, , , | v_(g_m) chevron.r; dots.v, dots.v, , dots.v) , $


such that $Q_m$ maps vectors from $cal(H)$ to $cal(H)_m$. These satisfy


$ Q_m Q_n^dagger = bb(1)_(d_m) delta_(m n), quad Q_m^dagger Q_m = bb(P)_m , $ <eq:proj2>
where $bb(P)_m$ are projectors onto the subspace, such that $sum_(m=1)^N bb(P)_m = bb(1)_d$. Let us now use the notation


$ | psi chevron.r^(( m )) = Q_m | psi chevron.r , quad A^(( m )) = Q_m A Q_m^dagger thin , $<Eq_red>


to denote the $d_m$-dimensional reduced states and operators, respectively. Recall that, since any unitary $U in bb(G)$ produced by such a system is block diagonal, we can write $U = sum_m bb(P)_m U bb(P)_m$. Also, let us note that if $A = A^dagger$ then $( A^(( k )) )^dagger = A^(( k ))$.


We are ready to prove of @Theo:subspace, which we here recall for convenience.


#thmbox("theorem", "Theorem (Subspace controllable)")[


Consider a system that is reducible (so that the Hilbert space is $cal(H) = x⋁_j cal(H)_j$ with each $cal(H)_j$ invariant under $bb(G)$), and controllable on some $cal(H)_k$ of dimension $d_k$. Then, if the initial state is such that $rho in cal(H)_k$, the variance of the cost function partial derivative is given by


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = frac(2 d_k, ( d_k^2 - 1 )^2) Delta ( H_mu^(( k )) ) Delta ( O^(( k )) ) Delta ( rho^(( k )) ) thin . $<Eq_th2SM>


Here


$ Delta(A) = D_(H S)(A,"Tr"[A]frac(bb(1)_(d), d)),quad "with "D_(H S)(A,B)="Tr"[(A-B)^(2)] $ <eq:hs>


is the Hilbert-Schmidt distance, and $A^(( k ))$ the reduction of operator $A$ onto the subspace of $cal(H)_k$ as defined in Eq @Eq_red.


] <Theo:subspaceSM>


#block[
#emph[Proof.]~◻

]


Consider the partial derivative of the cost function $C ( bold(theta) )$ with respect to the parameter $theta_(p q)$ ($= theta_mu$), i.e. the one associated with layer $p$ and generator $H_q$ ($= H_mu$). We have


$ partial_mu C ( bold(theta) ) = i upright("Tr") [ U_B rho U_B^dagger [ H_mu , O_A ] ] $


$ partial_(p q) C ( bold(theta) ) & = partial_(p q) (upright("Tr") \[ U ( bold(theta) ) rho U ( bold(theta) )^dagger O \])\
 & = partial_(p q) (upright("Tr") \[ U_B rho U_B^dagger O_A \])\
 & = i upright("Tr") \[ U_B rho U_B^dagger \[ H_q , O_A \] \] $


where in the second line we have expanded $U ( bold(theta) ) = U_A U_B$, with


$ U_B = product_(m = 0)^q e^(- i H_m theta_(p m)) (product_(l = 1)^(p - 1) product_(k = 0)^K e^(- i H_k theta_(l k))) thin quad upright("and") quad U_A = product_(l = p + 1)^L product_(k = 0)^K e^(- i H_k theta_(p k)) (product_(k = q + 1)^K e^(- i H_k theta_(p k))) thin , $


corresponding to the unitaries before and after the parameter $theta_(p q)$, and $O_A = U_A^dagger O U_A$. Then, the variance of the partial derivative is


$ upright("Var")_(bold(theta)) [ partial_(p q) C ] = - integral_(bb(U)_A) d U_A I ( U_A ) thin , quad upright("with ") quad I ( U_A ) = integral_(bb(U)_B) d U_B ( F ( U_B , U_A ) )^2 thin , $


where $bb(U)_A$ and $bb(U)_B$ denote the distribution of before and after unitaries, respectively, and $F ( U_B , U_A ) = upright("Tr") [ U_B rho U_B^dagger [ H_q , U_A^dagger O U_A ] ]$. Now, expanding the block-diagonal unitaries in this equation and assuming that the initial state belongs to a particular invariant subspace, i.e., $rho^(( k )) = bb(P)_k rho bb(P)_k = rho$, we find


$ F ( U_B , U_A ) = sum_(m n) upright("Tr") [ bb(P)_m U_B bb(P)_m rho bb(P)_n U_B^dagger bb(P)_n X ] = upright("Tr") [ U_B^(( k )) rho^(( k )) U_B^(dagger ( k )) X ] $<Eq_F>


where we defined $X = [ H_q^(( k )) , ( U_A^(( k )) )^dagger O^(( k )) U_A^(( k )) ]$, and thus


$ I ( U_A ) = integral_(bb(U)_B) d U_B (upright("Tr") [ U_B rho U_B^dagger [ H_q , U_A^dagger O U_A ])^2 = integral_(bb(U)_B^(( k ))) d U_B^(( k )) (upright("Tr") [ U_B^(( k )) rho^(( k )) U_B^(dagger ( k )) X ])^2 thin . $<Eq_Ik>


Note that here we have used the fact that, owing to Eq. @Eq_F, $F ( U_B , U_A )$ actually depends only on the action of $U_B^(( k ))$, i.e., on the action of $U_B$ projected onto the $k$-invariant subspace, and not on the action of the entire unitary $U_B$,. Hence, the integration over $bb(U)_B$ can be replaced by an integration over $bb(U)_B^(( k ))$.


At this point, we introduce the assumption of subspace controllability on $cal(H)_k$. By virtue of @theo:depth and @cor:Lscaling, we know that the distribution of unitaries produced by a subspace controllable PSA constitute a $epsilon$-approximate 2-design in the subspace. Therefore, we can use Eq.~[\[Eq\_lemma2\]] to integrate and get


$ I ( U_A ) = integral_(cal(U) ( d_k )) d U^(( k )) (upright("Tr") [ U^(( k )) rho^(( k )) ( U^(( k )) )^dagger X ])^2 = frac(upright("Tr") [ X X ] thin Delta ( rho^(( k )) ), d_k^2 - 1) thin , $<Eq_Iready>


where $Delta ( A )$ is the Hilbert-Schmidt distance defined in @Theo:subspaceSM. Here, we used that $upright("Tr") [ X ] = 0$. This is grounded in the fact that, because the generator $V$ shares the symmetry, the commutator $X$ in the subspace is still a commutator, i.e., $X = [ H_q^(( k )) , tilde(O)^(( k )) ]$ with $tilde(O) = U_A^dagger O U_A$. If the initial state was spread across two (or more) subspaces, neither $rho^(( k ))$ would be a density matrix, nor $X$ would be a commutator and one would have to be more careful in the derivation.


Finally, we proceed to integrate Eq.~@Eq_Iready over $bb(U)_A$. Notice again that $tilde(O)^(( k )) = bb(P)_k tilde(O) bb(P)_k = U_A^(dagger ( k )) O^(( k )) U_A^(( k ))$ so $X$ is actually only a function of $U_A^(( k ))$ (and not of the entire $U_A$). Consequently we can integrate over the reduced distribution $bb(U)_A^(( k ))$, that, according to the subspace controllability assumption, forms a $epsilon$-approximate $2$-design over $cal(U) ( d_k )$. This leads to


$ upright("Var")_(A , B) \[ partial_(p q) C \] & = - frac(Delta ( rho^(( k )) ), d_k^2 - 1) integral_(cal(U) ( d_k )) d mu ( U^(( k )) ) thin upright("Tr") \[ X X \]\
 & = - 2 frac(Delta ( rho^(( k )) ), d_k^2 - 1) integral_(cal(U) ( d_k )) d mu ( U^(( k )) ) ( upright("Tr") \[ H_q^(( k )) tilde(O)^(( k )) H_q^(( k )) tilde(O)^(( k )) \] - upright("Tr") \[ H_q^(( k )) H_q^(( k )) tilde(O)^(( k )) tilde(O)^(( k )) \] )\
 & = - 2 frac(Delta ( rho^(( k )) ), d_k^2 - 1) ( frac(( upright("Tr") \[ H_q^(( k )) \] )^2 upright("Tr") \[ O^(( k )) O^(( k )) \] + upright("Tr") \[ H_q^(( k )) H_q^(( k )) \] ( upright("Tr") \[ O^(( k )) \] )^2, d_k^2 - 1)\
 & quad - frac(upright("Tr") \[ H_q^(( k )) H_q^(( k )) \] upright("Tr") \[ O^(( k )) O^(( k )) \] + ( upright("Tr") \[ H_q^(( k )) \] upright("Tr") \[ O^(( k )) \] )^2, d_k ( d_k^2 - 1 )) - frac(upright("Tr") \[ H_q^(( k )) H_q^(( k )) \] upright("Tr") \[ O^(( k )) O^(( k )) \], d_k) )\
 & = frac(2 d_k Delta ( rho^(( k )) ), d_k ( d_k + 1 ) ( d_k^2 - 1 )) (upright("Tr") \[ H_q^(( k )) H_q^(( k )) \] - 1 / d_k upright("Tr") \[ H_q^(( k )) \]^2) (upright("Tr") \[ O^(( k )) O^(( k )) \] - 1 / d_k upright("Tr") \[ O^(( k )) \] )^2)\
 & = frac(2 d_k, ( d_k^2 - 1 )^2) Delta ( H_q^(( k )) ) Delta ( O^(( k )) ) Delta ( rho^(( k )) ) thin . $<eq10>


Here, we used the notation $upright("Var")_(bold(theta)) arrow.r upright("Var")_(A , B)$ to make explicit the assumption that both $bb(U)_A^(( k ))$ and $bb(U)_B^(( k ))$ form $2$-designs in $cal(U) ( d_k )$. Note that we first expanded $upright("Tr") [ X X ]$ in Eq.~@eq10, and then used identities [\[Eq\_lemma2\]] and [\[Eq\_lemma3\]] on each integrand respectively to arrive at Eq.~@eq10. Note that, even though $upright("Tr") [ H_q ] = 0$ (and, in most applications, $upright("Tr") [ O ] = 0$), this is not necessarily true for their reduced analogs $H_q^(( k ))$ and $O^(( k ))$.



 proof


= Proof of Corollary #ref(<cor:HXXZ>): Exponentially growing subspaces have barren plateaus
<app:proof_corollary_subspace>


Let us prove @cor:HXXZ, which we here recall.


#thmbox("corollary", "Corollary")[


Consider a PSA of the form in @eq:ansatz giving rise to a reducible DLA, and let $rho in cal(H)_k$, with $cal(H)_k$ some invariant subspace that is controllable (i.e. the DLA reduced to such subspace is full rank). If, $upright("Tr") [ ( H_mu )^4 ] , upright("Tr") [ O^4 ] in cal(O) ( 2^n )$, the cost function will exhibit a barren plateau for any subspace such that $d_k in cal(O) ( 2^n )$.


] <cor:HXXZSM>


#block[
#emph[Proof.]~◻

]


We consider the situation in which we have a reducible system and an initial state $rho$ that belongs to an invariant subspace $cal(H)_k$ which, by assumption, is controllable. Notice that, using Eqs.~@eq:proj2 and~@Eq_red, we find


$ upright("Tr") [ A^(( k )) A^(( k )) ] = upright("Tr") [ A bb(P)_k A bb(P)_k ] thin . $


Then, since the operator $M = A bb(P)_k A$ is a positive semi-definite operator, and since $bb(P)_k lt.eq I$, one can write


$ upright("Tr") [ A^(( k )) A^(( k )) ] lt.eq upright("Tr") [ A^2 bb(P)_k ] thin . $


Using this expression, the following bound on the Hilbert-Schmidt distance holds


$ Delta ( A^(( k )) ) & = upright("Tr") \[ A^(( k )) A^(( k )) \] - 1 / d_k ( upright("Tr") \[ A^(( k )) \] )^2\
 & lt.eq upright("Tr") \[ A^2 bb(P)_k \]\
 & lt.eq sqrt(upright("Tr") \[ A^4 \] upright("Tr") \[ bb(P)_k^2 \])\
 & lt.eq sqrt(d_k) sqrt(upright("Tr") \[ A^4 \]) thin . $<eq:ineqA>


Using Eq.~@eq:ineqA and the equation for the variance in ~@Eq_th2SM we find


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] lt.eq frac(4 d_k^2, ( d_k^2 - 1 )^2) sqrt(upright("Tr") [ H_mu^4 ]) sqrt(upright("Tr") [ O^4 ]) thin , $


where we have additionally used the fact that $Delta ( rho^(( k )) ) lt.eq 2 forall rho$. Recalling that we are interested in the case when $d_k in cal(O) ( 2^n )$ we find that, assuming $upright("Tr") [ V^4 ] , upright("Tr") [ O^4 ] in cal(O) ( 2^n )$, then the function


$ T ( n ) = frac(4 d_k^2, ( d_k^2 - 1 )^2) sqrt(upright("Tr") [ H_mu^4 ]) sqrt(upright("Tr") [ O^4 ]) $


is such that


$ T ( n ) in cal(O) ( 1 / 2^n ) thin . $


Hence, we finally find that $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] lt.eq T ( n )$, and the cost exhibits a barren plateau from the fact that the variance of the cost function partial derivative is upper bounded by a function that vanishes exponentially with $n$.



 proof


Let us finally denote that the proof of @cor:HXXZ follow from the fact that $upright("Tr") [ ( H_mu )^4 ] , upright("Tr") [ O^4 ] in cal(O) ( 2^n )$. We here note that the following relevant cases satisfy this assumption:

- $H_mu$, $O$ are projectors of arbitrary rank.

- $H_mu$, $O$ have a decomposition in the Pauli string basis of the form $sum_i c_i bold(sigma)_i$ (with $c_i$ real coefficients, and $bold(sigma)_i in { I, X, Y, Z }^(⊗ n)$) with up to $cal(O) ( "poly" ( n ) )$ terms such that $sum_i c_i^4 in cal(O) ( "poly" ( n ) )$.





= Proof of Theorem #ref(<theo:express-subspace2>): Expressibility in the subspace
<app:proof_theo_express>


Here we prove @theo:express-subspace2, which we now recall.


#thmbox("theorem", "Theorem")[


Consider a system that is reducible and let $rho in cal(H)_k$ with $cal(H)_k$ an invariant subspace of dimension $d_k$. Then, the variance of the cost function partial derivative is upper bounded by


$ upright("Var")_theta [ partial_mu C ( bold(theta) ) ] lt.eq min ( G_A ( rho^(( k )) ) , G_B ( O^(( k )) ) ) thin , $<eq:expressibilitySM>


with


$ G_B ( rho^(( k )) ) & = (lr(bar.v.double cal(A)_(U_B^(( k ))) (( rho^(( k )) )^(⊗ 2)) bar.v.double)_2 - frac(Delta ( rho^(( k )) ), d_k^2 - 1)) upright("Tr") [⟨X^2⟩_(U_A^(( k )))]\
G_A ( O^(( k )) ) & = (lr(bar.v.double cal(A)_(U_A^(( k ))) (( O^(( k )) )^(⊗ 2)) bar.v.double)_2 - frac(Delta ( O^(( k )) ), d_k^2 - 1)) upright("Tr") [⟨Y^2⟩_(U_B^(( k )))] . $<eq:bound1>


Here we define $X = [ H_mu^(( k )) , ( U_A^(( k )) thin )^dagger O thin U_A^(( k )) ]$ and $Y = [ H_mu^(( k )) , U_B^(( k )) rho^(( k )) ( U_B^(( k )) )^dagger ]$. For simplicity, we here employed the short-hand notation $chevron.l dot.op chevron.r_(U_x^(( k )))$ (with $x = A , B$) to indicate the expectation value over the distribution of unitaries obtained from $U_x^(( k ))$ in the $k$-th subsystem. Finally, $bar.v.double M bar.v.double_2 = sqrt(upright("Tr") [ M^dagger M ])$ is the Frobenius norm, and $Delta ( dot.op )$ was defined in @Theo:subspace.


] <theo:express-subspace2SM>


#block[
#emph[Proof.]~◻

]


Let us first note that the variance of the cost function partial derivative can be expressed as


$ upright("Var")_theta \[ partial_mu C ( bold(theta) ) \] & = - integral_(bb(U)_A^(( k ))) d U_A^(( k )) integral_(bb(U)_B^(( k ))) d U_B^(( k )) upright("Tr") \[ U_B^(⊗ 2) ( rho^(( k )) )^(⊗ 2) ( U_B^dagger )^(⊗ 2) X^(⊗ 2) \]\
 & = integral_(bb(U)_A) d U_A integral_(bb(U)_B) d U_B upright("Tr") \[ ( U_A^dagger )^(⊗ 2) ( O^(( k )) )^(⊗ 2) U_A^(⊗ 2) Y^(⊗ 2) \] $<eq:variance-first-step-rho>


where we defined


$ X = [ H_mu^(( k )) , ( U_A^(( k )) )^dagger O^(( k )) U_A^(( k )) ] thin , quad upright("and") quad Y = [ H_mu^(( k )) , ( U_B^(( k )) ) rho^(( k )) ( U_B^(( k )) )^dagger ] thin . $<eq:xlk>


Then, we recall that $cal(A)_x ( dot.op )$ denotes the expressibility superoperator for the second moment in the $k$-th subspace


$ cal(A)_omega ( dot.op ) = integral_(cal(U) ( d_k )) d mu ( U ) thin U^(⊗ 2) ( dot.op ) ( U^dagger )^(⊗ 2) - integral_(bb(U)_omega^(( k ))) d U thin ( U )^(⊗ t) ( dot.op ) ( U^dagger )^(⊗ t) thin , $


where $omega = A , B$ indicates that one evaluates the expressibility of $U_A^(( k )) ( bold(theta) )$ or $U_B^(( k )) ( bold(theta) )$ in the $k$-th subspace.


First, let us derive Eq.~@eq:bound1. Replacing $cal(A)_B ( ( rho^(( k )) )^(⊗ 2) )$ into~@eq:variance-first-step-rho leads to


$ upright("Var")_theta \[ partial_mu C ( bold(theta) ) \] & = - integral_(bb(U)_A^(( k ))) d U_A^(( k )) integral_(cal(U) ( d_k )) d mu ( U ) upright("Tr") \[ U_H^(⊗ 2) ( rho^(( k )) )^(⊗ 2) U_H^(dagger ⊗ 2) X^(⊗ 2) \] + integral_(bb(U)_A^(( k ))) d U_A^(( k )) upright("Tr") \[ cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) X^(⊗ 2) \]\
 & = upright("Var")_B \[ partial_mu C ( bold(theta) ) \] + integral_(bb(U)_A^(( k ))) d U_A^(( k )) upright("Tr") \[ cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) X^(⊗ 2) \] thin . $


Which leads to


$ | upright("Var")_theta [ partial_mu C ( bold(theta) ) ] - upright("Var")_B [ partial_mu C ( bold(theta) ) ] | lt.eq | integral_(bb(U)_A^(( k ))) d U_A^(( k )) upright("Tr") [ cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) X^(⊗ 2) ] | thin . $


Using the triangle inequality and then the Cauchy-Schwarz inequality one finds


$ | upright("Var")_theta \[ partial_mu C ( bold(theta) ) \] - upright("Var")_B \[ partial_mu C ( bold(theta) ) \] | & lt.eq integral_(bb(U)_A^(( k ))) d U_A^(( k )) | upright("Tr") \[ cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) X^(⊗ 2) \] |\
 & lt.eq bar.v.double cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) bar.v.double_2 integral_(bb(U)_A^(( k ))) d U_A^(( k )) | | X^(⊗ 2) | |_2\
 & lt.eq bar.v.double cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) bar.v.double_2 ⟨| | X^(⊗ 2) | |_2⟩_(U_A^(( k ))) thin . $<eq:DiffVarR>


Then, using the fact that


$ | | X^(⊗ 2) | |_2 = sqrt(upright("Tr") [ X^(⊗ 2) X^(⊗ 2) ]) = sqrt(upright("Tr") [ X^2 ⊗ X^2 ]) = | upright("Tr") [ X^2 ] | = | upright("Tr") [ [ H_mu^(( k )) , ( U_A^(( k )) )^dagger O^(( k )) U_A^(( k )) ]^2 ] | thin , $<eq:xlk-simplification>


one finds


$ | upright("Var")_theta [ partial_mu C ( bold(theta) ) ] - upright("Var")_B [ partial_mu C ( bold(theta) ) ] | lt.eq bar.v.double cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) bar.v.double_2 upright("Tr") [⟨X^2⟩_(U_A^(( k )))] thin . $<eq:DiffVarR2>


Note that the term $upright("Var")_B [ partial_mu C ( bold(theta) ) ]$ was explicitly computed in Eq.~@Eq_Iready, i.e., in Eq.~@Eq_Iready one evaluates the variance when $U_B^(( k )) ( bold(theta) )$ forms a $2$-design. Hence, replacing $upright("Var")_B [ partial_mu C ( bold(theta) ) ] = - frac(Delta ( rho^(( k )) ), d_k^2 - 1) upright("Tr") [⟨X^2⟩_(bb(U)_A^(( k )))]$ in~@eq:DiffVarR2 we finally obtain


$ upright("Var")_theta [ partial_mu C ( bold(theta) ) ] lt.eq (bar.v.double cal(A)_B ( ( rho^(( k )) )^(⊗ 2) ) bar.v.double_2 - frac(Delta ( rho^(( k )) ), d_k^2 - 1)) upright("Tr") [⟨X^2⟩_(U_A^(( k )))] thin . $<eq:DiffVarR3>


Similarly, one can derive Eq.~@eq:bound1 by replacing $cal(A)_A ( ( O^(( k )) )^(⊗ 2) )$ into~@eq:variance-first-step-rho, which leads to


$ upright("Var")_theta [ partial_mu C ( bold(theta) ) ] & = - integral_(U_B^(( k ))) d U_B^(( k )) integral_(cal(U) ( d_k )) d mu ( U ) upright("Tr") [ U_H^(⊗ 2) ( O^(( k )) )^(⊗ 2) U_H^(dagger ⊗ 2) Y^(⊗ 2) ] + integral_(U_B^(( k ))) d U_B^(( k )) upright("Tr") [ cal(A)_A ( ( O^(( k )) )^(⊗ 2) ) Y^(⊗ 2) ] thin . $


Following a similar derivation to the one used in obtaining~@eq:DiffVarR, one finds


$ upright("Var")_theta [ partial_mu C ( bold(theta) ) ] lt.eq (bar.v.double cal(A)_A ( ( O^(( k )) )^(⊗ 2) ) bar.v.double_2 - frac(Delta ( O^(( k )) ), d_k^2 - 1)) upright("Tr") [⟨Y^2⟩_(U_B^(( k )))] thin . $<eq:DiffVarR5>



 proof





= Proof of Proposition #ref(<prop:varsu2>): Variance on the irreducible representations of $cal(S) cal(U)$\(2)
<app:proof_su2>


In this section we derive a proof for @prop:varsu2 for the variance of the irreducible representations of $cal(S) cal(U)$\(2). @prop:varsu2SM reads.


#thmbox("proposition", "Proposition")[


Consider the cost function of Eq.~@eq:costsu2. Let $theta_mu = theta_(j , x)$, and let us assume that the circuit is deep enough to allow for the distribution of unitaries $U_A$ and $U_B$ to converge to $2$-designs on $bb(G) = cal(S) cal(U)$\(2). Then variance of the cost function partial derivative $partial_mu C ( bold(theta) ) = partial C ( bold(theta) ) / partial theta_mu$ is


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = frac(2 m^2, 3) thin . $<eq:varsu2SM>


] <prop:varsu2SM>


#block[
#emph[Proof.]~◻

]


First, let us bring the reader into context. We consider a toy model ansatz $U ( bold(theta) ) = product_(l = 1)^L e^(- i theta_(l x) S_y) e^(- i theta_(l y) S_x)$ with generators $cal(G) = ( S_x , S_y )$, where $( i S_x , i S_y , i S_z )$, with $S_nu in bb(C)^(d times d)$ ($nu = x , y , z$), form a basis of the spin $S = ( d - 1 ) / 2$ irreducible representation of $frak(s u)(2)$. Here, it is convenient to use as basis of the Hilbert space the set ${ | m chevron.r }$, $m = - S , - S + 1 , dots.h , S - 1 , S$, of eigenvectors of $S_z$. That is, we have


$ S_(z)|m chevron.r=m|m chevron.r thin,thin thin thin quad S_(plus.minus)|m chevron.r=lambda_(plus.minus) (m)|m plus.minus 1 chevron.r $


with $l_(plus.minus) = sqrt(S (S + 1) - m (m plus.minus 1))$, and where $S_(+)$ and $S_(-)$ are the spin ladder operators such that $S_x = 1 / 2 ( S_(+) + S_(-) )$ and $S_(-) = frac(1, 2 i) ( S_(+) - S_(-) )$.


The dynamical group $bb(G)$ is the $d$-dimensional representation of $cal(S) cal(U)$\(2) and we will be interested in the partial derivative w.r.t $theta_mu = theta_(j , x)$, i.e., the parameter associated with generator $V = S_x$ on the $j$-th layer of the circuit. We will assume that the circuit is deep enough to allow for the distribution of unitaries $U_A$ and $U_B$ to converge to $2$-designs on $bb(G) = cal(S) cal(U)$\(2). In consequence, when computing the variance of the different gradient components, we will be allowed to replace the integration over the angles in the PSA with an integration over the Haar measure on the group $cal(S) cal(U)$\(2). Moreover, because irreducible representations of $cal(S) cal(U)$\(2) and $cal(S) cal(O)$\(3) are isomorphic, we can choose to integrate over the latter


$ integral_(bold(theta)) d U ( bold(theta) ) arrow.r integral_(cal(S) cal(U) ( 2 )) d mu ( U ) thin arrow.r integral_(cal(S) cal(O) ( 3 )) d mu ( U ) thin . $


That is, we choose a parameterization of $cal(S) cal(O)$\(3), e.g. in terms of Euler angles


$ U(alpha,beta,gamma) = e^(-i alpha S_(z))e^(-i beta S_(y))e^(-i gamma S_(z))thin, $ <Eq_unitary_euler>


and compute the mean value of a function of the form $F_M ( bold(theta) ) = upright("Tr") [ U ( bold(theta) ) rho U ( bold(theta) )^dagger M ]$, with $M$ Hermitian, over the cost landscape as


$ chevron.l F chevron.r & = integral_(bold(theta)) d U(bold(theta)) "Tr"[U(bold(theta))rho U(bold(theta))^(dagger) M] \
& =integral_(cal(S)cal(O) (3)) d mu(U) "Tr"[U rho U^(dagger) M] \
& =frac(1, 8 pi^(2)) integral_(0)^(2 pi)d alpha integral_(0)^(pi) d beta sin beta integral_(0)^(2 pi) d gamma thin "Tr"[ U(alpha,beta,gamma) rho U(alpha,beta,gamma)^(dagger) M]thin . $


where $frac(1, 8 pi^2) dif alpha dif beta sin beta dif gamma$ is the normalized Haar measure for this parametrization of $cal(S) cal(O)$\(3). Considering an initial state that is an eigenstate of $J_z$, i.e., $rho = | m chevron.r chevron.l m |$, its evolution can be conveniently expressed in terms of Wigner's small $d$-matrices


$ U(alpha . beta,gamma) rho U(alpha . beta,gamma)^(dagger) =sum_(m'm'') e^(-i alpha(m'-m'')) d_(m'm)(beta)d_(m m'')(-beta) |m'chevron.r chevron.l m''| $


and using that $d_(r k)^j ( beta ) = d_(k r)^j ( - beta )$ and the orthonormality relations


$ frac(1, 2 pi) integral_(0)^(2 pi) d theta e^(-i theta(m-m'))=delta_(m m')thin,quad quad frac(2S+1, 2)integral_(0)^(pi) d beta thin sin beta thin d^(S)_(r k)(beta)d^(S')_(r k)(beta)=delta_(S,S') $


we arrive at


$ chevron.l F chevron.r = frac(upright("Tr") [ M ], 2 S + 1) thin . $


=== An unbiased gradient
<an-unbiased-gradient>


Now, the computation of the mean value of $partial_mu C ( bold(theta) )$ amounts to making the choice $M = X$, with $X = [ H_mu , U_A^dagger O U_A ]$. We readily find that


$ chevron.l partial_mu C chevron.r = integral_(bb(U)_A) d U_A W ( U_A ) = 0 $


since


$ W ( U_A ) = integral_(bb(U)_B) d U_B upright("Tr") [ U_B rho U_B^dagger X ( U_A ) ] = integral_(cal(S) cal(O) ( 3 )) d mu ( U ) upright("Tr") [ U rho U^dagger X ] = frac(upright("Tr") [ X ( U_A ) ], 2 S + 1) = 0 thin , $


which follows from the fact that commutators are traceless.


=== The variance
<the-variance>
Let us now compute the variance of $partial_mu C ( bold(theta) )$. Having shown that $chevron.l partial_mu C chevron.r = 0$, the variance is


$ upright("Var") [ partial_mu C ] = chevron.l ( partial_mu C )^2 chevron.r = - integral_(bb(U)_A) d U_A W ( U_A ) thin , $


where


$ W(U_(A))=integral_(bb(U)_(B)) d U_(B) "Tr"[U_(B)^(times.o 2) rho^(times.o 2) (U_(B)^(times.o 2))^(dagger) X^(times.o 2)]= frac(1, 8 pi^(2)) integral_(0)^(2 pi)d alpha integral_(0)^(pi) d beta sin beta integral_(0)^(2 pi) d gamma thin Y(alpha,beta,gamma)thin, $


and


$ Y(alpha,beta,gamma) & ="Tr"[ U^(times.o 2)(alpha,beta,gamma) rho^(times.o 2) (U^(times.o 2)(alpha,beta,gamma))^(dagger) X] \
& =sum_(m'm''n'n'') e^(-i alpha(m'-m'')) e^(-i alpha(n'-n'')) d_(m'm)(beta)d_(m''m)(beta) chevron.l m''|X|m'chevron.r d_(n'n)(beta)d_(n''n)(beta) chevron.l n''|X|n'chevron.r $


Here and henceforth, $d_(m , m') equiv d_(m , m')^S$. Now, again, integration over $gamma$ is trivial, and integrating over $alpha$ we get $delta_(n'' , m' + n' - m'')$, so that


$ W ( U_A ) = sum_(m' m'' n') chevron.l m'' | X | m' chevron.r chevron.l m' + n' - m'' | X | n' chevron.r 1 / 2 integral_0^pi d beta thin sin beta thin d_(m' m) ( beta ) thin d_(m'' m) ( beta ) thin d_(n' n) ( beta ) thin d_(m' + n' - m'' , n) ( beta ) thin . $<Eq_A>


In the following we will consider that the cost function minimize the expectation value of an operator $O$ that is an element of the dynamical algebra, i.e., $O in frak(k)$. It is easy to verify that any unitary $U ( alpha , beta , gamma )$ of the form of Eq. @Eq_unitary_euler, associated with some $3$-dimensional Euler rotation matrix $R ( alpha , beta , gamma )$, transforms an arbitrary element $S_(hat(n)) = ( S_x , S_y , S_z ) dot.op hat(n)$ (with $hat(n)$ a unit vector $in bb(R)^3$) of the algebra in the following manner


$ U(alpha,beta,gamma) S_(hat(n)) U^(dagger)(alpha,beta,gamma) = S_(hat(n)'),quad "with " hat(n)'=R(alpha,beta,gamma)hat(n) $


Using the shorthand $sin ( x ) arrow.r s_x$ and $cos ( x ) arrow.r c_x$, the rotation matrix reads $ R(alpha,beta,"gam")="left"[ & c_(alpha) c_(beta) c_("gam")-s_(alpha) s_("gam") & -c_("gam") s_(alpha)-c_(alpha) c_(beta) s_("gam") & c_alpha s_beta \
    & c_(alpha) s_("gam")+c_(beta) c_("gam") s_(alpha) & c_(alpha) c_("gam")-c_(beta) s_(alpha) s_("gam") & s_alpha s_beta \
    & -c_("gam") s_(beta) & s_(beta) s_("gam") & c_beta ] thin . $ Hence, considering $O = S_x + S_y + S_z$ and, calling $X^(( iota )) = \[ J_x , U S_nu U^dagger \]$, we get


$ & X^((x))=i s_(beta) c_(gamma) S_(y) +i(c_(alpha) s_(gamma) +s_(alpha) c_(beta) c_(gamma)) S_(z) \
& X^((y))=-i s_(beta) s_(gamma) S_(y) +i(c_(alpha) c_(gamma) -s_(alpha) c_(beta) s_(gamma)) S_(z) \
& X^((z))=-i c_(beta) S_(y) +i s_(alpha) s_(beta) S_(z) thin . $


Thus, denoting $X = sum_(nu = ( x , y , z )) X^(( nu )) = ( a_x , a_y , a_z ) dot.op ( S_x , S_y , S_z )^T$ we find


$ & a_(x)=0 \
& a_(y)=-i(s_(beta)(s_(gamma)-c_(alpha))+c_(beta)) \
& a_(z)=i(s_(alpha)(s_(beta) +c_(beta)(c_(gamma)-s_(gamma))) +c_(alpha)(s_(gamma)+c_(gamma)))thin . $


For the moment, let us neglect the explicit dependence of $a_i$ on the Euler angles and let us compute the matrix elements of $X$


$ chevron.l m''|X|m'chevron.r & =a_(+)chevron.l m''|S_(+)|m'chevron.r +a_(-)chevron.l m''|S_(-)|m'chevron.r+ a_(z)chevron.l m''|S_(z)|m'chevron.r \
& =a_(+)lambda_(+)(m')delta_(m'',m'+1)+a_(-)lambda_(-)(m')delta_(m'',m'-1)+a_(z) m'delta_(m'',m') $


where $a_plus.minus = frac(a_x minus.plus i a_y, 2)$, and where we here define $S_(plus.minus) |m chevron.r = l_(plus.minus) (m) |m plus.minus 1 chevron.r$. Similarly,


$ chevron.l m'+n'-m''|X|n'chevron.r & =a_(+)lambda_(+)(n')delta_(m'+n'-m'',n'+1) +a_(-)lambda_(-)(n')delta_(m'+n'-m'',n'-1) + a_(z) n'delta_(m'+n'-m'',n') \
& =a_(+)lambda_(+)(n')delta_(m'',m'-1) +a_(-)lambda_(-)(n')delta_(m'',m'+1) + a_(z) n'delta_(m'',m') thin . $ <Eq_n>


Now, out of the nine terms in the product $chevron.l m'' | X | m' chevron.r chevron.l m' + n' - m'' | X | n' chevron.r$ appearing in Eq. @Eq_A, only three terms are non-zero. That is, one only gets


$ & T_(1)=a_(+)a_(-)lambda_(+)(m')lambda_(-)(n')delta_(m'',m'+1) \
& T_(2)=a_(+)a_(-)lambda_(-)(m')lambda_(+)(n')delta_(m'',m'-1) \
& T_(3)=a_(z)^(2) m' n' delta_(m'',m')thin . $


which give rise to three terms on $Y$, namely $Y_1$, $Y_2$ and $Y_3$. Consider the first of these


$ Y_(1) = sum_(m'n') a_(+)a_(-)lambda_(+)(m')lambda_(-)(n') frac(1, 2)integral_(0)^(pi)d beta thin sin beta thin d_(m'm)(beta)thin d_(m'+1, m)(beta)thin d_(n'n)(beta)thin d_(n'-1, n)(beta)thin, $


where, we recall that the coefficients $a_i = a_i ( U_A )$ depend on $U_A$. Now, we can use the identity


$ d_(r k)^S ( beta ) d_(r' k')^(S') ( beta ) = sum_(J = | S - S' |)^(S + S') chevron.l S' r S r' #h(0em) | #h(0em) J , r + r' chevron.r chevron.l S k S' k' #h(0em) | #h(0em) J , k + k' chevron.r d_(r + r' , k + k')^J ( beta ) thin . $


where we henceforth employ the more general notation $| m chevron.r arrow.r | S , m chevron.r$. In our context, $S = S'$, and we will reference the Clebsh-Gordan coefficients as $g_(r , k) = chevron.l S r S k #h(0em) | #h(0em) J , r + k chevron.r$. We get


$ Y_(1) = & sum_(m'n'J J') a_(+)a_(-)lambda_(+)(m')lambda_(-)(n')frac(1, 2)integral_(0)^(pi)d beta thin sin beta thin d^(J)_(m'+n',m+n)(beta) d^(J')_(m'+n',m+n)(beta) \
& times chevron.l S m'S n' thin | thin J,m'+n' chevron.r thin chevron.l S,m'+1,S,n'-1 thin | thin J,m'+n' chevron.r thin chevron.l S m S n thin | thin J,m+n chevron.r thin chevron.l S m S n thin | thin J',m+n chevron.r, $


and using the orthogonality relations yields


$ Y_(1) & = sum_(m'n'J) frac( a_(+)a_(-)lambda_(+)(m')lambda_(-)(n'), 2J+1) chevron.l S m'S n' thin | thin J,m'+n' chevron.r thin chevron.l S,m'+1,S,n'-1 thin | thin J,m'+n' chevron.r (chevron.l S m S n thin | thin J,m+n chevron.r)^(2) \
& =sum_(m'n'J) frac( a_(+)a_(-)lambda_(+)(m')lambda_(-)(n'), 2J+1) g_(m',n') g_(m'+1,n'-1)g_(m,n)^(2)thin . $


Similarly


$ & Y_(2) = sum_(m'n'J) frac(a_(+)a_(-)lambda_(-)(m')lambda_(+)(n'), 2J+1) g_(m',n') g_(m'-1,n'+1)g_(m,n)^(2)thin, \
& Y_(3) = sum_(m'n'J) frac(a_(z)^(2) m' n', 2J+1) g_(m',n')^(2)g_(m,n)^(2)thin . $


These can be restated as $Y_1 = Y_2 = c_1 thin a_(+) a_(-)$ and $Y_3 = c_3 thin a_z^2$ with


$ & c_(1) = sum_(m'n'J) frac(lambda_(-)(m')lambda_(+)(n'), 2J+1) g_(m',n') g_(m'-1,n'+1)g_(m,n)^(2) = frac(2, 3) m^(2) \
& c_(3) = sum_(m'n'J) frac(a_(z)^(2) m' n', 2J+1) g_(m',n')^(2)g_(m,n)^(2) = frac(1, 3) m^(2) $


We can proceed to integrate over $U_A$, assuming again we can replace $bb(U)_A$ with an integration over the Haar measure on $bb(G)$. Let us call $v_i$ each contribution to the variance, i.e. $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = sum_(i = 1)^3 v_i$. First, one finds by explicit integration that let us consider


$ v_(3) & = -c_(3) integral_(U_(A)) d U_(A) a_(z)^(2)(U_(A)) \
& =-c_(3) frac(1, 8 pi^(2)) integral_(0)^(2 pi)d tilde(alpha)integral_(0)^(pi) d tilde(beta) sin tilde(beta)integral_(0)^(2 pi) d tilde(gamma) a_(z)^(2)(tilde(alpha),tilde(beta),tilde(gamma)) \
& =c_(3)thin . $


Similarly, it is easy to see that


$ v_1 = v_2 = c_1 / 4 thin . $


Altogether, we finally find


$ upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ] = upright("Var")_(A , B) [ partial_mu C ( bold(theta) ) ] = sum_(i = 1)^3 v_i = 2 / 3 m^2 $<eq:resultsu2>


where we have introduced $upright("Var")_(A , B)$ to make explicit the assumption made, that is, that the before and after distributions of unitaries form $2$-designs.



 proof


=== Numerical simulations of the $cal(S) cal(U)$\(2) toy model algebra.
<numerical-simulations-of-the-mathcalsmathcalu2-toy-model-algebra.>


// [figvision] imgs/FIG_SU2.png
// The figure shows a plot with one panel (a). The plot shows the variance of the derivative of a cost function
// \( {Var}[_C ] \) against a variable \( d \). The y-axis ranges from \( 10^{-5} \) to \( 10^{-1} \) and the
// x-axis from \( 10^1 \) to \( 10^3 \), both on a log scale. There are two series: one in dark purple with
// circles for \( m = S \) and one in red with circles for \( m = 1/2 \). Both series have dashed lines
// connecting the points. The trend shows that the variance for \( m = S \) remains constant across all values of
// \( d \), while the variance for \( m = 1/2 \) decreases as \( d \) increases. The message is that the variance
// of the derivative of the cost function changes differently with \( d \) for the two values of \( m \).
#figure(image("imgs/FIG_SU2.png", width: 100%),
  caption: [
    #strong[Numerical results for the $cal(S) cal(U)$\(2) toy model algebra.] Variance of the cost function partial derivative of the cost function in~@eq:costsu2SM as a function of $d = upright("dim") ( cal(H) )$. Dashed lines indicate the theoretical prediction of~@eq:resultsu2.
  ]
)
<fig:su-2->


Here we numerically simulate the model employing a PSA of the form


$ U ( bold(theta) ) = product_(l = 1 , dots.h , L) e^(- i theta_(l 1) S_y) e^(- i theta_(l 2) S_x) thin , $


for minimizing the normalized cost function


$ C ( bold(theta) ) = chevron.l m | U^dagger ( bold(theta) ) (S_x + S_y + S_z) U ( bold(theta) ) | m chevron.r / S thin . $<eq:costsu2SM>


We compute $upright("Var")_(bold(theta)) [ partial_mu C ( bold(theta) ) ]$ for the initial states $| m chevron.r = | S chevron.r$ and $| m chevron.r = | 1 / 2 chevron.r$ for $L = 100$ using $1200$ random initialization. As shown in #ref(<fig:su-2->), the theoretical prediction of Eq.~@eq:resultsu2 matches the numerical results, indicating that an initial state $| m chevron.r = | 1 / 2 chevron.r$ is trainable, while an initial state $| m chevron.r = | S chevron.r$ leads to a barren plateau in the cost function.


= Symmetries in the $X X Z$ and $upright("TFIM")$ systems
<App:XXZ>


== The $X X Z$ model
<the-xxz-model>
Consider the generators for an HVA ansatz to the $X X Z$ model in Eq. @eq:genHVAXXZ of section @section:XXZ. The elements in $cal(G)_(X X Z_U)$, and thus in its associated DLA, share two common symmetries: they commute both with the magnetization operator $M = sum_(i = 1)^n Z_i$ and with the parity operator


$ Pi=product_(m=1)^([n/2]) P_(m,n-m+1),quad "where " P_(i j)=frac(bb(1)+bold(sigma)_(i)bold(sigma)_(j), 2)quad "and " bold(sigma)_(i) = (X_(i),Y_(i),Z_(i)) . $ <eq:parity>


Here, $Pi$ is the unitary $d$-dimensional irreducible representation of the element of the symmetric group $cal(S)_n$ that corresponds to a reflection over the central constituent. As a result of these two symmetries, the state space is broken into invariant subspaces with well defined parity and excitation number


$ cal(H) = x⋁_(m = 0\
sigma = plus.minus)^n cal(H)_(m , sigma) $


The dimension of each excitation subspace is $upright("dim") ( cal(H)_m ) = binom(n, m)$, whereas, the joint parity-excitation subspaces have dimension $upright("dim") ( cal(H)_(m , sigma) ) approx 1 / 2 upright("dim") ( cal(H)_m )$. The DLA is, accordingly, a direct sum of simple algebras on each invariant subspace


$ frak(k)_(X X Z_U) = x⋁_(m = 0\
sigma = plus.minus)^n frak(k)_(m , sigma) subset.eq frak(u) ( d_(m , sigma) ) thin . $


Notably, upon the addition of a generator consisting of local fields on either end of the chain, $cal(G)_(X X Z) = cal(G)_(X X Z_U) union { upright("Z")_1 + upright("Z")_N }$, the DLA can be shown to become full rank on each subspace $frak(k)_(upright(X X Z)) = x⋁_(m = 0\
sigma = plus.minus)^n frak(u) \( d_(m \, sigma) \)$ @wang2016subspace.


== The TFIM and LTFIM models
<the-tfim-and-ltfim-models>
In this section we review the symmetries of the different variants of the Transverse Field Ising Model (TFIM) presented in Section~#ref(<section:Ising>, supplement: none).

=== Open boundary condition
<open-boundary-condition>
Let us first consider open boundary conditions on the TFIM model. In this case, the generators $cal(G)_(upright("TFIM")) = {sum_(i = 1)^(n - 1) Z_i Z_(i + 1) \, sum_(i = 1)^n X_i}$ have two symmetries. On one hand, they commute with the parity symmetry $Pi$ defined in Eq. @eq:parity. On the other hand, they commute with the so-called $bb(Z)_2$ operator


$ Pi_(bb(Z)_2) = product_(i = 1)^n X_i $


that amounts to a global flip of the qubits. Consequently, $cal(H)$ is broken into four subspaces $cal(H)_(sigma \, sigma')$ with $sigma \, sigma' in { 1 \, - 1 }$. Because the initial state $| + chevron.r^(⊗ n)$ for the cost function in Eq. @eq:costTFIM is an eigenstate of both symmetry operators with eigenvalues $sigma = sigma' = + 1$, the dynamics under such a PQC is constrained to the $cal(H)_(+ 1 \, + 1)$ subspace. We find, using Algorithm~#ref(<alg:lie>, supplement: none), that the dimension of the DLA scales polynomially, $upright(d i m) ( frak(k) ) = n^2$ (and so does the restriction to the $sigma = sigma' = + 1$ subspace.


In turn, consider open boundary conditions on the #emph[Longitudinal] Transverse Field Ising Model (LTFIM), given by generators $cal(G)_(upright(L T F I M)) = cal(G)_(upright(T F I M)) ⋃ {sum_(i = 1)^n Z_i}$. While parity symmetry is conserved, the introduction of this new global longitudinal field breaks the $bb(Z)_2$ symmetry. Thus, we are left with only two subspaces, $cal(H) = x⋁_(sigma = plus.minus 1) cal(H)_sigma$, of dimensions $upright(d i m) ( cal(H)_sigma ) approx 2^n / 2$. As expected, the DLA breaks into two corresponding subspace DLAs, each of which we find to be full rank on the corresponding subspaces, i.e., both subspaces are controllable.


=== Closed boundary conditions
<closed-boundary-conditions>
Let us now consider closed boundary conditions. This case is slightly more involved since the parity symmetry is replaced by $C_n$, the cyclic group of $n$ elements. Hereafter, we follow Ref.~@d2021dynamical. Consider the operator $R$ whose action is to cycle the qubits in a state, i.e., $R | a_1 , dots.h , a_n chevron.r = | a_n , a_1 , dots.h , a_(n - 1) chevron.r$. Clearly, $R^n = I$. Now, as a consequence of the invariance of the generators under the action of this group of symmetries, the state space is broken into $n$ invariant subspaces $cal(H) = x⋁_(k = 0)^(n - 1) cal(H)_k$, where the projector onto each subspace is given by


$ bb(P)_k = 1 / n sum_(j = 0)^(n - 1) epsilon^(k j) R^j thin . $


In particular, the state $| + chevron.r^(⊗ n) in cal(H)_0$ and for that reason we will only focus on this subspace. Let us note that a general formula for the dimension of this subspace is, as far as we know, not known, but it is possible to derive a closed expression in the case of $n$ prime~@d2021dynamical


$ upright("dim") ( cal(H)_0 ) = 2 + frac(( 2^n - 2 ), n) thin , $


which makes evident that the subspace is exponentially large. Furthermore, we compute the DLA reduced to this subspace in the LTFIM case and see an exponential behaviour. In contrast, for the TFIM model we find a DLA that reduced to the $k = 0$ subspace and the $sigma' = + 1$ (also has $bb(Z)_2$ symmetry), and that has a linear scaling, i.e., $upright("dim") ( frak(k)_(0 , +) ) in cal(O) ( n )$.


= Initial state for the numerical simulations of the $X X Z$ spin chain model
<App:numerical>
The initial states $| psi_(m , +) chevron.r$ in the cost function of Eq.~@eq:costxxz are chosen to be eigenstates of the symmetries of the generators, namely $M = sum_(i = 1)^n Z_i$ and $Pi$ (the reflective spatial symmetry w.r.t. the chain's center) defined in Eq.~@eq:parity. That is, the initial state is


$ | psi_(m , +) chevron.r = 1 / sqrt(2) (⨂_(i = 1)^m | 0 chevron.r_i ⨂_(i = m + 1)^n | 1 chevron.r_i + ⨂_(i = 1)^(n - m) | 1 chevron.r_i ⨂_(i = n - m + 1)^n | 0 chevron.r_i) . $


Here $m$ denotes the number of excitations in the state, and $+$ the fact that it is an even parity eigenstate.

#bibliography("refs.bib")
