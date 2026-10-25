#import "@preview/cetz:0.4.2"

// ---- document set ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 4.72cm, right: 4.74cm, top: 4.47cm, bottom: 4.13cm))
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#v(1.3cm)
#align(center)[
  #text(17.2pt, weight: "bold")[Non-Hermitian topological phenomena: A review] \
  #v(1.3em)
  #text(12pt, weight: "bold")[Nobuyuki Okuma¹ and Masatoshi Sato¹] \
  #v(2.6em)
  #text(8pt)[
    ¹Center for Gravitational Physics and Quantum Information, \
    Yukawa Institute for Theoretical Physics, Kyoto University, Kyoto 606-8502, Japan
  ]
]
#v(2.1em)

#align(center)[#block(width: 11.2cm, inset: (x: 1.2em, y: 0.8em))[
#set text(size: 9pt)
#set par(first-line-indent: (amount: 1.2em, all: true))
// abshead
#align(center)[#text(9pt, weight: "bold")[Abstract]]

  #h(1.2em) The past decades have witnessed an explosion of interest in topological materials, and a lot of mathematical concepts have been introduced in condensed matter physics. Among them, the bulk-boundary correspondence is the central topic in topological physics, which has inspired researchers to focus on boundary physics. Recently, the concepts of topological phases have been extended to non-Hermitian Hamiltonians, whose eigenvalues can be complex. Besides the topology, non-Hermiticity can also cause a boundary phenomenon called the non-Hermitian skin effect, which is an extreme sensitivity of the spectrum to the boundary condition. In this article, we review developments in non-Hermitian topological physics by focusing mainly on the boundary problem. As well as the competition between non-Hermitian and topological boundary phenomena, we discuss the topological nature inherent in non-Hermiticity itself.
]]
#v(1.6em)

= INTRODUCTION <introduction>

Recently, the topological properties of lattice systems have attracted broad interest in condensed matter physics. One of the major concepts in topological physics is the bulk-boundary correspondence in topological phases @Kane-review, @Zhang-review, which states that the topological invariant constructed from the bulk states counts the number of robust gapless boundary states @Hatsugai-93. In this context, topological phenomena also have aspects as boundary phenomena.

Dynamical properties of open systems are other major perspectives in recent condensed matter physics. While the Hamiltonian represented by a Hermitian matrix is the central object of interest in isolated equilibrium systems, non-Hermitian matrices, whose spectrum can be complex, play important roles in various open systems. Although the absence of Hermiticity brings about troublesome properties that defy the common sense of condensed matter physicists, it leads to new and deeper physics as well. In recent years, a lot of concepts in spectral theory @Trefethen and non-Hermitian physics @Bender-98 @Bender-02 @Bender-review @Konotop-review @Christodoulides-review have been introduced in condensed matter physics @ashida-gong-20.

In this paper, we review the topological physics in non-Hermitian lattice systems by focusing mainly on the boundary phenomena. The concept of topological phases was generalized to non-Hermitian systems in @Rudner-09 @Hu-11 @Esaki-11 @Schomerus-13 @Shen-18. In particular, @Esaki-11 provided bulk topological numbers in various non-Hermitian systems and showed the validity of the bulk-boundary correspondence in the presence of a class of symmetries. However, it was pointed out later that a general non-Hermitian system without such symmetries may exhibit other boundary phenomena specific to non-Hermitian systems @YW-18-SSH, @Kunst-18, called non-Hermitian skin effects @YW-18-SSH. The new effects localize bulk modes on boundaries and obscure the bulk-boundary correspondence. We first review the competition between the bulk-boundary correspondence and the non-Hermitian skin effects, but our focus is not merely on the competition between the two different phenomena. Remarkably, the latter non-Hermitian boundary physics is also closely related to topological physics. In the main part, we introduce the mathematics of non-Hermitian matrices and discuss recent developments in the field of non-Hermitian phenomena whose origin is #emph[non-Hermitian topology].

= REVIEW OF NON-HERMITIAN SKIN EFFECT <review-of-non-hermitian-skin-effect>

== Example and definition of non-Hermitian skin effect <example-and-definition>

In conventional solid-state physics, boundary insensitivity of bulk quantities plays important roles because one can freely choose a convenient boundary condition. In particular, the periodic boundary condition (PBC), together with translation invariance in solids, enables us to introduce band theory based on the momentum-space picture.

In non-Hermitian physics, on the other hand, the boundary condition can drastically affect bulk properties. Such a boundary sensitivity is best represented by the spectral properties of the Hatano-Nelson model (without disorder), which is a non-Hermitian tight-binding Hamiltonian defined on a one-dimensional lattice @Hatano-Nelson-96: @Hatano-Nelson-97 @Hatano98:

$
  hat(H)_"HN" = sum_i [ (t + g) c^dagger_(i+1) c_i + (t - g) c^dagger_i c_(i+1) ]
$<HNmodel>

where $i$ is the site index, $(c^dagger, c)$ are the bosonic or fermionic creation and annihilation operators, and $t in bb(R)$ and $g in bb(R)$ represent the Hermitian symmetric and non-Hermitian asymmetric hopping terms, respectively. We express the Hamiltonian in the equivalent matrix representation henceforth:

$ H_"HN" := mat(delim: "(",
  0, t - g, 0, dots.h;
  t + g, 0, t - g, dots.h;
  0, t + g, 0, dots.h;
  dots.v, dots.v, dots.v, dots.down
) $

Under the PBC $([H_"HN"]_(1,N) = [H_"HN"]_(N,1) = t ± g)$, we obtain the complex energy spectrum of the Hamiltonian by using the Fourier transform: $E_k = (t + g) e^(i k) + (t - g) e^(- i k)$, where $k = 2 pi j\/L$ ($j = 0, 1, dots., L - 1$) with $L$ being the number of sites. For $t g ≠ 0$, the PBC spectrum is on an ellipse in the complex plane. Under the open boundary condition (OBC), on the other hand, the eigenspectrum is completely different: Using the imaginary gauge transformation#footnote[This term was named after the fact that this transformation can be interpreted as a gauge transformation with an imaginary phase $theta$: $c_j -> e^(i theta j) c_j$, $c^dagger_j -> e^(- i theta j) c^dagger_j$.], one can map the OBC Hamiltonian to a Hermitian Hamiltonian without asymmetry @Hatano-Nelson-96: @Hatano-Nelson-97:

$ H_"HN"^"sim" := V_r^(-1) H_"HN" V_r = mat(delim: "(",
  0, sqrt(t^2 - g^2), dots.c;
  sqrt(t^2 - g^2), 0, dots.c;
  dots.v, dots.v, dots.c
) $ <imggauge>

where $[V_r]_(i,j) = r^i delta_(i j)$ with $r = sqrt((t + g)\/(t - g))$, and we have assumed $t > g > 0$ for simplicity. Since this is a similarity transformation, preserving the eigenspectrum of a finite-dimensional matrix, the OBC spectrum of the Hatano-Nelson model is given by that of the Hermitian matrix $H_"HN"^"sim"$. Thus, the OBC spectrum is on a line on the real axis of the complex plane, which is very different from the PBC one on an ellipse [@fig1(a)]. The corresponding OBC eigenstates, which are obtained from those of $H_"HN"^"sim"$ by the similarity transformation $V_r$, are exponentially localized at a boundary, in contrast to the extended PBC eigenstates.

Recently, such extreme sensitivities of eigenspectra and eigenstates against the boundary condition have been extensively studied as the #emph[non-Hermitian skin effect], named by Yao and Wang @YW-18-SSH. In their work, this term was used in the following situation @YW-18-SSH:

#emph[all the eigenstates of an open chain are found to be localized near the boundary]

In this paper, we adopt a broader definition of the non-Hermitian skin effect. We focus on the boundary-localized modes whose origin is non-Hermiticity. Unlike eigenstates of Hermitian Hamiltonians, the Hermitian conjugate of a right eigenstate (ket eigenvector) is not always a left eigenstate (bra eigenvector) in the presence of non-Hermiticity#footnote[More precisely, this is a property of non-normal matrices discussed later.]. To emphasize the difference, we adopt the following notation:

$
  H |E⟩ = E |E⟩, quad ⟪ E | H = E ⟪ E |
$<rightleft>

We call a mode $|E⟩$ as a #emph[non-Hermitian skin mode] if its spatial distribution is different from that of the left counterpart $|E⟩⟩$. Typically, we are interested in skin modes localized at one boundary whose left counterparts are localized at the other boundary [@fig1(b)]. Such a situation is realized in the case of the Hatano-Nelson model under the OBC. In the following, we define the non-Hermitian skin effect by the presence of non-Hermitian skin modes. As we will see throughout the paper, the presence of skin modes is equivalent to the extreme sensitivity of the non-Hermitian energy spectrum to the boundary condition.

In the first half of this paper, we will focus on #emph[conventional] skin effects with $cal(O)(L)$ skin modes#footnote[We count the number of modes by distinguishing algebraic degeneracy (multiplicity) for an eigenvalue $E$ defined as the number of times $lambda = E$ appears as a root of $det (H - lambda)$. For example, there is only one eigenvector for @HNmodel with $t = g$ because of the nondiagonalizability. In this case, the number of skin modes is counted as $L$, while the geometric degeneracy (multiplicity) defined as the dimension of the eigenspace is one.], which are found in one-dimensional systems with discrete translation invariance (except for the ends). In the presence of the conventional skin effect, the OBC bulk spectrum is determined by the non-Bloch band theory @Schmidt-Spitzer-60 @YW-18-SSH @YSW-18-Chern @Kunst-18 @YM-19 @yokomizo2020non @Yang-19 @KOS-20. In conventional band theory, the bulk spectrum, or the energy dispersion, is given as a function of crystal momentum $k$ (or the exponential factor of a Bloch wavefunction $e^(i k)$), $E(e^(i k))$. On the other hand, the non-Bloch band theory provides the OBC bulk spectrum as an analytic continuation $E(e^(i k)) -> E(beta)$, where $beta$ is a complex parameter on a closed curve in the complex plane, called the generalized Brillouin zone (GBZ). In the absence of the non-Hermitian skin effect, the GBZ reproduces the unit circle of the BZ, while in the case of the Hatano-Nelson model, it is given by a circle with radius $r^(-1)$. In general, the GBZ can be a complicated curve [@fig1(c)] and is determined with the help of numerical calculations, as discussed in @YM-19 @Yang-19.#footnote[The factors $e^(i k)(beta)$ in our notation correspond to the factors $e^(- i k)(beta^(-1))$ in @YM-19.]

// [figvision] imgs/fig1a.png
// Panel (a) of Fig. 1, two parts. Left: a PBC ring of eight open circles with two
// directed arcs between the two top sites, labelled t+g (clockwise) and t-g
// (counter-clockwise), and an OBC chain of four open circles below with the same pair of
// asymmetric arcs between its two central sites. Right: complex spectrum Im E (vertical,
// -2..2) versus Re E (horizontal, -2..2): a thick blue ellipse labelled PBC, spanning
// Re E from -2 to +2 and Im E from -1 to +1, and a thick red horizontal line at Im E=0
// from Re E=-2 to +2 labelled OBC.
// [figvision] imgs/fig1c.png
// Panel (c) of Fig. 1, two parts. Left: complex beta plane, Re beta (-1.5..1.5) versus
// Im beta (-1..1): the blue unit circle labelled BZ and a red elongated closed curve
// labelled GBZ that bulges outside the circle (Im up to about 1.2) with two inward
// kinks at Re beta ~ +-0.9 where it crosses Im beta=0. Right: complex energy plane,
// Re E (-2..2) versus Im E (-2..2): the blue PBC spectrum forms two lens-shaped loops
// that touch at E=0, while the red OBC spectrum is a thin X-shaped set of straight
// segments crossing at the origin and terminating near Re E = +-1.5.
// [figvision] imgs/fig1d.png
// Panel (a) is a black line plot of the eigenspectrum modulus |E| versus model parameter t1. The x-axis spans −3
// to 3, and the y-axis spans 0 to roughly 4. Numerous thin black curves form two large tear-drop regions running
// from |E|≈4 at t1=±3 down to |E|=0 at t1=∓1, plus a small central oval near |E|≈1 at t1=0. A thick red
// horizontal line lies at |E|=0 between approximately t1=−1 and t1=1. Blue arrows annotate t2−γ/2 at the central
// oval, t2+γ/2 near t1=1, and √(t2²+(γ/2)²) on the x-axis, indicating spectral boundaries.
#figure(placement: top, 
  grid(columns: (46%, 54%), column-gutter: 2%, row-gutter: 4pt,
// [figvision] imgs/fig1a.png
// Panel a is a scatter plot in the complex energy plane. The horizontal axis is the real part of energy and the
// vertical axis is the imaginary part of energy, both in arbitrary units. Two series are shown: the periodic
// boundary condition (PBC) spectrum as a blue loop forming a closed circle, and the open boundary condition
// (OBC) spectrum as red dots forming a vertical straight line strictly inside the PBC loop. The trend shows the
// non-Hermitian skin effect causing the OBC spectrum to collapse well inside the PBC bulk states, illustrating
// the spectral sensitivity to boundaries. Panel b is a line plot showing eigenstate amplitudes versus site
// index. The horizontal axis is the site index, ranging from 1 to 50, and the vertical axis is the probability
// amplitude. A Hermitian edge state is plotted with blue solid lines, where the right eigenstate is localized at
// the left boundary and the left eigenstate is localized at the right boundary. A non-Hermitian skin mode is
// plotted with red dashed lines, showing both right and left eigenstates localized at the same left boundary.
// This contrast demonstrates that skin modes break conventional chiral symmetry. Panel c is a schematic diagram
// in the complex momentum plane. The horizontal axis is the real part of the momentum parameter and the vertical
// axis is the imaginary part. The Brillouin zone (BZ) for PBC is drawn as a solid black unit circle. The
// generalized Brillouin zone (GBZ) for OBC is drawn as a red circle with a smaller radius, lying entirely inside
// the BZ. Annotations label the BZ and GBZ. The trend highlights how the GBZ contraction mathematically explains
// the spectral difference between PBC and OBC configurations. Panel d is a color-mapped plot of the absolute
// value of the OBC energy spectrum. The horizontal axis is a model parameter, such as the hopping amplitude
// ratio, ranging from 0 to 2. The vertical axis is the absolute energy, ranging from 0 to 3. A color gradient
// represents the density of states or distinct energy bands. Annotations mark the critical point at the
// parameter value of 1. As the parameter approaches 1, the band gap closes, illustrating the topological phase
// transition in the non-Hermitian Su-Schrieffer-Heeger model.
// [figvision] imgs/fig1c.png
// Panel (c), left plot: A schematic in the complex β-plane. The horizontal axis is Re β and the vertical axis is
// Im β, each spanning roughly −1.3 to 1.3. A blue circle of radius 1.0 centered at the origin is labeled BZ. A
// red closed curve outside it is labeled GBZ, reaching approximately Re β = ±1.2 and Im β = ±1.2, with a gently
// flattened top and bottom. The comparison shows how the generalized Brillouin zone deforms relative to the
// ordinary Brillouin zone under open boundaries. Panel (c), right plot: An energy spectrum with Re E on the
// horizontal axis from −2 to 2 and Im E on the vertical axis from −2 to 2. Blue curves marked PBC form two large
// loops that touch at the origin, extending to about Re E = ±1.7 and Im E = ±2. Red curves marked OBC consist of
// a straight horizontal segment on Im E = 0 between Re E ≈ −1 and 1, plus four diagonal segments joining its
// ends to points near (±1.4, ±2), producing an X-shaped structure inside the blue loops. The labels PBC and OBC
// appear in blue and red at the top.
    image("imgs/fig1a.png", width: 100%),
    image("imgs/fig1c.png", width: 100%),
    scale(67%, cetz.canvas(length: 1.1cm, {
      import cetz.draw: *

      let box(x0, y0, w, h, side, slow) = {
        // red localization profile filled under an exponential curve
        let N = 24
        let pts = ()
        let yb = y0 + 0.06
        let yt = y0 + h - 0.06
        let k = if slow { 1.6 } else { 4.2 }
        if side == "left" {
          pts.push((x0 + 0.06, yb))
          pts.push((x0 + 0.06, yt))
          for i in range(N + 1) {
            let t = i / N
            pts.push((x0 + 0.06 + t * (w - 0.12), yb + (yt - yb) * calc.exp(-k * t)))
          }
        } else {
          pts.push((x0 + w - 0.06, yb))
          pts.push((x0 + w - 0.06, yt))
          for i in range(N + 1) {
            let t = i / N
            pts.push((x0 + w - 0.06 - t * (w - 0.12), yb + (yt - yb) * calc.exp(-k * t)))
          }
        }
        line(..pts, close: true, fill: red, stroke: none)
        rect((x0, y0), (x0 + w, y0 + h), stroke: (thickness: 1.2pt, paint: black), fill: none)
      }

      content((-0.55, 3.5), anchor: "west", text(size: 14pt)[(b)])
      // column headers
      content((2.6, 3.35), text(size: 11pt)[Edge state])
      content((7.4, 3.35), text(size: 11pt)[Skin mode])
      // row labels
      content((0.0, 2.15), anchor: "east", text(size: 10pt)[$|E⟩$])
      content((0.0, 0.35), anchor: "east", text(size: 10pt)[$|E ⟫$])
      // four boxes
      box(0.35, 1.3, 4.5, 1.7, "left", false)
      box(5.35, 1.3, 4.5, 1.7, "left", false)
      box(0.35, -0.5, 4.5, 1.7, "left", true)
      box(5.35, -0.5, 4.5, 1.7, "right", false)
    })),
    image("imgs/fig1d.png", width: 100%),
  ),
  caption: [
    (a) The PBC and OBC eigenspectrum of the Hatano-Nelson model ($t = 1$, $g = 0.5$). (b) Right and left eigenstates of a Hermitian edge state and a non-Hermitian skin mode. (c) Brillouin zone (BZ) and generalized Brillouin zone (GBZ) for PBC and OBC spectra, respectively. We use $E(beta) = beta^2 - i beta + i beta^(-1) - beta^(-2)$@Trefethen @Okuma-correlated. (d) The OBC spectrum (absolute value) of the non-Hermitian Su-Schrieffer-Heeger model as a function of model parameter, adopted from @YW-18-SSH. The OBC and PBC gap-closing points are indicated by arrows. The emergence of topological zero modes (red) under the OBC cannot be predicted by the PBC information.
  ],
) <fig1>

== Bulk-edge correspondence under non-Hermitian skin effect <breakdown-of-bbc>

The non-Hermitian skin effect obscures the bulk-boundary correspondence @Lee-16 @MartinezAlvarez-18 @Xiong-2018 @Kunst-18 @YW-18-SSH @YSW-18-Chern. More precisely, even when the PBC spectrum is gapless and thus one cannot define the bulk topological invariant in the PBC, the bulk OBC spectrum can be gapped due to the skin effect. As a result, the topological phase diagram under the OBC is generally different from that under the PBC. In @fig1(d), the OBC spectrum of a non-Hermitian extension of the Su-Schrieffer-Heeger model @SSH-79, with asymmetric hopping @Lee-16 is plotted as a function of a model parameter @YW-18-SSH. This figure shows that the topological phase transition with the appearance of topological zero modes occurs at a point that is different from the gap-closing points under the PBC.

At first sight, this phenomenon suggests a breakdown of the bulk-boundary correspondence. However, even in such a case, one can recover the bulk-boundary correspondence once one introduces a proper topological invariant via the OBC bulk spectral information. For example, the topological invariant for the non-Hermitian Su-Schrieffer-Heeger model is given by a winding number defined in terms of the GBZ @YW-18-SSH in the OBC, instead of the conventional BZ in the PBC. To treat more generic cases including higher-dimensional systems and disordered ones, @song-real-space-19 proposed to use real-space topological invariants in the OBC, which enables us to characterize the bulk-boundary correspondence in terms of the explicit right and left eigenstates of the OBC Hamiltonian. These studies indicate that the bulk-boundary correspondence should be defined for the bulk and boundary modes under the common boundary condition. In the absence of the non-Hermitian skin effect, on the other hand, the topological invariant under the OBC coincides with that under the PBC. In this sense, the success of predictions by the PBC information in Hermitian topological physics is due to not only the bulk-boundary correspondence but also the boundary insensitivity, which is a special property of the systems without skin modes. Such a conventional bulk-boundary correspondence also holds in non-Hermitian systems without skin effects. Actually, when a class of symmetries may prohibit the skin effects @KSUS-19, the topological invariant under the PBC succeeds in the prediction of the boundary modes in the OBC @Esaki-11. One can also obtain the conventional bulk-boundary correspondence for the bosonic Bogoliubov-de Gennes Hamiltonian @bogoliubov1947theory, @Altland-Simons @Colpa-78 @kawaguchi2012spinor @Shindou-13, whose energy spectrum is given by the eigenspectrum of a non-Hermitian matrix with pseudo-Hermiticity and particle-hole symmetry @BdGsym @KSUS-19.#footnote[For more details, see a review paper of topological magnons @topo-magnon.] It should be noted here that one needs to generalize the topological invariants properly so as to be consistent with non-Hermiticity @Esaki-11 @Shen-18 @Shindou-13 @Ghatak-2019 even without the skin effects.

In this subsection, we have seen the competition between two different boundary phenomena: the bulk-boundary correspondence and the non-Hermitian skin effect. Actually, the non-Hermitian skin effect itself is also a kind of topological phenomenon, as we shall see in the following sections.

= Conventional skin effect as non-Hermitian topological phenomenon <conventional-skin-effect>

In this section, we review the topological nature of the conventional non-Hermitian skin effect @OKSS-20 @Zhang-19. In particular, we focus on the fact that the conventional non-Hermitian skin effect and the bulk-boundary correspondence in a class-AIII one-dimensional topological insulator share the same mathematical origin.

== Winding number as an indicator for conventional skin effect <winding-indicator>

As we mentioned, the OBC spectrum is given by a function of $beta$ on the GBZ determined by the non-Bloch band theory. Unfortunately, the shape of the GBZ is not a simple function of the model parameter in general, and the spectral behavior is unclear without the help of numerical calculations. Nevertheless, the presence or absence of the non-Hermitian skin effect is easily determined by the #emph[non-Hermitian topology], i.e., the winding number $W in bb(Z)$ of the PBC spectral curve in the complex plane. Several observations about this correspondence were indicated in @Gong-18, @Lee-Thomale-19 @Borgnia-19, and related theorems were proven in @OKSS-20 @Zhang-19. In the following, we focus on the theorem in @OKSS-20. Suppose that the system is described by a one-dimensional translation-invariant non-Hermitian tight-binding model $H$ with finite-range hopping and without symmetry. Then the following theorem holds in the infinite-volume limit @OKSS-20#footnote[For a rigorous definition of the infinite-volume limit, see the math textbook @Bottcher.].

#strong[Theorem]~~The OBC bulk spectrum cannot have a non-trivial winding number. Consequently, the PBC spectral curve with a non-trivial winding number implies that the OBC bulk spectral curve is different from the PBC one, or equivalently, the conventional skin effect inevitably occurs.

We here describe a strategy for the proof. Since there is no simple formula for calculating the OBC spectrum, it is difficult to compare the OBC spectrum to the PBC one directly. Thus, the proof of this theorem is divided into two parts: (i) the comparison between the PBC and the #emph[semi-infinite] boundary condition (SIBC), and (ii) that between the SIBC and the OBC. Here the "semi-infinite" means that there is only one boundary in the one-dimensional lattice. In step (i), we use the index theorem of spectral theory @Trefethen @Bottcher to relate the SIBC spectrum with the PBC one. According to the index theorem, the SIBC spectrum is given by a PBC curve together with all the points enclosed by the PBC curve with a non-zero winding number#footnote[In this proof, we focus only on the continuous spectrum and ignore isolated points. In physics, such points are nothing but edge modes such as the topological zero modes. For Toeplitz matrices, which correspond to cases without internal degrees of freedom in the unit cell, the statement here does not suffer from this subtlety.] [@fig2(a)]. Here, the winding number around a point $E in bb(C)$ is defined as

$
  W(E) := integral_0^(2 pi) frac(d k, 2 pi i) frac(d, d k) log det [ H(k) - E ]
$<windingnumber>

where $H(k)$ is the Bloch Hamiltonian of $H$ under the PBC. Corresponding to a point $E$ inside the PBC curve, the right (left) eigenstate is given by an exponentially localized boundary state for a negative (positive) winding number. In step (ii), we begin with the following inclusion:

$
  sigma_("OBC")(H) subset sigma_("SIBC")(H)
$

where $sigma$ denotes the spectrum. Besides an exact justification, it is intuitively natural because the OBC is given by a combination of the SIBC and an additional boundary condition at the other boundary. Once we admit this inclusion, we obtain another inclusion by applying the imaginary gauge transformation @imggauge, which is a kind of similarity transformation, to the Hamiltonian. The crucial point is that a similarity transformation changes the SIBC spectrum due to the infinite-dimensional nature of the matrix#footnote[Under the imaginary gauge transformation, the boundary of the SIBC spectrum is changed because the corresponding PBC Hamiltonian is also changed. The change of the PBC curve can be treated by introducing a Bloch Hamiltonian for complex momenta, $H(k - i log r)$@Lee-Thomale-19.] [@fig2(a)], while it does not change the OBC spectrum defined by the infinite-volume limit of the spectrum of a finite-dimensional matrix. Thus, the original OBC spectrum is included in the transformed SIBC spectrum. Since one can consider such an inclusion for an arbitrary imaginary gauge transformation $V_r$, we obtain

$
  sigma_("OBC")(H) subset ⋂_(r in (0, oo)) sigma_("SIBC")(V_r^(-1) H V_r).
$<intersection_inclusion>

Now we are in a position to prove the theorem. If the PBC spectrum has a non-trivial winding, one can find a SIBC mode with energy $E in bb(C)$ just inside the PBC curve, which is exponentially localized at the boundary. This boundary mode is mapped to a plane wave via the imaginary gauge transformation $V_r$ with an appropriate $r$, and $E$ is on the edge of $sigma_("SIBC")(V_r^(-1) H V_r)$, or equivalently, the PBC spectrum of $V_r^(-1) H V_r$. Thus, the intersection $sigma_("SIBC")(H) ∩ sigma_("SIBC")(V_r^(-1) H V_r)$ is smaller than the original SIBC spectrum $sigma_("SIBC")(H)$. This procedure can be repeated unless the right-hand side of the inclusion @intersection_inclusion becomes a curve without winding, which implies that the OBC spectrum cannot have a nonzero winding [@fig2(a)].

#figure(
  grid(columns: (34%, 66%), column-gutter: 1%,
    scale(70%, cetz.canvas(length: 0.62cm, {
      import cetz.draw: *
      let lgray = rgb("#D9D9D9")
      let dgray = rgb("#8C8C8C")
      let blu = rgb("#1500D6")

      content((-0.7, 9.6), anchor: "west", text(size: 14pt)[(a)])

      // nested tilted spectral contours
      group({
        translate((5.6, 4.7))
        rotate(18deg)
        // outer PBC / SIBC curve (light-gray disk, thick blue boundary)
        circle((0, 0), radius: (3.0, 4.15), fill: lgray,
          stroke: (thickness: 3.4pt, paint: blu), z: 0)
        // inner SIBC spectrum under imaginary gauge transform (dotted boundary)
        circle((0, 0), radius: (2.05, 3.15), fill: dgray,
          stroke: (thickness: 1.4pt, paint: black, dash: "dotted"), z: 1)
        // OBC spectrum (red line along the major axis)
        line((0, -2.75), (0, 2.75), stroke: (thickness: 3.4pt, paint: red), z: 2)
      })

      // labels with leader lines
      content((0.0, 7.9), anchor: "west", text(size: 10pt)[$sigma_("SIBC")(V_r^(-1) H V_r)$])
      line((3.6, 7.75), (5.05, 7.15), stroke: 0.9pt)
      content((0.0, 6.0), anchor: "west", text(size: 10pt)[$sigma_("SIBC")(H)$])
      line((1.75, 5.9), (3.45, 5.35), stroke: 0.9pt)
      content((0.0, 4.3), anchor: "west", text(size: 10pt)[$sigma_("PBC")(H)$])
      line((1.5, 4.2), (2.75, 3.95), stroke: 0.9pt)
      content((0.0, 2.6), anchor: "west", text(size: 10pt)[$sigma_("OBC")(H)$])
      line((1.75, 2.55), (5.05, 3.35), stroke: 0.9pt)
    })),
    scale(75%, cetz.canvas(length: 0.6cm, {
      import cetz.draw: *
      let gray = rgb("#999999")
      let dgray = rgb("#808080")

      content((-0.6, 13.9), anchor: "west", text(size: 14pt)[(b)])
      // left box: skin effect
      rect((0, 0), (10, 13), stroke: (thickness: 1.3pt, paint: black), fill: none)
      content((5, 12.15), text(size: 10pt)[Skin effect])
      // four-site chain
      for i in range(4) {
        circle((2.2 + i * 1.8, 9.6), radius: 0.55, stroke: (thickness: 1.4pt, paint: black), fill: none)
      }
      // t+g hop arrow (top, from site 2 to site 3)
      bezier((4.35, 10.05), (4.7, 10.8), (5.3, 10.8), (5.45, 10.1),
        stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
      content((4.9, 11.15), text(size: 8pt, $t + g$))
      // t-g hop arrow (bottom, from site 3 to site 2)
      bezier((5.45, 9.15), (5.3, 8.4), (4.7, 8.4), (4.35, 9.05),
        stroke: (thickness: 1.1pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
      content((4.9, 7.8), text(size: 8pt, $t - g$))
      content((5, 6.6), text(fill: red, size: 9.5pt)[Skin mode/])
      content((5, 5.65), text(fill: gray, size: 9.5pt)[Pseudospectrum])
      // tilted nested ellipses with red x marks
      group({
        translate((5.3, 2.75))
        rotate(-22deg)
        circle((0, 0), radius: (1.9, 2.65), fill: rgb("#D9D9D9"), stroke: (thickness: 1pt, paint: black), z: 0)
        circle((0, 0), radius: (1.3, 2.0), fill: dgray, stroke: (thickness: 0.8pt, paint: black), z: 1)
        for i in range(8) {
          let t = -1.55 + i * 0.44
          content((t * 0.16, t * 1.1), text(fill: rgb("#E00000"), size: 9pt, weight: "bold")[$times$], z: 2)
        }
      })
      content((1.6, 5.9), anchor: "east", text(size: 8pt)[$⋯, epsilon'$])
      content((3.4, 5.1), anchor: "east", text(size: 8pt)[$epsilon$])
      content((5, -1.5), text(size: 10.5pt)[Non-Hermitian \ Topology])

      // thick double arrow between boxes
      line((11.3, 6.5), (13.7, 6.5), stroke: (thickness: 4.5pt, paint: black),
        mark: (start: (symbol: "stealth", length: 0.5cm, width: 0.45cm), end: (symbol: "stealth", length: 0.5cm, width: 0.45cm)))

      // right box: topological insulator
      rect((14, 0), (24, 13), stroke: (thickness: 1.3pt, paint: black), fill: none)
      content((19, 12.15), text(size: 10pt)[Topological insulator])
      line((15.5, 10.0), (21.5, 10.0), stroke: (thickness: 1.2pt, paint: black), z: -1)
      for i in range(4) {
        circle((16.3 + i * 1.5, 10.0), radius: 0.8, stroke: (thickness: 1.3pt, paint: black), fill: none)
        circle((16.3 + i * 1.5 - 0.3, 10.0), radius: 0.2, fill: black, stroke: none)
        circle((16.3 + i * 1.5 + 0.3, 10.0), radius: 0.2, fill: black, stroke: none)
      }
      content((19, 7.3), text(fill: red, size: 9.5pt)[Exact zero mode/])
      content((19, 6.35), text(fill: gray, size: 9.5pt)[Quasi zero mode])
      // bands with mid-gap modes
      rect((15.3, 4.35), (18.0, 4.85), fill: black, stroke: none)
      rect((20.0, 4.35), (22.7, 4.85), fill: black, stroke: none)
      circle((19.0, 4.72), radius: 0.17, fill: red, stroke: none)
      circle((19.0, 4.32), radius: 0.17, fill: red, stroke: none)
      rect((15.3, 1.85), (18.0, 2.35), fill: black, stroke: none)
      rect((20.0, 1.85), (22.7, 2.35), fill: black, stroke: none)
      circle((18.78, 2.1), radius: 0.17, fill: gray, stroke: none)
      circle((19.22, 2.1), radius: 0.17, fill: gray, stroke: none)
      line((18.75, 1.45), (19.25, 1.45), stroke: 0.8pt, mark: (start: (symbol: "stealth", length: 0.11, width: 0.11), end: (symbol: "stealth", length: 0.11, width: 0.11)))
      content((19.0, 0.75), text(size: 8pt)[$cal(O)(epsilon)$])
      content((19, -1.5), text(size: 10.5pt)[Hermitian \ Topology])
    })),
  ),
  caption: [
    (a) Schematic picture of the PBC, SIBC, and OBC spectra in the presence of non-Hermitian skin effect. The disk with the dotted boundary is the SIBC spectrum under an imaginary gauge transformation $V_r$. (b) Relationship between non-Hermitian topology and Hermitian topology.
  ],
) <fig2>

== The bulk-boundary correspondence <BBC-and-line-gap>

The above consideration also clarifies how the conventional bulk-boundary correspondence breaks in the presence of the non-Hermitian skin effect. To see this, let us consider a non-Hermitian lattice system with the bulk band spectrum forming spectral islands in the complex energy plane. When the spectral islands are separated from each other, we say that the system has #emph[line gaps] @KSUS-19 (see @classification), and each island may support a topological number @Esaki-11 @Shen-18 @KSUS-19 @lein2020choosing. Then, the bulk-boundary correspondence holds if one considers spectral islands in the OBC: If a spectral island in the OBC has a non-zero topological number, we have a corresponding topological boundary state.

In the presence of the non-Hermitian skin effect, the spectral islands in the OBC are different from those in the PBC. Therefore, the conventional bulk-boundary correspondence, which relates a topological number in the PBC to a boundary state, does not always hold. However, the breakdown has limitations. By the argument in the previous subsection, the bulk OBC spectrum is always inside the PBC one, and thus each bulk spectral island in the OBC is also inside a spectral island in the PBC. Thus, if the system has a line gap in the PBC, it also has a line gap in the OBC. Since spectral islands in the PBC can be smoothly deformed into those in the OBC without closing line gaps, this means that the topological numbers of the spectral islands coincide between the PBC and the OBC under the same situation. Therefore, once one has a well-defined topological number in the PBC, which is always true in the situation above, the corresponding topological number in the OBC takes the same value, and thus the conventional bulk-boundary correspondence holds. Note that the PBC islands should merge before the gap closing (namely, a collision of spectral islands) in the OBC, and thus the topological number in the PBC becomes ill-defined near a topological phase transition in the OBC. The breakdown of the conventional bulk-boundary correspondence occurs in this situation.

== Correspondence between skin mode and topological exact zero mode <skin-zero-mode>

Thus far, we have related the conventional skin effect with a non-trivial winding number of the PBC spectrum. Actually, the same winding number characterizes the topological boundary zero modes of a Hermitian topological insulator. The key idea is to introduce the doubled Hermitian Hamiltonian, which is also a tool for topological classifications of Floquet Hamiltonians @roy-floquet-classification and non-Hermitian Hamiltonians without boundaries @Gong-18: @KSUS-19:

$
  tilde(H)_E := mat(delim: "(", 0, H - E; H^dagger - E^*, 0)
$<doubleham>

where $E in bb(C)$ is a reference point. Owing to the artificial doubling process, an additional chiral symmetry is imposed on the doubled Hermitian Hamiltonian as a constraint:

$
  Gamma tilde(H)_E Gamma^(-1) = - tilde(H)_E, quad "with" quad Gamma = mat(delim: "(", 1, 0; 0, -1)
$

In the Altland-Zirnbauer classification @Altland, the symmetry class with one chiral symmetry is called class AIII, and the topological classification of insulators (gapped#footnote[The gapped nature of $tilde(H)_E$ is defined by $det tilde(H)_E (k) ≠ 0$, or equivalently, $det [H(k) - E] ≠ 0$.] phases) is given by $bb(Z)$. Actually, the integer topological invariant is nothing but the winding number of the PBC spectral curve of $H$ around the reference point $E$, given in @windingnumber. Thus, the same winding number characterizes both a class-AIII topological insulator and a conventional skin effect. In other words, the conventional skin effect gives one physical interpretation of a non-Hermitian topological classification @Gong-18 @Kawabata-19 in a special case (see @classification for details). Remarkably, in this correspondence, one can relate the Hatano-Nelson model, which is the simplest model of the conventional skin effect, to the Su-Schrieffer-Heeger model @SSH-79, which is the simplest model of one-dimensional class-AIII topological insulators.

Moreover, the skin mode is not unrelated to the bulk-boundary correspondence. To see this, we begin with the SIBC. If $E in sigma_("SIBC")(H) ∖ sigma_("PBC")(H)$ and $W(E) < 0$ for the PBC curve, one can find a boundary-localized right eigenstate $|E⟩$ of $H$. By using $|E⟩$, one can construct a boundary zero mode of $tilde(H)_E$ with negative chirality: \ |E

$
  tilde(H)_E mat(delim: "(", 0; |E⟩) = 0, quad Gamma mat(delim: "(", 0; |E⟩) = - mat(delim: "(", 0; |E⟩).
$ <right-zero-mode>

This is nothing but a topological boundary zero mode of a class-AIII topological insulator. Similarly, for a positive winding number, one can assign a topological boundary zero mode with positive chirality

$
  tilde(H)_E mat(delim: "(", |E⟩⟩; 0) = 0, quad Gamma mat(delim: "(", |E⟩⟩; 0) = mat(delim: "(", |E⟩⟩; 0),
$<left-zero-mode>

where $|dot.op⟩⟩$ denotes the Hermitian conjugate of the left eigenstate [see @rightleft].

Basically, the same thing holds for the non-Hermitian skin modes under the OBC, but there are several significant differences from the SIBC case. One thing is that both the right and left eigenstates localized at the opposite boundaries can be defined at the same time, owing to the additional boundary. Correspondingly, the topological zero modes with opposite chirality appear at the opposite boundary of the doubled Hermitian system. The more crucial difference is a subtle mismatch in the correspondence. While $tilde(H)_E$ corresponds to a topological insulator for any $E$ in a two-dimensional region on the complex plane $sigma_("SIBC")(H) ∖ sigma_("PBC")(H)$, $sigma_("OBC")(H)$ is given by a one-dimensional complex curve. Under the OBC with finite $L$, two topological boundary modes with opposite chirality, localized at the opposite sides, usually have a finite overlap, and the true eigenstates are their superpositions with small but finite energy that becomes zero only for $L -> oo$. Such topological modes are called quasi-zero modes, and the correspondence between a Hermitian eigenstate and a non-Hermitian eigenstate does not exactly hold. In contrast, the topological boundary modes with exact zero energy have correspondence with the skin modes [@fig2(b)], as in the case of the SIBC. This is the origin of the subtle mismatch mentioned above.

== Correspondence between pseudospectrum and topological quasi zero mode <pseudospectrum>

The remaining question is what the non-Hermitian counterpart of the topological quasi-zero energy of $tilde(H)_E$ in the correspondence is. The answer is the $epsilon$-pseudospectrum $sigma_epsilon(H)$@Okuma-Sato-20 [@fig2(b)], which is defined by the set of spectra of perturbed matrices#footnote[In numerical calculations, another equivalent definition @Trefethen $sigma_epsilon(H) = ( z in bb(C) | parallel (H - z)^(-1) parallel > epsilon^(-1) )$ is useful.] $H + eta$ with $parallel eta parallel < epsilon$, where $parallel dot.op parallel$ is the matrix 2-norm or the largest singular value @Trefethen. While the $epsilon$-pseudospectrum of a normal matrix ($[H, H^dagger] = 0$) such as a Hermitian matrix is just given by the $epsilon$-neighborhood of the exact spectrum, that of a non-normal matrix ($[H, H^dagger] ≠ 0$) can be much larger than the $epsilon$-neighborhood. In the present case, the following holds#footnote[The opposite limit corresponds to the OBC spectrum: $lim_(L -> oo) lim_(epsilon -> 0) sigma_epsilon(H_"OBC"^(L)) = sigma_("OBC")(H)$.] @Trefethen @Gong-18 @Okuma-Sato-20:

$
  lim_(epsilon -> 0) lim_(L -> oo) sigma_epsilon(H_"OBC"^(L)) = sigma_("SIBC")(H),
$

where $H_"OBC"^(L)$ is the size-$L$ OBC Hamiltonian. Roughly speaking, the SIBC eigenstates approximate the states that correspond to the pseudospectrum, mentioned as #emph[quasieigenstate]#footnote[Related to this terminology, one can also describe the $epsilon$-pseudospectrum by another equivalent definition $sigma_epsilon(H) = ( z in bb(C) | parallel (z - H) bold(v) parallel < epsilon " for some unit vector " bold(v) )$, where $parallel dot.op parallel$ is the vector norm.] in @Gong-18. Reference @Okuma-Sato-20 showed the correspondence between topological quasi-zero modes with $cal(O)(epsilon)$ energy and the $epsilon$-pseudospectrum. Thus, the pseudospectrum with infinitesimally small $epsilon$ compensates for the subtle mismatch between the two-dimensional region with non-trivial topology and the OBC spectral curve in the complex plane. Note that the origin of the drastic difference between the OBC spectrum and pseudospectrum is the #emph[nonlocal] perturbations that connect the ends of the open chain. In other words, the OBC spectrum is unstable against such nonlocal perturbations#footnote[Related to this mathematics, it is known that a numerical diagonalization of the non-normal matrices is sensitive to a rounding error because it can behave as a nonlocal perturbation @Trefethen.], while it is robust against local perturbations. By using the correspondence between Hermitian and non-Hermitian topology, one can relate this behavior to the following fact: The topological zero modes of a topological insulator are easily gapped out by connecting edges, while they are robust against the symmetry-preserving local perturbations.

== The Bauer-Fike theorem and the skin effect <bauer-fike>

For a nonzero $epsilon$ and a finite $L$, we have a useful bound for perturbations called the Bauer-Fike theorem @Bauer-Fike @bauer-fike. When $H$ is diagonalizable, the theorem implies @Trefethen.

$
  sigma_epsilon(H) subset sigma(H) + Delta_(epsilon kappa(V)),
$<eq:Bauer-Fike>

with $Delta_delta = ( z in bb(C): |z| < delta )$ and $kappa(V) = parallel V parallel dot.op parallel V^(-1) parallel >= 1$, where $V$ is a matrix diagonalizing $H$, $V^(-1) H V = "diag"(E_1, E_2, dots.)$. The condition number $kappa(V)$ measures the non-normality of $H$ and gives a bound for the perturbed spectrum: If $H$ is normal so $V$ is unitary, it takes the minimal value $kappa(V) = 1$, so the perturbed spectrum stays in the $epsilon$-neighborhood of the exact spectrum. On the other hand, if $H$ is non-normal, it allows a larger perturbation of the spectrum.

With biorthogonal right and left eigenstates $|E_n⟩$, $|E_n⟩⟩$ of $H$, we have $V = (|E_1⟩, |E_2⟩, dots.h)$ and $V^(-1) = (⟨⟨E_1 |, ⟨⟨E_2 |, dots.h)^t$. Because the matrix 2-norm satisfies $parallel A parallel >= sqrt(tr (A^dagger A))\/sqrt(L)$ for an $L times L$ matrix $A$@Golub-Van_Loan, $kappa(V)$ has a lower bound as

$
  kappa(V) >= sqrt(sum_i ⟨E_i | E_i⟩ sum_j ⟪ E_i | E_i⟩⟩) \/ L = sqrt(sum_i ⟨E_i | E_i⟩ sum_j ⟪ E_i | E_i⟩⟩) \/ sum_k ⟪ E_k | E_k⟩.
$

Therefore, $kappa(V)$ can be huge if the skin effect occurs, where the right eigenstate $|E_i⟩$ and left one $|E_i⟩⟩$ are localized on opposite boundaries. The extreme sensitivity of the spectrum against perturbations, which is suggested by the bound $epsilon kappa(V)$ in @eq:Bauer-Fike, opens a possible application of the skin effect to highly accurate sensors @Budich-20.

For a larger $epsilon$, a variant of the Bauer-Fike theorem @Trefethen

$
  sigma_epsilon(H) subset.eq sigma(H) + Delta_(epsilon + "dep"(H))
$

with $"dep"(H) = sqrt(tr (H^dagger H) - sum_i |E_i|^2)$ gives a more severe bound for perturbations. The quantity $"dep"(H)$ is called departure of normality @Henrici, and also measures the non-normality of $H$. The skin effect results in a large difference between $"dep"(H)$ in the OBC and that in the PBC, and thus the difference also characterizes the skin effect @Nakai-Okuma-Sato.

We also note that the pseudospectrum plays an important role in non-Hermitian dynamics. This point will be discussed in @dynamical.

= Symmetry-protected skin effects under time-reversal symmetry <trs-skin>

So far we have shown that the PBC curve with a non-trivial winding number indicates the non-Hermitian skin effect. Then a natural question arises: #emph[Are all the non-Hermitian skin effects characterized by non-zero winding numbers?] The answer is NO.

In modern physics, the quantum Hall effect is regarded as an example of broader concepts: topological insulator @Kane-review @Zhang-review or symmetry-protected topological phase @senthil2015symmetry. Similarly, the conventional skin effect can be regarded as an example of a broader concept: symmetry-protected skin effects in general dimensions. In this section, we consider one- and two-dimensional skin effects protected by a non-Hermitian time-reversal symmetry. Instead of the $bb(Z)$ winding number, they are characterized by a $bb(Z)_2$ topological invariant.

== Time-reversal symmetry in non-Hermitian systems <Def-of-TRS>

For non-Hermitian Hamiltonian matrices, there are more types of symmetries than for Hermitian ones @Bernard-LeClair-02 @KSUS-19. Among them, we focus on extensions of the time-reversal symmetry (TRS). For a Hermitian Hamiltonian $H$, the TRS is defined as an antiunitary symmetry:

$
  T H^* T^(-1) = H
$<conjugateTRS>

where $T$ is taken as a unitary matrix. Corresponding to the integer/half-integer spin of a particle, $TT^* = ± 1$ are assigned. One natural extension to non-Hermitian cases is the complex-conjugate-type TRS defined by the same equation @conjugateTRS. Since the transpose is not equivalent to the complex conjugation under non-Hermiticity, one can also consider another extension, namely, the transpose-type TRS @Bernard-LeClair-02: @KSUS-19:

$
  T H^T T^(-1) = H.
$<transposeTRS>

Depending on the situation, both TRSs may be physically relevant. For example, the transpose-type TRS appears as a natural TRS of non-Hermitian Hamiltonians defined by the one-particle Green's function @Yoshida-dagger-symmetry or that of the quadratic Lindbladian @Lieu-19.

==$bb(Z)_2$ skin effect in one dimension <z2-1d>

In the previous section, we have introduced the doubled Hermitian Hamiltonian $tilde(H)_E$[see @doubleham] to show the correspondence between a conventional skin effect and a class-AIII topological insulator. In the presence of the transpose-type TRS, one can also define $tilde(H)_E$ for arbitrary $E in bb(C)$ because the addition of terms proportional to the identity matrix does not break the relation @transposeTRS. For the cases with $TT^* = -1$, $tilde(H)_E$ has a Hermitian TRS, an artificial chiral symmetry (CS), and their combination, namely, the particle-hole symmetry (PHS):

$
"TRS": tilde(T) tilde(H)_E^* tilde(T)^(-1) = tilde(H)_E, quad tilde(T) tilde(T)^* = -1, quad tilde(T) := mat(delim: "(", 0, T; T, 0) \
"PHS": tilde(C) tilde(H)_E^* tilde(C)^(-1) = - tilde(H)_E, quad tilde(C) tilde(C)^* = 1, quad tilde(C) := mat(delim: "(", 0, -T; T, 0) \
"CS": tilde(Gamma) tilde(H)_E tilde(Gamma)^(-1) = - tilde(H)_E, quad tilde(Gamma)^2 = 1, quad tilde(Gamma) := mat(delim: "(", 1, 0; 0, -1).
$<trsdouble>

In the Altland-Zirnbauer classification @Altland, the set of these symmetries corresponds to the symmetry class DIII. In one dimension, a class-DIII gapped Hermitian Hamiltonian (or the original non-Hermitian Hamiltonian) is classified by a $bb(Z)_2$ topological invariant $nu(E) in (0, 1)$ @KSUS-19.

$
  (-1)^(nu(E)) := "sgn" { frac("Pf"[ (H(pi) - E) T ], "Pf"[ (H(0) - E) T ]) times exp[-1\/2 integral_(k=0)^(k=pi) d log det [ (H(k) - E) T ]] },
$<z2inv>

where $H(k)$ is again the Bloch Hamiltonian for the non-Hermitian Hamiltonian. Under the OBC, the non-trivial phase ($nu = 1$) describes a topological superconductor with a Kramers doublet of Majorana fermions @teo-kane. If the energy of the OBC boundary modes are exactly zero, one can relate the Majorana boundary states to eigenstates of $H$ as in the case of the conventional skin effect [@fig3]:

$
  mat(delim: "(", 0; |E⟩), mat(delim: "(", T |E⟩^*; 0), mat(delim: "(", 0; T |E⟩⟩^*), mat(delim: "(", |E⟩⟩; 0).
$<exactzeromodes>

The former/latter two modes form a Majorana doublet. Since the former and the latter pairs are localized at the opposite side, $|E⟩$ ($T |E⟩⟩^*$) and $|E⟩⟩$ ($T |E⟩^*$) are the right and left eigenstates of $H$ localized at the different side. Thus, the right eigenstates $|E⟩$ and $T |E⟩⟩^*$ satisfy the definition of skin modes and are localized at the different sides. In terms of the transpose-type TRS, they are in the relationship of the non-Hermitian Kramers pair @Sato-11 @KSUS-19. To emphasize the difference from the conventional skin effect, we call this localization phenomenon the $bb(Z)_2$ skin effect. Note that the conventional winding number under the PBC cannot have a non-trivial winding number in the presence of the transpose-type TRS with $TT^* = -1$ because of the Kramers degeneracy.

In the following, we construct an explicit model of the $bb(Z)_2$ skin effect. Let us mimic the first example of the $bb(Z)_2$ topological insulator protected by the TRS, called the Kane-Mele model @Kane-Mele-05-QSH. This model was constructed by a stack of quantum anomalous Hall insulators with opposite Chern numbers. In the absence of spin-orbit interactions, the Kane-Mele model is block diagonalized into spin sectors and is characterized by the integer spin Chern number. In the presence of the spin-orbit interaction that couples the spin sectors, the non-trivial phase is characterized by a $bb(Z)_2$ topological invariant instead of the ill-defined spin Chern number. Similarly, we begin with the stack of the Hatano-Nelson model @HNmodel with opposite winding numbers $W = ± 1$ @Okuma-19:

$
  H_bb(Z)(k) = mat(delim: "(", H_("HN")(k), 0; 0, H_("HN")(-k)) = 2 t cos k sigma_0 + 2 i g sin k sigma_z,
$<spinhatano>

where $sigma$'s represent the Pauli matrix of spin. Instead of the full Hamiltonian, we have specified the model by the Bloch Hamiltonian. In this basis, the transpose-type TRS with $TT^* = -1$ for a Bloch Hamiltonian $H(k)$ is given by

$
  T H^T (-k) T^(-1) = H(k)
$<sytrs>

where $T = i sigma_y$. Thus, $H_bb(Z)(k)$ hosts the transpose-type TRS, and the total winding number @windingnumber cannot be non-trivial. However, the block Hamiltonians in the spin sectors are given by the Hatano-Nelson models with opposite asymmetric hopping terms, which show the skin effects characterized by the opposite winding numbers for $t g ≠ 0$. This is an example of the skin effect protected by transpose-type symmetry. Instead of the total winding number, the integer "spin" winding number characterizes this skin effect.

Next, we add a spin-orbit interaction $Delta >= 0$ that connects the spin sectors @OKSS-20:

$
  H_bb(Z_2)(k) = mat(delim: "(", H_("HN")(k), 2 Delta sin k; 2 Delta sin k, H_("HN")(-k)) = 2 t cos k + 2 Delta (sin k) sigma_x + 2 i g (sin k) sigma_z.
$

Since the spin-rotational symmetry is completely broken, the winding number in each spin sector cannot be defined for non-zero $Delta$. Even for this case, we can still define the $bb(Z)_2$ invariant @z2inv due to the presence of TRS @sytrs. The PBC spectrum is given by two bands $E_±(k) = 2 t cos k ± 2 i sqrt(g^2 - Delta^2) sin k$, both of which describe an ellipse in the complex plane for $|g| > Delta$ and $t ≠ 0$@OKSS-20. Correspondingly, the $bb(Z)_2$ invariant @z2inv is not trivial for this parameter region, which should lead to the non-Hermitian skin effect. The numerical diagonalization for a finite size ($L = 100$) shows the presence of the skin effect with Kramers pairs localized at the opposite sides [@fig3]. This is an example of symmetry-protected skin effects characterized by a $bb(Z)_2$ topological invariant @z2inv.

We here give several remarks about the symmetry-protected skin effects. First, the symmetry-protected nature appears as an instability of the skin effect against symmetry-breaking perturbations [$delta h ≠ 0$ in @fig3]. In the infinite-volume limit, this instability is understood by the failure of the standard non-Bloch band theory under some symmetry protection @Okuma-19. In the presence of the symmetry that block-diagonalizes $H(k)$ such as @spinhatano, the corresponding OBC spectrum is determined not by the non-Bloch band theory for the total Hamiltonian but by that for each block. Under symmetry-breaking terms that connect the blocks, however, the OBC spectrum is determined by the non-Bloch band theory for the total Hamiltonian. Remarkably, the latter spectrum for an infinitesimally small perturbation can be different from the former spectrum. For example, the OBC spectrum of @spinhatano under an infinitesimally small transverse magnetic field becomes identical to the PBC one @Okuma-19. In the case of the transpose-type TRS without spin-rotational symmetry, a similar discussion can be applied by introducing a modified non-Bloch band theory with Kramers doublet @KOS-20. In the language of the doubled Hermitian Hamiltonian, this phenomenon is understood by the fact that the exact zero modes acquire a finite gap under a symmetry-breaking term, which destroys the correspondence between the skin modes and the exact zero modes mentioned above.#footnote[In a finite system, the threshold of the perturbation strength for the instability is exponentially small with respect to the system size. In terms of the correspondence between the Hermitian and non-Hermitian topology, this threshold corresponds to the amount of perturbation that changes the energies of boundary modes significantly.]

Second, the $bb(Z)_2$ nature is checked by a stack of two copies of the system with the skin effect whose topological number is unity. The skin effect in such a stack is fragile even against symmetry-preserving terms [$nu = 0$ in @fig3]. This behavior can be understood by the fact that a skin mode of one Kramers doublet localized at the left side can be mixed with a skin mode of the other doublet localized at the right side.

These are the basic properties of symmetry-protected skin effects in one spatial dimension. One can apply a similar consideration based on the doubled Hermitian Hamiltonian to higher dimensions. However, more careful discussion about the boundary condition is needed to characterize a higher-dimensional non-Hermitian skin effect.

// [figvision] imgs/fig3.png
// Panel 1D left is a schematic labeled 1D showing a one-dimensional chain with blue bulk spectral weight filling
// most of the horizontal extent under a black curved boundary and red triangular regions at both ends. The text
// Majorana doublet sits above the center. The red edge regions indicate Majorana modes localized at the two
// boundaries of a one-dimensional topological superconductor. Panel 2D left is a schematic labeled 2D depicting
// a tilted gray two-dimensional plane with inner blue and red boundary lines. A vertical brown line passes
// through central blue and red dots and is labeled pi flux. Red arrows circulate along the outer rim labeled
// Helical Majorana, indicating helical edge modes. Below the panel reads Z2 topological superconductor. Panel 1D
// right contains two plots under the label 1D. The left plot shows Re E versus Im E with Re E from -3 to 3 and
// Im E from -1.0 to 1.0. A red vertical line segment lies at Im E = 0 between Re E = -2 and 2, encircled by an
// elliptical loop. Annotations identify OBC in red, PBC in blue, nu equals 0 in green, and delta h not equal 0.
// The right plot shows Weight versus Site from 0 to 100 with weight from 0.00 to 0.12. Red dots are large near
// site 0 and decay quickly, while blue dots are large near site 100, showing skin localization at opposite
// edges. Panel 2D right contains four parts under the label 2D. The left plot, titled Without pi flux, shows Re
// E versus Im E from -1 to 1 and -0.5 to 0.5. Green dots labeled y-OBC form nested loops, red dots labeled
// full-OBC occupy inner areas, and green dotted vertical lines mark kx equals pi and kx equals 0; a legend lists
// PBC in blue, y-OBC in green, and full-OBC in red. The middle plot, titled With pi flux, shows red dots forming
// a single circular loop in the same complex energy plane. To the right are two square heatmaps for E equals
// 0.12 plus 0.49 i. The top heatmap uses a color scale from 0 to 0.15 and displays a bright localized spot,
// while the bottom uses a scale from 0 to 0.02 and remains nearly uniform dark blue, illustrating the Z2 skin
// effect.
#figure(placement: top, 
  image("imgs/fig3.png", width: 90%),
  caption: [
    Relationship between $bb(Z)_2$ topological superconductor and $bb(Z)_2$ skin effects in one and two dimensions. The spectra and weight functions are adopted from @OKSS-20.
  ],
) <fig3>

==$bb(Z)_2$ skin effect in two dimensions <z2-2d>

We consider two-dimensional non-Hermitian Hamiltonians with the transpose-type TRS with $TT^* = -1$. Again, a doubled Hermitian Hamiltonian $tilde(H)_E$ describes class-DIII superconductors and is classified by a $bb(Z)_2$ invariant under the PBC @KSUS-19:

 $ (-1)^(nu(E)) := ∏_(X = "I,II") "sgn" ( frac("Pf"[ (H(bold(k)_(X+)) - E) T ], "Pf"[ (H(bold(k)_(X-)) - E) T ]) times exp[-1\/2 integral_(bold(k) = bold(k)_(X-))^(bold(k) = bold(k)_(X+)) d log det [ (H(bold(k)) - E) T ]] ), $<2dz2inv>

where $bold(k)$ is a two-dimensional momentum, and $(bold(k)_(I+), bold(k)_(I-))$ and $(bold(k)_(II+), bold(k)_(II-))$ are two pairs of time-reversal-invariant momenta. For the non-trivial phase $nu(E) = 1$, topological boundary modes are given by helical Majorana edge modes @teo-kane. If there exist exact zero modes, they are given by the same expression as @exactzeromodes. Unlike one dimension, however, the exact zero modes cannot be found under the full OBC, i.e., the OBC in both the $x$ and $y$ directions. This is because a topological gapless mode at the closed boundary of a higher-dimensional topological insulator/superconductor effectively feels the curvature of the boundary, and the "zero" modes inevitably have finite energy of the order of $1\/L$@Imura-12 @Parente-11 @DLee-09. Correspondingly, the $bb(Z)_2$ skin effect does not occur for this boundary condition. To observe a two-dimensional $bb(Z)_2$ skin effect, one should choose boundary conditions that allow the exact topological boundary zero modes of $tilde(H)_E$. At least two boundary conditions for this purpose are known for higher-dimensional topological insulators/superconductors: (i) the OBC in one direction and the PBC in the other directions, and (ii) the full OBC with topological defects @teo-kane.

In the following, we describe the properties of the two-dimensional $bb(Z)_2$ skin effect by using the massless Dirac Hamiltonian coupled to valley-dependent dissipation characterized by $Gamma in bb(R)$ @OKSS-20:

 $ H(bold(k)) = (sin k_x sigma_x + sin k_y sigma_y) + i Gamma (cos k_x + cos k_y). $<2dskineffect>

For non-zero $Gamma$, the set $( E in bb(C) | nu(E) = 1 )$ occupies a two-dimensional region of the complex plane. The complex spectrum of this system is shown in @fig3 for various boundary conditions @OKSS-20. In case (i), the OBC is imposed in the $y$ direction. In case (ii), the topological defect is given by a $pi$ flux (or a half flux quantum) at the central unit cell. In contrast to the full PBC and full OBC, there exist skin modes for both cases. Remarkably, only $cal(O)(L)$ modes of the total $cal(O)(L^2)$ modes show the $bb(Z)_2$ skin effect in which the spectrum has no winding, and they are separated from the other modes surrounding them. In case (i), $cal(O)(L)$ skin modes are also interpreted as the one-dimensional $bb(Z)_2$ skin modes of a one-dimensional Hamiltonian $H(k_x)$ at the time-reversal-symmetric points $k_x = 0, pi$, where $H(k_x)$ is the Fourier transform of $H$ in the $x$ direction. The skin modes are localized at the boundaries in the $y$ direction. In $D$-dimensional topological insulators/superconductors under the boundary condition (i), only $cal(O)(1)$ modes of the total $cal(O)(L^(D-1))$ modes of the surface Dirac Hamiltonian correspond to the exact zero modes. Thus, the $D$-dimensional skin effect has only $cal(O)(L)$ skin modes#footnote[The Hamiltonian @2dskineffect with $Gamma = 1$ has $cal(O)(L)$-fold algebraic degeneracy at $E = ± i$, which are exceptional points (see @EP). Three-dimensional cases were investigated in @Terrier-Kunst-20.]. In case (ii), $cal(O)(L)$ skin modes are localized at the boundary and the topological defect. In contrast to the other skin effects, this case shows a non-Hermitian localization in the radial direction [@fig3]. Note that this two-dimensional localization purely originates from the non-Hermiticity, while the higher-order skin effect in @hose is reduced to the combination of Hermitian and non-Hermitian localizations.

= Physical interpretation of non-Hermitian topological classification <classification>

We here review several topics related to non-Hermitian topological classification. In particular, the anomaly interpretation provides another insight into symmetry-protected skin effects, in addition to the topological aspects discussed above.

== Review of non-Hermitian topological classification <nh-classification>

In Hermitian physics, a standard classification of non-interacting topological insulators/superconductors is given by the K-theoretical classification of a momentum-resolved Hamiltonian matrix $H(bold(k))$@Schnyder-08 @Kitaev-09 @Ryu-10 @Schnyder-Ryu-review, where $bold(k)$ is a momentum on a sphere or a torus. In this field, the ten-fold Altland-Zirnbauer class @Altland, in which each class is specified by the combination of TRS, PHS, and CS, is regarded as the most fundamental symmetry class [for example, see @trsdouble]. The gapped nature of insulators/superconductors is captured by the condition $det H(bold(k)) ≠ 0$, which means the absence of zero energy in the bulk spectrum. Gong et al. adopted the same condition for a non-Hermitian $H(bold(k))$ as the definition of a non-Hermitian gapped phase @Gong-18. This type of complex energy gap was named #emph[point gap] in @KSUS-19 [@fig4(a)]. They showed that the topological classification of point-gapped phases is given by the K-theoretical classification of the corresponding doubled Hermitian Hamiltonian

$
  tilde(H)(bold(k)) := mat(delim: "(", 0, H(bold(k)); H^dagger(bold(k)), 0)
$

by noticing the equivalence between $det H(bold(k)) ≠ 0$ and $det tilde(H)(bold(k)) ≠ 0$. After this study, @KSUS-19 @ZL-19 applied this classification scheme to the 38-fold Bernard-LeClair class, which was originally introduced to describe non-Hermitian random matrices @Bernard-LeClair-02. Reference @KSUS-19 proposed another non-Hermitian gapped structure named the real/imaginary #emph[line-gapped] phase [@fig4(a)]. In this scheme, the gapped phase is defined as a spectral structure whose real/imaginary parts are nonzero. Furthermore, the concept of the line gap has been generalized to situations where several spectral islands exist in the complex energy plane @lein2020choosing.

Next, we consider physical interpretations of the non-Hermitian gapped phases. In the case of the Hermitian classification, the non-trivial phase of the classification corresponds to a topological insulator/superconductor, in which the bulk non-trivial topology indicates the presence of topological gapless boundary modes. Actually, the real/imaginary line-gapped phases can be adiabatically connected to Hermitian/anti-Hermitian gapped Hamiltonians without breaking the fundamental symmetries and closing the line gap @Esaki-11 @KSUS-19 @ashida-gong-20. Thus, the non-trivial topology in a line-gapped phase is essentially the same as that in a Hermitian gapped phase and indicates the bulk-boundary correspondence with a certain modification (see Sects. @breakdown-of-bbc and @BBC-and-line-gap). In contrast, it is not easy to say something about the point-gapped phases because the non-trivial topology indicates the bulk-boundary correspondence of the doubled Hermitian Hamiltonian $tilde(H)$, not of the original Hamiltonian $H$. To the best of the authors' knowledge, there is no unified physical interpretation for the point-gapped phases#footnote[There are even cases where the point-gap topological invariant is reminiscent of a line-gap topological invariant, whose origin is essentially Hermitian topology @OKSS-20.]. In the following, we give several interpretations for limited cases.

== Classification of non-Hermitian skin effects <skin-classification>

The symmetry-protected skin effects give one physical interpretation of the point-gap topological classification for classes without symmetry or with only transpose-type TRS ($TT^* = ± 1$) @OKSS-20 @Okuma-Sato-21. In these three classes, also called class A, AI†, and AII† @KSUS-19, the addition of an arbitrary reference energy $E in bb(C)$ to $H$ does not break the given symmetry, allowing us to construct the symmetry-protected skin effects discussed above @Okuma-Sato-21. The classification of skin effects for these three classes is highlighted in red in @tab1. The above discussion does not mean that symmetry-protected skin effects occur only in these three classes, because the topological invariants of the three classes can be non-zero in other classes.

== Non-Hermitian topology and quantum anomaly <quantum-anomaly>

=== Anomaly interpretation for AZ† symmetry <anomaly-az-dagger>

As we noted in @Def-of-TRS, there are two types of non-Hermitian TRS, i.e., complex-conjugate-type and transpose-type TRS. Similarly, one can define complex-conjugate-type and transpose-type PHS. The ten-fold Altland-Zirnbauer (AZ) class is defined by the combination of complex-conjugate-type TRS and transpose-type PHS, while the ten-fold AZ† class#footnote[In this paper, we call the combination of the two-fold complex AZ class @KSUS-19 and the eight-fold real AZ† class @KSUS-19 the ten-fold AZ† class.] is defined by the combination of transpose-type TRS and complex-conjugate-type PHS.

As far as the AZ† class is concerned, one can give a physical interpretation of the non-Hermitian topological classification, in the absence of boundaries. Lee et al. pointed out that a point-gap topological invariant of the PBC curve in the class $s^dagger in$ AZ† counts the number of anomalous gapless modes whose imaginary parts are large enough @Lee-Vishwanath-19. Here, the anomalous gapless modes in $D$ dimensions are the gapless modes that cannot appear on the bulk of a lattice due to the quantum anomaly but can appear on a $D$-dimensional boundary of a $(D + 1)$-dimensional Hermitian topological insulator/superconductor in the corresponding Hermitian class $s in$ AZ. In linear dynamics described by a non-Hermitian Hamiltonian, the eigenvalues with large imaginary parts are relevant to the long-time dynamics. In this sense, the dynamics described by a point-gap non-trivial Hamiltonian are governed by the anomalous gapless modes in the long-time limit. For example, the chiral modes, which appear on the edge of a quantum Hall insulator, describe the relevant modes in long-time dynamics of one-dimensional class-A non-trivial systems [@fig4(b)]. More precise formulae are summarized as the extended Nielsen-Ninomiya theorem in @Bessho-Sato-20.

#figure(
  table(
    columns: 12,
    align: (left, center, center, center, center, center, center, center, center, center, center, center),
    inset: 4pt,
    stroke: 0.5pt,
    [AZ†], [T], [C], [$Gamma$], [0], [1], [2], [3], [4], [5], [6], [7],
    [#text(red)[A]], [0], [0], [0], [0], [#text(red)[$bb(Z)$]], [0], [#text(red)[$bb(Z)$]], [0], [#text(red)[$bb(Z)$]], [0], [#text(red)[$bb(Z)$]],
    [AIII], [0], [0], [1], [$bb(Z)$], [0], [$bb(Z)$], [0], [$bb(Z)$], [0], [$bb(Z)$], [0],
    [#text(red)[AI†]], [1], [0], [0], [0], [0], [0], [#text(red)[$2 bb(Z)$]], [0], [#text(red)[$bb(Z)_2$]], [#text(red)[$bb(Z)_2$]], [#text(red)[$bb(Z)$]],
    [BDI†], [1], [1], [1], [$bb(Z)$], [0], [0], [0], [$2 bb(Z)$], [0], [$bb(Z)_2$], [$bb(Z)_2$],
    [D†], [0], [1], [0], [$bb(Z)_2$], [$bb(Z)$], [0], [0], [0], [$2 bb(Z)$], [0], [$bb(Z)_2$],
    [DIII†], [$-1$], [1], [1], [$bb(Z)_2$], [$bb(Z)_2$], [$bb(Z)$], [0], [0], [0], [$2 bb(Z)$], [0],
    [#text(red)[AII†]], [$-1$], [0], [0], [0], [#text(red)[$bb(Z)_2$]], [#text(red)[$bb(Z)_2$]], [#text(red)[$bb(Z)$]], [0], [0], [0], [#text(red)[$2 bb(Z)$]],
    [CII†], [$-1$], [$-1$], [1], [$2 bb(Z)$], [0], [$bb(Z)_2$], [$bb(Z)_2$], [$bb(Z)$], [0], [0], [0],
    [C†], [0], [$-1$], [0], [0], [$2 bb(Z)$], [0], [$bb(Z)_2$], [$bb(Z)_2$], [$bb(Z)$], [0], [0],
    [CI†], [1], [$-1$], [1], [0], [0], [$2 bb(Z)$], [0], [$bb(Z)_2$], [$bb(Z)_2$], [$bb(Z)$], [0],
  ),
  caption: [Point-gap topological classification in the AZ† class @KSUS-19. The red-colored rows can also be regarded as the skin-effect classification.],
) <tab1>

=== Anomaly interpretation of non-Hermitian skin effects <anomaly-skin>

In classes A, AI†, and AII†, the symmetry-protected skin effects give the physical interpretation of non-trivial non-Hermitian topology under the OBC, while the anomalous gapless modes do under the PBC. These facts indicate the presence of the anomaly interpretation of the symmetry-protected skin effects. In the anomaly interpretation, the skin effects are related to fermion production caused by the quantum anomaly @Okuma-Sato-21. For example, a conventional skin effect is related to a charge accumulation at the boundary caused by a chiral current. The anomaly interpretation also gives an intuitive reason why higher-dimensional skin effects occur in the presence of a topological defect. In quantum field theory, the combination of the quantum anomaly and the topological defect causes the fermion production at the topological defect. The most famous example is the Rubakov-Callan effect (or monopole catalysis), which was originally introduced as the mechanism for proton decay in a SU(5) grand unified theory @Rubakov @callan. The corresponding skin effect is realized in a class-A three-dimensional Weyl Hamiltonian with valley-dependent dissipation in the presence of a magnetic monopole @Okuma-Sato-21. The chiral magnetic skin effect in @Bessho-Sato-20 can be related to a typical fermion production mechanism called the chiral magnetic effect @fukushima2008chiral.

// [figvision] imgs/fig4c.png
// Panel c upper left shows a complex-energy schematic above a three-dimensional band plot. The upper plot has a
// vertical axis Im E and a horizontal axis Re E; a thick red vertical line is labeled line gap, and a red dot on
// the Re E axis is labeled Dirac point, flanked by short blue bars. Text to the right reads point: gapped line:
// gapped. Below, a 3D surface plot with vertical axis Re E and horizontal axes k_x and k_y shows two orange
// bands touching at a point encircled by a blue ellipse. Dotted blue arrows link the plane features to the
// bands, indicating that the spectrum is gapped both relative to a point and to a line. Panel c upper right
// presents a similar complex-energy diagram with vertical axis Im E and horizontal axis Re E. A red vertical
// line marks a line gap, while a red point labeled EP sits inside a blue circle also labeled EP. Text reads
// point: gapped line: gapless. The lower 3D plot with axes Re E, k_x, and k_y displays orange bands meeting at
// an exceptional point highlighted by a blue ellipse. This illustrates a spectrum that is point-gapped but
// line-gapless because it intersects the reference line. Panel c lower left depicts a translucent momentum-space
// sphere labeled S^2 with axes k_x, k_y, and k_z. A red closed curve on the sphere is labeled Weyl exceptional
// ring and annotated Re E = 0. A smaller blue loop labeled S^1 encircles a segment of the ring near a red dot.
// Dashed latitude lines mark the sphere, visualizing a nodal ring of exceptional points at zero real energy.
// Panel c lower right shows two spherical nodes in k-space connected by a straight green line labeled bulk Fermi
// arc (Re E = 0). The axes are k_x, k_y, and k_z. The left node contains a red dot, while the right node is
// labeled EP in red and also contains a red dot. The diagram illustrates an arc connecting bulk exceptional
// points lying at zero real energy.
#figure(placement: top, 
  grid(columns: (18%, 44%, 38%), column-gutter: 1%,
    cetz.canvas(length: 0.72cm, {
      import cetz.draw: *

      content((-1.75, 2.1), anchor: "west", text(size: 13pt)[(a)])
      // point gap
      line((-1.6, 0), (1.5, 0), stroke: (thickness: 2.6pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
      line((0, -1.6), (0, 1.5), stroke: (thickness: 2.6pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
      circle((0, 0), radius: 1.0, stroke: (thickness: 1.2pt, paint: blue), fill: none)
      circle((0, 0), radius: 0.09, fill: red, stroke: none)
      content((0.3, 1.42), anchor: "west", text(size: 11pt)[$"Im" E$])
      content((1.15, -0.3), anchor: "north-west", text(size: 11pt)[$"Re" E$])
      content((-1.55, -1.75), anchor: "west", text(size: 11pt)[point gap])

      // line gap (below)
      group({
        translate((0, -5.4))
        line((-1.6, 0), (1.5, 0), stroke: (thickness: 2.6pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
        line((0, -1.7), (0, 1.6), stroke: (thickness: 2.6pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
        line((0, -1.25), (0, 1.25), stroke: (thickness: 4pt, paint: red))
        circle((0.85, 0), radius: (0.32, 0.75), stroke: (thickness: 1.2pt, paint: blue), fill: none)
        circle((-0.85, 0), radius: (0.32, 0.75), stroke: (thickness: 1.2pt, paint: blue), fill: none)
        content((-1.55, -1.95), anchor: "west", text(size: 11pt)[line gap])
      })
    }),
    scale(72%, cetz.canvas(length: 0.75cm, {
      import cetz.draw: *
      let blu = rgb("#2C5AA8")

      let ax(ox, oy, len) = {
        line((ox - len, oy), (ox + len, oy), stroke: (thickness: 1.6pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
        line((ox, oy - len * 0.85), (ox, oy + len * 0.85), stroke: (thickness: 1.6pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
      }

      content((-0.85, 11.3), anchor: "west", text(size: 13pt)[(b)])
      // 1D ellipse with winding arrows (CCW)
      ax(1.6, 8.6, 2.1)
      content((3.9, 8.2), text(size: 9pt)[$"Re" E_k$])
      content((2.0, 10.45), text(size: 9pt)[$"Im" E_k$])
      content((-0.6, 10.2), anchor: "west", text(size: 9pt)[1D])
      circle((1.6, 8.6), radius: (1.75, 1.35), stroke: (thickness: 2pt, paint: blu), fill: none)
      line((1.6 - 0.55, 8.6 + 1.32), (1.6 - 1.15, 8.6 + 1.24), stroke: (thickness: 2pt, paint: blu), mark: (end: (symbol: "stealth", fill: black)))
      line((1.6 + 0.55, 8.6 - 1.32), (1.6 + 1.15, 8.6 - 1.24), stroke: (thickness: 2pt, paint: blu), mark: (end: (symbol: "stealth", fill: black)))
      circle((1.6, 8.6), radius: 0.09, fill: red, stroke: none)
      content((1.75, 8.45), anchor: "west", text(size: 8.5pt)[$E_B$])
      content((4.4, 6.6), text(size: 9pt)[$=> w = 1$])

      // 2D blob
      ax(9.6, 8.6, 2.6)
      content((12.4, 8.25), text(size: 9pt)[$"Re" E_k$])
      content((10.1, 11.0), anchor: "west", text(size: 9pt)[$"Im" E_k$])
      content((6.5, 10.6), anchor: "west", text(size: 9pt)[2D])
      circle((9.6, 8.6), radius: 1.75, fill: blu, stroke: none, z: 0)
      circle((9.6, 9.62), radius: (0.95, 0.42), fill: white, stroke: none, z: 1)
      circle((9.6, 7.58), radius: (0.95, 0.42), fill: white, stroke: none, z: 1)
      circle((9.6, 10.05), radius: 0.08, fill: white, stroke: (thickness: 0.7pt, paint: black), z: 2)
      content((10.35, 10.15), text(size: 7pt)[$(+)$], z: 2)
      circle((9.6, 9.2), radius: 0.08, fill: white, stroke: (thickness: 0.7pt, paint: black), z: 2)
      content((10.35, 9.1), text(size: 7pt)[$(minus)$], z: 2)
      circle((9.6, 8.6), radius: 0.10, fill: red, stroke: none, z: 2)
      circle((9.6, 8.0), radius: 0.08, fill: white, stroke: (thickness: 0.7pt, paint: black), z: 2)
      content((10.35, 8.1), text(size: 7pt)[$(minus)$], z: 2)
      circle((9.6, 7.15), radius: 0.08, fill: white, stroke: (thickness: 0.7pt, paint: black), z: 2)
      content((10.35, 7.0), text(size: 7pt)[$(+)$], z: 2)

      // middle correspondence line
      content((2.6, 4.4), text(size: 9pt)[Non-Hermitian d-dim])
      line((5.3, 4.4), (6.9, 4.4), stroke: 1.3pt, mark: (start: (symbol: "stealth", length: 0.22, width: 0.18), end: (symbol: "stealth", length: 0.22, width: 0.18)))
      content((9.7, 4.4), text(size: 9pt)[Hermitian d+1-dim])

      // chiral chain
      for i in range(8) {
        circle((1.0 + i * 0.62, 1.9), radius: 0.11, fill: black, stroke: none)
      }
      for i in range(7) {
        let x = 1.0 + i * 0.62
        bezier((x + 0.06, 2.06), (x + 0.22, 2.55), (x + 0.40, 2.55), (x + 0.56, 2.06),
          stroke: (thickness: 1pt, paint: black), mark: (end: (symbol: "stealth", fill: black)))
      }
      line((0.9, 0.9), (5.4, 0.9), stroke: (thickness: 2.6pt, paint: blu), mark: (end: (symbol: "stealth", length: 0.35cm, width: 0.25cm)))
      content((3.1, 0.15), text(size: 9.5pt)[1D Chiral hopping model])

      // IQH parallelogram
      line((8.0, 3.4), (6.8, 1.4), stroke: (thickness: 1.6pt, paint: blu), mark: (end: (symbol: "stealth", fill: black)))
      line((8.6, 3.55), (7.4, 1.55), stroke: (thickness: 1.6pt, paint: blu), mark: (end: (symbol: "stealth", fill: black)))
      content((6.55, 3.5), anchor: "east", text(size: 8.5pt)[chiral \ edge])
      line((7.3, 0.9), (12.3, 0.9), (13.5, 2.9), (8.5, 2.9), close: true,
        fill: rgb("#BFBFBF"), stroke: (thickness: 2pt, paint: blu))
      line((10.6, 1.9), (10.6, 3.4), stroke: (thickness: 2.6pt, paint: black), mark: (end: (symbol: "stealth", length: 0.35cm, width: 0.25cm)))
      content((10.8, 2.5), anchor: "west", text(size: 8.5pt)[B-field])
      content((10.4, 0.15), text(size: 9.5pt)[2D Integer Quantum Hall])
    })),
    // [figvision] imgs/fig4c.png
    // Panel (c) of Fig. 4, a three-part schematic of exceptional points (no axis ticks).
    // Top left: complex-E plane, Re E horizontal and Im E vertical; red vertical "line
    // gap" at Re E=0, red "Dirac point" at the origin, dashed blue gap segments on the
    // real axis, caption "point: gapped / line: gapped". Top right: same plane with an
    // exceptional point at the origin, a blue circle (line gap) around it and a red
    // "line gap" radius, caption "point: gapped / line: gapless". Dotted blue arrows
    // connect each plane to a 3D band surface Re E(k_x,k_y): the left surface shows two
    // sheets touching at a single point with a blue circle around the contact; the right
    // surface shows the sheets split along a ring, with the blue circle on the ring.
    // Bottom: a large sphere S^2 (axes k_x, k_y, k_z) carrying a red "Weyl exceptional
    // ring" where Re E = 0, with an S^1 loop (blue/red arrows) linking it; to the right,
    // two small spheres joined by a green "bulk Fermi arc (Re E = 0)", the right sphere
    // labelled EP.
    image("imgs/fig4c.png", width: 100%),
  ),
  caption: [
    (a) Definitions of non-Hermitian gapped spectra (blue). A point/line-gapped spectrum does not contain the red point/line. (b) Correspondence between class-A point-gap topology and the chiral edge mode at the boundary of the quantum Hall effect, adopted from @Lee-Vishwanath-19. (c) Exceptional point (EP) and its characterization by point and line gap, adopted from @KBS-19.
  ],
) <fig4>

== Non-Hermitian topology and degeneracy points <EP>

In the Hermitian topological classification, gapless structures in momentum space such as Dirac and Weyl point/line nodes are also of great interest @stab-of-fermi-surface @matsuura2013protected @Zhao-PRL-13 @Zhao-PRB-14 @Zhao-PRL-16 @Zhao-PRL-17 @Morimoto-semimetal @Kobayashi-14 @Shiozaki-Sato-14 @CKC-14. In a $D$-dimensional parameter space, a robust $d$-dimensional symmetry-protected gapless structure is characterized by a topological gapped structure on a $(D - d)$-dimensional sphere surrounding the gapless structure. On the basis of a similar topological classification on a sphere, @KBS-19 gave point-gap and line-gap topological classifications around the exceptional points#footnote[Note that non-trivial classifications do not always ensure the existence of exceptional points.], at which the parameterized non-Hermitian Hamiltonian is not diagonalizable @kato2013perturbation @berry2004physics @heiss2012physics [@fig4(c)]. According to @KBS-19, the point/line gap is open/closed around an exceptional point. This statement is based on the observation that exceptional points are connected via a line-gapless structure called the bulk Fermi arc @Kozii-17 @Zhou-18 @Papaj-19 [@fig4(c)]. Such topological classifications describe symmetry-protected exceptional structures with various dimensionality such as exceptional points and rings @Bergholtz-review @Kozii-17 @Zhou-18 @Papaj-19 @Zhou-19 @Shen-18 @Zyuzin-18 @Yoshida-18 @Yoshida-19 @Bergholtz-19 @Kimura-19 @Zhen-15 @Xu-17 @Okugawa-19 @Budich-19 @Cerjan-19.

= SKIN EFFECTS IN VARIOUS SITUATIONS <various-situations>

== Skin effects without asymmetric hopping <without-asymmetric>

Non-Hermitian skin effects are experimentally relevant in classical systems @Brandenbourger-19-skin-exp @Ghatak-19-skin-exp @Helbig-19-skin-exp @Hofmann-19-skin-exp. While the implementation of asymmetric hopping is not easy in quantum systems, this does not forbid the quantum implementation because non-Hermitian skin effects only require the spectral topology. Namely, on-site dissipation can also induce non-Hermitian skin effects, as emphasized in @Yi-Yang-20. In fact, the non-Hermitian skin effect in the discrete-time non-unitary quantum walk was experimentally realized by mode-selective loss @Xiao-19-skin-exp. For an intuitive understanding, let us consider a one-dimensional two-band Hermitian Hamiltonian $H(k) = bold(d)(k) dot.op bold(sigma)$, where $bold(d) in bb(R)^3$, and $sigma$'s are the Pauli matrices that represent "spin" degrees of freedom. The dispersion is given by $E_±(k) = ± | bold(d)(k) |$, and the spin direction of each eigenstate is parallel/anti-parallel to $bold(d)(k)$. Under momentum-independent spin-dependent non-Hermiticity, each band effectively feels momentum-dependent dissipation @Okuma-Sato-21. For $bold(d)(k)$ that realizes the PBC curve with a non-trivial winding number, one can realize the conventional skin effect by the combination of the spin-momentum locked band structure and the on-site non-Hermiticity [@fig5(a)]. This construction is analogous to an implementation of a topological superconductor in which the $p$-wave pairing is effectively realized by the combination of the spin-momentum-locked band structure and the $s$-wave pairing @Sato-Ando @Sato-Fujimoto @Lutchyn @O-R-vO. One can also use the combination of topological boundary states and boundary-dependent dissipation as a source of non-Hermitian skin effects @Okuma-Sato-21. For example, let us consider a thin film of a three-dimensional topological insulator. The low-energy effective model of this system is given by two two-dimensional Dirac cones with opposite chiralities at the top and the bottom surfaces. By setting a surface-dependent dissipation, one can realize the effective valley-dependent dissipation that leads to the two-dimensional $bb(Z)_2$ skin effect [@fig5(b)].

== Skin effects in higher dimensions <hose>

In the previous sections, we have discussed $D$-dimensional skin effects whose origin is a $D$-dimensional topology. In addition to such #emph[intrinsic] $D$-dimensional skin effects, one can also consider the $D$-dimensional skin effect whose origin is a $(d < D)$-dimensional topology. For example, under the OBC in the $x$ direction and the PBC in the other directions, the Hamiltonian is block diagonalized into the Bloch Hamiltonian $H(bold(k)_perp in bb(R)^(D-1))$, which can be regarded as a one-dimensional system. For each $bold(k)_perp$, one can define a conventional non-Hermitian skin effect whose origin is the spectral winding. In this context, @Hofmann-19-skin-exp theoretically and experimentally discussed a relationship between the emergence of exceptional points and a skin effect in a two-dimensional Dirac system.

Another remarkable direction is the corner skin modes at a higher-dimensional lattice, which are realized as the combination of Hermitian and non-Hermitian localizations. Reference @Lee-Li-Gong-19 proposed the hybrid higher-order skin-topological mode as the combination of a Hermitian topological gapless state and the non-Hermitian skin effect, and @zou2021observation experimentally realized it on electric circuits. References @Okugawa-takahashi-yokomizo @KSS-20 @Fu-Hu-Wan-21 investigated higher-order skin effects whose doubled Hermitian Hamiltonians are higher-order topological insulators#footnote[These skin modes are related to Hermitian edge states of semi-metals such as graphene. In this sense, Hermitian and non-Hermitian localizations coexist.] @benalcazar2017quantized @benalcazar2017electric @langbehn2017reflection @song2017d. In addition to these studies, higher-order localizations have been studied in various contexts#footnote[Correspondingly, the terminology "higher-order skin effects" is often used in various situations.]. For example, the combinations of non-Hermitian skin effect and higher-order topological modes have been investigated both theoretically @Liu-19 @Edvardsson-19 @GLSH-21 @GLS-21 and experimentally @wu2020observation @zhang2021observation.

= NON-HERMITIAN DYNAMICS AND SPECTRAL TOPOLOGY <dynamical>

// [figvision] imgs/fig5.png
// I don't see any figure attached to this conversation. The caption you provided references a Hamiltonian, model
// parameters, and Gamma matrices, but the actual image content (axes, ranges, colours, data series, annotations,
// layout) is not available to me. To produce the panel-by-panel annotation you need, please share the figure
// image directly. I can then describe each panel quantitatively—axes, units, series, line styles, labels, and
// trends—for the Typst archive entry.
#figure(placement: top, 
  image("imgs/fig5.png", width: 90%),
  caption: [
    Skin effects without momentum-dependent dissipation. (a) One-dimensional skin effect in spin-momentum-locked bands of the Hamiltonian $H(k) = sin k sigma_z + (1 - cos k) sigma_x$. A spin-dependent momentum-independent dissipation $i g (-1 + sigma_z)$ effectively behaves as momentum-dependent dissipation. The model parameters are $L = 100$ and $g = 0.1$. (b) Two-dimensional $bb(Z)_2$ skin effect realized on the surface of a three-dimensional topological insulator $H(bold(k)) = sum_(i = 1)^3 sin k_i gamma_i + (m + sum_(i = 1)^3 cos k_i) gamma_0$, where $gamma$'s are the Gamma matrices satisfying $(gamma_mu, gamma_nu) = delta_(mu nu)$. The constant dissipation $- i g$ is introduced at the bottom surface, and the $pi$ flux goes through the center. The system size is $20 times 20 times 6$, $m = -2$, and $g = 0.4$.
  ],
) <fig5>

Before closing, we relate the spectral topology of non-Hermitian tight-binding models to non-Hermitian dynamics. Let us consider the non-Hermitian Schrödinger equation with a non-Hermitian Hamiltonian $H$:

$
  i frac(partial, partial t) |psi(t)⟩ = H |psi(t)⟩
$<nonhermitiansch>

where $|psi(t)⟩$ is a wavefunction whose norm depends on time. In open quantum systems, this equation describes various situations, such as the Lindblad equation @Lindblad written in a quadratic form of field operators @Prosen-2008 @Prosen-2010 and the continuous Lindblad dynamics without quantum jumps @Daley-14. In classical systems, this equation has been investigated in various fields, including fluid mechanics @Trefethen and network science. If $H$ is a normal matrix ($[H, H^dagger] = 0$), the dynamics of the norm is always governed by the imaginary part of the spectrum. If not ($[H, H^dagger] ≠ 0$), however, the relaxation dynamics is more non-trivial. Remarkably, the right eigenstates of a non-normal matrix do not span the whole Hilbert space. If the initial state is in or close to the subspace spanned by the right eigenstates, the non-normal dynamics is not different from the normal dynamics. For more general initial states, however, there is a transient time $(0 < t < oo)$ for the state to have a large overlap with that subspace, and the transient dynamics is governed by the pseudospectrum discussed in @Asllani-2018 @pseudospectrum, instead of the spectrum. In the long-time limit $(t -> oo)$, non-normal dynamics is governed by the spectrum, as in the case of a normal matrix. Due to the pseudospectral nature, amplification in the transient time is allowed even if the largest imaginary part of the spectrum is negative.

Physically, the transient time depends on the speed of propagating information, or the Lieb-Robinson bounds @Gong-18. In a one-dimensional system with the non-Hermitian skin effect, the transient time is given by the time for the information to propagate from one end to the other end, which is proportional to the system size @Gong-18. The corresponding "quasi-eigenvalue" is in the $epsilon$-pseudospectrum with $epsilon$ that is exponentially small with respect to the system size @Gong-18. In the correspondence between non-Hermitian and Hermitian topology, the pseudospectrum under the non-Hermitian skin effect is related to the quasi-zero modes of a topological insulator @Okuma-Sato-20, as emphasized in @pseudospectrum. In this sense, the transient dynamics under the non-Hermitian skin effect is related to the quasi-zero modes of a Hermitian topological insulator. For general non-normal matrices, the transient time can be roughly estimated by the non-normal energy-time uncertainty relation defined for a pseudospectrum @Okuma-Nakagawa.

Which is physically more important, the spectrum or the pseudospectrum? The answer depends on the situation. If one is interested in the stability/instability under linear fluctuations, the stability/instability is judged by the negativity/positivity of the largest imaginary part of the spectrum. If nonlinearity is not negligible, on the other hand, the combination of transient amplification and nonlinearity can lead to instability even if the largest imaginary part of the spectrum is negative @Trefethen. @Nakai-Okuma-Sato. In addition to classical systems @Asllani-2018, @Okuma-Nakagawa, the mathematics of stability/instability is relevant in quantum systems described by the bosonic Bogoliubov-de Gennes equation @okuma2022boundary @Mc-18 @Flynn-20 @Flynn-21 @BdG-non-bloch. In addition to the stability analysis, the relaxation process to the non-equilibrium steady state in the Lindblad equation is related to non-normality. Several studies pointed out that the relaxation time is not always described by the spectral gap @mori-20 @haga-20 @Gong-18. In our view, the origin of the mismatch is nothing but the pseudospectral nature of non-normal matrices.

Although the above discussion is limited to the Schrödinger dynamics, we note that non-Hermitian spectral phenomena can appear in more generic situations. For example, @zou2021observation detected the skin corner modes with a small imaginary part in electric circuits in which the relevant eigenvalues are not given by the largest imaginary part but by the smallest absolute value. We hope that this review inspires readers to consider applications of non-Hermitian matrices to condensed matter physics.

#heading(level: 1, numbering: none)[ACKNOWLEDGMENTS]

The authors acknowledges Kenta Esaki, Kazuki Hasebe, Mahito Kohmoto, Kohei Kawabata, Ken Shiozaki, Masahito Ueda, Takumi Bessho, Sayed Ali Akbar Ghorashi, Tianhe Li, Taylor L. Hughes and Yuya O. Nakagawa for collaborations. This work was supported by JST CREST Grant No. JPMJCR19T2, JST ERATO-FS Grant No. JPMJER2105, and KAKENHI Grants Nos. JP20H00131 and JP20K14373.

#bibliography("refs.bib", style: "ieee", title: [References])
