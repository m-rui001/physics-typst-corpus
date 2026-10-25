#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt, lang: "en")
#set page(numbering: "1", margin: (x: 2.2cm, y: 2.5cm))
#set heading(numbering: "1.1")
#set par(justify: true)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)
#let unnum(body) = block({ set math.equation(numbering: none); body })

#align(center)[
  #text(17pt, weight: "bold", [High-threshold and low-overhead fault-tolerant quantum memory])   #v(1.2em)
  #text(10.5pt)[1]

#set math.equation(numbering: "(1)")

]
#v(1.6em)

As a concrete example, we show that 12 logical qubits can be preserved for syndrome cycles using 288 physical qubits in total, assuming the physical error rate of $0.1 "%"$.

We argue that achieving the same level of error suppression on 12 logical qubits with the surface code would require

. Our findings bring demonstrations of

a low-overhead fault-tolerant quantum memory within th

e reach of near-term quantum processors.

= Introduction
<introduction>

Quantum computing attracted attention due to its ability to offer asymptotically faster solutions to a set of computational problems compared to the best known classical algorithms @nielsen2002quantum It is believed that a scalable functioning quantum computer may help solve computational problems in such areas as scientific discovery, materials research, chemistry, and drug design, to name a few @lloyd1996universal @wang2008quantum @reiher2017elucidating @lloyd1996universal @wang2008quantum @reiher2017elucidating @alexeev2021quantum

The main obstacle to building a quantum computer is the fragility of quantum information, owing to various sources of noise affecting it. Since isolating a quantum computer from external effects and controlling it to induce a desired computation are in conflict with each other, noise appears to be inevitable. The sources of noise include imperfections in qubits, materials used, controlling apparatus, State Preparation and Measurement (SPAM) errors, and a variety of external factors ranging from local man-made, such as stray electromagnetic fields, to those inherent to the Universe, such as cosmic rays. See Ref. @gambetta2017building for a summary. While some sources of noise can be eliminated with better control @mundada2023experimental, materials @de2021materials, and shielding @10.1063/1.3658630@vepsalainen2020impact @PRXQuantum.4.020356, a number of other sources appear to be difficult if at all possible to remove. The latter kind can include spontaneous and stimulated emission in trapped ions @wu2018noise @boguslawski2023raman, and the interaction with the bath (Purcell Effect) @Houck2008 in superconducting circuits---covering both leading quantum technologies.

Thus, error correction becomes a key requirement for building a functioning scalable quantum computer.

The possibility of quantum fault tolerance was established earlier@shor1995scheme Encoding a logical qubit redundantly into many physical qubits enables one to diagnose and correct errors by repeatedly measuring syndromes of parity check operators. However, error correction is only beneficial if the hardware error rate is below a certain threshold value that depends on a particular error correction protocol. The first proposals for quantum error correction, such as concatenated codes~@aharonov1997fault @kitaev1997quantum @aliferis2005quantum, focused on demonstrating the theoretical possibility of error suppression. As understanding of quantum error correction and the capabilities of quantum technologies matured, the focus shifted to finding practical quantum error correction protocols. This resulted in the development of the surface code @2003faulkitaevt @bravyi1998quantum @dennis2002topological @fowler2009high that offers a high error threshold close to $1 "%"$, fast decoding algorithms, and compatibility with the existing quantum processors relying on 2-dimensional (2D) square lattice qubit connectivity. Small examples of the surface code with a single logical qubit have been already demonstrated experimentally by several groups~@takita2016demonstration @marques2022logical @krinner2022realizing @zhao2022realization @takita2016demonstration @marques2022logical @krinner2022realizing @zhao2022realization @google2023suppressing However, scaling up the surface code to a hundred or more logical qubits would be prohibitively expensive due to its poor encoding efficiency. This spurred interest in more general quantum codes known as Low-Density Parity-Check (LDPC) codes@gottesman2013fault Recent progress in the study of LDPC codes suggests that they can achieve quantum fault-tolerance with a much higher encoding efficiency@tremblay2022constant Here, we focus on the study of LDPC codes, as our goal is to find quantum error correction codes and protocols that are both efficient and possible to demonstrate in practice, given the limitations of quantum computing technologies.

A quantum error correcting code is of LDPC type if each check operator of the code acts only on a few qubits and each qubit participates only in a few checks. Multiple variants of the LDPC codes have been proposed recently including hyperbolic surface codes~@breuckmann2016constructions @higgott2021subsystem @higgott2023constructions, hypergraph product~@tillich2013quantum, balanced product codes~@breuckmann2021balanced, two-block codes based on finite groups~@kovalev2013quantum @panteleev2021degenerate @lin2023quantum @wang2023abelian, and quantum Tanner codes~@panteleev2022asymptotically @leverrier2022quantum The latter were shown~@panteleev2022asymptotically @leverrier2022quantum to be asymptotically "good" in the sense of offering a constant encoding rate and linear distance -- a parameter quantifying the number of correctable errors. In contrast, the surface code has an asymptotically zero encoding rate and only square-root distance. Replacing the surface code with a high-rate, high-distance LDPC code could have major practical implications. First, fault-tolerance overhead (the ratio between the number of physical and logical qubits) could be reduced dramatically. Secondly, high-distance codes exhibit a very sharp decrease in the logical error rate: as the physical error probability crosses the threshold value, the amount of error suppression achieved by the code can increase by orders of magnitude even with a small reduction of the physical error rate. This feature makes high-distance LDPC codes attractive for near-term demonstrations which are likely to operate in the near-threshold regime.

Here we present several concrete examples of high-rate LDPC codes with a few hundred physical qubits equipped with a low-depth syndrome measurement circuit, an efficient decoding algorithm, and a fault-tolerant protocol for addressing individual logical qubits. These codes exhibit an error threshold close to 1%, show excellent performance in the near-threshold regime, and offer of the encoding overhead compared with the surface code. Hardware requirements for realizing our error correction protocols are relatively mild, as each physical qubit is coupled by two-qubit gates with only six other qubits. Although the qubit connectivity graph is not locally embeddable into a 2D grid, it can be decomposed into two planar degree-3 subgraphs. As we argue below, such qubit connectivity is well-suited for architectures based on superconducting qubits. Before stating our results, let us describe several must-have features for a quantum error-correcting code to be suitable for near-term experimental demonstrations and formally pose the problem addressed in this work.

= Code selection criteria
<code-selection-criteria>

In this work, we study the problem of realizing a fault-tolerant quantum memory with a small qubit overhead and a large code distance. Our goal is to construct a combination of the LDPC code, syndrome measurement circuitry, and the decoding (error correction) algorithms, suitable for a near-term demonstration, but also offering long-term utility, while taking into account the capabilities and limitations of the superconducting circuits quantum hardware. In other words, we seek to develop a practical error correction protocol. Our selection criteria reflect this goal.

We focus on encoding $k gt.double 1$ logical qubits into $n$ data qubits and use $c$ ancillary check qubits to measure the error syndrome. In total, the code relies on $n thin + thin c$ physical qubits. The net encoding rate is therefore $r = frac(k, n + c) .$ For example, the standard surface code architecture encodes $k thin = thin 1$ logical qubit into $n thin = thin d^2$ data qubits for a distance-$d$ code and uses $c thin = thin n - 1$ check qubits for syndrome measurements. The net encoding rate is $r approx 1 ( 2 d^2 )$, which quickly becomes impractical as one is forced to choose a large code distance, due to, for instance, the physical errors being close to the threshold value. In contrast, we seek a high-rate LDPC code with $r gt.double 1 d^2$.

To prevent the accumulation of errors one must be able to measure the error syndrome frequently enough. This is accomplished by a syndrome measurement (SM) circuit that couples data qubits in the support of each check operator with the respective ancillary qubit by a sequence of $"Gate"{CNOT}$ gates. Check qubits are then measured revealing the value of the error syndrome. The time it takes to implement the SM circuit is proportional to its depth --- the number of gate layers composed of non-overlapping $"Gate"{CNOT}$s. Since new errors continue to occur while the SM circuit is executed, its depth should be minimized. Thus we seek an LDPC code with a high rate $r$ and low-depth SM circuit.

A noisy version of the SM circuit may include several types of faulty operations such as memory errors on data or check qubits, faulty $"Gate"{CNOT}$ gates, qubit initializations and measurements. We consider the circuit-based noise model~@fowler2009high where each operation fails with the probability $p$. Faults on different operations are independent. A logical error occurs when the final error-corrected state of $k$ logical qubits differs from the initial encoded state. The probability of a logical error $p_L$ depends on the error rate $p$, details of the SM circuits, and a decoding algorithm. A pseudo-threshold $p_0$ of an error correction protocol is defined as a solution of the break-even equation $p_L ( p ) = k p$. Here $k p$ is an estimate of the probability that at least one of $k$ unencoded qubits suffers from an error. To achieve a significant error suppression in the regime $p thin tilde thin 10^(- 3)$, which is relevant for near-term demonstrations, it is desirable to have pseudo-threshold close to 1% or higher. For example, the surface code architecture achieves pseudo-threshold $p_0 approx 1 "%"$ for a large enough code distance@fowler2009high We seek a high-rate LDPC code with a low-depth SM circuit and a high pseudo-threshold.

A logical error is undetectable if it can be generated without triggering any syndromes. Such errors span at least $d$ data qubits for a distance-$d$ code. Let us say that a SM circuit has distance $"dcirc"$ if it takes at least $"dcirc"$ faulty operations in the circuit to generate an undetectable logical error. By definition, $"dcirc" {less.eq} d$ for any distance-$d$ code and typically $"dcirc" {<} d$ since a few faulty operations in the SM circuit may create a high-weight error on the data qubits. We say that a SM circuit is distance-preserving if $"dcirc" {=} d$ meaning the circuit is designed so as to avoid accumulating high-weight errors, which is the best one can hope for. It is preferred (but not required) that the SM circuit is distance-preserving.

Another criterion is dictated by the limited qubit connectivity of near-term quantum devices. Each quantum code can be described by a Tanner graph $G$ such that each vertex of $G$ represents either a data qubit or a check operator. A check vertex $i$ and a data vertex $j$ are connected by an edge if the $i$-th check operator acts non-trivially on the $j$-th data qubit (by applying Pauli $X$ or $Z$). ~A) shows the Tanner graph describing a distance-3 surface code. To keep the SM circuit depth small, it is desirable that two-qubit gates such as $"Gate"{CNOT}$ can be applied along every edge of the Tanner graph. By construction, the Tanner graph of any LDPC code has a small degree. One drawback of high-rate LDPC codes is that their Tanner graphs may not be locally embeddable into the 2D grid~@baspin2022quantifying @bravyi2010tradeoffs This poses a challenge for hardware implementation with superconducting qubits coupled by microwave resonators. A useful VLSI design concept is graph #emph[thickness], see~@mutzel1998thickness @tremblay2022constant for details. A graph $G thin = thin ( V , E )$ is said to have thickness $theta$ if one can partition its set of edges $E$ into disjoint union of $theta$ sets $E_1 union.sq E_2 union.sq dots.h union.sq E_theta thin = thin E$ such that each subgraph $( V , E_i )$ is planar. Informally, a graph with thickness $theta$ can be viewed as a vertical stack of $theta$ planar graphs. Qubit connectivity described by a planar graph (thickness $theta thin = thin 1$) is the simplest one from hardware perspective since the couplers do not cross. Graphs with thickness $theta thin = thin 2$ might still be implementable since two planar layers of couplers and their control lines can be attached to the top and the bottom side of the chip hosting qubits, and the two sides mated (see for a detailed discussion).

Graphs with thickness $theta thin gt.eq thin 3$ are much harder to implement. Thus we seek a high-rate LDPC code with a low-depth SM circuit, high pseudo-threshold, and a low-degree Tanner graph with thickness $theta lt.eq 2$.

Finally, the code must perform a useful function within a larger architecture for quantum computation, the simplest of which is a quantum memory. In a quantum memory it must be possible to measure every logical qubit in at least one Pauli basis, permitting initialization and readout of individual qubits. Furthermore it should be possible to connect the code to another error correction code and facilitate Pauli product measurements between their logical qubits. This enables load-store operations that transfer quantum data out of and into the code via quantum teleportation. For the purpose of the shorter-term goal of demonstrating the code in practice, the code should also feature enough logical operations to facilitate experiments to verify correct operation.

Our code selection criteria are summarized below.

+ We desire a code with a large distance $d$ and a high encoding rate $r thin gt.double thin 1 d^2$,

+ that is complemented by a short-depth syndrome measurement circuit,

offers a pseudo-threshold close to 1% (or higher) for the circuit-based noise model,

is constructed over thickness-2 or less Tanner graph,

and possesses fault-tolerant load-store operations as well a

s readout and initialization of individual qubits.

= Main results
<sec:results>

Here we give concrete examples of LDPC codes equipped with syndrome measurement circuits and efficient decoding algorithms that meet all above conditions. Our examples fall into the family of tensor product generalized bicycle codes proposed by Kovalev and Pryadko@kovalev2013quantum These are stabilizer codes of CSS-type~@steane1996multiple @calderbank1996good that can be described by a collection of few-qubit check (stabilizer) operators composed of Pauli $X$ and $Z$. At a high level, a BB code is similar to the two-dimensional toric code@2003faulkitaevt In particular, physical qubits of a BB code can be laid out on a two-dimensional grid with periodic boundary conditions such that all check operators are obtained from a single pair of $X$- and $Z$-checks by applying horizontal and vertical shifts of the grid. However, in contrast to the plaquette and vertex stabilizers describing the toric code, check operators of a BB code are not geometrically local. Furthermore, each check acts on six qubits rather than four qubits. See ~B) an example Tanner graph of a BB code. We give a formal definition of BB codes in . The Tanner graph of any BB code has vertex degree six. Although this graph may not be locally embeddable into a 2D grid, we show that it has thickness $theta thin = thin 2$, as desired. This result may be surprising since it is known that a general degree-$6$ graph can have thickness $theta thin = thin 3$, see#text([])

// [figvision-cn] imgs/fig1.png
// 该图由三个子图（A、B、C）组成，顶部总标题为“Tanner
// Graphs of Surface and Bivariate Bicycle Codes”（表面码
// 与双变量自行车码的 Tanner 图）。 子图 A 位于左上方，标
// 题为“A) Tanner Graph of a Surface Code”（表面码的
// Tanner 图），是示意图。图中展示由细黑实线连接的空心圆
// 圈组成的方格网状结构。圆形节点分为两类：一类是位于网格
// 边中点的“data”节点（数据量子比特），另一类是位于网格面
// 中心的“checks”节点（校验量子比特）。图中所有数据节点上
// 均标有带颜色的字母方框，其中粉色方框标记“X”，绿色方框
// 标记“Z”，总计可见各 4 个。标注文字“data”配有向上弯曲的
// 箭头指向数据节点，“checks”配有向下弯曲的箭头指向校验节
// 点。上下相邻的数据节点和校验节点之间构成二部图连接，部
// 分节点的连线呈斜向虚线。 子图 B 位于右侧，标题为“B)
// Tanner Graph of the [[144,12,12]] Bivariate Bicycle
// Code”（[[144,12,12]] 双变量自行车码的 Tanner 图），为
// 平面方格阵列图。整个区域用黑色粗线框成一个矩形，框内是
// 由浅灰色细虚线构成的 12 行乘 12 列的方格点阵，共有 144
// 个节点。阵列的四个边缘外侧各有一个黑色三角形箭头，分别
// 指向阵列中心，其中上下箭头从左向右指，左右箭头从上向下
// 指。阵列内节点的形状与颜色通过底部的图例进行编码：图例
// 左侧为深蓝色实心圆点，对应“L data”；接着是橙黄色实心圆
// 点，对应“R data”；粉色实心方块标记“X check”；绿色实心
// 方块标记“Z check”；短虚线标记“'A' edge”（A 类边）；黑
// 色实线标记“'B' edge”（B 类边）。主图阵列中，节点按照特
// 定规律交替分布：粉色和绿色方框（校验节点）位于阵列的一
// 部分位置，蓝点和橙点（数据节点）位于其余位置。图中所有
// 节点在水平和垂直方向都由细虚线连接。最为显著的是，图中
// 标注了一条粗黑色的斜向封闭环状实线曲线，该曲线从阵列左
// 下部的一个橙点开始，斜向上贯穿阵列中心区域，到达右上部
// 的一个深蓝色点，然后再向下弯曲，沿右侧区域呈环状斜向左
// 下闭合，构成一个明显的平行四边形轮廓，此黑色实线环路对
// 应图例中的“'B' edge”。 子图 C 位于左下方，标题为“C)
// Sketch: Attaching to a Surface Code”（附着于表面码的草
// 图），包含两个上下排列的示意图。上方示意图左侧标有“
// Surface Code”（方框包围），引出一个粗灰实线向右侧延伸，
// 连接到一个由黑色实线构成的水平链状结构，包含两端圆点和
// 中间水平线。该链状结构右侧用大括号括住，标注文字“
// Ancilla for X̄”。下方示意图显示了一个更复杂的连接网络，
// 在浅灰色示意轮廓上方叠加了一个粗线三维结构。该结构包含
// 三个垂直列上的空心圆节点，用粉色标记“X̄”、绿色标记“Z̄”、
// 橙色标记“R̄”等带颜色框的节点。右侧同样用括号标记为“
// Ancilla for Z̄”。连接关系由垂直实线、水平实线及斜向虚
// 线构成，结构在三维空间上具有前后遮挡关系。
#figure(image("imgs/fig1.png", height: 9cm),
  caption: [
    A) Tanner graph of a surface code, for comparison. C) Tanner graph of a Bivariate Bicycle code with parameters $[ [ 144 , 12 , 12 ] ]$ embedded into a torus. Any edge of the Tanner graph connects a data and a check vertex. Data qubits associated with the registers $q ( L )$ and $q ( R )$ are shown by bLue and oRange circles. Each vertex has six incident edges including four short-range edges (pointing north, south, east, and west) and two long-range edges. There are also several long-range edges, of which we only show a few to to avoid clutter. Dashed and solid edges indicate two planar subgraphs spanning the Tanner graph, see . B) Sketch of a Tanner graph extension for measuring $macron(Z)$ and $macron(X)$ following @cohen2022lowoverhead The ancilla corresponding to the $macron(X)$ measurement can be connected to a surface code, enabling load-store operations for all logical qubits via quantum teleportation and some logical unitaries. This extended Tanner graph has a thickness-2 implementation, see .
  ]
)
<fig:2Dlayout>

Below we use the standard notation $[ [ n , k , d ] ]$ for code parameters. Here $n$ is the code length (the number of data qubits), $k$ is the number of logical qubits, and $d$ is the code distance. shows small examples of BB codes along with several metrics of the error suppression achieved by each codes. The distance-12 code $[ [ 144 , 12 , 12 ] ]$ may be the most promising for near-term demonstrations, as it combines large distance and high net encoding rate $r thin = thin 1 24$. For comparison, the distance-13 surface code has net encoding rate $r thin = thin 1 338$. Below we show that the distance-12 BB code outperforms the distance-13 surface code for the experimentally relevant range of error rates, see B). To the best of our knowledge, all codes shown in are new.

#block[
#block[
#figure(
  align(center)[#table(
    columns: 6,
    align: (center,center,center,center,center,center,),
    [], [], [], [], [], [],
    [$[ [ n , k , d ] ]$], [Net Encoding \
    Rate $r$], [Circuit-level \
    distance $"dcirc"$], [Pseudo-threshold $p_0$], [$p_L ( 0.001 )$], [$p_L ( 0.0001 )$],
    [], [], [], [], [], [],
    [$[ [ 72 , 12 , 6 ] ]$], [1/12], [$lt.eq 6$], [$0.0048$], [$7 times 10^(- 5)$], [$7 times 10^(- 8)$],
    [$[ [ 90 , 8 , 10 ] ]$], [$1 23$], [$lt.eq 8$], [$0.0053$], [$5 times 10^(- 6)$], [$4 times 10^(- 10)$],
    [$[ [ 108 , 8 , 10 ] ]$], [1/27], [$lt.eq 8$], [$0.0058$], [$3 times 10^(- 6)$], [$1 times 10^(- 10)$],
    [$[ [ 144 , 12 , 12 ] ]$], [$1 24$], [$lt.eq 10$], [$0.0065$], [$2 times 10^(- 7)$], [$8 times 10^(- 13)$],
    [$[ [ 288 , 12 , 18 ] ]$], [$1 48$], [$lt.eq 18$], [$0.0069$], [$2 times 10^(- 12)$], [$1 times 10^(- 22)$],
  )]
  , caption: [Small examples of Bivariate Bicycle LDPC codes and their performance for the circuit-based noise model. All codes have weight-6 checks, thickness-2 Tanner graph, and a depth-$7$ syndrome measurement circuit. A code with parameters $[ [ n , k , d ] ]$ requires $2 n$ physical qubits in total and achieves the net encoding rate $r = k 2 n$ (we round $r$ down to the nearest inverse integer). Circuit-level distance $"dcirc"$ is the minimum number of faulty operations in the syndrome measurement circuit required to generate an undetectable logical error. The pseudo-threshold $p_0$ is a solution of the break-even equation $p_L ( p ) = k p$, where $p$ and $p_L$ are the physical and logical error rates respectively. The logical error rate $p_L$ was computed numerically for $p gt.eq 10^(- 3)$ and extrapolated to lower error rates. ]
  , kind: table
  )

] <table:codes_intro>
]

To quantify the level of error suppression achieved by a code we introduce

SM circuits that repeatedly measure the syndrome of each check operator. The full cycle of syndrome measurement for a length-$n$ BB code requires $n$ ancillary check qubits to store the measured syndromes. According, the net encoding rate is $r = k ( 2 n )$. Check qubits are coupled with the data qubits by applying a sequence of $"Gate"{CNOT}$ gates. The full cycle of syndrome measurement requires only $7$ layers of $"Gate"{CNOT}$s regardless of the code length. The check qubits are initialized and measured at the beginning and at the end of the syndrome cycle respectively, see for details. We emphasize that our SM circuit applies to any BB code beyond those listed in . The circuit respects the cyclic shift symmetry of the underlying code. Assuming that the physical qubits (data or check) are located at vertices of the Tanner graph, all $"Gate"{CNOT}$ gates in the SM circuit act on nearest-neighbor qubits. Thus the required qubit connectivity is described by a degree-6 thickness-2 graph, as desired. We conjecture, based on the numerical simulations, that our SM circuit is distance-preserving for the code $[ [ 72 , 12 , 6 ] ]$, see for the upper bounds on $"dcirc"$ (the upper bound $"dcirc"less.eq 18$ for the 288-qubit code is unlikely to be tight ).

The full error correction protocol performs $N_c gt.double 1$ syndrome measurement cycles and calls a decoder --- a classical algorithm that takes as input the measured syndromes and outputs a guess of the final error on the data qubits. Error correction succeeds if the guessed and the actual error coincide modulo a product of check operators. In this case the two errors have the same action on any encoded (logical) state. Thus applying the inverse of the guessed error would return data qubits to the initial logical sate. Otherwise, if the guessed and the actual error differ by a non-trivial logical operator, error correction fails resulting in a logical error. Our numerical experiments are based on the Belief Propagation with an Ordered Statistics Decoder (BP-OSD) proposed by Panteleev and Kalachev@panteleev2021degenerate The original work~@panteleev2021degenerate described BP-OSD in the context of a toy noise model with memory errors only. Here we show how to extend BP-OSD to the circuit-based noise model. We also show that BP-OSD can be applied to other problems in quantum fault-tolerance such as estimating the distance of a quantum LDPC code, see for details. These tasks can be accomplished with a relatively minor extension of the publicly available BP-OSD software developed by Roffe et al.~@roffe2020decoding

Let $P_L ( N_c )$ be the logical error probability after performing $N_c$ syndrome cycles. Define the logical error rate as $p_L = 1 - ( 1 - P_L ( N_c ) )^(1 N_c) approx P_L ( N_c ) N_c$. Informally, $p_L$ can be viewed as the logical error probability per syndrome cycle. Following common practice, we choose $N_c = d$ for a distance-$d$ code. A) shows the logical error rate achieved by codes from . The logical error rate was computed numerically for $p gt.eq 10^(- 3)$ and extrapolated to lower error rates using a fitting formula $p_L=p^("dcirc"\'/2) e^(c_0 + c_1 p + c_2p^2)$, where $c_0 , c_1 , c_2$ are fitting parameters and $"dcirc"\'$ is an upper bound on $"dcirc"$ from . The observed pseudo-threshold , which is nearly the same as the error threshold of the surface code@groszkowski2009high To the best of our knowledge, this provides the first example of high-rate, large-distance LDPC codes achieving the pseudo-threshold close to 1$"%"$ under the circuit-based noise model.

// [figvision-cn] imgs/ldpc_vs_surface.pdf.wired.png
// 这是一张双对数坐标曲线图，展示逻辑错误率随物理错误率的
// 变化。横轴为Error rate p（物理错误率），范围10^-4至10^
// -2；纵轴为Logical error rate p_L（逻辑错误率），范围10
// ^-13至10^-1。图中包含五组数据，每组数据由离散数据点与
// 连接它们的直线组成。浅灰色线配星形标记，对应图例
// Surface [[972,12,9]]，分布最高；浅绿色线配星形标记，对
// 应Surface [[1452,12,11]]；蓝色线配星形标记，对应
// Surface [[2028,12,13]]，但该曲线大部分低于纵轴下限，仅
// 在高错误率端可见；粉色线配星形标记，对应Surface [[2700
// ,12,15]]；红色线配菱形标记，对应LDPC [[144,12,12]]。所
// 有曲线均随物理错误率增大而上升，呈现近似线性斜率；在相
// 同物理错误率下，红色LDPC曲线低于灰色Surface曲线，且粉
// 色星形曲线低于红色菱形曲线，表明LDPC与更大规模的
// Surface码具有更低的逻辑错误率。
// [figvision-cn] imgs/small_ldpc.pdf.wired.png
// 这是一张双对数坐标曲线图，横轴表示物理错误率 p（Error
// rate p），采用对数刻度，范围从 10^-4 到 10^-2；纵轴表
// 示逻辑错误率 p_L（Logical error rate p_L），同样采用对
// 数刻度，范围从 10^-13 到 10^-1。图中有五条对角线，每条
// 线由不同颜色的菱形数据点和同色实线拟合连接而成。图例位
// 于右下角，标明了五组数据对应的量子纠错码参数：蓝色菱形
// 对应 [[72,12,6]]，绿色菱形对应 [[90,8,10]]，橙色菱形对
// 应 [[108,8,10]]，红色菱形对应 [[144,12,12]]，品红色菱
// 形对应 [[288,12,18]]。所有曲线均呈现逻辑错误率随物理错
// 误率增加而上升的趋势，在低错误率区域（左侧），具有更大
// 编码距离的码（如品红色和红色曲线）其逻辑错误率显著更低；
// 所有曲线在物理错误率接近 10^-2 时逐渐汇聚并趋向于 10^
// -1。
#figure(
  [\n#image("imgs/small_ldpc.pdf.wired.png", width: 100%)\n#image("imgs/ldpc_vs_surface.pdf.wired.png", width: 100%)\n],
  caption: [
  ]
)

// [figvision-cn] imgs/small_ldpc.png
// 这是一张单子图（无 a、b、c 等分图）的对数-对数坐标曲线
// 图，类型为曲线图（散点连线图），展示逻辑错误率随物理错
// 误率变化的趋势。 坐标轴：横轴标签为“Error rate p”（错
// 误率 p，无量纲），采用对数刻度，范围从 10^-4 到 10^-2，
// 标注的主要刻度值为 10^-4、10^-3、10^-2，其间有对数次级
// 网格线。纵轴标签为“Logical error rate p_L”（逻辑错误率
// p_L，无量纲），采用对数刻度，范围从 10^-13 到 10^-1，
// 标注的主要刻度值为 10^-13、10^-11、10^-9、10^-7、10^-5、
// 10^-3、10^-1，其间有次级网格线。图中带有浅灰色的主网格
// 线，对应坐标轴的主要刻度。 图例位于右下角，用不同颜色
// 的菱形标记（黑色边框）区分五组数据，每组标记对应一条同
// 色实线，线型均为直线（在对数坐标下），并含有标注文字：
// 蓝色菱形加蓝线，对应标注“[[72,12,6]]”； 绿色菱形加绿线，
// 对应标注“[[90,8,10]]”； 橙色菱形加橙线，对应标注“[[108
// ,8,10]]”； 红色菱形加红线，对应标注“[[144,12,12]]”；
// 品红色（洋红）菱形加品红线，对应标注“[[288,12,18]]”。
// 图中所有曲线均呈从左下向右上倾斜的直线，表示逻辑错误率
// 随物理错误率增加而增加，且斜率为正。五条曲线并非平行：
// 蓝色曲线斜率最小、在最上方，绿色与橙色曲线非常接近（绿
// 色略高于橙色），红色曲线在它们下方，品红色曲线斜率最大
// 且在最下方。在低错误率端（靠近 10^-4），蓝色曲线的 p_L
// 约在 10^-7 附近，绿色约在 10^-10 附近，橙色约在 10^-10
// 附近（比绿色略低），红色约在 10^-12 附近，品红色曲线在
// 此范围内低于 10^-13 且未显示起点。随着 p 从 10^-4 增加
// 到 10^-2，各曲线相互靠近，在 p 接近 10^-2 时所有曲线趋
// 于汇聚在 10^-1 附近。数据点分布在每条直线上，标记为相
// 应颜色的实心菱形。
#figure(image("imgs/small_ldpc.png", width: 7cm),
  caption: [
    A subfigure
  ]
)
<fig:sub1>

// [figvision-cn] imgs/ldpc_vs_surface.png
// 这是一张双对数坐标系的折线散点图，用于展示不同量子纠错
// 码方案在不同物理错误率下的逻辑错误率表现。横轴（X轴）
// 为物理错误率 p，范围从 10^-4 到 10^-2，采用对数刻度。
// 纵轴（Y轴）为逻辑错误率 p_L，范围从 10^-13 到 10^-1，
// 同样采用对数刻度。图中包含五条从左上向右下倾斜的直线，
// 每条直线上标有离散的数据点。所有线条和点的整体趋势一致：
// 随着物理错误率 p 的增大，逻辑错误率 p_L 呈指数级上升。
// 图中右下角有一个图例，列出了五个数据系列： 灰色线条带
// 五角星标记：Surface [[972,12,9]]。该线在给定物理错误率
// 下对应的逻辑错误率最高，数据点用灰色五角星表示，并由灰
// 色实线连接。 绿色线条带五角星标记：Surface [[1452,12,
// 11]]。数据点用绿色五角星表示，由绿色实线连接，其逻辑错
// 误率低于灰色线。 红色线条带菱形标记：LDPC [[144,12,12]
// ]。数据点用红色菱形表示，由红色实线连接。注意，这条线
// 的斜率与灰色和绿色线相近，但在物理错误率约 10^-3 处，
// 其逻辑错误率位于灰色线和蓝色线之间。 蓝色线条带五角星
// 标记：Surface [[2028,12,13]]。数据点用蓝色五角星表示，
// 由蓝色实线连接。 粉色线条带五角星标记：Surface [[2700,
// 12,15]]。数据点用粉色五角星表示，由粉色实线连接。这条
// 线在相同的物理错误率下，对应的逻辑错误率最低（在所有展
// 示的码中性能最优）。 图中所有数据线均呈现为近乎平行的
// 直线，斜率较大。特别是 LDPC 码（红色菱形）的曲线，其斜
// 率与 Surface 码的曲线基本一致，表明其具有相似的错误抑
// 制能力，但在特定的物理错误率区间内，其逻辑错误率介于不
// 同尺寸的 Surface 码之间。图中没有标注比例尺或显微成像
// 信息，因为这是一个纯数据图表。
#figure(image("imgs/ldpc_vs_surface.png", width: 7cm),
  caption: [
    A subfigure
  ]
)
<fig:sub2>

obtained by simulating $d$ syndrome cycles for a distance-$d$ code. Most of the data points have error bars $approx p_L 10$ due to sampling errors. B) Comparison between the Bivariate Bicycle LDPC code $[ [ 144 , 12 , 12 ] ]$

and surface codes with $12$ logical qubits and distance .

The distance-$d$ surface code with $12$ logical qubits has length $n = 12 d^2$

since each logical qubit is encoded into a separate $d times d$ patch

of the surface code lattice.

<fig:nume>

rics
 figure

For example, suppose that the physical error rate is $p = 10^(- 3)$, which is a realistic goal for near-term demonstrations. Encoding $12$ logical qubits using the distance-$12$ code from would offer the logical error rate which is enough to preserve $12$ logical qubits for . The total number of physical qubits required for this encoding is $288$. The distance-$18$ code from would require $576$ physical qubits while suppressing the error rate from $10^(- 3)$ to enabling roughly hundred billion syndrome cycles. For comparison, encoding $12$ logical qubits into separate patches of the surface code would require physical qubits to suppress the error rate from $10^(- 3)$ to $10^(- 6)$, see ~B). In this example the distance-$12$ BB code offers saving in the number of physical qubits compared with the surface code.

We also find that BB LDPC codes admit extensions that allow them to function as a logical memory with load-store operations. In we show how to use methods from @cohen2022lowoverhead to attach two ancilla systems to the code that permit logical measurement of all logical qubits in the $X$ and $Z$ bases. Which logical qubit is being measured can be controlled via a set of fault tolerant unitary operations. The extended Tanner graph is not only thickness-2, but the extension from the $X$ ancilla system is "effectively planar" (in a sense we define later) facilitating interconnection with other codes on the same chip.

Our findings bring experimental demonstration of high-rate LDPC codes within the reach of near-term quantum processors which are expected to offer a few hundred physical qubits, gate error rates close to $10^(- 3)$, and long range qubit connectivity@bravyi2022future

The rest of this paper is organized as follows. formally defines BB LDPC codes and proves their basic properties. The construction of the syndrome measurement circuit is detailed in . The circuit-based noise model and BP-OSD decoder for this noise model are discussed in with some implementation details deferred to . We describe fault tolerant memory capabilities in . A summary of our findings and some open questions can be found in .

= Bivariate Bicycle quantum LDPC codes
<sec:codedefinition>

Let $I_ell$ and $S_ell$ be the identity matrix and the cyclic shift matrix of size $ell times ell$ respectively. The $i$-th row of $S_ell$ has a single nonzero entry equal to one at the column $i thin + thin 1 med ( mod med ell )$. For example,
#unnum[$ S_2 = mat(0, 1; 1, 0; delim: "["), quad "and" quad S_3 = mat(0, 1, 0; 0, 0, 1; 1, 0, 0; delim: "["). $]
Consider matrices
#unnum[$ x = S_ell ⊗ I_m quad "and" quad y = I_ell ⊗ S_m . $]
Note that $x y = y x$ and $x^ell = y^m = I_(ell m)$. A BB code is defined by a pair of matrices
$ A = A_1 + A_2 + A_3 quad "and" quad B = B_1 + B_2 + B_3 $ <AB>
where each matrix $A_i$ and $B_j$ is a power of $x$ or $y$. Here and below the addition and multiplication of binary matrices is performed modulo two, unless stated otherwise. Thus, we also assume the$A_i$are distinct and the$B_j$are distinct to avoid cancellation of terms. For example, one could choose$A = x^3 + y + y^2$and$B = y^3 + x + x^2$. Note that$A$and$B$have exactly three non-zero entries in each row and each column. Furthermore,$A B thin = thin B A$since$x y thin = thin y x$. The above data defines a BB LDPC code denoted$sans("QC") \( A , B \)$with length$n thin = thin 2 ell m$and check matrices
$ H^X = mat(A, "|", B; delim: "[") quad "and" quad H^Z = mat(B^T, "|", A^T; delim: "[") $ <HXHZ>
Here the vertical bar indicates stacking matrices horizontally and $T$ stands for the matrix transposition. Both matrices $H^X$ and $H^Z$ have size $(n / 2) times n$. Each row $v {in} "FF"_2^n$ of $H^X$ defines an $X$-type check operator $X ( v ) = product_(j = 1)^n X_j^(v_j)$. Each row $v {in} "FF"_2^n$ of $H^Z$ defines a $Z$-type check operator $Z ( v ) = product_(j = 1)^n Z_j^(v_j)$. Any X-check and Z-check commute since they overlap on even number of qubits (note that $H^X (H^Z)^T = A B + B A = 0 med (mod med 2)$). To describe the code parameters we use certain linear subspaces associated with the check matrices, see Table 1 for our notations. Then the code$sans("QC") \( A , B \)$has parameters$\[ \[ n , k , d \] \]$with$ n = 2 ell m , quad k = 2 dot.op upright("dim") (sans("ker") \( A \) sect sans("ker") \( B \)) quad upright("and") quad d = min #scale(x: 120%, y: 120%)[(] \| v \| : thin thin v in sans("ker") \( H^X \) \ sans("rs") \( H^Z \) #scale(x: 120%, y: 120%)[)] , $see . Here$\| v \| = sum_(i = 1)^n v_i$is the Hamming weight of a vector$vin "FF"\_2^n$. We note that the code$sans("QC") \( A , B \)$can be viewed as a special case of the Lifted Product construction~@panteleev2021quantum based on the abelian group$"ZZ"\_"ell" "times" "ZZ"\_m$. Here$"ZZ"\_j$denotes the cyclic group of order$j$.

#block[
#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.header([Notation], [Name], [Definition],),
    table.hline(),
    [$sans("rs") ( H )$], [row space], [Linear span of rows of $H$],
    [$sans("cs") ( H )$], [column space], [Linear span of columns of $H$],
    [$sans("ker") ( H )$], [nullspace], [Vectors orthogonal to each row of $H$],
    [$sans("rk") ( H )$], [rank], [$sans("rk") ( H ) = upright("dim") ( sans("rs") ( H ) ) = upright("dim") ( sans("cs") ( H ) )$],
  )]
  , caption: [Notations for linear spaces associated with a binary matrix $H$. Here the linear span, orthogonality, and dimension are computed over the binary field $"FF"_2=\(0,1\)$. If $H$ has size $s thin times thin n$ then $"sans"("rs"){(H)}"subseteq" "FF"_2^n$, $"sans"("cs"){(H)}"subseteq" "FF"_2^s$, and $"sans"("ker"){(H)}"subseteq" "FF"_2^n$. ]
  , kind: table
  )

]

#block[
#figure(
  align(center)[#table(
    columns: 6,
    align: (center,center,center,center,center,center,),
    [], [], [], [], [], [],
    [$[ [ n , k , d ] ]$], [Net Encoding \
    Rate $r$], [$ell , m$], [$A$], [$B$], [],
    [], [], [], [], [], [],
    [$[ [ 72 , 12 , 6 ] ]$], [1/12], [$6 , 6$], [$x^3 + y + y^2$], [$y^3 + x + x^2$], [],
  )]
  , kind: table
  )

]

$[ [ 90 , 8 , 10 ] ]$ & $1 23$ & $15 , 3$ & $x^9 + y + y^2$ & $1 + x^2 + x^7$ \
$[ [ 108 , 8 , 10 ] ]$ & 1/27 & $9 , 6$ & $x^3 + y + y^2$ & $y^3 + x + x^2$ \
$[ [ 144 , 12 , 12 ] ]$ & $1 24$ & $12 , 6$ & $x^3 + y + y^2$ & $y^3 + x + x^2$ \

$[ [ 288 , 12 , 18 ] ]$ & $1 48$ & $12 , 12$ & $x^3 + y^2 + y^7$ & $y^3 + x + x^2$ \

$[ [ 360 , 12 , lt.eq 24 ] ]$ & $1 60$ & $30 , 6$ & $x^9 + y + y^2$ & $y^3 + x^25 + x^26$ \

$[ [ 756 , 16 , lt.eq 34 ] ]$ & $1 95$ & $21 , 18$ & $x^3 + y^10 + y^17$ & $y^5 + x^3 + x^19$ \

 tabular

Notation $lt.eq d$ indicates that only an upper bound on the code distance is known at the time of this writing. We round $r$ down to the nearest inverse integer.

The codes have check matrices $H^X = [ A | B ]$

and $H^Z = [ B^T | A^T ]$ with $A$ and $B$ defined in the last two columns.

The matrices $x$, $y$ obey

$x^ =y^m=1

$and$xy=yx$.

<table:co>

des
 table

describes the polynomials $A$ and $B$ that give rise to examples of high-rate, high-distance BB codes found by a numerical search. This includes all codes from and two examples of higher distance codes. To the best of our knowledge, all these examples are new. The code $[ [ 360 , 12 , lt.eq 24 ] ]$ improves upon a code $[ [ 882 , 24 , lt.eq 24 ] ]$ with weight-6 checks found by Panteleev and Kalachev in~@panteleev2021degenerate (assuming that our distance upper bound is tight). Indeed, taking two independent copies of the 360-qubit code gives parameters $[ [ 720 , 24 , lt.eq 24 ] ]$.

By construction, the code $sans("QC") ( A , B )$ has weight-6 check operators and each qubit participates in six checks (three $X$-type plus three $Z$-type checks).

Accordingly, the code $sans("QC") ( A , B )$ has a degree-$6$ Tanner graph. Below we show that the Tanner graph has thickness $theta lt.eq 2$, as desired, see .

We note that the recent work by Wang, Lin, and Pryadko~@wang2023abelian @lin2023quantum described examples of group-based codes closely related to the codes considered here. Some of the group-based codes with weight-8 checks found in~@lin2023quantum outperform our BB codes with weight-6 checks in terms of the parameters $n , k , d$. It remains to be seen whether group-based codes can achieve a similar or better level of error suppression for the circuit-based noise model.

In the rest of this section we establish some properties of BB LDPC codes.

#block[
<lem:kd> The code $sans("QC") ( A , B )$ has parameters $[ [ n , k , d ] ]$, where $n = 2 ell m , quad k = 2 dot.op upright("dim") (sans("ker") ( A ) sect sans("ker") ( B )) , quad upright("and") quad d = min #scale(x: 120%, y: 120%)[(] | v | : thin thin v in sans("ker") ( H^X ) sans("rs") ( H^Z ) #scale(x: 120%, y: 120%)[)] .$ The code offers equal distance for $X$-type and $Z$-type errors.

]
#block[
#emph[Proof.] It is known~@steane1996multiple @calderbank1996good that $ k = n - sans("rk") \( H^X \) - sans("rk") \( H^Z \) . $ We claim that $sans("rk") \( H^X \) thin = thin sans("rk") \( H^Z \)$. Indeed, define a self-inverse permutation matrix $C_ell$ of size $ell thin times thin ell$ such that the $i$-th column of $C_ell$ has a single nonzero entry equal to one at the row $j = - i med \( mod med ell \)$. Define $C_m$ similarly and let $C = C_ell ⊗ C_m$. Since $C_ell S_ell C_ell = S_ell^T$ and $C_m S_m C_m = S_m^T$, one gets $ A^T = C A C quad upright("and") quad B^T = C B C . $<ABC2> Therefore one can write $$H^Z= \[B^T|A^T\] = \[CBC |CAC\] = C\[A|B\]\\left\[ \mat(delim: #none, cols: 2, 0, C, C, 0, \) \\right\]
=CH^X\\left\[ \mat(delim: #none, cols: 2, 0, C, C, 0, \) \\right\].$$Thus$H^Z$is obtained from$H^X$by multiplying on the left and on the right by invertible matrices. This implies$sans("rk") \( H^X \) = sans("rk") \( H^Z \)$. Therefore$ k & = n - 2 dot.op sans(r k) \( H^Z \) = n - 2 (n / 2 - dim \( sans(k e r) \( \( H^Z \)^T \) \) \)) = n - 2 (n / 2 - dim \( sans(k e r) \( A \) sect sans(k e r) \( B \) \))\
 & = 2 dot.op upright(d i m) (sans(k e r) \( A \) sect sans(k e r) \( B \)) . $Here we noted that$H^Z$has size$\( n \/ 2 \) thin times thin n$and$sans(k e r) \( \( H^Z \)^T \) \) = sans(k e r) \( A \) sect sans(k e r) \( B \)$since$H^Z = \[ B^T \| A^T \]$.~◻

]

It is known~@steane1996multiple @calderbank1996good that a CSS code with check matrices $H^X$ and $H^Z$ has distance $d thin = thin min ( d^X , d^Z )$, where $d^X$ and $d^Z$ are the code distances for $X$-type and $Z$-type errors defined as $d^X = min #scale(x: 120%, y: 120%)[(] | v | : thin thin v in sans("ker") ( H^Z ) sans("rs") ( H^X ) #scale(x: 120%, y: 120%)[)] quad upright("and") quad d^Z = min #scale(x: 120%, y: 120%)[(] | v | : thin thin v in sans("ker") ( H^X ) sans("rs") ( H^Z ) #scale(x: 120%, y: 120%)[)] .$ We claim that $d^Z thin lt.eq thin d^X$. Indeed, let $X ( f ) thin = thin product_(j = 1)^n X_j^(f_j)$ be a minimum weight logical $X$-type Pauli operator such that $| f | thin = thin d^X$. Then $H^Z f thin = thin 0$ and $f thin in.not thin sans("rs") ( H^X )$. Thus there exists a logical $Z$-type operator $Z ( g ) thin = thin product_(j = 1)^n Z_j^(g_j)$ anti-commuting with $X ( f )$. In other words, $H^X g thin = thin 0$ and $f^T g thin = thin 1$. Here, $f$ and $g$ are length-$n$ binary vectors. Write $f thin = thin ( alpha , beta )$ and $g thin = thin ( gamma , delta )$, where $alpha , beta , gamma , delta$ are length-$( n 2 )$ vectors. Conditions $H^Z f = 0$ and $H^X g = 0$ are equivalent to $$\$ \ 
\ $<alpha_beta_gamma_delta>$$

B^T = A^T and

A = B .

Here and below all arithmetics is modulo two. Define length-$n$ vectors $e = ( C delta , C gamma ) quad upright("and") quad h = ( C beta , C alpha ) .$

From Eqs.~(@ABC2,#text([])

a\_beta\_gamma\_delta) one gets

~

\[

H^X h = \[A|B\]

\=AC+BC= C(A^T +

B^T ) = 0. Likewise, ~

\[

H^Z e = \[B^T|A^T\]

\=B^T C+ A^T C= C(B

ta + A ) = 0. Furthermore, ~

\[

h^T e = ^T C C + ^T C C= ^T + ^T =f^T g=1.

Thus $X ( e )$ and $Z ( h )$ are non-identity logical o

perators.

It follow

s that $d^

Z  |h|$. We get
\

\[

d^Z|h|=|C|+|C|=||+||=|f|=d^X.

Thus $d^Z lt.eq d^X$. Similar

ar argument shows that $d^

X  d^Z$, that is,$d^X=d^Z$.

~

~

We note that the equality $d^X = d^Z$ can also be established using the machinery of Ref.~@panteleev2021quantum by viewing $sans("QC") ( A , B )$ as a Lifted Product code.

In the following, we partition the set of data qubits as $[ n ] thin = thin L R$, where $L$ and $R$ are the left and right blocks of $n 2 = ell m$ data qubits. Then, data qubits $L$ and $R$ and checks $X$ and $Z$ may each be labeled by integers $bb(Z)_(ell m) = ( 0 , 1 , dots.h , ell m - 1 )$ which are indices into the matrices $A , B$. Alternatively, qubits and checks can be labeled by monomials from $cal(M) = ( 1 , y , dots.h , y^(m - 1) , x , x y , dots.h , x y^(m - 1) , dots.h , x^(ell - 1) y^(m - 1) )$ in this order, so that $i in bb(Z)_(ell m)$ labels the same qubit or check as $x^(a_i) y^(i - m a_i)$ for $a_i = upright("floor") ( i m )$. Using the monomial labeling, $L$ data qubit $alpha in cal(M)$ is part of $X$ checks $A_i^T alpha$ and $Z$ checks $B_i alpha$ for $i = 1 , 2 , 3$. Similarly, $R$ data qubit $beta in cal(M)$ is part of $X$ checks $B_i^T beta$ and $Z$ checks $A_i beta$. A unified notation assigns each qubit or check a label $q ( T , alpha )$ where $T in ( L , R , X , Z )$ denotes its type and $alpha in cal(M)$ its monomial label#footnote[The monomial notations should not be confused with the matrix notations used earlier in this section. For example, multiplication of monomials such as $B_i alpha$ is different from multiplying a vector $alpha$ by a matrix $B_i$.].

// [figvision-cn] imgs/wheel_extraction.png
// 图中共有两个子图，分别为A和B，均为量子纠错码（或晶格模
// 型）的示意图与提取电路的放大图。 子图A（左侧）：标题为
// “A) Extraction of ‘A’ wheels in G_A”。主体为一个由灰色
// 矩形块组成、呈周期性排列的二维晶格网络。晶格由相邻的白
// 色和灰色矩形区域交替排列，四个角落各有一个彩色圆形节点
// （分别为粉红色打叉标记、黄色R标记、蓝色L标记和绿色Z标
// 记）。在晶格内部，黑色箭头表示连接关系：水平方向箭头标
// 有“B_1”、“B_2”、“B_3”，垂直方向箭头标有“A_1”、“A_2”、“
// A_3”。节点之间通过虚线箭头连接。图右侧有一个黑色弧形箭
// 头指向一个放大圆圈，展示了提取出的“A”轮子结构：圆圈的
// 外围按顺序由六个节点组成（粉红X、蓝色L、绿色Z、黄色R、
// 粉红X、蓝色L），相邻节点间以带箭头的实线连接，形成闭合
// 环，周围有表示相互作用的虚线连接。该子图示意了从主晶格
// 中提取特定轮子结构的规则。 子图B（右侧）：标题为“B)
// Extraction of ‘B’ wheels in G_B”。主体结构与子图A相似，
// 同样由交替的灰色和白色矩形块组成，角落为对应的彩色节点。
// 不同之处在于节点间的连接布局。水平方向箭头标有“B_1”、“
// B_2”、“B_3”，垂直方向箭头标有“A_1”、“A_2”、“A_3”，箭头
// 方向与子图A不同。图右侧同样有一个黑色弧形箭头指向一个
// 放大圆圈，展示了提取出的“B”轮子结构：圆圈外围按顺序由
// 六个节点组成（蓝色L、绿色Z、黄色R、粉红X、黄色R、粉红X），
// 相邻节点间实线箭头连接，并包含指示内部或外部相互作用的
// 虚线。该子图示意了从主晶格中提取“B”轮子结构的规则。 整
// 体而言，该图展示了两种不同轮子结构（A和B）在晶格网络中
// 的位置及其相互连接关系，通过放大图清晰呈现了提取出的轮
// 子内部的环形拓扑结构。
#figure(image("imgs/wheel_extraction.png", width: 90.0%),
  caption: [
    A). B) Two different grids over a torus defined using different subsets of $A_1 , A_2 , A_3 , B_1 , B_2 , B_3$. Edge labels indicate adjacency matrices that generate the respective edges. By extracting either horizontal or vertical strips from these grids, we obtain planar 'wheel graphs' whose union contains all edges in the Tanner graph. The 'A' wheels (dashed lines) cover $A_2 , A_3 , B_3$ and the 'B' wheels (solid lines) cover $B_1 , B_2 , A_1$. To avoid clutter, each grid shows only a subset of edges present in the Tanner graph.
  ]
)
<fig:wheel_extraction>

// [figvision-cn] imgs/navigation.png
// 该图由左右两个子图组成，均为示意图，无坐标轴。子图A标
// 有“A) ‘Compass’ representation”，展示一个菱形布局。四
// 个节点位于菱形四角：顶部是粉色方框，内有字母X；底部是
// 绿色方框，内有字母Z；左侧是蓝色圆形，内有字母L；右侧是
// 黄色圆形，内有字母R。节点之间由双平行黑线连接构成菱形
// 边框。每条边上标有字母：顶边标A和B，右边标A和B，底边标
// A和B，左边标A和B，字母位置表示该边对应的标记。子图B标
// 有“B) Unit Cell for Lemma 4”，展示一个3×3节点网格的晶
// 胞结构。网格节点包括：四个角为粉色X方框，四个边中点为
// 粉色X方框（上、下、左、右），中心为绿色Z方框，左列中点
// 为蓝色L圆形，右列中点为蓝色L圆形，中列上、下分别为黄色
// R圆形。水平相邻节点间有带箭头的连接线，箭头从中心指向
// 两侧：顶部水平线连接X和R，标有B_g和B_h；中部水平线连接
// L和Z，标有B_g和B_h；底部水平线连接X和R，标有B_g和B_h。
// 垂直相邻节点间有带箭头的连接线，箭头向下：左侧垂直线连
// 接X和L，标有A_i和A_j；中部垂直线连接R和Z，标有A_i和A_j；
// 右侧垂直线连接X和L，标有A_i和A_j。网格向四周延伸，用虚
// 线表示与相邻晶胞的连接。
#figure(image("imgs/navigation.png", width: 60.0%),
  caption: [
    A) "Compass" diagram that shows the direction in which matrices $A , B$ are applied to travel between different nodes. B) The unit cell of the construction of a toric layout in the proof of .
  ]
)
<fig:navigation>

#block[
<lem:thickness> The Tanner graph $G$ of the code $sans("QC") ( A , B )$ has thickness $theta thin lt.eq thin 2$. A decomposition of $G$ into two planar layers can be computed in time $O ( n )$. Each planar layer of $G$ is a degree-3 graph.

]
#block[
#emph[Proof.] Let $G thin = thin \( V , E \)$ be the Tanner graph. Partition $G$ into subgraphs $G_A thin = thin \( V , E_A \)$ and $G_B thin = thin \( V , E_B \)$ that describe CSS codes with check matrices $ upright("Tanner graph ") G_A upright(":") quad H_A^X = \[ A_2 + A_3 \| B_3 \] quad upright("and") quad H_A^Z = \[ B_3^T \| A_2^T + A_3^T \] $ $ upright("Tanner graph ") G_B upright(":") quad H_B^X = \[ A_1 \| B_1 + B_2 \] quad upright("and") quad H_B^Z = \[ B_1^T + B_2^T \| A_1^T \] . $ Since $A = A_1 + A_2 + A_3$ and $B = B_1 + B_2 + B_3$, every edge of $G$ appears either in $G_A$ or $G_B$, where the two subgraphs are named by whether they contain more $A_i$ edges or more $B_i$ edges. Then $G_A$ and $G_B$ are regular degree-3 graphs (since $A_i$ and $B_j$ are permutation matrices).~◻

]

Consider the graph $G_A$. Each $X$-check vertex is connected to a pair of data vertices $i_1 , i_2 in L$ via the matrices $A_2 , A_3$ and a data vertex $i_3 in R$ via the matrix $B_3$. Each $Z$-check vertex is connected to a pair of data vertices $i_1 , i_2 in R$ via the matrices $A_2^T , A_3^T$ and a data vertex $i_3 in L$ via the matrix $B_3^T$.

We claim that each connected component of $G_A$ can be represented by a “wheel graph\" illustrated in . A wheel graph consists of two disjoint cycles of the same length $p$ interconnected by $p$ radial edges. The outer cycle alternates between $X$-check and $L$-data vertices.

Edges of the outer cycle alternate between those generated by $A_3$ (as one moves from a check to a data vertex) and $A_2^T$ (as one moves from a data to a check vertex). The length of the outer cycle is equal to the order of the matrix $A_3 A_2^T$, that is, the smallest integer $p$ such that $( A_3 A_2^T )^p = I_(ell m)$. For example, consider the code $[ [ 144 , 12 , 12 ] ]$ from . Then $A = x^3 + y + y^2$, $A_2 = y$, and $A_3 = y^2$. Thus $A_3 A_2^T = y^2 y^(- 1) = y$ which has order $m = 6$. The inner cycle of a wheel graph alternates between $Z$-check and $R$-data vertices.

Edges of the inner cycle alternate between those generated by $A_3^T$ (as one moves from a check to a data vertex) and $A_2$ (as one moves from a data to a check vertex). The length of the inner cycle is equal to the order of the matrix $A_3^T A_2$ which is just the transpose of $A_3 A_3^T$ considered earlier. Thus both inner and outer cycles have the same length $m$. The two cycles are interconnected by $m$ radial edges as shown in A).

Radial edges are generated by the matrix $B_3$, as one moves towards the center of the wheel. The wheel graph contains $4$-cycles generated by tuples of edges $( B_3 , A_2 , B_3^T , A_2^T )$ and $( B_3^T , A_3 , B_3 , A_3^T )$. Commutativity between $A_i$ and $B_j$

ensures that traversing any of these $4$-cycles implements the identity matrix, that is, the graph is well defined.

Clearly, the wheel graph is planar. Since $G_A$ is a disjoint union of wheel graphs, $G_A$ is p

lanar.

The same argument shows that $G_B$ is planar

r: see B).

We empirically observed that BB codes reported in have no weight-$4$ stabilizers. The presence of such stabilizers is known to have a negative impact on the performance of belief propagation decoders~@panteleev2021degenerate, which we use here.

The definition of code $sans("QC") ( A , B )$ does not guarantee that its Tanner graph is connected. Some choices of $A$ and $B$ lead to a code that is actually several separable code blocks. This manifests as a Tanner graph with several connected components. For instance, although all codes in are connected, taking any of them with even $ell$ and replacing every instance of $x$ with $x^2$ creates a code with two connected components.

#block[
<lem:connected> The Tanner graph of the code $sans("QC") ( A , B )$ is connected if and only if $S = { A_i A_j^T : i , j in ( 1 , 2 , 3 ) } union { B_i B_j^T : i , j in ( 1 , 2 , 3 ) }$ generates the group $cal(M)$. The number of connected components in the Tanner graph is $ell m | chevron.l S chevron.r |$, and all components are graph isomorphic to one another.

]
#block[
#emph[Proof.]~◻

]

is helpful for following the arguments in this proof. We start by proving the reverse implication of the first statement. Note that there is a length 2 path in the Tanner graph from $L$ qubit $alpha in cal(M)$ to $L$ qubit $A_i A_j^T alpha$ and another length 2 path to $L$ qubit $B_i B_j^T alpha$. These travel through $X$ and $Z$ checks, respectively. Thus, because the $A_i A_j^T$ and $B_i B_j^T$ generate $cal(M)$, there is some path from $alpha$ to any other $L$ qubit $beta$. A similar argument shows the existence of a path connecting any pair of R qubits. Since each $X$ check and each $Z$ check are connected to at least one $L$ qubit and at least one $R$ qubit, this implies that the entire Tanner graph is connected. The forward implication of the first statement follows after noticing that, for all $T in ( L , R , X , Z )$, the path from a type $T$ node to any other $T$ node is necessarily described as a product of elements from $S$. Connectivity of the Tanner graph implies the existence of all such paths, and so $S$ must generate $cal(M)$.

If $S$ does not generate $cal(M)$, it necessarily generates a subgroup $chevron.l S chevron.r$ and nodes in connected components of the Tanner graph are labeled by elements of the cosets of this subgroup. This implies the theorem's second statement.

For the next part, we establish some terminology. A spanning sub-graph of a graph $G$ is a sub-graph containing all the vertices of $G$. Also, the undirected Cayley graph of a finite Abelian group $cal(G)$ (with identity element $0$) generated by set $S subset cal(G)$ is the graph with vertex set $cal(G)$ and undirected edges $( g , g + s )$ for all $g in cal(G)$ and all $s in S , s eq.not 0$. We say the Cayley graph of $bb(Z)_a times bb(Z)_b$ when we mean the Cayley graph of $bb(Z)_a times bb(Z)_b$ generated by $( ( 1 , 0 ) , ( 0 , 1 ) )$. The order $upright("ord") ( g )$ of an element $g$ in a multiplicative group is the smallest positive integer such that $g^(upright("ord") ( g )) = 1$.

#block[
Code $sans("QC") ( A , B )$ is said to have a toric layout if its Tanner graph has a spanning sub-graph isomorphic to the Cayley graph of $bb(Z)_(2 mu) times bb(Z)_(2 lambda)$ for some integers $mu$ and $lambda$.

]

Note that only codes with connected Tanner graphs can have a toric layout according to this definition. An example toric layout is depicted in ~B).

#block[
<lem:toric_layout> A code $sans("QC") ( A , B )$ has a toric layout if there exist $i , j , g , h in ( 1 , 2 , 3 )$ such that

+ $chevron.l A_i A_j^T , B_g B_h^T chevron.r = cal(M)$ and

+ $upright("ord") ( A_i A_j^T ) upright("ord") ( B_g B_h^T ) = ell m$.

]
#block[
#emph[Proof.] We let $mu = upright("ord") \( A_i A_j^T \)$ and $lambda = upright("ord") \( B_g B_h^T \)$. We associate qubits and checks in the Tanner graph of $sans("QC") \( A , B \)$ with elements of $cal(G) = bb(Z)_(2 mu) times bb(Z)_(2 lambda)$. For $L$ qubit with label $alpha in cal(M)$, because of (i), there is $\( a , b \) in bb(Z)_mu times bb(Z)_lambda$ such that $alpha = \( A_i A_j^T \)^a \( B_g B_h^T \)^b$. Because of (ii) and the pigeonhole principle, this choice of $\( a , b \)$ is unique. We associate $L$ qubit $alpha$ with $\( 2 a , 2 b \) in cal(G)$. Similarly, an $R$ qubit with label $alpha A_j^T B_g$ is associated with $\( 2 a + 1 , 2 b + 1 \) in cal(G)$, $X$-check $alpha A_j^T$ with $\( 2 a + 1 , 2 b \)$, and $Z$-check $alpha B_g$ with $\( 2 a , 2 b + 1 \)$. Edges in the Tanner graph $A_i , A_j^T , B_g , $ and $B_h^T$ can now be drawn as in (B) and correspond to edges in the Cayley graph of $cal(G)$. For instance, to get from $\( 2 a + 1 , 2 b + 1 \)$, an $R$ qubit, to $\( 2 a + 2 , 2 b + 1 \)$, a $Z$ check, we apply $A_i$, taking $R$ qubit labeled $alpha A_j^T B_g$ to the $Z$ check labeled $\( alpha A_j^T B_g \) A_i = alpha \( A_i A_j^T \) B_g$.~◻

]

All codes in have a toric layout with $mu = m$ and $lambda = ell$. Most of these codes satisfy with $i = g = 2$ and $j = h = 3$. The exception is the $bracket.l.double 90 , 8 , 10 bracket.r.double$ code, for which we can take $i = 2 , g = 1$ and $j = h = 3$.

However, we also note two interesting cases. First, there are codes with connected Tanner graphs that do not satisfy the conditions for a toric layout given in . One example of such a code is $sans("QC") ( A , B )$ with $ell , m = 28 , 14$, $A = x^26 + y^6 + y^8$, and $B = y^7 + x^9 + x^20$ which has parameters $[ [ 784 , 24 , lt.eq 24 ] ]$. Second, for a code satisfying the conditions of , it need not be the case that the set $( upright("ord") ( A_i A_j^T ) , upright("ord") ( B_g B_h^T ) )$ and the set $( ell , m )$ are equal. For example, the $[ [ 432 , 4 , lt.eq 22 ] ]$ code with $ell , m = 18 , 12$ and $A = x + y^11 + y^3$, $B = y^2 + x^15 + x$ only satisfies with $mu , lambda = 36 , 6$ (take $i = g = 1$ and $j = h = 2$ for instance).

= Syndrome measurement circuit
<sec:syndrome_circuit>

The next step is to furnish the code $sans("QC") ( A , B )$ with a syndrome measurement (SM) circuit that repeatedly measures the syndrome of each check operator. Here we describe a SM circuit that requires $2 n$ physical qubits in total: $n$ data qubits and $n$ ancillary check qubits used to record the measured syndromes. The circuit only applies $"Gate"{CNOT}$s to pairs of qubits that are connected in the Tanner graph.

The SM circuit is defined as a periodically repeated sequence of #emph[syndrome cycles] (SC). A single SC is responsible for measuring syndromes of all $n$ check operators of the code. Let $N_c$ be the number of syndrome cycles. We envision that $N_c thin > thin 1$. The circuit begins and ends with a special initialization and measurement cycle responsible for initializing logical qubits in a suitable initial state and measuring logical qubits in a suitable basis. Here we focus on the optimization of the SC circuit. Logical initialization and measurements are discussed in .

The SC circuit is divided into $N_r$ #emph[rounds] such that each round is a depth-1 circuit composed of $"Gate"{CNOT}$s and single-qubit operations. The latter include initializing a qubit in the $X$ or $Z$ basis and measuring a qubit in the $X$ or $Z$ basis. $"Gate"{CNOT}$s can be applied only to pairs of qubits which are nearest neighbors in the Tanner graph. Some qubits remain idle during some rounds, although we try to minimize such occurrences by squeezing more useful computations in as little time as possible. Our notations are summarized in .

#block[
#block[
#figure(
  align(center)[#table(
    columns: 2,
    align: (center,center,),
    table.header([Notation], [Operation],),
    table.hline(),
    [$"sans"("CNOT") {c} {#2}{t}$], [$"Gate"{CNOT}$ with control qubit $c$ and target qubit $t$],
    [$sans("InitX") quad q$], [Initialize qubit $q$ in the state $| + chevron.r = ( | 0 chevron.r + | 1 chevron.r ) sqrt(2)$],
    [$sans("InitZ") quad q$], [Initialize qubit $q$ in the state $| 0 chevron.r$],
    [$sans("MeasX") quad q$], [Measure qubit $q$ in the $X$-basis $| + chevron.r , | - chevron.r$],
    [$sans("MeasZ") quad q$], [Measure qubit $q$ in the $Z$-basis $| 0 chevron.r , | 1 chevron.r$],
    [$sans("Idle") quad q$], [Identity gate on qubit $q$],
  )]
  , caption: [Elementary operations used for syndrome measurements.]
  , kind: table
  )

] <table:tab3>
]

#block[
#block[
#figure(
  align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([Round], [Circuit], [Round], [Circuit],),
    table.hline(),
    [1], [#block[
    #block[
    ]
    ]], [5], [#block[
    #block[
    ]
    ]],
    [2], [#block[
    #block[
    ]
    ]], [6], [#block[
    #block[
    ]
    ]],
    [3], [#block[
    #block[
    ]
    ]], [7], [#block[
    #block[
    ]
    ]],
    [4], [#block[
    #block[
    ]
    ]], [8], [#block[
    #block[
    ]
    ]],
  )]
  , caption: [Depth-8 syndrome measurement cycle circuit.]
  , kind: table
  )

] <table:syndromecircuit>
]

Below we describe a SC circuit with effectively $N_r thin = thin 8$ rounds#footnote[The operator $sans("InitZ") quad q ( Z , i )$ must be executed before the first application of this SC circuit, raising the depth of the first stage to 9. However, each following syndrome cycle takes Z-check initialization from the previous round. Last syndrome cycle needs not apply the Z-check state initialization. Total SM circuit depth with $N_c$ syndrome cycles is thus $8 N_c thin + thin 1$.]. Ignoring single-qubit initialization and measurement operations, the SC circuit is a depth-7 $"Gate"{CNOT}$ circuit. By designing the circuit for an explicit family of LDPC codes we are able to leverage the symmetries and reduce computational depth to $7$ from what otherwise would be $14 thin = thin 2 dot.op 6 thin + thin 2$, as shown by previous authors @tremblay2022constant[Theorem 1]. Our notations are as follows. We divide $n$ data qubits into the left and the right registers $q ( L )$ and $q ( R )$ of size $n 2$ each. Each check operator acts on three data qubits from $q ( L )$ and three data qubits from $q ( R )$. The SM circuit uses $2 n$ physical qubits in total: $n$ data qubits and $n$ ancillary check qubits that record the syndrome of each check operator. Let $q ( X )$ and $q ( Z )$ be the ancillary registers of size $n 2$ that span $X$-check and $Z$-check qubits respectively. Thus the physical qubits are partitioned into four registers, $q ( X )$, $q ( L )$, $q ( R )$, and $q ( Z )$, of size $n 2$ each. Label qubits in each register by integers $i = 1 , 2 , dots.h , n 2$. We write $q ( X , i )$ for the $i$-th qubit of the register $q ( X )$ with similar notations for $q ( L )$, $q ( R )$, and $q ( Z )$. Each permutation matrix $A_p$ and $B_q$ from Eq.~(@AB) defines a one-to-one map from the set $( 1 , 2 , dots.h , n 2 )$ onto itself.

We identify a permutation matrix and the corresponding one-to-one map. For example, we write $j thin = thin A_1 ( i )$ if the matrix $A_1$ has a one at row $i$ and column $j$ (this is well defined since $A_1$ is a permutation matrix). Likewise, we write $j thin = thin A_1^T ( i )$ if the transposed matrix $A_1^T$ has a one at the row $i$ and column $j$. In this notation, the $i$-th $X$-check operator acts on data qubits $q ( L , A_p ( i ) )$ and $q ( R , B_p ( i ) )$ with $p = 1 , 2 , 3$. The $i$-th $Z$-check operator acts on data qubits $q ( L , B_p^T ( i ) )$ and $q ( R , A_p^T ( i ) )$ with $p = 1 , 2 , 3$.

// [figvision-cn] imgs/syndromecircuit.png
// 该图为一张量子纠错中深度为8的综合征测量周期电路示意图。
// 图中水平方向表示时间或量子比特线，垂直方向划分了8个测
// 量轮次（Round），由顶部标注Round: 1至8的垂直蓝色网格线
// 分隔，网格线间距相等。电路包含五种类型的水平线，由左侧
// 标签和颜色标识： X checks（粉红色方框内标有X）：共6条
// 水平线，从上到下排列，每条线初始状态标注为|+⟩，全部位
// 于电路上半部分。 L data（蓝色圆圈内标有L）：1条粗水平
// 线，位于X checks线组下方。 R data（黄色圆圈内标有R）：
// 1条粗水平线，位于L data线下方。 Z checks（绿色方框内标
// 有Z）：共6条水平线，从上到下排列，每条线初始状态标注为
// |0⟩，全部位于电路下半部分。 图中包含两类操作符号： 受
// 控非门（CNOT）：由黑色实心圆点（控制比特）和空心大圆圈
// 内加十字（目标比特）组成，两者通过垂直黑线连接。 测量
// 操作：位于电路最右侧，分为上下两个矩形框，分别作用于X
// checks线组和Z checks线组。上方的测量框内包含一个指向右
// 上方的仪表符号和标签X；下方的测量框内包含一个指向右上
// 方的仪表符号和标签Z。 电路的具体连接与布局如下： 垂直
// 黑线连接一条控制线和一条目标线，表示CNOT操作。X checks
// 线组作为控制比特，目标比特为L data或R data线；Z checks
// 线组作为目标比特，控制比特为L data或R data线。 在Round
// 1中：X checks线组的第1条线（最上方）作为控制比特，目标
// 为Z checks线组的第1条线（最下方），两者之间有一个CNOT
// 门。Z checks线组的第1条线同时作为目标，控制比特为R
// data线，两者之间有一个CNOT门。 在Round 2中：X checks线
// 组的第1条线作为控制比特，目标为L data线，执行CNOT门。R
// data线作为控制比特，目标为Z checks线组的第2条线，执行
// CNOT门。 在Round 3中：X checks线组的第2条线作为控制比
// 特，目标为R data线，执行CNOT门。L data线作为控制比特，
// 目标为Z checks线组的第3条线，执行CNOT门。 在Round 4中：
// X checks线组的第3条线作为控制比特，目标为L data线，执
// 行CNOT门。R data线作为控制比特，目标为Z checks线组的第
// 4条线，执行CNOT门。 在Round 5中：X checks线组的第4条线
// 作为控制比特，目标为R data线，执行CNOT门。L data线作为
// 控制比特，目标为Z checks线组的第5条线，执行CNOT门。 在
// Round 6中：X checks线组的第5条线作为控制比特，目标为L
// data线，执行CNOT门。R data线作为控制比特，目标为Z
// checks线组的第6条线，执行CNOT门。同时，L data线作为控
// 制比特，目标为Z checks线组的第1条线，执行CNOT门。 在
// Round 7中：X checks线组的第6条线作为控制比特，目标为R
// data线，执行CNOT门。L data线作为控制比特，目标为Z
// checks线组的第2条线，执行CNOT门。 在Round 8中：无CNOT
// 操作，仅包含测量操作。上方测量框作用于X checks线组，下
// 方测量框作用于Z checks线组。测量框右侧有箭头指向一个共
// 同区域，标注为“Next cycle”，表示该周期结束后进入下一周
// 期。 该图传达的结论是：在深度为8的测量周期中，通过交替
// 使用X checks和Z checks线组作为控制或目标比特，与L data
// 和R data线进行CNOT门操作，实现对数据量子比特的多次奇偶
// 校验，最终在周期结束时对辅助量子比特进行测量，以提取综
// 合征信息并进入下一个纠错周期。
#figure(image("imgs/syndromecircuit.png", height: 8cm),
  caption: [
    Depth-8 syndrome measurement cycle circuit.
  ]
)
<fig:syndromecircuit>

Our depth-8 SC circuit is described in and illustrated in . Note that within each round all operations act over non-overlapping sets of qubits. In particular, each round applies at most one layer of $"Gate"{CNOT}$ gates between $q ( X )$ and $q ( L )$ registers (Rounds 2, 6, and 7), at most one layer of $"Gate"{CNOT}$s between $q ( X )$ and $q ( R )$ registers (Rounds 3, 4, and 5), at most one layer of $"Gate"{CNOT}$s between $q ( Z )$ and $q ( L )$ registers (Rounds 3, 4, and 5), and at most one layer of $"Gate"{CNOT}$s between $q ( Z )$ and $q ( R )$ registers (Rounds 1, 2, and 6). Qubits from $q ( Z )$ are always targets for $"Gate"{CNOT}$s. Accordingly, $X$-type errors propagate from data qubits to check qubits in $q ( Z )$. The latter are measured in the $Z$-basis in Round 7 revealing the syndrome of $X$-type errors. Qubits from $q ( X )$ are always controls for $"Gate"{CNOT}$s. Accordingly, $Z$-type errors propagate from data qubits to check qubits in $q ( X )$. The latter are measured in the $X$-basis in Round~8 revealing the syndrome of $Z$-type errors. We envision that the syndrome cycles are repeated periodically. This justifies applying $"Gate"{CNOT}$s to $q ( Z )$ at Round~1 even though $q ( Z )$ is initialized only at Round~8. Indeed, Round~8 of the previous syndrome cycle goes immediately before Round~1 of the current cycle. Thus $q ( Z )$ has been already initialized at the beginning of Round~1. We were not able to find a depth-8 (or smaller depth) syndrome cycle in which $X$-check and $Z$-check qubits are initialized and measured synchronously.

Let us now prove that the above SC circuit has the desired functionality. Since the circuit involves only Clifford operations, its action can be compactly described using stabilizer tableau@aaronson2004improved We track how the tableau changes as each layer of $"Gate"{CNOT}$s in the circuit is applied. Since the $"Gate"{CNOT}$ gates do not mix Pauli $X$ and $Z$ operators, one may consider tableau describing the action of the circuit on $X$-type and $Z$-type Pauli operators separately.

Let us begin with $X$-type Pauli. The corresponding tableau $T$ is a binary matrix of size $n thin times thin 2 n$ such that each row of $T$ defines an $X$-type stabilizer of the underlying quantum state. We partition columns of $T$ into four blocks that represent qubit registers $q ( X )$, $q ( L )$, $q ( R )$, and $q ( Z )$. We partition rows of $T$ into two blocks such that initially the top $n 2$ rows represent weight-$1$ check operators on qubits of the register $q ( X )$ initialized in the state $| + chevron.r$ while the bottom $n 2$ rows represent weight-$6$ check operators on data qubits associated with the chosen code $sans("QC") ( A , B )$. Thus, at the beginning of Round~1, when all check qubits in the register $q ( X )$ have been initialized in the state $| + chevron.r$, while data qubits are in some logical state of the code $sans("QC") ( A , B )$, the binary matrix is $mat(delim: "(", I, 0, 0, 0; 0, A, B, 0) .$ Here $I thin equiv thin I_(n 2)$ is the identity matrix. The SC circuit (ignoring qubit initialization and measurements) enacts the transformation $mat(delim: "(", I, 0, 0, 0; 0, A, B, 0) arrow.r^(upright("SC circuit")) mat(delim: "(", I, A, B, 0; 0, A, B, 0) .$ Indeed, the circuit must map a single-qubit $X$ stabilizer $X_j$ on a check qubit $j thin in thin q ( X )$ to a product of $X_j$ and the $j$-th $X$-type check operator on the data qubits determined by the $j$-th row of $H^X = [ A | B ]$. The eigenvalue measurement of $X_j$ at the final round then reveals the syndrome of the $j$-th check operator. The bottom $n 2$ rows must be unchanged since the check operators of the code must be the same before and after the syndrome measurement.

Let us verify that the circuit defined in enacts the desired transformation. To accomplish this, we rewrite the SC circuit by removing notations irrelevant to showing the correctness of $X$-checks. Specifically, we write each $"Gate"{CNOT}$ in as $"cnotgate"_M(a,b)$, where $a , b thin in thin ( 1 , 2 , 3 , 4 ) = ( q ( X ) , q ( L ) , q ( R ) , q ( Z ) )$, and $M thin in thin ( A_1 , A_2 , A_3 , B_1 , B_2 , B_3 )$. Note that the $"Gate"{CNOT}$ instructions where the matrix $M^T$ is used instead of $M$ can be written using matrix $M$ by performing the variable renaming $i thin arrow.l thin M ( i )$ in the corresponding for loop in .

Using the above compact notation, the unitary part of the SC circuit becomes:

$
  "Round 1:" & "cnotgate"_(A_1)(3,4) \
  "Round 2:" & "cnotgate"_(A_2)(1,2), "cnotgate"_(A_3)(3,4) \
  "Round 3:" & "cnotgate"_(B_2)(1,3), "cnotgate"_(B_1)(2,4) \
  "Round 4:" & "cnotgate"_(B_1)(1,3), "cnotgate"_(B_2)(2,4) \
  "Round 5:" & "cnotgate"_(B_3)(1,3), "cnotgate"_(B_3)(2,4) \
  "Round 6:" & "cnotgate"_(A_1)(1,2), "cnotgate"_(A_2)(3,4) \
  "Round 7:" & "cnotgate"_(A_3)(1,2)
$ <SCunitary_part>

In the following we apply all seven unitary rounds to verify the correctness of the performed transformation:

$
  "Round 1:" quad mat(delim: "(", I, 0, 0, 0; 0, A, B, 0)
    arrow.r^("cnotgate"_(A_1)(3,4))
    mat(delim: "(", I, 0, 0, 0; 0, A, B, A_1 B)
$

$
  "Round 2:" quad arrow.r^("cnotgate"_(A_2)(1,2))
    mat(delim: "(", I, A_2, 0, 0; 0, A, B, A_1 B)
    arrow.r^("cnotgate"_(A_3)(3,4))
    mat(delim: "(", I, A_2, 0, 0; 0, A, B, (A_1 + A_3) B)
$

$
  "Round 3:" quad arrow.r^("cnotgate"_(B_2)(1,3))
    mat(delim: "(", I, A_2, B_2, 0; 0, A, B, (A_1 + A_3) B)
    arrow.r^("cnotgate"_(B_1)(2,4))
    mat(delim: "(", I, A_2, B_2, A_2 B_1; 0, A, B, (A_1 + A_3) B + A B_1)
$

$
  "Round 4:" quad arrow.r^("cnotgate"_(B_1)(1,3))
    mat(delim: "(", I, A_2, B_1 + B_2, A_2 B_1; 0, A, B, (A_1 + A_3) B + A B_1) \
  arrow.r^("cnotgate"_(B_2)(2,4))
    mat(delim: "(", I, A_2, B_1 + B_2, A_2 (B_1 + B_2); 0, A, B, (A_1 + A_3) B + A (B_1 + B_2))
    = mat(delim: "(", I, A_2, B_1 + B_2, A_2 (B_1 + B_2); 0, A, B, A_2 B + A B_3)
$

Here, we use the identity $(A_1 + A_3) B + A (B_1 + B_2) = A_2 B + A B_3$, which holds since the sum of first summands and second summands on both sides of the equation gives $A B$, and $A B + A B = 0$.

$
  "Round 5:" quad arrow.r^("cnotgate"_(B_3)(1,3))
    mat(delim: "(", I, A_2, B, A_2 (B_1 + B_2); 0, A, B, A_2 B + A B_3)
    arrow.r^("cnotgate"_(B_3)(2,4))
    mat(delim: "(", I, A_2, B, A_2 B; 0, A, B, A_2 B)
$

$
  "Round 6:" quad arrow.r^("cnotgate"_(A_1)(1,2))
    mat(delim: "(", I, A_1 + A_2, B, A_2 B; 0, A, B, A_2 B)
    arrow.r^("cnotgate"_(A_2)(3,4))
    mat(delim: "(", I, A_1 + A_2, B, 0; 0, A, B, 0)
$

$
  "Round 7:" quad arrow.r^("cnotgate"_(A_3)(1,2))
    mat(delim: "(", I, A, B, 0; 0, A, B, 0) .
$

This is the desired transformation.

So far, we have not considered the action of the SC circuit on the logical qubits of the code. Let us show that this action is trivial. Indeed, consider some $X$-type logical operator $X ( v )$, where $v {in} "FF"_2^n$. Write $v thin = thin ( u , w )$ where $u$ and $w$ are restrictions of $v$ onto the registers 2 and 3 respectively. Commutativity between $X ( v )$ and any $Z$-type check operator implies $u B + w A = 0 .$ Here we consider $u$ and $w$ as row vectors. Extending $v$ by zeroes on registers 1 and 4 gives the row vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$, where $0$ stands for the all-zero row vector of length $n 2$. Let us follow the same chain of transformations as above starting from the initial vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$. All $"Gate"{CNOT}$s controlled by the register 1, such as $"cnotgate"_(A_2)(1,2)$ or $"cnotgate"_(B_2)(1,3)$ in Eq.~(@SCunitary_part), have trivial action on the vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$ since all qubits of the control register are zeroes. Such $"Gate"{CNOT}$s can be omitted. The remaining $"Gate"{CNOT}$s in Eq.~(#text([])) such as $"cnotgate"_(A_1)(3,4)$ or $"cnotgate"_(B_1)(2,4)$ map the initial vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$ to $( 0 #h(0em) u #h(0em) w #h(0em) t )$ for some vector $t$ since the registers 2 and 3 always serve as the controls and the register 4 always serves as the target. Rounds~1, 2, and 6 in Eq.~(@SCunitary_part) are equivalent to XORing vectors $w A_1$, $w A_3$, and $w A_2$ respectively to the register 4. Rounds~3, 4, and 5 in Eq.~(@SCunitary_part) are equivalent to XORing vectors $u B_1$, $u B_2$, and $u B_3$ respectively to the register 4. Thus $t = w ( A_1 + A_2 + A_3 ) + u ( B_1 + B_2 + B_3 ) = w A + u B = 0 .$ We have shown that the SC circuit maps the vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$ to itself. Hence the circuit acts trivially on logical $X$-type operators.

To prove the correctness of $Z$-checks, observe that $Z$-checks can be mapped into $X$-checks by conjugation with Hadamards. When the unitary circuit in is conjugated with Hadamards, this flips controls and targets of all $"Gate"{CNOT}$ gates. Thus, to verify $Z$-checks, it suffices to perform a very similar calculation to the one already shown for $X$-checks. We omit this calculation here.

The SC circuit shown in is not unique in the following sense: we found 935 depth-7 alternatives to the unitary part of the SC circuit via a computer search.

These alternatives are obtained from the circuit defined in Eq.~(@SCunitary_part) by applying the gate layers $"cnotgate"_(A_i)$ and $"cnotgate"_(B_j)$ in a different order. In the special case of the $[ [ 144 , 12 , 12 ] ]$ code, numerical simulations show that all 936 variants of the syndrome cycle give rise to syndrome measurement circuits with distance $"dcirc"less.eq 10$ explaining our focus on a specific circuit Eq.~(@SCunitary_part) which we conjecture to have distance $"dcirc" {=} 10$. The short depth of the single cycle, relying on only seven computational stages, helps to keep the spread of errors under control. Details of calculating upper bounds on the circuit-level distance are provided in .

= Decoder for the circuit-based noise model
<sec:decoder>

So far we assumed that the SM circuit is noiseless. As shown in @sec:syndrome_circuit, in this case all measured syndromes are zero and the circuit implements the logical identity gate. Consider now what happens when each operation in the circuit including $sans("CNOT")$ gates, qubit initializations, measurements, and idle qubits is subject to noise. To enable efficient decoding and numerical simulations, we use the standard circuit-based depolarizing noise model~@fowler2009high. It assumes that each operation in the circuit is ideal or faulty with the probability $1 - p$ or $p$ respectively. Here $p$ is a model parameter called the error rate. Faults on different operations occur independently. We define faulty operations as follows. A faulty $sans("CNOT")$ is an ideal $sans("CNOT")$ followed by one of $15$ non-identity Pauli errors on the control and the target qubits picked uniformly at random. A faulty initialization prepares a single-qubit state orthogonal to the correct one. A faulty measurement is an ideal measurement followed by a classical bit-flip error applied to the measurement outcome. A faulty idle qubit suffers from a Pauli error $X$ or $Y$ or $Z$ picked uniformly at random.

To perform error correction one needs a decoder --- a classical algorithm that takes as input the measured error syndrome and outputs a guess of the final Pauli error on the data qubits resulting from all faults in the SM circuit. The error syndrome may itself be faulty due to measurement errors. The decoder succeeds if the guessed Pauli error coincides with the actual error up to a product of check operators. In this case the guessed and the actual error have the same action on any logical state.

Let us show how to adapt Belief Propagation with an Ordered Statistics postprocessing step Decoder (BP-OSD) proposed in~@panteleev2021degenerate @roffe2020decoding to the circuit-based noise model. The decoder consists of two stages. The first stage takes as input a BB code $sans("QC")(A, B)$ equipped with a SM circuit $cal(U)$ and an error rate $p$. It outputs a certain linearized noise model that ignores possible cancellations between errors generated by two or more faulty operations in $cal(U)$. This stage is analogous to computing the decoding graph in error correction algorithms based on the surface code~@fowler2012topological @higgott2023sparse. The second (online) stage of the decoder takes as input an error syndrome measured in the experiment and outputs a guess of the final error on the data qubits. This stage decodes the linearized noise model using BP-OSD method~@panteleev2021degenerate @roffe2020decoding.

Our linearized noise model is conceptually similar to spacetime codes studied by Delfosse and Paetznick~@delfosse2023spacetime and detector-based noise model proposed by McEwen, Bacon, and Gidney~@mcewen2023relaxing. The online stage of our decoder closely follows Refs.~@higgott2023improved @geher2023tangling. In particular, Gehér, Crawford, and Campbell~@geher2023tangling applied BP-OSD to study tangled syndrome measurement circuits capable of measuring certain non-local check operators on a hardware with short-range qubit connectivity. Higgott et al~@higgott2023improved showed that the performance of the standard minimum-weight matching decoder can be enhanced by computing prior error probabilities using BP-decoder as a preprocessing step.

We begin by describing the offline stage. Consider a BB code with parameters $[ [ n, k, d ] ]$ and let $cal(U)$ be the SM circuit constructed in @sec:syndrome_circuit with $N_c$ syndrome cycles. The circuit $cal(U)$ contains $6 n N_c$ $sans("CNOT")$s, $n N_c$ initializations and measurements, and $2 n N_c$ idle qubit locations. Let $cal(U)_1, cal(U)_2, dots, cal(U)_M$ be the list of all possible faulty realizations of $cal(U)$ with exactly one faulty operation. If the faulty operation happens to be $sans("CNOT")$ or an idle qubit, one of the admissible Pauli errors for this operation is specified. A simple counting shows that $M = 98 n N_c$, where $98 = 15 dot.op 6 + 1 + 1 + 3 dot.op 2$ accounts for $15$ noisy realizations of each $sans("CNOT")$, $3$ realizations of memory errors on idle qubits, noisy initializations and measurements. By definition, the list $cal(U)_1, cal(U)_2, dots, cal(U)_M$ includes all realizations of $cal(U)$ that can occur with the probability $O(p)$ in the limit $p arrow.r 0$. We simulate each circuit $cal(U)_j$ by propagating the chosen Pauli error towards the final time step taking into account qubit initialization and measurement errors (if any). This simulation can be performed efficiently using the stabilizer formalism. Let $s_j^U in {0, 1}^(n N_c)$ be the full measured syndrome of $cal(U)_j$ and $E_j$ be the final $n$-qubit Pauli error on the data qubits generated by $cal(U)_j$. Let $s_j^F in {0, 1}^n$ be the syndrome of the final error $E_j$. In other words, if we write $E_j = X(alpha_j) Z(beta_j)$ for some vectors $alpha_j, beta_j in {0, 1}^n$, then

$ s_j^F = mat(delim: "[", H^Z alpha_j; H^X beta_j) . $

Here $H^X$ and $H^Z$ are the check matrices of the chosen code. Finally, let $s_j^L in {0, 1}^(2 k)$ be a #emph[logical syndrome] of the final error $E_j$ defined as follows. Fix some basis set of logical Pauli operators $overline(P)_1, overline(P)_2, dots, overline(P)_(2 k)$ for the chosen code. For example, $overline(P)_1, overline(P)_2, dots, overline(P)_k$ could be logical $X$-type operators and $overline(P)_(k + 1), overline(P)_(k + 2), dots, overline(P)_(2 k)$ could be logical $Z$-type operators. The $i$-th bit of $s_j^L$ is defined as

$ (s_j^L)_i = cases(
  1 & "if" quad E_j overline(P)_i = - overline(P)_i E_j,
  0 & "if" quad E_j overline(P)_i = overline(P)_i E_j,
) $

for $i = 1, dots, 2 k$. Note that the pair of syndromes $s_j^F, s_j^L$ uniquely determines the final error $E_j$ modulo check operators. Define a pair of #emph[decoding matrices] $D$ and $D^L$ of size $(n N_c + n) times M$ and $2 k times M$ respectively such that the $j$-th column of $D$ is

$ mat(delim: "[", s_j^U; s_j^F) $

and the $j$-th column of $D^L$ is $s_j^L$. Let $p_j$ be the probability of a Pauli error that occurred in the circuit $cal(U)_j$. We have $p_j = p\/15$ if $cal(U)_j$ contains a faulty $sans("CNOT")$, $p_j = p\/3$ if $cal(U)_j$ contains a faulty idle qubit, and $p_j = p$ if $cal(U)_j$ contains a faulty qubit initialization or measurement. Suppose $I subset.eq {1, 2, dots, M}$ is a subset of columns of $D$ such that triples of syndromes $(s_j^U, s_j^F, s_j^L)$ are the same for all $j in I$. We merge all columns in $I$ to a single column and assign the value $sum_(j in I) p_j$ to the bit-flip error probability associated with the merged column. Let $M$ be the number of columns of $D$ after the merging step and $p_1, p_2, dots, p_M$ be the respective error probabilities.

Next, the decoding matrix $D$ is converted to a sparse form. To this end consider a faulty circuit $cal(U)_j$ and a sequence of syndromes measured by $cal(U)_j$ on some check operator. Let this sequence be $m = (m_1, m_2, dots, m_(N_c)) in {0, 1}^(N_c)$. Since $cal(U)_j$ contains a single fault, the sequence $m$ has only a few locations where the measured syndromes differ at two consecutive cycles. For example, if $cal(U)_j$ contains a Pauli error on some idle data qubit between two syndrome cycles, the $m$-sequence may look as $(0, 0, dots, 0, 1, 1, dots, 1)$. Such sequence can be made sparse if we represent it by a binary vector

$ m' = (m_1, m_2 xor m_1, m_3 xor m_2, dots, m_(N_c) xor m_(N_c - 1)) in {0, 1}^(N_c) . $

In other words, $m'$ stores changes in the measured syndrome at a given check operators at each cycle. We convert the matrix $D$ to a sparse form by applying the map $m arrow.r m'$ to the syndromes measured by each check operator for each faulty circuit $cal(U)_j$.

Let $xi_1, xi_2, dots, xi_M in {0, 1}$ be independent random variables such that $xi_j$ takes values $0$ and $1$ with the probability $1 - p_j$ and $p_j$ respectively. Define a linearized noise model that outputs a random triple $(s^U, s^F, E)$, where

$ E = product_(j = 1)^M (E_j)^(xi_j) $

is an $n$-qubit Pauli error and

$ mat(delim: "[", s^U; s^F) = sum_(j = 1)^M xi_j mat(delim: "[", s_j^U; s_j^F) quad (upright("mod") 2) $

is a binary vector that represents the error syndrome. The linearized model is a simplified version of the circuit-based noise that ignores possible cancellations among errors generated by two or more faulty operations in $cal(U)$. Note that such errors occur with the probability only $O(p^2)$. The decoder attempts to guess the final error $E$ acting on the data qubits based on the syndrome $s^U$ measured in the experiment making a simplifying assumption that that the pair $(s^U, E)$ was generated using the linearized noise model. We additionally assume that the decoder knows the syndrome $s^F$ of the final error $E$. This syndrome can be acquired by adding one noiseless cycle at the end of the syndrome measurement circuit, which is a common practice in numerical simulations of error correction. By definition, we have

$ D xi = mat(delim: "[", s^U; s^F) . $

Here $xi = (xi_1, xi_2, dots, xi_M)$ is a column vector and matrix-vector multiplication is modulo two. Define a minimum weight error $xi^* = xi^*(s) in {0, 1}^M$ as a solution of an optimization problem

$ xi^* = upright("arg") min_(xi in {0, 1}^M) sum_(j = 1)^M log(1/p_j) xi_j quad upright("subject to") quad D xi = mat(delim: "[", s^U; s^F) . $ <MWD>

This problem is equivalent to the minimum weight decoding for a length-$M$ linear code with the check matrix $D$, bit-flip error probabilities $p_1, p_2, dots, p_M$, and noiseless syndromes. Our guess of the unknown logical syndrome is

$ s^L = D^L xi^* . $

Let $E^*$ be any $n$-qubit Pauli operator with the syndrome $s^F$ and the logical syndrome $s^L$. Note that $E^*$ is defined uniquely modulo multiplication by check operators. The Pauli $E^*$ is our guess of the final error on the data qubits. Let $E$ be the actual final error on the data qubits generated by a noisy realization of $cal(U)$ without making any simplifications of the noise model. By definition, Pauli operators $E$ and $E^*$ have the same syndrome but they may differ by a logical Pauli operator. We declare a logical error if $E$ and $E^*$ differ by any non-identity logical operator (there are $4^k - 1$ choices of this logical operator). Otherwise the decoding is deemed successful.