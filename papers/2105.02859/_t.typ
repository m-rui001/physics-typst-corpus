#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.88cm, bottom: 2.15cm), columns: 2)
#set heading(numbering: "1.1")
#set heading(supplement: none)
#set figure(placement: auto)
#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
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

#let thmbox(fam, name, body, title: none) = {
  let is-str = type(name) == str
  let parts = if is-str { name.split("(") } else { () }
  let head = if is-str { parts.at(0).trim() } else { name }
  let ttl = if title != none { title } else if is-str and parts.len() > 1 { parts.slice(1).join("(").trim() } else { none }
  figure(
    kind: fam,
    supplement: head,
    numbering: "1",
    block(width: 100%, {
      context {
        let num = counter(figure.where(kind: fam)).display()
        if ttl == none { [*#head #num.*] } else { [*#head #num (#ttl).*] }
      }
      h(0.4em)
      set text(style: "italic")
      body
    }),
  )
}


#let algbox(title, body) = figure(
  kind: "algorithm",
  supplement: [Algorithm],
  numbering: "1",
  block(width: 100%, inset: (x: 6pt, y: 6pt), stroke: 0.5pt, {
    context [*Algorithm #counter(figure.where(kind: "algorithm")).display(): #title*]
    parbreak()
    set text(size: 9pt)
    body
  }),
)

#align(center)[
  #text(17pt, weight: "bold", [A Grand Unification of Quantum Algorithms])   #v(1.2em)
  #text(10.5pt)[John M. Martyn#super[1], Zane M. Rossi#super[2], Andrew K. Tan#super[3], Isaac L. Chuang#super[3]]

]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Center for Theoretical Physics, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, USA] \
  #text(9pt)[#super[2] Department of Physics, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, USA] \
  #text(9pt)[#super[3] Department of Physics, Co-Design Center for Quantum Advantage, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, USA] \
  #text(9pt)[#super[4] Center for Ultracold Atoms, and Research Laboratory of Electronics, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, USA] \
]
#v(1.2em)

Quantum algorithms offer significant speedups over their classical counterparts for a variety of problems. The strongest arguments for this advantage are borne by algorithms for quantum search, quantum phase estimation, and Hamiltonian simulation, which appear as subroutines for large families of composite quantum algorithms. A number of these quantum algorithms were recently tied together by a novel technique known as the quantum singular value transformation (QSVT), which enables one to perform a polynomial transformation of the singular values of a linear operator embedded in a unitary matrix. In the seminal GSLW'19 paper on QSVT \[Gilyén, Su, Low, and Wiebe, ACM STOC 2019\], many algorithms are encompassed, including amplitude amplification, methods for the quantum linear systems problem, and quantum simulation. Here, we provide a pedagogical tutorial through these developments, first illustrating how quantum signal processing may be generalized to the quantum eigenvalue transform, from which QSVT naturally emerges. Paralleling GSLW'19, we then employ QSVT to construct intuitive quantum algorithms for search, phase estimation, and Hamiltonian simulation, and also showcase algorithms for the eigenvalue threshold problem and matrix inversion. This overview illustrates how QSVT is a single framework comprising the three major quantum algorithms, suggesting a #emph[grand unification] of quantum algorithms.

= Introduction
<sec:Introduction>
Algorithms solve problems by presenting a process or set of rules to be followed, utilizing a basic set of building blocks provided. Computer science traditionally employs Boolean circuit components as the basic blocks, from which standard arithmetic operations may be composed, as Boolean functions. Quantum computation employs a different set of basic blocks, typically unitary operations on one or more two-state systems (qubits), to realize quantum circuits. A fundamental challenge arises, however, when seeking to unite the world of quantum circuits with that of Boolean functions: in general, Boolean functions need not be reversible, whereas quantum circuits are manifestly unitary transforms, and must thus be invertible.

Early in the history of quantum computation, this barrier was transcended by seminal work~@bennett1989time showing that all Boolean functions can be made reversible, with only a small overhead in space and time. Toffoli and Fredkin famously illustrated this idea by showing how the ideal Newtonian dynamics of finite-radii spheres (billiard balls) can be used to simulate reversible Boolean circuits, via their collisions~@fredkin1982conservative. Following this concept, simulation of arbitrary Boolean functions can also be accomplished using quantum circuits, by first embedding the desired function into a reversible Boolean circuit, then constructing a quantum circuit realizing this invertible transform. Such an embedding is a core part of Shor's quantum factoring algorithm~@shor1994algorithms, for example, as used in the modular exponentiation of an input number.

Intriguingly, however, the two other major "primordial" quantum algorithms, Grover's quantum search algorithm @grover1996fast, and the Hamiltonian simulation algorithm @feynman1982simulating @lloyd1996universal, do not employ an embedding of a reversible Boolean function. In fact, a key part of the quantum factoring algorithm is its use of the quantum Fourier transform, which has no direct classical analogue, in the sense that it is not at all like a quantum embedding of a reversible Boolean function for the Fourier transform. And yet, all three of these algorithms provide solutions to problems with clear classical counterparts, and attain known speedups over the comparable classical "Boolean function" approaches. So wherein lies the ability of quantum algorithms to address and speed up the solution to a classically specified problem?

With this framework, we present in this tutorial a pedagogical overview of the modern approach to quantum search, factoring, and simulation, focusing on how all three of these central quantum algorithms may be unified as instances of the recently developed #emph[quantum singular value transform (QSVT) algorithm]~@Gily_n_2019. The QSVT algorithm generalizes QSP and efficiently applies a polynomial transformation to the singular values of a linear operator (governing a particular subsystem) embedded in a larger unitary operator. And more recently, such a singular value transformation has been generalized to apply to an operator embedded in a block of a Hamiltonian~@lloyd2021hamiltonian.

Singular values naturally arise in this context from the fact that the input and output spaces of the embedded linear operator may be of different sizes. The polynomial transformation of the singular values is achieved by applying a specific sequence of SU(2) rotations to the embedded subspace, where each rotation is parameterized by an angle $phi.alt_k in bb(R)$. The QSVT algorithm is parametric in that the polynomial transformation is completely characterized by the choice of phase angles ${ phi.alt_k }$. Moreover, given the desired polynomial transformation, the QSP phase angles which generate it may be classically efficiently and stably computed~@Low_2016 @Gily_n_2019 @efficient_qsp_phase_factors.

This seemingly simple parameterization endows QSVT with immense flexibility and power. Using QSVT as a subroutine, we present quantum algorithms for the search problem and phase estimation, and give simplified arguments for optimal Hamiltonian simulation by QSVT and matrix inversion by QSVT. We also present a QSVT-based algorithm for #emph[the eigenvalue threshold problem], wherein one wishes to know if a (normal) matrix has an eigenvalue above some threshold, and use this to simplify the presentation of the use of QSVT for phase estimation. Each algorithm is realized simply as an instance of QSVT with a natural oracle, adaptively repeated and interspersed in a common pattern with simple quantum gates and measurements.

This common pattern is particularly fascinating. At face value, the algorithms for the search problem, factoring (aka phase estimation), and Hamiltonian simulation appear to share no similar structures, owing their quantum speedups to different sources, and yet they can all be derived from a single algorithmic primitive, and interpolated between by a simple change of parameters. In addition, these three central algorithms form the foundation for most quantum algorithms currently known. For instance, the Harrow-Hassidim-Lloyd algorithm for linear systems~@Harrow_2009 incorporates Hamiltonian simulation and phase estimation in order to invert a Hermitian matrix, and similarly the quantum counting algorithm integrates quantum search with phase estimation to count the number of marked elements in an unstructured set~@Brassard_1998. As shown in this tutorial, by simply adjusting the parameters of QSVT, one can construct nearly all known quantum algorithms. It is in this sense that QSVT provides a #emph[grand unification] of quantum algorithms.

While some of these applications have been covered in recent works on QSVT~@Gily_n_2019 @rall2021faster, here we aim to present these constructions as pedagogically as possible, providing detailed procedures and intuition for each, and including explicit examples to support abstract ideas where appropriate. We also supply performance bounds and resource requirements for each of the algorithms presented here, which we anticipate will be helpful. It is our hope that this presentation will make QSVT and QSP more accessible, catalyzing future developments in quantum algorithms.

Throughout this tutorial, we will assume familiarity with basic concepts in quantum computing, such as unitary dynamics and measurement, as well as the conventional quantum algorithms for search, phase estimation, and Hamiltonian simulation. For a comprehensive review of these subjects, see~@nielsen2010quantum @preskill1998lecture @kitaev2002classical. Further, we aim to present this work in a manner accessible to readers without prior knowledge of QSP and QSVT, but if more information on these topics is needed,~@low2017quantum @Low_2016 @gilyen2019quantum @Gily_n_2019 may serve as helpful references.

== Road Map
<road-map>

We share the story of this grand unification of quantum algorithms by first surveying the development of QSVT in Section~@sec:QSP_To_QSVT, beginning with quantum signal processing and then demonstrating how this technology leads to quantum eigenvalue transforms and ultimately the quantum singular value transformation. Thereafter, we detail a statement of grand unification for currently known quantum algorithms, presenting QSVT-based algorithms for the search problem and the eigenvalue threshold problem in Secs.~@sec:Search and~@sec:Threshold, respectively. Further fulfilling the unification promise, we introduce an algorithm for phase estimation by QSVT in Section~@sec:PhaseEstimation, and show how the quantum Fourier transform emerges from cascading QSVT sequences. We then highlight in Section~@sec:FuncEval how QSVT can yield intuitive algorithms for Hamiltonian simulation and matrix inversion. Lastly, in Section~@sec:Discussion, we explore the implications of these results and discuss areas of future research in the utility of QSVT.

= From QSP to QSVT
<sec:QSP_To_QSVT>

In this section, we develop the framework of QSVT, starting with quantum signal processing and then providing a concrete application of this technology to amplitude amplification. Building off this example, we establish quantum eigenvalue transforms and finally quantum singular value transforms. Overall, this section is meant to be pedagogical and easily accessible to readers with a background in basic quantum circuits and linear algebra, as the constructions of this section underlie the remainder of the work. For more details on QSP and QSVT, including alternate introductions to the topics, rigorous proofs, and applications not covered here, see @low2017quantum @Low_2016 @gilyen2019quantum @Gily_n_2019.

== Quantum Signal Processing
<sec:qsp>

Quantum signal processing (QSP) generalizes the results of composite pulse sequences~@Low_2016 @Low_2017 @Low_2019, and is built on the idea of interleaving two kinds of single qubit rotations: a #emph[signal] rotation operator $W$, and a #emph[signal processing] rotation operator $S$. These rotation operations are about different axes through the Bloch sphere, e.g. commonly $W$ is an $x$-rotation, while $S$ is a $z$-rotation. Moreover, the signal rotation always rotates through the same angle $theta$, whereas the signal processing rotation rotates through a variable angle according to some pre-determined sequence.

For example, let the signal rotation operator be

$W ( a ) = mat(delim: "[", a, i sqrt(1 - a^2); i sqrt(1 - a^2), a) thin ,$<eq:wa_qsp>

which is an $x$-rotation by angle $theta = - 2 cos^(- 1) a$. And let the signal processing rotation operator be

$S ( phi.alt ) = e^(i phi.alt Z) thin ,$<eq:qsp_rotation>

which is a $z$-rotation by angle $- 2 phi.alt$. For a tuple of phases $arrow(phi.alt) = ( phi.alt_0 , phi.alt_1 , . . . phi.alt_d ) in bb(R)^(d + 1)$, and using these conventions#footnote[The convention presented in @eq:qsp_uphi may be called the Wx convention. See Appendix~@sec:QSPConventions for other conventions.], the QSP operation sequence $U_(arrow(phi.alt))$ is defined as

$U_(arrow(phi.alt)) = e^(i phi.alt_0 Z) product_(k = 1)^d W ( a ) e^(i phi.alt_k Z) thin .$<eq:qsp_uphi>

What is interesting is how QSP can modify the incoming signal. Suppose $arrow(phi.alt) = ( 0 , 0 )$, i.e. there is no processing, such that $U_(arrow(phi.alt)) = W ( a )$ is just the unchanged signal. If we plot the probability of a $| 0 med$ qubit input staying unchanged under this operation, i.e. $p = |chevron.l 0|U_(arrow(phi.alt))|0 chevron.r|^2$, as a function of $theta$, we find a nice cosinusoid (the lower plot in @fig:qsp_response_functions), because for this case $p = cos^2 (theta / 2)$. Now if we do some signal processing, by letting $arrow(phi.alt) = ( pi / 2 , - eta , 2 eta , 0 , - 2 eta , eta )$, where $eta = 1 / 2 cos^(- 1) (- 1 / 4)$, then for the new $U_(arrow(phi.alt))$ using these phases, we find the new probability $p = |chevron.l 0|U_(arrow(phi.alt))|0 chevron.r|^2 = 1/8 cos^2 (theta/2) (3 cos^8 (theta/2)$ $ - 15 cos^6 (theta/2) + 35 cos^4 (theta/2) - 45 cos^2 (theta/2) + 30)$ (the upper dotted dashed line in @fig:qsp_response_functions), which for small $theta$ is approximately $1 - 5 / 8 (theta / 2)^6$. This has the nice property that the qubit remains unflipped for a wide range of signal angles, but then a sharp transition happens around $theta approx 2 pi / 3$. This increases sensitivity to specific values of the signal!

// [figvision] imgs/fig_bb1_comparison.png
// The figure has one panel. The plot shows the squared absolute value of the transition amplitude versus the
// angle . The horizontal axis ranges from - to , and the vertical axis ranges from 0 to 1. There are two series:
// one for the "Trivial" case with a uniform dashed line and one for the "BB1" case with a dotted dashed line.
// The trend shows that the "BB1" case has a near-one transition probability for a wider range of compared to the
// "Trivial" case. The message is that the QSP sequence for the BB1 protocol improves the transition probability.
#figure(image("imgs/fig_bb1_comparison.png", width: 100%),
  caption: [
    The transition probabilities for $| 0 chevron.r arrow.r | 0 chevron.r$ after the application of $exp ( i theta X / 2 )$ (uniform dashed) and the QSP sequence for the BB1 protocol (dotted dashed). The latter transition probability is seen to be near-one for a wider range of $theta$.
  ]
)
<fig:qsp_response_functions>

Thus, sequences like this are widely employed in magnetic resonance imaging to increase image contrast. This particular sequence is famous in the field of NMR, and is known as the "BB1" pulse sequence~@wimperis1994broadband. Many such "composite pulse" sequences are known~@freeman1998spin @RevModPhys.76.1037 @wolfowicz2007pulse, with a wide range of variations, and in experimental quantum computation, they serve to suppress specific kinds of errors and enhance sensitivity to specific kinds of signals, across implementations ranging from quantum dots~@wang2012composite and nitrogen vacancy centers in diamonds~@aiello2013composite, to trapped ions~@PhysRevA.92.060301 @Tomita_2010 @Ivanov:11 and superconducting qubits~@chow2013microwave.

That QSP sequences can have such signal transformation properties is well known, because in general the matrix element $P(a) = chevron.l 0|U_(arrow(phi.alt))|0 chevron.r$ becomes a polynomial in $a$, with the order of the polynomial being at most the length of the sequence of QSP phases $arrow(phi.alt)$. Specifically, for example, for $arrow(phi.alt) = ( 0 , 0 )$, $P ( a ) = a$; for $arrow(phi.alt) = ( 0 , 0 , 0 )$, $P ( a ) = 2 a^2 - 1$; and for $arrow(phi.alt) = ( 0 , 0 , 0 , 0 )$, $P ( a ) = 4 a^3 - 3 a$. These are the Chebyshev polynomials of the first kind, $T_d ( a )$.

Perhaps the most remarkable property of the QSP sequence of @eq:qsp_uphi, however, is the reverse of this statement: it turns out that for a given polynomial $P ( a )$ (subject to some reasonable constraints), there exists a set of QSP phase angles $arrow(phi.alt)$ such that $P(a) = chevron.l 0|U_(arrow(phi.alt))|0 chevron.r$. Specifically#cite(<Low_2016>):

#thmbox("theorem", "Theorem (Quantum Signal Processing)")[

The QSP sequence $U_(arrow(phi.alt))$ produces a matrix which may be expressed as polynomial function of $a$:

$ e^(i phi.alt_0 Z) product_(k=1)^d W ( a ) e^(i phi.alt_k Z) = mat(delim: "[", P ( a ), i Q ( a ) sqrt(1 - a^2); i Q^(*) ( a ) sqrt(1 - a^2), P^(*) ( a )) $<eq:qsp_thm>

for $a in [ - 1 , 1 ]$, and a $arrow(phi.alt)$ exists for any polynomials $P$, $Q$ in $a$ such that:

+ $upright("deg") ( P ) lt.eq d$, $upright("deg") ( Q ) lt.eq d - 1$,

+ $P$ has parity $d med upright("mod") med 2$ and $Q$ has parity $( d - 1 ) med upright("mod") med 2$,

+ $| P |^2 + ( 1 - a^2 ) | Q |^2 = 1$.

] <thm:qsp>

The forward part of this theorem is easily proven by induction, starting from the $d = 0$ case, for which $P = e^(i phi.alt_0)$ and $Q = 0$. The reverse direction of this theorem is more involved, and can be proven in a number of ways, including an elegant interpretation involving Laurent polynomial algebras~@Haah_2019 @chao2020finding.

Often however, we are interested not in the unitaries that can be constructed with QSP but rather the achievable polynomial transformations of the input, $upright("Poly") ( a )$, in a subsystem. If as above, we choose $upright("Poly") ( a ) = chevron.l 0 | U_(arrow(phi.alt)) | 0 | = chevron.r P ( a )$ we are limited to $P$ for which there exists a polynomial $Q$ satisfying the conditions of @thm:qsp. This can be quite a limiting condition for some applications. For example, for $a = plus.minus 1$, $W ( plus.minus 1 )$ is proportional to the identity matrix and the entire sequence QSP sequence collapses to a single $z$-rotation limiting us to polynomials $upright("Poly") ( a )$ such that $| upright("Poly") ( plus.minus 1 ) | = 1$. This limitation can be overcome by instead defining $upright("Poly") ( a ) = chevron.l + | U_(arrow(phi.alt)) | + | = chevron.r upright("Re") ( P ( a ) ) + i upright("Re") ( Q ( a ) ) sqrt(1 - a^2)$. In this case, it can be shown that we can accurately approximate any real polynomial with parity $d med upright("mod") med 2$ such that $deg ( upright("Poly") ) lt.eq d$, and $| upright("Poly") ( a ) | lt.eq 1 med forall med a in [ - 1 , 1 ]$. This can be achieved by selecting an appropriate $P$ whose real part approximates the desired function and a $Q$ with small real component. With this convention, the set of achievable polynomials is sufficiently expressive for all of the applications described in this tutorial. In general, the basis employed for the desired polynomial may be called the #emph[signal basis], and unless otherwise specified, below we take this basis to be $| + med , | - med$.

Appendix~@sec:QSPConventions elaborates on this, and discusses the different conventional statements of the QSP @thm:qsp.

While @thm:qsp guarantees the existence of such a $arrow(phi.alt)$, it does not provide a method for determining it. Fortunately, Remez-type exchange algorithms can efficiently compute a $arrow(phi.alt)$ that produces a good approximation to any feasible polynomials $P$ and $Q$~@Low_2016. Further, more efficient and numerically stable algorithms have also been found~@chao2020finding @Haah_2019 @arute2019quantum, and novel optimization techniques are currently under development~@lin2021optimization. Appendix~@sec:qsp_angle_examples gives explicit examples of $arrow(phi.alt)$ for a wide family of polynomials used in realizing quantum algorithms, and illustrates an open-source code package accompanying this tutorial for generating QSP phase angle coefficients.

== An Application to Amplitude Amplification and Search
<sec:AA_and_search>

Toward motivating QSVT from QSP, we introduce an illustrative example of how multi-qubit problems may be simplified by identifying qubit-like subsystems, to which the ideas of QSP may be applied. The concept demonstrated in this subsection is essentially that of #emph[qubitization]~@Low_2019, which forms a core tenet of QSVT.

Specifically, we discuss the problem of amplitude amplification; a similar construction will be discussed in Section~@sec:Search employing the major theorems of QSVT, but here we begin from basic principles. It is hoped that the geometric intuition behind the argument which follows, and the expediency of the fully-developed construction in Section~@sec:Search, will complement each other.

The utility of @thm:qsp is nicely demonstrated in solving the following problem. Suppose you are given a unitary $U$ (which may act on some Hilbert space of large dimension; i.e., larger than just a qubit) and its inverse, $U^dagger$, as well as two operators $A_phi.alt$ and $B_phi.alt$, each of which rotates the phases of a specific, privileged state, namely:

$ & A_phi.alt = e^(i phi.alt | A_0 chevron.r chevron.l A_0 |) \
  & B_phi.alt = e^(i phi.alt | B_0 chevron.r chevron.l B_0 |) thin , $<eq:aa_aphi>

The challenge is to construct a circuit $Q$ using $U$, $U^dagger$, $A_phi.alt$, and $B_phi.alt$ such that

$ | chevron.l A_0 | Q | B_0 chevron.r | arrow.r.long 1 $

in the limit of a sufficiently large circuit, and assuming that the original matrix element $chevron.l  A_0 | U |B_0 chevron.r$ of $U$ is nonzero.

This problem is known as #emph[amplitude amplification], and remarkably it can be solved without knowing the specific initial value $chevron.l A_0 | U | B_0 chevron.r$, by using the #emph[oblivious fixed-point amplitude amplification] quantum algorithm. We will show that such an algorithm arises only from @thm:qsp, even in the multiple-qubit setting, by recognizing that there are two concentric Bloch spheres (qubit-like spaces) in this problem.

Specifically, one can recognize that $U | B_0 med$ is a quantum state which has a non-zero component along $| A_0 med$, and another component perpendicular to $| A_0 med$. So we define

$ | A_perp chevron.r = frac(1, cal(N)) ( I - | A_0 chevron.r chevron.l A_0 | ) U | B_0 chevron.r thin , $

where $cal(N)$ is the normalization factor needed to make $| A_perp med$ a unit vector. Then

$U | B_0 med = a | A_0 med + sqrt(1 - a^2) | A_perp med$

for $a=chevron.l A_0|U|B_0 chevron.r$ (we may assume that $a$ is real because a possible phase may be absorbed into $| B_0 chevron.r$)). Similarly, we may define some $| B_perp med$ such that

$U | B_perp med = - a | A_perp med + sqrt(1 - a^2) | A_0 med thin .$

These ideas are illustrated in the diagram of @fig:amplitude-amplification-bloch-sphere, using the familiar Bloch sphere.

// [figvision] imgs/fig_double_bloch_sphere.png
// The figure is a Bloch sphere representation. The plot is a schematic diagram of a Bloch sphere with various
// states and operations illustrated. There are no axes in the classical sense, but the Bloch sphere has a radius
// of 1 and is centered at the origin. The states shown are |A_0, |B_0, |A_, and |B_, represented by points on
// the Bloch sphere. The blue and black lines represent rotations about the states. The dashed lines represent
// the application of operators \{i|A_0 A_0|\} and \{i|B_0 B_0|\}. The trend shows how amplitude amplification
// can be achieved through controlled rotations and operator applications. The message is that the standard
// Grover iterate can be recovered by producing a simple rotation. The angle is labeled, indicating the
// relationship between the states.
#figure(image("imgs/fig_double_bloch_sphere.png", width: 100%),
  caption: [
    An illustration of amplitude amplification, where one desires to prepare the state $| A_0 chevron.r$ (here the north pole of some Bloch sphere) obliviously to this state, given only $| B_0 chevron.r$, an operator $U$ whose $chevron.l A_0 | U | B_0 chevron.r = a$ component is non-zero, and the ability to rotate about the states $| B_0 chevron.r$ (blue) and $| A_0 chevron.r$ (black) through chosen angles. The standard Grover iterate can be recovered in this model if one desires, by producing a simple rotation by $theta = 2 cos^(- 1) (sqrt(1 - a^2)) = 2 sin^(- 1) a$ (red) toward $| A_0 chevron.r$.
  ]
)
<fig:amplitude-amplification-bloch-sphere>

Thus, on the two-dimensional Hilbert space spanned by $( | A_0 med , | A_perp med )$, the action of $U$ is that of a $2 times 2$ unitary:

$ & U = a ( | A_0 chevron.r chevron.l B_0 | - | A_perp chevron.r chevron.l B_perp | ) \
  & + sqrt(1 - a^2) ( | A_perp chevron.r chevron.l B_0 | + | A_0 chevron.r chevron.l B_perp | ) , $

which is convenient to represent in matrix form, as

$ U = mat(delim: "[", 
    "", | B_0 chevron.r, | B_perp chevron.r;
    | A_0 chevron.r, a, sqrt(1 - a^2);
    | A_perp chevron.r, sqrt(1 - a^2), -a,
  ) thin , $<eq:ampamp_rot>

where the labels on the matrix indicate that columns act on $| B_0 med , | B_perp med$ (from left to right), and the rows act on $| A_0 med , | A_perp med$ (from top to bottom), such that $U$ brings a state in the $B$ basis into a state in the $A$ basis. These two bases are the two Bloch spheres (or qubit bases) encoded in the problem. Moreover, $U$ is a reflection operation, which we may represent in this qubit-like abstraction as $R ( a ) = X R_y ( theta )$, with $theta = 2 cos^(- 1) (sqrt(1 - a^2)) = 2 sin^(- 1) a$.

This two-Bloch sphere picture provides the intuitive basis for the following theorem:

#thmbox("theorem", "Theorem (Amplitude Amplification)")[

Given unitary $U$, its inverse $U^dagger$, and operators $A_phi = e^(i phi |A_0 chevron.r chevron.l A_0|)$, $B_phi = e^(i phi |B_0 chevron.r chevron.l B_0|)$,

$ chevron.l A_0 | A_(phi.alt_0) [ product_(k=1)^((d-1)/2) U B_(phi.alt_(2k-1)) U^dagger A_(phi.alt_(2k)) ] U | B_0 chevron.r = upright("Poly") ( a ) thin , $<eq:thm_aa_qsp>

where $d$ is odd, and $upright("Poly") ( a )$ is a polynomial in $a = chevron.l A_0|U|B_0 chevron.r$ of degree at most $d$ that obeys the conditions on $P$ from @thm:qsp.

] <thm:aa>

Why does this work? Note first that $U | B_0 med$ lives in the $A$-qubit space, spanned by $| A_0 chevron.r$ and $| A_perp chevron.r$. This qubit then gets rotated around its "$z$" axis by $A_phi.alt$. The $U^dagger$ then rotates this around the $y$ axis (and also does a reflection around $Z$, but we can disregard that for this intuition). $U^dagger$ also maps the state from the $A$-qubit space back into the $B$-qubit space, spanned by $| B_0 chevron.r$ and $| B_perp chevron.r$. Next, $B_phi.alt$ rotates the state around the $B$-qubit space's $z$-axis. Then the leftmost $U$ does another $y$-rotation (and reflection), and maps the state back into the $A$-qubit space. The sequence in the square brackets maps the state back and forth between the two qubit bases, sandwiching $y$-axis rotations with $z$-axis rotations. This sandwich of rotations is thus just doing quantum signal processing as in Sec.~@sec:qsp; we understand this behavior well!

The formal proof of this theorem begins by noting that on the subspaces defined by the two Bloch spheres defined above, $U = U^dagger$. Moreover, note that $R ( a )$, the $2 times 2$ unitary representation of $U$ (in the qubit bases relevant to our problem), is related to the $W ( a )$ of @eq:wa_qsp by

$R ( a ) = - i e^(i pi / 4 Z) W ( a ) e^(i pi / 4 Z) thin ,$<eq:wa_to_ra>

Substituting this into @eq:thm_aa_qsp, and recognizing that $A_phi.alt$ and $B_phi.alt$ simply become $z$-axis rotations, we obtain

$ chevron.l A_0 | ( e^(i phi.alt'_0 Z) [ product_(k=1)^d W ( a ) e^(i phi.alt'_k Z) ] ) U | B_0 chevron.r = upright("Poly") ( a ) , $<eq:aa_qsp_seq>

where ${ phi.alt'_k }$ are linear combinations of the original phases ${ phi.alt_k }$. By @thm:qsp, the term in parentheses is a matrix of related polynomials evaluated at $a$. The above matrix element thus evaluates to a polynomial $upright("Poly") ( a )$ of degree at most $d$ (which can be seen by counting the instances of $U$ and $U^dagger$ in @eq:thm_aa_qsp), completing the proof of @thm:aa.

@thm:aa takes on the meaning of performing "oblivious amplitude amplification" when the phases ${ phi.alt_k }$ are chosen such that the polynomial constructed approximates the sign function for small values of $a$. The technical aspects of generating the proper polynomials are further discussed in Sec.~@sec:Search and Appendix~@sec:appx_fpsearch.

Grover's celebrated quantum search algorithm~@grover1996fast, which is similar in character to the above, can easily be derived from the construction of amplitude amplification. In the search problem, some computational basis state $| A_0 med$ is unknown, but an oracle is given that implements

$ A_pi = e^(i pi | A_0 chevron.r chevron.l A_0 |) thin , $

and the goal is to create a quantum state close to $| A_0 med$ using as few queries to the oracle as possible. The search algorithm solves this problem by choosing $U = H^(⊗ n)$ (Hadamards on all the qubits in the search space), and starting with $| B_0 med = | 0 med$. Note that since $| A_0 med$ is a computational basis state, $chevron.l A_0 |U|B_0 chevron.r = 2^(-n/2) = 1/sqrt{N}$ because $U | B_0 med = | psi_0 med$ is an equal superposition over all $N$ basis states in the search space. This means that the amplitude amplification algorithm can be applied, with the specific case of $a = 1 / sqrt(N)$ being known, meaning we choose all the $phi.alt_k = pi$ for all $k$. This choice implies that

$ U B_phi.alt U^dagger = e^(i pi H^(⊗ n) | 0 chevron.r chevron.l 0 | H^(⊗ n)) = I - 2 | psi_0 chevron.r chevron.l psi_0 | thin , $

which can be recognized as Grover's "inversion about mean" iterate. This choice also produces an oscillating polynomial that monotonically increases the matrix element up to $d approx ceil.l pi / ( 2 sin^(- 1) a ) ceil.r$ steps~@PhysRevLett.113.210501. This may be seen by noting that each application of the signal rotation operator rotates through an angle $2 sin^(- 1) a$, and the target state is at most an angle $pi$ away, similar to the argument used to derive the query complexity of Grover's algorithm in ~@nielsen2010quantum. The amplitude amplification algorithm thus gives Grover's quantum search algorithm in this limit, and the number of oracle calls required is $d approx pi / ( 2 sin^(- 1) a ) = pi / ( 2 sin^(- 1) ( 1 / sqrt(N) ) ) = O ( sqrt(N) )$, the known performance of Grover's algorithm. Once more, a similar result will be discussed in Section~@sec:Search, where the flow from qubitization to QSVT to fixed point amplitude amplification will be applied more generally.

== Quantum Eigenvalue Transforms
<sec:eigenvalue_transforms>

@thm:aa is known as amplitude amplification because it accomplishes a polynomial transform of one specific amplitude, namely the matrix element of $U$ at $|A_0 chevron.r chevron.l B_0|$. However, this polynomial transform can actually be performed over #emph[an entire vector space], not just a one-dimensional matrix element. In particular, we now show that this technology can be used to polynomially transform all the #emph[eigenvalues] of a Hamiltonian $cal(H)$ that has been embedded into a block of a unitary matrix $U$.

Specifically, suppose we have the unitary

$ U = mat(delim: "[", 
    "", 0, 1;
    0, cal(H), dot.c;
    1, dot.c, dot.c,
  ) thin , $<eq:block_u_h>

where $cal(H)$ is some $N times N$ (possibly very large) Hamiltonian operator, located in the upper left block of $U$, labeled by an index qubit being in the state $| 0 med$ (and it is said that $cal(H)$ has thus been "qubitized"). We have included the indices $0$ and $1$ adjacent to the matrix representation of $U$ to schematically indicate how $cal(H)$ is encoded in $U$. At the cost of some generality let us make some assumptions for simplicity of exposition. In particular, assume the operator norm $parallel cal(H) parallel$ is sufficiently small that this block embedding can be achieved, i.e. $parallel cal(H) parallel lt.eq 1$ (if not, then one can instead embed some rescaled version of the Hamiltonian, $cal(H) / alpha$, but for now we will neglect this case for the sake of expository clarity). In particular, suppose that the eigenvectors and eigenvalues of $cal(H)$ are given as

$ cal(H) = sum_lambda lambda | lambda chevron.r chevron.l lambda | thin , $

Then, specializing to a specific block encoding for clarity, the missing blocks of $U$ may be completed as

$U = mat(delim: "[", cal(H), sqrt(I - cal(H)^2); sqrt(I - cal(H)^2), - cal(H)) thin ,$<eq:U_block_encoding>

where

$ sqrt(I - cal(H)^2) = sum_lambda sqrt(1 - lambda^2) | lambda chevron.r chevron.l lambda | thin , $

and it can be seen by inspection that $U^dagger U = I$ as required for the unitarity of $U$, as long as the eigenvalues $lambda$ are of reasonable scale. While a general block encoding need not take this specialized form, this choice of encoding will be sufficient for our illustrative purposes. Moreover, the treatment of general block encodings is presented in~@Gily_n_2019 @Low_2019, wherein it is shown that a general block encoding takes a form similar to @eq:U_block_encoding in a special basis related to the eigenbasis of $cal(H)$.

Our specialized choice of block encoding means that $U$ may be expressed as a sum of two tensor products

$U = Z ⊗ cal(H) + X ⊗ sqrt(I - cal(H)^2) thin ,$

and therefore acts as

$ U | 0 med | lambda med & = & lambda | 0 med | lambda med + sqrt(1 - lambda^2) | 1 med | lambda med\
U | 1 med | lambda med & = & - lambda | 1 med | lambda med + sqrt(1 - lambda^2) | 0 med | lambda med thin , $

which indicates that $U$ contains a Bloch sphere (i.e. a qubit basis) for each eigenspace#footnote[Note that even for degenerate eigenspaces the linearity of the QSP sequence ensures qubitization.] of $cal(H)$ corresponding to a certain eigenvalue. In particular, $U$ may be expressed as a sum over $N$ separate Bloch spheres:

$ & U = sum_lambda mat(delim: "[", lambda, sqrt(1 - lambda^2); sqrt(1 - lambda^2), -lambda) ⊗ | lambda chevron.r chevron.l lambda | \
  & = sum_lambda [ sqrt(1 - lambda^2) X + lambda Z ] ⊗ | lambda chevron.r chevron.l lambda | \
  & =: sum_lambda R ( lambda ) ⊗ | lambda chevron.r chevron.l lambda | = ⊕_lambda R ( lambda ) , $<eq:uham_bloch_spheres>

where $R ( lambda )$ is defined as the operator in square brackets in the penultimate line above, and may be interpreted as a reflection and rotation about the Bloch sphere's $y$-axis, exactly the same as we found for the $R ( a )$ operator that appeared in the amplitude amplification construction as per @eq:ampamp_rot. We thus have a form for $U$ which parallels that of the amplitude amplification scenario. However, unlike amplitude amplification, we do not have one-dimensional phase rotation operators $A_phi.alt$ and $B_phi.alt$, because we have $N$ Bloch spheres, and not just two!

Nevertheless, there are still distinct vector spaces in which the input and output of $cal(H)$ exist: these are, respectively, the column space and row space of the matrix $cal(H)$, within $U$. In the scenario of @eq:block_u_h, these vector spaces are defined by the projector $Pi := |0 chevron.r chevron.l 0|$ acting on the auxiliary qubit. Generalizing the way amplitude amplification employs the phase shift $A_phi.alt$ of @eq:aa_aphi acting on a single element $|A_0 chevron.r chevron.l A_0|$, we may now define a projector controlled phase shift operation $Pi_phi.alt$:

$Pi_phi.alt := e^(i 2 phi.alt Pi) thin ,$

which imparts a phase of $e^(i 2 phi.alt)$ to the #emph[entire subspace] determined by the projector $Pi$. Note that if we want to be more precise, we may instead define this operation as

$Pi_phi.alt := e^(i phi.alt ( 2 Pi - I ))$

which is a proper unitary transform and acts as a $z$-rotation, like $S ( phi.alt )$ from @eq:qsp_rotation, but these two definitions differ only by a global phase which may be neglected. From a quantum circuit standpoint, $Pi_phi.alt$ may be realized by employing two instances of projector controlled-not gates (which we will refer to as $Pi$-controlled-not, or $upright("C")_Pi upright("NOT")$ for short) around a single qubit $z$-rotation by angle $phi.alt$:

// [figvision] imgs/fig_phased_iterate.png
// The figure shows a schematic diagram of a quantum circuit. The circuit has two horizontal lines representing
// qubits, with the top line labeled |0and the bottom line labeled |ψ0. There are two vertical boxes, Π, one on
// each qubit line, connected by a controlled rotation gate exp(−iϕZ) on the top line. The boxes represent
// projection operators Π. The gate is a controlled phase shift gate with a phase factor of exp(−iϕZ). The trend
// or message is that this circuit realizes a projector-controlled phase shift, also termed the "phased iterate".
#figure(image("imgs/fig_phased_iterate.png", width: 100%),
  caption: [
    The circuit used to realize the projector controlled phase shift $Pi_phi.alt$, also termed the "phased iterate", in analogy to the bare $exp ( i phi.alt Z )$ operation used in QSP, used as the signal processing rotation operator. We note that this circuit is valid for an arbitrary projector $Pi$, although it simplifies to a single rotation for the simple projector $Pi = | 0 chevron.r chevron.l 0 |$ that we've used in this section.
  ]
)
<fig:projector-phase-shift-quantum-circuit>

The main relevant observation is that on the subspace of each of the $N$ Bloch spheres of @eq:uham_bloch_spheres, $Pi_phi.alt$ acts as a $z$-axis rotation,

$ Pi_phi.alt = sum_lambda e^(i phi.alt Z) ⊗ | lambda chevron.r chevron.l lambda | = ⊕_lambda e^(i phi.alt Z) $

with $| lambda med$ as an eigenvector.

This picture of $N$ separate Bloch spheres evolving under $z$- and $y$-rotations provides the intuitive basis for the following theorem:

#thmbox("theorem", "Theorem (Eigenvalue transformation)")[

Given a block encoding of Hamiltonian $cal(H) = sum_lambda lambda |lambda chevron.r chevron.l lambda|$ in a unitary matrix $U$,

$ U = mat(delim: "[", 
    "", Pi, "";
    Pi, cal(H), dot.c;
    "", dot.c, dot.c,
  ) thin , $

with the location of $cal(H)$ determined by projector $Pi$, and given the ability to perform $Pi$-controlled NOT operations to realize projector controlled phase shift operations $Pi_phi.alt$, then, for even $d$,

$ & U_(arrow(phi.alt)) = [ product_(k=1)^(d/2) Pi_(phi.alt_(2k-1)) U^dagger Pi_(phi.alt_(2k)) U ] \
  & = mat(delim: "[", "", Pi, ""; Pi, upright("Poly") ( cal(H) ), dot.c; "", dot.c, dot.c) , $<eq:thm_eigenvalue_transform>

where

$ upright("Poly") ( cal(H) ) = sum_lambda upright("Poly") ( lambda ) | lambda chevron.r chevron.l lambda | $

is a polynomial transform of the eigenvalues of $cal(H)$. The polynomial is of degree at most $d$, and obeys the conditions on $P$ from @thm:qsp.

Similarly, for odd $d$,

$ & U_(arrow(phi.alt)) = Pi_(phi.alt_1) U [ product_(k=1)^((d-1)/2) Pi_(phi.alt_(2k)) U^dagger Pi_(phi.alt_(2k+1)) U ] \
  & = mat(delim: "[", "", Pi, ""; Pi, upright("Poly") ( cal(H) ), dot.c; "", dot.c, dot.c) , $<eq:thm_eigenvalue_transform_odd>

where $upright("Poly") ( cal(H) )$ has an analogous interpretation.

] <thm:eigenvalue_transform>

Why does this work? For the same reason that @thm:aa does! To see this, let us use the specific encoding of @eq:U_block_encoding to rewrite @eq:thm_eigenvalue_transform as an action on $N$ separate Bloch spheres (the odd $d$ case in @eq:thm_eigenvalue_transform_odd being analogous):

$U_(arrow(phi.alt)) & = & ⊕_lambda [product_(k = 1)^(d / 2) e^(i phi.alt_(2 k - 1) Z) R ( lambda ) e^(i phi.alt_(2 k) Z) R ( lambda )] ,$<eq:sigproc_tran_a>

recognizing that we have chosen conventions for $R ( lambda )$ in @eq:uham_bloch_spheres such that $R^dagger ( lambda ) = R ( lambda )$. This allows us to relabel the sum and the phases to put @eq:sigproc_tran_a into a standard form of quantum signal processing (similar to how we obtained @eq:sigproc_tran_a):

$U_(arrow(phi.alt)) & = & ⊕_lambda [e^(i phi.alt'_0 Z) product_(k = 1)^d W ( lambda ) e^(i phi.alt'_k Z)] thin .$<eq:sigproc_tran_b>

By @thm:qsp, the term in brackets is a matrix of polynomials in $lambda$, verifying @thm:qsp. Finally, although we have specialized to the specific block encoding of @eq:U_block_encoding, the proof for more general block encodings is contained in~@Gily_n_2019 @Low_2019.

One immediately apparent utility of this eigenvalue transformation theorem is its usefulness in filtering eigenvalues. For example, we saw previously in Section~@sec:qsp that the BB1 sequence of phases can be used to increase sensitivity to the signal. In this eigenvalue transformation scenario, the signal is the eigenvalue $lambda$, and a sequence of QSP phases can be used to selectively filter a range of eigenvalues, e.g. those below a threshold of $lambda approx 2 pi / 3$ in the case of BB1 (for now this is an imprecise statement, but a similar question is a major concern of Section~@sec:Threshold). Measuring the projector $Pi$ will show that the QSP sequence flips the index qubit with higher probability if the Hamiltonian has an eigenvalue larger than this threshold, versus when all the eigenvalues of $cal(H)$ are below the threshold. This result also assumes the ability to prepare a state which has some overlap with the relevant eigenstates of $cal(H)$, as input into $U$, but the specific amplitudes of the overlap are not crucial, because amplitude amplification can be employed to boost the signal.

== Quantum Singular Value Transforms
<sec:qsvt>

@thm:eigenvalue_transform is known as the eigenvalue transformation because it accomplishes a polynomial transform of the eigenvalues of a matrix embedded within a larger unitary matrix. However, in general the embedded matrix need not have a well defined set of eigenvalues; for example, instead of being a square matrix, it could be rectangular. Remarkably, the same idea of transforming the embedded matrix using quantum signal processing can still apply. Specifically, we now show that QSP sequences can be used to polynomially transform all the #emph[singular values] of a (possibly non-square) matrix $A$ which has been encoded into a block of a unitary matrix $U$.

Such a general matrix $A$ can be decomposed as

$A = W_Sigma Sigma V_Sigma^dagger thin ,$

where $W_Sigma$ and $V_Sigma$ are unitary and $Sigma$ is diagonal and contains along its diagonal the set of non-negative real numbers ${ sigma_k }$, known as the singular values of $A$, of which there are $r = upright("rank") ( A )$ nonzero values. All matrices have such a #emph[singular value decomposition] (SVD).

As $W_Sigma$ and $V_Sigma$ are unitary, their columns form orthonormal bases, which we denote by ${ | w_k med }$ and ${ | v_k med }$, respectively. ${ | w_k med }$ are the left singular vectors, which span the left singular vector space, and ${ | v_k med }$ are the right singular vectors, which span the right singular vector space. Using this notation, we may conveniently rewrite the singular value decomposition of $A$ in a form analogous to the eigenvalue decomposition:

$ A = sum_(k=1)^r sigma_k | w_k chevron.r chevron.l v_k | thin , $

Now, suppose that we are given a unitary matrix $U$ such that $A$ is encoded in a block of $U$, i.e.

$ U = mat(delim: "[", 
    "", Pi, "";
    tilde(Pi), A, dot.c;
    "", dot.c, dot.c,
  ) thin , $<eq:block_u_A>

where $"tilde"Pi := sum_k |w_k chevron.r chevron.l w_k|$ and $Pi := sum_k |v_k chevron.r chevron.l v_k|$ are projectors which locate $A$ within $U$, such that $A = tilde(Pi) U Pi$. We have again included $Pi$ and $tilde(Pi)$ indices adjacent to the matrix representation of $U$ to schematically indicate how $A$ is encoded in $U$: $Pi$ selects the columns and $tilde(Pi)$ the rows in which $A$ is encoded. Moreover, the projectors $Pi$ and $tilde(Pi)$ also identify the left and right singular vector spaces, respectively.

For pedagogical simplicity, let us assume for now that $A$ is a square matrix (this assumption is dropped in the next section). Again specializing to a specific block encoding, we may complete the missing blocks of the unitary $U$ by writing

$ U = mat(delim: "[", 
    "", 0, 1;
    0, A, sqrt(I - A^2);
    1, sqrt(I - A^2), -A,
  ) thin , $<eq:A_block_encoding>

where the $0$ and $1$ are index qubit labels for the block matrices within $U$, and where $sqrt(I - A^2)$ is formally defined in terms of the SVD of $A$, as

$ sqrt(I - A^2) := sum_k sqrt(1 - sigma_k^2) | w_k chevron.r chevron.l v_k | thin , $

It can then be verified straightforwardly that $U^dagger U = I$, as long as the singular values ${ sigma_k }$ are less than or equal to $1$ (which may always be achieved by rescaling $A$ to some $A / alpha$). Again, while a general block encoding need not take this specialized form, this choice will be sufficient for our illustrative purposes. And moreover, the treatment of general block encodings is presented in~@Gily_n_2019, wherein it is shown that a general block encoding takes a form similar to @eq:U_block_encoding in special basis related to the left and right singular vectors of $A$.

Just as with the analysis of the block-encoded Hamiltonian $cal(H)$, there are multiple Bloch spheres in $U$. Specifically, note that

$ U | 0 med | v_k med & = & sigma_k | 0 med | w_k med + sqrt(1 - sigma_k^2) | 1 med | w_k med\
U | 1 med | v_k med & = & - sigma_k | 1 med | w_k med + sqrt(1 - sigma_k^2) | 0 med | w_k med thin , $

so that $U$ may be expressed as a direct sum over a number of separate Bloch spheres equal to the rank of $A$:

$ & U = sum_k mat(delim: "[", sigma_k, sqrt(1 - sigma_k^2); sqrt(1 - sigma_k^2), -sigma_k) ⊗ | w_k chevron.r chevron.l v_k | \
  & = sum_k [ sqrt(1 - sigma_k^2) X + sigma_k Z ] ⊗ | w_k chevron.r chevron.l v_k | \
  & =: sum_k R ( sigma_k ) ⊗ | w_k chevron.r chevron.l v_k | thin , $<eq:svd_bloch_spheres>

where we have defined $R ( sigma_k )$ analogous to $R ( lambda )$ in @eq:uham_bloch_spheres. We now have a form for $U$ which directly parallels that of the eigenvalue transform scenario, and for exactly the same reasons, the following theorem holds:

#thmbox("theorem", "Theorem (Singular value transformation)")[

Given a block encoding of a matrix $A = sum_k sigma_k |w_k chevron.r chevron.l v_k|$ in a unitary matrix $U$,

$ upright("Poly")^((upright("SV"))) ( A ) := sum_k upright("Poly") ( sigma_k ) | w_k chevron.r chevron.l v_k | , $

with the location of $A$ determined by projectors $Pi$ and $tilde(Pi)$, and given the ability to perform $Pi$- and $tilde(Pi)$-controlled not operations to realize projector controlled phase shift operations $Pi_phi.alt$ and $tilde(Pi)_phi.alt$ (defined as in Sec.~@sec:eigenvalue_transforms), then, for odd $d$,

$ & U_(arrow(phi.alt)) = tilde(Pi)_(phi.alt_1) U [ product_(k=1)^((d-1)/2) Pi_(phi.alt_(2k)) U^dagger tilde(Pi)_(phi.alt_(2k+1)) U ] \
  & = mat(delim: "[", "", Pi, ""; tilde(Pi), upright("Poly")^((upright("SV"))) ( A ), dot.c; "", dot.c, dot.c) , $<eq:thm_singular_value_transform_d_odd>

where $upright("Poly")^(( upright("SV") )) ( A )$ is defined for an odd polynomial as

$ upright("Poly")^((upright("SV"))) ( A ) := sum_k upright("Poly") ( sigma_k ) | w_k chevron.r chevron.l v_k | , $

which applies a polynomial transform to the singular values of $A$. The polynomial is of degree at most $d$ and obeys the conditions of $P$ from @thm:qsp.

Similarly, for $d$ even,

$ & U_(arrow(phi.alt)) = [ product_(k=1)^(d/2) Pi_(phi.alt_(2k-1)) U^dagger tilde(Pi)_(phi.alt_(2k)) U ] \
  & = mat(delim: "[", "", Pi, ""; Pi, upright("Poly")^((upright("SV"))) ( A ), dot.c; "", dot.c, dot.c) , $<eq:thm_singular_value_transform>

where $upright("Poly")^(( upright("SV") )) ( A )$ is defined for an even polynomial as

$ upright("Poly")^((upright("SV"))) ( A ) := sum_k upright("Poly") ( sigma_k ) | v_k chevron.r chevron.l v_k | . $

which is also a polynomial transform of the singular values of $A$, but with the modification that the input and output spaces are both the right singular vector space, spanned by ${ | v_k chevron.r }$. Analogously, the polynomial is of degree at most $d$ and obeys the conditions of $P$ from @thm:qsp.

] <thm:singular_value_transform>

The main difference between this theorem and the eigenvalue transform of @thm:eigenvalue_transform is that here, the Bloch sphere transformations of $U$ also switch between the ${ | v_k chevron.r }$ and the ${ | w_k chevron.r }$ bases, similar to how the sequence in @thm:aa (@eq:thm_aa_qsp) flips between bases. Thus, we should now carefully keep track of which vector space the system is in at each stage of operation. In particular, in each of the terms in square brackets in @eq:thm_singular_value_transform and~@eq:thm_singular_value_transform_d_odd, the $U$ on the right moves the system from the ${ | v_k chevron.r }$ basis into the ${ | w_k chevron.r }$ basis, and $tilde(Pi)_phi.alt$ then rotates the system around the $z$-axis of each left singular vector space's Bloch sphere. Similarly, the $U^dagger$ on the left then moves the system back from the ${ | w_k chevron.r }$ basis into the ${ | v_k chevron.r }$ basis, and finally $tilde(Pi)_phi.alt$ rotates the system around the $z$-axis of each right singular vector space's Bloch sphere. Therefore, the odd $d$ sequence starts in the right singular vector space and ends in the left singular vector space, such that $upright("Poly")^(( upright("SV") )) ( A )$ is accessed with $Pi$ and $tilde(Pi)$, whereas the even $d$ sequence starts and ends in the right singular vector space, such that $upright("Poly")^(( upright("SV") )) ( A )$ is accessed with just $Pi$.

With this crucial modification, @thm:singular_value_transform may be verified by following the same logic as that of @thm:eigenvalue_transform, while the proof for general block encodings is presented in~@Gily_n_2019. Theorem @Gily_n_2019 is the essence of the quantum singular value transform (QSVT) algorithm, and we elaborate in the next sections upon what can be accomplished with it.

== Block Encodings
<sec:Block_Encodings>

A key idea behind the generalization of QSP from single-qubit dynamics, to multi-qubit transforms is the use of a block-encoded operator, as we have just seen in the last two subsections (and as is discussed in the following sections). While the embedding of one matrix inside a larger one is well known in mathematics as a #emph[dilation]@horn_johnson_1991, as used here, block encoded operators are a quantum concept, and their construction comes with some caveats. We elaborate on these constructions in this subsection.

The starting point for many applications of QSP and QSVT is the availability of the desired signal as a linear operator, a matrix $A$, encoded as a block inside a larger unitary matrix $U$, as described in @eq:block_u_A. What is such a block encoded operator, physically? Some limited intuition comes from the case when $A$ is a unitary matrix, in which case $U$ is simply a controlled-$A$ operator, as depicted in @fig:block_encoded_A.

// [figvision] imgs/fig_controlled_op.png
// The figure has one panel. It is a schematic diagram. There are no axes. The panel shows a rectangle labeled A
// with lines crossing it, representing a quantum circuit block. A line above the block connects to the block via
// a circle symbol, indicating a control qubit. The block has three lines crossing it, with dots on either side,
// suggesting additional qubits. The rectangle is labeled A, and there is an equals sign relating it to a matrix
// with A in the top left and dots elsewhere. The trend or message is that this block encodes a unitary
// operation, with the empty circle signifying a control.
#figure(image("imgs/fig_controlled_op.png", width: 100%),
  caption: [
    A simple block encoding quantum circuit, showing how such a block encoding of a unitary $A$ is notated. Observe that the empty circle on the control qubit (top line) indicates a $| 0 chevron.r$ control, whereas a filled-in circle would correspond to a $| 1 chevron.r$ control.
  ]
)
<fig:block_encoded_A>

// [figvision] imgs/fig_swap_controlled.png
// ## Step 1: Describe panel (a) Panel (a) is a schematic diagram. The axes are not explicitly labeled but appear
// to represent a quantum circuit layout with no numerical scales. There are three horizontal lines representing
// qubits, labeled |, |, and | from top to bottom. A control qubit symbol (a dot) is on the top line. Two swap
// operations (represented by * symbols) are on the middle and bottom lines, with one line crossing over. A box
// labeled A encloses a section of the middle line between the swaps. The trend shows a controlled operation
// involving swap gates and operator A. ## Step 2: Describe panel (b) Panel (b) is also a schematic diagram with
// the same structure as panel (a) but with a different configuration. The top line has a control qubit symbol.
// The middle and bottom lines have no symbols other than the labels. A box labeled A is now directly below the
// bottom line, and there is a line crossing under it. The message here shows an equivalent circuit with A
// applied conditionally. ## Step 3: Describe the relationship between panels (a) and (b) The panels are related