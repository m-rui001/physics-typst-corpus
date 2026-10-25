#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("TeX Gyre Termes", "Libertinus Serif"), size: 9.963pt, lang: "en", hyphenate: true, top-edge: "bounds", bottom-edge: "bounds")
#set page(numbering: "1", paper: "a4", margin: (left: 4.40cm, right: 4.47cm, top: 4.47cm, bottom: 4.16cm), footer-descent: 12.5pt)
#set heading(numbering: "1.1")
#show heading.where(level: 1): set block(above: 16pt, below: 7pt)
#show heading.where(level: 2): set block(above: 16pt, below: 7pt)
#show heading.where(level: 3): set block(above: 14pt, below: 6.5pt)
#set par(justify: true, leading: 0.30em, first-line-indent: (amount: 1.5em, all: true), spacing: 0.30em)
#set figure.caption(position: bottom)
#set figure.caption(separator: [ | ])
#show figure.caption: set text(size: 9pt)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set block(above: 10pt, below: 10pt)
#set math.equation(numbering: "(1)", supplement: none)
#show link: it => text(fill: rgb("#007cc1"), it)
#show ref: it => text(fill: rgb("#007cc1"), it)
#show cite: it => text(fill: rgb("#007cc1"), it)
#show outline.entry.where(level: 1): it => block(above: 13.2pt, text(weight: "bold", it))


#align(center)[
  #text(17pt, weight: "bold", [Active Turbulence])   #v(1.2em)
  #text(10.5pt)[Ricard Alert#footnote(numbering: (n) => "*")[ricard.alert\@princeton.edu]#super("1,2"), Jaume Casademunt#footnote(numbering: (n) => "†")[jaume.casademunt\@ub.edu]#super("3,4"), and Jean-François Joanny#footnote(numbering: (n) => "‡")[jean-francois.joanny\@college-de-france.fr]#super("5,6")]
  #v(0.6em)
  #text(9pt)[
    1 Princeton Center for Theoretical Science, Princeton University, Princeton, NJ (USA)\
    2 Lewis-Sigler Institute for Integrative Genomics, Princeton University, Princeton, NJ (USA)\
    3 Departament de Física de la Matèria Condensada, Universitat de Barcelona, Barcelona (Spain)\
    4 Universitat de Barcelona Institute of Complex Systems (UBICS), Barcelona (Spain)\
    5 Collège de France, Paris (France)\
    6 Laboratoire PhysicoChimie Curie, Institut Curie, PSL University, Sorbonne Universités, UPMC, Paris (France)
  ]
  #v(0.8em)
  #text(10pt)[April 7, 2021]
  #v(0.6em)
  #text(11pt)[*Abstract*]
]

#v(0.6em)





Active fluids exhibit spontaneous flows with complex spatiotemporal structure, which have been observed in bacterial suspensions, sperm cells, cytoskeletal suspensions, self-propelled colloids, and cell tissues. Despite occurring in the absence of inertia, chaotic active flows are reminiscent of inertial turbulence, and hence they are known as #emph[active turbulence]. Here, we survey the field, providing a unified perspective over different classes of active turbulence. To this end, we divide our review in sections for systems with either polar or nematic order, and with or without momentum conservation (wet/dry). Comparing to inertial turbulence, we highlight the emergence of power-law scaling with either universal or non-universal exponents. We also contrast scenarios for the transition from steady to chaotic flows, and we discuss the absence of energy cascades. We link this feature to both the existence of intrinsic length scales and the self-organized nature of energy injection in active turbulence, which are fundamental differences with inertial turbulence. We close by outlining the emerging picture, remaining challenges, and future directions.





#pagebreak()
#heading(level: 1, numbering: none, outlined: true, bookmarked: false)[Contents]
#v(14.8pt)
#show outline: set text(top-edge: "cap-height", bottom-edge: "descender")
#show outline.entry: set par(leading: 0.32em)
#outline(title: none, depth: 3, indent: level => if level == 2 { 1.5em } else if level == 3 { 3.8em } else { 0em })
#v(6pt)

= Introduction
<intro>


Turbulence is a ubiquitous phenomenon. It takes place in systems ranging from stars and interstellar gas clouds to the atmosphere and the oceans, and down to the scales of our daily activities such as breathing, cooking, and driving. Turbulence is central in many scientific problems such as mixing processes and drag reduction, and also in engineering applications. In physics, turbulence is at the crossroads of fluid dynamics and statistical physics, challenging us to grasp their deep connections @Frisch1995 @Rose1978 @Falkovich2006.


Inertial turbulence is controlled by the Reynolds number, which embodies the ratio between inertial and viscous forces. At high Reynolds number, inertial effects destabilize laminar flow and lead to the chaotic patterns of vortices and jets that we know as turbulence. In a simplified picture of fully-developed inertial turbulence, the external driving injects kinetic energy at a certain scale, at which viscous dissipation is negligible. Due to inertial effects, this energy is then transported across scales through a so-called energy cascade, until it is dissipated by viscous effects at a very different scale. In the intermediate scales, known as the inertial range, the flow exhibits self-similarity, and velocity correlations are scale-invariant --- a property that is usually studied via the energy spectrum of the flow. In seminal work in 1941, Kolmogorov predicted that the energy spectrum follows a power law as a function of wave number, $E ( q ) tilde q^(- 5 / 3)$, with a universal exponent independent of both the external driving and the fluid's properties. This picture of turbulence, involving the emergence of universal statistical properties of the flow from the combination of driving and nonlinearity, has become a paradigm of non-equilibrium physics @Kolmogorov1991 @Frisch1995 @Rose1978 @Kraichnan1980 @Falkovich2006 @Boffetta2012.


Two decades ago, seemingly chaotic, multiscale flows were discovered in polymer solutions at low Reynolds numbers, for which inertial effects are negligible. In this case, nonlinear elastic effects due to the polymer destabilize the laminar flow and lead to so-called #emph[elastic turbulence] @Groisman2000. This type of turbulence is controlled by either the Deborah or the Weissenberg numbers, which compare elastic and viscous effects. The flow exhibits scale-invariant properties parallel to those of inertial turbulence albeit with different universal exponents @Groisman2001 @Steinberg2019.


A few years after the discovery of elastic turbulence, spontaneous chaotic flows at low Reynolds numbers were found in a bacterial suspension @Dombrowski2004. They were initially called #emph[bacterial turbulence]. In the following decade, turbulent-like flows were discovered and characterized in several other active fluids, often of biological origin (@Fig1). Examples include different bacterial suspensions @Dombrowski2004 @Cisneros2007 @Sokolov2007 @Ishikawa2011 @Sokolov2012 @Wensink2012 @Dunkel2013 @Patteson2018 @Li2019 @Peng2020 @Liu2020, swarming sperm @Creppy2015, suspensions of microtubules and molecular motors @Sanchez2012 @Henkin2014 @Guillamat2017 @Lemma2019 @Martinez-Prat2019 @Tan2019 @Martinez-Prat2021, tissue cell monolayers @Doostmohammadi2015 @Yang2016a @Blanch-Mercader2018 @Lin2021, and suspensions of artificial self-propelled particles @Nishiguchi2015 @Karani2019.


The defining feature of active matter is that it is driven internally by its constituents, which transform stored free energy into motion @Marchetti2013. Active systems are prone to experience instabilities and self-organization phenomena, thus developing correlated collective flows at large scales. When these self-driven flows become spatiotemporally chaotic, the situation is analogous to inertial turbulence at a descriptive level. Hence, these flows are commonly known as #emph[active turbulence] @Thampi2016a, but also as mesoscale turbulence or simply spatiotemporal chaos. Here, we use the name active turbulence. Beyond this descriptive analogy, there has been recent progress in establishing to what extent and in which sense active chaotic flows define new classes of turbulence. The question, however, remains unsettled and requires further work.


A key difference between active and inertial turbulence is worth emphasizing from the start. In inertial turbulence, the scale at which energy is injected is imposed by the external driving. In contrast, active flows are autonomous, and the pattern of energy injection is self-organized. In other words, the spectrum of energy injection is not an input of the problem but part of its solution. In active matter, the energy input is ultimately due to its microscopic components, be them self-propelled colloids, swimming bacteria or molecular motors. However, their motion is correlated over much larger scales. Therefore, in a continuum description of the system as a fluid, the energy input into the hydrodynamic modes occurs at the characteristic scales of the flows. Consequently, both energy injection and dissipation are peaked at similar scales, and hence one may not expect energy cascades spanning an arbitrarily large range of scales as in traditional turbulence. Nevertheless, the spectra of energy injection and dissipation need not be exactly equal, thus allowing for energy transfer across scales. Finally, regardless of energy cascades, active turbulence can exhibit scale-free correlations. As we will discuss, the scaling regimes of active turbulence showcase similarities and differences with inertial turbulence.


Here, we review the different types of active turbulence, in an effort to provide a unified perspective. A key challenge is that, in contrast to the Navier-Stokes equation for inertial turbulence, in active turbulence there is no unique fundamental equation but rather a variety of equations to describe diverse situations. In terms of approach, there are two classes of equations: (i) phenomenological generalizations of the Navier-Stokes equation, adding terms that inject energy and produce instabilities, and (ii) the hydrodynamic equations for active liquid crystals, which derive from symmetries and conservation laws. Moreover, active turbulence usually takes place in systems with orientational order. Turbulence is qualitatively different in systems with either polar or nematic order, and we have thus organized the review according to this distinction. In each section, we also distinguish between 'wet' and 'dry' systems. Following the convention in the active matter literature, dry systems do not conserve momentum, usually due to the presence of a frictional substrate or environment, whereas wet systems are dominated by hydrodynamic interactions and are described by momentum-conserving equations. This distinction is not inherent to the physical system but to the model; a system may be described as wet or dry depending on parameter values and observation scales. Before discussing theory, we briefly describe experiments.


= Experiments
<experiments>


Since its original discovery in bacterial suspensions, active turbulence has been found in an increasing number of systems (@Fig1). Some are based on active particles. Microswimmers such as bacteria (Fig. 1a,d), sperm cells (Fig. 1b), and self-propelled colloids (Fig. 1c) are polar entities with head-tail asymmetry. Often, these particles align via both collisions and hydrodynamic interactions, leading to active polar phases that exhibit collective motion, equivalent to the flocking of birds. However, polar swimmers can potentially also align in a head-tail-symmetric way, leading to nematic phases. Determining the type of cell alignment in dense bacterial suspensions remains challenging. Other systems are clearly nematic, as revealed by the presence of half-integer topological defects. For example, in dense monolayers, eukaryotic cells have anisotropic shapes and align along a common axis (Fig. 1e). In these conditions, cells lack a persistent polarity, and therefore align nematically. Similarly, under the action of a depletant agent, polar cytoskeletal filaments known as microtubules align nematically into bundles (Fig. 1f). The bundles are then actively sheared by kinesin molecular motors that crosslink and walk on parallel filaments, producing active nematic forces.


// [figvision-cn] imgs/Fig1.png
// 该图由六个主行（标记为a至f）组成，每行展示一种不同的主
// 动湍流实验系统。每一行均包含三个垂直排列的子列：左侧为
// “实验图像”（Experimental image），中间为“涡度场”（
// Vorticity field），右侧为“能谱”（Energy spectrum）。各
// 子图描述如下： a. 大肠杆菌悬液（B. subtilis） 左列（实
// 验图像）：灰度显微照片，显示密集排列的杆状细菌。左下角
// 有白色方框标注区域，并附放大插图（右下角小图），清晰显
// 示单个细菌形态。比例尺位于左下角，标示“50 μm”。 中列（
// 涡度场）：彩色热图叠加流线或速度矢量场。颜色条位于右侧，
// 范围从-4到+4，单位为ω/(√γ)，其中ω为涡度，γ为噪声强度参
// 数。图中呈现红蓝相间的漩涡结构，红色代表正涡度，蓝色代
// 表负涡度。 右列（能谱）：对数坐标曲线图。横轴为波数k/
// k_c（无量纲），范围10⁻²至10¹；纵轴为能量谱E(k)（单位未
// 明确标出，但应为能量/波数）。图中包含四条曲线：黑色实
// 线（B. subtilis准二维）、绿色虚线（连续理论预测）、红
// 色方块点（B. sublis三维）、灰色三角形点（另一组数据）。
// 所有曲线在低波数区呈幂律下降趋势，斜率约-k⁻³。内嵌插图
// 显示速度相关函数C(r)，用于推导能谱。 b. 精子悬液（准二
// 维） 左列（实验图像）：彩色显微图像，显示大量弯曲游动
// 的精子细胞，背景为浅蓝色，精子呈深蓝色与青色交织。比例
// 尺位于左下角，标示“200 μm”。 中列（涡度场）：彩色等值
// 线图叠加流线。颜色条位于下方，范围从-30到+30，单位为Ω₀
// /√(νD)，其中Ω₀为特征涡度，ν为运动粘度，D为扩散系数。图
// 中可见多个闭合涡旋结构，中心为红色（正涡度）或蓝色（负
// 涡度）。 右列（能谱）：对数坐标散点加拟合曲线图。横轴
// 为归一化波数k/k_c，范围10⁰至10³；纵轴为ε(k)（单位未标，
// 应为耗散率谱）。数据点为黑色实心圆，整体呈-k⁻³幂律衰减，
// 用虚线拟合。 c. 自驱动Janus颗粒（二维） 左列（实验图像）：
// 灰度显微照片，显示圆形Janus颗粒（一半涂黑一半透明）随
// 机分布。部分颗粒被红色轮廓圈出，表示追踪对象。比例尺位
// 于右下角，标示“100 μm”。 中列（涡度场）：彩色热图，颜
// 色条位于右侧，范围从-0.02到+0.02，单位为s⁻¹。图中显示
// 局部涡旋结构，颜色变化反映涡度空间分布。 右列（能谱）：
// 双Y轴折线图。左Y轴为功率谱密度S(k)（单位μm²/s²），右Y
// 轴为归一化波数k/k_c。图中两条曲线：绿色实线（线性增长
// 段）、红色虚线（平台后下降段）。内嵌插图显示速度相关函
// 数随距离的变化，用于提取特征尺度。 d. 大肠杆菌悬液（E.
// coli，三维） 左列（实验图像）：灰度显微照片，显示高密
// 度棒状细菌均匀分布。比例尺位于左下角，标示“50 μm”。 中
// 列（涡度场）：彩色热图叠加流线。颜色条位于右侧，范围从
// -3×10⁻⁵到+3×10⁻，单位为s¹。图中呈现复杂涡旋网络，红蓝
// 交替区域明显。 右列（能谱）：多系列对数坐标散点图。横
// 轴为波数k（单位μm⁻¹），范围10⁻¹至10¹；纵轴为E(k)（单位
// μm³/s²）。不同符号和颜色代表不同实验条件（如浓度、温度
// 等），图例位于右上角。多数曲线在高波数区呈-k⁻³幂律，部
// 分在低波数区偏离。阴影区域可能表示误差带或理论预测范围。
// e. 组织细胞单层（MDCK, HUVEC, C2C12, NIH-3T3） 左列（
// 实验图像）：灰度显微照片，显示贴壁生长的上皮细胞单层，
// 细胞边界清晰。比例尺位于左下角，标示“300 μm”。 中列（
// 涡度场）：彩色网格图，每个网格单元填充颜色表示局部涡度。
// 颜色条位于上方，范围从-0.8到+0.8，单位为h⁻¹（每小时）。
// 图中显示细胞集体运动形成的涡旋模式，红蓝斑块对应旋转方
// 向。 右列（能谱）：对数坐标散点图。横轴为重标波数k/k_c
// （无量纲），范围10⁻¹至10⁰；纵轴为E(k)（单位μm²·h⁻²）。
// 四种细胞类型分别用不同符号表示：MDCK（红色圆圈）、
// HUVEC（紫色三角）、C2C12（橙色菱形）、NIH-3T3（绿色倒
// 三角）。所有数据点在中等波数区趋于一致，表明普适性行为。
// f. 微管-驱动蛋白悬液（二维） 左列（实验图像）：灰度动
// 态显微序列截图，显示纠缠的微管纤维束。比例尺位于左下角，
// 标示“50 μm”，并注明时间间隔“10 sec”。 中列（涡度场）：
// 彩色热图叠加流线。颜色条位于右侧，范围从-4到+4，单位为
// s⁻¹。图中显示大尺度涡旋结构，颜色渐变平滑。 右列（能谱）：
// 对数坐标曲线图。横轴为波数q（单位μm⁻¹），范围10⁻¹至10⁰；
// 纵轴为动能谱E(q)（单位μm²/s²）。图中一条绿色实线表示实
// 验数据，两条虚线分别表示理论预测（~q⁻³和~q⁻⁴）。底部标
// 注参数η=9.7×10⁻ Pa·s，以及特征长度l_f/L和l_s/L的比例关
// 系。 整幅图通过对比六种不同主动物质系统的涡度场结构与
// 能谱，揭示主动湍流的共性特征——即在不同微观机制下均出现
// -k⁻³幂律能谱，支持其作为普适现象的理论框架。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering)* #it.body]
}

#figure(
  placement: top,
  block[
    #v(-2.5cm)
    #align(center, image("imgs/Fig1.png", width: 80%))
  ],
  caption: [
    #strong[Experiments on active turbulence]. For each experimental system, the three columns show an image of the system, a snapshot of the vorticity field (with either streamlines or the flow field in some cases), and the measured energy spectrum $E ( k ) prop k chevron.l | tilde(bold(v))_(bold(k)) |^2 chevron.r$. a, Adapted from @Wensink2012. b, Adapted from @Creppy2015. c, Adapted from @Nishiguchi2015. The inset shows the velocity correlation function from which the spectrum is obtained. d, Adapted from @Peng2020 @Liu2020. The different spectra correspond to different volume fractions of bacteria. The inset shows the scaling exponent of the spectrum as a function of the volume fraction. e, Adapted from @Lin2021. The different spectra correspond to different cell types. f, Adapted from @Guillamat2017 @Martinez-Prat2021.
  ]
)
<Fig1>



In addition to their varied symmetries, these systems also lie at different points along the wet-dry spectrum. For example, bacteria in dense suspensions are thought to interact mainly by steric repulsion and other short-range interactions such as lubrication forces @Drescher2011 @Koch2011. Hence, dense bacterial suspensions have been successfully modeled as dry systems (Fig. 1a and @dry-polar). Yet, long-range hydrodynamic interactions might dominate in more dilute suspensions, where bacterial turbulence has been modeled in the wet limit (Fig. 1d and @wet-polar and @wet-nematics). Respectively, cohesive cell monolayers lie on solid substrates, with which they can exchange momentum by friction. Hence, they are often treated as dry systems. Yet, cell monolayers behave as wet systems at length scales smaller than the hydrodynamic screening length $lambda = sqrt(eta / xi)$, where $eta$ is the monolayer viscosity and $xi$ is the cell-substrate friction coefficient. This length typically ranges from a few tens to several hundreds microns depending on the strength of cell-cell and cell-substrate adhesion @Blanch-Mercader2017 @Duclos2018 @Perez-Gonzalez2019\; it can therefore encompass from a few cells up to a few hundreds, placing the system in the wet-dry crossover (@dry-nematics). Finally, two-dimensional microtubule films can be assembled at an oil-water interface. Hence, there is also a viscous screening length $ell_(upright("v")) = eta / eta_(upright("ext"))$ that results from comparing the two-dimensional viscosity $eta$ of the active nematic film with the three-dimensional viscosity $eta_(upright("ext"))$ of the external passive fluids. This system therefore also exhibits a wet-dry crossover @Martinez-Prat2021 (Fig. 1f and @dry-nematics).


Over the years, experiments have characterized some statistical properties of active turbulence. For example, motivated by theoretical predictions, experiments on active nematics have measured the vortex area distribution @Guillamat2017 @Lemma2019 @Martinez-Prat2021 @Blanch-Mercader2018. The central quantity common to all types of active turbulence is the velocity correlation function or, equivalently, the kinetic energy spectrum, which has been measured in most experimental systems @Wensink2012 @Liu2020 @Creppy2015 @Martinez-Prat2021 @Lin2021 @Nishiguchi2015 (@Fig1). Although these results are very informative, further measurements are required to fully characterize the scaling regimes and sort systems into classes. Moreover, additional relevant quantities have not been measured yet. These quantities include the spectra of energy transfer across scales, as well as the spectra of elastic energy in nematics. In addition to revealing this crucial information, future research might also discover active turbulence in other systems such as vibrated granular rods @Narayan2007, actin-based liquid crystals @Kumar2018 @Zhang2018c, cilia-driven flows on bronchial tissues @Loiseau2020, and nematic bacterial colonies migrating on substrates @Copenhagen2021.


= Polar fluids
<polar>


The observation of turbulent-like flows in bacterial suspensions motivated the first theories of active turbulence. Early approaches were based on models of microswimmer suspensions, which lead to continuum equations for three coupled fields: swimmer concentration, coarse-grained polarity, and fluid velocity @Aranson2007 @Wolgemuth2008. Simulations of these equations produced chaotic flows similar to the experiments.


Later work modelled bacterial turbulence ignoring the solvent flow, i.e. treating the system as dry. For example, simulations of self-propelled particles, either rods with steric interactions @Wensink2012 @Bar2020 or points with competing alignment interactions @Grossmann2014, yield a number of phases including irregular vortex patterns similar to the experimental observations (Fig. 2a). At the continuum level, Wensink, Dunkel, et al. proposed a phenomenological description based on a single equation for the velocity field of the bacterial suspension @Wensink2012 @Dunkel2013 @Dunkel2013a. This equation, known as the Toner-Tu-Swift-Hohenberg (TTSH) equation, has been the main focus of research in dry polar active turbulence @Wensink2012 @Dunkel2013 @Dunkel2013a @Bratanov2015 @James2018a @James2018. We discuss its origin and main results in @TTSH and @TTSH-scaling. More recently, the TTSH equation has been derived by explicit coarse-graining from microscopic models of microswimmers @Heidenreich2016 @Reinken2018. Thus, this work connects the initial wet suspension model with the final dry description in terms of a single velocity field. Finally, in @active-polar-LC we discuss other types of turbulence in models of active polar liquid crystals with friction.


Work in wet polar systems has mainly been in two directions. One follows the phenomenological approach of the TTSH equation to propose a momentum-conserving extension of the Navier-Stokes equation. We discuss it in @GNS. The other direction involves further work on active polar suspensions, which uncovered the mechanisms of the transition to spatiotemporal chaos in these systems. We discuss it in @active-polar-suspensions.


#pagebreak()
// [figvision-cn] imgs/Fig2.png
// 子图 a：二维涡度标量场模拟快照，叠加黑色流线。右侧竖直
// 色标标量为涡度 ω/|⟨ω⟩|，范围 −4（深蓝）到 4（深红），
// 红黄区域为正涡度涡旋核心，青蓝区域为负涡度区域。左下角
// 白色比例尺标注“50 μm”。图中标注文字仅有色标标签“
// Vorticity”与“ω/|⟨ω⟩|”以及比例尺“50 μm”。场面呈均匀湍流，
// 正负涡度斑块细小密集，黑色流线构成闭合涡旋与剪切带，表
// 征自驱动棒状体产生的主动湍流，涡旋特征尺度远小于系统尺
// 寸。 子图 b：二维折线图。横轴“Wave number q”，纵轴“
// Growth rate Ω”。纵轴原点处标注“−α”，表示 q=0 时的截距。
// 横轴上有一条垂直虚线，下方标注临界波数公式 q_c = √(−Γ₀
// /(2Γ₂))。图中只有一条红色实线，从 q=0、Ω=−α 出发，随 q
// 增大先上升，在 q=q_c 处达到最大值，随后下降并穿过横轴
// 进入 Ω<0 区域，q 继续增大时 Ω 趋向负值。结论：所示参数
// regime 下静止态在长波长（小 q）处线性不稳定（Ω>0），最
// 不稳定模态波数为 q_c，短波长扰动被稳定（Ω<0），故产生
// 具有特征尺度的涡旋。 子图 c：主图为散点折线图，左上角
// 嵌入 inset。主图横轴“Self-propulsion speed v0 (μm)”，
// 范围 0–50，刻度 0、10、20、30、40、50；纵轴“Vortex
// size R* (μm)”，刻度 0、5、10、15。蓝色实心三角形标记表
// 示涡旋尺度，v0 约小于 12 μm 时 R*≈0，在 v0≈12–15 μm 处
// 由一条垂直虚线标记的阈值突然跃升，v0 超过约 18 μm 后 R
// * 趋于平坦，用蓝色虚线连接高速点，值约 15 μm，随 v0 继
// 续增加基本不变。Inset 竖排标注“Correlation length”，横
// 轴 v0 范围 0–60，标注 0、v0、60，内含多条红蓝实线与虚
// 线，曲线从小值上升并在 v0≈30–60 处振荡并趋于约 10–12
// 的平台，下方有一条水平虚线。结论：自驱动速度超过临界值
// 后涡度尺度由零跃升并饱和，相关长度随 v0 增大而增大后趋
// 稳，表明活性湍流出现稳定的特征涡旋尺度。 子图 d：双对
// 数坐标折线图。横轴“Rescaled wave number kℓ”，范围约 10
// ⁻¹–10²，主刻度 10⁰、10¹、10²；纵轴“Energy spectrum E_k
// / v0²”，范围 10⁻²⁰–10⁰，主刻度 10⁰、10⁻¹⁰、10⁻²⁰。右侧
// 图例：红色实线标注“−ατ = −1”，蓝色点线标注“−ατ = 4”。
// 图中还画有两条黑色参考直线，上方标注“∝ k^2.04”，中间标
// 注“∝ k³”。小 kℓ 时红色实线近似遵循 ∝ k^2.04，蓝色点线
// 近似遵循 ∝ k³，能量谱随波数上升；kℓ 超过约 10–20 后两
// 条曲线分别发生指数型切断并快速下降，红色实线在更大波数
// 处切断，蓝色点线在 kℓ≈10 附近即开始快速衰减。结论：能
// 量在中等波数处积累，高波数处被快速耗散，−τ 值越大高波
// 数能量被抑制得越早。 子图 e：二维多曲线折线图。横轴“
// Rescaled wave number kℓ”，范围 0–40，每 5 一个刻度；纵
// 轴“Power spectra”，范围 −0.4–0.3，刻度 −0.4、−0.3、−
// 0.2、−0.1、0、0.1、0.2、0.3。右上角图例：能量源组包含“
// −2α E_k”（棕褐色虚线）、“T_rad^adv”（浅绿色实线）、“
// T_k^adb”（深蓝色实线）、“2|Ω| k² E_k”（品红实线）、“−2
// |Ω| k⁴ E_k”（青色实线）；能量汇组包含“−∂_t E_k”（黑色
// 实线）。品红曲线“2|Ω| k² E_k”为最大能量源，在 kℓ≈6 处
// 达峰值约 0.27，随后随 kℓ 增大单调衰减，kℓ≈25 后趋近零；
// 棕褐色虚线“−2α E_k”在 kℓ≈5 处达正峰约 0.14 后衰减；浅
// 绿色曲线“T_rad^adv”在 kℓ≈4 处正峰约 0.1 后转负，在 kℓ≈
// 10–15 处有浅负值并最终趋零；青色曲线“−2|Ω| k⁴ E_k”在小
// kℓ 略负后趋零；黑色曲线“−∂_t E_k”紧贴零轴且只有微小波
// 动；深蓝色曲线“T_k^adb”为最大能量汇，在 kℓ≈5 处达谷值
// 约 −0.4，随后上升并在 kℓ≈15–20 附近穿过零轴趋于零。图
// 中文字标注：“Energy sources”位于右上方，“Energy sinks”
// 位于右下方。结论：低波数处以 2|Ω| k² E_k 与 −2α E_k 为
// 主的注入机制占优势，中高波数处由 T_k^adb 主导的能量汇
// 移除能量，能量在 kℓ≈5–10 处由源转为汇，形成有限波长的
// 能量耗散截断。
#figure([#block[
  #box(image("imgs/Fig2.png", width: 100%))

  ]],
  caption: [
    #strong[Active turbulence in dry polar fluids]. a, Snapshot of the vorticity field and streamlines obtained from a simulation of self-propelled rods, which produces results similar to those of the continuum TTSH equation. Adapted from @Wensink2012. b, Growth rate of velocity perturbations in the TTSH equation for $alpha < 0$, $Gamma_0 < 0$, and $Gamma_2 > 0$. In this regime, the quiescent state is unstable at long wavelengths, producing vortices with a characteristic size $tilde(q)_(upright("c"))^(- 1)$. c, Simulations of the TTSH equation derived from a microscopic model of self-propelled swimmers also show the selection of a characteristic vortex size that saturates at high activity. A similar trend is found for the velocity correlation length measured experimentally in 3D bacterial suspensions @Sokolov2012 (inset). Adapted from @Heidenreich2016. d, The energy spectrum of the TTSH equation exhibits a scaling regime with a non-universal exponent that varies with the parameter $alpha$. This parameter controls energy injection, from lower (blue) to higher (red). e, Spectra of the contributions to the energy balance in the stationary turbulence regime of the TTSH equation ($alpha tau = - 1$). The advective nonlinearity transfers energy across scales. Panels d and e adapted from @Bratanov2015.
  ]
)
<Fig2>


== Dry systems
<dry-polar>


=== Toner-Tu-Swift-Hohenberg equation
<TTSH>


The TTSH equation builds on the Toner-Tu equations for flocking @Toner1995 @Toner2005 @Marchetti2013, which provide a coarse-grained description of the Vicsek model for self-propelled aligning particles @Vicsek1995 @Marchetti2013. As in flocking, the TTSH equation describes the coarse-grained velocity $bold(v)$ of the particles, and it ignores hydrodynamic interactions mediated by the solvent. The solvent, however, exchanges momentum with the particles. Thus, the momentum of the particle system is not conserved, making the theory dry. This description does not distinguish the velocity from the polarity field and assumes that motion always occurs along the particle orientation direction. Finally, in contrast to the original Toner-Tu equations, the TTSH assumes incompressibility, i.e. $bold(nabla) dot.op bold(v) = 0$.




Following the structure of the Toner-Tu equation, the TTSH equation can be expressed as @Wensink2012


$ (partial_t + bold(v) dot.op bold(nabla)) bold(v) = - bold(nabla) P med - ( alpha + beta | bold(v) |^2 ) bold(v) + bold(nabla) dot.op bold(E) $<eq-Toner-Tu>


where the pressure $P$ is determined by the incompressibility constraint $bold(nabla) dot.op bold(v) = 0$. The Landau-like expansion in powers of the velocity describes the flocking transition. For $alpha < 0$, with $beta > 0$, the system develops long-range polar order, flowing with velocity $v_0 = sqrt(- alpha / beta)$ in an arbitrary direction. Respectively, the strain-rate tensor $bold(E)$ takes the form


$ E_(i j) = S (v_i v_j - 1 / d | bold(v) |^2 delta_(i j)) + (Gamma_0 - Gamma_2 nabla^2) (partial_i v_j + partial_j v_i) . $


The first term, with $d$ the space dimension, corresponds to anisotropic active nematic stresses due to the microswimmers. These stresses give contributions to the advection and the pressure terms, and @eq-Toner-Tu can be rewritten as @Wensink2012


$ (partial_t + lambda_0 bold(v) dot.op bold(nabla)) bold(v) + bold(nabla) (p - lambda_1 | bold(v) |^2) = [Gamma_0 nabla^2 - Gamma_2 nabla^4 - ( alpha + beta | bold(v) |^2 )] bold(v) , $<eq-TTSH>


where $lambda_0 = 1 - S$ and $lambda_1 = - S / d$. Note that, because of the absence of Galilean invariance, the coefficient $lambda_0$ of the self-advection term can be different from one. For puller swimmers, such as the algae #emph[C. reinhardtii], $S > 0$. For pushers, such as the bacterium #emph[B. subtilis], $S < 0$. The $Gamma_0$ term corresponds to effective viscous stresses in the suspension.


All the terms discussed so far are taken from the original Toner-Tu equation. However, to destabilize the flocking state and produce vortices, the TTSH equation assumes the effective viscosity to be negative, $Gamma_0 < 0$ @Wensink2012. Even though this is a phenomenological assumption, negative effective viscosities are possible in active suspensions due to a combination of extensile activity and flow alignment, which decrease and may perhaps even reverse the viscous resistance to shear @Hatwalne2004 @Sokolov2009 @Giomi2010 @Ramaswamy2010 @Marchetti2013 @Gachelin2013 @Lopez2015 @Saintillan2018. Moreover, derivations of the TTSH equation from microscopic models reveal that activity indeed leads to a decreased effective viscosity $Gamma_0$, which could possibly turn negative @Grossmann2014 @Heidenreich2016 @Reinken2018. Note that there are important active or non-equilibrium contributions in three terms: the negative friction $alpha$, the self-advection term $lambda_0$, and the negative viscosity $Gamma_0$.


With $Gamma_0 < 0$, one needs the next-order term in the velocity gradient expansion, with $Gamma_2 > 0$, to stabilize the flow at short wavelengths. The right-hand side of @eq-TTSH has the structure of the Swift-Hohenberg equation for pattern formation, originally obtained in the context of thermal convection @Swift1977 @Cross1993. The right-hand side of @eq-TTSH produces a long-wavelength instability, which leads to energy injection across the range of unstable modes. The growth rate has a maximum at a finite wave number, $q_c = sqrt(- Gamma_0 / ( 2 Gamma_2 ))$, which defines a characteristic vortex size (Fig. 2b). This is consistent with both microswimmer models @Heidenreich2016 and experiments @Sokolov2012, which reveal a characteristic velocity correlation length that saturates at high activity (Fig. 2c). $Gamma_0$ and $Gamma_2$ also define a characteristic velocity $V_Gamma = sqrt(| Gamma_0 |^3 / Gamma_2)$. The existence of these characteristic scales of velocity and vortex size, at which the energy spectrum is maximal (Fig. 1a), is an important difference with inertial turbulence, which features scale-free vortex distributions.


Overall, the quiescent, isotropic state ($bold(v) = 0$) of the TTSH equation is subject to two activity-driven instabilities, which respectively yield a uniform transition to flocking due to a negative friction ($alpha < 0$), and spatial pattern formation due to a negative viscosity ($Gamma_0 < 0$). The combination of these two instabilities with the nonlinear effects of velocity self-advection lead to turbulent states in the TTSH equation. In fact, velocity self-advection makes the TTSH equation non-potential, whereas the right-hand side can be derived from an effective free energy and would therefore not produce chaos. The parameters in @eq-TTSH can be fitted to achieve good quantitative agreement with the experimentally-measured velocity correlation functions and energy spectra (Fig. 1a), both in 2D @Wensink2012 and in 3D @Dunkel2013 dense bacterial suspensions. These spectra exhibit scaling regimes described by power laws, which we discuss next.


=== Power laws with non-universal exponents
<TTSH-scaling>


At scales larger and smaller than the typical vortex size, the spectrum obtained in Ref. @Wensink2012 exhibits scaling regimes with exponents close to $5 / 3$ and $- 8 / 3$, respectively (Fig. 1a). With the simplifying choice $lambda_1 = 0$ in @eq-TTSH, later work analyzed TTSH turbulence in more detail, searching for parallels and differences with inertial turbulence @Bratanov2015. This study revealed that the scaling exponents are non-universal, in the sense that they depend on parameter values (Fig. 2d). Non-universal behavior in the TTSH equation arises from its cubic nonlinearity ($beta | bold(v) |^2 bold(v)$), which is not present in the Navier-Stokes equation. Combined with the advective nonlinearity ($bold(v) dot.op bold(nabla) bold(v)$) common to inertial turbulence, the cubic Toner-Tu term provides additional freedom, allowing the system to self-organize into turbulent states with parameter-dependent statistical properties. In this sense, the authors of Ref. @Bratanov2015 claim that these properties define a new class of turbulence.


The spectral energy balance reveals that energy injection is indeed controlled by the $alpha$ and $Gamma_0$ terms driving the instabilities @Bratanov2015. The $Gamma_2$ term contributes to dissipation. As in 2D Navier-Stokes turbulence, the advective nonlinearity transports energy from intermediate to large scales. The additional cubic nonlinearity dominates the dissipation at large scales (Fig. 2e). In particular, it dissipates the energy transported by the advective effects, thus preventing the inverse energy cascade of inertial 2D turbulence @Bratanov2015. More recent work has confirmed this scenario and revealed that a very strong advective transfer leads to the emergence of vortex patterns from a transient turbulent state @James2018a.


=== Active polar liquid crystals with friction
<active-polar-LC>


Other types of dry turbulence can take place in models for active polar liquid crystals with friction. In contrast to the TTSH equation, and like in two-phase suspensions, in liquid crystals the velocity and the polarity fields can be different from one another. In fact, polarity-velocity misalignment occurs in systems such as Janus colloids @Zhang2020 and epithelial monolayers @Kim2013 @Notbohm2016 @Alert2020, in which cells polarize in response to mechanical stresses and environmental cues @Alert2020. Similarly, early experiments and simulations on bacterial turbulence found a low correlation between the velocity and polarity fields, suggesting a strong advection of bacteria by the solvent @Sokolov2007 @Aranson2007.


Despite being simpler than full microswimmer suspensions, turbulence in polar liquid crystals has not received as much attention. An exception is Ref. @Blanch-Mercader2017c. Motivated by mechanical waves in epithelial cell monolayers on solid substrates, this study proposed an active polar fluid model based on the following force balance: $bold(nabla) dot.op bold(sigma) = xi bold(v) - T_0 bold(p)$. Here, $bold(sigma)$ is the stress tensor of the fluid, which includes viscous, active, and flow alignment contributions. The interaction forces with the substrate include viscous friction with coefficient $xi$ and active traction with magnitude $T_0$ in the direction of cell polarity $bold(p)$. In turn, the polarity evolves as dictated by liquid crystal hydrodynamics @DeGennes-Prost @Marchetti2013 @Prost2015 @Julicher2018, which includes advection and co-rotation of the polarity by the flow.


The polar state, with $| bold(p) | = 1$ and speed $v_0 = T_0 / xi$, is destabilized by the active stresses. Moreover, the advection term $bold(v) dot.op bold(nabla) bold(p)$ in the polarity dynamics endows the growth rate with an imaginary part, which leads to nonlinear traveling waves. Near the instability threshold, modulations of these waves follow the so-called complex Ginzburg-Landau equation, originally proposed in the context of pattern formation @Aranson2002 @Cross1993. This equation exhibits several forms of spatiotemporal chaos, including phase turbulence, amplitude turbulence, spatiotemporal intermittency, and bistable chaos @Chate1994. These states could therefore arise via secondary bifurcations from the nonlinear waves @Blanch-Mercader2017c, as also suggested in Ref. @Marcq2014. Whether such forms of active turbulence are found in polarized epithelial tissues or other polar systems remains an open question.


== Wet systems
<wet-polar>


=== Generalized Navier-Stokes equation
<GNS>


Following the phenomenological approach of the TTSH equation, Słomka and Dunkel proposed the so-called Generalized Navier-Stokes (GNS) equation to describe active turbulence in polar momentum-conserving systems @Slomka2015. In contrast to the TTSH equation, the GNS equation does not include Toner-Tu flocking terms. Therefore, it contains neither the negative friction leading to polar order nor the cubic nonlinearity that enables non-universal scaling in the TTSH equation (see @TTSH and @TTSH-scaling). Instead, the activity is phenomenologically encoded in a postulated, generic extension of the stress tensor. This approach is again similar in spirit to the Swift-Hohenberg equation for pattern formation @Swift1977 @Cross1993, and it had also been used in the context of granular media @Aranson2006. Here, the effective stress tensor is proposed to be linear in the velocity field, and it is expressed as a gradient expansion, thus conserving momentum. The only nonlinearity of the GNS equation is thus the velocity self-advection term, as in the Navier-Stokes equation. Assuming incompressibility ($bold(nabla) dot.op bold(v) = 0$), the GNS equation reads


$ (partial_t + bold(v) dot.op bold(nabla)) bold(v) = - bold(nabla) P + bold(nabla) dot.op bold(sigma) , $<eq-GNS>


with


$ sigma_(i j) = [Gamma_0 - Gamma_2 nabla^2 + Gamma_4 nabla^4] (partial_i v_j + partial_j v_i) . $<eq-eff_visc>


Except for the $Gamma_2$ and $Gamma_4$ terms, this equation has the form of the Navier-Stokes equation. In contrast to the TTSH equation, here $Gamma_0$ is a positive viscosity. Therefore, we may think of this model as having an effective kinematic viscosity that depends on the spatial scale, which is represented in Fourier space via the following dependence on the wave number $q$: $tilde(nu)_(upright("eff")) ( q ) = Gamma_0 + Gamma_2 q^2 + Gamma_4 q^4$. Turbulence at low Reynolds number is then modeled as arising from an instability obtained by setting $Gamma_2 < 0$ while keeping $Gamma_4 > 0$. This choice produces a band of unstable modes which, unlike for the TTSH equation (Fig. 2b), exclude the longest wavelengths ($q arrow.r 0$). The unstable modes inject energy to drive flows and, as in the TTSH equation, they produce patterns of vortices with a characteristic size. These patterns can then become turbulent thanks to the nonlinear advection term inherited from the Navier-Stokes equation @Slomka2015.


The GNS equation was proposed as an alternative model for the bacterial turbulence experiments. As for the dry TTSH equation, the parameters of the GNS equation were also fitted to the velocity correlation functions and probability distributions of 3D bacterial suspensions @Slomka2017, as originally measured in Refs. @Wensink2012 @Dunkel2013. On the theoretical side, the relative mathematical simplicity of the GNS equation enabled analytical solutions of vortex lattices @Slomka2017a. It was also formulated in a covariant way to simulate active turbulence on curved surfaces @Mickelin2018. In 3D, the theory predicted an inverse energy cascade @Slomka2017 @Slomka2018, opposite to the direct cascade of inertial 3D turbulence. The active inverse cascade is also different from the inverse cascade of inertial 2D turbulence in that it is not driven by vortex merging. Instead, the active cascade involves the formation of moving vortex chains, and it results from a spontaneous breaking of chiral symmetry @Slomka2017 @Slomka2018. Observing these effects in experiments remains a challenge.


Finally, a variant of the GNS equation was also used to study the crossover from active to inertial 2D turbulence as the Reynolds number is increased. By varying the effective viscosity spectrum $tilde(nu)_(upright("eff")) ( q )$, simulations revealed a sharp transition between the small vortices characteristic of GNS active turbulence and the emergence of a classic inverse cascade that accumulates energy at the largest scales, giving rise to a so-called condensate of two large vortices @Linkmann2019 @Linkmann2020. The authors argue that this transition might be observable in bacterial suspensions, which could reach moderate Reynolds numbers owing to the reduction of their effective viscosity by activity (see discussion in @TTSH). The active-to-inertial transition might also be observable in other systems where turbulence is driven by larger active objects such as magnetic spinners @Kokot2017 and camphor boats @Bourgoin2020, which might reach even higher Reynolds numbers.



// Fig. 3 caption's citations come first in the source's citation order.
#place(hide[#cite(<Giomi2012>) #cite(<Carenza2020>)])

=== Active polar liquid crystals and suspensions
<active-polar-suspensions>


As in the dry case, wet polar systems can also be modeled using the formalism of liquid crystal hydrodynamics. In contrast to the phenomenological approach of the GNS equation (@GNS), the hydrodynamic equations of polar liquid crystals are established by symmetries and conservation laws @DeGennes-Prost @Marchetti2013 @Prost2015 @Julicher2018, and the parameters are measurable quantities with a direct physical interpretation. The hydrodynamic equations are similar to those of active nematics (see @nematic-hydrodynamics), replacing the director field by a polarity field and adding polar terms that break the invariance under $bold(p) arrow.r - bold(p)$.


Work on wet turbulence in one-component polar liquid crystals has been surprisingly scarce @Bonelli2016. Most work has focused on two-component suspensions, whose equations include a swimmer concentration field $c$ @Aranson2007 @Wolgemuth2008 @Giomi2008 @Tjhung2011 @Giomi2012. In this case, active stresses become proportional to the concentration field. Moreover, the swimmers self-propel with respect to the fluid, and therefore the concentration and the polarity fields are advected both by the fluid and by the swimmers. Accordingly, the material derivatives in the transport equations read $partial_t c + bold(nabla) dot.op [( bold(v) + w_c bold(p) ) c]$ and $[partial_t + ( bold(v) + w_p bold(p) ) dot.op bold(nabla)] bold(p)$. Here, $w_c$ and $w_p$ characterize the self-advection terms arising from self-propulsion, which were found to enhance concentration inhomogeneities @Tjhung2011.


Polarity self-advection is a feature common with polar dry systems; it appears in the Toner-Tu equations. Consequently, active polar suspensions share some of the instabilities and spatiotemporal patterns of dry polar fluids @Giomi2012, such as the traveling density waves found in the Toner-Tu equations @Tu1998 @Bertin2009 @Geyer2018 @Marchetti2013 (Fig. 3a). Moreover, the hydrodynamic equations of polar fluids reduce to those of nematic fluids when the polar terms are ignored. Hence, active polar suspensions share the spontaneous flow instability of active nematics (Fig. 3a), which we discuss in @spontaneous-flow. Yet other instabilities arise from the interplay between advection and active stresses, leading to hydrodynamic traveling waves @Giomi2012 (Fig. 3a) reminiscent of experimental observations in bacterial swarms @Chen2017a. These waves, as those discussed in @active-polar-LC, are specific to polar fluids.


Unlike in nematic fluids, instabilities in polar fluids can occur via Hopf bifurcations, giving rise to oscillatory phenomena. Simulations of polar suspensions indeed find oscillatory flows that become increasingly complex, with the sequential addition of frequencies in the spectrum, as activity increases @Giomi2008. In fact, more complete simulations revealed a route to spatiotemporal chaos through patterns of traveling waves and vortices @Giomi2012 (Fig. 3b). Simulations of polar liquid crystals with polarity-velocity alignment painted a similar picture, with oscillatory and traveling patterns leading to chaos @Bonelli2016. Intriguingly, this sequence of patterns was also observed in simulations of active nematics confined between two walls with different friction @Ramaswamy2016. Apart from this specific case, the route to chaos through Hopf bifurcations is different than that of nematic systems, either the one-component fluids that we discuss in @wet-nematics, or suspensions, which exhibit excitable behavior prior to the transition to chaos @Giomi2011.


// [figvision-cn] imgs/Fig3.png
// 子图 a：相图，来源于齐次态的线性稳定性分析。横轴为浓度
// c₀ − c*，线性坐标，范围 0.0 到 1.0，无量纲；纵轴为活性
// −ζ，线性坐标，范围 −2 到 2，无量纲。图中按填充颜色划分
// 区域：左上窄条浅蓝色区域位于 c₀−c*≈0.05–0.12、−ζ≈0.9–
// 2.0，标注“Density waves”；左下窄条浅蓝色区域位于 c₀−c*
// ≈0.05–0.12、−ζ≈−2.0–−1.0，同样标注“Density waves”；中
// 间白色区域标注“Homogeneous”，大致位于绿色分界线下方、
// 橙色分界线上方，包含 −ζ≈0 附近；上方浅绿色区域标注“
// Spontaneous flow”，下界为一条深绿色实线，该线从 (c₀−c*
// ≈0.12, −ζ≈1.6) 向右下凸弯曲至 (1.0, −ζ≈0.2)；下方橙色
// 区域标注“Traveling waves”，上界为一条深褐色实线，从 (≈
// 0.05, −1) 急剧上升并在 c₀−c*≈0.2–0.3 附近趋平于 −ζ≈−
// 0.2–−0.1，直至 (1.0, −ζ≈−0.15)。全部标注文字：面板标识
// “a”，纵轴“Activity −ζ”，横轴“Concentration c₀ − c*”，
// 区域文字“Density waves”、“Spontaneous flow”、“
// Homogeneous”、“Traveling waves”。趋势与结论：在浓度接
// 近临界值 c* 的极窄带内出现密度波不稳定性；增大活性（−ζ
// 升高）与浓度使系统从齐次态进入自发流；降低活性使系统从
// 齐次态进入行波；齐次态夹在自发流与行波之间。 子图 b：
// 连续体模拟得到的非线性时空模式相图，以符号散布和彩色背
// 景区分相态。横轴为浓度 c₀ − c*，线性坐标，范围 1.0 到
// 2.0，无量纲；纵轴为活性 −ζ，线性坐标，范围 −5 到 0，无
// 量纲。顶部浅蓝色背景区域标注“Homogeneous”，−ζ 约 −1.2
// 到 0，散布空心小圆圈（蓝色圆点）；中上部淡红色背景区域
// 标注“Traveling waves”，−ζ 约 −1 到 −4，散布空心红色正
// 方形；中下部浅黄色背景区域标注“Traveling vortices”，−ζ
// 约 −3 到 −5，散布空心橙色三角形；右下浅绿色背景区域标
// 注“Chaos”，−ζ 约 −3 到 −5，散布小绿色菱形点。分界线包
// 括：一条蓝色实线从 (1.0, −1.1) 上升至 (2.0, −0.5)，分
// 隔齐次与行波；一条黑色虚线从 (1.0, −3.8) 上升至 (2.0,
// −1.8)，分隔行波与行涡/混沌；另有一条点划线穿过行波与行
// 涡区域。全部标注文字：面板标识“b”，纵轴“Activity −ζ”，
// 横轴“Concentration c₀ − c*”，区域文字“Homogeneous”、“
// Traveling waves”、“Traveling vortices”、“Chaos”。趋势
// 与结论：随着浓度增大且 −ζ 降低（即活性 ζ 增大），系统
// 依次经历齐次态、行波、行涡，最终在右下高浓度高活性区进
// 入混沌；各符号与彩色背景区域一一对应，表示模拟中观测到
// 的非线性稳态。 子图 c：能量谱曲线图，双对数坐标。横轴
// 为波数 k/k_min，对数坐标，范围 1 到约 200（主刻度 1、
// 10、100），无量纲；纵轴为能量谱 E(k)，对数坐标，范围
// 10⁻⁸ 到 10⁻⁴，无量纲。曲线为一组随活性 ζ 增大而叠加的
// 光谱，颜色由深蓝色（低 ζ）逐渐过渡到青色与浅蓝色（高 ζ）；
// 一条粗蓝色箭头标注“Increasing ζ”，指向谱峰升高并向大波
// 数移动的方向。参考斜率为三条黑色实线，分别标注“k”（浅
// 斜，约 k/k_min=2–8）、“k⁻¹”（中等斜，约 8–30）、“k⁻²”
// （陡斜，约 20–60）。两条竖直点线分别标注“k_v”（约 k/
// k_min≈20）和“k_d”（约 k/k_min≈80–100）。全部标注文字：
// 面板标识“c”，纵轴“Energy spectrum E(k)”，横轴“Wave
// number k/k_min”，“Increasing ζ”，“k⁻²”，“k⁻¹”，“k”，“
// k_v”，“k_d”。趋势与结论：能量在中等波数处达峰，ζ 越大
// 谱峰越高且峰位向大波数偏移；小波数处近似 k 律，中波数
// 处近似 k⁻¹，大波数处近似 k⁻² 衰减；k_v 标记涡旋特征波
// 数，k_d 标记耗散/截止波数。 子图 d：功率谱各项贡献曲线
// 图，横轴对数、纵轴线性。横轴为波数 k/k_min，对数坐标，
// 范围 1 到约 400（主刻度 1、10、100），无量纲；纵轴为功
// 率谱，线性坐标，范围 −40 到 60，无量纲。图例与曲线：Π^
// T(k) 用橙色实心三角形，曲线贴近 0，大波数处略升至约 +2；
// Π^visc(k) 用蓝色实心圆，曲线在 k/k_min≈30 后陡降，大波
// 数处约 −35；Π^bin(k) 用黄色实心正方形，曲线贴近 0，大
// 波数处约 −5；Π^pol(k) 用浅蓝色实心下三角形，大波数处约
// −15；Π^act(k) 用深红色实心菱形，曲线从低波数附近 0 开
// 始，在 k/k_min≈30–100 处陡升，大波数处饱和于约 +60。右
// 侧文字标注“Energy sources”位于正值区（约纵坐标 45–55），
// “Energy sinks”位于负值区（约纵坐标 −5 到 −20）。全部标
// 注文字：面板标识“d”，纵轴“Power spectra”，横轴“Wave
// number k/k_min”，图例公式“Π^T(k)”、“Π^visc(k)”、“Π^bin
// (k)”、“Π^pol(k)”、“Π^act(k)”，以及“Energy sources”、“
// Energy sinks”。趋势与结论：活性项 Π^act 为正并随波数增
// 大而显著增长至约 +60，作能量源；黏度项 Π^visc 为负并降
// 至约 −35，作主要能量耗散；Π^pol 与 Π^bin 为较弱的负贡
// 献（约 −15 与 −5），Π^T 接近零或为极弱正贡献（约 +2），
// 表明小尺度处由活性注入能量、由黏度耗散能量。
#figure(placement: top, [#block[
  #box(image("imgs/Fig3.png", width: 90.0%))

  ]],
  caption: [
    #strong[Transition to chaos and active turbulence in wet polar suspensions]. a, Phase diagram obtained from a linear stability analysis of the homogeneous state. Density waves are like those found in the Toner-Tu equations, i.e. in the dry limit. In addition to spontaneous flow, wet polar suspensions can exhibit traveling waves. b, Nonlinear spatiotemporal patterns obtained in simulations of the continuum equations, revealing the emergence of chaos via traveling waves and vortices. Panels a and b adapted from @Giomi2012. c, The energy spectrum in simulations of wet polar emulsions features activity-dependent scaling regimes. $k_(upright("v"))$ is the first moment of the energy distribution, and $k_(upright("d"))$ is related to the scale of emulsion droplets. d, Spectra of the contributions to the energy balance in simulations of active polar emulsions, which exhibit no energy transfer across scales (orange). The other contributions are associated with viscosity (dark blue), the binary composition of the system (yellow), passive polar stresses (light blue), and activity (red). Panels and adapted from @Carenza2020.
  ]
)
<Fig3>


The chaotic flow regime is only beginning to be characterized. Recent work by Carenza et al. has obtained the statistical properties of turbulent-like flows in simulations of active polar emulsions, in which the active component is localized in the emulsion droplets @Carenza2020. The results show energy spectra featuring three scaling regimes, and the exponent of the intermediate regime seems to vary with activity (Fig. 3c). Predicting these results remains an open challenge. Furthermore, the energy injected by active stresses is dissipated by a combination of passive effects (Fig. 3d). Hence, the chaotic flows involve no energy transfer across scales, and therefore no turbulent cascades.


Finally, recent work by Škultéty et al. has used kinetic theory to coarse-grain a microscopic model of microswimmers with hydrodynamic interactions. Going beyond the usual mean-field approximation, this work showed that, below the onset of collective motion, velocity correlations are suppressed by particle self-propulsion @Skultety2020.


= Nematic fluids
<nematic>


The early observations of bacterial turbulence led to the theories for active polar turbulence that we discussed in @polar. In this section, we discuss theories of active nematic turbulence, which were motivated by chaotic flows reported first in microtubule suspensions (Fig. 1f) and then in epithelial monolayers (Fig. 1e). Like for polar fluids, both dry and wet models have been put forward, as well as models that focus on the wet-dry crossover. Unlike in @polar, however, we discuss wet systems first and dry systems later. Before, we give a general introduction to active nematic hydrodynamics, discussing the spontaneous-flow instability that leads to active nematic turbulence, and the dimensionless number that controls it.


== Active nematics
<nematic-general>


=== Hydrodynamic equations
<nematic-hydrodynamics>


Most theoretical work on turbulence in active nematics is based on hydrodynamic equations for macroscopic slow variables @Ramaswamy2010 @Marchetti2013 @Prost2015 @Julicher2018. These variables are either conserved quantities, such as concentrations and momentum, or soft modes arising from the spontaneous breaking of continuous symmetries such as isotropy.


In nematics, orientational order is described by a traceless symmetric tensor known as the nematic order parameter, $bold(Q)$. It can be expressed as $bold(Q) = 2 / 3 S bold(q)$, where $q_(i j) = n_i n_j - 1 / d delta_(i j)$ and $d$ is the space dimension @DeGennes-Prost. Here, $hat(bold(n))$ is the so-called director field, which indicates the axis of alignment. Its direction is a soft mode. Respectively, $S$ is the amplitude of the order parameter, which quantifies the degree of alignment. Strictly speaking, it is not a soft mode. However, it can be useful to keep it in hydrodynamic equations to study situations in which the nematic order varies sharply, such as around topological defects. This approach is followed in most numerical work on active nematic turbulence, which we describe in the sections below.


The free energy $cal(F)$ of a passive nematic is a functional of the order parameter. The free energy per unit volume $F$ is split into two terms @DeGennes-Prost @Doostmohammadi2018 #cite(<Thampi2016a>): the Maier-Saupe free energy $F_(upright("MS"))$ describes the isotropic-nematic transition and it depends only on the order parameter $bold(Q)$\; the Frank free $F_(upright("F"))$ energy describes the orientational elasticity of the nematic and it depends on the gradients of $bold(Q)$.


Deep in the nematic phase, the amplitude of the order parameter is $S = 1$, and it is sufficient to describe the nematic order by the director orientation, given by its angle $theta$ in two dimensions. The free energy then reduces to the Frank contribution. In the one-constant approximation @DeGennes-Prost, it reads $F_(upright("F")) = K / 2 ( bold(nabla) bold(Q) )^2$, where $K$ is the Frank elastic constant. The relaxation of this energy is driven by the so-called orientational field $bold(h) = - frac(delta cal(F), delta bold(n))$. In two dimensions, its component perpendicular to $bold(n)$ is $h_perp = K nabla^2 theta$ @DeGennes-Prost, which tends to make the director relax to a uniform configuration.


In addition to relaxing according to the orientational field, the nematic order parameter is also advected by the flow $bold(v)$, co-rotated by the vorticity $bold(omega) = bold(nabla) times bold(v)$, and it realigns in response to shear, which is described by the symmetric shear-rate tensor $u_(i j) = 1 / 2 ( partial_i v_j + partial_j v_i )$. Taking all these effects into account, the dynamics of the director field is given by


$ partial_t bold(n) + bold(v) dot.op bold(nabla) bold(n) + 1 / 2 bold(omega) times bold(n) = bold(h) / gamma - nu bold(u) dot.op bold(n) . $<eq-director>


Here, $gamma$ is the rotational viscosity, and $nu$ is the flow-alignment parameter. This parameter depends on the shape of the nematic particles: $nu < 0$ for rod-like or prolate particles, and $nu > 0$ for disk-like or oblate particles. If $| nu | > 1$, the director tends to align at a fixed angle with respect to the shear. In contrast, for $| nu | < 1$, bulk passive nematics exhibit the so-called tumbling instability whereby the director rotates without settling at any particular angle. @eq-director specifies the director dynamics when nematic order is fully described by the director field, and for an incompressible nematic ($bold(nabla) dot.op bold(v) = 0$). The structure of the equation for the full order parameter is very similar, see Refs. @Doostmohammadi2018 @Thampi2016a. The main difference is that all the transport coefficients defined above depend on the amplitude $S$ of the order parameter.


The hydrodynamic theory of passive nematics has been generalized to active nematics @Kruse2005 @Marchetti2013 @Prost2015 @Julicher2018. In this case, the stress tensor can be decomposed into active and passive contributions: $bold(sigma) = bold(sigma)_(upright("pas")) + bold(sigma)_(upright("act"))$. The passive stress includes the pressure $P$, three elastic contributions, and the viscous stress: $bold(sigma)_(upright("pas")) = - P bold(I) + bold(sigma)_(upright("E")) + bold(sigma)_(upright("a")) + bold(sigma)_nu + bold(sigma)_(upright("v"))$. The Ericksen stress $bold(sigma)_(upright("E"))$ is a non-isotropic contribution to the pressure; in two dimensions, it is given by $sigma_(upright("E"))^(i j) = K partial_i theta partial_j theta - K / 2 | bold(nabla) theta |^2 delta_(i j)$. The antisymmetric stress $sigma_(upright("a"))^(i j) = 1 / 2 (n_j h_j - n_j h_i)$ arises from torques associated with the conservation of angular momentum. The third elastic term is the conjugate to the flow-alignment term in @eq-director: $sigma_nu^(alpha beta) = nu / 2 (n_i h_j + n_j h_i)$. An incompressible nematic has three independent viscosities that we assume here equal and given by $eta$. The viscous stress is then $bold(sigma)_(upright("v")) = 2 eta bold(u)$ , where $bold(u)$ is the symmetric shear-rate tensor defined above. Finally, the active stress is proportional to the orientational tensor: $bold(sigma)_(upright("act")) = - zeta bold(Q)$. It is extensile along the direction of the director for $zeta > 0$, and it is contractile for $zeta < 0$.


These constitutive equations must then be completed by the conservation laws. Here, we focus on systems at low Reynolds numbers, for which inertia is negligible. Force balance then reads


$ partial_i sigma^(i j) = 0 . $<eq-stress>


For dry systems, in contact with a substrate or environment, the right-hand side of @eq-stress would include additional forces such as friction or active traction, as we discuss in @dry-nematics.


=== Spontaneous-flow instability
<spontaneous-flow>


One of the general properties of active nematics is that the quiescent steady state with uniform director field is unstable, leading to spontaneous flows @Voituriez2005 @Simha2002 @Edwards2009. The growth rate of orientational perturbations around the uniform state, with a wave vector $bold(q)$ at an angle $phi.alt$ from the director, is given by @Duclos2018


$ Omega ( q ) = frac(zeta cos 2 phi.alt ( 1 - nu cos 2 phi.alt ), 2 (eta + gamma nu^2 sin^2 2 phi.alt / 4)) - frac(K q^2, gamma) frac(eta + gamma / 4 ( nu^2 - 2 nu cos 2 phi.alt + 1 ), eta + gamma nu^2 sin^2 2 phi.alt / 4) . $


This growth rate turns positive at long wavelengths (Fig. 4a), in a way that depends on the angle $phi.alt$ between the director and the wave vector. For $phi.alt = 0$, the perturbations are along the direction of alignment, corresponding to bend distortions of the director field (Fig. 4b left). In this case, the quiescent state is unstable if $zeta ( 1 - nu ) gt.eq 0$. Thus, for rod-like objects ($nu < 0$), the instability to bend distortions occurs for extensile active stresses ($zeta > 0$, Fig. 4b left). For $phi.alt = pi / 2$, the perturbations are perpendicular to the direction of alignment, corresponding to splay distortions of the director field (Fig. 4b right). In this case, the instability occurs if $zeta ( nu + 1 ) lt.eq 0$. Thus, for rod-like objects, splay distortions produce an instability if active stresses are contractile ($zeta < 0$, Fig. 4b right). In all cases, the instability is based on the following mechanism: a director perturbation produces active forces, given by $bold(nabla) dot.op bold(sigma)_(upright("act")) = - zeta bold(nabla) dot.op ( bold(n) bold(n) )$, which drive flows that further distort the director, amplifying the original perturbation (Fig. 4b). Director distortions offer less resistance for longer wavelengths, and hence the maximal growth rate is found at $q arrow.r 0$ (Fig. 4a). As a result, right past the instability threshold, the pattern of spontaneous flows has a wavelength given by the system size.


Overall, active nematics are generically unstable at long wavelengths. The critical wave number $q_(upright("c")) = ell_(upright("a"))^(- 1) f ( nu , eta / gamma , phi.alt )$ is mainly set by so-called active length $ell_(upright("a")) = sqrt(K / | zeta |)$, above which active stresses overcome the restoring elastic stresses of the nematic. As activity increases, the active length decreases, and hence the band of unstable modes becomes wider (Fig. 4a).


=== Dimensionless numbers and the high-activity limit
<dimensionless>


Finally, the hydrodynamic equations of active nematics that we have introduced can be made dimensionless by rescaling lengths by the system size $L$, time by the active time $tau_(upright("a")) = eta / | zeta |$ (Fig. 4a), and stresses by the active stress coefficient $| zeta |$. The equations then contain only three dimensionless parameters: the viscosity ratio $gamma / eta$, the flow-alignment parameter $nu$, and the activity number $A = (L / ell_(upright("a")))^2$.


Active turbulence occurs in the limit of high activity number, corresponding to large systems and/or large active stresses. In this limit, among the three elastic contributions to the stress (see @nematic-hydrodynamics), only the flow-alignment term is not negligible with respect to the active stress at length scales larger than $ell_(upright("a"))$. This is because all stresses proportional to the Frank constant $K$ (including via $h_perp$) scale like $1 / A$, and only $h_parallel$ yields non-vanishing contributions at high activity. To obtain $h_parallel$, we project @eq-director on the director, which gives $h_parallel = gamma nu med bold(n) dot.op bold(u) dot.op bold(n)$. Using this result, we express the flow-alignment stress as $bold(sigma)_nu = gamma nu^2 ( bold(n) dot.op bold(u) dot.op bold(n) ) ( bold(n) bold(n) )$. This expression shows that this elastic stress is equivalent to a viscous stress with an anisotropic viscosity tensor. Therefore, we expect it not to modify the scaling properties of active nematic turbulence, which we discuss next.


== Wet systems
<wet-nematics>


=== Transition to turbulence
<transition-turbulence>


Turbulence in active nematics ultimately emerges from the spontaneous-flow instability described in @spontaneous-flow. Right past the instability threshold, the instability leads to steady states with periodic flow patterns. As activity is increased, smaller-wavelength modes become unstable (Fig. 4a), which destabilizes the roughly-uniform regions in the flow patterns. Thus, starting from a uniform state, the system experiences a sequence of instabilities that lead to steady states with vortex patterns. Finally, at high activity, flows become unsteady, creating spatio-temporal chaos. This scenario for the transition to turbulence based on a sequence of instabilities was recently illustrated in simulations without topological defects @Alert2020a, and it is consistent with experimental observations on microtubule suspensions @Martinez-Prat2019.


Previous work had uncovered an overall similar picture, albeit enhanced by the presence and dynamics of topological defects, i.e. singular points of the nematic order @kleman1989. In two-dimensional nematics, the lowest-energy defects are those with topological charge $+ 1 / 2$ and $- 1 / 2$. Because of their different structures, $+ 1 / 2$ defects are propelled by active forces whereas $- 1 / 2$ defects are not @Doostmohammadi2018 @Aranson2019. This effect facilitates the proliferation of defects in active nematics. When an active nematic spontaneously flows, it generates sharp walls with a steep gradient of the director field separating nematic domains. As the activity increases, the walls decay into pairs of $+ 1 / 2$ and $- 1 / 2$ defects @Thampi2014a @Thampi2014b @Thampi2016a, which can unbind because of the self-propulsion of $+ 1 / 2$ defects. This process was first observed in experiments with active microtubule suspensions @Sanchez2012, and then studied numerically @Giomi2013 @Giomi2014a and theoretically @Shankar2018. In recent years, the defect dynamics has been extensively characterized in several experimental realizations of active nematics @Doostmohammadi2018.


The emergence of defects locally destroys the nematic order, which can be restored by the annihilation of pairs of opposite-sign defects. At high activity, the continuous creation and annihilation of defect pairs drives the chaotic formation and destruction of nematic domains, leading to active turbulence. This process has therefore been analyzed in terms of the rates of creation and annihilation of defect pairs, whose balance gives the steady-state defect density @Thampi2013 @Thampi2014b @Giomi2015.


The transition to turbulence in active nematics has also been studied in confined systems, for example in channels @Fielding2011 @Shendruk2017 @Doostmohammadi2019 @Doostmohammadi2017 @Hardouin2019a. As in unconfined systems, defect pairs are also generated above a critical activity. Under confinement, however, the defects organize in space and exhibit coordinated motions along an array of vortices rotating in alternating directions @Shendruk2017 @Doostmohammadi2019, as recently observed in microtubule experiments @Hardouin2019a. Further increasing the activity, the final transition from vortex arrays to chaotic flows occurs through the intermittent appearance of locally disordered flow patches, known as active puffs. Below a critical activity, these puffs split and decay. Above a critical activity, however, the active puffs percolate through the channel, corresponding to the emergence of turbulence. As a function of the distance to the critical activity, the active-puff fraction grows as a power law, with an exponent that coincides with that of the direct percolation universality class @Doostmohammadi2017. Overall, the intermittent-like behavior and the connection to critical phenomena is reminiscent of similar phenomena in the transition to inertial turbulence in channels @Frisch1995 @Rose1978 @Falkovich2006. Thus, future work along these lines might reveal further connections between active and inertial turbulence.


// [figvision-cn] imgs/Fig4.png
// 该图包含七个子图（a 至 g），展示了湿活性向列流体中的活
// 性湍流特性。 子图 a：曲线图。横坐标为波数 q，纵坐标为
// 增长率 Ω。图中有一条红色实线曲线，表示取向场扰动的增长
// 率随波数的变化关系。曲线从左侧高正值开始，随着 q 增加
// 而下降，在 q_c 处穿过横轴变为负值。图中标注了 q_c ∼ ℓ
// _a⁻¹，表示临界波数与活性长度成反比；左侧标注了 ~ ζ/η，
// 表示长波极限下的增长率与活性系数和粘度的比值相关。结论
// 是系统存在长波不稳定性，且活性增强会扩大不稳定模式的范
// 围。 子图 b：示意图。分为左右两部分，分别展示“伸展型”
// （Extensile）和“收缩型”（Contractile）活性机制。左侧伸
// 展型：两个黑色箭头背向排列，中间有四个浅蓝色小箭头指向
// 外，上下各有一个红色星号标记缺陷位置。右侧收缩型：两个
// 黑色箭头相向排列，中间有四个浅蓝色小箭头指向内，上下各
// 有一个红色星号标记缺陷位置。该图示意说明由取向扰动产生
// 的流动模式依赖于活性类型。 子图 c：显微照片或数值模拟
// 快照。左侧标题为“Schlieren texture”，显示黑白灰度图像，
// 呈现复杂的条纹状纹理，代表向列相的拓扑缺陷结构。右侧标
// 题为“Vorticity”，显示彩色涡度场，颜色从蓝（负涡度）到
// 红（正涡度），中间经过绿黄过渡，反映局部旋转强度分布。
// 两幅图并排对比，揭示缺陷结构与涡旋场的空间对应关系。
// 子图 d：曲线图。横坐标为涡旋面积 a/L²（无量纲），纵坐
// 标为涡旋数量 n(a)/Δa（对数刻度）。图中三条曲线分别对应
// 不同活性水平 |α|/Σ × 10³ = 4（黑）、6（红）、8（蓝），
// 均呈幂律衰减趋势。右上角插图显示归一化后的 ω_r τ vs. a
// /L² 曲线，三条曲线几乎重合，表明在不同活性下涡旋寿命与
// 尺寸的关系具有标度不变性。结论是活性增强导致更多小尺度
// 涡旋出现。 子图 e：复合图。左侧为曲线图，横坐标为波数
// q/q_min，纵坐标为 Frank 能量 E_s(q)（单位 10⁶），蓝色
// 曲线在 q_i 处出现峰值，之后快速衰减。右侧为 director
// angle 色图，用彩虹色谱（从紫 π 到红 0）表示取向角分布，
// 背景为杂乱多色区域，体现湍流态下的取向无序性。虚线 q_i
// 贯穿左右，指示特征波数。结论是在该波数附近弹性储能最大，
// 对应主导的不稳定模态。 子图 f：曲线图。横坐标为波数 q/
// q_min（对数刻度），纵坐标为能谱 E(q)（对数刻度）。红色
// 实线为实测能谱，黑色虚线为理论拟合，标注 ~ q⁻¹ 段（低
// 波数区）和 ~ q⁻⁴ 段（高波数区）。垂直虚线 q_i 标记转折
// 波数。结论是能谱在惯性区间遵循 -1 次方律，在高耗散区遵
// 循 -4 次方律，符合活性湍流的标度行为。 子图 g：曲线图。
// 横坐标为波数 q/q_min，纵坐标为功率谱（单位 10⁶）。四条
// 曲线分别代表：橙色“Active injection”（主动注入）、绿色
// “Shear dissipation”（剪切耗散）、紫色“Rotational
// dissipation”（旋转耗散）、灰色“Energy transfer”（能量
// 传递）。所有曲线在 q_i 处有显著特征：主动注入在此达到
// 峰值，剪切耗散在此达到谷值（负值），其他两项较小。左侧
// 标注“Sources”（源）和“Sinks”（汇），表明在 q_i 附近能
// 量主要由活性注入驱动，并通过剪切耗散移除。结论是能量在
// 特定波数尺度上被高效注入并耗散，形成非平衡稳态。
#figure(placement: top, [#block[
  #box(image("imgs/Fig4.png", width: 120.0%))

  ]],
  caption: [
    #strong[Active turbulence in wet nematic fluids]. a, Growth rate of director perturbations in wet active nematics. As discussed in the text, the system can exhibit a long-wavelength instability, with a critical wavelength proportional to the active length $ell_(upright("a"))$. Increasing activity therefore widens the range of unstable modes. b, Schematic of the instability mechanism. Flows generated by director perturbations further rotate the director field, amplifying the initial perturbation. Extensile systems can be unstable to longitudinal (bend) perturbations; contractile systems can be unstable to transverse (splay) perturbations. Adapted from @Maitra2018. c, Snapshots of the director and the vorticity fields in simulations of active nematic turbulence. The director is represented by the Schlieren texture (see @DeGennes-Prost), with $+ 1 / 2$ and $- 1 / 2$ defects indicated in red and blue, respectively. d, Distribution of vortex areas in simulations show an exponential tail. The vorticity of individual vortices is rather independent of vortex size (inset). Panels c and d adapted from @Giomi2015. e, Spectrum of the Frank elastic energy of the director field in simulations of active nematic turbulence. The peak at $q_(upright("i"))$ is related to the characteristic size of the vortices and director domains shown in the inset. f, Energy spectrum in simulations of active nematic turbulence feature scaling regimes with universal exponents both above and below the characteristic vortex size. g, Spectra of the contributions to the energy balance in simulations of a minimal model of wet active nematics. There is no energy transfer across scales; the energy injected at each scale is dissipated at that same scale by the combined effects of shear and rotational viscosity. Panels e to g adapted from @Alert2020a.
  ]
)
<Fig4>



=== Scaling with universal exponents
<scaling-nematics>


Fully-developed active turbulence arises in the limit of high activity number. In two dimensions, the turbulent state appears as a disordered array of swirling regions, which are strongly coupled to defects of the nematic order (Fig. 4c). In this section, we focus on the structure and statistical properties of the flow and the director's orientation patterns.


Giomi analyzed the turbulent regime in two-dimensional simulations (with parameters $nu lt.double 1$ and $gamma tilde eta$), focusing first on the statistical properties of the vorticity pattern @Giomi2015. Vortices are identified as regions where the so-called Okubo-Weiss parameter, which measures the local Lyapunov exponent, is negative. The statistics of the vortex areas $a$ is well described by an exponential distribution $p ( a ) tilde exp ( a / a_(*) )$ (Fig. 4d), whose characteristic vortex area $a_(*) = pi R_(*)^2$ defines the average vortex radius $R_(*)$. This characteristic vortex size is proportional to the active length $ell_(upright("a"))$, which is the only intrinsic length scale @Hemingway2016a (see @spontaneous-flow and Fig. 4a). Simulations also show that the individual vortices have a vorticity $omega_0$ that is rather independent of their size (Fig. 4d inset), and which is inversely proportional to the active time (see @dimensionless): $omega_0 tilde tau_(upright("a"))^(- 1) tilde | zeta | / eta$.


Based on these observations, Giomi describes the turbulent state by making two assumptions #cite(<Giomi2015>): (i) the absolute value of the vorticity is uniform and equal to $omega_0$ inside each vortex, and (ii) vortices are not correlated, which corresponds to a mean-field approximation. Averaging over the vortex area distribution, these two assumptions allow to calculate the spectrum of the enstrophy $Omega = integral 1 / 2 bold(omega)^2 ( bold(r) ) thin upright(d) bold(r) = integral frac(upright("dq"), 4 pi^2) thin tilde(Omega) ( q )$, which characterizes the vorticity distribution in Fourier space. This calculation shows that the enstrophy spectrum $tilde(Omega) ( q )$ features two scaling regimes. At scales smaller than the characteristic vortex size ($q R_(*) gt.double 1$), it scales as $tilde(Omega) ( q ) tilde q^(- 2)$, and at large scales ($q R_(*) lt.double 1$), it scales as $tilde(Omega) ( q ) tilde q$. Finally, the spectrum of the kinetic energy per unit mass density $E = integral 1 / 2 bold(v)^2 ( bold(r) ) thin upright(d) bold(r) = integral frac(upright("dq"), 4 pi^2) thin tilde(E) ( q )$ is directly related to the enstrophy spectrum: $tilde(E) ( q ) tilde tilde(Omega) ( q ) / q^2$. Therefore, the predicted scaling laws are $  & tilde(E) ( q ) tilde q^(- 1) & upright("for") #h(0em) q R_(*) lt.double 1 , \
    & tilde(E) ( q ) tilde q^(- 4) & upright("for") #h(0em) q R_(*) gt.double 1 . $ <eq-spectrum> The scaling at small scales is well observed in Giomi's simulations @Giomi2015. However, the activity number was not large enough to observe the scaling at large scales.


More recently, Alert et al. have performed simulations in two dimensions (with $nu = 0$ and $gamma tilde eta$) at much higher activity number, reaching $A = 3.5 times 10^5$ @Alert2020a. This study formulated a minimal theory that considers only the nematic orientation angle, assuming a fixed strength $S = 1$ of the order parameter as we introduced in @nematic-hydrodynamics. Thus, this formulation does not allow for the spontaneous creation of defects. Yet, simulations show disordered patterns of elongated orientation domains that exhibit persistent dynamics that looks chaotic in both space and time (Fig. 4e inset). The orientational pattern is statistically isotropic and has a characteristic wavelength proportional to the active length $ell_(upright("a"))$, as revealed by the spectrum $tilde(F) ( q )$ of the elastic Frank free energy $cal(F) = integral 1 / 2 | bold(nabla) theta |^2 upright(d) bold(r) = integral frac(upright("dq"), 4 pi^2) thin tilde(F) ( q )$, which is peaked around a wave number $q_(upright("i")) tilde 1 / ell_(upright("a"))$ (Fig. 4e). At larger scales ($q arrow.r 0$), the spectrum of the director angle scales as $chevron.l | tilde(theta) ( q ) |^2 chevron.r tilde q^0$, meaning that angle correlations decay over the active length $ell_(upright("a"))$, consistent with the existence of orientational domains of this characteristic size.


Regarding the flow spectrum, the simulations by Alert et al. reached sufficiently high activity to clearly show the two scaling regimes of @eq-spectrum, separated by a crossover at $q_(upright("i")) tilde 1 / ell_(upright("a"))$ @Alert2020a (Fig. 4f). Complementary to the calculations leading to @eq-spectrum, the large-scale scaling $tilde(E) ( q ) tilde q^(- 1)$ can be predicted in the high-activity limit via the following argument. At distances large compared to $ell_(upright("a"))$, director correlations can be considered as short range. Hence, the only non-vanishing contribution to the elastic stress, $bold(sigma)_nu$ (see @dimensionless), can be locally averaged over the director orientation, giving $chevron.l bold(sigma)_nu chevron.r = gamma nu^2 chevron.l ( bold(n) dot.op bold(u) dot.op bold(n) ) ( bold(n) bold(n) ) chevron.r = 2 frac(gamma nu^2, 8) bold(u)$. The elastic stresses therefore renormalize the shear viscosity to $eta_(upright("eff")) = eta ( 1 + frac(gamma nu^2, 8 eta) )$.


The statistical properties of the flow can then be predicted from the equation for the vorticity, which can be derived by taking the curl of the force balance @eq-stress. Using dimensionless variables, and in the high-activity limit, the vorticity equation reads


$ (1 + frac(gamma nu^2, 8 eta)) nabla^2 omega = upright("sgn") ( zeta ) [1 / 2 [partial_x^2 - partial_y^2] sin 2 theta - partial_(x y)^2 cos 2 theta] . $<eq-vorticity>


This is a Poisson equation with a source that depends only on the director's angle $theta$. As argued above, at large scales, the angle can be considered considered as a random variable which is delta-correlated in space. However, the propagator of the Laplace operator in @eq-vorticity is long-ranged (varying with distance as $log r$ in two dimensions), reflecting the long-range nature of hydrodynamic interactions. As a result, short-range angle correlations can lead to long-range correlations of the flow field. Accordingly, using $chevron.l | tilde(theta) ( q ) |^2 chevron.r tilde q^0$ in @eq-vorticity in Fourier space leads to $chevron.l | tilde(omega) ( q ) |^2 chevron.r tilde q^0$. Finally, this result leads to the scaling of @eq-spectrum, $tilde(E) ( q ) tilde q^(- 1)$, which corresponds to a velocity correlation function $chevron.l bold(v) ( 0 ) bold(v) ( r ) chevron.r tilde frac(K | zeta |, eta_(upright("eff"))^2) log r$.


These results establish that active nematic turbulence exhibits a universal scaling regime at large scales. The scaling exponent is universal: it does not depend on the sign of the active stress; it is observed in simulations for both contractile and extensile stresses. It is also independent of the flow-alignment parameter $nu$ and of the viscosity ratio $gamma / eta$. Furthermore, the defect-free simulations also demonstrate that the scaling properties of active nematic turbulence are not sensitive to the existence of topological defects @Alert2020a. Finally, recent microtubule suspension experiments are consistent with the predicted scaling regimes @Martinez-Prat2021 (Fig. 1f).


So far, our discussion has been restricted to two-dimensional turbulence, which has been the primary focus of both experimental and theoretical work. However, some experimental systems are three-dimensional. In fact, the scaling arguments above can be extended to three dimensions, predicting $tilde(E) ( q ) tilde q^0$ and $tilde(E) ( q ) tilde q^(- 3)$ at scales respectively larger and smaller than the typical vortex size. These scalings have also been predicted in the context of microswimmer suspensions. Below the onset of collective motion, Bárdfalvy et al. proposed to treat swimmers as hydrodynamically-interacting force dipoles @Bardfalvy2019a. Assuming that the dipoles undergo random reorientations, the theory indeed predicts a plateau of the energy spectrum at large scales, $tilde(E) ( q ) tilde c kappa^2$, where $c$ is the swimmer concentration and $kappa$ is the strength of the force dipoles.


Finally, these scaling laws for 3D flows, $tilde(E) ( q ) tilde q^0$ and $tilde(E) ( q ) tilde q^(- 3)$, have been recently found in bacterial suspensions experiments @Liu2020 (Fig. 1d). At first sight, this finding is surprising because bacterial turbulence has been successfully modeled using theories for polar fluids (@polar and Fig. 1a), including recent generalizations to account for density inhomogeneities @Worlitzer2021. Yet, these results suggest that, at least below the onset of collective motion, the spectra in 3D are well described by the hydrodynamics of active nematics (@nematic and Fig. 1d). Understanding if and how polar and nematic theories capture different regimes of bacterial turbulence in a consistent way will require further work.


=== Absence of energy cascades
<cascades>


A hallmark of inertial turbulence is the existence of an energy cascade. In three dimensions, the kinetic energy injected by the driving at large scales is transported across the inertial range of scales until it is dissipated by viscous effects at small scales. The cascade is therefore called #emph[direct]: from large to small scales @Kolmogorov1991 @Frisch1995 @Rose1978 @Falkovich2006. In two dimensions, however, the injected energy is transferred to larger scales; the energy cascade is #emph[inverse] @Rose1978 @Kraichnan1980 @Boffetta2012 @Falkovich2006.


The situation in active fluids is entirely different. Recent work has revealed that there is no energy cascade in active nematic turbulence @Alert2020a @Urzay2017 @Carenza2020b. Alert et al. derived the spectral energy balance in an active nematic fluid, which has four contributions #cite(<Alert2020a>):


$ partial_t tilde(F) ( q ) = - tilde(D)_(upright("s")) ( q ) - tilde(D)_(upright("r")) ( q ) + tilde(I) ( q ) + tilde(T) ( q ) . $<eq-energy-balance>


The left-hand side corresponds to the power spectrum of the Frank elastic energy. The right-hand side contains, in order, the power spectra of the shear viscous dissipation ($2 eta bold(u)^2$), the rotational viscous dissipation ($bold(h)^2 / gamma$), the injection of energy by the active stress ($sigma_(upright("act"))^(i j) u_(i j)$), and the energy transfer between scales, whose integral over $q$ vanishes in the steady state due to energy conservation. The simulation results showed that energy is injected at all scales, but primarily at the characteristic scale $q_(upright("i")) tilde ell_(upright("a"))$ of the vortex and orientation patterns (Fig. 4g). Moreover, the simulations also revealed that, in the absence of flow alignment ($nu = 0$), all the energy injected at a given scale is dissipated at that same scale. Therefore, there is no energy left to be transferred to other scales, and hence there is no energy cascade @Alert2020a (Fig. 4g). The numerical results by Urzay et al. and Carenza et al. are consistent with this conclusion @Urzay2017 @Carenza2020b.


Beyond the numerical results, an integral expression for the energy transfer spectrum $T ( q )$ can be derived from the director dynamics. The advection of the director field in @eq-director gives rise to potential energy transfer across scales. However, symmetry arguments show that this contribution to the energy transfer vanishes identically for the statistically-isotropic turbulent state @Alert2020a. Besides advection of the director, flow-alignment and other elastic stresses yield additional contributions to the energy transfer, which may be significant at scales comparable to the active length $ell_(upright("a"))$. Indeed, recent simulations by Carenza et al. have uncovered some energy transfer at intermediate scales due to elastic stresses @Carenza2020b. However, they did not find the scaling regime $tilde(E) ( q ) tilde q^(- 1)$ at large scales (see @scaling-nematics and Fig. 4f), possibly due to not reaching sufficiently high activity numbers.


In fact, we expect the spectral energy balance to be simpler in the high-activity limit and in the scaling regime. By the same arguments given in @dimensionless, rotational dissipation scales like $1 / A$ and hence becomes negligible in front of shear dissipation and injection. Similarly, the elastic contributions to energy transfer also scale like $1 / A$ and therefore also become negligible. Finally, as also argued in @dimensionless and @scaling-nematics, the flow-alignment contribution amounts to a renormalization of the shear viscosity. Thus, the emerging picture at high activity is that, in the scaling range, there is a simple scale-by-scale balance between energy injection and the renormalized viscous dissipation. At intermediate scales of order $tilde ell_(upright("a"))$, where most energy injection and dissipation takes place, there can be energy transfer due to both flow-alignment and elastic nonlinearities. Testing these predictions, both in simulations and in experiments, remains an important task for future work.


== Dry systems and the wet-dry crossover
<dry-nematics>


When interacting with a substrate or an external medium, the active fluid's momentum is not conserved, and hence the system is classified as dry @Marchetti2013 @Bar2020 @chate2020. Active turbulence in dry nematics can occur in systems of particles or rods with nematic interactions and whose concentration can vary. Microscopic models of these systems can be coarse-grained to obtain hydrodynamic equations for the order parameter and the density fields. Numerical work on these equations has revealed a rich phase diagram that includes regimes of spatiotemporal chaos @Ngo2014a @Putzig2016 @Maryshev2019 @Patelli2019a @Bar2020 @chate2020. The chaotic behavior arises from the unstable dynamics of nematic density bands. Thus, turbulence in these systems is associated with density segregation, and thus also with giant number fluctuations @Ngo2014a.


A different type of dry active turbulence occurs in incompressible nematic fluids. In this case, the theoretical description starts from the hydrodynamic theory that we presented in @wet-nematics, and extends the force balance @eq-stress to add interaction forces between the fluid and a substrate. These interaction forces may have both passive and active contributions, corresponding respectively to friction and traction forces. Friction comes in different types, which affect active turbulence in several ways that we discuss below. Before, we briefly introduce the active forces, whose role in active turbulence has not been particularly studied.


The functional form of interfacial active forces is dictated by nematic symmetry: $bold(f)^(upright("act")) = zeta_1 bold(n) bold(nabla) dot.op bold(n) + zeta_2 bold(n) dot.op bold(nabla) bold(n)$. If momentum were conserved, the coefficients $zeta_1$ and $zeta_2$ would have to be equal so that the active force results from the divergence of a symmetric stress, $bold(f)^(upright("act")) = zeta bold(nabla) dot.op ( bold(n) bold(n) )$, as in @nematic-hydrodynamics. However, if the fluid exchanges momentum with the substrate, $zeta_1$ and $zeta_2$ can be different from one another. Suprisingly, these active forces can stabilize nematic suspensions against the well-known spontaneous-flow instability of @spontaneous-flow @Maitra2018.


=== Substrate friction
<substrate-friction>


In nematic phases, friction can be anisotropic, with different coefficients for the directions parallel and perpendicular to the director $bold(n)$: $bold(f)^(upright("pass")) = - xi bold(v) + Delta xi thin bold(n) ( bold(n) dot.op bold(v) )$. In fact, friction anisotropy leads to asymmetries in the flow field around topological defects, which has been found to lead to cell accumulation at defects in monolayers of tissue cells @Kawaguchi2017 and bacteria @Copenhagen2021. Anisotropic friction can also organize otherwise chaotic flows into lanes with alternating directions @Thijssen2020, which had previously been discovered in experiments @Guillamat2016.


Even isotropic friction has a strong influence on active turbulence. Frictional dissipation dominates over viscous dissipation at length scales above the hydrodynamic screening length $lambda = sqrt(eta / xi)$, which therefore controls the crossover from wet to dry situations. This crossover has been studied in several simulations by adding friction to the hydrodynamic equations of active nematics (see @nematic-hydrodynamics) @Thampi2014 @Doostmohammadi2016 @Srivastava2016a @Oza2016 @Oza2016a @Doostmohammadi2019 @Coelho2020 @Thijssen2020b. As friction increases and the screening length gets closer to the active length $ell_(upright("a"))$ (see @spontaneous-flow), the number of defects actually first increases @Thampi2014 @Doostmohammadi2016 (Fig. 5a). In these conditions, recent simulations have observed turbulent flows whose energy spectrum features scaling regimes with exponents close to $5 / 3$ and $- 8 / 3$ @Coelho2020 (Fig. 5b). These scaling laws, however, are different than those obtained by extending the arguments presented in @scaling-nematics to include friction, which would predict $tilde(E) ( q ) tilde q^3$ at large scales $q lt.double lambda^(- 1)$ (see @external-fluid below and Fig. 5d). Future work is required to clarify this point.


// [figvision-cn] imgs/Fig5.png
// 子图 a：曲线图。纵轴名称为Number of defects，范围0到
// 100，无单位；横轴名称为Friction coefficient ξ，对数坐
// 标，范围10^-4到10^0，无单位。图中一条红色实线，带红色
// 圆形数据点，每个点配有垂直红色误差棒。标注文字包括纵轴
// Number of defects，横轴Friction coefficient ξ，纵轴刻
// 度0, 20, 40, 60, 80, 100，横轴刻度10^-4, 10^-3, 10^-2,
// 10^-1, 10^0。趋势：当ξ从10^-4增大至约10^-1时，缺陷数量
// 从约50上升至约90的峰值；ξ继续增大至10^0时，缺陷数量急
// 剧下降至0。结论：摩擦增加先使活性向流紊动中缺陷数增加，
// 随后摩擦阻尼并稳定流动，导致缺陷数骤减。 子图 b：曲线
// 图，双对数坐标。纵轴名称为Energy spectrum E(q)/E*，范
// 围10^-2至10^1以上，无单位；横轴名称为Rescaled wave
// number q/q*，范围10^-3到10^0，无单位。右下角图例显示三
// 条曲线分别对应ζ=0.005（绿色实线）、ζ=0.009（黄色实线）、
// ζ=0.013（蓝色实线）。标注文字包括纵轴Energy spectrum E
// (q)/E*，横轴Rescaled wave number q/q*，上升段标注5/3并
// 伴有点线参考斜率，下降段标注-8/3并伴有虚线参考斜率。趋
// 势：三条曲线在q/q*约0.05至0.1附近达到峰值，低波数段近
// 似呈q^{5/3}功率律增长，高波数段近似呈q^{-8/3}功率律衰
// 减。 子图 c：示意图，双对数相图。顶部标题Thick layer
// limit qH >> 1。纵轴名称为qℓ_v，范围0.01到100；横轴名称
// 为qR_*，范围0.01到100。右侧竖排文字将上半部标为
// Internal dissipation，下半部标为External dissipation。
// 图中水平虚线位于qℓ_v=1，垂直虚线位于qR_*=1，两条虚线构
// 成中心十字将图面划分为四个象限。顶部左侧水平箭头指向左
// 并标注Larger than vortex size，顶部右侧文字Smaller
// than vortex size，右侧竖排文字Length scale。四个象限内
// 的标注文字：左上象限（qR_*小于1，qℓ_v大于1）为E(q) ~ q
// ^-1；右上象限（qR_*大于1，qℓ_v大于1）为E(q) ~ q^-4；左
// 下象限（qR_*小于1，qℓ_v小于1）为E(q) ~ q；右下象限（
// qR_*大于1，qℓ_v小于1）为E(q) ~ q^-2。布局：以qR_*=1与q
// ℓ_v=1为边界，横向区分大于与小于涡旋尺度的波数范围，纵
// 向区分内耗与外耗主导区域。 子图 d：示意图，双对数相图。
// 顶部标题Thin layer limit qH << 1。纵轴名称为qℓ_v，范围
// 0.01到100；横轴名称为qR_*，范围0.01到100。右侧竖排文字
// 将上半部标为Internal dissipation，下半部标为External
// dissipation。水平虚线位于qℓ_v=1，垂直虚线位于qR_*=1，
// 划分四个象限。顶部左侧水平箭头指向左并标注Larger than
// vortex size，顶部右侧文字Smaller than vortex size，右
// 侧竖排文字Length scale。四个象限内的标注文字：左上象限
// 为E(q) ~ q^-1；右上象限为E(q) ~ q^-4；左下象限两行文字
// 为E(q) ~ q^3, no-slip 和 E(q) ~ q^-1, free；右下象限两
// 行文字为E(q) ~ q^0, no-slip 和 E(q) ~ q^-4, free。趋势：
// 该图划分了薄层极限下不同波数与长度尺度的能量谱幂律指数，
// 并区分了无滑移与自由边界条件下的不同耗散模式。
#figure(placement: top, [#block[
  #box(image("imgs/Fig5.png", width: 100%))

  ]],
  caption: [
    #strong[Active turbulence in dry active nematics and the wet-dry crossover]. a, As friction increases, the number of defects in active nematic turbulence first increases and then decreases sharply as friction damps and stabilizes the flow. Adapted from @Doostmohammadi2016. b, Energy spectrum in simulations of active nematic turbulence with friction. Adapted from @Coelho2020. These results show scaling regimes with exponents different than those predicted by theory. c,d, Scaling regimes predicted for an active nematic film in contact with a passive fluid layer. This is a common experimental setup @Martinez-Prat2021. The scaling regimes are classified in terms of three lengths: the thickness of the passive fluid layer $H$ (panel c vs d), the average vortex size $R_(*)$, and the viscous length $ell_(upright("v")) = eta / eta_(upright("ext"))$ above which dissipation is dominated by the external passive fluid. For thin external layers (d), some of the scaling laws depend on whether the external fluid has a free surface or is in contact with a solid substrate (no-slip boundary condition). From @Martinez-Prat2021.
  ]
)
<Fig5>



When friction becomes strong enough to screen the flow over distances comparable and even lower than the active length $ell_(upright("a"))$, the number of defects decreases sharply (Fig. 5a). Friction then stabilizes the flow into vortex lattices, and it organizes defects into dynamic yet positionally and orientationally ordered structures @Doostmohammadi2016 @Oza2016 @Oza2016a @Thijssen2020b @Putzig2016 @Patelli2019a @Srivastava2016a. These structures are reminiscent of ordered phases of defects reported in microtubule suspensions experiments @DeCamp2015 @Pearce2020. In this same context, other work has proposed to treat an active nematic as a fluid of defects @Shankar2019. Taking into account the active forces and torques between defects, Shankar and Marchetti developed a hydrodynamic theory of the defect fluid, and used it to predict transitions between a nematic, a chaotic, and a polar phase of defects @Shankar2019. Testing all these theoretical predictions and establishing the rich phase diagram of overdamped active nematics, including their defect phases, remains an experimental challenge for the future.


=== Interaction with an external fluid
<external-fluid>


Beyond substrate friction, recent work has studied the effects of a different type of external dissipation on active nematic turbulence @Martinez-Prat2021 @Thijssen2021. Instead of on a solid substrate, active nematic microtubule films can be assembled at an oil-water interface. Thus, the spontaneous flow in the active film induces flows in the adjacent passive fluids (oil and water) which, in turn, impact the flows in the active film via viscous forces. By varying the viscosity of the external oil, one can tune the external dissipation and vary the so-called viscous screening length $ell_(upright("v")) = eta / eta_(upright("ext"))$, above which external dissipation dominates. Therefore, this setup provides a way to probe the wet-dry crossover in experiments.


As oil viscosity was increased, experiments found slower defect motion and smaller vortices @Guillamat2016b. In recent experiments where the oil has a free surface, measurements of the energy spectrum have also revealed a new scaling regime $tilde(E) ( q ) tilde q$ at scales larger than the viscous length $ell_(upright("v"))$ @Martinez-Prat2021 (Fig. 1f). This result has been explained by generalizing the theoretical framework of @nematic-general and @wet-nematics to account for the viscous forces between the active film and the external fluids @Martinez-Prat2021. The generalized theory then fits the experimental spectra over a wide range of oil viscosities, and through scales across the wet-dry crossover @Martinez-Prat2021 (Fig. 1f). Besides explaining the measurements, the theory predicts up to six different scaling regimes, which are classified in terms of three lengths: the average vortex size $R_(\*)$, the viscous length $ell_(upright("v"))$, and the thickness $H$ of the external fluid layer (Fig. 5c and Fig. 5d). When the external layer is thin, the scaling laws also depend on its boundary conditions; no-slip conditions then correspond to the case of friction with a solid substrate discussed in @substrate-friction (Fig. 5d). Finally, while three scaling regimes were observed in Ref. @Martinez-Prat2021 (Fig. 1f), three additional scaling laws await experimental verification.


= Conclusions and outlook
<conclusions>


Since its origins in bacterial suspensions, the field of active turbulence has thrived. Chaotic flows at low Reynolds number have been observed in a wide variety of active fluids (@Fig1). Accordingly, different classes of theories have been developed to understand the statistical properties of these turbulent-like flows. Here, we have reviewed all these scenarios, highlighting their similarities and differences, and their comparison with inertial turbulence. Although there is debate on the technical use of the term #emph[active turbulence], here we have employed it in a loose sense to denote chaotic active flows. We note, however, that these flows represent a broad class of phenomena, which are described by a variety of model equations rather than being a single well-posed problem as for inertial turbulence.


We classified this variety of active turbulences according to whether systems have either polar or nematic order, and to whether they are described by models where momentum is either conserved (wet) or not conserved (dry). These key features define different scenarios of the transition from steady to turbulent flows: While it proceeds through non-oscillatory instabilities and defect proliferation in nematic fluids (@transition-turbulence), it generally involves oscillatory phenomena for polar fluids (@active-polar-LC and @active-polar-suspensions and Fig. 3a and Fig. 3b). This oscillatory behavior arises from active self-advection of the polar order. In fact, this advective nonlinearity of polar fluids is parallel to the velocity self-advection responsible for inertial turbulence. Consequently, active polar fluids at zero Reynolds number share advective mechanisms of energy transfer with passive fluids at high Reynolds number. In contrast, nematic fluids at zero Reynolds number lack self-advection terms. Thus, energy transfer in nematics is solely due to other nonlinear effects such as flow alignment and elastic stresses.


Besides instabilities and energy transfer, the differences between polar and nematic active turbulence are apparent in their scaling properties. Similar to Kolmogorov's scaling of inertial turbulence, active turbulence is also characterized by the emergence of power laws in the energy spectrum. However, in flocking-type models of polar fluids, these power laws have parameter-dependent exponents; their scaling properties are therefore non-universal (@TTSH-scaling and Fig. 2d). This non-universality is due to the fact that, in addition to the self-advective nonlinearity, flocking-type models for polar fluid feature nonlinearities that allow for extra freedom in their spectra. In contrast, nematic fluids exhibit scaling laws with universal, parameter-independent exponents (@scaling-nematics and @external-fluid and Fig. 4f). In this case, there are a few possible sets of exponents given by integer numbers (Fig. 5c and Fig. 5d). Whether one or another set applies to a particular situation depends only on general properties of the system such as its dimensionality and the dominant mechanism of dissipation, including their wet or dry nature. A similar picture with universal exponents might apply to polar liquid crystals --- an issue to be addressed in future work. Altogether, in the bigger scheme of active matter physics, the scaling properties of active turbulence are a promising way of attaching simple numbers (exponents) to classes of active matter.


From this variety of scenarios, a generic picture of active turbulence emerges. In other forms of turbulence, including inertial and elastic, the fluid is driven externally by means of stirring, shaking, or shearing. Therefore, the spectrum of energy injection is externally imposed by the driving protocol. In contrast, active fluids are internally driven. Thus, the spectrum of energy injection is not imposed but results from a self-organized, autonomous process. Energy injection is therefore built into active turbulence equations in the form of terms that produce activity-driven instabilities. These instabilities feature characteristic length scales, which determine the primary scales of both energy injection and dissipation. Hence, active turbulence generally lacks energy cascades. The picture is strikingly different from that of inertial turbulence, where the scales of energy injection and dissipation are separated by a wide range of scales across which energy is transported. In this same range of scales, the energy spectrum behaves as a power law. In active turbulence, instead, injection and dissipation scales are not widely separated, and scaling regimes emerge not in between but on each side of the injection and dissipation scales.


Looking forward, this emerging picture still poses considerable challenges, for both theory and experiments. For example, future work is needed to clarify the regimes of applicability of the different theories. Perhaps the clearest example is that of bacterial suspensions, which have been described using both polar and nematic theories, and both in the wet and the dry limits. Other remaining tasks include searching for non-universal exponents in experiments, further characterizing the phase behavior and universal scaling regimes of active nematics, and beginning to do so in polar liquid crystals. Another important challenge across different systems is to experimentally measure elastic energy and energy transfer spectra, which also needs to be better understood theoretically.


Beyond these immediate challenges, we finish by outlining promising directions for future work. For example, the spectral properties of active turbulence in the time domain remain to be uncovered. In particular, the extent to which intermittency and anomalous exponents might be relevant in active turbulence is an open question. Along similar lines, analyzing active turbulence using metrics from chaos theory such as Lyapunov exponents and topological entropy @Tan2019 @Hashemi2021 might provide profound insights. Studying active turbulence on curved surfaces with different topologies, as in recent work @Mickelin2018 @Ellis2018, might also reveal qualitatively new spectral features.


Along a different direction, active turbulence in 3D remains relatively unexplored. This situation, however, might change in the near future. For example, recent experiments on microtubule suspensions have revealed complex dynamics of topological disclination loops in 3D @Duclos2020, which might soon enable experimental studies of 3D turbulence. On the numerical side, simulations had been previously used to study the crossover between 2D and 3D nematic turbulence @Shendruk2018. Fully in 3D, more recent simulations have analyzed the formation of defect loops and their entanglement in dense defect networks @Copar2019a @Binysh2020 @Krajnik2020. Understanding the connections between topological and flow structures in 3D and investigating their spectral properties are interesting avenues for future research.


Still in 3D, chirality generates active torques. As active forces, active torques and torque dipoles can induce flows and, for example, induce the rotation or translation of chiral active droplets @carenza2019. The effects of chirality on active turbulence have hardly been explored and might lead to surprising behaviors. Along these lines, recent work has shown that the spontaneous breaking of chiral symmetry leads to parity-violating Beltrami flows and an inverse energy cascade in 3D active fluids @Slomka2017 @Slomka2018.


Finally, it is appealing to think about the role of active turbulence in biological systems @Needleman2019. On the one hand, chaotic flows might have to be tamed by biochemical regulation to enable robust biological functions and development @Nishikawa2017a. On the other hand, biological systems might also exploit active turbulence to enhance mixing and transport, thus overcoming the limitations imposed by flow reversibility in low-Reynolds hydrodynamics @Groisman2001 @C.P.2020. When moving toward more complex biological systems, it will be interesting to understand how viscoelastic effects modify active turbulence @Hemingway2015 @Hemingway2016 @Liu2021, as well as to consider other forms of turbulence driven by active biochemical reactions in cells @Tan2020a.


#heading(level: 1, numbering: none, outlined: false)[Acknowledgments]
<acknowledgments>


We apologize to the many colleagues whose work could not be cited owing to space constraints. R.A. acknowledges support from the Human Frontier Science Program (LT-000475/2018-C). R.A. acknowledges discussions in the virtual "Active 20" KITP program, supported in part by the National Science Foundation under grant No. NSF PHY-1748958. J.C. acknowledges support by MINECO (project PID2019-108842GB-C21) and Generalitat de Catalunya (project 2017-SGR-1061).

#show bibliography: set par(spacing: 6pt, first-line-indent: 0pt)
#show bibliography: it => {
  set par(spacing: 1.1em)
  it
}
#bibliography("refs.bib", style: "../../typst-refs/aps-numeric.csl", title: [References])