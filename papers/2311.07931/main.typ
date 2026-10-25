// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.87cm, bottom: 2.36cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set heading(numbering: none)
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure(numbering: "1", supplement: [Fig.], placement: auto)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: n => "(" + str(n) + ")", supplement: [Eq.])

// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering): #it.body]
}

#figure(placement: top, scope: "parent", kind: "title", numbering: none,
  block(width: 100%)[
    #align(center)[
      #text(13pt, weight: "bold")[Two-dimensional non-Hermitian skin effect in an ultracold Fermi gas]
      #v(1.0em)
      #text(10pt)[Entong Zhao#super[1,\*], Zhiyuan Wang#super[2,\*], Chengdong He#super[1], Ting Fung Jeffrey Poon#super[2], Ka Kwan Pak#super[1], \
        Yu-Jun Liu#super[1], Peng Ren#super[1], Xiong-Jun Liu#super[2,3,4,†], Gyu-Boong Jo#super[1,5,‡]]
      #v(0.7em)
      #text(8pt)[#super[1] Department of Physics, The Hong Kong University of Science and Technology, Clear Water Bay, Kowloon, Hong Kong, China \
        #super[2] International Center for Quantum Materials, School of Physics, Peking University, Beijing 100871, China \
        #super[3] Hefei National Laboratory, Hefei 230088, China \
        #super[4] International Quantum Academy, Shenzhen 518048, China \
        #super[5] IAS Center for Quantum Technologies, The Hong Kong University of Science and Technology, Hong Kong, China]
    ]
    #v(1.0em)
    #align(center)[#block(width: 78%)[#text(9pt)[The concept of non-Hermiticity has expanded the understanding of band topology leading to the emergence of counter-intuitive phenomena. One example is the non-Hermitian skin effect (NHSE), which involves the concentration of eigenstates at the boundary. However, despite the potential insights that can be gained from high-dimensional non-Hermitian quantum systems in areas like curved space, high-order topological phases, and black holes, the realization of this effect in high dimensions remains unexplored. Here, we create a two-dimensional (2D) non-Hermitian topological band for ultracold fermions in spin-orbit-coupled optical lattices with tunable dissipation, which exhibits the NHSE. We first experimentally demonstrate pronounced nonzero spectral winding numbers in the complex energy plane with non-zero dissipation, which establishes the existence of 2D skin effect. Further, we observe the real-space dynamical signature of NHSE in real space by monitoring the center of mass motion of atoms. Finally, we also demonstrate that a pair of exceptional points (EPs) are created in the momentum space, connected by an open-ended bulk Fermi arc, in contrast to closed loops found in Hermitian systems. The associated EPs emerge and shift with increasing dissipation, leading to the formation of the Fermi arc. Our work sets the stage for further investigation into simulating non-Hermitian physics in high dimensions and paves the way for understanding the interplay of quantum statistics with NHSE.]]]
  ],
)

Hermiticity of a Hamiltonian that guarantees the conserved energy with real eigenvalues breaks down when a quantum system exchanges particles and energy with the environment~@ashida2020non. This open quantum system may be effectively described by a non-Hermitian Hamiltonian which is indeed a ubiquitous description of classical systems with gain and loss~@el2018non @helbig2020generalized @ezawa2019non @Zhou.2018 @ghatak2020observation @liu2021non, interacting electronic systems~@Kozii.2017 @Shen.2018 and optical quantum gas~@ozturk2021observation. Recently, the non-Hermitian concept has been further generalized to the periodic lattice system in which non-Hermiticity interplays with band topology and profoundly changes the band structure leading to novel features such as a bulk open-ended Fermi arc connecting two exceptional points (EPs) showing a half-integer topological charge~@Zhou.2018 @Bergholtz.2021.

One of the intriguing phenomena in non-Hermitian bands is the non-Hermitian skin effect (NHSE)~@yao2018edge @Yao.2018m9 @Kunst.2018 @Yokomizo.2019 @guo2021theoretical @zhou2021engineering @Li.2022hyn, involving the accumulation of eigenstates at the boundary of an open system. It has been noted that the conventional Bloch band theory breaks down with non-Hermiticity~@yao2018edge @Yao.2018m9 @Kunst.2018 @Yokomizo.2019 @guo2021theoretical @zhou2021engineering @Li.2022hyn, and the exceptional degeneracy has been pointed out as a precursor of the NHSE~@Kawabata.2019 @Zhang.2022. Numerous studies revisit the bulk-boundary correspondence by considering the interplay between band topology, symmetry, and NHSE, but most previous works have focused on the 1D configuration~@liang2022dynamic @weidemann2020topological @xiao2020non. Although the theoretical framework for understanding NHSE is mostly well-established in 1D~@Yokomizo.2019 @sato2020origin @GBZ2020, the NHSE in higher dimensions or with extra physical degrees of freedom---e.g. symmetry, long-range coupling, and band topology---are still limited both in theory and experiment~@hofmann2020reciprocal @zhang2021observation @zou2021observation @shang2022experimental @zhang2021observationOf @Li.2022hyn @zhou2023observation @wang2023experimental @wan2023observation.

Moreover, the higher-dimensional NHSE interplays with or could be mapped to various fundamental Hermitian scenarios in, e.g. a curved space~@duality2022 @Hermitization2022 @zhou2022curve, black holes~@spinblackhole2012 @Weylblackhole2022, quantum information~@entanglement2021 @Anomaly2021 @entangletrans2023, and higher-order topological phases~@Yokomizo2020second @highorder2020, which all necessitate the realization in many-body systems beyond one-dimension (1D). Experimentally, however, the simultaneous realization of exceptional degeneracy and the NHSE still remains to be a formidable challenge, especially unexplored in quantum systems, nor in higher dimensions. In particular, no fermionic system has been experimentally realized with non-Hermitian topological band.

// [figvision-cn] imgs/Fig1.png
// 子图a：示意图与光学晶格势分布图。左侧为实验光路布局的
// 三维示意图，显示一束水平向右传播的晶格光束（Lattice
// beam E_y，灰色，中心带白色圆点表示光束截面）沿y方向构
// 成一维光学晶格；另一束拉曼光束（Raman beam E_x，浅蓝色，
// 中心带黑色圆点）以与晶格入射光束成16°角斜向入射，两束
// 光在原点附近交叠。右上为晶格势V_latt沿y方向的截面图，
// 横轴为y、纵轴为x，蓝色竖条纹表示周期性格点，颜色越深势
// 能越高，右侧色标显示V_latt从低（浅蓝）到高（深蓝）。图
// 中以红色空心圆和白色空心圆标记两种自旋态在相邻格点间的
// 交替分布。右下为拉曼势的空间分布，横轴为y、纵轴为x，红
// 黑色调表示势能M_R的高低，色标从黑（低）到红（高），两
// 格点间以紫色和白色圆圈标记，另一色标显示相位Phase从黑
// 到白的变化。该图展示一维晶格与斜入射拉曼光共同产生周期
// 性拉曼势，并引入自旋依赖的格点结构。 子图b：流程图与能
// 带/自旋极化相图。从左至右依次为四个阶段：Quench（淬火）
// 后的三维能带曲面示意图，坐标轴为q_x、q_y与能量，灰色曲
// 面上标有D_1、D_2两点并以箭头标出；随后Oscillation（振
// 荡）阶段给出Gap（能隙）的二维强度图，横轴为q_y、纵轴为
// q_x，色标从黑（低）到红（高）表示能隙大小正比于δΦ，图
// 中D_1、D_2位于亮红色高能隙区域；接着Adiabatic loading
// （绝热加载）后得到平衡态三维能带曲面，蓝色和红色分别表
// 示不同自旋分量，曲面在D_1、D_2处交叉；最后Equilibrium
// （平衡）给出自旋极化二维图，横轴为q_y、纵轴为q_x，白色
// 虚线为对称轴，颜色由蓝（向下自旋）经白到红（向上自旋），
// 色标标出红色向上箭头与蓝色向下箭头，极化强度正比于δ，
// 图中显示以q_y=0为界左右两侧自旋极化相反。该图说明通过
// 淬火、振荡与绝热加载可探测并映射能带交叉点的能隙与自旋
// 极化分布。 子图c：实验与模拟对比的三维能带图。左侧为
// Experiment（实验），右侧为Simulation（模拟），两图结构
// 相同。坐标轴为q_x(k_x)、q_y(k_y)、能量E，垂直方向另标
// 极化Polarization从-1（蓝）到1（红）。图中绘出多条沿q_y
// 方向排列的能带曲线，颜色表示自旋极化：负极化（蓝）与正
// 极化（红）的能带在D_1、D_2处相交，黑色虚线连接交叉点形
// 成对角线，灰色虚箭头指向交叉位置。实验与模拟图均显示能
// 带在交叉点附近发生自旋极化反转，且两者形态高度一致，说
// 明实验观测到自旋-轨道耦合导致的能带交叉与极化结构。 子
// 图d：Hermitian（厄米）与Non-Hermitian（非厄米）系统对
// 比示意图。左半部分为Hermitian灰色背景区：最左为“Band
// in optical lattice”示意图，横轴为k_x(k_y)、纵轴为能量，
// 红蓝两条正弦曲线在动量空间交叉；经“Add SOC”箭头后，给
// 出不同参数δ(E_x)下的能带放大图，纵轴为δ(E_x)从-2.10到
// 1.40，横轴为q_y，红蓝曲线在δ(E_x)=-0.35与0.00附近出现
// 交叉与避免交叉，图中0.9、0.0等数字为标注；右侧经“Add
// loss”箭头过渡到Non-Hermitian蓝色背景区。非厄米部分左侧
// 为复能带图，横轴为q_y、纵轴为δ(E_x)，红蓝曲线在复平面
// 内分离；右侧四个小图分别展示：Band manipulation（能带
// 调控）给出Re[E]与Im[E]随γ_⊥变化的曲线，实线为实部、虚
// 线为虚部，显示随损耗增大能带实部合并、虚部劈裂；
// Spectral area（谱面积）给出Im[E]对Re[E]的参量曲线，红
// 蓝两个闭合环分别对应不同自旋；Skin effect（趋肤效应）
// 给出x-y平面内的二维强度分布图，颜色由白到深蓝表示粒子
// 密度，显示粒子在边界处积累。该图总结从厄米光学晶格到引
// 入损耗后的非厄米系统，能带由实谱转变为复谱并出现非厄米
// 趋肤效应。
#figure(placement: top, scope: "parent", block(width: 100%)[#image("imgs/Fig1.png", width: 80%)],
  caption: [
    *Hermitian and non-Hermitian system in an optical lattice with spin-orbit coupling* *a*, Our optical Raman lattice system, which consists of a 1D optical lattice along the y direction and another Raman beam along the direction with angle $76 degree$ tilted from the lattice incident beam, generating a periodic Raman potential. A loss beam with $sigma^(-)$ polarization is further applied along -z direction to realize the non-Hermiticity. *b*, Band structure after the quantum quench where the band gap can be extracted by the time evolution of spin polarization and the equilibrium spin polarization which can be obtained by adiabatically loading the atoms into the lowest energy band in the Hermitian optical Raman lattice. *c*, Experimental measurement and numerical simulation of spin polarization of equilibrium state as a function of two photon detuning $delta$. *d*, Band structure of the lowest two bands at different two-photon detuning values in the Hermitian optical Raman lattice. With increasing dissipation, atoms accumulate at the boundary of the system showing the non-trivial winding of eigenenergy in the complex energy plane. Furthermore, the energy band closes the gap at a specific quasi-momentum.
  ]
)
<fig-1>

Here, we realize 2D NHSE for a non-Hermitian topological band in ultracold Fermi gas by synthesizing dissipative spin-orbit coupling (SOC) in a Raman-dressed lattice~@song2018observation @liu2013manipulating. This platform allows observing both EPs and NHSE with dissipation implemented by the spin-selective atom loss~@ren2022chiral. With increasing dissipation, the Dirac point, where two bands linearly intersect, extends forming a bulk Fermi arc that connects two exceptional points. With the momentum-dependent Rabi spectroscopy, we probe the change of band gap versus dissipation strength and also the parity-time ($cal("PT")$) symmetry-breaking transition across the exceptional points. Evidence from both the direct measurement of spectral topology in the complex energy plane~@Zhang.2020k3c @Zhang.2022 and the observation of the dynamical signature of NHSE in real space supports the existence of a 2D skin effect being consistent with theoretical calculations. Our work makes also a step in experimentally studying how the band topology interplays with symmetry and non-Hermiticity in high dimensions.

= TUNABLE NON-HERMITIAN TOPOLOGICAL BAND

We generate a non-Hermitian topological band by combining a simple optical lattice along the y direction with a periodic Raman potential over the x-y plane as described in #ref(<fig-1>)a~@Liu.2014. Non-Hermiticity arises from the state-dependent atom loss, which enables controlled dissipation with the near-resonant optical transition. In the Hermitian regime without dissipation, a topological band in the y direction is spanned out over the x direction due to the momentum shift and spin-flip transition driven by the Raman potential~@song2019observation. As a result, two gapless Dirac points (indicated by $D_1 , D_2$ in #ref(<fig-1>)b) emerge in two ends of band inversion line where spin-up and spin-down subbands cross and thus are resonantly coupled through SOC (see #ref(<fig-1>)b and #ref(<fig-1>)c). The spin texture and relevant topological invariant can be directly measured by loading atoms adiabatically into the lowest energy band exhibiting non-trivial spin textures~@song2018observation (See Supplementary Information and #ref(<fig-1>)c).

In the non-Hermitian regime with dissipation on, however, the complex energy spectrum necessitates the spectroscopic measurement of the complex energy gap to identify real and imaginary parts of energy gap, corresponding to band gap and damping rate, respectively. The energy spectrum within the momentum space also allows us to obtain the _spectral topology_ of the system, leading to the observation of the NHSE~@yao2018edge @Yao.2018m9 @Kunst.2018 @Yokomizo.2019 @guo2021theoretical. In the current work, we probe the quench evolution of spin polarization within the energy band and elucidate non-Hermitian phenomena including the emergence of exceptional points and NHSE (See #ref(<fig-1>)d).

// [figvision-cn] imgs/Fig2.png
// 子图a为三幅并排的曲线图，横轴均为Hold time，单位为ms，
// 范围0.0至0.3；纵轴均为Spin polarization，范围-1.0至1.0。
// 三幅子图对应不同的损耗项γ₁：左图为0.0Eᵣ，中图为1.2Eᵣ，
// 右图为2.1Eᵣ。每幅图包含四组数据点（颜色由浅至深为浅蓝、
// 中蓝、深蓝、深灰），分别对应用于子图b中四个准动量点（q
// ₓ, kₓ）/k₀从(-0.8, -0.2)到(0.2, 0.6)的位置；实线为阻尼
// 正弦函数拟合曲线。左图中自旋偏振振幅较大，相位翻转清晰
// 且对比度高；中图振幅略有下降；右图在2.1Eᵣ时振荡几乎消
// 失，偏振值维持在约0.5附近。这组图表明随着损耗增加，
// Rabi振荡被强烈抑制。 子图b为三幅并排的伪彩色热图，对应
// γ₁=0.0Eᵣ、1.2Eᵣ、2.1Eᵣ，展示由平面波展开计算的能带带隙。
// 横轴标注qₓ(k₀)，范围-1.0至1.0；纵轴标注kₓ(k₀)，范围
// -0.6至0.6（纵轴自下而上数值递减）。右侧图例色标范围0.0
// 至1.5，颜色由深红/黑渐变至亮黄/白，亮色对应较大带隙。
// 左图显示一条清晰的亮黄色对角带隙结构；中图亮黄色带隙区
// 域明显变暗收缩；右图带隙亮区进一步减弱，仅剩较窄的亮带，
// 且其上叠加了白色虚线曲线轮廓。 子图c为上下两幅热图，展
// 示不同损耗下Γ点附近的能带带隙结构。上图对应γ₁=1.5Eᵣ，
// 下图对应γ₁=2.4Eᵣ。色标范围0.0至1.5。上图在亮色带隙结构
// 中，于特定位置标注了一个绿色空心圆圈“EP”（例外点），并
// 伴有白色虚线和白色箭头指向该点；同时，上方和右侧各标有
// 绿圈“α”。下图除保留“α”和“β”绿圈标注外，还用黑色虚线标
// 出了名为“Fermi arc”（费米弧）的连接曲线。 子图d为散点
// 曲线图，横轴为γ₁(Eᵣ)，范围0.0至3.5；纵轴为Band gap(Eᵣ)，
// 范围0.0至1.0。图例表明深灰色点对应kₓ/k₀=-0.18，浅灰色
// 点对应kₓ/k₀=-0.54。两条曲线均随γ₁增大而下降，深灰色曲
// 线从接近1.0下降至约0.05，浅灰色曲线从约0.4下降至约0.1，
// 并在γ₁约2.4处出现接近零的极小值，随后略有回升。一个右
// 向箭头标注在浅灰色曲线极小值附近。 子图e为类似散点图，
// 横轴为γ₁(Eᵣ)，纵轴为Damping rate(Eᵣ)，范围0.0至1.0。数
// 据点及其标记与d图一致。深灰色点和浅灰色点表示的阻尼率
// 均随γ₁增大而逐渐增加，在γ₁约1.0至2.0之间增加较快，后趋
// 于饱和或较缓增长。箭头指向浅灰色曲线在γ₁约2.4附近的一
// 个数据点。
#figure(placement: top, scope: "parent", block(width: 100%)[#image("imgs/Fig2.png", width: 65%)],
  caption: [
    *Momentum-dependent Rabi oscillation to resolve the band gap closing.* *a*, Rabi oscillation at different quasi-momenta $bold("q") = ( k_x , q_y )$ (points in *b*). Lines show the fitted curve with a damped sinusoidal function. *b*, Band gap between the lowest two bands simulated from plane wave expansion at different loss terms from $gamma_arrow.b = 0 E_r$ to $2.1 E_r$, while the lattice potential and Raman coupling strength are fixed to $V_(arrow.t ( arrow.b )) = 3.2 ( 2.2 ) E_r$ and $M_0 = 2.0 E_r$. The two-photon detuning $delta$ (or equivalently $m_z$) is set to $delta = - 0.35 E_r$ to compensate the on-site energy difference induced by spin-dependent lattice potential. The dashed line marks the positions of quasi-momentum $bold("q")$ where the energy gap is closed. *c*, With dissipation, each Dirac point in the Hermitian regime separates into a pair of EPs, which are connected by a (non-Hermitian) Fermi arc and continuously move in the momentum space as dissipation increases. *d,e* The change of the real energy band gap and damping rate at different quasi-momenta shown by the point $alpha$ and $beta$ in *c* with increasing dissipation. The slight increase in the real band gap when the loss rate is larger than the exceptional point is a result of the higher band effect.
  ]
)
<fig-2>

The total Hamiltonian realized experimentally reads

$ H_0 & = sum_(sigma = arrow.t , arrow.b) [frac(p_x^2 + p_y^2, 2 m) + V_sigma ( y ) | sigma chevron.r chevron.l sigma |] + V_R ( x , y )\
 & + m_z ( | arrow.t chevron.r chevron.l arrow.t | - | arrow.b chevron.r chevron.l arrow.b | ) + H_(l o s s) $<eq-model>

where $frac(p_x^2, 2 m)$~($frac(p_y^2, 2 m)$) is the kinetic energy term in the x~(y) direction, $V_R = M_R ( x , y ) | arrow.b chevron.r chevron.l arrow.t | + "h.c."$ is the Raman coupling term and $H_(l o s s) = - sum_(sigma = arrow.t , arrow.b) i / 2 gamma_sigma | sigma chevron.r chevron.l sigma |$ represents spin-sensitive atom loss. The Zeeman term $m_z = ( delta - delta_0 ) / 2$ can be controlled by two photon detuning $delta$, where $delta_0$ denotes the on-site energy difference between $chevron.l arrow.t |$ and $| arrow.b chevron.r$ states. When there is no spin-selective dissipation ($gamma_(arrow.b ( arrow.t )) = 0$), the system is Hermitian and the Raman coupling opens the band gap around the band-inversion line (#ref(<fig-1>)d), which is the particular quasi-momentum subspace with resonant spin flipping ~@liang2021realization @song2019observation. The Raman potential can be describe by $M_R ( x , y ) = M_0 cos ( k_0 y ) e^(i k_2 x - i k_1 y)$ with $k_1 = k_0 sin theta$ and $k_2 = k_0 cos theta$, and $e^(i k_2 x)$ term in Raman potential coupling the two spin states gives the x-directional kinetic energy $frac(ℏ^2, 2 M) ( k_x plus.minus k_2 / 2 )^2$, rendering the linear spin-orbit term $frac(ℏ^2, 2 M) ( k_x k_2 ) sigma_z$, which leads to a 2D energy band (see #ref(<fig-1>)b). In fact, the linear spin-orbit term effectively shifts the Zeeman energy $m_z$, which makes the energy band for the $k_x = 0$ layer obtained by tuning $m_z$ is identical to that for fixed $m_z = m_0$ by scanning $k_x$ following the relation $H_(q_y , k_x = 0 , m_z = m_0) = H_(q_y , k_x = frac(2 M m_0, ℏ^2 k_2) , m_z = 0)$.

// [figvision-cn] imgs/Fig3.png
// 子图a包含左侧能带结构示意图和右侧四幅数据图。最左侧为
// 一幅二维伪彩色能带图，横轴为q_y，纵轴为q_x或δ，黑到红
// 再到白的颜色映射表示能量或强度，图中有两个水平虚线标记
// 动量位置1和2，以及一个代表能隙的垂直箭头。右侧四幅数据
// 图分为上下两行，分别对应动量位置1和2；每行左侧为能隙随
// γ_1变化的曲线，右侧为阻尼率随γ_1变化的曲线。所有数据图
// 的横轴γ_1（单位为E_r）范围约0至3。能隙图纵轴范围0至1.0
// E_r，阻尼率图纵轴范围0至约0.65 E_r。图中蓝色实线为平面
// 波展开模拟结果，浅蓝色阴影区域表示不确定度。离散符号分
// 为两种：在能隙图中，圆形代表一种拟合函数，方形代表另一
// 种拟合函数；在阻尼率图中，方形和星形代表不同拟合。每幅
// 图内还有小插图显示γ_1在1.0至3.0范围的放大细节。趋势显
// 示能隙随γ_1增加而先缓降后加速下降并趋于零，阻尼率则从
// 零开始随γ_1增加而上升，在特定γ_1处发生拟合函数的切换，
// 对应例外点。 子图b为两幅散点图，横轴γ_1（单位为E_r）范
// 围0至3，纵轴为R²(ED)/R²(DO)范围0.2至1.0。上图和下图分
// 别对应动量位置1和2，数据点用灰色圆表示。图中有一条垂直
// 黑色虚线标记例外点位置（γ_1约1.8 E_r）。趋势显示R²比值
// 随γ_1增加而上升，并在例外点附近达到1后保持平稳，表明在
// 例外点之后两种拟合函数的拟合优度趋于一致。 子图c为两列
// 多行曲线图，横轴均为Hold time（ms）范围0至0.25（最后一
// 幅为0至0.2）。左列纵轴为Spin polarization范围-1至1，右
// 列纵轴为自旋极化信号（无单位）范围约-1至1。每行对应不
// 同的γ_1值：0.0 E_r、0.6 E_r、1.2 E_r、1.8 E_r、2.6 E_r。
// 左列显示自旋极化随时间的Rabi振荡，用空心圆数据点和实线
// 拟合表示；右列显示对应的阻尼振荡曲线，用浅蓝到深蓝的实
// 线表示。趋势显示随着γ_1增加，振荡幅度衰减加快，在γ_1=
// 1.8 E_r时振荡几乎消失，表现为单调衰减，表明系统进入例
// 外点区域。 子图d为示意图与四幅自旋极化衰减曲线图的组合。
// 中间偏左为纵向流程示意图，纵轴为γ_1，标注了六个位置：
// 0.8E_r、1.4E_r、1.5E_r、2.6E_r，以及对应的动量标记1、2、
// 3、4。流程图中包含两幅二维伪彩色能带图，横轴q_y，纵轴
// k_x或δ，颜色映射黑到红到白表示强度，图中有水平虚线标记
// 动量位置。右侧四幅曲线图分为两组：上方浅蓝色背景区域标
// 注Outside Fermi arc，包含动量1（圆形，k_x=0.0k_0）和动
// 量2（方形，k_x=-0.5k_0）的曲线；下方深蓝色背景区域标注
// On Fermi arc，包含动量3（圆形，k_x=0.0k_0）和动量4（方
// 形，k_x=-0.5k_0）的曲线。所有曲线图横轴为Hold time（ms）
// 范围0至0.25，纵轴为Spin polarization范围0至1.0。曲线显
// 示自旋极化随时间的衰减振荡，Outside Fermi arc的曲线呈
// 现明显振荡衰减，On Fermi arc的曲线则表现为单调衰减或弱
// 振荡，趋势表明在费米弧内外自旋动力学行为存在显著差异。
// 子图e（未在图中明确标出，但根据图注和图像内容，可能为
// 能带结构与例外点的关系示意图，实际图像中未见独立子图e，
// 故省略）。
#figure(placement: top, scope: "parent", block(width: 100%)[#image("imgs/Fig3.png", width: 76%)],
  caption: [
    *Observation of non-Hermitian EPs and Fermi arc.* *a* The band gap $Re ( Delta E )$ (left) and damping rate $Im ( Delta E )$ (right) extracted from the Rabi oscillation at two different quasi-momentum marked in the left energy band gap. Before and after the EPs, the fitting functions are different. The solid line is obtained from the simulation of plane wave expansion. The shaded region indicates the uncertainty of the band gap and damping rate associated with the uncertainty of atom loss (green color) and the uncertainty of quasi-momentum (brown color). The inset shows the fitting result with same damped oscillation fitting function before and after the exceptional point. The vertical and horizontal error bars represent the fitting errors and the experimental uncertainty related to the calibration, respectively. *b* The normalized $R^2$ value, obtained by fitting the experimental data with exponential decay (ED) curves, divided by the $R^2$ value obtained from fitting with a damped oscillation (DO) curve, is presented. The corresponding quasi-momentum values, $( k_x , q_y ) = ( - 0.5 , - 0.9 ) k_0$ (top) and $( k_x , q_y ) = ( 0.0 , - 0.3 ) k_0$ (bottom), are marked in the energy band gap shown in *a*, respectively. This ratio reveals that above the exceptional point (EP), the fitting using an exponential decay function performs equally well as the fitting with a damped oscillation, indicating that the spin oscillation follows a monotonic exponential behavior, while below the EP, the exponential decay function is disfavored. The horizontal error bars represent the experimental uncertainty related to the calibration. *c* The spin oscillation for same quasi-momentum and different dissipation strengths and marked by the arrows in *a* bottom. When $gamma_arrow.b$ is smaller than the EP, the spin polarization oscillates with the frequency dependent, while above EP, the PT-symmetry broken phase shows a monotonic spin polarization. The right column shows the corresponding simulation from plane wave expansion with finite temperature considering momentum uncertainty (solid line) and without considering the momentum uncertainty (dashed line). *d* The spin oscillation for two different quasi-momentum and similar dissipation strength $gamma_arrow.b tilde 0.8 E_r$ (top) and $1.5 E_r$ (bottom). When $gamma_arrow.b = 1.5 E_r$, the left EP moves across $k_x = - 0.5 k_0$, which means the quasi momentum $( k_x , q_y ) = ( - 0.5 , - 0.9 ) k_0$ is on Fermi arc and shows a monotonic spin polarization.
  ]
)
<fig-3>

= PROBING QUENCH EVOLUTION IN THE NON-HERMITIAN REGIME

To monitor quench evolution of non-Hermitian topological band, we begin with preparing a spin-polarized degenerate $""^"173"$Yb Fermi gas in the spin-up states $| arrow.t chevron.r$ followed by loading into a Hermitian optical lattice potential within 3~ms (See #ref(<fig-1>)b and d). At this stage, two-photon detuning $delta_i tilde - 27 E_r$ is set to be far enough to minimize SOC where $E_r = h times 3.735$~kHz is the recoil energy. After the initial-state preparation with additional 1~ms hold, two photon-detuning is suddenly adjusted from $delta_i$ to $delta_f$ with the loss pulse being switched on at time $t = 0$ (#ref(<fig-1>)d). The band structure of the system starts to evolve from a hermitian lattice band to a band with dissipative SOC, and the atoms initially in $| arrow.t chevron.r$ state start the Raman-Rabi oscillation between $| arrow.t chevron.r$ and $| arrow.b chevron.r$. Holding a variable time $t_f$, we record spin-sensitive momentum distribution after 10ms (or 15ms) time-of-flight expansion and extract the oscillation of spin polarization in the first Brillouin zone. In #ref(<fig-2>)a, we show a typical spin oscillation in the momentum space after the quench with increasing dissipation $gamma_arrow.b$. The spin polarization at different quasi-momentum oscillates with different frequencies revealing a non-uniform band gap in consistent with the calculated band gap (see #ref(<fig-2>)b).

// [figvision-cn] imgs/Fig4.png
// 该图由四个子图（a、b、c、d）组成，展示了非厄米趋肤效应
// （NHSE）在动量空间中的特征。以下为各子图的详细描述：
// 子图 a：由上下两个复平面散点图组成，分别标记为“
// Experiment”（实验）和“Theory”（理论）。横轴均为 Re(ΔE)
// (E_r)，范围 0.0 至 2.0；纵轴均为 |Im(ΔE)| (E_r)，实验
// 图范围 -0.4 至 0.4，理论图范围 -0.1 至 0.1。图中包含两
// 组数据点：深灰色实心圆点代表 k_y/k_0 = 0.0，浅青色空心
// 圆点代表 k_y/k_0 = -0.2。所有浅灰色背景点代表“All k_y/
// k_0”。图例位于右侧。标题标注 γ_1 = 0.0E_r。趋势显示在
// 无耗散情况下，实验与理论的数据点均集中在纵轴为零的水平
// 线上，且深灰色点与浅青色点沿横轴分布范围不同。 子图 b：
// 分为“Experiment”（左）和“Theory”（右）两个面板。横轴均
// 为 Re(ΔE) (E_r)，范围 0.0 至 2.0（实验）或 0.0 至 2.0
// （理论）；纵轴均为 |Im(ΔE)| (E_r)，实验范围 0.0 至 0.7，
// 理论范围 0.0 至 0.20。标题标注 γ_1 = 0.4E_r。图中浅灰
// 色散点代表“All k_y/k_0”。实验图中包含深灰色实心圆点（
// k_y/k_0 = -0.1）和浅青色实心圆点（k_y/k_0 = -0.1），并
// 带有黑色箭头指示轨迹方向；理论图中包含深灰色实心圆点（
// k_y/k_0 = -0.1）和浅青色实心圆点，同样带有箭头。实验图
// 内嵌一个缩小版复平面图，横轴 Re(ΔE) (E_r) 0.6 至 1.0，
// 纵轴 |Im(ΔE)| (E_r) 0.2 至 0.8，标题 γ_1 = 0.8E_r，包
// 含深灰色点（k_y/k_0 = -0.1）及箭头。理论图右侧内嵌两个
// 热图，横轴 q_y，纵轴 k_x，分别显示 Re(ΔE) 和 |Im(ΔE)|
// 的分布，色标从 0 到 5 或 0 到 3。趋势表明在有耗散时，
// 复平面上的轨迹形成闭合环状结构。 子图 c：分为“
// Experiment”（左）和“Theory”（右）两个面板。横轴均为 Re
// (ΔE) (E_r)，实验范围 0.8 至 1.4，理论范围 0.0 至 2.0；
// 纵轴均为 |Im(ΔE)| (E_r)，实验范围 0.2 至 1.0，理论范围
// 0.0 至 0.20。标题标注 γ_1 = 0.4E_r。浅灰色散点代表“All
// q_y/k_0”。深灰色实心圆点代表 q_y/k_0 = -0.25，并带有黑
// 色箭头指示轨迹。理论图右侧内嵌两个热图，横轴 q_y，纵轴
// k_x，分别显示 Re(ΔE) 和 |Im(ΔE)| 的分布，色标从 0 到 3。
// 趋势显示数据点沿特定方向形成轨迹。 子图 d：为二维热图，
// 标题为 |Ψ|^2，右上角色标范围 0 至 5，乘数为 ×10^-4，颜
// 色由白到深蓝。横轴为 y(a_0)，范围 -30 至 30；纵轴为 x(
// a_0)，范围 -30 至 30。图中有一个黑色虚线绘制的圆圈，圆
// 心大致在原点，半径约为 15 a_0。热图显示在圆圈外部存在
// 不规则的深蓝色高密度区域，尤其在右上角区域较为明显，而
// 圆圈内部区域颜色较浅，接近白色。
#figure(scope: "parent", image("imgs/Fig4.png", width: 100.0%),
  caption: [
    *Signature of NHSE in momentum space.* *a*, Experimental and simulated band difference along $q_y$ direction without dissipation ($gamma_arrow.b = 0.0 E_r$) on the complex plane. The real part is extracted from spin polarization curve, while the imaginary part is extracted from spin down curve. *b* Experimental and simulated band difference along $q_y$ direction with dissipation strength $gamma_arrow.b = 0.4 E_r$ on the complex plane. The dots correspond to the difference between the lowest two eigenvalues at all quasi-momentum within first Brillouin zone and $- 0.6 < k_x / k_0 < 0.6$. The solid lines correspond to the spectral flow of the band gap at different $k_x$ layer when $q_y$ runs from $- k_0$ to $k_0$. The inset in the left figure shows band difference on the complex plane when spin-selective dissipation $gamma_arrow.b = 0.8 E_r$. The inset in the right figure shows the real and imaginary band gap at $gamma_arrow.b = 0.4 E_r$ simulated from the plane wave expansion. *c* Experimental and simulated band difference along $k_x$ direction on the complex plane with the dissipation strength $gamma_arrow.b = 0.4 E_r$. The dots correspond to the difference between the lowest two eigenvalues at all quasi-momentum within first Brillouin zone and $- 0.6 < k_x / k_0 < 1.0$. The solid lines correspond to the spectral flow of the band gap at selected $q_y$ layer labeled by arrow in inset. *d*, Simulation of density profile in the harmonic trap with $gamma_arrow.b = 0.4$$E_r$ and trap frequency $omega_r = 2 pi times 112$Hz, where $a_0$ is the lattice constant and the finite-difference step-length in $x$ direction is $x_0 = a_0 / 7.0$. The density profile is summed over eigenstates with eigenenergy satisfying $Re ( E ) < 1.5 E_r$. The dashed line denotes the effective trapping size obtained from the Fermi energy.
  ]
)
<fig-4>

= EMERGENCE OF NON-HERMITIAN FERMI ARC WITH EXCEPTIONAL POINTS

One key feature arising from the appearance of dissipation in our system is the emergence of exceptional degeneracy forming a non-Hermitian Fermi arc (connecting two exceptional points), which affects the physical properties of energy band and reveals non-trivial band topology~@zhou2021engineering @zhen2015spawning @Kozii.2017. In the Hermitian band, the band gap near the band inversion line is opened by the SOC (see #ref(<fig-1>)d) while the band gap becomes smaller with increasing dissipation due to the competition between SOC and dissipation as described in #ref(<fig-2>)b~@ren2022chiral. With increasing dissipation, two exceptional points, at which two eigenstates coalesce, emerge and continuously move in the momentum space, being connected by a (non-Hermitian) Fermi arc denoted by the dashed line (see #ref(<fig-2>)c). We note that the non-Hermitian Fermi arc is a bulk phenomenon in contrast to the Hermitian counterpart, the surface Fermi arc in 3D Weyl semimetal. To reveal a Fermi arc with exceptional points, we examine the spin evolution after quenching at two quasimomenta $alpha$=$( k_x , q_y ) tilde.eq ( - 0.54 , - 0.84 ) k_0$ and $beta$=$( k_x , q_y ) tilde.eq ( - 0.18 , - 0.54 ) k_0$ on the band inversion line. As the dissipation strength increases, the EP moves to the point $alpha$ closing the band gap while the point $beta$ still opens the gap. At larger dissipation strength, the EP reaches the point $beta$ while the quansimomentum between $alpha$ and $beta$ closes the gap with a non-zero damping rate (#ref(<fig-2>)d). Notably, the real band gap does not remain zero after EP, as the higher bands cause a slight shift in the Fermi arc with increasing dissipation. We also notice there is no such effect in the simulation using the tight-binding model.

= OBSERVATION OF THE EPs AND FERMI ARC

@fig-3 shows the measurement of the band gap $Re ( Delta E )$ and damping rate $Im ( Delta E )$ at different momentum states 1 and 2 for variable dissipation $gamma_arrow.b$. Our measurement manifests the EP moves in the momentum space passing the point 2 and 1, consecutively, showing the growth of the Fermi arc with increasing dissipation. The energy band gap before EP and damping rate after EP can then be extracted by fitting the oscillation curve with a sinusoidal and a monotonic exponential function, respectively (see Methods). By gradually increasing the dissipation, we observe that above the EP, the spin oscillation exhibits a monotonic exponential behavior, while below the EP, a monotonic exponential function clearly fails to capture the observed dynamics. This observation is quantitatively assessed by extracting the $R^2$ values of the exponential decay function and the damped oscillation function at different dissipation strengths. The resulting ratios are calculated and depicted in #ref(<fig-3>)b, providing an alternative approach to probe the appearance of the EP. In the inset, the result obtained by fitting only with a damped oscillation function is also presented. It should be noted that the band gap cannot completely reach zero due to the limitations imposed by the finite momentum resolution and fitting constraints.

When the loss rate is smaller than the critical dissipation, the initial state at point 1 oscillates between two eigenstates with the minimal damping rate respecting the $cal("PT")$ symmetry, as consistent with calculations (#ref(<fig-3>)c). Beyond the critical value, however, the strong dissipation completely closes the band gap making time evolution of spin polarization exponentially decay, manifesting $cal("PT")$ symmetry breaking. In #ref(<fig-3>)d, we show the comparison of the spin polarization at two different quasi momentum $( k_x , q_y ) = ( - 0.5 , - 0.9 ) k_0$ and $( k_x , q_y ) = ( 0.0 , - 0.3 ) k_0$ with similar dissipation strength $gamma_arrow.b tilde 0.8 E_r$ and $1.5 E_r$. At a smaller dissipation strength, the spin polarization at both quasi-momentums shows oscillation behaviors, which means they are outside the Fermi arc. With increasing dissipation, the spin polarization for higher $| k_x |$ convert into a monotonic curve earlier than lower $| k_x |$, which is another proof of the growth of Fermi arc.

With the above results we have successfully demonstrated the realization of a 2D non-Hermitain topological band described by Hamiltonian in @eq-model. The Hermitian nature of this Hamiltonian is confirmed through measurements of spin polarization in the equilibrium state or quench dynamics (see Supplementary Information), and our investigation extends the understanding to the non-Hermitian regime with the observation of EPs and Fermi arc phenomena. In addition to these remarkable findings, our platform also enables the observation of the NHSE arising from the dissipation.

// [figvision-cn] imgs/Fig5.png
// 图a为原理示意图与二维密度分布图。左侧纵向流程自下而上
// 分为三个阶段：Prepare（制备）、Hold time（保持时间）、
// Image（成像）。在Prepare阶段，一个浅蓝色半圆碗状势阱内
// 有一个蓝色圆球，标注为“Prepare initial status”；在Hold
// time阶段，势阱中蓝色圆球沿箭头向右移动，标注为“Hold
// time”；在Image阶段，分化为两条路径：上方路径标注“Skin
// effect”，势阱右侧边缘出现聚集的蓝色小球；下方路径标注“
// No skin effect”，蓝色小球均匀分布在势阱右侧。右侧为2D
// profiles（二维剖面）面板，包含四幅圆形原子密度分布图，
// 分为两列两行：左列标注“Skin effect”，右列标注“No skin
// effect”；上排标注“y”，下排标注“x”，每幅图均带x、y坐标
// 轴。下方有颜色条，标注“Atom density”，从Low（黑色）到
// High（白色/亮黄色）。有Skin effect的图中，高密度亮区偏
// 向右侧边缘；无Skin effect的图中，高密度亮区位于中心。
// 图b为实验（Skin effect）曲线图。横轴为Position x (μm)，
// 范围-5到5；纵轴为OD (a.u.)，范围0到1；右侧时间轴Time (
// ms)范围0.0到3.0。图中包含多条沿时间轴堆叠的OD分布曲线，
// 每条曲线由红色和蓝色阴影区域组成，红色在左、蓝色在右。
// 一条灰色虚线连接各曲线峰值位置，标注“Skin modes”，箭头
// 向右。时间轴各刻度旁标注“γi = 0.2Er”。 图c为实验（No
// skin effect）曲线图。横轴Position x (μm)范围-5到5，纵
// 轴OD (a.u.)范围0到1，时间轴Time (ms)范围0.0到3.0。堆叠
// 的OD分布曲线同样红左蓝右，灰色虚线连接各峰值位置，标注
// “Guideline”，虚线位置随时间基本竖直。时间轴旁标注“γi =
// 0Er”。 图d为理论（Skin effect）曲线图。坐标轴与图b相同，
// 横轴Position x (μm)范围-5到5，纵轴OD (a.u.)范围0到1，
// 时间轴Time (ms)范围0.0到3.0。堆叠曲线红左蓝右，灰色虚
// 线连接峰值，标注“Skin modes”，箭头向右。时间轴旁标注“γ
// i = 0.2Er”。 图e为理论（No skin effect）曲线图。坐标轴
// 同图c，横轴Position x (μm)范围-5到5，纵轴OD (a.u.)范围
// 0到1，时间轴Time (ms)范围0.0到3.0。堆叠曲线红左蓝右，
// 灰色竖直虚线标注“Guideline”。时间轴旁标注“γi = 0Er”。
// 图f包含四个曲线子图，排列为两行两列，上方标注“
// Experiment”，下方标注“Theory”。左侧两图纵轴为Center (μ
// m)，范围-1到2；右侧两图纵轴为Difference (μm)，范围-1到
// 2；四个图横轴均为Hold time (ms)，范围0到2。图例显示：
// 深蓝色实心圆点连线代表γi = 0.2Er，浅蓝色空心圆点连线代
// 表γi = 0Er；右侧图图例还标注了“-x”（空心圆点）和“+x”（
// 实心圆点）。实验左图中，深蓝曲线从0附近升至约1.5后平台，
// 浅蓝曲线从0附近升至约1后下降；实验右图中，深蓝曲线从0
// 附近升至接近2，浅蓝曲线从0附近升至约1。理论左图中，深
// 蓝曲线从0附近升至约2，浅蓝曲线从0附近升至约1后下降；理
// 论右图中，深蓝曲线从0附近升至接近2，浅蓝曲线从0附近升
// 至约1。各数据点带有误差棒。
#figure(scope: "parent", image("imgs/Fig5.png", width: 85.0%),
  caption: [
    *Signature of NHSE in real space.* *a*, Schematic illustrating the detection of the signature of the NHSE in real space. Initially, atoms are prepared with an initial status and given an initial velocity in the +x boundary. Subsequently, the system is either quenched to a non-Hermitian Hamiltonian or conserved in a Hermitian Hamiltonian. After a certain hold time, the presence of the skin effect causes the atoms to accumulate in the +x direction. In contrast, in the absence of the skin effect, the atoms undergo dipole oscillation. *b,c* One example of experimental one-dimensional normalized spin up atom profiles along the $x$ direction with ($gamma_arrow.b = 0.2 E_r$) or without skin effect ($gamma_arrow.b = 0.0 E_r$). The initial motion is along $+ x$ direction. The normalized atom profiles are averaged for the whole atom cloud along $y$ direction. The positions with the highest optical density (OD) are denoted by empty circles and the gray dashed line is a guideline based on polynomial function. The profiles corresponding to positive and negative positions are indicated by blue and red colors, respectively. *d,e* Simulated one-dimensional normalized spin up atom profiles along the $x$ direction with or without skin effect, specifically $gamma_arrow.b = 0.2 E_r$, or $gamma_arrow.b = 0.0 E_r$. The initial motion is along $+ x$ direction. The normalized atom profiles are averaged for the whole atom cloud along $y$ direction. The positions with the highest optical density (OD) are denoted by empty circles and the gray dashed line is a guideline based on polynomial function. The profiles corresponding to positive and negative positions are indicated by blue and red colors, respectively. *f*, Extracted center positions (left) of the experimental and simulated spin-up atom profiles along the $x$ direction when the atom cloud has an initial velocity in the +x direction, comparing the cases with ($gamma_arrow.b tilde 0.2 E_r$) and without the NHSE ($gamma_arrow.b = 0.0 E_r$). The difference in center positions between the two cases with skin effect ($gamma_arrow.b tilde 0.2 E_r$) and without skin effect when the atom cloud has an initial velocity to +x or -x direction, is shown on the right. The error bars indicate the standard deviation obtained from multiple measurements.
  ]
)
<fig-5>

= NON-HERMITIAN SKIN EFFECT

The existence of exceptional degeneracy in the spectra signals the NHSE~@Zhang.2022. Also, if the spin-dependent dissipation is projected onto the spin-orbit-coupled bands of the Hermitian part of the Hamiltonian, asymmetric hoppings will arise and lead to the NHSE~@yi2020non. To concretely characterize the NHSE in our system, we evaluate the topological feature of the complex spectrum.

It is shown that the NHSE arises in 1D under open-boundary condition (OBC), if and only if the periodic-boundary condition (PBC) spectrum of the Hamiltonian is point-gapped topological~@sato2020origin @Zhang.2020k3c, namely having nonzero spectral winding numbers or being non-backstepping curve(s) (see Supplementary Information for details). It can be understood that the non-backstepping spectrum under PBC indicates the lack of two degenerate Bloch waves to be superimposed to satisfy OBC, and this breakdown of the Bloch theorem leads to NHSE~@Yokomizo.2019. In a 2D system, a nonzero periodic-boundary spectral area indicates that the NHSE persists unless the open boundary geometry coincides with certain spatial symmetries of the bulk~@Zhang.2022 @wang2022amoeba. Specifically, nontrivial spectral topology of quasi-1D subsystems perpendicular to the edges can reveal the spectral flow and serve as an indication of the 2D skin effect under rectangular open boundary geometry~@Zhang.2022 @wang2022amoeba @zhang2023edge.

In our experiment, we investigate the existence of the NHSE with spectral topology of complex band difference extracted from the quench evolution of spin polarization and spin down information. If there is no dissipation, the experimentally measured data lie on the zero imaginary axis forming a line without spectral winding, except for a small portion (12\%) of points deviate from this axis (#ref(<fig-4>)a top), attributed to experimental uncertainties, such as a low signal-to-noise ratio for quasi-momentum far from the center of the atom cloud. The observation is consistent with the simulation (#ref(<fig-4>)a bottom).

The results are in sharp contrast after opening up dissipation. We observe the nonzero spectral area and nontrivial spectral winding at a specific $k_x$ layer with dissipation $gamma_arrow.b = 0.4 E_r$ (#ref(<fig-4>)b left), in agreement with simulated results obtained through plane-wave expansion (#ref(<fig-4>)b right). Notably, the spectral winding can be determined by measuring only the local complex band gap at each momentum in the experiment. The original band spectrum difference exhibits a ring-like pattern with an elliptical shape on the complex plane, and the sign of the imaginary part of the band gap changes as the quasi-momentum traverses the band inversion surface. By flipping the portion with a negative imaginary band gap into the first quadrant, the elliptical pattern evolves into the butterfly shape depicted in #ref(<fig-4>)b with a simulated result being consistent. Additionally, in the inset of #ref(<fig-4>)b, we present the band difference on the complex plane at $gamma_arrow.b = 0.8 E_r$ showing the similar spectral winding.

In #ref(<fig-4>)c, we also present the experimental data and simulation at a particular $q_y$ layer while varying $k_x$ from $- 0.6 k_0$ to $k_0$. In this direction, the absence of optical lattice results in the band difference spectrum intersecting at $k_x arrow.r plus.minus oo$. Then, for a finite range of the band difference spectrum, the spectral flow is generally observable and can be measured in experiments, in sharp contrast to the case with lattice. Importantly, for specific $q_y$ layers ($q_y / k_0 = - 0.2$), the currently measured region is sufficient to allow the observation of the non-backstepping behavior, implying the existence of NHSE.

The spectral winding or non-backstepping behavior of the band difference $| Re ( Delta E ) | - | Im ( Delta E ) |$, as measured in the present experiment for quasi-1D layers, uniquely corresponds to that of the band dispersion. This guarantees that (i) the nontrivial spectral winding of the energy bands $E_(1 / 2) ( k_x , q_y )$ and (ii) the nonzero spectral area (See Supplementary Information for a generic proof). Thus the measurement confirms the realization of the NSHE in both $x$ and $y$ directions, giving 2D corner skin modes under the OBC, which are actually supported by the numerical simulation in #ref(<fig-4>)d. We note that in addition to the measured spectral winding and non-backstepping feature, the nonzero periodic-boundary spectral area [the dots in light color of all $k_x / k_0$ ($q_y / k_0$) in #ref(<fig-4>)b (c)] also signals clearly the 2D skin effect in experiment.

To further validate the presence of the NHSE in our system, we investigate its dynamical signature in real space by monitoring the spatial distribution of spin-up atoms (#ref(<fig-5>)a). Initially, we prepare the atoms with an initial velocity in the +x direction by quenching the system to a Hermitian Hamiltonian. Subsequently, the system is either shifted to a non-Hermitian Hamiltonian or maintained in the Hermitian Hamiltonian. After a certain hold time, we obtain the real-space profiles of the spin-up atoms by magnifying the _in-situ_ image using a matter-wave magnifier~@asteria2021quantum, established by applying a harmonic trap along the z-direction.

In the first 1.5~ms, we observe the atom cloud moving in the +x direction for both cases. Following this, in the presence of the skin effect ($gamma_arrow.b = 0.2 E_r$), the atoms gradually localize in the +x direction over time with slight movement, which is a direct consequence of the large number of skin modes accumulated in the +x boundary. Conversely, in the absence of the skin effect ($gamma_arrow.b = 0.0 E_r$), the atoms move backward to their original position, exhibiting distinct dipole oscillation (#ref(<fig-5>)b,c). These observations are well consistent with the numerical simulation (#ref(<fig-5>)d,e), providing clear evidence for the manifestation of NHSE with nonzero dissipation.

To quantify the NHSE, we extract the center of mass from the 1D normalized spin-up atom profiles and further obtain the difference of center position between the Hermitian and non-Hermitian case (#ref(<fig-5>)f). With the skin effect, the center of mass position rises and then saturates. Without it, however, the position first rises and then falls, returning to its original position. In addition, we also take another experiment by initializing the motion along $- x$ direction. In the presence of skin effect in the +x boundary ($gamma_arrow.b = 0.2 E_r$), the atom cloud stopped the motion to $- x$ direction in a relatively short time and then turned to $+ x$ direction. In contrast, without the skin effect ($gamma_arrow.b = 0.0 E_r$), the atom cloud can move to $- x$ direction with a larger displacement and exhibit dipole oscillation. The results show an effective bias force due to the skin effect to +x direction, and are also well consistent with the numerical results (See Supplementary Information for details). These observations further confirm the existence of skin effect with skin modes mainly accumulated to the +x direction in our present system. Notably, regardless of our setup only having a harmonic potential, the skin effect remains robust in external trapping potentials~@guo2021theoretical. It is suggested that systems with non-Hermitian spin-orbit coupling show a dynamic sticky effect in a box potential, resulting in unusual reflection behavior near the boundary~@guo2021theoretical.

Lastly, we have two remarks on the 2D NHSE in our system. One is that the occurrence of the NHSE could be inferred from the imaginary vector potential and imbalanced hoppings induced by SOC together with the dissipation (see Method). As shown by the density profile of eigenstates in the harmonic trap in #ref(<fig-4>)d, besides the majority of skin modes being localized in the $( + x , + y )$ direction, some skin modes are localized in the $- x$ direction. In fact if the soft harmonic trap is replaced by a hard box trap, both $( plus.minus x , plus.minus y )$ corners will be populated with skin modes (see Supplementary Information). This feature originates from a universal result established by the particle-hole(-like) symmetry (PHS) that the skin modes related by the PHS are being localized in different boundaries~@liu2023PHS. Another thing worthwhile to mention is that, with appropriate approximations, the two low-energy sectors of our system could be mapped to Hermitian systems of free particles in 4D curved spaces that is the Cartesian products of two 2D pseudospheres (see Method). Together with the time dimension, the curved space after mapping is indeed (4+1)D. The nonzero curvature of the pseudospheres changes the inner product of states and renders the eigenstates to be localized in the boundaries of the curved spaces. This accumulation in the boundaries of the curved spaces is exactly the counterpart of the non-Hermitian skin effect in the mapping. The two dimensions of the 4D space can be considered as "extra dimensions" controlling the strength of the "geometric" potential experienced by the particles. This geometric description exhibits intriguing similarities with the (4+1)D Kaluza-Klein theory, a formalism unifying gravitation and electromagnetism through an extra dimension complementing to 3+1 space-time dimensions~@Kaluza2018OnTU @Klein1926fiveD @Klein1926atom. The potential of our non-Hermitian lattices shall inspire the further simulation of exotic high-dimensional curved spaces in future work.

= CONCLUSION

We have observed for the first time 2D NHSE for an ultracold fermion gas, and investigated systematically the coexistence of the EPs and skin effect in the quantum system. Our realization is achieved by engineering the non-Hermiticity of the 2D Fermi gas with SOC, which shows to be an intriguing system to explore rich phenomena including the 2D topological nodes, skin effect, and EP physics. In addition to the static regime, the present realization opens up a promising direction to study the non-equilibrium quantum dynamics with engineered non-Hermiticity. In contrast to classical systems, our experiment naturally sets a quantum many-body system, and therefore paves a way to investigate the non-Hermitian quantum dynamics in the many-body regime using ultracold fermions with dissipation. Moreover, the high controllability also makes our system be a versatile platform to explore the high-dimensional non-Hermitian phenomena linking to profound physics like curved space~@duality2022 @Hermitization2022 @zhou2022curve and simulation of black holes~@spinblackhole2012 @Weylblackhole2022, opening a broad avenue in studying exotic quantum physics beyond condensed matter and ultracold atoms.

\

*2D topological bands* In our experiments, the optical Raman lattice is generated by using a 1D spin-dependent optical lattice together with another free-running Raman beam to induce the Raman coupling, as described in #ref(<fig-1>)a. The lattice potential is produced by retroreflecting a Gaussian laser beam along y direction with the polarization linearly polarized along x direction, forming a spin-dependent potential $V_sigma ( y ) = V_(0 , sigma) cos^2 ( k_0 y )$. The free-running linearly polarized Raman beam with polarization direction z is applied along the direction with angle $theta = 76 degree$ tilted from the lattice incident beam, inducing the Raman coupling $M_R ( x , y ) = M_0 cos ( k_0 y ) e^(i k_2 x - i k_1 y)$ between $| arrow.t chevron.r = | m_F = 5 / 2 chevron.r$ and $| arrow.b chevron.r = | m_F = 3 / 2 chevron.r$, where $k_1 = k_0 cos theta$ and $k_2 = k_0 sin theta$. Both lattice beam and Raman beam are blue detuned by $tilde$1GHz from the $""^"1" S_0 ( F = 5 / 2 ) arrow.r ""^"3" P_1 ( F' = 7 / 2 )$ transition of $""^"173" "Yb"$ atoms and the frequency difference $delta omega$ between the lattice lights and Raman lights can be tuned by acousto-optical modulators. The quantized axis is fixed by the bias magnetic field of 13.6G along the z-direction, which will induce an 8.1MHz Zeeman splitting between adjacent $m_F$ states. To separate out a spin-1/2 subspace from other hyperfine states of the ground manifold, we also use an additional $sigma^(-)$ polarized 556 light along -z direction to induce spin-dependent ac stark shift(not shown in #ref(<fig-1>)b)@song2016spin. The spin dependent atom loss $gamma_(arrow.b ( arrow.t ))$ in our experiment is induced by a near-resonant $sigma^(-)$ polarized loss beam with frequency red detuned by $Delta_arrow.b = 1.0 tilde 1.6 ( 9.1 tilde 9.7 )$MHz from $| m_F = 3 / 2 chevron.r arrow.r | m_(F') = 1 / 2 chevron.r$ transition ($| m_F = 5 / 2 chevron.r arrow.r | m_(F') = 3 / 2 chevron.r$ transition). Remarkably, the loss beam also induces an additional energy shift in two-photon detuning, which we can compensate by tuning the frequency difference between the Raman beam and the lattice beam in our experiment.

To sum up, the s-band Bloch Hamiltonian could be written as:

$ H_s ( upright(bold(k)) ) & = h_0 ( upright(bold(k)) ) sigma_0 + h_z ( upright(bold(k)) ) sigma_z + h_y ( upright(bold(k)) ) sigma_y + i gamma_arrow.b / 4 sigma_z , $<eq-sbloch>

where $upright(bold(k)) = ( k_x , q_y )$, $h_y ( upright(bold(k)) ) = 2 t_(s o) sin ( q_y a_0 - k_1 a_0 / 2 )$, $h_z ( upright(bold(k)) ) = - ℏ^2 ( k_x k_2 ) / 2 m - t_y^arrow.t cos ( q_y a_0 ) - t_y^arrow.b cos ( q_y a_0 - k_1 a_0 ) + m_z$, $h_0 ( upright(bold(k)) ) = ℏ^2 ( k_x^2 + k_2^2 / 4 ) / 2 m - t_y^arrow.t cos ( q_y a_0 ) + t_y^arrow.b cos ( q_y a_0 - k_1 a_0 ) - i gamma_arrow.b / 4$ and $sigma_(0 , y , z)$ are the Pauli matrices. $t_y^(arrow.t ( arrow.b ))$ is the nearest hopping coefficient of spin-up(down) atoms and $a_0 = pi / k_0$ is the lattice constant in $y$ direction.

*Experimental procedure* We start the experiment with a single-component degenerate $""^"173"$Yb Fermi gas at $T / T_F lt.tilde 0.4$ with atom number around $2 times 10^4$ in a far detuned crossed optical dipole trap with trap frequencies $macron(omega) = ( omega_x omega_y omega_z )^(1 / 3) = 112 times 2 pi$Hz. The single-component degenerate $""^"173" "Yb"$ Fermi gas in the $| arrow.t chevron.r$ state is prepared with the optical pumping process during and after the evaporation cooling. The atoms are then loaded into our 1D optical lattice potential by ramping up both the lattice and Raman laser intensity in 3ms with the initial two-photon detuning $delta_i$ far enough to exclude the Raman coupling. After that, we further hold the system for another 1ms and then quench the two-photon detuning from $delta_i$ to $delta_f$ at time $t = 0$ and switch the loss pulse at the same time. Meanwhile, the optical dipole trap is switched off in case it affects the evolution. The atoms initially prepared in $| arrow.t chevron.r$ state start the Raman-Rabi oscillation between the lowest two bands in our system.

Holding a variable time $t_f$, we record spin-sensitive momentum distribution after 10ms (or 15ms) time of flight expansion by applying the 556nm blast pulses resonant to $""^"1" S_0 ( F' = 5 / 2 ) arrow.r ""^"3" P_1 ( F' = 7 / 2 )$ transition. Three absorption images with no atoms killed $cal(I)_1$, with spin up atoms killed $cal(I)_2$ and with both spin up and spin down atoms killed $cal(I)_3$ are obtained and we can further extract the atomic distribution of spin up and spin down from $cal(I)_arrow.t ( k'_x , k_y ) = cal(I)_1 - cal(I)_2$ and $cal(I)_arrow.b ( k'_x , k_y ) = cal(I)_2 - cal(I)_3$. After folding the atomic distribution of two spin states into the first Brillouin zone and shifting the momentum distribution of the spin-down state based on the spin momentum locking, we obtain the momentum distribution in quasi-momentum $cal(D)_sigma ( k_x , q_y )$. Finally, the spin polarization can be calculated by $P ( k_x , q_y ) = frac(cal(D)_arrow.t ( k_x , q_y ) - cal(D)_arrow.b ( k_x , q_y ), cal(D)_arrow.t ( k_x , q_y ) + cal(D)_arrow.b ( k_x , q_y ))$.

*Fitting procedure* When the system is Hermitian, the spin polarization oscillates between the lowest two dressed states following Rabi process which can be described by a sinusoidal function. As the loss rate increases, we find that the time evolution gradually change to a monotonic exponential decay curve (#ref(<fig-3>)c). To obtain the Phase diagram of the PT-symmetry breaking and further explore the shift of EPs at different quasi-momentum, one can extract the energy band gap $Re ( Delta E )$ and damping rate $Im ( Delta E )$ with a damped sinusoidal fitting function. However, when the dissipation is large, the damping term dominates the time evolution curve and the fitting is not sensitive to the oscillation term. Therefore, we quantify the different behaviors before and after PT-symmetry breaking transition by fitting with both damped oscillation and exponential decay and compare the $R^2 = 1 - frac(sum_(i = 1)^n ( y_i - f ( x_i ) )^2, sum_(i = 1)^n ( y_i - macron(y) )^2)$. When the loss rate is large enough, the $R^2$ ratio between these two fits is close to 1, which indicates the unnecessary of the oscillation term when fitting the time evolution at a large loss (#ref(<fig-3>)b). With this method, we can estimate where the transition occurs and then fit the time evolution curve before and after the transition region with sinusoidal function and exponential function respectively to extract the energy band and damping rate (#ref(<fig-3>)a). For different $k_x / k_0$ (or equivalently $delta$), the loss rates of EPs are different.

*Reconstruction of complex eigen spectrum* The momentum uncertainty caused by the finite resolution of our imaging system and fluctuation of two-photon detuning will make the oscillation of polarization dephase even without spin-dependent dissipation. At the low dissipation regime, fitting the oscillation of spin polarization can not distinguish this type of dephasing from the decay induced by spin-dependent dissipation. To avoid this issue, when we reconstruct the complex eigenspectrum in the low dissipation regime, the imaginary part of the energy gap is determined by fitting the oscillation curve of spin-down atoms with the following equation

$ f ( t ) & = e^(2 Im (E_1) t) [ A ( 1 + e^(2 Im (E_2 - E_1) t) )\
 & - 2 B e^(Im (E_2 - E_1) t) cos Re (E_2 - E_1) t ]\
 & + 2 B - 2 A $

in which $Im ( E_2 - E_1 )$ is the imaginary band gap and the dephasing induced by the momentum uncertainty can be absorbed by the $e^(2 Im ( E_1 ) t)$ term without influencing the imaginary band gap in the low dissipation regime. During the fitting process, the initial values of the fitting parameters are determined from the damped oscillation fitting of the corresponding spin polarization data. This aids in guiding the fitting towards a solution that aligns with the appropriate physical parameters of our system. Further combined with the real part extracted from the oscillation curve of spin polarization, the complex eigenspectrum can be reconstructed.

*Numerical simulation in the real space* To see the NHSE of our optical lattice system, here we solve a 2D lattice model with open boundary cut along $x$ and $y$ directions. The model is obtained by applying s-band tight-binding approximation in the $y$ direction and finite-difference approximation in the $x$ direction on the experimental model in @eq-model. It acts on the local basis $| upright(bold(j)) s chevron.r$ centered at the site $upright(bold(j)) = ( j_x , j_y )$ with spin $s = ( arrow.t , arrow.b )$, which in the $y$ direction are the s-band Wannier functions. The Hamiltonian is

$ H_L = & sum_(upright(bold(j))) ( m_z | upright(bold(j)) arrow.t chevron.r chevron.l upright(bold(j)) arrow.t | - ( m_z + i gamma_arrow.b / 2 ) | upright(bold(j)) arrow.b chevron.r chevron.l upright(bold(j)) arrow.b |\
 & - sum_(k = x , y) [ ( t_arrow.t^k | upright(bold(j)) + arrow(e)_k arrow.t chevron.r chevron.l upright(bold(j)) arrow.t | - t_arrow.b^k | upright(bold(j)) + arrow(e)_k arrow.b chevron.r chevron.l upright(bold(j)) arrow.b | )\
 & + h . c . ] + ( t_(s o) e^(- i k_0 cos theta j_y) | upright(bold(j)) arrow.b chevron.r chevron.l upright(bold(j)) + arrow(e)_y arrow.t |\
 & - t_(s o) e^(i k_0 cos theta j_y) | upright(bold(j)) arrow.t chevron.r chevron.l upright(bold(j)) + arrow(e)_y arrow.b | + h . c . ) + V_(t r) ( upright(bold(j)) ) ) , $<eq-lattice>

where $m_z$ is the Zeeman energy, $gamma_arrow.b$ is the loss rate of spin-down atoms, $t_(arrow.t , arrow.b)^k$ are the nearest-neighbor spin-conserved hopping coefficients of the optical lattice in the $k = ( x , y )$ directions, $t_(s o)$ is the nearest-neighbor spin-flipped hopping coefficient in the optical lattice direction, and $theta = 76 degree , k_0 = pi / a_0$ with $a_0$ being the lattice constant in the $y$ direction. Here $t_arrow.t^x = t_arrow.b^x^(*) = i sin theta frac(a, 2 l_x pi) + frac(a^2, l_x^2 pi^2)$ where $l_x$ is the finite difference step-length. We could gauge out the phase factor $e^(plus.minus i k_0 cos theta j_y)$ with a transformation $| upright(bold(j)) arrow.b chevron.r arrow.r e^(i k_0 cos theta j_y) | upright(bold(j)) arrow.b chevron.r$ and obtain a commensurate lattice system explicitly.

$V_(t r) ( upright(bold(j)) ) = frac(m omega_x^2 j_x^2, 2 l_x^2) + frac(m omega_y^2 j_y^2, 2 a^2)$ is the trap potential. This 2D lattice model approximates the low-energy and long wavelength sector of the original system well, but may fail in the high-energy and short wavelength parts. #ref(<fig-4>)d shows the NHSE in the real space, in which the tight-binding parameters are set to be $t_(arrow.t ( arrow.b )) = 0.32 ( 0.38 ) E_r$ and

$t_(s o) = 0.25 E_r$ corresponding to the experimental parameters $V_(arrow.t ( arrow.b )) = 3.2 ( 2.2 ) E_r$ and $M_R = 2.0 E_r$. The dissipation rate is $gamma_arrow.b = 0.2 E_r$ and the Zeeman splitting is $m_z = - 0.3 E_r$. The step-length in the $x$ direction is chosen to be $x_0 = a_0 / 7$ and we see that the low-energy solutions within the s-band regime of the optical lattice have converged well enough (See Supplementary Information).

*Spatial distribution signal detection* To observe the signal of the NHSE in real space, we employ a quantum gas magnifier in our system~@asteria2021quantum. This magnifier is created by applying a far-detuned optical dipole trap along the z-direction prior to the absorption imaging process, which effectively establishes a harmonic trap in the x-y plane. By applying a harmonic potential with a trapping frequency of $omega_("M") = 2 pi / T$ for a duration of $T / 4$, we map the spatial distribution to the momentum distribution~@murthy2014matter @holten2022observation. Combining this with a subsequent free time-of-flight (TOF) expansion, we reproduce the initial spatial distribution with a magnification factor of approximately $M approx omega_("M") t_("TOF")$. For our specific experimental parameters, with $t_("TOF") = 10 "ms"$ and $omega_("M") / ( 2 pi ) = 181 "Hz"$, the quantum gas magnifier provides an additional magnification of approximately 11.4 on top of the magnification achieved through conventional absorption imaging with a magnification of 3.73, with the estimated resolution along 0.2$mu m$. It is important to note that the current magnification is not sufficient to resolve the lattice spacing. Therefore, during the calibration of the focusing condition, we hold the atom cloud in the harmonic trap for a time of $T / 2$, resulting in a momentum distribution opposite in direction to the initial momentum distribution.

Utilizing the quantum gas magnifier, we proceed to investigate the manifestation of NHSE in real space. It is important to note that when the atoms are located far away from the boundary, the presence or absence of the skin effect may have limited influence on the short-term evolution of the atom cloud~@guo2021theoretical @mao2021boundary. Therefore, we initially quench the atoms in the crossed dipole trap to the Hermitian optical Raman lattice and allow them to evolve for a specific duration, establishing an initial state with a velocity in the +x direction. Subsequently, the system is either subjected to another quench to the non-Hermitian Hamiltonian or maintained in the original Hermitian Hamiltonian. After a certain hold time, we perform real-space detection of the spin-up atoms using the quantum gas magnifier. To mitigate perturbations arising from misalignment between the magnifier beam and the cross optical dipole trap during the ramping of the magnifier, the magnifier beam is ramped up prior to preparing the initial state.

*Mapping to 4D curved space* Here we consider the low-energy models of our experimental system and establish the mapping to Hermitian models of free particles living in 4D curved spaces. We start from the s-band Bloch Hamiltonian in @eq-sbloch. For simplicity, we assume $t_arrow.t^y = t_arrow.b^y = t_y$ and apply an overall $( k_0 + k_1 ) / 2$ quasi-momentum shift in the $y$ direction. The coefficients are simplified as $h_y ( upright(bold(k)) ) = - 2 t_(s o) cos ( q_y a_0 )$, $h_z ( upright(bold(k)) ) = - ℏ^2 ( k_x k_2 ) / 2 m - 2 t_y sin ( q_y a_0 ) cos ( k_1 a_0 / 2 ) + m_z$, $h_0 ( upright(bold(k)) ) = ℏ^2 ( k_x^2 + k_2^2 / 4 ) / 2 m - 2 t_y cos ( q_y a_0 ) sin ( k_1 a_0 / 2 ) - i gamma_arrow.b / 4$. To explicitly reveal the origin of the non-Hermitian skin effect and the connection to curved spaces, we rewrite the model under the spin-orbital-coupled Bloch bands $| plus.minus , upright(bold(k)) chevron.r$, which diagonalize the Hermitian part of the Hamiltonian as $[ H ( upright(bold(k)) ) - i gamma_arrow.b / 4 sigma_z ] | plus.minus , upright(bold(k)) chevron.r = [ h_0 ( upright(bold(k)) ) plus.minus epsilon.alt ( upright(bold(k)) ) ] | plus.minus , upright(bold(k)) chevron.r$ with $epsilon.alt ( upright(bold(k)) ) = sqrt(h_z^2 + h_y^2)$. The model is rewritten as

$ tilde(H) ( upright(bold(k)) ) & = h_0 ( upright(bold(k)) ) + epsilon.alt ( upright(bold(k)) ) sigma_z + i gamma_arrow.b / 4 frac(h_z ( upright(bold(k)) ) sigma_z + h_y ( upright(bold(k)) ) sigma_y, epsilon.alt ( upright(bold(k)) )) . $<eq-newmodel>

The $i frac(gamma_arrow.b h_z ( upright(bold(k)) ), 4 epsilon.alt ( upright(bold(k)) )) sigma_z$ term contributes imaginary vector potential in the $x$ direction and imbalanced hopppings in the $y$ direction, both of which lead to NHSE. We restrict the following discussion in the long-wavelength and weak dissipation regime, i.e. $| k_x | , | q_y | arrow.r 0$ and $gamma_arrow.b < | m_z |$. Then $epsilon.alt ( upright(bold(k)) ) approx sqrt(m_z^2 + 4 t_(s o)^2) := E_0$ and the off-diagonal term in @eq-newmodel could be neglected (see Supplementary Information for details). Then the Hamiltonian is diagonalized by $| plus.minus , upright(bold(k)) chevron.r$, with diagonal terms

$ tilde(H)_plus.minus ( x , y ) & = ℏ^2 ( - i partial_x minus.plus i A_x )^2 / ( 2 m )\
 & + ℏ^2 ( - i partial_y minus.plus i A_y )^2 / ( 2 m_y ) plus.minus ( E_0 + frac(gamma_arrow.b delta_z, 4 E_0) ) , $<eq-hpm>

where $( A_x , A_y ) = ( frac(gamma_arrow.b k_2, 8 E_0) , frac(gamma_arrow.b cot ( k_1 a_0 / 2 ), 4 a_0 E_0) )$ and $m_y = 2 m t_y sin ( k_1 a_0 / 2 ) a_0^2 / ℏ^2$ is the effective mass at $q_y = 0$. We notice that this could be mapped to Hermitian models on curved spaces. Consider the 4D curved spaces $M^plus.minus ( zeta , eta , zeta' , eta' )$ with metrics

$ upright(bold(g))_plus.minus ( zeta , eta , zeta' , eta' ) = & ( zeta^(- 2) d zeta^2 + zeta^(minus.plus 2) (d zeta')^2 ) / ( 2 A_x )^2\
 & + ( eta^(- 2) d eta^2 + eta^(minus.plus 2) (d eta')^2 ) m_y / ( 4 m A_y^2 ) , $

respectively. The Hamiltonian of free particles are given by

$ H_("cv")^plus.minus ( zeta , eta , zeta' , eta' ) = & - frac(ℏ^2, 2 m) 1 / sqrt(g_plus.minus) sum_(j , k) partial_j upright(bold(g))_plus.minus^(j k) sqrt(g_plus.minus) partial_k , $

with $j , k$ running over $( zeta , eta , zeta' , eta' )$ and $g_plus.minus = det ( upright(bold(g_plus.minus)) )$. With a coordinate transformation $( zeta , eta ) = ( e^(- 2 A_x x) , e^(- 2 A_y y) )$, the low-energy Hamiltonians in @eq-hpm are mapped to Hermitian systems of the free particles on curved spaces, namely we have

$ tilde(H)_plus.minus ( x , y ) = H_("cv")^plus.minus ( zeta , eta , k_(zeta') = 0 , k_(eta') = 0 ) , $

where $k_(zeta' , eta')$ are the momenta components in $zeta' , eta'$ directions. $M^plus.minus ( zeta , eta , zeta' , eta' )$ are the Cartesian products of two pseudospheres. The eigenstates of $H_("cv")^plus.minus ( zeta , eta , k_(zeta') = 0 , k_(eta') = 0 )$ are localized on the corners of $( zeta , eta )$ under OBC, in agreement with the corner skin effect of $tilde(H)_plus.minus$.

*ACKNOWLEDGMENTS* GBJ acknowledges support from the RGC through 16306119, 16302420, 16302821, 16306321, 16306922, C6009-20G, N-HKUST636-22, and RFS2122-6S04. XJL was supported by National Key Research and Development Program of China (2021YFA1400900), the National Natural Science Foundation of China (Grants No. 11825401 and No. 12261160368), the Innovation Program for Quantum Science and Technology (Grant No. 2021ZD0302000). \

#show bibliography: set text(size: 9pt, lang: "en")
#show bibliography: set par(leading: 0.2em, spacing: 0.5em)
#bibliography("refs.bib", title: none)

#pagebreak()
#set page(columns: 1)
#counter(heading).update(0)
#counter(math.equation).update(0)
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)
#set heading(numbering: none)
#set math.equation(numbering: "(1)", supplement: none)
#set figure(supplement: "Figure", numbering: n => "S" + str(n))
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(weight: "bold")
#show heading.where(level: 2): set align(center)
#show heading.where(level: 2): set text(weight: "bold")
#show heading: set block(above: 1.2em, below: 0.7em)

#align(center)[
  #text(12pt, weight: "bold")[SUPPLEMENTARY INFORMATION]
  #v(0.5em)
  #text(10.5pt)[for]
  #v(0.5em)
  #text(10.5pt)[“Two-dimensional non-Hermitian skin effect in an ultracold Fermi gas”]
]
#v(1.0em)
#align(center)[#text(10pt)[Entong Zhao#super[1,\*], Zhiyuan Wang#super[2,\*], Chengdong He#super[1], Ting Fung Jeffrey Poon#super[2], Ka Kwan Pak#super[1], \
  Yu-Jun Liu#super[1], Peng Ren#super[1], Xiong-Jun Liu#super[2,3,4,†], Gyu-Boong Jo#super[1,5,‡]]]
#v(0.5em)
#align(center)[#block(spacing: 0.4em)[#text(9pt)[#super[1] Department of Physics, The Hong Kong University of Science and Technology, Clear Water Bay, Kowloon, Hong Kong, China] \
  #text(9pt)[#super[2] International Center for Quantum Materials, School of Physics, Peking University, Beijing 100871, China] \
  #text(9pt)[#super[3] Hefei National Laboratory, Hefei 230088, China] \
  #text(9pt)[#super[4] International Quantum Academy, Shenzhen 518048, China] \
  #text(9pt)[#super[5] IAS Center for Quantum Technologies, The Hong Kong University of Science and Technology, Hong Kong, China]]]
#v(1.0em)
#line(length: 100%, stroke: 0.5pt)
#v(0.4em)


= EXPERIMENTAL SETUP AND PROCEDURE <experimental-setup-and-procedure>

== Experimental setup <experimental-setup>

The spin-dependent 1D optical lattice potential along $y$ direction is generated by retro-reflecting a Gaussian laser beam with the frequency $omega$ blue detuned by 1GHz from the $""^"1" S_0 ( F = 5 / 2 ) arrow.r ""^"3" P_1 ( F' = 7 / 2 )$ transition of $""^"173" "Yb"$ atoms and the polarization linearly polarized along $x$ direction (@fig-s0). The electromagnetic field of the lattice beam can be written as $upright(bold(E_y)) prop hat(e)_x E_y cos ( k_0 y + omega t + phi.alt ) = bold(E)_(+) + bold(E)_(-)$, with $upright(bold(E))_plus.minus = 1 / sqrt(2) hat(e)_plus.minus E_y cos ( k_0 y + omega t + phi.alt )$ and $hat(e)_plus.minus = 1 / sqrt(2) ( hat(e)_x plus.minus i hat(e)_y )$, forming the lattice potential

$ V_sigma^("latt") ( y ) = sum_(F') (frac(ℏ Omega_(y , sigma , + , F')^2, 4 Delta_(y , F')) + frac(ℏ Omega_(y , sigma , - , F')^2, 4 Delta_(y , F'))) = V_sigma cos^2 ( k_0 y ) , $

where the effective Rabi frequency $Omega_(y , sigma , plus.minus , F') = chevron.l F , sigma | e frac(x + y, sqrt(2)) | F' , m_F plus.minus 1 chevron.r E_plus.minus$ and single-photon detunings $Delta_(y , F')$ are determined from all relevant transitions to the excited states $( F' = 7 / 2 , 5 / 2 , 3 / 2 )$ in the $""^"3" P_1$ manifold.

Another linearly ($pi$) polarized light with polarization direction $z$ and frequency $omega' = omega + delta omega$, denoted as $upright(bold(E_x)) prop hat(e)_z E_x e^(- i k_1 y + i k_2 x + omega' t + phi.alt')$, is applied along the direction with angle $76 degree$ tilted from the lattice incident beam and induces the Raman coupling between $| arrow.t chevron.r = | m_F = 5 / 2 chevron.r$ and $| arrow.b chevron.r = | m_F = 3 / 2 chevron.r$, where $k_1 = k_0 cos theta$ and $k_2 = k_0 sin theta$. The frequency difference $delta omega$ between the lattice lights and Raman light can be tuned by the acousto-optical modulators. The Raman coupling potential $M_R$ has the form

$ M_R ( x , y ) = sum_(F') frac(ℏ Omega_(x , sigma , + , F') Omega_(R , sigma , F'), 4 Delta_(y , F')) = M_0 cos ( k_0 y ) e^(- i k_1 y + i k_2 x) , $

with effective Rabi frequency $Omega_(R , sigma , F') = chevron.l F , sigma | e z | F' , m_F chevron.r E_x$.

// [figvision-cn] imgs/FigS0.png
// 子图a是一幅能级示意图，展示相关跃迁。图左侧和右侧分别
// 对应基态流形中两个超精细态，左列标注 m_F=1/2 的虚线能
// 级位于最上方，其下为间隔 8.1 MHz 的 m_F=3/2 实线能级，
// 再下方为间隔 Δ₁↑ 的实线能级，最下方为 m_F=3/2 实线能级。
// 右列标注 m_F=5/2 的虚线能级位于最上方，其下为间隔 1
// GHz 的实线能级，再下方为 m_F=5/2 实线能级，该能级向下
// 偏移标注 δ'。四条跃迁线自左下至右上依次为：Loss beam σ
// ⁻（点线，连接左侧 m_F=3/2 与 m_F=1/2）、Lattice σ⁻（实
// 线，连接左侧 m_F=3/2 与 m_F=3/2）、Lattice σ⁺（实线，
// 连接右侧 m_F=5/2 与 m_F=5/2）、Raman π（实线，连接右侧
// m_F=5/2 与 m_F=5/2）。图示意晶格光和拉曼光均相对互组合
// 跃迁蓝失谐，并在基态流形两个超精细态之间诱导拉曼跃迁。
// 子图b是光学拉曼晶格系统示意图。中心为棕色球体表示原子，
// 周围有 x、y、z 坐标轴，黑色箭头标注 B 表示磁场沿 z 方
// 向。系统中一束竖直方向的青色光束标注为 Loss beam；一束
// 深灰色光束倾斜穿过原子中心，标注为 Lattice beam E_y，
// 末端标有双箭头表示线偏振；一束浅蓝色光束从右上方倾斜入
// 射，标注为 Raman beam E_x，末端同样标有线偏振双箭头。
// Lattice beam E_y 与 Raman beam E_x 在原子处夹角标注为
// 76°。系统由沿 y 方向的一维光学晶格和沿与 y 方向成 76°
// 倾角方向的拉曼光束组成。 子图c是原子动量分布曲线图（二
// 维密度图）。横轴 q_y(k₀)，范围 -4 到 4，刻度为 -4、-2、
// 0、2、4；纵轴 k_x(k₀)，范围 -4 到 4，刻度为 -4、-2、0、
// 2、4。图中显示一个位于原点 (0,0) 附近的紫色高斯型密度
// 斑块，中心有一个黑点，标注 m_F=5/2。右下角色标标注
// Atom density，从 Low（白色）到 High（深紫色）。该图显
// 示原子主要布居在零动量附近，对应 m_F=5/2 态。 子图d是
// 与子图c同坐标范围的二维原子密度图。横轴 q_y(k₀)，范围
// -4 到 4；纵轴 k_x(k₀)，范围 -4 到 4。图中显示三个紫色
// 密度斑块，中心斑块位于 (0,0) 附近并标注 m_F=5/2，左侧
// 斑块位于约 (-1.3, 1) 处标注 m_F=3/2，右侧斑块位于约 (
// 1.3, 1) 处标注 m_F=3/2。三个斑块之间用黑色虚线连接，中
// 心斑块附近叠加一条黑色实线弧线。该图显示原子在动量空间
// 中布居到三个离散峰，对应拉曼跃迁导致的动量转移，并呈现
// m_F=5/2 与 m_F=3/2 态之间的耦合。
#figure(image("imgs/FigS0.png", width: 65%),
  caption: [
    *a*, Schematic energy level diagram with relevant transitions. Both the lattice and the Raman beams are blue-detuned from $""^"1" S_0 ( F = 5 / 2 ) arrow.r ""^"3" P_1 ( F' = 7 / 2 )$ intercombination transition and induce the Raman transition between the $| arrow.t chevron.r = | m_F = 5 / 2 chevron.r$ and $| arrow.b chevron.r = | m_F = 3 / 2 chevron.r$ hyperfine states of the $""^"1" S_0$ ground manifold. *b*, Our optical Raman lattice system, which consists of a 1D optical lattice along the y direction and another Raman beam along the direction with angle $76 degree$ tilted from the lattice incident beam, generating a periodic Raman potential. A loss beam with $sigma^(-)$ polarization is further applied along -z direction to realize the non-Hermiticity. *c*, Absorption image of $m_F$ = 5/2 atoms without quenching the two photon detuning ($t_f$=0ms) after 15ms time-of-flight. *d*, When the two photon detuning is quenched from $delta_i$ to $delta_f$, two $m_F$ = 3/2 atom clouds are coupled out from $m_F$ = 5/2 clouds after holding $t_f$=0.15ms, which shows the resonant spin flipping on particular quasi-momentum subspace.
  ]
)
<fig-s0>

To separate out spin-1/2 space from other hyperfine states of the ground manifold, we use an additional $sigma^(-)$ polarized 556nm light along the z direction called lift beam to induce spin-dependent ac stark shift. Notably, the spin-dependent lattice potential $V_(arrow.t ( arrow.b )) = 3.2 E_r ( 2.2 E_r )$ will induce an additional on-site energy difference $delta_0$ to the Bloch bands of two spin states, which can be compensated by the two-photon detuning. The quantized axis is fixed by the bias magnetic field of 13.6G along the z-direction, which will induce an 8.1MHz Zeeman splitting between adjacent $m_F$ states. The loss beam is $sigma^(-)$ polarized and red detuned by $Delta_arrow.b = 1.0$ or 1.6MHz and $Delta_arrow.t = 9.1$ or 9.7MHz with respect to $""^"1" S_0 ( F = 5 / 2 , m_F = 3 / 2 ) arrow.r ""^"3" P_1 ( F' = 7 / 2 , m_(F') = 1 / 2 )$ and $""^"1" S_0 ( F = 5 / 2 , m_F = 5 / 2 ) arrow.r ""^"3" P_1 ( F' = 7 / 2 , m_(F') = 3 / 2 )$. Based on CG-coefficients, the estimated ratio of loss rate between two spin states $gamma_arrow.b / gamma_arrow.t$ is around 110 for $Delta_arrow.b = - 1.0$MHz and 248 for $Delta_arrow.b = - 1.6$MHz, which means the $gamma_arrow.t$ term can be ignored. Remarkably, the loss beam will also induce an additional energy shift in two photon detuning, which we can compensate by tuning the frequency difference between Raman beam and lattice beam in our experiment.

// [figvision-cn] imgs/FigS1.png
// 图中包含两个并排的时序图子图，分别标记为 a 和 b，用于
// 对比两种实验序列的时间结构。 子图 a：左上角标注标题“
// Momentum resolved Rabi spectroscopy”。该图为多通道时序
// 图，横轴为时间，由贯穿全图的六条垂直黑色虚线划分出六个
// 阶段，底部标注各阶段名称，从左至右依次为：Ramp up
// lattice 1ms、Hold、Evolution time 0~0.4ms、Blast Pulse、
// Image Pulse。纵轴从上至下排列七个通道的标签：m_z(δ)、
// Raman、Lattice、Lift、Loss、ODT、Image /Blast。各通道
// 图形表示信号开启区间：m_z(δ) 通道在最上方，显示一条棕
// 褐色水平线，在第三阶段前有一个向上的阶跃并保持至第四阶
// 段结束；Raman 通道为浅蓝色梯形，从第一阶段开始线性上升，
// 在第二阶段保持平台，至第四阶段结束；Lattice 通道为深灰
// 色梯形，起止时间与 Raman 通道相同，但平台高度略低于
// Raman，且上升沿更陡；Lift 通道为更浅的蓝色梯形，形状与
// Raman 类似，但平台高度最低，且覆盖前四个阶段；Loss 通
// 道为灰绿色矩形，仅出现在第三阶段（Evolution time）；
// ODT 通道为淡紫色矩形，覆盖前四个阶段；最下方 Image /
// Blast 通道包含两个独立的矩形脉冲，一个浅绿色矩形位于第
// 四阶段（Blast Pulse），一个紫色矩形位于第五阶段（Image
// Pulse）。 子图 b：右上角标注标题“Spin polarization
// texture in equilibrium”。该图结构与子图 a 类似，同样为
// 多通道时序图，横轴为时间，由五条垂直黑色虚线划分出五个
// 阶段，底部标注各阶段名称，从左至右依次为：Ramp up lift、
// Ramp up lattice 8ms、Hold 1ms、Blast Pulse、Image
// Pulse。纵轴通道标签与子图 a 完全相同，从上至下依次为
// m_z(δ)、Raman、Lattice、Lift、Loss、ODT、Image /Blast。
// 各通道图形表示信号开启区间：m_z(δ) 通道为一条贯穿全图
// 的棕褐色水平直线，无阶跃变化；Raman 通道为浅蓝色梯形，
// 从第一阶段开始线性上升，在第二阶段结束时达到平台，并保
// 持至第三阶段结束；Lattice 通道为深灰色梯形，从第二阶段
// 开始线性上升，在第三阶段结束时达到平台，保持至第三阶段
// 结束，其上升沿比 Raman 通道更晚且更缓；Lift 通道为浅蓝
// 色梯形，从第一阶段开始线性上升，在第二阶段开始时达到平
// 台，并保持至第三阶段结束；Loss 通道在该子图中无任何图
// 形，表示该通道未激活；ODT 通道为淡紫色矩形，覆盖前三个
// 阶段；最下方 Image /Blast 通道包含两个独立的矩形脉冲，
// 一个浅绿色矩形位于第四阶段（Blast Pulse），一个紫色矩
// 形位于第五阶段（Image Pulse）。
#figure(image("imgs/FigS1.png", width: 90%),
  caption: [
    Experimental sequence for momentum resolved Rabi spectroscopy (*a*) and spin polarization texture measurement in equilibrium (*b*).
  ]
)
<fig-s1>

== Experimental procedure
<experimental-procedure>

The experimental sequence for the momentum resolved Rabi spectroscopy can be briefly described in #ref(<fig-s1>)a. A single-component degenerate $""^"173" "Yb"$ Fermi gas in the $| arrow.t chevron.r$ state is prepared with the optical pumping process during (with 399nm light) and after (with 556nm light) the evaporation. The atoms are then loaded into a 1D optical lattice potential by ramping up both the lattice and Raman laser intensity in 3ms with the initial two photon detuning $delta_i = - 27 E_r$ far enough to exclude the Raman coupling. The final lattice depth and Raman coupling strength are set to $V_(arrow.t ( arrow.b )) = 3.2 ( 2.2 ) E_r$ and $M_0 = 2.0 E_r$ ($"Er" = ℏ^2 k_0^2 / 2 m = h times 3.735 "kHz"$), which can be calibrated from Kapitza-Dirac diffraction and the two-photon Rabi oscillation, respectively. After the initial state preparation, we further hold the system for another 1ms and then quench the two-photon detuning from $delta_i$ to $delta_f$ at time $t = 0$ by controlling the RF signal of the acousto-optical modulator and the loss pulse is switched on at the same time. The atoms initially prepared in $| arrow.t chevron.r$ state start the Raman-Rabi oscillation between the lowest two bands in our system. Holding a variable time $t_f$, we record spin-sensitive momentum distribution after 10ms (or 15ms) time of flight expansion by applying the 556nm blast pulses resonant to $""^"1" S_0 ( F' = 5 / 2 ) arrow.r ""^"3" P_1 ( F' = 7 / 2 )$ transition.

In our Rabi spectroscopy, we found that there is no obvious difference between the lattice loading in 3ms and 9ms, probably because the final lattice depth is not quite deep. From the estimation of Kapitza-Dirac diffraction, even though the lattice is suddenly switched on, the maximum population for higher order is smaller than 30\% and the oscillation period is around $60 mu s$, much smaller than the hold time (1ms). Therefore, the shorter loading time will not affect the Rabi spectroscopy and will maximumly suppresses the heating and other detrimental effects. Besides, it is worth noting that the optical dipole trap is switched off at the same time as the quench dynamics starts. This is because, in previous experiments~[#link(<si-1>)[1], #link(<si-2>)[2]], we found the intraband transition induced by optical dipole trap will affect the time evolution. Since the time evolution is smaller than 0.4ms, the atoms fall less than 1$mu m$ under gravity, which is much smaller than the beam waist of the lattice and Raman beam and can be ignored in our experiment.

// [figvision-cn] imgs/FigS2.png
// 这幅科学论文插图由三个子图（a、b、c）组成，展示自旋极
// 化的平衡态特性。所有子图共享相同的纵轴物理量“Two
// photon detuning”（双光子失谐），单位为反冲能量 E_r，数
// 值范围从 -2.0（顶部）到 1.5（底部，纵轴向下递增），刻
// 度间隔为 0.5。所有子图的横轴均为“q_y(k_y)”，即沿 y 方
// 向的准动量，单位为反冲动量 k_r，范围从 -1 到 1，刻度间
// 隔为 1。 子图 a 为数值模拟的自旋极化二维伪彩色图（相图）。
// 横轴范围 -1 至 1 k_r，纵轴范围 -2.0 至 1.5 E_r。图中颜
// 色映射表示自旋极化值，红色代表正值（约 +1.0），蓝色代
// 表负值（约 -1.0），白色代表零值。图中呈现一个显著的 V
// 形结构：当双光子失谐从 -2.0 E_r 增大到约 0.7 E_r 时，
// 红色区域（正极化）逐渐变窄，在失谐约 0.7 E_r、q_y 为 0
// 附近收敛为一点；当失谐继续增大至 1.5 E_r 时，蓝色区域
// （负极化）占据主导并变宽。图中标注了黑色虚线，勾勒出极
// 化反转的边界。右侧标有字母“D_1”（失谐约 -1.5 E_r，q_y
// 约 0.8 处）和“D_2”（失谐约 0.7 E_r，q_y 为 0 处）。 子
// 图 b 为实验测量的自旋极化二维伪彩色图，坐标轴范围和物
// 理量与子图 a 相同。颜色映射与 a 图一致，右侧附有颜色条，
// 标尺从 -1.0（深蓝）到 1.0（深红），中间白色为 0，刻度
// 间隔 0.5。与 a 图相比，b 图的数据呈现明显的像素化网格
// 特征（水平与垂直条纹），但整体趋势一致：随着失谐从
// -2.0 增加到 1.5 E_r，红色正极化区域逐渐收窄，蓝色负极
// 化区域在底部扩展。黑色虚线同样勾勒出 V 形边界，标注了“
// D_1”（失谐约 -1.5 E_r，q_y 约 0.8 处）和“D_2”（失谐约
// 0.8 E_r，q_y 为 0 处）。在 D_2 点附近，数据点周围用浅
// 蓝色小圆圈标记。 子图 c 由六个较小的自旋极化曲线图组成，
// 排列为 2 行 3 列。每列对应一个特定的双光子失谐值，左列
// 为 δ=-1.6 E_r，中列为 δ=-0.3 E_r，右列为 δ=1.0 E_r；上
// 排为理论计算曲线，下排为对应的实验测量曲线。所有小图的
// 横轴为 q_y(k_y)，范围 -1 至 1，刻度间隔 1；纵轴为“Spin
// polarization”，范围 -1.0 至 1.0，刻度间隔 0.5（注：左
// 列理论图纵轴刻度标注为 0.0、0.5、1.0，仅显示正半轴，但
// 曲线延伸至 -0.5 以下）。每幅图中，黑色实线代表理论或实
// 验的自旋极化随 q_y 的变化，曲线与零轴（白色水平线）之
// 间的区域用颜色填充：红色代表正极化，蓝色代表负极化。
// 具体而言，左上图（δ=-1.6 E_r，理论）：曲线在 q_y 接近
// ±1 时急剧下降至约 -0.6，中间大部分区域（q_y 从 -0.6 到
// 0.6）维持在约 0.5 至 0.7 的正值，红色填充区域呈宽平顶
// 状。左下图（δ=-1.6 E_r，实验）：曲线形状与理论图高度吻
// 合，同样在边缘下降，中间为红色填充的正极化平台。中上图
// （δ=-0.3 E_r，理论）：曲线呈钟形，在 q_y=0 处达到峰值
// 约 0.6，向两侧平滑下降至约 -0.4，红色填充区域覆盖 |q_y
// | < 0.5 的范围，两侧为蓝色。中下图（δ=-0.3 E_r，实验）：
// 同样呈钟形曲线，峰值约 0.6，与理论一致，红色填充区域在
// 中心。右上图（δ=1.0 E_r，理论）：曲线在 q_y=0 处急剧上
// 升至约 0.9，两侧迅速下降至约 -0.9，蓝色填充区域占据绝
// 大部分，红色区域极窄，呈尖锐的峰。右下图（δ=1.0 E_r，
// 实验）：曲线在 q_y=0 处有一个较小的峰（约 0.2），两侧
// 下降至约 -0.2 至 -0.4，蓝色填充区域宽大，整体极化幅度
// 小于理论值，且曲线呈现微弱的起伏。 综上，该图展示了自
// 旋极化随双光子失谐和准动量 q_y 的变化规律：在负失谐（δ
// =-1.6 E_r）时，自旋极化在较大的 q_y 范围内保持正值；随
// 着失谐增加至 -0.3 E_r，正极化区域收窄并集中于 q_y=0 附
// 近；在正失谐（δ=1.0 E_r）时，自旋极化在 q_y=0 处出现尖
// 锐的正峰，两侧迅速变为负值。理论模拟（a、c 上排）与实
// 验测量（b、c 下排）在整体趋势上吻合，但实验数据存在明
// 显的网格化噪声和幅度衰减。
#figure(image("imgs/FigS2.png", width: 90%),
  caption: [
    Spin polarization of equilibrium state. *a* Numerical simulation of spin polarization as a function of two photon detuning $delta$. *b* Experimental measurement of spin polarization as a function of two photon detuning $delta$. *c* Theoretical and experimental spin polarization texture of the lowest band for $delta = - 1.6 , - 0.3 , 1.0 E_r$, respectively.
  ]
)
<fig-s2>

== Spin polarization of equilibrium state in Hermitian regime
<spin-polarization-of-equilibrium-state-in-hermitian-regime>

Except for the momentum-resolved Rabi spectroscopy, we also measured the spin polarization texture in equilibrium with experimental sequence in #ref(<fig-s1>)b. An optical ac Stark shift is added by a lift beam 2ms before the optical lattice potential, which separates out an effective spin-1/2 subspace from other hyperfine levels. The Raman beam and lattice beams are adiabatically switched on with an 8-ms exponential ramp to the final value. The 10ms spin-resolved time-of-light image is taken after a spin sensitive blast sequence to reconstruct the spin polarization texture. Dependent on the value of two photon detuning (equivalent to $k_x$), our system can form either a topological band or trivial band along $q_y$ direction, as shown in #ref(<fig-s2>)a. The experimentally measured spin polarization $P ( q_y )$ can be reconstructed from the integrated momentum distribution along $k_x$ direction within $k_x / k_0 = - 0.2$ to $0.2$, as shown in #ref(<fig-s2>)b, similar to the detection technique used in previous work~#link(<si-3>)[[3]]. When the two photon detuning is in the trivial regime, the spin polarization is either $| arrow.t chevron.r$ (red)-dominated or $| arrow.b chevron.r$ (blue)-dominated. However, when the Raman transition resonantly couples the lowest two bands, spin polarization changes from blue to red and blue again within the first Brillouin zone, which indicates the nonzero winding number and topological band~#link(<si-1>)[[1]] (#ref(<fig-s2>)c). Notably, since the atom number at higher $k_x$ is not enough for a good signal-to-noise ratio, we choose to fix $k_x$ and scan the value of two photon detuning instead of fixing the two photon detuning and changing $k_x$ to obtain the whole spin polarization texture in equilibrium case.

// [figvision-cn] imgs/FigS3.png
// 本图由四个子图（a、b、c、d）组成，展示原子损失校准的实
// 验方案与结果。 子图a为能级示意图。横轴不适用。图中左侧
// 画出一条斜向的蓝色箭头表示损耗光束，标注为“Loss beam”，
// 其旁标有“σ⁻”。蓝色箭头起始于一条虚线能级，向右上指向另
// 一条虚线能级，二者之间用Δ₁标注失谐，该起始能级的磁量子
// 数标为m_F=1/2。从该虚线能级向下有实线能级，标为m_F=3/2。
// 在m_F=1/2虚线与m_F=3/2实线之间存在第二条蓝色箭头，同样
// 由Δ₁标注。图中右侧另有一组能级：一条实线能级标为m_F=3/
// 2，其上方为m_F=5/2的虚线能级，二者间距标为8.1MHz。一条
// 红色斜箭头从m_F=3/2实线能级指向上方m_F=5/2虚线能级，旁
// 注Δ₂。图中还有两条垂直实线箭头分别从m_F=3/2实线指向下
// 方的m_F=1/2实线，以及从m_F=5/2实线指向下方的m_F=3/2实
// 线，各带一个圆点符号：前者为蓝色实心圆点，后者为红色带
// 斜线圆点。该图示意自旋相关的能级结构与损耗跃迁路径。
// 子图b为能级跃迁示意图。横轴不适用，图中以水平粗线表示
// 从m_F=-7/2到m_F=7/2的各级能级，分上下两排排列。上排能
// 级标注为m_F=7/2、5/2、3/2、1/2、-1/2、-3/2、-5/2、-7/2；
// 下排能级标注为m_F=5/2、3/2、1/2、-1/2、-3/2、-5/2、-7/
// 2。两排能级之间由多条斜向箭头连接，箭头颜色分红色和橙
// 色两组，每组箭头按固定偏振方向连接相邻的磁子能级。图中
// 标注有跃迁相对强度数值：红色箭头标注“1/12”和“1/3”，橙
// 色箭头标注“1/6”、“1/3”、“1/2”等，图中左侧标注“(1/63 ×)
// ”。该图表示窄线宽互组跃迁对不同磁子能级的相对光学跃迁
// 强度。 子图c为曲线图。横轴为“Hold time (ms)”，范围0.0
// 至0.45，主刻度为0.0、0.1、0.2、0.3、0.4。纵轴为“
// Relative atom number”，范围0.0至1.0，主刻度为0.0、0.2、
// 0.4、0.6、0.8、1.0。图中有两条数据序列：一条为深蓝色圆
// 点及实线拟合曲线，对应标注“0.89E_r”；另一条为浅红色方
// 块及实线拟合曲线，对应标注“0.03E_r”。图右侧另有两个单
// 独圆点：一个深蓝色带斜线圆点（标注0.89E_r）和一个暗红
// 色带斜线圆点（标注0.03E_r），二者未与曲线连接。深蓝曲
// 线从约1.0快速衰减，在0.1ms附近降至约0.2，0.2ms后接近
// 0.05；浅红曲线衰减缓慢，0.45ms时仍约0.65。该图给出相同
// 光强下自旋向下态与自旋向上态的损耗率校准，显示二者损耗
// 速率存在明显差异。 子图d为曲线图。横轴为“Hold time (ms
// )”，范围0.0至0.45，主刻度同c。纵轴为“Relative atom
// number”，范围0.0至1.0，主刻度同c。图中包含四组数据及拟
// 合曲线，图例标注为：浅蓝空心圆点及线“0.00E_r”；中蓝实
// 心圆点及线“0.56E_r”；亮蓝实心圆点及线“1.02E_r”；深蓝近
// 黑色实心圆点及线“2.18E_r”。浅蓝曲线近乎水平，从约1.0缓
// 慢降至约0.9；中蓝曲线从约1.0指数衰减至0.4ms时近0.05；
// 亮蓝曲线衰减更快，0.2ms后接近0；深蓝近黑曲线衰减最快，
// 约0.1ms即降至0.1以下。该图给出自旋向下态在不同损耗光束
// 强度下的损耗率校准，强度越高损耗越快。
#figure(image("imgs/FigS3.png", width: 90%),
  caption: [
    Calibration of the atomic loss. *a* Schematic energy level for spin dependent loss. *b* Relative optical transition strength of different $m_F$ states for the narrow intercombination transition $""^"1" S_0 ( F = 5 / 2 ) arrow.r ""^"3" P_1 ( F = 7 / 2 )$. *c* Loss rate calibration for spin-down and spin-up state at same optical intensity. *d* Loss rate calibration for spin-down state at variable intensity of the loss beam.
  ]
)
<fig-s3>

== Calibration of the atomic loss
<calibration-of-the-atomic-loss>
In our system, the spin dependent loss is induced by an optical pumping beam at a small detuning from the narrow intercombination transition $""^"1" S_0 ( F = 5 / 2 ) arrow.r ""^"3" P_1 ( F = 7 / 2 )$, as shown in #ref(<fig-s3>)a. The optical pumping beam is red detuned by $Delta_arrow.b = 1.0$ or 1.6MHz and $Delta_arrow.t = 9.1$ or 9.7MHz with respect to $| arrow.b chevron.r arrow.r | m_(F') = 1 / 2 chevron.r$ and $| arrow.t chevron.r arrow.r | m_(F') = 3 / 2 chevron.r$, together with the relative optical transition strength or CG-coefficients (#ref(<fig-s3>)b), resulting in the spin dependence of atomic loss. In our experiment, we first prepare the atoms on specific spin state $| sigma chevron.r = | arrow.t chevron.r$ or $| arrow.b chevron.r$ in optical lattice and then suddenly switching on the loss pulse. The two photon detuning $m_z ( delta )$ is kept constant and large enough ($delta tilde - 134 E_r$) to avoid the Raman coupling during the pulse, and the relative atom number on specific state can then be resolved by optical Stern Gerlach measurment. The experimental sequence for other optical beams are same as that in momentum resolved Rabi spectroscopy measurement to avoid the effect of other types of dissipation. We further calibrate the loss rate by fitting the relative atom number of spin states $| sigma = arrow.t , arrow.b chevron.r$ with $f ( t ) = A e^(- gamma_sigma / ℏ t) + B$ and the loss rate is tunable by controlling the power of the loss beam (#ref(<fig-s3>)c). From the calibration, the loss rate between two spin states $gamma_arrow.b / gamma_arrow.t$ is larger than 20 for $Delta_arrow.b = - 1.6$MHz.

// [figvision-cn] imgs/FigS4.png
// 该图由三个子图（a、b、c）组成，每个子图均为一组 4×8 的
// 二维动量空间热图矩阵，展示了自旋极化纹理随时间的演化。
// 子图 a：自旋极化纹理（spin polarization texture）的二
// 维动量依赖时间演化。 矩阵行方向表示不同的初始自旋极化
// 率 γ₁，从上到下依次标注为 γ₁=0.0Eᵣ、γ₁=0.4Eᵣ、γ₁=1.0Eᵣ、
// γ₁=2.1Eᵣ。矩阵列方向表示时间 t，从左到右依次标注为 t=
// 0.00、0.04、0.08、0.12、0.16、0.20、0.24、0.28 ms。 每
// 个面板的横轴为 qₓ(k₀)，范围 -1 到 1；纵轴为 k_y(k₀)，
// 范围 -0.5 到 0.5。最右侧有一个颜色条，范围从 -1.0（深
// 蓝）到 1.0（深红），中间 0.0 为白色，表示自旋极化分量
// 的大小和符号。 在 t=0.00 时，所有行均为均匀的红色（约
// 1.0）。随时间推移，在 γ₁=0.0Eᵣ 行中，t=0.08 至 0.16 ms
// 期间出现明显的蓝色负极化区域，随后在 t=0.20 ms 后逐渐
// 恢复为红色。在 γ₁=0.4Eᵣ 行中，蓝色区域出现时间稍晚且强
// 度较弱。在 γ₁=1.0Eᵣ 和 γ₁=2.1Eᵣ 行中，蓝色区域几乎不可
// 见，整体保持红色。这表明较大的初始极化率抑制了自旋纹理
// 的演化。 子图 b：归一化自旋向上纹理（normalized spin
// up texture）。 布局与子图 a 相同，行标签为 γ₁=0.0Eᵣ、
// 0.4Eᵣ、1.0Eᵣ、2.1Eᵣ，列标签为 t=0.00 至 0.28 ms。横轴
// qₓ(k₀) 范围 -1 到 1，纵轴 k_y(k₀) 范围 -0.5 到 0.5。右
// 侧颜色条范围从 0.0（白色）到 1.0（深红），表示归一化自
// 旋向上分量。 所有面板整体呈红色，但随时间推移，在 γ₁=
// 0.0Eᵣ 和 0.4Eᵣ 行中，红色区域在 t=0.08 至 0.20 ms 期间
// 出现局部变白（值降低）的纹理，而在 γ₁=1.0Eᵣ 和 2.1Eᵣ
// 行中，颜色变化较小，保持较均匀的红色。 子图 c：归一化
// 自旋向下纹理（normalized spin down texture）。 布局与
// 子图 a 相同，行标签为 γ₁=0.0Eᵣ、0.4Eᵣ、1.0Eᵣ、2.1Eᵣ，
// 列标签为 t=0.00 至 0.28 ms。横轴 qₓ(k₀) 范围 -1 到 1，
// 纵轴 k_y(k₀) 范围 -0.5 到 0.5。右侧颜色条范围从 0.0（
// 白色）到 1.0（深蓝），表示归一化自旋向下分量。 在 t=
// 0.00 时，所有面板为白色（接近 0.0）。随时间推移，在 γ₁
// =0.0Eᵣ 行中，t=0.08 至 0.16 ms 期间出现明显的蓝色区域，
// 随后在 t=0.20 ms 后逐渐变淡。在 γ₁=0.4Eᵣ 行中，蓝色区
// 域出现较晚且强度较弱。在 γ₁=1.0Eᵣ 和 2.1Eᵣ 行中，蓝色
// 区域几乎不可见，整体保持白色。该趋势与子图 a 中自旋极
// 化纹理的演化一致。 整体结论：初始自旋极化率 γ₁ 越小，
// 自旋向上和自旋向下纹理在动量空间中的时间演化越显著；γ₁
// 越大，纹理演化越弱，系统更趋于保持初始均匀极化状态。
#figure(image("imgs/FigS4.png", width: 90%),
  caption: [
    2D momentum dependent time evolution for spin polarization texture $P ( k_x , q_y , t )$ in *a*, normalized spin up texture $cal(D)_arrow.t ( k_x , q_y , t ) / cal(D)_arrow.t ( k_x , q_y , t = 0 )$ in *b*, normalized spin down texture $cal(D)_arrow.b ( k_x , q_y , t ) / cal(D)_arrow.t ( k_x , q_y , t = 0 )$ in *c* with $gamma_arrow.b = 0.0 , 0.4 , 1.0 , 2.1 E_r$, respectively.
  ]
)
<fig-s4>

// [figvision-cn] imgs/FigS5.png
// 该图由六个二维伪彩色图子图组成，按两行三列排布，右侧设
// 有一个共享的竖直色标。该图展示的是在0毫秒至0.30毫秒演
// 化时间窗口内、不同弛豫率γ1条件下，时间平均的自旋极化二
// 维纹理。所有子图均为直角坐标系下的颜色映射图，坐标轴没
// 有单位标注，刻度值由大写字母k或q与下标表示。 坐标轴方
// 面，仅最下面一行中间的图（整体排布中的e图）标出了横轴
// 名称q_y(k_0)，其刻度从左至右为1、0、-1；仅最左侧一列上
// 方的图（a图）标出了纵轴名称k_x(k_0)，其刻度从上至下为
// -0.5、0.0、0.5，并且仅标注了这几个主要刻度。其余子图共
// 用相同的坐标尺度，仅显示刻度短线。 色标位于图的最右侧，
// 范围从-1.0到1.0，刻度为-1.0、-0.5、0.0、0.5、1.0，对应
// 的颜色依次为深蓝、浅蓝、白、浅红、深红。颜色代表自旋极
// 化的数值，白色对应0.0，红色为正极化，蓝色为负极化。 六
// 个子图按从左到右、从上到下的顺序如下： 子图a位于左上角，
// 右上角标注文字的转写为γ1=0.0E_r。该图的颜色以浅红色至
// 近白色为主，左下角区域呈现相对较强的浅红色，右上角区域
// 颜色较淡接近白色，整体未出现蓝色区域。 子图b位于上排中
// 间，右上角标注文字的转写为γ1=0.5E_r。该图的整体红色强
// 度比子图a有所提高，左下角区域红色更深，接近中等偏浅的
// 红色，其余区域仍以浅红至近白色为主。 子图c位于右上角，
// 右上角标注文字的转写为γ1=1.0E_r。该图左下角区域红色进
// 一步加深，呈现明显的浅红色到中等红色，中央及右上方区域
// 颜色仍较浅。 子图d位于左下角，右上角标注文字的转写为γ1
// =1.2E_r。该图整体色调偏红，左下角区域红色较深，中心区
// 域出现较淡的浅红色斑块，右半部分红色较为均匀。 子图e位
// 于下排中间，右上角标注文字的转写为γ1=1.8E_r。该图整体
// 呈现较为均匀的浅红色，左下角区域红色最深，右上角颜色相
// 对较淡，红色分布较前几幅图更加均一。 子图f位于右下角，
// 右上角标注文字的转写为γ1=2.1E_r。该图整体红色程度最高
// 且分布最均匀，仅左下角局部略深，其余区域呈一致的浅红色
// 至中等红色，未见明显白色区域。 整体趋势方面，随着γ1从
// 0.0E_r增加到2.1E_r，图像中的颜色由左下角较强、右上角较
// 弱的浅红色不均匀分布，逐渐演变为整体均匀且红色程度增强
// 的分布。所有子图均未出现对应负极化值的蓝色区域，数值范
// 围集中在0.0到约0.5之间，说明时间平均后的自旋极化以正值
// 为主，并随γ1增大而增强且空间分布趋于均匀。
#figure(image("imgs/FigS5.png", width: 85%),
  caption: [
    2D time averaged spin polarization texture obtained by the evolution from 0 ms to 0.30 ms with $gamma_arrow.b = 0.0 , 0.5 , 1.0 , 1.2 , 1.8 , 2.1 E_r$, respectively.
  ]
)
<fig-s5>

== Momentum-dependent time evolution
<momentum-dependent-time-evolution>

To obtain the spin information in the quasi-momentum space, we take a series of spin resolved absorption images $( cal(I)_1 ( "no atoms killed" ) , cal(I)_2 ( | arrow.t chevron.r "atoms killed" ) , cal(I)_3 ( | arrow.t , arrow.b chevron.r "atoms killed" ) )$ after a 10ms or 15ms time-of-flight expansion. The atomic distribution of spin up and spin down can be extracted from $cal(I)_arrow.t ( k'_x , k_y ) = cal(I)_1 - cal(I)_2$ and $cal(I)_arrow.b ( k'_x , k_y ) = cal(I)_2 - cal(I)_3$. Notably, a fraction of atoms may occupy other spin states due to the imperfect isolation of the spin-$1 / 2$ subspace or spontaneous emission of the atoms on excited states pumped by the loss beam, which can be eliminated by the background image $cal(I)_3$. The atomic distributions $cal(I)_sigma ( k'_x , k_y )$ are then folded into the first Brillouin zone by shifting the second and third Brillouin zone with integer number of $2 k_0$, $cal(D)_sigma ( k'_x , q'_y ) = sum_(n = - 1)^1 cal(I)_sigma ( k'_x , q'_y + 2 n k_0 )$. After that, based on the spin-momentum locking, momentum distributions in quasi-momentum are defined as $cal(D)_arrow.t ( k_x , q_y ) = cal(D)_arrow.t ( k'_x , q'_y )$ and $cal(D)_arrow.b ( k_x , q_y ) = cal(D)_arrow.b ( k'_x + k_0 sin theta , "mod" ( q'_y + k_0 - k_0 cos theta , 2 k_0 ) )$, where mod is the modulo operator. Finally, the spin polarization can be calculated by $P ( k_x , q_y ) = frac(cal(D)_arrow.t ( k_x , q_y ) - cal(D)_arrow.b ( k_x , q_y ), cal(D)_arrow.t ( k_x , q_y ) + cal(D)_arrow.b ( k_x , q_y ))$. The time evolution of spin polarization texture, normalized spin up texture and spin down texture are shown in @fig-s4. In the Hermitian regime with $gamma_arrow.b = 0 E_r$, the spin polarization at different quasi momentum oscillates with different frequency following Rabi process after quenching the two photon detuning and a line structure appears at specific time (0.08$tilde$0.20ms), which reveals a non-uniform band gap. When the spin-dependent atomic loss is induced, the oscillation frequency at quasi-momentum near the line structure become slower and the oscillation amplitude becomes smaller, which indicates the band gap closing behavior. The line structure, where the Raman coupling is resonant, can also be found in normalized spin up and spin down texture as shown in #ref(<fig-s4>)b-c. In particular, when the dissipation is comparable with the Raman coupling, since the spin up atoms near the line structure are constantly transfered to the spin down states by the two photon Raman process and the spin down atoms experienced a large atomic loss, there are few atoms return spin up state, which makes the line structure in spin up texture (#ref(<fig-s4>)b) can be observed for longer duration than Hermitian case. We can further obtain the time averaged spin texture by averaging the data with evolution time from 0 ms to 0.30 ms after quenching $m_z ( delta )$ as shown in @fig-s5, where the zero time-averaged spin polarizations indicate the band inversion surface in Hermitian regime~[#link(<si-4>)[4], #link(<si-5>)[5], #link(<si-3>)[3]].

// [figvision-cn] imgs/FigS6.png
// 子图a为五幅并排的二维伪彩色图，横轴均为\(q_y(k_0)\)，
// 范围从-1到1；纵轴表示保持时间（Hold time），单位毫秒（
// ms），范围从0.00到0.30，刻度间隔0.05 ms。每幅子图上方
// 标注不同的损耗率参数\(\gamma_1\)，从左到右依次为\(\
// gamma_1=0.0E_r\)、\(\gamma_1=0.4E_r\)、\(\gamma_1=
// 1.0E_r\)、\(\gamma_1=1.8E_r\)、\(\gamma_1=2.1E_r\)。右
// 侧共用色标表示自旋极化率，数值范围从-1.0（深蓝色）到
// 1.0（深红色），中间值为0.0对应白色，相邻刻度间隔0.5。
// 各子图显示不同损耗率下自旋极化随时间与准动量\(q_y\)的
// 演化。在最左侧子图（\(\gamma_1=0.0E_r\)）中，保持时间
// 约0.13至0.15 ms、\(q_y\)约-0.5至0.5范围内出现一块明显
// 偏蓝区域，表示自旋极化率降至约-0.2至-0.5；随着损耗率增
// 大（\(\gamma_1=0.4E_r\)至2.1E_r），该蓝色区域逐渐缩小
// 并消失，整幅图趋于以浅红至红色为主。所有子图显示在保持
// 时间0.20至0.25 ms和0.28至0.30 ms附近存在水平的条带状结
// 构。该子图说明，增大损耗率会抑制自旋极化信号，导致原子
// 数减少和极化特征消失。 子图b为五幅并排的二维伪彩色图，
// 横轴均为\(q_x(k_0)\)，范围从-1到1；纵轴均为\(k_y(k_0)\
// )，范围从-0.5到0.5（从上到下递增）。每幅子图上方标出对
// 应的耗散强度（dissipation strength），从左到右分别为\(
// \gamma_1=0.0E_r\)、\(\gamma_1=0.4E_r\)、\(\gamma_1=
// 1.0E_r\)、\(\gamma_1=1.2E_r\)、\(\gamma_1=2.1E_r\)。右
// 侧共用色标表示能隙（band gap），数值范围从0.0（深红至
// 黑色）到1.6（白色），刻度为0.0、0.8、1.6。图中不同颜色
// 表示从自旋极化纹理重建出的二维能隙大小。前两幅子图（\(
// \gamma_1=0.0E_r\)和\(\gamma_1=0.4E_r\)）整体偏暗，能隙
// 值多数接近0.0至0.3，仅在中心附近有微弱变化；从\(\
// gamma_1=1.0E_r\)起，图像中心区开始出现橙黄色区域，能隙
// 值升高到约0.8至1.0；在\(\gamma_1=1.2E_r\)子图中，中心
// 区域出现明显的亮黄色至白色带状/斑块，能隙值接近1.2至
// 1.6，说明耗散强度接近奇异点（exceptional point）时能隙
// 重建信号增强。在最右侧\(\gamma_1=2.1E_r\)子图中，整体
// 以橙色为主，中心偏左位置（约\(q_x=-0.2\)、\(k_y=0.1\)）
// 用黑色记号“X”标出，图注说明当损耗率接近奇异点时，原子
// 数显著减少，导致部分准动量无法获得合理的拟合结果，这些
// 点以黑色叉号标记。该子图显示，随着耗散强度增加，重建的
// 二维能隙在奇异点附近显著增大，并在极高损耗率下出现部分
// 数据缺失。
#figure(image("imgs/FigS6.png", width: 90%),
  caption: [
    *a*, Time evolution of spin polarization for different loss rate at $k_x = 0$ layer. *b*, The 2D band gap reconstructed from the spin polarization texture at different dissipation strength. When the loss rate is closed to the exceptional point, the significantly reduced atom number makes it hard to obtain reasonable fitting result for some quasi-momentum, which is marked by the black cross.
  ]
)
<fig-s6>

== Extraction of band gap information
<extraction-of-band-gap-information>

In #ref(<fig-s6>)a, the time dependent spin texture at $k_x = 0$ for different dissipation strength is shown. From the time-dependent spin polarization curve, one can roughly extract the band gap information with a empirical damped sinusoidal function $f ( t ) = A e^(- B t) cos C t + 1 - A$, where B corresponds to the imaginary part of energy gap and C corresponds to the real part of energy band. The extracted 2D band gap are shown in #ref(<fig-s6>)b, which shows similar ring-like pattern as simulation from plane wave expansion in #ref(<fig-2>)a.

// [figvision-cn] imgs/FigS8.png
// 主图是一张二维散点图，展示重构的能隙随准动量 q_y 的变
// 化。横轴为 q_y(k_0)，范围从 -1.00 到 1.00，主刻度间隔
// 为 0.25；纵轴为 Band gap (E_r)，范围从 0.0 到 1.3，主
// 刻度间隔为 0.2，单位是反冲能量 E_r。图中有两组带误差棒
// 的数据点：第一组为深灰色实心圆点，表示失谐量 δ =
// -1.4E_r 的能隙；第二组为浅蓝色实心圆点，表示失谐量 δ =
// -0.3E_r 的能隙。这些点由细线连接，误差棒代表拟合误差。
// 整体趋势呈拱形：在 q_y = -1.00 处，深灰色点约为 1.0，
// 浅蓝色点约为 0.9；随着 q_y 向 0 增加，两组数据均上升；
// 到达 q_y ≈ 0.25 附近时达到峰值，深灰色点约 1.2，浅蓝色
// 点约 1.1；随后数据缓慢下降，在 q_y = 1.00 处深灰色点降
// 至约 0.9，浅蓝色点降至约 0.85。深灰色点始终略高于浅蓝
// 色点，两者差值随 q_y 接近 0 而减小。 主图下方包含两个
// 并排的二维伪彩色图，右下角颜色条标注数值范围从 0.8 到
// 1.2，颜色由黑（低值，约 0.8）、暗红、亮红到白（高值，
// 约 1.2）过渡，代表能隙大小。左侧子图标题为 δ = -1.4E_r，
// 其横轴为 q_y(k_0)，范围从 -1 到 1；纵轴为 k_x(k_0)，范
// 围从 0.0 到 1.0，刻度为 0.0、0.5、1.0，纵轴旁标注 k_x(
// k_0)。图中有一条贯穿水平方向、在纵轴 0.5 处的灰色虚线。
// 亮红色至白色的高值区域分布在 q_y 接近 0 的位置，黑色低
// 值区域出现在 q_y 接近 0.2 的下方以及 q_y ≈ -0.3 的上方。
// 右侧子图标题为 δ = -0.3E_r，横轴同样为 q_y(k_0)，范围
// 从 -1 到 1，刻度 -1、0、1；纵轴标注为 k_x(k_0)，范围从
// -0.5 到 0.5，刻度 -0.5、0.0、0.5。该子图中灰色虚线位于
// 纵轴 0.0 处，亮红高值区集中在 q_y ≈ 0.5 附近，暗黑低值
// 区位于 q_y ≈ 0 的下方。两者对比说明，不同失谐量下能隙
// 在动量空间中的分布位置和形状存在明显差异。
#figure(image("imgs/FigS8.png", width: 65%),
  caption: [
    Comparison between reconstructed band gaps for $delta = - 0.3 E_r$ (inset on the right) and $delta = - 1.4 E_r$(inset on the left). For $delta = - 1.4 E_r$, the data is further shifted along $k_x$ direction during the analysis to compensate the difference of two photon detuning. The error bars stand for the fitting error.
  ]
)
<fig-s8>

However, the phase diagram obtained from this empirical method deviates from the theoretical simulation, as shown in the inset of #ref(<fig-3>)a. Even prior to the exceptional point, a finite damping rate exists, and the oscillation frequency obtained from fitting cannot be completely zero or may have a large fitting error after exceptional point. There are three primary reasons why the phase diagram deviates from the simulation. Firstly, in addition to the uncertainty of atom loss caused by the power fluctuation of the loss beam (green shaded region in #ref(<fig-3>)a), there is also momentum uncertainty induced by the finite resolution of the imaging system and the fluctuation of two-photon detuning in the system. This uncertainty causes the oscillation curve to dephase even without spin-dependent dissipation. In @fig-3, the effect of this type of momentum uncertainty on the phase diagram is labeled by the brown shaded region and explain the reason that the imaginary band gaps obtained by empirical damped sinusoidal function appear before the exceptional points. Secondly, when the dissipation is comparable to exceptional points, the atom number is significantly reduced, and the oscillation curve becomes a monotonic decay curve dominated by dissipation, making it difficult to obtain the oscillation term and further determine the position of the exceptional point. Finally, the theoretical time evolution is not a perfectly damped oscillation, which also contributes to the deviation.

// [figvision-cn] imgs/FigS9.png
// 图分为上下两行，分别标记为a和b；每行由左侧一个复平面散
// 点图与右侧两个时间演化曲线图组成。整体展示在复平面上重
// 构能带差以及对应的自旋极化和归一化自旋向下随脉冲时间的
// 演化。 子图a左侧：复平面散点图。横轴为Re(ΔE) (E_r)，范
// 围0.7至1.2，刻度间隔0.1；纵轴为|Im(ΔE)| (E_r)，范围
// -0.4至0.4，刻度间隔0.2。图中包含大量浅灰色小圆点作为背
// 景数据，分布在横轴0.8至1.1、纵轴约-0.02至0.35之间，在
// 纵轴0附近形成一条水平点带。一条由青色实心圆点连接成的
// 曲线位于纵轴0附近，横跨约0.84至1.06，覆盖水平点带；该
// 曲线上有一个黑色五角星标记，位于横轴约1.02、纵轴约0.01
// 处。该子图传达在复平面上选取的特定本征谱点（星标）附近，
// 虚部接近零，实部在0.8至1.1范围内。 子图a右侧上：时间演
// 化曲线图。横轴为Pulse time (ms)，范围0.0至0.4，刻度间
// 隔0.1；纵轴为Spin polarization，范围-1至1，刻度间隔1。
// 实验数据以深青色空心圆点表示，拟合结果为浅青色实线。曲
// 线从脉冲时间0.0 ms处自旋极化约0.95开始，单调下降至约
// 0.12 ms处接近0，随后缓慢回升至约0.3 ms处约0.5，之后略
// 微下降至0.4 ms处约0.2。拟合线穿过大部分数据点。 子图a
// 右侧下：时间演化曲线图。横轴为Pulse time (ms)，范围0.0
// 至0.4，刻度间隔0.1；纵轴为Spin down，范围0.0至1.0，刻
// 度间隔0.5。实验数据以深青色空心圆点表示，拟合结果为浅
// 青色实线。曲线从0.0 ms处接近0开始，上升至约0.12 ms处峰
// 值约0.6，然后下降至约0.25 ms处约0.2，再上升至约0.38 ms
// 处约0.45。拟合线跟随数据点。 子图b左侧：复平面散点图。
// 横轴为Re(ΔE) (E_r)，范围0.7至1.2，刻度间隔0.1；纵轴为|
// Im(ΔE)| (E_r)，范围0.2至0.6，刻度间隔0.1。图中包含大量
// 浅灰色小圆点作为背景数据，分布在横轴0.75至1.15、纵轴
// 0.22至0.58之间。一条由青色实心圆点连接成的曲线呈现折线
// 形状：从横轴约0.82、纵轴约0.28开始，上升至横轴约0.88、
// 纵轴约0.47，然后下降至横轴约0.95、纵轴约0.34，再上升至
// 横轴约1.08、纵轴约0.52。该曲线上有一个黑色五角星标记，
// 位于横轴约0.95、纵轴约0.35处。该子图传达在复平面上选取
// 的特定本征谱点（星标）附近，虚部非零，实部在0.8至1.1范
// 围内，且曲线呈现非单调变化。 子图b右侧上：时间演化曲线
// 图。横轴为Pulse time (ms)，范围0.0至0.4，刻度间隔0.1；
// 纵轴为Spin polarization，范围-1至1，刻度间隔1。实验数
// 据以深青色空心圆点表示，拟合结果为浅青色实线。曲线从
// 0.0 ms处自旋极化约0.95开始，单调下降至约0.15 ms处接近0，
// 随后回升至约0.25 ms处约0.5，之后略微下降至0.4 ms处约
// 0.2。拟合线穿过大部分数据点。 子图b右侧下：时间演化曲
// 线图。横轴为Pulse time (ms)，范围0.0至0.4，刻度间隔0.1；
// 纵轴为Spin down，范围0.0至1.0，刻度间隔0.5。实验数据以
// 深青色空心圆点表示，拟合结果为浅青色实线。曲线从0.0 ms
// 处接近0开始，上升至约0.12 ms处峰值约0.45，然后下降至约
// 0.3 ms处约0.1，之后保持在约0.1至0.15之间。拟合线跟随数
// 据点。
#figure(image("imgs/FigS9.png", width: 78%),
  caption: [
    Reconstructing the band difference on the complex plane. *a*, Time evolution of spin polarization and normalized spin down for selected point on the complex eigen spectrum with $gamma_arrow.b = 0.0 E_r$. *b*, Time evolution of spin polarization and normalized spin down for selected point on the complex eigen spectrum with $gamma_arrow.b = 0.4 E_r$. In both figures, the dots are experiment data and the solid line is the fitting result.
  ]
)
<fig-s9>

Therefore, we also quantify the different behaviors before and after PT-symmetry breaking transition by fitting with both damped oscillation $f ( t ) = A e^(- B t) cos C t + 1 - A$ and exponential decay $f ( t ) = A e^(- B t) + 1 - A$, and then compare the $R^2 = 1 - frac(sum_(i = 1)^n ( y_i - f ( x_i ) )^2, sum_(i = 1)^n ( y_i - macron(y) )^2)$, like shown in #ref(<fig-3>)b. When the loss rate is large enough, the $R^2$ of both fits overlap with each other, which indicates the needless of the oscillation term when fitting the time evolution at large loss. With this method, we can estimate where the transition occurs and then fit the time evolution curve before and after transition region with sinusoidal function and exponential function respectively to extract the energy band and damping rate (#ref(<fig-3>)a). For different $k_x / k_0$ (or equivalently $delta$), the loss rate of EPs are different.

== Relation between two photon detuning and $k_x$<relation-between-two-photon-detuning-and-k_x>

From the Hamiltonian of our Raman lattice, one can see that although the lattice potential is one-dimensional in the $y$ direction, the running-wave term $e^(i k_2 x)$ in the Raman potential couples the spin-up (spin-down) states with the x-directional kinetic energy $frac(ℏ^2, 2 M) ( k_x plus.minus k_2 / 2 )^2$. This coupling gives rise to a linear SO term $frac(ℏ^2, 2 M) ( k_x k_2 ) sigma_z$, which leads to a 2D energy band. In fact, the linear SO term effectively shifts the Zeeman energy $m_z$, making the energy band for the $k_x = 0$ layer obtained by tuning $m_z ( delta )$ identical to that for fixed $m_z ( delta ) = m_0$ by scanning $k_x$ following the relation $H_(q_y , k_x = 0 , m_z = m_0) = H_(q_y , k_x = frac(2 M m_0, ℏ^2 k_2) , m_z = 0)$.

In #ref(<fig-3>)a and b, we chose different detuning values and then transferred them into different $k_x$ values due to the limited atom number at high $k_x$. In #ref(<fig-s8>), we compared the reconstructed band gap by shifting the two-photon detuning values $delta$ and $k_x$ in Hermitian regime, which confirmed the relationship between the two-photon detuning and $k_x$ in our experiments.

== Momentum uncertainty and reconstruction of band difference on complex plane
<momentum-uncertainty-and-reconstruction-of-band-difference-on-complex-plane>

As mentioned in #link(<extraction-of-band-gap-information>)[Supplementary Information], the momentum uncertainty makes it hard to distinguish dephasing issue from the decay induced by atom dissipation when fitting the oscillation of spin polarization with damped oscillation. Therefore, to avoid the effect of dephasing issue, when we reconstruct the complex eigen spectrum in low dissipation regime, the imaginary gap is determined by fitting the oscillation curve of spin down atoms by following equation

$ f ( t ) = A ( e^(2 Im (E_2) t) + e^(2 Im (E_1) t) ) - 2 B e^(Im (E_1 + E_2) t) cos Re (E_2 - E_1) t + 2 B - 2 A $

This equation is obtained by combining the time-dependent SchrÃ¶dinger equation of tight-binding Hamiltonian and an empirical damped sinusoidal function. Here, we use the parameters obtained from fitting the spin polarization with damped sinusoidal function as the initial fitting parameters. This fitting function enables us to distinguish the decay induced by the imaginary band from the dephasing induced by the momentum uncertainty. By combining the real band gap extracted from the oscillation curve of the spin polarization, we can further reconstruct the band difference on the complex plane. @fig-s9 displays the time evolution of spin polarization and normalized spin down for selected points on the complex eigen spectrum with $gamma_arrow.b = 0.0 E_r$ and $gamma_arrow.b = 0.4 E_r$, respectively, along with the fitting curve. When there is no spin-dependent dissipation, the normalized spin down curve with only dephasing induced by momentum uncertainty has a non-zero offset after a sufficiently long time. This behavior can be described by the above fitting function with $Im (E_1) = Im (E_2)$ and $A = 0$, which is an empirical damped sinusoidal function. Conversely, when $gamma_arrow.b eq.not 0$, the spin down atoms eventually reach zero, which implies that $Im (E_1) eq.not Im (E_2)$ and $A = B$ in the above equation, which is the exact solution of time-dependent SchrÃ¶dinger equation of tight-binding Hamiltonian.

// [figvision-cn] imgs/FigS12.png
// 本图由上下两行共十个子图组成，顶部两个为二维热图，下方
// 为八个复平面轨迹图，整体用于展示不同层（不同kx/k0值）
// 下能带差异ΔE的实部与虚部关系。 子图a（左上）：二维热图，
// 横轴为q_y(k_0)，范围-1至1；纵轴为k_x(k_0)，范围-0.5至
// 0.5，刻度为-0.5、0.0、0.5。颜色标尺表示Re(ΔE)的大小，
// 范围0.0至1.5，颜色从浅黄（低值）过渡至暗红/黑色（高值）。
// 图中可见亮色高值带大致沿水平方向分布，在q_y=0附近形成
// 较暗的低值区域；四条灰色水平虚线分别位于k_x/k_0 = -0.4、
// -0.1、0.1、0.4处，每条虚线左端有灰色圆点标记。该图展示
// 实验数据中ΔE实部随kx和qy的变化。 子图b（右上）：二维热
// 图，坐标轴同a，颜色标尺表示|Im(ΔE)|，范围0.0至0.3，颜
// 色从浅黄（低值）至暗红/黑色（高值）。图中可见亮色条带
// 大致沿水平方向分布，在q_y≈-0.3和q_y≈0.5处出现高值脊线，
// 某些区域呈暗色。该图展示实验数据中ΔE虚部的绝对值分布。
// 子图c至f（第二行）：四个复平面轨迹图，横轴为Re(ΔE)(E_r
// )，范围约0.8至1.6，刻度为1.0、1.5；纵轴为|Im(ΔE)|(E_r)，
// 范围约0.2至0.8，刻度为0.1、0.3、0.5、0.7。每个子图中数
// 据点由深灰色圆点表示，以实线连接，点旁有箭头指示轨迹方
// 向。各子图标注的kx/k0值分别为-0.4、-0.1、0.1、0.4。曲
// 线呈闭合或近闭合环状，随kx/k0变化形状不同：c图轨迹从左
// 侧低实部向上延伸后向右；d图轨迹较紧凑；e图轨迹呈尖峰状；
// f图轨迹较窄且沿实部方向延伸。这些图对应实验数据中四个
// kx层的复平面轨迹。 子图g至j（第三行）：四个复平面轨迹
// 图，横轴Re(ΔE)(E_r)范围0至1.5，刻度0、1；纵轴|Im(ΔE)|(
// E_r)范围0至0.2，刻度0.0、0.1、0.2。样式同上一行，标注
// kx/k0值分别为-0.4、-0.1、0.1、0.4。曲线呈交叉或环状结
// 构，部分轨迹在实部1附近出现虚部峰值，形状随kx/k0变化。
// 这些图对应模拟结果中四个kx层的复平面轨迹。 整体传达的
// 趋势是：实验与模拟的复平面轨迹均随kx/k0层变化呈现不同
// 形状，虚部在特定实部位置出现峰值，表明能带差异在复平面
// 上的演化依赖于层位置。
#figure(image("imgs/FigS12.png", width: 85%),
  caption: [
    Band difference at different $k_x$ layers on complex plane with $gamma_arrow.b = 0.4 E_r$. The top row is the experimental data, while the bottom row is the corresponding simulation result.
  ]
)
<fig-s12>

== Band difference on complex plane
<band-difference-on-complex-plane>

@fig-s12 presents the band difference on the complex plane at various $k_x$ layers ($k_x / k_0 = - 0.4 , - 0.1 , 0.1 , 0.4$) with dissipation $gamma_arrow.b = 0.4 E_r$. For all the $k_x$ layers depicted in @fig-s12, the band difference exhibits a non-zero spectral winding number on the complex plane. This non-backstepping curve signifies that the system maintains a universal non-Hermitian skin effect (NHSE) along the $y$ direction, as corroborated in #link(<the-criteria-for-non-hermitian-skin-effect-in-1d-and-2d-systems>)[Supplementary Information]. It is also important to highlight that only the absolute value of the imaginary band gap can be measured in the experiment. According to the simulation, the original band difference spectrum on the complex plane manifests a ring-like pattern, and the imaginary part of the band gap alters its sign when the quasi-momentum traverses the band inversion surface. By flipping the portion with a negative imaginary band gap into the first quadrant, the ring-like pattern transforms into the butterfly shape depicted in the figures. In the case along the $q_y$ direction, as no optical lattice exists in this direction, the band difference spectrum intersects at $k_x arrow.r plus.minus oo$. Since only a portion of the band difference spectrum is measured in the experiment, it does not display a non-zero spectral winding. However, for specific $k_x$ layers ($q_y / k_0 = - 0.2 , 0.6$), the currently measured region is sufficiently expansive to observe the non-backstepping behavior. Consequently, the system also upholds a universal NHSE along the $x$ direction, and based on these two points, the entire 2D system must exhibit a non-zero spectral area.

// [figvision-cn] imgs/FigS13.png
// 本图由上下两行共十个子图组成，用于展示不同层上的能带差
// 异在复平面上的分布。上行是实验数据，下行是对应的模拟结
// 果。图中能量均以 E_r 为单位。 子图 a（左上）：二维伪彩
// 色图，标题为 Re(ΔE)，表示能带差的实部。横轴为 q_y(k_0)，
// 范围从 -1 到 1；纵轴为 k_x(k_0)，范围从 -0.5 到 0.5 且
// 向下递增。右侧色标范围从 0.0 到 1.6，颜色从白到橙红再
// 到黑，表示实部数值递增。图中在 q_y(k_0) 约 -0.6、-0.2、
// 0.2、0.6 处叠加了四条灰色垂直虚线，其顶部标有灰色向下
// 箭头。图像显示在 k_x(k_0) 约 -0.5 处有一条白色低值带，
// 在 k_x(k_0) 约 0.3 处有一条黑色高值带，整体呈现分层结
// 构。 子图 b（右上）：二维伪彩色图，标题为 |Im(ΔE)|，表
// 示能带差虚部的绝对值。坐标轴与 a 相同：横轴 q_y(k_0)
// 从 -1 到 1，纵轴 k_x(k_0) 从 -0.5 到 0.5 向下递增。右
// 侧色标范围从 0.00 到 0.30，颜色从白经橙到黑，表示虚部
// 绝对值递增。与 a 相同位置的灰色垂直虚线和向下箭头标示
// 了四条采样线。图像显示高值（黑色）主要集中在两侧，中间
// 有一条纵向的白色低值脊线。 子图 c（中左）：散点图，纵
// 轴为 |Im(ΔE)| (E_r)，范围 0.0 到 1.0；横轴虽未标出，但
// 根据下方子图共用横轴推断为 Re(ΔE) (E_r)。图中标注文字
// q_y/k_0 = -0.6。数据为深灰色实心圆点，自左下向右上排列，
// 起点约在 Re ≈ 0.7、|Im| ≈ 0.3，终点约在 Re ≈ 1.2、|Im|
// ≈ 0.95。一个黑色箭头指向数据序列中部，指示沿曲线的变化
// 方向。 子图 d：散点图，纵轴 |Im(ΔE)| 从 0.2 到 1.0，标
// 注 q_y/k_0 = -0.2。数据点从约 (Re≈1.0, |Im|≈0.3) 开始，
// 沿之字形上升至约 (Re≈1.35, |Im|≈0.65)，中间有一个箭头
// 指向右上。 子图 e：散点图，纵轴 |Im(ΔE)| 从 0.2 到 1.0，
// 标注 q_y/k_0 = 0.2。数据点从约 (Re≈1.0, |Im|≈0.45) 平
// 滑上升至 (Re≈1.4, |Im|≈0.7)，箭头指向右上。 子图 f：散
// 点图，纵轴 |Im(ΔE)| 从 0.2 到 1.0，标注 q_y/k_0 = 0.6。
// 数据点分布呈分岔状，约在 Re≈0.9–1.0 范围内形成多条上升
// 路径，|Im| 从约 0.3 升至 0.8，一个箭头指向左侧分支，另
// 一个箭头指向右侧。 子图 g（左下）：散点图，纵轴 |Im(ΔE
// )| 从 0.0 到 0.2；横轴 Re(ΔE) (E_r) 从 0 到 2。标注
// q_y/k_0 = -0.6。数据点从约 (Re≈0.6, |Im|≈0.02) 迅速上
// 升，在 Re≈1.0 达 |Im|≈0.12，随后在 Re 增大至 1.8 时趋
// 于平台约 0.14。箭头指向曲线中段的上升部分。 子图 h：散
// 点图，纵轴 0.0 到 0.2，标注 q_y/k_0 = -0.2。数据点在
// Re≈1.0–1.3 之间呈分叉形态，|Im| 从约 0.01 上升至约
// 0.11，两个箭头分别指向上下两个分支。 子图 i：散点图，
// 纵轴 0.0 到 0.2，标注 q_y/k_0 = 0.2。数据点从约 (Re≈
// 0.2, |Im|≈0.01) 快速上升至 (Re≈0.6, |Im|≈0.12)，后在
// Re≈1.8 处趋近 0.15。箭头指向曲线上升段。 子图 j：散点
// 图，纵轴 0.0 到 0.2，标注 q_y/k_0 = 0.6。数据点集中在
// Re≈0.5–0.9 的小范围内，呈现多个短分支或回环，|Im| 值主
// 要分布在 0.0–0.1 之间，两个箭头分别指向不同的分支方向。
// 整体趋势：子图 a 和 b 表明能带差在复平面上的实部和虚部
// 在空间（k_x, q_y）上呈现分层和周期性结构；子图 c–f（实
// 验）与 g–j（模拟）对比显示，在 q_y/k_0 = -0.6 和 0.2
// 附近，实验与模拟的曲线形态较为一致（单调上升并趋于饱和），
// 而在 q_y/k_0 = -0.2 和 0.6 附近，两者均表现出分叉或多
// 分支行为，且模拟结果更清晰地展示了不同分支的走向。
#figure(image("imgs/FigS13.png", width: 85%),
  caption: [
    Band difference at different $q_y$ layers on complex plane with $gamma_arrow.b = 0.4 E_r$. The top row is the experimental data, while the bottom row is the corresponding simulation result.
  ]
)
<fig-s13>

== Real space measurement with initial motion along -x direction <real-space-measurement-with-initial-motion-along--x-direction>

By initializing the motion along $- x$ direction, in the presence of skin effect in the +x boundary ($gamma_arrow.b = 0.2 E_r$), the atom cloud stopped the motion to $- x$ direction in a relatively short time and then turned to $+ x$ direction. In contrast, without the skin effect ($gamma_arrow.b = 0.0 E_r$), the atom cloud can move to the $- x$ direction with a larger displacement and exhibit dipole oscillation. The results are also well consistent with the numerical results (@fig-s16), further confirm the existence of skin effect with skin modes mainly accumulated to the +x direction in our present system. \

// [figvision-cn] imgs/FigS16.png
// 该图由四个子图（a、b、c、d）组成，布局为两行两列。它展
// 示了沿x方向初始运动时，原子云的一维归一化自旋向上原子
// 分布随时间演化的实验与理论对比。所有子图具有相同的坐标
// 轴结构：底面横轴为“Position x (μm)”，范围约从 -8 到 8，
// 纵轴为“OD (a.u.)”（光学密度，任意单位），范围 0 到 1。
// 竖直深度轴代表“Time (ms)”，标度从 0.0 延伸至 3.0，每
// 0.5 毫秒一个刻度。曲线按时间堆叠成瀑布图状，背景颜色划
// 分区：x < 0 区域为淡粉色，x > 0 区域为淡蓝色。每个时间
// 切片的曲线在底部有一条基准线，向右上延伸；曲线最高点（
// 最高OD值）用空心圆标记；连接这些最高点的曲线采用虚线。
// 子图 a：标题为“Experiment (Skin effect)”。左上角标注初
// 始速度参数 “V_i = 0.2E_r”。曲线显示随时间增加，最高OD
// 值位置（空心圆数列）形成向右弯曲的轨迹；在 t=0 时峰值
// 位于 x=0 稍偏左，t=1.2 ms 时弯曲至 x≈1 μm，t=2.5 ms 时
// 趋近 x≈0。在 t=1.5 ms 的切片上，峰值右侧位置有一个标注
// “Skin modes”的箭头指向右侧微小抬升的尾部（对应 x ≈ 2 μ
// m）。虚线连接的空心圆轨迹与堆叠曲线对应，整体趋势为峰
// 值先右移后左移的弯曲。 子图 b：标题为“Experiment (No
// skin effect)”。参数 “V_i = 0E_r”。曲线堆叠显示出峰值轨
// 迹（空心圆数列）近似垂直向下，x 坐标随时间几乎稳定在 x
// =0，但峰值位置有轻微展宽。无“Skin modes”标注。最高OD值
// 位置随时间基本不移动，与 a 图形成对比。 子图 c：标题为
// “Theory (Skin effect)”。参数 “V_i = 0.2E_r”，结构与 a
// 图对应，为理论模拟。曲线为平滑解析曲线，空心圆连接峰值
// 轨迹比 a 图更平滑，但向右弯曲的趋势在 t≈1.2~1.5 ms 处
// 一致明显。同样包含“Skin modes”标注箭头（在 t≈1.5 ms 处，
// 指向右侧 x≈2 μm）。理论曲线在峰值左侧（x<0）的斜率更陡，
// 右侧尾部更长，显示非对称展宽。 子图 d：标题为“Theory (
// No skin effect)”。参数 “V_i = 0E_r”。峰值轨迹（空心圆
// 数列）随时间几乎垂直，x 坐标保持约 0，曲线左右对称，无
// “Skin modes”标注。趋势与 b 图基本一致，但理论曲线更光
// 滑。 趋势与结论：对比 a、c 与 b、d 可见，存在初始运动
// （V_i = 0.2E_r）时，在“Skin effect”条件下，原子云峰值
// 位置轨迹发生明显的先右移后左移弯曲（子图 a、c），并出
// 现指向右侧的“Skin modes”尾巴；而在“No skin effect”条件
// 下（V_i = 0E_r），峰值轨迹近似竖直，无此弯曲和尾部特征。
// 这展示了沿x方向初始运动时非厄米趋肤效应对原子空间分布
// 的动态影响。实验与理论趋势一致。
#figure(image("imgs/FigS16.png", width: 65%),
  caption: [
    *Real space measurement with initial motion along $- x$ direction.* *a,b* One example of experimental one-dimensional normalized spin up atom profiles along the $x$ direction with ($gamma_arrow.b = 0.2 E_r$) or without skin effect ($gamma_arrow.b = 0.0 E_r$). The initial motion is along $- x$ direction. The normalized atom profiles are averaged for the whole atom cloud along $y$ direction. The positions with the highest optical density (OD) are denoted by empty circles and the gray dashed line is a guideline based on polynomial function. The profiles corresponding to positive and negative positions are indicated by blue and red colors, respectively. *c,d* Simulated one-dimensional normalized spin up atom profiles along the $x$ direction with or without skin effect, specifically $gamma_arrow.b = 0.2 E_r$, or $gamma_arrow.b = 0.0 E_r$. The initial motion is along $- x$ direction. The normalized atom profiles are averaged for the whole atom cloud along $y$ direction. The positions with the highest optical density (OD) are denoted by empty circles and the gray dashed line is a guideline based on polynomial function. The profiles corresponding to positive and negative positions are indicated by blue and red colors, respectively.
  ]
)
<fig-s16>

= SPECTRAL TOPOLOGY AND NON-HERMITIAN SKIN EFFECT
<spectral-topology-and-non-hermitian-skin-effect>

In this section, we discuss the complex spectral topology and the NHSE in detail. In the first subsection we review the theorems for skin effect in lattice systems and generalize the theory to continuous space. In the second subsection, based on the band difference obtained in the experiment we get access to non-trivial spectral topology and further predict the NHSE under open boundary condition (OBC). In the third subsection we numerically solve a 2D lattice model and discuss the features of the skin effect from a symmetry point of view. And in the last subsection we map the low-energy sectors of our 2D non-Hermitian model to Hermitian systems of free particles living in 4D curved space, and compare the non-Hermitian skin effect with the accumulation of eigenstates on the curved space.

== The criteria for non-Hermitian skin effect in 1D and 2D systems
<the-criteria-for-non-hermitian-skin-effect-in-1d-and-2d-systems>

In this subsection we review the theorems for the occurrence of the skin effect in (quasi-)1D and 2D lattice system and generalize the theory to the case of continuous space. The NHSE has a topological origin manifested by the bulk-boundary correspondence between the spectral topology of the periodic boundary eigenspectrum and the skin modes in the real space. For (quasi-)1D lattices, it has been rigorously proved that the emergence of skin effect is equivalent to the existence of nonzero spectral winding numbers

$ w ( E_0 ) = integral_("FBZ") frac(d k, 2 pi i) partial_k det ( H ( k ) - E_0 ) , $

where $H ( k )$ is the Bloch Hamiltonian with quasi-momentum $k$, and $E_0$ could be any gap point~#link(<si-6>)[[6]]. An equivalent and more intuitive description is that the periodic boundary spectrum $E_i ( k )$ ($i$ runs over all bands) is non-backstepping on the complex plane. Here we make a generalization that this also applies for the skin effect in the continuous space. This is because for any given eigenstate of a Hamiltonian in the continuous space we could treat it as an eigenstate of a lattice model by applying the finite difference approximation with a proper step length. The discretized model obtained in this way serves as a good approximation for the low-energy and long-wavelength spectrum of the continuous model. So if the spectrum of the continuous model is non-backstepping, that of the lattice model should also be so and the corresponding open boundary eigenstates of the lattice model should be skin modes. Therefore the continuous model should also have skin modes and exhibit NHSE. We try this criterion on two continuous two-band models which in the momentum space are written as:

$ H_1 ( k ) & = mat(delim: "(", ℏ^2 ( k - Q )^2 / 2 m, Omega_R; Omega_R^(*), ℏ^2 ( k + Q )^2 / 2 m - i Gamma) ,\
H_2 ( k ) & = mat(delim: "(", ℏ^2 ( k - Q )^2 / 2 m, Omega_R + Gamma / 2; Omega_R^(*) - Gamma / 2, ℏ^2 ( k + Q )^2 / 2 m) , $<eq-1dmodels>

where $Q , Omega_R$ and $gamma$ are all constants. If $Q$ takes the value $k_0 sin 76 degree / 2$ and $Gamma = gamma_arrow.b / 2$ is the loss rate of spin down atoms, $H_1$ is just the quasi-1D layer of our experimental model. We could see in #ref(<fig-nhse>) (a1,a2) that $H_1$ has non-backstepping periodic boundary spectrum and exhibits skin effect under the OBC, while $H_2$ has backstepping spectrum and no skin effect.

In a 2D periodic system, a nonzero periodic boundary spectral area on the complex plane results in the universal skin effect, which means that the skin effect persists unless the open boundary geometry coincides with some spatial symmetry of the bulk~#link(<si-7>)[[7]]. And more specifically in a 2D lattice with a rectangular open boundary, the skin effect can be absent only if the spectral winding numbers of quasi-1D layers perpendicular to the boundary

$ w_E ( upright(bold(k))_parallel ) = integral_("FBZ") frac(d k_perp, 2 pi i) partial_(k_perp) det ( H ( k_perp , upright(bold(k))_parallel ) - E_0 ) $

are zero for all gap points $E_0$ and fixed momenta $upright(bold(k))_parallel$ parallel to the boundary. Such winding numbers indicate the direction of spectral flow and on which boundary the skin modes accumulate in the real space. If the system is continuous space in one or two directions, the spectral winding numbers are no longer available. In that case we just need to check whether the spectrum of the quasi-1D layers are non-backstepping and the spectral flow will be clear.

// [figvision-cn] imgs/FigS_NHSE.png
// a1 子图为复平面内的能谱散点图。横轴为能量实部 Re E，范
// 围约 -0.4 到 2.0；纵轴为能量虚部 Im E，范围 -0.30 到
// 0.00。红色空心圆圈代表周期边界条件（PBC）下的能谱，构
// 成一条闭合的环状曲线；蓝色实心圆点代表开放边界条件（
// OBC）下的能谱，形成两条不闭合的弧线，分别位于复平面的
// 上下两侧，且未形成闭合环。图中右侧有一个内嵌图，标题为
// “Density profile”，横轴为格点位置 x（0 到 50），纵轴为
// 密度（0 到 10），蓝色散点连成的曲线显示在 x 接近 50 的
// 右边界处有一个显著的尖峰，峰值约 10，而内部区域密度接
// 近于 0，表明存在非厄米趋肤效应。a2 子图与 a1 类似，横
// 轴 Re E 范围约 -0.25 到 2.0，纵轴 Im E 范围 -0.2 到
// 0.2。红色空心圆圈（PBC）和蓝色实心圆点（OBC）的能谱形
// 状不同，蓝色点构成的曲线在左侧出现分叉。下方内嵌图横轴
// 为 x（0 到 50），纵轴约 0.0 到 1.5，蓝色曲线显示密度在
// 右边界 x=50 处急剧上升至约 1.6。b1 子图为相图/区域图，
// 横轴 Re E 范围 -1.2 到 1.5，纵轴 Im E 范围 -0.20 到
// 0.00。蓝色区域代表 PBC 能谱覆盖的复平面区域，红色区域
// 代表 OBC 能谱覆盖的区域。蓝色区域呈近似矩形，红色区域
// 仅出现在蓝色区域左右两侧的边缘，形成不重合的带状区域，
// 说明 PBC 和 OBC 能谱在复平面上存在明显差异。b2 至 b4
// 子图为二维热图，横轴为归一化坐标 y/a0（0 到 70），纵轴
// 为归一化坐标 x/a0（0 到 70）。b2 的颜色标尺为 1 到 5（
// 深蓝代表高值），图中显示在 x 接近 70 的上边界和 x 接近
// 0 的下边界处颜色较深，内部区域颜色较浅，呈蓝绿色。b3
// 的颜色标尺为 0.0025 到 0.0150，图中在上下边界呈现深蓝
// 色条带，内部为浅蓝绿色，且边界处的分布比 b2 更不规则。
// b4 的颜色标尺为 0 到 0.01，同样在上下边界出现深蓝色条
// 带，内部颜色较浅。这三个热图共同表明，在二维模型中，本
// 征态的概率密度主要局域在样品的边界区域，而体区域密度较
// 低，体现了二维非厄米趋肤效应。
#figure(image("imgs/FigS_NHSE.png", width: 90%),
  caption: [
    Complex spectra and non-Hermitian skin effect of the 1D and 2D models. *a1,a2*, open boundary spectrum (blue) and periodic boundary spectrum (red, calculated in the momentum space) of $H_(1 / 2)$ in @eq-1dmodels. The insets are the density profile summed over all open boundary eigenstates with eigenenergy $E$ satisfying $| Re E | < 2 "Er"$ and spin degree of freedom $sum_(i , s , | Re E_i | < 2 "Er") | Psi_i ( x , s ) |^2$. *b1*, low energy part of the periodic boundary (red) and open boundary (blue) spectra of the 2D lattice model in @eq-2dlattice. *b2*, the density profile summed over open boundary eigenstates of the model in @eq-2dlattice with eigenenergy $E$ satisfying $Re E < 1.5 "Er"$. *b3*, density profile of the 100 eigenstates with eigenenergies most closest to the base point $E_0 = ( 1.0 - 0.2 "I" ) E_r$. *b4*, density profile of the 100 eigenstates with eigenenergies most closest to the base point $- 0.2 "I" - E_0$.
  ]
)
<fig-nhse>

== A proof of the nontrivial spectral topology and the prediction of skin effect
<a-proof-of-the-nontrivial-spectral-topology-and-the-prediction-of-skin-effect>

In this subsection we deduce the nontrivial spectral based on the experimental results and predict the occurrance of NHSE under OBC. The band difference $Delta E ( k_x , q_y ) = E_1 ( k_x , q_y ) - E_2 ( k_x , q_y )$ between the two lowest bands extracted from the quench dynamics of spin polarization shows nonzero spectral area and non-backstepping curves of quasi-1D layers in $k_x$ and $q_y$ directions. But to predict skin effect we need the actual band dispersion rather than their difference. To bridge the gap, here we show that there exists at least one topological nontrivial quasi-1D subsystem in both $x$ and $y$ directions. We make the following assertion and provide a proof: If the band difference $Delta E ( k_x , q_y )$ of the quasi-1D layers with fixed $k_x$ or $q_y$ is non-backstepping on the complex plane and does not pass the origin point ($Delta E eq.not 0$), the bands $E_(1 / 2) ( k_x , q_y )$ should also be non-backstepping.

_Proof._ We prove the case of quasi-1D layer along $q_y$ direction with fixed $k_(x 0)$. First we define $h ( k_x , q_y ) = ( E_1 ( k_x , q_y ) + E_2 ( k_x , q_y ) ) / 2$, and then the bands are expressed as

$ E_(1 / 2) ( k_x , q_y ) = h ( k_x , q_y ) plus.minus Delta E ( k_x , q_y ) / 2 . $

The bands $E_(1 / 2) ( k_(x 0) , q_y )$ could be backstepping only in two cases: (i) $forall q_y$, $exists q_y eq.not q'_y , q''_y$ s.t. $E_1 ( k_(x 0) , q_y ) = E_1 ( k_(x 0) , q'_y )$, $E_2 ( k_(x 0) , q_y ) = E_2 ( k_(x 0) , q''_y )$, or (ii) $forall q_y$, $exists$ only one $q'_y eq.not q_y$ s.t. $E_1 ( k_(x 0) , q_y ) = E_2 ( k_(x 0) , q'_y )$. In case (i) there should be $q'_y = q''_y$ because such band degeneracy should be caused by a certain symmetry transforming the momentum in a physical sense, like $q_y arrow.r - q_y$, $q_y arrow.r pi - q_y$ or so on. Then we equivalently have $h ( k_(x 0) , q_y ) plus.minus Delta E ( k_(x 0) , q_y ) = h ( k_(x 0) , q'_y ) plus.minus Delta E ( k_(x 0) , q'_y )$ and thus $Delta E ( k_(x 0) , q_y ) = Delta E ( k_(x 0) , q'_y )$. This $q_y arrow.r q'_y$ relation actually gives a local homeomorphism $q'_y ( q_y )$ from the first Brillouin zone (FBZ) to itself. If the bands $E_(1 / 2) ( k_(x 0) , q_y )$ are backstepping, $q'_y ( q_y )$ and $q_y$ should go in the opposite directions ($q_y arrow.r q'_y$ have a negative mapping degree, rigorously speaking). Therefore $Delta E ( k_(x 0) , q_y ) = Delta E ( k_(x 0) , q'_y )$ indicates that the $Delta E ( k_(x 0) , q_y )$ curve is backstepping. This contradiction excludes the possibility of the first case. In case (ii) we have $h ( k_(x 0) , q_y ) + Delta E ( k_(x 0) , q_y ) = h ( k_(x 0) , q'_y ) - Delta E ( k_(x 0) , q'_y )$. Since $q_y$ and $q'_y$ run in the opposite directions, there must be some $q_(y 1)$ s.t. $q_(y 1) = q'_(y 1)$. Then we have $Delta E ( k_(x 0) , q_(y 1) ) = 0$, which contradicts the condition that the curve of $Delta E$ does not pass the origin point. By excluding the possibilities of these two cases, we conclude that the two bands $E_(1 / 2) ( k_x , q_y ) =$ themselves are non-backstepping. As a sidenote, our proof applies to the half-integer winding number case that across the Brillouin zone the two bands exchange eigenstates rather than returning to the original eigenstates respectively. #h(1fr) $square$

Applying this on the non-backstepping $Delta E ( k_x , q_y )$ curves as shown by @fig-s12 and @fig-s13, we deduce that the corresponding quasi-1D band spectra are non-backstepping. Combining this with the lack of reciprocity and spatial symmetry of our system, we predict the appearance of corner skin modes under the OBC, which is supported by the numerical simulation shown in @fig-nhse.

With the non-backstepping spectrum of both quasi-1D layers in $k_x$ and $q_y$ directions, we could further infer that the periodic boundary spectrum of the whole 2D system must have a nonzero spectral area. This is because otherwise the spectrum on the complex plane should be a 1D curve including both non-backstepping open curves of $k_x$ layers going to real positive infinity and the non-backstepping loops of $q_y$ layers, which is not possible. The nonzero spectral area also supports the occurrence of 2D NHSE~#link(<si-7>)[[7]].

== Simulation of the non-Hermitian skin effect and the nonlocal feature
<simulation-of-the-non-hermitian-skin-effect-and-the-nonlocal-feature>

To see the NHSE of our optical lattice system, here we solve a 2D lattice model with open boundary cut along $x$ and $y$ directions. The harmonic trap in the experiment is replaced by the hard box trap so that the skin modes will be localized on the edges. The model is obtained by applying s-band tight-binding approximation in the $y$ direction and finite-difference approximation in the $x$ direction. It acts on the local basis $| upright(bold(j)) s chevron.r$ centered at the site $upright(bold(j)) = ( j_x , j_y )$ with spin $s = ( arrow.t , arrow.b )$, which in the $y$ direction are the s-band Wannier functions. The Hamiltonian is

$ H_(l a t t i c e) = & sum_(upright(bold(j))) ( ( m_z + i gamma_arrow.b / 4 ) ( | upright(bold(j)) arrow.t chevron.r chevron.l upright(bold(j)) arrow.t | - | upright(bold(j)) arrow.b chevron.r chevron.l upright(bold(j)) arrow.b | ) + sum_(k = x , y) [ ( - t_arrow.t^k | upright(bold(j)) + upright(bold(e))_k arrow.t chevron.r chevron.l upright(bold(j)) arrow.t | + t_arrow.b^k | upright(bold(j)) + upright(bold(e))_k arrow.b chevron.r chevron.l upright(bold(j)) arrow.b | ) + h . c . ]\
 & + ( t_(s o) e^(- i k_0 cos theta j_y) | upright(bold(j)) arrow.b chevron.r chevron.l upright(bold(j)) + upright(bold(e))_y arrow.t | - t_(s o) e^(i k_0 cos theta j_y) | upright(bold(j)) arrow.t chevron.r chevron.l upright(bold(j)) + upright(bold(e))_y arrow.b | + h . c . ) ) - i gamma_arrow.b / 4 , $<eq-2dlattice>

where $m_z$ is the Zeeman energy, $gamma_arrow.b$ is the loss rate of spin-down atoms, $t_(arrow.t , arrow.b)^k$ are the nearest-neighbor spin-conserved hopping coefficients of the optical lattice in the $k = ( x , y )$ directions, $t_(s o)$ is the nearest-neighbor spin-flipped hopping coefficient in the optical lattice direction, and $theta = 76 degree , k_0 = pi / a$ with $a$ being the lattice constant in the y direction. Here $t_arrow.t^x = t_arrow.b^x = i sin theta frac(a, 2 l_x pi) + frac(a^2, l_x^2 pi^2)$ where $l_x$ is the finite difference step-length. We could gauge out the phase factor $e^(plus.minus i k_0 cos theta j_y)$ with a transformation $| upright(bold(j)) arrow.b chevron.r arrow.r e^(i k_0 cos theta j_y) | upright(bold(j)) arrow.b chevron.r$. Here the tight-binding parameters are set to be $t_(arrow.t ( arrow.b )) = 0.32 ( 0.38 ) E_r$ and $t_(s o) = 0.25 E_r$ corresponding to the experimental parameters $V_(arrow.t ( arrow.b )) = 3.2 ( 2.2 ) E_r$ and $M_R = 2.0 E_r$, and the Zeeman splitting is $m_z = - 0.3 E_r$. While 2D lattice model may fail in the high-energy and short wavelength sectors for the absence of higher bands, long-range hoppings and the discretization of the continuous direction, it could approximate the low-energy and long wavelength sector of the original system well. Here the step-length in the $x$ direction is chosen to be $x_0 = a_0 / 7$. #ref(<fig-converge>)a shows that in this case the periodic boundary solutions with the real part of the eigenenergies satisfying $Re E < 1.5 E_r$ already converge well. More quantitatively, the convergence could be demonstrated by the number of eigenstates in this regime as shown in #ref(<fig-converge>)b. Since the low-energy solutions of the lattice model are good approximation of the real eigenstates, we could study the NHSE by solving $H_(l a t t i c e)$ under the OBC.

// [figvision-cn] imgs/FigS_converge.png
// 子图a为六个并排排列的复能量平面散点图，展示周期性晶格
// 模型本征能量谱的低能部分随方向步长a0/λ0变化的收敛过程。
// 六幅子图分为两行三列，坐标轴一致：横轴为能量实部Re E，
// 范围-1.0到1.5，单位未直接标注（与能量相关）；纵轴为能
// 量虚部Im E，范围-0.20到0.00，单位未标注。每幅图由密集
// 蓝色散点构成，散点表示各本征态在复能量平面上的位置。顶
// 部标注的参数分别为a0/λ0 = 4.0、5.0、6.0、7.0、8.0、9.0。
// 所有图中散点大致形成从Im E = 0附近向下延伸的曲线状结构，
// 顶部有一条水平边界，大部分点分布在Im E < 0区域。随着步
// 长a0/λ0增大，散点在复平面上的分布逐渐平滑、收敛；在a0/
// λ0 = 4.0和5.0时点分布相对稀疏且存在局部聚集或间隙，在
// a0/λ0 = 7.0、8.0、9.0时则趋于更连续的曲线状排列，表明
// 有限差分方法随步长增加而收敛于稳定谱结构。 子图b为折线
// 图，展示本征态数量随方向步长的变化。横轴标注为a0/λ0，
// 范围4到9，刻度为4、5、6、7、8、9；纵轴标注已裁剪，可见
// 文本为"Number of eigenstates below 1.5Er"，范围约11630
// 到11750，刻度间隔40，标有11640、11680、11720。数据点由
// 红色方块标记，以蓝色折线连接。趋势为：a0/λ0从4到5时本
// 征态数从约11730缓慢降至约11720；从5到6时急剧下降至约
// 11640；从6到7时小幅回升至约11660；从7到8时下降至约
// 11640；从8到9时几乎保持不变，略低于11640。该图说明当步
// 长增大到6附近时，实部本征能量满足某一阈值的本征态数目
// 发生显著收敛性下降，随后趋于稳定。
#figure(image("imgs/FigS_converge.png", width: 100%),
  caption: [
    The convergence of the finite difference method. *a* Low energy part of the periodic boundary spectrum of the lattice model in @eq-2dlattice with different step-lengths in the $x$ direction. *b* Number of eigenstates with the real part of eigenenergy satisfying $Re E < 1.5 E_r$ varying with the step-length in the $x$ direction.
  ]
)
<fig-converge>

The lattice model exhibits NHSE when $gamma_arrow.b eq.not 0$, with a volume-law number of eigenstates being localized on the corners of the open boundary as shown by @fig-nhse. A noteworthy feature is that besides the most of the skin modes being localized at the top left corner, there are also skin modes showing up in the opposite bottom right corner. We attribute this to the (approximate) particle-hole(-like) symmetry (PHS). If $t_arrow.t^y = t_arrow.b^y$ and the overall dissipation $- i gamma_arrow.b / 4$ is omitted, the lattice model in @eq-2dlattice has a symmetry $hat(S) = ( - 1 )^(j_x) sigma_x hat(P)$, where $sigma_x$ is a Pauli matrix acting on the spin degree of freedom and $hat(P)$ is the transpose operation under the basis $| upright(bold(j)) s chevron.r$ (which is the particle-hole conjugation $Pi_(upright(bold(j)) , s) ( c_(upright(bold(j)) , s)^dagger + c_(upright(bold(j)) , s) )$ in the second quantization representation). The measurement of $Delta E ( k_x , q_y )$ reveals the nontrivial spectral winding topology of quasi-1D layers, say $E_1 ( q_y )$ with a fixed $k_(x 0)$. And then the particle-hole pair related to one band $E_1 ( q_y )$ by $hat(S)$, $- E_1 ( - q_y )$, should wind in the opposite direction. Therefore the particle and hole bands have opposite spectral winding numbers, indicating that the skin modes are distributed in different (opposite) boundaries~#link(<si-6>)[[6]]. For the same reason, in the $k_x$ direction this counter-propagating spectral flows also exist in the low-energy regime. Therefore the system hosts 2D symmetric skin effect with skin modes being localized in both of the opposite corners as shown in the plot. In fact this local PHS relates pairs of skin modes like $| E chevron.r , | - E chevron.r$ with opposite eigenenergies $plus.minus E$, which if not being topological boundaries states should be localized in opposite boundaries~#link(<si-8>)[[8]]. @fig-nhse shows that the 100 eigenstates with eigenenergies closest to the base point $E_0 = ( 1.0 - 0.2 "I" ) E_r$ are being localized on the bottom left corner, and correspondingly the 100 eigenstates with eigenenergies most closest to $- 0.2 "I" - E_0$ are being localized at the top right corner as shown in @fig-nhse. It is a novel phenomenon arising in the non-Hermitian physics that the local symmetry establishes a nonlocal correspondence.

// [figvision-cn] imgs/FigS_PHS.png
// 这是一张包含四个子图（a、b、c、d）的二维伪彩色图，用于
// 展示不同参数或模型下最低能带的自旋极化数值模拟结果。四
// 个子图采用完全相同的坐标轴、色标和布局：横轴标记为 \(
// q_x/k_0\)，范围从 -1.0 到 1.0；纵轴标记为 \(k_y/k_0\)，
// 范围从 -1.0 到 1.0；横轴和纵轴均具有 ±0.5 和 ±1.0 的刻
// 度标签。子图右侧共用一个竖直色标，数值范围从 -1.0（深
// 蓝色）到 1.0（深红色），0 对应白色，中间过渡为浅蓝和浅
// 红，表示自旋极化从负到正的连续变化。图中同时画有浅灰色
// 虚线标记特定动量路径。 子图 a：模型为二维晶格，参数为
// 某组设定值。图形呈沿 \(q_x/k_0=0\) 轴线对称的“V”形结构。
// 上部（\(k_y/k_0\) 约 -0.5 至 -1.0）为深红色区域，代表
// 自旋极化接近 +1.0；下部（\(k_y/k_0\) 约 0.5 至 1.0）中
// 心区域为深蓝色，代表自旋极化接近 -1.0；两侧区域为浅色
// 过渡带。\(q_x/k_0\) 约在 -0.2 至 -0.1 以及 0.1 至 0.2
// 之间存在较明显的红色汇聚区和蓝色汇聚区，呈分支状分布。
// 子图 b：二维晶格模型，另一组参数。图像特征与 a 图相似，
// 但分布略有细节差异。深红色区域在 \(k_y/k_0\) 约 -0.6
// 至 -1.0 范围内更宽阔；中心白色过渡带在 \(q_x/k_0 = 0\)
// 附近较为连续，向下的深蓝色尖峰位于 \(k_y/k_0\) 约 0.5
// 至 1.0 之间，且两侧蓝色区域分布与 a 图略有不同。 子图
// c：实验系统的模型（使用平面波方法计算）。整体形态与 a、
// b 图接近，但深红色区域向下的汇聚程度更明显，在 \(q_x/
// k_0\) 约 0 处形成一条明显的楔形过渡，中心白色区域在 \(
// k_y/k_0\) 约 -0.1 至 0.3 之间变化突出。下方的深蓝色尖
// 峰起始位置约在 \(k_y/k_0=0.6\)，并沿纵向拉伸至 1.0，两
// 侧蓝色区域较 a、b 图更为连续。 子图 d：为另一组参数或
// 模型下的结果。图像的整体分布趋势与 c 图相似，中央红色
// 区域呈现细长的“V”形向下延伸的形态，在 \(k_y/k_0\) 约
// -0.2 至 0.2 之间存在较强的白色零极化过渡带。顶部 \(k_y
// /k_0\) 接近 -1.0 的区域为深红色，底部 \(k_y/k_0\) 接近
// 1.0 的区域为深蓝色，并带有左右两侧青色/浅蓝色带。该子
// 图的整体结构和色块边界较前几图略有不同，呈现出中心红白
// 区域更细长的特征。 四幅子图均通过色标颜色连续变化展示
// 最低能带在动量空间中的自旋极化分布，红色对应正极化，蓝
// 色对应负极化，白色对应零极化；从子图 a 到 d，中央过渡
// 带形状、位置以及深色极值区域的宽度和深度存在差异，反映
// 了不同模型参数或计算方法（如平面波方法与晶格模型）对自
// 旋极化分布的影响。图中没有标尺、箭头或额外的文本注释，
// 仅有坐标轴标签、刻度及右侧的色标数值。
#figure(image("imgs/FigS_PHS.png", width: 100%),
  caption: [
    Numerical simulations of the spin polarization of the lowest band at equilibrium. *a* Spin polarization of the lowest band of the 2D lattice model in @eq-2dlattice, with $gamma_arrow.b = 0$ and $t_arrow.t = t_arrow.b = 0.35 E_r$. *b* Spin polarization of the lowest band of the 2D lattice model in @eq-2dlattice, with $t_arrow.t = 0.32 E r , t_arrow.b = 0.38 E_r$. *c* Spin polarization of the lowest band of the model of the experimental system at equilibrium with $V_arrow.t = V_arrow.b = 0.27 E_r$, calculated by the plane wave method. *d* Spin polarization of the lowest band of the model of the experimental system at equilibrium with $V_(arrow.t ( arrow.b )) = 0.32 E_r ( 0.22 E_r )$, calculated by the plane wave method.
  ]
)
<fig-phs>

Our real experimental system deviates from this $hat(S)$ symmetry, mainly resulting from the high-energy sectors (higher bands beyond the energy scale of the s-band in the optical lattice) and that $t_arrow.t eq.not t_arrow.b$. However, we know that the s-band width being about $w = 2 t_arrow.t + 2 t_arrow.b$ is much larger than the strength of the perturbation breaking the PHS at about $delta w = 2 | t_arrow.t - t_arrow.b |$. Since any pair of eigenstates related by the PHS have opposite eigenenergies, such pair of skins modes in the low-energy sector whose eigenenergies are larger than $delta w$ will not be largely influenced by the perturbation and their localization properties should be preserved. Therefore we could still predict this nonlocal feature of the skin effect for the real system. More concretely, the low-energy properties of the real system are not qualitatively changed compared with the ideal model in @eq-2dlattice. We visualise the symmetry breaking by simulating the spin polarization of the lowest band at equilibrium as shown in @fig-phs. In the ideal symmetric system described by @eq-2dlattice with $t_arrow.t = t_arrow.b$, only the physics within the energy scale of s-band width of the optical lattice is kept. In this case the $hat(S)$ symmetry is perfectly respected, reflected in the features that the Dirac points are located at $q_y / k_0 = 0 , plus.minus 1$ and the reflection symmetry about the $q_y = 0$ axis of the spin polarization distribution as shown in #ref(<fig-phs>)a. If $t_arrow.t eq.not t_arrow.b$, the Dirac points are slightly perturbed from the symmetric lines $q_y = 0 , plus.minus pi$ and the reflection symmetric feature is slightly broken as shown in #ref(<fig-phs>)b. If the higher-bands are included and the optical lattice is spin independent, the Dirac points are moved away from the symmetric lines and the spin polarization image is not perfectly symmetric about $q_y = 0$ as shown by #ref(<fig-phs>)c. In the real experimental system with spin-dependent optical lattices, the band structure is modified as shown by #ref(<fig-phs>)d. We could see that the symmetric features protected by the PHS are broken to a small extent in the real system. Also, the simulation shown in @fig-phs already shows the case of $t_arrow.t eq.not t_arrow.b$ in which the nearly-symmetric feature is observed. The robustness of the nonlocal skin effect with PHS significantly distinguishes PHS from time-reversal symmetries~[#link(<si-6>)[6], #link(<si-9>)[9], #link(<si-10>)[10]] and unitary spatial symmetries~[#link(<si-11>)[11], #link(<si-12>)[12]], in the case of which the degenerate pairs related by the symmetry could be scattered to each other by an arbitrarily small perturbation breaking the symmetry, resulting in the absence of skin effect. The nonlocal nature of the fundamental symmetries like the PHS manifested in non-Hermitian physics, and the symmetry protected feature of the NHSE are the new directions of our future research. As an aside, the eigenstates with energy much higher than the s-band energy scale should recover the Hermiticity and become more extended in the real space, simply because the kinetic energy part dominates the short wavelength physics.

== Mapping our 2D non-Hermitian system to Hermitian models in curved spaces
<mapping-our-2d-non-hermitian-system-to-hermitian-models-in-curved-spaces>

In this part we study our 2D non-Hermitian experimental model under spin-orbital-coupled basis, manifesting the asymmetric hoppings and imaginary vector potential which generally induce the 2D non-Hermitian skin effect. Further, we map the low energy sectors of our model to Hermitian systems of free particles in 4D curved spaces.

The simplified s-band Bloch Hamiltonian of our experimental model is

$ H ( upright(bold(k)) ) & = h_0 ( upright(bold(k)) ) sigma_0 + h_z ( upright(bold(k)) ) sigma_z + h_y ( upright(bold(k)) ) sigma_y + i gamma_arrow.b / 4 sigma_z , $<eq-2dbloch>

where $upright(bold(k)) = ( k_x , q_y )$, $h_0 ( upright(bold(k)) ) = ℏ^2 ( k_x^2 + k_2^2 / 4 ) / 2 m - 2 t_y cos ( q_y a_0 ) sin ( k_1 a_0 / 2 ) - i gamma_arrow.b / 4 , h_z ( upright(bold(k)) ) = - ℏ^2 ( k_x k_2 ) / 2 m - 2 t_y sin ( q_y a_0 ) cos ( k_1 a_0 / 2 ) + m_z , h_y ( upright(bold(k)) ) = - 2 t_(s o) cos ( q_y a_0 )$, and $sigma_(0 , y , z)$ are the Pauli matrices. Here an overall $( k_0 + k_1 ) / 2$ momentum shift has been applied in the $y$ direction. We rewrite it under the new spin-orbital-coupled basis $| plus.minus , upright(bold(k)) chevron.r$ which are the Bloch states of the Hermitian part of our model, i.e. $[ H ( upright(bold(k)) ) - i gamma_arrow.b / 4 sigma_z ] | plus.minus , upright(bold(k)) chevron.r = ( h_0 ( upright(bold(k)) ) plus.minus epsilon.alt ( upright(bold(k)) ) ) | plus.minus , upright(bold(k)) chevron.r$ with $epsilon.alt ( upright(bold(k)) ) = sqrt(h_z^2 + h_y^2)$:

$ tilde(H) ( upright(bold(k)) ) & = h_0 ( upright(bold(k)) ) sigma_0 + epsilon.alt ( upright(bold(k)) ) sigma_z + i gamma_arrow.b / 4 U^dagger ( upright(bold(k)) ) sigma_z U ( upright(bold(k)) )\
 & = h_0 ( upright(bold(k)) ) + epsilon.alt ( upright(bold(k)) ) sigma_z + i gamma_arrow.b / 4 ( cos ( theta ( upright(bold(k)) ) ) sigma_z + sin ( theta ( upright(bold(k)) ) ) sigma_x )\
 & = h_0 ( upright(bold(k)) ) + epsilon.alt ( upright(bold(k)) ) sigma_z + i gamma_arrow.b / 4 frac(h_z ( upright(bold(k)) ) sigma_z + h_y ( upright(bold(k)) ) sigma_y, sqrt(h_y ( upright(bold(k)) )^2 + h_z ( upright(bold(k)) )^2)) ,\
"where " U ( upright(bold(k)) ) & = mat(delim: "(", cos frac(theta ( upright(bold(k)) ), 2), sin frac(theta ( upright(bold(k)) ), 2); i sin frac(theta ( upright(bold(k)) ), 2), - i cos frac(theta ( upright(bold(k)) ), 2)) , theta ( upright(bold(k)) ) = arctan frac(h_y ( upright(bold(k)) ), h_z ( upright(bold(k)) )) . $<eq-rotated>

This formalism explains the occurrence of the non-Hermitian skin effect under the open boundary condition: In both $x$ and $y$ directions, the Hermitian part $h_0 ( upright(bold(k)) ) + epsilon.alt ( upright(bold(k)) ) sigma_z$ is parity-even and the non-Hermitian term $- i ( gamma_arrow.b h_z ( upright(bold(k)) ) sigma_z ) / ( 4 epsilon.alt ( upright(bold(k)) ) )$ is parity-odd. The $- i ( gamma_arrow.b t_y cos ( k_1 a_0 / 2 ) sin ( q_y a_0 ) sigma_z ) / ( 2 epsilon.alt ( upright(bold(k)) ) )$ term contributes imbalanced hopping amplitudes in the real space and hence induces non-Hermitian skin effect in the $y$ direction.

Similarly in the continuous space direction the $- i ( gamma_arrow.b ℏ^2 k_2 k_x sigma_z ) / ( 8 epsilon.alt ( upright(bold(k)) ) m )$ term resembles an imaginary vector potential, inducing the non-Hermitian skin effect just as how the imbalanced hoppings work in the lattice cases. Moreover, since these two terms have different signs for the two sectors $| plus.minus , upright(bold(k)) chevron.r$, the non-Hermitian skin modes should appear in two opposite corners, in agreement with the numerical results shown by @fig-nhse (b2-b4).

This could be further clarified if we adopt the following approximations: (i) In the low-energy (long-wavelength) limit, i.e. $| k_x | , | q_y | arrow.r 0$, we have $epsilon.alt ( upright(bold(k)) ) approx sqrt(m_z^2 + 4 t_(s o)^2) := E_0$. (ii) In this regime the gap between the $| plus.minus , upright(bold(k)) chevron.r$ two sectors of $tilde(H) ( upright(bold(k)) )$ in @eq-rotated, $2 | m_z |$, is much larger than the off-diagonal terms. Since the diagonal terms already manifest non-Hermitian skin effect, the $sigma_y$ term could be neglected. The simplified model is:

$ tilde(H) ( upright(bold(k)) ) = frac(ℏ^2 k_x^2, 2 m) + t_y sin ( k_1 a_0 / 2 ) a_0^2 q_y^2 + ( E_0 + i frac(gamma_arrow.b [ m_z - ( ℏ^2 k_x k_2 ) / ( 2 m ) - 2 t_y a_0 cos ( k_1 a_0 / 2 ) q_y ], 4 E_0) ) sigma_z + C , $

where $C$ is an overall constant and will be omitted in the following. For the $| plus.minus , upright(bold(k)) chevron.r$ bands, the diagonal terms are

$ tilde(H)_plus.minus ( upright(bold(k)) ) = frac(ℏ^2, 2 m) ( k_x minus.plus i A_x )^2 + frac(ℏ^2, 2 m_y) ( q_y minus.plus i A_y )^2 plus.minus ( E_0 + i frac(gamma_arrow.b m_z, 4 E_0) ) , $

where $( A_x , A_y ) = ( frac(gamma_arrow.b k_2, 8 E_0) , frac(gamma_arrow.b cot ( k_1 a_0 / 2 ), 4 a_0 E_0) )$ is the imaginary vector potential and $m_y = 2 m t_y sin ( k_1 a_0 / 2 ) a_0^2 / ℏ^2$ is the effective mass at $q_y = 0$. The imaginary vector potential of $tilde(H)_(+) ( upright(bold(k)) )$ could be removed by introducing a coordinate transformation $( zeta , eta ) = ( e^(- 2 A_x x) , e^(- 2 A_y y) )$:

$ tilde(H)_plus.minus ( x , y ) & = ℏ^2 ( - i partial_x minus.plus i A_x )^2 / ( 2 m ) + ℏ^2 ( - i partial_y minus.plus i A_y )^2 / ( 2 m_y ) plus.minus ( E_0 + frac(gamma_arrow.b m_z, 4 E_0) ) ,\
tilde(H)_plus.minus ( zeta , eta ) & = ℏ^2 ( 2 i A_x zeta partial_zeta minus.plus i A_x )^2 / ( 2 m ) + ℏ^2 ( 2 i A_y eta partial_eta minus.plus i A_y )^2 / ( 2 m_y ) plus.minus ( E_0 + frac(gamma_arrow.b m_z, 4 E_0) )\
 & = - ℏ^2 A_x^2 ( 2 zeta partial_zeta minus.plus 1 )^2 / ( 2 m ) - ℏ^2 A_y^2 ( 2 eta partial_eta minus.plus 1 )^2 / ( 2 m_y ) plus.minus ( E_0 + frac(gamma_arrow.b m_z, 4 E_0) ) . $

Then we have

$ tilde(H)_(+) ( zeta , eta ) & = - ℏ^2 A_x^2 ( 4 zeta^2 partial_zeta^2 + 1 ) / ( 2 m ) - ℏ^2 A_y y^2 ( 4 eta^2 partial_eta^2 + 1 ) / ( 2 m_y ) + ( E_0 + frac(gamma_arrow.b m_z, 4 E_0) ) ,\
tilde(H)_(-) ( zeta , eta ) & = - ℏ^2 A_x^2 ( 4 zeta^2 partial_zeta^2 + 8 zeta partial_zeta + 1 ) / ( 2 m ) - ℏ^2 A_y^2 ( 4 eta^2 partial_eta^2 + 8 eta partial_eta + 1 ) / ( 2 m_y ) - ( E_0 + frac(gamma_arrow.b m_z, 4 E_0) ) . $<eq-nh>

This reminds us of the free particles living on a curved space, whose Hamiltonian is given by

$ H_("cv") = - frac(ℏ^2, 2 m) 1 / sqrt(g) partial_i upright(bold(g))^(i j) sqrt(g) partial_j , $

where $upright(bold(g))$ is the metric, $g = det ( upright(bold(g)) )$ and $j$ runs over the space indices. However, the Hamiltonians of the two bands, $tilde(H)_plus.minus ( zeta , eta )$, could not be simply equalized to Hamiltonians of particles living in a 2D curved space. But we can introduce two auxiliary dimensions $( zeta' , eta' )$ and map $tilde(H)_plus.minus ( zeta , eta )$ to Hermitian systems in a 4D curved space. We consider two different 4D spaces $M^plus.minus ( zeta , eta , zeta' , eta' )$ with metrics

$ upright(bold(g))_plus.minus ( zeta , eta , zeta' , eta' ) = ( zeta^(- 2) d zeta^2 + zeta^(minus.plus 2) (d zeta')^2 ) / ( 2 A_x )^2 + ( eta^(- 2) d eta^2 + eta^(minus.plus 2) (d eta')^2 ) m_y / ( 4 m A_y^2 ) , $

respectively. And correspondingly the Hamiltonians of free particles on these two different 4D spaces are given by

$ H_("cv")^(+) ( zeta , eta , zeta' , eta' ) & = - frac(ℏ^2, 2 m) 1 / sqrt(g_(+)) partial_i upright(bold(g))_(+)^(i j) sqrt(g_(+)) partial_j\
 & = - frac(ℏ^2, 2 m) 4 A_x^2 zeta^2 ( partial_zeta^2 + partial_(zeta')^2 ) - frac(ℏ^2, 2 m_y) 4 A_y^2 eta^2 ( partial_eta^2 + partial_(eta')^2 ) ,\
H_("cv")^(-) ( zeta , eta , zeta' , eta' ) & = - frac(ℏ^2, 2 m) 1 / sqrt(g_(-)) partial_i upright(bold(g))_(-)^(i j) sqrt(g_(-)) partial_j\
 & = - frac(ℏ^2, 2 m) 4 A_x^2 ( zeta^2 partial_zeta^2 + zeta^2 partial_(zeta')^2 + 2 zeta partial_zeta ) - frac(ℏ^2, 2 m_y) 4 A_y^2 ( eta^2 partial_eta^2 + eta^2 partial_(eta')^2 + 2 eta partial_eta ) . $<eq-curved>

Comparing @eq-nh with @eq-curved, we notice that apart from the insignificant constant energy shifts, $tilde(H)_plus.minus ( zeta , eta )$ are exactly the Hermitian $H_("cv")^plus.minus$ with the quasi-momentum in the auxiliary directions $k_(zeta') , k_(eta') = 0$, i.e.

$ tilde(H)_plus.minus ( zeta , eta ) = H_("cv")^plus.minus ( zeta , eta , k_(zeta') = 0 , k_(eta') = 0 ) . $

These 4D spaces $M^plus.minus ( zeta , eta , zeta' , eta' )$ are the Cartesian products of two curved 2D spaces parametrized by $M_zeta^plus.minus ( zeta , zeta' )$ and $M_eta^plus.minus ( eta , eta' )$ respectively. All of $M_(zeta / eta)^plus.minus$ have uniform negative Gaussian curvature. Taking $M_zeta^plus.minus$ as an example, the Gaussian curvature is given by

$ R = - sqrt(g_(zeta zeta) g_(tilde(zeta) tilde(zeta)))^(- 1) ( ( frac(( sqrt(g_(zeta zeta)) )_(tilde(zeta)), sqrt(g_(tilde(zeta) tilde(zeta)))) )_(tilde(zeta)) + ( frac(( sqrt(g_(tilde(zeta) tilde(zeta))) )_zeta, sqrt(g_(zeta zeta))) )_zeta ) . $

Simple arithmetic gives $R = - 4 A_x^2$ for $M_zeta^plus.minus$ and $R = - ( 4 m A_y^2 ) / m_y$ for $M_eta^plus.minus$, which means $M_(zeta , eta)^plus.minus$ are all pseudospheres. $upright(bold(g))^(+)$ is exactly the standard Poincar$"é"$ upper-half-plane representation of pseudospheres, from which $upright(bold(g))^(-)$ differs by a transformation $( zeta , eta ) arrow.r ( zeta^(- 1) , eta^(- 1) )$.

The accumulation of the eigenfunctions of $H_("cv")^plus.minus$ in the boundary of the curved space coincides with the non-Hermitian skin effect of our 2D non-Hermitian model. The skin modes of the two sectors $tilde(H)_plus.minus ( upright(bold(k)) )$ are localized on the $( x , y )$ and $( - x , - y )$ corners respectively. While the eigenfunctions of $H_("cv")^plus.minus ( zeta , eta , k_(zeta') = 0 , k_(eta') = 0 )$ are the linear superpositions of wavefunctions in the form of $Psi ( zeta , eta ) = zeta^(plus.minus 1 / 2 + i k_zeta) eta^(plus.minus 1 / 2 + i k_eta)$, where $k_zeta$ and $k_eta$ are both real numbers. Therefore the eigenstates are localized on the $( - zeta , - eta )$ and $( zeta , eta )$ corners for $H_("cv")^plus.minus ( zeta , eta , k_(zeta') = 0 , k_(eta') = 0 )$ respectively, in agreement with the distribution of non-Hermitian skin modes.

It is worthwhile to note that, the 4D spaces here have two "extra dimensions" $zeta'$ and $eta'$ along each of which the translation symmetry is respected and the momentum is a conserved quantity. This geometry shares some similarities with the Kaluza-Klein theory~[#link(<si-13>)[13], #link(<si-14>)[14], #link(<si-15>)[15]], a formalism unifying gravitation and electromagnetism. In this theory, an extra fifth dimension in the shape of a tiny circle is introduced besides the regular 3+1 space-time dimensions, and the momentum along the extra dimension is identified with the electric charge quantity. In our case, $k_(zeta' ( eta' ))$ controls the strength of the "geometrical" potential in the form of $zeta^2$($eta^2$) in @eq-curved. This inspires us to further exploit the potential of non-Hermitian lattices for the simulation of high-dimensional special curved spaces in future work.

#set text(size: 9pt)
#set par(hanging-indent: 1.5em, justify: false, leading: 0.6em)
#set block(spacing: 0.75em)
#link(<si-1>)[[1]] <si-1> #h(0.45em) B. Song, L. Zhang, C. He, T. F. J. Poon, E. Hajiyev, S. Zhang, X.-J. Liu, and G.-B. Jo, Science advances #strong[4], eaao4748 (2018).

#link(<si-2>)[[2]] <si-2> #h(0.45em) Z. Ren, D. Liu, E. Zhao, C. He, K. K. Pak, J. Li, and G.-B. Jo, Nature Physics #strong[18], 385 (2022).

#link(<si-3>)[[3]] <si-3> #h(0.45em) B. Song, C. He, S. Niu, L. Zhang, Z. Ren, X.-J. Liu, and G.-B. Jo, Nature Physics #strong[15], 911 (2019).

#link(<si-4>)[[4]] <si-4> #h(0.45em) L. Zhang, L. Zhang, and X.-J. Liu, Physical Review A #strong[99], 053606 (2019).

#link(<si-5>)[[5]] <si-5> #h(0.45em) C.-R. Yi, L. Zhang, L. Zhang, R.-H. Jiao, X.-C. Cheng, Z.-Y. Wang, X.-T. Xu, W. Sun, X.-J. Liu, S. Chen, et al., Physical review letters #strong[123], 190603 (2019).

#link(<si-6>)[[6]] <si-6> #h(0.45em) N. Okuma, K. Kawabata, K. Shiozaki, and M. Sato, Physical review letters #strong[124], 086801 (2020).

#link(<si-7>)[[7]] <si-7> #h(0.45em) K. Zhang, Z. Yang, and C. Fang, Nature communications #strong[13], 1 (2022).

#link(<si-8>)[[8]] <si-8> #h(0.45em) X.-J. L. Zhi-Yuan Wang and Jian-Song Hong, Phys. Rev. B #strong[108], L060204 (2023).

#link(<si-9>)[[9]] <si-9> #h(0.45em) Z. Y. Chun-Hui Liu, Kai Zhang, and S. Chen, Phys. Rev. Research #strong[2], 043167 (2020).

#link(<si-10>)[[10]] <si-10> #h(0.45em) T. Hofmann, T. Helbig, F. Schindler, N. Salgo, M. Brzezińska, M. Greiter, T. Kiessling, D. Wolf, A. Vollhardt, A. Kabaši, et al., Physical Review Research #strong[2], 023265 (2020).

#link(<si-11>)[[11]] <si-11> #h(0.45em) M. S. Kohei Kawabata and K. Shiozaki, Phys. Rev. B #strong[102], 205118 (2020).

#link(<si-12>)[[12]] <si-12> #h(0.45em) T. M. Tsuneya Yoshida and Y. Hatsugai, Phys. Rev. Research #strong[2], 022062(R) (2020).

#link(<si-13>)[[13]] <si-13> #h(0.45em) T. Kaluza, International Journal of Modern Physics D (2018).

#link(<si-14>)[[14]] <si-14> #h(0.45em) O. Klein, Z. Phys. #strong[37], 895 (1926).

#link(<si-15>)[[15]] <si-15> #h(0.45em) O. Klein, Nature #strong[118], 516 (1926).