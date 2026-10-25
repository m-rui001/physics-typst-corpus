#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)

#align(center)[
  #text(17pt, weight: "bold", [A universal qudit quantum processor with trapped ions])
  #v(1em)
  #text(10.5pt)[Martin Ringbauer, Michael Meth, Lukas Postler, Roman Stricker, Rainer Blatt, Philipp Schindler, Thomas Monz]
]
#v(1em)

#text(9.5pt)[*Abstract.* Today's quantum computers operate with a binary encoding that is the quantum analog of classical bits. Yet, the underlying quantum hardware consists of information carriers that are not necessarily binary, but typically exhibit a rich multilevel structure, which is artificially restricted to two dimensions. A wide range of applications from quantum chemistry to quantum simulation, on the other hand, would benefit from access to higher-dimensional Hilbert spaces, which conventional quantum computers can only emulate. Here we demonstrate a universal qudit quantum processor using trapped ions with a local Hilbert space dimension of up to 7. With a performance similar to qubit quantum processors, this approach enables native simulation of high-dimensional quantum systems, as well as more efficient implementation of qubit-based algorithms.]


Quantum information processing (QIP) successfully builds on the paradigm of binary information processing that has fueled classical computers for decades. Quantum bits, just like their classical counterparts, are two-level systems with basis states labelled $\| 0 chevron.r$ and $\| 1 chevron.r$. The underlying physical systems, however, almost always consist of higher-dimensional Hilbert spaces that need to be artificially restricted to fit our binary paradigm. This multi-level structure presents a powerful resource for QIP. Using auxiliary levels as a cache memory for quantum information has enabled the implementation of highly complex quantum algorithms~@Martinez2016 and dissipative processes~@Schindler2013, as well as improved decomposition of multi-qubit gates~#cite(<Lanyon2008>). Yet, experimental realizations in various platforms are limited to proof-of-concept demonstrations~@Senko2015@Ahn2000@Godfrin2017@Anderson2015@Morvan2020#cite(<Hu2018a>). Featuring a much richer coherence~@Ringbauer2017 and entanglement structure~@Kraft2018 than their binary counterpart, combined with higher noise resilience~@Cozzolino2019 makes #emph[qudits] (quantum decimal digits) a prime candidate for the next generation of quantum devices.

Here we demonstrate a universal qudit trapped-ion quantum processor (TIQP) using of the native multilevel structure of trapped chains of $""^40$Ca$""^(+)$ ions. Building on the native interactions in the trapped-ion platform, we implement a universal gate set for qudit QIP at a performance approaching that of comparable qubit systems. We further introduce a scalable detection scheme that allows for full qudit readout and develop composite pulse techniques for cross-talk compensation.

Our quantum processor uses a string of $""^40$Ca$""^(+)$ ions in a linear Paul trap~#cite(<Schindler2013>). Quantum information is encoded in the $S_(1 / 2)$ electronic ground state and the metastable $D_(5 / 2)$ excited state which has a lifetime of $tau_1 tilde.op 1.1 med s$, see Fig.~@fig.levelscheme. Two sets of permanent magnets generate a magnetic field on the order of $4 med G$, which splits the ground state into two Zeeman sublevels ($m = plus.minus 1 / 2$) and the excited state into six Zeeman sublevels ($m = plus.minus 5 / 2 , plus.minus 3 / 2 , plus.minus 1 / 2 )$, with a splitting of several MHz. This gives rise to 10 allowed transitions due to the selection rules $Delta m = 0 , plus.minus 1 , plus.minus 2$, with the coupling strength controlled by the laser polarization and the orientation of the magnetic field. These transitions differ in their sensitivity to magnetic field fluctuations by up to a factor of 5, such that optical qubits are typically encoded in the least sensitive states $\| 0 chevron.r = S_(1 / 2 , - 1 / 2)$, $\| 0 chevron.r = D_(5 / 2 , - 1 / 2)$. However, with magnetic shielding, spin coherence times on the order of $100 med m s$, which is at least 3 orders of magnitude larger than typical gate times, can be achieved for all transitions. Each $""^40$Ca$""^(+)$ ion therefore natively supports a #emph[qudit] with 8 levels, featuring a highly connected Hilbert space, see Fig.~@fig.levelscheme.

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
#figure(image("imgs/FigTransitions.png"),
  caption: [
    #strong[Level scheme of the $""^40$Ca$""^(+)$ ion.] Quantum information is encoded in the $S_(1 / 2)$ and $D_(5 / 2)$ states, where each transition between S and D is accessible using a single narrowband laser at 729nm.
  ],
  placement: top,
)
<fig.levelscheme>

Ions are initialized close to the electronic and motional ground state by optical pumping and a combination of Doppler cooling, polarization-gradient cooling~@Joshi2020, and resolved sideband cooling~#cite(<Schindler2013>). The native operations available in the TIQP are equatorial rotations on any S-D transition: \$\$\\begin{equation}
\\R^{i,j}(\\theta,\\phi)= \\exp(-i \\theta \\sigma\_\\phi^{i,j}/2) , 
\\label{eq:localOps}
\\end{equation}\$\$ where $theta$ denotes the rotation angle, \$\\sigma\_\\phi^{i,j} = (\\cos{(\\phi)}{\\sigma\_\\textsc{x}}^{i,j}\\pm\\sin{(\\phi)}{\\sigma\_\\textsc{y}}^{i,j})\$ for Pauli matrices \$\\sigma\_\\textsc{x},\\sigma\_\\textsc{y},\\sigma\_\\textsc{z}\$, and $i , j$ indicate the addressed transition according to Fig.~@fig.levelscheme. Note, that the phase rotation for $phi.alt$ in $sigma_phi.alt^(i , j)$ is positive (negative) when $\| i chevron.r$ ($\| j chevron.r$) is in the S-manifold (i.e.~lower energy). The rotations of Eq.~#link(<eq:localOps>)[[eq:localOps]] enable arbitrary $"SU" ( 2 )$ operations and are thus universal for qubit quantum computing~@Barenco1995 when combined with a two-qubit entangling operation such as the Mølmer-Sørensen gate~#cite(<Molmer1999>). \$\$\\begin{equation}
\\ms^{i,j}(\\theta,\\phi) = \\exp\\left(-\\frac{i\\theta}{4} \\left(\\sigma\_\\phi^{i,j}\\otimes\\mathds 1 + \\mathds 1\\otimes \\sigma\_\\phi^{i,j}\\right)^2 \\right) .
\\label{eq:entOps}
\\end{equation}\$\$ This interaction is achieved by coupling the internal degrees of freedom of the ions to the common motion in the trap using a bichromatic light field. Using multiple focused laser-beams, entangling-gate operations can also be performed on arbitrary subsets of ions in the string, see Supplementary Material (SM) for details. All operations can be performed with error rates below $1 %$ and at least 3 orders of magnitude faster than the coherence time of the system~#cite(<Bermudez2017>). Finally, the state of each ion is read out by electron shelving using the short-lived $S_(1 / 2) arrow.l.r P_(1 / 2)$ transition and detecting fluorescence on a CCD camera.

We now demonstrate how to extend the above platform to qudits up to dimension $7$ (one level remains unoccupied for readout). As for qubits, this requires arbitrary single qudit gates, supplemented with one two-qudit entangling gate~#cite(<Brennen2006>). For simplicity, we will focus primarily on $d = 3$ (qutrits) or $d = 5$ (ququints) and outline generalizations to other dimensions.

The set of local operations on a qudit is described by the group $"SU" ( d )$. In the case of a qutrit, the Lie algebra of $"SU" ( 3 )$ is spanned by the Gell-Mann matrices~@Gell-Mann1962, which are a natural generalization of the Pauli matrices from $"SU" ( 2 )$ to $"SU" ( 3 )$, with further generalizations towards $"SU" ( d )$. The Gell-Mann matrices are a set of traceless, Hermitian matrices, satisfying $"Tr" [ lambda_i lambda_j ] = 2 delta_(i j)$, where $delta_(i j)$ is the Kronecker delta:

$ lambda_1 & = mat(delim: "(", 0, 1, 0; 1, 0, 0; 0, 0, 0) , lambda_2 = mat(delim: "(", 0, - i, 0; i, 0, 0; 0, 0, 0) , lambda_3 = mat(delim: "(", 1, 0, 0; 0, - 1, 0; 0, 0, 0) ,\
lambda_4 & = mat(delim: "(", 0, 0, 1; 0, 0, 0; 1, 0, 0) , lambda_5 = mat(delim: "(", 0, 0, - i; 0, 0, 0; i, 0, 0) ,\
lambda_6 & = mat(delim: "(", 0, 0, 0; 0, 0, 1; 0, 1, 0) , lambda_7 = mat(delim: "(", 0, 0, 0; 0, 0, - i; 0, i, 0) , lambda_8 = 1 / sqrt(3) mat(delim: "(", 1, 0, 0; 0, 1, 0; 0, 0, - 2) . $<eq:QutritGellMann> Notably, one can identify three independent $"SU" ( 2 )$ sub-algebras: ${ lambda_1 , lambda_2 , lambda_3 }$, ${ lambda_4 , lambda_5 , ( lambda_3 + sqrt(3) lambda_8 ) / 2 }$, ${ lambda_1 , lambda_2 , ( - lambda_3 + sqrt(3) lambda_8 ) / 2 }$. This reflects the physical implementation in the trapped-ion platform via two-level couplings and makes the Gell-Mann operations a natural starting point for a qudit quantum processor.

Beyond basis operations, an important class of single-qudit gates is the Clifford group, as used in quantum error correction~#cite(<Gottesman1998>). Following Ref.~@Clark2006, we introduce generalized Pauli Z and X operations: $ Z_d & = omega_d^j \| j chevron.r chevron.l j \|\
X_d & = \| j + 1 " (mod ") d  chevron.r chevron.l j \| . $<eq:QutritPauliZ> with $omega_d = e^(frac(2 pi i, d))$ and ${ \| j chevron.r }_(j = 0)^(d - 1)$ denoting the computational basis in dimension $d$. These operations generate the $d$-dimensional analogue of the Pauli group, from which one constructs the $d$-dimensional Clifford group, with generators $ H_d & = 1 / sqrt(d) sum_(j , k) omega_d^(j k) \| k chevron.r chevron.l j \|\
S_d & = sum_j omega_d^(j ( j + 1 ) / 2) \| j chevron.r chevron.l j \| . $<eq:QutritClifford> Achieving universal single qudit operations requires not only Clifford gates, but also one additional non-Clifford gate. A popular choice for such a gate is the "$pi / 8$" or "T" gate~@Gottesman1998, which for qutrits is given by~@Howard2012 $ T_3 = mat(delim: "(", 1, 0, 0; 0, e^(frac(2 pi i, 9)), 0; 0, 0, e^(- frac(2 pi i, 9)) .) $<eq:QutritT> In our TIQP any single-qudit operation can be constructed from at most $cal(O) ( d^2 )$ two-level rotations of Eq.~#link(<eq:localOps>)[[eq:localOps]], via a decomposition into #emph[Givens rotations]~@Brennen2006, see SM for details. A notable challenge in qudit as compared to qubit QIP is that the elementary two-level operations lose their "global phase" gauge freedom. For example, a qubit Z rotation by an angle $theta$ can be understood as a phase shift $theta$ applied to $\| 1 chevron.r$, or equivalently as phase shifts $plus.minus theta / 2$ applied to $\| 0 chevron.r$ and $\| 1 chevron.r$, respectively. In the qudit case, this equivalence breaks down, because any phase shift is measured relative to the spectator level. In the SM we discuss how to overcome this technical challenge when decomposing qudit gates.

Experimentally, we demonstrate universal single-qutrit control in a multi-ion crystal by implementing the fundamental Gell-Mann rotations of Eq.~#link(<eq:QutritGellMann>)[[eq:QutritGellMann]], as well as the Clifford+T gate set of Eqs.#link(<eq:QutritPauliX>)[[eq:QutritPauliX]]-#link(<eq:QutritT>)[[eq:QutritT]]. Process tomography results for each of these operations are shown in the SM. In order to benchmark the performance of our single qudit operations in a way that is not limited by state-preparation-and-measurement (SPAM) errors, we perform randomized benchmarking of the qutrit and ququint Clifford operations~@Magesan2012, see Fig.~@fig:RB. For qutrits and ququints we obtain error rates per Clifford operation of $2 ( 2 ) dot.op 10^(- 3)$ and $1.0 ( 2 ) dot.op 10^(- 2)$, respectively. These numbers compare well against the thresholds for quantum error correction, which for qubits are as high as $tilde.op 1 %$~@Fowler2012 and are expected to improve further with qudit dimension~#cite(<Campbell2014>).

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
#figure(image("imgs/FigRB_comb.png"),
  caption: [
    #strong[Single qudit randomized benchmarking]. From the decay of the survival probability for increasingly long sequences of randomly chosen Clifford gate decompositions of identity, we estimate the average error per gate. For qutrits (blue data points) we obtain an average Clifford error rate of $2 ( 2 ) dot.op 10^(- 3)$ corresponding to an error rate of $2.0_(- 0.5)^(+ 0.8) dot.op 10^(- 4)$ per laser pulse. For ququints (orange data points), we obtain an average Clifford error rate of $1.0 ( 2 ) dot.op 10^(- 2)$, corresponding to an error rate of $3.2_(- 0.7)^(+ 0.8) dot.op 10^(- 4)$ per laser pulse. For each length we performed at least 20 random sequences (data points), with the median shown in red. The fits (blue and orange lines) and their $99 %$ confidence intervals (shaded regions) are shown as well.
  ],
  placement: top,
)
<fig:RB>

Completing the universal toolbox requires at least one qudit entangling gate. The most basic choice here is a two-level controlled-NOT (\$\\cnot\$) gate embedded in a qudit Hilbert space. We call this a controlled-exchange gate, \$\\cex\$, since it exchanges two states $\| t_1 chevron.r , \| t_2 chevron.r$ of the target qudit if and only if the control qudit is in state $\| c chevron.r$: \$\$\\begin{align}
\\cex\_{c,t\_1,t\_2} : \\begin{cases}
|c,t\_1\\rangle \\leftrightarrow |c,t\_2\\rangle \\\\
|j,k\\rangle \\rightarrow |j,k\\rangle  \\quad\\text{for \$j\\neq c, k\\neq t\_1,t\_2\$} .
\\end{cases}
\\label{eq:cex}
\\end{align}\$\$ A slightly generalized version of the \$\\cex\$ is the controlled-increment (\$\\cinc\$) gate~@Brennen2006, which increments the state of the target qudit by 1, if and only if the control qudit is in state $d - 1$: \$\$\\begin{equation}
\\cinc : \\begin{cases}
|j,k\\rangle \\rightarrow |j,k\\rangle  & \\text{if \$j\<d-1\$} \\\\
|j,k\\rangle \\rightarrow |j,k\\oplus 1\\rangle  & \\text{if \$j=d-1\$}
\\end{cases} ,
\\label{eq:cinc}
\\end{equation}\$\$ where $xor$ denotes addition modulo $d$. Other entangling gates, such as the controlled-sum gate (\$\\mathrm{C}\_{\\textsc{sum}}|i\\rangle|j\\rangle=|i\\rangle|j+i\\rangle\$) can be obtained from multiple applications of \$\\cinc\$ or \$\\cex\$.

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
#figure(image("imgs/FigCinc.png"),
  caption: [
    #strong[Qutrit entangling gates] #strong[(a)] Experimentally measured truth-table for a controlled-increment gate \$\\cinc\$. #strong[(b)] Fidelity decays for a \$\\cex\$ gate in a qutrit Hilbert space, and a qutrit \$\\cinc\$ gate with initial states $\| 0 + 1 chevron.r \| 0 chevron.r / sqrt(2)$ and $\| 0 + 2 chevron.r \| 0 chevron.r / sqrt(2)$, respectively. The data points correspond to the average of population and coherence at each gate length and the lines are exponential fits from which we extract the average fidelity values. Note that the different number of data points is due to the periodicity of 2 for the \$\\cex\$ gate and 3 for the \$\\cinc\$ gate.
  ],
  placement: top,
)
<fig:CincResults>

The most straight-forward way to implement two-qudit gates, which we follow here, is again to decompose them into two-level rotations per Eq.~#link(<eq:localOps>)[[eq:localOps]] and two-level MS gates per Eq.~#link(<eq:entOps>)[[eq:entOps]]. A crucial challenge here is again the "global" phase factor $exp ( upright("i") theta / 2 )$ of the MS gate, which imparts unwanted phases on spectator states, see SM for details and design considerations. In the case of the \$\\cex\$ gate we find a decomposition into 2 two-level MS gates independent of qudit dimension, and for the \$\\cinc\$ gate we require $2 d$ MS gates. Other two-qudit gates can be synthesized in a similar fashion. Alternatively, one could directly generalize the MS gate to a native qudit gate by driving multiple transitions simultaneously. This reduces the gate count, however, only at the cost of increased complexity of the classical control system and more challenging experimental calibration~#cite(<Low2020>).

Experimentally, we estimate the fidelity of the \$\\cex\$ and \$\\cinc\$ gates in a SPAM-free way by applying a sequence of entangling gates of increasing length to a fixed input state and measuring both the fraction of runs that end in the correct state (population) and the contrast of the resulting interference fringes (coherence), see Fig.~@fig:CincResults. Fitting the average of these values we obtain fidelity estimates of $cal(F) = 97.5 ( 2 ) %$ and $cal(F) = 93.8 ( 2 ) %$ for the \$\\cex\$ and \$\\cinc\$ gates, respectively.

The final challenge is qudit readout, which requires us to distinguish $d$ different states, whereas conventional fluorescence readout can only distinguish the S and D manifold. To circumvent this problem, we employ a sequential readout scheme. First, we shelve the $\| 2 chevron.r$ state to the D manifold (thus one of the 8 levels needs to remain unpopulated). Then we perform a standard fluorescence readout, which projects each ion in the string onto ${ \| 0 chevron.r #h(-1em) chevron.l 0 \| , bb(1) - \| 0 chevron.r #h(-1em) chevron.l 0 \| }$, allowing us to identify the $\| 0 chevron.r$ state without perturbing the rest. This is followed by a reordering pulse, which brings the state $\| 1 chevron.r$ into the S manifold and another fluorescence readout. This sequence is repeated until all ions are found in the "bright" state at some point in the readout sequence, which lets us assign a unique qudit quantum state to the string of ions. The readout time for this scheme increases only linearly in qudit dimension, see Fig.~@fig:readout(a).

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
#figure(image("imgs/FigDetectionSmall.png"),
  caption: [
    #strong[(a) Qudit readout] is achieved by successive electron shelving and scattering steps with interleaved recooling. #strong[(b) Qudit Readout pulse sequence.] #strong[(c) Qudit readout error.] Data points represent measured discrimination uncertainty between bright and dark states at a given measurement time. The solid blue line indicates the fit to this data with $99 %$ confidence regions in orange. The dotted blue line represents the error from spontaneous decay for two detections (qutrit), with $2500 mu s$ of PGC cooling between detections. The combined detection error in the worst case is given by the dashed black line, indicating an optimum of $3 dot.op 10^(- 3)$ for $tilde.op 500 mu s$ detection time.
  ],
  placement: top,
)
<fig:readout>

An additional challenge with longer strings of ions is scattering-induced heating of the ion crystal. This increases the error rate of subsequent reordering pulses and thereby contributes to detection errors. We counter this effect by applying broadband polarization-gradient cooling (PGC) between detection events, see Fig.~@fig:readout(b). This unavoidably increases the time required for a full readout, leading to a qutrit readout error of $tilde.op 99.7 %$ for $500 mu s$ detection time and $2500 mu s$ re-cooling time. Note, however, that this is a worst-case error, since those states measured earlier will experience lower spontaneous decay errors than those measured later. Moreover, the readout error can be reduced by an order of magnitude using improved collection optics~@Pogorelov2021 and fast re-cooling techniques~#cite(<Schindler2013>).

We demonstrate a universal qudit quantum processor built on state-of-the-art trapped-ion hardware. Our approach requires only a minimal overhead in classical control capabilities and can be integrated into existing experiments. This will particularly benefit applications that are natively formulated in terms of higher spin models, such as quantum chemistry~@MacDonell2020 and quantum simulation of lattice gauge theories~#cite(<Rico2018>). Two key challenges for getting the best performance out of qudit hardware are low cross-talk errors due to the large number of local operations required, and fast re-cooling and readout capabilities to reduce SPAM errors. Improvements to the optics and control electronics could improve these numbers by at least an order of magnitude with current technology. Finally, a larger magnetic field would have the benefit of larger spectral separation between the various qudit transition, which will be required for working with longer strings of qudits and the associated crowded mode spectrum. Conceptually, a key challenge for making use of the system we present remains in compiling quantum algorithms into the qudit framework. To facilitate such compilation, it will be highly beneficial to complement the embedded two-level entangling gates we presented with a suite of genuine qudit entangling gates.

#block[
#strong[Acknowledgements] We thank Marcus Huber and Joel Wallman for discussions. This project has received funding from the European Union's Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No 840450. It reflects only the author's view, the EU Agency is not responsible for any use that may be made of the information it contains. We also acknowledge support by the Austrian Science Fund (FWF), through the SFB BeyondC (FWF Project No.~F7109), by the U.S.~Army Research Office (ARO) through grant no.~W911NF-21-1-0007, and by the Office of the Director of National Intelligence (ODNI), Intelligence Advanced Research Projects Activity (IARPA), via the U.S. ARO Grant No. W911NF-16-1-0070. This project has received funding from the European Union's Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No. 801110 and the Austrian Federal Ministry of Education, Science and Research (BMBWF). \
#strong[Author contributions] MR developed the concepts. MR, MM, LP, RS, PS, and TM performed the experiments. MR analyzed the data. TM and RB supervised the project. All authors contributed to writing the manuscript. \
#strong[Competing Interests] The authors declare no competing interests. \
Requests for materials and correspondence should be addressed to MR (email: martin.ringbauer\@uibk.ac.at).

]
#block[
#strong[Supplementary Information: \
A universal qudit quantum processor]

]
= Multi-ion addressing
<multi-ion-addressing>
Individual addressing of ions is achieved with a tightly focused laser beam at an angle of $67.5^compose$ to the ion string~#cite(<Schindler2013>). A combination of two crossed acousto-optic deflectors (AOD) at a $90^compose$ angle to each other~@kim2008acousto enables beam steering over a wide range with reconfiguration times below $10 mu s$, see Fig.~@fig:addressing. By using the positive first order of diffraction on the first AOD and the negative first order on the second AOD, any frequency shifts are exactly cancelled. Multiple ions are addressed by simultaneously applying two (or more) frequencies to the addressing unit. In contrast to approaches with fixed fibre arrays~@Figgatt2019, our setup allows for precise individual control of each beam to match the non-equidistant ion positions. Moreover, the phase of each addressed beam can be individually controlled by a phase offset between the RF signals on two AODs for a given driving tone. The price to pay for such flexibility, however, is that $n$ driving tones lead to $n^2$ beams, due to combinations of non-corresponding frequencies of the different AODs, see Fig.~@fig:addressing. Although beams that originate from mixing of different frequencies are out of the plane of ions, there is residual overlap when addressing ions in close proximity, which leads to cross-talk errors. To avoid such errors, we make use of the fact that any off-axis spots are frequency shifted and thus not resonant with the ion. An important design parameter to ensure that this is true also for bichromatic beams used for entangling gates is the ratio of RF-frequency change to spatial displacement. This parameter can be controlled by the choice of input beam size and focusing optics, which we design for a value of $tilde.op 65 med k H z / mu m$, and a minimal ion separation of $tilde.op 3.5 mu m$. This ensures that unwanted spots are spectrally detuned from all carriers and motional sidebands for strings up to length 10, see Fig.~@fig:addressingSpectrum. This optical setup could be further improved by using a beam that is perpendicular to the ion chain and then does not couple to axial motional modes. This system enables two-qubit entangling gates on arbitrary pairs of ions with an error rate that increases only weakly with the number of ions, see Fig.~@fig:AddressedMS.

#figure(image("src/FigAddressingA-wide.pdf"),
  caption: [
    #strong[Addressing unit for simultaneous multi-ion addressing.] #strong[(a)] An incoming light beam is frequency up-shifted by first-order diffraction in an AOD rotated $45 deg$ relative to the ion chain. The beam is then imaged into a second AOD rotated $- 45 deg$ to the ion chain and frequency down-shifted by the same amount. This results beam that is freely steerable along the ion chain with no frequency shift and full phase control via phase offset between the AODs. Owing to the large bandwidth of the AODs, the addressing range of such a system is only limited by the the subsequent focusing optics into the trap and capable of addressing up to 100 ions. #strong[(b)] Applying $n$ frequencies results in $n$ unshifted spots in the plane of the ions. However, at the same time, there are also $n^2 - n$ out-of-plane spots that result from mixing of diffractions corresponding to different frequencies and are thus off-resonant by the difference in addressing frequencies.
  ],
  placement: top,
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
#figure(image("imgs/off_axis_spot_spectrum.png", width: 90.0%),
  caption: [
    Simulated spectrum of the unwanted off-axis spots (solid stems, integer tuple in the legend denotes the addressed ions) when addressing two ions with a bichromatic light field, slightly detuned from the axial center-of-mass motional sideband, as used for the MS gate. Shown are only the off-axis spots resulting from addressing neighbour and next-neighbour ions, since the others' contributions to cross-talk errors are negligible. Different symbols indicate the frequencies of red (RSB) and blue (BSB) sidebands along the axial and radial direction with respect to the trap axis, see legend. The example is for 10 ions at an axial trap frequency of $800 med k H z$, with a displacement ratio of $tilde.op 65 med k H z / mu m$.
  ],
  placement: top,
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
#figure(image("imgs/ms_decay.png"),
  caption: [
    Fidelity decay for addressed entangling gates in a 3 and 10 ion string. The fidelity is $0.993 plus.minus 0.002$ and $0.983 plus.minus 0.002$ respectively. Gate performance for ion strings of intermediate length can be interpolated from these values.
  ],
  placement: top,
)
<fig:AddressedMS>

= Off-resonant operations
<off-resonant-operations>
One of the primary error sources in trapped-ion quantum computers is cross-talk from addressed operations~#cite(<Parrado-Rodriguez2020>). A common way to combat this problem in conventional TIQPs is through the use of composite pulses, which are a sequence of counter-rotating resonant operations and off-resonant AC-Stark ($"Z"$) rotations: \$\$\\begin{equation}
    \\R(\\theta,\\phi) = Z(\\pi)-\\R(-\\theta/2,\\phi)-Z(\\pi)-\\R(\\theta/2,\\phi).
    \\label{eq:refocusing}
\\end{equation}\$\$ The $"Z"$ rotations are implemented by a far-detuned laser, which induces energy level shifts due to the AC-Stark effect. Since the Rabi frequency in this case scales quadratically with the resonant Rabi frequency, these pulses benefit from quadratically suppressed cross-talk to neighbouring ions. In the present experiment, the sequence of Eq.~#link(<eq:refocusing>)[[eq:refocusing]] suppresses cross-talk to $tilde.op 2 dot.op 10^(- 3)$ (from $tilde.op 4 %$ for a resonant operation), which is on the same order of magnitude as the benchmarked gate error rate from Fig.~@fig:RB. This could be further reduced by several orders of magnitude with improved addressing optics~#cite(<Pogorelov2021>).

Reducing cross-talk errors is particularly relevant for qudit quantum processors, as they typically require more basic rotations to realize arbitrary operations than their qubit counterpart. However, when more than two states are occupied, the effect of off-resonant laser interaction is more complex, as each state acquires a different AC-Stark shift due to varying detunings and coupling strengths, see Fig.~@fig:StarkShift. Formally, the relative shift $Delta_(i , j)$ between states $\| i chevron.r$ and $\| j chevron.r$ is given by~@Haeffner2003 $ Delta_(i , j) ( Delta ) = Omega^2 / 4 (2 b - sum_t frac(Omega_t^2 dot.op gamma_(i , j)^(( t )), delta - delta_t)) , $<eq:Starkshift> where the sum runs over all transitions $( t )$, whose coupling strengths relative to the $0 arrow.l.r 1$ transition are given by the dimensionless quantity $Omega_c$ and can be controlled by the laser polarization. $delta$ denotes the detuning of the light field, $delta_t$ is the detuning of transition $t$ from the $\| 0 chevron.r arrow.l.r \| 1 chevron.r$ transition, $Omega$ the Rabi frequency on the $\| 0 chevron.r arrow.l.r \| 1 chevron.r$ transition, and $b$ is the Stark shift due to the far-detuned dipole transitions. The relative contributions of the quadrupole transitions to the Stark-shift obtained by the $\| i chevron.r arrow.l.r \| j chevron.r$ transition is given by $gamma_(i , j)$, which takes the value 2 for the transition $\| i chevron.r arrow.l.r \| j chevron.r$, 1 for transitions that include either $\| i chevron.r$ or $\| j chevron.r$, and 0 otherwise.

From Eq.~#link(<eq:Starkshift>)[[eq:Starkshift]] and Fig.~@fig:StarkShift it is clear that, in the qudit case, a single off-resonant light field would lead to practically uncontrollable phase shifts outside the addressed transition. However, a careful analysis shows that for a system with $d$ occupied levels, a multi-chromatic off-resonant light field with $( d - 1 )$ tones can, in principle, exactly compensate all level shifts, but one. This provides an avenue for targeted phase shifts of any level in a qudit, enabling composite pulse techniques like in Eq.~#link(<eq:refocusing>)[[eq:refocusing]]. However, each such beam contains $2 dot.op ( d - 2 )$ coupled parameters, which can make their experimental calibration challenging. $ "Z"^i ( theta ) \| j chevron.r = cases(delim: "{", e^(- i theta) \| j chevron.r & "if " j = i, \| j chevron.r & "otherwise") . $<eq:QuditStark>

#figure(image("src/FigACstark1-wide.pdf"),
  caption: [
    #strong[AC-Stark shifts in a ququart] Stark shift as a function of the detuning of a single off-resonant beam from the qubit transition for all four transitions in a ququart encoded as in Fig.~@fig.levelscheme. The solid lines represent the theory prediction according to Eq.~#link()[[eq:Starkshift]], adjusted for the finite bandwidth of the used AOM, where the relative coupling strengths were measured independently. The Rabi frequency, dipole contribution, and AOM bandwidth are fitted to the measured datapoints. Dashed and dot-dashed vertical lines indicate carrier transitions for the $S ( - 1 / 2 )$ and $S ( + 1 / 2 )$ states, respectively, and black, solid vertical lines indicate the frequencies of our bichromatic AC-Stark gate to achieve equal Stark shift on the two S and the two D levels. Stark shifts are expected to diverge close to the carrier transitions, and converge to a non-zero background level for large detuning due to coupling to the dipole transitions (not shown).
  ],
  placement: top,
)
<fig:StarkShift>

Fortunately, a simpler approach suffices for our purpose, where we do not need arbitrary phase shifts on individual levels, but merely want to generalize the composite pulse sequence of Eq.~#link(<eq:refocusing>)[[eq:refocusing]] to qudits. In this case, it is sufficient to limit the Stark shifts of all the levels to multiples of $pi$, rather than nulling all but one. For example, it is always sufficient to equally shift the "S" levels $\| 0 chevron.r , \| 2 chevron.r$ in Fig.~@fig.levelscheme with respect to the "D" levels, since shifts on spectator levels cancel by construction. Experimentally, we demonstrate such composite pulses for qutrits and ququarts using a bichromatic off-resonant light field with one frequency far detuned at $−10 med M H z$ and a second frequency at $−0.5 med M H z$ from the $0 arrow.l.r 6$ transition, see Fig.~@fig:QuditAC.

#figure(image("src/FigQuditAC2-wide.pdf"),
  caption: [
    #strong[Qudit AC-Stark pulses.] To verify the performance of our qudit off-resonant operations, we perform a Ramsey experiment, where we create an equal superposition of all qutrit states, followed by evolution under a #strong[(a)] single-tone, #strong[(b)] compensated two-tone AC-Stark pulse, followed by a reversal of the first operation. Solid lines correspond to a fit, points are measured data with one standard deviation statistical uncertainties.
  ],
  placement: top,
)
<fig:QuditAC>

= Single-qudit gate decomposition
<single-qudit-gate-decomposition>
Recall that the native single-ion operations available in the ion trap are equatorial rotations on any S-D transition, except those with $Delta m = plus.minus 3$, given by \$\$\\begin{equation}
\\R\_{i,j}(\\theta,\\phi) = \\exp(-i \\theta (\\cos{(\\phi)}{\\sigma\_\\textsc{x}}^{i,j} \\pm \\sin{(\\phi)}{\\sigma\_\\textsc{y}}^{i,j})/2) .
\\label{eq:SUPPlocalOps}
\\end{equation}\$\$ Here $sigma_(x , y , z)$ are the Pauli X,Y,Z matrices, $theta$ denotes the rotation angle, and $i , j$ with $i < j$ indicate the addressed transition. Recall, that the phase convention for $phi.alt$ in $sigma_phi.alt^(i , j)$ is positive when $\| i chevron.r$ is in the S-manifold and negative when $\| j chevron.r$ is in the S-manifold.

We now discuss how arbitrary $S U ( d )$ operations can be decomposed into the basic rotations of Eq.~@eq:SUPPlocalOps, adapted from Ref~#cite(<OLeary2006a>). Following Ref.~@OLeary2006a the idea is to first bring the target unitary into diagonal form using the subspace rotations of Eq.~@eq:SUPPlocalOps, and then implement appropriate phase-shifts between the qudit states. For the latter step it is in general sufficient to implement the target unitary up to a global phase $gamma$, which requires at most $d - 1$ phase gates between pairs of levels, which are decomposed into 3 resonant operations each. Importantly, this procedure works for any coupling map between the qudit levels, although the latter might affect the efficiency of the decomposition. In the case of ladder-type coupling, algorithm~@alg:SUPP_localdiag provides a decomposition of a generic unitary $U in "SU" ( d )$ (indices run from $1$ to $d$). In case of other coupling structures, the same algorithm can be used, albeit with an adapted sequence of operations. Note that the algorithm returns a sequence of gates that must be applied in reverse order and conjugate-transposed for implementing the corresponding unitary in the lab.

#figure([#block[
  #block[
  $tilde(U) = U$ $"decomp" = { }$ $theta = 2 arctan [ \| tilde(U)_(r , c) / tilde(U)_(r - 1 , c) \| ]$ $phi.alt = - ( arg [ tilde(U)_(r - 1 , c) ] - arg [ tilde(U)_(r , c) ] )$ $tilde(U) = "R" ( theta , phi.alt )_(r , c) dot.op tilde(U)$ $"decomp" . "append" ( "R" ( theta , phi.alt )_(r , c) )$ $r = r - 1$ $c = c + 1$ #strong[Solve] $mat(delim: "(", 1, 0, 0, dots.h.c, 0; - 1, 1, 0, dots.h.c, 0; dots.v, dots.v, dots.v, dots.down, dots.v; 0, 0, 0, dots.h.c, - 1) dot.op vec(gamma_1 / 2, gamma_2 / 2, dots.v, gamma_(d - 1) / 2) + vec(gamma, gamma, dots.v, gamma) = arg [ "diag" ( tilde(U) ) ]$ $"decomp" . "append" ( "R" ( pi / 2 , pi )_(i , i + 1) dot.op "R" ( gamma_i , pi / 2 )_(i , i + 1) dot.op "R" ( pi / 2 , 0 )_(i , i + 1) )$ $"decomp"$

  ]
  ]],
  caption: [
    Decomposition of $U in "SU" ( d )$ into two-level rotations adapted from Ref.~@OLeary2006a
  ]
)
<alg:SUPP_localdiag>

= Two-qudit gate synthesis
<two-qudit-gate-synthesis>
We now sketch a strategy for synthesising typical two-qudit gates using the standard gate set outlined in the main text. The two main challenges here are to control off-target operations (i.e.~operations beyond the addressed subspace) and undesired ("global" or local) phases of the employed operations. To this end, the first gadget we define is a phase-compensated MS-gate, denoted $tilde("MS")_(i , j) ( theta , phi.alt )$, see Fig.@fig:Supp:phasecorrectedMS. Here we employ additional phase-gates between all levels of the qudit to cancel unwanted phases of the MS-gate operation, such that it fully acts as the identity outside (0,1)-subspace that we want to address. These phase-gates will largely be absorbed into other local operations in the final compilation step.

#figure(image("src/qudit-MS-phasecorrected.pdf", width: 60.0%),
  caption: [
    Phase-compensated MS gate on the 01-qubit subspace in a 4-level system. For qudits with other dimensions, the procedure is similar.
  ],
  placement: top,
)
<fig:Supp:phasecorrectedMS>

== Decomposition of the \$\\cex\$ gate
<decomposition-of-the-cex-gate>
Using this phase-compensated gate, we now construct the most basic qudit gate, an embedded \$\\cnot\$ gate acting on some two-level subspace of two qudits. We denote this gate a controlled-exchange \$\\cex\$ gate. A key observation at this point is that the (phase-compensated) MS gate acts non-trivially if and only if both qudits are within the correct two-level subspace. As soon as one qudit is outside this subspace, the gate acts as the identity operation. As a consequence, the standard transformation between MS- and \$\\cnot\$-gate cannot be used for our purpose, since it involves local operations that do not correspond to a basis change. Hence in the cases where one of the qudits is outside the addressed subspace and the MS-gate acts as the identity, we are left with undesired local rotations, which effectively induce \$\\sqrt{\\cnot}\$-type couplings.

We overcome this problem by exploiting spectroscopic decoupling to turn the MS-gate directly into a controlled-$"R" ( theta , phi.alt )$-rotation. First, rotating the #emph[control] ion into the eigenbasis of the MS-gate, the gate imparts a conditional local operation on the #emph[target] ion as \$\$\\begin{align}
(\\R\_{0,1}(\\pi/2,\\phi + \\pi/2) \\otimes \\mathds 1) \\cdot
\\widetilde{\\ms}\_{0,1}(\\theta,\\phi) \\cdot 
(\\R\_{0,1}(\\pi/2,\\phi - \\pi/2) \\otimes \\mathds 1) &= \\nonumber\\\\
e^{-\\mathrm{i} \\theta/2} \\left(
 | 0 \\rangle\\!\\langle 0 | \\otimes \\operatorname{R}\_{0,1}(-\\theta,\\phi) + 
 | 1 \\rangle\\!\\langle 1 | \\otimes \\operatorname{R}\_{0,1}(\\theta,\\phi) \\right) & ,
\\label{eq:Supp:MSdecoupled}
\\end{align}\$\$ and identity on all other qudit states. Second, we need to drop the unwanted rotation in case the control ion is in state $\| 0 chevron.r$, which, as before, cannot be done using local operations. We achieve this, by decoupling the state $\| 0 chevron.r$ of the control ion from the interaction by transferring it to an auxiliary qudit level $\| a chevron.r$, see Fig.@fig:Supp:MScrot. Using this decomposition, a \$\\cex\$-gate on any two-level subspace of a qudit can be achieved using one \$\\ms(\\pi)\$ gate, compared to one \$\\ms(\\pi/2)\$ gate required for the standard qubit decomposition.

#figure(image("src/qudit-MS-controlledRot.pdf", width: 85.0%),
  caption: [
    Turning the MS-gate into a controlled rotation by a combination of local basis transformation and spectroscopic decoupling.
  ],
  placement: top,
)
<fig:Supp:MScrot>

== Decomposition of the $C ""_(I N C)$ gate
<decomposition-of-the-operatornamec_inc-gate>
As the qudit generalization of the \$\\cnot\$-gate, the \$\\cinc\$-gate is a qudit $"X"$ operation, controlled on the state $\| d chevron.r$ of the control qudit. In the case $d = 3$, we have \$\\operatorname{X}\_3 = \\R\_{0,1}(\\pi,\\pi/2) \\cdot  \\R\_{1,2}(\\pi,\\pi/2)\$. Using the above strategy, we replace the local rotations in the decomposition of $"X"_3$ by the controlled rotations of Fig.~@fig:Supp:MScrot. For experimental convenience, we use additional local $pi$-pulses to implement all \$\\ms\$-gate operations in the $( 0 , 1 )$-subspace. Finally, we replace the phase-corrected \$\\widetilde{\\ms}\$-gates by standard \$\\ms\$-gates and absorb the remaining phase shifts, where possible as frame-rotations of the local gates, see Fig.~@fig:supp:cinc. This decomposition achieves a $d$-dimensional \$\\cinc\$ gate, using $2 ( d - 1 )$ pairwise fully entangling gates, see Fig.~@fig:supp:cinc.

#figure(image("src/qutrit-Cinc-decomposition.pdf"),
  caption: [
    #strong[Decomposition of a qutrit \$\\cinc\$-gate into two-level operations.] Operations acting on different transitions are color-coded as a visual guide. #strong[a,
  placement: top,
)] Simple decomposition into controlled rotations using phase-compensated MS-gates. #strong[b)] Fully compiled decomposition where phase-gates have been absorbed into frame-changes of the local operations. One remaining $"Z"$ operation is performed in the standard Euler-decomposition as \$\\operatorname{Z}\_{2,3}(\\theta) = \\R\_{2,3}(\\pi/2,-\\pi/2) \\cdot \\R\_{2,3}(\\theta,0) \\cdot \\R\_{2,3}(\\pi/2,\\pi/2)\$.
  ]
)
<fig:supp:cinc>

= Qudit Tomography
<qudit-tomography>
In order to reconstruct qudit states and processes, we employ a semi-definite programming approach that is independent of the underlying dimension and compatible with any (potentially incomplete) set of experimental data. For the sake of simplicity, we start with state tomography and outline the straightforward generalization to process tomography later.

Following the notation of Ref.~@Ringbauer2015, let $cal(X)_d tilde.equiv bb(C)^d$ be a $d$-dimensional complex Hilbert space, and $D ( cal(X)_d )$ the set of density matrices on $cal(X)_d$. We perform measurements using a set of projectors ${ Pi_i }_(i = 1)^K$, where $Pi_i = \| psi_i chevron.r #h(-1em) chevron.l psi_i \|$ to reconstruct an unknown qudit state $sigma in D ( cal(X)_d )$. The probability for observing a click for projector $Pi_i$ when the qudit state $sigma$ was prepared is then given by \$\$\\begin{equation}
p\_{i} = \\operatorname{Tr}\\left[\\Pi\_i \\sigma \\right] = \\BraKet{\\Pi\_{i}}{\\sigma} .
\\label{eq:ProbsQST}
\\end{equation}\$\$ Here \$\\Ket{\\sigma}=\\sum\_{i,j=0}^{d-1} \\sigma\_{i,j}|j\\rangle\\otimes|i\\rangle\$ denotes the column vector obtained by stacking the columns of the operator $sigma$. We now define the vector of observed frequencies $\| f chevron.r$, the quadratic form $S$, and the weight matrix $W$ as follows: \$\$\\begin{equation}
|f\\rangle = \\sum\_{i=1}^K \\frac{n\_j+\\beta}{N\_j+d\\beta}|i\\rangle  \\qquad\\qquad
S = \\sum\_{i=1}^K |i\\rangle\\Bra{\\Pi\_{i}} \\qquad\\qquad
W = \\sum\_{i=1}^K \\sqrt{\\frac{N\_i}{f\_i(1-f\_i)}}  | i \\rangle\\!\\langle i | ,
\\label{eq:TomoDefsQST}
\\end{equation}\$\$ where $N_j$ is the number of measurement runs in which projector $Pi_j$ was measured, and $n_j$ is the number of observed counts. The weight matrix $W$ takes into account the multinomial distribution of the observed frequencies, and $beta$ is an optional hedging parameter, typically set to $beta tilde.op 0.5$ to avoid probabilities of 0 or 1 #cite(<Ferrie2012Hedged>). Using this, we can now perform a maximum likelihood reconstruction of the state $sigma$ by solving the following convex optimization problem \$\$\\begin{align}
&\\text{minimize}\\quad \\| W(S\\Ket{\\sigma}-|f\\rangle) \\|\_2
\\nonumber\\\\
&\\text{subject to: } \\quad\\sigma \\ge 0 , \\operatorname{Tr}[\\sigma]= 1 .
\\label{eq:MLEopt}
\\end{align}\$\$ Experimentally, an informationally complete set of the projectors ${ Pi_i }_(i = 1)^K$ is constructed by combining several orthonormal bases of the Hilbert space. In the case $d = 2$ these are the given by the three Pauli operators. In larger dimensions, we similarly construct them out of pair-wise superpositions, as these are most convenient experimentally. For $d = 3$ we have, for example, 6 bases, defined by the following collection of pure states (or projectors): $  & { ( \| 0 chevron.r + i \| 1 chevron.r ) / sqrt(2) , ( \| 0 chevron.r - i \| 1 chevron.r ) / sqrt(2) , \| 2 chevron.r } ,\
 & { ( \| 0 chevron.r + \| 1 chevron.r ) / sqrt(2) , ( \| 0 chevron.r - i \| 1 chevron.r ) / sqrt(2) , \| 2 chevron.r } ,\
 & { ( \| 0 chevron.r + i \| 2 chevron.r ) / sqrt(2) , \| 1 chevron.r , ( \| 0 chevron.r - i \| 2 chevron.r ) / sqrt(2) } ,\
 & { ( \| 0 chevron.r + \| 2 chevron.r ) / sqrt(2) , \| 1 chevron.r , ( \| 0 chevron.r - \| 2 chevron.r ) / sqrt(2) } ,\
 & { ( \| 1 chevron.r + i \| 2 chevron.r ) / sqrt(2) , \| 0 chevron.r , ( \| 1 chevron.r - i \| 2 chevron.r ) / sqrt(2) } ,\
 & { ( \| 1 chevron.r + \| 2 chevron.r ) / sqrt(2) , \| 0 chevron.r , ( \| 1 chevron.r - \| 2 chevron.r ) / sqrt(2) } , $<eq:QutritBasis>

In the case of quantum process tomography, we aim to reconstruct the Choi operator $Lambda_(cal(E))$ of a quantum process $cal(E)$, such that $ cal(E) ( rho ) = "Tr"_1 [ ( rho_i^T ⊗ bb(1)_(cal(X)_2) ) Lambda_(cal(E)) ] . $ This is achieved by preparing an informationally complete set of input states ${ rho_i }_(i = 1)^K$ and for each of them measuring an informationally complete set of projectors ${ Pi_j }_(j = 1)^K$. In practice, we chose these two sets to be the same. The probability for observing a click for projector $Pi_j$ when the state $rho_i$ was subject to the process $cal(E)$ is then given by \$\$\\begin{equation}
p\_{ij} = \\operatorname{Tr}\\big[\\Pi\_j \\operatorname{Tr}\_{1}[(\\rho\_i^T\\otimes\\mathds{1})\\Lambda]\\big] = \\operatorname{Tr}\\big[(\\rho\_i^T\\otimes\\Pi\_j)\\Lambda\\big]  
    = \\BraKet{\\Pi\_{ij}}{\\Lambda} ,
\\label{eq:ProbsQPT}
\\end{equation}\$\$ where $Pi_(i j) equiv rho_i^(*) ⊗ Pi_j$. With this we straightforwardly generalize Eq.~#link(<eq:TomoDefsQST>)[[eq:TomoDefsQST]] as follows: \$\$\\begin{equation}
|f\\rangle = \\sum\_{i,j=1}^K \\frac{n\_{ij}+\\beta}{N\_{ij}+d\\beta}|i,j\\rangle    \\qquad\\qquad
S = \\sum\_{i,j=1}^K |i,j\\rangle\\Bra{\\Pi\_{ij}} \\qquad\\qquad
W = \\sum\_{i,j=1}^K w\_{ij}  | i,j \\rangle\\!\\langle i,j | .
\\label{eq:TomoDefsQPT}
\\end{equation}\$\$ Equation~#link(<eq:MLEopt>)[[eq:MLEopt]] then becomes \$\$\\begin{align}
&\\text{minimize}\\quad \\| W(S\\Ket{\\Lambda\_{\\mathcal{E}}}-|f\\rangle) \\|\_2
\\nonumber\\\\
&\\text{subject to: } \\quad\\Lambda\_{\\mathcal{E}} \\ge 0 , \\operatorname{Tr}[\\Lambda\_{\\mathcal{E}}]= d .
\\label{eq:MLEoptQPT}
\\end{align}\$\$

We performed quantum process tomography using Eq.~#link(<eq:MLEoptQPT>)[[eq:MLEoptQPT]] and the basis in Eq.~#link(<eq:QutritBasis>)[[eq:QutritBasis]] to reconstruct the single-qutrit Gell-Mann operators in Fig.~@fig:Supp_LocalGM and single-qutrit Clifford in Fig.~@fig:Supp_LocalClifford.

#block[
#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,center,left,),
    table.header(table.cell(align: center, colspan: 2)[Clifford + T], table.cell(align: center, colspan: 2)[Gell-Mann],),
    table.hline(),
    [$X_3$], [$cal(F) = 0.994_(- 0.001)^(+ 0.003)$], [$lambda_1$], [$cal(F) = 0.986_(- 0.001)^(+ 0.006)$],
    [$Z_3$], [$cal(F) = 0.952_(- 0.017)^(+ 0.013)$], [$lambda_2$], [$cal(F) = 0.992_(- 0.001)^(+ 0.003)$],
    [$S_3$], [$cal(F) = 0.968_(- 0.012)^(+ 0.011)$], [$lambda_3$], [$cal(F) = 0.967_(- 0.004)^(+ 0.017)$],
    [$H_3$], [$cal(F) = 0.945_(- 0.015)^(+ 0.011)$], [$lambda_4$], [$cal(F) = 0.989_(- 0.002)^(+ 0.004)$],
    [$T_3$], [$cal(F) = 0.994_(- 0.016)^(+ 0.001)$], [$lambda_5$], [$cal(F) = 0.970_(- 0.001)^(+ 0.012)$],
    [], [], [$lambda_6$], [$cal(F) = 0.991_(- 0.002)^(+ 0.004)$],
    [], [], [$lambda_7$], [$cal(F) = 0.985_(- 0.001)^(+ 0.008)$],
    [], [], [$lambda_8$], [$cal(F) = 0.960_(- 0.006)^(+ 0.016)$],
  )]
  , caption: [#strong[Fidelities for single qutrit gates]. Fidelities are estimated from quantum process tomography without SPAM correction. The uncertainties correspond to $1 sigma$ statistical uncertainty from quantum projection noise, estimated using MonteCarlo resampling.]
  , kind: table
  )

] <tab:single_qudit_results>
= Single-qutrit results
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
#figure(image("imgs/LocalGatesCliff.png"),
  caption: [
    #strong[Single qutrit Clifford + T gate set]. Shown are experimentally reconstructed Choi operators corresponding to the Clifford gates#strong[(a)] $H_3$ and #strong[(b)] $S_3$, as well as the non-Clifford gate #strong[(c)] $T_3$.The fidelities are given in Tab.~
  ],
  placement: top,
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
#figure(image("imgs/LocalGatesGM8.png"),
  caption: [
    #strong[Single qutrit Gell-Mann operations]. Shown are experimentally reconstructed Choi operators corresponding to the 8 Gell-Mann operations forming the basis for the qutrit Hilbert space. The fidelities are given in Tab.~
  ],
  placement: top,
)
<fig:Supp_LocalGM>

#bibliography("refs.bib", style: "ieee")
