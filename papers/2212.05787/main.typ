// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.27cm, right: 1.27cm, top: 1.35cm, bottom: 1.19cm), columns: 2)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure(supplement: [Fig.])
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#show heading: set block(above: 1.4em, below: 0.7em)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)

// ---- title block ----
#place(top + center, scope: "parent", float: true)[
#align(center)[
  #text(15pt, weight: "bold")[Transient non-Hermitian skin effect]
  #v(1.0em)
  #text(10pt)[Zhongming Gu#super[1], He Gao#super[2#sym.star], Haoran Xue#super[3#sym.star], Jensen Li#super[4], Zhongqing Su#super[2] and Jie Zhu#super[1#sym.star]]
  #v(0.8em)
  #text(8.5pt)[#super[1] Institute of Acoustics, School of Physics Science and Engineering, Tongji University, Shanghai 200092, China. #linebreak() #super[2] Department of Mechanical Engineering, The Hong Kong Polytechnic University, Hung Hom, Kowloon, Hong Kong SAR, China. #linebreak() #super[3] Division of Physics and Applied Physics, School of Physical and Mathematical Sciences, Nanyang Technological University, Singapore 637371, Singapore.   #super[4] Department of Physics, The Hong Kong University of Science and Technology, Kowloon, Hong Kong, China. #linebreak() #super[sym.star] e-mail: h.e.gao\@connect.polyu.hk; haoran001\@e.ntu.edu.sg; jiezhu\@tongji.edu.cn.]
]
#v(0.8em)
#block(width: 92%)[
#text(9pt)[#strong[The discovery of non-Hermitian skin effect (NHSE) has opened an exciting direction for unveiling unusual physics and phenomena in non-Hermitian system. Despite notable theoretical breakthroughs, actual observation of NHSE's whole evolvement, however, relies mainly on gain medium to provide amplified mode. It typically impedes the development of simple, robust system. Here, we show that a passive system is fully capable of supporting the observation of the complete evolution picture of NHSE, without the need of any gain medium. With a simple lattice model and acoustic ring resonators, we use complex-frequency excitation to create virtual gain effect, and experimentally demonstrate that exact NHSE can persist in a totally passive system during a quasi-stationary stage. This results in the transient NHSE: passive construction of NHSE in a short time window. Despite the general energy decay, the localization character of skin modes can still be clearly witnessed and successfully exploited. Our findings unveil the importance of excitation in realizing NHSE and paves the way towards studying the peculiar features of non-Hermitian physics with diverse passive platforms.]]
]
]

Topological phases of matter have been widely studied in various platforms including both electronic materials @hasan2010colloquium @qi2011topological and artificial structures @ozawa2019topological @huber2016topological @ma2019topological @xue2022topological. Conventional topological band theory is built on the system's Hamiltonian which is often assumed to be Hermitian. However, for a system coupled to the open environment or with gain and/or loss modulation, a non-Hermitian Hamiltonian needs to be employed @moiseyev2011non. In contrast to the Hermitian case, a non-Hermitian Hamiltonian can host complex eigenvalues with nonorthogonal eigenmodes and has unique symmetries and bandgaps without Hermitian counterparts. These sharp differences lead to many surprises in topological physics and make non-Hermitian topology currently a hot topic under extensive research @ghatak2019new @ashida2020non @bergholtz2021exceptional.

One paradigmatic topological phenomenon in non-Hermitian systems is NHSE, which refers to the localization of an extensive number of eigenmodes at the boundaries @alvarez2018non @xiong2018does @gong2018topological @yao2018edge @kunst2018biorthogonal @ding2022non. NHSE has profound impacts on band topology as it reflects a novel point-gap topology that is unique to non-Hermitian systems @gong2018topological @borgnia2020non @okuma2020topological @zhang2020correspondence and leads to a breakdown of the conventional bulk-boundary correspondence @yao2018edge @kunst2018biorthogonal @yao2018non. The boundary-localized eigenmodes in NHSE, namely the skin modes, only exist in point-gapped systems that are intrinsically non-Hermitian and thus are fundamentally different from other boundary modes such as the Tamm states and topological edge states that can arise without the aid of non-Hermiticity. Due to its unconventional physical properties, NHSE has also been found to be useful in various applications, including wave funneling @weidemann2020topological, enhanced sensing @budich2020non @mcdonald2020exponentially and topological lasing @longhi2018non @zhu2022anomalous.

NHSE has been demonstrated in a number of active platforms, such as optical fiber loops with optical intensity modulators @weidemann2020topological, circuit lattices with negative impedance converters @helbig2020generalized @zou2021observation @liu2021non and phononic crystals connected to external circuits @ghatak2020observation @zhang2021acoustic @chen2021realization @wang2022non. The active components, while introducing gain and making NHSE easy to observe, largely enhance the complexities and instabilities of the systems. For example, when the lattice size is large and the excitation is far away from the boundary, the high intensity of the amplifying wavepacket can cause significant nonlinear effects @wimmer2015observation. On the other hand, NHSE can also exist in purely lossy systems @zhang2021observation. Despite the advantages of being easy to construct and stable, one crucial obstacle in passive systems is the difficulty in exciting the skin modes @gao2022non @schomerus2022fundamental. Owing to the rapid decay of energy, it is in general hard to observe NHSE, especially when the source is away from the boundary where the skin modes are localized. In such a case, instead of observing the localization of the skin modes, one observes that the excited field is localized around the source [see #ref(<fig-tb-model>)d].

In this work, we show that the above problem can be overcome using the concept of virtual gain, originally developed in parity-time symmetric systems @li2020virtual @yang2022observation @li2021gain @li2020parity. This technique has also been applied to achieve virtual optical pulling force @lepeshov2020virtual. The key idea is that, under a complex-frequency excitation, the intensity can increase along the propagation direction despite the eigenmodes moving in the same direction being lossy, thus mimicking the gain effect. In a passive lattice with NHSE, such a method can be exploited to excite the skin modes with an arbitrary excitation position and a unique NHSE, dubbed transient NHSE, can be observed in a quasi-stationary stage where the system's intensity drops in time but the localized profile persists. We provide an illustrative tight-binding model and a concrete acoustic crystal to demonstrate the feasibility of the idea. Furthermore, the acoustic model is realized experimentally and the virtual gain effect is verified through time-resolved field mapping.

// [figvision] imgs/figure1.png
// Panel a is a schematic diagram plotted in the complex plane with the horizontal axis labeled Im(omega) and the
// vertical axis labeled -Im(k). The origin is marked 0. A semi-circular region is divided into two sectors by a
// thick blue diagonal line originating from the center. The left sector, shaded light green, represents
// "Attenuated" regions or virtual loss. The right sector, shaded yellow, represents "Amplified" regions or
// virtual gain. Three stars mark specific points: a green star in the attenuated zone, a blue star on the
// critical boundary line, and a yellow star in the amplified zone. Panel b consists of three stacked plots
// showing field distributions corresponding to the stars in panel a. The vertical axis for all plots is labeled
// |p|, representing magnitude, while the bottom plot has a horizontal axis labeled x. The top plot, linked to
// the green star, shows a green curve decaying exponentially from a high value at x=0 towards zero. The middle
// plot, linked to the blue star, displays a flat blue rectangle indicating a constant field amplitude across the
// domain. The bottom plot, linked to the yellow star, features a yellow area where the field magnitude starts
// near zero and increases exponentially as x increases.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Fig. #context it.counter.display(it.numbering)* #it.body]
}

#figure(
  image("imgs/figure1.png", width: 100%),
  placement: top,
  caption: [
    #strong[Conceptual illustration of the virtual gain effect.] #strong[a], The effects due to simultaneous modulations on $k$ and $omega$ in the complex plane. The green and yellow regions exhibit virtual loss and gain effects, respectively. The blue line denotes the critical points. #strong[b], The field distributions for the three cases that are marked as stars in (#strong[a]).
  ],
) <fig-virtual-gain>

= Results

== Virtual gain effect

The virtual gain effect is realized by so-called complex-frequency excitation @baranov2017coherent @li2020virtual. Conventionally, we use the expression $e^(i ( omega t - k x ))$ to represent a propagating wave that travels along the $x$ direction with a frequency of $omega$, while the $e^(i omega t)$ is often omitted for simplicity in the case of monochromatic incidence. When gain and loss are considered as the characteristics of the materials, a complex wave number $k$ needs to be adopted: $k = k_0 n$, where $k_0$ is the wave number in the free space and $n = n_0 + i n'$ is the complex refractive index of the materials. Then, there will have a non-propagation term $e^(k_0 n' x)$ that denotes the attenuation or amplification, depending on the sign of $n'$. For a complex-frequency excitation with $omega = omega_0 + i omega'$, the intensity distribution shares a similar profile with that induced by the complex refractive index. When both gain/loss and the complex-frequency excitation are present, the amplification/attenuation of the wave is dependent on both factors, as illustrated in #ref(<fig-virtual-gain>)a. Since the system is passive, we only consider the imaginary part of $k$ varies in the negative axis. Specifically, when $( omega' / omega_0 - n' ) > 0$, the intensity decays along the propagation direction, corresponding to the loss effect. On the contrary, when $( omega' / omega_0 - n' ) < 0$, the intensity increases along the propagation direction, corresponding to the gain effect. Moreover, when $abs(omega' / omega_0) = abs(n')$, the modulations in the time domain and space domain will generate a plane wave pattern without distortions. The field distributions of the above three cases are illustrated in #ref(<fig-virtual-gain>)b.

== Tight-binding model

To illustrate the idea, we first consider a simple one-dimensional (1D) lattice model [see #ref(<fig-tb-model>)a]: $ H = sum_j ( kappa_r c_(j + 1)^dagger c_j + kappa_l c_j^dagger c_(j + 1) + i gamma c_j^dagger c_j ) , $ where $kappa_(l / r)$ are hopping strengths and $gamma < 0$ is the on-site loss. This model is simply the minimal model for NHSE (i.e., the Hatano-Nelson model with nearest-neighbor asymmetric hoppings) @hatano1996localization with additional on-site loss. Note that while here we use this specific model for illustration, our proposed method is applicable to various passive systems with NHSE, as evident in the following discussions and experiment. When $gamma = 0$, this lattice is known to host NHSE induced by the asymmetric hoppings (i.e., $kappa_r != kappa_l$), with the eigen spectrum under periodic boundary condition (PBC) forms a closed loop in the complex plane and the eigenmodes under open boundary condition (OBC) are all skin modes. A nonzero $gamma$ just shifts the eigenvalues of all modes along the imaginary axis while keeping the nontrivial point gap topology unchanged. In our calculations, we tune $gamma$ such that all modes are decaying modes [see #ref(<fig-tb-model>)b,c], which allows us to study the behaviors of a passive NHSE lattice under different excitations.

// [figvision] imgs/figure2.png
// Panel a: This schematic depicts a one-dimensional lattice consisting of blue circular nodes representing
// sites, connected by green and yellow arrows indicating couplings. A vertical wavy line labeled iγ sits above
// each node to represent on-site loss. Green arrows point rightward between adjacent nodes, while yellow arrows
// point leftward. The coupling strengths are denoted as κ_r for rightward (green) and κ_l for leftward (yellow).
// Ellipses at both ends imply the chain extends further. Panel b: This plot shows eigen spectra in the complex
// frequency plane with horizontal axis Re(ω) from -2 to 2 and vertical axis Im(ω) from -1.4 to -0.2. Colored
// dots form an elliptical ring under periodic boundary conditions (PBC), colored by phase k ranging from -π to π
// via a rainbow bar. Black dots lie along a straight horizontal line at Im(ω) = -0.8 under open boundary
// conditions (OBC), spanning Re(ω) ≈ -2 to 2. Panel c: This line plot displays intensity versus site number (1
// to 30) for all eigenmodes under OBC. Multiple curves start high near site 1 and decay rapidly toward zero by
// site ~15–20. Curves vary slightly in shape but share similar exponential-like decay profiles, suggesting
// localization or damping effects across modes. Panel d: Two heatmaps show time evolution of intensity field
// over site number (x-axis: 1–30) and time (y-axis: 0–30). Left panel: initial pulse decays quickly; right
// panel: pulse propagates rightward with growing amplitude. Inset plots compare t=18 (solid red) and t=19
// (dotted cyan) profiles — left inset shows rapid decay, right shows growth toward edge. Colorbar maps intensity
// 0 (black) to 1 (white/yellow). Orange arrows indicate directionality. Panel e: Similar structure to panel d.
// Left heatmap: localized excitation decays fast without propagation. Right heatmap: excitation moves diagonally
// upward-right, intensifying toward top-right corner. Insets again contrast t=18 vs t=19 — left shows collapse,
// right shows buildup. Vertical orange arrow indicates temporal progression. Shared color scale applies.
#figure(
  image("imgs/figure2.png", width: 100%),
  placement: top,
  caption: [
    #strong[Numerical results for the 1D tight-binding model.] #strong[a], Schematic of the lattice, where $gamma$ denotes the on-site loss and $kappa_r$ ($kappa_l$) are couplings from left to right (right to left). #strong[b], The eigen spectra for the lattice shown in (#strong[a]) under PBC (colored dots) and OBC (black dots), respectively. #strong[c], Plot of all eigenmodes under OBC for a finite lattice with 31 sites. #strong[d], Time evolutions of the intensity field in a finite lattice with a monochromatic excitation ($omega = 0.5$) at the left end (left panel) and the right end (right panel). #strong[e], Similar to (#strong[d]) but for a complex-frequency excitation ($omega = 0.5 + 0.6 i$). In (#strong[d]) and (#strong[e]), the intensity at each time slice is normalized by the maximum value at that moment for easy visualization and the insets show the signal strength without normalization at $t = 18$ and $t = 19$. The lattice parameters used in the calculations are $kappa_r = 0.7$, $kappa_l = 1.3$, and $gamma = 0.8$.
  ],
) <fig-tb-model>

Consider an excitation of the form $e^(i omega t) psi_0$, where $omega$ denotes the excitation frequency/energy (which can be complex), $t$ is time and $psi_0$ is the excitation profile at $t = 0$. When $omega$ is a real number, the excitation intensity remains unchanged in time, which is the usual case in experiments. #ref(<fig-tb-model>)d shows the time evolution of the intensity field in a finite lattice when the excitations with $omega = 0.5$ are located at the left and the right ends, respectively. As can be seen, the field is always localized around the position of the excitation due to the overall loss in the system, which fails to reveal the NHSE.

Next we set $omega$ to be a complex number, i.e., $omega = omega_0 + i omega'$. The parameter $omega'$ controls the amplification or decay of the excitation in time. For an excitation with complex frequency $omega$, at a fixed instant, the intensity (normalized to the input) will increase along the propagation direction when the decay in excitation is faster than the actual decay of the mode in the lattice at the corresponding frequency. To see the effects of such a virtual gain, we again calculated the intensity evolution using the same lattice as in #ref(<fig-tb-model>)d but with a complex-frequency excitation ($omega' = 0.6$). As shown in #ref(<fig-tb-model>)e, now the NHSE can be observed, even when the excitation position is far away from the boundary where skin modes are localized. We note that, in such a passive system with a complex-frequency excitation, the total intensity will decay in time. However, during the time window when the quasi-stationary profile is developed and the system's intensity is higher than the background noise, the transient NHSE can always be observed [see the insets in #ref(<fig-tb-model>)e]. Apart from the localization property, more subtle features of NHSE, such as the non-local response, can also be captured with the complex-frequency excitation, as provided in the Supplementary Note 2 of Supplementary Materials.

== Acoustic model

// [figvision] imgs/figure3.png
// Panel a is a schematic of an acoustic unit cell. It features a central blue racetrack-shaped ring with radius
// R = 5.6 cm and straight section width l = 9.6 cm. The top straight segment contains a green rectangle, and the
// bottom segment has a yellow rectangle; both have wavy arrows indicating different loss regions. The left and
// right sides connect to gray U-shaped waveguides labeled A, B, C, and D at their ends. Red dashed boxes
// highlight the coupling regions where the ring meets the waveguides. Panel b displays transmission data versus
// frequency from 7 to 9 kHz. The left y-axis shows Transmission (0–1) for blue circles, which remain near 1.0
// across the range. The right y-axis plots theta/pi (0.1–0.6) for red stars, starting around 0.53 and decreasing
// slightly to 0.5. An inset schematic illustrates a layered structure: a gray block above a blue block separated
// by brown vertical bars, with dimensions h and d marked. Wavy arrows indicate excitation on both sides of the
// layers. Panel c presents a complex plane plot of eigenvalues phi. The horizontal axis Re(phi) spans -pi to pi,
// while the vertical Im(phi) ranges from -0.3 to -0.1. Black dots form two horizontal lines at Im(phi) ≈ -0.2
// and -0.3. A color bar below maps wave number k from -pi (red) through 0 (yellow-green) to pi (blue),
// corresponding to the dot colors along the real axis. Panels d and e show time-domain pressure signals in
// arbitrary units over 0–10 ms. Panel d compares port C (blue line) and port A (yellow line); both exhibit
// decaying oscillations after initial transients. Panel e contrasts port B (blue) and port D (green), also
// showing damped waveforms. All traces start with high amplitude that diminishes exponentially, indicating
// energy dissipation or leakage from the system ports. Panel f depicts intensity distributions across a linear
// chain of ten coupled resonators under two excitations. Top row: complex-frequency excitation produces maximum
// intensity localized at the eighth resonator, fading toward edges. Bottom row: monochromatic excitation yields
// uniform intensity spread across all resonators. Color scale runs from black (0) to yellow (Max). Orange dotted
// outlines mark excited regions; arrows point to excitation sources above and below the chains.
#figure(
  image("imgs/figure3.png", width: 100%),
  placement: none,
  caption: [
    #strong[Numerical results for the acoustic ring resonator lattice.] #strong[a], The acoustic unit cell. The radius, $R$, of the circular part is 5.6 cm and the width, $l$, of the straight part is 9.6 cm. The green and yellow areas with arrows represent areas with different losses. The red dashed boxes denote the coupling regions. #strong[b], Plots of $theta$ (red stars) and the transmission coefficient (blue circles) between two neighboring rings against frequency. The inset shows the simulation geometry, which consists of an array of narrow waveguides (16 in total) that are used to couple the neighboring rings. The width and thickness of each narrow tube $h = 0.7$ cm and $b = 0.35$ cm, arrayed with a period of 0.47 cm. The width, $d$, of the ring resonator is 1.4 cm. #strong[c], The eigen spectra for the PBC and OBC lattices are derived from the transfer matrix method with $theta = 0.5 pi$. The colored dots and black dots denote the results for the PBC lattice and OBC lattice, respectively. #strong[d], #strong[e], Simulated pressure profiles of the input and output signals with complex frequency for the waves propagate along a path with (#strong[d]) less loss and (#strong[e]) more loss, respectively. The transient simulations are conducted by finite element method. #strong[f], Simulated field distributions at 15~ms after the lattice is injected with monochromatic excitation and complex-frequency excitation, respectively.
  ],
) <fig-acoustic-model>


We now apply the above scheme to a realistic acoustic ring resonator lattice with only lossy elements. As depicted in #ref(<fig-acoustic-model>)a, each unit cell of this lattice contains a site ring (depicted in grey) and a link ring (depicted in blue) of identical sizes. Both rings are hollow, filled with air and surrounded by hard walls. The upper and lower parts of the link ring have different losses [see #ref(<fig-acoustic-model>)a], which induces NHSE @longhi2015robust @zhu2020photonic. In this lattice, there are two sets of modes with opposite circulation directions in the ring resonators, which can be made to be decoupled by carefully designing the structures to minimize the backscattering. Thereafter, we focus on the modes with clockwise/counterclockwise circulation direction in the link/site ring.

We use the transfer matrix method to calculate the eigen spectra under PBC and OBC @liang2013optical @gao2016probing @peng2016experimental. In each coupling region (denoted by the red dashed boxes in #ref(<fig-acoustic-model>)a), the incoming and outcoming waves are related by a scattering matrix: $ S = mat(delim: "[", cos theta, - i sin theta; - i sin theta, cos theta) . $ where $theta$ describes the coupling strength. Since the loss is negligible in the coupling region, the #emph[S] matrix is unitary. Numerically, the value of $theta$ can be extracted from a two-port transmission simulation. The coupling regions are carefully designed such that $theta$ in a broad frequency window ranging from 7000 Hz to 9000 Hz is around $0.5 pi$, corresponding to the perfect transmission case [see #ref(<fig-acoustic-model>)b]. More details about the design procedure can be found in the Supplementary Note 3 of Supplementary Materials. Given the boundary condition, the scattering equations can be cast into a Floquet eigen-problem, with the round trip phase $phi$ in each ring playing the role of quasienergy (see Supplementary Note 1 for more details).


// [figvision] imgs/figure4.png
// Panel a displays a photograph of the physical experimental apparatus, which is a white 3D-printed structure on
// a black background. The object consists of a linear chain of six complete circular loops connected by straight
// segments, flanked by two partial loops at the ends. Text labels identify the full circles as site rings and
// the connecting sections as link rings. Rectangular boxes highlight specific regions: green boxes mark the top
// horizontal segments of the third and fifth link rings, while yellow boxes mark the bottom segments of the
// first, third, and fifth link rings. A white scale bar in the bottom right corner indicates a length of 5 cm.
// Panel b presents a time-domain plot showing the excitation signal applied to the loudspeaker. The vertical
// axis represents the Excitation Signal ranging from -5 to 5 arbitrary units, while the horizontal axis shows
// Time in milliseconds from 0 to 10. A single black curve depicts an oscillating waveform with an amplitude that
// decays exponentially over time. The signal starts with maximum intensity at t=0 and diminishes to near zero by
// approximately 6 ms, effectively defining the duration of the acoustic pulse injected into the system. Panel c
// illustrates the measured time evolution of sound pressure for a left-moving acoustic wave, plotted against
// Time in milliseconds from 0 to 10. The vertical axis denotes Pressure in arbitrary units, spanning -5 to 5.
// Two distinct signals are shown: a blue line representing the initial wave packet that peaks around 3 ms, and a
// yellow line indicating the signal detected after propagation. The yellow signal appears delayed, starting
// around 4 ms, and exhibits a lower peak amplitude compared to the blue signal, demonstrating attenuation during
// travel. Panel d shows another time-domain plot of sound pressure versus Time in milliseconds (0 to 10). The
// vertical axis ranges from -10 to 10 arbitrary units. It features a large blue oscillating wave peaking near 2
// ms, followed by a smaller green signal appearing later around 4 ms. The green signal has a significantly
// reduced amplitude relative to the blue input, visually quantifying the loss or transmission characteristics of
// the acoustic wave through the lattice structure under specific conditions. Panels e, f, and g form a column of
// schematic snapshots labeled w/ NHSE, visualizing the spatial distribution of acoustic intensity within the
// lattice at three specific time points. Each panel depicts two rows of interconnected ring structures. Red
// arrows on the right indicate the direction of wave injection. The panels correspond to times t=3.5 ms, t=8.5
// ms, and t=9.5 ms respectively. A color bar at the bottom maps intensity from 0 (black) to Max (yellow). In
// these frames, high-intensity regions (red/yellow) are clearly localized at the boundaries of the chains,
// illustrating the Non-Hermitian Skin Effect where waves accumulate at the edges rather than propagating
// uniformly. Panels h, i, and j constitute a comparative column of schematics labeled w/o NHSE, showing the same
// lattice geometry and time steps as the previous column (t=3.5, 8.5, and 9.5 ms). These panels visualize the
// scenario without the skin effect. Unlike the boundary-localized patterns in panels e-g, the high-intensity
// regions here appear distributed throughout the bulk of the lattice chains. The color map again ranges from
// black to yellow for intensity. This contrast demonstrates that without the specific non-Hermitian parameters,
// the acoustic energy spreads across the interior of the sample instead of accumulating at the edges.
#figure(
  scope: "parent",
  placement: top,
  image("imgs/figure4.png", width: 95.0%),
  caption: [
    #strong[Experimental demonstration in a 1D acoustic lattice.] #strong[a], Photo of the 3D-printed experimental sample, consisting of six ring resonators and two half rings on the boundaries. The green and yellow boxes indicate the areas with additional loss. #strong[b], The measured electric signal imposed on the loudspeaker. #strong[c], The time evolution of sound pressure for the left-moving acoustic wave. The signals are measured at the middle position of the first site ring (blue) and second site ring (yellow), respectively. #strong[d], The time evolution of sound pressure for the right-moving acoustic wave. The signals are measured at the middle position of the first site ring (blue) and second site ring (green), respectively. #strong[e]-#strong[g], Acoustic energy fields measured at (#strong[e]) 3.5~ms, (#strong[f]) 8.5~ms and (#strong[g]) 9.5~ms for both right and left incidences. #strong[h]-#strong[j], Acoustic energy fields measured in an empty waveguide without additional loss under the same complex frequency excitation at (#strong[h]) 3.5~ms, (#strong[i]) 8.5~ms and (#strong[j]) 9.5~ms for both right and left incidences.
  ],
) <fig-experiment>

#ref(<fig-acoustic-model>)c shows the eigenfrequnecies for both PBC (colored dots) and OBC (black dots) when $theta = 0.5 pi$ (The derivation can be found in the Supplementary Note 1 of Supplementary Materials). The PBC spectrum features two bands with opposite group velocity and distinct imaginary parts, which leads to the formation of skin modes under OBC. It is worthwhile to note that the PBC spectrum does not form a closed loop in the complex plane and the OBC spectrum spans the whole quasienergy range, which are unique features of anomalous NHSE in Floquet systems @gao2022non. Upon reducing the coupling strength $theta$, the PBC spectrum will evolve into a closed loop similar to the one given in #ref(<fig-tb-model>)b (see Supplementary Note 4).

To demonstrate how NHSE can be observed in this all--passive acoustic lattice, we first show the generation of virtual gain in a sing-cell setup as shown in #ref(<fig-acoustic-model>)a. The right-moving acoustic waves will propagate from port B to port D through the green area, whereas the left-moving waves will propagate from port C to port A through the yellow area. As discussed above, the effect of the complex-frequency excitation depends on the relative speed of attenuation caused by the system loss and the excitation decay. Thus, if the decay of the excitation is larger than the decay caused by the yellow area but smaller than the decay caused by the green area, the left-moving waves will have virtual gain while the right-moving waves are still decaying. Such a scenario is numerically demonstrated in #ref(<fig-acoustic-model>)d,e, where blue curves are the input signals and yellow/green curves are output signals. It is clear that at a fixed time after the signal reaches the output ports, the signal at port A/D is larger/smaller than the input one, thereby realizing virtual gain/loss for left/right-moving waves. With this designed complex-frequency excitation, the NHSE can be clearly visualized, as shown in the top panel of #ref(<fig-acoustic-model>)f. At 15 ms after the excitation, the skin mode at the left boundary has been well established. For comparison, we also study the field distribution at the same time under the monochromatic excitation, as shown in the bottom panel of #ref(<fig-acoustic-model>)f. It is obvious that the acoustic energy has been blocked at the input position and decays along the propagation direction since the system is purely dissipative.

== Experiments

We fabricate a 1D acoustic lattice with six ring resonators to realize the proposed scheme experimentally [#ref(<fig-experiment>)a]. There are two half rings attached at both ends of the lattice to inject sound signals. In addition to the background loss, different amounts of additional loss are introduced to the areas denoted by the green and yellow boxes in #ref(<fig-experiment>)a. In the experiments, an input signal with a complex frequency of $8250 (1 + 0.05 i)$ Hz is launched from one excitation port and a 1/4-inch microphone is successively inserted into the small holes in the whole structure to probe the acoustic waves. The measured time-varying electric signal imposed on the loudspeaker is shown in #ref(<fig-experiment>)b. By calculating the enveloping line of the temporal signals, we can obtain time-resolved amplitude of the sound waves in the whole lattice. More experimental details can be found in the Methods section and Supplementary Note 5.

We first adjust the amounts of absorbing materials inserted into the yellow and green areas, such that sound propagating through the yellow/green area exhibits virtual gain/loss. This can be verified by measuring the sound pressure at the adjacent site rings. As shown in #ref(<fig-experiment>)c, for left-moving transmission, the pressure amplitude at the second site ring (the yellow curve) is higher than that at the first site ring (the blue curve) at the same instant of time after traveling through the yellow area, thus realizing the virtual gain effect. By contrast, the situation is reversed for the right-moving transmission [see #ref(<fig-experiment>)d].

Next, we probe the signatures of the NHSE. #ref(<fig-experiment>)e–g show the acoustic intensity fields measured at three different times for both right and left incidences. At $t = 3.5$ ms, the sound waves have just passed through two rings and the quasi-stationary stage has not been reached yet [#ref(<fig-experiment>)e]. At $t = 8.5$ ms, the sound waves have gone across the whole lattice and it is clearly seen that the left-moving wave is amplifying while the right-moving wave is decaying [#ref(<fig-experiment>)f], which signifies the NHSE. Moreover, at $t = 9.5$ ms, the measured intensity distribution, after normalization to its maximum value, is almost the same as the one at $t = 8.5$ ms [#ref(<fig-experiment>)g]. This indicates the quasi-stationary stage can remain stable for a finite time window before the signal decays to the noise level. The detailed time evolutions of the intensity field appear as movies, which are provied in the Supplementary Note 6 of Supplementary Materials. As a comparison, we also measured the time-resolved acoustic intensity fields for an acoustic lattice without addtional loss (i.e., no absrobing materials are inserted into the yellow and green regions). In this case, the same complex frequency excitation always produces localization at the opposite end to the excitation [see #ref(<fig-experiment>)h–j], in contrast to the lattice with NHSE where the localization position is independent of the excitation position. It should be emphasized that the NHSE can be observed in a broad bandwidth with the high coupling strength, although we just use one specific frequency for the demonstration.

= Discussion

The complex-frequency excitation approach, as we show in this work, provides a universal route to study NHSE in passive platforms. Our work that demonstrates the feasibility of visualizing virtual gain and skin mode localization is the first step towards this direction. Many other interesting phenomena associated with NHSE, such as critical NHSE @li2020critical, NHSE with disorder @claes2021skin and self-healing of skin modes @longhi2022self, can be studied using complex-frequency excitation in future studies.

While our demonstration is in acoustics, similar experiments can also be done in various passive systems where time-dependent excitation and time-resolved measurements can be done, such as electric and microwave systems. Since our acoustic system has a relatively large background loss due to the narrow regions in the structures, we anticipate other platforms with smaller intrinsic loss would have larger time windows for the transient NHSE.

= Methods

== Numerical simulations

All the simulations were performed with COMSOL Multiphysics, pressure acoustics module. The density and sound speed for background medium, air, are set to be 1.21 kg/m#super[3] and 343 m/s, respectively. All the boundaries are considered as acoustically hard boundaries. When calculating the transmission and coupling angle (#ref(<fig-acoustic-model>)b), the simulation is conducted in the frequency domain. As illustrated in the inset in #ref(<fig-acoustic-model>)b, the coupling angle is defined as $abs(theta) = "atan"(abs(p_(L B)) slash abs(p_(L T)))$, where the subscripts $L T$ and $L B$ represent the acoustic wave transmitted from left input, with incident signal $p_i$, to top output and bottom output at the right boundary, respectively. When $p_(L T) slash p_i > 0 ( p_(L T) slash p_i < 0 )$, the coupling angle can be obtained directly as $theta = abs(theta) (theta = pi - abs(theta))$. The transmission coefficient is the ratio of $abs(p_(L B))^2$ to $abs(p_i)^2$. When calculating the temporal signals and field distributions in the sample (#ref(<fig-acoustic-model>)d,e,f), the simulations are conducted in the transient domain with a resolution of 1 $mu$s. The complex-frequency excitation is set to be $8250 + 200 i$ Hz.

== Experimental details

The sample is fabricated via 3D printing technology with the resolution of 0.1 mm. Arrayed small holes with the spacing of 2.8 cm are drilled at the top panel of the whole sample, allowing for the signal detection. When the position is not probed, a stopper is inserted to the hole for acoustic sealing. An additional background loss was first introduced, and then the losses in the yellow/green boxes of #ref(<fig-experiment>)a were decreased/increased to construct the virtual gain/loss effect. During the measurement, one port at the two ends of the structure is used for sound excitation, the other ports are sealed with absorptive materials to avoid the backscattering. The sound signal is excited circularly, and each position is probed successively with the same recording length for post-processing.

The complex-frequency excitation is generated by employing a time-varying sinusoidal signal. The real part of the complex excitation is 8250 Hz, which is at the center of working frequency window of the acoustic lattice. To determine the imaginary part of the excitation, we conduct the measurement shown in #ref(<fig-experiment>)c-d with the imaginary part of the excitation gradually increased from zero. When virtual gain and loss effects are respectively realized in the lower and upper parts of the link ring, the suitable value for the imaginary part of the excitation is then identified, which is 412.5 Hz. Finally, we prepare the time-dependent signal in advance, then sent it to the programmable signal generator to trigger the sound signal from the speaker.

= Data availability

The data that support the findings of this study are available from the corresponding author upon reasonable request.

= Acknowledgements

This work is supported by the Fundamental Research Funds for the Central Universities(Grant No. 22120220237) and by the Research Grants Council of Hong Kong SAR (Grant Nos. AoE/P-502/20 and 15205219).

= Author contributions

Z.G., H.G., H.X. and J.Z. conceived the idea. H.G., H.X. and J.Z. supervised the project. Z.G. designed the samples and performed the simulations. Z.G., H.G. and H.X. conducted the experiments and analyzed the data. Z.G., H.G., H.X. and J.Z. wrote the manuscript with inputs from J.L. and Z.S.. All authors contributed to discussions of the manuscript.

= Competing interests

The authors declare no competing interests.

#bibliography("refs.bib", title: [References])