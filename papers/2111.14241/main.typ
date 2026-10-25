#import "@preview/cetz:0.4.2"
#show figure.where(kind: figure): set figure(supplement: [Fig.])
#show figure.where(kind: table): set figure(supplement: [Table])

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, width: 544pt, height: 743pt, margin: (left: 1.37cm, right: 1.37cm, top: 1.97cm, bottom: 1.74cm),
  header: context {
    if counter(page).get().first() > 1 {
      set text(size: 9pt, font: "Arial")
      v(-15.5pt)
      align(center)[Quantum magnonics]
    }
  },
  footer: context {
    set text(size: 9pt, font: "Arial")
    v(-3.2pt)
    grid(columns: (1fr, 1fr),
      align(left)[#emph[Yuan et al.: Preprint submitted to Elsevier]],
      align(right)[Page #counter(page).get().first() of 93])
  })
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    let n = counter(math.equation).at(e.location()).first()
    let fmt = e.numbering
    let num = if type(fmt) == function { fmt(n) } else { numbering(fmt, n) }
    if it.supplement == none { num } else { [Eq. #num] }
  } else { it }
}

// Parent-number reference for a lettered row: LaTeX labels placed outside the
// letter context resolve to "94", not "94a".
#let eqref-parent(label) = context {
  let loc = query(label).first().location()
  numbering("(1)", counter(math.equation).at(loc).first())
}

// Multi-row displays that LaTeX numbered row by row. `base` is the parent number
// (taken from the original aux file); the counter is rewound so a lettered group
// advances it only once.
#let eqgroup(rows, base: none) = rows.enumerate().map(((i, row)) => {
  if base != none {
    if i > 0 { counter(math.equation).update(base - 1) }
    [ #set math.equation(numbering: n => "(" + str(n) + str.from-unicode(97 + i) + ")")
      #row ]
  } else {
    row
  }
}).join()

#set par(justify: true, spacing: 0.85em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9.5pt)

#align(center)[
 #text(17pt, weight: "bold", [Quantum magnonics: when magnon spintronics meets quantum information science]) #v(1.2em)
 #set text(size: 10.5pt)
 H. Y. Yuan¹ (ORCID: 0000-0003-0617-9489), Yunshan Cao² (ORCID: 0000-0002-3409-2578), Akashdeep Kamra³ (ORCID: 0000-0003-0743-1076), Rembert A. Duine¹,⁴,⁵, Peng Yan² (ORCID: 0000-0001-6369-2882)
]
#block[
 #set text(size: 9pt)
 ¹ Institute for Theoretical Physics, Utrecht University, 3584 CC Utrecht, The Netherlands. E-mail: huaiyangyuan\@gmail.com \ 
 ² School of Electronic Science and Engineering and State Key Laboratory of Electronic Thin Films and Integrated Devices, University of Electronic Science and Technology of China, Chengdu 610054, China. E-mail: yunshan.cao\@uestc.edu.cn \ 
 ³ Condensed Matter Physics Center (IFIMAC) and Departamento de Física Teórica de la Materia Condensada, Universidad Autónoma de Madrid, E-28049 Madrid, Spain. E-mail: akashdeep.kamra\@uam.es \ 
 ⁴ Department of Applied Physics, Eindhoven University of Technology, P.O. Box 513, 5600 MB Eindhoven, The Netherlands. E-mail: r.a.duine\@uu.nl \ 
 ⁵ Center for Quantum Spintronics, Department of Physics, Norwegian University of Science and Technology, NO-7491 Trondheim, Norway \ 
 ² E-mail: yan\@uestc.edu.cn
]
#block[
 #set par(first-line-indent: 0em)
 #text(size: 9pt)[*Abstract.* Spintronics and quantum information science are two promising candidates for innovating information processing technologies. The combination of these two fields enables us to build solid-state platforms for studying quantum phenomena and for realizing multi-functional quantum tasks. For a long time, however, the intersection of these two fields was limited due to the distinct properties of the classical magnetization, that is manipulated in spintronics, and quantum bits, that are utilized in quantum information science. This situation has changed significantly over the last few years because of the remarkable progress in coding and processing information using magnons. On the other hand, significant advances in understanding the entanglement of quasi-particles and in designing high-quality qubits and photonic cavities for quantum information processing provide physical platforms to integrate magnons with quantum systems. From these endeavours, the highly interdisciplinary field of quantum magnonics emerges, which combines spintronics, quantum optics and quantum information science. Here, we give an overview of the recent developments concerning the quantum states of magnons and their hybridization with mature quantum platforms. First, we review the basic concepts of magnons and quantum entanglement and discuss the generation and manipulation of quantum states of magnons, such as single-magnon states, squeezed states and quantum many-body states including Bose-Einstein condensation and the resulting spin superfluidity. We discuss how magnonic systems can be integrated and entangled with quantum platforms including cavity photons, superconducting qubits, nitrogen-vacancy centers, and phonons for coherent information transfer and collaborative information processing. The implications of these hybrid quantum systems for non-Hermitian physics and parity-time symmetry are highlighted, together with applications in quantum memories and high-precision measurements. Finally, we present an outlook on some of the challenges and opportunities in quantum magnonics.]
]
#v(1.2em)


#block[
magnon, spintronics, quantum entanglement, cavity spintronics, cavity magnomechanics, superconducting qubit, nitrogen-vacancy center, quantum information, many-body physics, Bose-Einstein condensation, spin superfluid, squeezed magnon, Schrödinger cat state, quantum optics, EPR steering, $cal(P T)$ symmetry

]


#align(left)[#set par(first-line-indent: 0em)
  #text(12.0pt, weight: "bold")[Contents]
]
#v(0.35em)
#block[
  #set text(size: 10.0pt)
  #set par(first-line-indent: 0em, leading: 0.54em)
  #show outline.entry: it => {
    if it.element.numbering == none { return none }
    if it.level == 1 { block(above: 0.95em, it) } else { it }
  }
  #outline(title: none, depth: 3)
]

= Introduction
<introduction>
With the rapid accumulation of information and data in science, technology, economics and social activities, finding efficient means to store and process big data is becoming important and urgent. The traditional transistor technologies that make use of the charge degree of freedom of electrons in semiconductor devices are encountering a bottleneck, and suffer from problems such as high-energy consumption, Joule heating, and uncontrollable quantum effects, when the processing units scale down to the nanoscale. To overcome these limitations and promote further developments of information processing, two promising candidates, namely spintronics and quantum information science, stand out and have kept moving forward over the last few decades. Firstly, spintronics, emerged in the late 1980s, focuses on harnessing the spin of an electron, instead of its charge exploited in conventional electronics. Information is coded in the spin orientation of an ordered magnet as well as in the magnetic excitations of the ordered states, so-called magnons. Appealing features of spintronics include the stability of a large class of room temperature magnets, the high spin density of a magnet that allows for high density of information storage, and the tunability of spin orientations by both electric current and external fields [1,2,3]. The subfield of spintronics that focuses on the generation and manipulation of magnons is called magnonics or magnon spintronics [4]. In principle, information coded in magnons can propagate through a magnetic insulator over long distances due to the small dissipation, which may significantly reduce the energy consumption.


On the other hand, quantum computing and quantum information science manipulate the quantum nature of spins and utilize the basic principles of quantum mechanics, such as superpositions and entanglement, as resources to realize computing and communication tasks [5,6,7,8]. For example, a spin-1/2 system has two states (up and down) and can thus represent a bit which records binary information. The simultaneous and coherent manipulation of $N$ spins would increase the storage capability in an exponential way as $2^N$, and thus increase the storage limit as well as the processing speed compared with classical computers. It has been reported that a programmable 53 qubit processor could complete a series of tasks in 200 seconds that would take a classical supercomputer approximately 1000 years [9]. The worldwide focus on, and fast developments in, quantum science and technologies, have gradually put us in the age of the so-called second quantum revolution [10], which may potentially shape our future lives.


In the early years, magnon spintronics and quantum information science developed independently. Recently, however, these two fields started to overlap, probably for the following reasons. (i) In modern quantum technologies, it is necessary and urgent to search for various hybrid platforms to achieve complementary functionalities and multitasking capabilities such as room temperature quantum computing and solid-state-based quantum simulations. With its long lifetime and tunability as information carrier, the magnon is an ideal choice to be integrated with the known quantum platforms, e.g., cavity photons and superconducting (SC) qubits; (ii) Spintronics mostly manipulates the classical magnetization orientation at room temperature and thermal stability of magnetic elements at the nanoscale is an important challenge. At this scale, quantum effects cannot be neglected any longer, and the interplay of spintronics and quantum mechanics has to be taken into account in a consistent manner; (iii) Currently, a young branch of quantum information, called continuous variable quantum information [11,12,13,14,15,16,17,18], has emerged, which manipulates quasi-particles, for example photons and phonons which have continuous spectrum as opposed to traditional qubits. Magnons, falling perfectly into this category, can be strongly coupled to both photons and phonons, and thus provide a fertile platform to study both fundamental quantum physics and fruitful applications such as quantum transducers, quantum memories, high precision measurements and logic gates. The interplay of magnon spintronics with quantum information science shapes the new field #emph[quantum magnonics], which covers the overlap between traditional spintronics, magnonics, quantum optics, quantum computing and quantum information science. In this review, we first introduce the language of quantum magnonics to make this field accessible to a general readership, and subsequently review its recent developments.


// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Fig. #context it.counter.display(it.numbering):* #it.body]
}

#figure(cetz.canvas(length: 0.78cm, {
  import cetz.draw: *

  set-style(
    stroke: (thickness: 1pt, paint: black),
    fill: none,
    mark: (length: 0.35cm, width: 0.3cm),
  )

  let photon-color = rgb("#d9761a")
  let phonon-color = rgb("#7ba03c")
  let magnon-color = rgb("#3c6b9e")
  let qubit-color = rgb("#4f92a5")
  let spin-color = rgb("#cec3d6")
  let wave-color = rgb("#c9c1a8")
  let state-color = rgb("#8fa8c8")
  let oscillator-color = rgb("#c6cba4")
  let photon-link = rgb("#2f6fa8")
  let magnon-link = rgb("#7a7ac0")
  let yellow-link = rgb("#bfa51f")
  let teal-link = rgb("#4f9aa0")

  let nodes = (
    (name: "photon", at: (10.46, 8.66), radius: 0.95, fill: photon-color, label: [photon], size: 9.5pt),
    (name: "thz", at: (10.41, 10.01), radius: 0.48, fill: wave-color, label: [THz \ wave], size: 5.2pt),
    (name: "optical", at: (8.66, 8.69), radius: 0.59, fill: wave-color, label: [Optical \ wave], size: 5.2pt),
    (name: "micro", at: (12.11, 8.79), radius: 0.47, fill: wave-color, label: [Micro \ wave], size: 5.2pt),
    (name: "phonon", at: (3.22, 3.24), radius: 1.05, fill: phonon-color, label: [phonon], size: 9.5pt),
    (name: "lattice", at: (2.91, 4.61), radius: 0.63, fill: oscillator-color, label: [Lattice \ vibration], size: 5.2pt),
    (name: "mechanical", at: (2.07, 1.66), radius: 0.70, fill: oscillator-color, label: [Mechanical \ oscillator], size: 4.9pt),
    (name: "magnon", at: (10.48, 3.56), radius: 1.05, fill: magnon-color, label: [magnon], size: 9.5pt),
    (name: "fock", at: (10.50, 5.02), radius: 0.55, fill: state-color, label: [Fock \ states], size: 5.2pt),
    (name: "squeezed", at: (8.43, 3.69), radius: 0.63, fill: state-color, label: [Squeezed \ states], size: 5.2pt),
    (name: "cat", at: (12.30, 3.70), radius: 0.63, fill: state-color, label: [Cat \ states], size: 5.2pt),
    (name: "superfluid", at: (9.38, 1.96), radius: 0.63, fill: state-color, label: [Super- \ fluid], size: 5.2pt),
    (name: "bec", at: (11.62, 2.00), radius: 0.60, fill: state-color, label: [BEC], size: 5.2pt),
    (name: "qubit", at: (17.80, 3.57), radius: 0.84, fill: qubit-color, label: [SC \ qubit], size: 7.5pt),
    (name: "spin", at: (17.85, 2.19), radius: 0.84, fill: spin-color, label: [single- \ spin \ qubit], size: 7.5pt),
  )

  // the cloud of magnon states
  circle((10.48, 3.32), radius: (3.0, 2.55), name: "states",
    stroke: (paint: photon-link, thickness: 1pt, dash: "dash-dotted"))

  for n in nodes {
    circle(n.at, radius: n.radius, fill: n.fill, stroke: none, name: n.name)
  }

  // photon couples to the magnon cloud: absorption (up) and emission (down)
  let vlink(x, from, to, color) = line(
    ((x, 0), "|-", from), ((x, 0), "|-", to),
    stroke: 5pt + color,
    mark: (end: (symbol: "stealth", fill: color)))
  vlink(10.26, "states.north", "photon.south", photon-color)
  vlink(10.66, "photon.south", "states.north", photon-link)

  let coupler(a, b, color) = line(a, b,
    stroke: 4pt + color,
    mark: (start: (symbol: "stealth", fill: color), end: (symbol: "stealth", fill: color)))

  coupler("photon", "phonon", yellow-link)
  coupler("photon", "qubit", teal-link)
  coupler("phonon", "states", photon-link)
  coupler("states", "qubit", magnon-link)

  // labels last so the link lines do not paint over them
  for n in nodes {
    content(n.name, text(n.size, n.label))
  }
}),
 caption: [
 Framework of quantum magnonics. Centered around magnons, four routes are being developed. The central route concerns quantum states of magnons at low temperatures. The left route integrates magnons with phonons corresponding to the lattice vibrations within the magnet or mechanical vibrations of external oscillators. The top route entangles magnons with photons ranging from optical to microwave domains. The right route couples magnons to discrete variable systems including superconducting qubit and single-spin qubit (nitrogen-vacancy centers, silicon-vacancy centers etc).
 ]
) <fig:auto1>
#strong[Horizon of quantum magnonics.] The term "quantum magnonics" has been very frequently used in literature and at conference talks, even when reporting on classical spin-wave physics. At the outset of this review, we first have to clarify the horizon of quantum magnonics. Tabuchi [19] restricted the field of quantum magnonics to the interplay of magnons with SC qubits. Later, Bunkov referred to quantum magnonics in the study of magnon Bose-Einstein condensation (BEC) and spin superfluidity [20]. As we shall see, the field of quantum magnonics has developed explosively and has become more diverse in recent years. Kamra et al. [21] have emphasized the possibilities offered by magnon squeezing within quantum magnonics. Pirro et al. [22] discussed entanglement of magnons with photons in the context of quantum magnonics. Here, we use the following definition:


#quote(block: true)[
#emph[In general, any study of quantum states of magnons and the entanglement of magnons with other quantum platforms is part of quantum magnonics. In a broader sense, quantum many-body states of magnons, including Bose-Einstein condensation and its resulting spin superfluidity, are included in this field.]
]


Following this definition, we schematically depict the interplay among the various branches of quantum magnonics in @fig:auto1. The first direction concerns nonclassical states of magnons, including Fock states, squeezed states, Schrödinger cat states and so on. Quantum many-body states also fall into this class. The second direction integrates magnonic systems with known quantum platforms, including photons, phonons, and qubits. Here the photonic systems range from optical frequencies down to the microwave domain. These photons can be coupled to magnons through off-resonant or resonant interactions. Phonons represent the quantization of the collective lattice vibration as well as the oscillations of mechanical oscillators. The qubit systems mainly include the SC qubits working under cryogenic conditions and nitrogen-vacancy (NV) centers at room temperature. Here the two directions are not isolated from each other, but have strong connections. For example, to detect the quantum states of magnons, one usually imprints the magnon state onto photons, which are measured with mature light detection methods. To probe the superfluid state of magnons, one may utilize quantum impurities placed on top of the magnetic system to detect the magnetic noise. Furthermore, hybrid magnonic systems provide a natural and controllable platform to study non-Hermitian physics and parity-time ($cal(P T)$) symmetry, which will also be covered in the current review.


Our review is organized as follows. In @sec_preliminary, we give a preliminary introduction to magnons and their classical and quantum behaviours. Then, we introduce various measures to quantify the entanglement of discrete variables (qubit, qutrit) and continuous variables (magnon, photon, phonon). In @sec_qmstate, we discuss the developments concerning quantum states of magnons, including the single-magnon state, squeezed states, Schrödinger cat states, as well as quantum many-body states. In @sec_magnonX, we overview the developments in the hybrid "magnon+X" systems, where X includes cavity photons, qubits, phonons and electrons. In @sec_PT, non-Hermitian physics and $cal(P T)$ symmetry, particularly emerging in magnonic systems are highlighted. After briefly summarizing the applications of quantum magnonics in @sec_application, we come to the conclusion and outlook in Section~#ref(<sec_outlook>, supplement: none). If not stated otherwise, we decorate operators with a hat and set the reduced Planck constant $ℏ$ equal to one throughout the review.


= Preliminary knowledge
<sec_preliminary>
== Magnons
<magnons>
=== Magnetization dynamics and spin wave
<sec_llg>
Spin waves (SWs) are the collective excitations of magnetic moments in ordered magnets. Generation, propagation, manipulation and read-out of SW information have attracted significant attention over the past decade because of their promising applications in information technology. One major advantage of SWs over electrons as information carriers is that they can propagate in insulating systems, which can, in principle, weaken the effect of Joule heating that hampers traditional transistor technologies. Besides, there exist rich and mature knobs to manipulate the SWs, such as microwave, terahertz and attosecond excitations [23,24,25,26], electric current through spin transfer [27,28,29,30,31,32], spin-orbit effects [33,34,35,36,37,38], temperature gradients, ultrafast laser pulses [44,45,46,47], and mechanical strains [48,49,50,51]. To study and utillize SWs in spintronic devices, it is essential to first describe the dynamics of spins under various perturbations. Generally, the average spin angular momentum or magnetic moment in a unit volume is represented by a magnetization vector and the magnetization dynamics is governed by the phenomenological Landau-Lifshitz-Gilbert (LLG) equation [52,53] $
frac(partial bold(m), partial t)=-gamma bold(m) times bold(H)_("eff") + alpha bold(m) times frac(partial bold(m), partial t) + bold(tau ) (bold(m)),
$ where $upright(bold(m))$ is the magnetization direction that is spatiotemporally dependent in general, $gamma > 0$ is the magnitude of gyromagnetic ratio, $upright(bold(H))_"eff"$ is the effective field including exchange, anisotropy, and dipolar fields, and $alpha$ is the Gilbert damping constant. The first and second terms respectively describe the precessional and damped motion of the magnetization around and towards its equilibrium orientation, as shown in @fig:auto2(a). The larger the damping, the faster the relaxation occurs. The term $tau ( upright(bold(m)) )$ is the spin torque caused by external drivings, for example, the thermal torque at finite temperature [54], spin-transfer torque from electric current [27,28,30], and spin-orbit torque by spin current [33,34]. The LLG equation was originally introduced by Landau and Lifshitz (LL) and extended by Gilbert on the dissipation term. In modern developments, this dynamic equation in both ferromagnets and antiferromagnets has been discussed based on the Lagrangian formalism by properly constructing the dissipation functional [55,56]. The microscopic mechanism of the Gilbert damping include the spin-orbit coupling [57,58,59,60,61], spin pumping [62,63,64], two-magnon scattering [65,66], etc.


Based on the LLG equation, the dynamics of physically-separated spins is coupled together and may form a wave-like pattern as a result of short-range exchange and long-range dipolar fields, as shown in @fig:auto2(b). If the exchange interactions dominate, the resulting SW has a short wavelength on the order of nanometer scale. It is sufficient to describe such exchange SW excitations and their spectrum by the LLG equation, as already presented in many textbooks and reviews [67,68,69]. If dipolar interactions dominate, the resulting SW has a longer wavelength, and is termed a magnetostatic SW. To fully describe the SW spectrum, one needs to consider the magnetic fields both inside and outside the magnetic sample, where Maxwell's equations are required to match the boundary conditions at the interface [70,71,72]. A special resonance mode with infinitely-long wavelength is the ferromagnetic resonance (FMR [73]), which corresponds to the uniform precession of all spins. This mode plays an important role when integrating magnonic systems with other quantum systems, such as photons, phonons and qubits. A schematic picture of the complete SW spectrum is shown in @fig:auto2(c). As an example, the SW spectrum of the widely used magnetic sphere is plotted in @fig:auto2(d). Here, the FMR mode is labeled as the $( 1, 1, 0 )$ mode [74,75], where all spins inside the sphere precess in phase around the equilibrium magnetization direction defined by an external field.


// [figvision-cn] imgs/spin_wave.png
// 子图(a)为示意图，展示磁矩在磁场中的进动与弛豫过程。图
// 中有一个红色的垂直向上箭头标记为H，代表外加磁场方向。
// 一个黑色的矢量箭头标记为m，代表磁化强度或磁矩，该矢量
// 从圆锥顶点出发，指向圆锥侧面上的一点，表示其偏离磁场方
// 向。围绕红色H轴绘制了一个灰色的圆锥面，顶部边缘用蓝色
// 虚线圆圈表示，象征磁矩m绕H轴的进动轨迹。在磁矩m的尖端
// 位置，有两个小矢量：一个是绿色的矢量，标记为m×∂tm，方
// 向大致沿圆锥切线向前；另一个是浅蓝色的矢量，标记为-γm×
// H，方向与绿色矢量相反，指向圆锥内部下方。这两个矢量共
// 同描述了磁矩随时间变化的动力学行为。 子图(b)分为上下两
// 部分，分别用经典和量子图像描述自旋波的激发。上半部分标
// 题为"classical"，展示了六个并排排列的灰色倒圆锥体，每
// 个圆锥体内都有一个黑色粗箭头代表局部磁矩，这些磁矩整体
// 向上但略有倾斜。一条连续的浅蓝色正弦波曲线穿过所有圆锥
// 体的顶端，线上标有七个绿色实心圆点，对应每个磁矩的位置。
// 在图像上方有一个向右的蓝色箭头，标记为k，表示波矢方向。
// 下半部分标题为"quantum"，由三行水平排列的黑色箭头组成，
// 每行六个，代表晶格上的自旋。大部分箭头向上，但在不同行
// 的特定位置有一个向下的红色箭头，分别位于第一行第二个、
// 第二行第三个、第三行第四个位置，表示局域化的自旋翻转（
// 即磁振子）。各行之间用加号“+”连接，最下方有三个黑点“
// ...”，暗示这种叠加态可以无限延续。 子图(c)为曲线图，横
// 坐标为波数k，无具体数值范围标注；纵坐标为频率ω，同样无
// 具体数值范围。图中包含两条曲线：一条蓝色实线和一条红色
// 实线，两者均从左至右呈上升趋势，且随着k增大，斜率逐渐
// 变陡。两曲线之间的区域被填充为浅蓝色。图中用两条垂直的
// 黑色虚线将横轴划分为三个区域：左侧区域标注为"Dipolar
// waves"（偶极波），中间区域标注为"Dipolar-exchange
// waves"（偶极-交换波），右侧区域标注为"Exchange waves"
// （交换波）。这表明随着波数k的增加，自旋波模式依次经历
// 以偶极相互作用为主、偶极与交换相互作用共存、以及以交换
// 相互作用为主的三个阶段。 子图(d)左侧为曲线图，右侧为一
// 组球体表面分布图。左侧图的横坐标为归一化外场 H₀/MᵧIG，
// 范围从约0.8到1.6；纵坐标为归一化频率偏移 (ω - ωₖ)/ωₘ +
// 1/3，范围从0.15到0.45。图中有多条颜色各异的曲线，每条
// 曲线旁标注了对应的自旋波模式指数，如(200)、(210)、(110
// )、(311)、(220)、(521)、(330)、(440)等，并用同色箭头指
// 向相应曲线。右侧共九个球体图，按3x3网格排列，每个球体
// 上方标注了其对应的模式指数，如<200,200,1>、<110>、<330
// >、<311>、<310>、<311>、<200>、<712>、<320>。每个球体
// 内部显示了一种特定的矢量场分布图案，颜色从深蓝到白色渐
// 变，代表某种物理量（可能是磁化强度分量或振幅）的空间分
// 布。其中一个球体（左上角第一个）内嵌了一个立方体坐标系
// 示意图，带有红绿蓝三色轴。此外，还有一个竖直的颜色条，
// 标注为|Re(E)|，从深红到亮白，可能用于解释某些图中的颜
// 色映射。整体而言，该子图展示了不同自旋波模式在不同外场
// 下的频率响应及其空间分布特征。
#figure(placement: top, image("imgs/spin_wave.png", width: 100.0%),
 caption: [
 (a) Schematic of magnetic-moment precession and relaxation toward a magnetic field. (b) Spin-wave excitation in classical (wave-like) and quantum (localized) picture. (c) Typical spin-wave dispersion of a finite ferromagnetic body. With the increase of wave number $k$, dipolar, dipolar-exchange and exchange spin waves are classified. (d) Field dependence of the dipolar spin-wave frequency of a magnetic sphere as a function of external field, and the wave profiles of typical modes involved. Here $(l,m,q)$ labels the number of radial ($q-1$), azimuthal ($m$) and polar modes ($l-m$), respectively. The (110) mode represents ferromagnetic resonance mode, where all spins precess in phase. Source: Fig. 2(d) is adapted from Ref. [75].
 ]
) <fig:auto2>
=== Quantization of spin wave: magnon
<quantization-of-spin-wave-magnon>


In a quantum-mechanical picture, the SW corresponds to the quasi-particle called magnon. It is a boson obeying Bose-Einstein statistics, and, in the absence of fields and anisotropy, corresponds to a Goldstone boson. Magnons were originally proposed by Bloch in a spin-$1 \/ 2$ system [76] to explain the reduction of magnetization with increasing temperature, i.e., the celebrated $T^(3 \/ 2)$ law. Extension to the higher spin case is due to Möller Holstein and Primakoff quantized the magnetic excitation based on the bosonic creation and annihilation operators and derived the Hamiltonian of magnons with both quadratic and higher-order terms, which give the non-interacting magnon behavior and interaction between magnons, respectively. This approach has become a standard technique to study the quantum behavior of magnons. Magnon theory was further developed by Dyson [79] to consider the influence of magnon interactions on the low temperature behavior of thermodynamic quantities. Here we briefly review the Holstein-Primakoff (HP) approach. To describe a spin-$S$ state in quantum mechanics [80], we consider the simultaneous eigenstates of the spin angular momentum operator $hat(upright(bold(S)))^2$ and its component along the quantization axis ($upright(bold(e))_z$) $hat(S)_z$ as $ hat(upright(bold(S)))^2 | S, m chevron.r = S ( S + 1 ) | S, m chevron.r, quad hat(S)_z | S, m chevron.r = m | S, m chevron.r, quad m = -S, -S + 1, dots., S - 1, S. $ However, with this approach it is difficult to treat the interaction between many spins and magnons. To overcome this difficulty, Holstein and Primakoff noticed that [78] the possible values of $m$ can be rewritten as $m equiv S - n$, where the new quantum number $n$ takes only non-negative values $n = 0, 1, 2, dots., 2S$, regardless of whether one deals with fermions (half-integer $S$) or bosons (integer $S$). Transforming to this new basis $| S, n chevron.r$, we have $hat(S)_z | S, n chevron.r = ( S - n ) | S, n chevron.r$. In comparison with the quantization of the harmonic oscillator $hat(a)^dagger hat(a) | n chevron.r = n | n chevron.r$, we immediately have the second-quantization form of $hat(S)_z$, i.e., $hat(S)_z = S - hat(a)^dagger hat(a)$, where $hat(a)$ ($hat(a)^dagger$) is the annihilation (creation) operator of a spin quantum or a magnon. To make the new representation complete, we need to find a representation of $hat(S)_x$ and $hat(S)_y$ by preserving the commutation relation for angular momentum $[ hat(S)_i, hat(S)_j ] = i epsilon.alt_(i j k) hat(S)_k$, where $epsilon.alt_(i j k)$ is the Levi-Civita symbol. To this end, we recall the spin raising and lowering operators defined as, $hat(S)^plus.minus = hat(S)_x plus.minus i hat(S)_y$. Based on the quantum theory of angular momentum, we have $ hat(S)^(+) | S, n chevron.r = sqrt(2 S - ( n - 1 )) sqrt(n) | S, n - 1 chevron.r = sqrt(2 S - hat(a)^dagger hat(a)) hat(a) | S, n chevron.r . $ We therefore obtain $hat(S)^(+) = sqrt(2 S - hat(a)^dagger hat(a)) hat(a)$ and, similarly, $hat(S)^(-) = hat(a)^dagger sqrt(2 S - hat(a)^dagger hat(a))$, which allows us to express the excitation of a single spin $S$ in terms of magnon creation and annihilation operators. A real magnet involves many interacting spins and is described by the general Hamiltonian [81,82] 
$
hat(cal(H)) = - J sum_(chevron.l i, j chevron.r) hat(upright(bold(S)))_i dot.op hat(upright(bold(S)))_j + hat(cal(H))_"an" - mu_0 g_e mu_B sum_i upright(bold(H))_i dot.op hat(upright(bold(S)))_i - frac(mu_0 ( g_e mu_B )^2, 4 pi) sum_(i < j) frac(3 ( hat(upright(bold(S)))_i dot.op upright(bold(e))_(i j) ) ( hat(upright(bold(S)))_j dot.op upright(bold(e))_(i j) ) - hat(upright(bold(S)))_i dot.op hat(upright(bold(S)))_j, | upright(bold(r))_(i j) |^3)
$ <generalHam> where $J$ is the exchange coefficient and the first sum is over nearest neighbouring spins, $upright(bold(H))_i$ is the external magnetic field on the $i$-th spin, $mu_0$ is vacuum magnetic permeability, $g_e$ is the Landé $g$-factor, $mu_B$ is Bohr magneton, $upright(bold(r))_(i j)$ is the vector between the $i$-th and $j$-th spin, and $upright(bold(e))_(i j)$ is the unit direction vector connecting sites $i$ and $j$. On the right hand side of $hat(cal(H))$, the first term is the exchange coupling, the second term is the magnetocrystalline anisotropy that prefers spins to align in particular directions, the third term is the Zeeman energy, and the last term is the long-range dipolar interaction. Depending on the competition of these interactions, the ground state of the system may be a collinear magnetic state, such as a homogeneous magnetic domain, or a noncollinear magnetic texture, such as a domain wall, vortex, skyrmion, etc [83,84,85,86,87]. To consider the magnon excitations above these magnetic states, one usually performs a HP transformation on the ground state of the system and derives the effective Hamiltonian for magnons as [88,89,90] $ hat(cal(H)) = hat(cal(H))_0 + hat(cal(H))^( 2 ) + hat(cal(H))^( 3 ) + hat(cal(H))^( 4 ) + dots. $ where $hat(cal(H))_0$ is ground state energy, $hat(cal(H))^( 2 ), hat(cal(H))^( 3 ), hat(cal(H))^( 4 )$ denote the two-magnon processes contributed by exchange field, external field, anisotropy field and dipolar interactions, three-magnon processes from dipolar interactions, and four magnon processes from exchange and dipolar interactions, respectively. If the magnon density of the system is very low, which typically holds for weak perturbations well below the Curie temperature, the three- and four-magnon processes can be neglected. It is then sufficient to diagonalize the quadratic component $hat(cal(H))^( 2 )$ to derive the eigenspectrum. Note that this approach works for both collinear and noncollinear magnetic structures


For sufficiently large $S$, the quantum approach should give an identical prediction of the low energy SW dispersion as starting from the LLG equation, because the diagonalization procedure of the Hamiltonian corresponds to solving the eigenvalues of the dynamic matrix of the quantum Heisenberg equation, which is equivalent to solving the linearized LLG equation in the absence of damping. As an example, let us consider a soft magnetic film with magnetization aligned along the in-plane field $upright(bold(H)) = H upright(bold(e))_z$. Hamiltonian of the system is 
$
hat(cal(H)) = - J sum_(chevron.l i, j chevron.r) hat(upright(bold(S)))_i dot.op hat(upright(bold(S)))_j + K_x sum_i (hat(S)_(i, x))^2 - K_z sum_i (hat(S)_(i, z))^2 - mu_0 g_e mu_B H sum_i hat(S)_(i, z)
$ <biaxialHam> where $K_x$ and $K_z$ are anisotropies along the $x$ and $z$ directions, respectively, with $K_x > 0, K_z > 0$. The classical ground state of the system is $chevron.l hat(upright(bold(S))) chevron.r = S upright(bold(e))_z$. By keeping the linear terms of the HP transformation of the spin operators along this ground state, i.e., 
$
hat(S)_(i, z) = S - hat(a)_i^dagger hat(a)_i, quad hat(S)_(i, x) = sqrt(2 S) \/ 2 ( hat(a)_i + hat(a)_i^dagger ), quad hat(S)_(i, y) = frac(sqrt(2 S), 2 i) ( hat(a)_i - hat(a)_i^dagger )
$ <HPtransform> where $hat(a)_i$ ($hat(a)_i^dagger$) is the magnon annihilation (creation) operator on the $i -$th spin site, the effective Hamiltonian of magnon excitations to the quadratic terms can be written as 
$
cal(hat(H))^( 2 ) = - J S sum_(chevron.l i, j chevron.r) ( hat(a)_i hat(a)_j^dagger + h . c . ) + sum_i mu_i hat(a)_i^dagger hat(a)_i + frac(K_x S, 2) sum_i ( hat(a)_i hat(a)_i + h . c . )
$ <hamsse> where $mu_i = 2 Z J S + mu_0 g_e mu_B H + 2 K_z S + K_x S$ with $Z$ being the coordination number. By switching to Fourier space and diagonalizing the Hamiltonian, we obtain the bosonic Hamiltonian of the system as 
$
cal(hat(H))^( 2 ) = c o n s t . + sum_k omega_k hat(a)_(upright(bold(k)))^dagger hat(a)_(upright(bold(k))) .
$ <sq:eq:Hmag> Here the eigenfrequency is $ omega_k = sqrt([ 2 J S ( k d )^2 + mu_0 g_e mu_B H + 2 K_x S ] [ 2 J S ( k d )^2 + mu_0 g_e mu_B H + 2 K_z S + 2 K_x S ])   $ in the long wavelength limit with $d$ the lattice constant. The same dispersion is obtained employing the LLG phenomenology.


 anisotropy may substantially alter the nature of the magnonic eigenmodes in a ferromagnet leading to squeezing, as discussed in @sec_squeezedmagnon below. Here and in the next section, we examine magnons in an isotropic ferromagnet @sec:cohstate. The corresponding considerations in an anisotropic ferromagnet will be addressed in @sec_squeezedmagnon. For a magnetic sphere with negligible magnetocrystalline anisotropy ($K_x = K_z = 0$), i.e., an istrotropic magnet, the resonance frequency $omega_k = mu_0 g_e mu_B H + 2 J S ( k d )^2$. Employing $hat(S)_(i, z) = S - hat(a)_i^dagger hat(a)_i$ from the HP approach, the total spin $z$-component in an eigenstate is evaluated as 
$
⟨hat(cal(S))_z⟩ equiv ⟨sum_i hat(S)_(i, z)⟩ & = N S - sum_(upright(bold(k))) ⟨hat(a)_(upright(bold(k)))^dagger hat(a)_(upright(bold(k)))⟩ = N S - sum_(upright(bold(k))) n_(upright(bold(k)))
$ <sq:eq:spin1> where $N$ is the total number of lattice sites and $n_(upright(bold(k)))$ is the number of $upright(bold(k))$ magnons. Equation #ref(<sq:eq:spin1>, supplement: none) shows that excitation of each magnon alters the total spin by unity, which is why each magnon carries one unit ($ℏ$) of spin angular momentum along $upright(bold(e))_z$ Within this linear approximation [Eq. #ref(<HPtransform>, supplement: none)], magnons are non-interacting bosonic modes. Hence, without loss of generality, we may focus on the $upright(bold(k)) = bold(0)$ mode addressed in typical ferromagnetic resonance experiments 
$
hat(cal(H)) & = omega_r hat(a)^dagger hat(a)
$ <sq:eq:H1> where $omega_r equiv omega_(upright(bold(k)) arrow.r bold(0))$ and we have further dropped the subscript $bold(0)$ of the magnon ladder operators for convenience.


=== Coherent states and classical dynamics
<sec:cohstate>
Now we wish to relate the magnonic quantum picture to the phenomenological LL description, considering the $upright(bold(k)) = bold(0)$ mode in an isotropic ferromagnet [Eq. #ref(<sq:eq:H1>, supplement: none)]. Employing Eq. #ref(<HPtransform>, supplement: none) and the properties of the number states, we evaluate the expectation value 
$
⟨hat(cal(S))_x⟩ & equiv ⟨sum_i hat(S)_(i, x)⟩ = sqrt(frac(N S, 2)) ⟨hat(a) + hat(a)^dagger⟩ = 0
$ <sq:eq:expect1> in any eigenstate of the Hamiltonian Eq. #ref(<sq:eq:H1>, supplement: none). The expectation value of $hat(cal(S))_y equiv ⟨sum_i hat(S)_(i, y)⟩$ vanishes similarly. This is in contrast with typical experiments which find a finite value for the spin's $x$ and $y$ components. What has gone wrong? The equivalent question for harmonic oscillators bothered Schrödinger and led him to find the states that reproduce the classically observed dynamics [96]. These are called coherent states [97,98,99] and are eigenstates of the annihilation operator $ hat(a) |beta⟩ & = beta |beta⟩   $ where $beta$ is a complex number. Using this property and Eq. #ref(<sq:eq:expect1>, supplement: none), it is seen directly that the expectation values of $hat(cal(S))_(x, y)$ in a coherent state do not vanish coherent state can further be expressed in terms of Fock states [100] $|n⟩$ 
$
|beta⟩ & = sum_n exp(- frac(| beta |^2, 2)) beta^n \/ sqrt(n !) |n⟩
$ <sq:eq:alphanum> from which we see that a coherent state has a Poissonian distribution of the magnon number $n$. We further evaluate the mean $macron(n)$ and uncertainty $Delta n$ of magnon number 
$
bar(n) equiv ⟨beta | hat(n) | beta⟩ equiv ⟨hat(n)⟩ = |beta |^2, quad ( Delta n )^2 equiv ⟨hat(n)^2⟩ - (⟨hat(n)⟩ )^2 = |beta |^2, quad ⇒ frac(Delta n, bar(n)) = frac(1, |beta |) = frac(1, sqrt(bar(n))).
$ <sq:eq:cohprop> properties above clarify the classical-quantum correspondence that we have sought. It is not sufficient to consider a high magnon number alone, as one might guess at first, to recover classical dynamics from the quantum picture. This is because the expectation values of $hat(cal(S))_(x, y)$ in any number state vanish [Eq. #ref(<sq:eq:expect1>, supplement: none)]. On the other hand, the coherent state which is a superposition of number states yields a finite expectation value [97,98,99]. Furthermore, in the limit of a large average magnon number $macron(n)$, the relative fluctuations become small [Eq. #ref(<sq:eq:cohprop>, supplement: none)] giving rise to the classical picture of a spin precession with (nearly) constant amplitude [99,101]


Let us take one step further and establish the method to determine $beta$. From a theoretical perspective, a coherent state is generated by the "displacement operator" $hat(D) ( beta )$ 
$
|beta⟩ & = hat(D) ( beta ) |0⟩   quad "where" med hat(D) ( beta ) equiv exp(beta hat(a)^dagger - beta^(*) hat(a)) .
$ <sq:eq:disp1> In certain ideal situations, the system's time evolution under an external drive can be cast in the form of Eq. #ref(<sq:eq:disp1>, supplement: none), which determines the generated coherent state (see also @sec_qm_equation). Furthermore, Equation #ref(<sq:eq:disp1>, supplement: none) provides a powerful theoretical tool for deriving various properties of coherent states. We discuss an alternative method [102,103,104] which is especially useful for studying spin dynamics. A more detailed analysis is presented in the next section


Accounting for a small microwave magnetic field $h cos ( omega_d t ) hat(bold(x))$, the drive Hamiltonian becomes 
$
hat(cal(H))_d & = mu_0 h cos ( omega_d t ) g_e mu_B hat(cal(S))_x = mu_0 h cos ( omega_d t ) g_e mu_B sqrt(frac(N S, 2)) (hat(a) + hat(a)^dagger) equiv epsilon.alt_"rf" ( t ) (hat(a) + hat(a)^dagger) .
$ <sq:eq:Hd> Working in the Heisenberg picture, the equation of motion $dot(hat(a)) = i [ hat(cal(H)) + hat(cal(H)_d), hat(a) ]$ yields [Eqs. #ref(<sq:eq:H1>, supplement: none) and #ref(<sq:eq:Hd>, supplement: none)] $ frac(d hat(a), d t) & = - i omega_r hat(a) - i epsilon.alt_"rf" ( t ) . $ In steadily oscillating state, we may take the expectation value of the above equation defining $⟨hat(a)⟩ equiv beta$ 
$
frac(d beta, d t) & = - i omega_r beta - i epsilon.alt_"rf" ( t ) - alpha omega_r beta
$ <sq:eq:dyn1> where the last term on the right has been added to account for dissipation. This can be derived rigorously considering a specific bath [103,104], but can also be seen as a phenomenological dissipation term with $alpha$ the Gilbert damping parameter that also enters the LLG phenomenology [53]


Equation #ref(<sq:eq:dyn1>, supplement: none) is a powerful result for multiple reasons. First, its solution expressed in terms of the spin component expectation values is nothing but the linearized LLG equation [53,103,104]. Hence, it serves as a derivation of the linearized classical spin dynamics from a microscopic quantum Hamiltonian. Second, it actually goes beyond the simplified understanding that classical dynamics corresponds to a coherent state. A realistic system, which includes dissipation and nonideal fluctuating drives, is not described by a pure state and thus cannot be a simple coherent state. Nevertheless, Equation #ref(<sq:eq:dyn1>, supplement: none) accounts for such nonidealities. The explicit example of a bosonic dissipative bath is presented in the following @sec_qm_equation.


Finally, assuming that the influence of dissipation and drive nonideality is small, we may approximate the state of our system by a coherent state 
$
|psi ( t )⟩ & = hat(D) ( beta ( t ) ) |0⟩
$ <sq:eq:psit> where $beta ( t )$ is determined by Eq. #ref(<sq:eq:dyn1>, supplement: none). Furthermore, the quantum fluctuations in the coherent state are the same as in vacuum 
$
Delta cal(S)_x equiv sqrt(⟨beta| hat(cal(S))_x^2 |beta⟩ - (⟨beta| hat(cal(S))_x |beta⟩)^2) = sqrt(⟨0| hat(cal(S))_x^2 |0⟩ - (⟨0| hat(cal(S))_x |0⟩)^2) = sqrt(frac(N S, 2)) = Delta cal(S)_y .
$ <sq:eq:fluc1> Thus, coherent states correspond to the minimum Heisenberg uncertainty, which is not the case for general states~#footnote[For example, the squeezed states with $theta eq.not 0, pi$ [Eqs. #ref(<sq:eq:deltasx>, supplement: none) and #ref(<sq:eq:deltasy>, supplement: none)] bear quantum fluctuations in $cal(S)_(x, y)$ larger than the Heisenberg minimum requirement.]. Moreover, they have an equal magnitude of quantum fluctuations in the two spin components.


// [figvision-cn] imgs/phase_space_coherent_state.png
// 该图像包含两个子图 (a) 和 (b)，均为二维相空间示意图，
// 用于描述自旋系统的量子态演化。两图共享相同的坐标系结构：
// 横轴为 S_x，纵轴为 S_y，原点位于中心，坐标轴以黑色实线
// 绘制并带有箭头指示正方向。 子图 (a)： 类型：相空间示意
// 图。 坐标轴：横轴标记为 S_x，纵轴标记为 S_y，无具体数
// 值范围或单位标注。 图形元素：在坐标原点 (0, 0) 处有一
// 个半透明红色圆形区域，代表各向同性铁磁基态（即磁振子真
// 空态）。该圆形的水平直径由两条短竖线界定，上方标注 Δ
// S_x；垂直直径由两条短横线界定，左侧标注 ΔS_y。这两个符
// 号表示由于海森堡不确定性原理导致的量子涨落幅度。 文字
// 标注：左上角有标签 “(a)”；圆形上方标有 “ΔS_x”，左侧标
// 有 “ΔS_y”。 趋势/结论：此图展示静态的磁振子真空态，其
// 不确定性区域中心固定于原点，不随时间演化。 子图 (b)：
// 类型：相空间动态轨迹示意图。 坐标轴：与子图 (a) 相同，
// 横轴 S_x，纵轴 S_y。 图形元素：图中包含一条黑色虚线构
// 成的完整圆形轨迹，圆心位于原点，半径未标注但视觉上大于
// 子图 (a) 中的涨落圆。轨迹上有两个半透明圆形区域：一个
// 红色圆形位于右侧 (S_x > 0, S_y = 0) 位置，旁边标注 “t
// = 0”；另一个蓝色圆形位于顶部 (S_x = 0, S_y > 0) 位置，
// 旁边标注 “t = π/(2ω_r)”。虚线圆周上绘有两个黑色小箭头，
// 指示逆时针旋转方向。 文字标注：左上角有标签 “(b)”；红
// 色圆旁标注 “t = 0”（红色字体）；蓝色圆旁标注 “t = π/(2
// ω_r)”（蓝色字体）。 趋势/结论：此图描绘磁振子相干态的
// 时间演化行为——不确定性区域的中心沿圆形轨迹做进动运动，
// 从 t=0 时的 S_x 正半轴位置，经过四分之一周期后到达 S_y
// 正半轴位置，表明系统具有确定的相位关系和周期性振荡特性。
// 整体说明：阴影区域（红、蓝圆）均代表因海森堡不确定性原
// 理引起的量子涨落，其面积恒定（虽未给出具体数值表达式），
// 但在相干态中该区域整体绕原点旋转，体现经典-like 的集体
// 激发行为。
#figure(placement: top, image("imgs/phase_space_coherent_state.png", width: 100.0%),
 caption: [Phase space depiction of (a) isotropic ferromagnetic ground state, corresponding to the magnon vacuum, and (b) a magnon coherent state. The shaded region represents the quantum fluctuations due to the Heisenberg uncertainty principle with its area $prop ℏ$. In the coherent state, depicted in (b), the uncertainty region center undergoes precession along a circular trajectory, shown as a dotted curve. For macroscopically large amplitude of the precession, the Heisenberg uncertainty region appears as an infinitesimal point and the classical spin precession picture is recovered.]
) <fig:auto3>


Equipped with the analysis above culminating in Eqs. #ref(<sq:eq:psit>, supplement: none) and #ref(<sq:eq:fluc1>, supplement: none), we portray the spin dynamics, including quantum fluctuations, in its phase space comprised of $cal(S)_x prop Re ( beta )$ and $cal(S)_y prop Im ( beta )$. This has been depicted for the magnon vacuum (ground state of an isotropic ferromagnet) in @fig:auto3(a) and "classical" spin precession in @fig:auto3(b). To summarize, the quantum spin dynamics follows the classical precession expected from the LLG description with a circular minimum Heisenberg uncertainty region around the classical trajectory [103,104]. This picture is an approximation valid when the microwave drive is in an ideal coherent state and the role of dissipation is negligible.




=== Quantum equation of motion
<sec_qm_equation>
In this section, we discuss the quantum dynamics of magnons, now also accounting for anisotropies in our description. Heisenberg equation corresponding to the Hamiltonian #ref(<hamsse>, supplement: none) reads 
$
i frac(d hat(a)_i, d t) = [ hat(a)_i, hat(cal(H))^( 2 ) ] = - 2 J S sum_j hat(a)_j + mu_i hat(a)_i + K_x S hat(a)_i^dagger .
$ <HeisenEq> where the first sum is over neighboring spins of the $i$-th spin. By reformulating these dynamic equations into the form of spin operators, we obtain, $partial_t hat(upright(bold(S)))_i = - gamma ( hat(upright(bold(S)))_i times hat(upright(bold(H)))_(i, "eff") )$, where the effective field is equal to $hat(upright(bold(H)))_(i, "eff") equiv ( 2 J sum_j hat(S)_(j, x) - 2 K_x hat(S)_(i, x) ) upright(bold(e))_x + J sum_j hat(S)_(j, y) upright(bold(e))_y + ( mu_0 g_e mu_B H + 2 K_z S + 2 Z J S ) upright(bold(e))_z$ and $gamma = g_e mu_B$ appears naturally. After taking the mean-field approximation, this equation becomes the same as the classical LLG equation.


When the dissipation of spins is considered, recovering the classical dynamic equations from the quantum mechanical evolution is an ongoing research. The difference between various approaches lies in the way how dissipation is introduced in the quantum models and how the damping of the classical magnetization is recovered [103,104,105,106,107,108]. In principle, all these methods, no matter quantum or classical, should give identical predictions for the low-energy spectrum of SWs. Two known methods to introduce dissipation in a quantum system are the master equation approach based on the Lindblad formalism [109,110], and the Heisenberg-Langevin approach based on the fluctuation-dissipation theorem [111]. Since the latter will be frequently used in this review, we will briefly introduce it here.


 Hamiltonian of the total system including the magnon mode, a bath and their interactions is written as 
$
hat(cal(H)) = hat(cal(H))_s + hat(cal(H))_b + hat(cal(H))_"int"
$ <hambath> where $hat(cal(H))_s, hat(cal(H))_b, hat(cal(H))_"int"$ are respectively the Hamiltonian for the magnon mode, bath and the mutual interaction. Without loss of generality, we shall focus on the FMR mode, and the Hamiltonian for the magnons is $hat(cal(H))_s = omega_r hat(a)^dagger hat(a)$, where $omega_r = omega ( upright(bold(k)) arrow.r 0 )$. The general formalism involving many interacting bosonic modes can be found in Ref. [112]. Next, $hat(cal(H))_b$ is the free Hamiltonian of the bath, which may be formulated as a collection of harmonic oscillators, i.e., $ hat(cal(H)_b) = sum_i omega_i hat(b)_i^dagger hat(b)_i   $ where $hat(b)_i^dagger$ ($hat(b)_i$) is the creation (annihilation) operator for the oscillators which satisfy the bosonic commutation relations $[ hat(b)_i, hat(b)_j^dagger ] = delta_(i j)$. Since the bath usually has a large number of degrees of freedom, we recast the Hamiltonian in the continuum limit as $ hat(cal(H))_b = integral omega hat(b)^dagger ( omega ) hat(b) ( omega ) d omega   $ with the commutations $[ hat(b) ( omega ), hat(b)^dagger ( omega' ) ] = delta ( omega - omega' )$. $hat(cal(H))_"int"$ is the interaction between the magnon modes and the bath 
$
hat(cal(H))_"int" = integral d omega [g ( omega ) hat(a)^dagger hat(b) ( omega ) + g^(*) ( omega ) hat(a) hat(b)^dagger ( omega )] .
$ <couple> where $g ( omega )$ is the magnon-bath coupling strength.


 Hamiltonian #ref(<hambath>, supplement: none) leads to the following Heisenberg equation of motion for the magnon mode and bath mode 
#eqgroup((
  [$ frac(d hat(a) ( t ), d t) = - i [ hat(a), hat(cal(H))_s ] - i integral d omega g ( omega ) hat(b) ( omega, t ) $ <hl1>],
  [$ frac(d hat(b) ( omega, t ), d t) = - i omega hat(b) ( omega, t ) - i g^(*) ( omega ) hat(a) ( t ) . $ <hl2>],
), base: 28)
According to Eq. #ref(<hl2>, supplement: none), the equation for the bath mode can be explicitly solved as $ hat(b) ( omega, t ) = hat(b) ( omega, t_0 ) e^(- i omega ( t - t_0 )) - i g^(*) ( omega ) integral_(t_0)^t d t' hat(a) ( t' ) e^(- i omega ( t - t' )) . $ By substituting this solution into Eq. #ref(<hl1>, supplement: none), we obtain 
$
frac(d hat(a) ( t ), d t) = - i [ hat(a), hat(cal(H))_s ] - i integral d omega g ( omega ) hat(b) ( omega, t_0 ) e^(- i omega ( t - t_0 )) \
-integral d omega g ( omega ) g^(*) ( omega ) integral_(t_0)^t d t' hat(a) ( t' ) e^(- i omega ( t - t' )) .
$ <aeq>


Equation #ref(<aeq>, supplement: none) shows that the state of the magnon at time $t$ depends on its evolution at earlier times, which makes it difficult to handle. The Markov approximation is usually adopted to further simplify the dynamic equations. If the bath is a large system maintained in thermal equilibrium, we expect that it quickly dissipates the information taken from the magnon system and yields no feedback [113]. Mathematically, we now assume that $g ( omega )$ is independent of frequency such that we define $| g ( omega ) |^2 equiv kappa_m \/ pi$, where the frequency-independent coefficient $kappa_m$ denotes the coupling strength between magnons and the bath. Then, Equation #ref(<aeq>, supplement: none) is reduced to 
$
frac(d hat(a) ( t ), d t) = - i [ hat(a), hat(cal(H))_s ] - kappa_m hat(a) ( t ) + sqrt(2 kappa_m) hat(zeta) ( t )
$ <ain> where the noise operator is defined as $hat(zeta) ( t ) = - i \/ sqrt(2 pi) integral d omega hat(b) ( omega ) e^(- i omega t)$. The damping rate is related to the Gilbert damping parameter as $kappa_m = alpha omega_r$ as used in Eq. #ref(<sq:eq:dyn1>, supplement: none). It is straightforward to verify that the noise has zero mean and correlations given by [102] $ chevron.l hat(zeta) ( t ) hat(zeta)^dagger ( t' ) chevron.r = ( n_"th" + 1 ) delta ( t - t' ), quad chevron.l hat(zeta)^dagger ( t ) hat(zeta) ( t' ) chevron.r = n_"th" delta ( t - t' )   $ where $n_"th" = 1 \/ [ "exp" ( omega_r \/ k_B T ) - 1 ]$ with $k_B$ Boltzmann constant and $T$ being the temperature. Equation #ref(<ain>, supplement: none) is also called Heisenberg-Langevin equation. It shows that the evolution of magnons at time $t$ depends only on the information of modes at $t$, and is thus Markovian. The linearity of this equation together with the Gaussian nature of the noise implies that the magnon mode will decay to a stationary Gaussian state.


Let us consider magnon dynamics under a periodic driving, $hat(cal(H))_s = omega_r hat(a)^dagger hat(a) + xi ( hat(a) e^(i omega_d t) + hat(a)^dagger e^(- i omega_d t) )$. In the rotating frame with $cal(R) = exp( - i omega_d hat(a)^dagger hat(a) t )$, the Hamiltonian becomes $hat(cal(H))_s = Delta hat(a)^dagger hat(a) + xi ( hat(a) + hat(a)^dagger )$, where $Delta = omega_r - omega_d$ is the detuning of the magnon mode with respect to the driving. Then the Heisenberg-Langevin equation for the system is $ frac(d hat(a), d t) = - i ( Delta - i kappa_m ) hat(a) - i xi + sqrt(2 kappa_m) hat(zeta) ( t ) . $ By solving this equation for the steady value of $chevron.l a chevron.r$ and $chevron.l a^dagger a chevron.r$, we have $ chevron.l hat(a) chevron.r = - frac(xi, Delta - i kappa_m), quad chevron.l hat(a)^dagger hat(a) chevron.r = frac(xi^2, Delta^2 + kappa_m^2) + n_"th", quad chevron.l hat(a) hat(a) chevron.r = frac(xi^2, ( Delta - i kappa_m )^2) . $ Based on the HP transformation shown above, $hat(cal(S))_x = sqrt(2 N S) ( hat(a) + hat(a)^dagger ) \/ 2, hat(cal(S))_y = sqrt(2 N S) ( hat(a) - hat(a)^dagger ) \/ 2 i$, we can readily evaluate the uncertainty of the spin components $ & Delta cal(S)_x = Delta cal(S)_y = sqrt(frac(N S, 2) (2 n_"th" + 1)) . $ At zero temperature ($n_"th" = 0$), one immediately sees that $ Delta S_x = Delta S_y = sqrt(frac(N S, 2))   $ which recovers the uncertainty relation in Eq. #ref(<sq:eq:fluc1>, supplement: none). This implies that the quantum fluctuations of $hat(cal(S))_x$ and $hat(cal(S))_y$ are equal and further satisfy the minimum uncertainty relation, which is a signature of a coherent state [97,98,99]. This indicates that the magnons under strong driving will reproduce the classically observed dynamics [96], and justify the arguments in the discussion of Eq. #ref(<sq:eq:fluc1>, supplement: none). At finite temperature, the thermal magnon will play its role, leading to a larger uncertainty of the spin components.


== Quantum entanglement
<sec_en_measure>
 quantum state of a physical system is represented by a state vector in Hilbert space. Depending on the dimension of the Hilbert space, two types of states are classified. (i) If the dimension of the Hilbert space is finite, it is a discrete variable system. The best-known example is the spin-1/2 system or qubit, with only two elements in the Hilbert space ($plus.minus 1 \/ 2$, or up and down, or 0 and 1). Effective qubits have been realized in various solid-state platforms, including superconducting Josephson junctions [114,115], photonic systems [116,117], NV centers [118], silicon-vacancy (SV) centers [119,120], nuclear spins [121], quantum dots [122], trapped ions [123] and topological states of matter [124]. Coherent control of qubits has become the cornerstone of quantum information processing. (ii) If the dimension of the Hilbert space is infinite, this is a continuous variable system. Examples are the position and momentum degrees of freedom of a particle. Besides photons, quasi-particle excitations in solid-state physics are also classified as a continuous variable system, for example, phonons and magnons, because the spectrum of these quasi-particles is continuous. quantum states of quasi-particles, such as the antibunched state, squeezed state, cat state and so on, provide a promising alternative for quantum computing, quantum communication and quantum key distribution [11,13] as we shall see below.


Entanglement corresponds to a nonclassical relation between two distant quantum systems and was first proposed by Einstein, Podolsky, Rosen and Schrödinger in the 1930s Later, such non-local correlations were shown to yield Bell inequalities [128] that have been experimentally tested since 1972 [129]. Nowadays, entanglement of two or more quantum systems has become an indispensable resource for quantum cryptography, quantum teleportation and quantum computation [6]. A fundamental question in this field is how to quantify and manipulate the entanglement of two or more systems. A single answer to this question does not exist. In general, the problem of deciding whether a state is entangled or not is difficult and is considered NP-hard under some reductions [130,131]. Only in low dimensions and for some special cases, one can quantify the entanglement based on a given density matrix of the joint system. Furthermore, the existing criteria for entanglement for discrete and continuous quantum systems are quite different [132], as briefly summarized below. Because it is not our aim to extensively discuss entanglement measures in this review, we will focus on the most important and widely used measures for quantum magnonics.


=== Discrete variable system: qubit
<sec_en_qubit>
#emph[Entanglement entropy.] most popular measure of entanglement for pure states is the von Neumann entanglement entropy [133]. Let us consider a physical system, that has been partitioned into two parts labelled 1 and 2, described by the density matrix $rho_12$. We wish to examine the entanglement between these two parts. von Neumann entanglement entropy is defined as $E equiv - "tr" ( hat(rho)_1 ln hat(rho)_1 )$, where $hat(rho)_1$ is the reduced density matrix of the subsystem, obtained by tracing out the degrees of freedom of the other subsystem, i.e., $hat(rho)_1 = "tr"_2 ( hat(rho)_12 )$. If the two systems are separable, $hat(rho)_1$ is the density matrix of a pure state satisfying $hat(rho)_1^2 = hat(rho)_1$, thus the entropy $E ( hat(rho)_1 )$ vanishes. On the other hand, if the two subsystems are entangled, $hat(rho)_1$ will be a mixed state with finite entropy. magnitude of $E$ directly quantifies the strength of entanglement. Considering two entangled qubits, the maximally entangled states are the four Bell states $ 1 \/ sqrt(2) (| 01 chevron.r + | 10 chevron.r), 1 \/ sqrt(2) (| 00 chevron.r + | 11 chevron.r), 1 \/ sqrt(2) (| 01 chevron.r - | 10 chevron.r), 1 \/ sqrt(2) (| 00 chevron.r - | 11 chevron.r) $ with entropy $ln 2$, which form a maximally entangled basis. For the two-qutrit case, one maximally entangled state is $| phi chevron.r = ( | 11 chevron.r + | 22 chevron.r + | 33 chevron.r ) \/ sqrt(3)$ with entanglement $ln 3$ von Neumann entanglement entropy has become a standard theoretical tool for characterizing, for example, the topological ground states and excitations of quantum spin liquids [135,136]. Its strength as an entanglement measure comes from its broad applicability to pure quantum states - discrete or continuum. Furthermore, by partitioning the system of interest in different ways, it allows for revealing new information about the quantum states [137,138]


#emph[Concurrence.] In most cases, the von Neumann entanglement entropy is a good metric for pure states only. When the two qubits are subject to relaxation and dephasing, the joint density matrix $hat(rho)_12$ represents a mixed state. In general, a mixed state is called separable, if there exist convex weights $p_i$ and product states $hat(rho)_(1, i) ⊗ hat(rho)_(2, i)$ such that $hat(rho)_12 = sum_i p_i hat(rho)_(1, i) ⊗ hat(rho)_(2, i)$ holds. Otherwise the state is called an entangled state [132]


Now the entropy cannot distinguish between classical and quantum correlations and it is no longer a good entanglement measure, because the von Neumann entropy of a subsystem is not zero when the two subsystems are separable [139]. Other metrics for entanglement quantification are now more useful, for example, the entanglement as measured by Wooters' concurrence [140] $ C_12 = max( 0, lambda_1 - lambda_2 - lambda_3 - lambda_4 )   $ where $lambda_1, lambda_2, lambda_3, lambda_4$ are the square roots of the eigenvalues of $hat(rho)_12 [ ( hat(sigma)^y ⊗ hat(sigma)^y ) hat(rho)_12^(*) ( hat(sigma)^y ⊗ hat(sigma)^y ) ]$ in the decreasing order, and where $hat(sigma)^nu med ( nu = x, y, z )$ are Pauli matrices and $hat(rho)_12^(*)$ is the complex conjugate of the joint density matrix $hat(rho)_12$. The concurrence is zero if and only if the two qubits are in a separable state. Concurrence has the merit of universal applicability to arbitrary two-qubit states and a larger value of $C_12$ indicates a stronger entanglement. Its generalization to high dimensional pure states was reported in [141]


// [figvision-cn] imgs/Eg_criteria.png
// 图(a)为二维曲线图，展示纯态下的纠缠度量随参数θ的变化。
// 横坐标为θ，范围从0.0到1.5，无单位标注；纵坐标为“
// Entanglement”，范围从-0.5到1.0。图中包含三条曲线：红色
// 实线代表Concurrence（并发度），蓝色实线代表Entropy（熵），
// 黑色实线代表PPT判据的最小特征值。所有曲线均起始于(0, 0
// )，终止于约(1.57, 0)。红色曲线在θ≈0.8处达到峰值约0.5；
// 蓝色曲线在相同位置达到更高峰值约0.7；黑色曲线在θ≈0.8处
// 降至最低点约-0.5，全程位于零轴下方，表明存在纠缠。图中
// 还有一条贯穿全图的黑色虚线，位于y=0处，作为参考基线。
// 图(b)同样为二维曲线图，展示混合态下的纠缠度量随参数q的
// 变化。横坐标为q，范围从0.0到1.0；纵坐标为“Entanglement
// ”，范围从-0.4到1.0。红色实线（Concurrence）从(0, 0)开
// 始，在q<0.35时保持为零（与x轴重合），之后线性上升至(
// 1.0, 1.0)。蓝色实线（Entropy）为水平直线，恒定在y≈0.7。
// 黑色实线（PPT）从(0, 0.25)线性下降至(1.0, -0.5)，在q≈
// 0.35处穿过零轴进入负值区。黑色虚线仍位于y=0处。该图显
// 示当q>0.35时，PPT值为负，指示纠缠出现，同时Concurrence
// 从零跃升。 图(c)为主图加两个插图的复合曲线图，展示铁磁
// 自旋链中相邻自旋的并发度对数导数dC(λ)/dλ随约化外场λ的
// 变化。主图横坐标为λ，范围0.7至1.3；纵坐标为dC(λ)/dλ，
// 范围-1.5至0.5。多条彩色曲线（红、绿、棕等）表示不同系
// 统尺寸N的结果，均在λ=1附近急剧下坠至负无穷，形成尖锐尖
// 峰，且随N增大尖峰更陡峭。左下角插图：横坐标为ln N（范
// 围4至8），纵坐标为ln(λ_m⁻¹)（范围-14至-2），数据点呈线
// 性下降趋势，拟合线斜率为负，反映临界点偏移行为。右下角
// 插图：横坐标为λ（范围0至2），纵坐标为C(λ)（范围0至0.25），
// 单条灰色曲线表示无限大系统(N→∞)的并发度，在λ≈1处达峰值
// 后缓慢衰减。主图顶部中央标有字母“q”。 图(d)为双Y轴曲线
// 图，展示比热容C_T及其温度导数-T·dC_T/dT随归一化温度T/
// Tc的变化。横坐标为T/Tc，范围0至0.2。左侧Y轴为C_T×10³，
// 范围2.8至3.6；右侧Y轴为-T·dC_T/dT ×10⁻³，范围0至1.0。
// 两条蓝色曲线对应Tb/Tc=0.08：实线为C_T，从~3.6缓慢下降
// 至~3.5；虚线为-T·dC_T/dT，从~0.8下降至~0.6。两条黄色曲
// 线对应Tb/Tc=0.10：实线C_T从~3.7微降至~3.6；虚线-T·dC_T
// /dT从~1.0骤降至~0.6。图中用红色箭头分别指向左右两侧Y轴
// 标签以明确对应关系。垂直虚线标记q=0.1的位置，与某些曲
// 线拐点或极值点对齐。整体趋势显示随着Tb/Tc增加，比热峰
// 变宽，其导数峰值降低并右移。
#figure(placement: top, image("imgs/Eg_criteria.png", width: 100.0%),
 caption: [
 Entanglement measures for a pure state (a) and mixed state (b). For PPT criteria, the minimum eigenvalue of $hat(rho)^(T_B)$ is plotted and its negativeness indicates the existence of entanglement. (c) Concurrence of neighboring spins in a ferromagnetic spin-1/2 chain as a function of the reduced external field $lambda$. $lambda equiv 2J\/h$. As the system size increases, the divergence of $d C \/ d lambda$ becomes more pronounced. (d) Concurrence of neighboring spins as a function of temperature in a magnonic system supporting Bose-Einstein condensation. $T_B$ and $T_C$ are respectively the condensation temperature and Curie temperature of the system. Source: Figures (c) and (d) are adapted from Refs. [142,143].
 ]
) <fig:auto5>
#emph[Peres-Herodecki criteria.] Another important measure for entanglement is the Peres-Herodecki criterion or positive partial transpose (PPT [144,145]) It states that the partial transpose of the joint density matrix of a bipartite system being positive definite is necessary for the joint states being separable. In systems with $2 times 2$ and $2 times 3$ dimensional Hilbert spaces, this condition is also sufficient. This criteria can be extended to the infinite dimensional case as we shall see below. As an example to illustrate the usefulness and relation between these measures, we first consider a two-qubit pure state, $| phi chevron.r = cos theta | 01 chevron.r - sin theta | 10 chevron.r$ and plot the entanglement between the two qubits using the measures that were introduced, in @fig:auto5(a). Here both concurrence and von Neumann entropy, though different in magnitude, consistently capture the entanglement as a function of $theta$. For a mixed state, we consider the Werner state $hat(rho)_12 = ( 1 - q ) hat(I) \/ 4 + q | phi_s chevron.r chevron.l phi_s |$, where $hat(I)$ is a $4 times 4$ identity matrix and $| phi_s chevron.r = ( | 01 chevron.r - | 10 chevron.r ) \/ sqrt(2)$ is the spin singlet-state. The entanglement of such a state is plotted in @fig:auto5(b). Now the concurrence and PPT criteria give mutually consistent predictions of the amount of entanglement, but the von Neumann entropy fails, as expected.


In a many-spin system, the entanglement between spins can behave as a measure for a quantum phase transition [142,148,149,150,151,152,153,154,155,156]. Osterloh et al. first studied a ferromagnetic spin-1/2 chain with an exchange coupling $J$ and transverse field $h$, described by the Hamiltonian $ hat(cal(H)) = - J \/ 2 ( 1 + delta ) sum_(i = 1)^N hat(sigma)_i^x hat(sigma)_(i + 1)^x - J \/ 2 ( 1 - delta ) sum_(i = 1)^N hat(sigma)_i^y hat(sigma)_(i + 1)^y - h sum_(i = 1)^N hat(sigma)_z . $ When $0 < delta lt.eq 1$, the system undergoes a quantum phase transition for $N = oo$ from ordered to disordered phase at the critical value $lambda equiv J \/ 2 h = 1$. The authors calculated the entanglement between neighboring spins as quantified by concurrence $C$ as a function of $lambda$, as shown in @fig:auto5(c) and found a scaling behavior of the first-order derivative of $C$ at the transition point. This suggests that the entanglement can be a good indicator of the quantum phase transition, and thus provides a way to connect the theory of critical phenomena with quantum information. Yuan et al. [143] studied the entanglement of spins in a magnetic systems allowing for magnon BEC [see @sec:quantummanybodystatesofmagnons] and found that the entanglement exhibits a distinct kink behavior near the condensation temperature, as shown @fig:auto5(d). Below the condensation temperature, there exists a finite entanglement between distant spins even when they are well separated in space, which is due to the off-diagonal long-range order in the system [157]. Similar results were also reported by Wong et al. [158]. Besides, the entanglement of spins can also serve as a measure of the transition between collinear and noncollinear magnetic structures Recently, Zou et al. [160] showed that the amount of entanglement of arbitrary spins in a magnetic system is tunable by external magnetic fields.


=== Continuous variable system: magnon, photon, phonon
<sec_cvs>
A continuous variable system has an infinite dimensional Hilbert space, and therefore the dimension of the density matrix to describe such a system is also infinite. Now, the entanglement measures that are obtained by directly evaluating the properties of the density matrix become difficult to implement. It is under such circumstances that the von Neumann entanglement entropy becomes a powerful metric for characterizing entanglement of pure states [136,137,138,161,162]. We refer the readers to other reviews [136,137,138] for further examples. Here, we confine our discussion to other entanglement metrics that are more useful in the presence of dissipation. First, one has to find manageable representations to reduce the amount of degrees of freedom in such systems [163]. A widely-used representation is based on the position and momentum space of a quasi-particle, defined as $hat(q) equiv ( hat(a) + hat(a)^dagger ) \/ sqrt(2), hat(p) equiv ( hat(a) - hat(a)^dagger ) \/ sqrt(2) i$, where $hat(a)$ ($hat(a)^dagger$) is the annihilation (creation) operator of the quasi-particle excitation. Here $hat(a)$ and $hat(a)^dagger$ satisfy the bosonic commutation relation $[ hat(a), hat(a)^dagger ] = 1$, which is a natural implication of the commutation relation between the position and momentum operators $[ hat(q), hat(p) ] = i$. In general, for a continuous variable system containing $N$ types of excitations, the quantum state of the system is described by a vector $(hat(q)_1, hat(p)_1, hat(q)_2, hat(p)_2, dots., hat(q)_N, hat(p)_N)^T$ with a reduced dimension of $2 N$. Here we focus on a bipartite system described by a four dimensional state vector $hat(upright(bold(R))) = ( hat(q)_1, hat(p)_1, hat(q)_2, hat(p)_2 )^T$, which satisfies the commutation relations 
$
[ hat(R)_i, hat(R)_j ] = i Omega_(i j), upright(bold(Omega)) = mat(delim: "(", upright(bold(J)), 0; 0, upright(bold(J))), upright(bold(J)) = mat(delim: "(", 0, 1; - 1, 0) .
$ <commut> In this representation, the density matrix can be expressed via the Wigner function of the system $ W ( upright(bold(q)), upright(bold(p)) ) = 1 \/ pi^2 integral d^2 upright(bold(q))' chevron.l upright(bold(q - q))' | hat(rho) | upright(bold(q + q))' chevron.r e^(2 i upright(bold(q))' dot.op upright(bold(p)))   $ where $upright(bold(q)) = ( q_1, q_2 )$ and $upright(bold(p)) = ( p_1, p_2 )$. In 2000, Simon generalized the PPT criterion presented in @sec_en_qubit to bipartite continuous variable states as,


#emph[Theorem: If $hat(rho)$ is separable, its Wigner distribution necessarily goes over into a Wigner distribution under the phase space mirror reflection $hat(upright(bold(R))) arrow.r Lambda hat(upright(bold(R)))$ with $Lambda = "diag"(1, 1, 1, -1)$.]


On the other hand, the commutation relations Eq. #ref(<commut>, supplement: none) and non-negativeness of the density matrix leads to the following uncertainty inequality [165] 
$
upright(bold(V)) + i \/ 2 upright(bold(Omega)) gt.eq 0
$ <uncertainty> where $upright(bold(V))$ is the bipartite covariance matrix defined as $V_(i j) equiv chevron.l ( hat(R)_i - chevron.l hat(R)_i chevron.r ) ( hat(R)_j - chevron.l hat(R)_j chevron.r ) chevron.r$. Note that the first moments $chevron.l hat(R)_i chevron.r$ can be arbitrarily adjusted by displacement operations in the phase space, which do not alter the entanglement properties. Therefore, it is usually adjusted to be zero without loss of generality [163]


By combining the PPT criteria and the uncertainty inequality #ref(<uncertainty>, supplement: none), Simon found a necessary condition for separability of a bipartite quantum state $ det upright(bold(A)) det upright(bold(B)) + (1 \/ 4 - det upright(bold(C)))^2 - "tr" ( upright(bold(A J C J B J C^T J)) ) gt.eq 1 \/ 4 ( det upright(bold(A)) + det upright(bold(B)) )   $ where $det upright(bold(A)) ( upright(bold(B)) )$ is the determinant of $upright(bold(A)) ( upright(bold(B)) )$ and the matrices $upright(bold(A)), upright(bold(B))$ and $upright(bold(C))$ are defined by expressing the covariance matrix in the following $2 times 2$ block matrix 
$
upright(bold(V)) = mat(delim: "(", upright(bold(A)), upright(bold(C)); upright(bold(C))^T, upright(bold(B))) .
$ <cv_twomode> The violation of this inequality implies a finite entanglement between the two particles. It was further proven that this inequality is a necessary and sufficient condition for separability, for all bipartite Gaussian states. Here, a Gaussian state is a class of states whose Wigner distribution is a Gaussian function in phase space, such as thermal states, squeezed states, and coherent states [11]. An equivalent separability criterion for bipartite Gaussian state was independently derived by Duan, Giedke, Cirac and Zoller (DGCZ [166]), which is called the DGCZ inequality. Generalizations of the Simon criterion to a wider class of multi-mode states without limiting oneself to two-mode Gaussian states were attempted in [167,168,169,170]


#emph[Logarithmic negativity.] Besides checking the inequality, another widely-used measure to quantity the entanglement of two-mode Gaussian states is logarithmic negativity [171]. It is defined as $ E_N = max( 0, - ln( 2 eta^(-) ) ), "with" med eta^(-) equiv 1 \/ sqrt(2) sqrt((sum upright(bold(V)))^2 - sqrt(sum upright(bold(V)) - 4 det upright(bold(V))))   $ where $sum upright(bold(V)) = det upright(bold(A)) + det upright(bold(B)) - 2 det upright(bold(C))$. Note that this measure is valid for both pure and mixed states, and it will be repeatedly used below to quantify the entanglement among magnons, photons and phonons.


As an example to illustrate the meaning of continuous variable entanglement, let us consider a two-mode squeezed state defined as


$ | r chevron.r = exp [r ( hat(a)_i^dagger hat(a)_j^dagger - hat(a)_i hat(a)_j )] | 0 chevron.r_i ⊗ | 0 chevron.r_j, r in "Reals" $


whose covariance matrix is


$ upright(bold(V)) & = mat(delim: "(", upright(bold(A)), upright(bold(C)); upright(bold(C))^T, upright(bold(B))) = 1 \/ 2 mat(delim: "(", cosh 2 r, 0, sinh 2 r, 0; 0, cosh 2 r, 0, - sinh 2 r; sinh 2 r, 0, cosh 2 r, 0; 0, - sinh 2 r, 0, cosh 2 r; #none) . $


We readily derive $ sum upright(bold(V)) = det upright(bold(A)) + det upright(bold(B)) - 2 det upright(bold(C)) = 1 \/ 2 cosh 4 r, "Det" upright(bold(V)) & = 1 \/ 16   $ and the smallest symplectic eigenvalue $ eta^(-) = 1 \/ 2 [cosh 4 r - ( cosh^2 4 r - 1 )]^(1 \/ 2) = 1 \/ 2 e^(- 2 | r |) . $ Therefore the entanglement is quantified as $E_N = - ln( 2 eta^(-) ) = 2 | r |$. On the other hand, by defining the two-mode position and momentum quadratures as $hat(X) = ( hat(a)_i + hat(a)_i^dagger + hat(a)_j + hat(a)_j^dagger ) \/ 2^(3 \/ 2)$ and $hat(P) = ( hat(a)_i - hat(a)_i^dagger + hat(a)_j - hat(a)_j^dagger ) \/ ( 2^(3 \/ 2) i )$, the uncertainties of the quadratures are evaluated as $Delta X = e^r \/ 2$ and $Delta P = e^(- r) \/ 2$. Given $r > 0$, we see that the larger the squeezing of the momentum uncertainty is, the stronger the two modes are entangled. Hence the strength of entanglement for a two-mode continuous variable system may be understood as how much the collective quadrature is squeezed below the quantum limit.


#emph[EPR steering.] Further, when two subsystems are entangled, one intriguing property is that one subsystem can steer the state of the other by local operations within its own Hilbert space and by classical communication (LOCC). This concept is known as EPR steering and was originally proposed by Schrödinger detection of the steering was first proposed by Reid [172] and experimentally verified later [173,174,175]. Unlike entanglement, EPR steering is an asymmetric property between two subsystems, i.e., one subsystem may steer the quantum state of the other, but not vice versa [12]. This makes EPR steering useful in realizing one-sided quantum key distribution [176,177]. More subtle differences between entanglement and EPR steering can be found in Refs. [178,179,180]. To quantify the strength of EPR steering, Kogias et al. [177] proposed a computable measure valid for arbitrary bipartite Gaussian states based on their covariance matrix #ref(<cv_twomode>, supplement: none) as $ cal(G)^(a arrow.r b) = max {0, 1 \/ 2 ln frac(det 2 upright(bold(A)), det 2 upright(bold(V)))}, cal(G)^(b arrow.r a) = max {0, 1 \/ 2 ln frac(det 2 upright(bold(B)), det 2 upright(bold(V)))} . $ The magnitude of $cal(G)^(a arrow.r b)$ ($cal(G)^(b arrow.r a)$ ) quantifies how much the joint state is steerable, by local measurements on the $a$ ($b$) side. The operational interpretation of this quantifier can be reduced to the seminal proposal by Reid [172]


So far, we have introduced magnons, the dynamic equations that describe the quantum behavior of magnons, and the language to describe the entanglement between two subsystems for both discrete and continuous variable systems. Equipped with these preliminary knowledge, we review the recent developments concerning the generation and manipulation of quantum states of magnons in the next section.


= Quantum states of magnons
<sec_qmstate>
It is known that the particle-like nature of light gave birth to the concept of photons, possessing many intriguing quantum properties, such as the photoelectric effect, BEC, squeezing, antibunching, and entanglement. As bosonic particles, magnons share many similarities to photons, but their quantum nature was not thoroughly studied until very recently. In such an infant stage, there still exist some controversial understandings in whether a phenomenon is quantum or classical, such as magnon BEC. In this section, we would like to review the recent developments in this direction including single-magnon state in @sec_singlemagnon, squeezed states in @sec_squeezedmagnon, magnonic cat states in @sec_cat_magnon, and quantum many-body states of magnons in @sec:quantummanybodystatesofmagnons.


== Single-magnon state
<sec_singlemagnon>
Magnons that are excited in a magnet will reach equilibrium with the environment in the absence of external driving and form a thermal magnon gas. Such a thermal state is usually described by a super-Poisson distribution in Fock space, where the mean magnon occupation is smaller than the variance of the magnon number. Under a strong driving, for example by microwaves, the magnons will reach a coherent state, with mean magnon number equal to its variance [see Eq. #ref(<sq:eq:cohprop>, supplement: none)]. As discussed above in @sec:cohstate. Coherent magnons behave classically as a wavepacket and can serve as carrier for information processing. In quantum science and technology, it is meaningful to study nonclassical states of magnons for the integration of magnons with other quantum platforms. In line with the single-photon state in quantum optics [181], a single-magnon state is a quantum state with large occupation probability of the first-excited state corresponding to a single magnon. The excitation of two or more magnons should be negligible. The magnon population in Fock space then obeys sub-Poisson statistics, which is different from a thermal magnon gas and a coherently driven magnonic system. Mathematically, these states can be characterized by a zero-delay second-order correlation function [111] defined as $ g^( 2 ) ( 0 ) equiv frac(chevron.l hat(a)^dagger hat(a)^dagger hat(a) hat(a) chevron.r, chevron.l hat(a)^dagger hat(a) chevron.r^2) = 1 + frac(chevron.l ( Delta hat(n) )^2 chevron.r - chevron.l hat(n) chevron.r, chevron.l hat(n) chevron.r^2)   $ where $hat(a)$ ($hat(a)^dagger$) is the magnon annihilation (creation) operator, $hat(n) = hat(a)^dagger hat(a)$ is number operator, $Delta hat(n) = hat(n) - chevron.l hat(n) chevron.r$ and $chevron.l hat(A) chevron.r equiv "tr" ( hat(rho) hat(A) )$ is the ensemble average of the observable $hat(A)$. According to the value of $g^( 2 ) ( 0 )$ or statistics of the magnon gas, three regimes are identified [182] (i) When the magnon distribution is super-Poissonian, $chevron.l ( Delta hat(n) )^2 chevron.r > chevron.l hat(n) chevron.r$, then $g^( 2 ) ( 0 ) > 1$. For example, $g^( 2 ) ( 0 ) = 2$ is achieved by a thermal magnon gas, which is bunched due to its bosonic statistics [101,183] (ii) When the magnon distribution is Poissonian, for example, a coherent state, one has $( Delta hat(n) )^2 chevron.r = chevron.l hat(n) chevron.r$ [see Eq. #ref(<sq:eq:cohprop>, supplement: none)] and thus $g^( 2 ) ( 0 ) = 1$. The magnonic system under strong driving falls into this class, as already discussed in @sec:cohstate and @sec_qm_equation. (iii) When the magnon distribution is sub-Poissonion, $chevron.l ( Delta hat(n) )^2 chevron.r < chevron.l hat(n) chevron.r$ and $g^( 2 ) ( 0 ) < 1$ implying antibunched magnons. This is a purely quantum-mechanical state that cannot be captured by classical statistics [184]. The limiting case $g^( 2 ) ( 0 ) = 0$ indicates a perfect single-magnon source. Such case leads to a magnon blockade, i.e., the excitation of a second magnon is blocked. Fock distributions of a typical thermal state, antibunched state and coherent state are shown in @fig:auto6. Kamra and Belzig [103] and Bender et al. [101] introduced a normalized spin current cross-correlation function $c^( 2 ) ( 0 )$ to quantify the quantum correlations of spin currents injected into two metallic leads attached to a ferromagnetic insulator. This function approaches 1 and 2 when magnons are in a coherent and thermal states, respectively, resembling the behavior of $g^( 2 ) ( 0 )$.


// [figvision-cn] imgs/antibunch_scheme.png
// 该图像由三个并排排列的柱状图组成，从左至右依次标记为子
// 图a、b和c（虽然图中未显式标注a/b/c，但按阅读顺序对应）。
// 所有子图共享相同的横轴定义：Fock number（福克数），取
// 值范围为整数0到8，刻度间隔为1。纵轴统一表示Population
// （布居数/概率幅），但各子图量程不同。 子图a（左侧）：
// 类型：柱状图（条形统计图） 标题文字：“thermal state”位
// 于图表上部中央 横轴标签：“Fock number”，范围0–8，单位
// 无量纲（离散整数） 纵轴标签：“Population”，范围0–0.5，
// 无明确单位（归一化概率） 数据表现：在Fock number=0处柱
// 子最高，高度约0.52；Fock number=1处次高，约0.28；随后
// 随Fock number增加迅速衰减，Fock number=2时约0.14，Fock
// number=3时约0.07，Fock number≥4后柱子高度趋近于0（<
// 0.02）。所有柱子均为橙黄色填充，边缘带深紫色描边。 物
// 理含义：展示热态玻色子的粒子数分布，呈现超泊松统计特性
// （方差大于均值），即低占据数概率高且快速衰减。 子图b（
// 中间）： 类型：柱状图 标题文字：“antibunching”位于图表
// 上部中央 横轴标签：“Fock number”，范围0–8 纵轴标签：“
// Population”，范围0–0.8 数据表现：Fock number=0处柱子极
// 高，高度约0.82；Fock number=1处有较小柱子，高度约0.12；
// Fock number≥2处几乎无可见柱子（高度接近0，仅以虚线基线
// 示意）。柱子颜色与子图a一致（橙黄填充+紫边）。 物理含
// 义：展示反聚束态（亚泊松统计），粒子倾向于单独存在，多
// 粒子同时出现概率极低，体现强量子关联抑制。 子图c（右侧）：
// 类型：柱状图 标题文字：“coherent”位于图表上部中央 横轴
// 标签：“Fock number”，范围0–8 纵轴标签：“Population”，
// 范围0–0.3 数据表现：分布呈单峰钟形，峰值位于Fock
// number=2，高度约0.29；Fock number=1和3处高度相近，分别
// 约0.24和0.26；Fock number=0处约0.12，Fock number=4处约
// 0.15，Fock number=5处约0.08，Fock number≥6后迅速降至接
// 近0。柱子样式同前。 物理含义：展示相干态（泊松统计），
// 粒子数分布围绕平均值对称展宽，符合经典波动行为，是激光
// 场的典型特征。 整体布局：三子图水平并列，等宽等高，共
// 用左侧纵轴标签“Population”（实际每个子图独立绘制了自身
// 纵轴刻度），底部共享横轴标签“Fock number”。所有柱子均
// 采用相同视觉风格（橙黄渐变填充+深紫轮廓），便于跨子图
// 比较分布形态差异。图像通过三种典型量子态的粒子数分布对
// 比，直观揭示其统计特性的本质区别：热态（超泊松）、反聚
// 束态（亚泊松）、相干态（泊松）。
#figure(placement: top, image("imgs/antibunch_scheme.png", width: 100.0%),
 caption: [
 Illustration of the thermal state, antibunched state and coherent state of bosons. They are respectively characterized by super-Poissonian ($g^(2)(0)\>1$), sub-Poissonian ($g^(2)(0)\<1$) and Poissonian statistics ($g^(2)(0)=1$). Source: The figures are adapted from Ref. [185].
 ]
) <fig:auto6>
// [figvision-cn] imgs/antibunch_yuan.png
// 该图包含四个子图，分别标记为(a)、(b)、(c)和(d)。 子图(
// a)是一个纳米磁体的三维示意图。图中展示了一个红褐色的椭
// 球体，代表纳米磁体。建立了一个右手直角坐标系，原点位于
// 椭球中心：x轴水平向右，y轴指向右上方（与x轴成约45度角），
// z轴垂直向上。在椭球内部沿x轴方向排列着五个黄色的箭头，
// 所有箭头均指向+x方向，表示磁化强度或自旋取向一致。坐标
// 轴标签分别为“x”、“y”以及“z,m”。 子图(b)是一个能级跃迁
// 示意图，展示了系统具有强非线性时的非谐性能级分布。图中
// 有三条水平实线代表能量本征态，从下至上分别标记为“n=0”、
// “n=1”和“n=2”，均为黑色粗线。其中，“n=1”能级被特别标注
// 为橙色粗线。最上方有一条黑色虚线，未标记具体量子数。图
// 中有两个蓝色实心箭头表示微波激发的跃迁过程：一个从n=0
// 指向n=1；另一个从n=1指向n=2，但该箭头上叠加了一个红色
// 的叉号（X），表示由于频率失配，从n=1到n=2的激发被抑制。
// 子图(c)是一个二维色标图（热图），展示了作为参数K_x S/2
// γ和K_z/γ函数的磁振子二阶关联函数g^(2)(0)。横坐标为“K_x
// S/2γ”，范围从0到4，刻度间隔为1。纵坐标为“K_z/γN”，范围
// 从0.0到2.0，刻度间隔为0.5。右侧有一个垂直的颜色条，标
// 签为“g^(2)(0)”，数值范围从0到1.0以上。颜色映射方案为：
// 白色/浅黄色代表低值（接近0），橙色代表中间值，深紫色/
// 黑色代表高值（接近1.0）。图中大部分区域呈现浅黄色至橙
// 色，表明g^(2)(0)较小，图中央偏上位置标注有文字“
// antibunched magnon”。在图的左侧边缘，绘制了三个大小不
// 一的橙色球体，分别对应不同的尺寸：最上方的球体最大，标
// 注为“4.9 nm”；中间的球体次之，标注为“6.2 nm”；下方的球
// 体最小，标注为“7.8 nm”。这些球体用于示意典型磁性微球的
// 尺寸及其对应的反聚束行为。图中还有一条白色的曲线穿过色
// 标图，大致位于纵坐标0.5附近，随横坐标变化略有波动。 子
// 图(d)是一个带有数据点的曲线图，展示了二阶关联函数g^(2)
// (0)随归一化参数ξ/γ的变化关系。横坐标为“ξ/γ”，采用对数
// 刻度，范围从0.01到10，主要刻度标记为0.01、0.1、1、10。
// 纵坐标为“g^(2)(0)”，线性刻度，范围从0到2，主要刻度标记
// 为0、1、2。图中包含三组数据系列，分别对应不同的粒子数N，
// 并在右上角图例中说明：黑色实心方块连接虚线代表N=10^4；
// 红色实心圆点连接虚线代表N=10^3；蓝色实心三角形连接虚线
// 代表N=5×10^2。三条曲线的总体趋势是：随着ξ/γ的增加，g^(
// 2)(0)先下降后上升。当ξ/γ较小时（< 1），g^(2)(0)显著小
// 于1；当ξ/γ较大时（> 1），g^(2)(0)趋近于1。图中用两条垂
// 直虚线将横轴分为三个区域，并用背景色块区分：左侧区域（
// ξ/γ < 1）背景为淡红色，右下角标注“Quantum”；右侧区域（
// ξ/γ > 1）背景为淡米色，右上角标注“Classical”。一条水平
// 实线位于g^(2)(0)=1处，作为经典与量子行为的分界线。
#figure(placement: top, image("imgs/antibunch_yuan.png", width: 100.0%),
 caption: [
 (a) Schematic of a nanomagnet. (b) Anharmonic energy-level distribution of the system with strong nonlinearity. The excitation of a magnon from $n=1$ to $2$ by a microwave with frequency $omega _1-omega _0$ will be suppressed due to frequency mismatch. (c) Second-order correlation function $g^(2) (0)$ of magnons as a function of $K_x S \/ 2 gamma$ and $K_z \/ gamma N$. The orange balls sketch typical magnetic spheres with bunched and antibunched behaviors. (d) Correlation function $g^(2) (0)$ as a function of driving strength for $N=10^4$ (black squares), $10^3$ (red dots) and $5 times 10^2$ (blue triangles), respectively. Source: The figures are adapted from Ref. [185].
 ]
) <fig:auto7>
How to generate and manipulate antibunched magnons has started to attract attention recently. The conventional method to generate a single-magnon state is to enhance the nonlinearities in the magnonic system, which induces anharmonicity of the energy levels of the system. Kerr-type nonlinearities $( hat(a)^dagger hat(a) )^2$ have been widely used to study photon blockade in quantum optics [186,187,188,189]. Wang et al. [190] experimentally demonstrated the magnon Kerr effect in a small yttrium-iron-garnet (YIG) sphere, which induced a perceptible shift of the magnon frequency. Yuan et al. [185] studied the magnon excitation in a nanometer-sized magnet as shown in @fig:auto7(a) and investigated the role of Kerr-type nonlinearities on the magnon correlations. In particular, they considered a biaxial magnet described by the Hamiltonian #ref(<biaxialHam>, supplement: none) and considered the Hamiltonian up to the fourth order $ hat(cal(H)) = omega_a hat(a)^dagger hat(a) + w ( hat(a)^dagger hat(a)^dagger + hat(a) hat(a) ) + v ( hat(a)^dagger hat(a) )^2 + u ( hat(a)^dagger hat(a) hat(a) hat(a) + hat(a)^dagger hat(a)^dagger hat(a)^dagger hat(a) ) + xi ( hat(a) e^(i omega t) + hat(a)^dagger e^(- i omega t) )   $ where $omega_a = 2 K_z + K_x + mu_0 g_e mu_B H$, $w = K_x S \/ 2$, $v = - K_z \/ N - K_x \/ 2 N$, $u = - K_x \/ 4 N$, with $N$ the number of spins in the magnet. Here, $xi$ is driving term produced by an external microwave. The nonlinear terms caused by four-magnon interactions may come from either shape or magnetocrystalline anisotropy and are inversely proportional to the number of spins [185,191]. Therefore, as the magnet becomes smaller, the interaction causes significant nonuniform spacing of the energy levels as shown in @fig:auto7(b). When the input microwave driving matches the frequency of the first excited level ($n = 0 arrow.r 1$), it will efficiently pump the magnons to the level $n = 1$, but cannot excite them further due to the frequency mismatch. Therefore, magnon antibunching may be realized in a small nanomagnet and the required size of magnet is estimated to be below 10 nm, which is accessible within current fabrication techniques [192,193]. A full phase diagram in the $( K_x S \/ 2 gamma, K_z \/ gamma N )$ plane is show in @fig:auto7(c). To study the classical-quantum transition in the presence of thermal fluctuations, nonlinearities and external drivings, the authors further simulated the steady-state correlations of magnons, the results of which are shown in @fig:auto7(d). In the weak driving regime, thermal effects dominate the steady state such that the steady-state correlations are close to 2. In the opposite limit of strong driving, the steady state approaches a coherent state with $g^( 2 ) ( 0 ) = 1$. Only in the regime of intermediate driving, the nonlinearity generates an antibunched state. At temperatures below 1 K, this magnonic quantum state survives. To detect the antibunched magnons, it was proposed to couple the magnonic system to photons and encode the magnon correlations onto the photons. By measuring the photon intensity correlations through a Hanbury Brown-Twiss interferometer [194], one could probe the magnon antibunching.


Another way to induce anharmonicities for magnons is to couple the magnon mode to an ancillary mode. Liu et al. [195] considered a hybrid magnet-qubit system inside a cavity [@fig:auto8(a)], where the magnet and cavity are coupled in a coherent way and are driven by microwaves with strengths $xi_p$ and $Omega$, respectively. They found that the qubit mode can change the energy level diagram of the magnons to an anharmonic form, as shown in @fig:auto8(b), where $| n, g chevron.r$ are the dressed states of the hybrid system with magnon number $n$ and the qubit in its ground state. Here, the transitions from the ground state $| 0, g chevron.r$ to $| 1, plus.minus chevron.r$ are allowed when the driving matches the frequency difference, but the transitions from $| 1, plus.minus chevron.r$ to $| 2, plus.minus chevron.r$ are suppressed due to a frequency mismatch, where $plus.minus$ denote the splitting of the qubit's energy level. By carefully manipulating the detuning between the driving and the intrinsic magnon frequency ($Delta$), and the driving amplitudes of the qubit ($Omega$) and magnon ($zeta_p$), a nearly perfect magnon blockade with $g^( 2 ) ( 0 ) < 0.001$ is realized, as shown in @fig:auto8(c). Similar results were independently obtained by Xie et al. [196]


// [figvision-cn] imgs/antibunch_Liu.png
// 子图(a)为示意图，展示了一个位于腔体内的混合磁振子-量子
// 比特系统。图像左右两侧各有一个垂直的红色矩形板，代表光
// 学或微波腔的反射镜边界。左侧有一束红色水平箭头指向右侧，
// 标注为ε_p，表示泵浦场输入。腔体内部中央偏左位置有一个
// 红色实心圆球，标注为YIG（钇铁石榴石），代表磁振子系统。
// 其右侧是一个蓝色不规则形状物体，标注为Qubit，代表超导
// 量子比特。两者之间由一条绿色双向虚线箭头连接，标注为
// g_qm，表示量子比特与磁振子的耦合强度。在Qubit下方有一
// 个蓝色波浪形向上箭头，标注为Ω，表示对量子比特的驱动场。
// 在图像底部中央有一个坐标系图标：x轴水平向右，y轴垂直向
// 上，原点处有一个圆圈内含叉号的符号，标注为B_z，表示沿z
// 方向施加的静磁场。整个腔体区域被淡黄色渐变背景填充，暗
// 示电磁场分布。 子图(b)为能级示意图，纵轴为“Energy”，无
// 具体数值刻度但标有ω_m和2ω_m两个能量层级标记；横轴无物
// 理量，仅用于排列不同自旋态。图中绘制了四条水平黑线代表
// 系统的本征能级，从下至上分别标注为|0,g⟩、|1,+⟩/|1,-⟩（
// 简并）、|2,+⟩/|2,-⟩（简并）。最底层|0,g⟩为基态。第一激
// 发态由两条平行线组成，分别标记|1,+⟩和|1,-⟩，二者能量差
// 为2g_qm，用绿色双箭头标示。第二激发态同样由两条平行线
// 组成，标记|2,+⟩和|2,-⟩，能量差也为2g_qm，同样用绿色双
// 箭头标示。从基态到第一激发态有两条蓝色实线箭头向上跃迁，
// 对应吸收一个磁振子。从第一激发态到第二激发态有两条蓝色
// 虚线箭头向上跃迁，同时也有两条绿色虚线箭头向下跃迁，表
// 示受激辐射或拉曼过程。所有跃迁均发生在相同频率间隔内，
// 体现非谐性结构。该图说明由于qubit-magnon耦合导致能级分
// 裂，形成非等间距的阶梯状能谱。 子图(c)包含两个并列的热
// 力图（等高线图），均为稳态二阶关联函数g^(2)(0)随参数变
// 化的二维映射。 左侧热力图： 横轴为Δ/γ，范围从-50到+50，
// 单位为无量纲失谐（Δ是磁振子本征频率与驱动频率之差，γ是
// 衰减率）。 纵轴为g_qm/γ，范围从0到50，单位为无量纲耦合
// 强度。 颜色条位于右侧，标注log₁₀[g^(2)(0)]，范围从-4（
// 深蓝）到+2（亮黄），中间过渡色为绿、橙。 图中用红色曲
// 线勾勒出三个区域边界： 中心V形区域内标注g^(2)(0)>1，颜
// 色为深绿至黑色，表示强反聚束或聚束行为。 V形外侧两侧区
// 域标注g^(2)(0)<1，颜色为浅绿至黄色，表示弱关联或经典行
// 为。 在V形顶点附近（Δ≈0, g_qm≈0）出现极小值区，颜色最
// 深。 数据点以绿色十字标记分布在曲线上，表明理论计算或
// 实验测量值。 结论：当失谐Δ接近零且耦合较弱时，系统呈现
// 亚泊松统计（g^(2)(0)<1）；随着耦合增强或失谐增大，进入
// 超泊松区域（g^(2)(0)>1），尤其在共振条件下（Δ=0）存在
// 尖锐峰值。 右侧热力图： 横轴为Ω/γ，范围从0.01到0.5，单
// 位为无量纲驱动振幅（Ω是量子比特驱动幅度）。 纵轴为ζ_H/
// γ，范围从0到0.1，单位为无量纲耗散系数（可能代表热浴耦
// 合或退相干速率）。 颜色条位于左侧，标注log₁₀[g^(2)(0)]，
// 范围从-4（深蓝）到+0（亮黄），中间为绿、橙。 图中用红
// 色曲线划分两个主要区域： 左上角区域标注g^(2)(0)<0.001，
// 颜色为深蓝至绿色，表示极强反聚束。 右下角区域未标注但
// 颜色渐变为黄，表示g^(2)(0)趋近于1或更大。 数据点同样以
// 绿色十字标记。 结论：在小驱动和小耗散 regime 下，系统
// 表现出高度非经典光子统计（g^(2)(0)<<1）；随着驱动增强
// 或耗散增加，非经典特性减弱，趋向经典极限。 综合三幅子
// 图，该图完整展示了混合磁振子-量子比特系统的结构模型、
// 能级演化机制以及在不同参数空间下的量子统计特性，揭示了
// 通过调节耦合强度、失谐、驱动和耗散可调控输出光场的量子
// 性质。
#figure(placement: top, image("imgs/antibunch_Liu.png", width: 100.0%),
 caption: [
 (a) Schematic illustration of a hybrid magnet-qubit system inside a cavity. (b) Anharmonic energy level diagram of the system induced by the qubit-magnon coupling $g_(q, m)$. (c) Steady-state second-order correlation as a function of the frequency detuning ($Delta$) between intrinsic magnon frequency and driving frequency, the qubit-magnon coupling strength ($g_(q, m)$), the driving amplitude of the qubit ($Omega$) and magnon ($zeta _p$). Source: The figures are adapted from Ref. [195].
 ]
) <fig:auto8>



Besides the method to generate magnon blockade by modifying their energies, Wang et al. reported unconventional blockade in the absence of nonlinearities, by playing with the magnon-photon coupling strength, the gain of the cavity and loss of the magnet to generate a $cal(P T)$ symmetric system In such a case, different channels interfere which leads to a significant occupation of the single-magnon energy level.


Lachance-Quirion et al. [198] have experimentally verified that one can detect the single-magnon state by coupling the magnonic system to a superconducting qubit. The details shall be discussed in Section #ref(<sec_magnon_qubit>, supplement: none). Bittencourt et al. [199] proposed a magnon-heralding protocol in a cavity optomagnonic setup. They first prepared the magnon state in vacuum. Then they sent a write pulse to generate an entangled photon-magnon state, and subsequently sent a second pulse to read the information of the photons. By measuring the statistical properties of the output photons, the magnon state collapses into a single-magnon Fock state. Hence the read photon is a witness of the heralding. This heralding protocol is sensitive to the initial state of the magnons and cooling of the magnons before the write pulses is preferred to reduce the initial mean number of magnons. The phononic counterpart of this proposal was reported by Galland et al. [200]. On the application side, the single-magnon excitation may be entangled to photons for Bell tests [201] and it can also be used as a quantum memory to store information from an incoming photon [202]. The realizations of single-magnon detectors is important to make use of magnetic states for quantum information processing [203]


== Squeezed states
<sec_squeezedmagnon>
 Heisenberg uncertainty principle states that the product of quantum fluctuations in two noncommuting observables has a minimum value determined by $ℏ$. Nevertheless, it is possible to realize states with reduced quantum noise in one observable at the expense of increased fluctuations in the other [204]. Such states, generally called "squeezed states", have been the subject of intense research in the field of quantum optics [100,204,205,206,207,208,209,210]. Considering a single electromagnetic or photon mode, its associated electric and magnetic fields become two such noncommuting observables. These are proportional to the two "quadratures" $tilde( hat(c)^dagger plus.minus hat(c) )$, where $hat(c)$ is the annihilation operator for the photon mode [100,210]. While a graphic and intuitive picture is provided by this squeezing of the quantum fluctuations, the wide range of quantum phenomena (such as entanglement) embodied by these states can be appreciated best via their wave functions.


Such squeezed states and related phenomena carry over to other bosonic systems, such as mechanical resonators or phonons [211,212,213,214], in a natural way. In optical and mechanical systems, squeezed states are nonequilibrium in nature and are generated via external drives, for example. Magnets, in contrast, host robust squeezed magnonic states in equilibrium, as shown by Kamra and Belzig in 2016 [103,104,215]. This equilibrium squeezing results from energy minimization and forms the primary focus of the present subsection. A physically intuitive discussion, avoiding formalism, of this niche admitted by magnons and an overview have been presented in Ref. [21]. Here, we follow a complementary approach and clarify some key aspects of these phenomena by introducing formalism and analyzing single-mode squeezing of the $upright(bold(k)) = bold(0)$ mode in ferromagnets. This also provides us tools to appreciate the key ideas in a wide range of recent studies, which are briefly discussed below. In this process, we also review some important insights from quantum optics [100,210], but using our magnon language. The latter turns out to be particularly convenient as the two noncommuting observables (or quadratures) simply become the spin components transverse to the equilibrium order direction. The discussion below borrows heavily from Refs. [100,103,104,216]~ which should be consulted for further details. Further, @sec:cohstate serves as a prelude to the following discussion.



#emph[Squeezed coherent state of magnon.] We first consider the $upright(bold(k)) = bold(0)$ magnon mode in an isotropic ferromagnet represented by Eq. #ref(<sq:eq:H1>, supplement: none), since it pertains to the transverse components of the total spin $cal(S)_(x y)$ [Eq. #ref(<sq:eq:expect1>, supplement: none)]. Can we accomplish a reduction of quantum noise in, say $cal(S)_y$? The Heisenberg principle cannot be violated. Hence, such a reduction should accompany an increase in quantum fluctuations of $cal(S)_x$. The so-called squeezed vacuum state $|eta⟩$ is defined as 
$
|eta⟩ = hat(S) ( eta ) |0⟩ , quad hat(S) ( eta ) equiv e^( 1 \/ 2 ( eta^* hat(a)^2 - eta hat(a)^(dagger 2) ) ) ,
$ <sq:eq:sqdef> with $eta = r e^(i theta)$, where $hat(S) ( eta )$ is called the squeeze operator, $r > 0$ is known as the squeeze parameter, and $theta$ determines the squeezing direction as clarified below. Employing the unitarity of $hat(S) ( eta )$ and the identities $ hat(S)^dagger ( eta ) = hat(S) ( - eta ) , quad hat(S)^dagger ( eta ) hat(a) hat(S) ( eta ) = hat(a) cosh r - hat(a)^dagger e^(i theta) sinh r , $ we evaluate the quantum fluctuations in $cal(S)_(x y)$ as


$
Delta cal(S)_x = sqrt(frac(N S, 2)) sqrt(cosh^2 r + sinh^2 r - 2 sinh r cosh r cos theta) med = sqrt(frac(N S, 2)) e^(r) ("taking" med theta = pi),
$ <sq:eq:deltasx>

$
Delta cal(S)_y = sqrt(frac(N S, 2)) sqrt(cosh^2 r + sinh^2 r + 2 sinh r cosh r cos theta) med = sqrt(frac(N S, 2)) e^(- r) ("taking" med theta = pi) .
$ <sq:eq:deltasy> Heisenberg uncertainty region has thus been squeezed from a circle [@fig:auto3(a)] into an ellipse [@fig:auto9(a), upper panel] while maintaining its area. The squeezing of quantum fluctuations takes places along the direction making an angle of $theta \/ 2$ with the $x$-axis. Further insight into the squeezed vacuum is gained by expressing it using the magnon number states $ hat(a) |0⟩ = 0, arrow.r.double.long hat(S) ( eta ) hat(a) hat(S)^dagger ( eta ) hat(S) ( eta ) |0⟩ = 0, arrow.r.double.long (hat(a) cosh r + hat(a)^dagger e^(i theta) sinh r) |eta⟩ = 0   $ which yields the desired expansion 
$
|eta⟩ & = 1 \/ sqrt(cosh r) sum_(n = 0)^oo ( - 1 )^n med e^(i n theta) med frac(sqrt(( 2 n ) !), 2^n n !) med (tanh r)^n med |2 n⟩ .
$ <sq:eq:ximag> Thus, the squeezed vacuum state is comprised of even magnon number states [schematically depicted in @fig:auto9(a), lower panel] with the corresponding probabilities decreasing with increasing $n$, but independent of $theta$.


// [figvision-cn] imgs/phase_space_squeeze_vaccum.png
// 该图包含两个子图(a)和(b)，均为相空间示意图，用于展示压
// 缩真空态与压缩相干态的量子特性。 子图(a)为相空间示意图。
// 横坐标轴标记为S_x，纵坐标轴标记为S_y，两轴相交于原点，
// 箭头分别指向正方向。图中中心位置绘制有一个半透明的红色
// 椭圆，该椭圆长轴沿水平方向（S_x轴），短轴沿垂直方向（
// S_y轴），表示在S_y方向上的不确定性被压缩，而在S_x方向
// 上展宽。在坐标系下方，有一行数学表达式，从左至右依次为：
// 一个由两条竖线组成的符号（代表真空态|0>），加上号，接
// 着是一个由两条竖线包围四个向上箭头的符号（代表双马格农
// 态|2>），加上号，再是一个由两条竖线包围八个向上箭头的
// 符号（代表四马格农态|4>），最后是加号和省略号。该表达
// 式直观地展示了压缩真空态是由偶数马格农数态的叠加构成的。
// 子图(b)为相空间演化示意图。横坐标轴标记为S_x，纵坐标轴
// 标记为S_y，两轴相交于原点，箭头分别指向正方向。图中绘
// 制了一条以原点为中心的黑色虚线圆，圆周上有三个逆时针方
// 向的黑色小箭头，指示旋转方向。在该圆周上分布着两个椭圆
// 区域：第一个位于S_x轴正半轴上，是一个半透明的红色椭圆，
// 其长轴沿水平方向，旁边标注有红色文字“t = 0”；第二个位
// 于S_y轴正半轴上，是一个半透明的蓝色椭圆，其长轴沿垂直
// 方向，上方标注有蓝色文字“t = π/2ω_r”。这两个椭圆代表了
// 压缩相干态在不同时刻的不确定性区域形状及取向。整个图像
// 传达了压缩相干态的中心点在相空间中做经典圆周运动，而其
// 不确定性椭圆的形状随时间发生相位依赖性的变化，即在t=0
// 时压缩方向为S_y，在t=π/2ω_r时压缩方向变为S_x。
#figure(placement: top, image("imgs/phase_space_squeeze_vaccum.png", width: 100.0%),
 caption: [
 Phase space depiction of (a) squeezed vacuum state and (b) squeezed coherent state. (a) The squeezed vacuum is constituted by superposition of even magnon number states, schematically depicted in the lower panel [21]. (b) Time evolution of the squeezed coherent state prepared at $t = 0$ with squeezing in $cal(S)_y$. Circular trajectory of the uncertainty region center represents a classical property. Phase-dependent quantum fluctuations due to squeezing of the uncertainty region is a quantum feature.
 ]
) <fig:auto9>


Equation #ref(<sq:eq:ximag>, supplement: none) shows that the squeezed vacuum is, strictly speaking, not a vacuum at all. It consists of all even magnon number states, including the true vacuum $|0⟩$. This also provides a hint regarding generation of such a squeezed vacuum in experiments. We need to create correlated magnon pairs on top of the true vacuum (isotropic ferromagnet ground state), for example via parametric pumping [217,218]. Such states, although commonplace in optical [205] and mechanical [211,212,213,214] systems, have not been experimentally observed in ferromagnets thus far. However, two-mode squeezed states (beyond the scope of ongoing discussion) in antiferromagnets have been achieved [161,219,220,221]. Such states will also be briefly discussed in the context of magnon-magnon entanglement below in @sec_magnonmagnon. Often, the quantum nature of phenomena is tested via mathematical inequalities on observables. For example, the violation of Bell's inequality proves quantum entanglement [128]. We thus briefly mention one mathematical inequality that is used to characterize "nonclassical" states and ascertains squeezed vacuum to be such a state. Glauber-Sudarshan P-function $P ( beta )$ for a general state is defined via $ hat(rho) = & integral P ( beta ) |beta⟩ ⟨beta| d^2 beta   $ where $hat(rho)$ is the system density matrix, and the integral is over the complex $beta$ plane (which is also proportional to the phase-space). P-function acts as a probability distribution in the phase-space and observables can often be written as $P ( beta )$-weighted integral over the $beta$ plane. Since a classical probability distribution assumes only nonnegative values, a state is nonclassical if its P-function becomes negative in some part of the phase space. Evaluating quantum fluctuations [Eqs. #ref(<sq:eq:deltasx>, supplement: none) and #ref(<sq:eq:deltasy>, supplement: none)] in terms of $P ( beta )$, it is seen that squeezing necessitates $P ( beta )$ becoming negative in at least some part of the phase space [100]. This makes the squeezed vacuum a nonclassical state and we can expect various quantum features from it, as discussed further below.



So, coherent states are classical and squeezed states are quantum. Having both in one sounds like an oxymoron. Nevertheless, squeezed coherent state is generated (theoretically) as $ |beta, eta⟩ & = hat(D) ( beta ) hat(S) ( eta ) |0⟩ . $ We wish to examine dynamics of this squeezed coherent state. A full derivation becomes too lengthy for us to reproduce here [100,210]. Hence, we directly depict the phase-space picture of this dynamics in @fig:auto9(b). Here, we assume that the state $|beta, eta⟩$ is realized using certain drives that are switched off at $t = 0$. Thereafter, the state undergoes its natural evolution due to the single-mode Hamiltonian Eq. #ref(<sq:eq:H1>, supplement: none). As shown in @fig:auto9(b), the uncertainty region center undergoes circular precession. The quantum fluctuations squeezing in $cal(S)_y$ at $t = 0$ appears in $cal(S)_x$ after a quarter of the cycle. Thus, the state harbors phase and time dependent quantum noise [100]. Generally, the quantum nature of this state is due to the Heisenberg uncertainty region squeezing while the circular precession is a classical property. The coherent state can thus be seen as a classical carrier or amplifier of the quantum features allowing the latter to be exploited in macroscopic systems [205]



#emph[Squeezed-magnons in anisotropic ferromagnets.] We now include magnetic anisotropy in describing our ferromagnet, which has a ground state configuration of spins pointing along $- upright(bold(e))_z$ due to the applied magnetic field $H upright(bold(e))_z$. The anisotropy may result from dipolar interaction and/or magnetocrystalline contributions [103,215]. In order to keep our discussion general while focusing on the $upright(bold(k)) = bold(0)$ mode, we consider $ hat(cal(H))_(a n) = sum_i ( K_x (hat(S)_(i x))^2 + K_y (hat(S)_(i y))^2 + K_z (hat(S)_(i z))^2 ) , $ which results in the following magnon Hamiltonian 
$
hat(cal(H)) = A hat(a)^dagger hat(a) + B ( hat(a)^2 + hat(a)^(dagger 2) ) = omega_r hat(b)^dagger hat(b) ,
$ <sq:eq:sqham1> with $A equiv mu_0 g_e mu_B H + K_x S + K_y S - 2 K_z S$, and $B equiv S ( K_x - K_y ) \/ 2$. We assume $B < 0$ for the following discussion. The Hamiltonian above has been diagonalized via a Bogoliubov transform [222]: $hat(a) = hat(b) cosh r - hat(b)^dagger e^(i theta) sinh r$. We continue to denote the eigenmode energy by $omega_r$, which now becomes $omega_r = sqrt(A^2 - 4 B^2)$. Further, $r$ and $theta$ are governed by the relations: $sinh r = 2 | B | \/ sqrt(( A + omega_r )^2 - 4 B^2)$ and $theta = pi$, due to $B < 0$.

Magnons, represented by $hat(a)$, are no longer the eigenmodes, which are annihilated by $hat(b)$ [Eq. #ref(<sq:eq:sqham1>, supplement: none)]. To gain insight into the new ground state and eigenexcitations, we exploit the relations $
hat(b) = hat(a) cosh r + hat(a)^† e^(i theta) sinh r = hat(S)(eta) hat(a) hat(S)^† (eta), quad hat(a) |0⟩_(a) equiv hat(a) |0⟩ = 0,
$ and typical properties of ladder operators in demonstrating [103] 
$
|n⟩_(b) = hat(S)(eta) |n⟩_(a) equiv hat(S)(eta) |n⟩,
$ <sq:eq:ketb>


where $|n⟩_(b)$ denotes the number state for the new eigenmodes annihilated by $hat(b)$. This implies that our new vacuum $|0⟩_(b)$ is the same squeezed magnon vacuum that we have discussed earlier [Eq. #ref(<sq:eq:sqdef>, supplement: none)], with the important difference that it occurs naturally as the ground state of the anisotropic ferromagnet [21,103,160]. This can be intuitively understood as follows. When $K_y > K_x$ such that $B < 0$, it costs the system more energy to have a nonzero $S_y$ as compared to $S_x$. Thus, the quantum fluctuations in $cal(S)_x$-$cal(S)_y$ phase space due to the Heisenberg uncertainty deform to reduce their component along $y$ direction (and hence, energy), while maintaining the uncertainty region area [21,160,215]. Thus, the new ground state is squeezed magnon vacuum and adequately represented by @fig:auto9(a). On account of Eq. #ref(<sq:eq:ketb>, supplement: none) for $n = 1$, the new eigenmode is termed "squeezed-magnon[103]" and expressed in the magnon number state basis as




$
|1⟩_(b) = hat(b)^dagger |0⟩_(b) = (cosh r hat(a)^dagger + e^(- i theta) sinh r hat(a)) |eta⟩ = 1 \/ sqrt(cosh^3 r) sum_(n = 0)^oo (-1)^n e^(i n theta) frac(sqrt(( 2 n + 1 ) !), 2^n n !) (tanh r)^n |2 n + 1⟩,
$ <sq:eq:sqmagnum>



whence we see that squeezed-magnon is a composite quasi-particle formed by a superposition of odd magnon number states [96,215,223]. This composite nature underlies various quantum properties that it imbibes as discussed below. It also implies that the average spin carried by squeezed-magnon is larger than 1 [103,215], measurable via magnon spin shot noise [103,104]. The squeezed-magnon spin of $1 + 2 sinh^2 r$ is evaluated as the expectation value of the magnon number operator $hat(a)^dagger hat(a)$ using Eq. #ref(<sq:eq:sqmagnum>, supplement: none). Alternately, the same result is obtained more easily by expressing $cal(S)_z$ in terms of squeezed-magnon number ($chevron.l hat(b)^dagger hat(b) chevron.r$), similar to our analysis in Eq. #ref(<sq:eq:spin1>, supplement: none).


Such an increase in the magnon's magnetic moment was already discussed (indirectly) in the seminal Holstein-Primakoff paper [222] using the thermodynamic definition of magnetic moment $z$-component $ m_z & = - 1 \/ mu_0 frac(partial omega, partial H)   $ where $omega equiv omega ( H )$ is the magnon energy in an applied field $H upright(bold(e))_z$. It has later been noted that this value is larger than what one expects from a spin-1 magnon [224], alluding to lack of understanding. Hence, this change in the magnetic moment has typically been absorbed into the effective gyromagnetic ratio, treating the magnon spin as fixed. Only recently, with experimental developments in spintronics and theoretical understandings based on squeezing [103,215], spin and magnetic moment can be clearly separated (e.g., via spin shot noise [103]) and the magnetic moment increase has been attributed to the aforementioned squeezed-magnon spin larger than 1 [Eq. #ref(<sq:eq:sqmagnum>, supplement: none)].


// [figvision-cn] imgs/phase_space_squeeze_3_qubit.png
// 子图 (a) 是一个二维相空间示意图，用于展示各向异性铁磁
// 体中自旋动力学和量子涨落。该图包含一个直角坐标系，横轴
// 标记为 $S_x$，纵轴标记为 $S_y$，两轴交点为原点，箭头分
// 别指向正方向。图中绘制了一条黑色的虚线椭圆轨迹，中心位
// 于原点，长轴沿 $S_x$ 方向，短轴沿 $S_y$ 方向。椭圆上标
// 有黑色箭头指示逆时针旋转方向。在 $t=0$ 时刻，系统状态
// 由一个红色的实心椭圆表示，位于 $S_x$ 轴正半轴上，其长
// 轴与 $S_x$ 轴重合，表示此时 $S_x$ 方向的涨落被压缩（
// squeezed），而 $S_y$ 方向的涨落较大。红色椭圆内部有一
// 条水平虚线贯穿其中心。在 $t=\pi/2\omega_r$ 时刻，系统
// 状态由一个蓝色的实心椭圆表示，位于 $S_y$ 轴正半轴上，
// 其长轴与 $S_y$ 轴重合，表示此时 $S_y$ 方向的涨落被压缩，
// 而 $S_x$ 方向的涨落较大。蓝色椭圆内部也有一条水平虚线
// 贯穿其中心。文字标注“$t = \pi/2\omega_r$”以蓝色字体位
// 于蓝色椭圆左上方，“$t = 0$”以红色字体位于红色椭圆下方。
// 该子图传达了自旋态在相空间中随时间演化时，量子涨落在不
// 同方向上交替被压缩的现象，即自旋压缩（spin squeezing）
// 的动态过程。 子图 (b) 是一个量子态叠加与激发的概念示意
// 图，说明压缩磁振子作为复合激发如何同步激发多个量子比特。
// 图中上半部分从左到右依次排列三个狄拉克符号表示的量子态：
// 第一个是单粒子态 $|\uparrow\rangle$，其中红色向上箭头
// 代表单个自旋向上；第二个是三粒子态 $|\uparrow\uparrow\
// uparrow\rangle$，三个红色向上箭头并列；第三个是六粒子
// 态 $|\uparrow\uparrow\uparrow\uparrow\uparrow\uparrow\
// rangle$，六个红色向上箭头并列。这三个态共同构成一个叠
// 加态，用大括号括起。从该叠加态引出三条黑色实线箭头，分
// 别指向下方的三个圆形图标。每个圆形图标代表一个量子比特，
// 内部绘有一个黑色向上箭头，背景为浅黄色，上下各有一条水
// 平黑线框住箭头。这表示压缩磁振子可以同时激发三个独立的
// 量子比特，使其处于相同的自旋向上态。该子图直观展示了压
// 缩磁振子作为多体关联激发的特性，能够产生非局域的量子纠
// 缠，例如生成 GHZ 态（Greenberger-Horne-Zeilinger state）。
#figure(placement: top, image("imgs/phase_space_squeeze_3_qubit.png", width: 90.0%),
 caption: [
   (a) Phase space representation of spin dynamics and quantum fluctuations in an anisotropic ferromagnet. This is directly analogous to the isotropic ferromagnet case depicted in @fig:auto3(b). (b) Squeezed magnon is a composite excitation formed by superposition of odd magnon number states [Eq. #ref(<sq:eq:sqmagnum>, supplement: none)]. Thus, it can excite, for example, 3 qubits synchronously thereby generating Greenberger-Horne-Zeilinger and related maximally entangled states: $(|g g g⟩ plus.minus |e e e⟩)\/sqrt(2)$. Source: The figure (b) is adapted from Skogvoll et al.
 ]
) <fig:auto10>




To complete our understanding of the ground state and excitations in an anisotropic ferromagnet, we express the spin components in the eigenbasis [using Eq. #ref(<HPtransform>, supplement: none)]
#eqgroup((
  [$ hat(cal(S))_x = sqrt(frac(N S, 2)) (hat(a)^dagger + hat(a)) = e^r sqrt(frac(N S, 2)) (hat(b)^dagger + hat(b)) $],
  [$ hat(cal(S))_y = 1 \/ i sqrt(frac(N S, 2)) (hat(a)^dagger - hat(a)) = e^(- r) \/ i sqrt(frac(N S, 2)) (hat(b)^dagger - hat(b)) $],
))
whence we conclude that the entire spin operators have been squeezed, and not just the quantum fluctuations. This result allows us to understand various phenomena in anisotropic ferromagnets by simple axes-squeezing of the isotropic case. In particular, classical spin dynamics plus quantum fluctuations in an anisotropic ferromagnet can be depicted in the phase-space as shown in @fig:auto10(a). As discussed previously, the classical trajectory is traced by the uncertainty region center while the quantum features are encoded in and due to its squeezed shape. A more detailed analysis of this dynamics including a dissipative bosonic bath has been presented in @sec_qm_equation above.


#emph[Equilibrium squeezing.] The emergence of squeezed-magnons and the corresponding vacuum in anisotropic ferromagnets is an equilibrium effect caused by energy minimization [21,103,160,215]. Mathematically, it is a consequence of the Bogoliubov transform, making it general to any bosonic system that invokes such transformations. This also gives magnets a niche over other bosonic systems [21], since their excitations are often described via such Bogoliubov transforms. As compared to the nonequilibrium squeezing discussed in isotropic ferromagnets (or typically realized with optical platforms [204,205]), equilibrium squeezing is robust against decay. To distinguish the two, we call it a squeezed state of magnon (represented by $hat(a)$ above) for the nonequilibrium case and squeezed-magnon ($hat(b)$) for equilibrium situations and normal excitations [161]. This squeezing formalism has allowed us to obtain the wave functions and quantum properties of the ground states and excitations in magnets. See, e.g., Refs. [225,226,227,228] and references therein for analysis beyond our linearized dilute magnon gas limit.


#emph[Entanglement.] An insight from the obtained wave functions is that the magnetic excitations and ground states are found to harbor entanglement between spatially separated spins [21,160,161,229]. Various metrics, such as von Neumann entropy [161,162] and concurrence [160,229,230], have been employed in quantifying this entanglement content [138,231], as introduced above in @sec_en_measure. Special focus has been on antiferromagnets [161,229,230,232,233] which manifest very large squeeze parameters, and entanglement, due to exchange interaction causing the squeezing [21,161]. In contrast, relatively weak anisotropy leads to squeezing in ferromagnets. Further, Wuhrer and coworkers [233] have theoretically demonstrated the violation of DGCZ inequalities [166] in antiferromagnets, which are continuous variable analogs of the Bell's inequality [128]. In this sense, a determination of the wave function for antiferromagnets in the magnon approximation gives insights into their generic entangled nature, which has been well-established in the context of their spin liquid states [135,234,235]. A more detailed discussion of magnon-magnon entanglement in antiferromagnets is presented in @sec_magnonmagnon below.


#emph[Coupling modification.] Since the magnets typically interact with the outside world via their spin, the composite and high-spin nature of the squeezed-magnon amplifies its coupling via the squeezing effect [21,161]. This has been clarified in the context of magnon-mediated superconductivity enhancement [236,237] and magnon-magnon ultrastrong coupling [238,239,240], among several others [241,242,243,244]. The nonequilibrium equivalent of this amplification was proposed earlier for squeezed states of light [245,246,247] and has been accomplished recently using ion trap systems [248]. The effect has also been proposed to underlie transient enhancement of phonon-mediated superconductivity [249]. However, squeezing can also reduce the magnon coupling with other excitations. Haigh and coworkers [250] recently found the squeezing effect to suppress the amplitude for certain optomagnonic transitions in their experiments.


#emph[Exploiting nonclassical properties.] squeezed-magnon vacuum is the magnetic ground state. Thus, extracting entanglement from it is not as straightforward as it is from a squeezed vacuum of light [173,251]. The latter being an excited state can be absorbed by another system thereby transferring its quantum features. To address this issue, several proposals have focused on coupling two qubits with entangled spins of the magnetic ground state [160,161,230,252]. In this protocol, the qubits need to be decoupled from the magnet after achieving the desired entanglement. On the other hand, a squeezed-magnon is itself highly nonclassical due to its composite nature [Eq. #ref(<sq:eq:sqmagnum>, supplement: none)]. This excitation can thus transfer its nonclassical features more easily to, for example, 3 qubits that jointly absorb it [216], as depicted in @fig:auto10(b). Generally, an intuitive and not very precise way of understanding the entanglement embodied by squeezed-magnons and their vacuum is as follows. When a wave function is constructed by a superposition of different magnon number states, it involves coherent action of multiple spin flips (each flip corresponding to one magnon) leading to spin entanglement. Thus, this composite nature is fundamental to nearly all the quantum features.


== Schrödinger cat states
<sec_cat_magnon>


In 1935, Schrödinger proposed a thought experiment according to which a cat should exist in a quantum superposition of being dead and alive, because its state is assumed to be linked to that of an atom, which is itself in a superposition [253] His goal was to argue against the concept of quantum superposition altogether because "classical" objects (like a cat) cannot possibly be in two states at once. Here, we consider so-called Schrödinger cat states 
$
| "cat"⟩ & = frac(1, sqrt(2 + 2 cos Phi exp( - 2 |beta |^2 ))) ( | (beta)⟩ + e^i Phi | (- beta)⟩ ) .
$ <sq:eq:catdef> two coherent states ($|plus.minus beta⟩$) that superpose to form the cat state are themselves classical, as we have discussed before. For large enough $| beta |$, the two constituent states are macroscopically distinguishable as the "dead" and "alive" cats. Cat states do not only play a fundamental role in discussions concerning the difference between classical and quantum physics [255], but also serve as an indispensable resource for quantum computing [256,257,258], quantum teleportation [259] and high-precision measurements [260]. Until now, cat states have been realized in optical systems [261,262,263,264], but the generation of magnonic cat states has just started to attract interest. Among various applications of such states [260,265,266] is their ability to emulate Schrödinger's thought experiment and characterize quantum decoherence in the system [267,268], i.e., to show how fast the quantum superposition reduces to a classical statistical mixture. Furthermore, a larger $| beta |$, corresponding to the constituents ($|plus.minus beta⟩$) being more classical, gives a faster decay of the quantum superposition [269], consistent with Schrödinger's expectation of a completely classical cat loosing the superposition immediately. Glauber-Sudarshan P-function for the cat states is more singular than a delta function [270]. This is not allowed for a classical probability distribution and indicates that the cat states are nonclassical.


 even and odd cat states are obtained when $Phi = 0$ and $pi$, respectively, $
| "cat"⟩_e & = frac(1, sqrt(2 + 2 exp( - 2 |beta |^2 ))) ( | (beta)⟩ + | (- beta)⟩ ), quad | "cat"⟩_o = frac(1, sqrt(2 - 2 exp( - 2 |beta |^2 ))) ( | (beta)⟩ - | (- beta)⟩ ).
$ Employing Eq. #ref(<sq:eq:alphanum>, supplement: none), we see that the even (odd) cat state contains even (odd) number states only $
| "cat"⟩_e & = frac(2 exp(-frac(|beta |^2, 2)), sqrt(2 + 2 exp( - 2 |beta |^2 ))) sum _(m = 0)^∞ frac(beta ^2m, sqrt(2m!)) | (2m)⟩ , \
  | "cat"⟩_o & = frac(2 exp(-frac(|beta |^2, 2)), sqrt(2 - 2 exp( - 2 |beta |^2 ))) sum _(m = 0)^∞ frac(beta ^2m+1, sqrt((2m+1)!)) | (2m+1)⟩ .
$ In this sense, the even and odd cat states are somewhat similar to the squeezed vacuum [Eq. #ref(<sq:eq:ximag>, supplement: none)] and squeezed magnon [Eq. #ref(<sq:eq:sqmagnum>, supplement: none)], which also contain only even and odd number states, respectively. This similarity further provides a convenient method to generate magnon cat states, as proposed recently by Sharma and coworkers [271,272]


// [figvision-cn] imgs/sharma_squeezed.png
// 该图包含两个子图，分别标记为(a)和(b)，展示了通过光子测
// 量在光学腔中制备磁振子薛定谔猫态的过程及结果。 子图(a)
// 是一个示意图，描绘了实验装置的物理布局和相互作用机制。
// 左侧部分展示了一个法布里-珀罗光学腔的侧视图，由左右两
// 个竖直放置的半透明椭圆形反射镜构成。在两镜之间中心位置
// 悬浮着一个绿色的椭球体，代表各向异性磁体。一个蓝色的双
// 头箭头穿过该绿色椭球体，标记为“H0”，表示施加的外部磁场
// 方向。一条紫色的波浪线从左侧镜面出发，经过磁体区域到达
// 右侧镜面，象征微波场或光子在腔内的传播。在右侧镜面附近，
// 有一个紫色的弯曲箭头指向右上方，旁边标注文字“
// Measurement”，表示对腔内光子的测量过程。在该部分的下方
// 绘制了一个三维直角坐标系，标有x、y、z轴，其中z轴垂直向
// 上，y轴水平向右，x轴指向观察者。 右侧部分是一个抽象的
// 能量耦合示意图。上下排列着两个水平椭圆：上方的紫色椭圆
// 内部写有“Microwave”（微波），下方的绿色椭圆内部写有“
// Magnetization”（磁化）。这两个椭圆之间用两条黑色的虚线
// 双向箭头连接，表示两者之间的能量交换或耦合。在两个椭圆
// 中间写有公式“-M · B”，代表磁偶极相互作用哈密顿量。 子
// 图(b)包含两张并排的相空间分布热图，用于对比不同量子态
// 的统计特性。 这两张图的横坐标均为“M_x / M_ZPF”，纵坐标
// 均为“M_y / M_ZPF”，表示归一化后的磁化强度分量，单位为
// 零点涨落幅度（ZPF）。两图的坐标轴范围均为-10到10。颜色
// 映射采用深蓝色背景代表低概率密度，亮黄色/白色代表高概
// 率密度。 左边的面板标题为“Ground State”（基态）。图中
// 显示了一个沿纵轴（M_y）拉长的单峰高斯分布，中心位于原
// 点(0, 0)。这代表了压缩磁振子真空态。在该面板的左下角有
// 一个小的三维示意图，显示了一个扁平的绿色椭球体，其长轴
// 沿y轴，短轴沿x轴，并标有x、y、z轴，直观展示了压缩的方
// 向。在该面板的右上角有一个小插图（Inset），标题为“
// Isotropic”（各向同性），显示了未压缩时的圆形高斯分布，
// 其坐标轴范围较小（约-4到4）。 右边的面板标题为“
// Heralded State”（触发态/制备态）。图中显示了两个分离的
// 高概率密度斑点，呈对称分布在纵轴两侧，中心大致位于(0,
// 5)和(0, -5)附近，形成类似“8”字形的结构。这代表了生成的
// 磁振子奇数猫态。在该面板的左下角同样有一个三维示意图，
// 显示了一个细长的绿色椭球体，但在其表面画有两个红色的箭
// 头，分别指向正负z方向，示意叠加态的特性。在该面板的右
// 上角也有一个小插图（Inset），标题为“Isotropic”，显示了
// 标准的圆形高斯分布作为对比参考。
#figure(placement: top, image("imgs/sharma_squeezed.png", width: 100.0%),
 caption: [
   Generation of a magnon cat state by adding a magnon to a squeezed-magnon vacuum. (a) An anisotropic magnet is placed in an optical cavity. Measurement of the one photon state in the cavity projects the magnetic state onto the magnon odd cat state. (b) The left panel depicts the squeezed-magnon vacuum in phase-space. The right panel shows the generated cat state. The insets show the corresponding situation for an isotropic magnet, visibly devoid of the cat. Source: The figures are adapted from Sharma et al.
 ]
) <fig:auto11>




 basic idea of the method is that an approximate odd cat state is achieved by adding a single magnon to the squeezed-magnon vacuum [Eq. #ref(<sq:eq:ximag>, supplement: none)], such that the resulting state contains odd-magnon number states only. This magnon addition is accomplished by projecting the combined ground state of an anisotropic magnet-photon cavity ensemble [@fig:auto11(a)] to a one-photon state, achieved via measurement of the photon number. The system Hamiltonian is [Eq. #ref(<sq:eq:sqham1>, supplement: none)] $ hat(cal(H))_t & = A hat(a)^dagger hat(a) + B (hat(a)^2 + hat(a)^(dagger 2)) + omega_c hat(c)^dagger hat(c) + g (hat(c) hat(a)^dagger + hat(c)^dagger hat(a))   $ where $hat(c)$ annihilates the photon and $g$ parameterizes the photon-magnon coupling mediated by the Zeeman interaction. For small $g$, the ground state is approximated by 
$
|G⟩ & approx (1 + sqrt(P) frac(hat(a)^dagger hat(c)^dagger, cosh r)) hat(S) ( r ) |0_a 0_c⟩ = hat(S) ( r ) |0_a 0_c⟩ + frac(sqrt(P), cosh r) hat(a)^dagger hat(S) ( r ) |0_a 1_c⟩
$ <sq:eq:ketg> where $P med ( lt.double 1 )$ is the probability of finding the cavity in its one-photon state, and $|0_a 0_c⟩$ ($|0_a 1_c⟩$) denotes the state with no magnons and (one) photon. The squeeze operator $hat(S) ( r )$ and parameter $r$ are approximately determined by the squeezed-magnon vacuum as discussed earlier [Eq. #ref(<sq:eq:sqham1>, supplement: none)]. $|G⟩$ is predominantly the squeezed-magnon vacuum plus zero photons, with small contributions from other entangled magnon-photon states. As soon as a one-photon state is detected in the cavity, the squeezed-magnon vacuum is eliminated and $|G⟩$ is projected onto the state with one photon 
$
|C⟩ & = frac(1, cosh r) hat(a)^dagger hat(S) ( r ) |0_a 1_c⟩ .
$ <sq:eq:ketc> ensuing state adds one magnon to the squeezed-magnon vacuum and is approximately a magnon-odd cat state $t.tilde ( | beta _("cat")⟩ - | - beta _("cat")⟩ )$ with $ | beta_"cat" | approx sqrt(frac(2 B, omega_r))   $ where $omega_r$ is the squeezed-magnon energy [Eq. #ref(<sq:eq:sqham1>, supplement: none)]. In obtaining the relatively simple expressions presented here, $B, omega_c gt.double omega_r gt.double g$ has been assumed. A more general analysis appears in Ref. [272]. Husimi Q-function, defined as $Q ( beta ) equiv ⟨beta| hat(rho) |beta⟩ \/ pi$, for a state described by the density matrix $hat(rho)$ is particularly convenient in visualizing cat states in phase space. Q-function for $|G⟩$ [Eq. #ref(<sq:eq:ketg>, supplement: none)] and $|C⟩$ [Eq. #ref(<sq:eq:ketc>, supplement: none)] are shown in @fig:auto11(b).


There are several other methods to generate cat states [266,274]. In the context of optomagnonic systems, Sun and colleagues [275] have suggested a method that does not require equilibrium magnon squeezing. Instead, they suggested a nonequilibrium two-mode squeezing between already generated magnon and photon coherent states. Subsequent remote manipulation and projective measurements on the optical beam enable converting the original magnon coherent state to even or odd cat state. In the near future, the experimental generation and detection of such magnonic cat states will help to determine the potential of low-damping magnetic insulators for quantum information applications.


== Quantum many-body states
<sec:quantummanybodystatesofmagnons>
In this section we review some aspects of the many-body physics of magnons, in particular the concepts of magnon BEC and spin superfluidity. For definiteness, we restrict ourselves to solid-state magnets and do not discuss similar physics in liquid helium [276]. We start out with a brief intermezzo on BEC of interacting particles. This intermezzo is intended to bring the reader up to speed with this topic and may be skipped by the readership that is already familiar with the mean-field description of interacting BEC. Readers who would like to explore more background on these topics may consult, for example, Refs. [277,278]. After this intermezzo we review equilibrium and quasi-equilibrium magnon BEC and spin superfluidity. Throughout, we emphasize the classical versus the quantum aspects of these phenomena. We end this section with some remarks on strongly-correlated many-body states of magnons.


=== Intermezzo: Bose-Einstein condensation of interacting particles
<intermezzo-bose-einstein-condensation-of-interacting-particles>
Bose-Einstein condensation is the occupation of the single-particle ground state by a macroscopic fraction of particles. Its textbook version occurs in a system comprised of conserved identical bosons. The simplest model for BEC that includes interactions starts from the Hamiltonian for $N$ identical bosons in a box that interact via short-range interactions. It is given by 
$
hat(cal(H)) = sum _(i=1)^N ( frac(-ℏ ^2 bold(nabla)_i^2, 2m)) + frac(1, 2) sum _(i eq.not j) g delta (bold(x)_i - bold(x)_j).
$ <eq:hamsinglequant> Here, the bosons have mass $m$, and the short-range interaction is modeled with a delta-function interaction potential as a function of the particle coordinates $bold(x)_i$ with strength $g$.


At zero temperature, the bosons are expected to occupy the same single-particle ground state $psi (bold(x))$, i.e., the many-body wave function will be given by 
$
Psi _N (bold(x)_1,bold(x)_2, ⋯, bold(x)_N) prop psi (bold(x)_1) psi (bold(x)_2) ⋯ psi (bold(x)_N).
$ <eq:BECfixedN> To find the ground state and its energy, one has to minimize the expectation value of the Hamiltonian for the above many-body wave function. This expectation value is given by 
$
⟨Psi _N | hat(cal(H)) | Psi _N⟩ = integral d bold(x) psi ^* (bold(x))[ ( frac(-ℏ ^2 bold(nabla)^2, 2m) ) + frac(g, 2) |psi (bold(x)) |^2]psi (bold(x)),
$ <eq:expecvaluehamBEC> for $N gt.double 1$. Minimizing the above energy yields the Gross-Pitaevskii equation [279,280] 
$
[ ( frac(-ℏ ^2 bold(nabla)^2, 2m) ) -mu + g |psi (bold(x)) |^2]psi (bold(x)) = 0,
$ <eq:GPequation01> where the chemical potential $mu$ enters as the Lagrange multiplier that enforces the constraint of fixed norm of $psi (bold(x))$. Gross-Pitaevskii equation yields $psi (bold(x)) = sqrt(n_c) e^i overline(theta)$ for $mu > 0$, corresponding to the BEC phase of the system. Here, $n_c = mu \/ g$ is the density of particles in the condensate, which, at zero temperature and within the mean-field description developed here, is $n_c = sqrt(N \/ V)$, with $V$ the total volume. Furthermore, $macron(theta)$ is the phase of the condensate wave function and is chosen randomly upon each realization of the condensate, corresponding to spontaneous breaking of the $U ( 1 )$ symmetry of @eq:expecvaluehamBEC. For $mu < 0$ we have that $psi (bold(x))=0$, so that there is no macroscopic fraction of particles in the ground state and therefore no BEC. Hence, the condensate wave function $psi (bold(x))$ is the order parameter for the transition.


 The same conclusion is reached by starting from the second-quantized version of @eq:hamsinglequant, i.e., 
$
hat(cal(H)) = integral d bold(x) hat psi ^* (bold(x))[ ( frac(-ℏ ^2 bold(nabla)^2, 2m) ) + frac(g, 2) |hat psi (bold(x)) |^2]hat psi (bold(x)),
$ <eq:hamBEC2ndquant> where $hat psi (bold(x))$ is a bosonic annihilation operator. After insertion of the mean-field approximation $hat psi (bold(x)) = ⟨hat psi (bold(x))⟩ equiv psi (bold(x))$ into the above, we recover the result in @eq:expecvaluehamBEC, yielding again the Gross-Pitaevskii equation. In this case, the particle number is fluctuating and the state is a coherent state that was introduced in @sec:cohstate.


The mean-field approximation within the context of second quantization makes it most clear that the BEC for interacting particles at zero temperature is essentially a classical state, albeit one that is described by a complex-valued field. Neglecting the non-commuting character of $hat psi (bold(x))$, and, hence, neglecting the quantum aspects, is a good approximation in the BEC phase because $
[hat psi (bold(x)) hat psi ^† (bold(x)) - hat psi ^† (bold(x))hat psi (bold(x))]
 | Psi _N⟩ = ( sqrt(N)sqrt(N+1) - N ) | Psi _N⟩ 
 approx 0,
$ for $N gt.double 1$.


At finite temperature $T$, quantum mechanics becomes relevant. In this case, the number of particles at the single-particle energy $epsilon.alt$ is given by the Bose-Einstein distribution function 
$
n_B ( epsilon.alt - mu ) = frac(1, e^( epsilon.alt - mu ) \/ k_B T - 1)
$ <eq:BECdistr> For energies smaller than the thermal energy, i.e., for $epsilon.alt lt.double k_B T$, we have that $n_B ( epsilon.alt - mu ) gt.double 1$ so that these modes are essentially classical. Bose-Einstein distribution function approaches the Rayleigh-Jeans distribution function $k_B T \/ ( epsilon.alt - mu )$ in this limit. For energies larger than the thermal energy, i.e., $epsilon.alt gt.double k_B T$, we have that $n_B ( epsilon.alt - mu ) lt.double 1$, so that quantum-mechanical effects cannot be neglected. On the contrary, quantum-many body effects are essential for BEC at finite temperature. Namely, the nature of the high-energy part of the Bose-Einstein distribution function is such that for a given negative chemical potential and temperature there is a certain maximum number of particles that can be accommodated by the states with energy $epsilon.alt > 0$. Keeping temperature fixed, this number reaches its maximum when $mu arrow.r 0$, at which point BEC occurs. Upon increasing the total number of particles at fixed temperature, the chemical potential thus increases until it becomes zero (measured from the single-particle ground state energy). At this point, the thermal cloud, i.e., the part of the system composed of the particles with energy $epsilon.alt > 0$, is saturated and all particles that are added increase the number of particles in the ground state, i.e., lead to growth of the BEC. At fixed particle number, decreasing the temperature leads to an increase in chemical potential until the latter becomes zero, leading again to Bose-Einstein condensation. The requirements of low temperature and high density are usually expressed in terms of the phase-space density via the dimensionless number $N Lambda ( T )^3 \/ V$, which should be of order one for BEC to occur. Here, $Lambda ( T ) tilde sqrt(2 pi ℏ^2 \/ m k_B T)$ is the thermal de Broglie wavelength


The proper description of interacting BEC requires the inclusion of interactions between the particles in the thermal cloud with the particles in the condensate. Within the Popov approximation, these are described by mean-field shifts of the single-particle energies. This yields the modified Gross-Pitaevskii equation 
$
[ ( frac(-ℏ ^2 bold(nabla)^2, 2m) ) -mu + g |psi (bold(x) )|^2+ 2 g n']psi (bold(x)) = 0,
$ <eq:GPequation> where $n'$ is the density of particles in the thermal cloud that is given by 
$
n' = integral frac(d bold(k), (2pi )^3) n_B (epsilon _(bold(k)) + 2 g |psi |^2 + 2 g n'-mu ),
$ <eq:densitythermalcloud> where the single-particle dispersion is $epsilon _(bold(k)) = ℏ ^2 bold(k)^2\/2m$. The critical temperature for BEC is now found as follows. From the modified Gross-Pitaevskii equation it follows that condensation occurs when $mu = 2 g n'$. At the critical temperature, $psi = 0$, so that the equation for the density of the thermal cloud becomes $
frac(mu, 2 g) = integral frac(d bold(k), (2pi )^3) n_B (epsilon _(bold(k)) ).
$ Carrying out the integral on the right-hand side of the above, yields the critical temperature 
$
T_"BEC" t.tilde frac(ℏ ^2, k_B m) (frac(mu, g))^(2 \/ 3),
$ <eq:Tc> which is valid for $mu > 0$ only. Hence, at zero temperature BEC occurs when $mu = 0$, in agreement with our previous discussion.


In the above, we have expressed the critical temperature as a function of the chemical potential, rather than the usual expression in terms of the total density. As we shall see in the next section, this discussion is convenient for the treatment of equilibrium magnon BEC.


=== Equilibrium magnon Bose-Einstein condensation
<equilibrium-magnon-bose-einstein-condensation>
 The simplest example of equilibrium magnon BEC occurs in systems that are described by the Hamiltonian in Eq. #ref(<biaxialHam>, supplement: none), for the case that $K_z < 0$ and $K_x = 0$. These are so-called easy-plane magnets. At zero temperature and at the classical level, this system has a spin-reorientation transition whereby the spin reorients from pointing fully along the external field for large fields, to having a nonzero component in the $x - y$-plane. This reorientation transition may be found by minimizing the Hamiltonian after the mean-field ansatz $hat(S)_i = ⟨hat(S)_i⟩$. This ansatz yields in the first instance 
$
hat(cal(H)) = - J sum _(⟨i,j⟩) ⟨hat(S)_i⟩ ⋯ ⟨hat(S)_j⟩ + |K_z| sum _i (⟨hat S_(i,z)⟩ )^2 -mu _0 g_e mu _B H sum _i ⟨hat S_(i,z)⟩ ,
$ <eq:easyplaneFMH> which is minimized by $chevron.l hat(S)_i chevron.r = S upright(bold(e))_z$ for $H > 2 | K_z | S \/ ( mu_0 g_e mu_B )$, and by $ chevron.l hat(S)_i chevron.r = S (sqrt(1 - frac(mu_0 g_e mu_B H, 2 | K_z | S)) cos phi, sqrt(1 - frac(mu_0 g_e mu_B H, 2 | K_z | S)) sin phi, frac(mu_0 g_e mu_B H, 2 | K_z | S)) $ for $H < 2 | K_z | S \/ ( mu_0 g_e mu_B )$. Here, the angle $phi$ is the angle that the magnetization makes in the $x - y$-plane, which is chosen spontaneously during the reorientation transition, in analogy to the phase of the condensate that was discussed in the previous section. Here, the difference is that the absolute phase of a condensate of particles is not directly observable, whereas the magnetization is of course directly observable.


 The reorientation transition that occurs at the field $H = 2 | K_z | S \/ ( mu_0 g_e mu_B )$ can be interpreted as BEC of interacting magnons. To this end, we use the HP transformation for $S_(i, z)$ and use the mean-field ansatz $chevron.l hat(a)_i chevron.r = phi.alt$, where we anticipate that the ground state is homogeneous. Up to a constant, this yields the energy per lattice site $ hat(cal(H)) \/ N = (mu_0 g_e mu_B H - 2 | K_z | S) | phi.alt |^2 + | K_z | | phi.alt |^4   $ which, upon minimization, leads to the Gross-Pitaevskii equation #ref(<eq:GPequation>, supplement: none) with $mu = 2 | K_z | S - mu_0 g_e mu_B H$ and $g = 2 | K_z |$. The analogy with BEC is understood as follows. For the HP transformation that is used here, that is, using the $z$-direction as the quantization axis, the creation of a magnon in the single-magnon ground state corresponds semi-classically to the magnetization tilting away from the $z$-axis. A macroscopic number of magnons therefore corresponds to a classical reorientation of the magnetization away from the $z$-direction for this specific setup. A caveat here is in the definition of the magnon itself. The interpretation of the reorientation transition as magnon BEC relies on the HP transformation that uses the $z$-direction as quantization axis. If one, instead, defines the magnon as a linearized excitation around the reoriented ground state for $H < 2 | K_z | S \/ ( mu_0 g_e mu_B )$, the interpretation of the reorientation transition in terms of magnon BEC is lost [282]. Furthermore, as the tilt of the magnetization away from the $z$-axis increases, the density of magnons becomes too large to be described by the truncated HP transformation. Regardless of one's opinion on whether or not this is BEC of magnons, the analogy with BEC allows one to immediately conclude that: i) there will be gapless excitations for $H < 2 | K_z | S \/ ( mu_0 g_e mu_B )$, in analogy to phonons in the BEC, and ii) that at finite temperature the reorientation transition occurs at $T_c prop J ( 2 S - mu_0 g_e mu_B H \/ | K_z | )^(2 \/ 3) \/ k_B$. Here, we used @eq:Tc. Finally, we remark that, though the easy-plane ferromagnet is a somewhat academic system as anisotropies will always pin the easy-plane magnetization direction, there are several experiments on materials which realize this type of transition, albeit that the magnetic excitations in these experiments are more complicated than the Holstein-Primakoff magnons that we have introduced in this paper [283,284,285]


=== Quasi-equilibrium magnon Bose-Einstein condensation
<quasi-equilibrium-magnon-bose-einstein-condensation>
Notwithstanding the above-mentioned example of equilibrium condensation, BEC is often a quasi-equilibrium phenomenon and requires thermalization to occur before particles or excitations decay away. Even BEC in cold-atom systems in a trap is of this kind, as e.g., three-particle collisions will cause one atom to escape from the trap that holds the atoms, leaving one molecule behind. The most well-known type of experiments is on quasi-equilibrium magnon BEC in YIG in which pairs of magnons are excited by parametric pumping [217]. This saturates the magnon gas and leads to a large occupation of the lowest magnon modes. Because the magnons are pumped at energies that are much smaller than $k_B T$, this situation does not involve the Bose-Einstein distribution function and has been dubbed Rayleigh-Jeans condensation [286]. This is different from other types of pumped condensates, such as exciton-polaritons [287] and photons [288], in which the pumping is at energies on the same order or larger than $k_B T$. Other regimes of magnon BEC have been reached by heating with a current pulse and subsequent fast cooling, and involves all magnons at thermal energies [289]. The so-called spin-caloritronic nano-oscillator, in which thermal magnons are injected into a magnetic insulator via the spin Seebeck effect, may be interpreted as quasi-equilibrium magnon BEC [291]. Very recently, magnon BEC by electric spin injection was reported [292]. Finally, we remark that in quasi-equilibrium magnon BEC the condensate is dynamic and leads to time-dependent magnetization dynamics, for example the nano-oscillator mentioned above. An equilibrium magnon BEC, on the other hand, corresponds to a static situation.


=== Spin superfluidity
<spin-superfluidity>
Magnon condensation may underly spin superfluidity#footnote[The connection between BEC and superfluid is a subtle issue. It is possible to have superfluid (BEC) without the presence of BEC (superfluid). More detailed discussion can be found in Ref. [293]]. In particular, the magnetization dynamics of the easy-plane ferromagnet, discussed above may --- in the condensed phase --- in the continuum limit be recast in terms of superfluid hydrodynamic equations. That is, inserting the ansatz $⟨hat(S)⟩ = S (sqrt(n_c\/s) cos phi.alt ,sqrt(n_c\/s) sin phi.alt , 1-n_c\/s)$, with $s = S \/ d^3$ the spin density and $d$ the lattice constant, into the LLG equation yields the equations 
$
frac(partial phi.alt, partial t) &= mu _0 g_e mu _B H-2|K_z|S+ 2|K_z| S n_c\/s, \ 
 frac(partial n_c, partial t) &= - bold(nabla) ⋯ (j)_s,
$ <eq:superfluidhydro> for $n_c lt.double s$. Here we have neglected the Gilbert damping. The spin supercurrent $(j)_s = n_c bold(nabla) phi.alt$ is proportional to the gradient of the angle $phi$ that plays the role of phase of the condensate. The influence of damping and anisotropies on spin superfluidity have been discussed extensively by Sonin [294,295]. Recent research has focused on spin superfluidity in devices in which heavy metallic leads serve as spin injectors and detectors [296] and the first experimental results have been reported [297,298,299]


=== Strongly-correlated magnon states
<strongly-correlated-magnon-states>
In addition to the states relevant for BEC, magnons may enter more exotic quantum-many body states. Hamiltonian for the easy-plane magnetic insulator, for example, features a zero-temperature Mott-insulator-to-superfluid transition [300] for large enough $| K_z[95] |$ That is, for $| K_z | gt.double J$, the magnons are localized on each lattice site because of the interactions and the system has a gap $tilde | K_z |$. This state is approximated by $
| Psi _"MI"⟩ prop product _(i=1)^N [ (hat a_i^† )^N_f ] |0⟩ ,
$ where $N$ is the number of lattice sites and $N_f$ is the filling of the Mott insulator, i.e., the number of magnons that are localized on-site, which is tuned by the external field. This state should be contrasted with the superfluid, i.e., BEC, phase in which all particles are in the zero momentum state, and which occurs for $J gt.double | K_z |$. This state reads for the same number of magnons $
| Psi _"SF"⟩ prop ( sum _(i=1)^N hat a_i^† )^N_f|0⟩ .
$ Other examples of quantum many-body states are that of pair condensation of magnons, i.e., states with $chevron.l hat(a) chevron.r = 0$ while $chevron.l hat(a) hat(a) chevron.r eq.not 0$. This situation corresponds to condensation of pairs or BCS-like state for magnons. Examples of the above states may be found in compounds studied within the field of quantum magnetism [301,302]. For example, the Mott insulator mentioned above is an example of a gapped quantum paramagnet. It should be noted, however, that in actual quantum magnets the excitations are often more complicated than the HP magnons that we consider here.


This ends our review of the quantum states of magnons. In the next section, we introduce the developments concerning coupling magnons to various quantum platforms, including photons, qubits, phonons, and electrons. Note that the detection of the quantum states of magnons may also require the coupling of magnons with other quantum systems. For example, by counting photons when they are coupled to magnons, one is able to deduce the statistics of magnon distribution [198]. By detecting the photoluminescence spectrum of a NV center coupled to the magnetic system, the BEC state of magnons may be measured [303]. It would also be meaningful to study the influence of magnon-photon coupling on the phase diagram of the quantum many-body states, which may resemble the situation of a bosonic atomic gas inside a cavity [304]


= Magnon + X
<sec_magnonX>
As information carriers, a great advantage of magnons is that there are various knobs to efficiently control their generation, propagation and detection. For example, magnons are generated by microwaves, spin-orbit torques [33,34,35,36,37], thermal gradients [44,45,46,47], and mechanical strain, and can be detected by optical means [305], microwave antennas [306], heavy metals through inverse spin Hall effect [307] and even spin qubits [198]. When we integrate a magnonic system with other quantum systems (denoted as $upright(X)$) such as cavity photons, superconducting qubits, NV centers and mechanical oscillators, it is desirable that the hybrid system benefits from the manipulation tools that have been and are developed in magnon spintronics, which extend the horizon of the coupled quantum systems. At the same time, the introduction of X helps to study quantum states of magnons and push magnonics to the quantum regime. For example, the entanglement between magnons and qubits enables the detection of single-magnon states [198]. The hybrid platforms have already generated multiparticle entanglement among magnons, photons and phonons for continuous variable quantum information and have found inspiring applications to design quantum transducers, quantum memories and high precision measurements. Following this line of mutual benefit between magnons and other quantum systems, we shall review the recent developments concerning hybrid magnon-photon systems in @sec_magnon_photon, magnon-qubit systems in @sec_magnon_qubit, magnon-phonon systems in @sec_magnon_phonon, and magnon-electron systems in @sec_magnon_electron. The field that focuses on the magnon-photon interaction is also dubbed cavity magnonics or spin cavitronics.


== Hybrid magnon-photon system
<sec_magnon_photon>


=== Overview
<overview>
People's interests in coupling magnets to microwaves can be traced back to the 1960s, where mode splitting from the coupling of the magnetic mode and the microwave mode was observed in ferrimagnet-loaded cavity resonators [308,309,310]. One popular theory to explain this coupling is coupled-mode theory [308]. This theory separates the magnetic fields into a superposition of a rotational and irrotational parts, and then expands the hybrid fields in terms of both electromagnetic and magnetostatic modes. This treatment leads to coupled equations for all mode amplitudes, whose solution yields the coupled spectrum. The coupling strength of magnet and microwave is proportional to the overlap of the electromagnetic wave with the magnetostatic mode inside the magnet as, $- mu_0 integral_V upright(bold(H)) dot.op upright(bold(M)) d^3 r$, where the integral is performed over the whole magnetic body. This coupling phenomenon is purely classical, and is well described by classical electromagnetism.


After a half century of dormancy, this topic was revisited by Soykal et al. in 2010 [311]. The interaction of magnon and photon is rewritten in second-quantized form as $hat(cal(H))_"int" = g_(m c) ( hat(a) + hat(a)^dagger ) ( hat(c) + hat(c)^dagger )$, after performing a HP transformation on the magnetization and quantizing cavity's electromagnetic waves. In the rotating wave approximation, the coupling takes the coherent form $cal(H)_"int" = g_(m c) ( hat(a)^dagger hat(c) + hat(a) hat(c)^dagger )$. It was found that the interaction between a YIG sphere and a microwave cavity can reach the strong-coupling regime and that the spin-photon hybrid state has a long spin dephasing time of roughly 14 seconds. In 2013, Huebl et al. [312] experimentally observed the strong coupling between the uniform magnon mode in YIG and a superconducting coplanar microwave resonator, and found that the energy level splitting is larger than the dissipation of the system. Since then, more experiments demonstrated such a coherent and strong coupling between magnons and photons, using various types of cavities and probing techniques [313,314,315,316,317,318,319]. Such strong coupling was also observed in antiferromagnetic systems [320,321,322,323]. In 2018, Vahram et al. [324] theoretically studied the interaction of two electromagnetic waves with one magnet and found that the resulting spectrum displays energy level attraction by tuning the relative phases of the two electromagnetic waves. Such an anomalous spectrum was observed in experiments by Harder et al. in a Fabri-Perot cavity [325], Bhoi et al. in an inverted pattern of split-ring resonator [326] and Boventer et al. in a reentrant cavity resonator [327]. For a consistent understanding of the energy level repulsion and attraction, Yu et al. [328] highlighted the role of travelling-wave modes with strong dissipation in the open cavity. Here the traveling-wave modes couple to both standing-wave photon and magnons and produce an effective complex coupling between magnons and photons. When the coupling is purely real (imaginary), the spectrum displays energy level repulsion (attraction). Yao et al. [329] also identified the role of the travelling wave mode for the energy level spectrum. The various coupled spectra at room temperature are still mostly classical, and are well described by classical electromagnetism This explains why the numerical solution of the coupled Maxwell and LLG equation, for example, by COMSOL Multiphysics, is sufficient to recover the spectrum observed in the experiments [328]. The use of quantum model that results from quantizing the magnetic excitations and the cavity electromagnetic waves provides an alternative angle to understand the essential physics, but it is not enough to claim quantum aspects of the physics.


Here, we mention some recent reviews on cavity spintronics [335,336,337]. Li et al. [335] outline the potential of hybrid magnetic systems for transformative applications in devices, circuits and information processing. Harder et al. [336] focused on the coherent and dissipative coupling characterized by level repulsion and attraction respectively. Rameshti et al. [337] reviewed the coupling of magnons with photons at frequencies ranging from microwaves to optical regimes. In particular, they present a semiclassical approach to model cavity spintronics and further briefly address the coupling of magnons with superconducting qubits. Here, we shall follow the framework sketched in Fig. to review the recent progress concerning quantum phenomena in the hybrid systems. In particular, we shall focus on the quantum entanglement between magnons and photons. The various energy spectra of the hybrid systems as already reviewed by Rameshti et al. [337] will not be covered in this section.


=== Magnon-photon entanglement
<sec_mpEn>
Li et al. studied steady-state magnon-photon entanglement in a hybrid magnet-cavity system in 2018 [338]. Because the methodology used in this work has wide applicability, we introduce the essential details here. The authors studied the hybrid system shown in @fig:auto12(a) that is described by the Hamiltonian $ hat(cal(H)) = omega_c hat(c)^dagger hat(c) + omega_r hat(a)^dagger hat(a) + omega_b \/ 2 ( hat(q)^2 + hat(p)^2 ) + g_(m b) hat(a)^dagger hat(a) hat(q) + g_(m c) ( hat(a) + hat(a)^dagger ) ( hat(c) + hat(c)^dagger ) + i Omega ( hat(a)^dagger e^(- i omega_0 t) - hat(a) e^(i omega_0 t) )   $ where $hat(c)$ ($hat(c)^dagger$) and $hat(a)$ ($hat(a)^dagger$) are respectively the annihilation (creation) operators for the cavity photons and magnons. Furthermore, $hat(q)$ and $hat(p)$ are the position and momentum operators for the mechanical oscillations of the magnetic sphere and $g_(m b)$ and $g_(m c)$ are the magnon-phonon and magnon-photon coupling strengths, respectively. Detailed justification of the magnon-phonon coupling term in the Hamiltonian can be found in Ref. [339] and is briefly introduced when we review the magnon-phonon interaction in Section~#ref(<sec_magnon_phonon>, supplement: none). Typically, the phonon frequency corresponding to the mechanical deformation of YIG is much smaller than the magnon frequency, i.e., $omega_b lt.double omega_(c, a)$ such that a strong driving $Omega$ of the magnon mode is required to induce a sizeable coupling between magnons and phonons. In the rotating frame at the driving frequency $omega_0$, the quantum Heisenberg-Langevin equations are written as 
#eqgroup((
  [$ frac(d hat(c), d t) = - i ( Delta_c - i kappa_c ) hat(c) - i g_(m c) hat(a) + sqrt(2 kappa_c) hat(c)^(i n) $ <langevin_Li2018>],
  [$ frac(d hat(a), d t) = - i ( Delta_a - i kappa_a ) hat(a) - - i g_(m c) hat(a) - i g_(m b) hat(a) hat(q) + sqrt(2 kappa_m) hat(a)^(i n) $],
  [$ frac(d hat(q), d t) = omega_b hat(p), quad frac(d hat(p), d t) = - omega_b hat(q) - gamma_b hat(p) - g_(m b) hat(a)^dagger hat(a) + hat(zeta) $],
), base: 94)
where the detunings $Delta_c = omega_c - omega_0, Delta_a = omega_a - omega_0$, $kappa_a$, $kappa_m$ and $gamma_b$ are the dissipation coefficients of photon, magnon and phonon, respectively. $c^(i n)$,~$a^(i n)$ and $zeta$ denote the respective Gaussian noises associated with these dissipation coefficients. The noise has zero mean and nonzero second-order correlations given by
#eqgroup((
  [$ chevron.l hat(nu)^(i n) ( t ) hat(nu)^(i n dagger) ( t' ) chevron.r = ( n_nu + 1 ) delta ( t - t' ), chevron.l hat(nu)^(i n dagger) ( t ) hat(nu)^(i n) ( t' ) chevron.r = n_nu delta ( t - t' ) $],
  [$ chevron.l hat(zeta) ( t ) hat(zeta) ( t' ) + hat(zeta) ( t' ) hat(zeta) ( t ) chevron.r = ( 2 n_b + 1 ) gamma_b delta ( t - t' ) $],
), base: 95) where $hat(nu) = hat(c), hat(b)$, $n_c$,$n_b$, and $n_a$ are respectively the Bose-Einstein distributions for the photons, phonons and magnons, which depend on temperature.


Since the magnons are strongly driven and are strongly coupled to photons, i.e., $| chevron.l hat(a) chevron.r | gt.double 1$, $| chevron.l hat(c) chevron.r | gt.double 1$, the magnon and photon states can be expanded around their mean-field values $hat(O) = chevron.l hat(O) chevron.r + delta hat(O)$ ($hat(O) = hat(c), hat(a), hat(q), hat(p)$). The linearized form of Eq. #eqref-parent(<langevin_Li2018>) that describes the evolution of the quadrature fluctuations is written as, $d hat(upright(bold(u))) \/ d t = upright(bold(A)) dot.op hat(upright(bold(u))) + hat(upright(bold(n)))$, where $hat(upright(bold(u))) = ( delta hat(X), delta hat(Y), delta hat(x), delta hat(y), delta hat(q), delta hat(p) )^T$, $hat(upright(bold(n))) = ( sqrt(2 kappa_c) hat(X)^(i n), sqrt(2 kappa_c) hat(Y)^(i n), sqrt(2 kappa_m) hat(x)^(i n), sqrt(2 kappa_m) hat(y)^(i n), 0   hat(zeta) )^T$ is the vector of input noises, and $upright(bold(A))$ is the drift matrix of the system. The quadrature operators are defined as $delta hat(X) = ( delta hat(c) + delta hat(c)^dagger ) \/ sqrt(2), delta hat(Y) = ( delta hat(c) - delta hat(c)^dagger ) \/ sqrt(2) i$,$delta hat(x) = ( delta hat(a) + delta hat(a)^dagger ) \/ sqrt(2), delta hat(y) = ( delta hat(a) - delta hat(a)^dagger ) \/ sqrt(2) i$. Gaussian nature of noise guarantees that the steady-state solution to this set of linearized equations is a Gaussian state and thus is completely characterized by a $6 times 6$ covariance matrix $upright(bold(V))$, as introduced in Section~#ref(<sec_cvs>, supplement: none). The covariance matrix is derived by solving the Lyapunov equation $upright(bold(A V)) + upright(bold(V A)) = - upright(bold(D))$, where $upright(bold(D)) = "diag" { kappa_c ( 2 n_c + 1 ), kappa_c ( 2 n_c + 1 ), kappa_m ( 2 n_a + 1 ), kappa_m ( 2 n_a + 1 ), 0   gamma_b ( 2 n_b + 1 ) }$ is the diffusion matrix. From the tripartite covariance matrix, one can trace one part and quantify the entanglement between the remaining two parts. In principle, one can also solve the master equation [109] of the system numerically to get the steady density matrix, based on which we can also evaluate the covariance matrix by $V_(i j) = 1 \/ 2 "tr" [ rho ( u_i u_j + u_j u_i ) ]$. Using this approach, a proper truncation of the Hilbert space has to be taken to guarantee the convergence of the evolution.


#ref(<fig:auto12>, supplement: "(b-d)") show the steady entanglement among magnons and photons using the experimentally feasible parameters [339] while the temperature is taken 10 mK to suppress the decoherence of quantum states. There exists a parameter regime ($Delta_a approx omega_b, Delta_c approx - omega_b$), where all the degrees of freedoms, i.e., magnon-photon, magnon-phonon and photon-phonon, are entangled. Here the nonlinear magnon-phonon interaction ($G_(m b) = i sqrt(2) g_(m b) chevron.l m chevron.r$) plays a key role to mediate the indirect entanglement between magnons and photons. Without this interaction, the beam-splitter type of interaction between magnons and photons does not generate any finite entanglement, as shown on the bottom of @fig:auto12(e) ($G_(m b) = 0$). Besides bipartite entanglement, a parameter regime of finite tripartite entanglement is also identified. In follow-up works, the authors showed that two cavity photons can be prepared in a stationary entangled state if they are respectively resonant with two mechanical side bands of the system [341]. Again, the nonlinearity caused by the magnetostrictive interaction between magnons and phonons is crucial to maintain the robustness of this entangled state. The authors also showed that magnons in a setup similar to @fig:auto12(a) can be prepared in a squeezed state via the beam-splitter interaction of magnons and photons, when the cavity is driven by a squeezed vacuum field [218]. Tan [342] identified both bipartite and tripartite EPR steering in such a hybrid system and found that continuous measurement of the cavity fields significantly enhances the bipartite steering.


// [figvision-cn] imgs/Limpp2018.png
// (a) 子图类型：示意图与频谱图组合。上半部分为混合磁体-
// 腔系统的三维结构示意图，展示一个YIG球体置于微波腔内，
// 腔体由两侧灰色弧形壁表示，中间橙色曲线代表腔模磁场分布
// （标记为c），YIG球位于磁场波腹处。图中建立右手坐标系：
// x轴水平向右，y轴垂直纸面向外，z轴竖直向上。紫色箭头表
// 示外加静磁场方向沿z轴正方向，用于调谐磁振子频率。虚线
// 框b放大显示YIG球及其周围声子模式（用双向箭头示意）。下
// 半部分为频谱图，横轴为角频率ω，纵轴无标度但示意振幅。
// 左侧峰对应腔模ω_c，右侧峰对应磁振子模ω_a，两峰之间距离
// 标注为Δ_a；在ω_c附近有一个窄峰标记为κ_c，其中心位置相
// 对于ω_b偏移量为ω_0 - ω_b；在ω_a附近有一个窄峰标记为κ_m，
// 其中心位置相对于ω_b偏移量为ω_0 + ω_b。两个主峰之间的失
// 谐量分别标注为-Δ_c（左）和Δ_a（右）。该子图传达系统构
// 型及关键能级关系。 (b) 子图类型：二维热图（色阶图）。
// 横轴为归一化失谐量Δ_c / ω_b，范围从-2到+2；纵轴为归一
// 化驱动强度Δ̃_ml / ω_b，范围从0.6到1.4。颜色条位于右侧，
// 数值范围0至0.125，颜色从深蓝（低值）渐变至黄绿（高值），
// 物理含义为磁振子-光子纠缠度量G_mp / g_mc。图中可见一条
// 垂直亮带位于Δ_c / ω_b ≈ -1处，表明在此失谐下纠缠最强，
// 且随驱动强度增加而增强，峰值出现在Δ̃_ml / ω_b ≈ 1.0附
// 近。 (c) 子图类型：二维热图。横轴同(b)，为Δ_c / ω_b ∈
// [-2, 2]；纵轴同(b)，为Δ̃_ml / ω_b ∈ [0.6, 1.4]。颜色条
// 位于右侧，数值范围0至0.15，颜色从深蓝至黄白，物理含义
// 为磁振子-声子纠缠度量G_mb / g_mb。图中可见两条对称亮带，
// 分别位于Δ_c / ω_b ≈ ±1处，表明在正负失谐下均存在强纠缠，
// 且在Δ̃_ml / ω_b ≈ 0.8–1.0区间达到最大值，中心区域（Δ_c
// =0）为暗区，纠缠最弱。 (d) 子图类型：二维热图。横轴同(
// b,c)，为Δ_c / ω_b ∈ [-2, 2]；纵轴同(b,c)，为Δ̃_ml / ω
// _b ∈ [0.6, 1.4]。颜色条位于右侧，数值范围0至0.20，颜色
// 从深蓝至黄白，物理含义为光子-声子纠缠度量G_cp / g_cp。
// 图中可见一条垂直亮带位于Δ_c / ω_b ≈ -1处，形态与(b)相
// 似但更宽，表明光子-声子纠缠在此失谐下显著，且随驱动强
// 度增加先增后减，峰值约在Δ̃_ml / ω_b = 1.0。 (e) 子图类
// 型：二维热图。横轴为Δ_c / ω_b ∈ [-2, 2]；纵轴为耦合强
// 度比值G_mb / g_mc，范围从0.0到1.0。颜色条位于右侧，数
// 值范围0至0.125，颜色从深蓝至浅绿，物理含义为磁振子-声
// 子纠缠度量G_mb / g_mb。图中可见一条垂直亮带位于Δ_c / ω
// _b ≈ -1处，表明即使改变耦合强度参数，磁振子-声子纠缠仍
// 集中在该失谐点，且整体强度低于其他子图所示情况。
#figure(placement: top, image("imgs/Limpp2018.png", width: 100.0%),
 caption: [
 (a) Schematic of the hybrid magnet-cavity system. A YIG sphere is placed at the position with maximum cavity magnetic field and an extra static magnetic field is applied to tune the magnon frequency. The bottom panel shows the frequencies and linewidth of magnon mode ($hat(a)$), cavity mode ($hat(c)$) and phonon mode ($hat(b)$). (b) Entanglement of magnon-photon $E_(a c)$, (c) magnon-phonon $E_(a b)$ and (d) photon-phonon $E_(c b)$ degrees of freedom versus detunings $Delta _c$ and $Delta _a$. (e) Magnon-photon entanglement versus $Delta _c$ and $G_(m b) \/ g_(m c)$. Source: The figures are adapted from Ref. [338].
 ]
) <fig:auto12>



Yuan et al. found an alternative way to entangle magnons and photons without including nonlinear magnon-phonon interactions in the Hamiltonian explicitly. They considered dissipative coupling between magnons and photons, as already realized in several experiments [325,326,327]. This hybrid system is usually described by the non-Hermitian Hamiltonian 
$
cal(hat(H)) & = omega_r hat(a)^dagger hat(a) + omega_c hat(c)^dagger hat(c) + g (hat(c)^dagger hat(a) + e^(i Phi) hat(c) hat(a)^dagger)
$ <ham> where $hat(a) med ( hat(a)^dagger )$ and $hat(c) med ( hat(c)^dagger )$ are respectively, annihilation (creation) operators of magnons and photons. $omega_r$ is the magnon frequency, which can be tuned by external magnetic field, $g$ is the effective coupling strength between magnons and photons, and $Phi$ is a tunable phase factor due to backaction effects. Such an effective Hamiltonian #ref(<ham>, supplement: none) describes the energy level repulsion and attraction which are observed in experiments very well [325,326,327]


// [figvision-cn] imgs/bell_state.png
// 该图由五个子图（a至e）组成，展示了混合磁体-腔系统的能
// 级特性、纠缠演化及鲁棒性。 子图 (a) 是一个二维曲线图，
// 展示混合磁体-腔的能级吸引现象。横坐标为归一化失谐量 $\
// Delta$，范围从 -5 到 5；纵坐标为归一化频率 $\omega/\
// omega_c$，范围从 0.0 到 2.0。图中包含两条实线代表特征
// 值的实部：一条黑色实线和一条红色实线。在 $\Delta < -1$
// 和 $\Delta > 1$ 的区域（标记为 PT-exact），黑线与红线
// 分离；在 $-1 < \Delta < 1$ 的区域（标记为 PT-broken，
// 背景为淡粉色），两线重合为一条水平红线。图中还有两条虚
// 线代表特征值的虚部：一条红色虚线始终位于纵坐标 0.0 处；
// 另一条黑色虚线在 PT-exact 区域位于 0.0，在 PT-broken
// 区域拱起形成半圆形凸起。两个箭头分别指向 $\Delta = -1$
// 和 $\Delta = 1$ 处的交汇点，标注为 EP1 和 EP2。 子图 (
// b) 是一个二维曲线图，展示随时间演化的纠缠度和保真度。
// 横坐标为归一化时间 $\omega_c t$，范围从 0.0 到 50.0；
// 纵坐标无明确标签，数值范围从 0.0 到 1.0。图中有三条曲
// 线：蓝色实线代表保真度（Fidelity），从约 0.7 迅速上升
// 至 1.0 并保持平稳；黑色点划线代表纠缠度 $N$，从 0 迅速
// 上升并趋近于 1.0；红色虚线代表纠缠度 $E_N$，从 0 上升
// 并趋近于 0.7。图右侧有一条紫色虚线对应纵坐标 0.7 左右
// 的位置，标注为 ln2。图右下角有文字标注 $\gamma=0$。 子
// 图 (c) 是一个散点图，展示稳态贝尔态对耗散的鲁棒性。横
// 坐标为归一化耗散率 $\kappa_m/g$，范围从 0.0 到 2.0；纵
// 坐标无明确标签，数值范围从 0.0 到 1.0。图中有两组数据
// 点，均随横坐标增加而下降。一组是空心圆圈、方块和三角形，
// 代表保真度（Fidelity），初始值接近 1.0；另一组是实心圆
// 点、方块和三角形，代表纯度（purity）或纠缠度 $E_N$，初
// 始值约为 0.7。图例显示不同形状对应不同的耦合强度比值 $
// g/\omega_c$：黑色实心圆点对应 0.1，红色实心方块对应
// 0.01，蓝色实心三角对应 0.0027。左侧有一个箭头指向低横
// 坐标处的实心点，标注为 $E_N$。 子图 (d) 包含两个并列的
// 二维曲线图，展示不同条件下的动力学演化。左图和右图的横
// 坐标均为归一化时间 $\omega_c t$，范围从 0 到 100；纵坐
// 标范围从 0.0 到 1.0。 左图中，蓝色实线（Fidelity）在
// 0.8 到 1.0 之间周期性振荡；红色虚线（$E_N$）在 0.4 到
// 0.6 之间周期性振荡；黑色点划线（$N$）保持在 1.0 的水平
// 直线上。 右图中，三条曲线均呈现衰减振荡趋势。蓝色实线
// 从 1.0 开始衰减；黑色点划线从 1.0 开始衰减至 0.3 左右；
// 红色虚线从 0.5 左右开始衰减至 0.1 左右。图右侧有图例说
// 明线型含义：黑色点划线为 $N$，红色虚线为 $E_N$，蓝色实
// 线为 Fidelity。 子图 (e) 是一个相图与散点结合图，展示
// 纠缠度随失谐量的变化。横坐标为归一化失谐量 $\Delta$，
// 范围从 -6 到 6；纵坐标为纠缠度 $E_N$，范围从 0.2 到
// 0.8。背景分为三个区域：中间淡粉色区域为 PT-broken ($\
// Delta$ 约在 -1 到 1 之间)，两侧淡蓝色区域为 PT-exact。
// 边界处标注了 EP1 和 EP2。图中分布着多个空心圆圈，代表
// 在不同 $\Delta$ 下的 $E_N$ 值。这些圆圈在 PT-exact 区
// 域大致呈抛物线状分布，而在 PT-broken 区域内，圆圈密集
// 分布在顶部附近。图中有一条紫色水平虚线贯穿整个区域，高
// 度约为 0.7，右侧标注为 ln2。
#figure(placement: top, image("imgs/bell_state.png", width: 100.0%),
 caption: [
 (a) Level attraction of a hybrid magnet-cavity described by Eq. #ref(<ham>, supplement: none) for $Phi =pi$. The solid and dashed lines represent the real and imaginary parts of the eigenvalues, respectively. (b) Evolution of the entanglement and the fidelity of the temporal state to the Bell state as a function of time. (c) Robustness of the steady Bell state against dissipation with different coupling strengths between magnons and photons ($g$). (d) Evolution of the entanglement for the coherent coupling between magnons and photons without (left) and with (right) dissipations. (e) Magnon-photon entanglement as a function of the detuning between magnons and photons. Source: The figures are adapted from Ref. [201].
 ]
) <fig:auto13>


@fig:auto13(a) shows a typical spectrum corresponding to energy level attraction with $Phi = pi$. As the detuning between the magnon frequency and the cavity frequency ($Delta equiv omega_r - omega_c$) changes, the system evolves from a $cal(P T)$ exact phase with purely real eigenvalues to a $cal(P T)$ broken phase with complex eigenvalues. In the transition between these two phases, two exceptional points (EPs) located at $Delta = plus.minus 1$ are identified. To study the dynamics of magnons and photons in both $cal(P T)$ exact and $cal(P T)$ broken phases, one decouples the non-Hermitian Hamiltonian into a Hermitian component ($hat(cal(H))_H equiv ( hat(cal(H)) + hat(cal(H))^dagger ) \/ 2$) and an anti-Hermitian component ($hat(cal(H))_A equiv ( hat(cal(H)) - hat(cal(H))^dagger ) \/ 2$). Here the Hermitian part and anti-Hermitian part characterize the unitary evolution, and gain/loss of the system, respectively. The master equation governing the evolution of the joint density matrix of the system ($hat(rho)$) may be written as [343,344,345]:

$
partial_t hat(rho) = - i [ hat(cal(H))_H, hat(rho) ] - i { hat(cal(H))_A, hat(rho) } + 2 i "tr" ( hat(rho) hat(cal(H))_A ) hat(rho) ,
$ <me_nonhermitian> where the brackets $[ ~ ]$ and $"{ ~ }"$ refer to commutator and anticommutator of two operators, respectively. The third non-linear term on the right-hand side of Eq. #ref(<me_nonhermitian>, supplement: none) is added to preserve $"tr" ( hat(rho) ) = 1$ and thus guarantees the stability of the system. Equation #ref(<me_nonhermitian>, supplement: none) preserves the total probability of the system ($"tr" ( rho ( t ) ) = 1$). A more detailed discussion of this master equation has been presented by Brody et al. [345]. Physically, the non-linear effect in a magnonic system may come from the magnon-magnon interactions caused by exchange and dipolar interactions, which will suppress the divergence of the magnon density [346,347,348,349]. A similar approach was adopted in a single quantum system with $cal(P T)$ symmetry [350].


By solving the quantum master equation #ref(<me_nonhermitian>, supplement: none), it is found that the hybrid system evolves to a steady state with entanglement $ln 2$, which is the maximum amount of entanglement of two qubits. To understand the structure of this steady state, the authors analytically derived the evolution of the density matrix and found that the eigenstate $| phi.alt_s chevron.r = ( | 10 chevron.r + e^(i phi_s) | 01 chevron.r ) \/ sqrt(2)$ of the Hamiltonian eventually dominates the steady state, with $phi_s = arccos ( Delta )$. Note that the state $| phi.alt_s chevron.r$ is a Bell state and that it has maximum entanglement $E_N ( | phi.alt_s chevron.r chevron.l phi.alt_s | ) = ln 2$ as shown in @fig:auto13(b). One can check the fidelity of the density matrix with respect to the Bell state ($F equiv "tr" sqrt(chevron.l phi.alt_s | hat(rho) | phi.alt_1 chevron.r)$) as a function of time, showing that it indeed approaches one in the steady case. This clearly proves that the steady Bell state is generated in the hybrid system. Furthermore, such a state is robust against dissipation ($kappa_m$) as long as $kappa_m < g$, as shown in @fig:auto13(c). Using the experimental parameters that correspond to a millimeter-sized YIG sphere inside a Fabry-Perot cavity [325], the fidelity of the generated Bell state is $97.85 %$. For comparison, in the $cal(P T)$ exact phase, the system keeps oscillating and no steady Bell states are generated, as illustrated in @fig:auto13(d). This result can also be viewed as Rabi oscillations and it applies to the original proposal put forth in Ref. [311], where the real beam-splitter type interaction cannot generate a steady entanglement between magnons and photons. A complete phase diagram of the system is found in @fig:auto13(e). Xie et al. proposed a Bell test using the hybrid magnet-cavity system in a recent preprint [351]


=== Magnon-magnon entanglement
<sec_magnonmagnon>
Besides magnon-photon entanglement, magnon-magnon entanglement is another interesting topic because of its fundamental importance to understand macroscopic quantum phenomena and the classical-quantum transition in magnetic systems, and their potential applications in continuous variable quantum information. Depending on whether the two magnons are excited in the same or two separate magnets, the study of magnon-magnon entanglement is progressing towards two directions. The first direction deals with the entanglement between magnons excited in two distant magnetic systems through their simultaneous interaction with a third subsystem, for example, a cavity. Here we will not cover the magnon-magnon coupling in hybrid nanostructures contain two magnetic layers, which can be well understood in the classical regime [352,353,354,355]. The second direction concerns the entanglement of magnons in ferri/anti-ferromagnets, where the two types of magnons are excited on the two sublattices of a magnet. The two directions are similar in that parametric interactions (or squeezing interactions) between the magnons are essential to generate a finite steady-state entanglement. As briefly discussed in @sec_squeezedmagnon above, the ground state and magnon modes in an anisotropic ferromagnet were demonstrated to be related to spin-flips in the magnet via single- and two-mode squeeze operators in 2016 [103,104]. Similar considerations in ferri- and antiferromagnets have been presented in 2017 [215]. However, while commenting on the relation between squeezing and entanglement [104], the authors did not study the entanglement, a task having received increasing attention in recent years as discussed further below.





// [figvision-cn] imgs/magnon_magnon_entangle_Zhang.png
// 子图(a)为示意图，展示两个相距较远的磁性钇铁石榴石（YIG）
// 小球在腔场作用下发生纠缠的物理系统。图中左侧标注“
// Microwave drive”并配有紫色正弦波形箭头指向绿色弧形结构，
// 该结构代表微波驱动输入；绿色弧形结构下方标有“Cavity”，
// 表示光学或微波谐振腔体；从腔体向左延伸出一个黄色粗箭头，
// 标注“Leakage”，表示能量泄漏路径。腔体内有两个红色实心
// 圆球，分别标记为“YIG1”和“YIG2”，代表两个磁振子系统。两
// 球之间由一条蓝色波浪线连接，象征通过腔场实现的耦合与纠
// 缠。每个YIG球周围均有四条蓝色波浪线向外辐射，底部统一
// 标注“Magnon dissipation”，表示磁振子耗散过程。在YIG1上
// 方有一个竖直向上的黑色箭头，标注“B₀”，表示外加静磁场方
// 向。左下角绘制三维直角坐标系，x轴水平向右，y轴垂直向上，
// z轴指向观察者，用于定义空间取向。整体布局从左至右依次
// 为：微波驱动→腔体→YIG1↔YIG2耦合→右侧开放端（未封闭），
// 暗示非对称边界条件。 子图(b)为二维热图，量化磁振子-磁
// 振子纠缠程度。横坐标为F (GHz)，范围从-0.05到+0.05 GHz；
// 纵坐标为G (GHz)，范围同样为-0.05到+0.05 GHz。颜色条位
// 于图右侧，数值范围从0（黑色）到0.25（浅绿色），中间过
// 渡色包括深绿、黄绿等，颜色越亮表示纠缠度量值越高。图像
// 中心区域（F≈0, G≈0）呈现深色圆形凹陷，表明在此参数点纠
// 缠度最低；随着远离原点，颜色逐渐变浅，在四个象限边缘处
// 达到最亮的浅绿色，显示纠缠强度随频率失谐增大而增强。无
// 额外曲线或符号，仅以连续颜色梯度表达函数分布。结论：磁
// 振子间纠缠在零频差时最小，随频率偏移增加而单调上升，具
// 有中心对称性。 子图(c)亦为二维热图，量化磁振子-光子纠
// 缠程度。坐标轴设置与子图(b)完全一致：横坐标F (GHz) ∈ [
// -0.05, 0.05]，纵坐标G (GHz) ∈ [-0.05, 0.05]。右侧颜色
// 条范围为0（黑色）至0.15（浅绿色），比子图(b)最大值更低，
// 说明磁振子-光子纠缠整体弱于磁振子-磁振子纠缠。图像形态
// 与(b)相似：中心深色区对应低纠缠，外围渐变为浅色高纠缠
// 区，但最大值为0.15而非0.25，且颜色过渡更平缓。无其他图
// 形元素。结论：磁振子与光子之间的纠缠也随频率失谐增大而
// 增强，但在相同参数下其强度约为磁振子-磁振子纠缠的60%左
// 右，反映不同自由度间耦合效率差异。
#figure(placement: top, image("imgs/magnon_magnon_entangle_Zhang.png", width: 100.0%),
 caption: [
 (a) Schematic of two distant magnetic YIG spheres inside a cavity entangled through the cavity field. (b-c) Two-dimensional plots that quantify magnon-magnon entanglement(b) and magnon-photon entanglement (c). Here $G=2v upright(Re) ⟨hat(a)_s⟩^2$, $F=2v upright(Im) ⟨hat(a)_s⟩^2$, $v_1=v_2equiv v$, $⟨hat(a)_s⟩$ is the steady-state magnon amplitude. Source: The figures are adapted from Ref. [356].
 ]
) <fig:auto14>

Zhang et al. [356] studied the entanglement of two distant magnets in a hybrid magnet-cavity system as shown in @fig:auto14. Here the cavity field mediates the coupling of two well-separated magnets and the effective Hamiltonian of the hybrid system is $ hat(cal(H)) = omega_c hat(c)^dagger hat(c) + sum_(j = 1)^2 lr([omega_j hat(a)_j^dagger hat(a)_j + g_j ( hat(c) hat(a)_j^dagger + hat(c)^dagger hat(a)_j ) + v_j hat(a)_j^dagger hat(a)_j hat(a)_j^dagger hat(a)_j)) + i Omega ( hat(c)^dagger e^(- i omega_d t) - hat(c) e^(i omega_d) t ) , $ where $hat(a)_1$ and $hat(a)_2$ are the magnon operators on the first and second magnets, respectively, $hat(c)$ is the cavity photon mode, $v_j$ is the nonlinearity coming from the magnetocrystalline anisotropy of the system, similar to non-linearity that is featured in the discussion in @sec_singlemagnon, and $Omega$ is the driving strength. In the strong driving limit, one can expand the magnon and photon operators around their mean-field values and derive the effective Hamiltonian for the magnonic and photonic fluctuations, as introduced in @sec_mpEn. Then the covariance matrix ($V_(6 times 6)$) is numerically obtained by solving the linearized Langevin equation with Gaussian noise. The entanglement between magnons and photons as quantified by log-negativity is calculated and shown in @fig:auto14(b). Firstly, in the absence of Kerr nonlinearities ($v_1 = v_2 = v equiv 0 , G = F = 0$), there is no entanglement among magnons and photons, because all the remaining interactions between magnons and photons are of the beam-splitter type, which cannot generate any steady-state entanglement. With Kerr nonlinearities ($G F eq.not 0$), the entanglement of magnons appears, because these interactions generate an effective parametric interaction between magnons and thus create a squeezed state of the two distant magnons with finite entanglement. In addition, it is identified that a finite entanglement emerges between magnons and photons as shown in @fig:auto14(c), which is understood in a similar manner.



Li et al. considered a setup similar to the one depicted in @fig:auto14(a), but focused on the nonlinearity coming from the magnetostrictive interaction in the form $hat(a)_1^dagger hat(a)_1 hat(q)$, where $hat(q)$ is the mechanical displacement of the first magnet. The magnetostrictive interaction in the second magnet is not activated upon properly choosing its magnetization direction. They showed that such a nonlinearity generates a finite entanglement between the two distant magnets, which is robust against thermal fluctuation below 0.2 K. Furthermore, the magnon-magnon entanglement can be transferred to the magnon-photon system through beam-splitter type of interactions between magnons and photons. Simon et al. [358] considered an optical resonator loaded with two laser-cooled atomic ensembles and showed that the optical mode of the resonator can help to generate magnon-number entanglement between the two ensembles. In particular, they first generated a single-magnon state in ensemble A with certain probability and then transferred it to ensemble B with the assistance of photons. At the same time, they suppressed the population of the photonic state using the technique of adiabatic dark-state transfer, and thus a partial transfer of a single magnon between these two atomic ensembles is realized. This results in a superposition in which the two atomic ensembles share one magnon. photons, as described by the authors, plays the role of a bus to entangle the two atomic ensembles.


Besides amplifying the nonlinearity in the magnetic system under strong driving to induce the entanglement of magnons, Nair et al. [359] presented a scheme to entangle two macroscopic magnets in the absence of nonlinearities. They proposed to place two YIG spheres in a single cavity and to drive the cavity using a quantum field with strong squeezing. They found that the squeezing property of the driving can be transferred to the cavity field [360] and thus mediates entanglement of two magnetic modes by producing an effective parametric interaction between them. In summary, the effective parametric interaction between two magnons is essential to generate steady-state entanglement of magnons, while the methods to generate such a parametric interaction differ between these proposals. Following a different chain of arguments, Kamra et al. previously demonstrated that the dipolar interaction generates equilibrium squeezing of magnons in a ferromagnetic film [103,104]. Similarly, if we look at two or more sublattice ferrimagnets and antiferromagnets, the magnons excited on each sublattice are naturally exchange-coupled by a parametric interaction because of the antiparallel alignment between the two sublattice magnetizations. It is thus expected that they will form squeezed states with strong entanglement. This idea is illustrated in detail as below.


Yuan et al. [229] and Kamra et al. [161] independently discussed the squeezing and entanglement properties of the antiferromagnetic ground state. To illustrate these ideas, let us consider an anisotropic two-sublattice ferrimagnet, described by the Hamiltonian 
$
cal(H)_("FiM")=J sum _(l,delta) hat(bold(S))_l ⋅ hat(bold(S))_(l+delta) - sum_l [ K_a ( hat(bold(S))_l^z )^2 + K_b ( hat(bold(S))_(l+delta)^z )^2 ] - mu_0 g_e mu_B sum_l bold(H) ⋅ hat(bold(S))_l ,
$ <Ham2subAFM> where $J > 0$ and $K_(a, b) > 0$ denotes the antiferromagnetic coupling between the two sublattices and anisotropy coefficients, respectively, and $upright(bold(H)) = H upright(bold(e))_z$ is an external magnetic field acting on the magnetization, which is assumed to be along the $z$ axis. Following the standard quantization procedures using the HP transformation around the classical ground state $upright(bold(S))_l = S_a upright(bold(e))_z$ and $upright(bold(S))_(l + delta) = - S_b upright(bold(e))_z$, the effective Hamiltonian of the magnon excitations is written as 
$
hat(cal(H)) = omega_a hat(a)_1^dagger hat(a)_1 + omega_b hat(a)_2^dagger hat(a)_2 + g_(a b) ( hat(a)_1^dagger hat(a)_2^dagger + hat(a)_1 hat(a)_2 )
$ <afm_wtphoton> where $hat(a)_1$ and $hat(a)_2$ are the magnon operators on the two sublattices of an antiferromagnet, $omega_a = H_"ex,b" + H_"an,a" + mu_0 g_e mu_B H, omega_b = H_"ex,a" + H_"an,b" - mu_0 g_e mu_B H$, $H_("ex," mu) = 2 Z J S_mu, med H_("an," mu) = 2 K_mu S_mu$~ ($mu = a, b$), $S_mu$ is the magnitude of spin vector, $Z$ is the coordination number, and $g_"ab" = sqrt(H_"ex,a" H_"ex,b")$ is the coupling strength of magnon modes on the two sublattices. The parametric interaction between the two types of magnons is understood as follows. The antiferromagnetic interaction between the two sublattices tends to align the spins antiparallel to each other, for example, in the $+ upright(bold(e))_z$ and $- upright(bold(e))_z$ directions. motion of $upright(bold(S))_1$ ($upright(bold(S))_2$) towards the $+ upright(bold(e))_z$ ($- upright(bold(e))_z$) direction will each annihilate one magnon, i.e., $hat(a)_1 hat(a)_2$. The inverse process will each generate one magnon on the two sublattices, i.e., $hat(a)_1^dagger hat(a)_2^dagger$.


By solving the Heisenberg-Langevin equation for this Hamiltonian #ref(<afm_wtphoton>, supplement: none) in the antiferromagnetic limit ($S_a = S_b equiv S, K_a = K_b equiv K$), the covariance matrix of the system is found to be $ upright(bold(V)) = mat(delim: "(", upright(bold(A)), upright(bold(C)); upright(bold(C))^T, upright(bold(B))) = mat(delim: "(", Lambda_a, 0, Lambda_c, Lambda_d; 0, Lambda_a, Lambda_d, - Lambda_c; Lambda_c, Lambda_d, Lambda_b, 0; Lambda_d, - Lambda_c, 0, Lambda_b; #none)   $ with


#[
  #set math.equation(numbering: none)
  $ Lambda_a & = Lambda_b = 1 \/ 2 (1 + frac(g_(a b)^2, ( H_"ex" + H_"an" )^2 - g_(a b)^2 + gamma_m^2))  Lambda_c & = - 1 \/ 2 frac(g_(a b) ( H_"ex" + H_"an" ), ( H_"ex" + H_"an" )^2 - g_(a b)^2 + gamma_m^2), Lambda_d = - 1 \/ 2 frac(g_(a b) gamma_m, ( H_"ex" + H_"an" )^2 - g_(a b)^2 + gamma_m^2) $
]
where $gamma_m$ is the dissipation coefficient of each sublattice. Then the entanglement of the sublattice magnons is quantified as 
$
E_N = - log( 2 eta^(-) ) = ln(1 + g_(a b) \/ sqrt(( H_"ex" + H_"an" )^2 + gamma_m^2)) .
$ <gsEnAFM> This result suggests that the magnons excited on the two sublattices are always entangled, and the amount of entanglement approaches the value $ln 2$ since $g_(a b) tilde H_"ex" gt.double H_"an", gamma_m$ in a typical crystalline antiferromagnet. In a van der Waals magnet, the anisotropy field can be comparable to and even larger than the exchange field [361], hence the amount of entanglement between sublattice magnons will be reduced. Kamra et al. [161] quantified the entanglement of spatially uniform magnon modes by the entanglement entropy a system described by Eq. #ref(<Ham2subAFM>, supplement: none) and found it increases monotonically with the squeezing parameter. Hartmann et al. [162] calculated the ground-state entanglement entropy by including the contribution from magnons with finite wavevectors by partitioning the antiferromagnet into two sublattices as shown in @fig:auto15(a) and found it scales with the system size in the thermodynamic limit as $ S_(E E) = N^upsilon frac(( 1 + 2^(upsilon - 1) K \/ J )^(upsilon \/ 2), 2^(- upsilon \/ 2 - 1) pi^(upsilon \/ 2) Gamma ( upsilon \/ 2 )) I (upsilon, K \/ J)   $ where $upsilon$ is the dimension of the system and $I$ is a special integral function. With this special partition [@fig:auto15(a), upper panel], the area law becomes a volume law while the density of entanglement entropy becomes an intensive property. The entanglement density is evaluated to be a universal dimensionality-dependent constant when $K lt.double J$. This result was further corroborated by the density matrix renormalization group (DMRG) calculations for a one dimensional spin chain. Wuhrer et al. [233] derived the full statistics of the sublattice magnon number with wave number $upright(bold(k))$ in the ground state. They showed that magnons with opposite wave vectors are always created in pairs and their entanglement, as quantified by the DGCZ inequality [166], decreases at the corners of Brillouion zone. Mousolou et al. [232] identified the relation between bipartite magnon entanglement and the EPR function and proposed a measurement setup based on the interaction of light and antiferromagnets, as shown in @fig:auto15(b). Here the strength of magnon entanglement is quantified by the EPR function $Delta_0$ and it depends sensitively on the magnon-photon transition frequency $f_k$ in the cavity, which can be measured directly. It has also been shown that the Dzyaloshinskii-Moriya (DM) interaction enhances the entanglement for all $upright(bold(k))$ modes


// [figvision-cn] imgs/magnon_magnon_entangle_Akash.png
// 子图(a)为示意图，展示反铁磁系统的两种划分方式。上部图
// 示中，一排水平排列的球体代表晶格位点，球体颜色交替为蓝
// 色和红色，表示两个子晶格；每个球体上附有灰色箭头表示自
// 旋方向：蓝色球体对应向上箭头，红色球体对应向下箭头，形
// 成反平行排列；相邻蓝红球体之间用垂直虚线分隔，共7条虚
// 线，将系统划分为8个单元；该部分用于表征子晶格间纠缠（
// intersublattice entanglement）。下部图示中，同一排球体
// 被一条居中的垂直虚线分为左右两半：左侧4个球体均为蓝色
// 且自旋向上，右侧4个球体均为红色且自旋向下；此划分用于
// 计算中心切割纠缠（central cut entanglement）。所有球体
// 大小一致，箭头长度相同，无坐标轴或数值标注。 子图(b)包
// 含三个部分：左侧为磁-腔系统示意图，中间为EPR函数曲线图，
// 底部为跃迁概率随时间变化曲线图。 左侧示意图：一个黄色
// 长方体标记为“AFM”（反铁磁体），位于左端，其表面绘有两
// 个红色圆圈分别标记为S_a和S_b，代表两个自旋模式；从S_a
// 引出一条红色弯曲箭头指向右方，从S_b引出一条蓝色直线箭
// 头指向右方；AFM右侧连接一段绿色螺旋状波导结构，延伸至
// 右端另一个透明长方体腔体，腔体两侧标有“B_p”，表示泵浦
// 场；整个装置沿z轴方向布置，x-y-z坐标系标注于下方，L为
// 总长度；外部施加磁场B由顶部黑色箭头指示，方向向右。 右
// 上曲线图：横轴为f_k = 1/T_k，范围0.0至2.0，无量纲；纵
// 轴为Δ(f_k, φ_k)，范围0至8，单位未标明但应为无量纲或能
// 量单位；三条曲线分别对应不同λ_k值：蓝色实线对应λ_k = 3
// π/4，单调递增且斜率最大；黑色实线对应λ_k = π，增长较缓；
// 红色实线对应λ_k = 5π/4，增长最慢；三线均从原点附近起始，
// 随f_k增加而上升，表明EPR函数随频率参数增大而增强，反映
// 马格诺模纠缠度提升。 右下曲线图：横轴为Time，范围0至
// 2T_k，单位为时间周期T_k；纵轴为Transition，范围0.0至
// 1.0，无量纲；红色单峰曲线呈周期性振荡，在t=0、T_k、
// 2T_k处值为0，在t=T_k/2和3T_k/2处达到峰值1.0；曲线光滑
// 对称，显示系统在驱动下发生完全相干跃迁，每半个周期完成
// 一次状态翻转。
#figure(placement: top, image("imgs/magnon_magnon_entangle_Akash.png", width: 100.0%),
 caption: [
 (a) An antiferromagnetic system is divided into two sublattices by alternating sites (red and blue) to characterize the intersublattice entanglement (top). The system is partitioned through the middle for the central cut entanglement (bottom). (b) A schematic of magnet-cavity system to measure the entanglement of the magnon modes. The EPR function $Delta _0$ quantifies the entanglement of magnons in the ground state and it can be inversely deduced by measuring the transition frequency between acoustic magnons and photons ($f_k$) in the cavity. $lambda _k$ is the scaled wavenumber. Source: The figures are adapted from Refs. [162,232].
 ]
) <fig:auto15>
In reality, one may wish to manipulate the entanglement. Zou et al. [160] demonstrated that the entanglement of spins can be controlled by external fields. This is not easily done in a crystalline antiferromagnet as the entanglement between magnons does not depend on the external field as shown by Eq. #ref(<gsEnAFM>, supplement: none). To overcome this challenge, Yuan et al. considered placing the antiferromagnet in a cavity and found that a circular-polarized cavity photon could be coupled to the magnon state as 
$
hat(cal(H)) = omega_a hat(a)_1^dagger hat(a)_1 + omega_b hat(a)_2^dagger hat(a)_2 + g_(a b) ( hat(a)_1^dagger hat(a)_2^dagger + hat(a)_1 hat(a)_2 ) + omega_c hat(c)^dagger hat(c) + g_(a c) (hat(a)_1^dagger c^dagger + hat(a)_1 c) + g_(b c) (hat(a)_2^dagger hat(c) + hat(a)_2 hat(c)^dagger) .
$ <FimHm> Here only when the magnetization $upright(bold(m))_2$ is pointing along the $- upright(bold(e))_z$ direction does the system absorb the photon's angular momentum $ℏ$ to excite one magnon, resulting in a beam-splitter type interaction $hat(a)_2^dagger hat(c) + hat(a)_2 hat(c)^dagger$. The interaction of photons with $upright(bold(m))_1$ does not conserve the total angular momentum, and is of the parametric-type $hat(a)_1^dagger hat(c)^dagger + hat(a)_1 hat(c)$. Following similar procedures as above, the magnon-magnon entanglement is quantified by log-negativity and its dependence on external field is shown in @fig:auto16(a). Clearly, the entanglement of magnons is enhanced by photons and it is maximal at a particular field, at which the photons and acoustic magnons (lower magnon branch) reach resonance as shown in @fig:auto16(b). To understand the enhancement of this magnon-magnon entanglement, the authors rewrote the effective Hamiltonian in the dressed basis $hat(alpha) = cosh theta hat(a)_1 - sinh theta hat(a)_2^dagger$, $hat(beta) = - sinh theta hat(a)_1^dagger + cosh theta hat(a)_2$, where $tanh 2 theta = - 2 g_(a b) \/ ( omega_a + omega_b )$ 
$
hat(cal(H)) = med omega_alpha hat(alpha)^dagger hat(alpha) + omega_beta hat(beta)^dagger hat(beta) + omega_c hat(c)^dagger hat(c) + g_(alpha c) ( hat(alpha)^dagger hat(c)^dagger + hat(alpha) hat(c) ) + g_(beta c) ( hat(beta) hat(c)^dagger + hat(beta)^dagger hat(c) )
$ <abeta> where $hat(alpha)$ and $hat(beta)$ are respectively the optical and acoustic modes of the magnons. beam-splitter type of coupling between acoustic magnons and photons ($g_(beta c)$) will cool the magnons towards their ground state. Note that the ground state is a two-mode squeezed state $| theta chevron.r = hat(S) ( theta ) | 0_(a_1), 0_(a_2) chevron.r$ with entanglement $E_N = 2 | theta | approx "arctanh" ( 1 + H_"an" \/ H_"ex" )^(- 1) approx 2.41$, which is larger than the steady-state entanglement $ln 2$ in the absence of light. Therefore, this cooling mechanism will enhance the entanglement of two magnons. On the other hand, the optical mode $alpha$ is a dark mode which is non-resonant with the photons, hence its role in the cooling process is negligible. The change of magnon and photon population near the resonant field is shown in @fig:auto16(c), which confirms this argument. By extending this result to a two-sublattice ferrimagnet, Zheng et al. [363] found that EPR steering of the two types of magnons is asymmetric, even when they have identical dissipation. The essential physics is understood to be due to the unbalanced population of acoustic and optical magnons under the cooling effect of cavity photons. Alternatively, Sharma et al. studied the cooling of a magnetic sphere by a monochromatic laser source and found that the magnon distribution in the steady state is controlled by the light intensity through inelastic magnon-photon scattering [364]

// [figvision-cn] imgs/mm_Eng_yuan.png
// 图(a)为曲线图，横坐标为外磁场强度 H 归一化于自旋波场
// H_sp（H/H_sp），范围从0.00到0.30；纵坐标为纠缠度 E_N，
// 范围从0.0到1.0。图中包含三条实线：黑色实线对应 ω_c/
// H_sp=0.80，红色实线对应 ω_c/H_sp=0.85，蓝色实线对应 ω
// _c/H_sp=0.90。每条曲线均呈现单峰结构，峰值随 ω_c/H_sp
// 增大而左移且高度降低。在 E_N=0.7 处有一条水平红色虚线
// 作为参考基准。右上角插入一个示意图 C，显示两个节点 a₁
// 和 a₂ 通过红色实线连接，上方有一个三角形标记“C”，三边
// 均为红色虚线箭头指向下方节点。该子图表明双亚晶格反铁磁
// 体中磁振子纠缠度随外磁场变化呈非单调行为，且在特定频率
// 比下存在最大值。 图(b)为能量谱线图，横坐标为 H/H_sp，
// 范围0.00至0.30；纵坐标为角频率 ω 归一化于 H_sp（ω/H_sp），
// 范围0.6至1.4。图中包含四条曲线：灰色实线 ω₁ 从(0,1.0)
// 线性上升至约(0.3,1.3)；蓝色点划线 ω₂ 从(0,1.0)下降至约
// (0.3,0.7)；红色实线 ω₃ 在低场区保持恒定于0.85附近，在
// 高场区略有上升；紫色点划线 ω_β 从(0,1.0)下降并与 ω_α（
// 黑色虚线）在 H/H_sp≈0.15 处发生 anticrossing（避免交叉）。
// 标注文字包括：“ω_c/H_sp=0.85”位于左上角，“ω_α”、“ω_β”、
// “ω_c”分别标注对应曲线。垂直灰色虚线位于 H/H_sp=0.15 处，
// 指示共振点。该子图展示腔光子与声学模混合形成
// hybridized mode，光学模未受影响，体现强耦合下的能级排
// 斥效应。 图(c)为粒子数分布曲线图，横坐标 H/H_sp 范围
// 0.00–0.30，纵坐标无单位数值范围0.0–2.0。三条曲线分别表
// 示不同模式的粒子占据数：黑色实线 ⟨â⁺â⟩（腔光子）、红色
// 实线 ⟨β̂⁺β̂⟩（声学模）、蓝色实线 ⟨ĉ⁺⟩（光学模）。其中
// ⟨â⁺â⟩ 在 H/H_sp≈0.15 处出现深谷，最低值接近0.0；⟨β̂⁺β̂
// ⟩ 在同一位置达到峰值约2.2；⟨ĉĉ⟩ 整体平缓，在共振点略升
// 后回落。所有曲线在远离共振区趋于稳定。该子图揭示在外调
// 谐过程中，腔光子被强烈抑制而声学模被激发，符合能量守恒
// 与模式转换机制。 图(d)为 van der Waals 磁体结构示意图。
// 左侧为侧视图，显示两层磁性原子层，上层红色箭头代表自旋
// 向上排列，下层蓝色箭头代表自旋向下排列，层间以橙色短线
// 连接表示交换作用。右侧为俯视图，标出 x、y、z 坐标系，
// 外加电场 E 沿 z 轴负方向（紫色箭头），外加磁场 H 沿 x
// 轴正方向（橙色箭头）。背景色块区分上下层区域。该图直观
// 展示二维范德华磁体的层状结构及外部场施加方向，用于解释
// 后续实验中对称性破缺或各向异性来源。 图(e)为多参数依赖
// 曲线图，横坐标为外磁场 Field (T)，范围0–4 T；纵坐标无
// 量纲，范围-0.4–0.4。图中包含五条曲线：绿色实线“
// Entanglement”在 Field≈2.5 T 处急剧上升并饱和于0.4以上；
// 红色实线“Δx”在相同位置出现尖峰；三条虚线分别代表三个量
// 子态的占据概率：蓝色虚线 Occ.|02>、黑色虚线 Occ.|11>、
// 紫色虚线 Occ.|22>，它们在 Field≈2.5 T 附近发生交叉重组。
// 两条垂直虚线标注临界场：蓝色虚线 H_ce ≈2.3 T，红色虚线
// H_cm ≈2.7 T。该子图表明在特定磁场区间内系统发生量子相
// 变，伴随纠缠突增与态布居重排，标志拓扑或对称性转变。
// 图(f)为能级跃迁示意图，纵轴为能量层级，从上至下依次标
// 注 |22>、|20>、|10>、|00>，最底层标注“Joint vacuum”。
// 横向箭头表示跃迁过程：绿色粗箭头 g 表示从 |00>→|10> 和
// |10>→|20> 的泵浦过程；红色粗箭头 g_p 表示从 |00>→|11>
// 的直接激发；蓝色细箭头 g_c 表示从 |11>→|20> 和 |11>→|
// 02> 的弛豫路径。顶部标注“symmetry forbidden”并用灰色虚
// 线框住 |12>, |21> 态，表明这些态因对称性禁戒无法参与跃
// 迁。中间态 |11> 是核心枢纽，连接多个通道。该图阐明系统
// 中允许的量子跃迁路径及其对称性约束，解释为何某些中间态
// 不参与动力学演化。
#figure(placement: top, image("imgs/mm_Eng_yuan.png", width: 100.0%),
 caption: [
 (a) Entanglement of magnons in a two-sublattice antiferromagnet as a function of external field. (b) Energy spectrum of the two-sublattice antiferromagnet coupled to cavity photons. The acoustic mode $omega _beta$ is hybridized with the photon mode $omega _c$ with an anticrossing structure near resonance, while the optical mode $omega _alpha$ is left unchanged. (c) Magnon and photon population as a function of external field. (d) Schematic of a bilayer van der Waals magnet. An in-plane field is applied to tilt the magnetization. (e) Entanglement (red line) and squeezing (green line) of magnons in the ground state of magnons as a function of external field. (f) Physical picture of the non-monotonic field dependence of the magnon-magnon entanglement. Source: The figures are adapted from Refs. [229,230].
 ]
) <fig:auto16>
An alternative way to tune the entanglement of magnons is to utilize the van der Waals magnets [230] Van der Waals magnets are a class of magnetic materials with only one to a few magnetic monolayers, and the neighboring layers are coupled through van der Waals interactions [365,366,367,368]. Depending on the stacking order of layers and the external electric field, the interlayer coupling can be either ferromagnetic or antiferromagnetic [369]. Compared with bulk crystalline magnets, van der Waals magnets have the advantage of tunable exchange and anisotropy fields by gate voltage, where the exchange and anisotropy can be comparable in strength such that the magnetic ground state can be altered by either electric field or magnetic field. For a canted magnetic state induced by an in-plane magnetic field, as shown in @fig:auto16(d), the effective magnon excitation is described by the following Hamiltonian [230] $ hat(cal(H)) = sum_(i = 1)^2 [omega_0 hat(a)_i^dagger hat(a)_i + 1 \/ 2 g ( hat(a)_i^dagger hat(a)_i^dagger + hat(a)_i hat(a)_i )] + g_c ( hat(a)_1^dagger hat(a)_2 + hat(a)_1 hat(a)_2^dagger ) + g_p ( hat(a)_1^dagger hat(a)_2^dagger + hat(a)_1 hat(a)_2 )   $ where $omega_0 = ( J + K ) S cos 2 theta + K S cos^2 theta + mu_0 g_e mu_B H sin theta, g = K S sin^2 theta, g_p = J S cos^2 theta, g_c = J S sin^2 theta$, with $J$ and $K$ being the interlayer exchange and anisotropy coefficients, respectively. As the external magnetic field increases above a critical value $H_"cm" = 2 ( J + K ) S \/ ( mu_0 g_e mu_B )$, the system reorients magnetically from a canted state ($theta < pi \/ 2$) to a collinear state ($theta = pi \/ 2$).


Now, both the two-mode squeezing ($g_p$) and single mode squeezing ($g$) interactions will contribute to the quantum correlations between the two magnons, and generate an anomalous field-dependence of the magnon-magnon entanglement. Even when the squeezing of the magnons decreases gradually (green solid line) when the field approaches the magnetic reorientation field, the magnon-magnon entanglement does not change monotonically (red solid line), as shown in @fig:auto16(e). The essential physics is understood from the schematics of the energy levels as shown in @fig:auto16(f). The key influencer of the magnon-magnon entanglement is the occupation of the state $| 11 chevron.r$, because it determines the difficulty to separate the joint wave function into a cross product of the wave function of each sublattice magnon. Here the two-mode squeezing $g_p$ contributes positively to the occupation of $| 11 chevron.r$, while the combined effect of coherent processes $g_c$ and single mode squeezing reduces the occupation of this energy level. Then these two channels will interfere to result in a local minimum of magnon-magnon entanglement before the transition field. This competition between the two channels is still there when the dissipation of magnons is taken into account. A sudden death of entanglement was observed upon tuning the exchange and anisotropy field by a gate voltage. On the application side, this tunable entanglement channel --- by both electric and magnetic means --- may serve as a bridge to entangle distant qubits, placed on the top and bottom sides of the bilayer system.


=== Bistability
<sec_bistable>
Several works reviewed above have shown that the hybrid magnet-cavity system provides a promising platform to study the entanglement among magnons, photons and phonons. Nonlinear effects usually play a crucial role to generate non-vanishing steady-state entanglement. On the other hand, nonlinearities often cause dynamic systems to have two, three or even more stable solutions under exactly the same conditions. This is called bistability, tristability or, more generally, multi-stability. Which state the system evolves to depends on the initial conditions and past dynamics. Note that bistability itself is not a quantum phenomenon exclusively and exists in various physical systems, including optical systems [370], acoustic systems [371,372], electronic systems [373,374], magnetic systems [375], etc. Manipulation of bistable states may find promising applications in data storage and memory devices [376,377,378,379]. Here we review the developments of this direction in hybrid magnet-cavity systems.


Wang et al. [380,381] studied the influence of Kerr nonlinearities on the stability of magnon-polaritons in cavity-magnet systems as shown in @fig:auto17(a). To demonstrate nonlinear effects, a microwave with frequency $omega_d$ (Port 3) is applied to the magnetic sphere to drive the magnon mode, while an external static field was tuned to let magnons get into resonance with photons (Position A in the lower branch of the anticrossing spectrum). Figure(b) first shows the frequency shift of the lower energy branch $Delta_"LP"$ as a function of the driving power $P_d$ at different driving frequency detuning ($delta_"LP" = omega_"LP" - omega_d$). Clearly, a hysteretic behavior of the frequency shift is identified in both forward and backward scanning of the driving frequency. This suggests bistability of the magnon polariton. Moreover, when the frequency detuning is scanned at a given driving power, a hysteresis loop is also observed, where the loop area decreases when reducing the driving power $P_d$.


// [figvision-cn] imgs/bistability.png
// 子图(a)由左侧的三维示意图和右侧的热图组成。左侧示意图
// 展示了一个长方体三维微波腔体，其内部中心位置放置有一个
// 红色的钇铁石榴石（YIG）球体。腔体侧面引出三个端口：端
// 口1和2用于传输谱测量，端口3连接一个标有“MW”的微波源用
// 于驱动YIG球体，同时端口1和2连接至标有“VNA”的网络分析仪。
// 图中用绿色粗箭头标示沿z轴方向的静态偏置磁场B0。在腔体
// 下方展示了YIG球体附近的磁场分布云图，颜色从蓝色（min）
// 渐变到紫色再到红色（max），表示磁场强度空间分布。右侧
// 热图的横坐标为磁线圈电流（Magnet coil current），范围
// 从4.75 A到5.00 A；纵坐标为探测频率（Probe frequency），
// 范围从9.9 GHz到10.3 GHz。色标位于右侧，表示S21参数的绝
// 对值平方|S21|^2，单位为dB，范围从-70 dB（深蓝色）到-20
// dB（亮红色）。图中显示两条交叉的色带：一条随电流增加而
// 频率升高的斜向亮带被标注为“Kittel mode”，另一条近乎水
// 平的亮带被标注为“Cavity mode”。两条模式在约4.85 A、
// 10.1 GHz处发生反交叉耦合。图中标注了A、B、C三个特定点
// 的位置，其中点A位于耦合区域中心，点B位于Kittel模式分支
// 上，点C位于Cavity模式分支上。 子图(b)包含六个曲线图，
// 分为左右两列，每列三行。左列三个图的横坐标均为驱动功率
// Pd（mW），范围0至350 mW；纵坐标为极化频移Δp/2π（MHz），
// 范围0至20 MHz。每个图中均绘制了正向扫描（空心圆圈）、
// 反向扫描（空心三角）以及理论预测（红色虚线）三条曲线。
// 随着驱动功率增加，系统出现滞后回线现象，且回线宽度随参
// 数变化：最上方图标注δ1P/2π = -14.1 MHz，中间图为-12.1
// MHz，最下方图为-10.1 MHz。右列三个图的横坐标为频率失谐
// δ1P/2π（MHz），范围-60至60 MHz；纵坐标同样为极化频移Δp
// /2π（MHz），范围0至20 MHz。每个图对应不同的驱动功率：
// 从上到下分别为Pd=25 dBm、23 dBm、21 dBm。图中同样显示
// 正向与反向扫描路径形成的滞后回线，并用黑色双向箭头标注
// 跳变幅度Δa。所有子图右下角统一图例说明符号含义及理论曲
// 线样式。 子图(c)由上方的结构示意图和下方的热图组成。上
// 方示意图描绘微波输入信号（蓝色箭头）进入一个两端开口的
// 谐振腔（橙色椭圆轮廓内绘有红色等相位面），腔内中心悬挂
// 一个红色YIG球体，微波输出从另一端射出（蓝色箭头）。下
// 方热图横坐标为外加磁场μ0H（mT），范围425至450 mT；纵坐
// 标为归一化频率ω/2π（GHz），范围11.8至12.4 GHz。色标位
// 于左上角，表示|S21|^2(dB)，范围从-25 dB（深蓝）到0 dB
// （亮黄绿）。图中可见两条主要共振轨迹：一条近似水平线标
// 注为ωc（腔模频率），另一条斜向上直线标注为ωm（磁振子模
// 式频率）。两者在约438 mT、12.1 GHz处发生强耦合分裂。图
// 中标注A、B、C、D、E五个点，分别位于不同磁场下的共振峰
// 位置，其中E点位于高频高场区，A点位于低频低场区。 子图(
// d)为相图，横坐标为归一化磁场差μ0(H-Hr)（mT），范围-0.2
// 至0.6 mT；纵坐标为归一化频率偏移(ω−ωc)/2π（GHz），范围
// -0.4至0.4 GHz。图中以垂直虚线x=0划分左右区域，左侧白色
// 区域标注“No Foldover”，右侧灰色区域标注“Foldover
// Regime”。绿色实线表示临界边界，其在x<0时急剧上升，在x>
// 0时趋于平缓。多条彩色曲线（红、蓝、紫）代表不同初始条
// 件下的动力学轨迹，均在折叠区呈现突变跳跃行为，箭头指示
// 演化方向。右上角标注“K<0”，表明非线性系数为负。整体图
// 像揭示系统在特定参数区间内存在双稳态与突变折叠现象。
#figure(placement: top, image("imgs/bistability.png", width: 100.0%),
 caption: [
 (a) Schematic diagram of a 3D cavity with a YIG sphere embedded and the coupling spectrum. Ports 1 and 2 of the 3D cavity are used for transmission spectroscopy and port 3 is for driving the magnetic sphere. (b) The detuning $Delta _(L P)$ as a function of driving power $P_d$ (left) and as a function of frequency detuning $delta _(L P)$. The red dashed lines are the theoretical prediction based on Eq. #ref(<eqbistable>, supplement: none). Here the [100] axis of YIG is aligned parallel to the static field and the cavity mode $upright("TE")_102$ is in resonance with magnons. (c) Schematic diagram of a follow-up experiment with driving on the cavity modes. (d) Phase diagram of the hysteresis loops, where the grey color indicates the different types of the bistability (foldover). $H_r$ is the resonance field and $omega _c$ is the cavity frequency. Source: The figures are adapted from Refs. [380,382].
 ]
) <fig:auto17>

To understand the essential physics, the authors considered the Hamiltonian of the hybrid system as [190] $ hat(cal(H)) = omega_c hat(c)^dagger hat(c) + omega_r hat(a)^dagger hat(a) + v ( hat(a)^dagger hat(a) )^2 + g ( hat(c)^dagger hat(a) + hat(c) hat(a)^dagger ) + Omega_d ( hat(c)^dagger e^(- i omega_d t) + hat(c) e^(i omega_d t) ) , $ where $hat(a)$ and $hat(c)$ are the magnon and photon creation operators, respectively, $v$ is the Kerr nonlinearity caused by magnetocrystalline anisotropy of the system, so that $v$ is inversely proportional to the volume of the magnet, which is consistent with the model we discussed in the context of magnon antibunching (@sec_singlemagnon). $Omega_d$ is the driving strength. Following a quantum Langevin approach, the authors derived a cubic equation for the frequency shift of the magnon-polariton $Delta_(upright(L P))$ in the steady state as $ [( Delta_(upright(L P)) + delta_(upright(L P)) )^2 + (gamma_(upright(L P)) / 2)^2] Delta_(upright(L P)) - 𝜚 P_d = 0 , $

<eqbistable>

where $gamma_(upright(L P))$ is the damping rate of the lower energy branch of the polariton and $𝜚$ is a fitting parameter that characterizes the coupling strength between the driving microwave and the polariton. Equation #ref(<eqbistable>, supplement: none) has two stable solutions, which correspond to the bistability of the system. The prediction of the frequency shift $Delta_(upright(L P))$ fits well with the experimental observations, as shown by the red dashed lines in @fig:auto17(b). Furthermore, the authors demonstrated the appearance of bistability for off-resonant conditions [Points B and C in the energy spectrum @fig:auto17(a)]. A follow-up work by Hyde et al. [382] studied the bistability of the magnon-polariton by driving the cavity mode instead of the magnon mode with a high-power microwave, as shown in @fig:auto17(c). They identified several types of bistability including (counter-)clockwise, (reversed) butterflylike, and clockwise hysteresis loops, as shown in @fig:auto17(d), which depend on the driving frequency as well as the magnon frequency. Tuning the bistable behavior by external field and driving power may have potential applications in designing low-energy switching devices. In a follow-up work [379], the authors experimentally observed the tristability in a three-mode hybrid magnet-cavity system, which is composed of two YIG spheres strongly coupled to a microwave cavity. The three separable stable states can be used to build a logic gate with zero, moderate and high driving powers.

Recently, Bi et al. further considered the nonlinearity of photons and found that their interplay with the magnon density saturation under strong driving induces tristability of the magnon polariton. Nair et al. [384] proposed to place two YIG spheres into a single cavity and to drive one of them to study the spin excitation of the other undriven sphere. They found that the spin excitation in the driven sphere can migrate to the undriven one. The indirect coupling channel is engendered by the cavity photons and shows multistable behaviors. They [385] also found that the threshold power to induce the bistability can be reduced by a factor of 5, when both the magnon and photon modes are connected to a common thermal bath and dissipation effects dominate the coherent coupling. Yang et al. [386] evaluated the magnon-photon entanglement in the nonlinear regime of this hybrid system and found that the entanglement can jump from one state to the other near the switching points of the bistable regime.


== Hybrid magnet-qubit system
<sec_magnon_qubit>
A qubit is a two-state quantum-mechanical system and it is the basic information carrier in quantum information science and technology. Various types of qubits have been implemented to realize quantum information tasks, including superconducting qubits [114,115], photonic qubits [116,117], atoms [121], trapped ions [123], NV centers [118], SV centers [119,120], and anyons [124], among others. Magnons have been successfully integrated with the superconducting qubit and NV center either by direct dipolar coupling or mediated by cavity photons. On the one hand, qubit systems are able to help to detect and image magnetic textures through magnetorelaxometry, where the spins are coupled with the qubit by dipolar interactions. Moreover, the qubits are capable of detecting the quantum magnonic state in both collinear and noncollinear magnetic structures, since it is very sensitive to magnetic noise. On the other hand, magnons are able to control the qubit state via dipolar interaction and further mediate the entanglement of two or more distant qubits. This takes advantage of the long lifetime of magnons in magnetic insulators and the high tunability of magnonic systems by electric and magnetic means. In this section, we will discuss these two sides and review the recent developments.


=== Magnon-superconducting qubit inside one cavity
<magnon-superconducting-qubit-inside-one-cavity>


// [figvision-cn] imgs/Tabuch_mqubit.png
// 子图(a)为示意图，展示了一个混合磁振子-量子比特-腔系统
// 的物理结构。主体是一个长方形的棕色谐振腔体，右上角标注
// 尺寸“5 mm”。腔体内部绘制了电场（Electric field）和磁场
// （Magnetic field）的分布云图及矢量箭头：左侧区域以蓝色
// 为主，代表磁场较强；右侧区域以橙红色为主，代表电场较强。
// 在腔体左下角放置一个黑色小球，标注为“YIG sphere”（钇铁
// 石榴石球），旁边有一个绿色箭头指向该球并标注“Static
// field B_static”（静磁场）。在腔体右侧中心位置嵌入一个
// 灰色矩形块，标注为“Qubit”（量子比特）。左上角插入一张
// 实物照片，显示一个直径约1毫米的黑色小球，标尺为“1 mm”。
// 右下角插入两张显微照片：左边一张是深绿色背景上的金属结
// 构，标尺为“0.5 μm”，显示量子比特的微观结构；右边一张是
// 浅灰色背景上的金属线，标尺为“0.5 mm”，显示谐振腔的宏观
// 布线。整个系统通过电场和磁场将YIG球与量子比特耦合在同
// 一个腔体内。 子图(b)为二维热图（曲线图的一种形式），横
// 轴为“Coil current δq (mA)”，范围从-1.0到1.0 mA；纵轴为
// “Excitation frequency (GHz)”，范围从8.12到8.15 GHz。右
// 侧色标表示信号强度，从0.00（深蓝色）到0.20（深红色）。
// 图中呈现两条对称弯曲的高亮带（红黄色区域），分别位于δq
// < 0和δq > 0两侧，随|δq|增大而向上弯曲，形成典型的Rabi
// 分裂特征。当δq = 0时，两条分支在约8.135 GHz处最接近但
// 未交叉，表明存在能级排斥。这反映了磁振子与量子比特通过
// 腔光子间接耦合导致的真空Rabi分裂现象，且分裂大小随线圈
// 电流调控。 子图(c)为能级结构示意图，用于解释非共振操控
// 下磁振子与量子比特耦合强度的机制。底部标注“Ground
// state”（基态）。左侧垂直轴标注“Energy”（能量），无具体
// 数值刻度但有断裂符号。图中包含三个主要部分：左下方是“
// Kittel mode”（基特尔模，即磁振子模式），其频率为ω_FMR；
// 右下方是“Qubit”（量子比特），其频率为ω_q；中间上方是“
// Cavity TE₁₀₂”（腔模），其频率为ω_c。三者之间用双向箭头
// 连接：g_m表示磁振子与腔的耦合，g_q表示量子比特与腔的耦
// 合，g_{qm,p}表示可调耦合（Tunable coupling），由橙色粗
// 箭头指示，源自“Parametric drive ω_d”（参量驱动）。右上
// 角方框内展示量子比特与磁振子的联合能级结构：水平排列的
// 能级标记为|g,0⟩、|e,1⟩、|e,2⟩等，其中实线表示未受扰动
// 能级，虚线表示受参量驱动后的修正能级，“Drive”箭头指向
// 这些能级跃迁。左上角有“Reflection measurement”（反射测
// 量）的绿色虚线箭头指向腔模，表示实验探测方式。整体说明
// 通过参量驱动可调节有效耦合强度g_{qm,p}，从而实现对磁振
// 子-量子比特相互作用的非共振控制。 子图(d)为流程图，分
// 为上下两部分。上半部分标题依次为“Preparation”、“
// Entangling operation”、“Qubit readout”。时间轴从左至右。
// “Kittel mode”行显示一个粉色脉冲波形，标注算符D̂(β)，表
// 示对磁振子模式施加位移操作；“Qubit”行显示一条蓝色直线，
// 在“Entangling operation”阶段出现一个向下凹陷的曲线，标
// 注τ_π和X̂_π⁰，表示量子比特经历π脉冲演化；最后“Qubit
// readout”阶段用一个半圆形仪表盘图标表示读取结果。下半部
// 分为直方图，横轴为“Demodulated signal (V)”，范围0.00到
// 0.10 V；纵轴为“Counts”，对数坐标，最大值为10⁴。图中有
// 两个峰：左侧蓝色峰对应|g⟩态（基态），右侧绿色峰对应|e⟩
// 态（激发态），两者均被高斯拟合曲线覆盖。中间区域标注“
// Preparing”，并用虚线分隔两个峰的位置，表明通过解调信号
// 可以区分量子比特状态，进而推断磁振子是否存在。 子图(e)
// 为散点拟合图，横轴为“Magnon population n̄_m”，范围0.00
// 到0.20；纵轴为“Detection probability p_g(n̄_m)”，范围
// 0.20到0.40。图中蓝色圆点代表实验数据（Data），黑色实线
// 为线性拟合（Fit）。拟合方程隐含斜率η=0.71，标注于图中
// 央：“Quantum efficiency η = 0.71”。底部有一条水平虚线，
// 标注“Dark-count probability p_g(0) ≈ 0.24”，表示零磁振
// 子时的本底计数概率。随着磁振子布居数n̄_m增加，检测概率
// p_g呈线性增长，斜率反映量子效率，截距反映暗计数。该图
// 验证了单磁振子探测的可行性，并量化了探测系统的性能参数。
#figure(placement: top, image("imgs/Tabuch_mqubit.png", width: 100.0%),
 caption: [
 (a) Schematic of a hybrid magnet-qubit-cavity system. (b) Rabi splitting due to the indirect coupling between magnons and qubits mediated by cavity photons. (c) Energy level distribution of the hybrid system to explain the off-resonant manipulation of the coupling strength between magnons and qubits. (d) Procedure for single-magnon detection using superconducting qubits. (e) Detection probability of magnons as a function of magnon population. Source: The figures are adapted from Refs. [198,387].
 ]
) <fig:auto18>

Tabuchi et al. first experimentally demonstrated a hybrid magnet-qubit-cavity system that consists of a ferromagnetic insulator (YIG sphere) and a superconducting qubit, as shown in @fig:auto18(a) [387]. The state of the qubit is well described by a two-level system while the magnon excitations in the magnet form a continuous variable system. Here magnons and qubits are magnetically and electrically coupled to the cavity photons ($upright(T E)_102$ mode), and hence there is an indirect coupling between magnons and photons by exchange of a virtual photon. This leads to an interaction of the form $hat(cal(H))_(upright(i n t)) = g_(m q) hat(sigma)^(+) hat(a) + g_(m q)^(*) hat(sigma)_(-) hat(a)^dagger$, where $hat(sigma)^plus.minus$ describes the qubit, $g_(m q) = g_m g_q / Delta$ is the effective magnon-qubit coupling strength, with $g_q$ and $g_m$ respectively the coupling strength of cavity photons to qubit and magnons, and $Delta$ is the detuning between the qubit (magnon) and cavity mode. To demonstrate the magnon-qubit coupling, the authors read the qubit state by another cavity mode ($upright(T E)_103$ mode) and found that the transmission spectrum takes the typical form of energy level repulsion as shown in @fig:auto18(b), which is a manifestation of the coherent coupling between magnon and qubit. The effective coupling strength $g_(m q) / 2 pi = 10 upright(M H z)$ is consistent with the theoretical estimate of 11.8 MHz, and it is much larger than the dissipation of either magnons or qubits, such that the coupling falls into the strong coupling regime. The authors further showed that parametric driving applied to the qubit effectively tunes the coupling strength between the qubit and magnons. Now, the hybrid system oscillates between the ground state $| g , 0 chevron.r$ and excited state $| e , 1 chevron.r$ as shown in @fig:auto18(c), where $| g chevron.r , | e chevron.r$ are the qubit ground and excited states and $| n chevron.r$ are the magnonic Fock states. The effective gap between these two states is manipulated by the driving power as well as by the detuning between the driving and the average of the magnon and qubit frequency.



Based on the strong coupling of magnon and qubit, Lachance-Quirion et al. tuned the system into a strongly dispersive regime, where the detuning between the qubit and magnon is much larger than their coupling, i.e., $| omega_q - omega_m | gt.double g_(m q)$, which produces an effective nonlinear interaction between magnons and photons in the form of $hat(cal(H))_"int" = chi_(q m) hat(a)^dagger hat(a) hat(sigma)_z$ This implies that the excitation probability of the qubit sensitively depends on the number of excited magnons. The higher the number of magnons, the larger the frequency shift of the qubit frequency. Therefore, the number of magnons can be deduced by measuring the shift of the qubit frequency. On the other hand, by measuring the probability of the qubit to be in the excited states, one determines the excitation probability of the magnons. @fig:auto18(d) shows the procedure for single-magnon detection. First, a coherent state of magnons was prepared. Second, a conditional excitation $X_pi^0$ pulse is applied on the qubit system to entangle the qubit and magnons. Finally, the qubit state is read out by using a high-power technique [390]. @fig:auto18(e) shows the detection probability of magnons as a function of magnon number, where the detection probability is given by $p_g ( n_m ) = macron(eta) ( 1 - e^(- n_m) ) + p_g ( 0 )$, with $macron(eta)$ and $p_g ( 0 )$ being respectively the quantum efficiency and the dark-count probability, which can be obtained by fitting the experimental data. When the magnet is in the vacuum state, the probability of the detector click is $p_g ( 0 )$. When the magnonic system is in the first excited state $| 1 chevron.r$, the detector clicks with a probability $macron(eta) + p_g ( 0 )$. Then one can readily detect single-magnon state by counting and analyzing the detector clicks. To guarantee the efficiency of detection, the measuring time has to be lower than the decoherence time of qubit, which is around 200 ns. This proof-of-concept experiment establishes the qubit state as single-magnon detector, which has promising applications to detect weak magnon excitation with high precision. The highest fidelity of single-magnon detection realized in this experiment corresponds to a precession of the magnetization with an angle of $10^(- 17)$ degree in a millimeter-sized YIG sphere.


Following these experimental works, Liu et al. [391] studied the steady-state behavior of the hybrid magnet-qubit-cavity system and found that the dispersive coupling between magnons and qubits induces bistability of the system. Wu et al. [392] considered a model with the superconducting qubit replaced by a three-level fluxonium qubit and found that both single and multi-magnon blockade is achieved and interchanged by properly choosing the parameters. Luo et al. [393] showed that nonlocal entanglement between two remote magnet-qubit-cavity systems can be realized. Janssønn et al. theoretically demonstrated the propagation of superconducting signatures to a distant ferromagnet mediated by their mutual coupling to a cavity electromagnetic mode [394]


=== Manipulating one or more qubits by magnons
<manipulating-one-or-more-qubits-by-magnons>
Trifunovic et al. first proposed to couple two spin qubits separated by a relatively larger distance (several $"mum"$) through magnonic excitations in a ferromagnet with a large gap. Here the two qubits are coupled to the ferromagnet through dipolar interactions, hence the qubit has to be placed close to the magnets, i.e., on the order of several tens of nanometers, to guarantee the coupling strength is sufficiently strong. on-and-off switching of the qubit-qubit interaction is achieved by tuning the qubits on and off resonance with the ferromagnets. The decoherence time of the qubit $T_2$ depends sensitively on $k_B T \/ Delta_F$, where $Delta_F$ is the magnon gap. Hence it is desirable to choose materials with a small magnon gap and to perform the operations at low temperature. Neuman et al. [396] considered a nanomagnet to mediate the long-range coupling of two qubits as shown in @fig:auto19(a). Here each qubit is coupled to the magnon mode inside the nanomagnet and their detunings relative to the magnon frequency are brought out of resonance to enhance their mutual coupling via the transfer of a virtual magnon. They found population exchange between the two qubits, which clearly demonstrates the indirect coupling of the two qubits. The effective coupling strength is three to four orders of magnitude larger than the direct coupling strength.


The generation of quantum entangled states of two or more qubits via magnons was recently theoretically proposed. Skogvoll et al. [216] theoretically showed that three qubits simultaneously coupled to a squeezed magnon mode can jointly absorb the latter and robustly generate a 3-qubit Greenberger-Horne-Zeilinger (GHZ) state [397]. Here the squeezed magnon state is a superposition of odd magnon-number excitations only [Eq. #ref(<sq:eq:sqmagnum>, supplement: none)]. Taking the case of three qubits as an example, this feature enables the system to transition from 1 squeezed magnon and 3 ground-state qubits $| 1, g g g chevron.r$ to 0 squeezed magnons and 3 excited qubits $| 0, e e e chevron.r$ via a set of virtual states, as shown in @fig:auto19(b). The generated GHZ and related states may be useful for implementing Shor's algorithm [398] for quantum error correction. Ramos et al. designed a chiral quantum network, where the interactions between spins are mediated by magnon excitations in a 1D XX spin chain [399]. Fukami et al. [400] theoretically showed that two qubits that are separated by $1 - 2 mu$m can become entangled due to exchange of magnons in a ferromagnetic YIG bar. The estimated cooperativity exceeds $10^4$ for on-resonance conditions and the ratio of the effective qubit-qubit interaction to the decoherence rate of the qubit is around $10^3$ away from resonance, which may be useful to implement entangling gate protocols. Zou et al. [401] showed that the two qubits can be entangled via dissipative coupling to a magnetic medium, in the absence of any coherent coupling. A proper measurement and post-selection can produce the maximally entangled Bell states of the two qubits. Xiong et al. [402] showed how distant quantum information tasks including two-qubit iSWAP gates and charger-battery devices can be potentially realized in such a hybrid system.


Besides using magnonic excitation of a collinear magnetic structure as illustrated above, Flebus et al. [252] theoretically showed that an antiferromagnetic domain wall is able to mediate a tunable coherent coupling between two qubits separated by around a micrometer as shown in @fig:auto19(c). Here the planar rotation of the staggered order parameter, i.e., the spin superfluid mode, is excited and simultaneously coupled two qubits placed above the domain wall. We note that the experimental demonstration of qubit-qubit coupling through magnon modes is still lacking. Nevertheless, current studies have already enabled the coupling between a single qubit and a magnon [403,404,405,406] as briefly described below.


// [figvision-cn] imgs/magnon_two_qubits.png
// 该图像包含三个子图，分别标记为(a)、(b)和(c)，展示了量
// 子比特通过磁振子模式耦合的物理机制及实验设置。 子图(a)
// 由三部分组成：顶部示意图、左下角曲线图和右下角曲线图。
// 顶部部分是一个三维结构示意图，展示了一个位于中心的灰色
// 球体，标注为“YIG sphere”（钇铁石榴石球），其半径用双向
// 箭头标注为“R”。球体中心有一个向上的白色箭头，标注为“Ms
// ”，代表饱和磁化强度。球体上方有一个向上的黑色箭头，标
// 注为“He”，代表外磁场。在球体左右两侧对称位置各放置一个
// 发射器。左侧发射器为蓝色圆点，标注为“Emitter 1”；右侧
// 发射器为红色圆点，标注为“Emitter 2”。两个发射器到球心
// 的距离均用双向箭头标注为“a”。左上角有一个三维坐标系，x
// 轴向右，y轴垂直纸面向里，z轴向上。 左下角部分是一个二
// 维曲线图。纵坐标轴名称为“Population”（布居数），范围从
// 0到1。横坐标轴名称为“Time (μs)”（时间，单位微秒），刻
// 度标记为0、1、2、3。图中有两条曲线：一条是实心蓝线，代
// 表“Emitter 1”的布居数随时间的变化，初始值为1，随后呈振
// 荡衰减趋势下降至接近0；另一条是虚线红线，代表“Emitter
// 2”的布居数随时间的变化，初始值为0，随后呈振荡上升趋势
// 达到峰值后下降。这两条曲线展示了两个发射器之间的能量交
// 换过程。 右下角部分是一个二维对数坐标曲线图。纵坐标轴
// 名称为“g(kHz)”（耦合强度，单位千赫兹），采用对数刻度，
// 标记为10^-2、10^0、10^2。横坐标轴名称为“Distance (nm)”
// （距离，单位纳米），采用线性刻度，标记为100、150、200。
// 图中有两条曲线：上方是一条实心蓝线，标注为“
// Magnon-mediated”（磁振子介导的），显示随着距离增加，耦
// 合强度缓慢下降，数值维持在较高水平（约10 kHz量级）；下
// 方是一条虚线红线，标注为“Direct”（直接的），显示随着距
// 离增加，耦合强度急剧下降，数值远低于磁振子介导的情况。
// 该图对比了有无磁性介质时两种耦合方式的强度差异。 子图(
// b)是一个能级跃迁与态叠加的示意图。顶部展示了三个圆形图
// 标，内部均画有向上的黄色箭头，代表自旋向上状态。这三个
// 图标上方对应着三个方括号内的符号序列：第一个方括号内是
// 一个向上箭头，第二个方括号内是两个向上箭头，第三个方括
// 号内是五个向上箭头，中间用加号连接，末尾有省略号，表示
// 多粒子激发态的叠加。从顶部的符号序列引出三条箭头指向下
// 方的三个圆形图标。中部展示了四个能级，垂直排列，能量值
// 从下到上依次标注为3ωq、5ωq、7ωq、9ωq。能级之间通过实线
// 和虚线箭头连接，表示跃迁路径。例如，从基态|0,eee⟩出发，
// 经过一系列中间态如|1,ceg⟩、|2,egg⟩等，最终到达高激发态
// |3,ggg⟩。这些跃迁路径描绘了系统在不同量子态之间的演化
// 过程。 子图(c)是一个三维立体结构示意图，展示了一个反铁
// 磁绝缘体薄膜及其上的量子自旋相互作用。底部是一个长方体
// 块，标注为“antiferromagnetic insulator”（反铁磁绝缘体）。
// 长方体顶面覆盖一层薄膜，颜色从左侧的青色渐变到右侧的黄
// 色。薄膜右侧边缘有一个垂直的颜色条图例，青色端标注为“
// -1”，黄色端标注为“+1”，表示某种物理量（如序参量）的空
// 间分布。薄膜表面上有两个红色的粗箭头，分别指向左下和右
// 下方向，均标注为“QI spin”（量子自旋）。这两个红箭头之
// 间的水平距离用虚线标注为“L”。其中一个红箭头的垂直高度
// 用虚线标注为“d”。在左侧红箭头正下方，有一个灰色的圆柱
// 体穿透薄膜进入底层，圆柱体内有一个向上的灰色箭头，标注
// 为“m”，代表局域磁矩。薄膜表面还绘制了一条波浪形的绿色
// 虚线，旁边标注有角度符号“λ”、“γ”和“Φ”，用于描述波矢或
// 相位关系。左侧有一个三维坐标系，x轴向右，y轴垂直纸面向
// 里，z轴向上。右下角有一个单独的箭头，标注为“h”，可能代
// 表外部场或其他矢量。
#figure(placement: top, image("imgs/magnon_two_qubits.png", width: 100.0%),
 caption: [
 (a) (Top) Schematics depiction of two qubits coupled by a magnon mode in a nanometer-sized magnetic sphere. (Bottom left) The population of the two qubits as a function of time. (Bottom right) Effective coupling strength of two qubits mediated by magnons as a function of the distance between the two qubits and its comparison with the direct coupling in the absence of magnets. (b) Schematic of the squeezed magnon with only odd number occupation and the transition $|1, g g g⟩$ to $|0, e e e⟩$ mediated by a set of virtual states. (c) Schematic of the coupling of two qubits via the magnon mode in an antiferromagnetic insulator. Here QI is the abbreviation of quantum impurity. Source: The figures are adapted from Refs. [216,252,396].
 ]
) <fig:auto19>
Andrich et al. developed a hybrid YIG-nanodiamond (ND) system as shown in @fig:auto20(a). Here each ND contains hundreds of NV centers, which can be viewed as a qubit bus at room temperature. They showed that the surface SW mode, which is excited using a micro-strip line in the YIG film, strongly interacts with the NV center ensembles in NDs. Specifically, the authors detected the photoluminescence spectrum change of the NV center by a nano-particle, located $40 mu$m away from the antenna. The results at driving power of $40 mu$W are shown in @fig:auto20(b). At such low power, the antenna's microwave field is negligible at the ND's location. Then, the observed discrete modes of the NV centers are likely to come from the coherent coupling between the propagation of SWs and NV centers. To strengthen this conclusion, the authors measured the Rabi oscillation signal of the NV centers as shown in @fig:auto20(c). Here, the larger the driving power, the larger the SW amplitude, and thus the faster the Rabi oscillation. Quantitatively, the frequency oscillation scales with the square root of the driving power. Finally, the authors studied the enhancement of coherent microwave fields by comparing the Rabi frequencies in the low-field regime (antenna microwave dominates, no significant coupling between SW and NV) and high-field regime (SW dominates the coupling with NV centers), and found that the magnetic field can be enhanced by two orders of magnitude as shown in @fig:auto20(d). Similar SW mediated excitation of NV centers was also reported by An et al. [404]


// [figvision-cn] imgs/Andrich_sw_nv.png
// 图(a)为混合磁体-氮空位（NV）中心系统的三维结构示意图。
// 底部为一块绿色的矩形薄膜，标注为“YIG”（钇铁石榴石）。
// 薄膜左侧边缘连接有一条白色的带状结构，标注为“
// Microstrip line”（微带线），作为微波信号源。在微带线右
// 侧的薄膜表面，绘制有蓝色的波浪状线条，代表由微带线激发
// 的表面自旋波向右侧传播。在薄膜表面的右半部分，分布着多
// 个白色的小菱形点阵，代表纳米金刚石颗粒，其中一个被箭头
// 指向并标注为“Diamond”。每个纳米金刚石内部包含数百个NV
// 中心。图中还画有一个黑色的粗箭头，标注为“B_ext”，指向
// 右上方，表示施加的外部磁场方向。 图(b)为光探测磁共振（
// ODMR）光谱的二维色标图（热图）。横坐标为外磁场强度，标
// 注为“Field (G)”，范围从0到250高斯（G）。纵坐标为微波频
// 率，标注为“Frequency (GHz)”，范围从2.2 GHz到3.2 GHz。
// 图的左上角标注有“40 μW”，表示实验所用的微波功率。颜色
// 条位于图右侧，标注为“ODMR Contrast (%)”，数值范围从
// -1.0%（深紫色/黑色）到0%（亮黄色）。图中显示了两组明显
// 的共振特征：一组是随磁场增加频率降低的斜线（对应m_s=0
// 到m_s=-1跃迁），另一组是随磁场增加频率升高的斜线（对应
// m_s=0到m_s=+1跃迁）。这两组特征呈现深色（低对比度），
// 表明在这些频率和磁场组合下发生了磁共振。背景区域为亮黄
// 色，表示无共振发生。 图(c)展示了三组不同微波功率下的NV
// 中心拉比振荡曲线图。该子图包含三个垂直排列的面板。所有
// 面板共享横坐标，标注为“Microwave pulse length (μs)”，
// 范围从0到0.5微秒。纵坐标均为“Optical Contrast (%)”，范
// 围从0到4或5。 第一个面板（顶部）右上角标注“3 μW”。图中
// 包含紫色的离散数据点和一条拟合它们的橙色实线。曲线从约
// 3%开始，随着脉冲长度增加呈正弦衰减振荡，周期约为0.15微
// 秒。 第二个面板（中部）右上角标注“10 μW”。数据点和拟合
// 线同样显示正弦振荡，但振幅更大，且振荡频率略快于3 μW的
// 情况。 第三个面板（底部）右下角标注“32 μW”。曲线显示出
// 更快的振荡频率和更大的初始振幅，表明微波驱动场增强导致
// 拉比频率增加。 图(d)展示了磁场增强因子随距离变化的散点
// 图，以及一个嵌入的插图。主图横坐标为“Distance from
// antenna (μm)”，范围从20到80微米。纵坐标为“Magnetic
// field enhancement”，范围从50到450。图中包含五个紫色的
// 数据点，每个点带有垂直误差棒。数据显示，随着距离天线距
// 离的增加，磁场增强因子显著增大，从20微米处的约100增加
// 到80微米处的约370。 图(d)内部左上角有一个嵌入式小图。
// 该小图横坐标为“MW pulse length (μs)”，范围0到1.0；纵坐
// 标为“Rabi contrast (%)”，范围-0.6到0.3。小图右上角标注
// “235 μm”和“1 μW”。图中显示了一条红色的正弦振荡曲线，叠
// 加了数据点，展示了在特定距离和功率下的拉比振荡细节。
#figure(placement: top, image("imgs/Andrich_sw_nv.png", width: 100.0%),
 caption: [
 (a) Schematic of the hybrid magnet-NV center system. Surface spin-waves are excited from the microstrip lines and propagate toward the nanodiamonds. Each nanodiamond contains hundreds of NV centers. (b) Optically detected magnetic resonance spectra as a function of the external magnetic field and driving frequency at microwave power $40~"muW"$. (c) Spin-wave mediated Rabi oscillations of NV centers at a fixed field 120 G. (d) Microwave magnetic field enhancement as a function of the nanodiamond's distance from the antenna. Source: The figures are adapted from Ref. [403].
 ]
) <fig:auto20>


Wolf et al. experimentally showed that the magnetic fields produced by an oscillating magnetic vortex core can coherently manipulate the Rabi oscillation of NV centers placed above the magnetic film at a distance of a few nanometers. Here, the vortex core is moved and repositioned on a time scale of 100 ns, which is the same scale as the coherence time of the NV centers and thus allows a coherent operation of the qubits. Using similar principles, Yuan et al. [407] theoretically showed that an electric field can drive the breathing motion of magnetic skyrmions by periodically changing the anisotropy of the system. The breathing skyrmions generate oscillating dipolar fields outside the magnetic film that can manipulate an NV center located a few nanometers above the magnetic film.


=== Detecting magnetism by single-spin qubits
<sec_magnon_NV>
Besides manipulating the state of spin qubits by magnons excited in a ferromagnetic system, spin qubits in quantum impurities, including NV centers and SV centers, can serve as a sensor to image magnetic textures, such as magnetic vortices [408], domain walls [409,410], skyrmions [411], and noncollinear antiferromagnets [412]. Furthermore, spin qubits can detect magnonic excitations above these magnetic textures [413] and the spin chemical potential of magnons [414]. Up to now, most of these efforts involve NV centers and a systematic review was presented in the early 2018 by Casola et al. [415], while SC centers draw little attention [416]. In the last few years, this field has been continuing to develop, featuring the detection of magnetic states in 2D van der Waals magnets and the study of SWs and spin current transport via spin qubit relaxometry. We will focus on the most recent developments of this field.


Ever since the discovery of ferromagnetic order in 2D materials $upright(C r I_3)$ and $upright(C r_2 G e_2 T e_6)$, 2D magnetism has gained significant research interest and the characterization of the magnetization in these 2D materials is an important issue. Compared to the traditional techniques to characterize 2D magnetism, including Kerr microscopy and magnetic circular dichroism, a sensor based on a quantum impurity has a high spatial resolution of a few tens of nanometers, which enables an accurate measurement of the magnetic-moment distribution [417]. Thiel et al. [418] imaged the magnetic moments of the van der Waals magnet $"CrI"_3$ by sensing the magnetic stray fields generated by the 2D magnet, as shown in @fig:auto21(a). Using reverse-propagation protocols, the magnetic-moment distribution in the van der Waals magnet is recovered from its stray field distribution. The authors found that the total magnetization of an odd number of layers is $16 mu_B \/ upright(n m^2)$, while the magnetization of an even number of layers is nearly zero. These findings corroborated the antiferromagnetic nature of the interlayer coupling in layered $"CrI"_3$. Sun et al. improved the magnetic field sensitivity by using a pulsed measurement scheme and successfully imaged the domain reversal in few layer $"CrI"_3$ samples, as shown in @fig:auto21(b). A wide field NV-microscope with lower resolution ($tilde 500$ nm) was used to detect magnetization reversal by external magnetic field [420]. Such techniques can track the domain structure of individual flakes, while it sacrifices the spatial resolution.


// [figvision-cn] imgs/NV_2D_magnet.png
// (a) 图由四个部分组成，分为上下两排。上排左侧为单自旋磁
// 力计技术原理示意图：一个蓝色的倒T形探针尖端悬停在红蓝
// 相间的原子层上方，红色箭头表示向上磁化，蓝色箭头表示向
// 下磁化；探针周围绘有闭合的黑色磁力线环，左上角标注坐标
// 系（x, y, z）及角度θ_NV、φ_NV。上排右侧为样品光学照片：
// 棕色基底上有一片菱形薄片，内部用虚线框标出两个区域，分
// 别标注“3 layers”和“2 layers”，左下角有比例尺“3 μm”。下
// 排左侧为磁杂散场分布图（Magnetic stray-field map），标
// 题下方标注B_NV - B_bias (mT)，颜色条从蓝色(-0.35)经白
// 色(0)到红色(+0.35)，图像显示一片三角形区域，边缘呈蓝色，
// 中心偏红，右下角有比例尺“2 μm”。下排右侧为磁化强度分布
// 图（Magnetization map），标题下方标注σ (μ_B/nm²)，颜色
// 条从蓝色(-20)经白色(0)到红色(+20)，图像形状与左侧一致，
// 整体以红色为主，局部有蓝色斑点，右下角有比例尺“2 μm”。
// 该子图结论：三层 flakes 产生强杂散场（红色区域），双层
// flakes 产生弱杂散场（蓝色区域），通过反传播法可重建磁
// 化分布。 (b) 图为3×3网格排列的九张磁畴演化显微图像，外
// 加右下角一个嵌入式小图和一条曲线图。每张主图展示同一区
// 域在不同外磁场下的磁畴结构，颜色映射为红色代表正磁化（
// +z方向），蓝色代表负磁化（-z方向）。各子图左下角标注磁
// 场值：第一行从左至右为2 mT、2.5 mT、3 mT；第二行为3.5
// mT、4 mT、5 mT；第三行为6 mT（左）、4 mI（中）、6 mI（
// 右）。其中，“4 mI”和“6 mI”为插入的小图，位于第三行中间
// 和右侧，其下方有独立颜色条标注m_z (μ_B/nm²)，范围从-40
// 到+40。部分磁畴边界用黄色实线或虚线圈出，尤其在4 mT图
// 中有一个大矩形黄框包围多个磁畴。所有主图右下角均有一条
// 黑色比例尺，长度对应2 μm。最右下角嵌入一个归一化磁化曲
// 线图：横轴为μ₀H (mT)，范围0–6；纵轴为M/M_sat（无量纲），
// 范围0–1.0；数据点为橙色圆圈，拟合曲线为橙色实线，背景
// 为深蓝色柱状图表示原始测量数据。该子图结论：随外磁场增
// 加，磁畴从多畴态逐渐转变为单畴饱和态，特定位置（黄圈处）
// 磁畴翻转行为被追踪，最终在约6 mT时达到饱和磁化。
#figure(placement: top, image("imgs/NV_2D_magnet.png", width: 100.0%),
 caption: [
 (a) (Top) Schematic of the single-spin magnetometry technique for imaging magnetism in van der Waals magnets $"CrI"_3$ with even and odd number of stacking layers. Strong and weak stray fields in the magnetic stray-field map emerge from trilayer and bilayer flakes, respectively. (Bottom) The corresponding magnetization distribution is recovered by the reverse propagation method. (b) Magnetic domain evolution of a $"CrBr"_3$ bilayer upon increasing the magnetic field. The solid and dashed yellow circles represent two pinning sites. Source: The figures are adapted from Refs. [418,419].
 ]
) <fig:auto21>


In addition to the sensitivity of spin qubits to static magnetic fields, the relaxation process of the qubit is influenced considerably by magnetic noise of the environment. By measuring the relaxation rate of the qubit, one is able to gain information on the dynamic excitation of magnetic textures which induce magnetic noise nearby. The magnetic noise generated by the magnetic system with a magnon gap lower than the resonance frequency of the qubit was addressed in Refs. [409,414,415]. To address the applicability of the technique to a wider class of ferromagnets with large magnon gap caused by strong anisotropy or external field, Flebus et al. [303,421] theoretically generalized this method to the detection of magnetic noise using a qubit with subgap frequencies. In particular, as shown in @fig:auto22(a), the two-magnon process contributes to the qubit relaxation rate, which is different from the one-magnon process in the normal case. Note that the two-magnon process contributes to the longitudinal noise of the magnetic field, which can be seen from the HP transformation $hat(S)_z = S - hat(m)^dagger hat(m)$. By evaluating the longitudinal susceptibility of the system, the authors derived the longitudinal noise's influence on the qubit's relaxation rate ($Gamma$) as $ Gamma tilde frac(16 mu_B^4, A^3 beta^2) ln frac(A, d_q^2 ( Delta_F - mu ))   $ where $A$ is the exchange coefficient, $beta = 1 \/ ( k_B T )$, $d_q$ is the distance of the qubit from the magnetic sample, $Delta_F$ is the magnon gap, and $mu$ is magnon chemical potential. In the equilibrium state, $mu = 0$, and the relaxation time $Gamma^(- 1) tilde 10$ ms for parameters of YIG, while near BEC, $Gamma^(- 1) tilde 100$ $mu$s, which is much shorter than the intrinsic relaxation time of the NV center. Therefore, magnon BEC may be probed via two-magnon noise through spin qubit relaxometry. Similar ideas apply to BEC in antiferromagnets, and were extended to propose the detection of magnon modes in antiferromagnetic domain walls [422]. One advantage of this method is that it can image magnetic structures with zero magnetization, such as a compensated antiferromagnet.


Finco et al. [423] experimentally demonstrated this proposal by successfully imaging various spin textures in synthetic antiferromagnets, including domain walls, spin spirals, and skyrmions as shown in @fig:auto22(b). Rustagi et al. [424] further addressed the influence of chiral magnetic noise on the qubit relaxation. In particular, the left-moving and right-moving magnons produce unequal magnetic noise and they are respectively coupled to the $m_s = 0 arrow.r - 1$ transition ($Gamma_(-)$) and $m_s = 0 arrow.r + 1$ transitions ($Gamma_(+)$) in an NV center. When the chiral symmetry of SWs is broken, for example by surface SWs, the magnitudes of the magnetic noise for left-moving and right-moving SWs are different, hence the relaxation rate $Gamma_(-)$ and $Gamma_(+)$ are unequal. authors proposed a general formalism to evaluate this difference and verified the prediction experimentally. Furthermore, it has been experimentally demonstrated that the NV center spins can effectively probe coherent SW transport driven by microwaves, spin torques, and thermal gradients [425,426,427,428]


// [figvision-cn] imgs/spin_relaxometry.png
// 子图 (a) 为量子杂质弛豫机制的示意图与能带结构图组合。
// 左侧展示了一个量子杂质（QI）位于基底表面，基底上分布有
// 代表自旋波的黄色箭头符号，一个红色弯曲箭头表示能量交换
// 过程，标注为 ω，旁边有一个棕色三角形物体。中间和右侧是
// 两个并排的抛物线型色散关系图，横轴均为波矢 k，纵轴为能
// 量 ħω_k。两个图中均画有一条水平虚线代表量子杂质的能量
// ω。在中间的图中，ω 位于抛物线最低点之上，存在一个垂直
// 向下的红色箭头表示单磁振子散射过程，标注为 ∝ Γ_1m；同
// 时还有一个从较高能量位置指向较低位置的红色弯曲箭头，标
// 注为 ∝ Γ_2m，代表双磁振子过程。该图下方文字说明当 ω >
// Δ 时，总弛豫率 Γ(ω) 主要由 Γ_1m(ω) 决定。在右侧的图中，
// ω 的位置降低至接近抛物线底部但仍有间隙 Δ（由三角形符号
// 标出），此时单磁振子过程被抑制，主要发生双磁振子过程，
// 标注为 ∝ Γ_2。该图下方文字说明当 ω < Δ 时，Γ(ω) 主要由
// Γ_2m(ω) 决定。整体传达了量子杂质弛豫率随其能级分裂相对
// 于自旋波隙的变化而改变主导散射机制的物理图像。 子图 (b
// ) 包含三部分：左侧为扫描氮-空位（NV）磁力计测量合成反
// 铁磁体（SAF）磁性畴壁的实验装置示意图，中间为实际拍摄
// 的归一化荧光强度图像，右侧为局部放大及磁场投影图。左侧
// 示意图中，上方是一个锥形金刚石尖端，内部有 NV 自旋，受
// 到绿色激光激发并发射红色荧光（PL），尖端距离样品表面高
// 度为 d_NV。下方是多层薄膜结构，从下至上依次为 Pt、Co、
// Ru、Co、Pt，其中 Co 层内用蓝色和红色箭头分别表示相反方
// 向的磁矩排列，形成反铁磁耦合结构，最底层标注为 PMMA。
// 中间图像为矩形区域，显示不规则的黑色线条状结构分布在浅
// 棕色背景上，这些黑色线条对应磁性畴壁。图像左下角有比例
// 尺，标示长度为 1 μm。图像下方有一个颜色条，范围从 0.9
// 到 1.0，标注为“norm. PL”，表示归一化光致发光强度。右侧
// 图像分为上下两部分：上部是中间图像的局部放大图，用虚线
// 框标出，显示一条清晰的黑色畴壁穿过棕色区域，左上角有比
// 例尺 250 nm；下部是该区域的磁场投影图，采用蓝绿黄三色
// 映射，颜色条范围从 -500 到 500，单位为 B_NV (μT)，箭头
// 指示 NV 轴投影方向。整体展示了通过扫描 NV 磁力计对 SAF
// 中磁性畴壁的空间成像及其对应的局域磁场分布。
#figure(placement: top, image("imgs/spin_relaxometry.png", width: 100.0%),
 caption: [
 (a) Quantum-impurity relaxation via one and two-magnon scattering processes. When the quantum impurity splitting $omega$ is larger than the spin-wave gap $Delta _F$, one magnon process dominates the relaxation rate of the quantum impurity. When $omega \< Delta$, two magnon process dominates the relaxation. (b) Imaging of a magnetic domain wall in a synthetic antiferromagnet ($"Co/Ru/Pt/Co"$) by a scanning-NV magnetometer. The overview of the domain and domain wall structures is obtained by measuring the photoluminescence of NV center. Source: The figures are adapted from Refs. [303,424].
 ]
) <fig:auto22>


== Hybrid magnon-phonon system
<sec_magnon_phonon>
The coupling between magnon and the quanta of mechanical oscillations is another interesting direction. The traditional approaches mainly address the interplay of magnons and phonons and their influence on magnon transport properties, for example, excitation of hybrid magnon-phonon polarons [429,430,431], magnon Seebeck effect driven by a thermal gradient [41], phonon-mediated spin transport [432], and surface acoustic waves mediated coherent magnon excitation [48,51,433,434,435]. A review of recent developments is performed by Bozhko et al. [436]. For quantum magnonics, the entanglement of magnons with phonons is manipulated. In particular, here, phonons are not limited to the deformation of the magnetic system itself, and the coupling of magnetic modes to the oscillations of a distinct mechanical system is discussed as well.



#emph[Coupling of magnons with deformation of magnets.] Zhang et al. [339] studied a hybrid cavity-magnet system by placing a YIG sphere into a copper cavity, as shown in @fig:auto23(a). The magnetization oscillation of the YIG sphere induces mechanical deformation via magnetostrictive interactions of the form [61] 
$
hat(cal(H))_(i n t) = b_1 integral d^3 r [ hat(m)_x^2 epsilon_(x x) + hat(m)_y^2 epsilon_(y y) - ( hat(m)_x^2 + hat(m)_y^2 ) epsilon_(z z) ] = b_1 M_s \/ V hat(a)^dagger hat(a) integral d^3 r ( epsilon_(x x) + epsilon_(y y) - 2 epsilon_(z z) ) ,
$ <mphonon_ZhangSA> where $b_1$ is magnetoelastic constant, $epsilon_(i j) equiv ( partial_j u_i + partial_i u_j ) \/ 2$ are the components of the strain tensor, $bold(u)$ is the atomic displacement, and $V$ is the volume of the magnet. In this model, the magnon-phonon interaction is dispersive, as the magnon frequency is shifted by the phonons. After quantizing the phonon operators, the effective coupling between the magnon and phonon modes is written as $hat(cal(H))_(i n t) = g_(m b) hat(a)^dagger hat(a) ( hat(b) + hat(b)^dagger )$, where $hat(b) ( hat(b)^dagger )$ is the annihilation (creation) operator for phonons. This justifies the magnon-phonon interaction that was used to study magnon-phonon entanglement in @sec_mpEn.

When the magnon frequency is tuned to be close to the photon frequency, two hybrid magnon-photon modes at energy $omega_plus.minus$ with eigenvectors $hat(A)_(+) = cos theta hat(c) + sin theta hat(a)$ and $hat(A)_(-) = - sin theta hat(c) + cos theta hat(a)$ are found as shown in @fig:auto23(b). Here, the magnon component of the hybrid mode is determined by the magnon-photon coupling $g_(m c)$ and the magnon-photon detuning $Delta_(m c)$ as, $tan 2 theta = 2 g_(m c) \/ Delta_(m c)$. The phonon mode does not play a role here because its MHz frequency is far below the magnon frequency, which is in GHz regime. To bring the magnon and phonon frequencies closer, a parametric driving $omega_d$ is applied to drive the cavity field. In the dressed basis, the interaction component of the Hamiltonian is rewritten as $hat(cal(H))_"int" = g_(m b) ( hat(b) + hat(b)^dagger ) (sin^2 theta hat(A)_(+)^dagger hat(A)_(+) + cos^2 theta hat(A)_(-)^dagger hat(A)_(-))$. Now both the beam-splitter-type interaction ($hat(A)_plus.minus^dagger hat(b) + hat(A)_plus.minus hat(b)^dagger$) and parametric interaction ($hat(A)_plus.minus^dagger hat(b)^dagger + hat(A)_plus.minus hat(b)$) between the phonon and the hybrid magnon-photon modes are realized and the coupling strength can be manipulated by the detuning between magnon and photon ($Delta_(m c)$ or angle $theta$). For red-detuned driving, the driving field only strongly interacts with the lower branch $omega_(-)$ and a typical Fano lineshape is observed with a transparent mode at the resonance, as shown in @fig:auto23(b). In the blue-detuned case, the driving is strongly coupled with the higher energy branch ($omega_(+)$), yielding a dip in the reflection spectra. By tuning the external magnetic field or magnon frequency, one is able to achieve the transition between these two situations, as shown in @fig:auto23(c). This is a distinct advantage of this hybrid system.


// [figvision-cn] imgs/magnon_mechanics.png
// 图(a)为实验装置示意图。左侧展示一个金色的长方体三维铜
// 腔，其顶部中央有一个U形凹槽。铜腔侧面连接一个圆柱形波
// 导接口。在铜腔的U形凹槽内放置着一个黑色的球体，代表钇
// 铁石榴石（YIG）球。左下角通过虚线框放大展示了铜腔内部
// 细节：黑色YIG球位于金色凹槽底部，旁边标有比例尺黑条。
// 右侧上方是一个圆形插图，标题为“Magnon mode”，显示黑色
// 背景上的三个黄色螺旋箭头，表示磁振子模式，并配有xyz坐
// 标系。右侧下方是另一个圆形插图，标题为“Deformation (
// top view)”，展示YIG球的俯视图变形情况，颜色从中心的红
// 色渐变到边缘的蓝色，周围环绕四个弯曲箭头指示形变方向，
// 下方标有“Vol. strain (a.u.)”及0到1的色标条。右下角还有
// 一个独立的YIG球示意图，表面呈红蓝渐变色，旁边标有垂直
// 磁场H（向上箭头）和位移u（0到1的色标）。 图(b)为反射谱
// 曲线图。横坐标为频率（Frequency），单位GHz，范围7.82至
// 7.90；纵坐标为反射率（Reflection），单位dB，范围-50至
// -20。图中有一条黑色实线曲线，呈现两个明显的凹陷（共振
// 谷）。第一个凹陷中心约在7.84 GHz，第二个在7.86 GHz。图
// 中标注了多个符号：ω_d（泵浦光子频率，位于7.83 GHz附近）、
// ω_s（探测光子频率，位于7.85 GHz附近）、Δ_+ 和 Δ_-（分
// 别对应上下杂化模式的失谐量，用红色和蓝色竖线标示）。整
// 体趋势表明当磁振子与腔光子共振时出现强耦合导致的分裂峰。
// 图(c)为多组测量反射谱堆叠图，包含主图和右侧局部放大图
// （Zoom-in）。横坐标分为两部分：左侧主图横坐标为失谐量Δ
// _sd（MHz），范围6至14；右侧放大图横坐标同样为Δ_sd（MHz），
// 但范围缩小至11.41至11.42。纵坐标均为反射率（Reflection），
// 单位dB，范围-60至-40。图中包含五条红色实线曲线，每条对
// 应不同外加磁场强度，从上到下依次为2719.17 Oe、2718.47
// Oe、2717.79 Oe、2717.03 Oe、2716.40 Oe。随着磁场降低，
// Fano型线型逐渐显现，并在特定条件下（如2717.79 Oe）出现
// 透明峰（即反射率局部升高）。右侧放大图清晰显示在Δ_sd ≈
// 11.41 MHz处出现的尖锐透明峰，伴随两侧不对称的Fano轮廓。
// 该图传达结论：在红失谐驱动下，靠近下杂化模区域可观测到
// Fano干涉效应及诱导透明现象。 图(d)为合作性（
// Cooperativity）随磁场变化曲线图。横坐标为磁场强度（
// Magnetic field），单位Oe，范围2720至2740；纵坐标为合作
// 性（Cooperativity），无量纲，范围0至2。图中包含两组数
// 据点：橙色空心方块（带误差棒）和蓝色空心圆圈（带误差棒），
// 分别拟合为橙色实线和蓝色实线曲线。两条曲线均呈钟形分布，
// 峰值位置略有偏移：橙色曲线峰值约在2728 Oe，蓝色曲线峰
// 值约在2732 Oe。图顶标注了ω_d和ω_s的位置及其相对移动方
// 向（双向箭头），并用红色向下箭头指向橙色曲线峰值区域，
// 蓝色向下箭头指向蓝色曲线峰值区域。此外，在曲线之间绘制
// 了两个简化的能级结构示意图，分别标记为Â⁻和Â⁺，示意上下
// 杂化模态。该图表明在不同磁场下系统合作性达到最大值，且
// 存在两个不同的最优工作点，对应于两种不同的杂化模式主导
// 区域。
#figure(placement: top, image("imgs/magnon_mechanics.png", width: 100.0%),
 caption: [
 (a) Schematic device containing a three-dimensional copper cavity and a YIG sphere. (b) The reflection spectrum when the magnon is on resonance with the cavity photon. (c) Measured reflection spectra with a red-detuned driving between pump and probe photons near the lower hybrid mode $A_-$. A Fano-like lineshape is identified, accompanied by a transparency peak when $Delta _(s d)=omega _b$, where $omega _b$ is the phonon frequency. (d) The magnonmechanical cooperativity as a function of bias magnetic field. The red and blue lines refer to the red and blue detuning between the pump and probe frequency, respectively. Source: The figures are adapted from Ref. [339].
 ]
) <fig:auto23>


Based on this accessible platform, various theoretical proposals have come up to study the interplay between magnons, phonons and photons. Sarma et al. [437] proposed a stimulated Raman adiabatic passage-like coherent transfer between the cavity mode and phonon mode, by properly tuning the driving and frequency detuning between cavity photon and magnon. The phonon mode with lower damping may be used to store the quantum state for a long time. Moreover, as introduced in @sec_mpEn, nonlinear magnon-phonon interactions enable the existence of steady-state entanglement among magnons, photons, and phonons at low temperature. Huai et al. [438] implemented gain to the magnonic system and constructed a $cal(P T)$ symmetric-like system with a passive cavity and active magnon modes. Lu et al. [439] studied the role of EPs in the hybrid system and showed flexible on-off optical transmission and slow-to-fast light switching near the EPs.


#emph[Coupling between magnons and external mechanical oscillators.] Alternatively, Gonzalez-Ballestero et al. [440,441] considered a spherical micromagnet (for example, YIG) trapped in a harmonic potential, as shown in @fig:auto24(a). The magnetic sphere experiences an external static field $upright(bold(B))_0 = B_0 upright(bold(e))_z$ and an oscillating gradient field $upright(bold(B))_d = b_g ( - x upright(bold(e))_x + z upright(bold(e))_z ) cos ( omega_d t )$. The static field tunes the magnon frequency while the inhomogeneous oscillatory field induces a coupling between the magnon mode and the center-of-mass motion of the magnet. This hybrid system is described by the Hamiltonian $ hat(cal(H)) = omega_x hat(b)^dagger hat(b) + omega_r hat(a)^dagger hat(a) + omega_p hat(c)^dagger hat(c) + g ( hat(a)^dagger hat(c) + hat(c)^dagger hat(a) ) + G_x cos ( omega_d t ) ( hat(a) + hat(a)^dagger ) ( hat(b) + hat(b)^dagger )   $ where $hat(b)$, $hat(a)$, $hat(c)$ are respectively the bosonic operators for the center-of-mass motion along the $x -$axis, the magnon mode and the acoustic mode with frequency close to the magnon mode. coupling strength $G_x$ is proportional to the amplitude of the oscillating field $b_g$. To study how the hybrid magnon-phonon mode couples with the center-of-mass motion, this Hamiltonian is partially diagonalized in the subspace of magnon and phonon through a Bogoliubov transformation and the result reads $ hat(cal(H)) = omega_x hat(b)^dagger hat(b) + sum_(alpha = 1)^2 Delta_alpha hat(d)_alpha^dagger hat(d)_alpha + ( hat(b)^dagger + hat(b) ) sum_(alpha = 1)^2 ( G_(x alpha) hat(d)_alpha^dagger + h . c . )   $ where $hat(d)_alpha$ ($alpha = 1, 2$) is a superposition of the magnon ($hat(a)$) and acoustic ($hat(c)$) mode, $Delta_alpha$ is the detuning between $i -$th eigenmode and the driving frequency, and the reduced couplings are $G_(x 1) = G_x \/ ( 2 lambda )$ and $G_(x 2) = - chi G_(x 1)$, with $chi = - 2 g \/ ( Delta - sqrt(Delta^2 + 4 g^2) )$ and $lambda = sqrt(1 + chi^2)$. To maximize the interaction between the acoustic mode and the center-of-mass motion, the detuning of the magnon frequency with respect to the driving frequency is adjusted ($Delta_2 = omega_x$) to guarantee that the $hat(d)_2$ mode is $99.99 %$ acoustic. In this way, an effective acoustomechanical system is realized. The authors further showed that this strong and tunable acoustomechanical coupling helps to probe the acoustic magnon excitation by measuring the mechanical displacement of the magnet. As shown in @fig:auto24(b), without acoustic magnon coupling ($b_g = 0$), the power spectrum of the magnet has a single peak at the intrinsic frequency $omega_x$. A strong enough coupling (larger $b_g$ in the figure) splits the peaks into two subpeaks. Such a tunable quantum platform can be realized using micromagnets levitated or deposited on a clamped nanomechanical oscillator, and it may open new possibilities for using acoustic phonons as a quantum memory and to study out-of-equilibrium quantum mesoscopic physics in a levitated particle.


Later, Colombano et al. [442] experimentally realized a hybrid magnet-mechanical system, by depositing a glass microsphere optical cavity on top of a YIG thin film, as shown in @fig:auto24(c). When an oscillating field acting on the magnet excites the magnon mode in YIG, it will also excite a deformation of the YIG sphere through magnetostrictive interactions. Such a deformation will immediately couple to the mechanical breathing mode of the microsphere. By detecting the mechanical motion of the sphere, the oscillating magnetic field can be indirectly recovered. Figure (d) shows the typical response of the system under an oscillating field of $2.3 mu$T at $206$ MHz. Clearly, a sharp peak response (red line) is observed, which disappears once the microsphere is levitated from the YIG film (black line), which demonstrates the mechanical origin of the signal. The authors estimated the field sensitivity of this technique at a few $"nTmedHz"^(- 1 \/ 2)$ at 206 MHz, which is close to the highest sensitivity of known magnetometers. The working frequency of this proposal can be extended to the GHz regime, by tuning the magnon frequency with an external field. This finding provides exciting opportunities to design a high-performance magnetometer.


// [figvision-cn] imgs/magnon_mechanics2.png
// 子图(a)为示意图，展示三种不同机械势阱中微磁体（灰色球
// 体）的构型。左侧部分从上至下依次排列三个结构：第一个结
// 构中，微磁体悬浮于一个开口向上的抛物线形势阱内；第二个
// 结构中，微磁体位于一个矩形块上方，该块表面有凹槽，微磁
// 体置于凹槽边缘；第三个结构中，微磁体被夹在两个平行板之
// 间，下方板上有网格状纹理。右侧部分为一个三维坐标系示意
// 图，坐标轴分别为x、y、z，其中z轴垂直向上。图中有一个灰
// 色球体代表微磁体，周围绘制了红色磁力线，表示由时变磁场
// B_d(r,t)产生的场分布，这些磁力线从球体表面向外辐射并弯
// 曲。同时，有一组绿色箭头沿z轴正方向排列，标注为B_0，表
// 示静态偏置磁场。整个示意图用于说明微磁体在不同机械约束
// 下的空间位置及所受磁场环境。 子图(b)为曲线图与嵌入子图
// 组合。主图横坐标为归一化频率ω/2π，单位为MHz，范围从10⁻
// ²到1 MHz，采用对数刻度；纵坐标为位移功率谱密度平方根√
// S_xx(ω)，单位为pm/√Hz，范围从10⁻³到10³，采用对数刻度。
// 图中包含三条橙色实线，分别对应不同的声-机耦合强度b_g值：
// 最下方一条标记为b_g = 0，中间一条标记为b_g = 2 × 10³ T
// /m，最上方一条标记为b_g = 2 × 10⁴ T/m。随着b_g增大，共
// 振峰高度显著增加，且峰值向低频移动。左上角嵌入一个子图，
// 横坐标为ω - ω_x (2π × kHz)，范围从-40到40 kHz；纵坐标
// 未明确标出但可推断为相对振幅或响应强度。该子图中有三条
// 彩色曲线：蓝色曲线对应Q_p = 10⁶，紫色曲线对应Q_p = 10⁷，
// 品红色曲线对应Q_p = 10⁸。每条曲线均呈现双峰结构，中心
// 凹陷处对应Q_p = 10⁹的情况（以黑色竖线标示）。右上角嵌
// 入另一个子图，横坐标为b_g (10³ T/m)，范围从0到20；纵坐
// 标为ω - ω_x (2π × kHz)，范围从-20到20。图中用颜色映射
// 表示S_xx^(1/2)/max[S_xx^(1/2)]的归一化响应强度，色标从
// 深绿（低值）到亮黄白（高值），并在两侧绘有虚线包络±
// G_x2(b_g)，显示响应随耦合增强的展宽趋势。 子图(c)为装
// 置结构示意图，展示磁强计的整体构造。主体是一个浅棕色基
// 底，其上放置一块黄色薄膜，标注为“YIG”（铁氧体钇铁石榴
// 石），薄膜上有一个圆形区域标注为“B”，可能代表局部磁场
// 作用区。YIG薄膜上方悬浮一个蓝色半透明球体，标注为“
// Microsphere”。在Microsphere右侧有一条细长矩形结构，标
// 注为“Waveguide”，即微带波导。图中还标注了两个力矢量：
// F_th（热噪声力，向上箭头）和F_mag（磁力，向下箭头），
// 作用于Microsphere。此外，在YIG薄膜左下角有一个小圆圈内
// 含螺旋符号，标注为B_DC，表示直流偏置磁场源。右下角另有
// 一个放大细节图，显示Microsphere内部存在环形电流（红色
// 箭头），产生自洽磁场，同时受到F_th和F_mag的作用。整体
// 布局表明该系统通过声学-机械耦合实现磁传感功能。 子图(d
// )为频谱响应图，包含三个部分。主图横坐标为Frequency (
// MHz)，范围从0到500 MHz；纵坐标为S(ω) (dBm)，范围从-90
// 到-80 dBm。图中红色曲线显示在约100 MHz和200 MHz处有两
// 个尖锐峰值，其余频段噪声水平约为-90 dBm。左下角嵌入一
// 个放大子图，横坐标为Frequency (MHz)，范围从200到220
// MHz；纵坐标为S(ω) (dBm)，范围从-90到-81 dBm。图中黑线
// 标注为“Thermal mode”，红线标注为“f_m = 206 MHz”，指示
// 在206 MHz处出现一个明显共振峰，高于热背景噪声。右下角
// 嵌入一个散点拟合图，横坐标为B (μT)，范围从1到约30 μT；
// 纵坐标为SNR^(1/2)，范围从1到5。图中五个粉色圆点呈线性
// 上升趋势，一条黑色直线穿过数据点，表明信噪比平方根与外
// 加磁场强度成正比关系。所有子图共同说明系统在特定频率下
// 具有高灵敏度磁探测能力，且性能随磁场增强而提升。
#figure(placement: top, image("imgs/magnon_mechanics2.png", width: 100.0%),
 caption: [
 (a) Schematic illustrations of a micromagnet trapped by a mechanical potential. (b) Power spectral density of the system at different acoustic-mechanical couplings ($b_g$). (c) Schematic representation of the magnetometer, containing a microsphere, a ferromagnetic YIG film and a microstrip waveguide. (d) Spectral response of a microsphere excited by applying an oscillating field of $2.3~ "muT"$ at 206 MHz (red line). The black curve is the response when the sphere is lifted from the YIG film. SNR is short for signal-to-noise ratio of the measurement. Source: The figures are adapted from Refs. [440,442].
 ]
) <fig:auto24>


Furthermore, Li et al. considered a hybrid cavity-magnet-mechanical oscillator system and showed that both classical and quantum states of magnons can be transferred to and stored in a distant long-lived mechanical resonator, through the assistance of optical pulses. The nonlocal entangled state of magnons and mechanical modes can also be prepared in this setup. Tan et al. [444] considered such a hybrid system and proposed a scheme to establish EPR steering channel between the magnon and phonon modes. Proskurin et al. [445] studied the coupling of magnetic domain walls pinned by a potential well with the cavity photons through magneto-optical interactions and found that the oscillating motion of the domain wall can be effectively coupled with the cavity photons in a nonlinear way as $hat(cal(H))_"int" = i g ( hat(b) - hat(b)^dagger ) hat(a)^dagger hat(a)$, where $hat(b)$ ($hat(b)^dagger$) is the quantization of the oscillating motion of the domain wall. This type of nonlinear interaction resembles the magnon-phonon coupling in Eq. #ref(<mphonon_ZhangSA>, supplement: none) and thus most of the physics presented there can be translated to such a system. This extension may generate nonclassical states of domain walls, which will significantly enrich current research efforts concerning the classical dynamics of domain walls.


== Hybrid magnon-electron systems
<sec_magnon_electron>
Finally, we discuss the coupling of magnons with electrons. We restrict ourselves to magnetic insulators because the magnetic quality of these materials, in particular, that of YIG, is much larger than that of metallic magnets. Magnons in magnetic insulators interact with electrons in adjacent normal metals via an interfacial exchange coupling $prop hat(S) ⋯ hat(s)$, where $hat(S)$ corresponds to the spin density in the insulator and $hat(s)$ to that of the metal. After rewriting the latter in terms of electronic creation and annihilation operators $hat(psi)_sigma$ and $hat(psi)_sigma^dagger$, with $sigma in { arrow.t, arrow.b }$ labelling the electronic spin state, and performing a HP transformation on $hat(S)$, we find that the interface coupling becomes $prop hat a psi ^†_(arrow.t) psi _(arrow.b) + (h.c.)$. Here, we restrict ourselves to the linearized version of the HP transformation and focus on terms that exchange spin between metal and insulators. The exchange of spin is clear from the fact the interface coupling describes that a spin flip in the normal metal is accompanied by the creation or annihilation of a magnon in the magnetic insulator, thereby leading to the exchange of one quantum of spin angular momentum between metal and insulator.


 physics that results from this coupling has been extensively studied in heterostructures with YIG as the magnetic insulator and Pt as the normal metal. Here, Pt is used because of its ability to convert spin current into charge current (and vice versa) via the (inverse) spin Hall effect that results from its large spin-orbit coupling. In setups consisting of a single Pt electrode on top of YIG, the so-called spin Seebeck effect, a magnon spin current that is driven by a thermal gradient and that is injected from YIG into Pt, was discovered [446]. In nonlocal setups with two Pt leads, electric actuation and detection of magnon spin current were achieved [447], and it was shown that the spin diffusion length of magnons is on the order of 10 $mu$m in YIG at room temperature. As discussed in @sec:quantummanybodystatesofmagnons, such nonlocal setups were used to probe signatures of spin superfluidity.


Both the spin Seebeck and nonlocal transport experiments probe thermal magnons for which quantum properties --- other then quantum statistics --- are not relevant. Kamra and Belzig [103] and Bender et al. [101] proposed to probe quantum properties, squeezing and temporal correlations, respectively, of magnons via spin-current noise in setups of normal metals on top of magnetic insulators. These theoretical proposals are waiting to be followed up experimentally. In a parallel development, spin current injection from insulating materials into normal metals has been used to probe various properties --- such as the magnetic phase diagram --- of quantum materials, in addition to the spin current itself. For a recent review, see Ref. [448]


To conclude, we have reviewed recent developments concerning the coupling between magnons with other quantum platforms. These hybrid platforms provide an avenue to study non-Hermitian physics, and suggest applications in quantum memories, high precision measurements, and quantum logic gates, as we shall introduce in the following two sections.


= Non-Hermitian physics and $cal(P T)$ symmetry
<sec_PT>


In recent years, non-Hermitian physics and $cal(P T)$ symmetry have attracted considerable attention. It was first discovered by Bender and Boettcher in 1998 [449] that non-Hermitian Hamiltonians allow for an entirely real spectrum as long as the combined parity ($cal(P)$) and time ($cal(T)$)-reversal symmetries are respected. $cal(P T)$ symmetry has been studied in optics, microwaves [453], acoustics [454], mechanics [455], electric circuits [456] and, recently, in magnonics [457,458] and magnon-polaritonics [459,460] Physical systems respecting $cal(P T)$ symmetry demonstrate exotic features. For example, a $cal(P T)$ symmetric ferromagnetic bilayer structure displays either a real spectrum or complex conjugate eigenfrequency pairs [457]. In the real-spectrum regime (termed the $cal(P T)$ exact regime), the eigenstates respect $cal(P T)$ symmetry and are equally distributed over both loss and gain ferromagnetic layers, and the whole system displays ferromagnetic behaviour. In the latter case (termed the $cal(P T)$ broken regime), the eigenstates deviate from equilibrium and the intensity is more concentrated either in the loss or gain layer associated with a phase transition from ferromagnet to antiferromagnet. The phase transition point has degenerate eigenvalues and eigenstates and is called an exceptional point (EP). Operating systems in different $cal(P T)$ phases or around EPs leads to new dynamics and unusual phenomena, with most achievements being reported in optics, such as unidirectional invisibility [450], loss-induced laser suppression [461], laser mode selection [462], and EP enhanced sensing [463,464,465]. Notably, the property that non-Hermitian Hamiltonian has real eigenvalues is not limited to $cal(P T)$ symmetry, but belongs to a larger class of "pseudo-Hermitian" systems. EPs generally stand for degeneracy points of any non-Hermitian system, like anti-$cal(P T)$ symmetric systems New physics and mechanisms in this emerging field are expected to be explored, for both fundamental interest and practical innovations.


== Preliminary knowledge of $cal(P T)$ symmetry
<preliminary-knowledge-of-mathcalpt-symmetry>



$cal(P T)$ symmetry in quantum mechanics requires that the potential satisfies $V ( hat(r) ) = V^(*) ( - hat(r) )$ [449], where $hat(r)$ is the position operator. The parity operator $hat(cal(P))$ reverses the sign of $hat(r) arrow.r - hat(r)$ and the time reversal operator $hat(cal(T))$ changes $i arrow.r - i$. The operator $hat(cal(P))$ is unitary and $hat(cal(T))$ is anti-unitary, and they commute with each other. As an example, we consider a two-level system describing two coupled sites with gain and loss $ hat(cal(H)) = mat(delim: "(", omega_1 - i kappa_1, g; g, omega_2 + i kappa_2; #none) , hat(cal(H)) | phi.alt_(1 , 2) chevron.r = E_(1 , 2) | phi.alt_(1 , 2) chevron.r , $

<PT_Ham>

where $omega_(1 , 2)$ is the single site energy, $kappa_(1 , 2)$ is the loss/gain parameter of the two sites, and $g$ is the coupling strength. When $kappa_(1 , 2) = 0$, the Hamiltonian is Hermitian and the eigenvalues are real. For general $kappa_(1 , 2)$, the Hamiltonian becomes non-Hermitian, and the eigenvalues are complex. To satisfy the $cal(P T)$ symmetry, we first define the parity operator as $ hat(cal(P)) = mat(delim: "(", 0, 1; 1, 0; #none) = hat(cal(P))^dagger , $ and the time-reversal operator corresponds to complex conjugation. Then, the Hamiltonian respects $cal(P T)$ symmetry, i.e., satisfies $[ hat(cal(P)) hat(cal(T)) , hat(cal(H)) ]$, if $omega_1 = omega_2 = omega_0$ and $kappa_1 = kappa_2 = kappa$. We therefore obtain the eigenvalues and eigenstates $ E_(1 , 2) = omega_0 plus.minus sqrt(g^2 - kappa^2) , phi.alt_(1 , 2) = (frac(- i kappa plus.minus sqrt(g^2 - kappa^2), g) , 1) . $

In the $cal(P T)$ exact regime, i.e., when the non-Hermiticity parameter $kappa < g$, the eigenvalues are completely real. Symmetry-breaking happens at $kappa = g$, beyond which the eigenvalues become complex ($cal(P T)$ broken). The phase transition point occurs, as mentioned before, at an EP. The eigenstates are no longer orthogonal, $chevron.l phi.alt_1 | phi.alt_2 chevron.r eq.not 0$, but follow a biorthogonal relation $chevron.l phi.alt_1^(\*) | phi.alt_2 chevron.r = 0$ In the $cal(P T)$ exact regime, the probability density of the eigenstates is equally distributed on the two sites because $| ( - i kappa plus.minus sqrt(g^2 - kappa^2) \/ g ) |^2 = 1$. However, at the EP, $phi.alt_1 = phi.alt_2 = [ - i, 1 ]^T$. In the $cal(P T)$ broken regime, two probability density of the eigenstates is unevenly distributed on site 1 and site 2.


#emph[Exceptional point.] non-Hermitian degeneracy point or the EP is not limited to $cal(P T)$ symmetry. The order $cal(N)$ of the EP is determined by the number of degenerate eigenstates. The lifting of the non-Hermitian degeneracy is a sub-linear effect: the eigenvalue splitting for an external perturbation $epsilon.alt$ at the EP is proportional to $| epsilon.alt |^(1 \/ cal(N))$, which thus provides a way to significantly enhance the sensitivity. This feature was recently confirmed in $cal(P T)$ symmetric optical laser system very presence of the EP would strongly affect the wave dynamics, by causing non-reciprocal energy transfer [470], eigenmode switching when encircling the EP [471,472]


#emph[Anyonic-parity-time symmetry.] Another type of interesting symmetry in non-Hermitian systems is the counterpart of $cal(P T)$ symmetry, called anti-parity-time ($cal(A P T)$) symmetry. A Hamiltonian respecting $cal(A P T)$ symmetry anti-commutes with the combined parity and time-reversal operators, i.e., ${ hat(cal(P)) hat(cal(T)), cal(H) } = 0$. For simplicity, we consider the following $cal(A P T)$ Hamiltonian $ hat(cal(H))_"APT" = mat(delim: "(", omega_0 - i kappa, i g; i g, - omega_0 - i kappa; #none) . $ An $cal(A P T)$-symmetric system is lossy in all sites with imaginary coupling. eigenvalues of the $cal(A P T)$-symmetric Hamiltonian are $E_(1, 2) = - i kappa plus.minus sqrt(omega_0^2 - g^2)$. In contrast to the $cal(P T)$ case, when $omega_0 > g$, the system is in the regime of $cal(A P T)$ symmetry, two eigenvalues are complex with the same imaginary parts. When $omega_0 < g$ and the system is turned into the $cal(A P T)$ broken regime, the eigenvalues become purely imaginary.


In the general case, the complex coupling between the two sites can be tuned in phase, and the system respects an anyonic-$cal(P T)$ symmetry $cal(P T)$ symmetry and $cal(A P T)$-symmetry are special cases when the coupling strengths are purely real and purely imaginary, respectively. anyonic-$cal(P T)$ Hamiltonian satisfies 
$
hat(cal(P)) hat(cal(T)) hat(cal(H)) = e^(- 2 i phi.alt) hat(cal(H)) hat(cal(P)) hat(cal(T)) .
$ <anionic> When $phi.alt = 0 med "or" med pi$, the Hamiltonian is $cal(P T)$ symmetric and satisfies bosonic commutation relations, while $phi.alt = plus.minus pi \/ 2$ corresponds to the $cal(A P T)$ symmetry and the Hamiltonian fulfills the fermionic commutation relation. An anyonic-$cal(P T)$ symmetric (laser) system is realized by manipulating the complex coupling from purely dispersive to purely dissipative [473] anyonic-$cal(P T)$ Hamiltonian is written as $ hat(cal(H))_(upright(A n y o n i c - cal(P T))) = mat(delim: "(", delta, g e^(i phi.alt); g e^(i phi.alt), - delta; #none)   $ where $delta = Delta omega - i Delta kappa$, with the frequency detuning $Delta omega$ and the loss difference $Delta kappa$ of each laser (relative to their average values). One can easily verify that the Hamiltonian satisfies the commutation relation #ref(<anionic>, supplement: none) if $tan phi.alt = Delta omega \/ Delta kappa$. For the $cal(P T)$ symmetric case $phi.alt = 0 med "or" med pi$, the EP is located at $Delta kappa = plus.minus g, Delta omega = 0$, while for $cal(A P T)$ symmetric one $phi.alt = plus.minus pi \/ 2$, the EP rotates $pi$ in $Delta omega - Delta kappa$ plane, at $Delta omega = plus.minus g, Delta kappa = 0$. By dynamically changing the coupling phase, the EP itself can move along a circle in parameter space, which corresponds to the relative dynamics of encircling the EP [470,471,472]


== $cal(P T)$ symmetry in spintronics
<mathcalpt-symmetry-in-spintronics>
Despite that $cal(P T)$ symmetry was originally developed in quantum mechanics, this concept has been employed in classical systems, such as photonic crystals, then extended to mechanical membranes and electrical circuits. As we have mentioned in this review, SWs have many properties analogous to electromagnetic waves, such as BEC [283,291], squeezed states [161,219], frequency combs [348], and quantum entanglement [185]. The success of exploring $cal(P T)$ symmetry and non-Hermiticity in optics stimulates these research activities in magnonic systems. We shall first review the studies of $cal(P T)$ symmetry in coupled magnets in Section~#ref(<sec_coupled_magnets_PT>, supplement: none). The physics here is mostly classical and it is included as a relevant and additional feature of the coupled magnets system discussed in @sec_magnonmagnon. Then we shall proceed to discuss the $cal(P T)$ symmetry in hybrid magnon-photon system in Section~#ref(<sec_cavity_magnonics_PT>, supplement: none). We expect purely quantum effects to manifest themselves as one goes to the low temperature regime or reduces the number of spins in the system, as discussed below.


=== $cal(P T)$ symmetry in coupled magnets
<sec_coupled_magnets_PT>


// [figvision-cn] imgs/Lee2015.png
// 该图包含四个子图，分别标记为(a)、(b)、(c)和(d)，展示了
// 两个交换耦合铁磁薄膜在外部磁场中的两种几何构型及其动力
// 学特性。 子图(a)是一个三维示意图，展示了垂直于膜面方向
// 的几何构型。图中有一个直角坐标系，x轴指向左前方，y轴指
// 向右前方，z轴垂直向上。主体由三个水平堆叠的长方体组成：
// 顶部是绿色长方体，内部标注文字“Loss”；中间是灰色薄层；
// 底部是红色长方体，内部标注文字“Gain”。在绿色和红色长方
// 体内部均画有向上的黑色箭头，代表磁场矢量H_c。在左侧，
// 有一个沿z轴正方向的外部磁场矢量，标记为H_0^ext。在右侧，
// 绘制了两个预cession（进动）矢量M_1（对应上层）和M_2（
// 对应下层），它们围绕一个平均磁化强度矢量M_0旋转。 子图
// (b)也是一个三维示意图，展示了平行于膜面方向的几何构型。
// 坐标系中，x轴指向左方，y轴指向前方，z轴垂直向上。主体
// 结构与(a)相同，分为上绿下红的两层及中间灰层，同样标注“
// Loss”和“Gain”。不同之处在于磁场方向：在左侧，有两个沿x
// 轴正方向的箭头穿过上下两层，标记为H_φ。在下方，有一个
// 沿x轴正方向的外部磁场矢量，标记为H_0^ext。在右侧，同样
// 绘制了矢量M_1、M_2以及平均磁化强度矢量M_0，显示其进动
// 状态。 子图(c)是一个二维曲线图，展示了混合系统特征值的
// 实部和虚部随吉尔伯特常数变化的函数关系。横坐标为α（
// Gilbert constant），范围从0到0.6，刻度标记为0, 0.2,
// 0.4, 0.6。纵坐标无明确物理量名称，数值范围从-1到2，主
// 刻度标记为0, 1, 2。图中包含两条黑色实线和两条红色虚线。
// 根据右上角图例，黑色实线代表特征值ω的实部Re[ω]，红色虚
// 线代表虚部Im[ω]。 具体趋势如下： Re[ω]（黑实线）：存在
// 两条分支。一条起始于纵坐标约1.8处，随α增加缓慢下降，在
// α约等于0.3处与另一条分支相遇并合并，随后继续下降至α=
// 0.6时约为1.2。另一条分支起始于纵坐标1.0，随α增加上升，
// 在α约等于0.3处与第一条分支汇合。 Im[ω]（红虚线）：同样
// 存在两条分支。一条起始于纵坐标0附近，随α增加缓慢上升，
// 在α约等于0.3处达到极小值（接近0），随后上升至α=0.6时约
// 为0.5。另一条分支起始于纵坐标0，随α增加迅速上升，在α约
// 等于0.3处与前一支汇合，之后变为负值并缓慢下降。 在α约
// 等于0.3的位置，所有曲线表现出异常点行为，即特征值发生
// 碰撞或分裂。 子图(d)是一个二维曲线图，展示了两层磁化强
// 度的-y分量比值及其相对相位差随吉尔伯特常数的变化。横坐
// 标为α，范围从0到0.6，刻度标记同(c)。纵坐标无单位，范围
// 从0到4，主刻度标记为0, 2, 4。图中包含一条黑色实线和一
// 条红色虚线。根据右上角图例，黑色实线代表R_y^(n)（两层
// 磁化强度-y分量的比值），红色虚线代表Δψ_y^(n)（相对相位
// 差）。 具体趋势如下： R_y^(n)（黑实线）：在α从0到约0.3
// 的区间内，数值保持在1.0左右不变。在α约等于0.3处发生突
// 变，曲线一分为二：一支迅速上升，在α=0.6时达到约3.0；另
// 一支迅速下降，在α=0.6时降至约0.5。 Δψ_y^(n)（红虚线）：
// 存在两条分支。一条起始于纵坐标约3.0，随α增加单调下降，
// 在α约等于0.3处降至约1.2。另一条分支起始于纵坐标0，随α
// 增加单调上升，在α约等于0.3处升至约1.2。两条分支在α约等
// 于0.3处相交，此后上方的分支继续缓慢下降，下方的分支保
// 持平稳。 该图表明在α约等于0.3处，系统的振幅比和相位差
// 发生了显著的非线性转变。
#figure(placement: top, image("imgs/Lee2015.png", width: 90.0%),
 caption: [
 Two exchange-coupled ferromagnetic thin films in an external magnetic field with two geometries: (a) out-of-plane and (b) in-plane. (c) Real and imaginary parts of eigenvalues of the hybrid system as a function of the Gilbert constant. (d) ratio of $y$-components of the magnetization in the two layers $R_y^n$ and their relative phase difference $Delta psi_y^n$ versus the Gilbert constant. Source: figures are adapted from Ref.
  [474]]
)
<Lee2015>


#emph[$cal(P T)$ symmetric magnetic bilayers.] Two coupled ferromagnetic films, one with loss and the other with a balanced gain, satisfy $cal(P T)$ symmetry. Interesting dynamics for the magnetization emerges in both $cal(P T)$ symmetry exact and broken regimes. The coupled dynamics are described by the LLG equations, as introduced in @sec_llg,
#eqgroup((
  [$ frac(partial upright(bold(m))_1, partial t) = - gamma upright(bold(m))_1 times upright(bold(H))_1 - gamma J upright(bold(m))_1 times upright(bold(m))_2 + alpha upright(bold(m))_1 times frac(partial upright(bold(m))_1, partial t) $],
  [$ frac(partial upright(bold(m))_2, partial t) = - gamma upright(bold(m))_2 times upright(bold(H))_2 - gamma J upright(bold(m))_2 times upright(bold(m))_1 - alpha upright(bold(m))_2 times frac(partial upright(bold(m))_2, partial t) $],
))
where the second layer has magnetic gain by via the reverse sign of the Gilbert damping constant $alpha$. Here, $upright(bold(m))_(1, 2)$ are the normalized magnetizations, $upright(bold(H))_(1, 2)$ are the local effective magnetic fields (considering only the external field and the demagnetizing field $upright(bold(H))_(1, 2) = upright(bold(H))_"ext" - 4 pi hat(N) M_s upright(bold(m))_(1, 2)$ with $hat(N)$ the demagnetizing tensor), $M_s$ is the saturation magnetization, and $J$ is the exchange coupling constant. The two equations are invariant under combined parity $hat(cal(P))$ and time reversal $hat(cal(T))$ operations, which means they are unchanged by interchanging $1 arrow.l.r 2$ together with $t arrow.l.r - t$. In the linear approximation, taking $upright(bold(m))_(1, 2) = upright(bold(e))_z + delta upright(bold(m))_(1, 2)$, and considering identical effective magnetic fields $upright(bold(H))_1 = upright(bold(H))_2 = H upright(bold(e))_z$, as shown in @Lee2015(a), one obtains the eigenvalues in the out-of-plane geometry as $ omega_(1, 2) = frac(omega_H + omega_J plus.minus sqrt(omega_J^2 - alpha^2 omega_H ( omega_H + 2 omega_J )), 1 + alpha^2)   $ where $omega_H = gamma H$ and $omega_J = gamma J M_s$. real and imaginary parts of the eigenvalues as a function of the Gilbert constant $alpha$ are plotted in @Lee2015(c). EP emerges at the critical Gilbert constant and frequency $ alpha_"cr" = omega_J \/ sqrt(omega_H ( omega_H + 2 omega_J )), med med med med med omega_"cr" = frac(omega_H ( omega_H + 2 omega_J ), omega_H + omega_J) . $


 ratio of the $y$-components $R_y^( n ) = | delta m_(1 y)^( n ) \/ delta m_(2 y)^( n ) |$ ($n = 1, 2$ denote the two eigenmodes) at $omega_J = 0.4 omega_H$ as a function of the Gilbert constant is plotted in @Lee2015(d), and so is the phase difference $Delta psi_y^( n )$. For $alpha = 0$, the phase differences are $0$ and $pi$, indicating a symmetric mode $delta upright(bold(m))_1 = delta upright(bold(m))_2$ and an antisymmetric one $delta upright(bold(m))_1 = - delta upright(bold(m))_2$, respectively. The two modes coalesce at the EP. A new type of steady-state magnetization dynamics is thus found: the precessional polar angle is bounded and neither attenuates (as in the case of loss) nor amplifies (as in the case of gain).


 notion of $cal(P T)$ symmetry in magnetic structures has been introduced by assuming a negative Gilbert constant. Pursuing a smaller Gilbert damping corresponds to a higher quality of the magnetic solid. How to realize a Gilbert damping arbitrarily close to zero or even across the border (negative damping) is an interesting and challenging problem [475]. It could effectively be implemented by injection of spin current via a spin-transfer torque. This latter scenario was used by Flebus et al. [476] to propose an array of coupled spin-torque oscillators that displays non-Hermitian topological phases and edge-state lasing.


// [figvision-cn] imgs/Yang2018.png
// 图(a)为三维示意图，展示一个双层铁磁体结构。坐标系原点O
// 位于左下角，x轴水平向右，y轴垂直纸面向外（用带箭头的斜
// 线表示），z轴竖直向上。上层为粉红色长方体，侧面标注“
// Gain”；下层为绿色长方体，侧面标注“Loss”。两层厚度相等，
// 沿z方向堆叠。在上层内部靠近右侧位置有一个黑色实心圆点，
// 标记为“m”，并有一条从左指向右的黑色箭头穿过该点；在下
// 层对应位置也有一个黑色实心圆点，标记为“m'”，同样有一条
// 从左指向右的黑色箭头穿过。两个箭头均平行于x轴，表示初
// 始磁化方向沿-x方向（即与箭头方向相反）。图中未显示比例
// 尺或具体尺寸数值。 图(b)为曲线图，横坐标为α，范围从0到
// 0.3，无单位标注；纵坐标为ω₁,₂ (GHz)，范围从-200到1000
// GHz。图中包含四条实线和两条虚线：蓝色实线对应kₓa = π/6
// 模式，红色实线对应kᵧa = π/4模式，另一条红色实线对应kᵧa
// = π/6模式（根据图例，实际应为三条不同颜色的实线分别代
// 表三种波矢条件，但图例中仅列出三个条目，其中前两个为蓝
// 色和红色，第三个也为红色——可能为笔误或颜色重复，按图例
// 文字描述为准）。所有实线表示Re(ω₁,₂)，即频率实部；所有
// 虚线表示Im(ω₁,₂)，即频率虚部。在α≈0.15处，有一个椭圆圈
// 出蓝色实线的交叉区域，并用箭头指向标注“Re(ω₁,₂)”；在α≈
// 0.18处，另一个椭圆圈出虚线发散区域，并用箭头指向标注“
// Im(ω₁,₂)”。趋势显示：随着α增大，各模式的实部频率变化平
// 缓，而虚部在α>0.1后开始显著分离，表明增益损耗参数α影响
// 模式稳定性。 图(c)为等高线图，横坐标为kₓd，范围从-π到π；
// 纵坐标为kᵧd，范围从-π到π。颜色映射由右侧色标给出，标签
// 为lg(α_c)，范围从-1.5（深蓝色）到1.5（黄色），中间绿色
// 对应0。图中中心区域为浅绿色至黄色，向外逐渐过渡为蓝紫
// 色。白色虚线勾勒出等值线，标注数值包括-1.8、-1.5、-1.2、
// -0.6、0.6、1.2、1.5等。中心最亮区域标注“Inf”，表示此处
// 临界增益损耗比趋于无穷大。整个图形呈近似圆形对称分布，
// 中心位于(kₓd=0, kᵧd=0)。白色区域（即lg(α_c)>0的区域）
// 内对称性未被破坏，如题注所述。
#figure(placement: top, image("imgs/Yang2018.png", width: 100.0%),
 caption: [
 (a) Schematic plot of a bilayer ferromagnet with balanced gain and loss. The magnetization of all spins is initially along the $x$-direction. (b) Evolution of $omega_(1, 2)$ as a function of $alpha$ for two representative spin-wave modes $upright(bold(k)) = [ pi \/ 6 d, pi \/ 4 d ]$ (blue curves) and $[ pi \/ 6 d, pi \/ 6 d ]$ (red curves). (c) Contour plot of the mode dependence on $alpha_c$. $cal(P T)$ symmetry is never broken in the white region. Source: figures are adapted from Ref.
  [457]]
)
<Yang2018>


#emph[Magnonic EPs.] Magnonic EPs are non-Hermitian degeneracies of SWs, which were first considered in ferromagnetic bilayers respecting $cal(P T)$ symmetry, as sketched in @Yang2018(a). Different from the macrospin case, the intralayer exchange coupling energy $- sum_(chevron.l i j chevron.r) J upright(bold(m))_i dot.op upright(bold(m))_j$ is considered with lattice constant $d$, on top of interlayer exchange $- sum_i lambda J upright(bold(m))_i dot.op upright(bold(m))'_i$, and the interfacial DM interaction $- sum_(chevron.l i j chevron.r) upright(bold(D))_(i j) dot.op ( upright(bold(m))_i times upright(bold(m))_j )$. One then derives the dispersion relation of SWs $ omega_(1, 2) ( upright(bold(k)) ) = lambda + 2 macron(zeta) ( upright(bold(k)) ) plus.minus sqrt(lambda^2 - 4 alpha^2 macron(zeta) ( upright(bold(k)) ) [lambda + macron(zeta) ( upright(bold(k)) )])   $ where $macron(zeta) ( upright(bold(k)) ) = 2 - cos k_x d - cos k_y d + ( D \/ J ) sin k_y d$. For any $upright(bold(k))$, the two eigenfrequencies approach each other as the gain-loss parameter $alpha$ increases, and coalesce at a critical value $alpha_(upright(c))$, i.e., at the second-order magnonic EP, $ alpha_c ( upright(bold(k)) ) = frac(lambda, 2 sqrt(macron(zeta) ( upright(bold(k)) ) [lambda + macron(zeta) ( upright(bold(k)) )])), med med med med med omega_c ( upright(bold(k)) ) = frac(gamma J, mu_0 M_s a^3) frac(lambda + 2 macron(zeta) ( upright(bold(k)) ), 1 + alpha_c^2 ( upright(bold(k)) ))   $ and then bifurcate into the complex plane [@Yang2018(b)]. In the $cal(P T)$ broken regime, an antiferromagnetic state appears in the gain layer. We point out that for $cal(P T)$ symmetric SW modes, a parameter region $- lambda lt.eq zeta ( upright(bold(k)) ) lt.eq 0$ exists in which the $cal(P T)$ symmetry is never broken in the framework of linear SW theory. This is in contrast to conventional $cal(P T)$ symmetric systems that always suffer from a symmetry breaking at the EP.


// [figvision-cn] imgs/Yu2020.png
// (a) 子图类型为三维示意图。图中展示了一个垂直堆叠的三层
// 结构，每一层包含一个球体代表宏观自旋（macrospin）。顶
// 层为红色球体，标注文字“Gain”；中间层为灰色球体，标注文
// 字“Neutral”；底层为蓝色球体，标注文字“Loss”。每个球体
// 中心引出一个黑色箭头指向左侧，表示磁化方向。在相邻两层
// 之间画有双向弯曲箭头，并标注希腊字母 $\lambda$，表示交
// 换耦合。右侧有一个坐标系图标，显示 x、y、z 轴方向。 (b
// ) 子图类型为三维立体示意图。图中展示了一个长方体薄膜异
// 质结结构，由上至下分为三层：顶层为红色块，侧面标注“
// Gain”；中间层为灰色块，侧面标注“Neutral”；底层为蓝色块，
// 侧面标注“Loss”。在薄膜左侧表面标有三个黑色矢量箭头，分
// 别对应三层，从上至下依次标记为 $m_1$、$m_2$、$m_3$，均
// 水平向左指。左下角设有 xyz 三维坐标轴，原点 O 位于左下
// 方，x 轴向右，y 轴向后，z 轴向上。 (c) 子图类型为二维
// 曲线图。横坐标为 $\alpha$，范围从 0 到 0.8，无单位；纵
// 坐标为 $\omega_n$ (GHz)，范围从 -10 到 30 GHz。图中包
// 含多条实线和虚线曲线。实线部分：一条曲线从左上角约 (0,
// 28) 处开始下降，在 $\alpha \approx 0.4$ 处与另一条从左
// 侧约 (0, 18) 开始的曲线相交，交点标记为绿色圆点并标注“
// EP2”；该下降曲线继续下行，在 $\alpha \approx 0.7$ 处与
// 第三条从左侧约 (0, 9) 开始的曲线相交，交点标记为红色圆
// 点并标注“EP3”。虚线部分：在纵坐标 0 附近有一组虚线，其
// 中一条在 $\alpha \approx 0.4$ 处出现分叉，分叉点标记为
// 绿色圆点；另一条在 $\alpha \approx 0.7$ 处出现分叉，分
// 叉点标记为红色圆点。整体趋势显示随着 $\alpha$ 增加，不
// 同模式频率发生简并与分裂，EP2 和 EP3 为异常点。 (d) 子
// 图类型为二维曲线图。横坐标为 $\alpha$，范围从 0 到 0.8；
// 纵坐标为 $\omega_n$ (GHz)，范围从 -20 到 40 GHz。图中
// 实线与虚线分布与 (c) 类似但数值范围更大。实线中，最上
// 方曲线从约 (0, 38) 下降，在 $\alpha \approx 0.35$ 处与
// 中间曲线（起始于约 (0, 28)）相交于绿色圆点“EP2”；该曲
// 线继续下降并在 $\alpha \approx 0.4$ 处与下方曲线（起始
// 于约 (0, 18)）相交于红色圆点“EP3”。虚线部分同样在 $\
// alpha \approx 0.35$ 和 $\alpha \approx 0.4$ 处分别出现
// 分叉，对应绿色和红色圆点。趋势表明系统存在两个异常点，
// 且频率随 $\alpha$ 变化呈现非对称演化。 (e) 子图类型为
// 一组六个小图组成的复合曲线图，排列为三行两列。所有子图
// 横坐标均为 $\lg \epsilon$ 或 $\epsilon$，纵坐标涉及频
// 率或其差值。第一行左图：横坐标 $\epsilon$ 从 0 到 0.01，
// 纵坐标 $\Omega$ (GHz) 从 11.92 到 12，一条直线上升。右
// 图：横坐标 $\lg \epsilon$ 从 -10 到 0，纵坐标 $\lg(\
// Omega_1 - \Omega_2)$ (log(GHz)) 从 -15 到 0，一条斜率
// 为 1.0 的直线，标注“slope=1.0”。第二行左图：横坐标 $\
// epsilon$ 从 0 到 0.01，纵坐标 Re($\Omega_n$) (GHz) 从
// 19.9 到 20.1，两条曲线形成蝴蝶结形状，分别标记 $\
// Omega_1$ 和 $\Omega_2$。右图：横坐标 $\lg \epsilon$ 从
// -10 到 0，纵坐标 $\lg|\text{Re}(\Omega_1 - \Omega_2)|$
// (log(GHz)) 从 -6 到 0，一条斜率为 0.50 的直线，标注“
// slope=0.50”。第三行左图：横坐标 $\epsilon$ 从 0 到
// 0.01，纵坐标 Re($\Omega_n$) (GHz) 从 13.5 到 15，三条
// 曲线，橙色实线标记“Numerical”，棕色虚线标记“Analytical
// ”，分别对应 $\Omega_1$、$\Omega_2$、$\Omega_3$。右图：
// 横坐标 $\lg \epsilon$ 从 -10 到 0，纵坐标 $\lg|\text{
// Re}(\Omega_3 - \Omega_2)|$ (log(GHz)) 从 -5 到 0，一条
// 斜率为 0.33 的直线，标注“slope=0.33”。整体传达系统在不
// 同参数区域下的本征值行为及幂律关系。
#figure(placement: top, image("imgs/Yu2020.png", width: 100.0%),
 caption: [
 (a) Three exchange-coupled macrospins consisting of a gain (red), neutral (gray), and (balanced-)loss (blue) spin. (b) Schematic plot of a ferromagnetic heterostructure with a gain, neutral, and loss layer, denoted by red, gray, and blue colors, respectively. The magnetizations of all layers are initially along the $x$ direction. Eigenvalues of the hybrid system versus Gilbert constant for (c) macrospin version and (d) spin-wave version with respect to wave vector $( k_x, k_y ) = ( pi \/ 30 d, 0 )$. (e) splitting of eigenfrequencies vs the perturbation follows linear, $epsilon.alt^(1 \/ 2)$ and $epsilon.alt^(1 \/ 3)$ responses, respectively, at FMR, EP2, and EP3. Source: figures are adapted from Ref.
  [458]]
)
<Yu2020>


Higher-order magnonic EPs are found as well in the $cal(P T)$ symmetric multilayer ferromagnetic systems. To illustrate the principle, Yu et al. consider a ferromagnetic trilayer structure [458], consisting of a gain, neutral, and loss spin (ferromagnetic layer), as shown in @Yu2020(a) and (b). Hamiltonian contains Zeeman energy, magnetic anisotropy, and interlayer exchange coupling, and is given by $ hat(cal(H)) = - mu_0 sum_(n = 1)^3 upright(bold(H)) dot.op upright(bold(M))_n - 1 \/ 2 sum_(n = 1)^3 K_n ( m_n^x )^2 - lambda mu_0 upright(bold(M))_2 dot.op ( upright(bold(M))_1 + upright(bold(M))_3 )   $ where $upright(bold(M))_n ( upright(bold(m))_n = upright(bold(M))_n \/ M_n )$ is the normalized spin vector, with $n = 1, 2   3$ labeling the layer. The external field is along the $x$ axis $bold(H)=H(e)_x$, $K_n > 0$ is the uniaxial anisotropy, and $lambda > 0$ is the ferromagnetic exchange coupling strength. The coupled magnetization dynamics is described by the LLG equations
#eqgroup((
  [$ frac(partial upright(bold(m))_1, partial t) = - gamma upright(bold(m))_1 times upright(bold(H))_"eff,1" - alpha upright(bold(m))_1 times frac(partial upright(bold(m))_1, partial t) $],
  [$ frac(partial upright(bold(m))_2, partial t) = - gamma upright(bold(m))_2 times upright(bold(H))_"eff,2" $],
  [$ frac(partial upright(bold(m))_3, partial t) = - gamma upright(bold(m))_3 times upright(bold(H))_"eff,3" + alpha upright(bold(m))_3 times frac(partial upright(bold(m))_3, partial t) $],
))
with the local effective magnetic fields $upright(bold(H))_"eff,n" = - mu_0 partial hat(cal(H)) \/ partial upright(bold(M))_n$. In the linear approximation, the above equations yield eigenmodes and frequencies. The evolution of eigenfrequencies as a function of the gain-loss parameter $alpha$ is plotted in @Yu2020(c), where the solid and dashed lines represent the real and imaginary parts of the eigenfrequencies respectively. It shows that EP2 and EP3 separately emerge at different critical $alpha$. In the vicinity of the non-Hermitian degeneracy at the EPs, a sub-linear response to external perturbations is displayed as $prop epsilon.alt^(1 \/ cal(N))$, with $cal(N)$ the order of the EPs. We consider a perturbation $epsilon.alt$ being added on the top macrospin by a small external magnetic field. The separation between the eigenfrequencies as a function of the strength of the perturbation is shown in @Yu2020(e). We observe a linear, $epsilon.alt^(1 \/ 2)$ and $epsilon.alt^(1 \/ 3)$ responses, respectively, for FMR, EP2 and EP3. To investigate the effect of fluctuations on the sensing performance [477,478], we consider a Gaussian distribution of the perturbation signal with a noise level $sigma$, i.e., $ P ( epsilon.alt - epsilon.alt_0 ) = frac(1, sqrt(2 pi) sigma) exp [- 1 \/ 2 (frac(epsilon.alt - epsilon.alt_0, sigma))^2]   $ where the signal $epsilon.alt_0$ is to be detected. We calculate the ensemble-averaged sensitivity and find the sensor performs well when $epsilon.alt_0 \/ sigma > 1$. The estimated magnetic sensitivity at EP3 is about $3 times 10^(- 14) med upright(T \/ H z)^(1 \/ 2)$ for a typical FMR frequency $5$ GHz and the FMR linewidth $5$ MHz. This value is three orders of magnitude higher than for a conventional magnetic sensor based on a magnetic tunnel junction [479].


The SW solution can be obtained by considering intralayer exchange coupling, as shown in @Yu2020(b). The evolution of the eigenfrequencies for wavevector $( k_x, k_y ) = ( pi \/ 30 d, 0 )$ with respect to the gain-loss parameter $alpha$ is shown in @Yu2020(d). Magnonic EP2 and EP3 emerge at different critical Gilbert constant. The sublinear response at the higher-order EP leads to an outstanding magnetic sensitivity. Hence, high-order magnonic EPs in all-magnetic structures are promising for designing ultra-high-sensitive magnetometers.


=== $cal(P T)$ symmetry in cavity magnonics
<sec_cavity_magnonics_PT>


Cavity magnonics---the emerging interdiscipline of cavity quantum electrodynamics and magnonics---has been rapidly developing in recent years [312,313,315,316,317,480,481,482]. An archetypal setup of the field consists of a YIG sphere placed in a microwave cavity, see @Zhang2014(a). As discussed in @sec_magnon_photon, a new type of bosonic quasi-particles, called cavity magnon-polaritons (CMPs), have been detected and characterized via the anti-crossing transmission spectrum, as shown in @Zhang2014(b), which results from the hybridization of magnons and cavity photons. The polaritonic eigenmodes are usually produced due to the strong light-matter interaction, that lies at the heart of cavity quantum electrodynamics and quantum information science. The entangled spin orientation and photon number state in CMPs enables an efficient quantum information transfer between photon and magnon via Rabi oscillation, which is promising for quantum computing. Recently, non-Hermitian singularities [325,483,484] have been experimentally observed in cavity-magnonic systems. $cal(P T)$ symmetric CMPs and, generally, non-Hermitian CMPs, offer exciting opportunities from the point of view of both scientific curiosity and new technological innovations.


// [figvision-cn] imgs/Zhang2014.png
// 子图(a)为实验装置示意图与模拟场分布图的组合。左侧展示
// 了一个金色的三维微波腔实物照片，该腔体呈长方体形状，顶
// 部有一个凹陷的槽，槽内放置着一个黑色的小球，通过引线标
// 注为“YIG sphere”（钇铁石榴石小球）。腔体侧面连接有一个
// 金属接头。右侧展示了该装置内部的电磁场模拟结果，为一个
// 半透明的长方体区域，内部填充了从深蓝色到红色的颜色渐变，
// 代表磁场强度h_mw的分布，旁边的色标显示范围从-1到1，单
// 位为a.u.（任意单位），红色表示正向最大值，蓝色表示负向
// 最小值。在长方体中心位置同样标示了一个黄色小球代表YIG
// 球体。一个红色的粗箭头垂直向下指向长方体，标注为“B”，
// 代表外加静磁场方向。右下角给出了三维坐标系指示，X轴向
// 右，Y轴向前，Z轴向下。该子图传达了检测腔磁极化激元（
// CMPs）的典型实验设置：将YIG球置于三维微波腔中并施加外
// 磁场。 子图(b)为二维热图形式的曲线图，展示了反射谱随频
// 率和磁场的变化。横坐标为“Magnetic field (mT)”（磁场），
// 范围从280 mT到282 mT。纵坐标为“Frequency (GHz)”（频率），
// 范围从7.84 GHz到7.92 GHz。图的右上角标注有“Refl. (dB)”，
// 表示纵轴数据为反射率，单位为分贝。右侧附有一个垂直的颜
// 色条，范围从-80 dB到-30 dB，颜色由深灰色（低反射率，即
// 高吸收或强耦合）过渡到浅灰色/白色（高反射率）。图中显
// 示了两条主要的深色带状区域，分别对应两个模式的频率响应。
// 上方的模式频率随磁场增加而略微上升，下方的模式频率随磁
// 场增加而下降。在磁场约为281 mT、频率约为7.87 GHz的位置，
// 这两条带并未交叉，而是相互排斥，形成了一个明显的能级反
// 交叉（anti-crossing）结构，这是CMPs存在的直接证据。该
// 子图结论是观测到了CMPs的反交叉现象。
#figure(placement: top, image("imgs/Zhang2014.png", width: 90.0%),
 caption: [
 (a) A typical setup for detecting CMPs consists of a YIG sphere placed inside a 3D-microwave cavity. (b) Observation of CMPs in the anti-crossing output spectrum. Source: figures are adapted from Ref.
  [313]]
)
<Zhang2014>


#emph[Non-Hermitian CMPs.] Conventional CMPs have a finite lifetime due to the intrinsic losses of photons and magnons. Pumping the cavity to compensate this dissipation may extend the coherent time and lead to a dynamical equilibrium. Such a pumped system is described by a non-Hermitian Hamiltonian, with the special features as discussed in previous sections. These features may significantly modify the properties of the polaritonic modes and the transmission spectrum. The experiment setup is sketched in @Zhang2017-1(a), where a YIG sphere is inserted into a 3D rectangular cavity. The essential physics is modelled by an archetypical two-level $cal(P T)$ symmetric Hamiltonian $ hat(cal(H))_"CPA" = ( omega_0 + i gamma_m ) hat(c)^dagger hat(c) + ( omega_0 - i gamma_m ) hat(a)^dagger hat(a) + g_(m c) ( hat(c) hat(a)^dagger + hat(c)^dagger hat(a) )   $ where the subscript CPA denotes polaritonic coherent perfect absorption, and $hat(c)^dagger ( hat(c) )$ and $hat(a)^dagger ( hat(a) )$ are the creation (annihilation) operators of a microwave photon and magnon, respectively. Both magnon and cavity photon are tuned on resonance with each other at the frequency $omega_0$, $g_(m c)$ is the coupling strength, and the photon gain is balanced with the magnon loss $gamma_m$. @Zhang2017-1(b) shows that the cavity has two ports for both measurement and feeding microwaves into the cavity. The total output spectrum is the sum of outputs from both ports. Hamiltonian commutes with the combined parity and time-reversal operator, i.e., $[ hat(cal(P)) hat(cal(T)), hat(cal(H))_"CPA" ] = 0$, and hence satisfies $cal(P T)$ symmetry. The corresponding eigenvalues are solved as $omega_(1, 2) = omega_0 plus.minus sqrt(g_m^2 - gamma_m^2)$. When $g_m > gamma_m$, the system is in the $cal(P T)$ exact regime with two entirely real eigenvalues, which results in two dips at zero in the output spectrum corresponding to the CPA frequencies. For $g_m < gamma_m$, a pair of complex conjugate eigenvalues appear. The symmetry is spontaneously broken and the CPA then disappears in this regime. The measured output spectrum is shown in @Zhang2017-1(c) versus the displacement of the YIG sphere in the cavity (the coupling strength $g_(m c)$ depends linearly on the displacement), which is consistent with the simulation shown in @Zhang2017-1(d). In the output spectrum, two real eigenvalues are located at zero output signal and coalesce at the EP when $g_m = gamma_m$. The central regime located around $x = 0$ in the spectrum without any zero dips represents the $cal(P T)$ broken phase.


// [figvision-cn] imgs/Zhang2017_1.png
// 图(a)为实验装置示意图。图中展示了一个棕色的三维矩形腔
// 体，其顶部中央有一个金属螺纹接口。一根细长的杆状物（木
// 质）斜插入腔体内部，杆的末端固定着一个深灰色的球体（
// YIG球）。图右侧标有三维直角坐标系，x轴水平向右，y轴垂
// 直纸面向外，z轴竖直向上。在腔体下方，一个蓝色箭头标注
// 为B0，指示外部磁场方向平行于杆的轴线。 图(b)包含两部分：
// 上方为腔体端口连接示意图，下方为两种对称性破缺状态下的
// 输出谱线对比图。上方示意图中，一个棕色矩形框代表腔体(
// Cavity)，内部左侧有一个黑色圆点代表钇铁石榴石(YIG)。腔
// 体顶部有两个耦合端口，分别标记为1和2。端口1处有两个蓝
// 色箭头，一个向下指向端口表示输入S1-，一个向左上方指出
// 表示反射信号；端口2处有两个红色箭头，一个向下指向端口
// 表示输入，一个向右上方指出表示输出S2+。下方左右并列两
// 个曲线图。左图标题为“Unbroken”（未破缺），纵坐标为|
// Stot-|^2，范围从0到1，横坐标为频率ω。图中绿色曲线呈现W
// 形，在中间区域有两个明显的凹陷，底部触及0值，两个红色
// 向下箭头指向这两个零点凹陷，下方文字标注为“Two zero
// dips”。右图标题为“Broken”（破缺），坐标轴定义同左图。
// 图中绿色曲线呈现U形，中间有一个凹陷但并未触及0值，下方
// 文字标注为“No zero dips”。 图(c)为实验测量的二维热图。
// 横坐标为位移x (mm)，范围从-4到4；纵坐标为归一化频率ω/2
// π (GHz)，范围从10.014到10.034。右侧颜色条表示总输出信
// 号强度|Stot-|^2 (dB)，数值范围从-53（深红/黑色）到-33
// （亮黄色）。图像主体显示两条V形的暗色轨迹（低信号区），
// 在x=0附近发生反交叉现象。左侧分支标记为I（上支）和II（
// 下支），右侧对应位置标记为III。白色空心圆圈叠加在暗色
// 轨迹上表示实验数据点。在中心区域(x≈0, y≈10.024)有一个
// 蓝色的X符号。图中还有三个蓝色箭头指向上方，分别位于x=
// -3, x=0, x=2附近。右下角标注有“Experiment”字样。整体趋
// 势显示随着位移x的变化，系统能级发生分裂与反交叉。 图(d
// )为理论模拟的二维热图，布局与图(c)一致。横坐标为位移x
// (mm)，范围-4到4；纵坐标为归一化频率ω/2π (GHz)，范围
// 10.014到10.034。顶部额外增加一行横坐标，表示耦合强度gm
// /2π (MHz)，刻度为5, 3, 1, 1, 3, 5，与下方的位移x对应。
// 右侧颜色条表示|Stot-|^2 (dB)，范围从-20（深蓝色）到0（
// 红色）。图像同样展示了V形的色带分布，其中深色区域（蓝
// 色）对应低信号强度，浅色区域（橙红色）对应高信号强度。
// 白色空心圆圈描绘了色带的边缘或特定特征轨迹。右下角标注
// 有“Simulation”字样。该图复现了实验中的反交叉结构，用于
// 验证理论模型。
#figure(placement: top, image("imgs/Zhang2017_1.png", width: 100.0%),
 caption: [
 (a) Sketch of the experimental setup, where a YIG sphere is glued on a wooden rod that is inserted into a 3D rectangular cavity. (b) cavity has 2 ports for both measurement and feeding microwaves into the cavity. The total output spectrum is the sum of outputs from both ports. The output spectrum has zero dips at zero when the system is in the unbroken-symmetry regime, corresponding to the coherent perfect absorption frequencies, which disappears in the broken-symmetry regime. Measured (c) and calculated (d) output spectrum versus displacement of the YIG sphere in the cavity. Source: figures are adapted from Ref.
  [483]]
)
<Zhang2017-1>


#emph[Pseudo-Hermiticity and higher-order EPs.] A cavity magnonic system without $cal(P T)$ symmetry but obeying pseudo-Hermiticity supports higher-order (e.g., third-order) EPs [485]. As an example, Zhang et al. considered a system consisting of two lossy YIG spheres coupled to a gain microwave cavity, as shown in @Zhang2017-2(a). The non-Hermitian Hamiltonian of the hybrid system reads


$ hat(cal(H))_"eff" = mat(delim: "(", omega_(upright(c)) + i kappa_g, g_1, g_2; g_1, omega_1 - i gamma_1, 0; g_2, 0, omega_2 - i gamma_2; #none)   $ in which the Kittel frequencies of the YIG spheres are denoted by $omega_(1, 2)$, and their losses with parameters $gamma_(1, 2) > 0$. The gain cavity has resonant frequency $omega_c$ and a gain coefficient $kappa_g > 0$. Such a ternary system does not respect $cal(P T)$ symmetry but can exhibit a real spectrum as well as second- and third-order EPs [see @Zhang2017-2(b)-(e)]. The eigenfrequencies of the system are obtained by solving the determinant $"Det" ( hat(cal(H))_"eff" - Omega I ) = 0$. According to the spectrum property of the pseudo-Hermitian Hamiltonian, the complex-conjugate equation $"Det" ( hat(cal(H))_"eff"^(\*) - Omega I ) = 0$ should have the same solutions. By comparing the corresponding coefficients of these two polynomial equations, one can derive the following constraints
#eqgroup((
  [$ kappa_g - gamma_1 - gamma_2 = 0 $ <constrains>],
  [$ Delta_1 gamma_1 + Delta_2 gamma_2 = 0 $ <constrains-b>],
  [$ ( Delta_1 Delta_2 - gamma_1 gamma_2 ) kappa_g + g_1^2 gamma_2 + g_2^2 gamma_1 = 0 $ <constrains-c>],
), base: 132)
where $Delta_(1 ( 2 )) = omega_(1 ( 2 )) - omega_c$ is the frequency detuning. Requiring pseudo-Hermiticity means ensuring that the total gain and loss are balanced in the whole system as indicated by Eq. #ref(<constrains>, supplement: none). For convenience, one can introduce the ratio of losses and couplings $eta = gamma_1 \/ gamma_2$ and $delta = g_2 \/ g_1$. It is found that the detunings should satisfy $Delta_2 = - eta Delta_1$ according to Eq. #ref(<constrains-b>, supplement: none). The last constraint Eq. #ref(<constrains-c>, supplement: none) leads to a minimal coupling strength $g_"min"$ to achieve an entirely real spectrum of the system. The emergence of the third-order EP thus does not require identical cavity-magnon couplings and magnon losses.


// [figvision-cn] imgs/Zhang2017_2.png
// 该图由五个子图组成，展示了一个包含两个有损耗钇铁石榴石
// （YIG）球与一个有增益微波腔耦合的混合系统的物理模型及
// 其本征值特性。 子图 (a) 为三维结构示意图。图中主体为一
// 个灰色的长方体微波腔，其顶部设有两个圆柱形端口，分别标
// 记为“Port 1”和“Port 2”。在腔体内部，沿水平方向排列着两
// 个紫色的球体，分别标记为“YIG 1”和“YIG 2”，代表两个钇铁
// 石榴石球。每个端口下方对应一个YIG球。对于Port 1，有一
// 个向下的蓝色箭头标记为 $a_1^{(in)}$，表示输入信号；一
// 个向上的红色弯曲箭头标记为 $a_1^{(out)}$，表示输出信号。
// Port 2具有相同的标注结构：向下蓝色箭头 $a_2^{(in)}$ 和
// 向上红色弯曲箭头 $a_2^{(out)}$。在腔体底部，有两个向上
// 的黄色粗箭头，分别位于YIG 1和YIG 2的正下方，标记为 $
// B_0 + \Delta B_1$ 和 $B_0 + \Delta B_2$，表示施加的偏
// 置磁场。左下角设有一个三维直角坐标系，x轴指向右侧，y轴
// 指向左前方，z轴指向上方。 子图 (b) 为二维曲线图，展示
// 对称情况下系统本征值的实部随耦合强度的变化。横坐标为 $
// g_1/2\pi$，单位为MHz，范围从1.5到2.4。纵坐标为 $\{Re[\
// Omega] - \omega_c\}/2\pi$，单位为MHz，范围从-4到4。图
// 中包含三条线：一条黑色实线恒定在纵坐标0处；一条红色虚
// 线和一条蓝色虚线在横坐标约1.7处发生相切并随后分离。在
// 相切点处有一个黑色箭头指向该点，并标注文字“EP3”。图的
// 左侧有一块浅绿色垂直背景区域，覆盖横坐标1.5至约1.6的范
// 围。 子图 (c) 为二维曲线图，展示非对称情况下系统本征值
// 的实部随耦合强度的变化。横坐标为 $g_1/2\pi$，单位为MHz，
// 范围从3.0到3.9。纵坐标无单位标注，数值范围从-2到1以上。
// 图中包含两条曲线：一条黑色实线和一条红色虚线在横坐标约
// 3.5处相交后分开；另一条蓝色虚线与红色虚线在横坐标约3.4
// 处相切。图中有两个标注：“EP3”指向蓝色虚线与红色虚线的
// 相切点，“EP2”指向黑色实线与红色虚线的交叉点。图的左侧
// 同样有一块浅绿色垂直背景区域，覆盖横坐标3.0至约3.2的范
// 围。 子图 (d) 为二维曲线图，展示对称情况下系统本征值的
// 虚部随耦合强度的变化。横坐标为 $g_1/2\pi$，单位为MHz，
// 范围从1.5到2.4。纵坐标为 $Im[\Omega]/2\pi$，单位为MHz，
// 范围从-2到2。图中包含三条线：一条黑色实线恒定在纵坐标0
// 处；一条红色虚线从正值下降至0；一条蓝色虚线从负值上升
// 至0。两条虚线在横坐标约1.7处同时到达0并与黑色实线汇合。
// 在该汇合点处有一个黑色箭头指向该点，并标注文字“EP3”。
// 图的右下角有一个图例框，标明红色虚线对应 $\Omega_+$，
// 黑色实线对应 $\Omega_0$，蓝色虚线对应 $\Omega_-$。图的
// 左侧有一块浅绿色垂直背景区域，覆盖横坐标1.5至约1.6的范
// 围。 子图 (e) 为二维曲线图，展示非对称情况下系统本征值
// 的虚部随耦合强度的变化。横坐标为 $g_1/2\pi$，单位为MHz，
// 范围从3.0到3.9。纵坐标为 $Im[\Omega]/2\pi$，单位为MHz，
// 范围从-2到1以上。图中包含三条线：一条黑色实线恒定在纵
// 坐标0处；一条红色虚线从正值下降，在横坐标约3.5处穿过0
// 变为负值；一条蓝色虚线从负值上升，在横坐标约3.4处达到
// 峰值后下降并在约3.5处穿过0。图中有两个标注：“EP3”指向
// 蓝色虚线与红色虚线在横坐标约3.4处的相切点（此时两者均
// 不为0）；“EP2”指向红色虚线与黑色实线在横坐标约3.5处的
// 交叉点。图的左侧有一块浅绿色垂直背景区域，覆盖横坐标
// 3.0至约3.2的范围。
#figure(placement: top, image("imgs/Zhang2017_2.png", width: 100.0%),
 caption: [
 (a)Two YIG spheres with losses coupled to a microwave cavity with gain. Real and imaginary parts of eigenvalues of the hybrid system versus the coupling $g_1$ for the symmetric case (b) and (d), as well as the asymmetric case (c) and (e). Source: figures are adapted from Ref.
  [485]]
)
<Zhang2017-2>


For the symmetric case, two Kittel modes have the same damping rates $gamma_1 = gamma_2 med ( eta = 1 )$. One then analytically obtains the condition to realize the third-order EP as $ g_1 = g_2 = g_"EP3" = 2 \/ sqrt(3) gamma_2, med med med med med Delta_1 = - Delta_2 = Delta_"EP3" = 1 \/ sqrt(3) gamma_2 . $ corresponding three eigenvalues read $omega_c, omega_c plus.minus sqrt(3 g_1^2 - 4 gamma_2^2)$ and their real and imaginary parts versus the coupling $g_1$ are plotted in @Zhang2017-2(b) and (d). green regime, i.e., $g_1 < g_"min"$, was not considered. This result shows that $g_"EP3" > g_"min"$ is experimentally accessible in the symmetric case.



For the asymmetric case, the magnonic losses $gamma_1 eq.not gamma_2 ( eta eq.not 1 )$. One can similarly obtain the parameters according to Eq. #eqref-parent(<constrains>) $ g_1 = g_(upright(E P 3)) = [frac(1 + eta delta^2, ( 1 + eta ) eta) + frac(3 ( 1 + delta^2 ), 1 + eta + eta^2)]^(- 1 / 2) 2 gamma_2 , Delta_1 = Delta_(upright(E P 3)) = [frac(1 + eta delta^2, ( 1 + eta ) eta) g_(upright(E P 3))^2 - gamma_2^2]^(1 / 2) . $ Numerical results for the spectra for $gamma_1 = 2 gamma_2$ are plotted in @Zhang2017-2(c) and (e), respectively, for the real and imaginary parts versus the coupling strength $g_1$. One observes the second- and third-order EPs separately at $g_(upright(E P 2)) = 3.600$ MHz and $g_(upright(E P 3)) = 3.394$ MHz.

We note that such exotic spectra can be experimentally detected via a transmission measurement as long as the cavity quality is high enough [102,210,486]. This provides a route to study pseudo-Hermiticity and higher-order EPs in a hybrid spincavitronic system.


// [figvision-cn] imgs/PTCMP_1.png
// (a) 示意图，展示微波腔内光子与两个具有平衡增益和损耗的
// 磁振子相互作用的过程。左侧为输入端口（In），右侧为输出
// 端口（Out）。腔体呈喇叭状，内部填充淡橙色渐变背景，表
// 示场分布。腔内有两个垂直排列的磁振子模式：左侧粉色圆圈
// 标记为 M₁，下方有向上箭头标注“Gain”；右侧蓝色圆圈标记
// 为 M₂，下方有向下箭头标注“Loss”。两者通过虚线双向箭头
// 连接，表示耦合。底部灰色半椭圆区域标注“Environment”，
// 表示环境耦合。所有文字均为黑色或彩色标注，无坐标轴。 (
// b) 曲线图，横轴为 P（无量纲参数），范围 0.0 至 3.0；纵
// 轴为 ω/g（归一化频率），范围 -2 至 6。图中包含两条实线
// （代表本征频率实部）和两条虚线（代表本征频率虚部）。在
// P ≈ 1.5 处，两条实线相交于一点，该点被红色星号标记并标
// 注“EP2”。在 Δ = -0.3 条件下绘制，左上角标注“Δ = -0.3”。
// 随着 P 增大，实部分支从分离逐渐靠近并在 EP2 合并后再次
// 分离；虚部分支在 EP2 处交叉并保持对称。 (c) 曲线图，结
// 构与 (b) 相同，但对应 Δ = 0 条件。横轴 P 范围 0.0–3.0，
// 纵轴 ω/g 范围 -2–6。两条实线在 P ≈ 1.8 处相交，交点标
// 为“EP3”（红色星号）。虚线同样在此处交叉。左上角标注“Δ
// = 0”。趋势显示当 detuning 为零时，例外点位置向右移动至
// 更高 P 值。 (d) 相图，横轴为 Δ（detuning 参数），范围
// -2 至 2；纵轴为 P，范围 0 至 √2（约 1.414）。图中以颜
// 色区分三个区域：浅蓝色区域 I 标注“Unbroken”，位于下部；
// 粉红色区域 II 标注“Broken”，位于上部；中间由一条 U 形
// 边界分隔。边界上标有三个关键点：左侧拐点“EP2”，顶点“
// EP3”（红色星号），右侧未命名拐点。EP3 位于 Δ=0, P≈√2
// 处。整个图形传达系统在不同 detuning 和增益-损耗强度下
// 的相位行为转变。 (e) 热图，横轴 Δ 范围 -2 至 2，纵轴 (
// ω−ωc)/g 范围 -2 至 2。颜色条位于顶部，标签为 |S₂₁|²，
// 范围 0.0–1.0，颜色从深蓝（低透射）到亮橙（高透射）。图
// 中显示两条明亮轨迹：一条从左下向右上倾斜，另一条从右下
// 向左上倾斜，二者在中心附近交汇形成 X 型结构。右侧附加
// 小图显示在固定 Δ 下 |S₂₁|² 随频率变化的谱线，标注 κs、
// κ₀、κp 等衰减率符号。右下角标注“P = 0.5”。 (f) 热图，
// 结构与 (e) 相同，但对应 P = P_EP3 条件。横轴 Δ 范围 -2
// 至 2，纵轴 (ω−ωc)/g 范围 -2 至 2。颜色映射同前。图中仅
// 有一条水平亮带贯穿整个 Δ 范围，表明在例外点处透射峰不
// 再分裂。右侧小图显示单一尖锐共振峰，标注“2κ_EP3”。右上
// 角标注“EP3”。 (g) 热图，横轴 Δ 范围 -2 至 2，纵轴 (ω−ω
// c)/g 范围 -2 至 2。颜色映射同前。图中显示两条弯曲亮带，
// 在 Δ ≈ ±1 处发生明显弯折，呈现非单调色散关系。右侧小图
// 显示双峰结构，标注 κs、κ₀、κp。右下角标注“P = 2”。 (h)
// 热图，横轴 Δ 范围 -2 至 2，纵轴 (ω−ωc)/g 范围 -2 至 2。
// 颜色映射同前。图中仅有一条水平亮带，无任何弯曲或分裂，
// 表示无耦合情况。右侧小图显示单峰，标注“2κ_p”。右上角标
// 注“Bare”。 (i) 曲线图，横轴 P 范围 0.0–3.0，纵轴 κ_CMP
// /κ_c 范围 0–6。图中三条曲线分别用不同符号表示：空心方
// 块（κ_s）、空心圆（κ_0）、空心菱形（κ_p）。在 P ≈ 1.5
// 处，κ_s 和 κ_0 曲线急剧上升，而 κ_p 保持平缓。图中用斜
// 纹阴影区标示过渡区域，并用红色星号标记“κ_EP3”位置。左
// 侧标注“I”，右侧标注“II”，对应相图中的区域划分。 (j) 曲
// 线图，横轴 Δ 范围 -0.2 至 0.2，纵轴 δω_EP3/g 范围 -0.5
// 至 0.5。图中两条曲线：红色实线和蓝色实线，分别从正负两
// 侧趋近原点，在 Δ=0 处汇合。右下角插入一个小图，显示在
// Δ=0.1 条件下 |S₂₁|² 随 (ω−ωc)g 的变化曲线，峰值偏移量
// 标注为 δω_EP3。主图左下角标注“P=P_EP3”。整体展示在例外
// 点附近频率偏移对 detuning 的线性响应。
#figure(placement: top, image("imgs/PTCMP_1.png", width: 100.0%),
 caption: [
 (a) Schematic illustration of photon scattering by two magnons with balanced gain and loss in a microwave cavity. (b-c) Evolution of eigenfrequencies as a function of the gain-loss parameter $P$, where the solid and dashed curves respectively represent the real and imaginary part of the eigenfrequencies. The detuning parameters are chosen to be (b) $Delta = - 0.3$ and (c) $Delta = 0$. The cavity frequency is set as $omega_(upright(c)) \/ g = 5$. (d) $cal(P) cal(T)$ symmetric phase transition diagram. Transmission spectrum for different gain-loss parameters: (e) $P = 0.5$, (f) $P = sqrt(2)$, and (g) $P = 2$. (h) Transmission spectrum of a bare cavity. The right panels in (e)-(h) show the zero-detuning spectrum. (i) Linewidth of CMP modes $kappa_"CMP" in { kappa_(upright(s)), kappa_(upright(o)), kappa_"EP3", kappa_(upright(p)) }$ as a function of the gain-loss parameter $P$ at the zero detuning point. Symbols are numerical results and solid curves are the asymptotic formulas #eqref-parent(<Eq-width>). The dashed area is not accessible because of the strong overlap between modes. (j) Sensitivity at $P = P_"EP3"$. Symbols denote numerical results and the blue curve represents the analytical formula #ref(<Sensitivity>, supplement: none). (Inset) Transmission spectrum as a function of the mode frequency at detuning $Delta = 0.1$. calculations use $kappa_(upright(c)) \/ g = 0.1$. Source: figures are adapted from Ref.
  [487]]
)
<PTCMP-1>

#emph[$cal(P T)$ symmetric CMP and exceptional magnetic sensitivity.] The ternary system with $cal(P T)$ symmetry is implemented by a lossless cavity and balanced gain and loss magnonic modes. A setup consisting of two magnetic bodies with balanced gain and loss placed inside a microwave cavity [@PTCMP-1(a)], has been proposed to realize an ultrahigh sensitivity magnetometer, based on the higher-order EP [487]. The system is described by the following non-Hermitian bosonic Hamiltonian $ hat(cal(H)) = omega_(upright(c)) hat(c)^dagger hat(c) + ( omega_(upright(s)) + i macron(beta) ) hat(s)_1^dagger hat(s)_1 + ( omega_(upright(s)) - i macron(beta) ) hat(s)_2^dagger hat(s)_2 + g [hat(c)^dagger ( hat(s)_1 + hat(s)_2 ) + h . c .] , $

<Eq-Ham>

where $hat(c)^dagger ( hat(c) )$ and $hat(s)_(1 , 2)^dagger ( hat(s)_(1 , 2) )$ are the photon and magnon creation (annihilation) operators, respectively, $omega_(upright(c))$ is the cavity's resonance frequency, $omega_(upright(s))$ denotes the Zeeman splitting, $macron(beta) > 0$ describes the energy dissipation/amplification rate, and $g$ represents the magnon-photon coupling strength. Under the combined operation of parity $hat(cal(P))$ ($hat(s)_1 arrow.l.r hat(s)_2$) and time reversal $hat(cal(T))$ ($i arrow.r - i$, $hat(s)_(1 ( 2 )) arrow.r - hat(s)_(1 ( 2 ))$, and $hat(c) arrow.r - hat(c)$), it is straightforward to find that Eq. #ref(<Eq-Ham>, supplement: none) is invariant and thus respects $cal(P) cal(T)$ symmetry. The direct exchange coupling between magnons is assumed to be absent in the present model.



One considers single particle processes, so that the three states ${hat(c)^dagger | 0 chevron.r, med hat(s)_1^dagger | 0 chevron.r, med hat(s)_2^dagger | 0 chevron.r}$ constitute a complete basis, where $| 0 chevron.r$ represents the vacuum state. Hamiltonian can therefore be expressed in the following matrix form $ hat(cal(H)) = mat(delim: "(", omega_(upright(s)) + i macron(beta), 0, g; 0, omega_(upright(s)) - i macron(beta), g; g, g, omega_(upright(c)); #none) . $ By solving $hat(cal(H)) | phi.alt chevron.r = omega | phi.alt chevron.r$, we obtain the following cubic equation for the eigenvalues 
$
(Omega^2 + P^2) (Omega + Delta) - 2 Omega = 0
$ <Eq-Cubic> with $Omega = ( omega - omega_(upright(s)) ) \/ g$, $Delta = ( omega_(upright(s)) - omega_(upright(c)) ) \/ g$ the frequency detuning, and $P = macron(beta) \/ g$ being the balanced gain-loss parameter.



The evolution of the three eigenvalues is demonstrated in @PTCMP-1(b) and (c), where the solid and dashed lines correspond to real and imaginary parts, respectively. The third-order EP3 appears in the case of resonance between photon and magnon, i.e., $Delta = 0$. The phase diagram [plotted in @PTCMP-1(d)] is determined by the sign of the discriminant $ Lambda = P^2 Delta^4 + ( 2 P^4 + 10 P^2 - 1 ) Delta^2 + ( P^2 - 2 )^3 $ of Eq. #ref(<Eq-Cubic>, supplement: none). $Lambda < 0$ gives the $cal(P) cal(T)$ exact phase, in which all three eigenvalues are real and the eigenvectors satisfy the so-called biorthogonal relation $chevron.l phi.alt_i^(*) | phi.alt_j chevron.r = delta_(i j)$ with $i , j = 1 , 2 , 3$. For $Lambda > 0$, only one real eigenvalue survives and the other two become complex conjugates to each other, which corresponds to the $cal(P) cal(T)$ broken phase. EP2 occurs along the critical curve $Lambda = 0$ but with $Delta eq.not 0$ [see the grey curve in @PTCMP-1(d)]. EP3 emerges when both $P = P_(upright("EP3")) = sqrt(2)$ and $Delta = 0$ are simultaneously satisfied [see the red star in @PTCMP-1(d)].

For a conventional CMP system, strong coupling is usually identified from the gap of the transmission spectrum at the resonance point. From input-output theory [210], the scattering coefficient is analytically obtained as 
$
S_21 = frac(kappa_(upright(c)), i ( omega - omega_(upright(c)) ) - kappa_(upright(c)) + Sigma ( omega ))
$ <Eq-S21> where the total self-energy $Sigma ( omega ) = Sigma^"gain" ( omega ) + Sigma^"loss" ( omega )$ from the magnon-photon coupling includes two parts: $Sigma^(upright(g a i n \/ l o s s)) ( omega ) = g^2 \/ [ i ( omega - omega_(upright(s)) ) plus.minus beta ]$ for gain ($+$) and loss ($-$), respectively. One notes that $Sigma ( omega )$ now is purely imaginary, leading to a fully transparent transmission at resonance.


@PTCMP-1(e)-(g) show the transmission spectrum $| S_21 |^2$ as a function of the mode frequency $omega$ and the cavity detuning $Delta$, for different gain-loss parameters $P$. As a reference, one plots the bare-cavity spectrum in @PTCMP-1(h). For $P < P_"EP3"$, one finds that the transmission spectrum displays a novel "Z"-shape [see @PTCMP-1(e)], instead of the conventional level anticrossing. Furthermore, the authors observed three peaks in the strong-coupling region ($Delta tilde 0$), in which the ultranarrow central mode corresponds to the dark-state CMP, besides two sideband abnormal Rabi-splitting modes. An increasing $P$ leads to a coalescence of the peaks. For $P = P_"EP3"$, three eigenvalues merge together at $omega_(upright(c))$, and form a flat and wide transparent window shown in @PTCMP-1(f). When $P$ further increases, i.e., $P > P_"EP3"$, the dark-state CMP mode still survives, with its linewidth however being significantly broadened as plotted in @PTCMP-1(g). This is a Purcell-like effect induced by the $cal(P) cal(T)$ symmetry breaking. The authors paid special attention to the $P$-dependence of the linewidth of the spectrum at zero detuning, and derived the following asymptotic formulas [solid curves in @PTCMP-1(i)]
#eqgroup((
  [$ P arrow.r 0 : med kappa_(upright(s)) \/ kappa_(upright(c)) tilde.eq ( P^2 + 2 ) \/ 4, med med med med kappa_(upright(o)) \/ kappa_(upright(c)) tilde.eq P^2 \/ 2 $ <Eq-width>],
  [$ P gt.double P_"EP3" : med kappa_(upright(p)) \/ kappa_(upright(c)) tilde.eq P^2 \/ ( P^2 - 2 ) $],
), base: 140)
which agree well with the numerical results [symbols in @PTCMP-1(i)].


 sensitivity is conventionally defined as the splitting of the eigenfrequencies perturbed around the EP. However, this becomes unfeasible due to the significant spectrum broadening near the EP as shown in @PTCMP-1(f). In the present model, there always exists a real central mode no matter whether the $cal(P) cal(T)$ symmetry is broken or not. A more appropriate definition of the sensitivity is the separation between the always-real central mode and the constant cavity mode. At $P = P_"EP3"$, 
$
delta omega_"EP3" \/ g = - "sgn" ( Delta ) delta theta, med med med med "with" med med delta theta = 2^(1 \/ 3) | Delta |^(1 \/ 3)
$ <Sensitivity> which is consistent with the numerical results in the small detuning regime, as plotted in @PTCMP-1(j). For detuning $| Delta | < 0.06$ (corresponding to the magnetic field $| delta B | < 2$ mT for $g tilde 1$ GHz), exceptional sensitivity on the order $| Delta |^(1 \/ 3)$ is still present. Considering the cavity frequency resolution $| delta omega_"EP3" | tilde kappa_(upright(c))$, the magnetic sensitivity is expressed as $ | delta B | approx frac(kappa_(upright(c)), 2 gamma C)   $ where $C tilde g^2 \/ kappa_(upright(c))^2$ is the strong coupling cooperativity ranging from $10^3 tilde 10^7$ For a microwave cavity working at GHz with a MHz resolution and a (sub-)MHz noise, the sensitivity is estimated as $tilde 10^(- 15) med upright(T) med "Hz"^(- 1 \/ 2)$, which is two orders of magnitude higher than that of the state-of-the-art magnetoelectric sensors [489]. Hopefully, the EPs discussed here are promising candidate for designing high-precision sensing device.


// [figvision-cn] imgs/Zhao2020.png
// 子图(a)包含左右两个部分。左侧为实验装置示意图，展示一
// 个垂直放置的长方体微波腔体，其内部填充有从底部蓝色渐变
// 至顶部红色的三维热图，表示场强分布，右侧附有颜色条，标
// 注“High”（高）对应红色，“Low”（低）对应蓝色。腔体内嵌
// 三个倾斜排列的天线：Antenna 1、Antenna 2、Antenna 3，
// 分别以红、绿、蓝三色矩形块表示，位置交错分布于腔体不同
// 高度和深度。右侧为系统耦合模型示意图，中心是两个黑色小
// 球，分别标记为“Sphere 1”和“Sphere 2”，代表两个钇铁石榴
// 石（YIG）球体。两球之间由双向黄色弧形箭头连接，标注“iΓ
// ”，表示非厄米耦合强度。每个球下方各有一个向下的灰色箭
// 头，分别标注“γ₁”和“γ₂”，代表各自的损耗率。两侧各有一个
// 橙色弯曲板状结构，象征耗散腔壁；左侧腔壁旁无额外标注，
// 右侧腔壁旁有三条向外发散的粉红色波浪线，标注“κ”，表示
// 腔体的整体耗散速率。 子图(b)为曲线图，横坐标为“κ/2π (
// MHz)”，范围从0到120 MHz，纵坐标为“Re λ±”，范围从-4到4
// （单位未明确标出，但根据上下文应为频率或能量本征值的实
// 部）。图中包含两条蓝色实线，分别代表理论拟合的两个本征
// 频率实部λ₊和λ₋；同时散布多个空心圆圈，代表实验测量数据
// 点。在横坐标约15 MHz处有一条垂直分界线，其右侧区域被浅
// 灰色阴影覆盖，并标注“broken phase”。在κ/2π < 15 MHz区
// 间，两条曲线几乎重合于零附近；当κ/2π > 15 MHz时，两条
// 曲线迅速分离，一条上升至约+3，另一条下降至约-3，呈现对
// 称分裂趋势。实验数据点与理论曲线高度吻合。 子图(c)同样
// 为曲线图，横坐标与子图(b)相同，为“κ/2π (MHz)”，范围0–
// 120 MHz；纵坐标为“Im λ±”，范围从-20到0（单位为虚部频率
// 或衰减率）。图中同样包含两条蓝色实线和多个空心圆圈，分
// 别对应理论预测和实验数据。在κ/2π < 15 MHz区间，两条曲
// 线均位于负值区，其中一条从约-18快速上升至约-5，另一条
// 从约-3缓慢下降至约-5，两者在κ/2π ≈ 15 MHz处交汇。进入
// 灰色阴影区（broken phase）后，两条曲线趋于平缓，稳定在
// 约-5附近。实验数据点与理论曲线一致显示：在临界点前虚部
// 存在显著差异，之后趋同并维持恒定负值，表明系统进入破缺
// 相后阻尼行为趋于一致。
#figure(placement: top, image("imgs/Zhao2020.png", width: 100.0%),
 caption: [
 (a)Two YIG spheres with losses coupled to a large dissipative microwave cavity. (b) Real and (c) imaginary parts of the eigenfrequencies as a function of the cavity dissipation rate $kappa$. The shadowed area is the $cal(A P T)$ broken phase. The dots and solid lines represent the experimental data and theoretical prediction, respectively. Source: figures are adapted from
 ]
)
<Zhao2020>

#emph[$cal(A P T)$ symmetry in CMPs.] The concept of $cal(P T)$ symmetry has been extended to other contexts. $cal(A P T)$ symmetry represents such a generalization. The difference with $cal(P T)$ symmetry lies in that $cal(P T)$ symmetry requires the presence of gain to compensate the loss of the system, while $cal(A P T)$ symmetry can be realized in all-lossy systems. Zhao et al. [467] considered the example sketched in @Zhao2020(a), in which two YIG spheres with nearly equal losses $gamma_m$ are placed in a large dissipative microwave cavity. Two YIG spheres are working in the low excitation regime and the magnon excitations of the YIG sphere are simply regarded as harmonic oscillators (Kittle modes only). The two magnons are directly coupled to the microwave photon. By eliminating the photonic degree of freedom, one obtains the effective $cal(A P T)$ magnon Hamiltonian $ hat(cal(H))_(upright(e f f)) = mat(delim: "(", Omega - i ( gamma_m + Gamma ), - i Gamma; - i Gamma, - Omega - i ( gamma_m + Gamma ); #none) , $ where $i Gamma$ is the dissipative coupling-rate of the two magnets mediated by the cavity mode and $Omega$ is the effective frequency detuning between the two magnons. In the regime of $kappa_c gt.double gamma_m$, we have $Gamma = g^2 / kappa_c$ with $g$ the direct coupling strength between magnons and photons and $kappa_c$ the cavity dissipation rate. The eigenvalues are plotted as solid lines in @Zhao2020(b) and (c). The eigenvalues are purely imaginary in the $cal(A P T)$ exact regime, and bifurcate into complex values with the same imaginary parts in the $cal(A P T)$ broken regime.






In the experiments, the magnon states (frequencies) are detected from the output photon spectrum. Experimental measurements of the hybridized magnon modes can be achieved from magnon-read out methods, by exacting the dips and linewidth from the transmission and reflection spectrum. The cavity dissipation rate can be tuned by solely changing the pin length of antenna 3. The measured data shown in @Zhao2020(b) and (c) correspond, respectively, to the output frequency dips and the linewidth, and are in good agreement with the theoretical analysis.

#emph[Purely quantum effects.] In principle, the corresponding physics such as exceptional point is valid in both classical and quantum systems. To study purely quantum effects in the hybrid system, one may go to the low temperature regime to minimize the detrimental influence of temperature on the quantum superposition and entanglement. The magnon-photon entanglement in the $cal(P T)$ exact regime of hybrid magnon-photon system discussed in @sec_magnon_photon is an example along this route. Along this line, Lu et al. [439] showed that the mechanical mode of a cavity magnomechanical system can be perfectly cooled to the ground state when the system approaches the EP. This may open up a possibility to engineer the purely quantum effects. By delicately designing the gain of cavity mode and loss of the magnon mode into the $cal(P T)$ symmetric regions, one can also generate single-magnon states even in the absence of Kerr nonlinearties [197]. The second approach to manifest the quantum effects is to reduce the size of magnets, such that the quantum fluctuation of spins can not be neglected any longer. Recently, Wu et al. [350] experimentally observed $cal(P T)$ symmetry breaking in a single-spin system. Here the authors studied the $cal(P T)$ symmetric Hamiltonian of the form $hat(cal(H))_s = i r hat(sigma)_z + hat(sigma)_x$ corresponding to $omega_1 = omega_2 = 0 , kappa_1 = kappa_2 = - r , g = 1$ in Eq. #ref(<PT_Ham>, supplement: none), which governs the dynamics of a single electron spin. To generate such an effective Hamiltonian, the electron spin was coupled to a nuclear spin system as shown in @fig:auto33(a), and the dilated Hermitian Hamiltonian $hat(cal(H))_(s , a)$ was delicately designed by shining two selective microwave pulses on the system. Population of the electron spin state $P_0$ was measured at different control parameter $r$, as shown in @fig:auto33(b). When $r < 1$, the system falls into $cal(P T)$ exact phase and real eigenvalues of $hat(cal(H))_s$ determine an oscillating behavior of the population. When $r > 1$, the $cal(P T)$ symmetry as well as the oscillation behavior break down.



// [figvision-cn] imgs/single_spin_PT.png
// (a) 量子电路图，展示构建对称哈密顿量及测量单自旋系统状
// 态演变的实验流程。该图水平分为三个阶段：左侧“State
// preparation”（态制备）、中间“Evolution”（演化）、右侧“
// Readout”（读出）。图中包含两条平行的水平线代表量子比特：
// 上方标记为“el. (system)”的电子系统初始态为|0⟩_e；下方
// 标记为“nucl. (ancilla)”的核辅助比特初始态为|1⟩_n。在态
// 制备阶段，仅核辅助比特线上有两个门操作：先是一个标记为
// Y(θ)的矩形框，紧接着是一个标记为X(π/2)的矩形框。在演化
// 阶段，两条线被一个大的矩形框包围，框内标记为H_{s,a}，
// 表示对称哈密顿量的作用。在读出阶段，核辅助比特线上有一
// 个标记为X(-π/2)的矩形框，随后连接到一个垂直排列文字的
// 矩形框，内容为“Measure populations”（测量布居数）。 (b
// ) 包含四个子图的曲线图集合，展示了在不同控制参数r下，
// 基态布居数P^0随时间变化的实验观测结果与理论预测对比。
// 所有子图横坐标均为Time (μs)，范围从0到8，刻度间隔为2；
// 纵坐标均为P^0，范围从0到1.0，刻度间隔为0.5。每个子图中，
// 红色实线代表理论值（theo.），蓝色带误差棒的点代表实验
// 值（exp.）。左上角子图标题为r = 0，显示P^0呈现明显的周
// 期性振荡，从t=0时的约1.0下降至t≈2 μs时的接近0，再上升
// 至t≈4 μs时的接近1.0，随后再次下降。右上角子图标题为r =
// 0.6，同样显示周期性振荡，但振幅略小且周期略有变化，最
// 小值出现在t≈4.5 μs附近。左下角子图标题为r = 1.0，显示P
// ^0随时间单调缓慢衰减，从约1.0降至t=8 μs时的约0.6，无明
// 显振荡。右下角子图标题为r = 1.4，显示P^0基本保持恒定在
// 约0.9附近，仅有微小波动，几乎无衰减或振荡趋势。
#figure(placement: top, image("imgs/single_spin_PT.png", width: 80.0%),
 caption: [
 (a) Quantum circuit of the experiment to construct $cal("PT")$ symmetric Hamiltonian and to measure the state evolution of a single spin system. $X$ ($Y$) represents the nuclear spin rotation around the $x$ ($y$) axis. (b) Experimental observed evolution of the single spin population in ground state ($P_0$) when the the control parameter $r$ is tuned from $cal("PT")$ exact ($r\<1$) to the $cal("PT")$ broken phase ($r\>1$). The blue dots and red lines denote experimental and theoretical prediction, respectively. Source: The figures are adapted from Ref. [350].
 ]
) <fig:auto33>





= Applications
<sec_application>
In the last few sections, we have reviewed some of the recent developments in quantum magnonics, including the quantum states of magnons and the hybridization of magnons with other quantum platforms, such as microwave photons, superconducting qubits, phonons and electrons. These studies are driven by fundamental interest as well as their promising applications in quantum information science and technologies. Strictly speaking, part of the proposals work in the classical regime as well, such as non-reciprocical wave propagation [490], microwave-light conversion mediated by magnons [491], microwave circulators [492], gradient memories [459], and coherent gate operations [493]. They are, however, expected to work in the quantum regime at low temperature because these applications are mainly based on linear interactions. Some of the proposals for applications, such as quantum memories based on magnons excited in atomic ensembles [202], single-magnon detection by superconducting qubits [198], and weak field sensors for dark matter searches [494] are already in the quantum regime, and require cryogenic conditions to suppress the thermal noise. In this section, we review a few already existing application directions of quantum magnonics, including quantum memories, high-precision sensors for temperature calibration, weak-field detection for dark matter searching, and coherent gate operations for signal processing.


== Memory devices
<memory-devices>






Tanji et al. [202] demonstrated a heralded single-magnon quantum memory for photon polarization states in a resonator containing two types of atomic ensembles as shown in @fig:auto34(a). To store a photon state with arbitrary polarization, i.e. $| phi chevron.r = cos theta | R chevron.r + sin theta e^(i phi.alt) | L chevron.r$, the authors used two spatially overlapping atomic ensembles A and B inside an optical resonator, where each ensemble consists of approximately 8000 atoms cooled to a temperature of $30 mu$K. Here $| L chevron.r$ and $| R chevron.r$ represent left and right circularly polarized photons, respectively. The energy levels of the atomic ensembles are delicately designed such that the A (B) atoms only absorb $R$-polarized ($L$-polarized) photons, and both atomic ensembles emit photons with the same polarization ($pi$). The working procedures of the memory are sketched in @fig:auto34(a). The authors first apply a write pulse that maps the polarization state of photon $| phi chevron.r$ into a superposed magnon state $| Phi chevron.r$ as $ | Phi chevron.r = cos theta | 1 chevron.r_A | 0 chevron.r_B + e^(i phi.alt) sin theta | 0 chevron.r_A | 1 chevron.r_B , $ where $| n chevron.r_nu$ represents the $n$-magnon state of the ensemble $nu$ ($nu = A , B$). With a proper delay, a read pulse (red arrows) is applied to the ensemble to stimulate emission of the $pi$ photons by both atomic ensembles. The successful detection of one photon indicates the mapping of the light polarization state onto a magnon state. In the experiments, the stored photon is recreated with sub-Poissonian statistics [$g_2 ( 0 ) = 0.24$] and efficiency as high as $50 %$. The original photon polarization is restored with fidelity larger than 0.9.

// [figvision-cn] imgs/quantum_memory.png
// (a) 示意图，展示原子系综中的量子态存储与读取过程。图中
// 主体为一个绿色矩形区域，代表原子系综，内部包含大量蓝色
// 小球（表示原子），排列成两排。左侧有一个带负电荷的符号
// “B̅”，位于一个灰色半圆形结构内，可能表示磁场或偏置场。
// 上方有一束绿色箭头标记为“IN α|R⟩ + β|L⟩”，表示输入的光
// 脉冲具有任意偏振态（右旋圆偏振R和左旋圆偏振L的叠加）。
// 该脉冲进入原子系综后，激发产生纠缠磁振子态和一个
// heralding photon（信标光子），后者以绿色波形线形式输出，
// 经过一个黑色探测器图标，再指向一个标有“Storage”的浅蓝
// 色存储器模块。 在图下方有两个放大圆圈：左边圆圈显示两
// 个能级跃迁——从F=3, Mₘ=-2到F'=2（红色向上箭头，标记π(R)）；
// 右边圆圈显示从F=3, Mₘ=+3到F'=2（绿色向下箭头，标记π(L)），
// 并标注了自旋投影值+2和+3。这些细节说明不同偏振光驱动不
// 同的磁子跃迁路径。 底部部分描绘读取过程：一束红色粗箭
// 头标记为“READ”从下方向上照射原子系综，导致原子状态被转
// 换为单光子输出，标记为“OUT α|R⟩ + β|L⟩”，以红色波形线
// 表示。同样有两个放大圆圈：左边显示从F=3, Mₘ=-2到F'=2的
// 跃迁（红色向上箭头，标记π(R)）；右边显示从F=3, Mₘ=+3到
// F'=2的跃迁（绿色向下箭头，标记π(L)），但此时是反向过程，
// 即退激发释放光子。整个图示表明通过写入和读出操作可实现
// 量子态的存储与恢复。 (b) 示意图，展示单个腔体内两个钇
// 铁石榴石（YIG）球体的亮模与暗模磁振子模式。主图为一个
// 黄色长方体腔体，顶部标注“Copper”，内部放置两个橙色小球，
// 标记为“YIG spheres”。腔体高度用虚线标注为h。坐标轴x、y、
// z已标出，其中z轴垂直于纸面。腔体底部两侧各有一个线圈，
// 分别施加磁场偏移ΔH/2和-ΔH/2，外加一个主磁场H₀（蓝色箭
// 头沿x方向）。 右侧分为上下两部分：“Bright”模式下，两个
// YIG球的磁矩同步旋转（同相位），用蓝色弯曲箭头表示，对
// 应集体辐射增强；“Dark”模式下，两个磁矩反相旋转（反相位），
// 不辐射能量。两种模式均标注有角动量量子数h，暗示其与光
// 子耦合特性。此图用于解释系统中存在的对称性破缺导致的模
// 式分裂现象。 (c) 曲线图，横坐标为频率（Frequency），单
// 位GHz，范围7.48至7.56 GHz；纵坐标为反射率（Reflection），
// 单位dB，范围-40至-20 dB。图中包含两条曲线：一条实线（
// 青色）和一条虚线（黑色），分别代表实验测量值和理论拟合
// 值。在约7.52 GHz处出现一个深谷，对应谐振频率，两侧有较
// 宽的平台区。在7.52 GHz附近，两条曲线之间标注了一个水平
// 双向箭头，标记为Δω，表示模式分裂宽度。 左下角嵌入一个
// 小型二维等高线图，横坐标为磁场强度（Magnetic field），
// 单位Oe，范围2.670至2.710 Oe；纵坐标为频率（Freq.），单
// 位GHz，范围7.45至7.60 GHz。颜色条位于右上角，从黑（-30
// dB）到白（-20 dB），表示反射率大小。该子图展示了在不同
// 磁场下的反射谱演化，呈现典型的 avoided crossing 行为，
// 证实强耦合 regime 的存在。 (d) 双面板时间域功率图，横
// 坐标均为时间（Time），单位ns，范围0至300 ns；纵坐标为
// 功率（Power），单位a.u.（任意单位），范围0至6 a.u.。主
// 图中红色填充区域表示输入信号后的响应，蓝色填充区域表示
// 后续 revival peaks（复兴峰）。在t≈100 ns处出现第一个高
// 峰，随后衰减，之后在t≈150–250 ns区间出现多个小峰，标记
// 为“Revival peaks”。一条黑色虚线从左向右下降，标记为“
// Input”，表示输入脉冲包络。 右上角嵌入两个小图：上方小
// 图为“Under-coupling”情况，横坐标时间（0–300 ns），纵坐
// 标频率（7.45–7.60 GHz），彩色热力图显示功率分布，颜色
// 从蓝（低功率）到红（高功率），右侧色标范围0–0.4 a.u.；
// 下方小图为“Critical coupling”情况，相同坐标轴设置，但
// 功率更高，右侧色标范围0–4 a.u.。这两个插图对比了不同耦
// 合强度下系统的动力学行为，critical coupling时信号更强
// 且更集中。整体趋势表明系统在特定条件下可实现高效能量交
// 换与周期性复苏。
#figure(placement: top, image("imgs/quantum_memory.png", width: 100.0%),
 caption: [
 (a) Schematics of an atomic ensemble containing two types of oppositely polarized atoms. (top) A write pulse with arbitrary polarization is fed into the ensemble and generates an entangled magnon state and a heralding photon state. (bottom) A read pulse converts the atomic state into a single photon and is then detected. (b) Magnon bright and dark modes of two YIG spheres in a single cavity. (c) Reflection spectrum of a cavity including 8 YIG spheres and (d) working procedure of the gradient memory in such a hybrid cavity. Source: The figures are adapted from Refs. [459,495].
 ]
) <fig:auto34>

Zhang et al. [459] considered $N$ identical YIG spheres loaded in a microwave cavity. This system is described by the following Hamiltonian $ hat(cal(H)) = omega_c hat(c)^dagger hat(c) + sum_(j = 1)^N (omega_j hat(a)_j^dagger hat(a)_j + g hat(c)^dagger hat(a)_j + g^(*) hat(c) hat(a)_j^dagger) , $ where $hat(c)$ and $hat(a)_j$ are the annihilation operators of photon mode and $j -$th magnon mode, respectively. The magnon frequency of each YIG sphere $omega_i$ is controlled by a small coil underneath and the frequencies are tuned to be evenly distributed as $omega_j = omega_c + [ j - ( N + 1 ) / 2 ] Delta omega_m$, with $Delta omega_m$ the frequency interval. Typically, the frequency spectrum contains $N + 1$ resonant modes with equal spacing $Delta omega_m$, as shown in @fig:auto34(c) with $N = 8$. Among these modes, there are $N - 1$ dark modes of magnons $hat(D)_n$ ($n = 1 , 2 , . . . N - 1$) which are not coupled to the cavity mode, while only one bright mode $hat(B)$ is coupled to the cavity, i.e., $ hat(B) = 1 / sqrt(N) sum_(j = 1)^N hat(a)_j , hat(D)_n = 1 / sqrt(N) sum_(j = 1)^N hat(a)_j e^(2 pi i ( j - frac(N + 1, 2) ) n / N) . $

Since these modes are uniformly distributed in frequency space, the dark modes and bright modes can dynamically convert from one to another in a period of $T = pi / ( N Delta omega )$ with $Delta omega approx Delta omega_m$ for large $N$. The proposed gradient memory including a storing process and a readout process works as follows: In the storing process, a pulsed microwave at frequency $omega_a$ is injected into the cavity and converted into the bright mode of magnons via their coherent coupling. The bright mode temporally transfers into the dark mode, which avoids radiative losses. After one period, the dark mode evolves back to the bright mode and the information coded in magnons is retrieved back by converting to photons. The dynamic output of the memory is found in @fig:auto34(d). To improve the signal of the retrieved pulse, the coaxial probe is tuned to meet the critical coupling condition $kappa_(a , 1) = kappa_(a , 0) + pi g^2 / Delta omega$ (red peak in the figure), where $kappa_(a , 1)$ is the coupling rate of cavity photons to the probe pulse and $kappa_(a , 0)$ is the intrinsic damping rate of the cavity mode. Compared with the proposals of memory based on spin ensembles, this approach takes advantage of the high spin-density and strong magnon-photon coupling in magnetic insulators, and it avoids the issue of inhomogeneous broadening in the dilute spin ensembles.






Sarma et al. proposed to transfer the information from cavity mode to phonon mode in a hybrid cavity-magnet setup with strong magnon-photon-phonon interaction as introduced in Section~#ref(<sec_magnon_phonon>, supplement: none). Due to the lower damping of the phonon mode compared with magnons and photons, the information coded in the phonon mode may stay available for a longer time. Lai et al. [496] studied the indirect coupling of a superconducting flux qubit and a NV center assisted by magnons excited in YIG and proposed a scheme to transfer and store the state of a superconducting qubit to the spin of a NV center with fidelity higher than 0.9 and long storage time of 10 ms. Compared with the direct coupling between the flux qubit and NV center, the magnetic mediator enhances the coupling strength and thus suppresses the decoherence of the qubits. Simon et al. [358] demonstrated that cavity photons can serve as a bus to connect two magnon quantum memories.


== Precision measurements
<precision-measurements>
=== Magnetometers and thermometers
<magnetometers-and-thermometers>







As introduced in @sec_magnon_phonon, Colombano et al. [442] studied the coupling of a breathing microsphere with a magnetic film and demonstrated a magnetometer to detect magnetic fields as low as $mu$T with a peak sensitivity of $upright(n T med H z)^(- 1 / 2)$ up to gigahertz. This finding may be used to build a high-speed sensor of oscillating magnetic fields. The NV center magnetometer is an accomplished application as discussed in @sec_magnon_NV.

Potts et al. [497] proposed a thermometer working below 1 K based on cross-correlation measurements of a hybrid cavity-magnon-phonon system, where the magnon mode is coupled with the phonon mode through magnetostrictive interactions. Specifically, the authors considered the Hamiltonian $ hat(cal(H)) = omega_c hat(c)^dagger hat(c) + omega_b hat(b)^dagger hat(b) + omega_r hat(a)^dagger hat(a) + g_(m c) ( hat(a) + hat(a)^dagger ) ( hat(c) + hat(c)^dagger ) + g_(m b) hat(a)^dagger hat(a) ( hat(b) + hat(b)^dagger ) + i epsilon.alt_d sqrt(kappa_P) ( hat(c) e^(i omega_d t) - hat(c)^dagger e^(i omega_d t) ) $ where $kappa_P$ is the coupling rate of the cavity mode to a single external port. By solving the quantum Langevin equation of this Hamiltonian, the cavity field fluctuations are written in terms of the mechanical displacement ($delta hat(z) equiv delta hat(b) + delta hat(b)^dagger$) $ delta hat(c) = - Lambda_(a m) (g_(c m) G_(m b) chi_m delta hat(z) + i g_(c m) chi_m sqrt(gamma_m) delta hat(eta)_m - sqrt(kappa) hat(xi)_P) , $ where $chi_m$ is the magnetic susceptibility, $gamma_m$ is the magnon dissipation rate, and $delta eta_m$ and $xi_P$ are, respectively, the fluctuation of the magnons and cavity photons. This result implies that the thermal mechanical fluctuations ($delta hat(z)$) are imprinted onto the cavity microwave mode ($delta hat(c)$) through the assistance of the magnon mode ($g_(m c)$). Making use of the input-output relations $delta hat(c)_(o u t) = hat(xi)_P - sqrt(kappa_P) delta hat(c)$, the cavity fluctuations together with the corresponding quadratures $hat(X)_(delta hat(c) , theta) = cos theta hat(X)_(delta hat(c)) + sin theta hat(P)_(delta hat(c))$ can be read out. In particular, they calculated the correlation spectrum of the output fields and found that the biased thermal metric relation of the system is $ frac(S_(pi / 2 , pi / 2) ( omega ), S_(0 , pi / 2) ( omega )) equiv frac(integral_(- oo)^oo d omega' chevron.l {X_(delta c , pi / 2) ( omega ) , X_(delta c , pi / 2) ( omega' )} chevron.r, integral_(- oo)^oo d omega' chevron.l {X_(delta c , 0) ( omega ) , X_(delta c , pi / 2) ( omega' )} chevron.r) = frac(4 coth ( omega / 2 k_B T ), 2 n_(upright(t h)) + 1) . $ This expression is independent of experimental parameters and it directly determines the temperature of the phonons via the measured correlation spectrum. Note that the above-mentioned thermal metric relation increases with phonon temperature and reaches a plateau for $T > ℏ omega_(c , r) / k_B$. Therefore, this proposal is most accurate at low temperatures, typically below 1 K, corresponding to the magnon frequency in GHz regime. Compared with existing proposals using high energy optical photons, microwave photons can reduce heating and thus are compatible with cryogenic temperatures.

// [figvision-cn] imgs/dark_matter.png
// 图(a)为实验装置示意图，展示了利用低温混合腔体-磁体系统
// 探测轴子暗物质的典型设置。图的左上角包含一个图例（Key），
// 定义了五种符号：三角形代表放大器（Amplifier），带波浪
// 线的圆圈代表振荡器（Oscillator），带圆点的圆圈代表隔离
// 器（Isolator），矩形代表衰减器（Attenuator），带叉的圆
// 圈代表混频器（Mixer）。图的主体分为上下两部分。下半部
// 分是一个由虚线框包围的区域，标注有“T≈5K”，表示该区域处
// 于约5开尔文的低温环境。此区域内左侧和右侧各有一个垂直
// 放置的X形结构，底部标注为“Magnet Bore”（磁体孔），两结
// 构之间有一个向上的箭头标注为“B₀”，表示背景磁场方向。在
// 磁体孔中心位置绘制了一个矩形腔体，内部标有“μW Cavity &
// YIG”，其中包含两个竖直的长方形条和一个实心灰色圆点。从
// 该腔体引出一条信号线向上穿过一个三角形符号（标注为AMP1，
// 即第一级放大器），接着经过一个矩形符号（衰减器）和一个
// 带圆点的圆圈符号（SO，隔离器）。上半部分展示了信号处理
// 链路：来自SO的信号进入一个带叉的圆圈（混频器），该混频
// 器的输入端分别标记为“RF”（射频输入）和“LO”（本振输入）。
// LO输入端连接到一个带波浪线的圆圈（振荡器）。混频器的输
// 出端标记为“IF”（中频输出），连接到上方的一个大方框，标
// 注为“VSA”（矢量信号分析仪）。此外，还有一个独立的三角
// 形符号（标注为AMP2，第二级放大器）位于混频器和VSA之间
// 的路径旁，但在主信号链路上未直接串联显示，可能表示备用
// 或并行通道。 图(b)为排除限曲线图（exclusion plot），展
// 示在95%置信水平下对轴子-电子耦合强度（g_aee）与轴子质
// 量（m_a）的约束结果。横坐标为“Axion mass [μeV]”（轴子
// 质量，单位微电子伏特），范围从35到55 μeV，主刻度间隔为
// 5 μeV。纵坐标为“|g_aee|”（轴子-电子耦合强度的绝对值），
// 采用对数刻度，范围从10⁻¹¹到10⁻，主刻度为10⁻¹¹、10⁻¹⁰、
// 10⁻⁹。图中主要数据以蓝色填充区域呈现，形状类似锯齿状或
// 梳齿状，分布在多个质量区间内，具体包括：约42.4–42.6 μ
// eV、42.7–42.9 μeV、以及43.0–43.1 μeV附近。这些蓝色区域
// 的下边界代表当前实验所能排除的最小耦合强度，即在该质量
// 下，若耦合强度高于该边界值则已被排除。图中还包含三个垂
// 直彩色条形标记不同实验的结果：左侧绿色竖条标注“Flowers
// 2019”，覆盖质量约42.4–42.6 μeV；中间蓝色竖条标注“QUAX
// 2019”，覆盖质量约42.6 μeV；右侧橙色竖条标注“QUAX 2018”，
// 覆盖质量约43.1 μeV。此外，图中有一条浅灰色虚线贯穿整个
// 质量范围，标注为“DFSZ axion line is at g_aee/10^11”，
// 表示DFSZ模型预测的轴子-电子耦合强度约为10⁻¹¹量级。顶部
// 有一行文字“Frequency [GHz]”，并对应下方一系列频率数值
// （10.24, 10.26, ..., 10.42 GHz），表明每个质量点对应的
// 探测频率。整体趋势显示，实验在特定质量窗口内设定了严格
// 的耦合上限，尤其在42.5–43.1 μeV范围内排除了高达~10⁻⁹量
// 级的耦合强度，显著优于DFSZ模型预测值。
#figure(placement: top, image("imgs/dark_matter.png", width: 100.0%),
 caption: [
 (a) Typical experimental setup to detect axionic dark matter using a hybrid cavity-magnet system at low temperature. (b) Overview of the exclusion plot at a 95% confidence level of the axion-electron coupling and axion mass. The DFSZ axion line is at $g_(a e e) tilde.equiv 10^(-15)$. Source: The figures are adapted from Refs. [494,498,499].
 ]
) <fig:auto35>


=== Searching for dark matter
<searching-for-dark-matter>


Dark matter is a hypothetical form of matter that plays an important role in modern cosmology. It is believed to make up 85% of the matter of our Universe and 27% of the Universe's total mass-energy density. However, its composition remains a mystery [500]. It is generally believed that the known elementary particles of the Standard Model are not dark matter, and thus one has to extend the standard model. Axions, originally proposed to solve the strong-CP problem in quantum chromodynamics [501,502], are a leading dark-matter candidate. The detection of the axion mass and its coupling with normal matter is challenging. The detection of axions using magnons was originally proposed by Barbieri et al. [503]. Using recent developments from cavity spintronics, it becomes achievable to search for axions using hybrid magnet-light systems because of the sensitivity of the output spectrum of the hybrid system to external small fields [494,498,499,504,505]. Such a hybrid system is called a magnetic axion haloscope.









To understand the working principle of magnetic axion haloscopes, we start from the Hamiltonian $ hat(cal(H)) = omega_c hat(c)^dagger hat(c) + omega_r hat(a)^dagger hat(a) + g ( hat(c)^dagger hat(a) + hat(c) hat(a)^dagger ) + hat(cal(H))_(a e e) . $

<darkham>

where $hat(c)$ and $hat(a)$ denote cavity photon and magnon mode, respectively. Here the first three parts of the Hamiltonian are the familiar form describing the hybridization of magnons with photons, while the last term $hat(cal(H))_(a e e) = - V upright(bold(M)) dot.op upright(bold(B))$ is the coupling between the magnetization $upright(bold(M))$ and the pseudo-magnetic field $upright(bold(B))$ generated by the axions, where $upright(bold(B))$ is proportional to the coupling strength between axion and electron spin $g_(a e e)$ and the mass of axions $m_a$ [498]. Under a HP transformation, the interaction term is quantized as, $hat(cal(H))_(a e e) = - B_(a e e) sqrt(S / 2) sin phi.alt ( hat(a) e^(- i theta) + hat(a)^dagger e^(i theta) )$, where $theta$ and $phi.alt$ parameterize the orientation of the axion field and $B_(a e e) = | upright(bold(B)) |$. By solving the quantum Langevin equation corresponding to Hamiltonian #ref(<darkham>, supplement: none) in the rotating frame, one can derive the cavity field in terms of the axion field as, $hat(c) ( omega ) = i g sqrt(S / 8) B_(a c e) sin phi.alt e^(i theta) / ( kappa_c kappa_m Delta_c Delta_a - g^2 )$, where $kappa_c$ and $kappa_m$ are the dissipation rate of the cavity photons and magnons, respectively, while $Delta_c = ( omega - omega_c ) / kappa_c + i / 2 , Delta_a = ( omega - omega_r ) / kappa_m + i / 2$. Using input-output relations, we solve the output power of the system as $ P_(o u t) ( omega_c ) equiv omega_c chevron.l hat(c)_(o u t)^dagger hat(c)_(o u t) chevron.r = frac(omega_c kappa_c^(e x t) g^2 S B_(a e e)^2 sin^2 phi.alt, 8 | kappa_c kappa_m Delta_c Delta_a - g^2 |^2) , $ where $kappa_c^(e x t)$ is the cavity dissipation caused by the coupling of the cavity field to the probe field. Based on this result, one can detect the existence of an axion field by measuring the output power of the hybrid magnet-cavity system, and, furthermore, obtain information on the axion mass $m_a$ and its coupling strength with the electron spin $g_(a e e)$. Since the axion field is expected to be very weak, it is crucial to increase the sensitivity of the detectors. One can increase the effective coupling strength of spins and photons $g$ by choosing a proper cavity with large magnetic field, and magnetic materials with high spin density, such as YIG. Cryogenic conditions are required to reduce the influence of thermal fluctuations.

A typical experimental setup is shown in @fig:auto35(a) and the comparison of three available experimental results is summarized in @fig:auto35(b). Crescini et al. [499] first set an upper limit on the coupling of axions to electrons at $g_(a e e) < 4.9 times 10^(- 10)$ for a mass of $58 upright(mu e V)$ with $95 %$ confidence. Flower et al. [498] set limits on $g_(a e e) > 3.7 times 10^(- 9)$ for a mass range $33.79 upright(mu e V) < m_a < 33.94 upright(mu e V)$. By further reducing the noise temperature below 1 K and placing 10 YIG spheres to increase the magnetic volume, Crescini et al. [494,506] performed a wide axion-mass scanning and set the coupling limit to $g_(a e e) < 1.7 times 10^(- 11)$ in the mass range $42.4 - 43.1 upright(mu e V)$. Such a sensitivity corresponds to a $1 - sigma$ field sensitivity of $5.5 times 10^(- 19)$ T, which is a record value. Nevertheless, all these results are orders of magnitude away from the theoretical prediction of $g_(a e e) tilde.equiv 10^(- 15)$ predicted by the DFSZ model [507]. Further upscaling of the hybrid system by using high-quality superconducting cavities and by improving the detector sensitivity to single magnon or photon is on going to test this theoretical value. The sensitivity can also be improved by using long-lived nuclear spins as preamplifier [508]. Recently, following a similar principle, cavity-magnets system were proposed to detect gravitational waves [509].

== Gate operation for signal processing
<gate-operation-for-signal-processing>


// [figvision-cn] imgs/logic_gate.png
// 图(a)包含三个部分：顶部为器件结构示意图，底部左侧为频
// 率随磁场变化的曲线图，底部右侧为S11参数随直流电压变化
// 的等值线图。 顶部示意图展示了一个圆柱形铜外壳（未完全
// 画出，仅示意边界），内部中心放置一个黄色的圆柱形介质谐
// 振器（DR）。在DR正下方悬浮着一个红色的球体，标注为YIG
// （钇铁石榴石）。一根细导线环绕YIG球体并引出，标注为
// gate（门控线圈）。DR上方有一个矩形结构，标注为probe（
// 探测环），连接至左侧标有RF的端口。图中建立了三维坐标系，
// x轴水平向右，y轴垂直向下，z轴指向纸面外。背景中有一个
// 带叉的圆圈符号，标注为H，表示外加静磁场方向沿z轴负方向。
// 底部左侧曲线图的纵坐标为Frequency ω/2π (GHz)，范围从
// 8.50到8.54；横坐标为Magnetic field (Oe)，范围从3030到
// 3050。图中显示两条白色曲线在黑色背景上呈现反交叉行为：
// 一条曲线从左下向右上延伸，另一条从左上向右下延伸，两者
// 在约3040 Oe处接近但未接触，形成能级排斥现象。 底部右侧
// 等值线图的纵坐标为Frequency ω/2π (GHz)，范围从8.50到
// 8.53；横坐标为DC Voltage (V)，范围从-4到4。图中用灰度
// 色标表示S11 (dB)的大小，右下角图例显示颜色从深黑（-25
// dB）渐变到浅白（-15 dB）。图像中心有一条水平的亮带，表
// 明在特定频率下S11参数对电压变化不敏感，而在该频率上下
// 区域，S11随电压变化呈现明显的色散特征。 图(b)包含四个
// 子图：左上角为脉冲时序示意图，左下角为频率随磁振子失谐
// 变化的曲线图，右上角为归一化振幅随时间变化的曲线图，右
// 下角为概率随时间变化的数据点与拟合曲线图。 左上角脉冲
// 时序图：横坐标为时间t，无具体数值刻度。包含三条水平线
// 分别代表rf（射频）、dc（直流电压）和h field（磁场）。
// rf线上有一段阴影矩形脉冲；dc线显示电压从-5 V线性上升至
// +5 V，上升过程标注为trise；h field线显示磁场强度先为0，
// 随后跃升至恒定值，并在rf脉冲结束后标记readout时刻。 左
// 下角曲线图：纵坐标为Frequency (GHz)，范围8.50至8.53；
// 横坐标为Magnon detuning (MHz)，范围-20至20。图中有一条
// 蓝色实线和一条红色实线，两线呈双曲线状分离，表现出典型
// 的能级排斥。蓝线上标注了点P1、S1、S2，红线上标注了点P2。
// 右上角曲线图：纵坐标为Norm. amp.（归一化振幅），范围0
// 至1.0；横坐标为trise (ns)，范围0至200。图中包含两组数
// 据：一组是红色圆点连成的下降曲线，标注为LZ transition；
// 另一组是黑色三角点连成的曲线，位于上方，标注为No LZ
// transition。 右下角曲线图：纵坐标为Probability，范围0
// 至1.0；横坐标为trise (ns)，范围0至200。图中绘制了黑色
// 三角形实验数据点，以及一条穿过这些点的黑色实线（标注
// Calculated ratio）和一条虚线（标注Measured ratio），两
// 者高度重合，显示理论计算与测量结果一致。 图(c)包含五个
// 部分：左上角为脉冲时序图，右上角为S11频谱图，中间左侧
// 为布洛赫球示意图及对应的腔反射率曲线，中间右侧为另一个
// 布洛赫球示意图，底部为腔反射率随脉冲宽度变化的曲线图。
// 左上角脉冲时序图：横坐标为时间t。包含rf和dc两条线。rf
// 线上有一个短脉冲；dc线显示电压从-5 V跳变至+5 V，维持一
// 段时间tp后跳回-5 V。在脉冲结束处标记readout。 右上角频
// 谱图：纵坐标为S11 (dB)，范围-25至-15；横坐标为ω/2π (
// GHz)，范围8.51至8.52。图中包含两条曲线：一条黑色实线对
// 应-5 V电压下的共振峰，一条红色实线对应+5 V电压下的共振
// 峰，红色曲线的共振频率略高于黑色曲线。 中间左侧布洛赫
// 球图：球体表面绘有经线和纬线。球心为原点。球面上标有三
// 个态矢量：|α⟩c指向北极附近，|α⟩m指向赤道偏北，|0⟩c指向
// 南极。旁边标注了基矢|α⟩/√2 c和|α⟩/√2 m。 中间右侧布洛
// 赫球图：结构与左侧类似，但态矢量位置不同。|α⟩c指向北极，
// |0⟩c指向南极，|α⟩m指向赤道。 底部曲线图：纵坐标为
// Cavity reflection (a.u.)，范围0.0至0.4；横坐标为tp (ns
// )，范围0至500。图中绘制了两组数据：黑色实心圆点代表
// Measurement（测量值），红色空心圆点代表Calculation（计
// 算值）。曲线在tp约为100 ns处出现第一个极小值，在约300
// ns处出现第二个极小值，整体呈现振荡衰减趋势。
#figure(placement: top, image("imgs/logic_gate.png", width: 100.0%),
 caption: [
 (a) Schematic illustration of the device containing a YIG sphere placed under a cylindrical dielectric resonator inside a copper housing. The gate loop wrapping around the YIG allows for a desirable tuning of the magnon frequency with a DC current. (b) Schematic plot of the pulse sequence to measure Landau-Zener transitions and the measured amplitude of the cavity photon as a function of the rise time $t_(L Z)$ of current pulse. (c) Schematic plot of the pulse sequence for measuring the Rabi oscillation and the comparison of measured (red circles) and calculated (black line) time dependence of the cavity reflection signal. The evolution of the system at 56 ns and 111 ns serves as a $pi \/2$ pulse and $pi$ pulse, respectively. Source: The figures are adapted from Ref. [493].
 ]
) <fig:auto36>

Gate operation is the basic element required for practical signal processing. Xu et al. [493] demonstrated a series of coherent gate operations using hybrid magnet-light systems, including Landau-Zener transitions, Rabi oscillations, Ramsey interference, and mode swap operations. The schematic of the system is shown in @fig:auto36(a), where a YIG sphere is placed underneath the dielectric resonator while a probe antenna is placed on top of the resonator to excite and read out the information coded in the cavity photons. A novel feature of this device is that a gate antenna is wrapped around the YIG sphere, which tunes the magnon frequency dynamically via a DC voltage. This system is described by the known Hamiltonian $hat(cal(H)) = omega_c hat(c)^dagger hat(c) + omega_r hat(a)^dagger hat(a) + g ( hat(c)^dagger hat(a) + hat(c) hat(a)^dagger )$. Here the magnon and photon modes hybridize to form an anticrossing structure [bottom panel of @fig:auto36(a)]. The authors first realized an analogue Landau-Zener transition [510] using the pulse sequence shown in @fig:auto36(b). Starting from an off-resonant condition ($V = - 5$ V), the photon component dominates the upper branch of the eigenstate. When the field is swept slowly to $+ 5$ V, the hybrid state will stay in the upper branch (path $P_1$), while the cavity photons slowly convert to the magnon mode in this sweeping process. On the other hand, when the field is swept fast, the initial state will jump from the upper branch to the lower branch (path $P_2$), while the hybrid state remains in the photon mode. In the intermediate case, these two paths will interfere and the photon has a certain probability to keep its initial state unchanged, i.e., $P_c = exp ( - pi g^2 t_(L Z) / Delta omega_m )$, where $t_(L Z)$ is the rising time of the current pulse and $Delta omega_m$ is the detuning between magnon and photon in the final state. Furthermore, by carefully choosing the pulse length of the dc current, the authors showed that the hybrid system evolves from the initial photon state $| alpha chevron.r_c | 0 chevron.r_a$ to the superposed state $| alpha / sqrt(2) chevron.r_c | alpha / sqrt(2) chevron.r_a$ on a time scale of $pi / 4 g$, which corresponds to a $pi / 2$ rotation of the state on the Bloch sphere, while a pulse length $pi / 2 g$ will transform the state to $| 0 chevron.r_c | alpha chevron.r_a$, which corresponds to a $pi$ rotation on the Bloch sphere, as shown in @fig:auto36(c). Therefore, both $pi / 2$ and $pi$ pulses can be realized in this hybrid system, based on which the authors further demonstrated the design of more complex logic gates, for example, using Ramsey interference. It is expected that these gate operations can be applied to low-temperature quantum measurements.



Skogvoll and coworkers theoretically proposed a method for generating 3-qubit GHZ states [397] required for quantum error correction [398] using a single-shot gate operation involving the qubits and a squeezed magnon. Such states have previously been generated using multiple two-qubit gate operations [511,512] which is slower than that in the single-shot proposal and is limited by qubit decoherence. As introduced in @sec_bistable, bistable and multi-stable states in magnet-cavity systems may be used to design logic gates and memory devices, too.


= Conclusions and Outlook
<sec_outlook>
In conclusion, we have clarified the scope of quantum magnonics and reviewed the recent developments and fruitful applications in the quantum technologies including quantum memories, high-precision sensors and coherent logic gates. These developments have witnessed quantum magnonics as the intersection of spintronics, quantum optics and quantum information, which not only makes the magnonic system a promising platform to study quantum physics, but also significantly extends the horizon of traditional spintronics. Despite great success, the progress of this field is far from saturation. For example, quite a few nonclassical states of magnons and their usefulness in quantum technologies remain to be verified in the lab. Thanks to the interdisciplinary nature of this field, it has already attracted the interests of very diverse communities, from spintronics to quantum optics, from magnonics to continuous variable quantum information, from condensed matter physics to astrophysics, from theorists to experimentalists and engineers. Therefore, we optimistically believe that quantum magnonics will continue its rapid developing pace in the next few decades that it will synergize all fields involved. Below, we give an outlook over the potential directions of this field in the future.


The - #strong[Experimental verification.] experimental realization of nonclassical states of magnons and the technical applications of hybrid "magnon+X" systems have seen considerable advances. However, there remain some nonclassical magnon states that are yet to be realized, for example, single-magnon states caused by nonlinearities and interference effects, Schrödinger cat states, and entangled state of magnons and photons. The utilization of these states for testing basic inequalities in quantum information, as well as their technical applications for quantum computing and quantum communication are open problems. The generation of a spin superfluid state for sustainable spin transport is worth studying to clarify the ongoing debates [37,297]


#strong[Squeezed states.] squeezing of magnons and excitations of magnets in general, present various paths towards interesting phenomena and novel technologies. Some of these stem from nonequilibrium magnon squeezing [219,220,221,337,513] and thus can borrow understanding from quantum optics directly. The path of equilibrium squeezing, however, has a clear niche in magnonic systems and might hold the key to unprecedented phenomena. Hence, theoretical efforts are needed to establish further new protocols that can capitalize on this equilibrium squeezing. The double-edged sword of strong interactions in magnets is that they enable large squeezing but may underlie rapid decoherence. Thus, the role of interactions and dissipation needs to be addressed. This will provide realistic estimates for the stability of quantum information encoded in magnonic systems. On the experimental side, in the short term, existing spectroscopic tools could be developed further towards detecting and confirming the nonclassical features of magnons [303,514,515,516]. For example, the detection of entanglement between different spins will likely require employing external qubit(s). Spin current correlations [103,215,517,518,519,520] offer another path where recent experiments show promise [521,522]. In the longer term, the focus of experiments is expected to shift from detection to exploitation. We hope that ongoing and future theoretical studies will pave the way for many feasible exploitation strategies.


#strong[Magnonic devices for quantum information processing.] Hybrid magnon-phonon systems are promising for precision metrology of temperature, small magnetic fields, and small mechanical displacements. Even though some of the proposals have been realized in the lab, the state-of-art design and test of these devices needs further investigation. It would also be meaningful to push existing proposals, such as microwave transducers and gradient memories, to the quantum limit, and see whether new physics will emerge. Several groups have already reported on the anomalous increase and saturation of magnon damping with decreasing temperature below 1 K [316,523,524]. The authors attributed this phenomenon to the coupling of the magnetic system to an ensemble of two-level atoms, though the physical interpretation of such a bath and its implication for magnetization dynamics remain unclear.

#strong[Classical analogue of quantum phenomena.] Searching for classical analogues of quantum phenomena or macroscopic quantum phenomena in a magnonic system is another ongoing direction. This direction will extend the horizon of magnon spintronics and promote it as a diverse and reliable platform. For example, stimulated Raman adiabatic passage is a population transfer process between two quantum states through the assistance of a third quantum state, which is useful when the direct population transfer between the two states is forbidden [525]. Wang et al. demonstrated a magnonic state transfer between two waveguides with the help of a third waveguide [526]. As another example, Klein tunneling (also known as Klein paradox [527]) is an important phenomenon of relativistic particles in quantum physics, but its experimental verification using fundamental particles is nearly impossible because of the extremely high electric fields required. Recently, Harms et al. [528] showed that this tunneling can be realized in a driven-dissipative magnonic system, where magnon-antimagnon pairs were produced by delicately designing the balance of driving through spin-orbit torque and intrinsic dissipation of magnons. Yet another example is the recent proposal for quantum computation with magnonic BECs [529]


#strong[Noncollinear structures based quantum magnonics.] Until now, most of the existing studies in quantum magnonics focus on magnon excitations in a collinear magnetic structure (either the ferromagnetic state or the antiferromagnetic Néel state). Magnonics based on noncollinear magnetic structures or spin textures including domain walls, skyrmions, vortices, spirals, hopfions, etc. is itself an interesting field, but most of the studies are still in the classical regime [530] while the exploration of their quantum aspects has just began [203,531,532]. It would be interesting to study the nonclassical states of magnons excited in these spin textures and further couple them to other quantum platforms such as qubits and photonic cavities. Recently, magnetic skyrmions have been proposed to serve as a new class of quantum logic qubits [203], where qubit information is encoded in the helicity of skyrmions and a single-magnon sensor is required to read out the qubit states. Liensberger et al. [533] experimentally demonstrated the dispersive coupling between magnons and photons in a chiral magnet with skyrmions, where the coupling rate can be effectively tuned by a magnetic field at the phase boundaries of the skyrmion lattice state. Proskurin et al. [445,534] used the oscillating mode of a pinned domain wall as an effective mechanical subsystem, which mimics the mechanical oscillator from cavity optomechanics. Graf et al. [535] studied the coupling of a magnetic vortex to an optical whispering gallery mode and Martínez-Pérez et al. show theoretically that a single photon can be coupled to a gyrating vortex.




#heading(level: 1, numbering: none)[Declaration of competing interest]
<declaration-of-competing-interest>
 authors declare no competing financial interests that could have appeared to influence the work reported in this paper.

#heading(level: 1, numbering: none)[Acknowledgments]
<acknowledgments>
H.Y.Y acknowledges the European Union's Horizon 2020 research and innovation programme under Marie Skłodowska-Curie Grant Agreement SPINCAT No. 101018193. Y.C. was supported by the National Natural Science Foundation of China (NSFC) (Grant No. 11704060). A.K. acknowledges financial support from the Spanish Ministry for Science and Innovation -- AEI Grant CEX2018-000805-M (through the "Maria de Maeztu" Programme for Units of Excellence in R&D). R.A.D. is member of the D-ITP consortium, a program of the Netherlands Organisation for Scientific Research (NWO) that is funded by the Dutch Ministry of Education, Culture and Science (OCW). R.A.D. has received funding from the European Research Council (ERC) under the European Union's Horizon 2020 research and innovation programme (Grant No. 725509). P.Y. was funded by the NSFC under Grants No. 12074057 and No. 11604041.

#include "refs_body.typ"