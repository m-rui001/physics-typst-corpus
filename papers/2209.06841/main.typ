#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, [#text(size: 9pt, weight: "regular")[#num#it.body]])
}

#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)
#let horizontalrule = line(length: 100%)

#place(top, float: true, scope: "parent", clearance: 1.2em)[
#align(center)[
  #text(14.3pt, weight: "bold", [The Future of Quantum Computing with Superconducting Qubits])
  #v(1em)
  #text(10.5pt)[Sergey Bravyi, Oliver Dial, Jay M. Gambetta, Darío Gil, Zaira Nazario]
]
#v(1em)

// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: 29 November 2022)]]

#text(9.5pt)[*Abstract.* For the first time in history, we are seeing a branching point in computing paradigms with the emergence of quantum processing units (QPUs). Extracting the full potential of computation and realizing quantum algorithms with a super-polynomial speedup will most likely require major advances in quantum error correction technology. Meanwhile, achieving a computational advantage in the near term may be possible by combining multiple QPUs through circuit knitting techniques, improving the quality of solutions through error suppression and mitigation, and focusing on heuristic versions of quantum algorithms with asymptotic speedups. For this to happen, the performance of quantum computing hardware needs to improve and software needs to seamlessly integrate quantum and classical processors together to form a new architecture that we are calling quantum-centric supercomputing. Long term, we see hardware that exploits qubit connectivity in higher than 2D topologies to realize more efficient quantum error correcting codes, modular architectures for scaling QPUs and parallelizing workloads, and software that evolves to make the intricacies of the technology invisible to the users and realize the goal of ubiquitous, frictionless quantum computing.]
]


= INTRODUCTION
<introduction>
The history of computing is that of advances born out of the need to perform ever more sophisticated calculations. Increasingly advanced semiconductor manufacturing processes have resulted in faster and more efficient chips---most recently the 2 nm technology node#cite(<2nm>)---and special accelerators like the GPU, TPU, and AI processors~@reuther2020survey have allowed more efficient computations on larger data sets. These advances share the same model of computation dating back to 1936 with the origins of the Church-Turing thesis. Now for the first time in history, the field of computing has branched with the emergence of quantum computers, which, when scaled, promise to implement computations intractable for conventional computers---from modeling quantum mechanical systems~@AbramsLloyd99 to linear algebra~@HHL, factoring~@shor1994algorithms, search~@grover, and more.

Unlocking the full potential of quantum processors requires the implementation of computations with a large number of operations. Since quantum gates are considerably less accurate than their classical counterparts, it is strongly believed that error correction will be necessary to realize long computations with millions or billions of gates. Accordingly, most of quantum computing platforms are designed with the long term goal of realizing error-corrected quantum circuits. As the noise rate decreases below a constant architecture-dependent threshold, an arbitrarily long quantum circuit can be executed reliably by redundantly encoding each qubit and repeatedly measuring parity check operators to detect and correct errors. However, the number of qubits required to realize error-corrected quantum circuits solving classically hard problems exceeds the size of systems available today by several orders of magnitude.

Meanwhile, as the quality and number of qubits in quantum computers continue to grow, we must be able to harvest the computational power of quantum circuits available along the way. For example, a quantum processing unit (QPU) with two-qubit gate fidelity of $99.99 %$ can implement circuits with a few thousand gates to a fair degree of reliability without resorting to error correction. Such circuits are strongly believed to be practically impossible to simulate classically, even with the help of modern supercomputers. This suggests the possibility that the first demonstrations of a computational #emph[quantum advantage]---where a computational task of business or scientific relevance can be performed more efficiently, cost-effectively, or accurately using a quantum computer than with classical computations alone---#emph[may be achieved without or with limited error correction].

Three central questions need to be answered for this to happen: (1) how to extract useful data from the output of noisy quantum circuits in the weak noise regime, (2) how to design quantum algorithms based on shallow circuits that can potentially solve some classically hard problems, and (3) how to improve the efficiency of quantum error-correction schemes and use error correction more sparingly.

These questions and our approach are discussed in detail in #ref(<sec:useful>, supplement: none). As an illustration, we pick one of the simplest scientifically relevant applications of quantum computers---simulating time evolution of a spin chain Hamiltonian~#cite(<childs2018toward>). We discuss state-of-the-art quantum algorithms for this problem and highlight the cost of making time evolution circuits fault-tolerant by encoding each qubit into the surface code~@kitaev2003fault@bravyi1998quantum, considered the best fit for hardware with two-dimensional qubit connectivity. For problem sizes of practical interest, error correction increases the size of quantum circuits by nearly six orders of magnitude, making it prohibitively expensive for near-term QPUs (see #ref(<sec:EC>, supplement: none)).

Question (1) is approached in Sections #ref(<sec:EM>, supplement: none) and~#ref(<sec:CK>, supplement: none) through quantum error mitigation~@temme2017error@li2017efficient and circuit knitting~@bravyi2016trading@peng2020simulating@tang2021cutqc#cite(<mitarai2021constructing>). These techniques extend the size of quantum circuits that can be executed reliably on a given QPU without resorting to error correction. We estimate the overhead introduced by state-of-the-art error mitigation methods and discuss recent ideas on how to combine error correction and mitigation. Circuit knitting techniques exploit structural properties of the simulated system, such as geometric locality, to decompose a large quantum circuit into smaller sub-circuits or combine solutions produced by multiple QPUs.

The classical simulation algorithms used in computational physics or chemistry are often heuristics and work well in practice, even though they do not offer rigorous performance guarantees. Thus, it is natural to ask whether rigorous quantum algorithms designed for simulating time evolution admit less expensive heuristic versions that are more amenable to near-term QPUs. We discuss such algorithms in #ref(<sec:VQE>, supplement: none) to address question (2).

To approach question (3), we discuss generalizations of the surface code known as low-density parity check (LDPC) quantum codes~@gottesman2013fault#cite(<PRXQuantum.2.040101>). These codes can pack many more logical qubits into a given number of physical qubits such that, as the size of quantum circuits grows, only a constant fraction of physical qubits is devoted to error correction (see #ref(<sec:EC>, supplement: none) for details). These more efficient codes need long-range connections between qubits embedded in a two-dimensional grid~@Baspin2021nonlocality, but the efficiency benefits are expected to outweigh the long-range connectivity costs.

We then focus on quantum-centric supercomputing, which is a new architecture for realizing error mitigation, circuit knitting, and heuristic quantum algorithms with substantial classical calculations. At the heart of this architecture is classical and quantum integration and modularity. We need classical integration at real-time to enable conditioning quantum circuits on classical computations (dynamic circuits), at near-time to enable error mitigation and eventually error correction, and at compile time to enable circuit knitting and advanced compiling. We need modulairty to enable scaling and speeding up workflows by using parallelization. We first start in #ref(<sec:hardware>, supplement: none) by focusing on superconducting computing hardware and we introduce a series of schemes---which we denote $m$, $l$, $c$, and $t$ couplers---that give us the amount of flexibility needed for realizing LDPC codes, scaling QPUs, and enabling workflows that take advantage of local operations and classical communication (LOCC) and parallelization. In #ref(<sec:software>, supplement: none), we discuss the requirements on the quantum stack by defining different layers for integrating classical and quantum computations, which define requirements on latency, parallelization, and the compute instructions. From this, we can define a cluster-like architecture that we call quantum-centric supercomputer. It consists of many quantum computation nodes comprised of classical computers, control electronics, and QPUs. A quantum runtime can be executed on a quantum-centric supercomputer, working in the cloud or other classical computers to run many quantum runtimes in parallel. Here we propose that a serverless model should be used so that developers can focus on code and do not have to manage the underlying infrastructure. We conclude with a high level view from a developer's/user's lens.

This paper offers a perspective of the future of quantum computing focusing on an examination of what it takes to build and program near-term superconducting quantum computers and demonstrate their utility. Realizing the computational power of these machines requires the concerted efforts of engineers, physicists, computer scientists, and software developers. Hardware advances will raise the bar of quantum computers' size and fidelity. Theory and software advances will lower the bar for implementing algorithms and enable new capabilities. As both bars converge in the next few years, we will start seeing the first practical benefits of quantum computation.

= TOWARDS PRACTICALLY USEFUL QUANTUM CIRCUITS
<sec:useful>
Although in principle a quantum computer can reproduce any calculation performed on conventional classical hardware, the vast majority of everyday tasks are not expected to benefit from quantum-mechanical effects. However, using quantum mechanics to store and process information can lead to dramatic speedups for certain carefully selected applications. Of particular interest are tasks that admit a quantum algorithm with the runtime scaling as a small constant power of the problem size $n$---e.g., as $n^2$ or $n^3$---whereas the best known classical algorithm solving the problem has runtime growing faster than any constant power of $n$---e.g., as $2^n$ or $2^(sqrt(n))$. We define runtime as the number of elementary gates in a circuit (or circuits) implementing the algorithm for a given problem instance. As the problem size $n$ grows, the more favorable scaling of the quantum runtime quickly compensates for a relatively high cost and slowness of quantum gates compared with their classical counterparts. These exponential or, formally speaking, super-polynomial speedups are fascinating from a purely theoretical standpoint and provide a compelling practical reason for advancing quantum technologies.

Known examples of tasks with an exponential quantum speedup include simulation of quantum many-body systems@lloyd1996universal, number theoretic problems such as integer factoring@shor1994algorithms, solving certain types of linear systems@harrow2009quantum, estimation of Betti numbers used in topological data analysis~@lloyd2016quantum@gyurik2020towards@ubaru2021quantum, and computing topological invariants of knots and links#cite(<aharonov2009polynomial>). (We leave aside speedups obtained in the so-called Quantum RAM model@giovannetti2008quantum, for although it appears to be more powerful than the standard quantum circuit model, it is unclear whether a Quantum RAM can be efficiently implemented in any real physical system.)

Simulation of quantum many-body systems has received the most attention due to its numerous scientific and industrial applications, and for being the original value proposition for quantum computing~#cite(<Feynman82>). The ground state and thermal-equilibrium properties of many-body systems can often be understood, at least qualitatively, using classical heuristic algorithms such as dynamical mean-field theory (DMFT) or perturbative methods. However, understanding their behavior far from equilibrium in the regime governed by coherent dynamics or performing high-precision ground state simulations for strongly-interacting electrons---e.g., in the context of quantum chemistry---is a notoriously hard problem for classical computers.

As a simple illustration, consider a spin chain composed of $n$ quantum spins (qubits or qudits) with Hamiltonian $ H = sum_(j = 1)^(n - 1) H_(j , j + 1) , $ where $H_(j , j + 1)$ is a two-spin nearest-neighbor interaction. The Schrödinger equation $ i frac(d \| psi ( t ) chevron.r, d t) = H \| psi ( t ) chevron.r $ governs the coherent time evolution of the system from some fixed initial state $\| psi ( 0 ) chevron.r$.

Suppose our goal is to compute the expected value of some local observable on the time-evolved state $\| psi ( t ) chevron.r = e^(- i H t) \| psi ( 0 ) chevron.r$. Such expected values are of great interest for understanding, among other things, thermalization mechanisms in closed quantum systems#cite(<kaufman2016quantum>). Transforming the time-dependent expected values into the frequency domain provides valuable information about the excitation spectrum of the system@shtanko2020unitary#cite(<aleiner2020accurately>). A slightly modified version of this problem that involves measuring each qubit of $\| psi ( t ) chevron.r$ is known to be BQP-complete@vollbrecht2008quantum@nagaj2008hamiltonian@kay2008computational@chase2008universal, meaning that it is essentially as hard as simulating a universal quantum computer.

The known classical algorithms for simulating the coherent time evolution of a quantum spin chain have runtime $min ( 2^(O ( n )) , 2^(O ( v t )) )$, where $v tilde.op max_j parallel H_(j , j + 1) parallel$ is the Lieb-Robinson velocity, which controls how fast information propagates through the system#cite(<bravyi2006lieb>). For simplicity, we ignore factors polynomial in $n$ and $t$. The runtime $2^(O ( n ))$ can be achieved using a standard state vector simulator while the runtime $2^(O ( v t ))$ can be achieved by approximating $\| psi ( t ) chevron.r$ with Matrix Product States@osborne2006efficient@schollwock2011density or by restricting the dynamics to a light cone#cite(<hastings2008observations>). In general, the linear growth of the entanglement entropy with time appears to be an insurmountable obstacle for classical simulation algorithms.

Haah, Kothari, #emph[et. al.] recently found a nearly optimal quantum algorithm for simulating the time evolution of spin chain Hamiltonians@haah2021quantum with runtime $tilde(O) ( n t )$, where $tilde(O)$ hides factors logarithmic in $n$, $t$, and the inverse approximation error. This algorithm works by approximating the time evolution operator $e^(- i H t)$ by a product of simpler unitaries describing forward and backward time evolution of small blocks of spins of length $O ( log n t )$. Assuming that the evolution time $t$ scales as a small constant power of $n$; e.g., $t tilde.op n$, this constitutes an exponential quantum speedup.

A natural question is what are the minimum quantum resources; i.e., qubit and gate counts, required to convincingly demonstrate a quantum advantage for simulating coherent dynamics. Childs, Maslov, #emph[et. al.] proposed a concrete benchmark problem for this, simulating the time evolution of the spin-$1 / 2$ Heisenberg chain with $n = t = 100$ and approximation error $0.001$#cite(<childs2018toward>). The Hamiltonian has the form $H = sum_(j = 1)^(n - 1) arrow(sigma)_j arrow(sigma)_(j + 1) + sum_(j = 1)^n h_j sigma_j^z$, where $h_j in [ - 1 , 1 ]$ are randomly chosen magnetic fields. Fig.~#ref(<fig:CNOTcount>, supplement: none) shows the gate count estimates for the benchmark problem obtained by Childs, Ostrander, and Su@childs2019faster, suggesting that about $10^7$ CNOT gates (and a comparable number of single-qubit gates) are needed. This exceeds the size of quantum circuits demonstrated experimentally to date by several orders of magnitude. As we move from simple spin chain models to more practically relevant Hamiltonians, the gate count required to achieve quantum advantage increases dramatically. For example, simulating the active space of molecules involved in catalysis problems may require about $10^11$ Toffoli gates#cite(<berry2019qubitization>). The only viable path to reliably implementing circuits with $10^7$ gates or more on noisy quantum hardware is quantum error correction.

// [figvision-cn] imgs/gate_counts.png
// 这是一张散点图，展示了使用随机化积公式近似模拟量子比特
// 海森堡链时所需的CNOT门数量随量子比特数的变化关系。 横
// 坐标轴标记为“Qubits n”，表示量子比特的数量，刻度从20到
// 100，以10为间隔递增（20, 30, 40, 50, 60, 70, 80, 90,
// 100）。纵坐标轴标记为“CNOT count”，表示CNOT门的数量，
// 采用对数标度，主要刻度线标记为$10^6$和$10^8$。图表背景
// 包含浅灰色的网格线，分别对应横纵坐标的刻度位置。 图表
// 左上角有一个图例框，定义了三种不同颜色的数据点所代表的
// 物理含义： 蓝色实心方块代表“first order”（一阶）积公式。
// 红色实心圆点代表“fourth order”（四阶）积公式。 绿色实
// 心圆点代表“sixth order”（六阶）积公式。 图中绘制了三组
// 离散的数据点，每组对应不同的量子比特数n（从20到100，步
// 长为10），具体分布如下： 蓝色方块（一阶）：数据点位于
// 图表的最上方，显示出最高的CNOT门需求。随着量子比特数n
// 的增加，CNOT数量呈指数级增长趋势。在n=20时，数值约为$4
// \times 10^6$；当n增加到100时，数值已超过$10^8$，接近$5
// \times 10^8$。 红色圆点（四阶）：数据点位于图表的中下
// 部。相比一阶方法，其CNOT门数量显著减少。在n=20时，数值
// 约为$3 \times 10^5$；随着n增加至100，数值上升至约$1.2
// \times 10^7$。 绿色圆点（六阶）：数据点的位置与红色圆
// 点非常接近，通常略低于或重合于同一点的红色圆点。这表明
// 六阶方法的效率与四阶方法相当或略优。例如在n=100时，绿
// 色圆点的数值略低于$10^7$。 总体趋势显示，对于所有阶数
// 的积公式，随着量子比特数n的增加，所需的CNOT门数量均单
// 调递增。然而，高阶公式（四阶和六阶）所需的门数量远低于
// 一阶公式，且在高量子比特数下，这种差距尤为明显。
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

#figure(image("imgs/gate_counts.png", width: 8cm),
  caption: [
    Estimated number of CNOT gates required to approximate the unitary evolution operator $e^(- i H t)$ for the $n$-qubit Heisenberg chain with $t = n$ and approximation error $0.001$ using randomized $k$-th order product formulas ($k = 1 , 4 , 6$). The presented data is based on empirical estimates of ref. , see Eq. (70) therein, assuming that exponentiating a single term in the Hamiltonian costs $3$ CNOTs. 
  ],
  placement: top,
)
<fig:CNOTcount>

== Quantum error correction
<sec:EC>
One reason why conventional classical computers became ubiquitous is their ability to store and process information reliably. Small fluctuations of an electric charge or current in a microchip can be tolerated due to a highly redundant representation of logical $0$ and $1$ states by a collective state of many electrons. Quantum error-correcting codes provide a similar redundant representation of quantum states that protects them from certain types of errors. A single logical qubit can be encoded into $n$ physical qubits by specifying a pair of orthogonal $n$-qubit states $\| overline(0) chevron.r$ and $\| overline(1) chevron.r$ called logical-$0$ and logical-$1$. A single-qubit state $alpha \| 0 chevron.r + beta \| 1 chevron.r$ is encoded by the logical state $alpha \| overline(0) chevron.r + beta \| overline(1) chevron.r$. A code has distance $d$ if no operation affecting fewer than $d$ qubits can distinguish the logical states $\| overline(0) chevron.r$ and $\| overline(1) chevron.r$ or map them into each other. More generally, a code may have $k$ logical qubits encoded into $n$ physical qubits and the code distance $d$ quantifies how many physical qubits need to be corrupted before the logical (encoded) state is destroyed. Thus good codes have a large distance $d$ and a large encoding rate $k / n$.

Stabilizer-type codes@gottesman1996class@calderbank1997quantum are by far the most studied and promising code family. A stabilizer code is defined by a list of commuting multi-qubit Pauli observables called stabilizers such that logical states are $+ 1$ eigenvectors of each stabilizer. One can view stabilizers as quantum analogues of classical parity checks. Syndrome measurements aim to identify stabilizers whose eigenvalue has flipped due to errors. The eigenvalue of each stabilizer is repeatedly measured and the result---known as the error syndrome---is sent to a classical decoding algorithm. Assuming that the number of faulty qubits and gates is sufficiently small, the error syndrome provides enough information to identify the error (modulo stabilizers). The decoder can then output the operation that needs to be applied to recover the original logical state.

Most of the codes designed for quantum computing are of the LDPC type@gallager1962low@tillich2013quantum@gottesman2013fault, meaning that each stabilizer acts on only a small number of qubits and each qubit participates in a small number of stabilizers, where small means a constant independent of the code size. The main advantage of quantum LDPC codes is that the syndrome measurement can be performed with a simple constant-depth quantum circuit. This ensures that the syndrome information can be collected frequently enough to cope with the accumulation of errors. Furthermore, errors introduced by the syndrome measurement circuit itself are sufficiently benign since the circuit can propagate errors only within a “light cone” of constant size.

A code must satisfy several requirements to have applications in quantum computing. First, it must have a high enough error threshold---the maximum level of hardware noise that it can tolerate. If the error rate is below the threshold, the lifetime of logical qubit(s) can be made arbitrarily long by choosing a large enough code distance. Otherwise, errors can accumulate faster than the code can correct them and logical qubits can become even less reliable than the constituent physical qubits. Second, one needs a fast decoding algorithm to perform error correction in real time as the quantum computation proceeds. This may be challenging since the decoding problem for general stabilizer codes is known to be NP-hard in the worst case@hsieh2011np@kuo2012hardness#cite(<iyer2015hardness>). Third, one must be able to compute on the logical qubits without compromising the protection offered by the code. In the sub-threshold regime, one must be able to realize arbitrarily precise logical gates from some universal gate set by choosing a large enough code distance.

The 2D surface code@kitaev2003fault@bravyi1998quantum has so far been considered an uncontested leader in terms of the error threshold---close to $1 %$ for the commonly studied depolarizing noise@raussendorf2007fault@fowler2009high#cite(<wang2011surface>)---yet has two important shortcomings. First, allocating a roughly $d times d$ patch of physical qubits for each logical qubit incurs a large overhead. Unfortunately, it was shown@bravyi2010tradeoffs that any 2D stabilizer code has encoding rate $k / n = O ( 1 / d^2 )$ which vanishes for large code distance. This means that as one increases the degree of protection offered by the surface code, quantified by the code distance $d$, its encoding rate approaches zero. That is, as the size of quantum circuits grows, the vast majority of physical qubits are devoted to error correction. This is a known fundamental limitation of all quantum codes that can be realized locally in the 2D geometry.

To make error correction more practical and minimize qubit overhead, codes with a large encoding rate $k / n$ are preferable. For example, quantum LDPC codes can achieve a constant encoding rate independent of the code size#cite(<tillich2013quantum>). In fact, the encoding rate can be arbitrarily close to one#cite(<gottesman2013fault>). A recent breakthrough result~@panteleev2021asymptotically demonstrated the existence of so-called good quantum LDPC codes that combine a constant encoding rate $k / n$ (which can be arbitrarily close to $1$) and a linear distance $d gt.eq c n$ for some constant $c > 0$. For comparison, the 2D surface code has an asymptotically vanishing encoding rate and has distance at most $sqrt(n)$. Certain LDPC codes have a favorable property known as single-shot error correction@bombin2015single#cite(<kubica2021single>). They provide a highly redundant set of low-weight Pauli observables (known as gauge operators) that can be measured to obtain the error syndrome more efficiently. This reduces the number of syndrome measurement cycles per logical gate from $O ( d )$ to $O ( 1 )$ and hence enables very fast logical gates. The syndrome measurement circuit for a quantum LDPC code requires a qubit connectivity dictated by the structure of stabilizers, i.e., one must be able to couple qubits that participate in the same stabilizer. Known examples of LDPC codes with a single-shot error correction require 3D or 4D geometry@bombin2015single@kubica2021single#cite(<campbell2019theory>).

The second shortcoming of the surface code is the difficulty of implementing a computationally universal set of logical gates~#cite(<bravyi2013classification>). The surface code and its variations such as the honeycomb code~@hastings2021dynamically or folded surface code~@moussa2016transversal offer a low-overhead implementation of logical Clifford gates such as CNOT, Hadamard $H$, and phase shift $S$. These gates can be realized by altering the pattern of stabilizers measured at each time step using the code deformation method. However, Clifford gates are not computationally universal on their own. A common strategy for achieving universality is based on preparation of logical ancillary states $( \| overline(0) chevron.r + e^(i pi / 4) \| overline(1) chevron.r ) / sqrt(2)$ known as magic states. A magic state is equivalent (modulo Clifford operations) to a single-qubit gate $T = upright("diag") ( 1 , e^(i pi / 4) )$. The Clifford+$T$ gate set is universal and has a rich algebraic structure enabling efficient and nearly-optimal compiling of quantum algorithms@kliuchnikov2012fast#cite(<ross2014optimal>). Unfortunately, the overhead for distilling high-fidelity magic states is prohibitively large. O'Gorman and Campbell@o2017quantum performed a careful examination of available distillation methods and their overhead, considering the implementation of a logical Clifford+$T$ circuit of size $N$ with an overall fidelity of $90 %$. Assuming a physical error rate of $10^(- 3)$, the following fitting formulas were found for the space-time volume ((physical qubits) $times$ (syndrome measurement cycles)) associated with a single logical gate:

#block[
#figure(
  align(center)[#table(
    stroke: none,
    columns: 2,
    align: (center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Logical gate], [Physical space-time volume],),
    table.hline(),
    [CNOT], [$1610 + 45 (log_10 N)^2.77$],
    [$T$-gate], [$3.13 + 3220 (log_10 N)^3.20$],
    table.hline(stroke: 0.8pt),
  )]
  , kind: table
  )

]
The space-time volume roughly quantifies the number of physical gates required to implement a single logical gate.

As an example, consider the Heisenberg benchmark problem described above with $100$ logical qubits. The desired time evolution operator can be approximated using about $10^7$ CNOTs and single-qubit gates (see fig.~@fig:CNOTcount). However, each single-qubit gate needs to be compiled using the logical-level gate set ${ H , S , T }$. In total, this requires roughly $10^9$ $T$-gates and a comparable number of Clifford gates#cite(<childs2018toward>). Accordingly, the physical space-time volumes of a single logical CNOT and $T$-gate are roughly $2 times 10^4$ and $4 times 10^6$, respectively. (In fact, this underestimates the error correction overhead since the Heisenberg benchmark problem requires logical circuit fidelity $0.999$ rather than $0.9$, as considered in ref. .)

The large overhead associated with logical non-Clifford gates may rule out the near-term implementation of error-corrected quantum circuits, even if fully functioning logical qubits based on the surface code become available soon. There have been several strategies proposed recently for reducing this overhead, including high-yield magic state distillation methods@haah2017magic@hastings2018distillation, better strategies for preparing “raw” noisy magic states that reduce the required number of distillation rounds@li2015magic, and better surface code implementations of distillation circuits @fowler2012bridge@litinski2019game@paetznick2013quantum#cite(<litinski2019magic>). A recent breakthrough result by Benjamin Brown@brown2020fault showed how to realize a logical non-Clifford gate CCZ (controlled-controlled-$Z$) in the 2D surface code architecture without resorting to state distillation. This approach relies on the fact that a 3D version of the surface code enables an easy (transversal) implementation of a logical CCZ~@kubica2015unfolding@vasmer2019three and a clever embedding of the 3D surface code into a 2+1 dimensional space-time. It remains to be seen whether this method is competitive compared with magic state distillation.

== Error mitigation
<sec:EM>
Although error correction is vital for realizing large-scale quantum algorithms with great computational power, it may be overkill for small or medium size computations. A limited form of correction for shallow quantum circuits can be achieved by combining the outcomes of multiple noisy quantum experiments in a way that cancels the contribution of noise to the quantity of interest@temme2017error#cite(<li2017efficient>). These methods, collectively known as error mitigation, are well suited for the QPUs available today because they introduce little to no overhead in terms of the number of qubits and only a minor overhead in terms of extra gates. However, error mitigation comes at the cost of an increased number of circuits (experiments) that need to be executed. In general, this will result in an exponential overhead; however, the base of the exponent can be made close to one with improvements in hardware and control methods, and each experiment can be run in parallel. Furthermore, known error mitigation methods apply only to a restricted class of quantum algorithms that use the output state of a quantum circuit to estimate the expected value of observables.

Probabilistic error cancellation (PEC) @temme2017error@endo2018practical aims to approximate an ideal quantum circuit via a weighted sum of noisy circuits that can be implemented on a given quantum computer. The weights assigned to each noisy circuit can be computed analytically if the noise in the system is sufficiently well characterized or learned by mitigating errors on a training set of circuits that can be efficiently simulated classically#cite(<strikis2020learning>). We expect that the adoption of PEC will grow due to the recent theoretical and experimental advances in quantum noise metrology~@harper2020efficient@flammia2021averaged#cite(<vandenBerg2022pec>). For example, ref. shows how to model the action of noise associated with a single layer of two-qubit gates by a Markovian dynamics with correlated Pauli errors. This model can be described by a collection of single-qubit and two-qubit Pauli errors $P_1 , dots.h , P_m$ and the associated error rate parameters $lambda_1 , dots.h , lambda_m gt.eq 0$ such that the combined noise channel acting on a quantum register has the form $Lambda ( rho ) = exp [ cal(L) ] ( rho )$, where $cal(L)$ is a Lindblad generator, $cal(L) ( rho ) = sum_(i = 1)^m lambda_i ( P_i rho P_i^dagger - rho )$. The unknown error rates $lambda_i$ can be learned to within several digits of precision by repeating the chosen layer of gates many times and measuring the decay of suitable observables~#cite(<vandenBerg2022pec>). The error mitigation overhead (as measured by the number of circuit repetitions) per layer of gates scales as $gamma^2$, where $ gamma = exp (2 sum_(i = 1)^m lambda_i) . $

For a circuit composed of $d > 1$ layers, the error rates $lambda_i$ may be layer-dependent and have to be learned separately for each layer. As observed in ref. , this model can approximate the actual hardware noise very well using only $m = O ( n )$ elementary Pauli errors $P_i$ supported on edges of the qubit connectivity graph, where $n$ is the total number of qubits in the circuit. In general, the runtime for getting a noise-free estimate will depend on the circuit implemented and the noise model used.

A large class of quantum algorithms that can benefit from PEC is based on the so-called hardware-efficient circuits#cite(<Kandala_2017>). A depth-$d$ hardware-efficient circuit consists of $d$ layers of two-qubit gates such that all gates within the same layer are non-overlapping and couple qubits that are nearest-neighbors in the QPU connectivity graph. Denoting the average error rate per qubit $macron(lambda) = ( 1 / n ) sum_(i = 1)^m lambda_i$, averaged over all $d$ layers, the overall PEC overhead scales as $( macron(gamma) )^(d n)$, where $macron(gamma) = exp ( 4 macron(lambda) )$. This allows a simple formula for estimating the runtime, $J$, for a noise-free estimate from a quantum circuit of depth $d$ and width $n$ to be $ "J" = d ( macron(gamma) )^(d n) beta , $<gammabeta> where $beta$ is the average time to run a single layer of the circuit. One can view $beta$ as a measure of the “speed” and $macron(gamma)$ as a hardware-dependent parameter that quantifies the average “quality” of gates across the entire QPU.

For a spin chain of $n = 100$ qubits, the size of our benchmark problem, fig. ~@fig:EMscaling shows the number of circuit instances that need to be sampled to perform PEC for 100 and 1000 Trotter steps using the decomposition in fig. 3A of ref. . Current hardware runs of up to $10^8$ circuits daily (red dashed line) and error rates of $10^(- 3)$ have been demonstrated. Hence, we anticipate that with a couple orders of magnitude improvement this becomes possible. Furthermore, this runtime can be further reduced with the quantum-centric supercomputing architecture that allows parallelized execution of quantum circuits.

// [figvision-cn] imgs/FigGammaEpsilon2Tex_100q_trotter_3.png
// 这是一张二维对数坐标曲线图，展示了在特定量子电路条件下，
// 进行误差抑制所需的运行时间缩放因子与门错误率之间的关系。
// 子图类型：双对数坐标曲线图（Log-Log Plot）。 坐标轴信
// 息： 横轴（X轴）标记为“Error (1-f)”，代表两量子比特门
// 的错误率。该轴采用对数刻度，显示的数值范围从 10^-5 到
// 10^-3。主刻度线分别标注为 10^-5、10^-4 和 10^-3。 纵轴
// （Y轴）标记为数学符号“γ^dm = J/(βd)”，代表归一化后的运
// 行时间缩放因子或所需电路实例数量。该轴同样采用对数刻度，
// 显示的数值范围从 10^0 到 10^12。主刻度线以 100 为间隔
// 递增，依次标注为 10^0, 10^2, 10^4, 10^6, 10^8, 10^10,
// 10^12。 曲线与数据系列： 图中包含两条实线曲线，均呈现
// 从左下向右上急剧上升的趋势，表明随着错误率的增加，所需
// 的计算资源呈指数级增长。 蓝色实线：根据右上角的图例，
// 该曲线标记为“Trotter 100”。它代表模拟 100 个 Trotter
// 步长的情况。曲线起点位于横坐标约 10^-5 处，对应的纵坐
// 标略高于 10^0；随着横坐标向右移动，曲线斜率逐渐增大，
// 在横坐标约为 3×10^-4 时穿过红色虚线。 橙色实线：根据图
// 例，该曲线标记为“Trotter 1000”。它代表模拟 1000 个
// Trotter 步长的情况。该曲线位于蓝色曲线的左侧，意味着在
// 相同的错误率下需要更多的资源。曲线起点位于横坐标 10^-5
// 处，对应的纵坐标约为 10^3；曲线迅速上升，在横坐标约为
// 2×10^-5 时即穿过红色虚线并超出图表上限。 参考线与标注：
// 图中有一条水平的红色虚线，贯穿整个绘图区域，其位置固定
// 在纵坐标 10^8 处。这条线代表了每天可运行的电路实例数量
// 上限（1 亿次），假设重复频率为 1。 图例： 位于图表内部
// 右上角的一个矩形框内，包含两个条目：上方是蓝色短线段对
// 应文字“Trotter 100”，下方是橙色短线段对应文字“Trotter
// 1000”。 趋势与结论： 该图定量地说明了在 100 量子比特且
// 存在局部去极化噪声的电路中，为了达到有效的误差抑制，所
// 需的电路实例数量随门错误率呈幂律增长。对于更长的演化时
// 间（1000 个 Trotter 步长），系统对错误的容忍度更低，即
// 在更高的错误率下就会超过每日 1 亿次运行的硬件限制（红
// 色虚线所示）。
#figure(image("imgs/FigGammaEpsilon2Tex_100q_trotter_3.png", width: 8cm),
  caption: [
    Runtime scaling (number of circuit instances) needed to error mitigate 100 and 1000 Trotter steps in a circuit of 100 qubits and layers of non-overlapping two-qubit gates, each gate affected by a local depolarizing two-qubit error. The red dotted line identifies 100 million circuits, the daily limit assuming a repetition rate of 1 $m s$. So far the only architectures that have achieved this speed are solid-state based. The number of circuit instances dramatically decreases with slight improvements in the error rate of the physical gates. 
  ],
  placement: top,
)
<fig:EMscaling>

We can also measure the quantity of interest at several different values of the noise rate and perform an extrapolation to the zero-noise limit~@temme2017error@li2017efficient#cite(<kandala2019error>). This method cancels the leading-order noise contribution as long as the noise is weak and Markovian. Unlike PEC, this method is biased and heuristic but may require fewer circuits for the reconstruction. This method was recently demonstrated@kim2021 to scale up to 27 qubits and still reconstruct observables. Whether this method can be combined with PEC, which gives an unbiased estimation, remains an open question.

More general (non-Markovian) noise can be mitigated using the virtual distillation technique@huggins2020virtual#cite(<koczor2020exponential>). It works by combining two copies of a noisy output state $rho$ in a way that enables measurements of observables on a state $rho^2 / upright("Tr") ( rho^2 )$. Assuming that $rho$ has most of its weight on the ideal output state, virtual distillation can quadratically suppress the contributions of errors. However, this method introduces at least a factor of two overhead in the number of qubits and gates. A review of the existing error mitigation proposals can be found in Endo, #emph[et. al.]#cite(<endo2021hybrid>).

We anticipate error mitigation to continue to be relevant when error-corrected QPUs with a hundred or more logical qubits become available. As discussed in #ref(<sec:EC>, supplement: none), the first generation of error-corrected quantum chips based on 2D stabilizer codes may not be able to execute universal computations. Such QPUs are likely to offer only high-fidelity Clifford gates such as the Hadamard or CNOT, which can all be efficiently simulated on a classical computer. Meanwhile, logical non-Clifford gates such as the $T$-gate may remain out of reach due to the need to perform magic state distillation. This leads to the interesting possibility of combining error correction and mitigation. A concrete proposal by Piveteau, #emph[et al.]@piveteau2021error leverages the ability to realize #emph[noisy] logical $T$-gates with fidelity comparable to or exceeding that of physical (unencoded) gates. Applying error mitigation protocols at the logical level to cancel errors introduced by noisy $T$-gates enables one to simulate universal logical circuits without resorting to state distillation. This may considerably reduce the hardware requirements for achieving a quantum advantage. However, error mitigation comes at the cost of an increased number of circuit executions. Assuming a physical gate fidelity of $99.9 %$ and a budget of $1 , 000$ circuit executions, Piveteau, #emph[et al.]@piveteau2021error estimate that logical Clifford+$T$ circuits with about 2,000 $T$-gates can be realized reliably. This is far beyond the limit of existing classical algorithms that can simulate Clifford+$T$ circuits with about 50 $T$-gates~@bravyi2016improved#cite(<bravyi2019simulation>). Similar ideas for combining error correction and mitigation are discussed in refs. .

== Circuit Knitting
<sec:CK>
We can extend the scope of near-term hardware to compensate for other shortcomings such as a limited number of qubits or qubit connectivity by using circuit knitting techniques. This refers to the process of simulating small quantum circuits on a quantum computer and stitching their results into an estimation of the outcome of a larger quantum circuit. As was the case with error mitigation, known circuit knitting techniques apply to a restricted class of quantum algorithms that aim to estimate the expected value of observables.

The most well-known example is circuit cutting @bravyi2016trading@peng2020simulating@tang2021cutqc#cite(<mitarai2021constructing>). In this method, a large quantum circuit is approximated by a weighted sum of circuits consisting of small isolated sub-circuits. Each sub-circuit can be executed separately on a small QPU. The overhead introduced by this method (as measured by the number of circuit repetitions) scales exponentially with the number of two-qubit gates or qubit wires that need to be cut in order to achieve the desired partition of the circuit. Surprisingly, it was recently shown that the circuit cutting overhead can be substantially reduced by running the isolated sub-circuits in parallel using non-interacting QPUs that can only exchange classical data#cite(<piveteau2022circuit>). This approach requires hardware capable of implementing dynamic circuits#footnote[Dynamic circuits are computational circuits that combine quantum and classical operations, using the outcome of classical computations to adapt subsequent quantum operations. For more information, see section @sec:software.], where the control electronics is extended to include independent QPUs.

A second example is entanglement forging@eddins2021doubling, where either an entangled variational state is decomposed into a weighted sum of product states or the entanglement between a pair of qubit registers is converted into time-like correlations within a single register#cite(<huembeli2022entanglement>). The overhead of this method typically scales exponentially with the amount of entanglement across the chosen partition of the system.

A third example, closely related to circuit knitting, uses embedding methods to decompose the simulation of a large quantum many-body system into smaller subsystems that can be simulated individually on a QPU. The interactions between subsystems are accounted for by introducing an effective bath that could be either a classical environment or another small quantum system. The decomposition of the original system and the optimization of the bath parameters are performed on a classical computer that can exchange classical data with the QPU. Well-known examples of quantum embedding methods that build on their classical counterparts are dynamical mean-field theory~@Bauer15@kreula2016few@bravyi2017complexity, density-matrix embedding~@knizia2012density@knizia2013density@mineh2022solving, and density-functional embedding~#cite(<ma2020quantum>).

== Heuristic quantum algorithms
<sec:VQE>
Heuristic quantum algorithms can be employed near-term to solve classical optimization~@FGG2014, machine learning~@havlivcek2019supervised, and quantum simulation~@yuan2019theory problems. These fall into two categories---algorithms that use kernel methods@havlivcek2019supervised and variational quantum algorithms (VQA). Quantum kernel methods have also been found that lead to provable speedups@liu2020shor and expand to a class of kernels for data with group structure#cite(<glick2021covariant>). For VQA, the basic proposal is appealingly simple: an experimentally-controlled trial state is used as variational wavefunction to minimize the expected energy of a given quantum Hamiltonian or a classical cost function encoding the problem of interest. The trial state is usually defined as the output state of a shallow quantum circuit. Rotation angles that define individual gates serve as variational parameters. These parameters are adjusted via a classical feedback loop to optimize the chosen cost function.

At present, there is no mathematical proof that VQA can outperform classical algorithms in any task. In fact, it is known that VQA based on sufficiently shallow (constant depth) variational circuits with 2D or 3D qubit connectivity can be efficiently simulated on a classical computer~@bravyi2021classical#cite(<coble2020quasi>). This rules out a quantum advantage. Meanwhile, the performance of VQA based on deep variational circuits is severely degraded by noise~#cite(<franca2020limitations>). However, as the error rates of QPUs decrease, we should be able to execute VQA in the intermediate regime where quantum circuits are already hard to simulate classically but the effect of noise can still be mitigated.

As a concrete example, let us discuss possible applications of VQA to the problem of simulating coherent time evolution of quantum spin chains. It is commonly believed~@haah2021quantum that approximating the time evolution operator $e^(- i H t)$ for a Hamiltonian $H$ describing a 1D chain of $n$ qubits requires a quantum circuit of size scaling at least linearly with the space-time volume $n t$. Meanwhile, the best known rigorous quantum algorithms based on product formulas~@childs2019faster or Lieb-Robinson bounds~@haah2021quantum require circuits of size $O ( n^2 t )$ or $O ( n t dot.op upright("polylog") ( n t ) )$, respectively. A natural question is whether VQA can reduce the circuit size to what is believed to be optimal, that is, linear in $n t$. If this is indeed the case, a QPU with gate fidelity around $99.99 %$ may be able to solve the classically hard problem instances described above with space-time volume $n t tilde.op 10^4$ using existing error mitigation techniques.

Variational quantum time evolution (VarQTE) algorithms, pioneered by Li and Benjamin~@li2017efficient, could be an alternative to simulate the time evolution of these classically hard instances given near-term noisy QPUs. These algorithms aim to approximate the time-evolved state $\| psi ( t ) chevron.r = e^(- i H t) \| psi ( 0 ) chevron.r$ by a time-dependent variational ansatz $\| phi.alt ( theta ) chevron.r = U ( theta ) \| 0^n chevron.r$, where $U ( theta )$ is a parameterized quantum circuit with a fixed layout of gates and $theta = theta ( t )$ is a vector of variational parameters. The initial state $\| psi ( 0 ) chevron.r$ is assumed to be sufficiently simple so that the variational ansatz for $\| psi ( 0 ) chevron.r$ is easy to find. The goal is to find a function $theta ( t )$ such that the variational state $\| phi.alt ( theta ( t ) ) chevron.r$ approximates the time evolved state $\| psi ( t ) chevron.r$ for all $t$ in the chosen time interval. As shown in ref. , the desired function $theta ( t )$ can be efficiently computed using the stationary-action principle with a Lagrangian $L ( t ) = chevron.l phi.alt ( theta ( t ) ) \| d / d t + i H \| phi.alt ( theta ( t ) ) chevron.r$. This yields a first-order differential equation~@yuan2019theory $sum_q M_(p , q) dot(theta)_q = V_p$ where $ M_(p , q) = upright("Im") ( chevron.l partial_p phi.alt ( theta ) \| partial_q phi.alt ( theta ) chevron.r ) , $ $ V_p = - upright("Re") ( chevron.l partial_p phi.alt ( theta ) \| H \| phi.alt ( theta ) chevron.r ) , $ and $partial_p equiv frac(partial, partial theta_p)$. As shown in [], the entries of $M$ and $V$ can be efficiently estimated on a quantum computer. A comprehensive review of VarQTE algorithms can be found in refs. .

The fact that VarQTE algorithms are heuristics and therefore lack rigorous performance guarantees raises the question of how to validate them. This becomes particularly important for large problem sizes where verifying a solution of the problem on a classical computer becomes impractical. Ref. recently developed a version of VarQTE based on McLachlan's variational principle that comes with efficiently computable bounds on the distance between the exact time-evolved state $\| psi ( t ) chevron.r$ and the approximate variational state found by the VarQTE algorithms. Thus, although VarQTE lacks a rigorous justification, one may be able to obtain #emph[a posteriori] bounds on its approximation error for some specific problems of practical interest.

== Summary
<summary>
To summarize, the Heisenberg chain example illustrates what we believe are general guidelines for designing near-term quantum algorithms.

First, our best chance of attaining a quantum advantage is by focusing on problems that admit an exponential (super-polynomial) quantum speedup. Even though a quantum algorithm that achieves such speedup with formal proof may be out of reach for near-term hardware, its mere existence serves as compelling evidence that quantum-mechanical effects such as interference or entanglement are beneficial for solving the chosen problem.

Second, the only known way to realize large-scale quantum algorithms relies on quantum error-correcting codes. The existing techniques based on the surface code are not satisfactory due their poor encoding rate and high cost of logical non-Clifford gates. Addressing these shortcomings may require advances in quantum coding theory such as developing high-threshold fault-tolerant protocols based on quantum LDPC codes and improving the qubit connectivity of QPUs beyond the 2D lattice. Supplementing error correction with cheaper alternatives such as error mitigation and circuit knitting may provide a more scalable way of implementing high-fidelity quantum circuits.

Third, near-term quantum advantage should be possible by exploring less expensive, possibly heuristic versions of the algorithm considered. Those heuristic quantum algorithms lack rigorous performance guarantees, but they may be able to certify the quality of a solution #emph[a posteriori] and offer a way to tackle problems that cannot be simulated classically.

We believe these general guidelines define the future of quantum computing theory and will guide us to important demonstrations of its benefits for the solution of scientifically important problems in the next few years.

= THE PATH TO LARGE QUANTUM SYSTEMS
<sec:hardware>
The perspective above leads to a challenge in quantum hardware. We believe there will be near-term advantage using a mixture of error mitigation, circuit knitting and heuristic algorithms. On a longer time frame, partially error-corrected systems will become critical to running more advanced applications and further down the line, fault-tolerant systems running on not-as-yet fully explored LDPC codes with non-local checks will be key. The first steps for all of these approaches are the same: we need hardware with more qubits capable of higher fidelity operations. We need tight integration of fast classical computation to handle the high run-rates of circuits needed for error mitigation and circuit knitting, and the classical overhead of the error correction algorithm afterwards. This drives us to identify a hardware path that starts with the early heuristic small quantum circuits and grows until reaching an error-corrected computer.

== Cycles of Learning
<cycles-of-learning>
The first step in this path is to build systems able to demonstrate near-term advantage with error mitigation and limited forms of error correction. Just a few years ago, QPU sizes were limited by control electronics cost and availability, I/O space, quality of control software, and a problem referred to as “breaking the plane”@Gambetta2017, i.e., routing microwave control and readout lines to qubits in the center of dense arrays. Today, solutions to these direct barriers to scaling have been demonstrated, which has allowed us to lift qubit counts beyond 100---above the threshold where quantum systems become intractably difficult to simulate classically and examples of quantum advantage become possible. The next major milestones are (1) increasing the fidelity of QPUs enough to allow exploration of quantum circuits for near-term quantum advantage with limited error correction and (2) improving qubit connectivity beyond 2D---either through modified gates, sparse connections with non-trivial topologies, and/or increasing the number of layers for quantum signals in 3D integration---to enable the longer term exploration of efficient non-2D LDPC error-correction codes. These developments are both required for our longer term vision, but can be pursued in parallel.

// [figvision-cn] src/2021_12_09_MLW_ToPCB.jpg
// 子图类型：三维结构示意图（剖面透视视图）。该图展示了一
// 种用于量子比特信号传输的垂直分层架构，旨在实现平面外布
// 线以支持数百个量子比特的集成。图中所有组件均以灰色、浅
// 蓝色、黄色和深灰色块状结构表示，通过引线标注名称。 从
// 下至上结构如下： 最底层为厚实的灰色基座，标注为“Wiring
// and signal distribution”，代表底层布线和信号分配层。其
// 上方紧贴一层薄浅蓝色层，标注为“Multi-Layer Wiring”，表
// 示多层金属布线层。再上方是一层较厚的灰色介质层，标注为
// “Dielectric”。在该介质层顶部表面，分布有多个浅蓝色倒梯
// 形柱体，这些是通孔结构，向上延伸并穿过介质层；其中部分
// 柱体顶部连接至中间层的灰色平台，另有部分直接连接至顶层
// 结构。这些通孔被统一标注为“Though-Substrate Vias”（注：
// 原文拼写应为Through-Substrate Vias），表示贯穿衬底的过
// 孔。 在介质层之上，有一个水平放置的灰色长方体平台，其
// 上表面安装有若干黑色圆形焊球，标注为“Bump Bonds”，即凸
// 点键合结构。该平台中央区域覆盖一块更大的灰色矩形块，标
// 注为“Readout Hardware”，代表读出硬件模块。在此模块下方
// 及两侧，分布有数个浅蓝色倒梯形结构，与下层通孔对齐，共
// 同构成信号通路的一部分。这些结构连同上方平台上的元件，
// 整体被箭头指向并标注为“Qubits and Busses”，表示量子比
// 特及其总线系统。 在结构左右两侧边缘，各竖立一个黄色圆
// 柱体，底部接触灰色平台，顶部高出其他结构，标注为“
// Printed Circuit Board”，代表印刷电路板接口或连接器。在
// 右侧黄色圆柱体旁，另有一条引线指向其下方的灰色层，标注
// 为“Superconductor”，表明该层为超导材料层，可能用于低温
// 环境下的无损耗传输。 整体布局呈对称性，中心为量子比特
// 与读出电路核心区域，两侧为外部接口，上下通过通孔和凸点
// 实现垂直互连。颜色映射中，灰色代表基底或功能模块主体，
// 浅蓝色代表导电通孔或布线通道，黄色代表外部PCB接口，黑
// 色代表焊接节点。比例尺未提供，但相对尺寸显示通孔高度约
// 为介质层厚度的一半，而PCB柱体高度显著高于其他垂直结构。
// 该示意图传达的核心结论是：通过采用源自传统CMOS工艺的垂
// 直互连技术（如通孔、凸点键合、多层布线），可在不占用芯
// 片平面的前提下实现高密度量子比特系统的信号输入输出，从
// 而突破二维平面布线限制，支持大规模量子处理器集成。
#figure(image("src/2021_12_09_MLW_ToPCB.jpg", width: 75.0%),
  caption: [
    An example of a scheme that allows breaking the plane for signal delivery compatible with the integration of hundreds of qubits. It is composed of technologies adapted from conventional CMOS processing.
  ],
  placement: top,
)
<fig:plane_break>

Work on improving the quality of quantum systems by improving gate fidelities involves many cycles of learning, trying coupling schemes, process changes, and innovations in controlling coupling and crosstalk. Scaling this work to large QPUs capable of demonstrating quantum advantage, and ultimately to the extreme system scales we anticipate in the distant future, involves integrating different technologies with enough reliability and skill to make size be limited by cost and need, not by technological capability. This adds challenges in reliability, predictability, and manufacturability of QPUs while continuing to incorporate improved technologies into these complex systems. Meanwhile, the increased development, fabrication, and test times for larger systems creates a lag in cycles of innovation that must be overcome.

The manufacturing cycle time increases with QPU sophistication. Many simple transmon QPUs require just a single level of lithography and can be easily fabricated in a day or two. Even the 5- and 16-qubit QPUs that were IBM's initial external cloud quantum systems involved only two lithography steps and took a week to fabricate. Compare this to more advanced packaging schemes like those at MIT Lincoln Laboratory@Yost2020@Tolpygo2015@Rosenberg2019 or IBM's newer "Eagle" QPUs (fig. @fig:plane_break), which involve dozens of lithography steps and slow process steps, and take months to build at a research-style facility with one-of-a-kind tools. This increased cycle time makes it harder to reach the fidelities and coherence times needed as well as debug the manufacturing and assembly for reliable QPU yield.

Reliability in semiconductor manufacturing is not a new problem. In general, among the unique component challenges faced in building a scaled machine, the conventional semiconductor technologies integrated on chip are the most well studied. Incorporating them in superconducting technologies is more a matter of ensuring that the associated processes are compatible with each other than inventing new approaches. However, the rapid growth of volume we anticipate being needed is a major challenge.

Many failure modes in superconducting quantum systems are not detectable until the QPUs are cooled to their operating temperature, sub-100 mK. This is a severe bottleneck that renders in-line test (where a device sub-component is tested for key metrics before the QPU build finishes) and process feed-forward (where future process steps are modified to correct for small deviations in early steps and stabilize total device performance) difficult or impossible. There are exceptions where it is possible to tightly correlate an easy measurement at room temperature with ultimate QPU performance: for example, resistance measurements of Josephson junctions can accurately predict their critical currents and hence, the frequency of qubits made with them---a key parameter in fixed frequency systems. We can take advantage of these statistical correlations wherever they exist for rapid progress in parts of our process @Kreikebaum2020 or in post-process tuning #cite(<2009.00781>). However, reliably establishing these correlations requires measuring hundreds or thousands of devices, a nontrivial feat.

Absent these correlations, we can use simplified test vehicles; for example, rather than using the entire complicated signal delivery stack when trying to improve qubit coherence, we can use a simplified device designed to obtain good statistics and fast processing #cite(<7745914>). Still, identifying specific steps leading to increased coherence is nontrivial. It is rarely possible to change just one parameter in materials processing. Changing a metal in a qubit may also change etch parameters, chemicals compatible with the metal for subsequent processing, and even allowed temperature ranges#cite(<Place2021>). Once an improved process is found, it is hard to identify exactly which steps were critical vs. simply expedient.

We must gather sufficient statistics when performing materials research for the results be meaningful and provide enough certainty#cite(<McRae2021>). We should carefully document process splits wherever relevant, and we should publish changes in materials processes that lead to neutral or even negative results, not just just publish highly successful work.

Similar difficulties occur in non-material based research on devices. Some gates work well between pairs of qubits yet exhibit strong couplings that make them unsuitable for larger QPUs or compromise single-qubit performance. Three- and four-qubit experiments are no longer challenging from a technical or budgetary perspective. To be relevant to larger QPUs, research needs to move away from two-qubit demos, especially hero experiments between a single pair of qubits in which many critical defects can be masked by luck.

A mixture of long cycle-time complex devices and short cycle-time test vehicles for sub-process development and quantum operations is key to continuing improvements in the quality of QPUs and provides a recipe for continued R&D contributions as the largest QPUs begin to exceed the capabilities of smaller groups and labs. Nonetheless, reductions in long cycle times are needed. Some of this will come naturally---first-of-a-kind processes and QPUs usually take longer as they tend to include extra steps, inspections, and in-line tests that, while suggested by general best practices, may not be necessary. While counterproductive from a cost viewpoint, building the "same" QPU repeatedly to iron out manufacturing problems and speed up cycles of innovation will likely be a successful strategy for the largest QPUs with the most complex fabrication flows.

== Supporting Hardware
<supporting-hardware>
Scaling to larger systems also involves scaling classical control hardware and the input/output (I/O) chain in and out of the cryostat. This I/O chain, while still needing substantial customization for the exact QPU being controlled, consists of high volumes of somewhat more conventional devices; for example, isolators, amplifiers, scaled signal delivery systems, and more exotic replacements such as non-ferrite isolators and quantum limited amplifiers that may offer performance, cost, or size improvements. These components have enormous potential for being shared between various groups pursuing quantum computing, and in some instances can be purchased commercially already. However, assembling these systems at the scale required today, let alone a few years time, requires a high volume cryogenic test capability that does not currently exist in the quantum ecosystem, creating a short-term need for vertically-integrated manufacturing of quantum systems. The challenge here is establishing a vendor and test ecosystem capable of scaled, low-cost production---a challenge made difficult by the fact that the demand is somewhat speculative.

There are also one-off components per system; for example, each quantum computer we deploy only requires a single dilution refrigerator, or in many cases a fraction thereof. The dilution refrigerator manufacturer effectively acts as a systems integrator for cryo-coolers, wiring solutions, pumping systems, and even some active electronics. Maintaining the flexibility we need to change quickly as the systems scale will be most easily attainable if we can standardize many of these interfaces so that, for example, moving to a more scalable cooling technology at 4K doesn't require redesigning the entire refrigeration infrastructure.

Currently, each group building large QPUs has their own bespoke control hardware. Given the radically different control paradigms and requirements@Geck2019@Xue2021@Ryan2017@Pino2021, it is unlikely that the analog front-ends of these systems could ever be shared. However, there is a common need for sequencing logic (branching, local and non-local conditionals, looping) at low-cost and low-power for all types of quantum computers, not just solid-state. These will likely need to be built into a custom processor---an Application Specific Integrated Circuit or ASIC---as we scale to thousands of qubits and beyond. On top of this, the software that translates a quantum circuit into the low-level representation of this control hardware is becoming increasingly complex and expensive to produce. Reducing cost favors a common control platform with customized analog front ends. Open-specification control protocols like OpenQASM3@qasm3 are already paving the way for this transformation.

== Classical parallelization of quantum processors
<clapar>
Reaching near-term quantum advantage will require taking advantage of techniques like circuit knitting and error mitigation that effectively stretch the capabilities of QPUs---trading off additional circuit executions to emulate more qubits or higher fidelities. These problems can be pleasingly parallel, where individual circuits can execute totally independently on multiple QPUs, or may benefit from the ability to perform classical communication between these circuits that span multiple QPUs. Introduction of control hardware that is able to run multiple QPUs as if they were a single QPU with shared classical logic, or split a single QPU into multiple virtual QPUs to allow classical parallelization of quantum workloads is an important near-term technology for stretching this advantage to the limit. Longer term, these technologies will play a critical enabling role as we begin to build quantum systems that span mutliple chips and multiple cryostats, i.e., modular quantum systems.

== Modularity
<modularity>
#figure([ \

  ],
  caption: [
    Beyond classical parallelization of QPUs, shown in (a), long-range quantum connections carry a high penalty in gate speed and fidelity. As shown in (b)-(e), a high fidelity, large quantum system will likely involve three levels of modularity---a very short-range modularity #emph[m] that allows breaking a QPU into multiple chips with minimal cost in gate speed and fidelity, a longer range connection #emph[l] for use within a single cryogenic environment to both get around I/O bottlenecks and allow non-trivial topologies or routing, and a very long-range optical "quantum network" #emph[t] to allow nearby QPUs to work together as a single quantum computational node (QCN). We will also need on-chip non-local couplers #emph[c] as shown in (b) for the exploration of LDPC codes. In this figure, pink lines represent quantum communication and purple lines represent classical communication.
  ]
)
<mod>

#figure(
  table(
    columns: 3,
    align: (center, left, left),
    inset: (x: 7pt, y: 3pt),
    stroke: none,
    table.hline(stroke: 0.8pt),
    [*Type*], [*Description*], [*Use*],
    table.hline(stroke: 0.5pt),
    [$p$], [Real-time classical communication], [Classical parallelization of QPUs],
    [$m$], [Short range, high speed, chip-to-chip], [Extend effective size of QPUs],
    [$l$], [Meter-range, microwave, cryogenic], [Escape I/O bottlenecks, enabling multi-QPUs],
    [$c$], [On-chip non-local couplers], [Non-planar error-correcting code],
    [$t$], [Optical, room-temperature links], [Ad-hoc quantum networking],
    table.hline(stroke: 0.8pt),
  ),
  caption: [Types of modularity in a long-term scalable quantum system],
  kind: table,
  placement: top,
) <tab:modularity>

The introduction of modular quantum systems will be key to bootstrapping ourselves from near-term quantum advantage towards long-term error-corrected quantum systems. These are systems with repeating unit cells that can be replaced if defective, with quantum links between the chips to entangle unit cells or perform remote gates. This approach simplifies QPU design and test, and allows us to scale quantum systems at will.

#block[
#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (center,left,left,),
    table.hline(stroke: 0.8pt),
    table.header([Type], [Description], [Use],),
    table.hline(),
    [$p$], [Real-time classical communication], [Classical parallelization of QPUs],
    [$m$], [Short range, high speed, chip-to-chip], [Extend effective size of QPUs],
    [$l$], [Meter-range, microwave, cryogenic], [Escape I/O bottlenecks, enabling multi-QPUs],
    [$c$], [On-chip non-local couplers], [Non-planar error-correcting code],
    [$t$], [Optical, room-temperature links], [Ad-hoc quantum networking],
    table.hline(),
  )]
  , kind: table
  )

]
In the near term, given limited or no error correction, the unit cells will require high-bandwidth and high fidelity links to connect them---there is not enough time to use complex protocols such as entanglement distillation. The simplest proposals to accomplish this extend quantum busses off chip, allowing the same gates between distant chips as on a single processor\@2102.13293#cite(<conner2021superconducting>). This "dense modularity", which we denote $m$, effectively extends the chip size. This requires linking adjacent chips with ultra low loss, low cross-talk lines that are short enough to be effectively single-mode---the distance between chips has to be of the order of the distance between qubits on a single chip. Several technologies from classical computational hardware may be adaptable to this problem but adding the flexibility to replace individual units will require other alternatives#cite(<Larsson_2006>).

The high density of qubits in this "dense modularity" creates a spatial bottleneck for classical I/O and cooling. Proposals to ameliorate this near term include the development of high-density connectors and cables to route classical signals on and off the chip@Tuckerman2016@Reilly2015, and the addition of time- and frequency-domain multiplexing of controls. A longer term approach to address this is to improve qubit connectivity through the use of a modified gate performed over a long conventional cable@Zhong2021@Kurpiers2018@Leung2019, called $l$ modularity. Beyond allowing us to escape control and cooling bottlenecks, these long-range couplers enable the realization of non-2D topologies, thereby not only reducing the average distance between qubits but also opening the door to the exploration of more efficient non-2D LDPC error correction codes#cite(<Campbell2017>). Developing these long-range couplers thus not only allows us to scale our near-term systems, but begins to form the basis for how to build quantum systems with mulitple QPUs.

The technologies that enable both dense modularity and long-range couplers, once developed and optimized, will ultimately be ported back into the qubit chip to enable non-local, non-2D connectivity. These on-chip non-local $c$ couplers will ultimately allow implementation of high-rate LDPC codes, bringing our long-term visions to completion.

Finally, connecting multiple quantum computers in an ad-hoc way will allow us to create larger systems as needed. In this “quantum networking” approach, the signals are typically envisioned to leave the dilution refrigerator, enabled by long-term technological advancements in microwave-to-optical transduction using photonic $t$ links between different fridges.

With these four forms of modularity, we can redefine “scale” for a quantum system by $ upright("n") = ([ ( q thin m ) thin l ] t) p $ where $n$ is the number of qubits in the entire modular and parallelized quantum system. The system is comprised of QPUs made from $m$ chips, each QPU having $q times m$ qubits. The QPUs can be connected with $l thin t$ quantum channels (quantum parallelization), with $l$ of them being microwave connections and $t$ optical connections. Finally, to enable things like circuit cutting and speeding up error mitigation, each of these multi-chip QPUs can support classical communication, allowing $p$ classical parallelizations.

A practical quantum computer will likely feature all five types of modularity---classical parallelization, dense chip-to-chip extension of 2D lattices of qubits ($m$), sparse connections with non-trivial topology within a dilution refrigerator ($l$), non-local on-chip couplings for error correction ($c$), and long-range fridge-to-fridge quantum networking ($t$) (Table~#ref(<tab:modularity>, supplement: none)). The optimal characteristic size of each level of modularity is an open question. The individual “chip-to-chip” modules will still be made as large as possible, maximizing fidelity and connection bandwidth. Performing calculations on a system like this with multiple tiers of connectivity is still a matter of research and development@Nickerson2013#cite(<monroe2014modular>).

Modularity needs to happen not just at the scale of the QPU, but at all levels of the system. Modular classical control systems allow for easy subsystem testing, replacement, and assembly. It's much easier to build a test infrastructure for a large number of small modules each year than a single, re-workable monolith. The same can be said of refrigeration, with the added benefit that shipping and deploying monolithic large refrigeration systems is impractical. A large number of our current failure points come in I/O and signal delivery, so modular solutions where sub-assemblies can be swapped out are essential. The challenge here is moving the replaceable unit from a single unit (a cable) to a larger unit (a flexible ribbon cable or other cable assembly).

While the jury is still out on module size and other hardware details, what is certain is that the utility of any quantum computer is determined by its ability to solve useful problems with a quantum advantage while its adoption relies on the former plus our ability to separate its use from the intricacies of its hardware and physics-level operation. Ultimately, the power provided by the hardware is accessed through software that must enable flexible, easy, intuitive programming of the machines.

// [figvision-cn] imgs/IPE_circuit_decomposition.png
// 该图展示量子电路从高层抽象到物理实现的多层级表示流程，
// 整体布局为从左至右、由上至下的分解与细化路径。 左上角
// 子图（a）：标题“Unitary circuit”，类型为示意图。左侧垂
// 直排列四个量子比特线 q0, q1, c10, c7，其中 q0 和 q1 为
// 计算量子比特，c10 和 c7 为经典控制线。在 q0 线上有一个
// 蓝色矩形框标注“U”，其右侧连接一个黑色旋转门符号（带斜
// 杠圆圈），再右侧是另一个相同旋转门；q1 线上对应位置也
// 有两个相同的旋转门。所有旋转门下方有箭头指向下方，并标
// 注数字“3”、“2”、“1”、“0”，分别对应各门的位置索引。在
// q0 和 q1 之间有一个紫色竖条区域，标注“CPE phase”，内含
// 文字“phase”。整个结构被一个大方框包围，右侧有一个粗黑
// 箭头指向右上方的子图（b）。 右上角子图（b）：标题“
// Decomposition as parameterized dynamic circuit”，类型
// 为参数化动态电路示意图。包含三条水平线：q0, q1, c10。
// 每条线上分布多个门操作块。q0 线上依次出现：白色方块“H”、
// 紫色长条“-8*phase=-π/2, π/2, 0”、灰色方块“P 0”、白色方
// 块“W”、紫色长条“-4*phase=-π/2, π/2, 0”、灰色方块“P 0”、
// 白色方块“W”、黑色旋转门、白色方块“W”、紫色长条“-2*
// phase=-π/2, π/2, 0”、灰色方块“P -π/4”、白色方块“W”、黑
// 色旋转门、灰色方块“P -3π/4”、白色方块“W”、黑色旋转门、
// 灰色方块“P -π/2”。q1 线上类似但部分门缺失或不同：起始
// 无 H 门，直接接紫色长条“-8*phase=...”等后续结构与 q0
// 相似但相位值略有差异。c10 线为经典控制线，仅在特定时间
// 点标记“0x0”、“0x1”、“0x2”、“0x3”，并在某些门下方标注“0
// ”或“1”表示触发条件。图中用虚线框圈出中间一段电路（从第
// 一个 P 门到第二个 W 门后），并用虚线箭头指向右下角子图
// （d）。此外，在该子图中央偏下位置嵌入一个小插图：一个
// 六节点图，节点编号 0–5，边连接关系为 0-1, 1-2, 1-3,
// 3-4, 3-5, 4-5，形成环状加中心星形结构，用于示意拓扑约
// 束。 左下角子图（c）：标题“Scheduled circuit with
// bound parameter”，类型为时间轴调度图。横轴为“System
// cycle time (dt)”，范围从 0 到 11457 dt，刻度标记包括
// 2291, 4583, 6874, 9165, 11457。纵轴列出八个通道：q0,
// q1, q2, q3, q4, q5, c1, c2。每个通道上有彩色矩形块代表
// 操作区间。q0 通道顶部有一深灰色块标注“Measure”，覆盖约
// 0–2291 dt；其后有两个浅蓝色块标注“CX”和“Rz”，分别位于
// ~4583–6874 dt 和 ~9165–11457 dt；另有一个红色小点标注“
// Rz”在 CX 块内。q1 通道有三个浅蓝色块标注“CX”，分别在 ~
// 4583–6874 dt、~6874–9165 dt、~9165–11457 dt，中间夹一
// 个红色“Rz”点。q2–q5 通道均为空白灰条，无操作。c1 通道
// 底部有一橙色大块标注“Classical function 2”，覆盖约
// 4583–11457 dt。c2 通道顶部有一深灰色块标注“Measure”，
// 覆盖约 0–2291 dt。所有操作块之间有垂直细线对齐关键时间
// 节点。图中还有一个大空心箭头从右侧指向此子图，表明它是
// 从上一步骤推导而来。 右下角子图（d）：标题“
// Parameterized physical circuit”，类型为物理层电路示意
// 图。包含八条水平线：q0 ← 0, q1 ← 1, ancilla_0 ← 2,
// ancilla_1 ← 3, ancilla_2 ← 4, ancilla_3 ← 5, ancilla_4
// ← 6, c7。每条线上方标注初始状态赋值（如 q0 ← 0 表示初
// 始化为零态）。电路中分布多种门：黑色旋转门（带斜杠圆圈）、
// 蓝色方块标注“Rz”及具体角度（如 π/2, π/4, -π/4, -3π/4）、
// 浅蓝色方块标注“X”或“IX”（可能表示单比特 X 门或受控 X
// 门）、以及连接线表示多比特相互作用。例如，q0 线上有多
// 个 Rz 门交替出现，间隔以 X 门；ancilla 线与 q0/q1 之间
// 存在交叉连线，表示纠缠或耦合操作。时间轴底部标记“0x0”、
// “0x1”、“0x2”、“0x3”，对应经典控制信号触发时刻。整个电
// 路通过虚线箭头与上方子图（b）相连，表示这是将参数化动
// 态电路映射到实际硬件支持的门集后的结果。 全图传达的核
// 心趋势：量子电路可从高层酉矩阵表示（unitary block）逐
// 步分解为参数化逻辑门序列，再进一步实例化为符合硬件限制
// 的物理门集合，并最终生成带有精确时序、校准参数和脉冲形
// 状的可执行调度方案。每一层级都引入更多细节和约束，体现
// 从算法设计到工程实现的完整链条。
// [figvision-cn] imgs/IPE_circuit_decomposition.png
// 该图展示量子电路从高层抽象到物理实现的多层级表示流程，
// 整体布局为从左至右、由上至下的分解与细化路径。 左上角
// 子图（a）：标题“Unitary circuit”，类型为示意图。左侧垂
// 直排列四个量子比特线 q0, q1, c10, c7，其中 q0 和 q1 为
// 计算量子比特，c10 和 c7 为经典控制线。在 q0 线上有一个
// 蓝色矩形框标注“U”，其右侧连接一个黑色旋转门符号（带斜
// 杠圆圈），再右侧是另一个相同旋转门；q1 线上对应位置也
// 有两个相同的旋转门。所有旋转门下方有箭头指向下方，并标
// 注数字“3”、“2”、“1”、“0”，分别对应各门的位置索引。在
// q0 和 q1 之间有一个紫色竖条区域，标注“CPE phase”，内含
// 文字“phase”。整个结构被一个大方框包围，右侧有一个粗黑
// 箭头指向右上方的子图（b）。 右上角子图（b）：标题“
// Decomposition as parameterized dynamic circuit”，类型
// 为参数化动态电路示意图。包含三条水平线：q0, q1, c10。
// 每条线上分布多个门操作块。q0 线上依次出现：白色方块“H”、
// 紫色长条“-8*phase=-π/2, π/2, 0”、灰色方块“P 0”、白色方
// 块“W”、紫色长条“-4*phase=-π/2, π/2, 0”、灰色方块“P 0”、
// 白色方块“W”、黑色旋转门、白色方块“W”、紫色长条“-2*
// phase=-π/2, π/2, 0”、灰色方块“P -π/4”、白色方块“W”、黑
// 色旋转门、灰色方块“P -3π/4”、白色方块“W”、黑色旋转门、
// 灰色方块“P -π/2”。q1 线上类似但部分门缺失或不同：起始
// 无 H 门，直接接紫色长条“-8*phase=...”等后续结构与 q0
// 相似但相位值略有差异。c10 线为经典控制线，仅在特定时间
// 点标记“0x0”、“0x1”、“0x2”、“0x3”，并在某些门下方标注“0
// ”或“1”表示触发条件。图中用虚线框圈出中间一段电路（从第
// 一个 P 门到第二个 W 门后），并用虚线箭头指向右下角子图
// （d）。此外，在该子图中央偏下位置嵌入一个小插图：一个
// 六节点图，节点编号 0–5，边连接关系为 0-1, 1-2, 1-3,
// 3-4, 3-5, 4-5，形成环状加中心星形结构，用于示意拓扑约
// 束。 左下角子图（c）：标题“Scheduled circuit with
// bound parameter”，类型为时间轴调度图。横轴为“System
// cycle time (dt)”，范围从 0 到 11457 dt，刻度标记包括
// 2291, 4583, 6874, 9165, 11457。纵轴列出八个通道：q0,
// q1, q2, q3, q4, q5, c1, c2。每个通道上有彩色矩形块代表
// 操作区间。q0 通道顶部有一深灰色块标注“Measure”，覆盖约
// 0–2291 dt；其后有两个浅蓝色块标注“CX”和“Rz”，分别位于
// ~4583–6874 dt 和 ~9165–11457 dt；另有一个红色小点标注“
// Rz”在 CX 块内。q1 通道有三个浅蓝色块标注“CX”，分别在 ~
// 4583–6874 dt、~6874–9165 dt、~9165–11457 dt，中间夹一
// 个红色“Rz”点。q2–q5 通道均为空白灰条，无操作。c1 通道
// 底部有一橙色大块标注“Classical function 2”，覆盖约
// 4583–11457 dt。c2 通道顶部有一深灰色块标注“Measure”，
// 覆盖约 0–2291 dt。所有操作块之间有垂直细线对齐关键时间
// 节点。图中还有一个大空心箭头从右侧指向此子图，表明它是
// 从上一步骤推导而来。 右下角子图（d）：标题“
// Parameterized physical circuit”，类型为物理层电路示意
// 图。包含八条水平线：q0 ← 0, q1 ← 1, ancilla_0 ← 2,
// ancilla_1 ← 3, ancilla_2 ← 4, ancilla_3 ← 5, ancilla_4
// ← 6, c7。每条线上方标注初始状态赋值（如 q0 ← 0 表示初
// 始化为零态）。电路中分布多种门：黑色旋转门（带斜杠圆圈）、
// 蓝色方块标注“Rz”及具体角度（如 π/2, π/4, -π/4, -3π/4）、
// 浅蓝色方块标注“X”或“IX”（可能表示单比特 X 门或受控 X
// 门）、以及连接线表示多比特相互作用。例如，q0 线上有多
// 个 Rz 门交替出现，间隔以 X 门；ancilla 线与 q0/q1 之间
// 存在交叉连线，表示纠缠或耦合操作。时间轴底部标记“0x0”、
// “0x1”、“0x2”、“0x3”，对应经典控制信号触发时刻。整个电
// 路通过虚线箭头与上方子图（b）相连，表示这是将参数化动
// 态电路映射到实际硬件支持的门集后的结果。 全图传达的核
// 心趋势：量子电路可从高层酉矩阵表示（unitary block）逐
// 步分解为参数化逻辑门序列，再进一步实例化为符合硬件限制
// 的物理门集合，并最终生成带有精确时序、校准参数和脉冲形
// 状的可执行调度方案。每一层级都引入更多细节和约束，体现
// 从算法设计到工程实现的完整链条。
#figure([
  #image("imgs/orcle.png", width: 100%)
  #v(0.6em)
  #horizontalrule
  #v(0.6em)
  #image("imgs/IPE_circuit_decomposition.png", width: 100%)
  ],
  caption: [
    Circuits can be represented at various levels. Unitary blocks represent circuits from libraries. These can be decomposed into parameterized circuits using the universal set of gates. Parameterized physical circuits use the physical gates supported by the hardware, while scheduled circuits specify timing, calibrations, and pulse shapes.
  ],
  placement: top,
)
<circuits>

= THE QUANTUM STACK
<sec:software>
For quantum computing to succeed in changing what it means to compute, we need to change the architecture of computing. Quantum computing is not going to replace classical computing but rather become an essential part of it. We see the future of computing being a quantum-centric supercomputer where QPUs, CPUs, and GPUs all work together to accelerate computations. In integrating classical and quantum computation, it is important to identify (1) latency, (2) parallelism (both quantum and classical), and (3) what instructions should be run on quantum vs. classical processors. These points define different layers of classical and quantum integration.

Before we go into the stack, we need to redefine a quantum circuit. Here we define a quantum circuit as follows:

#horizontalrule

#horizontalrule

This is general enough to represent the circuit model@DiVincenzo95, the measurement model@Nielsen03, and the adiabatic model@Farhi2000 of computation, and special routines such as teleportation. Furthermore, it can represent the circuit at various levels: unitary (unitary block that could represent circuit libraries such as quantum phase estimation, classical functions, etc.), standard decomposition (reduced to a universal set of gates or expressing the classical functions as reversible gates), parameterized physical circuits (using the physical gates supported by the hardware, possibly including ancilla qubits not used in the circuit, or parameters that are easy to update in real-time), and scheduled circuits (complete timing information, calibrated gates, or gates with assigned pulse shape) (see fig. @circuits). OpenQASM@qasm3 is an example intermediate representation for this extended quantum circuit and can represent each of these various abstractions.

With this extended quantum circuit definition, it is possible to define a software stack. Fig.~#ref(<stack>, supplement: none) shows a high level view of the stack, where we have defined four important layers: dynamic circuits, quantum runtime, quantum serverless, and software applications. At the lowest level, the software needs to focus on executing the circuit. At this level, the circuit is represented by controller binaries that will be very dependent on the superconducting qubit hardware, supported conditional operations and logic, and the control electronics used. It will require control hardware that can move data with low latency between different components while maintaining tight synchronization. For superconducting qubits, real-time classical communication will require a latency of $tilde.op$100 nanoseconds. To achieve this latency, the controllers will be located very close to the QPU. Today, the controllers are built using FPGAs to provide the flexibility needed, but as we proceed to larger numbers of qubits and more advanced conditional logic, we will need ASICs or even cold CMOS.

// [figvision-cn] imgs/stack.png
// 该图为量子软件栈的分层架构示意图，整体由四个垂直堆叠的
// 矩形区域构成，自下而上依次表示从底层硬件控制到顶层应用
// 的不同抽象层级。每个主矩形内部包含标题文字及功能描述文
// 字，部分层级右侧附有小型标签框以标识特定组件。 子图a（
// 最底层）： 类型：示意图中的基础层矩形块。 内容：浅灰色
// 填充矩形，占据图像底部约四分之一高度。矩形内居中显示两
// 行黑色文字：“Dynamic Circuit (Real Time Classical +
// Quantum)”位于上方，“Circuit Execution”位于下方。此层代
// 表实时经典与量子协同的动态电路执行层，是量子指令直接作
// 用于物理设备的接口。无坐标轴、曲线或比例尺。 子图b（第
// 二层）： 类型：示意图中的中间层矩形块。 内容：中灰色填
// 充矩形，位于子图a正上方，高度约占图像总高的五分之一。
// 矩形内居中显示两行黑色文字：“Quantum Runtime (
// Near-Time Classical + Quantum)”位于上方，“Runtime
// Compilation/Error Suppression/Mitigation/Correction
// ...”位于下方。右侧边缘附加一个深灰色小矩形标签，内含白
// 色文字“controller binaries”，指向本层右边界，表明控制
// 器二进制文件在此层运行。此层负责近实时编译、误差抑制、
// 缓解与校正等运行时操作。无坐标轴或颜色映射。 子图c（第
// 三层）： 类型：示意图中的高层矩形块。 内容：淡蓝色填充
// 矩形，位于子图b正上方，高度约占图像总高的三分之一。矩
// 形内顶部居中标题：“Quantum Serverless (Classical Cloud
// /HPC + Quantum)”。其下分列左右两组功能模块：左侧为“
// Circuit Compilation”，其下列出“Synthesis, Layout &
// Routing, Optimization ...”；右侧为“Circuit Knitting
// toolbox”，其下列出“Entanglement Forging, Embedding,
// Cutting ...”。右侧边缘附加一个浅蓝色小矩形标签，内含深
// 色文字“Primitive programs”，指向本层右边界，表示原语程
// 序在此层被调用。此层整合经典云/高性能计算资源与量子能
// 力，提供电路编译、布局布线优化及纠缠编织工具集。无坐标
// 轴或数据点。 子图d（最顶层）： 类型：示意图中的应用层
// 矩形块。 内容：中等饱和度蓝色填充矩形，位于子图c正上方，
// 高度约占图像总高的四分之一。矩形内顶部居中标题：“
// Quantum Software Applications”。其下列出三个应用领域，
// 用竖线分隔：“Machine learning | Natural science |
// Optimization ....”。右侧边缘附加一个较深蓝色小矩形标签，
// 内含白色文字“Workflows”，指向本层右边界，表示工作流编
// 排在此层实现。此层面向具体应用场景，如机器学习、自然科
// 学和优化工问题，通过工作流组织任务执行。无坐标轴或数值
// 刻度。 整体趋势与结论：该图展示量子软件栈的四层结构，
// 自底向上分别为动态电路执行层、量子运行时层、量子无服务
// 器层（含经典-量子混合计算）、以及量子软件应用层。每层
// 承担不同粒度的任务抽象与优化职责，右侧标签框分别标注各
// 层关键组件（controller binaries、Primitive programs、
// Workflows），体现从硬件控制到用户应用的完整技术栈演进
// 路径。所有文本均为英文，字体统一为无衬线体，字号随层级
// 重要性略有调整，但未见明确尺寸单位。图中无箭头、连线或
// 其他图形元素，仅靠垂直堆叠表达层级关系。
#figure(image("imgs/stack.png", width: 45.0%),
  caption: [
    The quantum software stack is comprised of four layers, each targeting the most efficient execution of jobs at different levels of detail. The bottom layer focuses on the execution of quantum circuits. Above it, the quantum runtime efficiently integrates classical and quantum computations, executes primitive programs, and implements error mitigation or correction. The next layer up (quantum serverless) provides the seamless programming environment that delivers integrated classical and quantum computations through the cloud without burdening developers with infrastructure management. Finally, the top layer allows users to define workflows and develop software applications.
  ],
  placement: top,
)
<stack>

// [figvision-cn] src/large-to-small.png
// 该图像为一张系统架构示意图，展示了一种将量子与经典计算
// 相结合的无服务器架构。图中包含三个主要部分，分别对应三
// 种不同的量子电路处理方法：Circuit Cutting（电路切割）、
// Entanglement Forging（纠缠锻造）和 Quantum Embedding（
// 量子嵌入）。 子图类型：流程图/架构图 整体布局：顶部是
// 一个大矩形框代表“Large quantum circuit”（大型量子电路），
// 其下方通过三条分支线连接到三个并列的处理模块，每个模块
// 内部又分为“General Classical”（通用经典计算）和“
// Specialized Classical”（专用经典计算）两个区域。 顶部
// 模块： 物体：一个浅蓝色填充的矩形框。 标注文字：“Large
// quantum circuit”。 尺寸标注：左侧有垂直双向箭头标注“
// qubit number”（量子比特数），上方有水平双向箭头标注“
// gate depth”（门深度）。 连接：从该矩形框底部引出三条细
// 实线，分别指向下方的三个处理模块。 左侧模块（Circuit
// Cutting）： 标题：模块正下方标注“Circuit Cutting”。 内
// 部结构：由左右两个大方框组成，左边标注“General
// Classical”，右边标注“Specialized Classical”。 General
// Classical 区域内容： 包含三个虚线框，每个框内有一个小
// 方框，分别标注“E₁”、“Eᵢ”、“Eₙ”。 这些 E 方框之间用带箭
// 头的实线连接，表示数据流或依赖关系。 还有一个较大的实
// 线框标注“Classical”，位于右侧，接收来自 E 方框的输入。
// Specialized Classical 区域内容： 包含多个堆叠的小矩形
// 块，象征并行计算单元（如 GPU 或 HPC 节点），排列成两列
// 多行。 连接：整个模块底部有一条向上的粗箭头，指向顶部
// 的“Large quantum circuit”，表示结果回传。 中间模块（
// Entanglement Forging）： 标题：模块正下方标注“
// Entanglement Forging”。 内部结构：同样分为“General
// Classical”和“Specialized Classical”两部分。 General
// Classical 区域内容： 左侧有一个“Classical”方框，右侧有
// 一个“Specialized Classical”方框。 “Specialized
// Classical”内含多个堆叠的小矩形块。 两者之间有箭头指示
// 交互。 Specialized Classical 区域内容： 四个虚线框，分
// 别标注“E₁”、“E₂”、“E₃”、“E₄”，呈 2x2 排列。 每个 E 方
// 框内有向右的箭头，表示输出方向。 连接：底部有向上箭头
// 指向顶部电路。 右侧模块（Quantum Embedding）： 标题：
// 模块正下方标注“Quantum Embedding”。 内部结构：分为“
// General Classical”和“Specialized Classical”。 General
// Classical 区域内容： 两个虚线框，分别标注“Eₙ”和“E₁”，
// 上下排列。 旁边有一个“Classical”方框，接收来自 E 方框
// 的输入。 Specialized Classical 区域内容： 与左侧模块类
// 似，包含多组堆叠的小矩形块，代表专用计算资源。 连接：
// 底部有向上箭头指向顶部电路。 所有模块中的“E”符号代表
// estimator primitives（估计器原语），即量子运行时的基本
// 操作单元。“Classical”方框代表通用经典处理器，“
// Specialized Classical”区域内的堆叠块代表高性能计算（
// HPC）或图形处理器（GPU）等专用硬件。 趋势与结论：该图
// 展示了如何将大型量子电路分解为可管理的子任务，并通过混
// 合使用通用和专用经典计算资源来执行这些任务。三种方法（
// Circuit Cutting, Entanglement Forging, Quantum
// Embedding）代表了不同的策略，用于在现有硬件限制下扩展
// 量子计算能力。最终所有路径都汇聚回原始量子电路，表明这
// 是一个闭环优化过程。
#figure(image("src/large-to-small.png", width: 85.0%),
  caption: [
    Example of a quantum serverless architecture integrating quantum and classical computations. Quantum runtimes are illustrated by estimator primitives. Cloud computing is illustrated by general classical computing. Specialized classical computing such as high precision computing (HPC) or graphics processing units (GPUs) could be integrated into the serverless architecture. In circuit cutting, a larger circuit is split into many smaller circuits using a specialized classical computer. For each of the smaller circuits, an estimator primitive is executed ($E_1$, $dots.h.c$, $E_N$) and if needed, a classical computing routine could be used to condition future circuits on the results of previous estimators. The process can be repeated as needed. In entanglement forging, a 2N-qubit wavefunction is decomposed into a larger number of N-qubit circuits. The entanglement synthesis may need to be offloaded to specialized classical processors. For each N-qubit circuit, an estimator $E_N$ is executed and combined to give the global outcome. This process could be repeated if used in a variational algorithm. Quantum embedding separates sub-parts of a problem that can be simulated classically from those computationally most costly and requiring quantum computations. A specialized classical computer could be used to condition the problem on previous outcomes. The quantum simulations employ estimators $E_N$ running on QPUs. The estimators can condition quantum circuits on previous outcomes with classical calculations run on the general classical processors. Collectively, this set of tools allows larger systems to be simulated with higher accuracy.
  ],
  placement: top,
)
<knitting>

We refer to the next level up as the quantum runtime layer. This is the core quantum computing layer. In the most general form, we expect a quantum computer to run quantum circuits and generate non-classical probability distributions at their outputs. Consequently, much of the workloads are sampling from or estimating properties of distributions. The quantum runtime thus needs to include at least two primitive programs: the sampler and the estimator. The sampler collects samples from a quantum circuit to reconstruct a quasi-probability distribution of the output. The estimator allows users to efficiently calculate expectation values of observables.

The circuit sent to the runtime would be a parameterized physical circuit. The software would perform a runtime compilation and process the results before returning the corrected outcome. The runtime compilation would update the parameters, add error suppression techniques such as dynamical decoupling, perform time-scheduling and gate/operation parallelization, and generate the controller code. It would also process the results with error mitigation techniques, and in the future, error correction. Both today's error mitigation and tomorrow's error correction will place strong demands on the classical computing needed inside these primitive programs. The circuit execution time could be as low as 100 microseconds (maybe even 1 microsecond for error correction), which is not possible over the cloud. It will need to be installed as part of the quantum computer. Fortunately, error mitigation is pleasingly parallel, thus using multiple QPUs to run a primitive will allow the execution to be split and done in parallel.

At the third level, we imagine software that can combine advanced classical calculations with quantum calculations. As described earlier in this paper, introducing classical computing can enable ideas such as circuit kniting. Here we need to be able to call quantum primitive programs as well as perform classical calculations such as circuit partitions. We call this a workflow (fig. @knitting shows examples of workflows for circuit knitting). We refer to quantum serverless as the software architecture and tooling that supports this in a way that allows developers to focus only on code and not on the classical infrastructure. Along with circuit knitting, this layer will also allow advanced circuit compiling that could include synthesis, layout and routing, and optimization---all of which are parts of the circuit reduction that should happen before sending the circuit to execute.

Finally, at the highest level of abstraction, the computing platform must allow users to efficiently develop software applications. These applications may need access to data and to resources not needed by the quantum computation itself but needed to provide the user an answer to a more general problem.

Each layer of the software stack we just described brings different classical computing requirements to quantum computing and defines a different set of needs for different developers. Quantum computing needs to enable at least three different types of developers: kernel, algorithm, and model developers. Each developer creates the software, tools, and libraries that feed the layers above, thereby increasing the reach of quantum computing.

The kernel developer focuses on making quantum circuits run with high quality and speed on quantum hardware. This includes integrating error suppression, error mitigation, and eventually, error correction into a runtime environment that returns a simplified application programming interface (API) to the next layer.

// [figvision-cn] imgs/qc_timescales.png
// 该图是一幅水平布局的流程图，展示了量子计算软件栈中从用
// 户程序到硬件的动态电路的四个层级及其相互关系。整个流程
// 从左至右排列，由四个主要模块组成，模块之间通过蓝色的双
// 向箭头连接，表示数据或控制的双向流动。 最左侧为第一层，
// 标题为“User Programs”。该层包含一个云朵形状的图标，云
// 朵主体为浅蓝色渐变，顶部有数条青色短线代表光芒。云朵下
// 方标注文字“User Programs”，其下小字注明时间尺度“
// Seconds”（秒）。再下方列出了对应的使用者角色：“Model
// Developers”和“Enterprises”。在整幅图的最左下角，独立标
// 注了“Builders”和“Users”，指向这一高层级。 向右移动，第
// 二个模块标题为“Quantum Serverless”。该模块的图形是一个
// 由许多圆点组成的螺旋状图案，圆点颜色从中心的深绿色逐渐
// 过渡到外圈的蓝色，呈现出一种向外扩散的视觉效果。该模块
// 下方标注文字“Advanced Classical”，并注明时间尺度“
// 10-100 milliseconds”（10-100毫秒）。对应的开发者角色位
// 于更下方，标注为“Algorithm Developer”和“Model
// Developers”。 第三个模块标题为“Quantum Runtime”。其图
// 形为一个黑色的抽象符号，看起来像是一个带有指针的仪表盘
// 或时钟的一部分，指针指向右上方。该模块下方标注文字“
// Near-Time”，时间尺度为“100 microseconds”（100微秒）。
// 对应的开发者角色为“Kernel Developers”和“Algorithm
// Developers”。 最右侧为第四层，标题为“Dynamic circuits”。
// 该部分包含两个并排的图像：左侧是一个三维堆叠结构的示意
// 图，由多层灰色网格板垂直堆叠而成，顶层为白色平面；右侧
// 是一张彩色的实物照片，显示了一个复杂的电子芯片或处理器
// 内部结构，具有金属质感的电路和组件。该模块下方标注文字
// “Real-Time”，时间尺度为“100 nanoseconds”（100纳秒）。
// 对应的角色为“Hardware Engineers”和“Kernel Developers”。
// 整体趋势表明，随着从左侧的用户程序向右侧的动态电路推进，
// 软件抽象层级降低，时间尺度急剧缩短（从秒级到纳秒级），
// 而涉及的开发者角色也从模型开发者和企业用户逐渐转变为内
// 核开发者和硬件工程师。
#figure(image("imgs/qc_timescales.png", width: 75.0%),
  caption: [
    The time scales and resources involved in quantum computing depend on the needs of the different types of developers and the level of abstraction at which they work. Quantum researchers and kernel developers work closer to the hardware while model developers require the highest level of software abstraction.
  ],
  placement: top,
)
<timescales>

// [figvision-cn] src/q+c.png
// 该图像为一幅系统架构示意图，展示了一种将经典处理器与量
// 子处理单元（QPU）集成的集群式架构模型。图中无坐标轴、
// 曲线或比例尺，主要由几何图形、文本标签和箭头构成，用于
// 说明组件间的逻辑关系与数据流向。 左侧为一个黑色圆圈，
// 内部标注“USER”，代表用户入口。从该圆圈向右引出一条紫色
// 双向箭头，连接至一个垂直排列的灰色矩形区域，该区域顶部
// 标有“Classical”字样，表明其属于经典计算部分。灰色区域
// 内自上而下依次包含五个白色子模块，每个模块均有蓝色边框：
// 最上方为“Orchestration”，其下依次为“Workflow”、“
// Quantum Serverless”、“Nested Programs”、“Circuit
// Knitting”和“Circuit/program Optimization”。其中，“
// Nested Programs”背景色略浅于其他模块，可能表示当前激活
// 或重点层级。 右侧分为上下两个主要区块，均被蓝色外框包
// 围，整体标注为“Quantum Computing NODE”。上半部分节点内
// 包含三个并列的蓝色矩形模块：“Primitive”（位于左侧，颜
// 色较浅）、“Controller”（中间）、“QPU”（右侧）。下半部
// 分节点结构更复杂：左侧同样有一个较大的浅色“Primitive”
// 模块；右侧则垂直堆叠三组相同的单元，每组包含一个“
// Controller”和一个“QPU”，共三个“Controller”和三个“QPU”。
// 在最下方一组中，“QPU”模块右下角有一条红色弯曲箭头指向
// 自身，暗示某种反馈或循环机制。 多个紫色双向箭头指示通
// 信路径：一条连接左侧“Orchestration”模块与右上“
// Primitive”模块；另一条连接左下“Circuit Knitting”模块与
// 右下“Primitive”模块；此外，在右侧上下两个“Primitive”模
// 块之间也有一条垂直紫色双向箭头，表示它们之间的交互。所
// 有“Primitive”模块均以虚线框额外勾勒，强调其作为接口或
// 抽象层的功能。 图底部中央标注文字“Distributed
// classical”，表明整个右侧量子节点依赖于分布式的经典计算
// 支持。根据图注提示，颜色深浅反映延迟需求——深色对应更低
// 延迟要求。在此图中，“Primitive”模块使用较浅蓝色，而“
// Controller”和“QPU”使用深蓝色，意味着后两者对低延迟的要
// 求更高。整体布局传达的核心结论是：通过分层编排（
// Orchestration）与分布式经典控制，实现经典与量子资源的
// 协同调度，以优化指令分发、并行化执行及降低端到端延迟。
#figure(image("src/q+c.png", width: 50.0%),
  caption: [
    Model of a cluster-like architecture integrating classical processors with QPUs to address latency, parallelization, and the distribution of instructions among classical and quantum processors. The darker the color, the lower the latency required.
  ],
  placement: top,
)
<cluster>

The algorithm developer combines quantum runtime with classical computing, implements circuit knitting, and builds heuristic quantum algorithms and circuit libraries. The purpose is to enable quantum advantage. Finally, as we demonstrate examples of quantum advantage, the model developer will be able to build software applications to find useful solutions to complex problems in their specific domain, enabling enterprises to get value from quantum computing. Fig.~#ref(<timescales>, supplement: none) summarizes the types of developers addressed by each layer of the software stack and the time scales involved depending on the type of job being executed and how close to the hardware each developer is working.

In putting all of this together and scaling to what we call a quantum-centric supercomputer, we do not see quantum computing integrating with classical computing as a monolithic architecture. Instead, fig. @cluster illustrates an architecture for this integration as a cluster of quantum computational nodes coupled to classical computing orchestration. The darker the color, the closer the classical and quantum nodes must be located to reduce latency. Threaded runtimes can execute primitives on multiple controllers. Classical communication in real time between the controllers can be used to enable things like circuit cutting. The figure also shows how future QPUs with quantum parallelization ($l$ and $t$ couplers) can be controlled by a single controller. We imagine that there could be workloads that need near-time classical communication (i.e., calculations based on the outcome of circuits that must complete in around 100 microseconds) or to share states between the primitives, enabled by a data fabric. Finally, the orchestration would be responsible for workflows, serverless, nested programs (libraries of common classical+quantum routines), the circuit knitting toolbox, and circuit compilation.

= CONCLUSION
<conclusion>
In conclusion, we have charted how we believe that quantum advantage in some scientifically relevant problems can be achieved in the next few years. This milestone will be reached through (1) focusing on problems that admit a super-polynomial quantum speedup and advancing theory to design algorithms---possibly heuristic---based on intermediate depth circuits that can outperform state-of-the-art classical methods, (2) the use of a suite of error mitigation techniques and improvements in hardware-aware software to maximize the quality of the hardware results and extract useful data from the output of noisy quantum circuits, (3) improvements in hardware to increase the fidelity of QPUs to 99.99% or higher, and (4) modular architecture designs that allow parallelization (with classical communication) of circuit execution. Error mitigation techniques with mathematical performance guarantees, like PEC, albeit carrying an exponential classical processing cost, provide a mean to quantify both the expected run time and the quality of processors needed for quantum advantage. This is the near-term future of quantum computing.

Progress in the quality and speed of quantum systems will improve the exponential cost of classical processing required for error mitigation schemes, and a combination of error mitigation and error correction will drive a gradual transition toward fault-tolerance. Classical and quantum computations will be tightly integrated, orchestrated, and managed through a serverless environment that allows developers to focus only on code and not infrastructure. This is the mid-term future of quantum computing.

Finally, we have seen how realizing large-scale quantum algorithms with polynomial run times to enable the full range of practical applications requires quantum error correction, and how error correction approaches like the surface code fall short of the long term needs owing to their inefficiency in implementing non-Clifford gates and poor encoding rate. We outlined a way forward provided by the development of more efficient LDPC codes with a high error threshold, and the need for modular hardware with non-2D topologies to allow the investigation of these codes. This more efficient error correction is the long-term future of quantum computing.

#heading(numbering: none)[Acknowledgments]

#block[
We thank Kristan Temme, Abhinav Kandala, Ewout van den Berg, Jerry Chow, Antonio Córcoles, Ismael Faro, Blake Johnson, Tushar Mittal, and Matthias Steffen for their assistance reviewing this manuscript.

]

#bibliography("refs.bib", style: "ieee", title: none)