#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: "CMU Serif", size: 10pt, lang: "en")
#set page(paper: "us-letter", margin: (left: 45.4pt, right: 45.4pt, top: 100pt, bottom: 96pt),
  header: [#context {
  let n = counter(page).get().first()
  if n > 1 { place(top + right, dx: 0pt, dy: 76.7pt)[#n] }
}])
#set heading(numbering: (..n) => {
  let p = n.pos()
  if p.len() == 1 { numbering("I.", p.at(0)) }
  else if p.len() == 2 { numbering("A.", p.at(1)) }
  else { numbering("1.", p.at(2)) }
})
#show heading.where(level: 1): set text(size: 9pt, weight: "bold")
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set block(above: 0.67em, below: 2.1em)
#show heading.where(level: 2): set text(size: 9pt, weight: "bold")
#show heading.where(level: 3): set text(size: 9pt, style: "italic")
#set par(justify: true, leading: 0.47em, spacing: 0.47em, first-line-indent: (amount: 1.2em, all: true))
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: bottom, separator: [. ])
#show figure.where(kind: table): set text(size: 8pt)
#show figure.where(kind: table): set par(leading: 0.62em)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)
#set math.equation(number-align: bottom)
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


#align(center)[
  #text(12pt, weight: "bold", [Does provable absence of barren plateaus imply classical simulability?])   #v(1.2em)
  #text(10pt)[M. Cerezo#super[1], Martin Larocca#super[3], Diego García-Martín#super[1], N. L. Diaz#super[1], Paolo Braccia#super[3], Enrico Fontana#super[6], Manuel S. Rudolph#super[7], Pablo Bermejo#super[8], Aroosa Ijaz#super[3], Supanut Thanasilp#super[7], Eric R. Anschuetz#super[12], Zoë Holmes#super[7]]
  
]
#v(9pt)
#align(center)[#block(spacing: 0.9pt)[
  #text(9pt)[#super[1]Information Sciences, Los Alamos National Laboratory, Los Alamos, NM 87545, USA] \
  #text(9pt)[#super[2]Quantum Science Center, Oak Ridge, TN 37931, USA] \
  #text(9pt)[#super[3]Theoretical Division, Los Alamos National Laboratory, Los Alamos, NM 87545, USA] \
  #text(9pt)[#super[4]Center for Nonlinear Studies, Los Alamos National Laboratory, Los Alamos, New Mexico 87545, USA] \
  #text(9pt)[#super[5]Departamento de Física-IFLP/CONICET, Universidad Nacional de La Plata, C.C. 67, La Plata 1900, Argentina] \
  #text(9pt)[#super[6]University of Strathclyde, Glasgow G1 1XQ, UK] \
  #text(9pt)[#super[7]Institute of Physics, Ecole Polytechnique Fédérale de Lausanne (EPFL), Lausanne CH-1015, Switzerland] \
  #text(9pt)[#super[8]Donostia International Physics Center, Paseo Manuel de Lardizabal 4, San Sebastián E-20018, Spain] \
  #text(9pt)[#super[9]Department of Physics and Astronomy, University of Waterloo, Ontario, N2L 3G1, Canada] \
  #text(9pt)[#super[10]Vector Institute, MaRS Centre, Toronto, Ontario, M5G 1M1, Canada] \
  #text(9pt)[#super[11]Chula Intelligent and Complex Systems, Department of Physics, \ Faculty of Science, Chulalongkorn University, Bangkok, Thailand, 10330] \
  #text(9pt)[#super[12]Institute for Quantum Information and Matter, Caltech, Pasadena 91125, USA] \
  #text(9pt)[#super[13]Walter Burke Institute for Theoretical Physics, Caltech, Pasadena 91125, USA] \
]]
#v(1.2em)









































#v(-7pt)
#align(center)[#block(width: 399pt)[
#set text(size: 9pt)
#set par(leading: 0.5em)
A large amount of effort has recently been put into understanding the barren plateau phenomenon. In this perspective article, we face the increasingly loud elephant in the room and ask a question that has been hinted at by many but not explicitly addressed: #emph[Can the structure that allows one to avoid barren plateaus also be leveraged to efficiently simulate the loss classically?] We collect evidence---on a case-by-case basis---that many commonly used models whose loss landscapes avoid barren plateaus can also admit classical simulation, provided that one can collect some classical data from quantum devices during an initial data acquisition phase. This follows from the observation that barren plateaus result from a curse of dimensionality, and that current approaches for solving them end up encoding the problem into some small, classically simulable, subspaces. Thus, while stressing that quantum computers can be essential for collecting data, our analysis sheds doubt on the information processing capabilities of many parametrized quantum circuits with provably barren plateau-free landscapes. We end by discussing the (many) caveats in our arguments including the limitations of average case arguments, the role of smart initializations, models that fall outside our assumptions, the potential for provably superpolynomial advantages and the possibility that, once larger devices become available, parametrized quantum circuits could heuristically outperform our analytic expectations.
]]




#v(29pt)
#columns(2, gutter: 15pt)[

= INTRODUCTION
<introduction>


In recent years, the initial excitement attracted by variational quantum algorithms~@cerezo2020variationalreview @bharti2021noisy @endo2021hybrid and quantum machine learning~@wiebe2014quantumdeep @schuld2015introduction @biamonte2017quantum @cerezo2022challenges @di2023quantum @abbas2023quantum has been tempered by the barren plateau phenomenon~@mcclean2018barren @larocca2024review @marrero2020entanglement @sharma2020trainability @patti2020entanglement @pesah2020absence @uvarov2020barren @cerezo2020impact @uvarov2020variational @wang2020noise @abbas2020power @arrasmith2021equivalence @larocca2021diagnosing @holmes2021connecting @cerezo2020cost @khatri2019quantum @zhao2021analyzing @liu2021presence @miao2023isometric @letcher2023tight @basheer2022alternating @suzuki2023effect @rudolph2023trainability @kieferova2021quantum @thanaslip2021subtleties @lee2021towards @shaydulin2021importance @holmes2021barren @leadbeater2021f @zhang2022escaping @martin2022barren @grimsley2022adapt @leone2022practical @sack2022avoiding @kashif2023impact @friedrich2023quantum @garcia2023deep @kulshrestha2022beinit @volkoff2021efficient @kashif2023unified @monbroussou2023trainability @cherrat2023quantum @fontana2023theadjoint @ragone2023unified @diaz2023showcasing @park2023hamiltonian @sannia2023engineered @thanasilp2022exponential @west2023provably @mao2023barren. Namely, there is a growing awareness that a large class of quantum learning architectures exhibit loss function landscapes that concentrate exponentially in system size towards their mean value. On such landscapes, exponential resources are required for training, prohibiting the successful scaling of variational quantum algorithms. Hence, identifying architectures and training strategies that provably do not lead to barren plateaus has become a highly active area of research. Examples of such strategies include shallow circuits with local measurements~@cerezo2020cost @pesah2020absence @khatri2019quantum @zhao2021analyzing @liu2021presence @miao2023isometric, dynamics with small Lie algebras~@larocca2021diagnosing @monbroussou2023trainability @cherrat2023quantum @fontana2023theadjoint @ragone2023unified @diaz2023showcasing @west2023provably @heredge2024prospects, identity initializations~@zhang2022escaping @park2023hamiltonian @wang2023trainability, embedding symmetries into the circuit's architecture~@larocca2022group @meyer2022exploiting @skolik2022equivariant @ragone2022representation @nguyen2022atheory @schatzki2022theoretical @zheng2021speeding @east2023all, adding non-unital noise or intermediate measurements~@sannia2023engineered @mele2024noise @fefferman2023effect @crognaletti2024estimates @deshpande2024dynamic, and certain classes of quantum generative models~@kieferova2021quantum @rudolph2023trainability @letcher2023tight.


However, these strategies all, in some sense, make use of some simple underlying structure of the problem. This provokes the question: #emph[Could the very same structure that allows one to provably avoid barren plateaus be leveraged to efficiently simulate the loss function classically?] Here we argue that the answer to this question is "Yes and No". Specifically, we argue and present strong evidence that a wide class of loss landscapes which provably do not exhibit barren plateaus can be simulated using either a classical algorithm or what we call a "quantum-enhanced" classical algorithm that runs in polynomial time. In the latter case, this simulation still necessitates the use of a quantum computer during an initial data acquisition phase~@huang2021power @elben2022randomized @huang2021information @gyurik2023exponential, but it does not require hybrid quantum-classical optimization loops. These arguments can be understood as a soft form of dequantization of the information processing capabilities of many variational quantum circuits in barren plateau-free landscapes.


Core to our argument is the observation that any loss based on evolving an initial state $rho$ through a parameterized quantum circuit $U ( bold(theta) )$ and then estimating the expectation value of an non-trivial observable $O$ can be written as an inner product between the Heisenberg evolved observable $U ( bold(theta) )^dagger O U ( bold(theta) )$ and the state $rho$. Given that both of these objects live in the exponentially large vector space of operators, one can generally expect this overlap to be --on average over $bold(theta)$-- exponentially small. This is the essence of the barren plateaus phenomenon---the curse of dimensionality. If, however, the evolved observable is confined to a polynomially large subspace, then the loss becomes the inner product between two objects in this reduced space and can therefore avoid barren plateaus. But, in this case one can also simulate the loss by representing the initial state, circuit, and measurement operator as polynomially large objects contained in, and acting on, the small subspace.


Our general argument is supported by an analysis of widely used schemes through which we show that all considered methods for avoiding barren plateaus can be efficiently classically simulated, as well as by recent works which explicitly perform the classical simulations~@bermejo2024quantum @angrisani2024classically @lerch2024efficient @anschuetz2024arbitrary @mele2024noise @shin2024dequantising @ermakov2024unified @miller2025simulation. Fundamentally, it is the very proof of absence of barren plateaus that allows us to identify the polynomially-sized subspaces in which the relevant part of the computation lives. Using this information, we can then determine the set of expectation values one needs to estimate (either classically or quantumly) to enable classical simulations. In the latter case the quantum computer is still essential, but is accessed non-adaptively to generate a #emph[classical surrogate] rather than via a hybrid optimization loop.


Given the potential for misunderstanding, let us first state a few caveats to our claims. Firstly, our argument applies to widely used models and algorithms that employ a loss function formulated as the expectation of an observable for a state evolved under a parametrized quantum circuit, as well as variants using measurements of this form followed by classical post-processing. This encompasses the majority of popular quantum architectures including most standard variational quantum algorithms, many quantum machine learning models and certain families of quantum generative schemes. However, it does not cover all possible quantum learning protocols.


Secondly, while for all our case studies it is possible to identify the ingredients necessary for simulation, we do not prove that this will always be possible. Thus, in principle, there could be models for which the landscape is free of barren plateaus, and yet we do not know how to simulate it. This could arise for sub-regions of a landscape which could be explored via smart initialization strategies, when the small subspace is otherwise unknown, or even when the problem lives in the full exponential space but is highly structured. Indeed, we provide an explicit (but highly contrived) construction for the latter and raise the possibility that more such cases might be found heuristically once larger quantum devices become available.


Finally, having identified these caveats, we present new opportunities and research directions that follow from our results. In particular, we discuss the potential offered by warm starts and the fact that even if polynomial-time classical simulation is available, the computational cost might still be too large, thus enabling potential polynomial advantages when running the variational quantum computing scheme on a quantum computer. More exotically, we suggest that by exploiting the structure of conventional fault-tolerant quantum algorithms, it might yet be possible to construct highly structured variational architectures for which superpolynomial quantum advantages can be realized.


= DEFINITIONS FOR BARREN PLATEAUS AND SIMULABILITY
<definitions-for-barren-plateaus-and-simulability>


Variational quantum computing algorithms encode a problem of interest into an optimization task. The standard approach is to train a parametrized quantum circuit to minimize a loss function that quantifies the quality of the solution~@cerezo2020variationalreview @bharti2021noisy @endo2021hybrid @wiebe2014quantumdeep @schuld2015introduction @biamonte2017quantum @cerezo2022challenges. These algorithms are hybrid computational models in the sense that they use quantum hardware to obtain an estimate of the loss and then leverage the power of classical optimizers to determine parameter updates for the next set of experiments.


In what follows, we will assume that the loss function takes the form


$ ell_(bold(theta)) ( rho , O ) = upright("Tr") [ U ( bold(theta) ) rho U^dagger ( bold(theta) ) O ] thin . $<eq:loss>


Here, $rho in cal(B)$ is an $n$-qubit input state belonging to the set of bounded operators $cal(B)$ acting on a $2^n$-dimensional Hilbert space $cal(H)$, $O in cal(B)$ is some non-trivial Hermitian operator (with $∥O∥_oo lt.eq 1$), $U ( bold(theta) )$ is the parametrized quantum circuit, and $bold(theta)$ is a set of trainable parameters. Losses of this form can be used to tackle a wide range of problems through different choices of $rho$, $O$ and $U ( bold(theta) )$. We note that while algorithms can employ more general loss functions that require computing multiple such quantities (e.g., by sending different states through the circuit, or by estimating the expectation value of several operators), we will focus on the fundamental case where the loss is given by Eq.~#ref(<eq:loss>, supplement: none), as the lessons derived here can be extrapolated to other scenarios.


To better understand and classify the problems we are focusing on, we find it convenient to define #emph[problems] specified by #emph[classes] $cal(C) = { cal(I) }$ of #emph[problem instances]. A problem instance $cal(I)$ is determined by an efficiently-sampleable parameter distribution $cal(P)$, and some efficient #emph[classical description] of $rho$, $U ( bold(theta) )$, and $O$ that can be used to estimate $ell_(bold(theta)) ( rho , O )$ on a quantum computer in polynomial time. These could be a quantum circuit that prepares $rho$ from some fiducial state, a dictionary of the gate types and placements in $U ( bold(theta) )$, and the Pauli decomposition of $O$. We assume that these descriptions can be encoded in a string of size in $cal(O) ( "poly" ( n ) )$.


For concreteness, let us consider an example of a problem class. Let $cal(C)_(upright("shallowHEA"))$ be the class of all instances where the circuit is a one-dimensional hardware efficient ansatz~@kandala2017hardware @cerezo2020cost composed of $L in cal(O) ( log ( n ) )$ layers of two-qubit gates acting on neighboring qubits in a brick-layered structure. Moreover, we take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state, and $O$ some Pauli operator that is diagonal in the computational basis (e.g., $O = Z^(⊗ n)$ or $O = Z_mu$ for some $mu in ( 1 , dots.h , n )$). Here, we further assume that all the gates in the circuit are parametrized, and every parameter is sampled uniformly at random.


Over the past few years, there has been a tremendous amount of work put forward to understand if the loss functions in a given problem class based on variational circuits are #emph[trainable] (and we refer the reader to Ref.~@gil2024relation for a subtle discussion of what trainable, or even variational, even means). Several sources of untrainability have been detected~@cerezo2022challenges such as the presence of sub-optimal local minima~@bittel2021training @fontana2022nontrivial @anschuetz2022beyond @anschuetz2021critical @larocca2021diagnosing and expressivity limitations~@tikku2022circuit. However, the vast majority of trainability analysis has been concentrated around the #emph[barren plateau] phenomenon~@larocca2024review @marrero2020entanglement @sharma2020trainability @patti2020entanglement @pesah2020absence @uvarov2020barren @cerezo2020impact @uvarov2020variational @wang2020noise @abbas2020power @arrasmith2021equivalence @larocca2021diagnosing @holmes2021connecting @cerezo2020cost @khatri2019quantum @zhao2021analyzing @liu2021presence @miao2023isometric @rudolph2023trainability @letcher2023tight @basheer2022alternating @suzuki2023effect @kieferova2021quantum @thanaslip2021subtleties @lee2021towards @shaydulin2021importance @holmes2021barren @leadbeater2021f @zhang2022escaping @martin2022barren @grimsley2022adapt @leone2022practical @sack2022avoiding @kashif2023impact @friedrich2023quantum @garcia2023deep @kulshrestha2022beinit @volkoff2021efficient @kashif2023unified @monbroussou2023trainability @cherrat2023quantum @fontana2023theadjoint @ragone2023unified @diaz2023showcasing @park2023hamiltonian @sannia2023engineered @thanasilp2022exponential @west2023provably @mao2023barren (see Ref.~@larocca2024review for a review on barren plateaus). When a problem exhibits a barren plateau, its loss function becomes---on average---exponentially concentrated with the system size~@mcclean2018barren @cerezo2020cost. We say a class $cal(C)$ of problems is #emph[provably barren plateau-free], i.e., $cal(C) in overline(upright("BP"))$, if one can show that


$ upright("Var")_(bold(theta) tilde cal(P)) [ ell_(bold(theta)) ( rho , O ) ] in Omega (frac(1, upright("poly") ( n ))) , $


for all loss functions $ell_(bold(theta)) ( rho , O )$ in the class $cal(C)$ of parameterized quantum circuits. Note that one can define a more general class of barren plateau-free problems where an explicit proof of absence of barren plateaus is not needed, but for now we will consider this restricted class.


Proving that certain types of problems are in $overline(upright("BP"))$ has recently become an active area of research. While such studies are extremely important, it is worth noting that just because the loss functions for a given problem are barren plateau-free does not mean that they are practically useful or that they can achieve a quantum advantage. For instance, one should wonder if the quantum computer is being employed in a meaningful way. That is, one would ideally like to show that beyond absence of barren plateaus, there exists no classical algorithm that can also efficiently compute the loss.


To better tackle this question, we then first need to define what it means to #emph[compute] a loss function, and also what we understand by #emph[classical simulability]. In particular, since the notion of barren plateaus is an average statement over the landscape, in this context the natural notions for computing and simulating the loss will also be average ones. However, stronger notions of simulability, such as one where one guarantees that the loss can be computed for all points on the landscape, will also be discussed below.


First, let us define the task of #emph[computing a loss function], such as that in Eq.~#ref(<eq:loss>, supplement: none), for a given problem. We will say that an algorithm can compute the loss functions in an instance $cal(I)$ if, with high probability $bold(theta) tilde cal(P)$, it can implement a function $tilde(ell)_(bold(theta)) ( rho , O )$ approximating the loss up to error $epsilon.alt$, i.e.,


$ (tilde(ell)_(bold(theta)) ( rho , O ) - ell_(bold(theta)) ( rho , O ))^2 lt.eq epsilon.alt thin . $


An algorithm can compute the loss functions in the problem~$cal(C)$ if it can compute them for all instances $cal(I)$ in $cal(C)$. One could also define problems in terms of being able to compute the loss function $ell_(bold(theta)) ( rho , O )$ and its gradients $nabla ell_(bold(theta)) ( rho , O )$. Being able to access the derivative information can be useful during the parameter training process. While in some cases computing the loss allows us to access derivatives (e.g., via parameter-shift rule~@mitarai2018quantum @schuld2019evaluating), we will restrict ourselves to only estimating the loss function.


As previously mentioned, the above definition guarantees that we can compute the loss function with high probability when the parameters are sampled according to $cal(P)$. While simulating--with high probability--random point in the landscape is typically easy (see for instance~@angrisani2024classically) it may not be particularly useful as it does not necessarily allow us to train the circuit. One might also be interested in computing the loss given #emph[any] parameter settings. Thus, we will also consider a stronger version where an algorithm can compute the loss function in an instance $cal(I)$ if #emph[for all] $bold(theta)$, it can implement a function $tilde(ell)_(bold(theta)) ( rho , O )$ approximating the loss up to error $epsilon.alt$. Of course, more pragmatic definitions exist where we do not care about approximating the loss function in average, or across all points, but where we instead focus on actually solving the optimization task at hand. As such, one may wish to obtain a $tilde(ell)_(bold(theta)) ( rho , O )$ such that the solution to the optimization problem $"arg min"_(bold(theta)) tilde(ell)_(bold(theta)) ( rho , O )$ is as good (according to some metric) as that obtained by solving $"arg min"_(bold(theta)) ell_(bold(theta)) ( rho , O )$. We will not focus on this case here but we note that its exploration is an open area of research~@gil-fuster2024understanding @bermejo2024quantum.


// [figvision-cn] imgs/Fig_Schematic_v2.png
// 该图由三个横向排列的子图组成，分别标记为 a)、b) 和 c)，
// 均为流程图类型，展示了三种不同的仿真类别的原理。图中所
// 有文本均为英文，各子图通过箭头表示信息流向，最终输出均
// 为损失估计。 子图 a) 标题为 CSIM。该图位于左侧虚线框内。
// 流程起始于左侧一个带有文档线条图案的图标，下方标注
// Problem Description（问题描述）。一个向右的箭头指向中
// 间的笔记本电脑图标，屏幕显示为二进制代码图案，下方标注
// Classical Computer（经典计算机）。再次通过向右箭头指向
// 右侧的输出项，符号表示为 \(\tilde{\ell}_\theta(\rho, O
// )\)，下方标注 Loss Estimate（损失估计）。该子图描述了
// 一个纯经典的计算流程。 子图 b) 标题为 QESIM。该图位于
// 上方偏右的点划线框内。流程起始于左侧的文档图标，下方标
// 注 Problem Description。向右箭头指向中间的量子计算机示
// 意图，该示意图呈圆柱形分层结构，下方标注 Quantum
// Computer。该量子计算机被一个红色的实线框包围，红框左侧
// 垂直标注有 Data acquisition phase（数据采集阶段）。向
// 右箭头指向右侧的笔记本电脑图标，下方标注 Classical
// Computer。最后通过向右箭头指向输出项 \(\tilde{\ell}_\
// theta(\rho, O)\)，下方标注 Loss Estimate。该流程展示了
// 量子计算与经典计算相结合，且特别强调了数据采集阶段发生
// 在量子计算机部分。 子图 c) 标题为 QSIM。该图位于下方。
// 流程起始于左侧的文档图标，下方标注 Problem Description。
// 向右箭头指向中间的量子计算机示意图，下方标注 Quantum
// Computer。量子计算机和右侧的笔记本电脑被一个红色的虚线
// 框包围。向右箭头指向笔记本电脑图标，屏幕上显示二进制代
// 码，下方标注 Classical Computer。最后通过向右箭头指向
// 输出项 \(\tilde{\ell}_\theta(\rho, O)\)，下方标注 Loss
// Estimate。该图展示了一个整体位于特定阶段（由红色虚线框
// 暗示）的量子-经典混合仿真流程。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [Figure #context it.counter.display(it.numbering). #it.body]
}

#figure(image("imgs/Fig_Schematic_v2.png", width: 100.0%),
  caption: [
    #strong[Schematic description of the simulation classes.] a) Problems in $upright("CSIM")$ are those for which there exists a fully classical algorithm that takes as input the problem description and estimates the loss function in polynomial time with a classical computer. Here, access to a quantum computer is not needed. b) Problems in $upright("QESIM")$ are those where one is allowed access to a quantum computer for an initial data acquisition phase that takes no more than polynomial time. At the end of this phase, access to the quantum computer is no longer allowed. A classical algorithm then takes the problem's description, and the data obtained from the quantum device, to estimate the loss function in polynomial time. Note that one can compute problems in $upright("QESIM")$ without needing to run a parametrized quantum circuit on the quantum hardware. c) Problems in $upright("QSIM")$ are those where one allows 'on demand' access to a quantum computer. Here, one usually implements the parametrized quantum circuit on the device.
  ],
  placement: top,
  scope: "parent"
)
<fig:models>


Now that we have defined what it means to compute (with high probability~or with certainty over $bold(theta)$) a loss, we can present different notions of what it means to simulate it. We begin with the most basic and intuitive definition for classical simulability, which we simply dub #emph[Classical Simulation] (CSIM). A problem $cal(C)$ is in $upright("CSIM")$ if a polynomial-time classical algorithm can compute every instance in $cal(C)$. As schematically shown in @fig:models, CSIM is performed entirely on a classical device with no need nor access to a quantum computer.


We also consider classical simulation algorithms enhanced by polynomial-size data obtained from quantum experiments, which we denote as #emph[Quantum Enhanced Classical Simulation] ($upright("QESIM")$), which morally means that the quantum landscape can be #emph[classically surrogated]. In this case, one is given a problem instance and is allowed to use a quantum computer for an initial data acquisition phase, which takes no more than polynomial time (and uses no more than polynomial-memory). During this phase, one can prepare copies of the initial quantum state, apply some operations, and independently measure them via some efficient tomographic or classical shadow techniques @huang2020predicting @elben2022randomized @anshu2023survey. Such a procedure can be used to obtain an efficiently storable classical representation (i.e., storable in string of size in $cal(O) ( "poly" ( n ) )$) of the state, unitary or measurement operator. Once this initial phase is over, one cannot access the quantum device anymore, and the computation of $ell_(bold(theta)) ( rho , O )$ has to be done purely classically. A problem $cal(C)$ is in $upright("QESIM")$ if a polynomial-time classical algorithm, which can utilize data obtained from quantum devices in an initial data acquisition phase, can compute every instance in $cal(C)$. Here we note that the problem of estimating a loss with data from a quantum computer can be cast into a decision problem. In this case, $upright("CSIM")$ can be related to BPP, $upright("QESIM")$ is closely connected to BPP/Samp~@huang2021power and even more closely connected to BPP/qgenpoly~@jerbi2023shadows, and $upright("QSIM")$ is related to BQP. Speaking more informally, algorithms in $upright("QESIM")$ are also often described as classical surrogate methods.


We stress that all problems in $upright("CSIM")$ and $upright("QESIM")$ do not require running a parametrized quantum circuit on the quantum computer. Quantum resources are either entirely unnecessary ($upright("CSIM")$), or used only in some initial data acquisition phase ($upright("QESIM")$).


// [figvision-cn] imgs/Inclusion_v2.png
// 这是一张表示集合包含关系的维恩图（Venn diagram）示意图，
// 用于说明三个计算复杂性类（QSIM、QESIM、CSIM）之间的包
// 含关系，以及可能实现量子优势的问题区域。 整张图由三个
// 同心圆构成，所有圆的底部在同一个切点处相切。由外到内依
// 次为： 最外层的大圆，其内部区域标注文字为“QSIM”。 中间
// 层的圆，其内部区域标注文字为“QESIM”。 最内层的小圆，其
// 内部区域标注文字为“CSIM”。 三个圆的包含关系为：最内层
// 圆完全包含在中间层圆内，中间层圆完全包含在最外层圆内。
// 即 CSIM ⊆ QESIM ⊆ QSIM。 颜色与图案填充： 最内层圆（
// CSIM）内部为纯浅米色/肉色填充。 中间层圆（QESIM）内部
// 也为纯浅米色/肉色填充。 最外层圆（QSIM）中，超出中间层
// 圆的部分（即 QSIM 与 QESIM 的差集区域）填充有垂直的粉
// 红色条纹图案。该条纹区域在图中覆盖了顶部、左侧和右侧，
// 底部因相切而收窄。 图中标注文字均位于对应圆的上方偏中
// 位置，垂直排列，自上而下依次为“QSIM”、“QESIM”、“CSIM”。
// 根据图注，该图传达的核心结论是：带有条纹的区域（即位于
// QESIM 之外但在 QSIM 之内的区域）对应于可能实现量子优势
// 的问题集合。
#figure(image("imgs/Inclusion_v2.png", width: 70%),
  caption: [
    #strong[Class inclusions.] We show the inclusions between the classes $upright("CSIM")$, $upright("QESIM")$ and $upright("QSIM")$. The region outside of $upright("CSIM")$ (highlighted with stripes) corresponds to problems where a quantum advantage could potentially be achieved.
  ]
)
<fig:inclusions>



This leads us to define #emph[Quantum Simulation] (QSIM). A problem class $cal(C)$ is in $upright("QSIM")$ if a polynomial-time quantum algorithm can compute all instances in $cal(C)$. As depicted in @fig:models, models in QSIM allow for feedback between the classical and quantum computer. Moreover, the models in QSIM will usually require implementing the parametrized quantum circuit on quantum hardware.


This is a convenient point to make a few important remarks. First, as shown in @fig:inclusions, we note that, by definition, the following inclusions hold:


$ upright("CSIM") subset.eq upright("QESIM") subset.eq upright("QSIM") thin . $


For instance, $upright("CSIM") subset.eq upright("QESIM")$ because if the loss is fully classically simulable then it can be estimated by simply skipping the quantum computer. The rest of the inclusions follow similarly. Clearly, QSIM is #emph[not] the largest possible set, and any loss that requires exponential time to estimate, even with a quantum computer, is beyond QSIM.


A quantum advantage is possible for problems where the loss can be simulated only if we have access to a quantum computer, i.e., for any problem in $upright("QSIM") inter overline(upright("CSIM")) thin$. In fact, any problem where the loss is in $upright("QESIM")$ but not $upright("CSIM")$ is already capable of a quantum advantage as it requires a quantum device. The problems that fall in $upright("QESIM") inter overline(upright("CSIM"))$ may well be the most suited for implementation on a near-term quantum computer as the data acquisition phase could be less noisy than fully implementing the parametrized quantum circuit~@mcclean2017hybrid @parrish2019quantum @bharti2020quantum @huang2021power @jerbi2023shadows @gyurik2023limitations.


With the definitions above, we are ready to ask the main question that motivates this work: #emph[Are all provably barren plateau-free loss functions also classically simulable (given polynomial-size data)?] That is, if:


$ overline(upright("BP")) subset^(?) upright("CSIM") thin thin upright("or") thin thin overline(upright("BP")) subset^(?) upright("QESIM") thin . $


= WHAT LEADS TO ABSENCE OF BARREN PLATEAUS?
<what-leads-to-absence-of-barren-plateaus>


To understand whether barren plateau-free losses are simulable, one must first understand the conditions leading to non-exponential concentration. While the study of barren plateaus was initially limited to case-by-case analyses, recent results have transformed our understanding of this phenomenon~@fontana2023theadjoint @ragone2023unified @diaz2023showcasing. As such, what previously seemed like a fragmented patchwork of special cases has started to coalesce into a cohesive unified theory of barren plateaus. In what follows, we will attempt to give an intuition for the sources of barren plateaus, and concomitantly how to avoid them.


To begin, let us note the simple, yet extremely important, fact that the loss function can be re-written as


$ ell_(bold(theta)) ( rho , O ) = ⟨rho ( bold(theta) ) , O⟩ = ⟨rho , O ( bold(theta) )⟩ thin , $<eq:inner-product>


where we have defined $rho ( bold(theta) ) = U ( bold(theta) ) rho U^dagger ( bold(theta) )$, $O ( bold(theta) ) = U^dagger ( bold(theta) ) O U ( bold(theta) )$, and where $⟨A , B⟩ = upright("Tr") [ A^dagger B ]$ denotes the Hilbert--Schmidt inner product~@knapp2013lie. At a first glance, Eq.~#ref(<eq:inner-product>, supplement: none) indicates that the loss is expressed as the inner product---a similarity measure---between two (exponentially large) operators of $cal(B)$. This fact should already raise some red flags as one can expect that, under quite general assumptions, the inner product between two exponentially large objects will be (on average) exponentially small and concentrated. For instance, we refer the reader to~@ragone2023unified @larocca2024review for a formalization of such argument. As such, problems with loss functions such as those in Eq.~#ref(<eq:inner-product>, supplement: none) can generically be expected to have barren plateaus.


// [figvision-cn] imgs/Subspaces.png
// 该图由上下排列的两个子图组成，分别标记为 a) 和 b)，均
// 为二维直角坐标图，用于对比量子力学中两个子空间的概念。
// 子图 a) 标题为“Proper Subspace”（真子空间）。横轴标记
// 为斜体花体字母 B，箭头向右，表示参数空间；轴上有一个刻
// 度标记，标注为“B_λ”。纵轴标记为尖括号表示的期望值⟨U(Θ)
// P_λU†(Θ)P_j⟩²，箭头向上，无具体数值刻度。图中绘制了一
// 个从横轴 B_λ 处开始、具有一定宽度的蓝色矩形区域，矩形
// 上边缘为水平直线，左右边缘为垂直直线，下边缘与横轴重合。
// 该矩形表示在 B_λ 附近的一个有限区间内，该期望值恒为常
// 数（矩形高度），而在区间外为零。这传达了一个“真子空间”
// 的投影特性：在特定参数范围内完全包含，范围外完全排除。
// 子图 b) 标题为“Effective Subspace”（有效子空间）。坐标
// 轴与子图 a) 相同，横轴为 B，纵轴为相同的期望值表达式。
// 图中绘制了一条钟形曲线（类似高斯分布），曲线下方面积被
// 分为三部分：中间部分填充蓝色，两侧尾部填充橙红色。蓝色
// 区域的左右边界分别对应横轴上的两个刻度，这两个刻度之间
// 的中心位置标记为“B_λ”。曲线在 B_λ 处达到峰值，向两侧逐
// 渐衰减至零。蓝色区域表示在 B_λ 附近的一个核心区间内，
// 期望值较高；橙红色区域表示在核心区间之外的尾部，期望值
// 虽不为零但逐渐减小。这传达了一个“有效子空间”的概念：与
// 真子空间不同，有效子空间在核心区域外仍有非零的泄漏（橙
// 红色部分），即期望值在边界处是连续衰减的，而非突然截断。
#figure(image("imgs/Subspaces.png", width: 100.0%),
  caption: [
    #strong[Adjoint action subspaces.] a) Given an operator $P_lambda$ and some parameters $bold(theta)$, we say $cal(B)_lambda subset cal(B)$ is a proper subspace if $⟨U ( bold(theta) ) P_lambda U^dagger ( bold(theta) ) , P_j⟩^2$ is non-zero only for operators $P_j$ in $cal(B)_lambda$. b) We will instead say that $cal(B)_lambda$ is an effective subspace if $⟨U ( bold(theta) ) P_lambda U^dagger ( bold(theta) ) , P_j⟩^2$ is non-zero for many operators outside of $cal(B)_lambda$, but is only large for operators in $cal(B)_lambda$. Proper and effective subspaces can arise either for all $bold(theta)$, or with high probability when sampling $bold(theta)$ from $cal(P)$.
  ]
)
<fig:modules>



If, however, the unitary $U ( bold(theta) )$ possesses additional structure, such as respecting some symmetry, then the loss can inherit this structure and potentially avoid the aforementioned issues. In particular, let us consider the adjoint action of $U ( bold(theta) )$ over the operator space $cal(B)$, and let us analyze if it leads to either subspaces, or, effective subspaces. That is, given some $bold(theta)$ and operator $P$ in an appropriate orthogonal basis of $cal(B)$ (such as a Pauli operator), we want to know: #emph[Where can $U ( bold(theta) ) P U^dagger ( bold(theta) )$ go?] Note that one can, and should, also ask the question: #emph[Where can $U^dagger ( bold(theta) ) P U ( bold(theta) )$ go?] But for simplicity of notation we will consider the first question.


Mathematically, this question can be answered by computing the inner products $⟨U ( bold(theta) ) P U^dagger ( bold(theta) ) , P_j⟩$ for the rest of the basis elements $P_j$. For instance, if the inner product is non-zero for all $P_j$, then we know that the unitary can transform $P$ into an operator that can spread out and reach operators across all of $cal(B)$. On the other hand, it could happen that the adjoint action of the unitary can only reach certain operators in $cal(B)$. For instance, as shown in Fig.~(a), the adjoint action of $U ( bold(theta) )$ can lead to well-defined subspaces in $cal(B)$ such that $⟨U ( bold(theta) ) P U^dagger ( bold(theta) ) , P_j⟩$ is only non-zero for operators in some $cal(B)_P subset cal(B)$. This case can arise for instance in circuits with small Lie algebraic modules~@larocca2021diagnosing @schatzki2022theoretical @kazi2024analyzing @anschuetz2022efficient @fontana2023theadjoint @ragone2023unified @diaz2023showcasing @heredge2024prospects or in shallow-depth hardware efficient ansätze~@cerezo2020cost @khatri2019quantum @zhao2021analyzing @liu2021presence.


A second case of interest arises when we have that $⟨U ( bold(theta) ) P U^dagger ( bold(theta) ) , P_j⟩$ is non-zero for a wide range of operators, but is large only for operators in a given subspace $cal(B)_P$. This case is depicted schematically in @fig:modules\(b) and we will say that given $P$, the adjoint action of $U ( bold(theta) )$ leads to 'effective' subspaces, rather than proper ones. We note that effective subspaces can either arise for all $bold(theta)$ or with high probability for $bold(theta) tilde cal(P)$. In the latter case, for most $theta$ values for the $⟨U ( bold(theta) ) P U^dagger ( bold(theta) ) , P_j⟩$ are large only within a small subspace, but for some low probability $bold(theta)$ values, large overlaps outside this subspace could be observed. Effective subspaces appear, with high probability for $bold(theta) tilde cal(P)$, for quantum convolutional neural networks~@cong2019quantum @pesah2020absence, in circuits with small angle initialization~@zhang2022escaping @park2023hamiltonian @wang2023trainability, or even due to the effects of noise~@mele2024noise.


To study whether or not a given problem lives within a subspace, it is convenient to express $O$ in an orthogonal basis of $cal(B)$ as


$ O = sum_lambda c_lambda P_lambda thin . $<eq:O-decomp>


Then, denote as $cal(B)_lambda equiv cal(B)_(P_lambda)$ the subspace associated to each $P_lambda$ that is induced by the adjoint action of $U ( bold(theta) )$. Given a state $rho in cal(B)$, we define its projection onto $cal(B)_lambda$ as $rho_lambda = sum_(P_j in cal(B)_lambda) a_j P_j$ with $a_j = ⟨rho , P_j⟩ / sqrt(⟨P_j , P_j⟩)$. In this notation, the loss function becomes:


$ ell_(bold(theta)) ( rho , O ) & = sum_lambda c_lambda ⟨rho , P_lambda ( bold(theta) )⟩ = sum_lambda c_lambda ⟨rho_lambda , P_lambda ( bold(theta) )⟩ thin , $<eq:loss-subspaces>


which reveals that $ell_(bold(theta)) ( rho , O )$ is the sum of the inner products in each subspace. Note that in the previous equation we expanded the measurement operator and expressed the loss in terms of the subspaces obtained by Heisenberg evolving each basis element. However, one could also expand $rho$ and study the loss in terms of the subspaces that concomitantly arise.


// [figvision-cn] imgs/HEA.png
// 该图由两个并排的子图组成，分别标记为 a) 和 b)，展示了
// 浅层硬件高效拟设（hardware efficient ansatz）的量子线
// 路结构及其子空间划分。两幅图均包含 8 条水平线，从上到
// 下代表 8 个量子比特（qubit）。线路由矩形框表示的双量子
// 比特门构成，采用砖块状（brick-like）交替排列，即每一层
// 门作用于相邻的量子比特对 (1,2)、(3,4)、(5,6)、(7,8)，
// 下一层则作用于 (2,3)、(4,5)、(6,7)，依此类推。每个矩形
// 框内部的对角线（或交叉线）表示该双量子比特门为任意 SU(
// 4) 操作，而非特定类型的受控门。 子图 a) 展示了一个深度
// 较大的拟设，共有 7 层双量子比特门。整个 8 量子比特线路
// 的主要部分被一个半透明的绿色矩形覆盖，该绿色区域从顶部
// 延伸至底部，覆盖了所有 8 条量子比特线和全部 7 层门。该
// 绿色区域代表一个特定的子空间。在绿色区域的右侧，每条量
// 子比特线末端（即输出端）都连接着一个测量符号，共 8 个，
// 符号为带有指针的圆形仪表盘，表示对每个量子比特进行独立
// 的 Z 基测量。绿色区域的顶部和底部有黑色箭头指向右侧，
// 表示该子空间的边界或流向。 子图 b) 展示了一个深度较浅
// 的拟设，共有 3 层双量子比特门。其绿色区域呈三角形。该
// 三角形覆盖了 8 条量子比特线中的中间 4 条（即第 3、4、5、
// 6 条线）。绿色区域从左侧第 2 层门开始，向右逐渐收缩，
// 覆盖了这 4 条线上的门，并在右侧汇聚成一个顶点。在第 4
// 条量子比特线（从上往下数）的末端，连接着一个测量符号（
// 仪表盘），表示仅对该量子比特进行测量。绿色区域的顶部和
// 底部边缘有黑色箭头指向右侧，表示该子空间的边界。与子图
// a) 不同，子图 b) 中绿色区域之外的量子比特线（第 1、2、
// 7、8 条）及其上的门以白色矩形框显示，表示它们不属于该
// 特定子空间，且这些线末端没有测量符号。 两幅图共同传达
// 的趋势是：在浅层硬件高效拟设中，可以通过选择特定的量子
// 比特子集（如子图 b 中的中间 4 个量子比特）来定义子空间，
// 且该子空间的维度或覆盖范围随线路深度的增加而变化（子图
// a 覆盖全部量子比特，子图 b 仅覆盖部分量子比特）。
#figure(image("imgs/HEA.png", width: 100%),
  caption: [
    #strong[Subspaces for shallow hardware efficient ansätze.] We consider classes of problems where the unitary $U ( bold(theta) )$ is an $L$-layered hardware efficient ansatz with two-qubit gates acting on alternating pairs of neighboring qubits in a brick-like fashion. We further assume that $L in cal(O) ( log ( n ) )$. a) For a global operator such as $O = Z^(⊗ n)$, the subspace obtained by adjoint action of $U ( bold(theta) )$ is exponentially large $forall L$. b) Given a local operator, such as $O = Z_mu$, one can see that for all $bold(theta)$ the ensuing subspace is proper and only contains Pauli operators acting on at most $cal(O) ( log ( n ) )$ neighboring qubits. Hence, this subspace is only polynomially large. Colored regions depict the backwards light cone of the measurement operator when Heisenberg evolved~@leone2022practical.
  ]
)
<fig:HEA>



If any of the subspaces appearing in Eq.~#ref(<eq:loss-subspaces>, supplement: none) is only polynomially large, then we can see that some component of the loss arises from comparing objects (via their Hilbert-Schmidt inner product) in non-exponentially large spaces. In what follows, we will use $cal(C)_(upright("polySub"))$ to denote the class of problems where the action of $U ( bold(theta) )$ on some term of the measurement operator is (either with high probability for $bold(theta) tilde cal(P)$ or for all $bold(theta)$) contained in an identifiable polynomially scaling (proper or effective) subspace, i.e., such that $upright("dim") ( cal(B)_lambda ) in cal(O)(upright("poly")(n))$, and where a basis for $cal(B)_lambda$ can be classically obtained.


To make these ideas clearer, let us go back to the class of problems with shallow hardware efficient ansätze $cal(C)_(upright("shallowHEA"))$. Consider first the case where the measurement operator is global, meaning that it acts on all qubits, such as $O = Z^(⊗ n)$. As schematically shown in @fig:HEA\(a), by applying the circuit to this operator one can obtain exponentially many other Pauli operators acting non-trivially on all qubits, meaning that the associated subspace is exponentially large. On the other hand, as seen in @fig:HEA\(b), if the measurement is a local operator such as $O = Z_mu$, then due to the bounded light cone structure of the circuit, it can only be mapped to Paulis acting on at most $2 L in cal(O) ( log ( n ) )$ neighboring qubits. Since there are $cal(O) ( "poly" ( n ) )$ such operators, the resulting subspace is a proper polynomial-sized subspace for any $bold(theta)$. Hence, if $O$ contains any local term, we will have that $cal(C)_(upright("shallowHEA")) subset cal(C)_(upright("polySub"))$.


As mentioned above, showing that certain problem classes are in $cal(C)_(upright("polySub"))$ indicates that some part of the loss arises from comparing objects in polynomially large spaces. While this appears to be a necessary step towards non-concentrated loss functions, it is also clearly #emph[not] a sufficient one. In particular, consider a subspace $cal(B)_lambda$ (for some $P_lambda$ in Eq.~#ref(<eq:O-decomp>, supplement: none)) such that $upright("dim") ( cal(B)_lambda ) in cal(O) ( "poly" ( n ) )$, but $rho$ or $O$ have almost no component when projected down into $cal(B)_lambda$. For instance, if $| ⟨rho_lambda , rho_lambda⟩ |$ or $| c_lambda^2 ⟨P_lambda , P_lambda⟩ |$ are in $cal(O) ( 1 / exp ( n ) )$, then we will clearly have an issue since the signal in the loss coming from the polynomially-sized subspace can therefore still be exponentially weak. If the previous occurs for all small subspaces, then the loss will be obtained by comparing objects in exponentially large spaces, which we already know can lead to concentration issues.


#figure(
  {
    align(center, {
      set text(size: 9pt, hyphenate: false)
      set par(leading: 0.4em, spacing: 0.4em)
      table(
        columns: (160.5pt, 60.8pt, 157pt, 133pt),
        stroke: 0.4pt,
        inset: (x: 2pt, y: 3.45pt),
        align: center + horizon,
        table.header([Problem instance $cal(C)$ based on], [Refs.], [Operators in the polynomial-sized $cal(B)_lambda$], [$O$ and $rho$ leading to $cal(C) subset overline(upright("BP"))$]),
        [Shallow hardware efficient ansatz], [@cerezo2020cost @khatri2019quantum @zhao2021analyzing @liu2021presence @letcher2023tight @basheer2022alternating @suzuki2023effect], [$cal(O) ( log ( n ) )$ neighboring qubits (P)], [Local $O$, area law $rho$],
        [Generic shallow locally circuits], [@napp2022quantifying @zhang2023absence#super[a]], [$cal(O) ( 1 )$-weight qubits (E)], [Local $O$, area law $rho$],
        [Quantum convolutional neural network], [@pesah2020absence], [$cal(O) ( 1 )$-weight qubits (E)], [Local $O$, area law $rho$],
        [$U ( 1 )$-equivariant], [@larocca2021diagnosing @monbroussou2023trainability @cherrat2023quantum], [Proj. with $cal(O) ( 1 )$ Hamming weight (P)], [Equivariant $O$, $rho in cal(B)_lambda$],
        [$S_n$-equivariant], [@schatzki2022theoretical], [Permutation equivariant (P)], [$O in cal(B)_lambda$, $upright("Tr")[rho_lambda^2] in Omega(upright("1/poly")(n))$],
        [Matchgate circuit], [@diaz2023showcasing], [Product of $cal(O) ( 1 )$ Majoranas (P)], [$O in cal(B)_lambda$, $upright("Tr")[rho_lambda^2] in Omega(upright("1/poly")(n))$],
        [Small angle initialization], [@zhang2022escaping @park2023hamiltonian @wang2023trainability], [$cal(O)(upright("poly")(n))$ Pauli Operators (E)], [Local $O$, area law $rho$],
        [Small Lie algebra $frak(g)$], [@fontana2023theadjoint @ragone2022representation @west2023provably], [Operators in $frak(g)$ (P)], [$O in i frak(g)$, $upright("Tr")[rho_(frak(g))^2] in Omega(upright("1/poly")(n))$],
        [Non-unital noisy-circuits], [@mele2024noise], [$cal(O) ( log ( n ) )$ qubits (E)], [Local $O$, any $rho$],
        [Dynamic circuits], [@deshpande2024dynamic], [$cal(O) ( 1 )$-weight qubits (E)], [Local $O$, any $rho$],
        [Quantum generative modeling#super[b]], [@rudolph2023trainability @letcher2023tight], [Tensor networks (e.g., MPS) (P)], [$O$, $rho$ computational basis proj.],
      )
    })
    v(2pt)
    set align(left)
    set text(size: 8pt)
    set par(first-line-indent: (amount: 0pt, all: false), hanging-indent: 8pt, justify: true, leading: 0.6em, spacing: 0.25em)
    set block(spacing: 0.25em)
    par[#super[a] See also the Supplemental Information for a detail proof of this claim.]
    par[#super[b] Here we refer to quantum circuit Born machines with the maximum mean discrepancy loss~@rudolph2023trainability and quantum generative adversarial networks with certain families of discriminators~@letcher2023tight (both using shallow hardware efficient circuits).]
    v(10pt)
  }
  , kind: table
  , placement: top
  , scope: "parent"
  , caption: [#strong[Problem classes in $overline(upright("BP"))$ and also in $cal(C)_(upright("polySub"))$.] In this table, we present the problems considered in our analysis. In all cases, we also provide the references where absence of barren plateaus was proven, as well as the relevant polynomially large subspace $cal(B)_lambda$ (indicating whether it is proper (P) or effective (E)), and the states and measurement operators for which $cal(C)$ is in $overline(upright("BP"))$. We refer the reader to @tab:sim-algs and the Supplemental Information for additional details on how the classical simulation is performed. Here 'proj.' is used as a short-hand for projector, while MPS stands for matrix product states~@verstraete2008matrix.]
  )
<tab:train_models>



To showcase the importance of having measurement operators and initial states which are "well-aligned" with the polynomial subspace, let us consider again the class of problems with shallow hardware efficient ansätze. We already saw that if $O$ is local (or contains relevant local terms), then $cal(C)_(upright("shallowHEA")) subset cal(C)_(upright("polySub"))$. Thus, to know whether the loss will concentrate, we need to study the Hilbert-Schmidt norm of the projected $rho$ into the subsets of $2 L in cal(O) ( log ( n ) )$ adjacent qubits in the backwards light cone of the local measurement. For instance, it is not hard to check that if $rho$ is pure and follows a volume law of entanglement~@cerezo2020cost @leone2022practical, then $| ⟨rho_lambda , rho_lambda⟩ |$ will be exponentially close to zero, and the loss will be exponentially concentrated. On the other hand, if $rho$ is pure and satisfies an area law of entanglement~@eisert2010colloquium @leone2022practical, then the previous inner product will be, at most, polynomially vanishing. Putting these realizations together we see that


$
cal(C)_(upright("shallowHEA")) subset overline(upright("BP")) #h(0.17em) #h(0.17em) #h(0.17em) upright("if ") rho upright(" follows area law and O is local") .
$


Note that these results actually correspond to a reinterpretation of Theorems 1 and 2 in Ref.~@cerezo2020cost, where it was shown that shallow-depth hardware efficient ansätze lead to barren plateaus for global measurements, but are barren plateau-free if the measurement operator is local and the initial state follows an area law of entanglement.


The previous example of $cal(C)_(upright("shallowHEA"))$ illustrates an important point. We started with a problem class, identified the measurement operators which, when evolved under the adjoint of $U ( bold(theta) )$, remain in polynomially small subspaces, and then used this to determine the states for which the problem does not exhibit a barren plateau. This argument then leads to the question: #emph[How general is the connection between absence of barren plateaus and polynomially small subspaces arising from the unitary's adjoint actions?] To address this, we have performed a detailed analysis of widely used barren plateau-free models and found that in all cases, it is #emph[precisely] the existence of such subspaces which allows us to avoid exponential concentration. As such, we believe that the following claim is true for all widely used architectures and techniques:


#thmbox("claim", "Claim")[


#emph[[Standard provably barren plateau-free architectures live in classically identifiable polynomial subspaces.]] For all standard problem classes $cal(C)$ such that $cal(C) subset overline(upright("BP"))$, we have that


$ cal(C) subset cal(C)_(upright("polySub")) thin . $


That is, take a problem class which provably avoids barren plateaus. Then, if one studies the parametrized unitary's adjoint action on the measurement operation and initial state, one will find that it generates operators that live either exactly, or approximately, in a polynomially sized subspace in operator space. Moreover, such subspaces can be identified classically.


] <claim1>


By 'standard problems' we here refer to the conventional variational quantum architectures which have been proven to be in $overline(upright("BP"))$. In @tab:train_models we present a non-exhaustive list of such architectures. Therein, we report the relevant polynomial subspace, indicating whether it is proper or effective, as well as the conditions on the measurement operator and initial state necessary for absence of barren plateaus. We emphasize that in many cases, it was the proof of absence of barren plateau itself which allowed us to determine the reported information. The majority of strategies studied, including shallow hardware efficient ansatz and highly symmetrized models, lead to proper subspaces for all $bold(theta)$. The most important examples of models where one lives in effective subspaces (with high probability $bold(theta) tilde cal(P)$) are quantum convolutional neural networks and small angle initialization strategies.


= CONNECTION BETWEEN ABSENCE OF BARREN PLATEAUS AND SIMULABILITY
<connection-between-absence-of-barren-plateaus-and-simulability>


In the previous section we claimed that barren plateaus arise as a curse of dimensionality for loss functions that compare objects in exponentially large spaces. We then argued that our attempts to fix this issue have ultimately led us to encode the problem in some polynomially small subspace, which we can classically identify. Here we show that the existence of such a subspace can be exploited to classically simulate the loss.


To illustrate our arguments, let us again start by considering a shallow hardware efficient ansatz class where $O = Z_mu$. Since the measurement is local the adjoint action of $U ( bold(theta) )$ leads to a proper subspace $forall bold(theta)$ of Pauli operators acting on at most $2 L in cal(O) ( log ( n ) )$-neighboring qubits. From @fig:HEA\(b), we can then see that if we 'drop' all the gates from $U ( bold(theta) )$ that are outside of the measurement's backwards light cone, the loss function remains unchanged. By denoting as $U_lambda ( bold(theta) )$ the reduction of $U ( bold(theta) )$ that acts only on the $2 L$ qubits in the backwards light cone, we find that


$ ell_(bold(theta)) ( rho , Z_mu ) &= ⟨rho , U^dagger ( bold(theta) ) Z_mu U ( bold(theta) )⟩ \
&= ⟨rho_lambda , U_lambda^dagger ( bold(theta) ) Z_mu U_lambda ( bold(theta) )⟩ thin . $


In the last equality, one computes the inner product between objects living, and acting on, the polynomially-sized subspace.


Indeed, we have taken an important step in the right direction as classically computing the loss now requires working with non-exponential operators. Still, we need to determine what $rho_lambda$ is. If $rho$ is some product state, then one can classically find its projection onto the subspace by computing (e.g., via pen and paper) the expectation value for all operators $P_j in cal(B)_lambda$. However, if $rho$ is some state obtained at the output of a given circuit, then there is no generic strategy which allows us to obtain these expectation values classically (even if we are promised that $rho$ is an area law state~@anshu2023survey). On the other hand, given access to a quantum computer, one can efficiently estimate $rho_lambda$ during the initial data acquisition phase. In particular, here one simply prepares the quantum state, and measures the expectation value for all (polynomially many) operators in a basis of $cal(B)_lambda$. One could also simply perform standard classical shadow tomography~@huang2020predicting @elben2022randomized, and this information will suffice.


Hence, for local observables and area law initial states, we have that


$ cal(C)_(upright("shallowHEA")) subset upright("CSIM") thin , quad upright("or") quad cal(C)_(upright("shallowHEA")) subset upright("QESIM") thin , $


and it is clear that the loss can be estimated without ever needing to use a quantum computer to run the parametrized quantum circuit. Hence, no problem based on shallow hardware efficient ansätze with a local measurement can be outside of $upright("QESIM")$. We note that this result was originally reported in Ref. @basheer2022alternating. It is worth additionally highlighting that, given the simplicity of the requisite measurement procedures here, one could lift the restriction that $rho$ is preparable by a poly depth quantum circuit and also consider quantum states that result from quantum experiments running in polynomial time, e.g., from analog or non-unitary processes. This makes the quantum-enhanced classical simulation method more flexible than directly implementing the parameterized quantum circuit on hardware~@jerbi2023power.


Here we argue that the process described above for simulating shallow HEA circuits can be applied to any problem in $cal(C)_(upright("polySub"))$. In all cases, the simulation follows the following three steps:

+ Identify the subspaces $cal(B)_lambda$ of polynomial dimension.

+ Characterize the adjoint action of $U ( bold(theta) )$ on the basis element $P_lambda$ in the decomposition of $O$ (or $rho$) that lead to the $cal(B)_lambda$.

+ Compute or measure the component of $rho$ (or $O$) that is in the relevant polynomial $cal(B)_lambda$ subspaces.


Identifying the polynomial subspace $cal(B)_lambda$ is the most important step and usually requires understanding the internal properties of $U ( bold(theta) )$ and how these translate into the circuit's adjoint action. For instance, in the shallow hardware efficient ansatz example, we needed to realize that the relevant subspace is composed only of operators acting on the qubits in the backwards light cone. More generally, given a problem in $overline(upright("BP"))$, one can obtain $cal(B)_lambda$ by carefully analyzing the proof techniques used to show non-exponential concentration and reverse engineering what the exploited structure is. In particular, all proofs for the absence of barren plateaus come with fine print, in the sense that they only hold for specific choices of $rho$ and $O$. Thus, most of the work has already been performed in proving absence of barren plateaus and one can take the initial states and measurement operators for which the proof holds and use these to infer $cal(B)_lambda$.


#figure(
  {
    align(center, {
      set text(size: 9pt, hyphenate: false)
      set par(leading: 0.4em, spacing: 0.4em)
      table(
        columns: (164pt, 158pt, 154pt, 45pt),
        stroke: 0.4pt,
        inset: (x: 2pt, y: 3.45pt),
        align: center + horizon,
        table.header([Problem instance $cal(C)$ based on], [Tomographic procedure for $rho$], [Simulation algorithm based on], [Simulable]),
        [Shallow hardware efficient ansatz], [Pauli classical shadows~@huang2020predicting], [Light-cone sim. reduced $U ( bold(theta) )$], [$forall thin bold(theta)$],
        [Generic shallow locally circuits], [Pauli classical shadows], [Pauli Propagation~@angrisani2024classically], [$bold(theta) tilde cal(P)$],
        [Quantum convolutional neural network#super[a]], [Pauli classical shadows], [Pauli Propagation], [$bold(theta) tilde cal(P)$],
        [$U ( 1 )$-equivariant], [Computational basis measurement], [Givens Rotations~@kerenidis2021classical], [$forall thin bold(theta)$],
        [$S_n$-equivariant], [Permutation invariant shadows~@toth2010permutationally], [$frak(g)$-sim~@goh2023lie], [$forall thin bold(theta)$],
        [Matchgate circuit], [Expectation value of Pauli operators], [$frak(g)$-sim], [$forall thin bold(theta)$],
        [Small angle initialization], [Pauli measurements], [Tensor Networks~@shin2024dequantising, Pauli Prop.~@lerch2024efficient], [$bold(theta) tilde cal(P)$],
        [Small Lie algebra $frak(g)$], [Expectation value of algebra elements], [$frak(g)$-sim], [$forall thin bold(theta)$],
        [Non-unital noisy-circuits], [Not needed], [Light-cone sim.~@mele2024noise, Pauli Prop.~@schuster2024polynomial], [$bold(theta) tilde cal(P)$],
        [Dynamic circuits], [Pauli classical shadows], [Pauli Propagation~@angrisani2024classically], [$bold(theta) tilde cal(P)$],
        [Quantum generative modeling#super[b]], [Not needed], [Tensor Networks], [$forall thin bold(theta)$],
      )
    })
    v(2pt)
    set align(left)
    set text(size: 8pt)
    set par(first-line-indent: (amount: 0pt, all: false), hanging-indent: 8pt, justify: true, leading: 0.6em, spacing: 0.25em)
    set block(spacing: 0.25em)
    par[#super[a] In the Supplemental Information we also show that certain parameter restricted quantum convolutional neural networks can be simulated for all $bold(theta)$. For a general simulation of vanilla quantum convolutional neural networks see~@bermejo2024quantum.]
    par[#super[b] Here we refer to quantum circuit Born machines with the maximum mean discrepancy loss~@rudolph2023trainability and quantum generative adversarial networks with certain families of discriminators~@letcher2023tight (both using shallow hardware efficient circuits).]
    v(10pt)
  }
  , kind: table
  , placement: top
  , scope: "parent"
  , caption: [#strong[Simulation algorithm for the problems in $overline(upright("BP"))$.] In this table we present the problem instances considered in our analysis and an example algorithm that we can use to simulate them. Alternatives to tensor networks can also be used, e.g. Refs.~@nemkov2023fourier @fontana2023classical @rudolph2023classical @shao2023simulating @beguvsic2023simulating. We also provide the tomographic procedure that could be used for a generic initial state as well as indicating whether the simulation is available on average, or for all points in the landscape.]
  )
<tab:sim-algs>



Once we have identified $cal(B)_lambda$, we can proceed to study the adjoint action of $U ( bold(theta) )$ over the relevant $P_lambda$ operator. The key insight here is to note that $U ( bold(theta) ) P_lambda U^dagger ( bold(theta) )$ can only map to operators in $cal(B)_lambda$, and hence, can be somehow represented by its effective action on this subspace. The specific construction of this effective action is case dependent, but as detailed in the Supplemental Information (which contains additional details and proofs, which contains Refs.~@wiersema2020exploring @jozsa2008matchgates @wan2022matchgate @de2013power @diaz2023parallel @bravyi2004lagrangian @dias2023classical @cudby2023gaussian @gigena2015entanglement @arrazola2022universal @johri2021nearest @lopez2022symmetric @somma2006efficient @zeier2011symmetry @wiersema2023classification @kokcu2024classification @aguilar2024full @vznidarivc2022solvable @deneris2024exact @braccia2024computing @belkin2023approximate @mittal2023local @benedetti2019generative @coyle2020born @alcazar2020classical @benedetti2019adversarial @perdomo2018opportunities @zoufal2021generative @ferris2012perfect @stoudenmire2010minimally @markov2008simulating @verstraete2006matrix @evenbly2011tensor @beguvsic2023fast @wecker2015progress @caro2021generalization @liu2023model @hur2021quantum @umeano2023can @mele2023introduction.), we have been able to derive it for all considered barren plateau-free problems. In some cases, such as the aforementioned hardware efficient ansatz, one can trivially reduce $U ( bold(theta) )$ to a smaller dimensional unitary acting on $2 L$ qubits by simply discarding all of the gates that are not in the light cone of the measurement (see @fig:HEA\(b)). In some other cases, one needs to employ classical simulation algorithms based on tensor networks, operator truncation, or Lie algebraic techniques~@anschuetz2022efficient @fontana2023classical @rudolph2023classical @goh2023lie. We refer the reader to the Supplemental Information for additional details. It is worth noting that constructing the adjoint action of $U ( bold(theta) )$ on $cal(B)_lambda$ has a computational cost associated with it, which one needs to take into consideration to estimate the simulation cost. Importantly, while we have found algorithms whose cost is polynomial in the number of qubits, it can nevertheless have poor scaling.


The final task is to obtain the component of $rho$ and $O$ in $cal(B)_lambda$, which we respectively denote as $rho_lambda$ and $O_lambda$. While it is possible to find the polynomially large subspaces and the effective adjoint of $U ( bold(theta) )$ fully classically, this will not be generically true for determining $O_lambda$ and $rho_lambda$ (as we saw, for example, for the shallow HEA). While $O_lambda$ is not much of a concern---since the classical description of $O$ could already contain this information---let us focus on obtaining $rho_lambda$. Recalling that, given an orthogonal basis ${ P_j }_j$, one can write $rho_lambda = sum_(P_j in cal(B)_lambda) ⟨ rho , P_j ⟩ P_j / sqrt(⟨ P_j , P_j ⟩)$, then we see that one needs to compute the expectation values $⟨P_j , rho⟩$. While for simple states such as the all-zero state this task can be performed fully classically, for general input states $rho$ this might not be the case.


With the previous arguments, we state the following claim.


#thmbox("claim", "Claim")[


#emph[[Problems in known polynomial subspaces are classically simulable (potentially requiring data from a quantum computer).]] Consider a problem class such that $cal(C) subset cal(C)_(upright("polySub"))$. Then either


$ ( i . ) thin thin thin thin cal(C) subset upright("CSIM") thin quad $


if $O_lambda$, $rho_lambda$ can be obtained classically, or


$ ( i i . ) thin thin thin thin cal(C) subset upright("QESIM") thin quad $


if $O_lambda$, $rho_lambda$ need to be estimated on a quantum computer. \


In particular, this opens the door towards the simulation of barren plateau-free loss functions $cal(C) subset overline(upright("BP"))$ living in a known polynomial subspace (as described in Claim~@claim1) using a classical algorithm without the need to implement a parametrized quantum circuit on a quantum computer.


] <claim2>


Again, for all barren plateau-free problems considered here, we have determined the relevant subspace, found efficient procedures to estimate the projections of the initial state and measurement operator, as well as for the action of the unitary. A summary of the resulting simulation algorithm and measurement protocols are reported in @tab:sim-algs and expanded upon in the Supplemental Information.


As mentioned above, and as indicated in @tab:sim-algs, for problems that live in proper polynomial subspaces (which constitute the vast majority of barren plateau-free schemes considered in the literature), one can simulate the loss in the strong sense, meaning that there exists a classical algorithm that approximates the loss for any $bold(theta)$. In the case of problems that live in effective subspaces, the classical simulability is available with high probability over $bold(theta) tilde cal(P)$. In particular, here we can simulate the parts of the loss that do not have barren plateaus. In the next section we will discuss the caveats resulting from this slightly weaker claim, but also opportunities to mitigate its disadvantages.


To wrap up, we highlight that combining Claim~@claim1 and Claim~@claim2 with our case-by-case analysis we can arrive at the conclusion: #emph[For the families of problems and architectures with provable absence of barren plateaus we analyzed, it does not seem that the parametrized quantum circuit need to be implemented on a quantum computer in order to estimate the loss in polynomial time]. Note that our results do #emph[not] imply a dequantization of variational quantum computing as a whole, since a quantum device might still be needed for the initial data acquisition phase. Viewed this way, our results can be viewed positively as highlighting the potential of a different learning paradigm where the quantum computer is used non-adaptively to create a classical surrogate of the loss landscape. Still, in a way, Claims~@claim1 and~@claim2 #emph[do], in a sense, dequantize the variational part of the model and shed some serious doubts on the non-classicality of the information processing being done by a barren plateau-free loss function.


= CAVEATS AND FUTURE DIRECTIONS
<sec:futureop>


In this section, we present several caveats to our arguments, as well as interesting new research directions.


== Caveats
<caveats>


First and foremost, we would like to highlight the fact that our general arguments are based on intuition gathered from a case-by-case study of widely used circuit architectures and techniques (although we do refer the reader to~@bermejo2024quantum @angrisani2024classically @lerch2024efficient @anschuetz2024arbitrary @mele2024noise @shin2024dequantising @ermakov2024unified @schuster2024polynomial for explicit simulation algorithms). It was not possible to analyze every work claiming absence of barren plateaus---we studied only those in #ref(<tab:train_models>)---but we highly encourage the community to check if our results are as widely applicable as we believe them to be. Moreover, while we have argued that absence of barren plateaus is linked to the presence of relevant polynomially small subspaces, we do not close the door to the existence of other non-exponential concentration mechanisms. For instance, Claim~@claim1 states #emph[for all cases studied] that, if $cal(C) subset overline(upright("BP"))$ then $cal(C) subset cal(C)_(upright("polySub"))$. We do #emph[not] claim that $overline(upright("BP")) subset cal(C)_(upright("polySub"))$. Thus we are #emph[not] claiming that #emph[any] non-concentrated loss can always be classically simulated.


In fact, one can construct examples of non-concentrated loss functions that are not classically simulable (see the Supplemental Information for one such example based on cryptographic hardness). Crucially, these examples do not resemble current mainstream variational quantum algorithms but instead draw inspiration from conventional fault-tolerant quantum algorithms for which we expect a superpolynomial quantum advantage to be achievable. In doing so, they break our initial assumption that comparing objects living in exponentially large spaces generically leads to concentrated expectation values, as the circuits used therein are not generic but rather purposely constructed. In fact, textbook quantum algorithms do not suffer from the curse of dimensionality as the exponentially large quantum states are manipulated in a well-thought and orderly manner, rather than a variational one. Nonetheless, as evidenced by our rather contrived examples in the Supplemental Information, it is not obvious how to use these techniques in variational quantum computing as textbook quantum algorithms are only built for very specific tasks.


Another caveat is that the amount of quantum resources required by problems that fall into $upright("QESIM")$ varies on a case-by-case basis. Many cases, as shown in @tab:sim-algs, require only Pauli measurements and thus the load on the quantum device is very light. Indeed, a universal quantum computer may not be required and rather a more bespoke analogue simulator or quantum experiment may suffice. At the other extreme one could consider a deep quantum circuit with only a single trainable parameter $phi.alt$~@gil-fuster2024understanding. Such a circuit could be constructed so that it does not have a barren plateau and yet also fall into $upright("QESIM")$, as one can trivially construct a classical surrogate for the landscape by running the circuit in 'a data collection phase' at different $phi.alt$ values. The absence of barren plateau results for small #emph[patches] of quantum landscapes close to minima~@haug2021optimal @puig2024variational @mhiri2025unifying which can also be surrogated by running the parametrized quantum circuit and making appropriate measurements~@lerch2024efficient. These cases thus strictly align with our claims that problems that can provably avoid barren plateaus fall into $upright("QESIM")$ but stretch the original spirit of $upright("QESIM")$ by requiring substantially more quantum resources from the quantum device.


It is worth noting that our general arguments against conventional variational quantum algorithms require provable absence of barren plateaus, as the proof itself is used in our derivation of the classical simulability techniques. As such, we cannot comment on situations where one can heuristically find large gradients (e.g., via numerics~@grimsley2022adapt @dborin2022matrix @rudolph2022synergy) but where the relevant subspace is not known. Such situations could arise for very special parts of the landscape, such as warm-starts or other smart initialization strategies. Although we believe that a careful analysis of many such cases will highlight that the problem is essentially contained in a polynomially-sized subspace. For instance, we can refer to the specific case of ADAPT-VQE~@grimsley2022adapt, which has no formal proof of absence of barren plateaus but has been heuristically shown to have large gradients for close to identity initializations. Here, it has been recently shown that Majorana Propagation~@miller2025simulation could efficiently simulate the action of the ADAPT-VQE circuit. Of course, these are preliminary results and there is as of yet no efficient protocol for characterizing the adjoint action of $U ( bold(theta) )$ throughout training and guaranteeing that it will remain in the simulable region. Indeed, as suggested by our counterexamples, it might be that the clever initializations explore an exponentially large space in some structured---but unknown---manner.


Relatedly, let us highlight that, for problems that live in effective but not proper subspaces, classical simulation is possible for $bold(theta) tilde cal(P)$ only with high probability. While this can enable for the simulation of randomly chosen points in certain regions of the landscape~@lerch2024efficient @mhiri2025unifying, this need not be necessarily useful for training, as one may be in a non-interesting part of the landscape, or the training might take us towards regions that not classically simulable. More concretely, if the subspace is effective (as in @fig:modules\(b)), our methods will provide simulation techniques that will only be faithful in the vicinity of the initialization. However, if the relevant sector $cal(B)_lambda$ shifts during training the simulation might cease to be reliable. The extent to which this is possible is yet to be explored, but recent results have shown that this phenomenon does not seem to occur in quantum convolutional neural networks~@bermejo2024quantum when benchmarked in standard tests, as there one initializes --and remains during training-- in the same classically simulable region of the landscape.


Finally, we would like to again highlight that our analysis was oriented towards loss functions based on quantities such as that in Eq.~#ref(<eq:loss>, supplement: none). Hence, our claims are not directly applicable to problems such as quantum Boltzmann machines~@coopmans2023sample where one employs different types of loss functions. In fact, quantum Boltzmann machines are another example of a variational model built upon a quantum primitive (thermal state preparation) which one expects is hard to simulate classically. Hence this is an interesting avenue for balancing quantum advantage and trainability considerations.


== New opportunities
<new-opportunities>


Perhaps the main goal of this perspective article is to provide new and exciting research directions that take into account the connection between barren plateaus and simulability. As such, we here discuss several new opportunities that we think could be fruitful to pursue.


First and foremost, we would like to note that just because some loss function can be classically simulated in polynomial time, this does not mean that it is still practical to do so. In particular, some of the simulation algorithms we have found (see the Supplemental Information) could still be prohibitively expensive to implement. Thus, by embracing the fact that some barren plateau-free loss functions are classically simulable, one could compare the computational complexity of the simulation versus that of estimating the loss function in a quantum computer, and thus potentially find provable polynomial speed-ups or at least more favorable constant factors with the same polynomial scaling. We refer the reader to Ref.~@anschuetz2022interpretable @miao2023convergence @anschuetz2024arbitrary for some examples on this research direction.


// [figvision-cn] imgs/Updated.png
// 该图由两个子图a和b组成，呈现了量子-经典混合优化中避免
// 贫瘠高原、实现忠实训练的策略。 子图a为二维参数空间曲线
// 图，横轴为θ₂、纵轴为θ₁，均无单位标度。图中包含三条曲线：
// 一条黑色实线标注为Classical Simulation，起点位于左下，
// 向右上延伸并趋于平缓；一条红色虚线标注为Full Loss，与
// 黑色曲线近似平行但整体位置偏上，并在右端出现明显分离。
// 红色虚线上有箭头指示从下方黑色曲线向红色曲线过渡的方向，
// 传达出在经典模拟的基础上，完整损失函数能保持可训练性、
// 不出现梯度消失的趋势。 子图b为流程图，把多个模块通过箭
// 头连接起来，构成从数据采集到优化再到更新数据采集的闭环。
// 流程从Problem Description（问题描述，图标为文档）开始，
// 箭头指向Quantum Computer（量子计算机，图标为稀释制冷机
// 样式的量子处理器），再指向Classical Computer（经典计算
// 机，图标为笔记本电脑，屏幕上显示“Classical Application
// of U(θ) and O”与“Optimization”）。在经典计算机右侧，与
// 子图a结构相同的θ₁-θ₂曲线图再次出现，标注为Updated
// Classical Simulation（更新后的经典模拟）和Full Loss（
// 虚线）。流程图中有一条标注为“Data acquisition phase”的
// 矩形框包围前三个模块；下方有反馈路径：从优化结果出发，
// 经“Update Parameters”（更新参数）返回量子计算机，另有“
// Update Data Acquisition”（更新数据采集）返回问题描述环
// 节。整体传达出数据采集、量子计算与经典优化循环迭代，且
// 完整损失函数能保持可训练性的结论。
#figure(image("imgs/Updated.png", width: 100.0%),
  caption: [
    #strong[Absence of barren plateaus, simulability, and faithful training.] a) We consider a problem in $overline(upright("BP"))$ such that, with high probability for some $bold(theta) tilde cal(P)$, the circuit's adjoint action leads to a polynomial effective subspace as in @fig:modules\(b). Training on the classically estimated loss can be faithful for the first few optimization steps. However, as the optimization continues, a vital contribution to the loss could arise from operators not in $cal(B)_lambda$. If this occurs, training on the classically estimated loss can be unfaithful and one can converge towards a parameter region that does not correspond to the minima of the true 'full' loss function. b) To mitigate the aforementioned issues, one could use an alternative form of hybrid variational quantum computing where multiple, iterative, data acquisition steps are used. This information is then used by a classical computer to update a classical simulation of the loss and make it more faithful as the optimization progresses. As schematically shown, this scheme could make training the loss on a classical computer more faithful.
  ],
  placement: top,
  scope: "parent"
)
<fig:modelsVQA2.0>



Second, we highlight the fact that being able to classically simulate and train a model without the need for expensive computational resources could be extremely useful. In particular, it is well known that there exist problems where one can classically train a variational state by minimizing some expectation value, but sampling from such a state on a classical computer is prohibitively expensive (such as in certain optimization problems or generative modeling tasks)~@medvidovic2021classical @diez2023quantum @hadfield2018quantum @sreedhar2022quantum @krovi2022average @farhi2016quantum or may not be supported by the particular simulation algorithm. Similarly, one can envision tasks where the goal is to variationally prepare some state for a quantum sensing task~@endo2020variational @beckey2020variational @huerta2022inference. Here, the ultimate goal is to obtain a metrological advantage rather than a computational one, meaning that classical simulations could be beneficial to save precious quantum resources. This paves the way for finding tasks where one ultimately cares about being able to prepare or sample from a state, as here one can train the parameters on a classical computer, transfer them to a quantum device (e.g., via Refs.~@ran2020encoding @rudolph2022decomposition), and perform additional operations and measurements therein.


Third, and as discussed in the Supplemental Information, there appears to be no 'one simulation algorithm' to rule them all, as we have found that different loss functions require different simulation algorithms. Hence, given some barren plateau-free model, we envision that asking the question '#emph[How can we simulate this loss?]' will lead us to new data-driven and quantum-inspired simulation algorithms. In the same line of thought, we think that our quest to better understand what makes an initial state well-aligned with the relevant subspaces, and thus a barren plateau-free loss, can allow us to uncover what are the true resources that make a loss function more difficult to simulate, but also more concentrated. For instance, the recent work of~@tindall2024confinement studied why certain quantum experiments~@kim2023evidence could be efficiently simulated via tensor networks~@tindall2023efficient. Therein, the authors showed that the dynamics generated by the quantum circuit ultimately live in a small (identifiable) subspace. In parallel, as most classical algorithms will have their limits where they particularly excel or perform poorly, it may also turn out that quantum methods where one runs the circuit on the device could still provide the most flexible 'catch all' simulation method.


As an example, we refer the reader to Ref.~@diaz2023showcasing, where a connection between computational resources in fermionic linear optic circuits, absence of barren plateaus, and simulability is unraveled. Therein, it was shown that when the quantum resources (measured by fermionic entanglement) are increased, the loss function becomes more concentrated. Simultaneously, even if the state has a large component in the polynomial subspace one still needs to estimate it, and whether such computation can be classically performed will likely determine if the loss is in $upright("CSIM")$ or $upright("QESIM")$ (see Claim~@claim2). We thus leave for future work a detailed study of the initial states and measurement operators for which the problems are actually in $upright("CSIM")$. Note that this analysis could promote simulations that are available on average, to faithful simulations for all $bold(theta)$. For instance, a quantum convolutional neural network with product initial states can be efficiently simulated via tensor networks~@cong2019quantum, and hence is actually in $upright("CSIM") forall bold(theta)$. We believe that such pursuits will lead to deep insights into architecture-dependent resource theories and the limits of classical simulation algorithms.


Going further, we have noted that problems which are in $upright("QESIM")$ but not in $upright("CSIM")$ could be precisely those that are more amenable for implementation in the near term. This is due to the fact that the data acquisition might require shallower circuits than the implementation of $U ( bold(theta) )$, and thus be less impacted by hardware noise. Moreover, optimizing directly on the classical device will generally be much more efficient given the relative speed of classical devices and the possibility of using tools such as automatic differentiation through gradient back-propagation. Indeed, while the loss is defined as a unitary evolution of the state's projection onto the polynomial subspace, once the data is stored classically, one can potentially analyze it with more general procedures such as sending it through an appropriate classical neural network. This then begs the question of whether the best way to analyze the tomographic data is via a unitary map, or some more general function.


More fundamentally, the very fact that a study of barren plateaus has led us to tomographic techniques~@huang2020predicting @elben2022randomized @anshu2023survey is in itself extremely interesting. Here, one can wonder about the limits of measure-first algorithms where initial data acquisition phases are allowed. While it is known that generically using the same shadows protocol for every problem has its limitations~@gyurik2023limitations, our results indicate that for every barren plateau-free problem there is an associated tomographic procedure, and that these protocols can vary widely from one task to the other. The extent to which these data acquisition methods are connected, and what their limitations are, is therefore an open question.


Regarding the utility of variational quantum computing and machine learning for classical data~@wiebe2014quantumdeep @schuld2015introduction @biamonte2017quantum @cerezo2022challenges @di2023quantum, our results should help us better understand if the quantum computer is being used as a meaningful form of enhanced feature-space. Namely, if the problem's loss function is barren plateau-free, and we can identify how to simulate it, one should ask whether the loss is in $upright("CSIM")$ or in $upright("QESIM")$. Answering these questions could rule out situations where the use of a quantum computer is not necessary. One could further explore the parallels here with recent research into the possibility of classical surrogates for quantum models using classical data~@schuld2021quantummodels @schreiber2022classical @landman2022classically @jerbi2023power @sweke2023potential.


As discussed in the previous section, we know that if the problem has effective subspaces, then one could potentially simulate and train the loss given some initial set of parameters, but that the loss might not be faithful for the full optimization procedure (see @fig:modelsVQA2.0\(a)). To mitigate this issue, we envision a novel form of hybrid quantum computation as shown in @fig:modelsVQA2.0\(b). Here, there is still a feedback loop between the classical and quantum device (similar to that of standard variational methods), but instead of updating parameters in a quantum circuit, one updates the data acquired from the initial state. As such, as the optimization progresses, one uses the quantum computer to take new measurements on the initial state, and then uses this information for a more faithful, updated classical simulation. While we have not tested the performance of this protocol, we believe it might be useful and encourage the community to try it out.


To finish, we note that many schemes are not covered by our results. These include certain clever initialization strategies and many quantum learning models (such as some schemes in generative modeling). Moreover, we have shown that by drawing inspiration from conventional quantum algorithms one can construct unorthodox variational settings where manipulation of exponentially large objects is enabled, barren plateaus can be avoided, and a quantum advantage is still possible. In this regard, we note that under widely held cryptographic assumptions it is believed that BQP $subset.eq.not$ BPP/poly. Ref.~@gyurik2023exponential uses this fact in a PAC-learning setting to argue that many-body physics problems that are BQP-complete could be used to construct learning problems that are not classically learnable. There are many differences between their setting and ours and so whether or not similar arguments could be applied here requires careful work. Nonetheless, this cautiously hints towards the exciting possibility that there could still be useful situations where the implementation of parametrized circuits on quantum hardware can be used to achieve an exponential advantage.


= CONCLUSIONS
<conclusions>


The arrival of variational quantum algorithms effectively democratized the world of quantum computing. Whereas coming up with new conventional quantum algorithms requires a careful consideration of how best to manipulate and extract quantum information, proposing a new variational quantum algorithm is relatively straightforward. One can simply identify a potential loss function and a circuit ansatz to use. The hard work of minimizing that cost is offloaded to a classical optimizer, reducing the burden both on the quantum computer and on the quantum researcher, or so it was hoped.


While the hopes for this approach were largely fueled by the overwhelming success of neural networks in classical machine learning, it did not take long for the community to realize that variational quantum computing can be significantly more challenging than its classical counterpart. In fact, as any practitioner can testify, actually performing the optimization for moderate-sized problems is frustrating. This opened the door to studying causes of untrainability, leading to the discovery of several sources of barren plateaus and how to avoid them. While this quest was in many ways fruitful, with numerous approaches identified, here we have argued that all of these approaches are at heart rather simple. More concretely, we have argued that the strategies for avoiding barren plateaus considered by the community so far lead to algorithms that effectively live in polynomially sized subspaces. From here, one can do away with parameterized quantum circuits and instead simulate the algorithms classically (potentially after an initial data acquisition stage on quantum hardware).


Our argument here at times borders on trivial, and may be---in some form, or another---already known to many. However, the connection between the absence of barren plateaus and simulability still has not permeated the field's Zeitgeist, and it is not uncommon to find claims where the absence of barren plateaus is equated with practical usefulness. In this manner, our conclusions push against current practice in the community and the net result is that variational quantum algorithms need a rethink.


#emph[So, where does this leave us?] One path forward is to embrace our case-by-case argument as something positive. While some classical simulations have been performed~@bermejo2024quantum @angrisani2024classically @lerch2024efficient @anschuetz2024arbitrary @mele2024noise @shin2024dequantising @ermakov2024unified @miller2025simulation, much work remains to be done in this field of "quantum machine learning dequantization". Moreover, the fact that a quantum computer is generally not required to implement the parameterized quantum circuit, but might be needed for an initial data acquisition stage, makes such algorithms much easier to implement. To take advantage of this opportunity will require research into how to best perform the data acquisition stage and how to best perform the classical simulation needed to optimize the loss. Moreover, careful analytic work will be required to understand the scaling of the classical simulation algorithms. It may well turn out that simulating the parametrized quantum circuit on quantum hardware enjoys polynomial advantages over our best classical algorithms.


Alternatively, one could rally against our arguments here and strive harder to identify potential avenues for achieving a provable exponential quantum advantage with parameterized quantum circuits. Of course, there are numerous classically hard quantum circuits and so it's natural to ask: #emph[Can't this be used to show that there are variational quantum algorithms that are barren plateau-free but not classically simulable even with data from quantum experiments?] Indeed, we showed that this is possible for a few contrived examples. The key question is whether the non-simulability of quantum circuits can be used more generally to construct useful, trainable, and non-classically simulable variational quantum algorithms. To achieve this we should seek to draw inspiration from conventional fault-tolerant quantum algorithms, and carefully consider how best to manipulate information in the exponentially large spaces in which quantum operators live. Variational quantum computing may still be a viable line of research in this regard but it will require a principled approach and a healthy dose of imagination.


Finally, our focus here has been on analytically studying the scaling of variational quantum algorithms because we simply do not currently have the hardware to study how these algorithms perform for problem sizes we are actually interested in. However, there might be cases where, although we cannot prove that an algorithm does not have a barren plateau, training is possible. Indeed, this is the case for classical machine learning, whose heuristic success goes well beyond what can be guaranteed analytically. As such, there could be architectures which we do not know how to simulate, and where we cannot prove they are barren plateau-free, and yet seem to work in practice.


We hope this perspective encourages the community to pause, reflect and take a more principled approach to variational quantum computing.


= ACKNOWLEDGMENTS
<acknowledgments>


We are extremely grateful to Hsin-Yuan Huang for his invaluable contributions to this work. We thank Andrew Sornborger, Lukasz Cincio, Nathan Wiebe, Chae-Yeun Park, Nathan Killoran, Maria Schuld, Xanadu's Toronto office staff, and the QTML 2023 community for thoughtful and insightful conversations.


M.C. acknowledges support from Los Alamos National Laboratory (LANL) ASC Beyond Moore's Law project.


M.L. was supported by the Center for Nonlinear Studies at LANL.


M.C., D.G.M., N.L.D. and P.B. were supported by Laboratory Directed Research and Development (LDRD) program of LANL under project numbers 20230527ECR and 20230049DR.


Also, N.L.D. acknowledges support from CONICET Argentina,


and P.B acknowledges support of DIPC.


A.I. acknowledges support by the U.S. Department of Energy (DOE) through a quantum computing program sponsored by the LANL Information Science & Technology Institute and by the U.S. DOE, Office of Science, Office of Advanced Scientific Computing Research, under Computational Partnerships program. E.F. acknowledges the support of the UK department for Business, Energy and Industrial Strategy through the National Quantum Technologies Programme, and the support of an industrial CASE (iCASE) studentship, funded by the Engineering and Physical Sciences Research Council (grant EP/T517665/1), in collaboration with the University of Strathclyde, the National Physical Laboratory, and Quantinuum.


E.R.A.~acknowledges support from the Walter Burke Institute for Theoretical Physics at Caltech. S.T. and Z.H. acknowledge support from the Sandoz Family Foundation-Monique de Meuron program for Academic Promotion. ST further acknowledges the grants for development of new faculty staff, Ratchadaphiseksomphot Fund, Chulalongkorn University [grant number 3230120336 DNS\_68\_052\_2300\_012], as well as funding from National Research Council of Thailand (NRCT) [grant number N42A680126]. M.C., Z.H., and E.R.A. thank the organizers of the PennyLane Research Retreat, where part of this work was undertaken, for their hospitality.


This material is based upon work supported by the U.S. Department of Energy, Office of Science, National Quantum Information Science Research Centers, Quantum Science Center (LC). This work was also supported by the Quantum Science Center (QSC), a National Quantum Information Science Research Center of the U.S. DOE.


#heading(level: 1, numbering: none)[AUTHOR CONTRIBUTIONS]
<author-contributions>
The project was conceived by MC, ML, and ZH. Theoretical results were derived by MC, NLD, and ERA. All authors contributed to the manuscript review process.


#heading(level: 1, numbering: none)[DATA AVAILABILITY]
<data-availability>
No data was generated.


#heading(level: 1, numbering: none)[COMPETING INTERESTS]
<competing-interests>
The authors declare no competing interests.














]
#pagebreak()
#columns(2, gutter: 15pt)[
#set text(size: 9pt)
#set par(leading: 0.5em, spacing: 0.5em)
#bibliography("refs.bib", style: "american-physics-society", title: none)
]

#pagebreak()
#counter(math.equation).update(0)
#set math.equation(numbering: (n) => "(A" + str(n) + ")")
#set heading(numbering: (..n) => {
  let p = n.pos()
  if p.len() == 2 { numbering("1.", p.at(1)) }
  else { numbering("a.", p.at(2)) }
})
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(hyphenate: false)
#show heading.where(level: 1): set block(above: 1.6em, below: 1.0em)
#show heading.where(level: 2): set align(center)
#show heading.where(level: 2): set block(above: 2.6em, below: 1.6em)
#show heading.where(level: 3): set align(center)
#show heading.where(level: 3): set text(style: "italic")
#show heading.where(level: 3): set block(above: 2.2em, below: 1.2em)
#show math.equation.where(block: true): set block(above: 10pt, below: 10pt)
#heading(level: 1, numbering: none)[SUPPLEMENTAL INFORMATION FOR “DOES PROVABLE ABSENCE OF BARREN PLATEAUS IMPLY CLASSICAL SIMULABILITY?”]
<supplemental-information-for-does-provable-absence-of-barren-plateaus-imply-classical-simulability>

#v(0.4em)
#heading(level: 1, numbering: none)[Supp. Info. A: Barren plateau-free models, polynomial subspaces, and simulation algorithms]
<barren-plateau-free-models-polynomial-subspaces-and-simulation-algorithms>


We now present an analysis for each architecture and technique in Tables 1 and 2. In all cases we begin by defining the problem class of interest, reviewing the proof of absence of barren plateaus (i.e., determining the measurement operators and initial states leading to non-exponential concentration), and using this information to find the polynomially-large subspace. We then present tomographic techniques that can allow us to obtain the projection of the initial state onto the relevant subspace, and some appropriate simulation algorithms that can be used to classically compute the loss. In particular, here we show that that loss functions in Tables 1 and 2 are in $upright("QESIM")$.


== Small dynamical Lie algebras
<apx:smalldla>


Since several examples in Tables 1 and 2 fall inside of this category, we find it convenient to first present the abstract case of circuits with small dynamical Lie algebras.


We begin by (very briefly) reviewing some preliminary concepts that will be useful throughout the rest of the Appendices. We note that the goal of this perspective article is not to delve on mathematical details. As such, we will simply define the #emph[dynamical Lie algebra] of a circuit, and also what an #emph[equivariant] operator is. We refer the reader to the cited articles for further details.


First, let us assume that the parametrized quantum circuit takes the form


$ U ( bold(theta) ) = product_(l = 1)^L e^(- i theta_l H_l) thin , $<ap-eq:basicansatz>


where $bold(theta) = ( theta_1 , theta_2 , dots.h )$ are the trainable parameters, and $H_l$ Hermitian operators taken from some set of generators $cal(G)$. We note that Eq.~#ref(<ap-eq:basicansatz>, supplement: none) can also capture an ansatz with fixed, un-parametrized, layers by setting some of the parameters to be constant. It is known that one can measure the potential expressivity of a circuit by analyzing its dynamical Lie algebra~@zeier2011symmetry @larocca2021diagnosing @wiersema2023classification @kokcu2024classification @aguilar2024full @kazi2024analyzing


$ frak(g) = chevron.l i cal(G) chevron.r_(upright("Lie")) thin , $<ap-eq:dla>


where $chevron.l dot.op chevron.r_(upright("Lie"))$ denotes the Lie closure. As such, $frak(g) subset.eq frak(u) ( 2^n )$ is the real vector space spanned by the nested commutators of the elements in $i cal(G)$. Here $frak(u) ( 2^n )$ denotes the unitary algebra on the Hilbert space of $n$ qubits. The importance of $frak(g)$ stems from the fact that any unitary produced by the circuit (for any number of layers $L$, and for any set of parameters $bold(theta)$) is contained in the subgroup generated by $frak(g)$, i.e., $U ( bold(theta) ) in e^(frak(g))$.


Recently, it was realized that too expressive circuits (where $frak(g)$ is exponentially large) are prone to exhibit barren plateaus~@holmes2021connecting @larocca2021diagnosing @fontana2023theadjoint @ragone2023unified. As such, a significant amount of effort has been dedicated to understanding how the expressivity of the circuit could be reduced. One of the most promising approaches is to create circuits that respect a given symmetry group $S$~@larocca2022group @meyer2022exploiting @skolik2022equivariant @nguyen2022atheory @ragone2022representation @zheng2021speeding @east2023all. This led to the concept of #emph[equivariant] circuits, where all the circuit's generators commute with the all the elements in $S$. More generally, we say that any operator is equivariant if it commutes with all the elements in $S$.


With the previous, definitions in mind, we denote by $cal(C)_("poly" frak(g))$ the class of all instances where the circuit's dynamical Lie algebra $frak(g)$ is simple and of polynomial dimension, i.e., $upright("dim") ( frak(g) ) in cal(O) ( "poly" ( n ) )$. We take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state, and $O$ some Hermitian operator. All the gates in the circuit are parametrized, and every parameter is sampled uniformly at random. We further assume that either $rho$ or $O$ are in $i frak(g)$.


Recently, an exact formula for deep versions of the circuits in $cal(C)_("poly" frak(g))$ was simultaneously obtained in Refs.~@fontana2023theadjoint @ragone2023unified. In particular, these works show that the variance is inversely proportional to $upright("dim") ( frak(g) )$, as conjectured in Ref.~@larocca2021diagnosing. Moreover, if the projection of $rho$ and $O$ in $i frak(g)$ is at most polynomially vanishing with the number of qubits, then it is guaranteed that a barren plateau will not appear. That is,


$ cal(C)_("poly" frak(g)) subset overline("BP") , quad "if the projection of" rho "or" O "in" i frak(g) "is in" Omega(upright("1/poly")(n)) . $


Notably, the relevant subspace in this case is the DLA itself. This follows from the fact a Lie algebra is closed under the adjoint action of its associated Lie group, i.e., if $g in frak(g)$, then $U g U^dagger in frak(g)$ for all $U in e^(frak(g))$. Consequently, if $O$ (or $rho$) is in $i frak(g)$, the adjoint action of the group on it will result in an operator that lives inside the polynomially sized subspace. Hence,


$ cal(C)_("poly" frak(g)) subset cal(C)_(upright("polySub")) thin . $


Next, one needs to obtain the projection of $rho$ and $O$ into the dynamical Lie algebra (denoted as $rho_(frak(g))$ and $O_(frak(g))$, respectively), which requires computing the inner product of the initial state and the measurement operator with the elements of a basis of $i frak(g)$. Such computation will generally be case dependent, but or all cases considered we have always found an efficient tomographic procedure (see below for more information). From here, we can employ a recently introduced classical simulation algorithm called $frak(g)$-sim~@somma2006efficient @goh2023lie, which allows us to (back-)propagate the elements of the dynamical Lie algebra with unitaries of the Lie group. For this algorithm to work, one needs to compute the structure constants of the algebra. Importantly, computing these constants takes a time that scales polynomially in $upright("dim") ( frak(g) )$. Thus, this suffices to show that


$ cal(C)_("poly" frak(g)) subset upright("QESIM") thin . $


We remark here that even if obtaining the structure constants takes polynomial time, such computational cost may still be prohibitively large~@anschuetz2022efficient. It is then possible that polynomial speed-ups could be obtained by running the quantum circuit in the quantum computer instead.


Here we find it important to note that we have assumed above that the Lie algebra is simple. However, $frak(g)$ will generally decompose as a direct sum of simple Lie algebras (plus an abelian component) as $frak(g) = xor_eta frak(g)_eta$. Here, barren plateaus can be avoided (and thus simulations are enabled) if at least one of the simple components is polynomially large, and $rho$ and $O$ have large projections therein.


As we will see below, the following examples from Tables 1 and 2 actually avoid barren plateaus by having a small Lie algebra: $U ( 1 )$-equivariant; and $S_n$-equivariant.


=== $U ( 1 )$-equivariant circuit
<u1-equivariant-circuit>


First, let us note that by $U ( 1 )$-equivariant circuits, we mean circuits that preserve the Hamming weight of a computational basis state. Hamming weight-preserving circuits have seen use for quantum chemistry, condensed matter, nearest centroid classification, portfolio optimization and hedging~@arrazola2022universal @johri2021nearest @lopez2022symmetric @cherrat2023quantum.


We define as $cal(C)_(upright("U") thin upright("(") thin upright("1") thin upright(")") equiv)$ the class of all instances where the circuit is $U ( 1 )$-equivariant, and is composed of Hamming weight preserving local gates. We take $rho$ to be an $n$-qubit pure state with fixed Hamming weight $k$ preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state, and $O$ some $U ( 1 )$-equivariant operator. All the gates in the circuit are parametrized, and every parameter is sampled uniformly at random.


Several proofs of absence of barren plateaus for $U ( 1 )$-equivariant have been presented in the literature~@larocca2021diagnosing @monbroussou2023trainability @cherrat2023quantum. Crucially, they all somewhat rely on the fact that the restriction of the dynamical Lie algebra into the subspace with $k$ Hamming weight can be, at most, of dimension $cal(O) ( binom(n, k)^2 )$, meaning that a necessary condition for the loss function to not exhibit barren plateaus is that the initial state's Hamming weight is not too large. Note that bitstrings with Hamming weight $n - k$ can trivially be mapped to bitstrings of Hamming weight $k$ by flipping all bits, and, while our following statements equally apply to Hamming weight $n - k$, we will focus on the case of Hamming weight $k lt.eq n / 2$. As such, one finds


$ cal(C)_("U(1)equiv") subset overline("BP") , quad "if the Hamming weight" k "of" rho "is such that" k in cal(O)(1) . $


The previous description allows us to readily identify the polynomially small subspace. Namely, since the initial state has fixed Hamming weight $k$ and since the unitary and measurement preserve such Hamming weight, then all of the dynamics occur in the Hilbert's subspace of states with Hamming weight $k$. Moreover, we know that the dimension of such subspace is $binom(n, k)$, which is in $cal(O) ( "poly" ( n ) )$ provided that $k in cal(O) ( 1 )$. Hence, $forall bold(theta)$ one has


$ cal(C)_(upright("U") thin upright("(") thin upright("1") thin upright(")") equiv) subset cal(C)_(upright("polySub")) thin . $


From here, we can perform tomography of $rho$ and $O$ in a basis of Hamming weight $k$ states to obtain an efficiently storable description in the polynomial-sized subspace. Moreover, while we can use $frak(g)$-sim to simulate the loss functions in $cal(C)_(upright("U") thin upright("(") thin upright("1") thin upright(")") equiv)$, here we can also obtain the action of $U ( bold(theta) )$ in the subspace by studying how each local gate acts on a computational basis state, a procedure that is highly efficient (see Ref.~@kerenidis2021classical for an example with Givens rotations). These ingredients then suffice to show that


$ cal(C)_(upright("U") thin upright("(") thin upright("1") thin upright(")") equiv) subset upright("QESIM") thin . $


=== $S_n$-equivariant
<s_n-equivariant>


Many problems in physics, machine learning, and quantum metrology have properties that remain invariant under any possible permutation of the $n$ qubits in the system. As such, studying these problems variationally will require the use of parametrized quantum circuits that are equivariant with respect to $S_n$, the symmetric group acting on $n$ qubits via qubit permutation~@larocca2022group.


We define as $cal(C)_(upright("Sn") equiv)$ the class of all instances where the circuit is composed of $S_n$-equivariant layers of one and two-qubit gates. We take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state, and $O$ some $S_n$-equivariant operator. All the gates in the circuit are parametrized, and every parameter is sampled uniformly at random.


In Ref.~@kazi2024analyzing the authors studied the dynamical Lie algebra associated to the unitaries used in $cal(C)_(upright("Sn") equiv)$ and determined that $upright("dim") ( frak(g) ) in cal(O) ( n^3 )$. In particular, the absence of barren plateaus for this problem class was studied and proved in Ref.~@schatzki2022theoretical, where, as expected, the authors found that


$ cal(C)_("Sn" thin "equiv") subset overline("BP") , quad "if the projection of" rho "in" i frak(g) "is in" Omega(upright("1/poly")(n)) . $


Since the measurement operator is in the algebra, and since the unitary cannot take $O$ outside of the algebra, we find that the subspace is proper for all $bold(theta)$ and thus


$ cal(C)_(upright("Sn") equiv) subset cal(C)_(upright("polySub")) thin . $


As discussed above, the simulation can be performed via $frak(g)$-sim provided that we can compute the components of the initial state and measurement operator in the Lie algebra. Notably, this information can be obtained via the tomographic procedure of permutation invariant shadows introduced in Ref.~@toth2010permutationally, indicating that


$ cal(C)_(upright("Sn") equiv) subset upright("QESIM") thin . $


== Matchgate circuit and small modules
<apx:matchgate>


Matchgate circuits, also known as fermionic linear optics circuits, are circuits whose gates can be mapped to free fermion evolution @jozsa2008matchgates. Their parameterized version ~@wan2022matchgate @de2013power @oszmaniec2022fermion @cherrat2023quantum @diaz2023parallel has received considerable attention in variational quantum computing as a test bed for benchmarking different ideas~@larocca2021theory. Crucially, the study of quantum resources and simulability of matchgate circuits ~@bravyi2004lagrangian @dias2023classical @cudby2023gaussian @gigena2015entanglement has been recently related to the theory of barren plateaus @diaz2023showcasing.


We denote by $cal(C)_(upright("match"))$ the class of all instances where the circuit is a parametrized matchgate circuit composed of parametrized rotations about the $z$ axis and parametrized entangling $X X$ gates on neighboring qubits. We take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state, and $O$ some Pauli operator. All of the gates in the circuit are parametrized, and every parameter is sampled uniformly at random.


The presence and absence of barren plateaus in parametrized matchgate circuits was originally empirically studied in Refs.~@wiersema2020exploring @larocca2021diagnosing, with a recent full characterization presented in Ref.~@diaz2023showcasing. In particular, it is well known that the dimension of these circuits' dynamical Lie algebra scales as $cal(O) ( n^2 )$. This already means that, if $O$ or $rho$ are in $i frak(g)$, we know that barren plateaus can be avoided, as the algebra itself is the relevant polynomially small subspace. However, the underlying algebraic properties of this model allow us to precisely characterize the loss function variance for #emph[any] initial state and measurement operator. Here, the key realization is that under the adjoint action of the circuit's unitary, operator space $cal(B)$ decomposes into group-modules as $cal(B) = x⋁_(eta = 1)^(2 n) cal(B)_eta$, where the operators in $cal(B)_eta$ can be exactly characterized as the product of $eta$ Majorana operators, and thus is of dimension $binom(2 n, eta)$. Hence, if $eta in cal(O) ( 1 )$ for $eta lt.eq n$, or if $2 n - eta in cal(O) ( 1 )$ for $eta > n$, one obtains $upright("dim") ( cal(B)_eta ) in cal(O) ( "poly" ( n ) )$. In what follows, we will assume for simplicity $eta lt.eq n$. Note that these subspaces are proper for all $bold(theta)$. Assuming that $O$ is in some $cal(B)_eta$ we get


$ cal(C)_("match") subset overline("BP") , quad "if the projection of" rho "in" cal(B)_eta in Omega(upright("1/poly")(n)) "and" eta in cal(O)(1) . $


Here, identifying the small subspace is straightforward as the group modules are, by definition, closed under the adjoint action of the group. This allows us to say that if $eta in cal(O) ( 1 )$, then


$ cal(C)_(upright("match")) subset cal(C)_(upright("polySub")) thin . $


Next, we need to obtain the component of $rho$ into the module $cal(B)_eta$ (note that since $O$ is a Pauli in $cal(B)_eta$, we already have all the information we need from the measurement operator). Here, one simply needs to prepare $rho$ and measure the expectation value of all the Pauli operators that can be expressed as a product of $eta$ distinct Majoranas. Such a procedure is efficient if $eta in cal(O) ( 1 )$. Then, we can obtain the adjoint action of the unitary in each module by computing the commutator graphs~@diaz2023showcasing (or generalized structure constants) and using $frak(g)$-sim. The classical cost here scales polynomially with the dimension of the module, and is therefore polynomial in the number of qubits. Hence, we have


$ cal(C)_(upright("match")) subset upright("QESIM") thin . $


== Shallow hardware efficient ansatz
<apx:hea>


Since the shallow hardware efficient ansatz was presented in the main text, we only recap it briefly here for completeness. \


First, we recall that as shown in Ref.~@cerezo2020cost, and also at the end of this Supplemental Information, one can prove that


$
cal(C)_(upright("shallowHEA")) subset overline(upright("BP")) #h(0.17em) #h(0.17em) #h(0.17em) upright("if ") rho upright(" follows area law and O is local") .
$


Moreover, since the measurement operator is local, the bounded light cone structure of a shallow hardware efficient ansatz means that the adjoint action of the circuit can only map the measurement operator to Paulis acting on at most $2 L in cal(O) ( log ( n ) )$ qubits. There are $cal(O) ( "poly" ( n ) )$ such operators and so the resulting subspace is a proper polynomial-sized subspace for any $bold(theta)$. Hence


$ cal(C)_(upright("shallowHEA")) subset cal(C)_(upright("polySub")) thin . $


To perform an efficient classical simulation of the loss we can obtain the adjoint action of the circuit in the subspace by 'dropping' from $U ( bold(theta) )$ all the gates that are outside of the measurement's backwards light cone. Then, the final step is to determine $rho_lambda$. If $rho$ has a known classical representation, then one can classically find its projection onto the subspace by computing (e.g., via pen and paper or using classical computing power) the expectation value for all operators $P_j in cal(B)_lambda$. However, if $rho$ is some state obtained at the output of a give circuit, these expectation values cannot generally be obtained classically. However, with access to a quantum computer one can efficiently estimate $rho_lambda$ using local tomography of the reduced states. Notably instead of performing full tomography, one can also perform standard Pauli classical shadow tomography~@huang2020predicting @elben2022randomized That is, we prepare $rho$, and implement randomly selected single-qubit Clifford gates on each qubit, and measure them in the computational basis. Since we care about estimating the expectation value of polynomially many local operators, this tomographic procedure is efficient. As such, we find


$ cal(C)_(upright("shallowHEA")) subset upright("QESIM") thin . $


It follows that no problem based on shallow hardware efficient ansätze with a local measurement can be outside of $upright("QESIM")$. We note that this result was originally reported in Ref.~@basheer2022alternating, with similar ideas explored concurrently in the context of quantum process learning in Ref.~@jerbi2023power.


=== Quantum generative modeling
<apx:generative>


Quantum generative modeling is a sub-field of quantum machine learning where the goal is to learn an unknown probability distribution underlying a classical dataset, with the hope that the trained model can be utilized to generate new data samples that closely match the original data~@benedetti2019generative @coyle2020born @alcazar2020classical @benedetti2019adversarial @perdomo2018opportunities @zoufal2021generative. While several schemes exist for quantum generative modeling, we will here focus on quantum circuit generative models, which include quantum circuit Born machines (QCBMs) and quantum generative adversarial networks (QGANs). In these models, one prepares a parametrized quantum state that encodes the desired distribution over computational basis measurements. It has been shown that these models can avoid barren plateaus by using losses that contain significant local contributions, which, in conjunction with a shallow hardware efficient ansatz, guarantees non-exponential concentration~@rudolph2023trainability @letcher2023tight.


We define as $cal(C)_(upright("gen"))$ the class of all instances where the circuit is a shallow one-dimensional hardware efficient ansatz composed of $L in cal(O) ( log ( n ) )$ layers of two-qubit gates acting on neighboring-qubits in a brick-layered structure. Moreover, we take $rho$ to be the all-zero state, and $O$ to be a weighted sum of projectors onto computational basis states. Here, we further assume that all the gates in the circuit are parametrized, and every parameter is sampled uniformly at random.


The loss functions in $cal(C)_(upright("gen"))$ can be simulated using the fact that the whole circuit can be efficiently represented via tensor networks~@markov2008simulating. In particular, the all-zero state, when evolved by a shallow one-dimensional hardware efficient ansatz up to $cal(O) ( log ( n ) )$ depth, admits an efficient matrix product state~@verstraete2008matrix description (a proper subspace) for all $bold(theta)$. That is,


$ cal(C)_(upright("gen")) subset cal(C)_(upright("polySub")) thin . $


Moreover, since there is no need for tomographic measurements, and since sampling from the output distribution of an MPS is efficient~@ferris2012perfect @stoudenmire2010minimally, one has


$ cal(C)_(upright("gen")) subset upright("CSIM") thin . $


== Generic shallow locally circuits
<generic-shallow-locally-circuits>


Here, by generic shallow locally circuits we refer to circuits where local two-qubit gates act according to some arbitrary topology, and where, there is a path that connects the input state with the measurement operator that crosses, at most, $cal(O) ( log ( n ) )$ such gates. This architecture encompasses hardware efficient ansatz in one-dimension, quantum convolutional neural networks, but also more general circuits where gates can act according to a generic topology (i.e, 2D and beyond). Importantly, the fact that the gate connectivity is arbitrary means that light-cone arguments such as ones previously presented for the shallow hardware efficient ansatz do not hold.


Let us then define as $cal(C)_(upright("slocal"))$ the class of all instances where the parameterized quantum circuit is built from local gates acting on pairs of qubits according to some arbitrary topology. We then take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state, and the measurement operator $O$ to be a local Pauli acting on a qubit at the circuit's output. We assume that the parameters are sampled such that each gate forms an independent $2$-design over $S U ( 4 )$.


The proof of absence of barren plateaus for these architectures can be derived with the results in~@napp2022quantifying @zhang2023absence, but for completeness, we also present a proof at the end of this Supplemental Information (Appendix~C). As shown therein, if the initial state is pure and satisfies an area law of entanglement, we find


$
cal(C)_(upright("slocal")) subset overline(upright("BP")) #h(0.17em) #h(0.17em) #h(0.17em) upright("if ") rho upright(" follows an area law of entanglement") .
$


Moreover, the scrambling nature of the circuit effectively suppresses the contribution of high weight Paulis and the dynamics occur in a subspace composed of Paulis with $cal(O) ( 1 )$-bodyness qubits, so that


$ cal(C)_(upright("slocal")) subset cal(C)_(upright("polySub")) thin . $


For a rigorous proof see Ref.~@angrisani2024classically. Then, the component of the initial state therein can be obtained via classical shadows, and the simulation follows as a direct application of the algorithm in~@angrisani2024classically, showing that


$ cal(C)_(upright("slocal")) subset upright("QESIM") thin . $


== Small angle initialization
<apx:smallangle>


A recurring theme in this and the following sections will be how to classically simulate the loss function values for effective polynomial subspaces for problem classes in $upright("QESIM")$ without relying on strong symmetries as in Secs.~#ref(<apx:smalldla>, supplement: none) & #ref(<apx:matchgate>, supplement: none) or small entanglement light cones such as in Sec.~#ref(<apx:hea>, supplement: none). Broadly speaking, one can either #emph[forward] propagate the initial state $rho$ (or measurements of it) through the circuit, or #emph[backward] propagate the measurement operator $O$ in order to estimate the loss $ell_(bold(theta)) ( rho , O )$.


If no tomography of the initial state is needed, i.e., if an efficient MPS or MPS representation is known, the approach of forward propagation can be especially efficient in practice. For quantum circuits with local entangling gates and at most $cal(O) ( log ( n ) )$ layers, the bond dimension of the tensor network will not grow to be exponentially large~@markov2008simulating, but even beyond log-depth circuits, high quality approximation with polynomial bond dimension may be possible. If a polynomial number of measurements of a non-trivial initial state are given, e.g., using standard Pauli classical shadows~@huang2020predicting, we notice that we can represent each measurement as an efficient matrix product operator (MPO)~@verstraete2006matrix @evenbly2011tensor with bond dimension $chi = 1$. The loss function $ell_(bold(theta)) ( rho , O )$ then becomes an average over all measurements from the quantum computer and their corresponding forward propagated MPOs.


On the flip side, one can also backward propagate the target operator through the quantum circuit, which may be particularly efficient in practice if $O$ is relatively simple in some basis (e.g., the Pauli basis) and one has to collect measurements from a non-trivial initial state $rho$. This can again be done using tensor networks in the form of MPOs or using methods, such as Pauli Propagation~@fontana2023classical @rudolph2023classical, which work using the Pauli transfer matrix formalism~@nemkov2023fourier @beguvsic2023simulating @beguvsic2023fast.





The above techniques could be used for the classical simulation of both small angle initializations (discussed in this section) and QCNNs (discussed in the next section). Small angle initializations have been an increasingly popular strategy aimed at replacing the most commonly used random angle initialization techniques. Here we will be focusing on two of them: Hamiltonian variational ansatz with small angles and Gaussian initialization in deep variational quantum circuits.


=== Hamiltonian variational ansatz
<hamiltonian-variational-ansatz>


The Hamiltonian variational ansatz was proposed in Ref.~@wecker2015progress as a problem-inspired circuit to find the ground state of a given target Hamiltonian $H$. Here, one splits $H$ into a sum of terms $H = sum_(i = 1)^M alpha_i h_i$, and builds the circuit as $U ( bold(theta) ) = product_(l = 1)^L product_(i = 1)^M e^(- i theta_(l , i) H_i)$, leading to a circuit that somewhat resembles a Trotterized evolution.


Let us define as $cal(C)_(upright("HVA"))$ the class of all instances where the parameterized quantum circuit is built is a Hamiltonian variational ansatz for a given $H$, which can be expressed as $H = sum_(i = 1)^M alpha_i h_i$. We assume that each $h_i$ is a $k$-local operator. We then take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state and the observable to be local, and the measurement operator $O$ to be a local Pauli. We assume that the parameters are sampled in a region around zero whose width scales as $cal(O) ( 1 / ( n M L ) )$.


The proof of absence of barren plateaus is given in Ref.~@park2023hamiltonian, where such parametrized quantum circuit is shown to be equivalent to a time evolution driven by a single $k$-local Hamiltonian. In this new framework, the loss can be shown to avoid barren plateaus if the initial state is pure and satisfies an area law of entanglement. Hence, we have


$
cal(C)_(upright("HVA")) subset overline(upright("BP")) #h(0.17em) #h(0.17em) #h(0.17em) upright("if ") rho upright(" follows an area law of entanglement") .
$


Given that $U ( bold(theta) )$ implements a short time evolution, the adjoint action of $U ( bold(theta) )$ on $O$ lives, with high probability for $bold(theta) tilde cal(P)$ , in an effective polynomially-sized subspace of operators acting on $cal(O) ( 1 )$ qubits (see the proof of Theorem~4 in Ref~@lerch2024efficient for a detailed proof). Thus, one has


$ cal(C)_(upright("HVA")) subset cal(C)_(upright("polySub")) med . $


Since the operators in the small subspace are all acting on at most $cal(O) ( 1 )$ qubits, we can utilize standard Pauli classical shadows on the initial state~@huang2020predicting. Then, since the parametrized quantum circuit can effectively be expressed as $U ( bold(theta) ) tilde.eq e^(- i K tau)$, where $K$ is a $k$-local Hamiltonian ($k in cal(O) ( 1 )$) and $tau in cal(O) ( 1 / n )$, we know that the entanglement generated by the circuit is bounded, and we can efficiently compute the loss function via tensor networks or Pauli Propagation methods (with time and sample complexity guarantees provided by Theorems 2 and 4 in Ref.~@lerch2024efficient). Hence,


$ cal(C)_(upright("HVA")) subset upright("QESIM") thin . $


=== Gaussian initialization in deep variational quantum circuits
<gaussian-initialization-in-deep-variational-quantum-circuits>


Next, let us define as $cal(C)_(upright("GI"))$ the class of all instances where the parametrized quantum circuit is built employing $L$ layers of single qubit parametrized rotations followed by an entangling layer of controlled $Z$ gates. We take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state and the observable to be local, and the measurement operator $O$ to be a local Pauli. We assume that the parameters are sampled according to a Gaussian distribution centered around zero and with variance in $cal(O) ( 1 / L )$.


The proof of absence of barren plateaus for this initialization technique was presented in Ref.~@zhang2022escaping, where the authors find that exponential concentration is avoided if $rho$ satisfies an area law of entanglement. Therefore, one has


$
cal(C)_(upright("GI")) subset overline(upright("BP")) #h(0.17em) #h(0.17em) #h(0.17em) upright("if ") rho upright(" follows an area law of entanglement") #h(0.17em) .
$


When the parameters are sampled from a Gaussian distribution whose width decreases with the circuit depth, then the adjoint action of the unitary on the measurements operator lives, with high probability for $bold(theta) tilde cal(P)$, in a low magic subspace. Concretely, as proven in Ref.~@lerch2024efficient, it belongs to an effective subspace composed of operators acting on $cal(O)(upright("poly")(n))$ qubits that can be efficiently classically identified using the small-angle Pauli Propagation algorithm. It follows that


$ cal(C)_(upright("GI")) subset cal(C)_(upright("polySub")) med . $


This trade-off between the range of parameter values and circuit depth renders the quantum circuit effectively simulated with low magic simulation algorithms~@lerch2024efficient @beguvsic2024fast. Again we might need to perform Pauli measurements on the initial state $rho$. Putting these results together leads to


$ cal(C)_(upright("GI")) subset upright("QESIM") thin . $





We note that Ref.~@wang2023trainability also proves a trainability guarantee for small angle initialization in an ansatz composed of alternating controlled Z layers and single qubit rotations. One can show that this is classically simulable by a similar argument to the one above.


== Quantum convolutional neural networks
<quantum-convolutional-neural-networks>


Quantum convolutional neural networks (QCNNs) are a type of circuit architecture introduced in Ref.~@cong2019quantum which has seen widespread use in supervised classification problems on both classical and quantum data~@cong2019quantum @caro2021generalization @liu2023model @hur2021quantum @umeano2023can. A QCNN is composed of parametrized gates acting on nearest neighbors which are interleaved with pooling layers where qubits are either measured or traced-out. Due to the way this architecture is constructed, its depth always scales logarithmically with the number of qubits, and the measurement operator is always local.


=== Standard QCNN with tracing-out pooling layers
<standard-qcnn-with-tracing-out-pooling-layers>


Let us define as $cal(C)_(upright("QCNN"))$ the class of all instances where the circuit is a QCNN composed of layers of two-qubit gates acting on nearest neighbors which are interleaved with pooling layers where half of the qubits are traced-out. We take $rho$ to be an $n$-qubit state preparable by a circuit with $cal(O) ( "poly" ( n ) )$ gates when acting on the all-zero state, and $O$ some Pauli operator acting on the last two qubits of the QCNN. All of the two-qubit gates in the circuit are parametrized, and every parameter is sampled uniformly at random. We assume that randomly sampling the parameters leads to all of the gates forming independent local $2$-designs.


The proof of absence of barren plateaus for QCNNs can be found in Ref.~@pesah2020absence, but can also be derived with the tools presented at the end of this Supplemental Information (Appendix~C). Therein, the authors showed that if all of the two-qubit gates in the circuit form independent local $2$-designs, then the loss function will not exhibit a barren plateau provided that the reduced states of $rho$ onto any pair of qubits are not exponentially close to the identity (e.g., if the initial state follows an area law of entanglement). Hence, we can find that


#set math.equation(numbering: none)
$
cal(C)_(upright("QCNN")) subset overline(upright("BP")) thin , #h(0.4em) upright("if ") rho upright(" follows an area law of entanglement") .
$
#set math.equation(numbering: (n) => "(A" + str(n) + ")")


With the previous, let us try to identify what are the relevant polynomial-sized subspaces under the QCNN's adjoint action. First, note that there always exists a set of parameters $bold(theta)_j$ such that the QCNN is able to transform the local Pauli operator $O$ into #emph[any] other Pauli $P_j$. That is,


$ forall P_j thin , upright("then ") exists bold(theta)_j thin thin upright("such that") thin thin 1 / d ⟨U^dagger ( bold(theta)_j ) O U ( bold(theta)_j ) , P_j⟩ = 1 thin . quad $


While this equation indicates that the adjoint action allows us to reach exponentially many Pauli operators, this does not mean that the adjoint action will typically lead to exponentially large subspaces. Indeed, one can verify that, with high probability for $bold(theta) tilde cal(P)$, $U^dagger ( bold(theta) ) O U ( bold(theta) )$ will live in an effective polynomially large subspace whose basis is composed of Pauli of operators acting on at most $cal(O) ( 1 )$ qubits~@bermejo2024quantum @angrisani2024classically. Thus, with high probability for some $bold(theta) tilde cal(P)$, the QCNNs adjoint action over the measurement leads to an effective polynomially-sized subspace, and so


$ cal(C)_(upright("QCNN")) subset cal(C)_(upright("polySub")) thin . $


Given that the small subspace contains operators acting on a small number of qubits, we can again perform standard Pauli classical shadows on the initial state~@huang2020predicting to obtain a classical description. Then, since the circuit is composed of local gates, and contains at most $cal(O) ( log ( n ) )$ layers, we can simulate the loss via tensor networks or any of the techniques outlined at the beginning of Sec.~#ref(<apx:smallangle>, supplement: none). High-fidelity approximations of $O ( bold(theta) )$ likely require polynomial MPO bond dimension, and algorithms such as Pauli Propagation could employ a simple truncation based on operator weight which has for example been used in Refs.~@beguvsic2023fast @rudolph2023classical. Thus, we find


$ cal(C)_(upright("QCNN")) subset upright("QESIM") thin . $


Indeed, we note that the recent work of~@bermejo2024quantum has explicitly implemented the previous classical simulation method, effectively dequantizing the quantum convolutional neural network architecture.


=== QCNN with post-selected pooling layers
<qcnn-with-post-selected-pooling-layers>


Next we consider a class of QCNNs where the loss function depends on the outcomes of the measurements in the pooling layers; we denote this class of QCNNs as $cal(C)_(upright("pl") - upright("QCNN"))$. This setting is typically studied in the context of error-correction, where one wants to learn a circuit that optimizes recovery given some noise channel and logical state~@cong2019quantum. Here, the circuit is a QCNN composed of layers of two-qubit gates acting on nearest neighbors, interleaved with pooling layers where half of the qubits are measured and used to control single-qubit unitaries. While simulation is only available with high probability for the case of $cal(C)_(upright("QCNN"))$, we claim one can simulate those in $cal(C)_(upright("pl") - upright("QCNN"))$ for all parameter values; that is,


$ cal(C)_(upright("pl") - upright("QCNN")) subset upright("QESIM") thin . $<eq:pool_qcnn_subset>


We assume there are $p$ parameterized gates, each a $2$-qubit unitary; we denote the unitary implemented by the QCNN as $U_(bold(theta))$, where $bold(theta) in bb(R)^p$. In the post-selected setting the loss is some function of the expectation values of observables of the form:


$ O = sum_(bold(m) in cal(M) subset.eq (0 , 1)^(n - k)) O_(m_1 , dots.h , m_(n - k)) ⊗ | bold(m) chevron.r chevron.l bold(m) | $<eq:o_def_post_qcnn>


for some subset $cal(M) subset.eq (0 , 1)^(n - k)$ and $k$-local $O_(m_1 , dots.h , m_(n - k))$ (assumed to have bounded Hilbert--Schmidt norm). A typical example of this setting is when a QCNN is used to learn the decoder of a quantum error correcting code where, given a circuit $V$ encoding a logical $k$-qubit state $rho_L$, one maximizes the probability of correcting $t$ errors after an error channel $cal(N)$ is applied#cite(<cong2019quantum>):


$ f (bold(theta)) = sum_(bold(m) in (0 , 1)^n :\
∥bold(m)∥_1 lt.eq t) upright("Tr") (rho_L ⊗ | bold(m) chevron.r chevron.l bold(m) | U_(bold(theta)) cal(N) (V (rho_L ⊗ | 0 chevron.r chevron.l 0 |^(n - k)) V^dagger) U_(bold(theta))^dagger) . $


Here, the input to the QCNN is the $n$-qubit state $rho := cal(N) (V (rho_L ⊗ | 0 chevron.r chevron.l 0 |^(n - k)) V^dagger)$, $O_(m_1 , dots.h , m_(n - k)) = rho_L$, and (for constant $t$) $lr(|cal(M)|) = cal(O) (n^t)$.


While QCNNs are defined via real parameters---i.e., their parameters are of infinite precision---by a net argument~@caro2021generalization @jerbi2023power we can assume that each of the $p$ parameterized gates is drawn from a finite set $S_(p , epsilon.alt)$ of $2$-qubit gates up to incurring a total error $epsilon.alt$ in diamond distance. More concretely, Theorem~1 of the Supplemental Information of Ref.~@caro2021generalization states that such a net of cardinality:


$ S_(p , epsilon.alt) = cal(O) ("poly" (p / epsilon.alt)) $


exists. We thus assume this setting without loss of generality.


We now show Eq.~#ref(<eq:pool_qcnn_subset>, supplement: none) via the following theorem.


QQTHMBQQtheorem|Theorem| (Classical simulability of QCNNs)QQENDQQ


Fix $epsilon.alt , delta = "Θ" (1)$. Consider a QCNN with $p$ parameterized $2$-qubit gates drawn from $S_(p , epsilon.alt)$, and consider:


$ upright("Tr") (O U rho U^dagger) , $<eq:qcnn_loss>


where $O$ is as in Eq.~#ref(<eq:o_def_post_qcnn>, supplement: none), $U$ is a unitary implementing the QCNN parameterized by $p$ elements of $S_(p , epsilon.alt)$, and $rho$ is an $n$-qubit state. Using


$ N = cal(O) (lr(|cal(M)|)^2 / epsilon.alt^2 (p log (p / epsilon.alt) + log (lr(|cal(M)|)) + log (delta^(- 1)))) $


copies of $rho$, with probability at least $1 - delta$, one can construct a classical shadow representation of $rho$ that allows one to estimate Eq.~#ref(<eq:qcnn_loss>, supplement: none) to additive error $epsilon.alt$ over all parameter settings. This classical shadow representation can be constructed with no prior knowledge of $U$ or $O$.




#block[
#emph[Proof.] Consider a classical shadows description of $rho$ using the random Clifford basis protocol of Ref.~@huang2020predicting, built using~◻

]


$ N = frac(300 lr(|cal(M)|)^2 ∥O_(upright("max"))∥_(upright("F"))^2, epsilon.alt^2) (p ln (S_(p , epsilon.alt)) + ln (lr(|cal(M)|)) + log (2 delta^(- 1))) $


copies of $rho$. Here, $∥O_(upright("max"))∥_(upright("F"))$ is the maximal Hilbert--Schmidt norm of the $O_(m_1 , dots.h , m_(n - k))$, assumed to be $cal(O) (1)$. By Ref.~@huang2020predicting, this classical shadows description of $rho$ is of size $"poly" (N)$. Theorem S1 combined with Proposition S1 of @huang2020predicting guarantees that, with probability at least $1 - delta$, this classical shadows description suffices to estimate the expectation values of


$ M = S_(p , epsilon.alt)^p lr(|cal(M)|) $


observables with Hilbert--Schmidt norm upper-bounded by $∥O_(upright("max"))∥_(upright("F"))$ each to additive error $epsilon.alt / lr(|cal(M)|)$ in classical time $"poly" (N)$. All that remains is demonstrating that there are $M$ observables being measured with Hilbert--Schmidt norm upper-bounded by $∥O_(upright("max"))∥_(upright("F"))$ by this QCNN.


Now consider the set of $lr(|cal(M)|)$observables:


$ (O_(m_1 , dots.h , m_(n - k)) ⊗ | bold(m) chevron.r chevron.l bold(m) |)_(bold(m) in cal(M)) . $


The Hilbert--Schmidt norm of each $O_(m_1 , dots.h , m_(n - k))$ is upper-bounded by $∥O_(upright("max"))∥_(upright("F")) = cal(O) (1)$ by definition. By additionally counting all $S_(p , epsilon.alt)^p$ choices for $U$, there are thus $S_(p , epsilon.alt)^p lr(|cal(M)|)$ operators of the form:


$ U^dagger (O_(m_1 , dots.h , m_(n - k)) ⊗ | bold(m) chevron.r chevron.l bold(m) |) U $


with Hilbert--Schmidt norm upper-bounded by $∥O_(upright("max"))∥_(upright("F"))$. The considered classical shadows description of $rho$ thus suffices to estimate the expectation value of each $U^dagger (O_(m_1 , dots.h , m_(n - k)) ⊗ | bold(m) chevron.r chevron.l bold(m) |) U$ to additive error $epsilon.alt / lr(|cal(M)|)$ with probability at least $1 - delta$, and thus also of each $U^dagger O U$ to additive error $epsilon.alt$.






== Non-unital noisy-circuits
<non-unital-noisy-circuits>


Let us define as $cal(C)_(upright("non") - upright("u"))$ the class of all instances where the circuit is composed of two-qubit gates on a one-dimensional lattice, interleaved by local (single-qubit) noise, with a final layer of single-qubit gates. Furthermore, we assume that the noise is non-unital and contractive~@mele2024noise. We take $rho$ to be a generic $n$-qubit state, and the observable $O$ to be local. We assume that all parameters are sampled such that each gate forms an independent $2$-design.


As shown in~@mele2024noise, the effect of the non-unital noise is to effectively make the circuit shallow by "resetting" the qubits after each layer of parametrized gates. Indeed, as proved in Theorem 1 of ~@mele2024noise, one can only consider the last $cal(O) ( log ( n ) )$ layers of the circuit, after which one can use light-cone arguments to prove that


$ cal(C)_(upright("non") - upright("u")) subset overline(upright("BP")) thin . $


Similarly, since the measurement is local, the same light-cone arguments can be used to show that the Heisenberg-evolved measurement operator will act on operators acting on at most $cal(O) ( log ( n ) )$ qubits. That is,


$ cal(C)_(upright("non") - upright("u")) subset cal(C)_(upright("polySub")) thin . $


Finally, by either using the classical simulation algorithms of Ref.~@mele2024noise in the case of 1D circuits, or those in Refs.~@angrisani2024classically @schuster2024polynomial for arbitrary topologies, one obtains


$ cal(C)_(upright("slocal")) subset upright("QESIM") thin . $


== Parameterized Dynamic Circuit
<parameterized-dynamic-circuit>


Parameterised dynamic circuits make crucial use of #emph[feedforward] operations. A feedforward operation consists of a measurement on a qubit followed by a conditional gate: If the measurement outcome is $0$ then $U_0 = I$ is applied, if instead it is $1$, then $U_1$ is applied where


$ U_1 = mat(delim: "(", cos phi e^(- i phi.alt), - i sin phi; - i sin phi, cos phi e^(i phi.alt)) thin . $


Let us define $cal(C)_(upright("dyn"))$ as the class of all instances where the circuit implements a channel $cal(E) ( bold(theta) ) = cal(U)_d ( bold(theta)_d ) compose dots.h compose cal(U)_1 ( bold(theta)_1 )$, where each channel $cal(U)_j ( bold(theta)_j )$ is a completely positive, trace preserving map on $n$ qubits. The operations in each $cal(U)_j$ can be written as a composition of single-qubit and two-qubit operations in an arbitrary circuit topology. It is further assumed that:

+ Every component $theta_i in bold(theta)$ parameterizes only a single operation in $cal(E)$ (i.e., the parameters are independent and uncorrelated).

+ $cal(E)$ is locally scrambling, i.e., is invariant under single-qubit random gates from a unitary $2$-design after every gate.

+ $cal(E)$ has a constant worst-case feedforward distance. That is, we define $f$ be the shortest path from a qubit measurement to a feedforward operation through the backwards light cone of the measurement and take $f in O ( 1 )$.

+ $cal(E)$ has an average entangling power of $alpha$ and average swapping power $beta gt.eq 0$~@ware2023sharp.

Let $O$ be a $k$-local Hamiltonian with $k in log ( n )$ and let the initial state be arbitrary. \


Then, as shown in Ref.~@deshpande2024dynamic, similarly to the case of non-unital noise, the effect of the resets is to effectively make the circuit shallow by "resetting" the qubits after each layer of parametrized gates. However, in contrast to non-unital noise, these resets can be implemented in a controlled manner. Indeed, as proven in Theorem 1 of ~@deshpande2024dynamic, one finds that


$ cal(C)_(upright("dyn")) subset overline(upright("BP")) thin . $


Since these circuits are locally scrambling, the arguments of Ref.~@angrisani2023learning also apply here, thus providing bounds on the approximation error by considering only the reduced subspace. In particular, the mid circuit measurements at the core of dynamic circuits can be viewed as controlled two qubit rotations followed by qubit resets and thus can be absorbed into the setting considered in Ref.~@angrisani2023learning. Thus, we have


$ cal(C)_(upright("dyn")) subset cal(C)_(upright("polySub")) thin , $


and


$ cal(C)_(upright("dyn")) subset upright("QESIM") thin . $


#counter(math.equation).update(0)
#set math.equation(numbering: (n) => "(B" + str(n) + ")")
#heading(level: 1, numbering: none)[Supp. Info. B: Examples of non-concentrated but also non-simulable loss functions]
<apx:counterexample>


In this section we showcase an example of a non-concentrated loss function which is not classically simulable. This example showcases that $overline(upright("BP")) eq.not upright("QESIM")$.





Let us begin by assuming that the parameterized quantum circuit takes the form,


$ U ( bold(theta) ) = U (⨂_(i = 1)^n e^(- i theta_i X_i)) , $<eq:circ-Bool>


where $U$ is a fixed polynomial-size quantum circuit. More specifically, we take $U$ to be a quantum circuit that implements a Boolean function $B ( x ) : ( 0 , 1 )^n arrow.r ( - 1 , 1 )$ over the first output qubit that is classically hard to simulate for random input bitstrings, even with advice strings~@gyurik2023exponential. Many cryptographic problems related to discrete logarithms are widely believed to satisfy these criteria because they are random self-reproducible. We take any one of them.


Next, let us focus on $U$ and the corresponding Boolean function $B ( x )$. The circuit $U$ implements $B ( x )$ in the following sense:


$ ∥upright("Tr") [ U | #h(0em) x chevron.r chevron.l x #h(0em) | U^dagger Z_1 ] - B ( x )∥ < 0.01 thin , $<ap-eq:BooleanFuncCirc>


for all $x in ( 0 , 1 )^n$, where $Z_1$ is the Pauli-Z operator acting on the first qubit. As previously stated, we will focus on the fact that $B ( x )$ is classically hard to simulate for uniformly random input bitstrings $x in ( 0 , 1 )^n$, even given a polynomial-size advice string. Equivalently, this can be stated as saying that this class of Boolean functions ${ B ( x ) }$ is #emph[not] in $upright("BPP") / upright("poly")$. As data from quantum experiments are a restricted form of advice strings, we will use this observation to argue that a loss function that estimates $B ( x )$ for $x$ uniformly sampled from $( 0 , 1 )^n$ is not $upright("QESIM")$.





Specifically, let us consider the loss function


$ ell_(bold(theta)) ( O ) = chevron.l 0^n | (⨂_(i = 1)^n e^(i theta_i X)) U^dagger Z_1 U (⨂_(i = 1)^n e^(- i theta_i X)) | 0^n chevron.r thin , $<ap-eq:BooleanLoss>


where $O = Z_1$ and we have explicitly taken the initial state $rho$ to be the all-zero state. Let us further suppose that each $theta_i$ is uniformly sampled from the #emph[discrete] set $( 0 , pi / 2 , pi , 3 pi / 2 , 2 pi )$ such that the parametrized quantum circuit prepares a random computational basis state. That is, $(⨂_(i = 1)^n e^(- i theta_i X)) | 0^n chevron.r = | x chevron.r$ where $| x chevron.r$ is a random bitstring. We call this distribution $cal(P)_(upright("disc"))$. We will then define $cal(C)_(upright("Bool"))^(upright("disc") thin upright("."))$ as the class of all instances where the circuit is of the form in Eq.~#ref(<eq:circ-Bool>, supplement: none) where $U$ implements a classically hard Boolean function (even with advice strings) and $bold(theta) tilde cal(P)_(upright("disc"))$.


Since this circuit by assumption approximates $B ( x )$ for all $x$, as stated in Eq.~#ref(<ap-eq:BooleanFuncCirc>, supplement: none), and estimating ${ B ( x ) }$ for uniformly sampled $x$ is not in $upright("BPP") / upright("poly")$, and data from quantum experiments are a form of advice string, it follows that $cal(C)_(upright("Bool"))^(upright("disc") thin upright("."))$ is not in $upright("QESIM")$. Moreover, since $U$ is a polynomial-size circuit, the problem is in $upright("QSIM")$. That is, we have


$ cal(C)_(upright("Bool"))^(upright("disc") thin upright(".")) subset ( upright("QSIM") inter overline(upright("CSIM")_(upright("QE"))) ) thin , $


where $overline(upright("CSIM")_(upright("QE")))$ denotes the classes not in $upright("QESIM")$.


It remains to show that this problem does not exhibit a barren plateau. To show this we start by highlighting that $B ( x )$ has a large variance over the input bitstrings. To see this note that if the variance is smaller than $1 / 100$, then for at least a $9 / 10$ fraction of the inputs, $B ( x )$ must give the same output (the constants are not optimized here, this is just for illustrative purposes). As a result, the error of a trivial classical algorithm that always gives the same output, would only be wrong on at most $1 / 10$ of the inputs. This contradicts the assumption that $B ( x )$ cannot, with high probability, be approximately computed classically. Since $ell_(bold(theta)) ( O )$ approximates $B ( x )$, as stated in Eq.~#ref(<ap-eq:BooleanFuncCirc>, supplement: none), it follows that $ell_(bold(theta)) ( O )$ has a large variance over $cal(P)_(upright("disc"))$. That is,


$ cal(C)_(upright("Bool"))^(upright("disc") thin upright(".")) subset overline(upright("BP")) thin . $


Thus, $cal(C)_(upright("Bool"))^(upright("disc") thin upright("."))$ provides an example of a problem class that is in $overline(upright("BP"))$ but not in $upright("QESIM")$, as claimed.





However, this example is rather contrived. For one, it considers an initialization over a discrete set of parameters. This is a long way from the spirit of more variational quantum algorithms. Moreover, this discrete initialization is doing much of the heavy lifting in this example. To see this one can also consider a variant of the above problem where the parameters are sampled uniformly in the range $[ 0 , 2 pi ]$. We will call this distribution $cal(P)_(upright("cont") thin upright("."))$ and the corresponding problem class $cal(C)_(upright("Bool"))^(upright("cont") thin upright("."))$.


To understand both the absence of barren plateaus and classical simulability of $cal(C)_(upright("Bool"))^(upright("cont") thin upright("."))$ it is helpful to write the backwards propagated observable in Eq.~#ref(<ap-eq:BooleanLoss>, supplement: none), $A equiv U^dagger Z_1 U$, in terms of its local and global components. Specifically, for a small number $k$, we can split $A$ as follows:


$ A = underbrace(sum_(| P | lt.eq k) alpha_P P, A^L) + underbrace(sum_(| P | > k) alpha_P P, A^H) . $


We note that the expectation of $A^L$ in any quantum state can be measured efficiently on quantum hardware in an initial data acquisition phase.


Next we highlight that for $bold(theta) tilde cal(P)_(upright("cont") thin upright("."))$, the contribution of $A^H$ to the loss decays exponentially with the bodyness $k$~@huang2022learning. (Intuitively, this can broadly be understood as following from the fact that the expectation of any Pauli operator $P$ of bodyness $k$ in a typical random product state decays exponentially in $k$.) Hence, it follows that with high probability for $bold(theta) in cal(P)_(upright("cont") thin upright("."))$ the problem lives in an effective polynomial subspace and we have


$ cal(C)_(upright("Bool"))^(upright("cont") thin upright(".")) subset cal(C)_(upright("polySub")) thin . $


It then follows from Claim 2 in the main text that $cal(C)_(upright("Bool"))^(upright("cont") thin upright("."))$ is classically simulable in the sense that with high probability for $bold(theta) tilde cal(P)_(upright("cont") thin upright("."))$ one can provide a classical estimate of the loss defined in Eq.~#ref(<ap-eq:BooleanLoss>, supplement: none).





#emph[So what do we conclude from these examples?] Firstly, this is a concrete example of the limitations of an average case notion of simulability. The loss we have constructed here is easy to classically simulate #emph[on average] over the continuous parameter range $cal(P)_(upright("cont") thin upright("."))$ after an initial data acquisition phase. However, on a special measure-zero set of parameters, the problem becomes classically hard. Secondly, while in a typical random product state the expectation of any given global operator vanishes with high probability, something subtle can happen for the case of random computational basis states. Namely, while on average the contribution of a typical global Pauli is exponentially small, there are exponentially many such terms and with the right structure these can add up to give a non-zero total contribution. This is what happens for $cal(C)_(upright("Bool"))^(upright("dist") thin upright("."))$---the contribution from $A^H$ does not vanish and gives rise to a non-vanishing variance. However, in parallel, the exponential number of global terms in $A^H$ makes its contribution impossible to classically simulate. This suggests smart initialization procedures may be the key to constructing efficiently trainable variational quantum algorithms that are not also classically simulable.


#counter(math.equation).update(0)
#set math.equation(numbering: (n) => "(C" + str(n) + ")")
#heading(level: 1, numbering: none)[Supp. Info. C: Absence of barren plateaus in shallow local circuits with arbitrary topology]
<app:arbtopabsenceofbp>


In this section we will show that that shallow hardware efficient ansatz composed of two-qubit gates acting an arbitrary topology do not posses barren plateaus. While these results can be, in a way, derived from those in~@napp2022quantifying @zhang2023absence, we add the full proof here for completeness.


We begin by present a few useful definitions. First, let $cal(H) = ( bb(C)^2 )^(⊗ 2)$ be the Hilbert space of two qubits. In what follows we will denote the subsystem of the first qubit with an index $A$, and that of the second qubit with an index $B$ so that $cal(H) = cal(H)_A ⊗ cal(H)_B$. Then let $cal(B) ( cal(H)^(⊗ t) )$ be the set of bounded operators acting on $t$ copies of the aforementioned Hilbert space. We are interested in computing expectation values of the form


$ tau_U^(( t )) ( X ) = integral_(S U ( 4 )) d mu ( U ) thin U^(⊗ t) X ( U^dagger )^(⊗ t) thin , $<eq:t-moments>


where $d mu ( U )$ denotes the uniquely defined, normalized, Haar measure over the fundamental representation of $S U ( 4 )$, and where $X in cal(B) ( cal(H)^(⊗ t) )$.


We know that the twirls of Eq.~#ref(<eq:t-moments>, supplement: none) can be evaluated via the Weingarten calculus~@mele2023introduction, as $tau^t ( X )_U$ projects into the commutant of the $t$-th fold tensor representation of $S U ( 4 )$. Here, we can use the Schur-Weyl duality to find that a basis of the commutant is the subsystem-permuting representation of $S_t$, the symmetric group of order $t$. For instance, for $t = 1$, a basis of $S_1$ is ${ bb(1) }$ where $bb(1)$ denotes the $4 times 4$ identity acting on $cal(H)$. Hence, one finds


$
tau_U^1 ( X ) = integral_(S U ( 4 )) d mu ( U ) #h(0.17em) U X U^dagger = frac(upright("Tr") [ X ], 4) bb(1) #h(0.17em) .
$<eq:1-moment>


Going further to $t = 2$, it is standard to take a basis of $S_2$ given by ${ bb(1) times.o bb(1) , upright("SWAP") }$. Here, $upright("SWAP")$ denotes the operator that permutes states acting on each of the copies of the Hilbert space and whose action is given by


$ upright("SWAP") ( | psi_1 chevron.r ⊗ | psi_2 chevron.r ) = | psi_2 chevron.r ⊗ | psi_1 chevron.r thin , $


for $| psi_1 chevron.r , | psi_2 chevron.r in cal(H)$. This leads to the standard result


$
tau_U^2 ( X ) = 1 / 15 (upright("Tr") [ X ] - frac(upright("Tr") [ X upright("SWAP") ], 4)) bb(1) times.o bb(1) + 1 / 15 (upright("Tr") [ X upright("SWAP") ] - frac(upright("Tr") [ X ], 4)) upright("SWAP") #h(0.17em) .
$


While the previous form can, and has~@vznidarivc2022solvable @deneris2024exact @braccia2024computing @belkin2023approximate @mittal2023local, been used to study properties of random quantum circuits composed of local gates, it has the key disadvantage that the basis ${ bb(1) times.o bb(1) , upright("SWAP") }$ is not orthogonal. As such, we will determine a more convenient basis to work in. For this purpose, we first re-arrange the Hilbert spaces so that


$ cal(H)^(⊗ 2) = ( cal(H)_(A , 1) ⊗ cal(H)_(B , 1) ) ⊗ ( cal(H)_(A , 2) ⊗ cal(H)_(B , 2) ) arrow.r ( cal(H)_(A , 1) ⊗ cal(H)_(A , 2) ) ⊗ ( cal(H)_(B , 1) ⊗ cal(H)_(B , 2) ) thin , $


so that


$
bb(1) times.o bb(1) arrow.r bb(1)_A times.o bb(1)_B #h(0.17em) quad upright("SWAP") arrow.r upright("SWAP")_A times.o upright("SWAP")_B #h(0.17em)
$


where $S W A P_(A ( B ))$ are the operators that swap the $A ( B )$ qubits in the two-fold tensor product of $cal(H)$, and $bb(1)_(A(B))$ the identity operator on the two-copies of the subsystem's Hilbert space $cal(H)_(A ( B ))$. Moreover, let us write


$
upright("SWAP")_A = 1 / 2 #scale(x: 180%, y: 180%)[(] bb(1)_(A 1) times.o bb(1)_(A 2) + X_(A 1) times.o X_(A 2) + Y_(A 1) times.o Y_(A 2) + Z_(A 1) times.o Z_(A 2) #scale(x: 180%, y: 180%)[)] = 1 / 2 (bb(1)_A + upright("SW")_A) #h(0.17em)
$


where we defined


$
bb(1)_A = bb(1)_(A 1) times.o bb(1)_(A 2) #h(0.17em) quad upright("SW")_A = X_(A 1) times.o X_(A 2) + Y_(A 1) times.o Y_(A 2) + Z_(A 1) times.o Z_(A 2) #h(0.17em) .
$


Combining the previous results, we obtain


$
upright("SWAP") = 1 / 4 #scale(x: 180%, y: 180%)[(] bb(1)_A times.o bb(1)_B + upright("SW")_A times.o bb(1)_B + bb(1)_A times.o upright("SW")_B + upright("SW")_A times.o upright("SW")_B #scale(x: 180%, y: 180%)[)] #h(0.17em) .
$


From here, we can find that an orthonormal basis for the commutant of the two-fold tensor rep of $S U ( 4 )$ is


#set math.equation(numbering: none)
$
brace.l frac(bb(1)_A times.o bb(1)_B, 4) , frac(upright("SW")_A + upright("SW")_B + upright("SW")_A times.o upright("SW")_B, 4 sqrt(15)) brace.r thin ,
$
#set math.equation(numbering: (n) => "(C" + str(n) + ")")


where we have dropped the trivial identity terms for ease of notation. Then, we can write the two-fold twirl as


$
tau_U^2 ( X ) = 1 / 16 upright("Tr") [ X ] bb(1)_A times.o bb(1)_B + 1 / 240 upright("Tr") [ X ( upright("SW")_A + upright("SW")_B + upright("SW")_A times.o upright("SW")_B ) ] ( upright("SW")_A + upright("SW")_B + upright("SW")_A times.o upright("SW")_B ) #h(0.17em) .
$<eq:2-moment>


Given Eq.~#ref(<eq:2-moment>, supplement: none) we can now compute the following twirls:


$ tau_U^2 ( P_A ⊗ P_B ) & = 1 / 15 ( upright("SW")_A + upright("SW")_B + upright("SW")_A ⊗ upright("SW")_B ) thin ,\
tau_U^2 ( upright("SW")_A ) & = 1 / 5 ( upright("SW")_A + upright("SW")_B + upright("SW")_A ⊗ upright("SW")_B ) thin ,\
tau_U^2 ( upright("SW")_B ) & = 1 / 5 ( upright("SW")_A + upright("SW")_B + upright("SW")_A ⊗ upright("SW")_B ) thin ,\
tau_U^2 ( upright("SW")_A ⊗ upright("SW")_B ) & = 3 / 5 ( upright("SW")_A + upright("SW")_B + upright("SW")_A ⊗ upright("SW")_B ) thin , $<eq:2-twirl-Pauli>


where $P_(A ( B ))$ is a single-qubit Pauli acting on the subsystems $A ( B )$.


// [figvision-cn] imgs/Fig_1_SI.png
// 这是一张量子电路示意图，子图标记为a。图中没有坐标轴、
// 数据曲线或色标，属于纯示意图类型。图像自上而下包含四条
// 平行的水平直线，代表四个量子比特（qubit）的线路，左侧
// 从上到下依次标注数字1、2、3、4。图中包含三个矩形操作块
// 和两个测量符号，具体布局和连接关系如下： 第一条水平线
// （量子比特1）从左端延伸至右端；第二条水平线（量子比特2）
// 从左端延伸至右端；第三条水平线（量子比特3）从左端延伸
// 至右端；第四条水平线（量子比特4）从左端延伸至右端。四
// 条线相互平行，间距均匀。 在水平线的左半部分，有两个垂
// 直放置的矩形框。第一个矩形框跨越第一条和第二条水平线，
// 位于线路的左侧，其内部标注有文字“U12”，代表作用于量子
// 比特1和2的双量子比特门。第二个矩形框跨越第三条和第四条
// 水平线，位于第一个矩形框的右下方，其内部标注有文字“U34
// ”，代表作用于量子比特3和4的双量子比特门。 在两个矩形框
// 的右侧，还有一个跨越第二条和第三条水平线的矩形框，其内
// 部标注有文字“U23”，代表作用于量子比特2和3的双量子比特
// 门。该框在水平位置上位于U12框的右侧、U34框的右侧，但在
// 垂直方向上仅连接量子比特2和3的线路。 在水平线的最右端，
// 第二条和第三条水平线上各有一个正方形测量符号。每个正方
// 形内部绘制了一条从左下到右上的圆弧，圆弧上有一个指向右
// 上方的箭头，这是量子电路中标准的测量符号，表示对量子比
// 特2和3进行测量。第一条和第四条水平线的最右端没有测量符
// 号，直接以水平线结束。 整张图传达的结论是：该电路首先
// 对量子比特1和2执行U12操作，对量子比特3和4执行U34操作；
// 随后对量子比特2和3执行U23操作；最后对量子比特2和3进行
// 测量（对应图注中所述测量泡利算符）。图中没有比例尺、颜
// 色映射或显微成像通道信息。
#figure(image("imgs/Fig_1_SI.png", width: 20%),
  caption: [
    #strong[Four qubit circuit example.] Consider the following circuit acting on four qubits. At the end of the circuit we measure a Pauli operator on qubits 2 and 3.
  ]
)
<fig:example>



Using the previous equation, we can evaluate the loss function variance over arbitrary circuits composed of $S U ( 4 )$ gates by simply keeping track of how the $upright("SW")$ operators transform between themselves and how the coefficients accumulate. As an example, consider the four qubit circuit shown in @fig:example, where the unitary $U$ implementing the whole circuit can be expressed as $U = U_23 U_34 U_12$. We assume the input to the circuit is $rho$, and that at the end of the circuit we measure the expectation value of some Pauli operator acting on qubits 2 and 3. We further assume that all the two-qubit gates form independent two-design over $S U ( 4 )$. We want to compute a quantities of the for $bb(E)_U [ upright("Tr") [ U rho U^dagger O ] ]$ and $bb(E)_U [ upright("Tr") [ U rho U^dagger O ]^2 ]$. In particular we will evaluate the expectation value over the circuit as


$ bb(E)_U [ f ( U ) ] & = integral_(S U ( 4 )) d mu ( U_12 ) d mu ( U_34 ) d mu ( U_23 ) f ( U ) thin , $


Using Eq.~#ref(<eq:1-moment>, supplement: none), we can readily show that


$ bb(E)_U [ upright("Tr") [ U rho U^dagger O ] ] = 0 thin . $


Then, since


$ upright("Tr") [ U rho U^dagger O ]^2 & = upright("Tr") [ U^(⊗ 2) rho^(⊗ 2) ( U^dagger )^(⊗ 2) O ]\
 & = upright("Tr") [ rho^(⊗ 2) ( U^dagger )^(⊗ 2) O U^(⊗ 2) ] thin , $


we find


$ bb(E)_U [ upright("Tr") [ rho^(⊗ 2) ( U^dagger )^(⊗ 2) O U^(⊗ 2) ] ] & = upright("Tr") [ rho^(⊗ 2) bb(E)_U [ ( U^dagger )^(⊗ 2) O U^(⊗ 2) ] ] thin , $


where we have used the linearity of the trace. Then, we see that we need to compute


$ tau_(U_12)^(( 2 )) compose tau_(U_34)^(( 2 )) compose tau_(U_23)^(( 2 )) [ O^(⊗ 2) ] thin . $


Since $O$ is some Pauli acting non trivially on qubits $2$ and $3$, we find via Eq.~#ref(<eq:2-twirl-Pauli>, supplement: none)


$ tau_(U_23)^(( 2 )) [ O^(⊗ 2) ] = 1 / 15 ( upright("SW")_2 + upright("SW")_3 + upright("SW")_2 ⊗ upright("SW")_3 ) thin . $<eq:test-1>


We then use Eq.~#ref(<eq:2-twirl-Pauli>, supplement: none) to obtain


$  & tau_(U_34)^(( 2 )) [ 1 / 15 ( upright("SW")_2 + upright("SW")_3 + upright("SW")_2 ⊗ upright("SW")_3 ) ]\
= & upright("SW")_2 / 15 + 1 / 75 ( upright("SW")_3 + upright("SW")_4 + upright("SW")_3 ⊗ upright("SW")_4 ) + 3 / 75 ( upright("SW")_2 ⊗ upright("SW")_3 + upright("SW")_2 ⊗ upright("SW")_4 + upright("SW")_2 ⊗ upright("SW")_3 ⊗ upright("SW")_4 ) thin . $<eq:test-2>


Here, we can already observe an important phenomenon. If a $upright("SW")_i$ goes into a twirl from a gate $U_(i j)$, then we obtain terms $upright("SW")_i$, $upright("SW")_j$, and $upright("SW")_i ⊗ upright("SW")_j$ with a coefficient $1 / 5$. Similarly, if $upright("SW")_i ⊗ upright("SW")_j$ goes into a twirl from a gate $U_(i j)$, then we obtain terms $upright("SW")_i$, $upright("SW")_j$, and $upright("SW")_i ⊗ upright("SW")_j$ with a coefficient $3 / 5$. Hence, we simply need to keep track of indexes and coefficients. As such, let us we-write Eq.~#ref(<eq:test-1>, supplement: none) as


$ O^(⊗ 2) arrow.r_(tau_(U_23)^(( 2 ))) {(( 2 ) , 1 / 5) , (( 3 ) , 1 / 5) , (( 2 , 3 ) , 1 / 5)} thin . $


Then, the next twirl over $U_34$ in Eq.~#ref(<eq:test-2>, supplement: none) leads to


$ arrow.r_(tau_(U_33)^(( 2 ))) & { (( 2 ) , 1 / 5) , (( 3 ) , 1 / 75) , (( 4 ) , 1 / 75) , (( 3 , 4 ) , 1 / 75) ,\
 & (( 2 , 3 ) , 3 / 75) , (( 2 , 4 ) , 3 / 75) , (( 2 , 3 , 4 ) , 3 / 75) } $


and finally the next twirl over $U_12$


$ arrow.r_(tau_(U_33)^(( 2 ))) & { (( 1 ) , 1 / 75) , (( 2 ) , 1 / 75) , (( 3 ) , 1 / 75) , (( 4 ) , 1 / 75) ,\
 & (( 1 , 2 ) , 1 / 75) , (( 3 , 4 ) , 1 / 75) , (( 2 , 3 ) , 3 / 375) ,\
 & (( 1 , 3 ) , 3 / 375) , (( 2 , 4 ) , 3 / 375) , (( 1 , 4 ) , 3 / 375) ,\
 & (( 1 , 2 , 3 ) , 3 / 375) , (( 1 , 2 , 4 ) , 3 / 375) , (( 2 , 3 , 4 ) , 3 / 375) ,\
 & (( 1 , 3 , 4 ) , 3 / 375) , (( 1 , 2 , 3 , 4 ) , 3 / 375) } thin . $


The previous example unveils a simple pattern that will be universally true. First, the "most-local" operators, are the ones which will be suppressed the least. Whereas "more global" operators will be quickly suppressed. As such, we can intuitively see that, in average, the Heisenberg evolved operator will live on $cal(O) ( 1 )$ bodied operators. Indeed, one can study how much the coefficient of a given operators at the out put of the circuit will look like by evaluating some weighted random walk over the circuit architecture following the rules mentioned above.


Putting it all together, we are now ready to show that shallow local circuits avoid barren plateaus when measured locally at their output. Interestingly, this result encompassed, and constitutes a simpler proof, to those in Refs.~@cerezo2020cost and~@pesah2020absence. Consider therefore an arbitrary circuit with two-qubit gate topology


$ cal(A) = ( ( i_k , j_k ) , quad forall k = 1 , dots.h , K ) thin . $


Note that we are not assuming any dimensionality on $cal(A)$, meaning that it could be as general as desired. Then, if the measurement operator is locally acting on the $mu$-th qubit, and that this index appears in $cal(A) L$ times, one can lower bound the expectation value's variance as


$ upright("Var")_U [ upright("Tr") [ U rho U^dagger O ] ] & gt.eq 1 / 15 1 / 5^(L - 1) upright("Tr") [ rho^(⊗ 2) upright("SW")_mu ]\
 & = 1 / 15 2 / 5^(L - 1) ( upright("Tr") [ rho_mu^2 ] - 1 / 2 ) thin , $


where we have defined as $rho_mu^2$ the reduced state of $rho$ on the $mu$-th qubit, and where we have used the fact that $upright("SW")_mu = 2 ( upright("SWAP")_mu - bb(1) )$. Moreover, here we have used the fact that we can drop all other terms in the path summation since the overlap between $rho^(⊗ 2)$ and the tensor product of many $upright("SW")$'s is always positive. More generally, if we define as $cal(S)$ as the set of indexes which are connected through a path of length $L$ from the beginning of the circuit to the measurement on the $mu$-th qubit, one can tighten the bound as


$ upright("Var")_U [ upright("Tr") [ U rho U^dagger O ] ] & gt.eq 1 / 15 2 / 5^(L - 1) sum_(j in cal(S)) ( upright("Tr") [ rho_j^2 ] - 1 / 2 ) thin . $


The previous result shows that if the circuit is shallow, i.e., if there exists a path of length $L$ such that $L in cal(O) ( log ( n ) )$\; and if the input state $rho$ is not too entangled, i.e., $| upright("Tr") [ rho_j^2 ] - 1 / 2 | in Omega ( 1 / "poly" ( n ) )$ then


$ upright("Var")_U [ upright("Tr") [ U rho U^dagger O ] ] in Omega (frac(1, "poly" ( n ))) thin . $


Notably, we find that the reduced states will be exponentially close to the maximally mixed state if they satisfy a volume law of entanglement, whereas their distance to it will be polynomially small is they follow an area law of entanglement~@leone2022practical.