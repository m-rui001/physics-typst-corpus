#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.41cm), columns: 2)
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

#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#place(top, float: true, scope: "parent", clearance: 1.2em)[
#align(center)[
  #text(12pt, weight: "bold", [A universal qudit quantum processor with trapped ions])   #v(1.2em)
  #text(10.5pt)[Martin Ringbauer#super[1], Michael Meth#super[1], Lukas Postler#super[1], Roman Stricker#super[1], Rainer Blatt#super[1], Philipp Schindler#super[1], Thomas Monz#super[1]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Institut für Experimentalphysik, Universität Innsbruck, Technikerstrasse 25, 6020 Innsbruck, Austria] \
  #text(9pt)[#super[2] Institut für Quantenoptik und Quanteninformation, Osterreichische Akademie der Wissenschaften, Otto-Hittmair-Platz 1, 6020 Innsbruck, Austria] \
  #text(9pt)[#super[3] Alpine Quantum Technologies GmbH, 6020 Innsbruck, Austria] \
]
#v(1.2em)



Today's quantum computers operate with a binary encoding that is the quantum analog of classical bits. Yet, the underlying quantum hardware consists of information carriers that are not necessarily binary, but typically exhibit a rich multilevel structure, which is artificially restricted to two dimensions. A wide range of applications from quantum chemistry to quantum simulation, on the other hand, would benefit from access to higher-dimensional Hilbert spaces, which conventional quantum computers can only emulate. Here we demonstrate a universal qudit quantum processor using trapped ions with a local Hilbert space dimension of up to 7. With a performance similar to qubit quantum processors, this approach enables native simulation of high-dimensional quantum systems, as well as more efficient implementation of qubit-based algorithms.
]





Quantum information processing (QIP) successfully builds on the paradigm of binary information processing that has fueled classical computers for decades. Quantum bits, just like their classical counterparts, are two-level systems with basis states labelled $| 0 chevron.r$ and $| 1 chevron.r$. The underlying physical systems, however, almost always consist of higher-dimensional Hilbert spaces that need to be artificially restricted to fit our binary paradigm. This multi-level structure presents a powerful resource for QIP. Using auxiliary levels as a cache memory for quantum information has enabled the implementation of highly complex quantum algorithms~@Martinez2016 and dissipative processes~@Schindler2013, as well as improved decomposition of multi-qubit gates~@Lanyon2008. Yet, experimental realizations in various platforms are limited to proof-of-concept demonstrations~@Senko2015 @Ahn2000 @Godfrin2017 @Anderson2015 @Morvan2020 @Hu2018a. Featuring a much richer coherence~@Ringbauer2017 and entanglement structure~@Kraft2018 than their binary counterpart, combined with higher noise resilience~@Cozzolino2019 makes #emph[qudits] (quantum decimal digits) a prime candidate for the next generation of quantum devices.


Here we demonstrate a universal qudit trapped-ion quantum processor (TIQP) using of the native multilevel structure of trapped chains of $""^40$Ca$""^(+)$ ions. Building on the native interactions in the trapped-ion platform, we implement a universal gate set for qudit QIP at a performance approaching that of comparable qubit systems. We further introduce a scalable detection scheme that allows for full qudit readout and develop composite pulse techniques for cross-talk compensation.


Our quantum processor uses a string of $""^40$Ca$""^(+)$ ions in a linear Paul trap~@Schindler2013. Quantum information is encoded in the $S_(1 / 2)$ electronic ground state and the metastable $D_(5 / 2)$ excited state which has a lifetime of $tau_1 tilde 1.1 med s$, see Fig.~#ref(<fig.levelscheme>, supplement: none). Two sets of permanent magnets generate a magnetic field on the order of $4 med G$, which splits the ground state into two Zeeman sublevels ($m = plus.minus 1 / 2$) and the excited state into six Zeeman sublevels ($m = plus.minus 5 / 2 , plus.minus 3 / 2 , plus.minus 1 / 2 )$, with a splitting of several MHz. This gives rise to 10 allowed transitions due to the selection rules $Delta m = 0 , plus.minus 1 , plus.minus 2$, with the coupling strength controlled by the laser polarization and the orientation of the magnetic field. These transitions differ in their sensitivity to magnetic field fluctuations by up to a factor of 5, such that optical qubits are typically encoded in the least sensitive states $| 0 chevron.r = S_(1 / 2 , - 1 / 2)$, $| 0 chevron.r = D_(5 / 2 , - 1 / 2)$. However, with magnetic shielding, spin coherence times on the order of $100 med "ms"$, which is at least 3 orders of magnitude larger than typical gate times, can be achieved for all transitions. Each $""^40$Ca$""^(+)$ ion therefore natively supports a #emph[qudit] with 8 levels, featuring a highly connected Hilbert space, see Fig.~#ref(<fig.levelscheme>, supplement: none).


// [figvision-cn] imgs/FigTransitions.png
// 该图为钙离子（Ca+）能级结构示意图，展示量子信息编码所
// 用的能级及其跃迁关系。图中包含多个水平黑线表示的原子能
// 级，垂直或斜向箭头表示激光诱导的跃迁过程，并标注了波长、
// 量子态符号及磁量子数。 左侧部分为实际原子能级结构： 最
// 下方为基态 4²S₁/₂，用粗黑横线表示。 其上方依次是激发态
// 3²D₃/₂、3²D₅/₂、4²P₁/₂ 和 4²P₃/₂，均以较细黑横线表示，
// 按能量从低到高排列。 各能级间有彩色箭头连接，表示不同
// 波长的激光驱动跃迁： 蓝色双向箭头连接 4²S₁/₂ 与 4²P₁/₂，
// 标注“397nm”，表示冷却/探测跃迁。 红色双向箭头连接 4²P₁
// /₂ 与 3²D₃/₂，标注“866nm”，表示再泵浦跃迁。 品红色单向
// 箭头从 4²P₃/₂ 指向 3²D₅/₂，标注“854nm”。 深红色双向箭
// 头连接 3²D₃/₂ 与 3²D₅/₂，标注“729nm”，这是量子比特操作
// 的关键跃迁。 右侧部分为量子计算中使用的逻辑能级映射示
// 意图： 底部两个能级标记为 |0⟩ 和 |1⟩，分别对应物理态 3
// ²D₃/₂, m = +1/2 和 3²D₅/₂, m = -1/2（注：根据图示虚线
// 连接，|0⟩ 实际对应 3²D₃/₂, m=+1/2；|1⟩ 对应 3²D₅/₂, m=
// -1/2）。 上方四个能级标记为 |2⟩ 至 |7⟩，分别对应 3²D₅/
// ₂ 的不同磁子能级： |2⟩: m = +1/2 |3⟩: m = +3/2 |4⟩: m
// = -3/2 |5⟩: m = +5/2 |6⟩: m = -5/2 |7⟩: m = +5/2 （注
// 意：|5⟩ 和 |7⟩ 均标为 +5/2，可能为笔误或特殊约定，但图
// 中明确分开列出） 所有 |0⟩ 到 |7⟩ 能级通过灰色虚线与左
// 侧真实能级相连，表明它们是同一物理系统的不同标记方式。
// 在右侧区域，存在多条浅红色单向箭头，从 |0⟩ 出发指向 |1
// ⟩、|2⟩、|3⟩、|4⟩、|5⟩、|6⟩、|7⟩，以及从 |1⟩ 指向 |2⟩、
// |3⟩、|4⟩、|5⟩、|6⟩、|7⟩，这些箭头未标注波长，暗示可通
// 过单束 729nm 激光实现任意 S-D 能级间的跃迁（即任意两个
// D 态之间），用于多能级量子门操作。 整体趋势与结论： 该
// 图说明钙离子量子系统中，量子信息被编码在 3²D₃/₂ 和 3²D
// ₅/₂ 的两个特定磁子能级上（即 |0⟩ 和 |1⟩），而整个 D 态
// 流形（共六个磁子能级）均可通过单一窄带 729nm 激光进行
// 操控。 左侧显示完整的原子能级结构和所需的多波长激光系
// 统（397nm、866nm、854nm、729nm）以维持离子稳定并执行量
// 子操作。 右侧强调量子计算视角下的简化模型：将复杂原子
// 结构抽象为八个离散量子态（|0⟩–|7⟩），并通过虚线关联回
// 真实物理态，突出 729nm 激光对全部 D 态子能级的普适可访
// 问性，支持高维量子态制备与门操作。 无比例尺、无坐标轴、
// 无图例框，所有文字均为直接标注于能级或箭头旁。颜色编码
// 具有物理意义：蓝色代表主冷却循环，红色代表再泵浦，品红
// 色代表辅助跃迁，深红色代表量子比特操作跃迁，浅红色代表
// 扩展的多能级操控路径。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure(image("imgs/FigTransitions.png", width: 100%),
  caption: [
    #strong[Level scheme of the $""^40$Ca$""^(+)$ ion.] Quantum information is encoded in the $S_(1 / 2)$ and $D_(5 / 2)$ states, where each transition between S and D is accessible using a single narrowband laser at 729nm.
  ]
)
<fig.levelscheme>



Ions are initialized close to the electronic and motional ground state by optical pumping and a combination of Doppler cooling, polarization-gradient cooling~@Joshi2020, and resolved sideband cooling~@Schindler2013. The native operations available in the TIQP are equatorial rotations on any S-D transition:


$ "R"^(i , j) ( theta , phi.alt ) = exp ( - i theta sigma_phi.alt^(i , j) / 2 ) , $<eq:localOps>


where $theta$ denotes the rotation angle, $sigma_phi.alt^(i , j) = ( cos ( phi.alt ) sigma_(upright(x))^(i , j) plus.minus sin ( phi.alt ) sigma_(upright(y))^(i , j) )$ for Pauli matrices $sigma_(upright(x)) , sigma_(upright(y)) , sigma_(upright(z))$, and $i , j$ indicate the addressed transition according to Fig.~#ref(<fig.levelscheme>, supplement: none). Note, that the phase rotation for $phi.alt$ in $sigma_phi.alt^(i , j)$ is positive (negative) when $| i chevron.r$ ($| j chevron.r$) is in the S-manifold (i.e.~lower energy). The rotations of Eq.~#ref(<eq:localOps>, supplement: none) enable arbitrary $upright("SU") ( 2 )$ operations and are thus universal for qubit quantum computing~@Barenco1995 when combined with a two-qubit entangling operation such as the Mølmer-Sørensen gate~@Molmer1999.


$ "MS"^(i , j) ( theta , phi.alt ) = exp (- frac(i theta, 4) (sigma_phi.alt^(i , j) ⊗ bb(1) + bb(1) ⊗ sigma_phi.alt^(i , j))^2) . $<eq:entOps>


This interaction is achieved by coupling the internal degrees of freedom of the ions to the common motion in the trap using a bichromatic light field. Using multiple focused laser-beams, entangling-gate operations can also be performed on arbitrary subsets of ions in the string, see Supplementary Material (SM) for details. All operations can be performed with error rates below $1 "%"$ and at least 3 orders of magnitude faster than the coherence time of the system~@Bermudez2017. Finally, the state of each ion is read out by electron shelving using the short-lived $S_(1 / 2) arrow.l.r P_(1 / 2)$ transition and detecting fluorescence on a CCD camera.


We now demonstrate how to extend the above platform to qudits up to dimension $7$ (one level remains unoccupied for readout). As for qubits, this requires arbitrary single qudit gates, supplemented with one two-qudit entangling gate~@Brennen2006. For simplicity, we will focus primarily on $d = 3$ (qutrits) or $d = 5$ (ququints) and outline generalizations to other dimensions.


The set of local operations on a qudit is described by the group $upright("SU") ( d )$. In the case of a qutrit, the Lie algebra of $upright("SU") ( 3 )$ is spanned by the Gell-Mann matrices~@Gell-Mann1962, which are a natural generalization of the Pauli matrices from $upright("SU") ( 2 )$ to $upright("SU") ( 3 )$, with further generalizations towards $upright("SU") ( d )$. The Gell-Mann matrices are a set of traceless, Hermitian matrices, satisfying $"Tr" [ lambda_i lambda_j ] = 2 delta_(i j)$, where $delta_(i j)$ is the Kronecker delta:


$ lambda_1 & = mat(delim: "(", 0, 1, 0; 1, 0, 0; 0, 0, 0) , lambda_2 = mat(delim: "(", 0, - i, 0; i, 0, 0; 0, 0, 0) , lambda_3 = mat(delim: "(", 1, 0, 0; 0, - 1, 0; 0, 0, 0) ,\
lambda_4 & = mat(delim: "(", 0, 0, 1; 0, 0, 0; 1, 0, 0) , lambda_5 = mat(delim: "(", 0, 0, - i; 0, 0, 0; i, 0, 0) ,\
lambda_6 & = mat(delim: "(", 0, 0, 0; 0, 0, 1; 0, 1, 0) , lambda_7 = mat(delim: "(", 0, 0, 0; 0, 0, - i; 0, i, 0) , lambda_8 = 1 / sqrt(3) mat(delim: "(", 1, 0, 0; 0, 1, 0; 0, 0, - 2) . $<eq:QutritGellMann>


Notably, one can identify three independent $upright("SU") ( 2 )$ sub-algebras: $( lambda_1 , lambda_2 , lambda_3 )$, $( lambda_4 , lambda_5 , ( lambda_3 + sqrt(3) lambda_8 ) / 2 )$, $( lambda_1 , lambda_2 , ( - lambda_3 + sqrt(3) lambda_8 ) / 2 )$. This reflects the physical implementation in the trapped-ion platform via two-level couplings and makes the Gell-Mann operations a natural starting point for a qudit quantum processor.


Beyond basis operations, an important class of single-qudit gates is the Clifford group, as used in quantum error correction~@Gottesman1998. Following Ref.~@Clark2006, we introduce generalized Pauli Z and X operations:


$ Z_d & = omega_d^j | j chevron.r chevron.l j |\
X_d & = | j + 1 upright(" (mod ") d ) chevron.r chevron.l j | . $<eq:QutritPauliZ>


with $omega_d = e^(frac(2 pi i, d))$ and ${ | j chevron.r }_(j = 0)^(d - 1)$ denoting the computational basis in dimension $d$. These operations generate the $d$-dimensional analogue of the Pauli group, from which one constructs the $d$-dimensional Clifford group, with generators


$ H_d & = 1 / sqrt(d) sum_(j , k) omega_d^(j k) | k chevron.r chevron.l j |\
S_d & = sum_j omega_d^(j ( j + 1 ) / 2) | j chevron.r chevron.l j | . $<eq:QutritClifford>


Achieving universal single qudit operations requires not only Clifford gates, but also one additional non-Clifford gate. A popular choice for such a gate is the "$pi / 8$" or "T" gate~@Gottesman1998, which for qutrits is given by~@Howard2012


$ T_3 = mat(delim: "(", 1, 0, 0; 0, e^(frac(2 pi i, 9)), 0; 0, 0, e^(- frac(2 pi i, 9)) .) $<eq:QutritT>


In our TIQP any single-qudit operation can be constructed from at most $cal(O) ( d^2 )$ two-level rotations of Eq.~#ref(<eq:localOps>, supplement: none), via a decomposition into #emph[Givens rotations]~@Brennen2006, see SM for details. A notable challenge in qudit as compared to qubit QIP is that the elementary two-level operations lose their "global phase" gauge freedom. For example, a qubit Z rotation by an angle $theta$ can be understood as a phase shift $theta$ applied to $| 1 chevron.r$, or equivalently as phase shifts $plus.minus theta / 2$ applied to $| 0 chevron.r$ and $| 1 chevron.r$, respectively. In the qudit case, this equivalence breaks down, because any phase shift is measured relative to the spectator level. In the SM we discuss how to overcome this technical challenge when decomposing qudit gates.


Experimentally, we demonstrate universal single-qutrit control in a multi-ion crystal by implementing the fundamental Gell-Mann rotations of Eq.~#ref(<eq:QutritGellMann>, supplement: none), as well as the Clifford+T gate set of Eqs.~#ref(<eq:QutritPauliZ>)-#ref(<eq:QutritT>). Process tomography results for each of these operations are shown in the SM. In order to benchmark the performance of our single qudit operations in a way that is not limited by state-preparation-and-measurement (SPAM) errors, we perform randomized benchmarking of the qutrit and ququint Clifford operations~@Magesan2012, see @fig:RB. For qutrits and ququints we obtain error rates per Clifford operation of $2 ( 2 ) dot.op 10^(- 3)$ and $1.0 ( 2 ) dot.op 10^(- 2)$, respectively. These numbers compare well against the thresholds for quantum error correction, which for qubits are as high as $tilde 1 "%"$~@Fowler2012 and are expected to improve further with qudit dimension~@Campbell2014.


// [figvision-cn] imgs/FigRB_comb.png
// 该图为一幅二维散点拟合曲线图，展示了单量子多能级系统（
// qudit）随机基准测试中存活概率随克利福德门序列长度的变
// 化关系。 横坐标轴名称为“Number of Clifford gates”（克
// 利福德门数量），范围从0到100，主刻度间隔为20，单位为无
// 量纲的计数值。纵坐标轴名称为“Survival probability”（存
// 活概率），范围从0.0到1.0，主刻度间隔为0.2，单位为无量
// 纲的概率值。 图中包含两组实验数据系列，分别对应三能级
// 系统（qutrit）和五能级系统（ququint）。每组数据均包含
// 大量离散的数据点和一条拟合曲线。 第一组数据位于图表上
// 方，标记为“qutrit”。该组数据由浅蓝色的小圆点组成，代表
// 原始测量数据，这些点分布在横坐标0至96的范围内，纵坐标
// 数值在0.75至1.0之间波动。在这些散点之上，叠加了一条较
// 粗的深红色实心圆点连线，代表平均后的数据趋势。同时，有
// 一条浅蓝色的实线穿过这些数据点，表示指数衰减拟合曲线。
// 该曲线起始于纵坐标约0.98处，随着横坐标增加缓慢下降，在
// 横坐标100处降至约0.78。在图表右上角区域，有黑色文字标
// 注“qutrit”。 第二组数据位于图表下方，标记为“ququint”。
// 该组数据由橙色的小圆点组成，代表原始测量数据，分布范围
// 集中在横坐标0至52之间，纵坐标数值在0.4至1.0之间波动。
// 同样，叠加了一条较粗的深红色实心圆点连线表示平均趋势。
// 一条橙色的实线穿过数据点，表示指数衰减拟合曲线。该曲线
// 起始于纵坐标约0.98处，下降速度明显快于上方的蓝色曲线，
// 在横坐标50左右时已降至约0.6。在图表右下方区域，有黑色
// 文字标注“ququint”。 此外，两条拟合曲线的周围各有一个半
// 透明的同色带状区域（蓝色对应qutrit，橙色对应ququint），
// 代表拟合结果的不确定度或置信区间。整体趋势表明，随着克
// 利福德门数量的增加，两种系统的存活概率均呈指数衰减，且
// 五能级系统（ququint）的衰减速率显著高于三能级系统（
// qutrit），说明其门操作误差更大。
#figure(image("imgs/FigRB_comb.png", width: 95%),
  caption: [
    #strong[Single qudit randomized benchmarking]. From the decay of the survival probability for increasingly long sequences of randomly chosen Clifford gate decompositions of identity, we estimate the average error per gate~@Magesan2012. For qutrits (blue data points) we obtain an average Clifford error rate of $2 ( 2 ) dot.op 10^(- 3)$ corresponding to an error rate of $2.0_(- 0.5)^(+ 0.8) dot.op 10^(- 4)$ per laser pulse. For ququints (orange data points), we obtain an average Clifford error rate of $1.0 ( 2 ) dot.op 10^(- 2)$, corresponding to an error rate of $3.2_(- 0.7)^(+ 0.8) dot.op 10^(- 4)$ per laser pulse. For each length we performed at least 20 random sequences (data points), with the median shown in red. The fits (blue and orange lines) and their $99 "%"$ confidence intervals (shaded regions) are shown as well.
  ]
)
<fig:RB>



Completing the universal toolbox requires at least one qudit entangling gate. The most basic choice here is a two-level controlled-NOT ($"Cnot"$) gate embedded in a qudit Hilbert space. We call this a controlled-exchange gate, $"Cex"$, since it exchanges two states $| t_1 chevron.r , | t_2 chevron.r$ of the target qudit if and only if the control qudit is in state $| c chevron.r$:


$ "C" "ex"_(c,t_(1),t_(2)) : | c,t_(1) chevron.r arrow.l.r | c,t_(2) chevron.r \
| j,k chevron.r arrow.r | j,k chevron.r quad"for j" eq.not c, k eq.not t_(1),t_(2) . $ <eq:cex>


A slightly generalized version of the $"Cex"$ is the controlled-increment ($"Cinc"$) gate~@Brennen2006, which increments the state of the target qudit by 1, if and only if the control qudit is in state $d - 1$: $ "Cinc" : cases(
    | j & k chevron.r arrow.r | j & k chevron.r & upright("if j<d-1"),
    | j & k chevron.r arrow.r | j & k xor 1 chevron.r & upright("if j=d-1")
  ) $<eq:cinc> where $xor$ denotes addition modulo $d$. Other entangling gates, such as the controlled-sum gate ($upright(C)_(upright("sum")) | i chevron.r | j chevron.r = | i chevron.r | j + i chevron.r$) can be obtained from multiple applications of $"Cinc"$ or $"Cex"$.


// [figvision-cn] imgs/FigCinc.png
// (a) 子图类型：三维柱状图。该图展示了一个9x9的网格，代
// 表输入和输出量子态的概率分布。垂直轴（Z轴）表示概率幅
// 值，通过右侧的颜色条映射，颜色从蓝色（0.0）渐变到红色
// （1.0）。水平面由两个轴定义：一个轴标记为输入基矢态 $|
// 00\rangle$ 到 $|22\rangle$（共9个态），另一个轴标记为
// 输出基矢态 $|00\rangle$ 到 $|22\rangle$。图中显示，对
// 于每个输入态（例如 $|00\rangle$），只有一个对应的输出
// 态具有较高的概率柱（红色/橙色），其余输出态的概率极低
// （蓝色平面）。具体对应关系遵循受控递增门的逻辑：输入 $
// |ij\rangle$ 主要转化为输出 $|i, (j+1)\%3\rangle$。例如，
// 输入 $|00\rangle$ 对应输出 $|01\rangle$ 的高柱，输入 $
// |02\rangle$ 对应输出 $|00\rangle$ 的高柱。这表明实验实
// 现的门操作具有极高的准确性，几乎将所有概率幅集中在预期
// 的目标态上。 (b) 子图类型：二维散点拟合曲线图。横坐标
// 为“Number of gates”（门数量），范围从0到约11，刻度间隔
// 为2。纵坐标为“Fidelity”（保真度），范围从0.6到1.0，刻
// 度间隔为0.1。图中包含两组数据系列，均从(0, 1.0)开始随
// 门数量增加而下降。第一组数据为蓝色圆点，带有垂直误差棒，
// 周围有浅蓝色阴影区域表示拟合不确定性；第二组数据为橙色
// 圆点，带有垂直误差棒，周围有浅橙色阴影区域。每组数据都
// 有一条实线穿过数据点，代表指数衰减拟合。蓝色曲线的衰减
// 速率较慢，在11个门时保真度约为0.78；橙色曲线衰减速率较
// 快，在11个门时保真度降至约0.55。该图传达了随着连续施加
// 的门操作数量增加，量子态的保真度呈指数级下降的趋势，且
// 不同门操作的退相干速率存在差异。
#figure(image("imgs/FigCinc.png", width: 95%),
  caption: [
    #strong[Qutrit entangling gates] #strong[\(a)] Experimentally measured truth-table for a controlled-increment gate $"Cinc"$. #strong[\(b)] Fidelity decays for a $"Cex"$ gate in a qutrit Hilbert space, and a qutrit $"Cinc"$ gate with initial states $| 0 + 1 chevron.r | 0 chevron.r / sqrt(2)$ and $| 0 + 2 chevron.r | 0 chevron.r / sqrt(2)$, respectively. The data points correspond to the average of population and coherence at each gate length and the lines are exponential fits from which we extract the average fidelity values. Note that the different number of data points is due to the periodicity of 2 for the $"Cex"$ gate and 3 for the $"Cinc"$ gate.
  ]
)
<fig:CincResults>



The most straight-forward way to implement two-qudit gates, which we follow here, is again to decompose them into two-level rotations per Eq.~#ref(<eq:localOps>, supplement: none) and two-level MS gates per Eq.~#ref(<eq:entOps>, supplement: none). A crucial challenge here is again the "global" phase factor $exp ( upright(i) theta / 2 )$ of the MS gate, which imparts unwanted phases on spectator states, see SM for details and design considerations. In the case of the $"Cex"$ gate we find a decomposition into 2 two-level MS gates independent of qudit dimension, and for the $"Cinc"$ gate we require $2 d$ MS gates. Other two-qudit gates can be synthesized in a similar fashion. Alternatively, one could directly generalize the MS gate to a native qudit gate by driving multiple transitions simultaneously. This reduces the gate count, however, only at the cost of increased complexity of the classical control system and more challenging experimental calibration~@Low2020.


Experimentally, we estimate the fidelity of the $"Cex"$ and $"Cinc"$ gates in a SPAM-free way by applying a sequence of entangling gates of increasing length to a fixed input state and measuring both the fraction of runs that end in the correct state (population) and the contrast of the resulting interference fringes (coherence), see @fig:CincResults. Fitting the average of these values we obtain fidelity estimates of $cal(F) = 97.5 ( 2 ) "%"$ and $cal(F) = 93.8 ( 2 ) "%"$ for the $"Cex"$ and $"Cinc"$ gates, respectively.


The final challenge is qudit readout, which requires us to distinguish $d$ different states, whereas conventional fluorescence readout can only distinguish the S and D manifold. To circumvent this problem, we employ a sequential readout scheme. First, we shelve the $| 2 chevron.r$ state to the D manifold (thus one of the 8 levels needs to remain unpopulated). Then we perform a standard fluorescence readout, which projects each ion in the string onto $( | 0 chevron.r chevron.l 0 | , bb(1) - | 0 chevron.r chevron.l 0 | )$, allowing us to identify the $| 0 chevron.r$ state without perturbing the rest. This is followed by a reordering pulse, which brings the state $| 1 chevron.r$ into the S manifold and another fluorescence readout. This sequence is repeated until all ions are found in the "bright" state at some point in the readout sequence, which lets us assign a unique qudit quantum state to the string of ions. The readout time for this scheme increases only linearly in qudit dimension, see @fig:readout\(a).


// [figvision-cn] imgs/FigDetectionSmall.png
// (a) 子图类型为能级示意图。图中展示了钙离子（Ca+）的能
// 级结构，分为左右两部分。左侧显示了基态 $^4S_{1/2}$、激
// 发态 $^4P_{1/2}$、$^4P_{3/2}$ 以及亚稳态 $^3D_{3/2}$
// 和 $^3D_{5/2}$。蓝色实心向下箭头表示波长为 397nm 的光
// 跃迁，连接 $^4S_{1/2}$ 与 $^4P_{1/2}$；红色空心向上箭
// 头表示 866nm 的再泵浦光，连接 $^3D_{3/2}$ 与 $^4P_{1/2
// }$；粉色空心向上箭头表示 854nm 的光，连接 $^4P_{3/2}$
// 与 $^3D_{5/2}$；浅红色空心向下箭头表示 729nm 的光，连
// 接 $^4S_{1/2}$ 与 $^3D_{5/2}$。右侧通过灰色虚线将左侧
// 的能级与右侧的三个量子态对应起来，这三个态分别标记为 |
// 0⟩（自旋投影 -1/2）、|1⟩（自旋投影 -1/2）和 |2⟩（自旋
// 投影 +1/2）。此外，还有灰色文字标注了其他自旋投影态：
// -5/2, -3/2, +3/2, +5/2。两个红色圆圈数字标注了关键过程：
// 标号①是一个红色虚线双向箭头，位于 |0⟩ (+1/2) 和 |2⟩ (+
// 1/2) 之间；标号②是一个红色虚线双向箭头，位于 |0⟩ (-1/2
// ) 和 |1⟩ (-1/2) 之间。该图传达了利用不同激光波长实现多
// 能级量子态操控和读取的物理机制。 (b) 子图类型为脉冲时
// 序流程图。横轴代表时间，从左到右依次排列了不同阶段的矩
// 形框。首先是三个浅蓝色填充的方框，分别标注为“DC”、“PGC
// ”、“SBC”。接着是一个较宽的粉红色填充方框，标注为“
// Experiment”。随后是一个黄色填充方框，标注为“Det”。之后
// 是一个重复单元，由一个大括号括起并标注为“x (d-2)”，表
// 示该序列重复 d-2 次。重复单元内部包含一个浅蓝色方框“DC
// /PGC”，一个粉红色方框“{|i⟩→|j⟩}”，以及一个黄色方框“Det
// ”。所有方框下方有黑色粗线连接，表示时序上的连续性。该
// 图描述了四量子比特读取的完整脉冲序列流程。 (c) 子图类
// 型为双对数坐标曲线图。横轴为“Detection time (μs)”，范
// 围从 150 到 500，主刻度间隔为 50。纵轴为“Readout error
// ”，对数刻度，范围从 $5 \times 10^{-5}$ 到 0.050，主刻
// 度包括 $5 \times 10^{-5}, 1 \times 10^{-4}, 5 \times
// 10^{-4}, 0.001, 0.005, 0.010, 0.050$。图中包含六个蓝色
// 实心圆点数据点，大致呈下降趋势。一条蓝色实线穿过这些数
// 据点，表示拟合曲线，其周围环绕着橙色阴影区域，代表置信
// 区间。一条黑色虚线位于上方，随检测时间增加缓慢下降后趋
// 于平缓。一条蓝色点划线水平贯穿图表下部，标注为“spont.
// decay”，位置约在 $0.002$ 处。另一条蓝色实线（或虚线，
// 根据上下文推断为理论极限线）标注为“shot noise”，与数据
// 点和拟合线重合度较高，表明误差主要受散粒噪声限制。该图
// 显示随着检测时间增加，读取误差显著降低，且在较长检测时
// 间下趋近于自发辐射极限和散粒噪声极限。
#figure(image("imgs/FigDetectionSmall.png", width: 100%),
  caption: [
    #strong[\(a) Qudit readout] is achieved by successive electron shelving and scattering steps with interleaved recooling. #strong[\(b) Qudit Readout pulse sequence.] #strong[\(c) Qudit readout error.] Data points represent measured discrimination uncertainty between bright and dark states at a given measurement time. The solid blue line indicates the fit to this data with $99 "%"$ confidence regions in orange. The dotted blue line represents the error from spontaneous decay for two detections (qutrit), with $2500 mu s$ of PGC cooling between detections. The combined detection error in the worst case is given by the dashed black line, indicating an optimum of $3 dot.op 10^(- 3)$ for $tilde 500 mu s$ detection time.
  ],
  placement: top,
)
<fig:readout>



An additional challenge with longer strings of ions is scattering-induced heating of the ion crystal. This increases the error rate of subsequent reordering pulses and thereby contributes to detection errors. We counter this effect by applying broadband polarization-gradient cooling (PGC) between detection events, see @fig:readout\(b). This unavoidably increases the time required for a full readout, leading to a qutrit readout error of $tilde 99.7 "%"$ for $500 mu s$ detection time and $2500 mu s$ re-cooling time. Note, however, that this is a worst-case error, since those states measured earlier will experience lower spontaneous decay errors than those measured later. Moreover, the readout error can be reduced by an order of magnitude using improved collection optics~@Pogorelov2021 and fast re-cooling techniques~@Schindler2013.


We demonstrate a universal qudit quantum processor built on state-of-the-art trapped-ion hardware. Our approach requires only a minimal overhead in classical control capabilities and can be integrated into existing experiments. This will particularly benefit applications that are natively formulated in terms of higher spin models, such as quantum chemistry~@MacDonell2020 and quantum simulation of lattice gauge theories~@Rico2018. Two key challenges for getting the best performance out of qudit hardware are low cross-talk errors due to the large number of local operations required, and fast re-cooling and readout capabilities to reduce SPAM errors. Improvements to the optics and control electronics could improve these numbers by at least an order of magnitude with current technology. Finally, a larger magnetic field would have the benefit of larger spectral separation between the various qudit transition, which will be required for working with longer strings of qudits and the associated crowded mode spectrum. Conceptually, a key challenge for making use of the system we present remains in compiling quantum algorithms into the qudit framework. To facilitate such compilation, it will be highly beneficial to complement the embedded two-level entangling gates we presented with a suite of genuine qudit entangling gates.


#block[
#strong[Acknowledgements] We thank Marcus Huber and Joel Wallman for discussions. This project has received funding from the European Union's Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No 840450. It reflects only the author's view, the EU Agency is not responsible for any use that may be made of the information it contains. We also acknowledge support by the Austrian Science Fund (FWF), through the SFB BeyondC (FWF Project No.~F7109), by the U.S.~Army Research Office (ARO) through grant no.~W911NF-21-1-0007, and by the Office of the Director of National Intelligence (ODNI), Intelligence Advanced Research Projects Activity (IARPA), via the U.S. ARO Grant No. W911NF-16-1-0070. This project has received funding from the European Union's Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No. 801110 and the Austrian Federal Ministry of Education, Science and Research (BMBWF). \
#strong[Author contributions] MR developed the concepts. MR, MM, LP, RS, PS, and TM performed the experiments. MR analyzed the data. TM and RB supervised the project. All authors contributed to writing the manuscript. \
#strong[Competing Interests] The authors declare no competing interests. \
Requests for materials and correspondence should be addressed to MR (email: martin.ringbauer\@uibk.ac.at).

]


#show bibliography: set text(size: 9pt, lang: "en")
#show bibliography: set par(leading: 0.25em, spacing: 0.6em, hanging-indent: 1em)
#show bibliography: set block(spacing: 0.6em)
#bibliography("refs.bib", title: none, style: "american-physics-society", full: true)

#pagebreak()
#set page(columns: 1)

#block(above: 0em, below: 1.2em)[
#set par(first-line-indent: 0em)
#strong[Supplementary Information: \
A universal qudit quantum processor]

]

#set heading(numbering: none)
#show heading.where(level: 1): it => block(above: 1.6em, below: 0.9em, text(weight: "bold", upper(it.body)))
#show heading.where(level: 2): it => block(above: 1.3em, below: 0.7em, align(center)[#text(weight: "bold", it.body)])
#counter(math.equation).update(0)
#set math.equation(numbering: n => "(S" + str(n) + ")")
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)
#show figure.where(kind: image): set figure(supplement: "FIG.", numbering: n => "S" + str(n))
#show figure.where(kind: table): set figure(supplement: "TABLE", numbering: "SI")
#show figure.where(kind: table): it => { set align(center); it }
#show figure.caption: set text(size: 8.5pt)
#show figure.caption: set par(justify: false)
#set figure.caption(separator: [.])
#show figure.caption: set text(size: 8.5pt)

= MULTI-ION ADDRESSING
<multi-ion-addressing>
Individual addressing of ions is achieved with a tightly focused laser beam at an angle of $67.5^compose$ to the ion string~@Schindler2013. A combination of two crossed acousto-optic deflectors (AOD) at a $90^compose$ angle to each other~@kim2008acousto enables beam steering over a wide range with reconfiguration times below $10 mu s$, see @fig:addressing. By using the positive first order of diffraction on the first AOD and the negative first order on the second AOD, any frequency shifts are exactly cancelled. Multiple ions are addressed by simultaneously applying two (or more) frequencies to the addressing unit. In contrast to approaches with fixed fibre arrays~@Figgatt2019, our setup allows for precise individual control of each beam to match the non-equidistant ion positions. Moreover, the phase of each addressed beam can be individually controlled by a phase offset between the RF signals on two AODs for a given driving tone. The price to pay for such flexibility, however, is that $n$ driving tones lead to $n^2$ beams, due to combinations of non-corresponding frequencies of the different AODs, see @fig:addressing. Although beams that originate from mixing of different frequencies are out of the plane of ions, there is residual overlap when addressing ions in close proximity, which leads to cross-talk errors. To avoid such errors, we make use of the fact that any off-axis spots are frequency shifted and thus not resonant with the ion. An important design parameter to ensure that this is true also for bichromatic beams used for entangling gates is the ratio of RF-frequency change to spatial displacement. This parameter can be controlled by the choice of input beam size and focusing optics, which we design for a value of $tilde 65 med "kHz" / mu m$, and a minimal ion separation of $tilde 3.5 mu m$. This ensures that unwanted spots are spectrally detuned from all carriers and motional sidebands for strings up to length 10, see @fig:addressingSpectrum. This optical setup could be further improved by using a beam that is perpendicular to the ion chain and then does not couple to axial motional modes. This system enables two-qubit entangling gates on arbitrary pairs of ions with an error rate that increases only weakly with the number of ions, see @fig:AddressedMS.


// [figvision-cn] imgs/FigAddressingA_wide.png
// 该图包含两个子图，分别标记为(a)和(b)，展示了用于同时多
// 离子寻址的地址单元。 子图(a)是一个光学装置示意图。图中
// 从左至右排列着三个主要元件：一个黑色的矩形块状器件、一
// 个灰色的双凸透镜、另一个相同的黑色矩形块状器件，以及第
// 二个灰色双凸透镜。一条红色的直线代表光束路径，水平穿过
// 整个装置。 在左侧第一个黑色器件处，标注文字为“
// frequency up-shift”（频率上移）。在该器件上方，标注有
// 数学表达式“f1+f2”，表示输出光的频率。光束进入该器件后，
// 经过第一个透镜聚焦，再进入右侧的第二个黑色器件。 在右
// 侧第二个黑色器件处，标注文字为“frequency down-shift”（
// 频率下移）。在该器件上方，同样标注有数学表达式“f1+f2”。
// 光束从该器件射出后，经过第二个透镜准直，变为两条平行的
// 红色光束向右传播。整个示意图描绘了通过两个级联的声学光
// 调制器（AOMs）对光束进行频率搬移的过程，先上移再下移，
// 最终输出两束频率相同的光束。 子图(b)是一张相机拍摄的衍
// 射光斑照片，背景为深紫色。图像中心区域分布着多个明亮的
// 方形或菱形光斑阵列。图像上有多种颜色的几何图形叠加以指
// 示不同光束的位置，并配有引线和文字说明。 左上角有两行
// 文字标签：“Addressing beams”（寻址光束）和“Detuned
// beams”（失谐光束）。 一条绿色的引线从“Addressing beams
// ”标签引出，指向图像左上方一个由绿色方框圈出的明亮光斑
// 区域。 三条橙色的引线从“Detuned beams”标签引出，分别指
// 向三个不同的光斑位置：一个位于图像中上部偏左的橙色方框
// 内，一个位于图像中下部偏左的橙色方框内，还有一个位于图
// 像中央偏下的蓝色菱形框内的某个光斑。 图像中央有一个白
// 色的圆形圈出了最中心的一个高亮光斑。一条浅蓝色的引线从
// 该圆圈引出，指向右侧的文字说明：“0th order of both
// AOMs”（两个AOM的零级衍射），表明这是两个调制器都未发生
// 衍射的主光束。 在图像右侧，有一个大的蓝色菱形框覆盖了
// 中心及右侧的大部分光斑区域。一条蓝色的引线从该菱形框引
// 出，指向右侧下方的文字说明：“0th order of one AOM and
// 1st order of the other AOM”（一个AOM的零级衍射和另一个
// AOM的一级衍射），解释了这些光斑是由一个调制器的零级光
// 和另一个调制器的一级光组合而成的。 整张图展示了经过双
// AOM系统后的光束空间分布，区分了主寻址光束、因频率失谐
// 产生的旁瓣光束以及不同衍射级的组合光斑。
#figure(image("imgs/FigAddressingA_wide.png", width: 100%),
  caption: [
    #strong[Addressing unit for simultaneous multi-ion addressing.] #strong[\(a)] An incoming light beam is frequency up-shifted by first-order diffraction in an AOD rotated $45 deg$ relative to the ion chain. The beam is then imaged into a second AOD rotated $- 45 deg$ to the ion chain and frequency down-shifted by the same amount. This results beam that is freely steerable along the ion chain with no frequency shift and full phase control via phase offset between the AODs. Owing to the large bandwidth of the AODs, the addressing range of such a system is only limited by the the subsequent focusing optics into the trap and capable of addressing up to 100 ions. #strong[\(b)] Applying $n$ frequencies results in $n$ unshifted spots in the plane of the ions. However, at the same time, there are also $n^2 - n$ out-of-plane spots that result from mixing of diffractions corresponding to different frequencies and are thus off-resonant by the difference in addressing frequencies.
  ]
)
<fig:addressing>



// [figvision-cn] imgs/off_axis_spot_spectrum.png
// 该图展示了一张模拟光谱图，描绘了在使用双频光场寻址两个
// 离子以执行MS门操作时，产生的非轴向外侧斑点的频率分布。
// 横坐标为相对于载波跃迁的失谐量，标记为“Detuning from
// carrier transition Δ/2π”，单位为兆赫兹（MHz），刻度范
// 围从-5至5，主刻度线位于-4、-2、0、2、4处。纵坐标未明确
// 标注数值，代表信号强度或概率幅。 图中包含多组垂直排列
// 的数据点，每组由不同颜色的圆点和三角形组成，并通过虚线
// 连接至横轴上的特定位置。每个符号代表一个特定的离子对或
// 运动模式：实心圆点表示被寻址的离子对，其标签为整数元组
// 如[1, 0]、[2, 1]等，共列出16种组合；空心三角形表示径向
// 或轴向边带模式，分为BSB axial（蓝色上三角）、BSB
// radial（黄色上三角）、RSB axial（浅蓝下三角）、RSB
// radial（浅黄下三角）。 颜色编码与图例一致：例如，深蓝
// 色圆点对应[1, 0]，橙色对应[2, 1]，绿色对应[3, 2]，红色
// 对应[4, 3]，紫色对应[5, 4]，棕色对应[6, 5]，粉色对应[7
// , 5]，玫红对应[7, 6]，淡粉对应[8, 6]，灰色对应[8, 7]，
// 橄榄绿对应[9, 7]，亮黄对应[9, 8]。这些圆点在横轴上分布
// 于约±0.5 MHz、±1.5 MHz、±2.5 MHz、±3.5 MHz附近，形成对
// 称簇状结构。 三角形符号分布在更宽的失谐范围内，主要集
// 中在±1.0 MHz、±2.0 MHz、±3.0 MHz、±4.0 MHz处，且上下三
// 角交替出现，分别对应不同的边带模式。所有数据点均通过垂
// 直虚线连接到横轴，表明其在频谱中的精确位置。 整体趋势
// 显示，当失谐接近零时，相邻及次相邻离子的贡献最为显著，
// 表现为密集的信号簇；随着失谐增大，信号逐渐稀疏并趋于均
// 匀分布。这反映了在MS门操作中，非目标离子的串扰主要来源
// 于邻近离子的耦合效应，且随失谐增加而减弱。
#figure(image("imgs/off_axis_spot_spectrum.png", width: 90%),
  caption: [
    Simulated spectrum of the unwanted off-axis spots (solid stems, integer tuple in the legend denotes the addressed ions) when addressing two ions with a bichromatic light field, slightly detuned from the axial center-of-mass motional sideband, as used for the MS gate. Shown are only the off-axis spots resulting from addressing neighbour and next-neighbour ions, since the others' contributions to cross-talk errors are negligible. Different symbols indicate the frequencies of red (RSB) and blue (BSB) sidebands along the axial and radial direction with respect to the trap axis, see legend. The example is for 10 ions at an axial trap frequency of $800 med "kHz"$, with a displacement ratio of $tilde 65 med "kHz" / mu m$.
  ]
)
<fig:addressingSpectrum>



// [figvision-cn] imgs/ms_decay.png
// 该图包含一个子图，类型为带有线性拟合曲线的散点图。纵坐
// 标轴标签为“Fidelity”，数值范围从0.75至1.00，刻度间隔为
// 0.05。横坐标轴标签为“Nr. of gates”，显示的主要刻度标记
// 为1、5、9、13和17。图中展示了两组数据系列及其对应的拟
// 合直线。第一组数据代表“10 ion crystal”（10离子晶体），
// 由蓝色实心圆点表示，每个数据点均附有垂直误差棒；一条实
// 心蓝色直线穿过这些点，呈下降趋势，在横坐标为1时纵坐标
// 约为0.98，随横坐标增加至17时，纵坐标降至约0.76。第二组
// 数据代表“3 ion crystal”（3离子晶体），由橙色实心圆点表
// 示，同样附有垂直误差棒；一条实心橙色直线穿过这些点，也
// 呈下降趋势但斜率较缓，在横坐标为1时纵坐标接近1.00，随
// 横坐标增加至17时，纵坐标降至约0.89。图左下角设有图例框，
// 上方条目为蓝色圆点及误差棒符号，标注文字为“10 ion
// crystal”；下方条目为橙色圆点及误差棒符号，标注文字为“3
// ion crystal”。整体趋势表明，随着门操作数量（Nr. of
// gates）的增加，两种离子晶体的保真度（Fidelity）均呈线
// 性衰减，且10离子晶体的衰减速度显著快于3离子晶体。
#figure(image("imgs/ms_decay.png", width: 50%),
  caption: [
    Fidelity decay for addressed entangling gates in a 3 and 10 ion string. The fidelity is $0.993 plus.minus 0.002$ and $0.983 plus.minus 0.002$ respectively. Gate performance for ion strings of intermediate length can be interpolated from these values.
  ]
)
<fig:AddressedMS>



= OFF-RESONANT OPERATIONS
<off-resonant-operations>
One of the primary error sources in trapped-ion quantum computers is cross-talk from addressed operations~@Parrado-Rodriguez2020. A common way to combat this problem in conventional TIQPs is through the use of composite pulses, which are a sequence of counter-rotating resonant operations and off-resonant AC-Stark ($upright(Z)$) rotations:


$ "R" ( theta , phi.alt ) = Z ( pi ) - "R" ( - theta / 2 , phi.alt ) - Z ( pi ) - "R" ( theta / 2 , phi.alt ) . $<eq:refocusing>


The $upright(Z)$ rotations are implemented by a far-detuned laser, which induces energy level shifts due to the AC-Stark effect. Since the Rabi frequency in this case scales quadratically with the resonant Rabi frequency, these pulses benefit from quadratically suppressed cross-talk to neighbouring ions. In the present experiment, the sequence of Eq.~#ref(<eq:refocusing>, supplement: none) suppresses cross-talk to $tilde 2 dot.op 10^(- 3)$ (from $tilde 4 "%"$ for a resonant operation), which is on the same order of magnitude as the benchmarked gate error rate from @fig:RB. This could be further reduced by several orders of magnitude with improved addressing optics~@Pogorelov2021.


Reducing cross-talk errors is particularly relevant for qudit quantum processors, as they typically require more basic rotations to realize arbitrary operations than their qubit counterpart. However, when more than two states are occupied, the effect of off-resonant laser interaction is more complex, as each state acquires a different AC-Stark shift due to varying detunings and coupling strengths, see @fig:StarkShift. Formally, the relative shift $Delta_(i , j)$ between states $| i chevron.r$ and $| j chevron.r$ is given by~@Howard2012


$ Delta_(i , j) ( Delta ) = Omega^2 / 4 (2 b - sum_t frac(Omega_t^2 dot.op gamma_(i , j)^(( t )), delta - delta_t)) , $<eq:Starkshift>


where the sum runs over all transitions $( t )$, whose coupling strengths relative to the $0 arrow.l.r 1$ transition are given by the dimensionless quantity $Omega_c$ and can be controlled by the laser polarization. $delta$ denotes the detuning of the light field, $delta_t$ is the detuning of transition $t$ from the $| 0 chevron.r arrow.l.r | 1 chevron.r$ transition, $Omega$ the Rabi frequency on the $| 0 chevron.r arrow.l.r | 1 chevron.r$ transition, and $b$ is the Stark shift due to the far-detuned dipole transitions. The relative contributions of the quadrupole transitions to the Stark-shift obtained by the $| i chevron.r arrow.l.r | j chevron.r$ transition is given by $gamma_(i , j)$, which takes the value 2 for the transition $| i chevron.r arrow.l.r | j chevron.r$, 1 for transitions that include either $| i chevron.r$ or $| j chevron.r$, and 0 otherwise.


From Eq.~#ref(<eq:Starkshift>, supplement: none) and @fig:StarkShift it is clear that, in the qudit case, a single off-resonant light field would lead to practically uncontrollable phase shifts outside the addressed transition. However, a careful analysis shows that for a system with $d$ occupied levels, a multi-chromatic off-resonant light field with $( d - 1 )$ tones can, in principle, exactly compensate all level shifts, but one. This provides an avenue for targeted phase shifts of any level in a qudit, enabling composite pulse techniques like in Eq.~#ref(<eq:refocusing>, supplement: none). However, each such beam contains $2 dot.op ( d - 2 )$ coupled parameters, which can make their experimental calibration challenging. $ upright("Z")^i ( theta ) | j chevron.r = cases(
    e^(- i theta) | j chevron.r & upright("if j=i"),
    | j chevron.r & upright("otherwise")
  ) . $<eq:QuditStark>


// [figvision-cn] imgs/FigACstark1_wide.png
// 该图为一个二维曲线图，展示了四能级量子系统（ququart）
// 中AC-Stark位移随失谐量的变化关系。 横坐标轴表示“相对于
// 量子比特载波的失谐量”（Detuning from qubit carrier），
// 符号为Δ/2π，单位为MHz。坐标轴范围从-30 MHz延伸至约25
// MHz，主刻度线标记在-30、-20、-10、0、10和20处。 纵坐标
// 轴表示“Stark位移”（Stark shift），符号为δ/2π，单位为
// kHz。坐标轴范围从-100 kHz至100 kHz，主刻度线标记在-100、
// -50、0、50和100处。 图中包含四条不同颜色的数据曲线，分
// 别对应四能级系统中的四个特定跃迁，右侧图例标明了各曲线
// 的物理含义： 蓝色曲线代表跃迁Δ01。 橙色曲线代表跃迁Δ12。
// 绿色曲线代表跃迁Δ23。 红色曲线代表跃迁Δ03。 每条曲线均
// 由离散的数据点（圆形符号）和穿过这些点的实线组成。实线
// 代表理论预测值，已针对所用声光调制器（AOM）的有限带宽
// 进行了调整，且相对耦合强度是独立测量的。 图像中的垂直
// 辅助线用于标示共振位置： 黑色虚线位于x轴数值约为-22.5、
// -7.5、7.5和17.5的位置。 黑色实线位于x轴数值约为-16、
// -11、-6、-1、4、9和14的位置。 趋势与结论描述： 所有曲
// 线均表现出典型的色散特征，即在接近特定的垂直线（共振点）
// 时，Stark位移发生剧烈变化，从负值迅速跳变至正值或反之。
// 具体而言，对于每一个跃迁（如蓝色曲线Δ01），其主要的发
// 散中心出现在x轴接近0的位置，而在其他位置（如约±5, ±10
// 等）也出现较小的发散结构，这对应于与其他能级的相互作用。
// 在远离共振区域（例如x < -25或x > 18），所有曲线的Stark
// 位移趋近于0 kHz。 四条曲线的形状相似但沿横轴平移，表明
// 不同的能级跃迁对失谐的响应具有特定的频率偏移，反映了四
// 能级系统的能级结构。
#figure(image("imgs/FigACstark1_wide.png", width: 90%),
  caption: [
    #strong[AC-Stark shifts in a ququart] Stark shift as a function of the detuning of a single off-resonant beam from the qubit transition for all four transitions in a ququart encoded as in Fig.~#ref(<fig.levelscheme>, supplement: none). The solid lines represent the theory prediction according to Eq.~#ref(<eq:Starkshift>, supplement: none), adjusted for the finite bandwidth of the used AOM, where the relative coupling strengths were measured independently. The Rabi frequency, dipole contribution, and AOM bandwidth are fitted to the measured datapoints. Dashed and dot-dashed vertical lines indicate carrier transitions for the $S ( - 1 / 2 )$ and $S ( + 1 / 2 )$ states, respectively, and black, solid vertical lines indicate the frequencies of our bichromatic AC-Stark gate to achieve equal Stark shift on the two S and the two D levels. Stark shifts are expected to diverge close to the carrier transitions, and converge to a non-zero background level for large detuning due to coupling to the dipole transitions (not shown).
  ]
)
<fig:StarkShift>



Fortunately, a simpler approach suffices for our purpose, where we do not need arbitrary phase shifts on individual levels, but merely want to generalize the composite pulse sequence of Eq.~#ref(<eq:refocusing>, supplement: none) to qudits. In this case, it is sufficient to limit the Stark shifts of all the levels to multiples of $pi$, rather than nulling all but one. For example, it is always sufficient to equally shift the "S" levels $| 0 chevron.r , | 2 chevron.r$ in Fig.~#ref(<fig.levelscheme>, supplement: none) with respect to the "D" levels, since shifts on spectator levels cancel by construction. Experimentally, we demonstrate such composite pulses for qutrits and ququarts using a bichromatic off-resonant light field with one frequency far detuned at $−10 med "MHz"$ and a second frequency at $−0.5 med "MHz"$ from the $0 arrow.l.r 6$ transition, see @fig:QuditAC.


// [figvision-cn] imgs/FigQuditAC2_wide.png
// 图1包含两个子图，分别标记为(a)和(b)，均为带有误差棒的
// 实验数据曲线图，用于展示三能级系统（qutrit）在拉姆齐干
// 涉实验中的激发态布居随时间演化。横坐标均为“time (μs)”，
// 范围从0到1000微秒；纵坐标均为“Excitation”，表示各能级
// 的激发概率，范围从0.0到1.0。每个子图中有三条带误差棒的
// 数据曲线，分别对应三个量子态|0⟩、|1⟩、|2⟩，由不同颜色
// 区分：蓝色代表|0⟩，橙色代表|1⟩，绿色代表|2⟩。每条曲线
// 上均有垂直误差棒，表示测量不确定性。 子图(a)： 类型：
// 实验数据曲线图。 坐标轴：横轴“time (μs)”从0至1000 μs，
// 纵轴“Excitation”从0.0至1.0。 曲线含义： 蓝色曲线（|0⟩）：
// 初始值为1.0，随后振荡衰减，在约200 μs处首次降至接近0，
// 之后呈现非周期性波动，振幅逐渐减小，最终在1000 μs时回
// 升至约0.9。 橙色曲线（|1⟩）：初始值为0，在约150 μs处达
// 到第一个峰值（约0.35），随后多次起伏，整体呈不规则振荡，
// 最大值未超过0.8，最小值不低于0.1。 绿色曲线（|2⟩）：初
// 始值为0，在约100 μs处达到第一个峰值（约0.65），随后与
// 橙色曲线交错振荡，幅度较大，部分区域与蓝色曲线交叉。
// 符号与线型：所有数据点均以实心圆点表示，连接成折线，每
// 点附有垂直误差棒。 标注文字：右上角图例标注“● |0⟩”、“●
// |1⟩”、“● |2⟩”，分别对应蓝、橙、绿三色。 趋势或结论：三
// 条曲线表现出复杂的非线性动力学行为，无明显周期同步性，
// 表明系统在自由演化过程中存在显著的退相干或非理想耦合效
// 应，导致布居分布混乱且不可预测。 子图(b)： 类型：实验
// 数据曲线图。 坐标轴：横轴“time (μs)”从0至1000 μs，纵轴
// “Excitation”从0.0至1.0。 曲线含义： 蓝色曲线（|0⟩）：
// 初始值为1.0，以近似正弦形式周期性振荡，周期约为200 μs，
// 振幅稳定在0.9以上，仅在波谷处短暂下降至0.1左右，整体保
// 持高保真度。 橙色曲线（|1⟩）：初始值为0，以相同周期振
// 荡，相位滞后于蓝色曲线约90度，峰值约0.65，谷值接近0，
// 形态规则。 绿色曲线（|2⟩）：初始值为0，同样以200 μs周
// 期振荡，相位介于蓝橙之间，峰值约0.7，谷值接近0，与另两
// 条曲线形成清晰的三角相位关系。 符号与线型：所有数据点
// 均以实心圆点表示，连接成平滑折线，每点附有垂直误差棒，
// 误差棒长度较小，表明测量精度高。 标注文字：右上角图例
// 标注“● |0⟩”、“● |1⟩”、“● |2⟩”，分别对应蓝、橙、绿三色。
// 趋势或结论：三条曲线展现出高度规则的周期性振荡，相位差
// 固定，振幅稳定，说明系统在该条件下实现了良好的相干操控，
// 能够维持多能级叠加态的长期稳定性，验证了所提出的qudit
// AC-Stark脉冲方案的有效性。
#figure(image("imgs/FigQuditAC2_wide.png", width: 95%),
  caption: [
    #strong[Qudit AC-Stark pulses.] To verify the performance of our qudit off-resonant operations, we perform a Ramsey experiment, where we create an equal superposition of all qutrit states, followed by evolution under a #strong[\(a)] single-tone, #strong[\(b)] compensated two-tone AC-Stark pulse, followed by a reversal of the first operation. Solid lines correspond to a fit, points are measured data with one standard deviation statistical uncertainties.
  ]
)
<fig:QuditAC>



= SINGLE-QUDIT GATE DECOMPOSITION
<single-qudit-gate-decomposition>
Recall that the native single-ion operations available in the ion trap are equatorial rotations on any S-D transition, except those with $Delta m = plus.minus 3$, given by


$ "R"_(i , j) ( theta , phi.alt ) = exp ( - i theta ( cos ( phi.alt ) sigma_(upright(x))^(i , j) plus.minus sin ( phi.alt ) sigma_(upright(y))^(i , j) ) / 2 ) . $<eq:SUPPlocalOps>


Here $sigma_(x , y , z)$ are the Pauli X,Y,Z matrices, $theta$ denotes the rotation angle, and $i , j$ with $i < j$ indicate the addressed transition. Recall, that the phase convention for $phi.alt$ in $sigma_phi.alt^(i , j)$ is positive when $| i chevron.r$ is in the S-manifold and negative when $| j chevron.r$ is in the S-manifold.


We now discuss how arbitrary $S U ( d )$ operations can be decomposed into the basic rotations of Eq.~#ref(<eq:SUPPlocalOps>, supplement: none), adapted from Ref~@OLeary2006a. Following Ref.~@OLeary2006a the idea is to first bring the target unitary into diagonal form using the subspace rotations of Eq.~#ref(<eq:SUPPlocalOps>, supplement: none), and then implement appropriate phase-shifts between the qudit states. For the latter step it is in general sufficient to implement the target unitary up to a global phase $gamma$, which requires at most $d - 1$ phase gates between pairs of levels, which are decomposed into 3 resonant operations each. Importantly, this procedure works for any coupling map between the qudit levels, although the latter might affect the efficiency of the decomposition. In the case of ladder-type coupling, algorithm 1 provides a decomposition of a generic unitary $U in "SU" ( d )$ (indices run from $1$ to $d$). In case of other coupling structures, the same algorithm can be used, albeit with an adapted sequence of operations. Note that the algorithm returns a sequence of gates that must be applied in reverse order and conjugate-transposed for implementing the corresponding unitary in the lab.


#block(
  width: 100%,
  inset: (y: 0.7em),
  stroke: (top: 0.6pt, bottom: 0.6pt),
  above: 1.8em,
  below: 1.8em,
)[
  #align(center)[#strong[Algorithm 1] Decomposition of $U in "SU"(d)$ into two-level rotations adapted from Ref.~@OLeary2006a]
  #v(0.35em)
  #block[
    #set text(size: 9pt)
    #set par(leading: 0.62em)
    $tilde(U) = U$ \
    $"decomp" = {}$ \
    *for* $c = 1$, $c < d$ *do* \
    #h(1em)*for* $r = d$, $r > c$ *do* \
    #h(2em)*if* $tilde(U)_(r , c) != 0$ *then* \
    #h(3em)$theta = 2 arctan [|tilde(U)_(r , c) / tilde(U)_(r - 1 , c)|]$ \
    #h(3em)$phi.alt = - (arg [tilde(U)_(r - 1 , c)] - arg [tilde(U)_(r , c)])$ \
    #h(3em)$tilde(U) = "R" (theta , phi.alt)_(r , c) dot.op tilde(U)$ \
    #h(3em)$"decomp" . "append" ("R" (theta , phi.alt)_(r , c))$ \
    #h(3em)$r = r - 1$ \
    #h(2em)*end if* \
    #h(1em)*end for* \
    #h(1em)$c = c + 1$ \
    *end for* \
    Solve #h(0.6em) $mat(delim: "(", 1, 0, 0, dots.h.c, 0; -1, 1, 0, dots.h.c, 0; dots.v, dots.v, dots.v, dots.down, dots.v; 0, 0, 0, dots.h.c, -1) dot.op vec(gamma_1 / 2, gamma_2 / 2, dots.v, gamma_(d - 1) / 2) + vec(gamma, gamma, dots.v, gamma) = arg ["diag" (tilde(U))]$ \
    *for* $i = 1$, $i < d$ *do* \
    #h(1em)*if* $gamma_i != 0$ *then* \
    #h(2em)$"decomp" . "append" ("R" (pi / 2 , pi)_(i , i + 1) dot.op "R" (gamma_i , pi / 2)_(i , i + 1) dot.op "R" (pi / 2 , 0)_(i , i + 1))$ \
    #h(1em)*end if* \
    *end for* \
    *return* $"decomp"$
  ]
]



= TWO-QUDIT GATE SYNTHESIS
<two-qudit-gate-synthesis>
We now sketch a strategy for synthesising typical two-qudit gates using the standard gate set outlined in the main text. The two main challenges here are to control off-target operations (i.e.~operations beyond the addressed subspace) and undesired ("global" or local) phases of the employed operations. To this end, the first gadget we define is a phase-compensated MS-gate, denoted $tilde(upright("MS"))_(i , j) ( theta , phi.alt )$, see @fig:Supp:phasecorrectedMS. Here we employ additional phase-gates between all levels of the qudit to cancel unwanted phases of the MS-gate operation, such that it fully acts as the identity outside (0,1)-subspace that we want to address. These phase-gates will largely be absorbed into other local operations in the final compilation step.


// [figvision-cn] imgs/qudit_MS_phasecorrected.png
// 该图像为一张量子电路示意图，展示了一个相位补偿的MS门（
// Mølmer-Sørensen gate）在四能级系统中01子空间上的等效分
// 解。整个图像由左侧一个复合操作符号、中间一个等号、以及
// 右侧一个展开的量子电路组成，整体布局从左至右呈线性排列。
// 左侧部分： 子图类型：示意图（量子门符号）。 物体描述：
// 一个黄色填充、圆角矩形框，带有粗黑边框和轻微阴影效果，
// 表示一个抽象的量子门操作。 内部标注文字：“\tilde{MS}_{
// 01}(θ,φ)”，其中“~”位于“MS”上方，下标“01”表示作用于|0⟩
// 与|1⟩构成的二能级子空间，“(θ,φ)”为两个参数。 输入/输出
// 线：左右两侧各有两条水平黑色直线，代表两个量子比特（或
// 两能级系统）的输入与输出线路，上下对齐。 中间部分： 一
// 个标准的数学等号“=”，连接左侧抽象门与右侧具体实现电路。
// 右侧部分： 子图类型：示意图（量子电路图），包含多个串
// 联门操作。 布局结构：分为上下两条平行量子线路，每条线
// 路依次经过三个粉色矩形门块，共六个门块，按顺序排列。
// 第一个门块（最左侧）： 类型：黄色填充、圆角矩形，带粗
// 黑边框，与左侧符号样式一致。 标注文字：“MS_{01}(θ,φ)”，
// 无波浪线，表示基础MS门。 位置：横跨上下两条线路，表明
// 这是一个双比特纠缠门。 后续门块（共三组，每组上下各一）：
// 类型：粉色填充、直角矩形，带粗黑边框，表示单比特Z旋转
// 门。 第一组（紧邻MS门右侧）： 上线路门标注：“Z_{01}(-θ
// /4)” 下线路门标注：“Z_{01}(-θ/4)” 含义：对每个量子比特
// 施加绕Z轴旋转角度为-θ/4的操作，作用于01子空间。 第二组
// （中间）： 上线路门标注：“Z_{12}(-θ/2)” 下线路门标注：
// “Z_{12}(-θ/2)” 含义：对每个量子比特施加绕Z轴旋转角度为
// -θ/2的操作，作用于12子空间（即涉及能级|1⟩与|2⟩的耦合项）。
// 第三组（最右侧）： 上线路门标注：“Z_{23}(-θ/4)” 下线路
// 门标注：“Z_{23}(-θ/4)” 含义：对每个量子比特施加绕Z轴旋
// 转角度为-θ/4的操作，作用于23子空间（即涉及能级|2⟩与|3⟩
// 的耦合项）。 所有门块之间通过水平黑线连接，形成串行电
// 路结构。 最终输出：两条水平黑线从最后一个门块向右延伸，
// 表示电路结束。 图中传达的趋势或结论： 该图说明，在一个
// 四能级系统中，若要在01子空间上实现一个相位补偿的MS门（
// 记作\tilde{MS}_{01}），其等效电路可由一个基础MS门后接
// 一系列特定角度的Z旋转门构成。这些Z旋转门分别针对不同的
// 能级子空间（01、12、23）进行相位校正，以消除高阶能级带
// 来的非理想相位积累。对于其他维度的qudit系统，类似分解
// 方法同样适用。所有旋转角度均与原始MS门参数θ成比例关系，
// 且对称地应用于两个量子比特线上。
#figure(image("imgs/qudit_MS_phasecorrected.png", width: 60%),
  caption: [
    Phase-compensated MS gate on the 01-qubit subspace in a 4-level system. For qudits with other dimensions, the procedure is similar.
  ]
)
<fig:Supp:phasecorrectedMS>



== Decomposition of the C#smallcaps[EX] gate
<decomposition-of-the-operatornamecmathrmex-gate>
Using this phase-compensated gate, we now construct the most basic qudit gate, an embedded $"Cnot"$ gate acting on some two-level subspace of two qudits. We denote this gate a controlled-exchange $"Cex"$ gate. A key observation at this point is that the (phase-compensated) MS gate acts non-trivially if and only if both qudits are within the correct two-level subspace. As soon as one qudit is outside this subspace, the gate acts as the identity operation. As a consequence, the standard transformation between MS- and $"Cnot"$-gate cannot be used for our purpose, since it involves local operations that do not correspond to a basis change. Hence in the cases where one of the qudits is outside the addressed subspace and the MS-gate acts as the identity, we are left with undesired local rotations, which effectively induce $sqrt("Cnot")$-type couplings.


We overcome this problem by exploiting spectroscopic decoupling to turn the MS-gate directly into a controlled-$"R" ( theta , phi.alt )$-rotation. First, rotating the #emph[control] ion into the eigenbasis of the MS-gate, the gate imparts a conditional local operation on the #emph[target] ion as


$ ( "R"_(0 , 1) ( pi / 2 , phi.alt + pi / 2 ) ⊗ bb(1) ) dot.op tilde("MS")_(0 , 1) ( theta , phi.alt ) dot.op ( "R"_(0 , 1) ( pi / 2 , phi.alt - pi / 2 ) ⊗ bb(1) ) & =\
e^(- upright(i) theta / 2) (| 0 chevron.r chevron.l 0 | ⊗ "R"_(0 , 1) ( - theta , phi.alt ) + | 1 chevron.r chevron.l 1 | ⊗ "R"_(0 , 1) ( theta , phi.alt )) & , $<eq:Supp:MSdecoupled>


and identity on all other qudit states. Second, we need to drop the unwanted rotation in case the control ion is in state $| 0 chevron.r$, which, as before, cannot be done using local operations. We achieve this, by decoupling the state $| 0 chevron.r$ of the control ion from the interaction by transferring it to an auxiliary qudit level $| a chevron.r$, see @fig:Supp:MScrot. Using this decomposition, a $"Cex"$-gate on any two-level subspace of a qudit can be achieved using one $"MS" ( pi )$ gate, compared to one $"MS" ( pi / 2 )$ gate required for the standard qubit decomposition.


// [figvision-cn] imgs/qudit_MS_controlledRot.png
// 该图展示了一个量子逻辑门（MS-gate）通过局部基变换和光
// 谱解耦技术被转化为受控旋转门的等效电路分解过程。图像整
// 体分为左右两部分，由一个等号连接，左侧为原始简化电路，
// 右侧为展开后的详细脉冲序列电路。 子图a（左侧部分）：
// 类型：量子电路图。 布局：包含两条平行的水平实线，代表
// 两个量子比特（qubit），上方为控制比特，下方为目标比特。
// 在两条线之间有一个垂直连接线，从上方比特的某点引出一个
// 实心黑点（表示控制端），连接到下方比特上的一个矩形框（
// 表示目标操作）。 符号与标注：下方矩形框内标注文字“R₀₁(
// θ,φ)”，表示这是一个作用于第0和第1个能级之间的旋转门，
// 参数为角度θ和相位φ。整个左侧结构代表一个受控的R₀₁旋转
// 门。 子图b（右侧部分）： 类型：量子电路图（脉冲序列展
// 开形式）。 布局：同样包含两条平行水平实线，代表相同的
// 两个量子比特。沿时间轴从左到右依次排列五个矩形模块，每
// 个模块对应一个特定的量子操作或状态阶段。各模块之间用虚
// 线分隔，并标注了相应的物理意义。 坐标轴：无显式坐标轴，
// 但隐含的时间轴从左至右推进。 模块详情（从左到右）： 第
// 一个模块：青绿色填充矩形，位于下方比特线上，标注“R₀ₐ(π
// , π/2)”。表示对第0与辅助态a之间施加一个幅度为π、相位为
// π/2的旋转门。 第二个模块：粉红色填充矩形，位于下方比特
// 线上，标注“R₀₁(π/2, φ - π/2)”。表示对第0与第1能级间施
// 加幅度为π/2、相位为φ−π/2的旋转门。此模块右侧有一条垂直
// 虚线，上方标注“Decouple 1st state”，表示在此时刻开始对
// 第一激发态进行解耦处理。 第三个模块：黄色填充圆角矩形，
// 横跨上下两条比特线，标注“~MS₀₁(θ,φ)”（波浪线表示近似或
// 有效门）。这是核心的Mølmer-Sørensen门，作用在两比特上，
// 参数仍为θ和φ。其左右两侧均有垂直虚线，左侧标注“
// Eigenbasis”，右侧也标注“Eigenbasis”，表明该门是在本征
// 基下执行的。 第四个模块：粉红色填充矩形，位于下方比特
// 线上，标注“R₀₁(π/2, φ + π/2)”。表示再次对第0与第1能级
// 间施加幅度为π/2、相位为φ+π/2的旋转门。 第五个模块：青
// 绿色填充矩形，位于下方比特线上，标注“R₀ₐ(π, -π/2)”。表
// 示对第0与辅助态a之间施加一个幅度为π、相位为-π/2的旋转
// 门。其右侧有一条垂直虚线，上方标注“Recouple 1st state”，
// 表示在此时刻重新耦合第一激发态。 所有模块均仅作用于下
// 方比特线，除了中间的MS门同时作用于两比特。虚线作为时间
// 标记，标示了解耦、本征基转换和再耦合的关键节点。 结论
// 传达：该图说明，原本复杂的受控R₀₁门可以通过一系列单比
// 特旋转门（R₀ₐ和R₀₁）夹着一个标准的MS门来实现，且整个过
// 程涉及在特定时刻切换至本征基并对中间态进行解耦与再耦合，
// 从而实现对MS门的有效调控，使其表现为一个可控的旋转门。
// 这种分解方案适用于实验实现中需要精确控制多体相互作用的
// 情形。
#figure(image("imgs/qudit_MS_controlledRot.png", width: 85%),
  caption: [
    Turning the MS-gate into a controlled rotation by a combination of local basis transformation and spectroscopic decoupling.
  ]
)
<fig:Supp:MScrot>



== Decomposition of the C#smallcaps[INC] gate
<decomposition-of-the-operatornamec_inc-gate>
As the qudit generalization of the $"Cnot"$-gate, the $"Cinc"$-gate is a qudit $"X"$ operation, controlled on the state $| d chevron.r$ of the control qudit. In the case $d = 3$, we have $"X"_3 = "R"_(0 , 1) ( pi , pi / 2 ) dot.op "R"_(1 , 2) ( pi , pi / 2 )$. Using the above strategy, we replace the local rotations in the decomposition of $"X"_3$ by the controlled rotations of @fig:Supp:MScrot. For experimental convenience, we use additional local $pi$-pulses to implement all $"MS"$-gate operations in the $( 0 , 1 )$-subspace. Finally, we replace the phase-corrected $tilde("MS")$-gates by standard $"MS"$-gates and absorb the remaining phase shifts, where possible as frame-rotations of the local gates, see @fig:supp:cinc. This decomposition achieves a $d$-dimensional $"Cinc"$ gate, using $2 ( d - 1 )$ pairwise fully entangling gates, see @fig:supp:cinc.


// [figvision-cn] imgs/qutrit_Cinc_decomposition.png
// 这是一张展示三能级系统（qutrit）量子门分解为二能级操作
// 的流程图，包含两个子图 a) 和 b)。 子图 a) 类型：时序流
// 程图。 布局：图像由两条平行的水平黑线构成时间轴，代表
// 系统的两个跃迁通道。一系列带有圆角的彩色矩形块沿时间轴
// 从左到右排列，代表按顺序执行的量子操作。垂直的虚线将流
// 程划分为不同的阶段。 左侧起始部分： 上方轨道有一个深蓝
// 色矩形，标注为 R_12(π, π/2)。 紧接着是一个青色矩形，标
// 注为 R_03(π, π/2)。 此时出现第一条垂直虚线，上方标注文
// 字 "Close control"。 中间第一阶段： 上方轨道有一个浅粉
// 色矩形，标注为 R_01(π/2, π)。 下方轨道对应位置有一个深
// 蓝色矩形，标注为 R_12(π, π/2)。 接着出现第二条垂直虚线，
// 上方标注文字 "Decouple 2-state"。 中间第二阶段： 上方
// 轨道有一个黄色矩形，标注为 MS~_01 (π, π/2)，其中MS上方
// 有波浪线符号。 紧接着上方轨道有一个浅粉色矩形，标注为
// R_01(π/2, 0)。 下方轨道对应位置有一个深蓝色矩形，标注
// 为 R_12(π, -π/2)。 接着出现第三条垂直虚线，上方标注文
// 字 "Flip 1-2"。 中间第三阶段： 上方轨道有一个浅粉色矩
// 形，标注为 R_01(π/2, π)。 紧接着上方轨道有一个黄色矩形，
// 标注为 MS~_01 (π, π/2)，其中MS上方有波浪线符号。 接着
// 出现第四条垂直虚线，上方标注文字 "Flip 0-1"。 右侧结束
// 阶段： 上方轨道有一个青色矩形，标注为 R_03(π, -π/2)。
// 紧接着上方轨道有一个深蓝色矩形，标注为 R_12(π, -π/2)。
// 最后出现第五条垂直虚线，上方标注文字 "Recouple 2-state
// "。 颜色编码说明：深蓝色块代表作用于 1-2 跃迁的操作；
// 青色块代表作用于 0-3 跃迁的操作；浅粉色块代表作用于
// 0-1 跃迁的操作；黄色块代表 Mølmer-Sørensen (MS) 类型的
// 纠缠操作。 子图 b) 类型：时序流程图。 布局：与子图 a)
// 类似，由两条平行的水平黑线构成，排列着彩色的矩形操作块。
// 此子图展示了另一种等效或简化的操作序列。 左侧起始部分：
// 上方轨道依次排列三个矩形：深蓝色 R_12(π, π/2)、青色
// R_03(π, π/2)、浅粉色 R_01(π/2, π)。 下方轨道在浅粉色块
// 对应位置有一个深蓝色矩形 R_12(π, π/2)。 中间部分： 上
// 方轨道有一个黄色矩形，标注为 MS_01 (π, π/2)。 下方轨道
// 对应位置有一个深蓝色矩形，标注为 R_12(π, 7π/4)。 随后
// 上方轨道出现第二个黄色矩形，标注为 MS_12 (π, π/2)。 右
// 侧结束部分： 上方轨道依次排列三个矩形：浅粉色 R_01(π/2
// , 0)、青色 R_03(π, 3π/4)、深蓝色 R_12(π, 3π/4)。 下方
// 轨道在最右侧有一个绿色矩形，标注为 Z_03(π)。 颜色编码
// 说明：与子图 a) 一致，深蓝色、青色、浅粉色分别对应不同
// 跃迁的单比特旋转门，黄色对应双比特 MS 门，绿色对应相位
// 门。
#figure(image("imgs/qutrit_Cinc_decomposition.png", width: 49%),
  caption: [
    #strong[Decomposition of a qutrit $"Cinc"$-gate into two-level operations.] Operations acting on different transitions are color-coded as a visual guide. #strong[a)] Simple decomposition into controlled rotations using phase-compensated MS-gates. #strong[b)] Fully compiled decomposition where phase-gates have been absorbed into frame-changes of the local operations. One remaining $"Z"$ operation is performed in the standard Euler-decomposition as $"Z"_(2 , 3) ( theta ) = "R"_(2 , 3) ( pi / 2 , - pi / 2 ) dot.op "R"_(2 , 3) ( theta , 0 ) dot.op "R"_(2 , 3) ( pi / 2 , pi / 2 )$.
  ]
)
<fig:supp:cinc>






= QUDIT TOMOGRAPHY
<qudit-tomography>
In order to reconstruct qudit states and processes, we employ a semi-definite programming approach that is independent of the underlying dimension and compatible with any (potentially incomplete) set of experimental data. For the sake of simplicity, we start with state tomography and outline the straightforward generalization to process tomography later.


Following the notation of Ref.~@Ringbauer2015, let $cal(X)_d tilde.equiv bb(C)^d$ be a $d$-dimensional complex Hilbert space, and $D ( cal(X)_d )$ the set of density matrices on $cal(X)_d$. We perform measurements using a set of projectors ${ Pi_i }_(i = 1)^K$, where $Pi_i = | psi_i chevron.r chevron.l psi_i |$ to reconstruct an unknown qudit state $sigma in D ( cal(X)_d )$. The probability for observing a click for projector $Pi_i$ when the qudit state $sigma$ was prepared is then given by


$ p_i = "Tr" [Pi_i sigma] = chevron.l chevron.l Pi_i | sigma chevron.r chevron.r . $<eq:ProbsQST>


Here $| sigma chevron.r chevron.r = sum_(i , j = 0)^(d - 1) sigma_(i , j) | j chevron.r ⊗ | i chevron.r$ denotes the column vector obtained by stacking the columns of the operator $sigma$. We now define the vector of observed frequencies $| f chevron.r$, the quadratic form $S$, and the weight matrix $W$ as follows:


$ | f chevron.r = sum_(i = 1)^K frac(n_j + beta, N_j + d beta) | i chevron.r #h(2em) #h(2em) S = sum_(i = 1)^K | i chevron.r chevron.l chevron.l Pi_i | #h(2em) #h(2em) W = sum_(i = 1)^K sqrt(frac(N_i, f_i ( 1 - f_i ))) | i chevron.r chevron.l i | , $<eq:TomoDefsQST>


where $N_j$ is the number of measurement runs in which projector $Pi_j$ was measured, and $n_j$ is the number of observed counts. The weight matrix $W$ takes into account the multinomial distribution of the observed frequencies, and $beta$ is an optional hedging parameter, typically set to $beta tilde 0.5$ to avoid probabilities of 0 or 1 @Ferrie2012Hedged. Using this, we can now perform a maximum likelihood reconstruction of the state $sigma$ by solving the following convex optimization problem


$  & upright("minimize") quad parallel W ( S | sigma chevron.r chevron.r - | f chevron.r ) parallel_2\
 & upright("subject to: ") quad sigma gt.eq 0 , "Tr" \[ sigma \] = 1 . $<eq:MLEopt>


Experimentally, an informationally complete set of the projectors ${ Pi_i }_(i = 1)^K$ is constructed by combining several orthonormal bases of the Hilbert space. In the case $d = 2$ these are the given by the three Pauli operators. In larger dimensions, we similarly construct them out of pair-wise superpositions, as these are most convenient experimentally. For $d = 3$ we have, for example, 6 bases, defined by the following collection of pure states (or projectors):


$  & ( ( | 0 chevron.r + i | 1 chevron.r ) / sqrt(2) , ( | 0 chevron.r - i | 1 chevron.r ) / sqrt(2) , | 2 chevron.r ) ,\
 & ( ( | 0 chevron.r + | 1 chevron.r ) / sqrt(2) , ( | 0 chevron.r - i | 1 chevron.r ) / sqrt(2) , | 2 chevron.r ) ,\
 & ( ( | 0 chevron.r + i | 2 chevron.r ) / sqrt(2) , | 1 chevron.r , ( | 0 chevron.r - i | 2 chevron.r ) / sqrt(2) ) ,\
 & ( ( | 0 chevron.r + | 2 chevron.r ) / sqrt(2) , | 1 chevron.r , ( | 0 chevron.r - | 2 chevron.r ) / sqrt(2) ) ,\
 & ( ( | 1 chevron.r + i | 2 chevron.r ) / sqrt(2) , | 0 chevron.r , ( | 1 chevron.r - i | 2 chevron.r ) / sqrt(2) ) ,\
 & ( ( | 1 chevron.r + | 2 chevron.r ) / sqrt(2) , | 0 chevron.r , ( | 1 chevron.r - | 2 chevron.r ) / sqrt(2) ) , $<eq:QutritBasis>


In the case of quantum process tomography, we aim to reconstruct the Choi operator $Lambda_(cal(E))$ of a quantum process $cal(E)$, such that


#set math.equation(numbering: none)
$ cal(E) ( rho ) = "Tr"_1 [ ( rho_i^T ⊗ bb(1)_(cal(X)_2) ) Lambda_(cal(E)) ] . $
#set math.equation(numbering: n => "(S" + str(n) + ")")


This is achieved by preparing an informationally complete set of input states ${ rho_i }_(i = 1)^K$ and for each of them measuring an informationally complete set of projectors ${ Pi_j }_(j = 1)^K$. In practice, we chose these two sets to be the same. The probability for observing a click for projector $Pi_j$ when the state $rho_i$ was subject to the process $cal(E)$ is then given by


$ p_(i j) = "Tr" [ Pi_j "Tr"_1 [ ( rho_i^T ⊗ bb(1) ) Lambda ] ] = "Tr" [ ( rho_i^T ⊗ Pi_j ) Lambda ] = chevron.l chevron.l Pi_(i j) | Lambda chevron.r chevron.r , $<eq:ProbsQPT>


where $Pi_(i j) equiv rho_i^(*) ⊗ Pi_j$. With this we straightforwardly generalize Eq.~#ref(<eq:TomoDefsQST>, supplement: none) as follows:


$ | f chevron.r = sum_(i , j = 1)^K frac(n_(i j) + beta, N_(i j) + d beta) | i , j chevron.r #h(2em) #h(2em) S = sum_(i , j = 1)^K | i , j chevron.r chevron.l chevron.l Pi_(i j) | #h(2em) #h(2em) W = sum_(i , j = 1)^K w_(i j) | i , j chevron.r chevron.l i , j | . $<eq:TomoDefsQPT>


Equation~#ref(<eq:MLEopt>, supplement: none) then becomes


$  & upright("minimize") quad parallel W ( S | Lambda_(cal(E)) chevron.r chevron.r - | f chevron.r ) parallel_2\
 & upright("subject to: ") quad Lambda_(cal(E)) gt.eq 0 , "Tr" \[ Lambda_(cal(E)) \] = d . $<eq:MLEoptQPT>


We performed quantum process tomography using Eq.~#ref(<eq:MLEoptQPT>, supplement: none) and the basis in Eq.~#ref(<eq:QutritBasis>, supplement: none) to reconstruct the single-qutrit Gell-Mann operators in @fig:Supp_LocalGM and single-qutrit Clifford in @fig:Supp_LocalClifford.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (center,left,center,left,),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.hline(stroke: 0.5pt),
    table.header(table.cell(align: center, colspan: 2)[Clifford + T], table.cell(align: center, colspan: 2)[Gell-Mann],),
    table.hline(stroke: 0.5pt),
    [$X_3$], [$cal(F) = 0.994_(- 0.001)^(+ 0.003)$], [$lambda_1$], [$cal(F) = 0.986_(- 0.001)^(+ 0.006)$],
    [$Z_3$], [$cal(F) = 0.952_(- 0.017)^(+ 0.013)$], [$lambda_2$], [$cal(F) = 0.992_(- 0.001)^(+ 0.003)$],
    [$S_3$], [$cal(F) = 0.968_(- 0.012)^(+ 0.011)$], [$lambda_3$], [$cal(F) = 0.967_(- 0.004)^(+ 0.017)$],
    [$H_3$], [$cal(F) = 0.945_(- 0.015)^(+ 0.011)$], [$lambda_4$], [$cal(F) = 0.989_(- 0.002)^(+ 0.004)$],
    [$T_3$], [$cal(F) = 0.994_(- 0.016)^(+ 0.001)$], [$lambda_5$], [$cal(F) = 0.970_(- 0.001)^(+ 0.012)$],
    [], [], [$lambda_6$], [$cal(F) = 0.991_(- 0.002)^(+ 0.004)$],
    [], [], [$lambda_7$], [$cal(F) = 0.985_(- 0.001)^(+ 0.008)$],
    [], [], [$lambda_8$], [$cal(F) = 0.960_(- 0.006)^(+ 0.016)$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [#strong[Fidelities for single qutrit gates]. Fidelities are estimated from quantum process tomography without SPAM correction. The uncertainties correspond to $1 sigma$ statistical uncertainty from quantum projection noise, estimated using MonteCarlo resampling.]
  , kind: table
  )
<tab:single_qudit_results>



= SINGLE-QUTRIT RESULTS
<single-qutrit-results>


// [figvision-cn] imgs/LocalGatesCliff.png
// 本图包含三个子图 (a)、(b) 和 (c)，展示了单三能级量子比
// 特（qutrit）的Clifford门及非Clifford门的实验重构Choi算
// 符。 子图 (a)： 类型：三维柱状图，展示相位信息。 坐标
// 轴：X轴和Y轴构成一个3x3的网格平面，刻度标签为00, 01,
// 02, 10, 11, 12, 20, 21, 22，对应Choi态矩阵的索引。Z轴
// 未标注数值范围，但代表幅值或概率分布的相对大小。 色标：
// 右侧垂直颜色条标记为“Phase”（相位），范围从-π到π。颜色
// 渐变顺序为：红色（-π）、黄色、绿色（0）、青色、蓝色（π
// /2）、紫色（π）。 数据特征：图中包含9个立方体柱（对应
// 3x3网格），高度一致且较低。所有柱体的颜色主要分布在蓝
// 绿色至深蓝色区域，表明其相位值集中在π/2附近。 结论：该
// 图表示Clifford门的Choi算符具有均匀的幅度分布和特定的相
// 位特性。 子图 (b)： 类型：三维柱状图，展示相位信息。
// 坐标轴：与子图(a)相同，X轴和Y轴为3x3网格（00-22）。 色
// 标：与子图(a)相同，范围-π到π。 数据特征：图中9个柱体的
// 高度呈现显著差异，部分柱体较高（如位于01, 11, 21位置的
// 柱体），部分较矮。颜色分布多样，高柱体多为深蓝色（相位
// 接近π），低柱体或背景网格中可见红色（相位接近-π）和绿
// 色（相位接近0）。 结论：该图表示另一个Clifford门的Choi
// 算符，其幅度分布不均匀，相位在网格不同位置表现出明显的
// 变化。 子图 (c)： 类型：三维柱状图，展示相位信息。 坐
// 标轴：与子图(a)和(b)相同，X轴和Y轴为3x3网格（00-22）。
// 色标：与子图(a)和(b)相同，范围-π到π。 数据特征：图中9
// 个柱体的高度同样呈现不均匀分布，具体高低模式与子图(b)
// 略有不同。颜色涵盖了整个色谱范围，包括深蓝色（π）、绿
// 色（0）和红色（-π），显示出复杂的相位结构。 结论：该图
// 表示非Clifford门（T门）的Choi算符，其相位分布比
// Clifford门更为复杂，体现了非Clifford操作的独特性质。
#figure(image("imgs/LocalGatesCliff.png", width: 100%),
  caption: [
    #strong[Single qutrit Clifford + T gate set]. Shown are experimentally reconstructed Choi operators corresponding to the Clifford gates #strong[\(a)] $H_3$ and #strong[\(b)] $S_3$, as well as the non-Clifford gate #strong[\(c)] $T_3$.The fidelities are given in Tab.~#ref(<tab:single_qudit_results>, supplement: none).
  ]
)
<fig:Supp_LocalClifford>



// [figvision-cn] imgs/LocalGatesGM8.png
// 该图像包含八个子图，标记为(a)至(h)，以3行3列的网格布局
// 排列（右下角位置为空）。每个子图均为三维柱状图，用于可
// 视化单个三能级量子比特（qutrit）的8个盖尔曼算符（
// Gell-Mann operations）对应的实验重构丘伊算符（Choi
// operators）的实部。 所有子图共享相同的坐标轴结构和颜色
// 映射方案： 水平面由两个轴构成，分别标记为“0”、“1”、“2”，
// 代表丘伊算符在计算基下的矩阵元索引（行和列），范围从0
// 到2。 垂直轴标记为“Re(ρ)”，表示丘伊算符矩阵元的实部数
// 值，刻度范围从-1到1。 每个子图右侧均有一个垂直颜色条（
// colorbar），标记为“Phase”，其颜色从蓝色（对应相位0）经
// 绿色、黄色过渡到红色（对应相位π），但根据图注说明，此
// 颜色条实际用于表示复数相位的视觉编码；然而，在当前图中，
// 柱体高度直接反映实部大小，而柱体颜色似乎与相位相关——具
// 体而言，正实部柱体多为蓝色或青色，负实部柱体多为红色或
// 品红，表明颜色可能同时编码符号与相位信息。但根据标准解
// 释，此处更可能是：柱高=实部值，颜色=相位角（0到π之间线
// 性映射）。不过观察图形，多数柱体颜色集中在蓝绿（小相位）
// 和红（大相位），暗示颜色确实编码相位，而高度编码实部幅
// 度。 逐个子图描述如下： (a) 三维柱状图，显示第一个盖尔
// 曼算符对应的丘伊算符实部分布。在3x3网格上，部分位置有
// 显著高度的柱体：例如(0,1)、(1,0)处有高蓝色柱（正值），
// (0,2)、(2,0)处有中等高度青色柱，(1,2)、(2,1)处有低矮绿
// 色柱，其余位置接近零。整体呈现非对角占优结构，符合σ₁类
// 算符特征。 (b) 三维柱状图，显示第二个盖尔曼算符对应的
// 丘伊算符实部分布。主要柱体位于对角线附近：(0,0)、(1,1)、
// (2,2)处有较高红色柱（负值？需结合颜色判断），其中(1,1)
// 最高，呈深红色；其他位置如(0,1)、(1,0)等也有中等高度红
// 色柱。整体对称性较强，符合σ₂类算符特征。 (c) 三维柱状
// 图，显示第三个盖尔曼算符对应的丘伊算符实部分布。柱体分
// 布在多个位置：(0,0)和(2,2)处有高绿色柱（正值），(1,1)
// 处有中等高度青色柱，(0,2)、(2,0)处有低矮蓝色柱，(1,2)、
// (2,1)处有红色柱（负值）。结构不对称，体现σ₃类算符特性。
// (d) 三维柱状图，显示第四个盖尔曼算符对应的丘伊算符实部
// 分布。主要柱体位于非对角区域：(0,1)、(1,0)处有高蓝色柱，
// (0,2)、(2,0)处有中等高度青色柱，(1,2)、(2,1)处有绿色柱，
// 对角线元素几乎为零。符合σ₄类算符（类似泡利X在三能级扩
// 展）的特征。 (e) 三维柱状图，显示第五个盖尔曼算符对应
// 的丘伊算符实部分布。柱体集中于对角线：(0,0)和(2,2)处有
// 高红色柱（负值），(1,1)处有中等高度红色柱，非对角元素
// 较小且多为蓝色或青色。符合σ₅类算符（类似泡利Z在三能级
// 扩展）的特征。 (f) 三维柱状图，显示第六个盖尔曼算符对
// 应的丘伊算符实部分布。柱体分布广泛：(0,1)、(1,0)处有高
// 青色柱，(0,2)、(2,0)处有中等高度绿色柱，(1,2)、(2,1)处
// 有蓝色柱，对角线元素接近零。符合σ₆类算符特征。 (g) 三
// 维柱状图，显示第七个盖尔曼算符对应的丘伊算符实部分布。
// 柱体主要集中在对角线及相邻非对角：(0,0)、(1,1)、(2,2)
// 处有高红色柱，(0,1)、(1,0)处有中等高度红色柱，其他位置
// 较低。符合σ₇类算符特征。 (h) 三维柱状图，显示第八个盖
// 尔曼算符对应的丘伊算符实部分布。柱体分布较分散：(0,0)
// 和(2,2)处有高蓝色柱，(1,1)处有中等高度青色柱，(0,2)、(
// 2,0)处有绿色柱，(1,2)、(2,1)处有红色柱。符合σ₈类算符（
// 迹零对角算符）的特征。 总体趋势：八个子图共同展示了三
// 能级系统中盖尔曼算符作为基底时，其对应丘伊算符的实验重
// 构结果。每个子图的柱状图形态反映了相应算符在希尔伯特空
// 间中的矩阵结构，颜色编码相位信息，高度编码实部幅值。这
// 些重构结果可用于评估量子门操作的保真度（具体数值见文中
// 表格），并验证理论预测与实验的一致性。
#figure(image("imgs/LocalGatesGM8.png", width: 100%),
  caption: [
    #strong[Single qutrit Gell-Mann operations]. Shown are experimentally reconstructed Choi operators corresponding to the 8 Gell-Mann operations forming the basis for the qutrit Hilbert space. The fidelities are given in Tab.~#ref(<tab:single_qudit_results>, supplement: none).
  ]
)
<fig:Supp_LocalGM>