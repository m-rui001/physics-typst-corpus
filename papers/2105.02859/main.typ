#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.88cm, bottom: 2.15cm), columns: 2)
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

#place(top, float: true, scope: "parent", clearance: 1.2em)[
#align(center)[
  #text(12pt, weight: "bold", [A Grand Unification of Quantum Algorithms])   #v(1.2em)
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
]

= INTRODUCTION
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

We share the story of this grand unification of quantum algorithms by first surveying the development of QSVT in Section~#ref(<sec:QSP_To_QSVT>, supplement: none), beginning with quantum signal processing and then demonstrating how this technology leads to quantum eigenvalue transforms and ultimately the quantum singular value transformation. Thereafter, we detail a statement of grand unification for currently known quantum algorithms, presenting QSVT-based algorithms for the search problem and the eigenvalue threshold problem in Secs.~@sec:Search and~@sec:Threshold, respectively. Further fulfilling the unification promise, we introduce an algorithm for phase estimation by QSVT in Section~#ref(<sec:PhaseEstimation>, supplement: none), and show how the quantum Fourier transform emerges from cascading QSVT sequences. We then highlight in Section~#ref(<sec:FuncEval>, supplement: none) how QSVT can yield intuitive algorithms for Hamiltonian simulation and matrix inversion. Lastly, in Section~#ref(<sec:Discussion>, supplement: none), we explore the implications of these results and discuss areas of future research in the utility of QSVT.

= FROM QSP TO QSVT
<sec:QSP_To_QSVT>

In this section, we develop the framework of QSVT, starting with quantum signal processing and then providing a concrete application of this technology to amplitude amplification. Building off this example, we establish quantum eigenvalue transforms and finally quantum singular value transforms. Overall, this section is meant to be pedagogical and easily accessible to readers with a background in basic quantum circuits and linear algebra, as the constructions of this section underlie the remainder of the work. For more details on QSP and QSVT, including alternate introductions to the topics, rigorous proofs, and applications not covered here, see @low2017quantum @Low_2016 @gilyen2019quantum @Gily_n_2019.

== Quantum Signal Processing
<sec:qsp>

Quantum signal processing (QSP) generalizes the results of composite pulse sequences~@Low_2016 @Low_2017 @Low_2019, and is built on the idea of interleaving two kinds of single qubit rotations: a #emph[signal] rotation operator $W$, and a #emph[signal processing] rotation operator $S$. These rotation operations are about different axes through the Bloch sphere, e.g. commonly $W$ is an $x$-rotation, while $S$ is a $z$-rotation. Moreover, the signal rotation always rotates through the same angle $theta$, whereas the signal processing rotation rotates through a variable angle according to some pre-determined sequence.

For example, let the signal rotation operator be

$ W ( a ) = mat(delim: "[", a, i sqrt(1 - a^2); i sqrt(1 - a^2), a) thin , $<eq:wa_qsp>

which is an $x$-rotation by angle $theta = - 2 cos^(- 1) a$. And let the signal processing rotation operator be

$ S ( phi.alt ) = e^(i phi.alt Z) thin , $<eq:qsp_rotation>

which is a $z$-rotation by angle $- 2 phi.alt$. For a tuple of phases $arrow(phi.alt) = ( phi.alt_0 , phi.alt_1 , . . . phi.alt_d ) in bb(R)^(d + 1)$, and using these conventions#footnote[The convention presented in @eq:qsp_uphi may be called the Wx convention. See Appendix~@sec:QSPConventions for other conventions.], the QSP operation sequence $U_(arrow(phi.alt))$ is defined as

$ U_(arrow(phi.alt)) = e^(i phi.alt_0 Z) product_(k = 1)^d W ( a ) e^(i phi.alt_k Z) thin . $<eq:qsp_uphi>

What is interesting is how QSP can modify the incoming signal. Suppose $arrow(phi.alt) = ( 0 , 0 )$, i.e. there is no processing, such that $U_(arrow(phi.alt)) = W ( a )$ is just the unchanged signal. If we plot the probability of a $| 0 med$ qubit input staying unchanged under this operation, i.e. $p = |chevron.l 0|U_(arrow(phi.alt))|0 chevron.r|^2$, as a function of $theta$, we find a nice cosinusoid (the lower plot in @fig:qsp_response_functions), because for this case $p = cos^2 (theta / 2)$. Now if we do some signal processing, by letting $arrow(phi.alt) = ( pi / 2 , - eta , 2 eta , 0 , - 2 eta , eta )$, where $eta = 1 / 2 cos^(- 1) (- 1 / 4)$, then for the new $U_(arrow(phi.alt))$ using these phases, we find the new probability $p = |chevron.l 0|U_(arrow(phi.alt))|0 chevron.r|^2 = 1/8 cos^2 (theta/2) (3 cos^8 (theta/2)$ $ - 15 cos^6 (theta/2) + 35 cos^4 (theta/2) - 45 cos^2 (theta/2) + 30)$ (the upper dotted dashed line in @fig:qsp_response_functions), which for small $theta$ is approximately $1 - 5 / 8 (theta / 2)^6$. This has the nice property that the qubit remains unflipped for a wide range of signal angles, but then a sharp transition happens around $theta approx 2 pi / 3$. This increases sensitivity to specific values of the signal!

// [figvision] imgs/fig_bb1_comparison.png
// The figure has one panel. The plot shows the squared absolute value of the transition amplitude versus the
// angle . The horizontal axis ranges from - to , and the vertical axis ranges from 0 to 1. There are two series:
// one for the "Trivial" case with a uniform dashed line and one for the "BB1" case with a dotted dashed line.
// The trend shows that the "BB1" case has a near-one transition probability for a wider range of compared to the
// "Trivial" case. The message is that the QSP sequence for the BB1 protocol improves the transition probability.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

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

Specifically, we discuss the problem of amplitude amplification; a similar construction will be discussed in Section~#ref(<sec:Search>, supplement: none) employing the major theorems of QSVT, but here we begin from basic principles. It is hoped that the geometric intuition behind the argument which follows, and the expediency of the fully-developed construction in Section~#ref(<sec:Search>, supplement: none), will complement each other.

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

$ U | B_0 med = a | A_0 med + sqrt(1 - a^2) | A_perp med $

for $a=chevron.l A_0|U|B_0 chevron.r$ (we may assume that $a$ is real because a possible phase may be absorbed into $| B_0 chevron.r$)). Similarly, we may define some $| B_perp med$ such that

$ U | B_perp med = - a | A_perp med + sqrt(1 - a^2) | A_0 med thin . $

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

Why does this work? Note first that $U | B_0 med$ lives in the $A$-qubit space, spanned by $| A_0 chevron.r$ and $| A_perp chevron.r$. This qubit then gets rotated around its "$z$" axis by $A_phi.alt$. The $U^dagger$ then rotates this around the $y$ axis (and also does a reflection around $Z$, but we can disregard that for this intuition). $U^dagger$ also maps the state from the $A$-qubit space back into the $B$-qubit space, spanned by $| B_0 chevron.r$ and $| B_perp chevron.r$. Next, $B_phi.alt$ rotates the state around the $B$-qubit space's $z$-axis. Then the leftmost $U$ does another $y$-rotation (and reflection), and maps the state back into the $A$-qubit space. The sequence in the square brackets maps the state back and forth between the two qubit bases, sandwiching $y$-axis rotations with $z$-axis rotations. This sandwich of rotations is thus just doing quantum signal processing as in Sec.~#ref(<sec:qsp>, supplement: none); we understand this behavior well!

The formal proof of this theorem begins by noting that on the subspaces defined by the two Bloch spheres defined above, $U = U^dagger$. Moreover, note that $R ( a )$, the $2 times 2$ unitary representation of $U$ (in the qubit bases relevant to our problem), is related to the $W ( a )$ of @eq:wa_qsp by

$ R ( a ) = - i e^(i pi / 4 Z) W ( a ) e^(i pi / 4 Z) thin , $<eq:wa_to_ra>

Substituting this into @eq:thm_aa_qsp, and recognizing that $A_phi.alt$ and $B_phi.alt$ simply become $z$-axis rotations, we obtain

$ chevron.l A_0 | ( e^(i phi.alt'_0 Z) [ product_(k=1)^d W ( a ) e^(i phi.alt'_k Z) ] ) U | B_0 chevron.r = upright("Poly") ( a ) , $<eq:aa_qsp_seq>

where ${ phi.alt'_k }$ are linear combinations of the original phases ${ phi.alt_k }$. By @thm:qsp, the term in parentheses is a matrix of related polynomials evaluated at $a$. The above matrix element thus evaluates to a polynomial $upright("Poly") ( a )$ of degree at most $d$ (which can be seen by counting the instances of $U$ and $U^dagger$ in @eq:thm_aa_qsp), completing the proof of @thm:aa.

@thm:aa takes on the meaning of performing "oblivious amplitude amplification" when the phases ${ phi.alt_k }$ are chosen such that the polynomial constructed approximates the sign function for small values of $a$. The technical aspects of generating the proper polynomials are further discussed in Sec.~#ref(<sec:Search>, supplement: none) and Appendix~@sec:appx_fpsearch.

Grover's celebrated quantum search algorithm~@grover1996fast, which is similar in character to the above, can easily be derived from the construction of amplitude amplification. In the search problem, some computational basis state $| A_0 med$ is unknown, but an oracle is given that implements

$ A_pi = e^(i pi | A_0 chevron.r chevron.l A_0 |) thin , $

and the goal is to create a quantum state close to $| A_0 med$ using as few queries to the oracle as possible. The search algorithm solves this problem by choosing $U = H^(⊗ n)$ (Hadamards on all the qubits in the search space), and starting with $| B_0 med = | 0 med$. Note that since $| A_0 med$ is a computational basis state, $chevron.l A_0 |U|B_0 chevron.r = 2^(-n/2) = 1/sqrt{N}$ because $U | B_0 med = | psi_0 med$ is an equal superposition over all $N$ basis states in the search space. This means that the amplitude amplification algorithm can be applied, with the specific case of $a = 1 / sqrt(N)$ being known, meaning we choose all the $phi.alt_k = pi$ for all $k$. This choice implies that

$ U B_phi.alt U^dagger = e^(i pi H^(⊗ n) | 0 chevron.r chevron.l 0 | H^(⊗ n)) = I - 2 | psi_0 chevron.r chevron.l psi_0 | thin , $

which can be recognized as Grover's "inversion about mean" iterate. This choice also produces an oscillating polynomial that monotonically increases the matrix element up to $d approx ceil.l pi / ( 2 sin^(- 1) a ) ceil.r$ steps~@PhysRevLett.113.210501. This may be seen by noting that each application of the signal rotation operator rotates through an angle $2 sin^(- 1) a$, and the target state is at most an angle $pi$ away, similar to the argument used to derive the query complexity of Grover's algorithm in ~@nielsen2010quantum. The amplitude amplification algorithm thus gives Grover's quantum search algorithm in this limit, and the number of oracle calls required is $d approx pi / ( 2 sin^(- 1) a ) = pi / ( 2 sin^(- 1) ( 1 / sqrt(N) ) ) = O ( sqrt(N) )$, the known performance of Grover's algorithm. Once more, a similar result will be discussed in Section~#ref(<sec:Search>, supplement: none), where the flow from qubitization to QSVT to fixed point amplitude amplification will be applied more generally.

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

$ U = mat(delim: "[", cal(H), sqrt(I - cal(H)^2); sqrt(I - cal(H)^2), - cal(H)) thin , $<eq:U_block_encoding>

where

$ sqrt(I - cal(H)^2) = sum_lambda sqrt(1 - lambda^2) | lambda chevron.r chevron.l lambda | thin , $

and it can be seen by inspection that $U^dagger U = I$ as required for the unitarity of $U$, as long as the eigenvalues $lambda$ are of reasonable scale. While a general block encoding need not take this specialized form, this choice of encoding will be sufficient for our illustrative purposes. Moreover, the treatment of general block encodings is presented in~@Gily_n_2019 @Low_2019, wherein it is shown that a general block encoding takes a form similar to @eq:U_block_encoding in a special basis related to the eigenbasis of $cal(H)$.

Our specialized choice of block encoding means that $U$ may be expressed as a sum of two tensor products

$ U = Z ⊗ cal(H) + X ⊗ sqrt(I - cal(H)^2) thin , $

and therefore acts as

$ U | 0 med | lambda med & = & lambda | 0 med | lambda med + sqrt(1 - lambda^2) | 1 med | lambda med\
U | 1 med | lambda med & = & - lambda | 1 med | lambda med + sqrt(1 - lambda^2) | 0 med | lambda med thin , $

which indicates that $U$ contains a Bloch sphere (i.e. a qubit basis) for each eigenspace#footnote[Note that even for degenerate eigenspaces the linearity of the QSP sequence ensures qubitization.] of $cal(H)$ corresponding to a certain eigenvalue. In particular, $U$ may be expressed as a sum over $N$ separate Bloch spheres:

$ & U = sum_lambda mat(delim: "[", lambda, sqrt(1 - lambda^2); sqrt(1 - lambda^2), -lambda) ⊗ | lambda chevron.r chevron.l lambda | \
  & = sum_lambda [ sqrt(1 - lambda^2) X + lambda Z ] ⊗ | lambda chevron.r chevron.l lambda | \
  & =: sum_lambda R ( lambda ) ⊗ | lambda chevron.r chevron.l lambda | = ⊕_lambda R ( lambda ) , $<eq:uham_bloch_spheres>

where $R ( lambda )$ is defined as the operator in square brackets in the penultimate line above, and may be interpreted as a reflection and rotation about the Bloch sphere's $y$-axis, exactly the same as we found for the $R ( a )$ operator that appeared in the amplitude amplification construction as per @eq:ampamp_rot. We thus have a form for $U$ which parallels that of the amplitude amplification scenario. However, unlike amplitude amplification, we do not have one-dimensional phase rotation operators $A_phi.alt$ and $B_phi.alt$, because we have $N$ Bloch spheres, and not just two!

Nevertheless, there are still distinct vector spaces in which the input and output of $cal(H)$ exist: these are, respectively, the column space and row space of the matrix $cal(H)$, within $U$. In the scenario of @eq:block_u_h, these vector spaces are defined by the projector $Pi := |0 chevron.r chevron.l 0|$ acting on the auxiliary qubit. Generalizing the way amplitude amplification employs the phase shift $A_phi.alt$ of @eq:aa_aphi acting on a single element $|A_0 chevron.r chevron.l A_0|$, we may now define a projector controlled phase shift operation $Pi_phi.alt$:

$ Pi_phi.alt := e^(i 2 phi.alt Pi) thin , $

which imparts a phase of $e^(i 2 phi.alt)$ to the #emph[entire subspace] determined by the projector $Pi$. Note that if we want to be more precise, we may instead define this operation as

$ Pi_phi.alt := e^(i phi.alt ( 2 Pi - I )) $

which is a proper unitary transform and acts as a $z$-rotation, like $S ( phi.alt )$ from @eq:qsp_rotation, but these two definitions differ only by a global phase which may be neglected. From a quantum circuit standpoint, $Pi_phi.alt$ may be realized by employing two instances of projector controlled-not gates (which we will refer to as $Pi$-controlled-not, or $upright("C")_Pi upright("NOT")$ for short) around a single qubit $z$-rotation by angle $phi.alt$:

// [figvision] imgs/fig_phased_iterate.png
// The figure shows a schematic diagram of a quantum circuit. The circuit has two horizontal lines representing
// qubits, with the top line labeled |0and the bottom line labeled |ψ0. There are two vertical boxes, Π, one on
// each qubit line, connected by a controlled rotation gate exp(−iϕZ) on the top line. The boxes represent
// projection operators Π. The gate is a controlled phase shift gate with a phase factor of exp(−iϕZ). The trend
// or message is that this circuit realizes a projector-controlled phase shift, also termed the "phased iterate".
#figure(image("imgs/fig_phased_iterate.png", width: 80%),
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

$ U_(arrow(phi.alt)) & = & ⊕_lambda [product_(k = 1)^(d / 2) e^(i phi.alt_(2 k - 1) Z) R ( lambda ) e^(i phi.alt_(2 k) Z) R ( lambda )] , $<eq:sigproc_tran_a>

recognizing that we have chosen conventions for $R ( lambda )$ in @eq:uham_bloch_spheres such that $R^dagger ( lambda ) = R ( lambda )$. This allows us to relabel the sum and the phases to put @eq:sigproc_tran_a into a standard form of quantum signal processing (similar to how we obtained @eq:sigproc_tran_a):

$ U_(arrow(phi.alt)) & = & ⊕_lambda [e^(i phi.alt'_0 Z) product_(k = 1)^d W ( lambda ) e^(i phi.alt'_k Z)] thin . $<eq:sigproc_tran_b>

By @thm:qsp, the term in brackets is a matrix of polynomials in $lambda$, verifying @thm:qsp. Finally, although we have specialized to the specific block encoding of @eq:U_block_encoding, the proof for more general block encodings is contained in~@Gily_n_2019 @Low_2019.

One immediately apparent utility of this eigenvalue transformation theorem is its usefulness in filtering eigenvalues. For example, we saw previously in Section~#ref(<sec:qsp>, supplement: none) that the BB1 sequence of phases can be used to increase sensitivity to the signal. In this eigenvalue transformation scenario, the signal is the eigenvalue $lambda$, and a sequence of QSP phases can be used to selectively filter a range of eigenvalues, e.g. those below a threshold of $lambda approx 2 pi / 3$ in the case of BB1 (for now this is an imprecise statement, but a similar question is a major concern of Section~#ref(<sec:Threshold>, supplement: none)). Measuring the projector $Pi$ will show that the QSP sequence flips the index qubit with higher probability if the Hamiltonian has an eigenvalue larger than this threshold, versus when all the eigenvalues of $cal(H)$ are below the threshold. This result also assumes the ability to prepare a state which has some overlap with the relevant eigenstates of $cal(H)$, as input into $U$, but the specific amplitudes of the overlap are not crucial, because amplitude amplification can be employed to boost the signal.

== Quantum Singular Value Transforms
<sec:qsvt>

@thm:eigenvalue_transform is known as the eigenvalue transformation because it accomplishes a polynomial transform of the eigenvalues of a matrix embedded within a larger unitary matrix. However, in general the embedded matrix need not have a well defined set of eigenvalues; for example, instead of being a square matrix, it could be rectangular. Remarkably, the same idea of transforming the embedded matrix using quantum signal processing can still apply. Specifically, we now show that QSP sequences can be used to polynomially transform all the #emph[singular values] of a (possibly non-square) matrix $A$ which has been encoded into a block of a unitary matrix $U$.

Such a general matrix $A$ can be decomposed as

$ A = W_Sigma Sigma V_Sigma^dagger thin , $

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

with the location of $A$ determined by projectors $Pi$ and $tilde(Pi)$, and given the ability to perform $Pi$- and $tilde(Pi)$-controlled not operations to realize projector controlled phase shift operations $Pi_phi.alt$ and $tilde(Pi)_phi.alt$ (defined as in Sec.~#ref(<sec:eigenvalue_transforms>, supplement: none)), then, for odd $d$,

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
#figure(image("imgs/fig_controlled_op.png", width: 70%),
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
// by an equivalence symbol , indicating that the quantum circuits represented in panels (a) and (b) are
// equivalent. This means that the controlled operation involving swap gates and operator A in panel (a) can be
// transformed into the configuration in panel (b), where A is applied conditionally as indicated.
#figure(image("imgs/fig_swap_controlled.png", width: 100%),
  caption: [
    Construction of $| 1 chevron.r$-controlled-$A$ (for $A$ a single qubit operator) given access to $| lambda chevron.r$ a $( + 1 )$-eigenvector of $A$, $| xi chevron.r$ the control qubit, and $| psi chevron.r$ the target state. Note that $A$ may in general act on a large Hilbert space, in which case the controlled swap operator is suitably generalized. The swaps can be made $| 0 chevron.r$-controlled to emulate @fig:block_encoded_A. We note that this is a similar construction to the circuits employed in @Huggins_2020 for matrix element measurement.
  ]
)
<fig:swap_controlled_A>

When $A$ is a large operator, it can be challenging to envision how a controlled-$A$ operation may be physically realized. In particular, given $A$, how to construct a controlled-$A$ operation is generally not possible without further information. For example, if a $+ 1$ eigenstate $| lambda med$ of $A$ is provided, then a controlled-$A$ quantum circuit can be constructed using $| lambda med$ together with two controlled-SWAP gates; see @fig:swap_controlled_A. However, in general, much more work has to be done in achieving a block encoding, generally in ways specific to the relevant physical system @Gily_n_2019 @Huggins_2020.

Related to the issue of the block encoding is accessing the desired polynomial transform of the encoded block. As described in Section~#ref(<sec:qsp>, supplement: none), after performing a QSP/QSVT sequence, a measurement may be done in the signal basis to determine if the desired polynomial transform was realized. In particular, in many of the algorithms, we wish to apply the transformed operator, $upright("Poly")^(( upright("SV") )) ( A )$, to some state $| psi chevron.r$, which may be done using the block encoding, $U_(arrow(phi.alt))$. However, this computation will only be successful if we apply to $| psi chevron.r$ the correct block (the one that encodes $upright("Poly")^(( upright("SV") )) ( A )$), so we must project the final state into being in this block by performing a projective measurement with the projectors $Pi$ and $tilde(Pi)$, which are assumed accessible. Consequently, the relevant projector for single-auxiliary-qubit QSVT is often $| + chevron.r chevron.l + | ⊗ Pi$, which both (1) isolates the real part of the transforming polynomial $P$ discussed in Section~#ref(<sec:qsp>, supplement: none), and (2) determines if we have applied the desired block of the overall unitary. Since this projective measurement is a one time projection that is done at the end of the algorithm, its cost is not large, and moreover, the probability of the projective measurement yielding the desired state can be amplified using amplitude amplification or classical repetition. Depending on the construction, this probability can also be either the desired output, or an algorithmically useful output. For more about the signal basis and QSP conventions, see Appendix~@sec:QSPConventions.

= SEARCH BY QSVT
<sec:Search>

Now that we have an overall perspective on the basic theorems of quantum signal processing and quantum singular value transformations, let us return to explicitly constructing the three "primordial" quantum algorithms using QSVT. Specifically, for each algorithm we indicate (a) the signal rotation operator, and (b) the appropriate QSP polynomial. This is not just a problem of reconstruction, but will in certain cases lead to slight improvements in algorithmic performance. We begin with the search algorithm.

A ubiquitous problem that admits a quantum speedup is unstructured search, the goal of which is to determine a single marked element $m in ( 0 , 1 , dots.h.c , N - 1 ) = : [ N ]$ from an unstructured database of size $N$. While the search problem can be solved in $cal(O) ( N )$ time classically, Grover's quantum algorithm requires only $cal(O) ( sqrt(N) )$ time, providing a provably optimal quadratic speedup. However, Grover's algorithm in its traditionally stated form suffers various shortcomings, including divergence from the proper solution if its underlying iterate is repeated too many times. Fortunately, by the parallels between this problem and amplitude amplification as discussed in Section~#ref(<sec:AA_and_search>, supplement: none), it is straightforward to recover an improved version of unstructured search using QSVT.

In quantum search, one is given access to a unitary operation $U$ whose application flags some marked element by a phase flip, i.e., $ U | j chevron.r = ( - 1 )^(delta_(j m)) | j chevron.r = cases(
    | j chevron.r & | j chevron.r eq.not | m chevron.r,
    - | j chevron.r & | j chevron.r = | m chevron.r
  ) $<eq:oracle_action> where $m in ( 0 , 1 , dots.h.c , N - 1 )$ is the (single) marked element.

As is conventional in quantum search, we will take our initial state to be the uniform superposition over all $N$ states, which may be expressed as

$ | psi_0 chevron.r = 1 / sqrt(N) sum_j^N | j chevron.r = sqrt(frac(N - 1, N)) thin | m^perp chevron.r + 1 / sqrt(N) thin | m chevron.r , $<eq:initial_state>

and is easily prepared by applying $n$ Hadamards to $| 0 chevron.r^(⊗ n)$. With this choice of initialization, our goal is to map $| psi_0 chevron.r$ to the marked state $| m chevron.r$.

In this context, how might we solve the search problem with QSVT? The standard method, which includes the construction of the Grover iterate, will not be necessary. Instead, we rephrase the problem. In the most general setting, we are given access to some initial state $| psi_0 chevron.r$ such that its projection onto the desired final state $| m chevron.r$ is nonzero. Denoting this projection by $Pi$, we may express this condition as

$ Pi thin V | psi_0 chevron.r = a | m chevron.r , $

for some known unitary $V$ and $| a | > 0$. In our case, as illustrated in @eq:initial_state, we can simply take $V$ as the identity, and $a = 1 / sqrt(N)$ by our choice of initial state. In general for amplitude amplification problems, $V$ need not be trivial, and is often viewed as a preparation oracle.

The search problem as framed above is precisely the statement of amplitude amplification as in Sec.~#ref(<sec:AA_and_search>, supplement: none), as we desire a circuit $U'$ (which will depend on $U$) such that

$ ∥ thin | m chevron.r chevron.l m | U' | psi_0 chevron.r chevron.l psi_0 | - | m chevron.r chevron.l psi_0 | thin ∥ < epsilon.alt , $<eq:amplitude_amplification>

for some small $epsilon.alt > 0$. For notational convenience we will refer to $| psi_0 chevron.r chevron.l psi_0 |$ as $Pi'$. Note that this induces a block encoding of the scalar $a$, that is

$ Pi thin V thin Pi' = Pi thin Pi' = a | m chevron.r chevron.l psi_0 | . $<eq:search_block_encoding>

We now have a problem goal stated in @eq:amplitude_amplification, and a block encoding of a single singular value $a = 1 / sqrt(N)$ stated in @eq:search_block_encoding. What remains to solve unstructured search with QSVT is a choice of QSVT polynomial, and an analysis of the minimum required QSVT sequence length.

Fortunately, given that there is only one relevant singular value, $a$, and one relevant left (and right) singular vector, the entire problem is reduced to mapping $a$ as close to $1$ in magnitude as possible, as under this condition the circuit will induce, with high probability, the desired block-encoded map $| m chevron.r chevron.l psi_0 |$. Luckily, there already exists a theorem which defines the conditions under which such transformations are possible: the major theorem of QSVT!

The requirements to perform QSVT as desired include the application of $V$, $V^dagger$, $C_Pi upright("NOT")$, $C_(Pi') upright("NOT")$, and $e^(- i phi.alt Z)$ gates. Note that here we have been allowed to choose $V = I$, as all Grover oracle information is encoded in the projector-controlled-NOTs. Moreover, these projector-controlled operators are easy to construct, $C_(Pi') upright("NOT")$ because $Pi'$ depends on a fixed, known state. Similarly, $C_Pi upright("NOT")$ may be crafted by first creating a controlled-$U$, which is easily achieved, and conjugating the control qubit by Hadamard gates, the result of which is a $C_Pi upright("NOT")$, where the control qubit now becomes the target of the projector-controlled-NOT.

Having now achieved a suitable block encoding and the necessary conditions for QSVT, we need only choose an appropriate QSVT polynomial. As our goal is to map $a$ to a value close to $1$, a sensible choice for such a polynomial can be derived if we start with the simple sign function $Theta ( x - c )$: $ Theta ( x - c ) = cases(
    - 1 & x < c,
    0 & x = c,
    1 & x > c ,
  ) $<eq:sign_function> As discussed in~@low2017quantum @Gily_n_2019, one can estimate the sign function with arbitrary precision by finding a polynomial approximation to $upright("erf") ( k [ x - c ] )$ for large enough $k$. In particular, one can efficiently compute a degree $cal(O) (1 / Delta log ( 1 / epsilon.alt ))$ odd polynomial $P_(epsilon.alt , Delta)^Theta ( x - c )$, where $epsilon.alt in paren.l 0 , sqrt(2 / e pi) bracket.r$, such that

+ $| P_(epsilon.alt , Delta)^Theta ( x - c ) | lt.eq 1 upright(" for ") x in [ - 1 , 1 ]$.

+ $| Theta ( x - c ) - P_(epsilon.alt , Delta)^Theta ( x - c ) | lt.eq epsilon.alt$ \
  for $x in [ - 1 , 1 ] without (c - Delta / 2 , med c + Delta / 2)$.

That is, $P_(epsilon.alt , Delta)^Theta ( x - c )$ is bounded in magnitude by $1$ and $epsilon.alt$-approximates the sign function outside of the region $(c - Delta / 2 , med c + Delta / 2)$. On the other hand, within the range $(c - Delta / 2 , med c + Delta / 2)$, where $Theta ( x - c )$ suffers a discontinuity, $P_(epsilon.alt , Delta)^Theta ( x - c )$ is not in general a good approximation to the sign function. In this region, $P_(epsilon.alt , Delta)^Theta ( x - c )$ is actually an $epsilon.alt$-approximation to $upright("erf") ( k [ x - c ] )$ where $k = sqrt(2) / Delta log^(1 / 2) (2 / [ pi epsilon.alt^2 ])$ (see~@low2017quantum for the explicit construction of $P_(epsilon.alt , Delta)^Theta ( x - c )$). For visual intuition, we illustrate this polynomial approximation below in @fig:SignFunctionApproximation.

// [figvision] imgs/fig_basic_sign_function.png
// Panel a: This is a plot. The x-axis ranges from -1 to 1, and the y-axis ranges from -1 to 1. There are two
// series: the "Ideal function" in solid black and the "Poly. approx." in dashed grey. The ideal function is a
// step function that jumps from 0 to 1 at x=0. The polynomial approximation oscillates around the ideal function
// outside the region [-Δ/2, Δ/2] and deviates from it within this region. The trend shows that the polynomial
// approximation stays within ε of the sign function outside the region [-Δ/2, Δ/2].
#figure(image("imgs/fig_basic_sign_function.png", width: 100%),
  caption: [
    An illustration of $Theta ( x )$ (solid) and its polynomial approximation, $P_(epsilon.alt , Delta)^Theta ( x )$ (dashed). Note how $P_(epsilon.alt , Delta)^Theta ( x )$ stays within $epsilon.alt$ of the sign function outside of the region $(Delta / 2 , med Delta / 2)$, while deviating from $Theta ( x )$ within this region. The shifted version of this function is constructed much the same way.
  ]
)
<fig:SignFunctionApproximation>

Note that the polynomial $P_(epsilon.alt , Delta)^Theta ( x )$ (i.e., with $c = 0$) has odd parity and is bounded in magnitude by $1$, and so it may be implemented via QSVT (i.e. it obeys the conditions on Poly($a$)$= chevron.l m | U_(arrow(phi.alt)) | psi_0 chevron.r$ discussed in Section~#ref(<sec:qsp>, supplement: none) and Appendix~@sec:QSPConventions). We will use this scheme to polynomially approximate the sign function, e.g., $Theta^(( upright("SV") )) ( V ) approx ( P_(epsilon.alt , Delta)^Theta )^(( upright("SV") )) ( V )$, and subsequently apply it to the initial uniform superposition over $N$ quantum states. Then, upon applying the pre-determined QSVT sequence, this yields $| m chevron.r$ in the register with probability $p = | P_(epsilon.alt , Delta)^Theta ( a ) |^2$.

We can now ask which values of $Delta$ and $epsilon.alt$ should we choose for our intended behavior? Because we desire that $a = 1 / sqrt(N)$ be mapped to a value greater than $1 - epsilon.alt$, we require that $1 / sqrt(N) gt.eq Delta / 2$, or equivalently $Delta = cal(O) ( 1 / sqrt(N) )$. Next, note that upon applying $( P_(epsilon.alt , Delta)^Theta )^(( upright("SV") )) ( V )$ to the uniform superposition, the amplitude of the desired state, $| m chevron.r$, is at least $1 - epsilon.alt$. Thus, upon measuring these qubits in the computational basis, the probability of the resultant state being $| m chevron.r$ is at least $( 1 - epsilon.alt )^2 gt.eq 1 - 2 epsilon.alt$. Therefore, if we want this procedure to succeed with probability at least $1 - delta$, we set $epsilon.alt = delta / 2$.

Under these choices, the polynomial $P_(epsilon.alt , Delta)^Theta ( x )$ is of degree $d = cal(O) (1 / Delta log ( 1 / epsilon.alt )) = cal(O) ( sqrt(N) log ( 1 / delta ) )$, such that the runtime of this algorithm is $cal(O) ( sqrt(N) log ( 1 / delta ) )$. Note that we again have $cal(O) ( sqrt(N) )$ scaling and thus maintain the quadratic speedup for the search problem, while circumventing Grover search's convergence issues. We summarize this algorithm for search by QSVT in @alg:UnstructuredSearchQSVT.

Finally, we remark that this algorithm employs a simple block encoding (i.e. the identity) of $a = 1 / sqrt(N)$ with nontrivial singular vectors (i.e. $| psi_0 chevron.r$ and $| m chevron.r )$. In this setting, our desired transformation would not have been possible had we used the quantum eigenvalue transformation of Sec.~#ref(<sec:eigenvalue_transforms>, supplement: none), as the eigenvalues of $V$ are necessarily $1$ and the input and output spaces identical. Hence, this instance illustrates the advantage of QSVT over the quantum eigenvalue transformation, as QSVT can achieve polynomial transformations between different input and output spaces.

#algbox([Unstructured Search by QSVT], [
*Input:* Access to a controlled version of the oracle $U$ which bit-flips an auxiliary qubit when given an unknown target state $| m chevron.r in { | j chevron.r, j in [N] }$ and acts trivially otherwise, an error tolerance $delta$, and a $Delta lt.eq 2 / sqrt(N)$.

*Output:* The flagged state $| m chevron.r$.

*Runtime:* $cal(O) ( sqrt(N) log ( 1 / delta ) )$ queries to controlled-$U$, equivalently $C_Pi upright("NOT")$, $C_(Pi') upright("NOT")$, and $e^(- i phi Z)$ gates and a single auxiliary qubit. Succeeds with probability at least $1 - delta$.

*Procedure:*
#enum(
  [Use QSVT to construct the operator $( P_(delta / 2 , Delta)^Theta )^(( upright("SV") )) ( V )$, where $V = I$ block encodes $a = 1 / sqrt(N)$ in its $| m chevron.r chevron.l psi_0 |$ element.],
  [Apply $( P_(delta / 2 , Delta)^Theta )^(( upright("SV") )) ( V )$ to the uniform superposition. With high probability, $| m chevron.r$ remains in the register and can be determined by measuring in the computational basis.],
)
]) <alg:UnstructuredSearchQSVT>


= THE EIGENVALUE THRESHOLD PROBLEM BY QSVT
<sec:Threshold>
Beyond the determination of a desired state, as was the object in unstructured search covered in @alg:UnstructuredSearchQSVT in Section~#ref(<sec:Search>, supplement: none), a separate major intent of many quantum algorithms is determining whether a certain property holds of a given quantum system. Through the lens of QSVT, we show in this section that these two algorithmic goals are similar: here, rather than wishing to prepare a special state (e.g., the marked state for unstructured search), we now wish to encode some underlying unknown information about a quantum system simply into a state which we can then measure.

This linkage between search and property testing is made apparent by considering the #emph[eigenvalue threshold problem]. In the setup of this problem, we are given access to a Hamiltonian $cal(H)$ and would like to determine if $cal(H)$ has any eigenvalues $lambda$ that are less than some chosen threshold $lambda_(upright("th"))$. Realistically, this must be determined to within some precision $Delta_lambda$, so we are guaranteed that either the Hamiltonian has at least one eigenvalue $lambda lt.eq lambda_(upright("th")) - Delta_lambda$ or that all of its eigenvalues obey $lambda gt.eq lambda_(upright("th")) + Delta_lambda$. The eigenvalue threshold problem seeks to distinguish these cases.

To solve this problem, one is also provided a state $| psi chevron.r$ that has reasonable overlap with the low-energy subspace (spanned by the eigenvectors with eigenvalues $lambda lt.eq lambda_(upright("th")) - Delta_lambda$) #emph[if it exists]. Mathematically, we represent this condition as

$ parallel Pi_(lt.eq lambda_(upright("th")) - Delta_lambda) | psi chevron.r parallel gt.eq zeta = Omega ( 1 ) , $

where $Pi_(lt.eq lambda_(upright("th")) - Delta_lambda)$ is a projector onto the (possibly non-existent) low-eigenvalue subspace mentioned above.

To solve this problem with QSVT, we will need to construct a block encoding of the Hamiltonian $cal(H)$. However, such a block encoding can only be constructed if $parallel cal(H) parallel lt.eq 1$, so we instead must determine an $alpha gt.eq parallel cal(H) parallel$ and construct a unitary block encoding of $cal(H) / alpha$. In general, doing so may be nontrivial because determining such an $alpha$ requires prior knowledge about $cal(H)$. We discuss this drawback in Sec.~#ref(<sec:Discussion>, supplement: none). Fortunately however, for a large class of Hamiltonians, such as sparse Hamiltonians and linear combinations of unitaries, one can determine a sufficient $alpha$ and construct a block encoding of $cal(H) / alpha$~@Low_2019 @Gily_n_2019. With this rescaled block encoding, one can equivalently imagine that our goal is to determine if $cal(H) / alpha$ has any eigenvalues less than $lambda_(upright("th")) / alpha$ to within a precision $Delta_lambda / alpha$.

Moreover, as the eigenvalue threshold problem deals with eigenvalues, it is most straightforwardly approached with a quantum eigenvalue transform. However, in accordance with the theme of this paper, we may equivalently solve this problem with QSVT if the eigenvalues of $cal(H)$ are positive, such that the singular values are equal to the eigenvalues. If this is not the case, we may instead use the block encoding of $cal(H) / alpha$ and the circuit in @fig:H_PosDef_BlockEncodingCircuit to construct a block encoding of the positive definite matrix $1 / 2 (cal(H) / alpha + I)$. Under this modification, the new goal would be to determine if $1 / 2 (cal(H) / alpha + I)$ has eigenvalues less than $1 / 2 (lambda_(upright("th")) / alpha + 1)$ to within a precision $Delta_lambda / alpha$, which may be achieved with QSVT. In the remainder of this section, we will assume that this issue has been alleviated and specialize to the case of distinguishing the threshold $lambda_(upright("th")) / alpha$.

// [figvision] imgs/fig_hamiltonian_block_encoding.png
// Panel a is not present, the figure has a single panel. The figure is a schematic diagram of a simple circuit
// for block encoding. It consists of a horizontal line with two boxes labelled "H" on it, one on the left and
// one on the right, connected by a vertical line with a dot in the middle. Below this line is a larger box with
// the text "/α" inside, and two horizontal lines on either side with three dots on each line. The boxes labelled
// "H" have a double-line border and are connected to the central box with a solid line. The central box has a
// single-line border and contains the text "/α". The trend or message is to show the layout of a quantum
// circuit.
#figure(image("imgs/fig_hamiltonian_block_encoding.png", width: 55%),
  caption: [
    A simple circuit for block encoding $1 / 2 (cal(H) / alpha + I)$, the projectors for which are, following QSVT conventions, $| 0 chevron.r chevron.l 0 | ⊗ Pi$ and $| 0 chevron.r chevron.l 0 | ⊗ tilde(Pi)$.
  ]
)
<fig:H_PosDef_BlockEncodingCircuit>

With those concerns out of the way, how might this problem be solved with QSVT? A fruitful approach, which we will follow, is to apply QSVT to the Hamiltonian with a function that filters out large eigenvalues. While one might suspect that we need a function that locates eigenvalues below the threshold $lambda_(upright("th")) / alpha$, such as the eigenstate filtering function of~@Lin_2020, we can actually employ a much simpler construction. All we need is a function that behaves markedly different on eigenvalues greater than and less than $lambda_(upright("th")) / alpha$, and such a function may be constructed using the technology from Section~#ref(<sec:Search>, supplement: none).

A good choice for such a function is $Theta ( lambda_(upright("th")) / alpha - x )$, which maps eigenvalues less than $lambda_(upright("th")) / alpha$ to $1$ and larger eigenvalues to $- 1$. One could imagine approximating this function by $P_(epsilon.alt , Delta)^Theta ( lambda_(upright("th")) / alpha - x )$, but there is a catch: this polynomial does not have definite parity and thus does not satisfy the constraints of @thm:qsp. Instead, we need to consider a symmetrized version with even parity, the #emph[eigenvalue threshold polynomial]:

$ P & ""_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( x ) :=\
 & frac(1, 1 + epsilon.alt / 4) (- 1 + epsilon.alt / 4 + P_(epsilon.alt / 2 , Delta)^Theta (lambda_(upright("th")) / alpha - x) + P_(epsilon.alt / 2 , Delta)^Theta (lambda_(upright("th")) / alpha + x)) $

The factors of $epsilon.alt / 4$ ensure that $P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( x )$ has the following desired properties, which are easily seen via the triangle inequality:

+ $| P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( x ) | lt.eq 1 upright(" for ") x in [ 0 , 1 ]$.

+ $| Theta ( lambda_(upright("th")) / alpha - x ) - P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( x ) | lt.eq epsilon.alt$ \
  for $x in [ 0 , 1 ] without (lambda_(upright("th")) / alpha - Delta / 2 , med lambda_(upright("th")) / alpha + Delta / 2)$.

So, $P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( x )$ behaves as $P_(epsilon.alt , Delta)^Theta ( lambda_(upright("th")) / alpha - x )$ for $x gt.eq 0$ (the only relevant range for singular values). In addition, $P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( x )$ has definite parity and magnitude bounded by $1$, so it may be implemented through QSVT (again, it obeys the conditions on Poly($a$)$= chevron.l + | U_(arrow(phi.alt)) | + chevron.r$ discussed in Section~#ref(<sec:qsp>, supplement: none) and Appendix~@sec:QSPConventions). Thus, this polynomial may be used to distinguish between eigenvalues less than $lambda_(upright("th")) / alpha - Delta / 2$ and greater than $lambda_(upright("th")) / alpha + Delta / 2$, which naturally indicates a precision $Delta_lambda / alpha = Delta / 2$.

To see how we may employ this technology, note that we may express $| psi chevron.r$ in the eigenbasis as

$ | psi chevron.r = sum_lambda c_lambda | lambda chevron.r = sum_(lambda lt.eq lambda_(upright("th"))) c_lambda | lambda chevron.r + sum_(lambda > lambda_(upright("th"))) c_lambda | lambda chevron.r , $

where $sum_(lambda lt.eq lambda_(upright("th"))) | c_lambda |^2 gt.eq zeta^2$ by the guarantee mentioned above. Next, consider using QSVT to develop $( P_(epsilon.alt , Delta)^(upright("ET")) )^(( upright("SV") )) ( cal(H) / alpha )$ and apply it to $| psi chevron.r$ controlled by an ancilla qubit in the state $| + chevron.r$, as in the circuit of @fig:ThresholdMeasurementCircuit. After applying a Hadamard to this ancilla qubit, the final (unnormalized) state of the system is

$ 1 / 2 ( | 0 chevron.r sum_lambda & c_lambda ( 1 + P_(epsilon.alt , Delta)^(upright("ET")) ( lambda ) ) | lambda chevron.r\
 & + | 1 chevron.r sum_lambda c_lambda ( 1 - P_(epsilon.alt , Delta)^(upright("ET")) ( lambda ) ) | lambda chevron.r ) . $

// [figvision] imgs/fig_theta_block_encoding.png
// The figure shows a schematic diagram of a quantum circuit. a. The top line represents a qubit in state |0⟩,
// and the bottom line represents another qubit in state |ψ⟩. The objects on the top line, from left to right,
// are: a Hadamard gate (H), a controlled-operation symbol (dot), another Hadamard gate (H), and a measurement
// gate (symbol: a circle with a cross). The bottom line has a large rectangle enclosing it, labeled Θ(λth/α -
// x), with three dots on either side indicating continuation. The trend or message is that this circuit can be
// used to solve the eigenvalue threshold problem with high probability upon measuring the auxiliary qubit. b.
// There is no panel b. c. There is no panel c. d. There is no panel d. e. There is no panel e. The objects and
// their connections are as follows: the top qubit line connects the gates in sequence; the bottom qubit line
// passes through the large rectangle. The rectangle's label suggests a dependence on threshold eigenvalue λth, a
// parameter α, and a variable x.
#figure(image("imgs/fig_theta_block_encoding.png", width: 70%),
  caption: [
    The circuit which, upon measuring the auxiliary qubit, can be used to solve the eigenvalue threshold problem with high probability as in @alg:EigenvalueThresholdQSVT.
  ]
)
<fig:ThresholdMeasurementCircuit>

We can solve the eigenvalue threshold problem by measuring the ancilla qubit in the computational basis. Observe that the probability of measuring the ancilla qubit in $| 0 chevron.r$ is

$ p ( 0 ) = 1 / 2 frac(sum | c_lambda |^2 ( 1 + P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( lambda ) )^2, sum | c_lambda |^2 ( 1 + ( P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( lambda ) )^2 )) $

If all eigenvalues obey $lambda > lambda_(upright("th")) + Delta_lambda$, then $- 1 lt.eq P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( lambda ) lt.eq - 1 + epsilon.alt$, and so

$ p ( 0 | med lambda > lambda_(upright("th")) + Delta_lambda ) lt.eq frac(epsilon.alt^2, 2 ( 1 + ( - 1 + epsilon.alt )^2 )) lt.eq 1 / 2 epsilon.alt^2 . $

This implies that it is unlikely to measure $| 0 chevron.r$ if all eigenvalues obey $lambda > lambda_(upright("th")) + Delta_lambda$. On the other hand, if there exists an eigenvalue that obeys $lambda < lambda_(upright("th")) - Delta_lambda$, then $1 - epsilon.alt lt.eq P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( lambda < lambda_(upright("th")) - Delta_lambda ) lt.eq 1$ and $- 1 lt.eq P_(epsilon.alt , Delta , lambda_(upright("th")) / alpha)^(upright("ET")) ( lambda > lambda_(upright("th")) + Delta_lambda ) lt.eq - 1 + epsilon.alt$, which implies that

$ p ( 0 | med exists lambda < lambda_(upright("th")) - Delta_lambda ) gt.eq frac(zeta^2 ( 2 - epsilon.alt )^2, 2 ( 1 + 1 )) gt.eq zeta^2 ( 1 - epsilon.alt ) . $

This indicates that, for reasonably sized $zeta$, we are more likely to measure $| 0 chevron.r$ if there exists an eigenvalue $lambda < lambda_(upright("th")) - Delta_lambda$.

With this construction, the eigenvalue threshold problem is reduced to distinguishing between two Bernoulli distributions: one with mean $lt.eq 1 / 2 epsilon.alt^2$ and one with mean $gt.eq zeta^2 ( 1 - epsilon.alt )$. To ensure that these means are well separated, we desire $zeta^2 ( 1 - epsilon.alt ) > 1 / 2 epsilon.alt^2$. Since $epsilon.alt lt.eq sqrt(2 / e pi) approx 0.48$ by the construction of $P_(epsilon.alt , Delta)^Theta ( x )$ in~@low2017quantum, this may be enforced by choosing an $epsilon.alt < zeta$ (i.e. $epsilon.alt = cal(O) ( zeta )$); for instance, $epsilon.alt = 1 / 4 zeta$ is a sufficient choice, which we will make use of in the following. We may then distinguish between these distributions with high probability by performing repeated measurements. This is quantified by the following lemma:

#thmbox("theorem", "Lemma")[

Suppose we have two Bernoulli distributions $X_0 , X_1$ which return elements in $ {0, 1} $ and have expected values $0 lt.eq a < b lt.eq 1$ respectively. Given a distribution $X$ that is either $X_0$ or $X_1$, we may determine $X$'s identity with confidence greater than $1 - delta$ for $delta > 0$ with $cal(O) (frac(b + a, ( b - a )^2) log ( 1 / delta ))$ samples of $X$.

#block[
#emph[Proof.] To distinguish between these distributions, let us take $n$ samples $X_i$, and guess that $X$ is the distribution whose mean is closest to the empirical mean of the samples. Suppose that $X = X_0$ and thus has mean $a$ (the case $X = X_1$ may be treated analogously). We're interested in computing the probability of mistaking this distribution for $X_1$, namely

$ P ( upright("error") ) &= P (sum_(i = 1)^n X_i gt.eq n ( a + b ) / 2)   &= P (sum_(i = 1)^n X_i gt.eq n [ a + ( b - a ) / 2 ]) . $

To bound this error probability, we may invoke the well-known multiplicative Chernoff bound, with mean $mu = bb(E) ( sum_(i = 1)^n X_i ) = n a$ and relative difference from the mean $epsilon$,

$ mu + n ( b - a ) / 2 = mu ( 1 + epsilon ) #h(0em) arrow.r.double.long #h(0em) epsilon = frac(b - a, 2 a) . $

Employing the multiplicative Chernoff bound, we may ensure that the error probability be less than some chosen $delta$ as

$ P (sum_(i = 1)^n X_i gt.eq n a ( 1 + epsilon )) lt.eq e^(- epsilon^2 n a / 3) lt.eq delta , $

which in turn requires $n gt.eq ( 3 / a epsilon^2 ) log ( 1 / delta )$, or equivalently, $n gt.eq frac(12 a, ( b - a )^2) log ( 1 / delta ) = cal(O) ( frac(a, ( b - a )^2) log ( 1 / delta ) )$.

Performing a similar calculation for the hypothesis $X = X_1$ yields $n = cal(O) ( frac(b, ( b - a )^2) log ( 1 / delta ) )$. Summing these results over equal priors over $X in ( X_0 , X_1 )$ provides the scaling $n gt.eq frac(6 ( a + b ), ( b - a )^2) log ( 1 / delta ) = cal(O) ( frac(a + b, ( b - a )^2) log ( 1 / delta ) )$, as claimed in the lemma statement.~◻

]
] <lemma:multiplicative_chernoff_bound>

Applying this lemma to our scenario in the eigenvalue threshold problem, we have $frac(1, b - a) lt.eq frac(1, zeta^2 ( 1 - epsilon.alt ) - epsilon.alt^2 / 2) = cal(O) ( 1 / zeta^2 )$. For instance, with our choice $epsilon.alt = zeta / 4$, we have $frac(1, b - a) < frac(3, 2 zeta^2)$. We then have $frac(a + b, ( b - a )^2) = frac(( b - a ) + 2 a, ( b - a )^2) = cal(O) ( 1 / zeta^2 + zeta^2 / zeta^4 ) = cal(O) ( 1 / zeta^2 )$. Therefore, if we repeat the aforementioned measurement procedure $cal(O) (1 / zeta^2 log ( 1 / delta ))$ times, we can correctly distinguish between the two distributions and solve the eigenvalue threshold problem with probability at least $1 - delta$. As each repetition performs QSVT with a polynomial of degree $cal(O) (1 / Delta log ( 1 / epsilon.alt )) = cal(O) (alpha / Delta_lambda log ( 1 / zeta ))$, this overall algorithm queries the Hamiltonian $cal(O) (frac(alpha, Delta_lambda zeta^2) log ( 1 / zeta ) log ( 1 / delta ))$ times. For consistency, we note that this $1 / zeta^2$ dependence is suboptimal, and can be improved to $1 / zeta$ using Lemma 7 of #cite(<Lin_2020_2>). We summarize the eigenvalue threshold problem by QSVT in @alg:EigenvalueThresholdQSVT. Here, we note that the upper limit on the index of the for loop comes from the condition $n gt.eq frac(6 ( a + b ), ( b - a )^2) log ( 1 / delta )$ according to @lemma:multiplicative_chernoff_bound, with the choice $epsilon.alt = zeta / 4$.

#algbox([The Eigenvalue Threshold Problem by QSVT], [
*Input:* Access to a Hamiltonian, $cal(H)$, and an $alpha gt.eq parallel cal(H) parallel$.

*Output:* Whether $cal(H)$ has at least one eigenvalue $lambda lt.eq lambda_(upright("th")) - Delta_lambda$, or if all eigenvalues obey $lambda gt.eq lambda_(upright("th")) + Delta_lambda$.

*Runtime:* $cal(O) ( frac(alpha, Delta_lambda zeta^2) log ( 1 / zeta ) log ( 1 / delta ) )$ uses of a unitary block encoding of $cal(H) / alpha$ and its inverse, and $C_Pi upright("NOT")$, $C_(tilde(Pi)) upright("NOT")$ and single qubit phase gates. Succeeds with probability at least $1 - delta$.

*Procedure:*
#enum(
  [Prepare a unitary block encoding of $cal(H) / alpha$.],
  [*for* $i = 1$ *to* $ceil.l 315 / ( 32 zeta^2 ) log ( 1 / delta ) ceil.r$ *do*
    #enum(
      numbering: n => str(n + 2) + ".",
      [Use QSVT to apply $( P_(zeta / 4 , 2 Delta_lambda / alpha , lambda_(upright("th")) / alpha)^(upright("ET")) )^(( upright("SV") )) ( cal(H) / alpha )$ to $| psi chevron.r$, controlled by an ancilla qubit in the state $| + chevron.r$ (see @fig:ThresholdMeasurementCircuit).],
      [Apply a Hadamard to the ancilla qubit and measure it in the computational basis.],
    )
  ],
  [If the fraction of $| 0 chevron.r$'s measured is closer to $zeta^2 ( 1 - zeta / 4 )$ than to $zeta^2 / 32$, then there exists an eigenvalue $lambda lt.eq lambda_(upright("th")) - Delta_lambda$ with high probability. Otherwise, all eigenvalues obey $lambda gt.eq lambda_(upright("th")) + Delta_lambda$ with high probability.],
)
]) <alg:EigenvalueThresholdQSVT>


= PHASE ESTIMATION BY QSVT
<sec:PhaseEstimation>

Another salient problem that admits a quantum advantage is #emph[phase estimation], which is as follows: given access to a unitary oracle $U$ and an eigenvector $| u chevron.r$ such that $U | u chevron.r = e^(2 pi i phi) | u chevron.r$, determine $phi$. Here, we approach this problem by integrating a feedback procedure inspired by Kitaev's algorithm~@kitaev2002classical @kitaev1995quantum with the technology developed in solving the eigenvalue threshold problem in Sec.~#ref(<sec:Threshold>, supplement: none). We first provide a sketch of the algorithm, and then address a few caveats in its construction. Finally, we present a concrete formulation of QSVT-based phase estimation, analyze its capabilities, and demonstrate how the quantum Fourier transform naturally emerges from this construction.

== Intuition
<sec:PhaseEstimation_Motivation>
To motivate iterative phase estimation by QSVT, recall that Kitaev's algorithm for phase estimation~@kitaev2002classical @kitaev1995quantum may be reinterpreted as a semi-classical feedback process~@Parker_2000 @Monz_2016. One may view this feedback process as incorporating a classical parameter $theta in [ 0 , 1 ]$, initialized at $theta = 0$, such that through a series of controlled-$U^j$ calls and a single-qubit measurements, each of which updates $theta$, one obtains a value $theta approx phi$ at the end of the algorithm.

Our approach to phase estimation by QSVT is heavily inspired by this feedback procedure. Just as in Kitaev's algorithm, we introduce a parameter $theta in [ 0 , 1 ]$, initialized at $0$, that is updated throughout the algorithm and by the end of the procedure, the final value of $theta$ will approximate $phi$. We sketch our algorithm in the following section.

Before proceeding, we note that a very similar QSVT-based phase estimation algorithm was independently discovered in @rall2021faster. A primary goal of their work is maintaining coherence, and accordingly their paper presents a thorough performance analysis of their algorithm including the derivation of constant factors as well as precise use of the diamond norm. Ref.~@rall2021faster also extends their QSVT-based phase estimation algorithm to coherent energy and amplitude estimation.

=== Sketch of the Algorithm
<sec:PhaseEstimation_Sketch>
To understand our algorithm, let us use the binary fraction representation of $phi$ and assume that $phi$ is an $m$-bit number: $phi = 0 . phi_1 phi_2 . . . phi_m$ for some finite $m$ (in this representation, $phi = sum_j 2^(- j) phi_j$). We will show how to deal with the $m = oo$ case later.

In the QSVT phase estimation algorithm, $phi$ is determined bit by bit through a series of $m$ iterations, beginning with the least significant bit, $phi_m$, and proceeding down to the most significant bit, $phi_1$. In each iteration, we construct a matrix whose singular values encode the least significant bits of $phi$ as well as the current value of $theta$. By applying QSVT to this matrix, conditioned on an ancilla qubit, and subsequently measuring the ancilla qubit, we determine a single bit of $phi$ and update $theta$ accordingly. If each iteration succeeds, then $theta = phi$ at the end of the algorithm.

To see how this may be achieved, consider the matrix $A_j ( theta ) := 1 / 2 ( I + e^(- 2 pi i theta) U^(2^j) )$, which has a singular value

$ sigma^j := | cos ( pi ( 2^j phi - theta ) ) | , $<eq:singular_value_expression>

with corresponding right singular vector $| v^j chevron.r = | u chevron.r$ and left singular vector $| w^j chevron.r = e^(i pi ( 2^j phi - theta )) | u chevron.r$. Because $upright("exp") ( pi i 2^j phi ) = upright("exp") ( 2 pi i 2^(j - 1) 0 . phi_1 . . . phi_m ) = upright("exp") ( pi i 0 . phi_(j + 1) . . . phi_m )$, $sigma^j$ may be re-expressed as

$ sigma^j = | cos ( pi ( 0 . phi_(j + 1) phi_(j + 2) . . . phi_m - theta ) ) | . $<eq:singular_value_reexpression>

This singular value is used to extract the bits of $phi$ as follows. Consider the first iteration of the QSVT phase estimation algorithm, where we begin with $j = m - 1$ (and will decrement $j$ down to $j = 0$). Because $theta$ is initialized at $0$, the singular value of interest is $ sigma^(m - 1) = | cos ( pi ( 0 . phi_m ) ) | = cases(
    1 & phi_m = 0,
    0 & phi_m = 1 ,
  ) $<eq:s_m> from which $phi_m$ may be evaluated as $phi_m = 1 / 2 (1 + Theta (1 / sqrt(2) - sigma^(m - 1)))$. This expression provides a pathway to extract $phi_m$, akin to the procedure used in the eigenvalue threshold problem: apply QSVT to $A_(m - 1) ( theta )$ with the target function $Theta (1 / sqrt(2) - x)$#footnote[The sign function is discontinuous and cannot be implemented exactly through QSVT. We will deal with this caveat shortly, but for now we assume it can be implemented exactly.], and employ the circuit in @fig:PhaseEstimationCircuit_SingleIteration, the measurement result of which is $phi_m$. After measurement, we update $theta$ by setting the first bit of $theta$ to $theta_1 = phi_m$(again using the binary fraction representation $theta = 0 . theta_1 theta_2 . . .$), such that $theta = 0 . phi_m$, which completes the $j = m - 1$ iteration.

We then move to the next iteration, wherein we decrement $j = m - 1 arrow.l m - 2$, map $theta arrow.l theta / 2 = 0.0 phi_m$, and construct $A_j ( theta ) = A_(m - 2) ( 0.0 phi_m )$, which has singular value

$ sigma^(m - 2) & = | cos ( pi ( 0 . phi_(m - 1) phi_m - 0.0 phi_m ) ) |\
 & = | cos ( pi ( 0 . phi_(m - 1) ) ) | . $

Note that the updated value of $theta$ allowed for a convenient cancellation of $phi_m$. As this relation is identical to @eq:s_m, $phi_(m - 1)$ may be determined by employing the QSVT procedure mentioned above and again executing the circuit in Fig~#ref(<fig:PhaseEstimationCircuit_SingleIteration>, supplement: none). Upon obtaining the measurement result of this circuit, we set $theta_1 = phi_(m - 1)$.

It is clear that this procedure may be repeated to determine each bit of $phi$, such that at the end of the $j = 0$ iteration, one obtains $theta = phi$, which solves the phase estimation problem. Ultimately, this procedure succeeds because $theta$ encodes the least significant bits of $phi$, from which the next bit of $phi$ may be extracted by cleverly transforming the singular values of $A_j ( theta )$. Accordingly, this algorithm may be seen as a binary search through the bits of $phi$, a key idea that we return to in Section~#ref(<sec:EmergentQFT>, supplement: none).

At this stage however, one may object to this algorithm sketch as it requires $m$ iterations, and it could be the case that $m$ is unknown or prohibitively large. This is not an issue, as we prove in Appendix~@sec:PhaseEstimation_m_n_Proofs that if we start at $j = n - 1$ for some positive integer $n$, then we have (with a minor procedural modification needed for $n < m$):

#thmbox("theorem", "Theorem")[

If $n gt.eq m$, and one can exactly implement the sign function through QSVT, then at the end of this procedure, $theta = phi$.

] <thm:n_geq_m>

#thmbox("theorem", "Theorem")[

If $n < m$ (including the case $m = oo$), and one can exactly implement the sign function through QSVT, then at the end of this procedure, $| theta - phi | lt.eq 2^(- n - 1)$.

] <thm:n_l_m>

As evidenced by these theorems, which are easily proven by induction, this procedure necessarily outputs an $n$-bit approximation to $phi$ and is the essence of the algorithm for phase estimation by QSVT. However, in spite of the simple appearance of this algorithm, a few issues must be addressed before presenting its concrete formulation.

// [figvision] imgs/fig_sign_embedding.png
// The figure is a schematic diagram of a quantum circuit. ### Panel description The figure contains a single
// schematic diagram with no panels labeled (a, b, c…). The diagram shows a quantum circuit with two horizontal
// lines representing qubits, with the top line labeled |0⟩ and the bottom line labeled |u⟩. The top qubit line
// has three boxes connected in series: - The first box is labeled H and has a single input from the left and a
// single output to the right. - The second box is also labeled H with a dot below indicating a control line
// connected to the bottom qubit line. - The third box has a curved line inside and is labeled with a meter
// symbol and ϕ_{j+1} on the right side. The bottom qubit line has a large box spanning its width with Θ(1/√2 -
// A_j(θ)) inside and two vertical lines with dots on top and bottom indicating multiple connections. The trend
// or message is that this quantum circuit is used for phase estimation by QSVT procedure at each iteration.
#figure(image("imgs/fig_sign_embedding.png", width: 80%),
  caption: [
    The quantum circuit used to evaluate $phi_(j + 1)$ at each iteration of the phase estimation by QSVT procedure.
  ]
)
<fig:PhaseEstimationCircuit_SingleIteration>

=== Caveats
<sec:PhaseEstimation_Caveats>
Here we address a few caveats in the above algorithm sketch. First, as described thus far, this procedure applies QSVT to the matrix $A_j ( theta )$, which requires a unitary block encoding of $A_j ( theta )$. Fortunately, this encoding can be easily constructed as the circuit in @fig:A_j_BlockEncodingCircuit, which we denote by $W_j ( theta )$. A simple calculation of @fig:A_j_BlockEncodingCircuit indicates that $W_j ( theta )$ has the desired form:

$ W_j ( theta ) : & = 1 / 2 mat(delim: "(", I + e^(- 2 pi i theta) U^(2^j), I - e^(- 2 pi i theta) U^(2^j); I - e^(- 2 pi i theta) U^(2^j), I + e^(- 2 pi i theta) U^(2^j))\
 & = mat(delim: "(", A_j ( theta ), dot.op; dot.op, dot.op) , $<eq:A_j_BlockEncoding>

with corresponding projection operators $Pi = tilde(Pi) = | 0 chevron.r chevron.l 0 | ⊗ I$.

// [figvision] imgs/fig_block_encoding.png
// Panel a is not present, the figure has a single panel. The figure is a schematic diagram of a quantum circuit.
// It consists of horizontal lines representing qubits, with two rectangular boxes and a dot on a vertical line
// connecting them. The left box has an "H" inside, the right box also has an "H", and the central box contains
// "e^{-2 i} U^{2^j}". There are no axes shown. The horizontal lines have dots on the left and right indicating
// continuation. The trend or message is the layout of a quantum circuit with Hadamard gates and a controlled
// unitary operation.
#figure(image("imgs/fig_block_encoding.png", width: 50%),
  caption: [
    A quantum circuit that achieves a unitary block encoding of $A_j ( theta )$, which we denote by $W_j ( theta )$ and incorporate into @alg:PhaseEstimationByQSVT.
  ]
)
<fig:A_j_BlockEncodingCircuit>

Another concern with the aforementioned procedure is that the sign function, $Theta (1 / sqrt(2) - x)$, may seem over-complicated and unnecessary, as the same results could be attained with a simpler function, such as $1 - x$. However, the sign function is crucial when one desires merely an $n$-bit approximation to $phi$, which is necessary when $m$ is unknown or prohibitively large, as is often the case in practice. In this situation, the use of the sign function (the exact sign function, rather than an approximation) will ultimately set $theta$ equal to the $n$-bit number closest to $phi$. For example, if $0 . phi_m phi_(m + 1) . . . = 0.011 . . .$ at the first iteration, then despite the fact that $phi_m = 0$, the use of the sign function will set $theta_1 = 1$ because $0.1$ is the best 1-bit approximation to $0.011 . . .$.

Lastly, the most significant problem with this procedure as it currently stands is that the sign function is not a polynomial and therefore cannot be implemented exactly in QSVT. Instead, $Theta ( 1 / sqrt(2) - x )$ must be approximated by a polynomial, a good choice for which is $P_(epsilon.alt , Delta)^Theta ( 1 / sqrt(2) - x )$ from Sec.~#ref(<sec:Search>, supplement: none). However, as in Sec.~#ref(<sec:Threshold>, supplement: none), in order to ensure that the target polynomial has definite parity, we must use a symmetrized polynomial, the #emph[phase estimation polynomial]:

$ P & ""_(epsilon.alt , Delta)^(upright("PE")) ( x ) :=\
 & frac(1, 1 + epsilon.alt / 4) (- 1 + epsilon.alt / 4 + P_(epsilon.alt / 2 , Delta)^Theta (1 / sqrt(2) - x) + P_(epsilon.alt / 2 , Delta)^Theta (1 / sqrt(2) + x)) . $<eq:SignFunction_Target>

Like the eigenvalue threshold polynomial, $P_(epsilon.alt , Delta)^(upright("PE")) ( x )$ is even, is bounded in magnitude by $1$, and behaves as $P_(epsilon.alt , Delta)^Theta (1 / sqrt(2) - x)$ for $x gt.eq 0$, which is the only relevant range for singular values.

This approximation comes with the potential for error, as an iteration of this procedure may now fail with a nonzero probability, where failure is defined as measuring an incorrect bit of an approximation to $phi$ (an approximation that suffers error $lt.eq 2^(- n - 1)$), which will result in an inaccurate $theta$ such that $| theta - phi | gt.eq 2^(- n - 1)$. Therefore, we reformulate our goal probabilistically as: obtain an $n$-bit approximation to $phi$ with probability at least $1 - delta$.

The probability of failure is dictated by the values of $Delta$ and $epsilon.alt$. In particular, for a nonzero $Delta$, note that if $sigma^j in [1 / sqrt(2) - Delta / 2 , med 1 / sqrt(2) + Delta / 2]$, where $P_(epsilon.alt , Delta)^(upright("PE")) ( x )$ is not a good approximation to the sign function, then an error may occur. Fortunately, if $Delta$ is made sufficiently small, this error mode does not induce significant errors:

#thmbox("theorem", "Theorem")[

If we choose $Delta$ such that

$ Delta < 2 (cos ( frac(3 pi, 16) ) - 1 / sqrt(2)) approx 0.25 , $

then $sigma^j in [1 / sqrt(2) - Delta / 2 , 1 / sqrt(2) + Delta / 2]$ is only possible at the $j = n - 1$ iteration, such that an error due to $Delta$ can only occur at the $j^(upright("th"))$ iteration. If an error is made at this iteration, then at the end of the algorithm, then $| theta - phi | < 1 / 2^n$, assuming no errors are made at later iterations.

] <thm:Delta_restriction>

This Theorem, proven in Appendix~@sec:Delta_mitigation, indicates that the error caused by $Delta$ is at most $2^(- n)$ when we obey this bound, which we assume is obeyed in the following.

Next, a nonzero $epsilon.alt$ can also induce errors. Because $P_(epsilon.alt , Delta)^(upright("PE")) ( x ) epsilon.alt$-approximates $Theta (1 / sqrt(2) - x)$ outside of $[1 / sqrt(2) - Delta / 2 , 1 / sqrt(2) + Delta / 2]$, the failure probability of the measurement in @fig:PhaseEstimationCircuit_SingleIteration goes as $cal(O) ( epsilon.alt^2 )$, and this type of error may occur at any iteration. To study this quantitatively, consider iteration $j < n - 1$, such that $sigma^j in.not [1 / sqrt(2) - Delta / 2 , 1 / sqrt(2) + Delta / 2]$, and focus on the scenario $sigma^j < 1 / sqrt(2) - Delta / 2$, in which case $P_(epsilon.alt , Delta)^(upright("PE")) ( sigma^j ) in [ - 1 , - 1 + epsilon.alt ]$, and $theta_1 = 0$ is the ideal measurement (the case in which $sigma^j > 1 / sqrt(2) + Delta / 2$ is analogous). By evaluating the circuit in @fig:PhaseEstimationCircuit_SingleIteration, with $P_(epsilon.alt , Delta)^(upright("PE")) ( sigma^j )$ in place of the sign function, we find that the final (unnormalized) state of the ancilla qubit is

$ 1 / 2 ( (1 - P_(epsilon.alt , Delta)^(upright("PE")) ( sigma^j )) | 0 chevron.r + (1 + P_(epsilon.alt , Delta)^(upright("PE")) ( sigma^j )) | 1 chevron.r ) , $

such that the probability of failure (measuring $| 1 chevron.r$) at this iteration is

$ p_(upright("fail")) = frac(( 1 + P_(epsilon.alt , Delta)^(upright("PE")) ( sigma^j ) )^2, 2 ( 1 + ( P_(epsilon.alt , Delta)^(upright("PE")) ( sigma^j ) )^2 )) lt.eq frac(epsilon.alt^2, 2 ( 1 + ( - 1 + epsilon.alt )^2 )) lt.eq 1 / 2 epsilon.alt^2 $

for $epsilon.alt lt.eq 1$.

What $epsilon.alt$ is sufficient for our purposes? As our procedure consists of $n$ iterations, we desire that each iteration fails with probability no greater than $delta / n$, such that the overall algorithm succeeds with probability at least $1 - delta$ by the union bound. From the above inequality, this can be enforced by the choice $epsilon.alt lt.eq sqrt(2 delta / n)$. Therefore, with these conditions on $Delta$ and $epsilon.alt$, this algorithm sketch succeeds with probability $gt.eq 1 - delta$ at determining a $theta$ such that $| theta - phi | < 1 / 2^n$, as desired.

== The Complete Algorithm
<the-complete-algorithm>

After supplying intuition and addressing potential issues, we now present the complete algorithm for phase estimation by QSVT in @alg:PhaseEstimationByQSVT. We depict this algorithm's circuit in @fig:abstract_qsvt_circuit, which illustrates is resemblance to the inverse quantum Fourier transform, a connection we elaborate on in Section~#ref(<sec:EmergentQFT>, supplement: none). We further unpack the details of the phase estimation by QSVT circuit in @fig:qsvt_phase_estimation; here, the operator $R_ell$ is defined as

$ R_ell := mat(delim: "[", 1, 0; 0, e^(2 pi i / 2^ell)) , $<eq:R_l>

which is a $z$-rotation, up to a global phase.

#algbox([Phase Estimation by QSVT], [
*Input:* An oracle that performs a controlled-$U^j$ operation, an eigenstate $| u chevron.r$ of $U$ with eigenvalue $e^(2 pi i phi)$, and $n + 1$ ancilla qubits (or 1 ancilla qubit that is reused $( n + 1 )$ times). Also, an $epsilon lt.eq sqrt(2 delta / ( n + 1 ))$ and a $Delta < 2 ( cos ( 3 pi / 16 ) - 1 / sqrt(2) ) approx 0.25$.

*Output:* A $theta$ such that $| theta - phi | lt.eq 1 / 2^n$.

*Runtime:* $cal(O) ( n log ( n / delta ) )$ queries to the controlled-$U^j$ oracle. Succeeds with probability $gt.eq 1 - delta$.

*Procedure:*
#enum(
  [Initialize $theta = 0$.],
  [Apply a Hadamard gate to each auxiliary qubit.],
  [*for* $j = n - 1$ *down to* $0$ *do*
    #enum(
      numbering: n => str(n + 2) + ".",
      [$theta arrow.l theta / 2$ (equivalently, $theta = 0 . theta_1 theta_2 dots.c arrow.l 0 . 0 theta_1 theta_2 dots.c$)],
      [Construct a block encoding of $A_j ( theta ) := 1 / 2 ( I + e^(- 2 pi i theta) U^(2^j) )$ as per @fig:A_j_BlockEncodingCircuit.],
      [Use QSVT to apply the operator $( P_(epsilon.alt , Delta)^(upright("PE")) )^(( upright("SV") )) ( A_j ( theta ) )$ to $| u chevron.r$, controlled on an ancilla qubit, where $P_(epsilon.alt , Delta)^(upright("PE")) ( x )$ is defined in @eq:SignFunction_Target.],
      [Apply a Hadamard gate to the ancilla qubit, and measure it in the computational basis.],
      [Set the first bit of $theta$ (i.e. $theta_1$) equal to the result of this measurement.],
    )
  ],
  [With $j = 0$, repeat lines 5-8 of the above loop.],
  [Set the first bit of $theta$ (i.e. $theta_0$) equal to the result of the measurement.],
)
]) <alg:PhaseEstimationByQSVT>


// [figvision] imgs/fig_phase_estimation.png
// The figure is a schematic diagram of a quantum circuit. The circuit has n+1 qubits, with the top n qubits
// initialized to {0} and the bottom qubit initialized to {u}. The circuit consists of n Hadamard gates H applied
// to the top n qubits, followed by n controlled QSVT operations ({1}{{2}}-A_k()) with k ranging from 1 to n.
// Each controlled QSVT operation is applied to the bottom qubit and one of the top n qubits. The top n qubits
// are then measured, with the measurements labeled as _0, _1, ..., _{n-1}, _n. The measurements are used to
// control the QSVT operations through the parameter . The circuit diagram shows the connections between the
// gates and the qubits, with double lines indicating the feedforward of measurement results.
#figure(scope: "parent", image("imgs/fig_phase_estimation.png", width: 100%),
  caption: [
    An Abstract overview of the circuit performing phase estimation through QSVT (@alg:PhaseEstimationByQSVT). The double lines indicate that measurement results are fed forward (via the parameter $theta$) to all future controlled QSVT operations, where this adaptive process is unpacked in @fig:qsvt_phase_estimation. In essence the circuit systematically computes the least significant bit of an unknown quantum phase, adaptively bit shifts this phase, and repeats. Note the similarity of this operation to the inverse quantum Fourier transform, a connection we elaborate on in Section~#ref(<sec:EmergentQFT>, supplement: none).
  ]
)
<fig:abstract_qsvt_circuit>

Note that we have included the additional lines 9-10 in the algorithm to account for the bit in the one's place of $theta$ (i.e. $theta_0$), which is needed when $n < m$ such that $theta$ is an approximation to $phi$. Typically, $theta_0 = 0$, but $theta_0 = 1$ is possible in the scenario that $1.0$ is a good approximation to $phi$ (for example, rounding $0.11111$ to two binary decimals yields $1.00$). As a result of this additional iteration, we must now require $epsilon.alt lt.eq sqrt(2 delta / ( n + 1 ))$ to ensure that the algorithm succeeds with probability at least $1 - delta$.

Also observe that @alg:PhaseEstimationByQSVT consists of $cal(O) ( n )$ iterations, each of which performs an instance of QSVT with a degree $cal(O) (1 / Delta log ( 1 / epsilon.alt )) = cal(O) (log ( n / delta ))$ degree polynomial, so phase estimation by QSVT queries the controlled-$U^j$ oracle $cal(O) ( n log ( n / delta ) )$ times. In addition, the multiplicative factor $1 / Delta$ is not particularly prohibitive because $Delta = cal(O) ( 1 )$ need only satisfy $Delta < 2 (cos ( frac(3 pi, 16) ) - 1 / sqrt(2)) approx 0.25$.

While this $cal(O) ( n log n )$ query complexity may appear to provide a speedup over conventional phase estimation, whose gate count scales as $cal(O) ( n^2 )$, we note that phase estimation by QSVT requires $cal(O) ( n log n )$ queries to the controlled-$U^j$ oracle, whereas conventional phase estimation requires only $cal(O) ( n )$ queries~@nielsen2010quantum. Nonetheless, we believe that this logarithmic factor could be removed by integrating phase estimation by QSVT with a more sophisticated phase estimation protocol, such as the inference procedures of~@svore2013faster @Wiebe_2016, which already attain speedups over conventional phase estimation. Indeed, the QSVT-based phase estimation algorithm of @rall2021faster requires only $cal(O) ( n )$ queries to the oracle, which is achieved by using a procedure very similar to @alg:PhaseEstimationByQSVT, but varying the degree of the QSVT polynomial at each iteration (schematically, by increasing $Delta$ at each iteration).

Likewise, phase estimation by QSVT may be modified to be more applicable to specialized scenarios, such as if one is restricted in the polynomials that may be implemented through QSVT, or if one has prior knowledge about $phi$. For example, suppose that one cannot implement $epsilon.alt lt.eq sqrt(2 delta / ( n + 1 ))$ with certainty, and so instead must choose $epsilon.alt = cal(O) ( 1 )$. To alleviate this difficult, one could repeat the measurement in line 7 $cal(O) ( log ( n / delta ) )$ times and set $theta_1$ equal to the majority vote of the measurement results, which will yield an accurate value of $theta$ with probability $gt.eq 1 - delta$. Similarly, suppose that the constraint on $Delta$ cannot be implemented. Then, again using repeated measurements, if $sigma^(n - 1)$ is very close to $1 / sqrt(2)$, the majority of the measurement results may not reflect the correct choice of $theta_1$. But with high probability, the measurement results will be ambiguous, signaling that $sigma^(n - 1)$ is near $1 / sqrt(2)$. In this event, one could move to an even higher iteration, say some $j > n - 1$, where is is likely that $sigma^j$ is not near $1 / sqrt(2)$ and $phi_(j + 1)$ is easily determined (and if $sigma^j$ is again near $1 / sqrt(2)$, one could again move to a higher iteration $j' > j$). With this bit correctly determined, one may proceed through the rest of the iterations and attain a good estimate of $phi$.

== Applications to Factoring and Beyond
<applications-to-factoring-and-beyond>
Here, we discuss how phase estimation by QSVT may be applied to the factoring problem and used for robust phase estimation.

=== Factoring
<factoring>
Phase estimation by QSVT may be straightforwardly applied to the factoring problem. Recall that in the factoring problem, the oracle $U$ behaves as $U | u chevron.r = | x u ( upright("mod ") N ) chevron.r$ for some $x < N$ and has eigenvalues $e^(2 pi i s / r)$, where $r$ is the order of $U$ (i.e. $x^r = 1 ( upright("mod") N )$) and $s in ( 0 , 1 , . . . , r - 1 )$~@nielsen2010quantum. The goal is to determine some eigenphase $s / r$, from which $r$ may be determined by the continued fractions algorithm and a factor of $N$ may be extracted. In addition, in the factoring problem, one does not have direct access to an eigenstate $| u_s chevron.r$, but instead can prepare a uniform superposition of eigenstates $1 / sqrt(r) sum_s | u_s chevron.r$.


First, consider employing the phase estimation by QSVT algorithm, but replacing $| u chevron.r$ with the superposition $1 / sqrt(r) sum_s | u_s chevron.r$. With this modification, the phase estimation algorithm begins with the superposition state $1 / sqrt(r) sum_s | u_s chevron.r$ and converges to a single eigenstate at the end of the algorithm. To see this, note that each measurement of an ancilla qubit will restrict the state to be a superposition over eigenstates whose eigenvalues are consistent with the measurement results thus far (i.e. the eigenphases whose least significant bits agree with the measurement results). Because the eigenvalues are not degenerate, the state at the end of the algorithm will be an eigenstate, say $| u_s chevron.r$, whose eigenphase is $theta approx s / r$, to which the continued fractions algorithm may be applied to determine $r$.

How accurate must the approximation $theta approx s / r$ be? Note that if our estimate $theta$ obeys

$ lr(|s / r - theta|) lt.eq frac(1, 2 r^2) , $

then we can determine the fraction $s / r$ by applying the continued fractions algorithm to $theta$~@nielsen2010quantum. We can ensure that this condition is met by selecting $n = 2 log_2 ( N ) + 1$, such that $lr(|s / r - theta|) lt.eq 2^(- n) = frac(1, 2 N^2) lt.eq frac(1, 2 r^2)$, as desired. Thus, subject to these conditions, phase estimation by QSVT may be used to factor $N$ in time $cal(O) ( n log ( n / delta ) ) = cal(O) (log N log (frac(log N, delta)))$.

#page(flipped: true)[
// [figvision] imgs/fig_qsvt_qpe_large.png
// The figure is a schematic diagram of a quantum circuit. ### Main Diagram - What is drawn: A quantum circuit
// schematic. - Axes and their ranges and units: Not applicable. - Series or color with its meaning: Not
// applicable. - Symbols and line styles: Solid and dotted lines represent connections between gates; boxes
// represent quantum gates or operations. - Annotations and labels: - Top lines labeled with |0 and H represent
// qubits initialized to zero and Hadamard gates, respectively. - Operations labeled _{2k-1}, _{2k}, W_{n-1},
// W_{n-1}^, etc., represent specific quantum operations. - n+1 qubits are shown. - Trend or message: The circuit
// performs phase estimation using QSVT (Quantum Singular Value Transformation). - Objects and their
// connections/layout: - Qubits run horizontally with various gates applied. - Controlled operations are shown
// with dots and lines connecting control qubits to target operations. ### Inset - What is drawn: An expanded
// view of a controlled W_j operation. - Axes and their ranges and units: Not applicable. - Series or color with
// its meaning: Not applicable. - Symbols and line styles: Similar to the main diagram, with additional details
// on R_j rotations and U^{2^j}. - Annotations and labels: - W_j represents a specific operation. - R_n^j, R_3^j,
// R_2^j represent rotations. - U^{2^j} represents a controlled operation. - Trend or message: Decomposes a
// controlled operation into basic quantum gates. - Objects and their connections/layout: - Shows a sequence of
// gates including Hadamard gates, rotations R_j, and a controlled U^{2^j} operation.
  #figure(image("imgs/fig_qsvt_qpe_large.png", width: 100%),
    caption: [
      A quantum circuit for performing phase estimation using QSVT, following @alg:PhaseEstimationByQSVT. The dotted controlled operators, denoted by $W_j$ at step $j$, represent a composite gadget (unwrapped in the inset block) that depends on the states of $(n - j - 2)$ controlling qubits above it. Here controlled-$phi_j$ gates represent controlled $Z$ rotations by angle $phi_j$. Additionally, this figure depicts only the even $d$ case of @thm:singular_value_transform. This circuit terminates by measuring all auxiliary qubits in the computational basis. Also depicted is an expanded view of a subroutine in the circuit depicted for phase estimation. Note that the $W_j$ operator is the unitary which block-encodes $A_j$ as depicted in @fig:A_j_BlockEncodingCircuit. Note also that each $R_ell$ operator is defined as in @eq:R_l. The controlled $R_ell$ operations serve to adaptively zero out the currently estimated phase to the $(n - j - 2)$-th bit.
    ]
  ) <fig:qsvt_phase_estimation>
]

=== Robust Phase Estimation
<sec:PhaseEstimation_Robust>
Phase estimation by QSVT comes in handy when $U$ cannot be implemented reliably. For instance, suppose that $U^(2^j)$ can only be implemented approximately, such that the error in $U^(2^j)$ may be interpreted as an additive error in the quantity $0 . phi_(j + 1) phi_(j + 2) . . . phi_m$ of @eq:singular_value_reexpression (i.e. the erroneous singular value is $tilde(sigma)^j = | cos ( pi ( 0 . phi_(j + 1) phi_(j + 2) . . . + epsilon - theta ) ) |$, where $epsilon$ is the additive error). If $Delta$ is made sufficiently small, then these errors are not large enough to induce an incorrect measurement result with high probability, and so these errors can be tolerated.

This robustness to error can be quantified via the analysis in Appendix~@sec:Delta_mitigation. Formally, if we choose a small enough $Delta$ such that $1 / 4 - 1 / pi arccos ( 1 / sqrt(2) + Delta / 2 ) < gamma$ for some $gamma > 0$, then we can tolerate additive errors in $0 . phi_(j + 1) phi_(j + 2) . . .$ of magnitude $< 1 / 8 - frac(3 gamma, 2)$. In this sense, phase estimation by QSVT provides protection against noise of this form, which is a nice improvement over conventional phase estimation.

== Emergent Quantum Fourier Transform
<sec:EmergentQFT>
An integral component of @alg:PhaseEstimationByQSVT is the cascading of multiple QSVT sequences, using the results from one instance to control subsequent instances. In its simplest case, this cascading structure reduces to the celebrated quantum Fourier transform (QFT), and generalizes the QFT in more sophisticated constructions. We elaborate on this key connection in this subsection.

To spot this connection, observe that circuit of @fig:abstract_qsvt_circuit resembles that of the (inverse) quantum Fourier transform, which becomes especially apparent in the limit of a length-one QSVT sequence. From a high level, this arises because @alg:PhaseEstimationByQSVT may be viewed as a binary search through each bit of $phi$, where a bit of $phi$ is determined at each iteration. Similarly, the (inverse) quantum Fourier transform may be viewed as a binary search through the bits defining an input state, where each qubit stores a bit of the input state at the end of the computation. Denoting the input state by $| x chevron.r = | x_1 x_2 . . . x_n chevron.r$ where $x = 0 . x_1 x_2 . . . x_n$, recall that the action of the inverse quantum Fourier transform is to map

$  & 1 / 2^(n / 2) sum_(k = 0)^(2^n - 1) e^(2 pi i x k) | k chevron.r = 1 / 2^(n / 2) (| 0 chevron.r + e^(2 pi i 0 . x_n) | 1 chevron.r) ⊗\
 & (| 0 chevron.r + e^(2 pi i 0 . x_(n - 1) x_n) | 1 chevron.r) ⊗ . . . (| 0 chevron.r + e^(2 pi i 0 . x_1 x_2 . . . x_n) | 1 chevron.r) med mapsto\
 & med med | x_1 x_2 . . . x_n chevron.r = | x chevron.r . $

Similar to @alg:PhaseEstimationByQSVT, this mapping is achieved by applying Hadamards and controlled rotations to extract a bit of $x$ from each qubit, leading to the correspondence seen here.

Let us explicitly show how the QFT naturally emerges from this construction. For the sake of pedagogical clarity, we will switch to performing QSVT by projecting into the $| 0 chevron.r chevron.l 0 |$ block of the QSVT sequence, as in the $( W_x , S_z , chevron.l 0 | dot.op | 0 chevron.r )$-QSP convention of Appendix~@sec:QSPConventions, which will make more apparent the connection to the QFT. This change is permissible because the threshold function, an even extension of $Theta (1 / sqrt(2) - x)$, can be well approximated by a polynomial in the more restricted class of polynomials of this convention, as presented in Appendix @subsec:phase_est_func.

Under these conditions, let us make use of the block encoding of @eq:A_j_BlockEncoding (@fig:A_j_BlockEncodingCircuit), where $Pi = tilde(Pi) = | 0 chevron.r chevron.l 0 | ⊗ I$. Then, a single instance of the signal rotation operator (the block encoding) followed by the signal processing rotation operator (the controlled phase shift), which is iterated in QSVT, may be fully realized as in the circuit on the left side of @fig:qsp_phaseestonestep. In this depiction, the top qubit is used to implement the projector controlled phase shift as per @fig:projector-phase-shift-quantum-circuit, and the middle qubit is the block encoding qubit used to access the encoding of $A_j ( theta )$ as per @fig:A_j_BlockEncodingCircuit. Evaluating this circuit allows simplification to the right side of the figure, where we are now able to ignore the top qubit in favor of just the block encoding qubit, an identity that follows from the simple choice of projector. A block encoding qubit can also double as one of the ancilla qubits used to read out a bit of $phi$, as shown below. Let us refer to this type of qubit as a phase readout qubit.

// [figvision] imgs/fig_aux_qubit_reuse.png
// The figure has two panels, labelled (a) and (b), showing two equivalent quantum circuit schematics. Panel (a)
// is a schematic diagram showing a quantum circuit. The diagram has four horizontal lines representing qubits,
// with the top line labelled |0〉 and the bottom line labelled |u〉. The circuit has four boxes: two labelled H,
// one large box with the expression e^(-2πiθ)U^(2^j), and one with the expression e^(-iϕZ). The H boxes are
// connected by a line with a circle and a plus sign. The large box has three dots indicating additional qubits.
// The trend is to show the application of a controlled-Z gate. Panel (b) is another schematic diagram showing an
// equivalent quantum circuit. The diagram has the same structure as panel (a), but with the e^(-iϕZ) box moved
// to the right side of the H boxes and without the controlled-Z gate. The expression e^(-iϕZ) now only has a Z
// inside. The trend is to show an equivalent and simplified circuit. There are no axes or units in these panels.
// The lines are solid, and there are no series or colours. The symbols used are standard quantum circuit
// notation. The message is that the two circuits are equivalent, with the second one being a simplified version
// of the first.
#figure(image("imgs/fig_aux_qubit_reuse.png", width: 100%),
  caption: [
    Simplification of QSP phase control for the case when the block-encoded operator has an accessible control qubit.
  ]
)
<fig:qsp_phaseestonestep>

To make this identification explicit and draw a parallel with the QFT, let us also assume that $phi$ is an $m = 3$ bit number. Then, employing a length $d$ QSVT sequence, the resulting phase estimation circuit may be schematically expressed as in @fig:qsp_phaseest3. Here, each phase readout qubit doubles as a block encoding qubit#footnote[Note that we do not include an additional $( m + 1 )^(upright("th"))$ phase readout qubit for the bit in the ones place of $phi$ because no approximation is needed if we know that $m = 3$.], which is crucial to the emergence of the QFT, and is indeed a valid restructuring. In particular, instead of measuring each phase readout qubit, updating $theta$, and then applying a controlled $theta$-rotation at the next iteration, as in @alg:PhaseEstimationByQSVT, here we directly apply rotations controlled by the phase readout qubit, making intermediate QSP measurement steps unnecessary.

We implement this with the rotation operations $R_ell$ defined in @eq:R_l. Similar to @fig:qsvt_phase_estimation, our construction employs controlled $R_ell$'s to implement the following behavior: if a phase readout qubit is $| 0 chevron.r$, then it does not contribute to $theta$ and no phase shift is applied; alternatively, if the phase readout qubit is $| 1 chevron.r$, then it contributes to $theta$ and the corresponding phase shift is applied. Moreover, we arrange the $R_ell$'s in a pattern that implicitly performs the $theta arrow.l theta / 2$ operation after each iteration; specifically, if ancilla qubit $k$ controls an $R_ell$ at one iteration, then at the next iteration ancilla qubit $k$ controls an $R_(ell + 1)$. It may be easily verified that this procedure correctly encodes $A_j ( theta ) = 1 / 2 ( I + e^(- 2 pi i theta) U^(2^j) )$ at each iteration and is entirely equivalent to the formalism of @alg:PhaseEstimationByQSVT, thus justifying the recycling of phase readout qubits as block encoding qubits.

// [figvision] imgs/fig_three_qubit_qpe_bracket.png
// The figure is a schematic diagram of a quantum circuit. The diagram has four horizontal lines representing
// qubits, with the top three labelled with |0and the bottom one |u. The diagram shows a series of quantum gates
// and operations, including Hadamard gates (H), rotation gates (R2†, R3†), phase gates (φ), and controlled
// unitaries (U4, U2, U1). The gates are connected by lines representing the flow of qubits through the circuit.
// There are also annotations, including "×d" above the top three lines, indicating that the operations are
// repeated d times. The trend or message is that this is a three-qubit quantum phase estimation circuit using
// Quantum Signal Processing (QSP).
#figure(image("imgs/fig_three_qubit_qpe_bracket.png", width: 100%),
  caption: [
    Illustration of three-qubit quantum phase estimation using QSP.
  ]
)
<fig:qsp_phaseest3>

Further, let the QSVT sequence length be simply $d = 1$, giving the quantum circuit depicted in @fig:qsp_phaseest3_L1. This allows us to further simplify the circuit, without changing any circuit elements, by observing that the controlled-$U^(2^j)$ operations commute with the $R_ell$ operations, which are $z$-rotations. Slide the first three Hadamard gates over to the far left, and gather all the remaining gates on the control qubits on the far right, dropping the signal rotation operations $phi.alt$, which are inconsequential at this level of simplification.

// [figvision] imgs/fig_three_qubit_qpe.png
// The figure is a schematic diagram of a quantum circuit. The diagram has four horizontal lines representing
// qubits, with the top three labelled with kets as |0and the bottom one as |u. The diagram shows a series of
// boxes and lines connecting them. The boxes are labelled with various quantum gates: H, φ, R2†, R3†, and U1,
// U2, U4. The lines connecting the boxes represent the flow of qubits through the circuit. There are no axes or
// numerical values in this diagram. The trend or message is that this is a specific implementation of a
// three-qubit quantum phase estimation using QSP.
#figure(image("imgs/fig_three_qubit_qpe.png", width: 100%),
  caption: [
    Illustration of three-qubit quantum phase estimation using QSP, in the simplified case when $d = 1$.
  ]
)
<fig:qsp_phaseest3_L1>

This systematic simplification results in the quantum circuit shown in @fig:qsp_phaseest3_L1QFT, where the inverse QFT circuit emerges naturally as the set of gates following the controlled-$U^(2^j)$ gates. This is the standard quantum phase estimation circuit.

// [figvision] imgs/fig_rearranged_qft.png
// The figure is a schematic diagram of a quantum circuit. The diagram shows four horizontal lines representing
// qubits, with the top three labelled as |0〉 and the bottom as |u〉. Rectangular boxes with letters or symbols
// inside represent quantum gates. The gates on the left are H, and on the right, there are H, R2†, and R3†. The
// gates are connected by solid lines, and some have dots indicating control. A dotted rectangular box encloses
// part of the circuit. The trend shows a sequence of operations applied to the qubits, specifically a
// three-qubit inverse QFT circuit emerging. The objects are qubits and quantum gates, with their connections
// showing the circuit layout.
#figure(image("imgs/fig_rearranged_qft.png", width: 100%),
  caption: [
    Illustration of three-qubit quantum phase estimation using QSP, in the simplified case when $d = 1$, with gates slid along wires to highlight the three-qubit inverse QFT circuit which emerges (gates in dotted rectangular box).
  ]
)
<fig:qsp_phaseest3_L1QFT>

As this pattern persists to higher orders, we see that quantum phase estimation emerges from cascaded QSVT (or QSP) employed to iteratively determine bits of the phase of an eigenphase. The QSVT construction of this transform allows for a richer variety of transformations, however, including a trade-off between the accuracy of each iterative step (by increasing $d$), the number of exponentiated powers $U$ to employ, the number of qubits to use in the transform, and more.

= FUNCTION EVALUATION PROBLEMS BY QSVT
<sec:FuncEval>
Another useful application of QSVT is to evaluate a function of a matrix, which we term #emph[Function Evaluation Problems]. Schematically, if $f ( x )$ is the function of interest, such that we wish to evaluate $f ( A )$, then we could imagine solving this problem by employing QSVT with a polynomial $P ( x )$ that approximates $f ( x )$. While these problems are generally more approachable with a quantum eigenvalue transform, they are still straightforward to solve with QSVT.

Here we summarize prominent function evaluation problems, most notably Hamiltonian simulation and matrix inversion. Our discussion summarizes results from~@Gily_n_2019, wherein the full details of these procedures can be found.

== Hamiltonian Simulation by QSVT
<sec:HamiltonianSimulation>

A motivating goal of quantum computation is to simulate the time evolution of a state under a Hamiltonian, a problem known as Hamiltonian simulation. That is, for a Hamiltonian $cal(H)$ and some time $t$, we would like to approximate the time evolution operator $e^(- i cal(H) t)$, which is evidently a function evaluation problem with the function $f ( x ) = e^(- i x t)$.

In the setup of this problem, we assume access to $cal(H)$, of which we desire a unitary block encoding such that we may solve this problem with QSVT. However, as we discussed in Sec.~#ref(<sec:Threshold>, supplement: none), such a unitary block encoding is only realizable if $parallel cal(H) parallel lt.eq 1$. In general then, we instead determine an $alpha gt.eq parallel cal(H) parallel$ and construct a unitary block encoding of $cal(H) / alpha$. Again, this requires some prior knowledge about $cal(H)$, a drawback we elaborate on in Sec.~#ref(<sec:Discussion>, supplement: none), but fortunately such a block encoding can be achieved for a large class of Hamiltonians~@Low_2019 @Gily_n_2019.

With this rescaled block encoding, one can equivalently imagine that our goal is to simulate the time evolution of a system under the rescaled Hamiltonian $H / alpha$ for a time $t alpha$. This equivalence holds because the corresponding time evolution operators are identical: $e^(- i ( cal(H) / alpha ) ( alpha t )) = e^(- i cal(H) t)$.

How might this problem be solved with QSVT? Naively, one may try to employ QSVT with a polynomial approximation to $e^(- i x t)$ (here, we view $t$ as a parameter, not a variable). However, because the exponential function does not have definite parity, this function does not satisfy the constraints on Poly($a$)$= chevron.l + | U_(arrow(phi.alt)) | + chevron.r$ discussed in Section~#ref(<sec:qsp>, supplement: none) and Appendix~@sec:QSPConventions). To circumvent this issue, one can instead apply QSVT twice - once with an even polynomial approximation to $cos ( x t )$, and once with an odd polynomial approximation to $sin ( x t )$, both of which have definite parities. Then, using the circuit illustrated in @fig:ComplexExponentialCircuit, one can sum together the results of these two QSVT executions to obtain $cos^(( upright("SV") )) ( cal(H) t ) - i sin^(( upright("SV") )) ( cal(H) t ) = e^(- i cal(H) t)$, as desired.

However, note that the above relation only holds if the eigenvalues of $cal(H)$ are positive, such that the singular values are equal to the eigenvalues. As we discussed in Section~#ref(<sec:Threshold>, supplement: none), if this is not the case, we may instead use the block encoding of $cal(H) / alpha$ and a circuit analogous to @fig:A_j_BlockEncodingCircuit to construct a block encoding of the positive definite matrix $1 / 2 (cal(H) / alpha + I)$. Applying the aforementioned QSVT procedure to this matrix for a time $2 alpha t$ produces a block encoding of $e^(- i cal(H) t)$ up to a global phase. In the remainder of this section, we assume that this issue has been alleviated.

// [figvision] imgs/fig_hamiltonian_simulation.png
// ## Panel description The figure shows a schematic diagram of a quantum circuit. ### Panel a * What is drawn:
// Schematic diagram * Axes and their ranges and units: None * Series or color with its meaning: None * Symbols
// and line styles: * Horizontal lines represent qubits, with two lines indicating two qubits. * Boxes represent
// quantum gates or operations. * The top qubit starts with a box labeled "H", indicating a Hadamard gate. * The
// line has a small open circle, then a small solid circle, and ends with another box labeled "H". * The bottom
// qubit starts with a label "|_0" and has a box labeled "({H}t)" followed by another box labeled "-i({H}t)". *
// Annotations and labels: * The top qubit is labeled "|0". * The bottom qubit is labeled "|_0". * Trend or
// message: The diagram shows a quantum circuit with two qubits and specific operations applied to them. ###
// Panel b There are no panels labeled "b" or "c". The figure appears to be a single schematic diagram with no
// additional panels.
#figure(image("imgs/fig_hamiltonian_simulation.png", width: 100%),
  caption: [
    One quantum circuit that can be used to construct the time evolution operator $cos ( cal(H) t ) - i sin ( cal(H) t ) = e^(- i cal(H) t)$ and apply it to $| psi_0 chevron.r$, for use in Hamiltonian simulation as described in @alg:HamiltonianSimulationByQSVT. Note that the correct evolution of the input state $| psi_0 chevron.r$ is achieved only upon post-selection of the auxiliary qubit in the $| 0 chevron.r$ state. One can achieve this with either repetition or fixed-point amplitude amplification, similar to projecting into the desired block of the QSVT sequence operator as discussed at the end of Section~#ref(<sec:qsvt>, supplement: none).
  ]
)
<fig:ComplexExponentialCircuit>

Returning back to the QSVT scheme, we note that in~@Gily_n_2019, Gilyén et al. approximate the functions $cos ( x t )$ and $sin ( x t )$ by polynomials using the Jacobi-Anger expansion:

$ cos ( x t ) = J_0 ( t ) + 2 sum_(k = 1)^oo ( - 1 )^k J_(2 k) ( t ) T_(2 k) ( x ) $<eq:Jacobi-Anger1>
$ sin ( x t ) = 2 sum_(k = 0)^oo ( - 1 )^k J_(2 k + 1) ( t ) T_(2 k + 1) ( x ) $<eq:Jacobi-Anger2>

where $J_i ( x )$ is a Bessel function of order $i$, and $T_i ( x )$ is a Chebyshev polynomial of order $i$. One can attain $epsilon.alt$-approximations to $cos ( x t )$ and $sin ( x t )$ by truncating these expressions at a sufficiently large index $k'$. The necessary truncation index $k'$ may be determined by a function $r ( t , epsilon.alt )$, which is defined implicitly as

$ epsilon.alt = (frac(| t |, r ( t , epsilon.alt )))^(r ( t , epsilon.alt )) upright(" s.t. ") r ( t , epsilon.alt ) in ( t , oo ) , $

and scales asymptotically as

$ r ( t , epsilon.alt ) = Theta ( | t | + frac(log ( 1 / epsilon.alt ), log ( e + frac(log ( 1 / epsilon.alt ), | t |) )) ) . $

In particular, truncating @eq:Jacobi-Anger1 and~@eq:Jacobi-Anger2 at $k' = floor.l 1 / 2 r (e / 2 | t | , 5 / 4 epsilon.alt) floor.r$ yields $epsilon.alt$-approximations to $cos ( x t )$ and $sin ( x t )$, respectively, where $0 < epsilon.alt < 1 / e$. Because $T_i ( x )$ is a polynomial of degree $i$ with definite parity, these approximations are polynomials of degree $2 k'$ and $2 k' + 1$, respectively, with the correct even/odd parity. Let us denote these polynomials by $P_epsilon.alt^(upright("cos")) ( x t )$ and $P_epsilon.alt^(upright("sin")) ( x t )$.

Lastly, because cosine and sine are bounded in magnitude by $1$, these $epsilon.alt$-approximations only obey $| P_epsilon.alt^(upright("cos")) ( x t ) | , | P_epsilon.alt^(upright("sin")) ( x t ) | lt.eq 1 + epsilon.alt$. However, we need the target polynomials to necessarily be bounded in magnitude by $1$ in order to be implemented through QSVT. As in~@Low_2017, we can fix this by rescaling the polynomials by a factor of $frac(1, 1 + epsilon.alt)$, at the expense of increasing the error of these approximations to $2 epsilon.alt$. This can be seen with the triangle inequality as $lr(|frac(1, 1 + epsilon.alt) P_epsilon.alt^(upright("cos")) ( x t ) - cos ( x t )|) lt.eq frac(1, 1 + epsilon.alt) (lr(|P_epsilon.alt^(upright("cos")) ( x t ) - cos ( x t )|) + lr(|epsilon.alt cos ( x t )|)) lt.eq frac(1, 1 + epsilon.alt) ( epsilon.alt + epsilon.alt ) lt.eq 2 epsilon.alt$, and similarly for $P_epsilon.alt^(upright("sin")) ( x t )$.

To determine the complexity of this Hamiltonian simulation algorithm, first recall that our effective goal is to simulate the rescaled Hamiltonian $cal(H) / alpha$ for time $alpha t$. In addition, note that the truncations of the Jacobi-Anger expansion used in this procedure should be $epsilon.alt / 4$-approximate such that, when rescaled by $frac(1, 1 + epsilon.alt / 4)$, they are $epsilon.alt / 2$-approximations to $cos ( x t )$ and $sin ( x t )$. With this choice, the sum of these approximations, which is the approximation to $e^(- i x t)$, is $epsilon.alt$-approximate by the triangle inequality. Incorporating these conditions, we see that this QSVT-based Hamiltonian simulation algorithm prepares an $epsilon.alt$-approximate block encoding of $e^(- i cal(H) t)$ and queries $U$ a total number of times

$ 2 k' + & 2 k' + 1 = 4 dot.op floor.l 1 / 2 r (e / 2 alpha | t | , 5 / 4 epsilon.alt / 4) floor.r + 1\
 & = Theta ( alpha | t | + frac(log ( 1 / epsilon.alt ), log ( e + frac(log ( 1 / epsilon.alt ), alpha | t |) )) ) . $

In comparing this query complexity with results quoted in the literature, $alpha$ may be replaced with $parallel cal(H) parallel$.

This complexity has state-of-the-art scaling in $t$ and $epsilon.alt$ for Hamiltonian simulation: it is linear in $t$, logarithmic in $epsilon.alt$, and additive in these two terms. As such, it provides a significant improvement over other algorithms~@Low_2017 @Low_2019 @Gily_n_2019. We summarize Hamiltonian simulation by QSVT in @alg:HamiltonianSimulationByQSVT.


#algbox([Hamiltonian Simulation by QSVT], [
*Input:* Access to a Hamiltonian $cal(H)$, a desired time $t$, an error tolerance $epsilon.alt$, and an $alpha gt.eq parallel cal(H) parallel$.

*Output:* A block encoded $epsilon.alt$-approximation of $e^(- i cal(H) t)$.

*Runtime:* $Theta ( alpha | t | + frac(log ( 1 / epsilon.alt ), log ( e + frac(log ( 1 / epsilon.alt ), alpha | t |) )) )$ queries to (the encoding of) $cal(H) / alpha$.

*Procedure:*
#enum(
  [Prepare a unitary block encoding of $cal(H) / alpha$.],
  [Apply QSVT to this encoding twice, using the polynomials $frac(1, 1 + epsilon.alt / 4) P_(epsilon.alt / 4)^(upright("cos")) ( x ; t )$ and $frac(1, 1 + epsilon.alt / 4) P_(epsilon.alt / 4)^(upright("sin")) ( x ; t )$, where $P_(epsilon.alt / 4)^(upright("cos")) ( x ; t )$ and $P_(epsilon.alt / 4)^(upright("sin")) ( x ; t )$ are obtained by truncating the series in @eq:Jacobi-Anger1 and~@eq:Jacobi-Anger2, respectively, at index $k' = floor.l 1 / 2 r ( e / 2 alpha | t | , 5 / 4 epsilon.alt / 4 ) floor.r$.],
  [With the results of the above QSVT executions, which approximate $cos^(( upright("SV") )) ( cal(H) t )$ and $sin^(( upright("SV") )) ( cal(H) t )$, respectively, run the circuit in @fig:ComplexExponentialCircuit.],
)
]) <alg:HamiltonianSimulationByQSVT>


== Matrix Inversion by QSVT
<sec:matrix_inversion>

Another straightforward, yet widely applicable function evaluation problem is that of #emph[matrix inversion]. That is, given access to a square matrix $A$, one wishes to construct an approximation to $A^(- 1)$. Harrow, Hassidim, and Lloyd presented a quantum algorithm for this problem in the case that $A$ is Hermitian~@Harrow_2009. In their eponymous algorithm, they prepare the state $A^(- 1) | b chevron.r$, which provides a quantum solution to the linear system $A | x chevron.r = | b chevron.r$.

Let's now look at this problem through the lens of QSVT. Suppose that we have an $N times N$ matrix $A$ with singular value decomposition $A = W_Sigma Sigma V_Sigma^dagger$, where $Sigma$ contains the singular values along its diagonal. As per the setup of HHL algorithm, we also assume that the singular values of $A$ obey $sigma_i in [ 1 / kappa , 1 ]$ for some finite condition number $kappa gt.eq 1$ (if not, $A$ may be rescaled to obey this condition). As the singular values are nonzero, the inverse of $A$ exists and may be obtained as $A^(- 1) = V_Sigma Sigma^(- 1) W_Sigma^dagger$, where $Sigma^(- 1)$ contains the reciprocals of the singular values along its diagonal. Because $A^dagger = V_Sigma Sigma W_Sigma^dagger$, this can be re-expressed as $A^(- 1) = f^(( upright("SV") )) ( A^dagger )$, where $f ( x ) = 1 / x$, indicating that matrix inversion is a function evaluation problem with $f ( x ) = 1 / x$.

Upon this realization, it is clear how to apply QSVT to matrix inversion: find an odd polynomial $P ( x )$ that approximates $f ( x ) = 1 / x$ over the range of singular values of $A$, and employ QSVT to construct $P^(( upright("SV") )) ( A^dagger )$, which approximates $A^(- 1)$. Finding a good polynomial $P ( x )$ is tricky because of the discontinuity in $1 / x$, but it indeed can be done. In addition, this procedure requires that one can construct a unitary block encoding of $A$, which is feasible because $parallel A parallel lt.eq 1$ as per the assumption that $sigma_i lt.eq 1$. Such a block encoding can indeed be achieved for a variety of matrices relevant to physics~@Gily_n_2019 @Low_2019 (but again, we discuss some caveats of doing so in Sec.~#ref(<sec:Discussion>, supplement: none)).

Moreover, because we require that the polynomial $P ( x )$ be bounded in magnitude by $1$ such that it can be implemented through QSVT, we cannot necessarily use $P ( x ) approx 1 / x$ as our target function since $1 / sigma_i gt.eq 1$ in general. To overcome this challenge, let us instead seek a polynomial approximation to a function that behaves as $frac(1, 2 kappa) 1 / x$ over the range $[ - 1 , 1 ] [ frac(- 1, kappa) , 1 / kappa ]$, which will invert each singular value and is bounded in magnitude by $1 / 2$ over this range (we use the multiplicative factor $frac(1, 2 kappa)$ instead of $1 / kappa$ to avoid the need to rescale by $frac(1, 1 + epsilon.alt)$ when we $epsilon.alt$-approximate this function, which was done in Section~#ref(<sec:HamiltonianSimulation>, supplement: none)). This procedure will output an approximation of $frac(1, 2 kappa) A^(- 1)$, and because $kappa$ is #emph[a priori] known, this multiplicative factor is not prohibitive to calculations. However, due to this multiplicative factor, we now desire a $frac(epsilon.alt, 2 kappa)$-approximation to $frac(1, 2 kappa) A^(- 1)$, from which we effectively attain an $epsilon.alt$-approximation to $A^(- 1)$.

The appropriate polynomial for matrix inversion is thus an $frac(epsilon.alt, 2 kappa)$-approximation to $frac(1, 2 kappa) 1 / x$. In Appendix~@sec:matrix_inversion_polynomial, we demonstrate how to construct such a polynomial. While the construction is a bit involved, in essence it is a product of a polynomial approximation to $1 / x$ over a restricted range (constructed as a sum of Chebyshev polynomials) and a polynomial approximation to a rectangular function (constructed as a sum of the sign function approximations, $P_(epsilon.alt , Delta)^Theta ( x )$).

We term this polynomial the #emph[matrix inversion polynomial], denoted by $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$, and defer its rigorous definition to in Appendix~@sec:matrix_inversion_polynomial. In addition to being an $frac(epsilon.alt, 2 kappa)$-approximation to $frac(1, 2 kappa) 1 / x$, $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ has odd parity and is bounded in magnitude by $1$ for $x in [ - 1 , 1 ]$. Hence, the matrix inversion polynomial may be implemented through QSVT.

Moreover, we also show in Appendix~@sec:matrix_inversion_polynomial that $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ has degree

$ d = cal(O) ( kappa log ( kappa / epsilon.alt ) ) . $

As QSVT requires $cal(O) ( d )$ calls to the block encoding, we see that matrix inversion by QSVT has complexity $cal(O) ( kappa log ( kappa / epsilon.alt ) )$. This is an improvement over the conventional HHL algorithm, which has runtime $cal(O) ( kappa^2 log ( N ) / epsilon.alt )$. It is quite impressive that the QSVT algorithm provides an large improvement in the scaling with $kappa / epsilon.alt$, although similar results have been achieved with non-QSVT methods @Childs_2017. In addition, the HHL algorithm uses a sparse Hamiltonian simulation subroutine with target Hamiltonian $A$, resulting in the $log ( N )$ term in its complexity, whereas the QSVT algorithm does not use such a subroutine and thus $N$ dependence is absent from its complexity (however, constructing the necessary block encoding of $A$ may scale with $N$). We summarize matrix inversion by QSVT in @alg:MatrixInversionByQSVT.

Moreover, like the HHL algorithm, matrix inversion by QSVT may be used to solve the linear system of equations $A | x chevron.r = | b chevron.r$, by applying the block encoding of $frac(1, 2 kappa) A^(- 1)$ to $| b chevron.r$, which yields an $epsilon.alt$-approximation to $A^(- 1) | b chevron.r$ upon rescaling by $2 kappa$. As discussed at the end of Section~#ref(<sec:qsvt>, supplement: none), this procedure requires that we project into the desired block of the QSVT sequence operator, which may be performed with little overhead.

Lastly, we note that this result can be further extended. With some minor adjustments, this QSVT-based algorithm can be adapted to prepare the pseudo-inverse of a rectangular matrix, which is useful in various machine learning contexts~@Gily_n_2019.

#algbox([Matrix Inversion by QSVT], [
*Input:* Access to $A$, an error tolerance $epsilon.alt$, and a condition number $kappa gt.eq 1 / ( min_i sigma_i )$.

*Output:* A block encoded $epsilon.alt / ( 2 kappa )$-approximation of $kappa / 2 A^(- 1)$, which is effectively equivalent to an $epsilon.alt$-approximation to $A^(- 1)$.

*Runtime:* $cal(O) ( kappa log ( kappa / epsilon.alt ) )$ queries to (a block encoding of) $A^dagger$.

*Procedure:*
#enum(
  [Prepare a unitary block encoding of $A^dagger$.],
  [Apply QSVT to this block encoding to compute $( P_(epsilon.alt , kappa)^(upright("MI")) )^(( upright("SV") )) ( A^dagger )$, where the polynomial $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ is defined in @eq:1OverxApprox of Appendix~@sec:matrix_inversion_polynomial.],
)
]) <alg:MatrixInversionByQSVT>


= DISCUSSION
<sec:Discussion>

In this paper, we have presented how the quantum singular value transformation encapsulates the three major quantum algorithms. Paralleling~@Gily_n_2019, we have constructed QSVT-based algorithms for search, Hamiltonian simulation, and the quantum linear systems problem. Toward this end we have also derived QSVT-based algorithms for the eigenvalue threshold problem and phase estimation. Moreover, the utility of QSVT is not entirely enumerated here --- further applications of QSVT to the quantum OR lemma, quantum machine learning, quantum walks, fractional query implementation, and Gibbs state preparation appear in the literature~@Gily_n_2019.

It is insightful that QSVT encompasses such a broad spectrum of problems. Effectively, QSVT provides a series of dials (i.e., a well-defined parameterization) that can be turned to transform from one algorithm to another. In addition, when there is sufficient structure inherent to the problem of interest, the resulting algorithm often becomes more efficient. Consequently, QSVT provides one lens through which to analyze the source of quantum advantage, and make concrete the somewhat vague tradeoff conjectured between problem structure and quantum algorithmic efficiency (while maintaining a significant gap between optimal classical and quantum performance). In aggregate, these constructions suggest that it is wise to continue to search for new quantum algorithms in the setting of QSVT.

There is ample room for future research in this area. Notably, various quantum algorithms have not yet been constructed from QSVT-based subroutines, such as variational algorithms like the variational quantum eigensolver @peruzzo2014variational or the quantum approximate optimization algorithm @farhi2014quantum. It would be fascinating to see if QSVT can encompass, or perhaps even enhance, these hybrid quantum algorithms as well. This work also begets the question of how else one might tweak the parameters of QSVT to create novel algorithms, or extend previously known algorithms to novel noise settings. As QSVT is intuitive and flexible, there is likely a large class of problems that are amenable to analysis by QSVT and admit a significant quantum advantage.

Moreover, note that there is a significant caveat in the use of QSVT, arising from the requirement of block encodings. In a typical implementation of QSVT on quantum computer, we may imagine that the matrix to which we would like to apply a transform, say $A$, is provided in a quantum random-access memory ("QRAM"), from which we may straightforwardly construct a block encoding of $A / parallel A parallel_F$~@Gily_n_2019. One could then apply QSVT to this encoding with a runtime linear in $parallel A parallel_F$, similar to how the runtimes of the eigenvalue threshold algorithm and the Hamiltonian simulation algorithm of this paper are linear in $alpha$. However, assuming that one has a classical computer with sampling and query access to $A$, as a classical analog of having $A$ loaded into QRAM, then one can acquire access to a singular value transformation of $A$ by executing a classical (not quantum!) algorithm~@Chia_2020; this classical algorithm impressively has a runtime polynomial in $parallel A parallel_F$. This polynomial runtime suggests that QRAM-based QSVT cannot always achieve an exponential speedup over classical algorithms, but can still attain a significant polynomial speedup. Although this challenge could be an Achilles' heel for application of QSVT to general and unstructured problems, clearly QSVT is still of interest for speeding up solution of problems with structure, as illustrated by quantum factoring. Also, while every QRAM essentially provides a block-encoded matrix, there are ways to block-encode matrices which do not require a QRAM; this is good, given the fact that QRAM implementations generally face a number of practical challenges in their realization, e.g. requiring a number of ancillary qubits which grows linearly with the number of items stored (see, e.g. @HannLeeGirvinJiang2021a and references therein).

It is also interesting to note that while physics has developed significant insight into the role of eigenvalues, appreciation of singular values has lagged. For example, eigenvalues are the bread and butter of quantum systems, as energies for eigenstates of the Hamiltonian, and as stability points for stochastic systems. In contrast, singular values apparently play few starring roles in physics. One of the few examples arises in the study of entanglement, where the singular value decomposition is the underlying construct behind the Schmidt decomposition of a bipartite quantum state.

Why are there so few prominent roles for singular values in physics? Maybe it is because physics is drawn to closed, Hamiltonian systems (think: square matrices), whereas singular value decompositions arise mostly in studies of subsystems (think: non-square matrices), where the input and output dimensions may be different. As discussed in the introduction, such disparate dimensions also arises naturally in computation. And indeed, singular value decompositions play a prominent role in modern computation, especially in machine learning, where it is the basis for principal component analysis, model reduction, collaborative filtering, and more. As quantum information and computer science continue to grow into a unified field, perhaps it is not surprising that singular value decompositions -- and singular value transformations -- are emerging as a unifying bridge.

#emph[Acknowledgements]: The numerical phase computation and algorithms work by AKT was supported by the U.S. Department of Energy, Office of Science, National Quantum Information Science Research Centers, Co-Design Center for Quantum Advantage under contract DE-SC0012704 and the Natural Sciences and Engineering Research Council of Canada (NSERC) \[PGSD3-545841-2020\]. The algorithm analysis work by ZMR was supported in part by the NSF EPIQC program. ILC was supported in part by the NSF Center for Ultracold Atoms. ZMR and ILC were also supported in part by ARO contract W911NF-17-1-0433.

#set heading(numbering: "A.1")
#counter(heading).update(0)

= QSP CONVENTIONS
<sec:QSPConventions>

A quantum signal processing construction may be entirely determined by four constituents:

+ The #emph[signal operator] $W$ (sometimes also called the signal unitary)

+ The #emph[phase angles] $arrow(phi.alt) = ( phi.alt_0 , phi.alt_1 , dots.h , phi.alt_d )$

+ The #emph[signal processing] operator $S ( phi.alt )$, constructing using $phi.alt in arrow(phi.alt)$

+ The #emph[signal basis] $M$, in which the desired polynomial is obtained

In its most basic form, QSP is performed by interleaving $W$ with $S ( phi.alt )$ operations followed by a projective measurement in the basis $M$.

The signal operator $W$ is signal-dependent and constant throughout the sequence; the signal processing operator $S$ is parameterized by a sequence of phases $arrow(phi.alt) in bb(R)^(d + 1)$, which are chosen based on the desired output function. The exact form of $W$ and $S$, along with the choice of measurement basis $M$, determine the family of achievable output functions. More specifically, $M$ may be not a basis for a complete vector space, but just the basis for a subspace identifying a specific desired polynomial output function. For example, we may specify $M=chevron.l +|dot.op |+ chevron.r$, when the measurement is to select the $| + med$ outcome, with the QSP sequence starting off with the control qubit in the $| + med$ state. Thus, we may refer to any particular QSP construction as being a ($W$, $S$, $M$)-QSP convention.

In this section, we discuss common ($W$, $S$, $M$)-QSP conventions in the literature for $W$, $S$, and $M$, and present relationships between the QSP phase angles $arrow(phi.alt)$. Specifically, we elaborate on the "Wx", reflection, and "Wz" conventions.

== Wx convention for QSP
<wx-convention-for-qsp>

One common convention is to choose the signal operator $W$ to be an $x$-rotation in the Bloch sphere, $ W_x ( theta ) := e^(i theta / 2 X) = [ & a & i sqrt(1 - a^2) \
    & i sqrt(1 - a^2) & a ] thin , $<eq:wa_qsp_x> where, compared with @eq:wa_qsp, we introduce the additional $x$ subscript for clarity. Under this convention, one also chooses the signal processing rotation to be a $z$-rotation,$S_z ( phi.alt ) = e^(i phi.alt Z)$. @thm:qsp describes the family of unitaries achievable in this convention.

Typically, we are not concerned with the achievable unitaries, but rather the achievable functions that can be computed in a subsystem. If we choose to project out the $chevron.l 0 | dot.op | 0 |$ element, the output is $upright("Poly") ( a ) = chevron.l 0 | U_(arrow(phi.alt)) | 0 | = chevron.r P ( a )$. Here, the choice of $upright("Poly")$ is restricted not only by the conditions on $P$ of @thm:qsp, but also the additional constraints below which ensure that a polynomial $Q$ exists satisfying the conditions of @thm:qsp.

#thmbox("theorem", "Theorem", title: [($(W_x, S_z, chevron.l 0 | dot.op | 0 chevron.r)$-QSP)])[

A QSP phase sequence $arrow(phi.alt) in bb(R)^(d + 1)$ exists

$ upright("Poly") ( a ) = chevron.l 0 | e^(i phi_0 Z) product_(k=1)^d W_x ( a ) e^(i phi_k Z) | 0 chevron.r $<eq:qsp_thm_Wx-Sz-00>

for $a in [-1, 1]$, and for any polynomial $upright("Poly") in bb(C)[a]$ if and only if the following conditions hold:

#enum(
  numbering: "(i)",
  [$upright("deg")(upright("Poly")) lt.eq d$],
  [$upright("Poly")$ has parity $d upright("mod") 2$],
  [$forall a in [-1, 1]$, $|upright("Poly")(a)| lt.eq 1$],
  [$forall a in (-infinity, -1] union [1, infinity)$, $|upright("Poly")(a)| gt.eq 1$],
  [if $d$ is even, then $forall a in bb(R)$, $upright("Poly")(i a) upright("Poly")^*(i a) gt.eq 1$],
)

] <thm:qsp_Wx-Sz-00>

The family of achievable polynomials in this case is significantly limited since the projective measurement is performed in the same basis $M = {|0 chevron.r, |1 chevron.r}$ as the signal processing operations. For example, this immediately limits us to polynomial functions such that $|upright("Poly")(plus.minus 1)| = 1$.

Properties (iv) and (v), are quite restrictive especially when approximating real functions. In fact, none of polynomial approximations described in this paper satisfy these last two constraints. Allowing a small but non-zero imaginary part, it is possible to find QSP phases in the $(W_x, S_z, chevron.l 0 | dot.op | 0 chevron.r)$ convention approximating real functions that satisfy $|f(plus.minus 1)| = 1$; an example of this is the phase estimation function plotted in Section~#ref(<subsec:phase_est_func>, supplement: none).

Since we are often interested in constructing real polynomials, choosing a different signal basis ends up being much more useful. In particular, when $M = {|+ chevron.r, |- chevron.r}$, then we may employ this theorem for real polynomials:

#thmbox("theorem", "Theorem", title: [($(W_x, S_z, chevron.l + | dot.op | + chevron.r)$-QSP)])[

A QSP phase sequence $arrow(phi.alt) in bb(R)^(d + 1)$ exists such that

$ upright("Poly") ( a ) = chevron.l + | e^(i phi_0 Z) product_(k=1)^d W_x ( a ) e^(i phi_k Z) | + chevron.r $<eq:qsp_thm_Wx-Sz-pp>

for $a in [-1, 1]$, and for any real polynomial $upright("Poly") in bb(R)[a]$ if and only if the following conditions hold:

#enum(
  numbering: "(i)",
  [$upright("deg")(upright("Poly")) lt.eq d$],
  [$upright("Poly")$ has parity $d upright("mod") 2$],
  [$forall a in [-1, 1]$, $|upright("Poly")(a)| lt.eq 1$],
)

] <thm:qsp_Wx-Sz-pp>

This QSP convention is expressive enough for all of the polynomials considered in this paper and is used in~@Low_2016 and @Gily_n_2019. The proofs of @thm:qsp_Wx-Sz-00 and @thm:qsp_Wx-Sz-pp are given in~@Gily_n_2019.

== Reflection convention for QSP
<subsec:reflection>

Another common convention is to choose the signal operator $W$ to be a reflection (as in @eq:ampamp_rot).

$ R ( a ) := mat(delim: "[", a, sqrt(1 - a^2); sqrt(1 - a^2), -a) thin , $<eq:ra_qsp_x>

The reflection operator is preferred in some cases as it has the added benefit of being Hermitian, which can simplify proof constructions, and in particular equations such as @eq:sigproc_tran_b. Given a phase sequence $arrow(phi.alt) in bb(R)^(d + 1)$, we can find a $arrow(phi.alt)' in bb(R)^(d + 1)$ such that

$ e^(i phi.alt_0 Z) product_(k = 1)^d R ( a ) e^(i phi.alt_k) = e^(i phi.alt'_0 Z) product_(k = 1)^d W_x ( a ) e^(i phi.alt'_k) thin . $

Using the relationship of @eq:wa_to_ra, this can be accomplished by choosing $phi.alt_0 = phi.alt'_0 + ( 2 d - 1 ) pi / 4$, $phi.alt_d = phi.alt'_d - pi / 4$, and $phi.alt_k = phi.alt'_k - pi / 2$ for $k in 1 , dots.h , d - 1$. Therefore, these two conventions are equivalent regardless of the final measurement basis.

== Wz convention for QSP
<wz-convention-for-qsp>

@thm:qsp_Wx-Sz-pp can also be understood through its relationship to the convention used in~@chao2020finding. Here the authors define QSP with the signal operator $W$ being a $z$-rotation,

$ W_z ( theta ) = e^(i theta / 2 Z) = mat(delim: "[", w, 0; 0, w^(- 1)) thin , $<eq:wa_qsp_z>

where $w := e^(i theta / 2)$, and the signal processing operator is an $x$-rotation, $S_x ( phi.alt ) = e^(i phi.alt X)$. Furthermore, in this convention, it is typical to choose the signal basis as being $M = ( | 0 med , | 1 med )$.

In our notation, this convention is written as $( W_z , S_x , chevron.l 0 | dot.op | 0 | ) chevron.r$-QSP. This convention is equivalent to $( W_x , S_z , chevron.l + | dot.op | + | ) chevron.r$-QSP and is equally expressive which can easily be seen since

$ chevron.l + | e^(i phi.alt_0 Z) product_(k=1)^d W_x ( theta ) e^(i phi.alt_k Z) | + chevron.r \
  chevron.l 0 | e^(i phi.alt_0 X) product_(k=1)^d W_z ( theta ) e^(i phi.alt_k X) | 0 chevron.r $<eq:Wx-Wz-equivalence>

The Laurent polynomial formulation of $( W_z , S_x , chevron.l 0 | dot.op | 0 | ) chevron.r$-QSP of~@chao2020finding can be related to our formulation as follows

$  &  & e^(i phi.alt_0 X) product_(k = 1)^d W_z ( theta ) e^(i phi.alt_k X)\
 & = & : mat(delim: "[", F ( w ), i G ( w ); i G ( w^(- 1) ), F ( w^(- 1) ))\
 & = & H e^(i phi.alt_0 Z) product_(k = 1)^d W_x ( theta ) e^(i phi.alt_k Z) H\
 & = & H mat(delim: "[", P ( a ), i Q ( a ) sqrt(1 - a^2); i Q^(*) ( a ) sqrt(1 - a^2), P^(*) ( a )) H $<eq:fg_matrix>

for complex polynomials $P , Q in bb(C) [ a ]$ and real Laurent polynomials $F , G in bb(R) [ w , w^(- 1) ]$ with parity $d #h(0em) mod med 2$.

Explicitly,

$ f_0 = Re [ p_0 ] , & quad & g_0 = Im [ p_0 ] $

and for $k > 0$,

$ f_k = 1 / 2 Re [ p_k + q_k ] , & #h(2em) & f_(- k) = 1 / 2 Re [ p_k - q_k ]\
g_k = 1 / 2 Im [ p_k - q_k ] , & #h(2em) & g_(- k) = 1 / 2 Im [ p_k + q_k ] $

where the coefficients for $P$ and $Q$ are given in the Chebyshev bases

$ P ( a ) & equiv & sum_(k = 0)^d p_k T_k ( a )\
Q ( a ) & equiv & sum_(k = 0)^d q_k U_(k - 1) ( a ) $

and the coefficients for the $F$ and $G$ are given in the standard basis

$ F ( w ) equiv sum_(k = - d)^d f_k w^k , & #h(2em) & G ( w ) equiv sum_(k = - d)^d g_k w^k $

Requiring unitarity in @eq:fg_matrix is equivalent to

$ F ( w ) F ( w^(- 1) ) + G ( w ) G ( w^(- 1) ) = 1 thin . $

A numerically stable method for computing phases for a given $F ( w )$ in the $( W_z , S_x , chevron.l 0 | dot.op | 0 | ) chevron.r$ convention is discussed further in~@chao2020finding and can also be seen as a constructive proof of @thm:qsp_Wx-Sz-pp.

= PROOFS ABOUT PHASE ESTIMATION BY QSVT
<sec:PhaseEstimationProofs>
In this appendix, we prove the theorems used in the development of phase estimation by QSVT in Section~#ref(<sec:PhaseEstimation>, supplement: none).

== Theorems~#ref(<thm:n_geq_m>, supplement: none) and~#ref(<thm:n_l_m>, supplement: none)
<sec:PhaseEstimation_m_n_Proofs>

Here, we prove the Theorems~#ref(<thm:n_geq_m>, supplement: none) and~#ref(<thm:n_l_m>, supplement: none) from Section~#ref(<sec:PhaseEstimation_Sketch>, supplement: none):

#block[
#ref(<thm:n_geq_m>) #h(0.4em) #emph[If $n gt.eq m$, and one has the ability to implement the sign function exactly through QSVT, then at the end of the algorithm sketch of Section~#ref(<sec:PhaseEstimation_Sketch>, supplement: none), $theta = phi$.]
]

and

#block[
#emph[Proof.] The proof proceeds by induction.

#emph[Base Case]: The base case is the $j = n - 1$ iteration, at which $theta = 0$. Using @eq:singular_value_reexpression, we see that $A_j ( theta ) = A_(n - 1) ( 0 )$ has singular value

$ sigma^(n - 1) = | cos ( pi ( 0 . phi_n - 0 ) ) | = cases(
  1 & upright("if") phi_n = 0,
  0 & upright("if") phi_n = 1,
) , $

and so $Theta ( 1 / sqrt(2) - sigma^(n - 1) ) = 1 - 2 phi_n$. Therefore, after we apply $Theta^(( upright("SV") )) ( 1 / sqrt(2) - A_(n - 1) ( 0 ) )$ to $| u chevron.r$, controlled on the ancilla qubit, the state of the ancilla qubit is $1 / sqrt(2) ( | 0 chevron.r + ( 1 - 2 phi_n ) | 1 chevron.r )$. The final Hadamard gate brings the ancilla qubit to the state

$ ( 1 - phi_n ) | 0 chevron.r + phi_n | 1 chevron.r = cases(
  | 0 chevron.r & upright("if") phi_n = 0,
  | 1 chevron.r & upright("if") phi_n = 1,
) , $

and therefore the measurement of the ancilla qubit will yield $phi_n$. The final step of the iteration will set $theta_1 = phi_n$, such that $theta = 0 . phi_n$, as claimed.

#emph[General Case:] Proceeding with induction, assume that this claim is true at the end of iteration $j + 1$. That is, $theta = 0 . phi_(j + 2) phi_(j + 3) . . . phi_n = 0 . phi_([ j + 2 : ])$ at the end of iteration $j + 1$. Then, at the start of iteration $j$, $theta arrow.l theta / 2 = 0.0 phi_(j + 2) phi_(j + 3) . . . phi_n$. Again using @eq:singular_value_reexpression, we see that $A_j ( theta )$ has singular value

$ sigma^j &= | cos ( pi ( 0 . phi_(j + 1) phi_(j + 2) . . . phi_n - 0.0 phi_(j + 2) phi_(j + 3) . . . phi_n ) ) | \
 &= | cos ( frac(pi, 2) phi_(j + 1) ) | = cases(
  1 & upright("if") phi_(j + 1) = 0,
  0 & upright("if") phi_(j + 1) = 1,
) , $

and so $Theta ( 1 / sqrt(2) - sigma^j ) = 1 - 2 phi_(j + 1)$. This is identical to the base case, and we ultimately find that the measurement of the auxiliary qubit will yield $phi_(j + 1)$, such that we set $theta_1 = phi_(j + 1)$. So at the end of this iteration, we have $theta = 0 . phi_(j + 1) phi_(j + 2) . . . phi_n = phi_([ j + 1 : ])$, as desired.

~◻

]

Considering the $j = 0$ iteration, we see that the final output of the algorithm is $theta = 0 . phi_1 phi_2 . . . phi_n = phi$, which completes the proof of @thm:n_geq_m.

=== $n < m$<sec:n_l_m>
If $n < m$, this algorithm will produce an $n$-bit approximation to $phi$ that suffers error at most $1 / 2^(n + 1)$. To show this, we first prove the following lemma.

#thmbox("theorem", "Lemma")[

If $phi$ is an $m > n$ bit number (including the case $m = oo$), then at the end of iteration $j gt.eq 0$, $theta = 0 . tilde(phi)_(j + 1) tilde(phi)_(j + 2) . . . tilde(phi)_n = 0 . tilde(phi)_([ j + 1 : ])$, such that $| tilde(r)_j . tilde(phi)_([ j + 1 : ]) - 0 . phi_([ j + 1 : ]) | lt.eq 2^(j - n - 1)$, where $tilde(r)_j . tilde(phi)_([ j + 1 : ])$ is attained by rounding $0 . phi_([ j + 1 : ])$ to $n - j$ binary decimals, and $tilde(r)^j$ is an additional bit carried over by this rounding.

] <lemma:n_l_m>

#block[
#emph[Proof.] As before, the proof proceeds by induction, albeit longer than the $n gt.eq m$ proof, but no more complicated. One minor difference is that we will still write expressions like $phi = 0 . phi_1 phi_2 . . . phi_m$ to indicate the binary expansion of $phi$, where it is to be understood that this will really be an infinite sequence in the case $m = oo$.

#emph[Base Case:] The base case is the $j = n - 1$ iteration, at which, $theta = 0$. Using @eq:singular_value_reexpression, we see that $A_j ( theta ) = A_(n - 1) ( 0 )$ has singular value

$ sigma^(n - 1) & = | cos ( pi ( 0 . phi_n phi_(n + 1) . . . phi_m - 0 ) ) |\
 & = | cos ( pi / 2 ( phi_n + 1 / 2 phi_(n + 1) + sum_(i = 2)^(m - n) 1 / 2^i phi_(n + i) ) ) | . $<eq:s_n1_expression>

We are not concerned with this exact value, but instead with the quantity $Theta ( 1 / sqrt(2) - sigma^(n - 1) )$, which is dictated by the values of $phi_n$ and $phi_(n + 1)$. In particular, the sum in @eq:s_n1_expression is bounded above by $1 / 2$, so it cannot affect $Theta ( 1 / sqrt(2) - sigma^(n - 1) )$ by itself. Let's look at each possible value of $phi_n$ and $phi_(n + 1)$.

First, if $phi_(n + 1) = 0$ (regardless of the value of $phi_n$), then this scenario is similar to the proof of @thm:n_geq_m, and we ultimately set $theta_1 = phi_n$. In addition, rounding $0 . phi_n phi_(n + 1) . . . phi_m = 0 . phi_n 0 phi_(n + 2) . . . phi_m$ to $n - j = 1$ decimal places yields $tilde(r)_(n - 1) . tilde(phi)_n = 0 . phi_n$, so indeed $theta = 0 . phi_n = 0 . tilde(phi)_n$. We then have that

$ | tilde(r)_(j - 1) . tilde(phi)_j - 0 . phi_([ j + 1 : ]) | = sum_(i = 2)^(m - n) & 1 / 2^(i + 1) phi_(n + i)\
 & lt.eq 1 / 4 = 2^(j - n - 1) , $

as desired.

On the other hand, if $phi_(n + 1) = 1$ and $phi_n = 0$, then $Theta ( 1 / sqrt(2) - sigma^(n - 1) ) = - 1$, which results in setting $theta_1 = 1$. Likewise, rounding $0 . phi_n phi_(n + 1) . . . phi_m = 0.01 phi_(n + 2) . . . phi_m$ to $n - j = 1$ decimal places yields $tilde(r)_(n - 1) . tilde(phi)_n = 0.1$, so indeed $theta = 0.1 = 0 . tilde(phi)_n$. We then have that

$  & | tilde(r)_j . tilde(phi)_(j + 1) - 0 . phi_([ j + 1 : ]) | = | 1 / 2 - 1 / 4 - sum_(i = 2)^(m - n) 1 / 2^(i + 1) phi_(n + i) | =\
 & | 1 / 4 - sum_(i = 2)^(m - n) 1 / 2^(i + 1) phi_(n + i) | lt.eq 1 / 4 = 2^(j - n - 1) , $

as desired.

Lastly, if $phi_(n + 1) = 1$ and $phi_n = 1$, then $Theta ( 1 / sqrt(2) - sigma^(n - 1) ) = 1$, which results in setting $theta_1 = 0$. In addition, rounding $0 . phi_n phi_(n + 1) . . . phi_m = 0.11 phi_(n + 2) . . . phi_m$ to $n - j = 1$ decimals yields $tilde(r)_(n - 1) . tilde(phi)_n = 1.0$, so indeed $theta = 0.0 = 0 . tilde(phi)_n$. We then have that

$  & | tilde(r)_j . tilde(phi)_(j + 1) - 0 . phi_([ j + 1 : ]) | = | 1 - 1 / 2 - 1 / 4 - sum_(i = 2)^(m - n) 1 / 2^(i + 1) phi_(n + i) |\
 & | 1 / 4 - sum_(i = 2)^(m - n) 1 / 2^(i + 1) phi_(n + i) | lt.eq 1 / 4 = 2^(j - n - 1) , $

as desired.

#emph[General Case:] Proceeding now to the general case, assume that this claim is true at the end of iteration $j + 1$ and all prior iterations. That is, $theta = 0 . tilde(phi)_(j + 2) tilde(phi)_(j + 3) . . . tilde(phi)_n$ at the end of iteration $j + 1$. Then, at the start of iteration $j$, $theta arrow.l theta / 2 = 0.0 tilde(phi)_(j + 2) tilde(phi)_(j + 3) . . . tilde(phi)_n$. Again using @eq:singular_value_reexpression, we see that $A_j ( theta )$ has singular value

$ sigma^j = & | cos ( pi ( 0 . phi_(j + 1) phi_(j + 2) . . . phi_m - theta ) ) | =\
 & | cos ( pi / 2 ( phi_(j + 1) + 1 / 2 ( phi_(j + 2) - tilde(phi)_(j + 2) ) +\
sum_(i = 3)^(n - j) 1 / 2^(i - 1) & ( phi_(j + i) - tilde(phi)_(j + i) ) + sum_(i = n - j + 1)^(m - j) 1 / 2^(i - 1) phi_(n + i) ) ) | . $

As before, we are interested in $Theta ( 1 / sqrt(2) - sigma^j )$, which, as we will see below, is dictated by the values of $phi_(j + 1) , med phi_(j + 2)$, and $tilde(phi)_(j + 2)$. Let's now look at the possible cases of these values.

First, if $tilde(phi)_(j + 2) = phi_(j + 2)$, then $Theta ( 1 / sqrt(2) - sigma^j )$ is dictated entirely by $phi_(j + 1)$, and so we ultimately set $theta_1 = phi_(j + 1)$. In addition, the condition $tilde(phi)_(j + 2) = phi_(j + 2)$ implies that no rounding occurred in the $j + 1$ iteration, so $tilde(r)_(j + 1) = 0$, and $tilde(r)_j . tilde(phi)_([ j + 1 : ]) = 0 . phi_(j + 1) phi_(j + 2) tilde(phi)_(j + 3) . . . tilde(phi)_n$ is the rounded value of $0 . phi_([ j + 1 : ])$. Therefore, we indeed have $theta = 0 . tilde(phi)_(j + 1) tilde(phi)_(j + 2) . . . tilde(phi)_n$, and also

$ | tilde(r)_j . tilde(phi)_(j + 1) - 0 . phi_(j + 1) | & = 1 / 2 | tilde(r)_(j + 1) . tilde(phi)_(j + 2) - 0 . phi_(j + 2) |\
 & lt.eq 1 / 2 2^(( j + 1 ) - n - 1) = 2^(j - n - 1) , $

where we have used the inductive hypothesis.

On the other hand, consider $tilde(phi)_(j + 2) = 1$ and $phi_(j + 2) = 0$. This condition implies that, at the $j + 1$ iteration, $0 . phi_([ j + 2 : ]) = 0.0 phi_(j + 3) . . . phi_m$ was rounded to $tilde(r)_(j + 1) . tilde(phi)_([ j + 2 : ]) = 0.1 tilde(phi)_(j + 3) . . . tilde(phi)_n$, which requires that $phi_(j + 3) = 1 = phi_(j + 4) = . . . phi_(n + 1)$ and $tilde(phi)_(j + 3) = 0 = tilde(phi)_(j + 4) = . . . = tilde(phi)_n$. Using these values, we see that $tilde(r)_j . tilde(phi)_([ j + 1 : ]) = 0 . phi_(j + 1) tilde(phi)_(j + 2) . . . tilde(phi)_n = 0 . phi_(j + 1) 100 . . .0$ is the rounded value of $phi^j$. In addition, inputting all of these values into $Theta ( 1 / sqrt(2) - sigma^j )$, we find that we will ultimately set $theta_1 = phi_(j + 1)$. Therefore, we indeed have $theta = 0 . tilde(phi)_(j + 1) tilde(phi)_(j + 2) . . . tilde(phi)_n$, and again

$ | tilde(r)_j . tilde(phi)_(j + 1) - 0 . phi_(j + 1) | & = 1 / 2 | tilde(r)_(j + 1) . tilde(phi)_(j + 2) - 0 . phi_(j + 2) |\
 & lt.eq 1 / 2 2^(( j + 1 ) - n - 1) = 2^(j - n - 1) , $

where we again used the inductive hypothesis.

Finally, consider $tilde(phi)_(j + 2) = 0$ and $phi_(j + 2) = 1$. This condition implies that, at the $j + 1$ iteration, $0 . phi_([ j + 2 : ]) = 0.1 phi_(j + 3) . . . phi_m$ was rounded to $tilde(r)_(j + 1) . tilde(phi)_([ j + 2 : ]) = 1.0 tilde(phi)_(j + 3) . . . tilde(phi)_n$, which requires that $phi_(j + 3) = 1 = phi_(j + 4) = . . . phi_(n + 1)$ and $tilde(phi)_(j + 3) = 0 = tilde(phi)_(j + 4) = . . . tilde(phi)_n$. Thus, if $phi_(j + 1) = 0$, then $tilde(r)_j . tilde(phi)_([ j + 1 : ]) = 0.100 . . . .0$ is the rounded value of $0 . phi_([ j + 1 : ]) = 0.011 . . .1 phi_(n + 2) . . . phi_m$. Inputting these values into $Theta ( 1 / sqrt(2) - sigma^j )$, we find that we will ultimately set $theta_1 = 1 = tilde(phi)_(j + 1) = 1 - phi_(j + 1)$. Therefore, we indeed have $theta = 0 . tilde(phi)_(j + 1) tilde(phi)_(j + 2) . . . tilde(phi)_n$, and also

$ | tilde(r)_j . tilde(phi)_(j + 1) & - 0 . phi_(j + 1) | = | 0.100 . . .0 - 0.011 . . .1 phi_(n + 2) . . . phi_m |\
 & = | 1 / 2 - sum_(i = 2)^(n - j + 1) 1 / 2^i - sum_(i = n - j + 2)^(m - j) 1 / 2^i phi_(j + i) |\
 & = | 1 / 2^(n - j + 1) - sum_(i = n - j + 2)^(m - j) 1 / 2^i phi_(j + i) | lt.eq 2^(j - n - 1) , $

Similarly, if $phi_(j + 1) = 1$, then $tilde(r)_j . tilde(phi)_([ j + 1 : ]) = 1.00 . . .0$ is the rounded value of $0 . phi_([ j + 1 : ]) = 0.11 . . .1 phi_(n + 2) . . . phi_m$. Inputting these values into $Theta ( 1 / sqrt(2) - sigma^j )$, we will ultimately set $theta_1 = 0 = tilde(phi)_(j + 1) = 1 - phi_(j + 1)$. Therefore, we indeed have $theta = 0 . tilde(phi)_(j + 1) tilde(phi)_(j + 2) . . . tilde(phi)_n$, and also

$ | tilde(r)_j . tilde(phi)_(j + 1) & - 0 . phi_(j + 1) | = | 1.00 . . .0 - 0.11 . . .1 phi_(n + 2) . . . phi_m |\
 & = | 1 - sum_(i = 1)^(n - j + 1) 1 / 2^i - sum_(i = n - j + 2)^(m - j) 1 / 2^i phi_(j + i) |\
 & = | 1 / 2^(n - j + 1) - sum_(i = n - j + 2)^(m - j) 1 / 2^i phi_(j + i) | lt.eq 2^(j - n - 1) , $

This proves the general case, and the entire proof is complete.

~◻

]

Furthermore, we must discuss the additional $j = 0$ iteration, which is just like that of the phase estimation by QSVT algorithm. The analysis of this iteration is identical to the case above, just with the modification that $phi_0 = 0$ because $phi < 1$. Ultimately, we find that this step usually will output $theta_0 = 0$, such that $theta = 0 . tilde(phi)_([ 1 : ])$. However, if $phi_1 = 1 = phi_2 = . . . = phi_(n + 1)$ and $tilde(phi)_1 = 0 = tilde(phi)_2 = . . . = tilde(phi)_n$, then this step will output $theta_0 = 1$, such that $theta = 1.00 . . .0$. This accounts for the possibility that $1.0$ is the best approximation to $phi$. For instance, the best 2-decimal approximation to $phi = 0.1110101$ is $theta = 1.00$. In either case,$theta$ still satisfies $| theta - phi | lt.eq 2^(- n - 1)$, as @lemma:n_l_m dictates at $j = 0$.

Finally, we mention one last caveat. It is possible that $sigma^j = 1 / sqrt(2)$, in which case the sign function is $0$, and we are equally likely to measure $0$ or $1$. However, this is not a problem, as the condition $sigma^j = 1 / sqrt(2)$ implies that $| 0 . phi_([ j + 1 : ]) - 0.0 tilde(phi)_([ j + 2 : ]) | = 0.1 = 1 / 2$, such that both $phi_(j + 1) = 0$ and $phi_(j + 1) = 1$ are equally accurate approximations, and so the inequality in @thm:n_l_m is still obeyed. This is analogous to conventional rounding, wherein one could round 0.5 to either 0 or 1 without changing the accuracy of the rounding. With these concerns alleviated, the proof of @thm:n_l_m is complete.

== @thm:Delta_restriction
<sec:Delta_mitigation>
Here, we prove the @thm:Delta_restriction from Section~#ref(<sec:PhaseEstimation_Caveats>, supplement: none):

#thmbox("theorem", "Theorem")[

If we choose $Delta$ such that

$ Delta < 2 (cos ( frac(3 pi, 16) ) - 1 / sqrt(2)) approx 0.25 . $

then an error due to $Delta$ can only occur at the $j = n - 1$ iteration. If an error is made at this iteration, then at the end of the algorithm, $| theta - phi | < 1 / 2^n$, assuming no errors are made at later iterations.

]

As discussed in Section~#ref(<sec:PhaseEstimation_Caveats>, supplement: none), we assume that we perform QSVT with a function that behaves as $P_(epsilon.alt , Delta)^Theta ( 1 / sqrt(2) - x )$ (for $x gt.eq 0$), which approximates the sign function. Recall that this approximation fails in the region $[ 1 / sqrt(2) - Delta / 2 , 1 / sqrt(2) + Delta / 2 ]$, which we dub “the $Delta$-region”. We show that the adverse effects of a finite sized $Delta$-region can be mitigated by choosing a sufficiently small $Delta$.

Throughout this section, we again use the notation $0 . phi_([ j : ]) := 0 . phi_j phi_(j + 1) . . .$ to denote a string of contiguous binary digits. We also use the definition of $tilde(r)_j$ from Section~#ref(<sec:n_l_m>, supplement: none).

To demonstrate our claim, recall that $sigma^j = | cos ( pi ( 0 . phi_([ j + 1 : ]) - theta ) ) |$ as per @eq:singular_value_reexpression. Whether or not $sigma^j$ is inside of the $Delta$-region is dictated by the value of $| 0 . phi_([ j + 1 : ]) - theta |$. In particular, in order for $sigma^j$ to be inside of the $Delta$-region, we require $| cos ( pi ( 0 . phi_([ j + 1 : ]) - theta ) ) | in [1 / sqrt(2) - Delta / 2 , 1 / sqrt(2) + Delta / 2]$, or equivalently,

$ pi | 0 . & phi_([ j + 1 : ]) - theta | in\
 & [arccos ( 1 / sqrt(2) + Delta / 2 ) , arccos ( 1 / sqrt(2) - Delta / 2 )]\
union & [arccos ( - 1 / sqrt(2) + Delta / 2 ) , arccos ( - 1 / sqrt(2) - Delta / 2 )] . $

We depict this condition graphically in @fig:DeltaRegion, which is a useful illustration for understanding the proof of this theorem.

// [figvision] imgs/fig_uncertain_region.png
// The figure has one panel. The plot is a schematic diagram of a semicircle. The semicircle is drawn with a
// solid black line and spans from 0 to /2 radians along the x and y axes, which are not explicitly shown but can
// be inferred from the angle labels. There are no numerical units on the axes. The regions where = 1 and = -1
// are labelled. The shaded regions are bounded by solid black lines and dashed grey lines and are labelled with
// inverse cosine expressions. The trend shows that the QSVT sequence returns an indeterminate measurement result
// in the shaded regions.
#figure(image("imgs/fig_uncertain_region.png", width: 100%),
  caption: [
    A depiction of a finite sized $Delta$-region and the resulting values of $Theta$. Shaded regions indicate where the application of the QSVT sequence returns an indeterminate measurement result (equivalently where the sign function is poorly approximated).
  ]
)
<fig:DeltaRegion>

As we show below, if we choose $Delta$ such that $sigma^j$ is within the $Delta$-region only if $| 0 . phi_([ j + 1 : ]) - theta | in ( 1 / 4 - 1 / 16 , med 1 / 4 + 1 / 16 ) union ( 3 / 4 - 1 / 16 , med 3 / 4 + 1 / 16 )$, then it is only possible for $sigma^j$ to be within the $Delta$-region at iteration $j = n - 1$. In order to enforce this constraint on the $Delta$-region, we require that

$ | 1 / pi arccos (1 / sqrt(2) plus.minus Delta / 2) - 1 / 4 | < 1 / 16 . $

As it turns out, the $+$ condition is actually more stringent, so we have the following lemma:

#thmbox("theorem", "Lemma")[

If we choose $Delta$ such that

$ (1 / 4 - 1 / pi arccos ( 1 / sqrt(2) + Delta / 2 )) < 1 / 16 , $

then $sigma^j$ can only be inside of the $Delta$-region at iteration $j = n - 1$.

] <lemma:Delta_restriction>

#block[
#emph[Proof.] To prove this, we will begin by analyzing the possible values of $sigma^j$. We assume that, if $sigma^j$ is outside of the $Delta$-region, then we can correctly determine $theta_1$ with high probability using an appropriate value of $epsilon.alt$ as in Section~#ref(<sec:PhaseEstimation_Caveats>, supplement: none). In addition, note that our restriction on $Delta$ implies that, in order for $sigma^j$ to be inside of the $Delta$-region, we must have $| 0 . phi_([ j + 1 : ]) - theta | in ( 1 / 4 - 1 / 16 , med 1 / 4 + 1 / 16 ) union ( 3 / 4 - 1 / 16 , med 3 / 4 + 1 / 16 )$

First, let $j = n - 1$ and suppose that we can correctly determine $theta_1$ (either $sigma^j$ is outside of the $Delta$-region, or $sigma^j$ is inside of the $Delta$-region and we get lucky). Next, proceed to iteration $j = n - 2$. If $tilde(r)_(n - 1) = 0$ at the previous iteration, then @lemma:n_l_m implies that,

$ | 0 . phi_([ n - 1 : ]) & - theta | = | 0 . phi_([ n - 1 : ]) - 0 . tilde(r)_(n - 1) tilde(phi)_(n :) |\
in & [0 . phi_(n - 1) - 1 / 2 2^(n - 1 - n - 1) , med 0 . phi_(n - 1) + 1 / 2 2^(n - 1 - n - 1)]\
= & [0 . phi_(n - 1) - 1 / 8 , med 0 . phi_(n - 1) + 1 / 8] . $

For either possible value of $phi_(n - 1)$, the restriction on $Delta$ implies that the corresponding value of $sigma^(n - 2)$ is not within the $Delta$-region, and so we can correctly determine $theta_1$ with high probability at this iteration.

On the other hand, if $tilde(r)_(n - 1) = 1$, then $0 . phi_([ n : ]) > 0.11$ and $theta = 0$. At iteration $j = n - 2$, we have

$ | 0 . phi_([ n - 1 : ]) - theta | = 0 . phi_([ n - 1 : ]) > 0 . phi_(n - 1) 11 . $

Again, because $0.011 = 1 / 4 + 1 / 8 > 1 / 4 + 1 / 16$, the corresponding value of $sigma^(n - 2)$ is not within the $Delta$-region for either possible value of $phi_(n - 1)$, and so we can correctly determine $theta_1$ with high probability at this iteration.

By inductively following this logic to further iterations, we see that, if we can correctly determine $theta_1$ at iteration $j = n - 1$, then the subsequent values of $sigma^j$ will not be in the $Delta$-region, and the corresponding values of $theta_1$ can be correctly determined with high probability.

Next, again let $j = n - 1$ and now suppose that $sigma^j$ is inside of the $Delta$-region, such that we choose an incorrect value for $theta_1$. First, consider the case in which $1 / 4 < 0 . phi_([ n : ]) < 1 / 4 + 1 / 16$, and we make an error by setting $theta_1 = 0$. Then at iteration $j = n - 2$,

$ | 0 . phi_([ n - 1 : ]) - theta | = 0 . phi_(n - 1) phi_([ n : ]) $<eq:delta_iter_eq>

This is bounded below by $0 . phi_(n - 1) + 1 / 8$ and above by $0 . phi_(n - 1) + 1 / 8 + 1 / 32$, so $sigma^(n - 2)$ does not fall within the $Delta$-region. Hence, despite our initial error, the correct value for $theta_1$ may be determined with high probability at the next iteration. As per the result of the previous paragraphs, this indicates that, with high probability, $sigma^j$ will not be inside the $Delta$-region at later iterations.

Next, consider the case in which $1 / 4 - 1 / 16 < 0 . phi_([ n : ]) < 1 / 4$, and we make an error by setting $theta_1 = 1$. Then at iteration $j = n - 2$,

$ 0 . phi_([ n - 1 : ]) - 0.01 = 0 . phi_(n - 1) phi_([ n : ]) - 0.01 . $

This is bounded below by $0 . phi_(n - 1) - 1 / 8 - 1 / 32$ and above by $0 . phi_(n - 1) - 1 / 8$, so again $sigma^(n - 2)$ does not fall within the $Delta$-region.

Finally, we note that the cases in which $3 / 4 < 0 . phi_([ n : ]) < 3 / 4 + 1 / 16$ and $3 / 4 - 1 / 16 < 0 . phi_([ n : ]) < 3 / 4$ are analogous to the two cases illustrated above, and we ultimately find that $sigma^(n - 2)$ is not within the $Delta$-region.

~◻

]

This theorem tells us that, if $Delta$ is made sufficiently small, then we are only plagued by the $Delta$-region at iteration $j = n - 1$. At all other iterations, $sigma^j$ will not be within the $Delta$-region, and we can correctly determine $theta_1$ with high probability. Thus, if at iteration $j = n - 1$, $sigma^(n - 1)$ is within the $Delta$-region and we do make an error, then our approximation of $0 . phi_([ n : ])$ is incorrect by some amount $< 1 / 4 + 1 / 16 < 1 / 2$, so the overall error in our estimate of $phi$ will be $< 1 / 2^n$ (with high probability).

Lastly, if we rearrange the inequality in @lemma:Delta_restriction, then we see that the necessary restriction on $Delta$ must be

$ Delta < 2 (cos ( frac(3 pi, 16) ) - 1 / sqrt(2)) approx 0.25 . $

So if we satisfy this constraint, then we can we can guarantee that the algorithm will succeed with high probability and suffer error $< 1 / 2^n$. This proves @thm:Delta_restriction.

As a corollary, suppose more generally that we choose $Delta$ such that $(1 / 4 - 1 / pi arccos ( 1 / sqrt(2) + Delta / 2 )) < gamma$ for some $gamma > 0$. In order for $sigma^j$ to be inside of the $Delta$-region under this constraint, we must have $| 0 . phi_([ j + 1 : ]) - theta | in ( 1 / 4 - gamma , med 1 / 4 + gamma ) union ( 3 / 4 - gamma , med 3 / 4 + gamma )$. Then, suppose that $sigma^(n - 1)$ is inside the $Delta$-region such that $1 / 4 < 0 . phi_([ n : ]) < 1 / 4 + gamma$, and we make an error by setting $theta_1 = 0$. Then at iteration $j = n - 2$,

$ | 0 . phi_([ n - 1 : ]) - theta | = 0 . phi_(n - 1) phi_([ n : ]) , $

which is bounded below by $0 . phi_(n - 1) + 1 / 8$ and above by $0 . phi_([ n - 1 : ]) + 1 / 8 + gamma / 2$. Hence this quantity is necessarily a distance $1 / 4 - gamma - ( 1 / 8 + gamma / 2 ) = 1 / 8 - frac(3 gamma, 2)$ from the $Delta$-region, and this distance increases at later iterations. Identical bounds hold for the other cases that $sigma^(n - 1)$ is in the $Delta$-region. In this sense, the quantity $0 . phi_([ j + 1 : ])$ can suffer an additive error of magnitude $< 1 / 8 - frac(3 gamma, 2)$, and the phase estimation algorithm will still output a $theta$ such that $| phi - theta | < 1 / 2^n$ with high probability, as claimed in Section~#ref(<sec:PhaseEstimation_Robust>, supplement: none).

= CONSTRUCTION OF THE MATRIX INVERSION POLYNOMIAL
<sec:matrix_inversion_polynomial>

As we described in Sec.~#ref(<sec:matrix_inversion>, supplement: none), in order to invert a matrix with QSVT, we desire an $frac(epsilon.alt, 2 kappa)$-approximation to $frac(1, 2 kappa) 1 / x$, where $kappa$ is the condition number of the matrix to be inverted. Gilyén et al. design such a polynomial by first noting that the function

$ g_(epsilon.alt , kappa) ( x ) = frac(1 - ( 1 - x^2 )^b, x) $

provides a good approximation to $1 / x$ over the range $x in [ - 1 , 1 ] [ frac(- 1, kappa) , 1 / kappa ]$ for large $b$. In particular, for $0 < epsilon.alt < 1 / 2$, $g_(epsilon.alt , kappa) ( x ) epsilon.alt$-approximates $1 / x$ over the range $x in [ - 1 , 1 ] [ frac(- 1, kappa) , 1 / kappa ]$ for $b ( epsilon.alt , kappa ) = ceil.l kappa^2 log ( kappa / epsilon.alt ) ceil.r$~@Gily_n_2019 @Childs_2017.

Next, although $g_(epsilon.alt , kappa) ( x )$ is not a polynomial, it can be $epsilon.alt$-approximated over the range $x in [ - 1 , 1 ]$ by the polynomial

$ P_(2 epsilon.alt , kappa)^(1 / x) ( x ) = 4 sum_(j = 0)^D ( - 1 )^j [2^(- 2 b) sum_(i = j + 1)^b binom(2 b, b + i)] T_(2 j + 1) ( x ) , $<eq:1OverxPoly>

where $T_i ( x )$ is the Chebyshev polynomial of order $i$ and $D ( epsilon.alt , kappa ) = ceil.l sqrt(b ( epsilon.alt , kappa ) log ( 4 b ( epsilon.alt , kappa ) / epsilon.alt )) ceil.r = cal(O) ( kappa log ( kappa / epsilon.alt ) )$ is the degree of this polynomial~@Gily_n_2019. In addition, by the triangle inequality, $P_(2 epsilon.alt , kappa)^(1 / x) ( x )$ is a $2 epsilon.alt$-approximation to $1 / x$ for $x in [ - 1 , 1 ] [ frac(- 1, kappa) , 1 / kappa ]$, hence the subscript $2 epsilon.alt$. To provide intuition, we illustrate this polynomial in @fig:MatrixInversionPolynomial.

At this stage, we may suspect that our candidate polynomial is $frac(1, 2 kappa) P_(epsilon.alt / 2 , 2 kappa)^(1 / x) ( x )$, which $epsilon.alt$-approximates $frac(1, 2 kappa) 1 / x$ for $x in [ - 1 , 1 ] [ frac(- 1, 2 kappa) , frac(1, 2 kappa) ]$. In addition, for $epsilon.alt < 1 / 2$, this polynomial is necessarily bounded in magnitude by $1$ for $x in [ - 1 , 1 ] [ frac(- 1, kappa) , 1 / kappa ]$, which is easily seen via the triangle inequality. Unfortunately however, this candidate polynomial is not necessarily bounded for $x in [ frac(- 1, 2 kappa) , frac(1, 2 kappa) ]$. In particular, the approximation of @eq:1OverxPoly obeys~@Childs_2017 @Gily_n_2019

$ max_(x in [ - 1 , 1 ]) | P_(epsilon.alt , kappa)^(1 / x) ( x ) | lt.eq 4 D ( epsilon.alt , kappa ) = cal(O) ( kappa log ( kappa / epsilon.alt ) ) , $

so our candidate polynomial is only bounded in magnitude by $frac(1, 2 kappa) 4 D ( epsilon.alt / 2 , 2 kappa ) = cal(O) ( log ( kappa / epsilon.alt ) )$, which is not necessarily $1$.

Therefore, to enforce that the magnitude of the candidate polynomial be bounded, we may multiply it by an even function that is close to $1$ for $x in [ - 1 , 1 ] [ frac(- 1, kappa) , 1 / kappa ]$, and close to $0$ for $x in [ frac(- 1, 2 kappa) , frac(1, 2 kappa) ]$, letting the range $x in [ frac(- 1, kappa) , frac(- 1, 2 kappa) ] union [ frac(1, 2 kappa) , 1 / kappa ]$ be a transition region between these two values. Such a rectangular function may be polynomially approximated by a linear combination of the step function approximations of Section~#ref(<sec:Search>, supplement: none):

$ P_(epsilon.alt , kappa)^(upright("rect")) ( x ) & :=\
frac(1, 1 + epsilon.alt / 2) & (1 + 1 / 2 (P_(epsilon.alt , frac(1, 4 kappa))^Theta (x - frac(3, 4 kappa)) + P_(epsilon.alt , frac(1, 4 kappa))^Theta (- x - frac(3, 4 kappa)))) , $

which is easily seen to obey

$ P_(epsilon.alt , kappa)^(upright("rect")) ( x ) in [ 1 - epsilon.alt , 1 ] med med forall x in [ - 1 , 1 ] \ [ frac(- 1, kappa) , 1 / kappa ]\
P_(epsilon.alt , kappa)^(upright("rect")) ( x ) in \[ 0 , epsilon.alt \] med med forall x in \[ frac(- 1, 2 kappa) , frac(1, 2 kappa) \] $

and has even degree $cal(O) ( kappa log ( 1 / epsilon.alt ) )$. In the in-between region $x in [ frac(- 1, kappa) , frac(- 1, 2 kappa) ] union [ frac(1, 2 kappa) , 1 / kappa ]$, $P_(epsilon.alt , kappa)^(upright("rect")) ( x )$ transitions between values close to 0 and close to 1, remaining bounded in magnitude by $1$ throughout. We illustrate the behavior of this polynomial in Fig~#ref(<fig:MatrixInversionPolynomial>, supplement: none).

Therefore, our target polynomial is the #emph[matrix inversion polynomial]:

$ P_(epsilon.alt , kappa)^(upright("MI")) ( x ) := frac(1, 2 kappa) P_(1 / 2 epsilon.alt , 2 kappa)^(1 / x) ( x ) P_(epsilon.alt' , kappa)^(upright("rect")) ( x ) $<eq:1OverxApprox>

where $epsilon.alt' = upright("min") (frac(2 epsilon.alt, 5 kappa) , frac(kappa, 2 D ( epsilon.alt / 4 , 2 kappa ))) = cal(O) (epsilon.alt / kappa)$. We illustrate this polynomial in Fig~#ref(<fig:MatrixInversionPolynomial>, supplement: none). In defining $epsilon.alt'$, the term $frac(2 epsilon.alt, 5 kappa)$ ensures that this polynomial is an $frac(epsilon.alt, 2 kappa)$-approximation to $frac(1, 2 kappa) 1 / x$ over the range of possible singular values, and the term $frac(kappa, 2 D ( epsilon.alt / 4 , 2 kappa ))$ ensures that $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ is bounded in magnitude by 1 for $x in [ frac(- 1, kappa) , 1 / kappa ]$. Indeed, over the range $x in [ - 1 , 1 ] [ frac(- 1, kappa) , 1 / kappa ]$, $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ is an $frac(epsilon.alt, 2 kappa)$-approximation to $frac(1, 2 kappa) 1 / x$:

$  & lr(|P_(epsilon.alt , kappa)^(upright("MI")) ( x ) - frac(1, 2 kappa) 1 / x|) lt.eq frac(1, 2 kappa) lr(|P_(1 / 2 epsilon.alt , 2 kappa)^(1 / x) ( x ) ( 1 - epsilon.alt' ) - 1 / x|)\
 & lt.eq frac(1, 2 kappa) (lr(|P_(1 / 2 epsilon.alt , 2 kappa)^(1 / x) ( x ) - 1 / x|) + epsilon.alt' lr(|P_(1 / 2 epsilon.alt , 2 kappa)^(1 / x) ( x )|))\
 & lt.eq frac(1, 2 kappa) (epsilon.alt / 2 + frac(2 epsilon.alt, 5 kappa) (kappa + epsilon.alt / 2))\
 & lt.eq frac(1, 2 kappa) (epsilon.alt / 2 + frac(2 epsilon.alt, 5) + epsilon.alt / 10) = frac(epsilon.alt, 2 kappa) $

where we have used the (loose) bound $epsilon.alt / kappa < 1 / 2$. Likewise, $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ is bounded above by $1$ for $x in [ frac(- 1, 2 kappa) , frac(1, 2 kappa) ]$:

$ lr(|P_(epsilon.alt , kappa)^(upright("MI")) ( x )|) lt.eq frac(1, 2 kappa) 4 D (epsilon.alt / 4 , 2 kappa) epsilon.alt' lt.eq 1 . $

Similarly, for the in-between region $x in [ frac(- 1, kappa) , frac(- 1, 2 kappa) ] union [ frac(1, 2 kappa) , 1 / kappa ]$, both components of $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ are bounded in magnitude by $1$, so $| P_(epsilon.alt , kappa)^(upright("MI")) ( x ) | lt.eq 1$.

// [figvision] imgs/fig_inverse_function_new.png
// (a) This is a plot of P_{{1}{2} , 2}^{1/x}(x). The x-axis ranges from -{1}{} to {1}{} and the y-axis from -1
// to 1. The plot shows one black solid line. There are vertical solid black lines at x=0 and grey dashed lines
// at x=-{1}{}, -{1}{2}, {1}{2}, {1}{}. The curve has a sharp peak at x=0 and decreases as x moves away from 0,
// crossing the x-axis at x={1}{2}. (b) This is a plot of P_{', }^{{rect}}(x). The x-axis ranges from -{1}{} to
// {1}{} and the y-axis from -1 to 1. The plot shows one black solid line. There are grey dashed lines at
// x=-{1}{}, -{1}{2}, {1}{2}, {1}{}. The curve is approximately 0 everywhere except near x={1}{2} where it
// increases to 1 and then back down to 0. (c) This is a plot of P_{, }^{{MI}}(x) and the target. The x-axis
// ranges from -{1}{} to {1}{} and the y-axis from -1 to 1. The plot shows one black solid line and one blue
// solid line. There are grey dashed lines at x=-{1}{}, -{1}{2}, {1}{2}, {1}{}. The black curve has oscillations
// that decay as x increases. The blue curve decreases as x increases, with a sharp drop near x=0. The two curves
// intersect near x={1}{}.
#figure(image("imgs/fig_inverse_function_new.png", width: 100%),
  caption: [
    A sketch of (a) $P_(1 / 2 epsilon.alt , 2 kappa)^(1 / x) ( x )$, (b) $P_(epsilon.alt' , kappa)^(upright("rect")) ( x )$, and (c) $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$ for $kappa = 2.5$. The resulting polynomial, $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$, is a degree $77$ approximation to the inverse function.
  ]
)
<fig:MatrixInversionPolynomial>

Finally, it is easy to compute the degree of $P_(epsilon.alt , kappa)^(upright("MI")) ( x )$, which is the sum of the degrees of $P_(1 / 2 epsilon.alt , 2 kappa)^(1 / x) ( x )$ and $P_(epsilon.alt' , kappa)^(upright("rect")) ( x )$:

$ d = cal(O) ( kappa log ( kappa / epsilon.alt ) + kappa log ( 1 / epsilon.alt' ) ) = cal(O) (kappa log ( kappa / epsilon.alt )) . $

= QSP PHASE ANGLE SEQUENCE EXAMPLES
<sec:qsp_angle_examples>

Presented in this appendix are some explicit polynomials and corresponding QSP phase angles, for functions which are useful in quantum signal processing applications. These are not necessarily the optimal polynomials, nor the best QSP phase angles, but they are pedagogically clear starting points. Unless otherwise specified, all QSP phases are given in the $( W_x , S_z , chevron.l + | dot.op | + | ) chevron.r$-QSP convention. All the code for generating these phase angles is available in the `pyqsp` open source repository on GitHub#footnote[#link("https://github.com/ichuang/pyqsp")[`https://github.com/ichuang/pyqsp`]].

== Oblivious amplitude amplification
<sec:appx_fpsearch>

For fixed point search or oblivious amplitude amplification, it is desired to make a polynomial which maps $a$ as close as possible to $1$, for a wide range of small values of $a$, starting as close to $a = 0$ as possible.

One sequence of phases which accomplishes this optimally, with error $1 - delta^2$, is given for $k = 0 , 1 , dots.h , d - 1$ by

$ phi.alt_(2 k) & = & alpha_(d - k - 1)\
phi.alt_(2 k + 1) & = & alpha_(k + 1) $

where

$ alpha_k = - cot^(-1) ( sqrt(1 - gamma^2) tan frac(2 pi (k + 1), L) ) $

and $L = 2 d + 1$ and $gamma^(- 1) = T_(1 / L) ( 1 / delta ) = cosh^(- 1) ( 1 / delta ) / cosh ( 1 / L )$ @PhysRevLett.113.210501.

For example, for $d = 10$ and $delta = 0.5$, the QSP phase angles are:

```
pyqsp --plot-positive-only --plot-probability 
--plot-tight-y --plot-npts=400 
--seqargs=10,0.5 --plot fpsearch
```

```
-1.58023603 -1.55147987 -1.6009483 -1.52812171 -1.62884337 -1.49242141 -1.67885248 -1.41255145 -1.8386054 -0.87463828 -0.87463828 -1.8386054 -1.41255145 -1.67885248 -1.49242141 -1.62884337 -1.52812171 -1.6009483 -1.55147987 -1.58023603
```

The corresponding response function is shown in @fig:example_amplification.

// [figvision] imgs/PLOT_pyqsp_fpsearch_d_10_delta_0_5.png
// The figure shows a plot of oblivious amplification. The plot has one series, a black line, representing
// abs\[Poly(a)\]^2. The x-axis is labeled "a" and ranges from 0.0 to 1.0. The y-axis is labeled "response" and
// ranges from 0.0 to 1.0. The curve starts at (0, 0), increases to approximately (0.7, 1), then decreases
// slightly to (1, 0.9). There is a legend in the bottom right corner indicating the line style and color. No
// additional annotations or labels are present. The trend shows an initial increase followed by a slight
// decrease.
#figure(image("imgs/PLOT_pyqsp_fpsearch_d_10_delta_0_5.png", width: 100%),
  caption: [
    Transition probability using the polynomial for oblivious amplification for $d = 10$ and $delta = 0.5$.
  ]
)
<fig:example_amplification>

== Sign function
<sec:appx_sign_func>

The sign function $Theta ( a )$ has a number of applications for quantum signal processing. As discussed in Section~#ref(<sec:Search>, supplement: none), a robust polynomial approximation of it can be obtained using the error function

$ Theta ( a ) approx upright("erf") ( k a ) thin , $

where $k$ is a (large) scaling factor.

For example, the QSP phase angles obtained using an $d = 19$ order approximation with $k = 10$ are

```
pyqsp --plot-real-only --plot-npts=400 
--seqargs=19,10 --plot poly_sign
```

```
0.01558127 -0.01805798 0.05705643 -0.01661832 0.16163773 0.09379074 -2.62342885 0.49168481 0.92403822 -0.09696846 -0.09696846 0.92403822 0.49168481 -2.62342885 0.09379074 0.16163773 -0.01661832 0.05705643 -0.01805798 1.5863776
```

The corresponding response function is shown in @fig:example_sign. For $a > 0$, this sign function approximation may be employed as a step function, e.g. for oblivious amplitude amplification.

// [figvision] imgs/PLOT_pyqsp_sign_poly_degree_19_kappa_10.png
// The figure shows a plot of the response function for the polynomial approximation to the sign function. ###
// Panel description The plot has a single panel. It is a line plot showing two series. The x-axis represents 'a'
// and ranges from -1.00 to 1.00. The y-axis represents 'response' and ranges from -1.0 to 1.0. The series are: -
// A dashed grey line representing the 'target function', which is a step function with a value of -1 for a < 0
// and 1 for a ≥ 0. - A solid black line representing 'Re[Poly(a)]', which is a smooth curve that approximates
// the target function. The trend shows that 'Re[Poly(a)]' closely approximates the target function, with some
// minor deviation near a = 0. The message is that the polynomial approximation effectively models the sign
// function.
#figure(image("imgs/PLOT_pyqsp_sign_poly_degree_19_kappa_10.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the sign function with $d = 19$ and $k = 10$.
  ]
)
<fig:example_sign>

== Matrix inversion using $1 / a$<matrix-inversion-using-1a>

The $1 / a$ function is useful for computing Moore-Penrose pseudoinverses of matrices using the quantum singular value transform. As discussed in Section~#ref(<sec:matrix_inversion>, supplement: none), Chebyshev polynomials may be employed to approximate this function @Childs_2017.

For example, with $kappa = 3$ and $epsilon.alt = 0.3$, a set of QSP phase angles for this polynomial is:

```
pyqsp --plot-real-only --plot-npts=400 
--seqargs=3,0.3 --plot invert
```

```
-0.27237279 -1.8808697 2.19755533 -0.860515 0.84659086 0.62794236 -0.69688032 -0.62874403 0.7406656 0.44483992 -0.60489363 -0.60489363 0.44483992 0.7406656 -0.62874403 -0.69688032
0.62794236 0.84659086 -0.860515 -0.94403733
1.26072295 1.29842354
```

The corresponding response function is shown in @fig:example_inverse.

// [figvision] imgs/PLOT_pyqsp_invert_kappa_3_epsilon_0_3.png
// The figure shows a plot with one panel labeled "Inversion". The plot has a y-axis labeled "response" with a
// range from -0.50 to 0.50 in increments of 0.25, and an x-axis labeled "a" with a range from -1.00 to 1.00 in
// increments of 0.25. There are two series: a dashed gray line representing the "target function" and a solid
// black line representing "Re[Poly(a)]". The target function starts near the origin, decreases to a minimum
// below -0.50 at about -0.75, then increases. The Re[Poly(a)] starts near -0.20, decreases to a minimum about
// -0.40 at -0.25, then increases to a maximum about 0.50 at 0.30, and finally decreases to about 0.20 at 1.00.
// The trend shows that Re[Poly(a)] approximates the target function, with deviations for large negative and
// positive values of "a".
#figure(image("imgs/PLOT_pyqsp_invert_kappa_3_epsilon_0_3.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the inverse function with $kappa = 3$ and $epsilon.alt = 0.3$.
  ]
)
<fig:example_inverse>

== Cosine and sine functions for Hamiltonian simulation
<subsec:hamsim_func>

For Hamiltonian simulation, we seek an approximation to $e^(- i a t)$. As discussed in Section~#ref(<sec:HamiltonianSimulation>, supplement: none), this can be accomplished using the Jacobi-Anger approximations of $cos ( a t )$ and $sin ( a t )$ of @eq:Jacobi-Anger1 and~@eq:Jacobi-Anger2. The approximation is chosen to sufficient degree so as to bound the error to $epsilon.alt > 0$ in the region $a in [ - 1 , 1 ]$.

For example, with $t = 5$ and $epsilon.alt = 0.1$, a set of QSP phase angles for the approximation to $cos ( a t )$ are

```
pyqsp  --plot-real-only --plot-npts=400 
--seqargs=10,0.1 --plot hamsim
```

```
-1.70932079 -0.05312746 2.12066859 -0.83307065 -0.50074601 0.40728859 0.32838472 0.9142489 -2.81320793 0.40728859 -0.50074601 2.30852201
-1.02092406 -0.05312746 3.00306819
```

The corresponding response function is shown in @fig:example_hamsim-cosine.

// [figvision] imgs/PLOT_pyqsp_hamsim_cosine_tau_5_epsilon_0_1_2.png
// The figure shows a plot of the response function for the polynomial approximation to the cosine function. The
// plot has a single curve. The x-axis ranges from -1.00 to 1.00 with no units specified. The y-axis ranges from
// -0.50 to 0.50 with no units specified. There are two series: a dashed gray line labeled "target function" and
// a solid black line labeled "Re[Poly(a)]". The trend shows that the response function oscillates between -0.50
// and 0.50 as 'a' varies from -1.00 to 1.00. The target function and Re[Poly(a)] are nearly identical.
#figure(image("imgs/PLOT_pyqsp_hamsim_cosine_tau_5_epsilon_0_1_2.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the cosine function with $t = 5$ and $epsilon.alt = 0.1$.
  ]
)
<fig:example_hamsim-cosine>

Similarly, the QSP phases for the approximation to $sin ( a t )$ are:

```
[-1.63276817  0.20550406 -0.84198335  0.39732059 
 -0.26820613  2.41324245  0.04662674 -2.02847501  
  1.11311765  0.04662674 -0.72835021 -0.26820613
  0.39732059 -0.84198335  0.20550406 -0.06197184]
```

The corresponding response function is shown in @fig:example_hamsim-sine.

// [figvision] imgs/PLOT_pyqsp_hamsim_sine_tau_5_epsilon_0_1_2.png
// The figure shows a plot comparing the target function, presumably the sine function, with the real part of its
// polynomial approximation, denoted as Re[Poly(a)]. a. The plot has a single panel. The plot has "response" on
// the y-axis, ranging from -0.75 to 0.75, and "a" on the x-axis, ranging from -1.00 to 1.00. There are two
// series: a dashed grey line representing the target function and a solid black line representing Re[Poly(a)].
// The lines are smooth and wavy, with no symbols. The trend shows that both series closely match, oscillating
// between approximately -0.55 and 0.55. The message is that the polynomial approximation accurately represents
// the target function.
#figure(image("imgs/PLOT_pyqsp_hamsim_sine_tau_5_epsilon_0_1_2.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the sine function with $t = 5$ and $epsilon.alt = 0.1$.
  ]
)
<fig:example_hamsim-sine>

== Threshold function
<subsec:thresh_func>

Distinguishing eigenvalues and singular values may be performed using a step function, which we will take to be $upright("step") ( a - 1 / 2 )$ for illustrative purposes. This may be polynomially approximated using a Taylor series expansion of

$ upright("step") ( a - 1 / 2 ) & approx\
1 / 2 ( upright("erf") & ( k ( a + 1 / 2 ) ) - upright("erf") ( k ( a - 1 / 2 ) ) ) , $

which becomes a good approximation for large $k$.

For example, with $k = 10$ and using a degree $d = 18$ Taylor series, a set of QSP phase angles for this polynomial is:

```
pyqsp --plot-real-only --plot-npts=400 
--seqargs=18,10 --plot poly_thresh
```

```
0.73930816 -0.69010006 -0.63972139 -0.47754554 0.81797049 0.09205065 -0.87660105 0.13460844 0.23892207 1.32216648 -2.90267058 0.13460844
2.2649916 0.09205065 -2.32362216 2.66404712 -0.63972139 -0.69010006 2.31010449
```

The corresponding response function is shown in @fig:example_threshold.

// [figvision] imgs/PLOT_pyqsp_threshold_poly_deg_18_kappa_10.png
// The figure shows a plot of the threshold function. The x-axis represents 'a' and ranges from -1.00 to 1.00.
// The y-axis represents 'response' and ranges from 0.0 to 0.8. There are two series: a grey dashed line
// representing the 'target function' and a black solid line representing 'Re[Poly(a)]'. The target function is a
// rectangular function with a value of 0.0 for |a| > 0.5 and 0.8 for |a| < 0.5. The Re[Poly(a)] line starts at
// 0.0, increases to 0.8 at a = -0.5, oscillates around 0.8 until a = 0.5, then decreases back to 0.0 at a = 0.5,
// and remains at 0.0 for a > 0.5. The trend shows that Re[Poly(a)] approximates the target function with
// oscillations.
#figure(image("imgs/PLOT_pyqsp_threshold_poly_deg_18_kappa_10.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the threshold function with $k = 10$ and $d = 18$.
  ]
)
<fig:example_threshold>

Note that this is an even function of $a$, but it may be used just in the region $a gt.eq 0$, e.g. to distinguish singular values that are above or below $1 / 2$. It can be made as sharp as desired by increasing $k$ and the degree of the polynomial.

== Linear amplitude amplification
<subsec:linear_amplification>

Linear amplitude amplification is a subroutine useful for a number of quantum algorithms including simulation. The goal is to multiply inputs by a constant $1 / 2 Gamma$ for $Gamma in paren.l 0 , 1 / 2 bracket.r$. As is usual for QSP, the absolute value of the output must bounded by $1$ and therefore we seek a polynomial approximation that performs the linear amplification only for small inputs. We can obtain a suitable approximation by truncating the Taylor expansion of

$ upright("linear_amplification") ( a , Gamma ) &approx \n  frac(a, 2 Gamma) times 1 / 2 ( upright("erf") & ( k ( a + 2 Gamma ) ) - upright("erf") ( k ( a - 2 Gamma ) ) ) , $

where $k$ is chosen to obtain the desired accuracy within the region $[ - Gamma , Gamma ]$. This approximation is described in further detail in~@low2017quantum.

For example, with $Gamma = 0.25$ and using a degree $d = 19$ Taylor series, a set of QSP phase angles for this polynomial is:

```
pyqsp --plot-real-only --plot-npts=400 
--seqargs=19,0.25 --plot poly_linear_amp
```

```
0.07658557 -0.01961714 -0.10257913 0.08269406 0.16291683 0.43552219 -2.62323892 2.61402960 0.02001814 -2.21710253 0.92449012 0.02001814 -0.52756304 0.51835372 0.43552219 0.16291683 0.08269406 -0.10257913 -0.0196171 -1.49421074
```

The corresponding response function is shown in @fig:example_linamp.

// [figvision] imgs/PLOT_pyqsp_linamp_poly_deg_19_gamma_0_25.png
// The figure shows a plot of the response function for the linear amplification polynomial. ### Panel
// description The plot has a y-axis labeled "response" with a range of -1.0 to 1.0 and an x-axis labeled "a"
// with a range of -1.00 to 1.00. There are two series: a dashed gray line representing the "target function" and
// a solid black line representing "Re[Poly(a)]". The target function is a straight line with a positive slope,
// crossing the origin. The Re[Poly(a)] line starts near zero at a=-1, decreases to a minimum below -1 at a=-0.5,
// increases to a maximum above 1 at a=0.5, and then decreases back to near zero at a=1. The trend shows that
// Re[Poly(a)] tracks the target function for a between 0 and 0.5 but deviates significantly outside this range.
#figure(image("imgs/PLOT_pyqsp_linamp_poly_deg_19_gamma_0_25.png", width: 100%),
  caption: [
    Response function for the linear amplification polynomial with $Gamma = 0.25$ and $d = 19$.
  ]
)
<fig:example_linamp>

== Phase estimation polynomial
<subsec:phase_est_func>

Similar to the threshold function is the phase estimation polynomial of @eq:SignFunction_Target used in Section~#ref(<sec:PhaseEstimation>, supplement: none).

For example, with $Delta = 10$ and using a degree $d = 18$ Taylor series, a set of QSP phase angles for this polynomial in the $( W_x , S_z , chevron.l + | dot.op | + | ) chevron.r$-QSP convention is:

```
pyqsp --plot-real-only --plot-npts=400 
--seqargs=18,10 --plot poly_phase
```

```
-2.69295576 0.92644177 -2.47601161 -2.95790072 -3.07710363 2.40352005 2.38432687 -3.0712802 -2.54668308 -0.87407521 0.59490957 -3.0712802
-0.75726578 2.40352005 -3.07710363 -2.95790072 -2.47601161 0.92644177 2.01943322
```

The corresponding response function is shown in @fig:example_phase_--.

// [figvision] imgs/PLOT_pyqsp_phase_poly_deg_18_kappa_10.png
// The figure shows a plot with one panel. The plot has a solid black line and a dashed grey line. The y-axis
// ranges from -1.0 to 1.0 in increments of 0.5, labelled "response". The x-axis ranges from -1.00 to 1.00 in
// increments of 0.25, labelled "a". The solid black line represents Re[Poly(a)], and the dashed grey line
// represents the target function. The plot shows that the solid black line closely follows the dashed grey line,
// with a flat section in the middle and a sharp drop-off at the edges, near a = -0.8 and a = 0.8. The trend
// shows that Re[Poly(a)] approximates the target function.
#figure(image("imgs/PLOT_pyqsp_phase_poly_deg_18_kappa_10.png", width: 100%),
  caption: [
    Response function for the real phase estimation polynomial with $Delta = 10$ and $d = 18$ in the $( W_x , S_z , chevron.l + | dot.op | + | ) chevron.r$-QSP convention..
  ]
)
<fig:example_phase_-->

A set of QSP phases for this polynomial can also be given in the $( W_x , S_z , chevron.l 0 | dot.op | 0 | ) chevron.r$-QSP convention; use of this convention clarifies the reduction to the quantum Fourier transform presented in Section~#ref(<sec:EmergentQFT>, supplement: none).

```
pyqsp --polydeg 16 --measurement="z"
--func="-1+np.sign(1/np.sqrt(2)-x)+
np.sign(1/np.sqrt(2)+x)"  --plot polyfunc
```

```
0.6744825 2.4248297 2.7351234 2.7316442 0.0127715 3.915519 2.3178308 -0.00533221 2.3088486 2.36385 2.3181891 1.585311
2.411246 0.4094785 -0.40136954 0.7154387
1.8687413
```

The corresponding response function is shown in @fig:example_phase_00.

// [figvision] imgs/PLOT_pyqsp_phase_polyfunc_deg_16.png
// The figure shows a plot of the response function for a degree polynomial approximation to the phase estimation
// function. ### Panel description The plot has a y-axis labeled "response" with a range of -1.0 to 1.0 and an
// x-axis labeled "a" with a range of -1.00 to 1.00. There are three series: a grey dashed line representing the
// target function, a black line representing the real part of Poly(a), and a blue line representing the
// imaginary part of Poly(a). The target function is a square wave with an amplitude of 1.0, centered at 0.0, and
// with a width of 1.0. The black line, Re[Poly(a)], starts at -1.0, increases to 1.0, and then decreases back to
// -1.0, with oscillations. The blue line, Im[Poly(a)], oscillates around 0.0 with an amplitude of 0.1. The trend
// shows that the real part of the polynomial approximation closely follows the target function, while the
// imaginary part has small oscillations. The message is that the polynomial approximation is a good fit to the
// target function.
#figure(image("imgs/PLOT_pyqsp_phase_polyfunc_deg_16.png", width: 100%),
  caption: [
    Response function for a degree $18$ polynomial approximation to the phase estimation function in the $( W_x , S_z , chevron.l 0 | dot.op | 0 | ) chevron.r$ convention.
  ]
)
<fig:example_phase_00>

Note that we are no longer using the real polynomial approximation of @eq:SignFunction_Target since it does not satisfy the conditions of @thm:qsp_Wx-Sz-00; because of this, there is a small non-zero imaginary response. The QSP phase angles for this example are generated using an optimization algorithm.

== Eigenstate filtering
<eigenstate-filtering>

As in the eigenvalue threshold problem of Section~#ref(<sec:Threshold>, supplement: none), suppose $cal(H)$ is a Hermitian matrix with an eigenvalue $lambda$ which is known to be separated from other eigenvalues by a gap $Delta_lambda > 0$, and the problem is to create, using QSP, a projection operator onto the eigenspace corresponding to $lambda$. Lin and Tong~@Lin_2020 show that the degree $d = 2 k$ polynomial

$ f_k ( x , Delta_lambda ) = frac(T_k (- 1 + 2 frac(x^2 - Delta_lambda^2, 1 - Delta_lambda^2)), T_k (- 1 + 2 frac(- Delta_lambda^2, 1 - Delta_lambda^2))) thin , $

known as the "eigenstate filtering function," is an optimal polynomial for filtering out the unwanted information from all other eigenstates.

For example, with $delta = 0.3$ and using a degree $d = 30$ Taylor series, a set of QSP phase angles for this polynomial is:

```
pyqsp --plot-positive-only --plot-real-only 
--plot-tight-y --seqargs 30,0.3 --plot efilter
```

```
-2.22655153 2.26982696 -0.76378956 0.07418111 0.25458387 0.5916072 0.30309002 0.10101557 -0.12943648 -1.00141425 0.60368299 -2.2897962 -0.04337353 0.28364185 2.28161478 -0.61804648 -0.85997787 0.28364185 -0.04337353 0.85179646
0.60368299 -1.00141425 -0.12943648 0.10101557 0.30309002 0.5916072 0.25458387 0.07418111 -0.76378956 -0.87176569 2.48583745
```

which produces this response function for $a > 0$:

The corresponding response function is shown in @fig:example_efilter.

// [figvision] imgs/PLOT_pyqsp_efilter_degree_30_delta_0_3.png
// The figure shows a plot with one panel. The plot has a solid black line and a dashed grey line. The y-axis
// ranges from 0.0 to 0.8 and is labelled "response". The x-axis ranges from 0.0 to 1.0 and is labelled "a". The
// solid black line, labelled Re[Poly(a)], starts at about 0.9, decreases rapidly to about 0.05 at a=0.2, then
// oscillates slightly around 0.0. The dashed grey line, labelled target function, is a step function with a
// value of 0.9 for a<0.15 and 0.0 for a>0.15. The trend is that the solid black line approximates the dashed
// grey line.
#figure(image("imgs/PLOT_pyqsp_efilter_degree_30_delta_0_3.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the eigenstate filtering function with $delta = 0.3$ and $d = 30$.
  ]
)
<fig:example_efilter>

This is a better threshold function than the one presented in section~@subsec:thresh_func, and the threshold can be located where desired by changing $Delta_lambda$.

== Gibbs distribution
<gibbs-distribution>

Given $cal(H) = sum_lambda lambda |lambda chevron.r chevron.l lambda|$, its corresponding Gibbs distribution state $rho ( beta ) = 1 / Z e^(- beta cal(H))$ is the density matrix

$ rho ( beta ) = frac(1, Z) sum_lambda e^(- beta lambda) | lambda chevron.r chevron.l lambda | thin , $

An approximation to $e^(- beta a)$ is useful for obtaining $rho$ using QSP. To ensure that the function has definite parity, we choose a polynomial approximation to $e^(- beta | a |)$.

For example, with $beta = 3.5$ and using a degree $d = 20$ Taylor series, a set of QSP phase angles for this polynomial is:

```text
pyqsp --plot-positive-only --plot-real-only
--plot-tight-y --seqargs=20,3.5 --plot gibbs
```

```
-0.0311925 0.15173154 -0.42846816 0.59591 -0.41539264 -0.16200557 0.12112529 -0.09068282 -0.92154011 -0.88213549 1.0199175 -0.88213549 2.22005254 -0.09068282 0.12112529 -0.16200557
-0.41539264 0.59591 -0.42846816 -2.98986111
1.53960383
```

The corresponding response function is shown in @fig:example_gibbs.

// [figvision] imgs/PLOT_pyqsp_gibbs_degree_20_beta_3_5.png
// The figure shows a plot with one panel. The plot shows two series: a dashed grey line representing the target
// function and a solid black line representing Re[Poly(a)]. The x-axis represents "a" and ranges from 0.0 to
// 1.0. The y-axis represents "response" and ranges from 0.0 to 1.0. The plot shows that the target function and
// Re[Poly(a)] are nearly identical, with the black line closely following the grey dashed line, indicating a
// good approximation. The trend of both series is a decrease as "a" increases from 0.0 to 1.0. There are no
// symbols, annotations, or labels other than the axis labels and the legend.
#figure(image("imgs/PLOT_pyqsp_gibbs_degree_20_beta_3_5.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the Gibbs distribution for $a > 0$ with $beta = 3.5$ using a degree $d = 20$ polynomial. The response is scaled to maximize $upright("Poly") ( a )$. Note that the approximation deviates from the target near $a = 0$ as the symmetrized version of the Gibbs distribution is non-analytic about that point.
  ]
)
<fig:example_gibbs>

== ReLU
<relu>

The "rectified linear unit" activation function, $upright("ReLU") ( x ) := upright("max") ( 0 , x )$, is popular in machine learning, and QSP is a natural framework to employ for realizing such nonlinear activation functions for quantum machine learning. A common differentiable approximation of the ReLU function is the softplus function, which is made into an even function in this version:

$ f ( a ) = frac(ln ( 1 + e^(Delta (| a | - delta)) ), Delta) $

where $Delta$ parameterizes the steepness, and $delta$ the offset of the threshold from $0$.

For example, with $delta = 0.6$ and $Delta = 15$ and using a degree $20$ Taylor series, a set of QSP phase angles for this polynomial is:

```
pyqsp --plot-real-only --plot-tight-y
--seqargs=20,0.6,15 --plot relu
```

```
0.5830891 -0.50867554 0.45797704 -1.83149903 0.20084092 -0.11936587 0.97960177 0.53415547 -0.9957325 -0.9362886 1.24987957 -0.9362886 -0.9957325 0.53415547 0.97960177 -0.11936587
0.20084092 1.31009363 -2.68361561 2.63291712
-0.98770723
```

The corresponding response function is shown in @fig:example_relu.

// [figvision] imgs/PLOT_pyqsp_softplus_degree_20_delta_0_6_kappa_15.png
// The figure shows a plot of the response function for the polynomial approximation to the ReLU function. ###
// Panel description The plot has a single panel. - The plot shows two series: a dashed grey line representing
// the target function and a solid black line representing Re[Poly(a)]. - The x-axis represents 'a' and ranges
// from -1.00 to 1.00. - The y-axis represents 'response' and ranges from 0.0 to 0.8. - There are no symbols or
// additional line styles. - The legend is located in the top-right corner, with the dashed grey line labeled as
// 'target function' and the solid black line labeled as 'Re[Poly(a)]'. - The trend shows that the target
// function has a sharp increase at a=0, while the Re[Poly(a)] function is a smooth approximation. - The message
// is that the Re[Poly(a)] function approximates the target function well, except at the point of sharp increase.
#figure(image("imgs/PLOT_pyqsp_softplus_degree_20_delta_0_6_kappa_15.png", width: 100%),
  caption: [
    Response function for the polynomial approximation to the ReLU function with $delta = 0.6$ and $Delta = 15$.
  ]
)
<fig:example_relu>

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", title: [References], full: true)