#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.38cm), columns: 2)
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
#set par(justify: true, spacing: 0.77em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.77em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Observation of quantum strong Mpemba effect])   #v(1.2em)
    #text(10.5pt)[Jie Zhang#super[1], Gang Xia#super[1], Chun-Wang Wu#super[1], Ting Chen#super[1], Qian Zhang#super[4], Yi Xie#super[1], Wen-Bo Su#super[1], Wei Wu#super[1], Cheng-Wei Qiu#super[5], Ping-Xing Chen#super[1], Weibin Li#super[6], Hui Jing#super[4], Yan-Li Zhou#super[1]]
  
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Institute for Quantum Science and Technology, College of Science, National University of Defense Technology, Changsha 410073, China] \
    #text(9pt)[#super[2] Hunan Key Laboratory of Mechanism and technology of Quantum Information, Changsha 410073, China] \
    #text(9pt)[#super[3] Hefei National Laboratory, Hefei 230088, Anhui, China] \
    #text(9pt)[#super[4] Key Laboratory of Low-Dimensional Quantum Structures and Quantum Control of Ministry of Education, Hunan Normal University, Changsha 410081, China] \
    #text(9pt)[#super[5] Department of Electrical and Computer Engineering, National University of Singapore, Singapore, Singapore] \
    #text(9pt)[#super[6] School of Physics and Astronomy, University of Nottingham, Nottingham NG7 2RD, United Kingdom] \
    #text(9pt)[#super[7] Centre for the Mathematics and Theoretical Physics of Quantum Non-equilibrium Systems, University of Nottingham, Nottingham NG7 2RD, United Kingdom] \
    #text(9pt)[#super[8] College of Science, National University of Defense Technology, Changsha 410073, China] \
  ]
  #v(1.2em)






  #footnote[These authors contributed equally to this work.]





  #footnote[These authors contributed equally to this work.]



























































// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: November 14, 2024)]]

  An ancient and counterintuitive phenomenon known as the Mpemba effect showcases the critical role of initial conditions in relaxation processes. How to realize and utilize this effect for speeding up relaxation is an important but challenging task in purely quantum system till now. Here, we experimentally study the strong Mpemba effect in a single trapped ion system in which an exponentially accelerated relaxation in time is observed by preparing an optimal quantum initial state with no excitation of the slowest decaying mode. Also, we demonstrate that the condition of realizing such effect coincides with the Liouvillian exceptional point, featuring the coalescence of both the eigenvalues and the eigenmodes of the systems. Our work provides an efficient strategy to engineer the dynamics of open quantum system, and suggests a link unexplored yet between the Mpemba effect and the non-Hermitian physics.
]





= INTRODUCTION
<introduction>
Relaxations or dissipative evolutions from initial states to a stationary state, widely existing in nature, are vital for fundamental studies of nonequilibrium phenomena and practical control of dynamical devices @Breuer2007 @Mohseni2014. In quantum realm, rapid relaxations are highly desirable for efficient quantum state preparation and qubit engineering @Verstraete2009 @Harrington2022 @Dann2019 @Wu2021c @Khandelwal2021 @Kumar2022. As a possible strategy to achieve this goal, the Mpemba effect (ME) @Mpemba_1969, well-known in the counterintui-tive example that water can cool faster when initially heated up, has attracted growing interests both in classical @Lu2017 @Klich2019 @Gal2020 @Kumar2020b @Bechhoefer2021 @Teza2023a @Pemartin2024 @Ibanez2024 and quantum systems in recent years~@Carollo2021 @Nava2019 @Kochsiek2022 @Manikandan2021 @Ares2023 @Rylands2023 @Ivander2023 @Chatterjee2023 @Chatterjee2023b @Moroder2024 @Boubakour2024 @Joshi2024 @Shapira2024. Often, this and related phenomena admits a general explanation @Lu2017 @Lasanta2017 @Gal2020  the state of the hotter system overlaps less with the slowest decaying mode (SDM) of the dissipative or cooling dynamics, implying the critical role of initial conditions in relaxations (see @fig-classical-vs-quantum(a-b)).


For purely quantum systems at zero temperature, the main challenge is to identify ME-induced rapid relaxations that are not smeared out by quantum superposition~@Carollo2021. Very recently, Carollo et al. ~@Carollo2021 proposed that strong ME (sME) or exponential speed-up of relaxation can emerge in Markovian open quantum systems by devising an optimal initial state (i.e., sME state) to prohibit excitation of the slowest decaying mode (SDM, see @fig-classical-vs-quantum(c)). This prediction of quantum sME, however, has not been experimentally realized till now, hindering its possible applications in e.g. 'engineered' relaxation dynamics of the open quantum system @Bechhoefer2021.


Here, we report the observation of the sME in a truly quantum system, which is a genuine quantum effect and cannot be captured by semi-classical methods. As an essential step towards this target, we construct the sME state via efficient gate operations on a single trapped ion and show that with such special pure state, featuring zero overlap with the SDM, exponential speeding-up of relaxations can be observed (see @fig-classical-vs-quantum(d-g)). Also we find that a critical point can appear in our system, separating the regimes with or without exponential acceleration of relaxations, which coincides well with the Liouvillian exceptional point (LEP) @Bender2007 @Chen2017 @Hodaei2017 @Miri2019 @Minganti2019 @Naghiloo2019 @Chen2021a @Chen2022. Furthermore, we observe both eigenvalues and eigenmodes coalesce at the LEP in the experiment by measuring the overlaps with the decaying modes. Our findings indicate a possible link unexplored yet between quantum ME and non-Hermitian physics @Ding2016 @Zhou2023 @Purkayastha2020 @Khandelwal2021 @Zhang2022 @Chen2021a @Chen2022 @Bu2023, which may stimulate more exciting efforts on e.g., engineering quantum sME with higher-order or topological LEPs @Chen2021a @Chen2022 @Bu2023.


// [figvision-cn] imgs/fig1.png
// 整幅插图分为左右两大区域，左区标注为“Classical sME”（
// 经典强姆潘巴效应），右区标注为“Quantum sME”（量子强姆
// 潘巴效应），每个区域内包含多个子图。所有背景为白色，线
// 条与标注文字以黑色为主，辅助使用蓝色、红色、绿色、紫色
// 和棕色区分不同曲线与符号。 子图 a：曲线图。横轴为“
// Temperature”（温度），从低温向高温递增，标有刻度位置
// T_C、T_S 和 T_H（T_C < T_S < T_H）。纵轴为“Overlap
// with SDM”（与最慢衰减模式的交叠），范围从 0 到 1。图中
// 有一条蓝色曲线，从温度最低处纵坐标 1 开始，先单调下降，
// 在 T_S 处降到纵坐标 0，然后单调上升，在 T_H 处约为 0.6。
// T_C 和 T_H 位置各有一条竖直虚线向下延伸至横轴附近。曲
// 线最小值处标有一个红色向下箭头，箭头旁文字为“strong ME
// ”。该图说明：初始态与 SDM 的交叠幅度随温度非单调变化，
// 在 T_S 处交叠为零，对应经典强姆潘巴效应。 子图 b：时间
// 演化示意图，纵轴为“Distance”（距离），横轴为“time”（时
// 间），未标具体数值刻度。图中包含三个并排的小面板。左侧
// 面板标题“weak ME”，显示两条从不同初始点出发的下降曲线：
// 较高初始点标为 T_H（红色实线），较低初始点标为 T_C（蓝
// 色实线）；T_C 初始点更高？此处按图面严格描述：T_H 初始
// 纵坐标较高，T_C 较低；两条曲线均随时间下降，红线下降速
// 度更快，最终在较晚时刻与蓝线交叉。中间面板标题“strong
// ME”，初始点 T_H（红色实线）位于较高纵坐标，T_S（蓝色实
// 线）位于较低纵坐标；蓝线下降较慢，红线下降极快，红线在
// 较早时刻穿过蓝线。右侧面板标题“No ME”，初始点 T_H（红
// 色实线）仍高于 T_C（蓝色实线）；两条曲线下降速度相近，
// 红线始终位于蓝线上方，不发生交叉。三个面板上方有一个红
// 色粗箭头，从子图 a 指向该区域。该图说明：弱 ME 中高温
// 态初始距离较大但衰减更快，强 ME 中高温态在更短时间内变
// 得比低温态更接近平衡，无 ME 时高温态始终比低温态距离大。
// 子图 c：状态空间示意图。标注“initial state”（初始态）
// 位于上方，用红点和蓝点表示；“SDM”用灰色圆点表示；“
// stationary state”（稳态）用黑色圆点表示。红色箭头从红
// 点（标注 sME）指向黑点，蓝色箭头从蓝点（标注 |0⟩）指向
// 黑点，灰色箭头从灰色 SDM 圆点指向黑点。图中还画出一个
// 弯折的灰色箭头，绕经初始态与 SDM 点之间。该图表明量子
// 初态在状态空间中向稳态演化，不同初态与 SDM 的相对位置
// 影响衰减行为。 子图 d：三能级系统示意图。三条水平黑线
// 表示能级，从上到下标注为 |1⟩、|2⟩、|0⟩。|1⟩ 与 |0⟩ 之
// 间用红色双箭头连接，标注 Ω_1；|2⟩ 与 |0⟩ 之间用绿色双
// 箭头连接，标注 Ω_2。红色双箭头旁另标注 κ_1，绿色双箭头
// 旁标注 κ_2。该图描述量子强姆潘巴效应所涉及的三能级耦合
// 与衰减通道。 子图 e：曲线图。横轴为“s”，范围从 0 到 π/
// 2，刻度标出 0 和 π/2。纵轴为“Overlap with SDM”，范围 0
// 到 1。蓝色曲线从 s=0 处纵坐标约 0.7 开始，先略升后下降，
// 在 s 约为 0.9 处降到 0，然后上升，在 π/2 处回到约 0.7。
// 纵坐标 0 处有一个紫色圆点，对应 s 约 0.9，旁有紫色文字
// “sME”。蓝色曲线左端标有 |0⟩，右端标有 |2⟩。曲线最低点
// 上方有红色向下箭头，旁标“strong ME”。该图说明量子情形
// 下交叠随参数 s 非单调变化，并在 sME 点处归零。 子图 f：
// 曲线图。横轴为“Ω_1 t”，采用对数坐标，刻度标出 0.10、1、
// 10、100。纵轴为“Distance”，范围 0.0 到 1.0，刻度 0.0、
// 0.2、0.4、0.6、0.8、1.0。图例显示三种符号：紫色空心圆
// 对应 |0⟩（紫色虚线），绿色空心三角对应 |2⟩（绿色点线），
// 红色空心菱形对应 |sME⟩（红色点线）。数据为离散点连线：
// 紫色曲线从约 0.65 缓慢下降，在 Ω_1 t 约 1 后加速下降，
// 至 10 附近接近 0；绿色曲线从约 0.9 先缓降，约 0.8 后快
// 速下降，在 10 附近接近 0；红色曲线从约 0.9 快速下降，
// 在 Ω_1 t 约 1 处已接近 0，随后与纵轴 0 附近波动。误差
// 棒可见于部分数据点。该图显示 |sME⟩ 初态的距离衰减最快，
// |2⟩ 次之，|0⟩ 最慢。 子图 g：曲线图。横轴为“Ω_1 t”，线
// 性坐标，范围 0 到 25，刻度 0、5、10、15、20、25。纵轴
// 为“Distance”，对数坐标，范围从 10^{-1} 到 1，标出 10^{
// -1} 和 1。图中三条曲线分别与子图 f 图例一致：紫色空心
// 圆连线从约 1 开始，中段有平台，后段在 10 之后快速下降，
// 标注“slow relaxation”（慢弛豫）；绿色空心三角连线从约
// 1 开始，下降很慢，在 25 处仍在 0.5 左右；红色空心菱形
// 连线从约 1 快速下降，在 Ω_1 t 约 5 处降到 10^{-1} 以下，
// 标注“fast relaxation”（快弛豫）。该图放大了短时行为，
// 说明 |sME⟩ 呈现快速弛豫，而 |2⟩ 和 |0⟩ 呈现较慢弛豫。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [TABLE #context it.counter.display(it.numbering). #it.body]
}

#figure(scope: "parent", 
  image("imgs/fig1.png", width: 100%),
  caption: [
    Comparison for classic and quantum Mpemba effect. *a* The ME can be understood in an intuitive way: the amplitude of the overlap of the initial state with the slowest decaying mode (SDM) depends on the initial temperature in a nonmonotonic way. The sME appears when the overlap with the SDM vanishes. *b* Weak ME: If an initial high temperature state has a smaller SDM amplitude than that of the lower temperature state, it can reach the thermal equilibrium faster. Strong ME: the system reaches equilibrium at an exponentially faster rate. No ME: the initial high temperature state has a larger overlap with the SDM and thus reaches the equilibrium slower. *c* By applying a unitary operation, one can realize an initial sME state and approaches the stationary state with a faster rate. *d* The energy levels for observing the sME (with $kappa_2 lt.double kappa_1$). *e* The overlap $|c_1|$ of a rotated initial random state with the SDM as a function of the rotation angle $s$. *f* The distance between the time-relaxed state $rho(t)$ and the stationary state $rho_("ss")$ for different initial states: $|0⟩$ (blue), $|2⟩$ (green) and $|"sME"⟩$ (red), respectively. The initial sME state starts with a longer distance from $rho_("ss")$ than the initial state $|0 (2)⟩$ but reaches $rho_("ss")$ faster. *g* The logarithmic scale of the distance evolves with time for different initial states. An exponential speed-up of relaxation is clearly observed for the sME initial state. The experimental parameters for (*e*-*g*) are $Omega_1 = 2 pi times 20$ kHz, $Omega_2 = 0.06 Omega_1 , kappa_1 = 2 Omega_1 , kappa_2 = 0.0015 Omega_1$, and the solid lines here are the theoretical predictions based on the experimental parameters.
  ],
) <fig-classical-vs-quantum>



= RESULTS
<results>
== Theory of quantum strong Mpemba effect
<theory-of-quantum-strong-mpemba-effect>
To understand the quantum sME, we consider a Lindblad master equation $dot(rho) = cal(L) rho(t)$, where $cal(L)$ is the Liouvillian superoperator @Macieszczak2016a @Carollo2021 @Minganti2019 $ cal(L) rho = - i[H , rho] + sum_alpha(J_alpha rho J_alpha^dagger - 1/2 (J_alpha^dagger J_alpha , rho)) .$ Here $H$ is the Hamiltonian of the system and $J_alpha$ are the quantum jump operators. The density operator $rho(t)$ can be expanded as the sum of all eigenmodes ($R_i$) of $cal(L)$ $ rho(t) = e^(cal(L) t) = rho_("ss") + sum_(i = 1)^(d^2 - 1) c_i e^(lambda_i t) R_i .$ Here $R_i(L_i)$ are the right (left) eigenmatrices of the Liou-villian superoperator $cal(L)$, with the corresponding eigenvalues $lambda_0 > op("Re")[lambda_1] >= op("Re")[lambda_2] >= op("Re")[lambda_3] >= . . .$, and $lambda_0 = 0$. $lambda_0$ or its eigenmatrix $R_0$ denotes the stationary state $rho_("ss")$, which is independent of any initial state $rho_("in")$, while the real parts of other eigenvalues $lambda_(i >= 1)$ indicate the relaxation rates of the eigenmodes $R_i$. Coefficients $c_i = op("Tr")[L_i rho_("in")]$ give the overlap of $L_i$ with $rho_("in")$, and $d^2$ denotes the number of the decay modes.


Generally, an initial state can overlap with all decaying modes of Lindblad dynamics, but at long times the relaxation is dominated by the slowest one $R_1$ @Minganti2018 @Macieszczak2016a @Teza2023a @Kumar2020b. The decay rate of the eigenmode $R_1$ sets an exponential timescale of the relaxation $tau_1 = 1/|op("Re")[lambda_1]|$@Znidaric2015 @Minganti2018 @Macieszczak2016a, which is normally independent of the initial state. But for the ME case, anomalous fast relaxations can be achieved by designing a special form of the overlap $c_1$ featuring smaller or even zero overlap with the SDM @Klich2019 @Kumar2020b @Carollo2021 @Kochsiek2022.


The quantum sME can be realized by designing such an initial state $|"sME"⟩$ satisfying~@Carollo2021, $ op("Tr")[L_1|"sME"⟩ ⟨"sME"|] = c_1 = 0 .$ This optimal state $|"sME"⟩$ is prepared by applying a well devised unitary transformation to an initially pure quantum state of the system ~@Carollo2021. Therefore the sME state is normally a quantum superposition state, which represents a fundamental difference from classic sME, and thus the resulting dynamical behaviour cannot be captured by semi-classical approaches (see Supplementary note 1). Since this sME initial state has zero overlap with the SDM, the relaxation rate of the system is thus $|op("Re")[lambda_2]|$, with the timescale $tau_2 = 1/|op("Re")[lambda_2]|$, instead of $tau_1 = 1/|op("Re")[lambda_1]|$. This implies an exponentially faster convergence to the stationary state by a factor $op("Re")[delta lambda_(12)] = op("Re")[lambda_1 - lambda_2]$.


== Experimental approach
<experimental-approach>


The experimental setup and relevant energy levels for the quantum sME are shown in @fig-setup-and-relaxation(a-b). The ground state $|0⟩ =|4^2 S_(1/2) , m_j = - 1/2⟩$ is resonantly coupled to state $|1⟩ =|3^2 D_(5/2) , m_j = - 5/2⟩$ and $|2⟩ =|3^2 D_(5/2) , m_j = 3/2⟩$ by one 729 nm laser beam with two frequency components and the corresponding Rabi frequencies are $Omega_1$ and $Omega_2$, respectively. Another laser at 854 nm with right circular polarization induces a tunable decay channel between state $|1⟩$ and $|0⟩$ with decay rate $kappa_1$, by coupling $|1⟩$ to a short-life level $|4^2 P_(3/2) , m_j = - 3/2⟩$, which will decay quickly back to the state $|0⟩ =|4^2 S_(1/2) , m_j = - 1/2⟩$ (see Supplementary note 2). The imperfect polarization of 854 nm will cause slow decay from state $|2⟩$ to $|0⟩$ with decay rate $kappa_2 lt.double kappa_1$ and also the leakage of population to the other Zeeman ground state. Fortunately, the leakage problem can be fixed by introducing a weak optical pumping beam at 397 nm during the data acquisition process. Then for the effective three-level system, we have the Hamiltonian $H = sum_(j = 1 , 2) Omega_j/2 (|0⟩ ⟨j|+|j⟩ ⟨0|)$ and two jump operators $J_j = sqrt(kappa_j)|0⟩ ⟨j|$ ($j = 1 , 2$).


// [figvision-cn] imgs/fig2.png
// 子图a：实验装置示意图，展示量子单模激发(sME)实验的光路
// 与电子控制布局。左侧有两台激光器：上方标注Laser，波长
// 729 nm；下方标注Laser，波长854 nm。729 nm激光经过AOM 1
// （声光调制器，由任意波形发生器AWG通过虚线控制），再经
// 透镜(Lens)和反射镜(Mirror)反射后，从右上方斜向穿过一个
// 黄色双锥形腔体（代表Paul陷阱电极），聚焦于腔体中心的蓝
// 色圆点（代表单个40Ca+离子）。854 nm激光经过AOM 2（由正
// 弦波形信号源通过虚线控制），经透镜和反射镜后，从右下方
// 斜向穿过同一黄色腔体并聚焦于中心离子。黄色腔体上方标有
// 箭头B，表示存在磁场。AWG为蓝色方框，带显示屏和键盘。图
// 中所有光路用红色实线表示，虚线表示电信号连接。 子图b：
// 40Ca+离子能级与跃迁示意图。左侧竖直线表示能级：4²S₁/₂
// (m_J=-1/2)为基态，4²P₃/₂为高能态，4²D₅/₂为中能态。397
// nm蓝色波浪箭头表示从4²S₁/₂到4²P₃/₂的跃迁；854 nm红色波
// 浪箭头表示从4²D₅/₂到4²P₃/₂的跃迁；729 nm红色直线箭头表
// 示从4²S₁/₂到4²D₅/₂的跃迁。右侧灰色圆角矩形内放大了4²D₅
// /₂能级，分为三个磁子能级：-5/2、-3/2、3/2。标注|0⟩对应
// -5/2，|1⟩对应-3/2，|2⟩对应3/2。红色实线箭头Ω₁连接|0⟩与
// |1⟩，红色波浪线κ₁表示从|1⟩的衰减；绿色实线箭头Ω₂连接|1
// ⟩与|2⟩，绿色波浪线κ₂表示从|2⟩的衰减。 子图c：实验时序
// 流程图。从左至右依次为：初始态|0⟩⟨0|（浅蓝色圆角矩形）、
// operation（绿色圆角矩形）、dynamics（浅蓝色圆角矩形）、
// tomography（紫色圆角矩形）、一个带箭头和圆点的测量符号
// （浅紫色圆形），最后箭头指向ρ(t)。各模块之间用黑色箭头
// 连接。 子图d、e、f：三行分别对应初始态|0⟩、|2⟩和|sME⟩
// 的弛豫动力学。每行左侧为布居数演化曲线，右侧为三个柱状
// 图。左侧曲线图横轴为Ω₁t，对数坐标，范围约0.005至300；
// 纵轴为Population，线性坐标，范围0至1.0。图例：蓝色空心
// 圆点ρ₀₀、绿色空心三角ρ₁₁、红色空心菱形ρ₂₂。图d中初始时
// 刻ρ₀₀≈0.95，随后下降，ρ₁₁和ρ₂₂上升，在Ω₁t≈10附近趋于稳
// 态，标注"approach to ρ_ss"。图e中初始时刻ρ₂₂≈0.95，随
// 后下降，ρ₀₀上升，ρ₁₁先升后降，标注"approach to ρ_ss"。
// 图f中初始时刻ρ₀₀≈0.6、ρ₁₁≈0.2、ρ₂₂≈0.2，标注"approach
// to ρ_ss"，并有两条竖直虚线标出τ₂和τ₁。右侧柱状图纵轴为
// |c_i|，范围0至1.0；横轴为基矢ρ_ss, R₁, R₂, R₃, R₄, R₅,
// R₆, R₇, R₈。黑色实心柱表示theoretical（理论值），空心
// 圆点表示experimental（实验值）。图d中标注c₁(0)≠0，并有
// 一个红色向下箭头指向ρ_ss处的绿色柱；图e中标注c₁(0)≠0；
// 图f中标注c₁(0)=0，并有一个红色向下箭头指向ρ_ss处。三个
// 柱状图分别对应|c_i(0)|、|c_i(τ₂)|、|c_i(τ₁)|。图d中ρ
// _ss处绿色柱约0.4，R₄处约0.2，R₅处约0.2；图e中ρ_ss处绿
// 色柱约0.75，R₁处约0.1；图f中ρ_ss处灰色柱约0.8，R₁处约
// 0.6，R₂处约0.6，R₅处约0.4，R₆处约0.4，R₇处约0.2，R₈处
// 约0.2。实验值与理论值总体吻合。
#figure(scope: "parent", 
  image("imgs/fig2.png", width: 100%),
  caption: [
    Experimental setup and relaxation dynamics for different initial states. *a* Experimental setup of quantum sME. The coherent driving between the S state and D state is realized by using a 729 nm laser beam with linewidth about 100 Hz. Two transitions required (as shown in *b*) are simultaneously driven by injecting two RF frequencies to an acoustic-optic modulator (AOM1) via an arbitrary waveform generator (AWG). The decay rate of the D state is controlled by the power of 854 nm laser. *b* The relevant energy levels of a single $""^(40)"Ca"^+$ ion involved in the experiment, with state $|0⟩ ,|1⟩ ,|2⟩$ are encoded in the energy levels $|4^2 S_(1/2) , m_j = - 1/2⟩$, $|3^2 D_(5/2) , m_j = - 5/2⟩$ and $|3^2 D_(5/2) , m_j = 3/2⟩$, respectively. The energy gap of state $|1⟩$ and $|2⟩$ can minimize detrimental effect from the polarization impurity of the 854 nm laser beam. *c* Protocol to generate the sME initial state and tomography of the density matrix $rho(t)$. After generating the initially sME state by applying two rotation gates on the state $|0⟩$, the system evolves with the Liouvillian superoperator $cal(L)$ of interest. After a time $t$, projective measurements are performed for the tomography of the state $rho(t)$. *d*-*f* Left: The dynamics of the state population $rho_("ii") = op("Tr")[|i⟩ i ⟨|rho(t)] (i = 0 , 1 , 2)$ for initial states $|0⟩$ (*d*), $|2⟩$ (*e*) and $|"sME"⟩$ (*f*) on a logarithmic timescale. Right: The evolving overlap $|c_i(t)|=|op("Tr")[L_i rho(t)]|$ for three time stamps at $0 , tau_2 , tau_1$. The solid lines indicate the theoretical results based on the experimental parameters same with @fig-classical-vs-quantum(*e*-*g*) and the error bars are generated by using Monte Carlo simulation.
  ],
) <fig-setup-and-relaxation>



To observe quantum sME, we initialize the ion in the ground state $|0⟩$ and subsequently rotate it by applying a unitary operation $U$ @Carollo2021 (see @fig-setup-and-relaxation(c)). Although this transformation can be exactly constructed through the decomposition method @Nielsen2011, it is still challenging to realize it with high fidelity in the experiment since at least six gate operations are required for our case. To overcome this obstacle, here we optimize the operations to two qubit-rotations (see Methods for technical details). The rotated state then relaxes with the desired Liouvillian superoperator $cal(L)$. The final step is quantum state tomography, i.e., performing the projective measurements on the time-relaxed state $rho(t)$ as it relaxes from the initial state $rho_("in")$ to the final stationary $rho_("ss")$. We remark that both the dynamical process and the state readout need to be carefully regulated, accompanying with the optimization procedure (see Methods).


== Quantum strong ME
<quantum-strong-me>


With the aid of tomography of $rho(t)$, we can characterize the relaxation process by using the Hilbert-Schmidt distance @Carollo2021 $ cal(D)(rho(t) , rho_("ss")) = norm(rho(t) - rho_("ss")) ,$ with the notation $norm(A) = op("Tr")[sqrt(A^dagger A)]$. As presented in @fig-classical-vs-quantum(f), the sME initial state generated by our method is farther from the stationary state than normal initial states $|0 (2)⟩$. This is due to the fact that while $U$ removes the SDM excitation, it also modifies the excitation of the remaining ones @Carollo2021. Nonetheless, the approach to stationarity for sME initial state is still faster since the SDM ($R_1$) is cut off by $U$ @Carollo2021. @fig-classical-vs-quantum(g) gives the Logarithmic scale of distance $cal(D)(rho(t) , rho_("ss"))$. Compared with the normal initial states, an exponential speeding-up of the relaxation is reached for the sME initial state, a clear evidence of quantum sME. It can also be observed by other distance measures, for instance, the trace distance @Nielsen2011 or Bures distance @VanVu2021c @Garcia-Pintos2022 (see Supplementary note 1).


@fig-setup-and-relaxation(d-f) illustrates the relaxation dynamics of initial states $|0⟩$, $|2⟩$, and $|"sME"⟩$, respectively, under same experimental parameters. We find that they all reach the same steady state after a sufficiently long time, but the relaxation time of the sME initial state is significantly shorter. For the normal initial states $|0 (2)⟩$ (see @fig-setup-and-relaxation(d-e)), when $t gt.double tau_2$ the system relaxes into a state in the metastable manifold till $tau_1 = 1/|op("Re")[lambda_1]|$ @Macieszczak2016a. Differently, as seen in @fig-setup-and-relaxation(f), the application of $U$, cutting of the excitation of the SDM, leads to striking faster approach to the steady state with the time scale $tau_2 lt.double tau_1$. In order to visualise their overlaps on each decaying mode, we give all coefficients $c_i(t)$ of $rho(t)$ decomposition into all the decaying modes at time $t = 0$, $t = tau_2$, and $t = tau_1$, respectively. As depicted in @fig-setup-and-relaxation (d-e), when time $t = 0$, a generic initial state will normally overlap with the slowest one, i.e., $c_1 (0) != 0$. When time $t > tau_2$, the overlap of initial state with the short-life excitation modes ($R_(i > 1)$) becomes very small, while the SDM ($R_1$) is still relevant and keeps the system away from stationarity for a long time till $t gt.double tau_1$. However, for the sME initial state, $c_1 = 0$, therefore, the relaxation time scale is reduced to $tau_2$ with a faster decay rate $|op("Re")[lambda_2]|$ (see @fig-setup-and-relaxation (f)). Note that the coefficient on $R_0$ (i.e., the stationary state) has the form $c_0 (t) = op("Tr")[L_0 rho(t)] = op("Tr")[rho(t)] = 1$ and consistently remains at 1 for all the time, while the coefficients on other decay modes $c_i(t) = c_i e^(lambda_i t) = op("Tr") "[" L_i rho_("in")] e^(lambda_i t)(i = 1 , 2 . . .)$ decrease with time for the reason $op("Re")[lambda_i] < 0$.


== From strong ME to weak ME
<from-strong-me-to-weak-me>


Can this exponential acceleration always happen for the sME initial state? To check this, we measure the distance $cal(D)(rho(t) , rho_("ss"))$ and the overlaps $c_(1 , 2)(t)$ for different parameters of the system. As shown in @fig-strong-to-weak(a-b), for the normal initial state $|0⟩ (|2⟩)$, the distance has similar dynamical behavior with the overlap $c_1 (t)$ at the final stage of the relaxation, i.e., $rho(t) - rho_("ss") tilde.eq c_1 e^(lambda_1 t) R_1$. While for sME intial state, it becomes to $rho(t) - rho_("ss") tilde.eq c_2 e^(lambda_2 t) R_2$. When $Omega_2/Omega_1 lt.double 1$, the accelerated relaxation achieved for sME initial state is very significant, since in this regime $|op("Re")[lambda_1]|lt.double|op("Re")[lambda_2]|$, as shown in @fig-strong-to-weak(c). While as $Omega_2$ increases, this exponential gain $|op("Re")[delta lambda_(12)]|$ decreases and even disappears when $Omega_2$ passes across the LEP, where $lambda_1 = lambda_2$ and $R_1 = R_2$. The reason is that when $Omega_2/Omega_1 > "LEP"$, the eigenvalue of the SDM of the $cal(L)$ forms a complex conjugate pair, i.e., $lambda_1 = lambda_2^*$ (see @fig-strong-to-weak(c)), which means that the decaying modes $R_1$ and $R_2$ have the same decay rate. Meanwhile, the imaginary parts of eigenvalues $lambda_(1 , 2)$ result in the oscillating during the relaxation process @Khandelwal2021 @Zhang2022 (Supplementary note 1). Even though, comparing with normal initial states which have two SDMs, the sME initial state here just has one so that it may still be faster to the stationary state. Different with sME featuring a faster decay rate, this acceleration here corresponds to the weak ME which is associated with a smaller overlap with the SDM @Klich2019. As a consequence, LEP is the boundary between the quantum strong ME and weak ME, showing that an existence of the quantum strong ME is limited to the regime in which $lambda_1$ is real. It is helpful for deepening the understanding of the relaxation speed limit from both LEPs and quantum ME perspectives.


Based on the measurements of the overlaps, we further demonstrate both eigenvalues (@fig-strong-to-weak(c)) and eigenmodes (@fig-strong-to-weak(d)) coalesce at LEP in the experiment. Whereas the impact of the decaying modes is often limited to transient dynamics, it presents a practical challenge for experimental observation of more than one eigenvalue of $cal(L)$. Normally, LEP happens at the point that an eigenvalue changes from real to complex @Chen2021a @Chen2022. However, this change just can show where LEP happens, but does not demonstrate the coalesce of the LEP, because the coalesce of LEPs typically occur in two or more eigenvalues. This challenge could be solved by fitting the measurement of $c_i(t) = c_i e^(lambda_i t)$ using a single exponential function of time. Based on this, theoretically, one can get the full spectrum of $cal(L)$. For our system here, considering the overlap $c_2$ is very small for initial state $|0 (2)⟩$), we choose to get $lambda_2$ by measuring $c_2 (t)$ of initial sME state and $lambda_1$ by measuring $c_1 (t)$ of initial state $|0⟩$. The results, as depicted in @fig-strong-to-weak(c), match well with the theoretical results and show that LEP is signaled by the degenerated of $lambda_(1 , 2) .$


As shown in @fig-strong-to-weak(d), the coalesce of the eigenmodes $R_1 (L_1)$ and $R_2 (L_2)$ at LEP is indicated by $c_1 = c_2$ for a fixed initial state, because at LEP $op("Tr")[L_1 rho_("in")] = op("Tr")[L_2 rho_("in")]$. This means the coalesce the coefficients is a detectable way to show the eigenmodes coalesce of LEP. Note that, as we observed in @fig-strong-to-weak(c-d), the bifurcation singularity of the spectrum and the overlaps $c_(1 , 2)$ is not detectable in the steady state but rather in the relaxation process @Minganti2019. In fact, for the dynamics at long times, $rho(t) - rho_("ss") tilde.eq c_1 e^(lambda_1 t) R_1$, thus LEP corresponds the final direction change of the dynamics from $R_1$ to $R_1 + R_1^dagger$. This direction change occurring at LEP is the further evidence of a direct link with anomalous phenomena arising in the relaxation process such as sME and the dynamical phase transition @Teza2023a @Orgad2024.


// [figvision-cn] imgs/fig3.png
// 整张图由左侧的六个子图（a、b各三列）和右侧的两个子图（
// c、d）组成，顶部有一个图例标明“初始态：蓝色空心圆=|0>，
// 绿色空心三角=|2>，红色空心菱形=|sME>”。左侧各列顶部标
// 注参数值分别为 Ω2/Ω1=0.04（<LEP）、0.16（接近 LEP）、
// 0.25（>LEP）。横轴均为 Ω1t，范围 0 到 25。 子图 a 为曲
// 线图，纵轴 D(ρ,ρe) 采用对数刻度，范围 1 到 10^-3。三列
// 分别对应不同 Ω2/Ω1。蓝色和绿色曲线在初始时刻接近 1，随
// 时间逐渐下降，在 Ω2/Ω1=0.04 时下降平缓，到 0.25 时下降
// 更快并在 Ω1t≈25 附近降到约 10^-2；红色曲线则在早期迅速
// 衰减，例如在 0.04 列中 Ω1t≈10 时降至 10^-2 以下。每个
// 子图内左下角带有小插图，同样以 Ω1t 为横轴、对数纵轴，
// 显示早期阶段红色曲线下降最快，蓝色曲线几乎保持平台，绿
// 色居中。 子图 b 为对应曲线图，纵轴 |c1,2(t)| 为对数刻
// 度。各列中蓝色曲线标记 c1(t) 在水平约 10^-1 附近形成平
// 台，随 Ω2/Ω1 增大略微下移；绿色曲线 c1(t) 从初始约 1
// 逐步下降，在 0.25 列中降至 10^-2 附近。红色曲线 c2(t)
// 从初始较低值开始快速衰减，误差棒明显，在 0.04 列中 Ω1t
// ≈20 时降至约 10^-2；在 0.25 列中 c2(t) 出现振荡并在 Ω
// 1t≈20 附近降至 10^-4 以下。小插图同样显示早期行为，强
// 调红色曲线快速回落。 子图 c 为曲线图，横轴 Ω2/Ω1 从 0
// 到 0.3，纵轴 Re[λ] 从约 -0.5 到 0.0。蓝色曲线从约 0 开
// 始小幅上升至约 -0.05；绿色曲线从约 0 下降至 -0.1；红色
// 曲线从约 -0.4 上升至 -0.2 附近，并在 Ω2/Ω1≈0.16 处与绿
// 色曲线相交。图中标注“LEP”位于约 0.16 处，竖直虚线标出
// 该分界，左侧区域标“strong ME”，右侧标“weak ME”。红色曲
// 线旁还标有“λ1=λ2”。 子图 d 为曲线图，横轴 Ω2/Ω1 从 0
// 到 0.3，纵轴 |c1,2| 从 0 到 1.0。图内标有图例：|0> 对
// 应红色实线 c1、红色点划线 c2；|2> 对应绿色实线 c1、绿
// 色点划线 c2。绿色实线从约 0.9 单调下降至约 0.5，并在
// 0.16 附近趋于平缓；绿色点划线从约 0.1 上升，在 0.16 附
// 近达到约 0.35 后维持平台。红色实线从约 0.05 快速上升至
// 约 0.4 后接近水平；红色点划线从接近 0 上升至约 0.3。所
// 有曲线在 Ω2/Ω1≈0.16 附近出现斜率变化，与子图 c 的 LEP
// 分界对应。
#figure(scope: "parent", 
  image("imgs/fig3.png", width: 100%),
  caption: [
    From strong ME to weak ME. *a* Logarithmic scale of distance $cal(D)(rho , rho_("ss"))$ evolves with time for different initial state: $|0⟩$ (blue), $|2⟩$ (green) and $|"sME"⟩$ (red), respectively. *b* The corresponding coefficients $c_1 (t)$ (of initial state $|0 (2)⟩$) and $c_2 (t)$ (of initial state $|"sME"⟩$). The sME that exits exponential acceleration is observed for $Omega_2/Omega_1 = 0.04, 0.16 (< "LEP")$. When $Omega_2/Omega_1 = 0.25 (> "LEP")$, $|"sME"⟩$ has the same decay rate with the normal initial states $|0 (2)⟩$, meaning the strong ME disappears but weak ME is allowed. *c* Real parts of the eigenvalues of the Liouvillian operator as a function of $Omega_2/Omega_1$. *d* Overlaps $|c_1|$ (solid) and $|c_2|$ (dashed) for different initial states $|0⟩$ (blue) and $|2⟩$ (green), respectively. The parameters are $Omega_1 = 2 pi times 20$ kHz, $kappa_1 = 2 Omega_1 , kappa_2 = 0.0015 Omega_1$. All error bars in this figure are calculated by using Monte Carlo simulation.
  ],
) <fig-strong-to-weak>



= DISCUSSION
<discussion>


In summary, we have observed the quantum sME in a single trapped-ion system by preparing an optimal pure state that has zero overlap with the SDM. For the quantum sME initial state, we propose an efficient quantum control technique for state preparation, dynamical engineering and state tomography. In addition, we reveal that quantum sME only happens within a certain parameter range, which is determined by LEP. Together with well-developed techniques of engineering quantum states, our work not only provides a powerful tool for exploring and utilizing the quantum sME as examples of engineered relaxation dynamics @Bechhoefer2021 but also bridges the LEP and quantum ME, two previously independent effects. Besides, the experi-mentally accessible methods discussed in the present manuscript, such as the the efficient unitary transformation and the overlaps measurement, will be valuable tools to assess the quality of the state preparation and the control of the system relaxation.


Note added: While submitting our manuscript, we became aware of another two experimental studies of the Mpemba effect performed with trapped ion systems appeared on arXiv, and currently they have been published on Phys. Rev. Lett. @Joshi2024 @Shapira2024.


= METHODS
<methods>


We explain here how to devise the unitary transformation $U$ to generate the quantum sME initial (pure) state $rho_("in")^("sME") =|"sME"⟩ ⟨"sME"|$. We firstly use the method performed in @Carollo2021 to get $|"sME"⟩$, then we explicitly construct feasible operation $U$ based on our experimental setting (see @fig-qutrit-protocol).


// [figvision-cn] imgs/fig4.png
// 本图是一张原理流程图，对比展示理论设计与实验实现任意纯
// 三能级量子态（qutrit）制备及密度矩阵测量的过程。图自上
// 而下分为三部分：顶部是一个概念性方框图；中部为浅橙色背
// 景的理论（theory）行；底部为浅蓝色背景的实验（
// experiment）行。各行从左至右分为初始态制备（initial
// state preparation）、动力学演化（dynamics）和层析测量
// （tomography）三个阶段。 顶部概念图：一个标有 ρ（密度
// 矩阵）的方框通过箭头指向一个标有 U（酉变换）的方框，随
// 后箭头指向输出端，输出表达式为 UρU†。该输出端通过一个
// 直角回折箭头连接至左端，表示这是一个闭环或迭代过程。
// 中部理论行（浅橙色）：左端初始态标注为 |0⟩⟨0|。初始态
// 制备阶段包含六个矩形脉冲操作块，从左至右依次为：R₀₂（
// 浅蓝色）、R₀₁（浅蓝色）、R⁺₀₂（浅黄色，右上角有加号）、
// R⁻₀₁（浅黄色，右下角有减号）、P₀₂（浅黄色）、P₀₁（浅黄
// 色）。随后进入动力学阶段，一个浅色方框标注为 e^{ℒ(Ω₁,Ω
// ₂)t}。最后进入层析测量阶段，一个浅蓝色方框标注为 𝒲(ϑ₁,
// ϑ₂)，其后连接一个带有指针的半圆形仪表盘图标，示意测量。
// 底部实验行（浅蓝色）：左端初始态同样标注为 |0⟩⟨0|。初
// 始态制备阶段仅包含两个矩形操作块：R₀₂（浅蓝色）和 R₀₁
// （浅蓝色），与理论行前两个块对应。动力学阶段方框标注为
// e^{ℒ(Ω'₁,Ω'₂)t}。层析测量阶段方框标注为 𝒲(ϑ'₁,ϑ'₂)，其
// 后同样连接一个半圆形仪表盘图标。实验行与理论行的对应方
// 框之间用浅灰色虚线连接，表明实验参数（带撇号）是对理论
// 参数（无撇号）的映射或调整。理论行与实验行在层析测量阶
// 段的仪表盘图标之间用红色双竖线标记。
#figure(scope: "parent", 
  image("imgs/fig4.png", width: 100%),
  caption: [
    Protocol to prepare arbitrary pure qutrit (three-level) states and to get the density matrix $rho(t)$ in the experiment. First, we construct the quantum state by engineering an 'virtual' but efficient unitary transformation $U = R_02 R_01$. Then in the dynamical process, the parameters of the lasers $Omega_(1 , 2)$ are adjusted accordingly to $Omega_1 e^(i phi.alt)$ and $Omega_2 e^(i phi.alt')$. Finally, the state tomography operations are changed accordingly to $cal(W)(theta.alt'_1 , theta.alt'_2)$.
  ],
) <fig-qutrit-protocol>



As discussed in @Carollo2021, the formula of this unitary can be expressed as $ U = exp[- i s(|phi.alt_1⟩ ⟨phi.alt_2|+|phi.alt_2⟩ ⟨phi.alt_1|)]|phi.alt_1⟩ ⟨0|,$ where $|phi.alt_(1 (2))⟩$ are the eigenstates of the left-hand eigenmatrix $L_1$ with the corresponding negative (positive) eigenvalues $alpha_(1 (2))$, $s = arctan(sqrt(|alpha_1/alpha_2|))$. This qutrit (three-level) $U$ operations can be decomposed into several qubit (two-level) rotations @Nielsen2011. Compared with qubit operations, a notable challenge in qutrit operations is that the elementary qubit operations lose their 'global-phase' gauge freedom because any phase shift is measured relative to the spectator level @Ringbauer2022.


Now we discuss how to overcome this technical challenge by applying a more efficient and practical way of decomposition, which requires only 2 two-level rotation operations in the experiment (see @fig-qutrit-protocol). Suppose an arbitrary qutrit pure state $|psi⟩ = U|0⟩ = (a , b , c)^T$ and $|a|^2 +|b|^2 +|c|^2 = 1$, then $U$ can be decomposed into a product of 2 two-level unitary matrices $U = A B$ @Nielsen2011, where $ A & = mat(delim: "(", a/sqrt(|a|^2 +|b|^2), b^(*)/sqrt(|a|^2 +|b|^2), 0; b/sqrt(|a|^2 +|b|^2), - a^(*)/sqrt(|a|^2 +|b|^2), 0; 0, 0, 1) ,\
B & = mat(delim: "(", a', 0, c^(*); 0, 1, 0; c, 0, -a'^(*)) , $ with $a' = sqrt(|a|^2 +|b|^2)$. The unitary $A$ and $B$ can be written in the form $ A & = & P_01 (alpha) Z_01 (beta) R_01 (gamma , pi/2) Z_01 (delta)\
 & = & P_01 (alpha) R_01^z(beta + delta) R_01 (gamma , pi/2 - 2 delta) ,\
B & = & P_02 (alpha') Z_02 (beta') R_02 (gamma' , pi/2) Z_02 (delta')\
 & = & P_02 (alpha') Z_02 (beta' + delta') R_02 (gamma' , pi/2 - 2 delta') , $ where $ P_01 (x) = mat(delim: "(", e^(i x), 0, 0; 0, e^(i x), 0; 0, 0, 1; #none), P_02 (x) = mat(delim: "(", e^(i x), 0, 0; 0, 1, 0; 0, 0, e^(i x); #none) ,\ Z_01 (x) = mat(delim: "(", e^(- i x), 0, 0; 0, e^(i x), 0; 0, 0, 1; #none), Z_02 (x) = mat(delim: "(", e^(- i x), 0, 0; 0, 1, 0; 0, 0, e^(i x); #none) , $


$ R_01 (x , y) = mat(delim: "(", cos(x/2), - i e^(- i y) sin(x/2), 0; - i e^(i y) sin(x/2), cos(x/2), 0; 0, 0, 1; #none) ,\
R_02 (x , y) = mat(delim: "(", cos(x/2), 0, - i e^(- i y) sin(x/2); 0, 1, 0; - i e^(i y) sin(x/2), 0, cos(x/2); #none) , $ and


$ gamma & = 2 cos^(- 1)(A_11) ,\
alpha & = 1/2 (arg(A_11) + arg(A_22) ,\
beta & = 1/2 (arg(A_21) - arg(A_11)) ,\
delta & = - alpha + arg(A_22) - beta ,\
gamma' & = 2 cos^(- 1)(B_11) ,\
alpha' & = 1/2 (arg(B_11) + arg(B_33)) ,\
beta' & = 1/2 (arg(B_31) - arg(B_11)) ,\
delta' & = - alpha' + arg(B_33) - beta' . $ Here we have translated the phase gates $P$ and $Z$ backwards which implement appropriate phase-shifts between the qutrit states @Ringbauer2022 @McKay2017. Then the final decomposed unitary operation for $U$ can be written as $ U & = & A B\
 & = & P_01 (alpha) Z_01 (beta + delta) R_01 (gamma , pi/2 - 2 delta) P_02 (alpha')\
 & & Z_02 (beta' + delta') R_02 (gamma' , pi/2 - 2 delta')\
 & = & P_01 (alpha) P_02 (alpha') Z_01 (beta + delta) Z_02 (beta' + delta')\
 & & R_01 (gamma , phi.alt) R_02 (gamma' , phi.alt') ,$ with $phi.alt = alpha' - (beta' + delta') + pi/2 - 2 delta , phi.alt' = pi/2 - 2 delta'$.


We can further simplify the unitary operation $U$ in a more efficient way by translating phase gates $P$ and $Z$ to the operation backwards till the detection due to the fact that the detection does not need phase information @McKay2017. By calculating the translated phase in software, we just need two rotation operations $R_01 R_02$ to generate arbitrary qutrit pure state experimentally, which can not only greatly simplify operations, but also improve the fidelity of sME state.


As shown in @fig-qutrit-protocol, our careful analysis shows that the corresponding dynamical operator and state tomography operations need to be modulated accordingly, $ cal(L)(Omega_1 , Omega_2) arrow.r cal(L)(Omega_1 e^(i phi.alt) , Omega_2 e^(i phi.alt')) .$ The state tomography for the qutrit system here requires 9 measurement basis, which are $|0⟩$, $|1⟩$, $|2⟩$, $(|0⟩ +|1⟩)/sqrt(2)$, $(|0⟩ + i|1⟩)/sqrt(2)$, $(|0⟩ +|2⟩)/sqrt(2)$, $(|0⟩ + i|2⟩)/sqrt(2)$, $(|1⟩ +|2⟩)/sqrt(2)$, $(|1⟩ + i|2⟩)/sqrt(2)$. However, only S or D state can be detected in the trapped ion system, therefore we need to rotate the basis to state $|0⟩$ before applying the detection beam since we have encoded state $|1⟩$ and $|2⟩$ in D state manifold. The rotation operation $cal(W)(theta.alt_1 e^(i phi.alt_(L 1)) , theta.alt_2 e^(i phi.alt_(L 2)))$ in the state tomography can be realized by simply combining the $pi$ or $pi/2$ pulses with translating phase $phi.alt_(L 1) = alpha' - 2 (beta + delta) - (beta' + delta')$ on the transition $|0⟩ arrow.l.r|1⟩$ and $phi.alt_(L 2) = alpha - 2 (beta' + delta') - (beta + delta)$ on the transition $|0⟩ arrow.l.r|2⟩$ respectively. After we get the projective measurement results of these basis, we can reconstruct density matrix by using maximum-likelihood method, and the error bars for the density matrix are obtained by using numerical simulations @PhysRevA.66.012303 @hu2023self.


= ACKNOWLEDGMENTS
<acknowledgments>
This work was supported by the Natural Science Foundation of Hunan Province of China under grant Nos. 2023JJ30626(Y.L.Z.), 2022RC1194(J.Z.), 2023JJ10052(J.Z.), National Natural Science Foundation of China under grant Nos. 12004430(J.Z.), 12174448(C.W.W.), 12074433(P.X.C.), 12174447(W.W.) and 12204543(T.C.). H.J. is supported by the NSFC (grant No.11935006), the Science and Technology Innovation Program of Hunan Province (grant No. 2020RC4047), National Key R&D Program of China (No. 2024YFE0102400) and Hunan provincial major sci-tech program (No. 2023ZJ1010), and P.X.C. acknowledges the support from Innovation Program for Quantum Science and Technology under grant No. 2021ZD0301605.


= AUTHOR CONTRIBUTIONS
<author-contributions>
Y.L.Z. conceived and designed the research with helpful discussions with H.J.,W.L. and P.X.C.; J.Z. and G.X. were responsible for the experimental implementation, the data acquisition and its evaluation; J.Z., Y.L.Z. and C.W.W. designed the experiment with the help of T.C., Y.X., W.W. and P.X.C.; Y.L.Z. performed the simulations; Y.L.Z., J.Z. and G.X. analyzed the data; Y.L.Z., J.Z, H.J., W.L. and C.W.Q. wrote the paper with inputs from G.X., T.C., Q.Z. and W.B.S. ; H.J., W.L. and P.X.C. supervised this project. All authors discussed the results and contributed to the manuscript.


= COMPETING INTERESTS
<competing-interests>
The authors declare no competing interests.








#pagebreak()
#set page(columns: 1)
= SUPPLEMENTARY INFORMATION: OBSERVATION OF QUANTUM STRONG MPEMBA EFFECT
<supplementary-information-observation-of-quantum-strong-mpemba-effect>


#footnote[These authors contributed equally: Jie Zhang, Gang Xia]





#footnote[These authors contributed equally: Jie Zhang, Gang Xia]
























































== Supplementary Note 1. Markovian open quantum dynamics, Liouvillian exceptional point, and quantum sME
<supplementary-note-1.-markovian-open-quantum-dynamics-liouvillian-exceptional-point-and-quantum-sme>


We first briefly discuss the fundamental elements of open quantum systems evolving under Markovian dynamics. The evolution of the density matrix $rho(t)$, is generated by the Lindblad master equation $ frac(d rho, d t) = cal(L) rho(t) := - i[H , rho] + sum_j(2 J_j rho J_j^dagger - (J_j^dagger J_j , rho)) ,$ where $cal(L)$ is the Liouvillian superoperator, $H$ is the Hamiltonian governing the unitary part of the dynamics, $J_j$ are the jump operators describing the dissipative process. Since the Liouvillian $cal(L)$ acts linearly on $rho(t)$, one can obtain the time evolution about the relaxation of any initial state $rho_("in")$ in terms of its eigenmatrices (eigenmodes) $R_i$ and the corresponding complex eigenvalues $lambda_i$ via the relation $cal(L) R_i = lambda_i R_i$: $ rho(t) = e^(cal(L) t) rho_("in") = rho_("ss") + sum_(i >= 1)^(d^2 - 1) c_i e^(lambda_i t) R_i .$ Here $c_i = op("Tr")[L_i rho_("in")]$ are coefficients of the initial state decomposed into the eigenmatrices of $cal(L)^dagger$ with $cal(L)^dagger L_i = lambda_i^* L_i$, $R_i$ and $L_i$ are referred as right and left eigenmatrices, respectively, and can be normalized by $op("Tr")[L_i R_j] = delta_(i j)$. The stationary state of the system under consideration is then given by the density matrix $rho_("ss")$ such that $cal(L) rho_("ss") = 0$, i.e., $rho_("ss") = R_0$, which corresponds to the zero eigenvalue $lambda_0 = 0$ and is independent of the initial state. The trace preservation of the dynamics implies that $op("Tr")[rho(t)] = op("Tr")[rho_("ss")] = 1 = op("Tr")[L_0 R_0]$, and thus $L_0$ is the identity ($L_0 = I$). It also implies that $op("Tr")[R_(i >= 1)] = 0$, which means other right eigenmatrices do not correspond to quantum states.


If the eigenvalues are ordered by decreasing their real parts, it is known that the negative real parts of the eigenvalues, $op("Re")[lambda_(i > 0)] < 0$, determine the relaxation rates of the system towards the stationary state, and the corresponding eigenmatrices $R_(i > 0)$ are called decaying modes @Znidaric2015. While the imaginary parts describe the possible oscillatory processes. Note that, due to the Hermiticity preserving of $cal(L)$, if $lambda_i$ is complex, $lambda_i^*$ must also be an eigenvalue of $cal(L)$ @Minganti2019 @Minganti2018 @Carollo2021. As a consequence, the eigenvalues are symmetrically distributed with respect to the real axis. For conjugate pairs, $lambda_(i , 1) = lambda_(i , 2)^*$, the corresponding eigenmodes can be constructed to be Hermitian by considering the combinations $(R_(i , 1) + R_(i , 2))$ and $i(R_(i , 1) - R_(i , 2))$, then their corresponding eigenvalues are real.


A generic initial state will overlap with all decaying modes of Lindblad dynamics, and thus, in particular, also with the slowest one $R_1$, which plays a fundamental role in the system dynamics @Znidaric2015. Then the Liouvillian gap, defined by $g =|op("Re")[lambda_1]|$, is also called the relaxation rate and thus is an important quantity determining the timescale of the final relaxation to the stationary state $tau_1 = 1/|op("Re")[lambda_1]|$ @Macieszczak2016a @Minganti2018. This means that the system dynamics at long times has the form $ rho(t) - rho_("ss") tilde.eq c_1 e^(lambda_1 t) R_1 ,$ and possesses the slowest decay rate $|op("Re")[lambda_1]|$. As such, for long times, the system will relax to $rho_("ss")$ with a purely exponential decay when $lambda_1$ is real.


For a quantum sME initial state $|"sME"⟩$, which has zero overlap with the slowest decaying mode (SMD) $R_1$, then we will get $c_1 = op("Tr")[L_1 (|"sME"⟩ ⟨"sME"|)] = 0$. Note that this optimal state $|"sME"⟩$ is prepared by applying a well devised unitary transformation to an initially pure quantum state of the system ~@Carollo2021. Therefore the sME state is normally a quantum superposition state, which is fundamentally different from classic ME. Besides, the relaxation process of our system contains the coherent evolution part, so that even the final steady state has quantum coherence. This can be illustrated by the state tomography of the sME initial state and the steady state, see @fig-s1-tomography. The non-zero value of non-diagonal elements indicates the quantum coherence here. Finally, for the sME initial state, the following dynamical behaviour cannot be captured by semi-classical approach. To show this, we compare the dynamics of the populations by using the rate equations (dashed lines) and the Lindblad master equation (solid lines) and the results are shown in @fig-s2-populations. Obviously, the dynamics for the sME initial state by using the rate equations (dashed lines) does not cause exponential acceleration. This proves that conventional rate equation approaches cannot capture the quantum Mpemba effect that is observed in our experiment.


// [figvision-cn] imgs/fig_s1.png
// 本图由四个三维柱状图子图组成，排列为两行两列，用于展示
// 单模纠缠（sME）初始态和最终稳态的密度矩阵层析结果。四
// 个子图共享相同的水平面坐标轴：两个水平轴均为量子态索引
// 标签，分别标记为 |0⟩、|1⟩、|2⟩ 和 |0⟩、|1⟩、|2⟩，构成
// 3×3 的矩阵网格；垂直轴表示密度矩阵元素的数值。每个子图
// 右侧均附有一个垂直色标，颜色从深蓝（负值或低值）经绿色
// 过渡到黄色和白色（高值）。 左上子图标题为“Real part of
// ρ₀”，即初始态密度矩阵的实部。垂直轴范围为 -0.2 至 0.6。
// 矩阵对角元素表现为高柱：|0⟩⟨0⟩ 位置的黄色柱最高，约达
// 0.64；|2⟩⟨2⟩ 位置的绿色柱高度约为 0.34；|1⟩⟨1⟩ 位置的
// 深绿色柱高度约为 0.14。非对角元素表现为浅蓝或深蓝色低
// 矮方块，其值接近 0 或略为负值（例如 |0⟩⟨2⟩ 和 |2⟩⟨0⟩
// 位置约为 -0.05 至 -0.16）。色标范围为 -0.1620 至
// 0.6400，刻度间隔不均匀。 右上子图标题为“Imaginary part
// of ρ₀”，即初始态密度矩阵的虚部。垂直轴范围为 -0.4 至
// 0.4。图中 |0⟩⟨1⟩ 位置有一显著的正向黄色柱，高度约 0.36；
// |1⟩⟨2⟩ 位置有绿色正柱，高度约 0.18；而 |1⟩⟨0⟩ 位置为深
// 蓝色负柱，高度约 -0.27；|2⟩⟨1⟩ 位置为深蓝色负柱，高度
// 约 -0.36。其余元素接近零。色标范围为 -0.366 至 0.366，
// 零点位于色标中部。 左下子图标题为“Real part of ρ_ss”，
// 即最终稳态密度矩阵的实部。垂直轴范围为 -0.2 至 0.4。对
// 角元素中，|0⟩⟨0⟩ 位置为黄色高柱，高度约 0.50；|2⟩⟨2⟩
// 位置为浅绿色柱，高度约 0.43；|1⟩⟨1⟩ 位置为深绿色柱，高
// 度约 0.16。非对角元素 |0⟩⟨2⟩ 和 |2⟩⟨0⟩ 位置为深蓝色负
// 值方块，约为 -0.05；其余非对角元素接近零。色标范围为
// -0.0500 至 0.5020。 右下子图标题为“Imaginary part of ρ
// _ss”，即最终稳态密度矩阵的虚部。垂直轴范围为 -0.2 至
// 0.2。图中 |0⟩⟨1⟩ 位置为黄色正柱，高度约 0.189；|1⟩⟨0⟩
// 位置为深蓝色负柱，高度约 -0.189；|1⟩⟨2⟩ 位置为绿色正柱，
// 高度约 0.095；|2⟩⟨1⟩ 位置为浅绿色负柱，高度约 -0.095。
// 其余元素接近零。色标范围为 -0.1890 至 0.1890。 整体趋
// 势表明：初始态 ρ₀ 的实部对角元素分布不均，虚部存在明显
// 的相干项（尤其是 |0⟩⟨1⟩ 和 |1⟩⟨2⟩ 及其共轭项）；经过演
// 化后，稳态 ρ_ss 的实部对角元素重新分布（|1⟩⟨1⟩ 布居增
// 加，|2⟩⟨2⟩ 布居显著增加），虚部相干项幅度减小但仍保留
// 一定相位关系（|0⟩⟨1⟩ 和 |1⟩⟨2⟩ 的虚部幅度约为初始态的
// 一半）。所有子图均使用三维柱状图表示密度矩阵元素，柱体
// 高度对应数值大小，颜色仅用于辅助表示正负与大小。
#figure(
  image("imgs/fig_s1.png", width: 100%),
  caption: [
    The tomography of the sME initial state $rho_0 =|"sME"⟩ ⟨"sME"|$ and the final stationary state $rho_("ss")$. The parameters are the same with @fig-setup-and-relaxation(f).
  ],
) <fig-s1-tomography>



// [figvision-cn] imgs/fig_s2.png
// 图中共有三个并排子图a、b、c，均为曲线图，纵轴为布居数
// Population，线性标度，范围0.0至1.0；横轴为无量纲时间Ω
// 1t，对数标度，范围约0.005至300。三个子图顶部标题分别为
// “a initial state |0⟩”、“b initial state |2⟩”、“c
// initial state |sME⟩”。子图内均有两条垂直虚线标出特征时
// 间：左侧蓝色垂直虚线标为τ2，位置约在Ω1t=3；右侧红色垂
// 直虚线标为τ1，位置约在Ω1t=100。子图a和b中的横向双箭头
// 标有“approach to ρss”，箭头从τ2指向τ1，表示从τ2到τ1区
// 间系统趋向稳态ρss的过程。 每个子图有三组数据点，用不同
// 颜色和标记区分，并配有图例（子图a左下角）：蓝色空心圆
// 表示ρ00，绿色空心三角表示ρ11，红色空心菱形表示ρ22。每
// 个数据点带有误差棒，为蒙特卡洛模拟产生。图中有两种线型：
// 虚线为速率方程结果，实线为Lindblad主方程结果。每个子图
// 的数据点和线型对应表示该初始态下三个能级布居数随Ω1t的
// 演化。 子图a（初始态|0⟩）：纵轴范围0.0至1.0。蓝色曲线ρ
// 00从1.0开始，在Ω1t较小时保持接近1，随后单调下降，经过τ
// 2后降速加快，在τ1附近下降至约0.5；黑色实线（Lindblad）
// 与虚线（速率方程）在早期几乎重合，在Ω1t约2之后实线略高
// 于虚线，并一直延续到后期。绿色曲线ρ11从约0开始，在τ2之
// 前平缓上升至约0.1，τ1附近快速上升至约0.2，之后趋于一个
// 平台，实线与虚线在整个区间基本一致。红色曲线ρ22从约0开
// 始，在τ1之前几乎为零，τ1附近迅速上升至约0.35，之后趋于
// 平台，实线在后期略高于虚线。整体趋势为系统在τ2到τ1之间
// 从初始态|0⟩向稳态ρss弛豫。 子图b（初始态|2⟩）：纵轴范
// 围0.0至1.0。红色曲线ρ22从1.0开始，在τ2之前保持接近1，τ
// 1之前仍在0.9以上，τ1附近快速下降至约0.4；实线与虚线在τ
// 2之前吻合良好，在τ1附近实线下降略早于虚线。蓝色曲线ρ00
// 从约0开始，在τ1之前基本为零，τ1附近迅速上升至约0.45，
// 之后呈缓慢上升趋势；实线在τ2之后明显高于虚线。绿色曲线
// ρ11从约0开始，在τ1之前保持为零，τ1之后上升至约0.15，实
// 线高于虚线。整体趋势为系统在τ1附近发生快速布居转移，从
// 初始态|2⟩向ρ00和ρ11弛豫。 子图c（初始态|sME⟩）：纵轴范
// 围0.0至1.0。蓝色曲线ρ00从约0.65开始，在τ2之前基本平坦，
// τ2之后略有下降，τ1之后在0.55至0.65之间波动；实线与虚线
// 在τ2之后出现偏差。绿色曲线ρ11从约0.1开始，在τ2之前基本
// 平坦，τ1附近上升至约0.15，之后略有下降；实线与虚线在τ1
// 之前基本一致。红色曲线ρ22从约0.25开始，在τ2之前平坦，τ
// 1之后快速上升至约0.3至0.35；实线与虚线在τ1附近有偏差。
// 整体趋势为初始态|sME⟩在τ2到τ1之间向稳态ρss缓慢演化，实
// 线与虚线在后期偏差较大，表明Lindblad主方程与速率方程在
// sME初始态下差异更显著。
#figure(
  image("imgs/fig_s2.png", width: 100%),
  caption: [
    The dynamics of the state populations for initial states $|0⟩$ (a), $|2⟩$ (b) and $|"sME"⟩$ (c) on a logarithmic timescale. Dashed lines: the rate equations, solid lines: the Lindblad master equation. The parameters are the same with @fig-setup-and-relaxation(d-f). The error bars are generated by using Monte Carlo simulation.
  ],
) <fig-s2-populations>



Whereas the sME initial state no longer excites the SDM, it generally relaxes with a faster decay rate $|op("Re")[lambda_2]|$. If $lambda_(1 , 2) in bb(R)$, the quantum sME initial state will generate an exponential speeding-up of the convergence to stationarity by a factor $delta lambda_(12) = lambda_1 - lambda_2 > 0$. However, it is impossible to have an exponential acceleration if the parameter of the system passes beyond the Liouvillian exceptional point (LEP). The reason is that $lambda_(1 , 2)$ becomes complex valued when $Omega_2/Omega_1 > "LEP"$ and hence $delta lambda_(12) = op("Re")[lambda_1 - lambda_2] = 0$. The key point is that if $lambda_1 = lambda_2^*$, then $R_1 = R_2^dagger$ is non-Herminan, namely $R_1 != R_1^dagger$ so that $c_1 = c_2^* != c_2$.


It also can be explained from long time evolution of $rho(t)$, where the two lowest decaying mode of the Liouvillian superoperator appear in conjugate paris, i.e., $lambda_1 = lambda_2^*$. The difference between $rho(t)$ and stationary state $rho_("ss")$ can be expressed as $ rho(t) - rho_("ss") & tilde.eq & c_1 e^(lambda_1 t) R_1 + c_1^* e^(lambda_1^* t) R_1^dagger\
 & = &|c_1|e^(op("Re")[lambda_1] t)(e^(i(omega_1 t + delta_1)) R_1 + e^(- i(omega_1 t + delta_1)) R_1^dagger)\
 & = &|c_1|e^(op("Re")[lambda_1] t)(cos(omega_1 t + delta_1) R'_1 + sin(omega_1 t + delta_1) R'_2)\
 & = & c_1 (t) R'_1 + c_2 (t) R'_2 ,$ where $omega_1 = op("Im")[lambda_1] , delta_1 = op("Arg")[c_1] , c_1 (t) =|c_1|e^(op("Re")[lambda_1] t) cos(omega t + delta_1) , c_2 (t) =|c_1|e^(op("Re")[lambda_1] t) sin(omega t + delta_1)$, and Hermitian eigenmatrices $R'_1 = (R_1 + R_1^dagger)$, $R'_2 = i(R_1 - R_1^dagger)$. Similar to the case of real value of $lambda_1$, the timescale of relaxation here is still determined by $|op("Re")[lambda_1]|$, but the dynamics which constitutes rotations will be determined by $R_1$ and $R_2$ simultaneously. Thus it can be interpreted as a phase transition in the relaxation dynamics @Teza2023a. Note that this singularity can not be detected in the steady state but rather in the relaxation dynamics. Considering $R'_1$ is Hermitian, we still can generate a pure initial state $|"sME"⟩$ that has zero overlap in $R'_1$, i.e., $c_1 (0) = op("Tr")[L'_1 (|"sME"⟩ ⟨"sME"|)] = 0 =|c_1|cos(delta_1)$, but another SDM $R'_2$, with the same decay rate $|op("Re")[lambda_1]|$, cannot be eliminated at the same time because $c_2 (0) =|c_1|sin(delta_1) != 0$. As a consequence, quantum sME will not exist when $lambda_1$ is complex; the LEP partitioned parameter space shows that the existence of the quantum sME is limited to the region in which $lambda_1$ is real (see @fig-s3-distance-overlaps).We also check that similar results are found using Bures distance @VanVu2021c @Garcia-Pintos2022 and the results are shown in @fig-s4-bures-distance.


// [figvision-cn] imgs/fig_s3.png
// 该图由五行九列共45个子图组成，整体分为五列，每列对应一
// 个特定的Ω₂/Ω₁取值，从左到右分别为0.04、0.1、0.16、0.18
// 和0.25。每个子图均为曲线图，横轴统一为Ω₁t，采用对数坐
// 标，显示范围约为0.005至500；纵轴根据行数不同而变化。图
// 中所有标注文字包括：左上角的图例“initial state: -○|0⟩,
// -△|2⟩, -◇|ME⟩”；每列顶部的参数值“Ω₂/Ω₁ = 0.04”、“0.1”、
// “0.16”、“0.18”和“0.25”；以及纵轴标签“D/(v_⊥/ω₁)”、“c₁(
// t)”和“c₂(t)”。 第一行子图（a）展示距离D/(v_⊥/ω₁)随Ω₁t
// 的变化。纵轴范围为0.0至1.0，刻度步长0.2。三条曲线分别
// 代表初始态：绿色曲线用左指向空心三角形（◁）标注，起始
// 于1.0；蓝色曲线用空心圆形（○）标注，起始于约0.65至0.8
// 之间（随Ω₂/Ω₁增大而升高）；红色曲线用空心菱形（◇）标注，
// 起始于约0.8至1.0之间（随Ω₂/Ω₁增大而升高）。所有曲线在Ω
// ₁t较小时保持水平，随后在特定Ω₁t处急剧下降至接近0。随着
// Ω₂/Ω₁从0.04增大至0.25，下降发生的位置向更大的Ω₁t方向移
// 动。图中还使用红色实心圆（●）标注了“ME”状态的特定时间
// 点。 第二行子图（b）展示系数c₁(t)随Ω₁t的变化。纵轴范围
// 约为-0.2至0.8（第一列）或-0.2至0.4（第五列），刻度步长
// 0.2。绿色曲线用空心三角形标注，起始于约0.8（第一列）或
// 0.4（第五列），保持水平后下降至0；蓝色曲线用空心圆形标
// 注，起始于约0.6（第一列）或0.2（第五列），保持水平或轻
// 微变化后下降至0；红色曲线用空心菱形标注，在Ω₂/Ω₁=0.04
// 和0.1时起始于约0.8，在0.16时起始于约0.2之后急剧下降，
// 在0.18和0.25时起始于约0，保持水平后出现负向偏移再趋于0。
// 第三行子图（c）展示系数c₂(t)随Ω₁t的变化。纵轴范围约为
// -0.3至0.5（第一列）或-0.3至0.3（第五列），刻度步长0.3。
// 绿色曲线用空心三角形标注，在Ω₂/Ω₁=0.04和0.1时起始于约0，
// 在0.16和0.25时起始于约0.3，之后趋于0；蓝色曲线用空心圆
// 形标注，起始于约0，保持水平后在特定时间点出现负向偏移
// 再趋于0；红色曲线用空心菱形标注，所有情况下均起始于约
// 0.5，保持水平后急剧下降至0附近，在Ω₂/Ω₁=0.18和0.25时下
// 降后出现负向偏移再趋于0。 所有子图均包含误差棒（error
// bars），由空心符号表示。图中趋势表明，不同初始态对应的
// 物理量随Ω₁t演化，在特定时间点发生突变，且突变位置受参
// 数Ω₂/Ω₁调控。红色曲线标记的“ME”状态在c₁(t)和c₂(t)子图
// 中表现为在特定时间点趋于0或出现显著偏移。
#figure(
  image("imgs/fig_s3.png", width: 100%),
  caption: [
    (a) Distance for $Omega_2/Omega_1 = 0.04, 0.1, 0.16, 0.18, 0.25$, with initial state $|0⟩$ (green), $|2⟩$ (blue) and $|"ME"⟩$ (red), respectively. (b-c) The corresponding coefficients $c_1 (t)$ (b) and $c_2 (t)$. (c) The sME that exits exponential acceleration is observed for $Omega_2/Omega_1 < "LEP"$. Considering that $c_(1 , 2)(t) in bb(C)$ when $Omega_2/Omega_1 < "LEP"$ and $c_(1 , 2)(t) in bb(R)$ when $Omega_2/Omega_1 > "LEP"$, for $Omega_2/Omega_1 = 0.04, 0.1, 0.16 (< "LEP")$ what we plot is $|c_(1 , 2)(t)|$ and for $Omega_2/Omega_1 = 0.18, 0.25 (> "LEP")$ what we plot is $c_(1 , 2)(t)$. Here, the open symbols and the filled symbols in the $x$ axis are time scales $tau_2$ and $tau_1$, respectively. The error bars are generated by using Monte Carlo simulation.
  ],
) <fig-s3-distance-overlaps>



// [figvision-cn] imgs/fig_s4.png
// 这张图片由三个并排的子图组成，分别标记为 a、b 和 c。这
// 是一张包含主图和嵌套插图的曲线图，用于展示不同参数下距
// 离随时间的变化趋势。图中主要包含三组数据，分别对应不同
// 的初始状态：蓝色圆形（标记为 \(|0\rangle\)）、绿色三角
// 形（标记为 \(|2\rangle\)）和红色菱形（标记为 \(|sME\
// rangle\)）。 整体布局：上方有一个图例框，包含了三种初
// 始状态的符号说明。三个子图共用相同的纵轴标签 \(\
// mathcal{D}(\rho, \rho_{\text{ss}})\)（表示某种距离测度），
// 纵轴为对数刻度，范围从 \(10^{-3}\) 到 \(1\)。横轴标签
// 为 \(\Omega_1 t\)（无量纲时间），刻度范围从 0 到 25 左
// 右。 子图 a：标题为“\(\Omega_2/\Omega_1 = 0.04\) (<LEP
// )”。主图中，蓝色圆形曲线和绿色三角形曲线在初始阶段迅速
// 下降，随后趋于平缓，稳定在 \(10^{-1}\) 至 \(1\) 之间的
// 某个值。红色菱形曲线则持续下降，最后降至 \(10^{-2}\)
// 附近。该图左下角有一个嵌套插图，纵轴为 \(1.0\) 到 \(
// 0.2\) 的线性刻度，横轴为 \(0\) 到 \(5\)。插图显示蓝色
// 和绿色曲线快速下降，红色曲线下降相对较慢。 子图 b：标
// 题为“\(0.16\) (close LEP)”。主图中，蓝色和绿色曲线在 \
// (10^{-1}\) 附近趋于平缓，红色曲线下降更陡，最终到达 \(
// 10^{-2}\) 以下。曲线上的数据点带有误差棒。左下角插图的
// 结构与子图 a 相同，显示蓝色和绿色曲线在 \(t=1\) 附近快
// 速下降，红色曲线下降稍缓。 子图 c：标题为“\(0.25\) (>
// LEP)”。主图中，三条曲线整体呈现下降趋势。蓝色曲线和绿
// 色曲线在下降过程中出现波动，红色曲线下降最为显著，在 \
// (t=15\) 左右降至 \(10^{-2}\) 以下。该图的数据点误差棒
// 比前两图更为明显。左下角插图同样显示，蓝色和绿色曲线在
// \(t=1\) 附近快速降至 0.2 以下，红色曲线下降较慢。 总结
// 趋势：随着参数 \(\Omega_2/\Omega_1\) 从 0.04 增加到
// 0.25，所有初始状态对应的距离测度 \(\mathcal{D}\) 整体
// 上呈现下降趋势，且红色菱形（\(|sME\rangle\) 态）的下降
// 幅度始终大于蓝色圆形和绿色三角形状态。
#figure(
  image("imgs/fig_s4.png", width: 100%),
  caption: [
    Beres distance for $Omega_2/Omega_1 = 0.04$ (a), 0.16 (b), 0.25(c), with initial state $|0⟩$ (green), $|2⟩$ (blue) and $|"ME"⟩$ (red), respectively. The parameters are the same with @fig-strong-to-weak(a) and the error bars are generated by using Monte Carlo simulation.
  ],
) <fig-s4-bures-distance>



LEP can also imply a discontinuity in the final direction of the approach to the stationary state and generates the dynamical phase transition @Orgad2024 @Teza2023a as a function of the system parameter in the relaxation dynamics (see @fig-strong-to-weak(d)). The singularity of this kind of transition, which is induced by the discontinuity of the final direction of the relaxation to stationary state, is intrinsically hard to detect in nature @Teza2023a. Here we show how this kind of transition can be observed in an experimentally feasible quantum system by measuring the overlap $c_1$ . Because the system dynamics at long times has the form $rho(t) - rho_("ss") tilde.eq c_1 e^(lambda_1 t) R_1$, the final direction will change from $R_1$ to $R_1 + R_2$ when the parameter passes through LEP. Obviously, this direction change at LEP will lead to a singularity of $c_1 = op("Tr")[L_1 rho_("in")]$. For a quantum sME initial state, however, at LEP we have $lambda_1 (R_1) = lambda_2 (R_2)$ so that $c_1 = c_2 = 0$. It corresponds to _super-strong_ ME @Klich2019 and the timescale of the relaxation is given by the $tau_3 = 1/|op("Re")[lambda_3]|$. This means that at LEP the sME initial state implies an exponentially faster convergence to the steady state by a factor $op("Re")[lambda_1 - lambda_3]$, and the final stage of the the relaxation is determined by $R_3$. Therefore, LEP implies a jump in the final direction of the approach to stationary state. The final dynamical direction change at LEP implies LEP could be linked to anomalous phenomena arising in the relaxation process (see Supplementary Table 1).





#figure(
  align(
    center,
    table(
      columns: 4,
      align: (center, center, center, center),
      table.header([], [$<$], [], [$>$]),
      table.hline(),
      [Dynamics of $rho_("in")$ dominate by], [$lambda_1 (in bb(R)) , R_1$], [$lambda_1 (R_1) = lambda_2 (R_2) ,$], [$lambda_1 = lambda_2^* , R'_1 , R'_2$],
      [Dynamics of $|"sME"⟩$ dominate by], [$lambda_2 (in bb(R)) , R'_2$], [$lambda_3 (R_3)$], [$lambda_2 = lambda_1^* , R'_2$],
      [], [$op("Re")[lambda_1 - lambda_2]$], [$op("Re")[lambda_1 - lambda_3]$], [0],
      [], [sME], [_Super_ sME], [No sME],
    ),
  ),
  caption: [Link between anomalous phenomena in the relaxation dynamics and LEP],
  kind: table,
) <tab-phenomena>



== Supplementary Note 2. Effective decay rate
<supplementary-note-2.-effective-decay-rate>


The effective decay channel $kappa_(1 , 2)$ from the long life excited state to the ground state in our experiments is created by coupling this long life excited state to another short life excited state, we call it $|p⟩$, which can quickly decay back to ground state by spontaneous emission process. To describe the full dynamics of this three-level system, we take the decay channel of $|1⟩ arrow.r|0⟩$ for example, the Lindblad master here is $ frac(d rho, d t) = cal(L) rho(t) := - i[H , rho] + (2 J rho J^dagger - (J^dagger J , rho)) ,$ where $H = Omega_p/2 (|1⟩ ⟨p|+|p⟩ ⟨1|)$, $J = sqrt(gamma)|0⟩ ⟨p|$ is the jump operator describing the spontaneous emission process from $|p⟩$ to $|0⟩$ and $gamma$ is the emission rate.


In order to investigate the physical connotations of the effective decay channel from $|1⟩$ to $|0⟩$, we reduce the master equation to the non-zero matrix elements of $rho$, $ dot(rho)_11 = & i Omega/2 (rho_(1 p) - rho_(p 1)) ,\
dot(rho)_("pp") = & - gamma rho_("pp") - i Omega/2 (rho_(1 p) - rho_(p 1)) ,\
dot(rho)_(1 p) = & - gamma/2 rho_(1 p) + i Omega/2 (rho_11 - rho_("pp")) ,\
dot(rho)_00 = & gamma rho_("pp") .$<eq-rate-equations> The coherent terms couple the populations $rho_11$ and $rho_("pp")$ to the coherence $rho_(1 p)$ and $rho_(p 1)$, but have no contribution to the dynamics of coherence $rho_(1 p) + rho_(p 1)$, because $dot(rho)_(1 p) + dot(rho)_(p 1) = - gamma/2 (rho_(1 p) + rho_(p 1))$, which is only exponentially damped dynamics with decay rate $gamma/2$. Meanwhile, as shown in Supplementary @eq-rate-equations(a), the damping term, proportional to $gamma$, does not affect $rho_11$. It contributes to the decay of $rho_("pp")$ and to the corresponding increase of $rho_00$, and the system eventually relaxes to state $|0⟩$. Considering there are only three independent variables in Supplementary @eq-rate-equations: $rho_11 , rho_("pp")$ and $- i(rho_(1 p) - rho_(p 1))$, we set $x = (rho_11 , rho_("pp") , - i(rho_(1 p) - rho_(p 1)))^T$ and find the dynamics $dot(x) = A x$, where $ A = mat(delim: "(", 0, 0, - Omega_p/2; 0, - gamma, Omega_p/2; Omega_p/2, - Omega_p/2, - gamma/2) .$<eq-matrix-a>


Eigenvalues of the $3 times 3$ matrix A in Supplementary @eq-matrix-a are $lambda_(1 , 2) = - (gamma minus.plus sqrt(gamma^2 - 4 Omega_p^2))/2$ and $lambda_3 = - gamma/2$. When the coupling driven is strong ($Omega_p > gamma/2$), the evolution of $x$ is described by damped oscillation with decay rates $gamma/2$. When the coupling is weak $Omega_p < gamma/2$, all the eigenvalues are real and the dynamics exhibits an irreversible damping with decay rate $- op("Re")[lambda_1] = (gamma - sqrt(gamma^2 - 4 Omega_p^2))/2$. Note that, here our aim is to create an purely exponential decay channel for state $|1⟩$, so we have to set the Rabi frequency $Omega_p < gamma/2$. Specially, in the limit of strong decay or weak coupling, $gamma gt.double 2 Omega$, the effective decay rate of $x$ (of couse also $rho_11$) is determined by $ (gamma - sqrt(gamma^2 - 4 Omega_p^2))/2 approx Omega_p^2/gamma .$ It leads to an effective decay from the state $|1⟩$ to state $|0⟩$, with the effective decay rate $ kappa_1 approx Omega_p^2/gamma .$ The above analysis shows that, this dissipative three-level model can be used to engineer decay processes between state $|1⟩$ and $|0⟩$, like the Percell effect in the spin-spring system with relaxation processes @Haroche2010, just by tuning the Rabi frequency $Omega_p$. Actually, the same result can be found in @Reiter2012a @Zhang2022 by employing perturbation theory and adiabatic elimination of states $|p⟩$ for a weakly driven between $|1⟩ arrow.l.r|p⟩$.


Here, we explain how to control and stabilize these decay rates, and further discuss what is the potential impact of this instability on the experimental results. Experimentally, the magnetic field of our system is created by using permanent magnets and the left-handed circular polarization of the 854 nm is maintained by using a Glan-Taylor prism and a quarter waveplate, hence we consider these parameters are stable during our experiments. Then we set the frequency of the 854 nm to be resonant with line $P_(3/2)(m_j = - 3/2) arrow.l.r D_(5/2)(m_j = - 5/2)$ so that other lines are off-resonant and the decay rate can be suppressed to some extent because of the different Lande g factors for $D_(5/2)$ state and $P_(3/2)$ state. Finally, we control the decay rates of the three dipole transition lines to by setting the polarization of the 854 nm. For the line $P 3/2 (m_j = - 3/2) arrow.l.r D 5/2 (m_j = - 5/2)$, the beam of 854 nm should be right-handed circularly polarized, while the 854 nm laser beam for lines $P_(3/2)(m_j = 1/2) arrow.l.r D_(5/2)(m_j = 3/2)$ and $P_(3/2)(m_j = 3/2) arrow.l.r D_(5/2)(m_j = 3/2)$ are left-handed circularly polarized and linearly polarized, respectively. Therefore, we make the 854 nm light polarization to be right-handed circularly polarized, and the wavevector of the 854 nm to be almost perfectly along with the magnetic field after careful alignment. In this case, we suppressed $kappa_2$ significantly. The example measurements for $kappa_1$ and $kappa_2$ are shown in @fig-s5-decay-rates (a) and @fig-s5-decay-rates (b) below.


// [figvision-cn] imgs/fig_s5.png
// 图由左右两个并排的子图组成，分别标记为(a)和(b)，均为散
// 点图叠加拟合曲线。 子图(a)：横轴为“Time (us)”，范围0至
// 15，主刻度间隔2；纵轴为“population of D state”，范围
// 0.0至1.0，主刻度间隔0.2。图中有约50个蓝色实心圆点数据
// 点，分布在时间0至15微秒之间。红色实线为指数衰减拟合曲
// 线，从时间0、纵轴约1.0处开始，单调下降，至时间15微秒时
// 趋近于0.0。数据点围绕拟合线有一定散布，整体趋势与拟合
// 线一致，显示D态布居数随时间快速衰减。 子图(b)：横轴为“
// Time(us)”，范围0至3000，主刻度间隔500；纵轴为“
// population of D state”，范围0.65至0.95，主刻度间隔0.05。
// 图中有约50个蓝色实心圆点，分布在时间0至3000微秒之间，
// 纵轴值大致在0.62至0.89之间波动。红色实线为线性拟合，从
// 时间0、纵轴约0.86处开始，缓慢下降至时间3000微秒、纵轴
// 约0.68处。数据点散布较大，但整体呈现缓慢下降趋势，表明
// D态布居数在长时间尺度上衰减极慢。
#figure(
  image("imgs/fig_s5.png", width: 100%),
  caption: [
    Measurement results for decay rate of states $D_(5/2)(m_j = - 5/2)$ and $D_(5/2)(m_j = 3/2)$ line. (a) Decay rate $kappa_1$ for state $D_(5/2)(m j = - 5/2)$ with 854 nm laser beam right-handed circularly polarized and $kappa_1$ is fitted to be $2 pi times 39.6$ kHZ (b) $kappa_2$ mesured with same 854 nm laser power and frequency used in (a), $kappa_2$ is only $2 pi times times 13.4$ Hz.
  ],
) <fig-s5-decay-rates>

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", title: none, full: true)