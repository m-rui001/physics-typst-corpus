#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.90cm, bottom: 2.40cm), columns: 2)
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
  block(width: 100%, above: 1.2em, below: 0.7em, [#text(size: 9pt, weight: "regular")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
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


#place(top, float: true, scope: "parent", clearance: 1.2em)[
#align(center)[
  #text(14.3pt, weight: "bold", [Noisy intermediate-scale quantum (NISQ) algorithms])   #v(1.2em)
  #text(10.5pt)[Kishor Bharti#super[1]#super[∗], Alba Cervera-Lierta#super[2]#super[∗], Thi Ha Kyaw#super[2]#super[∗], Tobias Haug#super[4], Sumner Alperin-Lea#super[3], Abhinav Anand#super[3], Matthias Degroote#super[2], Hermanni Heimonen#super[1], Jakob S. Kottmann#super[2], Tim Menke#super[6], Wai-Keong Mok#super[1], Sukin Sim#super[9], Leong-Chuan Kwek#super[1], Alán Aspuru-Guzik#super[2]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Centre for Quantum Technologies, National University of Singapore 117543, Singapore] \
  #text(9pt)[#super[2] Department of Computer Science, University of Toronto, Toronto, Ontario M5S 2E4, Canada] \
  #text(9pt)[#super[3] Chemical Physics Theory Group, Department of Chemistry, University of Toronto, Toronto, Ontario M5G 1Z8, Canada] \
  #text(9pt)[#super[4] QOLS, Blackett Laboratory, Imperial College London SW7 2AZ, UK] \
  #text(9pt)[#super[5] current address: Boehringer Ingelheim, Amsterdam, Netherlands] \
  #text(9pt)[#super[6] Department of Physics, Harvard University, Cambridge, MA 02138, USA] \
  #text(9pt)[#super[7] Research Laboratory of Electronics, Massachusetts Institute of Technology, Cambridge, MA 02139, USA] \
  #text(9pt)[#super[8] Department of Physics, Massachusetts Institute of Technology, Cambridge, MA 02139, USA] \
  #text(9pt)[#super[9] Department of Chemistry and Chemical Biology, Harvard University, Cambridge, MA 02138, USA] \
  #text(9pt)[#super[10] MajuLab, CNRS-UNS-NUS-NTU International Joint Research Unit UMI 3654, Singapore] \
  #text(9pt)[#super[11] National Institute of Education and Institute of Advanced Studies, Nanyang Technological University 637616, Singapore] \
  #text(9pt)[#super[12] Vector Institute for Artificial Intelligence, Toronto, Ontario M5S 1M1, Canada] \
  #text(9pt)[#super[13] Canadian Institute for Advanced Research, Toronto, Ontario M5G 1Z8, Canada] \
]
#v(1.2em)



// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: October 7, 2021)]]

A universal fault-tolerant quantum computer that can solve efficiently problems such as integer factorization and unstructured database search requires millions of qubits with low error rates and long coherence times. While the experimental advancement towards realizing such devices will potentially take decades of research, noisy intermediate-scale quantum (NISQ) computers already exist. These computers are composed of hundreds of noisy qubits, i.e. qubits that are not error-corrected, and therefore perform imperfect operations in a limited coherence time. In the search for quantum advantage with these devices, algorithms have been proposed for applications in various disciplines spanning physics, machine learning, quantum chemistry and combinatorial optimization. The goal of such algorithms is to leverage the limited available resources to perform classically challenging tasks. In this review, we provide a thorough summary of NISQ computational paradigms and algorithms. We discuss the key structure of these algorithms, their limitations, and advantages. We additionally provide a comprehensive overview of various benchmarking and software tools useful for programming and testing NISQ devices.

#text(8pt)[#super[∗] These authors contributed equally to this work. #link("kishor.bharti1@gmail.com") #link("a.cervera.lierta@gmail.com") #link("thihakyaw.phy@gmail.com")]
]












= INTRODUCTION
<ch:intro>


Quantum computing originated in the eighties when physicists started to speculate about computational models that integrate the laws of quantum mechanics @kaiser2011hippies. Starting with the pioneering works of Benioff and Deutsch, which involved the study of quantum Turing machines and the notion of universal quantum computation @benioff1980computer @deutsch1985quantum, the field continued to develop towards its natural application: the simulation of quantum systems @feynman1982simulating @lloyd1996universal @manin1980computable. Arguably, the drive for quantum computing took off in 1994 when Peter Shor provided an efficient quantum algorithm for finding prime factors of composite integers, rendering most classical cryptographic protocols unsafe @shor1994algorithms. Since then, the study of quantum algorithms has matured as a sub-field of quantum computing with applications in search and optimization, machine learning, simulation of quantum systems and cryptography~@montanaro2016quantum.


In the last forty years, many scientific disciplines have converged towards the study and development of quantum algorithms and their experimental realization. Quantum computers are, from the computational complexity perspective, fundamentally different tools available to computationally intensive fields. The implementation of quantum algorithms requires that the minimal quantum information units, #emph[qubits], are as reliable as classical bits. Qubits need to be protected from environmental noise that induces decoherence but, at the same time, their states have to be controlled by external agents. This control includes the interaction that generates entanglement between qubits and the measurement operation that extracts the output of the quantum computation. It is technically possible to tame the effect of noise without compromising the quantum information process by developing quantum error correction (QEC) protocols @shor1995scheme @lidar2013quantum @terhal2015quantum. Unfortunately, the overhead of QEC in terms of the number of qubits is, at the present day, still far from current experimental capabilities. To achieve the goal of fault-tolerant quantum computation, the challenge is to scale up the number of qubits with sufficiently high qubit quality and fidelity in operations such as quantum gate implementation and measurement~@aharonov2008fault @knill1998resilient @kitaev2003fault. As the system size grows, it becomes highly challenging to contain the errors associated with cross-talk and measurements below the required error-correction threshold.


Most of the originally proposed quantum algorithms require millions of physical qubits to incorporate these QEC techniques successfully, realizing the daunting goal of building a fault-tolerant quantum computer may take decades. Existing quantum devices contain on the order of 100 phyisical qubits. They are sometimes denoted as "#emph[Noisy Intermediate-Scale Quantum] (NISQ)" devices~@preskill2018quantum, meaning their qubits and quantum operations are not QEC and, therefore, imperfect. One of the goals in the NISQ era is to extract the maximum quantum computational power from current devices while developing techniques that may also be suited for the long-term goal of the fault-tolerant quantum computation~@terhal2015quantum.


== Computational complexity theory in a nutshell
<ch1:subsec:non-complexity>


The definition of a new computational paradigm opens the window to tackle those problems that are inefficient with the existing ones. New computational complexity classes have been recognized through the study of quantum computing, and proposed algorithms and goals have to be developed within well-known mathematical boundaries.


In this review, we will often use some computational complexity-theoretic ideas to establish the domain and efficiency of the quantum algorithms covered. For this reason, we provide in this subsection a brief synopsis for a general audience and refer to @arora2009computational for a more comprehensive treatment.


Widely believed containment relations for some of the complexity classes are shown in a schematic way in @Fig:Complexity.


To understand the internal structure of complexity classes, the idea of "reductions" can be quite useful. One says that problem $A$ is reducible to problem $B$ if a method for solving $B$ implies a method for solving $A$\; one denotes the same by $A lt.eq B$. It is a common practice to assume the reductions as polynomial-time reductions. Intuitively, it could be thought as solving $B$ is at least as difficult as solving $A$. Given a class $C$, a problem $X$ is said to be #emph[$C$-hard] if every problem in class $C$ reduces to $X$. We say a problem $X$ to be #emph[$C$-complete] if $X$ is $C$-hard and also a member of $C$. The $C$-complete problems could be understood as capturing the difficulty of class $C$, since any algorithm which solves one $C$-complete problem can be used to solve any problem in $C$.


A canonical example of a problem in the class $upright("BQP")$ is integer factorization, which can be solved in polynomial time by a quantum computer using Shor's factoring algorithm~@shor1994algorithms. However, no classical polynomial-time algorithm is known for the aforementioned problem. Thus, the integer factorization problem is in BQP, but not believed to be in P~@arora2009computational. While analyzing the performance of algorithms, it is prudent to perform complexity-theoretic sanity checks. For example, though quantum computers are believed to be powerful, they are not widely expected to be able to solve $upright("NP")$-Complete problems, such as the travelling-salesman problem, in polynomial time. The quantum algorithms, however, could provide a speedup with respect to classical algorithms for $upright("NP")$-Complete problems.


// [figvision] imgs/complexity_classes.png
// The figure shows complexity classes as nested rectangles. The outermost green box is EXPTIME, solvable in
// exponential time, labeled unrestricted chess on an n by n board. Inside is red PSPACE, solvable in polynomial
// space, labeled restricted chess on an n by n board. Inside PSPACE is blue QMA, verifiable in polynomial time.
// QMA contains yellow NP, verifiable in polynomial time, enclosing orange NP-Complete labeled traveling salesman
// problem. Also within QMA are peach P labeled testing whether a number is prime, gray integer factorization,
// blue-gray BQP labeled solvable in polynomial time, and bottom blue QMA-Complete labeled quantum hamiltonian
// ground state problem. Nesting suggests containment, some unproven.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [Figure #context it.counter.display(it.numbering) #it.body]
}

#figure(scope: "parent", image("imgs/complexity_classes.png", width: 94%),
  caption: [
    An illustrative picture of some relevant complexity classes together with a problem examples. For the chess example, the word "restricted" refers to a polynomial upper bound on the number of moves. The containment relations are suggestive. Some of them have not been mathematically proven, being a well-known open problem whether $upright("P")$ is equal to $upright("NP")$.
  ]
)
<Fig:Complexity>



== Experimental progress
<subsec:experimental_progress>


Here we present a somewhat biased and not exhausted summary of very recent quantum experiments. Interested readers should consult @acin2018quantum and references therein for more information about various quantum computing architectures.


Experimental progress in quantum computation can be measured by different figures of merit. The number of physical qubits available must exceed a certain threshold to solve problems beyond the capabilities of a classical computer. However, there exist several classical techniques capable of efficiently simulating certain quantum many-body systems. The success of some of these techniques, such as Tensor Networks @verstraete2008matrix @orus2014practical, rely on the efficient representation of states that are not highly entangled~@vidal2003efficient @vidal2004efficient. With the advent of universal quantum computers, one would expect to be able to generate and manipulate these highly entangled quantum states.


Hence, one imminent and practical direction towards demonstrating quantum advantage over classical machines consist of focusing on a region of the Hilbert space whose states can not be represented efficiently with classical methods. Alternatively, one might tackle certain computational tasks which are believed to be intractable with any classical computer, as the ones belonging to only quantum complexity classes.


Two recent experimental ventures exhibit this focus. In 2019, the Google AI Quantum team implemented an experiment with the 53-qubit Sycamore chip @arute2019quantum in which single-qubit gate fidelities of $99.85 "%"$ and two-qubit gate fidelities of $99.64 "%"$ were attained on average. Quantum advantage was demonstrated against the best current classical computers in the task of sampling the output of a pseudo-random quantum circuit.


An additional quantum advantage experiment was carried out by Jian-Wei Pan's group using a #emph[Jiuzhang] photonic quantum device performing Gaussian boson sampling (GBS) with $50$ indistinguishable single-mode squeezed states @zhong2020quantum. Here, quantum advantage was seen in sampling time complexity of a #emph[Torontonian] of a matrix @quesada2018gaussian, which scales exponentially with the photon clicks output. The Torontonian is a matrix function that determines the probability distribution of measurement outcomes, much like the permanent and #emph[Hafnian] in other boson sampling models. Intuitively speaking, while the total number of perfect matchings in a bipartite graph is given by the permanent, the Hafnian corresponds to the total number of perfect matchings in an arbitrarily given graph. Moreover, while the Hafnian is used in experiments counting the number of photons in each mode, the Torontonian corresponds to the case where one detects whether there are photons in each mode (see~@sec:GBS for more details about GBS and the related terms).


There are several quantum computing platforms that researchers are actively developing at present in order to achieve scalable and practical universal quantum computers. By "universal", it is meant that such a quantum computer can perform native gate operations that allow it to easily and accurately approximate any unitary gate (see @sec:compilers for more details). Two of the most promising platforms, superconducting circuits and quantum optics, have already been mentioned; In addition to these, trapped-ion devices are also leading candidates. For instance, major achievements are recent high-fidelity entangling gates reported by the Oxford group~@hughes2020benchmarking, all-to-all connectivity achieved by IonQ~@nam2020ground, and transport and reordering capabilities in 2D trap array by the Boulder group~@wan2020ion. In the last example, besides facilitating efficient transport of ions and quantum information exchange, the 2D architecture can be viewed towards attaining much more sophisticated quantum error correction code or surface code @lidar2013quantum, the smallest of it has been realized in superconducting qubit setup @corcoles2015demonstration.


Scientists and engineers are also developing hybrid quantum computing platforms trying to achieve similar feats described above. These devices might not necessarily possess universal quantum gate sets, as many are built to solve specific problems. Notably, coherent Ising machines @utsunomiya2011mapping @wang2013coherent @marandi2014network @mcmahon2016fully @inagaki2016coherent based on mutually coupled optical parametric oscillators are promising and have shown success in solving instances of hard combinatorial optimization problems. Recently, it has been shown that the efficiency of these machines can be improved with error detection and correction feedback mechanisms @kako2020coherent. The reader is advised to refer to the recent review article @yamamoto2020coherent for an in-depth discussion about coherent Ising machines. Quantum annealing~@finnila1994quantum @kadowaki1998quantum has been another prominent approach towards quantum advantage in the NISQ era~@perdomo2018opportunities @bouland2020prospects @hauke2020perspectives. Refer to @subsec:quantum-annealing for more details about quantum annealing.


Lastly, unlike the past decades of academic research in lab-based quantum technologies, we are witnessing the emergence of cloud quantum computers with which anyone with internet access can now control and manipulate delicate qubits and perform quantum computations on the fly. Presently, IBM Quantum is leading the effort followed by Rigetti Computing and Xanadu Quantum Cloud.


== NISQ and near-term
<ch1:subsec:NISQ_near-term>


The experimental state-of-the-art and the demand for QEC have encouraged the development of innovative algorithms capable of reaching the long-expected #emph[quantum advantage]. This goal can be defined as a purpose-specific computation that involves a quantum device and that can not be performed classically with a reasonable amount of time and energy resources. The term #emph[near-term] quantum computation has been coined to cluster all these quantum algorithms specially developed to be run on current quantum computing hardware or those which could be developed in the next few years,. It is important to note that NISQ is a hardware-focused definition, and does not necessarily imply a temporal connotation. NISQ devices can implement the model of quantum circuits, in which all gates adhere to the topology of a specified graph $G$, the nodes of which correspond to qubits. The gates typically operate on one or two qubits. Because each gate operation involves a certain amount of noise, NISQ algorithms are naturally limited to shallow depths~@barak2021classical. Near-term algorithms, however, refers to those algorithms designed for quantum devices available in the next few years and carries no explicit reference to the absence of QEC. The phrase "near-term" is subjective since different researchers may have other thoughts on how many years can be considered "near-term". Predicting experimental progress is always challenging, and such predictions are influenced by human bias. Algorithms developed for near-term hardware may be unfeasible if hardware advancement does not match the algorithm's experimental requirements.


== Scope of the review
<scope-of-the-review>


This review aims to accomplish three main objectives. The first is to provide a proper compilation of the available algorithms suited for the NISQ era and which can deliver results in the near-term. We present a summary of the crucial tools and techniques that have been proposed and harnessed to design such algorithms. The second objective is to discuss the implications of these algorithms in various applications such as quantum machine learning (QML), quantum chemistry, and combinatorial optimization. Finally, the third objective is to give some perspectives on potential future developments given the recent quantum hardware progress.


Most of the current NISQ algorithms rely on harnessing the power of quantum computers in a hybrid quantum-classical arrangement. Such algorithms delegate the classically difficult part of some computation to the quantum computer and perform the other on some sufficiently powerful classical device. These algorithms update variationally the variables of a parametrized quantum circuit and hence are referred to as #emph[Variational Quantum Algorithms] (VQA) @cao2019quantum @mcardle2020quantum @endo2020hybrid @cerezo2020variational.


The first proposals of VQA were the Variational Quantum Eigensolver (VQE) @peruzzo2014variational @mcclean2016theory @wecker2015progress, originally proposed to solve quantum chemistry problems, and the Quantum Approximate Optimization Algorithm (QAOA) @farhi2014quantum, proposed to solve combinatorial optimization problems. These two algorithms may be thought of as the parents of the whole VQA family. While NISQ devices can arguably achieve quantum advantage for sampling problems, the corresponding question for the optimization problems remains unanswered~@barak2021classical @barak2015beating. It is important to mention that, as of now, there is no provable quantum advantage for VQA with NISQ devices~@barak2021classical. We cover the main VQA blocks in @ch:building.


Other quantum computing paradigms propose different kinds of algorithms. They are inspired and hybridized with analog approaches.These include quantum annealing, digital-analog quantum computation, Gaussian Boson Sampling and analog quantum computation. We present their fundamental properties in @sec:non-variational.


In @ch:lemon, we examine the theoretical and experimental challenges faced by NISQ algorithms and the methods developed to best exploit them. We include the theoretical guarantees that some of these algorithms lay on as well as techniques to mitigate the errors coming from the use of noisy quantum devices. We also cover the possible trainability challenges that VQA have and how to map theoretical NISQ circuits to real hardware. @ch:application presents the large variety of applications that NISQ algorithms introduce. Techniques to benchmark, compare and quantify current quantum devices performance are presented in @sec:benchmark. Like any other computational paradigm, quantum computing requires a language to establish human-machine communication. We explain different levels of quantum programming and provide a list of open-source quantum software tools in @sec:software. Finally, we conclude this review in @ch:outlook by highlighting the increasing community involvement in this field and by presenting the NISQ, near-term and long-term goals of quantum computational research.


= BUILDING BLOCKS OF VARIATIONAL QUANTUM ALGORITHMS
<ch:building>


A VQA comprises several modular components that can be readily combined, extended and improved with developments in quantum hardware and algorithms. Chief among these are the objective function, the cost function to be variationally minimized; the parameterized quantum circuit (PQC), those unitaries whose parameters are manipulated in the minimization of objective; the measurement scheme, which extracts the expectation values needed to evaluate the objective; and the classical optimizer, the method used to obtain the optimal circuit parameters that minimize the objective. In the following subsections, we will define each of these pieces, presented diagrammatically in Fig.~#ref(<Fig:VQA_diag>, supplement: none).



// [figvision] imgs/VQA_loop.png
// Panel a is the input/objective-function schematic at top left. A line labelled θ → θ₀ carries the initial
// parameter vector into a dashed arrow pointing at a salmon rounded rectangle containing O(θ, {⟨H⟩_U(θ)}). There
// are no axes, ranges, or units; the box states that the objective is a parameter-dependent expectation value of
// H under the unitary U(θ). A solid black arrow from θ₀ also descends into the circuit below. Panel b is the
// parametrized quantum circuit, a schematic diagram occupying the centre. Four horizontal wires begin at |0⟩
// states (top, second, bottom, with a vertical ellipsis between the second and third indicating more qubits).
// Control-dot and target-⊕ CNOT symbols entangle neighbouring wires, followed by rotation boxes Rz(θ₁,₁),
// Rz(θ₂,₁), Rz(θ₃,₁) interleaved with Rx gates. A light blue shaded region covers the left gates; a dark blue
// block labelled U(θ) covers the right portion, marking the full parameterized unitary ansatz. Panel c is the
// green Basis change schematic on the right edge of the circuit. Inside the rounded green box, the top wire
// passes through an Rx(π/2) rotation while the middle wire carries an identity gate I; three measurement dials
// (semicircular arc symbols) sit on the output wires at the far right. This rotates each qubit into the desired
// measurement basis before readout, and the outputs wire back to the optimizer. Panel d is the
// classical-optimization block at bottom centre: a yellow rounded rectangle labelled min_θ O(θ, {⟨H⟩_U(θ)}). An
// arrow marked θ → θ_new exits leftward and re-enters the circuit input, closing the quantum-classical loop. In
// the top-right output panel, a red curve of E_grd versus distance drops steeply then plateaus, annotated θ* and
// E_grd ≈ O(θ*), reporting the converged ground-state estimate.
#figure(
  image("imgs/VQA_loop.png", width: 100%),
  caption: [
    Diagrammatic representation of a Variational Quantum Algorithm (VQA). A VQA workflow can be divided into four main components: #emph[a)] the objective function $O$ that encodes the problem to be solved; #emph[b)] the parameterized quantum circuit (PQC) $U$, which variables $bold(theta)$ are tuned to minimize the objective; #emph[c)] the measurement scheme, which performs the basis changes and measurements needed to compute expectation values that are used to evaluate the objective; and #emph[d)] the classical optimizer that minimizes the objective. The PQC can be defined heuristically, following hardware-inspired ansätze, or designed from the knowledge about the problem Hamiltonian $H$. Inputs of a VQA are the circuit ansatz $U ( bold(theta) )$ and the initial parameter values $bold(theta)_0$. Outputs include optimized parameter values $bold(theta)^(*)$ and the minimum of the objective.
  ],
  placement: top,
  scope: "parent",
) <Fig:VQA_diag>


== Objective function
<sec:objective_function>


The Hamiltonian is a quantum operator that encodes information about a given physical system, such as a molecule or a spin chain. Its expectation value yields the energy of a quantum state, which is often used as the minimization target of a VQA, i.e. obtaining the Hamiltonian ground state. Other problems not related to real physical systems can also be encoded into a Hamiltonian form, thereby opening a path to solve them on a quantum computer. Hamiltonian operators are not all that can be measured on quantum devices; in general, any expectation value of a function written in an operational form (i.e. decomposed or encoded into a quantum operator) can be also be evaluated on a quantum computer. After the Hamiltonian or operator of a problem has been determined, it must be decomposed into a set of particular operators that can be measured with a quantum processor. Such a decomposition, which is further discussed in @sec:pauli_strings, is an important step of many quantum algorithms in general and of VQA in particular.


Within a VQA, one has access to measurements on qubits whose outcome probabilities are determined by the prepared quantum state. Let us consider only measurements on individual qubits in the standard computational basis and denote the probability to measure qubit $q$ in state $| 0 chevron.r$ by $p_0^q$, where the qubit label $q$ will be omitted whenever possible. The central element of a VQA is a parametrized cost or #emph[objective function] $O$ subject to a classical optimization algorithm,


$min_(bold(theta)) O (bold(theta) , {bold(p)_0 (bold(theta))})$.


The objective function $O$ and the measurement outcomes $bold(p)_0$ of one or many quantum circuit evaluations depend on the set of parameters $bold(theta)$.


In practice it is often inconvenient to work with the probabilities of the measurement outcomes directly when evaluating the objective function. Higher level formulations employ expectation value of the Hamiltonian $H$ of the form


$ chevron.l H chevron.r_(U (bold(theta))) equiv chevron.l 0 | U^dagger (bold(theta)) H U (bold(theta)) | 0 chevron.r , $<eq:def_expectationvalue>


describing measurements on the quantum state generated by the unitary $U (bold(theta))$, instead of using the probabilities for the individual qubit measurements directly. Arbitrary observables can be decomposed into basic measurements of the so-called Paulis strings, which can be evaluated in the computational basis, as explained below and in @sec:measurement. Restricting ourselves to expectation values instead of pure measurement probabilities, the objective function becomes


$ min_(bold(theta)) O (bold(theta) , {chevron.l H chevron.r_(U (bold(theta)))}) . $


This formulation often allows for more compact definitions of the objective function. For the original VQE~@peruzzo2014variational and QAOA~@farhi2014quantum it can, for example, be described as a single expectation value $min_(bold(theta)) chevron.l H chevron.r_(U (bold(theta)))$,


where the differences solely appear in the specific form and construction of the qubit Hamiltonian.


The choice of the objective function is crucial in a VQA to achieve the desired convergence. Vanishing gradient issues during the optimization, known as barren plateaus, are dependent on the cost function used~@cerezo2020cost (see @sec:BP for details).


=== Pauli strings
<sec:pauli_strings>


To extract the expectation value of the problem Hamiltonian, it is sufficient to express it as a linear combination of primitive tensor products of Pauli matrices $hat(sigma)_x , hat(sigma)_y , hat(sigma)_z$. We refer to these tensor products as #emph[Pauli strings] $hat(P) = ⨂_(j = 1)^n hat(bold(sigma))$, where $n$ is the number of qubits, $hat(bold(sigma)) in ( hat(I) , hat(sigma)_x , hat(sigma)_y , hat(sigma)_z )$ and $hat(I)$ the identity operator. Then, the Hamiltonian can be decomposed as


$ H = sum_(k = 1)^M c_k hat(P)_k , $<eq:Pauli_string>


where $c_k$ is a complex coefficient of the $k$-th Pauli string and the number of Pauli strings $M$ in the expansion depends on the operator at hand. An expectation value in the sense of @eq:def_expectationvalue then naturally decomposes into a set of expectation values, each defined by a single Pauli string


$ chevron.l H chevron.r_U = sum_(k = 1)^M c_k chevron.l hat(P)_k chevron.r_U thin . $<eq:Pauli_string_exp>


Examples of Hamiltonian objectives include molecules (by means of some fermionic transformation to Pauli strings, as detailed in @sec:chemistry), condensed matter models written in terms of spin chains, or optimization problems encoded into a Hamiltonian form (see @sec:optimization).


=== Fidelity
<fidelity>


Instead of optimizing in respect to the expectation value of an operator, several VQAs require a subroutine to optimize the state obtained from the PQC $U (bold(theta))$, $| Psi chevron.r_(U (bold(theta)))$ in respect to a specific target state $| Psi chevron.r$. A commonly used cost function is the fidelity between the PQC and the target state


$ F (Psi , Psi_(U (bold(theta)))) equiv | chevron.l Psi | Psi_(U (bold(theta))) chevron.r |^2 , $<eq:fidelity_target>


which is equivalent to the expectation value over the projector $hat(Pi)_Psi = | Psi chevron.r chevron.l Psi |$. The state preparation objective is then the minimization of the infidelity $1 - F (Psi , Psi_(U (bold(theta))))$ or just the negative fidelity


$ max_(bold(theta)) F (Psi , Psi_(U (bold(theta)))) = min_(bold(theta)) (- chevron.l hat(Pi)_Psi chevron.r_(U (bold(theta)))) . $


If we know the efficient circuit $U_Psi$ that prepares the target state $| Psi chevron.r$, we can compute the fidelity with the inversion test by preparing the quantum state $U_Psi^dagger | Psi_(U (bold(theta))) chevron.r$ and measuring the projector into the zero state $hat(Pi)_0 = | 0 chevron.r^(⊗ n) chevron.l 0 |^(⊗ n)$ with the fidelity given by $F (Psi , Psi_(U (bold(theta)))) = chevron.l hat(Pi)_0 chevron.r_(U_Psi^dagger U (theta))$~@havlivcek2019supervised. If one wants to avoid optimizing in respect to a projector onto a single state, one can instead use a local observable that also becomes maximal for the target state, namely $hat(O) = 1 / N sum_(k = 1)^N | 0_k chevron.r chevron.l 0_k | ⊗ I_(macron(k))$, where $I_(macron(k))$ is the identity matrix for all qubits except $k$ and $| 0_k chevron.r$ is the zero state for qubit $k$ ~@cerezo2020cost @barison2021efficient. Alternatively, one can use randomized measurements to measure the fidelity $upright("Tr") ( rho_1 rho_2 )$ of two density matrices $rho_1$, $rho_2$~@van2012measuring @elben2019statistical @elben2020cross. First, one selects $m$ unitaries ${ V_k }_k$, which are chosen as tensor product of Haar random unitaries over the local $d$-dimensional subspace. These unitaries are applied on each quantum state $rho_i = V_k rho V_k^dagger$ and $rho_i$ is sampled in the computational basis. Then, one estimates the probability $P_(V_k)^(( i )) ( upright(bold(s)) )$ of measuring the computational basis state $upright(bold(s))$ for each quantum state $rho_i$ and unitary $V_k$. The fidelity is given by


$ upright("Tr") \[ rho_1 rho_2 \] = d^N / m sum_(k = 1)^m sum_(upright(bold(s)) , upright(bold(s))') ( - d )^(- cal(D) \[ upright(bold(s)) , upright(bold(s))' \]) #h(0em) P_(V_k)^(( 1 )) ( upright(bold(s)) ) P_(V_k)^(( 2 )) ( upright(bold(s))' ) . $<eq:rand_measl>


where $cal(D) \[ upright(bold(s)) , upright(bold(s))' \]$ is the Hamming distance between sampled computational basis states $upright(bold(s))$ and $upright(bold(s))'$. The number of measurements scales exponentially with the number of qubits, however the scaling is far better compared to state tomography. Importance sampling has been proposed to substantially reduce the number of samples necessary~@rath2021importance.


Objective formulations over fidelities are prominent within state preparation algorithms in quantum optics~@krenn2020computer @krenn2020conceptual @kottmann2020quantum, excited state algorithms~@lee2018generalized @kottmann2020feasible and QML~@cheng2018information @benedetti2019generative @perez2020data @huang2021power (see also @sec:QML for more references and details). In these cases, the fidelities are often defined in respect to computational basis states $e_i$, such that $F_(e_i) = | chevron.l Psi (bold(theta)) | e_i chevron.r |^2$.


=== Other objective functions
<other-objective-functions>


Hamiltonian expectation values are not the only objective functions that are used in VQAs. Any cost function that is written in an operational form can constitute a good choice. One such example is the conditional value-at-risk (CVaR). Given the set of energy basis measurements $( E_1 , dots.h E_M )$ arranged in a non-decreasing order, instead of using the expectation value from @eq:def_expectationvalue as the objective function, it was proposed to use @barkoutsos2020improving


$ upright("CVaR") ( alpha ) = frac(1, ceil.l alpha M ceil.r) sum_(k = 1)^(ceil.l alpha M ceil.r) E_k thin , $


which measures the expectation value of the $alpha$-tail of the energy distribution. Here, $alpha in ( 0 , 1 \]$ is the confidence level. The CVaR$( alpha )$ can be thought of as a generalization of the sample mean ($alpha = 1$) and the sample minimum ($alpha arrow.r 0$).


Another proposal @li2020quantum is to use the Gibbs objective function


$ G = - ln chevron.l e^(- eta H) chevron.r , $


which is the cumulant generating function of the energy. The variable $eta > 0$ is a hyperparameter to be tuned. For small $eta$, the Gibbs objective function reduces to the mean energy in @eq:def_expectationvalue. Since both the CVaR and the Gibbs objective function can be reduced to the mean energy for suitable limits of the hyperparameters ($alpha arrow.r 1$ and $eta arrow.r 0$ respectively), their performances are guaranteed to be at least as good as using the mean energy $chevron.l H chevron.r$. Empirically, by tuning the hyperparameters, both measures have been shown to outperform $chevron.l H chevron.r$ for certain combinatorial optimization problems @barkoutsos2020improving @li2020quantum.


== Parameterized quantum circuits
<sec:PQC>


Following the objective function, the next essential constituent of a VQA is the quantum circuit that prepares the state that best meets the objective. It is generated by means of a unitary operation that depends on a series of parameters, the PQC. In this subsection, we describe how this quantum circuit is defined and designed.


We define the state after application of the PQC as


$ | Psi (bold(theta)) chevron.r = U (bold(theta)) | Psi_0 chevron.r , $<eq:var_qcircuit>


where $bold(theta)$ are the variational parameters and $| Psi_0 chevron.r$ is some initial state. Typically, $| Psi_0 chevron.r$ is a product state with all qubits in the $| 0 chevron.r$ state, i.e. $| 00 dots.h.c 0 chevron.r = | 0 chevron.r^(⊗ n)$, where $n$ is the number of qubits. In some VQAs, it is convenient to prepare that state in a particular form before applying the PQC. The state preparation operation would then depend on some other unitary operation $P$ that may depend on variational parameters $bold(phi.alt)$,


$| Psi_0 chevron.r = P (bold(phi.alt)) | 0 chevron.r^(⊗ n)$.


One example are the quantum feature maps defined in @sec:SL that encode the data into the PQC.


Any known property about the final state can also be used to obtain the initial guess. For instance, if we expect that the final state solution will contain all elements of the computational basis, or if we want to exploit a superposition state to seed the optimization, an initial state choice may be


$P | 0 chevron.r^(⊗ n) = H_d^(⊗ n) | 0 chevron.r^(⊗ n)$,


where $H_d$ is the Hadamard gate. Applied to all qubits, $H_d$ generates the even superposition of all basis states, i. e.


$ | D chevron.r = H_d^(⊗ n) | 0 chevron.r^(⊗ n) = 1 / sqrt(n) sum_(i = 1)^n | e_i chevron.r , $<eq:sp_H>


where $| e_i chevron.r$ are the computational basis states.


In quantum chemistry algorithms, the initial state usually corresponds to the Hartree-Fock approximation (see @sec:chemistry for details). The choice of a good initial state will allow the VQA to start the search in a region of the parameter space that is closer to the optimum, helping the algorithm converge towards the solution.


The choice of the ansatz $U$ greatly affects the performance of a VQA. From the perspective of the problem, the ansatz influences both the convergence speed and the closeness of the final state to a state that optimally solves the problem. On the other hand, the quantum hardware on which the VQA is executed has to be taken into account: Deeper circuits are more susceptible to errors, and some ansatz gates are costly to construct from native gates. Accordingly, most of the ansätze developed to date are classified either as more #emph[problem-inspired] or more #emph[hardware efficient], depending on their structure and application.


=== Problem-inspired ansätze
<sec:HamiltonAnsatz>


An arbitrary unitary operation can be generated by an Hermitian operator $hat(g)$ which, physically speaking, defines an evolution in terms of the $t$ parameter,


$ G ( t ) = e^(- i hat(g) t) . $<eq:lie_product_formula>


As an example, the generator $hat(g)$ can be a Pauli matrix $hat(sigma)_i$ and thus, $G ( t )$ becomes a single-qubit rotation of the form


$ R_k (theta) = e^(- i theta / 2 hat(sigma)_k) = cos ( theta / 2 ) I - i sin ( theta / 2 ) hat(sigma)_k , $<eq:def_single_qubit_rotation>


with $t = theta$ and $hat(g) = 1 / 2 hat(sigma)_k$, corresponding to the spin operator.


From a more abstract viewpoint, those evaluations can always be described as time evolution of the corresponding quantum state, so that the generator $hat(g)$ is often just referred to as a Hamiltonian. Note, however, that this Hamiltonian does not necessarily need to be the operator that describes the energy of the system of interest. In general, such generators can be decomposed into Pauli strings in the form of @eq:Pauli_string.


Within so-called #emph[problem-inspired] approaches, evolutions in the form of ~@eq:lie_product_formula, with generators derived from properties of the system of interest are used to construct the parametrized quantum circuits. The unitary coupled-cluster approach (see below), mostly applied for quantum chemistry problems, is one prominent example. The generators then are elementary fermionic excitations, as shown in @eq:ucc_excitations.


The #emph[Suzuki-Trotter] (ST) expansion or decomposition @suzuki1976generalized is a general method to approximate a general, hard to implement unitary in the form of ~@eq:lie_product_formula as a function of the $t$ parameter. This can be done by decomposing $hat(g)$ into a sum of non-commuting operators ${ hat(o)_k }_k$, with $hat(g) = sum_k c_k hat(o)_k$ and some coefficients $c_k$. The operators $hat(o)_k$ are chosen such that the evolution unitary $e^(- i hat(o)_k t)$ can be easily implemented, for example as Pauli strings $hat(P)_k$. The full evolution over $t$ can now be decomposed into integer $m$ equal-sized steps as


$ e^(- i hat(g) t) = lim_(m arrow.r oo) (product_k e^(- i frac(c_k hat(o)_k t, m)))^m . $<eq:trotter>


For practical purposes, the time evolution can be approximated by a finite number $m$. When Pauli strings are used, this provides a systematic method to decompose an arbitrary unitary, generated by $hat(g)$, into a product of multi-qubit rotations $e^(- i frac(c_k hat(P)_k t, m))$, that can themselves be decomposed into primitive one and two qubit gates. Above, we have used the second order ST decomposition to approximate the true unitary at each time step $t$. The error incurred from the approximation can be bounded by $| | U_(hat(g)) ( Delta_t ) - U_(hat(g))^(upright("ST")) ( Delta_t ) | | lt.eq sum_(k = 1)^m | | \[ \[ H_k , H_(> k) \] , H_k \] \] + \[ \[ H_(> k) , H_k \] , H_(> k) \] \] | | Delta_t^3$, where $H_(> k) = sum_(beta > k) H_beta$ and $H_k = c_k hat(o)_k$~@poulin2014trotter.


Knowledge about the physics of the particular Hamiltonian to be #emph[trotterized] can reduce substantially the number of gates needed to implement this method. For instance, in @kivlichan2018quantum, it is shown that by using fermionic swap gates, it is possible to implement a Trotter step for electronic structure Hamiltonians using first-neighbour connectivity circuits with $N^2 / 2$ two-qubit gates width and $N$ depth, where $N$ is the number of spin orbitals. They also show that implementing arbitrary Slater determinants can be done efficiently with $N / 2$ gates of circuit depth.


==== Unitary Coupled Cluster.
<sec:unitary_coupled_cluster>
Historically, problem-inspired ansätze were proposed and implemented first. They arose from the quantum chemistry-specific observation that the unitary coupled cluster (UCC) ansatz @taube2006new, which adds quantum correlations to the Hartree-Fock approximation, is inefficient to represent on a classical computer @yung2014transistor. Leveraging quantum resources, the UCC ansatz was instead realized as a PQC on a photonic processor @peruzzo2014variational. It is constructed from the parametrized cluster operator $T ( bold(theta) )$ and acts on the Hartree-Fock ground state $| Psi_(upright("HF")) chevron.r$ as


$ | Psi ( bold(theta) ) chevron.r = e^(T ( bold(theta) ) - T ( bold(theta) )^dagger) | Psi_(upright("HF")) chevron.r . $<eq:ucc_canonical_form>


The cluster operator is given by $T ( bold(theta) ) = T_1 ( bold(theta) ) + T_2 ( bold(theta) ) + dots.h.c$ with


$ T_1 ( bold(theta) ) & = & sum_(i in upright("occ")\
j in upright("virt")) theta_i^j hat(a)_j^dagger hat(a)_i\
T_2 ( bold(theta) ) & = & sum_(i_1 , i_2 in upright("occ")\
j_1 , j_2 in upright("virt")) theta_(i_1 , i_2)^(j_1 , j_2) hat(a)_(j_2)^dagger hat(a)_(i_2) hat(a)_(j_1)^dagger hat(a)_(i_1) , $<eq:ucc_excitations>


and higher-order terms following accordingly @omalley2016scalable. The operator $hat(a)_k$ is the annihilation operator of the $k$-th Hartree-Fock orbital, and the sets #emph[occ] and #emph[virt] refer to the occupied and unoccupied Hartree-Fock orbitals.


Due to their decreasing importance, the series is usually truncated after the second or third term. The ansatz is termed #emph[UCCSD] or #emph[UCCSDT], respectively, referring to the inclusion of single, double, and triple excitations from the Hartree-Fock ground state. The $k$-UpCCGSD approach restricts the double excitations to pairwise excitations but allows $k$ layers of the approach~@lee2018generalized. After mapping to Pauli strings as described in @sec:pauli_strings, the ansatz is converted to a PQC usually via the Trotter expansion in~@eq:trotter.


In its original form, the UCC ansatz faces several drawbacks in its application to larger chemistry problems as well as to other applications. For strongly correlated systems, the widely proposed UCCSD ansatz is expected to have insufficient overlap with the true ground state and results typically in large circuit depths~@lee2018generalized @grimsley2019adaptive. Consequently, improvements and alternative ansätze are proposed to mitigate these challenges.


We restrict our discussion here to provide a short overview of alternative ansatz developments. For more details about the UCC ansatz, see @sec:chemistry.


==== Factorized Unitary Coupled-Cluster and Adaptive Approaches.
<factorized-unitary-coupled-cluster-and-adaptive-approaches.>
The non commuting nature of the fermionic excitation generators, given by the cluster operators~@eq:ucc_excitations leads to difficulties in decomposing the canonical UCC ansatz~@eq:ucc_canonical_form into primitive one- and two-qubit untiaries. First approaches employed the Trotter decomposition ~@eq:trotter using a single step~@romero2018strategies @mcclean2016theory. The accuracy of the so obtained factorized ansatz depends however on the order of the primitive fermionic excitations~@grimsley2019trotterized @Izmaylov2020order.


Alternative approaches propose to use factorized unitaries, constructed from primitive fermionic excitations, directly~@evangelista2019exact @Izmaylov2020order. Adaptive approaches, are a special case of a factorized ansatz, where the unitary is iteratively grown by subsequently screening and adding primitive unitary operators from a predefined operator pool. The types of operator pools can be divided into two classes: Adapt-VQE~@grimsley2019adaptive, that constructs the operator pool from primitive fermionic excitations, and Qubit-Coupled-Cluster~@ryabinkin2018qubit that uses Pauli Strings. In both original works, the screening process is based on energy gradients with respect to the prospective operator candidate. Since this operator is the trailing part of the circuit, the gradient can be evaluated through the commutator of the Hamiltonian with the generator of that operator. In contrast to commutator based gradient evaluation, direct differentiation, as proposed in~@kottmann2020reducing allows gradient evaluations with similar cost as the original objective and generalizes the approach by allowing screening and insertion of operators at arbitrary positions in the circuit. This is, for example, necessary for excited state objectives as discussed in~@sec:var_excited.


Extended approaches include iterative methods~@ryabinkin2020iterative, operator pool construction from involutory linear combination of Pauli strings~@lang2020iterative, Pauli string pools from decomposed fermionic pools~@tang2019qubit, mutual information based operator pool reduction~@zhang2020mutual, measurement reduction schemes based on the density matrix reconstruction~@liu2020efficient, and external perturbative corrections~@ryabinkin2021aposteriori.


==== Variational Hamiltonian Ansatz.
<variational-hamiltonian-ansatz.>
Motivated by adiabatic state preparation, the Variational Hamiltonian Ansatz (VHA) was developed to reduce the number of parameters and accelerate the convergence @wecker2015progress @mcclean2016theory. Instead of the Hartree-Fock operators, the terms of the fermionic Hamiltonian itself are used to construct the PQC. For this purpose, the fermionic Hamiltonian $H$ is written as a sum of $M$ terms $H = sum_i hat(h)_i$. Which parts of the Hamiltonian are grouped into each term $hat(h)_i$ depends on the problem and there is a degree of freedom in the design of the algorithm. The PQC is then chosen as


$ U_(upright("VHA")) = product_(i = 1)^M e^((i theta_i hat(h)_i)) , $


with the operators in the product ordered by decreasing $i$. The unitary corresponds to $n$ short time evolutions under different parts of the Hamiltonian, where the terms $hat(h)_i$ of the Hamiltonian can be repeated multiple times. The initial state is chosen so that it is easy to prepare yet it is related to the Hamiltonian, for example the eigenstate of the diagonal part of $H$. The Fermi-Hubbard model with its few and simple interaction terms is proposed as the most promising near-term application of the method. However, it is also shown that the VHA can outperform specific forms of the UCCSD ansatz for strongly correlated model systems in quantum chemistry. In @sec:chemistry we discuss some VQE-inspired algorithms that also use adiabatic evolution to improve the performance of the algorithm.


==== Quantum Approximate Optimization Algorithm.
<quantum-approximate-optimization-algorithm.>
One of the canonical NISQ era algorithms, designed to provide approximate solutions to combinatorial optimization problems, is the Quantum Approximate Optimization Algorithm (QAOA) @farhi2014quantum. While QAOA can be thought of as a special case of VQA, it has been studied in depth over the years both empirically and theoretically, and it deserves special attention.


The cost function $C$ of a QAOA is designed to encode a combinatorial problem by means of bit strings that form the computational basis. With the computational basis vectors $| e_i chevron.r$, one can define the problem Hamiltonian $H_P$ as (see @sec:MaxCut for an example)


$ H_P equiv sum_(i = 1)^n C ( e_i ) | e_i chevron.r chevron.l e_i | , $<eq:HP_QAOA>


and the mixing Hamiltonian $H_M$ as


$ H_M equiv sum_(i = 1)^n hat(sigma)_x^i . $<eq:mxing_operator>


The initial state in the QAOA algorithm is conventionally chosen to be the uniform superposition state $| D chevron.r$ from @eq:sp_H. The final quantum state is given by alternately applying $H_P$ and $H_M$ on the initial state $p$-times,


$ | Psi ( bold(gamma) , bold(beta) ) chevron.r equiv e^(- i beta_p H_M) e^(- i gamma_p H_P) dots.h.c e^(- i beta_1 H_M) e^(- i gamma_1 H_P) | D chevron.r , $<eq:QAOA_evolved_state>


with $bold(gamma) equiv (gamma_1 , gamma_2 , dots.h.c , gamma_p)$ and $bold(beta) equiv (beta_1 , beta_2 , dots.h.c , beta_p)$. A quantum computer is used to evaluate the objective function


$ C ( bold(gamma) , bold(beta) ) equiv chevron.l Psi ( bold(gamma) , bold(beta) ) | H_P ( bold(gamma) , bold(beta) ) | Psi ( bold(gamma) , bold(beta) ) chevron.r , $<eq:QAOA_objective>


and a classical optimizer is used to update the $2 p$ angles $bold(gamma)$ and $bold(beta)$ until $C$ is maximized, i.e. $C ( bold(gamma^(*)) , bold(beta^(*)) ) equiv max_(bold(gamma) , bold(beta)) C ( bold(gamma) , bold(beta) )$. Here, $p$ is often referred to as the QAOA level or depth. Since the maximization at level $p - 1$ is a constrained version of the maximization at level $p$, the performance of the algorithm improves monotonically with $p$ in the absence of experimental noise and infidelities.


In adiabatic quantum computing (see @subsec:quantum-annealing), we start from the ground state of $H_M$ and slowly move towards the ground state of $H_P$ by slowly changing the Hamiltonian. In QAOA, instead, we alternate between $H_M$ and $H_P .$ One can think of QAOA as a Trotterized version of quantum annealing. Indeed, the adiabatic evolution as used in quantum annealing can be recovered in the limit of $p arrow.r oo$.


For a combinatorial optimization problem with hard constraints to be satisfied, penalties in the cost function can be added. This might not be an efficient strategy in practice as it is still possible to obtain solutions which violate some of the hard constraints. A variation of the QAOA to deal with these constraints was also discussed in the Sec. VII from the original proposal @farhi2014quantum. Building on previous work in quantum annealing~@hen2016quantum @hen2016driver, it was proposed to encode the hard constraints directly in the mixing Hamiltonian~@hadfield2017quantum. This approach yields the main advantage of restricting the state evolution to the feasible subspace where no hard constraints are violated, which consequently speeds up the classical optimization routine to find the optimal angles. This framework was later generalized as the #emph[Quantum Alternating Operator Ansatz] to consider phase-separation and mixing unitary operators ($U_P ( gamma )$ and $U_M ( beta )$ respectively) which need not originate from the time-evolution of a Hamiltonian @hadfield2019from. The operators $e^(- i beta H_M)$ and $e^(- i gamma H_P)$ from @eq:QAOA_evolved_state are replaced by $U_M ( beta )$ and $U_P ( gamma )$ respectively. It is worth noting that both the Quantum Approximate Optimization Algorithm and the Quantum Alternating Operator Ansatz are abbreviated "QAOA" in the literature. In this case, we suggest "QuAltOA" as an acronym for the Quantum Alternating Operator Ansatz to distinguish the same from the Quantum Approximate Optimization Algorithm.


The use of QAOA for combinatorial optimization is presented in @sec:optimization. Some theoretical guarantees of this ansatz are introduced in @sec:theoretical_garantees.


// [figvision] imgs/problem_inspired_vs_hardware_efficient.png
// Panel a shows a quantum circuit schematic labeled Problem-inspired ansatz implementing the Unitary Coupled
// Cluster ansatz U_UCC(theta) = exp(T(theta) - T(theta)^dagger). Four horizontal qubit lines originate from the
// Hartree-Fock state |Psi_HF>, grouped by a left curly brace. A blue rectangle on the left denotes a single
// excitation exp(theta_1 a^_1 a_1), followed by ellipsis. A central light-blue box details a fermionic
// excitation exp(theta_i^j a^_j a_i): vertical dotted control lines connect CNOT symbols drawn as circle-plus
// across the lines, with a central R_y(theta_i^j) rotation gate linked by CNOT ladders to the bottom line, and
// ellipsis to the right. A green rectangle on the right represents a general multi-excitation exp(theta a^...
// a...). Panel b shows a hardware-efficient ansatz built from alternating layers on horizontal qubit lines
// initialized to |0>. A light-blue block U_1(theta) contains repeated pairs of single-qubit rotations
// R_x(theta_{1,1}) and R_z(theta_{1,2}) on each line, indexed by row up to n. This is followed by a green
// rectangle W_1 containing nearest-neighbor CNOT gates drawn as circle-plus symbols connected by vertical dotted
// lines. Ellipsis separates intermediate layers. A final light-blue block U_L(theta) holds rotations
// R_x(theta_{L,1}) through R_z(theta_{L,2}), and a green W_L block on the right completes the ladder-like CNOT
// connectivity, illustrating single-qubit rotations and nearest-neighbor two-qubit gates.
#figure(scope: "parent", image("imgs/problem_inspired_vs_hardware_efficient.png", width: 100%),
  caption: [
    Example problem-inspired and hardware-efficient ansätze. (a) Circuit of the Unitary Coupled Cluster ansatz with a detailed view of a fermionic excitation as discussed in @yordanov2020efficient. (b) Hardware-efficient ansatz tailored to a processor that is optimized for single-qubit $x$- and $z$-rotations and nearest-neighbor two-qubit CNOT gates.
  ]
)
<Fig:ansatz_type_comparison>



=== Hardware-efficient ansätze
<sec:HardwareAnsatz>


Thus far, we have described circuit ansätze constructed from the underlying physics of the problem to be solved. Although it has been shown computationally that such ansätze can ensure fast convergence to a satisfying solution state, they can be challenging to realize experimentally. Quantum computing devices possess a series of experimental limitations that include, among others, a particular qubit connectivity, a restricted gate set, and limited gate fidelities and coherence times. Therefore, existing quantum hardware is not suited to implement the deep and highly connected circuits required for the UCC and similar ansätze for applications beyond basic demonstrations such as the $upright("H")_2$ molecule @moll2018quantum.


A class of #emph[hardware-efficient ansätze] has been proposed to accommodate device constraints @kandala2017hardware. The common trait of these circuits is the use of a limited set of quantum gates as well as a particular qubit connection topology. The gate set usually consists of a two-qubit entangling gate and up to three single-qubit gates. The circuit is then constructed from blocks of single-qubit gates and entangling gates, which are applied to multiple or all qubits in parallel. Each of these blocks is usually called #emph[layer], and the ansatz circuit generally has multiple such layers.


The quantum circuit of a hardware-efficient ansatz with $L$ layers is usually given by


$ U ( bold(theta) ) = product_(k = 1)^L U_k (bold(theta)_k) W_k , $<eq:HE_ansatz>


where $bold(theta) = (bold(theta)_1 , , dots.h.c , bold(theta)_L)$ are the variational parameters, $U_k (bold(theta)_k) = exp (- i bold(theta)_k V_k)$ is a unitary derived from a Hermitian operator $V_k$, and $W_k$ represents non-parametrized quantum gates. Typically, the $V_k$ operators are single-qubit rotation gates, i.e. $V_k$ are Pauli strings acting locally on each qubit. In those cases, $U_k$ becomes a product of combinations of single-qubit rotational gates, each one defined as in @eq:def_single_qubit_rotation. $W_k$ is an entangling unitary constructed from gates that are native to the architecture at hand, for example CNOT or CZ gates for superconducting qubits or XX gates for trapped ions~@krantz2019quantum @wright2019benchmarking. Following this approach, the so-called #emph[Alternating Layered Ansatz] is a particular case of these Hardware-efficient ansätze which consists of layers of single qubit rotations, and blocks of entangling gates that entangle only a local set of qubits and are shifted every alternating layer.


The choice of these gates, their connectivity, and their ordering influences the portion of the Hilbert space that the ansatz covers and how fast it converges for a specific problem. Some of the most relevant properties of hardware-efficient ansätze, namely expressibility, entangling capability and number of parameters and layers needed are studied in Refs. @sim2019expressibility @woitzik2020entanglement @nakaji2020expressibility @bravoPrieto2020scalingof and further discussed in @sec:expressibility.


Instead of making a choice between the problem-inspired and hardware-efficient modalities, some PQC designers have chosen an intermediate path. One example is the use of an exchange-type gate, which can be implemented natively in transmons, to construct a PQC that respects the symmetry of the variational problem @ganzhorn2019gate @sagastizabal2019error. Such an ansatz leads to particularly small parameter counts for quantum chemistry problems such as the H$""_2$ and LiH molecules~@gard2020efficient. Another intermediate approach, termed QOCA for its inspiration from quantum optimal control, is to add symmetry-breaking unitaries, akin to a hardware-efficient ansatz, into the conventional VHA circuit @choquette2020quantum. This modification enables excursions of the variational state into previously restricted sections of the Hilbert space, which is shown to yield shortcuts in solving fermionic problems.


== Measurement
<sec:measurement>


To gain information about the quantum state that has been prepared on the quantum hardware, one needs to estimate the expectation value of the objective function $chevron.l hat(O) chevron.r_(U_(bold(theta)))$.


The most direct approach to estimate expectation values is to apply a unitary transformation on the quantum state to the diagonal basis of the observable $hat(O)$ and obtaining the probability of measuring specific computational states corresponding to an eigenvalue of $hat(O)$. In other words, to determine whether a measured qubit is in the $| 0 chevron.r$ or $| 1 chevron.r$ state. For experimental details on this task we refer to existing reviews, such as for superconducting qubits~@krantz2019quantum or ion traps~@haffner2008quantum. However, on NISQ devices, the tranformation to the diagonal basis mentioned before can be an overly costly one. As a NISQ friendly alternative, most observables of interest can be efficiently parameterized in terms of Pauli strings, as shown above, and transformed into their diagonal basis by simple single-qubit rotations, as shown below.


==== Measurement of Pauli strings.
<measurement-of-pauli-strings.>
The expectation value of the $hat(sigma)_z$ operator on a particular qubit can be measured by reading out the probabilities of the computational basis state $(| 0 chevron.r , | 1 chevron.r)$ as


$ chevron.l psi | hat(sigma)_z | psi chevron.r equiv chevron.l hat(sigma)_z chevron.r = | alpha |^2 - | beta |^2 , $


where $| alpha |^2$ is the probability to measure the qubit in state $| 0 chevron.r$, $| beta |^2$ is the probability to measure the qubit in state $| 1 chevron.r$ and $| psi chevron.r = alpha | 0 chevron.r + beta | 1 chevron.r$. Measurements defined by $hat(sigma)_x$ and $hat(sigma)_y$ can be defined similarly by transforming them into the $hat(sigma)_z$ basis first. The transformation is given by primitive single-qubit gates


$ hat(sigma)_x = R_y^dagger (pi / 2) hat(sigma)_z R_y (pi / 2) = H_(upright("d")) hat(sigma)_z H_(upright("d")) , $<eq:measureX>

$ hat(sigma)_y = R_x^dagger (pi / 2) hat(sigma)_z R_x (pi / 2) = S H_(upright("d")) hat(sigma)_z H_(upright("d")) S^dagger , $<eq:measureY>


where $S = sqrt(hat(sigma)_z)$ and $H_(upright("d")) = ( hat(sigma)_x + hat(sigma)_z ) / sqrt(2)$ is the Hadamard gate. Then, to measure $hat(sigma)_x$ on a quantum state $| psi chevron.r$, we rotate $hat(sigma)_x$ into the $z$-axis by applying $H_d$ and measure in logical $hat(sigma)_z$ basis, i.e.


$ chevron.l hat(sigma)_x chevron.r equiv chevron.l psi | hat(sigma)_x | psi chevron.r = chevron.l psi | H_(upright("d")) hat(sigma)_z H_(upright("d")) | psi chevron.r = alpha beta^(*) + alpha^(*) beta . $


The same applies for $chevron.l hat(sigma)_y chevron.r$. Arbitrary Pauli strings $hat(P)$, with primitive Pauli operations $hat(sigma)_(f ( k )) in (sigma_x , sigma_y , sigma_z)$ on qubits $k in K$, can then be measured by the same procedure on each individual qubit as


$ chevron.l hat(P) chevron.r_U & = chevron.l product_(k in K) sigma_z ( k ) chevron.r_(tilde(U) U) $


where $tilde(U)$ is a product of single qubit rotations according to~@eq:measureX and~@eq:measureY depending on the Pauli operations $hat(sigma)_(f ( k ))$ at qubit $k$.


So far we discussed expectation values of a physical observable $chevron.l hat(cal(O)) chevron.r$, which is the mean value averaged over an infinite number of measurements. In practice, one can sample only a finite number of single-shot measurements $N_(upright("s"))$ of the quantum state and thus can estimate the expectation values within some finite error. For a Pauli string $hat(P)$, the number of measurement samples $N_(upright("s"))$ needed to estimate the expectation value $chevron.l hat(P) chevron.r_U$ with an additive error of at most $epsilon.alt$ with a failure probability of at most $delta$ is bounded by Hoeffding's inequality~@huang2019nearterm


$ N_(upright("s")) gt.eq 2 / epsilon.alt^2 log (2 / delta) thin . $


In particular, the error $epsilon.alt$ decreases with the inverse square-root of the number of measurements $epsilon.alt prop 1 / sqrt(N_(upright("s")))$.


For many problems, such as quantum chemistry-related tasks, the number of terms in the cost Hamiltonian to be estimated can become very large. A naive way of measuring each Pauli string separately may incur a prohibitively large number of measurements. Recently, several more efficient approaches have been proposed~(see @bonet2020nearly for an overview). The common idea is to group different Pauli strings that can be measured simultaneously such that a minimal number of measurements needs to be performed.


Pauli strings that commute qubit-wise, i.e. the Pauli operators on each qubit commute, can be measured at the same time~@kandala2017hardware @mcclean2016theory. The problem of finding the minimal number of groups can be mapped to the minimum clique cover problem, which is NP-hard in general, but good heuristics exist~@verteletskyi2020measurement. One can collect mutually commuting operators and transform them into a shared eigenbasis, which adds an additional unitary transformation to the measurement scheme~@crawford2019efficient @gokhale2019minimizing @yen2020measuring. Combinations of single qubit and Bell measurements have been proposed as well~@hamamura2020efficient.


Alternatively, one can use a method called unitary partitioning to linearly combine different operators into a unitary, and use the so-called Hadamard test (see below) to evaluate it~@izmaylov2019unitary @zhao2020measurement. In @izmaylov2019revising, the observables can be decomposed into the so-called mean-field Hamiltonians, which can be measured more efficiently if one measures one qubit after the other, and uses information from previous measurement outcomes.


For specific problems such as chemistry and condensed matter systems, it is possible to use the structure of the problem to reduce the number of measurements @gokhale2019n @huggins2019efficient @cade2020strategies @cai2020resource. In particular, in ~@cai2020resource, where a Fermi-Hubbard model is studied using VQE, the number of measurements is reduced by considering multiple orderings of the qubit operators when applying the Jordan-Wigner transformation. In the context of quantum chemistry, the up-to-date largest reduction could be achieved by the Cartan subalgebra approach of ~@yen2020cartan. Other approaches use classical shadows~@hadfield2020measurements, a classical approximation of the quantum state of interest, or neural network estimators~@torlai2020precise to decrease the number of measurements. All those kind of optimizations require an understanding of the underlying problem and are usually not applicable for every use of the VQE.


==== Measurement of overlaps.
<measurement-of-overlaps.>
Several VQA require the measurement of an overlap of a quantum state $| psi chevron.r$ with unitary $U$ in the form of $chevron.l psi | U | psi chevron.r$. This overlap is in general not an observable and has both real and imaginary parts. The Hadamard test can evaluate such a quantity on the quantum computer using a single extra qubit~@miquel2002interpretation. The idea is to apply a controlled $U$ operation, with control on that qubit, and target $U$ on the quantum state. Then, one can measure from the this single qubit state both real and imaginary part of the overlap. A downside of this method is the requirement to be able to implement a controlled unitary, which may require too many resources on current quantum processors. Alternative methods to measure the overlap without the use of control unitaries have been proposed~@mitarai2019methodology. One idea is to decompose $U$ into a sum of Pauli strings, and then to measure the expectation value of each Pauli string individually. Another approach is possible if $U$ can be rewritten into a product of unitaries $U_q$ that act locally on only a few qubits. Then, one can find via classical means the diagonalization of $U_q = V_q^dagger D V_q$, with diagonal matrix $D$ and $V_q$ being a unitary. The overlap can be found by applying the $V_q$ unitaries on the state $| psi chevron.r$, measure the outcomes in the computational basis and do post-processing of the results with the classically calculated eigenvalues of $D$.


==== Classical shadows.
<classical-shadows.>
This is a powerful technique to accurately predict $M$ expectation values $upright("Tr") ( hat(O)_i rho )$, $1 lt.eq i lt.eq M$ of an unknown quantum state $rho$~@huang2020predicting. The method is based on and inspired from shadow tomography @aaronson2019shadow. First, a random unitary $U$ is applied on the state $rho arrow.r U rho U^dagger$ and then all the qubits are measured in the computational basis. This step is repeated with several random unitaries $U$. Common choices for $U$ are unitaries which can be efficiently computed on a classical computer such as random $n$-qubit Clifford circuits or tensor products of single qubit rotations. By post-processing the measurement results, one can gather a classical shadow, which is a classical representation of the quantum state $rho$.


There exists performance guarantees that classical shadows with size of order $log M$ suffice to predict $M$ expectation values simultaneously. For investigations involving classical shadow tomography protocols in the presence of noise, refer to @koh2020classical @chen2020robust. Experimental realizations have been performed recently as well~@struchalin2021experimental @zhang2021experimental.


== Parameter optimization
<sec:parameter_optimization>


In principle, the PQC parameter optimization to minimize the objective is not different from any multivariate optimization procedure and standard classical methods can be applied @lavrijsen2020classical. However, in the NISQ era, the coherence time is short, which means that high-depth analytical gradient circuits cannot be implemented. In addition, one of the biggest challenges in parameter optimization is the large number of measurements required for estimating the mean value of an observable to a high precision. Due to this high sampling rate, the measurement process can become a significant bottleneck in the overall algorithm runtime. Thus, an effective optimizer for PQCs should try to minimize the number of measurements or function evaluations. As a last criterion, the optimizer should be resilient to noisy data coming from current devices and precision on expectation values that is limited by the number of shots in the measurement. These three requirements imply that certain existing algorithms are better suited for PQC optimization and are more commonly used, and that new algorithms are being developed specifically for PQC optimization. Some intuitive concepts of the mechanisms behind optimisation of quantum problems have been investigated in~@mcclean2020low. Recently,~@bittel2021training have shown that the classical optimization corresponding to VQAs is a NP-hard problem.


In this section, we first review two classes of optimization, gradient-based and gradient-free. We also consider resource-aware optimization methods and strategies that additionally minimize quantities associated with the quantum cost of optimization. While we reserve more detailed descriptions to the respective references and the Supplementary Material, we highlight the main features and advantages for each optimization strategy.


=== Gradient-based approaches
<gradient-based-approaches>


A common approach to optimise an objective function $f ( bold(theta) )$ is via its gradient, i.e. the change of the function with respect to a variation of its $M$ parameters $bold(theta) = ( theta_1 , dots.h.c , theta_M )$. The gradient indicates the direction in which the objective function shows the greatest change. This is a local optimization strategy as one uses information starting from some initial parameter value $bold(theta)^(( 0 ))$ and iteratively updates $bold(theta)^(( t ))$ over multiple discrete steps $t$. A common update rule for each $theta_i$ is


$ theta_i^(( t + 1 )) = theta_i^(( t )) - eta med partial_i f ( bold(theta) ) thin , $<eq:grad_update>


or $bold(theta)^(( t + 1 )) = bold(theta)^(( t )) - eta med bold(nabla) f ( bold(theta) )$, where $eta$ is a small parameter called learning rate and


$ partial_i equiv frac(partial, partial theta_i) , med bold(nabla) = (partial_1 , dots.h.c , partial_M) $<eq:gradient>


is the partial derivative with respect to the parameter $theta_i$ and the gradient vector, respectively, using Einstein notation.


There are various ways of estimating the gradient on a quantum computer @romero2018strategies. The most relevant of them are detailed in the Supplementary Material and summarized in the following paragraphs.


==== Finite difference.
<finite-difference.>
One can compute the gradients using finite differences, i.e. $partial_i f ( bold(theta) ) approx ( f ( bold(theta) + epsilon.alt upright(bold(e))_i ) - f ( bold(theta) - epsilon.alt upright(bold(e))_i ) ) / 2 epsilon.alt$, where $epsilon.alt$ is a small number and $upright(bold(e))_i$ is the unit vector with 1 as its $i$-th element and 0 otherwise. As the objective function $f ( theta )$ is obtained with limited accuracy, a good estimation of the gradient requires smaller $epsilon.alt$, i.e. more samples taken from the quantum hardware.


==== Parameter shift rule.
<parameter-shift-rule.>
This strategy was proposed in~@romero2018strategies and developed in~@mitarai2018quantum @schuld2019evaluating. This method computes the gradients exact and $epsilon.alt$ can be large (commonly $epsilon.alt = pi / 2$). This method assumes that the unitary to be optimized can be written as $U ( bold(theta) ) = V G ( theta_i ) W$, where $G = e^(- i theta_i g)$ is the unitary affected by the parameter $theta_i$, $g$ is the generator of $G$ and $V , W$ are unitaries independent of $theta_i$. If $g$ has a spectrum of two eigenvalues $plus.minus lambda$ only, the gradient can be calculated by measuring the observable at two shifted parameter values as follows:


$ partial_i chevron.l f ( bold(theta) ) chevron.r = lambda (chevron.l f ( bold(theta)_(+) ) chevron.r - chevron.l f ( bold(theta)_(-) ) chevron.r) , $


where $bold(theta)_plus.minus = bold(theta) plus.minus ( pi / 4 lambda ) bold(e)_i$. This rule can be generalised to the case where the generator $g$ does not satisfy the eigenspectrum condition (see Supplementary Material for details). It can also be adapted to calculate analytical gradients for fermionic generators of Unitary Coupled-Cluster operators~@kottmann2020feasible and higher order derivatives~@mari2020estimating.


==== L-BFGS.
<l-bfgs.>
It is a quasi-Newton method that efficiently approximates the "inverse Hessian" using a limited history of positions and gradients @liu1989limited @fletcher2000mathematics. While effective in simulations, recent studies observed BFGS methods do not perform well in experimental demonstrations of VQA due to the level of noise in the cost function and gradient estimates @lavrijsen2020classical. Two heuristics were proposed to find quasioptimal parameters for QAOA using BFGS @zhou2020quantum, #smallcaps[INTERP] and #smallcaps[FOURIER] explained in the supplementary material. Efficient initialization of parameters has also been reported using the Trotterized quantum annealing (TQA) protocol~@sack2021quantum. These heuristic strategies can be easily extended to gradient-free optimization methods such as Nelder-Mead.


==== Quantum natural gradient.
<quantum-natural-gradient.>
The update rule of standard gradient descent assumes that the parameter space is a flat Euclidean space. However, in general this is not the case, which can severely hamper the efficiency of gradient descent methods. In classical machine learning, the natural gradient was proposed that adapts the update rule to the non-Euclidean metric of the parameter space~@amari1998natural. Its extension, the quantum natural gradient (QNG) defines the following update rule #cite(<stokes2020quantum>):


$ theta_i^(( t + 1 )) = theta_i^(( t )) - eta med cal(F)^(- 1) ( bold(theta) ) partial_i f ( bold(theta) ) thin , $<eq:natural_grad_update>


where $cal(F) ( bold(theta) )$ is the Fubini-Study metric tensor or quantum Fisher information metric given by


$ cal(F)_(i j) = upright("Re") ( chevron.l partial_i psi ( bold(theta) ) | partial_j psi ( bold(theta) ) | - chevron.r chevron.l partial_i psi ( bold(theta) ) | psi ( bold(theta) ) | chevron.l chevron.r | psi ( bold(theta) ) | partial_j psi ( bold(theta) ) chevron.r ) thin . $<eq:Fubiny_Study>


Superior performance of the QNG compared to other gradient methods has been reported~@yamamoto2019natural @stokes2020quantum and it has been shown that it can avoid becoming stuck in local minima~@wierichs2020avoiding. It can be generalized to noisy quantum circuits~@koczor2019quantum. The QNG can be combined with adaptive learning rates $eta ( theta_i^t )$ that change for every step of gradient descent to speed up training. For hardware efficient PQCs, one can calculate adaptive learning rates using the quantum Fisher information metric~@haug2021optimal. While the full Fubini-Study metric tensor is difficult to estimate on quantum hardware, diagonal and block-diagonal approximations can be efficiently evaluated~@stokes2020quantum and improved classical techniques to calculate the full tensor exist~@jones2020efficient. A special type of PQC, the natural PQC, has a euclidean quantum geometry such that the gradient is equivalent to the QNG close to a particular set of parameters~@haug2021natural.


==== Quantum imaginary time evolution.
<quantum-imaginary-time-evolution.>
Instead of using the standard gradient descent for optimization, a variational imaginary time evolution method was proposed in @mcardle2019variational to govern the evolution of parameters. They focused on many-body systems described by a $k$-local Hamiltonian and considered a PQC that encodes the state $| psi ( tau ) chevron.r$ as a parameterized trial state $| psi ( bold(theta) ( tau ) ) chevron.r$. The evolution of $bold(theta) ( tau )$ with respect to all the parameters can then be obtained by solving a differential equation (see Supplementary for details). It was later shown in~@stokes2020quantum that this method is analogous to the gradient descent via the QNG when considering infinitesimal small step sizes.


==== Hessian-aided gradient descent.
<hessian-aided-gradient-descent.>
A recent work~@huembeli2020characterizing proposed computing the Hessian and its eigenvalues to help analyze the cost function landscapes of QML algorithms. Tracking the numbers of positive, negative, and zero eigenvalues provides insight whether the optimizer is heading towards a stationary point. The Hessian can be computed by doubly applying the parameter shift rule as shown in @mitarai2019methodology and reproduced in the supplementary material. While a deeper analysis is necessary to compare their performance, both QNG and Hessian-based methods try to accelerate optimization by leveraging local curvature information.


==== Quantum Analytic Descent.
<quantum-analytic-descent.>
A method consisting of using a classical model of the local energy landscape to estimate the gradients is proposed in @koczor2020quantum. In this hybrid approach, a quantum device is used to construct an approximate ansatz landscape and the optimization towards the minima of the corresponding approximate surfaces can be carried out efficiently on a classical computer. Using this approximate ansatz landscape, the full energy surface, gradient vector and metric tensor can be expressed in term of the ansatz parameters. The analytic descent has been shown to achieve faster convergence as compared to the QNG.


==== Stochastic gradient descent.
<stochastic-gradient-descent.>
A major drawback of gradient-based methods is the high number of measurements. The stochastic gradient descent (SGD) algorithm addresses this issue by replacing the normal parameter update rule with a modified version


$ bold(theta)^(( t + 1 )) = bold(theta)^(( t )) - alpha med bold(g) ( bold(theta)^(( t )) ) , $


where $alpha$ is the learning rate and $bold(g)$ is an unbiased estimator of the gradient of the cost function. As an estimator, one can take the measurement of the gradient with a finite number of shots~@harrow2019low. This technique can be combined with sampling of the parameter-shift rule terms~@sweke2020stochastic or by extending it to doubly stochastic gradient. For the latter, the finite measurements are performed for only a subset of the expectation values of the Hamiltonian terms. This sampling can be performed in the extreme situation where only one Pauli-term is evaluated at a single point in the quadrature. This is a very powerful method that reduces the number of measurements drastically~@anand2020experimental. This method can be extended beyond circuits that allow the parameter-shift rule by expressing the gradient as an integral~@banchi2020measuring. To accelerate the convergence of SGD for VQA, different strategies are proposed @lyu2020accelerated and briefly explained in the Supplementary.


=== Gradient-free approaches
<gradient-free-approaches>


In this section, we discuss optimization methods for VQA that do not rely on gradients measured on the quantum computer.


==== Evolutionary algorithms.
<evolutionary-algorithms.>
Evolutionary strategies @rechenberg1978evolutionsstrategien @schwefel1977numerische are black-box optimization tools for high dimensional problems that use a search distribution, from which they sample data, to estimate the gradient of the expected fitness to update the parameters in the direction of steepest ascent. More recently, natural evolutionary strategies (NES)~@wierstra2014natural have demonstrated considerable progress in solving these high dimensional optimization problems. They use natural gradient estimates for parameter updates instead of the standard gradients. They have been adapted for optimization of VQA~@zhao2020natural @anand2020natural and have been shown to have similar performance as the state-of-the-art gradient based method. In @anand2020natural it is shown that NES, along with techniques like Fitness shaping, local natural coordinates, adaptive sampling and batch optimization, can be used for optimization of deep quantum circuits.


==== Reinforcement learning.
<reinforcement-learning.>
Several authors have used reinforcement learning (RL) to optimize the QAOA parameters @garcia2019quantum @khairy2019reinforcement @wauters2020reinforcement @yao2020noise @yao2020policy. This framework consists of a decision-making agent with policy $pi_(bold(theta)) ( a | s )$ parameterized by $bold(theta)$, which is a mapping from the state space $s in { S }$ to an action space $a in { A }$. In response to the action, the environment provides the agent with a reward $r$ from the set of rewards ${ R }$. The goal of RL is to find a policy which maximizes the expected total discounted reward. For more details, refer to @sec:applications_ML_RL. In the context of QAOA, for example, ${ S }$ can be the set of QAOA parameters ($bold(gamma) , bold(beta)$) used, $a$ can be the value of $gamma$ and $beta$ for the next iteration, and the reward can be the finite difference in the QAOA objective function between two consecutive iterations. The policy can be parameterized by a deep neural network with the weights $bold(theta)$. The policy parameters $bold(theta)$ can be optimized using a variety of algorithms such as Monte-Carlo methods~@hammersley2013monte @sutton2018reinforcement, Q-Learning~@watkins1992q and policy gradient methods~@sutton2018reinforcement.


==== Sequential minimal optimization.
<sequential-minimal-optimization.>
In machine learning, the sequential minimal optimization (SMO) method~@platt1998sequential has proven successful in optimizing the high-dimensional parameter landscape of support vector machines. The method breaks the optimization into smaller components for which the solution can be found analytically. This method has been applied to variational circuit optimization~@nakanishi2020sequential, circuit optimization with classical acceleration~@parrish2019jacobi and circuit optimization and learning with Rotosolve and Rotosolect~@ostaszewski2019quantum.


==== Surrogate model-based optimization.
<surrogate-model-based-optimization.>
When function evaluations are costly, it pays off to not only use the current function value to inform a next parameter value, but to use all previous evaluations to extract information about the search space. The function values in memory are used to build a surrogate model, an auxiliary function that represents the full expensive cost function based on the current information. All optimization happens on the surrogate cost landscape, so no explicit derivatives of the cost function are needed. Through the use of a fitted cost function, these methods are also expected to be more resilient to noise. Several classical surrogate models have been included in the scikit-quant package~@lavrijsen2020classical @scikit-quant. In the Bound optimization by quadratic approximation (BOBYQA) algorithm~@powell2009bobyqa, a local quadratic model is formulated from the previous function values. It is then minimized in the trust region to obtain a new parameter value. When the evaluation at this new parameter value does not result in a lower function value, the trust region is altered and the quadratic model is optimized in this new parameter space. It was shown that this method works well when the PQC is initialized close to the optimal parameters but has more problems with shallow optimization landscapes and gets stuck in local minima~@lavrijsen2020classical. The stable noisy optimization by branch and fit (SnobFit)~@huyer2008snobfit algorithm uses a branching algorithm to explore new areas in parameter space.


=== Resource-aware optimizers
<resource-aware-optimizers>


Optimization methods and strategies adopted for early demonstrations of VQA are largely general-purpose and black-box with minimal emphasis on reducing the quantum resources used in the optimization. Therefore, they are more costly and prone to errors than their classical counterparts. Optimizers developed in more recent years are tailored to additionally minimize quantities associated with the quantum cost of the optimization, e.g. number of measurements or real hardware properties. Additionally, one can use circuit compilation methods as the ones described in @sec:compilers.


==== ROSALIN.
<rosalin.>
While VQA leverage low-depth circuits to execute on near-term quantum processors, a significant challenge in implementing these algorithms is the prohibitive number of measurements, or shots, required to estimate each expectation value that is used to compute the objective. To address the challenge, @arrasmith2020operator developed a shot-frugal optimizer called ROSALIN (Random Operator Sampling for Adaptive Learning with Individual Number of shots) that effectively distributes fractions of a predefined number of shots to estimate each term of the Hamiltonian as well as each partial derivative. Given the expectation value of the Hamiltonian decomposed into the $h_i$ terms as in @eq:Pauli_string,


the authors note several strategies for allocating shots for estimating each term $chevron.l h_i chevron.r$. While a naive strategy would allocate equal numbers of shots per term, the authors observed lower variance in the energies using weighted approaches in which the number of shots allocated to the $i$-th term $b_i$ is proportional to the corresponding Hamiltonian coefficient $c_i$.


==== SPSA.
<spsa.>
In experimental realizations of VQA, the optimizer is often hindered by statistical noise. In @kandala2017hardware this issue is circumvented by applying the simultaneous perturbation stochastic approximation (SPSA) algorithm @spall1992multivariate, in which the algorithm hyperparameters are determined by experimental data on the level of statistical noise. Compared to the finite-difference gradient approximation, which requires $O ( p )$ function evaluations for $p$ parameters, SPSA requires only two evaluations, as explained in the supplementary. The convergence of SPSA with various types of PQCs has been studied~@woitzik2020entanglement.


= OTHER NISQ APPROACHES
<sec:non-variational>


We proceed to review some of the notable NISQ algorithms, besides VQA. These algorithms do not require tuning the parameters of a PQC in an adaptive feedback manner and often exploit analog or hybrid paradigms that constitute alternatives to the digital quantum computation.


== Quantum annealing
<subsec:quantum-annealing>


Quantum annealing (QA) ~@finnila1994quantum @kadowaki1998quantum derives its inspiration from simulated annealing (SA), a classical global optimization technique, usually employed to solve combinatorial optimization problems. SA can be valuable in discovering global optima in situations involving many local optima. The word "annealing" comes from metallurgy, which represents heating and slow cooling. In SA, one identifies the objective function with the energy of a statistical-mechanical system. The system is assigned an artificially-induced control parameter, called temperature. Like annealing, SA starts with some high temperature $T$, and then the value of $T$ is brought down following some temperature variation function called "annealing schedule" such that the final temperature is $T = 0 .$ The algorithm chooses a candidate state close to the current state randomly. If it improves the solution, it is always accepted with probability $1$. If it does not, then the acceptance is determined based on a temperature-dependent probability function. The idea of tolerating worse solutions can be considered as a virtue of the algorithm. In SA, the probability that a bad solution is accepted is slowly decreased as the solution space is explored. This relates to the notion of "slow cooling" in annealing.


In QA, one utilises quantum-mechanical fluctuations, like quantum tunnelling, to explore the solution space. This is analogous to the idea of using thermal fluctuations in SA to explore the solution space. In QA, artificial degrees of freedom of quantum nature via non-commutative operators are introduced, which induces quantum fluctuations. The strength of these quantum fluctuations is controlled using an annealing schedule (similar to SA, where we decrease the temperature). The physical idea behind annealing schedule in QA is to move the system from some initial Hamiltonian ground state to the ground state of the problem Hamiltonian. The concept of QA is related to the notion of quantum adiabatic evolution, which is being used for adiabatic quantum computation~@farhi2000quantum @albash2018adiabatic.


We proceed to a formal discussion now. Adiabatic quantum computation is model of computation based on quantum mechanical processes operating under adiabatic conditions~@farhi2000quantum @albash2018adiabatic. Before understanding adiabatic quantum computation, one needs to grasp the concept of $k$-local Hamiltonian.


#thmbox("theorem", "Definition")[


#strong[k-local Hamiltonian]: A $k$-local Hamiltonian is a Hermitian matrix of the form $H = sum_(i = 1)^r hat(h)_i$ where each term is a Hermitian operator acting non-trivially on at-most $k$ qudits, i.e., $hat(h)_i = h ⊗ I$ where $h$ is a Hamiltonian acting on at-most $k$ neighbouring qudits and $I$ is the identity operator.


] <def:k-loc>


Let us consider a time-dependent hamiltonian $H ( s )$, for $s equiv t / T in \[ 0 , 1 \]$ and a quantum system initialized in the ground state of $H ( 0 )$. We assume that $H ( s )$ varies smoothly as a function of $s$ and $H ( s )$ has a unique ground state for $s in \[ 0 , 1 \]$. A quantum state initialized in $| psi ( t = 0 ) chevron.r$ evolves according to the following Schrödinger equation (setting $ℏ = 1$),


$ i frac(d, d t) | psi ( t ) chevron.r = H ( t ) | psi ( t ) chevron.r . $<eq:-schro_1>


The above equation can be further, equivalently, written as


$ i frac(d, d s) | psi ( s ) chevron.r = T H ( s ) | psi ( s ) chevron.r . $<eq:-schro_2>


Assuming $| psi ( 0 ) chevron.r$ is a ground state of $H ( 0 ) ,$ then in the limit $T arrow.r oo$, $| psi ( t ) chevron.r$ is a ground state of $H ( 1 )$ obtained via evolution #ref(<eq:-schro_1>). Such an evolution will be, henceforth, referred as adiabatic evolution according to $H$ for time $T$.


Now we proceed to define adiabatic quantum computation.


#thmbox("theorem", "Definition")[


#strong[Adiabatic quantum computation (adapted from @aharonov2008adiabatic)]: An adiabatic quantum computation is specified by two $k$-local Hamiltonians $H_0$ and $H_1$ acting on n qudits and a map $s ( t ) : \[0 , T\] arrow.r \[ 0 , 1 \] .$ The input of the computation is the ground state of $H_0$, which is unique and is a product state. The desired output is given by a quantum state which is $epsilon.alt -$close in l2-norm to the ground state of $H_1$. Furthermore, $T$ is the smallest time such that the adiabatic evolution generated via $H ( s ) = ( 1 - s ) H_0 + s H_1$ for time $T$ yields the desired output. The running time of the algorithm is given by $T dot upright("max")_s ‖H ( s )‖ ,$ where $∥.∥$ denotes the spectral norm.


]


QA relaxes the strict requirement of adiabatic evolution, thus allowing diabatic transitions due to the finite temperature of the system, from fast changes of Hamiltonian parameters, and the interaction with the noisy environment~@hauke2020perspectives. Because of diabatic transitions, QA is prone to getting trapped in excited states.


QA has been investigated for problems in diverse areas including machine learning~@li2018quantum @benedetti2017quantum @o2015bayesian @benedetti2016estimation @benedetti2018quantum, protein folding~@perdomo2008construction @perdomo2012finding @babbush2012construction @babej2018coarse, fault diagnosis @perdomo2015quantum @perdomo2019readiness, compressive sensing~@ayanzadeh2019quantum, finance~@orus2019quantum @bouland2020prospects @marzec2016portfolio @rosenberg2016solving @venturelli2019reverse @cohen2020portfolio, fermionic simulation @babbush2014adiabatic and high energy physics~@mott2017solving @das2019track. The protein folding problem entails calculating a protein's lowest free-energy structure given its amino-acid sequence. The goal is to solve the protein folding problem by mapping it to a Hamiltonian and then using QA to identify low-energy conformations of the protein model. In~@perdomo2012finding, authors use five and eight qubits for the four-amino-acid sequence to encode and solve the protein folding problem for a short tetrapeptide and hexapeptide chain. QA has been one of the prominent approaches in the NISQ era in the search for quantum advantage~@perdomo2018opportunities @bouland2020prospects @hauke2020perspectives.


A major experimental implementation of QA is the D-Wave machine. It attempts to solve problems in a particular form called Quadratic Unconstrained Binary Optimization (QUBO)~@lucas2014ising. Optimization problems can be cast as a polynomial unconstrained binary optimization (PUBO) expressed in the form of a $k$-local interaction with $k gt.eq 3$ over binary variables $x_i in (0 , 1)$ ~@hauke2020perspectives @perdomo2019readiness. QUBO is a special case of PUBO with $k = 2 .$ For a vector of $n$ binary variables $bold("x") in (0 , 1)^n$ and problem specified values of $Q in bb(R)^(n times n)$ and $bold("c") in bb(R)^n$, QUBO is defined as


$ arg min bold("x")^T Q bold("x") + bold("c")^T bold("x") . $<eq:QUBO_1>


Using the map $x_i arrow.r frac(1 - sigma_z^i, 2)$, one can convert the problem in expression @eq:QUBO_1 to ground state finding problem of the following diagonal $n$-qubit Ising Hamiltonian (up to a constant),


$ H_(upright("QUBO")) = - sum_(i , j) J_(i , j) hat(sigma)_z^i hat(sigma)_z^j - sum_i h_i hat(sigma)_z^i , $<eq:QUBO_Ham>


where $hat(J)_(i , j) = - Q_(i , j) / 4$ and $h_i = frac(- c_i + sum_j Q_(i , j), 2) .$


Starting with the ground state of the base Hamiltonian $H_0 = - sum_i hat(sigma)_x^i$, solving the QUBO problem on a quantum annealer corresponds to implementing the annealing schedule $A ( t )$ and $B ( t )$ for the Hamiltonian


$ H ( t ) = A ( t ) H_0 + B ( t ) H_(upright("QUBO")) . $<eq:Annealing_Schedule>


Here, $A ( 0 ) = B ( T ) = 1$ and $A ( T ) = B ( 0 ) = 0$, where $T$ is computation time. Because annealing does not necessarily satisfy the constraints of adiabatic evolution, one can end up in excited states as mentioned earlier. However, one can run the annealing schedule multiple times and take the best answer i.e, the one corresponding to lowest energy. The qubits in an annealer are not necessarily all-to-all connected, necessitating additional engineering restrictions, such as the minor embedding problem~@choi2008minor @choi2011minor @klymko2014adiabatic.


The potential of QA has been studied extensively ~@hastings2020power @hauke2020perspectives @farhi2002quantum @denchev2016computational @brady2016spectral. The performance of D-Wave annealers have also been explored comprehensively~@shin2014quantum @albash2015reexamining @cohen2020portfolio. In particular, an extensive study comparing the performance of quantum annealing with other quantum-inspired and classical optimization state-of-the-art strategies, and in the context of a real- world application, can be found in @perdomo2019readiness. For the details of QA, refer to @hauke2020perspectives and the references therein. A review on Adiabatic Quantum Computation is presented in @albash2018adiabatic. Refer to~@sec:QML and @sec:finance for the discussions regarding applications of QA in machine learning and finance respectively.


== Gaussian boson sampling
<sec:GBS>


// [figvision] imgs/Gaussian_boson_sampling.png
// This single schematic shows a four-mode Gaussian boson sampling circuit. Four horizontal qumode lines each
// start at vacuum |0⟩. Line 1 passes a squeezer S(z₁) and phase shifter R(θ₁); line 2 passes S(z₂) and R(θ₂);
// line 3 passes a two-mode squeezer S(z₃,z₄) and R(θ₃); line 4 passes R(θ₄). The lines then enter an
// interferometer mesh of beam splitters drawn as rounded boxes with a blue diagonal cross and labelled BS,
// arranged in staggered columns coupling pairs of adjacent modes, with wires connecting BS outputs to the next
// stage inputs. Each line ends at a photon-number-resolving detector labelled n̂. The message is that vacuum
// Gaussian states are squeezed, phase shifted, linearly mixed by the interferometer, and measured in the Fock
// basis.
#figure(scope: "parent", image("imgs/Gaussian_boson_sampling.png", width: 100%),
  caption: [
    Gaussian boson sampling circuit for a photonic setup. The qumodes are prepared in gaussian states from the vacuum by squeezing operations $S ( z_i )$, followed by an interferometer consisting of phaseshifters $R ( theta ) = e^(i theta_j)$ and beam-splitters BS. At the end, photon number resolving measurements are made in each mode.
  ]
)
<fig:boson_sampling>



Boson sampling was first proposed as a candidate for quantum computational supremacy by @aaronson2011computational. The scenario consists of having $n$ photons that enter an optical circuit consisting of $m$ modes. This state is then acted upon by a series of phase-shifters and beam-splitters. A phase-shifter adds a phase $R ( theta ) = e^(i theta_j)$ with some angle $theta_j$ to the amplitude in mode $j$, and acts as the identity in the other $m - 1$ modes. A beam-splitter acts on two modes with a rotation $mat(delim: "(", cos phi.alt, - sin phi.alt; sin phi.alt, cos phi.alt)$ for some angle $phi.alt$ and as the identity in the other $m - 2$ modes. Finally, a measurement is made where the number of photons in each mode is found. An optical circuit with these elements is shown in @fig:boson_sampling. Each of these measurement outcomes represent a sample from the the symmetric wavefunction that bosonic systems have. Aaronson and Arkhipov found that the existence of an efficient classical algorithm for sampling from the distribution implies the existence of a classically efficient algorithm for the calculation of the permanent of a related matrix. Such an algorithm would imply the collapse of the polynomial hierarchy (see @ch1:subsec:non-complexity) to the third order, which is believed to be unlikely~@arora2009computational. Consequently, such an algorithm is unlikely to exist.


Gaussian boson sampling (GBS) is a variant of boson sampling, where instead of photon states as inputs into the optical circuit, Gaussian states are used as inputs @hamilton2017gaussian. Gaussian states are those whose Wigner quasi-probability distributions $W ( q , p )$ have Gaussian shape. A good introduction to the theory can be found in~@serafini2017quantum. They have the advantage that they can be created deterministically @hamilton2017gaussian @kruse2019detailed. They also provide additional degrees of freedom in comparison to boson sampling. Where boson sampling is equivalent to sampling from the permanent of a matrix, GBS is computationally equivalent to sampling from the Hafnian function of a matrix. Given a graph $G$ with adjacency matrix $E ,$ the Hafnian of $E$ is the number of perfect matchings of the graph $G .$ A matching of a graph $G$ is a subset of edges $M$ such that no two edges in $M$ have a vertex in common. A matching $M$ is perfect if every vertex is incident to exactly one edge in $M .$ While the Permanent gives the number of perfect matchings for a bipartite graph; the Hafnian gives perfect matching for any graph. Thus, the Hafnian can be thought of as a generalization of the Permanent. Using the adjacency matrix $E ,$ the relation between the Hafnian and the Permanent is given by


$ upright("Haf") mat(delim: "(", 0, E; E^T, 0) = upright("Per") ( E ) . $<ch2:eq:haf_per>


The hardness of simulating a noisy version of GBS has been studied~@qi2020regimes and GBS has recently become the second platform to show quantum computational supremacy @zhong2020quantum, and the latest experimental venture towards dynamically programmable GBS nanophotonic chip was carried out by~@arrazola2021quantum.


=== The protocol
<the-protocol>


In GBS we consider $m$ quantum modes (#emph[qumodes]), represented by harmonic oscillators with canonically conjugate variables $q$ and $p$. Gaussian states of the qumodes are those represented by a Wigner-function $W ( q , p )$ that has a Gaussian form. These states can be efficiently represented by the complex amplitude $alpha = 1 / sqrt(2 ℏ) ( q + i p )$ and a covariance matrix $Sigma in bb(C)^(2 m times 2 m)$. A general pure Gaussian state can be generated from a vacuum with three steps: #emph[i)] Single mode squeezing; #emph[ii)] multi-mode linear interferometry; and #emph[iii)] single-mode displacements. In the GBS protocol the state is then measured in the Fock-basis, performed in practice using photon number resolving detectors. The optical circuit in @fig:boson_sampling shows how the system is initialized in the vacuum state, followed by single- and multi-mode squeezing operators $S ( z_i )$ and $S ( z_i , z_j )$, respectively, and an interferometer with phaseshifters $R ( theta_j )$ and beamsplitters BS. At the end of the protocol, the photon number in each mode is measured.


For a Gaussian state with zero mean (of the Wigner-function), the probability of detecting $s_i$ photons in the $i$-th qumode is given by:~@hamilton2017gaussian @kruse2019detailed


$ P ( s_1 , s_2 . . . s_m ) = frac(1, upright("det") ( Q )) frac(upright("Haf") ( A_s ), sqrt(s_1 ! s_2 ! dots.h.c s_m !)) $<ch2:eq:GBS_probabilites>


where all the matrices are defined in terms of the covariance matrix $Sigma$:


$ Q = Sigma + bb(1) / 2\
A = X ( bb(1) - Q^(- 1) )\
X = mat(delim: "[", 0, bb(1); bb(1), 0) $


The $A_s$ matrix is a matrix created from $A$ such that if $s_i = 0$, we delete the rows and colums $i$ and $i + m$ of the matrix, and if $s_i eq.not 0$, we repeat the rows and columns $s_i$ times.


This means that by manipulating the covariance matrix $Sigma$, we control the matrix from which we sample the Hafnian. For a pure Gaussian state, it can be shown that the $A$ matrix is symmetric~@bromley2020applications.


A simpler form of the experiment where instead of counting the number of photons in each mode, we only detect if there are photons or not in each mode, can be used to sample from the so-called Torontonian function of a matrix~@quesada2018gaussian. If the probability of observing more than one photon per output mode stays low enough, this model has been shown to stay classically intractable to simulate. A more general experiment instead, where the mean of the Gaussian states is non-zero, can be used to sample from the loop Hafnian~@bjorklund2019faster.


=== Applications
<applications>


A number of algorithms for applications of GBS have been investigated, and are reviewed by @bromley2020applications. Here we only briefly summarise that work. Typically GBS algorithms are based on heuristics, and GBS devices are often used to provide a seed for starting points of classical algorithms. GBS can also be viewed as directly giving access to a statistical distribution, such as in the case of point processes~@jahangiri2020point.


Problems in chemistry have been tackled using GBS. Vibrational spectra of molecules have been computed using GBS by mapping the phononic modes of the molecule to the qumodes of the GBS device~@huh2015boson, and by extension electron-transfer reactions have been studied~@jahangiri2020quantum. The technique of sampling high-weight cliques has also been applied to predict molecular docking configurations~@banchi2020molecular.


The largest number of GBS algorithms are for graph problems, since the adjacency matrix of a graph is a natural fit as the symmetric $A$ matrix. The Hafnian function computes the number of perfect matchings of a graph, so the samples from the GBS device are with high likelihood from sub-graphs with high density. This is how GBS is used to identify dense subgraphs~@arrazola2018using, and to get good initial guesses for classical search algorithms to compute the max-clique of a graph~@banchi2020molecular.


GBS can also be used to build succinct feature vectors, or "fingerprints", of larger graphs via coarse-graining techniques. These feature vectors can then be used as inputs to statistical methods or machine learning to classify graphs. One such problem is to measure the similarity between graphs~@schuld2020measuring, which has applications in tasks such as checking fingerprint comparison or detecting mutations of molecules.


GBS can also be used as a type of importance sampling device to speed up algorithms requiring randomness. This is how stochastic search algorithms have been sped up by sampling from a GBS device encoding the graph to be searched, instead of sampling uniformly~@arrazola2018quantum.


Recently variational methods have been used within the GBS framework~@banchi2020training and applied to stochastic optimization and unsupervised learning. The method is based on varying the squeezing and interferometer parameters in the device and updating based on the measurement outcomes.


== Analog quantum simulation
<analog-quantum-simulation>


Simulating a quantum system is a hard problem for classical computers as the Hilbert space increases exponentially with the size of the system. As a solution to this long-standing problem, Feynman suggested the ground breaking idea to harness that physical systems given us by nature are quantum-mechanical. He proposed to use quantum systems that are well-controlled in the lab to simulate other quantum systems of interest~@feynman1982simulating. This concept has spurred the field of analog quantum simulation~@georgescu2014quantum @trabesinger2012quantum.


The core idea differs from digital quantum simulation~@lloyd1996universal. Digital quantum simulators decompose the quantum dynamics to be simulated into a circuit of discrete gate operations that are implemented on a quantum processor. The quantum processor is a well controlled quantum system, that is engineered to be able to efficiently apply a set of specific quantum gates that are universal, i.e. a sequential application of those gates can realize arbitrary unitaries (see @sec:gate_set).


With this universal approach, a wide range of quantum problems can be simulated to a desired accuracy with a polynomially increase in quantum resources only~@lloyd1996universal. However, current quantum processors have only limited coherence time and lack the capability to correct errors that inevitably appear during the computation, severely limiting the range of dynamics that can be simulated. In contrast, the idea of analog quantum simulators is to map the problem Hamiltonian to be simulated $hat(H)_(upright("sys"))$ to the Hamiltonian of the quantum simulator $hat(H)_(upright("sim"))$, which can be controlled to some degree, $hat(H)_(upright("sys")) arrow.l.r hat(H)_(upright("sim"))$. One then runs the quantum simulator, and maps the results back to the problem.


The range of problems that can efficiently mapped to the simulator is limited, however as one uses the native quantum dynamics of the simulator, the accessible system size, coherence length and errors is often more favorable compared to current digital quantum simulators.


=== Implementations
<implementations>


A wide-range of implementations in various controlled quantum systems has been achieved, ranging from solid state superconducting circuits~@houck2012chip, quantum dot arrays~@hensgens2017quantum, nitrogen-vacancy centers~@yao2012scalable, atomic and molecular physics based platforms such as trapped ions~@blatt2012quantum, interacting photons~@chang2014quantum @hartmann2016quantum, Rydberg atoms~@adams2019rydberg, and cold atoms~@bloch2012quantum @gross2017quantum @amico2020roadmap.


Concepts of analog quantum simulation have been used within VQA as well, such as problem inspired ansätze (see @sec:HamiltonAnsatz) or protocols inspired by quantum control~@yang2017optimizing @meitei2020gate. Experimental results for a quantum many-body problem beyond current classical computational capabilities have been reported for 2-D systems~@choi2016exploring.


=== Programmable quantum simulators
<programmable-quantum-simulators>


An analogue quantum system, such as a superconducting circuit, can be adapted to simulate arbitrary dynamics~@bastidas2020fully. The idea is to drive the parameters of the Hamiltonian $H ( t )$ that describes the analog quantum simulator in time $t$. This can be done by adjusting the physical parameters of the quantum simulator in time. The driving protocol is engineered via machine learning methods~@haug2020engineering such that the effective dynamics of the driven system over a time $T$ corresponds to the evolution of a problem Hamiltonian one wants to simulate. The effective dynamics that is generated can realize long-range interactions as well as complicated many-body terms, which are natively not supported by the quantum simulator and are often hard to simulate on digital quantum simulators. By periodically driving the analog quantum simulator with the aforementioned driving protocol, various problem Hamiltonians can be simulated~@oka2019floquet. One can realize complicated many-body dynamics or chemistry problems , as well as solve combinatorial tasks such as SAT-3. Trapped ion based analog quantum simulators have been recently used for the implementation of quantum approximate optimization algorithm~@Pagano2020quantum.


Highly controllable analog quantum simulators have also been proposed for engineering quantum chemistry Hamiltonians by combining different cold atom species embedded within cavity modes, which mediate long-range interactions required to simulate Coulomb repulsion. Optical fields can be used to modify the potential and interaction parameters in order to simulate large scale chemistry problems~@arguello2019analogue as well as quantum spin model with tunable interactions for system sizes ranging from 64 to 256 qubits @ebadi2020quantum. For ion traps, a programmable quantum simulator can be designed by light fields, that are applied to manipulate the internal degrees of freedom as well as the interaction between different ions. This allows one to simulate various types of spin Hamiltonians with a high degree of control over the parameters~@monroe2019programmable.


== Digital-analog quantum simulation and computation
<sec:digi-ana>


As opposed to analog simulators that are limited by the Hamiltonians they can simulate~@goldman2014periodically @kyriienko2018floquet, digital quantum simulators can simulate any system's Hamiltonian, but with sometimes costly quantum resources. To benefit from a combination of the two approaches, the digital-analog method to quantum computation~@dodd2002universal @parra2020digital and simulation~@mezzacapo2014digital @yung2014transistor has been proposed. These schemes combine the application of digital single-qubit gates with the underlying analog Hamiltonian of the quantum processor. This approach allows for universal simulation of quantum dynamics while replacing two qubit gates for an analog Hamiltonian and has been argued to be more resilient against certain types of noise than digital quantum computing~@parra2020digital @martin2020digital @garcia2021noise.


Digital-analog quantum simulation has been proposed to simulate the Rabi model @mezzacapo2014digital, Dicke model @mezzacapo2014digital @lamata2017basic, and fermionic systems @garcia2015fermion @celeri2021digital. Digital-analog quantum simulation has been reviewed in @lamata2018digital, whereas digital-analog quantum computing is more recent. The implementation of digital-analog quantum computing has been proposed for superconducting platforms @yu2021superconducting @gonzalez2021digital. So far the computing framework has been used to simulate Ising models @parra2020digital, where the analog blocks can be used to enhance the effective connectivity of the qubits to simulate graphs that have a different connectivity from the native connectivity of the quantum device~@galicia2020enhanced. The analog blocks have also been applied to reduce the operation count required to perform the quantum Fourier transform @martin2020digital.


The digital-analog approach has also been combined with VQA (see @ch:building) resulting in a digital-analog QAOA algorithm, where the two-qubit gates have been replaced by analog blocks @headley2020approximating. This also has two versions: #emph[i)] where a layer of entangling gates is replaced by an analog block; and #emph[ii)] where a continuous analog block is applied continuously with single-qubit operations overlayed.


== Iterative quantum assisted eigensolver
<sec:IQAE>


Almost all of the VQAs update a PQC's parameters in a feedback loop. However, there exist alternative algorithms that can circumvent this approach with the ansatz given by~@bharti2020iterative @huang2019nearterm @mcclean2017hybrid


$ | phi.alt (bold(alpha) ( t ) , bold(theta)) chevron.r = sum_(i = 0)^(m - 1) alpha_i ( t ) | psi_i (bold(theta)_i) chevron.r , $<eq:IQAE_Ansatz>


where $alpha_i in bb(C)$ and $theta_i in bb(R)^(k_i)$ for non-negative integers $k_i .$ This ansatz is a linear combination of quantum states, where the $alpha_i$ parameters are stored on a classical device. In the special case $m = 1$ it corresponds to the usual PQC, whereas for $m > 1$ this ansatz subsumes it. This ansatz has been used for finding the ground state of Hamiltonians~@bharti2020quantumeigensolver @bharti2020iterative, excited state~@parrish2019quantum @parrish2019quantum2 @huggins2020non @stair2020multireference the simulation of quantum dynamics~@bharti2020quantum @haug2020generalized, error mitigation~@mcclean2017hybrid, nonlinear dynamics~@bharti2020quantum @haug2020generalized, linear systems~@huang2019nearterm and semidefinite programming~@bharti2021nisq. If one keeps the parameters of the PQC $theta_i$ fixed and only varies the $alpha_i$, the algorithm can be considered a borderline non-VQA algorithm. Update of $theta_i$ parameters has been shown to cause trainability issues in VQA (see @sec:BP) and thus by fixing $theta_i$ one can by construction circumvent these issues. We present here the iterative quantum assisted eigensolver algorithm (IQAE) as an illustration, and in the applications subsection the quantum assisted simulator for closed systems (see @sec:quantum_assisted_simulator), open systems (see @sec:OpenQuantumSystem) and Gibbs state preparation (see @sec:gibbsstate).


The IQAE algorithm provides an approximation to the ground state of a Hamiltonian $H$. Without loss of generality, the $N$-qubit Hamiltonian $H$ is assumed to be a linear combination of unitaries


$ H = sum_(i = 1)^m beta_i U_i thin . $<eq:LCU_Ham>


Here, $beta_i in bb(C)$ and $U_i in S U (2^N)$ for $i in (1 , 2 , dots.h.c , m) .$ The unitaries $U_i$ act on at most $cal(O) (p o l y (log N))$ qubits. This condition can be relaxed if the unitaries Pauli strings (see @sec:pauli_strings). The ansatz state is taken as linear combination of "cumulative $K$-moment states" $bb(C S)_K$, which is generated using some efficiently preparable quantum states and the unitaries defining the Hamiltonian in @eq:LCU_Ham. For pedagogical reasons, we present the definition of $K$-moment states and cumulative $K$-moment states.


#thmbox("theorem", "Definition")[ (adapted from @bharti2020iterative) For a given positive integer $K$, a set of unitaries $bb(U) equiv {U_j}_(j = 1)^m$ and a quantum state $| psi chevron.r , K$-moment states is the set of quantum states of the form ${U_(j_K) dots.h.c U_(j_2) U_(j_1) | psi chevron.r}_j$ for $U_(j_l) in bb(U) .$ Let us denote the aforementioned set by $bb(S)_K$. We define the singleton set ${| psi chevron.r}$ as the $0$-moment state (denoted by $bb(S)_0$). Finally, we define the cumulative $K$-moment states $bb(C S)_K$ as $bb(C S)_K equiv union_(i = 0)^K bb(S)_i$.
] <def:cumulant_states>


As instructive example, note that the set of $1$-moment states is ${U_j | psi chevron.r}_(j = 1)^m$, where the unitaries ${U_j}_(j = 1)^m$ make up the Hamiltonian $H$. The set of cumulative $1$-moment states is $bb(C S)_1 = { | psi chevron.r } union {U_j | psi chevron.r}_(j = 1)^m ,$ and the set of cumulative $K$-moment states is $bb(C S)_K = { | psi chevron.r } union {U_(j_1) | psi chevron.r}_(j_1 = 1)^m union dots.h union {U_(j_K) dots.h U_(j_1) | psi chevron.r}_(j_1 = 1 , dots.h , j_K = 1)^r$.


Now, the ansatz is is given by $| xi (alpha) chevron.r^((K)) = sum_(| chi_j chevron.r in bb(C S)_K) alpha_j | chi_j chevron.r$. The ground state problem reduces to the following optimization program


$ min_alpha & thin alpha^dagger cal(D)^((K)) alpha\
upright("subject to ") & alpha^dagger cal(E)^((K)) alpha = 1 thin . $<eq:QCQP_1>


Here, the overlap matrices $cal(D)^((K))$ and $cal(E)^((K))$ are given by $cal(D)_("nm")^((K)) = sum_i beta_i chevron.l chi_n | U_i | chi_m chevron.r$ and $cal(E)_("nm")^((K)) = chevron.l chi_n | chi_m chevron.r$. These overlap matrices can be computed on a quantum computer without the requirement of any complicated measurement involving multi-qubit controlled unitaries. For example, for a Hamiltonian composed of Pauli strings, the product of Pauli strings is a Pauli string up to a phase factor $plus.minus$1 or $plus.minus iota$. Thus, the overlap matrices are simply expectation values $chevron.l psi | hat(P) | psi chevron.r$ of some Pauli string $hat(P)$, which can be easily measured (see @sec:measurement).


The optimization program @eq:QCQP_1 is a quadratically constrained quadratic program (QCQP) with single equality constraint. The Algorithms proceeds in three serial and disjoint steps.

+ Select ansatz, which can be done on paper

+ Estimate overlap matrices on quantum computer, which can be done efficiently in a parallel fashion.

+ Post-processing on a classical computer to solve the QCQP based on the overlap matrices from step $2$.


As a major speedup compared to standard VQA, there is no feedback loop between classical and quantum computer such that the calculations can be easily parallelized. The ansatz can be improved by changing $K$ to $K + 1 .$ The ansatz construction is systematic and there is no trainability issue such as the barren plateau problem (see @sec:BP). For the QCQP, there exist conditions which tell whether a local minima is a global minima as a stopping criteria for the classical solver. Moreover, the Lagrangian relaxation of the program @eq:QCQP_1 is a semidefinite program and efficiently solvable.

= THEORETICAL CHALLENGES
<theoretical-challenges>


== Barren plateaus
<sec:BP>


It was recently shown that the expectation value of the gradient of the objective function corresponding to randomly initialized PQCs (RPQC) decays exponentially to zero as a function of the number of qubits~@mcclean2018barren. The mathematical basis of this result hinges on the fact that the PQC from @eq:HE_ansatz becomes a unitary $2$-design as the circuit depth increases polynomially with the circuit width i.e, the number of qubits. The notion of unitary $2$-design has been used extensively in the recent proofs of barren plateau in RPQCs, which necessitates a small discussion about their mathematical structure.


Using the notion of $2$-design, the appearance of barren plateaus in the training landscape has been established for various kind of ansätze. Barren Plateaus can be thought of as a consequence of the exponentially large dimension of the Hilbert space when the number of qubits increases and the fact that the variational circuit unitary, when the parameters are initialized at random, is a 2-design. Consequently, the strategies proposed to tackle this problem focus on reducing the space dimension of this unitary or breaking the randomness properties related to the 2-designs. Another way to think of the origin of the barren plateau issue could be the problem-agnostic nature of the ansatz, faced with exponentially large parameter space. Thus, one could attempt to devise ansätze as well as the optimization methodology in a problem-aware manner by using physically-inspired or problem-specific ansätze as the ones presented in @sec:PQC or those proposed in~@sec:IQAE.


Besides the exponential parameter space that induced barren plateaus, other physical phenomena can also generate them. In particular, the noise and decoherence present in the quantum computing experiments also generates this problem in VQAs @wang2020noise. Entanglement-induced barren plateaus have also been reported recently~@marrero2020entanglement.


While certain ansätze can be assumed or proven to form (approximate) 2-designs, such proofs are challenging for the general ones. To numerically verify the presence of barren plateaus, past studies often considered computing the gradients and variances of a local observable using a particular ansatz over increasing system sizes~@mcclean2018barren @skolik2020layerwise.


Another attempt to avoid a barren plateau is to initialize the variational circuit with a particular state choice. Intuitively, the algorithm will start in a particular region of the Hilbert space allowing the optimization subroutine to potentially find the minima in a closer region. This strategy include all physically inspired methods mentioned in @sec:PQC. The use of clever encodings for the algorithm parameters can also be understood as a initialization strategy @cervera2020meta (see @sec:QML). Classical algorithms such as neural networks can also be used to learn the proper circuit encodings~@verdon2019learning.


A good choice for the initial state is often not enough to reduce the size of the Hilbert space. Although expressive circuit ansätze are usually a requirement for the success of a VQA (see @sec:expressibility for more details), it can expand the parameter space that the optimizer has to explore. Several works propose circuit structures that reduce that space by introducing correlations between the variational parameters of the circuit @volkoff2020large, block-wise initialization of those parameters~@grant2019initialization or exploring particular ansatz structures~@sharma2020trainability.


The mentioned works require a circuit design that is not necessarily hardware efficient. Other ideas focus on the classical parts of the VQA instead of the quantum circuit designs. One example is using local instead of global cost functions for the optimization. It has been shown~@cerezo2020cost that barren plateaus also emerge in shallow depth circuits, and that the use of local cost functions reduces the exponential decay tendency to a polynomial one. The optimization strategy may also reduce the effect of the vanishing gradients, for instance by training the circuit layer by layer~@skolik2020layerwise @lyu2020accelerated or by measuring low depth gradients~@harrow2019low. Certain variational quantum algorithms for quantum simulation can be free of barren plateaus when at every training step the state to be learned is close to the state of the circuit~@haug2021optimal.


Barren plateaus are a roadblock in the trainability and hence any PQC ansatz which suffers from this phenomena will fail to properly train the parameters in its search for the near-optimal (or optimal) performance. As shown in Ref.~@arrasmith2020effect, even the family of gradient-free approaches which perform local search, therefore mimicking gradient-based optimization, seem to face similar challenges. However, one can circumvent this issue by using hybrid quantum states of the form of equation @eq:IQAE_Ansatz or hybrid density matrices as introduced in Ref.~@haug2020generalized. The idea is to write the overall ansatz as a classical combination of quantum states i.e, $| phi.alt (bold(alpha) ( t ) , bold(theta)) chevron.r = sum_(i = 0)^(m - 1) alpha_i ( t ) | psi_i (bold(theta)_i) chevron.r .$ Tuning the $bold(theta)_i$ can often lead to barren plateaus. One can avoid such issues by fixing $bold(theta)_i$ by harnessing the structure of the problem to find the basis states of the ansatz, i.e, ${| psi_i (bold(theta)_i) chevron.r}$ (see @sec:IQAE for more details). Interestingly, quantum convolutional neural networks also do not exhibit barren plateaus~@pesah2020absence.


== Expressibility of variational ansätze
<sec:expressibility>


A cornerstone in the success of VQA is choosing the proper ansatz for the problem. In addition to trainability, i.e. how well the ansatz can be optimized, another major quality is expressibility. This concerns whether a given PQC is able to generate a rich class of quantum states. The number of PQC layers, parameters or entangling gates required to achieve a given accuracy is also linked to the expressibility of the circuit.


==== Expressibility.
<expressibility.>
Sampling states from a PQC $| psi_(bold(theta)) chevron.r$ for randomly chosen $bold(theta)$ generates a distribution of states. Expressibility is defined as the deviation of this distribution from the Haar measure, which samples uniformly from the full Hilbert space


$ A^(( t )) = | | integral_(upright("Haar")) ( | psi chevron.r chevron.l psi | )^(⊗ t) upright("d") psi - integral_(bold(theta)) ( | psi_(bold(theta)) chevron.r ( chevron.l psi_(bold(theta)) | )^(⊗ t) upright("d") psi_(bold(theta)) | |_(upright("HS"))^2 thin , $


where $integral_(upright("Haar")) upright("d") psi$ denotes the integration over a state $| psi chevron.r$ distributed according to the Haar measure and $| | A | |_(upright("HS"))^2 = upright("Tr") ( A^dagger A )$ the Hilbert-Schmidt norm. An ansatz circuit $U$ with small $A_U^(( t ))$ is more expressive, with $A_U^(( t )) = 0$ corresponding to being maximally expressive, as it generates quantum states with a distribution closer to the Haar measure. The PQC samples uniformly from the full Hilbert space and thus is able to approximate any possible state. This is especially important in the case where one wants to train the PQC to represent a particular quantum state while having little prior information about the state. A highly expressive PQC is more likely to be able to represent the target state.


==== Entangling capability.
<entangling-capability.>
This measure denotes the power of a PQC to create entangled states and can be used as another quantifier of the expressiveness of an ansatz. In @sim2019expressibility the Meyer-Wallach $Q$ measure~@meyer2002global has been proposed to estimate the number and types of entangled states a particular PQC can generate. One defines a linear mapping $iota_j ( e )$ that acts on the computational basis $iota_j ( b ) | b_1 dots.h.c b_n chevron.r = delta_(b b_j) | b_1 dots.h.c tilde(b)_j dots.h.c b_n chevron.r$, where $b_j in ( 0 , 1 )$ and $tilde(b)_j$ denotes absence of the $j$-th qubit. The entanglement measure $Q$ is then defined as


$ Q ( | psi chevron.r ) equiv 4 / n sum_(j = 1)^n D ( iota_j ( 0 ) | psi chevron.r , iota_j ( 1 ) | psi chevron.r ) , $<eq:meyer_wallach1>


where $D$ is the generalized distance defined by the coefficients of two states $| u chevron.r = sum u_i | e_i chevron.r$ and $| v chevron.r = sum v_i | e_i chevron.r$,


$ D ( | u chevron.r , | v chevron.r ) = 1 / 2 sum_(i , j) | u_i v_j - u_j v_i |^2 . $<eq:meyer_wallach_distance>


It can be rewritten as the average of the purity of each qubit~@brennen2003observable


$ Q ( | psi chevron.r ) = 2 ( 1 - 1 / n sum_(k = 1)^n upright("Tr") \[ rho_k^2 \] ) thin , $<eq:meyer_wallach2>


where $rho_k$ is the density matrix of the $k$-th qubit. Thus, $Q ( | psi chevron.r )$ is an entangling monotone~@scott2004multipartite and can be interpreted as the average of the entanglement of each qubit with the rest of the system.


Only if the state is a product state we find $Q = 0$, whereas $Q = 1$ is reached for certain entangled states such as the GHZ state. The entangling capability of a PQC is then defined as the average $Q$ of states randomly sampled from the circuit.


$ upright("Ent") = frac(1, | S |) sum_(bold(theta)_i in S) Q ( | psi_(bold(theta)_i) chevron.r ) , $<eq:entangling_capability_score>


where $S = { bold(theta)_i }_i$ is the set of sampled circuit parameters.


==== Parameter dimension
<parameter-dimension>
The parameter dimension $D_(upright("C"))$ is the number of independent parameters of the quantum state that is generated by the PQC~@haug2021capacity. From this measure, one can calculate the redundancy of a PQC, i.e. the fraction of parameters that can be removed without loss of expressive power. A further local measure of expressibility is the effective quantum dimension $G_(upright("C")) ( bold(theta) )$, which can be used to calculate the expressive power of initialization strategies for the PQC. Under a small variation of the PQC parameter $bold(theta)$, it measures how many independent directions in the parameter space exist for the quantum state. Both measures can be calculated as the number of non-zero eigenvalues of the Fubini-Study metric tensor defined in @eq:Fubiny_Study. \


In @sim2019expressibility @nakaji2020expressibility @haug2021capacity, a wide class of circuits have been investigated with the aforementioned expressibility measures. It has been found that certain types of ansätze are more expressive, e.g. layered PQCs consisting of CNOT or $sqrt(upright("iSWAP"))$ gates are more expressive than CZ. There is a trade-off between an ansatz being expressive and trainable. Making an ansatz more expressive most likely will result in reducing the gradient of the objective function. In @holmes2021connecting, the authors suggest several strategies for reducing expressibility and improving trainability, including correlating parameters or restricting rotation angles of parameterized gates. Interpolating the PQC parameters between fixed and random angles has been proposed as another method~@haug2021capacity. Expressibility of PQCs have been further explored using classical Fisher information~@abbas2020power and memory capacity~@wright2020capacity.


It has been shown that alternating layered ansatz (see @sec:HardwareAnsatz) is both relatively expressive as well as does not exhibit barren plateaus in certain regimes~@nakaji2020expressibility. In VQE algorithms, there is a trade-off between the number of layers in this ansatz and the correlation length of critical Hamiltonians. However, in the critical phase, the number of layers must exceed a certain threshold dictated by the system size to show an exponential improvement. The circuit depth unravels an effective correlation length that can be used as an estimation of the number of free parameters in the ansatz @bravoPrieto2020scalingof.


== Reachability
<sec:reachability>


Reachability discusses the question whether a given PQC $| Psi ( bold(theta) ) chevron.r$ with parameters $bold(theta)$ is capable of representing a quantum state that minimizes some objective function.


This can be quantified by the reachability deficit over finding the minimum of an objective function $hat(O)$~@akshay2020reachability as


$ f_(upright("R")) = upright("min")_(psi in cal(H)) chevron.l psi | O | psi chevron.r - upright("min")_(bold(theta)) chevron.l Psi ( bold(theta) ) | O | Psi ( bold(theta) ) chevron.r , $


where the first term on the right side is the minimum over all states $| psi chevron.r$ of the Hilbert space, whereas the second term is the minimum over all states that can be represented by the PQC. The reachability deficit is equal or greater than zero $f_(upright("R")) gt.eq 0$, with $f_(upright("R")) = 0$ when the PQC can generate a state $| Psi ( bold(theta)^(*) ) chevron.r$, where $bold(theta)^(*)$ are the parameters that minimizes the objective function.


Reachability has been studied in-depth for QAOA. Although QAOA has been shown to exhibit quantum computational universality @lloyd2018quantum @morales2019on, which implies that any unitary operator is reachable under the QAOA ansatz, this statement does not hold true for finite fixed depths $p$. In fact, it was shown that QAOA exhibits reachability deficits for the MAX-2-SAT and MAX-3-SAT problems, where the optimal value of the objective function cannot be found using a fixed circuit depth $p$ beyond a critical clause density (defined as the ratio between the number of clauses and the number of variables in the problem)~@akshay2020reachability. In other words, for problems with a certain clause density, there is a critical depth $p^(*)$ for which the optimal solution can only be found (up to a threshold) if $p gt.eq p^(*)$. As $p^(*)$ grows with the clause density, this limits the performance of QAOA for problem instances with high clause density.


Similar reachability deficits have also been found in the variational Grover search problem~@akshay2020reachability. Moreover, by re-analyzing the experimental data from Google's Sycamore quantum processor on the application of QAOA to various graph optimization problems @harrigan2021quantum, authors from @akshay2020reachability2 also discovered reachability deficits in this case, where the graph density (defined as the ratio between the number of graph edges to the number of graph nodes) replaces the clause density as the order parameter.


Note that the reachability deficits are distinct from the barren plateau problem, where the gradients of the objective function concentrate to zero for many choices of initial variational parameters, thus slowing down the optimization process. On the other hand, the reachability deficit for $p < p^(*)$ is independent of the initial parameters.


== Theoretical guarantees of the QAOA algorithm
<sec:theoretical_garantees>


The QAOA has several key analytical results which have contributed to its considerable interest in recent years. The quantum advantage of QAOA algorithm has been studied in @farhi2016quantum, where they showed that the efficient sampling of the output distribution of QAOA, even for the lowest depth case of $p = 1$, implies the collapse of the polynomial hierarchy (see @ch1:subsec:non-complexity ). Following the conjecture from complexity theory that the polynomial hierarchy does not collapse, this result propels QAOA as a possible candidate for establishing some quantum advantage. In particular, it has been shown that for $p = 1$, 420 qubits would suffice to demonstrate quantum advantage~@dalzell2020how.


The power of QAOA compared to classical algorithms is an ongoing topic of research. For specific instances of the Max-Cut problem, QAOA for $p = 1$ was shown to perform equally well or worse than classical algorithms~@hastings2019classical @bravyi2019obstacles. For more discussion on QAOA for Max-Cut, refer to ~@sec:MaxCut. For QAOA of depth $p$, the measurement outcomes of a qubit depend on the $p$-neighbourhood of that qubit. Thus if $p$ is too small, it does not 'see' the whole graph @farhi2020seetypical @farhi2020seeworst. For large $p$, the QAOA algorithms can 'see' the whole graph with no known indications regarding the performance limitations.


For the case where the problem Hamiltonian $H_P$ takes the form


$ H_P = sum_i omega_A hat(sigma)_z^(2 i) + omega_B hat(sigma)_z^(2 i + 1) + gamma_(A B) hat(sigma)_z^(2 i) hat(sigma)_z^(2 i + 1) + gamma_(B A) hat(sigma)_z^(2 i + 1) hat(sigma)_z^(2 i + 2) , $


where $omega_(A ( B ))$ are the coefficients for the even (odd) sites and $gamma_(A B ( B A ))$ are the interaction strength between first (second) neighbour spins. Taking $H_M$ as defined in @eq:mxing_operator for a 1D lattice, Ref. @lloyd2018quantum showed that QAOA can be used to implement universal quantum computation. This result was proven and generalized in a later work @morales2019on to include a larger class of problem and mixing Hamiltonians that can provide computational universality for QAOA.


By connecting VQA with optimal control theory, Pontryagin's minimum principle of optimal control is used to show that the bang-bang protocol (in which the evolution switches abruptly between two Hamiltonians) is optimal for a fixed total time $T$ @yang2017optimizing. Since QAOA can be regarded as a bang-bang ansatz by switching between unitary evolution under $H_P$ and $H_M$ respectively, this suggests the optimality of QAOA as a VQA. However, recent works have challenged this claim. By generalizing the argument in Ref. @yang2017optimizing, it has been shown that the optimal protocol actually possesses the 'bang-anneal-bang' structure @brady2020optimal. Such protocols begin and end with a bang, with regions of smoothly varying control function (akin to quantum annealing) in between. It was also shown that when the total time $T$ is large, bang-bang QAOA suffers from the proliferation of local minima in the control parameters, rendering it difficult to find optimal (or near-optimal) QAOA parameters.

= PROGRAMMING AND MAXIMIZING NISQ UTILITY
<ch:lemon>


Current NISQ devices have a limited number of qubits ($tilde 50 - 100$) available. In addition, due to their noisy nature and short coherence time, one can only perform a restricted number of gate operations. In order to make maximal use of the currently available quantum resources, there are two approaches from the operational point-of-view: the bottom-up and the top-down. The bottom-up approach refers to the scenario where one has full control over the design of any quantum computing platform to keep pushing the performance quality such as gate fidelity and coherence time for a given hardware design constraints. The top-down approach means implies that one does not get involved in hardware design and simply makes use of what has already been made or fabricated in the experimental labs. In this section, we focus on the latter approach, i.e. extending or maximizing the utility of current and near-term quantum devices from an algorithmical perspective. Finally, we also present a summary of software tools to control, program and maximize the utility of NISQ algorithms.


== Quantum error mitigation (QEM)
<quantum-error-mitigation-qem>


Sensitivity to errors and noise are the two most prominent roadblocks towards scalable universal quantum computers. Fault-tolerant quantum computing can be attained by encoding non-Abelian anyons in topological materials~@kitaev2003fault or applying quantum error correction codes~@raussendorf2007fault. While the former is still in its infancy, the latter mandates physical resources exceeding our current experimental capabilities. In the NISQ era of running hybrid quantum/classical algorithms, it is desirable to use all the restricted and available qubits as logical qubits without applying QEC techniques. As we discuss throughout this review article, the hybrid quantum/classical algorithms rely on computing the expectation value of some physical observables using quantum processors. Quantum error mitigation (QEM) techniques discussed in this subsection need no extra qubit and can suppress errors in finding expectation values with simple classical post-processing and different runs of quantum circuits. To be precise, with QEM, we are not interested to recover the ideal quantum output state $hat(rho)^(( 0 ))$, but to estimate the ideal observables $hat(A)$ expectation value: $E \[ mu^(( 0 )) \] = chevron.l hat(A)^(( 0 )) | = chevron.r upright("Tr") ( hat(rho)^(( 0 )) hat(A) )$ @li2017efficient @temme2017error @kandala2019error, sometimes surpassing the break-even point, where the effective gates are superior to their physical building blocks, at an affordable cost with respect to near-term quantum hardware @zhang2020error. Here, $mu$ is the outcome of a measurement and we use superscript $( 0 )$ to denote an ideal noise-free realization of a state, operation or observable quantity. Recently, it was also shown how to achieve stochastic error mitigation for a continuous time evolution @sun2020mitigating. For a comprehensive treatment on quantum error mitigation, refer to~@endo2020hybrid.


=== Zero-noise extrapolation
<ch4:subsubsec:ZNE>
@li2017efficient, and @temme2017error independently and concurrently proposed the Richardson extrapolation QEM, namely zero-noise extrapolation (ZNE), where a quantum program is to operate at various effective noise levels of a quantum processor. It is then extrapolated to an estimated value at a noiseless level.


Formally, a quantum circuit/system in the presence of noise can be modelled as an open quantum system @breuer2002theory using the Gorini-Kossakowski-Sudarshan-Lindblad equation or in short the Lindblad master equation (setting $ℏ = 1$):


$ frac(d, d t) hat(rho) ( t ) = - i \[hat(K) (t) , hat(rho) (t)\] + hat(hat(cal(L))) \[hat(rho) (t)\] , $<eq:ch4:Lindblad_master_eq>


where $hat(K) ( t )$ acts as time-dependent driving Hamiltonian, and $hat(hat(cal(L))) \[ . \] = sum_k Gamma_k ( hat(cal(O))_k \[ . \] hat(cal(O))_k^dagger - 1 / 2 ( hat(cal(O))_k hat(cal(O))_k^dagger , \[ . \] ) )$ is a superoperator. The above equation in general describes Markovian dynamics for $Gamma_k gt.eq 0$. Whenever loss rate $Gamma_k$ become negative @fleming2012non @rivas2010entanglement, the above equation would also describe non-Markovian dynamics @tan2010non @bastidas2018floquet @kyaw2020dynamical. To ensure the complete positivity, we require $integral_0^t Gamma ( t' ) d t' > 0$, $forall t$. In general, $Gamma_k$ are fixed by the nature of the noise experienced by a quantum system. Mathematically, one can parametrize $Gamma_k$ with a dimensionless scalar $lambda$, i.e., $Gamma_k arrow.r lambda Gamma_k$. When $lambda = 0$, there is no noise and the second term (loss term) in @eq:ch4:Lindblad_master_eq is zero, resulting in pure unitary dynamics. When $lambda = 1$, the actual quantum device loss rate is matched. In summary, ZNE involves two steps.

+ Noise-scaling: we make a number of measurements $E \[ mu^(( lambda_j )) \]$ for $lambda gt.eq 1 .$

+ Extrapolation: we estimate $E \[ mu^(( 0 )) \]$ from the previous step.


==== Noise-scaling
<noise-scaling>
can be accomplished in three ways. Firstly, in Ref. @temme2017error it was proposed to use a #emph[time-scaling approach] by taking $lambda > 1$, which means that the time-dependent driving Hamiltonian $hat(K) ( t )$ is now rescaled by $1 / lambda hat(K) ( t / lambda )$. This approach is only possible if the user has full control over back-end quantum processor. Control pulses for each quantum gate have to be recalibrated and be applied for longer duration. Secondly, one can apply a technique called #emph[circuit folding] @giurgica2020digital. Suppose that a quantum circuit is composed of $d$ unitary layers such that $U = L_d dots.h.c L_2 L_1$ where $d$ refers to the circuit depth and each $L_j$ either represents a single layer of gate operations or just a single quantum gate. The circuit folding is then achieved by


$ U arrow.r U ( U^dagger U )^n , $


where $n$ is some positive integer. Since $U^dagger U$ is an identity, this action has no effect on an ideal circuit. However, in noisy circuit, $U$ is imperfect and the above $1 + 2 n$ circuit operations would increase the noise level. Thirdly, instead of entire circuit folding, one can also use #emph[gate folding] technique #cite(<giurgica2020digital>):


$ L_j arrow.r L_j ( L_j^dagger L_j )^n . $


The second and third techniques do not require users to have full control of quantum computer back-end and thus we expect to be of greater use in software level control of quantum circuits.


==== Extrapolation step
<extrapolation-step>
of the ZNE method can be considered as a regression problem if we choose to consider a generic model for calculating the expectation value $E_(upright("model")) \[ mu^(( lambda Upsilon )) \]$, where the meaning of #emph[model] would become clear shortly and $Upsilon$ corresponds to the model parameters. We note that the expectation value $E$ is a real number that can only be obtained in the infinite measurement limit. With limited number of measurement samples $N$, statistical estimation is $hat(E) \[ mu^(( lambda )) \] = E \[ mu^(( lambda )) \] + hat(delta)$~#footnote[The hat notation used is in accordance with statistics notation and should not be confused with a quantum operator.], where $hat(delta)$ is a random variable with zero mean and variance $sigma^2 = bb(E) ( hat(delta)^2 ) = sigma_0^2 / N$. Here, $sigma_0^2$ is the single-shot variance. Given a set of $m$ scaling parameters $lambda = ( lambda_1 , lambda_2 , dots.h.c , lambda_m )$ with $lambda_j gt.eq 1$, and the corresponding measurement outcomes $mu = ( mu_1 , mu_2 , dots.h.c , mu_m )$, the ZNE is nothing but to build a good estimator $hat(E) \[ mu^(( 0 )) \]$ for $E \[ mu^(( 0 )) \]$ such that its bias $bb(E) ( hat(E) \[ mu^(( 0 )) \] - E \[ mu^(( 0 )) \] )$, and its variance $bb(E) ( hat(E) \[ mu^(( 0 )) \]^2 ) - bb(E) ( hat(E) \[ mu^(( 0 )) \] )^2$ are both reasonably small. Onwards, let us adopt a simplified notation of $E \[ mu^(( lambda )) \] = E ( lambda )$. Now let us mention briefly the statistical models. The expectation value $E ( lambda )$ cannot be of any arbitrary function, which would make ZNE impossible to extrapolate back to $E ( 0 )$. Depending on some underlying noise model assumption, one can apply various statistical models.


==== The polynomial extrapolation
<the-polynomial-extrapolation>
is based on the polynomial model of degree $d$ such that


$ E_(upright("poly"))^(( d )) ( lambda ) = c_0 + c_1 lambda + dots.h.c + c_d lambda^d , $


where $c_j$ are $d + 1$ unknown real parameters. This extrapolation is justified in weak noise limit and we need the number of data points $m$ to be equal or larger than $d + 1$. Consequently, we can obtain two other variants: #emph[the linear extrapolation] $( d = 1 )$ and #emph[the Richardson extrapolation] $( d = m - 1 )$ @temme2017error. By construction, the error with respect to the true expectation value is $O ( m )$ when we have large sample size $N arrow.r oo$. By using the interpolating #emph[Lagrange polynomial], the estimator is explicitly given by:


$ hat(E)_(upright("Rich")) ( 0 ) = hat(c)_0 = sum_(k = 1)^m mu_k product_(i eq.not k) frac(lambda_i, lambda_i - lambda_k) , $


with the assumption that all $lambda_j$ are different. One important observation is that the Richardson model based ZNE is dictated by a statistical uncertainty which is exponentially scaling with the number of data points. There are also other statistical models such as #emph[poly-exponential extrapolation] @giurgica2020digital and #emph[exponential extrapolation]~@endo2018practical. Various exponential extrapolation methods have been proposed and investigated in~@cai2020multi and applied to depolarizing noise in~@vovrosh2021efficient. In fact, @cai2020multi shows that the ZNE, quasi-probability and stabiliser-based approach can be combined by exploiting novel aspects of the individual technique.


The ZNE scheme suffers from a few limitations. The scheme works by extrapolation, and hence it is challenging to obtain result guarantees in general. The number of measurement shots required to obtain the mitigated expectation value can be relatively high compared to the unmitigated case as seen above. More importantly, the fundamental drawback of both ZNE and probabilistic error cancellation (PEC) @temme2017error, or quasi-probability method (which is discussed next) is that one needs to know the precise physical noise model in advance, which in itself is a difficult problem. Experimentalists in the lab will have imperfect knowledge about the real noise, which will typically differ from the canonical ones. We will also discuss a more practical approach based on gate set tomography proposed in Ref. @endo2018practical, which does not require explicit knowledge of the noise model and mitigates any localized Markovian errors, so that the error in the final output is only due to unbiased statistical fluctuation.


// [figvision] imgs/QEM_quasiprobability_decomposition.png
// Panel (a) is a three-wire quantum circuit labelled |ρ⟩⟩₁, |ρ⟩⟩₂ and |ρ⟩⟩₃ on the left. Wire 1 carries I, Xπ, a
// two-qubit XX block outlined in red spanning wires 1–2, Zπ and a measurement dial. Wire 2 carries Xπ, Xπ/2, the
// XX block, Xπ/2 inside a red outline and a dial. Wire 3 carries Yπ inside a red outline and a dial. A second
// red-outlined XX block sits between wires 2 and 3. Red highlighting marks the quasi-probabilistic gates; every
// wire ends in a measurement symbol. Below, red text reads "Quasi-probability decomposition". Panel (b) is a
// probability plot with vertical axis "Probability" and horizontal axis "Expectation value"; neither axis has
// numeric tick labels. Two smooth bell curves are drawn: a green "no error mitigation" curve, taller and
// narrower, peaking at lower expectation value, and a blue "with error mitigation" curve, shorter and broader,
// shifted toward higher expectation value. Beneath the axis, red text "ideal value" with an upward arrow marks
// the ideal expectation value; the blue curve is centered closer to it. Message: error mitigation recenters the
// observable distribution around the ideal value. Panel (c) shows three large red-outlined pale boxes at the
// bottom, each one Monte Carlo circuit sample with measurement dials on the right. The left box lists rows |ρ⟩⟩₃
// followed by I, Xπ, Yπ/2 and a vertical ellipsis. The middle box lists two-qubit column pairs XX–I, XX–I, XX–Xπ
// and an ellipsis. The right box lists Xπ/2–I, Xπ/2–Xπ, Xπ/2–Yπ and an ellipsis. Each box is one sampled circuit
// instance from the quasi-probability decomposition; averaging measurement outcomes over such samples estimates
// the mitigated expectation value.
#figure(scope: "parent", image("imgs/QEM_quasiprobability_decomposition.png", width: 100%),
  caption: [
    Quantum computing of the expected value of an observable using gate set tomography-based PEC. Quasiprobability decomposition of initial state preparation, examplary single- and two-qubit processes are computed. Implementing the resulting decomposition is done using the Monte Carlo approach. With QEM, the probability distribution of expected value of the physical observable is now centered around an ideal value with larger variance as compared to the one without QEM. Inspired by @zhang2020error.
  ]
)
<fig:ch4:QEM_quasiprobability_decomposition>



=== Probabilistic error cancellation
<ch4:subsubsec:PEC>


Let us familiarize ourselves with the notations used in quantum tomography @greenbaum2015introduction @merkel2013self, which we adopt here. A quantum state is represented by a density matrix $hat(rho)$, and a physical observable is denoted by a Hermitian $hat(A)$ operator. An operation is a map on the states space such that one can use the Kraus representation to denote it as: $hat(hat(cal(L))) \[ hat(rho) \] = sum_j hat(K)_j hat(rho) hat(K)_j^dagger .$ We note that this equivalence with @eq:ch4:Lindblad_master_eq is only valid when we have Markovian dynamics. Here, $hat(K)_j$ are Kraus operators. In terms of the Pauli transfer matrix representation, $hat(rho)$ in @eq:ch4:Lindblad_master_eq can be written as a column vector @navarrete2015open, denoted as $| rho chevron.r.closed$. Similarly, the Lindblad superoperator $hat(hat(cal(L)))$ can be recast as a square matrix, i.e., using the Pauli transfer matrix representation, since it is a linear map. For simplicity and without loss of generality, we may absorb the unitary dynamics (the first term in @eq:ch4:Lindblad_master_eq) into $hat(hat(cal(L)))$ onwards. A physical observable $hat(A)$ is now written as a row vector $chevron.l.closed A |$. Consequently, the expectation value is $chevron.l hat(A) | = chevron.r upright("Tr") \[ hat(A) hat(rho) \] = chevron.l.closed A | rho chevron.r.closed$. Likewise, the expectation of $hat(A)$ after the state $hat(rho)$ passing through a series of linear maps is read as: $upright("Tr") \[ hat(A) hat(hat(cal(L)))_N compose dots.h.c compose hat(hat(cal(L)))_1 ( hat(rho) ) \] = chevron.l.closed A | cal(L)_N dots.h.c cal(L)_1 | rho chevron.r.closed$.


The central theme of probabilistic error cancellation (PEC) or quasiprobability decomposition introduced by the IBM team in Ref. @temme2017error is that one can estimate the expectation value of an observable by sampling from a set of erroneous circuits, labelled by $cal(L)_(upright("tot"))^(( l ))$ for $l = 1 , 2 , dots.h.c ,$ such that


$ chevron.l hat(A)^(( 0 )) | = chevron.r sum_l q_l chevron.l.closed A^(( l )) | cal(L)_(upright("tot"))^(( l )) | rho^(( l )) chevron.r.closed . $<eq:ch4:PEC_expect>


The expectation of an observable is going to be far-off (without QEM) from the ideal value due to the presence of noise#footnote[The superscript $( 0 )$ to denote the ideal noise-free realisation of a state, operation or observable quantity.]. Given specific error models (assuming experimentalist has full and correct knowledge about them), the real numbers $q_l$, which represent quasiprobabilities, can be efficiently derived. Here, each $cal(L)_(upright("tot"))^(( l ))$ represents the total sequence of noisy gates in the $l$th circuit. Monte Carlo sampling could be used to compute $chevron.l hat(A)^(( 0 )) |$by randomly choosing the $l$th circuit with the probability $p_l = | q_l | / C$, where $C = sum_l | q_l |$. Lastly, the computed result is given by the expected value of effective measurement outcomes $⟨A^((0))⟩ = upright("CE")[mu_(upright("eff"))]$, where the effective outcome is $mu_(upright("eff")) = upright("sgn") ( q_l ) mu^(( l ))$ if the $l$th circuit is chosen and $mu^(( l ))$ is the outcome from the $l$th circuit.


As a consequence, the mean value of the PEC outcome centers around the ideal one with larger variance due to $C$ (see @fig:ch4:QEM_quasiprobability_decomposition right corner).


The above PEC method relies on the correct knowledge of error model $cal(L)_(upright("tot"))^(( l ))$ as is apparent from @eq:ch4:PEC_expect. To enable practical implementations, @endo2018practical proposes to combine linearly independent basis set operations and gate set tomography to fully remove impact of localized Markovian errors by systematically measuring the effect of errors to design efficient QEM circuits. The set of operations including measurement and single-qubit Clifford gates is universal in computing expected values of observables. For the single-qubit case, any operation $cal(L)$ which is a $4 times 4$ real matrix in the Pauli transfer matrix representation, can be expressed as a linear combination of 16 basic operations, i.e., $cal(L) = sum_(i = 1)^16 q_i cal(B)_i^(( 0 ))$, which are composed of $( pi , H , S , R_x , R_y )$ gates @endo2018practical. Similarly, the same decomposition can be applied to the two-qubit case. See @fig:ch4:QEM_quasiprobability_decomposition for example decompositions.


A way to systematically measure errors is through gate set tomography (GST), with which one can even mitigate state preparation and measurement errors. In short, the purpose of GST is to measure noisy individual quantum circuit performance a priori. For a single-qubit gate, one prepares initial states $| 0 chevron.r , | 1 chevron.r , | +_x chevron.r$, and $| +_y chevron.r$, where $| +_x chevron.r$ and $| +_y chevron.r$ are the eigenstates of Pauli operators $hat(sigma)_x$ and $hat(sigma)_y$ with $+ 1$ eigenvalue, respectively. For noisy devices, these four states are denoted as $overline(rho)_1$, $overline(rho)_2$, $overline(rho)_3$ and $overline(rho)_4$, accordingly. We also use $overline(cal(L))$ (superoperator) to denote a noisy/imperfect gate to be measured. Since what we care about are expectation value of physical observables, for single-qubit case, we have observables $hat(I) , hat(sigma)_x , hat(sigma)_y , hat(sigma)_z$, denoted as $overline(A)_1, overline(A)_2, overline(A)_3, overline(A)_4$. The mean value of observables, the $4 times 4$ matrix $tilde(A)$, is nothing but $tilde(A)_(j,k)=upright("Tr")[overline(A)_j overline(cal(L))overline(rho)_k]$. Similarly, we can also construct the $4 times 4$ matrix $g$ without applying any gate to the initial states as $g_(j,k)=upright("Tr")[overline(A)_j overline(rho)_k]$. This is repeated for each qubit and each single-qubit gate. Statistical estimation of the initial states $overline(rho)_k$ and the observables $overline(A)_j$ are then given by


$ | hat(rho)_k chevron.r.closed & = T_(bullet , k) ,\
chevron.l.closed hat(A)_j | & = ( g T^(- 1) )_(j , bullet) , $


where we note that the hat symbol represents the statistical estimate and $T_(bullet , k) ( T_(j , bullet) )$ denotes the $k$th column ($j$th row) of the matrix $T$, where $T$ is an invertible $4 times 4$ matrix with the following relationship $hat(cal(L)) = T g^(-1) tilde(cal(L)) T^(-1)$. The same procedure applies for the two-qubit case with the only difference being that there are total of $16$ initial states: $overline(rho)_(k_1)⊗ overline(rho)_(k_2)$ and $16$ observables: $overline(A)_(j_1)⊗ overline(A)_(j_2)$ to be measured. Similarly, we have $g = g_1 ⊗ g_2$ and $T = T_1 ⊗ T_2$. We have to implement two-qubit gate GST for each qubit pair involved in a quantum program run.


Quasiprobability decomposition is then computed based on GST results above. From GST, we have estimation of initial states $| hat(rho)_k chevron.r.closed$, observables to be measured $chevron.l.closed hat(A)_j |$, and gates $hat(cal(L))$. Let's denote $cal(L)^(( 0 ))$ as the Pauli transfer matrix of the ideal gate with no error. The main idea of decomposition comes from a very simple idea that a noisy gate operation comes from an ideal operation followed by a noise operation, i.e., $cal(L) = cal(N) cal(L)^(( 0 ))$. Hence, the inverse of the noise is given by $cal(N)^(- 1) = cal(L)^(( 0 )) hat(cal(L))^(- 1) = sum_i q_(cal(L) , i) hat(cal(B))_i .$ And, by applying the inverse of the noise after the operation, we can obtain the operation without error: $cal(L)^(( 0 )) = cal(N)^(- 1) cal(L)$. Notice that the matrices in the above equation are obtained from the first GST step. The remaining task is to determine quasiprobabilities $q_(cal(L) , i)$ for each qubit and gate involved by solving the above equation. We note that instead of quasiprobabilistic decomposition of quantum gates, one could in principle use randomized compiling technique proposed in Ref. @wallman2016noise.


GST-based PEC experiments have recently been done in trapped-ion systems~@zhang2020error and superconducting circuits~@song2019quantum. Lastly, a similar strategy was recently applied to mitigating errors in measurement readout @kwon2020hybrid.


=== Other QEM strategies
<sec:other_QEM>
We have seen that the quantum error mitigation techniques discussed so far do not require any ancilla or extra qubits with the caveat that one needs to perform more measurements. At the same time, one is only interested in information about the expectation value. Along this line of thought, there exist several proposals, which we will outline below. However, some of the methods might require ancilla qubits.


==== Subspace expansion method
<subspace-expansion-method>
@mcclean2017hybrid @colless2018computation @mcardle2019error @sagastizabal2019experimental @mcclean2020decoding @barron2020preserving are designed to mitigate errors in the VQE routine, where we often tend to find an approximate ground state $| psi_a chevron.r$ of a system Hamiltonian $H$. However, such state may differ from the true ground state $| psi_g chevron.r$ due to noisy processes. In general, we do not know which error occurred to the state. The subspace expansion method works by resolving the action of $H$ on the linear combination of quantum states ansatz~@eq:IQAE_Ansatz. The subspace is spanned by a set of operators $hat(cal(O))_i$, i.e., ${ | hat(cal(O))_i psi_a chevron.r }$. Now, one proceeds to evaluate $H_(i j) = chevron.l psi_a | hat(cal(O))_i H hat(cal(O))_j | psi_a chevron.r$, and $S_(i j) = chevron.l psi_a | hat(cal(O))_i hat(cal(O))_j | psi_a chevron.r$. The latter is needed since the subspace states are in general not orthogonal to each other. By solving the generalized eigenvalue problem $H C = S C E$, with eigenvectors $C$ and diagonal matrix of eigenvalues $E$, we can obtain the Hamiltonian spectra including the excited states (see @sec:var_excited).


This method requires an appropriate choice of subspace operators to mitigate errors due to external noise. In general, without knowing the noise models of quantum device, it would require an exponential number of expansion operators to obtain the optimal groundstate.


==== Stabilizer based approach
<stabilizer-based-approach>
@bonet2018low @mcardle2019error @sagastizabal2019experimental @cai2021quantum relies on the information associated with conserved quantities such as spin and particle number conserving ansatz. If any change in such quantities is detected, one can pinpoint an error in the circuit, which is akin to stabilizer measurement in quantum error correction schemes. We can implement the stabilizer measurements by adding ancilla qubits to the qubit registers or taking additional measurements and post-processing.


==== Individual error reduction
<individual-error-reduction>
method was proposed in Ref. @otten2019accounting. As we have seen earlier, Markovian noise can be modelled using the Lindblad master equation, @eq:ch4:Lindblad_master_eq, where we have $frac(d hat(rho), d t) = hat(hat(cal(L))) ( hat(rho) ) = sum_i cal(L)_i ( hat(rho) )$, where each $cal(L)_i$ denotes a noise channel present. Here, we have absorbed the unitary component into $hat(hat(cal(L)))$. It was shown that


$ tilde(rho)(T) &= hat(rho)(T) - sum_(j=1)^m frac(1, g_j) (hat(rho)(T) - hat(rho)_j (T)) , \
  &= hat(rho)^((0))(T) + cal(O)(tau^2) . $<eq:ch4:individual_error>


Notational explanations are as follows. $hat(rho) ( T )$ is the density matrix after applying quantum gates with the presence of all associated noise channels at the final evolution time $T$. In contrast, $hat(rho)_j ( T )$ is the state under the influence of all the noise channels but one less $cal(L)_j$ according to the ratio $g_j$. Notice that if $g_j = 1$, we have fully removal of the entire channel $cal(L)_j$. $hat(rho)^(( 0 )) ( T )$ is the ideal output state without any error, while $tau$ is the evolution time for each noise process after the gate application. We note that the first-order error $cal(O) ( tau )$ is removed. As usual, what we want to obtain is $chevron.l hat(A) | = chevron.r upright("Tr") \[ hat(rho)^(( 0 )) ( T ) hat(A) \]$ for a physical observable $hat(A)$. We can arrive at it by using @eq:ch4:individual_error. Though its result is neat and beautiful, this method assumes a perfect removal of individual noise channel. Hence, it is relatively unrealistic on current quantum hardware as compared to other strategies.


==== Dynamic error suppression/robust control techniques
<dynamic-error-suppressionrobust-control-techniques>
concern suppression of experimental gate errors at the pulse control level, which can be passive as well as active one. Pulse shaping technique is a strategy for passive cancellation of system-bath interaction. Traditionally, this method stands on the shoulder of a mean to obtain high-fidelity quantum gate in nonlinear qubits such as transmons, commonly known as derivative removal of adiabatic gate (DRAG) scheme @motzoi2009simple @gambetta2011analytic @de2015fast. On the other hand, #emph[dynamical decoupling] (DD) @viola1999dynamical @santos2005dynamical @viola2005random is a very well-known and widely used quantum control technique in the literature, which is designed to suppress decoherence via fancy pulses to the system so that it cancels the system-bath interaction to a given order in time-dependent perturbation theory @lidar2014review in an active manner. Recently, DD experiments were performed on the 16-qubit IBMQX5, 5-qubit IBMQX4, and the 19-qubit Rigetti Acorn chips @pokharel2018demonstration, where the gain in substantial gate fidelity relative to unprotected, free evolution of individual transmon qubits was demonstrated. One may combine DD and pulse shaping technique to obtain dynamically corrected gates @khodjasteh2009dynamically @edmunds2020dynamically composing of shaped pulses which actively drive state evolution within a Hilbert space in order to cancel certain system-bath couplings. With the availability of Qiskit Pulse @alexander2020qiskit that allows users to control backend pulse shapes and sequences of a quantum processor on the fly, a recent study @carvalho2020error, based on the Qiskit Pulse and robust control techniques, demonstrates enhancement up to: $tilde 10 times$ single-qubit gate coherent-error reduction; $tilde 5 times$ average coherent-error reduction; $tilde 10 times$ increase in calibration window to one week of valid pulse calibration; $tilde 12 times$ reduction gate-error variability across qubits and over time; and up to $tilde 9 times$ reduction in single-qubit gate error (including crosstalk). The improvements rendered by ~@carvalho2020error have implications on the performance of multiqubit gates in trapped ions~@milne2020phase.


In light of these recent developments, together with IBM Qiskit Pulse @alexander2020qiskit, we envisage a possibility to realize/encode holonomic quantum gates @zanardi1999holonomic @zhang2015fast which are robust against parameter fluctuations and attain even better gate fidelity and performance.


==== Lanczos-inspired approach
<lanczos-inspired-approach>
@suchsland2020algorithmic estimates the expectation value of a physical observable $upright("Tr") \[ hat(rho)^(( 0 )) hat(A) \]$ by constructing a basis of the order-$m$ Krylov subspace $cal(K)^(( m ))$ spanned by $( | Psi chevron.r , H | Psi chevron.r , H^2 | Psi chevron.r , . . . , H^m | Psi chevron.r )$. A way to look at this is to systematically construct the objective function to be minimised. For the order-$m$, the objective function is


$ E_(L , k , n , m) = min_(a in bb(R)^m) root(k, frac(chevron.l Psi | H^k ( sum_(i = 0)^(m - 1) a_i H^i )^n | Psi chevron.r, chevron.l Psi | ( sum_(i = 0)^(m - 1) a_i H^i )^n | Psi chevron.r)) . $


Due to the Krylov expansion, this technique can reduce the impact of different sources of noise with cost of an increase in the number of measurements to be performed, without additional experimental overhead. Calculating dynamic quantities such as Hamiltonian moments @vallury2020quantum and quantum power method based on higher-order Suzuki-Trotter expansion @seki2020quantum on near-term quantum computers are two recent examples that fall under the same approach here.


==== Learning-based and AI-inspired methods
<learning-based-and-ai-inspired-methods>
employ machine learning techniques such as regression for error mitigation. The process consists of training different candidate circuit variants with non-Clifford gates substituted with gates with efficient classical simulability~@strikis2020learning @czarnik2020error. A recent approach suggests merging zero noise extrapolation with learning-based methods for near-Clifford circuits~@lowe2020unified. There are also genetic algorithms to mitigate errors in quantum simulations @las2016genetic @spagnolo2017learning.


== Circuit compilation
<sec:compilers>


As it will be discussed in @sec:software, a quantum computer is composed of its hardware (quantum) and software (classical). The software translates a quantum algorithm into a set of instructions that implement the desired quantum operations and read out the qubit states. This process can be understood as #emph[quantum compilation] @chong2017programming, but the term is not limited to this particular application. When mapping a quantum circuit to a specific device architecture, one needs to consider the available quantum gates, the qubit connectivity that allows two-qubit gates implementation, and experimental limitations such as decoherence time, which imposes a certain maximum circuit depth in terms of the number of gates. For these reasons, it has become indispensable to develop tools that allow for circuit simplifications and efficient mappings of the general algorithm to specific hardware. These tools are also known as quantum compilers since they translate the theoretical circuit to the realistic simulator or device. In the following lines, we describe some of these tools. Many of them are suited both for NISQ and fault-tolerant quantum computation.


=== Native and universal gate sets
<sec:gate_set>


The available gates that can be implemented experimentally on a particular hardware platform are sometimes referred to as the #emph[native gate set]. With a universal gate set $cal(G) in S U ( d )$ (also called #emph[instruction gate set]), any unitary operation can be constructed efficiently. More formally, the #emph[Solovay-Kitaev theorem] @dawson2006solovay states that given this universal set $cal(G)$, any unitary operation $U in S U ( d )$ can be approximated with $epsilon.alt$ accuracy with a finite sequence $S$ of gates from $cal(G)$. This sequence scales logarithmically as $cal(O) ( log^c ( 1 / epsilon.alt ) )$, where $c$ is a constant that depends on the theorem proof. For $d = 2^n$ this theorem guarantees that qubit quantum circuits can be decomposed using a finite gate sequence. Although this is one of the most important theorems in quantum computation, it is an existence theorem, i.e. it does not provide the decomposition that it predicts. It also requires that the gate set contains the inverse of all gates. Further developments presented in @bouland2018trading tried to remove this assumption.


The Clifford group is an important object in quantum information science because of its applications in quantum error correction, randomized benchmarking and investigations for quantum advantage. The generalized Pauli operators in prime dimension $p$ are given by $ T_(( a , b )) = cases(
    omega^(- frac(a b, 2)) Z^a cal(X)^b & ( a , b ) in bb(Z)_p times bb(Z)_p & p eq.not 2,
    iota^(a b) cal(cal(Z))^a cal(X)^b & ( a , b ) in bb(Z)_2 times bb(Z)_2 & p = 2
  ) $<eq:Generalized_Pauli> where$omega = exp (frac(2 pi i, p))$and$bb(Z)_p$denotes an integer modulo$p$. The$cal(Z)$and$cal(X)$operators are defined via their action on computational basis states${| k chevron.r}_k$, with$cal(cal(X)) | k chevron.r = | k + 1 #h(0em) mod med p chevron.r , $<eq:Generalized_X> and$cal(Z) | k chevron.r = omega^k | k chevron.r .$The unitaries which map the set of generalized Pauli operators to themselves up to a phase are called #emph[Clifford unitaries]. Let us denote the set of$p$dimensional Clifford unitaries by$cal(C)_p$. Mathematically speaking,


$ U in cal(C)_p arrow.l.r.double exists phi.alt : U T_((a_1 , b_1)) U^dagger = exp (i phi.alt) T_((a_2 , b_2)) $<eq:Clifford_Operators>


where $T_((a_1 , b_1))$ and $T_((a_2 , b_2))$ are generalized Pauli operators. The set of Clifford unitaries $cal(C)_p$ forms a group, called the #emph[Clifford group]. In this review, we focus on $p = 2$, i.e. the qubit Clifford group.


There are infinitely many universal gate sets, but the Clifford group's gates $H$, $S$ and $C N O T$, together with the $T$ gate, compose the most commonly used set. The Clifford group alone can be simulated efficiently as stated by the #emph[Gottesman--Knill theorem] @Aaronson2004improved. The theorem states that no quantum advantage can be found without the use of the $T$ gate. For this reason, many algorithms try to simplify and reduce quantum circuits to the minimal number of $T$ gates, giving an estimation of the classical efficiency of that particular circuit @amy2013meet @gosset2013algorithm @heyfron2018efficient @kissinger2019reducing @amy2019t.


Besides these minimal reduction algorithms, other basic decompositions are useful. Even if only a native gate set is available experimentally, other basic gates can be constructed and used in algorithms. As an example, $S$ and $T$ gates are particular cases of the single-qubit rotational gate $R_z$, and the $H$ gate can be obtained from $R_y$ and $R_x$ gates as $H = R_y ( - pi / 2 ) R_x ( pi )$. Any single-qubit gate can be decomposed into the gate sequence


$U ( theta , phi.alt , lambda ) = R_z ( phi.alt ) R_y ( theta ) R_z ( lambda )$.


This motivates using single-qubit rotational gates and at least one entangling gate (e.g. $C N O T$ or $C Z$ gate) as native gate sets. Any two-qubit gate can be obtained from this minimal set by using circuit decompositions @barenco1995elementary @blaauboer2008analytical @watts2013metric @deguise2018simple @peterson2020two. The particular choice of the entangling gate can be motivated from the experimental platform. Depending on the technology used to construct the quantum device, a natural 2-qubit gate implementation can be more suited. Some examples are the use of $C Z$ gates in tunable superconducting circuits~@krantz2019quantum, cross-resonance gates in fixed frequency superconducting qubits~@krantz2019quantum @kjaergaard2020superconducting, or the $X X$ gates in trapped ions~@haffner2008quantum. More expressive gate sets with continuous gate parameters or long-range interactions can be achieved by further control over the hardware parameters in time @lacroix2020improving @foxen2020demonstrating @krinner2020demonstration @bastidas2020fully. The complexity of the circuit decomposition into CNOT and $R_z$ gates is analyzed in @amy2018controlled.


=== Circuit decompositions
<circuit-decompositions>


Once the native gate set is fixed, the next step consists of decomposing the theoretical unitary circuit into this basic set. A raw translation of all single and two-qubit gates into the native set might imply a large circuit depth, reducing the effectiveness of that decomposition. Moreover, finding the decomposition of gates acting on more than one qubit might prove challenging in general. Besides common circuit decompositions mentioned before, one may need mathematical tools to understand and derive general circuit reductions to particular smaller pieces.


One of these mathematical tools is the so-called #emph[ZX-Calculus]. It is a graphical language that maps quantum circuits to particular graph representations and derives a set of rules to manipulate these graphs. Its application range goes from measurement-based quantum computation to quantum error correction. For a complete review about ZX-calculus and its variety of applications, see Ref. @wetering2020zx. For the purpose of this review, we are interested in the quantum circuit simplification applications @cowtan2019phase @de2019techniques @duncan2020graph @kissinger2020reducing @hanks2020effective.


Other approaches use well-known artificial intelligence algorithms to find optimal circuit decompositions, for instance, the use of reinforcement learning @zhang2020topological @pirhooshyaran2020quantum. Evolutionary algorithms such as genetic algorithms have been widely studied @colin1999quantum @massey2004evolving @massey2006human @bang2014genetic @heras2016genetic @spagnolo2017learning @li2017approximate @lamata2018quantum @potovcek2018multi. In these approaches, multiple random circuits composed by the native gate set are generated and evolved later on. The evolution strategy includes the definition of possible #emph[mutations] such as introducing a new gate on a particular qubit, the swap between circuit gates or the deletion of a particular gate. Then, a multi-objective loss function is used to estimate the success of each circuit family until a given convergence criterion, after which the circuit with the best performance is selected. These works have to be added to those focusing finding the optimal PQC for a given VQA, as discussed in @sec:PQC. A VQA for circuit compilation using a genetic algorithm as optimization subroutine is presented in Ref. @khatri2019quantum, called Quantum Assisted Quantum Compiler.


=== The qubit mapping problem
<the-qubit-mapping-problem>


After decomposing and simplifying the quantum circuit into the native gates, a hardware-specific task remains: mapping the resultant circuit to the particular qubit connectivity or topology, a task also known as the #emph[qubit routing problem]. In general, due to experimental limitations, not all qubits are connected, which means that two-qubit operations are not always possible. A naive approach to circumvent this limitation consist of swapping each qubit state with its neighbour (by using $S W A P$ gates) until we find a connected pair, perform the desired two-qubit operation and swap back the states of the qubits involved, returning to the original state with the intended two-qubit gate applied to it. This translates into a significant growth of the circuit depth for circuit topologies with a sparse qubit connection graph.


Some NISQ algorithms presented in this review may include the qubits' connectivity by means of the loss function or the available rules used to decompose the unitaries. However, quantum compilation is a hardware-specific transformation; it might be more useful to apply this step independently of the quantum circuit and depending on the chip architecture. Unfortunately, the qubit mapping problem is NP-complete @Botea2018OnTC. Several heuristic approaches based on dynamic programming and depth partitioning have been explored @zulehner2017exact @siraichi2018qubit @zulehner2018efficient @li2019tackling @zulehner2019compiling @cowtan2019qubit as well as using reinforcement learning @pozzi2020using. Exact methodologies based on reasoning engines such as Boolean satisfiability solvers have also been proposed @wille2019mapping @tan2020optimal. The so-called LHZ architecture is an approach that solves the connectivity issue at the cost of increasing the number of qubits ~@lechner2020quantum. The same framework can be applied to a quantum annealing system as well~@lechner2015quantum. Encoding this problem into a QUBO (see @subsec:quantum-annealing) to solve it using classical simulated annealing has also been proposed in Ref. @dury2020qubo. Approaches for circuit compilation based on commutation algebra of quantum gates have been been suggested in ~@itoko2020optimization @itoko2019quantum.


There can be many possible qubit mappings of a given algorithm into a particular device if not all qubits are required. In those cases, one can put some extra effort to find the best performing qubits in terms of error rates and coherence times @nishio2020extracting @niu2020hardware. In that direction, finding the mapping with the lowest circuit depth may prove valuable to reduce the errors due to decoherence @zhang2020slackq.


Finally, the use of circuit synthesis with connectivity constraints have also been proposed. Some of these works are based on Gaussian elimination processes where you take the matrix representation of the circuit transformation and manipulate it to extract the basic transformations (in particular, the CNOT gates that respect the connectivity) @nash2020quantum @kissinger2019cnot. In @gheorghiu2020reducing, the strategy consist on slicing the circuit into smaller parts that can be adapted and transformed to fit into the particular topology. One can also adapt this problem to the syndrome decoding problem @de2020quantum. Reference @de2020architecture solves the qubit routing for phase polynomial circuits, i.e. circuits that only contain CNOTs and $R_z$ gates.


=== Resource-aware circuit design
<resource-aware-circuit-design>


As described in @sec:PQC, there are different strategies to design a circuit ansatz. Unfortunately, many of them require circuit depths, qubit connectivity and a number of parameters beyond the capabilities of current quantum hardware. In the following paragraphs, we discuss strategies to design and adapt PQC and VQA to the devices characteristics.


==== ADAPT-VQE.
<adapt-vqe.>
Early VQA employed a fixed ansatz design with its parameters tuned using a classical optimizer. The Adaptive Derivative-Assembled Pseudo-Trotter ansatz Variational Quantum Eigensolver (ADAPT-VQE) was introduced as a more scalable and efficient way to simultaneously design and optimize a parameterized ansatz @grimsley2019adaptive. At each iteration, ADAPT-VQE constructs an ansatz by adding an operator corresponding to the largest gradient from a carefully designed operator pool. That is, given an operator $hat(tau)_i$ from the operator pool, the gradient of the energy with respect to the corresponding parameter $theta_i$ is defined as


$ partial_i E = chevron.l psi | \[ H , hat(tau)_i \] | psi chevron.r , $


where $| psi chevron.r$ is the ansatz at the current iteration to be updated. After computing the gradient components and choosing the operator corresponding to the largest gradient, the gate operation implementing $hat(tau)_i$ is added to the ansatz with its parameter value initialized at $0$. The ansatz is then optimized before adding the next operator. The ADAPT-VQE algorithm terminates when the norm of the gradient vector falls below a predefined threshold.


In the case of fermionic ADAPT-VQE, the operator pool consists of fermionic operators that are transformed into quantum gate operations through, e.g., the Jordan-Wigner mapping. A more hardware-efficient variant of the ADAPT-VQE algorithm is the qubit ADAPT-VQE, in which the pool consists of gate operators acting directly on qubits @tang2019qubit. Both versions of ADAPT-VQEs were able to to generate optimized circuits with reduced depths and CNOT counts compared to previous ansatz construction and optimization methods.


==== MI-ADAPT-VQE.
<mi-adapt-vqe.>
The mutual information-assisted ADAPT-VQE (MI-ADAPT-VQE), introduced by @zhang2020mutual, leverages the density matrix renormalization group (DMRG) @white1992density @hallberg2006new method to accelerate the circuit constructions for the ADAPT-VQE routine. Instead of gradients, it uses the mutual information to guide circuit constructions. At the beginning of the algorithm, the pair-wise quantum mutual information is approximated using DMRG, which is then applied to construct a reduced pool of entangling gates. In each iteration of the method, new circuits are generated in which quantum gates are mainly distributed among pairs of qubits corresponding to large mutual information. This avoids allocating quantum resources on pairs of qubits that are less important to entangle. Numerical experiments suggest that the number of new circuits needed in each step of the adaptive construction can be significantly reduced using MI-ADAPT-VQE, saving both time and quantum resources. The number of trial circuits in certain cases can be reduced to about $5 "%"$ for $H_2$ and $10 "%"$ for $H_2 O$ as compared to ADAPT-VQE, using an operation pool based on the qubit coupled-cluster method @ryabinkin2020iterative.


==== MoG-VQE.
<mog-vqe.>
To reduce two-qubit gate counts for near-term experiments, the multiobjective genetic variational quantum eigensolver (MoG-VQE) optimizes for both the energy and the number of CNOTs in the quantum circuit @chivilikhin2020mogvqe. The MoG-VQE algorithm combines two evolutionary strategies: #emph[i)] NSGA-II @deb2000fast, a multiobjective genetic algorithm, to propose a circuit structure to minimize both the energy and CNOT count, and #emph[ii)] CMA-ES @hansen2003reducing to tune parameters and evaluate optimized energies for the qubit topologies suggested by the NSGA-II algorithm. MoG-VQE initializes a diverse population by sampling a checkerboard pattern of two-qubit circuit blocks. To vary the populations over different generations, the three possible mutation operators are: #emph[i)] inserting a two-qubit circuit block in a random position; #emph[ii)] removing a two-qubit circuit block in a random position; and #emph[iii)] adding or removing 10 circuit blocks to help escape from local minima. The authors note that #emph[iii)] is selected with a lower probability than mutation operators #emph[i)] and #emph[ii)]. Parents are selected using the tournament selection method. For each circuit topology, the corresponding energy is evaluated using the CMA-ES optimizer. These steps repeat until some termination criteria are satisfied. Using MoG-VQE, the authors reported significant reductions in the CNOT counts compared to those of other hardware-efficient circuits when estimating ground state energies of several molecules. For example, for a 12-qubit LiH Hamiltonian, MoG-VQE generated a circuit corresponding to estimating the ground state energy to within chemical precision using only 12 (non-nearest-neighbor) CNOTs.


==== PECT.
<pect.>
An alternative approach for adaptively constructing and optimizing an ansatz was introduced by the Parameter-efficient circuit training (PECT) scheme @sim2020adaptive. PECT enables optimizations of predefined ansätze, such as unitary coupled-cluster or the low-depth circuit ansatz (LDCA) @dallaire-demers2018lowdepth, by dynamically pruning and adding back parameterized gates during an optimization. After selecting an ansatz $U$, a subset of gate operations from $A$ is chosen while other parameterized gate operations are tuned to identity operations. This results in an ansatz substructure $A'$ with reduced circuit depth and gate count. Parameters of $A'$ are then optimized, following what the authors call a "local optimization" step. After local optimization, to refine or reparameterize the ansatz substructure, parameters with small magnitudes are pruned or removed. A heuristic growth rule is used to grow back the same number of parameters that was pruned. Steps of local optimization and ansatz reparameterization are repeated until termination criteria are met. Because PECT optimizes parameter subsets at any iteration, circuits that are executed on the quantum computer have reduced depths and CNOT counts compared to the original ansatz. Using PECT, the authors were able to optimize 12-qubit LDCA circuits, naively equipped with hundreds to low thousands of parameters, to estimate ground state energies of LiH and $upright("H")_2 upright("O")$. Previous optimizations of LDCA were limited to 8 qubits.


= APPLICATIONS
<ch:application>


== Many-body physics and chemistry
<sec:chemistry>


Understanding the static and dynamic properties of quantum mechanical systems is a core challenge at the heart of many fields such as chemistry and physics. Classical numerical methods often struggle in solving these problems, due to the exponential increase of resources needed with growing number of particles to simulate. Owing to their quantum mechanical nature, quantum computers offer a way to simulate even large-scale many-body systems~@feynman1982simulating @vonburg2020quantum. The initial application for chemistry was to obtain molecular energies via quantum phase estimation on a quantum computer @aspuru2005simulated. Besides the molecular energy, properties that can be extracted from a successfully prepared ground state, such as energy derivatives with respect to the nuclear framework, are of similar interest ~@kassal2009quantum @obrien2019calculating. Fault tolerant quantum algorithms have the potential to become #emph[killer applications] in the computational discovery of chemical reaction mechanisms ~@reiher2017elucidating and NISQ algorithms could play a major role in their realization. Here we review various NISQ algorithms that have been proposed to tackle quantum chemistry and many-body physics related problems. We start by introducing concepts on mapping physical problems onto the quantum computer. Then, we introduce algorithms for common challenges, such as finding the static as well as dynamic properties of quantum systems in various settings. All NISQ algorithms discussed in this section are listed in @tab:many_body.


=== Qubit encodings
<qubit-encodings>


In general, any physical system can be written in terms of a Hamiltonian which is the sum of its kinetic and potential energy. In quantum theory, each physical system is associated with a language of operators and an algebra establishing such language. Depending on the system constituents, there are three types of particles (operators) in Nature: fermions, bosons and anyons. The first two are elementary particles obeying Fermi-Dirac (FD) and Bose-Einstein (BE) statistics, respectively. The latter being quasiparticles obeying continuous or anyonic statistics, and existing only in two-dimensional confinement. Quantum computers (QC) operate in a language of qubits (a distinguishable set of spin-$1 / 2$ particles). Hence, the quantum simulation of a physical system refers to performing a one-to-one mapping from the system operator to the QC language, preserving the underlying statistics. For a recent review on hardware-dependent mappings of spin Hamiltonians into their corresponding quantum circuit, refer to ~@tacchino2020quantumreview.


In the standard model of quantum computation, a two-level system or spin-$1 / 2$ particle is denoted by its spin orientation $| arrow.t chevron.r = | 0 chevron.r = ( 1 , 0 )^T$ and $| arrow.b chevron.r = | 1 chevron.r = ( 0 , 1 )^T$. An $N$-qubit system is then constructed from the standard Pauli matrices $hat(sigma)_x^i , hat(sigma)_y^i , hat(sigma)_z^i$, where the superscript $i$ refers to the $i^(upright("th"))$ local qubit site. These operators satisfy the commutation relations of an $x⋁_(i = 1)^N s u ( 2 )_i$ algebra


$\[ hat(sigma)_mu^l , hat(sigma)_nu^m \] = 2 i delta_(l m) epsilon.alt_(mu nu lambda) hat(sigma)_lambda^l$,


where $epsilon.alt_(mu nu lambda)$ is the totally anti-symmetric Levi-Civita symbol with $mu , nu , lambda in ( x , y , z )$.


==== Fermions. 
<fermions.>
In the second quantized notation, $N$ fermions are denoted by fermionic operators $hat(f)_i^dagger ( hat(f)_i )$, the creation (annihilation) operators of a fermion in the $i^(upright("th"))$ mode/site $( i = 1 , dots.h.c , N ) .$ The fermionic operators obey Pauli's exclusion principle and the anti-symmetric nature of the fermion wave function. Hence, the fermionic algebra is defined by the anti-commutators $( hat(f)_i , hat(f)_j ) = 0 , ( hat(f)_i^dagger , hat(f)_j ) = delta_(i j) .$


There are a number of well-known mappings that allow the description of a fermionic system by the standard model of QC. They are the Jordan-Wigner transformation @jordan1928pauli, Bravyi-Kitaev transformation @bravyi2002fermionic and Ball-Verstraete-Cirac transformation @ball2005fermions @verstraete2005mapping. In~@steudtner2019quantum, the two-dimensional topology of most proposed qubit architectures is taken explicitly into account and compared to some of the aforementioned one-dimensional mappings. More advanced mappings, using the interaction graph of the Hamiltonian~@setia2018bravyikitaevsuperfast @setia2019superfast or customized quasi-local and local encodings~@havlicheck2017operator @chien2020custom @derby2020compact @jiang2020optimal have been introduced as well. Other approaches try to lower the qubit requirements of the mapped fermionic operators by taking inspiration from classical error correction codes and the internal symmetries of the system~@bravyi2017tapering @steudtner2018fermiontoqubit, other examples are mappings based on point-group symmetries of molecular Hamiltonians~@setia2020reducing. Recently, mappings of SU($N$) fermions to qubits have been proposed~@consiglio2021variational. \


In the following, we will briefly outline the oldest and most intuitive mapping: the Jordan-Wigner transformation. In this mapping, the qubit states are equivalent to the second-quantized occupation number vectors, and fermionic creation and annihilation operators are transformed to qubit raising and lowering operators $hat(sigma)_plus.minus^j = ( hat(sigma)_x^j plus.minus i hat(sigma)_y^j ) / 2$ combined with strings of $hat(sigma)_z$ operators that ensure the correct anti-commutation properties:


$ hat(f)_j arrow.r (product_(l = 1)^(j - 1) - hat(sigma)_z^l) hat(sigma)_(-)^j , quad f_j^dagger arrow.r (product_(l = 1)^(j - 1) - hat(sigma)_z^l) hat(sigma)_(+)^j . $


In this new transformation, one can verify that $hat(f)_j^dagger , hat(f)_j$ satisfy the above anticommutation relations, while $hat(sigma)_mu^j$ satisfy the commutation relations showed above. The reader is referred to the literature~@aspuru2005simulated @seeley2012bravyikitaev @tranter2015bravyikitaev @tranter2018comparison @somma2003quantum and the respective original references for details and comparisons regarding the other transformations.


==== Bosons. 
<bosons.>
Bosonic operators satisfy the commutation relations $\[ hat(tilde(b))_i , hat(tilde(b))_j \] = 0 , \[ hat(tilde(b))_i , hat(tilde(b))_j^dagger \] = delta_(i j)$


in an infinite-dimensional Hilbert space. At first, it seems it is impossible to simulate bosonic systems due to the nature of infinite dimensions. However, sometimes we are interested in studying some finite modes of excitations above the ground state. Hence, the use of the entire infinite dimensional Hilbert space is unnecessary. In a finite dimensional basis, the bosons $hat(b)_i^dagger , hat(b)_i$ obey the following commutation relations @batista2004algebraic


$ \[ hat(b)_i , hat(b)_j \] = 0 , med \[ hat(b)_i , hat(b)_j^dagger \] = delta_(i j) \[1 - frac(N_b + 1, N_b !) ( hat(b)_i^dagger )^(N_b) ( hat(b)_i )^(N_b)\] , $<eq:ch4:truncated_boson_commutator>


with $hat(b)_i^dagger hat(b)_i | n_i chevron.r = n_i | n_i chevron.r$ with $n_i = 0 , dots.h.c , N_b$, where $N_b$ is the maximum truncated excitation number, corresponding to the $i^(upright("th"))$ bosonic site/mode. A direct consequence is one can then write down the creation and annihilation operators as


$ hat(b)_i^dagger = sum_(n = 0)^(N_b - 1) sqrt(n + 1) | n + 1 chevron.r chevron.l n | , $


and $hat(b)_i$ is complex conjugate of $hat(b)_i^dagger$. There are infinite means to translate such truncated operators into the QC language, the so-called Pauli words. A Commonly used one is known as standard binary or compact encoding @somma2003quantum @veis2016quantum @sawaya2019quantum @mcardle2019digital @sawaya2020resource, where $( alpha , beta in bb(W) )$ in $| alpha chevron.r chevron.l beta |$ are now written in terms of binary strings. Using the following identities: $| 0 chevron.r chevron.l 1 | equiv hat(sigma)_(-) | 1 chevron.r chevron.l 0 | equiv hat(sigma)_(+) | 0 chevron.r chevron.l 0 | equiv ( I + hat(sigma)_z ) / 2 | 1 chevron.r chevron.l 1 | equiv ( I - hat(sigma)_z ) / 2$, Pauli words translation can be accomplished. Recently, detailed studies on various encodings (binary, Gray, Unary, block Unary), have been studied and Gray code in particular is found to be resource efficient (in terms of number of qubits and two-qubit entangling gates) in simulating some specific bosonic and spin Hamiltonians @sawaya2020resource.


==== Anyons. 
<anyons.>
As seen above, we can now proceed to simulate more general particle statistics, in particular, hard-core anyons. With "hard-core", we refer to the Pauli's exclusion principle where only zero or one particle can occupy a single mode. The anyonic operators $hat(a)_i , hat(a)_i^dagger$ obey the commutation relations


$\[ hat(a)_i , hat(a)_j \]_theta = \[ hat(a)_i^dagger , hat(a)_j^dagger \]_theta = 0$, $\[ hat(a)_i , hat(a)_j^dagger \]_(- theta) = delta_(i j) ( 1 - ( e^(- i theta + 1) ) hat(n)_j )$ and $\[ hat(n)_i , hat(a)_j^dagger \] = delta_(i j) hat(a)_j^dagger$,


where $hat(n)_j = hat(a)_j^dagger hat(a)_j , \[ hat(A) , hat(B) \]_theta = hat(A) hat(B) - e^(i theta) hat(B) hat(A)$, with $( i lt.eq j )$ and $0 lt.eq theta < 2 pi$. Specifically, $theta = pi upright(" mod") ( 2 pi )$ gives rise to canonical fermions, and $theta = 0 upright(" mod") ( 2 pi )$ would recover hard-core bosons. By simply applying the following isomorphic mapping between algebras #cite(<somma2003quantum>):


$ hat(a)_j^dagger & = & product_(i < j) (frac(e^(- i theta) + 1, 2) + frac(e^(- i theta) - 1, 2) hat(sigma)_z^i) hat(sigma)_(+)^j ,\
hat(a)_j & = & product_(i < j) (frac(e^(i theta) + 1, 2) + frac(e^(i theta) - 1, 2) hat(sigma)_z^i) hat(sigma)_(-)^j , quad hat(n)_j = frac(1 + hat(sigma)_z^j, 2) , $


we would obtain Pauli words for the QC. The above mapping would also ensure the anyonic algebra shown above.


=== Constructing electronic Hamiltonians
<sec:constructing_electronic_hamiltonians>


The electronic structure problem is one of the most prominent task within VQA (see for example the reviews @cao2019quantum @mcardle2020quantum) and was the pioneering task for the variational quantum eigensolver @peruzzo2014variational @mcclean2016theory. In this section, we will illustrate how the original continuous many-electron problem can be discretized to a second-quantized formulation that can itself be encoded into qubits by the techniques introduced in the beginning of @sec:chemistry. This encoded qubit systems define then the central problem of the VQAs further described in @sec:VQE.


The electronic structure problem aims to approximate eigenfunctions of an electronic Hamiltonians


$ H_(upright("e")) = cal(T)_(upright("e")) + cal(V)_(upright("ee")) + cal(V)_(upright("ext")) , $<eq:electronic_hamiltonian>


describing a system of $N_(upright("e"))$ electrons through their accumulated kinetic energies $cal(T)_(upright("e")) = - 1 / 2 sum_(k = 1)^(N_(upright("e"))) Delta_(bold(r)_k)$, the electronic Coulomb repulsion $cal(V)_(upright("ee")) = sum_(k eq.not l) V_(upright("ee")) (bold(r)_k - bold(r)_l) = sum_(k eq.not l) frac(1, | bold(r)_k - bold(r)_l |)$, and an external potential $cal(V)_(upright("ext")) = sum_(k = 1)^(N_(upright("e"))) V_(upright("ext")) (bold(r)_k)$ that is usually given by the accumulated Coulomb potential of nuclear point charges. If the external potential is not explicitly spin dependent, the electronic Hamiltonian only acts on the spatial coordinates $bold(r)_k in bb(R)^3$ of the electrons and, to ensure proper electronic wave functions, the fermionic anti-symmetry is achieved via restrictions in the Hilbert-space. We refer to @herbst2018thesis @kottmann2018thesis @rhowedder2010thesis and the textbook @yserentant2010regularity for the direct construction and discretization of this continous Hilbert spaces.


A more compact, but formally equivalent, definition is offered through second quantization by introducing the abstract anti-commuting field operators $hat(psi)^dagger (x)$ and $hat(psi) (x)$ that create and annihilate electrons at spin-coordinate $x_k in bb(R)^3 times {plus.minus 1 / 2}$~@jordan1927mehrkorperproblem @surjan2012second @jorgensen2012second. The electronic Hamiltonian can then be written as


$ H_(upright("e")) = & integral "d" x #h(0em) hat(psi)^dagger (x) (T (x) + V_(upright("ext")) (x)) hat(psi) (x)\
 & + integral "d" x "d" y #h(0em) hat(psi)^dagger (x) hat(psi)^dagger (y) V_(upright("ee")) (x - y) hat(psi) (y) hat(psi) (x) $<eq:electronic_hamiltonian_second_quantized>


where the potential operators still only act on the spatial part of the spin components. Although direct approaches on real-space grids are possible~@kottmann2018coupledGS @kottmann2018thesis @kunitsa2020grid @kivlichan2017bounding the majority of VQA employs a fixed set of three dimensional functions (so-called orbitals) to capture the spatial part of the electronic Hilbert space. The orbitals are usually determined by solving a mean-field problem (HartreeFock) within a set of globally defined atomic orbitals. Alternatives to the standard representation are, for example, direct determination of system adapted orbitals~@kottmann2020reducing, compactification of basis sets through intrinsic atomic orbitals~@barison2020quantum and optimized virtual orbitals represented by plane-waves~@bylaska2020quantum.


For the formal description of the discretized second-quantized electronic Hamiltonian, the origin of the orbitals is not important as long as they form an orthonormal set of $H^1 (bb(R)^3)$ functions. Using such a set of spatial orbitals we can formally expand the field operators in the corresponding spin-orbitals


$ hat(psi)^dagger (x) = sum_k phi.alt_k^(*) (x) f_k^dagger , quad hat(psi) (x) = sum_k phi.alt_k (x) f_k , $


where $f_k^dagger$ and $f_k$ are fermionic creation and annihilation operators obeying the anticommutation relations shown in the previous subsection. Using the expansion from @eq:electronic_hamiltonian_second_quantized leads to the common discretized second-quantized Hamiltonian,


$ H_(upright("e")) = sum_(k l) h_(k l) f_k^dagger f_l + sum_(k l m n) g_(k l m n) f_k^dagger f_l^dagger f_n f_m , $<eq:electronic_hamiltonian_second_quantized_discretized>


with the molecular integrals~@fermann2020fundamentals


$  & h_(k l) = integral phi.alt_k^(*) (x) (T (x) + V_(upright("ext")) (x)) phi.alt_l (x) "d" x ,\
 & g_(k l m n) integral phi.alt_k^(*) (x) phi.alt_l^(*) (y) V_(upright("ee")) (x - y) phi.alt_m^(*) (x) phi.alt_n^(*) (y) "d" x "d" y . $<eq:molecular_integrals>


Note that the indices of the two body integrals are denoted in the standard Dirac notation $g_(k l m n) equiv chevron.l k l | V_(upright("ee")) | m n chevron.r$ but other notations, such as Mulliken $("km" | l m) = chevron.l k l | V_(upright("ee")) | m n chevron.r$ are sometimes used. Generally speaking, an arbitrary set of spatial orbitals, that can in principle be any set of orthonormal $H^1 (bb(R)^3)$ functions, defines a discretized second-quantized Hamiltonian as in @eq:electronic_hamiltonian_second_quantized_discretized over the corresponding molecular integrals @eq:molecular_integrals. This discretized Hamiltonian can then be encoded into a qubit Hamiltonian by corresponding fermion to qubit mappings discussed in @sec:chemistry.


=== Variational quantum eigensolver
<sec:VQE>


Estimating the ground state and its energy of Hamiltonians is an important problem in physics, which has numerous applications ranging from solid-state physics to combinatorial optimization (see @sec:optimization). While this problem is in general QMA-hard and even quantum computers are not expected to be able to efficiently solve it in general~@kempe2006complexity, there is hope that approximate solutions of the ground state could be found faster and for larger system sizes compared to what is possible with classical computers.


To this end, VQE @peruzzo2014variational @mcclean2016theory has been proposed, to find the ground state of a Hamiltonian $H$ in a manner that is suited for NISQ devices~@wecker2015progress. Following the concept introduced in @sec:objective_function and @sec:PQC, a parameterized circuit $U ( bold(theta) )$ is minimized with respect to the objective function, which in general is the expectation value of the energy of the Hamiltonian from @eq:def_expectationvalue.


The approximated ground state is given by the quantum state $| psi_(upright("min")) chevron.r = U ( bold(theta)_(upright("min")) ) | 0 chevron.r$ which minimizes the energy $upright("min")_(bold(theta)) chevron.l H_(bold(theta)) chevron.r gt.eq E_(upright("g"))$ upper bounded by the true ground state energy $E_(upright("g"))$ as guaranteed by the Rayleigh-Ritz variational principle @gould2012variational. VQE has been intensively studied in both theory and experiments, and various adaptions and extensions have been proposed, which we discuss in the following paragraphs.


==== Self-verification. 
<self-verification.>
Whether the variational quantum simulator has converged to an actual eigenstate of the Hamiltonian, can be checked directly on the quantum processor by verifying that the variance of the energy $upright("var") = chevron.l ( H - chevron.l H chevron.r )^2 chevron.r$ is zero. This has been demonstrated for solving a many-body Hamiltonian on 8 qubits on a ion-trap @kokail2019self (see also @sec:nuclear_physics).


==== Accelerated VQE. 
<accelerated-vqe.>
A key computational effort in VQE lies in estimating the cost function, which is achieved by repeatedly running the circuit and taking measurements of the Pauli strings (see @sec:measurement). For a given desired additive error bounded by $epsilon.alt$, it takes $O ( 1 / epsilon.alt^2 )$ number of samples. This can be improved by using the Quantum Phase estimation algorithm to estimate the expectation value, which takes only $O ( upright("log") ( 1 / epsilon.alt ) )$ samples, however at the cost of additional computation which may be hard in the NISQ era. To leverage a trade-off between the advantages and disadvantages of both methods, an accelerated versions of VQE that interpolates between regular measurements and quantum phase estimation has been proposed~@wang2019accelerated.


==== Measurement-based VQE. 
<measurement-based-vqe.>
In @ferguson2020measurement, the authors present two strategies to implement the VQE algorithm on a measurement-based quantum computer, an alternative quantum computing paradigm that uses entanglement as a resource and achieves the the desired computation by performing particular sets of local measurements (see @briegel2009measurement for a review). They propose a way to generate the needed variational state families using measurements on a highly entangled state and provide an equivalence between the measurement- and gate-based schemes.


==== Reusing qubits in VQE. 
<reusing-qubits-in-vqe.>
A recent proposal suggested a VQE method that relies on fewer qubits by re-using some of them~@liu2019variational. The core idea is to represent a virtual $N$ qubit state by $R + V < N$ physical qubits, where $R$ qubits have to be reusable qubits, e.g. they can be measured and re-initialized during the circuit runtime. These intermittent measurements are possible on current ion trap hardware~@pino2020demonstration. The $R + V$ qubits are entangled by a PQC, then $R$ qubits are measured and the outcome is recorded. The $R$ qubits are re-initialized to the $| 0 chevron.r^(⊗ R)$ state, and again entangled with the $V$ other qubits by another PQC. This procedure is repeated until in total $N$ qubits have been measured. The concept and expressiveness of this type of ansatz is the same as Tensor networks methods such as MPS, which have been highly useful for the classical calculation of many-body problems, and open up a way to perform quantum computing of many qubits on devices with limited number of qubits.


==== Adiabatically assisted VQE. 
<adiabatically-assisted-vqe.>


The ground state of more challenging Hamiltonians can be difficult to find for standard VQE due to convergence to local minima instead of the global minima of the energy. To alleviate this, quantum annealing (see @subsec:quantum-annealing) can be used to adiabatically assist the optimisation procedure, as proposed in the adiabatically assisted VQE @garcia2018addressing. This approach uses an objective function $O ( s ) = chevron.l 0 | U^dagger ( bold(theta) ) H ( s ) U ( theta ) | 0 chevron.r$, where $H ( s ) = ( 1 - s ) H_0 + s H_1$. Here, $H_0$ is a Hamiltonian with easily preparable groundstate and the goal is to find the ground state of a Hamiltonian $H_1$. In this algorithm, VQE is run for multiple discrete steps $s_n$. One starts with $s_0 = 0$ and finds the minimal parameters $bold(theta)_0^(*)$ of the objective function $O ( s_0 )$. Then, $bold(theta)_0^(*)$ is used as initial guess for VQE for the next increasing step $s_1 = s_0 + Delta s$ with objective function $O ( s_1 )$. This procedure is repeated until $s = 1$ is reached. This approach eases the optimization task, as the initial Hamiltonian $H_0$ is a simple Hamiltonian with a ground state that can be easily found via optimization. For small steps $Delta s$, the ground state of the Hamiltonian $H ( s )$ and $H ( s + Delta s )$ will not differ too much, making the optimization task at every step less challenging compared to directly solving for $H ( 1 )$. Previous works @mcclean2016theory also suggest to use adiabatically prepared states as initial states of a VQE algorithm (see @sec:PQC).


=== Variational quantum eigensolver for excited states
<sec:var_excited>


The methods of VQE have been extended to obtain the excited states of a given Hamiltonian. Finding excited states or the spectrum of a Hamiltonian is an important problem in quantum chemistry and many-body physics. Various proposals have been put forward.


==== Folded spectrum method. 
<folded-spectrum-method.>
A straightforward way of calculating excited states is the folded spectrum method proposed by ~@peruzzo2014variational. To find an excited state of a Hamiltonian $H$ with approximate energy $lambda$, the above defined VQE method is here applied to the objective function $C ( bold(theta) ) = chevron.l (H - lambda)^2 chevron.r_(U_((bold(theta))))$. VQE will target the eigenstate with an energy that is closest to $lambda$. This method requires an approximate knowledge of the energy of the excited state that one wants to find, as well as estimating $chevron.l H^2 chevron.r$, which may require a excessively large number of measurements to be performed.


An extension of this method can also be used to find states that are constrained to a specific value of the conserved quantity of the problem, such as total particle number or magnetization~@ryabinkin2018constrained. Here, one defines the objective function $C ( bold(theta) ) = chevron.l H chevron.r_(cal(U) (bold(theta))) + sum_i mu_i ( chevron.l S_i chevron.r_(cal(U) ( bold(theta) )) - s_i )^2$, where $S_i$ is the operator corresponding to the conserved quantity, and $s_i$ is the target value of that quantity. Note, that this does not restrict the target space to be an eigenstate of $S_i$.


==== Orthogonally constrained VQE. 
<orthogonally-constrained-vqe.>
Excited states can be found by constraining the VQE objective function such that it penalizes the ground state @higgott2019variational. First, one finds an approximation to the ground state of Hamiltonian $H$ via VQE with $bold(theta)_0 = upright("arg min")_(bold(theta)) chevron.l H chevron.r_(cal(U) ( bold(theta) ))$ and approximated ground state $| psi ( bold(theta)_0 ) chevron.r = cal(U) ( bold(theta)_0 ) | 0 chevron.r$. Then, one uses this information to formally project out the approximate ground state to find the next highest excited state. One defines the Hamiltonian $H_1 = H + a | psi ( bold(theta)_0 ) chevron.r chevron.l psi ( bold(theta)_0 ) |$, with some sufficiently large positive parameter $a$. The ground state of $H_1$ then corresponds to the first excited state of $H$ and can be found with a VQE. This procedure can be repeated to find higher excited states up to any order by sequentially accumulating the projector terms of all states found. The Hamiltonian for the $k$-th excited state is then given by $H_k = H + sum_i^(k - 1) a_i | psi ( bold(theta)_i ) chevron.r chevron.l psi ( bold(theta)_i ) |$. Combined with the unitary coupled cluster ansatz, the orthogonally constrained VQE can find excited states of small molecules~@higgott2019variational @lee2018generalized. It was further extended for adaptive circuit construction~@kottmann2020feasible and imaginary time evolution~@jones2019variational.


The projector term requires calculating the overlap $| chevron.l psi ( theta ) | psi ( theta_0 ) chevron.r |$, which can be achieved for example by the SWAP test, by applying the inverse of the circuit that generated the ground state $| chevron.l 0 | U^dagger ( theta ) U ( theta_0 ) | 0 chevron.r |^2$, or randomized measurements~@elben2020cross. An alternative approach that relies on a discriminator circuit that is trained in parallel to distinguish between the excited state to be learned and previously found lower-lying states has been proposed~@tilly2020computing and demonstrated on a small model system. Scalable proposals still remain an open research question. Since the projector term does not require the overlap itself, but the absolute square of it, it can be computed with the help of ~@eq:fidelity_target by computing the fidelity of the current trial state with the previously found states~@lee2018generalized @kottmann2020reducing.


==== Subspace expansion. 
<subspace-expansion.>
The subspace expansion method was introduced in @sec:other_QEM for error mitigation. This method can be also used to find excited states~@mcclean2017hybrid and it was demonstrated for a small molecule in~@colless2018computation. After finding the ground state of a Hamiltonian $H$ with VQE, one follows the steps that were detailed in @sec:other_QEM. One expands the prepared quantum state with different appropriate operators that match the low-energy excitations of $H$ and generates a set of states that span the low-energy subspace. Then, overlaps between the states are measured, which are then used to solve a generalized eigenvalue problem on a classical computer. The eigenvalues and eigenstates give the excited states of the Hamiltonian. For quantum chemistry problems, the subspace expansion method was also proposed for including dynamical correlations to ground states over external corrections~@takeshita2020increasing, in the spirit of classical quantum chemistry methods, like for example #emph[CAS-CI]~@roos1980complete.


As alternative approach, the expansion in the subspace can also be accomplished by real-time evolving a reference state, and picking states at different evolution times as basis for expansion~@stair2020multireference. This is motivated by the fact that the time evolution can be seen as an approximate Krylov expansion of the quantum state. Then, one proceeds to solve the generalized eigenvalue problem to find eigenstates and eigenvalues of the Hamiltonian.


==== Subspace-search VQE/State-averaged VQE. 
<subspace-search-vqestate-averaged-vqe.>
The core idea of a subspace-search VQE (SSVQE)~@nakanishi2019subspace or state-averaged VQE (SAVQE)~@yalouz2021stateaveraged @arimitsu2021analytic is to minimize the energy of a PQC $U ( bold(theta) )$ over a set of orthogonal quantum states. The goal is to find the $k$-th eigenstates with lowest eigenenergy of a Hamiltonian $H$. In the weighted SSVQE the cost function is


$ L ( bold(theta) ) = sum_(j = 1)^k w_j chevron.l phi_j | U^dagger ( theta ) H U ( bold(theta) ) | phi_j chevron.r thin , $<eq:SSVQE_weighted>


where ${ | phi_j chevron.r }_(j = 0)^k$ is a set of $k$ easily preparable mutually orthogonal quantum states (with $chevron.l phi_i | phi_j | = chevron.r delta_(i , j)$) and ${ w_j }_j$ are positive real numbers with $w_i > w_j$ for $i < j$. Minimizing $bold(theta)^(*) = upright("arg min")_(bold(theta)) L ( bold(theta) )$ to its global minimum gives us the ground state and excited states $| psi_j chevron.r = U ( bold(theta) ) | phi_j chevron.r$, where $j = 1$ is the ground state and $j > 1$ the excited states sorted in ascending order. This algorithm gives all $k$ eigenstates in a single optimization routine. Note however that the more states to be optimized, the more complex the optimization landscape and the effort to minimize becomes. An alternative formulation of the algorithm to find specifically the $k$-th lowest eigenstate is the unweighted SSVQE. Here, one minimizes


$L_1 ( bold(theta) ) = sum_(j = 1)^k chevron.l phi_j | U^dagger ( bold(theta) ) H U ( bold(theta) ) | phi_j chevron.r$.


However, due to the absence of weights, the found states $| psi'_j chevron.r = U ( bold(theta)^(*) ) | phi_j chevron.r$ for minimal $bold(theta)^(*)$ are not proper eigenstates of $H$, but are superposition states that span the subspace of the $k$ lowest energies. As final step to find the $k$-th eigenstate, one fixes $bold(bold(theta)) = theta^(*)$ to its minimized value, and then maximizes $bold(phi.alt)^(*) = upright("max")_(bold(phi.alt)) L_2 ( bold(phi.alt) )$, with $L_2 ( bold(phi.alt) ) = sum_(j = 1)^k chevron.l phi_j | V^dagger ( bold(phi.alt) ) U^dagger ( theta^(*) ) H U ( bold(theta)^(*) ) V ( bold(phi.alt) ) | phi_j chevron.r$ and $V ( bold(phi.alt) )$ being a unitary that acts only on the Hilbert space of the $k$ lowest eigenstates. Then, for the maximized $bold(phi.alt)^(*)$, the $k$-th lowest eigenstate is given by $| psi_k chevron.r = U ( bold(theta)^(*) ) V ( bold(phi.alt)^(*) ) | phi_k chevron.r$. Besides general applications that involve excited states, state-averaged orbital-optimized VQEs (SA-OO-VQE) were proposed to treat chemical systems that require a "democratic description of multiple states" as for example necessary in the vicinity of conical intersections~@yalouz2021stateaveraged. Here, "democratic description" corresponds to treating degenerate or quasi-degenerate states at the same footing.


==== Multistate contracted VQE. 
<multistate-contracted-vqe.>
This algorithm combines the non-weighted SSVQE with the subspace expansion to find the ground state and excited states~@parrish2019quantum. First, one runs the non-weighted SSVQE routine to find the unitary $U ( bold(theta)^(*) )$ to find $k$ states that span the subspace of the $k$ smallest eigenvalues $| psi'_j chevron.r = U ( bold(theta)^(*) ) | phi_j chevron.r$. Then, to find the correct eigenstates, one runs the subspace expansion and measures the overlap matrix $H_(i j) = chevron.l psi'_i | H | psi'_j chevron.r$, and diagonalizes it to find estimates of the $k$ lowest eigenergies and eigenstates.


==== Fourier transform of evolution. 
<fourier-transform-of-evolution.>
Recent experiments have determined the spectra of molecular and many-body Hamiltonians using superconducting processors~@aleiner2020accurately @roushan2017spectroscopic @google2020hartree. A particular method to determine the eigenergies of Hamiltonians via Fourier transforming the dynamics of observables has been applied in~@aleiner2020accurately @roushan2017spectroscopic. The idea is to prepare a Fock state that has overlap with the eigenstates whose eigenvalues one wants to calculate. The Fock state is then evolved in time with the Hamiltonian and specific observables are measured over a range of time. The Fourier transform of the time evolution of the observables can be used to deduce the eigenenergies of the Hamiltonian.


==== Witness-assisted variational eigenspectra solver (WAVES). 
<witness-assisted-variational-eigenspectra-solver-waves.>
WAVES core idea is to use a single reference qubit as an eigenstate witness to variationally find the ground state and excited states~@santagati2018witnessing. A variational ansatz applied to a reference state is chosen. Then, the time evolution operator $U ( t ) = exp ( - i H t )$ is evolved on the ansatz state as a control unitary $C U ( t )$, with the control being the single qubit in a superposition state. Then, full tomography is performed on the single qubit to read out its von-Neumann entropy. If the variational state is an eigenstate of the Hamiltonian $H$, then the entropy is zero. Further, the energy of the state can be estimated from the state of the qubit as well. The ansatz is variationally updated using the information from the qubit in a iterative fashion until the ground state is found. Excited states can be found by applying an appropriate excitation operator on the found ground state, and then variationally minimizing the von-Neumann entropy of the qubit. As last step, the authors suggest to use the iterative phase estimation algorithm to further improve the accuracy of the excited state as well determine its eigenvalue. This method requires to implement a controlled time evolution operator, similar to non-variational proposals~@jensen2020quantum, which are considered to be challenging for larger systems on NISQ devices.


=== Hamiltonian simulation
<sec:hamilton_simulation>


A major application for quantum computers is the simulation of the dynamics of Hamiltonians for problems such as many-body physics and chemistry. One standard approach for quantum simulation of Hamiltonians is based on the Trotter-Suzuki expansion from @eq:trotter, where the evolving unitary is split up into small discrete timesteps of efficiently implementable unitaries, which can be run on the quantum computer. Naturally, the depth of the quantum circuit increases polynomially with the desired time to be evolved and target accuracy, which may not be feasible on NISQ devices without access to error correction. The relevant algorithms are reviewed in the following. We remark that some necessary tools to simulate many-body interaction Hamiltonian ~@menke2019automated @bravyi2008quantum have also been proposed.


==== Variational quantum simulator. 
<variational-quantum-simulator.>
VQA have been proposed to solve dynamical problems in the NISQ era~@li2017efficient. The core idea is to iteratively update an efficiently implementable variational quantum state $| psi ( bold(theta) ) chevron.r$ with a new set of parameters $bold(theta) arrow.r bold(theta)'$ such that it minimizes the error between the actual time evolution $exp ( - i H delta t ) | psi ( bold(theta) ) chevron.r$ for a timestep $delta t$ and the updated variational state $| psi ( bold(theta)' ) chevron.r$. The rules to update the parameters $bold(theta)$ to solve the Schrödinger equation $i upright("d") / upright("d") t | psi ( t ) chevron.r = H | psi ( t ) chevron.r$ can be found by the variational McLachlan's principle $delta | | ( upright("d") / upright("d") t + i H ) | psi ( bold(theta) ) chevron.r | | = 0$ with $| | | psi chevron.r | | = sqrt(chevron.l psi | psi |) chevron.r$ and demanding that $bold(theta)$ remains real-valued. One finds a set of linear equations of motion $bold(A) dot(bold(theta)) = bold(C)$ with


$ A_(i , j) & = & upright("Re") ( partial_(theta_i) chevron.l psi ( bold(theta) ) | partial_(theta_j) | psi ( bold(theta) ) chevron.r ) ,\
C_i & = & upright("Im") ( partial_(theta_i) chevron.l psi ( bold(theta) ) | H | psi ( bold(theta) ) chevron.r ) thin . $


At a given step of the iteration, one needs to measure the elements of $bold(A)$ and $bold(C)$ using the Hadamard test or methods from @mitarai2019methodology (see @sec:measurement), and then update $bold(theta)$ with the solution of the linear equation of motion by a small timestep $delta t$. The solver can be combined with adaptive strategies to reduce the complexity of the Ansatz circuit~@zhang2020low @yao2020adaptive.


VQS has been applied on the IBM quantum processor to simulate energy transfer in molecules~@lee2021simulating as well as to simulate a time-dependent Hamiltonian~@lau2021quantum. A straightforward extension of the variational quantum simulator can be applied to solve the Schrödinger equation in imaginary time~@mcardle2019variational, for time-dependent problems~@yuan2019theory or for general linear differential equations~@endo2020variational @kubo2020variational. Its implementation to open quantum systems~@endo2020variational @yuan2019theory is discussed in @sec:OpenQuantumSystem. Using the hardware-efficient structure of the PQC, it is possible to reduce the cost of measuring the $bold(A)$ and $bold(C)$ matrices~@benedetti2020hardware. Alternatively, the projected - Variational Quantum Dynamics method (p-VQD) has been proposed to bypass the measurement of aforementioned matrices~@barison2021efficient @otten2019noise. Here, one variationally maximizes the fidelity between the PQC $| psi ( bold(theta) ) chevron.r$ and the Trotter evolved state $exp ( - i H delta t ) | psi ( bold(theta)' ) chevron.r$. The optimized PQC yields the state evolved by a time $delta t$. This algorithm is then repeated to gain evolution for longer times. By appropriately choosing the evolution time $delta t$, barren plateaus can be avoided~@haug2021optimal.


==== Subspace variational quantum simulator. 
<subspace-variational-quantum-simulator.>
The subspace variational quantum simulator (SVQS) @heya2019subspace builds upon the idea of the SSVQE @nakanishi2019subspace introduced earlier in @sec:var_excited. The core idea is to rotate the initial state to be evolved onto the low-energy subspace found by the weighted SSVQE, then evolve it in time within the subspace, and then apply the reverse mapping. First, run the weighted SSVQE by preparing $k$ initial states ${| phi_j chevron.r = sigma_j^x | 0 chevron.r}_(j = 0)^k$ which are orthogonal with each other ($chevron.l phi_i | phi_j | = chevron.r delta_(i , j)$) and lie in the computational subspace, as well as a PQC $U ( bold(theta) )$. Now as in the weighted SSVQE minimize @eq:SSVQE_weighted.


Then, prepare an initial state $| psi_(upright("in")) chevron.r$ to be evolved, which is encoded into the computational subspace by applying the Hermitian conjugate of the obtained circuit $U^dagger ( bold(theta) )$. Here, the evolution of the state in time is performed by applying single-qubit rotations on each qubit $cal(T) ( t ) = ⨂_j R_Z ( - E_j t )$, where ${ E_j }_j$ are the eigenenergies of the eigenstates ${ | E_j chevron.r }_j$ obtained by SSVQE earlier. Finally, the state $cal(T) ( t ) U^dagger ( bold(theta) ) | psi_(upright("in")) chevron.r$ in the computational subspace is reverse mapped by applying $U ( bold(theta) )$, giving the evolved state


$ | psi ( t ) chevron.r = U ( bold(theta) ) cal(T) ( t ) U^dagger ( bold(theta) ) | psi_(upright("in")) chevron.r thin . $


This method has the key advantage that since the evolution is directly implemented as simple rotations in the computational subspace, the circuit depth is independent of the evolution time to be simulated. However, the initial SSVQE optimization can be difficult, especially when one considers many eigenstates $k$.


==== Variational fast forwarding. 
<variational-fast-forwarding.>
Similar to the idea of the SVQS, variational fast forwarding (VFF) relies on the idea of evolving a quantum state in time $exp ( - i H t )$ within a diagonal subspace, such that an enhanced evolution time can be achieved @cirstoiu2020variational. First, a circuit that implements a small timestep of the desired evolution is implemented as $V ( delta t ) = exp ( - i H delta t )$. Then, an approximate diagonal factorization of $V ( delta t )$ is trained for a particularly structured variational circuit


$ U ( bold(theta) , bold(gamma) , delta t ) = W ( bold(theta) ) D ( bold(gamma) , delta t ) W^dagger ( bold(theta) ) thin . $


Here, $D ( bold(gamma) , delta t )$ is composed of commuting unitaries and chosen to parameterize the eigenvalues of unitary $V ( delta t )$, whereas $W ( bold(theta) )$ represents its eigenvectors. Then, the evolution to an arbitrary time $T = N delta t$, where $N$ is some integer, is found by fast forwarding with $U ( bold(theta) , bold(gamma) , N delta t ) = W ( bold(theta) ) D^N ( bold(gamma) , delta t ) W^dagger ( bold(theta) )$. For the training of the variational Ansatz, the fidelity between $V ( delta t )$ and $U ( bold(theta) , bold(gamma) , delta t )$ is maximized by a quantum-classical feedback loop with a cost function that uses the local Hilbert-Schmidt test~@khatri2019quantum. As alternative approach, it was proposed to diagonalize the Hamiltonian $H$ instead of the unitary $V ( delta t )$, and fast forward via $U ( bold(theta) , bold(gamma) , T ) = W ( bold(theta) ) exp ( - i D ( bold(gamma) ) T ) W^dagger ( bold(theta) )$ ~@commeau2020variational. Fast-forwarding can also be performed without requiring to train via a feedback loop using the linear combination of states approach (@eq:IQAE_Ansatz)~@lim2021fast.


==== Quantum Assisted Simulator. 
<sec:quantum_assisted_simulator>
The VQS algorithm employs a classical-quantum feedback loop to update the parameters of the PQC. Until the classical processor has calculated its output, the classical-quantum feedback loop delays any use of the quantum device, slowing the algorithm on current cloud computing framework. The VQS algorithm, as well as its VQE based variant, i.e. SVQS share similarities and most of the concerns faced by VQE, such as the barren plateau issue (see @sec:BP). Further, the VQS algorithm requires controlled-unitaries, which make it difficult to realize for current-term devices. To tackle the issues faced by VQS, the quantum assisted simulator (QAS) was suggested recently~@bharti2020quantum. The QAS algorithm does not need any classical-quantum feedback loop, can be parallelized, evades the barren plateau problem by construction, supplies a systematic approach to constructing the ansatz and does not require any complicated unitaries.


The QAS algorithm shares its approach with IQAE (see @sec:IQAE). The ansatz is given as a linear combination of states $| phi.alt (bold(alpha) ( t )) chevron.r = sum_(| psi_i chevron.r in bb(C S_K)) alpha_i ( t ) | psi_i chevron.r$ (see @eq:IQAE_Ansatz), with classical coefficients $bold(alpha) ( t )$ for ansatz state $| psi_i chevron.r$, which can be systematicly constructed (see @def:cumulant_states). The Hamiltonian $H$ is given as a linear combination of unitaries (see @eq:LCU_Ham). The QAS algorithm employs Dirac-Frenkel principle to obtain the following classical evolution equation for $bold(alpha) ( t )$


$ cal(E) frac(partial bold(alpha) ( t ), partial t) = - iota cal(D) bold(alpha) ( t ) . $<eq:Dirac_Frenkel_QAS>


Here, $cal(E)_(i , j) = chevron.l psi_i | psi_j chevron.r$ and $cal(D)_(i , j) = sum_k beta_k chevron.l psi_i | U_k | psi_j chevron.r$ are overlap matrices that can be efficiently measured on a quantum computer, i.e. for $H$ given as combination of Pauli strings, the overlaps are measurement of Pauli strings.


Recently, QAS was run on the IBM quantum computer and showed superior performance compared to Trotter and VQS for a time-dependent Hamiltonian~@lau2021quantum. A novel Hamiltonian simulation algorithm based on truncated Taylor series was proposed recently~@lau2021nisq. The classical post-processing in the aforementioned algorithm corresponds to a QCQP.


=== Quantum information scrambling and thermalization
<quantum-information-scrambling-and-thermalization>


Quantum information scrambling is a quantum phenomena occurring when initially local states become increasingly non-local with the time-evolution of the system. It can be analyzed by computing the so-called out-of-time-ordered correlation function (OTOC) and has strong implications in thermalization in closed quantum systems dynamics. Recent experiments have been carried out to study this phenomena in a few qubits trapped-ion devices and simulators @landsman2019verified @joshi2020quantum, and in a 53 superconducting qubit processor @mi2021information. The algorithms proposed are based on the well-known teleportation algorithm and use single and two-qubit gates to reproduce the the scrambling process.


In the context of VQAs, a variation of the VQE algorithm has been proposed to obtain the thermal evolution of quantum systems @verdon2019quantum. The authors present the Quantum Hamiltonian-Based Models (QHBM), an extension of the VQA's PQC to mixed states instead of pure states. Within this approach, the QHBM are classically trained to learn a mixed state distribution as a function of the optimization parameters. A direct application of such a model is the Variational Quantum Thermalizer (VQT), an algorithm which goal is to prepare a fixed-temperature thermal state of a given Hamiltonian.


The limitations of using variational QML algorithms to learn a scrambling unitary have also been studied in @holmes2020barren, where it is found trainability issues related with barren plateaus (see @sec:BP).


=== Simulating open quantum systems
<sec:OpenQuantumSystem>


In the following, we deal with the physics of open quantum systems @huh2014linear which are well-described by the Lindblad master equation from @eq:ch4:Lindblad_master_eq. By sampling from a mixture of pure state trajectories evolved by a non-Hermitian Hamiltonian and random quantum jumps, one recovers the Lindblad dynamics.


==== Trotter simulation of open systems. 
<trotter-simulation-of-open-systems.>
NISQ quantum hardware can be used to directly simulate the dynamics of small-scale open systems by using ancillas combined with measurements in the spirit of the quantum jump method~@koppenhofer2020quantum @hu2020quantum. Here, the unitary part of the dynamics is implemented via a Suzuki-Trotter decomposition (see @sec:PQC). The non-unitary part of the dynamics that encodes the interaction with the external degrees of freedom is simulated by entangling the circuit with ancillas and subsequently measuring them. For every time step of the dynamics a new set of ancilla qubits has to be provided. Current quantum computers based on superconducting circuits do not allow one to measure and re-use qubits, thus requiring a linear increase in the number qubits with every timestep. Further, in general the circuit depth scales polynomially with simulation time.


==== Generalized variational quantum simulator. 
<generalized-variational-quantum-simulator.>
In Ref.~@endo2020variational the VQS algorithm is extended to simulate the method of quantum jumps in a variational setting. They implemented the algorithm for 2D Ising Hamiltonians for $6$ qubits and observed a dissipation induced phase transition. In another work @yuan2019theory, VQS is extended to mixed states and simulate the Lindblad dynamics fully without the need of stochastic sampling. The idea is to write the density matrix as $rho = rho (bold(theta) (t))$ and simulate the evolution of $rho$ via evolution of the parameters $bold(theta) ( t ) .$ One can re-express @eq:ch4:Lindblad_master_eq as $frac(d, d t) rho = sum_i g_i S_i rho T_i^dagger$, where $S_i$ and $T_i$ are unitaries and $g_i$ are coefficients. Using Dirac and Frenkel equation, the evolution of parameters is given by


$ sum_j M_(i , j) dot(theta_j) = V_i ,\
M_(i , j) = upright("Tr") \[(partial_i rho (bold(theta) ( t )))^dagger partial_j rho (bold(theta) ( t ))\]\
V_i = upright("Tr") \[(partial_i rho (bold(theta) ( t )))^dagger sum_j g_j S_j rho T_j^dagger\] thin . $<eq:Frenkel_evolution_1>


This method can also be extended to deep quantum neural network type Ansatzes~@liu2020solving.


These algorithms, however, suffer from the canonical drawbacks of the VQS algorithm, such as the requirement of feedback loop, trainability issues and necessity of controlled unitaries.


==== Generalized quantum assisted simulators. 
<generalized-quantum-assisted-simulators.>
Recently, the generalized quantum assisted simulator (GQAS)~@haug2020generalized was proposed as extension of the quantum assisted simulator to tackle above issues (see @sec:quantum_assisted_simulator). Instead of using a density matrix, the GQAS algorithm introduced the concept of "hybrid density matrix"


$ hat(rho) = sum_(k , l) beta_(k , l) | psi_k chevron.r chevron.l psi_l | $<eq:Hybrid_density_matrix>


for $beta_(k , l) in bb(C)$ and $| psi_l chevron.r$ are chosen from the set of cumulative $K$ moment states (see @def:cumulant_states). A classical device stores the coefficients $bold(beta)$ and the quantum states correspond to some quantum register. A hybrid density matrix is a valid density matrix, if $upright("Tr") (hat(rho)) = 1$ and $hat(rho) succ.curly.eq 0 .$ Note that the normalization condition is fulfilled when $upright("Tr") (hat(rho)) = upright("Tr") (bold(beta) cal(E)) = 1 ,$ where $cal(E)_(k , l) = chevron.l psi_k | psi_l chevron.r .$ Using Dirac-Frenkel principle, the simulation of open system dynamics for the hybrid density matrix is given by


$ cal(E) frac(upright("d"), upright("d") t) bold(beta) ( t ) cal(E) = - iota ( cal(D) bold(beta) ( t ) cal(E) - cal(E) bold(beta) ( t ) cal(D) ) +\
sum_(n = 1)^K gamma_n ( cal(R)_n bold(beta) ( t ) cal(R)_n^dagger - 1 / 2 cal(F)_n bold(beta) ( t ) cal(E) - 1 / 2 cal(E) bold(beta) ( t ) cal(F)_n ) , $<eq:GQAS_Dirac_Frenkel>


where $cal(D)_(k , l) = chevron.l psi_k | H | psi_l chevron.r$, $cal(R)_(k , l)^n = chevron.l psi_k | L_n | psi_l chevron.r$ and $cal(F)_(k , l)^n = chevron.l psi_k | L_n^dagger L_n | psi_l chevron.r$. For a given choice of ansatz, the quantum computers only have to compute the overlap matrices as measurements of Pauli strings. Then, the classical computer uses this information to simulate the dynamics. There is no quantum-classical feedback loop, which on the currently available quantum computers can speed up computations substantially.


=== Nonequilibrium steady state
<sec:nonequilibrium>
Unlike the previous @sec:OpenQuantumSystem, we concern the physics of open quantum system that is out-of-equilibrium in nature, which is common in designing devices for molecular-scale electronics @xiang2016molecular, excitonic transport @kyaw2017parity as well as quantum thermodynamics @vinjanampathy2016quantum. By "out-of-equilibrium", we mean that a quantum system and bath/s are constantly driven by external forces such as voltage differences, during which the composite particles of the system and bath are also interacting each other.


Notice that the method used in the previous @sec:OpenQuantumSystem would also lead to extremely high dimensional matrices in the Lindblad like master equation approach $d hat(rho) / d t = hat(hat(cal(L))) hat(rho)$ (see @ch4:subsubsec:ZNE, @eq:ch4:Lindblad_master_eq), and it deems impossible to capture all the degrees-of-freedom involved. However, one may relax some of the constraints involved in the problem setup, say time-independent dissipation and non-interaction among particles with small system size. The steady state density matrix of a quantum system $hat(rho)_(upright("SS"))$ at the limit $t arrow.r oo$ is then given by solving


$ hat(hat(cal(L))) | hat(rho)_(upright("SS")) chevron.r = 0 , $


or equivalently $hat(hat(cal(L)))^dagger hat(hat(cal(L))) | hat(rho)_(upright("SS")) chevron.r = 0$. A recent study @yoshioka2020variational has shown that with ancilla qubits, the above non-Hermitian superoperator $hat(hat(cal(L)))$ can be simulated. The main idea is to map the density matrix of $N$ qubits onto a vector of twice the number of qubits $2 N$


$ hat(rho) = sum_(i j) rho_(i j) | i chevron.r chevron.l j | arrow.r | hat(rho) chevron.r = sum_(i j) rho_(i j) / C | i chevron.r_P | j chevron.r_A , $


where $C = sqrt(sum_(i j) | rho_(i j) |^2)$. By using a digital quantum computer and the variational approach one iteratively minimize the expectation value of a parameterized density matrix $| rho_(bold(theta)) chevron.r = U ( bold(theta) )$ with $upright("min")_(bold(theta)) chevron.l 0 |^(⊗ 2 N) U^dagger ( bold(theta) ) hat(hat(cal(L)))^dagger hat(hat(cal(L))) U ( bold(theta) ) | 0 chevron.r^(⊗ 2 N)$. A drawback of this approach is that measuring expectation values from the parameterized density matrix directly is difficult and thus requires an additional transformation.


Beyond the Lindblad master equation, to capture and describe truly "out-of-equilibrium" processes, the nonequilibrium Green's function (NEGF) formalism @stefanucci2013nonequilibrium @dalla2013keldysh @sieberer2016keldysh is commonly used. These existing Green's function techniques are very complicated to be solved. Many assumptions need to be made in order to have some closed form and do some calculations. In particular, it requires that the interaction among particles are weak such that one does not need to find higher-order Feynman diagrams in finding the self-energy functional.


Since some of the existing quantum algorithms provide promising speedup over classical ones, one may wonder to use quantum algorithms to solve the NEGF, with a strategy of leaving classically hard computational tasks to the quantum processor and feeding its output back to classical computer, which could be done in a variational fashion. There exists a number of proposals @kreula2016non @jaderberg2020minimum @endo2020calculation in the literature that undertake such hybrid quantum-classical approach. However, these methods assume no interaction among composite particles. In generic open quantum system in which many-body effects cannot be neglected, one would like to go beyond those assumptions. It is yet to see any quantum advantage of those near-term quantum algorithms over existing methods @hartle2008multimode @li2016resummation @fitzpatrick2017observation for solving nonequilibrium steady state solution of an extremely complex physical setup such as vibrationally-coupled electron transport with multiple electronic levels @hartle2008multimode.


=== Gibbs state preparation
<sec:gibbsstate>
Finding the ground state of quantum Hamiltonians is known to be QMA-hard. Under reasonable assumptions, preparing Gibbs state corresponding to arbitrarily small temperatures is as challenging as the Hamiltonian ground state problem. Gibbs state preparation has applications in many areas including quantum annealing, quantum SDP solvers, Boltzmann training and simulation of equilibrium physics. For a Hamiltonian $H ,$ the Gibbs state at temperature $T$ (with $k_(upright("B")) = 1$) is given by


$ rho ( T ) = frac(exp (- H / T), upright("Tr") (exp (- H / T))) . $<eq:Gibbs_state>


Some of the approaches to prepare Gibbs state are mentioned in the following

+ Starting with $d$-dimensional maximally mixed state $I_d / d$, under imaginary time evolution for time $tau ,$ one gets Gibbs state corresponding to temperature $T = frac(1, 2 tau)$~@verstraete2004matrix.

+ One can start with maximally entangled state $| xi chevron.r_d = 1 / sqrt(d) sum_j | j , j chevron.r_(A B)$ of a system combined of two equally sized subsystems A and B, and evolve it under imaginary time evolution using Hamiltonian $H ⊗ I .$ After tracing out system $B$, the state of system $A$ at time $tau$ is given by Gibbs state corresponding to temperature $T = frac(1, 2 tau) .$

+ The Gibbs state of a system is the density matrix which corresponds to minimum of its free energy. Thus, one can variationally tune the parameters of a parametrized density matrix such that it leads to minimization of free energy.

Recently, a few NISQ algorithms for Gibbs state preparation have been proposed, which apply the aforementioned ideas. In @yuan2019theory, authors used VQS based imaginary time evolution to prepare Gibbs state following the second approach. The first approach does not work in VQS based imaginary time evolution. In another work @chowdhury2020variational, the third approach was used to prepare Gibbs states. The aforementioned works require complicated controlled unitaries and classical-quantum feedback loop. In @haug2020generalized, QAS based imaginary time evolution (see @sec:quantum_assisted_simulator) was suggested to prepare the Gibbs state with either first and second approach. The QAS approach does not require any classical quantum feedback loop or complicated controlled unitaries. Using random circuits as initial state, ~@richter2020simulating suggested an approach based on imaginary time evolution prepare Gibbs state.


=== Simulation of topological phases and phase transitions
<simulation-of-topological-phases-and-phase-transitions>
NISQ devices can be used to study the ground states of quantum Hamiltonians for understanding topological phases and phase transitions. An important example is the one-dimensional cluster Ising Hamiltonian, describing a symmetry-protected topological phase of matter. The ground state of this Hamiltonian is the one-dimensional cluster state, which can be created by applying Hadamard gates to all qubits, followed by control-Z gates on each pair of neighboring qubits. State tomography and symmetry arguments were used to study the entanglement measures of this state and to highlight its topological nature~@choo2018measurement @azses2020identification. A modified algorithm was implemented to simulate an enlarged family of Hamiltonians and study the quantum phase transition between a topological and a topologically-trivial phases of matter~@smith2019crossing. NISQ devices were also used to simulate the dynamics of fundamental models of quantum magnetism~@bassman2020towards @smith2019simulating and topological phases in one and two dimensions~@mei2020digital.


=== Many-body ground state preparation
<many-body-ground-state-preparation>


The preparation of non-trivial many-body quantum states is crucial for many applications in quantum metrology and quantum information processing @kyaw2014measurement. QAOA has been used as a resource-efficient scheme for many-body quantum state preparation. In this context, the state $| psi chevron.r$ for a system with linear dimension $L$ (e.g. $L$ can refer to the number of spins in a 1D spin chain) is non-trivial if there is no local unitary circuit $U$ with depth $cal(O) ( 1 )$ which can generate $| psi chevron.r$ from a product state $| phi.alt chevron.r$: $| psi chevron.r = U | phi.alt chevron.r$ @ho2019efficient. The Greenberger-Horne-Zeilinger (GHZ) state, which is an essential resource in several quantum metrology proposals @dur2014improved @geza2014quantum, is an example of a non-trivial quantum state due to its highly-entangled nature, and is the ground state of the 1D Ising Hamiltonian with periodic boundary conditions, i.e. $H_P = - sum_(i = 1)^L hat(sigma)_z^i hat(sigma)_z^(i + 1)$


Using QAOA, it has been shown that the GHZ state can be prepared efficiently with perfect fidelity using $p = L / 2$, where $p$ is the QAOA depth @ho2019efficient. The authors conjectured that the ground state of the 1D transverse-field Ising model


with $L$ even and periodic boundary conditions, can be prepared perfectly at any point in the phase diagram using QAOA with $p = L / 2$. The ground state of the antiferromagnetic Heisenberg model with open boundary conditions $H_P = sum_(i = 1)^(L - 1) hat(bold(sigma))^i dot.op hat(bold(sigma))^(i + 1)$,


where $hat(bold(sigma))^i equiv ( hat(sigma)_x^i , hat(sigma)_y^i , hat(sigma)_z^i )$, has also been prepared with near perfect fidelity using QAOA. Using a long-range 1D Ising Hamiltonian $H_P = - sum_(i < j) J_(i j) hat(sigma_z)^i hat(sigma)_z^j$,


where $J_(i j) = J_0 / | i - j |^alpha$, QAOA can achieve the ultrafast preparation of a GHZ state with a circuit depth of $cal(O) ( 1 )$ (for $alpha = 0$) @ho2019ultrafast. This result was generalized by @wauters2020polynomial, which showed that QAOA can prepare the ground states of the fully-connected ferromagnetic $q$-spin model (note that $q$ is used here instead of the conventional $p$ in order to avoid confusion with the QAOA depth $p$)


$ H = - 1 / N^(q - 1) ( sum_(i = 1)^N hat(sigma)_z^i )^q - h ( sum_(i = 1)^N hat(sigma)_x^i ) $


with resources scaling polynomially with the number of spins $N$. Since the system can encounter a first-order phase transition where the spectral gap becomes very small, QAOA greatly outperforms quantum annealing in this instance since an exponentially long annealing time is needed.


=== Quantum autoencoder
<quantum-autoencoder>


The quantum autoencoder~@romero2017quantum (QAE) is a VQA for the compression of data on a quantum computer. It finds a new data state representation which requires fewer qubits than the data was originally defined upon. This new encoding is said to be a representation in the #emph[latent space]. The process of transforming the data into the latent space is referred to as #emph[encoding], and the converse, transformation of states in the latent space back onto the original, is known as #emph[decoding].


Training a QAE requires the minimization of an objective defined over several related quantum states. For a set of $n$-qubit states ${ | psi chevron.r_i }$, the goal of the QAE is to find a unitary circuit $cal(E) ( bold(theta) )$ which accomplishes the following transformation


$ E : cal(H)^n arrow.r cal(H)^k ⊗ cal(H)^(n - k) | E | psi chevron.r_i = | phi.alt chevron.r_i ⊗ | 0 chevron.r^(⊗ ( n - k )) , $


where $k$ is the dimension of the latent space. Thus, the application of a perfectly trained autoencoder to any state of the relevant set yields a product state that consists of the transformed state on $k$ qubits with a $( n - k )$-qubit "trash" state. In principle, the trash state could be any state, but the all-zero state is chosen for simplicity.


The loss function of the QAE may be defined in several ways. It is a fidelity loss function (see @sec:objective_function), in which minimization is performed by increasing the overlap between a (partial) measurement of the state resulting from the application of the encoder and a known state. The most practical definition for training the autoencoder, called "trash training", uses as its objective the overlap between the "trash" qubits and the $| 0 chevron.r^(⊗ ( n - k ))$ state. Formulated in the density matrix picture, the objective of minimization is


$ O = - upright("Tr") ( I^(⊗ k) ⊗ | 0 chevron.r chevron.l 0 |^(⊗ ( n - k )) rho_i ) , $


where $rho_i = sum_i p_i | psi_i chevron.r chevron.l psi_i |$ with, in general, all states in the set equally weighted.


The QAE can be trained by training only the encoding circuit, due to the unitarity of the encoder; the decoding operation is achieved by the complex conjugate of the encoder circuit. Improvements in the encoding results translates to improvements in the decoder, a boon not possessed by classical autoencoders.


After the successful training of a QAE, the encoder and decoder circuits may be used for data transformation in further algorithms, action upon the data in the latent space, in which the data is represented more densely, may prove powerful in further applications.


A data re-uploading strategy to construct a QAE encoder is presented in @bravo2020quantum2, where the so-called enhanced feature quantum autoencoder (EF-QAE) is trained to compress the ground state of the 1-D Ising model as a function of the external field and samples of handwritten digits. The QAE has also been deployed experimentally in the compression of qutrits on a photonic device~@pepper2019experimental. Small states have been experimentally compressed losslessly on photonic devices by @huang2020realization. @bondarenko2020quantum designed a QAE capable of denoising entangled quantum states, such as GHZ or W states, subject to spin flip errors and random unitary noise.


=== Quantum computer-aided design
<sec:quantum_aided_design>


Two recent proposals focus the computing power of NISQ devices back on the processors themselves: Techniques were developed to simulate quantum hardware on a quantum computer @kottmann2020quantum @kyaw2020quantum. They establish the paradigm of "quantum computer-aided design", indicating that classically intractable simulations of quantum hardware properties can be performed on a quantum computer, thereby improving the prediction of device performance and reducing experimental testing cycles.


In the first approach, optical path modes are mapped to sets of qubits, and quantum optical elements are mapped to digital quantum circuits that act on the qubits @kottmann2020quantum. Photonic setups can then be flexibly simulated. The framework is used to simulate both a Boson sampling experiment and the optimization of a setup to prepare a high-dimensional multipartite entangled state.


The second proposal introduces quantum simulation techniques for superconducting circuit hardware @kyaw2020quantum. A circuit module consisting of coupled transmon qubits is designed. The corresponding superconducting circuit Hamiltonian, which is written in a basis of multi-level operators, is efficiently mapped to a set of data qubits @sawaya2020resource. Simulations of a multi-level extension to the VQE algorithm @higgott2019variational are used to determine the spectrum of the superconducting circuit. The resulting states and eigenenergies are directly related to experimentally relevant device characteristics and can be used to seed simulations of time dynamics.


Device and setup design is a key challenge in improving and scaling quantum systems. Therefore, digital quantum simulation of quantum processors will be a relevant application for NISQ quantum computers as classical resources become too small to capture the relevant Hilbert space of the hardware.


== Machine learning
<sec:QML>


The goal of machine learning is to facilitate a computer to act without being explicitly programmed to. As per Tom Mitchell~@mitchell1997machine, given some class of tasks $cal(T)$ and performance metric $cal(P)$, a computer program is said to learn from experience $cal(E)$ if


$ cal(P) ( cal(T) ) prop cal(E) , $


i.e. its performance measured by $cal(P)$ for task #strong[$cal(T)$] increases with $cal(E)$.


Depending on the kind of experience $cal(E)$ permitted to have during the learning process, the machine learning algorithms are classified into three categories:

+ #emph[Supervised learning.] Given a function $y = f ( x ) ,$ the goal is to learn $f$ so that it returns the label $y$ for the unlabelled data $x .$ A canonical example would be pictures of cats and monkeys, with the task to recognize the correct animal. Given training examples from the joint distribution $P ( Y , X )$, the task of supervised learning is to infer the probability of a label $y$ given example data, $x$, i.e., $P (Y = y | X = x)$.

+ #emph[Unsupervised learning.] The data is provided without any label. The task is to recognize an underlying pattern in this data. Given access to several examples $x in X$ the algorithm goal is to learn the probability distribution $P ( X )$ or some important properties of the aforementioned distribution.

+ #emph[Reinforcement learning.] In this case, neither data nor label is provided. The machine has to generate data and improve the aforementioned data generation process via optimizing a given reward function. This is similar to how a human child learns to walk. If it fails, the output acts as a negative reward.


Machine learning has uncovered applications in physics such as Monte Carlo Simulation~@huang2017accelerated @liu2017self, many-body physics~@carleo2017solving, phase transition~@wang2016discovering, quantum foundations~@bharti2019teach, and state tomography~@torlai2018neural.


For a meticulous review on machine learning for physics, refer to~@carleo2019machine @dunjko2018machine @bharti2020machine.


Most of the success in machine learning come from the use of artificial neural networks, structures capable of learning sophisticated distributions and that encompass multiple features that can be fine-tuned depending on the problem to tackle. In that direction, there are several proposals to define a model for quantum neural networks with different kind of activation functions~@schuld2014quest @wan2017quantum @torrontegui2019unitary. For implementations of artificial neuron and artificial neural network on the NISQ hardware, refer to~@tacchino2019artificial @tacchino2020quantum.


The merger of quantum theory and machine learning has recently led birth to a new discipline, known as quantum machine learning (QML). Both algorithms that deal classically with data from a quantum origin and quantum algorithms that process quantum and classical data are usually known as QML applications. However, in this review, we will focus only on those algorithms that process data quantum-mechanically, in particular, those that use quantum algorithms that can be run in NISQ computers. For QML review that mainly focus on fault-tolerant quantum algorithms check~@biamonte2017quantum. For a survey of quantum computational learning theory, refer to~@arunachalam2017survey. An analysis of QML from a classical ML perspective can be found at @ciliberto2018quantum @dunjko2018machine, and for near-term devices in @perdomo2018opportunities @benedetti2019parameterized @li2021recent.


It might be surprising that a linear theory as quantum physics can generate the non-linearities that a machine learning model needs. However, the linearity of quantum mechanics comes from the dynamical part (quantum states evolution) and one can encounter multiple sources of non-linearities arising from measurement, post-selection or coupling the system with environment. Quantum operations in the Hilbert space can also encode non-linear behaviour, as it will be shown with Kernel methods.


In the following subsections, we will present the quantum mechanical analogs of the three machine learning categories defined above. The algorithms discussed will be listed in @tab:ml_algorithms.


=== Supervised learning
<sec:SL>


The two prominent methods to perform a supervised learning classification task using a NISQ computer are #emph[quantum Kernel estimation] @schuld2019quantum @havlivcek2019supervised @kusumoto2019experimental @huang2021power and #emph[Variational Quantum Classifier] (VQC)~@farhi2018classification @mitarai2018quantum.


Classical Kernel methods include well-known machine learning algorithms such as Support Vector Machines (SVM) @cortes1995support, Principal Component Analysis (PCA) or Gaussian Processes, among others. The rich theoretical structure of Kernel methods can be expanded to the quantum world by defining and working in the Hilbert space with the quantum equivalent of feature vectors @schuld2019quantum. To that aim, one needs to modify and adapt the well-known theorems to work in a quantum feature space. For more details about classical Kernel methods we refer to @hofmann2008kernel. A review on Kernel methods in the context of QML can be found in @mengoni2019kernel. In the following lines, we will directly describe the quantum versions of them. The basics of supervise learning with quantum computers are presented in~@schuld2018supervised.


Given an input set $cal(X)$ and quantum Hilbert space $cal(H)$, data $bold(x) in cal(X)$ is encoded into a quantum state (#emph[quantum feature vector]) $| Phi ( bold(x) ) chevron.r$ by means of the #emph[quantum feature map], i.e. $Phi : cal(X) arrow.r cal(H)$. The inner product of two quantum feature vectors defines a kernel


$ kappa (bold(x)_i , bold(x)_j) equiv ⟨Phi (bold(x)_i) | Phi (bold(x)_j)⟩_(cal(H)) , $


for $bold(x)_i , bold(x)_j in cal(X)$. In comparison with classical kernels, the inner product is defined in a Hilbert space by replacing the standard definition $chevron.l dot.op , dot.op chevron.r$ by the Dirac brackets $chevron.l dot.op | dot.op chevron.r$. For a map $Phi$, the #emph[reproducing kernel Hilbert space] takes the form


$ cal(R)_phi.alt = (f : cal(X) arrow.r bb(C) | med f ( bold(x) ) = ⟨w | Phi ( bold(x) )⟩_(cal(H)) , forall bold(x) in cal(X) , | w chevron.r in cal(H)) . $<eq:RKHS>


The orthogonality of $| w chevron.r$ w.r.t. $| Phi ( bold(x) ) chevron.r$ defines a decision boundary, i.e. depending on the sign of the inner product, $bold(x)$ lies in one side of the hyperplane. The function $f$ is thus a linear function in $cal(H)$. The #emph[representer theorem] @Scholkopf2001generalized states that this function can be approximated by the linear function $f^star.op$ by using the kernel defined above, i.e.


$ f^star.op ( bold(x) ) = sum_(i = 1)^(cal(D)) alpha_i kappa (bold(x) , bold(x)_i) $<eq:representer_theorem>


for an input dataset $cal(D)$. Using @eq:representer_theorem, one can solve a convex optimization problem to get the coefficients $alpha_i$. The analysis so far entails the connection between linear models in reproducing kernel Hilbert space with kernelized models in the input space.


One can use a quantum computer to calculate the inner product of feature mapped quantum states to obtain the kernel $kappa$. This kernel can be fed to a classical device, which can use @eq:representer_theorem to obtain the coefficients $alpha_i$, for instance, by maximizing a cost function of the form @havlivcek2019supervised


$ C ( bold(alpha) ) = sum_(i = 1)^(cal(D)) alpha_i - 1 / 2 sum_(i , j)^(cal(D)) y_i y_j alpha_i alpha_j kappa (bold(x)_i , bold(x)_j) , $


where $y_i$ are the labels of the training points and constrained to $sum_(i = 1)^(cal(D)) alpha_i y_i = 0$. Ideas based on connections between kernel methods and quantum circuit based machine learning has been used to justify that the models for QML can be framed as kernel methods~@schuld2021quantum. For some of the other relevant works on quantum kernel methods, refer to~@park2020theory @blank2020quantum. A high-dimensional data classification experiment with quantum kernel methods was carried out recently~@peters2021machine. The encoding of data into quantum circuits is characterized by the quantum Fisher information metric~@haug2021largescale. For hardware efficient PQCs, the kernel can be related to radial basis function kernels~@haug2021optimal @haug2021largescale. Measuring the quantum kernel using the SWAP or inversion test scales as $cal(D)^2$. Using randomized measurements~@elben2020cross, the kernel can be computed in a time that scales linearly with the dataset size $cal(D)$, which allows for processing large datasets with quantum computers~@haug2021largescale.


Also, a Gaussian Boson Sampling device (see @sec:GBS) can be used for computing kernel functions @schuld2020measuring.


Another approach is to use a variational circuit $U ( bold(theta) )$ and directly perform the classification task in the reproducing kernel Hilbert space, without using @eq:representer_theorem. This approach is sometimes referred as a variational quantum classification. Data is also embedded into the state $| Phi ( bold(x) ) chevron.r$ and then processed with a PQC $U ( bold(theta) )$. The resultant state becomes


$ | Psi ( bold(x) , bold(theta) ) chevron.r = U ( bold(theta) ) | Phi ( bold(x) ) chevron.r , $<eq:VQC_state>


which parameters are estimated by training it to match the target states $| y_i chevron.r$ that represent the $y_i$ labels of the training points, i.e. by minimizing the infidelity


$ C ( bold(theta) ) = sum_(i = 1)^(cal(D)) (1 - | chevron.l y_i | Psi ( bold(x)_i , bold(theta) ) chevron.r |^2) . $<eq:VQE_cost>


Both methods require a way to encode the data into a quantum state. There are several strategies to define the quantum feature map. It is a key step in the success of the classification task, as the needed non-linearities must come from it. Furthermore, to eventually obtain any quantum advantage, one should search from the set of classically intractable feature maps. One of the first proposed approaches was the amplitude encoding ~@schuld2016prediction also required in other quantum algorithms @harrow2009quantum. This approach encodes the classical data points into the amplitudes of a quantum state, i.e. $| Phi ( bold(x) ) chevron.r = sum_i x_i | e_i chevron.r$, where $| e_i chevron.r$ are the basis states. However, this raw encoding requires #emph[i)] knowing which gates can be used to perform this operation for general data points and #emph[ii)] having an efficient way to extract and process these amplitudes. Although the first point can eventually be overcome by using similar approaches as the ones used to define a PQC, the second one requires tools as QRAM~@giovannetti2008quantum, experimentally challenging for the NISQ era. The studies towards QRAM in~@park2019circuit proposed an approach to update classical data consisting of $M$ entries of $n$ bits each using $O ( n )$ qubits and $O ( M n )$ steps. A #emph[forking-based] sampling scheme was suggested in~@park2019parallel to reduce the resource requirements for state preparation for tasks involving repeated state preparation and sampling. At the moment of writing, building a QRAM remains challenging and further investigations are required.


In general, the encoding strategies used in state-of-the-art algorithms consist on introducing the classical data points into the parameters of the quantum circuit gates. As briefly mentioned in @sec:PQC, one designs a state preparation circuit $E$ that encodes the data points,


$ | Phi ( bold(x) ) chevron.r = E ( bold(x) , bold(phi.alt) ) | 0 chevron.r . $<eq:encoding>


The use of $bold(phi.alt)$ parameters is optional and they can be subject to the optimization subroutine too.


Typically, the encoding gate is designed using the same structure of a layer-wise PQC from @eq:HE_ansatz. Data points are introduced in layers of single-qubit rotational gates $R$, as defined in @eq:def_single_qubit_rotation, followed by an entangling gate unitary $W$, e.g.


$ E ( bold(x) ) = product_(k = 1)^(L_E) (⨂_(i = 1)^n R_k ( bold(x)_i )) W_k , $


with $L_E$ being the total number of encoding layers. Then, the whole Variational Quantum Classifier (VQC) is composed by this encoding circuit and the processing one to be optimized, i.e. $U_(V Q C) ( bold(theta) , bold(x) ) = E ( bold(x) ) U ( bold(theta) )$.


Alternatively, some works propose to remove the distinction between the encoding $E$ and processing $U$ circuits and introduce the data values along the circuit @vidal2019input @perez2020data @lloyd2020quantum @schuld2020effect @nghiem2020unified. This strategy, sometimes called #emph[input-redundancy] or #emph[data-reuploading], introduce the data in all circuit layers, e.g.


$ U_(V Q C) ( bold(theta) , bold(x) ) = product_(k = 1)^L (⨂_(i = 1)^n R_k ( bold(x)_i , bold(theta) )) W_k , $


where $L$ is now the total number of circuit layers. This strategy has proved the universality when applied to one qubit @perez2020data and can reconstruct the coefficients of the Fourier series @vidal2019input @schuld2020effect.


The inclusion of encoding strategies and, in particular, the data re-uploading, can help well-known VQA such as the VQE. In general, one of the final goals of a VQE can be the identification of interesting points on a potential energy surface generated by a parametrized Hamiltonian. Often, one is interested in the ground state energy as a function of some Hamiltonian parameter $lambda$, e.g. the interatomic distance, but other properties, like the energy gap between ground state and first excited state can be interesting as well.~@kyaw2020quantum To do so, one often needs to scan discretely over $lambda$ for some particular interval and run a VQE to obtain the ground state energy on each of these points. This becomes an extra computational cost, especially if we are interested only in a particular region of this ground state profile, e.g. to extract the $lambda_(m i n)$ whose ground state has minimal energy. In that direction, some proposals suggest to encode the parameters of the Hamiltonian into the PQC and learn the energy profiles @mitarai2019generalization. In particular, the #emph[Meta-VQE] algorithm @cervera2020meta proposes to encode the $lambda$ into the PQC gates together with the optimization parameters. Then optimize an objective function that corresponds with the sum of expectation values for some $M$ training $lambda$ parameters, i.e. $chevron.l hat(O) chevron.r_(=) sum_(i = 1)^M chevron.l H chevron.r_(U ( bold(theta) , lambda_i ))$. Once the circuit has been optimized, one can run it again with the new $lambda_i$ to directly extract an estimation of the ground state, without having to optimize the full circuit again. An extension of this approach is the #emph[optimized Meta-VQE] (#emph[opt-meta-VQE]), which consist of using the optimized parameters from the Meta-VQE as starting points of a standard VQE. This tries to avoid vanishing gradients issues (discussed in @sec:BP) by starting in a particular region of the parameter space instead of random initialization.


Some VQC also need an extra piece, the definition of the target state $| y_i chevron.r$ to construct the objective function to be optimized using the fidelity with respect to these states. The goal of the quantum circuit is to divide and push the quantum states that encode the data points into two or more regions of the Hilbert space. To that aim, the parameters of the circuit are trained to match every encoded state into a particular representative of one of these regions. Therefore, the more separated these regions are, the lesser misclassified points are expected. As discussed in @sec:measurement, qubits measurement implies a certain computational cost. For that reason, many proposals suggest to use the state of only one qubit to train the whole circuit @farhi2018classification @schuld2020circuit. The cost function estimation reduces to measuring the probability distribution of one qubit. Other works use a more sophisticated definition of these target states by selecting the most orthogonal states of the qubits space @perez2020data @lloyd2020quantum. This strategy is inspired from optimal state discrimination @helstrom1969quantum.


Using the nonlinear character of quantum mechanical processes as "reservoir", the notion of #emph[quantum reservoir computing] has been suggested. The reservoir is a highly nonlinear system whose parameters are arbitrary but fixed. One can perform reservoir computing by employing a basic training algorithm such as linear regression at the readout stage. Since the reservoir parameters are fixed, only training of the readout stage parameters is required. The aforementioned idea helps utilize the high nonlinearities of the reservoir without the high computational cost of training. The concept of employing quantum systems as quantum reservoirs was first introduced in ~@fujii2017harnessing @nakajima2019boosting. Quantum reservoir computing has been proposed for many experimental platforms such as Gaussian states in the optical set-up~@nokkala2020gaussian, two-dimensional fermionic lattices~@ghosh2019quantum and nuclear spins~@negoro2018machine. Quantum gate based implementation of quantum reservoir computing for NISQ devices has also been discussed~@chen2020temporal. A Gaussian Boson Sampler (see @sec:GBS) can also be used for quantum reservoir computing as suggested in ~@wright2020capacity to perform machine learning tasks such as classification. NISQ devices have also been used for regression~@mitarai2018quantum. Distance-based classifier using quantum interference circuits has been proposed in ~@schuld2017implementing.


Quantum annealing has been also applied to supervised learning to predict biological data~@li2018quantum. Here, the quantum annealer is used to train the parameters of the classification model, which is done by mapping the problem of finding the optimal parameters to a minimization of a QUBO.


=== Unsupervised learning
<sec:unsupervised_learning>


The use of quantum devices to speed up different unsupervised learning tasks has been investigated thoroughly, leading to different algorithms for generative modelling @benedetti2016estimation @benedetti2017quantum @benedetti2019generative, clustering~@otterbach2017unsupervised, among others~@lloyd2013quantum. An analysis of quantum speedup in unsupervised learning for Fault-Tolerance algorithms is presented in @aimeur2013quantum. The task of learning probabilistic generative models in particular has been of interest to the QML community, because of the potential advantage quantum computers may exhibit over their classical counterparts in the near future @perdomo2018opportunities. For the advantages rendered by quantum correlations such as #emph[contextuality] and #emph[Bell non-locality] for generative modelling, refer to ~@gao2021enhancing.


Generative Modelling involves learning the underlying probability distribution from a finite set of samples from a data set, and generating new samples from the distribution. There have been several proposals for using parameterized quantum circuits as models for generative learning~@benedetti2019generative @benedetti2018quantum @amin2018quantum, including quantum Boltzmann machines, quantum circuit Born machines, quantum assisted Helmholtz machines, quantum generative adversarial networks, amongst others~@benedetti2019parameterized @amin2018quantum @benedetti2018quantum @benedetti2019generative. We discuss some of these proposals in detail hereafter.


==== Quantum Boltzmann Machines. 
<quantum-boltzmann-machines.>
The quantum Boltzmann machine @amin2018quantum (QBM) extends the classical Boltzmann machine~@ackley1985learning, a neural architecture capable of several tasks including generative modeling of data. Such models take their name from their physical inspiration, namely, the Boltzmann distribution over the Ising model in the classical case, and the Boltzmann distribution over the transverse-field Ising model, for the quantum case. Such a network consists of a mixture of #emph[visible] and #emph[hidden] vertices, connected by weighted edges. The visible vertices function as both input and outputs to the network, whilst the hidden vertices add extra degrees of freedom to the network.


The QBM can be modeled with the Hamiltonian


$ H = - sum_a^N ( b_a hat(sigma)_z^a + Gamma_a hat(sigma)_x^a ) - sum_(a , b) omega_(a b) hat(sigma)_z^a hat(sigma)_z^b , $<eq:QBM>


where $b_a$, $Gamma_a$, and $omega_(a b)$ are the parameters to be fine-tuned to generate the training data. Defining the density matrix $rho = e^(- H) / Z$ with $Z$ the usual partition function, $Z = upright("Tr") (e^(- H))$, the marginal probability that the visible variables are in some state $bold(v)$ is given by $P_v = upright("Tr") (Lambda_v rho)$, with $Lambda_v = (⨂_nu frac(1 + v_nu hat(sigma)_z^nu, 2)) ⊗ I_h$, a projector onto the subspace spanned by the visible variables tensor the identity acting on the hidden variables. The objective of training the QBM, then, is to get the family of probability distributions $P_v$ to match the family inherent to the data, $P_v^(upright("data"))$, for arbitrary $bold(v)$. This is achieved by minimizing the negative log-likelihood measure shown below


$ cal(L) = - sum_v P_v^(upright("data")) upright("log") frac(upright("Tr") Lambda_v e^(- H), upright("Tr") e^(- H)) thin . $


The gradients of $cal(L)$ with respect to the Hamiltonian parameters are difficult to calculate by sampling the Boltzmann machine, both classically and in the quantum variant. Methodologies of approximating these gradients are necessary to advance the deployment of QBM's.


The QBM may be trained both to be a generator, or a discriminator, with respect to the distribution it is trained to mimic. Consider the joint distribution of input and output variables $x$ and $y$ respectively. In the discriminative case, the objective is to minimize negative log-likelihood with respect to $P_(y | x)$, For generative learning, the goal is to learn the joint distribution $P_(x , y)$ directly.


The implementation of the QBM designed by @amin2018quantum found that a ten qubit QBM with only visible vertices is able to learn a mixture of randomly generated Bernoulli distributions more effectively than a classical Boltzmann machine, and performed better in generative applications. @kieferova2017tomography found that a QBM outperformed classical Boltzmann machines in generative training to reproduce small Haar-random states. Extensions to the QBM, such as the Variational Quantum Boltzmann Machine (VQBM) @zoufal2020variational, have improved upon trainability. Using ideas similar to ~@zoufal2020variational, VQBM were also proposed in ~@shingu2020boltzmann. In addition to its generative capacities, QBMs have shown potential in reinforcement learning @crawford2019reinforcement, in which they have been shown to achieve better fidelity to data distributions than do restricted Boltzmann machines or deep Boltzmann machines (classical boltzman machines with layers of hidden vertices) of similar sizes. To suit NISQ devices,~@verdon2017quantum suggested that QBM can be approximated using QAOA as a subroutine in @anschuetz2019realizing, an efficient method for training QBMs in NISQ devices based on the eigenstate thermalization hypothesis has been proposed.


==== Quantum Circuit Born Machines. 
<quantum-circuit-born-machines.>
Parametrized quantum circuits can function as generative models to sample from probability distribution. The Quantum Circuit Born Machine (QCBM) @benedetti2019generative outputs bitstrings $bold(x)$ sampled from measurements in the computational basis of a quantum circuit $U ( bold(theta) )$, with the probability of each bit string given by the Born rule $p_(bold(theta)) ( x ) tilde | chevron.l bold(x) | U ( bold(theta) ) | 0 chevron.r |^2$. The goal is that the distribution of the QCBM matches the one from a given target distribution.


QCBMs can prepare classical probability distributions as well as entangled quantum states by training them to match the probability distribution corresponding to the desired quantum state~@benedetti2019generative. In @liu2018differentiable, training of QCBMs using the gradients of the parameterized quantum circuit was proposed using the maximum mean discrepancy loss, which calculates the difference of the sampled output from the quantum circuit and the desired distribution in a kernel feature space.


QCBMs are well suited to be run on current NISQ hardware and can serve as benchmarks~@zhu2019training @leyton2019robust @hamilton2019generative and have been applied to tasks such as generating images~@rudolph2020generation or financial data~@coyle2020quantum @alcazar2020classical. It has been shown that QCBMs can potentially outperform classical computers as they are able to sample from probability distributions that are difficult for classical computers~@du2020expressive @coyle2020born.


==== Quantum Generative Adversarial Networks. 
<quantum-generative-adversarial-networks.>
Generative adversarial learning~@goodfellow2014generative has been one of the most recent breakthrough in machine learning, and have become very powerful tool in the machine learning community, for image and video generation, and materials discovery. The GAN consists of two networks, a generator, $F_G ( z theta_g )$ and a discriminator, $F_D ( x theta_d )$ - with parameters $theta_g$ and $theta_d$ respectively, playing an adversarial game, which can be summarized as follows:


$ min_(theta_g) max_(theta_d) ( E_(x tilde p_(upright("data")) ( x )) \[ log ( F_D ( x ) \]\
+ E_(z tilde p_z ( z )) \[ log ( 1 - F_D ( F_G ( z ) ) ) \] $


where $p_z ( z )$ is a fixed prior distribution, $p_(upright("data")) ( x )$ is the target distribution, $x$ is the data sampled from $p_(upright("data")) ( x )$, and $z$ is the noise sampled from $p_z ( z )$. The training of GAN is carried iteratively, until the generator produces a distribution indistinguishable from the target distribution.


A quantum version of generative adversarial networks (GANs) was proposed theoretically in Refs.~@dallaire2018quantum @lloyd2018quantumgenerative and further developed for near term quantum devices in Refs.~@zeng2019learning @romero2019variational @situ2020quantum, where parameterized quantum circuits are used for adversarial learning instead of classical neural networks.


The different adaptions of quantum GANs can be divided into different categories, based on the data and networks used being classical and quantum~@romero2019variational. There have been different studies with hybrid models of GANs using both classical and quantum data, and it has been shown that the training of these networks are robust to moderate level of noise~@anand2020experimental.


The training of quantum GANs has been demonstrated experimentally on various quantum processing units, for a variety of tasks including, quantum state estimation~@hu2019quantum, image generation~@huang2020experimental @huang2020realizing, generating continuous distributions~@anand2020experimental, learning distribution~@zoufal2019quantum, among others~@nakaji2020quantum.


=== Reinforcement learning
<sec:applications_ML_RL>


The general framework of reinforcement learning (RL) involves an agent interacting with an environment attempting to maximize an underlying reward function.


The mathematics of RL can be captured using Markov decision process (MDP)~@sutton2018reinforcement. An MDP is a $4$-tuple $(S , A , R , P) ,$ where $S$ is the set of all possible valid states; $A$ is the set of all possible actions; $R$ is the reward function, i.e. a map $R : med S times A times S arrow.r bb(R)$\; and $P$ is the transition probability, i.e. a map $P : med S times A arrow.r \[ 0 , 1 \] .$ Specifically, the transition probability $P ( tilde(s) | s , a )$ represents the probability of transition to state $tilde(s)$ given the present state is $s$ and the action $a$ has been taken. The term "Markov" in MDP means that transitions are memory-less and depend only on the current state and action. The agents in reinforcement learning learn via trial and error. For a successful training, a proper balance between exploration of unknown strategies and exploitation of prior experience is required.


The training happens via agent-environment interaction. At the beginning of time step $t$, the environment state is $s_t .$ From the set $A ,$ the agent selects an action $a_t .$ The transition probability dictates the next state of the environment $s_(t + 1)$ and the agent gets reward $r_(t + 1)$ based on the reward function $R .$ The agent-environment interaction yields a series of states and actions of the form $tau = (s_1 , a_1 , s_2 , a_2 , dots.h.c , s_H , a_H) .$ The aforementioned series is called a trajectory and the number of interactions ($H$) in an episode is called horizon. Suppose the probability of a trajectory is $P (tau)$ and the corresponding cumulative reward is $R_(t o t) (tau) .$ Then, the expected reward is $sum_tau P (tau) R_(t o t) (tau) .$


By harnessing quantum mechanical phenomena such as superposition and entanglement, one can expect to achieve speedups in the reinforcement learning tasks @dong2008quantum @dunjko2016quantum @dunjko2017advances @paparo2014quantum. The aforementioned intuition has led to recent works towards quantum reinforcement learning @dunjko2017advances @cornelissen2018quantum


We discuss the essence of quantum reinforcement lerning by providing a brief synopsis of quantum agent environment (AE) paradigm. For details, refer to ~@dunjko2017advances. In the AE paradigm, agent and environment are modelled via sequences of unitary maps ${cal(E)_A^j}_j$ and ${cal(E)_E^j}_j$ respectively. The agent and environment have access to memory registers belonging to Hilbert spaces $cal(H)_A$ and $cal(H)_E$. The communication register between the agent and the environment belongs to Hilbert space $cal(H)_C .$ The agent maps ${cal(E)_A^j}_j$ act on $cal(H)_A ⊗ cal(H)_C$ and the environment maps ${cal(E)_E^j}_j$ act on $cal(H)_E ⊗ cal(H)_C$. The agent and environment interact with each other by applying their maps sequentially. The set of actions and states correspond to orthonormal set of vectors ${| a chevron.r | a in A}$ and ${| s chevron.r | s in S}$ respectively. The Hilbert space corresponding to the communication register is given by $cal(H)_C = cal(upright("span")) (| y chevron.r | y in S union A) .$ The classical AE paradigm corresponds to the case where the agent and environment maps are classical.


Quantum reinforcement learning has been studied for algorithm such as SARSA, and Q Learning ~@jerbi2019quantum, which are some of the elementary reinforcement learning algorithms~@sutton2018reinforcement.


In the set-up of variational quantum circuits, reinforcement learning has been explored for small input sizes~@chen2020variational. This work revealed a possibility of quadratic advantage in parameter space complexity. Using better encoding schemes, @lockwood2020reinforcement showed the case of reinforcement learning with variational quantum circuits for larger input sizes. In a follow-up work, @lockwoodplaying demonstrated the possibility of dealing with the relatively complicated example of playing Atari games.


Reinforcement learning with quantum annealers has also been investigated by ~@crawford2016reinforcement. In their framework, they explore reinforcement learning with quantum Boltzmann machines. A detailed study of basic reinforcement learning protocols with superconducting circuits is provided in ~@lamata2017basic. Some exciting proposals of reinforcement learning with trapped ions and superconducting circuits have also been proposed recently~@cardenas2018multiqubit. For quantum eigensolvers, reinforcement learning study has been carried out recently~@albarran2020reinforcement. Reinforcement learning with optical set-up has been discussed in ~@yu2019reconstruction.


== Combinatorial optimization
<sec:optimization>


Given a finite set of objects, say $S$, combinatorial optimization deals with finding an optimal object from the set $S .$ It is a sub-discipline of mathematical optimization theory, with applications in diverse fields such as artificial intelligence, logistics, supply chain and theoretical computer science. Some typical examples of combinatorial optimization problems are the traveling salesman problem~@lenstra1975some, job-shop scheduling~@manne1960job, max-cut~@festa2002randomized and Boolean satisfiability~@tovey1984simplified.


To understand combinatorial optimization, let us consider the canonical problem of Boolean satisfiability. Boolean variables admit two truth values, TRUE and FALSE. These can be combined together using operators AND or conjunction (denoted by $and$), NOT or negation (denoted by $not$), and OR or disjunction (denoted by $or$). These combinations are called Boolean expressions.


A Boolean expression is said to be satisfiable if it can be TRUE for appropriate assignment of logical values to its constituent Boolean variables. Given a Boolean expression $E$, the Boolean satisfiability problem (SAT) consist of checking if $E$ is satisfiable. The well-known Cook-Levin theorem showed that SAT is NP-complete~@arora2009computational.


Every combinatorial optimization problem can be expressed as $m$ clauses over $n$ Boolean variables. A Boolean variable is known as positive literal, while its negation is known as a negative literal. A disjunction of literals is known as clause or constraint. For every constraint $C_alpha$ for $alpha in (1 , 2 , dots.h.c , m)$ and every string $z in (0 , 1)^n ,$ let define


$ C_alpha (z) = cases(1 & "if " z " satisfies " C_alpha (z) , 0 & "if " z " does not satisfy") . $


The goal of a combinatorial optimization problem, framed as such, is to find a string which maximizes the following objective function,


$ C ( z ) = sum_(alpha = 1)^m C_alpha (z) , $<eq:Objective_Cluase>


which counts the number of satisfied constraints.


Approximate optimization algorithms such as QAOA seeks to find a solution $z$ (usually a bit-string) with a desired approximation ratio $r^(*) lt.eq C ( z ) / C_(upright("max"))$, where $C_(upright("max"))$ is the maximum value of $C ( z )$. Using $C ( z )$ and computational basis vectors $| e_i chevron.r in bb(C)^(2^n)$ for $i = 1 , dots.h , 2^n$, one can construct the problem Hamiltonian as the one in @eq:HP_QAOA, and thus mapping the combinatorial optimization problem to a Hamiltonian ground state problem.


The list of the NISQ algorithms for combinatorial optimization discussed in the following lines are listed in @tab:combinatorial.


=== Max-Cut
<sec:MaxCut>


Max-Cut is an important combinatorial optimization problem with applications in diverse fields such as theoretical physics and circuit design. In theoretical physics, the Max-Cut problem is equivalent to finding the ground state and its energy of a spin glass Hamiltonian. Given a graph $G = (V , E)$ with a vertex set $V$ and edge set $E$, a cut is a partition of the elements of $V$ into two disjoint subsets. Given a weight function $w : E arrow.r bb(R)^(+)$ such that the edge $(i , j) in E$ has weight $E_(i j)$, the Max Cut problem consist of finding a cut $K union macron(K) = V$ that maximizes


$ sum_(i in K , j in macron(K) , ( i , j ) in E) w_(i j) . $<eq:max_cut_objective_1>


For every vertex $v_i in V$, let us associate a variable $x_i$ which takes values $plus.minus 1 .$ Given an arbitrary cut $K union macron(K) = V$, let us define $x_i = 1$ if $v_i in K$ and $- 1$ otherwise. Then, the Max-Cut problem is equivalent to the following quadratic program,


$ max thin sum_((v_i , v_j) in E) w_(i j) frac(1 - x_i x_j, 2) , $<eq:max_cut_objective_2>


subject to $x_i in (- 1 , + 1) forall v_i in V$.


Considering $n$ vertices as $n$ qubits in the computational basis, we can classify qubits by assigning quantum states $| 0 chevron.r$ or $| 1 chevron.r .$ For the classical objective function in the optimization program from @eq:max_cut_objective_2, we can use the following Hamiltonian as the problem Hamiltonian,


$ H_P = sum_((i , j) in E) 1 / 2 (I - hat(sigma)_z^i ⊗ hat(sigma)_z^j) equiv sum_((i , j) in E) C_(i j) . $


It has been shown that it is NP-hard to achieve an approximation ratio of $r^(*) gt.eq 16 / 17 approx 0.9412$ for Max-Cut on all graphs @hastad2001optimal. For the QAOA with $p = 1$, it has been shown that for a general graph,


$ chevron.l C_(i j) chevron.r = 1 / 2 + 1 / 4 ( sin 4 beta sin gamma ) ( cos^(d_i) gamma + cos^(d_j) gamma )\
- 1 / 4 ( sin^2 beta cos^(d_i + d_j - 2 lambda_(i j)) gamma ) ( 1 - cos^(lambda i j) 2 gamma ) , $


where $d_i + 1$ and $d_j + 1$ denote the degrees of vertices $i$ and $j$ respectively, and $lambda_(i j)$ is the number of triangles containing the edge $( i , j )$ in the graph @wang2018quantum. Here, $gamma$ and $beta$ refer to the QAOA parameters from~@eq:QAOA_evolved_state. Analytical results for general Ising optimization problems with $p = 1$ have also been found @ozaeta2020expectation.


In the case of unweighted 3-regular (u3R) graphs, the above result gives the approximation ratio of $0.692$, which is consistent with the pioneering result by Farhi, Goldstone and Gutman @farhi2014quantum. In comparison, the best classical algorithms to date give the approximation ratio of $r^(*) approx 0.8786$ for general graphs @goemans1995improved, and $r^(*) approx 0.9326$ for u3R graphs @halperin2004max using semidefinite programming. While QAOA for $p = 1$ does not outperform its classical counterparts for the Max-Cut problem, QAOA has been found to surpass the Goemans-Williamson bound for larger values of $p$ @crooks2018performance.


QAOA has also been applied to the clustering problem (from unsupervised learning) by mapping it to Max-Cut problem @otterbach2017unsupervised. Remarkably, it was shown that by fixing the QAOA parameters and selecting the typical problem instances from a reasonable distribution, the objective function value concentrates, i.e. the objective function value is almost independent on the instance @brandao2018for. This implies that the parameters optimized for one instance can be used for other typical instances, which would drastically reduce the optimization cost. Similar concentration behavior was also reported for the Sherrington-Kirkpatrick model in the infinite size limit $( n arrow.r oo )$ @farhi2019quantum.


Recently, a non-local version of QAOA called recursive QAOA (RQAOA) was proposed ~@bravyi2019obstacles. It consist of running a QAOA as a subroutine on a specific problem with $N$ qubits and measuring the expectation values of the correlations between the all qubit pairs $( i , j )$ with $M_(i j) = chevron.l sigma_z^i sigma_z^j chevron.r$. Then, one picks out the pair of qubits $( n , m )$ that have maximal absolute value of correlation $n , m = upright("arg max")_(( i , j )) | M_(i j) |$. For $M_("nm") > 0$, the selected qubit pair $( n , m )$ are positively correlated and very likely to be in the same state, whereas for $M_("nm") < 0$ they are anti-correlated and likely to be in opposite state. Now, this correlation is fixed as a constraint on the problem by fixing the state of the qubit $sigma_z^m = upright("sign") ( M_("nm") ) sigma_z^n$. With this constraint, one of the two qubits can be removed as its state is completely determined by the other, reducing the total qubit number by one. Now, the above procedure is repeated for the now reduced problem of size $N - 1$ qubits, i.e. one runs the QAOA subroutine, measures the correlations and fixes the qubit pairs with maximal correlation. The RQAOA algorithm is run recursively until the size of the problem is reduced to a small number of qubits such that it can be solved easily classically. When RQAOA is run with the QAOA subroutine of depth $p = 1$, it can efficiently simulated on a classical computer, which can serve as an important benchmark with classical algorithms~@bravyi2019obstacles. Numerical experiments with higher $p$ suggest similar or better performance on combinatorial problems compared to other classical algorithms~@bravyi2020hybrid @egger2020warm.


Finally, QAOA with depth $p = 1$ has been investigated in comparison with quantum annealing~@streif2020forbidden. QAOA is connected to quantum annealing in the sense that in the limit of infinite depth $p$, QAOA is equivalent to quantum annealing (refer to @sec:HamiltonAnsatz for QAOA, as well as @subsec:quantum-annealing for quantum annealing). However, QAOA can outperform quantum annealing on specific problems even at depth $p = 1$. In fact, QAOA can solve specific problems perfectly for $p = 1$, arriving at the correct solution with unit probability, whereas quantum annealing struggles here to find the solution~@streif2020forbidden. This shows that QAOA is strictly more powerful than quantum annealing.


=== Other combinatorial optimization problems
<other-combinatorial-optimization-problems>


While the usage of QAOA on Max-Cut has been studied extensively, QAOA has also applications in other important combinatorial optimization problems such as Max-$k$ Vertex Cover, which seeks to find the set of $k$ vertices on a graph that maximizes the number of edges incident on the vertices @cook2019quantum\; Exact-cover problem (given a set $X$ and several subsets $S_i$, find the combination of subsets which contains all elements just once) with applications to the tail-assignment problem @bengtsson2020improved @vikstaal2020applying\; lattice protein folding @fingerhuth2018quantum @robert2021resource\; knapsack problem as applied to battery revenue optimization @grandrive2019knapsack\; multi-coloring graph problems @oh2019solving\; maximum independent set problems @choi2020quantum @saleem2020max with applications to scheduling; and the vehicle routing problem @utkarsh2020solving. An adiabatically assisted approach was suggested in ~@garcia2018addressing to tackle combinatorial optimization problems. Investigations involving variational Grover search could be helpful to solve combinatorial optimization problems~@morales2018variational @zhang2021implementation. Gaussian Boson Sampling (see @sec:GBS) has been used to assist in a wide variety of combinatorial optimization problems @bromley2020applications @arrazola2018quantum, most prominently to solve Max-Clique @arrazola2018using @banchi2020training. This has applications in predicting molecular docking configurations @banchi2020molecular, computing vibrational spectra of molecules @huh2015boson, and electron-transfer reactions @jahangiri2020quantum. Using NISQ devices, an approach was suggested in ~@metwalli2020finding for the triangle finding problem and its $k$-clique generalization.


Quantum Annealing, which has been the inspiration of QAOA, is a prominent platform that has been applied to various combinatorial optimization problems and its applications, such as protein folding~@perdomo2012finding, reviewed in @hauke2020perspectives. As gate-based devices mature, it will open the possibility for experimental benchmarking of QAOA against state-of-the- art solvers for suitable real-world applications, as performed in @perdomo2019readiness in the context of quantum annealing machines and including proposals beyond the capabilities of current D-wave devices.


== Numerical solvers
<sec:numerical_solvers>


We proceed to discuss NISQ algorithms used to solve numerical problems such as factoring, singular value decomposition, linear equations and non-linear differential equations, all of them listed in @tab:numerical_solvers.


=== Variational quantum factoring
<sec:factoring>


The factoring problem accepts a composite positive integer $N$ as input and returns its prime factors as output. There is no known efficient classical algorithm for prime factorization and the hardness of factoring is used to provide the security in the RSA public-key cryptosystems. The famous Shor's factoring algorithm is a polynomial time quantum algorithm for the factoring problem~@shor1999polynomial (implying prime factorization is in BQP) and hence has been extensively investigated by quantum computing researchers (for details refer to~@anschuetz2019variational and references therein). The resource estimates for implementing the Shor's algorithm is, however, way beyond the capabilities of the NISQ era. A detailed analysis has shown that factoring a $2048$-bit RSA number would necessitate a quantum processor with $10^5$ logical qubits and circuit depth on the order of $10^9$ to run for roughly $10$ days~@van2010distributed @jones2012layered. On a photonic architecture, using $1.9$ billion photonic modules, factoring a $1024$-bit RSA number is expected to tale around $2.3$ years~@devitt2013requirements. To tackle the factoring problem in the near-term quantum devices, it is imperative to develop NISQ-era compatible alternatives to Shor's factoring algorithm.


The factoring problem can be mapped to the ground state problem of an Ising Hamiltonian~@burges2002factoring @dattani2014quantum. To understand the aforesaid mapping, let us consider the factoring of $m = p times q$. Suppose the binary representations of $m , p$ and $q$ are $m = sum_(k = 0)^(n_m - 1) 2^i m_k$, $p = sum_(k = 0)^(n_p - 1) 2^i p_k$ and $q = sum_(k = 0)^(n_q - 1) 2^i q_k$. Here, $m_k in (0 , 1)$is the $k$th bit of $m$ and the total number of bits for $m$ has been denoted by $n_m .$ Similar notation has been employed for $p$ and $q .$ Since $m = p times q ,$ it induces $n_c = n_p + n_q - 1$ constraints on the individual bits of $m , p$ and $q ,$


$ sum_(j = 0)^i q_i p_(i - j) + sum_(j = 0)^i z_(j , i) - m_i - sum_(j = 1)^(n_c) 2^j z_(i , i + j) = 0 thin , $<eq:Constraints_factoring_1>


for $i in \[ 0 , n_c )$ and the carry bit from position $i$ to position $j$ has been represented by $z_(i , j) .$ The constraint $i$ in @eq:Constraints_factoring_1 induces clause $C_i equiv sum_(j = 0)^i q_i p_(i - j) + sum_(j = 0)^i z_(j , i) - m_i - sum_(j = 1)^(n_c) 2^j z_(i , i + j)$ over $bb(Z)$ such that factoring can be modelled as assignment of binary variables ${m_i} , {p_i}$ and ${q_i}$ which solves $sum_(i = 0)^(n_c - 1) C_i^2 = 0 .$


One can map the binary variables to quantum observables to quantize the clause $C_i$ to $hat(C_i)$ using the mapping


$ b_k arrow.r 1 / 2 (1 - sigma_(b , k)^z) $


and obtain the Hamiltonian


$H_P = sum_(i = 0)^(n_c - 1) hat(C_i)^2$,


which we refer as factoring Hamiltonian. Note that the factoring Hamiltonian is a 4-local Ising Hamiltonian.


By using the aforementioned ideas, one can use NISQ algorithms for the ground state problem to tackle the factoring problem (see @sec:VQE and @sec:optimization). In Ref.~@anschuetz2019variational, authors employ QAOA to find the ground state of the factoring Hamiltonian and refer to their Algorithm as variational quantum factoring (VQF) algorithm. Numerical simulations were provided for numbers as high as $291311$. For a recent experimental realization and detailed analysis of VQF, refer to ~@karamlou2020analyzing.


=== Singular value decomposition
<subsec:-SVD>


Given a matrix $M in bb(C)^(m times n)$, the Singular Value Decomposition (SVD) provides a factorization of the form


$M = U Sigma V^dagger$,


where $U in bb(C)^(m times m)$ is a unitary matrix, $Sigma in bb(R)_(+)^(m times n)$ is a rectangular diagonal matrix with non-negative real diagonal entries and $V in bb(C)^(n times n)$ is a unitary matrix. The diagonal entries of $Sigma$ are called the singular values of matrix $M .$ The columns of the unitary matrices $U$ and $V$ are called left-singular and right-singular vectors of $M .$ Using Dirac notation, one can write


$ M = sum_(j = 1)^r d_j | u_j chevron.r chevron.l v_j | . $<eq:SVD_Dirac>


where $d_j , | u_j chevron.r , | v_j chevron.r$ are singular values, left-singular vectors and right-singular vectors. The rank of matrix $M$ is $r$ and is equal to the number of non-zero singular values.


SVD finds applications in calculating pseudoinverse ~@gregorcic2001singular, solving homogeneous linear equations ~@klema1980singular, signal processing ~@vandewalle1991use and recommendation systems ~@koren2009matrix. Moreover, the notion of Schmidt decomposition which is used to study entanglement of bipartite quantum states, is related to SVD.


In the quantum information context, the SVD can be used to compute the Schmidt decomposition of bipartite quantum states. For a quantum state $| psi chevron.r in cal(H)_A ⊗ cal(H)_B$, the Schmidt decomposition is given by


$ | psi chevron.r = sum_i d_i | u_i chevron.r | v_i chevron.r , $<eq:Schmidt>


where $d_i$ are non-negative real numbers such that $sum_i d_i^2 = 1$. Moreover, ${| u_i chevron.r}_i$ and ${| v_i chevron.r}_i$ correspond to orthonormal basis sets for $cal(H)_A$ and $cal(H)_B$ respectively. The number of non-zero $d_i$, say $chi$, is called the Schmidt rank of the quantum state $| psi chevron.r$ and is used to quantify the bipartite entanglement. To calculate the Schmidt decomposition, one can write the bipartite quantum state as a matrix


$| psi chevron.r = sum_(i , j) A_(i j) | i chevron.r | j chevron.r$,


where $| i chevron.r$ and $| j chevron.r$ are the computational basis states of each qubit, and perform SVD of the matrix $A .$


Ref.~@bravo2020quantum provide a NISQ algorithm to perform SVD of pure bipartite states. Starting with two unitary circuits, which act on different bipartitions of the system, the authors variationally determine the singular values and singular vectors by training the circuits on exact coincidence of outputs. The central ideas of their method is to variationally find circuits that provides the following transformation of the initial quantum state $| psi chevron.r_(A B)$ with Schmidt rank $chi$,


$ U_A ⊗ V_B | psi chevron.r_(A B) = sum_(i = 1)^chi lambda_i e^(i gamma_i) | e_i chevron.r_A | e_i chevron.r_B , $<eq:SVD_Bravo_Circuits>


where $U_A | v_i chevron.r_A = e^(i alpha_i) | e_i chevron.r_A$, $V_B | v_i chevron.r_B = e^(i beta_i) | e_i chevron.r_B$ such that $alpha_i = beta_i + gamma_i in \[ 0 , 2 pi )$ and $(| e_k chevron.r_(A , B))_k$ are the compuational basis states in $cal(H)_(A , B) .$ Using their algorithm, authors also suggest the possibility to implement SWAP gate between parties $A$ and $B$ without the requirement of any gate connecting the two subsystems.


Using variational principles for singular values and Ky Fan theorem @fan1951maximum, @wang2020variational provide an alternative NISQ algorithm for SVD. The authors provide proof of principle application of their algorithm in image compression of handwritten digits. They also discuss the applications of their algorithm in recommendation systems and polar decomposition.


=== Linear system problem
<sec:linear_system_problem>


Systems of linear equations play a crucial role in various areas of science, engineering and finance. Given a matrix $A in bb(C)^(N times M)$ and $bold(b) in bb(C)^N$, the task of the linear system problem (LSP) consists of finding $bold(x) in bb(C)^M$ such that


$ A bold(x) = bold(b) thin . $<eq:LSP>


Depending on the dimensions $M$ and $N$, the LSP takes various forms. If $M = N$ and $A$ is invertible, $bold(x) = A^(- 1) bold(b)$ is unique. If $M eq.not N ,$ the LSP can be under-determined or over-determined. For the sake of simplicity, it is natural to assume the matrix $A$ to be square i.e. $M = N .$ If the matrix $A$ has at most $s$ non-zero elements per row or column, the LSP is called $s$-sparse.


The quantum version of the LSP, known as the quantum linear system problem (QLSP), assumes $A$ to be $N times N$ Hermitian matrix and $bold(b)$ to be a unit vector, i.e. it can be represented as a quantum state $| b chevron.r = sum_(i = 1)^N b_i | e_i chevron.r .$ The QLSP problem thus is formulated as


$ A | x chevron.r = | b chevron.r arrow.r | x chevron.r = A^dagger | b chevron.r . $<eq:QLSP>


The first quantum algorithm proposed for solving the QLSP was the famous Harrow-Hassidim-Lloyd (HHL) algorithm~@harrow2009quantum. Apart from the size of the matrix $A$, i.e. $N$, and its sparsity $s$, two other dominant factors determining the running time of a LSP or QLSP algorithm are the condition number $( kappa )$ of the matrix $A$ and the additive error $( epsilon.alt )$ corresponding to the solution. The condition number of a matrix $A$ is given by ratio of maximal and minimal singular values of $A .$ The best classical algorithm for LSP is the conjugate gradient method with runtime complexity $O ("Ns" kappa log (1 / epsilon.alt)) .$ On the other hand, the HHL algorithm for QLSP, as originally proposed, has runtime complexity $O (log (N) s^2 kappa^2 / epsilon.alt) .$ Further works on the HHL algorithm has improved $kappa$ scaling to linear~@ambainis2012variable and error dependence to $p o l y (log (1 / epsilon.alt))$~@childs2017quantum. Implementation of HHL algorithm, however, requires the fault-tolerant architecture and hence its guarantees can not be leveraged on the NISQ architecture. The largest QLSP solved on a gate based quantum computer corresponds to its implementation on an nuclear magnetic resonance (NMR) processor for $N = 8$~@wen2019experimental.


Recently, a few VQA based implementations of the QLSP were proposed~@huang2019nearterm @bravo2019variational @xu2019variational2. Given a QLSP with input $A$ and $| b chevron.r ,$ the idea is to find the ground state of the following Hamiltonian,


$ H ( u ) = A ( u ) P_(+ , b)^perp A ( u ) , $<eq:Hamiltonian_Subasi>


where $A ( u )$ and $P_(+ , b)^perp$ are defined as


$ A ( u ) & equiv (1 - u) sigma_z ⊗ I + u med sigma_x ⊗ A ,\
P_(+ , b)^perp & = I - | + , b chevron.r chevron.l b , + | . $


Both $A$ and $| b chevron.r$ are assumed to be constructed efficiently with a quantum circuit, i.e. $A = sum_(k = 1)^(K_A) beta_k U_k$ and $| b chevron.r = U_b | 0 chevron.r$, with $K_A = O (p o l y (log N))$. The phase in $beta_k$ can be absorbed in $U_k$ and hence one can assume $beta_k > 0 .$


The Hamiltonian in @eq:Hamiltonian_Subasi for $u = 1 ,$ has a unique ground state, $| + chevron.r | x^star.op chevron.r = | + chevron.r frac(A^(- 1) | b chevron.r, lr(bar.v.double A^(- 1) | b chevron.r bar.v.double)_2) ,$ with zero ground state energy. After removing the ancilla, the ground state can be seen to be proportional to $A^(- 1) | b chevron.r .$ Thus, one can define the following loss function,


$ L_H (| x chevron.r) = chevron.l + , x | H ( 1 ) | + , x chevron.r . $<eq:Loss_Subasi>


Without the ancilla, the above loss function can be written as $L_H (| x chevron.r) = chevron.l x | A^2 | x chevron.r - chevron.l x | A | b chevron.r chevron.l b | A | x chevron.r .$


In @huang2019nearterm, authors analyze the optimization landscape for VQA based optimization for the loss function of @eq:Loss_Subasi and show the presence of barren plateaus which persist independent of the architecture of the quantum circuit for generating $| x (theta) chevron.r .$ Even techniques based on adiabatic morphing~@garcia2018addressing fail to evade the effect of the barren plateaus. To circumvent the barren plateau problem, ~@huang2019nearterm proposed a classical-quantum hybrid state (see also @sec:IQAE and @eq:IQAE_Ansatz) $bold(x) = sum_(i = 1)^r alpha_i | psi_i (theta_i) chevron.r$, where $alpha_i in bb(C)$ and $theta_i in bb(R)^(k_i)$ for $i in (1 , 2 , dots.h.c , r) .$ Note that $theta_i$ are the usual variational parameters and $alpha_i$ are the combination parameters. These parameters are stored on a classical device and the state $x$ is not explicitly created on a quantum processor. Moreover, $x$ may not be normalized. To solve the QLSP, one minimizes the following loss function,


$ L_R (x) = lr(bar.v.double A x - | b chevron.r bar.v.double)_2^2 = x^dagger A^dagger A x - 2 upright("Re") {chevron.l b | A x} + 1 . $


Since optimization with respect to $theta_i$ suffers from the barren plateau problem, one can fix and subsequently drops the variational parameter $theta_i$.


The optimization landscape is convex in $bold(alpha) = (alpha_1 , alpha_2 , dots.h.c , alpha_r) .$ Starting from $| psi_1 chevron.r = | b chevron.r ,$ other quantum states can be generated using the Ansatz tree approach in @huang2019nearterm. It was proved that finding the combination parameters of $| psi_1 chevron.r , | psi_2 chevron.r , dots.h.c , | psi_r chevron.r$ to minimize $L_R (sum_(i = 1)^r alpha_i | psi_i chevron.r)$ is BQP complete. Moreover, using $O (K_A^2 r^2 / epsilon.alt)$ measurements, one can find $epsilon.alt$-suboptimal solution. With this approach, linear systems as high as $2^300 times 2^300$ can be solved by considering cases which are also classically tractable.


=== Non-linear differential equations
<sec:nonlinear_differential>


Nonlinear differential equations (NLDE) are a system of differential equations (DE) that cannot be expressed as a linear system. The numerical approaches to tackle DE can be local or global. Local methods employ numerical differentiation techniques~@butcher1987numerical such as the Runge-Kutta or discretization of the space of variables. Global methods, on the other hand, represent the solution via a suitable basis set, and the goal remains to find optimal coefficients~@gottlieb1977numerical. In many cases, as the number of variables or nonlinearity in the differential equations increase, finding solutions becomes challenging. To achieve higher accuracy, local methods require a fine grid, which renders high computational cost. In the case of global methods, high accuracy necessitates a large number of elements in the basis set, leading to more extensive resource requirements. To tackle resource challenges, quantum algorithms are proposed.


Linear DE can be re-expressed as a system of linear equations using the finite difference method, and one can employ NISQ linear system algorithms to tackle the problem (see @sec:linear_system_problem). For a recent theoretical proposal with experimental work on linear differential equations, refer to ~@xin2020quantum. However NLDE defy this approach for large nonlinearities.


A canonical example of a NLDE appearing in quantum theory is the $1$-D nonlinear Schrödinger equation $\[- 1 / 2 frac(upright("d")^2, upright("d") x^2) + V ( x ) + g lr(|f ( x )|)^2\] f ( x ) = E f ( x )$. Here, $E$ denotes energy, $g$ quantifies nonlinearity, and $V$ is the external potential. Recently, NISQ algorithms for NLDE have been proposed. Ref.~@lubasch2020variational use ancillary quantum registers and controlled-multiqubit operations to implement nonlinearities to simulate the nonlinear Schrodinger equation. Ref.~@haug2020generalized propose the nonlinear quantum assisted simulator (NLQAS) to tackle NLDE without any controlled unitaries. Using NLQAS, they simulate this equation for $8$ qubit system. NLDE have also been studied in @gaitan2020finding for fluid dynamics problems. Using differentiable quantum circuits, @kyriienko2020solving have also proposed an interesting approach to solving NLDE via global methods.


== Other applications
<sec:other_app>


In this subsection, we cover other applications for which NISQ algorithms can provide promising improvements. They are listed in @tab:other_app.


=== Quantum foundations
<quantum-foundations>


One of the first experiments in digital quantum computers were the Bell nonlocality tests known as #emph[Bell inequalities] @brunner2014bell. Those experiments computed a type of Bell inequalities known as Mermin inequalities in up to five superconducting quantum qubits. The experiment consisted in preparing the GHZ state @greenberger1990bell, measure it in a particular basis state and obtain the expectation value of the Mermin operator @alsina2016experimental. These nonlocality tests can be extended to higher dimensions by controlling quantum levels beyond the $| 0 chevron.r$ and $| 1 chevron.r$. As example, @cervera2021experimental experimentally generate a qutrit GHZ state using a programmable device controlled with Qiskit Pulse software @alexander2020qiskit, the first step towards performing a GHZ test.


In the context of VQA, the non-classicality in VQEs is examined using contextuality, which is a nonclassical feature of quantum theory~@amaral2018graph. Using the notion of "strong contextuality", @kirby2019contextuality categorized VQE experiments into two categories: contextual and non-contextual. Such foundational works could be utilized to comprehend the possible sources of quantum advantage in NISQ algorithms. Using novel concepts from this field, contextual subspace VQE (CS-VQE) was recently proposed~@kirby2020contextual.


In another work, the variational consistent history (VCH) algorithm was suggested to investigate foundational questions~@arrasmith2019variational. The consistent history approach has been used to examine topics from quantum cosmology and quantum-classical transition. In the VCH algorithm, the quantum computer is used to compute the "decoherence functional", which is challenging to calculate classically. The classical computer is employed to tune the history parameter so that the consistency is improved.


=== Quantum optimal control
<sec:quantum_optimal_control>


Quantum optimal control is a topic of paramount importance in the pursuit to harness the potential of Near-Term quantum devices. For a given quantum control system and a cost function that measures the quality of control, it aims to find a control that can achieve optimal performance.


Some recent works have investigated quantum optimal control in the NISQ framework. Recent detailed perspective in this direction can be found in Ref. @magann2020pulses. Ref.~@li2017hybrid provides a hybrid quantum-classical approach to quantum optimal control. To remedy some of the difficulties of classical approaches to optimal control related to scaling of resources, @dive2018situ proposed another NISQ framework. Experimental demonstration of quantum control for a $12$-qubit system has also been carried on~@lu2017enhancing. The aforementioned approaches, however, restrict their target states to be sparse matrices. For dense target states, @policharla2020algorithmic recently proposed a NISQ algorithm. Along with their algorithm, they also suggested a few algorithmic primitives to calculate overlap of quantum states and transition matrix elements. Hybrid quantum-classical algorithm have also been implemneted for computing quantum optimal control pulses, in particular for controlling molecular systems~@magann2020digital @castaldo2020quantum.


=== Quantum metrology
<sec:quantum_metrology>


Quantum metrology harnesses non-classical features of quantum theory for parameter estimation tasks. A canonical example could be estimating the parameter $phi.alt$ of a unitary map under the action of Hamiltonian $hat(H)$, given by


$ hat(rho) (phi.alt) = e^(- i hat(H) phi.alt) hat(rho)_0 e^(+ i hat(H) phi.alt) $


where the density matrix $hat(rho)_0$ refers to the initial state of the system. The goal is to estimate $phi.alt$ via measurements on $hat(rho) ( phi.alt ) .$ The quantum Cramér-Rao bound provides a lower bound to the achievable precision,


$ (Delta phi.alt)^2 gt.eq frac(1, n F_Q (hat(rho) (phi.alt))) . $<eq:QFI_metrology>


Here, $n$ represents number of samples, $F_Q (hat(rho) (phi.alt))$ is quantum Fisher information and $(Delta phi.alt)^2$ is the variance in the estimation of $phi.alt$. In most of the experiments, the parameter of interest is either temperature or magnetic field.


Notice that the precision of the estimation procedure increases as the quantum Fisher information increases. Using it as a cost function, a few works have recently explored quantum metrology to prepare a better probe state in a VQA set-up~@koczor2020variational @kaubruegger2019variational @ma2020adaptive @beckey2020variational. In addition, @meyer2020variational provided a toolbox for multi-parameter estimation and @haug2021natural the natural PQC with the lowest possible quantum Cramér-Rao bound for a general class of circuits.


=== Fidelity estimation
<sec:fidelity_estimation>


In @sec:objective_function, we discussed how to use the fidelity as an objective function, a quantity which is useful to train some VQA algorithms. In addition, estimating the fidelity of a quantum state with respect to another state has a general interest in the context of quantum computing. For this reason, algorithms that can estimate this property may become useful in the NISQ era.


Given the density matrices of two quantum states $rho_1$ and $rho_2$, their fidelity is given by


$ F (rho_1 , rho_2) = (upright("Tr") sqrt(sqrt(rho_1) rho_2 sqrt(rho_1)))^2 . $<eq:Fidelity_quantum>


Due to the large dimensionality of the Hilbert spaces, computing fidelity can be challenging.


Recently, variational quantum fidelity estimation (VQFE) algorithm was proposed to tackle slightly modified version of the fidelity estimation task which works efficiently when $rho_1$ has low-rank. Ref.~@cerezo2020fidelity provide lower and upper bounds on $F (rho_1 , rho_2)$ via VQFE. The algorithm calculate fidelity between $rho_1^n$, which is a truncated version of $rho_1$ obtained by projecting $rho_1$ to subspace spanned by $n$ largest eigenvalue eigenvectors of $rho_1 .$ The bounds improve monotonically with $n$ and is exact for $n = r a n k (rho_1) .$ The VQFE algorithm proceeds in three steps: #emph[i)] a variational diagonalization of $rho_1$\; #emph[ii)] the matrix elements of $rho_2$ are computed in the eigenbasis of $rho_1$\; and #emph[iii)] using the matrix elements from #emph[ii)], the fidelity is estimated.


=== Quantum error correction
<sec:variational_error_correction>


The leading error correction schemes carry high resource overheads, which renders them impractical for near-term devices~@fowler2012surface @johnson2017qvector. Moreover, many of the schemes mandate knowledge of the underlying noise model~@fletcher2008channel @kosut2008robust @kosut2009quantum. For an encoding process $cal(E)$, decoding process $cal(D)$ and noise model $cal(N)$, the quality of a quantum error correction scheme can be characterized by how close $cal(D) compose cal(N) compose cal(E)$ is close to identity. The range of $cal(E)$ is called code space $cal(C) .$


In ~@johnson2017qvector, a variational error-correcting scheme i.e, quantum variational error corrector (QVECTOR) was proposed by defining an objective function over the code space $cal(C)$. The authors employ two trainable parametric quantum circuits $V (bold(p))$ and $W (bold(q))$ for encoding and decoding respectively, with tunable parameter vectors $bold(p)$ and $bold(q)$. For a given encoding-decoding pair, characterized by $(bold(p) , bold(q)) ,$ the authors calculate a quantity called "average code fidelity" with respect to Haar distribution of states over the code space $cal(C) .$ The algorithm is model-free, i.e. no assumption of the noise model is involved. The goal of the QVECTOR algorithm is to maximize average code fidelity in a variational set-up.


In the context of VQA, error correction has also been explored in~@xu2019variational2 where the target logical states are encoded as ground state of appropriate Hamiltonian. @xu2019variational2 employ imaginary time evolution to find the ground state. The authors implement there scheme for five and seven qubit codes. For a brief discussion on error correction and quantum fault-tolerance, refer to @subsec:fault-tolerance.


=== Nuclear physics
<sec:nuclear_physics>


The Standard Model of particle physics is the theory that describes the nature of the electromagnetic and nuclear interactions. Its current formulation consist of describing the forces as quantum fields, i.e. by using quantum field theory (QFT) formalism. Perturbative calculations of QFT provide with the dynamics of the physical processes at a given energy scale. However, in some cases as in quantum chromodynamics (QCD), perturbation theory can not be applied because the impossibility of observe a free quark or gluon (the fundamental particles affected by QCD interaction) due to confinement. For this reason, QCD calculations are obtained by means of numerical methods such as Monte Carlo simulations in a discretized version of QFT on a lattice structure (LQFT). The high computational cost of LQFT has motivated the study of using quantum computation or simulation to obtain the desired QCD predictions @joo2019status.


The Schwinger model describes the dynamics of the quantum electromagnetic (QED) interaction in one spatial and temporal dimensions. It is used as a toy model to study QCD since it shows fermion confinement but it is simple enough to be solved analytically. The first experimental quantum simulations of this model were carried out in trapped ions @hauke2013quantum and later on a superconducting circuit quantum computer @martinez2016real. A first proposal to use a quantum-classical algorithm to simulate this model was presented in @klco2018quantum, where the quantum computer simulates the dynamics of the symmetry sectors suggested by a classical computation. In Ref. @kokail2019self a VQS is used in an analog setup to reduce the number of variational parameters and thus, reduce the computational cost of the algorithm. Their proposal is experimentally implemented in a trapped-ion analog simulator. A significant reduction of the computational cost of LQFT is proposed in @avkhadiev2020accelerating by using a VQA approach to compute the #emph[optimized interpolating operators] (approximators of the quantum state wavefunction).


Adaptations of the UCC quantum chemistry ansatz, introduced in @sec:HamiltonAnsatz, to study quantum-variationally QCD are presented in @liu2020quantum @dumitrescu2018cloud, and for the study neutrino-nucleus scattering in @roggero2020quantum. A 10-qubit VQC is used in @wu2020application to study Higgs boson decays and production processes and in @chen2020quantum a QCNN model is proposed to study basic high-energy processes. Recently, a PQC is used to learn the parton distribution function of protons~@perez2020determining.


=== Entanglement properties
<entanglement-properties>


Entanglement is a resource for numerous quantum information tasks. A bipartite quantum state $rho_(A B) in cal(H)_A ⊗ cal(H)_B$ is called separable if it admits the form


$rho_(A B) = sum_i p_i rho_i^A ⊗ rho_i^B$,


where $p_i$ are non-negative and $sum_i p_i = 1 .$ If a state is not separable, then it is called entangled. The problem of detecting whether a state is separable or entangled is known as the separability problem and has been shown to be NP-hard~@gurvits2003classical.


As mentioned in #ref(<subsec:-SVD>), computing the Schmidt rank of $rho_(A B)$ gives a measure of the bipartite entanglement. Thus, those algorithms that tackle the SVD problem can also be used to extract entanglement properties~@bravo2020quantum. In~@wang2020detecting, authors propose a NISQ algorithm for the separability problem by providing a variational approach to employ #emph[the positive map criterion]. This criterion establishes that the quantum state $rho_(A B)$ is separable if and only if for arbitrary quantum system $R$ and arbitrary positive map $cal(N)_(B arrow.r R)$ from $B$ to $R$, we have $cal(N)_(B arrow.r R) (rho_(A B)) gt.eq 0 .$ The authors start with a positive map and decompose it into a linear combination of NISQ implementable operations. These operations are executed on the target state, and the minimal eigenvalue of the final state is variationally estimated. The target state is deemed entangled if the optimized minimal eigenvalue is negative.


Exploring a similar strategy as the one presented in @bravo2020quantum, @perez2020measuring propose a VQA to compute the tangle, a measure of tripartite-entanglement.


VQA have also been employed for extracting the entanglement spectrum of quantum systems in ~@cerezo2020variational @larose2019variational.


= BENCHMARKING
<sec:benchmark>


One of the central questions at the intersection of software and hardware for NISQ devices is evaluating devices' performance and capabilities. This is where benchmarking concepts come in, to provide various metrics that attempt to measure different machines' capabilities and compare them across time and other devices. A benchmarking protocol can be characterized by its inherent assumptions, resource costs and the information gain. The goal is to build benchmarking protocols that make minimal and practical assumptions, have low resource costs, and have high information-gain.


Benchmarking protocols have been developed for NISQ as well as fault-tolerant devices. For a pedagogical summary, refer to~@eisert2019quantum. In this review, we focus on quantum benchmarking protocols for NISQ devices. Some of the leading NISQ benchmarking schemes are randomized benchmarking, quantum volume, cross-entropy benchmarking and application-based benchmarks.


== Randomized benchmarking
<randomized-benchmarking>


The most straightforward way of comparing devices is by simply counting qubits. To really compare different qubits, we must also have a sense of how many operations we can do with them before the noise arising from errors drowns out the signal. Randomized benchmarking (RB) is a convenient method for finding average error rates for quantum operations, in particular for single and two-qubit gates~@magesan2011scalable @magesan2012characterzing. RB is robust against state preparation and measurement (SPAM) errors and, unlike tomography, admits an efficient and practical implementation.


RB involves the following assumptions: #emph[i)] for every gate, the incurred noise is independent of other Clifford gates; #emph[ii)] the involved unitaries should constitute a $2$-design (see @sec:BP) and should not be universal. In other words, no $T$ gate is allowed; #emph[iii)] during the experiment, there is no drifting in the noise processes; and #emph[iv)] one can describe noise processes using completely positive trace-preserving (CPTP) maps.


A RB protocol starts by sampling a sequence of $m$ #emph[Clifford] gates (see @sec:gate_set). The sequence is applied to the initial state, followed by its inverse. Finally a two-outcome POVM measurement is done to calculate the fidelity between initial state and the output state, followed by classical post-processing. The RB protocol discretizes time so that it is measured in the number of gates and it then averages over many sequences of each length $m$. More formally, a $4$-step RB protocol consist of


+ Generate $K_m$ sequences of $m$ quantum operations $C_(i_j)$ with $i in \[ 1 , m \]$ and $j in \[ 1 , K_m \]$, where $i$ indexes over the sequence of operations, and $j$ over the statistical samples. These operations are randomly chosen from the Clifford group, and a $m + 1$-th operation is chosen that cancels the first $m$ operations such that the net operation is the identity. The operations can be chosen from the $2$-, $4$- or $2^n$-dimensional Clifford groups, depending on whether we are benchmarking single-, two- or $n$-qubit operations @mckay2019three. These operations come with some error, which is modeled with linear operators $Lambda_(i_j , j)$, so that the full sequence of $m$ operations is given by $S_(K_m) = circle.stroked_(j = 1)^(m + 1) ( Lambda_(i_j , j) compose C_(i_j) )$<eq:ch5:gate_error> Here, $compose$ denotes composition and $circle.stroked$ represents composition of the terms defined with index $j$.

+ For each sequence we find the fidelity with the initial state by measuring $upright("Tr") \[ E_psi S_(K_m) ( rho ( psi ) ) \]$, where $rho ( psi )$ is the initial state (with preparation errors) and $E_psi$ is a POVM measurement operator corresponding to the measurement including noise. Without noise, this would be the projector $E_psi = | psi chevron.r chevron.l psi |$.

+ Average over the $K_m$ statistical samples to find the sequence fidelity $F ( m , psi ) = upright("Tr") \[ E_psi S_m ( rho ( psi ) ) \]$<eq:ch5:sequence_fidelity> where $S_m$ is the mean over the operations $S_(K_m)$.

+ Fit the data with the function $F_(f i t) ( m , psi ) = A_0 p^m + B_0 ,$<eq:ch5:RB_fit> where we have assumed the errors are independent of gate and time. This is not a fundamental assumption, but can be relaxed~@magesan2011scalable @magesan2012characterzing. The average gate error is here given by $epsilon.alt_(R B) = 1 - p - ( 1 - p ) / 2^n$, and the constants $A_0$ and $B_0$ absorb the SPAM errors.


The operations $C_(i_j)$ are chosen from the Clifford group, because these are relatively easy to perform on quantum hardware, and because the final $m + 1$-th operation that undoes the sequence can easily be pre-computed on a classical computer. Averaging over the Clifford group (or any other finite group) also has the property that even though the real noise-channel would be more complicated than the purely depolarizing one, the average over the group will still give rise to an exponential decay.


These gate errors extracted from randomized benchmarking can be used to compare the quality of quantum gates, and to estimate that an algorithm of depth $tilde 1 / epsilon.alt_(R B)$ gates can be run on the device before only statistical noise is output. The intuition behind the RB protocol is that a (purely) depolarizing channel will cause exponential decay of an excited state over time.


Simultaneous randomized benchmarking (SRB) has been proposed to acquire information about crosstalk and undesired coupling between the neighbouring qubits~@gambetta2012characterization. RB has also been extended for gatesets that do not form a Clifford group~@cross2016scalable @brown2018randomized @hashagen2018real @francca2018approximate @carignan2015characterizing @gambetta2012characterization @harper2017estimating. In such cases, the expression for $F_(f i t) ( m , psi )$ does not follow equation @eq:ch5:RB_fit~@helsen2019new. Employing concepts from representation theory, an extension of RB has been proposed to extract the fidelity for a broad category of gatesets, including T-gate @helsen2019new. A practically scalable protocol called cycle benchmarking was developed lately to characterize local and global errors for multi-qubit quantum computers~@erhard2019characterizing.


== Quantum volume
<subsec:quantum_volume>
To further refine the concept of the computational power of a quantum computer from just qubit count and gate-errors, the IBM Quantum team introduced the "quantum volume"~@moll2018quantum @cross2019validating. It is one of the widely accepted metrics for benchmarking NISQ-era quantum computers. As mentioned earlier, one can not rank quantum computers based on the number of qubits alone. Quantum volume gives a rough estimate of the number of effective qubits a quantum computer has based on their performance on the "heavy output generation problem". The heavy output generation problem is related to the random circuit sampling task used in Google's quantum supremacy experiment. Quantum volume treats the depth and width of a quantum circuit at the equal footing. Hence, its estimation depends on the largest square-sized circuit, which can successfully implement the heavy output generation problem. The quantum computer's performance also depends on its software stack, for example, compiler, and thus quantum volume can increase with the improvements in the software stack.


The quantum volume benchmark can be thought analogous to the classical LINPACK benchmark~@dongarra1987linpack. Like the LINPACK benchmark, it is architecture-agnostic and provides a single real number metric based on the quantum computer's performance for a model problem, i.e., heavy output generation problem.


More formally, quantum volume can be defined in the following terms. Given an $n$ qubit quantum computer with the largest achievable #emph[model circuit] depth $d ( m )$ for #emph[model circuit] width $m in (1 , 2 , dots.h.c , n)$ such that the probability of observing a #emph[heavy output] for a random selection of model circuit is strictly greater than $2 / 3$, the quantum volume $V_Q$ is defined as~@cross2019validating


$ log_2 V_Q = "argmax"_m min (m , d ( m )) . $<eq:quantum_volume>


Intuitively speaking, quantum volume estimates the largest square random quantum circuit which the quantum computer can successfully implement the so-called heavy output generation problem. To conclude the discussion, it remains to describe the "model circuit" and the "heavy output generation problem".


The model circuit with depth $d$ and width $m$ for estimating quantum volume is given by $d$-layered sequence $U = U^(( d )) U^(( d - 1 )) dots.h.c U^(( 1 ))$ where layer $t$ consists of random permutations $pi_t in S_m$ applied to qubit labels, followed by the tensor product of Haar-random two-qubit unitaries from $S U ( 4 )$. If the model circuit width $m$ is odd, one of the qubits is left idle in every layer. See @fig:QV_model_circuit for a pictorial description.


// [figvision] imgs/quantum_volume.png
// Panel (a): A single horizontal quantum circuit schematic for the model quantum volume benchmark circuit. Five
// input qubit wires on the left are initialized to |0⟩, with vertical ellipsis between the second and fourth
// lines indicating additional qubits. Three shaded blue rounded rectangles are stacked horizontally and labelled
// Layer 1, Layer 2 and Layer d at the bottom, with horizontal ellipsis between Layer 2 and Layer d indicating
// intermediate layers. Inside each layer, a tall vertical white box labelled π denotes a random permutation of
// qubit labels, followed by two rounded rectangles labelled SU(4) (top and bottom) representing two-qubit
// Haar-random unitaries, with vertical ellipsis between them indicating further two-qubit gates. Thin black
// horizontal wires are qubit lines; some pass straight through while others are permuted by the π blocks. Five
// measurement/readout symbols (rectangles containing eye-like icons) terminate the wires on the right, again
// with vertical ellipsis indicating more outputs. The trend is repetition of permutation and entangling SU(4)
// gate layers across d layers to build the benchmark circuit.
#figure(scope: "parent", image("imgs/quantum_volume.png", width: 100%),
  caption: [
    Model circuit for the quantum volume benchmark. Each layer consists of random permutations of qubit labels, followed by application of two-qubit haar-random unitaries. Inspired by @cross2019validating.
  ]
)
<fig:QV_model_circuit>



Given a model circuit $U$ with width $m$, the ideal output distribution over bit strings $x in (0 , 1)^m$ is given by$P_U ( x ) = | chevron.l x | U | 0 chevron.r |^2 .$


One can arrange the probabilities for various bitstrings in ascending order in a set $bb(P) = {p_0 lt.eq p lt.eq dots.h.c lt.eq p_(2^m - 1)} .$ The median of the set $bb(P)$is given by $p_(m e d) = frac(p_(2^(m - 1)) + p_(2^(m - 1) - 1), 2) .$ The Heavy outputs are defined as $H_U = {x in (0 , 1)^m | p_U ( x ) > p_(m e d)} .$ The goal of the heavy output problem is to sample a set of strings such that at least $2 / 3$ are heavy output. For an ideal quantum circuit, the expected heavy output probability asymoptotically tends to $tilde 0.85$. For a completely depolarized device, it is $tilde 0.5 .$


On the target system, one implements $tilde(U)$ by using a circuit compiler with native gate set such that $1 - F_(upright("avg")) (U , tilde(U)) lt.eq epsilon.alt lt.eq 1$ for some approximation error $epsilon.alt$, where $F_(upright("avg"))$ is average gate fidelity, as defined in Ref.~@horodecki1999general. The role of circuit compiler is crucial in the aforementioned step. Suppose the observed distribution for the implemented circuit $tilde(U)$ of the model circuit $U$ is $g_u ( x ) .$ The probability of sampling heavy output is given by


$ h_U = sum_(x in H_U) q_U (x) . $<eq:heavy_output_probability>


For a randomly selected circuit of depth $d$, the probability of sampling a heavy output is given by


$ h_d = integral_U h_U d U . $<eq:depth_d_sampling>


The term $d ( m )$ in @eq:quantum_volume is equal to the largest depth $d$ for model circuit of width $m in (1 , 2 , dots.h.c , n)$ such that $h_d > 2 / 3 .$


The quantum volume benchmark requires simulation of the model circuit's heavy output generation problem on a classical computer. It, hence, is not a scalable method as the quantum volume increases. Moreover, the special treatment for square circuits is not entirely justified. Investigations are needed to devise other interesting benchmarks. A benchmark for rectangular circuits has also been proposed in the literature~@blume2020volumetric.


At the time of writing, Honeywell's system model H1 has achieved $log_2 V_Q = 9$~@Honeywel2021online, and IBM quantum device named "IBM Montreal" has demonstrated $log_2 V_Q = 6$~@ibmnews.


== Cross-entropy benchmarking
<subsec:XEB>


The linear cross-entropy benchmarking is a statistical test used by Google in their quantum supremacy experiment~@arute2019quantum @neill2018blueprint. It measures how often high-probability bitstrings are sampled in an experimental scenario. Suppose we perform a sampling task and obtain bitstrings ${x_j}_j$ via measurement on a given $m$-qubit circuit $cal(C)_E .$ The linear cross-entropy benchmarking fidelity is given by


$ cal(F)_(X E B) = 2^m ⟨P (x_j)⟩_j - 1 . $<eq:Linear_XEB>


Here, the average $⟨.⟩_j$ is over the experimentally observed bitstrings ${x_j}_j$ and $P (x_j)$ denotes the probability of observing bitstring $x_j$ for the ideal circuit version of $cal(C)_E$. In other words, $P (x_j)$ denotes the ideal probability of the generated sample $x_j .$ Since one can not have an ideal circuit in practice, $P (x_j)$ are calculated using a classical computer simulation of the ideal circuit. $cal(F)_(X E B)$ compares how often a bitstring $x_j$ is observed experimentally with its classically simulated ideal probability. For the ideal case, $cal(F)_(X E B)$ approaches unity for a large number of qubits. On the other hand, it is equal to zero for uniform distribution. As the circuit's nose grows, $F_(X E B)$ decreases and approaches zero. Since the probabilities $P (x_j)$ are calculated via classical simulation; it renders the computation of $cal(F)_(X E B)$ intractable in the supremacy regime. The classical hardness of spoofing linear cross-entropy benchmarking was studied by Aaranson and Gunn~@aaronson2019classical, where they suggested the absence of any efficient classical algorithm for the aforementioned task.


== Application benchmarks
<application-benchmarks>


While hardware benchmarks, such as randomized benchmarking or quantum volume, provide valuable insight into the performance of quantum devices, they may not well represent or predict the performance of VQAs which employ structured circuits. Application benchmarks were developed to complement hardware benchmarks and provide a more complete picture of both the performance and (near-term) utility of quantum devices. These benchmarks consist executing experimental demonstrations of VQA instances that can be compared to classically computed exact results. Examples of application benchmarks can be found in Refs.~@dallaire2018quantum @benedetti2019generative @arute2020hartree @karamlou2020analyzing. In particular, @arute2020hartree demonstrated VQE experiments for hydrogen chain binding energy and diazene isomerization mechanism with PQC sizes as big as $12$ qubits and $72$ two-qubit gates.


As a specific example of an application benchmark, quantum circuits that diagonalize spin Hamiltonians have been proposed in recent years @verstraete2009quantum @schmoll2017kitaev @cervera2018exact. By comparing the results obtained from the quantum device with the analytical solution, one can discern the performance of the computation for a specific purpose experiment. Small experiments have shown that gate fidelities and decoherence times alone do not provide a complete picture of the noise model @cervera2018exact.


In that direction, authors of @dallaire2020application proposed a figure-of-merit called the #emph[effective fermionic length] to quantify the performance of a NISQ device in which the application-at-hand is estimating the energy density of the one-dimensional Fermi-Hubbard model over increasing chain lengths. Theoretically, as the chain length increases, the energy density should approach the infinite chain limit. In practice, the NISQ device will accrue some level of noise and decoherence, which will cause the computed energy density to diverge past some chain length. The maximum chain length after which noise and decoherence start degrading the algorithm performance reveals the "limit" of the quantum device in carrying out related algorithms. Ref.~@dallaire2020application abstracts this idea to redefine an application benchmark as a way to systematically test the limits of a quantum processor using exactly solvable VQA instances that can also be scaled to larger system sizes (e.g chain length in Ref.~@dallaire2020application or number of preprocessing steps in Ref.~@karamlou2020analyzing).


Generative models such as the QCBM (see @sec:unsupervised_learning) can serve as benchmarks for NISQ devices~@leyton2019robust @hamilton2019generative @zhu2019training. Here, the measurement output of hardware efficient variational ansäte are used to represent different types of distributions and study the effect of noise and hardware limitations on the result.


In addition to VQAs, one can analyze more fundamental benchmarks, such as the ability of NISQ devices to violate local-realism by means of Mermin inequalities @alsina2016experimental or the entanglement power of the devices by trying to construct maximal entangled states @wang201816 @cervera2019quantum.


== Quantum software tools
<sec:software>


// [figvision] imgs/NISQ_software.png
// This single-panel schematic flowchart depicts a standard NISQ programming workflow without lettered
// sub-panels. Four green ovals denote libraries and languages: "Libraries for chemistry, ML, etc." at top left
// feeds "Problem definition: cost function, circuit ansatz, initialization" in a light blue box; "Quantum
// language" lies beneath it; "Assembly language" sits center; "Settings for compiler, error mitigation, noise
// model" occupies bottom left. Additional light blue boxes are Quantum circuit, Quantum instructions, Quantum
// compiler, Optimizer, Optimization libraries, and Classical postprocessing. Dark blue rectangles mark Quantum
// device and Quantum simulator; a red rectangle marks Result. Black arrows run from Problem definition to
// Quantum language to Quantum circuit to Quantum compiler, which branches to Quantum instructions and Quantum
// simulator. Quantum instructions receive Assembly language and feed Quantum device; both device and simulator
// feed Classical postprocessing, which leads downward to Result. Optimization libraries and Optimizer occupy the
// top right, with Optimization libraries also connecting vertically to Quantum device and Classical
// postprocessing.
#figure(scope: "parent", image("imgs/NISQ_software.png", width: 100%),
  caption: [
    Schematic representation of a standard NISQ programming workflow (color online). Green circular boxes represent the libraries and languages used for designing, optimizing and running a quantum algorithm in a real quantum device or in a simulator. External libraries can be used to define the problem or to improve the performance of the algorithm by simplifying the circuit or using error-mitigation techniques. An assembly language will be needed to translate the theoretical algorithm to a set of physical operations on the quantum hardware. Classical post-processing is necessary to manipulate the result of the computation and to either obtain the final result or send the provisional one to a classical optimizer (VQA).
  ]
)
<fig:software>



A quantum computer is a hybrid device composed of quantum hardware and classical software that controls it by sending a list of instructions and processing the results of the computation. This hybrid nature is accentuated in the NISQ era, as explained in the current review. Thus, the classical subroutines are part of the core in state-of-the-art NISQ algorithms and a language to communicate with the quantum device is a bare necessity. On top of that, almost all progress in quantum algorithms is tested in quantum simulators making them essential to perform proof-of-concept simulations, before or until the algorithm is applicable on real devices.


@fig:software represents diagrammatically the typical workflow of a NISQ algorithm. The individual parts of the problem, such as the objective function to optimize, the quantum circuit design or the initialization parameters, are translated into quantum circuits by a classical pre-computation step. The syntax of this language includes the quantum gates, qubit initialization, objective function definition, etc. The theoretical circuit is then compiled to fulfill experimental limitations such as qubit connectivity, native quantum gate set or circuit depth. To accomplish this task, compilers that allow for circuit simplification (see @sec:compilers), or noise models (for simulation purposes) might be useful. After this pre-processing step, the algorithm is ready to enter into the quantum-classical loop. The quantum circuit can be run in a quantum simulator or real hardware. In the latter case, an assembly language @cQASM @OpenQASM @pyquil @strawberry will translate the quantum circuit into a set of instructions for the device. After the qubits are measured, the result can be post-processed and techniques such as error mitigation might be used. Either the algorithm finishes or the result is sent to the classical optimizer that computes the next loop variables (e.g. for VQA).


We define a #emph[quantum software library] as a library or a set of libraries written in a classical programming language (e.g. python or C++) that allows writing a quantum program. In some cases, these libraries are open-source and can be used directly on real hardware or on a quantum simulator. The proliferation of all these libraries, simulators and devices has also created a necessity for some multi-platform languages. These are those that can use multiple quantum software libraries as a backend, reducing the programming efforts substantially by unifying the language syntax. Some of these packages include built-in sub-libraries suited for particular applications, from chemistry to QML, or particular well-known algorithms such as VQE or QAOA.


We provide a list of some open-source libraries suited for NISQ computation in @tab:software from App.~@app:tables. This list represents just a snapshot of the state-of-the-art of the quantum software ecosystem as new tools are being developed and some projects are being abandoned. An updated list of quantum software resources can be found in Ref. @qcreports @awesomeqosf and a detailed comparison analysis between some of these languages and libraries in Ref. @gay2006quantum @nguyen2020extending @heim2020quantum @garhwal2019quantum. Due to the broad applications of NISQ algorithms, specific libraries used in other fields beyond quantum computation can also be required, e.g. quantum chemistry and machine learning libraries or external compilers and simulators. These libraries are used for other applications besides purely quantum computation, so we consider and list them as external libraries in @tab:ext_soft from App.~@app:tables, although most of them integrated in the quantum software libraries.


= OUTLOOK
<ch:outlook>


In the last decade, quantum computing has experienced notable progress in applications, experimental demonstrations, and theoretical results. The number of papers in quantum computation, particularly in NISQ applications, is growing almost exponentially. Several reasons explain this community drive, one of those being tremendous improvements in quantum hardware. Quantum computing is a relatively young field in science and, as such, there is plenty of room for pioneering research and discoveries. This fact, together with the theoretical, practical, and experimental challenges (several of them covered in this review), has strengthened the motivation for an open-source strategy in the field. Nowadays, many universities and research centers subscribe to an open-access policy that pushes towards the free and open-source publication of all computational tools, data, and programs used in their research. These policies have proved valuable for rapid scientific development as well as for democratizing community knowledge. This way of thinking has percolated through academia walls and it has been introduced into several private companies, not just for its advantage, but also because it facilitates the continuous healthy flow of quantum computing researchers to themselves (and, in some cases, resulting in foundation of startups). Consequently, there is a rich open quantum computing ecosystem composed of universities, institutes, big corporations, startups, and uncountable individual enthusiasts. Another product of the symbiosis between academia and the private sector is #emph[cloud quantum computing]. Companies are offering access to their hardware remotely, in some cases at zero-cost for their small prototypes and simulators. On the one hand, scientists and quantum computing enthusiasts around the world have the opportunity to experience real quantum devices from their homes. On the other hand, this increases the chances of finding real-world applications in quantum computation and solving the current challenges of this field. The proliferation of open-source quantum computing languages, simulators, and tools (detailed in @sec:software) have burgeoned many user communities. Various international initiatives have been set up to attract quantum computing talent, and the private sector's involvement is ramping up. Several non-profit initiatives are also encouraging the use and development of these tools @unitaryfund @QOSF.


Experimental realizations of quantum computation, although in the early stages, have interested many communities in this quantum information subfield. Healthy competition has also arisen between the classical and quantum computing branches. Classical computational scientists have put their efforts into moving the quantum advantage frontier further, raising the bar to claim that a quantum algorithm shows a significant speed-up. Along that direction, an off-shoot is an effort in #emph[dequantization], first exhibited in the case of recommendation-systems, to devise quantum-inspired classical algorithms that are nearly as fast as their quantum counterparts~@tang2019quantum. Such attempts have eliminated examples of speed-up for some problems in linear algebra. So far, dequantized machine learning algorithms have been developed for recommendation systems~@tang2019quantum, principal component analysis and supervised clustering~@tang2018quantum, stochastic regression~@gilyen2018quantum and low-rank linear systems @chia2018quantum @arrazola2019quantum.


Since NISQ devices are inherently noisy, analysis similar to~@napp2019efficient @zlokapa2020boundaries @zhou2020limits will be required to find out how much noise a NISQ algorithm can endure until its classical simulation becomes efficient. This is crucial in order to understand the boundary where quantum computers provide an advantage. Investigating the potential of NISQ algorithms using ideas from quantum foundations such as contextuality and entanglement are helpful in that respect @deutsch2020harnessing @bharti2020machine. More theoretical results as the ones presented in @farhi2016quantum @lloyd2018quantum @biamonte2019universal @bravyi2020quantum @bravyi2021classical @bouland2021noise @movassagh2019quantum may also prove valuable. It is also imperative to develop strategies that help us bypass complicated measurements involving controlled multi-qubit unitaries~@mitarai2019methodology. For machine learning tasks, ideas similar to~@harrow2020small would be valuable.


Another fascinating frontier that needs to be investigated in the next few years, we believe, is quantum and classical certification schemes for quantum devices and quantum computation ~@eisert2020quantum. The intractability of quantum computation by classical devices poses the challenge to verify the correct functioning of the quantum devices as well as the correctness of the final output~@eisert2020quantum. The existence of multiple quantum computing platforms requires new methodologies and figures of merit to benchmark and compare these devices. Other works are being proposed in that direction @kyaw2020quantum @kottmann2020quantum, as well as the development of benchmarking measures discussed in @sec:benchmark. Ideas from complexity theory~@mahadev2018classical @metger2020self and quantum foundations~@bharti2019local @bharti2019robust could be valuable in this direction.


At the moment of documenting this review, there is no known demonstration of industrially relevant quantum advantage. Quantum computing is still in its early days, and so far a useful quantum computer is missing. The potential of NISQ devices is not fully understood, and a lot of rigorous research is required to release the power of the early quantum computers. However, a number of experiments overcoming classical computational resources have been performed and many theoretical and practical tools are being used and developed, as explained in @ch:lemon.


== NISQ goals
<nisq-goals>


We expect experimental pursuit in the NISQ era would focus on the design of quantum hardware with a larger number of qubits, and gates with lower error rates capable of executing deeper circuits. Along the way, one of the goals is to demonstrate quantum advantage for practical use cases. If the NISQ paradigm is not powerful enough to exhibit any quantum advantage, theoretical pursuits would be required to understand its limitations. The prime direction of the NISQ and near-term era is to engineer the best possible solution with the limited quantum resources available. The tools and techniques invented during this period could be valuable in the fault-tolerant era as well.


To conduct a successful demonstration of quantum advantage, the right blend of the following three crucial components is required:

+ #emph[Hardware development:] The design of quantum computers with more qubits, lesser error rates, longer coherence times, and more connectivity between the qubits will be one of the top priorities in the NISQ era. Intensive research in new qubits developments, quantum optimal control and material discovery will be indispensable for both universal programmable quantum computers or special-purpose ones. A way to scale up the number of qubits present in a quantum platform is to design a novel qubit which has built-in autonomous quantum error correction down to the hardware level @paz1998continuous @chamberland2020building or protected novel qubit @douccot2012physical @nataf2011protected @kyaw2019towards which is robust against specific noises in the hardware. As a quantum processor size grows, there is a tremendous need to store quantum information during quantum information processing @kyaw2014z_2 @kyaw2015scalable @kyaw2015creation. Even miniaturizing microwave circulator onto the superconducting chip @mahoney2017chip @chapman2017widely can be seen as a mean to scale up the quantum platform although it has nothing to do with novel qubit design.

+ #emph[Algorithm design:] To harness the potential of noisy but powerful quantum devices, we expect breakthroughs on the algorithm frontier. Algorithms with realistic assumptions, as the ones mentioned in @sec:compilers, regarding device capabilities will be favored. To lessen the effect of noise, progress towards the design of error mitigation algorithms is expected. Efforts have to be made to develop algorithms that harness the problem's structure in the best possible manner and map it to the given hardware in efficient ways, such as in @sec:digi-ana. VQA with better expressibility and trainability will also be helpful.

+ #emph[Application problem:] We have discussed the existing applications of NISQ devices in many areas in @ch:application. Collaborations between experts with domain knowledge from these fields and quantum algorithm researchers will be required more and more to develop the field and integrate quantum computation into industrial workflows. New collaborations might reveal difficult problems for classical computers that are well suited for NISQ devices. It is not clear yet which applications will be the first ones to witness quantum advantage, though there is plenty of speculation and opinions.


== Long-term goal: fault-tolerant quantum computing
<subsec:fault-tolerance>


Noise is regarded as one of the most prominent threats to a quantum computer's practical realization. In 1995, Peter Shor established that by encoding quantum information redundantly using extra qubits, one could circumvent the effect of noise~@shor1995scheme. The quantum information is spread over multiple physical qubits to generate a logical qubit~@calderbank1996good @knill1997theory @gottesman1997stabilizer @shor1995scheme. Most of the transformative algorithms such as Shor's factoring algorithm, Grover search algorithm, and HHL require error-corrected qubits for their execution. Soon after Shor's error-correcting code, many others were developed. Some of the famous error-correcting codes are stabilizer and topological error-correcting codes @terhal2015quantum @fowler2012surface. While the stabilizer code utilizes extra qubits to protect the logical qubit, topological codes employ a set of qubits positioned on a surface, such as a torus, in a lattice structure.


Over the years, quantum error correction has evolved as a subfield of quantum computation and has transformed from a theoretical pursuit to a practical possibility. The process of detecting and correcting errors can be, itself, prone to noise. Thus error correction alone does not guarantee the prospect of storing or processing quantum information for an arbitrarily long period. The aforesaid issue can be tackled by utilizing the #emph[Quantum Fault-Tolerant threshold theorem]. Informally speaking, it is possible to execute arbitrarily large quantum computation by arbitrarily suppressing the quantum error rate, given the noise in the individual quantum gates are below a certain threshold~@aharonov2008fault. If one wants to simulate an ideal circuit of size $N$, the size of the noisy quantum circuit for fault-tolerant quantum computation scales $O (N (log N)^c)$, for some constant $c$, given the noisy circuit is subjected to stochastic noise strength $p < p_c$ for some noise threshold $p_c$ @terhal2015quantum. This theorem rises some practically relevant questions such as #emph[i)] How high is $p_c$\; #emph[ii)] what is the value of the constant $c$\; and #emph[iii)] what is the value of the multiplicative constant in $O (.)$. These questions determine the practicality of any fault-tolerant quantum computation scheme~@terhal2015quantum.


Looking forward, lowering the noise level will be a critical challenge. Though the problem is demanding, significant progress has been made recently at the algorithmic as well as hardware frontier~@lidar2013quantum @terhal2015quantum @campagne2020quantum @noh2020fault. Quantum error-correcting codes amenable to architectures with limited qubit connectivity have also been proposed~@chamberland2020topological. As we transition towards fault-tolerant quantum computing, partial quantum error correction demonstrations such as exponential suppression of bit or phase errors~@ai2021exponential and approximate quantum error correction schemes~@leung1997approximate @faist2020continuous become highly relevant. Recently, Monroe and Brown's groups have confirmed the first-ever fault-tolerant operation on a logical qubit~@egan2020fault.


We are at an exciting juncture in the history of computing. Completely new kinds of computers that were once only figments of imagination are rapidly becoming a reality. The NISQ era offers fantastic opportunities to current and future researchers to explore the theoretical limits of these devices and discover practical and exciting applications in the near-term. Theoretical investigations and experimental challenges will help us to comprehend quantum devices power and build better algorithms. The success of the field lies in the hands of the researchers and practitioners of the area, so we encourage everyone with interest to join the effort.


#heading(level: 1, numbering: none)[Acknowledgements]
<acknowledgements>


A.A.-G. acknowledges the generous support from Google, Inc. in the form of a Google Focused Award. This work was supported by the U.S. Department of Energy under Award No. DESC0019374 and the U.S. Office of Naval Research (ONS506661). A.A.-G. also acknowledges support from the Canada Industrial Research Chairs Program and the Canada 150 Research Chairs Program. T.H. is supported by a Samsung GRC project and the UK Hub in Quantum Computing and Simulation, part of the UK National Quantum Technologies Programme with funding from UKRI EPSRC grant EP/T001062/1. L.-C.K and K.B acknowledge the financial support from the National Research Foundation and the Ministry of Education, Singapore. We thank Michael Biercuk, Naresh Boddu, Zhenyu Cai, Sam Gutmann, Edward Farhi, Rahul Jain, Dax Koh, Alejandro Perdomo-Ortiz and Mark Steudtner for interesting discussions, feedback and comments.








#block[
]


#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "../../typst-refs/rmp.csl", title: [References])

#pagebreak()
#set page(columns: 1)
#set text(size: 9pt)
= NISQ ALGORITHMS AND TOOLS TABLES
<app:tables>


== Tables of applications
<tables-of-applications>

#figure(
  table(
    columns: (0.5fr, 1fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Algorithm/Application*], [*Proposed implementations*],
    table.cell(colspan: 2)[Variational quantum eigensolver (VQE) and related solvers],
    [VQE], [@mcclean2016theory @peruzzo2014variational @wecker2015progress],
    [Adaptive VQE], [@grimsley2019adaptive @ryabinkin2018qubit @sim2020adaptive @kottmann2020feasible @zhang2020mutual @tang2019qubit @gomes2021adaptive @stair2021simulating],
    [IQAE], [@bharti2020iterative @bharti2020quantumeigensolver],
    [Krylov approaches], [@stair2020multireference @huggins2020non @jouzdani2020hybrid],
    [Imaginary time evolution], [@motta2020determining @sun2020quantum @mcardle2019variational @bharti2020quantum],
    [Full quantum eigensolver (FQE)], [@wei2020full],
    table.cell(colspan: 2)[VQE for excited states],
    [Folded spectrum], [@peruzzo2014variational @ryabinkin2018constrained],
    [Orthogonally constrained VQE], [@higgott2019variational @lee2018generalized @kottmann2020feasible],
    [Subspace expansion and linear-response based], [@mcclean2017hybrid @takeshita2020increasing @ollitrault2020quantum],
    [Subspace-search VQE], [@nakanishi2019subspace],
    [Multistate contracted VQE], [@parrish2019quantum],
    [Fourier transform of evolutions], [@aleiner2020accurately @roushan2017spectroscopic],
    [WAVES], [@santagati2018witnessing],
    [Adiabatically-Assisted], [@mcclean2016theory @garcia2018addressing],
    [Projected VQE], [@stair2021simulating],
    table.cell(colspan: 2)[Hamiltonian simulation],
    [Variational quantum simulator (VQS)], [@li2017efficient @mcardle2019variational @yuan2019theory @endo2020variational @kubo2020variational @benedetti2020hardware],
    [Subspace VQS], [@heya2019subspace],
    [projected-Variational Quantum Dynamics (p-VQD)], [@barison2021efficient @otten2019noise],
    [Variational fast forwarding], [@cirstoiu2020variational @commeau2020variational],
    [Quantum assisted simulator], [@bharti2020quantum],
    table.cell(colspan: 2)[Quantum information scrambling and thermalization],
    [Scrambling], [@joshi2020quantum @landsman2019verified @holmes2020barren @mi2021information],
    [Thermal state], [@verdon2019quantum],
    table.cell(colspan: 2)[Open quantum systems],
    [Generalized VQS], [@endo2020variational @yuan2019theory @liu2020solving],
    [Generalized quantum assisted simulator], [@haug2020generalized],
    [Trotter simulation], [@koppenhofer2020quantum @hu2020quantum],
    table.cell(colspan: 2)[State preparation],
    [Non-equilibrium steady state], [@yoshioka2020variational@kreula2016non @jaderberg2020minimum @endo2020calculation],
    [Gibbs-state], [@endo2020variational @chowdhury2020variational @haug2020generalized],
    [Many-body ground state], [@ho2019efficient @ho2019ultrafast @wauters2020polynomial],
    table.cell(colspan: 2)[Quantum autoencoder],
    [Quantum autoencoder], [@romero2017quantum @bravo2020quantum2 @pepper2019experimental @huang2020experimental @huang2020realization @bondarenko2020quantum],
    table.cell(colspan: 2)[Quantum computer-aided design],
    [Optical setups], [@kottmann2020quantum],
    [Superconducting circuits], [@kyaw2020quantum],
  ),
  caption: [NISQ algorithms for Many-body physics and chemistry applications from @sec:chemistry.],
  placement: none,
) <tab:many_body>

#figure(
  table(
    columns: (0.5fr, 1fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Algorithm/Application*], [*Proposed implementations*],
    table.cell(colspan: 2)[Supervised learning],
    [Quantum kernel methods], [@havlivcek2019supervised @kusumoto2019experimental @schuld2019quantum @schuld2020measuring @peters2021machine],
    [Variational quantum classifiers (VQC)], [@farhi2018classification @mitarai2018quantum @vidal2019input @lloyd2020quantum @perez2020data @schuld2020circuit @schuld2020effect],
    [Encoding strategies in VQA], [@mitarai2019generalization @cervera2020meta],
    [Quantum reservoir computing], [@fujii2017harnessing @nakajima2019boosting @nokkala2020gaussian @ghosh2019quantum @negoro2018machine @chien2020custom @mitarai2018quantum],
    [Supervised QUBO classifier], [@li2018quantum],
    table.cell(colspan: 2)[Unsupervised learning],
    [Quantum Boltzmann machines (QBM)], [@amin2018quantum @kieferova2017tomography @zoufal2020variational],
    [Energy-based models (e.g., RBMs)], [@benedetti2016estimation @benedetti2017quantum @benedetti2018quantum],
    [Quantum circuit Born machines (QCBM)], [@zhu2019training @benedetti2019generative @liu2018differentiable @leyton2019robust @hamilton2019generative @rudolph2020generation @coyle2020quantum @alcazar2020classical],
    [Quantum generative adversarial networks (QGAN)], [@dallaire2018quantum @lloyd2018quantumgenerative @zeng2019learning @romero2019variational @situ2020quantum @hu2019quantum],
    table.cell(colspan: 2)[Reinforcement learning],
    [Reinforcement learning], [@chen2020variational @lockwood2020reinforcement @lockwoodplaying @crawford2016reinforcement @lamata2017basic @cardenas2018multiqubit @albarran2020reinforcement @yu2019reconstruction @jerbi2019quantum],
  ),
  caption: [NISQ algorithms for machine learning applications from @sec:QML.],
  placement: none,
) <tab:ml_algorithms>

#figure(
  table(
    columns: (0.5fr, 1fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Algorithm/Application*], [*Proposed implementations*],
    [Max cut], [@farhi2014quantum @otterbach2017unsupervised @hastings2019classical @bravyi2019obstacles @headley2020approximating @satoh2020subdivided],
    [Max clique], [@banchi2020molecular @arrazola2018using],
    [Triangle finding], [@metwalli2020finding],
    [Maximum independent set], [@choi2020quantum @saleem2020max @utkarsh2020solving],
    [Max hafnian], [@arrazola2018quantum],
    [Vertex cover], [@cook2019quantum],
    [Exact cover], [@bengtsson2020improved @vikstaal2020applying @garcia2018addressing],
    [Knapsack], [@grandrive2019knapsack],
    [Graph multi-coloring], [@oh2019solving],
    [Fault diagnosis], [@perdomo2015quantum @perdomo2019readiness],
    [Bayesian networks], [@o2015bayesian],
    [Protein folding], [@benedetti2016estimation @perdomo2008construction @babbush2014adiabatic @fingerhuth2018quantum @robert2021resource @babej2018coarse @perdomo2012finding],
  ),
  caption: [NISQ algorithms for combinatorial optimization from @sec:optimization.],
  placement: none,
) <tab:combinatorial>

#figure(
  table(
    columns: (0.5fr, 1fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Algorithm/Application*], [*Proposed implementations*],
    [Factoring], [@anschuetz2019variational @karamlou2020analyzing],
    [SVD], [@bravo2020quantum @wang2020variational],
    [Linear systems], [@bravo2019variational @huang2019nearterm @xu2019variational2],
    [Non-linear differential equations], [@lubasch2020variational @haug2020generalized @gaitan2020finding @kyriienko2020solving],
    [Semidefinite programming], [@bharti2021nisq],
  ),
  caption: [NISQ algorithms for numerical solvers applications from @sec:numerical_solvers.],
  placement: none,
) <tab:numerical_solvers>

#figure(
  table(
    columns: (0.5fr, 1fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Algorithm/Application*], [*Proposed implementations*],
    [Portfolio optimization], [@alcazar2021enhancing @bouland2020prospects @cohen2020portfolio @marzec2016portfolio @rosenberg2016solving @venturelli2019reverse @egger2020quantum],
    [Fraud detection], [@egger2020quantum @egger2020warm @zoufal2020variational],
    [Option pricing], [@kubo2020variational],
  ),
  caption: [NISQ algorithms for finance applications from @sec:finance],
  placement: none,
) <tab:finance>

#figure(
  table(
    columns: (0.5fr, 1fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Algorithm/Application*], [*Proposed implementations*],
    table.cell(colspan: 2)[Quantum foundations],
    [Bell inequalities], [@alsina2016experimental],
    [Contextuality], [@kirby2019contextuality @kirby2020contextual],
    [Variational consistent history (VCH)], [@arrasmith2019variational],
    table.cell(colspan: 2)[Quantum optimal control],
    [Quantum optimal control], [@magann2020pulses @li2017hybrid @dive2018situ @lu2017enhancing @policharla2020algorithmic],
    table.cell(colspan: 2)[Quantum metrology],
    [Quantum metrology], [@beckey2020variational @kaubruegger2019variational @koczor2020variational @ma2020adaptive @meyer2020variational],
    table.cell(colspan: 2)[Fidelity estimation],
    [Fidelity estimation], [@cerezo2020fidelity],
    table.cell(colspan: 2)[Quantum error correction (QEC)],
    [Quantum variational error corrector (QVECTOR)], [@johnson2017qvector],
    [Variational circuit compiler for QEC], [@xu2019variational],
    table.cell(colspan: 2)[Nuclear physics],
    [Schwinger model], [@hauke2013quantum @martinez2016real @klco2018quantum @kokail2019self @avkhadiev2020accelerating],
    [High-energy processes], [@dumitrescu2018cloud @liu2020quantum @roggero2020quantum @wu2020application @chen2020quantum @perez2020determining],
    table.cell(colspan: 2)[Entanglement properties],
    [Schmidt decomposition], [@bravo2019variational @wang2020detecting],
    [Multipartite entanglement], [@perez2020measuring],
    [Entanglement spectrum], [@larose2019variational @cerezo2020variational],
  ),
  caption: [NISQ algorithm for other applications listed in @sec:other_app.],
  placement: none,
) <tab:other_app>

#pagebreak()



== Table of software packages
<table-of-software-packages>

#figure(
  table(
    columns: (1fr, 0.333333fr, 0.277778fr, 0.444444fr, 0.722222fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Name*], [*Language*], [*Hardware*], [*Multi-platform*], [*Built-in applications*],
    [Cirq @cirq], [python], [Yes], [No], [Chemistry, ML, Noise characterization, Optimization],
    [DQCSim @DQCsim], [python, C++, Rust], [No], [No], [--],
    [IQS @intel], [C++], [No], [No], [QAOA],
    [$|"Lib" chevron.r$@Lib], [python, C++], [Yes\*\*], [Yes], [--],
    [Pennylane @pennylane], [python], [Yes\*\*], [Yes], [ML, Optimization],
    [ProjectQ @projectq], [python], [Yes\*\*], [Yes], [Fermionic simulation, Optimization],
    [pyquil/Forest @pyquil], [python, Lisp], [Yes], [No], [VQE, QAOA, Noise characterization, Optimization],
    [QDK @qsharp], [python, C\#, Q\#], [Yes\*\*], [No], [Chemistry, Optimization],
    [Qibo @qibo], [python], [Yes\*], [Yes], [VQE, QAOA, Adiabatic evolution, Optimization],
    [Qiskit @Qiskit], [python], [Yes], [No], [Chemistry, ML, Optimization, Finance, Noise characterization],
    [QTensor @qtensor], [python, C++], [No], [No], [Tensor-Network simulator, quantum circuit simulator, QAOA],
    [QuEST @quest @jones2020questlink], [C++, Mathematica], [No], [Yes], [--],
    [Quimb @quimb], [python], [No], [No], [Tensor-Network simulator, quantum circuit simulator],
    [Qulacs @qulacs], [python, C++], [No], [No], [Simulator, noise characterization],
    [StrawberryFields @strawberry], [python], [Yes\*], [No], [GBS],
    [Tequila @tequila], [python], [Yes\*\*], [Yes], [Chemistry, ML, Noise characterization, Optimization],
    [XACC @xacc], [python, C++], [Yes\*\*], [Yes], [Optimization, VQE, QAOA, RBM and other algorithms],
    [Yao @yao], [Julia], [No], [No], [--],
  ),
  caption: [List of open-source quantum software libraries. These packages are designed using common computing languages such as python, C++ or Julia. Some of them can be used in real quantum hardware, either because the developers are also building these devices or because the package include other quantum libraries. Some of them can translate their code to other quantum libraries or simulators. 
 \*Hardware not publicly available yet. \*\*Not on own hardware but can be run in a hardware backend.],
  placement: none,
) <tab:software>

#pagebreak()



== Table of external libraries
<table-of-external-libraries>

#figure(
  table(
    columns: (1fr, 0.5fr, 0.5fr),
    stroke: (x: none, y: 0.4pt),
    inset: (x: 4pt, y: 3pt),
    align: left,
    [*Name*], [*Language*], [*Application*],
    [OpenFermion @OpenFermion], [python], [Chemistry],
    [psi4 @psi4], [python], [Chemistry],
    [PySCF @pyscf1 @pyscf2], [python], [Chemistry],
    [NWChem @nwchem], [Fortran 77, C], [Chemistry],
    [EntropicaQAOA @EntropicaQAOA], [python], [QAOA],
    [TensorFlowQ @TFQ], [python], [QML],
    [TensorFlow @TF], [python], [ML],
    [Mitiq @larose2020mitiq], [python], [Error Mitigation],
    [pyzx @pyzx], [python], [Compiler],
    [quilc @quilc], [quil], [Compiler],
    [Q-Convert @qconvert @qconvert_js], [JavaScript, python], [quantum language converter],
    [iTensor @itensor], [Julia,C++], [Tensor Networks],
    [OpenQL @OpenQL], [python, C++], [Compiler],
    [JKQ @JKQ], [C++], [Simulator and Compiler],
    [ScaffCC @scaffcc], [Scaffold], [Compiler],
    [staq @staq], [C++], [Compiler],
    [Silq @silq], [D], [Compiler],
    [QX simulator @QXsim], [python, C++], [Simulator],
    [QRACK @qrack], [C++], [Simulator],
    [quantum-circuit @qsimulator], [JavaScript], [Simulator],
    [QuTip @Qutip], [python], [Quantum Info. SDK],
    [Q-Ctrl @QCtrl], [python], [Quantum Control],
  ),
  caption: [External open-source libraries useful for the NISQ era. These libraries have applications in chemistry, machine learning, circuit compilation and quantum control. Some of them are integrated in the quantum software libraries listed in @tab:software.],
  placement: none,
) <tab:ext_soft>

#pagebreak()
#set page(columns: 2)
#set text(size: 10pt)

= CLASSICAL OPTIMIZATION STRATEGIES
<classical-optimization-strategies>
In this section, we detail the algorithms and strategies used to optimize the parameters of the PQC. For completeness, we reproduce part of the text shown in the main article and add the corresponding details on the methods.


== Gradient-based approaches
<gradient-based-approaches>


==== Finite difference.
<finite-difference.>
This method approximates the gradient of a function $f ( theta )$ as follows:


$ partial_i f ( bold(theta) ) approx frac(f ( bold(theta) + epsilon.alt upright(bold(e))_i ) - f ( bold(theta) - epsilon.alt upright(bold(e))_i ), 2 epsilon.alt) , $


where $epsilon.alt$ is a small number and $upright(bold(e))_i$ is the unit vector with 1 as its $i$-th element and 0 otherwise. The smaller $epsilon.alt$, the closer the right-hand side of above formula is to the true value of the gradient. However, for small $epsilon.alt$ the difference of the numerator becomes small as well. As the objective function is an expectation value sampled from the quantum device and it is only estimated with limited accuracy, smaller $epsilon.alt$ require more samples taken from the quantum hardware to achieve a good estimation of the gradient.


==== Parameter-shift rule.
<parameter-shift-rule.>
The analytical gradient can be calculated on quantum hardware using the parameter-shift rule, which was originally proposed in @romero2018strategies and developed in~@mitarai2018quantum @schuld2019evaluating. A key advantage is that the gradient is exact even if the difference parameter $epsilon.alt$ is chosen to be a large number (commonly $epsilon.alt = pi / 2$), avoiding the issues of the finite difference method. We assume that the unitary to be optimized can be written as $U ( bold(theta) ) = V G ( theta_i ) W$, where $G = e^(- i theta_i g)$ is the unitary affected by the parameter $theta_i$, $g$ is the generator of $G$ and $V , W$ are unitaries independent of $theta_i$. If $g$ has a spectrum of two eigenvalues $plus.minus lambda$ only, the gradient can be calculated by measuring the observable at two shifted parameter values as follows:


$ partial_i chevron.l f ( bold(theta) ) chevron.r = lambda (chevron.l f ( bold(theta)_(+) ) chevron.r - chevron.l f ( bold(theta)_(-) ) chevron.r) , $


where $bold(theta)_plus.minus = bold(theta) plus.minus ( pi / 4 lambda ) bold(e)_i$.


This rule can be generalised to the case where the generator $g$ does not satisfy the eigenspectrum condition by decomposing the unitary into commuting terms as $G = G_1 G_2 . . G_n = e^(- i theta_i ( g_1 + g_2 + . . + g_n ))$, where the generator $g_m$ of $G_m = e^(- i theta_i g_m)$ satisfies that condition. We can then use the parameter-shift rule on each $G_m$ and calculate the analytical gradient using the product rule. This has been further developed for calculating analytical gradients for fermionic generators of Unitary Coupled-Cluster operators~@kottmann2020feasible and higher order derivatives~@mari2020estimating.


One can also use an auxiliary qubit and controlled unitaries to evaluate the gradient of multi-qubit unitaries where the parameter-shift rule does not apply. This was originally proposed in the context of unitary coupled-cluster~@romero2018strategies and later generalized for arbitrary gradients~@schuld2019evaluating @yuan2019theory. A further alternative is the stochastic parameter-shift rule~@banchi2020measuring, which relies on stochastically sampling scaled evolutions of the generator.


==== L-BFGS.
<l-bfgs.>


It is a quasi-Newton method that efficiently approximates the “inverse Hessian” using a limited history of positions and gradients @liu1989limited. "Inverse Hessian" refers to the inverse of the Hessian matrix, where Hessian is a square matrix of second-order partial derivatives of the loss function. The inverse Hessian is employed to adjust gradient updates to the current loss landscape. L-BFGS is a memory-efficient variant of the BFGS method, which stores dense approximations of the inverse Hessian @fletcher2000mathematics. While effective in simulations, recent studies observed BFGS methods do not perform well in experimental demonstrations of VQA due to the level of noise in the cost function and gradient estimates @lavrijsen2020classical.


Two heuristics were proposed to find quasioptimal parameters for QAOA using BFGS #cite(<zhou2020quantum>): #emph[i)] #smallcaps[INTERP], where the optimized parameters at QAOA level $p$ are linearly interpolated and used as initial parameters for the level $p + 1$ optimization; and #emph[ii)] #smallcaps[FOURIER], where instead of optimizing the $2 p$ QAOA parameters $bold(gamma)$ and $bold(beta)$ in @eq:QAOA_evolved_state, one can instead optimize $2 q$ new parameters $bold(u) equiv ( u_1 , u_2 , dots.h u_q )$ and $bold(v) equiv ( v_1 , v_2 , dots.h v_q )$ defined via the discrete sine and cosine transformations


$ gamma_i ( beta_i ) = sum_(j = 1)^q u_j ( v_j ) sin ( cos ) \[(i - 1 / 2) (j - 1 / 2) pi / p\] . $


Similarly to #smallcaps[INTERP], the optimal parameters found at level $p$ are used to initialize the parameters for level $p + 1$. Efficient initialization of parameters has also been reported using the Trotterized quantum annealing (TQA) protocol~@sack2021quantum. Note that these heuristic strategies can be easily extended to gradient-free optimization methods such as Nelder-Mead.


==== Quantum natural gradient.
<quantum-natural-gradient.>
The update rule of standard gradient descent @eq:grad_update has the implicit assumption that the underlying parameter space is a flat Euclidean space. However, in general this is not the case, which can severely hamper the efficiency of gradient descent methods. In classical machine learning, the natural gradient was proposed that adapts the update rule to the non-Euclidean metric of the parameter space~@amari1998natural. As an extension to the realm of parameterized quantum circuits, the quantum natural gradient (QNG) has been proposed~@stokes2020quantum. The update rule for this method is


$ theta_i^(( t + 1 )) = theta_i^(( t )) - eta med cal(F)^(- 1) ( bold(theta) ) partial_i f ( bold(theta) ) thin , $<eq:natural_grad_update_sup>


where $cal(F) ( bold(theta) )$ is the Fubini-Study metric tensor or quantum Fisher information metric given by


$ cal(F)_(i j) = upright("Re") ( chevron.l partial_i psi ( bold(theta) ) | partial_j psi ( bold(theta) ) | - chevron.r chevron.l partial_i psi ( bold(theta) ) | psi ( bold(theta) ) | chevron.l chevron.r | psi ( bold(theta) ) | partial_j psi ( bold(theta) ) chevron.r ) thin . $<eq:Fubiny_Study_sup>


Superior performance of the QNG compared to other gradient methods has been reported~@yamamoto2019natural @stokes2020quantum and it has been shown that it can avoid becoming stuck in local minima~@wierichs2020avoiding. It can be generalized to noisy quantum circuits~@koczor2019quantum. The QNG can be combined with adaptive learning rates $eta ( theta_i^t$ that change for every step of gradient descent to speed up training. For hardware efficient PQCs, one can calculate adaptive learning rates using the quantum Fisher information metric~@haug2021optimal.


While the full Fubini-Study metric tensor is difficult to estimate on quantum hardware, diagonal and block-diagonal approximations can be efficiently evaluated~@stokes2020quantum and improved classical techniques to calculate the full tensor exist~@jones2020efficient. A special type of PQC, the natural PQC, has a euclidean quantum geometry such that the gradient is equivalent to the QNG close to a particular set of parameters~@haug2021natural.


==== Quantum imaginary time evolution.
<quantum-imaginary-time-evolution.>
Instead of using the standard gradient descent for optimization, a variational imaginary time evolution method was proposed in @mcardle2019variational to govern the evolution of parameters. They focused on many-body systems described by a $k$-local Hamiltonian and considered a PQC that encodes the state $| psi ( tau ) chevron.r$ as a parameterized trial state $| psi ( bold(theta) ( tau ) ) chevron.r$.


The evolution of $bold(theta) ( tau )$ with respect to all the parameters can then be obtained by solving the following differential equation


$ sum_j A_(i j) partial_tau theta_j ( tau ) = C_i , $


with


$A_(i j) = upright("Re") (chevron.l partial_i psi ( bold(theta) ( tau ) ) | partial_j psi ( bold(theta) ( tau ) ) chevron.r)$ and $C_i = upright("Re") (- sum_alpha c_alpha chevron.l partial_i psi ( bold(theta) ( tau ) ) | h_alpha | psi ( bold(theta) ( tau ) ) chevron.r)$,


where $h_alpha$ and $c_alpha$ are the Hamiltonian terms and coefficients. It was later shown in~@stokes2020quantum that the matrix $A_(i j)$ is related to the Fubini-Study metric tensor from @eq:Fubiny_Study_sup, and the imaginary time evolution is analogous to the gradient descent via the QNG when considering infinitesimal small step sizes.


==== Hessian-aided gradient descent.
<hessian-aided-gradient-descent.>
A recent work~@huembeli2020characterizing proposed computing the Hessian and its eigenvalues to help analyze the cost function landscapes of quantum machine learning algorithms. Tracking the numbers of positive, negative, and zero eigenvalues provides insight whether the optimizer is heading towards a stationary point.


The Hessian can be computed by doubly applying the parameter shift rule as @mitarai2019methodology


$ partial_i partial_j f ( bold(theta) ) =\
1 / 2 ( chevron.l f ( bold(theta)_(not ( i , j )) , theta_i + alpha , theta_j + alpha ) chevron.r + chevron.l f ( bold(theta)_(not ( i , j )) , theta_i - alpha , theta_j - alpha ) chevron.r\
- chevron.l f ( bold(theta)_(not ( i , j )) , theta_i - alpha , theta_j + alpha ) chevron.r - chevron.l f ( bold(theta)_(not ( i , j )) , theta_i + alpha , theta_j - alpha ) chevron.r ) , $


where the shift parameter $alpha = frac(pi, 4 lambda)$ for gates generated by operators with eigenvalues $plus.minus lambda$. Other parameters, i.e. parameters not at the $i$-th and $j$-th indices, denoted $bold(theta)_(not ( i , j ))$, are fixed. To improve optimization, they propose setting the learning rate to the inverse of the largest eigenvalue of the Hessian.


Numerical simulations of the Hessian-based method and QNG both showed improvement over standard gradient descent in the ability to escape flat regions of the parameter landscape, with the former requiring fewer training epochs than QNG. While a deeper analysis is necessary to more closely compare the performance, both QNG and Hessian-based methods accelerate optimization by leveraging local curvature information.


==== Quantum Analytic Descent.
<quantum-analytic-descent.>
A method consisting of using a classical model of the local energy landscape to estimate the gradients is proposed in @koczor2020quantum. In this hybrid approach, a quantum device is used to construct an approximate ansatz landscape and the optimization towards the minima of the corresponding approximate surfaces can be carried out efficiently on a classical computer. The method considers the ansatz circuit as a product of $m$ unitary operations as $U ( bold(theta) ) = U_m ( theta_m ) dots.h.c U_1 ( theta_1 )$ which, without loss of generality, can be approximated around a reference point $theta_0$ as:


$ U ( bold(theta) ) = A ( bold(theta) ) U^(( A )) + sum_(k = 1)^v \[B_k ( bold(theta) ) U_k^(( B )) + C_k ( bold(theta) ) U_k^(( C ))\]\
+ sum_(l > k)^v \[ D_(k l) ( bold(theta) ) U_(k l)^(( D )) \] + O ( sin^3 delta ) , $


where $A$, $B_k$, $C_k$, $D_(k l)$ : $bb(R)^v arrow.r bb(R)$ are products of simple univariate trigonometric functions, $U^(( A ))$, $U_k^(( B ))$, $U_k^(( C ))$, $U_(k l)^(( D ))$ are discrete mappings of the gates and $delta$ is the absolute largest entry of the parameter vector. Using this approximate ansatz landscape, the full energy surface, gradient vector and metric tensor can be expressed in term of the ansatz parameters. The analytic descent has been shown to achieve faster convergence as compared to the QNG~@koczor2020quantum.


==== Stochastic gradient descent.
<stochastic-gradient-descent.>
A major drawback of gradient-based methods is the high number of measurements. The stochastic gradient descent (SGD) algorithm addresses this issue by replacing the normal parameter update rule with a modified version


$ bold(theta)^(( t + 1 )) = bold(theta)^(( t )) - alpha med bold(g) ( bold(theta)^(( t )) ) , $


where $alpha$ is the learning rate and $bold(g)$ is an unbiased estimator of the gradient of the cost function. There are many choices for this estimator, for instance a measurement of the gradient with a finite number of shots~@harrow2019low. It was also shown that it is not necessary to include all Pauli terms in the evaluation of the cost function; sampling from a subset still results in well-behaved gradient estimator. On top of that, it is possible to go even further by combining this technique with sampling of the parameter-shift rule terms~@sweke2020stochastic.


In the doubly stochastic gradient, finite measurements are performed for only a subset of the expectation values of the Hamiltonian terms. This sampling can be performed in the extreme situation where only one Pauli-term is evaluated at a single point in the quadrature. This is a very powerful method that reduces the number of measurements drastically~@anand2020experimental.


This method can be extended beyond circuits that allow the parameter-shift rule by expressing the gradient as an integral~@banchi2020measuring. The integral can be seen as an infinite sum of terms that can be sampled. To accelerate the convergence of SGD for VQA, two optimization strategies are proposed #cite(<lyu2020accelerated>): #emph[i)] Qubit-recursive, where the optimization is first performed for a smaller quantum system and is then used as initial parameter guess for a larger quantum system; and #emph[ii)] Layer-recursive, which is similar to a greedy approach, where the parameters are sequentially updated layer-by-layer in the quantum circuit.


== Gradient-free approaches
<gradient-free-approaches>


In this section, we discuss optimization methods for VQA that do not rely on gradients measured on the quantum computer.


==== Evolutionary algorithms.
<evolutionary-algorithms.>
Evolutionary strategies @rechenberg1978evolutionsstrategien @schwefel1977numerische are black-box optimization tools for high dimensional problems that use a search distribution, from which they sample data, to estimate the gradient of the expected fitness to update the parameters in the direction of steepest ascent. More recently, natural evolutionary strategies (NES)~@wierstra2014natural have demonstrated considerable progress in solving these high dimensional optimization problems. They use natural gradient estimates for parameter updates instead of the standard gradients. They have been adapted for optimization of VQA~@zhao2020natural @anand2020natural and have been shown to have similar performance as the state-of-the-art gradient based method.


The search gradients used in NES can be estimated as


$ nabla J ( bold(theta) ) approx 1 / k sum_(n = 1)^k f ( bold(z)_n ) nabla log pi ( bold(z)_n | bold(theta) ) , $


where $J ( bold(theta) ) = E_(bold(theta)) \[ f ( bold(z) ) \]$ is the expected fitness, $pi ( bold(z) | bold(theta) )$ is the density of the search distribution with parameter $bold(theta)$, $f ( bold(z) )$ is the fitness for the corresponding sample $bold(z)$ drawn from the search distribution and $k$ is the different number of samples drawn from the distribution. The (classical) Fisher matrix $cal(F)_(upright("C"))$ for the natural gradient can be estimated as


$ cal(F)_(upright("C")) approx 1 / k sum_(n = 1)^k nabla log pi ( bold(z)_n | bold(theta) ) nabla log pi ( bold(z)_n | bold(theta) )^T $


and the parameter update can then be carried out as $bold(theta) = bold(theta) + eta dot.op cal(F)_(upright("C"))^(- 1) nabla J ( bold(theta) )$. In @anand2020natural it is shown that NES, along with techniques like Fitness shaping, local natural coordinates, adaptive sampling and batch optimization, can be used for optimization of deep quantum circuits.


==== Reinforcement learning.
<reinforcement-learning.>
Several authors have used reinforcement learning (RL) to optimize the QAOA parameters @khairy2019reinforcement @wauters2020reinforcement @yao2020noise @yao2020policy. This framework consists of a decision-making agent with policy $pi_(bold(theta)) ( a | s )$ parameterized by $bold(theta)$, which is a mapping from the state space $s in { S }$ to an action space $a in { A }$. In response to the action, the environment provides the agent with a reward $r$ from the set of rewards ${ R }$. The goal of RL is to find a policy which maximizes the expected total discounted reward. For more details, refer to @sec:applications_ML_RL. In the context of QAOA, for example, ${ S }$ can be the set of QAOA parameters ($bold(gamma) , bold(beta)$) used, $a$ can be the value of $gamma$ and $beta$ for the next iteration, and the reward can be the finite difference in the QAOA objective function between two consecutive iterations. The policy can be parameterized by a deep neural network with the weights $bold(theta)$. The policy parameters $bold(theta)$ can be optimized using a variety of algorithms such as Monte-Carlo methods~@hammersley2013monte @sutton2018reinforcement, Q-Learning~@watkins1992q and policy gradient methods~@sutton2018reinforcement.


==== Sequential minimal optimization.
<sequential-minimal-optimization.>
In machine learning, the sequential minimal optimization (SMO) method~@platt1998sequential has proven successful in optimizing the high-dimensional parameter landscape of support vector machines. The method breaks the optimization into smaller components for which the solution can be found analytically. This method has been applied to variational circuit optimization~@nakanishi2020sequential, circuit optimization with classical acceleration~@parrish2019jacobi and circuit optimization and learning with Rotosolve and Rotosolect~@ostaszewski2019quantum. Although these algorithms heavily rely on the parameter-shift rule, they can be considered gradient-free methods. They exploit the sinusoidal nature of the expectation value of a specific operator $hat(O)$ when all but one parameters in the variational circuit are fixed:


$ chevron.l hat(O) chevron.r (bold(theta)) = A sin (bold(theta) + B) + C , $


where $A$, $B$ and $C$ are parameters that can be found analytically. This means that only three well-chosen circuit evaluations are needed to exactly determine these coefficients and the optimal value $theta^(*)$ of the parameter $theta$ for this operator is given by


$ theta^(*) = - upright("arctan2") \[ 2 chevron.l hat(O) chevron.r (phi) - chevron.l hat(O) chevron.r (phi + pi / 2) - chevron.l hat(O) chevron.r (phi - pi / 2) ,\
chevron.l hat(O) chevron.r (phi + pi / 2) - chevron.l hat(O) chevron.r (phi - pi / 2) \] + 2 pi k - phi - pi / 2 thin , $


where $upright("arctan2")$ is the 2-argument arctangent and for any integer $k$ and angle $phi$. The most straightforward choice is to set $phi = 0$ and choose $k$ such that $theta^(*) in ( - pi , pi \]$. The algorithm proceeds by looping over all the variational parameters until convergence. The method can be generalized to optimize more than one parameter at a time~@nakanishi2020sequential @parrish2019jacobi but no general analytical expression can be found here. One has to resort to numerical methods to find the solutions for the free parameters.


SMO offers a versatile starting point that can be combined with more advanced search acceleration algorithms like Anderson acceleration~@anderson1965iterative or direct inversion of the iterative subspace (DIIS)~@pulay1980convergence. The same tools have also been used to optimize categorical variables like rotation axes in the Rotoselect algorithm~@ostaszewski2019quantum. While cost efficient, sequential parameter optimization only takes into account local information (albeit exactly), which often causes the optimization to get stuck in local minima~@koczor2020quantum. One has to balance the speed of a local method like SMO with the global approximate information of methods like the quantum analytic descent for specific problems.


==== Surrogate model-based optimization.
<surrogate-model-based-optimization.>
When function evaluations are costly, it pays off to not only use the current function value to inform a next parameter value, but to use all previous evaluations to extract information about the search space. The function values in memory are used to build a surrogate model, an auxiliary function that represents the full expensive cost function based on the current information. The surrogate model of the cost function can be evaluated cheaply and many of these evaluations can be used to inform the next parameter value at which to compute the cost function. The new evaluation of the true objective function is added to the set of function values and the surrogate model is iteratively refined until convergence. All optimization happens on the surrogate cost landscape, so no explicit derivatives of the cost function are needed. Through the use of a fitted cost function, these methods are also expected to be more resilient to noise.


Several classical surrogate models have been included in the scikit-quant package~@lavrijsen2020classical @scikit-quant. In the Bound optimization by quadratic approximation (BOBYQA) algorithm~@powell2009bobyqa, a local quadratic model is formulated from the previous function values. It is then minimized in the trust region to obtain a new parameter value. When the evaluation at this new parameter value does not result in a lower function value, the trust region is altered and the quadratic model is optimized in this new parameter space. It was shown that this method works well when the PQC is initialized close to the optimal parameters but has more problems with shallow optimization landscapes and gets stuck in local minima~@lavrijsen2020classical. The stable noisy optimization by branch and fit (SnobFit)~@huyer2008snobfit algorithm uses a branching algorithm to explore new areas in parameter space. In these areas it proposes several evaluation points and from the function values it fits a quadratic model. The algorithm combines this local search with an explorative generation of points in new areas of the parameter space. SnobFit performs well when tight bounds on the parameters are available~@lavrijsen2020classical. This can be achieved by combining the method with other optimizers that limit the size of the parameter space.


In @sung2020using, a trust region with a least-squares fit to a quadratic function is used. They find that the minimum of the quadratic function often lies outside of the trust region, which causes the algorithms to constantly readjust it. Instead of using standard trust region optimization, they use either standard gradient descent or policy gradient descent optimization on the quadratic function to define a search direction in the parameter space. Both the model gradient descent (MGD) as the model policy gradient (MPG) have a hyperparameter that gradually shrinks the set of points used for the fit around the current minimum as the optimization progresses. The authors show that their algorithms are well suited for realistic conditions on near-term hardware. In particular, they study the ability of the algorithm to take into account a cloud access situation where circuits need to be uploaded in batches with a certain latency. The MPG outperforms MGD in the case of gate errors due to the ability to handle a large level of uncertaintity while learning its policy~@sung2020using.


== Resource-aware optimizers
<resource-aware-optimizers>


Optimization methods and strategies adopted for early demonstrations of VQA are largely general-purpose and black-box with minimal emphasis on reducing the quantum resources used in the optimization. Therefore, they are more costly and prone to errors than their classical counterparts. Optimizers developed in more recent years are tailored to additionally minimize quantities associated with the quantum cost of the optimization, e.g. number of measurements or real hardware properties. Additionally, one can use circuit compilation methods as the ones described in @sec:compilers.


==== ROSALIN.
<rosalin.>
While VQA leverage low-depth circuits to execute on near-term quantum processors, a significant challenge in implementing these algorithms is the prohibitive number of measurements, or shots, required to estimate each expectation value that is used to compute the objective. To address the challenge, @arrasmith2020operator developed a shot-frugal optimizer called ROSALIN (Random Operator Sampling for Adaptive Learning with Individual Number of shots) that effectively distributes fractions of a predefined number of shots to estimate each term of the Hamiltonian as well as each partial derivative. Given the expectation value of the Hamiltonian decomposed into the $h_i$ terms as in @eq:Pauli_string,


the authors note several strategies for allocating shots for estimating each term $chevron.l h_i chevron.r$. While a naive strategy would allocate equal numbers of shots per term, the authors observed lower variance in the energies using weighted approaches in which the number of shots allocated to the $i$-th term $b_i$ is proportional to the corresponding Hamiltonian coefficient $c_i$. For instance, in the #emph[weighted deterministic sampling] method, $b_i = b_(upright("tot")) frac(| c_i |, sum_i | c_i |)$ where $b_(upright("tot"))$ is the total number of shots. In the #emph[weighted random sampling] method, $b_i$ is drawn from a multinomial distribution with the probability of measuring the $i$-th term weighted by $| c_i |$, i.e. $p_i = frac(| c_i |, sum_i | c_i |)$.


In addition, ROSALIN employs iCANS (individual Coupled Adaptive Number of Shots), an optimizer that allocates shots for partial derivatives, as a subroutine @kubler2020adaptive. As a brief overview, the iCANs algorithm allocates measurements for each partial derivative such that the expected gain per shot is maximized. This gain depends on quantities such as the learning rate, the Lipschitz constant of the cost function, and estimates of gradient components and their variances. Through VQE optimizations, ROSALIN was shown to outperform other optimizers such as iCANS and Adam especially in the presence of noise.


==== SPSA.
<spsa.>
In experimental realizations of VQA, the optimizer is often hindered by statistical noise. In @kandala2017hardware this issue is circumvented by applying the simultaneous perturbation stochastic approximation (SPSA) algorithm @spall1992multivariate, in which the algorithm hyperparameters are determined by experimental data on the level of statistical noise. Compared to the finite-difference gradient approximation, which requires $O ( p )$ function evaluations for $p$ parameters, SPSA requires only two evaluations. That is, for a small positive $b_k$, the gradient at $k$-th iteration is approximated as


$ bold(g)_k ( bold(theta)_k ) = frac(chevron.l psi ( bold(theta)_k^(+) ) | H | psi ( bold(theta)_k^(+) ) chevron.r - chevron.l psi ( bold(theta)_k^(-) ) | H | psi ( bold(theta)_k^(-) ) chevron.r, 2 b_k med bold(Delta)_k) , $


where $bold(Delta)_k$ is a random perturbation vector and $bold(theta)_k^plus.minus = bold(theta)_k plus.minus b_k bold(Delta)_k$. After computing the gradient estimate, the next parameter settings are updated with learning rate $a_k$. In general, $b_k$ and $a_k$ decrease over iterations, e.g. $b_k = b / k^gamma$ and $a_k = a / k^alpha$ for some fixed $gamma$ and $alpha$.


The values of $b$ and $a$ are carefully estimated to be robust against statistical noise based on samples of energy differences $| chevron.l psi ( bold(theta)_k^(+) ) | H | psi ( bold(theta)_k^(+) ) chevron.r - chevron.l psi ( bold(theta)_k^(-) ) | H | psi ( bold(theta)_k^(-) ) chevron.r |$. The convergence of SPSA with various types of PQCs has been studied~@woitzik2020entanglement.


= NISQ APPLICATIONS FOR FINANCE
<sec:finance>


The subject of finance deals with money and investments. The three typical subdivisions of this field are; personal finance, corporate finance and public finance. Due to its practical relevance, comprehensive and rigorous investigations have been carried out to comprehend finance using techniques from mathematics. Some of the typical applications from finance which could potentially benefit from quantum technologies are portfolio optimization, modelling financial markets via differential equations and predicting market trends. In the following lines, we present one possible approach to classify mathematical problems in finance @egger2020quantum.


==== Optimization based. 
<optimization-based.>
Many of the finance problems involve decision-making subject to certain constraints and consequently fall in the optimization framework. Some of the typical examples of optimization problems in finance are portfolio optimization, portfolio diversification and auctions. Concepts from convex optimization and combinatorial optimization turn out to be appropriate for the aforementioned class of problems. A considerable number of optimization centric problems can be converted to QUBO (see @eq:QUBO_1 in @subsec:quantum-annealing). Quantum algorithms for linear systems, convex optimization and QUBO have been employed with the hope for a possible advantage. In particular, the problems which can be reduced to QUBO have been investigated extensively using quantum annealing, VQE and QAOA~@bouland2020prospects @hodson2019portfolio.


==== Simulation based. 
<simulation-based.>
The simulation problems in finance deal with simulating potential outcomes, typical examples being simulating the influence of volatility on risk or estimating asset values for pricing. Monte-Carlo simulations and algorithms for stochastic processes are particularly beneficial for such tasks. Consequently, quantum Monte-Carlo algorithms and quantum algorithms for modelling stochastic processes have been investigated in the context of finance~@kubo2020variational @bouland2020prospects @egger2020quantum @ramos2019quantum @blank2020quantum2.


==== Machine learning based. 
<machine-learning-based.>
Some of the standard machine learning based problems in finance require predicting a future event based on historical data, pattern and anomaly detection, and classification of the end result in categories. Sample problems are fraud detection, algorithmic trading, risk assessment and credit scoring. One can potentially hope to apply QML algorithms as the ones presented in @sec:QML for such tasks.


The complete coverage of quantum finance is outside the scope of this review. We direct the reader to @egger2020quantum @bouland2020prospects @orus2019quantum for a comprehensive treatment. We proceed to discuss portfolio optimization and fraud detection; two canonical examples from finance. The algorithms that appear in this subsection are listed in @tab:finance.


== Portfolio optimization
<portfolio-optimization>


The mathematical notion of portfolio optimization, was first proposed in~@markowitz1952portfolio. Given some capital and set of $m$ assets, the goal is to find the best investment strategies under a set of constraints. Some of the typical constraints could be non-negativity of the investment or limit on total budget $B$. The objective function could be variance of the whole portfolio or overall risk. Let us represent the overall portfolio allocation by $x in bb(R)^m$, where $x_k$ denotes the investment in the $k$-th asset. Suppose the return at time step $t$ is $c ( t ) in bb(R)^m$ with expected return $mu in bb(R)^m$and covariance matrix $Sigma in bb(R)^(m times m)$ given by


$ mu ( T ) = & 1 / T sum_(t in \[T\]) c ( t ) ,\
Sigma ( T ) = & frac(1, T - 1) sum_(t in \[T\]) (c ( t ) - mu) (c ( t ) - mu)^T . $<eq:mean>


With some additional equality constraints captured by $A in bb(R)^(m times m)$ and $b in bb(R)^m ,$ such as the total budget constraint $sum x_i = B ,$ the portfolio optimization task corresponds to the following program,


$ min_(x in bb(R)^m) x^T Sigma x , "s.t." thin c^T x = mu , A^T x = b . $<eq:Opt_1>


We can introduce Lagrange multipliers $eta$ and $theta$ for the equality constraints, and get the following Lagrangian corresponding to the aforementioned program,


$ cal(L) (x , eta , theta) = 1 / 2 x^T Sigma x + eta (c^T x - mu) + theta (A^T x - b) . $<eq:Lagrangian_portfolio_1>


The solution to the portfolio optimization @eq:Opt_1 reduces to solving the following linear system, $ \[ & 0 & 0 & c^T \
    & 0 & 0 & A^T \
    & c & A & Sigma \] \[ eta\
theta\
x \] = \[ mu\
b\
0 \] $<eq:Linear_system_portfolio_1>


In ~@rebentrost2018quantum the HHL algorithm was proposed to implement the above approach with a quantum computer. One can use near-term linear system solvers for portfolio optimization tasks given assumptions about hardware capabilities and input model are satisfied~@huang2019nearterm. A modified version of the program from @huang2019nearterm was recently tackled using VQE and QAOA~@egger2020quantum. Specifically, the following optimization program was attempted,


$ min_(x in {0,1}^m) q x^T Sigma x - mu^T x , "s.t." thin 1^T x = B . $<eq:obj_2_finance>


Here, the portfolio vector $x in (0 , 1)^m$ is a vector of binary variables where $x_i = 1$ means the $i$th asset was selected. $x_i = 0$ means otherwise. Similar to the previous case, $mu$ and $Sigma$ denote expected return and covariance matrix respectively. The total budget has been denoted by $B$ and $q > 0$ captures the risk appetite of the decision maker. It is assumed that all assets have same price and total budget has to be spent. By adding the constraint as a penalty term $(1^T x - B)^2 ,$ the authors convert optimization program @eq:obj_2_finance to a QUBO problem, which further reduces to an appropriate Hamiltonian ground state problem. They employ both VQE and QAOA hereafter. They also study portfolio diversification, by again converting the same to QUBO~@egger2020quantum. Since problems which can be converted in QUBO can be a good fit for annealing based optimization, quantum annealing has been extensively applied for portfolio optimization~@marzec2016portfolio @rosenberg2016solving @venturelli2019reverse @cohen2020portfolio. For details, refer to~@orus2019quantum @bouland2020prospects. In @alcazar2021enhancing, a quantum optimization strategy exploiting generative machine learning models to bypass the need for constructing QUBO or PUBO cost functions has been proposed. Besides acting as a black-box solver (i.e., an optimizer which is agnostic to the details of the cost function), it was shown that this quantum portfolio optimization strategy scales to industrial data sets such as the entire S&P 500 by leveraging quantum-inspired models based on tensor networks, instead of using hardware models.


== Fraud detection
<fraud-detection>


Machine learning can be utilised to detect financial frauds. A typical example could be somebody's credit card getting blocked because higher than usual transaction was under process. Based on the historical data, often a fraudulent transaction can be caught. There are, however, false positives also. A typical example of false positive is somebody's credit card transaction getting declined when trying it at a new store. Based on synthetic credit card transaction data in Ref.~@altman2019synthesizing, variational quantum classification was performed in Ref.~@egger2020quantum. The example problem in Ref.~@egger2020quantum contains dataset with $100$ purchase transaction records with each transaction $k$ marked fraudulent $(y_k = - 1)$ or not fraudulent $(y_k = 1)$. The $k$-th transaction input vector $x_k$ contains information about transaction amount, time, method and location. Variational quantum classification was used to predict the right label. A similar analysis using variational QBM was carried on in Ref.~@zoufal2020variational. NISQ algorithms for anomaly detection, such as ~@herr2020anomaly, could also be used for detecting financial frauds.

= UNITARY T-DESIGN
<sec:t-design>


The primary objective of unitary $t$-designs is to substitute with a finite sum the integration over the space of unitaries. The aforementioned approach provides an accessible way to find the average of functions over unitaries and then prove intriguing theorems about them. The set of unitaries $bb(U) ( d )$ forms a topologically compact and connected group. Furthermore, they correspond to the set of norm-preserving matrices in $bb(C)^d .$ We can define a unique translation-invariant measure, the #emph[Haar measure], on $bb(U) ( d )$ which can be employed to calculate expectation values of functions of unitaries,


$ chevron.l f chevron.r = integral_(bb(U) ( d )) f ( U ) med d U . $<eq:Haar_expectation>


We present the aforementioned statement in a relatively formal manner.


#thmbox("theorem", "Definition")[


Let $bb(U)$ be a group of $n times n$ unitaries. A probability measure $mu$ on $bb(U)$ is called Haar measure on $bb(U)$ if for any subset $bb(S) subset.eq bb(U)$ and for any fixed $K in bb(U)$, we have


$ mu (K bb(S)) = mu (bb(S) K) = mu (bb(S)) $<eq:translation_invariance>


where $K bb(S) equiv {K U : U in bb(S)}$and $bb(S) K equiv {U K : U in bb(S)} .$ The property in @eq:translation_invariance is called translation invariance.


] <def:Haar>


Because of translation invariance, if $U_1$ is a Haar-distributed random unitary matrix, then so are $U U_1$ and $U_1 U$ for a fixed unitary matrix $U .$ To present the concept of unitary designs, we need to first discuss the notions of #emph[homogeneous polynomials] $(H o m ( a , b ))$ and #emph[weight functions], defined in the context of unitary matrices. Any polynomial of degree $a$ in the entries of $U in bb(U) ( d )$ and $b$ in $U^dagger$ is called a homogeneous polynomial $H o m ( a , b ) .$ Some of the examples of homogeneous polynomials are $U^dagger V^dagger U V in H o m ( 2 , 2 )$ and $V U^dagger V U in H o m ( 3 , 1 ) .$ A weight function on a set $S , w : S arrow.r ( 0 , 1 \]$, for all $U in S$ satsfies the following two properties: $( i ) thin w ( U ) gt.eq 0 upright(" and ") ( i i ) thin sum_(U in S) w ( U ) = 1 .$ Having discussed the concepts of homogeneous polynomials and weight function, we proceed to define the notion of unitary t-designs.


#thmbox("theorem", "Definition")[


Unitary $t$-design: Given a finite set $S subset bb(U) ( d )$ and a weight function $w : S arrow.r ( 0 , 1 \]$, the tuple $( S , w )$ is called a unitary t-design if for all $f in H o m ( t , t )$


$ sum_(U in S) w ( U ) f ( U ) = integral_(bb(U) ( d )) f ( U ) med d U . $<eq:unitary_t_1>


]


We will refer to unitary $t$-design as $t$-design henceforth. Note that to verify if a tuple $( S , w )$ forms a $t$-design, we need to check the condition from @eq:unitary_t_1 for every function $f$ in $H o m ( t , t ) .$ For many cases, such an approach might be impractical and hence it requires more tractable condition, such as the one from the following Lemma.


#thmbox("theorem", "Lemma")[


Given a finite set $S subset bb(U) ( d )$ and a weight function $w : S arrow.r ( 0 , 1 \]$, the tuple$( S , w )$ forms a $t$-design if and only if $sum_(U in S) w ( U ) U^(⊗ t) ⊗ (U^dagger)^(⊗ t) = integral_(U ( d )) U^(⊗ t) ⊗ (U^dagger)^(⊗ t) d U .$


]



