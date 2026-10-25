#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "a4", margin: (left: 2.03cm, right: 2.03cm, top: 2.32cm, bottom: 2.20cm))
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

#set par(justify: true, spacing: 0.47em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set figure(placement: top)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.47em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)
#let thmbox(fam, name, body) = figure(
  kind: fam,
  supplement: if type(name) == array { name.at(0) } else { name.split(" ").first() },
  numbering: "1",
  block(width: 100%, context {
    let num = counter(figure.where(kind: fam)).display()
    let head = if type(name) == array { name.at(0) } else { name.split(" ").first() }
    let tail = if type(name) == array { name.at(1) } else if name.contains(" ") { name.split(" ").slice(1).join(" ") } else { none }
    [*#head #num*]
    if tail != none { [ #tail] }
    h(0.4em)
    set text(style: "italic")
    body
  }),
)


#place(top + center, scope: "parent", float: true, clearance: 1.2em)[
  #align(center)[
    #text(12pt, weight: "bold", [Provably efficient machine learning for quantum many-body problems])   #v(1.2em)
    #text(10.5pt)[Hsin-Yuan Huang#super[1], Richard Kueng#super[2], Giacomo Torlai#super[3], Victor V. Albert#super[4], John Preskill#super[1]]
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Institute for Quantum Information and Matter and Department of Computing and Mathematical Sciences, Caltech, Pasadena, CA, USA] \
    #text(9pt)[#super[2] Institute for Integrated Circuits, Johannes Kepler University Linz, Austria] \
    #text(9pt)[#super[3] AWS Center for Quantum Computing, Pasadena, CA, USA] \
    #text(9pt)[#super[4] Joint Center for Quantum Information and Computer Science, National Institute of Standards and Technology and University of Maryland, College Park, MD, USA] \
  ]
]





// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: September 28, 2022)]]

Classical machine learning (ML) provides a potentially powerful approach to solving challenging quantum many-body problems in physics and chemistry. However, the advantages of ML over more traditional methods have not been firmly established. In this work, we prove that classical ML algorithms can efficiently predict ground state properties of gapped Hamiltonians in finite spatial dimensions, after learning from data obtained by measuring other Hamiltonians in the same quantum phase of matter. In contrast, under widely accepted complexity theory assumptions, classical algorithms that do not learn from data cannot achieve the same guarantee. We also prove that classical ML algorithms can efficiently classify a wide range of quantum phases of matter. Our arguments are based on the concept of a classical shadow, a succinct classical description of a many-body quantum state that can be constructed in feasible quantum experiments and be used to predict many properties of the state. Extensive numerical experiments corroborate our theoretical results in a variety of scenarios, including Rydberg atom systems, 2D random Heisenberg models, symmetry-protected topological phases, and topologically ordered phases.





= INTRODUCTION
<introduction>


// [figvision] imgs/MainIllus.png
// (a) The panel shows a schematic drawing of a process. A green ellipse represents a quantum system with blue
// lines inside. On the left, it is connected to a box labeled "Random Evolution" with arrows pointing out. The
// box is connected to a series of four boxes labeled "Measurements". An arrow points from there to a sphere with
// a blue grid and a series of binary numbers. A box on the right lists "Preserve Properties": Hamiltonian,
// Correlations, Entanglement Entropy, Local Observables, and others. The trend shows converting a quantum system
// to a classical representation via randomized measurements. (b) The panel shows a schematic drawing of a
// process. A blue honeycomb lattice represents parameters describing a physical Hamiltonian. An arrow points
// from it to a computer monitor labeled "Classical ML" and "Predicting...", with three colored boxes below. An
// arrow points from there to a sphere with a blue grid and a series of binary numbers, labeled "Classical
// representation of the ground state". The trend shows a classical ML model predicting a classical
// representation of the ground state. (c) The panel shows a schematic drawing of a process. A sphere with a gray
// grid and a series of binary numbers is labeled "Classical representation of the ground state". An arrow points
// from it to a computer monitor labeled "Classical ML" and "Predicting...", with four colored boxes below. They
// are labeled "Trivial", "Symmetry-broken", and "Topological". An arrow points from there to "Quantum phases of
// matter". The trend shows a classical ML model predicting phases of matter. (d) The panel shows a diagram with
// two tasks: "Ground state task" and "Phase of matter task". The ground state task has a red arrow pointing from
// "Parameters describing a physical Hamiltonian" and "Classical representation of the ground state" to "Quantum
// many-body ground state". The phase of matter task has three purple spheres with grids and binary numbers,




Solving quantum many-body problems, such as finding ground states of quantum systems, has far-reaching consequences for physics, materials science, and chemistry. While classical computers have facilitated many profound advances in science and technology, they often struggle to solve such problems. Powerful methods, such as density functional theory~@HohenbergKohn @NobelKohn, quantum Monte Carlo~@CEPERLEY555 @SandvikSSE @becca_sorella_2017 and density-matrix renormalization group~@DMRG1 @DMRG2, have enabled solutions to certain restricted instances of many-body problems, but many general classes of problems remain outside the reach of even the most advanced classical algorithms.


Scalable fault-tolerant quantum computers will be able to solve a broad array of quantum problems, but are unlikely to be available for years to come. Meanwhile, how can we best exploit our powerful classical computers to advance our understanding of complex quantum systems? Recently, classical machine learning (ML) techniques have been adapted to investigate problems in quantum many-body physics~@CarleoRMP @APXReview, with promising results~@dassarma2017 @carrasquilla2017nature @Carleo_2017 @torlai_learning_2016 @Nomura2017 @evert2017nature @leiwang2016 @gilmer2017neural @torlai_Tomo @vargas2018extrapolating @schutt2019unifying @Glasser2018 @rodriguez2019identifying @qiao2020orbnet @choo_fermionicnqs2020 @kawai2020predicting @moreno2020deep @Kottmann2021. So far these approaches are mostly heuristic, reflecting the general paucity of rigorous theory in ML. While shown to be effective in some intermediate-size experiments~@Bohrdt2018 @Rem2018 @torlai_rydberg19, these methods are generally not backed by convincing theoretical arguments to ensure good performance, particularly for problem instances where traditional classical algorithms falter.


In general, simulating quantum many-body physics is hard for classical computers, because accurately describing an $n$-qubit quantum system may require an amount of classical data that is exponential in $n$. In prior work, some of us addressed this bottleneck using #emph[classical shadows] --- succinct classical descriptions of quantum many-body states that can be used to accurately predict a wide range of properties with rigorous performance guarantees @huang2020predicting @paini2019approximate. Furthermore, this quantum-to-classical conversion technique can be readily implemented in various existing quantum experiments @Struchalin2021Shadows @Elben2020Entanglement @choi2021emergent. Classical shadows open new opportunities for addressing quantum problems using classical methods such as ML. In this paper, we build on the classical shadow formalism and devise polynomial-time classical ML algorithms for quantum many-body problems which are supported by rigorous theory.

#figure(image("imgs/MainIllus.png", width: 100.0%),
  caption: [
    (a) #smallcaps[Efficient quantum-to-classical conversion.] The classical shadow of a quantum state, constructed by measuring very few copies of the state, can be used to predict many properties of the state with a rigorous performance guarantee. (b) #smallcaps[Predicting ground state properties.] After training on data obtained in quantum experiments, a classical ML model predicts a classical representation of the ground state $rho ( x )$ of the Hamiltonian $H ( x )$ for parameters $x$ spanning the entire phase. This representation yields estimates of the properties of $rho ( x )$, avoiding the need to run exhaustive classical computations or quantum experiments. (c) #smallcaps[Classifying quantum phases.] After training, a classical ML receives a classical representation of a quantum state, and predicts the phase from which the state was drawn. (d) #smallcaps[Training data.] For predicting ground states, the classical ML receives a classical representation of $rho ( x )$ for each value of $x$ sampled during training. For predicting quantum phases of matter, the training data consists of classical representations of quantum states accompanied by labels identifying the phase to which each state belongs.
  ]
)
<fig:main>


We consider two applications of classical ML, indicated in @fig:main. The first application we examine is learning to predict classical representations of quantum many-body ground states. We consider a family of Hamiltonians, where the Hamiltonian $H ( x )$ depends smoothly on $m$ real parameters (denoted by $x$). The ML algorithm is trained on a set of training data consisting of sampled values of $x$, each accompanied by the corresponding classical shadow for the ground state $rho ( x )$ of $H ( x )$. This training data could be obtained from either classical simulations or quantum experiments. During the prediction phase, the ML algorithm predicts a classical representation of $rho ( x )$ for new values of $x$ different from those in the training data. Ground state properties can then be estimated using the predicted classical representation.


This learning algorithm is efficient, provided that the ground state properties to be predicted do not vary too rapidly as a function of $x$. Indeed, sufficient upper bounds on the gradient can be derived for any family of gapped geometrically-local Hamiltonians in any finite spatial dimension, if the property of interest is the expectation value of a sum of few-body observables. The conclusion is that any such property can be predicted with a small average error, where the amount of training data and the classical computation time are polynomial in $m$ and linear in the system size. Furthermore, we show that classical algorithms that do not learn from data cannot provide the same rigorous guarantee without violating widely accepted complexity-theoretic conjectures. This is a manifestation of the advantage of ML algorithms with data over those without data @huang2020power.


If the training data are obtained from quantum experiments, then one might choose to learn about properties of $rho ( x )$ for a new input $x$ by conducting new experiments rather than by using the classical ML to generalize from the training data. However, ML could be far more convenient in some cases, especially when changing some parameters may even require costly re-engineering of the entire experiment. ML algorithms open up the possibility of efficiently and accurately predicting properties of quantum states that are extremely challenging to prepare and measure in the laboratory.


Classical ML could be used to generalize from training data that are obtained from either quantum experiments or classical simulations; the same rigorous performance guarantees apply in either case. Even if the training data are generated classically, it could be more efficient and more accurate to use ML to predict properties for new values of the input $x$, rather than doing new simulations which could be computationally very demanding and of unverified reliability. Promising insights into quantum many-body physics are already being obtained using classical ML based on classical simulation data @dassarma2017 @Nomura2017 @Carleo_2017 @zhang2017machine @zhang2020interpreting @gilmer2017neural @vargas2018extrapolating @schutt2019unifying @qiao2020orbnet @choo_fermionicnqs2020 @kawai2020predicting. Our rigorous analysis identifies general conditions that guarantee the success of classical ML models, and elucidates the advantages of classical ML models over non-ML algorithms. These results enhance the prospects for interpretable ML techniques @ribeiro2016should @arrieta2020explainable @zhang2020interpreting to further shed light on quantum many-body physics.


In the second application we examine, the goal is to classify quantum states of matter into phases @Read2012 in a supervised learning scenario. Suppose that during training we are provided with sample quantum states which carry labels indicating whether each state belongs to phase $A$ or phase $B$. Our goal is to predict the phase label for new quantum states that were not encountered during training. We assume that, during both the learning and prediction stages, each quantum state is represented by its classical shadow, which could be obtained either from a classical computation or from an experiment on a quantum device. The classical ML, then, trains on labeled classical shadows, and learns to predict labels for new classical shadows.


We assume that the $A$ and $B$ phases can be distinguished by a nonlinear function of marginal density operators of subsystems of constant size. This assumption is reasonable because we expect the phase to be revealed in subsystems which are larger than the correlation length, but independent of the total system size. We show that if such a function exists, a classical ML can learn to distinguish the phases using an amount of training data and classical processing which are polynomial in the system size. We do not need to know anything about this nonlinear function in advance, apart from its existence.


In what follows, we review the classical shadow formalism @huang2020predicting, and use this formalism to derive rigorous guarantees for ML algorithms in predicting ground state properties and classifying quantum phases of matter. We also describe numerical experiments in a wide range of physical systems to support our theoretical results.


= CONSTRUCTING EFFICIENT CLASSICAL REPRESENTATIONS OF QUANTUM SYSTEMS
<constructing-efficient-classical-representations-of-quantum-systems>


We begin with an overview of the randomized measurement toolbox @Ohliger_2013 @VanEnk2012 @Elben2018 @evans2019scalable @huang2020predicting @paini2019approximate, relegating further details to Appendix~#ref(<sec:classical-shadows>, supplement: none). We approximate an $n$-qubit quantum state $rho$ by performing randomized single-qubit Pauli measurements on $T$ copies of $rho$. That is, we measure every qubit of the unknown quantum state $rho$ in a random Pauli basis $X , Y$ or $Z$ to yield a measurement outcome of $plus.minus 1$. Collapse of the wavefunction implies that this measurement procedure transforms $rho$ into a random pure product state $| s^(( t )) chevron.r = ⨂_(i = 1)^n | s_i^(( t )) chevron.r$, where $| s_i^(( t )) chevron.r in ( | 0 chevron.r , | 1 chevron.r , | + chevron.r , | - chevron.r , | upright(i) + chevron.r , | upright(i) - chevron.r )$ are eigenstates of the selected Pauli matrices. Performing one randomized measurement grants us classical access to one such snapshot. Performing a total of $T$ randomized measurements grants us access to an entire collection $S_T ( rho ) = { | s_i^(( t )) chevron.r : #h(0em) i in ( 1 , dots.h , n ) , #h(0em) t in ( 1 , dots.h , T ) }$. Each element is a highly structured single-qubit pure state, and there are $n T$ of them in total. So, $3 n T$ bits suffice to store the entire collection in classical memory. The randomized measurements can be performed in actual physical experiments or through classical simulations. Resulting data can then be used to approximate the underlying $n$-qubit state $rho$:


$ rho approx sigma_T ( rho ) = 1 / T sum_(t = 1)^T sigma_1^(( t )) ⊗ dots.h ⊗ sigma_n^(( t )) quad upright("where") quad sigma_i^(( t )) = 3 | s_i^(( t )) chevron.r chevron.l s_i^(( t )) | - bb(I) , $<eq:sigma-T-shadow>


and $bb(I)$ denotes the $2 times 2$ identity matrix. This #emph[classical shadow] representation~@huang2020predicting @paini2019approximate exactly reproduces the global density matrix in the limit $T arrow.r oo$, but $T = cal(O) ( upright("const")^r log ( n ) / epsilon.alt^2 )$ already provides an $epsilon.alt$-accurate approximation of #emph[all] reduced $r$-body density matrices (in trace distance). This, in turn, implies that we can use $sigma_T ( rho )$ to predict any function that depends on only reduced density matrices, such as expectation values of (sums of) local observables and (sums of) entanglement entropies of small subsystems. Classical storage and postprocessing cost also remain tractable in this regime. To summarize, the classical shadow formalism equips us with an efficient quantum-to-classical converter that allows classical machines to efficiently and reliably estimate subsystem properties of any quantum state $rho$.


= PREDICTING GROUND STATES OF QUANTUM MANY-BODY SYSTEMS
<predicting-ground-states-of-quantum-many-body-systems>


We consider the task of predicting ground state representations of quantum many-body Hamiltonians in finite spatial dimensions. Suppose that a family of geometrically local, $n$-qubit Hamiltonians $( H ( x ) : #h(0em) x in [ - 1 , 1 ]^m )$ is parametrized by a classical variable $x$. That is, $H ( x )$ smoothly maps a bounded $m$-dimensional vector $x$ (parametrization) to a Hermitian matrix of size $2^n times 2^n$ ($n$-qubit Hamiltonian). We do not impose any additional structure on this mapping; in particular, we do not assume knowledge about how the physical Hamiltonian depends on the parameterization. The goal is to learn a model $hat(sigma) ( x )$ that can predict properties of the ground state $rho ( x )$ associated with Hamiltonian. This problem arises in many practical scenarios. Suppose diligent experimental effort has produced experimental data for ground state properties of various physical systems. We would like to use this data to train an ML model that predicts ground state representations of hitherto unexplored physical systems.


== An ML algorithm with rigorous guarantee
<an-ml-algorithm-with-rigorous-guarantee>


We will prove that a classical ML algorithm can predict classical representations of ground states after training on data belonging to the same quantum phase of matter. Formally, we consider a smooth family of Hamiltonians $H ( x )$ with a constant spectral gap. During the training phase of the ML algorithm, many values of $x$ are randomly sampled, and for each sampled $x$, the classical shadow of the corresponding ground state $rho ( x )$ of $H ( x )$ is provided, either by classical simulations or quantum experiments. The full training data of size $N$ is given by ${ x_ell arrow.r sigma_T ( rho ( x_ell ) ) }_(ell = 1)^N$, where $T$ is the number of randomized measurements in the construction of the classical shadows at each value of $x_ell$.


We train classical ML models using the size-$N$ training data, such that when given the input $x_ell$, the ML model can produce a classical representation $hat(sigma) ( x )$ that approximates $sigma_T ( rho ( x_ell ) )$. During prediction, the classical ML produces $hat(sigma) ( x )$ for new values of $x$ different from those in the training data. While $hat(sigma) ( x )$ and $sigma_T ( rho ( x_ell ) )$ classically represent exponentially large density matrices, the training and prediction can be done efficiently on a classical computer using various existing classical ML models, such as neural networks with large hidden layers @jacot2018neural @li2019enhanced @du2019graph @neuraltangents2020 and kernel methods @cortes1995support @CC01a. In particular, the predicted output of the trained classical ML models can be written as the extrapolation of the training data using a learned metric $kappa ( x , x_ell ) in bb(R)$,


$ hat(sigma) ( x ) = 1 / N sum_(ell = 1)^N kappa ( x , x_ell ) sigma_T ( rho ( x_ell ) ) . $<eq:sigma-x->



For example, prediction using a trained neural network with large hidden layers  @jacot2018neural is equivalent to using the metric $kappa ( x , x_ell ) = sum_(ell' = 1)^N f^(upright("(") thin upright("NTK") thin upright(")")) ( x , x_(ell') ) ( F^(- 1) )_(ell' ell)$, where $f^(upright("(") thin upright("NTK") thin upright(")")) ( x , x' )$ is the neural tangent kernel  @jacot2018neural corresponding to the neural network and $F_(ell' ell) = f^(upright("(") thin upright("NTK") thin upright(")")) ( x_(ell') , x_ell )$; see Appendix~#ref(<sec:neuralnetwork>, supplement: none) for more discussion.


The ground state properties are then estimated using these predicted classical representations $hat(sigma) ( x )$. Specifically, $f_O ( x ) = upright("tr") (O rho ( x ))$ can be predicted efficiently whenever $O$ is a sum of few-body operators.


To derive a provable guarantee, we consider the simple metric $kappa(x, x_("ell")) = sum_{k in bb(Z)^m, norm(k)_2 lt.eq Lambda} "cos"(pi k dot.op (x - x_("ell")))$ with cutoff $Lambda$, which we refer to as the $l_2$-Dirichlet kernel. We prove that the prediction will be accurate and efficient if the function $f_O ( x )$ does not vary too rapidly when $x$ changes in any direction. Indeed, sufficient upper bounds on the gradient magnitude of $f_O ( x )$ can be derived using quasi-adiabatic continuation @hastings2005quasiadiabatic @bachmann2012automorphic.


Under the $l_2$-Dirichlet kernel, the classical ML model is equivalent to learning a truncated Fourier series to approximate the function $f_O ( x )$. The parameter $Lambda$ is a cutoff for the wavenumber $k$ that depends on (upper bounds on) the gradient of $f_O ( x )$. Using statistical analysis, one can guarantee that $"𝔼"_x | "tr" ( O hat(sigma) ( x ) ) - f_O ( x ) |^2 lt.eq epsilon.alt$ as long as the amount of training data obeys $N = m^(cal(O) ( 1 / epsilon.alt ))$ in the $m arrow.r oo$ limit. The conclusion is that any such $f_O ( x )$ can be predicted with a small #emph[constant] average error, where the amount of training data and the classical computation time are polynomial in $m$ and at most linear in the system size $n$. Moreover, the training data need only contain a #emph[single] classical shadow snapshot at each point $x_ell$ in the parameter space (i.e., $T = 1$). An informal statement of the theorem is given below; we explain the proof strategy in Appendix~#ref(<sec:proofideaGSUPP>, supplement: none), and provide more details in Appendix~#ref(<sec:proofthmGSUPP>, supplement: none). We also discuss how one could generalize the proof to long-range interacting systems, electronic Hamiltonians, and other settings in Appendix~#ref(<sec:generalize-GSUPP>, supplement: none).


#thmbox("theorem", "Theorem (Learning to predict ground state representations; informal)")[


For any smooth family of Hamiltonians $( H ( x ) : #h(0em) x in [ - 1 , 1 ]^m )$ in a finite spatial dimension with a constant spectral gap, the classical machine learning algorithm can learn to predict a classical representation of the ground state $rho ( x )$ of $H ( x )$ that approximates few-body reduced density matrices up to a constant error $epsilon.alt$ when averaged over $x$. The required training data size $N$ and computation time are polynomial in $m$ and linear in the system size $n$.


] <thm:mainFourier>


Though formally "efficient" in the sense that $N$ scales polynomially with $m$ for any fixed approximation error $epsilon.alt$, the required amount of training data scales badly with $epsilon.alt$. This unfortunate scaling is not a shortcoming of the considered ML algorithm, but a necessary feature. In Appendix~#ref(<app:proofthmlowerbound>, supplement: none), we show that the data size and time complexity cannot be improved further without making stronger assumptions about the class of gapped local Hamiltonians. However, in cases of practical interest, the Hamiltonian may obey restrictions such as translational invariance or graph structure that can be exploited to obtain better results. Incorporating these restrictions can be achieved by using a suitable $kappa ( x , x_ell )$, such as one that corresponds to a large-width convolutional neural network @li2019enhanced or a graph neural network @du2019graph. Rigorously establishing that neural-network-based ML algorithms can achieve improved prediction performance and efficiency for particular classes of Hamiltonians is a goal for future work.


== Computational hardness for non-ML algorithms
<computational-hardness-for-non-ml-algorithms>


In the following proposition, we show that a classical algorithm that does not learn from data cannot achieve the same guarantee in estimating ground state properties without violating the widely believed conjecture that NP-complete problems cannot be solved in randomized polynomial time. This proposition is a corollary of standard complexity-theoretic results @Lichtenstein1982PlanarFA @VALIANT198685. See Appendix~#ref(<sec:proofhardnonML>, supplement: none) for the detailed statement and proof.


#thmbox("proposition", "Proposition (Informal)")[


Consider a randomized polynomial-time classical algorithm $cal(A)$ that does not learn from data. Suppose for any smooth family of two-dimensional Hamiltonians $( H ( x ) : #h(0em) x in [ - 1 , 1 ]^m )$ with a constant spectral gap, $cal(A)$ can efficiently compute expectation values of one-body observables in the ground state $rho ( x )$ of $H ( x )$ up to a constant error when averaged over $x$. Then there is a randomized classical algorithm that can solve NP-complete problems in polynomial time.


] <thm:hardnonML>


It is instructive to observe that a classical ML algorithm with access to data can perform tasks that cannot be achieved by classical algorithms which do not have access to data. This phenomenon is studied in @huang2020power, where it is shown that the complexity class defined by classical algorithms that can learn from data is strictly larger than the class of classical algorithms that do not learn from data. (The data can be regarded as a restricted form of randomized advice string.) We caution that obtaining the data to train the classical ML model could be challenging. However, if we focus only on data that could be efficiently generated by quantum-mechanical processes, it is still possible that a classical ML that learns from data could be more powerful than classical computers. In Appendix~#ref(<sec:proofhardnonML>, supplement: none) we present a contrived family of Hamiltonians that establishes this claim, based on the (classical) computational hardness of factoring.


= CLASSIFYING QUANTUM PHASES OF MATTER
<classifying-quantum-phases-of-matter>


Classifying quantum phases of matter is another important application of machine learning to physics. We will consider this classification problem in the case where quantum states are succinctly represented by their classical shadows. For simplicity, we consider the classification of two phases (denoted $A$ and $B$), but the analysis naturally generalizes to classifying any number of phases.


== ML algorithms
<ml-algorithms>


We envision training a classical ML with classical shadows, where each classical shadow carries a label $y$ indicating whether it represents a quantum state $rho$ from phase $A ( y ( rho ) = 1 )$ or phase $B ( y ( rho ) = - 1 )$. We want to show that a suitably chosen classical ML can learn to efficiently predict the phase for new classical shadows beyond those encountered during training. Following a strategy which is standard in learning theory, we consider a classical ML that maps each classical shadow to a corresponding feature vector in a high-dimensional feature space, and then attempts to find a hyperplane that separates feature vectors in the $A$ phase from feature vectors in the $B$ phase. The learning is efficient if the geometry of the feature space is efficiently computable, and if the feature map is sufficiently expressive. Thus, our task is to construct a feature map with the desired properties.


In the simpler task of classifying symmetry-breaking phases, there is typically a local order parameter $O = sum_i O_i$ given as a sum of $r$-body observables for some $r > 0$ that satisfies


$ "tr" ( O rho ) gt.eq 1 , forall rho in upright("phase A") , quad quad "tr" ( O rho ) lt.eq - 1 , forall rho in upright("phase B") . $<eq:observPhase>


Under this criterion, the classification function may be chosen to be $y ( rho ) = "sign" ( "tr" ( O rho ) )$. Hence, classifying symmetry-breaking phases can be achieved by finding a hyperplane that separates the two phases in the high-dimensional feature space that subsumes all $r$-body reduced density matrices of the quantum state $rho$. The feature vector consisting of all $r$-body reduced density matrices of the quantum state $rho$ can be accurately reconstructed from the classical shadow representation $S_T ( rho )$ when $T$ is sufficiently large.


Finding a suitable choice of hyperplane in the feature space can be cast as a convex optimization problem known as the soft-margin support vector machine, discussed in more detail in Appendix~#ref(<sec:trainSVM>, supplement: none). With a sufficient amount of training data, the hyperplane found by the classical ML model will generalize so the phase $y ( rho )$ can be predicted accurately for a previously unseen quantum state $rho$. The classical ML is not merely a black box; it exhibits the order parameter (encoded by the hyperplane), guiding physicists toward a deeper understanding of the phase structure.


For more exotic quantum phases of matter, such as topologically ordered phases, the above classical ML model no longer suffices. The topological phase of a state is invariant under a constant-depth quantum circuit, and a phase containing the product state $| 0 chevron.r^(⊗ n)$ is called the trivial phase. Using these notions, we can prove that no observable --- not even one that acts on the entire system --- can be used to distinguish between two topological phases. The proof, given in Appendix~#ref(<sec:no-nonlocal-obs>, supplement: none), uses the observation that random single-qubit unitaries can confuse any global or local order parameter.


#thmbox("proposition", "Proposition")[


Consider two distinct topological phases $A$ and $B$ (one of the phases could be the trivial phase). No observable $O$ exists such that


$ "tr" ( O rho ) > 0 , forall rho in upright("phase A") , quad quad "tr" ( O rho ) lt.eq 0 , forall rho in upright("phase B") . $


] <prop:noobs>


While this proposition implies that no linear function $"tr" ( O rho )$ can be used to classify topologically ordered phases, it does not exclude nonlinear functions, such as quadratic functions $"tr" ( O rho ⊗ rho )$, degree-$d$ polynomials $"tr" ( O rho^(⊗ d) )$ and more general analytic functions. For example, it is known that the topological entanglement entropy @kitaev2006topological @levin2006detecting, a nonlinear function of $rho$, can be used to classify a wide variety of topologically ordered phases. For this purpose, it suffices to consider a subsystem whose size is large compared to the correlation length of the state, but is independent of the total size of the system. The correlation length in the ground state of a local Hamiltonian increases when the spectral gap between the ground state and the first excited state becomes smaller @hastings2006spectral. On the other hand, a linear function on the full system will fail even with constant correlation length.


To learn nonlinear functions, we need a more expressive ML model. For this purpose we devise a powerful feature map that takes the classical shadow $S_T ( rho )$ of the quantum state $rho$ to a feature vector that includes arbitrarily-large $r$-body reduced density matrices, as well as an arbitrarily-high-degree polynomial expansion,


$ phi.alt^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho ) ) = lim_(D , R arrow.r oo) x⋁_(d = 0)^D sqrt(frac(tau^d, d !)) (x⋁_(r = 0)^R sqrt(frac(1, r !) (gamma / n)^r) x⋁_(i_1 = 1)^n dots.h x⋁_(i_r = 1)^n upright("vec") [1 / T sum_(t = 1)^T ⨂_(ell = 1)^r sigma_(i_ell)^(( t ))])^(⊗ d) , $<eq:featureshadow>


where $tau , gamma > 0$ are hyper-parameters. The direct sum $x⋁_(r = 0)^R$ is a concatenation of all $r$-body reduced density matrices, and the other direct sum $x⋁_(d = 0)^D$ subsumes all degree-$d$ polynomial expansions. The computational cost of finding a hyperplane in feature space that separates the training data into two classes is dominated by the cost of computing inner products between feature vectors. The inner product $chevron.l phi.alt^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho ) ) , phi.alt^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( tilde(rho) ) ) chevron.r$ can be analytically computed by reorganizing the direct sums, writing it as a double series, and wrapping both series into an exponential, which gives


$ k^(upright("(") thin upright("shadow") thin upright(")")) (S_T ( rho ) , S_T ( tilde(rho) )) = exp (tau / T^2 sum_(t , t' = 1)^T exp (gamma / n sum_(i = 1)^n "tr" (sigma_i^(( t )) tilde(sigma)_i^(( t' ))))) , $<eq:doubleinfkernel>


where $S_T ( rho )$ and $S_T ( tilde(rho) )$ are classical shadow representations of $rho$ and $tilde(rho)$, respectively. The computation time for the inner product is $cal(O) ( n T^2 )$, linear in the system size $n$ and quadratic in $T$, the number of copies of each quantum state which are measured to construct the classical shadow.


== Rigorous guarantee
<rigorous-guarantee>


By statistical analysis, we can establish a rigorous guarantee for the classical ML model $chevron.l alpha , phi.alt^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho ) ) chevron.r$, where $alpha$ is the trainable vector defining the classifying hyperplane. The result is the following theorem proven in Appendix~#ref(<sec:proofthmPHASEC>, supplement: none).


#thmbox("theorem", "Theorem (Classifying quantum phases of matter; informal)")[


If there is a nonlinear function of few-body reduced density matrices that classifies phases, then the classical algorithm can learn to classify these phases accurately. The required amount of training data and computation time scale polynomially in system size.


] <thm:phaseclassification>


If there is an efficient procedure based on #emph[few-body reduced density matrices] for classifying phases, the proposed ML algorithm is guaranteed to find the procedure efficiently. This includes local order parameters for classifying symmetry breaking phases, and topological entanglement entropy in a sufficiently large local region for partially classifying topological phases @kitaev2006topological @levin2006detecting. We expect that, to classify topological phases accurately, the classical ML will need access to local regions that are sufficiently large compared to the correlation length, and as we approach the phase boundary, the correlation length increases. As a result, the classifying function for topological phases may depend on $r$-body subsystems with a larger $r$, and the amount of training data and computation time required would increase accordingly. Note that the classical ML not only classifies phases accurately, but also constructs a classifying function explicitly.


Our classical ML model may also be useful for classifying and understanding symmetry-protected topological (SPT) phases. SPT phases are characterized much like topological phases, but with the additional constraint that all structures involved (states, Hamiltonians, and quantum circuits) respect a particular symmetry. It is reasonable to expect that an SPT phase can be identified by examining reduced density matrices on constant-size regions @Li2008 @Pollmann2010 @pollmann2012detection @Haegeman2012 @Shapourian2017 @Dehghani2021, where the size of the region is large compared to the correlation length. The existence of classifying functions based on reduced matrices have been rigorously established in some cases @Kitaev2006 @zhang2017quantum @Hastings2015 @Kapustin2020 @Bachmann2020 @Bachmann2014a @tasakiPRL2018 @Tasaki2020. In Appendix~#ref(<sec:tasaki>, supplement: none), we prove that the ML algorithm is guaranteed to efficiently classify a class of gapped spin-$1$ chains in one dimension. For more general SPT phases, the ML algorithm should be able to corroborate known classification schemes, determine new and potentially more compact classifiers, and shed light on interacting SPT phases in two or more dimensions for which complete classification schemes have not yet been firmly established.


The hypothesis of @thm:phaseclassification, stating that phases can be recognized by inspecting regions of constant size independent of the total system size, is particularly plausible for gapped phases, but might apply to some gapless phases as well. Our classical ML model would be able to efficiently classify such gapless phases. On the other hand, the contrapositive of @thm:phaseclassification asserts that if the classical ML is not able to distinguish between two distinct gapless phases, then nonlocal data is required to characterize at least one of those phases.


= NUMERICAL EXPERIMENTS
<sec:numerics>


// [figvision] imgs/rydberg.png
// (a) This panel is a schematic. It shows a one-dimensional array of Rydberg atoms with a separation of 'a'. The
// atoms are represented by red circles. The Hamiltonian of the system is given by an equation, which includes
// terms for the energy of the two-level system and the interaction between atoms. The two-level system is shown
// in an inset, with a ground state and a Rydberg state. Three phases of the system are illustrated: disordered,
// Z2-ordered, and Z3-ordered. (b) This panel is a plot. The axes are interaction range (Rb/a) and detuning
// (Δ/Ω), with ranges of 2.75 to 4.00 and -2 to 6, respectively. The plot shows a phase diagram with three
// distinct phases: disordered, Z2-ordered, and Z3-ordered, represented by blue, red, and orange dots,
// respectively. There are 20 training data points enclosed by gray circles and three testing points indicated by
// black star, diamond, and cross symbols. (c) This panel consists of six plots. The top three plots show the
// expectation values of X, Z, and Z, respectively, for a 1D array of Rydberg atoms. The bottom three plots show
// the same quantities but for the nearest training data. The x-axis represents the number of Rydberg atoms,
// ranging from 0 to 15. The y-axis represents the expectation values, ranging from -1 to 1. The plots show the
// results of classical machine learning (ML) and exact values from DMRG, represented by different symbols and
// colors. The trend shows that the expectation values oscillate or converge as the number of Rydberg atoms
// increases.
#figure(image("imgs/rydberg.png", width: 100.0%),
  caption: [
    Numerical experiment for predicting ground-state properties in a 1D Rydberg atom system with 51 atoms. (a) #smallcaps[Hamiltonian.] Illustration of the Rydberg array geometry, Hamiltonian, and phases. (b) #smallcaps[Phase diagram.] The system's three distinct phases @bernien2017probing are characterized by two order parameters (for $Z_2$ and $Z_3$ orders). Training data are enclosed by gray circles, and three specific testing points are indicated by the star, diamond, and cross, respectively. (c) #smallcaps[Local expectation values.] We use classical ML (the best model is selected from a set of ML models) to predict the expectation values of Pauli operators $X_i$ and $Z_i$ for each atom at the three testing points. We compare with "predictions" obtained from the training data nearest to the testing points. The markers denote predicted values, while the solid lines denote exact values obtained from DMRG. Additional predictions are shown in Appendix~#ref(<sec:more-numer>, supplement: none).
  ]
)
<fig:rydberg>



We have conducted numerical experiments assessing the performance of classical ML algorithms in some practical settings. The results demonstrate that our theoretical claims carry over to practice, with the results sometimes turning out even better than our guarantees suggest.


== Predicting ground state properties
<predicting-ground-state-properties>


For predicting ground states, we consider classical ML models encompassed by Eq.~#ref(<eq:sigma-x->, supplement: none). We examine various metrics $kappa ( x , x_ell )$ equivalent to training neural networks with large hidden layers @jacot2018neural @neuraltangents2020 or training kernel methods @cortes1995support @murphy2012machine. We find the best ML model and the hyperparameters using a validation set to minimize root-mean-square error (RMSE) and report the predictions on a test set. The full details of the models and hyperparameters, as well as their comparison, are given in Appendix~#ref(<sec:numdetail-groundstate>, supplement: none)~and~@sec:numdetail-groundstate2.


#emph[Rydberg atom chain] --- Our first example is a system of trapped Rydberg atoms~@Fendley2004 @browaeys_many-body_2020, a programmable and highly-controlled platform for Ising-type quantum simulations~@Schauss1455 @Endres2016 @bernien2017probing @Labuhn @Misha256 @2020arXiv201212268S. Following~@bernien2017probing, we consider a one-dimensional array of $n = 51$ atoms, with each atom effectively described as a two-level system composed of a ground state $| g chevron.r$ and a highly-excited Rydberg state $| r chevron.r$. The atomic chain is characterized by a Hamiltonian $H ( x )$ (given in @fig:rydberg\(a)) whose parameters are the laser detuning $x_1 = Delta / Omega$ and the interaction range $x_2 = R_b / a$. The phase diagram (shown in @fig:rydberg\(b)) features a disordered phase and several broken-symmetry phases, stemming from the competition between the detuning and the Rydberg blockade (arising from the repulsive Van der Waals interactions).


We trained a classical ML model using $20$ randomly chosen values of the parameter $x = ( x_1 , x_2 )$\; these values are indicated by gray circles in @fig:rydberg\(b). For each such $x$, an approximation to the exact ground state was found using DMRG~@DMRG1 based on the formalism of matrix product states (MPS)~@SCHOLLWOCK201196. For each MPS, we performed $T = 500$ randomized Pauli measurements to construct a classical shadow. The classical ML then predicted classical representations at the testing points in the parameter space, and these predicted classical representations were used to estimate expectation values of local observables at the testing points.


Predictions for expectation values of Pauli operators $Z_i$ and $X_i$ at the testing points are shown in @fig:rydberg\(c), and found to agree well with exact values obtained from the DMRG computation of the ground state at the testing points. Additional predictions can be found in Appendix~#ref(<sec:more-numer>, supplement: none). Also shown are results from a more naive procedure, in which properties are predicted using only the data at the point in the training set which is closest to the testing point. The naive procedure predicts poorly, illustrating that the considered classical ML model effectively leverages the data from multiple points in the training set.


This example corroborates our expectation that classical machines can learn to efficiently predict ground state representations. An important caveat is that the rigorous guarantee in @thm:mainFourier applies only when the training points and the testing points are sampled from the same phase, while in this example the training data includes values of $x$ from three different phases. Nevertheless, our numerics show that classical machines can still learn to predict well.


// [figvision] imgs/Heisenberg.png
// (a) Schematic. The 2D antiferromagnetic random Heisenberg model geometry and Hamiltonian are illustrated. The
// model consists of a 5x5 grid of lattice points, each representing a spin. The spins are connected by edges
// with varying thickness, indicating the coupling strength J_{ij}. The couplings are random and sampled
// uniformly from [-1, 1]. The Hamiltonian is given by H = _{ ij } J_{ij} (X_i X_j + Y_i Y_j + Z_i Z_j). (b)
// Two-point correlator plot. The plot consists of two panels, each showing a heatmap of the two-point
// correlator. The x-axis represents spin i and the y-axis represents spin j, both ranging from 1 to 25. The
// colorbar indicates the correlation function value, ranging from -1.0 to 1.0. The left panel shows exact values
// from DMRG, and the right panel shows ML predictions. Blue dots indicate positive correlations, while orange
// dots indicate negative correlations. (c) Scatter plot. The plot shows the RMS error between the true ground
// state and the ML-predicted ground state for different system sizes. The x-axis represents the RMS error,
#figure(image("imgs/Heisenberg.png", width: 100.0%),
  caption: [
    Numerical experiment for predicting ground state properties in the 2D antiferromagnetic Heisenberg model. (a) #smallcaps[Hamiltonian.] Illustration of the Heisenberg model geometry and Hamiltonian. We consider random couplings $J_(i j)$, sampled uniformly from $[ 0 , 2 ]$. A particular instance is shown, with coupling strength indicated by the thickness of the edges connecting lattice points. (b) #smallcaps[Two-point correlator.] Exact values and ML predictions of the expectation value of the correlation function $C_(i j) = 1 / 3 ( X_i X_j + Y_i Y_j + Z_i Z_j )$ for all spin pairs $( i j )$ in the lattice, for the Hamiltonian instance shown in (a). The absolute value of $C_(i j)$ is represented by the size of each circle, while the circle's color indicates the actual value. (c) #smallcaps[Prediction error.] Each blue point indicates the root-mean-square error (averaged over Heisenberg model instances) of the correlation function for a particular pair $( i j )$, where the estimate of $C_(i j)$ is obtained using a classical shadow with $T = 500$ randomized Pauli measurements of the true ground state. Red points indicate errors in ML predictions for $C_(i j)$.
  ]
)
<fig:heisenberg>



#emph[2D antiferromagnetic Heisenberg model] --- Our next example is the two-dimensional antiferromagnetic Heisenberg model. Spin-$1 / 2$ particles (i.e. qubits) occupy sites on a square lattice, and for each pair $( i j )$ of neighboring sites the Hamiltonian contains a term $J_(i j) (X_i X_j + Y_i Y_j + Z_i Z_j)$ where the couplings ${ J_(i j) }$ are uniformly sampled from the unit interval $[ 0 , 2 ]$. The parameter $x$ is a list of all $J_(i j)$ couplings; hence in this case the dimension of the parameter space is $m = O ( n )$, where $n$ is the number of qubits. The Hamiltonian $H ( x )$ on a $5 times 5$ lattice is shown in @fig:heisenberg\(a).


We trained a classical ML model using 90 randomly chosen values of the parameter $x = { J_(i j) }$. For each such $x$, the exact ground state was found using DMRG, and we simulated $T = 500$ randomized Pauli measurements to construct a classical shadow. The classical ML predicted the classical representation at new values of $x$, and we used the predicted classical representation to estimate a two-body correlation function, the expectation value of $C_(i j) = 1 / 3 (X_i X_j + Y_i Y_j + Z_i Z_j)$, for each pair of qubits $( i j )$. In @fig:heisenberg\(b), the predicted and actual values of the correlation function are displayed for a particular value of $x$, showing reasonable agreement.


@fig:heisenberg\(c) shows the prediction performance for all pairs of spins and for variable system size. Each red point in the plot represents the RMSE in the correlation function estimated using our predicted classical representation, for a particular pair of spins and averaged over sampled values of $x$. For comparison, each blue point is the RMSE when the correlation function is predicted using the classical shadow obtained by measuring the actual ground state $T = 500$ times. For most correlation functions, the prediction error achieved by the best classical ML model is comparable to the error achieved by measuring the actual ground state.


== Classifying quantum phases of matter
<subsec:numerics-classification>


For classifying quantum phases of matter, we consider an unsupervised classical ML model that constructs an infinite-dimensional #emph[nonlinear] feature vector for each quantum state $rho$ by applying the map $phi.alt^(upright("(") thin upright("shadow") thin upright(")"))$ in Eq.~#ref(<eq:featureshadow>, supplement: none) with $tau , gamma = 1$ to the classical shadow $S_T ( rho )$ of the quantum state $rho$. We then perform a principal component analysis (PCA) @pearson1901liii in the infinite-dimensional #emph[nonlinear] feature space. The low-dimensional subspace found by PCA in the nonlinear feature space corresponds to a nonlinear low-dimensional manifold in the original quantum state space. This method is efficient using the shadow kernel $k^(upright("(") thin upright("shadow") thin upright(")"))$ given in Eq.~#ref(<eq:doubleinfkernel>, supplement: none) and the kernel PCA procedure @scholkopf1998nonlinear. Details are given in Appendix~#ref(<sec:numdetail-phases>, supplement: none)~and~@sec:numdetail-phases2.


#emph[Bond-alternating XXZ model] --- We begin by considering the bond-alternating XXZ model with $n = 300$ spins. The Hamiltonian is given in @fig:XXZ\(a); it encompasses the bond-alternating Heisenberg model ($delta = 1$) and the bosonic version of the Su-Schrieffer-Heeger model ($delta = 0$)~@su1979solitons. The phase diagram in @fig:XXZ\(b) is obtained by evaluating the partial reflection many-body topological invariant @pollmann2012detection @elben2020many. There are three different phases: trivial, symmetry-protected topological, and symmetry broken.


For each value of $J$ and $delta$ considered, we construct the exact ground state using DMRG, and find its classical shadow by performing randomized Pauli measurement $T = 500$ times. We then consider a two-dimensional principal subspace of the infinite-dimensional nonlinear feature space found by the unsupervised ML based on the shadow kernel, which is visualized in @fig:XXZ\(c, d). We can clearly see that the different phases are well separated in the principal subspace. This shows that even without any phase labels on the training data, the ML model can already classify the phases accurately. Hence, when trained with only a small amount of labeled data, the ML model will be able to correctly classify the phases as guaranteed by @thm:phaseclassification.


// [figvision] imgs/SPT.png
// (a) This is a schematic of a one-dimensional qubit chain. The objects are circles representing qubits, and
// lines representing bonds between them. The bonds are labelled J and J', indicating alternating coupling
// strengths. The bonds also have an associated equation, (X_iX_{i+1} + Y_iY_{i+1} + Z_i Z_{i+1}), indicating the
// Hamiltonian of the system. (b) This is a 2D plot of the phase diagram. The x-axis is J'/J, ranging from 0 to
// 2.5, and the y-axis is , ranging from 0 to 3. The plot is coloured, with blue denoting a trivial phase, red
// denoting a topological phase, and gray denoting a symmetry-broken phase. The trend shows that as increases,
// the phase changes from trivial to symmetry-broken, and as J'/J increases, the phase changes from topological
// to trivial. (c) Top: This is a 2D scatter plot of unsupervised machine learning (ML) at = 0.5. The x-axis is
// the 1st principal component, ranging from -4 to 4, and the y-axis is the 2nd principal component, ranging from
// -1 to 1. There are two series of points, coloured from blue to red, representing different phases. The points
// form two clusters, one for the trivial phase and one for the topological phase. Bottom: This is a 1D plot of
// {Z}_R versus J'/J. The y-axis ranges from -1 to 1, and the x-axis ranges from 0 to 2.5. The points are
// coloured from blue to red, representing different phases. The trend shows that as J'/J increases, {Z}_R
// decreases sharply from 1 to -1. (d) Top: This is a 2D scatter plot of unsupervised ML at = 3.0. The x-axis is
// the 1st principal component, ranging from -4 to 4, and the y-axis is the 2nd principal component, ranging from
// -1 to 1. There are three series of points, coloured from blue to red, representing different phases. The
// points form three clusters, one for the trivial phase, one for the symmetry-broken phase, and one for the
// topological phase. Bottom: This is a 1D plot of {Z}_R versus J'/J. The y-axis ranges from -1 to 1, and the
// x-axis ranges from 0 to 2.5. The points are coloured from blue to red, representing different phases. The
// trend shows that as J'/J increases, {Z}_R decreases gradually from 1 to -1.
#figure(image("imgs/SPT.png", width: 100.0%),
  caption: [
    Numerical experiments for classifying quantum phases in the bond-alternating XXZ model. (a) #smallcaps[Hamiltonian.] Illustration of the model --- a one-dimensional qubit chain, where the coefficient of $( X_i X_(i + 1) + Y_i Y_(i + 1) + delta Z_i Z_(i + 1) )$ alternates between $J$ and $J'$. (b) #smallcaps[Phase diagram.] The system's three distinct phases are characterized by the many-body topological invariant $tilde(Z)_R$ discussed in Refs.~@pollmann2012detection @elben2020many. Blue denotes $tilde(Z)_R = 1$, red denotes $tilde(Z)_R = - 1$, and gray denotes $tilde(Z)_R approx 0$. (c,~d) #smallcaps[Unsupervised phase classification.] Bottom panels: $tilde(Z)_R$ vs. $J' / J$ at cross sections (c) $delta = 0.5$ and (d) $delta = 3.0$ of the phase diagram. Top panels: visualization of the quantum states projected to two dimensions using the unsupervised ML ( nonlinear PCA with shadow kernel). In all panels, colors of the points indicate the value of $J' / J$, indicating that the two phases naturally cluster in the expressive feature space.
  ]
)
<fig:XXZ>



#emph[Distinguishing a topological phase from a trivial phase] --- We consider the task of distinguishing the toric code topological phase from the trivial phase in a system of $n = 200$ qubits. @fig:topophase\(a) illustrates the sampled topological and trivial states. We generate representatives of the nontrival topological phase by applying low-depth geometrically local random quantum circuits to Kitaev's toric code state @kitaev2003fault with code distance 10, and we generate representatives of the trivial phase by applying random circuits to a product state.


Randomized Pauli measurements are performed $T = 500$ times to convert the states to their classical shadows, and these classical shadows are mapped to feature vectors in the high-dimensional feature space using the feature map $phi.alt^(upright("(") thin upright("shadow") thin upright(")"))$. @fig:topophase\(b) displays a one-dimensional projection of the feature space using the unsupervised classical ML for various values of the circuit depth, indicating that the phases become harder to distinguish as the circuit depth increases. In @fig:topophase\(c), we show the classification accuracy of the unsupervised classical ML model. We also compare to training convolutional neural networks (CNN) that use measurement outcomes from the Pauli-$6$ POVM @carrasquilla2019reconstructing as input to learn an observable for classifying the phases. Since @prop:noobs establishes that no observable (even a global one) can classify topological phases, this CNN approach is doomed to fail. On the other hand, if the CNN takes classical shadow representations as input, then it can learn nonlinear functions and successfully classify the phases.


= OUTLOOK
<outlook>


We have rigorously established that classical machine learning (ML) algorithms, informed by data collected in physical experiments, can effectively address some quantum many-body problems. These results boost our hopes that classical ML trained on experimental data can solve practical problems in chemistry and materials science that would be too hard to solve using classical processing alone.


Our arguments build on the concept of a classical shadow derived from randomized Pauli measurements. We expect, though, that other succinct classical representations of quantum states could be exploited by classical ML with similarly powerful results. For example, some currently available quantum simulators are highly programmable, but lack the local control needed to perform arbitrary single-qubit Pauli measurements. Instead, after preparing a many-body quantum state of interest, one might switch rapidly to a different Hamiltonian and then allow the state to evolve for a short time before performing a computational basis measurement. How can we make use of that measurement data to predict properties reliably? Answering such questions, and thereby expanding the reach of near-term programmable quantum platforms, will be an important goal for future research @cotler2021emergent @hu2021hamiltonian.


Viewed from a broader perspective, by illustrating how experimental data can be exploited to make accurate predictions about features of quantum systems that have never been studied directly, our work exemplifies a potentially powerful methodology for advancing the physical sciences. With further theoretical developments, perhaps we can learn how to use experimental data that is already routinely available to accelerate the discovery of new chemical compounds and materials with remarkable properties that could benefit humanity.


// [figvision] imgs/Phase_acc.png
// (a) This panel contains two schematics. The top schematic shows a Toric code ground state on a sphere with
// lines and symbols representing a lattice structure, connected to a random circuit with lines, circles,
// squares, and crosses. The bottom schematic shows a product state as multiple vertical arrows, connected to
// another random circuit. Both schematics represent the generation of trivial or topological states through the
// application of local random quantum circuits. (b) This panel is a scatter plot. The x-axis represents circuit
// depth or code distance, ranging from 0.0 to 0.9. The y-axis represents the first principal component, ranging
// from -2.5 to 2.5. There are two series: Topological (red circles) and Trivial (blue diamonds). The plot shows
// the unsupervised phase classification of quantum states projected to one dimension, with points scattered
// across the plot indicating the distribution of states. (c) This panel is another scatter plot. The x-axis is
// the same as in panel (b), ranging from 0.0 to 0.9. The y-axis represents classification accuracy, ranging from
// 0.5 to 1.0. There are four series: CNN+Shadow (supervised) in blue stars, CNN (supervised) in purple circles,
// Shadow (unsupervised) in teal diamonds, and a black dashed line at y=0.5. The plot compares the classification
// accuracy of different methods for distinguishing between trivial and topological phases.
#figure(image("imgs/Phase_acc.png", width: 95.0%),
  caption: [
    Numerical experiments for distinguishing between trivial and topological phases. (a) #smallcaps[State generation.] Trivial or topological states are generated by applying local random quantum circuits of some circuit depth to a product state or exactly-solved topological state, respectively. (b) #smallcaps[Unsupervised phase classification.] visualization of the quantum states projected to one dimension using the unsupervised ML ( nonlinear PCA with shadow kernel), shown for varying circuit depth (divided by the "code distance" 10, which quantifies the depth at which the topological properties are washed out). The feature space is sufficiently expressive to resolve the phases for a small enough depth without training, with classification becoming more difficult as the depth increases. (c) #smallcaps[Classification accuracy] for three ML algorithms described in @subsec:numerics-classification.
  ]
)
<fig:topophase>



#heading(level: 2, numbering: none)[Acknowledgments:]
<acknowledgments>


The authors thank Nir Bar-Gill, Juan Carrasquilla, Sitan Chen, Yifan Chen, Andreas Elben, Matthew Fishman, Martin Fraas, Scott Glancy, Jeongwan Haah, Felix Kueng, Jarrod McClean, Spiros Michalakis, Jacob Taylor, Yuan Su, and Thomas Vidick for valuable input and inspiring discussions. HH thanks Andreas Elben for providing the code on bond-alternating XXZ model. The numerical simulations were performed on AWS EC2 computing infra-structure, using the software packages ITensors~@itensor and PastaQ~@pastaq. HH is supported by the J. Yang & Family Foundation. JP acknowledges funding from the U.S. Department of Energy Office of Science, Office of Advanced Scientific Computing Research, (DE-NA0003525, DE-SC0020290), and the National Science Foundation (PHY-1733907). The Institute for Quantum Information and Matter is an NSF Physics Frontiers Center. Contributions to this work by NIST, an agency of the US government, are not subject to US copyright. Any mention of commercial products does not indicate endorsement by NIST. VVA thanks Olga Albert, Halina and Ryhor Kandratsenia, as well as Tatyana and Thomas Albert for providing daycare support throughout this work.








#block[
#strong[Appendices: contents & navigation guide]

]





#strong[@sec:classical-shadows.~~#link(<sec:classical-shadows>)[Background on classical shadows]] #strong[]


#strong[@sec:relatedwork.~~#link(<sec:relatedwork>)[Related work]] #strong[]


#block[
#link(<sec:relatedwork1>)[Estimating ground state properties] $bullet$ #link(<sec:relatedwork2>)[Classifying quantum phases of matter] $bullet$ #link(<sec:relatedwork3>)[Classical representations of quantum systems]

]


#strong[@sec:neuralnetwork.~~#link(<sec:neuralnetwork>)[Neural networks with classical shadow for quantum many-body problems]] #strong[]


#block[
#link(<sec:neuralnetwork1>)[Predicting ground state representation] $bullet$ #link(<sec:neuralnetwork2>)[Classifying phases of matter]

]


#strong[@sec:numdetail.~~#link(<sec:numdetail>)[Details regarding numerical experiments]] #strong[]


#block[
#link(<sec:more-numer>)[Additional numerical experiments] $bullet$ #link(<sec:numdetail-groundstate>)[Ground state properties of the Rydberg atom chain] $bullet$ #link(<sec:numdetail-groundstate2>)[Ground state properties of the 2D antiferromagnetic Heisenberg model] $bullet$ #link(<sec:numdetail-phases>)[Classifying phases of the bond-alternating XXZ model] $bullet$ #link(<sec:numdetail-phases2>)[Distinguishing a topological phase from a trivial phase]

]


#strong[@sec:proofideaGSUPP.~~#link(<sec:proofideaGSUPP>)[Proof idea for the efficiency in predicting ground states]] #strong[]


#block[
#link(<sec:qubit-GSUPP>)[Main result] $bullet$ #link(<sec:generalize-GSUPP>)[Generalization to other systems and settings]

]


#strong[@sec:proofthmGSUPP.~~#link(<sec:proofthmGSUPP>)[Proof of efficiency for predicting ground states]] #strong[]


#block[
#link(<sec:overviewSCupGS>)[Overview for sample complexity upper bound] $bullet$ #link(<sec:truncGS>)[Controlling the truncation error] $bullet$ #link(<sec:MLTrun>)[Controlling generalization errors from using the training data] $bullet$ #link(<sec:runtimeGS>)[Computational time for training and prediction] $bullet$ #link(<sub:smoothness>)[Spectral gap implies smooth parametrizations]

]


#strong[@app:proofthmlowerbound.~~#link(<app:proofthmlowerbound>)[Sample complexity lower bound for predicting ground states]] #strong[]


#block[
#link(<sub:lowerboundsmooth-learning-problem>)[Learning problem formulation] $bullet$ #link(<sub:lowerboundsmooth-communication-protocol>)[Communication protocol] $bullet$ #link(<sub:lowerboundsmooth-analysis>)[Information-theoretic analysis]

]


#strong[@sec:proofhardnonML.~~#link(<sec:proofhardnonML>)[Computational hardness for non-ML algorithms to predict ground state properties]] #strong[]


#block[
#link(<sec:proofhardnonML1>)[NP-hardness for estimating one-body observables in the ground state of 2D Hamiltonians] $bullet$ #link(<sec:factoringH>)[Computational hardness for a class of Hamiltonians based on factoring]

]


#strong[@sec:no-nonlocal-obs.~~~#link(<sec:no-nonlocal-obs>)[No observable can classify topological phases]] #strong[]


#strong[@sec:proofthmPHASEC.~~~#link(<sec:proofthmPHASEC>)[Proof of efficiency for classifying phases of matter]] #strong[]


#block[
#link(<sec:trainSVM>)[Training support vector machines] $bullet$ #link(<sec:pred-SVM>)[Prediction using support vector machines] $bullet$ #link(<sub:shadow-kernel>)[Kernel functions for classical shadows] $bullet$ #link(<sec:phases-assumption>)[Physical assumptions about classifying quantum phases of matter] $bullet$ #link(<sec:train-shadowkernel>)[Training with shadow kernels] $bullet$ #link(<sec:predict-shadowkernel>)[Prediction based on shadow kernels]

]


#strong[@sec:tasaki.~~#link(<sec:tasaki>)[Classifying SPT phases with $O ( 2 )$ symmetry using a few-body observable]] #strong[]


#block[
#link(<sec:tasaki1>)[Symmetry-protected topological phases] $bullet$ #link(<sec:tasaki2>)[$O ( 2 )$-symmetric qutrit spin chains]

]


For those unfamiliar with the classical shadow formalism @huang2020predicting, Appendix #ref(<sec:classical-shadows>, supplement: none) provides a concise introduction and contains all the necessary information on classical shadows to follow this paper. Discussion of related literature on methods in many-body physics, in particular works for training machine learning models to solve quantum many-body problems, is given in Appendix~#ref(<sec:relatedwork>, supplement: none).


Readers interested in the numerical experiments can jump directly to Appendix~#ref(<sec:neuralnetwork>, supplement: none), which provides a detailed discussion on practical approaches for combining neural networks with classical shadows. The reader could then continue to Appendix #ref(<sec:numdetail>, supplement: none), which gives additional numerical experiments, details of numerical experiments, and example codes (in Python) for using the machine learning models.


The rest of the appendices are dedicated to providing a rigorous understanding in using classical machine learning models to solve quantum many-body problems.


==== Predicting ground states
<predicting-ground-states>
: We recommend that readers start with Appendix~#ref(<sec:proofideaGSUPP>, supplement: none), which provides the idea for why classical machine learning models can be trained to predict ground state representations of quantum systems. In Appendix~#ref(<sec:proofideaGSUPP>, supplement: none), we also provide the proof idea for generalizing to other settings (such as Fermionic systems, long-range interacting systems, etc). The detailed proof is given in Appendix~#ref(<sec:proofthmGSUPP>, supplement: none). In Appendix~#ref(<app:proofthmlowerbound>, supplement: none), we give a fundamental lower bound in the required data size for learning to predict ground state properties for general classes of Hamiltonians. In Appendix~#ref(<sec:proofhardnonML>, supplement: none), we show why non-ML algorithms cannot achieve a similar guarantee as ML algorithms in predicting ground state representations.


==== Classifying phases of matter
<classifying-phases-of-matter>
: The reader could begin with the basic proposition given in Appendix~#ref(<sec:no-nonlocal-obs>, supplement: none), which shows that no (local or global) observable $"tr" ( O rho )$ can be used to classify topological phases. This motivates the need to consider stronger machine learning models that can learn nonlinear functions in the quantum state $rho$. The readers could then proceed to Appendix~#ref(<sec:proofthmPHASEC>, supplement: none), which provides a general theory for establishing provable guarantees in training machine learning models based on classical shadows to classify quantum phases of matter. In Appendix~#ref(<sec:tasaki>, supplement: none), we briefly introduce symmetry-protected topological phases and prove that the proposed machine learning model can classify a particular subset of such phases.





= BACKGROUND ON CLASSICAL SHADOWS
<sec:classical-shadows>


The classical shadows formalism uses randomized (single-shot) measurements to predict many properties of an unknown quantum state $rho$ at once @huang2020predicting, see also @paini2019approximate @evans2019scalable. The underlying idea dates back to @Ohliger_2013 and also features prominently in @VanEnk2012 @Elben2018 @Vermersch2018. In particular, the classical shadows formalism comes with rigorous performance guarantees in terms of approximation accuracy, classical storage, as well as data processing. Here, we focus on randomized single-qubit Pauli measurements and repeat the following procedure a total of $T$ times: (i) prepare an independent copy of $rho$\; (ii) select $n$ single qubit Pauli measurements uniformly at random ($Z$, $X$ and $Y$ occur with probability $1 / 3$ each) and (iii), perform the associated measurement to obtain $n$ classical bits ($+ 1$ if we measure 'up' and $- 1$ if we measure 'down'). Subsequently, we store the associated post-measurement state


$ | s_1^(( t )) chevron.r ⊗ dots.h.c ⊗ | s_n^(( t )) chevron.r quad upright("with") quad | s_1^(( t )) chevron.r , dots.h , | s_n^(( t )) chevron.r in (| 0 chevron.r , | 1 chevron.r , | + chevron.r , | - chevron.r , | upright(i) + chevron.r , | upright(i) - chevron.r) subset bb(C)^2 $<eq:snapshot>


in classical memory. This is very cheap, because there are only six possibilities for each qubit. After $T$ repetitions, we obtain an entire collection of $n T$ single-qubit states that we arrange in a two-dimensional array:


$ S_T ( rho ) = {| s_i^(( t )) chevron.r : #h(0em) i in ( 1 , dots.h , n ) , t in ( 1 , dots.h , T )} in (| 0 chevron.r , | 1 chevron.r , | + chevron.r , | - chevron.r , | upright(i) + chevron.r , | upright(i) - chevron.r)^(n times T) $


The distribution of product states contains valuable information about the underlying $n$-qubit density matrix $rho$. In fact, we can use $S_T ( rho )$ to approximate $rho$ via


$ sigma_T ( rho ) = 1 / T sum_(t = 1)^T (3 | s_1^(( t )) chevron.r chevron.l s_1^(( t )) | - bb(I)) ⊗ dots.h.c ⊗ (3 | s_n^(( t )) chevron.r chevron.l s_n^(( t )) | - bb(I)) , $<eq:classical-shadow>


where $bb(I)$ denotes the identity matrix (here, a 2-by-2 identity). It is instructive to view this as the empirical average of $T$ independent and identically (#emph[iid]) random matrices. Each random matrix is an #emph[iid] copy of $sigma_1 ( rho ) = ( 3 | s_1 chevron.r chevron.l s_1 | - bb(I) ) ⊗ dots.h.c ⊗ ( 3 | s_n chevron.r chevron.l s_n | - bb(I) )$. Each tensor factor is guaranteed to have eigenvalues $lambda_(+) = 2$ and $lambda_(-) = - 1$. This ensures that $  $<eq:shadow-norm>


$ upright("tr") (sigma_1 ( rho )) = & upright("tr") (| s_1 chevron.r chevron.l s_1 | - bb(I)) dots.h.c upright("tr") (| s_n chevron.r chevron.l s_n | - bb(I)) = 1 quad upright("and")\
∥sigma_1 ( rho )∥_p = & ∥3 | s_1 chevron.r chevron.l s_1 | - bb(I)∥_p dots.h.c ∥3 | s_n chevron.r chevron.l s_n | - bb(I)∥_p = (| lambda_(+) |^p + | lambda_(-) |^p)^(n / p) = (2^p + 1^p)^(n / p) , $





regardless of the concrete realization (and the underlying quantum state $rho$).


The most relevant Schatten-$p$ norms are $parallel sigma_1 ( rho ) parallel_1 = 3^n$, $parallel sigma_1 ( rho ) parallel_2 = 5^(n / 2)$ and $parallel sigma_1 ( rho ) parallel_oo = 2^n$. Note, however, that the matrix $sigma_1 ( rho )$ is never positive semidefinite.


The random matrix $sigma_1 ( rho )$ is a highly structured tensor product that can assume a total of $6^n$ values. Each of them reflects the outcome of performing randomly selected single-qubit Pauli measurements on the $n$-qubit state $rho$. Let us denote these Pauli matrices by $W_1 , dots.h , W_n in (X , Y , Z)$ and let $o_1 , dots.h , o_n in {plus.minus 1}$ be the observed outcomes ($+ 1$ if we measure 'spin up' and $- 1$ if we measure 'spin down'). Elementary reformulations and Born's rule then imply


$ sigma_1 ( rho ) = 1 / 2 (bb(I) + 3 o_1 W_1) ⊗ dots.h.c ⊗ 1 / 2 (bb(I) + 3 o_n W_n) quad upright("with prob.") quad 1 / 3^n upright("tr") (1 / 2 ( bb(I) + o_1 W_1 ) ⊗ dots.h.c ⊗ 1 / 2 ( bb(I) + o_n W_n ) rho) . $


This construction ensures that $sigma_1 ( rho )$ exactly reproduces the underlying quantum state $rho$ in expectation. That is, if we average over all $3^n$ choices of Pauli measurements and the associated (single-shot) outcomes $o_i in {plus.minus 1}$, we obtain $  $


$ "𝔼"_(s_1 , dots.h , s_n) [sigma_1 ( rho )] & = "𝔼"_(s_1 , dots.h , s_n) [1 / 2 (bb(I) + 3 o_1 W_1) ⊗ dots.h.c ⊗ 1 / 2 (bb(I) + 3 o_n 3 W_n)]\
 & = sum_(W_1 , dots.h , W_n = X , Y , Z) sum_(o_1 , dots.h , o_n = plus.minus 1) 1 / 3^n upright("tr") (1 / 2 ( bb(I) + o_1 W_1 ) ⊗ dots.h.c ⊗ 1 / 2 ( bb(I) + o_n W_n ) rho)\
 & med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med med times 1 / 2 (bb(I) + o_1 3 W_1) ⊗ dots.h.c ⊗ 1 / 2 (bb(I) + o_n 3 W_n)\
 & = rho . $<eq:snapshot-expectation>






We refer to Ref.~@huang2020predicting for a more detailed derivation and context.


The classical shadow~@eq:classical-shadow attempts to approximate this expectation value by an empirical average over $T$ independent samples, much like Monte Carlo sampling approximates an integral. The accuracy of the approximation increases with $T$, but insisting on accurate approximations of the global state $rho$ is prohibitively expensive. Known fundamental lower bounds~@flammia2012quantum @haah2017sample state that classical shadows of exponential size (at least) $T = Omega (2^n / epsilon.alt^2)$ are required to $epsilon.alt$-approximate $rho$ in trace distance. This quickly becomes intractable in terms of both measurement budget, as well as classical storage and processing.


This bleak picture lightens up considerably if we restrict our attention to subsystem approximations. The classical shadow size required to accurately approximate #emph[all] reduced $r$-body density matrices scales exponentially in subsystem size $r$, but is independent of the total number of qubits $n$.


#thmbox("lemma", "Lemma")[


Fix $epsilon.alt , delta in ( 0 , 1 )$, a subsystem size $r lt.eq n$ and let $sigma_T ( rho )$ be a classical shadow~(@eq:classical-shadow) of an $n$-qubit quantum state $rho$ with size


$ T = ( 8 / 3 ) 12^r (r (log ( n ) + log ( 12 )) + log ( 1 / delta )) / epsilon.alt^2 = cal(O) (r 12^r log ( n / delta ) / epsilon.alt^2) . $


Then, with probability at least $1 - delta$,


$ | "tr"_(not A) ( sigma_(T) (rho) ) - "tr"_(not A)( rho ) |_(1) lt.eq epsilon quad "for all subsystems A" subset {1,…,n} w i t h s i z e |A|lt.eq r . $


] <lem:subsystem-approximation>


#block[
#emph[Proof.] Let us start by considering a fixed subsystem $A = ( i_1 , dots.h , i_r )$ comprised of (at most) $r$ qubits. Use linearity to exchange partial trace with expectation value to obtain $  $~◻

]


$  & "𝔼"_(s_(i_1)^(( t )) , dots.h , s_(i_r)^(( t ))) [( 3 | s_(i_1)^(( t )) chevron.r chevron.l s_(i_1)^(( t )) | - bb(I) ) ⊗ dots.h.c ⊗ ( 3 | s_(i_r)^(( t )) chevron.r chevron.l s_(i_r)^(( t )) | - bb(I) )]\
 & = upright("tr")_(not A) ("𝔼"_(s_1^(( t )) , dots.h , s_n^(( t ))) [( 3 | s_1^(( t )) chevron.r chevron.l s_1^(( t )) | - bb(I) ) ⊗ dots.h.c ⊗ ( 3 | s_n^(( t )) chevron.r chevron.l s_n^(( t )) | - bb(I) )])\
 & = upright("tr")_(not A) ( rho ) , $





according to Eq.~#ref(<eq:snapshot-expectation>, supplement: none).


In words, each reduced tensor product


is an independent random matrix that reproduces the $r$-qubit state $upright("tr")_(not A) ( rho )$ exactly in expectation.


Empirical averages of $T$ such independent and identically distributed (#emph[iid]) random matrices tend to concentrate sharply around this expectation value.


The matrix Bernstein inequality, see e.g.~@Tro12:User-Friendly, provides powerful tail bounds in terms of operator norm deviation. Let $X_1 , dots.h , X_T$ be #emph[iid] random $D$-dimensional matrices that obey $parallel X_t - "𝔼" X_t parallel_oo lt.eq R$ almost surely. Then, for $tilde(epsilon.alt) > 0$


$ upright("Pr") [∥1 / T sum_(t = 1)^T (X_t - "𝔼" X_t)∥_oo gt.eq tilde(epsilon.alt)] lt.eq 2 D exp (- frac(T tilde(epsilon.alt)^2 / 2, sigma^2 + R tilde(epsilon.alt) / 3)) quad upright("where") quad sigma^2 = ∥1 / T sum_t "𝔼" X_t^2∥_oo . $


Let us apply this tail bound to classical shadow concentration. We have $D lt.eq 2^r$ (at most $r$ qubits) and set $X_t = ( 3 | s_(i_1)^(( t )) chevron.r chevron.l s_(i_1)^(( t )) - bb(I) ) ⊗ dots.h.c ⊗ ( 3 | s_(i_r)^(( t )) chevron.r chevron.l s_(i_r)^(( t )) | - bb(I) )$, such that $"𝔼" X_t = upright("tr")_(not A) ( rho )$. Eq.~#ref(<eq:shadow-norm>, supplement: none) then implies $parallel X_t - "𝔼" X_t parallel_oo lt.eq parallel X_t parallel + parallel "𝔼" X_t parallel_oo lt.eq 2^r + 1 = : R$. Accurately bounding $sigma^2$ is somewhat more involved, and we turn to existing literature. A computation detailed in @guta2020fast[Appendix~C.3] yields $sigma^2 = 3^r$. We are now ready to apply the matrix Bernstein inequality. For $tilde(epsilon.alt) > 0$,


$ upright("Pr") [∥upright("tr")_(not A) (sigma_T ( rho )) - upright("tr")_(not A) ( rho )∥_oo gt.eq tilde(epsilon.alt)] lt.eq 2^(r + 1) exp (- frac(T tilde(epsilon.alt)^2 / 2, 3^r + ( 2^r + 1 ) tilde(epsilon.alt) / 3)) lt.eq 2^(r + 1) exp (- frac(3 T tilde(epsilon.alt)^2, 8 times 3^r)) , $


for $tilde(epsilon.alt) in ( 0 , 1 )$. This is a powerful concentration statement in operator norm. We can use the equivalence relation between trace- and operator norm, $parallel X parallel_oo lt.eq parallel X parallel_1 lt.eq D parallel X parallel_oo$, to obtain a tail bound for trace norm deviations:


$ upright("Pr") [∥upright("tr")_(not A) (sigma_T ( rho )) - upright("tr")_(not A) ( rho )∥_oo gt.eq epsilon.alt] lt.eq upright("Pr") [∥upright("tr")_(not A) (sigma_T ( rho )) - upright("tr")_(not A) ( rho )∥_1 gt.eq epsilon.alt / 2^r] lt.eq 2^(r + 1) exp (- frac(3 T epsilon.alt^2, 8 times 12^r)) . $


We see that, for a fixed subsystem $A = ( i_1 , dots.h , i_r )$, the probability of an $epsilon.alt$-deviation in trace distance is exponentially suppressed in the size $T$ of the classical shadow. A union bound allows us to extend this assertion to #emph[all] subsystems comprised of (at most) $r$ qubits: $  $


$ upright("Pr") [max_(A subset ( 1 , dots.h , n ) , | A | lt.eq r) ∥upright("tr")_(not A) (sigma_T ( rho )) - upright("tr")_(not A) ( rho )∥_1 gt.eq epsilon.alt] & lt.eq sum_(A subset ( 1 , dots.h , n ) , | A | lt.eq r) upright("Pr") [∥upright("tr")_(not A) (sigma_T ( rho )) - upright("tr")_(not A) ( rho )∥_1 gt.eq epsilon.alt]\
 & lt.eq n^r 2^(r + 1) exp (- frac(3 T epsilon.alt^2, 8 times 12^r)) . $





Setting $T = ( 8 / 3 ) 12^r (log ( n^r 12^r ) + log ( 1 / delta )) / epsilon.alt^2 = ( 8 / 3 ) 12^r (r (log ( n ) + log ( 12 )) + log ( 1 / delta )) / epsilon.alt^2$


ensures that this upper bound on failure probability does not exceed $delta$.






= RELATED WORK
<sec:relatedwork>


== Estimating ground state properties
<sec:relatedwork1>


Determining the ground state of a system governed by a known many-body Hamiltonian is a long-standing problem in quantum science. Despite having several well-established and practically successful algorithms at our disposal, we are typically faced with either a runtime that scales exponentially with system size, and/or a lack of rigorous performance guarantees. The literature is vast, and surveying it is beyond the scope of this article. Instead, we review a few families of established algorithms in order to put our work into proper context.


Density functional theory (DFT) has been a workhorse for determining properties of interacting electronic systems in quantum chemistry and solid-state physics. DFT recasts the problem of finding the many-body state with minimal energy into finding a few-body energy functional. While the "true" functional corresponding to the ground state is known to exist in theory~@HohenbergKohn @NobelKohn, determining it to polynomial accuracy in the number of electrons is QMA-hard @Schuch2009. Various efficient approximations to the true functional have seen much practical success, but they are difficult to justify rigorously (except so far for some special cases @Lewin2020). These limitations present an opportunity for ML approaches to be used instead of or to supplement DFT methods @Schleder2019 @moreno2020deep. In @moreno2020deep, they utilized the Hohenberg-Kohn theorem in DFT which implies the existence of a mapping from single-particle densities to correlation function. Then @moreno2020deep proposed to train deep learning models to approximately learn the mapping between correlation functions and the densities. The authors in @moreno2020deep found that across the phase boundary, the mapping becomes hard to learn. This empirical observation could be seen as a manifestation of the fact that @thm:mainFourier only holds when we do not consider the presence of phase transitions. However, our numerical experiments on Rydberg atoms suggest that ML models could still predict well when there are multiple phase boundaries. Understanding when predictions would be accurate in the presence of phase transitions is an interesting and important question to study further.


The family of algorithms known as Quantum Monte Carlo (QMC)~@CEPERLEY555 @SandvikSSE utilizes probabilistic sampling techniques to estimate observable properties at either finite or zero temperature. For ground states, expectation values can be obtained using an imaginary-time evolution projector or a high-power of the model Hamiltonian~@KaulQMC. The efficiency of QMC methods depends on the structure of the Hamiltonian, specifically on whether all of its off-diagonal matrix elements are negative (i.e.~it is #emph[stoquastic]~@BravyiStoquastic). In this case, the ground state wavefunction is real-valued and positive, and the algorithmic complexity of the QMC estimators scales polynomially with the number of particles. For non-stoquastic Hamiltonians, the QMC suffers from the so-called #emph[sign problem], which makes evaluation of statistical properties of the system NP-hard and renders QMC intractable for large systems or low temperatures~@TroyerSignProblem. It is important to note that, even for stoquastic Hamiltonians with polynomial computational complexity, the success of QMC simulations heavily relies on the existence of efficient sampling schemes (e.g. cluster updates) which are sufficiently ergodic, and leading to small auto-correlation time~@EvertzLoop. In general, it is not possible to prove the existence of such update algorithms, nor their ergodicity.


An alternative approach to solve for the ground state properties of a many-body Hamiltonian is based on the variational principle in quantum mechanics, which states that the expectation value of the energy on any valid wavefunction is always greater or equal than the ground state energy. It is then possible to design classical parametric representations of the many-body wavefunction, and update their parameters to minimize the corresponding energy estimator. A notable example is the density-matrix renormalization group~@DMRG1 @DMRG2 (DMRG). This algorithm can be interpreted as a variational optimization of a Matrix Product State (MPS)~@Garcia07 @Vestraete2008 @SCHOLLWOCK201196, which is a local decomposition of a wavefunction as a one-dimensional tensor network. These parametrized wavefunctions display area law of entanglement and exponentially-decaying correlations~@ORUS2014117, which lend themselves most effective for systems described by one-dimensional gapped Hamiltonians. Furthermore, a standout feature of DMRG is that modifications of the original procedure, such as rigorous renormalization group algorithms @arad2017rigorous, are guaranteed to find the ground state of one-dimensional geometrically-local gapped Hamiltonians in polynomial time @landau2015polynomial @arad2017rigorous @abrahamsen2020polynomialtime. In two spatial dimensions, MPS-based DMRG can still be applied to solve for ground states~@Stoudenmire12 @Wu2019 @Moore2020, though it suffers an exponential scaling in one of the two linear dimensions of the system. Projected entangled pair states (PEPS)~@Jordan2008 @Vanderstraeten2016 @Corboz2016, the two-dimensional generalization of MPSs, are instead a more suitable ansatz in this context. However, while improved algorithms for PEPS optimization are routinely put forward~@Zalatel2020 @Haghshenas2019 @Hyatt2019, the same level of performance achieved by DMRG in 1d systems is still out of reach.


Another class of variational wavefunctions that has recently received a lot of attention are #emph[neural-network quantum states]~@Carleo_2017. In this framework, a neural network is used as a parametric function approximator of a many-body wavefunction $psi_lambda ( sigma ) = chevron.l sigma | psi chevron.r$, where the classical state $sigma$ is interpreted as the neural-network input, and $lambda$ is a set of neural-network parameters (i.e. weights and biases). In a variational setting, these parameters are iteratively optimized to lower the total energy~@becca_sorella_2017, or additionally the energy variance. Neural-network quantum states have been explored in a variety of setups, including topological phases~@dassarma2017, Fermi-Hubbard models~@Nomura2017, molecular ground states~@choo_fermionicnqs2020, frustrated magnetism~@Ferrari2019, and more~@Glasser2018 @Choo2018 @rbm_su2 @morawetz2020 @Luo2021. The auto-regressive property of some types of neural networks (e.g. recurrent neural networks, transformers, etc.) has also been leveraged to improve convergence of variational Monte Carlo~@hibat2020recurrent. In contrast to tensor-network states, this class of wavefunctions can more easily display non-local correlations, allowing in principle to capture quantum states with higher entanglement~@Deng2017.


Another class of machine learning methods @gilmer2017neural @vargas2018extrapolating @schutt2019unifying @qiao2020orbnet @kawai2020predicting train neural networks to predict the ground state or excited state properties directly. The input to the neural network is a description of the Hamiltonian, and the output is a ground state property of interest. The training data is a set of different Hamiltonians (inputs) and their corresponding ground state properties (outputs). This class of ML methods is closest to the setting considered in this paper. Methods in this class lack rigorous guarantees, so it is not clear when such approaches could outperform non-ML algorithms. In one of our main contributions, given in @thm:mainFourier and @thm:hardnonML, we introduce an ML model that, when trained with experimental data, can accurately predict ground state representations better than any classical algorithm that does not learn from data. Our model is relatively basic, utilizing the well-known $l_2$-Dirichlet kernel, but it is already enough to establish a rigorous guarantee. Similarly determining when other ML models yield an advantage over non-ML algorithms is an interesting topic for future work.


== Classifying quantum phases of matter
<sec:relatedwork2>


Proposals for classifying quantum phases of matter abound. These include quantum neural networks @cong2019quantum, classical neural networks @carrasquilla2017nature @evert2017nature @neupeurt2017 @Beach2017 @Greplova_2020, or other classical machine learning models @leiwang2016 @Wetzel2017 @rodriguez2019identifying @che2020topological. Since these models do not come with rigorous guarantees, relying on them too much can lead one astray. For example, some deep neural networks can misclassify the original phase if the corresponding state is distorted by noise, even if the distortion is very slight @jiang2019vulnerability.


In this work, we provide rigorous machine learning approaches that are guaranteed to classify accurately under the specified conditions given in @thm:phaseclassification. We believe similar analyses can be performed on other machine learning models to understand their limitation and potential, which will be an important future direction. The ML model used in @rodriguez2019identifying, which is based on defining diffusion maps over classical spins systems, is the ML approach that seems most similar to that used in our work. Hence, it is very likely that the models considered in @rodriguez2019identifying can be rigorously analyzed via similar techniques. Neural network approaches for classifying phases of matter will be harder to analyze, but one should be able to study neural network with large hidden layers using the theory developed in this work and the theory of neural tangent kernels @jacot2018neural @neuraltangents2020.


== Classical representations of quantum systems
<sec:relatedwork3>


One of the most important ingredients in designing classical ML procedures for understanding quantum spin systems is the construction of efficient classical representations of the underlying quantum systems. The properties of the quantum system retained by the classical representation directly determine the set of functions the classical ML procedure can learn. The classical shadow formalism @huang2020predicting @paini2019approximate, developed by some of us and others and used throughout this work, is a versatile framework for this purpose. It has been extended to fermionic systems @zhao2021fermionic @hadfield2020measurements, suggesting that our ML approaches may be extendable as well. Classical shadows have also been shown to allow sample-efficient reconstruction of Hamiltonian from thermal states @anurag2021sample, although such an algorithm is not yet time efficient. However, classical shadows provide only one of many promising and actively studied approaches for efficient representation @cotler2020quantum @paini2019approximate @huang2020predicting @evans2019scalable @koh2020classical @chen2020robust @huang2021efficient.


While the curse of dimensionality prevents one from representing general quantum spin systems both exactly and efficiently, simplifying assumptions can lift the curse and drastically reduce both the overhead and complexity of representing and characterizing the system. A prime example is a classical system, whose Hamiltonian is diagonal in the computational basis. ML methods for such systems, such as those in Ref.~@rodriguez2019identifying (discussed above), do not require an additional quantum-to-classical compression. Another example, relevant to electronic material characterization, is the family of solid-state band insulators @topobook --- gapped two- and three-dimensional non-interacing fermionic systems with various crystalline symmetries. Their myriad topological phases can typically be characterized by data at a discrete set of high-symmetry points in the Brillouin zone @Bacry @Bradlyn2017 @Po2017 @Kruthoff2017 @Po2020 @Cano2021. The techniques developed here should pave the way for certifying accuracy of current ML methods for band insulator characterization (e.g., @Sun2018 @Ming2019 @Balabanov2021 @Scheurer2020 @Claussen2020 @Andrejevic2020 @Peano2021) as well as developing new ones.


= NEURAL NETWORKS WITH CLASSICAL SHADOW FOR QUANTUM MANY-BODY PROBLEMS
<sec:neuralnetwork>


Imposing inductive biases in the ML model is a common technique for boosting the prediction performance of ML models. One approach is to enhance the proposed ML algorithms with neural networks, such as convolutional or graph neural networks. These neural networks could better capture structure of the underlying function we are trying to learn and hence may require significantly less data than the very expressive ML model given in the main text. We leave the proof that neural network enhancements can lead to better prediction performance as a goal for future work.


There are multiple ways of combining classical shadows and neural networks. Here, we will only showcase one such approach by utilizing the theory of neural tangent kernels @jacot2018neural. Remarkably, this theory allows us to efficiently train various types of neural networks (convolutional/graph/etc.) with an infinite number of neurons in each hidden layer (#emph[infinite width]). As such, this line of work has gained a lot of attention @du2019graph @arora2019exact @neuraltangents2020 in recent years. In the limit of infinite width, one can analytically solve for the neural network after training on a set of data $( x_ell , y_ell )_(ell = 1)^N$, where $x_ell$ and $y_ell$ are vectors of some size. For example, consider training a neural network that takes in a vector $x$ and produces a vector $f_theta^(upright("NN")) ( x )$ through the following optimization problem using gradient descent,


$ min_(theta) sum_(ell = 1)^(N) || f^("NN")_(theta)(x_(ell)) - y_(ell)||_(2)^(2), $


where we begin on a randomly initialized $theta$. Note that due to the infinite number of neurons, $theta$ is a vector of infinite dimension. The trained neural network $f_(theta^(*))^(upright("NN")) ( x )$ can always be written in the following form


$ f_(theta^(*))^(upright("NN")) ( x ) = sum_(ell = 1)^N sum_(ell' = 1)^N k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x_ell ) ( K^(- 1) )_(ell ell') y_(ell') , $<eq:ntkfunc>


where $k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x' )$ is a function called the neural tangent kernel @jacot2018neural, and $K_(ell , ell') = k^(upright("(") thin upright("NTK") thin upright(")")) ( x_ell , x_(ell') )$ is the kernel matrix of the neural tangent kernel. One can see that the infinite-dimensional vector $theta^(*)$ does not appear on the right hand side of Eq.~#ref(<eq:ntkfunc>, supplement: none). And as long as we can efficiently evaluate the neural tangent kernel $k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x' )$, we can evaluate the infinite-dimensional neural network in polynomial time. This is the main contribution of @jacot2018neural, which enables one to efficiently train infinite-width neural networks. For a given neural network architecture, one can compute $k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x' )$ efficiently using open-source software, such as @neuraltangents2020. In Appendix~#ref(<sec:numdetail-groundstate>, supplement: none), we give the code for training infinite-width neural networks using the open-source software: Neural Tangents @neuraltangents2020.


== Predicting ground state representation
<sec:neuralnetwork1>


For the task of predicting ground state representation, we consider the training data to be


$ { x_ell arrow.r sigma_T ( rho ( x_ell ) ) }_(ell = 1)^N med , $


where $sigma_T ( rho ( x_ell ) )$ is the classical shadow representation of $rho ( x_ell )$ given in Eqs.~@eq:sigma-T-shadow and @eq:classical-shadow based on $T$ randomized Pauli measurements. Recall that $sigma_T ( rho ( x_ell ) )$ is a $2^n times 2^n$ matrix that reproduces $rho ( x_ell )$ in expectation over the randomized Pauli measurements. Suppose we now train an infinite-width neural network parameterized by $theta$ that takes in an input $x$ and produces an exponential-size matrix $sigma_theta^(upright("NN")) ( x )$, by solving the optimization problem


$ min_theta & quad sum_(ell = 1)^N ∥sigma_theta^(upright("NN")) ( x_ell ) - sigma_T ( rho ( x_ell ) )∥_F^2 . $


The squared Frobenius difference between two matrices is equal to the squared Euclidean norm of their vectorizations (flattenings). In turn, the theory of infinite-width neural networks @jacot2018neural shows that the trained neural network $sigma_(theta^(*))^(upright("NN")) ( x )$ could be written in the form


$ sigma_(theta^(*))^(upright("NN")) ( x ) = sum_(ell = 1)^N sum_(ell' = 1)^N k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x_ell ) ( K^(- 1) )_(ell ell') sigma_T ( rho ( x_(ell') ) ) . $<eq:nngroundstate>


The kernel function $k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x' )$ depends on the neural network architecture and could be calculated utilizing existing open-source software @neuraltangents2020. This also falls into the general form shown in the main text; see Eq.~#ref(<eq:sigma-x->, supplement: none). Hence, training an infinite-width neural networks to predict an exponentially large density matrix can be done efficiently on a classical computer. For a given neural network architecture, all one has to do is compute the kernel function $k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x' )$. Then the neural network optimized using the training data could be analytically solved as given in Eq.~#ref(<eq:nngroundstate>, supplement: none). To estimate a property on the predicted ground state using the neural network is as simple as evaluating


$ "tr" ( O sigma_(theta^(*))^(upright("NN")) ( x ) ) = sum_(ell = 1)^N sum_(ell' = 1)^N k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x_ell ) ( K^(- 1) )_(ell ell') "tr" ( O sigma_T ( rho ( x_(ell') ) ) ) , $


which can be done by first computing $"tr" ( O sigma_T ( rho ( x_ell ) ) ) , forall ell = 1 , dots.h , N$ and compute the linear interpolation.


== Classifying phases of matter
<sec:neuralnetwork2>


We want to learn how to classify two phases of $n$-qubit states. A fully classical training set would simply consist of $N$ labeled classical representations of quantum states ${ rho_ell arrow.r y_ell }_(ell = 1)^N$, where $y_ell = + 1$ ($- 1$) if $rho_ell$ belongs to phase $A$ ($B$). However, insisting on perfect knowledge of each $rho_ell$ is impractical for a variety of reasons. Instead, we assume that we have access to classical shadows of $rho_ell$. The raw data $S_T ( rho_ell )$ behind each classical shadow is a 2-dimensional array,


$ S_T ( rho_ell ) = {| s_i^(( t )) chevron.r : #h(0em) i in ( 1 , dots.h , n ) , t in ( 1 , dots.h , T )} quad upright("where") quad | s_i^(( t )) chevron.r in ( | 0 chevron.r , | 1 chevron.r , | + chevron.r , | - chevron.r , | upright(i) + chevron.r , | upright(i) - chevron.r ) . $<eq:snapshot-array>


In the main text, we propose to use this data to train a support vector machine based on the shadow kernel


$ k^(upright("(") thin upright("shadow") thin upright(")")) (S_T ( rho_ell ) , tilde(S)_T ( rho_(ell') )) = exp (tau / T^2 sum_(t , t' = 1)^T exp (gamma / n sum_(i = 1)^n upright("tr") (( 3 | s_i^(( t )) chevron.r chevron.l s_i^(( t )) | - bb(I) ) ( 3 | tilde(s)_i^(( t )) chevron.r chevron.l tilde(s)_i^(( t )) | - bb(I) )))) . $<eq:shadow-kernel-ml>


This specific choice of (deterministic) kernel function allows us to carry out a thorough theoretical analysis of the entire learning procedure; see Appendix~#ref(<sec:proofthmPHASEC>, supplement: none).


But there are other sensible kernels that may perform even better in practice. For instance, we could feed the two-dimensional data array~@eq:snapshot-array into a neural network architecture, e.g.~a convolutional neural network. In the limit of an infinite number of neurons in each hidden layer, this produces the neural tangent kernel $k^(upright("(") thin upright("NTK") thin upright(")")) (S_T ( rho_ell ) , tilde(S)_T ( rho_(ell') ))$ @jacot2018neural. This kernel is positive-semidefinite and should be viewed as a measure of similarity induced by the trained neural network. Mercer's theorem~@mercer1909functions allows us to make this intuition precise by reformulating the neural tangent kernel as a Gram matrix in feature space:


$ k^(upright("(") thin upright("NTK") thin upright(")")) (S_T ( rho_ell ) , tilde(S)_T ( rho_(ell') )) = ⟨phi.alt^(upright("(") thin upright("NTK") thin upright(")")) (S_T ( rho_ell )) , phi.alt^(upright("(") thin upright("NTK") thin upright(")")) (tilde(S)_T ( rho_(ell') ))⟩ med . $


Hence, any infinite-width neural network with input array $S_T ( rho )$ induces a feature map $phi.alt^(upright("(") thin upright("NTK") thin upright(")"))$ that can be used instead of the doubly-infinite feature map $phi.alt^(upright("(") thin upright("shadow") thin upright(")"))$ (@eq:featureshadow) that is associated with the shadow kernel~@eq:shadow-kernel-ml.


= DETAILS REGARDING NUMERICAL EXPERIMENTS
<sec:numdetail>


In this appendix, we provide additional numerical experiments as well as more details about the numerical experiments described in the main text.


== Additional numerical experiments
<sec:more-numer>


// [figvision] imgs/rydberg_Z_all.png
// Panel a: This is a plot showing the expectation value of Z (⟨Z⟩) for a 1D array of 51 Rydberg atoms. The
// x-axis ranges from 0 to 51 and represents the Rydberg atoms. The y-axis ranges from -1 to 1 and represents
// ⟨Z⟩. There are two series: one with black diamond markers and orange lines, labeled "Classical ML", and
// another with solid orange lines. The trend shows that the Classical ML predictions (markers) follow the exact
// values (solid lines) but with some deviation, indicating a relatively good prediction. Panel b: This plot also
// shows ⟨Z⟩ for the same 1D array. The axes and ranges are the same as in panel a. The series include black star
// markers with blue lines for Classical ML, and gray star markers with blue lines for exact values from DMRG.
// The trend indicates that the Classical ML predictions are close to the exact values, with a slight deviation
// at the beginning. Panel c: This plot shows ⟨Z⟩ with the same axes and ranges. The series include black cross
// markers with red lines for Classical ML, and solid red lines for exact values. The trend shows that the
// Classical ML predictions match the exact values very well, with almost no visible deviation. Panel d: This
// plot shows ⟨Z⟩ for the nearest training data. The x-axis and y-axis have the same ranges as before. The series
#figure(image("imgs/rydberg_Z_all.png", width: 100%),
  placement: top,
  caption: [Numerical experiment for predicting ground state properties (Pauli-$Z$ in each atom) in a 1D Rydberg atom system with 51 atoms. We use the classical ML to predict the ground state properties at the three testing points. Also shown are “predictions” obtained from the training data nearest to the testing points. The markers denote predicted values, while the solid lines denote exact values obtained from DMRG.]
) <fig:rydberg-Z>
// [figvision] imgs/rydberg_X_all.png
// Panel a: This is a plot showing the predicted ground state properties of a 1D Rydberg atom system. The x-axis
// represents the Rydberg atoms in a 1D array, ranging from 0 to 51. The y-axis represents the value of <X>,
// ranging from -1 to 1. The plot shows a series of black diamond markers representing the predicted values from
// Classical ML, with no line connecting them. The trend shows an initial value of approximately 0.9 at atom 0,
// then oscillating around 0 with decreasing amplitude. Panel b: This plot shows another predicted ground state
// property. The x-axis is the same, representing Rydberg atoms from 0 to 51. The y-axis is also the same,
// representing <X> from -1 to 1. The series consists of black star markers representing Classical ML
// predictions. The trend starts at about -0.9, then fluctuates around -0.2 with minimal oscillation. Panel c:
// This plot shows a third predicted ground state property. The axes are the same as panels a and b. The series
// consists of black cross markers representing Classical ML predictions, with some red diamond markers
// overlaying them. The trend starts near 0, then alternates around 0 with small deviations. Panel d: This plot
#figure(image("imgs/rydberg_X_all.png", width: 100%),
  placement: top,
  caption: [Numerical experiment for predicting ground state properties (Pauli-$X$ in each atom) in a 1D Rydberg atom system with 51 atoms. We use the classical ML to predict the ground state properties at the three testing points. Also shown are “predictions” obtained from the training data nearest to the testing points. The markers denote predicted values, while the solid lines denote exact values obtained from DMRG.]
) <fig:rydberg-X>
// [figvision] imgs/rydberg_Spline_all.png
// Panel a: This is a plot showing interpolated and exact values for the Z expectation value. The x-axis ranges
// from 0 to 50 and represents Rydberg atoms in a 1D array. The y-axis ranges from -1 to 1 and represents the Z
// expectation value. There are two series: one with a peach-colored solid line and diamond markers, representing
// spline interpolation, and another with a blue solid line and no markers, representing exact values from DMRG.
// The trend shows oscillations around 0. Panel b: This is a plot showing interpolated and exact values for the Z
// expectation value. The x-axis ranges from 0 to 50 and represents Rydberg atoms in a 1D array. The y-axis
// ranges from -1 to 1 and represents the Z expectation value. There are two series: one with a blue solid line
// and star markers, representing spline interpolation, and another with a gray solid line and no markers,
// representing exact values from DMRG. The trend shows a mostly flat line around 0.5. Panel c: This is a plot
// showing interpolated and exact values for the Z expectation value. The x-axis ranges from 0 to 50 and
// represents Rydberg atoms in a 1D array. The y-axis ranges from -1 to 1 and represents the Z expectation value.
// There are two series: one with a red solid line and cross markers, representing spline interpolation, and
// another with a gray solid line and no markers, representing exact values from DMRG. The trend shows
// oscillations around 0. Panel d: This is a plot showing interpolated and exact values for the X expectation
// value. The x-axis ranges from 0 to 50 and represents Rydberg atoms in a 1D array. The y-axis ranges from -1 to
// 1 and represents the X expectation value. There are two series: one with a peach-colored solid line and
// diamond markers, representing spline interpolation, and another with a blue solid line and no markers,
// representing exact values from DMRG. The trend shows oscillations that dampen around 0. Panel e: This is a
#figure(image("imgs/rydberg_Spline_all.png", width: 100%),
  placement: top,
  caption: [“Predictions” obtained by performing bivariate B-spline interpolation using the training data. The markers denote interpolated values, while the solid lines denote exact values obtained from DMRG.]
) <fig:rydberg-spl>



// [figvision] imgs/Phase_gram_matrix.png
// (a) The panel shows a heatmap representing the kernel matrix for SPT/trivial phases. The x and y axes
// represent the index of the states, with no explicit units given, and range from 1 to approximately 50. The
// colorbar represents the inner product, ranging from 0.80 to 1.00. The SPT (red) and Trivial (blue) states are
// labeled. The top-left and bottom-right quadrants show high inner products for same-phase states, while the
// off-diagonal quadrants show lower inner products for different-phase states. The trend shows that SPT and
// Trivial phases are distinguishable. (b) This is a 2D scatter plot visualizing the infinite-dimensional feature
// space. The x-axis represents the 1st principal component, ranging from -0.4 to 0.4, and the y-axis represents
// the 2nd principal component, also ranging from -0.4 to 0.4. The SPT (red) and Trivial (blue) states are
// plotted as points. The SPT states cluster around (-0.2, 0), while the Trivial states cluster around (0.2, 0).
// The trend indicates that the two phases can be separated in this 2D representation. (c) The panel shows a
// heatmap representing the kernel matrix for Topological/Trivial phases. The x and y axes represent the index of
// the states, with no explicit units given, and range from 1 to approximately 50. The colorbar represents the
// inner product, ranging from 0.94 to 1.00. The Topological (red) and Trivial (blue) states are labeled. The
// top-right and bottom-left quadrants show high inner products for same-phase states, while the off-diagonal
// quadrants show lower inner products for different-phase states. The trend shows that Topological and Trivial
// phases are distinguishable. (d) This is a 2D scatter plot visualizing the infinite-dimensional feature space.
// The x-axis represents the 1st principal component, ranging from -0.1 to 0.1, and the y-axis represents the 2nd
// principal component, ranging from -0.15 to 0.15. The Topological (red) and Trivial (blue) states are plotted
// as points. The Topological states cluster around (-0.05, 0), while the Trivial states cluster around (0.05,
// -0.05). The trend indicates that the two phases can be separated in this 2D representation.
#figure(image("imgs/Phase_gram_matrix.png", width: 82.0%),
  caption: [
    Numerical experiments for distinguishing trivial and topological phases. Trivial or topological states are generated by applying low-depth local random quantum circuits to a product state or exactly solved topological state respectively. (a) #smallcaps[Kernel matrix for SPT/trivial phases] The exactly solved topological state is the cluster state. The $( i , j )$-entry denotes the inner product of the $i$-th and $j$-th feature vectors in the infinite-dimensional feature space defined by the classical shadow representation. To the left, states from the two phases are randomly mixed. To the right, the two phases are ordered. (b) #smallcaps[Kernel matrix for topologically-ordered/trivial phases.] The exactly solved topological state is the toric code ground state.
  ]
)
<fig:kernelmatrix>



#emph[Rydberg atom chain] --- In the main text, we have provided partial prediction outcomes for a one-dimensional chain of $n = 51$ Rydberg atoms; see @fig:rydberg. Here, we supply predictions of expectation values of Pauli operators $Z_i$ and $X_i$ on all $51$ atoms at the testing points marked in @fig:rydberg\(b). These are shown in Figure~#ref(<fig:rydberg-Z>, supplement: none) and Figure~#ref(<fig:rydberg-X>, supplement: none), respectively. These extend the more restricted presentation in the main text to all qubits. In @fig:rydberg-spl, we show a different baseline considering bivariate B-spline interpolation from the training data.


#emph[Distinguishing an SPT phase from a trivial phase] --- We consider a one-dimensional chain of $n = 50$ qubits with $Z_2 times Z_2$ symmetry. The 1D cluster state is in the nontrivial SPT phase. We generate other representatives of the nontrivial SPT phase by applying symmetric depth-$3$ geometrically local random quantum circuits to the cluster state, and we generate representatives of the trivial phase by applying symmetric depth-$3$ random circuits to a product state.


Randomized Pauli measurements are performed $T = 500$ times to convert the states to their classical shadows, and these classical shadows are mapped to feature vectors in the infinite-dimensional feature space using the feature map $phi.alt^(upright("(") thin upright("shadow") thin upright(")"))$ (@eq:featureshadow). In @fig:kernelmatrix\(a), inner products of feature vectors (matrix elements of the shadow kernel) are displayed. @fig:kernelmatrix\(b) shows the feature vectors projected onto a two-dimensional subspace using #emph[nonlinear] principal component analysis (PCA) based on the shadow kernel $k^(upright("(") thin upright("shadow") thin upright(")"))$. Both figures show that feature vectors representing distinct phases can be distinguished easily. Correspondingly, the classical ML efficiently learns how to classify phases accurately, even if the training data is unlabeled.


#emph[Distinguishing a topologically-ordered phase from a trivial phase] --- We consider the task of distinguishing the toric code @kitaev2003fault topologically-ordered phase from the trivial phase in a system of $n = 200$ qubits. We generate other representatives of the topologically-ordered phase by applying two-dimensional depth-$3$ geometrically local random quantum circuits to the toric code state, and we generate representatives of the trivial phase by applying two-dimensional depth-$3$ random circuits to a product state.


Randomized Pauli measurements are performed $T = 500$ times to convert the states to their classical shadows, and these classical shadows are mapped to feature vectors in the infinite-dimensional feature space using the feature map $phi.alt^(upright("(") thin upright("shadow") thin upright(")"))$. In @fig:kernelmatrix\(c, d), inner products of feature vectors (matrix elements of the shadow kernel) and the projection of feature space data onto the two-dimensional subspace spanned by the largest principal components is shown. Once more, one can clearly see


that feature vectors representing distinct phases can be distinguished easily. Correspondingly, the classical ML efficiently learns how to classify phases accurately, even if the training data is unlabeled.


== Ground state properties of the Rydberg atom chain
<sec:numdetail-groundstate>


Our first example is a one-dimensional chain of $n = 51$ Rydberg atoms~@Fendley2004 @browaeys_many-body_2020 @bernien2017probing. Each atom can be in either its ground state or a highly excited Rydberg state. Such systems can effectively be regarded as a qubit, where the basis state $| 0 chevron.r$ is the ground state $| g chevron.r$ and the basis state $| 1 chevron.r$ is the Rydberg state $| r chevron.r$. The Hamiltonian of the atomic chain is


$ H = Omega / 2 sum_i X_i - Delta sum_i N_i + Omega sum_(i < j) (frac(R_b, a | i - j |))^6 N_i N_j med , $


where $Omega$ is the (fixed) Rabi frequency, $Delta$ is the laser detuning, $N_i$ is the Rydberg occupation number operator, $a$ is the separations of the atoms, and $R_b$ is the so called Rydberg blockade radius. For large and negative $Delta$, the ground state of $H$ is a vacuum state, where all atoms are in the ground state $| g chevron.r$. In contrast, for large and positive $Delta$, different broken-symmetry ground states can be engineered depending on the value of $R_b$.


Approximations of the exact ground states of the Rydberg chain were found using the density-matrix renormalization group (DMRG) based on matrix product states (MPS). Starting from a random MPS with bond dimension $chi = 10$, we variationally optimize the MPS using a singular value decomposition (SVD) cutoff of $10^(- 9)$. We perform a number of DMRG sweeps until the change in energy is below $epsilon.alt = 10^(- 6)$. Upon convergence, we perform randomized Pauli measurements simply by performing local rotations into the corresponding Pauli bases, and sampling the resulting state~@FerrisSampling.


In @fig:rydberg\(b), the color in the phase diagram corresponds to the phase obtained by two order parameters for characterizing $Z_2$ and $Z_3$ order. For $Z_2$ order, where the atoms are in $| r g r g r g dots.h chevron.r$ or $| g r g r g r dots.h chevron.r$, we consider the order parameter,


$ O_(Z_2) = frac(1, n - 1) sum_(i = 1)^(n - 1) (| r_i g_(i + 1) chevron.r chevron.l r_i g_(i + 1) | + | g_i r_(i + 1) chevron.r chevron.l g_i r_(i + 1) |) . $


For $Z_3$ order, where the atoms are in $| r g g r g g dots.h chevron.r$ or $| g r g g r g dots.h chevron.r$ or $| g g r g g r dots.h chevron.r$, we consider the order parameter,


$ O_(Z_3) = frac(1, n - 2) sum_(i = 1)^(n - 2) (| r_i g_(i + 1) g_(i + 2) chevron.r chevron.l r_i g_(i + 1) g_(i + 2) | + | g_i r_(i + 1) g_(i + 2) chevron.r chevron.l g_i r_(i + 1) g_(i + 2) | + | g_i g_(i + 1) r_(i + 2) chevron.r chevron.l g_i g_(i + 1) r_(i + 2) |) . $


We estimate the two order parameters of the ground state $rho$. First we check which order parameter ($O_(Z_2)$ or $O_(Z_3)$) yields a larger expectation value. Then, we check if that expectation value is larger than the threshold value $0.8$. If $O_(Z_2) > O_(Z_3)$ and $O_(Z_2) > 0.8$, we associate the state with the $Z_2$-order phase (red color). Else if $O_(Z_3) > O_(Z_2)$ and $O_(Z_3) > 0.8$, we say that the state is in the $Z_3$-order phase (vanilla color). If neither of these conditions is satisfied (both expectation values are less than $0.8$), we assign the disordered phase (blue color) to this state.


For the Rydberg atom experiment, the input parameter vector $x$ is two-dimensional. We first normalize the values to lie within a square $[ - 1 , 1 ]^2$. Then we consider classical machine learning models given by


$ hat(sigma)_N ( x ) = sum_(ell = 1)^N kappa ( x , x_ell ) sigma_T ( x_ell ) = sum_(ell = 1)^N underbrace((sum_(ell' = 1)^N k ( x , x_(ell') ) ( K + lambda I )_(ell' ell)^(- 1)), kappa ( x , x_ell )) sigma_T ( x_ell ) , $


where $lambda > 0$ is a parameter to regularize the model when $K$ is not invertible, $sigma_T ( x_ell )$ is shorthand for $sigma_T (rho_ell)$ and denotes the classical shadow representation of the ground state $rho_ell = rho ( x_ell )$ under $T$ randomized Pauli measurements. Moreover, $K_(i j) = k ( x_i , x_j )$ is the kernel matrix, $k ( x , x' )$ is a kernel function, and $kappa ( x , x_ell )$ is a function that depends on the kernel function, the kernel matrix $K$, and $lambda$. We consider a set of different regularization parameters,


$ lambda in ( 0.0125 , 0.025 , 0.05 , 0.125 , 0.25 , 0.5 , 1.0 , 2.0 , 4.0 , 8.0 ) , $


and we also consider a set of different kernel functions $k ( x , x' ) = tilde(k) ( x , x' ) / sqrt(tilde(k) ( x , x ) tilde(k) ( x' , x' ))$, where $  $


$ tilde(k)(x, x') & = exp(-gamma || x - x'||_(2)^(2)), & quad "(Gaussian kernel)", \
tilde(k)(x, x') & = sum_(k_(1) = -3)^(3) sum_(k_(2) = -3)^(3) cos(pi (k_(1) (x_(1) - x_(1)') + k_(2) (x_(2) - x_(2)') ) ), & quad "(Dirichlet kernel)", \
tilde(k)(x, x') & = k^("(NTK)")(x, x'), & quad "(Neural tangent kernel)" . $ <eq:numer-dirichlet-kernel>





The hyperparameter $gamma > 0$ in the Gaussian kernel is chosen to be equal to $N^2 / sum_(i=1)^N sum_(j=1)^N norm(x_i - x_j)_2^2$, the inverse of the average distance between $x_i$ and $x_j$.


We consider the neural tangent kernel $k^(upright("(") thin upright("NTK") thin upright(")")) ( x , x' )$ @jacot2018neural @neuraltangents2020 that is equivalent to an infinite-width feed-forward neural network with $2 , 3 , 4 , 5$ hidden layers and that uses the rectified linear unit (ReLU) as the activation function. Computing the neural tangent kernel can be implemented easily using the open-source software Neural Tangents @neuraltangents2020.


Suppose that the input data ${ x_ell }_(ell = 1)^N$ is stored in a


showstringspaces=false




 !numpy!


array of size


$N times m$, denoted as


language=Python, basicstyle=,


morekeywords=self, Add keywords here keywordstyle=, emph=MyClass,\_\_init\_\_, Custom highlighting


emphstyle=, Custom highlighting style stringstyle=, frame=tb, Any extra options here showstringspaces=false




 !dataX!


in the following


code. We can use then use following code


to generate the neural tangent kernel matrix. The imported package


language=Python, basicstyle=, morekeywords=self, Add keywords here keywordstyle=, emph=MyClass,\_\_init\_\_, Custom highlighting emphstyle=, Custom highlighting style


stringstyle=, frame=tb, Any extra options here showstringspaces=false




 !neural\_tangents!


can be downloaded from


#link("https://github.com/google/neural-tangents").


#block[
import jax import numpy as np from neural\_tangents import stax

]


init\_fn, apply\_fn, kernel\_fn = stax.serial( stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(1) ) kernel\_NN2 = kernel\_fn(dataX, dataX, 'ntk')


init\_fn, apply\_fn, kernel\_fn = stax.serial( stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(1) ) kernel\_NN3 = kernel\_fn(dataX, dataX, 'ntk')


init\_fn, apply\_fn, kernel\_fn = stax.serial( stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(1) ) kernel\_NN4 = kernel\_fn(dataX, dataX, 'ntk')


init\_fn, apply\_fn, kernel\_fn = stax.serial( stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(32), stax.Relu(), stax.Dense(1) ) kernel\_NN5 = kernel\_fn(dataX, dataX, 'ntk')


list\_kernel\_NN = \[kernel\_NN2, kernel\_NN3, kernel\_NN4, kernel\_NN5\]


\# Normalization of the kernel matrix for r in range(len(list\_kernel\_NN)): for i in range(len(list\_kernel\_NN\[r\])): for j in range(len(list\_kernel\_NN\[r\])):


list\_kernel\_NN\[r\]\[i\]\[j\] /= (list\_kernel\_NN\[r\]\[i\]\[i\] ~


\* list\_kernel\_NN\[r\]\[j\]\[j\]) \*\* 0.5






In order to predict the expectation value $"tr" ( O hat(sigma)_N ( x ) )$ of an observable $O$ for a new ground state


$hat(sigma)_N ( x )$, we utilize the following property of expectation values,


$ "tr" ( O hat(sigma)_N ( x ) ) = sum_(ell = 1)^N kappa ( x , x_ell ) "tr" ( O sigma_T ( x_ell ) ) . $


Hence, we first compute $"tr" ( O sigma_T ( x_ell ) )$, which can be done efficiently for $r$-body observables that factorize nicely into tensor products. Indeed, an $O = O_(i_1) ⊗ dots.h ⊗ O_(i_r)$ ensures


$ "tr" ( O sigma_T ( x_ell ) ) = 1 / T sum_(t = 1)^T "tr" (O sigma_1^(( t )) ( x_ell ) ⊗ dots.h ⊗ sigma_n^(( t )) ( x_ell )) = 1 / T sum_(t = 1)^T "tr" (O_(i_1) sigma_(i_1)^(( t )) ( x_ell )) dots.h "tr" (O_(i_r) sigma_(i_r)^(( t )) ( x_ell )) , $


and the right hand side can be computed with $cal(O) ( T n )$ arithmetic operations. Then, we can compute $"tr" ( O hat(sigma)_N ( x ) )$ by extrapolating $"tr" ( O sigma_T ( x_ell ) )$ using $kappa ( x , x_ell )$. We utilize scikit-learn, a Python package @scikit-learn, for the training of these machine learning models.


Due to the different classical ML models one could consider (corresponding to different regularization parameters $lambda$ and kernel functions $k ( x , x' )$), we have to perform model selection to find an appropriate ML model. Typically, the prediction performance will be quite sensitive to these parameters, so one has to select them carefully. To evaluate the ML models, we consider $100$ different points $x in [ - 1 , 1 ]^2$ in parameter space. Among these $100$ points, we select $N = 20$ to be training data. These are the circled points in @fig:rydberg\(b). For each property we would like to predict, we choose one of the the three kernels and the different values of $lambda$ such that the prediction error is minimized on a validation set containing $80 - 3$ inputs of $x$. The validation set is disjoint from the $20$ training points and the $3$ testing points for evaluating the prediction performances (special markers in @fig:rydberg\(a)). Their purpose is to perform model selection. Finally, we test on the three input $x$'s shown by the special markers (cross, diamond and star) in @fig:rydberg\(b).


We found that for each property we would like to predict, the prediction performance for different classical ML model varies moderately. When we have sufficiently large training data size $N$, most choices of $lambda$ and the kernel function should yield good prediction performance. However, we are using a very small number of training data in our experiments, hence the choice of these options becomes more important. In particular, the best choice of $lambda$ can differ quite significantly over the different properties we would like to predict.


// [figvision] imgs/rydberg_scaling.png
// Panel a: This is a line plot showing the root mean squared error (RMSE) against training size (N). The y-axis
// ranges from 0.20 to 0.32 and the x-axis from 5 to 30. There are three series: Dirichlet (solid green line with
// circles), Gaussian (dashed orange line with crosses), and Neural (dotted blue line with squares). Error bars
// are shown for each data point. As training size increases, RMSE decreases for all series, with Dirichlet
// having the highest RMSE and Neural the lowest. Panel b: This is a line plot showing RMSE against shadow size
// (T) on a log scale. The y-axis ranges from 0.19 to 0.25 and the x-axis from 10 to 10^2. The same three series
// are shown as in panel a, with the same line styles, symbols, and error bars. As shadow size increases, RMSE
// decreases for Dirichlet but remains relatively constant for Gaussian and Neural, which have similar RMSE
// values.
#figure(image("imgs/rydberg_scaling.png", width: 90.0%),
  caption: [
    Numerical experiment for predicting ground state properties (Pauli-$X$ and $Z$ in each atom) in a 1D Rydberg atom system with 51 atoms under different hyperparameters. #smallcaps[\(Left)] The prediction error (root-mean-square error) over different training sizes $N$ with a fixed number $T = 10$ of randomized Pauli measurements, also referred to as the shadow size. #smallcaps[\(Right)] The prediction error over different shadow sizes $T$ with a fixed training data size $N = 31$.
  ]
)
<fig:rydberg-scaling>



For completeness, we include a set of experiments where we vary the training data size $N$ or the classical shadow size $T$, where by "shadow size" we mean the number of randomized Pauli measurements used to approximate each state. The result in given in @fig:rydberg-scaling. For this set of experiments, we consider a fixed set of $70$ validation points in the phase space. Recall that we are using the ML model to predict ground state properties. Here, we consider the properties to be the expectation values of single-site Pauli-$X$ and Pauli-$Z$ operators. Because there are a total of $51$ atoms, there are a total of $51 times 2 = 102$ properties. For each property, we randomly draw $10$ different points in the phase space (not in the training set or the validation set). Therefore, the test set is of size $1020$, where each instance in the test set corresponds to a property of a point in the phase space. The prediction error is given by the root-mean-square error over the $1020$ instances in the test set. We can see that as training set size $N$ increases, the prediction becomes better. However, we see that as the training size increases, the slope of the prediction error (RMSE) over $N$ flattens. This is expected from the theorem we established showing that $N = m^(cal(O) ( 1 / epsilon.alt ))$, where $N$ is the training set size, $m$ is the number of parameters, and $epsilon.alt$ is the prediction error. While the theorem only provides an upper bound on $N$, if we assume the upper bound is saturated, then we can use elementary calculus to derive


$ frac(d epsilon.alt, d N) upright(" is proportional to ") - frac(epsilon.alt^2, N log ( m )) . $


Hence, the analysis is compatible with the observation that the slope of RMSE over $N$ flattens as $N$ becomes larger.






While we proved a rigorous result using the Dirichlet kernel, other commonly used ML models may yield a better prediction performance in practice. Proving rigorous prediction guarantees and understanding the limitations and strengths for other more commonly used ML models are important future directions.


== Ground state properties of the 2D antiferromagnetic Heisenberg model
<sec:numdetail-groundstate2>


Our next example is the two-dimensional antiferromagnetic Heisenberg model. Spin-$1 / 2$ particles (i.e. qubits) occupy sites on a square lattice, and for each pair $( i j )$ of neighboring sites the Hamiltonian contains a term $J_(i j) (X_i X_j + Y_i Y_j + Z_i Z_j)$ where the couplings ${ J_(i j) }$ are uniformly sampled from the interval $[ 0 , 2 ]$. The parameter $x$ is a list of all $J_(i j)$ couplings; hence in this case the dimension of the parameter space is $m = O ( n )$, where $n$ is the number of qubits. The Hamiltonian $H ( x )$ on a $5 times 5$ lattice is shown in @fig:heisenberg\(a). The exact ground state was found using DMRG. Analogously to the Rydberg atoms experiments, we fixed the SVD cutoff to $10^(- 8)$ and stopped the DMRG runs when the difference in energy was below $10^(- 4)$.


The classical ML models we considered are the same as the Rydberg atom chain experiment. The only difference is that we slightly modify the Dirichlet kernel (#ref(<eq:numer-dirichlet-kernel>, supplement: none)) to


$ k ( x , x' ) = sum_(i eq.not j) sum_(k_i = - 3)^3 sum_(k_j = - 3)^3 cos (pi ( k_i ( x_i - x'_i ) + k_j ( x_j - x'_j ) )) , quad upright("(Dirichlet kernel)") . $


We trained the classical ML model using a training set containing $N = 90$ randomly chosen values of the parameter $x = { J_(i j) }$. Then, for each property we would like to predict, we find the top-performing ML model setting (out of all $lambda$ parameters and kernel functions $k ( x , x' )$) on a validation set containing $100$ parameters $x$ distinct from the training set. Finally, we test on $10$ newly sampled parameters $x$ to estimate the prediction error. @fig:heisenberg\(b) shows the prediction outcome from one of the input parameter $x$. @fig:heisenberg\(c) shows the RMSE from all $10$ input parameters.


// [figvision] imgs/Heisenberg_scaling.png
// The figure has two panels, a and b. Panel a is a line plot showing the relationship between training size (N)
// and RMSE. The x-axis ranges from 10 to 90 and the y-axis ranges from 0.06 to 0.12. There are three series:
// Dirichlet (green solid line with circles), Gaussian (orange dashed line with x's), and Neural (blue dotted
// line with squares). Each series has vertical error bars. The trend shows that as training size increases, RMSE
// decreases for all series, with the Neural series having the lowest RMSE at larger training sizes. Panel b is
// also a line plot showing the relationship between shadow size (T) and RMSE. The x-axis is on a log scale,
// ranging from 10^1 to 10^2, and the y-axis ranges from 0.06 to 0.09. The same three series are shown as in
// panel a, with the same line styles, symbols, and colors. The trend shows that as shadow size increases, RMSE
// decreases for all series, with the Gaussian series having the lowest RMSE at larger shadow sizes.
#figure(image("imgs/Heisenberg_scaling.png", width: 90.0%),
  caption: [
    Numerical experiment for predicting ground state properties (two-point correlation functions) in a 2D antiferromagnetic Heisenberg model with $5 times 5$ spins under different hyperparameters. #smallcaps[\(Left)] The predict error (root-mean-square error) over different training size $N$ with a fixed number of randomized Pauli measurements $T = 10$, also referred to as the shadow size. #smallcaps[\(Right)] The prediction error (root-mean-square error) over different shadow size $T$ with a fixed training data size $N = 90$.
  ]
)
<fig:Heisenberg-scaling>



Similar to the Rydberg atom experiment, the best-performing ML model setting differs across the properties we would like to predict. The three kernels perform similarly at larger training data size $N$ and larger number of randomized Pauli measurements $T$. But neural networks and Gaussian kernel methods tend to perform better in most cases. The best choice of $lambda$ differs substantially across the different properties: there is no single choice of $lambda$ that performs uniformly better than the other choices.


To showcase these effects, we also include a set of experiments where we vary the training data size $N$ or the classical shadow size $T$, that is, the number of randomized Pauli measurements used to approximate each state. The numerical results are summarized in @fig:Heisenberg-scaling. For this set of experiments, we consider fixed sets of $100$ validation points. For this set of experiments, we consider a fixed set of $70$ validation points in the phase space. Recall that we are using the ML model to predict ground state properties. Here, we consider the properties to be the two-point correlation functions over every pair of the $25$ spins. This results in a total of $25 times 25 = 625$ properties. For each property, we randomly draw $10$ testing points in the $m = cal(O) ( n )$ dimensional parameter space (not in the training set or the validation set). Therefore, the test set is of size $6250$, where each instance in the test set corresponds to a property of a point in the parameter space. The prediction error is given by the root-mean-square error over the $6250$ instances in the test set.


The results resemble what was found in the Rydberg atom experiments, but with one notable difference --- in the Rydberg experiments, but not for the 2D antiferromagnet, the Dirichlet kernel has the best performance for the largest shadow size $T$ we considered. This may be because the dimension $m$ of the parameter space is much lower in the Rydberg case.







== Classifying phases of the bond-alternating XXZ model
<sec:numdetail-phases>


To illustrate our classical ML for classifying quantum phases of matter, we consider the bond-alternating XXZ model with $n = 300$ spin-$1 / 2$ particles (i.e.~qubits). The Hamiltonian is given by


$ sum_(i : upright("odd")) J ( X_i X_(i + 1) + Y_i Y_(i + 1) + delta Z_i Z_(i + 1) ) + sum_(i : upright("even")) J' ( X_i X_(i + 1) + Y_i Y_(i + 1) + delta Z_i Z_(i + 1) ) , $


and encompasses the bond-alternating Heisenberg model ($delta = 1$), as well as the bosonic version of the Su-Schrieffer-Heeger model @su1979solitons ($delta = 0$). The phase diagram in @fig:XXZ\(b) is obtained by evaluating the partial reflection many-body topological invariant @pollmann2012detection @elben2020many.


It is given by


$ tilde(cal(Z))_(cal(R)) = cal(Z)_(cal(R)) / sqrt([ "tr" ( rho_(I_1)^2 ) + "tr" ( rho_(I_2)^2 ) ] / 2) , quad upright("where") quad cal(Z)_(cal(R)) = "tr" ( rho_(I_1 union I_2) cal(R)_(I_1 union I_2) ) , $


and we consider $I_1$ with $6$ spins: the $145$-th spin to the $150$-th spin. Likewise, we fix $I_2$ to also contain $6$ spins: the $151$-th spin to the $156$-th spin. Hence, the union $I_1 union I_2$ contains $12$ spins. The symbols $rho_(I_1) , rho_(I_2)$ and $rho_(I_1 union I_2)$ denote the reduced density matrices associated with each local region. The reflection operator $cal(R)_(I_1 union I_2)$ acts on the local region $I_1 union I_2$ and is given by


$ cal(R)_(I_1 union I_2) | s_1 , dots.h , s_(| I_1 union I_2 |) chevron.r = | s_(| I_1 union I_2 |) , dots.h , s_1 chevron.r , quad forall s_1 , dots.h , s_(| I_1 union I_2 |) in ( 0 , 1 ) . $


The partial reflection many body-topological invariant can resolve three phases: trivial ($tilde(cal(Z))_(cal(R)) = + 1$), symmetry-protected topological (SPT) ($tilde(cal(Z))_(cal(R)) = - 1$) and symmetry broken ($tilde(cal(Z))_(cal(R)) = 0$). In @fig:XXZ\(b), we use the colors blue (trivial), red (SPT) and gray (symmetry broken) to visualize these different types of phases.


For each value of $J' / J$ and $delta$ considered, we construct the exact ground state using DMRG, and find its classical shadow by performing randomized single-qubit Pauli measurements a total of $T = 500$ times. To simulate this experiment, we follow the same setting for DMRG used in @elben2020many. We limit the maximum number of sweeps to $100$ and set the DMRG cutoff to $10^(- 9)$. We initialize the state to be the Néel state $| 0101 dots.h chevron.r$. To pin one of the degenerate ground state in the symmetry broken phase, we include a penalty term given by $0.1 J Z_1$ in the Hamiltonian.


After obtaining the classical shadow representation $S_T ( rho_ell )$ for each quantum state $rho_ell$, we compute the kernel matrix $K in bb(R)^(N times N)$, where each entry is given by the shadow kernel $k^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho_ell ) , S_T ( rho_(ell') ) )$. Recall that the shadow kernel is defined as


$ k^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho ) , S_T ( tilde(rho) ) ) = exp (1 / T^2 sum_(t , t' = 1)^T exp (1 / n sum_(i = 1)^n "tr" (sigma_i^(( t )) tilde(sigma)_i^(( t' ))))) , thin thin upright("where") thin thin sigma_i^(( t )) = 3 | s_i^(( t )) chevron.r chevron.l s_i^(( t )) | - bb(I) , $


and the classical shadow representation is given by


$ S_T ( rho ) = {| s_i^(( t )) chevron.r : #h(0em) i in (1 , dots.h , n) , #h(0em) t in (1 , dots.h , T)} , quad upright("where") quad | s_i^(( t )) chevron.r in ( | 0 chevron.r , | 1 chevron.r , | + chevron.r , | - chevron.r , | upright(i) + chevron.r , | upright(i) - chevron.r ) med . $


Care should be taken when computing diagonal elements of the kernel matrix $K$. The problem is that for $rho = tilde(rho)$ and $t = t'$, we necessarily have $upright("tr") (sigma_i^(( t )) tilde(sigma)_i^(( t ))) = 5$ for all $1 lt.eq i lt.eq n$. And the double exponential will amplify this already substantial contribution enormously. We found that counteracting this blow-up improves the numerical stability of the kernel method substantially. When $ell = ell'$, when we compute $k^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho_ell ) , S_T ( rho_ell ) )$, we sum over $t eq.not t'$ instead of all $t , t'$. In particular, when $rho = tilde(rho)$, we consider a slight modification to the kernel definition,


$ k^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho ) , S_T ( rho ) ) = exp (frac(1, T ( T - 1 )) sum_(t eq.not t') exp (1 / n sum_(i = 1)^n "tr" (sigma_i^(( t )) sigma_i^(( t' ))))) , $


This modification also seems to slightly improve the classification performance.


After evaluating the kernel matrix $K$, we renormalize the entries to obtain the standardized kernel matrix


$ overline(K)_(ell ell') = K_(ell ell') / sqrt(K_(ell ell) K_(ell' ell')) quad upright("for") quad ell , ell' in (1 , dots.h , N) . $


Subsequently, we perform kernel principal component analysis (PCA) on $overline(K)$. The implementation we used for kernel PCA is based on scikit-learn @sklearn_api. The output of kernel PCA is a list of low-dimensional vectors (the dimension can be chosen arbitrarily, but we choose two dimensions for this experiment). Each low-dimensional vector corresponds to a quantum state. In @fig:XXZ\(c, d), we can see that the low-dimensional vectors are clustered into different quantum phases of matter.


#emph[Distinguishing an SPT phase from a trivial phase] --- We consider a one-dimensional chain of $n = 50$ qubits with $Z_2 times Z_2$ symmetry. The 1D cluster state is in the nontrivial SPT phase. We generate other representatives of the nontrivial SPT phase by applying symmetric low-depth geometrically local random quantum circuits to the cluster state, and we generate representatives of the trivial phase by applying symmetric random circuits to a product state. We simulate the application of symmetric low-depth geometrically local random quantum circuits to the cluster state through matrix product states (MPS). Each circuit layer consists of patterns of random two-qubit gates acting on next-to-nearest neighbors sites. We generate the random gates in a block-sparse structure in the parity symmetry sectors. This choice, together with the choice of connectivity, guarantees that the $Z_2 times Z_2$ symmetry is conserved during the circuit evolution.


Randomized Pauli measurements are performed $T = 500$ times to convert the states to their classical shadows. We perform kernel PCA to find low-dimensional representation for the quantum states using exactly the same method as the experiment on bond-alternating XXZ model.


== Distinguishing a topological phase from a trivial phase
<sec:numdetail-phases2>


We consider the task of distinguishing the toric code topological phase from the trivial phase in a system of $n = 200$ qubits. Kitaev's toric code state @kitaev2003fault is in the nontrivial topologically-ordered phase, while a product state represents the trivial phase. To populate both phases, we apply low-depth geometrically local random Clifford circuits~@aaronson2004improved to Kitaev's toric code state @kitaev2003fault with code distance 10, and we generate representatives of the trivial phase by applying random Clifford circuits to a product state. We utilize Clifford circuits to ensure efficient simulation of in total $n = 200$ qubits (and with a depth up to $9$) by means of the Gottesman-Knill theorem. We again perform kernel PCA to find low-dimensional representations for the quantum states using exactly the same method as the experiment on bond-alternating XXZ model. This is used to generate the plot in @fig:topophase\(b) for a one-dimensional projection of the feature space, as well as the plot in @fig:kernelmatrix\(d) for a two-dimensional projection.


For the unsupervised ML model shown in @fig:topophase\(c), we consider a combination of kernel PCA and randomized projections @pmlr-v23-karnin12. First we perform kernel PCA to map the data to a six-dimensional subspace of the infinite-dimensional feature space. Then we repeat the following procedure $500$ times. We select a one-dimensional subspace uniformly at random in the six-dimensional subspace. We project all the quantum states to the one-dimensional subspace. Then, we find the center point (according to median instead of mean) to split up the quantum states into two phases. We also record the sum of the absolute values from all points to the center point in the one-dimensional subspace. Finally, we consider the classification obtained from the random one-dimensional projection that results in the largest sum of the absolute values.


For the convolutional neural network (CNN) approach shown in @fig:topophase\(c), we consider the following CNN built from Keras @chollet2015keras.


#block[
import tensorflow as tf from tensorflow.keras import datasets, layers, models

]


model = models.Sequential() model.add(layers.Conv2D(32, (2, 2), activation='relu', padding='same', input\_shape=(2\*L, L, 6))) model.add(layers.MaxPooling2D((2, 2))) model.add(layers.Conv2D(32, (2, 2), activation='relu', padding='same'))


model.add(layers.MaxPooling2D((2, 2))) model.add(layers.Conv2D(32, (2, 2), activation='relu', padding='same'))


model.add(layers.Flatten()) model.add(layers.Dense(32, activation='relu'))


model.add(layers.Dense(2))






In the above code, $L$ is the code distance for the toric code and is equal to $10$ in this experiment (recall that toric code ground state has $n = 2 L^2$ qubits). This CNN model is supervised and requires a training data with a corresponding label for indicating which phase the training data point is in. We first perform the Pauli-$6$ POVM on each qubit @carrasquilla2019reconstructing to transform the quantum state into a array of size $n$ where each entry has six outcomes. We perform one-hot encoding to yield a classical vector of size $6 n$, where each entry in the classical vector is either $0$ or $1$. Because the toric code ground state is two-dimensional ($2 L times L$), we restructure the classical vector into a three-dimensional tensor of size $2 L times L times 6$. The first two dimensions corresponds to the spatial dimension of the toric code ground state. The last dimension corresponds to the one-hot encoded vector for the six-outcome POVM. We then train the above model using the Adam optimizer @kingma2014adam with the categorical cross entropy as the loss function. The code is given below.


#block[
model.compile(optimizer='adam', loss=tf.keras.losses.SparseCategoricalCrossentropy(from\_logits=True), metrics=\['accuracy'\])

]


We train the convolutional neural network using $100$ training points (half are topologically-ordered states, and the other half are trivial states). Then we use a validation set of $100$ points to perform early stopping. This is because the longer we train, the more likely the neural network is going to overfit. Hence, it is a good practice to perform model selection by choosing which model to use at different time points (during the training process). We choose the model that performs the best on the validation set. Then we test the classification accuracy (the percentage that the prediction of the phases is correct) on a testing set consisting of $100$ points.


The performance of the above ML model is not substantially different from random guessing. Hence, we also consider a very simple CNN enhanced with classical shadow under $T = 500$ randomized Pauli measurements. In particular, we compute the local reduced density matrix using the classical shadow. Then for each qubit, we represent it with the local reduced density matrix. For simplicity, we consider the $i$-th qubit to be represented by a vector of size $16$, which includes the $2$-body reduced density matrix for the subsystem consisting of the $i$-th and the $i + 1$-th qubit. Hence, each quantum state is now represented by a classical vector of dimension $2 L^2 times 16$. We reshape the classical vector into a three-dimensional tensor of size $2 L times L times 16$. The classical vector is feed into the convolutional neural network structured as follows. We also apply the Adam optimizer @kingma2014adam with the categorical cross entropy as the loss function. The evaluation process is exactly the same as the CNN approach based on the Pauli-$6$ POVM.


#block[
import tensorflow as tf from tensorflow.keras import datasets, layers, models

]


model = models.Sequential() model.add(layers.Conv2D(16, (1, 1), activation='relu',~padding='same', input\_shape=(2\*L, L, 16))) model.add(layers.MaxPooling2D((2, 2))) model.add(layers.Conv2D(16, (2, 2), activation='relu',~padding='same')) model.add(layers.MaxPooling2D((2, 2))) model.add(layers.Conv2D(16, (2, 2), activation='relu',~padding='same')) model.add(layers.MaxPooling2D((2, 2))) model.add(layers.Flatten()) model.add(layers.Dense(32, activation='relu')) model.add(layers.Dense(2))


model.compile(optimizer='adam', loss=tf.keras.losses.SparseCategoricalCrossentropy(


from\_logits=True),


metrics=\['accuracy'\])






= PROOF IDEA FOR THE EFFICIENCY IN PREDICTING GROUND STATES
<sec:proofideaGSUPP>


== Main result
<sec:qubit-GSUPP>


In order to illustrate the proof of @thm:mainFourier, let us begin by looking at a simpler task: training a machine learning model to predict a specified ground state property instead of the classical representation of the ground state. Consider the property $"tr" ( O rho )$, where $rho$ is the ground state and $O$ is a local observable. In this simpler task, we consider the training data to be


$ ( x_1 arrow.r "tr" ( O rho ( x_1 ) ) , quad dots.h , quad x_N arrow.r "tr" ( O rho ( x_N ) ) ) , $


where $x_ell in [ - 1 , 1 ]^m$ is a classical description of the Hamiltonian $H ( x_ell )$ and $rho ( x_ell )$ is the ground state of $H ( x )$. Intuitively, in a quantum phase of matter, the ground state property $"tr" ( O rho ( x ) )$ changes smoothly as a function of the input parameter $x$. The smoothness condition can be rigorously established as an upper bound on the average magnitude of the gradient of $"tr" ( O rho ( x ) )$ using quasi-adiabatic evolution @hastings2005quasiadiabatic @bachmann2012automorphic, assuming that the spectral gap of $H ( x )$ is bounded below by a nonzero constant throughout the parameter space. The upper bound on the average gradient magnitude enables us to design a simple classical ML model based on an $l_2$-Dirichlet kernel for generalizing from the training set to a new input $x in [- 1 , 1]^m$:


$ hat(O)_(N)(x) = frac(1, N) sum_(ell=1)^(N) kappa(x, x_(ell)) "tr"(O rho(x_(ell))) thin thin thin "with" thin thin thin kappa(x, x_(ell)) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) cos(pi k ⋯ (x - x_(ell))) in bb(R) . $


The $l_2$-Dirichlet kernel is often used in the study of high-dimensional Fourier series @weisz2012summability and the proposed ML model is equivalent to learning a truncated Fourier series to approximate the function $"tr" ( O rho ( x ) )$, where the parameter $Lambda$ is a cutoff on the wavenumber $k$ that depends on the upper bound on the gradient of $"tr" ( O rho ( x ) )$. Using statistical analysis, one can guarantee that $"𝔼"_x | hat(O)_N ( x ) - "tr" ( O rho ( x ) ) |^2 lt.eq epsilon.alt$ as long as the amount of training data $N = m^(cal(O) ( 1 / epsilon.alt ))$ where our big-$cal(O)$ notation is with respect to the $m arrow.r oo$ limit. Hence, we can achieve a small #emph[constant] prediction error with an amount of training data and computational time that are both polynomial in the number $m$ of input parameters. The training is efficient because the number of modes needed for the truncated Fourier series to provide an accurate approximation to $"tr" ( O rho )$ scales polynomially with $m$.


The key to the statistical analysis is to bound the model complexity of the above machine learning model. In particular, the model complexity depends on the number of wave vectors we consider in the $l_2$-Dirichlet kernel. The more wave vectors $k$ we include, the higher the model complexity; and we would have to use more data to train the ML model to achieve good generalization performance. Furthermore, one could show that the amount of data is proportional to the number of wave vectors we consider. In order to achieve a prediction error $"𝔼"_x | hat(O)_N ( x ) - "tr" ( O rho ( x ) ) |^2 lt.eq epsilon.alt$, we would need to select $Lambda$ to be of order $sqrt(1 / epsilon.alt)$. Hence, the number of wave vectors is proportional to the number of lattice points in an $m$-dimensional $l_2$ ball of radius $Lambda$. The volume of an $m$-dimensional $l_2$ ball with radius $Lambda$ is proportional to $Lambda^m = ( 1 / epsilon.alt )^(m / 2)$. If the number of lattices points is proportional to the volume, then this would imply an exponential scaling in the number of parameters $m$. However, through a proper combinatorial analysis, we show that the number of lattices points is actually proportional to $m^(cal(O) ( Lambda^2 )) = m^(cal(O) ( 1 / epsilon.alt ))$, which is only polynomial in the number of parameters $m$.


We can build on this idea to address the task of predicting ground state representations. Now instead of predicting $"tr" ( O rho )$ for a new input $x$, the goal is to predict the classical shadow of the ground state $rho ( x )$. We consider the training data to be ${ x_ell arrow.r sigma_1 ( rho ( x_ell ) ) }_(ell = 1)^N$, where $sigma_1 ( rho ( x_ell ) )$ is the classical shadow representation of $rho ( x_ell )$ obtained from just a #emph[single] randomized Pauli measurement of the state (the $T = 1$ case of Eq.~#ref(<eq:sigma-T-shadow>, supplement: none)). Following the same approach as outlined above for the case of predicting a single property, the predicted ground state representation is now given by


$ hat(sigma)_(N)(x) = frac(1, N) sum_(ell = 1)^(N) kappa(x, x_(ell)) sigma_(1)(rho(x_(ell))) thin thin thin "with" thin thin thin kappa(x, x_(ell)) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) cos(pi k ⋯ (x - x_(ell))) in bb(R) . $


One can then guarantee that this representation accurately predicts expectation values for a wide range of observables.


The fact that only a single snapshot $sigma_1$ per parameter point is required for our protocol may be surprising. However, since the snapshots depends on the parameters, sampling over training data indirectly samples over different snapshots, and is thus sufficient for a reasonable estimate of properties of the phase. The estimate can of course be further improved if multiple snapshots are used for each parameter point, and we leave proving such improved bounds as an exciting goal for future work.


== Generalization to other systems and settings
<sec:generalize-GSUPP>


In this subsection, we discuss how one could generalize the proof of @thm:mainFourier to various different scenarios.


=== Prediction based on other quantum measurements
<prediction-based-on-other-quantum-measurements>


Throughout this work, we considered classical shadows based on randomized Pauli measurements @huang2020predicting. However, it may be difficult to perform randomized Pauli measurements in some experimental systems. @thm:mainFourier can be directly generalized to other kinds of measurement procedures. Consider a restricted setting where the experimentalist can only obtain training data of the form


$ {x_ell arrow.r "tr" ( O rho ( x_ell ) )}_(ell = 1)^N , $


for a single observable $O$ (that can be written as a sum of local observables). In this case, the classical ML model can no longer predict a classical representation of $rho ( x )$ for a new $x$. Nevertheless, the classical ML model can still predict $"tr" ( O rho ( x ) )$ accurately for a new $x$ by following the proof sketch in Appendix~#ref(<sec:qubit-GSUPP>, supplement: none).


More generally, suppose the experimentalist can construct some classical representation of the ground state $rho ( x_ell )$ through the available measurements, such as classical shadows based on another random unitary ensemble @hu2021hamiltonian, or simply a list of properties of $rho ( x_ell )$. And suppose that the classical representation allows us to predict the expectation values of observables $O_1 , O_2 , dots.h , O_M$ in the ground state $rho ( x_ell )$. Then for a new $x$, the classical ML model can predict $"tr" ( O_i rho ( x ) )$ accurately for $i = 1 , dots.h , M$.


=== A variable number of parameters
<a-variable-number-of-parameters>


So far, we have considered the input vector $x$ to be of a fixed dimension $m$. Here we briefly discuss how to generalize @thm:mainFourier to a setting where the input is not a fixed dimensional vector. We can think of the input as $xi = ( m , x )$, where $m in bb(N)$ is a discrete variable specifying the number of parameters, and $x in bb(R)^m$ is an $m$-dimensional vector with continuous entries. The number of parameters $m$ may range from $m_(upright("min"))$ to $m_(upright("max"))$. We consider a class of Hamiltonians $H ( xi ) = H ( ( m , x ) )$ that depends on both the discrete parameter $m$ and the continuous vector $x$. For example, we may have


$ m & = 1 : & H ( ( m , x ) ) & = sum_(i = 1)^n x_1 ( X_i X_(i + 1) + Y_i Y_(i + 1) ) ,\
m & = 2 : & H ( ( m , x ) ) & = sum_(i = 1)^n x_1 ( X_i X_(i + 1) + Y_i Y_(i + 1) ) + x_2 ( Z_i Z_(i + 1) ) , $


where $x_1 , x_2$ denote the first and second entry of the vector $x$. In order the train the ML model, we can consider training data to be of the form


$ { xi_ell arrow.r sigma_T ( rho ( xi_ell ) ) }_(ell = 1)^N , $


where $rho ( xi_ell )$ is the ground state of the Hamiltonian $H ( xi_ell )$ (and $xi_ell = ( m_ell , x_ell )$). In this most general case, we can now simply train a distinct ML model for each $m in [ m_(upright("min")) , m_(upright("max")) ]$. Using this direct method, we only need a training data size $N$ that is $( m_(upright("max")) - m_(upright("min")) + 1 )$ times larger than the training data size when $m$ is fixed.


=== Systems with long-range interactions
<systems-with-long-range-interactions>


For simplicity, the proof for our main theorem (@thm:mainFourier) focuses on Hamiltonians that can be written as a sum of geometrically local terms,


$ H ( x ) = sum_j h_j ( x ) , $


where $h_j ( x )$ acts on a constant number of constituents that are contained in a ball of constant size in a finite-dimensional space. Our proof can be generalized to some physical systems where $h_j ( x )$ acts on constituents that are geometrically non-local. The main condition we must impose is that the evolution under the Hamiltonian $H ( x )$ in the ground state $rho ( x )$ has a bounded speed of information spreading. In the study of quantum many-body systems~@chen2019finite @kuwahara2020strictly @tran2020hierarchy this assumption is described as a #emph[linear light cone], meaning that if a perturbation is applied at a point $P$ at time zero, then the effects of that perturbation at a later time $t$ are mostly confined to a region centered at $P$ with radius $v t$\; here $v > 0$ is called the Lieb-Robinson velocity.


To be more precise, consider two few-body operators, $O_A$ acting on a set of constituents $A$, and $O_B$ acting on a set of constituents $B$\; the sets $A$ and $B$ need not be geometrically local. We denote by $d ( O_A , O_B )$ the minimum Euclidean distance between constituents in $A$ and constituents in $B$. Recall that in the Heisenberg picture, operators evolve according to $O ( t ) = upright(e)^(i t H ( x )) O upright(e)^(- i t H ( x ))$, where $H ( x )$ is the Hamiltonian. We require that the expectation value in the ground state $rho ( x )$ of the commutator of $O_A$ with $O_B ( t )$ is highly suppressed when $d ( O_A , O_B )$ is small compared to $v t$, i.e.,


$ | "tr"( [O_(A), O_(B)(t) ] rho(x) ) | lt.eq frac(c |t|^(beta), max(0, d(O_(A), O_(B)) - v |t|)^(alpha)) || O_(A)||_(infinity) || O_(B)||_(infinity), $ <eq:long-range-decay>


where $c$ is a constant, and $alpha > beta > 0$ are constants that determine the decay,


Such Lieb-Robinson bounds were proven for geometrically local Hamiltonians decades ago, but linear light cones in physical systems with non-local interactions had not been studied until comparatively recently @chen2019finite @kuwahara2020strictly @tran2020hierarchy. It has now been established that, for many long-range interacting systems, Eq.~#ref(<eq:long-range-decay>, supplement: none) applies, where $alpha$ is sufficiently large compared to $beta$ for our arguments to apply.


Specifically, in the proof given in Appendix~#ref(<sec:proofthmGSUPP>, supplement: none), we can replace Eq.~#ref(<eq:uppslope>, supplement: none) by


$ | "tr" ( [ O , D_(hat(u)) ( x ) ] rho ( x ) ) | & lt.eq sum_i integral_(- oo)^oo W_gamma ( t ) sum_j lr(|"tr" ([O_i , upright(e)^(upright(i) t H ( x )) frac(partial h_j, partial hat(u)) ( x ) upright(e)^(- upright(i) t H ( x ))] rho ( x ))|) upright(d) t , $<eq:uppslope-alt>


and also replace the Lieb-Robinson bound in Eq.~#ref(<eq:LRbound>, supplement: none) by the bound in Eq.~#ref(<eq:long-range-decay>, supplement: none). When $alpha$ is sufficiently large compared to $beta$ in Eq.~#ref(<eq:long-range-decay>, supplement: none), we can guarantee that the right hand side of Eq.~#ref(<eq:uppslope-alt>, supplement: none) is upper bounded by


$ "const" times sum_(i) || O_(i)||_(infinity), $


using an analysis similar to that given in Appendix~#ref(<sub:smoothness>, supplement: none). After establishing such an upper bound on $| "tr" ( [ O , D_(hat(u)) ( x ) ] rho ( x ) ) |$, we can follow exactly the same proof given in the other sections in Appendix~#ref(<sec:proofthmGSUPP>, supplement: none) to show that the classical ML model can accurately predict the classical representation of the ground state for long-range interacting systems with a similar guarantee as @thm:mainFourier, assuming that the Lieb-Robinson velocity $v$ is bounded above by a constant.


=== Fermionic systems
<fermionic-systems>


We can also generalize the proof of @thm:mainFourier to fermionic systems, such as those arising in studies of electronic structure; see for example @helgaker2014molecular. We consider second quantization, also known as the occupation number representation, and use the abstract Fock space to represent the Hamiltonians of fermionic systems. Given a system of $n$ spin orbitals, the Fock space is a $2^n$-dimensional space spanned by $| c_0 , c_1 , dots.h , c_(n - 1) chevron.r$, where $c_j = 1$ indicates that mode $j$ is occupied and $c_j = 0$ indicates that mode $j$ is unoccupied. A vector in the Fock space is a linear combination of these $2^n$ basis states. Given a mode $j in ( 1 , dots.h , n )$, a fermionic #emph[creation operator] $A_j$ is defined by


$ A_j^dagger | c_0 , c_1 , dots.h , 0_j , dots.h , c_(n - 1) chevron.r & = ( - 1 )^(sum_(k = 0)^(j - 1) c_k) | c_0 , c_1 , dots.h , 1_j , dots.h , c_(n - 1) chevron.r ,\
A_j^dagger | c_0 , c_1 , dots.h , 1_j , dots.h , c_(n - 1) chevron.r & = 0 ,\
 $<eq:createrule>


whereas the fermionic #emph[annihilation operator] $A_j$ is defined by


$ A_j | c_0 , c_1 , dots.h , 0_j , dots.h , c_(n - 1) chevron.r & = 0 ,\
A_j | c_0 , c_1 , dots.h , 1_j , dots.h , c_(n - 1) chevron.r & = ( - 1 )^(sum_(k = 0)^(j - 1) c_k) | c_0 , c_1 , dots.h , 0_j , dots.h , c_(n - 1) chevron.r .\
 $<eq:annihirule>


For a fermionic system, each local term $h_j ( x )$ in the Hamiltonian $H ( x ) = sum_j h_j ( x )$ is a Hermitian matrix that can be expressed as a product of an even number of fermionic creation and annihilation operators; we refer to such a Hermitian matrix as an #emph[even fermionic observable]. For example, we could have $h_(p q r s) ( x ) = U_(p q r s) ( x ) A_p^dagger A_q^dagger A_r A_s + overline(U_(p q r s)) ( x ) A_s^dagger A_r^dagger A_q A_p$, where $U_(p q r s) ( x )$ is a complex-valued number. (This particular term conserves the total fermion number, but fermion number conservation is not actually required for our arguments to work.) Two #emph[even fermionic observables] acting on disjoint sets of spin orbitals commute with one another, just as two local observables acting on disjoint sets of qubits commute. As a result, several results in qubit systems based on the commutation relations of disjoint local observables can be easily generalized to #emph[even fermionic observables] in fermionic systems. In particular, one can generalize the proof of @thm:mainFourier as follows.

- First we construct a classical shadow representation for fermionic systems. An efficient approach for constructing such a representation is given in @zhao2021fermionic. This work rigorously analyzes how to predict a large number of properties using outcomes of measurements performed after randomized fermionic Gaussian unitaries. We can replace the classical shadow based on randomized Pauli measurements with the fermionic partial tomography introduced in @zhao2021fermionic.

- Secondly we establish a bounded speed of information spreading under evolution governed by $H ( x )$ in the ground state $rho ( x )$. Intuitively, we would like the "diameter" of the support (by "support" we mean the set of spin orbitals that an observable acts on substantially) of an #emph[even fermionic observable] under Heisenberg evolution to grow at most linearly in time. As for qubit systems, this growth rate is known as the Lieb-Robinson velocity. Because two even fermionic observables acting on disjoint sets of spin orbitals commute with one another, one can establish an upper bound on the Lieb-Robinson velocity in fermionic systems by following the argument used for qubit systems @bru2016lieb @nachtergaele2018lieb. This argument does not work for arbitrary fermionic systems, but it does work if the interaction graph of the spin orbitals is suitably sparse.


After these replacements, the rest of the proof follows immediately, yielding a version of @thm:mainFourier for fermionic systems. As we noted, the argument used to bound the Lieb-Robinson velocity does not work for some fermionic systems; for example it fails in models where orbitals have all-to-all connectivity without any geometrical constraints (the same is true for qubit systems).


But the proof of @thm:mainFourier does go through for tight-binding models, including the Fermi-Hubbard model. Since computing ground state properties of the Fermi-Hubbard model is notoriously difficult for classical computers, it is encouraging to find that our classical ML algorithm can compute these properties efficiently when provided with polynomial-size training data.





= PROOF OF EFFICIENCY FOR PREDICTING GROUND STATES
<sec:proofthmGSUPP>


This section contains a detailed proof for one of our main contributions. Namely, a rigorous performance guarantee for learning to predict ground state representations.


#thmbox("theorem", ([Theorem], [(#ref(<thm:mainFourier>), detailed restatement)]))[


Consider any family of $n$-qubit geometrically-local Hamiltonians $( H ( x ) : #h(0em) x in [ - 1 , 1 ]^m )$ in a finite spatial dimension, such that each local term in $H ( x )$ depends smoothly on $x$, and the smallest eigenvalue and the next smallest eigenvalues have a constant gap $gamma gt.eq Omega ( 1 )$ between them. Let $rho ( x )$ be the ground state of $H ( x )$, that is


$ rho ( x ) = & lim_(beta arrow.r oo) e^(- beta H ( x )) / "tr" ( e^(- beta H ( x )) ) in (bb(H)_2)^(⊗ n) & upright("(ground state of Hamiltonian H(x))") $


where $bb(H)_2$ is the vector space of $2 times 2$ Hermitian matrices. Suppose that we are interested in learning to predict a sum $O = sum_(i = 1)^L O_i$ of $L$ local observables that satisfies $sum_(i=1)^L norm(O_i) lt.eq B$ (bounded norm). Then, classical shadow data ${ x_ell arrow.r sigma_1 ( rho ( x_ell ) ) }_(ell = 1)^N$, with $x_ell tilde upright("Unif") [ - 1 , 1 ]^m$ and


$ N & = B^2 m^(cal(O) ( B^2 / epsilon.alt )) & upright("(training data size)") , $


suffices to produce a ground state prediction model


$ hat(sigma)_(N)(x) = frac(1, N) sum_(ell = 1)^(N) kappa(x, x_(ell)) rho(x_(ell)) thin thin thin "with" thin thin thin kappa(x, x_(ell)) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) cos(pi k ⋯ (x - x_(ell))) in bb(R), $


that achieves


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) | "tr" ( O hat(sigma)_N ( x ) ) - "tr" ( O rho ( x ) ) |^2 lt.eq epsilon.alt , $


with high probability. The classical training time for constructing $hat(sigma)_N ( x )$ and the prediction time for computing $"tr" ( O hat(sigma) ( x ) )$ are both upper bounded by $cal(O) ( ( n + L ) B^2 m^(cal(O) ( B^2 / epsilon.alt )) ) .$


] <thm:detailedFourier>


@thm:detailedFourier can be generalized to the following statement about learning a family of quantum states. In particular, we will prove the following theorem and use it to derive @thm:detailedFourier.


#thmbox("theorem", "Theorem")[


Consider a parametrized family of $n$-qubit states $( rho ( x ) : #h(0em) x in [ - 1 , 1 ]^m )$ and a sum $O = sum_(i = 1)^L O_i$ of $L$ local observables that obey $  $


$ bb(E)_(x tilde.op [-1, 1]^(m)) ||nabla_(x) "tr"(O rho(x))||_(2)^(2) lt.eq C & quad "(smoothness condition)", \
sum_(i) || O_(i)|| lt.eq B & quad "(bounded norm)" . $





Then, classical shadow data ${ x_ell arrow.r sigma_1 ( rho ( x_ell ) ) }_(ell = 1)^N$, with $x_ell tilde upright("Unif") [ - 1 , 1 ]^m$ and


$ N & = B^2 m^(cal(O) ( C / epsilon.alt )) & upright("(training data size)") , $


suffices to produce a state prediction model we can learn from classical data ${ x_ell arrow.r sigma_1 ( rho ( x_ell ) ) }_(ell = 1)^N$ to produce a model


$ hat(sigma)_(N)(x) = frac(1, N) sum_(ell = 1)^(N) kappa(x, x_(ell)) "tr"(O rho(x_(ell))) thin thin thin "with" thin thin thin kappa(x, x_(ell)) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) cos(pi k ⋯ (x - x_(ell))) in bb(R), $


that achieves


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) | "tr" ( O hat(sigma)_N ( x ) ) - "tr" ( O rho ( x ) ) |^2 lt.eq epsilon.alt , $


with high probability. The classical training time for constructing $hat(sigma)_N ( x )$ and the prediction time for computing $"tr" ( O hat(sigma) ( x ) )$ are both upper bounded by $cal(O) ( ( n + L ) B^2 m^(cal(O) ( C / epsilon.alt )) ) .$


] <thm:stateFourier>


The following sections are structured as follows. In @sec:overviewSCupGS, we provide an overview to illustrate the proof of the sample complexity upper bound. The first step, given in @sec:truncGS, bounds the truncation error when approximating the quantum state function $rho ( x )$ using a truncated Fourier series. The second step, given in @sec:MLTrun, bounds the generalization error for learning the Fourier approximation to the quantum state function $rho ( x )$. Then, in @sec:runtimeGS, we analyze the training and prediction time of the proposed classical machine learning model. These three sections establish @thm:stateFourier. Finally, in @sub:smoothness, we use @thm:stateFourier and nice properties about ground states of Hamiltonians to prove @thm:detailedFourier.


== Overview for sample complexity upper bound
<sec:overviewSCupGS>


The key intermediate step is to construct a truncated Fourier series of the quantum state function $rho ( x )$. The Fourier series of the matrix-valued function $rho ( x )$ is given as


$ rho ( x ) = sum_(k in bb(Z)^m) e^(upright(i) pi k dot.op x) A_k , $<eq:fourier-basis>


where $A_k$ are matrix-valued Fourier coefficients


$ A_k = 1 / 2^m integral_([ - 1 , 1 ]^m) e^(- upright(i) pi k dot.op x) rho ( x ) upright(d)^m x . $


We define the truncated Fourier series as


$ rho_(Lambda)(x) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) e^("i" pi k ⋯ x) A_(k), $ <eq:truncated-series>


where $Lambda > 0$ is a pre-specified cutoff value. Given an observable $O$ that can be written as a sum of local observables $O = sum_i O_i$ with $sum_i norm(O_i)_infinity lt.eq B$ and $"𝔼"_(x tilde [ - 1 , 1 ]^m) ∥nabla_x "tr" ( O rho ( x ) )∥_2^2 lt.eq C$, the proof of @thm:detailedFourier consists of two parts.


First, we bound the error between the truncated Fourier series $rho_Lambda ( x )$ and the true quantum state function $rho ( x )$ in @sec:truncGS giving


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"tr" ( O rho ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2 lt.eq cal(O) (C / Lambda^2) , $<eq:errrhoandrhoL>


We choose the truncation $Lambda = Theta ( sqrt(C / epsilon.alt) )$ such that the error between truncated Fourier series and the true quantum state function obeys


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"tr" ( O rho ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2 lt.eq epsilon.alt / 4 . $


In the second part, we bound the error between the machine learning model $hat(sigma) ( x )$ and the truncated Fourier series $rho_Lambda ( x )$ in @sec:MLTrun. With high probability over the randomness in generating the training data, we have


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"tr" ( O hat(sigma) ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2 lt.eq frac(B^2 m^(cal(O) ( Lambda^2 )), N) . $<eq:errgandrhoL>


The training data contains two sources of randomness, one from the sampling of $x_ell$ and the other from the local randomized measurement to construct approximate classical representation for $rho ( x_ell )$ that could be feed into the classical machine learning model. We choose the training data size


$ N = frac(2 B^2 m^(cal(O) ( C / epsilon.alt )), epsilon.alt) lt.eq B^2 m^(cal(O) ( C / epsilon.alt ) + log ( 1 / epsilon.alt ) + 1) = B^2 m^(cal(O) ( C / epsilon.alt )) , $


such that the error between the machine learning model and the truncated Fourier series obeys


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"tr" ( O hat(sigma) ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2 lt.eq epsilon.alt / 4 , $


with high probability. The two parts can be combined by a triangle inequality to yield $  $


$  & "𝔼"_(x tilde \[ - 1 , 1 \]^m) lr(|"tr" ( O hat(sigma) ( x ) ) - "tr" (O rho ( x ))|)^2\
 & lt.eq (sqrt("𝔼"_(x tilde \[ - 1 , 1 \]^m) lr(|"tr" ( O hat(sigma) ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2) + sqrt("𝔼"_(x tilde \[ - 1 , 1 \]^m) lr(|"tr" ( O rho ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2))^2 = epsilon.alt , $





with high probability over the randomness in the training data.


This establishes the sample complexity upper bound for @thm:detailedFourier.


When the Hamiltonians $H ( x )$ have spectral gap $gt.eq Omega ( 1 )$ in the domain $x in [ - 1 , 1 ]^m$, for any observable $O = sum_i O_i$ that can be written as a sum of local observables with $sum_i norm(O_i)_infinity lt.eq B$, we have


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) ∥nabla_x "tr" ( O rho ( x ) )∥_2^2 lt.eq cal(O) ( B^2 ) . $


Hence, we can prove the sample complexity upper bound in @thm:stateFourier by utilizing @thm:detailedFourier and the fact that $C = cal(O) ( B^2 )$.


== Controlling the truncation error
<sec:truncGS>


For a fixed observable $O$, we can define a function


$ f ( x ) = "tr" ( O rho ( x ) ) = sum_(k in bb(Z)^m) e^(upright(i) pi k dot.op x) "tr" ( O A_k ) . $


And the truncated Fourier series of the function $f ( x )$ is given by


$ f_(Lambda)(x) = "tr"(O rho_(Lambda)(x)) = rho_(Lambda)(x) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) e^("i" pi k ⋯ x) "tr"( O A_(k) ) . $


#thmbox("lemma", "Lemma (truncation error)")[


Let $f ( x ) = sum_(k in bb(Z)^m) alpha_k e^(upright(i) pi k dot.op x)$ and $f_Lambda(x) = sum_{k in bb(Z)^m, norm(k)_2 lt.eq Lambda} alpha_k e^(upright("i") pi k dot.op x)$. Then


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) | f ( x ) - f_Lambda ( x ) |^2 lt.eq frac(1, pi^2 Lambda^2) "𝔼"_(x tilde [ - 1 , 1 ]^m) ∥nabla_x f ( x )∥_2^2 quad upright("for any cutoff") quad Lambda > 0 . $


] <lem:truncation-error>


#block[
#emph[Proof.] The claim follows from standard Harmonic analysis arguments. More precisely, we combine #emph[orthogonality] ( $integral_([ - 1 , 1 ]^m) upright(e)^(upright(i) ( pi ( k - k' ) x) upright(d)^m x = delta_(( k , k' ))$) with the fact that the Fourier transform exchanges differentials ("momentum") with multiplications ("position"):~◻

]


$ nabla_x f ( x ) = sum_(k in bb(Z)^m) alpha_k nabla_x upright(e)^(upright(i) pi k x) = upright(i) pi sum_(k in bb(Z)^m) alpha_k k upright(e)^(upright(i) pi k x) . $<eq:fourier-property>


Use orthogonality to rewrite the truncation error as $  $


$ bb(E)_(x tilde.op [-1,1]^(m)) | f(x) - f_(Lambda)(x) |^(2) = & integral_([-1,1]^(m)) | sum_(k in bb(Z)^(m): || k||>Lambda) "e"^("i" pi k x) alpha_(k) |^(2) "d"^(m) x \
= & sum_(k:|| k||_(2)>Lambda) sum_(k':|| k'||_(2)>Lambda) ( integral_([-1,1]^(m)) "e"^("i" pi (k-k')x) "d"^(m) x ) overline(alpha_(k)) alpha_(k) \
= & sum_(k: || k||_(2) >Lambda) | alpha_(k) |^(2) . $ <eq:truncation-error-aux1>





Conversely, we use orthogonality and Rel.~@eq:fourier-property to rephrase this upper bound.


Let $chevron.l k' , k chevron.r$ be the Euclidean inner product between two vectors $k , k' in bb(Z)^m$. Then, $  $


$ bb(E)_(x tilde.op [-1,1]^(m))|| nabla_(x) f(x)||_(2)^(2) = & integral_([-1,1]^(m)) || sum_(k in bb(Z)^(m)) pi k "e"^("i" pi k x) alpha_(k)||_(2)^(2) "d"^(m) x \
= & sum_(k,k' in bb(Z)^(m)) pi^(2) chevron.l k',k chevron.r integral_([-1,1]^(m)) "e"^("i" pi (k-k')x) "d"^(m) x overline(alpha_(k')) alpha_(k) \
= & pi^(2) sum_(k in bb(Z)^(m)) chevron.l k,k chevron.r |alpha_(k)|^(2) = pi^(2) sum_(k in bb(Z)^(m)) || k||_(2)^(2) | alpha_(k) |^(2) . $





In words, the upper bound from Eq.~#ref(<eq:truncation-error-aux1>, supplement: none) can be rephrased as the Euclidean norm


$∥nabla_x f ( x )∥_2^2$ of the vector $nabla_x f ( x )$. The advertised claim readily follows from comparing these two reformulations:


$ sum_(k:|| k||_(2)>Lambda) | alpha_(k) |^(2) lt.eq frac(1, Lambda^(2)) sum_(k:|| k||_(2)>Lambda) || k||_(2)^(2) | alpha_(k) |^(2) lt.eq frac(1, pi^(2) Lambda^(2))( pi^(2) sum_(k in bb(Z)^(m)) || k||_(2)^(2) |alpha_(k) |^(2) ) . $





Using @lem:truncation-error and the condition that $"𝔼"_(x tilde [ - 1 , 1 ]^m) ∥nabla_x "tr" ( O rho ( x ) )∥_2^2 lt.eq C$, we can obtain the desired inequality for bounding the truncation error,


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"tr" ( O rho ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2 lt.eq cal(O) (C / Lambda^2) . $


==  Controlling generalization errors from using the training data 
<sec:MLTrun>


This section is devoted to a practical issue regarding training data based on classical shadows. Each label is obtained by performing a single-shot quantum measurement of a parametrized quantum state $rho ( x_i )$. We can use Eq.~#ref(<eq:classical-shadow>, supplement: none) to convert the single-shot outcome into $sigma_1 ( rho ) = ⨂_(i = 1)^n (3 | s_i chevron.r chevron.l s_i | - bb(I))$. Such a classical shadow approximation reproduces the underlying state in expectation, i.e., $"𝔼"_(s_1 , dots.h , s_n) [ sigma_1 ( rho ) ] = rho$. Recall that the training data $cal(T) = {x_ell arrow.r sigma_1 ( rho ( x_ell ) )}_(ell = 1)^N$ consists of such classical shadow approximations. The machine learning model makes predictions based on a truncated Fourier kernel for future predictions. For new input $x in [- 1 , 1]^n$, we predict $  $<eq:sigma-hat>


$ hat(sigma) (x) & = frac(1, N) sum_(ell = 1)^(N)kappa (x, x_(ell)) sigma_(1) ( rho (x_(ell)) ) quad "with" quad \
kappa(x, x_(ell)) & = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) "e"^("i" pi k ⋯ (x - x_(ell))) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) cos(pi k ⋯ (x - x_(ell))) . $





In the following, we will show that machine learning model $hat(sigma) ( x )$ is equal to the truncated Fourier series $rho_Lambda ( x )$ of the true target quantum state if we take the expectation over the training data, which includes the sampled inputs $x_1 , dots.h , x_N$ and the randomized measurement outcomes $S_1 ( rho ( x_ell ) ) = { s_i }_(i = 1)^n$ for each input $x_ell$.


Moreover, statistical flucutations due to shot noise will be small provided that we are interested in predicting an observable that decomposes nicely as a sum of local terms. These observations are the content of the following statement.


#thmbox("lemma", ([Lemma], [(Statistical properties of the predicted quantum state $hat(sigma) ( x )$)]))[


Let $cal(T) = { x_ell arrow.r sigma_1 ( rho ( x_ell ) ) }_(ell = 1)^N$ be a training set featuring uniformly random inputs $x_ell tilde^(italic("unif")) [ - 1 , 1 ]^m$ and classical shadows of the associated quantum states as labels. Then, the machine learning model obeys


$ bb(E)_(cal(T))[hat(sigma)(x)] = rho_(Lambda)(x) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) e^("i" pi k ⋯ x) A_(k) . $


Moreover, suppose that an observable $O = sum_i O_i$ decomposes into a sum of $q$-local terms. Then, with probability at least $1 - delta$, we have


$ bb(E)_(x tilde.op [-1, 1]^(m)) |"tr"(O hat(sigma)(x)) - "tr"(O rho_(Lambda)(x)) |^(2) lt.eq frac(1, N)9^(q) (sum_(i) || O_(i)||_(infinity))^(2) (2m+1)^(Lambda^(2)) ( Lambda^(2) log(2m + 1) + log(4/delta) ) . $


] <lem:groundstateprop>


The advertised bound can be further streamlined if the observable locality $q$ and confidence level $delta$ are constant. Assuming $q , delta = cal(O) ( 1 )$ ensures the following simplified scaling:


$ bb(E)_(x tilde.op [-1, 1]^(m)) |"tr"(O hat(sigma)(x)) - "tr"(O rho_(Lambda)(x)) |^(2) = cal(O) ( frac(1, N) ( sum_(i) || O_(i)|| )^(2) (2m + 1)^(Lambda^(2) + log (Lambda^(2)) +1) ) = frac((sum_(i) || O_(i)||)^(2) m^(cal(O)(Lambda^(2))), N) . $


Using the condition that $sum_i norm(O_i) lt.eq B$, we have


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"tr" ( O hat(sigma) ( x ) ) - "tr" (O rho_Lambda ( x ))|)^2 = frac(B^2 m^(cal(O) ( Lambda^2 )), N) , $


which controls the generalization error from quantum measurements.


The argument is based on fundamental properties of classical shadows that have been reviewed in Appendix~#ref(<sec:classical-shadows>, supplement: none).


#block[
#emph[Proof of @lem:groundstateprop.] We begin by condensing notation somewhat. Here, we only consider classical shadows of size $T = 1$. Hence, we may replace the superscript $( t )$ by $( x_ell )$ to succinctly keep track of classical input parameters. More precisely, we let $| s_i^(( x_ell )) chevron.r$ be the randomized Pauli measurement outcome for the $i$-th qubit when measuring the quantum state $rho ( x_ell )$. The training data $cal(T) = { x_ell arrow.r sigma_1 ( rho ( x_ell ) ) }_(ell = 1)^N$ is determined by the following random variables $  $<eq:training-data>~◻

]


$ x_(ell) in [-1,1]^(m), quad "for" ell in {1,…,N}, $ <eq:training-xell>

$ s^((x_(ell)))_(i) in {|0 chevron.r, |1 chevron.r, |+chevron.r, |-chevron.r, |"i"+chevron.r, |"i"-chevron.r}, quad "for i" in {1,…,n} and ell in {1,…,N} . $ <eq:training-sell>





The first claim is an immediate consequence of Eq.~#ref(<eq:snapshot-expectation>, supplement: none):


$  $


$ bb(E)_(cal(T))[hat(sigma)(x)] & = frac(1, N) sum_(ell=1)^(N) bb(E)_(x_(ell)tilde.op[-1,1]^(m))[kappa(x, x_(ell)) bb(E)_(s^((x_(ell)))_(1), …, s^((x_(ell)))_(n))[sigma_(1)(rho(x_(ell)))]] \
& = frac(1, N) sum_(ell=1)^(N) bb(E)_(x_(ell)tilde.op[-1,1]^(m))[kappa(x, x_(ell)) rho(x_(ell)) ] \
& = bb(E)_(x_(1)tilde.op[-1,1]^(m))[kappa(x, x_(1)) rho(x_(1)) ] \
& = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) e^("i" pi k ⋯ x) bb(E)_(x_(1)tilde.op[-1,1]^(m))[ e^(-"i" pi k ⋯ x_(1)) rho(x_(1))] \
& = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) e^("i" pi k ⋯ x) frac(1, 2^(m)) integral_([-1, 1]^(m)) e^(-"i" pi k ⋯ x_(1)) rho(x) "d"^(m) x_(1) \
& = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) e^("i" pi k ⋯ x) A_(k) \
& = rho_(Lambda) (x) . $





Here, we have also used the fact that each $x_ell$ is sampled independently and uniformly from $[ - 1 , 1 ]^m$.


The second result is contingent on the training data for predicting the ground state representation $cal(T) = { x_ell arrow.r sigma_1 ( rho ( x_ell ) ) }_(ell = 1)^N$. We begin with using the definitions of $hat(sigma) ( x )$ (@eq:sigma-hat) and $rho_Lambda ( x )$ to rewrite the expression of interest as $  $<eq:shot-noise-concentration-aux1>


$ & bb(E)_(x tilde.op[-1,1]^(m))|"tr"(O hat(sigma)(x))-"tr"(O rho_(Lambda)(x))|^(2) \
= & frac(1, 2^(m))integral_([-1,1]^(m))"d"^(m)x|sum_(k in bb(Z)^(m),|| k||_(2)lt.eq Lambda)"e"^("i" pi k⋯ x)(frac(1, N)sum_(ell=1)^(N)"e"^(-"i" pi k⋯ x_(ell))"tr"(O sigma_(1)(rho(x_(ell))))-"tr"(O A_(k)))|^(2) \
= & sum_(k in bb(Z)^(m),|| k||_(2)lt.eq Lambda)|frac(1, N)sum_(ell=1)^(N)"e"^(-"i" pi k⋯ x_(ell))"tr"(O sigma_(1)(rho(x_(ell))))-"tr"(O A_(k))|^(2)~, \
equiv & sum_(k in bb(Z)^(m),|| k||_(2)lt.eq Lambda)D_((k))(cal(T))^(2)~, $ <eq:shot-noise-concentration-aux1.1>





where we have evaluated the Fourier integral over $x$ and introduced shorthand notation $D_(( k )) ( cal(T) )^2$ for each summand.


The next key step is to notice that each $A_k$ is an expectation value over both the parameters and the shadows. Writing out $A_k$ and expressing $rho$ in terms of shadows using Eq.~(@eq:snapshot-expectation), $  $


$ "tr" (O A_k) & = 1 / 2^m integral_(\[ - 1 , 1 \]^m) upright(e)^(- upright(i) pi k dot.op x_ell) "tr" (O rho ( x_ell )) upright(d)^m x_ell\
 & = "𝔼"_(x_ell tilde \[ - 1 , 1 \]^m) upright(e)^(- upright(i) pi k dot.op x_ell) "tr" (O rho ( x_ell ))\
 & = "𝔼"_(x_ell upright(" and ") s_1^(( x_ell )) , dots.h , s_n^(( x_ell ))) upright(e)^(- upright(i) pi k dot.op x_ell) "tr" (O sigma_1 (rho ( x_ell ))) med . $





Plugging this back into the summand in Eq.~(#ref(<eq:shot-noise-concentration-aux1.1>, supplement: none)) yields


$ D_(( k )) ( cal(T) )^2 = lr(|1 / N sum_(ell = 1)^N upright(e)^(- upright(i) pi k dot.op x_ell) "tr" (O sigma_1 (rho ( x_ell ))) - "𝔼"_(x_ell upright(" and ") s_1^(( x_ell )) , dots.h , s_n^(( x_ell ))) upright(e)^(- upright(i) pi k dot.op x_ell) "tr" (O sigma_1 (rho ( x_ell )))|)^2 med . $


Therefore, each $D_(( k )) ( cal(T) )^2$ is the (square-)deviation of an empirical average from the true expectation value $A_k$. Hence, we can use Hoeffding's inequality to bound it, provided that $O$ is local and bounded. This may come as a surprise, as the empirical average samples only different parameters $x_ell$ and not different shadows $sigma$. However, the shadows depend on the parameters, so sampling only over the parameters turns out to be sufficient for a reasonable estimate.


In order to apply Hoeffding's inequality, we first have to make sure the expectation value is bounded. Recall that $O = sum_i O_i$ decomposes nicely into a sum of $q$-body terms. More formally, $upright("supp") ( O_j ) subset ( 1 , dots.h , n )$ contains at most $q$ qubits. We also know trace and trace norm of each single-qubit contribution to $sigma_1 ( rho ( x_ell ) )$, $upright("tr") ( 3 | s_j^(( x_ell )) chevron.r chevron.l s_j^(( x_ell )) | - bb(I) ) = 1$, and Eq.~#ref(<eq:shadow-norm>, supplement: none) asserts $norm(3 | s_j^(( x_ell )) chevron.r chevron.l s_j^(( x_ell )) | - bb(I))_1 = 3$. The matrix Hoelder inequality then implies, for every $x_ell in [ - 1 , 1 ]^m$, $  $


$ lr(|upright(e)^(upright(i) pi k dot.op x_ell) "tr" (O sigma_1 (rho ( x_ell )))|) & lt.eq sum_i lr(|upright("tr") (O_i sigma_1 ( rho ( x_ell ) ))|)\
 & = sum_i lr(|upright("tr") (O_(A_i) upright("tr")_(not A_i) (sigma_1 (rho ( x_ell ))))|)\
 & lt.eq sum_i ∥O_(A_i)∥_oo ∥upright("tr")_(not A_i) (sigma_1 (rho ( x_ell )))∥_1\
 & = sum_i parallel O_i parallel_oo product_(j in upright("supp") ( O_i )) ∥3 | s_j^(( x_ell )) chevron.r chevron.l s_j^(( x_ell )) | - bb(I)∥_1\
 & = sum_i parallel O_i parallel_oo 3^(| upright("supp") ( O_j ) |) lt.eq 3^q sum_i parallel O_i parallel_oo . $





Thus, the expectation value is bounded.


We are now ready to bound the likelihood of a large deviation $D_(( k )) ( cal(T) )^2$. To recap, for each $k in bb(Z)^m$ obeying $norm(k)_2 lt.eq Lambda$, we face a contribution that collects the (square-)deviation of a sum of #emph[iid] and #emph[bounded] random variables around their expectation value. These variables are complex, but one can analyze their real and imaginary parts separately and collect them into a complex version of Hoeffding's inequality: $  $<eq:shot-noise-concentration-aux2>


$ "Pr"[D_((k))(cal(T))^(2)gt.eq tau^(2)] & ="Pr"[D_((k))(cal(T))gt.eq tau] \
& lt.eq 2 exp(-frac(2N tau^(2), 9^(q)(sum_(i)|| O_(i)||)^(2)))quad"for all" quad tau>0 . $





This concentration bound connects training data size $N = | cal(T) |$ with the size of a (fixed, but arbitrary) contribution to the expected deviation @eq:shot-noise-concentration-aux1. For fixed magnitude $tau$ and confidence $delta$, there is always a (finite) training data size $N = N ( tau , delta )$ that ensures $D_(( k )) ( cal(T) )^2 lt.eq tau$ with probability at least $1 - delta$.


We can extend this reasoning to the entire sum in Eq.~#ref(<eq:shot-noise-concentration-aux1>, supplement: none) by exploiting that Rel.~@eq:shot-noise-concentration-aux2 is independent of $k$, and the summation only ranges over finitely many terms. Introduce $K_Lambda = | {k in bb(Z)^m: norm(k)_2 lt.eq Lambda } |$ --- the number of wave-vectors $k in bb(Z)^m$ whose Euclidean norm is bounded by $Lambda$ --- and apply a union bound to conclude $  $


$ "Pr" [ sum_(k in bb(Z)^(m),|| k||_(2) lt.eq Lambda) D_((k)) (cal(T))^(2) gt.eq K_(Lambda) tau^(2) ] & lt.eq "Pr" [ exists k in bb(Z)^(m): || k||_(2) lt.eq Lambda, thin thin "s.t." thin thin D_((k)) (cal(T))^(2) gt.eq tau^(2) ] \
& lt.eq sum_(k in bb(Z)^(m),|| k||_(2) lt.eq Lambda) "Pr" [ D_((k))(cal(T))^(2) gt.eq tau^(2) ] \
& lt.eq 2 K_(Lambda) exp ( - frac(2 N tau^(2), 9^(q) (sum_(i) || O_(i)||)^(2)) ) . $





for all $tau > 0$.


To finish the argument, we take guidance from Eq.~#ref(<eq:shot-noise-concentration-aux2>, supplement: none). Fix a confidence level $delta in ( 0 , 1 )$ and set


$ tau^2 = frac(1, N) 9^q (sum_i norm(O_i))^2 log (2 K_Lambda / delta) quad "to ensure" quad "Pr" [ "𝔼"_(x tilde [-1, 1]^m) |"tr"(O hat(sigma)(x)) - "tr"(O rho_Lambda (x))|^2 gt.eq K_Lambda tau^2 ] lt.eq delta . $


The advertised bound follows from inserting an explicit bound on the number of relevant wavevectors:


$ K_(Lambda) = | { k in bb(Z)^(m):med || k||_(2) lt.eq Lambda } | lt.eq (2m+1)^(Lambda^(2)) . $ <eq:numklambda>


To see this, note that $norm(k)_2^2 = sum_(i=1)^n |k_i|^2 gt.eq sum_(i=1)^n |k_i| = norm(k)_(1)$, because $k_i in bb(Z)$. Conversely, every $k in bb(Z)^m$ that obeys $norm(k)_2 lt.eq Lambda$ also obeys $norm(k)_1 lt.eq Lambda^2$. Next, we enumerate all wave-vectors that obey the relaxed condition $norm(k)_1 lt.eq Lambda^2$. To this end, we consider a simple process: select an index $i in [ m ]$,


and update the associated wave number by $+ 1$ (increment), $0$ (do nothing) or $- 1$ (decrement).


Repeating this process a total of $Lambda^2$ times allows us to generate no more than $( 2 m + 1 )^(Lambda^2)$ different wavevectors. But, at the same time, every wave vector $k in bb(Z)^m$ that obeys $norm(k)_2 lt.eq Lambda^2$ can be reached in this fashion. Hence, we conclude $K_Lambda lt.eq | { k in bb(Z)^m: norm(k)_1 lt.eq Lambda^2 } | lt.eq (2m+1)^(Lambda^2)$.






== Computational time for training and prediction
<sec:runtimeGS>


We have proposed a very simple prediction model that is based on approximating a truncated Fourier series ($l_2$-Dirichlet kernel). The training time is equivalent to loading the training data $cal(T) = {x_ell arrow.r sigma_1 ( rho ( x_ell ) )}_(ell = 1)^N$. Only a single snapshot is provided for each sampled parameter $x_ell$ (i.e., $T = 1$), so we relabel $s^(( t )) arrow.r s^(( x_ell ))$. The training data is given by the collection of $x_ell$ and shadows ${ s_i^(x_ell) }_(i = 1)^n$, following Eq.~(@eq:training-data). Therefore, one only needs


$ cal(O) (( n + m ) N) = cal(O) (( n + m ) B^2 m^(cal(O) ( C / epsilon.alt ))) = cal(O) (n B^2 m^(cal(O) ( C / epsilon.alt ))) & quad upright("(training time)") $


computational time to load the relevant data into a classical memory. Next, suppose that $O = sum_(i = 1)^L O_i$ is comprised of $L q$-local terms. Then, we can compute the associated expectation value for the predicted quantum state $hat(sigma) ( x )$ by evaluating


$ "tr" ( O hat(sigma) ( x ) ) = 1 / N sum_(ell = 1)^N sum_(i = 1)^L kappa ( x , x_ell ) "tr" ( O_i sigma_1 ( rho ( x_ell ) ) ) . $


Recall that the kernel function is defined as


$ kappa(x, x_(ell)) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) "e"^("i" pi k ⋯ (x - x_(ell))) = sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) cos(pi k ⋯ (x - x_(ell))) . $


This can be computed in time $cal(O) (K_Lambda)$, where $K_Lambda = | { k in bb(Z)^m: norm(k)_2 lt.eq Lambda } | lt.eq (2m+1)^(Lambda^2)$, according to Rel.~@eq:numklambda above. Because we have chosen $Lambda = Theta ( sqrt(C / epsilon.alt) )$, the runtime to evaluate one kernel function is upper bounded by $m^(cal(O) ( C / epsilon.alt ))$.


On the other hand, the computation of each $"tr" ( O_j sigma_1 ( rho ( x_ell ) ) )$ can be performed in constant time after storing the data in a classical memory. This is a consequence of the tensor product structure of $sigma_1 ( rho ( x_ell ) ) = ⨂_(i = 1)^n (3 | s_i^(( x_ell )) chevron.r chevron.l s_i^(( x_ell )) | - bb(I))$ which ensures


$ "tr" ( O_j sigma_1 ( rho ( x_ell ) ) ) = "tr" ( O_j ⨂_(i in upright("supp") ( O_j )) (3 | s_i^(( x_ell )) chevron.r chevron.l s_i^(( x_ell )) | - bb(I)) ) , $


where $upright("supp") ( O_j )$ is the set of qubits in $( 1 , dots.h , n )$ the local observable $O_j$ acts on. Because $| upright("supp") ( O_j ) | lt.eq q = cal(O) ( 1 )$, computing $"tr" ( O_j sigma_1 ( rho ( x_ell ) ) )$ takes only constant time. However, the computation time does scale exponentially in $| upright("supp") ( O_j ) |$. This can become a problem if $| upright("supp") ( O_j ) |$ ceases to be a #emph[small] constant. Putting everything together implies that $"tr" ( O hat(sigma) ( x ) )$ can be computed in time (at most)


$ cal(O) (N L m^(cal(O) ( C / epsilon.alt ))) = cal(O) (L B^2 m^(cal(O) ( C / epsilon.alt ))) & med med med med med med med med upright("(prediction time)") . $


We conclude that both classical training time and prediction time for $"tr" ( O hat(sigma) ( x ) )$ are upper bounded by


$ cal(O) ( ( n + L ) B^2 m^(cal(O) ( C / epsilon.alt )) ) . $


This concludes the proof of all statements given in @thm:stateFourier.


== Spectral gap implies smooth parametrizations
<sub:smoothness>


We attempt to deduce @thm:detailedFourier from @thm:stateFourier. The key step involves showing that the ground state $rho ( x )$ in a quantum phase of matter satisfies the following condition: For any observable $O = sum_i O_i$ that can be written as a sum of local observables with $sum_i norm(O_i)_infinity lt.eq B$, we have


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) ∥nabla_x "tr" ( O rho ( x ) )∥_2^2 lt.eq cal(O) ( B^2 ) . $


Then we can apply @thm:stateFourier with $C = cal(O) ( B^2 )$ to derive @thm:detailedFourier.


The average gradient magnitude $"𝔼"_(x tilde [ - 1 , 1 ]^m) ∥nabla_x "tr" ( O rho ( x ) )∥_2^2$ depends on the observable $O$ in question, but also on the parametrization $x mapsto H ( x ) mapsto rho ( x )$. This section provides a useful smoothness bound based on physically meaningful assumptions:

+ #emph[Physical system:] We consider $n$ finite-dimensional quantum many-body systems that are arranged at locations, or sites, in a $d$-dimensional space, e.g.,~a spin chain ($d = 1$), a square lattice ($d = 2$), or a cubic lattice ($d = 3$). Unless specified otherwise, our big-$cal(O) , Omega , Theta$ notation will be with respect to the thermodynamic limit $n arrow.r oo$.

+ #emph[Hamiltonian:] $H ( x )$ decomposes into a sum of geometrically local terms $H ( x ) = sum_j h_j ( x )$, each of which only acts on an $cal(O) ( 1 )$ number of sites in a ball of $cal(O) ( 1 )$ radius. Individual terms $h_j ( x )$ obey $norm(h_j(x))_infinity lt.eq 1$ and also have bounded directional derivative: $∥partial h_j / partial hat(u)∥_oo lt.eq 1$, where $hat(u)$ is a unit vector in parameter space. However, each term $h_j ( x )$ can depend on the entire input vector $x in [ - 1 , 1 ]^m$.

+ #emph[Ground-state subspace:] We consider "the" ground state $rho ( x )$ for the Hamiltonian $H ( x )$ to be defined as $rho ( x ) = lim_(beta arrow.r oo) upright(e)^(- beta H ( x )) / "tr" ( upright(e)^(- beta H ( x )) )$. This is equivalent to a uniform mixture over the eigenspace of $H ( x )$ with the minimum eigenvalue.

+ #emph[Observable:] $O$ decomposes into a sum of few-body observables $O = sum_i O_i$, each of which only acts on an $cal(O) ( 1 )$ number of sites. Each few-body observables $O_i$ can act on geometrically-nonlocal sites.


Assumptions (a)--(c) should be viewed as mild technical assumptions that are often met in practice. The main result of this section bounds the smoothness condition based on an additional requirement.


#thmbox("lemma", "Lemma (Spectral gap implies smoothness condition)")[


Consider a class of local Hamiltonians


$ (H ( x ) : #h(0em) x in [ - 1 , 1 ]^m) $


and an observable $O = sum_i O_i$ that obey the technical requirements (a)--(c) above. Moreover, suppose that the #emph[spectral] gap of each $H ( x )$ is lower bounded by (constant) $gamma > Omega ( 1 )$. Then,


$ bb(E)_(x tilde.op [-1, 1]^(m)) ||nabla_(x) "tr"(O rho(x))||_(2)^(2) lt.eq c_("all")(sum_(i) || O_(i)||_(infinity))^(2) . $


Here, $c_(upright("all")) > 0$ is a constant that depends on spatial dimension $d$, spectral gap $gamma$, as well as the Lieb-Robinson velocities.


] <lem:truncatedFourier>


The proof is based on combining two powerful techniques from quantum many body physics. Namely, Lieb-Robinson bounds @Lieb1972 to exploit locality and the spectral flow formalism @bachmann2012automorphic, also referred to as quasi-adiabatic evolution or continuation @hastings2005quasiadiabatic @osborne2007simulating, to exploit the spectral gap.


==== Quasi-adiabatic continuation for gapped Hamiltonians @hastings2005quasiadiabatic @osborne2007simulating #cite(<bachmann2012automorphic>):
<quasi-adiabatic-continuation-for-gapped-hamiltonians>


Given a quantum system satisfying the above assumptions (a)-(c), it is reasonable to expect that small changes in $x$


only lead to small changes in the associated ground state $rho ( x )$. Spectral flow makes this intuition precise. Let the spectral gap of $H ( x )$ be lower bounded by a constant $gamma$ over $[ - 1 , 1 ]^m$. Then, the directional derivative of an associated ground state, in the direction defined by the parameter unit vector $hat(u)$, obeys


$ frac(partial rho, partial hat(u)) ( x ) = upright(i) [ D_(hat(u)) ( x ) , rho ( x ) ] quad upright("where") quad D_(hat(u)) ( x ) = integral_(- oo)^oo W_gamma ( t ) upright(e)^(upright(i) t H ( x )) frac(partial H, partial hat(u)) ( x ) upright(e)^(- upright(i) t H ( x )) upright(d) t . $


Here, $W_gamma ( t )$ is a fast decaying weight function that obeys $sup_t lr(|W_gamma ( t )|) = 1 / 2$ and only depends on the spectral gap. More precisely, $ | W_gamma ( t ) | lt.eq cases(
    1 / 2 & 0 lt.eq gamma | t | lt.eq theta ,,
    35 upright("e")^2 ( gamma | t | )^4 upright("e")^(- 2 / 7 frac(gamma | t |, log ( gamma | t | )^2)) & gamma | t | > theta .
  ) $<eq:Wbound> The constant $theta$ is chosen to be the largest real solution of $35 upright(e)^2 theta^4 exp ( - 2 / 7 frac(theta, log ( theta )^2) ) = 1 / 2$.


==== Lieb-Robinson bounds for local Hamiltonians/observables @Lieb1972 #cite(<hastings2010locality>):
<lieb-robinson-bounds-for-local-hamiltoniansobservables>
Let $upright("supp") ( X )$ denote the sites on which a many-body operator $X$ acts nontrivially.


Furthermore, for any two operators $X_1 , X_2$, we define the distance $Delta ( X_1 , X_2 )$ to be the minimum distance between all pairs of sites acted on by $X_1$ and $X_2$, respectively, in the $d$-dimensional space. We also consider the number of local terms in a ball of radius $r$. For any operator $X$ acting on a single site,


this ball contains $cal(O) ( r^d )$ local terms in $d$-dimensional space,


$ sum_(j : Delta ( X , h_j ) lt.eq r) 1 lt.eq b_d + c_d r^d , forall r gt.eq 0 , $<eq:termsinball>


where we recall the definition that $H = sum_j h_j$ is a sum of local terms $h_j$. The bound on the number of local terms in a ball of radius $r$ implies the existence of a Lieb-Robinson bound @bravyi2006lieb @hastings2010locality. It states that for any two operator $X_1 , X_2$ and any $t in bb(R)$, we have


$ ||[exp("i"t H(x)) X_(1) exp(-"i"t H(x)), X_(2)]||_(infinity) lt.eq c_("lr") || X_(1)||_(infinity) || X_(2)||_(infinity) |"supp"(X_(1))| "e"^(-a_("lr") (Delta(X_(1), X_(2)) - v_("lr") |t|)), $ <eq:LRbound>


for some constants $a_(upright("lr")) , c_(upright("lr")) , v_(upright("lr")) = Theta ( 1 )$.


Apart from these two concepts, we will also need a bound on integrals of certain fast-decaying functions.


#thmbox("lemma", ([Lemma], [(Lemma 2.5 in #cite(<bachmann2012automorphic>))]))[


Fix $a > 0$ and define the function $u_a ( x ) = exp ( - a x / log ( x )^2 )$ on the domain $x in ( 1 , oo )$. Then,


$ integral_(t)^(infinity) x^(k) u_(a)(x) "d" x lt.eq frac(2k + 3, a) t^(2k + 2) u_(a)(t) quad "for all t" >"e"^(4) and k in bb(N) t h a t o b e y quad 2k+2 lt.eq frac(a t, log(t)^(2)) . $


] <lem:boundintua>


#block[
#emph[Proof of @lem:truncatedFourier.]~◻

]


Fix an input $x in [- 1 , 1]^n$ and a unit vector $hat(u) in bb(R)^n$ (direction). We may then rewrite the associated directional derivative of $rho ( x )$ in two ways, namely $  $


$ frac(partial rho, partial hat(u)) ( x ) & = hat(u) dot.op nabla_x rho ( x ) , quad upright("and")\
frac(partial rho, partial hat(u)) ( x ) & = - upright(i) [D_(hat(u)) ( x ) , rho ( x )] quad upright("with") quad D_(hat(u)) ( x ) = integral_(- oo)^oo upright(d) t W_gamma ( t ) upright(e)^(upright(i) t H ( x )) frac(partial H, partial hat(u)) ( x ) upright(e)^(- upright(i) t H ( x )) . $





When evaluated on an observable $O$, this establishes the following correspondence:


$ hat(u) dot.op nabla_x "tr" ( O rho ( x ) ) = "tr" (O [D_(hat(u)) ( x ) , rho ( x )]) = "tr" ([O , D_(hat(u)) ( x )] rho ( x )) , $


for any $hat(u)$. Choosing $hat(u) = hat(u) ( x , O ) = frac(nabla_x "tr" ( O rho ( x ) ), ∥nabla_x "tr" ( O rho ( x ) )∥_2)$ implies


$ ∥nabla_x "tr" ( O rho ( x ) )∥_2^2 = lr(|"tr" ( [ O , D_(hat(u) ( x , O )) ( x ) ] rho ( x ) )|)^2 . $


The left hand side is the magnitude of steepest slope in a phase for the particular observable $O$. The average slope over the entire domain $[ - 1 , 1 ]^m$ is thus given as


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) ∥nabla_x "tr" ( O rho ( x ) )∥_2^2 = 1 / 2^m integral_([ - 1 , 1 ]^m) lr(|"tr" ( [ O , D_(hat(u) ( x , O )) ( x ) ] rho ( x ) )|)^2 upright(d)^m x . $<eq:gradaverage>


Intuitively, thermodynamic observables should not change too rapidly within a phase. Making this intuition precise will allow us to upper bound the average slope by a constant $C$.


We first expand $D_(hat(u)) ( x )$ and apply a triangle inequality to obtain


$ | "tr" ( [ O , D_(hat(u)) ( x ) ] rho ( x ) ) | & lt.eq sum_i integral_(- oo)^oo W_gamma ( t ) sum_j ∥[O_i , upright(e)^(upright(i) t H ( x )) frac(partial h_j, partial hat(u)) ( x ) upright(e)^(- upright(i) t H ( x ))]∥_oo upright(d) t . $<eq:uppslope>


For fixed $t$, we can separate local Hamiltonian terms into two groups, defines using the constants in the Lieb-Robinson bound (#ref(<eq:LRbound>, supplement: none)). The first group contains all terms $h_j$ that obey $Delta ( O_i , h_j ) lt.eq v_(upright("lr")) | t |$. The second group contains all $h_j$ that obey $Delta ( O_i , h_j ) > v_(upright("lr")) | t |$ instead. Equation~#ref(<eq:termsinball>, supplement: none) above provides a useful bound on the size of the first group. It contains at most $| upright("supp") ( O_i ) | ( b_d + c_d ( v_(upright("lr")) | t | )^d ) lt.eq c_O ( b_d + c_d ( v_(upright("lr")) | t | )^d )$ local terms $h_j$, for some constant $c_O lt.eq upright("supp") ( O )$. We can bound the summation over these terms using $norm([A, B])_infinity lt.eq 2 norm(A)_infinity norm(B)_infinity$ to obtain $  $


$ sum_(j: Delta(O_(i), h_(j)) lt.eq v_("lr") t) ||[O_(i), "e"^("i" t H(x)) frac(partial h_(j), partial hat(u))(x) "e"^(-"i" t H(x))]||_(infinity) & lt.eq c_(O) (b_(d) + c_(d) (v_("lr") |t|)^(d)) times 2 || O_(i)||_(infinity) ||frac(partial h_(j), partial hat(u))||_(infinity) \
& lt.eq 2 c_(O) || O_(i)||_(infinity) (b_(d) + c_(d) (v_("lr") |t|)^(d)) . $





The second inequality follows from


technical assumption (b): $∥partial h_j / partial hat(u)∥_oo lt.eq 1$.


The contributions from the second group can be controlled via the


Lieb-Robinson bound from Eq.~#ref(<eq:LRbound>, supplement: none). For every $h_j$ that obeys $Delta ( O_i , h_j ) > v_(upright("lr")) | t |$, we have $  $


$ ||[O_(i), "e"^("i" t H(x)) frac(partial h_(j), partial hat(u))(x) "e"^(-"i" t H(x))]||_(infinity) & lt.eq c_("lr") || O_(i)||_(infinity) ||partial h_(j) / partial hat(u)||_(infinity) |"supp"(h_(j))| "e"^(-a_("lr") (Delta(O_(i), h_(j)) - v_("lr") |t|)) \
& lt.eq c_("lr") c_(h) || O_(i)||_(infinity) "e"^(-a_("lr") (Delta(O_(i), h_(j)) - v_("lr") |t|)) . $





Reusing Eq.~#ref(<eq:termsinball>, supplement: none), we conclude that there are at most $| upright("supp") ( O_i ) | ( b_d + c_d ( v_(upright("lr")) | t | + r + 1 )^d )$ local terms $h_j$ with $Delta ( O_i , h_j ) in [ v_(upright("lr")) | t | + r , v_(upright("lr")) | t | + r + 1 ]$. This ensures


$  $


$ & sum_(j: Delta(O_(i), h_(j)) > v_("lr") |t|) ||[O_(i), "e"^("i" t H(x)) frac(partial h_(j), partial hat(u))(x) "e"^(-"i" t H(x))]||_(infinity) \
& lt.eq sum_(r = 0)^(infinity) sum_(j: Delta(O_(i), h_(j)) in [v_("lr") |t| + r, v_("lr") |t|+ r + 1]) ||[O_(i), "e"^("i" t H(x)) frac(partial h_(j), partial hat(u))(x) "e"^(-"i" t H(x))]||_(infinity) \
& lt.eq integral_(r = 0)^(infinity) "d" r c_("lr") c_(h) || O_(i)||_(infinity) "e"^(-a_("lr") r) times "supp"(O_(i)) (b_(d) + c_(d) (v_("lr") |t| + r + 1)^(d)) \
& lt.eq c_("lr") c_(h) c_(O) || O_(i)||_(infinity) integral_(r = 0)^(infinity) "d" r "e"^(-a_("lr") r) (b_(d) + c_(d) (v_("lr") |t| + r + 1)^(d)) \
& lt.eq c_("lr") c_(h) c_(O) || O_(i)||_(infinity) ( frac(b_(d), a_("lr")) + c_(d) sum_(p=0)^(d) frac(d!, p! a_("lr")^(d-p+1)) (v_("lr") |t| + 1)^(p) ) . $





We can now combine the two bounds into a single statement:


$ sum_(j) ||[O_(i), "e"^("i" t H(x)) frac(partial h_(j), partial hat(u))(x) "e"^(-"i" t H(x))]||_(infinity) lt.eq || O_(i)||_(infinity) sum_(p=0)^(d) C_(p) |t|^(p) . $ <eq:gap-aux1>


Here, we have implicitly defined a new set of constants $C_p$ that depend on the constants $c_O , c_h , c_(upright("lr")) , c_d , a_(upright("lr")) , v_(upright("lr")) , d$ that had already featured before. Plugging the above into Eq.~#ref(<eq:uppslope>, supplement: none) and substituting the spectral flow weight function $W$ @eq:Wbound for its absolute value allows us to bound the maximum slope of $"tr" ( O rho ( x ) )$ when the Hamiltonian moves from $H ( x )$ to $H ( x + upright(d) hat(u) )$. Indeed,


$ |"tr"([O, D_(hat(u))(x)] rho(x))| lt.eq (sum_(i) || O_(i)||_(infinity)) sum_(p=0)^(d) C_(p) integral_(-infinity)^(infinity) |W_(gamma)(t)| |t|^(p) "d"t~ . $


To bound the resulting integral, we recall that $W_gamma ( t )$ obeys $sup_t | W_gamma ( t ) | = 1 / 2$, define $t^(*) = max ( upright(e)^4 , 7 ( d + 5 ) , theta ) / gamma$, and split up the integration into two parts, $t in [ - t^(*) , t^(*) ]$ and $t in.not [ - t^(*) , t^(*) ]$. Symmetry then ensures $  $


$ integral_(- oo)^oo upright(d) t | W_gamma ( t ) | | t |^p & lt.eq 1 / 2 integral_(- t^(*))^(t^(*)) upright(d) t | t |^p + 2 integral_(t^(*))^oo upright(d) t thin 35 upright(e)^2 ( gamma t )^4 upright(e)^(- 2 / 7 frac(gamma t, log ( gamma t )^2)) t^p\
 & = integral_0^(t^(*)) upright(d) t thin t^p + 70 upright(e)^2 gamma^(- p - 1) integral_(x = gamma t^(*))^oo upright(d) x thin x^(p + 4) upright(e)^(- 2 / 7 frac(x, log ( x )^2)) . $





The first integral is straightforward, and the second integral can be bounded using @lem:boundintua. Set $a = 2 / 7$, $k = p + 4$ and note that we have chosen $t^(*)$ such that all assumptions are valid.


Applying @lem:boundintua ensures $  $


$ integral_(- oo)^oo upright(d) t | W_gamma ( t ) | | t |^p upright(d) t & lt.eq frac(| t^(*) |^(p + 1), p + 1) + 70 upright(e)^2 gamma^(- p - 1) frac(2 k + 3, a) ( gamma t^(*) )^(2 k + 2) upright(e)^(- frac(2 gamma t^(*), 7 log ( gamma t^(*) )^2))\
 & = frac(| t^(*) |^(p + 1), p + 1) + 35 upright(e)^2 gamma^(- p - 1) 7 ( 2 p + 11 ) ( gamma t^(*) )^(2 p + 10) upright(e)^(- frac(2 gamma t^(*), 7 log ( gamma t^(*) )^2)) , $





for any integer $0 lt.eq p lt.eq d$. Inserting these bounds into the sum @eq:gap-aux1 implies


$ |"tr"([O, D_(hat(u))(x)] rho(x))| & lt.eq (sum_(i) || O_(i)||_(infinity)) sum_(p=0)^(d) C_(p) ( frac(|t^(*)|^(p+1), p+1) + 35 "e"^(2) gamma^(-p-1) 7(2p + 11) (gamma t^(*))^(2p + 10) "e"^(-frac(2 gamma t^(*), 7 log(gamma t^(*))^(2))) ) . $


Recall that $t^(*) = max ( upright(e)^4 , 7 ( d + 5 ) , theta ) / gamma$ is a constant that only depends on $d$ and $gamma$, and the $C_p$'s are also constants that depend on on $c_O , c_h , c_(upright("lr")) , c_d , a_(upright("lr")) , v_(upright("lr")) , d$. We may subsume all of these constant contributions in a new constant $c_(upright("all"))$ and conclude


$ |"tr"([O, D_(hat(u))(x)] rho(x))| lt.eq c_("all") (sum_(i) || O_(i)||_(infinity)) . $ <eq:TrODrho>


Inserting this uniform upper bound into Eq.~#ref(<eq:gradaverage>, supplement: none) completes the proof of @lem:truncatedFourier.






= SAMPLE COMPLEXITY LOWER BOUND FOR PREDICTING GROUND STATES
<app:proofthmlowerbound>


This section establishes an information-theoretic lower bound for the task of predicting ground state approximations. It highlights that, without further assumptions on the Hamiltonians, the training data size required in @thm:stateFourier is essentially tight.


#thmbox("theorem", "Theorem")[


Fix a prediction error tolerance $epsilon.alt$, a number $m$ of parameters, as well as constants $C , B > 0$ such that


$C / ( 9 epsilon.alt ) lt.eq m^0.99$. Consider a quantum ML model that learns from quantum data ${ x_ell arrow.r rho ( x_ell ) }_(ell = 1)^N$ of size $N$ to generate ground state predictions $hat(sigma) ( x )$, where $x in [ - 1 , 1 ]^m$. Suppose the quantum ML model can achieve


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) | "tr" ( O hat(sigma) ( x ) ) - "tr" ( O rho ( x ) ) |^2 lt.eq epsilon.alt , $


with high probability, for every class of Hamiltonians $H ( x )$ and for every observable $O$ given as a sum of local observables $sum_i O_i$ that obey $  $


$ bb(E)_(x tilde.op [-1, 1]^(m)) ||nabla_(x) "tr"(O rho(x))||_(2)^(2) lt.eq C quad "(smoothness condition)" . $ <eq:smthcond>

$ sum_(i) || O_(i)|| lt.eq B quad "(bounded norm)" . $ <eq:bddnormO>





Then, the (quantum) training data size must obey


$ N gt.eq B^2 m^(Omega ( C / epsilon.alt )) / log ( B ) . $<eq:lower-bound-appendix>


This is also a lower bound on quantum computational time associated with the quantum ML model.


] <thm:lowerboundsmooth-restatement>


The assumption $C / ( 9 epsilon.alt ) lt.eq m^0.99$ is required for technical reasons outlined below. It is equivalent to demanding that the prediction error tolerance is large enough compared to the inverse of $m$, i.e., $epsilon.alt gt.eq C / ( 9 m^0.99 )$. If the quantum ML model can achieve an even smaller prediction error, such that $"𝔼"_(x tilde [ - 1 , 1 ]^m) | "tr" ( O hat(sigma) ( x ) ) - "tr" ( O rho ( x ) ) |^2 < C / ( 9 m^0.99 )$, then we choose $epsilon.alt = C / ( 9 m^0.99 )$. For such a choice of $epsilon.alt$, the training data size lower bound becomes $N gt.eq B^2 m^(Omega ( m^0.99 )) / log ( B )$, which is exponential in $m^0.99$. Hence, in all cases, we need $epsilon.alt$ to be a constant for any (quantum or classical) machine learning algorithm to obtain a sample complexity that scales polynomially in $m$.


We prove @thm:lowerboundsmooth-restatement by means of an information-theoretic analysis. Conceptually, it resembles arguments developed in prior work @huang2021information (sample complexity lower bound for general quantum machine learning models). @sub:lowerboundsmooth-learning-problem formulates a learning problem that involves predicting ground state properties of a certain class of Hamiltonians. Subsequently, @sub:lowerboundsmooth-communication-protocol incorporates a hypothetical (quantum ML) solution to this learning problem as a decoding procedure in a communication protocol. Information-theoretic bottlenecks then beget fundamental restrictions on the sample complexity of any ML model that solves the learning problem, see @sub:lowerboundsmooth-analysis.


== Learning problem formulation
<sub:lowerboundsmooth-learning-problem>


We consider a family of single-qubit Hamiltonians, i.e.~$n = 1$, that is parametrized by $m$ degrees of freedom. We first map $x in [- 1 , 1]^m$ to a real number by evaluating a truncated Fourier series $f_a$. Fix a cutoff $Lambda = sqrt(C / ( 9 epsilon.alt ))$ and let


$ K_(Lambda)= | {k in bb(Z)^(m):med || k||_(2) lt.eq Lambda = sqrt(C/(9 epsilon))} | $ <eq:defLambda>


denote the number of $n$-dimensional wave-vectors with Euclidean norm at most $Lambda$. We equip each of these wave vectors $k$ with a sign $a_k in {plus.minus 1}$ and define the function


$ f_(a)(x) = sqrt(frac(9 epsilon, K_(Lambda))) sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) a_(k) cos ( pi k ⋯ x ), quad "where" quad a in { plus.minus 1 }^(K_(Lambda)), $ <eq:lowerboundsmooth-function>


subsumes all sign choices involved. We use this function to define a single-qubit Hamiltonian. For Pauli matrices $X$ and $Z$, we set


$ H_a ( x ) = exp (+ upright(i) / 2 arcsin (f_a ( x ) / B) X) (- Z) exp (- upright(i) / 2 arcsin (f_a ( x ) / B) X) , $<eq:lowerboundsmooth-hamiltonian>


where $B$ is a constant that will reflect the size of the target observable, see Eq.~#ref(<eq:bddnormO>, supplement: none). To summarize, each choice of $a in {plus.minus 1}^(K_Lambda)$ yields an entire class of single-qubit Hamiltonians $H_a ( x )$ that is parametrized by $m$-dimensional inputs $x in [- 1 , 1]^m$. These stylized Hamiltonians are simple enough to compute their (nondegenerate) ground state explicitly: $ rho_a ( x ) = | psi_a ( x ) chevron.r chevron.l psi_a ( x ) | quad upright("with") quad | psi_a ( x ) chevron.r = ( & cos ( 1 / 2 arcsin ( f_a ( x ) / B ) ) \
    & upright("i") sin ( 1 / 2 arcsin ( f_a ( x ) / B ) ) ) in bb(C)^2 . $<eq:lowerboundsmooth-ground-state> Finally, we fix the single-qubit observable $O$ to be a scaled version of Pauli $Y$. Setting $O = B Y$ yields a $1$-local observable. And, more importantly, $  $<eq:lowerboundsmooth-learning-problem>


$ "tr" (O rho_a ( x )) & = B chevron.l psi_a | Y | psi_a chevron.r = B (- upright(i) overline(chevron.l 0 | psi_a ( x ) chevron.r) chevron.l 1 | psi_a ( x ) chevron.r + upright(i) chevron.l 0 | psi_a ( x ) chevron.r overline(chevron.l 1 | psi_a ( x ) chevron.r))\
 & = 2 B cos (1 / 2 arcsin (f_a ( x ) / B)) sin (1 / 2 arcsin (f_a ( x ) / B))\
 & = B sin (arcsin (f_a ( x ) / B)) = f_a ( x ) . $





By construction, the expectation value $upright("tr") (O rho_a ( x ))$ exactly reproduces the function $f_a ( x )$ defined in Eq.~#ref(<eq:lowerboundsmooth-function>, supplement: none).


Being able to accurately predict it will be equivalent to accurately learning this function -- regardless of the underlying sign parameter $a in {plus.minus 1}^(K_Lambda)$.


To complete the formulation of the learning problem, we recall that the training parameters are sampled from the uniform distribution over the hypercube, $upright("Unif") [- 1 , 1]^m$, and that we will evaluate the expectation $"𝔼"$ over $x$ with respect to this distribution from now on. This choice of distribution implies a nice closed-form expression for the average squared distance of two functions $f_a , f_b$. For $a , b in {plus.minus 1}^(K_Lambda)$, $  $<eq:lowerboundsmooth-hamming>


$ bb(E)_(x) | f_(a) (x) - f_(b) (x) |^(2) & = frac(9 epsilon, K_(Lambda))sum_(k,l in bb(Z)^(m), || k||_(2),|| l||_(2) lt.eq Lambda) (a_(k)-b_(k))(a_(l)-b_(l)) integral_([-1,1]^(m))cos (pi k ⋯ x ) cos ( pi l ⋯ x )"d"^(m) x \
& = frac(9 epsilon, K_(Lambda))sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) ( a_(k) - b_(k) )^(2) \
& = frac(9 epsilon, K_(Lambda))sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda)4 times bold(1) { a_(k) eq.not b_(k) } \
& = frac(36 epsilon, K_(Lambda))d_(H) (a,b)~, $





where we have used orthonormality of the Fourier basis $cos ( pi k dot.op x )$, and $d_H ( a , b ) = sum_k upright(bold(1)) {a_k eq.not b_k}$ is the #emph[Hamming distance] on ${plus.minus 1}^(K_Lambda)$.


We conclude this expository section by examining whether the construction fulfills the requirement stated in the theorem and presenting a technical lemma. First of all, we have


$ || O|| = B || Y|| = B , $


which satisfies the bounded norm constraint in Eq.~#ref(<eq:bddnormO>, supplement: none). Furthermore, we can use the orthonormality of $cos ( pi k dot.op t )$ to find that


$ bb(E)_(x tilde.op [-1, 1]^(m)) ||nabla_(x) "tr"(O rho_(a)(x))||_(2)^(2) = frac(9 epsilon, K_(Lambda)) sum_(k in bb(Z)^(m): || k||_(2) lt.eq Lambda) || k||_(2)^(2) |a_(k)|^(2) lt.eq frac(9 epsilon, K_(Lambda)) K_(Lambda) Lambda^(2) = C . $


Thus the smoothness condition in Eq.~#ref(<eq:smthcond>, supplement: none) is also satisfied. Now, we turn our attention to the ground state~@eq:lowerboundsmooth-ground-state. The following technical lemma exposes the function $f_a ( x ) / B$ directly in the amplitudes of ground states.


#thmbox("lemma", "Lemma")[


Let $| psi_a ( x ) chevron.r$ be the ground state of Hamiltonian $H_a$ defined in Eq.~#ref(<eq:lowerboundsmooth-ground-state>, supplement: none). Then, $ rho_a ( x ) = | psi_a ( x ) chevron.r chevron.l psi_a ( x ) | = 1 / 2 ( & 1 + sqrt(1 - ( f_a ( x ) / B )^2) & - upright("i") f_a ( x ) / B \
    & upright("i") f_a ( x ) / B & 1 - sqrt(1 - ( f_a ( x ) / B )^2) ) . $<eq:lowerboundsmooth-ground-state2>


] <lem:lowerboundsmooth-groundstate>


#block[
#emph[Proof.] The proof is based on double-angle and half-angle trigonometric identities. Suppressing $x$ dependence, the first diagonal entry becomes $  $~◻

]


$ chevron.l 0 | rho_a | 0 chevron.r & = | chevron.l 0 | psi_a chevron.r |^2 = cos^2 (1 / 2 arcsin (f_a / B)) = 1 / 2 (1 + cos (arcsin (f_a / B)))\
 & = 1 / 2 (1 + sqrt(1 - sin^2 (arcsin (f_a / B)))) = 1 / 2 (1 + sqrt(1 - ( f_a / B )^2)) , $





and normalization implies that $chevron.l 1 | rho_a | 1 chevron.r = 1 - chevron.l 0 | rho_a | 0 chevron.r$.


The off-diagonal entries are $  $


$ overline(chevron.l 1 | rho_a | 0 chevron.r) & = chevron.l 0 | rho_a | 1 chevron.r = chevron.l 0 | psi_a chevron.r chevron.l psi_a | 1 chevron.r = - upright(i) cos (1 / 2 arcsin (f_a / B)) sin (1 / 2 arcsin (f_a / B))\
 & = - upright(i) / 2 sin (arcsin (f_a / B)) = - upright(i) / 2 f_a / B med . $









== Communication protocol
<sub:lowerboundsmooth-communication-protocol>


Consider the learning problem introduced in the previous section. Suppose that a quantum ML model can use training data $cal(T) = (x_ell , rho_a ( x_ell ))_(ell = 1)^N$ to learn a function $f^Q ( x )$ that (on average) predicts $upright("tr") (O rho_a ( x )) = f_a ( x )$ for a particular unknown $a in {plus.minus 1}^(K_Lambda)$, up to some accuracy $epsilon.alt$,


$ "𝔼"_x lr(|f^Q ( x ) - f_a ( x )|)^2 lt.eq epsilon.alt med . $


Such a model will not fare as well in estimating the expectation value associated with $b eq.not a$, whenever $b$ is sufficiently far away from $a$. Using the triangle inequality and Eq.~#ref(<eq:lowerboundsmooth-hamming>, supplement: none),


$ "𝔼"_x lr(|f^Q ( x ) - f_b ( x )|)^2 gt.eq "𝔼"_x lr(|f_a ( x ) - f_b ( x )|)^2 - "𝔼"_x lr(|f^Q ( x ) - f_a ( x )|)^2 gt.eq frac(36 epsilon.alt, K_Lambda) d_H ( a , b ) - epsilon.alt med . $


The model's accuracy significantly worsens at $d_H ( a , b ) > K_Lambda / 18$, where we recall $K_Lambda= | {k in bb(Z)^m: norm(k)_2 lt.eq Lambda } |$ from Eq.~#ref(<eq:defLambda>, supplement: none). In other words, a good quantum ML model would allow us to use training data $cal(T)$ in order to recover the underlying parameter $a in {plus.minus 1}^(K_Lambda)$ up to resolution $K_Lambda / 18$ in Hamming distance.


We can use this assertion as an effective decoding procedure in a two-way communication protocol involving Alice and Bob. To accommodate imperfect resolution, Alice and Bob agree on a dictionary of sign vectors $(a^(( 1 )) , dots.h , a^(( M ))) subset {plus.minus 1}^(K_Lambda)$ whose pairwise Hamming distance is large enough: $d_H ( a_i , a_j ) > K_Lambda / 18$ for all $i eq.not j$. Let $M$ denote the cardinality of this dictionary. Alice and Bob use this dictionary and the ML procedure to transmit integers up to size $M$ over a quantum channel. Alice samples an integer $j in (1 , dots.h , M)$ and sets $a = a^(( j )) in {plus.minus 1}^(K_Lambda)$. Subsequently, she uses $a$ to generate (quantum) training data $cal(T) = (( x_ell , rho_a ( x_ell ) ))_(ell = 1)^N$ with $x_1 , dots.h , x_N tilde upright("Unif") [- 1 , 1]^m$ which she passes on to Bob. Subsequently, Bob uses $cal(T)$ to train a quantum ML model to predict the underlying function $"tr" (O rho_a ( x )) = f_a ( x )$. By checking $"𝔼"_x lr(|f_(macron(a)) ( x ) - f^Q ( x )|)^2 lt.eq epsilon.alt$ for every possible dictionary element $macron(a)$, he will retrieve the correct message with high probability, i.e., $macron(a) = a$.


This is a protocol that conveys classical information via a quantum dataset. It is subject to fundamental constraints from information theory. These will allow us to deduce a lower bound on the required training data size $N = | cal(T) |$. An important figure of merit in this argument is the cardinality $M$ of the dictionary. That is, the number of different integers that can be communicated. The larger $M$, the more powerful the communication protocol, and following result, sometimes attributed to Gilbert and Varshamov @gilbert1952comparison, is a lower bound on how many bits one can "pack" into the space of $L$-bit strings while maintaining the required distance.


#thmbox("lemma", ([Lemma], [(Lemma 5.12 in #cite(<rigollet201518>))]))[


There exists a dictionary $(a^(( 1 )) , dots.h , a^(( M ))) in {plus.minus 1}^(K_Lambda)$ of cardinality $M gt.eq floor.l exp (K_Lambda / 32) floor.r$ that achieves $d_H (a^(( i )) , a^(( j ))) gt.eq K_Lambda / 4$ whenever $i eq.not j$.


] <lem:dictionary>


== Information-theoretic analysis
<sub:lowerboundsmooth-analysis>


Let us now take a closer look at the communication protocol introduced above by bounding the correlation between Alice's original randomly chosen message $a$ and Bob's decoded signal $macron(a)$. Up to now, we have stablished the following. Per the bound in @lem:dictionary, the dictionary of available $a$'s can be chosen to be rather large: $M = floor.l exp (K_Lambda / 32) floor.r$. Moreover, the existence of a good quantum ML procedure, in the sense of @thm:lowerboundsmooth-restatement, ensures that $macron(a) = a$ with high probability.


Correlations between Alice's and Bob's variables are quantified by the (classical) mutual information


$ I ( a : macron(a) ) gt.eq Omega (log ( M )) = Omega ( K_Lambda ) , $<eq:lowerboundsmooth-aux1>


which we have bounded from below using Fano's inequality @yu1997assouad. Our task now is to provide an upper bound on $I ( a : macron(a) )$, in terms of $N , B$ and $epsilon.alt$, in order to relate those parameters to $K_Lambda$ and obtain the desired result in @thm:lowerboundsmooth-restatement.


Since the parameters $x_1 , dots.h , x_N$ are sampled independently from $a$, we have $I ( a : x_1 , dots.h , x_N ) = 0$ and $a |_(x_1 , dots.h , x_N) = a$. Therefore, we can upper bound the mutual information as follows, $  $<eq:mutual-information0>


$ I (a : macron(a)) & lt.eq I (a : macron(a) , x_1 , dots.h , x_N)\
 & = I (a : x_1 , dots.h , x_N) + I (a : macron(a) | x_1 , dots.h , x_N)\
 & = I (a : macron(a) | x_1 , dots.h , x_N)\
 & = "𝔼"_(x_1 , dots.h , x_N) I (a |_(x_1 , dots.h , x_N) : macron(a) |_(x_1 , dots.h , x_N))\
 & = "𝔼"_(x_1 , dots.h , x_N) I (a : macron(a) |_(x_1 , dots.h , x_N)) med , $<eq:xarerandomvar>





where $Q |_x$ denotes the random variable $Q$ conditioned on the random variable $x$.


Next, recall that Bob reconstructs the classical $macron(a)$ by performing quantum operations on the training data $cal(T) = (( x_ell , rho_a ( x_ell ))_(ell = 1)^N$. For each instance of randomly chosen parameters $x_1 , dots.h , x_N tilde upright("Unif") [ - 1 , 1 ]^m$, Bob performs a quantum measurement on the state $⨂_(ell = 1)^N rho_a ( x_ell )$ and uses the measurement outcomes to reconstruct $macron(a)$. Bob's procedure is equivalent to performing the quantum ML algorithm that we have been promised in Sec.~#ref(<sub:lowerboundsmooth-communication-protocol>, supplement: none). Thus we can use Holevo's theorem @holevo\[@wildebook, Sec.~11.6.1\] to write


$ I (a : macron(a) |_(x_1 , dots.h , x_N)) lt.eq chi (a : ⨂_(ell = 1)^N rho_a (x_ell) |_(x_1 , dots.h , x_N)) med , $<eq:mutual-information>


where the Holevo information $chi$ quantifies correlations between a random variable $z$ and a quantum state $rho_z$,


$ chi ( z : rho_z ) = S ("𝔼"_z rho_z) - "𝔼"_z S ( rho_z ) med , $<eq:holevo>


and $S ( rho ) = - "tr" ( rho log rho )$ is the von Neumann entropy. In other words, for each instance of parameters, the correlation between $a$ and $macron(a)$ is bounded by the Holevo information of Bob's ensemble of quantum states.


Next, we use the subadditivity of von Neumann entropy, $S ( "𝔼"_z rho_z ⊗ sigma_z ) lt.eq S ( "𝔼"_z rho_z ) + S ( "𝔼"_z sigma_z )$, and the additivity of entropy for independent systems, $S ( rho ⊗ sigma ) = S ( rho ) + S ( sigma )$, to obtain


$ chi (a : ⨂_(ell = 1)^N rho_a (x_ell) |_(x_1 , dots.h , x_N)) lt.eq sum_(ell = 1)^N chi (a : rho_a (x_ell) |_(x_1 , dots.h.c , x_N)) med . $<eq:subadd>


Plugging Eqs.~(@eq:mutual-information) and (@eq:subadd) into Eq.~(@eq:mutual-information0) and using the fact that $rho_a ( x_ell )$ is independent to $x_(ell')$ for any $ell' eq.not ell$, we obtain $  $


$ I (a : macron(a)) & lt.eq sum_(ell = 1)^N "𝔼"_(x_1 , dots.h.c , x_N) chi (a : rho_a (x_ell) |_(x_1 , dots.h.c , x_N))\
 & = sum_(ell = 1)^N "𝔼"_(x_ell) chi (a : rho_a (x_ell) |_(x_ell))\
 & = N "𝔼"_x chi (a : rho_a (x)) med . $





The last equality follows from the fact that each $( x_ell , rho_a ( x_ell ) )$ is generated independently and in an identical fashion for all $ell = 1 , dots.h , N$.


We have thus reduced the problem of bounding the correlations between classical variables $a$ and $macron(a)$ to that of bounding the Holevo information of the ensemble of states $rho_a$ --- a much simpler problem because $rho_a$ is a two-by-two matrix. In @lem:technical-bound at the end of section, we obtain the bound


$ "𝔼"_x chi (a : rho_a ( x )) lt.eq frac(9 epsilon.alt, 4 B^2) log (frac(4 upright(e) B^2, 9 epsilon.alt)) med . $<eq:technical-bound>


Using this bound, the first claim in @thm:lowerboundsmooth-restatement readily follows, provided that we are allowed to choose


$ K_Lambda = m^(Omega ( C / epsilon.alt )) med . $<eq:assumption>


This assumption, combined with Eqs.~(#ref(<eq:lowerboundsmooth-aux1>, supplement: none)--#ref(<eq:technical-bound>, supplement: none)) ensures that


$ N frac(9 epsilon.alt, 4 B^2) log (frac(4 upright(e) B^2, 9 epsilon.alt)) gt.eq Omega ( K_Lambda ) = m^(Omega ( C / epsilon.alt )) quad upright("which implies") quad N gt.eq frac(B^2 m^(Omega ( C / epsilon.alt )), log ( B )) . $


Because the quantum ML has to process quantum training data of size $N gt.eq frac(B^2 m^(Omega ( C / epsilon.alt )), log ( B ))$, the runtime of the quantum ML has to be lower bounded by that amount as well.


Let us now verify the assumption (@eq:assumption) on the number of Fourier modes $K_Lambda$ available for estimating the quantum state. While we have already determined that $K_Lambda lt.eq m^(cal(O) ( C / epsilon.alt ))$ in Eq.~(#ref(<eq:numklambda>, supplement: none)), here we need a lower bound. We utilize the assumption that $C / ( 9 epsilon.alt ) lt.eq m^0.99$, which implies $⌊C / ( 9 epsilon.alt )⌋ lt.eq m^0.99$. To establish Eq.~(@eq:assumption), we restrict our attention to binary wavevectors $k in (0 , 1)^m$, such that the number of ones is exactly equal to $floor.l C / ( 9 epsilon.alt ) floor.r$. Clearly, every such wavevector obeys $norm(k)_2 lt.eq sqrt{C/(9epsilon)}$, so the number of such wavevectors lower bounds $K_Lambda$. This observation, along with some combinatorics, yields $  $


$ K_Lambda & gt.eq | { k in (0 , 1)^m : #h(0em) sum_(j = 1)^m k_j = floor.l C / ( 9 epsilon.alt ) floor.r } |\
 & = binom(m, floor.l C / ( 9 epsilon.alt ) floor.r) gt.eq frac(m^(floor.l C / ( 9 epsilon.alt ) floor.r), ( floor.l C / 9 epsilon.alt floor.r )^(floor.l C / ( 9 epsilon.alt ) floor.r))\
 & = m^(floor.l C / ( 9 epsilon.alt ) floor.r - ( floor.l C / 9 epsilon.alt floor.r ) log ( floor.l C / ( 9 epsilon.alt ) floor.r ) / log ( m )) gt.eq m^(0.01 floor.l C / ( 9 epsilon.alt ) floor.r) = m^(Omega ( C / epsilon.alt )) . $





We now prove the upper bound (@eq:technical-bound) on the mutual information. It follows from analyzing the ground state representations provided by @lem:lowerboundsmooth-groundstate.


#thmbox("lemma", "Lemma")[


The learning problem from @sub:lowerboundsmooth-learning-problem is set up to obey


$ "𝔼"_(x tilde upright("Unif") [ - 1 , 1 ]^m) chi (a : rho_a ( x )) lt.eq frac(9 epsilon.alt, 4 B^2) log (frac(4 upright(e) B^2, 9 epsilon.alt)) . $


] <lem:technical-bound>


#block[
#emph[Proof.] Using the definition (@eq:holevo) of the Holevo information and the von Neumann entropy, $  $~◻

]


$ "𝔼"_(x tilde upright("Unif") \[ - 1 , 1 \]^m) chi (a : rho_a ( x )) & = "𝔼"_x ["𝔼"_a \[ "tr" ( rho_a ( x ) log rho_a ( x ) ) \] - "tr" (("𝔼"_a rho_a ( x )) log ("𝔼"_a rho_a ( x )))]\
 & = - "𝔼"_x "tr" [("𝔼"_a rho_a ( x )) log ("𝔼"_a rho_a ( x ))] med . $<eq:Isxrho>






The second equality follows from the fact that $rho_a ( x )$ is a pure state, so we have $"tr" ( rho_a ( x ) log rho_a ( x ) ) = 0$. We also consider $"𝔼"_x$ to be $"𝔼"_(x tilde upright("Unif") [ - 1 , 1 ]^m)$.


Recalling @lem:lowerboundsmooth-groundstate yields


$ "𝔼"_a rho_a ( x ) = 1 / 2 "𝔼"_a mat(delim: "(", 1 + sqrt(1 - ( f_a ( x ) / B )^2), - upright(i) f_a ( x ) / B; upright(i) f_a ( x ) / B, 1 - sqrt(1 - ( f_a ( x ) / B )^2); #none) . $


The eigenvalues $lambda_plus.minus$ of $"𝔼"_a rho_a ( x )$, like those of any two-by-two matrix, can be expressed in terms of the trace and determinant. Using the formula for the eigenvalues and evaluating the trace and determinant yield $  $


$ lambda_plus.minus & = 1 / 2 "tr" ["𝔼"_a rho_a ( x )] plus.minus 1 / 2 sqrt(("tr" ["𝔼"_a rho_a ( x )])^2 - 4 det ["𝔼"_a rho_a ( x )])\
 & = 1 / 2 plus.minus 1 / 2 sqrt(("𝔼"_a f_a ( x ))^2 / B^2 + ("𝔼"_a sqrt(1 - f_a ( x )^2 / B^2))^2) med . $





We will use following lower bound for $lambda_(+)$


$  $


$ lambda_(+) & gt.eq 1 / 2 + 1 / 2 "𝔼"_a sqrt(1 - f_a ( x )^2 / B^2)\
 & gt.eq 1 / 2 + 1 / 2 ( 1 - "𝔼"_a f_a ( x )^2 / B^2 )\
 & = 1 - 1 / 2 "𝔼"_a f_a ( x )^2 / B^2 gt.eq 1 / 2 . $





The first inequality follows from dropping the term $( "𝔼"_a f_a ( x ) )^2 / B^2$.


The second inequality follows from the fact that $sqrt(1 - z) gt.eq 1 - z$ for all $z in [ 0 , 1 ]$.


We now proceed to bounding the von Neumann entropy of $"𝔼"_a rho_a ( x )$, $  $


$ - "tr" (("𝔼"_a rho_a ( x )) log ("𝔼"_a rho_a ( x ))) & = - lambda_(+) log lambda_(+) - lambda_(-) log lambda_(-) = H ( lambda_(+) )\
 & lt.eq H (1 - 1 / 2 "𝔼"_a f_a ( x )^2 / B^2)\
 & = H (1 / 2 "𝔼"_a f_a ( x )^2 / B^2)\
 & equiv H ( g ( x ) ) lt.eq g ( x ) log ( upright(e) / g ( x ) ) med , $<eq:intrhocalc>






where $H ( x ) = - x log x - ( 1 - x ) log ( 1 - x )$ is the binary entropy, and $g ( x ) = 1 / 2 "𝔼"_a f_a ( x )^2 / B^2$.


The first inequality follows from the fact that $H ( x ) lt.eq H ( x' )$ for all $1 / 2 lt.eq x' lt.eq x$. Going back to Eq.~#ref(<eq:Isxrho>, supplement: none), $  $


$ "𝔼"_x chi (a : rho_a ( x ) | x) & = - "𝔼"_x "tr" [("𝔼"_a rho_a ( x )) log ("𝔼"_a rho_a ( x ))]\
 & lt.eq "𝔼"_x \[ g ( x ) log ( upright(e) / g ( x ) ) \]\
 & lt.eq ("𝔼"_x g ( x )) log (frac(upright(e), "𝔼"_x g ( x )))\
 & = frac("𝔼"_(x , a) f_a ( x )^2, 2 B^2) log (frac(2 upright(e) B^2, "𝔼"_(x , a) f_a ( x )^2)) . $<eq:finishing>





The first inequality follows from Eq.~#ref(<eq:intrhocalc>, supplement: none). The second inequality follows Jensen's inequality and the fact that $z log ( upright(e) / z )$ is concave for all $z gt.eq 0$.


Orthogonality of the $cos ( pi k dot.op x )$ terms in $f_a$ @eq:lowerboundsmooth-function yields


$ bb(E)_(x,a) f_(a)(x)^(2) = frac(1, 2) times frac(9 epsilon, L) sum_(k in bb(Z)^(m), || k||_(2) lt.eq Lambda) bb(E)_(a) |a_(k)|^(2) = frac(9 epsilon, 2) . $


Plugging the above into Eq.~#ref(<eq:finishing>, supplement: none), we obtain the advertised bound.






= COMPUTATIONAL HARDNESS FOR NON-ML ALGORITHMS TO PREDICT GROUND STATE PROPERTIES
<sec:proofhardnonML>


== NP-hardness for estimating one-body observables in the ground state of 2D Hamiltonians
<sec:proofhardnonML1>


We begin by showing that the task of estimating one-body observables in the ground state of any smooth class of two-dimensional Hamiltonians with a constant spectral gap is NP-hard. The task is hard even if we consider the computation to yield a small error averaged over the smooth class of Hamiltonians.


// [figvision] imgs/planarrect3SAT.png
// Panel a: This is a schematic diagram showing a planar rectilinear 3SAT problem. The objects are nodes
// representing Boolean variables (red circles labeled X, Y, Z, S, T, W) and clauses (green circles labeled C, D,
// E, F), and lines representing connections between them. There are 6 red nodes and 4 green nodes. The trend
// shows how clauses are connected to variables. Panel b: This is not present. Panel c: This is not present,
// however, there is a key at the top right which shows two types of terms: a two-body term on a path represented
// by a gray box with two gray circles and a three-body term for each clause represented by a green box with
// three gray circles. The main diagram on the right is a schematic diagram showing a Qubit Hamiltonian on a 2D
// grid. The grid has grey circles at each intersection representing qubits, with some labeled with letters (X,
// Y, Z, S, T, W). There are grey boxes around pairs of qubits representing two-body terms and green boxes around
// three qubits representing three-body terms for each clause. The trend shows how clauses and variables are
// mapped onto the grid.
#figure(image("imgs/planarrect3SAT.png", width: 100.0%),
  caption: [
    Reduction of planar rectilinear 3SAT (#smallcaps[left]) to a qubit Hamiltonian on a 2D grid (#smallcaps[right]). Each pair $( i , j )$ of nearby grid points on a path (originating from variable $X , Y , Z , S , T , W$) contains a two-body local term $- Z_i Z_j$ (illustrated by boxes with gray stroke). Each clause $( C , D , E , F )$ corresponds to a three-body local term that imposes the Boolean constraint, e.g., $X or Z or S$ would correspond to $- sum_(x , z , s in ( 0 , 1 )) bb(1) [ x or z or s = 1 ] dot.op | x chevron.r chevron.l x | ⊗ | z chevron.r chevron.l z | ⊗ | s chevron.r chevron.l s |$. Every empty grid point (the irrelevant qubits) contain a single body term $- Z_i$.
  ]
)
<fig:planarrect3SAT>



#thmbox("proposition", ([Proposition], [(Detailed restatement of #ref(<thm:hardnonML>); a variant of Lemma 1.4 in #cite(<abrahamsen2020sub>))]))[


Consider a randomized polynomial-time classical algorithm $cal(A) ( H , i , r )$ whose inputs are the description of a Hamiltonian $H$, an index $i$ that enumerates the qubits in the Hamiltonian, and a random bit string $r$. Suppose that for any smooth class of Hamiltonians on a two-dimensional grid with a spectral gap $gt.eq 1$ and a unique ground state,


$ H ( x ) = sum_a h_a ( x ) thin thin thin upright("with") thin thin rho ( x ) thin thin upright(": the ground state of") thin thin H ( x ) , $


where $x in [ - 1 , 1 ]^m$ is a parameter and $h_a ( x )$ is a three-qubit geometrically-local observable, and for each one-body Pauli-Z observable $Z_i$, the randomized classical algorithm $cal(A)$ outputs $cal(A) ( H , i , r )$ that approximates $"tr" ( Z_i rho ( x ) )$ up to an average error $"𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"𝔼"_r cal(A) ( H , i , r ) - "tr" ( Z_i rho ( x ) )|) lt.eq 1 / 4 .$ Then $upright("RP") = upright("NP")$.


] <prop:phaseclassification-app>


#block[
#emph[Proof.] From standard results in complexity theory @Lichtenstein1982PlanarFA @knuth1992problem @VALIANT198685, it is known that if there is a randomized polynomial-time classical algorithm that can find the solution for any planar rectilinear 3SAT problem with a unique solution with probability at least $1 / 2$, then $upright("RP") = upright("NP")$. ($upright("RP")$, also known as Randomized Polynomial Time, is the class of decision problems such that there is a polynomial-time randomized classical algorithm that outputs YES with probability at least 1/2 when the correct answer is YES, and outputs NO with probability one when the correct answer is NO. RP is contained in BPP, the class of decision problems that can be solved efficiently by a randomized classical computer.) The planar rectilinear 3SAT problem is a constrained version of 3SAT, where all the Boolean variables $x_1 , dots.h , x_n$ are vertices on the $x$-axis and all the clauses containing three variables are vertices that lie above or below the $x$-axis. Each clause is connected by an edge to each of the the variables that the clause contains. The vertices and the edges form a planar graph; see @fig:planarrect3SAT (left) for an illustration.~◻

]


We can embed such a planar graph in a two-dimensional grid with a single qubit on each grid point; see @fig:planarrect3SAT (right) for an illustration of the embedding. First, we distinguish between the variable vertices and the clause vertices in the planar graph. Variable vertices lie on the $x$-axis of the two-dimensional qubit grid, and clause vertices lie above or below the $x$-axis. Edges of the planar graph become embedded paths on the the 2D grid connecting clause vertices to variable vertices. Because the original graph is planar, we can ensure that the paths corresponding to each edge on the planar graph do not overlap (except when they terminate at the same variable) by choosing a large enough spacing between the variable vertices on the $x$-axis. For each path on the 2D grid, we add a $- Z_i Z_j$ term to the Hamiltonian for every pair of nearest neighbors along the path. The two body $- Z_i Z_j$ term ensures that, in the unique ground state, the qubits on the path must be either all $| 0 chevron.r$'s or all $| 1 chevron.r$'s. Then, for every clause vertex on the planar graph, we add a three-body geometrically-local term (diagonal in the $Z$-basis) to the Hamiltonian enforcing that in the ground state the endpoints of the three corresponding paths satisfy the Boolean constraint of the corresponding clause. For example, the Boolean clause $X or Z or S$ would correspond to the three body local term $- sum_(x , z , s in ( 0 , 1 )) bb(1) [ x or z or s = 1 ] dot.op | x chevron.r chevron.l x | ⊗ | z chevron.r chevron.l z | ⊗ | s chevron.r chevron.l s |$, where $bb(1) [ A ]$ is $1$ if $A$ is true and $0$ otherwise. The qubits on paths are called the "relevant" qubits, and the rest of the qubits are called "irrelevant." We add a $- Z_i$ term to the Hamiltonian for all the irrelevant qubits, fixing these qubits to be $| 0 chevron.r$ in the ground state.


Moreover, the eigenstates of the Hamiltonian are computational basis states, because all the local terms are diagonal in the $Z$-basis. We can also see that there are no terms connecting the relevant and irrelevant qubits, hence the ground state space of the constructed Hamiltonian must be the tensor product of the ground state space for the relevant qubits and the ground state space for the irrelevant qubits. The unique ground state for the irrelevant qubits is the all-zero state $| 0 chevron.r ⊗ dots.h ⊗ | 0 chevron.r$ due to the $- Z_i$ term. Because the original planar rectilinear 3SAT problem has a unique solution, the ground state for the relevant qubits is also unique. We denote the ground state by $| b chevron.r chevron.l b | , b in ( 0 , 1 )^n , $ where $n$ is the total number of qubits in the two dimensional grid. In this ground state, all variable vertices are fixed at the values that solve the 3SAT problem. Furthermore, because all eigenvalues of the Hamiltonian are integers, the spectral gap is at least one.


Let us define $sum_a h_a$ to be the Hamiltonian constructed from a planar rectilinear 3SAT problem. Note that $h_a$ is diagonal in the $Z$-basis and acts on at most three geometrically-local qubits. We define a trivial class of two-dimensional Hamiltonians with a spectral gap $gt.eq 1$,


$ H ( x ) = sum_a h_a ( x ) = sum_a h_a = H , $


where $x in [ - 1 , 1 ]^m$ is the parameter, and $H ( x )$ does not depend on $x$. Let $rho ( x )$ be the unique ground state of $H ( x )$. We have $rho ( x ) = | b chevron.r chevron.l b | , b in ( 0 , 1 )^n , $ where $b$ encodes the solution to the planar rectilinear 3SAT problem.


We apply the randomized classical algorithm to provide estimates for all the expectation values of Pauli-$Z$ observables in the ground state space $rho ( x )$ of $H ( x )$. Let $cal(A)$ be the randomized classical algorithm. By the assumption that the randomized classical algorithm could output an estimate of $"tr" ( Z_i rho ( x ) )$ up to an additive error $1 / 4$ averaged uniformly over $x in [ - 1 , 1 ]^m$, we have


$ "𝔼"_(x tilde [ - 1 , 1 ]^m) lr(|"𝔼"_r cal(A) ( H ( x ) , i , r ) - "tr" ( Z_i rho ( x ) )|) lt.eq 1 / 4 , quad forall i = 1 , dots.h , n . $


Using Jensen's inequality, we have the following bound,


$ lr(|"𝔼"_(x tilde [ - 1 , 1 ]^m) "𝔼"_r cal(A) ( H ( x ) , i , r ) - "𝔼"_(x tilde [ - 1 , 1 ]^m) "tr" ( Z_i rho ( x ) )|) lt.eq 1 / 4 , quad forall i = 1 , dots.h , n . $


We can see that $bb(E)_(x tilde [-1, 1]^m) op("tr")(Z_i rho(x)) = ⟨b_i| Z_i |b_i⟩,$ where $b_i$ is the $i$-th bit in the $n$-bit string $b$ that encodes the solution to the planar rectilinear 3SAT problem.


We sample random $x$ uniformly from $[ - 1 , 1 ]^m$ and sample the random string $r$, obtaining the output value $cal(A) ( H ( x ) , i , r )$ using the randomized classical algorithm $cal(A)$. As a result of the above analysis, by sampling $cal(O) ( log ( n ) )$ times and computing the average over the output $cal(A) ( H ( x ) , i , r )$, we can obtain an estimate for $⟨b_i| Z_i |b_i⟩$ up to an additive error $1 / 2$ with probability at least $1 - frac(1, 2 n)$, where $n$ is the total number of qubits in the 2D grid.


Because $⟨b_i| Z_i |b_i⟩ in (-1, 1)$, an estimate for $⟨b_i| Z_i |b_i⟩$ up to an additive error $1 / 2$ allows us to obtain $b_i in ( 0 , 1 )$. Using the union bound, with probability at least $1 / 2$, we can obtain $b_i$, for all $i = 1 , dots.h , n$. This implies that we can obtain the bit string $b$ with probability at least $1 / 2$.


Hence, we can use the randomized classical algorithm $cal(A)$ to find the unique solution for the planar rectilinear 3SAT problem with probability at least $1 / 2$. Therefore, RP$=$NP if such an algorithm exists.






We remark that a similar argument still applies if we replace the constant Hamiltonian $H ( x )$ considered above by a suitably chosen class of Hamiltonians $( H ( x ) = H : x in [ - 1 , 1 ]^m )$ with nontrivial dependence on $x$.


For example, we can consider $H ( x ) = sum_a h_a ( x ) = sum_a (U_1 ( x_1 ) ⊗ dots.h ⊗ U_n ( x_n )) h_a (U_1 ( x_1 ) ⊗ dots.h ⊗ U_n ( x_n ))^dagger$, where $n$ is the number of qubits in the Hamiltonian, $U_i ( x_i ) = exp ( - upright(i) ( pi / 4 ) X_i x_i )$ is a single-qubit rotation, $X_i$ is the Pauli-$X$ matrix on the $i$-th qubit, and $m = n$. It is not hard to see that $h_a ( x )$ still acts on at most three geometrically-local qubits. Furthermore, one can adapt the proof to show that predicting ground state properties averaged over $x$ for this nonconstant class of Hamiltonians is still hard.


== Computational hardness for a class of Hamiltonians based on factoring
<sec:factoringH>


@thm:mainFourier and @prop:phaseclassification-app together implies that an NP-hard problem could be solved by performing single-qubit measurements on a modest number of copies of the ground state of a two-dimensional local Hamiltonian, and then performing an efficient classical computation with the measurement outcomes as input. We may therefore conclude that, in hard instances, the preparation of the ground state is itself an NP-hard task. Because we do not expect any NP-hard task to be performed efficiently in the physics lab, or in any other physically realizable process, @prop:phaseclassification-app does not usefully characterize the computational power of data under realistic conditions.


In contrast, it is reasonable to expect that simple measurements performed on quantum states that are efficiently prepared by quantum computers, combined with classical processing, suffice for solving computational problems that are beyond the reach of classical processing alone. Indeed, proposals for using variation quantum eigensolvers to study quantum chemistry and materials @peruzzo2014variational @mcclean2016theory are motivated by this expectation. @thm:mainFourier is of potential practical interest for a class of Hamiltonians ${ H ( x ) }$ such that the ground state of $H ( x )$ can be prepared efficiently by a feasible quantum process, yet cannot be efficiently prepared classically.


The rest of this subsection outlines a stylized example that illustrates this idea. Leveraging the efficient quantum algorithm for factoring large numbers, and the assumption that factoring is classically hard, we construct a smooth class of local Hamiltonians whose ground states are easy to prepare quantumly, such that expectation values of one-local observables can be learned efficiently from training data, yet are hard to learn by any classical procedure without access to data.


The first step is to construct two-dimensional Hamiltonians such that computing expectation values of one-local observables in the ground state is equivalent to solving a factoring problem. This can be done by noting a series of well-known facts in complexity theory.

+ The following task is expected to be hard for classical computers. Given a $n$-bit number $R$ guaranteed to be a product of two prime numbers $p < q$, find $p , q$. When $R$ is large, all known classical algorithms scale superpolynomially with $n$. Solving this problem suffices to break the RSA encryption @rivest1978method.

+ We can represent $p , q$ using at most $2 n$ binary variables (bits), and we can write down a propositional formula for these $2 n$ variables, which corresponds to a logical circuit that computes the multiplication of $p , q$ and checks if the product equals $R$. The propositional formula can be written without any additional Boolean variable. This yields a SAT problem with $2 n$ Boolean variables whose unique solution is equal to the two prime numbers $p , q$.

+ A SAT problem with a unique solution can be efficiently mapped to a 3SAT problem with a unique solution; see @kozen1992design.

+ A 3SAT problem with a unique solution can be efficiently mapped to a planar rectilinear 3SAT problem with a unique solution; see @Lichtenstein1982PlanarFA @knuth1992problem.

+ A planar rectilinear 3SAT problem with a unique solution can be efficiently mapped to a two-dimensional 3-local Hamiltonian with a spectral gap of one and a unique ground state, such that estimating one-local observables in the ground state of the Hamiltonian to a constant error with a constant probability is sufficient to find the unique solution for the planar rectilinear 3SAT problem; see the proof of @prop:phaseclassification-app.

We now focus on any smooth class of two-dimensional Hamiltonians $H^(upright("RSA")) ( x )$ with a constant spectral gap such that there exists $x^(upright("RSA")) in [ - 1 , 1 ]^m$ such that $H^(upright("RSA")) ( x^(upright("RSA")) )$ can be written as a two-dimensional Hamiltonian that is mapped from a factoring problem. We refer to such a class of Hamiltonians as an RSA-based two-dimensional gapped Hamiltonian class.


For any RSA-based Hamiltonian class $H^(upright("RSA"))$, we can efficiently obtain the training data from a quantum experiment. We first prepare the ground state for $H^(upright("RSA")) ( x^(upright("RSA")) )$ by applying Shor's algorithm. Then we can adiabatically evolve the ground state for $H^(upright("RSA")) ( x^(upright("RSA")) )$ to obtain the ground state for $H^(upright("RSA")) ( x ) , forall x in [ - 1 , 1 ]$ due to the existence of a constant spectral gap @aharonov2008adiabatic @wan2020fast. Hence, according to @thm:mainFourier, for any RSA-based Hamiltonian class, a classical ML algorithm trained from data obtained in quantum experiments can predict efficiently expectation values of one-local observables in the ground state. In contrast, a classical algorithm that does not learn from training data is unable to efficiently estimate 1-body observables in the ground state, assuming that RSA encryption can not be broken by classical computers.


= NO OBSERVABLE CAN CLASSIFY TOPOLOGICAL PHASES
<sec:no-nonlocal-obs>


Recall that ground states of two Hamiltonians are in the same topological phase if there exists a constant-depth geometrically-local quantum circuit that can transform one state to another @zeng2019quantum. The goal of this section is to establish the following proposition.


#thmbox("proposition", "Proposition")[


Consider two distinct topological phases $A$ and $B$ (one of the phases could be the trivial phase). No observable $O$ exists such that


$ "tr" ( O rho ) > 0 , forall rho in upright("phase A") , quad quad "tr" ( O rho ) lt.eq 0 , forall rho in upright("phase B") . $


]


#block[
#emph[Proof.] We consider depth-$1$ quantum circuits consisting of single-qubit unitaries $U_1 , dots.h , U_n$. We let $| psi_A chevron.r , | psi_B chevron.r$ be the signature quantum state for phase $A$ and $B$. Suppose there is an observable such that~◻

]


$ "tr" ( O rho ) > 0 , forall rho in upright("phase A") , quad quad "tr" ( O rho ) lt.eq 0 , forall rho in upright("phase B") . $


Then, by definition, we have $  $


$ chevron.l psi_A | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_A chevron.r & > 0 , forall U_1 , dots.h , U_n in U ( 2 ) ,\
chevron.l psi_B | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_B chevron.r & lt.eq 0 , forall U_1 , dots.h , U_n in U ( 2 ) , $





However, from @lem:noobserU1...Un, no such observable exists. Hence no observable exists that can be used to classify two topologically ordered phases.






The key lemma utilized in the above proof is the following.


#thmbox("lemma", "Lemma")[


For any two $n$-qubit states $| psi_1 chevron.r , | psi_2 chevron.r$, no observable $O$ exists such that $  $


$ chevron.l psi_1 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_1 chevron.r & > 0 , forall U_1 , dots.h , U_n in U ( 2 ) ,\
chevron.l psi_2 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_2 chevron.r & lt.eq 0 , forall U_1 , dots.h , U_n in U ( 2 ) , $<eq:psi1condition>





where $U ( 2 )$ is the unitary group of $2 times 2$ unitary matrices.


] <lem:noobserU1...Un>


#block[
#emph[Proof.] We will prove this result by contradiction. Assume the existence of an observable $O$ such that Eq.~#ref(<eq:psi1condition>, supplement: none)~and~@eq:psi1condition both hold. Consider $U_1 , dots.h , U_n$ to be independent random matrices that follows the Haar measure on the unitary group $U ( 2 )$. Then using the identity for the first order moment of Haar integration,~◻

]


$ "𝔼"_(U tilde upright("Haar") ( U ( d ) )) U X U^dagger = "tr" ( X ) bb(I) / d , $


we can obtain the following identity,


$ "𝔼"_(U_1 , dots.h , U_n tilde upright("Haar") ( U ( 2 ) )) [( U_1 ⊗ dots.h ⊗ U_n ) | psi_1 chevron.r chevron.l psi_1 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger )] = "tr" ( | psi_1 chevron.r chevron.l psi_1 | ) bb(I) / 2^n = bb(I) / 2^n . $<eq:depolarizing>


The key property is the compactness of the unitary group $U ( 2 )$. Consider the following infimum,


$ o_1 = inf_(U_1 , dots.h , U_n in U ( 2 )) chevron.l psi_1 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_1 chevron.r . $


Because the infimum is always attained by an element in the compact set, $exists U_1^inf , dots.h , U_n^inf in U ( 2 )$ such that


$ o_1 = chevron.l psi_1 | ( ( U_1^inf )^dagger ⊗ dots.h ⊗ ( U_n^inf )^dagger ) O ( U_1^inf ⊗ dots.h ⊗ U_n^inf ) | psi_1 chevron.r . $


Therefore, we have $o_1 > 0$ from Eq.~#ref(<eq:psi1condition>, supplement: none). Using the property of infimum, we have


$ chevron.l psi_1 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_1 chevron.r gt.eq o_1 , forall U_1 , dots.h , U_n in U ( 2 ) , $


we have the following inequality,


$ "𝔼"_(U_1 , dots.h , U_n tilde upright("Haar") ( U ( 2 ) )) chevron.l psi_1 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_1 chevron.r gt.eq o_1 > 0 . $


By the linearity of expectation and Eq.~#ref(<eq:depolarizing>, supplement: none), we have


$  & "𝔼"_(U_1 , dots.h , U_n tilde upright("Haar") ( U ( 2 ) )) chevron.l psi_1 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_1 chevron.r\
 & = "tr" (O "𝔼"_(U_1 , dots.h , U_n tilde upright("Haar") ( U ( 2 ) )) [( U_1 ⊗ dots.h ⊗ U_n ) | psi_1 chevron.r chevron.l psi_1 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger )]) = frac("tr" ( O ), 2^n) . $


Together, we have


$ frac("tr" ( O ), 2^n) gt.eq o_1 > 0 . $<eq:Oleqo1>


The argument for $| psi_2 chevron.r$ is slightly simpler. Consider the following supremum,


$ o_2 = sup_(U_1 , dots.h , U_n in U ( 2 )) chevron.l psi_2 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_2 chevron.r . $


From Eq.~#ref(<eq:psi1condition>, supplement: none), we have $o_2 lt.eq 0$. Using the fact that


$ chevron.l psi_2 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_2 chevron.r lt.eq o_2 , forall U_1 , dots.h , U_n in U ( 2 ) , $


we have the following inequality,


$ "𝔼"_(U_1 , dots.h , U_n tilde upright("Haar") ( U ( 2 ) )) chevron.l psi_2 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_2 chevron.r lt.eq o_2 lt.eq 0 . $


By the linearity of expectation and Eq.~#ref(<eq:depolarizing>, supplement: none), we have


$  & "𝔼"_(U_1 , dots.h , U_n tilde upright("Haar") ( U ( 2 ) )) chevron.l psi_2 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger ) O ( U_1 ⊗ dots.h ⊗ U_n ) | psi_2 chevron.r\
 & = "tr" (O "𝔼"_(U_1 , dots.h , U_n tilde upright("Haar") ( U ( 2 ) )) [( U_1 ⊗ dots.h ⊗ U_n ) | psi_2 chevron.r chevron.l psi_2 | ( U_1^dagger ⊗ dots.h ⊗ U_n^dagger )]) = frac("tr" ( O ), 2^n) . $


Together, we have


$ frac("tr" ( O ), 2^n) lt.eq o_2 lt.eq 0 . $<eq:Oleqo2>


From Eq.~#ref(<eq:Oleqo1>, supplement: none)~and~@eq:Oleqo2, we have derived the following result


$ frac("tr" ( O ), 2^n) lt.eq o_2 lt.eq 0 < o_1 lt.eq frac("tr" ( O ), 2^n) , $


which is a contradiction. Therefore, no such observable $O$ exists.






= PROOF OF EFFICIENCY FOR CLASSIFYING PHASES OF MATTER
<sec:proofthmPHASEC>


This section contains a detailed proof for another one of our main contributions. Namely, a rigorous performance guarantee for learning to predict quantum phases of matter.


== Training support vector machines
<sec:trainSVM>


Let us start by reviewing the textbook framework for reasoning about supervised learning tasks: support vector machines (SVMs). The underlying idea is simple and intuitive. Suppose that we have $N$ data points $bold(upright(bold(x)))_ell in bb(R)^D$ with binary labels $y_ell in {plus.minus 1}$ that form two well separated clusters. Then, we may try to separate these training clusters with a linear hyperplane $sans(H)_(bold(upright(bold(alpha)))) = (bold(upright(bold(x))) in bb(R)^D : #h(0em) chevron.l bold(upright(bold(alpha))) , bold(upright(bold(x))) chevron.r = 0) subset bb(R)^D$, defined using any vector $bold(upright(bold(alpha)))$ that is perpendicular to all vectors in the hyperplane. Here, we implicitly assume that the hyperplane $sans(H)_(bold(upright(bold(alpha))))$ must contain the origin $bold(upright(bold(0))) in bb(R)^D$. This simplifies exposition and will suffice for our purposes, but also constitutes an actual restriction (linear SVMs typically also allow for affine shifts). Such a hyperplane divides $bb(R)^D$ up into two half-spaces. For linear classification, we want that these half-spaces perfectly capture the labels of training data: $chevron.l bold(upright(bold(alpha))) , bold(upright(bold(x)))_ell chevron.r > 0$ whenever $y_ell = + 1$ and $chevron.l bold(upright(bold(alpha))) , bold(upright(bold(x)))_ell chevron.r < 0$ whenever $y_ell = - 1$. The hope is that this simple linear classification strategy generalizes to data we haven't yet seen. When we get a new data point, we simply check which halfspace it belongs to and assign the label accordingly. In the training stage, the main question is: how do we find a suitable hyperplane? Several strategies are known in the literature. One of them is the #emph[soft margin] problem: $  $


$ upright("minimize")_(bold(upright(bold(alpha))) in bb(R)^D) & quad sum_(ell = 1)^N max (0 , 1 - y_ell chevron.l bold(upright(bold(alpha))) , bold(upright(bold(x)))_ell chevron.r)\
upright("subject to") & quad chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r lt.eq Lambda^2 . $





For both label values, a positive product $y_ell chevron.l bold(upright(bold(alpha))) , bold(upright(bold(x)))_ell chevron.r$ is theoretically sufficient. However, numerical precision considerations warrant a nonzero separation between the clusters, so the product is optimized to be at least as large as a positive number (here, $1$). Otherwise, a hyperplane defined by $bold(upright(bold(alpha)))$ does not perfectly classify the data, yielding the training error $upright(E)_(upright("tr")) ( bold(upright(bold(alpha))) ) = sum_(ell = 1)^N max (0 , 1 - y_ell chevron.l bold(upright(bold(alpha))) , bold(upright(bold(x)))_ell chevron.r)$.


The task is to find $bold(upright(bold(alpha)))_sharp$ that achieves the smallest training error: $upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) lt.eq upright(E)_(upright("tr")) ( bold(upright(bold(alpha))) )$ for all vectors that obey $chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r lt.eq Lambda^2$. This is a convex optimization problem that can be solved in


polynomial time and we refer to @fig:SVM-illustration for a visual illustration. The most interesting situation occurs if we manage to achieve an optimal objective value of 0. This corresponds to zero training error. In this case, we have found a hyperplane $sans(H)_(bold(upright(bold(alpha)))_sharp)$ that perfectly separates training data. What is more, the constraint $chevron.l bold(upright(bold(alpha)))_sharp , bold(upright(bold(alpha)))_sharp chevron.r lt.eq Lambda^2$ ensures that the margin of separation is strictly positive. Let $hat(bold(upright(bold(alpha)))) = bold(upright(bold(alpha))) / parallel bold(upright(bold(alpha))) parallel$ be the unit vector that characterizes a hyperplane. Then, zero training error implies $chevron.l hat(bold(upright(bold(alpha)))) , bold(upright(bold(x)))_ell chevron.r gt.eq 1 / parallel bold(upright(bold(alpha))) parallel gt.eq 1 / Lambda$ for all $bold(upright(bold(x)))_ell$ with $y_ell = + 1$ and $chevron.l hat(bold(upright(bold(alpha)))) , bold(upright(bold(x)))_ell chevron.r < - 1 / Lambda$ for all $bold(upright(bold(x)))_ell$ with $y_ell = - 1$. In turn, the minimal margin amounts to $2 / Lambda$.


// [figvision] imgs/SVM_vis.png
// Panel (a) is a schematic. The axes are X1 and X2, both dimensionless and ranging from approximately -3 to 3.
// There are two series: pink circles (A, B, D, H) and blue squares (C, E, F, G). The pink circles represent one
// type of data point, while the blue squares represent another. A shaded region is bounded by lines with
// equations <α,x> = -1, 0, and 1, with a margin of 2/√<α,α> indicated. The trend shows the separation of data
// points into two groups. Panel (b) is also a schematic. The axes are X1, X2, and X3, all dimensionless. A gray
// plane is shown with the text "Data lie on a 2D plane". The pink circles (A, B, D, H) and blue squares (C, E,
// F, G) from panel (a) are plotted on this plane. The layout shows the relationship between these points in 3D
// space, with the plane intersecting the axes. The trend illustrates how the data points are embedded in a
// lower-dimensional space.
#figure(image("imgs/SVM_vis.png", height: 30%),
  caption: [
    \(a) #smallcaps[Geometric intuition behind support vector machines (SVMs)]. The idea is to separate clusters of labeled data with a linear hyperplane. The separation margin (yellow) is inversely proportional to the length $sqrt(chevron.l alpha  comma  alpha chevron.r)$ of the hyperplane normal vector. During the training stage we try to find a hyperplane that separates points with label +1 (blue) from points with label -1 (red) such that the margin is as large as possible (left). This hyperplane separates the data space into two halfspaces. In order to predict the label of a new data point, we simply check which halfspace it belongs to. (b) #smallcaps[Geometric intuition behind the representer theorem]. When trying to find a separating hyperplane, the total dimension of the data space does not matter. We can without loss restrict our attention to the smallest subspace that contains all the data points. This is because orthogonal directions don't matter during training and has two implications: (i) the cost of finding a separating hyperplane depends on the training data size $N$, not feature space dimension and (ii) we can express the hyperplane vector as a linear combination of training data points.
  ]
)
<fig:SVM-illustration>



However, it should not come as a surprise that such linear classification strategies are often inadequate. Most labeled collections of data simply cannot be separated by a linear hyperplane. However, it has been observed that this drawback can be overcome by first transforming data into a (usually much larger) feature space $bold(upright(bold(x)))_ell mapsto phi.alt ( bold(upright(bold(x)))_ell )$ and trying to find a separating hyperplane there. This transformation is typically nonlinear and increases the expressiveness of hyperplane classification. Although the separating hyperplane is linear in feature space, it may be highly nonlinear in the original data space. Denote the feature space by $cal(F)$ and suppose that it comes with an inner product $chevron.l dot.op , dot.op chevron.r_(cal(F))$ and dual space $cal(F)^(*)$. We can then formally phrase the search for a linear classifier in feature space as $  $


$ upright("minimize")_(bold(upright(bold(alpha))) in cal(F)^(*)) & quad sum_(ell = 1)^N max (0 , 1 - y_ell chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F)))\
upright("subject to") & quad chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2 . $<eq:SVM-classifier>





This problem looks more daunting than its linear counterpart, especially because the feature space $cal(F)$ may have an exceedingly large -- perhaps even infinite -- dimension. But we are still interested in identifying a hyperplane that separates a total of $N$ transformed data points $phi.alt ( bold(upright(bold(x)))_1 ) , dots.h , phi.alt ( bold(upright(bold(x)))_N ) in cal(F)$ in a linear fashion: $chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F)) > 0$ if $y_ell = + 1$ and $chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F)) < 0$ else if $y_ell = - 1$.


And in order to achieve this, we can without loss restrict ourselves to the $N$-dimensional subspace $upright("span") (phi.alt ( bold(upright(bold(x)))_1 ) , dots.h , phi.alt ( bold(upright(bold(x)))_N )) subset cal(F)$ that is spanned by the data points themselves (all other directions are orthogonal to #emph[all] data points and do not play a role for classification). For finite dimensional feature spaces $( cal(F) , chevron.l dot.op , dot.op chevron.r_(cal(F)) )$, this is an intuitive observation that follows from basic orthogonality arguments.


We refer to @fig:SVM-illustration for a visual illustration. For infinite-dimensional feature spaces it is the content of the celebrated generalized representer theorem~@scholkopf2001generalized. More formally, this insight allows us to decompose every (relevant) hyperplane normal vector $bold(upright(bold(alpha)))$ in the optimization problem~@eq:SVM-classifier as $bold(upright(bold(alpha))) = sum_(ell = 1)^N alpha_ell phi.alt ( bold(upright(bold(x)))_ell )$. Linearity then ensures $chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x)))_(ell') ) chevron.r_(cal(F)) = sum_(ell = 1)^N alpha_ell chevron.l phi.alt ( bold(upright(bold(x)))_ell ) , phi.alt ( bold(upright(bold(x)))_(ell') ) chevron.r_(cal(F))$ for each $ell' in (1 , dots.h , N)$ and also $chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) = sum_(ell , ell' = 1)^N alpha_ell alpha_(ell') chevron.l phi.alt ( bold(upright(bold(x)))_ell ) , phi.alt ( bold(upright(bold(x)))_(ell') ) chevron.r_(cal(F))$. These expressions only depend on the elements of a $N times N$ Gram matrix in feature space:


$ [ bold(bold(K))]_( ell ell')= chevron.l phi (bold(bold(x))_(ell)), phi (bold(bold(x))_(ell')) chevron.r_(cal(F))=: k ( bold(bold(x))_(ell),bold(bold(x))_(ell') ) quad "for" ell,ell' in {1,…,N} . $ <eq:kernel-matrix>


The expression $k ( bold(upright(bold(x)))_ell , bold(upright(bold(x)))_(ell') )$ is called the #emph[kernel] associated with the feature map $phi.alt$ and the matrix $bold(upright(bold(K)))$ is the #emph[kernel matrix]. Kernels are a measure of similarity between (training) data points that is often easier to compute than performing the underlying feature map $phi.alt : bb(R)^D arrow.r cal(F)$. But, for linear classification (in feature space), both contain exactly the same amount of information. Indeed, we may re-express the optimization problem~@eq:SVM-classifier as $  $


$ upright("minimize")_(bold(upright(bold(alpha))) in bb(R)^N) & quad sum_(ell = 1)^N max (0 , 1 - y_ell bold(upright(bold(alpha)))^T bold(upright(bold(K))) bold(upright(bold(e)))_ell)\
upright("subject to") & quad bold(upright(bold(alpha)))^T bold(upright(bold(K))) bold(upright(bold(alpha))) lt.eq Lambda^2 . $<eq:SVM-classifier-2>





We can also collect the classification labels in a diagonal matrix $bold(upright(bold(Y))) = upright("diag") (y_1 , dots.h , y_N)$ of compatible dimension and linearize the loss function by means of an entry-wise nonnegative slack variable $bold(upright(bold(beta))) gt.eq bold(upright(bold(0)))$. Let $bold(upright(bold(1))) = ( 1 , dots.h , 1 )^T$ denote the vector of ones. Then, problem~@eq:SVM-classifier-2 is equivalent to solving


$  $


$ upright("minimize")_(bold(upright(bold(alpha))) , bold(upright(bold(beta))) in bb(R)^N) & quad chevron.l bold(upright(bold(1))) , bold(upright(bold(beta))) chevron.r\
upright("subject to") & quad bold(upright(bold(beta))) gt.eq bold(upright(bold(1))) - bold(upright(bold(Y))) bold(upright(bold(K))) bold(upright(bold(alpha)))\
 & quad bold(upright(bold(beta))) gt.eq bold(upright(bold(0))) , #h(0em) bold(upright(bold(alpha)))^(*) bold(upright(bold(K))) bold(upright(bold(alpha))) lt.eq Lambda^2 . $<eq:training-problem>





Similar to before, the optimal function value denotes the minimal #emph[training error] $upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) = chevron.l bold(upright(bold(1))) , bold(upright(bold(beta)))_sharp chevron.r$.


Apart from a single quadratic constraint ($bold(upright(bold(alpha)))^(*) bold(upright(bold(K))) bold(upright(bold(alpha))) lt.eq Lambda^2$), this optimization problem looks like a linear program in $2 N$ dimensions. It is a convex instance of a quadratically constrained quadratic program (QCQP) and can be solved in time at most polynomial


in the training data size $N$ @boyd2004convex. In practice, one could use existing software packages, such as scikit-learn @scikit-learn or LIBSVM @CC01a. If the time to compute the kernel function $k ( bold(upright(bold(x)))_ell , bold(upright(bold(x)))_(ell') )$ is $t_(upright("kernel"))$, then the time complexity for training a support vector machine is given by


$ cal(O) ( t_(upright("kernel")) N^2 + upright("poly") ( N ) ) &  &  & upright("(training time)") . $<eq:general-training-time>


Hence, for support vector machines with efficiently computable kernel functions $k ( bold(upright(bold(x)))_ell , bold(upright(bold(x)))_(ell') )$, small training data sizes $N$ directly ensure a short training time. The polynomial scaling in training data size depends on the type of algorithm. Dedicated solvers for the soft margin problem @joachims1998making @CC01a @hazan2011beating require (at most) $cal(O) (N^3 + Lambda^2 N / epsilon.alt^2)$ arithmetic operations to produce a solution $bold(upright(bold(alpha)))_(sharp , epsilon.alt)$ that is $epsilon.alt$-close to optimal: $upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_(sharp , epsilon.alt) ) lt.eq upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) + epsilon.alt$. For the concrete training problems considered here, such an approximation is good enough and the associated runtime bound simplifies to $cal(O) (t_(upright("kernel")) N^2 + N^3)$. Interior point methods offer an alternative that scale worse in training data size, but much better in the approximation error $epsilon.alt$, see e.g.~@boyd2004convex.


== Prediction using support vector machines
<sec:pred-SVM>


In the last section, we have explained how feature maps and kernels can considerably boost the expressiveness of initially linear classifiers. We have also explained how to use labeled training data of size $N$ to find a separating hyperplane in feature space by solving a quadratic program~@eq:training-problem that depends on the kernel matrix~@eq:kernel-matrix. Ideally, $upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) = 0$ (zero training error) and the optimal solution $bold(upright(bold(alpha)))_sharp in bb(R)^N$ parametrizes a separating hyperplane with minimal margin $2 / Lambda$ in feature space: $ h_sharp ( bold(upright(bold(x)))_(ell') ) = sum_(ell = 1)^N [ bold(upright(bold(alpha)))_sharp ]_ell chevron.l phi.alt ( bold(upright(bold(x)))_ell ) , phi.alt ( bold(upright(bold(x)))_(ell') ) chevron.r_(cal(F)) = sum_(ell = 1)^N [ bold(upright(bold(alpha)))_sharp ]_ell k ( bold(upright(bold(x)))_ell , bold(upright(bold(x)))_(ell') ) quad cases(
    > + 1 / Lambda & "if " y_(ell') = +1,
    < - 1 / Lambda & "else if " y_(ell') = -1,
  ) $ for all (labeled) training data points $( bold(upright(bold(x)))_1 , y_1 ) , dots.h , ( bold(upright(bold(x)))_N , y_N )$.The sign of this classifier, in turn, correctly reproduces training labels:


$ y_(sharp) (bold(bold(x))_(ell')) := "sign" ( h_(sharp) (bold(bold(x))_(ell')) ) = y_(ell') quad "for each" ell in {1,…,N} . $ <eq:prediction-function>


In the prediction stage, we use this function to assign a label $y_sharp ( bold(upright(bold(x))) ) in {plus.minus 1}$ to a new (and unlabeled) data point $bold(upright(bold(x)))$.


The cost of evaluating $y_sharp ( bold(upright(bold(x)))_(ell') )$ is dominated by the cost of evaluating $N$ kernel functions. If the time to compute the kernel function is $t_(upright("kernel"))$, then the prediction time for a new input vector $bold(upright(bold(x)))$ is bounded by


$ cal(O) ( t_(upright("kernel")) N ) &  &  & upright("(prediction time)") . $


Similar to the training time~@eq:general-training-time, a small training data size $N$ translates into a fast prediction time.


The hope is that training with an adequate kernel uncovers latent structure that generalizes beyond training data. Typically, larger training data sizes $N$ also increase the chance for learning good classifiers~@eq:prediction-function. But generalization beyond training data often only makes sense if the new data point $bold(upright(bold(x)))$ is somewhat related to the training data (e.g.~training a SVM on labeled cat-vs-dog images does not necessarily produce a classifier that can distinguish apples from oranges). Extra assumptions that address similarity of training and prediction data are important when one aims at establishing rigorous bounds on the probability of making a wrong prediction, i.e. $y_sharp ( bold(upright(bold(x))) ) = - y ( bold(upright(bold(x))) )$. A common assumption is that both the training data and new data points are generated independently from the same distribution: $( bold(upright(bold(x)))_1 , y_1 ) , dots.h , ( bold(upright(bold(x)))_N , y_N ) , ( bold(upright(bold(x))) , y ) tilde cal(D)$. The data distribution $cal(D)$ is a joint distribution over both the input vector $bold(upright(bold(x)))$ and the label $y$. Such an assumption encompasses the intuition that the label $y$ is correlated with the input vector $bold(upright(bold(x)))$, but is not necessarily a function of $bold(upright(bold(x)))$. Flexibility of this form is useful for describing situations where the data points $bold(upright(bold(x)))$ are corrupted by noise. This is often the case in quantum mechanics due to the inherent randomness in quantum measurements. The underlying data distribution should be taken into account when reasoning about false predictions, motivating the probability


$ upright("Pr")_(( bold(upright(bold(x))) , y ) tilde cal(D)) [y_sharp ( bold(upright(bold(x))) ) eq.not y] in & med [ 0 , 1 ] & upright("(average-case prediction error)") $<eq:average-prediction>


as a good figure of merit. Noting that there are in general many approaches to bounding the prediction error, we present a user-friendly theorem that bounds the average-case prediction error in terms of the training error $upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp )$ and training data size $N$.


#thmbox("theorem", "Theorem (Prediction error for support vector machines)")[


Fix a data distribution $( bold(upright(bold(x))) , y ) tilde cal(D)$, a kernel function $k ( dot.op , dot.op )$, a minimal margin $2 / Lambda$ and a training data size $N$. Assume $k ( bold(upright(bold(x))) , bold(upright(bold(x))) ) lt.eq R^2$ almost surely. Then, with probability (at least) $1 - delta$,


$ upright("Pr")_(( bold(upright(bold(x))) , y ) tilde cal(D)) [y_sharp ( bold(upright(bold(x))) ) eq.not y] lt.eq 1 / N upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) + 7 ( Lambda R + 1 ) sqrt(frac(log ( 2 / delta ), N)) , $


where $y_sharp ( bold(upright(bold(x))) )$ is the classifier~@eq:prediction-function obtained from solving the training problem~@eq:training-problem on independently sampled training data $(bold(upright(bold(x)))_1 , y_1) , dots.h , (bold(upright(bold(x)))_N , y_N) tilde cal(D)$, and $upright(E)_(upright("tr"))$ denotes the associated training error.


] <thm:svm-prediction>


This rigorous statement bounds the average prediction error in terms of the training error plus an error term that decays as $1 / sqrt(N)$ in training data size. The core assumption is that training and prediction data is sampled in an independent and identically distributed (#emph[iid]) fashion. The proof is based on specializing a standard result from high dimensional probability theory to the task at hand.


#thmbox("theorem", ([Theorem], [(Theorem 3.3 in #cite(<mohri2018foundations>))]))[


Fix a probability distribution $cal(D)$ over elements in a set $sans(X)$, a family of functions $cal(G)$ from $sans(X)$ to the interval $[ 0 , gamma_max ]$, as well as $delta in ( 0 , 1 )$ and $N in bb(N)$. Then, with probability $1 - delta$, the following bound is valid for #emph[all] functions $g in cal(G)$ simultaneously:


$ "𝔼"_(x tilde cal(D)) [ g ( x ) ] lt.eq 1 / N sum_(ell = 1)^N g ( x_ell ) + 3 gamma_max sqrt(frac(log ( 2 / delta ), 2 N)) + 2 / sqrt(N) "𝔼"_(epsilon_1 , dots.h , epsilon_N) [sup_(g in cal(G)) 1 / sqrt(N) sum_(ell = 1)^N epsilon_ell g ( x_ell )] . $<eq:rademacher>


Here, $x_1 , dots.h , x_N tilde^(italic("iid")) cal(D)$ are sampled from $sans(X)$ and $epsilon_1 , dots.h , epsilon_N tilde^(italic("iid")) {plus.minus 1}$ are Rademacher random variables (the failure probability $lt.eq delta$ addresses these random selections).


] <thm:rademacher>


The right hand side of this upper bound contains three qualitatively different contributions. The first term describes an empirical average over $N$ independent samples. It approximates the true expectation value by Monte Carlo sampling, and can underestimate the true average. As $N$ increases, the approximation accuracy becomes better and, simultaneously, the probability of sampling a poor approximation diminishes exponentially. This is precisely the content of the second term. Larger sampling rates $N$ suppress it and also allow for insisting on ever smaller failure probabilities $delta$. However, these two terms are still not enough for an upper bound because we would like to have a bound for #emph[all functions] $g in cal(G)$. This is where the third term comes into play. It contains the empirical width, a statistical summary parameter for the extent of the function set $cal(G)$, see e.g.~@vershynin2018high. Suppose, for instance, that $cal(G) = {g}$ contains only a single function. Then, we can ignore the supremum (over a single element) and the contribution vanishes entirely (Rademacher random variables have zero expectation). The empirical width parameter can, however, grow with the size of the function set $g in cal(G)$.


In the context of bounding the performance of support vector machines, the domain variable $x$ becomes $( bold(upright(bold(x))) , y )$, and the function family consists of the training error $g_(bold(upright(bold(alpha))))$ from Eq.~(@eq:SVM-classifier), indexed by $bold(upright(bold(alpha)))$. The third term in @thm:rademacher can then be bounded by the largest norm of the feature vectors.


#thmbox("lemma", "Lemma")[


Fix a feature map $phi.alt : bb(R)^D times {plus.minus 1} arrow.r cal(F)$ and define $g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x))) , y ) = max (0 , 1 - y chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F)))$ for $bold(upright(bold(alpha))) in cal(F)^(*)$. Then,


$ "𝔼"_(epsilon_1 , dots.h , epsilon_N) [sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) 1 / sqrt(N) sum_(ell = 1)^N epsilon_ell g_(bold(upright(bold(alpha)))) (bold(upright(bold(x)))_ell , y_ell)] lt.eq Lambda max_(1 lt.eq ell lt.eq N) sqrt(chevron.l phi.alt ( bold(upright(bold(x)))_ell )  comma  phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F))) $


for any collection $(bold(upright(bold(x)))_1 , y_1) , dots.h , (bold(upright(bold(x)))_N , y_N) in bb(R)^D times {plus.minus 1}$.


] <lem:svm-width>


#block[
#emph[Proof.] Let us abbreviate the expectation over all $N$ Rademacher random variables by $"𝔼"_epsilon$. Note that the empirical width is invariant under a constant shift of the hinge loss function: $max (0 , 1 - z) mapsto max (0 , 1 - z) - 1$. In turn, the shifted loss function $L ( z ) = max (0 , 1 - z) - 1$ describes a contraction, i.e.~$L ( 0 ) = 0$ and $lr(|L ( z_1 ) - L ( z_2 )|) lt.eq lr(|z_1 - z_2|)$ for all $z_1 , z_2 in bb(R)$. Such contractions can only decrease the empirical width. More precisely, the Rademacher comparison principle @ledoux2013probability[Eq.~(4.20)] asserts $  $~◻

]


$ "𝔼"_epsilon [sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) 1 / sqrt(N) sum_(ell = 1)^N epsilon_ell g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x)))_ell , y_ell )] & = "𝔼"_epsilon [sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) 1 / sqrt(N) sum_(ell = 1)^N epsilon_ell (max (0 , 1 - y_ell chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F))) - 1)]\
 & lt.eq "𝔼"_epsilon [sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) 1 / sqrt(N) sum_(ell = 1)^N epsilon_ell y_ell chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F))]\
 & = "𝔼"_epsilon [sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) chevron.l bold(upright(bold(alpha))) , h_epsilon chevron.r_(cal(F))] . $





In the last step, we have introduced the short-hand notation $h_epsilon = 1 / sqrt(N) sum_(ell = 1)^N epsilon_ell y_ell phi.alt ( bold(upright(bold(x)))_ell ) in cal(F)$.


Applying a Cauchy-Schwarz inequality in feature space allows us to separate the supremum from the Rademacher randomness:


$ "𝔼"_epsilon [sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) chevron.l bold(upright(bold(alpha))) , h_epsilon chevron.r_(cal(F))] lt.eq sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) sqrt(chevron.l bold(upright(bold(alpha)))  comma  bold(upright(bold(alpha))) chevron.r_(cal(F))) #h(0em) "𝔼"_epsilon [sqrt(chevron.l h_epsilon  comma  h_epsilon chevron.r_(cal(F)))] lt.eq Lambda sqrt("𝔼"_epsilon chevron.l h_epsilon  comma  h_epsilon chevron.r_(cal(F))) . $


The last inequality is Jensen's. We complete the argument using $"𝔼"_epsilon [epsilon_ell epsilon_(ell')] = delta_(ell , ell')$ and $y_ell^2 = 1$:


$ "𝔼"_epsilon chevron.l h_epsilon , h_epsilon chevron.r_(cal(F)) = 1 / N sum_(ell , ell' = 1)^N "𝔼"_epsilon [epsilon_ell epsilon_(ell')] y_ell y_(ell') chevron.l phi.alt ( bold(upright(bold(x)))_ell ) , phi.alt ( bold(upright(bold(x)))_(ell') ) chevron.r_(cal(F)) = 1 / N sum_(ell = 1)^N chevron.l phi.alt ( bold(upright(bold(x)))_ell ) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F)) lt.eq max_(1 lt.eq ell lt.eq N) chevron.l phi.alt ( bold(upright(bold(x)))_ell ) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F)) . $





We are now ready to prove the general connection between average prediction (@eq:average-prediction) and training error.


#block[
#emph[Proof of @thm:svm-prediction.] We consider functions $y_(bold(upright(bold(alpha)))) ( bold(upright(bold(x))) ) = upright("sign") (chevron.l bold(upright(bold(alpha))) , phi.alt (bold(upright(bold(x)))) chevron.r_(cal(F))) in {plus.minus 1}$, such that $bold(upright(bold(alpha))) in cal(F)^(*)$ obeys $chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2$. This family of functions includes all classifiers that are feasible points in the training stage~@eq:training-problem of our support vector machine. For $bold(upright(bold(alpha)))$ fixed, but otherwise arbitrary, we want to compare the corresponding classifier $y_(bold(upright(bold(alpha)))) (bold(upright(bold(x))))$ to the true data label $y in {plus.minus 1}$. Elementary reformulations then allow us to re-express the failure probability as~◻

]


$ upright("Pr")_(( bold(upright(bold(x))) , y ) tilde cal(D)) [y_(bold(upright(bold(alpha)))) ( bold(upright(bold(x))) ) eq.not y] = upright("Pr")_(( bold(upright(bold(x))) , y ) tilde cal(D)) [upright("sign") (chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F))) eq.not y] = upright("Pr")_(( bold(upright(bold(x))) , y ) tilde cal(D)) [y chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F)) < 0] , $


because the sign is negative if and only if the number itself is. Next, we rewrite this probability as the expectation value of the associated indicator function and use $upright(bold(1)) {z lt.eq 0} lt.eq max (0 , 1 - z)$ for all $z in bb(R)$ to obtain


$ upright("Pr")_(( bold(upright(bold(x))) , y ) tilde cal(D)) [y chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F)) < 0] = "𝔼"_(( bold(upright(bold(x))) , y ) tilde cal(D)) [bold(upright(bold(1))) (y chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x)))_ell ) chevron.r_(cal(F)) < 0)] lt.eq "𝔼"_(( bold(upright(bold(x))) , y ) tilde cal(D)) [max (0 , 1 - y chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F)))] . $


This upper bound is the expected value of a certain hinge loss function


$ g_(bold(upright(bold(alpha)))) (bold(upright(bold(x))) , y) = max (0 , 1 - y chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F))) quad upright("with") quad chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2 . $


The function is a specific element of an entire family, namely


$ cal(G) = (g_(bold(upright(bold(alpha)))) ( dot.op , dot.op ) : chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) : bb(R)^D times {plus.minus 1} arrow.r lr([0 , oo)) . $


The associated function values are always nonnegative and bounded. Indeed, the Cauchy-Schwarz inequality in feature space asserts


$ g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x))) , y ) lt.eq & lr(|y chevron.l bold(upright(bold(alpha))) , phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F))|) + 1 lt.eq sqrt(chevron.l bold(upright(bold(alpha)))  comma  bold(upright(bold(alpha))) chevron.r_(cal(F)) chevron.l phi.alt ( bold(upright(bold(x))) )  comma  phi.alt ( bold(upright(bold(x))) ) chevron.r_(cal(F))) + 1 lt.eq Lambda sqrt(k ( bold(upright(bold(x))) , bold(upright(bold(x))) )) + 1 lt.eq Lambda R + 1 = : gamma_max . $


We are now in a position to use @thm:rademacher. With probability (at least) $1 - delta$,


$ "𝔼"_(( bold(upright(bold(x))) , y ) tilde cal(D)) [g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x))) , y )] lt.eq & 1 / N sum_(ell = 1)^N g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x)))_ell , y_ell ) + 3 gamma_max sqrt(frac(log ( 2 / delta ), 2 N)) + 2 / sqrt(N) "𝔼"_epsilon [sup_(chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2) 1 / sqrt(N) sum_(ell = 1)^N epsilon_ell g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x)))_ell , y_ell )] , $


is true for #emph[all] dual vectors $bold(upright(bold(alpha))) in cal(F)^(*)$ that obey $chevron.l bold(upright(bold(alpha))) , bold(upright(bold(alpha))) chevron.r_(cal(F)) lt.eq Lambda^2$. Here, $(bold(upright(bold(x)))_1 , y_1) , dots.h , (bold(upright(bold(x)))_N , y_N) tilde cal(D)$ is a randomly sampled (but fixed) collection of labeled data points. We now use $sqrt(k ( bold(upright(bold(x)))_ell , bold(upright(bold(x)))_ell )) lt.eq R$ almost surely to apply @lem:svm-width and control the empirical width term: $  $


$ "𝔼"_(( bold(upright(bold(x))) , y ) tilde cal(D)) [g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x))) , y )] & lt.eq 1 / N sum_(ell = 1)^N g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x)))_ell , y_ell ) + 3 ( Lambda R + 1 ) sqrt(frac(log ( 2 / delta ), 2 N)) + frac(2 Lambda R, sqrt(N))\
 & lt.eq 1 / N sum_(ell = 1)^N g_(bold(upright(bold(alpha)))) ( bold(upright(bold(x)))_ell , y_ell ) + 7 ( Lambda R + 1 ) sqrt(frac(log ( 2 / delta ), N)) . $





With probability (at least) $1 - delta$, this bound is valid for all hyperplane vectors $bold(upright(bold(alpha))) in cal(F)$.


The tightest bound is achieved for minimizing the right hand side. This is precisely what training a support vector machine does, as the first term is precisely the training error that is minimized in the training stage~@eq:training-problem.


The optimal solution $bold(upright(bold(alpha)))^sharp$ to this problem simultaneously produces the actual classifier $y_sharp ( bold(upright(bold(x))) )$ on the left hand side and the (minimal) training error on the right hand side.






== Kernel functions for classical shadows
<sub:shadow-kernel>


We have reviewed the classical shadow formalism in Appendix~#ref(<sec:classical-shadows>, supplement: none). For randomized single-qubit Pauli measurements, a classical shadow approximates a $n$-qubit state $rho$ by means of $T$ elementary tensor products. Each shadow raw data corresponds to a two-dimensional array


$ S_T ( rho ) = S_T ( rho ) = {| s_i^(( t )) chevron.r : #h(0em) i in ( 1 , dots.h , n ) , t in ( 1 , dots.h , T )} in (| 0 chevron.r , | 1 chevron.r , | + chevron.r , | - chevron.r , | upright(i) + chevron.r , | upright(i) - chevron.r)^(n times T) $


and is combined into an approximator of the state as


$ sigma_T ( rho ) = 1 / T sum_(t = 1)^T (3 | s_1^(( t )) chevron.r chevron.l s_1^(( t )) | - bb(I)) ⊗ dots.h.c ⊗ (3 | s_n^(( t )) chevron.r chevron.l s_n^(( t )) | - bb(I)) = 1 / T sum_(t = 1)^T sigma_1^(( t )) ⊗ dots.h.c ⊗ sigma_n^(( t )) , $


where we have introduced the short-hand notation $sigma_i^(( t )) = 3 | s_i^(( t )) chevron.r chevron.l s_i^(( t )) | - bb(I)$. For these quantum state representations, we fix parameters $tau , gamma > 0$ and introduce a suggestive, yet finite-dimensional feature map. For large, but finite, integers $D , R > 0$ we define


$ phi.alt^(upright("(finite)")) (S_T ( rho )) = x⋁_(d = 0)^D sqrt(frac(tau^d, d !)) ( x⋁_(r = 0)^R sqrt(frac(1, r !) (gamma / n)^r) x⋁_(i_1 = 1)^r dots.h.c x⋁_(i_r = 1)^r 1 / T sum_(t = 1)^T upright("vec") (sigma_(i_1)^(( t ))) ⊗ dots.h.c ⊗ upright("vec") (sigma_(i_r)^(( t ))) )^(⊗ d) , $<eq:feature-space-linearization>


Here, $upright("vec") ( dot.op )$ denotes an appropriate vectorization operation that maps the real-valued vector space $bb(H)_2$ of Hermitian $2 times 2$ matrices to $bb(R)^4$ such that the Hilbert-Schmidt inner product is preserved: $chevron.l upright("vec") ( A ) , upright("vec") ( B ) chevron.r = upright("tr") ( A B )$.


This feature map embeds classical shadows in a very large-dimensional, real-valued feature space $cal(F)^(upright("(finite)"))$. This feature space arises from taking direct sums and tensor products of $upright("vec") ( bb(H)_2 ) tilde.eq bb(R)^4$. We can extend the standard inner product $chevron.l dot.op , dot.op chevron.r$ on $bb(R)^4$ to this feature space by setting $chevron.l x_1 xor x_2 , y_1 xor y_2 chevron.r = chevron.l x_1 , y_1 chevron.r + chevron.l x_2 , y_2 chevron.r$ (direct sums), as well as $chevron.l x_1 ⊗ x_2 , y_1 ⊗ y_2 chevron.r = chevron.l x_1 , y_1 chevron.r chevron.l x_2 , y_2 chevron.r$ (tensor products) and extend these definitions linearly. Doing so equips the feature space $cal(F)^(upright("(finite)"))$ with a well-defined inner product $chevron.l dot.op , dot.op chevron.r_(cal(F)^(upright("(finite)")))$. The inner product and feature map induce a kernel function on pairs of classical shadows of equal size $T$: $  $


$  & k^(upright("(finite)")) (S_T ( rho_1 ) , tilde(S)_T ( rho_2 )) = ⟨phi.alt^(upright("(finite)")) ( S_T ( rho_1 ) ) , phi.alt^(upright("(finite)")) ( tilde(S)_T ( rho_2 ) )⟩_(cal(F)^(upright("(finite)")))\
= & sum_(d = 0)^D frac(tau^d, d !) (sum_(r = 0)^R frac(1, r !) (gamma / n)^r sum_(i_1 = 1)^n dots.h.c sum_(i_r = 1)^n 1 / T^2 sum_(t , t' = 1)^T ⟨upright("vec") (sigma_(i_1)^(( t ))) , upright("vec") (tilde(sigma)_(i_1)^(( t' )))⟩ dots.h.c ⟨upright("vec") (sigma_(i_r)^(( t ))) , upright("vec") (tilde(sigma)_(i_r)^(( t' )))⟩)^d\
= & sum_(d = 0)^D frac(tau^d, d !) (sum_(r = 0)^R frac(1, r !) (gamma / n)^r sum_(i_1 = 1)^n dots.h.c sum_(i_r = 1)^n upright("tr") ((1 / T sum_(t = 1)^T sigma_(i_1)^(( t )) ⊗ dots.h.c ⊗ sigma_(i_r)^(( t )))) (1 / T sum_(t' = 1)^T tilde(sigma)_(i_1)^(( t' )) ⊗ dots.h.c ⊗ tilde(sigma)_(i_r)^(( t' ))))^d\
= & sum_(d = 0)^D frac(1, d !) (tau / T^2 sum_(t , t' = 1)^T sum_(r = 0)^R frac(1, r !) (gamma / n)^r sum_(i = 1)^n dots.h.c sum_(i_r = 1)^r upright("tr") (sigma_(i_1)^(( t )) tilde(sigma)_(i_1)^(( t' ))) dots.h.c upright("tr") (sigma_(i_r)^(( t )) tilde(sigma)_(i_r)^(( t' ))))^d\
= & sum_(d = 0)^D frac(1, d !) (tau / T^2 sum_(t , t' = 1)^T sum_(r = 0)^R frac(1, r !) (gamma / n sum_(i = 1)^n upright("tr") (sigma_i^(( t )) tilde(sigma)_i^(( t' ))))^r)^d . $





This kernel function sill looks somewhat complicated, but it simplifies considerably if we first take $R arrow.r oo$ and then $D arrow.r oo$:


$  $


$ k^(upright("(") thin upright("shadow") thin upright(")")) (S_T ( rho_1 ) , tilde(S)_T ( rho_2 )) := & lim_(D arrow.r oo) lim_(R arrow.r oo) k^(upright("(finite)")) (S_T ( rho_1 ) , tilde(S)_T ( rho_2 ))\
= & lim_(D arrow.r oo) sum_(d = 0)^D frac(1, d !) (tau / T^2 sum_(t , t' = 1)^T lim_(R arrow.r oo) sum_(r = 0)^R frac(1, r !) (gamma / n sum_(i = 1)^n upright("tr") (sigma_i^(( t )) tilde(sigma)_i^(( t' ))))^r)^d\
= & exp (tau / T^2 sum_(t , t' = 1)^T exp (gamma / n sum_(i = 1)^n upright("tr") (sigma_i^(( t )) tilde(sigma)_i^(( t' ))))) $<eq:shadow-kernel>





We call this kernel function a #emph[shadow kernel]. In contrast to its finite approximations, this kernel function can be computed very efficiently. Trace inner products between single-qubit shadow constituents assume one out of 3 values only:


$ upright("tr") (sigma_i^(( t )) tilde(sigma)_i^(( t ))) = & upright("tr") (( 3 | s_i^(( t )) chevron.r chevron.l s_i^(( t )) | - bb(I) ) ( 3 | tilde(s)_i^(( t )) chevron.r chevron.l tilde(s)_i^(( t )) | - bb(I) )) = 9 lr(|chevron.l s_i^(( t )) | tilde(s)_i^(( t )) chevron.r|)^2 - 4 in (- 4 , 1 / 2 , 5) . $<eq:shadow-inner-products>


And we need to compute exactly $n T^2$ of them to unambiguously characterize the shadow kernel~@eq:shadow-kernel. The total cost for evaluating shadow kernels also amounts to


$ cal(O) (n T^2) &  & upright("(shadow kernel evaluation cost)") $<eq:shadow-kernel-evaluation-cost>


arithmetic operations. As long as $T$ is not too large, this is extremely efficient, given that we combine classical approximations of $n$-qubit quantum states $rho_1 , rho_2$ which way well have $( 4^n - 1 )$ degrees of freedom. Eq.~#ref(<eq:shadow-inner-products>, supplement: none) also ensures that shadow kernels remain bounded functions:


$ 0 lt.eq k^(upright("(") thin upright("shadow") thin upright(")")) (S_T ( rho_1 ) , tilde(S)_T ( rho_2 )) lt.eq exp (tau exp (5 gamma)) , $<eq:kernel-upper-bound>


because exponential functions are nonnegative and monotonic.


While easy to evaluate and conceptually appealing, the shadow kernel does have its downsides. By construction, the associated feature space is not finite-dimensional anymore. This can complicate a thorough analysis of support vector machines substantially. In particular, it is a priori not clear if powerful results, like @thm:svm-prediction, cover the shadow kernel as well. Fortunately, we can bypass such mathematical subtleties by approximating $k^(upright("(") thin upright("shadow") thin upright(")")) ( dot.op , dot.op )$ with $k^(upright("(finite)")) ( dot.op , dot.op )$, where $D$ and $R$ are large, but finite, numbers. This incurs an additional approximation error, but allows us to formulate theoretical prediction and training guarantees exclusively for finite-dimensional feature spaces. What is more, elementary approximation results from calculus ensure that we can make this additional approximation error arbitrarily small by making the cutoffs sufficiently large.


Taylor's approximation theorem, for instance, shows that $D = upright(e)^2 tau exp ( 5 gamma ) + log ( 1 / eta ) - 1$, as well as $R = 5 upright(e)^2 gamma + tau exp ( 5 gamma ) + log ( tau / eta ) - 1$ ensure


$ lr(|k^(upright("(") thin upright("shadow") thin upright(")")) (S_T ( rho_1 ) , tilde(S)_T ( rho_2 )) - k^(upright("(finite)")) (S_T ( rho_1 ) , tilde(S)_T ( rho_2 ))|) lt.eq 2 eta $


for all pairs of classical shadows with compatible size $T$. Properly tuning $gamma$ and $tau$ would yield better prediction performance in practice. Nevertheless, for simplicity, we will assume $gamma = tau = 1$ in the following theoretical analysis.


Finite-dimensional feature space approximations also allow us to highlight the expressiveness behind the shadow kernel~@eq:shadow-kernel. It describes (the limit of) a feature map that extracts #emph[all] tensor powers of #emph[all] subsystem operators $X_A = upright("tr")_(not A) ( X ) in bb(H)_2^(⊗ | A |)$, where $A subset [n] = (1 , dots.h , n)$. In particular, any function that can be written as a finite power series, of degree at most $d_p$, in reduced subsystem operators, of size at most $r$, becomes a #emph[linear] function in feature space, represented by the dual vector $bold(upright(bold(alpha)))_f$: $  $


$ f (S_T ( rho )) & = sum_(d = 0)^(d_p) frac(1, d !) sum_(A_1 dots.h A_d subset ( 1 , dots.h , n ) , | A_i | lt.eq r) upright("tr") (O_(A_1 , dots.h , A_d) upright("tr")_(not A_1) (sigma_T ( rho )) ⊗ dots.h.c ⊗ upright("tr")_(not A_d) (sigma_T ( rho )))\
 & = chevron.l bold(upright(bold(alpha)))_f , phi.alt^(upright("(finite)")) ( S_T ( rho ) ) chevron.r_(cal(F)^(upright("(finite)"))) , $<eq:feature-linearization>





provided that $d_p lt.eq D , r lt.eq R$.


The (extended) Euclidean norm of $bold(upright(bold(alpha)))_f$ is also bounded. Use Eq.~#ref(<eq:feature-space-linearization>, supplement: none) (with tuning parameters $gamma , tau = 1$) to compute $  $<eq:separator-size>


$ chevron.l bold(bold(alpha))_(f), bold(bold(alpha))_(f) chevron.r_(cal(F)^("(finite)")) & lt.eq sum_(d=0)^(d_(p)) frac((r! n^(r))^(d), d!) sum_(A_(1),…,A_(d) subset {1,…,n}, |A_(i)| lt.eq r) "tr" ( O_(A_(1),…,A_(d))^(2) ) \
& lt.eq sum_(d=0)^(d_(p)) frac((r! n^(r))^(d), d!) sum_(A_(1),…,A_(d) subset {1,…,n}, |A_(i)| lt.eq r) 2^(r d) | O_(A_(1),…,A_(d)) |_(infinity)^(2) \
& lt.eq (2n r)^(r d_(p)) max_(d lt.eq d_(p), A_(1), …, A_(d) subset 1, …, n, |A_(i)| lt.eq r) || O_(A_(1), …, A_(d))||_(infinity) thin thin thin sum_(d=0)^(d_(p)) frac(1, d!) sum_(A_(1),…,A_(d) subset {1,…,n}, |A_(i)| lt.eq r) | O_(A_(1),…,A_(d)) |_(infinity) \
& lt.eq (2n r)^(r d_(p)) d_(p)^(d_(p)) ( sum_(d=0)^(d_(p)) frac(1, d!) sum_(A_(1),…,A_(d) subset {1,…,n}, |A_(i)| lt.eq r) | O_(A_(1),…,A_(d)) |_(infinity))^(2) $





Here, we have used the fundamental Schatten-$p$ norm relation $parallel X parallel_2 lt.eq sqrt(upright("dim") ( X )) parallel X parallel_oo$, as well as the assumption that each $O_(A_1 , dots.h , A_d)$ is supported on a total tensor product space with dimension $2^(r d)$ (a tensor product of $d$ subsystems comprised of at most $r$ qubits each).


The second to last inequality follow from using $sum_i x_i^2 lt.eq max_i | x_i | sum_i | x_i |$, and Stirling's formula. The final simplifications uses Stirling's formula again as well as the fact that $sum_i | x_i | gt.eq max_i | x_i |$.


== Physical assumptions about classifying quantum phases of matter
<sec:phases-assumption>


We want to learn how to classify two phases of $n$-qubit states: either $rho$ belongs to phase $A$ ($y ( rho ) = + 1$) or $rho$ belongs to phase $B$ ($y ( rho ) = - 1$). We assume that we have access to labeled classical shadows: ${( S_T ( rho_ell ) , y ( rho_ell ) ) : #h(0em) ell in ( 1 , dots.h , N )}$, where each $S_T ( rho_ell )$ is classical shadow data obtained from performing $T$ randomized single-qubit measurements on independent copies of $rho_ell$. We can use this raw data to form classical representations $sigma_T ( rho_ell )$ of the underlying quantum state $rho_ell$, see Eq.~#ref(<eq:sigma-T-shadow>, supplement: none). The number $T$ determines the resolution of these approximations. Note that $sigma_T ( rho_ell ) approx rho_ell$ can only become exact for $T gt.eq exp (Omega ( n ))$ @guta2020fast @haah2017sample. This would be far too costly for experimental implementations and efficient data processing. For instance, recall from Eq.~#ref(<eq:shadow-kernel-evaluation-cost>, supplement: none) that a single shadow kernel evaluation scales quadratically in $T$. In this section, we show that we can choose much coarser resolutions if the underlying phase can be classified by a nice analytic function on reduced density matrices.


#thmbox("assumption", "Assumption (well-conditioned phase separation)")[


Consider two phases among $n$-qubit states. For $epsilon.alt > 0$, we assume that there exists a function $f$ on reduced $r$-body density matrices $rho_A = upright("tr")_(not A) ( rho )$ that can distinguish the two phases in question. In particular, $  $<eq:classification-assumption>


$ f(rho) & = f( {rho_(A):med A subset{1,…,n},|A| lt.eq r} ) quad "satisfies" \
f(rho) & quad > +1 & "for all rho that belong to phase A (y(rho)=+1)", \
< -1 & "for all rho that belong to phase B (y(rho)=-1)" . $





Moreover, we assume that $f ( rho )$ can be approximated by a truncated power series


$ f^(( d_p )) ( rho ) = sum_(d = 0)^(d_p) frac(1, d !) sum_(A_1 , dots.h , A_d subset ( 1 , dots.h , n ) , | A_i | lt.eq r) upright("tr") (O_(A_1 , dots.h , A_d) rho_(A_1) ⊗ dots.h.c ⊗ rho_(A_d)) , $<eq:polynomial-approximation>


up to constant accuracy: $lr(|f ( rho ) - f^(( d_p )) ( rho )|) lt.eq 0.25$ for all $n$-qubit quantum states $rho$. We refer to $d_p$ as the truncation degree and define the normalization constant


$ C = sum_(d = 0)^(d_p) frac(1, d !) ( sum_(A_1 , dots.h , A_d subset ( 1 , dots.h , n ) , | A_i | lt.eq r) parallel O_(A_1 , dots.h , A_d) parallel_oo ) . $


] <as:phase-separation>


We don't need to know the normalization constant exactly. An upper bound is fully adequate for the theoretical analysis presented in this section.


Morally, the second part of Assumption~@as:phase-separation requires that the phase classication function can be well-approximated by a degree-$d_p$-polynomial in reduced density matrices. The actual formulation is general enough to encompass most physically relevant functions. Let us illustrate this by means of three popular examples.


==== Subsystem purity:
<subsystem-purity>
Fix a subsystem $A subset (1 , dots.h , n)$ comprised of $| A | = r$ qubits and let $rho_A = upright("tr")_(not A) ( rho )$ be the associated $r$-body density matrix. The subsystem purity $f ( rho ) = upright("tr") ( rho_A^2 )$ is a quadratic polynomial in this reduced density matrix. We can rewrite this as $f^(( 2 )) ( rho ) = upright("tr") ( S_A rho_A ⊗ rho_A )$, where $S_A$ denotes the swap operator between two copies of the subsystem $A$. This reformulation is also an #emph[exact] approximation of $f ( rho )$ with degree $d_p = 2$ and normalization constant $C = frac(1, 2 !) parallel S_A parallel_oo = 1 / 2$. These arguments readily extend to averages of multiple subsystem purities.


==== Subsystem Rényi entropy:
<subsystem-rényi-entropy>
Let us consider the subsystem Rényi entropy of order two $H_2 ( rho_A ) = - log (upright("tr") ( rho_A^2 ))$ (the argument will generalize straightforwardly to higher order entropies). This function is closely related to the subsystem purity, but also features a logarithm. And, although the logarithm is #emph[not] a polynomial, $- log ( 1 - x )$ can be accurately approximated by the truncated Mercator series. A crude, but sufficient, bound ensures


$ l^((d_(p)))(x) = sum_(d=1)^(d_(p)) frac(1, d)x^(d) quad "obeys" quad | l^((d_(p)))(x)- log (1-x)| lt.eq x^(d_(p)) log (1/(1-x)) quad "for x in (-1,1)." $


We can now approximate $H_2 ( rho_A ) = - log (1 - ( 1 - upright("tr") ( rho_A^2 ) ))$ by $l^(( d_p )) ( 1 - upright("tr") ( rho_A^2 ) )$. Subsystem purities necessarily obey $upright("tr") ( rho_A^2 ) gt.eq 2^(- | A |) = 2^(- r)$. This allows us to conclude


$ lr(|l^(( d_p )) (1 - upright("tr") ( rho_A^2 )) - H_2 ( rho_A )|) lt.eq (1 - 2^(- r))^(d_p) r log ( 2 ) lt.eq log ( 2 ) r exp (- d_p / 2^r) $


which drops beneath $0.25$ if we set $d_p = log ( 4 log ( 2 ) r ) 2^r = cal(O) (log ( r ) 2^r)$. This degree scales exponentially in the subsystem size $r$, but is independent of total dimension. We can also use $1 = upright("tr") ( rho_A )^2 = upright("tr") (bb(I)_A^(⊗ 2) rho_A^(⊗ 2))$ and $upright("tr") ( X ) upright("tr") ( Y ) = upright("tr") ( X ⊗ Y )$ to bring this polynomial approximation onto the form advertised in Eq.~#ref(<eq:polynomial-approximation>, supplement: none). Indeed, $  $


$ l^(( d_p )) (1 - upright("tr") ( rho_A^2 )) = & l^(( d_p )) (upright("tr") (( bb(I)_A^(⊗ 2) - S_A ) rho_A^(⊗ 2))) = sum_(d = 1)^(d_p) frac(1, d !) upright("tr") (( d - 1 ) ! (bb(I)_A^(⊗ 2) - S_A)^(⊗ d) rho_A^(⊗ 2 d)) quad upright("and")\
C = & sum_(d = 1)^(d_p) frac(1, d !) ∥( d - 1 ) ! ( bb(I)_A^(⊗ 2) - S_A )^(⊗ d)∥_oo = sum_(d = 1)^(d_p) 1 / d ∥bb(I)_A^(⊗ 2) - S_A∥_oo^d = sum_(d = 1)^(d_p) 1 / d approx log ( d_p ) . $





This analysis readily extends to higher order Rényi entropies, as well as averages over multiple subsystems.


==== Entanglement entropy:
<entanglement-entropy>
This is where things start to get somewhat interesting, because the entanglement (von Neumann) entropy $H ( rho_A ) = - upright("tr") (rho_A log ( rho_A )) in [ 0 , r log ( 2 ) ]$ of a $r$-body subsystem is notoriously difficult to accurately approximate with a polynomial @Fawzi2019. Fortunately, Assumption~@as:phase-separation does not require an accurate approximation -- a constant error of size $1 / 4$ is fine. To achieve this goal, we make the following polynomial ansatz in the reduced density matrix $rho_A$:


$ H^(( d_p )) ( rho_A ) = - "tr" ((rho_A - bb(I)_A) + sum_(k = 2)^(d_p) frac((bb(I)_A - rho_A)^k, k ( k - 1 ))) $


Let $lambda_i$ denote the eigenvalues of a subsystem density matrix $rho_A$ and note that there are $2^r$ eigenvalues in $rho_A$. We can rewrite the entanglement entropy and the polynomial ansatz as $  $


$ H ( rho_A ) & = - sum_(i = 1)^(2^r) lambda_i log ( lambda_i ) quad upright("and")\
H^(( d_p )) ( rho_A ) & = - sum_(i = 1)^(2^r) (( lambda_i - 1 ) + sum_(k = 2)^(d_p) frac((1 - lambda_i)^k, k ( k - 1 ))) , $





respectively.


Using Taylor's theorem in the interval $[ 0 , 1 ]$, we have


$ x log ( x ) = ( x - 1 ) + (sum_(k = 2)^oo frac(( 1 - x )^k, k ( k - 1 ))) . $<eq:xlogx-taylor>


Note that at $x = 0$, $x log x = 0$ and the infinite sum comprising the second term on the right hand side also converges to $1$. This ensures that the above equality is valid for the closed interval $[ 0 , 1 ]$. We shall also use the following identity


$ sum_(k = 2)^n frac(1, k ( k - 1 )) = 1 - 1 / n , $<eq:partialsum>


which remains valid even in the limit $n arrow.r oo$. We can combine Eq.~#ref(<eq:xlogx-taylor>, supplement: none)~and~@eq:partialsum to obtain an approximation error for our polynomial ansatz function. For all $x in [ 0 , 1 ]$, we have


$ lr(|x log ( x ) - (( x - 1 ) + (sum_(k = 2)^(d_p) frac(( 1 - x )^k, k ( k - 1 ))))|) lt.eq sum_(k = d_p + 1)^oo frac(( 1 - x )^k, k ( k - 1 )) lt.eq sum_(k = d_p + 1)^oo frac(1, k ( k - 1 )) = 1 / d_p . $


This allows us to bound the approximation error for each individual eigenvalue $lambda_i in [ 0 , 1 ]$ of $rho_A$. There are in total $2^r$ eigenvalues and a triangle inequality asserts


$ | H ( rho_A ) - H^(( d_p )) ( rho_A ) | lt.eq sum_(i = 1)^(2^r) lr(|lambda_i log ( lambda_i ) - (( lambda_i - 1 ) + (sum_(k = 2)^(d_p) frac(( 1 - lambda_i )^k, k ( k - 1 ))))|) lt.eq 2^d / d_p . $


By choosing $d_p = 2^(r + 2)$, we can approximate the entanglement entropy in $r$-body subsystem by a polynomial function. As long as the subsystem size $r$ is a constant independent of total system size $n$, the polynomial approximation degree $d_p$ is also a constant. And it is not hard to check that the same is true for the normalization constant $C$. This analysis readily extends to averages of multiple entanglement entropies.


== Training with shadow kernels
<sec:train-shadowkernel>


We are now ready to dive into the main results of this section: converting Assumption~@as:phase-separation into a statement about classical shadows and their expressiveness when it comes to training a support vector machine. Our measure of similarity is the #emph[shadow kernel]~@eq:shadow-kernel evaluated on classical shadows. The kernel matrix is


$ [bold(bold(K))]_(ell ell')= k^("(shadow)") ( S_(T)(rho_(ell)),S_(T) (rho_(ell')) ) quad "for" ell, ell' in {1,…,N}, $


and implicitly specifies the feature map, as well as the nonlinear geometry with respect to which we want to find classifiers for phases. We begin by approximating the true classifier, given as a nonlinear function $f ( rho )$ in Assumption~@as:phase-separation, by a finite power series $f^(( d_p )) ( rho )$ with degree-$d_p$. We will then use $f^(( d_p )) ( rho )$ as an approximate phase classifier. Recalling Eq.~#ref(<eq:feature-linearization>, supplement: none), a finite power series $f^(( d_p )) ( S_T ( rho ) )$ is linear in feature space, with its corresponding dual vector $bold(upright(bold(alpha)))_f$ defining a candidate hyperplane for separating the two phases. To complete the connection to the support vector machines from @sec:trainSVM, we must ensure that $f^(( d_p )) ( S_T ( rho ) )$ does not differ substantially from the approximate phase classifier $f^(( d_p )) ( rho )$ from Assumption~@as:phase-separation. This is the content of the following auxiliary statement.


#thmbox("lemma", "Lemma")[


Suppose that Assumption~@as:phase-separation is valid for a function on reduced $r$-body density matrices with the two constants $C gt.eq 1$ and $d_p in bb(N)$. For any $0 < epsilon.alt < 1$, classical shadows of size


$ T = ( 32 / 3 ) d_p^2 C^2 12^r (r (log ( n ) + log ( 12 )) + log ( 1 / delta )) / epsilon.alt^2 $


suffice to $epsilon.alt$-approximate $f^(( d_p )) ( rho )$ with high probability. In particular, for any density matrix $rho in bb(H)_2^(⊗ n)$,


$ lr(|f^(( d_p )) ( S_T ( rho ) ) - f^(( d_p )) ( rho )|) lt.eq epsilon.alt $


with probability at least $1 - delta$ (over the randomized measurement settings and outcomes producing $S_T ( rho )$).


] <lem:function-approximation-shadows>


A proof can be found at the end of this subsection. With high probability, this statement ensures that existence of a well-conditioned phase separation implies the existence of a separating hyperplane in shadow feature space. This, in turn, is enough to ensure that the SVM training stage can be executed perfectly: solving the training problem~@eq:training-problem efficiently yields a separating hyperplane parametrization $bold(upright(bold(alpha)))_sharp$ that (1) lies in the subspace $bb(R)^N$ of $cal(F)^(upright("(shadow)"))$ spanned by the $N$ training vectors, and (2) performs at least as well as $bold(upright(bold(alpha)))_f$. Since we are guaranteed that $bold(upright(bold(alpha)))_f$ separates training data perfectly and achieves zero training error, $bold(upright(bold(alpha)))_sharp$ must be at least as good: $upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) lt.eq upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_f ) = 0$ with high probability. The main result of this section formalizes this observation.


#thmbox("proposition", "Proposition")[


Suppose that Assumption~@as:phase-separation is valid for some function on reduced $r$-body density matrices with normalization constant $C$ and truncation degree $d_p$. Then, for $delta in ( 0 , 1 )$, a (joint) classical shadow size $T = ( 512 / 3 ) d_p^2 C^2 12^r (r (log ( n ) + log ( 12 )) + log ( N / delta ))$ ensures that we can achieve zero training error when solving~@eq:training-problem with squared margin constant $Lambda^2 = 4 (2 r n)^(r d_p) d_p^(d_p) C^2$.


] <prop:zero-training-error>


The extra constraint $Lambda^2 gt.eq chevron.l bold(upright(bold(alpha)))_f , bold(upright(bold(alpha)))_f chevron.r_(cal(F)^(upright("(finite)")))$ ensures that the ideal separating hyperplane is a feasible point of the training problem~@eq:training-problem.


#block[
#emph[Proof of @prop:zero-training-error.]~◻

]


We establish the claim not for the shadow kernel itself ($k^(upright("(shadow)")) ( dot.op , dot.op )$), but for large finite-dimensional approximations ($k^(upright("(finite)")) ( dot.op , dot.op )$) thereof. We begin by utilizing Eq.~#ref(<eq:polynomial-approximation>, supplement: none) that approximates the nonlinear function $f ( rho )$ by a finite power series $f^(( d_p )) ( rho )$ with the approximation error,


$ | f ( rho ) - f^(( d_p )) ( rho ) | lt.eq 0.25 . $


For each $ell in ( 1 , dots.h , N )$, we invoke @lem:function-approximation-shadows using the truncated Taylor series to conclude


$ upright("Pr") [| f^(( d_p )) ( rho_ell ) - f^(( d_p )) (S_T ( rho_ell )) | gt.eq 0.25] lt.eq delta / N , $


provided that $T = ( 512 / 3 ) d_p^2 C^2 12^r (r (log ( n ) + log ( 12 )) + log ( N / delta ))$. Triangle inequality and a union bound allows us to combine these approximation guarantees into a single statement:


$ max_(1 lt.eq ell lt.eq N) | f (rho_(ell)) - f^((d_(p))) ( S_(T) (rho_(ell)) ) | lt.eq 0.5 quad "with probability (at least) 1-delta." $ <eq:training-error-aux1>


Let us condition on this desirable event and also assume hat the cutoff values of our finite kernel approximation are large enough, i.e.~$D gt.eq d_p$, $R gt.eq r$). Then, the function


$ 2 f^(( d_p )) ( S_T ( rho_ell ) ) = chevron.l bold(upright(bold(alpha)))_f , phi.alt^(upright("(finite)")) ( S_T ( rho_ell ) ) chevron.r $


describes a linear function in feature space $cal(F)^(upright("(finite)"))$ that is guaranteed to achieve zero training error. Indeed, combine Eq.~#ref(<eq:classification-assumption>, supplement: none) and Eq.~#ref(<eq:training-error-aux1>, supplement: none) to ensure $lr(|2 f^(( d_p )) ( S_T ( rho_ell ) )|) gt.eq 2 ( lr(|f ( rho_ell )|) - lr(|f ( rho_ell ) - f^(( d_p )) ( S_T ( rho_ell ) )|) ) gt.eq 2 ( 1 - 0.5 ) = 1$ and, moreover, $upright("sign") (f^(( d_p )) ( S_T ( rho_ell ) )) = upright("sign") (f ( rho_ell )) = y ( rho_ell ) in {plus.minus 1}$ for all $ell in ( 1 , dots.h , N )$. In turn, $  $


$ sum_(ell = 1)^N max (0 , 1 - y ( rho_ell ) chevron.l bold(upright(bold(alpha)))_f , phi.alt^(upright("(finite)")) (S_T ( rho_ell )) chevron.r) & = sum_(ell = 1)^N max (0 , 1 - upright("sign") (f^(( d_p )) ( S_T ( rho_ell ) )) 2 f^(( d_p )) (S_T ( rho_ell )))\
 & = sum_(ell = 1)^N max (0 , 1 - lr(|f^(( d_p )) (S_T ( rho_ell ))|)) = 0 . $





Since zero is the smallest possible training error,


the minimizer of the original training problem~@eq:training-problem must also achieve zero, provided that $bold(upright(bold(alpha)))_f$ is actually a feasible point of this optimization. We can, however, ensure this by choosing the squared margin constant large enough. Eq.~#ref(<eq:separator-size>, supplement: none) and Assumption~@as:phase-separation ensures


$ chevron.l bold(upright(bold(alpha)))_f , bold(upright(bold(alpha)))_f chevron.r_(cal(F)^(upright("(finite)"))) lt.eq 4 (2 r n)^(r d_p) d_p^(d_p) C^2 . $


Choosing a squared margin size $Lambda^2$ that exceeds this bound ensures that $bold(upright(bold(alpha)))_f$ is indeed a feasible point of the training problem~@eq:training-problem and the claim follows.






We conclude our discussion on training with shadow kernels by providing a rigorous proof of the auxiliary statement.


#block[
#emph[Proof of @lem:function-approximation-shadows.]~◻

]


It suffices to analyze implications of @lem:subsystem-approximation: for $eta , delta in ( 0 , 1 )$


$ T gt.eq ( 8 / 3 ) 12^r (r (log ( n ) + log ( 12 )) + log ( 1 / delta )) / eta^2 #h(0em) arrow.r.double #h(0em) max_(A subset ( 1 , dots.h , n ) , | A | lt.eq r) ∥upright("tr")_(not A) (sigma_T ( rho )) - upright("tr")_(not A) ( rho )∥_1 lt.eq eta $<eq:reduced-densities-claim>


with probability at least $1 - delta$. Here, $parallel dot.op parallel_1$ denotes the trace norm. Abbreviate $upright("tr")_(not A_i) (sigma_T ( rho ))$ and $upright("tr")_(not A_i) ( rho )$ as $sigma_(A_i)$ and $rho_(A_i)$, respectively. A combination of triangle inequalities and Matrix Hoelder ($upright("tr") ( X Y ) lt.eq parallel X parallel_oo parallel Y parallel_1$) asserts $  $<eq:approximation-aux1>


$  & lr(|f^(( d_p )) ( rho ) - f^(( d_p )) (S_T ( rho ))|)\
 & lt.eq sum_(d = 0)^(d_p) frac(1, d !) sum_(A_1 , dots.h , A_d subset ( 1 , dots.h , n ) , | A_i | lt.eq r) lr(|upright("tr") (O_(A_1 , dots.h , A_r) (rho_(A_1) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_1) ⊗ dots.h.c ⊗ sigma_(A_d)))|)\
 & lt.eq sum_(d = 0)^(d_p) frac(1, d !) sum_(A_1 , dots.h , A_d subset ( 1 , dots.h , n ) , | A_i | lt.eq r) ∥O_(A_1 , dots.h , A_d)∥_oo ∥rho_(A_1) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_1) ⊗ dots.h.c ⊗ sigma_(A_d)∥_1 . $





Next, we fix a trace norm contribution and


use a telescoping trick ($A_1 ⊗ A_2 - B_1 ⊗ B_2 = ( A_1 - B_1 ) ⊗ A_2 + B_1 ⊗ ( A_2 - B_2 )$), as well as a triangle inequality and $parallel rho_(A_i) parallel_1 = upright("tr") ( rho_(A_i) ) = 1$ to infer $  $


$  & ∥rho_(A_1) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_1) ⊗ dots.h.c ⊗ sigma_(A_d)∥_1\
 & = ∥(rho_(A_1) - sigma_(A_1)) ⊗ rho_(A_2) ⊗ dots.h.c ⊗ rho_(A_d) + sigma_(A_1) ⊗ (rho_(A_2) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_2) ⊗ dots.h.c ⊗ sigma_(A_d))∥_1\
 & lt.eq parallel rho_(A_1) - sigma_(A_1) parallel_1 parallel rho_(A_2) parallel_1 dots.h.c parallel rho_(A_d) parallel_1 + parallel sigma_(A_1) parallel_1 ∥rho_(A_2) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_1) ⊗ dots.h.c ⊗ sigma_(A_d)∥_1\
 & lt.eq parallel rho_(A_1) - sigma_(A_1) parallel_1 + (1 + parallel rho_(A_1) - sigma_(A_1) parallel_1) ∥rho_(A_2) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_1) ⊗ dots.h.c ⊗ sigma_(A_d)∥_1\
 & lt.eq eta + ( 1 + eta ) parallel rho_(A_2) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_1) ⊗ sigma_(A_d) parallel_1 . $





The last line follows from Rel.~@eq:reduced-densities-claim. Iterating this simplification procedure ensures


$ ∥rho_(A_1) ⊗ dots.h.c ⊗ rho_(A_d) - sigma_(A_1) ⊗ dots.h.c ⊗ sigma_(A_d)∥_1 lt.eq eta sum_(k = 0)^(d - 1) ( 1 + eta )^k = ( 1 + eta )^d - 1 . $


According to Rel.~@eq:reduced-densities-claim, such an upper bound is valid for every trace norm contribution in Eq.~#ref(<eq:approximation-aux1>, supplement: none). This allows us to obtain $  $


$ lr(|f^(( d_p )) ( rho ) - f^(( d_p )) (S_T ( rho ))|) & lt.eq sum_(d = 0)^(d_p) frac(1, d !) sum_(A_1 , dots.h , A_d subset ( 1 , dots.h , n ) , | A_i | lt.eq r) ∥O_(A_1 , dots.h , A_d)∥_oo [( 1 + eta )^d - 1]\
 & lt.eq [( 1 + eta )^(d_p) - 1] sum_(d = 0)^(d_p) frac(1, d !) sum_(A_1 , dots.h , A_d subset ( 1 , dots.h , n ) , | A_i | lt.eq r) ∥O_(A_1 , dots.h , A_d)∥_oo\
 & = C [( 1 + eta )^(d_p) - 1] . $





Here, we have used Assumption~@as:phase-separation.


Finally, by choosing $eta = epsilon.alt / ( 2 C d_p )$, we can see that


$ lr(|f^(( d_p )) ( rho ) - f^(( d_p )) (S_T ( rho ))|) lt.eq C [(1 + frac(epsilon.alt, 2 C d_p))^(d_p) - 1] lt.eq C [ exp ( epsilon.alt / 2 C ) - 1 ] lt.eq epsilon.alt . $


The second inequality follows from $( 1 + x / n )^n lt.eq exp ( x ) , forall | x | lt.eq n , n gt.eq 1$. The third inequality utilizes $exp ( x ) lt.eq 1 + 2 x , forall x in [ 0 , 1 ]$.


The claim of @lem:function-approximation-shadows now follows from inserting this specific choice of $eta$ into Rel.~@eq:reduced-densities-claim.






== Prediction based on shadow kernels
<sec:predict-shadowkernel>


We now have all pieces in place to prove strong bounds on the prediction error of a SVM based on shadow kernels. The main result of this section will be a consequence of @thm:svm-prediction. For fixed parameters $tau , gamma = 1$, the shadow kernel~@eq:shadow-kernel (and finite approximations thereof) is always bounded when applied to classical shadows. Eq.~#ref(<eq:kernel-upper-bound>, supplement: none) (under $tau = gamma = 1$) asserts


$ k^(upright("(") thin upright("shadow") thin upright(")")) (S_T ( rho_1 ) , tilde(S)_T ( rho_2 )) lt.eq exp (exp (5)) $


for any $T$ and quantum states $rho_1 , rho_2$. This bound readily extends to finite dimensional approximations $k^(upright("(finite)")) ( dot.op , dot.op )$. Next, we need to specify a distribution. We assume that $tilde(cal(D))$ is a distribution over $n$-qubit quantum states $rho$ that either belong to phase $A$ or phase $B$. We sample quantum states $rho_ell tilde tilde(cal(D))$ accordingly, but are not permitted to process them directly. Instead, we obtain a (randomly generated) classical shadow of size $T$. Denote the raw data by $S_T ( rho_ell )$ which allows us to produce a state approximation $sigma_T ( rho_ell )$. We do, however, require that we have direct access to the label $y ( rho_ell ) in {plus.minus 1}$ associated with the phase of $rho_ell$. This produces a joint distribution over input data $S_T ( rho_ell )$ and the label $y ( rho_ell )$ which we call $cal(D)$. In summary, we assume that training data and new data are generated independently from this data distribution: $(S_T ( rho_1 ) , y ( rho_1 )) , dots.h , (S_T ( rho_N ) , y ( rho_N )) , (S_T ( rho ) , y) tilde cal(D)$. We are now ready to combine @thm:svm-prediction (the prediction error is bounded by the training error) and @prop:zero-training-error (the training error vanishes if a good phase classifier exists) to obtain a powerful result about generalization.


#thmbox("corollary", "Corollary")[


Fix $delta , epsilon.alt in ( 0 , 1 )$ and suppose there exists an analytic function on reduced $r$-body density matrices that can distinguish phases: $f ( rho ) > 1$ if $rho in upright("phase ") A$ and $f ( rho ) < - 1$ else if $rho in upright("phase ") B$. Let $C$ be the normalization constant and $d_p$ be the truncation degree given in Assumption~@as:phase-separation. Suppose that we obtain identically distributed training data $(S_T ( rho_1 ) , y ( rho_1 )) , dots.h , (S_T ( rho_N ) , y ( rho_N )) tilde cal(D)$ such that $  $


$ T & gt.eq ( 512 / 3 ) d_p^2 C^2 12^r (r (log ( n ) + log ( 12 )) + log ( N / delta )) quad upright("and")\
N & gt.eq 256 (2 r n)^(r d_p) d_p^(d_p) C^2 exp ( exp ( 5 ) ) log ( 4 / delta ) / epsilon.alt^2 . $





Then, solving the training problem~@eq:training-problem for the shadow kernel with squared margin constant $Lambda^2 = 4 (2 r n)^(r d_p) d_p^(d_p) C^2$ will produce a hyperplane $bold(upright(bold(alpha)))_sharp in bb(R)^N$ in shadow feature space that achieves zero training error with probability (at least) $1 - delta / 2$.


Conditioned on perfect training, the resulting classifier


$ y_sharp (S_T ( rho )) = upright("sign") ( sum_(ell = 1)^N [bold(upright(bold(alpha)))_sharp]_ell k^(upright("(") thin upright("shadow") thin upright(")")) ( S_T ( rho_ell ) , S_T ( rho ) ) ) in {plus.minus 1} $


achieves, with probability (at least) $1 - delta / 2$,


$ upright("Pr")_(( S_T ( rho ) , y ( rho ) )) [y_sharp (S_T ( rho )) eq.not y ( rho )] lt.eq epsilon.alt med . $


] <cor:shadow-prediction>


The total probability of success is (at least) $1 - delta$ and follows from a union bound over either desirable event failing. Theorem~@cor:shadow-prediction is contingent on four core assumptions:

+ It must be possible to distinguish phases $A$ and $B$ by evaluating a well-conditioned analytical function on reduced $r$-body density matrices. The coefficients in the power series of the analytical function should also be bounded, but explicit knowledge is #emph[not] necessary. This is the content of Assumption~@as:phase-separation.

+ We use classical shadow raw data to read-in training data ($rho_ell mapsto S_T ( rho_ell )$) and process new states in the prediction phase ($rho mapsto S_T ( rho )$). We assume that each classical shadow arises from $T$ randomized single-qubit Pauli measurements on independent state copies. The larger $T$, the more accurate these representations become. Theorem~@cor:shadow-prediction requires $T gt.eq ( 512 / 3 ) d_p^2 C^2 12^r (r (log ( n ) + log ( 12 )) + log ( N / delta )) = cal(O) (r 12^r d_p^2 C^2 log ( n N / delta ) ))$. If $r , C , d_p$ are constants, this resolution only scales polylogarithmically in system size $n$ because $N$ scales polynomially in $n$\; see the next bullet point.

+ The training data size must not be too small either. We need to have a training data size $N$ of order at least $(2 r n)^(r d_p) d_p^(d_p) C^2 exp ( exp ( 5 ) ) log ( 4 / delta ) / epsilon.alt^2$. As long as $r , C , d_p$ are constants (independent of system size $n$), this requirement simplifies to $N = cal(O) (n^(r d_p) log ( 1 / delta ) / epsilon.alt^2)$. Hence, the number scales polynomially in system size $n$.

+ The squared margin constant also scales polynomially with system size $n$: $Lambda^2 = 4 (2 r n)^(r d_p) d_p^(d_p) C^2 = cal(O) (n^(r d_p))$ if $r , C , d_p = upright("const")$. This is equivalent to demanding that the minimal margin $2 / Lambda$ scales inverse polynomially in system size $n$.


@cor:shadow-prediction does not only bound a hypothetical training error. The required shadow size $T$ and training data size $N$ both scale favorably in the number of qubits $n$. This also ensures that the numerical costs behind this procedure remain tractable for a wide range of system sizes. The costs associated with storage (classical shadows are sums of $T$ elementary tensor products), training (can be reduced to a QCQP in $N$ dimensions per @sec:trainSVM) and prediction (execute Formula~@eq:prediction-function) all scale polynomially in system size $n$, shadow size $T$, and training data size $N$.


#block[
#emph[Proof of @cor:shadow-prediction.]~◻

]


Again, we establish the claim for large, but finite-dimensional, approximations to the shadow kernel ($1 lt.eq d_p lt.double D < oo$ and $1 lt.eq r lt.double R < oo$). Fix $delta in ( 0 , 1 )$ (probability of failure) and $epsilon.alt in ( 0 , 1 )$ (bound on average prediction error). Consider the data distribution $(S_T ( rho ) , y ( rho )) tilde cal(D)$, the kernel $k^(upright("(finite)")) ( dot.op , dot.op )$ -- which obeys $k^(upright("(finite)")) (S_T ( rho ) , S_T ( rho )) lt.eq exp (exp ( 5 ))$ -- and a squared margin constant $Lambda^2$ to be specified later. Assume $Lambda^2 exp ( exp ( 5 ) ) gt.eq 1$ for simplicity (the other case is similar). Then, for training data size $N$, @thm:svm-prediction asserts


$ upright("Pr")_(( S_T ( rho ) , y ( rho ) ) tilde cal(D)) [y_sharp (S_T ( rho )) eq.not y ( rho )] lt.eq 1 / N upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) + 8 sqrt(Lambda^2 exp ( exp ( 5 ) ) frac(log ( 4 / delta ), N)) , $


with probability (at least) $1 - delta / 2$. Choosing $N$ large enough allows us to suppress the second contribution beneath the desired approximation error bound:


$ N gt.eq 64 Lambda^2 exp ( exp ( 5 ) ) log ( 4 / delta ) / epsilon.alt^2 quad arrow.r.double quad upright("Pr")_(( S_T ( rho ) , y ( rho ) ) tilde cal(D)) [y_sharp (S_T ( rho )) eq.not y ( rho )] lt.eq 1 / N upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) + epsilon.alt , $<eq:prediction-aux1>


with probability (at least) $1 - delta / 2$. Here, $upright(E)_(upright("tr")) ( bold(upright(bold(alpha)))_sharp )$ is the training error obtained from solving problem~@eq:training-problem for $N$ independently sampled training data points $(S_T ( rho_1 ) , y ( rho_1 )) , dots.h , (S_T ( rho_N ) , y ( rho_N )) tilde cal(D)$. @prop:zero-training-error asserts that this training error can vanish with high probability, provided that a well-conditioned analytical function on reduced $r$-body density matrices exists that can distinguish the phases (see Assumption~@as:phase-separation).


The classical shadow size $T$ and the squared margin constant $Lambda^2$ depend on the number of body $r$, the normalization constant $C$, and the truncation degree $d_p$ of this classifier:


$  & T & gt.eq & ( 512 / 3 ) d_p^2 C^2 12^r ( r ( log ( n ) + log ( 12 ) ) + log ( N / delta ) ) \
    & Lambda & gt.eq & 4 ( 2 r n )^(r d_p) d_p^(d_p) C^2 quad arrow.r.double upright("E")_(upright("tr")) ( bold(upright(bold(alpha)))_sharp ) = 0 $


with probability (at least) $1 - delta / 2$. The claim now follows from inserting this squared margin size into the expression~@eq:prediction-aux1 for training data size.






= CLASSIFYING SPT PHASES WITH $O ( 2 )$ SYMMETRY USING A FEW-BODY OBSERVABLE
<sec:tasaki>


== Symmetry-protected topological phases
<sec:tasaki1>


We consider a scenario similar to that of @sub:smoothness, namely, a family of Hamiltonians $H ( x )$ parameterized by $x$. We additionally enforce that $H ( x )$ be invariant under certain symmetry transformations, which can include tensor products of on-site rotations, "spatial" transformations permuting the sites, or antiunitary maps characterizing time-reversal. These additional symmetry constraints allow for a fine-grained characterization of $H ( x )$ into various symmetry-protected topological (SPT) phases. Removing said constraints reduces this characterization to the coarser one involving purely topological phases. Similar to the coarser characterization, ground states of $H ( x )$ remain in a particular SPT when the parameters $x$ are varied continuously, as long as the spectral gap of the Hamiltonian remains finite. In other words, the gap has to close at some $x$ in order for the ground states to transition into another phase. When there is a constant spectral gap, it is expected that an operator acting on a local region larger than some constant size independent of the full system size $n$ can classify different SPT phases. The existence of a classifying function of local density matrices has been rigorously established for a handful of cases: $U ( 1 )$-symmetric systems in two dimensions (either noninteracting fermionic @Kitaev2006 @zhang2017quantum or interacting @Hastings2015 @Kapustin2020 @Bachmann2020), and certain spin-$1$ chains in one dimension @Bachmann2014a @tasakiPRL2018 @Tasaki2020.


SPT phases of one-dimensional spin chains with unique ground states, symmetric under tensor-product unitaries forming a symmetry group $G$, are in one-to-one correspondence with the various projective representations realized by $G$ @Chen2011. Projective representations are those in which the group's multiplication table is decorated with phases in a way that is consistent with associativity @Arovas. A genuine (i.e., linear) representation corresponds to the unique trivial projective representation.


Consider, for example, spin chains symmetric under $G = S O ( 3 )$. This group admits two distinct classes of projective representations: one class corresponds to integer spin, and one corresponds to half-integer spin. Thus, there are two different phases for such chains --- the trivial phase and the "Haldane phase" @Haldane1983a @Chen2011.


Relaxing the symmetry group down to its $O ( 2 )$ subgroup maintains the two-phase classification, because $O ( 2 )$ also admits two projective representations @Chen2013. In fact, one can relax the symmetry all the way down to the simplest dihedral subgroup $Z_2 times Z_2$ @Gu2009 @Pollmann2010\; such a classification is similar to that of the model in Appendix~#ref(<sec:numdetail-phases>, supplement: none). We investigate systems admitting the larger $O ( 2 )$ symmetry below, noting that the work we rely on @tasakiPRL2018 @Tasaki2020 also studies symmetry groups that include spatial inversion and time reversal.


== $O ( 2 )$-symmetric qutrit spin chains
<sec:tasaki2>


The representative states for each of the two $O ( 2 )$-symmetric phases for qutrit spin chains are the product state, representing the trivial phase, and the valence-bond-solid (VBS) state @Affleck1988, admitting a projective representation of the symmetry @Tasaki2020 and thus representing the Haldane phase. It has long been known that the expectation value of a nonlocal "twist" operator $O_L$ @Totsuka1995 @nakamura2002a distinguishes these two representative states: $upright("sign") ( chevron.l O_L chevron.r )$ is $+ 1$ for the product state, and $- 1$ for the VBS state. We will see later that, by continuity arguments, this sign will stay constant for other states within the same phase.


In order to work efficiently, our phase classification algorithms require a #emph[local] operator whose expectation value (a) has the same sign as that of $O_L$\; and (b) is above or below a margin (here, $1 / 2$), in order to determine the required accuracy of the classical shadows. Recently, criterion (a) was explicitly demonstrated by Tasaki @tasakiPRL2018 @Tasaki2020 using a local version $O_ell$ of the twist, see Eq.~#ref(<eq:twist>, supplement: none) below. We collect relevant parts of his results to prove both criteria in the theorem below. Due to the existence of a local operator for classifying the SPT phases, our ML algorithms are guaranteed to predict the SPT phases accurately based on the proof given in Appendix~#ref(<sec:proofthmPHASEC>, supplement: none).


#thmbox("theorem", "Theorem")[


Consider the triple $(H ( x ) , | psi ( x ) chevron.r , Delta ( x ))$ containing $( 2 L + 2 )$-site spin-one chains with periodic boundary conditions


$ H ( x ) = sum_(j = - ( L - r ))^(L - r + 1) h_j ( x ) + h_(- L) ( x ) + h_(L + 1) ( x ) $


that admit corresponding unique ground states $| psi ( x ) chevron.r$ and spectral gaps $Delta ( x ) gt.eq gamma = Omega ( 1 )$, bounded interaction strength $norm(h_j(x))_infinity lt.eq R = cal(O)(1)$, and whose terms $h_j ( x )$ are supported on sites $k$ such that $| j - k | lt.eq r = cal(O) ( 1 )$. Assume that $H ( x )$ is $O ( 2 )$-symmetric, with the symmetry group generated by

+ a collective $z$-axis rotation by any angle, and

+ an $x$-axis rotation by $pi$.

There exists a few-body observable $A$, such that for all $x$, we have $  $<eq:toprove>


$ upright("sign") ( chevron.l psi ( x ) | A | psi ( x ) chevron.r ) & = upright("sign") (chevron.l psi ( x ) | O_L | psi ( x ) chevron.r) , quad upright("as well as")\
| chevron.l psi ( x ) | A | psi ( x ) chevron.r | & gt.eq 1 / 2 med . $<eq:toprove-2>





]


#block[
#emph[Proof.] We use spin-one operators $S^(( alpha ))$ with $alpha in ( x , y , z )$ that have eigenvalues $( 0 , plus.minus 1 )$ and satisfy angular-momentum commutation relations $[ S^(( x )) , S^(( y )) ] = upright("iS")^(( z ))$. Eigenstates of $S^(( z ))$ are denoted by $| sigma chevron.r$ with $sigma in ( 0 , plus.minus 1 )$. A rotation around axis $alpha$ is a unitary operator generated by the corresponding $S^(( alpha ))$. The two symmetry group generators are, for $theta in [ 0 , 2 pi )$,~◻

]


$ U (theta) = ⨂_(j = - L)^(L + 1) e^(- upright(i) theta S_j^(( z ))) thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin upright("and") thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin V = ⨂_(j = - L)^(L + 1) e^(- upright(i) pi S_j^(( x ))) thin . $<eq:rotinv>


By assumption, both symmetries commute with each Hamiltonian term $h_j$\; we will explicitly use both to prove the theorem. We will also need superimposed versions $S^(( plus.minus )) = S^(( x )) plus.minus upright("iS")^(( y ))$, which satisfy


$ e^(upright(i) phi.alt S^(( z ))) S^(( plus.minus )) e^(- upright(i) phi.alt S^(( z ))) = S^(( plus.minus )) e^(plus.minus upright(i) phi.alt) thin . $<eq:spin-rotation>


The family of unitary twist operators @Affleck1986a, acting on an interval of $2 ell$ spins centered at the origin, is


$ O_ell = ⨂_(k thin , thin lr(|k - 1 / 2|) lt.eq ell + 1 / 2) exp (- upright(i) 2 pi frac(k + ell, 2 ell + 1) S_k^(( z ))) thin . $<eq:twist>


Each site's rotation is by a multiple of $2 pi / ( 2 ell + 1 )$ that is proportional to the site index, forming the namesake twist pattern. The $ell = L$ case reduces to the aforementioned nonlocal twist operator $O_L$, while $ell lt.double L$ are its local versions.


Suppressing $x$ dependence, the key property is that the twisted ground state $O_ell | psi chevron.r$ has energy close to that of the ground state. In particular, there exists $C_0 , C_1 > 0$, such that for all $ell gt.eq C_0$, @lem:vanenergy below yields


$ chevron.l psi | O_ell H O_ell^dagger | psi chevron.r - chevron.l psi | H | psi chevron.r lt.eq C_1 / ell thin . $<eq:energies>


The ground state is unique by our assumption of a gap, so the twisted ground state must then become proportional to the ground state as $ell arrow.r oo$. In other words, the magnitude of their overlap must be close to one as long as $ell gt.eq C_0$,


$ lr(|chevron.l psi | O_ell | psi chevron.r|)^2 gt.eq 1 - frac(C_1, Delta ell) thin $<eq:overlap>


see @lem:highoverlap below. The phase of this overlap is either $0$ or $pi$ because the $pi$-rotation $V$ leaves the ground state invariant:


$ chevron.l psi | O_ell | psi chevron.r = chevron.l psi | V^dagger O_ell V | psi chevron.r = chevron.l psi | O_ell^dagger | psi chevron.r = overline(chevron.l psi | O_ell | psi chevron.r) in bb(R) thin . $


Hence, the few-body Hermitian observable $A = ( O_ell + O_ell^dagger ) / 2$ with $ell = max ( 4 gamma / ( 3 C_1 ) , C_0 )$ satisfies


$ | chevron.l psi | A | psi chevron.r | = | chevron.l psi | O_ell | psi chevron.r | gt.eq sqrt(1 - frac(C_1, Delta ell)) gt.eq 1 / 2 med , $<eq:sign>


proving Eq.~(#ref(<eq:toprove-2>, supplement: none)). Note that the required value of $ell$ depends on the gap, and thus also on $x$.


To prove Eq.~(@eq:toprove-2), we need to show that the sign of the twist's expectation value remains the same for any $ell gt.eq max ( 4 gamma / ( 3 C_1 ) , C_0 )$. To do this, first notice that, when $ell$ is relaxed to be a nonnegative real, the twist (@eq:twist) is #emph[continuous] in $ell$. (This can be verified, e.g., by studying the twist's eigenvalues.)


Continuity implies that the expectation value cannot change sign; otherwise, it would have to cross zero, thus violating Eq.~(@eq:sign). Therefore, the sign remains the same, confirming Eq.~(@eq:toprove-2). Similarly, by continuity in $ell$ and $x$, the expectation value maintains its sign within each phase.






The above argument is contingent on two auxiliary statements, which we now prove.


#thmbox("lemma", ([Lemma], [(Vanishing energy difference #cite(<tasakiPRL2018>); Eq. #ref(<eq:energies>, supplement: none))]))[


For constants $C_0 , C_1$, as long as $ell gt.eq C_0$, we have


$ chevron.l psi | O_ell H O_ell^dagger | psi chevron.r - chevron.l psi | H | psi chevron.r lt.eq C_1 / ell . $


] <lem:vanenergy>


#block[
#emph[Proof.] Using the variational principle (which says that the difference in energy between any state and the ground state is nonnegative), plugging in $O_ell$ and $H$, applying $chevron.l psi | O | psi chevron.r lt.eq lr(bar.v.double O bar.v.double)_oo$, and distributing the norm over the sum yields$  $~◻

]


$ chevron.l psi | O_ell H O_ell^dagger | psi chevron.r - chevron.l psi | H | psi chevron.r & lt.eq chevron.l psi | (O_ell H O_ell^dagger + O_ell^dagger H O_ell - 2 H) | psi chevron.r\
 & = sum_(j = - (ell + r))^(ell + r + 1) chevron.l psi | (O_ell h_j O_ell^dagger + O_ell^dagger h_j O_ell - 2 h_j) | psi chevron.r\
 & lt.eq sum_(j = - (ell + r))^(ell + r + 1) lr(bar.v.double O_ell h_j O_ell^dagger + O_ell^dagger h_j O_ell - 2 h_j bar.v.double)_oo $<eq:sumj>



 subequationsNext, we use the finite support and rotational


invariance of $h_j$ from Eq.~(@eq:rotinv) to rotate the twist $O_ell$, $  $


$ O_ell h_j O_ell^dagger & = O_ell U (theta_j) h_j U^dagger (theta_j) O_ell^dagger\
 & = (⨂_(lr(|k - j|) lt.eq r) e^(- upright(i) (frac(2 pi, 2 ell + 1) [k + ell] + theta_j) S_k^(( z )))) h_j (⨂_(lr(|k - j|) lt.eq r) e^(upright(i) (frac(2 pi, 2 ell + 1) [k + ell] + theta_j) S_k^(( z )))) thin , $



 subequationswhere we pick $theta_j = - frac(2 pi, 2 ell + 1) ( j + ell )$


for each $j$. That way, the twist does not affect site $j$, with


$ O_ell h_j O_ell^dagger & = e^(upright(i) frac(2 pi, 2 ell + 1) M_j) h_j e^(- upright(i) frac(2 pi, 2 ell + 1) M_j) thin , thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin upright("and") thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin thin M_j = sum_(| k - j | lt.eq r) (j - k) S_k^(( z )) thin . $<eq:M>


We now expand $h_j$ as a polynomial in $( S_k^(( z )) , S_k^(( plus.minus )) )$. This can be done because products of powers of these operators form a matrix basis for any operator on the chain. For a single site, the set $( S^(( z )) S^(( plus.minus )) , ( S^(( + )) )^2 )$, along with their complex conjugates and some powers of $S^(( z ))$, form the basis of nine matrix units for all $3 times 3$ operators on the site. Tensor products of these operators therefore form a matrix-unit basis for all sites. The conjugation property (@eq:spin-rotation) and Eq.~(@eq:M) imply that each term in the expansion of $h_j$, upon conjugation by $O_ell$, will be imparted with a phase that is some multiple $mu$ of $2 pi / ( 2 ell + 1 )$. Combining all terms with the same phase into $h_(j , mu)$, we have


$ e^(upright(i) frac(2 pi, 2 ell + 1) M_j) h_(j , mu) e^(- upright(i) frac(2 pi, 2 ell + 1) M_j) = h_(j , mu) e^(upright(i) frac(2 pi, 2 ell + 1) mu) thin . $


Moreover, $| mu | lt.eq 2 mu_(upright("max"))$, where $mu_(upright("max")) = sum_(lr(|k - j|) lt.eq r) lr(|j - k|) = r (r + 1)$ is the largest eigenvalue of $M_j$. Plugging this in and expanding the resulting cosine yields$  $


$ lr(bar.v.double O_ell h_j O_ell^dagger + O_ell^dagger h_j O_ell - 2 h_j bar.v.double)_oo & = 2 lr(bar.v.double sum_(lr(|mu|) lt.eq 2 r (r + 1)) [cos (frac(2 pi, 2 ell + 1) mu) - 1] h_(j , mu) bar.v.double)_oo\
 & lt.eq (frac(2 pi, 2 ell + 1))^2 sum_(lr(|mu|) lt.eq 2 r (r + 1)) mu^2 lr(bar.v.double h_(j , mu) bar.v.double)_oo thin . $





Since the spin operators form a matrix-unit basis, each $h_(j , mu)$ is simply $h_j$ with some entries removed. Therefore, the norm of $h_(j , mu)$ is bounded by $R$. Applying that and performing the remaining sum (@eq:sumj) over $j$ yields


$ chevron.l psi | O_ell H O_ell^dagger | psi chevron.r - chevron.l psi | H | psi chevron.r & lt.eq frac(ell + r + 1, (2 ell + 1)^2) 4 pi^2 R (sum_(lr(|mu|) lt.eq 2 r (r + 1)) mu^2) thin . $


Thus, for $ell gt.eq C_0$, the difference in energies between the ground state and twisted ground state will be bounded by $C_1 / ell$,


where $C_0 , C_1$ are two constants depending on the interaction range $r$ and norm bound $R$ of the Hamiltonian terms.






#thmbox("lemma", ([Lemma], [(High overlap #cite(<Tasaki2020>); Eq. #ref(<eq:overlap>, supplement: none))]))[


For constants $C_0 , C_1$, as long as $ell gt.eq C_0$, we have


$ lr(|chevron.l psi | O_ell | psi chevron.r|)^2 gt.eq 1 - frac(C_1, Delta ell) thin . $


] <lem:highoverlap>


#block[
#emph[Proof.] All eigenvalues of $H$ are bounded below by the sum of the ground state energy $E_(upright("gnd")) = chevron.l psi | H | psi chevron.r$ and spectral gap $Delta$,~◻

]


$ H & gt.eq E_(upright("gnd")) | psi chevron.r chevron.l psi | + (E_(upright("gnd")) + Delta) (bb(I) - | psi chevron.r chevron.l psi |) = E_(upright("gnd")) bb(I) + Delta (bb(I) - | psi chevron.r chevron.l psi |) thin . $


Conjugating by $O_ell$ and evaluating the result in the ground state yields


$ chevron.l psi | O_ell H O_ell^dagger | psi chevron.r & gt.eq E_(upright("gnd")) + Delta (1 - lr(|chevron.l psi | O_ell | psi chevron.r|)^2) thin . $


Rearranging this and plugging in @lem:vanenergy yields


the desired result.





#show bibliography: set text(size: 9pt)
#show bibliography: set par(leading: 0.48em, spacing: 1em)
#bibliography("refs.bib", style: "../../typst-refs/plain.csl", title: none)
