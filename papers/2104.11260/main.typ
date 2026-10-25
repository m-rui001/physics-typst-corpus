// Observation of hybrid higher-order skin-topological effect in
// non-Hermitian topolectrical circuits  (arXiv:2104.11260)
// Converted from the arXiv PDF e-print (no LaTeX source is available).

#set text(font: ("Times New Roman", "Libertinus Serif"), size: 11pt, lang: "en")
#set page(numbering: "1", paper: "a4", margin: (left: 3.18cm, right: 3.07cm, top: 2.74cm, bottom: 2.59cm))
#set heading(numbering: none)
#show heading: set text(size: 12pt, weight: "bold")
#show heading: set block(above: 1.0em, below: 0.35em)
// The published e-print is a double-spaced, first-line-indented manuscript.
#set par(justify: true, first-line-indent: (amount: 21pt, all: true), spacing: 1.47em)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 1.47em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#show figure.caption: set text(size: 10pt)
#show figure.caption: set par(leading: 2.0em, first-line-indent: 0pt, justify: true)
#set figure(supplement: strong[Fig.], numbering: "1")
#set figure.caption(separator: [. ])
// A numbering *callback* (not the "(1)" pattern) is used so that `@eq:…` references
// print the published "Eq. (N)" form instead of "Eq. N". The number itself is pinned to
// the body size so that the reduced-size displays below keep a full-size number.
#let eqnum(n) = text(11pt, "(" + str(n) + ")")
#set math.equation(numbering: eqnum, supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#show math.equation.where(block: true): set align(center)

// The 4x4 circuit-Laplacian matrices and the multi-term Kirchhoff blocks are wider than
// the text column; the published paper sets them in reduced type, so we scope the size
// per equation instead of letting them run into the number column.
#let eqfit(size, body) = block(inset: 0pt)[
  #set text(size)
  #body
]

#align(center)[
  #set par(spacing: 0.5em, first-line-indent: 0pt, justify: false)
  #text(12pt, weight: "bold")[Observation of hybrid higher-order skin-topological effect in non-Hermitian topolectrical circuits] \
  #v(1.0em)
  #set text(11pt)
  #strong[Deyuan Zou] #super[1,\*], #strong[Tian Chen] #super[1,\*], #strong[Wenjing He] #super[2], #strong[Jiacheng Bao] #super[2], #strong[Ching Hua Lee] #super[3], #strong[Houjun Sun] #super[2,‡] and #strong[Xiangdong Zhang] #super[1,+] \
  #v(0.6em)
  #set text(10pt)
  #super[1] Key Laboratory of advanced optoelectronic quantum architecture and measurements of Ministry of Education, Beijing Key Laboratory of Nanophotonics & Ultrafine Optoelectronic Systems, School of Physics, Beijing Institute of Technology, 100081, Beijing, China \
  #super[2] Beijing Key Laboratory of Millimeter wave and Terahertz Techniques, School of Information and Electronics, Beijing Institute of Technology, Beijing 100081, China \
  #super[3] Department of Physics, National University of Singapore, Singapore 117542 \
  #v(0.4em)
  #super[\*,+] These authors contributed equally to this work. Author to whom any correspondence should be addressed. E-mail: zhangxd\@bit.edu.cn; sunhoujun\@bit.edu.cn; chentian\@bit.edu.cn
]

#v(1.2em)

#block(width: 100%, above: 0.6em, below: 1.2em)[
  #set text(size: 11pt)
  #set par(first-line-indent: 0pt)
  #align(center)[#strong[Abstract]]
  #v(0.5em)

  Robust boundary states epitomize how deep physics can give rise to concrete experimental signatures with technological promise. Of late, much attention has focused on two distinct mechanisms for boundary robustness - topological protection, as well as the non-Hermitian skin effect. In this work, we report the first experimental realizations of hybrid higher-order skin-topological effect, in which the skin effect selectively acts only on the topological boundary modes, not the bulk modes. Our experiments, which are performed on specially designed non-reciprocal 2D and 3D topolectrical circuit lattices, showcases how non-reciprocal pumping and topological localization dynamically interplays to form various novel states like 2D skin-topological, 3D skin-topological-topological hybrid states, as well as 2D and 3D higher-order non-Hermitian skin states. Realized through our highly versatile and scalable circuit platform, theses states have no Hermitian nor lower-dimensional analog, and pave the way for new applications in topological switching and sensing through the simultaneous non-trivial interplay of skin and topological boundary localizations.
]

Much of contemporary condensed matter physics has been dominated by theoretical and experimental investigations into robust boundary phenomena. Originally formulated in the context of anomalies, they revolutionized the field of condensed matter physics in the form of topological insulators and semimetals #cite(<r01>) #cite(<r02>) #cite(<r03>). More recently, they aroused much attention again as non-Hermitian skin states, which demonstrated how unbalanced non-Hermitian gain/loss can challenge well-held tenets of bulk-boundary correspondence #cite(<r04>) #cite(<r05>) #cite(<r06>) #cite(<r07>) #cite(<r08>) #cite(<r09>) #cite(<r10>) #cite(<r11>) #cite(<r12>).

While skin and topological effects are already by themselves conceptually deep, with contrasting implications on the bulk-boundary correspondence, their simultaneous nontrivial interplay has been particularly intriguing. Introduced in Ref. #cite(<r13>), hybrid skin-topological states represent a hierarchy of novel higher-dimensional new states without analogs in Hermitian or non-topological settings. Characterized by scenarios where topological localization dynamically allows the non-Hermitian skin effect to act only on certain topological modes, they greatly augment the richness of higher-dimensional robustness beyond higher-order topological phenomena, and provokes the re-formulation of higher-order topological bulk-boundary correspondence to accommodate various avenues of higher-order skin and topological interplay #cite(<r14>) #cite(<r15>). Their non-triviality and richness is also apparent in the context of applications: this simultaneous interplay of the skin effect and higher-order topology has been proposed to be used as a topological switch #cite(<r16>).

In these advances, theory has always preceded experiments. The reason is because most tight-binding models proposed are rather artificial for realization in conventional materials or metamaterials. While higher-order topological phenomena #cite(<r17>) #cite(<r18>) #cite(<r19>) #cite(<r20>) #cite(<r21>) #cite(<r22>) #cite(<r23>) and the non-Hermitian skin effect #cite(<r09>) #cite(<r10>) #cite(<r11>) #cite(<r12>) have been separately realized in several high-profile experiments, their combined interplayed has so far remained a theoretical fantasy due to concomitant challenges of high dimensionality, artificial sublattice structure and non-Hermitian instabilities.

In this work, we demonstrate the first experimental realization of hybrid higher order skin-topological states in 2D and 3D through a topolectrical circuit platform. Electrical circuits are ideally suited for transcending the abovementioned challenges, since electronic components, which have benefited from industrial refinement over the decades, can accommodate almost any desired features like arbitrary long-range connectivity, dimensionality, non-Hermiticity gain/loss as well as non-reciprocity. Recently, simulating topological states with electric circuits has attracted lots of interests based on the similarity between circuit Laplacian and lattice Hamiltonian #cite(<r23>) #cite(<r24>) #cite(<r25>) #cite(<r26>) #cite(<r27>) #cite(<r28>) #cite(<r29>) #cite(<r30>). Some topological states have been observed in circuit networks #cite(<r31>) #cite(<r32>) #cite(<r33>) #cite(<r34>) #cite(<r35>). Through a combination of z-direction non-Hermitian INICs and 2D topological circuits, here we managed to achieve a 3D realization of not just the non-Hermitian skin effect, but also a network of competing such effects that conspire to result in higher-order hybrid states, much beyond the scope of previous circuit demonstrations of 1D skin or higher-order topological robustness individually #cite(<r10>) #cite(<r18>).

= Hybrid higher-order topological skin effect in 2D topolectrical circuits

Hybrid skin-topological phenomena represent not just the simultaneous presence of non-Hermitian skin as well as topological localizations. They are special scenarios where topological localization in one direction dynamically "switches on" the skin effect in another direction, thereby allowing the skin effect to be felt only by topological modes. Given the wide variety of possible types of topological modes, as well as various nontrivial ways whereby the skin effect modifies topological properties, even in 1 dimension, hybrid modes thus comes in a vast array of possibilities. This is especially interesting in 2 dimensions or higher, which we also experimentally probe, because even topological localization per se is subject to higher-order topological effects, which can be modified by skin localization even before they interplay as hybrid phenomena.

We firstly provide the theoretical design of 2D electric circuits to observe skin-topological (ST) and skin-skin (SS) modes, and then give the experimental results to demonstrate such a design. Voltage measurements are particularly sensitive to the spectrum of the circuit Laplacian. In matrix form, Kirchhoff's law is expressed as $bold(I) = bold(J) bold(V)$, where $bold(J)$ is the circuit Laplacian. The electrical potentials $bold(V)$ at each node can be obtained by inverting this expression to obtain

$ bold(V) = bold(J)^(-1) bold(I) = sum_(-mu) epsilon_(-mu)^(-1) |psi_(-mu) ⟩ ⟨psi_(-mu| bold(I) $ <eq:1>

Notably, the potentials $bold(V)$ are most sensitive to small eigenvalues $epsilon_(-mu)$, especially if they are vanishing. In the case of skin-topological hybrid modes, the hybrid mode with zero eigenvalue thus dominates voltage measurements, leading the voltage profile $bold(V)$ proportional to the corresponding hybrid eigenmode. Indeed, we experimentally observe that the voltage profile is topologically localized in the y-direction, and skin-localized in the x-direction, even though the bulk modes are not supposed to even experience the skin effect.

The designed 2D electric circuit network is shown in Fig. 1(a). The sample contains 6×6 units and each unit cell contains four sublattices $(a, b, c, d)$. In the network, different circuit unit cells can be used to construct systems with different functions. For example, if we use the unit cell as shown in Fig. 1(b), the hybrid second-order ST modes appear. In contrast, if the unit cell as shown in Fig. 1(c) is used, the SS modes can be observed. Two kinds of unit cell are composed of capacitances, inductances and three different kinds of negative impedance converter through current inversion (INIC). Operational amplifiers arranged as INIC allow the type of nonreciprocity in the circuit to be precisely tuned, where their detail structures are shown in Fig. 1(d).

For the unit cell as shown in Fig. 1(b), we make the directions of INIC be opposite along x and y directions. This can result in vanished net nonreciprocity since the nonreciprocities cancel along x and y directions, but local nonreciprocity among four sublattices in each unit cell still exists, which corresponds to the 2D hybrid lattice model revealed in Ref. #cite(<r13>). If the directions of INIC are the same along x and y directions as shown in Fig. 1(c), the nonreciprocities along both directions of the electric circuit do not interfere destructively, which accomplishes 2D skin lattice model. Details of the theoretical analysis for the lattice models are provided in Methods. No matter what kind of circuit, we can derive circuit Laplacian $J_(2D)(omega)$ in the moment space at the resonance frequency based on Kirchhoff's current law. It can be written as

#eqfit(9pt)[
$ J_(2D)(omega) = i omega mat(delim: "[",
    0, 0, C_1 - C_3 + C e^(-i q_(-x)), C_1 ± C_2 + C e^(-i q_(-y));
    0, 0, -C_1 - C_2 - C e^(i q_(-x)), C_1 ± C_3 + C e^(i q_(-y));
    C_1 + C_3 + C e^(i q_(-x)), -C_1 + C_2 - C e^(-i q_(-y)), 0, 0;
    C_1 ∓ C_2 + C e^(i q_(-x)), C_1 ∓ C_3 + C e^(-i q_(-y)), 0, 0
) $ <eq:2>
]

where $C = 2.2 "nF"$, $C_1 = 1 "nF"$, $C_2 = 820 "pF"$ and $C_3 = 390 "pF"$. If we choose – in $±$ and + in $∓$ from the matrix above, @eq:2 represents the circuit Laplacian for the case where the hybrid second-order ST effect can be shown. Otherwise, it corresponds to the case that can show the SS effect. The detailed derivation of @eq:2 is given in Methods.

// [figvision] imgs/fig1.png
// (a) This is a schematic of a 2D electric circuit network. The plot shows a grid of coloured dots connected by
// black lines and blue lines with arrows. The blue lines represent INICs and the black lines represent
// inter-cell capacitive and inductive couplings. Each unit cell contains four sublattices, shown as red, yellow,
// green, and blue dots. The trend shows a designed circuit with nonreciprocity. (b) This is a schematic of the
// ST effect. The plot shows a unit cell with four sublattices connected by black lines, labelled C, L, and INIC.
// The x and y axes are shown with purple arrows. The INIC is shown in blue, and the capacitive and inductive
// couplings are shown in black. The trend shows the circuit design for the ST effect. (c) This is a schematic of
// the SS effect. The plot shows a similar unit cell to (b), but with different connections. The trend shows the
// circuit design for the SS effect. (d) This is a schematic of circuit components. The plot shows four different
// circuit diagrams, each with a specific component: C_{1} C_{2}, C_{1} C_{3}, and L_{1} L_{2}. Each diagram
// shows a specific connection of capacitors, resistors, and inductors, with values and labels. The trend shows
// the specific circuit designs for each component.
#figure(
  placement: top,
  image("imgs/fig1.png", width: 100%),
  caption: [The circuit design for the hybrid second-order ST and SS effects. (a) Designed 2D electric circuit network with different values of intra-cell and inter-cell couplings. Each unit cell contains four sublattices $(a, b, c, d)$. The blue lines with arrows represent INICs which can tune nonreciprocity in the circuit and the black lines denote inter-cell capacitive and inductive couplings. (b) and (c) display the circuit unit for the realization of hybrid second-order ST effect and SS effect with $C = 2.2 "nF"$ and $L = 1.5 "uH"$, respectively. Different colors of INIC indicate different values of non-Hermitian coupling. (d) Detail structures of different INICs with $C_1 = 1 "nF"$, $L_1 = 3.3 "uH"$, $R_(-a) = 20 "Ω"$ and $C_(-a) = 1 "uF"$.],
) <fig:1>

As a concrete illustration, and to foreshadow our experimental results, we firstly display the spectrum of our resonant circuit Laplacian for the 2D ST case in Fig. 2(a). While topological localization only causes the appearance of special, non-extensively scaling boundary modes when a boundary appears, the non-Hermitian skin effect is characterized by a modification of the entire spectrum upon opening up a boundary. In the ST case, a small number of topological modes, arranged in the form of a spectral loop (blue), appears when y-boundaries are implemented. When x-boundaries are further introduced, we manifest observe that only these topological modes acquire very different spectral values (green) i.e. undergo the skin effect; the other bulk modes are unchanged by the introduction of either boundary. In particular, there is a ST zero-mode that arises only when the skin effect selectively applies to the topological modes in this manner. This zero mode will contribute massively to the experimentally observed electrical potentials, as further elaborated. By contrast, in Fig. 2(b) the entire spectrum is dramatically altered whether the x-boundary or y-boundary is introduced, indicative of the skin effect in both directions.

We next perform numerical simulations using LTspice. In the calculation, we take $C = 2.2 "nF"$, $C_1 = 1 "nF"$, $C_2 = 820 "pF"$, $C_3 = 390 "pF"$, $L = 1.5 "uH"$, $L_1 = 3.3 "uH"$, $L_2 = 3.9 "uH"$ and $L_3 = 8.2 "uH"$. By appropriate grounding design, the circuit has a same resonance angular frequency $omega_0 = 1"/"sqrt(L C) = 1"/"sqrt(L_1 C_1) = 1"/"sqrt(L_2 C_2) = 1"/"sqrt(L_3 C_3)$. We excite the two circuits in same positions which are red stars in Fig. 2(c) and (d). Actually, points in line 11 are all suitable for exciting. The resulting voltage distribution at the resonance frequency $f_0 = 2.77 "MHz"$ on this electric circuit is presented in Fig. 2(c) and (d) for two cases, respectively. It can be seen clearly in Fig. 2(c) that the large amplitude of voltages can be found at the top left corner and lower right corner. Moreover, the amplitudes on sublattices in unit cell plaquette are unequal. For example, at the top left corner of circuit, only the sublattice $d$ of plaquettes possess large amplitude, and the neighboring sublattices $a$ and $b$ of plaquettes have very small amplitudes. For comparison, at the lower right corner of circuit, only the sublattice $c$ of plaquettes displays large amplitude, and the neighboring sublattices $a$ and $b$ of plaquettes also have very small amplitudes. These unequal distributions at different sublattices indicate that the corner modes stem from the nonreciprocal skin effect on the 1D topological modes along x and y directions. They are locally nonreciprocal from the lack of full destructive interference. Such spontaneous breaking of sublattice symmetry and hence nonreciprocity is generic among topological modes, which gives rise to hybrid ST modes shown in Ref. #cite(<r13>). In Fig. 2(d), the corner modes are indicated by large-amplitude voltages at the lower right corner in the circuit. The voltages at different sublattices of the lower right corner are nearly the same. This is typical second order skin effect which has the similar feature with the 1D skin mode shown in Ref. #cite(<r10>).

// [figvision] imgs/fig2.png
// (a) This is a plot of the spectrum of the resonant circuit Laplacian. The x-axis ranges from -4 to 4 and the
// y-axis from -1 to 1, both without units. Red, blue, and green dots represent the spectrum under double
// periodic, x-periodic and y-open, and double open boundary conditions, respectively. The trend shows that the
// spectrum for double periodic and x-periodic boundary conditions overlap and have an arcing shape, while the
// spectrum for double open boundary conditions is more scattered and has a distinct green line at y=0. (b) This
// is a plot of the spectrum of the resonant circuit Laplacian. The x-axis ranges from -4 to 4 and the y-axis
// from -0.5 to 0.5, both without units. Red, blue, and green dots represent the spectrum under double periodic,
// x-periodic and y-open, and double open boundary conditions, respectively. The trend shows that the spectrum
// for double periodic boundary conditions has many arcs, while the spectrum for x-periodic and y-open and double
// open boundary conditions is limited to the x-axis. (c) This is a schematic of a honeycomb lattice with a red
// star near the center. The lattice has sites labeled a, b, c, and d. The color bar indicates that red sites
// have a higher value (13.5mV) and white sites have a lower value (0.034mV). The trend shows that sites near the
// corners have higher values. (d) This is a schematic of a honeycomb lattice with a red star near the center.
// The lattice has sites labeled a, b, c, and d. The color bar indicates that red sites have a higher value
// (0.3mV) and white sites have a lower value (0.002mV). The trend shows that sites near the corners have
// slightly higher values.
#figure(
  placement: top,
  image("imgs/fig2.png", width: 100%),
  caption: [Simulated results for the hybrid second-order ST and SS effects. (a)-(b) Spectrum of our resonant circuit Laplacian for the ST and SS effects. Red, blue and green dots represent the spectrum of the circuit Laplacian subject to double periodic boundary conditions, x-periodic, y-open boundary conditions, and double open boundary conditions respectively. For hybrid ST effect in (a), when going from double periodic boundaries to y-open boundaries (red to blue), only $1"/"L_(-y)$ of the eigenvalues change drastically, signature of topological boundary modes. When next going from y-open boundaries to double open boundaries (blue to green), only topological eigenvalues in the blue loop morph into the loop interior (undergo the skin effect), but not the majority bulk modes. For SS effect in (b), the spectra in all these three boundary conditions differ completely, signify skin effects from both x and y boundaries. (c) and (d) show the voltage distributions at the resonance frequency for hybrid second-order ST effect and SS effect, respectively. Big arrows in (c) show the directions of skin and topological pumping. Big arrows in (d) show the directions of skin pumping. Red stars are the points of voltage excitation.],
) <fig:2>

// [figvision] imgs/fig3.png
// (a) This is a photograph of a fabricated electric circuit. The main image shows a green circuit board with
// various components, including capacitors, resistors, and inductors. A red polygon highlights a portion of the
// circuit with a 820pF capacitor, a blue polygon outlines another portion with a 390pF capacitor, and an inset
// shows an enlarged view of a unit cell. The image conveys the layout and components of the electric circuit for
// the hybrid second-order ST effect. (b) This is another photograph of a fabricated electric circuit. Similar to
// panel (a), it shows a green circuit board with various components. A red polygon highlights a portion of the
// circuit with a resistor labeled "R_a", and a blue polygon outlines another portion. An inset shows an enlarged
// view of a unit cell. The image conveys the layout and components of the electric circuit for the SS effect.
// (c) This is a plot of the measured voltage distribution at the resonance frequency for the hybrid second-order
// ST effect. The plot is a hexagonal grid with a color bar on the right, ranging from 7.2mV to 16.7mV. The grid
// has points labeled "a", "b", "c", and "d" along the edges, and a point labeled "C" in the center. The plot
// shows a non-uniform voltage distribution across the grid, with higher voltages near the edges. (d) This is a
// plot of the measured voltage distribution at the resonance frequency for the SS effect. The plot is similar to
// panel (c), but with a different color bar ranging from 0.15mV to 0.27mV. The grid has the same labels as panel
// (c). The plot shows a relatively uniform voltage distribution across the grid, with slightly higher voltages
// near the edges.
#figure(
  placement: top,
  image("imgs/fig3.png", width: 100%),
  caption: [The photograph of fabricated sample and experimental results for the hybrid second-order ST effect and SS effect. (a)-(b) The photograph of the fabricated electric circuit for the hybrid second-order ST effect (a) and SS effect (b). The inset presents the enlarged view of the unit cell. (c)-(d) The measured voltage distribution at the resonance frequency for the hybrid second-order ST effect and SS effect in (c) and (d), respectively. Big arrows in (c) show the directions of skin and topological pumping. Big arrows in (d) show the directions of skin pumping.],
) <fig:3>

To experimentally test the theoretical analysis, we fabricate two kinds of electric circuits as shown in Fig. 3(a) and 3(b). The insets in Fig. 3(a) and 3(b) display the circuit structure where INICs and LC elements to achieve intra- and inter-cell couplings are marked, which correspond exactly to the unit cells presented in the above theory. Thus, the circuits in Fig. 3(a) and 3(b) also correspond exactly to the designed structures in Fig. 1. The sample contains 6×6 units and the parameters are the same to the above theoretical designs. It is worthy to note that the tolerance of the circuit elements is only 1% to avoid the detuning of corner resonance. To ensure the effective excitation of the circuit, NI PXle-8840 Quad-Core Embedded Controller is used to tune the excitation amplitude and frequency. Details of the sample fabrication and experimental measurements are provided in Methods.

The measured voltage distributions at the resonance frequency are shown in Fig. 3(c) and 3(d). It is noted that, the dominant voltage signals on sublattices in the unit cell plaquette are similar to the theoretical results shown in Fig. 2(c) and 2(d). The detailed comparisons for theoretical and experimental results are provided in S1 of Supplementary Materials. It is found that the experimental phenomena correspond exactly to the theoretical results, which indicates that the ST and SS modes have been observed successfully in designed circuit systems.

= 3D hybrid skin-topological modes in topolectrical circuits

The above discussions only focus on the 2D cases. In fact, more plentiful hybridizations of topology and nonreciprocity can appear in higher dimensions. In the following, we illustrate two kinds of corner modes in 3D electric circuits. One is caused by the z-directional nonreciprocal pumping (can show hybrid 3D skin-topological-topological (STT) effect), and the other is obtained from the nonreciprocities along x, y and z three directions (can show 3D skin-skin-skin (SSS) effect).

// [figvision] imgs/fig4.png
// Panel (a) is a circuit schematic titled STT effect showing the unit cell of the total circuit. It depicts a
// planar lattice with nodes marked by colored circles: green a at left mid and lower left, blue b at right mid
// and lower right, yellow c at center-right upper and lower, red d at center top and bottom. Elements include
// capacitors labeled C1 and C2 and inductors labeled L1 and L2, drawn as capacitor and coil symbols along
// horizontal and vertical branches. A coordinate axis x y z appears at the upper left. Green and dark green
// shaded rectangular regions outline the unit cell, and the label INIC marks negative impedance converter
// blocks. The layout emphasizes interleaved C1 C2 L1 L2 connections around the four node types. Panel (b) is a
// circuit schematic titled SSS effect showing the unit cell for the 3D SSS corner effect. It uses the same
// component library as panel a, with capacitors C1 C2 and inductors L1 L2 arranged on a rectangular grid.
// Colored node circles are repositioned: green a at left mid and bottom left, blue b at top right and right mid,
// yellow c at center right and bottom center, red d at top center and center bottom. White diagonal link symbols
// and INIC labels indicate active converter blocks connecting nodes. Shaded light and dark green regions define
// the cell boundaries. Coordinate axes x y z are shown at the upper left. The topology differs from panel a by
// placing the red d nodes on horizontal symmetry lines and using angled white connectors, reflecting the SSS
// corner configuration. Panel (c) shows the voltage distribution for the STT effect at resonance frequency. On
// the left, a small wireframe cube labels nodes a b c d e f h, with a red dot at one corner. The main drawing is
// a multi-layer stack of identical planar circuit planes, each populated with horizontal inductor coils and
// vertical connecting lines. Blue arrows trace current paths around the top perimeter and down vertical edges. A
// vertical colorbar on the right scales voltage from 1.1 mV in white to 26.1 mV in red. Small red dots mark
// high-voltage points at the top corners and along vertical edges. The message is strong corner-localized
// voltage enhancement in the hybrid 3D STT configuration. Panel (d) shows the voltage distribution for the SSS
// effect at resonance frequency. On the left, a small wireframe cube has red dots at four vertical corners
// labeled a b c d. The main drawing is again a multi-layer stack of planar circuit planes with horizontal
// inductor coils and vertical interconnects. Blue arrows trace paths along the top edges and downward at the
// sides. A vertical colorbar on the right scales voltage from 0.1 mV in white to 2.57 mV in red, indicating a
// much smaller voltage range than panel c. Red dots mark localized hot spots at corners and edge centers. The
// figure demonstrates weaker but still corner-concentrated voltage distribution characteristic of the 3D SSS
// effect.
#figure(
  placement: top,
  image("imgs/fig4.png", width: 100%),
  caption: [The circuit design and results for the hybrid 3D STT effect and 3D SSS corner effect. (a)-(b) The schematic diagrams for the unit cell of the total circuit with $C_1 = 1 "nF"$, $L_1 = 3.3 "uH"$, $C_2 = 2.2 "nF"$ and $L_2 = 1.5 "uH"$. (a) is for hybrid 3D STT effect and (b) is for 3D SSS effect. The details of INICs are in Fig. 1(d). (c)-(d) The voltage distributions at the resonance frequency for hybrid 3D STT effect and 3D SSS effect in (c) and (d), respectively. Big arrows in (c) show the directions of skin and topological pumping. Big arrows in (d) show the directions of skin pumping.],
) <fig:4>

The corresponding 3D circuit unit cells for two kinds of case are shown in Fig. 4(a) and 4(b), respectively. The unit cells consist of capacitances, inductances and two different kinds of INICs. In the first case (Case I) shown in Fig. 4(a), the 2D layer on the x-y surface corresponds to the 2D topological lattice. To yield the nonreciprocity, the INICs are put along the positive direction of z axis in sublattices $a$ and $b$ of plaquettes, and reversed along the z axis in sublattices $c$ and $d$. For the second case (Case II) shown in Fig. 4(b), the 2D layer on the x-y surface is the same to that in Fig. 1(c). The INICs are all put forward along the positive direction of z axis which also yield the nonreciprocity. For the two kinds of case above, we can derive circuit Laplacian $J_(3D)(omega)$ in the moment space at the resonance frequency based on Kirchhoff's current law. It can be written as

#eqfit(6pt)[
$ J_("STT 3D (SSS 3D)")(omega) &= J_("TT 2D (SS 2D)")(omega) + \
    & i omega mat(delim: "[",
    (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0, 0, 0;
    0, (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0, 0;
    0, 0, (C_1 ± C_2) e^(i q_(-z)) + (C_1 ∓ C_2) e^(-i q_(-z)), 0;
    0, 0, 0, (C_1 ± C_2) e^(i q_(-z)) + (C_1 ∓ C_2) e^(-i q_(-z))
) $ <eq:3>
]

If we choose + in $±$ and – in $∓$ from the matrix above, @eq:3 represents the circuit Laplacian for Case I. Otherwise, it corresponds to Case II. The $J_("TT 2D (SS 2D)")$ represents circuit Laplacian on x-y surface for Case I (Case II), and the remaining term in $J_("STT 3D (SSS 3D)")$ represents the coupling between different layers along the z direction. The detailed derivation can be found in Methods.

Similar to the 2D cases, we can simulate the circuit using LTspice. The results are shown in Fig. 4(c) and 4(d) for Case I and Case II, respectively. The parameters of components are the same to those of the 2D sample. In Fig. 4(c), at the top layer, the large-amplitude voltages appear only at the sublattice $a$ of lower left corner and at the sublattice $b$ of top right corner. At the bottom layer, the large-amplitude voltages appear only at the sublattice $d$ of top left corner and at the sublattice $c$ of lower right corner. The unequal distributions at different sublattices indicate the topological origin of these corner modes, which are realized by stacking 2D layers of 2nd-order Hermitian topological mode. The INICs along the z direction lead to the nonreciprocal skin mode. So these corner modes at top and bottom layers come from the interplay between the topological and nonreciprocal pumping, which gives rise to STT modes described in Ref. #cite(<r13>). In Fig. 4(d), the large-amplitude voltages emerge at the lower right corner of the top layer. Moreover, nearly the same amplitudes of voltages on different sublattices at the lower right corner of the top layer indicate the nonreciprocal origin of these corner modes. In such settings, nonreciprocal pumping leads to accumulation of boundary skin modes along each direction, that is, the appearance of 3D SSS modes. So no matter in 2D or 3D, the corner modes (2D ST and 3D STT modes) induced by both topological and nonreciprocal pumping lead to unequal distributions of voltages on sublattices; for comparison, the corner modes caused by only nonreciprocal pumping bring about the nearly same distributions of voltages on sublattices.

// [figvision] imgs/fig5.png
// Panel (a) is a photograph of the fabricated stacked sample, consisting of about eight green printed circuit
// boards separated by spacers and joined at the corners by vertical copper pillars. Yellow text labels identify
// the copper pillar, an SMP connector on the top layer edge, and the X and Y directions with horizontal arrows
// at lower left, plus the Z direction with vertical arrows at lower right. The boards are aligned vertically to
// form a three-dimensional metamaterial structure. No plot axes are present; the image serves as the physical
// context for the hybrid 3D STT and 3D SSS effects described in the caption. Panel (b) is an enlarged photograph
// of a unit cell labeled STT effect. It shows a green circuit board populated with surface-mount passive
// components. Annotations in orange highlight capacitors C1, C2, and C3, while yellow and green rings mark
// inductors L1 and L2 respectively. A black ring encircles a lower component labeled L2 near the bottom edge. A
// coaxial connector is mounted at the top right. The components are arranged around a central node on the board,
// illustrating the lumped-element circuit that implements the hybrid 3D STT effect. No axes or numerical scales
// are shown. Panel (c) is an enlarged photograph of a unit cell labeled SSS effect. Two black integrated circuit
// chips are mounted side by side on the green board. Red traced paths connect components around the left chip,
// and blue traced paths connect components around the right chip, forming symmetric coupling networks. Small
// capacitors and inductors near the bottom center are ringed in green, with labels such as C3 and L3 visible.
// Board identifiers C505 and C506 appear near the edges, and a connector sits at the top right. The layout
// emphasizes the planar circuit topology for the 3D SSS effect. Panel (d) is a schematic diagram titled STT
// effect depicting a finite 3D cubic lattice of coil-like resonators stacked vertically and connected by posts.
// A vertical color bar on the right maps voltage from 3.23 mV (white) to 20.1 mV (red). Blue double-headed
// arrows indicate the lateral width and vertical height of the cube. Red dots mark selected lattice sites, and
// dashed blue lines outline the lattice boundaries. The figure shows the voltage distribution at the resonance
// frequency, illustrating strong field localization for the hybrid 3D STT effect. Panel (e) is a schematic
// diagram titled SSS effect depicting an analogous finite 3D cubic lattice of coil-like resonators. A vertical
// color bar on the right maps voltage from 1.12 mV (white) to 2.23 mV (red). Blue double-headed arrows mark the
// width and height of the structure, while dashed blue lines denote its boundaries. Red dots highlight specific
// lattice sites, including corners and central positions. The diagram presents the voltage distribution at
// resonance for the 3D SSS effect, showing a lower voltage range and a different spatial pattern than panel (d).
#figure(
  placement: top,
  image("imgs/fig5.png", width: 100%),
  caption: [The photograph of fabricated sample and experimental results for the hybrid 3D STT effect and 3D SSS effect. (a) The photograph of the electric circuit of the 3D SSS corner effect. (b)-(c) The enlarged view of the unit cells for the hybrid 3D STT effect in (b) and the 3D SSS effect in (c). (d)-(e) The voltage distributions at the resonance frequency for hybrid 3D STT effect and 3D SSS effect in (d) and (e), respectively. Big arrows in (c) show the directions of skin and topological pumping. Big arrows in (d) show the directions of skin pumping.],
) <fig:5>

To experimentally observe Case I and Case II, we fabricate two kinds of electric circuits. The photograph image of the fabricated sample is shown in Fig. 5(a). Due to the size limit of the PCB fabrication in the 3D sample, we cut the whole sample into eleven pieces. Six of them are used to describe the interaction on x-y surface of circuit designs, and the remaining five pieces contain the couplings in the circuit designs along the z direction. Details of the z-direction connections are given in S3 of Supplementary Materials. The enlarged views of the unit cell are shown in Fig. 5(b) and 5(c) for Case I and Case II, respectively. It corresponds exactly to the unit cells presented in the theory above. The parameters of electronic components are the same to the theoretical design. Details of the sample fabrication and experimental measurements are given in Methods.

In Fig. 5(d) and 5(e), we plot the measured voltage distributions at the resonance frequency for Case I and Case II, respectively. The dominant voltage signals on sublattices in the unit cell plaquette are similar to the simulation results shown in Fig. 4(c) and 4(d). The detailed comparisons for theoretical and experimental results are provided in S1 of Supplementary Materials. It is seen clearly that the experiment results agree well with the simulation results and the hybrid 3D STT and SSS effects have also been confirmed in circuit experiments.

In summary, we have theoretically designed and experimentally constructed 2D and 3D nonreciprocal topolectric circuits for observing hybrid higher-order topological skin effects for the first time. These hybrid states are not just trivial combinations of skin states and higher-order topological states put together, even though their separate realizations are already achievements in themselves. By direct circuit simulations and voltage measurements, the 2D ST modes and 3D STT modes have not only been demonstrated experimentally, but also the corresponding 2D SS and 3D SSS effects have been found. The qualitative distinction across these modes have been clearly observed from the distribution of voltages in circuits. Our investigations show that the circuits can offer feasible platforms to investigate the exciting interplay of topology and nonreciprocity in high dimensions, which have important applications like topological switching and sensing in non-Hermitian systems.

#v(1em)
#heading(numbering: none)[Methods]

#strong[The Hamiltonian for the lattice model.]

#strong[Hamiltonian for 2D lattice model.] In order to present the correspondence between the electric design in the main text and the lattice model, we provide the lattice Hamiltonian. The details of unit cell are shown in S2(A) of Supplementary Materials. The 2D lattice Hamiltonian can be expressed as

#eqfit(10.6pt)[
$ H_(2D) = sum_((x,y)) & (t_x - delta_1) a^dagger_(x,y) c_(x,y) + (t_x + delta_1) c^dagger_(x,y) a_(x,y) \
  & + (t_x + delta_2) d^dagger_(x,y) b_(x,y) + (t_x - delta_2) b^dagger_(x,y) d_(x,y) \
  & + (t_y + delta_3) a^dagger_(x,y) d_(x,y) + (t_y - delta_3) d^dagger_(x,y) a_(x,y) \
  & + (-t_y - delta_4) b^dagger_(x,y) c_(x,y) + (-t_y + delta_4) c^dagger_(x,y) b_(x,y) \
  & + t' (a^dagger_(x+1,y) c_(x,y) + a_(x+1,y) c^dagger_(x,y) + d^dagger_(x+1,y) b_(x,y) + d_(x+1,y) b^dagger_(x,y)) \
  & + t' (a^dagger_(x,y+1) d_(x,y) + a_(x,y+1) d^dagger_(x,y) - c^dagger_(x,y+1) b_(x,y) - c_(x,y+1) b^dagger_(x,y)) $ <eq:4>
]

Here, the annihilated operator $Lambda_((x,y))$ $(Lambda = a,b,c,d)$ denotes the elimination of one excitation at the sublattice $Lambda$ of the position $(x,y)$ in the lattice, and the generated operator $Lambda^dagger_((x,y))$ $(Lambda = a,b,c,d)$ describes one excitation at the sublattice $Lambda$ of the position $(x,y)$. The coupling strengths between different sublattices are governed by $t_x$, $t_y$, $t'$ and $delta_(i=1,2,3,4)$.

The nonreciprocity in this 2D system depends on the value of the $delta_(-i)$ $(i = 1,2,3,4)$. We can derive the lattice Hamiltonian in the moment space

#eqfit(9pt)[
$ hat(H)_(2D) = sum_(-k) hat(eta)^dagger_(-k) mat(delim: "[",
    0, 0, t_(-x) - delta_1 + t' e^(-i k_(-x)), t_(-y) + delta_3 + t' e^(-i k_(-y));
    0, 0, -t_(-y) - delta_4 - t' e^(i k_(-y)), t_(-x) - delta_2 + t' e^(i k_(-x));
    -t_(-y) + delta_4 - t' e^(-i k_(-y)), 0, 0, t_(-x) + delta_1 + t' e^(i k_(-x));
    t_(-x) + delta_2 + t' e^(-i k_(-x)), 0, 0, 0
) hat(eta)_(-k) $ <eq:5>
]

where $hat(eta)^dagger_(-k) = (hat(a)^dagger_(-k), hat(b)^dagger_(-k), hat(c)^dagger_(-k), hat(d)^dagger_(-k))^T$. When nonreciprocities cancel in both directions $(delta_1 = delta_2, delta_3 = delta_4)$, no skin effect is observed in either direction. But, skin modes are still observed when OBCs are taken in both directions. We thus obtain hybrid skin-topological modes. Such lattice Hamiltonian shows the first-order topological modes when we take open and periodic boundary condition at x and y directions, respectively. Each topological mode mainly locates at two of four sublattices along the boundary, and the local nonreciprocity among these two sublattices can affect the distributions of boundary modes when both directions are open.

When nonreciprocities along both directions of each plaquette do not destructively interfere $(delta_1 != delta_2, delta_3 != delta_4)$, we obtain SS modes.

#strong[Hamiltonian for 3D lattice model.] In our description of Fig. 4(a) and 4(b), the 3D electrical architectures are stacked by 2D electric boards. These 3D electric circuits have the one-to-one correspondence to the lattices models. Here, we provide how to realize these 3D lattices by stacking 2D layers of lattices. The details of unit cell are shown in S2(B) of Supplementary Materials. The Hamiltonians for each 2D layers can be attributed to @eq:4 above. Since different 2D layers are connected, the total Hamiltonian for such 3D lattice is

#eqfit(7pt)[
$ H_(3D) = sum_((x,y,z)) & H^(-z)_(2D) \
  & + (t_(-a) + delta_(-a)) a^dagger_((x,y,z+1)) a_((x,y,z)) + (t_(-a) - delta_(-a)) a_((x,y,z+1)) a^dagger_((x,y,z)) \
  & + (t_(-b) + delta_(-b)) b^dagger_((x,y,z+1)) b_((x,y,z)) + (t_(-b) - delta_(-b)) b_((x,y,z+1)) b^dagger_((x,y,z)) \
  & + (t_(-c) + delta_(-c)) c^dagger_((x,y,z+1)) c_((x,y,z)) + (t_(-c) - delta_(-c)) c_((x,y,z+1)) c^dagger_((x,y,z)) \
  & + (t_(-d) + delta_(-d)) d^dagger_((x,y,z+1)) d_((x,y,z)) + (t_(-d) - delta_(-d)) d_((x,y,z+1)) d^dagger_((x,y,z)) $ <eq:6>
]

Here, the annihilated operator $Lambda_((x,y,z))$ $(Lambda = a,b,c,d)$ denotes the elimination of one excitation at the sublattice $Lambda$ of the position $(x,y,z)$ in the lattice, and the generated operator $Lambda^dagger_((x,y,z))$ $(Lambda = a,b,c,d)$ describes that one excitation at the sublattice $Lambda$ of the position $(x,y,z)$. We can derive the lattice Hamiltonian in the moment space. The lattice Hamiltonian can be expressed as

#eqfit(5.5pt)[
$ hat(H)_(3D) = sum_(-k) hat(eta)^dagger_(-k) mat(delim: "[",
    (t_(-a) - delta_(-a)) e^(i q_(-z)) + (t_(-a) + delta_(-a)) e^(-q_(-z)), 0, t_(-x) - delta_1 + t' e^(-i k_(-x)), t_(-y) + delta_3 + t' e^(-i k_(-y));
    0, (t_(-b) - delta_(-b)) e^(i q_(-z)) + (t_(-b) + delta_(-b)) e^(-q_(-z)), -t_(-y) - delta_4 - t' e^(i k_(-y)), t_(-x) - delta_2 + t' e^(i k_(-x));
    t_(-x) + delta_1 + t' e^(i k_(-x)), -t_(-y) + delta_4 - t' e^(-i k_(-y)), (t_(-c) - delta_(-c)) e^(i q_(-z)) + (t_(-c) + delta_(-c)) e^(-q_(-z)), 0;
    t_(-y) - delta_3 + t' e^(i k_(-y)), t_(-x) + delta_2 + t' e^(-i k_(-x)), 0, (t_(-d) - delta_(-d)) e^(i q_(-z)) + (t_(-d) + delta_(-d)) e^(-q_(-z))
) hat(eta)_(-k) $ <eq:7>
]

The sublattices at the neighboring layers are connected by the coupling strengths $t_j ± delta_j$ $(j = a,b,c,d)$ where $delta_(j=a,b,c,d)$ indicates the nonreciprocity along z-direction of system.

#strong[Theoretical model of the designed electric circuits.]

#strong[Circuit Laplacian for 2D electric circuit.] Here, we focus on the correspondence between the non-Hermitian lattice model and our designed electric circuits. According to the Kirchhoff's law, the relation between the node alternating current and voltage should satisfy the following equation:

$ I_(-alpha) = i omega^(-1) "[" - sum_(-beta) (V_(-alpha) - V_(-beta)) / L_(-alpha beta) + omega V_(-alpha) C_(-alpha) + sum_(-gamma) C_(-alpha gamma) omega (2 V_(-alpha) - V_(-gamma)) "]" $ <eq:8>

where $I_(-alpha)$ and $V_(-alpha)$ are the net current and voltage of node $alpha$ with angular frequency being $omega$. $L_(-alpha beta)$ is the inductance between node $alpha$ and node $beta$. $C_(-alpha)$ is the ground capacitance at node $alpha$. $C_(-alpha gamma)$ is the capacitance between node $alpha$ and node $gamma$. The summation is taken over all nodes, which are connected to node $alpha$ through an inductor or a capacitor.

As we can see in Fig. 1(a)-(c), each unit cell possesses four nodes. In this case, the voltage and current at the site $alpha$ should be registered as $V_(-alpha)$ $(alpha = a,b,c,d)$ and $I_(-alpha)$ $(alpha = a,b,c,d)$. Additionally, each site is connected with other sites through three kinds of coupling: intra-cell couplings ($C_1$ or $L_1$), inter-cell couplings ($C$ or $L$), non-Hermitian couplings (INIC). Also, each site is grounded through capacitances and inductances to guarantee the resonance frequency. Details of the grounding part is provided in the S4 of the Supplementary Materials.

Here, based on the Kirchhoff's law, we give the details of realizing the electric design to observe the SS mode in Fig. 1(c). Consider the model shown in S2(C) of Supplementary Materials, there are voltages $V_(-a) - V_(-d)$ at the four nodes and currents $I_1 - I_8$ at the circuit branches. Using the Kirchhoff's current formula, we have

$ I_3 + I_8 &= I_6 e^(-i q_(-x)) + I_1 e^(-i q_(-y)) + G_(-a) \
  I_2 + I_5 &= I_4 + I_7 + G_(-b) \
  I_4 + I_6 &= I_8 + I_2 e^(-i q_(-y)) + G_(-c) \
  I_1 + I_7 &= I_3 + I_5 e^(-i q_(-x)) + G_(-d) $ <eq:9>

where $G_(-i)$ $(i = a,b,c,d)$ is grounding part, $q_(-x)$ and $q_(-y)$ denote the phase of Block wave vector propagating in the x and y directions, respectively. So we can write the currents that flow into each node as,

#eqfit(6.5pt)[
$ I_(-a) = i omega^(-1) "[" &- omega^2 V_(-a)^(x,y) (C_3 - 2/(omega^2 L_1) - 1/(omega^2 L_2) - 2/(omega^2 L)) + omega^2 (C_1 - C_3)(V_(-c)^(x,y) - V_(-a)^(x,y)) + omega^2 (C_1 + C_2)(V_(-d)^(x,y) - V_(-a)^(x,y)) \ &+ omega^2 C (V_(-d)^(x,y+1) - V_(-a)^(x,y)) + omega^2 C (V_(-c)^(x+1,y) - V_(-a)^(x,y)) "]" \
I_(-b) = i omega^(-1) "[" &- (V_(-b)^(x,y) - V_(-a)^(x,y))/L_1 + (V_(-c)^(x,y) - V_(-b)^(x,y))/L_2 - (V_(-c)^(x,y-1) - V_(-b)^(x,y))/L - omega^2 V_(-b)^(x,y) (-1/(omega^2 L_3) - 1/(omega^2 L_2)) \ &+ (C_1 + C_3) omega^2 (V_(-d)^(x,y) - V_(-b)^(x,y)) + C omega^2 (V_(-d)^(x-1,y) - V_(-b)^(x,y)) "]" \
I_(-c) = i omega^(-1) "[" &- (V_(-b)^(x,y) - V_(-c)^(x,y))/L_1 - (V_(-b)^(x,y) - V_(-c)^(x,y))/L_2 - (V_(-b)^(x,y+1) - V_(-c)^(x,y))/L - omega^2 V_(-c)^(x,y) (-1/(omega^2 L_3) - 1/(omega^2 L_2)) \ &+ (C_1 + C_3) omega^2 (V_(-a)^(x,y) - V_(-c)^(x,y)) + C omega^2 (V_(-a)^(x-1,y) - V_(-c)^(x,y)) "]" \
I_(-d) = i omega^(-1) "[" &- omega^2 V_(-d)^(x,y) (-2/(omega^2 L_1) - 2/(omega^2 L) + C_2 + C_3) + (C_1 - C_2) omega^2 (V_(-a)^(x,y) - V_(-d)^(x,y)) + C omega^2 (V_(-a)^(x,y-1) - V_(-d)^(x,y)) \ &+ C omega^2 (V_(-b)^(x+1,y) - V_(-d)^(x,y)) + (C_1 - C_3) omega^2 (V_(-b)^(x,y) - V_(-d)^(x,y)) "]" $ <eq:10>
]

According to the circuit Laplacian $J(omega)$, we can write @eq:10 in the form below,

$ mat(delim: "[", I_(-a); I_(-b); I_(-c); I_(-d)) = J mat(delim: "[", V_(-a)^(x,y); V_(-b)^(x,y); V_(-c)^(x,y); V_(-d)^(x,y)) $ <eq:11>

The circuit Laplacian matrix $J(omega)$ for SS mode can be expressed as:

#eqfit(6pt)[
$ J_("SS 2D")(omega) = i omega mat(delim: "[",
    2/(omega^2 L_1) + 2/(omega^2 L_2) + 2/(omega^2 L) - 2C_1 - C_2 - 2C, 0, C_1 - C_3 + C e^(-i q_(-x)), C_1 + C_2 + C e^(-i q_(-y));
    0, 1/(omega^2 L_1) + 1/(omega^2 L_2) + 1/(omega^2 L) - C_1 - C_3 - C, -1/(omega^2 L_1) + 1/(omega^2 L_2) - e^(i q_(-y))/(omega^2 L), C_1 + C_3 + C e^(i q_(-x));
    C_1 + C_3 + C e^(i q_(-x)), -1/(omega^2 L_1) - 1/(omega^2 L_2) - e^(-i q_(-y))/(omega^2 L), 1/(omega^2 L_1) + 1/(omega^2 L_2) + 1/(omega^2 L) - C_1 - C_3 - C, 0;
    C_1 - C_2 + C e^(i q_(-y)), C_1 - C_3 + C e^(-i q_(-x)), 0, 2/(omega^2 L_1) + 2/(omega^2 L) - 2C_1 - 2C
) $ <eq:12>
]

For the hybrid second-order ST mode, with $H_0 = (2,1) - (2,-1) - (2,-2) - (2,-3)$, the circuit Laplacian $J_(2D)(omega)$ can be expressed as

#eqfit(9pt)[
$ J_(2D)(omega) = i omega mat(delim: "[",
    0, 0, C_1 - C_3 + C e^(-i q_(-x)), C_1 ± C_2 + C e^(-i q_(-y));
    0, 0, -C_1 + C_2 - C e^(i q_(-x)), C_1 ± C_3 + C e^(i q_(-y));
    C_1 + C_3 + C e^(i q_(-x)), -C_1 + C_2 - C e^(-i q_(-y)), 0, 0;
    C_1 ∓ C_2 + C e^(i q_(-x)), C_1 ∓ C_3 + C e^(-i q_(-y)), 0, 0
) $ <eq:13>
]

If we choose – in $±$ and + in $∓$, @eq:13 represents the circuit Laplacian for the case where the hybrid second-order ST effect can be shown. Otherwise, it corresponds to the case that can show the SS effect. @eq:13 is @eq:2 in the main text of the paper. It is similar to theoretical design shown in @eq:5.

#strong[Circuit Laplacian for 3D electric circuit.] As for our 3D circuit, each unit cell possesses four nodes ($a$, $b$, $c$ and $d$). We need to consider the coupling in z direction. Here, based on the Kirchhoff's law, we provide the details of electric design to observe the SSS mode. In this case, the Kirchhoff equation on each site can be expressed as:

#eqfit(6.5pt)[
$ I_(-a) = i omega^(-1) "[" &- omega^2 V_(-a)^(x,y,z) (C_3 - 4/(omega^2 L_1) - 1/(omega^2 L_2) - 2/(omega^2 L)) + omega^2 (C_1 - C_3)(V_(-c)^(x,y,z) - V_(-a)^(x,y,z)) \ &+ omega^2 (C_1 + C_2)(V_(-d)^(x,y,z) - V_(-a)^(x,y,z)) + omega^2 C (V_(-d)^(x+1,y,z) - V_(-a)^(x,y,z)) + omega^2 C (V_(-c)^(x+1,y,z) - V_(-a)^(x,y,z)) \ &+ omega^2 (C_1 - C_2)(V_(-a)^(x,y,z-1) - V_(-a)^(x,y,z)) + omega^2 (C_1 + C_2)(V_(-a)^(x,y,z+1) - V_(-a)^(x,y,z)) "]" \
I_(-b) = i omega^(-1) "[" &- (V_(-c)^(x,y,z) - V_(-b)^(x,y,z))/L_1 - (V_(-c)^(x,y,z) - V_(-b)^(x,y,z))/L_2 - (V_(-c)^(x,y-1,z) - V_(-b)^(x,y,z))/L \ &- omega^2 V_(-b)^(x,y,z) (-2/(omega^2 L_1) - 1/(omega^2 L_3) - 1/(omega^2 L_2)) + (C_1 + C_3) omega^2 (V_(-d)^(x,y,z) - V_(-b)^(x,y,z)) \ &+ C omega^2 (V_(-d)^(x-1,y,z) - V_(-b)^(x,y,z)) + omega^2 (C_1 - C_2)(V_(-b)^(x,y,z-1) - V_(-b)^(x,y,z)) + omega^2 (C_1 + C_2)(V_(-b)^(x,y,z+1) - V_(-b)^(x,y,z)) "]" \
I_(-c) = i omega^(-1) "[" &- (V_(-b)^(x,y,z) - V_(-c)^(x,y,z))/L_1 + (V_(-b)^(x,y,z) - V_(-c)^(x,y,z))/L_2 - (V_(-b)^(x-1,y,z) - V_(-c)^(x,y,z))/L \ &- omega^2 V_(-c)^(x,y,z) (-2/(omega^2 L_1) - 1/(omega^2 L_3) - 1/(omega^2 L_2)) + (C_1 + C_3) omega^2 (V_(-a)^(x,y,z) - V_(-c)^(x,y,z)) \ &+ C omega^2 (V_(-a)^(x-1,y,z) - V_(-c)^(x,y,z)) + omega^2 (C_1 - C_2)(V_(-c)^(x,y,z-1) - V_(-c)^(x,y,z)) + omega^2 (C_1 - C_2)(V_(-c)^(x,y,z+1) - V_(-c)^(x,y,z)) "]" \
I_(-d) = i omega^(-1) "[" &- omega^2 V_(-d)^(x,y,z) (-4/(omega^2 L_1) - 2/(omega^2 L) + C_2 + C_3) + (C_1 - C_2) omega^2 (V_(-a)^(x,y,z) - V_(-d)^(x,y,z)) \ &+ C omega^2 (V_(-a)^(x,y-1,z) - V_(-d)^(x,y,z)) + C omega^2 (V_(-b)^(x+1,y,z) - V_(-d)^(x,y,z)) + (C_1 - C_3) omega^2 (V_(-b)^(x,y,z) - V_(-d)^(x,y,z)) \ &+ omega^2 (C_1 + C_2)(V_(-d)^(x,y,z-1) - V_(-d)^(x,y,z)) + omega^2 (C_1 + C_2)(V_(-d)^(x,y,z+1) - V_(-d)^(x,y,z)) "]" $ <eq:14>
]

The circuit Laplacian $J(omega)$ for the 3D SSS mode can be expressed as

#eqfit(6.5pt)[
$ J_("SSS 3D")(omega) = i omega mat(delim: "[",
    A_1, 0, C_1 - C_3 + C e^(-i q_(-x)), C_1 + C_2 + C e^(-i q_(-y));
    0, A_2, -1/(omega^2 L_1) - 1/(omega^2 L_2) - e^(i q_(-y))/(omega^2 L), C_1 + C_3 + C e^(i q_(-x));
    C_1 + C_3 + C e^(i q_(-x)), -1/(omega^2 L_1) + 1/(omega^2 L_2) - e^(-i q_(-y))/(omega^2 L), A_3, 0;
    C_1 - C_2 + C e^(i q_(-y)), C_1 - C_3 + C e^(-i q_(-x)), 0, A_4
) $ <eq:15>
]

with

#[
  #set math.equation(numbering: none)
  $ A_1 = 4/(omega^2 L_1) + 1/(omega^2 L_2) + 2/(omega^2 L) - 4C_1 - C_2 - 2C + (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)) $
  $ A_2 = A_3 = 1/(omega^2 L_3) + 3/(omega^2 L_1) + 1/(omega^2 L) - 3C_1 - C_3 - C + (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)) $
  $ A_4 = 4/(omega^2 L_1) + 2/(omega^2 L) - 4C_1 - 2C + (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)) $
]

When the electrical components satisfy $omega = omega_0 = (L C)^(-1/2) = (L_1 C_1)^(-1/2) = (L_2 C_2)^(-1/2) = (L_3 C_3)^(-1/2)$, Eq. (15) becomes,

#eqfit(5.5pt)[
$ J_("SSS 3D")(omega) = i omega mat(delim: "[",
    (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0, C_1 - C_3 + C e^(-i q_(-x)), C_1 + C_2 + C e^(-i q_(-y));
    0, (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), -C_1 - C_2 - C e^(i q_(-y)), C_1 + C_3 + C e^(i q_(-x));
    C_1 + C_3 + C e^(i q_(-x)), -C_1 + C_2 - C e^(-i q_(-y)), (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0;
    C_1 - C_2 + C e^(i q_(-y)), C_1 - C_3 + C e^(-i q_(-x)), 0, (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z))
) $ <eq:16>
]

The diagonal elements in the matrix (@eq:16) represent the coupling along z direction, and the off-diagonal elements in the matrix denote the coupling on the x-y surface. It is clearly visible that the nonreciprocities appear along x, y and z directions. Following the similar construction, we can get $J_("STT 3D")(omega)$ as

#eqfit(5.5pt)[
$ J_("STT 3D")(omega) = i omega mat(delim: "[",
    (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0, C_1 + C e^(-i q_(-x)), C_1 + C e^(-i q_(-y));
    0, (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), -C_1 - C e^(i q_(-y)), C_1 + C e^(i q_(-x));
    C_1 + C e^(i q_(-x)), -C_1 - C e^(-i q_(-y)), (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0;
    C_1 + C e^(i q_(-y)), C_1 + C e^(-i q_(-x)), 0, (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z))
) $ <eq:17>
]

The circuit Laplacian matrix $J_(3D)(omega)$ can be expressed as

#eqfit(5.5pt)[
$ J_("STT 3D (SSS 3D)")(omega) &= J_("TT 2D (SS 2D)")(omega) +     & i omega mat(delim: "[",
    (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0, 0, 0;
    0, (C_1 - C_2) e^(i q_(-z)) + (C_1 + C_2) e^(-i q_(-z)), 0, 0;
    0, 0, (C_1 ± C_2) e^(i q_(-z)) + (C_1 ∓ C_2) e^(-i q_(-z)), 0;
    0, 0, 0, (C_1 ± C_2) e^(i q_(-z)) + (C_1 ∓ C_2) e^(-i q_(-z))
) $ <eq:18>
]

$ J_("TT 2D")(omega) = i omega mat(delim: "[",
    0, 0, C_1 + C e^(-i q_(-x)), C_1 + C e^(-i q_(-y));
    0, 0, -C_1 - C e^(i q_(-y)), C_1 + C e^(i q_(-x));
    C_1 + C e^(i q_(-x)), -C_1 - C e^(-i q_(-y)), 0, 0;
    C_1 + C e^(i q_(-y)), C_1 + C e^(-i q_(-x)), 0, 0
) $ <eq:19>

If we choose + in $±$ and - in $∓$, @eq:18 represents the circuit Laplacian for Case I. Otherwise, it corresponds to Case II. It is @eq:3 in the main text of the paper. It is similar to theoretical design shown in @eq:7. As revealed in this matrix @eq:18, for $J_("STT 3D")(omega)$, the nonreciprocity only emerges in the diagonal elements containing $q_(-z)$. It will bring about the corner modes driven unbalanced along z direction (this is shown in Fig. 4 and Fig. 5 of the main text). Based on the consistence for the mathematical formula, it is straightforward to infer that we can implement the hybrid 3D STT effect and 3D SSS effect by using our designed electric circuits.

#strong[Sample fabrications and circuit measurements.] We exploit the electric circuits by using PADs program software, where the PCB composition, stackup layout, internal layer and grounding design are suitably engineered. Here, each well-designed PCB possesses totally eight layers to arrange the complex conductor. It is worthy to note that the ground layer should be placed in the gap between any two layers to avoid their coupling. Moreover, all PCB traces have a relatively large width (0.5mm) to reduce the parasitic inductance and the spacing between electronic devices is also large enough (1.0mm) to avert spurious inductive coupling. On the other hand, due to the size limit of the PCB fabrication in 3D sample, we cut the whole sample into eleven pieces. Six pieces are used to display the couplings along x and y directions and the remaining five pieces for the z direction. To ensure the same grounding condition, we link the copper pillar of each sub-PCB together. As for the circuit excitation, we use NI PXle-8840 Quad-Core Embedded Controller to input 2.77MHz alternating current. SMP connectors are welded on the PCB for the signal input and circuit measurement. Photo to show connections in the z direction is shown in S3 of Supplementary Materials. Four sublattices ($a$, $b$, $c$, $d$) represent four INICs which connect corresponding points between two x-y layers. DB9 connectors are used to connect the INICs between each two x-y layers. Lots of external wires are used for DB9 connectors. So we need to use wires with low impedance. Besides, we need to disorganize the wires to avoid parallel interference between wires. What’s more, the total 3D circuit is a large sample, we need to use enough voltage inputs to guarantee the work of INICs.

#v(0.6em)
#strong[Data availability.] Any related experimental background information not mentioned in the text and other findings of this study are available from the corresponding author upon reasonable request.

#v(0.6em)
#strong[Acknowledgements.] This work was supported by the National key R & D Program of China under Grant No. 2017YFA0303800, the National Natural Science Foundation of China (91850205) and C. H. Lee acknowledges support from Singapore MOE Tier I grant WBS: R-144-000-435-133.

#v(0.6em)
#strong[Author contributions.] D.Y. Z. and T. C. provided the theory with the help of C.H. L., D.Y. Z. performed the experiments with the help of W.J. H., J. C. B. and H. J. S., X.D. Z. initiated and designed this research project.

#v(0.6em)
#strong[Competing interests.] The authors declare no competing interests.

#v(1.2em)
#show bibliography: set text(size: 10pt)
#show bibliography: set par(spacing: 0.55em, leading: 1.15em)
#bibliography("refs.bib", style: "nature.csl", title: [References])

#pagebreak()
#align(center)[#text(size: 12pt, weight: "bold")[SUPPLEMENTARY MATERIALS]]
#counter(figure.where(kind: image)).update(0)
#set figure(numbering: n => text(weight: "bold", "S" + str(n)))

#strong[S1. The detailed comparisons for theoretical and experimental results]

In this part, we provided detailed comparisons for theoretical and experimental results in both 2D and 3D circuits. The 2D results are shown in Fig. S1. We can see that in Fig. S1(a), voltages along right and left edges in both theoretical and experimental results are topological SSH localization. By contrast, the voltages in Fig. S1(b) are skin localization. Besides, theoretical and experimental results in ST and SS effect toward the same trend.

// [figvision] imgs/figS1.png
// Panel (a) is a line plot titled ST effect with Node Voltage Vy on the vertical axis from 0 to 1 and Y on the
// horizontal axis from 1 to 12. Solid lines are experimental results and dotted lines are theoretical results.
// Blue represents the left edge, red the right edge, and black the bulk. The blue experimental line oscillates
// sharply between zero and roughly 0.45, while the blue theoretical line starts near 1, decays to a plateau
// around 0.45, then declines toward 0.35. The red experimental line remains low before climbing steeply after Y
// equals 10 to reach 1 at Y equals 12; the red theoretical line rises more smoothly to the same endpoint. Black
// lines stay near 0.1 to 0.2 throughout. The ST effect localises voltage changes to opposing edges with strong
// experimental oscillations not present in theory. Panel (b) is a line plot titled SS effect with Node Voltage
// Vy from 0 to 1 on the vertical axis and Y from 1 to 12 on the horizontal axis. Solid lines indicate
// experimental data and dotted lines indicate theory, with blue for left edge, red for right edge, and black for
// bulk. All series remain low, mostly below 0.2, from Y equals 1 to about 10. Blue lines fluctuate mildly around
// 0.1 to 0.2, while black bulk lines stay near 0.1 to 0.3. The red right edge curves stay flat near 0.1 until
// about Y equals 10, then both experimental and theoretical lines rise sharply together to reach 1 at Y equals
// 12. Unlike panel (a), there are no large interior oscillations; the SS effect is weak in the bulk and
// localised to the final right-edge boundary.
#figure(placement: top, 
    image("imgs/figS1.png", width: 100%),
  caption: [The direct comparison for 2D theoretical and experimental results. Solid lines represent experimental results and dotted line represent theoretical results. (a) Comparison for ST theoretical and experimental results. (b) Comparison for SS theoretical and experimental results. Blue, red and black solid lines represent experimental voltage change along left edge, right edge, and average of bulk voltages in Fig. 3(c) and (d), respectively. Blue, red and black dotted lines represent theoretical voltage change along left edge, right edge, and average of bulk voltages in Fig. 2(c) and (d), respectively.],
) <fig:S1>

The 3D results are shown in Fig. S2. We can see that in Fig. S2(a), voltages in both theoretical and experimental results are topological SSH localization. By contrast, the voltages in Fig. S2(b) are skin localization. Besides, theoretical and experimental results in STT and SSS effect toward the same trend. The results mean that the experimental phenomena correspond exactly to the theoretical results, which indicates that the modes in 2D and 3D have been observed successfully in designed circuit systems.

// [figvision] imgs/figS2.png
// (a) This plot compares theoretical and experimental results for STT. The y-axis is Node Voltage, ranging from
// 0 to 1, and the x-axis is Node, numbered 0 to 12. Solid lines represent experimental results and dotted lines
// represent theoretical results. There are multiple series in red and blue, with different line styles. The
// experimental results show a more jagged trend, while the theoretical results show a smoother trend. The plot
// shows that the experimental and theoretical results have some similarities but also some discrepancies. (b)
// This plot compares theoretical and experimental results for SSS. The y-axis is Node Voltage, ranging from 0 to
// 1, and the x-axis is Node, numbered 0 to 12. Solid lines represent experimental results and dotted lines
// represent theoretical results. There are multiple series in red, blue and black, with different line styles.
// The experimental results show a generally increasing trend, while the theoretical results show a more variable
// trend. The plot shows that the experimental and theoretical results have some similarities but also some
// discrepancies. (c) This schematic shows the color coding for the solid lines in panel (a). It appears to be a
// diagram of a series of connected nodes or circles, with a red line and a blue line running through them. The
// nodes are numbered from 1 to 12, and there are multiple rows of nodes. The red and blue lines correspond to
// specific series in panel (a). (d) This schematic shows the color coding for the solid lines in panel (b). It
// appears to be a similar diagram to panel (c), but with a different layout and a red line, blue line and black
// line running through the nodes. The nodes are again numbered from 1 to 12, and there are multiple rows of
// nodes. The lines correspond to specific series in panel (b).
#figure(
  placement: top,
  image("imgs/figS2.png", width: 100%),
  caption: [The directly comparison for 3D theoretical and experimental results. Solid lines represent experimental results and dotted line represent theoretical results. (a) Comparison for STT theoretical and experimental results. (b) Comparison for SSS theoretical and experimental results. (c)-(d) show the corresponding colors for solid lines in (a) and (b), respectively.],
) <fig:S2>

#strong[S2. Figures for the method.]

#strong[A. Figure for 2D lattice model.] In order to present the correspondence between the electric design in the main text and the lattice model, we provide the lattice Hamiltonian in Fig. S3. The green, blue, yellow and red spheres represent the sublattice $a$, $b$, $c$ and $d$ within unit cell plaquette. The details of unit cell are shown in Fig. S3.

// [figvision] imgs/figS3.png
// This schematic depicts the unit cell of a 2D lattice model on a pale peach background. Four coloured circular
// sublattices occupy the corners: green a at lower left, red d at upper left, light blue b at upper right, and
// yellow c at lower right. Asymmetric intra-cell coupling is shown by paired horizontal arrows: between d and b,
// a dark brown rightward arrow labeled t_x − δ_2 lies above an orange leftward arrow labeled t_x + δ_2; between
// a and c, a dark brown leftward arrow labeled t_x − δ_1 lies above an orange rightward arrow labeled t_x + δ_1.
// Vertical intra-cell couplings on the left and right use opposing dark brown and orange arrows with t_y and δ_3
// or δ_4 labels. Blue inter-cell lines extend outward: solid vertical t′ from d, solid horizontal t′ from b and
// c, and dashed vertical −t′ from b.
#figure(
  placement: top,
  image("imgs/figS3.png", width: 50%),
  caption: [The unit cell for the 2D lattice model. Each unit cell contains four sublattices $(a, b, c, d)$. The brown and black lines with arrows represent asymmetric intra-cell coupling and the blue lines denote inter-cell coupling. This tight-binding model can demonstrate both hybrid second-order ST effect and SS effect with different values of $delta_(-i)$ $(i = 1,2,3,4)$.],
) <fig:S3>

#strong[B. Figure for 3D lattice model.] These 3D electric circuits have the one-to-one correspondence to the lattices models. Here, we provide how to realize these 3D lattices by stacking 2D layers of lattices. The details of unit cell are shown in Fig. S4.

// [figvision] imgs/figS4.png
// The figure shows a schematic diagram of a 3D lattice model. The plot is a 2D representation of the lattice
// structure with no axes shown, no units, and no numerical ranges. There are four series of circles with
// different colors: green (a), yellow (b and c), and red (d), representing different sublattices. The brown and
// black lines with arrows represent asymmetric intra-cell coupling, blue lines denote inter-cell coupling, and
// red lines with arrows represent asymmetric z-direction coupling. Each unit cell contains four sublattices (a,
// b, c, d). The trend or message is that this tight-binding model can demonstrate both hybrid 3D STT effect and
// 3D SSS effect.
#figure(
  placement: top,
  image("imgs/figS4.png", width: 58%),
  caption: [The diagram for the 3D lattice model. We can see that each unit cell contains four sublattices $(a, b, c, d)$. The brown and black lines with arrows represent asymmetric intra-cell coupling and the blue lines denote inter-cell coupling. The red lines with arrows represent asymmetric z direction coupling. This tight-binding model can demonstrate both hybrid 3D STT effect and 3D SSS effect with different value of $delta_(-i)$ $(i = 1,2,3,4, a, b, c, d)$.],
) <fig:S4>

#strong[C. Figure for deriving circuit Laplacian in 2D electric circuit.] Fig. S5 shows the model of unit cell for realizing the electric design to observe the SS mode in Fig. 1(c). There are voltages $V_(-a) - V_(-d)$ at the four nodes and currents $I_1 - I_8$ at the circuit branches.

// [figvision] imgs/figS5.png
// The figure shows a schematic diagram of a proposed circuit to observe SS mode. The diagram has no axes. It
// features several objects: capacitors (C), inductors (L), and conductances (Gd, Ga, Gb, Gc) labeled in red,
// with Gd at top left, Ga at bottom left, Gb at top right, and Gc at bottom right. The objects are connected by
// lines representing currents I1 through I8, with I1, I3, I7, and I8 in green, I2, I4, I5, and I6 in blue, and
// I3 in red. Arrows indicate the direction of currents. Nodes are labeled a, b, c, and d. The trend or message
// is the layout and connections of the circuit components to facilitate SS mode observation.
#figure(
  placement: top,
  image("imgs/figS5.png", width: 42%),
  caption: [The unit cell of proposed circuits to observe SS mode. The arrows mark the direction of currents.],
) <fig:S5>

#strong[S3. Sample fabrications in the z direction.] In this part, we show the details of the fabricated z-direction components for the 3D sample. The photograph are shown in Fig. S6. The right photograph shows the total INICs between two layers. The inset presents z-direction INICs in a unit cell.

// [figvision] imgs/figS6.png
// The figure has two panels, a and b. Panel a is a photograph of a green circuit board with various components.
// The board has a DB9 connector, labeled in yellow text with a black arrow pointing to it. Four circles, colored
// red, blue, yellow, and another red, highlight areas with z-direction INICs, labeled a, b, c, and d. These
// INICs connect points between two x-y layers. The board has various small components, including chips and
// resistors, and light green lines indicating connections between them. Panel b is a larger image of the same
// circuit board, showing a 3x6 grid of identical sections. Each section has a DB9 connector and several small
// components, including chips and resistors. The sections are connected by light green lines. The image has text
// in the top-right corner, "skin3D2_link". The trend or message is to show the layout and connections of the
// fabricated z-direction components for a 3D sample.
#figure(
  placement: top,
  image("imgs/figS6.png", width: 100%),
  caption: [The photograph of the fabricated z-direction components for the 3D sample. The inset presents the enlarged view. Four circles with different colors show z-direction INICs which connect corresponding points $a$, $b$, $c$ and $d$ between two x-y layers. We use DB9 to connect z-direction INIC with the upper and lower layers.],
) <fig:S6>

#strong[S4. Grounding of the finite electric circuit.] To fulfill the lattice Hamiltonian by a topolectrical circuit Laplacian, we need to choose the suitable grounding to eliminate the diagonal elements of open circuit Laplacian at the resonant frequency. This can be easily realized by making the inductivities and capacitances enter the circuit Laplacian with opposite sign, that is,

// Supplement equations are numbered (S1), (S2), … in the published paper: restart the
// equation counter and switch the numbering callback to the "S" prefixed form.
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(S" + str(n) + ")", supplement: [Eq.])
$ J(omega) = i omega C - i/(omega L) $ <eq:S1>

Hence, the contribution of inductivities (capacitances) at the fix node can be cancelled by grounding matched capacitances (inductivities). We present the grounding patterns in Tables 1-4, which correspond to the actual sample.

#v(0.4em)
#image("imgs/tables123_new.png", width: 100%)
#v(0.4em)
#image("imgs/table4a.png", width: 100%)
#v(0.4em)
#image("imgs/table4b.png", width: 100%)
#v(0.2em)
#text(size: 10pt)[Table.4]
#v(0.4em)

#block[#set text(size: 10pt)
  #set par(first-line-indent: 0pt, justify: true)
  Table.1 is grounding part for SS effect. Table.2 is grounding part for hybrid second-order ST effect. Table.3 is grounding part for 3D SSS effect. Table.4 is grounding part for hybrid 3D STT effect. As we mentioned above, the whole 3D sample is divided to eleven layers. Only six layers have grounding parts. The end, mid and top are for the end layer, mid 2-4 layers and top layer, respectively.
]

