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

#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 1.6em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: auto)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9pt)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#let eqnn(body) = { set math.equation(numbering: none); body }


#place(top, float: true, scope: "parent", clearance: 1.2em)[
  #align(center)[
    #text(12pt, weight: "bold", [Suppressing quantum errors by scaling a surface code logical qubit])   #v(1.2em)
    #text(10.5pt)[Google Quantum AI]
  ]
  #v(1.6em)

// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: July 21, 2022)]]

  Practical quantum computing will require error rates that are well below what is achievable with physical qubits. Quantum error correction @shor1995scheme @gottesman1997stabilizer offers a path to algorithmically-relevant error rates by encoding logical qubits within many physical qubits, where increasing the number of physical qubits enhances protection against physical errors. However, introducing more qubits also increases the number of error sources, so the density of errors must be sufficiently low in order for logical performance to improve with increasing code size. Here, we report the measurement of logical qubit performance scaling across multiple code sizes, and demonstrate that our system of superconducting qubits has sufficient performance to overcome the additional errors from increasing qubit number. We find our distance-5 surface code logical qubit modestly outperforms an ensemble of distance-3 logical qubits on average, both in terms of logical error probability over 25 cycles and logical error per cycle (2.914%±0.016% compared to 3.028%±0.023%). To investigate damaging, low-probability error sources, we run a distance-25 repetition code and observe a $1.7 times 10^(- 6)$ logical error per round floor set by a single high-energy event ($1.6 times 10^(- 7)$ when excluding this event). We are able to accurately model our experiment, and from this model we can extract error budgets that highlight the biggest challenges for future systems. These results mark the first experimental demonstration where quantum error correction begins to improve performance with increasing qubit number, illuminating the path to reaching the logical error rates required for computation.
]

  #heading(numbering: none)[Introduction]

  Since Feynman's proposal to compute using quantum mechanics @feynman1982simulating, many potential applications have emerged, including factoring @shor1999polynomial, optimization @farhi2001quantum, machine learning @biamonte2017quantum, quantum simulation @lloyd1996universal, and quantum chemistry @aspuru2005simulated. These applications often require billions of quantum operations @reiher2017elucidating @gidney2019factor @kivlichan2020improved while state-of-the-art quantum processors typically have error rates around $10^(- 3)$ per gate @ballance2016high, @huang2019fidelity @rol2019fast @jurcevic2020demonstration @foxen2020demonstrating @wu2021strong, far too high to execute such large circuits. Fortunately, quantum error correction can exponentially suppress the operational error rates in a quantum processor, at the expense of physical qubit overhead @knill1998resilient @aharonov2008fault.

  Several works have reported quantum error correction on small codes able to correct a single error @ryan2021realization @egan2021fault @krinner2022realizing @sundaresan2022matching @zhao2021realizing @abobeih2022fault @satzinger2021realizing and in continuous variable codes @ofek2016extending @fluhmann2019encoding @campagne2020quantum  @grimm2020stabilization. However, a crucial question remains: will scaling up the error-correcting code size reduce logical error rates in a real device? In theory, logical errors should be reduced if physical errors are sufficiently sparse in the quantum processor. In practice, demonstrating reduced logical error requires scaling up a device to support a code which can correct at least two errors, without sacrificing state-of-the-art performance. In this work, we report a 72-qubit superconducting device supporting a 49-qubit distance-5 ($d = 5$) surface code that narrowly outperforms its average subset 17-qubit distance-3 surface code, demonstrating a critical step towards scalable quantum error correction.



= SURFACE CODES WITH SUPERCONDUCTING QUBITS <surface-codes-with-superconducting-qubits>

Surface codes @kitaev2003 @dennis2002topological @raussendorf2007fault @fowler2012surface @satzinger2021realizing are a family of quantum error-correcting codes which encode a logical qubit into the joint entangled state of a $d times d$ square of physical qubits, referred to as #emph[data qubit]s. The logical qubit states are defined by a pair of anti-commuting logical observables $X_L$ and $Z_L$. For the example shown in Fig.~1a, a $Z_L$ observable is encoded in the joint $Z$-basis parity of a line of qubits which traverse the lattice from top-to-bottom, and likewise an $X_L$ observable is encoded in the joint $X$-basis parity traversing left-to-right. This non-local encoding of information protects the logical qubit from local physical errors, provided we can detect and correct them.

To detect errors, we periodically measure $X$ and $Z$ parities of adjacent clusters of data qubits with the aid of $d^2 - 1$#emph[measure qubits] interspersed throughout the lattice. As shown in Fig.~1b, each measure qubit interacts with its neighbouring data qubits in order to map the joint data qubit parity onto the measure qubit state, which is then measured. These parity measurements, or #emph[stabilisers], are laid out so that each one commutes with the logical observables of the encoded qubit as well as every other stabiliser. Consequently, we can detect errors when parity measurements change unexpectedly, without disturbing the logical qubit state.

A #emph[decoder] uses the history of stabiliser measurement outcomes to infer likely configurations of physical errors on the device. We can then determine the overall effect of these inferred errors on the logical qubit, thus preserving the logical state. Most surface code logical gates can be implemented by maintaining logical memory and executing different sequences of measurements on the code boundary @horsman2012 @fowler2019. Thus, we focus on preserving logical memory, the core technical challenge in operating the surface code.

We implement the surface code on an expanded Sycamore device @arute2019quantum with 72 transmon qubits @koch2007charge and 121 tunable couplers @neill2017path @yan2018tunable. Each qubit is coupled to four nearest neighbours except on the boundaries, with mean qubit coherence times $T_1$ = 20~$mu$ s and $T_(2 "CPMG")$ = 30~$mu$ s. As in  @chen2021exponential, we implement single-qubit rotations, controlled-Z (CZ) gates, reset, and measurement, demonstrating similar or improved simultaneous performance as shown in Fig.~1c.

// [figvision-cn] imgs/fig1_20220712_1000.png
// 子图 a 为示意图，展示了一个包含72个量子比特的Sycamore
// 处理器上嵌入的距离为5的表面码结构。图中由金色圆圈表示
// 的25个数据量子比特和蓝色圆圈表示的24个测量量子比特排列
// 成网格状。每个测量量子比特关联一个稳定子（蓝色方块），
// 其中深色方块代表Z型稳定子，浅色方块代表X型稳定子。黑色
// 粗线表示逻辑算符$Z_L$，绿色粗线表示逻辑算符$X_L$，两者
// 在左下角的数据量子比特处相交。图中还标注了未使用的灰色
// 量子比特以及一个红色方框标示的子集距离-3区域。 子图 b
// 为流程图，展示了动态解耦序列中的操作过程。图中左侧是部
// 分量子比特阵列的简化视图，右侧是随时间变化的操作序列。
// 橙色线条代表Hadamard门，黑色线条代表Controlled-Z门，蓝
// 色线条代表测量与重置操作。图中标注了“Time”轴，指示时间
// 的流逝方向。此外，还标注了“Dynamical decoupling”、“
// Hadamard”、“Controlled-Z”和“Measure and reset”等文字说
// 明各操作步骤。 子图 c 为曲线图，显示了累积分布函数。横
// 坐标为Pauli和测量错误率，范围从$10^{-3}$到$10^{-2}$；
// 纵坐标为累积概率。图中有四条曲线：红色曲线代表单量子比
// 特错误（1Q），黑色曲线代表CZ门错误，蓝色曲线代表测量错
// 误（Meas），黄色曲线代表动态解耦错误（DD）。每条曲线旁
// 边都有相应的标签，并且在图的右下角有一个图例，分别用不
// 同颜色标识Data qubit ($d^2$)、Measure qubit ($d^2 - 1$
// )、Unused和Subset distance-3。
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [TABLE #context it.counter.display(it.numbering). #it.body]
}

#figure(image("imgs/fig1_20220712_1000.png", width: 89mm),
  caption: [
    #strong[Implementing surface code logical qubits.] #strong[a,] Schematic of a 72-qubit Sycamore device with a distance-5 surface code embedded, consisting of 25 data qubits (gold) and 24 measure qubits (blue). Each measure qubit is associated with a stabiliser (blue colored tile, dark: $X$, light: $Z$). Representative logical operators $Z_L$ (black) and $X_L$ (green) traverse the array, intersecting at the lower-left data qubit. The upper-right quadrant (red outline) is one of four subset distance-3 codes (the four quadrants) we compare to distance-5. #strong[b,] Illustration of a stabiliser measurement, focusing on one data qubit (gold) and one measure qubit (blue), in perspective view with time progressing to the right. Each qubit participates in four controlled-Z (CZ) gates with its four nearest neighbours, interspersed with Hadamard gates (H), and finally, the measure qubit is measured and reset to $| 0 chevron.r$. Data qubits perform dynamical decoupling (DD) while waiting for the measurement and reset. All stabilisers are measured in this manner concurrently. Cycle duration is 921~ns, including 500~ns measurement and 160~ns reset. #strong[c,] Cumulative distributions of errors for single-qubit gates, CZ gates, measurement, and data qubit DD (idle during measurement and reset). Benchmarked in simultaneous operation using random circuit techniques, on the 49 qubits used in distance-5 and the four CZ layers from the stabiliser circuit @emerson2005scalable @arute2019quantum. Vertical lines are means.
  ]
)

The distance-5 surface code logical qubit is encoded on a 49-qubit subset of the device, with 25 data qubits and 24 measure qubits. Each measure qubit corresponds to one stabiliser, classified by its basis ($X$ or $Z$) and the number of data qubits involved (weight, 2 or 4). Ideally, to assess how logical performance scales with code size, we would compare distance-5 and distance-3 logical qubits under identical noise. Although device inhomogeneity makes this comparison difficult, we can compare the distance-5 logical qubit to the average of four distance-3 logical qubit subgrids, each containing 9 data qubits and 8 measure qubits. These distance-3 logical qubits cover the four quadrants of the distance-5 code with minimal qubit overlap, capturing the average performance of the full distance-5 grid.

In a single instance of the experiment, we initialise the logical qubit state, run several cycles of error correction, then measure the final logical state. We show an example in Fig.~2a. To prepare a $Z_L$ eigenstate, we first prepare the data qubits in $| 0 chevron.r$'s and $| 1 chevron.r$'s, an eigenstate of the $Z$ stabilisers. The first cycle of stabiliser measurements then projects the data qubits into an entangled state that is also an eigenstate of the $X$ stabilisers. Each cycle contains CZ and Hadamard gates sequenced to extract $X$ and $Z$ stabilisers simultaneously, and ends with the measurement and reset of the measure qubits. In the final cycle, we also measure the data qubits in the $Z$ basis, yielding both parity information and a measurement of the logical state. Preparing and measuring $X_L$ eigenstates proceeds analogously. The instance succeeds if the corrected logical measurement agrees with the known initial state; otherwise, a logical error has occurred.

Our stabiliser circuits contain a few modifications @supplement to the standard gate sequence described above, including phase corrections to correct for unintended qubit frequency shifts @kelly2016scalable and dynamical decoupling gates during qubit idles. We also remove certain Hadamard gates to implement the #emph[ZXXZ] variant of the surface code @wen2003quantum, @bonilla2021xzzx, helping to symmetrise the $X$- and $Z$-basis logical error rates. Finally, during initialization, the data qubits are prepared into randomly selected bitstrings. This ensures that we do not preferentially measure even parities in the first few rounds of the code, which could artificially lower logical error rates due to bias in measurement error.

#heading(numbering: none)[Error detectors]

// [figvision-cn] imgs/fig2_20220704_1000.png
// 该图包含八个子图（a至h），展示了表面码中的错误检测实验。
// 子图 a 是一个三维透视图，描绘了表面码实验的时序过程。
// 时间轴从左向右延伸，标记为 t=0, t=1, t=2, t=3。 在 t=0
// 左侧，有一个灰色的立方体示意图，代表初始数据量子比特状
// 态，其表面分布着蓝色和黄色的圆点。旁边有一列数字 "
// 01000", "01010", "01100"，表示已知的稳定子基下的奇偶性。
// 接着是 "Initial data"（初始数据）阶段，显示一个由黄色
// 方块组成的网格，每个方块内有数字0或1。 然后是 "
// Inferred parities"（推断奇偶性）阶段，显示一个倾斜的蓝
// 色网格，上面有数字0或1。 图中用不同颜色的曲线连接了不
// 同的点，代表不同类型的错误对： 红色曲线标记为 "
// Spacelike pair"（空间对），连接两个在同一时间步但不同
// 位置的检测事件。其中一个点被标记为 "B"（可能代表X错误）。
// 紫色曲线标记为 "Timelike pair"（时间对），连接两个在不
// 同时间步但同一位置的检测事件。其中一个点被标记为 "B"。
// 蓝色曲线标记为 "Diagonal pair"（对角对），连接两个在不
// 同时间和不同位置的检测事件。 在 t=3 处，显示了 "Final
// data"（最终数据）和 "Meas. error"（测量错误）。 整个过
// 程中，黑色的小球和连接线代表了量子比特的演化路径和相互
// 作用。 子图 b 是一个曲线图，标题为 "d = 5 (Exp.)"。 横
// 坐标轴为 "QEC cycle, t"，范围从0到25。 纵坐标轴为 "
// Detection prob., p_d"，范围从0.00到0.25。 图中有多条曲
// 线，分为两组：浅蓝色曲线组标记为 "weight-4"，深青色曲
// 线组标记为 "weight-2"。这些曲线显示了随着量子纠错周期
// 的增加，检测概率的变化趋势。 子图 c 是一个热图，对应于
// 子图 b 的数据。 图像为一个正方形区域，内部填充颜色，周
// 围有四个半圆形突出部分。 下方有一个颜色条，标记为 "p_d
// "，范围从0.1到0.25，颜色从深蓝过渡到绿色再到黄色。 热
// 图的颜色分布反映了检测概率的空间分布。 子图 d 是一个曲
// 线图，标题为 "d = 3 (Exp.)"。 横坐标轴为 "QEC cycle, t
// "，范围从0到25。 纵坐标轴为 "Detection prob., p_d"，范
// 围从0.00到0.25。 图中有多条曲线，分为两组：橙色曲线组
// 标记为 "weight-4"，深橙色曲线组标记为 "weight-2"。这些
// 曲线显示了随着量子纠错周期的增加，检测概率的变化趋势。
// 子图 e 是一个热图，对应于子图 d 的数据。 图像结构与子
// 图 c 相同。 下方有一个颜色条，标记为 "p_d"，范围从0.1
// 到0.25，颜色从深蓝过渡到绿色再到黄色。 热图的颜色分布
// 反映了检测概率的空间分布。 子图 f 是一个曲线图，标题为
// "d = 5 (Pauli+ sim.)"。 横坐标轴为 "QEC cycle, t"，范
// 围从0到25。 纵坐标轴为 "Detection prob., p_d"，范围从
// 0.00到0.25。 图中有多条曲线，分为两组：浅黄色曲线组标
// 记为 "weight-4"，浅绿色曲线组标记为 "weight-2"。这些曲
// 线显示了模拟结果中检测概率随量子纠错周期的变化趋势。
// 子图 g 是一个热图，对应于子图 f 的数据。 图像结构与子
// 图 c 和 e 相同。 下方有一个颜色条，标记为 "p_d"，范围
// 从0.1到0.25，颜色从深蓝过渡到绿色再到黄色。 热图的颜色
// 分布反映了模拟结果中检测概率的空间分布。 子图 h 是一个
// 柱状图，标题为 "Correlation, p_ij"。 横坐标轴有五个类
// 别："Time", "Space", "Diag.", "Unexp."。 纵坐标轴为 "
// Correlation, p_ij"，范围从0.00到0.05。 图中有三组柱子，
// 分别用不同颜色表示：蓝色代表 "Exp."（实验），橙色代表
// "Pauli+"，紫色代表 "Pauli"。每组柱子的高度表示不同类型
// 的相关性概率。
#figure(placement: auto, image("imgs/fig2_20220704_1000.png", width: 183mm),
  caption: [
    #strong[Error detection in the surface code.] #strong[a,] Illustration of a surface code experiment, in perspective view with time progressing to the right. We begin with an initial data qubit state which has known parities in one stabiliser basis (here, $Z$). We show example errors that manifest in detection pairs: a $Z$ error (red) on a data qubit (spacelike pair), a measurement error (purple) on a measure qubit (timelike pair), an $X$ error (blue) during the CZ gates (diagonal pair), and a measurement error (green) on a data qubit (detected in the final inferred $Z$ parities). #strong[b,] Detection probability for each stabiliser over a 25-cycle distance-5 experiment (50,000 repetitions). Darker lines: average over all stabilisers with the same weight. There are fewer detections at $t = 0$ because there is no preceding data idling, and at $t = 25$ because the final parities are calculated from data qubit measurements. #strong[c,] Detection probability heatmap, averaging over $t = 1$ to 24. #strong[d-e,] Similar to #strong[b-c] for four separate distance-3 experiments covering the four quadrants of the distance-5 code. #strong[f-g,] Similar to #strong[b-c] using a simulation with Pauli errors plus leakage, crosstalk, and stray interactions (#emph[Pauli+]). #strong[h,] Bar chart summarising the detection correlation matrix $p_(i j)$, comparing the distance-5 experiment from #strong[b] to the simulation in #strong[f] (#emph[Pauli+]) and a simpler simulation with only Pauli errors. We aggregate four groups of correlations: timelike pairs; spacelike pairs; diagonal pairs expected for Pauli noise; and diagonal pairs unexpected for Pauli noise ("Unexp."), including correlations over two timesteps. Each bar shows a mean and standard deviation of correlations from a 25-cycle, 50,000-repetition dataset.
  ],
  scope: "parent"
)

After initialisation, parity measurements should produce the same value in each cycle, up to known flips applied by the circuit. If we compare a parity measurement to the corresponding measurement in the preceding cycle and their values are inconsistent, a #emph[detection event] has occurred, indicating an error. We refer to these comparisons as #emph[detectors].

The detection event probabilities for each detector indicate the distribution of physical errors in space and time while running the surface code. In Fig.~2, we show the detection event probabilities in the distance-5 code (b, c) and the distance-3 codes (d, e) running for 25 rounds, as measured over 50,000 experimental instances. For the weight-4 stabilisers, the average detection probability is $0.185 plus.minus 0.018$ ($1 sigma$) in the distance-5 code and $0.175 plus.minus 0.017$ averaged over the distance-3 codes. The weight-2 stabilisers interact with fewer qubits and hence detect fewer errors. Correspondingly, they yield a lower average detection probability of $0.119 plus.minus 0.012$ in the distance-5 code and $0.115 plus.minus 0.008$ averaged over the distance-3 codes. The relative consistency between code distances suggests that growing the lattice does not substantially increase the component error rates during error correction.

The average detection probabilities exhibit a relative rise of 12% for distance-5 and 8% for distance-3 over 25 cycles, with a typical characteristic risetime of roughly 5 cycles @supplement. We attribute this rise to data qubits leaking into non-computational excited states and anticipate that the inclusion of leakage-removal techniques on data qubits would help to mitigate this rise @aliferis2005fault @suchara2015leakage @mcewen_removing_2021  @chen2021exponential. We hypothesise that the greater increase in detection probability in the distance-5 code is due to increased stray interactions or leakage from simultaneously operating more gates and measurements.

We test our understanding of the physical noise in our system by comparing the experimental data to a simulation. We begin with a Pauli simulation based on the component error information in Fig.~1c in a probabilistic Clifford simulator, then incorporate coherence information, transitions to leaked states, and crosstalk errors from unwanted coupling (#emph[Pauli+]). Fig.~2f shows that this second simulator accurately predicts the average detection probabilities, finding $0.180 plus.minus 0.013$ for the weight-4 stabilisers and $0.116 plus.minus 0.011$ for the weight-2 stabilisers, with average detection probabilities increasing 7% over 25 rounds (distance-5).



#heading(numbering: none)[Understanding errors through correlations]

We next examine pairwise correlations between detection events, which give us fine-grained information about which types of errors are occurring during error correction. Fig.~2a illustrates a few examples of pairwise detections which are generated by $X$ or $Z$ errors in the surface code. Measurement and reset errors are detected by the same stabiliser in two consecutive rounds, which we classify as a #emph[timelike] pair. Data qubits may experience an $X$ ($Z$) error while idling during measurement which is detected by its neighbouring $Z$ ($X$) stabilisers in the same round, forming a #emph[spacelike] pair. Errors during CZ gates may cause a variety of pairwise detections to occur, including #emph[diagonal] pairs which are separated in both space and time. More complex clusters of detection events arise when a $Y$ error occurs, which generates detection events for both $X$ and $Z$ errors.

To estimate probabilities of detection event pairs from our data, we compute an appropriately normalised correlation $p_(i j)$ between detection events occurring on any two detectors $i$ and $j$@chen2021exponential. In Fig.~2h, we show the estimated probabilities for experimental and simulated distance-5 data, aggregated and averaged according to the different classes of pairs. In addition to the expected pairs, we also quantify how often detection pairs occur which are unexpected from component Pauli errors.

Overall, the Pauli simulation systematically underpredicts these probabilities compared to experimental data, while the #emph[Pauli+] simulation is closer and predicts the presence of unexpected pairs, which we surmise are related to leakage and stray interactions.

These errors can be especially harmful to the surface code because they can generate multiple detection events distantly separated in space or time, which a decoder might wrongly interpret as multiple independent component errors. We expect that mitigating leakage and stray interactions will become increasingly important as error rates decrease.



= DECODING AND LOGICAL ERROR PROBABILITIES <decoding-and-logical-error-probabilities>

// [figvision-cn] imgs/fig3_20220712_1100.png
// 该图包含三个子图（a、b、c），展示了量子纠错循环次数与
// 逻辑错误概率及保真度之间的关系。 子图 a 类型：散点拟合
// 曲线图。 坐标轴：横轴为“Quantum error correction cycle
// , t”（量子纠错循环次数，t），范围从0到25，刻度间隔为5。
// 纵轴为“Logical error probability, p_L”（逻辑错误概率，
// p_L），范围从0.00到0.45，刻度间隔为0.05。 数据系列：
// 红色倒三角形标记及其误差棒代表“d = 3 average”（距离为3
// 的平均值）。 浅粉色倒三角形标记代表“d = 3 individual
// quadrants”（距离为3的四个独立象限）。 蓝色实心圆点代表
// “d = 5”（距离为5）。 红色实线是对实验平均值的拟合曲线
// （Fit to experimental average）。 蓝色虚线代表“Pauli+
// simulation”（Pauli+模拟结果）。 趋势与结论：随着纠错循
// 环次数t的增加，逻辑错误概率p_L呈上升趋势。距离为5（蓝
// 色）的逻辑错误概率始终低于距离为3（红色）的情况，表明
// 距离为5的编码具有更好的纠错性能。蓝色虚线位于所有实验
// 数据下方，表示理论模拟的错误率低于实际实验测量值。 子
// 图 b 类型：半对数散点拟合曲线图。 坐标轴：横轴与子图a
// 相同，为“Quantum error correction cycle, t”，范围0到25。
// 纵轴为“Logical fidelity, F = 1 - 2p_L”（逻辑保真度），
// 采用对数标度，范围从0.2到1.0，主刻度为0.2, 0.4, 0.6,
// 0.8, 1.0。 数据系列： 红色倒三角形标记代表“d = 3
// average”。 蓝色实心圆点代表“d = 5”。 红色实线是拟合曲
// 线，标注文字为“Fit, ε_3 = (3.028 ± 0.023)%”，表示距离
// 为3时的拟合参数ε_3。 蓝色实线是拟合曲线，标注文字为“
// Fit, ε_5 = (2.914 ± 0.016)%”，表示距离为5时的拟合参数ε
// _5。 趋势与结论：逻辑保真度F随循环次数增加而指数衰减。
// 距离为5（蓝色）的衰减速率略慢于距离为3（红色），对应更
// 低的ε值，再次证实了更大距离编码的优势。 子图 c 类型：
// 嵌入式的散点图。 位置：位于子图a的右下区域。 坐标轴：
// 横轴为“1 - ε_3”，范围从0.90到0.98。纵轴为“1 - ε_5”，范
// 围从0.90到0.98。 数据系列： 深蓝色实心圆点代表“d = 3
// average”。 浅蓝色空心圆圈代表“d = 3 individual”。 一条
// 红色的对角线标注为“ε_3 = ε_5”，表示两个参数相等的基准
// 线。 一个蓝色的箭头指向右上方，标注文字为“System
// improvements”（系统改进）。 趋势与结论：大多数数据点位
// 于红色对角线的右上方，意味着对于同一组实验条件，1 - ε
// _5通常大于1 - ε_3（即ε_5 < ε_3），这与子图b中的结论一
// 致。蓝色箭头指示的方向代表了系统性能提升的趋势。
#figure(image("imgs/fig3_20220712_1100.png", width: 89mm),
  caption: [
    #strong[Logical error reduction.] #strong[a,] Logical error probability $p_L$ vs. cycle comparing distance-5 (blue) to distance-3 (pink: four separate quadrants, red: average), all averaged over $Z_L$ and $X_L$. Each individual datapoint represents 100,000 repetitions. Solid line: fit to experimental average, $t = 3$ to 25 (see main text). Dotted line: comparison to #emph[Pauli+] simulation. #strong[b,] Logical fidelity $F = 1 - 2 p_L$ vs. cycle, semilog plot. Same experimental averages and fits from #strong[a]. #strong[c,] Summary of experimental progression comparing logical error per round $epsilon_d$ (specifically plotting $1 - epsilon_d$) between distance-3 and $5$, where system improvements lead to faster improvement for distance-5 (see main text). Each open circle is a comparison to a specific distance-3 code, and filled circles average over multiple distance-3 codes measured in the same session. Markers are colored chronologically from light to dark. Typical $1 sigma$ statistical and fit uncertainty is $0.02 "%"$, smaller than the points.
  ]
)

We next examine the logical performance of our surface code qubits. To infer the error-corrected logical measurement, the decoder requires a probability model for physical error events. This information may be expressed as an #emph[error hypergraph]: detectors are vertices, physical error mechanisms are hyperedges connecting the detectors they trigger, and each hyperedge is assigned its corresponding error mechanism probability. We use a generalisation of $p_(i j)$ to determine these probabilities @chen2021exponential @chen2022calibrated.

Given the error hypergraph, we implement two different decoders: belief-matching, an efficient combination of belief propagation and minimum-weight perfect matching @higgott2022fragile;; and tensor network decoding, a slow but accurate approximate maximum-likelihood decoder. The belief-matching decoder first runs belief propagation on the error hypergraph to update hyperedge error probabilities based on nearby detection events @criger2018multi @higgott2022fragile. The updated error hypergraph is then decomposed into a pair of disjoint error graphs, one each for $X$ and $Z$ errors @dennis2002topological. These graphs are decoded efficiently using minimum-weight perfect matching @fowler2012towards to select a single probable set of errors.

By contrast, a maximum-likelihood decoder considers all possible sets of errors consistent with the detection events, splits them into two groups based on whether they flip the logical measurement, and chooses the group with the greater total likelihood. The two likelihoods are each expressed as a tensor network contraction @BSV2014 @chubb2021statistical @higgott2022fragile that exhaustively sums the probabilities of all sets of errors within each group. We can contract the network approximately, and verify that the approximation converges. This yields a decoder which is nearly optimal given the hypergraph error priors, but is considerably slower. Further improvements could come from a more accurate prior, or incorporating more fine-grained measurement information @suchara2015leakage @pattison2021improved.

Figure~3 compares the logical error performance of the distance-3 and distance-5 codes using the approximate maximum-likelihood decoder. Because the #emph[ZXXZ] variant of the surface code symmetrises the $X$ and $Z$ bases, differences between the two bases' logical error per round are small and attributable to spatial variations in physical error rates. Thus, for visual clarity, we report logical error probabilities averaged between the $X$ and $Z$ basis; the full data set may be found in the supplement. Note that we do not post-select on leakage or high-energy events in order to capture the effects of realistic non-idealities on logical performance. Over all 25 cycles of error correction, the distance-5 code realises lower logical error probabilities $p_L$ than the average of the subset distance-3 codes.

We fit the logical fidelity $F = 1 - 2 p_L$ to an exponential decay, starting at $t = 3$ to avoid time-boundary effects that are advantageous to the distance-5 code. We obtain a logical error per cycle $epsilon_5 = ( 2.914 plus.minus 0.016 )$% ($1 sigma$ statistical and fit uncertainty) for the distance-5 code, compared to an average of $epsilon_3 = ( 3.028 plus.minus 0.023 )$% for the subset distance-3 codes, a relative error reduction of about 4%. When decoding with the faster belief-matching decoder, we fit a logical error per cycle of $( 3.056 plus.minus 0.015 )$% for the distance-5 code, compared to an average of $( 3.118 plus.minus 0.025 )$% for the distance-3 codes, a relative error reduction of about 2%. We note that the distance-5 logical error per cycle is slightly higher than two of the distance-3 codes individually, and that leakage accumulation may cause distance-5 performance to degrade faster than distance-3 as logical error probability approaches 50%.

In principle, the logical performance of a distance-5 code should improve faster than a distance-3 code as physical error rates decrease @fowler2012surface. Over time, we improved our physical error rates, for example by optimising single and two qubit gates, measurement, and data qubit idling @supplement. In Fig.~3c, we show the corresponding performance progression of distance-5 and distance-3 codes. The larger code improved about twice as fast until finally overtaking the smaller code, validating the benefit of increased-distance protection in practice.

To understand the contributions of individual components to our logical error performance, we follow Ref. ~@chen2021exponential and simulate the distance-5 and distance-3 codes while varying the physical error rates of the various circuit components. Because the logical error-suppression factor $Lambda_(d\/(d + 2)) = epsilon_d\/epsilon_(d + 2)$ is approximately inversely proportional to the physical error rate, we can budget how much each physical error mechanism contributes to $1\/Lambda$ as shown in Fig.~4a to assess scaling. This error budget shows that CZ error and data qubit decoherence during measurement and reset are dominant contributors.




#heading(numbering: none)[Algorithmically-relevant error rates with repetition codes]

// [figvision-cn] imgs/fig4_20220712_1300.png
// 子图a是一个堆叠条形图，展示了表面码（Surface code）的
// 误差预算分解。纵轴名为“Surface code error budget, 1/Λ
// _3.5”，范围从0.0到1.0。图中只有一个总高度为1.0的条形柱，
// 由六种不同颜色的色块垂直堆叠而成。从上到下依次为：红色
// 区域代表“1Q”（单量子比特门误差），紫色区域代表“Leakage
// ”（泄露误差），蓝色区域代表“Measure”（测量与重置误差），
// 黄色区域代表“DD”（动态解耦及空闲误差），灰色区域代表“
// CZ stray int”（CZ门杂散相互作用误差），黑色区域代表“CZ
// ”（CZ门主要误差）。该图传达了在特定参数下各物理误差源
// 对总逻辑误差预算的贡献比例。 子图b是一个散点图，对比了
// 表面码和重复码的逻辑误差率随码距的变化。横轴名为“Code
// distance, d”，刻度标记为3、5、15、25；纵轴名为“Logical
// error per cycle, ε_d”，采用对数坐标，范围从10^-7到10^
// -1。图中包含两组数据点：黑色实心圆点代表“Surface code”
// （表面码），分布在左上角（d=3, 5附近）；蓝色实心圆点代
// 表“Repetition code”（重复码），形成一条从左上向右下倾
// 斜的曲线，显示随着码距增加，逻辑误差显著降低。在d大于
// 15的区域，部分浅蓝色数据点被标注为“Removed high-energy
// event”（移除高能事件后的数据），位于深蓝色点的下方。图
// 的右上角嵌入了一个示意图，描绘了d=25的表面码晶格结构，
// 由交替排列的蓝色和黄色节点组成的网格状图案，文字标注为
// “d = 25”。 子图c是一个二维填充等高线图（热力图），展示
// 了误差模型缩放因子s与表面码距离d之间的关系对逻辑误差的
// 影响。横轴名为“Surface code distance, d”，范围从3到25；
// 纵轴名为“Error model scale factor, s”，范围从0.8到1.3。
// 背景颜色从底部的深紫色渐变到顶部的深红色。图中绘制了多
// 条白色等值线，分别标注了不同的逻辑误差率数值：“ε_d < ε
// _{d+2}”、“ε_d = 0.050”、“ε_d = 0.036”、“ε_d = 0.030”、
// “ε_d = 0.020”、“ε_d = 0.014”、“ε_d = 0.010”以及底部的“
// ε_d > ε_{d+2}”。左下角区域标注有绿色文字“Pauli sim.”。
// 图的右侧有一条垂直的双向箭头，将区域划分为三个部分：底
// 部紫色区域标注为“Below threshold”（低于阈值），中间黄
// 色过渡区标注为“Crossover regime”（交叉区域），顶部红色
// 区域标注为“Above crossover”（高于交叉点）。 子图d是一
// 个多组散点图，展示了在不同缩放因子s下，逻辑误差率随表
// 面码距离的变化趋势。横轴名为“Surface code distance, d”，
// 范围从3到25；纵轴名为“Logical error per cycle, ε_d”，
// 线性坐标，范围从0.00到0.06。图中包含六条不同颜色的数据
// 曲线，每条曲线对应一个特定的s值，并配有相应颜色的文字
// 标注。从上到下依次为：深红色点对应“s = 1.3”，橙色点对
// 应“s = 1.2”，浅橙色点对应“s = 1.1”，青绿色点对应“s =
// 1.0”，深紫色点对应“s = 0.9”。此外，底部还有一组深紫色
// 点标注为“Pauli sim.”。整体趋势显示，随着s值的减小，逻
// 辑误差率降低；对于s小于等于1.0的情况，逻辑误差率随码距
// 增加趋于饱和或缓慢下降，而s大于1.0时误差率随码距增加呈
// 上升趋势。
#figure(image("imgs/fig4_20220712_1300.png", width: 89mm),
  caption: [
    #strong[Towards algorithmically-relevant error rates.] #strong[a,] Estimated error budgets for the surface code, based on operation errors (see Fig.~1c) and #emph[Pauli+] simulations. $Lambda_(3  5) = epsilon_3  epsilon_5$. CZ: contributions from CZ error (excluding leakage and stray interactions). CZ stray int: CZ error from unwanted interactions. DD: dynamical decoupling, data qubit idle error during measurement and reset. Measure: measurement and reset error. Leakage: leakage during CZs and due to heating. 1Q: single-qubit gate error. #strong[b,] Logical error for repetition codes. Inset: schematic of the distance-25 repetition code, using the same data and measure qubits as the distance-5 surface code. Smaller codes are subsampled from the same distance-25 data @chen2021exponential.  A high-energy event resulted in an apparent error floor around $10^(- 6)$. After removing the instances nearby (light blue), error decreases more rapidly with code distance. 50 cycles, $5 times 10^5$ repetitions. We also plot the surface code error per cycle from Fig.~3b in black. #strong[c,] Contour plot of simulated surface code logical error per round $epsilon_d$ as a function of code distance $d$ and a scale factor $s$ on the error model in Fig.~1c (Pauli simulation, $s = 1.0$ corresponds to the current device error model). #strong[d,] Horizontal slices from c, each for a value of error model scale factor $s$. $s = 1.3$ is above threshold (larger codes are worse), while $s = 1.2$ to $1.0$ represent the crossover regime, where progressively larger codes get better until a turnaround. $s = 0.9$ is below threshold (larger codes are better).
  ]
)

Even as known error sources are suppressed in future devices, new dominant error mechanisms may arise as lower logical error rates are realised. To test the behaviour of codes with substantially lower error rates, we employ the bit-flip repetition code, a 1D version of the surface code. The bit-flip repetition code does not correct for phase flip errors and is thus unsuitable for quantum algorithms. However, correcting only bit-flip errors allows it to achieve much lower logical error probabilities.

Without post-selection, we achieve a logical error per cycle of $( 1.7 plus.minus 0.3 ) times 10^(- 6)$ using a distance-25 repetition code decoded with minimum-weight perfect matching. We attribute many of these high-distance logical errors to a high-energy impact, which can temporarily impart widespread correlated errors to the system @mcewen2022resolving. These events may be identified by spikes in detection-event counts @chen2021exponential, and such error mechanisms must be mitigated for scalable quantum error correction to succeed. In this case, there was one such event; after removing it (0.15% of trials), we observe a logical error per cycle of $( 1.6 plus.minus 0.8 ) times 10^(- 7)$ @supplement. The repetition code results demonstrate that low logical error rates are possible in a superconducting system, but finding and mitigating highly correlated errors such as cosmic ray impacts will be an important area of research moving forward.




#heading(numbering: none)[Towards large-scale quantum error correction]

To understand how our surface code results project forward to future devices, we simulate the logical error performance of surface codes ranging from distance-3 to 25, while also scaling the physical error rates shown in Fig.~1c. For efficiency, the simulation considers only Pauli errors. Figures 4c-d illustrate the contours of this parameter space, which has three distinct regions. When the physical error rate is high (for example, the initial runs of our surface code in the inset of Fig.~3), logical error probability increases with increasing system size ($epsilon_(d + 2) > epsilon_d$). On the other hand, low physical error rates show the desired exponential suppression of logical error ($epsilon_(d + 2) < epsilon_d$). Our experiment lies in a crossover regime where, due to finite-size effects, increasing system size initially suppresses the logical error rate before later increasing it.

While our device is close to threshold, reaching algorithmically-relevant logical error rates with manageable resources will require an error-suppression factor $Lambda gt.double 1$. Based on the error budget and simulations in Fig.~4, we estimate that component performance must improve by at least 20% to move below threshold, and significantly improve beyond that to achieve practical scaling. However, these projections rely on simplified models and must be validated experimentally, testing larger code sizes with longer durations to eventually realise the desired logical performance. This work demonstrates the first step in that process, suppressing logical errors by scaling a quantum error-correcting code -- the foundation of a fault-tolerant quantum computer.



#heading(numbering: none)[Author Contributions]

The Google Quantum AI team conceived and designed the experiment. The theory and experimental teams at Google Quantum AI developed data analysis, modeling and metrological tools that enabled the experiment, built the system, performed the calibrations, and collected the data. The modeling was done jointly with collaborators outside Google Quantum AI. All authors wrote and revised the manuscript and the Supplementary Information.



#heading(numbering: none)[Acknowledgements]

We are grateful to S. Brin, S. Pichai, R. Porat, J. Dean, E. Collins, and J. Yagnik for their executive sponsorship of the Google Quantum AI team, and for their continued engagement and support. A portion of this work was performed in the UCSB Nanofabrication Facility, an open access laboratory. J. Marshall acknowledges support from NASA Ames Research Center (NASA-Google SAA 403512), NASA Advanced Supercomputing Division for access to NASA HPC systems, and NASA Academic Mission Services (NNA16BD14C). D. Bacon is a CIFAR Associate Fellow in the Quantum Information Science Program.

#heading(numbering: none)[Data availability]

The data that support the plots within this paper and other findings of this study are available upon reasonable request, or at #link("https://doi.org/10.5281/zenodo.6804040")[10.5281/zenodo.6804040].

#block[
Google Quantum AI:

]

#bibliography("refs.bib", style: "ieee", title: none)


#pagebreak()

#block[
#strong[Supplemental materials for #emph[Suppressing quantum errors by scaling a surface code logical qubit]]

#figure(
  align(center)[#table(
    columns: 1,
    align: (center,),
    [Google Quantum AI],
    [(Dated: July 21, 2022)],
  )]
  , kind: table
  )

]

#pagebreak()


#figure(
  scale(86%, reflow: true, cetz.canvas({
    import cetz.draw: *

    let med = rgb("#6ba3e8")
    let lt = rgb("#cfe0f5")
    let grey = rgb("#9a9a9a")
    let blk = rgb("#000000")
    let lw = (thickness: 1pt, paint: blk)

    // ---------------- left panel: $(x, y)$ frame ----------------
    let ox = 1.5
    let oy = .85
    let u = .32
    let X(x) = ox + x * u
    let Y(y) = oy + y * u

    // boundary (weight-2) stabiliser tiles, inner halves hidden by the tiles
    for b in ((2, 9), (6, 9), (4, 1), (8, 1), (1, 4), (1, 8), (9, 2), (9, 6)) {
      circle((X(b.at(0)), Y(b.at(1))), radius: 1 * u, fill: lt, stroke: none)
    }
    // the sixteen weight-4 stabiliser tiles
    for i in range(4) {
      for j in range(4) {
        let f = if calc.rem(i + j, 2) == 0 { med } else { lt }
        rect((X(1 + 2 * i), Y(1 + 2 * j)), (X(3 + 2 * i), Y(3 + 2 * j)),
          fill: f, stroke: none, radius: .1)
      }
    }
    // axes
    line((X(0), Y(0)), (X(10.2), Y(0)), stroke: lw)
    line((X(0), Y(0)), (X(0), Y(10.2)), stroke: lw)
    for t in range(11) {
      let len = if calc.rem(t, 5) == 0 { .14 } else { .07 }
      line((X(t), Y(0)), (X(t), Y(0) - len), stroke: lw)
      line((X(0), Y(t)), (X(0) - len, Y(t)), stroke: lw)
    }
    for t in (0, 5, 10) {
      content((X(t), Y(0) - .38), text(size: 8.5pt, str(t)))
      content((X(0) - .38, Y(t)), text(size: 8.5pt, str(t)))
    }
    content((X(5), Y(0) - .82), text(size: 9pt, [$x$]))
    content((X(0) - .85, Y(5)), text(size: 9pt, [$y$]))

    // ---------------- right panel: $(row, column)$ frame ----------------
    let cx = 9.3
    let cy = 2.85
    let s = .40
    let k = s / calc.sqrt(2)
    let RX(i, j) = cx + (i - j) * k
    let RY(i, j) = cy + (i + j - 6) * k

    // stabiliser tiles on the measure-qubit sublattice
    for i in range(7) {
      for j in range(7) {
        if calc.rem(i + j, 2) == 1 {
          let f = if calc.rem(i + j, 4) == 1 { med } else { lt }
          polygon((RX(i, j), RY(i, j)), 4, angle: 0deg, radius: .707 * s,
            fill: f, stroke: none)
        }
      }
    }
    // all 49 qubits
    for i in range(7) {
      for j in range(7) {
        circle((RX(i, j), RY(i, j)), radius: .085, fill: grey, stroke: none)
      }
    }
    // the original $x$ and $y$ axes, now diagonal
    line((RX(0, 6) - .18, RY(0, 6) + .18), (RX(6, 6) + .06, RY(6, 6) - .06), stroke: lw)
    line((RX(0, 6) - .18, RY(0, 6) - .18), (RX(0, 0) + .06, RY(0, 0) + .06), stroke: lw)
    content((RX(3, 6) - .3, RY(3, 6) + .22), text(size: 9pt, [$y$]))
    content((RX(0, 3) - .3, RY(0, 3) - .3), text(size: 9pt, [$x$]))

    // column axis (top) and row axis (left)
    let cxa(t) = cx - 3 * k + t * (.6 * k)
    let cya = cy + 6 * k + .6
    line((cxa(0), cya), (cxa(10), cya), stroke: lw)
    for t in range(11) {
      let len = if calc.rem(t, 5) == 0 { .14 } else { .07 }
      line((cxa(t), cya), (cxa(t), cya - len), stroke: lw)
    }
    for t in (0, 5, 10) {
      content((cxa(t), cya + .3), text(size: 8.5pt, str(t)))
    }
    content((cx, cya + .82), text(size: 9pt, [#emph[Column]]))

    let rya(r) = cy + 3 * k - r * (.6 * k)
    let rxa = cx - 6 * k - .55
    line((rxa, rya(0)), (rxa, rya(10)), stroke: lw)
    for r in range(11) {
      let len = if calc.rem(r, 5) == 0 { .14 } else { .07 }
      line((rxa, rya(r)), (rxa + len, rya(r)), stroke: lw)
    }
    for r in (0, 5, 10) {
      content((rxa - .32, rya(r)), text(size: 8.5pt, str(r)))
    }
    content((rxa - .95, rya(5)), text(size: 9pt, [#emph[Row]]))
    content((cx, cy - 7.4 * k), text(size: 8.5pt, [(row, column)]))
  })),
  caption: [
    #strong[Qubit coordinates.] Left: Distance-5 surface code as presented in the main text, with an $( x y )$ coordinate system indicated. Right: Rotated coordinate system used for heatmap plots in the supplement, using (row, column).
  ]
) <fig:sup_ksatz_coordinates>

= EXPERIMENTAL DETAILS <experimental-details>

== Idling errors <idling-errors>

A significant contribution to the logical error budget is data qubit decoherence during the readout and reset of the measure qubits. The primary decoherence mechanism is dephasing induced by low frequency flux noise. We mitigate dephasing through dynamical decoupling with XY-4 phase cycling, which compensates first-order pulse errors and protects arbitrary quantum states equally. As mentioned in the main text, the specific dynamical decoupling sequence is chosen on a per-qubit basis in order to tailor the sequence filter function to each qubit's unique noise environment.

== Optimizing gate parameters <sec:snake>

// [figvision-cn] imgs/figure_snake.png
// 该图由两行六列共十二个子图组成，展示量子处理器在不同误
// 差机制启用及优化阶段的频率配置演变。每行代表一种可视化
// 方式：上行为网格状像素热图（Idle 和 Interaction 频率），
// 下行为六边形晶格节点图（对应物理量子比特布局）。左侧纵
// 轴标注“Frequency (a.u.)”，颜色条从深紫色（低频）经蓝色、
// 绿色至黄色（高频），红色表示异常高值或错误事件。 第一
// 列（初始状态）： 上行：全深紫色正方形区域，表示无约束
// 处理器中所有位置空闲频率与相互作用频率均处于最低且均匀
// 水平。 下行：六边形晶格全部为深紫色节点，中心对称排列，
// 外围呈星形扩展，每个节点代表一个量子比特，初始频率一致。
// 第二列（+ Pulse Distortions）： 上行：出现棋盘格图案，
// 深蓝与浅绿交替分布，右上角局部出现黄色方块，表明脉冲畸
// 变导致部分位置频率升高并产生近简并相互作用。 下行：多
// 数节点仍为深紫，但右侧边缘及部分内部节点变为浅蓝或浅绿，
// 显示频率开始分化，尤其右半部有轻微抬升。 第三列（+
// Parasitic Crosstalk）： 上行：棋盘格更明显，黄绿色块增
// 多并向中心扩散，左下角新增一块亮黄色区域，反映串扰引入
// 额外频率偏移。 下行：更多节点转为青绿或浅绿，尤其右下
// 象限密集出现中等频率节点，整体频率分布不均加剧。 第四
// 列（+ Coherence, Other）： 上行：颜色进一步混合，黄绿
// 主导，局部出现橙色过渡，左上角有一小块红色斑点，提示相
// 干性误差引发局部频率异常。 下行：大部分节点为青绿至浅
// 绿，少数深紫残留于左上角，右下角仍有黄色节点，整体频率
// 梯度增强。 第五列（Error Event(s)）： 上行：中央偏左出
// 现大面积鲜红色区域，周围环绕橙黄，其余区域保持黄绿为主，
// 标示严重错误事件集中爆发。 下行：对应位置多个连续节点
// 变为鲜红色，形成垂直条带，邻近节点为橙黄，清晰指示错误
// 传播路径。 第六列（Locally Reoptimize）： 上行：红色消
// 失，恢复为黄绿主导的棋盘格，但局部颜色微调，如左上角略
// 偏蓝，表明局部重优化成功抑制错误。 下行：红色节点完全
// 消除，重新分布为青绿与浅绿组合，仅个别节点保留淡黄，系
// 统回归稳定态。 箭头连接各列，标注依次为：“+ Pulse
// Distortions”、“+ Parasitic Crosstalk”、“+ Coherence,
// Other”、“Error Event(s)”、“Locally Reoptimize”，指示演
// 化顺序。整图传达结论：逐步启用误差机制使频率分布复杂化
// 并诱发错误，而局部重优化可有效修复错误并恢复可控频率构
// 型。
#figure(placement: auto, image("imgs/figure_snake.png", width: 100%),
  caption: [
    Idle (top) and interaction (bottom) frequencies found by our Snake optimizer as error mechanisms are progressively enabled. Readout parameters are not shown. Starting from an unconstrained processor, enabling pulse distortions results in an idle checkerboard with nearly-degenerate interactions. This configuration minimizes frequency-sweeps during CZ gates. Enabling crosstalk results in idle and interaction patterns that resemble multi-layer checkerboards. This configuration minimizes frequency collisions over the surface-code. Finally, enabling dephasing, relaxation, and other error mechanisms leads to frequency configurations with no obvious structure. After optimization, random error events can render arbitrary gates unusable (red). In such scenarios, we locally reoptimize parameters and stitch solutions. Color scales were chosen to maximize contrast.
  ],
  scope: "parent"
) <fig:snake>

Our quantum processor employs frequency-tunable qubits on a two-dimensional lattice with coupler-mediated nearest-neighbor coupling and dispersive readout. Quantum logic is implemented via single-qubit (SQ), two-qubit (CZ), and readout (RO) gates. SQ gates are implemented via resonant microwave pulses at qubits' respective $f_10$#emph[idle] frequencies. CZ gates are implemented by sweeping qubit pairs into $f_10  f_21$ resonance at respective #emph[interaction] frequencies and actuating respective couplers. RO gates are implemented by sweeping qubits'$f_10$ frequencies to respective #emph[readout] frequencies and measuring them via variable-amplitude and -length readout pulses. Most error mechanisms depend strongly on gate frequencies and readout-pulse parameters, which we refer to collectively as #emph[gate parameters]. Optimizing gate parameters is a critical error mitigation strategy necessary for state-of-the-art surface-code performance @arute2019quantum @chen2021exponential.

To optimize gate parameters, we developed a surface-code objective through benchmarking and machine learning. It includes error contributions from relaxation, dephasing, crosstalk, and pulse distortion, along with various heuristics. Furthermore, it embeds the surface code circuit and it's mapping onto our processor. To offer a sense of scale, the distance-5 objective incorporates $O ( 10^4 )$ error terms and is defined over 49 idle, 49 readout, and 80 interaction frequencies, and 49 readout pulse amplitudes and 49 lengths. It is noisy, non-convex, and all parameters are explicitly or implicitly intertwined due to engineered interactions and/or crosstalk. Furthermore, since each parameter is constrained to $tilde 10^2$ values by the control electronics, processor circuit, and gate parameters, the search-space is $tilde 10^552$. This space is intractable to search exhaustively and traditional global optimizers do not perform well on the objective. Therefore, we invented the Snake optimizer to address it @klimov2020snake.

The Snake leverages concepts in graph optimization and dynamic programming to split complex high-dimensional optimization problems into simpler lower-dimensional subproblems. One key hyperparameter of the Snake is the subproblem dimension, which enables us to trade optimization complexity for accessible solutions. We operate the Snake in an intermediate dimensional regime that benefits from the speed of local search and non-locality of global search. This strategy outperforms local and global optimization in convergence rate and error on the distance-5 objective. Furthermore, we believe it will scale towards fault-tolerant processors.

To illustrate how the Snake trades between error mechanisms, we plot optimized idle and interaction frequencies as error mechanisms are progressively enabled in @fig:snake. Readout parameters experience similar tradeoffs but are not shown. After optimization, some gates unexpectedly experience uncharacteristically large error rates. These events happen randomly and are often due to spurious resonances, for example due to two-level-system defects, moving into the path of SQ and/or CZ gates @klimov2018tls. Reoptimizing all gates after such failures is unscalable due to considerations including calibration runtime. Instead, we use the Snake to locally reoptimize failing gates and stitch solutions. To improve the quality and longevity of our solutions, we employ higher dimensional optimization and embed historical data into our objective.

== Single qubit gates <single-qubit-gates>
Single qubit gates are implemented through a combination of microwave $X Y$ rotations and virtual $Z$ rotations. All microwave pulses utilize DRAG pulse shaping to mitigate leakage from off-resonant driving of the $| 1 chevron.r arrow.l.r | 2 chevron.r$ transition, as detailed in @chen2021exponential. We assess our single qubit gate performance through randomized benchmarking, acting on all qubits simultaneously. A summary of our single qubit device parameters, including operating frequencies, coherence times, and gate errors can be found in @fig:sq_parameters.

// [figvision-cn] imgs/sq_parameters.png
// 该图像包含六个子图，标记为a至f，排列成两行三列的网格布
// 局。所有子图均为热图（Heatmap），展示了一个9x9量子比特
// 阵列中各个位置单量子比特参数的空间分布。每个子图的横轴
// 表示“column”（列），纵轴表示“row”（行），坐标范围均为1
// 到9。由于量子芯片的物理布局限制，并非所有81个网格位置
// 都有数据，实际数据点呈不规则的十字形或T字形分布。颜色
// 从深紫色/蓝色渐变到绿色、黄色再到红色，通常代表数值从
// 低到高。每个有数据的方格内都标注了具体的数值。 子图 a
// 类型：热图 标题：Qubit f10 [GHz] （基态到第一激发态跃
// 迁频率） 坐标轴：横轴 column (1-9)，纵轴 row (1-9)。
// 物理含义：展示各量子比特的共振频率 $f_{10}$。 数据与趋
// 势：频率值分布在5.74 GHz到6.26 GHz之间。大部分区域集中
// 在5.90-6.10 GHz。例如，位于(row=1, col=4)的值为5.94，(
// row=3, col=7)的值为6.25。右下角(row=6, col=7)处的值为
// 6.31，是局部较高值；而(row=6, col=1)处的值为5.75，相对
// 较低。整体分布较为均匀，但存在局部波动。 子图 b 类型：
// 热图 标题：Qubit f10 - f21 [MHz] （工作频率下的非谐性）
// 坐标轴：横轴 column (1-9)，纵轴 row (1-9)。 物理含义：
// 展示各量子比特的非谐性参数（anharmonicity）。 数据与趋
// 势：数值主要集中在259 MHz到271 MHz之间。大多数格子显示
// 为深蓝色或紫色，对应数值约262-265 MHz。少数几个格子呈
// 现黄色或浅绿色，表示较高的非谐性，如(row=3, col=2)为
// 277，(row=6, col=1)为271，(row=7, col=4)为271。这表明
// 大部分量子比特的非谐性非常一致，仅有少量偏差较大的个体。
// 子图 c 类型：热图 标题：Maximum qubit frequency [GHz]
// （最大可实现量子比特频率） 坐标轴：横轴 column (1-9)，
// 纵轴 row (1-9)。 物理含义：展示通过调节控制线能达到的
// 最高量子比特频率。 数据与趋势：数值范围约为5.84 GHz到
// 6.38 GHz。颜色分布显示出明显的梯度变化，右上角和中部偏
// 右区域（如row 3-5, col 6-8）多为黄色和绿色，数值在
// 6.24-6.38之间，表明这些位置的量子比特具有更高的可调频
// 上限。相比之下，左侧边缘（col 1-2）和底部部分区域颜色
// 较深，数值较低（如5.84, 5.96）。 子图 d 类型：热图 标
// 题：Qubit T1 [us] （量子比特弛豫时间） 坐标轴：横轴
// column (1-9)，纵轴 row (1-9)。 物理含义：展示能量弛豫
// 时间 $T_1$，反映量子比特保持能量状态的能力。 数据与趋
// 势：数值范围从12.9 us到26.8 us。图中颜色差异较大，表明
// 不同位置的 $T_1$ 时间存在显著的空间不均匀性。例如，(
// row=3, col=7)处仅为12.9 us（深紫色），而(row=5, col=4)
// 处高达26.0 us（亮黄色）。(row=7, col=5)处也达到26.8 us。
// 这种分布暗示了制造过程中某些区域的退相干损耗更严重。
// 子图 e 类型：热图 标题：Qubit T2 [us] （CPMG测量的量子
// 比特退相干时间） 坐标轴：横轴 column (1-9)，纵轴 row (
// 1-9)。 物理含义：展示通过CPMG脉冲序列测量得到的相位相
// 干时间 $T_2$。 数据与趋势：数值范围从14.8 us到45.5 us。
// 同样表现出强烈的空间依赖性。右侧边缘(col=9)附近有几个
// 高值点，如(row=5, col=9)为45.5 us，(row=6, col=9)为
// 41.1 us。中心区域及左下角数值普遍较低，多在20-30 us之
// 间，如(row=5, col=5)为16.5 us。这说明退相干性能在不同
// 位置差异巨大。 子图 f 类型：热图 标题：Single qubit
// gate error [%] （同时单量子比特门误差） 坐标轴：横轴
// column (1-9)，纵轴 row (1-9)。 物理含义：展示执行单量
// 子比特逻辑门时的平均错误率百分比。 数据与趋势：数值范
// 围从0.03%到0.15%。绝大多数格子的误差低于0.10%，呈现深
// 蓝色或青色。只有少数几个点误差略高，如(row=4, col=5)为
// 0.15%（橙色），(row=3, col=4)为0.11%（浅绿）。整体上，
// 该阵列的单量子比特门保真度非常高，错误率控制在千分之一
// 以下，且分布相对均匀，仅在个别位置略有劣化。
#figure(placement: auto, image("imgs/sq_parameters.png", width: 100%),
  caption: [
    Heatmaps of various single qubit parameters: #strong[a,] ground to first excited state transition frequency. #strong[b,] Qubit anharmonicity at the operating frequency. #strong[c,] Maximum achievable qubit frequencies. #strong[d,] Qubit relaxation time. #strong[e,] Qubit decoherence time as measured by CPMG. #strong[f,] Simultaneous single-qubit gate error.
  ],
  scope: "parent"
) <fig:sq_parameters>

== Two qubit gates <two-qubit-gates>
The two qubit gate utilized in this work is the controlled-Z (CZ) gate. CZ gates in the sycamore architecture arise from a state-selective dispersive shift on the two qubit state $| 11 chevron.r$, which is introduced through a tunable coupling in the two excitation manifold, as detailed in @foxen2020demonstrating. We assess our CZ gate performance by performing cross-entropy benchmarking (XEB). In a single round of error correction in the surface code, CZ gates are applied in layers which correspond to their position in a given stabilizer. Therefore, to more accurately represent the CZ performance in the surface code, we perform simultaneous XEB on pairs using their respective CZ layers. We summarize our CZ gate parameters and measured errors in @fig:cz_parameters.

// [figvision-cn] imgs/cz_parameters.png
// 该图由三个并列的六边形网格热图组成，分别标记为 a、b 和
// c。所有子图共享相同的空间布局：横轴表示“column”（列），
// 纵轴表示“row”（行），刻度范围均为 1 至 9。每个子图中的
// 数据点以倾斜排列的六边形单元呈现，形成类似蜂窝状的晶格
// 结构，对应于二维量子处理器中相邻超导量子比特之间的耦合
// 关系。灰色虚线勾勒出部分未激活或无效的连接区域。 子图
// a：标题为 “Interaction frequency [GHz]”，类型为热图。
// 横轴标注 “column”，纵轴标注 “row”，两者均从 1 到 9。每
// 个六边形内填充颜色并标注数值，代表两个耦合量子比特执行
// CZ 门时的相互作用频率（单位 GHz）。颜色从深紫色（低频）
// 渐变至亮黄色（高频），具体数值分布在 5.76 至 6.19 GHz
// 之间。例如，位于 row=4, column=3 的六边形值为 5.85；
// row=6, column=4 为 6.00；row=2, column=5 为 6.09。整体
// 趋势显示中心区域频率略高，边缘偏低，但变化幅度小于 0.5
// GHz，表明系统调谐一致性较好。 子图 b：标题为 “
// Effective qubit-qubit coupling efficiency [%]”，类型为
// 热图。坐标轴与子图 a 相同。每个六边形内标注百分比数值，
// 表示有效量子比特间耦合效率。颜色从深蓝色（低效）过渡到
// 亮绿色/黄色（高效），数值范围在 0.63% 至 0.88% 之间。
// 例如，row=3, column=4 处为 0.85；row=7, column=5 处为
// 0.88；row=9, column=5 处为 0.83。多数区域集中在 0.80–
// 0.85%，仅少数位置低于 0.70%（如 row=6, column=4 为
// 0.72），表明耦合效率普遍较高且分布均匀。 子图 c：标题
// 为 “CZ error [%]”，类型为热图。坐标轴与前两图一致。每
// 个六边形内标注数值，表示通过 XEB（交叉基准测试）及表面
// 码层测量得到的 CZ 门误差百分比。颜色从深紫色（低误差）
// 经蓝色、青色、绿色至亮黄色（高误差）。数值范围从 0.21%
// 到 1.25%。显著异常点包括：row=6, column=4 处误差高达
// 1.25%（亮黄色）；row=5, column=4 为 1.16%；而大部分区
// 域误差在 0.30–0.50% 之间。此外，row=2, column=4 为
// 0.30%，row=8, column=5 为 0.31%，属于较低误差区。图中
// 存在局部热点（如第 4 列中部），暗示该区域可能存在控制
// 噪声或校准偏差。 三幅子图共同展示同一组量子比特对的三
// 个关键性能指标：相互作用频率、耦合效率和门保真度（以误
// 差形式体现）。数据显示系统在频率和耦合效率上高度一致，
// 但在特定位置（尤其是第 4 列附近）出现明显的门误差升高，
// 提示需针对性优化这些区域的脉冲序列或硬件参数。
#figure(placement: auto, image("imgs/cz_parameters.png", width: 100%),
  caption: [
    Heatmaps of various two qubit gate parameters: #strong[a,] frequency where two coupled qubits interact to perform a CZ gate. #strong[b,] The effective coupling efficiency between two qubits. #strong[c,] CZ gate error as measured by XEB and in the surface code layers.
  ],
  scope: "parent"
) <fig:cz_parameters>

== Measurement and reset <measurement-and-reset>
Every qubit on the Sycamore processor has a dedicated resonator used for measurement and reset of the qubit state, see details in Refs.~@arute2019quantum @chen2021exponential @mcewen_removing_2021. In @fig:readout_parameters (a-d) we summarize various parameters related to the resonators and the measurement chain. Feeding those parameters into models for different readout and reset error mechanisms, we optimize three readout parameters (qubit frequenecy during readout, readout pulse length, and readout pulse power) individually for each qubit. The total readout time is kept at 500 ns for each qubit; however for measure qubits we need the respective resonators to be empty before reset starts so we include time (equal to 500 ns minus the readout pulse length) for the resonators to ring down. The optimization is done using the Snake optimizer, see @sec:snake. For instance, we model errors due to finite signal-to-noise ratio, qubit relaxation during readout, swapping between neighboring qubits, and qubit state transition due to the resonator drive @sank2016measurement. The optimized values are found in @fig:readout_parameters (e-g). In the end, we benchmark readout by preparing and measuring a random set of qubit states, summarized in @fig:readout_parameters (h).

// [figvision-cn] imgs/readout_parameters.png
// 该图像由八个子图（a至h）组成，排列成两行四列的网格。所
// 有子图均为热图，用于展示不同读出参数在9x9阵列中的分布
// 情况。每个子图的纵轴表示“row”（行），横轴表示“column”
// （列），坐标范围均为1到9。每个单元格内的数值代表特定位
// 置的测量值，颜色深浅反映数值大小，颜色映射在各图中略有
// 差异但总体遵循从冷色（低值）到暖色（高值）或反之的渐变
// 规律。 子图a：标题为“Bare resonator frequency [GHz]”。
// 这是一个热图，显示每个读出谐振器的裸频率。纵轴为row（
// 1-9），横轴为column（1-9）。每个单元格内标注具体频率值
// （单位GHz），例如左上角(1,4)为4.83 GHz，右下角(9,5)为
// 4.82 GHz。颜色从深蓝（约4.72 GHz）过渡到亮黄/绿（约
// 4.88 GHz）。趋势显示频率在中心区域略高，边缘偏低，整体
// 波动较小（±0.06 GHz）。 子图b：标题为“Ringdown time [
// ns]”。热图形式，纵轴row（1-9），横轴column（1-9）。单
// 元格内数值单位为纳秒（ns），如(1,4)=32 ns，(9,5)=30 ns。
// 颜色从深紫（~20 ns）到亮绿（~40 ns）。可见第5列和第6列
// 部分位置出现较高环降时间（>35 ns），其余多数在25–30 ns
// 之间，表明某些谐振器衰减较慢。 子图c：标题为“
// Resonator-qubit coupling [%]”。热图，坐标同上。数值范
// 围为2.7%至2.9%，如(1,4)=2.8%，(5,5)=2.9%。颜色从浅蓝（
// 2.7%）到黄色（2.9%）。耦合效率高度均匀，绝大多数为2.8%，
// 仅少数点偏离±0.1%，说明系统耦合一致性良好。 子图d：标
// 题为“Measurement efficiency [%]”。热图，坐标同上。数值
// 范围12%至28%，如(1,4)=22%，(5,5)=25%。颜色从深紫（~12%）
// 到亮绿（~28%）。效率在中心区域（row 3–7, column 4–6）
// 普遍高于20%，边缘较低，尤其(9,5)=16%、(9,6)=20%等位置
// 明显偏低，提示边缘测量链性能下降。 子图e：标题为“Qubit
// frequency during readout [GHz]”。热图，坐标同上。数值
// 范围5.76 GHz至6.18 GHz，如(1,4)=5.87 GHz，(5,8)=6.18
// GHz。颜色从深蓝（~5.76 GHz）到亮黄（~6.18 GHz）。频率
// 在右侧列（column 7–9）显著升高，左侧较稳定在5.8–5.9
// GHz，表明优化后qubit频率随位置调整以匹配谐振器。 子图f：
// 标题为“Readout pulse length [ns]”。热图，坐标同上。数
// 值范围200 ns至410 ns，如(1,4)=260 ns，(5,1)=400 ns。颜
// 色从深紫（~200 ns）到亮黄（~410 ns）。脉冲长度在左下角
// （row 5–6, column 1–2）最长（>370 ns），右上角较短（~
// 220–260 ns），反映不同位置需不同积分时间以达到最优信噪
// 比。 子图g：标题为“Readout pulse power [dBm]”。热图，
// 坐标同上。数值范围-132 dBm至-119 dBm，如(1,4)=-129 dBm，
// (5,1)=-132 dBm。颜色从深紫（~-132 dBm）到亮黄（~-119
// dBm）。功率在左侧和底部边缘偏低（<-128 dBm），中心及右
// 上区域偏高（>-124 dBm），显示驱动功率按位置微调以补偿
// 损耗或非线性效应。 子图h：标题为“Avg readout error [%]
// ”。热图，坐标同上。数值范围1.1%至4.2%，如(1,4)=2.0%，(
// 5,1)=4.2%。颜色从深紫（~1.1%）到亮黄（~4.2%）。平均读
// 出误差在左下角（row 5–6, column 1–2）最高（>3.5%），中
// 心及右上区域最低（<1.5%），表明优化后大部分位置误差控
// 制在2%以内，但边缘仍较差。 综上，八张热图共同描绘了一
// 个9x9量子比特阵列中各读出参数的空间分布特征，揭示了系
// 统在频率、耦合、效率、脉冲参数及误差方面的局部异质性，
// 为后续硬件校准与算法优化提供定量依据。
#figure(placement: auto, image("imgs/readout_parameters.png", width: 100%),
  caption: [
    Heatmaps of various readout parameters: #strong[a,] bare frequency of each readout resonator. #strong[b,] Ringdown time (equal to $1  kappa$) of each resonator. #strong[c,] The coupling efficiency between resonator and qubit. #strong[d,] Efficiency of the measurement chain close to the readout frequency. #strong[e,] Optimized qubit frequency during readout (in the absence of a readout drive). #strong[f,] Optimized readout pulse lengths. #strong[g,] Optimized readout pulse power referenced to the input of the readout resonator and calibrated using the AC-Stark shift. #strong[h,] Measured average readout error over $|0⟩$ and $|1⟩$ when preparing a random set of qubit states across all 49 qubits.
  ],
  scope: "parent"
) <fig:readout_parameters>

== Microwave crosstalk induced leakage mitigation <microwave-crosstalk-induced-leakage-mitigation>

// [figvision-cn] imgs/figure_microwave_xtalk_leakage.png
// 子图a)：示意图。展示量子比特阵列的脉冲序列控制逻辑。左
// 侧标注“receiver qubit”指向最上方一行，该行包含多个圆角
// 矩形框，每个框内标有希腊字母π，表示施加π脉冲；相邻两个
// π脉冲之间用双向箭头连接并标注时间间隔t。下方标注“
// source qubits”，并用大括号括起多行相同的结构（每行均为
// 一系列π脉冲），中间以垂直排列的三个黑点省略号表示存在
// 更多源量子比特行。最右侧最后一个方框内绘有一个双能级系
// 统符号（两条水平线加一个向上弯曲的箭头），旁边标注数字
// 2，表示最终测量或激发至第二激发态。整体布局从左到右表
// 示时间演化过程，体现接收量子比特与多个源量子比特同步受
// 控于周期性π脉冲序列。 子图b)：曲线图。横坐标为t (ns)，
// 范围0至100 ns，刻度标记0、50、100；纵坐标为p₂，范围0.0
// 至0.3以上，刻度标记0.0、0.1、0.2、0.3。图中蓝色实线描
// 绘p₂随t变化的函数关系，呈现三个尖锐峰值：第一个峰位于
// 约t=5 ns处，高度超过0.3；第二个峰位于约t=50 ns处，高度
// 约0.25；第三个峰位于约t=95 ns处，高度约0.15。在第一个
// 峰值左侧有一黑色左向箭头，指向该峰，并标注文字“optimal
// t”。其余区域p₂值接近0.0，表明仅在特定时间点出现显著概
// 率响应。 子图c)：曲线图。横坐标为“source qubit index”，
// 范围0至40以上，刻度标记0、20、40；纵坐标为p₂，范围0.0
// 至0.3以上，刻度标记0.0、0.1、0.2、0.3。图中蓝色实线显
// 示p₂随源量子比特索引的变化：在索引约等于5处出现单一尖
// 锐峰值，高度超过0.3；其余所有索引位置p₂值均低于0.05，
// 基本贴近基线。表明仅当选择特定编号的源量子比特时，才能
// 获得高概率激发。 子图d)：二维热图（颜色映射图）。横坐
// 标为r，范围0.00至0.08，刻度标记0.00、0.02、0.04、0.06、
// 0.08；纵坐标为θ，范围-2至2以上，刻度标记-2、0、2。图中
// 网格单元按p₂值着色，右侧垂直色条标注p₂值从深紫色（≈0.0）
// 经绿色过渡到黄色（≈0.4+）。图像中央偏左区域（r≈0.01, θ
// ≈0）有一个红色五角星标记，其周围为黄绿色高亮区，对应p₂
// 最大值区域。随着r增大或|θ|增大，颜色逐渐变为蓝紫色，表
// 示p₂下降。整体呈现围绕中心点的辐射状衰减分布，且在不同
// (r, θ)组合下存在干涉条纹样式的明暗交替带。
#figure(placement: auto, 
  block(width: 100%)[
    #block(width: 3.5in)[
      #image("imgs/figure_microwave_xtalk_leakage.png", width: 100%)
      #v(0.65em)
      #align(left)[#context [Figure #counter(figure.where(kind: image)).display():] Mitigation of microwave crosstalk induced leakage. #strong[a,] The Ramsey error filter pulse sequence consists of $pi$ rotations separated by a variable delay $t$. We repeat this several times to amplify the coherent leakage, which we observe by direct measurement of $|2⟩$. #strong[b,] Leakage probability $p 2$ vs $t$ during the Ramsey error filter. This data is taken with all sources operating in parallel. The $t$ that maximizes leakage is held fixed throughout the remainder of the calibration sequence. #strong[c,] $p 2$ vs source qubit during pairwise operation at optimal $t$. The peak identifies the dominant source. #strong[d,] $p 2$ after Ramsey error filter during pairwise operation with the dominant source vs r and $theta$, the magnitude and phase of the compensation tone used to null the crosstalk leakage. The red star indicates the optimal $r$ and $theta$.]
    ]
  ],
  caption: none,
  scope: "parent",
) <fig:xtalk_leakage>

Leakage out of the computational subspace is an important error class as it leads to correlated error patterns during error detection. Microwave crosstalk is one mechanism that causes leakage during single qubit gates. If the drive frequency is near f21 of the receiver qubit, a parasitic $| 1⟩ arrow.r | 2⟩$ leakage error can result.

To mitigate this leakage channel we apply a compensation pulse, out of phase with the parasitic drive, directly to the receiver qubit to null this leakage. We apply a signal $V' (t) = V (t) r e^(i theta)$ for $V'$ the applied compensation, $V$ the source signal. In this section we outline our procedure for calibrating the parameters $r$ and $theta$.

We use a procedure based on the Ramsey error filter pulse sequence, @fig:xtalk_leakage, to calibrate the magnitude and phase of the compensation tone. For certain delay times $t$, this sequence amplifies the coherent crosstalk leakage to facilitate the calibration. This amplification can be understood as a result of constructive interference between the leakage amplitudes induced by successive pulses.

@fig:xtalk_leakage shows representative data from the Ramsey error filter vs delay time $t$. This data is taken while driving all qubits in parallel to minimize data acquisition time. In the following calibration steps, $t$ is held fixed at the value that maximizes the leakage population $p 2$. In @fig:xtalk_leakage, we show the output of the Ramsey error filter at optimal $t$ during pairwise operation for all possible pairs that include the receiver qubit. This data identifies the source of the parasitic drive.

@fig:xtalk_leakage shows $p 2$ on the receiver qubit during pairwise operation with the dominant source qubit at optimal $t$ vs the amplitude $r$ and phase $theta$ of the compensation tone. The red star indicates the optimal $r$ and $theta$ to mitigate crosstalk induced leakage.

== Surface code experimental details <surface-code-experimental-details>

=== Surface code circuits <surface-code-circuits>
We present the surface code circuit in Fig.~1b (main text), focusing primarily on two qubits. The circuit generalises across the surface code, which we show here for clarity in @fig:sup_ksatz_circuit1. We also clarify the #emph[ZXXZ] stabilisers and how they relate to other stabilisers in @fig:sub_ksatz_zxxz.

// [figvision-cn] imgs/sup_ksatz_circuit1.png
// 该图展示了距离为5的表面码量子纠错电路的完整操作流程，
// 包含四个主要部分：量子比特布局、初始比特串、基矢设置、
// 量子纠错循环（QEC cycle）、修改后的“回波”X门操作以及最
// 终测量。 第一部分：顶部区域展示基础设置 左上角标题为“
// Qubit layout”（量子比特布局）。图示为一个由圆形节点组
// 成的六边形晶格结构，中心节点为蓝色实心圆，周围环绕一圈
// 黄色实心圆，再外围是一圈浅蓝色空心圆。这代表了数据量子
// 比特和辅助量子比特的空间排列。 中间上方标题为“1.
// Initial bitstring”（初始比特串）。图示为一个4x6的网格，
// 每个格子内有一个数字0或1。第一行是0 0 0 1 0；第二行是0
// 1 0 1 0；第三行是0 1 1 0 0；第四行是1 0 1 0 1；第五行
// 是1 0 1 1 0。背景为淡蓝色方块，表示数据量子比特被制备
// 在特定的计算基态（|0>或|1>）上。 右侧上方标题为“2.
// Basis setup”（基矢设置）。展示了两种并排的选项，用“or”
// 连接。左侧选项是一个类似棋盘格的图案，其中浅蓝色方块标
// 有字母“H”，深蓝色方块无标记。下方文字说明：“Initialize
// for light ('Z' stabilizers) & 'Z_L'"（为浅色初始化，即
// Z型稳定子及逻辑Z算符）。右侧选项同样是棋盘格，但颜色反
// 转，深蓝色方块标有“H”，浅蓝色方块无标记。下方文字说明：
// “Initialize for dark ('X' stabilizers) & 'X_L'"（为深
// 色初始化，即X型稳定子及逻辑X算符）。这里的“H”代表哈达
// 玛门（Hadamard gate），用于改变量子比特的测量基矢。 第
// 二部分：中部区域展示标准的量子纠错循环 标题为“3. QEC
// cycle (repeat N times), as in Fig. 1b”（第3步：量子纠
// 错循环，重复N次，如图1b所示）。此部分包含从a到j的一系
// 列子图，描述了一个完整的纠错周期。 子图a：显示一个由浅
// 蓝色方块组成的网格，大部分方块内有字母“H”。这是第一步
// 操作，对特定量子比特施加哈达玛门。 子图b：显示与a相同
// 的网格布局，但在每个节点上画有黑色的箭头，指向不同的方
// 向。这代表CNOT门或其他受控非门的相互作用，黑色箭头指示
// 控制端和目标端的关系。 子图c：与a类似，显示带有“H”的网
// 格，但布局略有不同，可能对应于另一组稳定子的测量准备。
// 子图d：与b类似，显示带有黑色箭头的网格，表示另一轮相互
// 作用。 子图e：未在图中直接标出，但在流程中隐含。根据上
// 下文，这可能是一个中间状态或省略的步骤。 子图f：再次显
// 示带有黑色箭头的网格，与b和d的模式相似，继续进行相互作
// 用。 子图g：显示带有“H”的网格，与a和c的模式相似，进行
// 基矢变换。 子图h：显示带有黑色箭头的网格，继续相互作用。
// 子图i：显示带有“H”的网格，可能是最后一轮基矢变换。 子
// 图j：显示一个密集的网格，每个格子内有字母组合如“DD”、“
// MR”、“DO”等。这些缩写可能代表具体的量子门操作序列，例
// 如“DD”可能指双重退相干，“MR”可能指测量重置，“DO”可能指
// 其他操作。这部分详细列出了在纠错循环中执行的具体门操作
// 序列。 第三部分：下部区域展示修改后的“回波”X门操作 标
// 题为“Modifications to 3: 'echo' X gates”（对步骤3的修
// 改：‘回波’X门）。此部分包含从a到i的子图，展示了如何在
// 标准纠错循环中加入额外的X门以实现回波效应，从而抑制某
// 些类型的噪声。 子图a：显示一个网格，其中一些位置标有“X
// ”符号，其余位置标有“H”。这表示在特定时间点对特定量子比
// 特施加X门。 子图c：显示更多的“X”符号分布在网格中，表明
// X门的应用范围扩大。 子图e：显示几乎整个网格都被“X”符号
// 覆盖，除了边缘的一些“H”。这可能是回波脉冲的主要阶段。
// 子图g：显示“X”符号减少，恢复到类似a的状态，完成回波序
// 列。 子图i：显示最终的配置，与a相似，确保回波效果正确
// 实现。 注意：子图b, d, f, h在此部分未明确标出，但根据
// 对称性和回波原理，它们应与a, c, e, g, i形成互补或镜像
// 关系。此外，在子图e下方有一行小字“(insert between 3d &
// f)”，提示这个修改应插入到标准循环的第3d和3f步骤之间。
// 第四部分：底部区域展示最终测量 标题为“4. Final
// measurement (replace 3i-j in final cycle)”（第4步：最
// 终测量，替换最后一个循环中的3i-j步骤）。此部分展示了在
// 纠错过程结束后，如何读取逻辑量子比特的信息。 左侧有两
// 个选项，用“or”连接。第一个选项是一个网格，大部分格子标
// 有“H”，下方文字说明：“Measure 'Z_L'”（测量逻辑Z算符）。
// 第二个选项也是一个网格，大部分格子标有“H”，但布局不同，
// 下方文字说明：“Measure 'X_L'”（测量逻辑X算符）。这两个
// 选项对应于之前基矢设置的选择，分别用于测量逻辑Z或逻辑X
// 的本征值。 右侧是一个单独的网格，所有格子都标有字母“M”。
// 这代表对所有相关量子比特进行测量操作。“M”通常表示测量
// （Measurement），得到经典结果。这一步骤将量子信息转换
// 为经典信息，以便后续处理或反馈控制。
#figure(placement: auto, image("imgs/sup_ksatz_circuit1.png", width: 100%),
  caption: [
    #strong[Distance-5 surface code circuits.] Expanded version of Fig.~1b (main text) showing the full sequence of operations. #strong[\1.] We reset all qubits to $| 0 chevron.r$ and then prepare an initial bitstring state on the data qubits using $X$ gates. #strong[\2.] We apply $H$ (Hadamard) gates to some of the data qubits to convert the initial bitstring (eigenstate of all $Z$ operators) into an eigenstate of half the #emph[ZXXZ] stabilisers, the half matching to logical operator of interest ($X_L$ or $Z_L$) for the specific experiment. Note steps (1) and (2) could be combined into a single moment of Clifford gates, but for simplicity we execute them in two moments as shown. #strong[\3.] QEC cycle, as in Fig.~1b (main text), showing the explicit gate patterns. Note although all stabilisers measure #emph[ZXXZ], the "$X$" stabilizers and "$Z$" stabilizers apply their CZs in a different order (specifically in 3d and f). This pattern is carefully designed to manage "hook" errors. As mentioned in the main text, we modify this gate sequence with additional "echo" or "dynamical decoupling" gates #emph[within] the unitary part of the circuit. This amounts to adding $X$ gates to the data qubits in 3a and 3i, to the measure qubits in 3c and 3g, and to all qubits in 3e (inserted between the middle two CZ moments). #strong[\4.] For the final measurement, we replace 3i-j with a different Hadamard pattern (transforming the data qubit state to the appropriate basis for logical measurement) and measure all qubits simultaneously. This final measurement is used for detectors for the penultimate round (measure qubit results) and the final round (data qubit results, converted to parities in the relevant basis).
  ],
  scope: "parent"
) <fig:sup_ksatz_circuit1>

#figure(placement: auto, 
  block(width: 100%)[
    #block(width: 3.5in)[
  #scale(76%, reflow: true, cetz.canvas({
    import cetz.draw: *

    let blue = rgb("#2f6fbe")
    let ltblue = rgb("#a9c9ee")
    let tilelt = rgb("#d6e4f8")
    let tilemd = rgb("#7fa9e6")
    let gold = rgb("#f2a71b")
    let ltgold = rgb("#f9d78d")
    let red = rgb("#e0312e")
    let blk = rgb("#000000")
    let dy = .72
    let bw = .42

    let wire(color, a, b) = line(a, b, stroke: (thickness: 1.2pt, paint: color))

    // a qubit on the device lattice: circle with four coupler arms
    let qubit(x, y, ring, core) = {
      let r = .17
      for ang in (45deg, 135deg, 225deg, 315deg) {
        let dx = r * calc.cos(ang)
        let dyy = r * calc.sin(ang)
        line((x + .9 * dx, y + .9 * dyy), (x + 1.9 * dx, y + 1.9 * dyy),
          stroke: (thickness: 3.6pt, paint: ring, cap: "round"))
        polygon((x + 2.05 * dx, y + 2.05 * dyy), 4, angle: 45deg, radius: .09,
          fill: ring, stroke: none)
      }
      circle((x, y), radius: .2, fill: ring, stroke: none)
      circle((x, y), radius: .115, fill: core, stroke: none)
    }

    // a single-qubit gate box (H / M)
    let gbox(x, y, label, color, bg: white) = {
      rect((x - bw / 2, y - bw / 2), (x + bw / 2, y + bw / 2), fill: bg,
        stroke: (thickness: 1.1pt, paint: color))
      content((x, y), text(size: 8pt, fill: color, label))
    }

    // a stabiliser tile: coloured square, central qubit symbol, four basis letters
    let tile(x, y, bg, letters) = {
      let s = .62
      rect((x - s, y - s), (x + s, y + s), fill: bg, stroke: none)
      let offs = ((-.38, .38), (.38, .38), (-.38, -.38), (.38, -.38))
      for i in range(4) {
        content((x + offs.at(i).at(0), y + offs.at(i).at(1)),
          text(size: 8pt, fill: blk, letters.at(i)))
      }
      for ang in (45deg, 135deg, 225deg, 315deg) {
        polygon((x + .27 * calc.cos(ang), y + .27 * calc.sin(ang)), 4,
          angle: 45deg, radius: .095, fill: blue, stroke: none)
      }
      circle((x, y), radius: .21, fill: blue, stroke: none)
      circle((x, y), radius: .12, fill: ltblue, stroke: none)
    }

    // one panel: tile icon, compiled circuit (left) and CZ decomposition (right)
    let panel(y0, tag, heading, bg, letters, labels, kind, two: false, boxbg: ltblue) = {
      let top = y0 + 4 * dy
      content((0, top + .92), anchor: "west",
        text(size: 10.5pt)[#strong[#tag] #heading])
      if two {
        tile(1.05, y0 + 2 * dy + .62, tilelt, letters)
        tile(1.05, y0 + 2 * dy - .62, tilemd, letters)
      } else {
        tile(1.05, y0 + 2 * dy, bg, letters)
      }

      // ---- left: a single weight-4 controlled gate
      let mx = 2.5
      let x0 = mx + .34
      let xe = 5.75
      let cx = 3.95
      for i in range(5) {
        let yrow = top - i * dy
        wire(if i == 0 { blue } else { gold }, (x0, yrow), (xe, yrow))
      }
      rect((cx - .19, y0 - .3), (cx + .19, top - dy + .3), fill: boxbg,
        stroke: (thickness: 1.2pt, paint: blue))
      for i in range(4) {
        content((cx, top - (i + 1) * dy), text(size: 8pt, fill: blk, labels.at(i)))
      }
      line((cx, top), (cx, top - dy + .3), stroke: (thickness: 1.2pt, paint: blk))
      circle((cx, top), radius: .075, fill: blk, stroke: none)
      gbox(3.15, top, [H], red)
      gbox(4.75, top, [H], red)
      gbox(5.45, top, [M], blue)
      qubit(mx, top, blue, ltblue)
      for i in range(4) { qubit(mx, top - (i + 1) * dy, gold, ltgold) }

      // ---- right: the same stabiliser decomposed into CZ gates
      let rx = 7.15
      let r0 = rx + .34
      let re = 11.9
      let cols = range(4).map(i => rx + 1.25 + i * .78)
      for i in range(5) {
        let yrow = top - i * dy
        wire(if i == 0 { blue } else { gold }, (r0, yrow), (re, yrow))
      }
      for i in range(4) {
        line((cols.at(i), top), (cols.at(i), top - (i + 1) * dy),
          stroke: (thickness: 1.2pt, paint: blk))
        circle((cols.at(i), top), radius: .075, fill: blk, stroke: none)
        circle((cols.at(i), top - (i + 1) * dy), radius: .075, fill: blk, stroke: none)
      }
      let ha = (cols.at(0) + cols.at(1)) / 2
      let hb = (cols.at(2) + cols.at(3)) / 2
      let hpos = if kind == "x" {
        range(4).map(i => (cols.at(i) - .48, cols.at(i) + .48))
      } else if kind == "zxxz" {
        range(4).map(_ => (ha, hb))
      } else {
        ()
      }
      if hpos != () {
        for i in range(4) {
          for xp in hpos.at(i) {
            gbox(xp, top - (i + 1) * dy, [H], red)
          }
        }
      }
      gbox(rx + .72, top, [H], red)
      gbox(re - .3, top, [M], blue)
      qubit(rx, top, blue, ltblue)
      for i in range(4) { qubit(rx, top - (i + 1) * dy, gold, ltgold) }
    }

    panel(9.3, [a], [Z stabilizer], tilelt, ("z", "z", "z", "z"), ("Z", "Z", "Z", "Z"), "z")
    panel(4.95, [b], [X stabilizer], tilemd, ("x", "x", "x", "x"), ("X", "X", "X", "X"), "x", boxbg: tilemd)
    panel(0.6, [c], [ZXXZ stabilizers], tilelt, ("z", "x", "x", "z"), ("Z", "X", "X", "Z"), "zxxz", two: true)
  }))
      #v(0.65em)
      #align(left)[#context [Figure #counter(figure.where(kind: image)).display():] #strong[#emph[ZXXZ] stabilisers.] #strong[a,] Illustration of measuring a #emph[ZZZZ] stabiliser including compilation into CZ gates. #strong[b,] Similar for #emph[XXXX]. #strong[c,] Similar for #emph[ZXXZ] which we use for all stabilisers in our experiments.]
    ]
  ],
  caption: none,
  scope: "parent",
) <fig:sub_ksatz_zxxz>

In addition to individual-gate calibrations to track how qubit phases are affected by each gate, we add additional corrections within the surface code circuit, empirically optimized to minimize detection probabilities @kelly2015state @chen2021exponential. These catch-all corrections allow us to mitigate the impact of a variety of noise sources which all effectively act as a single qubit phase shift. We place a "virtual $Z^alpha$" correction preceding each Hadamard gate, and then tune the value of $alpha$ for each correction to minimize the detection rate of the detectors that the correction impacts.

The measure qubit case is simpler because they are reset to $| 0 chevron.r$ to start each round, meaning that the initial Hadamard does not need a correction. As a result, each measure qubit only has a single correction per error correction cycle. Data qubits, which are assumed to be in a non-trivial state throughout, require two corrections per cycle. In case there are "warmup" effects, we give each measure qubit a special correction value for the first cycle, and then each uses another value for the rest of the cycles, while data qubit corrections have unique values for the first cycle and the bulk cycle for each correction. Data qubits also have a single extra correction in the last round, to correct for errors which occur right before logical measurement.

These corrections $( a"lpha" )$, typically small (\< 0.1), are optimized using separate surface code experiments. We can divide the corrections into ten groupings of compatible corrections for any distance of surface code, meaning that the corrections impact different detectors and can therefore be optimized simultaneously. We then find the value for each correction which minimized the detection rate in parallel. Since the number of groupings is constant for any distance of surface code, we expect this method to scale well as we increase the sizes of our system.

=== Choice of $d = 3$ grids <choice-of-d3-grids>
// [figvision-cn] imgs/qubit_involvement.png
// 该图包含两个并排排列的方形热力图，分别展示四种距离为3
// 的网格中CZ门数量与量子比特数量的分布情况。 左侧子图标
// 题为“CZ count”，类型为二维热力图。横轴标记为“column”，
// 范围从1到9，单位为整数列号；纵轴标记为“row”，范围从1到
// 9，单位为整行号，数值自上而下递增（即第1行在顶部）。图
// 中数据以六边形单元格形式呈现，每个六边形内标注有白色数
// 字，表示该位置对应的CZ门计数值。所有六边形排列成一个近
// 似菱形的对称图案，覆盖约第2至第8行、第2至第8列区域。颜
// 色映射由右侧垂直色条定义：深紫色对应0，经蓝绿色过渡至
// 亮黄色对应10。具体数值分布如下：中心区域（如row=4~6,
// column=4~6）出现多个值为2的六边形，边缘及外围多为1，无
// 大于2的值。背景中存在浅灰色虚线勾勒出的更大菱形轮廓，
// 可能表示理论边界或扩展区域，但内部未填充数据。该子图表
// 明，在所研究的网格结构中，CZ门参与度集中在中心区域，且
// 最大计数仅为2，整体分布高度对称。 右侧子图标题为“Qubit
// count”，类型同为二维热力图。坐标轴设置与左图完全一致：
// “column”横轴1–9，“row”纵轴1–9（自上而下）。数据以正方
// 形网格单元呈现，每个方格内标注白色数字，表示该位置量子
// 比特数量。颜色映射同样使用右侧垂直色条，深紫=0，亮黄=
// 10。实际数值范围在1至4之间：绝大多数格子为1或2，仅有一
// 个格子（位于row=5, column=5）显示为4，颜色为青绿色；另
// 有若干格子为2，呈局部聚集态。整个非零区域构成一个不规
// 则十字形加扩展块状结构，大致覆盖row=3~7、column=3~8区
// 域。该子图揭示量子比特密度在中心略高（唯一4值点），其
// 余大部分区域为低密度（1或2），空间分布不对称，反映不同
// 网格拓扑下资源分配差异。 两幅图共享同一套颜色标尺，便
// 于直接比较CZ门与量子比特的空间分布模式。综合来看，CZ门
// 分布更均匀对称，而量子比特分布更具局部集中性，尤其在(5
// ,5)处存在显著峰值。
#figure(placement: auto, image("imgs/qubit_involvement.png", width: 100%),
  caption: [
    Heatmaps of CZ and qubit involvements in the four distance-3 grids considered in this work.
  ],
  scope: "parent"
) <fig:qubit-heatmap>

In total, there are 10 possible distance-3 grids whose footprint lies within the footprint of the distance-5 surface code grid. The four grids chosen were picked such that their overlap was minimized, in order to reduce susceptibility to bias. There is still non-trivial overlap at the boundaries of the distance-3 grids, as well as the center qubit, which is included in all 4 of the smaller codes as seen in @fig:qubit-heatmap. Since the distance-3 codes are more susceptible to outlier qubits, the performance of the center qubit is essential to a fair measurement of $Lambda_35$.

In @fig:outlier, we show a dataset where the center qubit was experiencing excess phase errors, dramatically impacting the performance of the distance-3 codes. In the inset, we can see that although this dataset does land in the desired region, it is clear that it is due to outlier performance. We can also see this by comparing to our models and observing that the logical error per cycle does not match where our models would expect such a crossover to occur. By looking at the detection event fractions in Fig.~2 of the main text, we can see that the performance around the center of the chip was within the standard range for the experiment presented, so we have no reason to believe that our measurement of $Lambda$ was skewed.

// [figvision-cn] imgs/fig3_outlier.png
// 该图像包含三个子图（a、b、c），展示了量子纠错实验中逻
// 辑错误概率和保真度随时间的变化关系。 子图 a： 类型：曲
// 线图，包含散点数据和拟合曲线。 坐标轴：横轴为“Quantum
// error correction cycle, t”（量子纠错周期，t），范围从0
// 到25，刻度间隔为5；纵轴为“Logical error probability,
// p_L”（逻辑错误概率，p_L），范围从0.00到0.50，刻度间隔
// 为0.05。 数据系列与图例： 红色倒实心三角形标记代表“d =
// 3 average”（距离参数d=3的平均值）。这些点大致分布在一
// 条上升的曲线上，从t约等于3时的p_L约0.12上升至t等于25时
// 的p_L约0.45。 浅红色倒空心三角形标记代表“d = 3
// individual quadrants”（d=3的各个独立象限）。这些点散布
// 在红色平均值的上下方，显示了数据的波动范围。 蓝色实心
// 五边形标记代表“d = 5”（距离参数d=5）。这些点位于红色曲
// 线的下方，同样呈上升趋势，从t约等于3时的p_L约0.07上升
// 至t等于25时的p_L约0.43。 两条实线分别对应上述两种情况
// 的平均值拟合曲线：“Fit to experimental average”。红色
// 实线穿过红色倒三角的中心趋势，蓝色实线穿过蓝色五边形的
// 中心趋势。两条曲线均为向上弯曲的非线性增长形态。 标注
// 文字：左上角有图例说明各符号含义。 结论：随着量子纠错
// 周期的增加，逻辑错误概率单调递增。对于相同的周期数，d=
// 5系统的逻辑错误概率低于d=3系统。 子图 b： 类型：曲线图，
// 纵坐标为对数标度。 坐标轴：横轴与子图a共用，为“Quantum
// error correction cycle, t”，范围0到25。纵轴为“Logical
// fidelity, F = 1 - 2p_L”（逻辑保真度，F），采用对数刻度，
// 范围从0.1到1，主刻度线标注为0.1和1。 数据系列： 红色倒
// 实心三角形及其连线代表d=3的情况。曲线从t接近0时的F接近
// 1开始，随时间推移近似指数下降，至t等于25时降至0.1以下。
// 蓝色实心五边形及其连线代表d=5的情况。曲线起点与红色相
// 似，但下降速度较慢，始终位于红色曲线上方，至t等于25时F
// 值约为0.15左右。 标注文字：无额外标注，依赖子图a的图例
// 或上下文理解颜色含义。 结论：逻辑保真度随纠错周期增加
// 而衰减。d=5系统的保真度衰减速率慢于d=3系统，表明其具有
// 更好的容错性能。 子图 c： 类型：散点图，带有参考线和箭
// 头注释。 坐标轴：横轴为“1 - ε_3”，范围从0.90到0.98；纵
// 轴为“1 - ε_5”，范围从0.90到0.98。两个轴的物理意义推测
// 分别为不同距离参数下的某种保真度或成功率指标（ε通常表
// 示误差率）。 数据系列与图例： 深蓝色实心圆点代表“d = 3
// average”（d=3的平均值），图中有两个明显的聚集点，一个
// 在(0.96, 0.97)附近，另一个在(0.97, 0.97)附近。 浅蓝色
// 空心圆点代表“d = 3 individual”（d=3的个体测量值），散
// 布在深蓝色点周围，主要集中在图表右下区域，但也有一些点
// 向左上方延伸。 红色实心圆点：图中有一个单独的红色实心
// 圆点，位于(0.95, 0.97)附近，未明确在图例中说明，可能代
// 表特定实验条件或理论预测值。 辅助线与标注： 一条浅红色
// 对角线贯穿图表，标注方程“ε_3 = ε_5”，表示当两个误差率
// 相等时的轨迹。 一个蓝色粗箭头指向右上方，旁边标注文字“
// System improvements”（系统改进），指示随着系统优化，数
// 据点应向更高保真度（即更靠近右上角）移动的方向。 结论：
// 该图比较了d=3和d=5系统在不同运行条件下的性能表现（通过
// 1-ε度量）。大部分d=3的个体测量值位于对角线下方，暗示在
// 某些情况下d=5的表现优于d=3（因为纵坐标1-ε_5大于横坐标
// 对应的1-ε_3意味着ε_5 < ε_3）。系统改进的目标是使所有操
// 作点向高保真度区域移动。
#figure(placement: auto, 
  block(width: 100%)[
    #block(width: 3.5in)[
      #image("imgs/fig3_outlier.png", width: 100%)
      #v(0.65em)
      #align(left)[#context [Figure #counter(figure.where(kind: image)).display():] Plots in the style of Fig.~3 in the main text, but for a dataset where the center qubit in the grid was experiencing performance issues. In #strong[a] and #strong[b], we present the logical error probability versus round, while in the inset #strong[c], we present the same progression shown in the main text, but with this outlier set plotted in red.]
    ]
  ],
  caption: none,
  scope: "parent",
) <fig:outlier>

=== Order of experiments <order-of-experiments>
We interleave the experiments in Fig.~3 (main text). Specifically, we acquire one (number of cycles, basis, code) dataset at a time. Each dataset consists of 50000 total surface code runs (10 initial bitstring states times 5000 repetitions).

We shuffle the order in which we acquire each (number of cycles) group of datasets. We begin with an extra 25-cycle experiment which we use for some decoder "training" (see decoding section) and then proceed with the other numbers of cycles in random order, in particular (25 (extra), 15, 17, 21, 13, 1, 19, 5, 23, 25, 7, 9, 3, 11).

Additionally, after each 5 cycles, we run a "frequency update" calibration on all the qubits. This is a simultaneous Ramsey experiment to quickly check the qubit frequency and update the flux bias values to tune the qubits to the desired frequencies if needed.

The pseudocode below describes the specific order in which the (number of cycles, basis, code) datasets were acquired.

``

`num_cycles = (25, 15, 17, ...)  # see text`

`codes = (`

`    d5,`

`    upper_left,`

`    lower_right,`

`    upper_right,`

`    lower_left,`

`)`

`for idx, n in enumerate(num_cycles):`

`    if should_run_frequency_update(idx):`

`        run_frequency_update()`

`    for basis in (Z, X):`

`        for code in codes:`

`            take_data(n, basis, code)`

=== Initial states <initial-states>
As discussed in the main text, we use random bitstrings as the initial data qubit states. This avoids a situation where we start with a bias to more $| 0 chevron.r$ measurement outcomes: if all the data qubits start in $| 0 chevron.r$, about 3/4 of the measure qubits will see $| 0 chevron.r$ in the first cycle, as opposed to 1/2, and there would be an asymmetry in measurement fidelity. This would artificially lower the error for the first several rounds as the code "warms up" to the steady state.

For the data in Fig.~3 (main text), we choose to initialize with 10 different bitstrings, 5 with each logical value. To accomplish this, for $N$ qubits, we generate 5 integers between 0 (inclusive) and $2^(N - 1)$ (exclusive) and then interleave them with their $N$-bit bitwise complements (for odd surface code distance, bitwise complements have opposite logical values).

Specifically, the bit-packed decimal integers we use for distance-5 are (1497382, 32057049, 12984827, 20569604, 10981887, 22572544, 7363158, 26191273, 7264790, 26289641), and for distance-3, (22, 489, 198, 313, 167, 344, 112, 399, 110, 401).

The 25-bit representation of 1497382 is 0b0000101101101100100100110. Referring to @fig:sup_ksatz_coordinates, this is assigned to the data qubits in a big-endian fashion using the (row, column) coordinate system, with the most significant bit being (row=1, column=5), followed by (2, 4) and (2, 6) and ending with the least significant bit (9, 5). 1497382 is followed by its 25-bit complement, 32057049 or 0b1111010010010011011011001.

= DECODING <sec:decoding>

== Setting the prior distribution <sec:prior>
Each decoder requires a prior distribution on the set of errors occurring in the device. However, there are many sets of errors which trigger the same set of detectors. Because our decoder only depends on the detection events themselves, we group error probabilities collectively into bins according to the set of detectors they activate. This is done using Stim's detector error model functionality @gidney2021stim, which tracks Pauli errors to perform this binning automatically. Specifically, we use a simple depolarizing circuit noise model, derived from Stim circuit descriptions of the experimental circuits, to generate an initial set of bins of detectors and their collective probabilities. This information represents an initial error hypergraph - detectors are vertices, bins act as hyperedges connecting those detectors they activate, and hyperedge weights are defined from the collective error probabilities of the errors contained in each bin. Note that this is a slightly restricted model of decoding, and that more general models may be employed to increase the probability of success @pattison2021improved.

From here, we use a higher-order extension of the $p_(i j)$ method to assign probabilities to this initial ansatz of hyperedges using device-level data @chen2021exponential @chen2022calibrated. We compute the highest-order correlations present in the standard depolarizing circuit model, which are weight-$4$. We then continue to lower-order correlations, subtracting the probabilities of higher-order correlations that contain them to avoid double counting. However, this procedure can underestimate probabilities due to over-subtracting when the detection event data exhibits additional correlations that are not captured in the initial ansatz @chen2022calibrated. This is most common in one- and two-body correlations, which may be contained in many three- or four-body correlations. To account for this, we enforce a simple averaged depolarizing $T_1  T_2$ noise probability floor for one-body and spacelike two-body correlations to avoid unphysically small (or even negative) probabilities.

Because we use device-level data to calibrate the decoder, we must be careful not to fit the parameters of the decoder to the specific data that must be decoded. This can happen e.g. when optimizing minimum-weight perfect matching edge weights using gradient descent with the logical error per cycle as an objective function @kelly2015state. To avoid this issue, we decode an even subset of experimental trials by computing $p_(i j)$ on the odd subset, and vice versa, similar to @kelly2015state, and then average the two. This sidesteps the potential concern of having computed $p_(i j)$ on the same data set as decoding (although in practice, we observe a negligible advantage when decoding with $p_(i j)$ computed from the decoded data set directly, as there is no optimization step). Without perfect statistics, this leads to a mild interdependence between the two individual decoding problems.

We validate the assumption that the interdependence is negligible by decoding half of a single experiment via this averaging method, and then decoding it again with $p_(i j)$ computed from another quarter of the data independent from the half we decode. This ensures that each $p_(i j)$ is given the same amount of statistics, so that the only additional difference between the two decoding pathways are statistical fluctuations. We perform an abbreviated (due to the computational cost of the tensor network) distance-3 decoding experiment using 5, 9, and 13 rounds with this method. With the tensor network decoder and belief-matching decoder, averaged over round, we observe a #emph[relative] change of average logical error probability by $0.2 "%"$ and $0.1 "%"$, respectively, when using the independently computed $p_(i j)$ compared to averaging. These relatively weak dependencies of performance on the precise edge weights (rather than their general features) provide evidence that any interdependence between the two data sets due to statistical fluctuations is small.

For real-time decoding, it is also important that a decoder is robust to imperfections in the prior distribution e.g. caused by device drift. Although the tensor network decoder will likely be too slow to keep up with the throughput of a surface code processor, belief-matching is a promising candidate for building such a real-time decoder. To test belief-matching's sensitivity to an imperfect prior, we additionally use it to decode the experimental data with $p_(i j)$ computed from earlier data generated by the device. We observe a very small increase in logical error per cycle from $3.118 "%"$ to $3.129 "%"$ for distance-3 and $3.056 "%"$ to $3.059 "%"$ for distance-5. This robustness reinforces belief-matching as a promising candidate for real-time decoding.

== Correlated minimum-weight perfect matching <correlated-minimum-weight-perfect-matching>
For simulations involving larger scans through parameter space (e.g. for error budgeting), we employ a minimum-weight perfect matching decoder that uses a variant of the two-pass correlation strategy detailed in @fowler2013optimal. Because the time cost of this decoder is essentially twice the time cost of minimum-weight perfect matching, we can leverage a fast custom matching engine to perform these larger scans quickly. Matching is also used to decode the repetition code, which does not require a two-pass strategy.

== Belief-matching <belief-matching>

The minimum-weight perfect matching (MWPM) decoder often used for surface codes is efficient, but only considers edge-like fault mechanisms in the error hypergraph, ignoring hyperedge fault mechanisms that include more than two detectors @dennis2002topological.   Like the correlated MWPM decoder, the belief-matching decoder exploits information about hyperedge fault mechanisms, but in a different way - by combining belief propagation (BP) with MWPM~@higgott2022fragile @criger2018multi. In terms of efficiency, it has the same average and worst-case asymptotic running time as the conventional MWPM decoder @fowler2012towards.

// [figvision-cn] imgs/belief_matching_parallel_tanh_vs_serial_tanh_vs_serial_minsum.png
// 这是一张二维曲线图，展示了在不同最大迭代次数下，几种解
// 码算法的逻辑错误率。 横坐标轴标记为“Maximum iterations
// ”（最大迭代次数），范围从0到20，刻度间隔为2。纵坐标轴
// 标记为“Logical error rate”（逻辑错误率），显示的数值范
// 围大约从0.034到0.053，主要刻度标记为0.035、0.040、
// 0.045和0.050。 图中包含五条数据系列，图例位于图表右侧
// 中间位置，具体描述如下： Uncorrelated MWPM（非相关MWPM）：
// 由一条黑色的水平虚线表示。该线位于图表顶部，逻辑错误率
// 恒定在约0.052左右，不随迭代次数变化。 Correlated MWPM
// （相关MWPM）：由一条红色的水平虚线表示。该线位于黑色虚
// 线下方，逻辑错误率恒定在约0.038左右，作为性能基准线。
// Parallel (tanh)（并行双曲正切更新）：由一条带有圆形标
// 记的蓝色实线表示。该曲线起始于迭代次数为1时，逻辑错误
// 率约为0.0425。随着迭代次数增加，曲线迅速下降，在迭代次
// 数为6时降至约0.035，随后在0.035至0.036之间波动，整体表
// 现略高于橙色曲线。 Serial (tanh)（串行双曲正切更新）：
// 由一条带有圆形标记的橙色实线表示。该曲线起始于迭代次数
// 为1时，逻辑错误率约为0.040。曲线在迭代次数为2时急剧下
// 降至0.035，随后继续缓慢下降，在迭代次数为5时达到最低点
// 约0.033。之后曲线保持平稳或微幅上升，始终位于所有动态
// 曲线的最下方，表现出最优的性能。 Serial (min-sum)（串
// 行最小和近似）：由一条带有圆形标记的绿色实线表示。该曲
// 线起始于迭代次数为1时，逻辑错误率最高，约为0.0435。曲
// 线在迭代次数为2时急剧下降至约0.0375，随后快速收敛至
// 0.035附近。其走势与蓝色曲线非常接近，两者在后续迭代中
// 多次交叉并纠缠在一起。 总体趋势显示，使用BP子程序的三
// 种变体（蓝色、橙色、绿色曲线）均随着迭代次数的增加显著
// 降低了逻辑错误率，且最终性能均优于Correlated MWPM基准
// （红色虚线）。其中，Serial (tanh)方法在收敛速度和最终
// 错误率上表现最佳。
#figure(placement: auto, image("imgs/belief_matching_parallel_tanh_vs_serial_tanh_vs_serial_minsum.png", width: 100%),
  caption: [
    Comparison of different variants of BP used as a subroutine in the belief-matching decoder for a distance-5 surface code with simulated circuit-level depolarising noise over 5 rounds of syndrome measurement. We compare a parallel and serial schedule using the tanh update rule, as well as a serial schedule using the min-sum approximation of BP with a scaling factor of $0.7$. The $x$-axis shows the maximum number of iterations used for BP. The black and red dashed lines show the performance of an uncorrelated~@dennis2002topological and correlated~@fowler2013optimal MWPM decoder, respectively. All decoders were run on the same simulated data set of 50,000 shots.
  ]
) <fig:belief_matching_serial_vs_parallel_schedule>

In the first stage of belief-matching, BP is used to estimate the posterior marginal probability that each hyperedge fault mechanism has occurred, based on the prior probability of each hyperedge in the error hypergraph, as well as the set of detection events that have occurred in the experiment. In the second stage, the error hypergraph is decomposed into two error graphs, using the BP posterior marginal probabilities to set the edge weights. These two error graphs are then decoded using a MWPM decoder @dennis2002topological.   We refer the reader to Ref.~@higgott2022fragile for a more detailed description.

The main difference between our implementation of belief-matching and that of Ref.~@higgott2022fragile is that we use a serial (rather than a parallel) schedule for BP and a maximum of 5 iterations. This choice of parameters is motivated by our analysis of different variants of BP in belief-matching for simulated surface code data, shown in @fig:belief_matching_serial_vs_parallel_schedule. The serial schedule increases the rate of convergence of BP by roughly a factor of two~@zhang2005shuffled, @Panteleev2021degeneratequantum @kuo2020refined, and we also find that it improves the accuracy of belief-matching relative to using a parallel schedule, which we attribute to the serial schedule mitigating against the problem of split-beliefs caused by quantum degeneracy @poulin2008iterative. We find that using more than 5 iterations for BP did not improve the accuracy of belief-matching for our simulations, and increasing the number of iterations can even degrade performance. We expect this is due to short loops in the Tanner graph bounding information spread beyond some local region~@higgott2022improved and leading to unreasonably confident log-likelihood ratios when the number of iterations is increased beyond the length of these short loops. Although we use the standard "tanh" rule for BP in our belief-matching implementation for the experiment, in @fig:belief_matching_serial_vs_parallel_schedule we also show the performance of belief-matching when using the min-sum approximation of BP. The min-sum algorithm is an approximation of BP that is more efficient to implement in hardware. Despite its relative simplicity, we find that the accuracy of the min-sum algorithm with a serial schedule is only slightly worse than that of BP using the tanh rule with the same serial schedule, and is comparable to that of the tanh rule with a parallel schedule. A review of the tanh rule and min-sum algorithm can be found in @chen2005reduced.

Practically, this decoder holds promise for scaling to the $tilde 1$ $mu$ s per round throughput required by a real-time superconducting quantum computer. In addition to using the min-sum approximation and a small number of iterations, the BP subroutine can be made even faster through the use of parallelisation. Furthermore, by using belief-find, which uses weighted union-find~@huang2020fault @Delfosse2021almostlineartime instead of MWPM for post-processing, further speedups might be achieved with only a very small reduction in accuracy @higgott2022fragile.

== Tensor network decoding <tensor-network-decoding>

We implement a close-to-optimal decoder mapping the prior distribution defined in @sec:prior to a tensor network. Given a configuration of detection events and a choice of logical frame change, the contraction of this tensor network estimates its probability. It does so by summing the probabilities of all error configurations compatible with the set of detection events and logical frame change considered. This decoder guesses the more plausible logical frame change by comparing the likelihood of both outcomes. Unlike similar previous approaches~@BSV2014, @chubb2021statistical @higgott2022fragile, our protocol takes as input device level noise specified by $p_(i j)$ correlations rather than gate-level noise.

The contraction complexity of the resulting tensor network grows exponentially in $d^2$, where $d$ is the distance of the code. In practice, we contract it approximately as a matrix product state evolution with a finite maximum bond dimension, $chi$. The complexity of this approximate contraction grows with $chi^3$. In order to guarantee that the value of $chi$ used achieves convergence, we study the logical error probability of a distance-5 $Z$-basis experiment over 25 rounds - the largest experiment run. We show in @fig:lep_vs_bd that the logical error probability already converges at $chi = 30$, which we use to decode. Our implementation of this decoder uses the tensor network library quimb as a backend @gray2018quimb.

// [figvision-cn] imgs/lep_vs_bd.png
// 该图像包含一个独立的二维散点连线图，用于展示逻辑错误概
// 率随张量网络收缩中最大键维度的变化关系。 横坐标轴（X轴）
// 标记为“Maximum bond dimension, χ”，代表张量网络收缩过
// 程中使用的最大键维度。坐标轴刻度从10开始，以10为间隔递
// 增，依次标记为10、20、30、40、50。纵坐标轴（Y轴）标记
// 为“Logical error probability”，代表逻辑错误概率。坐标
// 轴范围从0.372到0.384，主刻度线间隔为0.002，依次标记为
// 0.372、0.374、0.376、0.378、0.380、0.382、0.384。图表
// 背景包含与坐标轴刻度对应的浅灰色网格线。 图中绘制了一
// 条蓝色的折线，连接了五个数据点，每个数据点均用实心蓝色
// 圆点表示。每个数据点上方和下方均有一条垂直的蓝色线段作
// 为误差棒，误差棒两端有短横线封口，表示平均值的标准误差。
// 具体数据点分布如下： 第一个数据点位于横坐标χ=10处，纵
// 坐标数值约为0.3815。其误差棒上端延伸至约0.3835，下端延
// 伸至约0.3795。 第二个数据点位于横坐标χ=20处，纵坐标数
// 值约为0.3768。其误差棒上端延伸至约0.379，下端延伸至约
// 0.3748。 第三个数据点位于横坐标χ=30处，纵坐标数值约为
// 0.3759。其误差棒上端延伸至约0.378，下端延伸至约0.3738。
// 第四个数据点位于横坐标χ=40处，纵坐标数值约为0.3760。其
// 误差棒上端延伸至约0.3782，下端延伸至约0.3738。 第五个
// 数据点位于横坐标χ=50处，纵坐标数值约为0.3759。其误差棒
// 上端延伸至约0.378，下端延伸至约0.3738。 趋势描述：随着
// 最大键维度χ从10增加到20，逻辑错误概率显著下降；当χ从20
// 继续增加至50时，逻辑错误概率在0.376附近趋于平稳，不再
// 发生明显变化。
#figure(placement: auto, image("imgs/lep_vs_bd.png", width: 100%),
  caption: [
    Logical error probability of a distance-5, $Z$-basis, 25-round experiment with 50,000 shots as a function of the maximum bond dimension $chi$ used in the tensor network contraction. Error bars denote standard error of the mean. We observe that the logical error probability stabilizes at $chi = 30$.
  ]
) <fig:lep_vs_bd>

= FITTING ERROR VERSUS ROUNDS TO EXTRACT LOGICAL ERROR PER CYCLE <fitting-error-versus-rounds-to-extract-logical-error-per-cycle>

// [figvision-cn] imgs/fitting.png
// 该图包含三个水平排列的子图（a、b、c），展示了基于Z基距
// 离-5数据、使用张量网络解码器进行拟合的过程。 子图 a：
// 类型为散点图，带有误差棒。横坐标轴标记为“Rounds”（轮数），
// 范围从0到25，刻度间隔为5。纵坐标轴标记为“F_L(r)”（逻辑
// 保真度），范围从0.2到1.0，刻度间隔为0.2。图中绘制了一
// 系列蓝色的菱形数据点，代表逻辑保真度随轮数的变化。每个
// 数据点都附有一个垂直的蓝色误差棒，用于表示从二项分布中
// 抽取的不确定性；为了在视觉上更清晰，图中显示的误差棒大
// 小为实际标准差的10倍。左下角标注有文字“10σ error bars”。
// 整体趋势显示，随着轮数从0增加到25，逻辑保真度呈非线性
// 下降趋势，从接近1.0降至约0.2左右。 子图 b： 类型为散点
// 图，带有误差棒。横坐标轴标记为“Rounds”，范围从0到25，
// 刻度间隔为5。纵坐标轴标记为“Log_10(F_L(r))”（逻辑保真
// 度的以10为底的对数），范围大致从-0.6到0.0，刻度标记包
// 括0.0、-0.3和-0.6。图中绘制了与子图a相同的实验数据点，
// 但纵坐标经过了以10为底的对数变换，同样使用蓝色菱形表示。
// 每个点配有垂直蓝色误差棒。一条黑色的实线穿过数据点中心，
// 表示对这些对数化数据的线性拟合结果。整体趋势显示，在对
// 数坐标系下，数据点呈现出明显的线性下降关系，表明逻辑保
// 真度随轮数呈指数衰减。 子图 c： 类型为散点图，带有误差
// 棒。横坐标轴标记为“Rounds”，范围从0到25，刻度间隔为5。
// 纵坐标轴标记为“F_L(r)”，范围从0.2到1.0，刻度间隔为0.2。
// 图中包含原始的蓝色菱形数据点及其误差棒。此外，还有一条
// 蓝色的虚线穿过数据点，这条曲线代表了根据子图b中的线性
// 拟合结果反推回原始线性空间后的拟合曲线。整体趋势显示，
// 蓝色虚线紧密贴合数据点的下降轨迹，验证了指数衰减模型对
// 该组数据的拟合效果。
#figure(scope: "parent", placement: auto, image("imgs/fitting.png", width: 100%),
  caption: [
    A figure demonstrating our fitting procedure on the Z-basis distance-5 data from the run presented in the main text, decoded with the tensor network decoder. #strong[a,] The logical fidelity data as a function of rounds, with error bars pulled from the binomial distribution (in this figure, all error bars shown at $10 sigma$ to help with visibility.) #strong[b,] The same data after a base-10 logarithm has been applied to it, with the error bars transformed appropriately, along with a two-parameter linear fit. #strong[c,] The data transformed back into the original coordinates, along with the transformed fit.
  ]
) <fig:fitting>

There are many ways to fit the data for error versus rounds to extract the logical error per cycle, which can yield slightly different results. In this section we lay out the procedure followed for this work.

We start with logical fidelities $F_"L" ( r ) = 1 - 2 P_"err" ( r )$, discarding the first round as it decreases the quality of our fits due to the unique nature of its errors, which disproportionately favor distance-5. Our goal is to find some logical error per cycle $epsilon$ such that

$
  P_"err" (r + 1) &= (1 - epsilon) P_"err" (r) + epsilon (1 - P_"err" (r)) \
  &= epsilon + (1 - 2 epsilon) P_"err" (r)
$

which corresponds to exponential decay in the fidelity:

$
  F_"L" (r + 1) &= (1 - 2 epsilon) F_"L" (r).
$

To do this, we first take our $F_"L" ( r )$ data and append error bars from a binomial distribution, meaning that the variance at each point is given by

$
  sigma^2 &= frac(P_"err" (r) (1 - P_"err" (r)), N).
$ <eq:binomial-variance>

We then take the base-10 logarithm of each of these points, transforming the error bars as appropriate, before fitting to simple two-parameter linear fit using least squares, weighting the squared errors by the transformed variances to approximate a maximum-likelihood estimate. We then exponentiate this linear fit in order to get the fit in the original coordinates. In~@fig:fitting we show this process applied to the Z-basis distance-5 dataset presented in the main text. When combining data from multiple experiments, such as when considering data from multiple logical bases, this process is done on each dataset separately, and the final $epsilon$'s are averaged.

We additionally quantify out-of-model errors (such as leakage and device drift) by comparing the residuals of the fit to the residuals we would expect from binomial sampling errors alone. As the residuals are roughly three times larger than what we expect from sampling noise alone, we scale up the uncertainty calculated for sampling noise by this factor to account for the additional variance in our estimates from these out-of-model factors. As a final conservative measure, we upper bound our uncertainty by combining uncertainties from individual fits (from different initial-state bases and different distance-3 configurations) via averaging, which accounts for the possibility that these out-of-model errors might be correlated across different subsets of experiments.

// [figvision-cn] imgs/tensor_network_fluctuating_lepr_fit_separations.png
// 该图像为一个二维热力图，展示了基于扩展模型拟合的结果。
// 子图类型：二维热力图（Heatmap）。 坐标轴说明： 横坐标
// （X轴）标记为“Final round”（结束轮次），刻度标签从1到
// 25，具体标注数值为1, 5, 9, 13, 17, 21, 25。 纵坐标（Y
// 轴）标记为“Start round”（开始轮次），刻度标签从1到25，
// 具体标注数值为1, 5, 9, 13, 17, 21, 25。 图表的有效数据
// 区域仅位于对角线上方及对角线本身（即结束轮次大于或等于
// 开始轮次的区域），左下角三角形区域为空白灰色背景，表示
// 无数据。 色标与物理含义： 右侧设有一个垂直的颜色条（
// Colorbar）。 颜色条上的数值范围从底部的-10.0到顶部的
// 10.0，中间刻度包括-7.5, -5.0, -2.5, 0.0, 2.5, 5.0, 7.5。
// 颜色映射采用发散型配色：深红色代表负值（约-10.0），随
// 着数值增加颜色逐渐过渡为浅红、白色（0.0）、浅蓝，最后
// 变为深蓝色代表正值（约10.0）。 颜色条旁边的数学公式标
// 注为：$2(\varepsilon_3 - \varepsilon_5) / (\sigma_3 +
// \sigma_5)$。这表示图中每个方格的颜色代表了距离为3的逻
// 辑错误率（$\varepsilon_3$）与距离为5的逻辑错误率（$\
// varepsilon_5$）之差，经过归一化处理后的结果。分母为两
// 种距离下逻辑错误率不确定度的平均值之和。 数据分布与趋
// 势： 在图表的上半部分（特别是当“Start round”较小，如1
// 至9时），绝大多数方格呈现深蓝色或中蓝色，对应数值约为+
// 5.0至+10.0。这表明在这些早期开始的区间内，距离3的逻辑
// 错误率显著高于距离5的逻辑错误率（差值为正且较大）。 随
// 着“Start round”数值的增加，沿对角线方向向下移动，颜色
// 逐渐变浅。 在图表的右下角区域（特别是当“Start round”大
// 于等于13时），出现了明显的暖色调。例如，在“Start round
// ”为13，“Final round”为17附近，以及“Start round”为17，“
// Final round”为17附近，存在深红色和橙红色的方格，对应数
// 值约为-5.0至-10.0。这表明在这些特定的后期区间内，距离5
// 的逻辑错误率反而高于距离3的逻辑错误率（差值为负）。 整
// 体趋势显示，随着实验轮次的推进，距离3和距离5之间的逻辑
// 错误率差异发生了翻转，从早期的距离3表现较差转变为后期
// 的距离5表现较差。
#figure(placement: auto, image("imgs/tensor_network_fluctuating_lepr_fit_separations.png", width: 100%),
  caption: [
    Results of fitting to an extended model with fluctuating $epsilon$. Fits are performed for all subintervals of rounds containing at least three points, and the result of the fit is presented as the difference in logical error per cycle between distance-3 and distance-5 measured in the average of the uncertainties of logical error per cycle for each distance given the extended model. Fits starting from round 1 clearly favor distance-5 disproportionately, and are not used for our quoted results. Fits starting from rounds 3--11 show consistent significant separation between the estimates for logical error per cycle. The fit from rounds 3--25, the range used for our quoted logical error per cycles, shows a separation of $5.7 sigma$ between distance-3 and distance-5, which is consistent with the $5.8 sigma$ separation we get from our original fits when scaling our error bars by the excess residual factor.
  ]
) <fig:extended-model-fits>

As a check that this can appropriately account for additional errors, we also fit an extended model in which the residuals in our fits come primarily from fluctuations in the logical error per cycle $epsilon$ itself instead of binomial sampling noise. This model results in near identical separation between the logical error per cycle for distance-3 and distance-5, as measured in standard deviations of the estimate. The results of this fit are illustrated in~@fig:extended-model-fits for all potential subintervals, demonstrating the robustness of our findings to out-of-model errors and fitting choices.

= SIMULATION OF LOGICAL MEMORY EXPERIMENT <sec:simulation_Dvir>
We consider multiple simulation strategies for the logical memory experiment. The simplest approach, labeled "Pauli" in the main text, is implemented as a standard Pauli frame simulation. This simulation is based on the #emph[Stim] open source library @gidney2021stim.  The associated error model corresponds to adding one and two-qubit depolarizing channels each device operation, matched to experimentally characterized fidelities.

A more sophisticated simulation approach is labeled "Pauli $+$\". This is still a classical simulation in the sense that the cost grows polynomially in the number of qubits, though its performance is not as heavily optimized. The advantage of this simulation is that it explicitly accounts for correlated errors such as qubit leakage and parallel gate crosstalk.

Finally, we do a "brute force" quantum simulation of the distance-3 experiment. This is a quantum trajectories simulation @tomita_low-distance_2014, @isakov2021simulations, meaning that each experimental sample corresponds to propagating the noisy evolution of the full quantum state vector. Unlike the previous approaches, the quantum simulation is "exact" in the sense that all noise is modeled using explicit quantum channels derived from physical considerations. The previous approaches must represent noise using Pauli channels, which can be derived from the more general quantum channels through approximations (detailed below). While the quantum simulation is not scalable to large code distances, we can use it to validate the approximations required for the Pauli $+$ simulator.

Below we outline the general procedure to simulate the logical memory experiment.

+ The "ideal" experiment is represented as a noiseless quantum circuit. Each layer of gate, idle, measure, or reset Operations is encoded as a #emph[Circuit] object of the Cirq open source library @isakov2021simulations. Simultaneous Operations are organized into Moments.

+ The "ideal" circuit is mapped to a "noisy" circuit. This corresponds to inserting additional moments into the circuit composed of operations representing noise. (The noise models used are described below.) Each noise operation is a quantum noise channel encoded using Kraus operators. Such a representation is sufficient for the quantum simulator. Both noisy circuit processing and quantum trajectories simulation are implemented using the kraus\_sim library (@sec:kraus_sim).

+ Additional processing of the noise is required for the "Pauli $+$" simulator. As detailed in @sec:twirling, we apply a generalization of the Pauli Twirling Approximation @geller2013efficient to construct Generalized Pauli Channels (GPC's) capable of including leakage.

+ The chosen simulator generates many measurement samples of the experiment represented by the noisy circuit. The initial data qubit states are matched to those used in experiment, and the results are then processed in the same way as experimental measurement data.

In the following sections, we discuss details of the simulated noise models as well as the Pauli $+$ simulator and the Generalized Pauli Twirling Approximation. We conclude with a comparison of results between the "Pauli $+$" and quantum simulations for a distance-3 experiment.

== Noise models <sec:noise>
Below we give a brief summary of all noise models included in our simulations. These models are accounted for using Kraus operators, which define quantum channels that are applied to each qubit after their respective gate or idling operations. In the Pauli $+$ simulation, these channels are first converted into corresponding Generalized Pauli Channels (GPC's) so that the noisy experiment is amenable to efficient simulation.

=== Decay, dephasing, and leakage heating <sec:decoherence>
We consider the effects of qubit decay, white noise dephasing, and passive leakage to state $|2⟩$ for an idling transmon qubit. We assume decay into a large, zero temperature environment with characteristic decay time $T_1$. Each transmon (both measure and data qubits) couples to the environment through its charge operator $q$. This induces a decay (in the energy eigenbasis) through the $|j⟩ ⟨j+1 |$ elements of the charge operator, which we assume scale as $q_(j j+1) prop sqrt(j+1)$. Fermi's Golden rule predicts a $j+1 arrow.r j$ decay rate proportional to $|q_(j+1,j)|^2 prop (j+1)$, so we expect the state $|2⟩$ to decay twice as fast as state $|1⟩$. Similarly, one can derive dephasing as arising from a weak measurement of the number operator $n$, with information leaking at a rate $1\/T_phi.alt$. Finally, we include a phenomenological leakage heating rate $Gamma_(1 arrow.r 2)$ described by the Lindbladian operator $sqrt(Gamma_(1 arrow.r 2)) |2⟩ ⟨1 |$. The dynamics of an idle transmon in the presence of these processes is described through the master equation,

$
  partial_t rho &= -i\/ℏ [H^("idle"), rho] + cal(L)[rho] \
  &= -i\/ℏ [H^("idle"), rho] \
  &+ 1\/T_1 (a rho a^"dagger" - 1\/2 lr({ n, rho })) + 2\/T_phi.alt (n rho n - 1\/2 lr({ n^2, rho })) \
  &+ Gamma_(1 arrow.r 2) (|2⟩ ⟨1 | rho |1⟩ ⟨2 | - 1\/2 lr({ |1⟩ ⟨1 |, rho })) \
  a &= sum_(j >= 0) sqrt(j+1) |j⟩ ⟨j+1 | \
  n &= sum_(j >= 0) j |j⟩ ⟨j | = a^"dagger" a .
$<eq:deco_lindblad>

The values for $T_1$ and $T_phi.alt$ used in our simulations are both qubit specific. They are extracted from experimental decay and CPMG data. For $Gamma_(1 arrow.r 2)$ we use a homogeneous value of $1\/(700 mu "s")$, which is in agreement with typical numbers for both our current device and past experiments @chen_measuring_2016.

We use the dissipative dynamics in @eq:deco_lindblad to extract corresponding discrete quantum noise channels. These are applied on each qubit following every idle or gate operation. For an operation of duration $t$, evolution under the master equation can be approximately decomposed as $cal(E) circle hat(U)_0$, where $hat(U)_0$ represents the ideal unitary evolution and

$
  cal(E) = exp(t cal(L))
$

represents the effect of decoherence. We solve for $cal(E)$ by representing $cal(L)$ as a linear operator and doing the direct matrix exponentiation; this ignores a correction due to weak non-linearity of the spectrum of $H^("idle")$. From this we follow the standard prescription to extract the Kraus operators of $cal(E)$@wilde_2013_quantum.

=== Readout and reset error <sec:readout>
Readout error is assumed to be a classical process. Accordingly, our simulations in fact implement perfect readout in the standard basis (including leaked states $|2⟩$ and $|3⟩$) and errors are added using a Markov transition matrix in post-processing. To populate this matrix we use the calibrated readout fidelities in the device. Measure qubit fidelities are calibrated during parallel measurement of all measure qubits, while for data qubits we use fidelities calibrated during parallel measurement of #emph[all] qubits. Since the experiment does not actually implement readout that distinguishes the leaked states, we assume that both state $|2⟩$ and $|3⟩$ are read out as $|0⟩$ or $|1⟩$ with equal probability. Additionally, we account for measure qubit reset error by adding this probability to the average readout error of the measure qubits. This is justified as a reset error on a measure qubit at the beginning of an error correction round has the same effect as a measurement error at the end of the round.

=== Leakage <sec:leakage>
Leakage outside the computational subspace is caused by three mechanisms included in our models.

+ Heating: Passive heating from state $|1⟩$ to $|2⟩$, as included in the decoherence model above.

+ CZ gate dephasing: Since our CZ gates are diabatic (implemented as two complete Rabi swaps) dephasing processes may cause transitions between states $|11⟩$ and $|02⟩$. To model this process, after each CZ gate we include a channel with Kraus operators

  #eqnn($
    K_1 &= sqrt(p_t) (|02⟩ ⟨11 | + |11⟩ ⟨02 |) \
    K_0 &= sqrt(I - K_1^"dagger" K_1) .
  $)

  The value $p_t = 8 times 10^(-4)$ used matches the median value observed in characterization of isolated CZ gates. The qubit ordering above matches the $f_10$ transition frequencies of the qubits, so that only the higher frequency qubit leaks @chen2021exponential.

+ CZ crosstalk: As discussed below, coupling crosstalk between independent CZ pairs or idling qubits may lead to leakage transitions.

Along with affecting measurement outcomes, we also account for the effect of leakage on our CZ gates. This is captured by two processes:

+ Controlled phases: When one of two qubits is in a leaked state $|j⟩$ during the CZ gate, the applied Z phase on the other, $phi.alt_j$, will typically not be $0$ or $pi$. When the non-leaked qubit is a measure qubit, this will have a randomizing effect on the observed stabilizer measurement @battistel2021hardware. Under the twirling approximation, this effect is mapped to a $sigma_z$ Pauli channel applied conditionally on the non-leaked qubit.

+ Higher level transitions: The physical implementation of the diabatic CZ gate leads to resonances between higher energy states (e.g. $|22⟩$ and $|13⟩$). Accordingly, this leads to coherent transitions between these states and effective transport of leakage between measure and data qubits @mcewen_removing_2021.

In order to accurately capture the above processes, we numerically calibrated then simulated the CZ gate matching the experimental qubit and coupler control schedules. The observed values for $phi.alt_j$, as well as the transition amplitudes (specifically between states $|22⟩ ⟺ |13⟩$ and $|21⟩ ↔ |03⟩$) were extracted.

=== Crosstalk <sec:x-talk>

We model coupling crosstalk between qubits undergoing parallel CZ or idling operations. This crosstalk error is caused by two effects. First, the #emph[inactive] couplers (i.e those not implementing a CZ gate) used to mediate the qubit-qubit couplings at idle are unable to cancel all effective couplings over all fixed excitation subspaces @youngkyu_coupler_2021.  Second, diagonal capacitive couplings (e.g., between next-nearest-neighbor qubits) are also present throughout the device, with $| 01⟩arrow.l.r| 10⟩$ swap rates on the order of $200$ kHz. To account for both of these effects, we consider all pairs of simultaneous gates (either single qubit idle or two-qubit CZ). For each pair of gates containing a diagonal or nearest neighbor, we simulate the parallel operation of both gates in the lab frame (while including the undesired couplings above). The full 3- or 4- qubit unitary $U_(l a b)$ is then re-expressed in the "interaction picture"

$ U_(l a b) U_0^dagger = U_I $<eq:xtalk_unitary>

where $U_0$ represents the "ideal" evolution in the absence of the unwanted couplings#footnote[Note that the ordering of operations is swapped compared to the typical interaction picture definition $U_(l a b) = U_0 U_I$. This is to retain consistency with the other noise models, for which we append error channels after (instead of before) each ideal gate operation.#text(fill: white, size: 0pt)[#cite(<Note1>)]]. (This ideal evolution can be computed as a tensor product of unitaries acting on the two subsystems involved in each gate.) Note that the simulations are carried out using 4-level qubits, so that leakage-related effects are explicitly included. Details of these simulations are deferred to a later work. The $U_I$ unitaries for all pairs of neighboring gates are included as error channels in representation of the noisy circuit.

=== Depolarizing errors <sec:depolarizing>
While the models above account for a majority of errors in the experiment, they typically under-predict the experimentally calibrated decay of fidelity. To compensate for this missing error, we append additional depolarizing errors after each gate. In all cases, the fidelity decay curves are converted to an inferred Pauli error. This error is compared to the sum of Pauli errors accumulated over the error models described above. The effect of leakage transitions on the Pauli error are explicitly accounted for as in @pedersen2007fidelity. Single qubit gates are characterized using parallel randomized benchmarking @emerson2005scalable, while CZ gates are characterized with parallel cross-entropy benchmarking (XEB) @arute2019quantum.  Additionally, the data qubit idles (during measure qubit measurement and reset) are characterized using interleaved single qubit XEB.

== Simulator details <simulator-details>
=== kraus\_sim - noisy circuit compiler and quantum simulator <sec:kraus_sim>
The kraus\_sim library serves as an intermediate layer between the Cirq (used to represent the circuit) and #emph[qsim] (used for high-performance qubit state evolution) @arute2019quantum @quantum_ai_team_and_collaborators_2020_4023103 libraries. At the interface to Cirq, it processes the ideal circuit to generate the noisy circuit (as described in @sec:noise). These noisy circuits are then consumed by kraus\_sim's quantum trajectories simulator. A single quantum trajectory is equivalent to consecutively sampling the Kraus operators of each applied quantum channel using Born's rule for POVMs @wilde_2013_quantum, then applying the Kraus operator to the state vector and normalizing the result @isakov2021simulations.  Below, we highlight unique features of the library, which necessitate a custom simulator backend based on the #emph[qsim] library.

The kraus\_sim analog of Cirq's Operation is the KrausOperation. It is used to encode all quantum channels (both gates and errors) applied to the system. These channels are encoded as Kraus operators, each of which is represented as a multi-dimensional tensor. While typical Kraus operators are "square" matrices, KrausOperations allow these tensors to have an arbitrary shape. This means that channels can be defined which "create" or "destroy" degrees of freedom in the system. Accordingly, in many cases it is possible to reorder the application of commuting KrausOperations to greatly speed up calculations by decreasing the size of the state vector. Specifically, the structure of the surface code and bit flip code circuits means that operations can be ordered so that a "destructive" measurement of a single measure qubit is following by a "creative" reset of another measure qubit @obrien_density-matrix_2017.  Thus, only a single measure qubit ever needs to be represented in memory. This allows for noisy simulations of up to a distance-5 surface code (25 data + 24 measure qubits) while keeping at most 25+1 qubits in memory. However, this technique is not possible in the presence of 3- and 4-local crosstalk errors, since if two measure qubits are affected by such error they must both exist concurrently in the simulation. We therefore focus only on distance-3 simulations (requiring only 9+8=17 qubits in memory).

kraus\_sim also implements functionality to represent classical degrees of freedom (registers), which are updated using stochastic matrices. KrausOperations can be conditioned on the values of these registers, which allows the registers to affect the quantum state evolution. Analogously, the index of the sample Kraus operator for a given KrausOperation can be used to apply conditional stochastic matrices to classical registers. This is relevant for simulations of leakage, as in our models we approximate all leakage transitions as incoherent. This means that no superposition is ever formed between the computational and leakage subspaces of any qubit, and we therefore are never required to keep more than two levels per qubit in our state vector. Instead we use classical registers to track the leakage status of each qubit, applying only the parts of our Kraus operators that act in the current computational subspace#footnote[Details of this approximation are deferred to a future work.#text(fill: white, size: 0pt)[#cite(<Note2>)]].

=== Pauli $+$ simulator implementation <pauli-simulator-implementation>

Pauli $+$ carries out a classical simulation of the logical memory experiment. The term "classical" here denotes the fact that the simulation cost scales quadratically with the number of qubits and linearly with the number of error correction rounds, so it is amenable to classical computers. For a system of qubits, polynomial scaling of simulation cost for an arbitrary Clifford circuit with Pauli-channel errors is a consequence of the Gottesmann-Knill theorem @Gottesman-Knill-1999. Related methods have long been used for accuracy threshold calculations @Steane-2003 @Fowler-QEC-2004 @raussendorf2007fault @Wang-Fowler-Stephens-Hollenberg-2010 @Wang-Fowler-Hollenberg-2011 @Landahl-2011 @Brown-Nickerson-Browne-2016 @Tuckett-Bartlett-Flammia-2018 and non-Pauli errors @Gutierrez-Svec-Vargo-Brown-2013, and even for simulating circuits with a small fraction of non-Clifford gates @Bravyi-Gosset-2016 @Bravyi-etal-sim-2019.

In the presence of leakage, we achieve such a scaling in a Markov-chain simulation by using an approximate Generalized Pauli Channel (GPC) error model similar to that used in Pauli-frame simulations by Fowler @fowler2013coping.  In our case, to ensure correct correlations between measurement events in an arbitrary Clifford circuit, the state of the system is described by a vector of device leakage labels and an $m$-qubit stabilizer state for the devices in the computational (qubit) subspace.

The noisy circuit is modified for Pauli $+$ simulations by decomposing each noisy gate as a product of an ideal Clifford gate and a sequence of residual error channels. The error channels are then approximated as a GPC. As a result, the entire simulation consists of four operation types:

+ A unitary that acts as a perfect Clifford gate in the computational subspace and identity on its complement.

+ A perfect measurement (all leakage levels resolved) in the computational basis.

+ A perfect reset to a single-device $|0⟩$ state in the computational basis.

+ An error channel, represented as a Generalized Pauli (GP) channel.

\(As noted previously, classical readout error is handled through post-processing of measurement data). We describe how each of these operations are handled by the simulator below.

The full Hilbert space of the $n$-device system is approximated as a $q^n$-dimensional space, where each device has $q = 4$ energy levels, with $|0⟩$ and $|1⟩$ forming the computational subspace. Further, because the corresponding phases are not being tracked, the states $|2⟩$ and $|3⟩$ are subject to rapid dephasing. As a result, the full Hilbert space is separated into mutually incoherent leakage subspaces given by Kronecker products,

$
  cal(H)_(macron(a)) = cal(H)_(a[1]) ⊗ cal(H)_(a[2]) ⊗ dots.h ⊗ cal(H)_(a[n]),
$<eq:hilbert-space-decomp>

where the local subspace $cal(H)_(a[j])$ of the $j$th device with leakage state label $a[j] in { c, 2, 3 }$ is selected from

$
  cal(H)_c = "Span" lr({ |0⟩, |1⟩ }), quad cal(H)_2 = "Span" lr({ |2⟩ }), quad cal(H)_3 = "Span" lr({ |3⟩ }).
$<eq:leakage-decomposition>

Each GP channel acting on $k$ devices in the index set $J = lr(( "j_1", "j_2", d"ots".h, "j_k" ))$ is represented by a collection of possible transitions between leakage subspaces:

$
  macron(a)[J] equiv (a[j_1], a[j_2], dots.h, a[j_k]) arrow.r macron(b)[J] equiv (b[j_1], b[j_2], dots.h, b[j_k]).
$ <eq:space-decomp>

For each transition $macron(a) arrow.r macron(b)$, the set of devices in $J$ are partitioned into four categories, depending on their initial and final leakage status. The devices which begin and #emph[remain] in the computational subspace are denoted

$
  R equiv lr({ j in J | a[j] = b[j] = c }).
$ <eq:qubits-remain>

These devices will receive a standard Pauli channel. The devices that transition #emph[up] to leakage are denoted by

$
  U equiv lr({ j in J | a[j] = c, b[j] != c }).
$ <eq:up-leak>

Leaked devices are not modified after the transition. Conversely, devices which transition #emph[down] to the computational subspace are labeled

$
  D equiv lr({ j in J | a[j] != b[j] = c }).
$ <eq:down-leak>

We assume that such devices are fully disordered, meaning that they receive a maximally depolarizing Pauli channel. Finally, the remaining devices are those which start and end #emph[leaked],

$
  L equiv lr({ j in J | a[j] != c, b[j] != c }).
$<eq:stay-leak>

Like the devices in $U$, no Pauli channel is applied for these devices. However, transitions between different leakage subspaces are allowed. As detailed below, approximating quantum error channels in terms of GP channels is premised on the assumption that the input is a highly-entangled stabilizer state, that the output is eventually projected to such a state, e.g., at the end of a measurement cycle, and that a "large" part of evolution during any gate is factored out as a Clifford rotation, while the remaining error channel is in some sense close to identity.

Each transition (denoted by the initial and final subspace vectors $macron(dotless.i)$, $macron(f)$ supported on $J$) is assigned a conditional probability $P ( macron(f) divides macron(dotless.i) ) equiv P ( macron(dotless.i) arrow.r macron(f) )$. Whenever the GP channel is applied to the system initially in subspace ${cal(H)}_(macron(a))$, there is a unique subspace label $macron(dotless.i) equiv macron(a) [ J ]$ which is updated according to the distribution $P ( macron(f) divides macron(dotless.i) )$. Additionally, each transition is associated with a standard Pauli channel acting on the qubits in $R$. Initial state of the qubits in $U$ is traced over, while the final state for each qubit in $D$ is a randomly selected $|0⟩$ or $|1⟩$ with equal probability. Overall, each GP channel acting on devices in the index set $J$ is represented by compound data

$ {(P ( macron(dotless.i) arrow.r macron(f) ) #h(0.17em) p ( sigma_(macron(mu)) | macron(dotless.i) arrow.r macron(f) ))}_(macron(dotless.i) macron(f)) $<eq:compound-data>

where the Pauli operators $macron(sigma)_mu$ act only on the qubits in the set $R$, see @eq:qubits-remain.

The simulator takes as input a quantum circuit (a sequential list of operations of the four types above) and returns corresponding experimental measurement samples. The simulator is implemented as a Markov chain whose internal states are specified by the leakage space label vector $macron(a)$ and (with $m = m_(macron(a)) lt.eq n$ devices in the computational subspace) an $m$-qubit stabilizer state specified in terms of $m$ Hermitian generators of the corresponding stabilizer group ${cal(S)} = ⟨hat(G)_1, dots.h.c, hat(G)_m⟩$, an abelian subgroup of the $m$-qubit Pauli group ${cal(P)}_m$ which does not include $- hat(I)$. Notice that it is the stabilizer group but not the particular generators that represent the state, thus at any point the set of generators can be changed by an arbitrary sequence of #emph[row transformations] $hat(G)_i arrow.r hat(G)_i hat(G)_j$, $j eq.not i$.

To collect a single sample, the simulation begins by initializing all $n$ components of the leakage state label $macron(a)$ to $c$ and the $m = n$ qubits in the product state $|00 dots.h.c 0⟩$, by selecting the stabilizer generators $hat(G)_i = sigma_z^( i )$, $i = 1, 2 dots.h m$, where a single-qubit state $|0⟩$ is a $+ 1$ eigenstate of $sigma_z$. Subsequently, the simulator iterates over the operations in the circuit, at each step updating the stabilizer generators and possibly the leakage state label $macron(a)$:

+ `clifford`: a Clifford unitary $hat(U)$ acting on devices in the index set $J subset lr({1, 2, dots.h, n})$.
  #set enum(numbering: "(i)")
  + if any of the devices in $J$ are outside of the computational state, do nothing;
  + otherwise, replace each stabilizer generator $hat(G)_i$ with a Pauli operator $hat(G)'_i = hat(U) hat(G)_i hat(U)^dagger$.

+ `measure`: an ideal computational-basis measurement of qubit $j$.
  #set enum(numbering: "(i)")
  + If the device $j$ is leaked, `return` the leakage label $a[j]$.
  + Otherwise, use row transformations to select a set of generators with (a) only $hat(G)_1$ supported on the qubit $j$ if it is unentangled, or (b) only $hat(G)_1$ and $hat(G)_2$ supported on $j$, where $hat(G)_1[j] = sigma_x$ and $hat(G)_2[j] = sigma_z$.
  + In case (a), if $hat(G)_1[j] in lr({sigma_x, sigma_y})$, or in case (b), select the result $alpha in lr({0, 1})$ randomly with equal probabilities and replace the 1st generator with $hat(G)'_1 = (-1)^alpha sigma_z^(j)$; `return` $alpha$.
  + Otherwise, in case (a) with $hat(G)_1[j] = sigma_z$, do full row reduction of the generator matrix to separate the independent generator $hat(G)'_1 = plus.minus sigma_z equiv (-1)^alpha sigma_z$ supported only on the qubit $j$, `return` the sign bit $alpha$.

+ `reset`: an ideal reset of device $j$ to the state $|0⟩$.
  #set enum(numbering: "(i)")
  + If the device $j$ is leaked, set the label $a[j] = c$ and add an extra generator $hat(G)_(m+1) = sigma_z^(j)$; increment $m$.
  + Otherwise, do partial row reduction as in step 2(ii) above, and replace the first generator with $hat(G)'_1 = + sigma_z^(j)$.

+ `paulichannel`: Generalized Pauli (GP) channel acting on devices in the index set $J$.
  #set enum(numbering: "(i)")
  + Construct the initial subspace vector $macron(dotless.i) = macron(a)[J]$ and choose the final subspace vector $macron(f)$ according to the probability distribution $P(macron(dotless.i) arrow.r macron(f))$.
  + For this outcome, select the set of devices $U$ transitioning upward from the computational subspace. For each $j in U$: (a) do partial row reduction as in step 2(ii); (b) drop the first generator $G_1$ (swap it with $G_m$ and decrement $m$); (c) if the qubit $j$ was entangled with the rest of the system, replace $G_2[j] = sigma_z$ with the identity operator; (d) with probability $p = 1\/2$, flip the sign of $G_2$; (e) set leakage label $a[j]$ according to its value in $macron(f)$.
  + Select the Pauli error operator $hat(E) = macron(sigma)_mu$ according to the conditional distribution $p(macron(sigma)_mu | macron(dotless.i) arrow.r macron(f))$ supported on the set $R$ of devices remaining in the computational subspace, and flip the signs of all the generators $G_i$ which anticommute with the error $E$, $G'_i equiv E G_i E^dagger = plus.minus G_i$.
  + For every device $j in D$ coming down from leakage, (a) add a generator $G_(m+1) = plus.minus sigma_z^(j)$ with a random sign; (b) set $a[j] := c$; and (c) increment $m$.


Once the last operation in the circuit is reached, a record of all measurement results is kept for each sample.

The validity of operations described follow from general theory of entanglement for stabilizer states @Fattal-Cubitt-Yamamoto-Bravyi-Chuang-2004.

=== Generalized twirling approximation <sec:twirling>

Given an arbitrary quantum channel $cal(E)$ with Kraus operators $K_j$ acting on devices $J$, the Generalized Pauli Twirling approximation allows us to define a corresponding GP channel. This mapping corresponds to the following physical process:

+ For a given initial subspace $cal(H)_(macron(dotless.i))$, double the number of degrees of freedom and prepare a maximally entangled state over the product $cal(H)_(macron(dotless.i)) ⊗ cal(H)_(macron(dotless.i))$, a direct product of EPR pairs. Namely, the devices whose index in $macron(dotless.i)$ match the computational subspace and their matching ancillary pairs should be set as the $+ 1$ eigenstates of $sigma_x ⊗ sigma_x$ and $sigma_z ⊗ sigma_z$.

+ Apply $cal(E)$ to the first subsystem.

+ Measure the leakage status of each device in the first subsystem, thereby determining the final subspace $macron(f)$. This can be represented by the single-device projective measurement with elements

  #eqnn($
    P_c &= |0⟩ ⟨0 | + |1⟩ ⟨1 | \
    P_2 &= |2⟩ ⟨2 | \
    P_3 &= |3⟩ ⟨3 |
  $)

+ For the devices that remained in the computational subspace ($R$), measure the commuting stabilizers $sigma_x ⊗ sigma_x$ and $sigma_z ⊗ sigma_z$ acting on them and their entangled pair. Associate the resulting stabilizer eigenvalue pairs $( 1, 1 )$, $( 1, -1 )$, $( - 1, 1 )$, $( - 1, -1 )$ with the Pauli operators $I$, $sigma_x$, $sigma_z$, $sigma_y$, respectively. The total error operator $sigma_(macron(mu))$ over all devices in $R$ is the tensor product of all single qubit errors.

The conditional probability distribution $P ( macron(i) arrow.r macron(f), macron(mu) )$ is then defined as the probability of recording the outcomes $macron(f), macron(mu)$ assuming an initial state preparation in subspace $cal(H)_(macron(dotless.i)) ⊗ cal(H)_(macron(dotless.i))$. Accordingly, the extracted GP channel will have the exact same statistics under the physical process represented above.

The probabilities $P (macron(i) arrow.r macron(f), macron(mu))$ can be determined directly from the Kraus operators $K_j$. For a given transition $macron(dotless.i) arrow.r macron(f)$, Kraus operator $K_j$ decomposed as a sum over tensor products for the devices in $U$, $R$, $D$, and $L$.

#eqnn($
  P_(macron(f)) K_j P_(macron(dotless.i)) = sum_(macron(u), macron(d)) (K_j^(macron(u), macron(d), macron(dotless.i) arrow.r macron(f)))_R \
  quad ⊗ |macron(f)[U]⟩ ⟨macron(u) |_U ⊗ |macron(d)⟩ ⟨macron(dotless.i)[D] |_D ⊗ |macron(f)[L]⟩ ⟨macron(dotless.i)[L] |_L
$)

where $|macron(u)⟩, |macron(d)⟩$ sum over the tensor product of standard (normalized) basis vectors ($|0⟩, |1⟩$) representing an orthonormal basis for the computational subspaces of devices $U$ and $D$, respectively. The vectors $|macron(f)[U]⟩$, $|macron(dotless.i)[D]⟩$, and $(|macron(dotless.i)[L]⟩, |macron(f)[L]⟩)$ correspond to the leakage states of the devices which leaked, returned to the computational subspace, and remained leaked, respectively. (Note that the last operator in the tensor product can be used to represent transitions between leaked states.) The sub-block Kraus operator $K_j^(macron(u), macron(d), macron(f)[U+L], macron(dotless.i)[D+L])$ can correspondingly be written as

#eqnn($
  K_j^(macron(u), macron(d), macron(dotless.i) arrow.r macron(f)) = \
  quad lr(( chevron.l macron(f)[U]|_U ⊗ chevron.l macron(d)|_D ⊗ chevron.l macron(f)[L]|_L )) K_j \
  quad lr(( |macron(u)⟩_U ⊗ |macron(dotless.i)[D]⟩_D ⊗ |macron(dotless.i)[L]⟩_L ))
$)

Given the above decomposition, we can further break up the operators on the computational devices $R$ by decomposing them as a linear combination of Pauli operators,

$
  K_j^(macron(u), macron(d), macron(dotless.i) arrow.r macron(f)) = sum_(macron(mu)) c_(macron(mu))^(j, macron(u), macron(d), macron(dotless.i) arrow.r macron(f)) sigma_(macron(mu)),
$

where the sum is taken over the Pauli operators $sigma_(macron(mu))$ acting on the devices in $R$; these operators are assumed to vanish on the leakage states $|2⟩, |3⟩$. Below we will shorten the notations by dropping the extra fixed indices $macron(dotless.i) arrow.r macron(f)$. From this expansion, one may derive the conditional distribution, cf. @eq:compound-data:

$
  P (macron(dotless.i) arrow.r macron(f), macron(mu)) equiv P (macron(dotless.i) arrow.r macron(f)) P (sigma_(macron(mu)) | macron(dotless.i) arrow.r macron(f), macron(mu)) \
  = 1 \/ 2^(| U |) sum_(macron(u), macron(d), j) |c_(macron(mu))^(j, macron(u), macron(d))|^2.
$<eq:MarkovProb>

The first term denotes the fact that each state $|macron(u)⟩$ exists in a computational subspace of dimension $2^(| U |)$. Finally, the sum itself is the average probability of applying $sigma_(macron(u))$ on the qubits in $R$. In the case of no leakage transitions ($macron(dotless.i) = macron(f)$) it corresponds to the typical Pauli Twirling Approximation.

As a simple example, we apply the approximation to an error channel representing coherent rotation between the $|1⟩$ and $|2⟩$ states. The error channel is composed of a single unitary Kraus operator

#eqnn($
  U &= |0⟩ ⟨0 | + cos(theta) (|1⟩ ⟨1 | + |2⟩ ⟨2 |) + |3⟩ ⟨3 | \
  &+ sin(theta) (|1⟩ ⟨2 | - |2⟩ ⟨1 |).
$)

Using the definitions of the single device projection operators, the non-vanishing blocks of the Kraus operator are

#eqnn($
  P_c U P_c = |0⟩ chevron.l 0 | + cos(theta) |1⟩ chevron.l 1 | \
  quad = (cos^2 (theta \/ 2) sigma_I + sin^2 (theta \/ 2) sigma_z) ⋅ 1_U ⋅ 1_D ⋅ 1_L \
  P_c U P_2 = sin(theta) × (1_R ⋅ 1_U ⋅ |1⟩ ⟨2 |_D ⋅ 1_L) \
  quad + 0 × (1_R ⋅ 1_U ⋅ |0⟩ ⟨2 |_D ⋅ 1_L) \
  P_2 U P_c = -sin(theta) (1_R ⋅ |2⟩ ⟨1 |_U ⋅ 1_D ⋅ 1_L) \
  quad + 0 × (1_R ⋅ |2⟩ ⟨0 |_U ⋅ 1_D ⋅ 1_L) \
  P_2 U P_2 = cos(theta) 1_R ⋅ 1_U ⋅ 1_D ⋅ |2⟩ ⟨2 |_L \
  P_3 U P_3 = 1_R ⋅ 1_U ⋅ 1_D ⋅ |3⟩ ⟨3 |_L
$)

where we have added trivial terms with zero coefficients to emphasize that the subspace $cal(H)_c$ it two-dimensional. From this decomposition we may read off the non-vanishing Pauli coefficients:

#eqnn($
  c_I^(c arrow.r c) &= cos^2 (theta \/ 2), quad c_Z^(c arrow.r c) = sin^2 (theta \/ 2), \
  c_0^(u=1, c arrow.r 2) &= sin(theta) = -c_0^(d=1, 2 arrow.r c), \
  c_0^(2 arrow.r 2) &= cos(theta), \
  c_0^(3 arrow.r 3) &= 1.
$)

The conditional probabilities can now be read off using @eq:MarkovProb. Evidently, for each input state $dotless.i$, the sum of output probabilities equals one.

#block(breakable: false)[
  #align(center)[
    #table(
      columns: 4,
      align: center,
      stroke: 0.5pt,
      table.header([$dotless.i$], [$f$], [$mu$], [$P(dotless.i arrow.r f, mu)$]),
      [$c$], [$c$], [$I$], [$cos^4 (theta\/2)$],
      [$c$], [$c$], [$Z$], [$sin^4 (theta\/2)$],
      [$c$], [$2$], [-], [$sin^2 (theta)\/2$],
      [$2$], [$c$], [-], [$sin^2 (theta)$],
      [$2$], [$2$], [-], [$cos^2 (theta)$],
      [$3$], [$3$], [-], [$1$],
    )
  ]
]


As expected, the probability to observe a transition down from state $|2⟩$ is just the modulus square of the transition amplitude, $"sin"^(2)(theta)=|\⟨1 |U| 2⟩|^(2)$. The reverse transition, though, has half this probability because a device in the computational subspace is (on average) in state $|1⟩$ only half the time. A higher order effect cause by this twirling is the dephasing observed in the $c arrow.r c$ transition. This can be interpreted as a measurement "back-action": because the device was not observed to leak and only state $|1⟩$ can leak, the channel acts like a weak measurement in the standard basis.

== Comparison of Pauli $+$ and quantum simulations <comparison-of-pauli-and-quantum-simulations>
// [figvision-cn] imgs/d3W_Z_d3W_X_cq_comparison.png
// 这是一张二维曲线图，展示了不同实验条件下逻辑错误概率随
// 纠错轮次的变化。 图表整体布局： 图表背景为白色，四周有
// 黑色边框。横轴表示“Error correction round”（纠错轮次），
// 范围从0到25，主刻度间隔为5，标注数值为0, 5, 10, 15, 20
// , 25。纵轴表示“Logical error probability”（逻辑错误概
// 率），范围从0.00到0.40，主刻度间隔为0.05，标注数值为
// 0.00, 0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40。
// 图中包含四条数据曲线，均从左下方向右上方延伸，呈单调递
// 增趋势，且随着横坐标增加，增长速率逐渐减缓（曲线斜率减
// 小）。所有曲线在横坐标约等于1处开始，纵坐标值约为0.02；
// 在横坐标等于25处，纵坐标值介于0.40至0.42之间。 具体曲
// 线描述如下： 第一条曲线（蓝色实线）：代表“d3W_Z
// kraus_sim (ε = [3.33 ± 0.017] %)”。该曲线为连续蓝色实
// 线，位于四条曲线的中间偏下位置。在横坐标25处，其纵坐标
// 值约为0.41。 第二条曲线（橙色虚线）：代表“d3W_Z Pauli+
// (ε = [3.31 ± 0.014] %)”。该曲线由橙色短点组成的虚线构
// 成，紧邻蓝色实线下方或几乎重合，在大部分区间内略低于蓝
// 色实线。在横坐标25处，其纵坐标值约为0.405。 第三条曲线
// （绿色实线）：代表“d3W_X kraus_sim (ε = [3.53 ± 0.018]
// %)”。该曲线为连续绿色实线，位于四条曲线的最上方。在横
// 坐标25处，其纵坐标值约为0.42。 第四条曲线（红色虚线）：
// 代表“d3W_X Pauli+ (ε = [3.5 ± 0.016] %)”。该曲线由红色
// 短点组成的虚线构成，紧邻绿色实线下方或几乎重合，在大部
// 分区间内略低于绿色实线。在横坐标25处，其纵坐标值约为
// 0.415。 图例说明： 图例位于图表右下角区域，是一个带有
// 浅灰色背景和细黑框的矩形框。内部从上到下依次列出四条曲
// 线的标识： 蓝色实线后接文字：“d3W_Z kraus_sim (ε = [
// 3.33 ± 0.017] %)” 橙色虚线后接文字：“d3W_Z Pauli+ (ε =
// [3.31 ± 0.014] %)” 绿色实线后接文字：“d3W_X kraus_sim
// (ε = [3.53 ± 0.018] %)” 红色虚线后接文字：“d3W_X Pauli
// + (ε = [3.5 ± 0.016] %)” 趋势与结论： 所有曲线显示，随
// 着纠错轮次增加，逻辑错误概率持续上升。对于相同基（Z或X），
// 使用kraus_sim模型的曲线始终略高于Pauli+模型对应的曲线。
// 同时，X基下的两条曲线整体位于Z基对应曲线的上方，表明在
// 相同参数下，X基实验的逻辑错误概率更高。各曲线的误差项ε
// 值相近，但X基的ε值略大于Z基。
#figure(placement: auto, image("imgs/d3W_Z_d3W_X_cq_comparison.png", width: 100%),
  caption: [
    Comparison of simulated logical error probabilities for the distance-3 West, X and Z basis experiments. Each data point is the average over $N = 2 times 10^5$ samples, so that its standard deviation is bounded from above by $1\/sqrt(4 N) approx 0.11 "%"$.
  ]
) <fig:quantum_classical_fidelities>

// [figvision-cn] imgs/detection_event_fractions.png
// 该图包含两个并排的子图，左侧子图标题为“kraus_sim”，右
// 侧子图标题为“Pauli+”。两个子图均为曲线图，用于展示距离
// -3西（West）型X基实验中模拟的探测事件分数随探测轮次的
// 变化。 左子图（kraus_sim）： 坐标轴名称与范围：横轴为“
// Detection round”（探测轮次），范围从0到25，刻度间隔为5；
// 纵轴为“Detection fraction”（探测事件分数），范围从
// 0.000到0.200以上，主刻度线位于0.000、0.025、0.050、…、
// 0.200。图中所有曲线均带有圆形数据点标记和实线连接。 曲
// 线含义与色标： 蓝色带圆点实线：代表q3_2: X, weight=2。
// 曲线从第0轮约0.055开始，缓慢上升至第24轮约0.128，第25
// 轮骤降至约0.078。 黄色带方块实线：代表q4_3: Z, weight=
// 4。曲线从第0轮约0.095开始，平缓上升至第24轮约0.172，第
// 25轮骤降至约0.145。 绿色带三角实线：代表q4_5: Z,
// weight=2。曲线从第0轮约0.065开始，上升至第24轮约0.130，
// 第25轮骤降至约0.125。 橙色带菱形实线：代表q5_2: X,
// weight=4。曲线从第0轮约0.075开始，快速上升后在约0.205
// 处达到峰值（第12至24轮），第25轮骤降至约0.148。 紫色带
// 方块实线：代表q5_4: X, weight=4。曲线从第0轮约0.065开
// 始，上升至第24轮约0.188，第25轮骤降至约0.138。 棕色带
// 圆点实线：代表q6_1: Z, weight=2。曲线从第0轮约0.095开
// 始，微幅波动上升至第24轮约0.100，第25轮骤降至约0.098。
// 粉色带叉号实线：代表q6_3: Z, weight=4。曲线从第0轮约
// 0.075开始，上升至第24轮约0.195，第25轮骤降至约0.135。
// 灰色带圆点实线：代表q7_4: X, weight=2。曲线从第0轮约
// 0.055开始，上升至第24轮约0.150，第25轮骤降至约0.118。
// 趋势与结论：所有曲线在第0轮后迅速上升，随后趋于平缓或
// 继续缓慢增长，表明探测事件分数随轮次增加而累积。在第25
// 轮时，除q6_1外，所有曲线均出现显著下降，暗示系统在该轮
// 次发生剧烈状态变化或测量终止。整体趋势显示漏泄积累导致
// 探测事件分数随时间缓慢增加。 右子图（Pauli+）： 坐标轴
// 名称与范围：与左子图完全相同，横轴“Detection round”范
// 围0–25，纵轴“Detection fraction”范围0.000–0.200以上。
// 曲线含义与色标：图例与左子图一致，对应相同的量子比特、
// 基矢及权重设置。 各曲线行为： q3_2: X, weight=2（蓝线）：
// 从0.055升至0.128（第24轮），第25轮跌至0.078。 q4_3: Z,
// weight=4（黄线）：从0.095升至0.172（第24轮），第25轮跌
// 至0.145。 q4_5: Z, weight=2（绿线）：从0.065升至0.130
// （第24轮），第25轮跌至0.125。 q5_2: X, weight=4（橙线）：
// 从0.075升至0.208（第12–24轮），第25轮跌至0.148。 q5_4:
// X, weight=4（紫线）：从0.065升至0.188（第24轮），第25
// 轮跌至0.138。 q6_1: Z, weight=2（棕线）：从0.095微升至
// 0.100（第24轮），第25轮跌至0.098。 q6_3: Z, weight=4（
// 粉线）：从0.075升至0.195（第24轮），第25轮跌至0.135。
// q7_4: X, weight=2（灰线）：从0.055升至0.150（第24轮），
// 第25轮跌至0.118。 趋势与结论：与左子图高度相似，但部分
// 曲线数值略高（如q5_2最高达0.208 vs 0.205），表明Pauli+
// 模型下漏泄效应稍强。同样在第25轮出现集体骤降，验证了实
// 验数据中观察到的现象——探测事件分数随轮次缓慢增长源于数
// 据量子比特的漏泄积累，且两种模拟方法（kraus_sim与Pauli
// +）定性结果一致。
#figure(placement: auto, image("imgs/detection_event_fractions.png", width: 100%),
  caption: [
    Comparison of simulated detection event fractions for the distance-3 West, X-basis experiment. As in the experimental data, we see a slow increase in detection event fraction as the number of rounds progresses. This can be attributed to leakage accumulation in the data qubits.
  ]
) <fig:quantum_classical_defs>

// [figvision-cn] imgs/scatter_plot_spatial_and_timelike.png
// 该图像由三个并排排列的散点图组成，从左至右依次标记为子
// 图(a)、(b)和(c)，用于对比距离-3 West码在X基实验中模拟
// 得到的类空与类时边缘概率。所有子图均展示蓝色实心圆点构
// 成的数据分布，以及一条贯穿数据的黑色虚线对角线（斜率为
// 1），表示理想线性关系。 子图(a)：标题为“spatial X edge
// probability R² = 0.959”。横轴标注为“kraus_sim”，范围从
// 0.00到0.05，单位为无量纲概率值；纵轴标注为“Pauli+”，范
// 围同样为0.00到0.05。图中蓝色散点密集分布在黑色虚线附近，
// 呈现强正相关趋势，表明Kraus算符模拟结果与Pauli噪声模型
// 预测高度一致。R²值为0.959，说明拟合优度较高。 子图(b)：
// 标题为“spatial Z edge probability R² = 0.978”。横轴标
// 注为“kraus_sim”，范围从0.02到0.07；纵轴标注为“Pauli+”，
// 范围从0.02到0.07。蓝色散点沿黑色虚线紧密聚集，相关性更
// 强于子图(a)。R²值为0.978，显示Z空间边缘的概率模拟与理
// 论预期吻合度更高。 子图(c)：标题为“timelike edge
// probability R² = 0.969”。横轴标注为“kraus_sim”，范围从
// 0.02到0.06；纵轴标注为“Pauli+”，范围从0.02到0.06。蓝色
// 散点围绕黑色虚线分布，略宽于前两个子图，但仍保持良好线
// 性趋势。R²值为0.969，表明类时边缘（即相隔一个纠错轮次
// 的稳定子之间）的概率模拟也具有较高的准确性。 整体而言，
// 三张子图共同验证了在不同类型边缘（X空间、Z空间、类时）
// 上，基于Kraus算符的数值模拟结果与简化Pauli噪声模型预测
// 具有高度一致性，支持使用Pauli近似进行后续分析的有效性。
#figure(scope: "parent", placement: auto, image("imgs/scatter_plot_spatial_and_timelike.png", width: 100%),
  caption: [
    Comparison of simulated spacelike and timelike edge probabilities for the distance-3 West, X-basis experiment. From left to right, the scatter plots correspond to "X" spatial edges (between stabilizers in the initial state basis), "Z" spatial edges (between stabilizers with undetermined initial value), and timelike edges (between the stabilizers separated by one error correction round). The $R^2$ quantities reported above correspond to the coefficient of determination between the "observed" (kraus\_sim) and "predicted" (Pauli$+$) edge probabilities.
  ]
) <fig:quantum_classical_scatter>

We tested the validity of the Generalized Twirling Approximation used by the #emph[Pauli+] model by doing a direct comparison with the equivalent kraus_sim simulation. Specifically, we simulated the distance-3 $Z$-basis and $X$-basis experiments associated with the West device configuration. Each 25-round simulation corresponded to 200,000 samples. The classical #emph[Pauli+] simulation required about 160 seconds (distributed over 16 CPU cores), while the quantum simulation required ~11 hours#footnote[Note that the qsim backend for the kraus_sim simulator has not been optimized for performance on these system sizes.#text(fill: white, size: 0pt)[#cite(<Note3>)]]. Decoding was implemented using the algorithm in Ref. @fowler2013optimal, with detection cluster probabilities inferred from the $p_(i j)$ matrix.

As can be seen in @fig:quantum_classical_fidelities–@fig:quantum_classical_scatter, there is generally quite good agreement between both simulations with respect to logical error and typical detection event statistics. It is not entirely clear why this is the case. Generally, the surface code measurement circuit implies a stabilizer-state projection at the end of each cycle; this has the effect of "twirling" the quantum noise, so that for a single data qubit error in the absence of leakage the approximation is exact @cai2019constructing.  The same is true for errors in non-neighboring circuit locations. With the net error rates $tilde 1 "%"$ per gate and total of $n tilde 20$ qubits, we expect around one error per cycle. Moreover, some of the modeled error channels, (such as dephasing), are described by a Pauli channel exactly.

On the other hand, our simulations also include some unitary rotation errors (due to crosstalk) which may add coherently in a QMC simulation @Bravyi-Englbrecht-Koenig-Peard-2018.  Early work @katabarwa2015logical simulating smaller distance codes suggested that Twirling Approximation under both decoherence and unitary gate errors strongly over predicted the expected logical error (by factors of 2 or more). Interestingly, an early numerical test of the distance-3 surface code @tomita_low-distance_2014 found good agreement with the Pauli Twirling Approximation under amplitude damping ($T_1$ decay) and (white noise) dephasing, but only in the logical $Z$ basis (twirling over-predicted the error for the logical $X$). There are several factors that may have contributed to reducing these effects in our simulations. First, the Hadamard operations in our experiments are chosen so that the stabilizer generators describing our system are all of mixed $Z X X Z$ type @wen2003quantum @bonilla2021xzzx. This has the effect of approximately symmetrizing all bit-flip and phase-flip errors. Second, we deliberately insert $X$ gates whenever a qubit is idle, which is also known to reduce coherent errors. With these measures in place, a good agreement between an exact QMC and a classical simulations indicates that the net contribution of coherently-added errors is not large enough to see.

#figure(
  align(center)[#table(
    columns: 2,
    align: (left,center,),
    table.header(table.cell(align: center)[Component], [Error probability],),
    table.hline(),
    [SQ gates], [$1.09 times 10^(- 3)$],
    [CZ gates], [$6.05 times 10^(- 3)$],
    [Data qubit idle], [$2.46 times 10^(- 2)$],
    [Reset], [$1.86 times 10^(- 3)$],
    [Readout], [$1.96 times 10^(- 2)$],
    [CZ leakage], [$2.0 times 10^(- 4)$],
    [Leakage from heating], [$6.4 times 10^(- 4)$],
    [CZ crosstalk], [$9.5 times 10^(- 4)$],
  )]
  , caption: [Average probabilities of main errors at the operation point of $d = 5$ surface code experiments.]
  , kind: table
  ) <tab:table-expt-operation-point>


= SENSITIVITY OF LOGICAL ERROR PER CYCLE TO PHYSICAL ERRORS <sensitivity-of-logical-error-per-cycle-to-physical-errors>
In this section we provide the sensitivity coefficients of surface code logical error per cycle ($epsilon_L$) to errors in the main components of the device; namely, control-Z (CZ) gates, single qubit (SQ) gates, data qubit idle (this includes dynamical decoupling sequence during readout and reset time), readout and reset. Additionally, we also present $epsilon_L$ sensitivity coefficients to leakage and crosstalk. The results are obtained using the Pauli+ simulator and the correlated minimum-weight perfect matching decoder. We note that this analysis is separate from the $1\/Lambda$ analysis presented in Fig.~4a of the main text. Specifically, in Fig.~4a, we used the methodology of Ref.~@chen2021exponential, to estimate the $1\/Lambda$ budget with sensitivities evaluated at the half-operation point (i.e., component errors being 0.5 times the component errors shown in @tab:table-expt-operation-point, used in the main simulation).

For a certain component error (e.g., SQ gate error), we evaluate the sensitivity coefficient for the logical error per cycle $epsilon_"L"$ using the formula

$
  nu_("error") = (delta epsilon_"L") \/ (delta p_("error")),
$<eq:sensitivity_formula>

where $delta epsilon_"L"$ is the change of the logical error per cycle due to a variation $delta p_("error")$ of the error probability of all components of the same type (e.g., when calculating the $epsilon_"L"$ sensitivity to SQ gate errors, $delta p_("error")$ is the error change of all SQ gates, excluding dynamical decoupling gates).

The logical error per cycle $epsilon_"L"$ is a nonlinear function of the component error probabilities, so the sensitivity coefficients depend on the operation point (i.e., linearization point). We are particularly interested in evaluating the $epsilon_"L"$ sensitivities at the experimental operation point, discussed below.

== Experimental operation point <experimental-operation-point>
The experimental operation point of the $d = 5$ surface code experiment (used in the simulator) is specified by the error probabilities of all components in the surface code circuit. We independently measure the component error probabilities to be used in the simulator. @tab:table-expt-operation-point shows Pauli error probabilities averaged over all components of the same type, while individual values for every circuit element are used in the simulator.

In particular, the SQ gate errors are measured by RB for each qubit and the CZ gate errors are measured by XEB for each CZ. Data qubit idle errors are measured individually by interleaved RB, which includes dynamical decoupling sequence used during readout and reset. The readout and reset errors are also measured independently.

Another imperfection present in our device is leakage into non-computational states (mainly to state $|2⟩$). We assume that leakage is generated at the high frequency qubit of a CZ gate (e.g., due to qubit dephasing during CZ operation) with a nominal probability of

$
  p_2^("CZ") = 0.25 p_t = 2.0 times 10^(-4),
$<eq:p2_CZ>

where we assume parameter $p_t = 8 times 10^(-4)$ for all CZs (see @sec:leakage) and the factor 0.25 is the probability of state $|11⟩$ before a CZ gate during surface code operation. Moreover, leakage can be generated from a non-equilibrium "heating" process at each qubit, for which we use a probability per QEC cycle of

$
  p_2^("heating") = 0.5 Gamma_(1 arrow.r 2) t_"cycle" = 6.4 times 10^(-4),
$<eq:p2_heating>

where the factor 0.5 is the probability that the qubit is in state $|1⟩$ during surface code operation, the QEC cycle duration is $t_"cycle" = 896 space "ns"$, and we assume the experimentally estimated heating rate of $Gamma_(1 arrow.r 2) = 1\/(700 space mu "s")$ being the same for all qubits. Note that in the simulator the possibility of heating is considered after each gate or idling, so the actual parameter is $Gamma_(1 arrow.r 2)$, but we still characterize the heating strength by $p_2^("heating")$.

Finally, another imperfection in the device is the presence of unwanted interactions (crosstalk) between simultaneous gates (either single qubit idle or CZ), see @sec:x-talk. This error channel is modelled individually for all elements and leads to CZ errors with a Pauli error probability (averaged over all CZs) of

$
  p_("CZ")^("crosstalk") = 9.5 times 10^(-4),
$

which is roughly 15% of the observed total CZ error. Note that in the simulator this contribution is subtracted from the total CZ error to obtain the depolarizing part of the CZ error.

#figure(
  align(center)[#table(
    columns: 3,
    align: (left,center,center,),
    table.header(table.cell(align: center)[Component], [sensitivity (d3)], [sensitivity (d5)],),
    table.hline(),
    [SQ gates], [$6.2 plus.minus 0.3$], [$8.4 plus.minus 0.2$],
    [CZ gates], [$2.13 plus.minus 0.08$], [$4.0 plus.minus 0.2$],
    [Data qubit idle], [$0.91 plus.minus 0.02$], [$1.05 plus.minus 0.03$],
    [Readout or reset], [$0.26 plus.minus 0.01$], [$0.41 plus.minus 0.02$],
    [Leakage (heating)], [$2.4 plus.minus 0.3$], [$4.0 plus.minus 0.8$],
    [CZ crosstalk], [$5.0 plus.minus 0.5$], [$6.5 plus.minus 0.6$],
  )]
  , caption: [Logical error rate sensitivities at the experimental operation point.]
  , kind: table
  ) <tab:LER_sensitivities_expt_op_point>


== Logical error rate sensitivities for $d = 3$, 5 surface codes <logical-error-rate-sensitivities-for-d-3-5-surface-codes>
@tab:LER_sensitivities_expt_op_point shows the sensitivity coefficients of $d = 3$ and $d = 5$ logical error per cycle to errors in the main components of the surface code circuit, and also the sensitivities to leakage and crosstalk errors. The main takeaway from this table is that $d = 5$ surface code is more sensitive to component errors than $d = 3$ surface code.

We have computed these sensitivity coefficients at the experimental operation point. For instance, for SQ gate errors, $delta p_("error")$ in @eq:sensitivity_formula is the variation of the SQ gate error probability $delta p_("sq")$, which is assumed to be the same for all SQ gates (excluding those in dynamical decoupling sequence). As shown by the orange markers in @fig:sensitivities_d3 and~@fig:sensitivities_d5, the dependence of the change of logical error per cycle $delta epsilon_("L")$ on the variation of the SQ gate error $delta p_("sq")$ is fairly linear. From a linear fit (orange dashed lines in @fig:sensitivities_d3 and~@fig:sensitivities_d5) to the simulation data we obtain the sensitivity coefficients for single qubit gate errors: $nu_("sq") = 6.2 plus.minus 0.3$ ($d = 3$) and $8.4 plus.minus 0.2$ ($d = 5$). A similar procedure is used to obtain the $epsilon_("L")$ sensitivity coefficients for the component errors indicated in @tab:LER_sensitivities_expt_op_point.

For leakage and crosstalk, there are subtleties in this procedure. For leakage from heating, we actually vary the heating rate $Gamma_(1 arrow.r 2)$ applied to all qubits, while in @eq:sensitivity_formula we use $delta p_("error") = 0.5 delta Gamma_(1arrow.r 2)  t_("cycle")$. For crosstalk, we scale all crosstalk unitaries as $U_I arrow.r U_I^alpha$ (with the power $alpha = 1$ corresponding to the operation point) and use $delta p_("error") = (alpha^2-1) p_("CZ")^("crosstalk")$ in @eq:sensitivity_formula with the nominal crosstalk error value $p_("CZ")^("crosstalk") = 9.5 times 10^(-4)$.

// [figvision-cn] imgs/sensitivities_d3.png
// 这是一张二维曲线图，展示了表面码（surface code）的逻辑
// 错误率对六种不同物理错误源概率变化的敏感性。 坐标轴信
// 息： 横轴标记为“δp_error”，代表对应组件错误概率的变化
// 量，范围从0.000到0.006，主刻度间隔为0.001。纵轴标记为“
// Logical error rate (ε_L)”，代表逻辑错误率，范围从0.030
// 到略高于0.038，主刻度标记包括0.030、0.032、0.034、
// 0.036和0.038。 图例与数据系列： 图的左下角包含一个白色
// 背景的图例框，列出了六个数据系列，每个系列由一种颜色的
// 虚线表示，并在特定位置标有同色的实心三角形数据点。所有
// 曲线均起始于横坐标接近0的位置，纵坐标约为0.0335至0.034
// 之间，并随着横坐标增加呈线性上升趋势。 具体描述如下：
// CZ error（CZ门错误）：蓝色虚线。该曲线斜率中等，数据点
// 延伸至横坐标约0.0012处，对应的纵坐标约为0.0363。 SQ
// error（单量子比特门错误）：橙色虚线。该曲线具有图中最
// 大的斜率之一，表明极高的敏感性。其数据点仅延伸至横坐标
// 约0.0004处，纵坐标已达到0.036附近。 Dq idle error（数
// 据量子比特空闲错误）：绿色虚线。该曲线斜率较小，但数据
// 点覆盖的横坐标范围最宽，延伸至横坐标约0.0057处，对应的
// 纵坐标约为0.039。 Readout error（读出错误）：红色虚线。
// 该曲线斜率最小，表明敏感性最低。其数据点同样覆盖了较宽
// 的横坐标范围，延伸至约0.0052处，对应的纵坐标约为0.035。
// CZ crosstalk（CZ串扰）：紫色虚线。该曲线斜率较大，仅次
// 于橙色曲线。其数据点延伸至横坐标约0.0005处，纵坐标超过
// 0.038。 leakage from heating（加热导致的泄漏）：褐色虚
// 线。该曲线斜率介于蓝色和绿色曲线之间。其数据点延伸至横
// 坐标约0.0013处，纵坐标约为0.0365。 趋势与结论： 图中所
// 有虚线均为模拟数据点的线性拟合结果，其斜率代表了逻辑错
// 误率对该特定错误源的敏感度。结果显示，SQ error（橙色）
// 和CZ crosstalk（紫色）引起的逻辑错误率增长最快，即系统
// 对这两种错误最为敏感；而Readout error（红色）的影响相
// 对最小。
#figure(placement: auto, image("imgs/sensitivities_d3.png", width: 100%),
  caption: [
    Calculation of logical error rate sensitivities for $d = 3$ surface code. The depicted logical error rates are averaged values over the four $d = 3$ surface code grids. The variable $delta p_("error")$ is the variation of the corresponding component error probability. Dashed lines are linear fits to the simulation data (markers) and their slopes are the sensitivities reported in @tab:LER_sensitivities_expt_op_point
  ]
) <fig:sensitivities_d3>

// [figvision-cn] imgs/sensitivities_d5.png
// 子图类型：曲线图，包含离散数据点（标记）和线性拟合虚线。
// 坐标轴信息：横轴表示物理量 $\delta p_{\text{error}}$，
// 无单位，数值范围从 0.000 到 0.006，主刻度间隔为 0.001；
// 纵轴表示逻辑错误率 $\varepsilon_L$，无单位，数值范围从
// 0.030 到 0.038 以上，主刻度间隔为 0.002。 图例与线条说
// 明：图右上角设有图例，列出了六种不同的误差源及其对应的
// 颜色和线型。所有曲线均为虚线，代表对模拟数据点的线性拟
// 合。具体对应关系如下： CZ error：蓝色虚线，对应蓝色菱
// 形标记。 SQ error：橙色虚线，对应橙色五边形标记。 Dq
// idle error：绿色虚线，对应绿色五边形标记。 Readout
// error：红色虚线，对应红色五边形标记。 CZ crosstalk：紫
// 色虚线，对应紫色五边形标记。 leakage from heating：棕
// 色虚线，对应棕色五边形标记。 数据分布与趋势： 所有六组
// 数据的拟合直线均起始于横轴接近 0、纵轴约 0.0295 的位置，
// 表明当 $\delta p_{\text{error}}$ 趋近于零时，逻辑错误
// 率趋于一致的基础值。 随着 $\delta p_{\text{error}}$ 的
// 增加，所有曲线均呈线性上升趋势，但斜率差异显著。 橙色
// 曲线（SQ error）斜率最大，上升最为陡峭，在 $\delta p_{
// \text{error}}$ 约为 0.001 时已超出纵轴显示范围（大于
// 0.038）。 紫色曲线（CZ crosstalk）斜率次之，在 $\delta
// p_{\text{error}}$ 约为 0.0012 附近达到纵轴顶部 0.038。
// 蓝色曲线（CZ error）和棕色曲线（leakage from heating）
// 斜率相近且较大，两者几乎重叠，在 $\delta p_{\text{
// error}}$ 约为 0.0012 时纵坐标达到约 0.0348。 绿色曲线
// （Dq idle error）斜率较缓，延伸至图表最右侧，在 $\
// delta p_{\text{error}} = 0.006$ 处纵坐标约为 0.036。
// 红色曲线（Readout error）斜率最小，最为平缓，在 $\
// delta p_{\text{error}} = 0.006$ 处纵坐标约为 0.0323。
// 结论：该图展示了不同误差源对表面码逻辑错误率的敏感性。
// 斜率越大表示该误差源对逻辑错误率的影响越敏感。结果显示，
// 单量子比特门误差（SQ error）和受控非门串扰（CZ
// crosstalk）对逻辑错误率的影响最为显著，而读出误差（
// Readout error）的影响相对较小。
#figure(placement: auto, image("imgs/sensitivities_d5.png", width: 100%),
  caption: [
    Calculation of logical error rate sensitivities for $d = 5$ surface code. Similarly to @fig:sensitivities_d3, dashed lines are linear fits to the simulation data (markers) and their slopes are the sensitivities reported in @tab:LER_sensitivities_expt_op_point
  ]
) <fig:sensitivities_d5>

// [figvision-cn] imgs/pij_expt.png
// 子图 (a) 为一张对称相关矩阵的热力图，标题标注为“Expt ρ
// _ij”，表示实验测得的节点间相关性。横轴与纵轴均标记为“
// node index i”和“node index j”，代表检测节点的索引，共
// 包含25个节点，按顺序从左下角的q2_5 (Z)排列至右上角的
// q9_6 (X)。每个节点标签由两部分组成：前缀如q2、q4等表示
// 空间坐标（测量量子比特编号），后缀如_5、_3等表示时间坐
// 标（通过次要刻度指示），括号内字母(Z)或(X)表示数据量子
// 比特的制备基矢。 图中颜色映射使用连续色标，位于图像底
// 部，范围从-0.015（深蓝色）到+0.015（深红色），中间值为
// 0.000（白色）。正值用暖色调（橙红）表示正相关性，负值
// 用冷色调（蓝紫）表示负相关性，零值区域为浅色背景。矩阵
// 整体呈稀疏结构，非零元素主要沿主对角线及其附近分布，形
// 成若干斜向条带和局部块状聚集区。例如，在(q2_5, q2_5)、
// (q4_3, q4_3)等自相关位置出现强红色斑点；在相邻时空节点
// 如(q2_5, q4_3)、(q4_3, q6_1)之间可见中等强度红色连线；
// 部分远距离节点如(q8_5, q9_6)也存在微弱但可辨的相关性信
// 号。所有网格线为浅灰色细线，用于划分单元格边界。该图传
// 达的核心结论是：在25轮表面码实验中，检测事件之间存在显
// 著的时空局域相关性，且相关性随时空距离增加而衰减，符合
// 预期误差传播模式。
// [figvision-cn] imgs/pij_expt.png
// 子图 (a) 为一张对称相关矩阵的热力图，标题标注为“Expt ρ
// _ij”，表示实验测得的节点间相关性。横轴与纵轴均标记为“
// node index i”和“node index j”，代表检测节点的索引，共
// 包含25个节点，按顺序从左下角的q2_5 (Z)排列至右上角的
// q9_6 (X)。每个节点标签由两部分组成：前缀如q2、q4等表示
// 空间坐标（测量量子比特编号），后缀如_5、_3等表示时间坐
// 标（通过次要刻度指示），括号内字母(Z)或(X)表示数据量子
// 比特的制备基矢。 图中颜色映射使用连续色标，位于图像底
// 部，范围从-0.015（深蓝色）到+0.015（深红色），中间值为
// 0.000（白色）。正值用暖色调（橙红）表示正相关性，负值
// 用冷色调（蓝紫）表示负相关性，零值区域为浅色背景。矩阵
// 整体呈稀疏结构，非零元素主要沿主对角线及其附近分布，形
// 成若干斜向条带和局部块状聚集区。例如，在(q2_5, q2_5)、
// (q4_3, q4_3)等自相关位置出现强红色斑点；在相邻时空节点
// 如(q2_5, q4_3)、(q4_3, q6_1)之间可见中等强度红色连线；
// 部分远距离节点如(q8_5, q9_6)也存在微弱但可辨的相关性信
// 号。所有网格线为浅灰色细线，用于划分单元格边界。该图传
// 达的核心结论是：在25轮表面码实验中，检测事件之间存在显
// 著的时空局域相关性，且相关性随时空距离增加而衰减，符合
// 预期误差传播模式。
#figure(placement: auto, [#box(image("imgs/pij_expt.png", width: 93.0%)) #box(image("imgs/pij_expt_minus_cevol.png", width: 93.0%))

  ],
  caption: [
    Correlation matrix $p_(i j)$. Panel (a) illustrates the $600 times 600$ symmetric correlation matrix $p_(i j)$ for a 25 rounds $d = 5$ surface code experiment with data qubits prepared in the $Z$-basis. Each detection node $i = ( t s )$ has time coordinate $t$ indicated by the minor ticks and a spatial coordinate $s$ indicated by the measure qubit labels ($s =$ q2\_5, q4\_3, ... q9\_6). Panel (b) illustrates the difference of the $p_(i j)$ correlation matrices from experimental and simulation Pauli $+$ data. The ellipses indicate the main discrepancies between the experiment and simulation, which are due to excess leakage accumulation in a pair of data qubits (2\_6 and 2\_4) during the surface code experiment.
  ]
) <fig:pij_matrix>

=$p_(i j)$ diagnostics of surface codes <p_ij-diagnostics-of-surface-codes>
We analyze the pairwise detection event correlations in surface code data using the $p_(i j)$#emph[correlation matrix method] that was introduced in @chen2021exponential. This method quantifies the probability $p_(i j)$ of simultaneous triggering of two detection events at the error detection nodes $i$ and $j$. The $p_(i j)$ method can provide the correlation probability for any pair $i$-$j$ (edge), but we will focus here on the dominant pairwise correlations that we observe in the data; namely, timelike, spacelike and spacetimelike (referred to as diagonal in the main text) pairs. Hereon, we will refer to pairs as edges. We also compare the experiment #emph[vs.] Pauli $+$ simulation $p_(i j)$ correlation matrices. The experimental data that is used to compare against simulations is from the 25 rounds, $d = 5$ surface code experiment with data qubits prepared in the Z basis.

= $p_(i j)$ DIAGNOSTICS OF SURFACE CODES

== Experiment #emph[vs.] Pauli $+$ correlation matrices $p_(i j)$
Panel (a) of @fig:pij_matrix is a graphical representation of the $600 times 600$ symmetric correlation matrix $p_(i j)$ for the considered $d = 5$ surface code experiment with 25 QEC rounds and initial data qubit states prepared in the $Z$-basis. The number of detection nodes $i$ is $12 times 26 + 12 times 24 = 600$, since for the twelve measure qubits that measure the $Z$ stabilisers, we have 26 detection rounds (an additional detection round comes from the final data qubit measurements), while for the remaining twelve measure qubits that measure the X stabilisers, we have 24 detection rounds (two detection rounds less since the values of the X-stabilisers are fully random at the start and there is no $X$-measurement at the end of the Z-basis surface code experiment). The detection nodes $i = ( t s )$ have a time coordinate $t$ (spanning from $t = 0$ to 25 for the considered experiment) as well as a space coordinate $s$ associated to the measure qubits. In @fig:pij_matrix\(a), the time coordinates are indicated by the minor ticks and the space coordinates are indicated by the qubit labels such as $s = "q2_5(Z)"$ for the measure qubit 2\_5 that measures a Z stabiliser. Note that even though we actually use the $Z X X Z$ variant of the surface code, all notations for stabilizers here are as if we were using the traditional surface code.

There are two distinct types of features in the $p_(i j)$ correlation matrix illustrated in @fig:pij_matrix\(a). Namely, we see some narrow reddish features (e.g., the one inside the qubit-qubit block q8\_5-q6\_5) that can be explained in terms of conventional Pauli errors in the surface code circuit (such conventional errors manifest in the $p_(i j)$ matrix as one-pixel-wide reddish features since these errors produce detection events separated in time by 0 or 1 round). In addition, we also see some broader reddish features (e.g., the one inside the qubit-qubit block q1\_4-q2\_5) that indicate the presence of long-lived time correlations in the error detection events. Such correlations are due to leakage accumulation in the data qubits, see Ref @chen2021exponential.

Panel (b) of @fig:pij_matrix shows the difference between the $p_(i j)$ correlation matrices from experimental data and Pauli $+$ simulation data (used in the main text). We see that the $p_(i j)$ matrix difference looks much cleaner (with fainter reddish regions than the experimental $p_(i j)$ matrix shown in @fig:pij_matrix\(a)). This indicates that Pauli $+$ simulation does a good job in capturing most of the detection event correlations that are present in the experiment. There are, however, some spatial/temporal correlations that are significantly stronger in the experiment than in the simulation, indicated by the ellipses in the $p_(i j)$ matrix difference. We attribute these features to stronger-than-usual leakage in two data qubits: 2\_4 and 2\_6. Leakage accumulation in these data qubits leads to detection events that are correlated locally in space (with detection events at measure qubits that are neighbors to the leaky data qubits 2\_4 and 2\_6) and correlated nonlocally in time (with a correlation time of roughly $T_1  2 approx 10 #h(0.17em) mu$ s). These correlations produce the reddish regions indicated by the magenta and blue ellipses for leakage accumulation in the data qubits 2\_4 and 2\_6, respectively. We stress that Pauli $+$ simulation can in principle capture these missing correlations by properly adjusting the simulation parameters related to leakage generation in the data qubits 2\_4 and 2\_6 (e.g., by increasing the heating rates $Gamma_(1 arrow.r 2)$ or by increasing the leakage generation probabilities $p_2^("CZ")$ of the CZs that act on these leaky data qubits). Besides the broad reddish regions indicated by the ellipses in @fig:pij_matrix\(b), we also notice some faint narrow reddish features in the $p_(i j)$ matrix difference. These features indicate short temporal correlations of detection events separated in time by 0 or 1 round, and they can be understood as a discrepancy between the actual component error probabilities during the surface code experiment and the component error probabilities assumed in the simulation. To quantify the discrepancy between the component error probabilities, we need to compare the $p_(i j)$ probabilities for the edges of the surface code error graph, which we discuss below.

#figure(
  scale(90%, reflow: true, cetz.canvas({
    import cetz.draw: *

    let red = rgb("#cc0000")
    let blue = rgb("#0000ee")
    let blk = rgb("#000000")
    let rad = 5.5pt

    // a detection event
    let event(p) = circle(p, radius: rad, fill: red, stroke: none)
    // a label
    let lbl(p, body, size: 9.5pt, color: blk) = content(p, text(size: size, fill: color, body))
    // an edge between two detection events
    let edge(a, b) = {
      line(a, b, stroke: (thickness: 1.2pt, paint: red))
      event(a)
      event(b)
    }

    // timelike edges: same measure qubit, consecutive rounds
    let tpa = (x: 6.2, y: 6.4)
    let tpb = (x: 8.4, y: 6.4)
    edge(tpa, tpb)
    lbl((7.3, 7.7), [T-edges], color: blue, size: 11pt)
    lbl((tpa.x, tpa.y + .55), [t])
    lbl((tpb.x, tpb.y + .55), [t+1])
    lbl((tpa.x, tpa.y - .6), [mq])
    lbl((tpb.x, tpb.y - .6), [mq])

    // spacelike edges: same round, neighbouring measure qubits
    let spa = (x: 3.4, y: 3.6)
    let spb = (x: 3.4, y: 1.1)
    edge(spa, spb)
    lbl((2.0, 2.35), [S-edges], color: blue, size: 11pt)
    lbl((spa.x, spa.y + .6), [mq2])
    lbl((spa.x + .62, spa.y - .3), [t])
    lbl((spb.x + .62, spb.y + .3), [t])
    lbl((spb.x, spb.y - .6), [mq1])

    // spacelike-timelike edges: neighbouring measure qubits, consecutive rounds
    let stpa = (x: 7.6, y: 2.4)
    let stpb = (x: 9.9, y: 3.5)
    edge(stpa, stpb)
    lbl((stpa.x - .5, stpa.y + .55), [t])
    lbl((stpa.x, stpa.y - .6), [mq1])
    lbl((stpb.x, stpb.y + .6), [mq2])
    lbl((stpb.x + .62, stpb.y - .45), [t+1])
    lbl((10.9, 2.4), [ST-edges], color: blue, size: 11pt)
  })),
  caption: [
    Main pairwise detection event correlations in the surface code. The red dots indicate detection events. The considered pairwise correlations (edges) are timelike (T) edges, spacelike (S) and spacetimelike (ST) edges. These correlations are mainly from readout/reset errors, idle data qubit errors and CZ errors, respectively.
  ]
) <fig:edges>

== $p_(i j)$ probability of main error edges in the surface code <p_ij-probability-of-main-error-edges-in-the-surface-code>
In this section we examine the probabilities of the main pairwise correlations (error edges) in the $d = 5$ surface code. These error edges are depicted in @fig:edges. Timelike edges (T-edges) indicate correlations of detection events occurring at the same measure qubit and separated in time by 1 round. Physical errors that give rise to T-edges mainly include readout/reset errors. Spacelike edges (S-edges) indicate correlations of detection events occurring at the same round and at two measure qubits of the same type (X or Z). Physical errors that give rise to spacelike edges mainly include bit-flip errors (from $T_1$ qubit decay) and phase-flip errors (from qubit dephasing) at the data qubits during measurement and reset time (idle time). Finally, spacetimelike edges indicate correlations of detection events separated in time by 1 round and occurring at different measure qubits. Spacetimelike edges that come from Pauli CZ errors are denoted as ST edges, while other spacetimelike edges that are not expected from CZ errors are denoted as ST' edges. The latter can be due to leakage or crosstalk.

=== Timelike edges <timelike-edges>
The probability of T-edges are obtained from the $p_(i j)$ correlation matrix with $i = ( t s )$ and $j = ( t + 1 s )$, where the space coordinate $s$ refers to one of the measure qubits. It is convenient to average over time $t$ and present the time-averaged T-edge probabilities as shown at the top panel heatmap of @fig:t_edges. This way of presenting the $p_(i j)$ data for the T-edges is particularly useful to spot the measure qubits with good or bad readout/reset errors. We point out that, although readout/reset errors are the main contributors to the T-edges in our experiment, other physical errors (e.g., leakage and CZ errors) can also contribute to the T-edge probabilities.

The mean T-edge probability (averaging over all qubits and all rounds) is

#eqnn($
  p_(i j)^("T-edge," "mean") = 3.85 times 10^(-2) \
  & "Pauli+ sim" = 3.7 times 10^(-2), \
  &"Pauli sim" = 3.0 times 10^(-2)
$)

where we have also included the averaged T-edge probabilities from Pauli $+$ and Pauli simulations.

// [figvision-cn] imgs/T_edges_heatmap_diff.png
// 该图像展示了一张二维热图，标题为“T edges [Expt - Sim]”，
// 位于图表顶部中央。该图描绘了表面码实验中测量量子比特的
// 时序边（T-edge）概率的实验值与模拟值之间的差异。 坐标
// 轴系统： 纵轴标记为“row”（行），刻度从底部的1到顶部的9，
// 数字垂直排列。横轴标记为“column”（列），刻度从左至右为
// 1到9。整个绘图区域呈现为一个由离散方格组成的网格布局，
// 但并非所有行列交叉点都有数据填充，形成一种特定的几何图
// 案。 右侧包含一个垂直的颜色条（Colorbar），用于表示数
// 值大小。颜色条的范围从-0.012到0.012。颜色映射规则如下：
// 深蓝色代表负值的下限（约-0.012），随着数值增加逐渐过渡
// 为浅蓝、白色（代表0.000）、浅红，最后变为深红色代表正
// 值的上限（约0.012）。 图中的每个非空白方格代表一个测量
// 量子比特，其位置由(row, column)坐标确定。每个方格内部
// 包含两行文字信息：上方是具体的数值（保留三位小数），下
// 方是字母标识符“X”或“Z”。根据上下文，这些方格对应于测量
// X或Z稳定子的测量量子比特。 以下是各数据点的详细分布及
// 数值描述（按从上到下、从左到右的视觉顺序）： 第1行：
// 在(4, 1)位置有一个深红色方格，数值为.009，标识符为X。
// 第2行： 在(5, 2)位置有一个深红色方格，数值为.028，标识
// 符为Z；在(7, 2)位置有一个深红色方格，数值为.009，标识
// 符为Z。 第3行： 在(2, 3)位置有一个深蓝色方格，数值为
// -0.013，标识符为X；在(4, 3)位置有一个深红色方格，数值
// 为.012，标识符为X；在(6, 3)位置有一个浅粉色方格，数值
// 为.002，标识符为X。 第4行： 在(3, 4)位置有一个中蓝色方
// 格，数值为-0.005，标识符为Z；在(5, 4)位置有一个鲜红色
// 方格，数值为.006，标识符为Z；在(7, 4)位置有一个粉红色
// 方格，数值为.003，标识符为Z；在(9, 4)位置有一个浅粉色
// 方格，数值为.002，标识符为Z。 第5行： 在(2, 5)位置有一
// 个粉红色方格，数值为.003，标识符为X；在(4, 5)位置有一
// 个浅蓝色方格，数值为-0.001，标识符为X；在(6, 5)位置有
// 一个浅蓝色方格，数值为-0.002，标识符为X；在(8, 5)位置
// 有一个粉红色方格，数值为.003，标识符为X。 第6行： 在(1
// , 6)位置有一个浅粉色方格，数值为.002，标识符为Z；在(3,
// 6)位置有一个中蓝色方格，数值为-0.006，标识符为Z；在(5,
// 6)位置有一个粉红色方格，数值为.003，标识符为Z；在(7, 6
// )位置有一个中蓝色方格，数值为-0.003，标识符为Z。 第7行：
// 在(4, 7)位置有一个极浅的灰色/白色方格，数值为-0.000，
// 标识符为X；在(6, 7)位置有一个中蓝色方格，数值为-0.004，
// 标识符为X；在(8, 7)位置有一个浅蓝色方格，数值为-0.001，
// 标识符为X。 第8行： 在(3, 8)位置有一个中蓝色方格，数值
// 为-0.004，标识符为Z；在(5, 8)位置有一个极浅的灰色/白色
// 方格，数值为.000，标识符为Z。 第9行： 在(6, 9)位置有一
// 个浅蓝色方格，数值为-0.001，标识符为X。 图中未提及的坐
// 标位置为空白，没有显示任何方格或数据。整体来看，数值在
// 正负之间波动，大部分集中在-0.013到0.028的范围内，反映
// 了实验结果与理论模拟之间的偏差分布情况。
// [figvision-cn] imgs/T_edges_heatmap_diff.png
// 该图像展示了一张二维热图，标题为“T edges [Expt - Sim]”，
// 位于图表顶部中央。该图描绘了表面码实验中测量量子比特的
// 时序边（T-edge）概率的实验值与模拟值之间的差异。 坐标
// 轴系统： 纵轴标记为“row”（行），刻度从底部的1到顶部的9，
// 数字垂直排列。横轴标记为“column”（列），刻度从左至右为
// 1到9。整个绘图区域呈现为一个由离散方格组成的网格布局，
// 但并非所有行列交叉点都有数据填充，形成一种特定的几何图
// 案。 右侧包含一个垂直的颜色条（Colorbar），用于表示数
// 值大小。颜色条的范围从-0.012到0.012。颜色映射规则如下：
// 深蓝色代表负值的下限（约-0.012），随着数值增加逐渐过渡
// 为浅蓝、白色（代表0.000）、浅红，最后变为深红色代表正
// 值的上限（约0.012）。 图中的每个非空白方格代表一个测量
// 量子比特，其位置由(row, column)坐标确定。每个方格内部
// 包含两行文字信息：上方是具体的数值（保留三位小数），下
// 方是字母标识符“X”或“Z”。根据上下文，这些方格对应于测量
// X或Z稳定子的测量量子比特。 以下是各数据点的详细分布及
// 数值描述（按从上到下、从左到右的视觉顺序）： 第1行：
// 在(4, 1)位置有一个深红色方格，数值为.009，标识符为X。
// 第2行： 在(5, 2)位置有一个深红色方格，数值为.028，标识
// 符为Z；在(7, 2)位置有一个深红色方格，数值为.009，标识
// 符为Z。 第3行： 在(2, 3)位置有一个深蓝色方格，数值为
// -0.013，标识符为X；在(4, 3)位置有一个深红色方格，数值
// 为.012，标识符为X；在(6, 3)位置有一个浅粉色方格，数值
// 为.002，标识符为X。 第4行： 在(3, 4)位置有一个中蓝色方
// 格，数值为-0.005，标识符为Z；在(5, 4)位置有一个鲜红色
// 方格，数值为.006，标识符为Z；在(7, 4)位置有一个粉红色
// 方格，数值为.003，标识符为Z；在(9, 4)位置有一个浅粉色
// 方格，数值为.002，标识符为Z。 第5行： 在(2, 5)位置有一
// 个粉红色方格，数值为.003，标识符为X；在(4, 5)位置有一
// 个浅蓝色方格，数值为-0.001，标识符为X；在(6, 5)位置有
// 一个浅蓝色方格，数值为-0.002，标识符为X；在(8, 5)位置
// 有一个粉红色方格，数值为.003，标识符为X。 第6行： 在(1
// , 6)位置有一个浅粉色方格，数值为.002，标识符为Z；在(3,
// 6)位置有一个中蓝色方格，数值为-0.006，标识符为Z；在(5,
// 6)位置有一个粉红色方格，数值为.003，标识符为Z；在(7, 6
// )位置有一个中蓝色方格，数值为-0.003，标识符为Z。 第7行：
// 在(4, 7)位置有一个极浅的灰色/白色方格，数值为-0.000，
// 标识符为X；在(6, 7)位置有一个中蓝色方格，数值为-0.004，
// 标识符为X；在(8, 7)位置有一个浅蓝色方格，数值为-0.001，
// 标识符为X。 第8行： 在(3, 8)位置有一个中蓝色方格，数值
// 为-0.004，标识符为Z；在(5, 8)位置有一个极浅的灰色/白色
// 方格，数值为.000，标识符为Z。 第9行： 在(6, 9)位置有一
// 个浅蓝色方格，数值为-0.001，标识符为X。 图中未提及的坐
// 标位置为空白，没有显示任何方格或数据。整体来看，数值在
// 正负之间波动，大部分集中在-0.013到0.028的范围内，反映
// 了实验结果与理论模拟之间的偏差分布情况。
#figure(placement: auto, [#box(image("imgs/T_edges_heatmap_expt.png", width: 90%)) #box(image("imgs/T_edges_heatmap_diff.png", width: 90%))

  ],
  caption: [
    Top panel: timelike edge probabilities. Each number in the heatmaps is the median of the T-edge probabilities of a measure qubit. Measure qubits that measure X or Z stabilisers are indicated by X or Z. Top panel shows the time-averaged T-edge probabilities for the 25 rounds $d = 5$ surface code experiment with data qubits initialized in the Z-basis. Bottom panel shows the difference of T-edge probabilities between experiment and Pauli $+$ simulation.
  ]
) <fig:t_edges>

The lower panel heatmap of @fig:t_edges shows the difference of the time-averaged T-edge probabilities between experiment and Pauli $+$ simulation. We see that the difference is relatively small, indicating a good agreement between experiment and simulation. The biggest discrepancy between experiment and simulation is for T-edges of the measure qubits 1\_4, 3\_4, 2\_5, 2\_9, which are spatially close to the data qubits 2\_4 and 2\_6 that exhibit more leakage in the experiment than in the Pauli $+$ simulation. Thus the reason for this discrepancy is most likely leakage accumulation in these data qubits.

=== Spacelike edges <sec:space_edges>
The heatmap at the top panel of @fig:sx_edges shows the time-averaged probabilities of SX edges (spacelike edges between two X measure qubits) for the $d = 5$ surface code experiment in the Z-basis. To explain the information displayed in this heatmap, let us consider the middle data qubit 5\_5. A phase-flip error in this data qubit during idle time produces two detection events at the neighboring X measure qubits 5\_4 and 5\_6 (see horizontal red edge in @fig:sx_edges) and at some round $t$. The number 0.043 written in the middle tile (5,5) is the average (specifically, the median) of the $p_(i j)$ probabilities of all SX edges between these two X measure qubits. Idle Y errors in the data qubit 5\_5 also contributes to the displayed probability 0.043; for this reason, we write 'T2' below 0.043 to remind us that this SX edge probability comes from phase-flip or Y idle data qubit errors (in reality, other errors such as leakage and CZ errors can also contribute to the SX edge probabilities). Let us consider another example: an idle bit-flip error (due to T1 qubit decay) in the data qubit 6\_4 produces a SX edge between the X measure qubits 5\_4 and 7\_4 (vertical red edge in @fig:sx_edges). One might expect that all SX edges are produced by phase-flip idle data qubit errors. This is not the case for our surface code experiments since we implement the ZXXZ variant of the surface code circuit (see main text). \
Idle errors in the boundary data qubits of the surface code grid sometimes produce just one detection event (i.e., a boundary edge). For instance, this is the case of an idle phase-flip error in the data qubit 1\_5 that produces only one detection event at the X measure qubit 1\_4 and at some time $t$. Finally, we also have the situation where idle errors in two different boundary data qubits produce the same detection event or boundary edge. For instance, a bit-flip error in data qubit 6\_2 and a phase-flip error in data qubit 5\_1 both produce the same boundary edge at the X measure qubit 5\_2. In this ambiguous situation, we split equally the $p_(i j)$ probability of the boundary edge among these data qubits \[in this example 0.03 in the tiles (5,1) and (6,2)\] and write asterisks at the corresponding data qubit tiles.

// [figvision-cn] imgs/sx_edges_heatmap_diff.png
// 这是一张标题为“SX edges [Expt - Sim]”的热图，展示了实
// 验测量值与模拟值之间的差异。 子图类型：热图（矩阵可视
// 化）。 坐标轴：横轴标记为“column”，范围从1到9；纵轴标
// 记为“row”，范围从1到9。两个坐标轴均代表量子比特网格中
// 的位置索引。 颜色标尺：位于图像右侧的垂直色条，数值范
// 围从-0.012到0.012。颜色映射采用红蓝发散色谱：深红色表
// 示正值（约+0.012），白色表示零值（0.000），深蓝色表示
// 负值（约-0.012）。 图中包含一个非矩形的网格布局，由多
// 个填充颜色的方块组成。每个方块内标注有具体的数值、标签
// （T1或T2）以及可能的符号（X或*）。具体分布如下： 第1行：
// 列4：浅粉色背景，标注红色字母“X”。 列5：深蓝色背景，标
// 注数值“-0.008”和标签“T2”。 第2行： 列3：深红色背景，标
// 注数值“.013”和标签“T1”。 列5：浅粉色背景，标注数值“
// .001*”和标签“T1”。星号通常表示统计显著性。 第3行： 列2：
// 浅粉色背景，标注红色字母“X”。 列3：深蓝色背景，标注数
// 值“-0.009”和标签“T2”。 列4：浅粉色背景，标注红色字母“X
// ”。 列5：中蓝色背景，标注数值“-0.003”和标签“T2”。 列6：
// 浅粉色背景，标注红色字母“X”。 列7：浅粉色背景，标注数
// 值“.001*”和标签“T2”。 第4行： 列2：极浅色背景，标注数
// 值“.000”和标签“T1”。 列4：浅粉色背景，标注数值“.002”和
// 标签“T1”。 列6：深红色背景，标注数值“.012”和标签“T1”。
// 列8：浅粉色背景，标注数值“.002*”和标签“T1”。 第5行：
// 列1：中蓝色背景，标注数值“-0.002*”和标签“T2”。 列2：浅
// 粉色背景，标注红色字母“X”。 列3：浅蓝色背景，标注数值“
// -0.001”和标签“T2”。 列4：浅粉色背景，标注红色字母“X”。
// 列5：中红色背景，标注数值“.005”和标签“T2”。 列6：浅粉
// 色背景，标注红色字母“X”。 列7：极浅色背景，标注数值“
// .000”和标签“T2”。 列8：浅粉色背景，标注红色字母“X”。
// 列9：浅粉色背景，标注数值“.002*”和标签“T2”。 第6行：
// 列2：浅蓝色背景，标注数值“-0.002*”和标签“T1”。 列4：中
// 红色背景，标注数值“.009”和标签“T1”。 列6：中红色背景，
// 标注数值“.007”和标签“T1”。 列8：浅粉色背景，标注数值“
// .001”和标签“T1”。 第7行： 列3：中蓝色背景，标注数值“
// -0.002*”和标签“T2”。 列4：浅粉色背景，标注红色字母“X”。
// 列5：深蓝色背景，标注数值“-0.005”和标签“T2”。 列6：浅
// 粉色背景，标注红色字母“X”。 列7：浅粉色背景，标注数值“
// .002”和标签“T2”。 列8：浅粉色背景，标注红色字母“X”。
// 第8行： 列4：浅蓝色背景，标注数值“-0.002*”和标签“T1”。
// 列6：中红色背景，标注数值“.005”和标签“T1”。 第9行： 列
// 5：中红色背景，标注数值“.006”和标签“T2”。 列6：浅粉色
// 背景，标注红色字母“X”。 图中红色字母“X”出现在特定位置，
// 根据图注说明，这些位置对应于测量X稳定子的测量量子比特
// （measure qubits）。未出现“X”的位置则对应其他（Z）测量
// 量子比特。带星号的数值表示具有统计显著性的差异。整体来
// 看，该图通过颜色深浅直观地呈现了实验与模拟在SX边概率上
// 的偏差分布，正偏差（红色区域）主要集中在T1相关的边上，
// 而负偏差（蓝色区域）多出现在T2相关的边上。
// [figvision-cn] imgs/sx_edges_heatmap_diff.png
// 这是一张标题为“SX edges [Expt - Sim]”的热图，展示了实
// 验测量值与模拟值之间的差异。 子图类型：热图（矩阵可视
// 化）。 坐标轴：横轴标记为“column”，范围从1到9；纵轴标
// 记为“row”，范围从1到9。两个坐标轴均代表量子比特网格中
// 的位置索引。 颜色标尺：位于图像右侧的垂直色条，数值范
// 围从-0.012到0.012。颜色映射采用红蓝发散色谱：深红色表
// 示正值（约+0.012），白色表示零值（0.000），深蓝色表示
// 负值（约-0.012）。 图中包含一个非矩形的网格布局，由多
// 个填充颜色的方块组成。每个方块内标注有具体的数值、标签
// （T1或T2）以及可能的符号（X或*）。具体分布如下： 第1行：
// 列4：浅粉色背景，标注红色字母“X”。 列5：深蓝色背景，标
// 注数值“-0.008”和标签“T2”。 第2行： 列3：深红色背景，标
// 注数值“.013”和标签“T1”。 列5：浅粉色背景，标注数值“
// .001*”和标签“T1”。星号通常表示统计显著性。 第3行： 列2：
// 浅粉色背景，标注红色字母“X”。 列3：深蓝色背景，标注数
// 值“-0.009”和标签“T2”。 列4：浅粉色背景，标注红色字母“X
// ”。 列5：中蓝色背景，标注数值“-0.003”和标签“T2”。 列6：
// 浅粉色背景，标注红色字母“X”。 列7：浅粉色背景，标注数
// 值“.001*”和标签“T2”。 第4行： 列2：极浅色背景，标注数
// 值“.000”和标签“T1”。 列4：浅粉色背景，标注数值“.002”和
// 标签“T1”。 列6：深红色背景，标注数值“.012”和标签“T1”。
// 列8：浅粉色背景，标注数值“.002*”和标签“T1”。 第5行：
// 列1：中蓝色背景，标注数值“-0.002*”和标签“T2”。 列2：浅
// 粉色背景，标注红色字母“X”。 列3：浅蓝色背景，标注数值“
// -0.001”和标签“T2”。 列4：浅粉色背景，标注红色字母“X”。
// 列5：中红色背景，标注数值“.005”和标签“T2”。 列6：浅粉
// 色背景，标注红色字母“X”。 列7：极浅色背景，标注数值“
// .000”和标签“T2”。 列8：浅粉色背景，标注红色字母“X”。
// 列9：浅粉色背景，标注数值“.002*”和标签“T2”。 第6行：
// 列2：浅蓝色背景，标注数值“-0.002*”和标签“T1”。 列4：中
// 红色背景，标注数值“.009”和标签“T1”。 列6：中红色背景，
// 标注数值“.007”和标签“T1”。 列8：浅粉色背景，标注数值“
// .001”和标签“T1”。 第7行： 列3：中蓝色背景，标注数值“
// -0.002*”和标签“T2”。 列4：浅粉色背景，标注红色字母“X”。
// 列5：深蓝色背景，标注数值“-0.005”和标签“T2”。 列6：浅
// 粉色背景，标注红色字母“X”。 列7：浅粉色背景，标注数值“
// .002”和标签“T2”。 列8：浅粉色背景，标注红色字母“X”。
// 第8行： 列4：浅蓝色背景，标注数值“-0.002*”和标签“T1”。
// 列6：中红色背景，标注数值“.005”和标签“T1”。 第9行： 列
// 5：中红色背景，标注数值“.006”和标签“T2”。 列6：浅粉色
// 背景，标注红色字母“X”。 图中红色字母“X”出现在特定位置，
// 根据图注说明，这些位置对应于测量X稳定子的测量量子比特
// （measure qubits）。未出现“X”的位置则对应其他（Z）测量
// 量子比特。带星号的数值表示具有统计显著性的差异。整体来
// 看，该图通过颜色深浅直观地呈现了实验与模拟在SX边概率上
// 的偏差分布，正偏差（红色区域）主要集中在T1相关的边上，
// 而负偏差（蓝色区域）多出现在T2相关的边上。
#figure(placement: auto, [#box(image("imgs/sx_edges_heatmap_expt.png", width: 79%)) #box(image("imgs/sx_edges_heatmap_diff.png", width: 79%))

  ],
  caption: [
    Top panel: time-averaged $p_(i j)$ probabilities of SX edges. Pink tiles with an X indicate the measure qubits that measure X stabilisers and the empty pink tiles indicate the other (Z) measure qubits. The red horizontal edge indicates SX edges between the X measure qubits 5\_4 and 5\_6. The probabilities of these SX edges are obtained from the $p_(i j)$ matrix with $i = ( s t )$ and $j = ( s' t )$, and $s = "q5_4"$ and $s' = "q5_6"$. After averaging over time $t$, we write the result in the middle data qubit tile (5,5) since phase-flip errors in this data qubit would produce such SX edges. Asterisks indicate ambiguous data qubits (e.g., the pair 5\_1 and 6\_2) in the sense that idle errors at those data qubits produce the same boundary edge (see @sec:space_edges). Lower panel shows the difference of the time-averaged SX edge probabilities between experiment and Pauli $+$ simulation. Labels T1 and T2 at the tiles indicate the type of idle data qubit error (bit-flip and phase-flip errors, respectively) that gives rise to the SX edges (see @sec:space_edges).
  ]
) <fig:sx_edges>

// [figvision-cn] imgs/sz_edges_heatmap_diff.png
// 该图像为一张热图（Heatmap），标题为“SZ edges [Expt -
// Sim]”，展示了实验测量值与泡利模拟值之间在时间平均的SZ
// 边概率上的差异。 图表主体是一个由彩色方格组成的网格，
// 呈阶梯状分布，并非完整的矩形矩阵。左侧垂直坐标轴标记为
// “row”（行），刻度从1到9；底部水平坐标轴标记为“column”
// （列），刻度同样从1到9。 图表右侧设有一个垂直的颜色条
// （Colorbar）作为图例，用于量化颜色对应的数值。颜色条范
// 围从底部的-0.012到顶部的0.012。深蓝色代表负值（最低
// -0.012），白色代表零值（0.000），深红色代表正值（最高
// 0.012）。中间过渡色包括浅蓝、浅红等。 网格内的每个填充
// 方格代表特定行列位置的数据点，方格内包含具体的数值和标
// 签。部分数值右上角带有星号（*）。标签分为三类：“Z”、“
// T1”和“T2”。 具体数据分布如下： 第1行：第5列显示数值
// -0.002，标签T1，背景为浅蓝色。 第2行：第4列显示数值
// -0.002，标签T2，背景为浅蓝色；第5列显示标签Z，无具体数
// 值，背景为浅粉色；第6列显示数值.003，标签T2，背景为浅
// 红色；第7列显示标签Z，无具体数值，背景为浅粉色。 第3行：
// 第3列显示数值-0.001，标签T1，带星号，背景为浅蓝色；第5
// 列显示数值.009，标签T1，背景为深红色；第7列显示数值
// .002，标签T1，背景为中等红色。 第4行：第2列显示数值
// -0.001，标签T2，带星号，背景为浅蓝色；第3列显示标签Z，
// 背景为浅粉色；第4列显示数值.002，标签T2，背景为浅红色；
// 第5列显示标签Z，背景为浅粉色；第6列显示数值.000，标签
// T2，背景为白色；第7列显示标签Z，背景为浅粉色；第8列显
// 示数值.003，标签T2，背景为浅红色；第9列显示标签Z，背景
// 为浅粉色。 第5行：第1列显示数值.002，标签T1，背景为浅
// 红色；第3列显示数值-0.001，标签T1，背景为浅蓝色；第5列
// 显示数值-0.003，标签T1，背景为中等蓝色；第7列显示数值
// .004，标签T1，背景为中等红色；第9列显示数值.005，标签
// T1，背景为深红色。 第6行：第1列显示标签Z，背景为浅粉色；
// 第2列显示数值.007，标签T2，背景为深红色；第3列显示标签
// Z，背景为浅粉色；第4列显示数值.009，标签T2，背景为深红
// 色；第5列显示标签Z，背景为浅粉色；第6列显示数值-0.002，
// 标签T2，背景为浅蓝色；第7列显示标签Z，背景为浅粉色；第
// 8列显示数值-0.001，标签T2，带星号，背景为浅蓝色。 第7
// 行：第3列显示数值.001，标签T1，背景为浅粉色；第5列显示
// 数值.000，标签T1，背景为白色；第7列显示数值-0.001，标
// 签T1，带星号，背景为浅蓝色。 第8行：第3列显示标签Z，背
// 景为浅粉色；第4列显示数值-0.002，标签T2，背景为浅蓝色；
// 第5列显示标签Z，背景为浅粉色；第6列显示数值.006，标签
// T2，带星号，背景为深红色。 第9行：第5列显示数值.006，
// 标签T1，带星号，背景为深红色。 整体来看，图中大部分非
// 零数值的绝对值较小，集中在±0.01以内。深红色区域（如第3
// 行第5列的.009 T1，第6行第2列和第4列的.007/.009 T2）表
// 示实验值显著高于模拟值，而深蓝色区域较少且数值绝对值相
// 对较小，表示实验值略低于模拟值。带有星号的点可能表示统
// 计上显著的差异。
// [figvision-cn] imgs/sz_edges_heatmap_diff.png
// 该图像为一张热图（Heatmap），标题为“SZ edges [Expt -
// Sim]”，展示了实验测量值与泡利模拟值之间在时间平均的SZ
// 边概率上的差异。 图表主体是一个由彩色方格组成的网格，
// 呈阶梯状分布，并非完整的矩形矩阵。左侧垂直坐标轴标记为
// “row”（行），刻度从1到9；底部水平坐标轴标记为“column”
// （列），刻度同样从1到9。 图表右侧设有一个垂直的颜色条
// （Colorbar）作为图例，用于量化颜色对应的数值。颜色条范
// 围从底部的-0.012到顶部的0.012。深蓝色代表负值（最低
// -0.012），白色代表零值（0.000），深红色代表正值（最高
// 0.012）。中间过渡色包括浅蓝、浅红等。 网格内的每个填充
// 方格代表特定行列位置的数据点，方格内包含具体的数值和标
// 签。部分数值右上角带有星号（*）。标签分为三类：“Z”、“
// T1”和“T2”。 具体数据分布如下： 第1行：第5列显示数值
// -0.002，标签T1，背景为浅蓝色。 第2行：第4列显示数值
// -0.002，标签T2，背景为浅蓝色；第5列显示标签Z，无具体数
// 值，背景为浅粉色；第6列显示数值.003，标签T2，背景为浅
// 红色；第7列显示标签Z，无具体数值，背景为浅粉色。 第3行：
// 第3列显示数值-0.001，标签T1，带星号，背景为浅蓝色；第5
// 列显示数值.009，标签T1，背景为深红色；第7列显示数值
// .002，标签T1，背景为中等红色。 第4行：第2列显示数值
// -0.001，标签T2，带星号，背景为浅蓝色；第3列显示标签Z，
// 背景为浅粉色；第4列显示数值.002，标签T2，背景为浅红色；
// 第5列显示标签Z，背景为浅粉色；第6列显示数值.000，标签
// T2，背景为白色；第7列显示标签Z，背景为浅粉色；第8列显
// 示数值.003，标签T2，背景为浅红色；第9列显示标签Z，背景
// 为浅粉色。 第5行：第1列显示数值.002，标签T1，背景为浅
// 红色；第3列显示数值-0.001，标签T1，背景为浅蓝色；第5列
// 显示数值-0.003，标签T1，背景为中等蓝色；第7列显示数值
// .004，标签T1，背景为中等红色；第9列显示数值.005，标签
// T1，背景为深红色。 第6行：第1列显示标签Z，背景为浅粉色；
// 第2列显示数值.007，标签T2，背景为深红色；第3列显示标签
// Z，背景为浅粉色；第4列显示数值.009，标签T2，背景为深红
// 色；第5列显示标签Z，背景为浅粉色；第6列显示数值-0.002，
// 标签T2，背景为浅蓝色；第7列显示标签Z，背景为浅粉色；第
// 8列显示数值-0.001，标签T2，带星号，背景为浅蓝色。 第7
// 行：第3列显示数值.001，标签T1，背景为浅粉色；第5列显示
// 数值.000，标签T1，背景为白色；第7列显示数值-0.001，标
// 签T1，带星号，背景为浅蓝色。 第8行：第3列显示标签Z，背
// 景为浅粉色；第4列显示数值-0.002，标签T2，背景为浅蓝色；
// 第5列显示标签Z，背景为浅粉色；第6列显示数值.006，标签
// T2，带星号，背景为深红色。 第9行：第5列显示数值.006，
// 标签T1，带星号，背景为深红色。 整体来看，图中大部分非
// 零数值的绝对值较小，集中在±0.01以内。深红色区域（如第3
// 行第5列的.009 T1，第6行第2列和第4列的.007/.009 T2）表
// 示实验值显著高于模拟值，而深蓝色区域较少且数值绝对值相
// 对较小，表示实验值略低于模拟值。带有星号的点可能表示统
// 计上显著的差异。
#figure(placement: auto, [#box(image("imgs/sz_edges_heatmap_expt.png", width: 90%)) #box(image("imgs/sz_edges_heatmap_diff.png", width: 90%))

  ],
  caption: [
    Top panel: time-averaged $p_(i j)$ probabilities of SZ edges. Description of the information displayed at the top panel is similar to that of @fig:sx_edges. Lower panel shows the difference of the time-averaged SZ edge probabilities between experiment and Pauli $+$ simulation.
  ]
) <fig:sz_edges>

@fig:sz_edges is complementary to @fig:sx_edges, and it displays the time-averaged SZ edge probabilities. For instance, for the middle data qubit 5\_5, we read a SX edge probability of 0.043 from @fig:sx_edges, and a SZ edge probability of 0.031 from @fig:sz_edges. The bottom panels of @fig:sx_edges and @fig:sz_edges show the difference between the experimental and simulated values, which is relatively small.

The mean spacelike edge probabilities are

#eqnn($
  p_(i j)^("SX-edge, mean") = 3.4 times 10^(-2) [&"Pauli"^+ "sim" = 3.3 times 10^(-2), \
  &"Pauli sim" = 3.1 times 10^(-2) ],
$)

#eqnn($
  p_(i j)^("SZ-edge, mean") = 3.2 times 10^(-2) [&"Pauli"^+ "sim" = 3.0 times 10^(-2), \
  &"Pauli sim" = 2.9 times 10^(-2) ],
$)

where we have also included the results from Pauli $+$ and Pauli simulations.

// [figvision-cn] imgs/st_edges_heatmap_diff.png
// 该图像是一张标题为“ST edges [Expt - Sim]”的热力图（
// Heatmap），展示了实验中测得的时间平均ST边概率与模拟结
// 果之间的差值。 坐标轴： 横轴（x-axis）标记为 t，表示时
// 间步长或qubit标签。从左到右依次标注了24个qubit标签，格
// 式为“q[编号]_[操作](Z/X)”，具体为：q2_5(Z), q4_3(Z),
// q6_1(Z), q2_7(Z), q4_5(Z), q6_3(Z), q4_7(Z), q6_5(Z),
// q8_3(Z), q4_9(Z), q6_7(Z), q8_5(Z), q1_4(X), q3_2(X),
// q3_4(X), q5_2(X), q3_6(X), q5_4(X), q5_6(X), q7_4(X),
// q5_8(X), q7_6(X), q7_8(X), q9_6(X)。 纵轴（y-axis）标
// 记为 t+1，表示下一个时间步的qubit标签。从下到上依次标
// 注了24个qubit标签，格式同样为“q[编号]_[操作](Z/X)”，具
// 体为：q2_5(Z), q4_3(Z), q6_1(Z), q2_7(Z), q4_5(Z),
// q6_3(Z), q4_7(Z), q6_5(Z), q8_3(Z), q4_9(Z), q6_7(Z),
// q8_5(Z), q1_4(X), q3_2(X), q3_4(X), q5_2(X), q3_6(X),
// q5_4(X), q5_6(X), q7_4(X), q5_8(X), q7_6(X), q7_8(X),
// q9_6(X)。 色标： 位于图右侧，是一个垂直的颜色条，范围
// 从-0.008到0.008。 颜色映射：深蓝色代表负值（最小值
// -0.008），白色代表零值（0.000），深红色代表正值（最大
// 值0.008）。中间过渡色包括浅蓝、浅红等。 数据点： 图中
// 的每个方格代表一个(t, t+1)位置上的差值。大部分方格为空
// 白（白色），表示差值为零或接近零。 非零差值的方格用颜
// 色填充，并在其中标注了具体的数值（保留三位小数，省略前
// 导零和小数点前的零，例如“005”表示0.005，“-003”表示
// -0.003）。 具体数值分布如下： 在横轴t=q2_5(Z)处，纵轴t
// +1=q4_3(Z)有一个值为0.003的浅红色方块；纵轴t+1=q3_4(X)
// 有一个值为-0.015的深红色方块（注：此处根据颜色应为深蓝
// 色，但标注为负值，需确认颜色映射是否正确，根据上下文，
// 深红色应为正值，深蓝色为负值，因此-0.015应对应深蓝色，
// 但图中显示为深红色，可能存在矛盾，按标注文字为准）。
// 在横轴t=q4_3(Z)处，纵轴t+1=q6_1(Z)有一个值为0.003的浅
// 红色方块；纵轴t+1=q5_2(X)有一个值为0.005的浅红色方块。
// 在横轴t=q6_1(Z)处，纵轴t+1=q2_7(Z)有一个值为0.005的浅
// 红色方块。 在横轴t=q2_7(Z)处，纵轴t+1=q4_5(Z)有一个值
// 为0.005的浅红色方块。 在横轴t=q4_5(Z)处，纵轴t+1=q6_3(
// Z)有一个值为0.007的深红色方块。 在横轴t=q6_3(Z)处，纵
// 轴t+1=q4_7(Z)有一个值为0.003的浅红色方块。 在横轴t=
// q4_7(Z)处，纵轴t+1=q6_5(Z)有一个值为0.003的浅红色方块。
// 在横轴t=q6_5(Z)处，纵轴t+1=q8_3(Z)有一个值为-0.003的浅
// 蓝色方块。 在横轴t=q8_3(Z)处，纵轴t+1=q4_9(Z)有一个值
// 为0.003的浅红色方块。 在横轴t=q4_9(Z)处，纵轴t+1=q6_7(
// Z)有一个值为0.003的浅红色方块。 在横轴t=q6_7(Z)处，纵
// 轴t+1=q8_5(Z)有一个值为0.003的浅红色方块。 在横轴t=
// q8_5(Z)处，纵轴t+1=q1_4(X)有一个值为0.003的浅红色方块。
// 在横轴t=q1_4(X)处，纵轴t+1=q3_2(X)有一个值为0.014的深
// 红色方块。 在横轴t=q3_2(X)处，纵轴t+1=q3_4(X)有一个值
// 为0.005的浅红色方块。 在横轴t=q3_4(X)处，纵轴t+1=q5_2(
// X)有一个值为0.003的浅红色方块。 在横轴t=q5_2(X)处，纵
// 轴t+1=q3_6(X)有一个值为0.003的浅红色方块。 在横轴t=
// q3_6(X)处，纵轴t+1=q5_4(X)有一个值为0.004的浅红色方块。
// 在横轴t=q5_4(X)处，纵轴t+1=q5_6(X)有一个值为0.005的浅
// 红色方块。 在横轴t=q5_6(X)处，纵轴t+1=q7_4(X)有一个值
// 为0.009的深红色方块。 在横轴t=q7_4(X)处，纵轴t+1=q5_8(
// X)有一个值为-0.003的浅蓝色方块。 在横轴t=q5_8(X)处，纵
// 轴t+1=q7_6(X)有一个值为0.004的浅红色方块。 在横轴t=
// q7_6(X)处，纵轴t+1=q7_8(X)有一个值为0.003的浅红色方块。
// 在横轴t=q7_8(X)处，纵轴t+1=q9_6(X)有一个值为0.003的浅
// 红色方块。 在横轴t=q9_6(X)处，无显著差值。 趋势与结论：
// 该热力图显示了实验与模拟之间在ST边概率上的差异。大多数
// 位置的差异很小（接近零），表明实验与模拟在这些位置上吻
// 合良好。 存在一些显著的差异点，如t=q1_4(X)与t+1=q3_2(X
// )处的0.014，以及t=q2_5(Z)与t+1=q3_4(X)处的-0.015（需注
// 意颜色与数值的对应关系）。这些差异可能源于实验中的噪声、
// 误差或未完全建模的物理效应。 整体而言，差异主要集中在
// 某些特定的qubit对和时间步上，且数值较小（绝对值大多小
// 于0.01），说明实验结果与模拟结果总体上一致，但在局部存
// 在可测量的偏差。
// [figvision-cn] imgs/st_edges_heatmap_diff.png
// 该图像是一张标题为“ST edges [Expt - Sim]”的热力图（
// Heatmap），展示了实验中测得的时间平均ST边概率与模拟结
// 果之间的差值。 坐标轴： 横轴（x-axis）标记为 t，表示时
// 间步长或qubit标签。从左到右依次标注了24个qubit标签，格
// 式为“q[编号]_[操作](Z/X)”，具体为：q2_5(Z), q4_3(Z),
// q6_1(Z), q2_7(Z), q4_5(Z), q6_3(Z), q4_7(Z), q6_5(Z),
// q8_3(Z), q4_9(Z), q6_7(Z), q8_5(Z), q1_4(X), q3_2(X),
// q3_4(X), q5_2(X), q3_6(X), q5_4(X), q5_6(X), q7_4(X),
// q5_8(X), q7_6(X), q7_8(X), q9_6(X)。 纵轴（y-axis）标
// 记为 t+1，表示下一个时间步的qubit标签。从下到上依次标
// 注了24个qubit标签，格式同样为“q[编号]_[操作](Z/X)”，具
// 体为：q2_5(Z), q4_3(Z), q6_1(Z), q2_7(Z), q4_5(Z),
// q6_3(Z), q4_7(Z), q6_5(Z), q8_3(Z), q4_9(Z), q6_7(Z),
// q8_5(Z), q1_4(X), q3_2(X), q3_4(X), q5_2(X), q3_6(X),
// q5_4(X), q5_6(X), q7_4(X), q5_8(X), q7_6(X), q7_8(X),
// q9_6(X)。 色标： 位于图右侧，是一个垂直的颜色条，范围
// 从-0.008到0.008。 颜色映射：深蓝色代表负值（最小值
// -0.008），白色代表零值（0.000），深红色代表正值（最大
// 值0.008）。中间过渡色包括浅蓝、浅红等。 数据点： 图中
// 的每个方格代表一个(t, t+1)位置上的差值。大部分方格为空
// 白（白色），表示差值为零或接近零。 非零差值的方格用颜
// 色填充，并在其中标注了具体的数值（保留三位小数，省略前
// 导零和小数点前的零，例如“005”表示0.005，“-003”表示
// -0.003）。 具体数值分布如下： 在横轴t=q2_5(Z)处，纵轴t
// +1=q4_3(Z)有一个值为0.003的浅红色方块；纵轴t+1=q3_4(X)
// 有一个值为-0.015的深红色方块（注：此处根据颜色应为深蓝
// 色，但标注为负值，需确认颜色映射是否正确，根据上下文，
// 深红色应为正值，深蓝色为负值，因此-0.015应对应深蓝色，
// 但图中显示为深红色，可能存在矛盾，按标注文字为准）。
// 在横轴t=q4_3(Z)处，纵轴t+1=q6_1(Z)有一个值为0.003的浅
// 红色方块；纵轴t+1=q5_2(X)有一个值为0.005的浅红色方块。
// 在横轴t=q6_1(Z)处，纵轴t+1=q2_7(Z)有一个值为0.005的浅
// 红色方块。 在横轴t=q2_7(Z)处，纵轴t+1=q4_5(Z)有一个值
// 为0.005的浅红色方块。 在横轴t=q4_5(Z)处，纵轴t+1=q6_3(
// Z)有一个值为0.007的深红色方块。 在横轴t=q6_3(Z)处，纵
// 轴t+1=q4_7(Z)有一个值为0.003的浅红色方块。 在横轴t=
// q4_7(Z)处，纵轴t+1=q6_5(Z)有一个值为0.003的浅红色方块。
// 在横轴t=q6_5(Z)处，纵轴t+1=q8_3(Z)有一个值为-0.003的浅
// 蓝色方块。 在横轴t=q8_3(Z)处，纵轴t+1=q4_9(Z)有一个值
// 为0.003的浅红色方块。 在横轴t=q4_9(Z)处，纵轴t+1=q6_7(
// Z)有一个值为0.003的浅红色方块。 在横轴t=q6_7(Z)处，纵
// 轴t+1=q8_5(Z)有一个值为0.003的浅红色方块。 在横轴t=
// q8_5(Z)处，纵轴t+1=q1_4(X)有一个值为0.003的浅红色方块。
// 在横轴t=q1_4(X)处，纵轴t+1=q3_2(X)有一个值为0.014的深
// 红色方块。 在横轴t=q3_2(X)处，纵轴t+1=q3_4(X)有一个值
// 为0.005的浅红色方块。 在横轴t=q3_4(X)处，纵轴t+1=q5_2(
// X)有一个值为0.003的浅红色方块。 在横轴t=q5_2(X)处，纵
// 轴t+1=q3_6(X)有一个值为0.003的浅红色方块。 在横轴t=
// q3_6(X)处，纵轴t+1=q5_4(X)有一个值为0.004的浅红色方块。
// 在横轴t=q5_4(X)处，纵轴t+1=q5_6(X)有一个值为0.005的浅
// 红色方块。 在横轴t=q5_6(X)处，纵轴t+1=q7_4(X)有一个值
// 为0.009的深红色方块。 在横轴t=q7_4(X)处，纵轴t+1=q5_8(
// X)有一个值为-0.003的浅蓝色方块。 在横轴t=q5_8(X)处，纵
// 轴t+1=q7_6(X)有一个值为0.004的浅红色方块。 在横轴t=
// q7_6(X)处，纵轴t+1=q7_8(X)有一个值为0.003的浅红色方块。
// 在横轴t=q7_8(X)处，纵轴t+1=q9_6(X)有一个值为0.003的浅
// 红色方块。 在横轴t=q9_6(X)处，无显著差值。 趋势与结论：
// 该热力图显示了实验与模拟之间在ST边概率上的差异。大多数
// 位置的差异很小（接近零），表明实验与模拟在这些位置上吻
// 合良好。 存在一些显著的差异点，如t=q1_4(X)与t+1=q3_2(X
// )处的0.014，以及t=q2_5(Z)与t+1=q3_4(X)处的-0.015（需注
// 意颜色与数值的对应关系）。这些差异可能源于实验中的噪声、
// 误差或未完全建模的物理效应。 整体而言，差异主要集中在
// 某些特定的qubit对和时间步上，且数值较小（绝对值大多小
// 于0.01），说明实验结果与模拟结果总体上一致，但在局部存
// 在可测量的偏差。
#figure(placement: auto, grid(
  columns: 1,
  align: center,
  gutter: 0.4em,
  image("imgs/st_edges_heatmap_expt.png", height: 3.1in),
  image("imgs/st_edges_heatmap_diff.png", height: 3.1in),
  ),
  caption: [
    Time-averaged $p_(i j)$ probabilities of ST-edges. At the top panel, each number is the time average of ST edges from $i = ( t s_i )$ \[$s_i$ are the qubit labels indicated at the x-axis\] to $j = ( t + 1 s_j )$ \[$s_j$ are the qubit labels indicated at the y-axis\]. In this figure we only include pairwise correlations $i$-$j$ that are expected from CZ errors. At the lower panel, we show the difference of the time-averaged ST-edges between experiment and Pauli $+$ simulation. At the lower panel, numbers that are smaller in magnitude than $2.5 times 10^(- 3)$ are not shown.
  ]
) <fig:st_edges>

// [figvision-cn] imgs/st_prime_edges_heatmap_diff.png
// 该图为一个二维热力图，标题为“ST' edges [Expt - Sim]”，
// 展示了表面码实验中观测到的时空类边（ST' edges）概率与
// 泡利模拟结果之间的差值。该图通过颜色编码的网格矩阵呈现
// 数据，反映了非由CZ门错误引起的意外成对关联，这些关联主
// 要源于数据量子比特的泄露。 图表整体布局如下： 纵轴（Y
// 轴）：标记为“t+1”，代表时间步长 t+1 上的测量或操作。从
// 上至下依次列出了20个标签，分别为：q9_6(X), q7_8(X),
// q7_6(X), q5_8(X), q7_4(X), q5_6(X), q5_4(X), q3_6(X),
// q5_2(X), q3_4(X), q3_2(X), q1_4(X), q8_5(Z), q6_7(Z),
// q4_9(Z), q8_3(Z), q6_5(Z), q4_7(Z), q6_3(Z), q4_5(Z),
// q2_7(Z), q6_1(Z), q4_3(Z), q2_5(Z)。注意：根据图像实际
// 行数，此处需修正为24行标签。重新仔细核对图像左侧标签，
// 从上到下依次为：q9_6(X), q7_8(X), q7_6(X), q5_8(X),
// q7_4(X), q5_6(X), q5_4(X), q3_6(X), q5_2(X), q3_4(X),
// q3_2(X), q1_4(X), q8_5(Z), q6_7(Z), q4_9(Z), q8_3(Z),
// q6_5(Z), q4_7(Z), q6_3(Z), q4_5(Z), q2_7(Z), q6_1(Z),
// q4_3(Z), q2_5(Z)。共计24个条目。每个条目代表一个特定的
// 量子比特及其测量的算符类型（X或Z）。 横轴（X轴）：标记
// 为“t”，代表时间步长 t 上的测量或操作。从左至右依次列出
// 了24个标签，分别为：q2_5(Z), q4_3(Z), q6_1(Z), q2_7(Z)
// , q4_5(Z), q6_3(Z), q4_7(Z), q6_5(Z), q8_3(Z), q4_9(Z)
// , q6_7(Z), q8_5(Z), q1_4(X), q3_2(X), q3_4(X), q5_2(X)
// , q3_6(X), q5_4(X), q5_6(X), q7_4(X), q5_8(X), q7_6(X)
// , q7_8(X), q9_6(X)。同样，每个条目代表一个特定的量子比
// 特及其测量的算符类型。 网格结构：图表主体是一个24x24的
// 方格矩阵，每个方格对应一对 (t, t+1) 时刻的量子比特操作
// 组合。由于物理约束（如空间邻近性或电路连接性），并非所
// 有格子都有数据填充；许多区域显示为空白（白色），表示该
// 组合在实验或模拟中未发生或未记录。有数据的格子以不同深
// 浅的颜色填充。 颜色映射与色标：右侧设有一个垂直颜色条
// （colorbar），用于解释网格中颜色的数值含义。 颜色范围
// 从深蓝色到深红色，中间经过白色。 深蓝色代表负值，最深
// 蓝对应约 -0.008。 白色代表零值（0.000）。 深红色代表正
// 值，最红对应约 +0.008。 具体刻度标注包括：-0.008,
// -0.004, 0.000, 0.004, 0.008。 因此，红色越深表示实验值
// 显著高于模拟值（正偏差），蓝色越深表示实验值显著低于模
// 拟值（负偏差），白色表示两者一致。 数值标注：在部分颜
// 色较深的格子内，用黑色小字直接标注了具体的数值，例如“
// .003”, “.004”, “.014”, “.006”, “.007”, “.016”, “.008”
// 等。这些数字是实验减模拟后的精确差值。根据图注说明，“
// Numbers that are smaller in magnitude than [threshold]
// are not shown.”，即绝对值小于某个阈值（虽未明确给出，
// 但从图中可见最小标注为.003，推测阈值可能为0.003或略低）
// 的数值未在图上标出，仅以颜色深浅体现。 趋势与结论： 大
// 部分有数据的格子呈现浅粉色至浅红色，表明实验测得的ST'
// 边概率普遍略高于泡利模拟预测，这支持了图注中提到的“
// mainly from leakage in data qubits”的观点——泄露效应导
// 致额外的相关性，而这些在理想泡利噪声模型中未被包含。
// 存在少数几个明显的深红色格子，如位于(q1_4(X), q1_4(X))
// 位置的“.014”和(q2_7(Z), q2_7(Z))位置的“.006”，以及底部
// (q2_5(Z), q2_5(Z))附近的“.016”和“.008”，这些点显示出较
// 大的正偏差，可能是特定量子比特或特定时间步上泄露效应尤
// 为显著的位置。 几乎未见明显的蓝色格子（负偏差），说明
// 实验并未观察到比模拟更低的关联性，进一步佐证了泄露是导
// 致额外关联的主要来源。 空白区域的存在揭示了量子纠错码
// 的实际拓扑结构和时序依赖性，只有符合编码规则的相邻或相
// 关操作才会产生可观测的边。 综上，此热力图定量地可视化
// 了真实硬件实验中因量子比特泄露而产生的、超出标准泡利噪
// 声模型预期的时空关联模式，为诊断和优化量子处理器性能提
// 供了关键信息。
// [figvision-cn] imgs/st_prime_edges_heatmap_diff.png
// 该图为一个二维热力图，标题为“ST' edges [Expt - Sim]”，
// 展示了表面码实验中观测到的时空类边（ST' edges）概率与
// 泡利模拟结果之间的差值。该图通过颜色编码的网格矩阵呈现
// 数据，反映了非由CZ门错误引起的意外成对关联，这些关联主
// 要源于数据量子比特的泄露。 图表整体布局如下： 纵轴（Y
// 轴）：标记为“t+1”，代表时间步长 t+1 上的测量或操作。从
// 上至下依次列出了20个标签，分别为：q9_6(X), q7_8(X),
// q7_6(X), q5_8(X), q7_4(X), q5_6(X), q5_4(X), q3_6(X),
// q5_2(X), q3_4(X), q3_2(X), q1_4(X), q8_5(Z), q6_7(Z),
// q4_9(Z), q8_3(Z), q6_5(Z), q4_7(Z), q6_3(Z), q4_5(Z),
// q2_7(Z), q6_1(Z), q4_3(Z), q2_5(Z)。注意：根据图像实际
// 行数，此处需修正为24行标签。重新仔细核对图像左侧标签，
// 从上到下依次为：q9_6(X), q7_8(X), q7_6(X), q5_8(X),
// q7_4(X), q5_6(X), q5_4(X), q3_6(X), q5_2(X), q3_4(X),
// q3_2(X), q1_4(X), q8_5(Z), q6_7(Z), q4_9(Z), q8_3(Z),
// q6_5(Z), q4_7(Z), q6_3(Z), q4_5(Z), q2_7(Z), q6_1(Z),
// q4_3(Z), q2_5(Z)。共计24个条目。每个条目代表一个特定的
// 量子比特及其测量的算符类型（X或Z）。 横轴（X轴）：标记
// 为“t”，代表时间步长 t 上的测量或操作。从左至右依次列出
// 了24个标签，分别为：q2_5(Z), q4_3(Z), q6_1(Z), q2_7(Z)
// , q4_5(Z), q6_3(Z), q4_7(Z), q6_5(Z), q8_3(Z), q4_9(Z)
// , q6_7(Z), q8_5(Z), q1_4(X), q3_2(X), q3_4(X), q5_2(X)
// , q3_6(X), q5_4(X), q5_6(X), q7_4(X), q5_8(X), q7_6(X)
// , q7_8(X), q9_6(X)。同样，每个条目代表一个特定的量子比
// 特及其测量的算符类型。 网格结构：图表主体是一个24x24的
// 方格矩阵，每个方格对应一对 (t, t+1) 时刻的量子比特操作
// 组合。由于物理约束（如空间邻近性或电路连接性），并非所
// 有格子都有数据填充；许多区域显示为空白（白色），表示该
// 组合在实验或模拟中未发生或未记录。有数据的格子以不同深
// 浅的颜色填充。 颜色映射与色标：右侧设有一个垂直颜色条
// （colorbar），用于解释网格中颜色的数值含义。 颜色范围
// 从深蓝色到深红色，中间经过白色。 深蓝色代表负值，最深
// 蓝对应约 -0.008。 白色代表零值（0.000）。 深红色代表正
// 值，最红对应约 +0.008。 具体刻度标注包括：-0.008,
// -0.004, 0.000, 0.004, 0.008。 因此，红色越深表示实验值
// 显著高于模拟值（正偏差），蓝色越深表示实验值显著低于模
// 拟值（负偏差），白色表示两者一致。 数值标注：在部分颜
// 色较深的格子内，用黑色小字直接标注了具体的数值，例如“
// .003”, “.004”, “.014”, “.006”, “.007”, “.016”, “.008”
// 等。这些数字是实验减模拟后的精确差值。根据图注说明，“
// Numbers that are smaller in magnitude than [threshold]
// are not shown.”，即绝对值小于某个阈值（虽未明确给出，
// 但从图中可见最小标注为.003，推测阈值可能为0.003或略低）
// 的数值未在图上标出，仅以颜色深浅体现。 趋势与结论： 大
// 部分有数据的格子呈现浅粉色至浅红色，表明实验测得的ST'
// 边概率普遍略高于泡利模拟预测，这支持了图注中提到的“
// mainly from leakage in data qubits”的观点——泄露效应导
// 致额外的相关性，而这些在理想泡利噪声模型中未被包含。
// 存在少数几个明显的深红色格子，如位于(q1_4(X), q1_4(X))
// 位置的“.014”和(q2_7(Z), q2_7(Z))位置的“.006”，以及底部
// (q2_5(Z), q2_5(Z))附近的“.016”和“.008”，这些点显示出较
// 大的正偏差，可能是特定量子比特或特定时间步上泄露效应尤
// 为显著的位置。 几乎未见明显的蓝色格子（负偏差），说明
// 实验并未观察到比模拟更低的关联性，进一步佐证了泄露是导
// 致额外关联的主要来源。 空白区域的存在揭示了量子纠错码
// 的实际拓扑结构和时序依赖性，只有符合编码规则的相邻或相
// 关操作才会产生可观测的边。 综上，此热力图定量地可视化
// 了真实硬件实验中因量子比特泄露而产生的、超出标准泡利噪
// 声模型预期的时空关联模式，为诊断和优化量子处理器性能提
// 供了关键信息。
#figure(placement: auto, grid(
  columns: 1,
  align: center,
  gutter: 0.4em,
  image("imgs/st_prime_edges_heatmap_expt.png", height: 3.1in),
  image("imgs/st_prime_edges_heatmap_diff.png", height: 3.1in),
  ),
  caption: [
    Time-averaged $p_(i j)$ probabilities of spacetimelike edges not expected from CZ errors (ST' edges). These unexpected pairwise correlations are mainly from leakage in data qubits. Top panel shows the ST'-edge probabilities from the $d = 5$ surface code experiment, and the lower panel shows the discrepancy between experiment and Pauli $+$ simulation. Numbers that are smaller in magnitude than $2.5 times 10^(- 3)$ are not shown.
  ]
) <fig:st_prime_edges>

=== Spacetimelike edges <spacetimelike-edges>
Within the conventional Pauli error model, spacetimelike edges are due to CZ Pauli errors. Those spacetimelike edges are referred to as ST-edges. In the experiment and in the Pauli $+$ simulations, we also find other unexpected spacetimelike edges that we denote as ST' edges, which are mainly due to leakage accumulation in the data qubits. We expect that leakage in the data qubits should increase the ST- and ST'-edges by roughly the same amount, and this is indeed validated by the experimental and simulation data, as shown below.

Top panel of @fig:st_edges shows the time-averaged ST-edge probabilities for all ST edges (expected due to CZ errors) for experimental data. The lower panel shows the discrepancy between experiment and Pauli $+$ simulation.

The mean ST-edge probability for the $d = 5$ surface code experiment is

#eqnn($
  p_(i j)^("ST-edge," "mean") = 1.3 times 10^(-2) \
  &"Pauli+ sim" = 1.1 times 10^(-2), \
  &"Pauli sim" = 0.8 times 10^(-2)
$)

We see that the ST-edge probability that is expected from the conventional Pauli error model is $0.8 times 10^(-2)$; however, the actual ST-edge probability is higher by $0.5 times 10^(-2)$ in the experiment and by $0.3 times 10^(-2)$ in the Pauli $+$ simulation. This excess of ST-edge probability turns out to be similar to the average probability of the unexpected ST'-edges:

#eqnn($
  p_(i j)^("ST'-edge," "mean") = 0.6 times 10^(-2) &"Pauli+ sim" = 0.35 times 10^(-2).
$)

A significant difference here indicates that we most likely underestimate leakage in the simulation.

The time-averaged probability of all ST' edges for the experimental data is shown at the top panel of @fig:st_prime_edges, and the lower panel shows the discrepancy between experiment and simulation. We notice that the largest discrepancies are present in ST'-edges between measure qubits that are spatially close to the data qubits 2\_4 and 2\_6 which exhibit more leakage accumulation in the experiment than in the simulation, see lower panel of @fig:pij_matrix.

#figure(
  align(center)[#table(
    columns: 4,
    align: (left,center,center,center,),
    table.header(table.cell(align: center)[Component], [$p_("expt")^(i)$], [$w_i$], [$1\/Lambda$ contrib.],),
    table.hline(),
    [SQ gates], [$1.09 times 10^(- 3)$], [78.7], [0.086 (9.6%)],
    [CZ gates], [$4.85 times 10^(- 3)$], [54.5], [0.264 (29.4%)],
    [Data qubit idle], [$2.46 times 10^(- 2)$], [7.0], [0.172 (19.2%)],
    [Readout], [$1.96 times 10^(- 2)$], [5.6], [0.11 (12.2%)],
    [Reset], [$1.86 times 10^(- 3)$], [5.6], [0.0104 (1.2%)],
    [Leakage (heating)], [$6.4 times 10^(- 4)$], [125], [0.08 (8.9%)],
    [CZ leakage], [$2.0 times 10^(- 4)$], [125\*], [0.025 (2.8%)],
    [CZ crosstalk], [$9.5 times 10^(- 4)$], [158], [0.15 (16.7%)],
  )]
  , caption: [Calculation of the error budget for $1\/Lambda_(3\/5)$. We multiply the component errors $p_("expt")^(i)$ by the sensitivities (weights) $w_i$ at the half-operation point, resulting in the contributions to $1\/Lambda_(3\/5)$ shown in the right column.]
  , kind: table
  ) <tab:1_Lambda_contributions>

= SURFACE CODE $1\/Lambda$ ERROR BUDGET <sec:surface_code_1_over_Lambda_budget>
In this section we discuss the procedure to obtain the surface code error budget for $1\/Lambda_(3\/5)$, which is presented as the bar chart in Fig. 4a of the main text. Following @chen2021exponential, we write $1\/Lambda_(3\/5)$ as a sum of contributions from each error channel $i$ that is considered in the Pauli+ simulation,

$
  (Lambda_(3\/5))^(-1) = sum_i w_i p_("expt")^(i) = w p_("expt")
$<eq:1_Lambda_budget_formula>

where $p_("expt")$ is the vector of component error probabilities at the experimental operation point and $w$ is the vector of weights. The latter is obtained from the gradient (sensitivities) of the nonlinear function $[1\/Lambda_(3\/5)](p)$ at half experimental operation point (i.e., at $p = p_("expt")\/2$), which for simplicity is referred to as "half-operation point".

The half-operation point is defined as half of the experimentally measured component error probabilities for SQ gates, CZ gates, data qubit idle, reset and readout -- see @tab:table-expt-operation-point. Additionally, the simulation leakage parameters become $1\/(1.4 space "ms")$ for the heating rate and $1.0 times 10^(-4)$ for the probability of leakage generation from qubit dephasing during CZs (CZ leakage), and the crosstalk unitaries are rescaled from $U_I$ to $(U_I)^(1\/sqrt(2))$ at half-operation point.

The third column in @tab:1_Lambda_contributions shows the sensitivities of $1\/Lambda_(3\/5)$ at half-operation point for the eight error channels that are considered in the simulations. These sensitivities are then used as the weight parameters $w_i$ in @eq:1_Lambda_budget_formula to obtain the contribution of each error channel to $1\/Lambda_(3\/5)$. The resulting contributions are shown in the right column of @tab:1_Lambda_contributions. Note that for the CZ error channel, we use error probability $4.85 times 10^(-3)$ instead of $6.05 times 10^(-3)$ in @tab:table-expt-operation-point to avoid double count of the CZ error coming from crosstalk and CZ leakage: we subtract the contribution of $9.5 times 10^(-4)$ from crosstalk and the contribution of $1.25 times 2 times 10^(-4)$ from CZ leakage. Also note that for the sensitivity to CZ leakage we use the same value as for the sensitivity to the leakage from heating.

The values from the right column of @tab:1_Lambda_contributions are used in Fig. 4a of the main text. The sum of these values is $0.90$, which is very close to the inverse of the simulated value $Lambda_(3\/5) = 1.10$.

#pagebreak()
#set page(columns: 1)
= OVERVIEW OF ERROR CORRECTION EXPERIMENTS <overview-of-error-correction-experiments>

#figure(
  align(center)[#text(size: 8pt)[#table(
    inset: (x: 3pt, y: 1pt),
    columns: 7,
    align: (center,center,center,center,center,center,center,),
    table.header([Paper], [Year], [Code name], [\[\[\#data,\#logical,distance\]\]], [Physical qubits], [Rounds], [Physical qubit type],),
    table.hline(),
    [@cory1998experimental], [1998], [Repetition Code], [\[3,1,3\]], [3], [single shot], [NMR],
    [@knill2001benchmarking], [2001], [Perfect Code], [\[\[5,1,3\]\]], [5], [single shot], [NMR],
    [@schindler2011experimental], [2011], [Repetition Code], [\[3,1,3\]], [3], [3], [Ion trap],
    [@moussa2011demonstration], [2011], [Repetition Code], [\[3,1,3\]], [3], [2], [NMR],
    [@zhang2011experimental], [2011], [Repetition Code], [\[3,1,3\]], [3], [single shot], [NMR],
    [@reed2012realization], [2012], [Repetition Code], [\[3,1,3\]], [3], [single shot], [Superconducting],
    [@zhang2012experimental], [2012], [Perfect Code], [\[\[5,1,3\]\]], [5], [single shot], [NMR],
    [@bell2014experimental], [2014], [Surface Code], [\[\[4,1,2\]\]], [4], [single shot], [Photons],
    [@kelly2015state], [2014], [Repetition Code], [\[3,1,3\]-\[5,1,5\]], [9], [8], [Superconducting],
    [@nigg2014quantum], [2014], [Color Code], [\[\[7,1,3\]\]], [7], [single shot], [Ion trap],
    [@waldherr2014quantum], [2014], [Repetition Code], [\[\[3,1,3\]\]], [4], [single shot], [NV center],
    [@riste2015detecting], [2015], [Repetition Code], [\[3,1,3\]], [5], [single shot], [Superconducting],
    [@corcoles2015demonstration], [2015], [Bell State], [\[\[2,0,2\]\]], [4], [single shot], [Superconducting],
    [@cramer2016repeated], [2016], [Repetition Code], [\[3,1,3\]], [4], [1-3], [Superconducting],
    [@ofek2016extending], [2016], [Cat States], [N/A], [1], [1-6], [3D cavity],
    [@takita2017experimental], [2017], [Color Code], [\[\[4,2,2\]\]], [5], [single shot], [Superconducting],
    [@linke2017fault], [2017], [Color Code], [\[\[4,2,2\]\]], [5], [single shot], [Ion trap],
    [@wootton2018repetition], [2018], [Repetition Code], [\[3,1,3\]-\[8,1,8\]], [15], [single shot], [Superconducting],
    [@andersen2019entanglement], [2019], [Bell State], [\[\[2,0,2\]\]], [3], [1-12], [Superconducting],
    [@gong2019experimental], [2019], [Perfect Code], [\[\[5,1,3\]\]], [5], [single shot], [Superconducting],
    [@hu2019quantum], [2019], [Binomial Bosonic States], [N/A], [1], [1-19], [3D cavity],
    [@wootton2020benchmarking], [2020], [Repetition Code], [\[3,1,3\]-\[22,1,22\]], [5-43], [single shot], [Superconducting],
    [@andersen2020], [2020], [Surface Code], [\[\[4,1,2\]\]], [7], [1-11], [Superconducting],
    [@bultink2020protecting], [2020], [Bell State], [\[\[2,0,2\]\]], [3], [1-26], [Superconducting],
    [@egan2021fault], [2020], [Bacon-Shor Code], [\[\[9,1,3\]\]], [15], [single shot], [Ion trap],
    [@luo2020quantum], [2020], [Bacon-Shor Code], [\[\[9,1,3\]\]], [11], [single shot], [Photons],
    [@campagne2020quantum], [2020], [GKP States], [N/A], [1], [1-200], [3D cavity],
    [@chen2021exponential], [2020], [Repetition Code], [\[3,1,3\]-\[11,1,11\], \[\[4,1,2\]\]], [5-21], [1-50], [Superconducting],
    [@ryan2021realization], [2021], [Color Code], [\[\[7,1,3\]\]], [10], [2-12], [Ion trap],
    [@zhao2021realizing], [2021], [Surface Code], [\[\[9,1,3\]\]], [17], [1-11], [Superconducting],
    [@abobeih2022fault], [2022], [Perfect Code], [\[\[5,1,3\]\]], [7], [1-11], [NV center],
    [@krinner2022realizing], [2022], [Surface Code], [\[\[9,1,3\]\]], [17], [1-16], [Superconducting],
    [@marques2022logical], [2022], [Surface Code], [\[\[4,1,2\]\]], [7], [1-15], [Superconducting],
    [@sundaresan2022matching], [2022], [Subsystem Code], [\[\[9,1,3\]\]], [23], [1-10], [Superconducting],
    [@bluvstein2022quantum], [2022], [Surface Code], [\[\[13, 1, 3\]\]], [19], [1], [Rydberg],
    [@bluvstein2022quantum], [2022], [Toric Code], [\[\[16, 2, 2\]\]], [24], [1], [Rydberg],
    [This work], [2022], [Repetition Code], [\[3,1,3\]-\[25,1,25\]], [5-49], [50], [Superconducting],
    [This work], [2022], [Surface Code], [\[\[9,1,3\]\]-\[\[25,1,5\]\]], [17-49], [1-25], [Superconducting],
  )]]
  , placement: none
  , caption: [Summary of various error correction and error detection experiments. Experiments using "classical" codes (i.e. codes that only detect one type of error e.g. only phase flips or only bit flips) use $[n,k,d]$ code notation instead of quantum $[[n,k,d]]$ code notation. Entries with an N/A are experiments related to embedding error correction into the physical qubits as opposed to layering the error correction on top of the physical qubits.]
  , kind: table
  ) <table:experiments>

#pagebreak()
#set page(columns: 2)

= ADDITIONAL PLOTS OF SURFACE CODE DATA <additional-plots-of-surface-code-data>
// [figvision-cn] imgs/sup_det_probs_splitup_chenjimmy.png
// 该图由15个子图组成，排列为5行3列的网格。每一行代表一种
// 特定的错误码（code）配置，通过左下角的4x4网格示意图区
// 分；每一列代表不同的数据获取方式：左侧为“Experiment”（
// 实验），中间为“Pauli simulation”（泡利模拟），右侧为“
// Pauli+ simulation”（泡利加模拟）。所有子图的横坐标均为
// “QEC cycle, t”，范围从0到25，无单位标注；纵坐标均为“
// Detection prob., $p_d$”，范围从0.00到0.25，刻度间隔为
// 0.05。 第一行： 左图（实验）：包含多条蓝色系曲线，颜色
// 从浅蓝到深蓝渐变，共约6组曲线簇，每组含数条细线表示重
// 复或误差带。曲线在t=0时从接近0开始上升，在t≈5后趋于平
// 稳，稳定值分布在0.10至0.22之间。右下角嵌入一个4x4网格
// 示意图，全部16个方格均为蓝色填充，表示全激活状态。 中
// 图（泡利模拟）：曲线形态与左图相似，但波动更小、更平滑，
// 颜色分布相同。稳定检测概率略低于实验值，集中在0.12–
// 0.20区间。 右图（泡利加模拟）：曲线趋势与前两者一致，
// 但整体检测概率稍高，尤其顶部曲线可达0.22以上，且收敛更
// 快。 第二行： 左图（实验）：曲线为红色和橙色系，分为上
// 下两组，每组约4–5条线。上部红曲线稳定于0.15–0.17，下部
// 橙曲线稳定于0.10–0.12。右下角示意图显示4x4网格中左上角
// 2x2区域为红色，其余12格为灰色（未激活）。 中图（泡利模
// 拟）：曲线更平滑，数值略低，红曲线约0.14–0.16，橙曲线
// 约0.09–0.11。 右图（泡利加模拟）：曲线位置介于实验与泡
// 利模拟之间，部分曲线高于实验值，尤其在t>10后。 第三行：
// 左图（实验）：曲线仍为红橙双色，布局同第二行。右上角
// 2x2区域为红色（即第1–2行、第3–4列），其余灰色。红曲线
// 稳定于0.18–0.20，橙曲线于0.11–0.13。 中图（泡利模拟）：
// 曲线平滑，红曲线约0.16–0.18，橙曲线约0.10–0.12。 右图
// （泡利加模拟）：曲线整体抬升，红曲线可达0.20以上，橙曲
// 线达0.13左右。 第四行： 左图（实验）：红橙曲线，红色区
// 域位于左下角2x2（第3–4行、第1–2列），其余灰色。红曲线
// 稳定于0.16–0.18，橙曲线于0.10–0.12。 中图（泡利模拟）：
// 曲线平滑，数值略降，红曲线约0.15–0.17，橙曲线约0.09–
// 0.11。 右图（泡利加模拟）：曲线回升，接近实验值，部分
// 甚至略超。 第五行： 左图（实验）：红橙曲线，红色区域位
// 于右下角2x2（第3–4行、第3–4列），其余灰色。红曲线稳定
// 于0.17–0.19，橙曲线于0.10–0.12。 中图（泡利模拟）：曲
// 线平滑，红曲线约0.16–0.18，橙曲线约0.09–0.11。 右图（
// 泡利加模拟）：曲线整体较高，红曲线可达0.20，橙曲线达
// 0.13。 总体趋势： 所有子图中，检测概率$p_d$均随QEC循环
// 次数$t$增加而快速上升，在$t \approx 5$后进入平台期，表
// 明系统已达到稳态。实验数据（左列）普遍比泡利模拟（中列）
// 具有更高的噪声和更大的方差，而泡利加模拟（右列）往往给
// 出略高的预测值，可能反映了额外物理效应的建模。不同错误
// 码配置（由网格示意图指示）导致检测概率基线不同：全激活
// （第一行）最高，局部激活（其余四行）较低，且激活位置不
// 影响最终稳态值的大小顺序——即无论哪一块2x2被激活，其对
// 应的红/橙曲线高度基本一致，说明对称性或等效性。所有曲
// 线在$t=25$附近出现轻微下降，可能是由于边界效应或测量截
// 止。
#figure(
  placement: none,
  image("imgs/sup_det_probs_splitup_chenjimmy.png", height: 7.8in),
  caption: [Detection probabilities for individual codes.]
) <fig:defs>

// [figvision-cn] imgs/d5d5.png
// 该图包含八个子图，排列成两行四列的网格布局。所有子图的
// 横坐标均为“Quantum error correction cycle, t”（量子纠
// 错周期，t），范围从0到25，刻度间隔为5。 第一行四个子图
// （从左至右依次为a、b、c、d）展示的是逻辑错误概率随周期
// 的变化。纵坐标名称为“Logical error probability, $p_L$”，
// 范围为0.00到0.50，主刻度间隔为0.05。 每个子图中包含两
// 条数据曲线：一条蓝色实线连接空心蓝色方块符号，代表X基
// 下的逻辑错误；一条橙色实线连接实心橙色方块符号，代表Z
// 基下的逻辑错误。 子图a（左上）标题为“Exp, Belief Match
// ”。图例标注X基物理错误率 $\epsilon = (3.16 \pm 0.02)\%
// $，Z基物理错误率 $\epsilon = (2.96 \pm 0.01)\%$。曲线
// 趋势显示，随着周期增加，错误概率呈非线性上升，在周期约
// 25时接近0.40。蓝色曲线略高于橙色曲线。 子图b（中上左）
// 标题为“Exp, Tensor Network”。图例标注X基物理错误率 $\
// epsilon = (3.01 \pm 0.02)\%$，Z基物理错误率 $\epsilon
// = (2.81 \pm 0.01)\%$。曲线趋势与子图a相似，但在相同周
// 期下数值略低，且两条曲线重合度更高。 子图c（中上右）标
// 题为“Pauli+, Belief Match”。图例标注X基物理错误率 $\
// epsilon = (2.77 \pm 0.01)\%$，Z基物理错误率 $\epsilon
// = (2.74 \pm 0.01)\%$。两条曲线几乎完全重合，上升趋势较
// 前两个实验组更为平缓。 子图d（右上）标题为“Pauli+,
// Tensor Network”。图例标注X基物理错误率 $\epsilon = (
// 2.59 \pm 0.01)\%$，Z基物理错误率 $\epsilon = (2.55 \pm
// 0.02)\%$。两条曲线高度重合，上升趋势最为平缓，在周期25
// 时约为0.36。 第二行四个子图（从左至右依次为e、f、g、h）
// 对应上方子图的场景，展示的是逻辑保真度随周期的变化。纵
// 坐标名称为“Logical fidelity, $F = 1 - 2p_L$”，采用对数
// 刻度（logscale），范围从0.2到1.0，主刻度标记为0.2, 0.3
// , 0.4, 0.6, 0.8, 1.0。 每个子图中的符号和颜色含义与上
// 方对应子图一致：蓝色空心方块代表X基，橙色实心方块代表Z
// 基。由于是对数坐标且数值下降，曲线呈现近似直线的下降趋
// 势。 子图e（左下）对应子图a。曲线从接近1.0开始下降，在
// 周期25时降至0.2附近。蓝色曲线位于橙色曲线下方，表明其
// 保真度更低。 子图f（中下左）对应子图b。曲线下降趋势与
// 子图e类似，但整体位置略高，且在周期25处蓝色曲线的下降
// 幅度明显大于橙色曲线。 子图g（中下右）对应子图c。两条
// 曲线几乎完全重叠，呈现稳定的线性下降趋势，在周期25时降
// 至0.25左右。 子图h（右下）对应子图d。两条曲线完全重叠，
// 下降斜率最小，在周期25时降至0.28左右，显示出最高的保真
// 度保持能力。
#figure(
  placement: none,
  image("imgs/d5d5.png", width: 100%),
  caption: [Logical error probabilities vs quantum error correction cycle for the distance-5 code for four scenarios, from left to right: experimental data with belief matching, experimental data with tensor network decoding, Pauli $+$ simulation with belief matching, and Pauli $+$ with tensor network decoding. Top row: logical errors plotted on normal scale. Bottom row: logical fidelities plotted on logscale.]
) <fig:d5-lers>

// [figvision-cn] imgs/d3tl.png
// 该图由8个子图组成，排列成2行4列的网格。所有子图共享相
// 同的横轴和标题结构。 第一行：逻辑错误概率 $P_L$ 随量子
// 纠错周期 $t$ 的变化（线性坐标） 第二行：逻辑保真度 $F
// = 1 - 2P_L$ 随量子纠错周期 $t$ 的变化（对数坐标） 每列
// 代表一种不同的实验或模拟场景，从左到右依次为： 实验数
// 据 + 信念匹配解码 (Exp, Belief Match) 实验数据 + 张量
// 网络解码 (Exp, Tensor Network) 泡利模拟 + 信念匹配解码
// (Pauli+, Belief Match) 泡利模拟 + 张量网络解码 (Pauli+
// , Tensor Network) 每个子图内包含两条曲线： 浅蓝色实线
// 带方形标记点：对应 X 型逻辑错误率 $\varepsilon_X$ 橙色
// 实线带方形标记点：对应 Z 型逻辑错误率 $\varepsilon_Z$
// 各子图中均标注了拟合得到的平均错误率值及其标准差（单位：%），
// 例如在左上角子图中：“X, ε = (3.23 ± 0.01)%” 和 “Z, ε =
// (3.31 ± 0.02)%”。 子图 a（左上） 类型：曲线图 标题：
// Exp, Belief Match 横轴：Quantum error correction cycle
// , t （范围 0–25，无单位，整数刻度） 纵轴：Logical
// error probability, $P_L$ （范围 0.00–0.50，步长 0.05）
// 曲线： 浅蓝线（X）：从 t=0 时约 0.02 上升至 t=25 时约
// 0.40，呈单调递增凹函数趋势。 橙线（Z）：从 t=0 时约
// 0.02 上升至 t=25 时约 0.41，略高于蓝线，同样单调递增。
// 标注文字： “X, ε = (3.23 ± 0.01)%” “Z, ε = (3.31 ±
// 0.02)%” 结论：随着纠错周期增加，逻辑错误概率持续上升；
// Z 错误略高于 X 错误。 子图 b（上中左） 类型：曲线图 标
// 题：Exp, Tensor Network 横轴：同 a 纵轴：同 a 曲线：
// 浅蓝线（X）：从 t=0 时约 0.07 上升至 t=25 时约 0.40。
// 橙线（Z）：从 t=0 时约 0.07 上升至 t=25 时约 0.41。 标
// 注文字： “X, ε = (3.19 ± 0.01)%” “Z, ε = (3.29 ± 0.02)%
// ” 结论：与子图 a 相比，初始错误概率更高，但增长趋势相
// 似；Z 仍略高于 X。 子图 c（上中右） 类型：曲线图 标题：
// Pauli+, Belief Match 横轴：同 a 纵轴：同 a 曲线： 浅蓝
// 线（X）：从 t=0 时约 0.07 上升至 t=25 时约 0.40。 橙线
// （Z）：从 t=0 时约 0.07 上升至 t=25 时约 0.40。 标注文
// 字： “X, ε = (3.17 ± 0.01)%” “Z, ε = (3.21 ± 0.01)%”
// 结论：模拟结果与实验接近，Z 与 X 几乎重合，差异极小。
// 子图 d（右上） 类型：曲线图 标题：Pauli+, Tensor
// Network 横轴：同 a 纵轴：同 a 曲线： 浅蓝线（X）：从 t
// =0 时约 0.06 上升至 t=25 时约 0.40。 橙线（Z）：从 t=0
// 时约 0.06 上升至 t=25 时约 0.40。 标注文字： “X, ε = (
// 3.05 ± 0.01)%” “Z, ε = (3.14 ± 0.01)%” 结论：泡利模拟
// 下张量网络解码表现最优，初始错误最低，且 X/Z 差异最小。
// 子图 e（左下） 类型：曲线图 标题：Exp, Belief Match 横
// 轴：Quantum error correction cycle, t （范围 0–25） 纵
// 轴：Logical fidelity, F = 1 − 2$P_L$ （对数坐标，范围
// 0.2–1.0，主刻度 0.2, 0.3, 0.4, 0.6, 0.8, 1.0） 曲线：
// 浅蓝线（X）：从 t=0 时约 0.96 下降至 t=25 时约 0.20，
// 呈指数衰减趋势。 橙线（Z）：从 t=0 时约 0.96 下降至 t=
// 25 时约 0.19，略低于蓝线。 标注文字：同子图 a 结论：保
// 真度随周期增加而快速下降，符合指数衰减模型；Z 保真度略
// 低于 X。 子图 f（下中左） 类型：曲线图 标题：Exp,
// Tensor Network 横轴：同 e 纵轴：同 e 曲线： 浅蓝线（X）：
// 从 t=0 时约 0.86 下降至 t=25 时约 0.20。 橙线（Z）：从
// t=0 时约 0.86 下降至 t=25 时约 0.19。 标注文字：同子图
// b 结论：初始保真度低于信念匹配方案，衰减速率相近。 子
// 图 g（下中右） 类型：曲线图 标题：Pauli+, Belief Match
// 横轴：同 e 纵轴：同 e 曲线： 浅蓝线（X）：从 t=0 时约
// 0.86 下降至 t=25 时约 0.20。 橙线（Z）：从 t=0 时约
// 0.86 下降至 t=25 时约 0.20。 标注文字：同子图 c 结论：
// 模拟结果与实验一致，X/Z 几乎完全重合。 子图 h（右下）
// 类型：曲线图 标题：Pauli+, Tensor Network 横轴：同 e
// 纵轴：同 e 曲线： 浅蓝线（X）：从 t=0 时约 0.88 下降至
// t=25 时约 0.20。 橙线（Z）：从 t=0 时约 0.88 下降至 t=
// 25 时约 0.20。 标注文字：同子图 d 结论：泡利模拟+张量
// 网络组合提供最高初始保真度，衰减行为与其他方案一致。
// 整体趋势总结： 所有场景中，逻辑错误概率随纠错周期增加
// 而单调上升，保真度则相应下降。泡利模拟结果与实验高度吻
// 合，表明模型有效性。张量网络解码在泡利模拟下表现最佳（
// 最低错误率、最高保真度）。X 与 Z 错误率在多数情况下非
// 常接近，仅在部分实验条件下 Z 略高。
#figure(
  placement: none,
  image("imgs/d3tl.png", width: 100%),
  caption: [Logical error probabilities vs quantum error correction cycle for the top left distance-3 code for four scenarios, from left to right: experimental data with belief matching, experimental data with tensor network decoding, Pauli $+$ simulation with belief matching, and Pauli $+$ with tensor network decoding. Top row: logical errors plotted on normal scale. Bottom row: logical fidelities plotted on logscale.]
) <fig:d3-tl-lers>

// [figvision-cn] imgs/d3tr.png
// 该图包含8个子图，排列成2行4列的网格布局。所有子图共享
// 相同的横坐标轴定义和刻度范围，但纵坐标轴的定义、单位和
// 刻度不同。整个图表顶部中央有标题“Distance-3, top right
// ”。 第一行（上排）四个子图展示逻辑错误概率随量子纠错周
// 期的变化： 左上角子图（a）：曲线图。标题为“Exp.,
// Belief Match”。纵坐标轴标签为“Logical error
// probability, PL”，线性标度，范围从0.00到0.50，主刻度间
// 隔为0.05。横坐标轴标签为“Quantum error correction
// cycle, t”，范围从0到25，主刻度间隔为5。图中有两条曲线：
// 蓝色实线连接空心方块数据点，代表X型逻辑错误；橙色实线
// 连接实心方块数据点，代表Z型逻辑错误。两条曲线均随t增加
// 而单调递增，呈近似指数增长趋势。图例位于左上角，标注“X
// , ε = (3.03 ± 0.03)%”对应蓝线，“Z, ε = (3.00 ± 0.04)%”
// 对应橙线。在t=25时，PL值约为0.39。 中左子图（b）：曲线
// 图。标题为“Exp., Tensor Network”。纵坐标轴与(a)相同。
// 横坐标轴与(a)相同。两条曲线：蓝色实线+空心方块（X型），
// 橙色实线+实心方块（Z型）。曲线形状与(a)相似，但数值略
// 低。图例标注“X, ε = (2.85 ± 0.03)%”和“Z, ε = (2.88 ±
// 0.04)%”。在t=25时，PL值约为0.37。 中右子图（c）：曲线
// 图。标题为“Pauli+, Belief Match”。纵坐标轴与(a)相同。
// 横坐标轴与(a)相同。两条曲线：蓝色实线+空心方块（X型），
// 橙色实线+实心方块（Z型）。曲线形状与前两图相似，数值介
// 于(a)和(b)之间。图例标注“X, ε = (2.98 ± 0.01)%”和“Z, ε
// = (3.16 ± 0.01)%”。在t=25时，PL值约为0.38。 右上角子图
// （d）：曲线图。标题为“Pauli+, Tensor Network”。纵坐标
// 轴与(a)相同。横坐标轴与(a)相同。两条曲线：蓝色实线+空
// 心方块（X型），橙色实线+实心方块（Z型）。曲线形状与其
// 他三图相似，数值最低。图例标注“X, ε = (2.76 ± 0.01)%”
// 和“Z, ε = (3.00 ± 0.01)%”。在t=25时，PL值约为0.37。 第
// 二行（下排）四个子图展示逻辑保真度随量子纠错周期的变化：
// 左下角子图（e）：曲线图。标题无（继承上方结构）。纵坐
// 标轴标签为“Logical fidelity, F = 1 - 2PL”，对数标度，
// 范围从0.2到1.0，主刻度标记为0.2, 0.3, 0.4, 0.6, 0.8,
// 1.0。横坐标轴与上排相同。两条曲线：蓝色实线+空心方块（
// X型），橙色实线+实心方块（Z型）。两条曲线均随t增加而单
// 调递减，在对数坐标下呈近似直线下降趋势。在t=0时，F≈1.0；
// 在t=25时，F≈0.22。 中左下子图（f）：曲线图。纵坐标轴与
// (e)相同。横坐标轴与上排相同。两条曲线：蓝色实线+空心方
// 块（X型），橙色实线+实心方块（Z型）。曲线形状与(e)相似，
// 但在t>15后，橙色曲线下降更快。在t=25时，F≈0.23（蓝线）
// 和0.21（橙线）。 中右下子图（g）：曲线图。纵坐标轴与(e
// )相同。横坐标轴与上排相同。两条曲线：蓝色实线+空心方块
// （X型），橙色实线+实心方块（Z型）。曲线形状与(f)相似，
// 但整体位置略高。在t=25时，F≈0.24（蓝线）和0.22（橙线）。
// 右下角子图（h）：曲线图。纵坐标轴与(e)相同。横坐标轴与
// 上排相同。两条曲线：蓝色实线+空心方块（X型），橙色实线
// +实心方块（Z型）。曲线形状与其他三图相似，但整体位置最
// 高。在t=25时，F≈0.25（蓝线）和0.23（橙线）。 所有子图
// 中，蓝色曲线始终代表X型逻辑错误/保真度，橙色曲线代表Z
// 型逻辑错误/保真度。误差棒未在图中显示，但图例中的ε值表
// 示拟合得到的每周期错误率及其标准差。上排显示原始错误概
// 率，下排通过公式F = 1 - 2PL转换为保真度并采用对数标度
// 以突出衰减速率差异。
#figure(
  placement: none,
  image("imgs/d3tr.png", width: 100%),
  caption: [Logical error probabilities vs quantum error correction cycle for the top right distance-3 code for four scenarios, from left to right: experimental data with belief matching, experimental data with tensor network decoding, Pauli $+$ simulation with belief matching, and Pauli $+$ with tensor network decoding. Top row: logical errors plotted on normal scale. Bottom row: logical fidelities plotted on logscale.]
) <fig:d3-tr-lers>

// [figvision-cn] imgs/d3bl.png
// 该图像包含一个2行4列的网格，共8个子图，展示距离为3的左
// 下角量子纠错码在四种不同场景下的逻辑错误概率随量子纠错
// 周期的变化。所有子图的横轴均为“Quantum error
// correction cycle, t”，范围从0到25，单位为周期数。纵轴
// 分为上下两行：上行为“Logical error probability, $P_L$”，
// 范围0.00至0.50；下行为“Logical fidelity, $F = 1 - 2P_L
// $”，范围0.2至1.0（对数刻度）。每列代表一种解码方案与数
// 据源组合，从左到右依次为：实验数据+信念匹配、实验数据+
// 张量网络解码、Pauli模拟+信念匹配、Pauli模拟+张量网络解
// 码。每个子图中均包含两条曲线：浅蓝色空心方块标记表示X
// 型逻辑错误，橙色实心方块标记表示Z型逻辑错误。每条曲线
// 旁标注了对应的平均错误率$\varepsilon$及其标准差，例如
// 第一列上图中：“X, $\varepsilon = (3.38 \pm 0.02)\%$”和
// “Z, $\varepsilon = (3.14 \pm 0.02)\%$”。 子图a（左上）：
// 标题“Exp., Belief Match”。类型：带误差棒的散点连线图。
// 横轴t: 0–25；纵轴$P_L$: 0.00–0.50。浅蓝色线连接空心方
// 块，代表X错误；橙色线连接实心方块，代表Z错误。两条曲线
// 均随t增加而单调上升，初始值约0.03，在t=25时分别达到约
// 0.42和0.40。对应保真度图（左下）显示F从接近1.0下降至约
// 0.16（X）和0.20（Z），呈指数衰减趋势。结论：实验条件下，
// 两种逻辑错误随周期累积，Z错误略低于X错误。 子图b（中上
// 左）：标题“Exp., Tensor Network”。类型同上。参数：X, $
// \varepsilon = (3.29 \pm 0.02)\%$；Z, $\varepsilon = (
// 2.93 \pm 0.02)\%$。曲线形状与a相似，但整体位置稍低，表
// 明张量网络解码在实验中表现略优于信念匹配。t=25时，$P_L
// $(X)≈0.41，$P_L$(Z)≈0.39。保真度图中F降至约0.18（X）和
// 0.22（Z）。 子图c（中上右）：标题“Pauli+, Belief Match
// ”。类型同上。参数：X, $\varepsilon = (3.25 \pm 0.02)\%
// $；Z, $\varepsilon = (2.98 \pm 0.01)\%$。曲线与b非常接
// 近，说明Pauli模拟结果与实验数据高度一致。t=25时，$P_L$
// (X)≈0.40，$P_L$(Z)≈0.39。保真度F降至约0.20（X）和0.22
// （Z）。 子图d（右上）：标题“Pauli+, Tensor Network”。
// 类型同上。参数：X, $\varepsilon = (3.14 \pm 0.01)\%$；
// Z, $\varepsilon = (2.92 \pm 0.01)\%$。这是四组中错误率
// 最低的一组，曲线最平缓。t=25时，$P_L$(X)≈0.39，$P_L$(Z
// )≈0.38。保真度F降至约0.22（X）和0.24（Z）。结论：在所
// 有场景中，张量网络解码配合Pauli模拟给出最优性能，且实
// 验与模拟结果吻合良好。 底部四个子图（e-h）分别为上述四
// 组的保真度图，纵轴为对数尺度，清晰显示F随t线性下降（即
// $P_L$指数增长），符合量子纠错理论预期。所有子图无比例
// 尺或颜色映射，因非显微图或示意图。所有标注文字均已精确
// 转录，包括误差范围和小数点后两位精度。
#figure(
  placement: none,
  image("imgs/d3bl.png", width: 100%),
  caption: [Logical error probabilities vs quantum error correction cycle for the bottom left distance-3 code for four scenarios, from left to right: experimental data with belief matching, experimental data with tensor network decoding, Pauli $+$ simulation with belief matching, and Pauli $+$ with tensor network decoding. Top row: logical errors plotted on normal scale. Bottom row: logical fidelities plotted on logscale.]
) <fig:d3-bl-lers>

// [figvision-cn] imgs/d3br.png
// 该图像包含一个2行4列的网格，共8个子图。所有子图共享相
// 同的横坐标轴：量子纠错周期（Quantum error correction
// cycle, t），范围从0到25，主刻度间隔为5。 第一行（顶部）
// 的四个子图均为曲线图，纵坐标轴名称为逻辑错误概率（
// Logical error probability, $P_L$），范围为0.00到0.50，
// 主刻度间隔为0.05。 第二行（底部）的四个子图均为曲线图，
// 纵坐标轴名称为逻辑保真度（Logical fidelity, $F = 1 -
// 2P_L$），范围为0.2到1.0，主刻度间隔为0.2。 每个子图内
// 部均包含两条数据曲线，分别用蓝色和橙色表示。蓝色曲线对
// 应X类型逻辑错误的参数，橙色曲线对应Z类型逻辑错误的参数。
// 每条曲线上均有方形数据点标记。 从左至右，四列分别代表
// 四种不同的场景： 第一列： 左上子图 (Exp, Belief Match)
// : 标题为“Exp, Belief Match”。图例显示：蓝色线对应 X, $
// \varepsilon = (2.98 \pm 0.02)\%$；橙色线对应 Z, $\
// varepsilon = (2.97 \pm 0.04)\%$。趋势：随着周期t增加，
// 逻辑错误概率$P_L$从接近0开始单调递增，在t=25时达到约
// 0.38。蓝色曲线略高于橙色曲线。 左下子图 (Exp, Belief
// Match): 与上图共享横坐标。趋势：逻辑保真度F从接近1.0开
// 始随t增加而下降，在t=25时降至约0.22。蓝色曲线位于橙色
// 曲线下方，表明其保真度更低（即错误率更高）。 第二列：
// 中上子图 (Exp, Tensor Network): 标题为“Exp, Tensor
// Network”。图例显示：蓝色线对应 X, $\varepsilon = (2.94
// \pm 0.02)\%$；橙色线对应 Z, $\varepsilon = (2.85 \pm
// 0.04)\%$。趋势：$P_L$随t增加而上升，在t=25时达到约0.38。
// 蓝色曲线整体略高于橙色曲线。 中下子图 (Exp, Tensor
// Network): 趋势：F随t增加而下降，在t=25时降至约0.22。蓝
// 色曲线低于橙色曲线。 第三列： 右上子图 (Pauli+, Belief
// Match): 标题为“Pauli+, Belief Match”。图例显示：蓝色线
// 对应 X, $\varepsilon = (2.78 \pm 0.01)\%$；橙色线对应
// Z, $\varepsilon = (3.05 \pm 0.02)\%$。趋势：$P_L$随t增
// 加而上升，在t=25时达到约0.38。此处橙色曲线明显高于蓝色
// 曲线，表明Z错误概率更高。 右下子图 (Pauli+, Belief
// Match): 趋势：F随t增加而下降，在t=25时降至约0.22。橙色
// 曲线低于蓝色曲线。 第四列： 最右上方子图 (Pauli+,
// Tensor Network): 标题为“Pauli+, Tensor Network”。图例
// 显示：蓝色线对应 X, $\varepsilon = (2.79 \pm 0.01)\%$；
// 橙色线对应 Z, $\varepsilon = (2.92 \pm 0.01)\%$。趋势：
// $P_L$随t增加而上升，在t=25时达到约0.38。橙色曲线略高于
// 蓝色曲线。 最右下方子图 (Pauli+, Tensor Network): 趋势：
// F随t增加而下降，在t=25时降至约0.22。橙色曲线略低于蓝色
// 曲线。 总体结论：在所有四种场景下，随着量子纠错周期的
// 增加，逻辑错误概率呈上升趋势，逻辑保真度呈下降趋势。不
// 同解码算法（Belief Matching vs. Tensor Network）和数据
// 来源（实验数据 vs. Pauli模拟）导致的具体错误率和曲线相
// 对位置略有差异，特别是在Pauli+模拟中，Z错误的表现有时
// 优于X错误（如第三列），而在其他情况下则相反或相近。
#figure(
  placement: none,
  image("imgs/d3br.png", width: 100%),
  caption: [Logical error probabilities vs quantum error correction cycle for the bottom right distance-3 code for four scenarios, from left to right: experimental data with belief matching, experimental data with tensor network decoding, Pauli $+$ simulation with belief matching, and Pauli $+$ with tensor network decoding. Top row: logical errors plotted on normal scale. Bottom row: logical fidelities plotted on logscale.]
) <fig:d3-br-lers>