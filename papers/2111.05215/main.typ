#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#let ok = text(fill: rgb("#2ea44f"))[✓]
#let no = text(fill: rgb("#cc2222"))[✗]
#let lst(..items) = {
  set list(marker: none, indent: 0em, body-indent: 0.55em)
  set par(justify: false)
  list(..items)
}

#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)

#place(top, float: true, scope: "parent", clearance: 1.2em)[
#align(center)[
  #text(12pt, weight: "bold", [Levitodynamics: Levitation and control of microscopic objects in vacuum])
  #v(1em)
  #text(10.5pt)[C. Gonzalez-Ballestero, M. Aspelmeyer, L. Novotny, R. Quidant, O. Romero-Isart]
]
#v(1em)

#text(9.5pt)[*Abstract.* The control of levitated nano- and micro-objects in vacuum is of considerable interest, capitalizing on the scientific achievements in the fields of atomic physics, control theory and optomechanics. The ability to couple the motion of levitated systems to internal degrees of freedom, as well as to external forces and systems, provides opportunities for science and technology. Attractive research directions, ranging from fundamental quantum physics to commercial sensors, have been unlocked by the many recent experimental achievements, including motional ground-state cooling of an optically levitated nanoparticle. We review the status, challenges and prospects of levitodynamics, the mutidisciplinary research devoted to understanding, controlling, and using levitated nano- and micro-objects in vacuum.]
]


// [figvision-cn] imgs/Figure_Abstract_New.png
// 这是一张展示不同尺度下悬浮技术及其对应科学研究领域的示
// 意图。图像底部是一条水平的时间轴式标尺，标题为“
// Levitation across length scales”（跨越长度尺度的悬浮），
// 背景为从左至右由深红渐变为浅橙红色的箭头条。标尺上标注
// 了三个关键长度量级：左侧为$10^1$m，中间为$10^{-4} - 10
// ^{-7}$m，右侧为$10^{-10}$m。 在标尺上方，从左至右依次
// 排列着三个代表不同物理系统的黑色线条示意图，每个系统下
// 方都对应一个势阱形状的曲线： 最左侧（对应$10^1$m）：绘
// 制了一个黑色的磁悬浮列车侧面剪影，悬浮在轨道之上，位于
// 一个宽大的抛物线形势阱内。 中间（对应$10^{-4} - 10^{-7
// }$m）：绘制了一个蓝色的实心球体，位于一个较窄的抛物线
// 形势阱底部。这代表了微纳尺度的固体颗粒。 最右侧（对应$
// 10^{-10}$m）：绘制了一个原子模型符号（中心圆点周围环绕
// 椭圆轨道），位于一个极小的抛物线形势阱内。 图像的顶部
// 列出了四个主要的科学应用领域，每个领域都有一个蓝色圆形
// 图标和相应的文字说明，并通过蓝色细线与底部的物理系统相
// 连，表示这些领域与特定尺度悬浮技术的关联： Quantum
// Science（量子科学）：位于左上角，图标为一个打开的礼盒
// 中飞出猫头鹰形状（薛定谔的猫）。文字下方括号内注明“(
// macroscopic superpositions, decoherence, etc)”（宏观叠
// 加态、退相干等）。一条蓝线将其连接到中间的蓝色球体系统，
// 另一条蓝线连接到右侧的原子系统。 Material Science（材
// 料科学）：位于量子科学下方，图标为一个分子或晶体结构。
// 文字下方括号内注明“(extreme stress, phase transitions,
// etc)”（极端应力、相变等）。一条蓝线将其连接到中间的蓝
// 色球体系统。 Non-equilibrium physics（非平衡物理学）：
// 位于右上角，图标为一个火焰和一个雪花并列。文字下方括号
// 内注明“(stochastic processes, many-body dynamics, etc)
// ”（随机过程、多体动力学等）。一条蓝线将其连接到中间的
// 蓝色球体系统，另一条蓝线连接到右侧的原子系统。 Sensing
// （传感）：位于非平衡物理学下方，图标为一个声波探测器或
// 传感器。文字下方括号内注明“(short-range forces,
// ultra-weak interactions, etc)”（短程力、超弱相互作用等）。
// 一条蓝线将其连接到中间的蓝色球体系统，另一条蓝线连接到
// 右侧的原子系统。 整体布局表明，位于中间尺度（$10^{-4}
// - 10^{-7}$m）的微纳悬浮系统（蓝色球体）是连接宏观与微
// 观的桥梁，能够同时服务于量子科学、材料科学、非平衡物理
// 学和传感这四个前沿研究领域。
#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [Table #context it.counter.display(it.numbering): #it.body]
}

#figure(image("imgs/Figure_Abstract_New.png", width: 70.0%),
  caption: [
    Controlled levitation of macroscopic- and atomic-scale objects has advanced technology and fundamental science, respectively. Levitodynamics---the levitation and control of microscopic solids in vacuum---targets objects in the intermediate-size regime. This research area provides access to unexplored research directions in quantum science, materials science, nonequilibrium physics, and sensing.
  ],
) <fig-abstract>

= INTRODUCTION
<introduction>
Levitation has been a topic of fascination for centuries. Although it was initially a subject reserved solely for science fiction, it became a reality by means of recent advances in science and technology~@BrandtScience1989. Well-known examples include magnetically levitated trains used for high-speed transportation and magnetically levitated centimeter-sized superconductors used as accelerometers~@GoodkindRSI1999. Further reducing the size of the levitated object enables a previously unattainable degree of control over its dynamics in vacuum. Indeed, in vacuum, the plethora of external (motion, rotation, libration) and internal (e.g., phonons, excitons, magnons, quantum impurities) degrees of freedom of a levitated micro- or nanoparticle can freely evolve or interact with each other in conditions of extreme environmental isolation. High-precision control over these degrees of freedom can be achieved by borrowing and building on techniques developed in atomic physics and biophysics~@arnold1988spectroscopy @ChuPRL1986 @FryeEPJQT2021 @PhillipsRevModPhys1998 @BustamanteNatRevMP2021 @DholakiaNatPhot2011, such as optical tweezers, dynamical control of trapping potentials, and motional cooling.

Levitodynamics---the trapping and control of nano- and micro-objects in vacuum---has established itself as an exciting research field by combining several ingredients from other fields in a single platform. When compared with other levitation platforms, two features stand out: (i) the large mass and density (and hence complexity) of the levitated object, as compared with the mass and density of trapped atoms; (ii) the high degree of control over both conservative dynamics and coupling to the environment, as compared with the degree of control for levitated meter-scale objects. The combination of these two features provides a springboard to many applications and branches of physics. For instance, large masses provide high inertial sensitivities for acceleration sensors. Moreover, the possibility of dynamically tuning both external potentials and dissipation provides a platform to study nonequilibrium physics and thermodynamics. This tunability also enables a top-down approach to quantum physics---namely, to bring a mesoscopic object of billions of atoms from the classical to the quantum regime to address long-standing questions about the nature of quantum mechanics at large scales. The possibilities of levitating particles of any material and of externally accessing their multitude of internal degrees of freedom also enable studies of condensed matter in unexplored regimes (e.g., in the absence of any substrate). Applications range from studying exotic material properties under extreme conditions to answering fundamental questions about the nature of equilibration in de facto isolated complex systems. Levitation also provides new opportunities for established fields---for instance, the study of liquid droplet levitation is useful for model development of aerosol processes in the atmosphere ~@ReichCommPhys2020. In essence, levitodynamics offers the possibility to levitate microscale objects of arbitrary shape and type in high vacuum and to study its motional and rotational dynamics, its internal properties, and the interplay between them.

In this Review, we detail advances in levitodynamics that have brought maturity to the field, as well as research directions currently under exploration. We discuss near-future prospects enabled by the untapped potential of levitodynamics and conclude with an overview of the main challenges that lie ahead.

= ADVANCES
<advances>
Trapping of polarizable objects by means of optical forces was pioneered in the 1970s~@AshkinPRL1970. The subsequent development of optical tweezers revolutionized the field of biophysics~@BustamanteNatRevMP2021, whereas the levitation of microparticles~@AshkinAPL1971 @AshkinAPL1976 and, later, atoms in vacuum set the basis for modern atomic physics~@ChuPRL1986 @PhillipsRevModPhys1998. Building on these advances, several theoretical works in the 2010s proposed applying quantum optical control techniques to levitated objects in vacuum~@RomeroIsartNJP2010 @ChangPNAS2010 @BarkerPRA2010 @RomeroIsartPRA2011b. In this section, we review the advances sparked by the aforementioned works, which established levitodynamics as a vibrant research field.

_Levitation schemes._ The physical mechanisms involved in the levitation of nano- and microparticles are summarized in Box~#link(<box-1-levitation>)[1], and a comparison between different levitation methods is provided in @tab-comparison. Early levitation experiments made use of optical potentials and weakly absorbing dielectric polarizable particles. In the subsequent years, the toolbox expanded to include techniques borrowed from the atom-trapping community. The development of electrostatic and magnetic levitation made it possible to overcome excessive photoheating of the trapped specimen~@MillenNatNano2014 @RahmanSciRep2016 and extended levitation to magnets~@GieselerPRL2020 @VinantePhysRevAppl2020 @TimberlakeAPL2019 @WangPRAppl2019, metals~@SchellACSPhot2017, diamond with quantum emitters~@NeukirchNatPhot2015 @HoangNatComm2016 @ConanglaNanoLett2018 @DelordPRL2018, liquid droplets~@HillPRL2008, graphene flakes~@NagornykhPRB2017, and even superfluid helium droplets~@BrownArxiv2021.

#figure(
  text(size: 7.5pt, table(
    columns: (2.1cm, 1fr, 1fr, 1.35fr),
    align: (left, left, left, left),
    inset: (x: 3pt, y: 2.5pt), stroke: none,
    [], [#align(center)[*Optical*]], [#align(center)[*Electrical*]], [#align(center)[*Magnetic*]],
    table.hline(stroke: 0.9pt),
    [#align(left + top)[*Levitation*]],
    [#lst[
      [#ok High trapping frequencies ($>100$ kHz)],
      [#ok Charged or neutral particles],
      [#ok/#no Large distance from surfaces],
      [#no Laser recoil heating],
      [#no Internal heating due to absorption],
      [#no Limited to ultralow absorption, high-temperature-resistant particles],
    ]],
    [#lst[
      [#ok No internal heating],
      [#ok Applicable to a wide range of charged particles],
      [#ok Large potential depth],
      [#ok On-chip integration],
      [#ok Compatible with optical manipulation],
      [#no Low trapping frequencies ($<10$ kHz)],
      [#no Highly charged particles (sensitive to decoherence)],
      [#no Poor spatial confinement],
    ]],
    [#lst[
      [#ok No internal heating],
      [#ok Potentials created by static fields],
      [#ok Applicable to very large particles],
      [#ok On-chip integration],
      [#ok/#no Advanced cryogenics required for superconducting traps or particles],
      [#no Low trapping frequencies ($<1$ kHz)],
      [#no Dissipation and decoherence mechanisms not fully understood],
    ]],
    table.hline(stroke: 0.5pt),
    [#align(left + top)[*Control*]],
    [#lst[
      [#ok Cooling via active and passive feedback],
      [#ok Potentials can be easily engineered and reconfigured],
      [#ok Control of rotational degrees of freedom],
      [#no Coherent control limited by decoherence due to light scattering],
    ]],
    [#lst[
      [#ok Cooling via active and passive feedback],
      [#ok Simple implementation of cold damping],
      [#ok Particles with internal degrees of freedom (quantum emitters)],
      [#no Proximity to surfaces (sensitive to stray fields)],
    ]],
    [#lst[
      [#ok Cooling via active and passive feedback],
      [#ok Easy access to other degrees of freedom (e.g., magnetization)],
      [#no Static potentials],
    ]],
    table.hline(stroke: 0.5pt),
    [#align(left + top)[*Measurement*]],
    [#lst[
      [#ok Shot-noise-limited measurements],
      [#no Laser recoil heating],
    ]],
    [#lst[
      [#ok No need for bulk optical elements],
      [#no Requires the detection of very weak currents],
    ]],
    [#lst[
      [#ok Sensitive readout with magnetometers (e.g., SQUIDs) or superconducting circuits (cavities, qubits)],
      [#no Low compatibility with optical measurements],
    ]],
    table.hline(stroke: 0.9pt),
  )),
  caption: [Advantages (#ok) and drawbacks (#no) of optical, electrical, and magnetic interactions in terms of levitation, control, and measurement of the particle.],
  kind: table,
  placement: top,
  scope: "parent"
) <tab-comparison>


_Loading in high-vacuum._ Regardless of the trapping mechanism, one of the main challenges for trapping is the controlled loading of a particle into the trap in vacuum. Simple loading techniques such as spraying with a nebulizer rely on gas damping, which requires loading at higher pressures and subsequent pumping to desired vacuum conditions. More refined approaches enable particle loading in high vacuum. These methods make use of particle loading from a charged tip~@DelordPRL2018 or particle launching with piezoelectric transducers~@AshkinAPL1971, electrospray~@NagornykhAPL2015, laser-induced acoustic desorption~@KuhnNanoLett2015 @BykovAPL2019 @FlajvsmanovaSciRep2020, or transfer through a load-lock~@MestresAPL2015 @CalamaiAIPAdv2021.

_Measurement and cooling._ Another key advance has been the implementation of feedback control (cooling; see @fig-control) of levitated particle motion, which is essential for mitigating and controlling the impact of external noise. Freezing the motion of a levitated particle into the quantum ground state sets the stage for macroscopic quantum mechanics and has thus been a major objective in the field of levitodynamics. This quest has been pursued by means of both active- and passive-feedback cooling.

Active-feedback cooling relies on an actual measurement of the particle, the result of which is used to counteract particle motion by means of a control loop~@LiNatPhys2011 @GieselerPRL2012 @HsuSciRep2016 @SlezakNJP2018 @GoldwaterQST2019 @DaniaPRR2021. The efficiency of active feedback relies on three factors: (i) quantum-limited measurement~@JainPRL2016 @KambaPRA2021, (ii) optimal control~@TebbenjohannsPRL2019 @ConanglaPRL2019 @IwasakiPRA2019, and (iii) high detection efficiency~@TebbenjohannsPRA2019. The trade-off between measurement imprecision and measurement backaction is fundamentally constrained by the Heisenberg limit, which sets a lower bound on the performance of active-feedback cooling. Optimization on all three parameters has led to measurement near the Heisenberg limit, observation of motional sideband asymmetry~@TebbenjohannsPRL2020, and demonstration of quantum ground-state cooling for an optically levitated dielectric particle in both room temperature~@MagriniNature2021 and cryogenic~@TebbenjohannsNature2021 environments.

Passive-feedback cooling makes use of the autonomous feedback provided by an optical cavity~@KieselPNAS2013 @MillenPRL2015 @MeyerPRL2019. In the so-called resolved sideband limit, photons in the cavity most effectively counteract, and thereby slow, the motion of the particle by means of radiation pressure~@RomeroIsartNJP2010 @ChangPNAS2010 @BarkerPRA2010 @RomeroIsartPRA2011b. Furthermore, as known from research into cavity cooling of atoms and molecules~@HorakPRL1997 @VuleticPRL2000, laser noise can be minimized if the cavity is populated solely by the photons scattered from the particle (coherent scattering)~@WindeyPRL2019 @DelicPRL2019 @GonzalezBallesteroPRA2019. This configuration led to the first report on ground-state cooling of an optically levitated dielectric particle~@DelicScience2020.

// [figvision-cn] imgs/box_1_Physical_Mechanisms.png
// 这是一张名为“Box 1. Physical mechanisms for levitation
// of nano- and microparticles”的综述性示意图，旨在解释纳
// 米和微粒悬浮的物理机制。该图整体布局分为左侧的文字与公
// 式推导区、中间的物理模型示意图区以及右侧的三种具体悬浮
// 机制说明区。 中间部分展示了一个二维势能曲线图。横轴代
// 表空间位置（未明确标出单位），纵轴代表势能V(R_j)。图中
// 有一条黑色的实线抛物线，开口向上，表示粒子在势阱中的势
// 能分布。抛物线的最低点处放置着一个蓝色的球体，代表处于
// 稳定平衡位置的粒子。在蓝色球体上方有一个弯曲的蓝色箭头，
// 标注为希腊字母Ω，指示粒子在势阱底部进行简谐振荡的运动
// 方向。从抛物线最低点垂直向下引出一个粗大的红色箭头，指
// 向下方文字“Gravity”，表示重力作用方向。在抛物线两侧对
// 称位置各有一条黑色虚线，形状与实线相似但略向外扩展，可
// 能表示某种边界或不同条件下的势能轮廓。 左侧区域包含一
// 段英文文本和一个数学方程组。文本定义了悬浮现象：即自由
// 粒子在无基底情况下稳定悬浮于势能最小值处。接着给出描述
// 粒子沿每个坐标轴j=x,y,z运动的二阶微分方程：R̈_j + γ_j
// Ṙ_j + Ω_j² R_j = -g δ_{jz} + F^{fluct}_j(t)/m。其中各
// 符号含义如下：R_j是质心位置；γ_j是阻尼率；Ω_j是机械频
// 率；g是重力加速度；δ_{jz}是克罗内克δ函数；F^{fluct}_j(
// t)是涨落力；m是粒子质量。下方进一步解释了这些参数的物
// 理意义，并指出稳定悬浮需要势能足以抵消重力且足够深以防
// 止逃逸。最后给出了陷阱深度U_j的表达式：U_j ∝ m Ω_j²
// L_j²，其中L_j是特征陷阱长度尺度。 右侧区域通过三个彩色
// 图标分别介绍三种悬浮机制： 第一个是绿色圆形图标，内含
// 激光束聚焦图案，标题为“Optical trapping”。其下文字说明：
// 由三维光强梯度诱导的偶极力可用于捕获介电粒子。平行于光
// 轴（纵向）和垂直于光轴（横向）的机械频率Ω_t和Ω_ℓ对于亚
// 波长粒子通常在Ω/2π ~ 10–300 kHz范围内。它们与质量无关，
// 并按Ω_t ∝ √P/w²、Ω_ℓ √Pλ/w³缩放，其中P是激光功率，w是
// 焦点处光束腰径，λ是波长。 第二个是黄色闪电图标，标题为
// “Electrical trapping”。文字说明：射频电场阱（又称保罗
// 阱）利用非均匀交流电势（振幅V₀，频率ω）来捕获带电粒子。
// 对于小粒子，机械频率通常在Ω_j/2π ~ 1–10 kHz范围，并按(
// q/m)比例缩放，即Ω_j ∝ (V₀/w) × (q/m)，其中q是电荷量。
// 第三个是蓝色磁铁图标，标题为“Magnetic trapping”。文字
// 说明：许多方法可绕过厄恩肖定理实现无需外时变场的磁性粒
// 子稳定悬浮。例如，抗磁悬浮（典型频率Ω_j/2π ~ 0.1–1 kHz）
// 适用于永磁体（如钕铁硼型或II型超导体），通过迈斯纳效应
// 和磁通钉扎实现。抗磁性也允许对顺磁（包括超导[179]）粒
// 子进行磁-重力和四极子悬浮。旋转与磁化之间的耦合（如爱
// 因斯坦-德哈斯效应[187]）理论上可实现旋转或量子自旋稳定
// 的悬浮磁体[188–189]。 整张图无比例尺、无坐标轴数值刻度、
// 无图例框，所有信息均以文字和示意图形呈现。颜色使用具有
// 象征意义：蓝色代表粒子与振荡运动，红色代表重力，绿色代
// 表光学，黄色代表电场，蓝色代表磁场。所有公式均为标准
// LaTeX格式书写，变量用斜体，常数用正体。
#figure(image("imgs/box_1_Physical_Mechanisms.png"), kind: "box", supplement: [Box], placement: top, scope: "parent") <box-1-levitation>

_Motional and rotational control._ One of the main advantages of levitation is that the particles are free to move when presented with external influences, allowing for precise control of their external degrees of freedom (motion, rotation). Control of conservative particle motion is achieved via engineering of the trapping potential. On the one hand, complex static potentials can be synthesized using optical trapping beams with desired intensity profiles~@RicciNatComm2017 @AritaJOSAB2017 @ZhouLasPhotRev2017 @RondinNatNano2017 or by following a hybrid approach (i.e., combining optical and electric fields that act on charged dielectric particles)~@MillenPRL2015 @FonsecaPRL2016 @ConanglaNanoLetters2020. On the other hand, potentials can also be dynamically modified, either externally~@NeukirchNatPhot2015 @RashidPRL2016 @HebestreitPRL2018 @BykovAPL2019 -- including fast control of a complex optical potential~@CiampiniArxiv2021 -- or by the backaction induced by the particle itself on the trapping field~@KuhnOptica2017 @NeumeierNJP2015. Furthermore, the equilibrium position of a levitated particle can be controlled with high precision, enabling its positioning and translation with nanometer-scale accuracy. Such control has been implemented with moving single-beam traps~@MestresAPL2015 @DelicQST2020 @CalamaiAIPAdv2021, standing-wave traps~@VcivzmarAPL2005 @BrzobohatyNatPhot2013 @GrassAPL2016, and electric Paul traps~@OstermayrRSI2018.

Precise control has also been achieved over the rotational degrees of freedom of levitated particles. On the one hand, tuning the polarization direction of linearly polarized light on an optical trap allows external control of the equilibrium angular orientation of an anisotropic particle~@KuhnOptica2017 @PerdriatArxiv2021 @SchellACSPhot2017. On the other hand, using circularly polarized light, particles of different materials and shapes can be set into sustained rotation in a controlled fashion~@NagornykhPRB2017 @KuhnNanoLett2015 @KuhnOptica2017 @AritaNatComm2013 @MonteiroPRA2018 @KuhnNatComm2017 @RashidPRL2018 @HoangPRL2016. Record spinning velocities in the gigahertz range have been reported for nanodumbbells~@ReimannPRL2018 @AhnPRL2018 @AhnNatNano2020 and are limited only by particle disintegration when the elastic tensile limit is reached. Furthermore, rotational degrees of freedom can be cooled~@DelordNature2020, even simultaneously with the translational motion~@BangPRR2020 @VanDerLaanArxiv2020 @SchaeferPRL2021. Enhanced understanding of rotational noise~@SticklerPRL2018, especially noise induced by particle motion~@VanDerLaanPRA2020, has made it possible to reach the shot-noise limit, defined by radiation pressure torque~@VanDerLaanArxiv2020. This paves the way for bringing rotational degrees of freedom to the quantum regime.

// [figvision-cn] imgs/Figure_control.png
// 该图像是一幅中心辐射状布局的示意图，标题为“Control in
// levitodynamics”（悬浮动力学中的控制），位于图像正中央。
// 中心是一个蓝色的圆形图标，内部包含一个白色的电源开关符
// 号。从该中心圆向外延伸出六条浅蓝色直线，分别连接六个不
// 同的功能模块区域，每个区域展示一种控制手段及其物理原理。
// 左侧第一个分支指向标有“Internal & rotational degrees
// of freedom”（内部与转动自由度）的区域。该区域并列展示
// 三个蓝色球体模型：最左侧球体沿垂直轴被压缩成扁椭球形，
// 两侧有红色双向箭头表示形变；中间球体保持球形，周围环绕
// 红色环形箭头表示自旋运动；右侧球体呈细长椭球形并倾斜，
// 其长轴方向由虚线标示，顶部有水平双向红色箭头表示取向变
// 化。这三个模型共同说明可通过外部场调控粒子的内部振动模
// 式和空间旋转状态。 左下方第二个分支指向标有“
// Conservative vs dissipative dynamics”（保守与耗散动力
// 学）的区域。上方有一条从左至右渐变的橙红色粗箭头，标注
// “Pressure”（气压），指示气压升高方向。下方并列两个势阱
// 图：左侧图中，蓝色小球位于黑色抛物线势阱底部，周围分布
// 多个灰色小圆圈代表气体分子，粒子附近有两个短小的红色双
// 向箭头表示微弱热运动；右侧图中，同样结构但气体分子数量
// 显著增多且更密集地包围粒子，粒子周围的红色双向箭头更长，
// 表示更强的随机碰撞导致的能量耗散。此对比说明通过调节环
// 境气压可切换系统从保守振荡到强阻尼耗散的动力学行为。
// 左上角第三个分支指向标有“Dynamic manipulation of
// potentials”（势能的动态操控）的区域。图中绘制两条曲线：
// 一条实线黑色抛物线代表静态势阱，另一条虚线灰色抛物线代
// 表经调制后的势阱形状，两者开口大小不同。一个蓝色小球位
// 于实线势阱底部，旁边有一个红色弯曲箭头指向虚线势阱位置，
// 示意势能面随时间演化导致粒子轨迹改变。这表明可通过实时
// 调整外加场参数来动态重塑囚禁势的几何形态。 右上角第四
// 个分支指向标有“Active and passive feedback”（主动与被
// 动反馈）的区域。分为左右两部分：左侧部分显示一个蓝色小
// 球在黑色抛物线势阱中运动，其位置标记为x(t)，下方施加一
// 个向左的红色箭头力F_cool(t)，右侧有一个半圆形探测器接
// 收信号，构成闭环反馈冷却回路；右侧部分显示同一势阱中的
// 小球，其运动轨迹用模糊的粉红色阴影带表示，两侧各有一个
// 灰色矩形板，暗示存在非接触式感应或反射机制实现被动稳定。
// 整体表达利用测量-反馈或固有耦合机制抑制粒子热涨落。 右
// 侧第五个分支指向标有“Hybrid potentials”（混合势）的区
// 域。图中展示一个平面基板，上面安装两个红色U型磁铁，产
// 生磁场梯度；同时有一根绿色螺旋线圈缠绕穿过基板，通以交
// 流电（由±符号和波浪线表示）。一个蓝色小球悬浮于两磁极
// 之间，受磁场与电场共同作用。蓝色箭头描绘粒子在复合场中
// 的复杂轨迹，表明多种物理相互作用（如磁偶极、介电泳等）
// 可协同构建新型势阱构型。 右下角第六个分支指向标有“
// Coupling to other systems / sympathetic cooling”（与其
// 他系统耦合/共冷）的区域。图中一个大蓝色球体位于黑色抛
// 物线势阱底部，其内部嵌入一个小粉色球体，象征主粒子携带
// 辅助子系统。左侧有三个独立的小粉色球体，各自带有绿色螺
// 旋箭头指向大球体，表示它们作为“制冷剂”通过碰撞或共振交
// 换能量将热量带走。整个场景体现通过引入额外自由度或辅助
// 粒子实现目标系统的间接冷却或量子态制备。 所有子图均为
// 手绘风格示意图，无真实数据坐标轴，颜色用于区分物理实体
// （蓝=主粒子，红=力/运动方向，绿=电磁场/冷却剂，灰=环境
// 介质），线条粗细与虚实表示主次关系或时变特性。全图旨在
// 可视化悬浮微粒系统中可用的多维度控制策略，涵盖从单自由
// 度调节到多物理场集成、从开环驱动到闭环反馈、从孤立系统
// 到开放耦合的全谱系技术手段。
#figure(image("imgs/Figure_control.png"),
  caption: [
    Control in levitodynamics. The control toolbox of levitodynamics makes it possible to tailor every degree of freedom of a levitated particle in multiple ways. Both the conservative dynamics and the dissipation of motional, rotational, and internal (e.g., acoustic) degrees of freedom can be tailored via dynamic manipulation of potentials and modification of gas pressure, respectively. They can also be cooled and parametrically driven via both active and passive feedback. Additional control can be achieved through hybrid traps and coupling to external systems, which also provide controlled nonlinearity. $F_"cool"(t)$, cooling force.
  ],
  placement: top,
  scope: "parent"
) <fig-control>

_Coupling to external systems._ Experiments focused on coupling a levitated particle to external systems have been driven by the goals of (i) preventing photodamage in absorptive particles and (ii) exploiting nonlinear interactions (e.g., via coupling to a two-level system). Two prominent cases are levitated magnets coupled to other magnetic systems and diamond particles that contain color centers. Diamagnetically levitated magnets generate a position-dependent magnetic field that has been read out with both a superconducting quantum interference device (SQUID), which offers high sensitivity and minimal power dissipation at cryogenic temperatures~@VinantePhysRevAppl2020 @PratCampsPRAppl2017, and a single electronic spin in a nitrogen-vacancy color center (NV center) embedded in a nearby diamond slab~@GieselerPRL2020. NV centers can also be embedded in a levitated nanodiamond~@ConanglaNanoLett2018, thereby equipping the particle with an internal energy-level structure. These quantum emitters can be optically manipulated and coherently controlled~@HoangNatComm2016 @DelordPRL2018, even at the single-electron level~@NeukirchNatPhot2015 @SchellACSPhot2017. Moreover, in the presence of a magnetic field gradient, electronic spins couple to the motion and rotation of the particle, as the Zeeman splitting of the electronic levels depends on the position and orientation of the particle. This spin-mechanical coupling in an ensemble of electronic spins has been used to control the orientation of a levitated diamond~@PerdriatArxiv2021, exert a torque~@PelletArxiv2021, and cool its librational motion via optical polarization~@DelordNature2020. Hosting quantum emitters in a levitated particle also provides a local probe for its internal dynamics.

_Stochastic thermodynamics._ The advances outlined above have enabled controlled levitation of micro- and nanosolids in high vacuum, advancing the use of levitodynamics in the pursuit of several research directions. The first example is the study of single-particle stochastic thermodynamics. Levitated particles provide a convenient platform for this goal, as motional and rotational degrees of freedom can be controlled, and their coupling to the environment can be tuned by many orders of magnitude. This tuning, a distinctive feature of levitation, can be performed by controlling gas pressure or by engineering artificial reservoirs (e.g., using an optical cavity)~@DechantPRL2015. The controllable isolation makes it possible to study equilibration~@MillenNatNano2014 or underdamped Brownian motion both in the linear~@LiScience2010 and nonlinear~@GieselerPRL2014 regimes. As a specific example, the tunability of the damping rate facilitates exploration of thermally activated transitions between two potential minima separated by a barrier~@RondinNatNano2017 @RicciNatComm2017. It has been shown that the transition probability is maximized at intermediate damping rates, a phenomenon predicted by Kramers in 1940. Dynamical modulation of trapping potentials is also a powerful tool. Specifically, it provides a means to study the equilibration from nonequilibrium initial states, enabling tests of fundamental fluctuation theorems~@GieselerNatNano2014 @HoangPRL2018, and to implement shortcuts to adiabaticity for heat engine cycles~@GieselerEntropy2018. Along with feedback control, this technique also enables assessment of fluctuations under nonequilibrium thermal driving~@RademacherArxiv2021 and of a generalized second law in non-Markovian information thermodynamics~@DebiossacNatComm2020. The combination of dynamical potential modulation and tunable dissipation provides a window into the thermodynamics of small systems, where fluctuations are relevant. The many open questions pertaining to this regime are explored, for example, by devising microscopic levitated heat engines~@LiScience2010 @GieselerEntropy2018 that can operate near the Curzon-Ahlborn efficiency bound~@DechantPRL2015 @DechantEPL2017. In this realm, another quantum system, such as an optical cavity, enables gradual substitution of the thermal reservoir to experimentally study the extension of the concepts of classical stochastic thermodynamics into the quantum regime~@AgarwalPRE2013.

_Interrogation of materials._ Another feature of levitated nano- and microparticles is the ability to control and investigate mesoscopic solids composed of billions of atoms in conditions of extreme isolation. Important applications are measurement and reduction of a particle's internal temperature. This is relevant for preventing particle loss at low pressures, reducing blackbody decoherence for fundamental tests of quantum mechanics, or reducing decoherence of embedded color centers for use in quantum transduction. One way to measure the internal temperature of optically levitated particles is via the mechanical frequency shift induced by a temperature-dependent refractive index~@HebestreitPRA2018. Another way is to use the fluorescence of embedded quantum emitters~@HoangNatComm2016 @DelordAPL2017, which also allows for internal refrigeration of the particle~@RahmanNatPhot2017. Additionally, surface temperature can be estimated by tracking particle motion in the background gas~@MillenNatNano2014.

// [figvision-cn] imgs/box_2_Sensing.png
// 该图像为标题“Box 2. Sensing”的科学综述插图，整体布局分
// 为左侧三个垂直排列的信号检测示意图区域和右侧包含公式推
// 导与定量分析图表的区域。 子图 a（左上角区域）： 类型：
// 振荡信号检测的复合示意图与频谱图。 布局：上方展示一个
// 紫色球体悬浮在黑色倒U型势阱中，受到绿色螺旋状箭头表示
// 的力作用，旁边标注希腊字母ω。右侧对应的时间-信号图显示
// 横轴为Time t，纵轴为Signal，曲线为绿色的正弦波。下方是
// 功率谱密度图，横轴为Frequency，纵轴为Power spectral
// density。图中蓝色填充曲线呈现两个峰，分别位于频率ω和Ωj
// 处，其中Ωj处的峰值显著高于背景噪声。 物理含义：说明通
// 过监测位置功率谱密度中的额外峰值来检测外部振荡力F cos(
// ωt)。 子图 b（左中区域）： 类型：恒定信号检测的相空间
// 演化示意图。 布局：左侧展示时间-信号图，横轴Time t，纵
// 轴Signal，信号为恒定的绿色条带。中间展示概率分布图，横
// 轴Position，纵轴Probability distribution，显示两个高斯
// 分布峰，分别对应初始状态和最终状态。下方展示粒子在势阱
// 中的运动过程，标记为1)、2)、3)。步骤1)粒子在势阱底部；
// 步骤2)势阱消失，粒子自由膨胀；步骤3)势阱恢复，粒子被捕
// 获。 物理含义：说明通过让粒子动力学演化并分析最终相空
// 间概率分布的位移来测量恒定外力。 子图 c（左下区域）：
// 类型：脉冲信号检测的能量-时间示意图。 布局：上方展示势
// 阱中的紫色球体，下方有一个向上的灰色箭头表示能量注入。
// 右侧展示两个图表。第一个是时间-信号图，横轴Time t，纵
// 轴Signal，显示一个单峰的绿色脉冲波形。第二个是时间-机
// 械能图，横轴Time t，纵轴Motional energy，显示能量从低
// 水平跃升至高水平并保持的方波形式。 物理含义：说明通过
// 监测粒子能量（即振荡幅度）的变化来测量脉冲信号。 子图
// d（右上角区域）： 类型：数学公式推导文本区。 内容：包
// 含两个主要公式。第一个公式计算最小可探测振幅F_min，涉
// 及玻尔兹曼常数k_b、温度T、阻尼率γ_j和质量m以及积分时间
// t_m。第二个公式计算最小可探测加速度a_min，同样依赖于上
// 述参数。文本解释了热平衡下的灵敏度限制及动量冷却的作用。
// 子图 e（右下角区域）： 类型：双Y轴对数坐标曲线图。 坐
// 标轴：横轴为Radius (nm)，范围从10^1到10^5。左侧纵轴为
// F_min (N)，范围从10^-21到10^-18。右侧纵轴为a_min，范围
// 从10^-6到1。顶部还有一个辅助横轴Mass (kg)，范围从10^
// -19到10^-11。 曲线与色标：红色曲线对应左侧纵轴F_min，
// 随半径增加呈下降趋势。蓝色曲线对应右侧纵轴a_min，随半
// 径增加呈上升趋势。两条线在半径约10^3 nm处相交。 标注文
// 字：图中注明条件为SiO_2粒子，气压10^-8 mbar，温度T=
// 300K，积分时间t_m=1s。底部文字指出当T趋于0时，测量受量
// 子反冲限制。
#figure(image("imgs/box_2_Sensing.png"), kind: "box", supplement: [Box], placement: top, scope: "parent") <box-2-sensing>

A related research direction is the study of matter in controlled conditions (i.e., without the perturbing effects of any substrate). The absence of clamping allows particles to be rotated at frequencies that exceed 1 GHz~@ReimannPRL2018 @AhnPRL2018 @MonteiroPRA2018, which, for particles of $100$-nm radius, results in surface velocities of $600$ m/s and centrifugal accelerations of $4 times 10^11 g$ (where g is Earth's gravitational acceleration). The extreme surface forces and material stresses provide information about material susceptibilities, their modification as a result of large centrifugal stress~@NagornykhPRB2017, and tensile failure~@SchuckSciAdv2018. The absence of a substrate has received particular attention in the study of liquid particle (droplet) physics, which is important for modeling a wide range of systems, from atomic nuclei to black holes~@HillPRL2008. Moreover, at low temperatures, levitation of liquid helium droplets provides insight into superfluid physics~@ChildressPRA2017 -- e.g., into the complex interplay between fast droplet rotation and the formation of superfluid vortices. In this scenario, by providing controlled and stable trapping, levitation offers a definite advantage over current methods based on x-ray diffraction of liquid helium jets~@LangbehnPRL2018.

_Sensing._ Levitated particles also excel as force sensors (Box~#link(<box-2-sensing>)[2]). Their three-dimensional (3D) motion and rotation allows for independent sensing of forces and torques along three dimensions (6D sensing) with shot-noise-limited sensitivity. Moreover, their large motional amplitude provides a much larger dynamic range than that afforded by clamped resonators. In addition, the spectral response of levitated sensors can be largely tuned by potential engineering, thus modifying their oscillation frequencies. Force sensitivities in the sub-femtonewton regime have been demonstrated~@MoorePRL2014 @RanjitPRA2016 @HempstonAPL2017 @LiNatPhys2011 @GieselerNatPhys2013 @GieselerPRL2012 @RiderPRL2016. The high force sensitivity can be exploited for the sensing of different fields. For example, if the levitated particle carries a charge, it responds to electric fields and thus constitutes an electric field sensor~@MoorePRL2014 @FrimmerPRA2017 @RanjitPRA2016 @SlezakNJP2018 @RicciNanoLett2019. Likewise, if the particle carries a magnetic moment it responds to magnetic fields and acts as a magnetic field sensor~@KimballPRL2016 @HoangPRL2016. Furthermore, the high mass of a levitated particle (as opposed to, e.g., a trapped atom) makes it a natural sensor for gravitational and inertial forces, including acceleration and rotation (gyroscopes)~@MonteiroPRA2017 @HebestreitPRL2018 @RiderPRA2018 @TimberlakeAPL2019 @MonteiroPRA2020. Anisotropic particles, such as rods, dumbbells, or other particles composed of anisotropic materials, can be set into rotation and used for torque sensing with sensitivities exceeding $10^(-27) "N m Hz"^(-1/2)$~@AhnNatNano2020 @HoangPRL2016 @RashidPRL2018 @AhnPRL2018 @VanDerLaanPRA2020. In addition, a polarizable particle also responds to optical forces, such as radiation pressure, which can be measured with photon-recoil-limited precision~@JainPRL2016. Finally, the lack of a clamping mechanism allows levitated particles to be released from their trap and recaptured at a later time and different location. This feature opens up the possibility of measuring forces "in the dark" (e.g., the gravitational force in a free-fall experiment~@HebestreitPRL2018). Aside from sensing, this protocol is of interest for quantum matter-wave interferometry with massive, solid-state particles~@RomeroIsartPRL2011 @RomeroIsartPRA2011 @KaltenbaekExpAstronom2012 @BatemanNatCom2014 @GeraciPRD2015 @WanPRL2016 @PinoQST2018.

= FUTURE RESEARCH DIRECTIONS
<future-research-directions>
The potential of levitodynamics is largely untapped. However, enabled by the aforementioned advances, a large variety of research directions and applications will become attainable in the near future. We classify these directions in three broad, interconnected areas: (i) sensing and metrology, from commercial navigation sensors to searches for new physics such as dark matter; (ii) novel quantum physics, e.g., generation of macroscopic quantum superpositions; and (iii) physics of complex systems, from nonequilibrium physics to materials engineering.

_Integrated sensors._ On the applied side, levitation-based sensing may find uses in areas ranging from seismometry to inertial navigation systems. Development of commercial sensors, however, will require integration of trapping, control, and readout on a single platform to reduce noise and achieve long-term stability. The prospect of compact and robust integrated sensors motivates the ongoing effort toward on-chip levitodynamics. Controlled levitation near structured surfaces, a key first step, has already been achieved in ambient conditions and low vacuum. Dielectric nanoparticles have been levitated in planar Paul traps~@AldaApplPhysLett2016, near dielectric photonic structures~@MagriniOptica2018 and metasurfaces~@ShenArxiv2021, and near ultrathin membranes~@DiehlPRA2018. Levitation of magnetic particles near the surface of superconductors~@PratCampsPRAppl2017, which has applications in high-sensitivity magnetometry~@KimballPRL2016, has also been reported~@GieselerPRL2020 @VinantePhysRevAppl2020 @TimberlakeAPL2019 @WangPRAppl2019. Current efforts focus on reducing particle-surface separations, increasing vacuum conditions, and using the same nearby surfaces or structures for particle control and readout~@KuhnApplPhysLett2017 @WinstonePRA2018. On this front, particles have already been levitated at subwavelength distances from surfaces~@MagriniOptica2018 @MontoyaArxiv2021, even in high vacuum with the aid of feedback cooling~@DiehlPRA2018. Moreover, exploitation of the strong mode confinement of a photonic crystal cavity has enabled enhanced readout of the particle dynamics~@MagriniOptica2018. Controlling and mitigating the still poorly understood surface-induced noise, also known as anomalous heating in the trapped-ion community~@BrownuttRMP2015, remains a major challenge for on-chip levitodynamics.

_Rotation-based sensing and metrology._ Owing to their complex dynamics, the rotational degrees of freedom of a levitated particle can be exploited in many areas of sensing and metrology. Fast-rotating nanorotors can act as local magnetic fields~@KimballPRL2016 or pressure sensors~@KuhnNatComm2017. Moreover, the frequency of optically levitated nanorotors can be locked to external clocks and tuned across a wide frequency range. The frequency stability of these nanorotors~@VanDerLaanPRA2020 is limited only by clock stability, even at room temperature~@KuhnNatComm2017. This will enable their use as frequency standards for metrology. Finally, rotation can be used for sensing fundamental forces. Fast-rotating nanorotors have been proposed as torsion balances for measuring processes such as Casimir torques or vacuum friction~@AhnPRL2018 @AhnNatNano2020 @ManjavacasPRA2010 @ZhaoPRL2012. Measuring such electromagnetic dispersion forces could elucidate the mechanisms behind surface-induced heating, opening the door for compact levitation platforms. Furthermore, controlled rotation will facilitate cancellation of limiting noise in fundamental sensing experiments, such as the measurement of Newton's gravitational constant~@WestphalNature2021 or the search for exotic particles beyond the standard model~@MoorePRL2014. A major challenge for rotational sensing and metrology is to reach the fundamental sensitivity limit imposed by the quantization of angular momentum and associated radiation torque shot noise~@VanDerLaanArxiv2020.

// [figvision-cn] imgs/Figure_Quantum.png
// 该图是一幅综合示意图，展示了通过量子悬浮动力学（
// Quantum levitodynamics）进入量子领域的研究路径。图像中
// 央有一个宽大的浅蓝色箭头从左向右延伸，箭头上写有白色文
// 字“Toward the quantum regime”（迈向量子领域）。箭头左
// 侧连接着四个标有序号的阶段性里程碑，右侧发散出三个应用
// 方向。 子图 1：基态冷却 (Ground-state cooling) 位于左
// 上角。这是一个势能曲线图。横轴代表位置，纵轴代表能量。
// 图中有一条黑色的向上开口的抛物线，表示谐振子势阱。在势
// 阱底部上方，画有一个红色的钟形曲线，标注为“∝ √(k_B T)”，
// 代表热运动振幅随温度变化的包络线。一个灰色的粗箭头从红
// 色曲线指向势阱底部。在势阱最低点，画有一个蓝色的窄峰高
// 斯分布曲线，标注为“~ x_zpm”，代表零点运动振幅。该图展
// 示了将粒子的热运动振幅从宏观的热涨落（红色区域）降低到
// 微观的量子零点涨落（蓝色区域）的过程。 子图 2：非经典
// 态 (Non-classical states) 位于左下角。包含两个部分。上
// 半部分是一个威格纳函数 W(x, p) 的二维色度图。横轴标记
// 为 x，纵轴标记为 p。中心是一个红蓝相间的同心圆图案，红
// 色核心向外过渡到蓝色环带。右侧有一个垂直的颜色条，范围
// 从 <0 到 >0，颜色从深蓝渐变到深红，中间为白色/浅色，表
// 示威格纳函数的负值区域（量子特性的标志）。下半部分是在
// 同样的黑色抛物线势阱中展示的两个波函数概率密度分布。最
// 底部的虚线对应 n=0 能级，画有一个单峰的蓝色曲线；其上
// 方的虚线对应 n=1 能级，画有一个双峰的蓝色曲线（类似薛
// 定谔猫态或叠加态的空间分布）。 子图 3：运动纠缠 (
// Motional entanglement) 位于中上部。展示了两个独立的黑
// 色抛物线势阱。每个势阱底部各有一个蓝色的球体，代表悬浮
// 粒子。两个球体之间由一串红色的离散点云连接，形成一条波
// 浪状的轨迹，形象地表示两个粒子的运动状态发生了量子纠缠，
// 即它们的位置或动量存在强关联。 子图 4：大尺度量子离域
// 化 (Large quantum delocalization) 位于中下部。展示了一
// 个较大的黑色抛物线势阱。势阱底部有一个半透明的、体积巨
// 大的红色球体，旁边标注了“~ Radius”，表示粒子的空间扩展
// 范围很大。在这个红色球体的中心，有一个极小的蓝色尖峰，
// 标注为“~ x_zpm”。这表明尽管粒子的物理尺寸（半径）很大，
// 但其量子波包的相干性仍然被限制在极小的零点运动范围内，
// 或者反过来理解，大质量物体实现了显著的量子离域化。 右
// 侧分支展示了三个主要的应用前景： 第一个分支（右上）：
// 量子多粒子系统 (Quantum many-particle systems) 描绘了
// 一个晶格结构，由多个黑色抛物线势阱排列组成，每个势阱中
// 有一个蓝色粒子。粒子之间有虚线连接，表示相互作用。此外，
// 还有红色的曲线和箭头在粒子间穿梭，暗示粒子之间的量子交
// 换或隧穿过程。 第二个分支（右中）：宏观量子叠加态 (
// Macroscopic quantum superpositions) 展示了两个相同的三
// 维网格状势阱面，上面各有一个蓝色粒子。这两个态之间用一
// 个加号 "+" 连接，并用狄拉克符号 |...> + |...> 的形式表
// 示，意指系统处于两个不同空间位置的宏观叠加态（例如，粒
// 子同时存在于两个不同的势阱中）。 第三个分支（右下）：
// 量子计量学 (Quantum metrology) 包含两部分。左侧是一个
// 威格纳函数图，坐标轴为 x 和 p，显示为一个沿 x 轴极度压
// 缩、沿 p 轴拉长的椭圆状分布（压缩态），用于提高测量精
// 度。右侧展示了利用这种量子态进行测量的过程：一个蓝色粒
// 子受到红色波浪线（代表外部信号或场）的作用，随后分裂成
// 两个分开的蓝色团簇，示意通过量子态的演化来探测微弱信号。
#figure(image("imgs/Figure_Quantum.png"),
  caption: [
    Quantum levitodynamics. Levitated particles in the quantum regime open new research directions in fundamental quantum mechanics, quantum sensing, and many-particle physics, among other areas. Reaching this regime is a challenging effort that must be undertaken sequentially. Some milestones along the way are (1) ground-state cooling, which reduces the thermal motional amplitude to the zero-point motion $x_"zpm"$ ($k_B$, Boltzmann constant); (2) generation of nonclassical motional states at length scales $tilde(x)_"zpm"$ (e.g., Fock states); (3) demonstration of entanglement between the motional degrees of freedom of two levitated particles; and (4) delocalization of the particle wave function to an extension orders of magnitude larger than the zero-point motion, comparable to its size.
  ],
  placement: top,
  scope: "parent"
) <fig-quantum>

_New physics._ The possibility of bringing particles to the quantum regime provides a novel sensing platform for fundamental science. Specifically, the substantial degree of isolation and control required to reach the quantum regime yields laboratory-scale experiments that are extremely sensitive to forces or phenomena that couple to mass. A first possible use is the search for new physics beyond the standard model of particle physics. As an alternative approach to colliders pushing the energy frontier, these compact levitodynamics experiments push the sensitivity frontier~@MooreQST2021. They can exploit (i) the high isolation and mass density of levitated particles and (ii) levitation near structured surfaces~@DiehlPRA2018 to detect tiny deviations arising from high-energy physics at short distances~@GeraciPRL2010. This will enable tests of short-distance corrections to Coulomb's law to exclude dark matter models in the hidden sector, as well as searches for fundamental non-neutrality of matter~@AfekPRD2021. Experiments along this route have already been performed using optically levitated microparticles~@MoorePRL2014. Moreover, these experiments will allow researchers to test potential corrections to Newton's gravitational law at the unexplored micrometer and submicrometer scale~@GeraciPRL2010 @KawasakiRevSciInstrum2020 @BlakemoreArxiv2021, an order of magnitude beyond the 50-$mu$m scale where strong constraints to deviations have been reported~@LeePRL2020. A second related prospect for these sensitive experiments is the detection of astrophysical signals, including high-frequency gravitational waves~@AggarwalArXiv2020 and signatures of dark matter and dark energy~@MoorePRL2014 @BatemanSciRep2015 @RiderPRL2016 @MonteiroPRL2020 @CarneyQSciRep2021. Finally, levitated particles could shed light on the quantum nature of gravity by entangling two levitated massive objects via their mutual gravitational interaction~@MarlettoPRL2017 @BosePRL2017. As discussed below, exploring all of these research directions requires devising advanced techniques to suppress quantum decoherence.

_Quantum sensing and transduction._ Bringing a levitated particle to the quantum regime also enables a variety of genuine quantum applications (@fig-quantum), such as quantum-enhanced sensing. These applications require cooling of the particle to the quantum regime, as well as the ability to coherently couple its motion to other quantum systems---that is, to establish a coherent coupling at a rate higher than the decoherence rate of both the particle and the external quantum system. Although such strong coupling has been demonstrated with dielectric particles coupled to an optical cavity~@DeLosRiosNatComm2021, establishing coherent coupling to other quantum systems remains to be achieved. Two-level systems are particularly relevant for current research, owing to their large intrinsic nonlinearity~@MartinetzNPJQI2020. As in clamped quantum nanomechanical systems, coherent coupling to such nonlinear systems will enable the preparation of levitated particles in non-Gaussian quantum states -- that is, states characterized by a phase-space quasi-probability density with negative values. These states can be used to unequivocally certify the quantum nature of the particle's motional state and to identify decoherence sources, to which they are extremely sensitive. Moreover, coherent coupling to an ensemble of entangled two-level quantum systems will improve the displacement readout of levitated particles, with potential uses in inertial or -- in the case of levitated magnets -- magnetic quantum sensing. More specific to levitodynamics are applications in which an interface with internal solid-state quantum excitations, such as acoustic phonons, could be established. Theoretical proposals~@GonzalezBallesteroPRL2020 indicate that, owing to their nearly perfect isolation, these long-lived quantum excitations could be used, for instance, as quantum memories or quantum transducers.

_Macroscopic quantum superpositions._ One of the most appealing features of quantum physics is the ability to prepare macroscopic superpositions, in which an object behaves as if it were in two locations at once, separated by a distance comparable to or larger than its size. Experimental confirmations started as early as 1927, using electrons, and have today reached the size of organic molecules that contain thousands of atoms~@FeinNaturePhysics2019. Levitodynamics will enable the preparation of macroscopic quantum superpositions of nanoparticles that contain billions of atoms and, in principle, far beyond. These superpositions will enable quantum matter-wave interferometry with mesoscopic particles~@RomeroIsartPRL2011 @RomeroIsartPRA2011 @KaltenbaekExpAstronom2012 @BatemanNatCom2014 @SticklerNJP2018 and will corroborate the quantum superposition principle in a hitherto inaccessible parameter regime where collapse models predict the breakdown of quantum mechanics~@RomeroIsartPRA2011 @BassiRMP2013. Moreover, they will serve as ultraprecise sensors able to detect tiny signals~@SticklerNJP2018 @GeraciPRD2015 and will thus promote enhanced understanding and testing of theoretical models of environmental decoherence. This is made possible by the extreme sensitivity of these superpositions to decoherence. Finally, superpositions will open the door for exploring the interplay between quantum mechanics and gravity -- for example, by elucidating the gravitational field generated by a massive object in a macroscopic quantum superposition state~@Cecile2011ChapelConference.

Macroscopic quantum superpositions require sufficiently pure states that are coherently delocalized over large scales. These conditions could be achieved by ground-state motional cooling, followed by large-scale expansion of the wave function through dynamical control of the trapping potential~@PinoQST2018 @RomeroIsartNJP2017 @WeissPRL2021 (@fig-quantum). This expansion increases the spatial extent of the wave function by several orders of magnitude, from the zero-point motion in the ground state (typically around $10^(-12)$ m) to, ideally, a size comparable to that of the particle itself ($10^(-7)$ m). Several theoretical works have proposed and analyzed these ideas and have determined the requirements to prevent the detrimental action of decoherence from the environment~@RomeroIsartPRL2011 @RomeroIsartPRA2011 @KaltenbaekExpAstronom2012 @BatemanNatCom2014 @WanPRL2016. After the achievement of motional ground-state cooling~@DelicScience2020 @MagriniNature2021 @TebbenjohannsNature2021, the next steps consist of reaching the low decoherence level required for unitary expansion of the wave function and devising detection schemes to certify the successful preparation of a macroscopic superposition~@WeissPRR2019.

_Non-equilibrium physics._ Levitated particles offer a distinctive channel to probe and engineer complex systems across multiple scales. These encompass arrays of levitated particles for many-body physics, single particles for motional quantum heat engines, and solid-state physics inside a single particle. At the largest scale, ensembles of levitated particles can be used to explore many-body physics as done with atomic ensembles, with the addition of rotational degrees of freedom, rich internal solid-state structure, tunable coupling to the environment, and gravitational interactions, among others. On the one hand, ensembles of nanoparticles levitated in a single wide and deep trap will enable the exploration of nonequilibrium self-assembly, liquid crystal phases, and the transitions between them~@DholakiaRMP2010 @LechnerPRL2013. Conversely, arrays of physically separated particles with tunable interactions can be tailored by multiplexing several traps into an array~@BurnhamOptExp2006. In these systems, the ability to tune the dissipation enables exploration of the transition between closed and open systems. This may contribute to previous studies~@GringScience2012 of elusive phenomena, such as prethermalization~@LiuAQT2020, and tests of long-standing hypotheses, such as the eigenstate thermalization hypothesis.

At the single-particle level, levitodynamics has turned out to be an excellent approach to implement far-from-equilibrium processes and understand irreversibility, similar to the complementary and long-established approach of colloids in liquids. This will certainly not be limited to optical approaches in the future. With the first demonstrations of levitated systems in the quantum regime, new ground can be explored at the interface of classical, information, and quantum thermodynamics. Focusing on the refinement of levitated microheat engines as a paradigmatic example, the rapid control enabled (e.g., by all-optical approaches) theoretically designed optimal protocols~@DechantEPL2017 to become a reality. Generally, substituting the thermal environment by engineered (quantum) reservoirs~@MillenNJP2016 -- e.g., via cavity optomechanical methods~@WollmannScience2015 @PirkkalainenPRL2015 @LecocqPRX2015 -- opens the door for investigating extended schemes with nonthermal or nonclassical baths, making it possible to bypass the Carnot efficiency limit~@RossnagelPRL2014 @KlaersPRX2017. More importantly, these engineered reservoirs will enable researchers to understand and minimize entropy production in the finite time domain, which is paramount, in engines and elsewhere, to optimize efficiency and minimize wasted energy. In the quantum domain, coherence, entanglement, and measurement backaction, which are now starting to become observable in optical levitodynamics, will play key roles in engine design and performance, addressing open questions in quantum thermodynamics~@TalknerPRE2016 @GieselerEntropy2018. By helping researchers to understand these concepts and providing flexible possibilities for spatiotemporal design, levitodynamics may inspire an entirely new generation of classical and quantum nanoscale mechanical engines.

_Material science._ A defining advantage of levitated particles is their high internal complexity as a mesoscopic solid-state system. The ability to investigate and control this isolated solid will open new avenues for materials science. Specifically, the absence of surrounding gas and substrate will enable precise measurements of physi- and chemisorption rates in unusually clean environments~@RicciArxiv2021. Moreover, the enhanced control provided by levitation can be exploited for the growth of novel crystalline heterostructures~@KanePRB2010. In the field of droplet levitation~@KriegerChemSocRev2012, the control techniques developed in levitodynamics will make it possible to scale down current experiments with microdroplets to the nanoscale. The preparation of nanodroplets with different chemical composition, viscosity, refractive index, and surface tension will facilitate the study of processes such as phase transitions, coagulation, and photochemical reactions, among others, as a function of external stimuli. In the future, levitodynamics could provide a nanolab for engineering the material properties of levitated nanoobjects.

_Condensed matter physics._ Levitodynamics also enables researchers to study previously unexplored regimes of condensed matter where solid-state excitations (e.g., phonons, electrons, magnons) exist in extreme isolation and confinement~@RubioLopezPRB2018. Acoustic phonons have received the most attention, owing to their ubiquity and highest-recorded quality factor. This provides acoustic modes with extremely long coherence times but also makes them difficult to probe experimentally. Future detection will be possible by means of Brillouin scattering or, in rapidly rotating spheres, by the change in polarizability stemming from centrifugal elastic deformation~@HummerPRB2018. In optical traps, this deformation would additionally give rise to a complex dynamical coupling between rotation, motion, and acoustic field, which could shed light on the motional decoherence induced by internal vibrations. Once detection schemes become available, acoustic phonons will represent a powerful resource. According to theoretical works, a tunable and strong coupling between acoustic phonons and the particle motion can be engineered by using mediating degrees of freedom (e.g., magnons in levitated magnets)~@GonzalezBallesteroPRB2020. This could enable the use of internal acoustic resonances for motional cooling without the need for external feedback, or for engineering internal and external states via motional control~@GonzalezBallesteroPRL2020, such as squeezed magnonic, acoustic, or motional states. Because the novel properties of acoustic phonons stem entirely from confinement and isolation, similar exotic properties can be expected for any other condensed matter excitations (e.g., semiconductor excitons in levitated quantum dots or supercurrents in levitated superconducting particles)~@RomeroIsartPRL2012. Despite the potential of levitated particles, both for fundamental solid-state science and as tools to control external dynamics, their internal physics remains largely unexplored.

= OPEN CHALLENGES
<open-challenges>
The prospects outlined above have established levitodynamics as a vibrant research field. However, several challenges must be addressed before such research directions can be fully explored.

_On-chip levitodynamics._ The implementation of levitation-based sensing platforms faces three substantial obstacles. The first one concerns the development of chip-scale levitation systems operating in high isolation. On-chip integration is key to interface levitodynamics with other existing technologies, to increase platform robustness, and to devise autonomous and portable sensors. Despite achievements in this direction, the transition from current bulky proof-of-principle experiments to compact on-chip platforms remains challenging. On the technical side, it requires the engineering of optical, magnetic, and electric fields, or combinations of them, at the chip surface to create microscale traps. These traps must include on-chip feedback-control schemes to stabilize traps in ultrahigh vacuum and/or reduce the ring-down time of trapped high-quality factor oscillators. Developing an autonomous integrated platform will also require miniaturization of key surrounding components, from vacuum equipment to cryogenic setup. On the fundamental side, particles in microscale traps experience surface-induced forces and decoherence, which are relevant at short particle-surface separations. These short-range interactions affect the trapping potential, and the dynamics they induce depend on the internal degrees of freedom of the trapped object and their properties (e.g., temperature, internal equilibration times). Because these degrees of freedom can be largely out of equilibrium, the forces may differ from typical predictions on the basis of quasi-equilibrium assumptions~@RubioLopezPRB2018. Second, in analogy to anomalous heating in trapped ions~@BrownuttRMP2015, surface-induced dissipative forces create additional heating. These forces can have multiple origins, such as Johnson noise or patch potentials in Paul traps~@BrownuttRMP2015 @TellerPRL2021 or eddy currents or hysteresis losses for magnets trapped above superconductors~@PratCampsPRAppl2017 @VinantePhysRevAppl2020 @GieselerPRL2020. In most cases, these mechanisms are not well understood for levitated particles. To implement on-chip levitation in high vacuum, future research must focus on developing a fundamental understanding of surface-induced forces and implementing strategies to mitigate them.

// [figvision-cn] imgs/box_3_Noise_v2.png
// 该图是一个名为“Box 3. Noise and decoherence”的综合说明
// 框，包含左侧的文本列表、右上方的示意图和左下方的曲线图。
// 左上方文本部分列出了悬浮动力学（levitodynamics）中噪声
// 的主要来源，包括：与周围气体分子的碰撞；导致光子反冲加
// 热的激光散射；热电磁辐射的发射、吸收和散射；由振动或杂
// 散场引起的阱中心噪声；由产生势阱的电磁场波动引起的阱频
// 率噪声（例如光镊中的激光强度噪声）；以及由粒子与其他热
// 自由度（如正交方向的运动、旋转或内部激发，例如声子）之
// 间的交叉耦合引起的噪声。 右上方是一幅示意图，展示了一
// 个蓝色球体（代表被捕获的粒子）位于一个黑色U形曲线（代
// 表势阱）的底部。图中用带箭头的波浪线和箭头标示了各种噪
// 声源对粒子的影响： 来自左上方的红色波浪线箭头指向粒子，
// 标注为“Black body radiation”（黑体辐射）。 来自左下方
// 的绿色波浪线箭头指向粒子，标注为“Field fluctuations”（
// 场涨落）。 从粒子顶部向上指出的黑色箭头，旁边画有两个
// 小圆圈，标注为“Gas molecules”（气体分子），表示气体碰
// 撞。 从粒子右侧指向外部的紫色双向弯曲箭头，标注为“
// Coupling to other degrees of freedom”（与其他自由度的
// 耦合）。 从粒子右下方指向内部的灰色粗箭头，标注为“
// Unknown sources”（未知来源）。 左下方是一张二维曲线图。
// 纵坐标轴标签为“Motional energy”（运动能量），横坐标轴
// 标签为“Time t”（时间t）。图中包含两条线： 一条橙色实线：
// 从原点(0,0)开始，初始阶段近似线性增长，随后增长率逐渐
// 减小并最终趋于一个水平渐近值。这条线代表了粒子运动能量
// 随时间的实际演化过程。 一条棕色虚线：从原点出发，沿直
// 线向上延伸，其斜率对应于橙色实线的初始增长段。该虚线旁
// 标注有数学符号“∝ γⱼt”，表明在初始阶段，运动能量与阻尼
// 系数γⱼ和时间t成正比。 该子图传达的趋势是：被捕获粒子的
// 能量最初随时间线性增长，直到最终与环境达到热平衡（
// thermalizes）。 图的右下部分包含文字解释和两个公式。文
// 字指出，这些噪声源通常表现为阻尼力和涨落力，对于白热噪
// 声，它们通过涨落-耗散定理相关联。第一个公式给出了阻尼
// 系数γⱼ的表达式：γⱼ = (π / m k_B T) Sⱼ(Ωⱼ)。第二个公式
// 定义了涨落力的功率谱密度Sⱼ(ω)，它是一个关于时间τ的积分，
// 涉及涨落力Fⱼ^fluct(t)的相关函数。最后的总结段落指出，
// 在量子 regime 下，所有这些噪声源都会通过向环境提供关于
// 粒子位置的信息，从而导致运动量子态的退相干。
#figure(image("imgs/box_3_Noise_v2.png", width: 66.0%), kind: "box", supplement: [Box], placement: top, scope: "parent") <box-3-noise>

_Sensor performance._ The second challenge ahead for levitation-based sensors is to establish their true sensing potential. Most studies are at the proof-of-concept level and focus on the minimum detectable signal, commonly referred to as sensitivity. However, for industrial and field applications, other attributes -- such as robustness, reliability, and stability -- are more important. The stability of an instrument is characterized by the Allan minimum, corresponding to the signal integration time that yields the lowest variance~@HebestreitRSI2018. Undesired effects, such as laser pointing noise~@MonteiroPRA2017, eddy currents in magnetic levitation~@TimberlakeAPL2019, or technical noise~@MonteiroPRA2020, limit the stability of levitated sensors. Stability against long-term drifts is especially critical for low-frequency signal detection using high-quality factor levitated sensors. Technical noise is a particular obstacle for torque sensing with fast nanorotors because it linearly increases with rotational frequency and makes shot-noise-limited operation difficult~@VanDerLaanPRA2020. Other challenges include calibration uncertainties (e.g., particle mass)~@HebestreitRSI2018 @RicciNanoLett2019 @BlakemorePRAppl2019 @ZhengPRL2020 and the temperature dependence of system parameters (e.g., index of refraction of particle). Although some of these noise sources can be suppressed by differential measurements, the potential of levitation-based sensors for commercial applications requires thorough evaluation and optimization procedures.

_Enhancing sensitivity._ The third important challenge pertains to boosting the sensitivity of levitation-based sensors, especially for uses in fundamental science (e.g., detection of weak forces or of quantum features). A fundamental sensitivity limit is reached when all thermal and technical noise sources are eliminated and the measurement becomes shot-noise limited. State estimation based on Kalman filtering~@WieczorekPRL2015 @MagriniNature2021 in combination with quantum control can be used to compensate for drifts and stabilize operation. Stretching the measurement precision beyond the standard quantum limit will require implementation of quantum-enhanced sensing protocols (e.g., squeezed states of light and/or motion). In the future, completely new sensing strategies will open up once it is possible to harness the "wave properties" of levitated particles and to capitalize on progress achieved in the field of matter-wave interferometry.

_Decoherence._ Levitated objects are macroscopic and thus very sensitive to quantum decoherence (Box~#link(<box-3-noise>)[3]). To perform quantum experiments, strategies to mitigate or circumvent such decoherence must be developed. Decoherence due to collisions with molecules of the surrounding gas can be suppressed by operating in ultrahigh vacuum, such that the probability to scatter a single gas molecule in each experimental run becomes negligible. The use of laser light also generates motional decoherence in two ways: by direct scattering of photons and by raising the internal energy of the particle through absorption, thereby increasing the emission rate and frequency of the thermal electromagnetic field radiated by the particle. In both cases, the photons (scattered and thermally emitted, respectively) carry away information about the center-of-mass position and orientation of the particle, thus generating decoherence. Controlling levitated particles without light does not necessarily reduce decoherence, as it requires either highly charged particles, which are more sensitive to stray electric fields, or magnetic or superconducting particles levitated using magnetic fields, which typically need on-chip schemes that are prone to surface-induced decoherence. The decoherence challenge is amplified as soon as the extension of the particle wave function grows, a required step toward exploration of macroscopic quantum physics. In addition, adding nonlinearities to the quantum motional control toolbox of a levitated particle, as required for exploration of non-Gaussian physics, typically involves either strong coupling to a two-level quantum system or the use of strongly nonharmonic potentials. In both cases, a levitated particle must be placed in a region of large field gradients, which unavoidably require the proximity of the particle to other materials and are hence accompanied by surface-induced decoherence. To tackle these challenges, quantum experiments with levitated particles, and particularly those exploring macroscopic quantum physics, will have to involve fast experimental runs and minimal use of laser light while avoiding large surfaces and time-dependent electromagnetic fields. A deeper understanding of decoherence in levitodynamics, attainable by the progress of experiments and theory, will most likely lead to innovative ideas for controlling levitated particles in the quantum regime.

_Repeatability._ In addition to minimizing decoherence, quantum experiments must be robust and repeatable. A quantum tomography protocol involves (i) preparation of the initial state, (ii) state evolution, and (iii) measurement of the final state. This sequence must be repeated many times, with the same particle and under identical conditions, to extract the underlying quantum statistics. Because protocols likely involve sequences of free fall and changes in trapping potential, it is difficult to retrap the particle and bring it back to its initial state. Optimal control protocols, methods for low-noise measurements and filtering, and ultrafast data acquisition and processing techniques will thus be needed.

_Scalability._ Scaling up the size and number of levitated particles (to enhance inertial sensitivities or to study many-particle physics, respectively) also poses several challenges. The more massive the particle, the more difficult it is to levitate in a high-frequency trap, the stronger its coupling to the environment, and the smaller its zero-point motion. This introduces additional noise and hinders motional ground-state cooling and all related applications (e.g., metrology of impulses or transient signals, tests of quantum mechanics)~@MonteiroPRA2020. Levitating several particles is also challenging, owing to the difficulty of simultaneously multiplexing different traps~@CurtisOptComm2002 and controlling the resulting interactions between the particles contained in them (e.g., coupling that stems from optical binding~@AritaOptical2018). Once these complex traps are engineered, practical questions, such as those pertaining to controlled loading of several particles and the cooling required for applications, will have to be addressed. A step ahead in terms of complexity are hybrid multiplexed traps, which would enable levitation of particles of different sizes and types (e.g., dielectric, charged, magnetic, superconducting) for exploring, e.g., multispecies statistical mechanics, including complex (magnetic, electrostatic) interactions, or reconfigurable levitated particle lattices to model solid-state physics. Developing such hybrid multiplexed traps will likely require a combined effort toward hybrid trap design and on-chip integration.

= OUTLOOK
<outlook>
Levitodynamics brings together appealing features from different fields -- examples include levitation techniques from atomic physics and biosciences, control techniques from atomic and molecular optics, the richness of solid-state physics, and the potential to couple motion to various degrees of freedom and/or external systems. It is the combination of all of these properties in a single platform that brings forth unique opportunities for science and technology. The path toward attractive research directions, from commercial sensing devices to fundamental quantum physics, has been unlocked by the many recent experimental achievements. Exploring the multiple future prospects for science and technology is a multidisciplinary endeavor, which will establish levitated objects in high vacuum as highly controllable nanolabs for use in areas as diverse as nonequilibrium physics, condensed matter physics, particle physics, and the foundations of quantum mechanics.

#text(fill: white)[#cite(<RusconiPRB2016>), #cite(<RusconiPRL2017>), #cite(<RusconiPRB2017>)]

#heading(numbering: none)[Acknowledgments]
<acknowledgments>
The authors acknowledge the valuable feedback from colleagues all over the world and thank C. Dellago in particular for suggesting the term "levitodynamics."

*Funding:* This work has received funding from the Q-Xtreme project of the European Research Council under the European Union's Horizon 2020 research and innovation program (grant agreement 951234). *Competing interests:* None declared.

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "ieee", title: none)