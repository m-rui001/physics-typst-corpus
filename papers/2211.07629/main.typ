// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10.9pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 2.54cm, right: 2.60cm, top: 2.59cm, bottom: 1.93cm))
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
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 10pt, weight: "bold")[#num#it.body]])
}

// Front- and back-matter headings are unnumbered.
#show heading.where(label: <acknowledgements>): set heading(numbering: none)
#show heading.where(label: <appendices>): set heading(numbering: none)
#set par(justify: true, spacing: 0.58em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set figure(placement: top)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.58em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(label: <tab-physical-and-logical-overhead>): set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#align(center)[
  #text(12pt, weight: "bold", [Assessing requirements to scale to practical quantum advantage])
]

#v(0.9em)

#align(center)[
  #set text(size: 10.9pt)
  #show super: set text(size: 8pt)
  #par(justify: true)[M. E. Beverland#super[1], P. Murali#super[1], M. Troyer#super[1], K. M. Svore#super[1], T. Hoefler#super[2], V. Kliuchnikov#super[1], G. H. Low#super[1], M. Soeken#super[3], A. Sundaram#super[1], and A. Vaschillo#super[1]]
]

#v(0.6em)

#align(center)[
  #set text(size: 10pt, style: "italic")
  #show super: set text(size: 7pt, style: "normal")
  1Microsoft Quantum, Redmond, WA 98052, USA \
  2ETH Zurich, Department of Computer Science, Zürich, 8006, Switzerland \
  3Microsoft Quantum, Zurich, Switzerland
]

#v(0.4em)

#align(center)[#text(size: 10pt)[(Dated: November 19, 2022)]]

#v(0.9em)

#align(center)[#block(width: 85.5%)[
  #set text(size: 10.9pt)
  #set align(left)
  #set par(justify: true)
  While quantum computers promise to solve some scientifically and commercially valuable problems thought intractable for classical machines, delivering on this promise will require a #emph[large-scale] quantum machine. Understanding the impact of architecture design choices for a scaled quantum stack for specific applications, prior to full realization of the quantum system, is an important open challenge. To this end, we develop a framework for quantum resource estimation, abstracting the layers of the stack, to estimate resources required across these layers for large-scale quantum applications. Using a tool that implements this framework, we assess three scaled quantum applications and find that hundreds of thousands to millions of physical qubits are needed to achieve practical quantum advantage. We identify three qubit parameters, namely size, speed, and controllability, that are critical at scale to rendering these applications practical. A goal of our work is to accelerate progress towards practical quantum advantage by enabling the broader community to explore design choices across the stack, from algorithms to qubits.
]]





= TOWARD QUANTUM APPLICATIONS WITH PRACTICAL IMPACT
<toward-quantum-applications-with-practical-impact>
With rapid progress in quantum computing, there is a shift in focus from scientific demonstrations on a small number of noisy qubits @arute2019 @Preskill2018NISQ towards large quantum systems solving valuable business problems and resolving long-standing scientific questions that are classically intractable~@Schoelkopf21. But just how large does a quantum computer need to be to achieve these forms of #emph[practical quantum advantage], and how long will such a computation take? Are some qubit technologies better suited than others for solving such problems? What are the best architecture choices across the hardware and software stacks to enable scaled quantum computation?


While many quantum algorithms have asymptotic speedups over their non-quantum counterparts~@jordan2011, scaling up to problem sizes with a practical quantum advantage @Babbush2020 will demand high-precision quantum computers. Quantum operations at the physical level are noisy, and so the long computations required for practical quantum advantage necessarily require error correction to achieve fault tolerance. Quantum computers are complex, and the overheads required to ensure fault-tolerant quantum computing will significantly outpace the resources required for fault-tolerant classical computing which is based on small, cheap, and reliable transistors. A fault-tolerant operation on a quantum computer requires orders of magnitude more space -- including many transistors for qubit control and readout -- and runs with much slower clock speeds than a classical computer. With these overheads, practical quantum advantage will be achieved, albeit only for algorithms with small I/O requirements and superquadratic (ideally exponential) speedups over their classical counterparts @Love2020 @Babbush2020 @TroyerQ2B2020.


One algorithm with superquadratic speedup for which the cost of error correction is well studied is Shor's period finding algorithm @Shor1994. Estimating the resources required for Shor's algorithm is important for assessing the vulnerability of some of today's public key cryptosystems to future quantum threats. With the fastest quantum hardware operations proposed to date, factoring a 2048-bit integer using Shor's algorithm could be done in minutes with an array of twenty five thousand #emph[perfect, noiseless] qubits. Yet in reality, qubits are noisy and must have error correction to enable long computation, and so as we will reconfirm later, the implementation cost increases to about a day with tens of millions of qubits~@Gidney2021.


Some of the most compelling quantum algorithms with scientific and commercial interest, however, are those which leverage the ability of a quantum computer to efficiently simulate quantum systems, with applications across chemistry, materials science, condensed matter, and nuclear physics.


The exact simulation time of the dynamics of such quantum systems scales exponentially with classical algorithms, but has a favorable polynomial scaling for quantum algorithms~@lloyd1996.


The earliest application of scientific interest may be simulating the dynamics of around one hundred quantum spins in a quantum magnet @daley2022.


The earliest commercially relevant applications will likely be quantum simulations of chemistry and materials science problems, where a quantum-accelerated elucidation of catalytic reaction mechanisms has applications to fertilizer production @Reiher2017, carbon fixation @vonBurg2021, among many other problems~@bauer2020quantum @vonBurg2021 @delgado2022 @kim2022.


We propose a framework to understand the requirements of applications promising quantum advantage, determine their practicality, and assess changes in the underlying architecture to accelerate their implementation. The framework is composed of layers of abstractions capable of estimating the performance and required resources of quantum applications and algorithms on current and future quantum architecture designs. Starting with an algorithm implemented in a high-level programming language, the framework compiles the algorithm onto the architecture of a specified quantum device and models the resource requirements at the architecture level, considering qubit layout, allowed operations, and other design parameters. We specify models for each layer and implement a tool, the Azure Quantum Resource Estimator, that calculates based on those models an estimate of the resources required to implement a given quantum algorithm on a given architecture with an underlying qubit technology. We focus on #emph[digital] quantum computers using gates and measurements for computation, rather than analog quantum simulators and annealers @daley2022\; however, similar layers of abstraction may also be valuable to analyze these other systems.


We analyze the resources that would be required to implement three specific high-impact applications on various quantum architectures. The first considers the #emph[quantum dynamics] of a simple quantum magnet, the so-called two-dimensional (2D) transverse field Ising model, where we consider a parameter regime that is on the boundary of what can be done by classical computation~@Pearson2020. The second is for #emph[quantum chemistry] where we analyze the activation energy of a catalyst for carbon fixation~@vonBurg2021. Lastly, we analyze #emph[factoring] a large integer with Shor's algorithm. While we do not foresee running this application in practice, it is arguably the best-studied quantum algorithm and can help provide security requirements of our classical cryptosystems. Our analysis reveals that practical quantum advantage for scientific and commercial problems requires hundreds of thousands to millions of qubits which satisfy the following requirements.


#strong[Requirements for scale.---] To achieve practical quantum advantage, quantum computers will require an underlying qubit technology that at scale is:

- #emph[Controllable:] Practical quantum error correction requires reliable control of more than a million well-connected qubits, with parallel operations that fail in under one part in a thousand.

- #emph[Fast:] To achieve a practical runtime of one month or less, while targeting a physical qubit count of around one million, operations will need to be performed in under a microsecond.

- #emph[Small:] Scaling to a million and more qubits constrains the size of the qubit to tens of microns in diameter; this size is determined to avoid the complexity of coherent high-bandwidth quantum interconnects between qubits on different modules.


We see these requirements as necessary to scale to practical quantum advantage, and as valuable additions, for scale, to the criteria for building a quantum computer proposed by DiVincenzo in the year 2000~@Divincenzo2000. They stem from incorporating research developments spanning the last two decades, insights across algorithms to qubits, and an empirical end-to-end resource analysis of several applications and qubit parameter settings. We hope they reveal new considerations and valuable insights in considering how to engineer and architect for scale.


= RESOURCE ESTIMATION FOR CLASSICAL AND QUANTUM COMPUTING
<resource-estimation-for-classical-and-quantum-computing>


Estimating the resources required for computation, also known as performance modeling, plays a central role in classical high-performance computing. Elaborate techniques have been developed to understand application scaling characteristics, their portability across architectures, and resource consumption. These models consider some resources as a measure of cost, such as time, energy, number of instructions, and more recently, data movement. In this section, we first reflect on the mature field of classical computational resource estimation, and then leverage this perspective to present a framework for quantum resource estimation.


// [figvision-cn] imgs/program_flow.png
// 该图包含三个并列的垂直堆叠示意图，分别展示经典计算栈、
// 量子计算栈以及量子资源估算框架。所有子图均采用分层矩形
// 条块结构表示不同抽象层级，条块颜色分为浅蓝色（代表语言
// 或指令集）和米黄色（代表程序表示形式），右侧配有垂直花
// 括号标注分类。 左侧子图标题为“classical computing
// stack”，共七层。从上至下：第一层为米黄色卷轴状图形，标
// 注“high-level language”；第二层为浅蓝色矩形，标注“IR”；
// 第三层为米黄色卷轴，标注“ISA”；第四层为浅蓝色矩形，标
// 注“microcode”；第五层为米黄色卷轴，标注“
// microarchitecture”；第六层为浅蓝色矩形，无文字标注；第
// 七层为米黄色卷轴，标注“transistor control”。最底层下方
// 有一条深灰色横线。左侧边缘有双向箭头：向下箭头旁标注“
// compile down full program”，向上箭头旁标注“build up
// language instructions”。 中间子图标题为“quantum
// computing stack”，同样七层。从上至下：第一层米黄色卷轴，
// 标注“high-level quantum language”；第二层浅蓝色矩形，
// 标注“quantum IR”；第三层米黄色卷轴，标注“quantum ISA (
// logical)”；第四层浅蓝色矩形，标注“microcode (QEC)”；第
// 五层米黄色卷轴，标注“microarchitecture (physical)”；第
// 六层浅蓝色矩形，无文字标注；第七层米黄色卷轴，标注“
// device control”。结构与左侧完全对应，仅内容替换为量子
// 相关术语。 右侧子图标题为“quantum resource estimation
// framework”，分为上下两部分，由一条水平虚线分隔。上半部
// 分包含三层：顶层米黄色卷轴，标注“high-level quantum
// program”；其下绿色倒梯形框内标注“estimate instruction
// counts of ISA program”；再下一层白色矩形框标注“quantum
// ISA”。下半部分包含三层：顶层绿色正梯形框内标注“
// estimate physical resources to supply ISA instructions
// ”；其下两层为浅蓝色矩形，无文字标注；最底层为深蓝色矩
// 形，标注“device specs”。右侧有两个垂直花括号：上方括号
// 涵盖前三层，标注“quantum program representations”；下
// 方括号涵盖后四层，标注“quantum machine models”。整个右
// 侧子图通过箭头和形状强调从高层程序到低层物理资源的估算
// 流程。
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
  [Table #context it.counter.display(it.numbering) #it.body]
}

#figure(image("imgs/program_flow.png", width: 100.0%),
  caption: [
    The stacks for classical (left) and quantum (center) computing. At the top of the stack the program is expressed in a natural, high-level language such as C/C++ (classical) or Q\# (quantum). This program is re-expressed as different program representations (manilla scrolls) in a sequence of languages (blue boxes) which are represented here as layers, with each layer being a lower-level language than that above, down to the physical signals controlling the device. A complementary viewpoint is that the instruction set available to the language at one layer can be combined to form a more elaborate instruction set for the layer above. The scrolls are shortest at the top, symbolizing that program representations are simplest when expressed in higher-level languages, while the blue boxes are smallest at the base of the stack, symbolizing that instruction sets are simplest at the lower levels. (right) Our quantum resource modeling framework is a modular representation of the layers of the quantum computing stack, which collects together the upper layers as #emph[quantum program representations], and the lower layers as #emph[quantum machine models], with the quantum ISA connecting both.
  ]
)
<fig-program-flow>



In the classical computing stack, the program is initially expressed in a high-level language at the top and is sequentially re-expressed in more and more explicit representations down the stack; see the left column of @fig-program-flow. We can consider each layer in the stack as having a language with a specific #emph[instruction set] of allowed instructions, which can be broken down in terms of simpler instructions in the layer below, or combined together to form more abstract instructions for the layer above. For example the program could be expressed in C++, which is compiled into an intermediate representation (IR) for optimizations, e.g., LLVM's static single assignment form (SSA) intermediate representation~@LLVM. The IR is then lowered to assembly code in a specific instruction-set architecture (ISA) that is the interface to the classical processor. Such assembly code could consist of x86~@x86, ARM~@arm, or RISCV~@riscv instruction sets. Some complex instruction set computers such as Intel's Haswell translate the x86 code into a microcode representation for execution by the arithmetic logical units (ALUs). The microarchitecture then executes those micro-instructions and eventually translates them to electrical signals to be implemented by transistors. For some processors, microcode and microarchitecture are combined, but we illustrate them in separate layers here to draw parallels with the quantum stack.


The goal of resource estimation is to model the stack in order to estimate some physical resources such as the run time required to implement a high-level program. One approach could be to consider a chain of re-expressions of the program from the very top of the stack all the way to the bottom and then read off the physical resources needed. Near the top of the stack this is an appealing approach as it is very natural to think of a program being compiled down into a sequence of lower-level representations. Towards the bottom of the stack however this approach becomes very difficult because of the intricacies of the microarchitecture, runtime dependencies of the program execution, and the overall length of the representation itself. However, the instruction sets within which the program is expressed typically become simpler for lower layers, which can be exploited to model resources more conveniently. The strategy is then to choose a layer towards the middle of the stack, and model the layers above by re-expressing the high-level program down to the instruction set at this layer, and estimate the physical resources required to implement those instructions by building them up from the more basic instructions in the layers below.


There is of course a choice about where to draw the line between the top and the bottom in this view of the stack, and the best choice can depend on the precise goals of the model. For most purposes, the ISA layer has emerged as the natural interface because it provides an implementation-independent interface that can be used to ground modeling efforts. ISAs such as x86, ARM and RISCV represent program executions across a wide variety of classical processors. Performance modeling frameworks can leverage this powerful abstraction to model the resources of the full stack by first establishing the requirements of the program when expressed as instructions the ISA level, and then identifying the resources required at the device level to implement the ISA-level program.


The quantum computing stack is less established and abstractions are still in their definition phase. Some aspects are similar, for example while a quantum program includes instructions which are executed as quantum operations, the quantum program itself is just a sequence of instructions similar to a classical program. However, in stark contrast with the classical stack, which is built upon extremely reliable transistors, the quantum stack must account for the unavoidable fact that all forms of physical qubit implementations are inherently noisy~@Preskill2018NISQ. To execute a quantum application successfully, quantum error correction (QEC)~@gottesman1998 must be used to build logical qubits that can be used to store and manipulate quantum information better than raw physical qubits. This QEC capability is central to scalable quantum computers, but the costs are formidable, often multiplying the number of qubits needed by a factor of thousands, and runtimes by a factor of hundreds. Therefore, the specific QEC approach used impacts design decisions across the quantum computing stack, both at the hardware layers which must be capable of implementing it, and at the software layers which must compile to logical operations compatible with it.


Prior works that address the design of a flexible quantum stack and resource estimation span vastly different viewpoints. For example, prior quantum architecture and compilation proposals @ibmstack @triq @shicompilation @bertels develop stacks for near-term small quantum computers, but do not incorporate QEC. These works either ignore noise~@bertels, or reduce its impact with error mitigation techniques~@ibmstack which unfortunately do not scale to larger systems~@quek2022. On the other hand, works comparing resources for multiple QEC codes and logical operations, such as @beverland2021 @Chamberland2022b @Chamberland2019 @Bombin2021 @Litinski2019b, typically address lower layers of the stack without incorporating the software layers. There is a growing number of informative end-to-end resource analyses, but typically these single out very specific algorithms and hardware and make very different assumptions across the stack, making direct comparisons of different approaches challenging~@Fowler2012 @Gidney2021 @gouzien2021 @Chamberland2020 @rotteler17 @beauregard03 @vanmeter10 @lee22 @suchara13.


== A framework for quantum resource estimation
<a-framework-for-quantum-resource-estimation>


We present a quantum resource estimation framework that aims to capture the essential aspects of a full-stack quantum computer with the flexibility to allow direct and easy comparisons across a range of algorithms, software techniques, QEC codes, hardware specifications and other aspects. To form the skeleton of our framework, we propose the stack shown in @fig-program-flow (center) for large-scale quantum computers. This framework builds upon the previous work mentioned above, but seeks to clearly delineate the different layers, clarify the functions of each layer and define how they inter-operate to attain the computation capabilities required for large-scale applications. We find that it is possible to draw broad parallels between the classical and quantum computing stacks, allowing us to leverage established resource modeling strategies from classical performance modeling.


In what follows we describe the layers in this stack, briefly stating the main characteristics of each layer, and listing some known examples from the quantum computing literature which naturally fit into it. As we will see, the layers are modular, allowing them to be designed either collectively or independently, provided that the interfaces between layers remain consistent. Consistency of the interfaces is ensured by providing explicit maps: compilation algorithms for program representations down to the ISA from above, and explicit constructions of instruction sets from those below up to the ISA from below. These maps are themselves a crucial part of the stack and the modeling framework. We start at the top of the stack, where the layers are conceptually similar to the classical case.


#strong[High-level quantum language.]--- This layer hosts the explicit representation of an algorithm as a program expressed in a high-level programming language. The language should enable the expression of any quantum algorithm. At this level of abstraction, users need not know the requirements of quantum error correction, and may assume their program and its operations are fault tolerant. Languages ideally include support for loops, functions, rich type systems, debugging and other functions that are common in classical computing in order to allow quantum applications to be developed and tested efficiently. Similarly, supporting hybrid quantum-classical computation which allow applications to use phases of classical and quantum operations seamlessly is valuable for practical applications. Examples of languages include Q\#~@svore2018, Quipper~@green2013, Scaffold~@abhari2012, QWire~@paykin2017, Quil~@quil and others.


#strong[Quantum IR.]--- To execute a high-level quantum program, that program's instructions need to be #emph[compiled] and expressed in terms of quantum ISA instructions. It is appealing to support executions of programs expressed in a diverse set of high-level languages across a range of hardware back ends that may have different quantum ISAs. In analogy with classical computing, we propose the use of a quantum intermediate representation (quantum IR) that expresses high-level operations in a language-agnostic and ISA-agnostic manner~@mccaskey2021 @Ittah2022 @qir. A compiler then includes three components --- the front end, the optimization layer and the back end. The front end component translates high-level language instructions to the quantum IR. The back end component translates the quantum IR into the quantum ISA operations. The middle optimization layer performs transformations on the quantum IR to reduce resource requirements~@Ittah2022. To support a new quantum language or quantum ISA, we simply need to add the corresponding front end or back end components, rather than reinventing the whole compiler. An example of a quantum IR is the aptly named QIR~@qir, which includes support for expressing logical operations, measurements and other quantum constructs that are required for applications.


The parallels of these two upper layers with the classical stack can be leveraged. For instance, later we consider high-level quantum programs expressed in Rust, and the classical IR LLVM has been applied to quantum compilation tasks Ref.~@javadiabhari2014 @Meuli2020. Next we address the layers at the bottom of the stack and describe how their instruction sets build up to form the instruction set of the logical qubits at the quantum ISA layer (which the quantum IR compiles down to).


#strong[Device control.]--- There is a wide range of hardware approaches to build the quantum device at the base of the stack, including those based on photonic~@knill2001 @carolan2015 @bombin2021a, trapped atom~@Jaksch1999 @bluvstein2022, trapped ion~@Cirac1995 @pino2021, Majorana~@kitaev2001 @sarma2015 @Karzig2017, spin~@kane1998 @Hanson2007 @Jnane2022, superconducting transmon~@transmonSchoelkopf @schreier2008 @kjaergaard2020 @arute2019 @hong2020 @Steffen2011, and electro-acoustic~@Guillaud2019 @Chamberland2022a platforms. Quantum devices themselves are not sufficient for computation, we require classical computing resources to bring up, calibrate and control the devices as well as the ability to transmit and process information from quantum measurements. The nature of how qubits are stored within the device, the range of control available, and the nature of that control are all very device-dependent and form the instruction set at the device level -- the constraints on ion traps will be different than the constraints on transmon qubits, for example, simply because their physical realizations are fundamentally different. It is at this level that resources are typically most forthright - one may consider run time, number of qubits, control bandwidth, device size and other cost metrics.


#strong[Microarchitecture (physical).]--- In this layer, low-level details of the qubit device design are abstracted away, leading to a viewpoint consisting of a set of abstract physical qubits, along with a discrete set of physical instructions such as single-qubit measurements and CNOT gates. These instructions can be characterized by simple properties such as their action on the physical qubits, how long they take to apply, and their probability of failure (their so-called #emph[error rate]). This abstraction allows microarchitectural components to be reused across a variety of qubit device implementations, while flexibly supporting the needs of different QEC schemes. Each of the operations in the physical instruction set is built from operations available at the device control level (for example, in ion traps a CNOT may be implemented by a sequence of Mølmer-Sørensen~@Molmer1999 gates, while in spin qubits it may be implemented by a sequence of exchange interactions~@Hanson2007). In planar device platforms like superconducting qubits or Majorana qubits, the ability to support such device-level operations can lead to connectivity restrictions such as 2D nearest-neighbor connectivity at this level.


#strong[Microcode (QEC).]--- The microcode instruction set consists of the primitives required to implement a QEC strategy, which uses a QEC code to form reliable logical qubits using noisy physical qubits. These logical qubits support logical operations (which form the instruction set for the quantum ISA level above) that have better error rates than raw physical operations. For example, if the QEC strategy uses the surface code~@Kitaev2003 @Bravyi1998, the primitives which form the instruction set will include #emph[syndrome measurement circuits] expressed in the physical instruction set of the microcode layer below. For the surface code, syndrome measurements provide the information required to diagnose and correct faults at the physical level by measuring stabilizers, but can also induce logical operations by deforming the code~@Litinski2019 @Horsman2012.


#strong[Quantum ISA (logical).]--- This layer forms the interface between the software and hardware layers. It abstracts the details of how QEC is implemented in the layer below, retaining only a set of fault-tolerant logical operations as its instruction set. It is crucial that the instruction set is #emph[universal], meaning it is complete for quantum computing. In this formulation of the stack, it is the map from the microcode level to the quantum ISA level that actually implements the error correction, using a classical algorithm known as a #emph[decoder] to identify and correct faults while implementing specific logical operations. Clearly, the instructions in this layer must be chosen such that they can implemented by the underlying hardware; that is, when choosing an ISA, it is important to consider the constraints of the system architecture such as connectivity of logical qubit representations and ability to construct the logical operations with known sequence of micro-operations and physical qubit control operations. At the same time, the ISA operations should be chosen such that the software layers above can efficiently express common application operations using it. The planar quantum ISA is an example we will discuss later which arises from the logical operations of two different QEC approaches, one based on surface codes and the other on Hastings-Haah codes. For instance, the planar quantum ISA instruction set includes single-qubit initializations, single-qubit measurements and multi-qubit measurements, which are all examples of Clifford operations. Clifford operations by themselves are not universal~@GottesmanKnill, but when combined with a fault-tolerant T state initialization, the resulting set becomes universal.


#strong[Estimating resources.]--- Our goal here has been to define the layers of the quantum stack at a sufficiently high-level of abstraction, so that a broad range of known and yet-to-be discovered approaches can be readily incorporated. This forms the basis of a #emph[modular] framework for quantum resource modeling, in which layers can be considered together or independently. We find it convenient to -- similar to the classical case -- split the quantum stack in two at the quantum ISA and analyze the upper layers from the top down in terms of programs, and the lower layers from bottom up in terms of instruction sets; see @fig-program-flow (right). To use the framework to make explicit estimates, one models a consistent instantiation of each layer and each of the maps between layers with an explicit example. Later, we will specify examples of these layers and maps in more detail to answer questions regarding system requirements for scaling.


This framework enables the estimation of resources (such as the number of qubits, the run time and the power consumption) which would be required to implement a given quantum algorithm using a given qubit technology and with a fixed set of architectural choices. Within the framework, architectural choices can be viewed as explicit specifications for each layer and map in the hardware and software parts of the quantum stack. There is no single answer to questions on architectural design trade-offs, with different choices resulting in different estimation results which can be explored to make informed decisions as researchers and engineers work to scale up a complete system. One can, for example, trade off more qubits against shorter run times, or trade off faster qubit gate operations against lower fidelities. One can also use the framework much more broadly, to compare new error correction proposals, to evaluate the potential for quantum advantage for new or optimized quantum algorithms, and to motivate future research directions by identifying bottlenecks in the stack which generate large resource contributions.


The modular nature of the framework allows for future modifications and extensions. For some purposes it may be desirable to combine some layers together, and to split other layers into sub-layers. In this work our focus is on resource estimates for the quantum accelerated parts of the computation, however more layers can be added to model the hybrid aspects of the computation.


== Fault-tolerant design considerations
<fault-tolerant-design-considerations>


Before discussing specific implementations of the quantum resource estimation framework, we address several significant design considerations that arise from the need for QEC. Typically, a QEC approach is centered around a QEC code family which stores the logical qubits. A wide range of QEC codes have been discovered over the last three decades with wide ranging properties, including small codes such as the Shor~@shor1995 and Steane~@steane1996 codes, 2D local codes such as surface codes~@Kitaev2003 @Bravyi1998, color codes~@bombin2006, Hastings-Haah codes~@Hastings2021 and Bacon-Shor codes~@bacon2006 @shor1996, and more exotic families of positive-rate low-density parity check codes~@Tillich2014 @panteleev2022 @guth2014 @leverrier2015. The choice of QEC code has impact up and down the stack since different codes can place different implementation demands on the physical instructions provided by the microarchitecture level below, while also exposing different logical operations to the quantum ISA level above.


Here we focus on the requirements that QEC imposes on the physical operations at the microarchitecture level of the quantum stack, corresponding to the setting known as #emph[circuit-level] analysis in the QEC literature. It is common in this setting to assume QEC is implemented with Clifford operations (state preparation, Clifford unitary gates, and Pauli measurement) for single qubits and across pairs of qubits coupled by a specified #emph[connectivity], and that those operations fail independently with a uniform error rate (see @app-noise). An important metric for a QEC approach in this setting is its #emph[threshold], which specifies the maximum error rate that it can tolerate. In what follows, we leverage known threshold results for a range of QEC schemes to extract a number of key design parameters pertaining to error rates, parallelism and connectivity.


The theoretical upper limit for any threshold is not known, but the highest threshold discovered to date is about 3\% using the scheme described in Ref.~@knill2005, and a range of schemes~@Wang2011 @beverland2016 @tremblay2022 @Paetznick2022 have been found with thresholds approaching 1\%. To avoid prohibitive QEC overheads, error rates at least an order of magnitude smaller than the threshold are much preferred. For this reason, we require physical error rates on Clifford operations below 0.1\%.


The aforementioned schemes obtain high threshold values only in the setting where operations can be applied in parallel, which may pose a significant hardware challenge for some platforms such as trapped ions~@Wang2017. However, the necessity of parallel operations has long been believed necessary for any QEC scheme to exhibit a non-zero threshold~@steane1998 @gottesman2010. We therefore require that physical operations can be applied in parallel.


Next we consider connectivity. Probably the most practically relevant classes of connectivity correspond to arrays of qubits with neighboring connections in one or two dimensions, which we refer to as #emph[1D] and #emph[2D connectivity] respectively. For connectivity with any fixed dimension, the thresholds of many of the more exotic code families are believed to drop to zero~@Bravyi2010 @delfosse2021. With 2D connectivity the thresholds of some QEC schemes based on concatenating small codes are reduced~@svore2005. Fortunately, many 2D local codes (including the surface code~@Wang2011, the Hastings-Haah code~@Paetznick2022 and the color code~@beverland2016) are naturally implementable with 2D connectivity and achieve high thresholds approaching 1\% in this setting despite the connectivity restrictions. Further restricting to 1D connectivity leaves very few code families known to have finite thresholds, and those that do are around 0.01\% and below~@jones2018 @szkopek2006 @stephens2009. Moreover, 1D connectivity is vulnerable to hardware defects that some qubits permanently unusable. To avoid such potentially fatal conditions, we require that qubits are well connected, for example with 2D connectivity but not 1D connectivity.


There are a number of important subtleties that we have ignored so far. First, the simple uniform discrete error model is not a true refection of most systems. Including some realistic aspects of noise, such as asymmetries in the probabilities of different error channels~@Brown2020 @Chamberland2022a and richer information from noisy measurements~@pattison2021 can improve error correction performance. On the other hand, including other realistic aspects, such as correlated errors~@klesse2005 and permanent hardware defects which must be worked around to implement QEC~@strikis2021 @Stace2009 can worsen error correction performance. To partially allow for these subtleties, we require that the #emph[worst] error rates for Clifford operations that are employed by the QEC approach are below 0.1\%. Next, we have required the qubits are #emph[well connected] to enable practical QEC, and make it clear that 2D connectivity falls into this class, while 1D connectivity does not. However, we leave the formulation of a more complete definition which applies to more general connectives to future work.


In summary, we require physical qubits to be well connected such as having 2D connectivity, with the ability to perform parallel operations with error rates below one part in a thousand. This holds for all examples we consider in this paper, and forms the basis of one of our criteria for scale.


= ESTIMATING RESOURCES FOR THREE QUANTUM APPLICATIONS
<sec-examples>


In this section we introduce an implementation of the quantum resource modeling framework, hereafter referred to as 'the tool', which is publicly available in Microsoft Azure Quantum as the first version of the Azure Quantum Resource Estimator~@toolLink. Our primary goal in this work is to identify architecture features which will be crucial to achieve practical quantum computing advantage. To do so, we estimate the resources for select applications with the potential for practical quantum advantage (@sec-application-examples), using qubit parameters which are relevant for a number of prominent qubit technologies. We fix a set of consistent architectural options for the quantum stack based on established approaches from the literature.


Following our framework, estimates obtained using the tool can be viewed as consisting of two broad components as shown in @fig-quantum-resource-estimator. The first component (@sec-algorithms-and-software) involves an explicit front end compilation from a high-level language to a quantum IR, which is fed to the tool. The tool then models the back end compilation down to a quantum ISA, yielding ISA-level resource estimates including the number of logical qubits and the number of logical time steps. In the second component (@sec-hardware-and-QEC), specific qubit parameters are fed to the tool which performs a bottom-up estimation of the hardware resources required to implement ISA instructions by modeling error correction with specific QEC codes. In @sec-putting-pieces-together we combine these components to obtain concrete resource estimates.


In the appendices we provide a more detailed and self-contained description of the material in this section, including our modeling assumptions. Our examples are available as samples at @samplesLink.


// [figvision-cn] imgs/Quantum_Resource_Estimator.png
// 该图像为一幅流程图，标题为“Quantum Resource Estimator”
// （量子资源估算器），展示了从应用程序到资源估算的完整处
// 理流程。整体布局从左至右分为输入、处理和输出三个主要阶
// 段，通过箭头指示数据流向。 左侧部分标注为“application
// examples”（应用示例）。顶部并列展示三个黄色卷轴状图标，
// 分别标记为“quantum dynamics”（量子动力学）、“quantum
// chemistry”（量子化学）和“factoring”（因数分解）。这三
// 个图标下方是一个指向右侧的绿色宽箭头，标记为“INPUT”（
// 输入）。箭头指向一个矩形框，内部描绘了一个抽象的量子电
// 路示意图，包含三条水平紫色线条代表量子比特线，线上分布
// 有橙色矩形门和蓝色圆形节点。该矩形框下方标注文字为“QIR
// program”。在“QIR program”右侧是另一个绿色箭头，标记为“
// compilation models”（编译模型），指向中央的处理区域。
// 中央区域被虚线框包围，核心标题为“Quantum Resource
// Estimator”。该区域内包含两个主要组件。左侧是一个复杂的
// 网格状结构，由多个垂直排列的蓝色圆柱体和连接它们的黄色
// 横线组成，下方标注为“planar quantum ISA executable”（
// 平面量子指令集架构可执行文件）。右侧是一个名为“
// ISA-level calculations”（指令集架构级计算）的白色方框。
// 在该方框右侧，有一个图示表示“planar quantum ISA
// instruction set”（平面量子指令集架构指令集），其中包含
// 两个紫色填充的矩形块和一个带有字母“T”的黄色小方块。 右
// 侧部分标注为“qubit parameter examples”（量子比特参数示
// 例）。顶部是一个2行3列的表格，共六个蓝色圆角矩形，内部
// 分别写有不同的参数组合：第一行为“(μs, 10^-4)”、“(ns,
// 10^-4)”、“(ns, 10^-4)*”；第二行为“(μs, 10^-3)”、“(ns,
// 10^-3)”、“(ns, 10^-6)*”。表格下方是一个指向左侧的绿色
// 宽箭头，标记为“INPUT”。箭头指向一个矩形框，内部描绘了
// 物理量子比特的布局示意图，背景为黑色点阵，上面分布着绿
// 色、橙色和黄色的几何形状（如圆形、D形等）。该矩形框下
// 方标注文字为“physical qubit instruction set”。在“
// physical qubit instruction set”左侧是另一个绿色箭头，
// 标记为“QEC models”（量子纠错模型），指向中央的处理区域。
// 底部输出部分位于中央区域的正下方。一个绿色宽箭头从“
// ISA-level calculations”向下指出，标记为“OUTPUT”。箭头
// 指向底部的一个椭圆形框，内部文字为“resource estimates
// (# qubits, time etc.)”，意为资源估算（量子比特数量、时
// 间等）。
#figure(image("imgs/Quantum_Resource_Estimator.png", width: 100.0%),
  caption: [
    A sketch of how the tool estimates resources for the three example applications and six qubit parameter examples we consider. Note the stack is represented left-to-right rather than top-to-bottom. Applications, addressed by a high-level quantum program, are first translated explicitly to a QIR program which is input into the tool, where its compilation down to an ISA-level executable is modeled. All our examples flow to the same planar quantum ISA, which has an instruction set consisting of logical surface code operations. On the hardware side, we input physical qubit parameters to the tool including the physical qubit instruction set and the times and error rates of those instructions. The tool then models how these noisy qubits are used to build up protected logical qubits and to fault-tolerantly implement the planar quantum ISA instructions using configurable QEC models. The tool outputs resource estimates such as the number of physical qubits and time required to run the application.
  ]
)
<fig-quantum-resource-estimator>



== Quantum applications
<sec-application-examples>


The first of our three example applications is a #emph[quantum dynamics] simulation that is one of the smallest scientifically interesting problems that is out of reach for classical computation. Specifically, we consider a 2D transverse-field Ising model with 100 quantum spins, propagated for ten time steps using a fourth-order Trotter algorithm as described in Ref.~@Pearson2020. This is among the simplest models to exhibit a quantum phase transition. Its dynamics are representative of strongly entangled quantum systems and as such is believed to be classically intractable~@bauer2020quantum.


Our second example is a #emph[quantum chemistry] application to calculate the energy of a ruthenium-based catalyst for carbon fixation which could have implications for reversing the effects of global warming. More specifically, to estimate the energy of Complex~XVIII in Ref.~@vonBurg2021 to chemical accuracy of 1~mHa using the so-called 'double-factorized qubitization' algorithm described in Ref.~@vonBurg2021.


Our third application is #emph[factoring], specifically to identify the pair of prime factors of a $2048$-bit integer. Solving this problem would form the basis of an attack on widely used RSA-based encryption schemes. In our resource estimation model, we use a high-level program to implement Shor's factoring algorithm based on that described in Ref.~@Gidney2021.


To achieve the desired solution accuracy for each application, we also set a minimum probability that the overall algorithm succeeds, which we call the #emph[algorithm execution accuracy]. For the quantum dynamics and quantum chemistry examples we assume that algorithm execution accuracies of $0.999$ and $0.99$ will be required. However factoring admits a lower algorithm execution accuracy since it is easy to check if a proposed solution is correct (by multiplying the purported prime factors to identify if they recover the original integer), and so we take it to be $2 / 3$ in this case.


== Requirements at the quantum ISA level
<sec-algorithms-and-software>


Here we describe how we obtain ISA-level resource estimates needed to target our three example applications. To identify the physical-level costs of implementing an ISA-level executable, we will not only need to know parameters capturing the size of the program, but also the required quality of the ISA operations needed to achieve the desired algorithm execution accuracy. This is because different quality requirements will result in different error correction solutions being preferred.


As a starting point, we assume explicit high-level implementations of the quantum-accelerated components of each of the three target applications, using Rust for quantum chemistry and factoring and Q\# for quantum dynamics#footnote[These implementations are available as samples at @samplesLink]. First we use an explicit front end compilation to a specific quantum IR, namely QIR~@qir using the Q\# compiler or the Rust compiler based on the application. The tool then models the back end stage of compilation which translates QIR into operations supported by the quantum ISA.


In this work we use the #emph[planar quantum ISA], which is based on the logical operations of the most well-established QEC code, namely the surface code~@Kitaev2003 @Bravyi1998, and also applies to the recently developed Hastings-Haah codes~@Hastings2021 @Paetznick2022. Logical qubits are stored in patches laid out in a 2D plane, along with ancilla regions. We sketch some key features of the planar quantum ISA instructions in @fig-quantum-resource-estimator, and provide a full specification in @fig-logical-operations in @app-logical-operations-details. Only Clifford operations involving patches (purple) that are connected by ancilla regions (grey) are permitted, and two such operations can only be performed simultaneously only if the ancilla regions they require are disjoint. Non-Clifford T states are produced in dedicated T factories (yellow).


There are two primary conceptual challenges that need to be overcome to implement the back end compilation phase. Firstly, the QIR instruction set contains fine-angle rotation unitaries, which must be approximated with sufficient accuracy by sequences of operations from the planar quantum ISA, a process known as #emph[synthesis]. Secondly, one requires methods to layout qubits and perform communication in order to map from the QIR, which has no connectivity restrictions, to the planar quantum ISA, which has geometric constraints. Standard layout and communication methods can be applied to address this second aspect of compilation, including SWAP-based schemes where qubits are moved by swapping neighbors, as well as teleportation-based schemes where qubits are moved using quantum teleportation. In @app-cat-state, we provide an alternative back end compilation scheme which we refer to as Parallel Synthesis Sequential Pauli Computation (PSSPC), which is based on a combination of favorable features from existing approaches~@Litinski2019 @Chamberland2021 @Beverland2022 @Kliuchnikov2022. The tool first takes a trace of the QIR program and then uses accurate formulas to calculate the planar quantum ISA resource requirements that would result from back end compiling with PSSPC.


@tab-application-examples presents the ISA-level resource requirements of our three example applications, which are seen to vary significantly across the applications. Our quantum dynamics example, selected as being among the smallest applications of scientific interest, requires only 200 logical qubits after mapping to the planar quantum ISA. However, even this application requires logical qubits with error rates that are below $10^(- 11)$, which puts it beyond the capabilities of current noisy quantum hardware. Applications like chemistry and factoring require several thousand logical qubits, with each logical qubit having error rates in the range of $10^(- 15)$ to $10^(- 18)$ and T states with error rates in the range of $10^(- 12)$ to $10^(- 15)$. These applications require mature QEC implementations and large-scale, reliable quantum hardware which we discuss in the next subsection.


#figure(
  table(
    columns: 7,
    align: center,
    table.cell(rowspan: 2)[application], [algorithm execution], table.cell(align: center, colspan: 3)[quantum executable parameters], table.cell(align: center, colspan: 2)[quality requirements],
    [accuracy $1 - epsilon.alt$], [$Q$], [$C_(upright("min"))$], [$M$], [max $P$], [max $P_T$],
    [quantum dynamics], [$0.999$], [230], [$1.5 dot.op 10^5$], [$2.4 dot.op 10^6$], [$9.7 dot.op 10^(- 12)$], [$1.4 dot.op 10^(- 10)$],
    [quantum chemistry], [$0.99$], [2740], [$4.1 dot.op 10^11$], [$5.4 dot.op 10^11$], [$3.0 dot.op 10^(- 17)$], [$6.1 dot.op 10^(- 15)$],
    [factoring], [$0.667$], [$25481$], [$1.2 dot.op 10^10$], [$1.5 dot.op 10^10$], [$3.5 dot.op 10^(- 16)$], [$7.4 dot.op 10^(- 12)$],
  ),
  caption: [Estimates of the ISA-level requirements to implement our applications. The application is compiled down from a high-level application program to a program expressed in the quantum ISA, with parameters as shown. These requirements include the number of logical qubits $Q$, the minimum number of logical time steps (also called logical time steps) $C_(upright("min"))$ and the number of T states $M$ consumed by the program. To ensure that the algorithm fails with probability at most $epsilon.alt$, the tool also estimates the maximum allowed error rate for each logical qubit $P$ and the maximum allowed error rate for the distilled T states $P_T$.],
)
<tab-application-examples>


== Requirements at the device level
<sec-hardware-and-QEC>


To understand the high-level impact of physical qubit parameters on application resource estimates, we configure the tool to model the underlying qubit technology relatively abstractly in terms of operation times and error rates, and consider parameter configurations which are relevant for a range of prominent hardware approaches. These features are captured at the microarchitecture level of the quantum stack. Along with the operation time and error rate, the tool takes as input one of two physical operation sets: #emph[gate-based instructions] (including CNOTs and single-qubit measurements) relevant for technologies such as superconducting qubits, trapped ion qubits etc., and #emph[Majorana instructions] (including non-destructive two-qubit Pauli measurements) which are relevant for Majorana qubits~@Karzig2017 @Plugge2016. Both of these instruction sets have 2D connectivity and allow the parallel application of disjoint operations.


#figure(
  table(
    columns: 5,
    align: center,
    [#strong[qubit parameter]], table.cell(align: center, colspan: 2)[operation times], table.cell(align: center, colspan: 2)[error rates],
    [#strong[examples]], [gate], [measurement], [Clifford], [non-Clifford],
    [#strong[$(upright(mu)"s", 10^(-3))$ qubit]], [100 $mu$s], [100 $mu$s], [$10^(- 3)$], [$10^(- 6)$],
    [#strong[$(upright(mu)"s", 10^(-4))$ qubit]], [100 $mu$s], [100 $mu$s], [$10^(- 4)$], [$10^(- 6)$],
    [#strong[$("ns", 10^(-3))$ qubit]], [50 ns], [100 ns], [$10^(- 3)$], [$10^(- 3)$],
    [#strong[$("ns", 10^(-4))$ qubit]], [50 ns], [100 ns], [$10^(- 4)$], [$10^(- 4)$],
    [#strong[$("ns", 10^(-4))$ Majorana qubit]], [100 ns], [100 ns], [$10^(- 4)$], [0.05],
    [#strong[$("ns", 10^(-6))$ Majorana qubit]], [100 ns], [100 ns], [$10^(- 6)$], [0.01],
  ),
  caption: [We consider a set of examples of qubit parameters which represent various regimes of interest. Each example is labelled with the units of its operation times (either $mu$s or ns), and the limiting error rate of its Clifford operations. The parameter values and instruction set chosen for each example is informed by published proposals for various hardware approaches. We assume that the first four examples have gate-based instruction sets, while the last two examples have Majorana instruction sets.],
)
<tab-qubit-type>


As listed in @tab-qubit-type, we consider six qubit parameter examples, each labelled with the unit of its operation time and error rate. In @fig-quantum-resource-estimator, we use an asterisk to differentiate the two examples which use Majorana-based instructions rather than gate-based instructions. With operation times in the microsecond range, the ($mu$s,~$10^(- 3)$) and the ($mu$s,~$10^(- 4)$) qubits are relevant for trapped ions~@Cirac1995, while the (ns,~$10^(- 3)$) and (ns,~$10^(- 4)$) qubits are more relevant for superconducting transmon qubits~@transmonSchoelkopf or spin qubits~@kane1998. We also include the (ns,~$10^(- 4)$) and (ns,~$10^(- 6)$) Majorana qubit examples, to account for future topological qubits based on Majorana zero modes~@Karzig2017. These latter qubits are also expected to have operations in the nanosecond regime, and owing to topological protection in the hardware, they also have the potential for higher fidelities at the physical level. In @app-noise we provide more explanation of these qubit parameter examples and provide the full specifications of the aforementioned instruction sets in @fig-physical-operations.


In this work, we assume that logical qubits are encoded in patches (purple in the ISA instructions of @fig-quantum-resource-estimator) of either the surface code~@Kitaev2003 @Bravyi1998 or the recently discovered Hastings-Haah code~@Hastings2021. We make this restriction primarily because these codes have high fault-tolerance thresholds, have relatively well-understood logical operations, and can be implemented using physical qubits with 2D connectivity. We model QEC to relate properties at the ISA (logical) level to properties at the microarchitecture (physical) level. For both the surface code and Hastings-Haah code, error suppression can be tuned by scaling the patch's code distance $d$. For fixed qubit parameters, increasing the distance costs quadratically more physical qubits $n ( d )$ and has a linearly longer logical time step $tau ( d )$, but reduces the probability $P ( d )$ of a logical qubit failing during a logical time step exponentially. A number of fault-tolerant logical Clifford operations have essentially no time cost in these codes, including state initialization, readout and Pauli gates. On the other hand, logical qubit movement and multi-qubit Pauli measurements are implemented via lattice surgery with the use of ancilla regions (grey in @fig-quantum-resource-estimator) and require a logical time step. For counting resources, it is convenient to partition the physical qubits into tiles, where each tile contains $n ( d )$ physical qubits, and can either be used to encode a logical qubit in a code patch, or can form part of an ancilla region. The total number of physical qubits used for code patches and ancilla regions is then $Q dot.op n ( d )$, where $Q$ is the number of tiles (which we also refer to as the number of logical qubits). See @app-logical-operations-details for details.


For the ISA-level instruction set to be universal, we also require non-Clifford operations, such as a logical T gate. This is achieved via the generation of T states (also known as magic states) using T factories (yellow in @fig-quantum-resource-estimator), which typically requires many more resources than other quantum ISA operations. These T factories typically involve a sequence of rounds of distillation, where each round takes in many noisy T states encoded in a smaller distance code, processes them using a distillation unit, and outputs fewer less noisy T states encoded in a larger distance code, with the number of rounds, distillation units, and distances all being parameters which can be varied. There are therefore many options when selecting a T factory. We use the symbol $cal(D)$ to label a particular T factory choice which requires $n ( cal(D) )$ physical qubits, and takes a time $tau ( cal(D) )$ to produce a T state with error rate $P_T ( cal(D) )$. We assume T factories that are space and time efficient implementations of the well-known 15-to-1 distillation circuit; see @app-distillation-overhead for details.


For each application, the code distance $d$ and T factory $cal(D)$ must be chosen to ensure that the ISA requirements from @tab-application-examples are satisfied, namely that $P ( d ) lt.eq upright("max") med P$ and $P_T ( cal(D) ) lt.eq upright("max") med P_T$, but with minimal cost. As an example, @tab-hardware-examples shows the resource costs to satisfy the ISA-level requirements for the factoring application across different physical qubit parameters. We can see that the number of physical qubits and the duration of a logical time step reduce as physical error rates improve. For this example application, improving physical error rates from $10^(- 3)$ to $10^(- 4)$ can reduce the number of qubits by a factor of four, and can halve the logical time step. Comparing qubits with microsecond and nanosecond operating times, we see the impact of physical operation time at the ISA level --- logical time steps are several orders of magnitude higher than physical operating times, underscoring the importance of fast physical operations. T factories incur significant physical overheads, requiring several thousand physical qubits and only producing new T states once every 10 to 15 logical time steps, motivating the need for multiple parallel T factories to meet application T state demand.


#figure(
  table(
    columns: 7,
    align: center,
    [], [], table.cell(align: center, colspan: 3)[logical qubit parameters], table.cell(align: center, colspan: 2)[T factory parameters],
    [qubit parameter], [QEC code], table.cell(align: center, colspan: 3)[for $P ( d ) lt.eq 3.5 dot.op 10^(- 16)$], table.cell(align: center, colspan: 2)[for $P_T ( cal(D) ) lt.eq 7.4 dot.op 10^(- 12)$],
    [examples], [selected], [distance], [\# qubits], [logical time step], [\# qubits], [duration],
    [], [], [$d$], [$n ( d )$], [$tau ( d )$], [$n ( cal(D) )$], [$tau ( cal(D) )$],
    [\($mu$s,~$10^(- 3)$) qubit], [surface], [27], [1458], [16 ms], [17640], [163 ms],
    [\($mu$s,~$10^(- 4)$) qubit], [surface], [13], [338], [7 ms], [4840], [85 ms],
    [\(ns,~$10^(- 3)$) qubit], [surface], [27], [1458], [10 $mu$s], [33320], [128 $mu$s],
    [\(ns,~$10^(- 4)$) qubit], [surface], [13], [338], [5 $mu$s], [5760], [72 $mu$s],
    [\(ns,~$10^(- 4)$) Majorana qubit], [Hastings-Haah], [15], [1012], [4 $mu$s], [21840], [52 $mu$s],
    [\(ns,~$10^(- 6)$) Majorana qubit], [Hastings-Haah], [7], [244], [2 $mu$s], [16416], [23 $mu$s],
  ),
  caption: [Physical resources required to implement a single logical qubit and to produce a single T state with a T factory for factoring across the qubit parameter examples specified in @tab-qubit-type. For the logical qubit we also show which QEC code was selected and the corresponding code distance.],
)
<tab-hardware-examples>


== Combining the requirements into application resource estimates
<sec-putting-pieces-together>


We now outline how the tool combines the aspects described in @sec-algorithms-and-software and @sec-hardware-and-QEC to estimate thew physical resources required our three application examples with our six qubit parameter examples. According to @sec-algorithms-and-software, the tool provides detailed estimates of the ISA-level executable, including the number of logical qubits, the minimum number of logical time steps, and also number of logical T states required. The tool also estimates the maximum logical error rates for logical qubits and logical T states that achieve the required algorithm execution accuracy.


Then, according to @sec-hardware-and-QEC, the tool selects the QEC code and code distance for logical qubits and the T factory configuration which have the smallest physical space-time footprints while achieving the required logical error rate and logical T state error rate respectively. This choice depends on the physical qubit parameters, and sets the number of physical qubits per logical qubit and per T factory, and also the duration of a logical time step and the T factory. Next, the tool selects the number of T factories to balance the rate of production of T states against the rate of T state consumption demanded by the algorithm#footnote[In some cases, the number of T factories required to meet demand may be very large, prompting the exploration of a trade-off by slowing down the algorithm allowing for a reduced number of T factories and lower qubit count.]. Finally, the tool computes the total number of physical qubits as the sum of physical qubits required to implement all logical qubits and all T factories. It computes the overall computation time using the number of logical time steps, and the duration of a single logical time step.


// [figvision-cn] imgs/resourceEstimationChart.png
// 这是一张二维对数-对数坐标图，展示了实现三种量子应用所
// 需的物理量子比特数量（纵轴）与运行时间（横轴）之间的关
// 系。 子图类型： 曲线图（散点连线形成的区域图）。 坐标
// 轴信息： 横轴（X轴）：名称为“run time (seconds)”，单位
// 为秒。刻度采用对数标度，范围从1E-01到1E+10。主刻度标记
// 包括：1E-01, 1E+00, 1E+01, 1E+02, 1E+03, 1E+04, 1E+05,
// 1E+06, 1E+07, 1E+08, 1E+09, 1E+10。在主刻度下方标注了
// 时间单位参考标签：“second”（对应1E+00）、“minute”（对
// 应1E+02）、“hour”（对应1E+04）、“day”（对应1E+05）、“
// week”（对应1E+06）、“month”（对应1E+07）、“year”（对应
// 1E+08）、“decade”（对应1E+09）、“century”（对应1E+10）。
// 纵轴（Y轴）：名称为“physical qubits (millions)”，单位
// 为百万个物理量子比特。刻度采用对数标度，范围从0.01到
// 100.00。主刻度标记包括：0.01, 0.10, 1.00, 10.00,
// 100.00。 数据系列与区域描述： 图中包含四个由不同形状符
// 号连接的闭合多边形区域，代表不同的应用场景或配置。 浅
// 绿色区域（上方）： 标签文字：“quantum dynamics”。 位置：
// 位于图表左侧中部。 顶点坐标近似值（运行时间, 物理量子
// 比特数）：(0.1, 0.6), (1, 8), (1000, 3), (10, 0.5)。
// 该区域表示在标准配置下实现量子动力学应用所需的资源范围。
// 深绿色区域（下方）： 标签文字：“quantum dynamics (
// reduced T factories)”。 位置：位于浅绿色区域正下方。
// 顶点坐标近似值（运行时间, 物理量子比特数）：(0.1, 0.1)
// , (1, 0.1), (1000, 0.4), (10, 0.1)。 该区域表示通过减
// 少T工厂数量来降低硬件需求，但导致运行时间延长的量子动
// 力学应用配置。 浅蓝色区域： 标签文字：“factoring”。 位
// 置：位于图表右上部。 顶点坐标近似值（运行时间, 物理量
// 子比特数）：(10000, 6), (100000, 40), (100000000, 40),
// (10000000, 10)。 该区域表示实现大数分解应用所需的资源
// 范围。 浅红色区域： 标签文字：“quantum chemistry”。 位
// 置：位于浅蓝色区域下方。 顶点坐标近似值（运行时间, 物
// 理量子比特数）：(1000000, 1.5), (10000000, 7), (
// 10000000000, 7), (100000000, 2)。 该区域表示实现量子化
// 学模拟应用所需的资源范围。 图例说明： 图例位于右下角，
// 解释了构成上述区域边界的四种不同符号的含义，这些符号代
// 表了不同的量子比特参数示例（具体参数见原文表1或相关部
// 分）： 实心黑圆点 (●)：对应参数 (μs, 10⁻³)。 空心白圆
// 圈 (○)：对应参数 (μs, 10⁻⁴)。 实心黑方块 (■)：对应参数
// (ns, 10⁻³)。 空心白方块 (□)：对应参数 (ns, 10⁻⁴)。 实
// 心黑三角 (▲)：对应参数 (ns, 10⁻⁶) Majorana。 空心白三
// 角 (△)：对应参数 (ns, 10⁻⁸) Majorana。 注：Majorana指
// 马约拉纳费米子量子比特。 趋势与结论： 该图展示了实现不
// 同量子应用时，物理量子比特数量与运行时间之间的权衡关系。
// 一般来说，对于同一应用，减少所需的物理量子比特数量（向
// Y轴下方移动）会导致运行时间显著增加（向X轴右侧移动）。
// 例如，“quantum dynamics (reduced T factories)”区域相比
// 标准的“quantum dynamics”区域，其物理量子比特需求降低了
// 约一个数量级，但运行时间相应延长。此外，不同的应用对资
// 源的需求差异巨大，从需要约0.1百万个量子比特的简化量子
// 动力学模拟，到需要数十百万个量子比特的大数分解任务。
#figure(image("imgs/resourceEstimationChart.png", width: 100.0%),
  caption: [
    Estimates of the resources required to implement three applications, assuming the qubit parameter examples specified in @tab-qubit-type. We explore a trade-off in the quantum dynamics application by considering two implementations: one which uses sufficient T factories to supply the needs of the shortest-depth algorithm and another which slows the algorithm down, allowing for a reduced number of T factories.
  ]
)
<fig-resources-chart>



As can be seen in @fig-resources-chart, qubit counts and runtimes vary by orders of magnitude based on the physical qubit parameters for all three applications. Even the smallest practical applications such as quantum dynamics involve devices with more than 100K physical qubits and applications in chemistry and factoring require upwards of 1M qubits. Unsurprisingly, the three orders of magnitude longer operation time for the ($mu$s,~$10^(- 3)$) and ($mu$s,~$10^(- 4)$) qubit models compared with the other models results in about three orders of magnitude longer application run times. For quantum chemistry, this leads to impractical runtimes of more than a century.


To build the tool and obtain these estimates we have made many choices including what algorithmic, compilation and QEC options to include and also what approximations and assumptions to make. Other resource estimation works have made different choices, which leads to small differences in estimates~@Gidney2021. In the appendices, we point out more explicitly these choices, assumptions and approximations, and in particular, collect together our primary assumptions in @app-primary-assumptions. We anticipate that future work will extend and improve the tool and framework in two ways. Firstly, the estimates for a given stack will become more accurate as assumptions and approximations are honed and made more realistic, for example by including more detailed and nuanced noise models. Secondly, the estimates will become more favorable as improved solutions and optimizations are included in the stack and resource models, such as algorithmic improvements and hand-optimized compilation of important subroutines. We expect the broad conclusions that we draw from these results in the next section to hold true despite these choices, approximations and assumptions. This is because our conclusions are relatively insensitive to order of magnitude changes in resource estimates.


= TECHNOLOGICAL IMPLICATIONS AND CONCLUSIONS
<sec-conclusions>


More than two decades ago, DiVincenzo~@Divincenzo2000 specified a set of fundamental requirements that any usable quantum computer should satisfy. For example, DiVincenzo identified the necessity of low error rates, by requiring #emph[long relevant decoherence times, much longer than the gate operation time]. Since then, a variety of qubit technologies that satisfy DiVincenzo's criteria have been developed, including technologies such as superconducting and trapped ion qubits. However, it is an open question as to what additional conditions beyond DiVincenzo's criteria a qubit technology must satisfy to scale to practical quantum advantage, and whether or not current technologies are on the path to do so.


Our work sheds light on this question, by estimating and analyzing the resources needed for quantum applications with practical value implemented on fault-tolerant architecture designs assuming a variety of underlying qubit technologies. Our analysis rests on several assumptions including qubit technology trends, QEC schemes, instruction sets, and choices across other parts of the stack. We have attempted to reflect the community's current best understanding of the quantum stack and its future evolution in these assumptions. Our resource estimates indicate that while scaling requirements to achieve the first scientifically interesting demonstrations of quantum advantage are not too stringent, scaling to commercially valuable applications, such as those using computational catalysis in chemistry, presents significant challenges. We deduce based on the results that to overcome these challenges and achieve scale, a qubit technology will need to be:


#strong[Controllable.---] While most quantum hardware is controllable at small qubit counts, scaling qubit control to millions of fast and reliable qubit operations without introducing new noise channels is important. Controllability is at the core of scaling up, and has implications on several aspects of the physical qubit device, including its connectivity, error rates, operation speed and size.


Regarding connectivity, it has been shown that 2D connectivity is sufficient to implement fault-tolerant quantum error correction and build logical qubits~@Fowler2012 @Paetznick2022 @svore2005, however such an array may present challenges for control and readout wiring. In contrast, while 1D connectivity is simpler for control wiring, it requires prohibitively low error rates @jones2018 and seems unlikely to be viable with fabrication defects which permanently eliminates some qubits and operations. All-to-all connectivity is challenging to realize in many architectures, and may not be practically beneficial for large-scale implementations unless QEC schemes with good fault tolerant logical operations are developed to take advantage of such properties.


At the heart of fault-tolerant QEC is the requirement that the error rate of each physical operation (including qubit preparations, measurements, and gates) is below a threshold value. With no connectivity restrictions, the highest known threshold~@knill2005 is 3\%, and 1\% can be achieved with 2D connectivity~@Fowler2012 @Paetznick2022. The qubit overhead of QEC goes down significantly as error rates are reduced further below this threshold value; however the overheads may still be prohibitive if error rates are not an order of magnitude better, say below around 0.1\%. Even so, error rates have to be well below threshold while allowing for #emph[parallel] operations at a scale of #emph[millions of qubits].


Controllability means being able both to control those millions of parallel operations with the desired error rates, and to readout out those millions of qubits in parallel to enable decoding of the errors at speed; all while ensuring the overarching logical clock time is fast enough to complete the computation within a month runtime or less.


To execute syndrome measurements on these qubits and communicate the quantum measurements to the decoder, we require large quantum-classical bandwidth and processing power for decoding. The exact estimates of bandwidth requirements depend on the choice of QEC code, system size and physical operation times, but roughly, for system with a few million qubits, we estimate that several terabytes per second of bandwidth will be required beteween the quantum and classical plane. Furthermore, processing these measurements at a rate that is sufficient to effectively correct errors demands petascale classical computing resources that are tightly integrated with the quantum machine.


#strong[Fast.---] The run times identified in our study help determine the desired speed of physical operations for a given quantum architecture to be practical. We find that logical gate times under 10 $mu$s, in turn requiring physical gate times around 100 ns, would be needed to complete the quantum chemistry algorithm within a month, using a few million physical qubits. While these gate times are realistic for solid state or photonic qubits @bombin2021a, this is several orders of magnitude faster than current proposals for large ion trap or neutral atom-based devices @blueprintTrappedIon @Saffman_2016. For some algorithms, it may be possible to compensate for slower qubit speeds by using parallelization techniques, most likely resulting in increasing the required number of physical qubits.


#strong[Small.---] Bringing together a million and more physical qubits along with their control and readout systems presents another challenge: the size of the quantum computer. We foresee a monolithic, single-wafer approach as desirable and estimate that a linear extent of a micron or more is needed for wiring, defining a 'sweet spot' for the size of a qubit of around 10 microns~@Franke2019.


To understand this sweet spot, consider estimating the approximate footprint of the quantum plane by multiplying the number of physical qubits by the size of a physical qubit, including control electronics. While precise estimates on the size of leading qubit platforms are not available in the literature, we estimate that a system with 10M superconducting transmon qubits would require an area of $tilde 10$ square meters based on current designs~@arute2019. At such scale, a dilution refrigerator that provides the operating environment for the qubit plane will no longer be able to accommodate a monolithic quantum module. While modular quantum architectures that span multiple dilution refrigerators have been proposed @Bravyi2022, the reliability of the components, such as high bandwidth interconnects and low latency coherent quantum networks with associated distributed fault-tolerance schemes, and the ability to scale up while maintaining low error rates is not yet known. In contrast, the pursuit of a monolithic architecture in which ten million physical qubits must fit onto a single wafer suggests that shrinking the qubit to a linear extent of less than 100 microns would be needed. This presents another set of challenges, including not making the qubit too small. If qubits are too tightly packed, then scalable control and readout of arrays of qubits will become hard.


While no qubit technology currently implemented satisfies all of these requirements, two architecture proposals, while not yet implemented, appear to satisfy the requirements from a design perspective. These include recent proposals of electro-acoustic qubits @Guillaud2019 @Chamberland2022a, and the topological qubit approach based on Majorana Zero Modes @Karzig2017. Understanding these requirements on the path to scaling up, for these and other existing technologies, illuminates the opportunities and advancements needed to achieve practical quantum advantage. It will be through studying the tradeoffs across the stack, from the algorithm to the qubit device, and then verifying them in implemnetation, that we will accelerate the development of scalable quantum computers. Both the framework and Azure Resource Estimator tool pave the way for the community to better understand the path to scaling up, the dependencies across the stack on the ultimate qubit numbers and runtimes, and the opportunities to bring down the costs at every layer.


Practical quantum advantage is on the horizon; it may be accelerated through breakthrough techniques, including improved quantum error correction protocols, faster and more accurate decoders enabling improvements in the thresholds, richer logical operations and logical connectivity, improved algorithm compilation and optimization, and the discovery of low-cost, useful quantum algorithms with the promise of advantage. These research directions, and more, can be studied in the context of resource estimation, and just may be key to unlocking quantum at scale.


= ACKNOWLEDGEMENTS <acknowledgements>
We thank Bela Bauer, Nicolas Delfosse, Alan Geller, Jeongwan Haah, Thomas Häner, Matthew Hastings, Christina Knapp, Chetan Nayak, Adam Paetznick and Marcus da Silva for discussions.


= APPENDICES <appendices>

// Appendix sections are lettered (A, B, ...) and referenced as "Appendix A".
#set heading(numbering: "A", supplement: [Appendix])
#counter(heading).update(0)
In these appendices, we provide a self-contained, more detailed description of how the resource estimates presented in @sec-examples of the main text are obtained. Since these estimates are calculated using the first release version of the Azure Quantum Resource Estimator, hereafter called 'the tool', these appendices also serve to specify the choices, assumptions and approximations of the tool.


@fig-examples summarizes the set of examples and major options that form the stacks that we model to estimate resources, and @tab-physical-and-logical-overhead collects together the input, output, and intermediate data used to calculate the estimates for each application example using each qubit parameter example, which are used to produce @fig-resources-chart in the main text. The appendices methodically address each aspect of this estimation calculation.


// [figvision-cn] imgs/examples.png
// 该图是一幅展示量子计算资源估算中“量子堆栈”（quantum
// stack）架构的垂直分层流程图。图中元素自上而下排列，通
// 过箭头表示数据流向或编译层级关系。右侧使用大括号对每一
// 层进行归类标注，左侧标注了各层之间的转换过程名称。 顶
// 部并列三个应用示例模块： 最左侧为“quantum dynamics”，
// 下方连接一个浅黄色矩形框，内文为“Trotter algorithm in
// Q#”。 中间为“quantum chemistry”，下方连接一个浅黄色矩
// 形框，内文为“qubitization algorithm in Rust”。 最右侧
// 为“factoring”，下方连接一个浅黄色矩形框，内文为“Shor’s
// algorithm in Rust”。 这三个模块右侧由一个大括号统一标
// 注为“application example”。 从上述三个算法模块分别引出
// 黑色实线箭头，汇聚指向下方一个居中的浅黄色矩形框，内文
// 为“LLVM quantum IR program”。该框右侧由大括号标注为“
// high-level quantum language”和“quantum IR”两层（注：根
// 据布局，“high-level quantum language”对应上方三个算法
// 框，“quantum IR”对应此LLVM框）。 从“LLVM quantum IR
// program”框向下引出一条黑色实线箭头，指向下一个浅黄色矩
// 形框，内文为“quantum executable”。该框右侧由大括号标注
// 为“quantum ISA (logical)”。 在“quantum executable”与下
// 一层之间有一条横向虚线，将逻辑层与物理层分隔开。 虚线
// 下方是微码层（microcode），包含两个并列的蓝色圆角矩形
// 框： 左侧框内文为“surface code QEC”。 右侧框内文为“
// Hastings-Haah code QEC”。 这两个框共同被右侧大括号标注
// 为“microcode (QEC)”。其中，“surface code QEC”接收来自
// 上方“planar quantum ISA”（位于“quantum executable”正下
// 方、虚线之下，是一个较小的蓝色圆角矩形框）的输入箭头；
// 同时，“Hastings-Haah code QEC”也接收来自同一“planar
// quantum ISA”的输入箭头（图中显示两条独立箭头分别从“
// planar quantum ISA”指向两个QEC框）。 再往下是微架构层
// （microarchitecture），包含两个主要分支： 左支： 一个
// 蓝色圆角矩形框，内文为“gate-based instructions”。 该框
// 向上接收来自“surface code QEC”的输入箭头。 该框向下分
// 出四条蓝色粗箭头，分别指向底部四个参数组： 第一组：“(μ
// s, 10⁻³)” 第二组：“(μs, 10⁻)” 第三组：“(ns, 10⁻³)” 第
// 四组：“(ns, 10⁻)” 这四个参数组下方由一个大括号统一标注
// 为“trapped-ion qubits”和“superconducting qubits”两类设
// 备类型（前两组对应离子阱，后两组对应超导）。 右支： 一
// 个蓝色圆角矩形框，内文为“Majorana instructions”。 该框
// 向上接收来自“Hastings-Haah code QEC”的输入箭头。 该框
// 向下分出两条蓝色粗箭头，分别指向底部两个参数组： 第一
// 组：“(ns, 10⁻)*” 第二组：“(ns, 10⁻)*” 这两个参数组下方
// 由一个大括号统一标注为“Majorana qubits”。 所有底层设备
// 类型（trapped-ion qubits, superconducting qubits,
// Majorana qubits）共同被右侧最下方的大括号标注为“
// relevant device type”。 左侧边缘从上至下依次标注了各层
// 间转换过程的名称： “front end compilation”：位于顶层算
// 法框与LLVM框之间。 “back end compilation”：位于LLVM框
// 与quantum executable框之间。 “logical operation
// decoder”：位于quantum executable/planar quantum ISA与
// QEC层之间。 “syndrome extraction circuits”：位于QEC层
// 与指令层（gate-based / Majorana instructions）之间。
// 整张图传达了从高层应用算法经过多级编译和解码，最终映射
// 到不同物理量子比特平台及其具体操作参数的完整流程，并突
// 出了不同硬件路径所对应的时序与错误率参数范围。
#figure(image("imgs/examples.png", width: 90.0%),
  caption: [
    The examples and options included in the quantum stack for our resource estimates. We consider three application examples at the top, and a range of hardware parameter examples relevant for a variety of hardware approaches at the base of the stack. We label layers of the quantum stack on the right, and the maps between these layers on the left. To highlight our qubit parameter examples, we separate the microarchecture layer into two sub-layers. All our examples flow through the same planar quantum ISA. Applications are translated down the software stack and the resulting ISA-level executable is input to the tool. The tool also takes as input configurable architecture models that include fault-tolerance details and physical qubit models. The tool outputs resource estimates such as the number of physical qubits or time required to run the application.
  ]
)
<fig-examples>



While it is impossible to fully model every aspect of a future large-scale quantum computing system, here we strive to model system components that are expected significantly impact performance; we abstract away or neglect aspects which are expected to have small contributions to the cost. In this tool we have made a number of assumptions to enable simple and efficient, yet effective, resource estimation. The formulas used in our estimates are expressed to the lowest order in parameters which are expected to be small (such as error rates). These formulas are therefore only valid for sufficiently small values of those parameters. (Various checks are included in the tool to flag when this is not the case given user inputs.) We anticipate that the resource estimates we present here will be further improved by incorporating additional details and relaxing a number of our assumptions. The primary assumptions that are made throughout the various aspects of this analysis are collected together and listed in @app-primary-assumptions.


The remaining appendices are divided into three parts. The first part, @app-noise#"-"@app-cat-state, describes models for different components of a large-scale quantum computer. In @app-resource-estimates, we use these models to estimate physical resources (qubit counts, runtime) required for executing quantum applications. The third part, @app-applications, details the applications and algorithmic optimizations used to reduce resource requirements.


#figure(
  {
  set text(size: 7pt)
  set par(leading: 0.5em)
  table(
    columns: 11,
    align: center,
    inset: (x: 3pt, y: 1.2pt),
    table.cell(rowspan: 4)[#strong[application]], table.cell(align: center, colspan: 4)[planar quantum ISA], [], table.cell(align: center, colspan: 3)[QEC], table.cell(align: center, colspan: 2)[#strong[resource]],
    table.cell(align: center, colspan: 4)[requirements], [#strong[qubit]], table.cell(align: center, colspan: 3)[optimization], table.cell(align: center, colspan: 2)[#strong[requirements]],
    table.cell(rowspan: 2)[$Q$], table.cell(rowspan: 2)[$C_(upright("min"))$], [ ], table.cell(rowspan: 2)[$M$], [#strong[parameters]], table.cell(rowspan: 2)[$d$], table.cell(rowspan: 2)[$F$], [factory], [#strong[physical]], [#strong[physical]],
    [], [], [ratio], [#strong[qubits]], [#strong[run time]],
    [], [], [], [ $1.5 dot.op 10^5$], [], [], [19], [199], [95\%], [#strong[3.0M]], [#strong[29 mins]],
    [], [], [], [ $1.5 dot.op 10^5$], [], [], [9], [199], [95\%], [#strong[0.68M]], [#strong[14 mins]],
    [#strong[quantum]], table.cell(rowspan: 2)[230], table.cell(rowspan: 2)[$1.5 dot.op 10^5$], [ $1.5 dot.op 10^5$], table.cell(rowspan: 2)[$2.4 dot.op 10^6$], [], [19], [242], [98\%], [#strong[8.2M]], [#strong[1.1 secs]],
    [#strong[dynamics]], [ $1.5 dot.op 10^5$], [], [9], [199], [95\%], [#strong[0.68M]], [#strong[0.56 secs]],
    [], [], [], [ $1.5 dot.op 10^5$], [], [], [9], [260], [99\%], [#strong[5.8M]], [#strong[0.42 secs]],
    [], [], [], [ $1.5 dot.op 10^5$], [], [], [5], [224], [95\%], [#strong[0.62M]], [#strong[0.23 secs]],
    [], [], [], [ $1.5 dot.op 10^6$], [], [], [21], [18], [56\%], [#strong[0.46M]], [#strong[5.3 hours]],
    [#strong[quantum]], [], [], [ $1.5 dot.op 10^6$], [], [], [11], [17], [50\%], [#strong[0.11M]], [#strong[2.8 hours]],
    [#strong[dynamics]], table.cell(rowspan: 2)[230], table.cell(rowspan: 2)[$1.5 dot.op 10^5$], [ $1.5 dot.op 10^6$], table.cell(rowspan: 2)[$2.4 dot.op 10^6$], [], [21], [22], [78\%], [#strong[0.94M]], [#strong[13 secs]],
    [#strong[\(reduced]], [ $1.5 dot.op 10^6$], [], [11], [17], [50\%], [#strong[0.11M]], [#strong[6.7 secs]],
    [#strong[T factories)]], [], [], [ $1.5 dot.op 10^6$], [], [], [11], [22], [79\%], [#strong[0.61M]], [#strong[5.0 secs]],
    [], [], [], [ $1.5 dot.op 10^6$], [], [], [5], [23], [66\%], [#strong[0.09M]], [#strong[2.3 secs]],
    [], [], [], [ $4.1 dot.op 10^11$], [], [], [33], [15], [6.9\%], [#strong[6.4M]], [#strong[260 years]],
    [], [], [], [ $4.1 dot.op 10^11$], [], [], [17], [14], [5.9\%], [#strong[1.6M]], [#strong[130 years]],
    [#strong[quantum]], table.cell(rowspan: 2)[2740], table.cell(rowspan: 2)[$4.1 dot.op 10^11$], [ $4.1 dot.op 10^11$], table.cell(rowspan: 2)[$5.4 dot.op 10^11$], [], [33], [17], [14\%], [#strong[6.9M]], [#strong[2.0 months]],
    [#strong[chemistry]], [ $4.1 dot.op 10^11$], [], [17], [17], [15\%], [#strong[1.9M]], [#strong[1.0 month]],
    [], [], [], [ $4.1 dot.op 10^11$], [], [], [17], [19], [22\%], [#strong[4.5M]], [#strong[24 mins]],
    [], [], [], [ $4.1 dot.op 10^11$], [], [], [9], [19], [22\%], [#strong[1.3M]], [#strong[12 days]],
    [], [], [], [ $1.2 dot.op 10^10$], [], [], [27], [13], [0.6\%], [#strong[37M]], [#strong[6.2 years]],
    [], [], [], [ $1.2 dot.op 10^10$], [], [], [13], [14], [0.8\%], [#strong[8.6M]], [#strong[3.0 years]],
    table.cell(rowspan: 2)[#strong[factoring]], table.cell(rowspan: 2)[25481], table.cell(rowspan: 2)[$1.2 dot.op 10^10$], [ $1.2 dot.op 10^10$], table.cell(rowspan: 2)[$1.5 dot.op 10^10$], [], [27], [15], [1.3\%], [#strong[37M]], [#strong[1.5 days]],
    [ $1.2 dot.op 10^10$], [], [13], [18], [1.1\%], [#strong[8.7M]], [#strong[18 hours]],
    [], [], [], [ $1.2 dot.op 10^10$], [], [], [15], [15], [0.9\%], [#strong[26M]], [#strong[15 hours]],
    [], [], [], [ $1.2 dot.op 10^10$], [], [], [7], [13], [1.2\%], [#strong[6.2M]], [#strong[7.1 hours]],
  )
  },
  caption: [Estimated resource costs to implement some example applications using hardware devices with various parameters. The application is compiled down from a high-level quantum program to a program expressed in the planar quantum ISA, with parameters as shown. To supply the planar quantum ISA with the capability to run this program, QEC is used. The code distance $d$ of the error correcting code and the number of T state distillation factories $F$ are carefully optimized to minimize the resources needed while providing enough fault protection that the overall computation runs reliably. We also show the percentage of the physical qubits which are used for T state distillation factories. We use an asterisk to indicate Majorana qubits. In the second implementation of the quantum dynamics example we slow the algorithm down by setting $C = 10 C_(upright("min"))$, which allows for a reduction in the number of T factories, thereby reducing the qubit overhead.],
)
<tab-physical-and-logical-overhead>


= PHYSICAL QUBIT MODELS
<app-noise>


We begin by specifying the instruction sets and noise models for the physical qubits representation in our analysis, at the level of the microarchitecture in our quantum stack. We also provide a set of example qubit parameters.


We assume that physical qubits are capable of implementing one of two instruction sets; see @fig-physical-operations. The #emph[gate-based] instruction set implements unitary operations such as CNOT or CZ as its native entangling operations. On the other hand, the #emph[Majorana] instruction set implements parity checks such as ZZ and XX measurements as its native entangling operations.#footnote[Note that in some literature, the Majorana instruction set is known as 'measurement-based', but this can cause confusion with quantum computing using cluster states, which is also commonly referred to as measurement-based.] With Majorana instruction sets, unitary operations are realized using a sequence of measurements. For both gate-based and Majorana instruction sets in @fig-physical-operations, we specify the allowed operations by visualizing the qubits laid out in a array with nearest neighbor connectivity. This visualization can either represent the true layout of the qubits in the hardware, such as for solid-state based approaches or can be considered as no more than a visualization to ensure that all operations in the instruction set are available, such as for trapped ions. Note that a particular hardware approach may have other allowed operations not in one of these instruction sets --- these additional operations are not relevant for our analysis as we assume only operations from the instruction sets are used.


// [figvision-cn] imgs/Picture3.png
// 该图像包含两个并排的示意图，分别标记为(a)和(b)，展示了
// 两种不同的物理量子比特指令集在二维晶格上的布局。 子图(
// a) 类型：示意图。 布局与物体：背景是一个由黑色实心圆点
// 组成的规则矩形网格，代表物理量子比特的位置，排列成5行8
// 列。网格上叠加了多种带有字母标注的彩色几何图形，代表不
// 同类型的量子门操作或状态制备指令。所有图形均具有白色边
// 框。 颜色编码与含义：根据图注，绿色代表泡利基（Pauli
// basis）的状态制备；黄色代表T态制备或T门应用；蓝色代表
// 在所有泡利基下的测量；橙色代表特定的逻辑门操作。 具体
// 元素分布： 绿色图形（泡利基制备）：左上角有一个竖直的
// 绿色圆角矩形，内含字母“Z”；左侧中间有一个绿色的D形块（
// 左半圆），内含字母“X”；左下角有一个蓝色的D形块（左半圆），
// 内含字母“Y”（注意：此处虽然图注称绿色为泡利制备，但图
// 中Y是蓝色，X和Z有绿色也有蓝色，需结合下文说明，实际上
// 图中X, Y, Z既有绿色也有蓝色，可能表示不同基矢的操作，
// 或者颜色区分了单比特/双比特，但图注明确说了“state
// preparation in the Pauli basis (green)”和“measurement
// in all Pauli basis (blue)”。仔细观察，左上角的Z是绿色，
// 左边的X是绿色，左下Y是蓝色，中间Z是蓝色，右下Y是绿色。
// 这可能意味着具体的操作类型。为了准确描述，我将按视觉呈
// 现的颜色描述）。修正：左上角Z是绿色；左侧X是绿色；右下
// 角Y是绿色。 黄色图形（T相关）：右上角区域有两个黄色的D
// 形块（右半圆），均内含字母“T”。 蓝色图形（测量或其他）：
// 左侧下方有一个蓝色D形块含“Y”；中间偏左有一个蓝色D形块
// 含“Z”；中间偏左上方有一个蓝色D形块含“X”。 橙色图形（门
// 操作）： 顶部中间有一个橙色正方形，内含字母“S”。 顶部
// 右侧有一个竖直的长条形橙色圆角矩形，内含竖排文字“CNOT”。
// 中间左侧有一个横向的橙色圆角矩形，内含文字“CZ”。 中间
// 右侧有一个横向的橙色圆角矩形，内含文字“CNOT”。 底部中
// 间有一个橙色正方形，内含字母“H”。 最右侧边缘有一个竖直
// 的长条形橙色圆角矩形，内含竖排文字“CZ”。 连接关系：大
// 部分图形独立放置在网格点上，除了标有“CNOT”和“CZ”的长方
// 形似乎跨越了两个网格点的距离，暗示这是两比特纠缠门。例
// 如顶部的“CNOT”跨越了垂直方向的两个点，中间的“CZ”跨越了
// 水平方向的两个点。 标注文字：左下角有文字“gate-based
// instructions”。 子图(b) 类型：示意图。 布局与物体：背
// 景同样是5行8列的黑色实心圆点网格。网格上叠加了较少的彩
// 色图形，且部分图形之间有连接线。 颜色编码与含义：沿用
// 子图(a)的颜色定义。 具体元素分布： 绿色图形：左上角有
// 一个绿色D形块（左半圆），内含“Z”；左侧中间有一个绿色D
// 形块（左半圆），内含“X”；右下角有一个绿色D形块（左半圆），
// 内含“Y”。 黄色图形：右上角有一个黄色D形块（右半圆），
// 内含“T”；其下方有一个黄色D形块（右半圆），内含“T”。 蓝
// 色图形： 左侧下方有一个蓝色D形块（左半圆），内含“Y”。
// 中间偏左下方有一个蓝色D形块（左半圆），内含“Z”。 中间
// 偏左上方有一个蓝色D形块（右半圆），内含“X”。 顶部中间
// 有一组垂直排列的两个蓝色D形块（均为左半圆），上下相连，
// 均内含“X”。这两个块之间有一条短的蓝色直线连接。 中间偏
// 右下方有一组水平排列的两个蓝色D形块（均为右半圆），左
// 右相连，均内含“Z”。这两个块之间有一条短的蓝色直线连接。
// 连接关系：此图中出现了明显的连接线。顶部中间的两个“X”
// 块通过一条短蓝线垂直连接；中间右侧的两个“Z”块通过一条
// 短蓝线水平连接。这暗示了Majorana指令集中特定的相互作用
// 或编织操作。 标注文字：左下角有文字“Majorana
// instructions”。 趋势或结论： 该图对比了基于门的（
// gate-based）和马约拉纳（Majorana）两种量子计算架构的物
// 理指令集。子图(a)显示基于门的架构支持丰富的单比特门（H
// , S, T, X, Y, Z）和标准的两比特纠缠门（CNOT, CZ），操
// 作种类多样且密集。子图(b)显示马约拉纳架构的指令集更为
// 精简，主要由泡利基操作、T门以及特定的两比特相互作用组
// 成（如图中连接的XX和ZZ项），反映了拓扑量子计算中利用马
// 约拉纳零能模进行编织操作的特性。
#figure(image("imgs/Picture3.png", width: 80.0%),
  caption: [
    We consider gate-based and Majorana instruction sets for physical qubits. Both sets include state preparation in the Pauli basis (green), T state preparation (yellow), T gate application (yellow), and measurement in all Pauli basis (blue). (a) The gate-based instruction set also includes Hadamard H and S gates, and CNOT and CZ entangling gates between adjacent qubits (all orange). (b) The Majorana instruction set also allows non-destructive joint Pauli measurements of adjacent qubits (blue).
  ]
)
<fig-physical-operations>



We assume the standard noise model known as #emph[circuit noise], wherein each operation on the physical qubits fails independently. More specifically, we assume each Clifford operation fails with probability $p$, where Clifford operations include the Hadamard and phase gates, the Controlled NOT (CNOT) and Controlled Z (CZ) gates, single-qubit basis state preparation, and one-qubit and two-qubit Pauli measurements. We consider an idle qubit for a single time step to be an identity operation which can also fail with probability $p$. The preparation of a single-qubit T state, which is a non-Clifford operation, is assumed to fail with probability $p_T$. Failures are modeled by introducing random Pauli operators on qubits targeted by the operation. When the operation which fails is a measurement, the outcome is randomly flipped in addition to applying a Pauli operator to the support of the measurement. We also use the terminology of error rate in place of infidelity when describing noisy states, by making the simplifying assumption that the noise on the state arose from circuit noise (or logical Pauli noise where appropriate) with a given error rate.


In @tab-qubit-type, we consider a range of example qubit parameters which abstractly represent different regimes of operation fidelity and time. These values of parameters are selected to be relevant for different hardware approaches. For readability, we label each example by the approximate operation time, Clifford operation error rate and instruction set. For example, the first qubit has a gate time $t_(upright("gate"))$ and measurement time $t_(upright("meas"))$ of 100 $mu$s, a Clifford error rate $p$ of $10^(- 3)$ with a gate-based instruction set; therefore, we label it ($mu$s, $10^(- 3) )$. The first four examples are gate-based qubits and the remaining two are Majorana qubits. To fit the simple circuit noise model which we assume, we choose a uniform error rate for all Clifford operations, which can be assumed to equal the highest of the error rates for any Clifford operation in the instruction set (including single-qubit gates and measurements and two-qubit gates and measurements). We select the parameters for each example as follows:

- #strong[$(upright(mu)"s", 10^(-3))$ qubit] and #strong[$(upright(mu)"s", 10^(-4))$ qubit] may be relevant for future versions of trapped ion qubits~@Cirac1995 @pino2021, which typically have operations times in the microsecond regime. We choose 100 $mu$s as the gate and measurement time based on typical assumptions for ion qubits~@Leung2018 @Murali2020. We assume high-quality single qubit gates with an error rate of $10^(- 6)$ and two cases for two-qubit gates with error rates of $10^(- 3)$ and $10^(- 4)$ based on the architectural assumptions in Ref.~@blueprintTrappedIon.

- #strong[$("ns", 10^(-3))$ qubit] and #strong[$("ns", 10^(-4))$ qubit] may be relevant for future versions of superconducting transmon qubits~@transmonSchoelkopf @schreier2008 @kjaergaard2020 @arute2019 @hong2020 @Steffen2011 or spin qubits~@kane1998 @Hanson2007 @Jnane2022, which typically have operation times in the nanosecond regime. We project 50 ns gate times and 100 ns measurement times for future systems based on recent system implementations~@googleSurfaceCode @ibmMontreal, which can be viewed as relatively optimistic (particularly for measurements). We evaluate two cases, with $10^(- 3)$ and $10^(- 4)$ two-qubit gate error rates, respectively, as realistic and optimistic targets for a scaled up system~@ibmMontreal @Gidney2021.

- #strong[$("ns", 10^(-4))$ Majorana qubit] and #strong[$("ns", 10^(-6))$ Majorana qubit] may be relevant for future Majorana qubits~@kitaev2001 @sarma2015 @Karzig2017. For these qubits, we assume that measurements and the physical T gate each take $100$ ns. Owing to topological protection in the hardware, we assume single and two-qubit measurement error rates (Clifford error rates) of $10^(- 4)$ as a realistic target and $10^(- 6)$ as an optimistic target. Non-Clifford operations in this architecture do not have topological protection, so we assume a $5 "%"$ and $1 "%"$ error rate for non-Clifford physical T gates for the realistic and optimistic models respectively.


Together, these examples cover a range of operation times and error rates, enabling sufficient exploration of the resource costs anticipated to enable practical quantum applications. Note that in @fig-examples and @tab-physical-and-logical-overhead, we use an asterisk to indicate the Majorana qubit for notational convenience.


= QUANTUM ERROR CORRECTION AND THE PLANAR QUANTUM ISA
<app-logical-operations-details>


Here we review two quantum error correction (QEC) schemes, focusing on estimates of the resources required for their implementation and for applying fault-tolerant logical operations on the encoded information. For qubits with a gate-based instruction set, we assume the surface code. It is the best-understood QEC scheme for this class of qubits and offers a high threshold for practical implementation. For qubits with a Majorana instruction set, we consider both the surface code and also the Hastings-Haah code, which is a recently developed QEC scheme that offers better space-time costs than surface codes on Majorana qubits in many regimes~@Hastings2021 @Paetznick2022. It is also in principle possible to implement the Hastings-Haah code with qubits that use a gate-based instruction set, but the overhead is higher than the surface code in all regimes of interest in this case so we do not include it~@Gidney2022.


In @tab-error-correction we provide formulas to estimate the physical qubit and time overheads required to implement logical qubits with the surface code and the Hastings-Haah code as a function of qubit design parameters. We estimate the logical error rate $P ( d )$ of a patch of surface code or Hastings-Haah code of distance $d$ with physical error rate $p$ using the formula


$ P ( d ) = a (p / p^(*))^(frac(d + 1, 2)) , $<eq-logical-error-rate-formula>


where the pre-factor $a$ and threshold value $p^(*)$ can be extracted numerically from simulations.


#figure(
  table(
    columns: 4,
    align: center,
    table.header([QEC scheme], [logical error rate], [qubits per logical qubit], [logical time step],),
    table.hline(),
    [surface code], table.cell(rowspan: 2)[$P_(upright("sur")) ( d ) = 0.03 (p / 0.01)^(frac(d + 1, 2))$], table.cell(rowspan: 2)[$n_(upright("sur")) ( d ) = 2 d^2$], table.cell(rowspan: 2)[$tau_(upright("sur")) ( d ) = ( 4 t_(upright("gate")) + 2 t_(upright("meas")) ) d$],
    [(gate-based qubits)],
    [surface code], table.cell(rowspan: 2)[$P_("sur,meas") ( d ) = 0.08 (p / 0.0015)^(frac(d + 1, 2))$], table.cell(rowspan: 2)[$n_("sur,meas") ( d ) = 2 d^2$], table.cell(rowspan: 2)[$tau_("sur,meas") ( d ) = 20 t_(upright("meas")) d$],
    [(meas-based qubits)],
    [Hastings-Haah code], table.cell(rowspan: 2)[$P_(upright("HH")) ( d ) = 0.07 (p / 0.01)^(frac(d + 1, 2))$], table.cell(rowspan: 2)[$n_(upright("HH")) ( d ) = 4 d^2 + 8 ( d - 1 )$], table.cell(rowspan: 2)[$tau_(upright("HH")) ( d ) = 3 t_(upright("meas")) d$],
    [(meas-based qubits)],
  ),
  caption: [Options of error correction schemes. We model each logical qubit as having a probability $P$ of failing during a single logical time step, which can be tuned by changing the code distance $d$, which is an odd integer. Increasing $d$ increases the number of qubits $n ( d )$ required to store each logical qubit and the time $tau ( d )$ required for each logical time step. The formulas are based on Refs.~@Fowler2012 and @Wang2011 for gate-based surface codes, on Refs.~@Tran2020 and @Chao2020 for surface codes implemented with Majorana instruction sets (replacing 8 steps to measure a single stabilizer in Ref.~@Tran2020 by 20 steps to measure all stabilizers), and on Ref.~@Paetznick2022 for Hastings-Haah codes.],
)
<tab-error-correction>


// [figvision-cn] imgs/Picture4.png
// (a) 示意图。展示了一个用于编码逻辑量子比特的物理量子比
// 特补丁。主体是一个大的正方形区域，内部填充浅紫色，并排
// 列有5行5列共25个黑色实心圆点，代表物理量子比特。该正方
// 形的上下边缘标有粗体大写字母“X”，左右边缘标有粗体大写
// 字母“Z”。正方形的边框由粗黑虚线构成。 (b) 示意图。展示
// 了两个相邻的逻辑量子比特补丁及其相互作用。左侧是一个垂
// 直方向的矩形补丁，内部包含两行三列共6个白色大写字母“X”
// 和“Z”交替排列（第一行X, Z, X；第二行Z, X, Z），背景为
// 浅紫色，边框为粗黑虚线。右侧是一个更大的垂直矩形补丁，
// 同样为浅紫色背景和粗黑虚线边框。该右侧补丁的左半部分标
// 有“Z1”和“Z2”，右半部分标有“X1”和“X2”。在两个补丁的上方
// 中间位置标注有“X1X2”，下方中间位置标注有“Z1Z2”。这两个
// 补丁右侧紧邻一个填充了灰色斜线的矩形区域。 (c) 示意图。
// 展示了两个独立的方形单元。左侧是一个较小的正方形，填充
// 浅紫色，边框为粗黑虚线。右侧是一个尺寸相同的正方形，填
// 充灰色斜线图案。两者水平并排，中间有少量间隙。 (d) 示
// 意图。展示了量子比特状态的移动或传输过程。左侧是一个填
// 充浅紫色、边框为粗黑虚线的正方形。一条蓝色粗虚线箭头从
// 该正方形出发，先向右延伸，然后向下转折90度，再向右延伸，
// 最终指向右侧的一个正方形。目标正方形填充浅紫色，但边框
// 变为细实线且颜色较淡。路径经过的区域被灰色斜线填充。 (
// e) 示意图。展示了多个分散的逻辑量子比特补丁布局。图中
// 包含四个主要的浅紫色正方形补丁，均带有粗黑虚线边框。左
// 上角的补丁内标有字母“Z”；右上角的补丁内标有字母“X”；左
// 下角的补丁内标有字母“Z”；右下角的补丁内标有字母“X”。此
// 外，在图的中部偏右位置，有三个较小的浅紫色正方形水平排
// 列，每个内部都标有字母“X”。这些补丁之间通过填充灰色斜
// 线的区域连接或分隔。 (f) 示意图。展示了两个分离的垂直
// 矩形补丁嵌入在一个大的背景区域中。背景区域填充灰色斜线。
// 左侧的补丁为浅紫色，边框为粗黑虚线，内部标有“P1 P2”。
// 右侧的补丁结构与左侧相同，内部标有“P3 P4”。两个补丁水
// 平排列，中间被灰色斜线区域隔开。 (g) 示意图。展示了包
// 含特殊门操作的量子电路片段。左侧是一个不规则形状的区域，
// 填充灰色斜线。右侧是一个较小的正方形区域，填充浅紫色，
// 边框为细实线且颜色较淡。在该浅紫色正方形的中心，有一个
// 黄色的圆形，圆内标有大写字母“T”。
#figure(image("imgs/Picture4.png", width: 100.0%),
  caption: [
    #strong[Fault-tolerant logical operations: instruction set of the planar quantum ISA]. (a) Patches of physical qubits encode logical qubits in either the surface code or the Hastings-Haah code, with error correction performed using operations from the instruction set. We group the array of physical qubits into tiles, each containing $n ( d )$ physical qubits, and count logical operations in units of logical time steps $tau ( d )$ as defined in @tab-error-correction. (b) We focus here on #emph[one-tile patches], and #emph[two-tile patches], which encode one and two qubits into $n ( d )$ and $2 n ( d )$ physical qubits respectively. We label sections of the boundary of these patches which are relevant for the logical operations of the planar quantum ISA. #strong[Preparation] of qubits in one-tile and two-tile patches in computational basis states can be applied in $0 tau ( d )$. Arbitrary #strong[Pauli unitaries] can be applied to qubits in one-tile and two-tile patches in $0 tau ( d )$. Destructive #strong[measurement] of a qubit in a one-tile patch in the X or Z basis and of both of the qubits in a two-tile patch (either both in the X basis or both in the Z basis) can be done in $0 tau ( d )$. (c) #strong[Hadamard and phase unitaries] can be applied to a qubit in a one-tile patch with an adjacent ancilla tile in $3 tau ( d )$ and $2 tau ( d )$ respectively. The ancilla can be on any boundary for the Hadamard, and next to a Z boundary for the phase. (d) A #strong[move] of a qubit in a one-tile patch to a different tile along a path connecting any boundaries of the starting and ending tiles in $1 tau ( d )$. (e) A non-destructive #strong[multi-qubit X, Z type measurement] of the qubits in a set of one-tile patches can be implemented in $1 tau ( d )$. This can be done by forming a connected region of tiles, where each tile hosting a qubit to be measured in the X (Z) basis connects through one or both of its X (Z) boundaries, and connections can be between adjacent qubit tiles, or mediated by ancilla tiles. (h) A non-destructive #strong[multi-qubit arbitrary Pauli measurement] of a set of qubits stored in two-tile patches can be performed in $1 tau ( d )$. This can be achieved with a connected region of ancilla tiles with access to all of the X and Z boundaries of each of the two-tile patches. (i) #strong[T state preparation] in either a one-tile patch or a two-tile patch can be achieved using a distillation factory as described in @app-distillation-overhead, using a non-integer number of tiles and logical time steps which depends on the quality requirements of the state.
  ]
)
<fig-logical-operations>



Protected logical operations can be applied to logical qubits stored in the surface code or the Hastings-Haah code. We assume precisely the same types of logical patches, set of logical operations and costs (in units of number of tiles and logical time steps) for surface codes and Hastings-Haah codes, which forms the logical instruction set which we call the #emph[planar quantum ISA] shown in @fig-logical-operations. The differences that we account for between these two QEC codes are all captured by the different formulas for the logical error rate $P ( d )$, number $n ( d )$ of physical qubits in a tile and the time $tau ( d )$ for a logical time step for a given distance $d$, as specified in @tab-error-correction. The logical operations can be inexpensive, almost perfect and instantaneous (Pauli unitaries, single-qubit preparations and measurements), medium cost, requiring ancilla tiles and one logical time step (multi-qubit Pauli measurements), or expensive, such as T state preparation for the execution of so-called non-Clifford gates, which requires a significant number of time steps and auxiliary qubits, which is discussed in detail in @app-distillation-overhead. The patch choices and logical Clifford operations and costs are largely based on Refs.~@Litinski2019 @Bombin2021.


As a simplification, we do not account for the overhead contributions associated with a number of known challenges. The circuits expressed in the physical-level instruction set which are used to implement QEC codes and logical operations fault-tolerantly are referred to as #emph[syndrome measurement circuits]. For surface codes, the two-tile patches may require additional technical challenges to implement the necessary syndrome measurement circuits, such as measuring higher-weight stabilizer generators~@Chamberland2021 @Chamberland2022b. Two-tile patches for Hastings-Haah codes have not been studied in detail in the literature but may pose similar implementation challenges. Moreover, the size and shape of a tile may need to be altered to accommodate the non-standard patches (such as the two-tile patch) and to account for ancillas between patches that can aid lattice surgery. We also assume that a Clifford operation which takes $A$ logical time steps to implement and involves $B$ tiles fails with probability $A dot.op B dot.op P ( d )$.


= T STATE DISTILLATION FACTORIES
<app-distillation-overhead>


The non-Clifford T state preparation in the planar quantum ISA in @fig-logical-operations is crucial because the other operations in that quantum ISA, which are all Clifford operations, and are not sufficient for universal quantum computation~@GottesmanKnill. To implement non-Clifford operations for practical-scale algorithms, we require low error rate T gates or T states, however these can be difficult to directly implement on logical qubits~@Bravyi2013 @beverland2016a, and can also be difficult for some physical qubits~@sarma2015 @Karzig2017. Instead, the required low error rate T states are produced using a #emph[T state distillation factory]~@knill2004 @bravyi2005, which we sometimes refer to as a 'T state factory', a 'distillation factory' or even just a 'factory' for short. Here we consider the resources required to implement factories which produce T states in distance-$d$ surface or Hastings-Haah codes with error rate $P_T$.


The operation of a T state factory typically begins by first producing imperfect T states using some means, for example, a low-quality physical T gate acting on a physical qubit. These T states are then typically transferred to a logical qubit and is refined using a distillation unit, which uses only Clifford operations. This procedure can be iterated, where the output T states of one round are fed into the next round as inputs. In the error rate of physical T gates $p_T$ is much larger than that of physical Clifford operations $p$, it can make sense to do some distillation in physical qubits before transferring the state to a logical qubit.


// [figvision-cn] imgs/Picture5.png
// 这是一张包含三个子图（a、b、c）的科学示意图，展示了双
// 轮T态蒸馏工厂的架构。 子图 (a) 类型：示意图 布局与物体：
// 该子图展示了一个由34个相同的单元组成的阵列，排列成5行。
// 前四行每行包含7个单元，第五行包含6个单元。每个单元由一
// 个浅蓝色的正方形网格表示，网格内部有一个黑色的“X”形图
// 案，代表一个15-to-1蒸馏单元。在阵列的最左侧一列下方，
// 有一个垂直的黑色粗箭头指向第一行的第一个单元。 标注文
// 字：子图左下角标有“(a)”，底部中央标有“distillation
// units (round 1)”。 物理含义与趋势：此图描绘了第一轮蒸
// 馏过程。根据图注，这些是15-to-1蒸馏单元的副本。图中显
// 示的34个单元对应于输入到第一轮蒸馏中的T态数量。图注指
// 出，并非所有这34个副本都会被接受，意味着这是一个概率性
// 的或需要后选择的过程。左侧的箭头可能指示数据流或处理的
// 起始方向。 子图 (b) 类型：示意图 布局与物体：该子图展
// 示了转移单元的配置。它包含多个独立的组块。具体来说，有
// 四组水平排列的三个单元，以及两组单独的单单元。总共显示
// 了14个单元。每个单元由一个浅蓝色的正方形表示，中心有一
// 个黑点，四个角各有一个小黑点。相邻的单元之间通过水平的
// 黑色短箭头连接，表示信息或量子态的传输。 标注文字：子
// 图左下角标有“(b)”，底部中央标有“transfer units”。 物理
// 含义与趋势：此图描绘了用于将噪声T态编码到距离为d的代码
// 补丁中的转移单元。虽然图注提到代码补丁未显示，但这些转
// 移单元是预处理步骤的一部分。箭头表明了数据从一组单元流
// 向另一组单元的方向。 子图 (c) 类型：示意图 布局与物体：
// 该子图展示了第二轮蒸馏单元的简化视图。它包含两个主要的
// 处理节点，每个节点由一个大的黑色星号形状表示，中心有一
// 个蓝色的“X”。这两个节点位于一个由浅蓝色方块组成的背景
// 网格上。在每个星号节点的上方和下方，都有垂直的黑色粗条
// 带穿过，连接到其他蓝色方块。此外，还有一些孤立的蓝色方
// 块分布在周围。 标注文字：子图左下角标有“(c)”，底部中央
// 标有“distillation units (round 2)”。 物理含义与趋势：
// 此图描绘了第二轮蒸馏过程。经过第一轮筛选后的T态被送入
// 这些更高级别的蒸馏单元进行处理。星号形状可能代表了更复
// 杂的逻辑操作或更多的资源消耗。垂直的连接线表明这些单元
// 与系统的其他部分有交互，可能是接收输入或输出结果。
#figure(image("imgs/Picture5.png", width: 95.0%),
  caption: [
    An example of a two-round T state distillation factory. First, a transfer unit encodes $c_0 = 34 dot.op 15 = 510$ noisy T states into distance-$d_1$ code patches (not shown). (a) Next, in the first distillation round, each of these T states are input into one of $c_1 = 34$ copies of a 15-to-1 distillation unit are applied on the distance-$d_1$ code patches. It is possible that not all of the 34 copies of the distillation unit are accepted. (b) For those copies which are accepted, the code patch hosting the T state produced is expanded from distance $d_1$ to distance $d_2$, and moved into place for the next distillation round using a transfer unit. (c) In the second distillation round, $30$ T states (provided at least that many remain) are fed into $c_2 = 2$ copies of a 15-to-1 distillation unit. If fewer than $30$ T states remain (but more than 14), then just one of the $c_2 = 2$ copies of the distillation unit can be implemented. The T states encoded in distance-$d_2$ codes produced by round two form the output of the distillation factory.
  ]
)
<fig-distillation>



We consider T state distillation factories which are implemented in a sequence of rounds, where each round consists of a set of identical distillation units run in parallel; see @fig-distillation. We focus on factories composed of two types of units. #emph[Distillation units] (see @tab-distillation-modules) take in a set of T states with a given quality, and output a smaller set of T states, but which typically have a higher quality. We assume that distillation units have the same kind of qubits as input and output, for example distance-$d$ surface codes. Distillation units typically involves a post selection test - if it is passed, then the output is accepted, otherwise the output is discarded. #emph[Transfer units] take T states stored in qubits of one type in one location and transfer them to T states stored in qubits of a different type at another location. For example a transfer unit could take a set of T states stored in physical Majorana qubits, and transfer them into a set of distance-$d$ Hastings-Haah codes positioned where they are needed as inputs to a distillation unit in the next round. Another example would take qubits in distance-$d_1$ surface codes at the locations output from a previous round of distillation, and transfer them into distance-$d_2$ surface codes at the locations where they are needed as inputs to a distillation unit in the next round. In our analysis we neglect additional overheads required for implementing the transfer units and any noise they introduce. We specify a distillation factory $cal(D)$ by stating: the number of rounds it uses $R$, and for each round $r in ( 1 , 2 , dots.h R )$, both the distillation unit $M_r$ (including the qubit type, such as a specific physical qubit example, or a logical surface code or logical Hastings-Haah code, and code distance) and the number of copies $c_r$ of that unit. We do not specify the transfer units between rounds because we do not include the associated costs in our resource estimates. See @tab-distillation-examples for some example distillation factories.


#figure(
  table(
    columns: 7,
    align: center,
    [distillation], [\# input Ts], [\# output Ts], [acceptance], [\# qubits], [time], [output],
    [unit], [], [], [probability], [], [], [error-rate],
    [15-to-1 space-eff.], [15], [1], [$1 - 15 p_T - 356 p$], [$12$], [$46 t_(upright("meas"))$], [$35 p_T^3 + 7.1 p$],
    [physical], [], [], [], [], [], [],
    [15-to-1 space-eff.], [15], [1], [$1 - 15 P_T - 356 P$], [$20 n ( d )$], [$13 tau ( d )$], [$35 P_T^3 + 7.1 P$],
    [logical], [], [], [], [], [], [],
    [15-to-1 RM prep.], [15], [1], [$1 - 15 p_T - 356 p$], [$31$], [$23 t_(upright("meas"))$], [$35 p_T^3 + 7.1 p$],
    [physical], [], [], [], [], [], [],
    [15-to-1 RM prep.], [15], [1], [$1 - 15 P_T - 356 P$], [$31 n ( d )$], [$13 tau ( d )$], [$35 P_T^3 + 7.1 P$],
    [logical], [], [], [], [], [], [],
  ),
  caption: [Distillation units. Physical distillation units assumes Majorana qubits with error rates of $p$ and $p_T$ for Clifford and input T states respectively. Logical distillation units assume either the surface code or the Hastings-Haah code, with each logical qubit requiring $n$ physical qubits, each logical time step requiring a time $tau$, and logical error rates of $P$ and $P_T$ for Clifford and input T states respectively. The units are implemented by circuits of allowed operations as shown in @fig-distillation-circuits-1 and @fig-distillation-circuits-2. The coefficients for $p$ and $P$ are estimates based on numerical results for similar circuits, but may be inaccurate.],
)
<tab-distillation-modules>


The outputs of each distillation round are fed into the next, which leads to the following sequence of calculations which can be used to identify the overall properties of the factory. First we set the input error rate $Q_0$ for the first round to be the physical error rate of the T, i.e., $Q_0 = p_T$. Then let $Q_(r - 1)$ be the error rate of the encoded T state that is input into round $r$, and let $P_r$ be the Clifford error rate of the unit at that round (where $P_r$ is calculated from the physical qubit type and the distance and type of error correcting code used by the unit). The acceptance probability $P_r^(upright("acc"))$ and output T state error rate $Q_r$ for each unit in round $r$ are then calculated by setting $P_T$ to $Q_(r - 1)$ and setting $P$ to $P_r$. In @tab-distillation-modules we show the relevant formulas for the four explicit distillation units specified in @fig-distillation-circuits-1 and @fig-distillation-circuits-2, which are all different explicit implementations of the standard 15-to-1 protocol~@bravyi2005.


// [figvision-cn] imgs/Picture6.png
// 子图 (a) 为示意图，展示一个由20个方块组成的4行5列网格
// 布局。其中第一列包含三个绿色方块（位于第1、3、4行）和
// 两个灰色方块（位于第2、5行），第二至第四列为全灰色方块，
// 第五列为全蓝色方块。该图表示逻辑层面的空间分布，绿色代
// 表特定功能区域，灰色代表通用或空闲区域，蓝色代表另一类
// 功能区域。 子图 (b) 为示意图，展示两列垂直排列的圆点：
// 左侧一列共6个灰色实心圆点，右侧一列共6个蓝色实心圆点；
// 最上方一对圆点中，左灰右绿，其余五对均为左灰右蓝。该图
// 对应物理层布局，绿色圆点标记特殊物理量子比特位置，灰色
// 与蓝色分别代表不同类型的物理量子比特资源分配。 子图 (c
// ) 为量子电路示意图，包含四条水平线代表四个输入量子比特
// 轨道。从左到右依次标注：顶部轨道起始处标有“X”，随后是
// 黄色矩形框内含“I”、“Z”等单量子门符号；第二条轨道起始标
// “T”，后接多个黄色框内“Z”或“I”；第三、四轨道同样以“T”开
// 始，后续结构类似。所有黄色框代表对角非Clifford旋转操作，
// 每个框内字母表示具体门类型（I为单位门，Z为泡利Z门）。
// 电路末端四个轨道均连接绿色圆形节点并标注“X”。整体传达
// 基于文献[Ref.]构建的酉形式蒸馏电路，初始注入四个T态，
// 经一系列对角非Clifford旋转后输出。 子图 (d) 为等价变换
// 示意图，左右两侧通过双向箭头连接。左侧为一个竖直黄色长
// 条框，内部自上而下重复书写“Z”，中间用省略号表示延续，
// 底部再写“Z”，代表连续作用在多条线路上的Z门序列。右侧分
// 为三部分：最左是一个黄色椭圆标注“T”，连接至一组竖直排
// 列的“Z”门（蓝色背景），其上方引出支路标记“a”指向一个绿
// 色椭圆标注“P_a”（相位门），该相位门再连接至右侧另一个
// 蓝色背景的“Z”门组。此图说明将密集Z门序列分解为含辅助相
// 位门的等效结构，用于优化实现。 子图 (e) 为复杂量子电路
// 展开图，左侧为一个高大蓝色弧形块，内含多行“Z”字，代表
// 并行作用的Z门阵列；右侧通过双向箭头连接至更详细的电路
// 结构。右侧电路包含六条水平轨道，每条轨道起始处有一个绿
// 色圆形节点标注“X”，之后交替出现蓝色方形“Z”门和浅蓝色菱
// 形“X”门，部分轨道在中间被虚线分隔，虚线右侧继续排列“Z”
// 门及“X”门，最终全部汇聚至最右侧一个高大蓝色矩形框，框
// 内竖排文字“Pauli correction”。该图展示如何从紧凑Z门模
// 块扩展为包含纠错机制的完整电路，末尾执行泡利修正以保证
// 保真度。
#figure(image("imgs/Picture6.png", width: 80.0%),
  caption: [
    Space-efficient 15-to-1 distillation units. (a) and (b) show the logical and physical layouts using 20 patches and 12 physical qubits respectively. (c) A unitary version of the distillation circuit based on Ref.~@Litinski2019b. Four T states are fed in at the beginning of the circuit, and then a sequence of diagonal non-Clifford rotations are applied (yellow boxes, with the rotation $exp ( - i P pi / 8 )$ applied for a box containing Pauli $P$). (d) A diagonal non-Clifford rotation $exp ( - i P pi / 8 )$ can be implemented using a small Clifford circuit given an ancilla prepared in the T state. First, a multi-qubit Z measurement is applied with the support of $P$ extended to include the ancilla, the outcome is $a$. Then the ancilla is measured in the basis $P_a$, where $P_0 = X$ and $P_1 = Y$. A Pauli correction is applied conditioned on the outcome of this ancilla measurement. (e) For physical-level distillation, the multi-qubit Pauli measurement must be broken down further into smaller pieces. Up until the dashed line involves the construction of a cat state on neighboring ancilla qubits. Note that if the support of the multi-qubit Z measurement is not over all six qubits, we replace the upcoming ZZ measurement for any qubits not in the support, and replace it by a single Z measurement. The Pauli correction at the end depends on the outcomes of the measurements in the circuit. #strong[Logical distillation.]--- These operations allow the distillation circuit to be re-expressed as surface code operations using 20 tiles to form a logical distillation unit. The five blue tiles store the qubits shown in the original circuit, and as such, four of them contain T states at the start of the distillation unit. The three green tiles also host T states, and these will be refreshed as the circuit proceeds. Each of the diagonal non-Clifford rotations is implemented using the gadget from (d), where the T state is held in one of the green tiles, and the five grey tiles represent ancillas that are used to facilitate the multi-qubit Z measurement, which takes a single logical time step. Following the multi-qubit Z measurement, that green ancilla is measured in either the X (taking zero logical time steps) or the Y basis (taking one logical time step with the aid of three adjacent ancilla tiles). Following this, another T state is transferred to the green tile, which we assume can be done in a single logical time step. As we have three green tiles, we can overlap this procedure for consecutive rotations such that the 11 non-Clifford rotations are each implemented in a total of 13 logical time steps. This represents the full time of the distillation unit since the initial X basis preparation and final single-qubit measurements take zero logical time steps. #strong[Physical distillation.]--- The physical distillation unit can be run on 12 physical qubits laid out as shown. Each of the 11 non-Clifford rotations requires five time steps, but the ancilla preparation in the X basis for all but the first round since the X basis at the end of the previous round deems it unnecessary. As the operations at the very start and end of the circuit are not supported on the ancillas, the can be done in parallel to the first and last steps of the non-Clifford rotations, such that this physical distillation unit requires $5 + 10 dot.op 4 + 1 = 46$ physical time steps.
  ]
)
<fig-distillation-circuits-1>



// [figvision-cn] imgs/Picture7.png
// 该图展示了一个基于Majorana量子比特的Reed-Muller态制备
// 过程，采用15对1的蒸馏单元。图中每个方块代表一个物理
// Majorana量子比特或单瓦片补丁中的逻辑量子比特。步骤(a)
// 至(g)展示了使用右侧所示器件（适用于物理Majorana量子比
// 特和逻辑操作）制备Reed-Muller态的过程。灰色方块表示辅
// 助比特，蓝色方块表示参与操作的量子比特。 子图(a)： 类
// 型：示意图 布局：由多个正方形组成的十字形网格结构，中
// 心为3x3区域，上下左右各延伸出一个方块。 标注文字：部分
// 方块内标有字母“B”或“P”，颜色为紫色；其余方块为浅灰色或
// 深灰色。 连接关系：一条紫色折线连接了五个标记为“B”或“P
// ”的方块，路径从左上角开始，依次经过中间左侧、中心、右
// 下角、右上角。 趋势/结论：此图显示初始状态下的特定量子
// 比特被选中并连接，用于后续操作。 子图(b)： 类型：示意
// 图 布局：与(a)相同的十字形网格结构。 标注文字：部分方
// 块内标有字母“X”或“Z”，颜色为绿色；其余方块为浅灰色或深
// 灰色。 连接关系：无显式连接线，但通过位置暗示操作顺序。
// 趋势/结论：此图显示在特定位置应用了Pauli-X或Pauli-Z门
// 操作。 子图(c)： 类型：示意图 布局：与(a)相同的十字形
// 网格结构。 标注文字：部分方块内标有带圆圈的加号符号（⊕），
// 颜色为黑色；其余方块为浅灰色或深灰色。 连接关系：多条
// 黑色曲线连接不同的方块，形成复杂的网络结构。 趋势/结论：
// 此图显示了多量子比特纠缠操作，通过CNOT门实现。 子图(d)：
// 类型：示意图 布局：与(a)相同的十字形网格结构。 标注文
// 字：无内部标注，但有橙色箭头指示循环方向。 连接关系：
// 两个橙色箭头分别位于中心上方和下方，指示顺时针和逆时针
// 旋转。 趋势/结论：此图显示了某种循环或迭代操作，可能涉
// 及相位调整或状态更新。 子图(e)： 类型：示意图 布局：与
// (a)相同的十字形网格结构。 标注文字：无内部标注，但有橙
// 色箭头指示循环方向。 连接关系：两个橙色箭头分别位于中
// 心上方和下方，指示顺时针和逆时针旋转。 趋势/结论：此图
// 继续显示循环操作，可能是前一步骤的延续或变体。 子图(f)：
// 类型：示意图 布局：与(a)相同的十字形网格结构。 标注文
// 字：部分方块内标有带圆圈的加号符号（⊕），颜色为黑色；
// 其余方块为浅灰色或深灰色。 连接关系：多条黑色曲线连接
// 不同的方块，形成复杂的网络结构。 趋势/结论：此图显示了
// 另一组多量子比特纠缠操作，可能与(c)类似但连接方式不同。
// 子图(g)： 类型：示意图 布局：与(a)相同的十字形网格结构。
// 标注文字：部分方块内标有带圆圈的加号符号（⊕），颜色为
// 黑色；其余方块为浅灰色或深灰色。 连接关系：多条黑色曲
// 线连接不同的方块，形成复杂的网络结构。 趋势/结论：此图
// 显示了进一步的纠缠操作，完成整个制备过程的关键步骤。
// 子图(h)： 类型：示意图 布局：与(a)相同的十字形网格结构。
// 标注文字：部分方块内标有字母“T”，颜色为黄色；其余方块
// 为浅灰色或深灰色。 连接关系：无显式连接线，但通过位置
// 暗示操作顺序。 趋势/结论：此图显示在特定位置应用了T门
// 操作，用于引入非Clifford门效应。 子图(i)： 类型：示意
// 图 布局：与(a)相同的十字形网格结构。 标注文字：部分方
// 块内标有字母“X”，颜色为绿色；其余方块为浅灰色或深灰色。
// 连接关系：无显式连接线，但通过位置暗示操作顺序。 趋势/
// 结论：此图显示最终状态的量子比特配置，所有操作完成后得
// 到的结果。 右侧器件说明： 第一个器件：显示一个垂直的双
// 向箭头连接两个“B”标记的方块，旁边是一个包含多个“X”和“Z
// ”门的电路框，标注为“Pauli correction”。这表明需要进行
// Pauli修正操作以纠正错误。 第二个器件：显示一个水平双向
// 箭头连接一个带圆圈的加号符号和一个包含多个“X”和“Z”门的
// 电路框，同样标注为“Pauli correction”。这表示另一种形式
// 的Pauli修正操作。 第三个器件：显示两个弯曲的橙色箭头，
// 旁边是一个包含多个“X”、“Y”、“Z”门的复杂电路框，标注为“
// Pauli correction”。这表明更复杂的Pauli修正操作，可能涉
// 及多个轴上的旋转。 整体趋势/结论：该图详细描述了如何通
// 过一系列精心设计的操作步骤，利用特定的量子门和纠错机制，
// 成功制备出Reed-Muller态。每一步都清晰地展示了量子比特
// 的状态变化和操作细节，确保了最终态的正确性和稳定性。
#figure(image("imgs/Picture7.png", width: 100.0%),
  caption: [
    Reed-Muller state preparation 15-to-1 distillation units. Each of the 31 squares represents a physical Majorana qubit or a logical qubit in a one-tile patch. In steps (a-g), a Reed-Muller state is prepared, using the gadgets shown on the right, which are available for both physical Majorana qubits and logical operations. We consider the grey squares ancillas, and the blue squares are those qubits which have been set and acted upon and host the Reed-Muller state. A naive counting of these first seven steps requires $( 4 + 1 + 4 + 6 + 6 + 4 + 4 ) = 29$ physical time steps, however overlapping consecutive steps with disjoint support reduces this to 21 physical time steps. At the logical level, these seven steps require $( 2 + 0 + 2 + 2 + 2 + 2 + 2 ) = 12$ logical time steps. (h) Next a T gate is applied to all but one of the qubits in the Reed-Muller state. For physical qubits, this can be done directly in a single physical time step. For logical qubits, this is instead achieved by transferring a T state to one of the grey qubits, and applying a $Z Z$ measurement as in @fig-distillation-circuits-1\(b). As we do not account for the transfer time, this requires a single logical time step. (i) Finally, each of the qubits to which T gates had been applied are measured in the X basis, which takes a single physical time step, or zero logical time steps. The overall time for the physical distillation unit is therefore 21+1+1= 23 physical time steps, and for the logical distillation unit is 12+1+0=13 logical time steps.
  ]
)
<fig-distillation-circuits-2>



The overall output T states of a distillation factory $cal(D)$ are those output from its last round, and therefore have error rate


$ P_T ( cal(D) ) = Q_R . $


We estimate the run time and qubit requirements as:


$ tau ( cal(D) ) & = & sum_(r = 1)^R tau ( M_r ) ,\
n ( cal(D) ) & = & upright("max")_(r in ( 1 , 2 , dots.h R )) ( c_r n ( M_r ) ) , $


where $n ( M_r )$ is the number of qubits needed for a single copy of distillation unit $M_r$ and $c_r$ is the number of copies of the unit in round $r$. Each unit in a factory can fail, therefore the number of T states output by a factory is a random variable. We choose to address this by defining the number of output T states from the factory $M ( cal(D) )$ as follows:


$ M ( cal(D) ) & = & \# med upright("T states output in at least 99% of runs of") med cal(D) . $


In principle, many factories have $M ( cal(D) ) = 0$ according to this definition, which would occur for example if the final round consists of a single unit with an acceptance probability below 99\%. Therefore many of the distillation factories that we consider over-provision units so that after accounting for some units failing the required number of T states is passed on to the next round. We assume that such decisions are specified to our framework by setting the appropriate distillation factory parameters such as $R$, $c_r$ and choice of unit types for each round.


#figure(
  table(
    columns: 11,
    align: center,
    table.cell(rowspan: 2)[$P_T$], table.cell(align: center, colspan: 4)[round 1], table.cell(align: center, colspan: 4)[round 2], table.cell(align: center, colspan: 2)[resources],
    [unit], [qubits], [time], [copies], [unit], [qubits], [time], [copies], [qubits], [time],
    [], [15-to-1], [], [], [], [], [], [], [], [], [],
    [$5.6 dot.op 10^(- 11)$], [space-eff.], [3240], [46.8 $mu$s], [1], [], [], [], [], [3240], [46.8 $mu$s],
    [], [$( d = 9 )$], [], [], [], [], [], [], [], [], [],
    [], [15-to-1], [], [], [], [15-to-1], [], [], [], [], [],
    [$2.1 dot.op 10^(- 15)$], [space-eff.], [$16000 = 16 dot.op 1000$], [26 $mu$s], [16], [RM prep.], [10478], [57.2 $mu$s], [1], [16000], [83.2 $mu$s],
    [], [$( d = 5 )$], [], [], [], [$( d = 13 )$], [], [], [], [], [],
    [], [15-to-1], [], [], [], [15-to-1], [], [], [], [], [],
    [$5.51 dot.op 10^(- 13)$], [space-eff.], [$5760 = 16 dot.op 360$], [15.6 $mu$s], [16], [space-eff.], [4840], [57.2 $mu$s], [1], [5760], [72.8 $mu$s],
    [], [$( d = 3 )$], [], [], [], [$( d = 11 )$], [], [], [], [], [],
  ),
  caption: [T state distillation factories to target the required error rates for our three application examples with the (ns,~$10^(- 4)$) qubit parameter example.],
)
<tab-distillation-examples>


= COMPILATION FROM QIR TO THE PLANAR QUANTUM ISA
<app-cat-state>


The planar quantum ISA, consisting of the Clifford operations defined in @fig-logical-operations and non-Clifford T states distilled as described in @app-distillation-overhead, forms a set of basic instructions that is sufficient for universal quantum computation. Here we describe how the program expressed in QIR, is mapped to the instructions of the planar quantum ISA, which we refer to as back end compilation.


Here we describe the back end compilation scheme that we assume in this paper at a high level. Our compilation scheme is formed by combining sequential Pauli-based computation (SPC), as described in Ref.~@Litinski2019 and elaborated upon in Ref.~@Chamberland2021, with an approach to synthesize sets of diagonal non-Clifford unitaries in parallel, as was done in Ref.~@Beverland2022. We call this compilation scheme Parallel Synthesis Sequential Pauli Computation (PSSPC).


We assume that the input is a QIR program which has first been re-expressed as a sequence of Clifford layers and non-Clifford layers, which we refer to as the input circuit. A Clifford layer of the input circuit consists of a set of basic instructions, which are either Clifford unitaries, basis state preparations, or Pauli measurements. Non-Clifford layers of the input circuit require T states to implement, and include operations such as T gates, Toffoli gates, and single-qubit arbitrary angle rotations (where the angle is not an integer multiple of $pi / 4$) around either the X, Y or Z axis. The input circuit can be dynamic in the sense that the measurement outcomes in one Clifford layer can affect the instructions applied in subsequent layers of the input circuit. In the following description, we describe a compilation strategy which can be applied to compile a dynamic input circuit layer by layer#footnote[When estimating resources to implement a dynamic algorithm, we randomly pick outcomes of measurements in the algorithm such that each layer is specified for explicit analysis.] to produce an equivalent output circuit which is expressed in terms of the logical instruction set in @fig-logical-operations.


To orchestrate the execution of this algorithm, PSSPC performs the following circuit transformations (see @fig-sequential-Pauli-computation).

- #strong[Step 0.]--- We first re-express the input algorithm such that it consists of a sequence of Clifford layers and diagonal non-Clifford layers. This is straight-forward: a rotation around the X or Y axis can be converted by conjugation of a Clifford into a rotation around the Z axis $R_z ( theta ) = | 0 chevron.r chevron.l 0 | + e^(i theta) | 1 chevron.r chevron.l 1 |$. The Cliffords that are used to implement this transformation are then absorbed into the Clifford layers before and after the non-Clifford layer. Similarly, a Toffoli gate can be re-expressed as a CCZ gate with a Hadamard applied before and after on the target qubit.

- #strong[Step 1.]--- Delegating expensive operations to synthesis qubits to increase parallelism: Non-Clifford rotations $R_z ( theta )$ are frequently used in quantum algorithms, but are among the most resource intensive operations when we consider implementation costs. To improve algorithm performance, PSSPC seeks to delegate these operations to ancilla qubits, referred to as synthesis qubits. By delegating these operations, multiple rotations can be synthesized in parallel to increase the T consumption rate and improve algorithm runtime. As shown in @fig-sequential-Pauli-computation\(b), PSSPC first re-expresses rotation operations on algorithm qubits using ancillary synthesis qubits. To implement a rotation such as $R_z ( theta )$ on an algorithm qubit, it is first entangled with an ancilla by measuring a Pauli supported on both that qubit and the ancilla. Then a sequence of operations are performed on the ancilla to apply the rotation's phase using Clifford gates and also T gates. The phase is kicked back to the algorithm qubit by measuring out the ancilla and applying a Pauli correction to the algorithm qubit. All other diagonal non-Clifford unitaries (including the T gate and the CCZ) are applied similarly~(see Figure~20 in~@Beverland2022).

- #strong[Step 2.]--- Eliminating Clifford unitaries: After delegating the synthesis of rotations and Toffoli gates to ancillas, operations on the algorithm qubits are a series of Clifford unitaries and Pauli measurements. While these operations can be implemented using the instruction set in @fig-logical-operations, we can further optimize the circuit by eliminating Clifford unitaries. Clifford unitaries map Pauli operations to other Pauli operations. Using this property, PSSPC commutes each Clifford unitary through the subsequent Pauli operations. This transforms the local Pauli operations to multi-qubit Pauli measurements and Pauli corrections. This optimization allows us eliminate the Cliffords at the cost of executing multi-qubit Pauli measurements.


// [figvision-cn] imgs/Picture1.png
// 该图由四个子图（a、b、c、d）组成，展示了量子电路的逐步
// 变换过程。所有子图均包含多条平行的水平线，代表量子比特
// 线路；图中使用不同颜色的矩形框和符号表示量子门操作。
// 子图 (a) 标题为 "initial circuit"（初始电路）。 类型：
// 量子电路示意图。 布局：包含六条平行的水平黑线，代表六
// 个量子比特。底部有一个黄色长条区域标注为 "synthesis
// qubits"（合成量子比特），对应最下方的两条线。 元素描述：
// 左侧第一个橙色竖直矩形块跨越所有六条线，内部标注文字 "
// C1"。在第一条线上，该块之前有一个小的橙色方框，内部标
// 注 "Z"。 第二个橙色竖直矩形块跨越所有六条线，内部标注
// 文字 "C2"。在第二条线上，该块之前有一个蓝色小方块，内
// 部标注 "R1"。在第三条和第四条线上，分别有两个小的橙色
// 方框，内部均标注 "Z"。 第三个橙色竖直矩形块跨越所有六
// 条线，内部标注文字 "C3"。在第五条线上，该块之前有一个
// 蓝色小方块，内部标注 "R2"。在第六条线上，该块之前有一
// 个小的橙色方框，内部标注 "Z"。 在 C2 和 C3 之间，有一
// 个蓝色的双齿状门连接第五条和第六条线，内部标注 "CCZ"。
// 趋势/结论：展示了初始电路结构，其中交替出现 Clifford
// 层（橙色块 C1, C2, C3）和非 Clifford 层（蓝色块 R1, R2
// , CCZ）。 子图 (b) 标题为 "Step 1: Rotation by
// measurement"（步骤 1：通过测量进行旋转）。 类型：量子
// 电路示意图。 布局：与 (a) 类似，包含六条平行水平线和底
// 部的黄色 "synthesis" 区域。 元素描述： 左侧橙色块 "C1"
// 保持不变。其上方第一条线上的 "Z" 门保留。 原 "C2" 位置
// 变为空白，但在第二条线上出现一个蓝色方块 "Z"，并有一条
// 垂直蓝线连接到底部黄色区域的第一个 "X" 门。 底部黄色区
// 域内从左到右依次排列：一个带叉圆圈符号 "X"，一个蓝色方
// 块 "Z"，一个带叉圆圈符号 "X"，一个蓝色方块 "R1"，以及
// 另一个带叉圆圈符号 "X"。这些符号下方有括号标注 "
// synthesis"。 原 "R2" 位置保留。原 "CCZ" 门位置保留。
// 在 C2 和 C3 之间，第五条线上出现两个小的橙色方框 "Z"。
// 右侧橙色块 "C3" 保持不变。 趋势/结论：展示了将非
// Clifford 旋转 R1 委托给辅助量子比特并进行合成的第一步，
// 引入了 Pauli 测量和修正操作。 子图 (c) 标题为 "Step 2:
// eliminating Clifford C1"（步骤 2：消除 Clifford C1）。
// 类型：量子电路示意图。 布局：与 (a)、(b) 类似。 元素描
// 述： 最左侧的橙色块 "C1" 被替换为一个蓝色的竖直椭圆，
// 内部标注 "Pauli measurement"。该椭圆跨越所有六条线。其
// 上方第一条线上的 "Z" 门保留。 紧接着是一个蓝色的竖直矩
// 形块，跨越所有六条线，内部标注 "Pauli correction"。 再
// 往右是一个蓝色的竖直椭圆，内部标注 "Pauli measurement"，
// 跨越所有六条线。 随后是合并后的橙色块 "C1 C2"，跨越所
// 有六条线。 之后是蓝色块 "R2"、蓝色 "CCZ" 门、橙色块 "
// C3" 以及相应的 "Z" 门，与 (a) 中对应部分相同。 底部黄
// 色区域内的 "synthesis" 结构与 (b) 完全相同。 趋势/结论：
// 展示了通过 Pauli 测量和修正来消除初始 Clifford 层 C1
// 的过程。 子图 (d) 标题为 "Step 2: all Clifford
// unitaries eliminated"（步骤 2：所有 Clifford 幺正算符
// 被消除）。 类型：量子电路示意图。 布局：与前述子图类似，
// 但结构更为复杂。 元素描述： 最左侧是一个大的蓝色竖直椭
// 圆，标注 "Pauli measurement"，跨越所有六条线。其上方第
// 一条线上的 "Z" 门保留。 紧接着是一个蓝色竖直矩形块，标
// 注 "Pauli correction"。 随后是三个连续的蓝色竖直椭圆，
// 均标注 "Pauli measurement"，每个都跨越所有六条线。 在
// 这三个测量椭圆之后，是一个蓝色竖直矩形块，标注 "Pauli
// correction"。 最后是一个蓝色竖直椭圆，标注 "Pauli
// measurement"。 底部黄色区域被划分为三个时间段，用双向
// 箭头标示： 第一段："time synthesis"，对应左侧的 "Pauli
// measurement" 和 "Pauli correction"。 第二段："time
// measurements"，对应中间的三个 "Pauli measurement" 椭圆。
// 第三段："time synthesis"，对应右侧的 "Pauli correction
// " 和最后的 "Pauli measurement"。 趋势/结论：展示了最终
// 状态，所有原始的 Clifford 层（C1, C2, C3）均已被一系列
// Pauli 测量和修正操作所取代，整个电路被分解为合成和测量
// 阶段。
#figure(image("imgs/Picture1.png", width: 95.0%),
  caption: [
    (a) The initial circuit consists of alternating Clifford (orange) and diagonal non-Clifford layers (blue). For illustrating the principles behind PSSPC, we show the implementation details for the first non-Clifford (the single rotation $R_1$ between Clifford unitaries $C_1$ and $C_2$), but the concepts extend to parallel distinct rotations. (b) $R_1$ is delegated to an ancilla qubit, where the operation is synthesized using T states and the phases are kicked back to the algorithm qubit. (c) $C_1$ is eliminated by commuting it through the Pauli operations that follow it, transforming them into multi-qubit Pauli operations. (d) After eliminating all Clifford unitaries, the circuit consists of a sequence of Pauli measurements and Pauli corrections, along with synthesis on ancilla qubits. For the second set of non-Cliffords (between $C_2$ and $C_3$ in the input circuit), we have a series of Pauli measurements and synthesis, followed by a final Pauli correction after synthesis and then the Pauli measurements from the original circuit. We assume that the Pauli correction for the current non-Clifford layer is completed before moving on to the next layer.
  ]
)
<fig-sequential-Pauli-computation>



Like SPC, a major benefit of PSSPC is that all Clifford unitaries in the input algorithm are eliminated and do not need to be applied. SPC differs from PSSPC by synthesizing the non-Clifford gates in place rather than in external ancillas, and the Ts resulting algorithm which has the drawback of serializing all T gates in the circuit. This drawback is partially overcome by PSSPC by parallelizing the synthesis of rotations which appear in the same layer of the input circuit, but the phase kickback of the synthesized rotations within a layer is still serial. Other layout and compilation approaches have been proposed~@JavadiAbhari2017 @Lao2018 @Steiger2018 @Murali2019 @Zulehner2019 @Childs2019 @Beverland2022 @Leung2010 @Hahn2019 @Beaudrap2020a, but are more involved to implement and analyze in detail.


We estimate the resources required to implement an algorithm using PSSPC in terms of the following parameters of the input algorithm. Let $Q_(upright("alg"))$ be the number of logical qubits used by the algorithm. Let $M_R$ be the number of single-qubit rotations, $M_T$ be the number of T gates, and $M_(upright("Tof"))$ be the number of Toffoli gates, and $M_(upright("meas"))$ be the number of Pauli measurements of the input algorithm. Let $D_R$ be the number of non-Clifford layers in which there is at least one arbitrary angle rotation (note this can be smaller than the total number of non-Clifford layers since it excludes those layers consisting entirely of T gates and Toffoli gates). Let the target error budget for synthesis in the overall program be $epsilon.alt_(upright("syn"))$ (measured in the diamond norm).


We assume the fast block layout from Ref.~@Litinski2019 (also shown in @fig-compilation-cat-state-layout), such that each pair of algorithm qubits is stored in a two-tile surface code patch, surrounded by ancilla tiles which can be used to measure an arbitrary Pauli operator on the algorithm qubits in one logical time step. This results in the number of logical qubits#footnote[More precisely, $Q$ is the number of tiles, some of which are allocated to ancillas, and some of which are allocated to store algorithm qubits in two-tile patches.] $Q$ given by


$ Q = 2 Q_(upright("alg")) + ⌈sqrt(8 Q_(upright("alg")))⌉ + 1 . $<eq-logical-qubits>


We account for the resources required for distillation separately in @app-resource-estimates, and in this section we assume that T states are produced on command and simply count how many T states are needed to implement the algorithm.


// [figvision-cn] imgs/Picture2.png
// 该图是一张量子计算机整体布局的示意图，展示了采用PSSPC
// 布局的量子比特排布。图像左侧为功能区域标注，右侧为网格
// 化的量子比特阵列，右下角附有图例说明颜色含义。 子图a（
// 即整张图）： 类型：示意图。 布局：图像分为左右两部分。
// 左侧包含两个黄色矩形区域，分别标注“synthesis”和“
// distillation”；右侧是一个由12列×6行共72个方格组成的规
// 则网格，其中部分方格填充紫色或灰色。 左侧区域： “
// synthesis”区域位于左上角，为一个实心浅黄色矩形，占据第
// 1–2行、第1–3列的位置（以整个网格坐标系计），内部居中黑
// 色文字“synthesis”。 “distillation”区域位于左下角，为一
// 个带斜线填充的浅黄色矩形，占据第3–6行、第1–4列的位置，
// 内部居中黑色文字“distillation”。 右侧网格区域： 网格共
// 12列（从左至右编号1–12）、6行（从上至下编号1–6）。 紫
// 色矩形块：每个紫色块垂直跨越2行、水平占1列，代表一对算
// 法量子比特（pair of algorithm qubits），编码于表面码或
// Hastings-Haah码的双瓦片补丁中。具体位置如下： 第1列：
// 行1–2、行3–4、行5–6 → 三个紫色块 第3列：行1–2、行3–4、
// 行5–6 → 三个紫色块 第5列：行1–2、行3–4、行5–6 → 三个紫
// 色块 第7列：行1–2、行3–4、行5–6 → 三个紫色块 第9列：行
// 1–2、行3–4、行5–6 → 三个紫色块 第11列：行1–2、行3–4、
// 行5–6 → 三个紫色块 总计18个紫色块，对应18对算法量子比
// 特。 灰色方块：每个灰色方块占1行×1列，代表辅助瓦片（
// ancilla tile），用于多量子比特泡利测量。其余未填充紫色
// 的格子均为灰色，共计72 – 18 = 54个灰色方块。 图例（位
// 于右下角）： 一个紫色竖条旁标注：“pair of algorithm
// qubits” 一个灰色小方块旁标注：“ancilla tile (for
// multi-qubit Pauli measurements)” 趋势与结论：该布局将
// 逻辑量子比特（紫色）集中排列在右侧网格中，形成周期性结
// 构，便于执行表面码纠错；左侧独立划分出合成（synthesis）
// 与蒸馏（distillation）功能区，表明系统预留专用资源用于
// T态制备与纯化，支持容错量子计算所需非Clifford门操作。
// 整体体现模块化设计思想，兼顾算法执行与资源管理需求。
#figure(image("imgs/Picture2.png", width: 100%),
  caption: [
    Overall layout of qubits in the quantum computer, using the PSSPC layout. The main block of logical qubits is purple and grey. Each purple rectangle denotes a pair of algorithm qubits encoded in a two-tile patch of surface or Hastings-Haah code, while the grey boxes are tiles of ancillas to facilitate multi-qubit Pauli measurements. A block of qubits is dedicated for distilling T states which are used to apply T gates and Toffolis, or are passed on to the synthesis block to synthesize rotations. We neglect the qubits needed for synthesis. In the overall program, we use $Q$ to denote the number of tiles in the main block, $M$ to denote the number of T states that are produced, and $C$ to denote the number of logical time steps needed to run the program.
  ]
)
<fig-compilation-cat-state-layout>



Synthesizing a single-qubit rotation to diamond-norm accuracy $epsilon.alt'$ re-expresses the unitary as Cliffords and at most $R_T ( epsilon.alt' )$ non-Clifford T gates, where


$ R_T ( epsilon.alt' ) = ⌈A log_2 ( 1 / epsilon.alt' ) + B⌉ , $<eq-T-count-synthesis>


for constants $A$ and $B$. We assume the Clifford+T synthesis in Table 1 of Ref.~@Kliuchnikov2022, which results in $A = 0.53$ and $B = 5.3$.#footnote[For simplicity, we use this formula for all single-qubit arbitrary angle rotations, and do not distinguish between best, worst and average cases. We also do not incorporate further improvements from~@Kliuchnikov2022 that use Clifford+$sqrt(upright(T))$ synthesis and known improvements for special cases, for example when many rotations are applied in parallel with the same angle~@Gidney2018halvingcostof.] To meet the accuracy requirement for the overall algorithm, which involves $M_R$ single-qubit rotations, we set $epsilon.alt' = epsilon.alt_(upright("syn")) / M_R$.


As described in @fig-sequential-Pauli-computation\(d), the computation proceeds in layers. Each diagonal non-Clifford unitary is applied as part of a layer of non-Clifford rotations from the input circuit. The first step to implement such a unitary is to couple the algorithm qubits to the synthesis ancilla qubits. This requires one multi-qubit Pauli measurement for each algorithm qubit in the support of the unitary. Therefore one logical time step is used for a T gate or a single-qubit rotation $R_z ( theta )$, while each Toffoli requires three logical time steps. We assume that T gates and CCZ gates require no additional synthesis time beyond the time required for these measurements, justified by techniques in Ref.~@Gidney2019 @Haner2022. To estimate the time required to synthesize an arbitrary angle rotation $R_z ( theta )$, we note that the synthesis consists of $R_T ( epsilon.alt_(upright("syn")) / M_R )$ non-Clifford T gates interleaved with Clifford unitaries. We assume this can be implemented by a sequence of $R_T ( epsilon.alt_(upright("syn")) / M_R )$ Pauli measurements supported on the synthesis ancilla and other ancillas to which the T states are delivered from distillation factories, taking $R_T ( epsilon.alt_(upright("syn")) / M_R )$ logical time steps. The final step to implement a rotation, after the synthesis has finished, is to apply a measurement of the ancilla and then a Pauli correction to the algorithm qubits, both of which can be done instantaneously.


The time required to implement a non-Clifford layer depends on whether the layer consists entirely of Toffoli and T gates, or whether it also contains some arbitrary angle rotations. In the former case, the number of logical time steps required is simply the number of measurements needed to entangle the algorithm and synthesis ancillas. In the latter case, in addition to the time needed for these entangling measurements, one also needs to add the time for synthesis. It is possible to further compress this by overlapping synthesis for one non-Clifford layer with the measurements for the following Clifford and non-Clifford layers, but for simplicity we assume that consecutive layers are executed sequentially without overlap. Within each layer however, the synthesis of rotations that were parallel in the input quantum IR circuit is performed in parallel. Since all Clifford unitaries in the Clifford layer are eliminated, the time required for the Clifford layer is simply the time required to implement the measurements it contains. The total number $C_(upright("min"))$ of logical time steps is therefore


$ C_(upright("min")) = ( M_(upright("meas")) + M_R + M_T ) + ⌈A log_2 ( M_R / epsilon.alt_(upright("syn")) ) + B⌉ D_R + 3 M_(upright("Tof")) . $<eq-logical-timesteps>


Note that this is our estimate of the number of logical time steps that would be needed if the T state factories produce T states at a sufficient rate so as to not limit the algorithm speed. In practice, the time $C gt.eq C_(upright("min"))$, and one could increase $C$ to slow the algorithm down if for example it puts a strain on the qubit resources available to produce T states.


Finally, using Eq.~(@eq-T-count-synthesis) and noting that four T states are sufficient to implement Toffoli, the number of T states $M$ is given by


$ M = ⌈A log_2 ( M_R / epsilon.alt_(upright("syn")) ) + B⌉ M_R + 4 M_(upright("Tof")) + M_T . $<eq-number-T-states>


We neglect the ancilla qubits used for unitary synthesis and those that would be required to transport the T states from distillation factories to where they are consumed for synthesis.


= PUTTING THE PIECES TOGETHER TO ESTIMATE RESOURCES OF AN ALGORITHM
<app-resource-estimates>


This appendix puts together components described over previous appendices in order to estimate the resources required to implement a high-level language quantum algorithm on a specified fault-tolerant architecture. After compilation of the algorithm to the instruction set described in @fig-logical-operations, the problem reduces to estimating the resources required to implement a circuit with $Q_(upright("alg"))$ algorithm qubits, with $M_R$ single-qubit rotations spread among $D_R$ layers, $M_T$ T gates, and $M_(upright("Tof"))$ Toffoli gates. Furthermore, let $1 - epsilon.alt$ be the desired probability that the overall algorithm succeeds.#footnote[More formally, $epsilon.alt$ is the total variational distance between the probability distribution of the final output bit strings of the compiled circuit and the algorithm circuit. Commonly, the circuits correspond to channels and the required total variational distance can be bounded using the diamond norm distance between the compiled channel and algorithm's channel as explained in Appendix~B in~@Kliuchnikov2022.]


The value of $epsilon.alt$, which we refer to as the #emph[error budget], depends on how the samples from algorithm instances are to be post-processed, and its value is set by taking the desired algorithm execution accuracy to be $1 - epsilon.alt$. For example, if one is running Shor's algorithm for factoring integers, a large value of $epsilon.alt$ may be tolerated as one can check that the output are indeed the prime factors of the input. On the other hand, a much smaller $epsilon.alt$ may be needed for an algorithm solving a problem with a solution which cannot be efficiently verified. For the target architecture, we assume that a specific physical qubit model and quantum error correction scheme has been chosen from @app-noise and @app-logical-operations-details. The target architecture implements the logical instruction set described in @fig-logical-operations.


To achieve the required algorithm success probability, we require that


$ epsilon.alt_(upright("log")) + epsilon.alt_(upright("dis")) + epsilon.alt_(upright("syn")) lt.eq epsilon.alt , $<eq-error-budget>


where $epsilon.alt_(upright("log"))$, $epsilon.alt_(upright("dis"))$ and $epsilon.alt_(upright("syn"))$ are the probabilities of at least one logical failure, at least one faulty T distillation, and at least one failed rotation synthesis respectively. In our estimates, we retain only the first order terms in these small probabilities. We ensure Eq.~(@eq-error-budget) is satisfied by requiring that each of $epsilon.alt_(upright("log"))$, $epsilon.alt_(upright("dis"))$ and $epsilon.alt_(upright("syn"))$ are at most $epsilon.alt / 3$.


We assume the PSSPC compilation strategy from @app-cat-state, which sets the number of logical qubits $Q$ and the number of T states consumed $M$. This also specifies a minimum possible logical runtime of the algorithm $C_(upright("min"))$. In what follows we establish the code distance $d$ required for error correction, the choice of distillation factory $cal(D)$, the number of distillation factories $F$, and the number of logical time steps $C$. We then use these to identify the number of physical qubits $q$ and runtime $t$.


Before computing these quantities, let's consider the need to balance the speed of the algorithm vs. the rate of T state production. From @app-cat-state, we know that the algorithm requires at least $C_(upright("min"))$ time steps. That is, we are free to run the algorithm at any desired speed by choosing $C gt.eq C_(upright("min"))$. Similarly, we are allowed to choose the number of factories $F$ and control how many T states are available for the algorithm per logical time step. However, we require that for any chosen value of $C$, $F$ must be chosen large enough to produce all the required T states for the algorithm within $C$ time steps. Therefore, with large $C$, as we slow down the algorithm, we can afford to reduce the number of T factories and save qubits required for their implementation#footnote[Note that slowing down the algorithm may not always result in a reduction in overall qubit counts. As the algorithm is slowed down, we can use lesser T factories and incur less qubit overhead for them. But for the algorithm's logical qubits, the code distance depends on the number of logical time steps (see Eq.~(@eq-distance-required)). We may require a higher code distance to protect the algorithm qubits during a slower execution]. Similarly, as we speed up the algorithm to finish in the least number of logical time steps possible, we require a large number of T factories to quickly supply the required T states, and incur higher qubit overheads. To navigate this space-time tradeoff, we fix a scenario such as space-optimal or time-optimal or an intermediate case and choose suitable values for $C$ and $F$. In what follows, we present the analysis for the general case where some $C gt.eq C_(upright("min"))$ has been selected.


#strong[Estimating resources for logical operations:] We determine the number of physical qubits and time required for the logical operations by selecting an appropriate code distance used for the logical qubits. From Eq.~(@eq-logical-error-rate-formula), we see that $d = 2 log ( a / P ) / log ( p^(*) / p ) - 1$ for constants $a$ and $p^(*)$ that depend on the type of physical qubit chosen in the architecture. Seeking the smallest error correction overhead that achieves an acceptably low probability that logical failure occurs in the implementation of the algorithm, i.e., that $Q C P = epsilon.alt_(upright("log")) lt.eq epsilon.alt / 3$, we select the following distance,


$ d = ⌈frac(2 log ( a epsilon.alt / ( 3 Q C ) ), log ( p^(*) / p )) - 1⌉_(upright("odd")) . $<eq-distance-required>


We then obtain the physical run time by multiplying the number of logical time steps $C$ by the time per logical time step $tau ( d )$ as defined in @app-logical-operations-details,


$ t = tau ( d ) C . $<eq-logical-time>


Similarly, the number of physical qubits required for the logical operations is $Q n ( d )$. Note that the code distance is a function of $C$. If $C$ is chosen to be much higher than $C_(m i n)$ to reduce the number of factories, we may require a higher code distance to protect the algorithm qubits for the longer execution duration.


#strong[Estimating resources for T distillation:] Next, we determine $cal(D)$, the number of factories and the physical resources required for distillation. Towards this, we first require the number of T states required by the algorithm at the given error budget. That is, we need to satisfy Eq.~(@eq-number-T-states) with $epsilon.alt_(upright("syn")) lt.eq epsilon.alt / 3$, which allows us to calculate $M$, the minimum number of T states required. Next, we determine the quality of these T states. In @tab-hardware-examples, we show the number of physical qubits $n ( cal(D) )$ and the time $tau ( cal(D) )$ to distill a single T state with error rate $P_T$ with various choices of distillation factory $cal(D)$. As we aim for the $M$ injected T states to fail with low probability, we require that $M P_T ( cal(D) ) = epsilon.alt_(upright("dis")) lt.eq epsilon.alt / 3$. Given a list of all the considered factories with the specified hardware type $( cal(D)_1 , cal(D)_2 , cal(D)_3 , dots.h , cal(D)_m )$, we therefore select $cal(D)$ as the factory with the smallest space-time footprint which satisfies this inequality, i.e.,


$ cal(D) = "arg min"_(cal(D)_i in ( cal(D)_1 , cal(D)_2 , cal(D)_3 , dots.h , cal(D)_m )) { n ( cal(D)_i ) tau ( cal(D)_i ) | P_T ( cal(D)_i ) lt.eq epsilon.alt / 3 M } . $<eq-select-factory>


Finally, the smallest number $F$ of distillation factories capable of producing the demanded $M$ T states during the algorithm's run time is selected


$ F = ⌈frac(M dot.op tau ( cal(D) ), M ( cal(D) ) dot.op t)⌉ . $


At this point a check should be made to ensure that the factories execute during the runtime of the algorithm, i.e., that $tau ( d ) C gt.eq tau ( cal(D) )$. This catches the case when the runtime of an algorithm is less than the runtime of a single T factory. If this is not satisfied, $C$ should be increased and the analysis repeated.


#strong[Total resources:] The total number of qubits $q$ for the quantum computation is then found from adding those qubits for distillation to those required to build the logical qubits,


$ q = F n ( cal(D) ) + Q n ( d ) . $<eq-total-physical-qubits>


The total runtime of the algorithm is given by Eq.~(@eq-logical-time).


= APPLICATIONS
<app-applications>


Here we provide further details of the three example applications, and the calculations that result in the resource estimates in @tab-physical-and-logical-overhead.


Before getting into specifics about each of three application examples, we make a remark about quantum algorithm sampling. Throughout this work, we are focused on the resources required to implement a full quantum algorithm once, however it is often the case that quantum algorithms must be repeated (even when run perfectly). This is because the output of some quantum algorithms is not a deterministic bit string, but instead is a drawn from a probability distribution over bit strings, and the information from the algorithm may require learning details of the distribution, requiring a set of samples. We do not account for the resource costs that algorithms may need to be sampled many times in this work. This could in principle be achieved by either re-running the algorithm consecutively on the available quantum computer, or by having many independent quantum computers running in parallel, or some combination.


#strong[Quantum dynamics].--- Here we outline the calculation that produced the resource requirements of the quantum dynamics example in @tab-physical-and-logical-overhead, following the approach in Ref.~@Pearson2020. We are interested in the time evolution $e^(- i H t)$ by the 2D $sqrt(N) times sqrt(N)$ transverse field Ising Hamiltonian


$ H = underbrace(- J sum_(chevron.l j , k chevron.r) Z_j Z_k, A) + underbrace(g sum_j X_j, B) $


with nearest-neighbour interactions is accomplished using fourth-order product formulas. Trotter & Suzuki~@Hatano2005TrotterSuzuki define a recursive construction using


$ U_2 ( Delta ) & = e^(- i A Delta / 2) e^(- i B Delta) e^(- i A Delta / 2) = e^(- i H Delta) + cal(O) ( Delta^3 ) ,\
U_4 ( Delta ) & = U_2 ( gamma Delta ) U_2 ( gamma Delta ) U_2 ( ( 1 - 4 gamma ) Delta ) U_2 ( gamma Delta ) U_2 ( gamma Delta ) = e^(- i H Delta) + cal(O) ( Delta^5 ) ,\
gamma & = ( 4 - 4^(1 / 3) )^(- 1) . $<eq-TrotterFourthOrder>


When applying $T > 1$ time steps steps, the first and last terms may be merged, leading to $10 T + 1$ exponentials in~Eq.~(@eq-TrotterFourthOrder). Note that $A$ and $B$ may be interchanged depending on which is more expensive. These product formulas reduce the resource costs of quantum dynamics to evaluating the resource cost of applying $e^(- i A Delta)$ and $e^(- i B Delta)$. All terms in $A$ commute and similarly for $B$, and $e^(- i B Delta)$ is the product of $N$ single-qubit rotations $product_j e^(- i X_j g Delta)$. The simulation can be carried out by assigning a qubit to each of the $N$ sites in the lattice, such that $Q_(upright("alg")) = N$. By conjugating with a CNOT gate, each nearest-neighbour $Z_j Z_k$ term is transformed in to a single-qubit Pauli $Z_j$. Thus $e^(- i A Delta)$ can be implemented by eight depth-1 layers of $N / 2$ CNOT gates and four depth-1 layers of $N / 2$ single qubit rotations $product_j e^(i Z_j J Delta)$. The number of rotations is therefore $M_R = ( 5 T + 1 ) N + 10 T N = ( 15 T + 1 ) N$. Finally, the depth of the rotation gates over the $T$ time steps is $D_R = 5 T + 1 + 4 ( 5 T ) = 25 T + 1$.


In the example we consider, we take $epsilon.alt = 0.001$, $N = 100$ and $T = 20$ such that when the algorithm, which is initially written as a Q\# program, is explicitly compiled down to a QIR-level program with $Q_(upright("alg")) = 100$, $M_R = 30100$, $M_T = 0$, $M_(upright("Tof")) = 0$ and $M_(upright("meas")) = 1400000$ and $D_R = 501$. From Eq.~(@eq-logical-qubits), Eq.~(@eq-logical-timesteps) and Eq.~(@eq-number-T-states), we calculate that with the PSSPC compilation and layout, the ISA-level executable that this QIR program would compile down to has $Q = 230$ logical qubits, which are needed for at least $C_(upright("min")) = 1.5 dot.op 10^5$ logical time steps, consuming $M = 2.4 dot.op 10^6$ T states.


At the physical level, here we illustrate the analysis with the (ns,~$10^(- 4)$) qubit example (with the other qubit parameter examples being analyzed analogously). In this example we will ultimately increase $C$ so that it is significantly larger than $C_(upright("min"))$ to reduce the qubit count as a trade-off paid for by an increase in run time. To see why we do so, let us first consider the case where $C = C_(upright("min"))$. We use Eq.~(@eq-distance-required) to find the distance $d = 9$, such that $n ( d ) = 2 d^2 = 162$ and $tau ( d ) = ( 4 t_(upright("gate")) + 2 t_(upright("meas")) ) d = 400$ ns. This sets the algorithm run time via Eq.~(@eq-logical-time) to be $t =$ 0.55 s. From Eq.~(@eq-select-factory), a distillation factory is selected. There are $F = 199$ factories. Each factory has a single round of logical distillation (15-to-1 space efficient), with one unit of code distance 9. Each factory produces $M ( cal(D) ) = 1$ encoded T state with error rate $5.6 dot.op 10^(- 11)$, and contains $n ( cal(D) ) = 3240$ physical qubits, and requires $tau ( cal(D) ) = 46.8 med mu$s to run. The total number of physical qubits using is then Eq.~(@eq-total-physical-qubits) is $q =$ 0.68M, with distillation accounting for $94.5 "%"$ of these qubits.


Because of the very high fraction of qubits allocated to distillation when $C = C_(upright("min"))$, we consider a slowed down version of the algorithm where we set $C = 10 C_(upright("min"))$, therefore easing the requirement on the number of T factories required. With the (ns,~$10^(- 4)$) qubit example, we use Eq.~(@eq-distance-required) to find the distance increases to $d = 11$ since the logical qubits need to be protected for longer. The number of physical qubits per logical qubit is therefore $n ( d ) = 2 d^2 = 242$ and $tau ( d ) = ( 4 t_(upright("gate")) + 2 t_(upright("meas")) ) d = 4.4 med mu$s. This increases the algorithm run time via Eq.~(@eq-logical-time) to be $t =$ 6.78 s. Precisely the same factory is selected, namely a single round of logical distillation (15-to-1 space efficient), with one unit of code distance 9. Each factory produces $M ( cal(D) ) = 1$ encoded T state with error rate $5.6 dot.op 10^(- 11)$, and contains $n ( cal(D) ) = 3240$ physical qubits, and requires $tau ( cal(D) ) = 46.8 med mu$s to run. However, now only $F = 17$ factories are required. The total number of physical qubits using is then Eq.~(@eq-total-physical-qubits) drops to $q =$ 0.11M, with distillation accounting for $49.7 "%"$ of these qubits.


#strong[Quantum chemistry].--- We assume the so-called 'double-factorized qubitization' algorithm described in Ref.~@vonBurg2021 @Low2022Halving is used. The #emph[qubitization] approach is based on quantum phase estimation, but instead of constructing the standard $U = exp ( - i H / alpha )$ from the Hamiltonian matrix $H$, one instead takes $U approx exp ( - i sin^(- 1) ( H / alpha ) )$, which can typically be implemented with fewer resources by qubitization~@Low2019Qubitization. Using #emph[double-factorization], the naive representation of $H$ is compressed into fewer terms and also with a smaller $alpha$.


We take $epsilon.alt = 0.01$. The algorithm, initially expressed as a Rust program, is explicitly compiled down to a QIR-level program with $Q_(upright("alg")) = 1318$ logical qubits with $M_T = 5.53 dot.op 10^7$, $D_R = 2.05 dot.op 10^8$, $M_R = 2.06 dot.op 10^8$, $M_(upright("Tof")) = 1.35 dot.op 10^11$ and $M_(upright("meas")) = 1.37 dot.op 10^9$. From Eq.~(@eq-logical-qubits), Eq.~(@eq-logical-timesteps) and Eq.~(@eq-number-T-states), we calculate that with the PSSPC compilation and layout, the ISA-level executable that this QIR program would compile down to has $Q = 2740$ logical qubits, which are needed for at least $C_(upright("min")) = 4.10 dot.op 10^11$ logical time steps, consuming $M = 5.44 dot.op 10^11$ T states. We set $C = C_(upright("min"))$.


At the physical level, here we illustrate the analysis with the (ns,~$10^(- 4)$) qubit example (with the other qubit parameter examples being analyzed analogously). We use Eq.~(@eq-distance-required) to find the distance $d = 17$, such that $n ( d ) = 578$ and $tau ( d ) = 6.8 mu$s. This sets the algorithm run time via Eq.~(@eq-logical-time) to be $t =$ 1 month and one day. From Eq.~(@eq-select-factory), the following distillation factory is selected: There are $F = 17$ factories. Each factory has two rounds of logical distillation, with 16 units of code distance 5 (15-to-1 space-eff.) in the first round and 1 unit of code distance 13 (15-to-1 RM prep.) in the second round. Each factory requires $n ( cal(D) ) = 16000$ physical qubits, $tau ( cal(D) ) =$ 83.2 $mu$s run time, and produces $M ( cal(D) ) = 1$ encoded T states with error rate $2.13 dot.op 10^(- 15)$. The total number of physical qubits using Eq.~(@eq-total-physical-qubits) is $q = 1.86$M.


#strong[Factoring].--- We use a custom optimized implementation of Shor's algorithm~@Shor1994. We follow the logical algorithm implementation in Ref.~@Gidney2021, applying all of their optimizations (including coset representation, windowing over exponents and multiplicands, iterative phase estimation), except that we do not implement carry runways. As an input number to factorize, we use the RSA-2048 number from the RSA factoring challenge~@Kaliski1991, and set the trial generator to 7. Further, we set both the windowing parameters $c_(upright("mul"))$ and $c_(upright("exp"))$ to 5.


First note that by the verifiable nature of the factoring problem, namely that once a solution has been found it can be easily verified, we can tolerate a large probability of the algorithm failing due to a logical fault since if the output is not valid the algorithm can be re-run. For this application example, we take $epsilon.alt = 1 / 3$.


In the example we consider of factoring a $2048$-bit integer, the algorithm is initially expressed as a Rust program, and is explicitly compiled down to a QIR-level program with $Q_(upright("alg")) = 12581$ algorithm qubits. Moreover, we find that $M_T = 12$, $D_R = 12$, $M_R = 12$, $M_(upright("Tof")) = 3.73 dot.op 10^10$ and $M_(upright("meas")) = 1.08 dot.op 10^9$. From Eq.~(@eq-logical-qubits), Eq.~(@eq-logical-timesteps) and Eq.~(@eq-number-T-states), we calculate that with the PSSPC compilation and layout, the ISA-level executable that this QIR program would compile down to has $Q = 25481$ logical qubits, which are needed for at least $C_(upright("min")) = 1.23 dot.op 10^10$ logical time steps, consuming $M = 1.49 dot.op 10^10$ T states.


At the physical level, here we illustrate the analysis with the (ns,~$10^(- 4)$) qubit example (with the other qubit parameter examples being analyzed analogously). We use Eq.~(@eq-distance-required) to find the distance $d = 13$, such that $n ( d ) = 2 d^2 = 338$ and $tau ( d ) = ( 4 t_(upright("gate")) + 2 t_(upright("meas")) ) d = 5.2 mu$s. This sets the algorithm run time via Eq.~(@eq-logical-time) to be $t =$ 17 hours 43 mins. From Eq.~(@eq-select-factory), a distillation factory is selected. There are $F = 18$ factories. Each factory has two rounds of logical distillation (both 15-to-1 space efficient), with 16 units of code distance 3 in the first round and 1 unit of code distance 11 in the second round, which produces $M ( cal(D) ) = 1$ encoded T state with error rate $5.51 dot.op 10^(- 13)$, and which contains $n ( cal(D) ) = 5760$ physical qubits, and requires $tau ( cal(D) ) =$ 72.8 $mu$s to run. The total number of physical qubits using Eq.~(@eq-total-physical-qubits) is then $q =$ 8.72M.


In the introduction, we state that factoring a 2048-bit integer using Shor's algorithm could be done in minutes with an array of twenty five thousand #emph[perfect, noiseless] qubits. This estimate is obtained by assuming that the perfect qubits replace the ISA-level logical qubits in @tab-application-examples. With perfect operations, there would be no need for distillation, and so the only cost would be the qubits $25481$ algorithm and ancilla qubits in the array. Taking the $1.2 dot.op 10^10$ logical time steps to be physical time steps, each lasting 100 ns, results in a run time of 20 mins.


= PRIMARY ASSUMPTIONS
<app-primary-assumptions>


Here we summarize our primary assumptions. These are the subset of assumptions which are not justified to our satisfaction in the current literature, and which we believe will significantly increase our resource estimates if relaxed.

+ #strong[Uniform independent physical noise].--- We assume that the noise on physical qubits and physical qubit operations is the standard circuit noise model. In particular we assume error events at different space-time locations are independent and that error rates are uniform across the system in time and space.

+ #strong[Efficient classical computation].--- We assume that classical overhead (compilation, control, feedback, readout, decoding, etc.) does not dominate the overall cost of implementing the full quantum algorithm.

+ #strong[Syndrome measurement circuits for planar quantum ISA].--- We assume that syndrome measurement circuits with similar depth and error correction performance to those for standard surface and Hastings-Haah code patches can be constructed to implement all operations of the planar quantum ISA (as specified in @fig-logical-operations).

+ #strong[Uniform independent logical noise].--- We assume that the error rate of a logical operation is approximately equal to its space-time volume (the number of tiles multiplied by the number of logical time steps) multiplied by the error rate of a logical qubit in a standard one-tile patch in one logical time step.

+ #strong[Negligible Clifford costs for synthesis].--- We assume that the space overhead for synthesis and space and time overhead for transport of T states within T state factories and to synthesis qubits are all negligible.

+ #strong[Smooth T state consumption rate].--- We assume that the rate of T state consumption throughout the compiled algorithm is almost constant, or can be made almost constant without significantly increasing the number of logical time steps for the algorithm.

#show bibliography: set text(size: 10pt)
#show bibliography: set par(leading: 0.52em, spacing: 0.52em)
#bibliography("refs.bib", style: "../../typst-refs/plain.csl", title: none)