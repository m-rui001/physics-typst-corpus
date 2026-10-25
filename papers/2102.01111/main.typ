#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10.9pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.94cm, right: 3.00cm, top: 3.16cm, bottom: 2.74cm))
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 1.03em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.58em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#show math.equation.where(block: true): set align(center)

#align(right)[`IFT-UAM/CSIC-21-10`]
#v(1.2em)
#align(center)[
  #text(size: 20pt, weight: "bold")[Lectures on the Swampland Program \
  in String Compactifications]
  #v(12mm)
  #text(size: 14pt)[QFT & Geometry Summer School]
  #v(4pt)
  #text(size: 12pt)[July 2020]
  #v(1.5cm)
  #text(size: 13pt)[Marieke van Beest#super[1], José Calderón-Infante#super[2], Delaram Mirfendereski#super[3], Irene Valenzuela#super[4]]
  #v(8mm)
  #text(size: 8pt)[
    #super[1] Mathematical Institute, University of Oxford, Andrew-Wiles Building, Woodstock Road, Oxford, OX2 6GG, UK \   #super[2] Instituto de Física Teórica IFT-UAM/CSIC, C/ Nicolás Cabrera 13-15, 28049 Madrid, Spain \   #super[3] Physics Department, Boğaziçi University, 34342 Bebek / Istanbul, TURKEY \   #super[4] Jefferson Physical Laboratory, Harvard University, Cambridge, MA 02138, USA
  ]
]
#v(1em)
#strong[Abstract] \
The Swampland program aims to determine the constraints that an effective field theory must satisfy to be consistent with a UV embedding in a quantum gravity theory. Different proposals have been formulated in the form of Swampland conjectures. In these lecture notes, we provide a pedagogical introduction to the most important Swampland conjectures, their connections and their realization in string theory compactifications. The notes are based on the series of lectures given by Irene Valenzuela at the online #emph[QFT and Geometry summer school] in July 2020.

#pagebreak()
#align(left)[#set par(first-line-indent: 0em)
  #text(14.3pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 10.9pt)
  #set par(first-line-indent: 0em, leading: 0.62em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { block(above: 1.0em, it) } else { it }
  }
  #outline(title: none, depth: 3)
]

= Introduction <introduction>

#emph[Not everything] is possible in quantum gravity (QG), in the sense that not every model constructed following the rules of quantum field theory will be consistent once gravity is considered at the quantum level.

This reflects the fact that obtaining a consistent quantum gravity theory is not so simple, and can still hide many surprises for the physics at lower energies.

The Swampland program aims to determine the constraints that an effective field theory must satisfy to be consistent with a UV embedding in a quantum gravity theory. They are dubbed #emph[swampland constraints], and the different proposals are formulated in the form of Swampland conjectures. The goal is to identify these constraints, gather evidence to prove (or disprove) them in a quantum gravity framework, provide a rationale to explain them in a model-independent way and understand their phenomenological implications for low energy physics. Although
the notion of the swampland is in principle not restricted to string theory, the swampland conjectures are often motivated by or checked in string theory setups. Indeed, string theory provides a perfect framework to quantitatively and rigorously test the conjectures, improving our understanding of the possible string theory compactifications on the way. Interestingly, we have recently revealed that many of these conjectures are actually related, suggesting that they might simply be different faces of some more fundamental quantum gravity principles yet
to be uncovered.

The swampland constraints may also have important implications for Particle Physics and Cosmology. They can provide new guiding principles to constructing Beyond Standard Model theories and progress in High Energy Physics. They may also induce UV/IR mixing that breaks the expectation of scale separation and potentially provides new insights on the naturalness issues observed in our universe. Hence, the existence of a swampland is great news for Phenomenology! \

In these lectures, we provide a pedagogical introduction to the most important Swampland conjectures, their connections and their realization in string theory compactifications. The notes are based on the series of lectures given by Dr. Irene Valenzuela at the online #emph[QFT and Geometry summer school] @school in July 2020.

These lecture notes are not intended to be a review, so many references belonging to this research field will be missing. We will sometimes provide concrete references to particular papers within each topic, but we will mainly be using the more pedagogical references, which are most well-suited for students. For a more complete list of references of the Swampland program, we refer the reader to @Palti:2019pca, where the Swampland program is also reviewed and introduced. Other key references for lecture notes about the Swampland program are @Palti:2020mwc @Brennan:2017rbf.

= The Swampland Program <the-swampland-program>

== What is the Swampland? <what-is-the-swampland>

Effective field theories (EFTs) have proven to be very useful in the history of physics. They provide a description of the physical phenomena which is valid up to a certain energy scale denoted as the cut-off scale $Lambda$. Above this scale, the EFT breaks down and needs to be modified, but below $Lambda$ it should provide a valid description of the physics, both in agreement with the full theory and with the experiments.

// [figvision] imgs/scale_v3.png
// Panel (a) is a horizontal energy scale axis labelled Λ (GeV) with an arrowhead at the right. Seven vertical
// ticks run left to right: Λ_CC at 10⁻¹¹ GeV, Λ_QCD at 10⁰ GeV, M_EW at 10² GeV, H, M_KK and M_s as adjacent
// ticks, and M_p at 10¹⁹ GeV. Each tick has an italic label above the axis and a power-of-ten value below where
// shown, spanning roughly thirty orders of magnitude. Per the caption, the marks denote the cosmological
// constant, QCD scale, electroweak symmetry breaking scale, inflationary Hubble scale, compactification scale,
// string scale, and Planck scale. The message is an ordered succession of EFT validity cut-offs from 10⁻¹¹ to
// 10¹⁹ GeV.
// [figvision] imgs/scale_v3.png
// Panel (a) is a horizontal energy scale axis labelled Λ (GeV) with an arrowhead at the right. Seven vertical
// ticks run left to right: Λ_CC at 10⁻¹¹ GeV, Λ_QCD at 10⁰ GeV, M_EW at 10² GeV, H, M_KK and M_s as adjacent
// ticks, and M_p at 10¹⁹ GeV. Each tick has an italic label above the axis and a power-of-ten value below where
// shown, spanning roughly thirty orders of magnitude. Per the caption, the marks denote the cosmological
// constant, QCD scale, electroweak symmetry breaking scale, inflationary Hubble scale, compactification scale,
// string scale, and Planck scale. The message is an ordered succession of EFT validity cut-offs from 10⁻¹¹ to
// 10¹⁹ GeV.
#figure(placement: top, image("imgs/scale_v3.png", width: 100%),
  caption: [
    Each EFT has an energy cut-off up to which the description is valid. Typical reference scales in high energy physics are indicated here, including the cosmological constant, QCD, electroweak symmetry breaking, and the Planck scale $M_p$. Also indicated is a possible estimation of the Hubble scale $H$ for inflation, the compactification scale $M_"KK"$ and the string scale $M_s$, at which stringy effects become important.
  ]
)

// [figvision] imgs/scale_v3.png
// Panel (a) is a horizontal energy scale axis labelled Λ (GeV) with an arrowhead at the right. Seven vertical
// ticks run left to right: Λ_CC at 10⁻¹¹ GeV, Λ_QCD at 10⁰ GeV, M_EW at 10² GeV, H, M_KK and M_s as adjacent
// ticks, and M_p at 10¹⁹ GeV. Each tick has an italic label above the axis and a power-of-ten value below where
// shown, spanning roughly thirty orders of magnitude. Per the caption, the marks denote the cosmological
// constant, QCD scale, electroweak symmetry breaking scale, inflationary Hubble scale, compactification scale,
// string scale, and Planck scale. The message is an ordered succession of EFT validity cut-offs from 10⁻¹¹ to
// 10¹⁹ GeV.
It is well-known that, given some UV theory, it is always possible to integrate out the UV degrees of freedom, and thereby obtain the low energy EFT.

In this way, the effective Lagrangian of a $d$-dimensional theory can be divided into the renormalizable part and a tower of non-renormalizable operators (over the Planck mass $M_p$)

$
  cal(L)_"eff" = cal(L)_"ren" + sum_(n = d)^infinity frac(cal(O)_n, M_p^(n - d)) .
$

The question we are trying to answer with the Swampland program is whether this process can always be run in reverse; whether, #emph[starting from some quantum EFT weakly coupled to Einstein gravity, it can always be UV completed to a consistent theory of QG.] The answer to this question turns out to be: no, we cannot UV complete any EFT in a way that is consistent with QG. This answer has its origin in the fact that not everything is possible in string theory. Even if the string landscape is huge, as we will discuss, it does not cover everything. The
next question is, thus : if this cannot always be done, what are the conditions that an EFT has to satisfy in order to make this possible?

In a sense, the fact that we can have a consistent EFT which becomes inconsistent when coupled to a gauge field or gravity is not a new thing. For instance, we know that there may appear new anomalies that need to be cancelled to guarantee consistency of the theory. To give an example, consider an EFT with an odd number of fermions in the fundamental representation of an $S U ( 2 )$ flavour global symmetry. This EFT is perfectly sensible on its own, but when it is coupled to a dynamical gauge field that gauges the $S U ( 2 )$ symmetry, the theory becomes
inconsistent due to the presence of a Witten anomaly @Witten:1982fp. We therefore have to require that an EFT coupled to a gauge field must be anomaly free. When the theory is coupled to gravity new anomalies will in general appear, but, interestingly, the absence of gravitational anomalies is not enough to guarantee quantum consistency of the theory. There are other constraints that one needs to satisfy, that simply seem to express the fact that arriving at a unitary theory of quantum gravity is not so simple. These additional constraints are called
quantum gravity or #emph[Swampland constraints]. This brings us to our first definition of the lectures:


#block[
#strong[The Swampland.] Those apparently consistent (anomaly free) quantum EFTs that cannot be embedded in a UV consistent theory of quantum gravity @Vafa:2005ui.

]

Hence, we say that an EFT belongs to the Swampland when it does not satisfy the Swampland constraints, meaning that the theory cannot be UV completed in QG. The name was chosen in contrast to the #emph[Landscape], which include those EFTs that are consistent with quantum gravity considerations. The goal of the Swampland program is to determine where the boundary lies that separates the Swampland from the landscape. From the point of view of string theory, the program attempts to classify the possible string geometries, i.e. string compactifications, to
understand what can and cannot arise from string theory.

An important point to note is that these constraints, in order to be Swampland constraints, should disappear as the Planck mass goes to infinity and we decouple gravity. This also implies that they are more constraining as the energy at which the EFT should be valid increases, picking out in the end a (possibly unique) theory of QG. This is illustrated in @fig:cone, where the blue cone represents the set of consistent theories, which we call the landscape, and the Swampland surrounds the cone. The Swampland criteria become stronger as the energy
increases and we get closer to the QG scale, as illustrated by the cone shape, and terminate in a consistent theory of QG. It is tantalizing to conclude, following the previous reasoning, that there is a unique QG theory in the UV, meaning that all consistent QG theories should be somehow connected to string theory. This is known as String Universality, which will be discussed in more detail in @sec:BPScomp. As of today, it is an open question and one of the mysteries that we address in the Swampland program.

// vision: This is a schematic diagram, not a data plot. The vertical axis is labeled Energy with no units or numeric range; the horizontal plane is labeled Theory space with no units or range. A translucent blue cone rises from the plane to a point labeled “Quantum Gravity (String Theory),” with its edge labeled “Swampland Constraints.” Inside the plane, an elliptical region labeled “Landscape” (green field with a tree) sits within a larger swampy area labeled “Swampland.” Arrows annotate the exterior as “Not consistent with Quantum Gravity” and the landscape as “Consistent with Quantum Gravity.” There are no curves, legend entries, or numerical values.
// [figvision] imgs/swampland_figure.png
// This schematic diagram illustrates the Swampland and Landscape of effective field theories. A vertical axis
// labeled Energy points upward. An elliptical horizontal plane represents Theory space, textured with a swamp
// photograph. Inside this ellipse, a smaller blue-outlined oval labeled Landscape contains a green pasture with
// a solitary tree, while the surrounding marshy region is labeled Swampland. A translucent blue cone rises from
// the Landscape region, widening at low Energy and narrowing toward high Energy; its left edge is labeled
// Swampland Constraints and its apex points upward to Quantum Gravity (String Theory). Curved arrows mark the
// exterior as Not consistent with Quantum Gravity and the interior as Consistent with Quantum Gravity. The cone
// shape indicates that Swampland constraints become stronger at high energies.
#figure(placement: top, image("imgs/swampland_figure.png", width: 70.0%),
  caption: [
    The Swampland and Landscape of EFTs. The space of consistent EFTs forms a cone because Swampland constraints become stronger at high energies.
  ]
) <fig:cone>

// As explained above, for each EFT there exists some cut-off $Lambda_"EFT"$ at which the effective description breaks down, typically because of the presence of new light degrees of freedom. Above this cut-off the EFT should be modified by "integrating in" these new degrees of freedom, resulting in the definition of a new EFT which is valid above that energy scale up to some new cut-off. However, this process cannot be repeated indefinitely: any EFT has a cut-off (dubbed the QG cut-off $Lambda_"QG"$) above which it cannot be amended to give a
// [figvision] imgs/Swampland_cone_section.png
// This schematic panel shows a two-dimensional diagram with unlabeled vertical and horizontal axes marked by
// black arrows at their ends. A blue shaded region occupies the lower-left, bounded by the axes below and left
// and above by a smooth decreasing convex curve descending from near the top of the vertical axis to meet the
// horizontal axis at the far right. The word "Landscape" appears in black serif font inside the blue region near
// the lower left. Two horizontal dashed lines span the panel at different heights. No numerical tick labels,
// units, or series legends are visible. The curve separates the shaded landscape region below from the region
// above, the swampland.
// consistent QFT weakly coupled to Einstein gravity. In other words, it is not possible to "integra in" the new light degrees of freedom while preserving the QFT description. This occurs, for example, if an infinite tower of new light states appears, they cannot simply be "integrated in": quantum gravitational effects become important and the EFT completely breaks down. It is then necessary to drastically change what we identify as the “fundamental degrees of freedom” and go to a string theory description, grow an extra dimension, etc. Therefore, an
// EFT belongs to the Swampland, not only if it has a feature which makes it impossible to be UV completed in QG, but also if it is defined up to an energy scale which lies above its QG cut-off. This is represented in @fig:cone_section, where the same EFT used to describe a physical process at an energy $E_1$ belongs to the landscape while it belongs to the Swampland if the characteristic energy of the process is $E_2$.

// [figvision] imgs/Swampland_cone_section.png
// This schematic panel shows a two-dimensional diagram with unlabeled vertical and horizontal axes marked by
// black arrows at their ends. A blue shaded region occupies the lower-left, bounded by the axes below and left
// and above by a smooth decreasing convex curve descending from near the top of the vertical axis to meet the
// horizontal axis at the far right. The word "Landscape" appears in black serif font inside the blue region near
// the lower left. Two horizontal dashed lines span the panel at different heights. No numerical tick labels,
// units, or series legends are visible. The curve separates the shaded landscape region below from the region
// above, the swampland.
#figure(image("imgs/Swampland_cone_section.png", width: 35.0%),
  caption: [
    The Swampland and Landscape of EFTs. Cross section of @fig:cone. The effective field theory (EFT#sub[0]) is in the landscape/swampland if it is used to describe a process of characteristic energy $E_1 \/ E_2$.
  ]
) <fig:cone_section>

To sum up, whether an EFT is in the Swampland depends on the energy scale at which we claim that it is valid. The higher this energy, the more difficult it is to be consistent with string theory (the landscape is smaller). The Swampland constraints will sometimes indicate features that the EFT must have, while others will define the QG cut-off at which the EFT should drastically break down.

// [figvision] imgs/Swampland_cone_section.png
// This schematic panel shows a two-dimensional diagram with unlabeled vertical and horizontal axes marked by
// black arrows at their ends. A blue shaded region occupies the lower-left, bounded by the axes below and left
// and above by a smooth decreasing convex curve descending from near the top of the vertical axis to meet the
// horizontal axis at the far right. The word "Landscape" appears in black serif font inside the blue region near
// the lower left. Two horizontal dashed lines span the panel at different heights. No numerical tick labels,
// units, or series legends are visible. The curve separates the shaded landscape region below from the region
// above, the swampland.
An interesting ramification of the Swampland program is that it has brought about a shift in attitude in the string phenomenology community. Instead of trying to find out, from a phenomenological point of view, which vacuum we are living in -- a daunting task given that the landscape is huge -- we can try to predict features of this vacuum by understanding what is not possible, i.e. where we do not live. Thus, Swampland constraints can have phenomenological implications and give rise to new guiding principles for constructing Beyond Standard Model
theories as well as cosmological models. Furthermore, the Swampland breaks with the logic of naturalness, which is based on scale separation, because if QG imposes non-trivial constraints in the IR, this constitutes UV/IR mixing which could explain the hierarchy problems that we observe. We will give some examples of this in the lectures, although the focus will be to understand the string theory and geometric realizations of the Swampland constraints.

== Swampland Conjectures <swampland-conjectures>

Of course, the Swampland constraints, that distinguish between what is in the landscape and what is in the Swampland, are not as well-understood as the gauge or gravitational anomalies. At the moment, we only have proposals. These proposals go under the name of Swampland conjectures because none of them are completely proven. However, in the last few years a significant amount of evidence has been gathered for several of them, which are currently widely accepted in the string theory community. The differences in the status of the evidence for each
conjecture will become clear as this is discussed throughout the lectures. @fig:mapofconjectures shows the Swampland conjectures as well as some connections between them.

#figure(cetz.canvas(length: 0.18cm, {
  import cetz.draw: *

  let purple = rgb("#a9a9e0")
  let gray = rgb("#9a9a9a")
  let edgecol = rgb("#2f2f9f")

  set-style(stroke: (paint: edgecol, thickness: 1pt), fill: none)

  let nodes = (
    nfp: ((9.1, 16.84), (9.1, 3.1), "No Free Parameters", purple),
    tc: ((24.0, 23.84), (8.5, 2.9), "Trivial Cobordism", purple),
    dc: ((29.6, 14.64), (8.6, 2.9), "Distance Conjecture", gray),
    ngs: ((44.7, 21.34), (9.9, 3.1), "No Global Symmetries", gray),
    ch: ((65.6, 23.94), (9.9, 3.1), "Completeness Hypothesis", purple),
    wgc: ((62.7, 15.14), (9.9, 3.1), "Weak Gravity Conjecture", gray),
    sw: ((46.5, 9.34), (6.1, 2.8), "Scalar WGC", purple),
    adsd: ((14.8, 5.94), (9.9, 3.1), "AdS Distance Conjecture", purple),
    ds: ((35.7, 3.74), (8.0, 3.1), "dS Conjecture", purple),
    tpc: ((57.1, 3.14), (9.9, 3.1), "Transplanckian Censorship", purple),
    ai: ((74.4, 7.54), (9.9, 3.1), "AdS Instability Conjecture", purple),
  )

  for (name, n) in nodes {
    circle(n.at(0), radius: n.at(1), fill: n.at(3), stroke: none, name: name)
  }

  line("tc", "nfp")
  line("tc", "dc")
  line("tc", "ngs")
  line("nfp", "dc")
  line("dc", "ngs", stroke: 1pt + black)
  line("dc", "wgc", stroke: 1pt + black)
  line("dc", "adsd")
  line("dc", "ds")
  line("dc", "sw")
  line("dc", "ai")
  line("adsd", "ds")
  line("ds", "tpc")
  line("ngs", "ch")
  line("ngs", "wgc", stroke: 1pt + black)
  line("ch", "wgc")
  line("wgc", "sw")
  line("wgc", "ai")

  for (name, n) in nodes {
    content(name, text(size: 7pt, n.at(2)))
  }
}),
  caption: [
    Map of the Swampland conjectures. The conjectures in black are at the core of the Swampland program, and we will discuss them in detail in the following. The conjectures in purple will also be discussed throughout the lectures, but sometimes in less detail.
  ]
) <fig:mapofconjectures>

In these lecture notes, we will go through the map and describe some of the most important conjectures. One of the most interesting things about this map are all the connections between the conjectures which are currently being discovered. This development is exciting because it might be indicating that some of the conjectures are actually different faces of the same underlying QG principles that are starting to appear. The hope is that they will all be unified in the future, improving our understanding of QG.

Formulating the conjectures is only the first step in the Swampland program. Most of the work actually comes afterwards, as several tasks need to be accomplished before claiming success. This is illustrated in the scheme of @fig:roadmap. First, one tries to identify universal patterns from the data we have from string theory or from black hole (BH) physics and formulate some criterion. Then a lot of work must go into testing the conjectures and, if needed, refine and sharpen them. This usually implies that the conjecture is tested in string theory
(or in AdS/CFT), since it is a consistent quantum gravity framework and provides a perfect playing ground to quantitatively check the conjecture. However, this is not sufficient to claim that a conjecture applies in general for QG. Although the string theory tests can be very rigorous, the proofs are typically restricted to specific classes of string compactifications so they are not completely universal. Hence, one should also be able to provide some physical rationale for the conjecture and explain what could go wrong otherwise. This is typically done
using BH physics, consistency of the S-matrix, positivity constraints or some other model-independent approach. These arguments are, in general, only able to support mild versions of the conjectures, leaving several ambiguities. However, combined with the string theory tests, they can constitute strong evidence for the conjecture. Finally, it is interesting to study the phenomenological implications of the conjectures, both for Particle Physics and Cosmology. In these lecture notes, we will focus on explaining the conjectures themselves, their
connections and how they are realized in string theory compactifications.

#figure(cetz.canvas(length: 0.75cm, {
  import cetz.draw: *

  let blue = rgb("#a6cdec")
  let dark = rgb("#555555")

  set-style(stroke: (paint: dark, thickness: 1pt), fill: none,
    mark: (length: 0.25cm, width: 0.22cm))

  let nodes = (
    top: ((10, 5.08), (2.95, 1.2), [Identify universal patterns \ and formulate criteria]),
    left: ((3, 1.28), (3.0, 1.3), [Test the conjecture]),
    mid: ((10, 1.28), (2.95, 1.3), [Explain underlying \ QG principle]),
    right: ((17, 1.28), (2.95, 1.3), [Phenomenological \ implications]),
  )

  for (name, n) in nodes {
    circle(n.at(0), radius: n.at(1), fill: blue, stroke: none, name: name)
  }

  line("top", "left", mark: (end: (symbol: "stealth", fill: dark)))
  line("top", "mid", mark: (end: (symbol: "stealth", fill: dark)))
  line("top", "right", mark: (end: (symbol: "stealth", fill: dark)))

  for (name, n) in nodes {
    content(name, text(size: 8.5pt, n.at(2)))
  }
}),
  caption: [
    Road map of the Swampland program.
  ]
) <fig:roadmap>

= No Global Symmetries in Quantum Gravity <sec:globalsym>

The first conjecture, which is the oldest and the most widely accepted, is the statement that there are no global symmetries in QG. In order to discuss this conjecture, it is important to first define what we mean by a global symmetry in this context. Because, of course, this conjecture is not meant to imply that there are no symmetries in QG, just that they have to be associated to gauge degrees of freedom. A useful reference on this topic is @Banks:2010zn.

== No Global Symmetries Conjecture <no-global-symmetries-conjecture>

#block[
#strong[No Global Symmetries.] There are no global symmetries in quantum gravity (i.e. any symmetry is either broken or gauged).

]

A global symmetry can be defined as a transformation described by a unitary local operator that commutes with the Hamiltonian and acts non-trivially on the Hilbert space of physical states. The latter requires the existence of at least one charged local operator, so we say that the symmetry acts faithfully. The condition of commuting with the Hamiltonian is guaranteed by a local energy conservation condition in QFT implying that the stress-energy tensor is neutral. The local operators are required to satisfy a group law, although it is a very interesting
question to understand whether this can be relaxed and whether other topological operators are likewise absent in QG. Analogously, we will also require that a global symmetry should map local operators into local operators, although it seems that this requirement might sometimes also be relaxed, as we will discuss in @sec:cob.

<def:globalsym> $exists$ unitary local operator $U ( g )$, $g in G$ that:

- Satisfies a group law: $U ( g ) U ( g' ) = U ( g g' )$ ,

- Acts non-trivially on the Hilbert space: $exists$ a charged local operator $(x)$ s.t. \
 $U^dagger (g) (x) U(g) (x)$ ,

- Commutes with the Hamiltonian: $U^dagger T_(mu nu) U = T_(mu nu)$ ,

- Maps local operators into local operators.

While most of the evidence for this conjecture takes all these conditions into account, part of proving and understanding why global symmetries are not allowed in QG implies trying to properly define what the disallowed global symmetry is, and whether one can relax any of the above conditions. The approach is to use evidence from string theory and AdS/CFT to properly and rigorously state what does and does not occur.

Note that the global part of a gauge group is not included in the above definition of a global symmetry, i.e. this is perfectly allowed in QG. The reason is that the global part of a gauge symmetry (and also its large gauge transformations) violate the second condition above, i.e. there are no gauge invariant charged local operators $(x)$. We illustrate this in the following example. \

#strong[Example 1.] Consider, as a typical example of a (zero-form) global symmetry, the shift symmetry of an axion
$ phi -> phi + c . $
The current for this action is
$
  j = "d" phi ,
$
and, if the theory has a Lagrangian description, we can write the corresponding local operator describing this symmetry as
$
  U = exp( "i" alpha integral ast j ) .
$
There are local operators charged under the symmetry given by
$
  cal(O)(x) = exp( "i" q phi ) .
$
This constitutes a global symmetry which is not allowed in QG. To adhere to the conjecture we must either break the symmetry or gauge it. Gauging the symmetry amounts to coupling the current to some gauge field
$ integral A ast j -> cal(L) supset ( "d" phi - A )^2 . $ <Aj>
Then the theory is invariant under the combined transformation of the axion and the gauge field
$ phi -> phi + c(x) , quad quad A -> A + "d" c(x) . $
Thus, once the symmetry is gauged the operator $cal(O)(x)$ is not gauge invariant, which violates the second condition of the definition of a global symmetry above, so this setup is perfectly allowed in QG.

#strong[Example 2.] The conjecture of No Global Symmetries also applies to $p$-form global symmetries. These are generalizations of global symmetries whose charged operators are supported on $p$-dimensional manifolds @Gaiotto:2014kfa. We can take the example of a gauge theory invariant under the transformation
$
  A_p -> A_p + lambda_p
$<pglobal>
with $lambda_p$ a closed $p$-form. This provides a $( p + 1 )$-form current $J = F_(p + 1)$ which is conserved, $delta*J=0$, where $F_(p+1)=delta A_(p)$ is the gauge field strength. The symmetry operators read

$
  U_g (M^(d - p - 1)) = exp ( i alpha integral.cont_(M^(d - p - 1)) ast J_(p + 1) )
$

and its topological nature follows from the conservation of the current. The charged operators are Wilson lines operators supported on $p$-dimensional manifolds $gamma_p$ as follows,

$
  cal(O)(gamma_p) = exp ( i n integral.cont_(gamma_p) A_p )
$<WL>

We can either break this symmetry (e.g. by adding electrically charged states so that $delta*J != 0$) or gauge it by coupling the current to a $( p + 1 )$-form field,
$
  integral B_(p+1) ast J -> cal(L) supset ( partial A_p - B_(p+1) )^2
$<Stuck>
in analogy to @Aj. In this latter case, there are no gauge invariant charged operators anymore so the gauged symmetry is consistent with QG. In string theory, the breaking and gauging of these symmetries is typically guaranteed by the presence of Chern-Simon terms. \

#strong[Example 3.] As a final example we can consider the case of discrete symmetries. These should also be either broken or gauged, the latter implying that the discrete symmetry can be embedded in a larger gauge group or be part of the diffeomorphisms of the geometry. Hence, a discrete gauge symmetry is allowed in QG as it is actually a redundancy of the theory. Consider for example the $E_8 times E_8$ heterotic string theory. The EFT has a $bb(Z)_2$ symmetry interchanging the two $E_8$ gauge sectors, but this is a discrete gauge symmetry as it has a
clear geometric interpretation: the $E_8 times E_8$ heterotic arises from compactifying M-theory on an interval with the $E_8$ gauge sectors living at the endpoints, and the $bb(Z)_2$ symmetry is equivalent to the geometric action of flipping the interval, so it is part of the diffeomorphism transformations. The same occurs for $S L ( 2, bb(Z) )$ of Type IIB. It is gauged, as all duality groups in string theory. The particular case of $S L ( 2, bb(Z) )$ can be understood by going to F-theory, where it becomes part of the diffeomorphisms of the torus.

== Motivation <sec:motiv>

The Swampland conjectures usually come with both evidence from string theory and some piece of motivation from a more bottom-up perspective, like black hole physics. In these notes, we will mainly emphasize the former, precisely because the arguments based on BH physics should be taken as (heuristic) motivation and not as proofs. As such, they are useful for gaining intuition for the consequences of a given conjecture, in the present case, to illustrate what would go wrong if one allowed for global symmetries.

If a BH is charged under some global symmetry, it will evaporate loosing mass but not the global charge, since Hawking radiation is blind to the global charge; ending up as a remnant of Planckian size. Since this can occur for BHs in any representation of the symmetry group, the result is an infinite number of stable remnants. The remnants are arbitrarily long lived, since any combination of particles carrying such large representations of the global symmetry will be heavier than the remnant. Gravitational bremsstrahlung cannot carry away global charge
either, as gravitons are neutral under the global symmetry. Hence, in a theory with a global symmetry, starting with a charged particle we can actually end up with an infinite number of states by constructing black holes by throwing particles together and letting them evaporate until they reach Planckian size. Having an infinite number of states below a finite energy scale sounds at the very least problematic @Susskind:1995da. However, it is difficult to rigorously prove a fundamental inconsistency as we are dealing with Planckian size objects and the
semiclassical description of gravity breaks down. It has also been argued @Banks:2010zn that the existence of these remnants would violate the covariant entropy bound. According to this bound, the entropy associated to the remnant should be finite, in contradiction to the fact that there are infinitely many different states that can give rise to the same black hole geometry, suggesting instead infinite entropy.

Another argument against global symmetries makes use of the No-hair theorem for black holes @Israel:1967wq, which states that a stable black hole can be completely characterised only in terms of its mass, gauge charge and angular momentum. This implies that, given a black hole of a certain mass, there is no way to determine its global charge. This yields an infinite uncertainty to an observer outside of the black hole which can again be associated to an infinite entropy. However, this would violate the expectation that the black hole entropy should be
finite and given by the Bekenstein-Hawking formula, i.e. proportional to the square of its mass.

== Evidence <evidence>

#underline[String perturbation theory]: \

Much of the evidence for this conjecture comes from string theory.

In particular, it is proven in Polchinski's book @Polchinski:1998rr that there are no continuous global symmetries in the target space of perturbative string theory. In other words, any global symmetry of the worldsheet corresponds to a gauge symmetry in spacetime, and viceversa. In the following, we briefly revisit the proof for the case of bosonic string theory. Associated to any global symmetry in the worldsheet, there is a worldsheet charge given by $Q = frac(1, 2 pi i) integral.cont ( d z j_z - d macron(z) j_(macron(z)) )$ by Noether's theorem,
where $j_z$, $j_(macron(z))$ are the symmetry currents. This charge must be conformally invariant, which implies that $j_z$ transforms as a (1,0) tensor and $j_(macron(z))$ as (0,1) tensor. We can then form two vertex operators of the form

$
  j_z macron(partial) X^mu e^(i k X) , quad partial X^mu j_(macron(z)) e^(i k X) .
$

// [figvision] imgs/AdSCFTWilsonLine.png
// The figure is a single schematic diagram of a disk-shaped bulk bounded by a thick black circle. Curved black
// internal lines divide the interior into a central region surrounded by six outer subregions that touch the
// boundary. A filled black dot at the exact center marks the charged symmetry operator. A thick green sinusoidal
// line runs horizontally from the dot to the right edge of the circle, representing the Wilson line carrying
// symmetry information to a boundary subregion. There are no axes, ranges, units, series legends, or text
// labels. The message is that when the symmetry is gauged, the green Wilson line transports bulk symmetry data
// to the boundary.
These vertex operators precisely create massless gauge vectors in the target space coupling to the left and right moving parts of the charge $Q$. Hence, any global symmetry gives rise to a gauge symmetry in spacetime, and not to a global symmetry. The same type of proof applies to superstring theory.

As of today, there is not a single counterexample of the conjecture, even beyond perturbative string theory. \

#underline[AdS/CFT]: \

The conjecture has been proven in AdS/CFT under certain assumptions. It was shown in @Harlow:2018jwu @Harlow:2018tng that a global symmetry in the bulk would lead to a contradiction in the CFT, in the case where the symmetry is splittable on the boundary. This result is derived using entanglement wedge reconstruction, where the boundary is divided into several subregions which have access to some subregion of the bulk obtained using the Ryu-Takayanagi formula (see e.g. @Harlow:2018fse). That the symmetry is splittable implies that it splits into a
product of operators, where each operator is localized in one of the different subregions of the boundary. If the subregions are small enough, they are not sensitive to a charged operator in the bulk, so none of the operators localized in these regions can be charged under the global symmetry. But without charged operators, then there is no global symmetry in the boundary, which leads to a contradiction. On the other hand, if the symmetry is gauged in the bulk, this implies that we can insert a Wilson line which can carry information of the bulk operator
to the boundary. This setup is illustrated in @fig:AdSCFTWilsonLine. Hence, global symmetries in the boundary correspond to gauge symmetries in the bulk, and the conjecture is satisfied.

// [figvision] imgs/AdSCFTWilsonLine.png
// The figure is a single schematic diagram of a disk-shaped bulk bounded by a thick black circle. Curved black
// internal lines divide the interior into a central region surrounded by six outer subregions that touch the
// boundary. A filled black dot at the exact center marks the charged symmetry operator. A thick green sinusoidal
// line runs horizontally from the dot to the right edge of the circle, representing the Wilson line carrying
// symmetry information to a boundary subregion. There are no axes, ranges, units, series legends, or text
// labels. The message is that when the symmetry is gauged, the green Wilson line transports bulk symmetry data
// to the boundary.
#figure(placement: top, image("imgs/AdSCFTWilsonLine.png", width: 100%),
  caption: [
    Bulk and boundary region of AdS/CFT. In the center of the bulk sits a charged symmetry operator. The boundary is divided into subregions in which symmetry operators localize. When the symmetry is gauged a Wilson line, shown in green, can carry information of the symmetry to the boundary.
  ]
) <fig:AdSCFTWilsonLine>

== Phenomenological Implications <phenomenological-implications>

#underline[Approximate global symmetries in the IR]: \

One could ask how this conjecture is useful from a bottom-up perspective, i.e. what are its phenomenological implications. In this regard, however, the conjecture that there are no global symmetries in QG does not give the strongest constraints. This is because, to satisfy the conjecture, one can either gauge the symmetry, which implies that there are degrees of freedom associated to the symmetry, or simply break it at very high energies. So global symmetries are not ruled out in the IR, so long as they are approximate global symmetries, which are broken
// [figvision] imgs/AdSCFTWilsonLine.png
// The figure is a single schematic diagram of a disk-shaped bulk bounded by a thick black circle. Curved black
// internal lines divide the interior into a central region surrounded by six outer subregions that touch the
// boundary. A filled black dot at the exact center marks the charged symmetry operator. A thick green sinusoidal
// line runs horizontally from the dot to the right edge of the circle, representing the Wilson line carrying
// symmetry information to a boundary subregion. There are no axes, ranges, units, series legends, or text
// labels. The message is that when the symmetry is gauged, the green Wilson line transports bulk symmetry data
// to the boundary.
// parallel diagonal black lines. The left white strip is labeled EFT1. The middle strip is shaded light blue and
// labeled Domain Wall. The right white strip is labeled EFT2. No axes, ranges, units, or numerical data are
// present. The panel illustrates a domain wall interpolating between two effective field theories, EFT1 and
// EFT2, occupying separate regions separated by the domain-wall strip.
at some high energy scale. Therefore, if this breaking is highly suppressed, the effects in the IR might be negligible and with no phenomenological consequences.

In subsequent sections we shall discuss other related conjectures, which precisely try to quantify how approximate the global symmetries can be. \

#underline[New defects]: \

There are certain occasions in which the absence of global symmetries can have implications for a subsector of the theory. Sometimes this conjecture can be used to predict the existence of new defects in order to make sure that some global symmetry is broken or gauged. These defects can lead to new states or constrain some property of the theory. Examples of this will appear when discussing the triviality of cobordism classes in the next section.

== Triviality of the Cobordism Classes <sec:cob>

There is a generalization of the notion that there are no global symmetries, where we include topological global charges, which states that all cobordism classes must vanish.

We will explain the notion of a cobordism class here, and will discuss it further in the context of instability of non-supersymmetric vacua in @sec:nonsusy-ads, where it also plays an important role.

Cobordism is an equivalence relation on compact manifolds of the same dimensions: \

This has been illustrated in @fig:cobordantmanifolds. It has an abelian group structure and a trivial element, which is a manifold that is a boundary by itself. The following conjecture was then proposed in @McNamara:2019rup:

From the point of view of the lower $( D - d )$-dimensional theory, the fact that two $d$-dimensional compactification manifolds are cobordant to each other, is seen as a $( D - d - 2 )$-brane domain wall interpolating between two different EFTs, see @fig:cobordantmanifolds. If the bordism group does not vanish, this implies that there are some $d$-dimensional manifolds that cannot be connected with other ones, i.e. there are no domain walls interpolating between the associated EFTs. This in turn implies that there is some global topological
charge $[ M ] in Omega_d^("QG")$, which we cannot get rid of. The global charges will give rise to some $( D - d - 1 )$-form global symmetry, which would contradict the statement of No Global Symmetries in QG.

// vision: The figure is a two-panel schematic diagram with no axes, units, data curves, legend entries, or quantitative results. The top panel shows a gradient-green, irregular blob bounded by a dark green outline, containing two enlarged lobes labeled M1 on the left and M2 on the right, connected by a narrower central region that contains two small curved dark-green annotations. The bottom panel shows a slanted parallelogram divided into three vertical bands by black lines: a white left band labeled EFT1, a light blue gradient middle band labeled Domain Wall, and a white right band labeled EFT2. No numerical values, scales, or measurements are displayed.
// [figvision] imgs/cobordant_manifolds.png
// Panel a: A schematic drawing of a manifold as a light green filled region enclosed by a thick dark green
// outline. On the left is a large bulbous boundary component labeled M1; on the right is a matching bulb labeled
// M2. The two bulbs are joined by a narrower connecting neck. Inside the neck are two small white oval shapes
// with green borders, representing holes or lower-dimensional boundaries. No axes, ranges, units, or numerical
// values are shown. The figure depicts a higher-dimensional manifold whose boundary components are M1 and M2.
// Panel b: A schematic diagram inside a black-outlined parallelogram divided into three vertical strips by two
// parallel diagonal black lines. The left white strip is labeled EFT1. The middle strip is shaded light blue and
// labeled Domain Wall. The right white strip is labeled EFT2. No axes, ranges, units, or numerical data are
// present. The panel illustrates a domain wall interpolating between two effective field theories, EFT1 and
// EFT2, occupying separate regions separated by the domain-wall strip.
#figure(placement: top, image("imgs/cobordant_manifolds.png", width: 100%),
  caption: [
    Cobordant manifolds $M_1$ and $M_2$, and the EFTs arising from compactification on $M_1$ and $M_2$. The higher dimensional manifold of which $M_(1, 2)$ are the boundary is associated to a domain wall interpolating between the two EFTs.
  ]
) <fig:cobordantmanifolds>

// [figvision] imgs/cobordant_manifolds.png
// Panel a: A schematic drawing of a manifold as a light green filled region enclosed by a thick dark green
// outline. On the left is a large bulbous boundary component labeled M1; on the right is a matching bulb labeled
// M2. The two bulbs are joined by a narrower connecting neck. Inside the neck are two small white oval shapes
// with green borders, representing holes or lower-dimensional boundaries. No axes, ranges, units, or numerical
// values are shown. The figure depicts a higher-dimensional manifold whose boundary components are M1 and M2.
// Panel b: A schematic diagram inside a black-outlined parallelogram divided into three vertical strips by two
// parallel diagonal black lines. The left white strip is labeled EFT1. The middle strip is shaded light blue and
// labeled Domain Wall. The right white strip is labeled EFT2. No axes, ranges, units, or numerical data are
// present. The panel illustrates a domain wall interpolating between two effective field theories, EFT1 and
// EFT2, occupying separate regions separated by the domain-wall strip.
The way to understand this conjecture is that a QG theory must contain the required defects to guarantee triviality of the bordism group. All these defects and any required additional structure#footnote[For instance, if the manifold admits a spin structure, the relevant cobordism group is $Omega^"spin"$. If there are fermions charged under some gauge field, one typically has to look at $Omega^"spin"_c$.] are encoded in the superscript “QG” in $Omega^("QG")$. If at low energies the theory has a non-zero bordism group, it should be taken as an indication
that the theory is missing some ingredient that should be manifest at higher energies and make the cobordism group vanish. This is why in @McNamara:2019rup, this conjecture was used to predict the existence of new non-supersymmetric defects in string theory. So there #emph[are] consequences of this conjecture, but they are not necessarily visible in the IR.

To give an example, if the compactification includes internal fluxes, there can be non-trivial cobordism classes characterized by $integral_(X_d) F_d$ where $d$ is the dimension of the compactification manifold. According to the conjecture, this theory by itself would be inconsistent with QG, as $Omega_d = bb(Z)$. However, by adding branes acting as a source for the flux, one recovers a trivial corbordim group since $integral_(X_d) F_d$ is not an invariant anymore. Hence, consistency with QG would tell us that, in the presence of internal fluxes, the
existence of charged branes is required, as occurs in string theory. In this case, triviality of the cobordism group could also be achieved by adding a Chern-Simons coupling that forces $delta F_p 0$, so there is no conserved charge anymore. This is also very common in string theory.

= The Completeness Hypothesis <the-completeness-hypothesis>

The next conjecture we will discuss is the Completeness Hypothesis. Like the previous one, the Completeness Hypothesis is a very old and widely accepted Swampland conjecture. Sometimes it can be difficult to ascertain who was the first to propose a conjecture, because in some cases the conjectures are like common lore in the community, but it can certainly be found both in @Banks:2010zn and in Polchinski's book  \ @Polchinski:1998rr. \

#block[
#strong[Completeness Hypothesis.] A gauge field theory coupled to gravity must contain physical states with all possible gauge charges consistent with Dirac quantization.

]

A consequence of the Completeness Hypothesis and No Global Symmetries is that continuous gauge groups must be compact. Consider the example where the gauge group is $bb(R)$, which allows for irrational electric charges. Then a particle with irrational charge cannot decay to particles of rational charge (because of charge conservation), which implies that there is some global charge associated to this. This would be inconsistent with the statement that there are no global symmetries. This conjecture thus lets us understand why continuous gauge groups in
string theory are always compact. Importantly, this does not apply to discrete gauge groups, which can be non-compact, as is the case with duality groups. \

#block[
#strong[Consequence.] All continuous gauge groups must be compact.

]


== Motivation <motivation>

#underline[BH physics]: \

The conjecture states that in a theory with a gauge symmetry coupled to gravity, the full lattice of allowed gauge charges must be populated by physical states. This is not necessary in QFT because a charged particle can always be decoupled from the theory by sending the mass to infinity. This ensures that the particle in question is no longer part of the QFT. However, in QG one cannot decouple a particle in this way, because this process will simply result in a BH which is part of the spectrum in a complete theory of QG. Because BHs can have any charge,
we expect every possible gauge charge to be populated by some physical state (some of which could be BHs). \

#underline[Breaking global symmetries (connected gauge groups)]: \

There are some very interesting connections between completeness of the spectrum and the absence of global symmetries in QG. Recall from @sec:globalsym that the latter includes the case of higher form global symmetries (i.e. $p$-form global symmetries) associated to higher dimensional charge defects, with operators that live on higher dimensional manifolds. A common way of breaking these higher form global symmetries is simply by having charged states. But only if the spectrum of charged states is complete, can we break the full group.

Consider the #emph[Example 2] given in @sec:globalsym. The current of the $p$-form global symmetry is given by the field strength of the gauge field $F_(p+1) = delta A_p$. Then a very straightforward way to break this global symmetry is precisely to introduce states that are charged under the gauge group,
$
  delta ast J_(p+1) = delta ast F_(p+1) = ast j_"electric" .
$
Since the conservation equation for the current is tantamount to the equation of motion for the gauge field, this will be non-zero if there are charged states, $delta ast J_(p+1) eq.not 0$.

If the spectrum is not complete, there will be some discrete symmetry that remains intact. Consider e.g. only the existence of states with even charge; this leaves a $bb(Z)_2$ discrete symmetry. Therefore, a complete spectrum is required to break any discrete remnant of a higher form global symmetry, as argued in @Gaiotto:2014kfa.

Ongoing research is trying to understand to what extend the two conjectures, i.e. No Global Symmetries and Completeness, are different or follow from each other. The answer seems to depend on whether we are talking about connected or disconnected gauge groups. In the latter case, it seems that the Completeness Hypothesis is related to the absence of more general topological operators.

== Evidence <evidence>

The evidence for the Completeness Hypothesis is very similar to that of the No Global Symmetries Conjecture. It comes from string theory and AdS/CFT. In particular, in @Harlow:2015lma, it was shown that the Completeness Hypothesis follows from solving the Factorization Problem in AdS/CFT, which pertains to a rephrasing of the Completeness Hypothesis where we require that the theory must contain enough charged states such that all Wilson lines can break. This is exactly what is happening in the gauge theory example above: there are some Wilson line
charged operators defined in @WL which can break because of the presence of electrically charged states, which implies that the $p$-form global symmetry is broken. \

== BPS Completeness and Implications <sec:BPScomp>

There is a generalization of the Completeness Hypothesis, where we also require completeness in terms of BPS states. In particular, the BPS Completeness condition states that if a charge can support a BPS state, then there should be a BPS state populating that charge. Of course it is generally difficult to understand which BPS states can exist in a theory, and which charges can support BPS states. However, the idea is that if we were able to determine the lattice of BPS states at the same level of detail and generality that we understand it for gauge
groups, then all these states should be populated. \

#block[
#strong[BPS Completeness.] If a charge can be populated by BPS states, then a BPS state with this charge should be part of the physical spectrum.

]

Interestingly, in the past two years there has been a lot of progress in obtaining constraints on the possible gauge groups in QG, using this simple generalization. Certain string theory compactifications admit BPS strings, and anomaly constraints in the world-volume of these strings can be utilized to obtain constraints on the gauge groups allowed by QG. For instance, in @Kim:2019vuc @Kim:2019ths this was used to rule out the following gauge groups:

- 16 supercharges: $E_8 times U ( 1 )^248 U ( 1 )^496$ in 10d, rank $r_G > 26 - d$ for $d < 10$.

- 8 supercharges: $r_G > k + k' - 3$ in 5d, where $k k'$ are Chern-Simons levels.

To get some of the constraints on the rank of the gauge group in lower dimensions it is necessary to combine the BPS Completeness with additional conjectures like the Distance Conjecture, which will be discussed in @sec:distconj. These bounds apply e.g. to the $cal(N) = 4$ Super Yang-Mills theory. There also exist some bounds on the allowed number of Abelian gauge group factors, i.e. the rank of the Mordell-Weil group, in 6d $cal(N) = ( 1, 0 )$ theories @Lee:2019skh.

One of the goals of this program of constraining the gauge groups is to find out whether we can get everything from string theory that could be consistent with QG. In principle, e.g. in a 10D theory with 16 supercharges, in addition to the $E_8 times E_8$ and $S O ( 32 )$ gauge groups that we observe in string theory, one could have had other anomaly-free gauge groups. However, any other possible gauge groups have turned out to be inconsistent with BPS Completeness, so this might be the explanation for why we do not observe them in string theory, i.e.
that there is no known string theory construction of these gauge groups.

This bring us to a very deep and important question: how universal is string theory? This question is coupled to the Swampland program, since much of the evidence that we have for the conjectures comes from string theory. Therefore, at some point we must ask whether our results are just an artifact of the lamppost we are looking under, or whether the conjectures are more general and are actually reflecting inconsistencies in QG. If we can show that the anomaly free theories which do not appear in string theory, do not appear for some underlying QG
reason, e.g. they are inconsistent with a Swampland conjecture which is expected to be more general, this could imply that we really get everything we can get in string theory. At present, this seems to be the case for highly supersymmetric setups. The idea that everything that can possibly happen (i.e. that is not inconsistent with QG) does happen in string theory is called #emph[String Universality] or the #emph[String Lamppost Principle]. Certainly, it would be very interesting indeed if this is the case and any consistent QG theory is somehow
connected to string theory! Therefore, a significant amount of work in the Swampland program goes into studying those anomaly-free theories that we do not know how to realize in string theory, and whether there is always an additional inconsistency which prohibits them.

= The Weak Gravity Conjecture <sec:WGC>

We have seen that the absence of global symmetries and completeness of the charge spectra are at the core of the Swampland program. However, they lack phenomenological impact unless we can constrain #emph[how approximate] a global symmetry can be#footnote[See @Fichet:2019ugl @Daus:2020vtf for proposals to quantify how approximate a global symmetry can be.], and whether there is any upper bound on the mass of some of the charged states. Otherwise, they only constrain the full theory but not the low energy EFT. In particular, it is phenomenologically
relevant whether all charged particles can be super heavy and even correspond to BH's, or there is some notion of completeness of the spectrum that survives at low energies. Most of the Swampland conjectures discussed in the rest of the lectures precisely deal with these questions; they aim to sharpen these statements and quantify how close we can get to the situation of recovering some global symmetries. For example, we can a priori continuously restore a $U ( 1 )$ global symmetry by sending the gauge coupling to zero, which should not be allowed in QG.
Trying to understand how string theory forbids this, and what goes wrong if one tries to do this, can provide information about the constraints that an EFT has to satisfy to be consistent with QG. We will see that the Weak Gravity Conjecture forbids this process by signaling the presence of new light charged states invalidating the EFT description. By doing so, it also provides an upper bound on the mass of these charged states in terms of their charge.

== Definition of the WGC <sec:defWGC>

The Weak Gravity Conjecture (WGC) @ArkaniHamed:2006dz contains two parts: the electric and magnetic version. \

Given a gauge theory, weakly coupled to Einstein gravity, there exists an electrically charged state with

$
  Q\/m gt.eq (cal(Q)\/M)|_"extremal" = cal(O)(1)
$<eq:WGC>

in Planck units. Here $cal(Q)$ and $M$ are the charge and mass of an extremal black hole, and $Q = q g$, where $q$ is the quantized charge of the state and $g$ is the gauge coupling.

The electric version of the conjecture requires the existence of an electrically charged state with a charge to mass ratio greater than the one of an extremal BH in that theory, which is typically an order one factor. The order one factor depends on the theory under consideration.

The simplest case corresponds to a Maxwell theory coupled to Einstein gravity in which there are no massless scalar fields. In that case, we can construct Reissner-Nordström BH solutions, so given a $p$-form gauge field in $d$ dimensions, the WGC implies the existence of a $(p-1)$-brane satisfying:

$
  frac(p (d-p-2), d-2) T^2 lt.eq Q^2 M_p^(d-2)
$<RNBH>
Here, $T$ is the tension of the brane, and instead of an unspecified $cal(O) ( 1 )$ number, we have given the precise bound for the case of a Reissner-Nordström BH. Hence, for the case of particles in four dimensions, the order one factor in @eq:WGC is $1 \/ sqrt(2)$.

This is a very sharp conjecture, since it is phrased in terms of some computable order one number, which depends on the dimension and specifics of the theory, but it does not require UV data.

The other interpretation of this conjecture is that the bound implies that gravity acts weaker than the gauge force over this state -- hence the name the WGC. This is an equivalent formulation, since requiring that the gravitational force is weaker than the electromagnetic force
$
  F_"gravity" lt F_("EM")
$<eq:weakgrav>
will imply that the charge is greater than the mass, so we arrive as the same condition as above. This is no longer true in the presence of massless scalar fields, as discussed in @sec:WGCscalars.

We now turn to discuss the magnetic version of the conjecture, which states that the EFT cut-off $Lambda$ is bounded from above by the gauge coupling, so that, given some EFT coupled to Einstein gravity, its cut-off is smaller than the Planck mass if the gauge coupling is small. \

The magnetic version of the conjecture can be derived in two ways. We can apply @eq:weakgrav to the magnetic field (which is why it is called the magnetic version), which implies that the theory should have a monopole whose mass is smaller than its charge. Since the magnetic charge is proportional to the magnetic gauge coupling, which is the inverse of the electric gauge coupling, this means that the mass of the monopole must be smaller than the Planck mass over the electric gauge coupling:
$
  m lt.eq M_p \/ g
$
The mass of the monopole will typically be at least at the order of the cut-off of the theory over the gauge coupling squared (which is just the electrostatic energy integrated up to the cut-off), which implies that the cut-off of the theory is bounded by

$
  Lambda lt.eq g M_p
$ <gMp>
We arrive at the same conclusion if we require that the theory has some monopole that is not a BH, so that the mass of the unit charge monopole must be smaller than the Schwarzschild radius
$
  m lt.eq M_p^2 R
$
Since this radius provides a cut-off for the EFT
$
  R tilde.eq Lambda^(-1) ,
$
this again implies that $Lambda$ is smaller than $g M_p$. No that the gauge coupling is always evaluated at the given energy scale $g = g ( Lambda )$.

These are intuitive arguments for why this cut-off should be imposed. The EFT is breaking down, because at this energy scale it becomes sensitive to the monopole degrees of freedom, so these degrees of freedom can no longer be treated as solitonic objects. However, this is not necessarily a drastic breakdown of the EFT due to some QG effect. Below, we shall see a genuine QG cut-off appear in some stronger versions of the WGC, which really hints at a drastic breakdown of the EFT.

== Motivation <motivation>

The motivation for the WGC is twofold. First, it provides a QG obstruction to restoring a U(1) global symmetry by sending $g → 0$. If a gauge coupling goes to zero, according to the WGC, this results in new light particles; and the cut-off of the theory goes to zero according to @gMp, invalidating the EFT.

Given some EFT, how small the gauge coupling can be depends on how high the energy of the process you want to describe with that EFT is. The smaller the energy of the process, the smaller the gauge coupling can be, as dictated by @gMp. Conversely, if you want to keep the EFT valid up to a very high cut-off, then the gauge coupling cannot be too small. This is an example of a Swampland constraint becoming stronger for higher energies (as illustrated by the cone in @fig:cone). Needless to say, a theory with vanishing gauge coupling (i.e. a global symmetry)
is inconsistent as the EFT cut-off is then also zero.

The other main motivation for the WGC is that it is a kinematic requirement that allows extremal BHs to decay. Charged BHs must satisfy an extremality bound in order to avoid the presence of naked singularities, as implied by Weak Cosmic Censhorship. For a given charge $cal(Q)$, this extremality bound implies that the mass of the BH $M$ must be greater than the charge $ M gt.eq cal(Q) $ for the BH to have a regular horizon. Here, we are setting the extremality $cal(O) ( 1 )$ factor in @eq:WGC to one for simplicity. For an extremal BH the charge is equal
to the mass, so the only way it can decay is if there exists a particle whose charge to mass ratio is at least $1$. To see this, consider the decay of an extremal BH, where one of the decay products has a charge smaller than its mass or saturates the extremality bound, so $cal(Q)_1 lt.eq M_1$. Then the other decay product cannot have a charge smaller than the mass, i.e. $Q_2 gt.eq m_2$. This is simply a kinematic requirement. Since the second decay product violates Weak Cosmic Censorship it cannot be a BH, so it must be a particle. The system is
illustrated in @fig:BHdecay.


// vision: This is a schematic conceptual diagram with no axes, units, ranges, curves, panels, or legend. A large shaded sphere on the left is labeled Q = M and emits two black arrows. The upper arrow points to a smaller shaded sphere labeled Q₁ < M₁. The lower arrow points to a smaller shaded sphere labeled Q₂ > M₂, overlaid with a red X made of two crossing diagonal lines. A green right-pointing arrow leads from that lower region to a small solid green circle labeled Q₂ > m₂, with the word "Particle" beneath it. The visible relations are Q = M, Q₁ < M₁, Q₂ > M₂ (marked excluded by the red X), and Q₂ > m₂ for the emitted particle.
// [figvision] imgs/BHdecay.png
// Panel (a) is a schematic diagram with no axes, illustrating the decay of an extremal black hole. On the left,
// a large black sphere labeled Q = M represents the parent extremal black hole. Two black arrows originate from
// it. The upper arrow points to a smaller black sphere labeled Q₁ < M₁, indicating a decay product satisfying
// the extremality bound. The lower arrow points to a black sphere overlaid with a red X and labeled Q₂ > M₂,
// indicating a violation of the bound. A green arrow leads from this crossed-out sphere to a small green circle
// labeled Q₂ > m₂ and Particle, showing that the second product cannot be a black hole and must be a particle.
#figure(placement: top, image("imgs/BHdecay.png", width: 100%),
  caption: [
    Decay of an extremal BH. One decay product can have a charge to mass ratio $cal(Q)_1 \/ M_1 < 1$ to preserve the extremality bound, but then the other must have a charge to mass ratio $Q_2 \/ m_2 > 1$. Therefore, the latter cannot be a BH but must be a particle.
  ]
) <fig:BHdecay>

The above kinematic requirement can be derived by simply imposing mass/energy conservation and charge conservation as follows. The mass of the initial black hole state must be greater than the sum of the decay product masses $M_i$, and the charge of the initial black hole $cal(Q)$ must equal that of the decay products $cal(Q)_i$,
$
  M gt.eq sum_i M_i , space space quad quad cal(Q) = sum_i cal(Q)_i
$
Then
$
  M\/cal(Q) gt.eq 1\/cal(Q) sum_i M_i = 1\/cal(Q) sum_i (M_i\/cal(Q)_i) cal(Q)_i gt.eq 1\/cal(Q) (M\/cal(Q))_"min" sum_i cal(Q)_i = (M\/cal(Q))_"min"
$
Hence, we have shown that the mass to charge ratio of the original BH must be grater than the ratio of the decay product with minimal mass to charge ratio, which is why we need some particle satisfying the WGC.

To sum up, if a theory does not satisfy the WGC, then extremal black holes cannot decay. The question one could now ask is: what is the problem with having stable extremal BHs? The WGC is a kinematic requirement that allows extremal BHs to decay, but why is this actually necessary?

There is a heuristic argument, which is very similar to the argument for the absence of global symmetries, which suggests that we run into trouble with BH remnants. Starting with large BHs of all possible charges, they will evaporate until reaching the extremality bound. If the gauge coupling is very small, they will all reach a very similar mass, but still having very different charges. This will result in a large number of remnants (how large depends on how small the gauge coupling is)

$
  N tilde.op 1 \/ g ,
$

that are almost degenerate in mass at weak coupling. The difference in mass is set by the gauge coupling

$
  Delta M tilde.op g M_p .
$

So $N → oo$ and $Delta M → 0$ when the gauge coupling is small, and we run into trouble with entropy bounds as in @sec:motiv. However, this heuristic argument is even less satisfactory than for the case of global symmetries because it does not imply an infinite number of remnants below a fixed energy scale, but just a large number of them. As such, the argument should be understood only as supplying some intuition of what might go wrong for an EFT violating the WGC from a bottom-up perspective.

== Evidence <evidence>

The motivations from BH physics are interesting because they constitute more general arguments that allow us to at least understand some difference in the physics of an EFT that satisfies the WGC and one that does not. If we only base the conjecture on evidence from examples in string theory, we risk being fooled by the lamppost we look under. However, these motivations are very far from proving anything. The reason why the WGC is one of the most important Swampland conjectures nowadays is not because of these BH arguments, but because of all the
// [figvision] imgs/graphWGC.png
// Panel a: A plot of mass M on the vertical axis versus charge Q on the horizontal axis, both originating at the
// lower-left corner and extending to the upper right, with no numerical tick marks or ranges shown. A solid
// straight diagonal line runs from the origin to the top-right corner, identified in the legend as the
// extremality bound. A series of filled black circular marks lies below this line, roughly parallel to it,
// identified in the legend as BHs with corrections. The marks cluster close to but under the line, indicating
// smaller black holes remain sub-extremal relative to the large-black-hole extremality bound. A boxed legend
// below the plot maps the solid line to Extremality bound and the filled dot to BHs with corrections.
evidence that we have gathered for it in the past years. To go through all the evidence in detail is beyond the capacity of these notes, instead we will give a summary of the different works in this direction, and some useful references discussing these arguments. One of the nice things about the Swampland program in general, and in particular with this conjecture, is that there are many people working from a wide range of areas of research trying to prove the conjecture. Hence, the assumptions that go into a particular piece of evidence coming from one
corner of research is different from what another person assumes in a different corner. This suggests that there may indeed be something behind it all, and increases our confidence that some statement along the lines of the WGC is indeed a universal criterium of QG. \

#underline[Higher derivative corrections to BHs]: \

One piece of evidence comes from studying higher derivative corrections to the BH charge and mass. It turns out that these higher derivative corrections could be enough to show that the charge to mass ratio of small black holes is greater than the classical extremality bound. The latter is defined as the charge to mass ratio of large extremal black holes of large charge, for which quantum or higher derivative corrections become negligible,

$ cal(Q)\/M >= (cal(Q)\/M)|_"ext" . $ <hd>

If that is the case, then the WGC could already be satisfied by small BHs. The pattern found in certain setups is the following. If we plot the mass to charge ratio, as in @fig:graphWCG, with the straight line indicating the extremality bound for a large BH of large charge, then small BHs happen to lie below this curve upon taking into account higher derivative corrections. If this holds in general, it would be a way to prove a very mild version of the WGC, where the WGC-satisfying states are BHs instead of light particles. One could expect, though, that
if we extrapolate the pattern to lower masses, small black holes will eventually turn into particles, so there will also be some particle with a charge to mass ratio bigger than one. In fact, it can be interpreted as motivation for having an infinite tower of particles satisfying the WGC, where the heavier states are actually black holes. However, this extrapolation to lower energies goes beyond the regime of validity of the computations.

// vision: A two-dimensional scatter plot with a reference line plots vertical axis M against horizontal axis Q; neither axis shows numeric tick labels, units, or ranges. A solid black diagonal line runs from the origin to the upper-right corner, labeled in the legend as the "Extremality bound." Black circular points labeled "BHs with corrections" lie along and slightly below this line, clustering close to it and approaching it toward large M and Q. Axis annotations are only the italic labels M and Q. The main visible result is that the corrected black holes saturate or remain just below the extremality bound across the plotted range.
// [figvision] imgs/graphWGC.png
// Panel a: A plot of mass M on the vertical axis versus charge Q on the horizontal axis, both originating at the
// lower-left corner and extending to the upper right, with no numerical tick marks or ranges shown. A solid
// straight diagonal line runs from the origin to the top-right corner, identified in the legend as the
// extremality bound. A series of filled black circular marks lies below this line, roughly parallel to it,
// identified in the legend as BHs with corrections. The marks cluster close to but under the line, indicating
// smaller black holes remain sub-extremal relative to the large-black-hole extremality bound. A boxed legend
// below the plot maps the solid line to Extremality bound and the filled dot to BHs with corrections.
#figure(placement: top, image("imgs/graphWGC.png", width: 100%),
  caption: [
    Graph of charge $cal(Q)$ versus mass $M$, where the line indicates the extremality bound for a large BH, and the marks represent smaller BHs.
  ]
) <fig:graphWCG>

For this story to work out, there is an assumption about the possible higher derivative terms that can occur built into this argument. Interestingly, this pattern of higher derivative corrections have been found to hold in certain string theory setups (see e.g. @Kats:2006xp), and there is a significant amount of research dedicated to investigate whether such assumptions on higher derivative terms can be related to other IR consistency criteria, as explained next. \

#underline[Positivity constraints from unitarity and causality]: \

The above evidence relies to some extent on specifics of the theory in which the BHs live. But there are several works trying to derive model independent results, based on the concepts of unitarity and causality, to check if positivity constraints can provide any definite answer as to the direction of the corrections to the BHs, see e.g. @Cheung:2018cwt @Hamada:2018dde. Interestingly, it seems that positivity constraints indeed imply @hd under mild assumptions of the UV theory which are realized in string theory. Along a different but related avenue,
interesting relations between the WGC and analyticity and causality appear when studying the difference in the low energy theory between integrating out charged states that satisfy or do not satisfy the WGC @Andriolo:2018lvp. \

#underline[Relation to Weak Cosmic Censorship]: \

The WGC has interesting relations to Weak Cosmic Censorship, which forbids the presence of naked singularities not hidden by a horizon. The latter has been extensively tested in the context of general relativity in four dimensions, although there are some known possible counterexamples involving an electric field that grows in time without bound. A few years ago, it was shown in @Crisford:2017gsb that if that theory also includes states that are charged under the gauge field and satisfy the WGC, then the theory does not violate Weak Cosmic Censorship any
more. Some work is currently going into trying to understand the connections between the WGC and Weak Cosmic Censorship in more detail by generalizing the above setup. It would certainly be interesting if it turns out that we always need to satisfy the WGC or some other Swampland conjecture to preserve Weak Cosmic Censorship. \

#underline[AdS/CFT]: \

Evidence for the WGC has also been obtained in the framework of AdS/CFT. Specifically, the WGC has been derived from imposing modular invariance of a 2d CFT @Montero:2016tif, @Heidenreich:2016aqi, so it applies in the context of "AdS"_3 / "CFT"_2 but also for any gauge field with a worldsheet description in string theory. It would be very interesting to find similar arguments for higher dimensional CFTs. Further evidence has been found in AdS/CFT by studying thermalization properties of the CFT @Hod:2017uqc, @Urbano:2018kax, as well as from quantum
information theorems related to entanglement entropy @Montero:2018fns.

=== Evidence from String Compactifications <sec:evidenceWGC>

Finally, and very importantly, there is a plethora of examples and works in the context of string theory compactifications, which is the main focus of these lectures. Some of these examples will be discussed in more detail in @sec:SDC-ST-evidence, since they provide evidence both for the WGC and the Distance Conjecture. However, we will already outline the basic features here in an attempt to give some intuition for how the WGC is usually realized in string theory. A summary of the string theory evidence can also be found in @Palti:2019pca. \

#underline[$S O \( 32 \)$ heterotic string on $T^6$:] \

The most typical example, that already appeared in the original paper @ArkaniHamed:2006dz, is a toroidal compactification of heterotic string theory. Compactifying the $S O ( 32 )$ heterotic string on $T^6$ yields a theory with 16 supercharges, i.e. $cal(N) = 4$ supergravity in 4d. Since we have a perturbative description of this theory, the full perturbative spectrum is readily available, and it is known to form a self-dual lattice, charged under the $U ( 1 )^28$ gauge group. The extremal BH solutions of this theory are also known. The non-BPS extremal BHs satisfy
$
  M^2 = frac(2, alpha^' ) abs(q)^2
$
If one studies the non-BPS states in that theory, they do not saturate this extremality bound, rather the
$
  m^2 = frac(2, alpha^') ( abs(q)^2 - 2 )
$<mhet>
So if we plot the mass versus the charge, as in @fig:graphWCGhetstring, with the straight line indicating the extremality bound, i.e. where the extremal BHs live, the states (i.e. the particles) indeed lie below this curve. Hence, the theory satisfies the WGC, and the states approach the extremal value for very large charges. This piece of evidence is particularly nice, because it concerns non-BPS states and not just supersymmetric particles. \

// vision: This is a two-dimensional scatter plot with an overlaid straight line. The horizontal axis is labeled q, marked at 2, 4, 6, 8, and 10, spanning 0 to 10. The vertical axis is labeled √α′M, marked at 5, 10, and 15, spanning 0 to 15. The legend lists two entries: a solid black line for "Non-BPS extremal BH" and black circular dots for "Non-BPS states." The line rises linearly from the origin to about q = 10, √α′M = 14. Black dots appear at roughly q = 1.5 through 10, lying close to the line, with √α′M reaching about 14 at q = 10.
// [figvision] imgs/graphWGChetstring.png
// Panel (a) shows a two-dimensional graph of mass versus charge. The vertical axis is labeled √α′ M and runs
// from 0 to 15 with ticks at 5, 10, and 15. The horizontal axis is labeled q and runs from 0 to 10 with ticks at
// 2, 4, 6, 8, and 10. A solid black straight line rises from the origin to approximately q = 10, √α′ M = 14,
// representing the non-BPS extremal black hole bound. Filled black circular dots mark individual non-BPS states;
// roughly twelve points lie close to but generally below the line, ending near q = 10 and √α′ M ≈ 14. A legend
// identifies the solid line as Non-BPS extremal BH and the filled circles as Non-BPS states.
#figure(placement: top, image("imgs/graphWGChetstring.png", width: 100%),
  caption: [
    Graph of charge $q$ versus mass $M$, where the line indicates the extremality bound for non-BPS BHs, and the marks represent non-BPS states of the theory.
  ]
) <fig:graphWCGhetstring>

#underline[Closed string gauge fields in Type II:] \

In Type II compactifications, there are abelian gauge fields arising from dimensionally reducing the RR and NS 10D gauge potentials. They always come together with charged states coming from wrapping D-branes and NS5-branes. In supersymmetric compactifications, sometimes it is somewhat automatic that the WGC is satisfied because the BPS states themselves saturate the WGC. In this way, the WGC can be thought of as an anti-BPS bound, although this will be explained in more detail in @sec:sharpening-wgc. For example, the supersymmetric mass $M_(D_p)$ of a
brane wrapping the cycle $gamma_p$ is given, according to the DBI action, by the string scale over the string coupling times the volume that it is wrapping $cal(V)_gamma$
$
  M_(D_p) (gamma_p) = 2 pi frac(M_s, g_s) cal(V)_gamma
$
In 4d Planck units this becomes
$
  M_(D_p)(gamma_p) = sqrt(pi) M_p frac(cal(V)_gamma, cal(V)) ,
$
where $cal(V)$ is the overall volume of the compactification space. Notice that any time we are checking a Swampland conjecture, it is very important to go to the Einstein frame, and write every mass in Planck units. Hence, when talking about light states in the Swampland program, we always refer to light with respect to the Planck mass.

One might think that, since the mass is proportional to the volume of the cycle, maybe we can violate the WGC by making this cycle very large, so the state becomes very massive. However, this will also change the gauge coupling as the gauge field comes from dimensionally reducing $C_(p + 1)$ on the same cycle $gamma_p$. In fact, if the state is BPS, in the asymptotic weak coupling limit the gauge coupling has the same dependence than the mass in Planck units,
$
  frac(M_(D_p)(gamma_p), M_p) tilde.eq g
$
saturating the WGC. A proper analysis requires the inclusion of scalars in the extremality bound, which is postponed to @sec:WGCscalars. It will also be discussed in detail in @sec:typeII-CY \

#underline[Open string gauge fields:] \

If we instead focus on open string gauge fields, one could try to play the same game. So, given some branes with a gauge field living on them, we can have strings suspended between the branes, giving rise to charged states, see @fig:openstring1. One could try to violate the WGC in this setup by increasing the mass of these charged states. This can be done by increasing the distance between the branes as the mass of the charged strings is proportional to the distance. Unlike in the previous setup with closed string gauge fields, here the gauge coupling
remains constant, as it is not sensitive to the distance between branes. However, in a compact space, it is not possible to increase the distance between the branes as much as we want without also increasing the overall volume of the compactification space. Increasing the overall volume decreases the gravitational strength, since it results in a larger value for the Planck mass. For this reason, there is a maximum value of the mass measured in Planck units that can be attained by increasing the distance between branes, implying that beyond that point,
the charge to mass ratio in Planck units remains constant $frac(Q M_p, m) tilde.op "const." thin .$

// vision: This is a schematic diagram, not a plotted graph. Two light cyan rectangular planes with gray borders face each other vertically, separated by empty space. A blue wavy curve runs horizontally between the planes, oscillating with decreasing amplitude as it approaches the right plane; the line fades to lighter blue near its right end. Black arrows point outward horizontally from both sides of the planes: a left-pointing arrow on the left and a right-pointing arrow on the right. There are no axes, units, numerical ranges, legend entries, annotations, or data series labels.
// [figvision] imgs/openstring1.png
// The figure is a single schematic diagram showing an open string stretched between two D-branes. Two pale cyan
// rectangular planes with dark gray borders stand vertically and slightly tilted, facing each other across a
// central gap. A thick blue wavy line represents the open string, anchored at an interior point on the left
// brane and terminating at an interior point on the right brane; the string undulates with one crest and one
// trough before flattening near the right brane. Thin gray horizontal arrows protrude outward from the far left
// and far right, indicating extension along the brane worldvolume. No axes, scales, units, series, symbols, or
// numerical annotations are present. The image conveys the geometric setup of a string with endpoints fixed on
// separate branes.
#figure(placement: top, image("imgs/openstring1.png", width: 100%), caption: [Open string suspended between a set of D-branes.],) <fig:openstring1>

Upon compactification to lower dimensions, there is a richer set of possible limits that one can take varying both the mass and the charge. We could think of violating the WGC by sending a gauge coupling to zero and parametrically decreasing the charge of any state. Consider for example the open string gauge fields from a stack of D7-branes wrapping some divisor (co-dimension 1 subvariety) $C_A$ in an F-theory compactification. We can send the gauge coupling to zero by sending the volume of this divisor to
infinity, $ 1 \/ g_(D 7) tilde.op "vol" ( C_A ) arrow.r oo thin . $ However, we are going to run into the same above problems of increasing the overall volume and decreasing $M_p$, unless we are able to engineer a so-called equi-dimensional limit, in which the overall volume does not change.

This is possible by simultaneously decreasing the volume of another cycle $C_B$ while increasing the volume of $C_A$, so that the overall volume $cal(V)$ is This is possible by simultaneously decreasing the volume of another cycle $C_B$ while increasing the volume of $C_A$, so that the overall volume $cal(V)$ is kept fixed, i.e.
$
  "vol" ( C_A ) arrow.r oo thin quad quad "vol" ( C_B ) arrow.r 0 thin quad quad "s.t." quad quad cal(V) tilde.op "const."
$

However, as shown in @Lee:2018urn, the curve $C_B$ will have a non-zero intersection with $C_A$, and a D3-brane wrapping $C_B$ will give rise to a string charged under the D7-brane gauge sector whose tension is proportional to the volume of $C_B$. The mass of the string excitation modes will then go to zero,
$
  M_(D 3) ( C_B ) tilde.op "vol" ( C_B ) arrow.r 0
$
as $g_(D 7) arrow.r 0$, in a way consistent with the WGC. See @fig:openstring2 for an illustration. Hence, once again, the WGC is satisfied; in this case, thanks to the presence of the string modes arising from a wrapping D3-brane. This example will be discussed in more detail in @sec:SDC-5d-N1.

// vision: This is a schematic string-theory diagram, not a data plot, with no axes, units, or numerical ranges. A large light-green bean-shaped region labeled C_A fills most of the frame with a dark-green outline. Inside it on the left are three vertical cyan elliptical sheets labeled “D7-branes” by an arrow; inside it on the right is a gray spiral labeled “D3-branes” by an arrow. Two black curves originate near the bottom-left label C_B, one threading through the D7-branes and another extending toward and past the D3-branes off the right edge. C_B and C_A annotate the bottom left and bottom right.
// [figvision] imgs/openstring2.png
// This single-panel schematic depicts a light green irregular oval domain enclosed by a dark green boundary. At
// the left edge, a stack of nested light blue vertical ellipses represents D7-branes, identified by an
// upper-left label with an arrow. A black curve labeled C_B rises from the bottom left, crosses the domain’s
// lower edge, and traverses the green interior. On the right, a grey spiral denotes D3-branes, indicated by an
// upper-right label and arrow; a black line runs from this spiral leftward into the domain and continues briefly
// to the right beyond it. The text C_A sits at the bottom right outside the shape. The diagram illustrates
// intersecting brane stacks and curves within a compact space, with brane gauge coupling and D3-brane tension
// both approaching zero in the equi-dimensional limit described by the caption.
#figure(placement: top, image("imgs/openstring2.png", width: 100%),
  caption: [
    Equi-dimensional limit. In order for the overall volume to remain finite while the volume of the divisor $C_A$ goes to infinity, there must exist another curve $C_B$ which intersects $C_A$ and whose volume goes to zero. The gauge coupling of the D7-brane gauge sector wrapping $C_A$ will go to zero while the tension of a D3-brane wrapping $C_B$ will also go to zero.
  ]
) <fig:openstring2>

// [figvision] imgs/convexhullvssep.png
// The figure shows a single plot in the z_1–z_2 plane, with z_1 on the horizontal axis and z_2 on the vertical
// axis, both increasing away from the origin with an arrowhead on the z_1 axis. A light-gray quarter-disk
// occupies the first quadrant, bounded by a circular arc connecting a black dot on the z_2 axis to a black dot
// on the z_1 axis; this gray region is the extremal region saturating the weak gravity conjecture. A straight
// black line, the convex hull of the two states' charge-to-mass ratios, connects the two black dots directly,
// cutting through the interior of the gray quarter-disk rather than lying on its boundary. Because this chord
// passes below the circular arc, the convex hull does not satisfy the convex hull condition of the WGC. No
// units, numerical tick values, or additional series are shown.
These examples are intended to give some intuition for how string theory typically defeats our attempts to violate the WGC. We will get deeper into these examples and the geometric structures underlying the relations between the charges and masses in @sec:SDC-ST-evidence.

== Multiple Gauge Fields and the Convex Hull Condition <sec:convex-hull-WGC>

So far we have discussed the WGC in the presence of a single gauge field, but how does one properly define the conjecture in the presence of several gauge fields? One could have guessed that it is enough to require the existence of a particle for each gauge field with a charge to mass ratio bigger than the extremality bound, but this turns out not to be sufficient. Instead, the correct generalization is a requirement known as the Convex Hull Condition. \

#block[
#strong[Convex Hull WGC.] For multiple $U ( 1 )$ gauge fields, the WGC is satisfied if the convex hull of the charge to mass ratio $arrow(z) = arrow(Q) \/ m$ of all the states contains the extremal region @Cheung:2014vva.

]

Consider the example of two $U ( 1 )$ s, shown in the plot in @fig:convexhull. If we determine the extremal region, i.e. the region in this plane that allows for BHs to exist, and plot the charge to mass ratio $arrow(z)$ of all the states, then the requirement is that the convex hull of the charge to mass ratio of the states in the theory includes the extremal region. This ensures that there is always some particle with a charge to mass ratio bigger than the extremality factor along #emph[any] rational direction of the charge space.

// [figvision] imgs/convexhull.png
// The figure has one panel. It is a plot. The axes are z_1 and z_2 with equal ranges that are not quantified;
// the units are not specified. There is one series of black dots representing charge to mass ratios of states.
// The dots are connected by black lines forming a convex hull. A gray circle represents the extremal region. The
// trend or message is that the extremal region is contained within the convex hull of the charge to mass ratios
// of the states. The layout indicates the extremal region's boundary does not intersect the hull.
#figure(placement: top, image("imgs/convexhull.png", width: 100%),
  caption: [
    Plot of charge to mass ratios $arrow(z) = ( z_1 z_2 )$ of a set of states for two $U ( 1 )$ gauge fields. The extremal region is indicated in gray. It is contained in the convex hull of the charge to mass ratios of the states, indicated by the black lines. The WGC is satisfied.
  ]
) <fig:convexhull>

Here we see that having a set of states saturating the WGC separately for each gauge field would cut into the extremal region, see @fig:convexhullvssep, so it is not enough to satisfy the Convex Hull Condition. Therefore, the Convex Hull Condition is clearly a stronger statement than requiring the WGC to be satisfied for each $U ( 1 )$. Essentially this condition allows BHs with #emph[any charge] under both gauge fields to decay. This puts non-trivial constraints on the EFTs.

// [figvision] imgs/convexhullvssep.png
// The figure shows a single plot in the z_1–z_2 plane, with z_1 on the horizontal axis and z_2 on the vertical
// axis, both increasing away from the origin with an arrowhead on the z_1 axis. A light-gray quarter-disk
// occupies the first quadrant, bounded by a circular arc connecting a black dot on the z_2 axis to a black dot
// on the z_1 axis; this gray region is the extremal region saturating the weak gravity conjecture. A straight
// black line, the convex hull of the two states' charge-to-mass ratios, connects the two black dots directly,
// cutting through the interior of the gray quarter-disk rather than lying on its boundary. Because this chord
// passes below the circular arc, the convex hull does not satisfy the convex hull condition of the WGC. No
// units, numerical tick values, or additional series are shown.
// vision: This is a two-dimensional schematic plot in the first quadrant with a vertical z2 axis and horizontal z1 axis meeting at the origin, both ending in arrowheads; no tick labels, units, or numeric ranges are shown. Two filled black dots mark points on the positive z2 and z1 axes at equal distance from the origin. A straight diagonal line segment joins the dots (a chord), while a quarter-circle arc centered at the origin also joins them, bowing outward away from the origin. The enclosed region is shaded light gray; there is no legend or annotation.
// [figvision] imgs/convexhullvssep.png
// The figure shows a single plot in the z_1–z_2 plane, with z_1 on the horizontal axis and z_2 on the vertical
// axis, both increasing away from the origin with an arrowhead on the z_1 axis. A light-gray quarter-disk
// occupies the first quadrant, bounded by a circular arc connecting a black dot on the z_2 axis to a black dot
// on the z_1 axis; this gray region is the extremal region saturating the weak gravity conjecture. A straight
// black line, the convex hull of the two states' charge-to-mass ratios, connects the two black dots directly,
// cutting through the interior of the gray quarter-disk rather than lying on its boundary. Because this chord
// passes below the circular arc, the convex hull does not satisfy the convex hull condition of the WGC. No
// units, numerical tick values, or additional series are shown.
#figure(placement: top, image("imgs/convexhullvssep.png", width: 100%),
  caption: [
    Plot of charge to mass ratios $arrow(z) = ( z_1 z_2 )$ of two states saturating the WGC for the $U ( 1 )^( 1 )$ and $U ( 1 )^( 2 )$ gauge fields, separately. The extremal region is shown in gray, and the convex hull of the charge to mass ratios of the states is indicated by the black line. The WGC convex hull condition is not satisfied.
  ]
) <fig:convexhullvssep>

The extremal region is sometimes called a unit ball, since for simplicity we tend to set the charge to mass ratio of an extremal black hole to 1. This terminology can be somewhat confusing because, first, the extremal region is not necessarily of radius one (it is some $cal(O) ( 1 )$ constant), and, second, when scalar fields are present it is not necessarily even a ball. The extremal region can then be an ellipse or have straight lines, as discussed in @sec:WGCscalars.

== Strong Versions of the WGC <strong-versions-of-the-wgc>

One of the main open questions in the WGC is: how do we identify #emph[which] states satisfy the WGC? This question is very important in order to be able to derive phenomenological implications of the conjecture. The formulation of the conjecture given so far contains no statement, or even indication, of whether there should be one or several states satisfying the WGC, if they need to be very light, have a very small charge, or the biggest charge to mass ratio, etc. In this sense, there is a mild version and many strong versions of the WGC. The mild
version simply says that there must be #emph[some] state (any state) that satisfies the WGC. It can even be above the EFT cut-off, so in this form the conjecture does not have any implications at low energies. Contrary to this, the strong versions specify which state(s) should satisfy the WGC. Such refinements typically imply particles below the cut-off, leading to potential phenomenological constraints.

For this purpose, a lot of the recent research has precisely been dedicated to understanding this question, by investigating the structure of the states satisfying the WGC in string theory setups. In fact, there was an attempt in the original paper to get a strong version of the conjecture, by identifying the WGC-particle with the lightest one, the one with smallest charge, or the one with the biggest charge to mass ratio. However, these stronger versions are not well-defined in the presence of several gauge fields. At the moment the available strong
versions that are consistent with everything we know and any string theory example are the Sublattice WGC @Montero:2016tif @Heidenreich:2016aqi @Heidenreich:2015nta or the Tower WGC @Andriolo:2018lvp, which require the states satisfying the WGC to form a (full dimensional) sublattice of the charge lattice or a tower, respectively. The two proposals are very similar, however it is slightly stronger to require a sublattice of superextremal states than requiring a tower. It is also expected that the conjectures might be satisfied by unstable resonances but
not by multiparticle states. \

#block[
#strong[Sublattice/Tower WGC.] For every site $arrow(q)$ of the charge lattice, there is a positive integer $n$ such that there is a superextremal state with charge $n arrow(q)$ satisfying the WGC. This integer can depend on $arrow(q)$ for the Tower version, while it is universal for the Sublattice.

]

The main motivation for these proposals comes from demanding that the WGC is consistent under dimensional reduction @Heidenreich:2015nta. Starting from a theory with a single particle satisfying the WGC, when this theory is dimensionally reduced it can result in an EFT that does not satisfy the WGC anymore. On the other hand, starting with a sublattice (or an infinite tower) of states satisfying the WGC ensures that the dimensionally reduced theory will also satisfy the WGC. So it is exactly this consistency under dimensional reduction that requires the
// [figvision] imgs/convexhullKK.png
// A single plot has vertical axis z_KK and horizontal axis z_U(1), both from zero. A gray quarter-disk fills the
// lower-left corner as the extremal region, bounded by a thin circular arc meeting the z_U(1) axis at point 0
// and the z_KK axis at top left. Black dots labeled 0, 1, 2, 3 lie on the arc from the z_U(1) axis upward toward
// the z_KK axis, with dot 3 beside smaller points and an ellipsis marking an infinite tower continuing up the
// z_KK axis. The KK states trace the extremal boundary, and their approach to the gray region shows the weak
// gravity conjecture fails in the lower-dimensional theory.
existence of infinitely many states satisfying the WGC in the original theory. Arguments from unitarity and causality @Andriolo:2018lvp motivates the weaker version in which an infinite tower (instead of a sublattice) suffices, which also relates to the Distance Conjecture as discussed in @Andriolo:2018lvp. However, up to now, there is no known string theory counterexample to the Sublattice WGC (see though @Lee:2019tst for a potential candidate). In the following, we will see two key examples that were important in motivating these stronger versions,
based on consistency under dimensional reduction. \

#underline[Kaluza-Klein circle compactification:] \

Consider a theory with a $U ( 1 )$ gauge field and some particle that satisfies the WGC, so that it has charge to mass ratio $ z_0 = q_0 \/ m_0 gt.eq 1 thin . $ Dimensionally reducing the theory by compactifying on a circle $S_R^1$ of radius $R$, will give rise to a lower dimensional $U ( 1 )$ gauge field, as well as an extra Kaluza-Klein (KK) $U ( 1 )$ gauge field. The zero mode of the original particle with charge to mass ratio $z_0$ will still satisfy the WGC for the U(1) gauge field in lower dimensions. There will also be states charged under the extra $U ( 1 )$, namely the KK modes with
$
  m_(K K)^2 = m_0^2 + frac(q_(K K)^2, R^2) , quad g_(K K) = 1 \/ R
$
and $q_(K K) = n$ with $n$ being an integer. So here we see that, if there are massless states in the original theory (i.e. $m_0 = 0$), the KK modes of these massless states are going to saturate the WGC for the KK gauge field, since their mass will be equal to their charge. Thus, it is automatic in a KK compactification, that the KK modes of e.g. the graviton saturate the WGC.

However, we have learned that in the presence of multiple $U ( 1 )$ gauge fields, we must impose a stronger condition than satisfying the WGC for each $U ( 1 )$. We must require that the Convex Hull Condition is satisfied. In the lower dimensional theory, the charge to mass ratio vector of the KK modes of the original WGC-satisfying particle is given by
$
  vec z = (z_(U(1)), z_(K K)) = frac((q_0, q_(K K)\/R), sqrt(m_0^2 + q_(K K)^2 \/ R^2))
$
as they are charged both under the original $U ( 1 )$ gauge field and the KK photon.

If we plot this charge to mass ratio in the two directions spanned by the KK photon and the original gauge field, we get @fig:convexhullKK. We can see that the states lie on an ellipsoid satisfying
$
  z_(U(1))^2 \/ z_0^2 + z_(K K)^2 = 1 ,
$
outside the extremal region. However, since they only populate a finite region of the ellipsoid, they are not always enough to satisfy the WGC as their convex hull can cut the extremal region as represented in @fig:convexhullKK. It can be checked that the convex hull WGC will only be satisfied if the following relation holds,
$
// [figvision] imgs/convexhullKK.png
// A single plot has vertical axis z_KK and horizontal axis z_U(1), both from zero. A gray quarter-disk fills the
// lower-left corner as the extremal region, bounded by a thin circular arc meeting the z_U(1) axis at point 0
// and the z_KK axis at top left. Black dots labeled 0, 1, 2, 3 lie on the arc from the z_U(1) axis upward toward
// the z_KK axis, with dot 3 beside smaller points and an ellipsis marking an infinite tower continuing up the
// z_KK axis. The KK states trace the extremal boundary, and their approach to the gray region shows the weak
// gravity conjecture fails in the lower-dimensional theory.
  ( m_0 R^2 ) gt.eq frac(1, 4 z_0^2) ( z_0^2 - 1 )
$
This implies that the Convex Hull Condition is violated unless the radius is very large or we started with a very superextremal particle. Otherwise, the dimensionally reduced theory will violate the WGC, even if it was satisfied in higher dimensions.

// vision: Two-dimensional plot with vertical axis $z_{KK}$ and horizontal axis $z_{U(1)}$, shown without numeric tick labels, units, or axis ranges. A gray shaded region fills the lower-left portion beneath a curved boundary. Black dots labeled 0, 1, 2, 3, … (with ellipsis) lie along the upper-left boundary; dot 0 sits on the horizontal axis at the lower right, dot 3 is upper-left, and dots decrease leftward and upward. A straight line segment connects dot 1 to dot 0. No legend or annotations are present; no explicit quantitative values or main result can be read from the figure itself.
// [figvision] imgs/convexhullKK.png
// A single plot has vertical axis z_KK and horizontal axis z_U(1), both from zero. A gray quarter-disk fills the
// lower-left corner as the extremal region, bounded by a thin circular arc meeting the z_U(1) axis at point 0
// and the z_KK axis at top left. Black dots labeled 0, 1, 2, 3 lie on the arc from the z_U(1) axis upward toward
// the z_KK axis, with dot 3 beside smaller points and an ellipsis marking an infinite tower continuing up the
// z_KK axis. The KK states trace the extremal boundary, and their approach to the gray region shows the weak
// gravity conjecture fails in the lower-dimensional theory.
#figure(placement: top, image("imgs/convexhullKK.png", width: 100%),
  caption: [
    Plot of charge to mass ratios $arrow(z) = ( z_(U ( 1 )) z_(K K) )$ of KK modes of a particle charged under a higher dimensional $U ( 1 )$ gauge field and originally satifying the WGC $z_0 > 1$ in higher dimensions. The extremal region is indicated in gray. The states are labelled by $q_(K K) = n in bb(Z)$. The WGC is not satisfied in the lower dimensional theory.
  ]
) <fig:convexhullKK>

The solution that was proposed in @Heidenreich:2015nta was to start with a tower of states satisfying the WGC already the original theory in higher dimensions instead of a single particle. This tower will then give rise to lower dimensional states that will exactly lie on the extremal region, filling the entire ball and satisfying the Convex Hull Condition in lower dimensions.

It is an interesting proposal, because this is in fact the way in which the WGC is satisfied in typical string theory compactifications. Take e.g. the case of Type IIA string theory on a circle, which has the $C_1$ gauge field as well as a KK photon. To satisfy the Convex Hull WGC we need to have not just one particle but a charged tower under $C_1$ in the original 10d theory. This tower of particles is precisely the tower of D0-branes, which are the KK modes from M-theory. So precisely because Type IIA already has this tower of charged states
(which signals the extra M-theory direction when taking the strong coupling limit), the WGC continues to be satisfied under dimensional reduction to 9d. There are many more examples of this phenomenon in string theory, where not only one state but towers of them satisfy the WGC. Furthermore, if one focuses on toroidal compactifications, one finds that there is a superextremal state for each point of the entire charge lattice. This provides a stronger version of the Completeness Hypothesis. However, in more general situations, only a sublattice is
populated by superextremal states, as explained next. \

#underline[Toroidal Orbifold Compactifications:] \

// [figvision] imgs/massgaptower.png
// The figure is a single schematic panel showing a vertical mass axis M with an upward arrow at the top. A
// horizontal dashed line marks the cutoff Λ_QG near the top. One solid horizontal line lies above the dashed
// line, and five solid horizontal lines lie below it, spaced roughly evenly. On the right, a curly brace
// labelled Δm brackets the lowest three lines. The dashed cutoff separates a single state above from a tower of
// states below, each separated by a mass gap Δm.
Consistency under dimensional reduction was first used to formulate a Lattice WGC (since toroidal compactifications always give rise to a lattice), but in @Heidenreich:2016aqi it was shown, by studying toroidal orbifold compactifications, that only a sublattice of states satisfies the WGC. Consider a toroidal orbifold e.g. $ T^3 \/ bb(Z)_2 times bb(Z)'_2 , $ where each $bb(Z)_2$ acts freely, so we mod out by a "rototranslation" symmetry. Compactification on the three-torus gives rise to a set of KK $U ( 1 )$ gauge fields

$
  "KK photons of " T^3 : W_mu , quad Y_mu , quad Z_mu .
$

However, due to the orbifold, one of the KK photons, say $W_mu$, is projected out. The corresponding KK modes stay, which has non-trivial implications. In fact, the KK modes associated to odd charge $n_Y$ under $Y_mu$ receive a contribution from the KK modes of $W_mu$, so that these odd charge states are actually subextremal. Hence, it is only a sublattice of states (with even $n_Y$ charge) that satisfy the WGC. This was the first example to suggest the idea of the sublattice, confirmed by the results using modular invariance of the CFT @Montero:2016tif.


=== Species Bound Cut-Off

When there is not just one but infinitely many weakly coupled states, e.g. a sublattice or tower of states, becoming light, this implies a drastic breakdown of the EFT by quantum gravitational effects. Therefore, there is a natural QG cut-off associated to a tower of states known as the Species Bound @ArkaniHamed:2005yv @Dvali:2007wp @Dvali:2007hz @Dvali:2010vm.

The basic idea is that gravity becomes strongly coupled if there are too many light fields. Assuming that perturbative techniques work, one can check that the graviton propagator gets renormalized due to the presence of light degrees of freedom, so the QG cut-off is actually given by
$
  Lambda_("QG") = frac(M_p, N^(1\/(d-2))) ,
$<species>
where $d$ is the spacetime dimension and $N$ is the number of light species.

Hence, the QG cut-off is smaller than the Planck scale, so quantum gravitational effects become important earlier than one would naively expect. The same species bound has been motivated using non-perturbative arguments based on black hole physics @Dvali:2007wp @Dvali:2007hz.

For a tower of states, the number of light species, i.e. how many states there are below $Lambda_("QG")$, is related to the mass gap of the tower as follows,
$
  N = frac(Lambda_("QG"), Delta m)
$ <Nsepcies>
// [figvision] imgs/massgaptower.png
// The figure is a single schematic panel showing a vertical mass axis M with an upward arrow at the top. A
// horizontal dashed line marks the cutoff Λ_QG near the top. One solid horizontal line lies above the dashed
// line, and five solid horizontal lines lie below it, spaced roughly evenly. On the right, a curly brace
// labelled Δm brackets the lowest three lines. The dashed cutoff separates a single state above from a tower of
// states below, each separated by a mass gap Δm.
Plugging this into @species one finds that the species scale behaves as
$
  Lambda_("QG") = M_p^((d-2)\/(d-1)) (Delta m)^(1\/(d-1))
$ <speciesm>
When the full tower is getting light, they are also getting more degenerate in mass, so the QG cut-off goes to zero. If the states in the tower saturate the WGC, the mass gap is proportional to the gauge coupli
$
  Delta m tilde.eq g
$
so the QG cut-off scales with a power of the gauge coupling itself,
$
  Lambda_("QG") tilde.eq g^(1\/(d-1)) M_p^((d-2)\/(d-1))
$
Therefore, we see that this QG cut-off goes to zero as the gauge coupling goes to zero. This situation is similar to what we encountered in the magnetic WGC, but here the cut-off is not motivated by the presence of monopoles, but by the infinite tower of states that are becoming light. Unlike for the magnetic cut-off, this truly signals a drastic break down of the effective field theory by quantum gravitational effects.

// vision: This is a black-and-white schematic diagram with magnetization $M$ on a vertical axis (arrow upward, no numerical units or ranges). A dashed horizontal line marks $\Lambda_{QG}$ on the $M$ axis. Several solid horizontal lines represent discrete magnetization levels, with one line above the dashed line and multiple below. A curly brace on the right labeled $\Delta m$ spans the lower levels to indicate uniform spacing between adjacent lines. There are no colored curves, legend entries, numerical axis ranges, or further annotations; the visible result is quantized $M$ levels referenced to $\Lambda_{QG}$ with spacing $\Delta m$.
// [figvision] imgs/massgaptower.png
// The figure is a single schematic panel showing a vertical mass axis M with an upward arrow at the top. A
// horizontal dashed line marks the cutoff Λ_QG near the top. One solid horizontal line lies above the dashed
// line, and five solid horizontal lines lie below it, spaced roughly evenly. On the right, a curly brace
// labelled Δm brackets the lowest three lines. The dashed cutoff separates a single state above from a tower of
// states below, each separated by a mass gap Δm.
#figure(placement: top, image("imgs/massgaptower.png", width: 88%),
  caption: [
    Tower of states separated by a mass gap $Delta m$ in a theory with cut-off $Lambda_("QG")$.
  ]
) <fig:massgaptower>

== Phenomenological Implications <phenomenological-implications>

Among all the possible phenomenological implications of the Weak Gravity Conjecture and its refined versions, let us discuss one that triggered the renewed great deal of activity on the Swampland program in the past five years. We are talking about the implications for large field inflation, more specifically in the context of natural inflation. This was triggered by the following works @Rudelius:2015xta @Montero:2015ofa @Brown:2015iha in response to the increased amount of research on large field inflationary models originated from the BICEP2
announcement about primordial gravitational waves.

Recall that the WGC should apply not only to particles, but to any kind of state that is charged under a $p$-form gauge field. According to this, for any $p$-form gauge field there should exist a $( p - 1 )$-dimensional state whose charge to mass ratio is greater than or equal to the one of the extremal $( p - 1 )$ black brane. One can apply this for axions, that are 0-form gauge fields. The WGC for axions implies that there must exist an instanton with quantized charge $q$ whose action satisfies

$ S lt.tilde q M_p \/ f thin . $<WGCinstanton>

Here, we have used that the equivalent of the mass for an instanton is its action, and that the gauge coupling of an axion is the inverse of its decay constant, $f$. The twiddle in the inequality is due to the lack of extremal solutions for instantons. Since there is no known way to define an extremality bound in this case, the previous bound actually contains an undetermined order one factor.

In natural inflation scenarios, an axion slowly rolls down a non-perturbative potential generated by instantons. It takes the form

$ V ( phi.alt ) tilde e^(- S) cos (frac(2 pi phi.alt, f)) $<eq:axion-potential>

where we have assumed that the leading contribution comes from a charge one instanton and we have neglected the higher harmonics contributions, which are suppressed with respect to the fundamental one. Looking at this expression, we see that the field range available for inflation is of the order of the decay constant. Notice that, if the leading contribution comes from an instanton with quantized charge $q$ greater than one, this field range is smaller, so in general $Delta phi.alt lt.tilde f$.

It is important to take into account that @eq:axion-potential applies in the diluted instanton gas approximation, which requires that $S gt.tilde 1$ to keep control of the instanton expansion. Moreover, if this condition is relaxed in some model, the higher harmonics that we previously neglected will not be suppressed enough anymore and will reduce the field range available for inflation (see @fig:inst-potential). So the maximum field range is attainable by having the non-perturbative potential generated by a charge one instanton with $S gt.tilde 1$.

// [figvision] imgs/inst_potential_v3.png
// Panel a and b: These are plots of potential V versus field . The vertical axis V() has no label or units and
// ranges from approximately -0.7 to 0.9 in panel a and from approximately -0.8 to 0.8 in panel b. The horizontal
// axis has no label or units and appears to range from -3 to 3. Each panel contains two series: a solid blue
// line and a dashed blue line. The solid line represents the fundamental harmonic contribution to the potential,
// while the dashed line includes the first higher harmonic correction. In panel a, for S=2, the dashed line is
// only slightly different from the solid line, and both are monotonic. In panel b, for S=0.5, the dashed line
// deviates significantly from the solid line and is non-monotonic. The trend is that as S decreases, the
// correction to the potential becomes more significant, potentially spoiling the monotonicity of the potential
// and shortening the field range for inflation.
#figure(placement: top, [#block[
  #box(image("imgs/inst_potential_v3.png", width: 100%))
  ]],
  caption: [
    Non-perturbative potential for the axion. The plain line is the fundamental harmonic contribution while the dashed one includes the first higher harmonic correction. Left: The action is larger than one so the correction does not modify the field range available for inflation. Right: For small action the corrections spoil the monotonicity of the potential, shortening the field range for inflation.
  ]
) <fig:inst-potential>

If this instanton satisfies the WGC, we can combine this condition on the action $S gt.tilde 1$ with the WGC bound @WGCinstanton, obtaining $Delta phi.alt lt.tilde f lt.tilde M_p$ which means that transplanckian axionic excursions, and consequently, natural (large field) inflation, is disfavoured by the WGC. Of course what we are considering here is only the simplest case which includes a single axion. One can use the convex hull WGC to place bounds on models with several axions, including N-flation and alignment models.

A loophole in this argumentation is to be noted. It could be the case that the instanton satisfying the WGC is not the one contributing the dominant piece of the potential for inflation. This could happen if both the action $S$ and the quantized charge $q$ of the WGC-satisfying instanton are larger than the ones corresponding to the instanton generating the inflationary potential. In this way, the exponential suppression in @eq:axion-potential is greater for the WGC instanton, but the field range is instead bounded
by $Delta phi.alt lt.tilde f lt.tilde q thin M_p$ where we have considered the best case scenario in which the instanton generating the potential has unit charge. So a transplanckian field range is allowed if the charge of the WGC-satisfying instanton is $q > 1$. However, this requires a somewhat unnatural scenario in which the charge to mass ratio of the WGC instanton is bigger than for the #emph[light] instanton generating the potential, which goes against the monotonicity found in string theory examples and which is explained in
@fig:graphWCGhetstring. Nonetheless, we cannot discard this scenario (see e.g. @Hebecker:2015rya).

Thus we have seen that the mild version of the WGC, in which it is not specified which instanton should satisfy the WGC, is not enough to rule out large field inflation. In order to determine meaningful constraints, some strong version of the WGC is needed. For instance, if the full lattice of WGC states is present, the unit charge one will imply an important constraint for large field inflation. But if only a sublattice is required, as the index of the lattice grows, the quantized charge of the first state satisfying the WGC grows and the constraint
gets weaker. If this index is very large, the implications stop being relevant for constraining large field inflation. This is why constraining the index of the sublattice is one of the most important open questions of research in the WGC. All known string theory examples have an index of order one, but we are lacking a fundamental universal bound. This issue is highly linked to the question of the maximum rank for discrete symmetries; a large sublattice index hints at a large discrete symmetry. However, this rank is expected to be bounded in order to
avoid a global symmetry.

== The Weak Gravity Conjecture with Scalar Fields <sec:WGCscalars>

The presence of massless scalar fields strongly affects the WGC bounds. As discussed in @sec:defWGC, without scalar fields, there are two different but equivalent interpretations of the WGC. We could either think of it as a super-extremality condition or a repulsive force condition in the sense that the gauge repulsion is stronger than the gravity attraction over two equal states. However, these two conditions will not be equivalent any more in the presence of massless scalar fields. Clearly, the second condition gets modified due to the presence of
additional scalar forces, and the extremality bound is also sensitive to the contribution from massless scalars. The current convention is to still identify the WGC with a superextremality condition, while the second interpretation receives the name of the Repulsive Force Condition.

- #underline[#strong[WGC (superextremality condition):]] \

Given some p-form gauge field, $exists$ a superextremal state satisfying $ Q^2 gt.eq gamma ( phi.alt_i ) M^2  $ where the massless scalars ${ phi.alt_i }$ can also contribute to the extremality factor $gamma ( phi.alt_i )$. Recall that this factor is the charge to mass ratio of an extremal black hole in that theory. For instance, a famous example is a dilatonic black hole, which is an extremal black hole solution in an Einstein-Maxwell-dilaton theory in which the gauge kinetic function of the gauge fields is parametrized by (canonically normalised) massless scalars as follows,

$ cal(L) supset frac(1, 2 g_0^2) e^(alpha_i phi.alt_i) F_(p + 1)^2  . $<gaugekinetic>

The scalars induce an additional contribution to the charge to mass ratio of the extremal black holes, so the WGC becomes $Q^2 M_p^(d - 2) gt.eq #scale(x: 180%, y: 180%)[(] frac(| arrow(alpha) |^2, 2) + frac(p ( d - p - 2 ), d - 2) #scale(x: 180%, y: 180%)[)] T^2$ with $Q = q g_0$. By comparing to @RNBH we can see that there is an extra term proportional to the scalar couplings $arrow(alpha) := { alpha_i }$ in @gaugekinetic.
The generalization to multi-fields will again involve a convex hull condition as in @sec:convex-hull-WGC. However, notice that the extremal region will #emph[no longer] be a #emph[unit ball] but will depend on the scalar contribution. For states that are mutually BPS, the extremal region becomes an ellipse, while for states that are non-mutually BPS it develops straight lines. The take-home message is that, in order to check the WGC, it is essential to first know the charge to mass ratio of extremal black holes in that theory, which can vary extremely
from one theory to another if massless scalar fields are present. \

#underline[#strong[Repulsive Force Condition (RFC):]] \

Given some p-form gauge field, $exists$ a state which is self-repulsive, namely the gauge repulsion between two copies of the state acts stronger than the sum of the gravitational and scalar interactions @Palti:2017elp,@Heidenreich:2019zkl, i.e. $ F_("gauge") gt.eq F_("gravity") + F_("scalar")  $ In a d-dimensional theory, each of these forces for a particle of mass $m$ and gauge charge $Q$ take the following
form $ F_("gauge") = Q^2 \/ r^(d - 2)  quad F_("gravity") = frac(m^2, M_p^(d - 2) r^(d - 2)) frac(d - 3, d - 2)  quad F_("scalar") = frac(mu^2, M_p^(d - 2) r^(d - 2))  $<forces> where $mu$ is the scalar Yukawa charge. The scalar Yukawa force emerges whenever the mass $m$ of the state is parametrized by a massless scalar $phi.alt$, as we can always expand the mass term as follows, $cal(L) supset m^2 ( phi.alt ) chi^2 = #scale(x: 180%, y: 180%)[(] m_0^2 + 2 m_0 ( partial_phi.alt m ) phi.alt #scale(x: 180%, y: 180%)[)] chi^2 + dots.h $ where the scalar
Yukawa charge is then given by $mu = partial_phi.alt m$. For the case of a particle in four dimensions, the RFC in ([repulsive force condition]) reads $Q^2 M_p^2 gt.eq 1\/2 m^2 + g^(i j) ( partial_(phi.alt^i) m ) ( partial_(phi.alt^j) m ) M_p^2 $ where we have allowed for the presence of multiple scalars with inverse field metric $g^(i j)$. This condition was first proposed in @Palti:2017elp as the proper interpretation of the WGC in the presence of scalar fields, and later named as the RFC in @Heidenreich:2019zkl.
For a p-form gauge field, we can generalize @forces and derive the existence of a $( p - 1 )$-brane of tension $T$ satisfying $ f^(a b) q_a q_b gt.eq g^(i j) ( partial_(phi.alt^i) T ) ( partial_(phi.alt^j) T ) + frac(p ( d - p - 2 ), d - 2) T^2  $<eq:RFC-general> where we have written explicitly the gauge charge in terms of the inverse gauge kinetic function $f^(a b)$ and gauge quantized charges $q_a$.

Note that [extremality bound with scalars] and @eq:RFC-general are identical apart from the contribution from the massless scalars. In the WGC, the scalars contribute through the dependence in the gauge kinetic function; while in the RFC, they enter through the behaviour of the mass/tension. Consequently, it seems we now have two different bounds, so which one is realised in quantum gravity? This is an open question, although there is no known counterexample for any of the two conditions in string theory, so it might be that both are realised. In fact,
although seemingly different, they coincide in many cases. For instance, string theory evidence shows that they are fulfilled by the same states at the weak coupling limits $g → 0$@Lee:2018spm @Gendler:2020dfp. Furthermore, extremal BPS states saturate both conditions, as by definition they satisfy a no-force condition. In these cases, the charges and masses are related such that the scalar contributions in [extremality bound with scalars] and @eq:RFC-general become equal. This is in fact related to the sharpening of the WGC discussed in the next
section.

== Sharpening the WGC and BPS states <sec:sharpening-wgc>

A sharpening of the WGC was proposed in @Ooguri:2016pdq: \

#block[
#strong[Sharpening of the WGC.] The WGC can only be saturated by BPS states in a supersymmetric theory.

]

This has important implications for the stability of non-susy vacua, as discussed in @Ooguri:2016pdq. The idea is that only supersymmetry can guarantee an exact equality relating the mass and charge of a state. Otherwise, one should expect quantum corrections preventing these physical quantities from saturating the WGC bound.

In the following, we will summarize some examples from string theory compactifications that support this sharpening. Unfortunately, the evidence is scarce. This is due to the difficulties in computing the mass of non-BPS states.

- The first typical example is the toroidal compactification of heterotic string theory, discussed in @sec:evidenceWGC. In this setup, we can compute the whole spectrum perturbatively including non-BPS states. These states do not saturate the WGC as their mass is strictly smaller than the charge,
  $ m^2_("non-BPS") = frac(2, alpha') (|q^2| - 2) < frac(2, alpha') |q^2| = M^2_("BH") ~, $
  as given in @mhet. Indeed, by comparing to the charge to mass ratio of the extremal non-BPS black hole solutions of the theory, these states are superextremal. This is why they lie below the extremal curve in @fig:graphWCGhetstring.

Another example are the exictation modes of strings becoming tensionless at the weak coupling limit of gauge field theories in F-theory CY#sub[3] compactifications. The string arises from wrapping a D3-brane on a shrinking curve. This example was briefly discussed in @sec:evidenceWGC and we will have a more detailed explanation in @sec:evidenceWGC. The string spectrum is given by non-BPS states satisfying $g^2 q^2 = m^2 + 4 j g^2 > m^2$ where $m$ and $q$ are the mass and quantized charge of the state, $g$ the gauge coupling and $j$ some integer depending
on some intersection number defined below @eq:string-excitations. Again, these states are superextremal with respect to the black hole extremality bound, which in the weak coupling limit coincides with a no-force condition.

Higher derivative corrections to non-BPS black holes in heterotic string theory also motivate the sharpening of the WGC. The corrections go in the direction of increasing the charge to mass ratio of small black holes, so they satisfy the strict inequality of the WGC.

Consider some supersymmetric theory with massless scalar fields, so they contribute to the extremality bound as given in [extremality bound with scalars]. Upon compactification, if supersymmetry is preserved, the scalar contribution $| alpha |^2$ changes in such a way as to compensate the variation of the second term in [extremality bound with scalars] due to the change in the space-time dimension. This way, a particle saturating the WGC in higher dimensions will also saturate it in lower dimensions. However, if supersymmetry is broken while
compactifying, the scalars will typically get a mass, so they will not contribute to the extremality bound anymore, since $alpha = 0$. Hence, the charge to mass ratio of extremal black holes decreases, and a previously extremal particle will become superextremal with respect to the new extremality bound in the lower dimensional non-supersymmetric theory. More generally, since the scalar contribution to the extremality bound is positive, this helps to make the states satify the strict inequality when supersymmetry gets broken and the states are no longer
BPS.

All the previous items are examples of non-BPS states satisfying the strict inequality of the WGC, and not saturating it, in agreement with the sharpening of the WGC above, according to which, only BPS states could exactly saturate the WGC. If that happens, then the BPS state is saturating both the WGC and the RFC (as it feels no force), so the scalar contributions in [extremality bound with scalars] and @eq:RFC-general coincide. One should keep in mind, though, that it is not necessary for a BPS state to saturate the WGC; there are examples of
non-extremal BPS states near finite distance singularities of the moduli space, e.g. conifold singularities. Contrary, BPS states becoming light at the infinite field distance singularities are typically extremal @Gendler:2020dfp.

If the sharpening of the WGC is true, it predicts interesting conditions on the geometry of string theory compactifications. For instance, take M-theory compactified on $K 3$ where M2-branes can wrap non-holomorphic curves, so the resulting states are non-BPS. Then, validity of the sharpened version of the conjecture implies that the mass associated to the area of two-cycles has to be smaller than the charge which can be obtained by integrating the Kähler class over the two-cycle. A check of this geometric statement would provide a robust piece of
evidence for the sharpened WGC. Another example would be to consider M-theory on $G 2$ manifolds. Since the resulting 4d theory is $cal(N) = 1$, the particles are non-BPS. According to the sharpened WGC, these states should satisfy only the strict inequality of the WGC.

== Open Questions <open-questions>

Here, to conclude the WGC, we mention some of the key open questions as well as some generalizations and other current avenues of research that we did not cover in these lectures:

- WGC version for discrete gauge symmetries. Some proposals have appeared, see e.g. @Craig:2018yvw and $Z_K$ Weak coupling conjecture in @Buratti:2020kda.
- Bottom-up motivation of the WGC for axions and low codimension objects. There are no extremal black hole solutions of such dimensionalities, so the motivation for the WGC based on black hole physics is missing in these cases.
- Very little evidence in non-susy setups.
- Better understanding of the interplay between the extremality bound, the BPS bound and the repulsive force condition.
- What is the exact strong version of the WGC realized in string theory? If it is the sublattice WGC, is there any upper bound on the sublattice index?
- Possible loophole: WGC under Higgsing, see e.g. @Saraswat:2016eaz. The WGC might not be satisfied in the IR upon Higgsing even if satisfied in the UV, unless the amount of Higgsing is also constrained by quantum gravity.
- Can we rigorously prove any fundamental inconsistency with having stable non-BPS black holes?
- WGC in $"AdS"_(d + 1) slash "CFT"_d$ for $d > 2$. The evidence for the WGC using modular invariance only applies for $d = 2$.
- WGC in de Sitter space, see e.g. @Montero:2019ekk.

= Swampland Distance Conjecture <sec:distconj>

We now turn to discuss the Distance Conjecture, which plays a central role in the Swampland program as it comes with many interesting relations to the other Swampland conjectures.

== Asymptotic Limits in Moduli Space <sec:asymptotic-limits>

// [figvision] imgs/modulispacev2.png
// Panel (a) A schematic diagram of quantum gravity moduli space drawn as an irregular six-lobed star-shaped
// region filled with a light blue-to-white gradient that darkens toward the curved outer boundary. Two orange
// dots mark points P in the interior left and Q at the upper-right boundary tip, with Q labeled in black text
// beside its dot. A thick orange curved arrow travels from P to Q with an arrowhead at Q, indicating a path
// through the moduli space toward an asymptotic infinite-distance limit. No axes, tick marks, units, or
// numerical values appear. Panel (b) A two-dimensional plot with a vertical axis labeled Λ_QG and a horizontal
// axis labeled Δφ, each terminating in an arrowhead but lacking tick marks, ranges, or numerical units. A thick
// blue curve begins high on the vertical axis near the origin and decays smoothly toward zero as Δφ increases to
// the right, approaching the horizontal axis asymptotically without touching it. The trend shows the quantum
// gravity cut-off falling exponentially with geodesic distance as one approaches an infinite distance point,
// consistent with a tower of light states.
In string theory every coupling, mass, etc., is controlled by the vacuum expectation value (vev) of some scalar fields. They are called moduli as they are massless before adding fluxes or other ingredients to the compactification manifold. From the 10d perspective, they control the size and shape of the extra dimensions. This motivates the common lore that there are no free parameters#footnote[This is actually related to the absence of $( - 1 )$-form global symmetries, where the role of the symmetry current is played by the parameter.] in string theory, but all of them are #emph[dynamical].

Different effective field theories can be explored by moving in this moduli space. For example, one may try to move towards a point in which a global symmetry is restored, by e.g. sending some gauge coupling to zero. This case is particularly interesting, since global symmetries are forbidden in Quantum Gravity, so something dramatic is expected to happen when approaching such a limit. Leaving its definition for later, let us recall that the moduli space is naturally equipped with a Riemannian metric. The obvious way in which the theory is protected
against restoring a global symmetry in this way is that, according to this metric, weak coupling limits are at infinite field distance in moduli space. But this is not the end of the story. One would expect the effective field theory description to continuously break down as the approximate global symmetry looks more and more exact as we move towards the infinite distance loci. This is precisely the behaviour predicted e.g. by the magnetic version of the WGC or the species bound for the WGC tower, since the EFT cut-off will fall down to zero as the gauge
coupling goes to zero.

// [figvision] imgs/modulispacev2.png
// Panel (a) A schematic diagram of quantum gravity moduli space drawn as an irregular six-lobed star-shaped
// region filled with a light blue-to-white gradient that darkens toward the curved outer boundary. Two orange
// dots mark points P in the interior left and Q at the upper-right boundary tip, with Q labeled in black text
// beside its dot. A thick orange curved arrow travels from P to Q with an arrowhead at Q, indicating a path
// through the moduli space toward an asymptotic infinite-distance limit. No axes, tick marks, units, or
// numerical values appear. Panel (b) A two-dimensional plot with a vertical axis labeled Λ_QG and a horizontal
// axis labeled Δφ, each terminating in an arrowhead but lacking tick marks, ranges, or numerical units. A thick
// blue curve begins high on the vertical axis near the origin and decays smoothly toward zero as Δφ increases to
// the right, approaching the horizontal axis asymptotically without touching it. The trend shows the quantum
// gravity cut-off falling exponentially with geodesic distance as one approaches an infinite distance point,
// consistent with a tower of light states.
It is worth noting that the cut-off decreasing is purely a quantum gravity mechanism. From the Quantum Field Theory perspective, even if the point with vanishing gauge coupling is unreachable since it is at infinite distance, there seems to be nothing wrong with being as close as possible. In fact, it is precisely in these weak coupling limits where we have good control of the EFT, so a tiny gauge coupling is very appealing from a bottom-up perspective. However, restoring a global symmetry is strictly forbidden in quantum gravity and, as a consequence,
the effective field theory description should break down in a continuous way by quantum gravitational effects when taking these infinite distance limits.

We could try to run a similar argument when taking other limits restoring other types of global symmetries. Or more generally, we could wonder what happens when approaching any infinite distance boundary in moduli space. Does the EFT always break down? And if so, what is the mechanism introduced by QG so that it happens? This is quantified by the Swampland Distance Conjecture (SDC), to which this section is devoted.

== Swampland Distance Conjecture <swampland-distance-conjecture>

Consider a $D$-dimensional effective field theory coupled to Einstein gravity and with some moduli space $cal(M)$ parametrized by massless scalar fields. The action includes the term $S supset M_p^(D - 2) integral d^D x sqrt(- h) (R\/2 - 1\/2 g_(i j) partial_mu phi.alt^i partial^mu phi.alt^j)$ where $g_(i j)$ is identified as the metric in moduli space.

The first statement of this conjecture is that the moduli space is non-compact. Starting from a point $P in cal(M)$, there always exist another point $Q in cal(M)$ at infinite geodesic distance $d ( P Q )$. No that a point is at infinite distance if every trajectory approaching the point has infinite length. One typical example in string theory compactifications is the decompactification limit. The second and more important statement describes what happens if we try to approach some point at infinite field distance: \

#block[
#strong[Swampland Distance Conjecture.] There is an infinite tower of states that becomes exponentially light at any infinite field distance limit as $M ( Q ) tilde M ( P ) thin e^(- lambda Delta phi.alt) quad "when " Delta phi.alt → oo$ in terms of the geodesic field distance $Delta phi.alt equiv d ( P Q )$ @Ooguri:2006in.

]

// [figvision] imgs/modulispacev2.png
// Panel (a) A schematic diagram of quantum gravity moduli space drawn as an irregular six-lobed star-shaped
// region filled with a light blue-to-white gradient that darkens toward the curved outer boundary. Two orange
// dots mark points P in the interior left and Q at the upper-right boundary tip, with Q labeled in black text
// beside its dot. A thick orange curved arrow travels from P to Q with an arrowhead at Q, indicating a path
// through the moduli space toward an asymptotic infinite-distance limit. No axes, tick marks, units, or
// numerical values appear. Panel (b) A two-dimensional plot with a vertical axis labeled Λ_QG and a horizontal
// axis labeled Δφ, each terminating in an arrowhead but lacking tick marks, ranges, or numerical units. A thick
// blue curve begins high on the vertical axis near the origin and decays smoothly toward zero as Δφ increases to
// the right, approaching the horizontal axis asymptotically without touching it. The trend shows the quantum
// gravity cut-off falling exponentially with geodesic distance as one approaches an infinite distance point,
// consistent with a tower of light states.
#figure(placement: top, [#block[
  #box(image("imgs/modulispacev2.png", width: 90.0%))
  ]],
  caption: [
    Left: Pictorial representation of quantum gravity moduli space with several asymptotic limits at infinite distance. Right: Quantum gravity cut-off falling exponentially with the geodesic distance as we approach an infinite distance point, due to the tower of states predicted by the SDC.
  ]
) <fig:moduli-space>

// [figvision] imgs/SDC_KKcircle_v3.png
// Panel a: A schematic shows a thin black circle surrounded by a thicker green wavy closed curve that wraps
// around it once. Four black arrows point radially inward toward the circle from the top, bottom, left, and
// right. Below the left side is the label r → 0, indicating the small-radius limit. The green loop represents a
// string winding around the compact circle, and in this limit the winding mode becomes exponentially light.
// Panel b: A line plot has horizontal axis circle radius r from r → 0 on the left to r → ∞ on the right, with no
// numeric tick marks. The vertical axis is mass with no labels or ticks. Two smooth exponential curves cross
// near the center: a green curve labeled m_ω rises monotonically from near zero at small r to large values at
// large r, while a blue curve labeled m_KK falls monotonically from large at small r to near zero at large r.
// The winding mode mass grows with radius and the Kaluza-Klein mass shrinks with radius. Panel c: A schematic
// shows a thin black circle with four black arrows pointing radially outward from the top, bottom, left, and
// right. A small blue dot sits on the upper-right circumference, with a curved blue arrow indicating
// counterclockwise motion around the circle. Below the right side is the label r → ∞, indicating the
// large-radius or decompactification limit. The moving dot represents a Kaluza-Klein momentum mode, which
// becomes exponentially light at large radius.
The exponential rate $lambda$, apart from being positive, is not specified by the conjecture. It is expected to be an $cal(O) (1)$ constant, as otherwise it could spoil the exponential behaviour, but its origin is not known. In fact, determining how small this parameter can be is the main open question about the SDC, and we will see that significant progress on this has been achieved in certain string theory setups. Concrete lower bounds have also been proposed in the literature @Gendler:2020dfp @Bedroya:2019snp @Andriot:2020lea @Lanza:2020qmt and will
be discussed later. Clearly, having an unspecified factor in the conjecture is not satisfactory; we would like to be able to compute it from first principles or effective field theory data. This was the case for the WGC, in which the order one factor is specified in terms of the extremality bound for black holes.

// [figvision] imgs/SDC_KKcircle_v3.png
// Panel a: A schematic shows a thin black circle surrounded by a thicker green wavy closed curve that wraps
// around it once. Four black arrows point radially inward toward the circle from the top, bottom, left, and
// right. Below the left side is the label r → 0, indicating the small-radius limit. The green loop represents a
// string winding around the compact circle, and in this limit the winding mode becomes exponentially light.
// Panel b: A line plot has horizontal axis circle radius r from r → 0 on the left to r → ∞ on the right, with no
// numeric tick marks. The vertical axis is mass with no labels or ticks. Two smooth exponential curves cross
// near the center: a green curve labeled m_ω rises monotonically from near zero at small r to large values at
// large r, while a blue curve labeled m_KK falls monotonically from large at small r to near zero at large r.
// The winding mode mass grows with radius and the Kaluza-Klein mass shrinks with radius. Panel c: A schematic
// shows a thin black circle with four black arrows pointing radially outward from the top, bottom, left, and
// right. A small blue dot sits on the upper-right circumference, with a curved blue arrow indicating
// counterclockwise motion around the circle. Below the right side is the label r → ∞, indicating the
// large-radius or decompactification limit. The moving dot represents a Kaluza-Klein momentum mode, which
// becomes exponentially light at large radius.
The infinite tower of states is weakly coupled and signals the breakdown of the effective field theory, as it is impossible to have an effective field theory description weakly coupled to Einstein gravity with infinitely many light degrees of freedom. Hence, there is a quantum gravity cut-off associated to the infinite tower of states, which decreases exponentially in terms of the proper field distance,

$ Lambda_("QG") = Lambda_0 thin e^(- lambda Delta phi.alt) $<eq:SDC-cut-off>

as represented in @fig:moduli-space. For simplicity, here we are taking this cut-off to coincide with the first state of the tower. But a more accurate way of defining it is via the species bound cut-off given in @speciesm, whose exponential rate will differ from $lambda$ by an order one factor depending on the space-time dimension.

An immediate consequence is that effective field theories are only valid for finite scalar field variations. From @eq:SDC-cut-off and taking into account that $Lambda_0 lt.eq M_p$ one gets

$ Delta phi.alt lt.eq 1 \/ lambda log M_p \/ Lambda $<eq:SDC-bound>

which is telling us that the maximum field variation actually depends on the cut-off of the effective field theory. This means that the higher the cut-off or the process changing the vev of the scalar, the smaller is the maximum field distance that can be described within the effective field theory. This statement has direct implications for inflation that will be discussed later. Notice that this correlation between the cut-off and the maximum field range is intrinsically quantum gravitational, as these two quantities are a priori unrelated from a QFT perspective.

== Examples and Connection to String Dualities <sec:SDCdual>

The prototypical example of how the SDC is realized is a KK circle compactification of string theory to $d$ space-time dimensions. Taking $r$ to be the modulus controlling the radius of the circle one finds:

$ S supset M_p^(d - 2) integral d^d x sqrt(- h) (R \/ 2 - 1 \/ 2 frac(d - 1, d - 2) frac(( partial r )^2, r^2)) $<SKK>

where we show only the Einstein-Hilbert term and the kinetic term for the modulus $r$. There are thus two limits at infinite distance, small radius $r → 0$ and large radius $r → oo$. The proper field distance is given by the canonically normalized field $Delta R = sqrt(frac(d - 1, d - 2)) thin log r thin .$ Taking the decompactification limit $r → oo$ we know that the KK tower becomes light. The mass of these modes is given by

$ m_(K K) = q \/ r^(frac(d - 1, d - 2)) = q thin e^(- sqrt(frac(d - 1, d - 2)) thin Delta R) $<eq:KK-mass>

so we indeed find an infinite tower of states becoming exponentially light with the distance, as required by the SDC. Moreover, in this case we have been able to compute the exponential rate in terms of the space-time dimension of the effective field theory as

$ lambda = sqrt(frac(d - 1, d - 2)) thin . $<lambdaKK>

As expected, it turns out to be an order one constant.

In the opposite limit at infinite distance $r → 0$ the KK tower cannot be the one satisfying the SDC. In this limit it is another infinite tower that is becoming light. These are the winding modes (wrapping strings) and they present the same behaviour as the KK modes in the decompactification limit. This leads to the striking observation that in order to satisfy the SDC in KK compactifications we need extended objects that can wrap some compact directions and become light in the limit in which they shrink to zero size. For an illustration of the SDC in this setup see @fig:SDC-KKcircle.

// [figvision] imgs/SDC_KKcircle_v3.png
// Panel a: A schematic shows a thin black circle surrounded by a thicker green wavy closed curve that wraps
// around it once. Four black arrows point radially inward toward the circle from the top, bottom, left, and
// right. Below the left side is the label r → 0, indicating the small-radius limit. The green loop represents a
// string winding around the compact circle, and in this limit the winding mode becomes exponentially light.
// Panel b: A line plot has horizontal axis circle radius r from r → 0 on the left to r → ∞ on the right, with no
// numeric tick marks. The vertical axis is mass with no labels or ticks. Two smooth exponential curves cross
// near the center: a green curve labeled m_ω rises monotonically from near zero at small r to large values at
// large r, while a blue curve labeled m_KK falls monotonically from large at small r to near zero at large r.
// The winding mode mass grows with radius and the Kaluza-Klein mass shrinks with radius. Panel c: A schematic
// shows a thin black circle with four black arrows pointing radially outward from the top, bottom, left, and
// right. A small blue dot sits on the upper-right circumference, with a curved blue arrow indicating
// counterclockwise motion around the circle. Below the right side is the label r → ∞, indicating the
// large-radius or decompactification limit. The moving dot represents a Kaluza-Klein momentum mode, which
// becomes exponentially light at large radius.
#figure(placement: top, [#block[
  #box(image("imgs/SDC_KKcircle_v3.png", width: 80.0%))
  ]],
  caption: [
    Illustration of the SDC being realized in circle compactifications of string theory. KK (winding) modes become exponentially light at large (small) radius.
  ]
) <fig:SDC-KKcircle>

Another interesting feature of this example is that the realization of the SDC is inexorably linked to the existence of a T-duality involving both limits and their tower of states. When the radius becomes small we can go to the dual description in which the radius is again large and the winding modes are exchanged by a KK tower becoming light. Notice that going to the dual description does not help when it comes to saving the effective field theory, but it can tell us how to resolve it in the full Quantum Gravity theory. In this case it is telling us
that we have to grow a new extra dimension to resolve the singular limit.

It is very common in string theory that a dual description arises in these asymptotic limits. Hence, the Distance conjecture can also be understood as a #emph[Duality conjecture], in the sense that it is predicting the existence of a duality at every infinite distance limit such that the infinite tower provides the new fundamental (weakly coupled) degrees of freedom of the dual description. In this fashion, trying to understand why the SDC is true from first principles in Quantum Gravity is closely related to giving a reason why dualities exist in the
first place. A bottom-up explanation of this feature or of the SDC is missing. Currently, the SDC just points out a universal feature observed in string theory compactifications, but there is no clear intuition why it should hold in general in quantum gravity. It is fair to say, though, that there is so much evidence in support of the conjecture in string theory, that the SDC is widely accepted in the community. It has also been noted that a possible explanation arises by connecting the Distance conjecture with the WGC and the absence of global
symmetries. This connection is natural when some global symmetry is restored in the limit at infinite distance, as was discussed in @sec:asymptotic-limits. In the next section we will elaborate more in this direction.

Before moving on, it is worth mentioning a refinement of the SDC regarding the nature of the tower of states, which also connects with known dualities. This is the Emergent String Conjecture @Lee:2019wij: \

#block[
#strong[Emergent String Conjecture.] Any infinite distance limit is either a decompactification limit or a limit in which there is a weakly coupled string becoming tensionless.

]
This means that the leading tower becoming light is either a KK tower (in some appropiate dual frame) or some string excitation modes, such that the resolution in Quantum Gravity of the EFT breaking down is given by growing an extra dimension or by considering a string perturbation theory. The first case is associated to a T-duality while the second one fits with an S-duality.

Let us show the typical example in which these two possibilities are realised in the same moduli space. This is the case of type IIA in ten dimensions, whose action in the Einstein frame contains $S supset M_p^8 integral d^10 x sqrt(- h) (R\/2 - frac(( partial s )^2, 4 s^2))$ where $s$ is related to the string coupling $g_s$ and the 10d dilaton $Phi$ via $s = 1\/g_s = e^(- Phi) thin .$ We again find two infinite distance limits that correspond to strong ($g_s → oo$) or weak ($g_s → 0$) string coupling. The proper field distance grows logarithmically with
the string coupling in both limits, $Delta phi.alt = 1\/sqrt(2) log s$.

In the strong coupling limit, a tower of D0-branes becomes exponentially light with the distance. Indeed, a D0-brane becomes massless polynomially with the string coupling as $m_(D 0) tilde M_s\/g_s tilde M_p\/g_s^(3 \/4) tilde M_p thin e^(- frac(3 sqrt(2), 4) Delta phi.alt)$ which means that they do so exponentially with the proper field distance. Importantly, these D0-branes are the KK modes of M-theory on $S^1$, and thus we see that this corresponds to a decompactification limit.

Contrary, in the weak coupling limit, the string excitations are the modes becoming exponentially light. The mass of these states falls polynomially to $0$ as $g_s → 0$, $M_s tilde M_p thin g_s^(1 \/4) tilde M_p thin e^(- sqrt(2)\/4 Delta phi.alt)$ which again decreases exponentially with the proper field distance. We see that in this case there is no extra dimension growing up, rather this is the perturbative string limit of Type IIA. In both cases, as dictated by the SDC, the ten dimensional quantum field theory description breaks down, and we need to
either grow extra dimensions or consider a string theoretical description of the theory.

The motivation for this refinement of the SDC is example based. So, as with the SDC itself, there is no known quantum gravity reason why the leading towers should always be KK modes or a weakly coupled string. For instance, one could a priori expect a limit in which the tower corresponds to a tensionless membrane. The absence of this type of limits is, though, in agreement with the lack of a perturbative description for a membrane theory, which has been extensively searched for in the string theory community.

== Relation to the WGC <sec:relation-WGC>

As already mentioned in @sec:asymptotic-limits, all limits in which a global symmetry is restored because some gauge coupling vanishes are at infinite field distance in moduli space. The opposite direction has also been proposed to be true @Gendler:2020dfp although not proven in general. Interestingly, in all string theory examples studied so far, there seems to be a global symmetry restored at infinite distance coming from a $p$-form gauge coupling going to zero (sometimes also an infinite order discrete global symmetry appears). The SDC, like the WGC,
can then be understood as a quantum gravity obstruction to restore a global symmetry.

If there is a vanishing $p$-form gauge coupling in a certain infinite distance limit, charged states satisfying some tower or sublattice version of the WGC would be the natural candidates for the SDC tower of states becoming light. And in that case, the exponential rate $lambda$ will be fixed by the black hole extremality bound @Gendler:2020dfp @Lee:2018spm. No that even if this charged tower is not the leading one becoming light, it can be used to put a lower bound on the SDC exponential rate, as any other fast-decaying tower will have a
bigger $lambda$. Thus, this is a very appealing situation in which the WGC and the SDC merges in one single statement in which no undetermined order one factors are left.

To give an example, this situation is realized in the previously discussed KK compactification on a circle of @sec:SDCdual. In this case we have a KK photon whose kinetic gauge function can be read from $S supset - M_p^(d - 2) integral d^d x sqrt(- h) thin 1\/2 thin e^(- 2 sqrt(frac(d - 1, d - 2)) phi.alt) thin F_(K K)^2$ which supplements the Einstein-Hilbert term and the scalar kinetic term given in @SKK. Here, $phi.alt = log r$ with $r$ the radius of the circle. This implies that the scalar contribution to the black hole extremality bound in [extremality bound with scalars] is given by

$ alpha = 2 sqrt(frac(d - 1, d - 2)) thin . $<alpha>

By plugging this into [extremality bound with scalars] one finds that the WGC requires the existence of some charge states satisfying

$ m^2 = q^2 \/ r^2 $<massKK>

where $q$ is the quantized charge and we have used that the gauge coupling for the KK photon is given by $g_0 = frac(2, r^2 M_p^(d - 2))$. KK modes are charged under the KK photon and precisely satisfy @massKK. They also become exponentially light with the proper field distance, as shown in @eq:KK-mass. Therefore, a KK tower satisfies simultaneously the WGC and the SDC with an exponential rate given by $lambda = alpha \/ 2$, obtained from comparing @lambdaKK and @alpha.

This matching is actually quite general and will happen whenever the extremality condition [extremality bound with scalars] and the RFC @eq:RFC-general coincide, in the sense that extremal states feel no force. In that case, the second term on the left hand side of [extremality bound with scalars] is equal to the second term in @eq:RFC-general, which is related to the exponential decay rate of the tower. Then, by equating both bounds for the case of particles, one gets $lambda = alpha\/2$ thus fixing the exponential decay rate in terms of the extremality
bound. This merging of the conjectures has been seen to occur at weak coupling limits of several string theory setups @Lee:2018spm @Gendler:2020dfp and it is expected to hold whenever there is a gauge coupling vanishing at infinite distance. If the tower of states of the SDC comes from the excitations of a weakly coupled string, the exponential rate can be fixed in a similar way by using the WGC for the two-form gauge field to which it couples.

Hence, the generality of the lower bound for the SDC exponential factor in terms of the extremality factor in the WGC depends on whether there is always a gauge coupling vanishing at any infinite distance limit. This has been proposed to be the case in @Gendler:2020dfp and it is supported by the string theory evidence and the Emergent String Conjecture. The latter suggests that we can always use either the extremality bound associated to a KK photon or to a two-form gauge field for the case of a weakly coupled string, since in both cases their gauge
coupling is going to zero in the asymptotic limit.

There is an alternative connection between the WGC and the SDC which does not require a gauge coupling vanishing in each infinite distance limit. More specifically, this requires a version of the WGC dubbed the Scalar WGC that does not even need the presence of a gauge theory at all to be formulated. It was proposed in @Palti:2017elp and poses that gravity should be weaker than any scalar force, even if both of them are attractive, so they are not actually competing with each other. For a particle with mass $m$, controlled by the vev of some moduli, this
translates into the following condition: \

#block[
#strong[Scalar WGC.] Given some EFT weakly coupled to Einstein gravity with some massless scalar fields $phi.alt_i$, there must exist a state with mass $m$ satisfying:

$ g^(i j) thin partial_i m thin partial_j m > frac(d - 3, d - 2) thin m^2 $<eq:Scalar-WGC>

where $g_(i j)$ is the field metric and $d$ the space-time dimension.

]

The above condition can be obtained from simply setting the gauge charge to zero in [extremality bound from repulsive force condition]. Unlike the usual WGC, it is not related to any black hole extremality bound, as there are no extremal black holes with only scalar charge by the no-hair theorem. Therefore, the motivation in terms of black hole decay is missing, although one could run a similar argument in terms of gravitational bound states instead of black hole remnants.

Notice that, in order to satisfy this condition at large field distance, the mass of the state has to decrease exponentially as required for the SDC. Hence, using the scalar WGC one can also argue for an exponential rate of order one. We would like to remark, though, that the evidence behind this scalar WGC is very scarce, so it is not on the same level of rigor as the usual WGC or the SDC. In fact, refinements involving second derivatives of the mass @Gonzalo:2019gjp @Freivogel:2019mtr @DallAgata:2020ino @Benakli:2020pkm @Gonzalo:2020kke have appeared,
which suggests that the simplest form in @eq:Scalar-WGC might not be the end of the story, and a proper formulation of the conjecture (if any) is still a subject for further research.

== String Theory Evidence <sec:SDC-ST-evidence>

The evidence for the SDC comprises a plethora of examples in string theory. Those discussed in @sec:SDCdual are so simple that the conjecture might look trivial from a string theoretical perspective. However, in general there are many different infinite distance limits that one can engineer in more involved compactifications, and how string theory manages to always have such light towers of states is non-trivial. In fact, testing the SDC against different classes of models has triggered research in several corners of string theory compactifications,
uncovering very interesting connections to cutting-edge mathematics, such as algebraic geometry and modular forms.

In the following we will be discussing the setups in which most of the progress testing the SDC has been made, providing an introduction to the underlying mathematical structures uncovered on the way. These are supersymmetric compactifications of the following types:

- 4d $cal(N) = 2$ from Type II.

- 5d $cal(N) = 1$ from M-theory and F-theory duals.

- 4d $cal(N) = 1$ from Type II.

In all these examples the towers have been shown to satisfy both the WGC and the SDC.

=== 4d $cal(N) = 2$ Type II Calabi-Yau Compactifications
<sec:typeII-CY>

The moduli space in this class of compactifications is known to be the product of the Kähler and the complex structure moduli spaces. As a consequence we can study them separately to leading order. Let us first focus on the vector multiplet moduli space, which is the complex structure in Type IIB or Kähler in Type IIA.

Infinite (geodesic) distance can only occur when approaching some singularity. Hence, testing the SDC reduces to studying the physics near singularities in the moduli space. In fact, it is known that there are always #emph[some] BPS states becoming massless at the singularities of the vector multiplet moduli space, so they are perfect candidates for the SDC tower. Note that one can have different kinds of singularities in moduli space, and not all of them are necessarily at infinite distance. For instance, the well-known conifold points are indeed
singular but at finite distance. Interestingly, in this case one does not find an infinite number of BPS states becoming light, but a finite amount of them. Then, for the singularities at infinite distance the SDC is predicting that the number of BPS states becoming massless has to actually be infinite, and this is not trivial at all.

Following @Grimm:2018ohb, @Grimm:2018cpv, let us work with the complex structure moduli space of Type IIB CY#sub[3] compactifications. These works constitute a non-trivial test of the SDC, as they show the existence of an infinite tower of BPS states becoming exponentially light with the distance at any infinite distance singularity of any Calabi-Yau manifold. Notice that, upon mirror symmetry, the analysis translates to the Kähler moduli space in Type IIA @Corvilain:2018lgw. First let us introduce some background about the metric and the set of BPS
states which will be relevant for realizing the SDC.

The vector multiplet moduli space of a Calabi-Yau three-fold is known to be a special Kähler manifold. This means that the metric is determined by the Kähler potential, which can be written in terms of a holomorphic $( D 0 )$-form $Omega$ as follows, $g_(I macron(J)) = partial_(z^I) partial_(macron(z)^J) K thin quad K = - log (i^D thin integral_(C Y_D) Omega and macron(Omega))$ with $D = 3$ for a $C Y_3$.

Here, we have chosen a set of complex coordinates $z^I$, known as the complex structure deformation moduli, that locally parametrise the moduli space. It is always possible to find an appropiate symplectic basis of three-cycles, such that the Kähler potential can be written as

$ K = - log ( - i^D Pi^T eta bar(Pi) ) $ <KIIB>

where $eta$ is the symplectic intersection product and $Pi$ is a vector containing the periods of $Omega$ over the basis of three-cycles,

 $Pi^(cal(I)) = integral_(Gamma_(cal(I))) Omega thin .$ BPS particles can be obtained by wrapping D3-branes on special Lagrangian three-cycles $Gamma_(cal(I))$.#footnote[In the IIA mirror, they correspond to bound states of D0 and D2-branes wrapping two-cycles.] Their mass is given by its central charge, which is again determined by the periods as

$ M = | Z | = e^(K \/ 2) thin | q^T thin eta thin Pi | . $<Z>

Here, $q$ is the vector of quantized charges of the BPS particle with respect to the gauge fields coming from the dimensional reduction of the Type IIB RR 4-form field,

$ A_1^(cal(I)) = integral_(Gamma_(cal(I))) C_4 thin . $<Afield>

One could now start testing the SDC case by case, computing the periods $Pi$ in different Calabi-Yau manifolds, but given the incredible amount of them this does not seem like the best way of gathering evidence for this conjecture. Fortunately, we can do better and give a systematic approach which is valid for any Calabi-Yau, and may be even more general than that. In order to do so, we will be using some powerful tools of algebraic geometry and BPS counting. Namely, we will use theorems of limiting Hodge theory to describe the behaviour of the periods
near any infinite distance loci, and the study of walls of marginal stability to count the number of BPS states becoming light.

The key ingredient of this analysis are the monodromy transformations. As mentioned before, we are interested in approaching singularities in moduli space that are at infinite distance. It turns out that the periods undergo a monodromy transformation when circling around the singularity. That is, choosing some special complex coordinates, $z^I$, for which the singularity is located at $z^i → i oo$, the periods transform as $Pi ( . . z^i + 1 . . ) = T_i thin Pi ( . . z^i + 1 . . )$ while the Kähler potential remains invariant. From the point of view of
the effective field theory, $z^i → z^i + 1$ is a discrete shift of an axion, so the monodromies correspond to axionic shift symmetries in the EFT.

The monodromy around a singularity can be of finite or infinite order. That is, after going around the singularity several times we either get back to the same point, so $T^n = bb(I)$ for some $n > 0$ or this is not possible, so $T^n eq.not bb(I)$ for any $n > 0$. We will see that infinite distance singularities are necessarily related to infinite order monodromies.

If the monodromy is of infinite order, one can define a non-trivial nilpotent operator by taking $N_i = log T_i$. In this situation, the Nilpotent Orbit Theorem of Schmid @schmid gives an asymptotic expansion of the periods near the singular locus such that they are well approximated by the following nilpotent orbit

$ Pi ( z ) = e^(z^i N_i) Pi_0 + cal(O) ( e^(2 pi i z^i) ) $<nil>

up to exponentially suppressed corrections, where $Pi_0$ only depends on the complex coordinates which are not sent to infinity.

For simplicity, let us now stick to the case of a single modulus $z → oo$. By plugging @nil into @KIIB and using that $N^T eta = - eta N$, we can see that $K = - log ( p_d ( "Im" z ) + cal(O) ( e^(2 pi i z) ) )$ near the infinite distance locus, where $p_d ( "Im" z )$ is a polynomial of degree $d$. This further implies the following leading term for the metric,

$ g_(z macron(z)) = frac(d, 4 ( "Im" z )^2) thin . $<metric>

Here, $d$ is the effective nilpotency order defined as $N^d Pi_0 eq.not 0 thin quad N^(d + 1) Pi_0 = 0$ which is bounded by the complex dimension of the Calabi-Yau, so in the case at hand it can take values $d = 0, 1, 2, 3$. Clearly, only for $d eq.not 0$ the singularity will be at infinite distance, so an infinite order monodromy is a necessary condition for infinite distance. This nilpotency order can be used to classify different asymptotic limits and, interestingly, it also fixes the exponential rate of the tower for the SDC. Indeed, one can show
that there is always an infinite tower of BPS states behaving as required by the SDC and whose exponential rate is bounded by

$ 1 \/ sqrt(2 d) < lambda < sqrt(2 d) thin . $<eq:bound-exponential-ra>

Since $d lt.eq 3$ for a Calabi-Yau three-fold, this yields the following lower bound for the exponential ra: $lambda gt.eq 1\/sqrt(6) thin .$ The exponential behaviour of the mass is a consequence of the asymptotic behaviour of the metric. By plugging @nil into @Z the BPS mass behaves as a polynomial in the coordinates $z^i$ which, by using @metric to canonically normalise the scalars, depends exponentially on the proper field distance $Delta phi.alt = sqrt(d\/2) log "Im" z thin .$

The role of the monodromy transformations does not end here. The existence of an infinite tower of states (and not only a finite number of them) can be intuitively explained by it. The monodromy transformation acts on the charge of the BPS states, generating an orbit of charges $q_n = T^n q_0$. Monodromies are redundancies of the theory, which implies that even if the charge of a single state varies, the full tower must reorder itself and remain invariant under the monodromy so that the physics does not change. In fact, these monodromies become actual
global symmetries at infinite distance. Hence, the existence of a single state implies that the entire orbit must be populated by physical BPS states, which yields an infinite tower if the monodromy is of infinite order. In this way, the fact that there is an infinite tower of BPS states tracks back to the monodromy transformations around infinite distance singularities being of infinite order. This intuitive reasoning must be accompanied by the analysis of walls of marginal stability and a careful check of the existence of the seed charges $q_0$, but we
refer the student interested in the details to the original paper @Grimm:2018ohb. The generalization to multiple moduli limits can be found in @Grimm:2018cpv.

In this scenario we can relate the SDC with the WGC as already discussed in @Grimm:2018cpv. We find that in these limits there is always a gauge coupling going to zero for some gauge field $A^(cal(I))$ of @Afield and that the bound in @eq:bound-exponential-ra can be related to the black hole extremality bound. Hence, the SDC tower also saturates the WGC. These conjectures can then be understood as quantum gravity obstructions to restore some global symmetries at infinite distance, coming both from the vanishing gauge couplings and from the monodromies,
which can be promoted to continuous global symmetries of the theory at infinite distance.

After having studied the vector multiplet moduli space, we are left with the hypermultiplet moduli space. In what follows, let us give a very brief review of the results that have been obtained, referring to @Marchesano:2019ifh @Baume:2019sry for more details. In this case, one does not find a tower of BPS states but KK towers, charged strings from wrapping branes and instantons becoming light. Importantly, the fact that some instantons become light (in the sense that their action goes to zero) means that there could be relevant quantum corrections to
the field metric, which could even obstruct certain infinite distance limits from being taken. What typically happens then is that the trajectories approaching such limits get deviated towards another one in which there is a weakly-coupled string becoming light at the same rate as a KK tower, $T_("string")\/M_p^2 tilde M_(K K)^2\/M_p^2 → 0 thin .$ Since the KK modes have a less dense spectrum than the string excitation modes, i.e. $m_("KK")^2 tilde k^2 M_("KK")^2$ vs $m_("str")^2 tilde k T_("str")$ for $k in bb(N)$, the leading tower fulfilling the SDC
is given by string excitation modes in these limits.

=== 5d $cal(N) = 1$ M-theory and 6d F-theory Duals
<sec:SDC-5d-N1>

We consider the Kähler moduli space of M-theory compactified on a Calabi-Yau three-fold, and their 6d F-theory duals. In this setup, the SDC is realized by a tower of particles coming from wrapping M2-branes on two-cycles, which corresponds to strings becoming tensionless from the F-theory perspective.

There have been two approaches to analyse and classify the possible infinite distance limits in this setup. One approach consists in borrowing the classification of singular limits on Calabi-Yau three-folds used to study 4d $cal(N) = 2$ theories in @sec:typeII-CY and applying it to compactifications of M-theory to 5d on these spaces. Since the geometry is the same, the classification based on the properties of the monodromies still
applies,#footnote[In the Kähler moduli space, different properties of the monodromies, like the effective nilpotency order, translates into different patterns of vanishing and non-vanihising intersection numbers @Corvilain:2018lgw.] and only the microscopic interpretation changes. Now the monodromies will not be related to shift symmetries of the axions but to large gauge transformations of the one-form gauge fields obtained from reducing $C_3$ on the two-cycles. They will act on the M2-brane charges, populating an infinite tower of particles.

The other approach involves an equivalent classification of these singularities in terms of the fibration structure that the Calabi-Yau three-fold develops in the limit. This was worked out in @Lee:2018urn, @Lee:2019tst @Lee:2019xtm @Lee:2019wij, where it was shown that the possible fibrations are $T^2$, $K 3$ and $T^4$. The limits studied in this series of works involve shrinking some of these fibers. Interestingly, this classification translates into certain properties of the intersection numbers which can be mapped one-to-one to the properties of the
monodromy transformations and the previous classification of singularities. In the following, we will focus on this second approach and explain the appearance of the infinite tower from the F-theory perspective. To illustrate the main features we will restrict to the case of a K3 fibration.

Consider F-theory compactified on an elliptically fibered $C Y_3$. The 6d Planck mass is given by $M_p^4 = 4 pi "Vol" ( B_2 )$ where $"Vol" ( B_2 )$ is the volume of the base of the fibration. The theory contains a gauge theory sector coming from 7-branes wrapping some divisor of the base, $C$. The associated gauge coupling is given by $1\/g_(Y M)^2 = frac(1, 2 pi) "Vol" ( C ) .$ The limit $"Vol" ( C ) → oo$ is a weak coupling limit at infinite distance in moduli space. There are now two possibilities. It could be that, when taking the volume of the
divisor to be large, the overall volume of the base also goes to infinity, leading to a decompactification limit and the corresponding tower of KK modes. The second possibility is to engineer an equi-dimensional limit, in which $"Vol" ( B_2 )$ remains finite even if $"Vol" ( C ) → oo$. To make this geometrically feasible, it can be proven that there is always another curve $C_0$ that intersects $C$ and whose volume is going to zero. D3-branes wrapping this shrinking curve will therefore give rise to strings that become tensionless in the weak coupling
limit, $T tilde "Vol" ( C_0 ) → 0 thin .$

For the SDC to hold it is still necessary to show that the string spectrum contains infinitely many excitation modes in this limit. In this present case it is easy to show this by using dualities and thus identifying this string as the critical heterotic string on a K3 surface. More generally, it has been shown in @Lee:2020gvu that the modular properties of quasi-Jacobi forms of the elliptic genus of the string can be used to determine the spectrum and yield infinitely many states. For the present case, this results in an infinite tower of excitations whose mass is given by @Lee:2018urn.

$ m_n^2 = 8 pi T ( n - 1 ) $<eq:string-excitations>

with $j = 1\/2 C dot.c C_0$ and $n$ the excitation level of the string.

In fact, one obtains a sublattice of charges with index $2 j$ such that for each charge

$
  q_k = 2 j k , quad k in bb(Z) ,
$


there exists a state at excitation level $n ( k ) = j k^2$. These states satisfy $g_(Y M)^2 q_k^2 = m_k^2 + 4 j g_(Y M)^2 > m_k^2$ in agreement with the WGC. Therefore, one gets a sublattice of non-BPS states satisfying the SDC and the strict inequality of the WGC at the same time. This provides evidence for both conjectures in the case in which the states are not necessarily supersymmetric, and it is also consistent with the sharpened WGC in @sec:sharpening-wgc. The analysis can also be extended to 4d $cal(N) = 1$ theories obtained from F-theory on Calabi-Yau four-folds @Lee:2019tst.

These works are again an example in which the swampland conjectures have served to uncover the underlying geometric structures of string compactifications and new relations to mathematics. In particular, this has triggered research on modular forms, yielding interesting non-trivial connections between algebraic geometry of Calabi Yau manifolds and modular properties of quasi-Jacobi forms that allow the WGC and the SDC to hold.

=== 4d $cal(N) = 1$ Effective Field Theories
<d-mathcaln1-effective-field-theories>

In this case there are no BPS particles in the spectrum, and that makes it more difficult to keep track of the states that could satisfy the SDC at the boundaries of moduli space. However, there are BPS charged strings and membranes that can be shown to become tensionless in these limits @Font:2019cxq. Even though they are not necessarily the leading
towers,#footnote[In the string theory setups analysed, the leading tower either correspond to KK modes (in some appropiate dual frame) or excitation modes of these BPS strings, in agreement with the Emergent String Conjecture.] they can still give us valuable information about the physics at these boundaries @Herraez:2020tih @Lanza:2020qmt.

The strings are charged under two-form gauge fields that are dual to axions in 4d. The gauge kinetic function for the two-forms is equal to the inverse of the axionic field metric, which in $cal(N) = 1$ can be given in terms of the Kähler potential, $g_(i j) = frac(partial^2 K, partial s^i partial s^j) thin .$ Here, $s^i$ are the saxions which, together with the axions $phi.alt^i$, make up the complex scalars of the chiral multiplets. Thus, information about the gauge kinetic terms of the two-forms under which the strings are charged gets translated into
information about the metric in moduli space.

// [figvision] imgs/inflation_bounds_v3.png
// Left panel: a two-dimensional plot with vertical axis Δφ ranging from 0 to 20 and horizontal axis r
// (tensor-to-scalar ratio) from 0.00 to 0.30. Two solid dark-blue curves bound an allowed region: the Lyth bound
// rises from Δφ ≈ 0 at r = 0 to about 12 at r = 0.30, while the SDC constraint drops from about 13 near r = 0
// and plateaus near Δφ ≈ 9.7 at large r. The area between them to the left of a dashed vertical line at r ≈ 0.06
// is shaded light blue and labelled Planck 18. A red point at r ≈ 0.09, Δφ ≈ 15 marks chaotic inflation. The
// message is that the scalar excursion allowed by combining the Lyth bound and SDC constraint is restricted by
// the Planck 18 limit on r. Right panel: a two-dimensional plot with identical axes, Δφ from 0 to 20 versus r
// from 0.00 to 0.30. Three solid dark-blue curves are drawn, each falling steeply near r = 0 and flattening at
// large r to asymptotes near Δφ ≈ 14, 10, and 5. There is no shading, markers, or internal text beyond the axis
// labels. These curves show the SDC bound starting from different upper values, demonstrating that the
// constraint is highly sensitive to the precise starting value of Δφ.
In the same way, membranes are charged under three-forms and their gauge kinetic function $T_(a b)$ is related to the scalar potential as follows,

// [figvision] imgs/inflation_bounds_v3.png
// Left panel: a two-dimensional plot with vertical axis Δφ ranging from 0 to 20 and horizontal axis r
// (tensor-to-scalar ratio) from 0.00 to 0.30. Two solid dark-blue curves bound an allowed region: the Lyth bound
// rises from Δφ ≈ 0 at r = 0 to about 12 at r = 0.30, while the SDC constraint drops from about 13 near r = 0
// and plateaus near Δφ ≈ 9.7 at large r. The area between them to the left of a dashed vertical line at r ≈ 0.06
// is shaded light blue and labelled Planck 18. A red point at r ≈ 0.09, Δφ ≈ 15 marks chaotic inflation. The
// message is that the scalar excursion allowed by combining the Lyth bound and SDC constraint is restricted by
// the Planck 18 limit on r. Right panel: a two-dimensional plot with identical axes, Δφ from 0 to 20 versus r
// from 0.00 to 0.30. Three solid dark-blue curves are drawn, each falling steeply near r = 0 and flattening at
// large r to asymptotes near Δφ ≈ 14, 10, and 5. There is no shading, markers, or internal text beyond the axis
// labels. These curves show the SDC bound starting from different upper values, demonstrating that the
// constraint is highly sensitive to the precise starting value of Δφ.
$ V = 1 \/ 2 T^(a b) ( s phi.alt ) f_a f_b = 1 \/ 2 Z^(a b) ( s ) rho_a ( f phi.alt ) rho_b ( f phi.alt ) $<eq:CY-flux-potential>

where $f_a$ are the discrete internal fluxes dual to the three-form gauge fields. Interestingly, the flux potential of string compactifications can always be factorized between a saxionic an axionic part, where the $rho_a$ functions are shift invariant axion polynomials including the fluxes, see e.g.@Bielleman:2015ina @Herraez:2018vae. Therefore, studying the behaviour of the three-form gauge couplings and charges of BPS membranes in the asymptotic limits provides information about the scalar potential.

In conclusion, the asymptotic behaviour of the field metric and the scalar potential can be translated into properties of BPS strings and membranes charged under two-form and three-form gauge fields, respectively, in 4d $cal(N) = 1$ EFTs. This yields interesting relations between different Swampland conjectures @Lanza:2020qmt. For instance, the exponential behaviour of the SDC tower becomes a consequence of having a BPS string satisfying the WGC. This allows us to provide a lower bound for the SDC exponential rate in 4d $cal(N) = 1$ EFTs in terms of the
extremality factor for the strings. Similarly, a potential described by a WGC-saturating membrane satisfies the de Sitter conjecture that will be explained in @dS.

== SDC with Potential and Implications for Inflation <sdc-with-potential-and-implications-for-inflation>

Up to now, the SDC has been a statement about the moduli space of the theory. This means that it regards a set of scalars with an exactly flat potential (typically protected by extended supersymmetry) that parametrizes different vacua of the theory. However, it is phenomenologically relevant, e.g. for inflation, to understand what happens when a potential is added so that this moduli space is lifted. Based on physical grounds, one would expect that the SDC should also apply to the valleys of the potential, i.e. to directions along which the potential may
not be exactly flat but the relevant energies are smaller than a given cut-off.

The refined SDC @Klaewer:2016kiy proposes that:

The exponential behaviour with $lambda tilde cal(O) ( 1 )$ should be manifest when $Delta phi.alt gt.tilde M_p$.

The conjecture should also hold for scalars with nearly flat potential.

This can have important implications for inflationary models.#footnote[The SDC also places important constraints on relaxation models of the EW scale, since they typically require transplanckian field ranges.] Consider the bound for the field distance in terms of the cut-off in @eq:SDC-bound. In order to accommodate inflation in the effective field theory we need the cut-off to be above the Hubble scale, $Lambda > H$. These two conditions together yield

$ Delta phi.alt lt.eq 1 \/ lambda log (M_p \/ H) thin . $<eq:SDC-inflation>

Thus, the SDC gives an upper bound on the field range of inflation in terms of the Hubble scale. In particular, when $H$ is close to the Planck scale one finds that the field range is bounded by an order one number in Planck units.

In slow roll inflation, the field range provides an upper bound on the tensor-to-scalar ratio $r$ via the Lyth bound,

$
  Delta phi.alt gt.eq (r \/ 0.002)^(1 \/ 2) .
$

The tensor-to-scalar ratio can be related to the Hubble scale as

$
  M_p \/ H = sqrt(frac(2, pi^2 A_s r)) ,
$<Hr>

// [figvision] imgs/non_geodesic_v2.png
// The figure is a single schematic panel depicting field-space trajectories. A black dot near the center-left
// marks the locus at infinite distance; radial distance corresponds to the saxion scalar and angular position to
// the axion scalar. A green straight line runs radially from the black dot to a grey dot at the right edge, with
// a green arrow pointing inward toward the black dot, representing the purely saxionic geodesic trajectory. A
// blue spiral begins close to the black dot and winds counterclockwise outward through roughly one and a half
// turns, with a blue arrowhead indicating its direction, representing a highly turning axion-monodromy-like
// trajectory. No numerical axes, units, or tick labels are displayed.
// the axion scalar. A green straight line runs radially from the black dot to a grey dot at the right edge, with
// a green arrow pointing inward toward the black dot, representing the purely saxionic geodesic trajectory. A
// blue spiral begins close to the black dot and winds counterclockwise outward through roughly one and a half
// turns, with a blue arrowhead indicating its direction, representing a highly turning axion-monodromy-like
// trajectory. No numerical axes, units, or tick labels are displayed.
where $A_s$ is the amplitude of scalar perturbations whose value has been measured experimentally to $log ( 10^10 A_s ) = 3.047 ± 0.015$ @Aghanim:2018eyx. Using @Hr we can write the SDC bound in @eq:SDC-inflation in terms of $r$ as follows,

$
  Delta phi.alt lt.eq - frac(1, 2 lambda) lr(( log (frac(pi^2 A_s, 2)) + log r )),
$

so it provides a lower bound on the tensor-to-scalar ratio. When written in this way, we note that the Lyth and the SDC bounds are complementary and can constrain different models of inflation @Scalisi:2018eaz. To give an example, chaotic inflation @linde_chaotic_1983 would be ruled out. This is shown in @fig:SDC-Lyth-bounds.

// [figvision] imgs/inflation_bounds_v3.png
// Left panel: a two-dimensional plot with vertical axis Δφ ranging from 0 to 20 and horizontal axis r
// (tensor-to-scalar ratio) from 0.00 to 0.30. Two solid dark-blue curves bound an allowed region: the Lyth bound
// rises from Δφ ≈ 0 at r = 0 to about 12 at r = 0.30, while the SDC constraint drops from about 13 near r = 0
// and plateaus near Δφ ≈ 9.7 at large r. The area between them to the left of a dashed vertical line at r ≈ 0.06
// is shaded light blue and labelled Planck 18. A red point at r ≈ 0.09, Δφ ≈ 15 marks chaotic inflation. The
// message is that the scalar excursion allowed by combining the Lyth bound and SDC constraint is restricted by
// the Planck 18 limit on r. Right panel: a two-dimensional plot with identical axes, Δφ from 0 to 20 versus r
// from 0.00 to 0.30. Three solid dark-blue curves are drawn, each falling steeply near r = 0 and flattening at
// large r to asymptotes near Δφ ≈ 14, 10, and 5. There is no shading, markers, or internal text beyond the axis
// labels. These curves show the SDC bound starting from different upper values, demonstrating that the
// constraint is highly sensitive to the precise starting value of Δφ.
#figure(placement: top, [#block[
  #box(image("imgs/inflation_bounds_v3.png", width: 100%))
  ]],
  caption: [
    Left: Allowed (blue) region of scalar field excursion during inflation against tensor-to-scalar ratio obtained by combining Lyth bound and SDC constraint for $lambda = 1$, together with the experimental bound put by Planck 18 @Akrami:2018odb. The red point corresponds to chaotic inflation @linde_chaotic_1983. Right: SDC bound for $lambda = 0.7 1, 2$ starting from the upper one. We note that the constraint is very sensitive to the precise value of $lambda$.
  ]
) <fig:SDC-Lyth-bounds>

In conclusion, we see that the SDC can constrain some models of large field inflation (including axion monodromy) but it does not rule it out, as a moderate transplanckian field range might suffice for some models. Notice that the SDC constraint on large field inflation highly depends on the exact value of $lambda$. For this reason, it is really important to learn about this exponential decay rate and how it can be computed from first principles or effective field theory data. It should also be noted that replacing $H$ as the cut-off in @eq:SDC-inflation
gives a very conservative bound, in the sense that the EFT will likely break down (or at least get sensitive to the infinite tower) before the mass of the first state becomes of order Hubble, so the constraints might be stronger than represented here.

The implications of the SDC do not end here.

Remember that the SDC applies to geodesics in moduli space but, with the inclusion of a potential, the trajectory followed during inflation is not necessarily a geodesic from the perspective of the UV moduli space. However, it still makes sense to apply the SDC if it corresponds to a geodesic from the perspective of the IR pseudo-moduli space generated by the valleys of the potential. In such a case, for the SDC to hold, it should be impossible to generate a potential such that the trajectory is sufficiently non-geodesic so that the exponential behaviour
of the tower is violated @Calderon-Infante:2020dhm. This is to say, by requiring consistency of the SDC at any energy scale, we can put constraints on the type of potentials that one can engineer in quantum gravity!

The main evidence that we have for this statement, and that motivated the Refined SDC, comes from Calabi-Yau flux compactifications in string theory. Since the theory is 4d $cal(N) = 1$, the scalars come in chiral multiplets including an axion and its partner, the saxion. Before adding the scalar potential, purely saxionic trajectories are geodesics of the moduli space. When adding the flux potential, both saxions and axions get stabilized. One could think that a way of avoiding any tower of states in inflation could be by moving only along an axionic
trajectory, while keeping the saxion fixed. This way, one would engineer an axion monodromy model with a highly turning trajectory and very large field range, see @fig:non-geodesic. However, the structure of the flux potential coming from string theory is such that the minimization of the potential in the saxionic directions implies $partial_(s^i) V = 0 arrow.r.double s^i = tilde(lambda) phi.alt^i + dots.c$ for large $phi.alt^i$. That is, when trying to move in an axionic direction, the potential induces a linear backreaction on the saxion. So one cannot
move along large values of the axion without displacing the saxion in the same way. This implies that if there was a tower decaying exponentially with the saxionic distance, it will also decay exponentially upon taking into account the backreaction in the axion monodromy model.

// [figvision] imgs/non_geodesic_v2.png
// The figure is a single schematic panel depicting field-space trajectories. A black dot near the center-left
// marks the locus at infinite distance; radial distance corresponds to the saxion scalar and angular position to
// the axion scalar. A green straight line runs radially from the black dot to a grey dot at the right edge, with
// a green arrow pointing inward toward the black dot, representing the purely saxionic geodesic trajectory. A
// blue spiral begins close to the black dot and winds counterclockwise outward through roughly one and a half
// turns, with a blue arrowhead indicating its direction, representing a highly turning axion-monodromy-like
// trajectory. No numerical axes, units, or tick labels are displayed.
#figure(placement: top, image("imgs/non_geodesic_v2.png", width: 100%),
  caption: [
    Green: purely saxionic (geodesic) trajectory. Blue: a highly turning trajectory, like in axion monodromy. The black dot represents a locus at infinite distance, while the radial and angular coordinates correspond to the saxion and axion scalars respectively.
  ]
) <fig:non-geodesic>

This backreaction issue was first introduced in @Baume:2016psm and further checked in @Valenzuela:2016yny @Blumenhagen:2017cxt @Grimm:2019ixq. In the context of F-theory compactifications on Calabi-Yau four-folds with fluxes, this backreaction was proven to hold more generally @Grimm:2019ixq due to an asymptotic homogeneity of the potential $V ( alpha s^i alpha phi.alt^i ) tilde.eq alpha^(d_i) V ( s^i phi.alt^i )$ realised near the infinite distance loci.

==  Distance Conjecture
<ads-distance-conjecture>

Finally, we are going to very briefly mention a generalization of the Distance conjecture to other field space configurations beyond the moduli space. In particular, one can define a notion of distance between different metric configurations#footnote[Taking a background metric and considering perturbations around it, we will have a metric configuration space on which we can define distances.] of AdS spacetime. As discussed in @Lust:2019zwm, the flat spacetime limit $Lambda -> 0$ is then at infinite distance in this metric configuration space. Assuming
that the Distance conjecture also applies in this space, and taking into account that the distance grows logarithmically as $Lambda -> 0$, one gets the following conjecture: \

#block[]
#block[]
// [figvision] imgs/emergence.png
// This schematic depicts a cyclical relationship between two concepts. A light cyan ellipse with a dark blue
// border on the left contains the text Small gauge coupling over Infinite field distance. A matching light cyan
// ellipse on the right contains Infinite tower of weakly coupled light states. Two thick dark blue curved arrows
// form a closed clockwise loop between them: an upper arrow runs from the left ellipse to the right and is
// labeled WGC,SDC above it; a lower arrow runs from the right ellipse back to the left and is labeled Emergence
// below it. The diagram illustrates that the Weak Gravity Conjecture and Swampland Distance Conjecture link
// small gauge coupling and infinite field distance to an infinite tower of weakly coupled light states through
// emergence.
#block[
#strong[AdS Distance Conjecture.] Any AdS vacuum has an infinite tower of states that becomes light in the flat space limit $Lambda -> 0$, satisfying
$ m tilde abs(Lambda)^alpha . $ <mL>

]
A strong version of the conjecture implies $alpha = 1\/2$ if the vacuum is supersymmetric and $alpha gt.eq 1\/2$ for non-susy AdS and $alpha lt.eq 1\/2$ for dS space. A consequence of the strong version of the conjecture is that a supersymmetric $d$-dimensional AdS vacuum cannot exhibit scale separation between the AdS scale and the cut-off of the $d$-dimensional theory (typically given by the KK scale), as the associated scale of the tower is of order the AdS scale $Lambda^(1\/2)$. Most of the AdS vacua constructed in string theory satisfy this
conjecture, as they do not have scale separation between the internal dimensions and the AdS length. However, there is one exception associated to Type IIA compactified on a particular limit of a flux orientifold CY#sub[3] @DeWolfe:2005uu, which has captured a lot of recent attention since the vacuum is in principle at parametric control, although its validity is still under debate (see e.g. @McOrist:2012yc @Junghans:2020acz @Marchesano:2020qvg). In any case, this latter example would only be a counterexample to the strong version of the conjecture but
not to @mL.

== Open Questions <open-questions>

There are a number of interesting open questions about the SDC:

All the evidence for the conjecture comes from string theory compactifications. Hence, a botom-up explanation for the conjecture is missing.

// [figvision] imgs/emergence.png
// This schematic depicts a cyclical relationship between two concepts. A light cyan ellipse with a dark blue
// border on the left contains the text Small gauge coupling over Infinite field distance. A matching light cyan
// ellipse on the right contains Infinite tower of weakly coupled light states. Two thick dark blue curved arrows
// form a closed clockwise loop between them: an upper arrow runs from the left ellipse to the right and is
// labeled WGC,SDC above it; a lower arrow runs from the right ellipse back to the left and is labeled Emergence
// below it. The diagram illustrates that the Weak Gravity Conjecture and Swampland Distance Conjecture link
// small gauge coupling and infinite field distance to an infinite tower of weakly coupled light states through
// emergence.
The existence of the towers is linked to the manifestation of dualities at the asymptotic limits. Why are dualities ubiquitous in string theory? Can we map the geometric classification of infinite distance limits to different types of dualities?

SDC in AdS/CFT, see e.g. @Baume:2020dqd and @Perlmutter:2020buo.

Can the SDC always be understood as a quatum gravity obstruction to restore a global symmetry at infinite distance?

More concretely, is there always some gauge coupling going to zero at infinite distance in moduli space? If so, there is a WGC tower satisfying the SDC, which would bound the exponential rate, see @Gendler:2020dfp, and would serve as a quantum gravity obstruction to restore a global symmetry.

What is the specific value of the exponential rate? Can we compute it or bound it from first principles or effective field theory data?

Better understand the constraints on scalar potentials coming from the Refined SDC.

What is the nature of the leading tower? Could it ever originate from $p$-branes with $p gt.eq 2$? This would disprove the Emergent String Conjecture.

If the scalars have a non-trivial profile in the non-compact space-time dimensions, does the EFT also break down at large distances and how? This is known as the Local SDC, see e.g. @Klaewer:2016kiy @Draper:2019utz.

What are the cosmological signatures of the tower during inflation or la-time cosmology?

= Emergence Proposal <emergence-proposal>

The so-called Emergence proposal @Harlow:2015lma @Grimm:2018cpv @Corvilain:2018lgw @Heidenreich:2017sim @Heidenreich:2018kpg @Palti:2019pca provides a general rationale for why the Swampland conjectures, especially the WGC and the SDC, should hold true in any theory of quantum gravity. Recall that these two conjectures relate the kinetic terms (i.e., gauge couplings, field metrics, etc.) to the mass of some new states. But it is well known that relations between the mass of heavy states that are integrated out and couplings of the low energy effective
field theory Lagrangian are already guaranteed by the renormalization group equations. So could it be that the relations provided by the Weak Gravity and Distance conjectures are simply due to the renormalization group equations upon integrating out the WGC- and SDC-satifying states? The answer would be affirmative according to the Emergence proposal.

#block[
#strong[Emergence Proposal.] All the kinetic terms in an EFT #emph[emerge] from integrating out the massive states up to some quantum gravity cut-off @Grimm:2018ohb @Palti:2019pca.

]

This implies that all fields are non-dynamical at the quantum gravity scale where gravity becomes strongly coupled, hinting at some sort of UV topological description. That is, there is no kinetic term to start with. It is only upon going to the IR and integrating out the tower of states predicted by the Weak Gravity and/or Distance conjecture, that we get some finite kinetic terms. We will see that when the tower becomes light, it generates small gauge couplings and parametrically large field distances. In other words, in the UV there are no tiny gauge
couplings or infinite distances; these, as well as the approximate global symmetries that come with them, are just artifacts of the IR description.

A weaker version of the proposal @Heidenreich:2017sim @Heidenreich:2018kpg allows for a classical piece of the kinetic terms of the same form as the quantum corrected piece, so the IR value is not purely coming from quantum corrections. In that case, at the quantum gravity scale the fields are still dynamical but a sort of unification occurs, in the sense that gravity and the other gauge and scalar forces become strongly coupled at the same quantum gravity cut-off scale.

We started the section by promising that the emergence proposal provides a bottom-up explanation for the Swampland conjectures. The WGC and the SDC imply the presence of an infinite tower of states getting light, whenever the EFT allows for very small gauge couplings and/or very large field distance (how light depends on how small the gauge couplings or how large is the field distance). The emergence proposal goes the other way around by saying that having an infinite tower of states becoming light at some point in the field space generates the infinite
field distance and the small gauge coupling there, see @fig:emergence.

// [figvision] imgs/emergence.png
// This schematic depicts a cyclical relationship between two concepts. A light cyan ellipse with a dark blue
// border on the left contains the text Small gauge coupling over Infinite field distance. A matching light cyan
// ellipse on the right contains Infinite tower of weakly coupled light states. Two thick dark blue curved arrows
// form a closed clockwise loop between them: an upper arrow runs from the left ellipse to the right and is
// labeled WGC,SDC above it; a lower arrow runs from the right ellipse back to the left and is labeled Emergence
// below it. The diagram illustrates that the Weak Gravity Conjecture and Swampland Distance Conjecture link
// small gauge coupling and infinite field distance to an infinite tower of weakly coupled light states through
// emergence.
#figure(placement: top, image("imgs/emergence.png", width: 100%), caption: [Comparison of the emergence proposal and the WGC/SDC.],) <fig:emergence>



We can perform computations in a field theory toy model to exemplify how the infinite tower can indeed generate the small gauge coupling and the infinite field distance.

Consider the IR EFT resulting from integrating out a tower of states charged under some gauge field, for simplicity we stick to the 4d case. We should integrate out the tower up to a species bound $Lambda_("QG")$, as in @species, which acts as a QG cut-off above which quantum gravitational effects becomes important and QFT computations are not reliable any more. Using @species and @Nsepcies, the number of states $N$ of the tower running in the loops can be written purely in terms of the mass gap $Delta m$ as follows,
$
  N = (Delta m \/ M_p)^(- 2\/3)
$ <eq:N-species-bound>
Computing the one-loop correction from integrating out the tower of states, the IR quantum-corrected gauge coupling is given by

$
  frac(1, g^2_("IR")) = sum_(k=1)^N q_k^2 log #scale(x: 120%, y: 120%)[(] frac(L^2_("QG"), m_k^2) #scale(x: 120%, y: 120%)[)] tilde.eq sum_(k=1)^N k^2 log frac(N^2, k^2) tilde.eq N^3 tilde.eq frac(1, (Delta m)^2) ~ ,
$<IR-gauge-coupling-in-terms-of-mass-gap>
where $m_k = k Delta m$ and $q_k = k$ are the mass and charge of the $k$-th state of the tower, and $L_("QG")$ is the species scale in @species. This result implies that the mass of the states that we integrated out is proportional to the renormalized gauge coupling in the IR, i.e. $ m_k^2 tilde.eq k^2 g_("IR")^2 $, and this is precisely the WGC!

It should be emphasized that, in order to obtain this result, it is essential that we are summing an infinite tower up to its species bound.

The dependence of the cut-off and $N$ on $Delta m$ qualitatively changes the result, transforming the logarithmic behaviour on the mass into polynomial in @IR-gauge-coupling-in-terms-of-mass-gap.

In contrast, we could not reach this conclusion by integrating out only a finite number of states and having a constant cut-off. This motivates the stronger versions of the WGC in which there is not only one but an infinite number of states.

A similar calculation can be done for the Distance conjecture. If the mass of the tower of states is parametrised by some scalar field, quantum corrections from integrating out the tower will modify the field metric of the scalar. The one-loop contribution to the scalar propagator is given
// [figvision] imgs/metastable.png
// Panel (a): Line plot of potential V(φ) versus field φ, drawn as grey axes with arrowheads and labeled V(φ) on
// the vertical axis and φ on the horizontal axis; no numeric tick labels, ranges, or units are displayed. A
// single thick blue curve enters from high V on the left, descends to a shallow local minimum (the metastable
// vacuum), rises to a local maximum forming a barrier, then falls to a deeper global minimum on the right before
// flattening and approaching V=0 from below at large φ. There are no symbols, markers, line-style variations, or
// annotations beyond the axis labels. The message is that the left minimum is metastable and higher in energy
// than the right minimum, separated by a barrier, consistent with non-perturbative decay to the lower state.
by $ g_(phi.alt phi.alt) = sum_(k = 1)^N #scale(x: 120%, y: 120%)[(] partial_phi.alt m_k #scale(x: 120%, y: 120%)[)]^2 = #scale(x: 120%, y: 120%)[(] partial_phi.alt Delta m #scale(x: 120%, y: 120%)[)]^2 sum_(k = 1)^N k^2 tilde.eq #scale(x: 120%, y: 120%)[(] partial_phi.alt Delta m #scale(x: 120%, y: 120%)[)]^2 N^3 tilde.eq #scale(x: 180%, y: 180%)[(] frac(partial_phi.alt Delta m_k, Delta m_k) #scale(x: 180%, y: 180%)[)]^2  $<eq:emergence-metric> where $m_k$ is the mass of the particle of the tower running in the loop. As before, it is important to sum up
to the species bound @eq:N-species-bound where quantum field theory computations are not reliable any more. The proper field distance measured by using this renormalized field metric reads $ Delta phi.alt tilde.eq integral_(phi.alt_1)^(phi.alt_2) sqrt(g_(phi.alt phi.alt)) tilde.eq log (frac(Delta m ( phi.alt_2 ), Delta m ( phi.alt_1 )))  . $ This gives rise to the exponential behaviour of the tower predicted by the SDC in terms of the proper field distance. If the full tower becomes massless at some point $phi.alt_2$ of the moduli space,
// [figvision] imgs/metastable.png
// Panel (a): Line plot of potential V(φ) versus field φ, drawn as grey axes with arrowheads and labeled V(φ) on
// the vertical axis and φ on the horizontal axis; no numeric tick labels, ranges, or units are displayed. A
// single thick blue curve enters from high V on the left, descends to a shallow local minimum (the metastable
// vacuum), rises to a local maximum forming a barrier, then falls to a deeper global minimum on the right before
// flattening and approaching V=0 from below at large φ. There are no symbols, markers, line-style variations, or
// annotations beyond the axis labels. The message is that the left minimum is metastable and higher in energy
// than the right minimum, separated by a barrier, consistent with non-perturbative decay to the lower state.
so $Delta m ( phi.alt_2 ) = 0$, then the field distance becomes infinite. Again, this only occurs upon integrating out an infinite tower up to its species scale, since a finite number of fields will always generate a finite distance.#footnote[Quantum corrections from integrating out only a #emph[finite] number $n$ of fields would generate a finite field distance given by $Delta phi.alt tilde.eq n integral partial_phi.alt m = n ( m ( phi.alt_2 ) - m ( phi.alt_1 ) ) < oo$.] So from this point of view it is the tower itself that is responsible for the
infinite distance.
// [figvision] imgs/domainwallv2.png
// A single schematic diagram with no axes or units. At center stands a vertical, translucent blue plane labeled
// "domain wall with charge q". To its left, black text reads "vacuum with flux f" above a green W-shaped
// potential curve with two minima. To its right, black text reads "vacuum with flux f + q" above an orange
// W-shaped potential curve partly overlaid by a green dotted curve. Four blue horizontal arrows point left to
// right across the domain wall, indicating flux change through the wall. The message is that a charged domain
// wall separates and interpolates between two vacua whose fluxes differ by q.
Although these are just toy model computations, the emergence of the WGC and SDC behaviours arising from integrating out the towers of states serves as motivation for the Emergence proposal. Unfortunately, the estimations of the species bound are not precise enough to trust the resulting numerical factors. There are some string theory setups, though, in which these toy model computations actually provide a good approximation of the physics and the Emergence proposal can be checked. Consider the type IIB Calabi-Yau compactifications of @sec:typeII-CY. It
is known that the geometry near the conifold singularity in the complex structure moduli space can be reproduced by computing the quantum corrections of the BPS state becoming massless at the singular point @Strominger:1995cz. Thanks to supersymmetry, it is enough to compute the one-loop correction to the gauge coupling and the field metric to reproduce the geometric result. Hence, the complex structure moduli space is quantum in nature, in the sense that it incorporates the effects from integrating out the BPS states. The singularities are then
generated because one is 'incorrectly' integrating out some BPS states that are actually massless. Analogously, one can compute the quantum corrections from integrating out the tower of BPS states near the infinite distance singularities and check that the resulting gauge coupling and field metric in @IR-gauge-coupling-in-terms-of-mass-gap and @eq:emergence-metric matches with the results obtained from the geometry. This was done in @Grimm:2018cpv, providing evidence for the Emergence proposal. The difficulty behind extending these computations beyond
// [figvision] imgs/bubblev2.png
// This is a single schematic panel with no axes, scales, or quantitative ranges. A light blue circular disk is
// centered on a white background, filled with a radial gradient from pale blue at the center to slightly deeper
// blue at the rim. Black sans-serif text inside reads "AdS with less flux" on two centered lines. Eight dark
// gray arrows radiate outward from the disk perimeter at roughly 45 degree intervals, pointing straight up,
// straight down, left, right, and along all four diagonals. Each arrow has a solid triangular head and uniform
// thickness. The arrows originate at the circle boundary and extend outward, indicating expansion in all
// directions. The diagram represents a bubble of AdS vacuum with less flux inside nucleating and expanding to
// mediate vacuum decay.
the complex structure moduli space is that the species bound of the tower in other scenarios is typically above the KK scale or around the string scale, so that a low energy field theory computation is not possible.

= Non-SUSY AdS Instability Conjecture <sec:nonsusy-ads>

// [figvision] imgs/domainwallv2.png
// A single schematic diagram with no axes or units. At center stands a vertical, translucent blue plane labeled
// "domain wall with charge q". To its left, black text reads "vacuum with flux f" above a green W-shaped
// potential curve with two minima. To its right, black text reads "vacuum with flux f + q" above an orange
// W-shaped potential curve partly overlaid by a green dotted curve. Four blue horizontal arrows point left to
// right across the domain wall, indicating flux change through the wall. The message is that a charged domain
// wall separates and interpolates between two vacua whose fluxes differ by q.
The conjecture first appeared a few years ago in @Ooguri:2016pdq.  While @Ooguri:2016pdq focused on the non-trivial case of AdS spacetime, it was emphasized in @Freivogel:2016qwc that it should apply to any non-susy vacuum.

#figure(block(inset: 10pt, stroke: (left: 1.2pt))[ *Conjecture (No Non-susy Stable Vacuum).*  Any non-supersymmetric vacuum is at best metastable and has to decay eventually. ], kind: "conjecture", numbering: "1.", supplement: []) <conj:nonsusy>

In other words, supersymmetry is the only mechanism to protect a vacuum from decaying in quantum gravity. Typically, it is quite common to generate some instabilities when breaking supersymmetry. But it is highly non-trivial to propose that this should always be the case; in particular, it is false for a QFT in the absence of gravity.

// [figvision] imgs/bubblev2.png
// This is a single schematic panel with no axes, scales, or quantitative ranges. A light blue circular disk is
// centered on a white background, filled with a radial gradient from pale blue at the center to slightly deeper
// blue at the rim. Black sans-serif text inside reads "AdS with less flux" on two centered lines. Eight dark
// gray arrows radiate outward from the disk perimeter at roughly 45 degree intervals, pointing straight up,
// straight down, left, right, and along all four diagonals. Each arrow has a solid triangular head and uniform
// thickness. The arrows originate at the circle boundary and extend outward, indicating expansion in all
// directions. The diagram represents a bubble of AdS vacuum with less flux inside nucleating and expanding to
// mediate vacuum decay.
The instability can be perturbative or non-perturbative. In the latter case, it is called a metastable vacuum, as the decay rate is exponentially suppressed, see @fig:metastable. The conjecture does not give any bound on the decay rate, so the vacuum can be very long-lived. Hence, the implications of this conjecture for dS could be negligible (however see the next section for stronger conjectures about dS vacua). On the other hand, the implications for AdS are huge, as the existence of the boundary implies that a mestastable AdS vacuum cannot live longer
than a Hubble time. We will discuss the implications for AdS/CFT in @sec:-inst-implications. Regarding Minkowski vacua, they could in principle also be very long-lived, although it is actually not clear whether non-susy Minkowski vacua even exist as they require an extreme fine-tunning to keep a vanishing cosmological constant.

// [figvision] imgs/metastable.png
// Panel (a): Line plot of potential V(φ) versus field φ, drawn as grey axes with arrowheads and labeled V(φ) on
// the vertical axis and φ on the horizontal axis; no numeric tick labels, ranges, or units are displayed. A
// single thick blue curve enters from high V on the left, descends to a shallow local minimum (the metastable
// vacuum), rises to a local maximum forming a barrier, then falls to a deeper global minimum on the right before
// flattening and approaching V=0 from below at large φ. There are no symbols, markers, line-style variations, or
// annotations beyond the axis labels. The message is that the left minimum is metastable and higher in energy
// than the right minimum, separated by a barrier, consistent with non-perturbative decay to the lower state.
#figure(placement: top, image("imgs/metastable.png", width: 100%), caption: [Potential with a metastable vacuum (the left one). It can decay non-perturbatively to the lower energy minimum on the right, which presumably should be supersymmetric if stable.],) <fig:metastable>



== Motivation from the WGC <sec:motivation-from-WGC>

The original motivation for the conjecture comes from the WGC, as it provides a decay mode for non-susy vacua supported by fluxes.

Consider an AdS vacuum supported by fluxes, meaning that some of the scalars are stabilized by a scalar potential, which is generated by these fluxes. Specifically, fluxes can originate from gauge fields with field strength $F_p$ propagating in the extra dimensions, so the fluxes $f$ are given by the integrals $ integral_("§"_p) F_p = f  $ over some internal non-trivial $p$-cycle. These fluxes induce a scalar potential which can stabilize the scalars in a particular minimum, say an AdS
// [figvision] imgs/cobordismv2.png
// Panel (a) is a schematic diagram. A translucent light-blue sphere at center is labeled "Bubble of nothing".
// Eight thick black arrows radiate outward along cardinal and intercardinal directions, indicating expansion at
// the speed of light. On the upper-right rim, a blue flared tube emerges from the sphere, filled with dashed
// blue internal curves, and terminates in an orange ring labeled S¹. This represents the internal compact
// manifold shrinking to zero size on the bubble wall. No axes or numerical ranges are shown. Panel (b) is a
// schematic diagram. A blue irregular closed curve labeled B_{d+1} forms a compact manifold in the trivial
// bordism class. An orange irregular closed curve labeled C_d shares part of its boundary and encloses a
// separate region. Inside C_d, a dashed blue ellipse surrounds an orange ring labeled S¹, indicating the
// shrinking compact cycle. Two small blue loop drawings lie inside B_{d+1}. The diagram illustrates that a
// manifold in the trivial bordism class can become a bubble of nothing. No axes or numerical ranges are shown.
vacuum.#footnote[It is not necessary that all scalars are stabilized by fluxes, but rather changing the flux changes the vacuum we are in.] The fluxes are Hodge dual to top form gauge field strengths $cal(F)_d = "d" C_(d - 1)$ where $d$ is the spacetime dimension. We can now apply the WGC to the gauge field $C_(d - 1)$ which implies the existence of some electrically charged $( d - 2 )$-brane that plays the role of a domain wall of codimension
one.#footnote[Here we applied WGC to the non-dynamical gauge fields dual to the fluxes in the lower dimensional EFT. Equivalently, from the higher dimensional perspective, we can apply the WGC to the magnetic duals $star.op F_p$ of the gauge fields in the extra dimensions. It implies that there should be a charged $( D - p - 2 )$-brane, where $D$ is the total spacetime dimension. Then, dimensional reduction of these branes on the dual cycles to $"§"_p$ gives $( d - 2 )$-branes, which are the domain walls obtained above.] The WGC requires such a brane to
satisfy

$ T lt.eq Q M_p^2 $<inequality-tension-charge>

where $T$ denotes the brane tension. These branes are magnetically charged under the fluxes and interpolate between different vacua with different values for the fluxes.
Suppose that the vacuum state on one side of the domain wall has flux $f$. Then the charge conservation law determines the flux of the vacuum state on the other side of the wall to be equal to $f + q$, where $q$ is the quantized charge of the brane (see @fig:domainwall). The presence of these domain walls is somewhat expected in a flux landscape, but the novelty of the WGC is the upper bound on the tension.

// [figvision] imgs/domainwallv2.png
// A single schematic diagram with no axes or units. At center stands a vertical, translucent blue plane labeled
// "domain wall with charge q". To its left, black text reads "vacuum with flux f" above a green W-shaped
// potential curve with two minima. To its right, black text reads "vacuum with flux f + q" above an orange
// W-shaped potential curve partly overlaid by a green dotted curve. Four blue horizontal arrows point left to
// right across the domain wall, indicating flux change through the wall. The message is that a charged domain
// wall separates and interpolates between two vacua whose fluxes differ by q.
#figure(placement: top, image("imgs/domainwallv2.png", width: 100%),
  caption: [
    A charged brane interpolates between vacua with different fluxes.
  ]
) <fig:domainwall>

Now, let us assume that the sharpened version of the WGC discussed in @sec:sharpening-wgc is valid.

If the vacuum is not supersymmetric, then the sharpening of the WGC requires the strict inequality $T < Q M_p^2$. But a codimension one brane with a tension smaller than its charge corresponds to an instability in !

The intuition is simple and it is based on energy conservation. We can nucleate a bubble (whose wall is the brane) and, if the tension is smaller than the charge, the energy cost of expanding the bubble will be smaller than the energy gain from the electric repulsion between different points on the wall. So the bubble will grow indefinitely and will eventually describe a false vacuum decay to the true vacuum inside the bubble, in the sense that as the bubble comes to occupy the entire space, everything will be in the true vacuum, see @fig:bubble.

// [figvision] imgs/bubblev2.png
// This is a single schematic panel with no axes, scales, or quantitative ranges. A light blue circular disk is
// centered on a white background, filled with a radial gradient from pale blue at the center to slightly deeper
// blue at the rim. Black sans-serif text inside reads "AdS with less flux" on two centered lines. Eight dark
// gray arrows radiate outward from the disk perimeter at roughly 45 degree intervals, pointing straight up,
// straight down, left, right, and along all four diagonals. Each arrow has a solid triangular head and uniform
// thickness. The arrows originate at the circle boundary and extend outward, indicating expansion in all
// directions. The diagram represents a bubble of AdS vacuum with less flux inside nucleating and expanding to
// mediate vacuum decay.
#figure(placement: top, image("imgs/bubblev2.png", width: 100%), caption: [Bubble nucleation of an AdS vacuum with less flux inside. It will expand mediating vacuum decay.],) <fig:bubble>



More concretely, one can construct the instanton solution that mediates the vacuum decay. For this purpose, consider the following parametrization of the AdS#sub[d] metric, $d s^2 = L^2 ( cosh^2 r thin d tau^2 + d r^2 + sinh^2 r thin d Omega_(d - 2)^2 )$

with $L$ the AdS radius. Following @Maldacena:1998uz, the instanton solution corresponds to a spherical brane of action
$
  S = L^(d-1) Omega_(d-2) integral "d"tau ( T sinh^(d-2) r sqrt( cosh^2 r + ( "d"r \/ "d"tau )^2 ) - Q sinh^(d-1) r )
$
Upon solving the euclidean Einstein's equations, one gets that the radius for the spherical brane solution is given by#footnote[This computation was performed in the probe/thin wall approximation, neglecting e.g. the backreaction on the scalar fields. Although this is a good approximation far away from the object, it would be desirable to have a more complete analysis including the scalar contribution to the WGC bound.] $tanh R = T\/Q$ in Planck units. In Lorentzian signature, this will be associated with the nucleation of a bubble of radius $R$ that
will continue expanding at the speed of light. The strict inequality on the WGC condition @inequality-tension-charge implies $tanh R < 1$ which admits solutions for finite values of the radius. On the contrary, if the vacuum is supersymmetric, we could satisfy the WGC by a BPS brane saturating the inequality @inequality-tension-charge, implying

$ tanh R = 1 $<infini-radius-domain-wall>

whose only solution has infinite radius. Thus, we get a straight domain wall interpolating between different susy vacua which remain stable.
$
  tanh R = T \/ Q
$
In conclusion, the sharpening of the WGC in @sec:sharpening-wgc, implies the presence of a codimension one brane with a tension smaller than its charge in non-susy vacua, which describes a bubble instability. According to this argument, any AdS non-susy vacuum with fluxes should be at best metastable.

== Bubbles of Nothing <bubbles-of-nothing>

We have seen that the sharpened WGC provides a decay mode for non-susy vacua with fluxes. But what if there are no fluxes and, therefore, we cannot use the WGC? In principle, conjecture @conj:nonsusy should apply to any non-susy vacuum. It would be very interesting then to look for an universal instability whenever supersymmetry is broken, regardless of the ingredients of the theory.

A potential candidate for a universal instability, whenever there are extra dimensions, is a #emph[bubble of nothing]. This was first constructed by Witten in @witten_instability_1982, and we have recently learned that these instabilities are far more common than thought @GarciaEtxebarria:2020xsr. \

#block[
#strong[Bubble of Nothing.] A bubble of nothing is a non-perturbative instability mediating the decay from the vacuum to nothing, i.e. the vacuum annihilates itself. This occurs when a compact dimension collapses to zero size at the bubble wall.

]

Hence, it is literally a bubble with nothing inside (not even a spacetime) that pops up in the vacuum and starts expanding at the speed of light, leaving #emph[nothing] behind. Expressed this way, it may sounds very exotic. However, it is a perfectly well defined smooth solution to the equations of motion. The trick is that some extra dimension collapses to zero size at the bubble wall, allowing for the full solution to be regular and geodesically complete from the higher dimensional perspective.

The existence of bubbles of nothing was first brought up by Witten @witten_instability_1982 in the case of a Kaluza-Klein circle compactification of five dimensional Einstein gravity to four dimensions. The circle shrinks to zero size when approaching the bubble wall, as represented in figure @witten_instability_1982. More generally, we can have bubbles of nothing for higher dimensional compact spaces as long as the compact dimensions are allowed to collapse. Bubbles of nothing have e.g. been constructed for $"AdS"_5 times S^5 \/ Gamma$ with freely
acting $Gamma$ and $"AdS"_4 times bb(C) P^3$, where no other decay mode was previously known, providing evidence for conjecture @conj:nonsusy.

// [figvision] imgs/cobordismv2.png
// Panel (a) is a schematic diagram. A translucent light-blue sphere at center is labeled "Bubble of nothing".
// Eight thick black arrows radiate outward along cardinal and intercardinal directions, indicating expansion at
// the speed of light. On the upper-right rim, a blue flared tube emerges from the sphere, filled with dashed
// blue internal curves, and terminates in an orange ring labeled S¹. This represents the internal compact
// manifold shrinking to zero size on the bubble wall. No axes or numerical ranges are shown. Panel (b) is a
// schematic diagram. A blue irregular closed curve labeled B_{d+1} forms a compact manifold in the trivial
// bordism class. An orange irregular closed curve labeled C_d shares part of its boundary and encloses a
// separate region. Inside C_d, a dashed blue ellipse surrounds an orange ring labeled S¹, indicating the
// shrinking compact cycle. Two small blue loop drawings lie inside B_{d+1}. The diagram illustrates that a
// manifold in the trivial bordism class can become a bubble of nothing. No axes or numerical ranges are shown.
#figure(placement: top, image("imgs/cobordismv2.png", width: 100%),
  caption: [
    (a) The bubble of nothing is expanding at the speed of light. The internal compact manifold shrinks to zero size on the bubble wall. Here $S^1$ is an example of internal compact manifold that belongs to the trivial class, i.e. $S^1 = partial D$. (b) A compact manifold $C_d = partial B_(d + 1)$ that belongs to the trivial bordism class $cal(O)_d^♯$, can become a bubble of nothing.
  ]
) <fig:cobordism>

Consider some compactification $M_D times C_d$ with $C_d$ the compact space and $M_D$ the space-time. Whether this compact space is topologically allowed to shrink to zero size gets translated to the question of whether it can be written as the boundary of another manifold of one dimension higher, i.e. $C_d = partial B_(d + 1)$. For Witten's case with $C_1 = S^1$, the circle is the boundary of a disk (@fig:cobordism). In general the compact manifold will be a boundary if it belongs to the trivial class of the cobordism group $Omega_(d)$ (@fig:cobordism).
Recall that the bordism group was defined in @sec:cob, so we refer the reader there for details. In a nutshell, we say that two manifolds are bordant to each other if together they form a boundary of another manifold, and a manifold which is a boundary by itself belongs to the trivial class. Manifolds of this latter type admit bubbles of nothing at the topological level. This can be summarized as follows: $ && "Compact manifold " C_d " can shrink to zero size" ⟺ C_d = partial B_(d+1) ⟺ \
  && C_d " belongs to trivial class of " cal(O)_d ⟺ "A bubble of nothing is topologically allowed." $

The euclidean instanton solution mediating the decay is a warped product of the bordism manifold over a $( D - 1 )$-sphere given by $cal(M)_("BON") = B_(d + 1) times_W S^(D - 1)  .$ The decay rate is exponentially suppressed by the euclidean action, i.e. $Gamma tilde.op e^(- S_("BON"))$, where $S_("BON")$ can be computed to be proportional to the volume of the compact space $C_d$ at spatial infinity.

The decay rate is exponentially suppressed by the euclidean action, i.e. $Gamma tilde e^(- S_("BON"))$, where $S_("BON")$ can be computed to be proportional to the volume of the compact space $C_d$ at spatial infinity.

For the case of a KK circle compactification with fermions, $C_d = S^1$ preserves a spin structure. We then have $Omega_1^"spin" = Z_2$, implying that only the circle with antiperiodic boundary conditions for the fermions belongs to the trivial class on bordism and admits a bubble of nothing. Contrary, the circle with periodic (SUSY-compatible) boundary conditions cannot decay via a bubble of nothing, even if the vacuum breaks supersymmetry.

However, this topological obstruction can be absent in higher dimensions since e.g. $Omega_d^"spin" = 0$ for $d = 3, 5, 6, 7$. Therefore, any spin manifold of these dimensions admits a bubble of nothing! This was shown in @GarciaEtxebarria:2020xsr and used to construct new types of bubbles of nothing for a toroidal $T^3$ compactification with periodic boundary conditions. This is very interesting as it implies that a bubble of nothing can exist even if the boundary conditions are periodic and supersymmetry is restored at high energies (as long as the vacuum breaks susy spontaneously).

It is very important to remark, though, that the fact that a bubble of nothing is topologically allowed, does not mean that it will expand after nucleation, describing an instability. For this to happen, the decay must be dynamically allowed, in the sense that it must be energetically favourable to decay. Otherwise, it will either collapse after nucleation or it will describe a flat domain wall instead of a bubble instability, as happens for a vacuum that preserves supersymmetry. In the latter case the radius of the euclidean solution will be infinite,
describing an end-of-the-world brane. This dynamical obstruction is tied to whether a certain local energy condition is satisfied @GarciaEtxebarria:2020xsr. For instance, in the case of a manifold with covariantly constant spinors, the bubble of nothing will be dynamically allowed and the vacuum will decay only if the Dominant Energy Condition is
violated.#footnote[The Dominant Energy Condition requires the vector $-T^(mu)_(nu)n^(nu)>0$ to be causal and future-pointing, for every causal and future-pointing vector $n^(mu)$ and $T_(mu nu)$ being the stress-energy tensor.] Interestingly, this condition is generically violated when the vacuum breaks supersymmetry. For a theory with charged fermions, the energy condition is modified and resembles the WGC. By studying the relation between these energy conditions and supersymmetry in more detail, we could end up proving or disproving the conjecture
about the instability of any non-susy vacuum.

== Implications of AdS Instability Conjecture
<sec:-inst-implications>

Here, we are going to discuss two implications of the AdS instability conjecture.

#underline[Non-susy AdS/CFT]: \

An instability in AdS, even if highly suppressed, has dramatic implications for the boundary CFT. Note that an observer at the boundary has access to an infinite volume of the bulk and hence can detect any bulk instability instantaneously. This implies that the AdS vacuum has no dual unitary CFT. From the gravity side, the instability will reach the boundary and come back in Hubble time, so this is the maximum lifetime of the vacuum.

This can have important implications for non-susy holography. Notice, though, that the previous discussion about AdS instabilities was performed in the context of a weakly coupled Einstein gravity theory, in which a semiclassical description of bubble instabilities is possible and the WGC applies. Consequently, non-susy holography can be consistent but only if the non-susy unitary CFT is dual to a gravity theory which is not AdS weakly coupled to Einstein gravity. In other words, a non-susy unitary CFT cannot admit a large N expansion and/or a large gap
to single-trace higher s operators (s greater than two).

// [figvision] imgs/potential.png
// Panel a: A schematic diagram of field space drawn as a soft-edged five-lobed star filled with a radial blue
// gradient that darkens toward the center and lightens toward the outer boundary. A thick black curved arrow
// begins near the center and sweeps upward toward the upper edge, indicating motion toward an infinite-distance
// point in field space. No axes, tick marks, or numerical scales are present. The arrow denotes the direction of
// approach to the boundary where, according to the asymptotic de Sitter conjecture, the potential exhibits
// runaway behavior as the field traverses infinite distance. Panel b: A two-dimensional line plot with a
// vertical axis labeled V(φ) and a horizontal axis labeled Δφ, each ending in an arrowhead but without tick
// marks, numerical ranges, or units. A single thick blue curve starts near the top of the vertical axis at small
// Δφ and decays monotonically and smoothly, asymptotically approaching zero as Δφ extends to the right. The
// curve is convex throughout, illustrating the runaway drop of the potential as the field traverses infinite
// distance in field space. No additional series, symbols, or annotations appear.
#underline[Compactifications of Standard Model of particle physics]: \

This conjecture can also have implications for our universe. Even though we do not live in an AdS spacetime, non-susy AdS vacua can still be generated in lower dimensions from compactifying the Standard Model. The simplest case is to compactify on a circle to three dimensions. Assuming background independence, compactifications of a theory consistent with QG should also be consistent. Hence, according to the conjecture, these 3d AdS vacua should be unstable because otherwise the Standard Model would be inconsistent with quantum gravity! But this cannot
possibly be the case, since the Standard Model is clearly a low energy theory consistent with QG describing our universe. We then need to find a way to exclude the existence of these stable 3d vacua, which can be done by placing bounds on beyond Standard Model parameters and the cosmological constant of our universe. In particular, we can guarantee the absence of stable AdS vacua by imposing a lower bound on the value of the cosmological constant $Lambda_4$ in terms of the Dirac
// [figvision] imgs/potential.png
// Panel a: A schematic diagram of field space drawn as a soft-edged five-lobed star filled with a radial blue
// gradient that darkens toward the center and lightens toward the outer boundary. A thick black curved arrow
// begins near the center and sweeps upward toward the upper edge, indicating motion toward an infinite-distance
// point in field space. No axes, tick marks, or numerical scales are present. The arrow denotes the direction of
// approach to the boundary where, according to the asymptotic de Sitter conjecture, the potential exhibits
// runaway behavior as the field traverses infinite distance. Panel b: A two-dimensional line plot with a
// vertical axis labeled V(φ) and a horizontal axis labeled Δφ, each ending in an arrowhead but without tick
// marks, numerical ranges, or units. A single thick blue curve starts near the top of the vertical axis at small
// Δφ and decays monotonically and smoothly, asymptotically approaching zero as Δφ extends to the right. The
// curve is convex throughout, illustrating the runaway drop of the potential as the field traverses infinite
// distance in field space. No additional series, symbols, or annotations appear.
mass#footnote[Majorana neutrinos (only 2 degrees of freedom) would be ruled out according to the conjecture, as they always generate an AdS vacuum.] of the lightest neutrino $m_nu$@Ibanez:2017kvh, which roughly goes as

$ Lambda_4 gt.tilde m_nu^4  . $<naturalness>

Interestingly, this could explain the numerical coincidence $Lambda_4 tilde.op m_nu^4$ observed in our universe. Furthermore, we can write the neutrino mass in terms of the Higgs vev, so that the previous bound gets translated to an upper bound on the electroweak scale $ chevron.l H chevron.r lt.tilde Lambda^(1 \/ 4) \/ Y_nu $ where $Y_nu$ is the neutrino Yukawa coupling. Amazingly, this relates the two naturalness problems associated to the cosmological constant and the EW scale, so that if we happened to live in a universe with a
small $Lambda^(1 \/ 4)$, the EW scale would also have to be small (of order TeV at most) by consistency of quantum gravity. Hence, there is no EW hierarchy problem to start with, as greater values of $chevron.l H chevron.r$ would not lead to theories consistent with quantum gravity.

Let us emphasize, though, that this is #emph[not] a solution to the EW hierarchy problem yet. Clearly, we first need to prove the validity of the Swampland conjecture. But also, we are assuming that there is no other way to destabilize the lower dimensional AdS vacua beyond those provided by the Standard Model, which can be criticized. Yet, this result exemplifies the potential of the Swampland conjectures to change our logic of naturalness, which breaks down when taking into account quantum gravity constraints. The naturalness issues observed in our
universe could simply be artifacts of not yet knowing the space of parameters that is consistent with quantum gravity. Remember, not everything goes!

= de Sitter Conjecture <sec:dS>


For the time being, it is still an open question whether string theory admits a de Sitter vacuum or not. At the moment, there is no full-fledged top-down de Sitter construction in a controllable regime of string theory. Although there is no universal no-go theorem either. This is a challenging and very important objective in string theory, due to the obvious phenomenological implications for the cosmological expansion of our universe. Based on the relations to other Swampland conjectures, and the difficulties of constructing a dS vacuum in string theory,
the following Swampland conjecture has been proposed @Obied:2018sgi @Ooguri:2018wrx @Garg:2018reu asserting that de Sitter vacua (even if metastable) are not consistent with quantum gravity: \

#block[
#strong[de Sitter Conjecture.] A scalar potential of an EFT weakly coupled to Einstein gravity must satisfy

$ M_P frac(| nabla V |, V) gt.eq c $<dS>

with $c$ some $cal(O) ( 1 )$ constant. This was further refined by stating that the previous bound only needs to be imposed if the following condition on the second derivative of the potential is violated, $ min #scale(x: 120%, y: 120%)[(] nabla_i nabla_j V #scale(x: 120%, y: 120%)[)] lt.eq frac(- c' V, M_P^2) $ with $c'$ another $cal(O) ( 1 )$ constant. This way, only dS minima (and not critical points in general) are ruled out.
]
This conjecture is very strong and not free of controversy. Currently, it has only been checked in the asymptotic regions of the moduli space (i.e. near infinite distance singularities) where it is more widely accepted to be true. We will discuss this asymptotic version of the dS conjecture in the next subsection. For reviews about the status of de Sitter vacua in string theory we refer the reader to @Danielsson:2018ztv @Cicoli:2018kdo.

Let us finally mention that there is another conjecture also constraining the scalar potential in de Sitter space; this is the Transplanckian Censorship conjecture (TCC) @Bedroya:2019snp. In these lectures, we will not discuss it in much detail, but we will at least give its definition and comment on the differences with respect to the original dS conjecture. \

#block[
#strong[Transplanckian Censorship Conjecture.] The expansion of the universe must slow down before all Planckian modes are stretched beyond Hubble size. It has two implications:

- No dS minima can exist at the asymptotic boundaries of the moduli space. In the asymptotic regimes, one recovers a similar bound to @dS constraining the asymptotic behaviour of the potential, but with a fixed constant $c$ given by

$ frac(| nabla V |, V) gt.eq 2 \/ sqrt(( d - 1 ) ( d - 2 ))  . $<TCC>

- A dS minimum can exist deep inside the bulk, but it must be short-lived. The lifetime $tau$ for a metastable dS vacuum is bounded from above by $tau lt.eq 1\/H log M_P\/H$ where $H$ is the Hubble scale.

]
In a certain sense, the TCC is weaker than the dS conjecture as it does not completely forbid the existence of dS vacua, but only does so asymptotically. It also provides a lower bound on the exponential rate of the SDC tower, by assuming that the potential scales as $m^d$ with $d$ the space-time dimension @Bedroya:2019snp or as $m^2$@Andriot:2020lea.

== Asymptotic de Sitter Conjecture and Relation to SDC <asymptotic-de-sitter-conjecture-and-relation-to-sdc>

From the landscape of string theory compactifications, we can gather evidence for an asymptotic version of the dS conjecture. Although it has no official name, we will refer to it as the Asymptotic dS conjecture, see @fig:potential \

#block[
#strong[Asymptotic dS Conjecture.] A scalar potential of an EFT weakly coupled to Einstein gravity presents a runaway behavior when approaching an infinite field distance point,

$ | nabla V | gt.eq c V      c tilde cal(O) ( 1 )  . $<runaway>

]
We can also motivate this claim by using the Distance conjecture, as we will do below. The parameter $c$ is undetermined although the relation to the SDC suggests that it is proportional to the exponential rate of the infinite tower.

// [figvision] imgs/potential.png
// Panel a: A schematic diagram of field space drawn as a soft-edged five-lobed star filled with a radial blue
// gradient that darkens toward the center and lightens toward the outer boundary. A thick black curved arrow
// begins near the center and sweeps upward toward the upper edge, indicating motion toward an infinite-distance
// point in field space. No axes, tick marks, or numerical scales are present. The arrow denotes the direction of
// approach to the boundary where, according to the asymptotic de Sitter conjecture, the potential exhibits
// runaway behavior as the field traverses infinite distance. Panel b: A two-dimensional line plot with a
// vertical axis labeled V(φ) and a horizontal axis labeled Δφ, each ending in an arrowhead but without tick
// marks, numerical ranges, or units. A single thick blue curve starts near the top of the vertical axis at small
// Δφ and decays monotonically and smoothly, asymptotically approaching zero as Δφ extends to the right. The
// curve is convex throughout, illustrating the runaway drop of the potential as the field traverses infinite
// distance in field space. No additional series, symbols, or annotations appear.
#figure(placement: top, image("imgs/potential.png", width: 100%),
  caption: [
    The runaway behavior of the potential as we approach an infinite distance point in the field space according to the asymptotic de Sitter conjecture.
  ]
) <fig:potential>

This can be thought of as a generalization of the “Dine-Seiberg problem” for any direction in field space. Dine and Seiberg @Dine:1985he pointed out that the string coupling cannot be stabilized at weak coupling by classical effects. Classical limits are examples of infinite distance limits, and only away from these limits, when quantum corrections are important, can a minimum be generated. The asymptotic dS conjecture basically implies the same conclusion for any scalar direction when taking a large field limit, essentially forbidding the presence of dS
vacua at parametric control. Notice that this asymptotic version of the conjecture does not constrain KKLT-like constructions @Kachru:2003aw since those vacua are not at parametric control.

This is a concrete claim that we can check in string theory, as these asymptotic regimes are precisely those regimes in which we have control of the corrections and we can trust the EFT. In fact, the majority of models in string phenomenology are constructed in these regimes as we are often dealing with large volume, weak couplings, etc. So most of the time we are at some asymptotic regime in the field space even if we do not declare it explicitly. To be clear, every limit represents some perturbative expansion of the EFT in $1 \/ phi.alt$
where $phi.alt$ would be the scalar taken to be large. Whenever this perturbative expansion makes sense and the corrections are subleading with respect to the leading term, we say we are in the asymptotic regime. For the particular case of the string coupling, the corrections can be understood as quantum effects over a classical leading piece, although this interpretation in terms of classical vs quantum pieces does not extend to other limits. In @sec:dS-ST-evidence we will discuss the string theory evidence in support of this asymptotic version of the
dS conjecture.

$
  N tilde.eq e^(b phi.alt)
$<Ntower>

For a quasi-dS space in which we have a nearly flat potential, the contribution of the tower to the entropy cannot exceed the Gibbons-Hawking entropy, which is fixed by the value of $R$,

$ S_("tower") ( N R ) lt.eq S_("GH") = R^2 = 1 \/ H^2 $<boundS>

where $H$ is the Hubble scale. In the weak coupling limit,#footnote[Infinite distane limits are associated with weakly coupled descriptions of the theory.] one would expect that the light degrees of freedom dominate the Hilbert space, so the above bound is saturated.

Assuming that $S_("tower")$ depends polynomially on $N$ and $R$, the previous two equations imply an exponential behaviour of $R$ in terms of the field distance. For a nearly flat potential, $H^2 = R^(- 2)$ scales the same way as the potential, implying
$
  V(phi) tilde.eq H^2 tilde.eq e^(-c phi) .
$

The constant $c$ will be proportional to $b$ in @Ntower which is related to the exponential rate of the tower. More concretely, by parametrizing the entropy of the tower as
$
  S_"tower" tilde.eq N^gamma H^(- delta)
$
the bound @boundS implies
$
  H ≲ frac(1, N^(gamma \/ (2 - delta)))
$<HS>
in Planck units. The coefficient $c$ in the de Sitter conjecture is then given by

$
  c = frac(2 gamma, 2 - delta) b
$<cS>

As a particular example, we can take a KK tower of a circle compactification, so the exponential rate $lambda$ is given in @lambdaKK. We can estimate the number of states as the number of species in @Nsepcies, which can be written in Planck units as
$
  N = (Delta m)^((2-d)\/(d-1))
$
using @speciesm. Hence, it implies
$
  b = frac(d-2, d-1) lambda = sqrt( frac(d-2, d-1) ) .
$ <bKK>
Notice that @HS actually resembles the species bound in @species. In fact, if we impose that the Hubble scale is smaller than the species bound @species we get
$
  H ≲ Lambda_"QG" approx frac(1, N^(1\/(d-2)))
$<HQG>

in Planck units, which is equivalent to @HS upon identifying $frac(gamma, 2 - delta) = frac(1, d - 2)$. An interesting coincidence occurs when using this species bound result and the growth of a KK tower.

By replacing @Ntower and @bKK into @HQG, we get that the potential decreases exponentially in the distance with the following rate

$
  c = frac(2, d-1) lambda = frac(2, sqrt( (d-1)(d-2) ) )
$
which is precisely the value of the TCC factor in @TCC. Hence, upon using the species bound, the exponential rate of a KK tower would give rise to the asymptotic behaviour of the scalar potential predicted by the TCC.

== String Theory Evidence <sec:dS-ST-evidence>

Even before the formulation of this Swampland conjecture, there were several no-go theorems for de Sitter in the literature, valid in the classical regimes of certain string theory compactifications (see e.g. @Maldacena:2000mw @Hertzberg:2007wc @Flauger:2008ad @Wrase:2010ew). This has recently been extended to other setups, see e.g. @Danielsson:2018ztv @Andriot:2019wrs for recent reviews, as well as more general infinite distance limits beyond the classical regime (i.e. beyond small $g_s$) @Grimm:2019ixq. Different no-go theorems apply to different
compactification manifolds with fluxes and types of localized sources: D-branes, orientifolds, etc. Many of them are based on the asymptotic scaling of the potential with the moduli. As an example, we are going to discuss the original no-go theorem regarding type IIA on an orientifold CY#sub[3] @Hertzberg:2007wc, as all the others can, in a sense, be considered as generalizations of this one.

$
  V = frac(A_("NS") (phi), rho^3 tau^2) + sum_(p = 0, 2, 4, 6) frac(A_("RR", p) (phi), rho^(p - 3) tau^4) + frac(A_("D6") (phi), tau^3) - frac(A_("O6") (phi), tau^3) ,
$<flux-potential-IIA>
where each term corresponds to a different contribution from NS fluxes, RR $p$-form fluxes, D6-branes and O6-planes. The coefficients $A_i (phi)$ are positive and depend on the axion partners of the dilaton and the volume, as well as other ingredients, such as fluxes or other scalars of the compactfication. One can check that the derivatives of the scalar potential satisfy
$
  - rho partial_rho V - 3 tau partial_tau V = 9 V + sum_(p = 0, 2, 4, 6) p V_p gt.eq 9 V ,
$<no-extremum>
where the last inequality holds because $sum p V_p$ is always positive. This implies that we cannot stabilize the moduli in dS, as this equation has no solution for $partial_i V = 0$ and $V > 0$. In fact, no dS critical point is allowed.
Other no-go theorems will involve a similar inequality to @no-extremum but with different numerical coefficients coming from the moduli scaling of the different contributions to the potential. More generally, the no-go theorems based on the moduli scaling take the following form,
$
  a V(phi) + sum b_i partial_(phi^i) V(phi) lt.eq 0, quad a > 0, quad b_i eq.not 0 ,
$<general-no-go>
where the values of $a, b_i$ will depend on the specific moduli scaling of the potential and the field metric. If @general-no-go is satisfied, then the dS conjecture is satisfied with an order one factor $c$ given by
$
  | nabla V| gt.eq c V ; quad c^2 = frac(a^2, sum b_i^2) .
$<dS-conj>

When leaving the asymptotic regime, the coefficients $A_i (phi)$ receive corrections which can eventually change the sign of the coefficient, invalidating the no-go theorem.

Although many of these no-go theorems are formulated in the weak coupling limit of type II compactifications, it is also possible to generalize them beyond weak coupling by studying F-theory compactifications dual to M-theory with $G_4$ flux @Grimm:2019ixq. Employing the techniques of mixed Hodge structures, used to test the Distance conjecture in Calabi-Yau manifolds (see @sec:typeII-CY), we can determine the asymptotic form of the flux potential near any type of infinite distance limit in the complex structure moduli space of the CY#sub[4], which also
includes the type II dilaton. This way, one realizes that the coefficients $a, b_i$, and consequently $c$, are determined in terms of the type of infinite distance singularity under consideration, which is in turn fixed by the monodromy properties, as happened for the SDC. This supports that the dS conjecture is not associated to weak coupling but valid in more general infinite distance limits, and that indeed the SDC exponential rate and the dS conjecture factor $c$ are related, as they have the same geometrical origin.

There is still much more work to do and many questions to answer regarding this conjecture. For instance, we need to have a better understanding of the nature of the factor $c$. The situation is analogous to the exponential rate of the SDC, where we can gather evidence from the geometry of different string theory compactifications, but a general derivation based on EFT data is missing. Interestingly, from a bottom-up perspective, the factor $c$ may also be related to the extremality bound of the membranes that generate the scalar potential $V(phi)$.
Recall from @eq:CY-flux-potential that the fluxes can be dualized to top-form gauge field strengths, so $V(phi)$ becomes equivalent to the physical charge of a membrane whose quantized charges are equal to the fluxes. By applying the WGC to these fluxes, we find that membranes #emph[saturating] the WGC generate a scalar potential that satisfy the de Sitter conjecture, as shown in @Lanza:2020qmt.

= Final Remarks <final-remarks>

To conclude these lectures, we can take a final look at the web of Swampland conjectures represented in @fig:mapofconjectures. Now, the meaning of the different connecting lines between the conjectures is hopefully more clear for the reader. Sometimes, they imply that a conjecture follows from the other in a concrete setup, or that a certain conjecture can inform another. In other cases, they imply generalizations or extensions of a given conjecture. Hence, proving one conjecture is #emph[not] enough to prove the ones related to it. However, the
uncovered relations between a priori disconnected conjectures suggest that we are on the right path, and that some constraints along these lines should be require to guarantee consistency in quantum gravity.

In these notes, we have discussed in detail those conjectures for which the amount of evidence has significantly increased in the past few years, and with it, our confidence in the conjectures. These are the Absence of Global Symmetries, the Weak Gravity Conjecture and the Distance Conjecture. We have also briefly explained the rest of the conjectures represented in @fig:mapofconjectures, although they can often be understood as extensions of the previous three. Let us remark that there are a few other swampland conjectures which have not been included
in the figure, due to their recent formulation and lack of sufficient research by different groups. However, they might play an important role in the future, in the same way that some of the present conjectures might get disproven and disappear. The swampland program is very rapidly evolving, so we cannot discard the possibility that the diagram of the relevant conjectures might have a very different shape in the future.

Our job is to continue gathering evidence to prove or disprove the conjectures, as well as understanding their implications. In this sense, string theory is a perfect framework to sharpen and define the swampland constraints in a precise way. Even if our understanding of string theory is still in continuous evolution, we already have plenty of data from corners which are under computational control. Fortunately, it is precisely at these corners, typically boundaries of the field space, where weakly coupled Einstein gravity theories arise and, therefore,
where the swampland conjectures should naturally hold and can be quantitatively tested. Any ambiguity or undetermined order one factor in the conjectures should then disappear upon collecting enough information about the precise statements that hold at these string theory corners. A more difficult obstacle will be to abandon supersymmetry, although some first steps to testing the conjectures in non-supersymmetric setups have already been taken.

As a final remark, let us emphasize that it is at the infinite distance boundaries of field space where approximate global symmetries, weakly coupled gauge theories, large field ranges and an Einstein gravity description arise. And it is precisely at these boundaries where quantum gravitational effects preventing too well-approximated global symmetries become important, and where the swampland conjectures seem to have implications for the IR physics. Our universe shares these features, as we observe Einstein gravity at low energies as well as a weakly
coupled photon. So it might be precisely in universes like ours where we cannot ignore the UV imprint of quantum gravity at low energies. In fact, nature might be telling us with the naturalness issue of the cosmological constant and the EW hierarchy problem that it is time to break with the expectation of separation of scales originating from a Wilsonian quantum field theory approach. The UV/IR mixing induced by quantum gravity might be the missing piece to understanding these naturalness issues. In particular, our notion of naturalness should be
modified if not the entire space of parameters is consistent with quantum gravity, as the Swampland program defends. Maybe, after all, Quantum Gravity really matters at low energies, even if the Planck scale happens to be so high in energies. And this is, certainly, a very exciting possibility!


#heading(numbering: none)[Acknowledgements]

We would like to thank the organizers of the QFT and Geometry summer school 2020 for organizing such a wonderful school in such difficult times. Many thanks also to Miguel Montero for very helpful discussions and comments on the manuscript. The work of M.v.B. is in part supported by the ERC Consolidator Grant number 682608 "Higgs bundles: Supersymmetric Gauge Theories and Geometry (HIGGSBNDL)". The work by J.C. is supported by the FPU grant no. FPU17/04181 from the Spanish Ministry of Education and by the Spanish Research Agency
(Agencia Española de Investigación) through the grant IFT Centro de Excelencia Severo Ochoa SEV-2016-0597. D.M. is supported by TUBITAK grant 117F376. The research of I.V. was supported by a grant from the Simons Foundation (602883, CV).

#bibliography("refs.bib", style: "ieee", title: [References])
