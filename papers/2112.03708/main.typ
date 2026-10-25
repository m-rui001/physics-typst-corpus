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

#set heading(numbering: "1.1")
#set figure(placement: auto)
#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)
#let panel(ref-lbl, letter) = context {
  let el = query(ref-lbl).first()
  link(el.location(), numbering(el.numbering, ..el.counter.at(el.location())) + letter)
}
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#place(top, float: true, scope: "parent", clearance: 1.2em)[
  #align(center)[
    #text(12pt, weight: "bold", [Realizing Repeated Quantum Error Correction in a Distance-Three Surface Code])
    #v(1.2em)
    #text(10.5pt)[Sebastian Krinner#footnote[These authors contributed equally to this work.]#footnote[These authors contributed equally to this work.]#footnote[Current affiliation: QuTech and Kavli Institute for Nanoscience, Delft University of Technology, Delft 2628 CJ, Netherlands.]]
  ]
  #v(1.6em)

// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: December 8, 2021)]]

  Quantum computers hold the promise of solving computational problems which are intractable using conventional methods @Preskill2018. For fault-tolerant operation quantum computers must correct errors occurring due to unavoidable decoherence and limited control accuracy ~@Shor1996. Here, we demonstrate quantum error correction using the surface code, which is known for its exceptionally high tolerance to errors @Kitaev2003 @Dennis2002 @Raussendorf2007 @Bombin2009. Using 17 physical qubits in a superconducting circuit we encode quantum information in a distance-three logical qubit building up on recent distance-two error detection experiments @Andersen2020b @Marques2021 @Chen2021p. In an error correction cycle taking only $1.1$µs, we demonstrate the preservation of four cardinal states of the logical qubit. Repeatedly executing the cycle, we measure and decode both bit- and phase-flip error syndromes using a minimum-weight perfect-matching algorithm in an error-model-free approach and apply corrections in postprocessing. We find a low error probability of $3 "%"$ per cycle when rejecting experimental runs in which leakage is detected. The measured characteristics of our device agree well with a numerical model. Our demonstration of repeated, fast and high-performance quantum error correction cycles, together with recent advances in ion traps @Ryan-Anderson2021, support our understanding that fault-tolerant quantum computation will be practically realizable.
]

  The surface code @Bravyi1998 @Dennis2002 is a planar realization of Kitaev's toric code @Kitaev2003 which uses topological features of a qubit lattice to correct errors in quantum information processing systems. This code is a prominent contender to reach fault-tolerant quantum computation because of its high error threshold of about $1 "%"$ against quantum circuit noise @Wang2003a @Raussendorf2007 and its compatibility with 2D architectures. The surface code belongs to the family of stabilizer codes @Gottesman1997 @Terhal2015n which encode quantum information into a joint subspace of definite parities on a set of physical data qubits to form a logical qubit. Errors are detected using measurements of auxiliary qubits to extract parity information without collapsing the logical qubit state. The fault-tolerant operation of a quantum computer requires repeated detection and correction of both bit- and phase-flip errors on data qubits. With an increasing number of physical qubits and thus an increasing code distance $d$ the number of errors $ ⌊ (d-1)/2 ⌋ $ which can at least be detected and corrected per error-correction cycle increases, making the code more resilient when error rates are sufficiently low.

  Error correction limited to a single type of error has been realized with repetition codes in nuclear magnetic resonance @Moussa2011, trapped ions @Schindler2011, nitrogen-vacancy centers @Waldherr2014 and superconducting circuits @Kelly2015 @Chen2021p. In single-cycle experiments, fault-tolerant stabilizer measurements and correction of both types of errors have been demonstrated with the five-qubit code and the Bacon-Shor code @Knill2001a @Abobeih2021 @Egan2021 @Hilder2021 Recently, error detection in a distance-two surface code has been realized with seven qubits @Andersen2020b @Marques2021 @Chen2021p, and only very recently, repeated stabilizer-based error correction has been demonstrated with a distance-three color code in a trapped ion system @Ryan-Anderson2021

  Correction of both bit- and phase-flip errors requires at least a distance-three code. In combination with fault-tolerant circuits for error syndrome measurements, this guarantees that any single error on any of the constituent data and auxiliary qubits or operations can be corrected @Horsman2012 @Terhal2015n. While the work we discuss here focuses on digital encoding of quantum information, continuous variable encoding, for example in harmonic oscillator states, constitutes an alternative approach to quantum error correction~(QEC), see for example Refs.~@Ofek2016 @Hu2019a @Fluehmann2019 #cite(<CampagneIbarcq2020>)

  #heading(level: 1, numbering: none)[A Distance-Three Surface Code in Superconducting Circuits]
  <a-distance-three-surface-code-in-superconducting-circuits>

  #place(top + center, scope: "parent", float: true)[
  // [figvision] imgs/surface_code_and_device_20211202_reduced.png
  // Four labelled panels, no common axes.
  // (a) d=3 surface-code schematic drawn as a 3x3 grid: nine red data qubits D1-D9 at
  //     vertices; four green Z-type stabilizer plaquettes S_Z1-S_Z4 and four blue X-type
  //     stabilizers S_X1-S_X4 on the faces; gray lines show coupler connectivity.
  //     Solid black horizontal path through D1-D3 (and row 2) marks the logical X_L;
  //     solid black vertical path marks the logical Z_L. Thin gray lattice edges join
  //     all neighbours, matching the rotated heavy-hex layout of (b).
  // (b) False-colour micrograph of the 17-qubit device (QUBEV logo lower right; scale bar
  //     about 1 mm). Qubits labelled Z1-Z4, X1-X4, D1-D9 sit on a diamond lattice rotated
  //     45 deg from (a). A side legend keys the false colours: Qubits, Drive Lines,
  //     Flux Lines, Coupling Elements, Readout Resonators, Purcell Filters, Feed Lines.
  // (c) Qubit frequency omega/2pi (GHz, vertical) versus qubit index (horizontal, grouped).
  //     Three horizontal bands: violet open circles ~7.3 GHz for readout resonators,
  //     teal/green markers ~6.2 GHz for Z/X auxiliary qubits, red ~4 GHz for data qubits.
  //     Vertical bars under each marker give the tunable frequency range.
  // (d) Cumulative probability (0-1, vertical, log-style tail) versus error rate
  //     (horizontal, 1e-4 to 1e-1). Four curves: single-qubit gate (pink), simultaneous
  //     two-qubit gate (cyan), two-state readout error (red), three-state readout error
  //     (light red). Curves rise steeply around 1e-3 to 1e-2, with the readout curves
  //     shifted to higher error rates than the gate curves.
// [figvision-cn] imgs/surface_code_and_device_20211202_reduced.png
// 该图包含四个子图（a、b、c、d），展示了距离为3的表面码
// 量子器件的概念设计、物理架构及性能指标。 子图 a： 类型：
// 示意图。 内容：展示了距离为3的表面码的逻辑结构。图中包
// 含9个数据量子比特，表示为红色圆圈，标记为D1至D9，排列
// 成3x3的网格。围绕数据量子比特的是辅助量子比特：4个Z型
// 辅助量子比特（绿色圆圈，标记为Z1至Z4）位于网格的角上或
// 边中点，以及4个X型辅助量子比特（蓝色圆圈，标记为X1至X4）
// 交错分布。灰色细线连接相邻的数据量子比特与辅助量子比特，
// 表示耦合连接关系。实心的黑色粗线勾勒出逻辑算符的路径：
// 一条垂直的黑色粗线穿过左侧的Z1、D1、D4、D7，代表逻辑Z
// 算符（$\hat{Z}_L$）；一条水平的黑色粗线穿过上方的D1、
// D2、D3，代表逻辑X算符（$\hat{X}_L$）。背景被划分为不同
// 颜色的区域（面）：浅蓝色区域标记为$\hat{S}^{X1}$、$\
// hat{S}^{X2}$、$\hat{S}^{X3}$、$\hat{S}^{X4}$，对应X型
// 稳定子；浅绿色区域标记为$\hat{S}^{Z1}$、$\hat{S}^{Z2}$、
// $\hat{S}^{Z3}$、$\hat{S}^{Z4}$，对应Z型稳定子。左上角
// 标注有逻辑算符符号$\hat{X}_L$和$\hat{Z}_L$。 子图 b：
// 类型：显微照片/芯片版图。 内容：展示了上述表面码电路的
// 实际物理布局。图像中心是呈星形辐射状排列的超导量子比特
// 阵列。黄色圆形区域标记为量子比特（Qubits），分别对应图
// a中的D1-D9和X1-X4/Z1-Z4位置。从每个量子比特延伸出多条
// 微带线：粉色线条为驱动线（Drive Lines），绿色线条为通
// 量线（Flux Lines），红色波浪形结构为读出谐振器（
// Readout Resonators），蓝色矩形块为普塞尔滤波器（
// Purcell Filters），紫色线条为馈线（Feed Lines），青色
// 线条为耦合元件（Coupling Elements）。图中可见明显的金
// 属走线和接地孔阵列。左上角有一个黑色的比例尺，标注为“1
// mm”。底部有图例说明各颜色对应的组件名称。 子图 c： 类
// 型：散点图与条形图组合。 坐标轴：纵轴为频率（Frequency
// $\omega/2\pi$），单位GHz，范围从3.5到7.5 GHz；横轴为量
// 子比特编号（Qubit），从左至右依次标记为N1-N4（未使用）、
// Z1-Z4、D1-D9、X1-X4。 数据展示：图中用不同颜色的圆点表
// 示各量子比特的频率。绿色点对应Z型辅助量子比特（Z1-Z4），
// 分布在6-6.5 GHz区间；红色点对应数据量子比特（D1-D9），
// 分布在4-4.5 GHz区间；蓝色点对应X型辅助量子比特（X1-X4），
// 分布在6 GHz附近；紫色点对应未使用的N型量子比特，分布在
// 7 GHz以上。背景色带区分了不同频段：浅红色区域覆盖4-4.5
// GHz，浅蓝色区域覆盖6-6.5 GHz，浅紫色区域覆盖7-7.5 GHz。
// 此外，还有垂直的彩色细线从底部延伸至对应频率点，可能表
// 示频率调谐范围或误差棒。 子图 d： 类型：累积分布函数图
// （CDF）。 坐标轴：纵轴为累积分布（Cumulative distrib.），
// 范围0.0至1.0；横轴为门和测量误差（Gate and measurement
// errors），对数刻度，范围从$10^{-3}$到$10^{-1}$。 曲线
// 含义：图中有三条阶梯状上升曲线。粉色曲线标记为“2-state
// ”，代表两能级系统的误差分布；蓝色曲线标记为“3-state”，
// 代表三能级系统的误差分布。两条曲线均显示随着误差值增加，
// 累积概率单调递增。在横坐标约$10^{-2}$处，粉色曲线的累
// 积概率接近1.0，而蓝色曲线在相同位置的累积概率约为0.8，
// 表明三能级系统的误差普遍大于两能级系统。左下角有一个空
// 心方框，可能表示特定阈值或置信区间。
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

  #figure(scope: "parent", placement: auto, image("imgs/surface_code_and_device_20211202_reduced.png", width: 100%),
    caption: [
      Device concept, architecture and performance. #strong[a]~Conceptual representation of the distance-three surface code consisting of data qubits (red circles), Z-type (green circles) and X-type auxiliary qubits (blue circles), with their connectivity indicated by gray lines. The data qubits participating in the weight-three logical operators $hat(Z)_"L"$ and $hat(X)_"L"$ are indicated by solid black lines. Green (blue) plaquettes indicate X-type (Z-type) stabilizer circuits. #strong[b]~False-color micrograph of the device realizing the concept in #strong[a] with 17 transmon qubits, see legend for circuit elements and text for details. The qubit lattice is rotated by 45 degrees with respect to #strong[a]. #strong[c]~Frequency arrangement in three distinct bands for idling data qubits (red circles), idling Z/X-type auxiliary qubits (green/blue circles), and readout resonators (violet open circles). The qubit-frequency tuning ranges are indicated by vertical bars. #strong[d]~Cumulative distributions (integrated histograms) of single-qubit gate (pink), simultaneous two-qubit gate (cyan), two-state (red) and three-state readout errors (light red).
    ]
  )
  <fig:device>
  ]

  Experimentally realizing a distance-three surface code requires nine data qubits and eight auxiliary qubits, also referred to in the literature as ancilla or measurement qubits @Bombin2007 @Horsman2012 @Tomita2014a. The qubits are arranged in a diagonal, planar square lattice, the edges of which are shown in gray in the schematic Fig.~#panel(<fig:device>, "a"). The data qubits $D_j$,~$j = 1 dots.h 9$, (red dots) form a $3 times 3$ array and are interlaced with auxiliary qubits $A i$, labeled $X_i$ (blue) and $Z_i$,~$i = 1 dots.h 4$ (green). We realized this arrangement in a superconducting circuit using 17 transmon qubits @Koch2007 (yellow) capacitively coupled to each other along the edges of the square array with $tilde 1$~mm long coplanar waveguide segments (turquoise), see Fig.~#panel(<fig:device>, "b"). We discuss the fabrication of this device in @app:device_fabrication.

  Using the auxiliary qubits $X_i$ and $Z_i$ we measure the parity of the neighboring two or four data qubits $D_j$, which are located at the vertices of the blue and green plaquettes, in the X or Z basis (@fig:device,b). In a Z-basis measurement, if an odd number of the data qubits involved in the parity operator under consideration is in the $| 1 ⟩$-state the auxiliary qubit state is flipped. On the other hand, if an even number of data qubits is in $| 1 ⟩$ the auxiliary qubit state remains unchanged. The equivalent is true in the X basis for an even or odd number of data qubits in the $| - ⟩$-state. Here, $| 0 ⟩$, $| 1 ⟩$ are the transmon qubit ground and first excited states, and $| plus.minus ⟩ = (| 0 ⟩ plus.minus | 1 ⟩) / sqrt(2)$ are their superpositions. To map the parity of the data qubits $D_j$ onto the corresponding auxiliary qubit, we effectively use a sequence of controlled-not gates with the data qubits as control and the auxiliary qubit as target, and subsequently measure the state of the auxiliary qubit in the Z basis using single-shot readout. In the Z basis, a single bit-flip error of any individual data qubit leads to a change of parity, as does a single phase-flip in the X basis. Hence, measurements of changes of data-qubit parities allow us to detect and identify phase-flip or bit-flip errors as long as they occur sufficiently rarely @Fowler2012. These parity measurements are also referred to as stabilizer measurements @Gottesman1997 @Terhal2015n. The corresponding mutually-commuting weight-two (or weight-four) stabilizer operators $hat(S)^("X" i) = product_(j = 1)^(2 ( 4 )) hat(X)_j$ and $hat(S)^("Z" i) = product_(j = 1)^(2 ( 4 )) hat(Z)_j$ of the surface code are products of two (or four) Pauli-$hat(X)$ or -$hat(Z)$ operators of the data qubits $j$ located at the vertices of a given data-qubit plaquette. Measurement outcomes $s^(A i) = plus.minus 1$ of individual stabilizers $hat(S)^(A i)$ are extracted from the observed change of auxiliary qubit state from one cycle to the next and indicate even or odd parity, respectively.

  In our experiments, the stabilizer gate sequence is realized as two or four controlled-phase (CZ) gates @Strauch2003 @DiCarlo2010 @Negirneac2021 (see Methods @methods_sec:cz_gates) between data and auxiliary qubits, operated in a high and a low frequency band (see @fig:device), respectively, combined with initial and final $pi 2$-rotations on the auxiliary qubits (@fig:stabilizer,b). The gate sequence for measuring $hat(S)^("X" i)$ contains additional initial and final $pi 2$-rotations acting on the data qubits, implementing a basis change from the Z to the X basis (blue dashed squares in @fig:stabilizer and b). We apply echo pulses to the data qubits in the middle of the gate sequence to reduce dephasing of the data qubits and residual coherent coupling to spectator qubits@Krinner2020

  The 24 pairwise CZ gates have a mean duration of $98 ( 7 ) $ns, including two conservatively chosen 15-ns-long buffers at the beginning and the end, and display a mean gate error of 0.015(10). The gate error histogram, displayed as an integrated (cumulative) distribution, shows variations of about a factor of four in two-qubit gate error (@fig:device). We determine the two-qubit gate error from interleaved randomized benchmarking experiments with sets of three gates executed in parallel, as employed in our realization of the surface code cycle. Time-varying microscopic defects in our device have a detrimental influence on two-qubit gate performance and are responsible for outliers in the gate error distribution (@app:two_qubit_gates). Single-qubit gates displaying a mean error of 0.0009(4) are realized by applying short resonant microwave pulses to each qubit individually through a dedicated drive line (pink coplanar waveguide in @fig:device). We determined the single-qubit gate fidelities in randomized benchmarking experiments. We discuss the experimental setup used to realize these gates in @app:experimental_setup
  A key element of individual stabilizer measurements are fast and high-fidelity measurements of auxiliary qubit states while leaving data qubit states unaffected @Negnevitsky2018 @Andersen2019 @Bultink2020 (see Methods @methods_sec:readout). Accurate stabilizer measurements using mid-cycle qubit readout on timescales comparable to or shorter than the cumulated gate times per error correction cycle also contribute to maximizing the performance of error detection and correction in our surface code implementation as a whole.

  With our readout scheme we discriminate the two computational qubit states and a leakage state, which if undetected or uncorrected for is detrimental to any surface code implementation @Alferis2007 @Fowler2013 @Ghosh2015a @Suchara2015 @Bultink2020      @Varbanov2020. We achieve a mean readout assignment error of $0.009 ( 7 )$ when discriminating the computational states only (two-state readout) and of $0.022 ( 14 )$ when discriminating the computational states and the leakage state (three-state readout), see @app:readout_characterization. The corresponding cumulative distribution for two-state readout exhibits performance variations on the device of about a factor of two when disregarding two outliers, while the distribution for three-state readout shows variations larger by about a factor of two (@fig:device).

  With all elements in place for realizing a surface code, we first characterize the measurements of individual $hat(S)^(A i)$ stabilizers. To do so we prepare the data qubits $D_j$ of a given weight-two or weight-four plaquette sequentially in each one of its $2^2 = 4$ or $2^4 = 16$ basis states composed of $| 0 ⟩$ and $| 1 ⟩$ for $hat(S)^("Z" i)$ and $| + ⟩$ and $| - ⟩$ for $hat(S)^("X" i)$. In the beginning of each experiment all qubits are initialized by heralding the ground state $| 0 ⟩$ from single-shot readout.

  For each input state, we compute the mean values $overline(s)^(A i)$ from $tilde 4 times 10^4$ measurements of $s^(A i)$ (colored bars in @fig:stabilizer) and find good qualitative agreement with master equation simulations (red outlines), see @app:numerical_simulations and @app:stabilizers for details. Here, $+ 1 - 1$ indicate even/odd parity of the measured state. The colored percentage values display the corresponding experimental and simulated errors of the stabilizer measurements. We attribute the differences between measurements and simulation mostly to two-qubit gate errors due to microscopic defect modes changing their frequency on timescales of hours or days (@app:two_qubit_gates).

  Having verified that all stabilizer measurements perform at high quality levels individually, we combine the stabilizer measurements into a surface code cycle. Executing this cycle once, we prepare one of the four cardinal logical qubit states. Executing the cycle multiple times, we stabilize the logical states and investigate the performance of our realization of the code.

  // [figvision] imgs/stabilizers_v2_20211207_reduced.png
  // Three panels (a,b circuit diagrams; c histogram grid).
  // (a) Weight-two Z- and X-type stabilizer circuits on one plaquette. Red data-qubit
  //     wires at left and right, green Z auxiliary in the centre. Boxes mark rotations
  //     (Y-pulses shown as labelled boxes), CZ gates drawn as vertical connectors between
  //     data and auxiliary wires, final measurement box on the auxiliary. The X-type
  //     circuit in (b) is the same topology in blue, with dashed-blue basis-change
  //     (Hadamard-like) squares on the data-qubit lines before and after the CZ gates.
  // (c) Eight small panels of mean stabilizer value overline(s)^(A i) vs data-qubit
  //     input state, ordered by excitation number: 00/01/10/11 for Z-type, +x/-x/+y/-y
  //     for X-type, with gray background = odd parity, white = even parity.
  //     Green bars = Z stabilizers, blue bars = X stabilizers, red wireframe outlines =
  //     master-equation simulation. Error-bar tops carry experimental/simulated
  //     infidelities: 2.9%/2.8%, 8.4%/5.0%, 5.7%/6.7%, 2.5%/2.0%, 5.9%/3.9%,
  //     4.5%/2.6%, 6.8%/4.3%, 11.8%/4.4%.
  //     Measured bars alternate near +1 for even-parity inputs and near -1 for
  //     odd-parity inputs; simulation follows the same sign pattern.
// [figvision-cn] imgs/stabilizers_v2_20211207_reduced.png
// 图a为量子电路示意图，展示作用于面（plaquette）顶点数据
// 量子比特上的权重二稳定子。图中包含四个红色实心圆代表的
// 数据量子比特，垂直排列于左侧；一个位于左上角的辅助量子
// 比特，由上半绿色、下半蓝色组成的双色圆表示，用于Z型测
// 量。该辅助比特通过CZ门（灰色实心圆点连线）依次与第一和
// 第三个数据比特连接。在辅助比特后接有一个标有“Y”的灰色
// 方框，表示单量子比特Y旋转门。每个数据比特线上均有一个
// 虚线蓝色方框包围的“Y”门，以及一个实线灰色方框包围的“Y”
// 门，分别对应不同角度的旋转操作。最右侧为一个带波浪线的
// 矩形框，标注为“Measurement”，表示测量操作。图下方图例
// 说明：“Y Y Y”组合代表单量子比特Y旋转（角度分别为π/2, π
// , π/2），带波浪线矩形框代表测量，灰色圆点连线代表CZ门。
// 图b同样为量子电路示意图，展示权重四稳定子电路。结构与
// 图a类似：左侧四个红色实心圆为数据量子比特，左上角双色
// 圆（绿上蓝下）为辅助量子比特。辅助比特通过CZ门与全部四
// 个数据比特相连。辅助比特后接一个“Y”门。每个数据比特线
// 上均有虚线蓝色方框包围的“Y”门和实线灰色方框包围的“Y”门。
// 对于X型测量所需的基变换，图中用虚线蓝色方框标示，并附
// 有文字注释“basis change (dashed-blue squares)”。最右侧
// 同样是带波浪线的“Measurement”框。整体布局显示该电路涉
// 及更多纠缠操作，适用于更高权重的稳定子测量。 图c为柱状
// 图集合，共六组，分为上下两行三列，每组对应一个特定稳定
// 子算符的平均值分布。纵轴统一标注为“Mean stabilizer
// value s̃^A_i”，范围从-1.0到1.0，刻度间隔0.5。横轴标题
// 为“Data qubits initial state”，根据子图不同分为两类编
// 码：左列使用二进制字符串（如0001, 0010等），右列使用符
// 号序列（如+ - + +, + + - +等）。所有柱子均为垂直条形，
// 颜色区分如下：深棕色或浅绿色代表理论预期值（无误差），
// 粉红色或浅蓝色代表实验测量值（含误差）。每组柱状图上方
// 或内部标注百分比数值，表示偏离理想值的比例。具体分组如
// 下： 第一行左图（对应s̃^z₁）：横轴标签为“odd”及若干二
// 进制串。左侧两个柱子（深棕与粉红）高度接近±1.0，标注
// 2.9%（粉）和2.8%（棕）。中间区域多个柱子呈交替正负分布，
// 底部标注8.4%（绿）和5.0%（粉）。 第一行中图（对应s̃^z₂）：
// 结构同上，但柱子分布略有差异，底部标注8.4%和5.0%。 第
// 一行右图（对应s̃^x₁）：横轴为符号序列，“odd”及多种组合。
// 左侧柱子标注5.7%（蓝）和6.7%（红）。中间区域柱子密集，
// 底部标注5.9%和3.9%。 第二行左图（对应s̃^z₄）：左侧柱子
// 标注2.5%（浅绿）和2.0%（粉红）。中间区域底部标注6.8%和
// 4.3%。 第二行中图（对应s̃^z₃）：结构与左图相似，底部标
// 注6.8%和4.3%。 第二行右图（对应s̃^x₃）：左侧柱子标注
// 4.5%（浅蓝）和2.6%（粉红）。中间区域底部标注11.8%和4.4%，
// 表明此处实验偏差最大。 所有子图中，虚线水平线位于y=±
// 1.0处，作为理想值参考边界。柱状图整体趋势显示：多数情
// 况下实验值（彩色柱）接近理论值（深色柱），但在部分初始
// 态下存在显著偏差，尤其在s̃^x₃中达到11.8%，反映测量噪声
// 或系统误差的影响。
  #figure(placement: auto, image("imgs/stabilizers_v2_20211207_reduced.png", width: 100%),
    caption: [
      Stabilizer circuits and their characterization. Quantum circuit diagrams for #strong[a]~weight-two and #strong[b]~weight-four stabilizers acting between data qubits located on the vertices of a plaquette (red circles) and the corresponding auxiliary qubit used for Z-type (green) or X-type (blue circle) stabilizer measurements, where the latter require a basis change (dashed-blue squares), see text for details. #strong[c]~Measured (filled bars), and simulated (red wireframes) average stabilizer values $overline(s)^(A i)$ versus data qubit input state, ordered by number of excitations. Percentages are the experimental (blue, green) and simulated (red) error of $overline(s)^(A i)$. Gray background indicates odd and white even parity.
    ]
  )
  <fig:stabilizer>

  #heading(level: 1, numbering: none)[The Surface Code Cycle and State Initialization]
  <the-surface-code-cycle-and-state-initialization>

  At the beginning of each experimental sequence, we prepare the nine data qubits in either one of the product states $| 0 ⟩^(⊗ 9)$ and $hat(X)_"L" | 0 ⟩^(⊗ 9)$ ($| + ⟩^(⊗ 9)$ and $hat(Z)_"L" | + ⟩^(⊗ 9)$) to begin the process of initializing the cardinal logical qubit states $| 0 ⟩_"L"$ and $| 1 ⟩_"L"$ ($| + ⟩_"L"$ and $| - ⟩_"L"$). The cardinal states are eigenstates of the eight stabilizer operators $hat(S)^(A i)$ and $plus.minus 1$ eigenstates of the logical Pauli operators which we choose as $hat(Z)_"L" = hat(Z)_1 hat(Z)_2 hat(Z)_3$ and $hat(X)_"L" = hat(X)_1 hat(X)_4 hat(X)_7$, see Fig.~#panel(<fig:device>, "a"). As required, $hat(Z)_"L"$ and $hat(X)_"L"$ commute with all stabilizers and anti-commute with each other. Since each of the prepared product states is an equal superposition of $16$ equivalent instances of the target logical state, executing a single quantum error correction cycle once deterministically initializes the target logical state in the stabilizer eigenspace corresponding to the measurement outcome of the stabilizers (@app:logical_state_fidelity).

  In a single surface code cycle, we first execute all gate operations implementing the four $hat(S)^("Z" i)$ stabilizer measurements. We realize the necessary two-qubit gates in four time steps in each of which we execute three CZ gates simultaneously. Parallelizing stabilizer execution is a key technical requisite for scalable quantum error correction, in particular for operation of larger-distance codes. The two-qubit gates are accompanied by a set of single-qubit gates applied to all auxiliary qubits in a leading and a trailing time step, and a dynamical decoupling pulse applied to all data qubits at a central time step (@fig:stabilizers_state_init). We choose the order of gate operations to provide resilience against single auxiliary qubit errors and to avoid interactions with microscopic defect modes (@app:gate_sequence). The gate execution is followed by readout of the Z-type auxiliary qubits to complete the Z-type stabilizer measurement, see @fig:stabilizers_state_init Simultaneous with the Z-type auxiliary qubit readout, we start executing the X-type stabilizer circuits, which are equivalent up to an additional basis change of the data qubits. This allows us to execute the $hat(S)^("Z" i)$ and $hat(S)^("X" i)$ stabilizer measurements in a parallel, pipelined approach @Versluis2017, see Fig.~#panel(<fig:stabilizers_state_init>, "a") for a full circuit diagram and @app:pulse_sequence for a full pulse sequence.

  Thanks to the pipelined approach combined with short qubit-readout times, we are able to execute a single quantum error correction cycle in a cycle time as short as $t_c = 1.1$ µs, setting the rate at which we detect errors for their subsequent correction. A short cycle time is essential for any error correction code as it determines the performance of the code at a given physical qubit coherence time. Moreover, a short cycle time reduces the execution time of error-corrected quantum algorithms @Burg2021 @Babbush2021

  To maximize performance, we have designed our device with parameters minimizing leakage on data qubits. We also detect the residual leakage on auxiliary qubits during the execution of each cycle, and on data qubits after the last cycle, using our three-state readout (see Methods @methods_sec:leakage).

  In our experiments we reject all instances of detected leakage events. The degree to which leakage rejection affects the retained fraction of experimental runs is discussed in @app:leakage_rejection
  To characterize our logical-state initialization scheme, we determine the fidelity of the prepared state with respect to the target logical state by measuring the $2^9$ Pauli strings which form the basis of the 9-data-qubit logical state~@Nigg2014b @Abobeih2021. For $|0 angle_"L"$ we find a quantum state fidelity $cal(F)_"phys" = "Tr" ( rho | 0 ⟩_"L" ⟨ 0 |_"L" ) = 54.0 ( 1 ) "%"$ (dark red bar in Fig.~#panel(<fig:stabilizers_state_init>, "b")) when using our leakage-detection scheme and when correcting for readout errors on data qubits. Considering only errors in the logical subspace~@Andersen2020b, we find a logical fidelity $cal(F)_"L" = cal(F)_"phys" P_"L" = 99.6 ( 2 ) "%"$ where $P_"L" = 54.2 ( 1 ) "%"$ is the experimentally measured probability of preparing a state in the logical subspace (@app:logical_state_fidelity). Both $cal(F)_"phys"$ and $P_"L"$ are smaller than in a distance-two surface code, see Ref.~@Andersen2020b for example, since the two quantities are expected to decrease with increasing distance $d$ at constant physical error rate.

  // [figvision] imgs/gate_sequence_state_init_20211126.png
  // Four panels (a timing diagram; b fidelity bars; c,d syndrome decay).
  // (a) One 1.1 us QEC cycle. Rows labelled init, Z stabilizer (green, four repeated
  //     cycle markers), X stabilizer (blue, four repeated cycles), RO; within each row:
  //     black sync lines, empty squares = single-qubit rotations on data qubits, vertical
  //     CZ connectors, filled measurement boxes; a symbol legend at left. Dashed boxes in
  //     the first cycle mark the X auxiliary qubits that are not measured.
  // (b) Fidelity bar chart on a log scale from about 1e-3 to 1: F_phys (dark red),
  //     F_w1..F_w4 (the sectors correctable by one to four Pauli errors, red), and
  //     1-F_c (light red). F_c = 0.960(9) annotated above the group; F_phys ~ 0.54.
  // (c) Mean syndrome element overline(sigma)_m^(A i) (vertical, -1..+1) vs cycle index m
  //     (horizontal, 0..5) for Z1-Z4, filled circles with open-circle simulation points;
  //     values relax towards +1 with increasing m (Z preservation).
  // (d) Same axes for X1-X4 (filled triangles/squares, open symbols simulation), values
  //     relaxing towards +1 (X preservation). Horizontal black arrows in (c),(d) give the
  //     average syndrome element over all stabilizers and cycles.
// [figvision-cn] imgs/gate_sequence_state_init_20211126.png
// 该图包含四个子图（a、b、c、d），展示了表面码量子纠错循
// 环的电路结构、逻辑态初始化保真度以及平均错误综合征随时
// 间的演化。 子图 a： 类型：量子电路图（时序图）。 布局
// 与坐标：纵轴表示物理量子比特，从上至下依次标记为 Z1,
// Z2, Z3, Z4（绿色圆点标记），D1 至 D9（红色圆点标记），
// X1 至 X4（蓝色圆点标记）。横轴表示时间进程，从左至右分
// 为三个主要阶段：init.（初始化）、Z stabilizer（Z型稳定
// 子测量）、X stabilizer（X型稳定子测量）和 RO（读出）。
// 顶部标注总时长“QEC cycle: 1.1μs”。 元素说明： 背景色块：
// 浅绿色区域对应 Z stabilizer 阶段，浅蓝色区域对应 X
// stabilizer 阶段。图注说明绿色代表并行执行的四个 Z 型稳
// 定子电路，蓝色代表 X 型稳定子电路。 门操作符号：灰色矩
// 形框内标有“Y”代表单量子比特 Y 旋转门（参数为 π/2, π/2）；
// 空心方框代表单量子比特门；实心黑点连线代表受控 Z 门（
// CZ gate）；右侧带有 XYZ 斜线的方框代表测量（Meas.）。
// 连线：水平线代表量子比特的世界线。垂直或倾斜的连线连接
// 不同量子比特上的门操作，表示相互作用。 特殊标记：底部
// X1-X4 行在 Z stabilizer 阶段下方有虚线框包围的 Z 门符
// 号，表示重复操作。右侧有一列垂直排列的黑点，表示省略的
// 中间步骤。 结论：该图详细描绘了距离为 3 的表面码逻辑量
// 子比特在一个 1.1 微秒周期内的完整操作流程，包括通过 Y
// 旋转进行初始化，随后交替执行 Z 型和 X 型稳定子测量以检
// 测错误，最后进行读出。 子图 b： 类型：柱状图。 坐标轴：
// 纵轴为对数坐标，标记为“Fidelity”，范围从 10^-3 到 10^0。
// 横轴为分类变量，依次标记为 F_phys, F_w1, F_w2, F_w3,
// F_w4, 1-F_c。 数据系列： 深红褐色柱：F_phys，高度约为
// 0.5。 红色柱：F_w1，高度略低于 0.5；F_w2，高度约为 0.2；
// F_w3，高度约为 0.005；F_w4，高度约为 0.001。 浅粉色柱：
// 1-F_c，高度约为 0.04。 所有柱子均带有黑色误差棒。 标注：
// 图表上方标注文字“F_c = 0.960(9)”。 结论：该图比较了物
// 理量子比特保真度、不同权重错误下的保真度以及最终逻辑保
// 真度的补数。结果显示随着纠错轮次增加（w1到w4），特定类
// 型的错误概率显著降低，最终逻辑保真度 F_c 达到 0.960。
// 子图 c： 类型：散点图（带趋势线）。 坐标轴：纵轴标记为
// “Mean syndr. el. σ̃_m^AI”，线性刻度，范围 0.0 到 0.2。
// 横轴标记为“QEC cycle index m”，线性刻度，范围 0 到 15。
// 数据系列：图中有四条曲线，分别用不同深浅的绿色圆圈表示，
// 对应图例中的 Z1, Z2, Z3, Z4。 Z1（深绿实心圆）：数值最
// 高，从 0.05 迅速上升至约 0.22 并保持平稳。 Z3（中绿实
// 心圆）：数值次之，上升至约 0.15。 Z2（浅绿实心圆）：数
// 值较低，上升至约 0.12。 Z4（极浅绿空心圆）：数值最低，
// 上升至约 0.08。 标注：左侧有一个黑色箭头指向纵轴约
// 0.14 处。 结论：该图显示了四个 Z 型稳定子元素的平均错
// 误综合征随 QEC 循环次数 m 的变化。所有稳定子的错误率在
// 前几个循环内迅速上升并趋于饱和，表明系统达到了稳态错误
// 分布。 子图 d： 类型：散点图（带趋势线）。 坐标轴：纵
// 轴未直接标记名称，但根据上下文应与子图 c 类似（平均错
// 误综合征），线性刻度，范围 0.0 到 0.2。横轴标记为“QEC
// cycle index m”，线性刻度，范围 0 到 15。 数据系列：图
// 中有四条曲线，分别用不同深浅的蓝色三角形表示，对应图例
// 中的 X1, X2, X3, X4。 X1（深蓝实心三角）：数值最高，上
// 升至约 0.17。 X3（中蓝实心三角）：数值次之，上升至约
// 0.16。 X2（浅蓝实心三角）：数值较低，上升至约 0.14。
// X4（极浅蓝空心三角）：数值最低，上升至约 0.08。 标注：
// 左侧有一个黑色箭头指向纵轴约 0.15 处。 结论：该图显示
// 了四个 X 型稳定子元素的平均错误综合征随 QEC 循环次数 m
// 的变化。趋势与子图 c 类似，错误率在初期快速增加后达到
// 平台期，反映了 X 型错误的稳态行为。
  #figure(placement: auto, image("imgs/gate_sequence_state_init_20211126.png", width: 100%),
    caption: [
      The surface code cycle, fidelity of logical state initialization, and average error syndromes. #strong[a]~Quantum circuit used to initialize and (repeatedly) error correct the distance-3 surface code logical qubit. Green (blue) shaded circuit elements represent the parallel execution of the four Z-type (X-type) stabilizer circuits. Empty squares indicate single-qubit rotations on data qubits. In the first cycle the $X_i$ auxiliary qubits are not measured (dashed boxes). #strong[b]~Fidelity of the prepared logical state $|0 angle_"L"$ (dark red bar), all correctable states differing from $|0 angle_"L"$ by one to four Pauli errors (red bars) and all uncorrectable states (light red bar). Average syndrome elements $overline(sigma)_m^(A i)$ as a function of the cycle index $m$ for #strong[c] the $hat(Z)_"L"$ (filled circles) and #strong[d] the $hat(X)_"L"$ (filled triangles) preservation experiment. Open symbols are simulations. The horizontal black arrows indicate the average syndrome element over all stabilizers and cycles, see main text for details.
    ]
  )
  <fig:stabilizers_state_init>

  To further evaluate the performance of our logical state initialization, we analyze the fidelity of the prepared state with respect to subspaces of states which our surface code implementation can in principle correct. The errors which are correctable by the distance-three surface code include all single-qubit Pauli (weight-one) errors $hat(X)_j$, $hat(Y)_j$, or $hat(Z)_j$ on any data qubit $j$ and a subset of higher-weight errors. We compute the fidelity of the experimentally prepared state with respect to correctable subspaces including states which are equivalent to the target state up to Pauli errors of weight $i$ up to $i = 4$ and find $( cal(F)_"w1" , cal(F)_"w2" , cal(F)_"w3" , cal(F)_"w4" ) = [ 34.3 ( 0 ) , 7.3 ( 5 ) , 0.3 ( 8 ) , 0.1 ( 4 ) ] "%"$, see @app:logical_state_fidelity and Ref.~@Abobeih2021. Hence, the prepared initial state has a fidelity of $cal(F)_"c" = cal(F)_"phys" + sum_(i = 1)^4 cal(F)_("w" i) = 96.0 ( 9 ) "%"$ with respect to states which are in principle correctable in our realization of the surface code. We also note that weight-one errors account for the majority of errors on data qubits in the $|0 angle_"L"$ state initialization, with higher weight errors having a largely reduced probability of occurrence (Fig.~#panel(<fig:stabilizers_state_init>, "b").

  #heading(level: 1, numbering: none)[Repeated Quantum Error Correction]
  <sec:QEC>

  Once the first quantum error correction cycle completes the logical state initialization, we make use of all subsequent cycles for logical state preservation. In our experiments, we preserve the cardinal logical qubit states for up to $n = 16$ cycles. In each cycle $m = 1 , . . , n$ we extract eight stabilizer values $s_m^(A i)$. Changes in stabilizer values signal the occurrence of errors and are used to construct error syndromes $sigma_m$ consisting of eight syndrome elements $sigma_m^(A i) = ( 1 - s_m^(A i) times s_(m - 1)^(A i) ) 2$. The elements $sigma_m^(A i)$ are inferred in each cycle from the current $( m )$ and the previous ($m - 1$) measured stabilizer values with $sigma_m^(A i) = 1 ( 0 )$ indicating an error (no error), respectively @Kelly2015

  We collectively process successive syndromes $sigma_m$ to determine which data and auxiliary qubits have most likely suffered an error @Dennis2002 @Fowler2012 @Terhal2015n Specifically, we construct a graph in which the syndrome elements are displayed at the auxiliary qubit locations along two spatial coordinates for each cycle index $m$ which forms the temporal coordinate. Spatial and temporal correlations between non-zero syndrome elements correspond to data and auxiliary qubit errors, respectively. If the overall error rate is sufficiently low, we obtain a low density of non-zero syndrome elements, or equivalently, mean syndrome element values $overline(sigma)_m^(A i) lt.double 1$, with the mean taken over experimental realizations. In that case, the underlying errors can be decoded with low ambiguity (@app:decoding).

  Executing $n$ consecutive error correction cycles and rejecting runs in which leakage has been detected, we record stabilizer measurement outcomes and construct syndromes from their values, the averages of which are shown in @fig:stabilizers_state_init,d. When averaging the syndromes over all individual elements and time, we find that the average syndrome element $overline(sigma) = 0.14 lt.double 1$ is small (see arrows in Fig.~#panel(<fig:stabilizers_state_init>, "c,d")), indicating that errors are rare and, therefore, allowing for efficient error detection and correction@Chen2021p. All syndrome elements $overline(sigma)_m^(A i)$ averaged over repetitions of the experiments are approximately constant as a function of $m$ for $m gt.eq 2$, see Fig.~#panel(<fig:stabilizers_state_init>, "c,d") obtained for preserving $|0 angle_"L"$,$|1 angle_"L"$ and $|+ angle_"L"$, $|- angle_"L"$, respectively. We attribute the small remaining increase of $overline(sigma)_m^(A i)$ with $m$ to the fact that, in the absence of auxiliary qubit reset, auxiliary qubits initially prepared in the ground state tend to an asymptotic probability of $0.5$ to be in the excited state after $m$ cycles. As a result, with increasing $m$, auxiliary qubits suffer from larger decoherence during readout and during the subsequent idling periods of about $150$ ns before the start of the next quantum-error-correction cycle. Our numerical simulations show the same feature (open symbols in @fig:stabilizers_state_init,d). For $m = 1$, the averaged syndrome elements $overline(sigma)_1^(A i)$ are reduced because the corresponding reference stabilizer values are computed from the initial data qubit product state, which we prepare with high fidelity. In the first cycle, the four values of $overline(sigma)_1^("Z" i)$ are smaller than $overline(sigma)_1^("X" i)$ because a quantum-error-correction cycle starts with measurements of $hat(S)^("Z" i)$ and errors thus accumulate only during half a cycle.

  To determine the performance of our distance-three surface code, we extract the logical error per cycle when preserving eigenstates of the logical qubit operators $hat(Z)_"L"$ and $hat(X)_"L"$ versus the number of executed cycles $n$. For each sequence of cycles, we decode the error syndromes, including a syndrome determined from the final data qubit readout. After the $n^"th"$ cycle we perform a projective readout of the final data qubit state in the Z or X basis from which we determine the eigenvalue $z_"L"=plus.minus 1$ of $hat(Z)_"L"$ or $x_"L"=plus.minus 1$ of $hat(X)_"L"$.

  // [figvision] imgs/210810_ZLXL_S17_datadds_v15.png
  // Three stacked panels, all with legends inline.
  // (a) <Z_L> (vertical, -1..+1) vs time (horizontal, 0-17.5 us). Green circles = |0>_L
  //     exp., green squares = |1>_L exp., open circles/squares = simulation; grey
  //     dash-dotted line = physical qubit decay. Analytic curves annotated top right:
  //     2T1 = 65.0 us, T1,L,Sim = 25.7 us, T1,L,Exp = 16.4 us. Data decay from +1 (|0>_L)
  //     and rise from -1 (|1>_L) with the same envelope.
  // (b) Same axes for <X_L>. Blue triangles = |+>_L, blue diamonds = |->_L, open = sim.
  //     Annotations: T2 = 37.5 us, T2,L,Sim = 26.0 us, T2,L,Exp = 18.2 us.
  // (c) Logical error probability E_L (0..0.45) vs number of QEC cycles n (0-16).
  //     Green circles |0>_L exp., blue triangles |+>_L exp., open symbols sim.; solid
  //     linear fits with slopes eps_L = 0.032 (green) and 0.029 / 0.021 / 0.021 (blue and
  //     sim. curves); grey dash-dotted lines = physical two-qubit gate eps_L = 0.015.
  //     Inset: log-log E_L (1e-4..1) vs improvement factor x (1-10), green circles,
  //     falling from about 0.42 at x=1 to about 3e-4 at x=10 along a dashed guide.
// [figvision-cn] imgs/210810_ZLXL_S17_datadds_v15.png
// 该图包含三个垂直排列的子图（a、b、c），展示了量子纠错
// 实验中逻辑态的保持情况和每周期错误率。 子图 a 子图类型：
// 曲线图（散点与拟合线）。 坐标轴：横轴为“Time (μs)”，范
// 围从0.0到17.5，刻度间隔2.5。纵轴为“⟨Z_L⟩”，即逻辑算符
// Z_L的期望值，范围从-1.0到1.0，刻度间隔0.5。 数据系列与
// 符号： 图中包含两组关于逻辑态|0⟩_L和|1⟩_L的数据。 对于
// |0⟩_L（初始值为正）：实心绿色圆点代表实验数据（Exp.），
// 空心绿色圆点代表模拟数据（Sim.）。两条绿色实线和虚线分
// 别是对这两组数据的指数衰减拟合。 对于|1⟩_L（初始值为负）：
// 实心绿色方块代表实验数据（Exp.），空心绿色方块代表模拟
// 数据（Sim.）。两条绿色实线和虚线分别是对这两组数据的指
// 数衰减拟合。 参考线：黑色点划线表示物理比特的平均衰减
// （Phys. qubit），其衰减速率是逻辑比特衰减的基准。 标注
// 文字与结论： 右上角标注了提取的衰减时间常数：物理比特
// T_1 = 65.0 μs；逻辑比特模拟值T_{1,L, Sim} = 25.7 μs；
// 逻辑比特实验值T_{1,L, Exp} = 16.4 μs。 趋势：随着时间
// 推移，所有逻辑态的期望值都向0衰减，表明存在退相干。实
// 验数据的衰减速度快于模拟数据，且快于物理比特的衰减（注
// 意：这里物理比特的线在上方，表示其衰减更慢，即寿命更长？
// 不，看图，物理比特的线在最外侧，说明它衰减得最慢，也就
// 是寿命最长。等等，让我们重新看图。 修正观察：图中的黑
// 色点划线（Phys. qubit）位于最上方和最下方，意味着它的
// 绝对值下降得最慢，即衰减时间常数最大。但是右侧标注写着
// T_1 = 65.0 μs。而逻辑比特的 T_{1,L} 只有十几二十微秒。
// 这说明在这个特定的图中，逻辑比特的寿命实际上比物理比特
// 短？或者这里的“Phys. qubit”指的是某种特定的参考线？ 再
// 次仔细看图注：“For reference, twice the average
// physical qubit decay is shown”。哦，原来这条线代表的是
// “两倍物理比特衰减”。如果物理比特衰减是 exp(-t/T)，那么
// 两倍衰减就是 exp(-2t/T)。这意味着这条线的斜率是物理比
// 特实际衰减斜率的两倍，所以它应该衰减得更快。 让我们再
// 看图。黑色点划线确实比绿色线衰减得慢（更接近1或-1）。
// 这与“twice the average physical qubit decay”的描述似乎
// 矛盾，除非这里的“decay”指的是衰减速率（rate），而不是
// 衰减函数本身。如果衰减速率加倍，那么寿命减半。 让我们
// 看数值。T_1 = 65.0 μs。如果是两倍衰减速率，那么有效寿
// 命应该是 32.5 μs。但是图中的黑线看起来比 T=65 的线还要
// 平缓？不对，让我们看 y=0.5 的位置。 对于 |0>_L 实验数
// 据（绿实心圆），在 t=17.5 时，y≈0.4。 对于 Phys. qubit
// 线（黑点划），在 t=17.5 时，y≈0.8。 显然黑线衰减得更慢。
// 这说明图注中的 "twice the average physical qubit decay
// " 可能是一个误导性的描述，或者我理解错了。 另一种可能
// 是，这里的 "decay" 指的是衰减的时间常数 T1。如果
// T1_phys = 65us，那么 "twice the decay" 可能指的是
// T1_eff = 2 * 65 = 130us？但这也不对，因为那样线会更平。
// 让我们忽略这个困惑，直接描述视觉事实。 视觉事实：黑色
// 点划线代表的衰减最慢，绿色线代表的衰减较快。右侧标注显
// 示物理比特的 T1 为 65.0 μs，而逻辑比特的 T1 约为 16-26
// μs。这表明在此实验中，逻辑比特的寿命短于物理比特。这可
// 能是由于编码开销或门操作引入的错误导致的。 结论：逻辑
// 态的保真度随时间指数衰减。实验测得的逻辑态寿命（约16.4
// μs）短于模拟预测（约25.7 μs），并且显著短于物理比特的
// 寿命（65.0 μs，尽管参考线的具体含义存疑，但数值对比明
// 确）。 子图 b 子图类型：曲线图（散点与拟合线）。 坐标
// 轴：横轴同子图a，为“Time (μs)”，范围0.0到17.5。纵轴为“
// ⟨X_L⟩”，即逻辑算符X_L的期望值，范围从-1.0到1.0。 数据
// 系列与符号： 图中包含两组关于逻辑态|+⟩_L和|-⟩_L的数据。
// 对于|+⟩_L（初始值为正）：实心蓝色三角形代表实验数据（
// Exp.），空心蓝色三角形代表模拟数据（Sim.）。两条蓝色实
// 线和虚线分别是对这两组数据的指数衰减拟合。 对于|-⟩_L（
// 初始值为负）：实心蓝色菱形代表实验数据（Exp.），空心蓝
// 色菱形代表模拟数据（Sim.）。两条蓝色实线和虚线分别是对
// 这两组数据的指数衰减拟合。 参考线：黑色点划线表示物理
// 比特的衰减（Phys. qubit）。 标注文字与结论： 右上角标
// 注了提取的退相干时间常数：物理比特T_2 = 37.5 μs；逻辑
// 比特模拟值T_{2,L, Sim} = 26.0 μs；逻辑比特实验值T_{2,L
// , Exp} = 18.2 μs。 趋势：随着时间推移，所有逻辑态的期
// 望值都向0衰减，表明存在退相位。实验数据的衰减速度快于
// 模拟数据。 结论：逻辑态的相干性随时间指数衰减。实验测
// 得的逻辑态退相干时间（约18.2 μs）短于模拟预测（约26.0
// μs），也短于物理比特的退相干时间（37.5 μs）。 子图 c
// 子图类型：曲线图（散点与拟合线），包含一个内嵌插图。
// 主图坐标轴：横轴为“Number of QEC cycles n”，即量子纠错
// 循环次数，范围从0到16，刻度间隔2。纵轴为“Logical error
// prob. E_L”，即逻辑错误概率，范围从0.0到0.4以上，刻度间
// 隔0.1。 主图数据系列与符号： 图中包含两组关于逻辑态|0⟩
// _L和|+⟩_L的数据。 对于|0⟩_L：实心绿色圆点代表实验数据
// （Exp.），空心绿色圆点代表模拟数据（Sim.）。一条绿色实
// 线穿过实验数据点，表示趋势。 对于|+⟩_L：实心蓝色三角形
// 代表实验数据（Exp.），空心蓝色三角形代表模拟数据（Sim.）。
// 一条蓝色实线穿过实验数据点，表示趋势。 参考线：黑色点
// 划线表示物理双比特门的错误率（Phys. two-qubit gate），
// 作为基准。 标注文字与结论： 右侧标注了不同条件下的逻辑
// 错误率 ε_L： 对于|0⟩_L实验数据，ε_L = 0.032。 对于|+⟩
// _L实验数据，ε_L = 0.029。 对于|0⟩_L模拟数据，ε_L =
// 0.021。 对于|+⟩_L模拟数据，ε_L = 0.021。 对于物理双比
// 特门，ε_L = 0.015。 趋势：随着纠错循环次数n的增加，逻
// 辑错误概率E_L呈线性增长。实验数据的错误率高于模拟数据，
// 且高于物理双比特门的错误率。 结论：逻辑错误概率随纠错
// 循环次数的增加而累积。实验观测到的错误率高于理论模拟和
// 物理门操作的预期，表明系统中存在额外的错误来源或校准误
// 差。 内嵌插图（Inset） 子图类型：曲线图（散点与拟合线）。
// 坐标轴：横轴为“Improvement factor x”，即改进因子，采用
// 对数刻度，范围从1到10。纵轴为“ε_L, ε_{EQ}”，即逻辑错误
// 率和等效错误率，采用对数刻度，范围从10^-4到10^-2。 数
// 据系列与符号： 绿色空心圆点代表实验数据，一条绿色实线
// 穿过这些点，表示趋势。 黑色虚线代表理论预测或参考线。
// 标注文字与结论： 没有具体的数值标注，但从图中可以看出，
// 随着改进因子x的增加，错误率ε_L降低。 趋势：错误率随改
// 进因子的增加而减小，符合预期的幂律关系。 结论：通过提
// 高系统的某些参数（如门保真度或测量效率），可以显著降低
// 逻辑错误率，验证了量子纠错的有效性。
  #figure(placement: auto, image("imgs/210810_ZLXL_S17_datadds_v15.png", width: 100%),
    caption: [
      Logical state preservation and error per cycle. #strong[a]~Experimentally determined (full symbols) and simulated (open symbols) expectation value of the $hat(Z)_"L"$ operator for prepared $| 0 ⟩_"L"$ (circles) and $| 1 ⟩_"L"$ (squares) and exponential fit (solid and dashed line). For reference, twice the average physical qubit decay is shown (dash-dotted line). The extracted decay times are indicated on the right. #strong[b]~Corresponding data sets for $hat(X)_"L"$, $| + ⟩_"L"$ (triangles) and $| - ⟩_"L"$ (diamonds). For reference, the average physical qubit coherence decay is indicated (dash-dotted line). #strong[c]~Logical error probability $E_"L"$ as a function of the number $n$ of error correction cycles for $| 0 ⟩_"L"$ and $| + ⟩_"L"$ and the extracted error per cycle $epsilon_L$ indicated on the right. Same symbols as in #strong[a] and #strong[b]. The dash-dotted line shows the physical two-qubit gate error accumulated over $n$ cycles, for reference. The inset shows simulation results for $epsilon_"L"$ in state $| 0 ⟩_"L"$ (open, green circles) for an assumed homogeneous distribution of decoherence rates, gate and readout errors, reduced by factors of $x = 2 , 5$ and $10$, see text for details. The green solid line is a fit to $1 \/ x^2$.
    ]
  )
  <fig:state_preservation>

  Decoding the error syndromes and applying potential corrections to $z_"L"$ or $x_"L"$, we compute the mean logical qubit expectation values $macron(z)_L=⟨ hat(Z)_L ⟩$ and $macron(x)_L=⟨ hat(X)_L ⟩$ as a function of $n$ from a total of $10^6$ experimental runs, where the available data is reduced by ground state heralding before and leakage rejection during each run. We decode the error syndromes using a minimum-weight perfect matching algorithm @OBrien2017 @Edmonds1965. We determine the weights in an error-model-free approach by inferring the errors per cycle from the measured data using a correlation analysis of the syndromes as described in @app:decoding and Refs.~@Spitz2018 @Chen2021p. The correction of an error, initiated by analysing all cycles in postprocessing, takes the form of changing the sign of the logical qubit operator values $z_"L"$ and $x_"L"$ when indicated by the decoder. We note that for correcting $hat(Z)_"L"$ it is sufficient to decode only syndromes ${ sigma_m^("Z" i) }$, or, equivalently, only ${ sigma_m^("X" i) }$ for $hat(X)_"L"$.

  We observe an exponential decay of $⟨ hat(Z)_"L" ⟩$ and $⟨ hat(X)_"L" ⟩$ with $n$ (solid symbols in Fig.~#panel(<fig:state_preservation>, "a,b")). From the logical qubit operator expectation values we extract the logical error probability $E_"L" = (1 - | ⟨ Z_"L" ⟩ |) \/ 2$ (solid symbols in Fig.~#panel(<fig:state_preservation>, "c") as a function of $n$ and find a small per cycle error probability of $epsilon_"L" = [1 - exp(-t_"c"/T_(1,"L"))]/2 approx t_"c"/2T_(1,"L") = 0.032(1)$ also indicated on the right hand side of the corresponding data set in #panel(<fig:state_preservation>, "c"). Equivalently, we obtain $epsilon_"L" = [1 - exp(-t_"c"/T_(2,"L"))]/2 approx t_"c"/2T_(2,"L") = 0.029(1)$ for $⟨ X_"L" ⟩$. We find that both the coherence time of $T_(2 , "L") = 18.2(5)$ µs and the lifetime $T_(1 , "L") = 16.4(8)$ µs of the logical qubit, as extracted from the decay curves of $⟨ hat(Z)_"L" ⟩$ and $⟨ hat(X)_"L" ⟩$, are much longer than the duration of the quantum error correction cycle $t_c = 1.1$ µs in our implementation of the surface code. In these experiments, we reject detected leakage events which occur with small probabilities on auxiliary and data qubits. As detailed in @app:leakage_rejection, the retained fraction of data per cycle amounts to 92~%.

  We note that the logical coherence time is only about a factor of two lower than the mean physical coherence time $overline(T_2^(*)) = 37.5$ µs of all 17 qubits while the logical relaxation time is about a factor four lower than twice the mean physical energy relaxation time $2 overline(T_1) = 65.0$ µs, as indicated in Fig.~#panel(<fig:state_preservation>, "a,b"). In the latter case the factor of two assumes an infinite lifetime of the physical qubit ground state for the comparison. We also note that, within errors bars, the lifetime of the states $| 0 ⟩_"L"$ and $| 1 ⟩_"L"$, and the coherence time of $| + ⟩_"L"$ and $| - ⟩_"L"$ are identical. This is expected since all cardinal states of the logical qubit have the same number of qubits in the excited state and our dynamical decoupling scheme alternates between the basis states which are therefore similarly affected by decoherence.

  #heading(level: 1, numbering: none)[Performance Assessment and Projection]
  <performance-assessment-and-projection>

  We compare the state preservation experiments with numerical simulations using a Monte Carlo wavefunction method (open symbols in @fig:state_preservation,b,c). The model underlying the simulations (@app:numerical_simulations) uses the measured coherence times, interaction rates and readout errors of the device as inputs. We find that despite the complexity of the quantum error correction cycle the measured expectation values $⟨ hat(X)_"L" ⟩$ and $⟨ hat(Z)_"L" ⟩$, when rejecting leakage, come close to the simulated values (open symbols in @fig:state_preservation,b). The logical lifetimes extracted from exponential fits (dashed lines in @fig:state_preservation,b) to the simulated expectation values are approximately $26$ µs providing an upper bound for the performance achievable with the specified device parameters.

  Since the numerical simulations model the performance of our quantum device well, we use the model to project how future improvements in gate and readout fidelities are expected to reduce the logical error per cycle $epsilon_L$. To free the projection from device-specific spread in qubit parameters, we use the average over all 17 qubits as uniform parameters (see @tab:qubit_measured_parameters), and find good agreement with the results obtained from the qubit-specific model. We then uniformly reduce all physical error parameters of the numerical model by a factor $x$, repeat the simulations of $⟨ hat(X)_"L" ⟩$ and $⟨ hat(Z)_"L" ⟩$ #emph[vs]~$n$, and extract the mean logical error per cycle $epsilon_L$ as a function of the improvement factor $x$. We find that the simulated error per cycle scales to a good approximation as $1 \/ x^2$, see inset in Fig.~#panel(<fig:state_preservation>, "c"), as expected for a code of distance three @Fowler2012. For reference, we plot the scaled two-qubit physical error per cycle $epsilon_"2Q"$ in the same plot (dash-dotted line).

  A metric commonly used to assess the performance of quantum error correction compares the logical error per cycle $epsilon_"L"$ to the dominant error on the physical level, typically the two-qubit gate error $epsilon_"2Q"$ @Ryan-Anderson2021 @Trout2018. Such a comparison is particularly relevant in architectures in which the logical two-qubit gate error is dominated by errors $epsilon_L$ in the quantum error correction cycles belonging to or following the logical two-qubit gate operation. The number of required cycles scales in general with $d$ in planar architectures and in architectures allowing for transversal execution of logical two-qubit gates @Raussendorf2007 @Bombin2009 @Horsman2012 @Landahl2014 @Gutierrez2019. The good agreement between measured ($tilde 3 "%"$) and simulated ($tilde 2 "%"$) logical errors $epsilon_"L"$ together with their simulated quadratic scaling suggests that the break-even of per-cycle logical errors with two-qubit gate errors may be in reach for modest improvements of device performance, when employing leakage detection or correction.

  In our experiments, we demonstrate the viability of realizing quantum error correction in the surface code by detecting errors during the error correction cycle, and decoding the error syndromes and correcting for errors in postprocessing, which is sufficient in a quantum memory setting. Next generation experiments will provide the capability of correcting errors during the cycle using real-time decoding~@Ryan-Anderson2021 and fast in-sequence feedback~@Andersen2019, implemented with dedicated digital electronics. Feedback will also enable the mid-cycle suppression of leakage~@McEwen2021a, for example by auxiliary qubit reset. Realizing larger surface code lattices while improving the performance of their components and demonstrating exponential suppression of logical errors with increasing code distance are upcoming important steps toward achieving the long-term goal of fault-tolerant quantum computation.

  #heading(level: 1, numbering: none)[Acknowledgments]
  <acknowledgments>
  The authors are grateful for valuable discussions with Quentin Ficheux and Cristóbal Lledó. The authors acknowledge the contributions of Richard Boell to the experimental setup and of Michael Kerschbaum for early work on the two-qubit gate implementation.

  The team in Zurich acknowledges financial support by the Office of the Director of National Intelligence (ODNI), Intelligence Advanced Research Projects Activity (IARPA), via the U.S. Army Research Office grant W911NF-16-1-0071, by the EU Flagship on Quantum Technology H2020-FETFLAG-2018-03 project 820363 OpenSuperQ, by the National Centre of Competence in Research Quantum Science and Technology (NCCR QSIT), a research instrument of the Swiss National Science Foundation (SNSF), by the SNFS R'equip grant 206021-170731 and by ETH Zurich. S.K. acknowledges financial support from Fondation Jean-Jacques & Felicia Lopez-Loreta and the ETH Zurich Foundation. The work in Sherbrooke was undertaken thanks in part to funding from NSERC, Canada First Research Excellence Fund and ARO W911NF-18-1-0411, the Ministère de l'Économie et de l'Innovation du Québec, and U.S. Department of Energy, Office of Science, National Quantum Information Science Research Centers, Quantum Systems Accelerator. M.M. acknowledges support by the U.S. Army Research Office grant W911NF-16-1-0070. The views and conclusions contained herein are those of the authors and should not be interpreted as necessarily representing the official policies or endorsements, either expressed or implied, of the ODNI, IARPA, or the U.S. Government.

  #heading(level: 1, numbering: none)[Author Contributions]
  <author-contributions>
  S.K., N.L. and A.R. planned the experiments, S.K. and N.L performed the main experiment, and S.K. and N.L. analyzed the data. F.S., A.R. and C.K.A. designed the device, and S.K., A.R. and G.J.N. fabricated the device. N.L., C.H. and S.L. developed the experimental software framework and A.R., C.H., N.L., S.K. and S.L. developed control and calibration software routines. A.R., J.H., S.K. and C.H. designed and built elements of the room-temperature setup, and S.K., A.R., C.H., S.L., N.L. and F.S. maintained the experimental setup. S.K., N.L., A.R., C.H., S.L. and C.K.A. characterized and calibrated the device and the experimental setup. E.G., A.D.P. and C.L. performed the numerical simulations. M.M. provided guidance on logical qubit evaluation methodology aspects. S.K., N.L., A.R., C.H. and S.L. prepared the figures for the manuscript and S.K., N.L., A.R., C.E. and A.W. wrote the manuscript with inputs from all co-authors. A.B., C.E. and A.W. supervised the work.

  #heading(level: 1, numbering: none)[Competing interests]
  <competing-interests>
  The authors declare no competing interests.

  #heading(level: 1, numbering: none)[Methods]
  <methods>
  == Controlled-phase Gates
  <methods_sec:cz_gates>
  We realize the necessary two-qubit controlled-phase (CZ) gates by tuning adjacent pairs of data ($D_j$) and auxiliary qubits ($X_i$, $Z_i$) into resonance @Strauch2003 @DiCarlo2010 @Negirneac2021 using individual flux lines implemented with coplanar waveguides (green in @fig:device) shorted near the SQUID loop of each qubit. We fabricated all qubits with asymmetric superconducting quantum interference devices (SQUIDs) @Strand2013 @Hutchings2017 to allow for data qubits to idle at their minimum and auxiliary qubits at their maximum frequencies, at which the qubits are to first-order insensitive to flux noise. Data qubits are designed with idle frequencies $3.7 - 4.1 $GHz in a low frequency band and auxiliary qubits with idle frequencies $5.9 - 6.3 $GHz in a high frequency band, see red and blue/green dots, respectively, in @fig:device and @app:device_params
  We implement CZ gates by tuning both data and auxiliary qubits to an intermediate interaction frequency $omega_"int"$ and $omega_"int"-alpha$, respectively, with $omega_"int"/2pi$ ranging from $4.4$ to $5.6 $GHz (@app:two_qubit_gates). The qubit anharmonicity $alpha tilde - 0.17 $GHz is designed to be small to minimize residual qubit/qubit interactions@Krinner2020. We make use of net-zero flux pulses @Negirneac2021, which reduce both the detrimental effect of low-frequency flux noise on qubit coherence and the impact of non-idealities in the transfer function of the flux lines on gate fidelities. Given the large designed detuning of $tilde 2$~GHz between the data and auxiliary qubits at their idle frequencies, we calculate residual-ZZ interaction strengths between qubits lower than $alpha_"zz" 2 pi tilde 8 $kHz @Krinner2020. It is only during two-qubit gate execution that $alpha_"zz"$ increases by a factor of approximately $2$ to $25$, depending on the interaction frequency $omega_"int"$, which we partially mitigate using echo pulses. The coupling strength between auxiliary qubits and data qubits at the interaction point is about $J 2 pi tilde 7 $MHz.

  == Qubit-readout Architecture
  <methods_sec:readout>
  Each qubit is coupled to a resonant pair of readout resonator and Purcell filter (red- and blue $lambda / 4$ coplanar waveguide resonators in @fig:device). Moreover, each readout resonator is coupled strongly to the qubit ($g / (2 pi) tilde 169$MHz for auxiliary qubits and $g / (2 pi) tilde 252$MHz for data qubits) and has a large effective bandwidth ($kappa_"eff"/(2 pi) tilde 10$MHz) to enable fast, high-fidelity readout @Walter2017. The individual Purcell filters both maintain high qubit coherence, despite the large coupling and bandwidth of the readout resonators, and reduce undesired readout crosstalk (@app:crosstalk) between qubits which are in close proximity or have similar frequencies @Heinsoo2018. This is particularly important for the simultaneous frequency-multiplexed readout of groups of four or five qubits using joint feed lines (purple coplanar waveguides in @fig:device). The readout resonator frequencies are separated by about 200~MHz within each feed line and occupy a frequency band extending from 6.8 to 7.6~GHz (purple points in @fig:device).

  We read out the states of all qubits dispersively by applying frequency-multiplexed Gaussian filtered microwave pulses of duration $200 - 300 $ns to all four feed lines. We integrate the transmitted signals in a heterodyne detection scheme for a duration of $400$~ns (@app:readout_characterization). Auxiliary qubits are read out near their idle frequencies while data qubits are read out at a flux-tuned qubit frequency of $tilde 5$~GHz reducing the data qubit-readout resonator detuning @Sank2016 and thus enhancing the dispersive coupling and the readout fidelity @Wallraff2005 @Walter2017
  == Leakage Detection
  <methods_sec:leakage>
  We make use of a leakage detection scheme based on three-state readout which allows us, in postprocessing, to reject those sequences in which any of the qubits were measured in a leakage state, see @app:readout_characterization. In our CZ gate scheme we make use of the second excited state $| 2 ⟩$ of the auxiliary qubits rather than the one of the data qubits to mediate the interaction which minimizes data qubit leakage. Performing three-state readout of the data qubits after the final error correction cycle, we reject experimental runs for which data qubit leakage was detected. The rejected fraction per qubit and per cycle amounts to $0.0017 ( 2 )$. In addition there is a cycle-independent rejection probability of about $0.01$ per qubit due to false positives caused by readout-error. In addition, we detect, if any of the eight auxiliary qubits has leaked to the $| 2 ⟩$ state in any of the $n$ cycles, using the same three-state readout, and find an average rejection probability of $0.0094 ( 4 )$ per qubit per cycle. In total, this leads to a rejected data fraction per cycle of 8 %.

  #heading(level: 1, numbering: none)[Supplementary Information]
  <supplementary-information>
  #block[
  ]

  #counter(heading).update(0)
  #set heading(numbering: "A.1", supplement: [Appendix])

= Device fabrication
<app:device_fabrication>
To fabricate the 17-qubit surface code device, we pattern transmon qubit islands, couplers, resonators, and control lines into a 150 nm-thin niobium film sputtered onto a high-resistivity silicon substrate using photolithography and reactive ion etching. To establish a well-connected ground plane at microwave frequencies and realize cross-overs for coplanar waveguides, we fabricate aluminum-titanium-aluminum trilayer airbridges onto the device using a two-layer resist photolithography process with reflow. We fabricate aluminium-based Josephson junctions of the transmon qubits using electron-beam lithography (EBL) and shadow evaporation, and establish electrical contact between the junction metal and the niobium base-layer film using aluminum bandages~@Dunsworth2017 fabricated in a second EBL and evaporation run.

= Device parameters and performance
<app:device_params>
We characterize the performance and properties of each qubit on the device using spectroscopy and standard time-domain methods, see @tab:qubit_measured_parameters. Note that some parameters (marked with the superscript 'a' in @tab:qubit_measured_parameters) were extracted from measurements in a separate cooldown of the same device.

We realize single-qubit gates with 40-ns-duration microwave DRAG pulses~@Motzoi2009 with a Gaussian envelope which has a standard deviation of $sigma = 10 "ns"$ and is truncated at $plus.minus 2 sigma$.

We realize two-qubit gates with net-zero flux pulses~@Rol2019 @Negirneac2021 with an average duration of $68 "ns"$, see~@app:two_qubit_gates for a detailed description of the two-qubit gates implementation. We add $15 "ns"$ buffers before and after each flux-pulse resulting in a total average two-qubit gate duration of $98 "ns"$.

We benchmark the performance of single- and two-qubit gate operations across the entire device using randomized benchmarking~@Magesan2011 @Epstein2014 (single-qubit gates) and interleaved randomized benchmarking~@Magesan2012 @Corcoles2012 @Barends2014 (two-qubit gates), and display the resulting errors in Fig.~#panel(<fig:gate_performance>, ""). CZ gates that are executed simultaneously in the quantum error correction cycle (see Fig.~#panel(<fig:stabilizers_state_init>, "a") and @fig:pulse_sequence) are also calibrated and benchmarked simultaneously.

Single-qubit gates have a mean error of 0.09(4)~%, which is in good agreement with the mean error of 0.08~% obtained from master-equation simulations taking only decoherence into account, see @app:numerical_simulations. Two-qubit gates have an average gate error of 1.5(1.0)~%, and a best (worst) gate error of 0.6~% (5.4~%). Two-qubit gates used to realize the stabilizer $hat(S)^("X" 1)$ display larger errors, which we attribute to the low coherence times of the auxiliary qubit X1, and to the interaction with a microscopic defect (@app:two_qubit_gates) with a frequency close to the idle-frequency of qubit X1.

// [figvision] imgs/gate_performance_20211109_000852.png
// Single lattice map with two colour scales above it, no axes.
// Top scale (pink, 0.00-0.20 %) = single-qubit gate error eps_1Q; each qubit is a pink
// circle labelled with its role and its eps_1Q value.
// Second scale (blue, 1-5 %) = two-qubit gate error eps_2Q; each coupler is a blue band
// of proportional width and shade labelled with its value.
// Node values: Z1 0.10, D1 0.06, D4 0.04, X2 0.13, D2 0.07, X1 0.16, D7 0.04,
// Z2 0.09, D5 0.06, Z3 0.07, D3 0.04, X4 0.14, D8 0.08, X3 0.17, D6 0.06,
// D9 0.06, Z4 0.16.
// Edge values: Z1-D1 1.2, Z1-D4 1.2, D1-X2 0.6, D4-X2 0.9, D4-D7 1.3, X2-D2 0.8,
// D2-X1 2.6, X1-D3 5.4, D7-X4 0.9, D7-Z2 1.0, Z2-D5 1.0, D5-Z3 1.9, Z3-D3 3.4,
// Z2-D8 1.2, X4-D8 1.3, D8-X3 1.3, D5-X3 1.4, X3-D6 2.4, Z3-D6 1.2, X3-D9 1.1,
// D9-Z4 0.7, D6-Z4 1.8.
// Largest errors sit on the X1-D3 coupler (5.4 %) and on X3/X4/X1 single-qubit gates.
#figure(placement: auto, image("imgs/gate_performance_20211109_000852.png", width: 100%),
  caption: [
    Single- and two-qubit gate errors as characterized by randomized benchmarking and interleaved randomized benchmarking, respectively. The average measured single-qubit (two-qubit) gate error across the device is 0.09(4) % \[1.5(1.0) %\].
  ]
)
<fig:gate_performance>

#pagebreak()
#figure(placement: auto, 
  block(width: 100%)[
    #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left,right,right,right,right,right,right,right,right,right,),
    table.header([Parameter], [D1], [D2], [D3], [D4], [D5], [D6], [D7], [D8], [D9],),
    table.hline(),
    [Qubit idle frequency, $omega_Q 2 pi$ (GHz)], [3.885], [3.994], [3.952], [3.878], [3.895], [3.74], [4.056], [3.993], [4.143],
    [Qubit anharmonicity, $alpha 2 pi$ (MHz)], [-184], [-184], [-183], [-184], [-186], [-184], [-181], [-183], [-181],
    [Lifetime, $T_1$ (μs)], [29.1], [33.0], [65.5], [59.3], [32.2], [60.2], [36.0], [33.1], [25.9],
    [Ramsey decay time, $T_2^(*)$ (μs)], [35.0], [13.5], [33.9], [74.3], [46.1], [78.1], [74.8], [41.4], [31.7],
    [Echo decay time, $T_2^"e"$ (μs)], [46.2], [52.2], [49.3], [75.5], [56.1], [89.3], [72.5], [59.1], [36.3],
    [Single-qubit RB error#super[a], $epsilon_"1Q"$ (%)], [0.06], [0.07], [0.04], [0.04], [0.06], [0.06], [0.04], [0.08], [0.06],
    [Readout frequency, $omega_"RO" 2 pi$ (GHz)], [6.769], [6.979], [6.88], [7.12], [7.18], [7.032], [6.91], [7.075], [6.868],
    [Qb. freq. during RO, $omega'_Q 2 pi$ (GHz)], [5.321], [4.75], [5.275], [4.25], [4.42], [5.13], [4.395], [3.993], [5.0],
    [Dispersive shift#super[a], $chi 2 pi$ (MHz)], [-2.0], [-2.2], [-1.9], [-1.6], [-1.5], [-1.6], [-2.3], [-2.0], [-2.4],
    [Disp. shift during RO, $chi' 2 pi$ (MHz)], [-7.4], [-3.9], [-6.0], [-2.0], [-2.1], [-4.7], [-3.0], [-2.0], [-4.9],
    [Readout linewidth#super[a], $kappa_"eff" 2 pi$ (MHz)], [6.3], [7.2], [8.3], [8.7], [3.5], [9.0], [8.6], [8.2], [8.9],
    [Qubit-RO res. coupling#super[a], $g_"Q,RR" 2 pi$ (MHz)], [244], [269], [241], [241], [238], [244], [267], [265], [260],
    [Two-state readout error, $epsilon_"RO"^(( 2 ))$ (%)], [0.7], [0.5], [0.5], [0.6], [0.8], [0.5], [2.3], [1.3], [0.5],
    [Three-state readout error, $epsilon_"RO"^(( 3 ))$ (%)], [4.4], [1.0], [5.9], [2.1], [1.6], [1.1], [3.3], [2.1], [1.0],
    [Thermal population, $P_"th"$ (%)], [2.1], [0.7], [1.5], [3.8], [2.7], [2.2], [0.0], [0.8], [1.6],
    table.hline(stroke: 0.4pt),
    [Parameter], [X1], [X2], [X3], [X4], [Z1], [Z2], [Z3], [Z4], [$upright(bold(overline(Q)))$],
    [Qubit idle frequency, $omega_Q 2 pi$ (GHz)], [6.097], [5.885], [6.022], [6.049], [6.328], [6.192], [5.956], [6.037], [#strong[\-]],
    [Qubit anharmonicity, $alpha 2 pi$ (MHz)], [-170], [-174], [-170], [-170], [-163], [-168], [-171], [-170], [#strong[\-177]],
    [Lifetime, $T_1$ (μs)], [12.4], [17.4], [18.5], [12.6], [17.0], [42.7], [29.7], [27.5], [#strong[32.5]],
    [Ramsey decay time, $T_2^(*)$ (μs)], [5.6], [14.3], [20.7], [28.9], [29.3], [33.1], [48.0], [28.9], [#strong[37.5]],
    [Echo decay time, $T_2^"e"$ (μs)], [15.8], [33.0], [16.1], [33.1], [31.5], [26.0], [53.6], [53.6], [#strong[47.0]],
    [Single-qubit RB error#super[a], $epsilon_"1Q"$ (%)], [0.16], [0.13], [0.17], [0.14], [0.1], [0.09], [0.07], [0.16], [#strong[0.09]],
    [Readout frequency, $omega_"RO2pi"$ (GHz)], [7.372], [7.554], [7.258], [7.461], [7.316], [7.502], [7.2], [7.412], [#strong[\-]],
    [Qb. freq. during RO, $omega'_Q 2 pi$ (GHz)], [5.9], [5.885], [6.022], [6.049], [6.328], [6.191], [5.956], [5.687], [#strong[\-]],
    [Dispersive shift#super[a], $chi 2 pi$ (MHz)], [-2.8], [-1.9], [-3.2], [-2.6], [-4.7], [-2.9], [-3.2], [-2.8], [#strong[\-2.4]],
    [Disp. shift during RO, $chi' 2 pi$ (MHz)], [-2.1], [-1.9], [-3.2], [-2.6], [-4.7], [-2.9], [-3.2], [-2.8], [#strong[\-3.5]],
    [Readout linewidth#super[a], $kappa_"eff" 2 pi$ (MHz)], [15.1], [20.1], [13.0], [11.0], [11.2], [12.2], [14.3], [10.0], [#strong[10.3]],
    [Qubit-RO res. coupling#super[a], $g_"Q-RR" 2 pi$ (MHz)], [167], [168], [167], [168], [171], [170], [167], [171], [#strong[213]],
    [Two-state readout error, $epsilon_"RO"^(( 2 ))$ (%)], [2.7], [0.7], [0.8], [0.8], [1.3], [0.4], [0.4], [0.5], [#strong[0.9]],
    [Three-state readout error, $epsilon_"RO"^(( 3 ))$ (%)], [3.9], [2.0], [1.9], [1.6], [2.2], [1.2], [0.9], [1.1], [#strong[2.2]],
    [Thermal population, $P_"th"$ (%)], [0.2], [0.2], [0.5], [0.3], [0.6], [0.5], [0.2], [0.9], [#strong[1.1]],
  )
    #v(0.3em)
    #text(size: 8pt)[#super[a] Measured in a different cooldown.]
  ],
  caption: [Qubit parameters, coherence properties and single-qubit performance for the nine data qubits (top) and the eight auxiliary qubits (bottom). We also provide, for relevant quantities, the averaged value across the device in column $overline(upright(Q))$.],
  kind: table,
) <tab:qubit_measured_parameters>
#v(0.6em)

#set heading(numbering: "A.1", supplement: [Appendix])

= Two-qubit gates
<app:two_qubit_gates>
Two-qubit gates are essential building blocks of the stabilizer circuits of the surface code. Here, we describe our implementation of CZ gates, discuss the constraints and considerations for gate parallelization and gate ordering during the error correction cycle, and report on coherence properties during the gate execution.

== CZ gate implementation
<app:two_qubit_gates:implementation>
We realize two-qubit controlled-phase (C$Z$) gates @Strauch2003 @DiCarlo2010 by flux-tuning two neighboring qubits to an interaction frequency between the idle frequencies of the two qubits. We use a net-zero pulse shape to protect the qubits from low-frequency flux noise and to avoid the buildup of long-timescale distortions in the flux-control lines @Rol2019 @Negirneac2021.

The flux pulse applied to each qubit consists of two Gaussian-filtered, approximately $30$-ns-long sections, which are interleaved with a 2.5-ns-long net-zero transition section, see @fig:interaction_frequencies for an example waveform. The amplitudes of the longer sections bring the $| 20 ⟩$-transition frequency into resonance with the the $| 11 ⟩$-transition frequency, see Fig.~#panel(<fig:interaction_frequencies>, "b"). We calibrate the duration of these sections to achieve full population recovery into the $| 11 ⟩$ state.

To achieve a $pi$-controlled-phase rotation, we calibrate the pulse amplitude of the transition section for the data qubit, which effectively controls the phase acquired by the $| 20 ⟩$ state relative to the $| 11 ⟩$ state.

We select interaction frequencies which allow for the parallel execution of three CZ gates in each of the eight time steps of the quantum error correction cycle, as indicated by the color and label of the qubit-qubit couplers in Fig.~#panel(<fig:interaction_frequencies>, ""). The interaction frequencies for a single time step (colored horizontal lines of same color) are chosen to avoid crossing neighboring qubits on which gates are executed in the same time step. In addition, the interaction frequencies in a given CZ gate time step are distributed over the available $tilde 2 $GHz frequency range to minimize residual-ZZ couplings between neighboring qubits performing CZ gates in parallel. The overall, calculated residual-ZZ coupling during the eight CZ gate time steps, averaged over all 24 qubit pairs and over the eight time steps, amounts to $alpha_"ZZ"/2pi = 27(37)$kHz, which is about a factor three larger than with all qubits biased at their idle frequency.

Finally, the interaction frequencies are chosen to minimize population loss due to interaction with the strongly coupled microscopic defects of our device. To characterize the defect-mode distribution, we determine the frequency-dependent population loss for each qubit by measuring the remaining excited-state population after applying Gaussian-filtered square flux pulse that tunes the qubit frequency from its idle frequency (black semi-circle) to $omega_"int"$ for a duration of $t_"int" = 100 "ns"$, see the gray filled areas in Fig.~#panel(<fig:interaction_frequencies>, "c"). For most qubits, we observe a constant background population loss of $lt.eq 2 "%"$ over the entire frequency range, with $0 - 3$ narrow frequency bands ($lt.eq 50 $MHz) exhibiting peak population loss $gt.eq 25 "%"$. We attribute these population-loss peaks to coherent interactions with defects coupled to the qubits with a strength of $g 2 pi gt.eq 0.8 $MHz. Qubits D7, D8 and X1 display broader and higher population-loss peaks, likely due to the interaction with defects coupled to the qubits with $g 2 pi$ on the order of 1-20 MHz. For these qubits, the finite interaction during the rising and falling edge of the flux pulse leads to a population loss tail when crossing the defect. We choose interaction frequencies for the two-qubit gates that are detuned from all defects and that avoid crossing strongly coupled defects.

// [figvision] imgs/two_qb_gates_20211110_160000.png
// Three panels (a pulse shapes; b dressed frequencies; c leakage spectra plus lattice).
// (a) Pulse amplitude a (V, -0.7..1.0) vs time t (0-100 ns) for D5 (red) and X2 (blue).
//     Both are symmetric trapezoids of about +-0.55 V with ~8 ns ramps: D5 is high from
//     0-50 ns then low; X2 is low 0-55 ns then high to 100 ns, so the gate window overlaps.
// (b) Qubit frequency omega_q/2pi (GHz, 4.5-12.5) vs t (0-100 ns) for the five transition
//     traces labelled 01, 10, 02, 11, 20 at the right. Outside the window the traces sit at
//     their idle values (01 ~6.8, 10 ~5.0, 02 ~10.0, 11 ~9.8, 20 ~12.5 GHz); during the
//     window 01 is pushed down to ~5.3 GHz, 02 down to ~7.5 GHz, 11 down to ~8.2 GHz,
//     while 20 shows a small upward excursion - the avoided crossings that activate the
//     CZ gate.
// (c) Population loss P_loss (%) (0-25, horizontal) versus internal frequency
//     omega_int/2pi (3.8-6.3 GHz, vertical), shown as ten grey spectral traces attached to
//     vertical columns with black dots marking the loss maxima; coloured horizontal
//     segments (black, blue, cyan, green, orange, red, pink, grey) mark the qubit
//     frequencies. Below, the qubit lattice with the frequency ordering and coupler labels
//     (numbers 2-8, coloured by gate order: orange 2, green 3, red 4, brown 5, grey 6/7,
//     cyan 8), e.g. Z1-D4 orange 2, Z1-D1 green 3, D5-Z3 red 4.
#figure(placement: auto, image("imgs/two_qb_gates_20211110_160000.png", width: 100%),
  caption: [
    Realization of two-qubit gates. #strong[a]. Example of a net-zero pulse shapes before compensating for flux line distortions that are applied simultaneously on a data qubit (D5) and an auxiliary qubit (X2) to implement a CZ gate between the two. Note that the duration of the transition section has been increased from $2.5 "ns"$ to $12.5 "ns"$ for better visibility in this figure. #strong[b]. Calculated evolution of the eigenenergies for the pulse shapes shown in panel #strong[a]. #strong[c]. Frequency arrangement chosen for the operation of the device. Measured population loss (gray areas) when flux-tuning qubits from their idle frequencies (black dots) to $omega_"int"$ for a duration of $100 "ns"$. The chosen two-qubit gate interaction frequencies are displayed as colored lines corresponding to the color code used in the conceptual device representation at the bottom of the panel, which indicates two-qubit pairs between which gates are executed. Gates sharing the same color are executed simultaneously, in the time step indicated by the label extending between pairs of qubits
  ]
)
<fig:interaction_frequencies>

In addition to a suitable selection of interaction frequencies, accurate control of the qubit frequency is essential for the realization of high-fidelity and low-leakage two-qubit gates. However, the flux pulses reaching the sample and controlling the qubit frequency, are transformed from the programmed waveforms on the AWGs due to the transfer functions of, for instance, the high-pass filtering in the bias-tee, the frequency-dependent attenuation in the cables, and imperfections in the impedance matching of the flux line. To characterize the flux pulse distortions at timescales ranging from $tilde 50 "ns"$ to $50 mu s$, we apply a step-like Gaussian-filtered flux pulse and resolve the resulting time dependence of the qubit frequency by identifying which drive frequency induces a transition from $| 0 ⟩$ to $| 1 ⟩$, for a varying delay $Delta t$ after applying the step-like flux pulse. The time-dependent qubit-frequency response is then used to calibrate infinite impulse response (IIR) filters which invert the distortions of signals propagating along the flux line in digital preprocessing of the programmed waveforms, see above. Moreover, to compensate for distortions on nanosecond timescales, we calibrate finite impulse response (FIR) filters using methods described in Ref.~@Rol2020.

== Two-qubit gate order
<app:gate_sequence>
We choose the order of the two-qubit gates, executed in the CZ gate time steps 1, 2, 3, 4 for $hat(S)^("Z" i)$ and in the time steps 5, 6, 7, 8 for $hat(S)^("X" i)$ (Fig.~#panel(<fig:stabilizers_state_init>, "a"), to provide resilience against single auxiliary-qubit errors propagating to data qubits~@Horsman2012 @Tomita2014a Simultaneously, we satisfy constraints imposed by the presence of microscopic defects near the two-qubit gate interaction frequencies (@app:two_qubit_gates:implementation).

A single $hat(X)$ error on an auxiliary qubit $"Z" i$ ($"X" i$) during a stabilizer measurement $hat(S)^("Z" i)$ ($hat(S)^("X" i)$) results in $hat(Z)$ ($hat(X)$) errors on all data qubits which subsequently perform CZ gates with that auxiliary qubit, see @fig:gate_order for an example. Auxiliary qubit $hat(Z)$ errors commute with the CZ gates and therefore do not propagate to data qubits. We only consider the middle of weight-four stabilizer gate sequences as potential times when $hat(X)$ errors occur on the auxiliary qubits since the error propagates to two data qubits only in this case. For all other auxiliary qubit error locations, the error effectively propagates to at most a single data qubit because data qubit errors are only relevant up to multiplication with stabilizer operators. For instance, although an error between the first and second CZ gate physically propagates to three data qubits of the corresponding stabilizer plaquette, this three-qubit error is equivalent to a single-qubit error, of the same type, on the originally unaffected data qubit of the plaquette.

To ensure that such correlated two-qubit $hat(Z)$ or $hat(X)$ errors do not result in logical errors in the decoding process, we choose the last two CZ gates of each of the $hat(S)^("Z" i)$ ($hat(S)^("X" i)$) measurements to involve data qubits which are not aligned parallel to the data-qubit strings forming the logical operators $hat(Z)_"L"$ ($hat(X)_"L"$)~@Tomita2014a, i.e. not horizontal (vertical) in Fig.~#panel(<fig:gate_order>, "b"). With this gate order, correlated two-qubit $hat(Z)$ or $hat(X)$ errors can be correctly identified (up to multiplication with stabilizer operators). As an example, we consider the correlated error $hat(Z)_"D4"hat(Z)_"D7"$ on D4 and D7 resulting from a single error $hat(Z)_"Z2"$ on Z2, see Fig.~#panel(<fig:gate_order>, "b"). As a consequence, X2 and X4 show syndrome elements of 1 (dark blue, solid circles in @fig:gate_order). Because the stabilizers $hat(S)^("X" 2)$ and $hat(S)^("X" 4)$ do not share a data qubit, this syndrome cannot be caused by a single data-qubit error and the minimum-weight-perfect-matching decoder (@app:decoding) correctly identifies both errors, the error $hat(Z)_"D7"$ and one of the equivalent errors $hat(Z)_"D4"$ (indicated in @fig:gate_order with solid, dark blue arrows) or $hat(Z)_"D1"$. On the other hand, if the gates Z2-D7 and Z2-D8 were successively performed in either the CZ gate time steps 1 and 2, or 3 and 4, the corresponding correlated error $hat(Z)_"D7"hat(Z)_"D8"$ (green rectangle with dashed outline in Fig.~#panel(<fig:gate_order>, "b") would not be correctly identified by the decoder. In that case, only the syndrome element of X3 is 1 and as a result the decoder identifies one of the equivalent single-qubit errors $hat(Z)_"D9"$ (indicated in Fig.~#panel(<fig:gate_order>, "b") with a dashed, dark blue arrow) or $hat(Z)_"D6"$, and applies the corresponding correction $hat(Z)_"D9"$ or $hat(Z)_"D6"$. However, one such false correction together with the original error $hat(Z)_"D7"hat(Z)_"D8"$ is equivalent to the application of $hat(Z)_"L"$ and thus leads to a logical error, see black dashed line in Fig.~#panel(<fig:gate_order>, "b")
We note that data qubits participating in the last two CZ gates of a stabilizer measurement may also be aligned diagonally with respect to the data qubit string of the corresponding logical operator, and that the resulting weight-two error on the data qubits remains correctable. In particular, this is the case for $hat(S)^("Z" 3)$ and allows us to execute the gate Z3-D5 in a different time step than the gate Z2-D7, which would otherwise result in a frequency crossing of Z2 and D5 because the gate Z2-D7 is constrained to an interaction frequency $omega_"int"/2pi "≲" 4.5~$GHz due to a microscopic defect on D7 (Fig.~#panel(<fig:interaction_frequencies>, "c"). For completeness, we note that there is no constraint imposed on the two-qubit gate order from maintaining the commutation of neighboring stabilizers $hat(S)^("Z" i)$ and $hat(S)^("X" i)$ @Fowler2012 @Tomita2014a because we measure $hat(S)^("Z" i)$ and $hat(S)^("X" i)$ sequentially.

// [figvision] imgs/211103_fig_gate_order.png
// Two panels: (a) syndrome-extraction circuits, (b) anyon/error paths on the lattice.
// (a) Two four-data-qubit stabilizer circuits drawn as horizontal wires with coloured
//     qubit dots at the left (blue = one row, red = the other). Each wire carries Y-rotation
//     boxes (three-pulse sequences, dashed-blue for some), CZ gates drawn as vertical
//     connectors with grey dots on the data wires, a purple "Error" box and a final
//     measurement box. Legend: YYY = single-qubit Y-rotation (-pi/2, pi, pi/2), a box with
//     Z = measurement, a line with a dot = CZ gate, and filled grey circles = qubit.
// (b) Diamond lattice with D1-D9 red data qubits, green Z stabilizer faces Z1-Z4
//     (green circles) and blue X faces X1-X4 (blue circles). Axes X_L (top) and Z_L
//     (right, dashed) span the logical operators; the solid black square through D1-D3-D6-D7
//     is the logical Z. Solid blue arrows labelled "Corrected" arc from Z1/Z4 to X2/X4
//     (corrections), while dashed blue arrows labelled "Logical error" run along the
//     bottom edge (X4 and Z4) and through X3 - the undetectable chains that cause failure.
//     A teal dashed boundary marks the Z boundary of the patch.
#figure(placement: auto, image("imgs/211103_fig_gate_order.png", width: 100%),
  caption: [
    Limiting the propagation of auxiliary-qubit errors. #strong[a] Weight-four stabilizer circuit as discussed in the main text. A single $hat(X)$ error on the auxiliary qubit in the middle of the circuit propagates to two data qubits (violet lines), resulting in a correlated $hat(Z) hat(Z)$ error (green box) for Z-type stabilizer circuits and in a correlated $hat(X) hat(X)$ error (blue rounded-corner box with dashed outline) for X-type stabilizer circuits. #strong[b] 17-qubit surface code schematic with two potential correlated $hat(Z) hat(Z)$ errors (solid and dashed green boxes) indicated. Dark blue, solid and dashed circles around auxiliary qubits indicate the corresponding syndrome elements with value 1. Dark blue, solid and dashed arrows indicate the errors identified by the decoder, see text for details.
  ]
)
<fig:gate_order>

== Reduced coherence at interaction frequencies
<app:T2_intfreq>
// [figvision] imgs/T2_at_int_freqs_20211110_151649.png
// Two bar-chart panels above a qubit lattice that gives the column ordering.
// (a) T2* and T2^int in us (0-75, vertical) as a triplet of bars per qubit (red, green,
//     blue). Red bars reach 10-75 us (most 35-55, several clipped at the 75 axis),
//     green bars 5-50 us, blue bars 4-25 us. A few qubits show near-zero blue bars.
// (b) Ratio T2*/T2^int (0-12) for the same triplets. A grey band marks the typical range
//     (about 1-3, dashed boundaries); most bars sit at 2-4, with a single green outlier
//     near 13 and several red bars at 5-7.
// Below: the 17-qubit lattice (green Z1-Z4, blue X1-X4, red D1-D9) laid out so that each
// column of bars lines up with one qubit; thin vertical leaders connect bar groups to
// the corresponding lattice nodes, showing which physical qubit each bar belongs to.
#figure(scope: "parent", placement: top, image("imgs/T2_at_int_freqs_20211110_151649.png", width: 55%),
  caption: [
    Reduced coherence during two-qubit gate execution.~#strong[a] Comparison between the Ramsey decay times measured at the qubit idle frequencies (wire-frames), $T_2^(*)$, and at the two-qubit gate interaction frequencies (solid bars), $T_2^(* , "int")$, for the 24 two-qubit gates of the device, with colors matching the respective qubit color in the conceptual device representation at the bottom of the figure. Each qubit appears multiple times as it is tuned to different interaction frequencies depending on which neighboring qubit it performs a gate with.~#strong[b] Ratio of the Ramsey decay time at the qubit idle frequency, $T_2^(*)$, and the Ramsey decay time at the two-qubit gate interaction frequency, $T_2^(* , "int")$. The median ratio is indicated by the gray area.
  ]
)
<fig:t2_interaction_frequencies>
At the two-qubit gate interaction frequency, the sensitivity of the qubit frequency to fluctuations in flux is higher than at the idle frequency, which is first-order insensitive to fluctuations in flux. Hence, flux-noise-induced dephasing is increased during two-qubit gates. We characterize the effective Ramsey decay time $T_2^(* , "int")$, for a given qubit $Q i$ ($Q in ( "D" , "X" , "Z" )$ and $i = 1 , dots.h , 9$ if $Q = "D"$ and $i = 1 , dots.h , 4$ otherwise), fluxed-tuned to the interaction frequency $omega_"int"$ with a sequence of Ramsey measurements. Specifically, we measure the phase of a given qubit with a Ramsey experiment in which we insert a train of $N$ $60 "ns"$-duration net-zero flux pulses (with 15-ns-long buffers on each side) between two Ramsey $pi 2$-pulses. We repeat the measurement for $N = 1 , 2 , 4 , 8 , dots.h , 256$ pulses, extract the phase contrast for each measurement from a cosine fit, and fit the phase contrasts to a decaying exponential to extract $T_2^(* , "int")$.

We compare $T_2^(* , "int")$ to the Ramsey decay time measured at the qubit idle frequency, $T_2^(*)$, for each of the 24 two-qubit gates, see the wire-frame and filled bars in Fig.~#panel(<fig:t2_interaction_frequencies>, "a") respectively. Averaged over the 24 qubit-pairs, we observe a mean $T_2^(* "int")$ of 13.1(4.2)$ $µs at the interaction frequency, compared to a mean $T_2^(*)$ of 46.8(20.2)$ $µs at the idle frequency. As the built-in echo effect of the net-zero flux-pulse provides protection against low-frequency flux-noise, we hypothesize that the reduction in decay-time is dominated by high-frequency flux noise. We compute the decay-time ratio $T_2^(*) T_2^(* , "int")$ for each qubit-pair, see~Fig.~#panel(<fig:t2_interaction_frequencies>, "b") and extract a mean ratio of $tilde 3.2$ (gray area). This reduction in Ramsey decay time significantly affects the coherence limit of the two-qubit gates. To reproduce the characteristics of the experiment in numerical simulations, we account for this reduction by adjusting the dephasing rates for the duration of the two-qubit gates, see @app:numerical_simulations for details.

= Experimental setup
<app:experimental_setup>
We install the 17-qubit quantum device in a magnetically-shielded sample holder mounted at the base plate of a dilution refrigerator~@Krinner2019 and connect it to the control-electronics setup located at room temperature as indicated in Fig.~#panel(<fig:experimental_setup>, ""). Input and output lines for charge control (pink), flux control (green), and readout (purple), are configured with the indicated microwave components for signal conditioning.

#place(top + center, scope: "parent", float: true)[
// [figvision] imgs/electronics_setup.png
// Single large rack/wiring diagram with three vertical stages, plus board insets and a
// component legend along the bottom. No plotted data.
// Top stage (beige): control electronics grouped under headers "Flux control" (17x AWG,
//   17x Bat.), "Drive control" (17x AWG), "Readout & acquisition control" (4x UHFQA,
//   4x MWG). Signal paths coloured green (flux), pink (drive), purple (readout drive),
//   black (readout return).
// Middle stage: dashed horizontal lines labelled Front Panel, 4K, 100 mK, 9 mK mark the
//   cryostat plates. Each line carries attenuators (-10, -20 dB; yellow boxes mark -15 dB
//   data and 0 dB auxiliary variants), low-pass/band-pass ECCO filters, dc blocks and
//   amplifiers at 4K (-10 dB) and the output chain (20 dB at 4K, RT-A amplifier).
// Bottom stage (violet): schematic Quantum Device chip with 17 transmon symbols, drive
//   (pink), flux (green) and readout (purple) feeds, then the output path through
//   isolators, a band-pass filter and a power splitter to the acquisition inputs.
// Grey boxes a,b,c mark connector details: (a) MWG to UC board, (b) MWG to UC/DC board,
//   (c) multi-channel switch from UC board to the flux lines.
// Right column insets: UC board (LO/IQ inputs, -10 dB pads, IQ mixer, amplifier, RF/Cal
//   outputs), DC board (fast flux with -3 dB pads and a (v) ZFL-500LN stage), RT-A board
//   (input amplifier (iv), -10 dB, filter, (iii) output), and the (a)(b)(c) connectors.
// Bottom legend keys: Attenuator, LP/BP/HP filter, ECCO IR filter, dc-block, 50 ohm
//   terminator, coaxial cable, uw switch, Displacer, Bias-tee, Power splitter,
//   Dir. coupler, IQ-mixer, Isolator, Amplifier (i Lincoln Lab TWPA, ii LNF HEMT,
//   iii Agile AMT-A0284, iv Kuhne LNA BB-2001200, v ZFL-500LN).
#figure(placement: auto, image("imgs/electronics_setup.png", width: 98.0%),
  caption: [
    Schematic illustration of the experimental setup. Flux lines (green), drive lines (pink), and readout lines (purple) connect room-temperature electronics to the device, schematically represented by qubits (yellow), readout resonators (red) and Purcell filters (dark blue). The background colors indicate the temperature stages of the experimental setup. We provide additional details about the components in the legend (white background) and in the text.
  ]
)
<fig:experimental_setup>
]

DC voltage sources (Bat.) generate a current which passes through a series of attenuators and filters to induce a magnetic flux in the SQUID-loop of the transmon qubit and control its idle frequency. Arbitrary waveform generators (AWG) generate voltage pulses at a sampling rate of 2.4 GSa/s to control the qubit frequencies on the nano-second timescale to implement two-qubit gates, see @app:two_qubit_gates. The AWG signal is combined with the DC bias current using a bias-tee.

Single-qubit drive pulses are generated at an intermediate frequency in the range of 0-$500 M H z$ by an AWG, and then up-converted (UC) to microwave frequencies in an analog IQ-mixer using the continuous-wave signal of a microwave generator (MWG) as a carrier.

An ultra-high frequency quantum analyzer (UHFQA) generates multiplexed-readout pulses at a sampling rate of 1.8 GSa/s. The amplification chain at each readout port of the sample consists of a wide-bandwidth near-quantum limited traveling-wave parametric amplifier (TWPA) @Macklin2015, a high-electron-mobility transistor (HEMT) amplifier and low-noise, and room-temperature amplifiers (RT-A board). We add the TWPA pump tone to the input of the amplifier using a 20 dB directional coupler (Dir. coupler), and cancel it interferometrically at the input of the room-temperature amplifiers by combining the cryostat output signal with a phase- and amplitude-displaced pump tone that bypasses the cryostat. After amplification, the signal is down-converted with an IQ-mixer in a down-conversion (DC) board and then both digitally demodulated and integrated using the field-programmable gate-array of the UHFQA.

= Crosstalk characterization and compensation
<app:crosstalk>

An important requirement for scaling up quantum processors is the individual and independent control of its constituents. Here, we characterize three types of crosstalk relevant for the execution of the surface code on our 17-qubit device: microwave drive crosstalk, flux crosstalk, and measurement-induced dephasing.

== Drive crosstalk
<drive-crosstalk>

// [figvision] imgs/drive_crosstalk_20211110_124637.png
// Square 17x17 crosstalk matrix. Rows = drive lines DL Z1, DL Z2, DL Z3, DL Z4, DL X1,
// DL X2, DL X3, DL X4, DL D1 ... DL D9 (vertical label "Drive line DL Qi"); columns =
// qubits Qj in the same order (horizontal label "Qubit Qj").
// Colour scale above: "Cross driving ratio log10(a_f^{DLQi}/a_j^{DLQi})", pink, from
// -1.50 to +0.50. Every diagonal cell is 0.0 (self-driving), printed in bold.
// Off-diagonal entries are printed values, mostly between -0.9 and -1.6 (light pink),
// i.e. leakage amplitudes one to two orders of magnitude below the drive of the target.
// The upper-right block (auxiliary drive lines vs data qubits) and the lower-left block
// (data drive lines vs auxiliary qubits) are hatched grey: those combinations are not
// used because data and auxiliary qubits are driven by separate lines. Within the
// Z/X blocks (top-left 8x8) a few -1.2 to -1.4 entries appear near shared couplers;
// the data block (bottom-right 9x9) is mostly empty except the diagonal and isolated
// -1.5 / -1.0 cells.
#figure(placement: none, image("imgs/drive_crosstalk_20211110_124637.png", width: 88%),
  caption: [
    Drive crosstalk characterization. For each drive line (DL) targeting qubit $Q i$, crosstalk is expressed as the logarithm of the ratio between the amplitude of a $pi$-pulse on the target qubit, $a_i^("DL" Q i)$, and the amplitude of a $pi$-pulse on any other qubit $j$, $a_j^("DL" Q i)$. The hatched gray area corresponds to cross-driving of far detuned qubits ($tilde$2 GHz), see text for details. White matrix elements without annotation correspond to DL-qubit pairs with cross-driving ratios $< - 1.6$.
  ]
)
<fig:drive_crosstalk>

During the execution of multi-qubit quantum circuits, individual qubits are susceptible to off-resonant driving mediated by microwave pulses applied to drive lines designed to address other qubits. Ensuring low cross-driving is therefore essential for the successful execution of the surface code.

We characterize the coupling rates of each drive line (DL $Q i$) to all other qubits on the device, by measuring the excited state population of qubit $Q j$ after applying a 100-ns-long Gaussian drive pulse to drive line DL $Q i$ at the frequency of qubit $Q j$. We sweep the pulse amplitude and fit a cosine function to the measured data to obtain the amplitude $a_j^("DL" Q i)$ corresponding to a $pi$-rotation induced on qubit $Q j$. As a measure of cross-driving, we normalize each value by the $pi$-pulse amplitude of the target qubit $a_i^("DL" Q i)$ to obtain the cross-driving ratios, of which we show the negative logarithm $- log_10 (a_j^("DL" Q i) a_i^("DL" Q i))$ in Fig.~#panel(<fig:drive_crosstalk>, ""). Given the chosen pulse duration and the maximum drive rate which we can apply without compressing the up-conversion IQ-mixer, this method allows us to resolve cross-driving ratios down to about $- log_10 (a_j^("DL" Q i) a_i^("DL" Q i)) approx - 1.6$, or equivalently a Rabi rotation angle of 4.6 degrees. We find the off-diagonal elements of the cross-driving matrix on average 1.5 orders of magnitude smaller than the drive rate of the target qubit, which provides an upper bound for the cross-driving of $Q j$ via DL $Q i$, since pulses applied to DL $Q i$ during the execution of the surface code are detuned from the frequency of $Q j$.

Some auxiliary-data qubit pairs in physical proximity exhibit larger crosstalk, most likely mediated by the qubit-qubit coupling resonator. However, for all these pairs, the drive line addresses a qubit in the other frequency band (see Fig.~#panel(<fig:device>, "a") and Fig.~#panel(<fig:device>, "c") for a visual representation of the geometry and the frequency bands) than the cross-coupled qubit (see hatched region in @fig:drive_crosstalk), which strongly suppresses the effective cross-driving during device operation. Taking both the relative detunings and the experimentally characterized cross-driving ratios into account, we estimate the gate error induced on $Q j$ resulting from applying a $pi$-pulse on $Q i$ via DL $Q i$ and find that the gate error is smaller than 0.01% for all auxiliary-data qubit pairs except for DL X3 - D9 and DL X2 - D1 with estimated gate errors of 0.06% and 0.17%, respectively.

For qubit pairs within the same frequency band, we find that the expected gate error is smaller than 0.2% for all pairs except for the drive line DL D5 and qubits D1 and D4, for which the expected gate errors are 19.2% and 16.6%, respectively. We attribute the stronger cross-coupling for these elements to the crossover between DL D5 and the qubit-qubit couplers connecting Z1-D1 and D4-X2 (see Fig.~#panel(<fig:device>, "b"). As crosstalk on that scale would significantly impact the execution of the surface code, we compensate the cross-driving of DL D5 on D1 and D4 with an interferometric cancellation drive pulse which has opposite amplitude but is otherwise identical to the pulse arriving at D1 via DL D5.

Note that this characterization measurement was performed in a separate cooldown of the same device.

== Flux crosstalk
<flux-crosstalk>

During the execution of a two-qubit gate, the transition-frequencies of both qubits are tuned to an intermediate interaction frequency (@app:two_qubit_gates), at which the sensitivity of the qubit-frequency to flux is increased. Consequently, the parallel execution of two-qubit gates requires a careful flux crosstalk characterization and compensation.

We characterize the coupling of each flux line on the device to all qubits using a sequence of Ramsey experiments. In particular, we measure the effect of the flux line with target qubit $Q i$ (FL $Q i$) on any qubit $Q j$ by sweeping the amplitude $V_i$ of a voltage pulse on FL $Q i$ and measuring the phase $phi_j$ induced on $Q j$ in a Ramsey experiment. During the experiment, $Q j$ is flux-tuned away from its idle frequency to increase its flux sensitivity and thereby increase the signal-to-noise ratio of the measured phase. We convert the measured phase to frequency of $Q j$, $omega_j=phi_j/tau_"fp"$, with $tau_"fp"=60$ns the duration of the flux pulse applied on FL $Q i$, which is close to the mean two-qubit gate duration on our device. Finally, we convert the frequency $omega_j ( V_i )$ to a flux $Phi_j ( V_i )$ dependent on the applied voltage $V_i$ and fit a linear function to it, whose slope $d Phi_j \/ d V_i$ corresponds to an element of the flux crosstalk matrix $bold(C)$. Repeating this procedure for all flux lines and all qubits, we obtain the flux crosstalk matrix. For each flux line FL $Q i$, we normalize all crosstalk elements with respect to the targeted coupling on $Q i$, i.e. $d Phi_i \/ d V_i$, to obtain the cross-flux ratio, which we show on a base-ten logarithmic scale in Fig.~#panel(<fig:flux_crosstalk>, "a")
#place(top + center, scope: "parent", float: true)[
// [figvision] imgs/flux_xtalk_ab_20211110_130546.png
// Two side-by-side 17x17 matrices, (a) and (b), sharing one colour bar.
// Rows = flux lines FL Z1, FL Z2, FL Z3, FL Z4, FL X1, FL X2, FL X3, FL X4, FL D1 ... FL D9;
// columns = qubits Qj in the same order.
// Colour bar (right, green): "Cross flux ratio log10 |(domega/dV)_i / (domega/dV)_j|",
// from -5 (white) to 0 (dark green).
// (a) Diagonal 0.0; off-diagonal printed values run from about -1.9 to -5.9, with the
//     strongest couplings (-1.9 to -2.9) clustered around the Z/X block and a few
//     NNN cells (e.g. FL D9-Z4 -2.9).
// (b) Same layout after the crosstalk mitigation: off-diagonals are uniformly more
//     negative, about -4.4 to -6.5 and the pale cells dominate, i.e. an additional
//     order of magnitude of suppression relative to (a).
// Both matrices are symmetric in structure (diagonal-dominant, block structure following
// the coupler graph); column labels and row labels are identical.
#figure(scope: "parent", placement: auto, image("imgs/flux_xtalk_ab_20211110_130546.png", width: 100%),
  caption: [
    Flux crosstalk characterization and compensation. #strong[a]~Measured flux crosstalk matrix normalized by its diagonal, for a $60 "ns"$ net-zero flux pulse and without crosstalk compensation (see text for details). #strong[b]~Measured flux crosstalk matrix with a single round of flux crosstalk compensation calibrated based on the matrix shown in #strong[a]. Red numbers indicate a negative sign of $"d" Phi_j "d" V_i$.
  ]
)
<fig:flux_crosstalk>
]

We find that crosstalk (off-diagonal elements) is on average about three orders of magnitude smaller than the target couplings (diagonal elements). The total induced flux $arrow(Phi) = ( Phi_1 , dots.h , Phi_17 )^"T"$ in the SQUID loops when applying voltage pulses with amplitude $arrow(V) = ( V_1 , dots.h , V_17 )^"T"$ is given by $arrow(Phi) = upright(bold(C)) arrow(V)$ Hence, to induce a target flux vector $arrow(Phi)'$, we program the amplitudes $arrow(V)' = upright(bold(C))^(- 1) arrow(Phi)'$ which compensates for the flux line crosstalk between all qubits on the device.

To verify the effectiveness of our compensation scheme, we repeat the crosstalk characterization measurement with activated flux crosstalk compensation, which yields $tilde(upright(bold(C)))$, see Fig.~#panel(<fig:flux_crosstalk>, "b"). The resulting off-diagonal elements of $tilde(upright(bold(C)))$ are suppressed by two additional orders of magnitude. To further reduce the flux crosstalk in our experiments, we apply the crosstalk compensation method recursively by using $tilde(upright(bold(C)))^(- 1)$ as a second compensation matrix.

== Measurement-induced dephasing
<measurement-induced-dephasing>
A successful implementation of the surface code requires repeated readout of a subset of auxiliary qubits without disturbing the state of any other qubits. However, in the presence of finite readout crosstalk, a readout pulse on an auxiliary qubit can off-resonantly excite the readout resonator of another qubit, thereby leading to dephasing and/or coherent phase rotations on that other qubit.

To characterize this effect, we sweep the amplitude of the readout pulse of an auxiliary qubit Qi while measuring the phase of another qubit Qj in a Ramsey experiment @Heinsoo2018. We fit the Ramsey-fringes contrast to a Gaussian model and the phase deviation to a quadratic model, from which we extract the measurement-induced dephasing rate $Gamma_(i j)$, and the coherent phase rotation $Delta phi_(i j)$ for the untargeted qubit Qj when reading out Qi. The additional dephasing rate can be related to a phase-flip probability $P_phi^(i j) = [ 1 - exp ( - Gamma_(i j) tau_"RO" ) ] 2$, where $tau_"RO"$ is the readout pulse duration.

We characterize the measurement-induced dephasing of all auxiliary qubits on any other qubit, see Fig.~#panel(<fig:measurement_induced_dephasing>, ""). Note that for this measurement, the qubit idle frequency of X1 was changed from 6.097$ $GHz to 4.429$ $GHz to avoid a microscopic two-level defect whose frequency drifted towards X1's idle frequency.

On average, we observe a phase-flip probability of $0.09 "%"$ and a coherent phase rotation of $0.6^compose$. In our implementation of the surface code, all Z-type (X-type) auxiliary qubits are measured simultaneously, and therefore their mutual measurement-induced dephasing is not a concern (hatched region in @fig:measurement_induced_dephasing). We observe the largest dephasing ($P_phi = 2.3 "%"$ and $Delta phi = 13.4^compose$) on auxiliary qubit Z2, when reading out auxiliary qubit X2, which we attribute to cross-driving of the readout resonator of Z2 by the readout signal targeting X2. This dephasing could partially explain the higher mean syndrome element $sigma_m^("Z" 2)$, compared to the other mean syndrome elements (see Fig.~#panel(<fig:stabilizers_state_init>, "c").

// [figvision] imgs/measurement_induced_dephasing_20211110_124822.png
// Two 8x17 matrices, rows = measured qubit (Z1-Z4, X1-X4; vertical label "Measured
// qubit Qi"), columns = dephased qubit Qj (Z1-Z4, X1-X4, D1-D9).
// (a) Phase flip probability P_phi (%) with a log colour bar 0.01-1.00 (violet).
//     Every cell is printed; most cells are 0.0 or 0.1-0.2. Two large values stand out:
//     X1-Z1 = 1.9 and X2-Z2 = 2.3 (dark violet). The block of columns Z1-X4 for rows
//     without a shared coupler is hatched grey (not measured), as are the two diagonal
//     sub-blocks except the bolded neighbour pairs.
// (b) Phase rotation Delta phi (deg) with a log colour bar 0.1-10.0. Same layout; values
//     are 0.1-4.2, with X2-Z2 = 13.4 deg (darkest), X1-Z1 = 2.7, D5-X3 = 4.2,
//     D3? (Z3 column) = 1.8, X4-D5 = 1.3. Hatched blocks identical to (a).
// Reading: dephasing is dominated by the measured qubit's own neighbour partners
// (Z1<->X1, Z2<->X2) and is negligible for non-neighbouring data qubits.
#figure(placement: auto, image("imgs/measurement_induced_dephasing_20211110_124822.png", width: 100%),
  caption: [
    Measurement-induced dephasing. #strong[a]~Phase flip probability and #strong[b] coherent phase rotation when measuring auxiliary qubits, on any other qubits. The hatched gray area corresponds to auxiliary qubits which are read out simultaneously in the surface-code experiment (see text for details).
  ]
)
<fig:measurement_induced_dephasing>

In future work, we expect that we could correct for the coherent phase rotations by utilizing virtual-$Z$ rotations of equal magnitude and opposite sign.

= Readout characterization
<app:readout_characterization>

== Three-state readout
<three-state-readout>
// [figvision] imgs/three_level_ro_20211110_132404.png
// IQ-plane scatter of the integrated readout signal for a three-level transmon.
// Main axes: integrated quadrature u1 (horizontal, -4.5..9) vs u2 (vertical, -4..7),
// both arbitrary units. Three Gaussian clouds of ~2000 points each: |0> (blue) centred
// near (-1.5, 0), |1> (red) near (4.5, -0.2), |2> (dark grey) near (5.8, 4.8). White
// dashed circles mark the cloud centres (means). Shaded polygons define the three
// classification regions (light blue, salmon, grey) separated by straight decision lines.
// Marginal histograms: top (counts vs u1) shows the three well-separated peaks, each
// reaching about 300 counts for |0>/|2> and slightly less for |1>; right (counts vs u2)
// shows the overlapping u2 projections of |1> and |2>. Legend at top right: |0>, |1>, |2>.
// The key feature is that |1> and |2> are partially overlapping in u2 but separable in u1.
#figure(placement: auto, image("imgs/three_level_ro_20211110_132404.png", width: 100%),
  caption: [
    Three-state readout characterization of auxiliary qubit X4 presented as a representative example. We show the first 3000 of the $10^5$ single-shot measurements for each of the three state preparations, after preselection. The blue, red, and black areas delimit the regions of the integrated quadrature plane in which a measured data point is assigned to $| 0 ⟩$, $| 1 ⟩$ and $| 2 ⟩$, respectively. We indicate the mean (white dot) and the $1 sigma$ confidence ellipse (white dashed line) of each Gaussian distribution. The marginal histogram distributions of $u_1$ and $u_2$ are shown in the top and right panel, respectively.
  ]
)
<fig:three_level_readout>

We dispersively read out the state of the transmon qubits by applying a Gaussian-filtered ($sigma = 10 "ns"$) rectangular pulse with a pulse duration of 200 ns to auxiliary qubits and 300 ns to data qubits, see Fig.~#panel(<fig:interaction_frequencies>, "a") for an example waveform.

To optimally distinguish between the first three states of the transmon, we integrate the complex-valued downconverted signals $s ( t )$ in real-time on the UHFQA (see @app:experimental_setup) with two sets of complex-valued, 400-ns-long integration weights $w_i ( t )$ @Walter2017 @Heinsoo2018 @Kurpiers2018 @Magnard2018 @Lacroix2020 to obtain
$ u_i = "Re" { integral_0^(t_"int.") s ( t ) w_i ( t ) upright(d) t } . $
We use the integration weights
$ w_1 ( t ) &= s_(| 1 ⟩)^ast ( t ) - s_(| 0 ⟩)^ast ( t ) comma \
  w_2 ( t ) &= s_(| 2 ⟩)^ast ( t ) - s_(| 0 ⟩)^ast ( t ) - \
    & - (frac(integral w_1 ( t ) (s_(angle(2)) ( t ) - s_(angle(0)) ( t )) upright(d) t, integral abs (w_1 ( t ))^2 upright(d) t)) w_1 ( t ) , $
where $s_i ( t )$ is the averaged measured readout-resonator response for a qubit prepared in state $i in (| 0 ⟩, | 1 ⟩, | 2 ⟩)$.

To characterize the single-shot readout, we prepare the qubit $10^5$ times in each of the three basis states ($| 0 ⟩$, $| 1 ⟩$, and $| 2 ⟩$), and measure the integrated resonator response yielding a pair of values $( u_1 , u_2 )$ for each experimental run. Prior to applying the state-preparation pulses we perform a pre-selection readout and reject measurements in which the qubit is not in the ground state. We estimate the thermal population for each qubit as the probability to be in $| 1 ⟩$ or $| 2 ⟩$ after this pre-selection readout, see @tab:qubit_measured_parameters. We fit the distribution of measured $( u_1 , u_2 )$ pairs to a trimodal Gaussian mixture model, associating each qubit state to one of the Gaussian components, see Fig.~#panel(<fig:three_level_readout>, ""). To characterize two-state readout, we use only the Gaussian components of the mixture model corresponding to the $| 0 ⟩$ and $| 1 ⟩$ state. Based on the fitted model, we assign the individual readout outcomes to the most likely qubit state and compute the $N$-level readout error (@tab:qubit_measured_parameters) $epsilon_"RO"^(( N )) = 1 - 1 / N sum_(i = 1)^N P ( i | i ) ,$ where $P ( i | i )$ is the probability of correctly assigning the state $i$ to a qubit prepared in the state $i$.

== Flux pulse-assisted readout
<flux-pulse-assisted-readout>
We make use of the flux-tunability of our transmon qubits to dynamically change the qubit frequency for the duration of the readout, see Fig.~#panel(<fig:fpaRO>, "a"). This allows us to optimize readout parameters #emph[in-situ], such as the readout resonator-qubit detuning and the dispersive shift $chi$, see~@tab:qubit_measured_parameters for the parameters during readout. We employ this method for all data qubits to reduce the detuning with the readout resonator during the readout, and for auxiliary qubit X1 to avoid a microscopic defect located close to its idle frequency (Fig.~#panel(<fig:interaction_frequencies>, "c").

We use Gaussian-filtered, rectangular flux pulses with short rising and falling edges ($sigma = 0.5$~ns) in order to minimize coupling to defects. The flux pulse lasts longer than the readout pulse (see also @app:pulse_sequence) because we continue integrating the readout signal while the readout resonator field is ringing down.

// [figvision] imgs/FPAro_20211110_132526.png
// Two stacked panels sharing the time axis (0-450 ns, bottom label "Time t (ns)").
// (a) Frequency omega/2pi (GHz, 3.5-7.2) vs t. Purple solid line: dressed readout-tone
//     frequency omega'_Q/2pi, flat at 6.7 GHz for the whole window. Red solid line:
//     qubit frequency omega_Q/2pi, which sits at 4.0 GHz before t~10 ns, rises in a
//     trapezoid to 5.25 GHz during roughly 10-340 ns, then returns to 4.0 GHz.
//     Pale red dotted line at 3.95 GHz marks the bare/idle frequency.
// (b) Amplitude a (mV, -25..25) vs t. A purple tone burst with ~15 ns raised-cosine
//     ramps: flat envelope of about +-23 mV between 20 and 335 ns, zero outside. The
//     burst coincides with the red frequency excursion in (a) - the parametric drive
//     window.
#figure(placement: auto, image("imgs/FPAro_20211110_132526.png", width: 100%),
 caption: [
 Pulse sequence used for flux pulse-assisted readout of qubit D1. #strong[a] The qubit transition-frequency (red solid line) is tuned from its lower sweet spot value (red dotted line), $omega_Q tilde 4 $GHz, to a value $omega'_Q$ closer to the readout resonator frequency (purple line), using a fast flux pulse. #strong[b] Intermediate frequency signal programmed on the AWG to generate the readout pulse.
 ]
)
<fig:fpaRO>

= Numerical Simulations
<app:numerical_simulations>
== General considerations
<general-considerations>

In this section, we describe how the simulations of the experiment are performed. These simulations are based on the measured device characteristics including the individual qubit coherence times, readout errors (see~@tab:qubit_measured_parameters) and spurious $Z Z$ interactions.

=== Device Hamiltonian
<device-hamiltonian>

The system Hamiltonian includes a flux-tunable transmon Hamiltonian per qubit mode and capacitive-coupling interactions of the form~$ℏ g_(k , k') hat(n)_k hat(n)_(k')$, where~$hat(n)_k$ is the charge operator associated with the~$k$th qubit, and~$ℏ g_(k , k')$ is the capacitive coupling strength between the pair of qubits~$( k , k' )$. Single-qubit gates are modeled by a microwave-drive Hamiltonian of the form~$2 e hat(n)_k V_k ( t )$, where~$V_k ( t )$ is a time-dependent voltage. Two-qubit gates are modeled by time-dependent flux pulses~$( phi_k ( t ) , phi_(k') ( t ) )$ on both target and control qubits in the pair~$( k , k' )$. Here,~$phi_k$ is the external flux applied to the SQUID loop of qubit~$k$.

To facilitate the comparison to spectroscopy data used for gate calibration, we move to the flux-dependent basis which diagonalizes the device Hamiltonian, resulting in an effective model of the form
$ hat(H)_"eff" ( t ) / ℏ = & sum_k omega_k [phi_k (t)] b_k^dagger b_k + alpha_k / 2 b_k^(dagger 2) b_k^2 - i Omega_k (t) (b_k - b_k^dagger) \
  & + sum_(k < k') xi_(k , k') [phi_k (t), phi_(k') (t)] b_k^dagger b_k b_(k')^dagger b_(k') \
  & + dots.h $ <eq:effective-circuit-hamiltonian>
Here, $omega_k [phi_k (t)]$, $alpha_k$ and $Omega_k (t)$ correspond, respectively, to the frequency, anharmonicity and effective drive amplitude of the $k$th qubit mode, while $xi_(k , k') [phi_k (t), phi_(k') (t)]$ is the strength of the cross-Kerr (or $Z Z$) interaction of the form $b_k^dagger b_k b_(k')^dagger b_(k')$ between the pair of modes $(k, k')$. Note that the explicit dependence of the qubit frequencies and cross-Kerr interactions on the flux biases $phi_k$ is omitted below. This model accounts for the change in the $Z Z$-interactions with the bare mode frequencies, and therefore with the external flux biases $\{ phi_k (t), phi_(k') (t) \}$ during the two-qubit gates. Higher-order interactions represented by the dots in @eq:effective-circuit-hamiltonian are not included in this effective model. Indeed, the impact of such nonidealities is minimized by device design and careful scheduling of the two-qubit gates, as described in @app:crosstalk and @app:two_qubit_gates.

We describe relaxation and dephasing with the effective zero-temperature master equation for the system's density matrix $rho (t)$
$ dot(rho) ( t ) &= - i [ hat(H)_"eff" (t) / ℏ , rho (t) ] \
  &+ sum_k gamma_(1 , k) cal(D) [b_k] rho (t) \
  &+ sum_k gamma_(phi , k) [phi_k (t)] cal(D) [b_k^dagger b_k] rho (t) , $ <eq:effective-master-equation>
where $gamma cal(D) [hat(o)] bullet = cal(D) [hat(c)] bullet = hat(c) bullet hat(c)^dagger - \{ hat(c)^dagger hat(c) , bullet \} / 2$ for the collapse operator $hat(c) = sqrt(gamma) hat(o)$, and $gamma_(1 , k)$ and $gamma_(phi , k) [phi_k (t)]$ are, respectively, the decay and dephasing rates associated to mode $k$. The dephasing rates of the qubits involved in two-qubit gates incorporate a flux-bias dependence $gamma_(phi , k) [phi_k (t)]$ which is determined experimentally.

=== Numerical solver
<numerical-solver>

To make the simulation of the 17-qubit chip numerically tractable, with each qubit modeled as a $d$-dimensional Kerr-nonlinear oscillator, we employ the method of Monte Carlo wavefunctions~@Dalibard1992 @Molmer1993 @Dum1992 as implemented in QuTiP's `mcsolve` @Johansson2012a. Because it evolves wavefunctions of size $d^17$ rather than the $d^17 times d^17$ density matrix necessary for a master-equation simulation, the memory requirements are significantly reduced in this approach with respect to the master-equation simulation.

Succinctly, the Monte Carlo method evolves a stochastic wavefunction~$| psi ( t ) ⟩$ according to a non-Hermitian Hamiltonian~$H_"nh" = H_"eff" ( t ) - i ℏ / 2 sum_l c_l^dagger c_l$, where~$c_l$ are the collapse operators of the system's master equation. Time-evolution under $H_"nh"$ for a time $d t$ leads to a decrease of the norm-square of the wavefunction by $d p = sum_l d t ⟨ psi ( t ) | c_l^dagger c_l | psi ( t ) ⟩ lt.double 1$. At time~$t + d t$, the wavefunction~$| psi ( t + d t ) ⟩$ is renormalized with probability~$1 - d p$, or subject to a single quantum jump with probability~$d p$. In the case of a jump, the wavefunction collapses to the state~$c_l | psi ( t ) ⟩ ⟨ psi ( t ) | c_l^dagger c_l | psi ( t ) ⟩^(1 2)$ with relative probability~$⟨ psi ( t ) | c_l^dagger c_l | psi ( t ) ⟩ sum_(l') ⟨ psi ( t ) | c_(l')^dagger c_(l') | psi ( t ) ⟩$.

One realization of this stochastic evolution is known as a quantum trajectory, and an advantage of this approach is that multiple such trajectories can be numerically computed in parallel @Molmer1993. With a sufficiently large number of trajectories, one can recover the solution of the master equation in~@eq:effective-master-equation as

$ bb(E) [ | psi ( t ) ⟩ ⟨ psi ( t ) | ] = rho ( t ) . $ <eq:mcsolve-convergence>

Expectation values of an observable~$hat(O)$ are similarly obtained from

$ bb(E) [ ⟨ psi ( t ) | hat(O) | psi ( t ) ⟩ ] = "tr" [ rho ( t ) hat(O) ] . $ <eq:mcsolve-convergence-observable>

We adjust the solver's error-tolerance parameters such that~@eq:mcsolve-convergence holds numerically (see~`qutip.Options`). To do so, we determine the appropriate solver parameters by comparing the result of~`qutip.mcsolve` to that produced by the complete master-equation solver~`qutip.mesolve` for systems of up to seven qubits and error-tolerance parameters set to numerical accuracy. In our stochastic simulations, we determine the number of trajectories that are needed by analyzing the convergence of~@eq:mcsolve-convergence-observable for all the stabilizer and logical-qubit operators. We found that 50k trajectories were sufficient to estimate these expectation values with a sampling uncertainty of less than $1 "%"$, for the reduced model that we introduce below.

=== Measurement model
<measurement-model>

Qubit measurements are modeled by letting the qubit idle for a time equal to the experimental readout time, followed by the projection of the stochastic wavefunction according to $| psi ⟩ arrow.r frac(Pi_k^j | psi ⟩, sqrt(p_k^j)) ,$ where $Pi_k^j = | j ⟩ ⟨ j |_k$ is the single-qubit projector of the qubit~$k$, ~$j in ( 0 , 1 )$ corresponds to the measured qubit state, and $p_k^j = ⟨ psi | Pi_k^j | psi ⟩$ is the probability of measuring qubit~$k$ in the state~$j$. We model qubit readout errors by flipping the result of the measurement with a probability that is computed from the readout assignment matrix for each qubit.

=== Single-qubit gate model
<single-qubit-gate-model>

Single-qubit gates on qubit~$k$ are implemented with a Gaussian DRAG waveform with carrier frequency~$omega_k$~@Motzoi2009 and additional virtual-$Z$ gates~@Mckay2017 when needed. To speed up the simulations, we drop counter-rotating terms following the usual rotating-wave approximation (RWA). We test this approximation by first comparing the average gate error per qubit with and without the counter-rotating terms, which we find to be limited by decoherence instead. Second, we have found no significant discrepancy in the estimated value of the logical qubit operators when using a RWA for simulating circuits with up to seven-qubits in a setup similar to that of Ref.~@Andersen2020b for up to five quantum-error-detection cycles.

=== Two-qubit gate model
<two-qubit-gate-model>

CZ gates between a pair of qubits~$( k , k' )$ are emulated by the free evolution of the effective Hamiltonian~$( pi t_g - xi_(k , k') ) b_k^dagger b_k b_(k')^dagger b_(k')$, where~$t_g$ is the experimental gate time. During the gate time, we change the dephasing rates~$gamma_(phi , k)$ and~$gamma_(phi , k')$ of the two qubits involved in the gate to the effective values corresponding to the coherence times measured experimentally for the 24 different controlled-$Z$ gates at the qubit interaction frequencies, see @app:two_qubit_gates
Given that the qubits are flux-biased at specific interaction frequencies during the gate time, we also account for the residual cross-Kerr interactions by adjusting the interaction strengths $xi_(k , k')$ of the gate qubits with their neighbors on the device. With this model, we simulate an average gate infidelity of $0.9 "%"$, which is consistent with the median of the interleaved randomized benchmarking error of $1.2 "%"$. Data post-selection in the experiment mitigates the impact of leakage to a large extent and enables the use of a simpler model of the two-qubit gates which involves levels only within the computational subspace. As discussed in~@app:two_qubit_gates, the performance of some of the two-qubit gates is limited by the interaction of qubits with strongly coupled two-level defects, an effect which is not included in the model used for the simulations.

=== Pulse schedule
<pulse-schedule>

Combining our model for the single- and two-qubit gates with projective measurements, we concatenate these operations to compose the pulse sequences used in the quantum error correction experiment, including buffer times, state-preparation and measurement pulses.

== Reduced 9+4 model
<reduced-94-model>

By using the Monte Carlo solver we can simulate a 17-qubit system in a reasonable time using a general-purpose workstation: approximately 25~s per trajectory per error-correction cycle with a clock speed of~$tilde 3$~GHz and using about $6$~GB of RAM. However, improvements in runtime and potential extensions of this method to even larger systems are possible with effective models with a reduced number of qubits. In this section, we describe an approximate model that employs a total of 13 qubits and is obtained by tracing out the auxiliary-qubit modes that do not participate in a given stabilizer measurement.

In practice, this effective model significantly reduces the simulation requirement to about 2~s per trajectory per QEC cycle while using less than $1$~GB of memory. A schematic illustration of the two models in consideration is provided in~@fig:schematic-9plus4-model.

#place(top + center, scope: "parent", float: true)[
// [figvision] imgs/9plus4_vs_17_model.png
// Three panels: (a) reduced 9+4 lattice, (b) full 17-qubit lattice, (c) logical decay.
// (a) Two diagrams of the reduced model. Left: "Z - stabilizer measurement" of
//     rho(red, green) (x) rho(light blue). Green stabilizer faces Z1-Z4 sit on red data
//     qubits; the X qubits (pale blue) are faded because they are traced out; the graph
//     edges are grey. Right: "X - stabilizer measurement" rho(red, blue) (x) rho(pale
//     green), the mirror image with blue X faces and faded green Z qubits. Triangular
//     boundary faces are drawn faintly.
// (b) "QEC cycle": rho(red, green, blue) with both Z (green) and X (blue) faces active
//     simultaneously on the same diamond lattice (the full 17-qubit model).
// (c) Two decay plots of the logical expectation value vs cycle index m (1-8):
//     left <Z_L> (green), right <X_L> (blue). Each has four curves: 9+4 model solid with
//     downward triangles and 17-qubit model dashed with downward triangles, for the two
//     logical input states (|0>_L / |1>_L and |+>_L / |->_L). |0>_L starts at 0.97 and
//     falls to 0.70 by m=8; |1>_L rises from -0.97 to -0.72; |+>_L falls 0.97 to 0.73;
//     |->_L rises from -0.95 to -0.71. Solid and dashed curves lie almost on top of
//     each other, i.e. the 9+4 reduction reproduces the 17-qubit model.
#figure(scope: "parent", placement: auto, image("imgs/9plus4_vs_17_model.png", width: 100%),
 caption: [
 #strong[a] Illustration of the 9+4 model. Logical~$Z$ ($X$) stabilizer measurements are simulated by tracing out the state of the~X-type (Z-type) auxiliary qubits prior to the stabilizer measurement.~$rho ( { bullet } )$ refers to a density matrix describing the subsystem~${ bullet }$ of qubits indexed by color. #strong[b] Full 17-qubit model includes all qubits at all times in the simulation. #strong[c] Comparison between the decoded simulated data for the reduced 9+4- and the full 17-qubit model. The parameters of the simulation are those measured on the device and provided in~@tab:qubit_measured_parameters. We observe an excellent agreement of the resulting logical~$T_1$ and~$T_2$ times between these two models.
 ]
) <fig:schematic-9plus4-model>
]

To introduce the "9+4" model, we first consider the Z-type stabilizer measurements which constitute the first half of the QEC cycle. As illustrated in~Fig.~#panel(<fig:schematic-9plus4-model>, "a") (see also~Fig.~#panel(<fig:stabilizer>, "a"), the circuit only involves single- and two-qubit operations on the nine data and four Z-type auxiliary qubits. Meanwhile, the measurement of the X-type auxiliary qubits, which occurs in 400~ns, projects those qubits into a product state of the form~$| X_n ⟩ = ⨂_(k'' in upright(X - a u x .)) | j_(k'') ⟩$ with~$j_(k'') in ( 0 , 1 )$. By assuming that the state of the X-type auxiliary qubits remains close to a product state during the full semi-cycle duration, it is possible to trace-out those qubit modes from the Hamiltonian. Following the measurement, the best description of the auxiliary modes is given by a product of single-qubit density matrices of the form~$| 1_(k'') ⟩ ⟨ 1_(k'') | e^(- t T_(1 , k'')) + | 0_(k'') ⟩ ⟨ 0_(k'') | ( 1 - e^(- t T_(1 , k'')) )$ if the measurement result for qubit~$k''$ is 1, and~$| 0_(k'') ⟩ 0_(k'') |$ otherwise. In other words, this corresponds to the effective model
$ hat(H)_"red" ( t ) / ℏ &= sum_k lr( omega_k + sum_(k'' in X) xi_(k , k'') e^(- t / T_(1 , k'')) ⟨ b_(k'')^dagger b_(k'') ⟩ ) b_k^dagger b_k \
  &+ alpha_k / 2 b_k^(dagger 2) b_k^2 - i Omega_k (t) (b_k - b_k^dagger) \
  &+ sum_(k < k') xi_(k , k') b_k^dagger b_k b_(k')^dagger b_(k') , $ <eq:effective-reduced-circuit-hamiltonian>
where the subindices $k$ and $k'$ run over data and Z-type auxiliary qubits, and $⟨ b_(k'')^dagger b_(k'') ⟩$ is the expectation value of $b_(k'')^dagger b_(k'')$ immediately after the preceding X-type auxiliary measurement. After evolving the 13-qubit wavefunction under $hat(H)_"red" (t)$ for the full semi-cycle, the projective measurement of the four Z-type auxiliary qubits is performed and the state of the system at time $T$ is updated as
$ | psi (T) ⟩ | Z_n ⟩ arrow.r | psi (T) ⟩ | X_n ⟩ , $ <eq:state-update>
where $| psi (T) ⟩$ describes the state of the data qubits after the projection. We perform the simulation of the following X-type stabilizer measurement in a similar way.

In our simulations, we account for some of the noise associated with the auxiliary qubits that were traced out. First, as~@eq:effective-reduced-circuit-hamiltonian shows, the cross-Kerr interaction between an auxiliary qubit that has been traced out and its neighboring data qubits varies in time to account for the auxiliary qubit's finite~$T_1$ time. Second, the idling state of a traced-out auxiliary qubit~$k''$ after its measurement is modeled by flipping~$| j_(k'') ⟩$ from $| 1 ⟩$ to $| 0 ⟩$ with probability~$1 - exp (- T_"semi-cycle" T_(1 , k''))$, where~$T_"semi-cycle"$ is the time of a quantum error correction semi-cycle. The resulting auxiliary-qubit state from this process is used to simulate the next quantum error correction cycle.

To test the validity of this reduced model, Fig.~#panel(<fig:schematic-9plus4-model>, "c") shows a comparison between the results obtained for the reduced 9+4- and 17-qubit models for up to eight QEC cycles. The parameters of the simulation reflect those of the measured device, as discussed above. We show the decoded data from a logical-state preservation simulation as a function of the number of QEC cycles, from where we can infer the logical~$T_1$ and~$T_2$ for the two models. We use the decoder described in~@app:decoding with weights that are extracted from the simulation data for each model. The result shows an excellent agreement between the reduced and full models of the experiment, with a discrepancy that is contained in the error of the exponential fit. This observation gives us confidence about the accuracy of the 9+4 model used to perform the simulations reported in the main text. We note that, while limited in some respects, our effective model goes beyond previous approaches~@OBrien2017 @Huang2020 in the treatment of correlated errors (spurious~$Z Z$) and dissipation in continuous time.

= Stabilizers
<app:stabilizers>
The distance-three surface code comprises eight stabilizer operators, i.e.~products of $hat(Z)$ or $hat(X)$ Pauli operators of a subset of the nine data qubits, as listed in @tab:stabilizers. We characterize the quantum circuit realizing each ^Ai (Fig.~#panel(<fig:stabilizer>, "a,b")) for the $2^N$ input states of the $N in ( 2 , 4 )$ data qubits of a given plaquette (Fig.~#panel(<fig:device>, "a") and compute the stabilizer error $epsilon = 1 - 1 / 2^N sum_(n = 1)^(2^N) 1 / 2 | overline(s)_n^(A i) - overline(s)_(n , "ideal")^(A i) | ,$ see @tab:leakage_schemes
#block[
#place(top + center, scope: "parent", float: true)[
#figure(
 align(center)[#table(
    stroke: none,
 columns: 4,
 align: (center,left,center,center,),
    table.hline(stroke: 0.8pt),
 table.header([Symbol], [Stabilizer], [$epsilon$ (%)], [$epsilon_"sim"$ (%)],),
 table.hline(),
 [$hat(S)^("Z" 1)$], [$hat(Z)_1 hat(Z)_4$], [2.9], [2.8],
 [$hat(S)^("Z" 2)$], [$hat(Z)_4 hat(Z)_5 hat(Z)_7 hat(Z)_8$], [8.4], [5.0],
 [$hat(S)^("Z" 3)$], [$hat(Z)_2 hat(Z)_3 hat(Z)_5 hat(Z)_6$], [6.8], [4.3],
 [$hat(S)^("Z" 4)$], [$hat(Z)_6 hat(Z)_9$], [2.5], [2.0],
 [$hat(S)^("X" 1)$], [$hat(X)_2 hat(X)_3$], [5.7], [6.7],
 [$hat(S)^("X" 2)$], [$hat(X)_1 hat(X)_2 hat(X)_4 hat(X)_5$], [5.9], [3.9],
 [$hat(S)^("X" 3)$], [$hat(X)_5 hat(X)_6 hat(X)_8 hat(X)_9$], [11.8], [4.4],
 [$hat(S)^("X" 4)$], [$hat(X)_7 hat(X)_8$], [4.5], [2.6],
 [], [Weight-two average], [3.9], [3.5],
 [], [Weight-four average], [8.2], [4.4],
 [], [Average], [6.1], [3.9],
    table.hline(stroke: 0.8pt),
 )]
 , caption: [Stabilizers ^Ai of the distance-3 surface code, characterized by the measured stabilizer error ($epsilon$) and the stabilizer error ($epsilon_"sim"$) determined from simulation.]
 , kind: table
 ) <tab:stabilizers>

]

We measure an average weight-two stabilizer error of $3.9 "%"$, which is in good agreement with the $3.5 "%"$ average weight-two stabilizer error extracted from numerical simulations (@app:numerical_simulations). The average weight-four stabilizer error obtained from measurements ($8.2 "%"$) is larger than the one obtained from simulation ($4.4 "%"$), which we identify as most likely due to the interaction with microscopic defects, residual coherent errors in two-qubit gates, and residual crosstalk which are not modeled in our numerical simulations (@app:numerical_simulations).

= Logical state initialization and characterization
<app:logical_state_fidelity>
Here, we describe the characterization of the prepared nine-data-qubit logical states by measuring their quantum state fidelity with respect to (i) the target state, (ii) the target logical subspace, and (iii) states in correctable subspaces.

== Fidelity with respect to the target state
<fidelity-with-respect-to-the-target-state>
While the complete tomographic reconstruction of a generic quantum state $rho$ of $n = 9$ qubits would require the measurement of $4^n = 262144$ independent Pauli correlators ~@Nielsen2000, the measurement of the fidelity with respect to a target logical state $rho_|0⟩_"L" = |0⟩_"L" ⟨0|_"L" = hat(cal(P))_"L" hat(cal(P))_"O"$ expressed in terms of the projector $hat(cal(P))_"L"$ onto the logical subspace and the projector $hat(cal(P))_"O"$ onto an eigenstate of $Z_L$
$ hat(cal(P))_"L" hat(cal(P))_"O" &= 1 / 2^9 (1 + hat(Z)_"L") product_(i = 1)^4 (1 + s^("X" i) hat(S)^("X" i)) product_(i = 1)^4 (1 + hat(S)^("Z" i)) \
  &= 1 / 512 sum_(j = 1)^512 gamma_j hat(P)_j $ <eq:rho_z_prod>
requires the measurement of only $2^n = 512$ terms ~@Nigg2014b @Abobeih2021. Here, $s^("X" i)$ are the outcomes of the $X$-stabilizer measurements obtained in the state initialization, $hat(P)_i$ are 9-qubit Pauli correlators obtained from expanding the product in @eq:rho_z_prod, and the $gamma_j$ take values $+1$ or $-1$ depending on the individual outcomes of $\{s^("X" i)\}$. The fidelity $cal(F)_"phys"$ of state $rho$ with respect to $|0⟩_"L"$ is given by
$ cal(F)_"phys" = "Tr" (rho rho_(|0⟩_"L")) = 1 / 512 sum_(j = 1)^512 ⟨ gamma_j hat(P)_j ⟩_rho $ <eq:fid_phys_pauli>
where $⟨ gamma_j hat(P)_j ⟩_rho$ corresponds to the expectation value of the Pauli correlator $hat(P)_i$ in state $rho$.

We evaluate each of the 512 Pauli correlators of @eq:fid_phys_pauli with data collected by executing a single quantum error correction cycle, followed by single-qubit tomography rotations on data qubits and a readout of all qubits. We observe that in ~80.5% of the experimental runs the measurements of $s^("Z" i)$ yields the target value +1 for all four $hat(S)^("Z" i)$, which is in good agreement with the probability of having none of the four Z-type mean syndrome elements signaling an error in the first cycle, $product_i^4 ( 1 - overline(sigma)_1^("Z" i) ) approx 84.5 "%"$, see Fig.~#panel(<fig:stabilizers_state_init>, "c").

For each $⟨ gamma_j hat(P)_j ⟩_rho$, we reject leakage events as detected by our three-state readout scheme (@app:leakage_rejection) and account for readout errors (@app:readout_characterization) on each of the data qubits involved in the correlator. Note that apart from leakage rejection we keep all instances for further data analysis, including those events in which at least one of the four measured $hat(S)^("Z" i)$ values yields $- 1$. Following @eq:fid_phys_pauli, we then take the average over all expectation values to compute $cal(F_"phys")$.

== Fidelity in the logical subspace
<fidelity-in-the-logical-subspace>
Similarly, we evaluate the probability of having prepared a state in the logical subspace as $P_"L" = "Tr" (rho hat(cal(P))_"L") = 1 / 256 sum_(j = 1)^256 ⟨ gamma_j hat(P)_j ⟩_rho$ where the sum extends over the expectation values of the 256 Pauli correlators resulting from the expansion of the projector onto the logical subspace $hat(cal(P))_"L"$. Together with the value of $cal(F_"phys")$ the probability $P_"L"$ yields an estimate for the logical fidelity $cal(F_"L") = cal(F_"phys") P_"L"$, which corresponds to the fidelity of the prepared state with the target logical state conditioned on having successfully projected onto the logical subspace.

== Fidelity with respect to states in correctable subspaces
<fidelity-with-respect-to-states-in-correctable-subspaces>
In the context of quantum error correction, it is insightful to compute the fidelity of the prepared state with respect to any of the states which are equivalent to the target state up to a correctable error. By construction, a data-qubit state projected to the logical $Z$-basis is a $plus.minus 1$ eigenstate of the eight stabilizers $hat(S)^(A i)$ and a $plus.minus 1$ eigenstate of $hat(Z)_"L"$. Thus, there are $2^9 = 512$ distinct eigenstates of the data-qubit space in the logical Z-basis, with pair-wise degenerate syndromes. However, in a simple error correction scheme, each of the $2^8 = 256$ possible syndromes produced by the eight stabilizers is associated to a single corrective action. Consequently, for each of the 256 pairs of eigenstates with a degenerate syndrome, only one of the two eigenstates can be included in a given correctable subspace. To perform error correction most effectively, one includes the eigenstate in the correctable subspace, which can be reached by a Pauli error that is more likely to occur on the physical device.

Specifically, we construct correctable subspaces for $|0 angle_"L"$ in the following way: for each pair of eigenstates with degenerate syndrome, we compute the lowest weight errors which, when applied to $|0 angle_"L"$, lead to these two eigenstates, respectively. With the assumption that lower-weight errors are more likely than higher-weight errors, we preferably include the eigenstate that can be reached via the lowest weight error. If the two eigenstates can only be reached by applying errors of equal weight-$n$, we check how many different errors of weight-$n$ lead to each of the two eigenstates, and include the eigenstate that can be reached by more weight-$n$ errors. Finally, if both eigenstates can be reached by an equal number of weight $n$ errors, we randomly select one of the two eigenstates. Note that with this approach, any correctable subspace includes $| 0 ⟩_"L"$ (trivial +1 eigenstate of all stabilizers and of $hat(Z)_"L"$), as well as all the states, which can be reached by applying a weight-one Pauli error on any one of the data qubits.

We define the fidelity of the prepared state $rho$ with respect to a set of $N$ states ${hat(E)_n |0⟩_"L"}$ as
*$ cal(F)_"c" &= sum_(n = 1)^N "Tr" (rho hat(E)_n |0⟩ ⟨0|_"L" hat(E)_n^dagger) \
  &= 1 / 512 sum_(n = 1)^N "Tr" (rho sum_(j = 1)^512 hat(E)_n gamma_j hat(P)_j hat(E)_n^dagger) $*
where we have made use of @eq:rho_z_prod. We observe that $hat(E)_n hat(P)_j hat(E)_n^dagger = c_(j , n) hat(P)_j$ with $c_(j , n) = plus.minus 1$ because $hat(E)_n$ and $hat(P)_j$ are both tensors of Pauli matrices, and all matrices in the Pauli group commute or anti-commute. Consequently,
$ cal(F)_"c" = 1 / 512 sum_(n = 1)^N sum_(j = 1)^512 c_(j , n) ⟨ gamma_j hat(P)_j ⟩_rho $ <eq:fid_corr_pauli>
can be computed based on the same set of 512 measured expectation values $⟨ gamma_j hat(P)_j ⟩_rho$ with the appropriate combination of sign prefactors $c_(j , n)$. This circumvents the need to measure the expectation value of 512 Pauli correlators for each of the $N = 256$ states spanning the correctable subspace.

We evaluate the fidelity $cal(F)_"c"$ of the prepared state with respect to any state in the correctable subspace for 500 different correctable subspaces randomly chosen according to the procedure described above. We obtain a mean correctable fidelity averaged over the 500 correctable subspaces of $cal(F)_"c" = 96.0 ( 9 ) "%"$. The 4.0(9)% average infidelity, which can also be interpreted as the probability of being in a state which would result in a logical error after a single cycle, is in good agreement with the probability of logical error per cycle $epsilon_"L"=0.032(1)$ deduced from the state preservation of $⟨ hat(Z)_"L" ⟩$, see main text. We observe that $epsilon_"L"$ is slightly smaller, likely due to the fact that the state initialization characterization cannot correct for auxiliary-qubit readout errors, which require several quantum error-correction cycles to be detected.

= Pulse sequence
<app:pulse_sequence>
We realize the quantum circuit presented in @fig:stabilizers_state_init a with a combination of microwave and flux pulses applied to the 17 qubits, see @fig:pulse_sequence for the complete pulse sequence of a single cycle of quantum error correction used to prepare $|0 angle_"L"$.

// [figvision] imgs/pulse_sequence_20211109_234454.png
// Waveform/timing diagram of one QEC cycle, one horizontal lane per qubit (Z1-Z4 green,
// X1-X4 blue, D1-D9 red), with the lattice connectivity drawn as grey edges at left.
// Timeline 0.0-4.1 us with a break around 0.4-0.5 us; a bracket at top marks
// "QEC cycle: 1.1 us". Sequence: readout pulses (rounded rectangles, dotted outlines
// for the non-destructive variant) at the start, then a burst of pi/2 pulses, four
// repeated green blocks (Z stabilizer interactions) and four blue blocks (X stabilizer
// interactions), interleaved CZ gates shown as stepped (dotted) square pulses on the
// data-qubit lanes, then the final readout burst. Green and blue shading highlights the
// Z and X stabilizer windows. Legend: pi-half pulse, pi pulse, CZ gate, readout pulse.
// Neighbour maps: Z1 couples to D1,D4; Z2 to D4,D7; Z3 to D5,D3; Z4 to D9,D6;
// X1 to D2,D1; X2 to D4,D2; X3 to D8,D6; X4 to D7,D8.
#figure(scope: "parent", placement: auto, image("imgs/pulse_sequence_20211109_234454.png", width: 100%),
 caption: [
 AWG pulse sequence for the execution of a single quantum error correction cycle. Single-qubit drive pulses (solid lines), readout pulses (solid lines), and flux pulses (dotted lines) are displayed for each of the 17 qubits, as indicated by the label in the conceptual device representation. Qubit pairs realizing CZ gates are connected by shaded gradients. The time axis is segmented (parallel lines intersecting the axes) during idle times for clarity, see text for details.
 ]
)
<fig:pulse_sequence>
]

The sequence starts with a multiplexed readout of all qubits to herald the ground-state in post-selection. Next, single-qubit drive pulses are applied to a subset of the data qubits to prepare the nine data qubits in one of the four product states $| 0 ⟩^(⊗ 9)$, $hat(X)_"L" | 0 ⟩^(⊗ 9)$, $| + ⟩^(⊗ 9)$ or $hat(Z)_"L" | + ⟩^(⊗ 9)$, each of which is a superposition of the $16$ equivalent instances of the respective target logical state. Thereafter, Z-type stabilizers are executed by applying three simultaneous CZ gates in four sequential time steps, with a dynamical decoupling pulse applied to all data qubits in between the second and the third two-qubit gate time step. Each CZ gate is realized by applying a flux pulse to a data qubit and to the corresponding auxiliary qubit, see the shaded gradient connecting pairs of qubits in Fig.~#panel(<fig:pulse_sequence>, ""). While the Z-type auxiliary qubits are being read out, the X-type stabilizers are realized in a similar fashion as the Z-type stabilizers but with $pi 2$-rotations implementing basis changes before and after the four time steps of CZ gates. Finally, all qubits are read out in the Z-basis after a latency of $800 "ns"$ set by the minimum re-triggering period of our acquisition devices.

= Leakage rejection
<app:leakage_rejection>

While non-computational states can provide a useful resource for example to realize two-qubit gates in transmon qubits, uncontrolled leakage into non-computational states constitutes a source of errors. Leakage has therefore been addressed both theoretically and experimentally by reducing leakage errors @Chen2016 @Negirneac2021, by detecting leakage indirectly on both auxiliary and data qubits using hidden Markov models @Bultink2020 or quantum non-demolition measurement protocols @Stricker2020, by developing leakage-aware decoding schemes @Suchara2015 @Kelly2015, and by converting leakage errors into errors within the computational subspace rendering them correctable in the standard error correction framework @Alferis2007 @Fowler2013 @Ghosh2015a.

For our experimental realization of the surface code we mitigate leakage, particularly of data qubits, by choosing a frequency configuration and two-qubit gate scheme in which only the auxiliary qubits evolve through the second excited state $| 2 ⟩$, keeping the average leakage probability per data qubit and per cycle as low as about two per mill. Furthermore, we detect the remaining leakage events on both the data and auxiliary qubits by implementing a high-fidelity three-state readout scheme (@app:readout_characterization), which allows us to reject all instances of experimental runs with detected leakage events and to study the performance of quantum error correction independent of leakage dynamics @Varbanov2020.

// [figvision] imgs/210810_ZLXL_S17_datadds_retfrac_2rows_v2.png
// Two panels of retained fraction, sharing the horizontal axis "Number of QEC cycles n"
// (0-16). Top panel green for |0>_L, |1>_L; bottom panel blue for |+>_L, |->_L.
// Vertical axis: retained fraction r, 0.2-1.0 (top), 0.2-1.0 (bottom); linear fits drawn
// through each series.
// Legend in each panel: pale markers = data qubits only, mid-tone = auxiliary qubits,
// dark = auxiliary + data qubits (leakage detection applied to that subset).
// Top: data-qubit series stays high (0.98 at n=1 -> 0.72 at n=16, shallow slope);
// aux-qubit series falls faster (0.97 -> 0.25); aux+data series is nearly identical to
// the aux series above n~4 (0.97 -> 0.24). Points at n=1..4,8,10,12,16.
// Bottom: same pattern in blue; data 0.98 -> 0.68, aux 0.96 -> 0.26, aux+data
// 0.94 -> 0.23. Shaded error bands are narrow and visible around the fits.
// Take-away: leakage detection on data qubits alone has almost no effect; rejecting
// runs with auxiliary-qubit leakage is what dominates the loss of retained fraction.
#figure(placement: auto, image("imgs/210810_ZLXL_S17_datadds_retfrac_2rows_v2.png", width: 100%),
 caption: [
 Retained fraction of experimental runs after leakage rejection. #strong[a] Retained fraction when rejecting leakage of data qubits only (light, green symbols), of auxiliary qubits only (mid-green), and of both (dark green). Solid black lines are exponential fits to the data. Data corresponds to the state preservation experiments of $|0 angle_"L"$ and $|1 angle_"L"$ presented in the main text. #strong[b] Same as #strong[a], but for data from the state preservation experiments of $|+ angle_"L"$ and $|- angle_"L"$.
 ]
)
<fig:retained_fractions>

When analyzing the state preservation experiments shown in @fig:state_preservation of the main text, we find that the retained fraction of runs $r$ in which no leakage event has been detected, decreases to good approximation exponentially with $n$, indicating that the retained fraction of runs per cycle $r_"c"$ is independent of the cycle number, see @fig:retained_fractions. The value $r_"c"approx 92.1(3) "%"$, which we obtain from exponential fits $r = A r_"c"^n$ (black lines) to the data (dark symbols) is identical within error bars for prepared eigenstates of $"hat" Z_"L"$ (panel a) and $"hat" X_"L"$ (panel b). We attribute the slight deviation between the measured data and the exponential fit to the finite probability of falsely classifying a $| 1 ⟩$-state as $| 2 ⟩$ during readout, which for auxiliary qubits is on average $0.004$ and for data qubits $0.019$. In fact, the probability for having such falsely identified leakage events is proportional to the population of the $| 1 ⟩$-state, which for auxiliary qubits increases from cycle to cycle due to their initialization in $| 0 ⟩$ and the error correction protocol, approaching 0.5 in the limit of large $n$. Hence, the falsely identified auxiliary-qubit leakage events increase with $n$, approaching about $21 "%"$ of the totally detected auxiliary qubit leakage events and explaining the slight increase of detected leakage events per cycle with $n$.

Distinguishing between leakage events on data and auxiliary qubits (lighter data points in @fig:retained_fractions a, b), we find that the probability for having detected a leakage event on any of the nine data qubits is only about $0.015 ( 2 )$ per cycle and about $0.075 ( 3 )$ for the eight auxiliary qubits.

For comparison, we also determine the extracted logical error probabilities $epsilon_"L"$ without leakage rejection (i), when rejecting data qubit leakage only (ii), and when rejecting auxiliary qubit leakage only (iii), see @tab:leakage_schemes. For simplicity, we interpret non-rejected measured $| 2 ⟩$-states as $| 1 ⟩$-states during decoding. Compared to the case when rejecting all detected leakage events (iv), the average absolute increase in the logical error probability is $0.021 ( 2 )$ for scheme (i), $0.016 ( 1 )$ for scheme (ii), and only $0.001 ( 1 )$ for scheme (iii). These results suggest that the low leakage rates achieved on our device, when combined with auxiliary-qubit reset using either feedback in combination with three-state readout or an unconditional scheme @Magnard2018 @McEwen2021a, could render leakage errors tractable in general.

#figure(
 align(center)[#table(
    stroke: none,
 columns: 4,
 align: (left,right,right,center,),
    table.hline(stroke: 0.8pt),
 table.header([Leakage rejection], [$epsilon_"L" [ hat(Z)_"L" ]$], [$epsilon_"L" [ hat(X)_"L" ]$], [$r_c$],),
 table.hline(),
 [\(i,
    table.hline(stroke: 0.8pt))   None], [0.054(1)], [0.049(2)], [1.000(0)],
 [\(ii)  Data qubits only], [0.049(1)], [0.044(1)], [0.985(2)],
 [\(iii) Aux. qubits only], [0.033(2)], [0.030(1)], [0.925(3)],
 [\(iv) Aux. and data qubits], [0.032(1)], [0.029(1)], [0.921(3)],
 )],
 caption: [
   Extracted logical error per cycle $epsilon_("L")$ for the experiment preserving eigenstates of $⟨ hat(Z)_"L" ⟩$ and of $⟨ hat(X)_"L" ⟩$ using the indicated leakage rejection schemes. The retained data fraction per cycle $r_c$ after leakage rejection is also indicated.
 ], kind: table
) <tab:leakage_schemes>

= Decoding and weight extraction
<app:decoding>
To identify the most likely sequence of errors having occurred in a single instance of an experimental run, we decode the measured set of syndromes in post-processing by adopting the minimum-weight-perfect matching (MWPM) algorithm described in Ref.@OBrien2017. We represent each syndrome element $sigma_m^(A i)$ as a vertex of a graph, which has two spatial dimensions set by the layout of auxiliary qubits $A i$ in the surface code lattice, and one temporal dimension indexed by the cycle number $m$. We connect pairs of vertices with edges, each of which represents a particular error at the physical level @Kelly2015.

In our model, we consider three kinds of errors. First, auxiliary qubit errors, including errors during readout, which are represented by vertices at the same location but separated in time by one cycle ($Delta m = 1$). Second, auxiliary qubit measurement misclassification errors, i.e. measurement errors which do not change the state of the auxiliary qubit, are represented by edges connecting vertices at the same location but separated in time by two cycles ($Delta m = 2$). And third, single Pauli errors acting on data qubits, which are represented by edges connecting vertices either to a direct neighbor of the same type ($X$ or $Z$) or to a boundary. Depending on the time at which these errors occur, the corresponding edge either connects to a vertex of the same cycle ($Delta m = 0$) or the next cycle ($Delta m = 1$). We extract the probabilities associated with those edges directly from measured syndrome correlations using the methods described in Refs.~@Spitz2018 @Chen2021p Details of this scheme will be provided in a separate publication.

Based on the individual edge error probabilities, we then compute for #emph[all] pairs of vertices $k$ and $l$ with $Delta m lt.eq 2$, the total probability $p_("kl")$ of being connected. We do so, by summing the individual probabilities over all possible error paths along the edges of the graph, see Ref.~@Spitz2018 for details. Here, the terms $p_("kk")$ correspond to the probability of having vertex $k$ being connected to a boundary. We convert the matrix of probabilities $p_( k l)$ into a weight matrix $w_(k l) = - ln p_( k l)$, based on which the MWPM algorithm connects each syndrome element $sigma_m^(A i) = 1$ either to a second such syndrome element or to a boundary while minimizing the total weight associated with these connections.

To correct for decoded errors in the final outcome $z_"L"$ ($x_"L"$) of the logical operator $hat(Z)_"L"$ ($hat(X)_"L"$), we evaluate $z_"L"=z_1 z_2 z_3$ ($x_"L"=x_1 x_4 x_7$) from the final data qubit readout and multiply it by $( - 1 )^M$, where $M$ is the number of syndrome element pairs determined by the MPWM algorithm, which signal a logical error. A syndrome element pair signals a logical error if the underlying error path contains an odd number of errors on those data qubits, which are contained in the logical operator string $hat(Z)_"L" = hat(Z)_(1)hat(Z)_(2)hat(Z)_(3)$ ($hat(X)_"L" = hat(X)_(1)hat(X)_(4)hat(X)_(7)$).

For consistency we evaluate the weights for each of the experimental and simulated state preservation experiments independently. We verified that the decoding with weights extracted from separate data sets yields the same logical lifetimes.

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "ieee", title: none)