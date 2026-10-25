#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.84cm, right: 1.75cm, top: 1.91cm, bottom: 3.74cm))
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 1.15em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)
#let unnum(body) = block({ set math.equation(numbering: none); body })
#let thmbox(name, body) = figure(
  kind: lower(name),
  supplement: name,
  numbering: "1",
  block(width: 100%, align(left, {
    context [*#name #counter(figure.where(kind: lower(name))).display().*]
    h(0.4em)
    body
  })),
)
#let lemma(body) = thmbox("Lemma", body)
#let dfn(body) = thmbox("Definition", body)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#align(center)[
  #text(17pt, weight: "bold", [High-threshold and low-overhead fault-tolerant quantum memory])
  #v(1.2em)
  #text(11pt)[Sergey Bravyi#super[1], Andrew W. Cross#super[1], Jay M. Gambetta#super[1], Dmitri Maslov#super[1], Patrick Rall#super[2], Theodore J. Yoder#super[1]]
  #v(0.5em)
  #text(8.5pt)[#super[1] IBM Quantum, IBM T.J. Watson Research Center, Yorktown Heights, NY 10598 (USA) \
  #super[2] IBM Quantum, MIT-IBM Watson AI Lab, Cambridge, MA 02142 (USA)]
]
#v(1.6em)

// abshead
#align(center)[#text(9pt, weight: "bold")[Abstract]]

Quantum error correction becomes a practical possibility only if the physical error rate is below a threshold value that depends on a particular quantum code, syndrome measurement circuit, and decoding algorithm. Here we present an end-to-end quantum error correction protocol that implements fault-tolerant memory based on a family of LDPC codes with a high encoding rate that achieves an error threshold of $0.8%$ for the standard circuit-based noise model. This is on par with the surface code which has remained an uncontested leader in terms of its high error threshold for nearly 20 years. The full syndrome measurement cycle for a length-$n$ code in our family requires $n$ ancillary qubits and a depth-7 circuit composed of nearest-neighbor CNOT gates. The required qubit connectivity is a degree-6 graph that consists of two edge-disjoint planar subgraphs.

As a concrete example, we show that 12 logical qubits can be preserved for nearly one million syndrome cycles using 288 physical qubits in total, assuming the physical error rate of $0.1%$. We argue that achieving the same level of error suppression on 12 logical qubits with the surface code would require nearly 3000 physical qubits. Our findings bring demonstrations of a low-overhead fault-tolerant quantum memory within the reach of near-term quantum processors.

= Introduction
<introduction>

Quantum computing attracted attention due to its ability to offer asymptotically faster solutions to a set of computational problems compared to the best known classical algorithms @nielsen2002quantum. It is believed that a scalable functioning quantum computer may help solve computational problems in such areas as scientific discovery, materials research, chemistry, and drug design, to name a few @lloyd1996universal @wang2008quantum @reiher2017elucidating @alexeev2021quantum.

The main obstacle to building a quantum computer is the fragility of quantum information, owing to various sources of noise affecting it. Since isolating a quantum computer from external effects and controlling it to induce a desired computation are in conflict with each other, noise appears to be inevitable. The sources of noise include imperfections in qubits, materials used, controlling apparatus, State Preparation and Measurement (SPAM) errors, and a variety of external factors ranging from local man-made, such as stray electromagnetic fields, to those inherent to the Universe, such as cosmic rays. See Ref. @gambetta2017building for a summary. While some sources of noise can be eliminated with better control @mundada2023experimental, materials @de2021materials, and shielding @10.1063-1.3658630 @vepsalainen2020impact @PRXQuantum.4.020356, a number of other sources appear to be difficult if at all possible to remove. The latter kind can include spontaneous and stimulated emission in trapped ions @wu2018noise @boguslawski2023raman, and the interaction with the bath (Purcell Effect) @Houck2008 in superconducting circuits---covering both leading quantum technologies.

Thus, error correction becomes a key requirement for building a functioning scalable quantum computer.

The possibility of quantum fault tolerance was established earlier @shor1995scheme. Encoding a logical qubit redundantly into many physical qubits enables one to diagnose and correct errors by repeatedly measuring syndromes of parity check operators. However, error correction is only beneficial if the hardware error rate is below a certain threshold value that depends on a particular error correction protocol. The first proposals for quantum error correction, such as concatenated codes~@aharonov1997fault @kitaev1997quantum @aliferis2005quantum, focused on demonstrating the theoretical possibility of error suppression. As understanding of quantum error correction and the capabilities of quantum technologies matured, the focus shifted to finding practical quantum error correction protocols. This resulted in the development of the surface code @2003faulkitaevt @bravyi1998quantum @dennis2002topological @fowler2009high that offers a high error threshold close to $1%$, fast decoding algorithms, and compatibility with the existing quantum processors relying on 2-dimensional (2D) square lattice qubit connectivity. Small examples of the surface code with a single logical qubit have been already demonstrated experimentally by several groups~@takita2016demonstration @marques2022logical @krinner2022realizing @zhao2022realization @google2023suppressing. However, scaling up the surface code to a hundred or more logical qubits would be prohibitively expensive due to its poor encoding efficiency. This spurred interest in more general quantum codes known as Low-Density Parity-Check (LDPC) codes @gottesman2013fault. Recent progress in the study of LDPC codes suggests that they can achieve quantum fault-tolerance with a much higher encoding efficiency @tremblay2022constant. Here, we focus on the study of LDPC codes, as our goal is to find quantum error correction codes and protocols that are both efficient and possible to demonstrate in practice, given the limitations of quantum computing technologies.

A quantum error correcting code is of LDPC type if each check operator of the code acts only on a few qubits and each qubit participates only in a few checks. Multiple variants of the LDPC codes have been proposed recently including hyperbolic surface codes~@breuckmann2016constructions @higgott2021subsystem @higgott2023constructions, hypergraph product~@tillich2013quantum, balanced product codes~@breuckmann2021balanced, two-block codes based on finite groups~@kovalev2013quantum @panteleev2021degenerate @lin2023quantum @wang2023abelian, and quantum Tanner codes~@panteleev2022asymptotically @leverrier2022quantum. The latter were shown~@panteleev2022asymptotically @leverrier2022quantum to be asymptotically "good" in the sense of offering a constant encoding rate and linear distance -- a parameter quantifying the number of correctable errors. In contrast, the surface code has an asymptotically zero encoding rate and only square-root distance. Replacing the surface code with a high-rate, high-distance LDPC code could have major practical implications. First, fault-tolerance overhead (the ratio between the number of physical and logical qubits) could be reduced dramatically. Secondly, high-distance codes exhibit a very sharp decrease in the logical error rate: as the physical error probability crosses the threshold value, the amount of error suppression achieved by the code can increase by orders of magnitude even with a small reduction of the physical error rate. This feature makes high-distance LDPC codes attractive for near-term demonstrations which are likely to operate in the near-threshold regime.

Here we present several concrete examples of high-rate LDPC codes with a few hundred physical qubits equipped with a low-depth syndrome measurement circuit, an efficient decoding algorithm, and a fault-tolerant protocol for addressing individual logical qubits. These codes exhibit an error threshold close to 1%, show excellent performance in the near-threshold regime, and offer of the encoding overhead compared with the surface code. Hardware requirements for realizing our error correction protocols are relatively mild, as each physical qubit is coupled by two-qubit gates with only six other qubits. Although the qubit connectivity graph is not locally embeddable into a 2D grid, it can be decomposed into two planar degree-3 subgraphs. As we argue below, such qubit connectivity is well-suited for architectures based on superconducting qubits. Before stating our results, let us describe several must-have features for a quantum error-correcting code to be suitable for near-term experimental demonstrations and formally pose the problem addressed in this work.

= Code selection criteria
<code-selection-criteria>

In this work, we study the problem of realizing a fault-tolerant quantum memory with a small qubit overhead and a large code distance. Our goal is to construct a combination of the LDPC code, syndrome measurement circuitry, and the decoding (error correction) algorithms, suitable for a near-term demonstration, but also offering long-term utility, while taking into account the capabilities and limitations of the superconducting circuits quantum hardware. In other words, we seek to develop a practical error correction protocol. Our selection criteria reflect this goal.

We focus on encoding $k gt.double 1$ logical qubits into $n$ data qubits and use $c$ ancillary check qubits to measure the error syndrome. In total, the code relies on $n thin + thin c$ physical qubits. The net encoding rate is therefore $r = frac(k, n + c) .$ For example, the standard surface code architecture encodes $k thin = thin 1$ logical qubit into $n thin = thin d^2$ data qubits for a distance-$d$ code and uses $c thin = thin n - 1$ check qubits for syndrome measurements. The net encoding rate is $r approx 1 ( 2 d^2 )$, which quickly becomes impractical as one is forced to choose a large code distance, due to, for instance, the physical errors being close to the threshold value. In contrast, we seek a high-rate LDPC code with $r gt.double 1 d^2$.

To prevent the accumulation of errors one must be able to measure the error syndrome frequently enough. This is accomplished by a syndrome measurement (SM) circuit that couples data qubits in the support of each check operator with the respective ancillary qubit by a sequence of $sans("CNOT")$ gates. Check qubits are then measured revealing the value of the error syndrome. The time it takes to implement the SM circuit is proportional to its depth --- the number of gate layers composed of non-overlapping $sans("CNOT")$s. Since new errors continue to occur while the SM circuit is executed, its depth should be minimized. Thus we seek an LDPC code with a high rate $r$ and low-depth SM circuit.

A noisy version of the SM circuit may include several types of faulty operations such as memory errors on data or check qubits, faulty $sans("CNOT")$ gates, qubit initializations and measurements. We consider the circuit-based noise model~@fowler2009high where each operation fails with the probability $p$. Faults on different operations are independent. A logical error occurs when the final error-corrected state of $k$ logical qubits differs from the initial encoded state. The probability of a logical error $p_L$ depends on the error rate $p$, details of the SM circuits, and a decoding algorithm. A pseudo-threshold $p_0$ of an error correction protocol is defined as a solution of the break-even equation $p_L ( p ) = k p$. Here $k p$ is an estimate of the probability that at least one of $k$ unencoded qubits suffers from an error. To achieve a significant error suppression in the regime $p thin tilde thin 10^(- 3)$, which is relevant for near-term demonstrations, it is desirable to have pseudo-threshold close to 1% or higher. For example, the surface code architecture achieves pseudo-threshold $p_0 approx 1 "%"$ for a large enough code distance@fowler2009high. We seek a high-rate LDPC code with a low-depth SM circuit and a high pseudo-threshold.

A logical error is undetectable if it can be generated without triggering any syndromes. Such errors span at least $d$ data qubits for a distance-$d$ code. Let us say that a SM circuit has distance $d_sans("circ")$ if it takes at least $d_sans("circ")$ faulty operations in the circuit to generate an undetectable logical error. By definition, $d_sans("circ") {lt.eq} d$ for any distance-$d$ code and typically $d_sans("circ") {<} d$ since a few faulty operations in the SM circuit may create a high-weight error on the data qubits. We say that a SM circuit is distance-preserving if $d_sans("circ") {=} d$ meaning the circuit is designed so as to avoid accumulating high-weight errors, which is the best one can hope for. It is preferred (but not required) that the SM circuit is distance-preserving.

Another criterion is dictated by the limited qubit connectivity of near-term quantum devices. Each quantum code can be described by a Tanner graph $G$ such that each vertex of $G$ represents either a data qubit or a check operator. A check vertex $i$ and a data vertex $j$ are connected by an edge if the $i$-th check operator acts non-trivially on the $j$-th data qubit (by applying Pauli $X$ or $Z$). ~A) shows the Tanner graph describing a distance-3 surface code. To keep the SM circuit depth small, it is desirable that two-qubit gates such as $sans("CNOT")$ can be applied along every edge of the Tanner graph. By construction, the Tanner graph of any LDPC code has a small degree. One drawback of high-rate LDPC codes is that their Tanner graphs may not be locally embeddable into the 2D grid~@baspin2022quantifying @bravyi2010tradeoffs. This poses a challenge for hardware implementation with superconducting qubits coupled by microwave resonators. A useful VLSI design concept is graph #emph[thickness], see~@mutzel1998thickness @tremblay2022constant for details. A graph $G thin = thin ( V , E )$ is said to have thickness $theta$ if one can partition its set of edges $E$ into disjoint union of $theta$ sets $E_1 union.sq E_2 union.sq dots.h union.sq E_theta thin = thin E$ such that each subgraph $( V , E_i )$ is planar. Informally, a graph with thickness $theta$ can be viewed as a vertical stack of $theta$ planar graphs. Qubit connectivity described by a planar graph (thickness $theta thin = thin 1$) is the simplest one from hardware perspective since the couplers do not cross. Graphs with thickness $theta thin = thin 2$ might still be implementable since two planar layers of couplers and their control lines can be attached to the top and the bottom side of the chip hosting qubits, and the two sides mated (see for a detailed discussion).

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

Here we give concrete examples of LDPC codes equipped with syndrome measurement circuits and efficient decoding algorithms that meet all above conditions. Our examples fall into the family of tensor product generalized bicycle codes proposed by Kovalev and Pryadko@kovalev2013quantum. These are stabilizer codes of CSS-type~@steane1996multiple @calderbank1996good that can be described by a collection of few-qubit check (stabilizer) operators composed of Pauli $X$ and $Z$. At a high level, a BB code is similar to the two-dimensional toric code@2003faulkitaevt. In particular, physical qubits of a BB code can be laid out on a two-dimensional grid with periodic boundary conditions such that all check operators are obtained from a single pair of $X$- and $Z$-checks by applying horizontal and vertical shifts of the grid. However, in contrast to the plaquette and vertex stabilizers describing the toric code, check operators of a BB code are not geometrically local. Furthermore, each check acts on six qubits rather than four qubits. See @fig:2Dlayout~B) an example Tanner graph of a BB code. We give a formal definition of BB codes in @sec:codedefinition. The Tanner graph of any BB code has vertex degree six. Although this graph may not be locally embeddable into a 2D grid, we show that it has thickness $theta thin = thin 2$, as desired. This result may be surprising since it is known that a general degree-$6$ graph can have thickness $theta thin = thin 3$, see@mutzel1998thickness.

// [figvision] imgs/fig1.png
// Title "Tanner Graphs of Surface and Bivariate Bicycle Codes", three labelled parts.
// (A) Tanner graph of a surface code: a rotated lattice of open circles (data qubits)
//     joined by edges to pink squares marked X and teal squares marked Z (checks); curved
//     arrows label the two node types "data" and "checks".
// (B) Tanner graph of the [[144,12,12]] bivariate bicycle code: a 12x12 array of nodes,
//     alternating rows of circular data nodes (blue L, orange R) and square checks
//     (pink X, teal Z); solid horizontal black edges are 'A' edges, dotted vertical edges
//     are 'B' edges; black arrows run along the outer boundary, and a long black loop
//     traces a diagonal closed path through the array (the logical operator / wheel).
//     Legend below: L data, R data, X check, Z check, 'A' edge, 'B' edge.
// (C) "Sketch: Attaching to a Surface Code": a box labelled "Surface Code" with two
//     horizontal teal rails labelled "Ancilla for X-bar"; below, a quasi-cyclic code
//     patch (blue/orange circles with pink X, teal Z and orange R nodes, wavy orange
//     line) labelled "Quasi-Cyclic Code", ending in two rails labelled "Ancilla for Z-bar".
#figure(image("imgs/fig1.png", height: 9cm),
  caption: [
    A) Tanner graph of a surface code, for comparison. C) Tanner graph of a Bivariate Bicycle code with parameters $[ [ 144 , 12 , 12 ] ]$ embedded into a torus. Any edge of the Tanner graph connects a data and a check vertex. Data qubits associated with the registers $q ( L )$ and $q ( R )$ are shown by bLue and oRange circles. Each vertex has six incident edges including four short-range edges (pointing north, south, east, and west) and two long-range edges. There are also several long-range edges, of which we only show a few to to avoid clutter. Dashed and solid edges indicate two planar subgraphs spanning the Tanner graph, see @sec:codedefinition. B) Sketch of a Tanner graph extension for measuring $macron(Z)$ and $macron(X)$ following @cohen2022lowoverhead. The ancilla corresponding to the $macron(X)$ measurement can be connected to a surface code, enabling load-store operations for all logical qubits via quantum teleportation and some logical unitaries. This extended Tanner graph has a thickness-2 implementation, see @sec:logicals.
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
    table.hline(),
    [$[ [ n , k , d ] ]$], [Net Encoding \
    Rate $r$], [Circuit-level \
    distance $d_sans("circ")$], [Pseudo-threshold $p_0$], [$p_L ( 0.001 )$], [$p_L ( 0.0001 )$],
    table.hline(),
    [$[ [ 72 , 12 , 6 ] ]$], [1/12], [$lt.eq 6$], [$0.0048$], [$7 times 10^(- 5)$], [$7 times 10^(- 8)$],
    [$[ [ 90 , 8 , 10 ] ]$], [$1/23$], [$lt.eq 8$], [$0.0053$], [$5 times 10^(- 6)$], [$4 times 10^(- 10)$],
    [$[ [ 108 , 8 , 10 ] ]$], [1/27], [$lt.eq 8$], [$0.0058$], [$3 times 10^(- 6)$], [$1 times 10^(- 10)$],
    [$[ [ 144 , 12 , 12 ] ]$], [$1/24$], [$lt.eq 10$], [$0.0065$], [$2 times 10^(- 7)$], [$8 times 10^(- 13)$],
    [$[ [ 288 , 12 , 18 ] ]$], [$1/48$], [$lt.eq 18$], [$0.0069$], [$2 times 10^(- 12)$], [$1 times 10^(- 22)$],
  )]
  , caption: [Small examples of Bivariate Bicycle LDPC codes and their performance for the circuit-based noise model. All codes have weight-6 checks, thickness-2 Tanner graph, and a depth-$7$ syndrome measurement circuit. A code with parameters $[ [ n , k , d ] ]$ requires $2 n$ physical qubits in total and achieves the net encoding rate $r = k 2 n$ (we round $r$ down to the nearest inverse integer). Circuit-level distance $d_sans("circ")$ is the minimum number of faulty operations in the syndrome measurement circuit required to generate an undetectable logical error. The pseudo-threshold $p_0$ is a solution of the break-even equation $p_L ( p ) = k p$, where $p$ and $p_L$ are the physical and logical error rates respectively. The logical error rate $p_L$ was computed numerically for $p gt.eq 10^(- 3)$ and extrapolated to lower error rates. ]
  , kind: table
  ) <table:codes_intro>

]
]

To quantify the level of error suppression achieved by a code we introduce SM circuits that repeatedly measure the syndrome of each check operator. The full cycle of syndrome measurement for a length-$n$ BB code requires $n$ ancillary check qubits to store the measured syndromes. According, the net encoding rate is $r = k\/(2 n)$. Check qubits are coupled with the data qubits by applying a sequence of $sans("CNOT")$ gates. The full cycle of syndrome measurement requires only $7$ layers of $sans("CNOT")$s regardless of the code length. The check qubits are initialized and measured at the beginning and at the end of the syndrome cycle respectively, see @sec:syndrome_circuit for details. We emphasize that our SM circuit applies to any BB code beyond those listed in @table:codes_intro. The circuit respects the cyclic shift symmetry of the underlying code. Assuming that the physical qubits (data or check) are located at vertices of the Tanner graph, all $sans("CNOT")$ gates in the SM circuit act on nearest-neighbor qubits. Thus the required qubit connectivity is described by a degree-6 thickness-2 graph, as desired. We conjecture, based on the numerical simulations, that our SM circuit is distance-preserving for the code $[ [ 72 , 12 , 6 ] ]$, see @table:codes_intro for the upper bounds on $d_sans("circ")$ (the upper bound $d_sans("circ") lt.eq 18$ for the 288-qubit code is unlikely to be tight and this affects the fit and extrapolations).

The full error correction protocol performs $N_c gt.double 1$ syndrome measurement cycles and calls a decoder --- a classical algorithm that takes as input the measured syndromes and outputs a guess of the final error on the data qubits. Error correction succeeds if the guessed and the actual error coincide modulo a product of check operators. In this case the two errors have the same action on any encoded (logical) state. Thus applying the inverse of the guessed error would return data qubits to the initial logical sate. Otherwise, if the guessed and the actual error differ by a non-trivial logical operator, error correction fails resulting in a logical error. Our numerical experiments are based on the Belief Propagation with an Ordered Statistics Decoder (BP-OSD) proposed by Panteleev and Kalachev@panteleev2021degenerate. The original work~@panteleev2021degenerate described BP-OSD in the context of a toy noise model with memory errors only. Here we show how to extend BP-OSD to the circuit-based noise model. Our approach closely follows Refs.~@delfosse2023spacetime @mcewen2023relaxing @higgott2023improved @geher2023tangling. We also show that BP-OSD can be applied to other problems in quantum fault-tolerance such as estimating the distance of a quantum LDPC code, see @sec:decoder for details. These tasks can be accomplished with a relatively minor extension of the publicly available BP-OSD software developed by Roffe et al.~@roffe2020decoding.

Let $P_L ( N_c )$ be the logical error probability after performing $N_c$ syndrome cycles. Define the logical error rate as $p_L = 1 - ( 1 - P_L ( N_c ) )^(1/N_c) approx P_L ( N_c )/N_c$. Informally, $p_L$ can be viewed as the logical error probability per syndrome cycle. Following common practice, we choose $N_c = d$ for a distance-$d$ code. @fig:numerics A) shows the logical error rate achieved by codes from @table:codes_intro. The logical error rate was computed numerically for $p gt.eq 10^(- 3)$ and extrapolated to lower error rates using a fitting formula $p_L=p^(d_sans("circ")\'/2) e^(c_0 + c_1 p + c_2p^2)$, where $c_0 , c_1 , c_2$ are fitting parameters and $d_sans("circ")\'$ is an upper bound on $d_sans("circ")$ from @table:codes_intro. The observed pseudo-threshold for the $144$-qubit and $288$-qubit codes is close to $0.007$, which is nearly the same as the error threshold of the surface code@groszkowski2009high. To the best of our knowledge, this provides the first example of high-rate, large-distance LDPC codes achieving the pseudo-threshold close to 1 $"%"$ under the circuit-based noise model.

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
#figure(placement: top, 
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    // [figvision] imgs/small_ldpc.png
    // Log-log plot: logical error rate p_L (vertical, 1e-13..1e-1) versus physical error
    // rate p (horizontal, 1e-4..1e-2). Five straight-line fits with diamond markers:
    // [[72,12,6]] (blue, steepest at low p: p_L ~2e-8 at p=1e-4), [[90,8,10]] (green),
    // [[108,8,10]] (orange), [[144,12,12]] (red) and [[288,12,18]] (magenta, lowest p_L at
    // small p, ~1e-13 extrapolated) - larger distance gives a steeper slope and lower p_L.
    // All curves converge near p ~ 5e-3.
    align(center)[#image("imgs/small_ldpc.png", width: 100%)],
    // [figvision] imgs/ldpc_vs_surface.png
    // Log-log comparison: p_L (1e-13..1e-1) versus p (1e-4..1e-2). Star markers = surface
    // codes [[972,12,9]] (grey), [[1452,12,11]] (green), [[2028,12,13]] (blue),
    // [[2700,12,15]] (pink); red diamonds = LDPC [[144,12,12]]. The LDPC curve lies below
    // all four surface-code curves and nearly coincides with the [[2028,12,13]] line at
    // p >= 1e-3, i.e. far fewer physical qubits for comparable logical performance.
    align(center)[#image("imgs/ldpc_vs_surface.png", width: 100%)],
  ),
  caption: [
    A) Logical vs physical error rate for small examples of Bivariate Bicycle LDPC codes. A numerical estimate of $p_L$ (diamonds) was obtained by simulating $d$ syndrome cycles for a distance-$d$ code. Most of the data points have error bars $approx p_L\/10$ due to sampling errors. B) Comparison between the Bivariate Bicycle LDPC code $[ [ 144 , 12 , 12 ] ]$ and surface codes with $12$ logical qubits and distance $d in {9 , 11 , 13 , 15}$. The distance-$d$ surface code with $12$ logical qubits has length $n = 12 d^2$ since each logical qubit is encoded into a separate $d times d$ patch of the surface code lattice.
  ],
) <fig:numerics>

For example, suppose that the physical error rate is $p = 10^(- 3)$, which is a realistic goal for near-term demonstrations. Encoding $12$ logical qubits using the distance-$12$ code from @table:codes_intro would offer the logical error rate $2 times 10^(-7)$ which is enough to preserve $12$ logical qubits for nearly one million syndrome cycles. The total number of physical qubits required for this encoding is $288$. The distance-$18$ code from @table:codes_intro would require $576$ physical qubits while suppressing the error rate from $10^(-3)$ to $2 times 10^(-12)$ enabling roughly hundred billion syndrome cycles. For comparison, encoding $12$ logical qubits into separate patches of the surface code would require nearly $3000$ physical qubits to suppress the error rate from $10^(-3)$ to $10^(-6)$, see @fig:numerics~B). In this example the distance-$12$ BB code offers more than $10$X saving in the number of physical qubits compared with the surface code.

We also find that BB LDPC codes admit extensions that allow them to function as a logical memory with load-store operations. In @sec:logicals we show how to use methods from @cohen2022lowoverhead to attach two ancilla systems to the code that permit logical measurement of all logical qubits in the $X$ and $Z$ bases. Which logical qubit is being measured can be controlled via a set of fault tolerant unitary operations. The extended Tanner graph is not only thickness-2, but the extension from the $X$ ancilla system is "effectively planar" (in a sense we define later) facilitating interconnection with other codes on the same chip.

Our findings bring experimental demonstration of high-rate LDPC codes within the reach of near-term quantum processors which are expected to offer a few hundred physical qubits, gate error rates close to $10^(- 3)$, and long range qubit connectivity@bravyi2022future.

The rest of this paper is organized as follows. @sec:codedefinition formally defines BB LDPC codes and proves their basic properties. The construction of the syndrome measurement circuit is detailed in @sec:syndrome_circuit. The circuit-based noise model and BP-OSD decoder for this noise model are discussed in @sec:decoder with some implementation details deferred to @sec:numerics. We describe fault tolerant memory capabilities in @sec:logicals. A summary of our findings and some open questions can be found in @sec:conclusions.

= Bivariate Bicycle quantum LDPC codes
<sec:codedefinition>

Let $I_ell$ and $S_ell$ be the identity matrix and the cyclic shift matrix of size $ell times ell$ respectively. The $i$-th row of $S_ell$ has a single nonzero entry equal to one at the column $i thin + thin 1 med ( mod med ell )$. For example,
#unnum[$ S_2 = mat(0, 1; 1, 0; delim: "["), quad "and" quad S_3 = mat(0, 1, 0; 0, 0, 1; 1, 0, 0; delim: "["). $]
Consider matrices
#unnum[$ x = S_ell ⊗ I_m quad "and" quad y = I_ell ⊗ S_m . $]
Note that $x y = y x$ and $x^ell = y^m = I_(ell m)$. A BB code is defined by a pair of matrices
$ A = A_1 + A_2 + A_3 quad "and" quad B = B_1 + B_2 + B_3 $ <AB>
where each matrix $A_i$ and $B_j$ is a power of $x$ or $y$. Here and below the addition and multiplication of binary matrices is performed modulo two, unless stated otherwise. Thus, we also assume the $A_i$ are distinct and the $B_j$ are distinct to avoid cancellation of terms. For example, one could choose $A = x^3 + y + y^2$ and $B = y^3 + x + x^2$. Note that $A$ and $B$ have exactly three non-zero entries in each row and each column. Furthermore,$A B thin = thin B A$ since $x y thin = thin y x$. The above data defines a BB LDPC code denoted $sans("QC")(A,B)$ with length $n thin = thin 2 ell m$ and check matrices
$ H^X = mat(A, "|", B; delim: "[") quad "and" quad H^Z = mat(B^T, "|", A^T; delim: "[") $ <HXHZ>
Here the vertical bar indicates stacking matrices horizontally and $T$ stands for the matrix transposition. Both matrices $H^X$ and $H^Z$ have size $(n / 2) times n$. Each row $v in bb(F)_2^n$ of $H^X$ defines an $X$-type check operator $X ( v ) = product_(j = 1)^n X_j^(v_j)$. Each row $v in bb(F)_2^n$ of $H^Z$ defines a $Z$-type check operator $Z ( v ) = product_(j = 1)^n Z_j^(v_j)$. Any X-check and Z-check commute since they overlap on even number of qubits (note that $H^X (H^Z)^T = A B + B A = 0 med (mod med 2)$). To describe the code parameters we use certain linear subspaces associated with the check matrices, see Table 1 for our notations. Then the code $sans("QC")(A,B)$ has parameters $\[ \[ n , k , d \] \]$ with $ n = 2 ell m , quad k = 2 dot.op "dim" (sans("ker") \( A \) inter sans("ker") \( B \)) quad "and" quad d = min #scale(x: 120%, y: 120%)[(] \| v \| : thin thin v in sans("ker") \( H^X \) without sans("rs")(H^Z) #scale(x: 120%, y: 120%)[)] , $ see #ref(<lem:kd>). Here $\| v \| = sum_(i = 1)^n v_i$ is the Hamming weight of a vector $v in bb(F)_2^n$. We note that the code $sans("QC")(A,B)$ can be viewed as a special case of the Lifted Product construction~@panteleev2021quantum based on the abelian group $bb(Z)_ell times bb(Z)_m$. Here $bb(Z)_j$ denotes the cyclic group of order $j$.

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
    [$sans("rk") ( H )$], [rank], [$sans("rk") ( H ) = "dim" ( sans("rs") ( H ) ) = "dim" ( sans("cs") ( H ) )$],
  )]
  , caption: [Notations for linear spaces associated with a binary matrix $H$. Here the linear span, orthogonality, and dimension are computed over the binary field $bb(F)_2 = (0,1)$. If $H$ has size $s thin times thin n$ then $sans("rs")(H) subset.eq bb(F)_2^n$, $sans("cs")(H) subset.eq bb(F)_2^s$, and $sans("ker")(H) subset.eq bb(F)_2^n$. ]
  , kind: table
  )

]

#block[
#figure(
  align(center)[#table(
    columns: 5,
    align: (center, center, center, center, center),
    stroke: none,
    table.header([$[ [ n, k, d ] ]$], [Net encoding \ Rate $r$], [$ell, m$], [$A$], [$B$]),
    [$[ [ 72, 12, 6 ] ]$], [$1/12$], [$6, 6$], [$x^3 + y + y^2$], [$y^3 + x + x^2$],
    [$[ [ 90, 8, 10 ] ]$], [$1/23$], [$15, 3$], [$x^9 + y + y^2$], [$1 + x^2 + x^7$],
    [$[ [ 108, 8, 10 ] ]$], [$1/27$], [$9, 6$], [$x^3 + y + y^2$], [$y^3 + x + x^2$],
    [$[ [ 144, 12, 12 ] ]$], [$1/24$], [$12, 6$], [$x^3 + y + y^2$], [$y^3 + x + x^2$],
    [$[ [ 288, 12, 18 ] ]$], [$1/48$], [$12, 12$], [$x^3 + y^2 + y^7$], [$y^3 + x + x^2$],
    [$[ [ 360, 12, lt.eq 24 ] ]$], [$1/60$], [$30, 6$], [$x^9 + y + y^2$], [$y^3 + x^25 + x^26$],
    [$[ [ 756, 16, lt.eq 34 ] ]$], [$1/95$], [$21, 18$], [$x^3 + y^10 + y^17$], [$y^5 + x^3 + x^19$],
  )],
  caption: [Small examples of Bivariate Bicycle LDPC codes and their parameters. All codes have weight-6 checks, thickness-2 Tanner graph, and a depth-7 syndrome measurement circuit. Code distance was computed by the mixed integer programming approach of Ref.~@landahl2011fault. Notation $lt.eq d$ indicates that only an upper bound on the code distance is known at the time of this writing. We round $r$ down to the nearest inverse integer. The codes have check matrices $H^X = [A | B]$ and $H^Z = [B^T | A^T]$ with $A$ and $B$ defined in the last two columns. The matrices $x$, $y$ obey $x^ell = y^m = 1$ and $x y = y x$.],
  kind: table,
) <table:codes>
]

@table:codes describes the polynomials $A$ and $B$ that give rise to examples of high-rate, high-distance BB codes found by a numerical search. This includes all codes from @table:codes_intro and two examples of higher distance codes. To the best of our knowledge, all these examples are new. The code $[ [ 360, 12, lt.eq 24 ] ]$ improves upon a code $[ [ 882, 24, lt.eq 24 ] ]$ with weight-6 checks found by Panteleev and Kalachev in~@panteleev2021degenerate (assuming that our distance upper bound is tight). Indeed, taking two independent copies of the 360-qubit code gives parameters $[ [ 720, 24, lt.eq 24 ] ]$.

By construction, the code $sans("QC") ( A , B )$ has weight-6 check operators and each qubit participates in six checks (three $X$-type plus three $Z$-type checks).

Accordingly, the code $sans("QC") ( A , B )$ has a degree-$6$ Tanner graph. Below we show that the Tanner graph has thickness $theta lt.eq 2$, as desired, see @lem:thickness.

We note that the recent work by Wang, Lin, and Pryadko~@wang2023abelian @lin2023quantum described examples of group-based codes closely related to the codes considered here. Some of the group-based codes with weight-8 checks found in~@lin2023quantum outperform our BB codes with weight-6 checks in terms of the parameters $n , k , d$. It remains to be seen whether group-based codes can achieve a similar or better level of error suppression for the circuit-based noise model.

In the rest of this section we establish some properties of BB LDPC codes.

#lemma[The code $sans("QC") ( A , B )$ has parameters $[ [ n , k , d ] ]$, where $n = 2 ell m , quad k = 2 dot.op "dim" (sans("ker") ( A ) inter sans("ker") ( B )) , quad "and" quad d = min #scale(x: 120%, y: 120%)[(] | v | : thin thin v in sans("ker") ( H^X ) without sans("rs") ( H^Z ) #scale(x: 120%, y: 120%)[)] .$ The code offers equal distance for $X$-type and $Z$-type errors.] <lem:kd>
#block[
#emph[Proof.] It is known~@steane1996multiple @calderbank1996good that $ k = n - sans("rk") H^X - sans("rk") H^Z . $ We claim that $sans("rk") H^X = sans("rk") H^Z$. Indeed, define a self-inverse permutation matrix $C_ell$ of size $ell times ell$ such that the $i$-th column of $C_ell$ has a single nonzero entry equal to one at the row $j = -i med ("mod" ell)$. Define $C_m$ similarly and let $C = C_ell ⊗ C_m$. Since $C_ell S_ell C_ell = S_ell^T$ and $C_m S_m C_m = S_m^T$, one gets

$ A^T = C A C quad "and" quad B^T = C B C . $ <ABC2>

Therefore one can write

$ H^Z = [B^T | A^T] = [C B C | C A C] = C [A | B] mat(delim: "[", 0, C; C, 0) = C H^X mat(delim: "[", 0, C; C, 0) . $

Thus $H^Z$ is obtained from $H^X$ by multiplying on the left and on the right by invertible matrices. This implies $sans("rk") H^X = sans("rk") H^Z$. Therefore

$ k & = n - 2 dot.op sans("rk") H^Z = n - 2 (n/2 - dim(sans("ker") (H^Z)^T)) \
  & = n - 2 (n/2 - dim(sans("ker") A inter sans("ker") B)) \
  & = 2 dot.op "dim" (sans("ker") A inter sans("ker") B) . $

Here we noted that $H^Z$ has size $(n/2) times n$ and $sans("ker") (H^Z)^T = sans("ker") A inter sans("ker") B$ since $H^Z = [B^T | A^T]$.~◻

It is known~@steane1996multiple @calderbank1996good that a CSS code with check matrices $H^X$ and $H^Z$ has distance $d = min(d^X, d^Z)$, where $d^X$ and $d^Z$ are the code distances for $X$-type and $Z$-type errors defined as

$ d^X = min { |v| : thin v in sans("ker") H^Z without sans("rs") H^X } quad "and" quad d^Z = min { |v| : thin v in sans("ker") H^X without sans("rs") H^Z } . $

We claim that $d^Z lt.eq d^X$. Indeed, let $X(f) = product_(j=1)^n X_j^(f_j)$ be a minimum weight logical $X$-type Pauli operator such that $|f| = d^X$. Then $H^Z f = 0$ and $f in.not sans("rs") H^X$. Thus there exists a logical $Z$-type operator $Z(g) = product_(j=1)^n Z_j^(g_j)$ anti-commuting with $X(f)$. In other words, $H^X g = 0$ and $f^T g = 1$. Here, $f$ and $g$ are length-$n$ binary vectors. Write $f = (alpha, beta)$ and $g = (gamma, delta)$, where $alpha, beta, gamma, delta$ are length-$(n/2)$ vectors. Conditions $H^Z f = 0$ and $H^X g = 0$ are equivalent to

$ B^T alpha = A^T beta quad "and" quad A gamma = B delta . $ <alpha_beta_gamma_delta>

Here and below all arithmetics is modulo two. Define length-$n$ vectors

$ e = (C delta, C gamma) quad "and" quad h = (C beta, C alpha) . $

From @ABC2, @alpha_beta_gamma_delta one gets

$ H^X h = [A | B] mat(delim: "[", C beta; C alpha) = A C beta + B C alpha = C (A^T beta + B^T alpha) = 0 . $

Likewise,

$ H^Z e = [B^T | A^T] mat(delim: "[", C delta; C gamma) = B^T C delta + A^T C gamma = C (B delta + A gamma) = 0 . $

Furthermore,

$ h^T e = beta^T C C delta + alpha^T C C gamma = beta^T delta + alpha^T gamma = f^T g = 1 . $

Thus $X(e)$ and $Z(h)$ are non-identity logical operators. It follows that $d^Z lt.eq |h|$. We get

$ d^Z lt.eq |h| = |C beta| + |C alpha| = |beta| + |alpha| = |f| = d^X . $

Thus $d^Z lt.eq d^X$. Similar argument shows that $d^X lt.eq d^Z$, that is, $d^X = d^Z$.

]
We note that the equality $d^X = d^Z$ can also be established using the machinery of Ref.~@panteleev2021quantum by viewing $sans("QC") ( A , B )$ as a Lifted Product code.

In the following, we partition the set of data qubits as $[ n ] thin = thin L R$, where $L$ and $R$ are the left and right blocks of $n 2 = ell m$ data qubits. Then, data qubits $L$ and $R$ and checks $X$ and $Z$ may each be labeled by integers $bb(Z)_(ell m) = ( 0 , 1 , dots.h , ell m - 1 )$ which are indices into the matrices $A , B$. Alternatively, qubits and checks can be labeled by monomials from $cal(M) = ( 1 , y , dots.h , y^(m - 1) , x , x y , dots.h , x y^(m - 1) , dots.h , x^(ell - 1) y^(m - 1) )$ in this order, so that $i in bb(Z)_(ell m)$ labels the same qubit or check as $x^(a_i) y^(i - m a_i)$ for $a_i = "floor" ( i m )$. Using the monomial labeling, $L$ data qubit $alpha in cal(M)$ is part of $X$ checks $A_i^T alpha$ and $Z$ checks $B_i alpha$ for $i = 1 , 2 , 3$. Similarly, $R$ data qubit $beta in cal(M)$ is part of $X$ checks $B_i^T beta$ and $Z$ checks $A_i beta$. A unified notation assigns each qubit or check a label $q ( T , alpha )$ where $T in ( L , R , X , Z )$ denotes its type and $alpha in cal(M)$ its monomial label#footnote[The monomial notations should not be confused with the matrix notations used earlier in this section. For example, multiplication of monomials such as $B_i alpha$ is different from multiplying a vector $alpha$ by a matrix $B_i$.].

// [figvision] imgs/wheel_extraction.png
// Two extraction circuits sharing the same node/edge convention (blue L, orange R,
// pink X, teal Z nodes; solid horizontal edges, dotted vertical edges).
// (A) "Extraction of 'A' wheels in G_A": a 4x4 lattice of alternating check squares
//     (pink X, teal Z) and data circles (blue L, orange R) with horizontal edges labelled
//     B_3, B_2 and vertical edges A_3 (down) / A_2 (up), grey shaded columns. A curved
//     arrow points to the right-hand abstraction: a dotted circle around a square of
//     X/Z/R/L nodes connected by their A-type edges, i.e. one "wheel".
// (B) "Extraction of 'B' wheels in G_B": the transpose lattice with horizontal edges
//     B_1, B_2 / B_1 and vertical edges A_1, A_2, again with a shaded column; the
//     corresponding dotted-circle wheel abstraction appears at the right, now connecting
//     the same node types through B edges.
#figure(placement: top, image("imgs/wheel_extraction.png", width: 90.0%),
  caption: [
    A). B) Two different grids over a torus defined using different subsets of $A_1 , A_2 , A_3 , B_1 , B_2 , B_3$. Edge labels indicate adjacency matrices that generate the respective edges. By extracting either horizontal or vertical strips from these grids, we obtain planar 'wheel graphs' whose union contains all edges in the Tanner graph. The 'A' wheels (dashed lines) cover $A_2 , A_3 , B_3$ and the 'B' wheels (solid lines) cover $B_1 , B_2 , A_1$. To avoid clutter, each grid shows only a subset of edges present in the Tanner graph.
  ]
)
<fig:wheel_extraction>

// [figvision] imgs/navigation.png
// Two small labelled schematic panels.
// (A) "Compass" representation: a diamond of four stacked nodes - blue L (left),
//     pink X (top), orange R (right), teal Z (bottom) - with multiple parallel black
//     edges; edge labels A at upper-left/lower-right and B at upper-right/lower-left.
// (B) "Unit Cell for Lemma 4": a 3x3 node grid, columns L-Z-L and X-R-X, with X squares
//     at the corners, R circles in the top/bottom middle, L circles mid-left/mid-right
//     and a Z square at the centre. Horizontal edges labelled B_g (left-to-right) and
//     B_h (right-to-left), vertical edges labelled A_i (down) and A_j (up); dotted
//     continuations at the borders indicate periodic repetition.
#figure(image("imgs/navigation.png", width: 60.0%),
  caption: [
    A) "Compass" diagram that shows the direction in which matrices $A , B$ are applied to travel between different nodes. B) The unit cell of the construction of a toric layout in the proof of @lem:toric_layout.
  ]
)
<fig:navigation>

#lemma[The Tanner graph $G$ of the code $sans("QC") ( A , B )$ has thickness $theta thin lt.eq thin 2$. A decomposition of $G$ into two planar layers can be computed in time $O ( n )$. Each planar layer of $G$ is a degree-3 graph.] <lem:thickness>
#block[
#emph[Proof.] Let $G = (V, E)$ be the Tanner graph. Partition $G$ into subgraphs $G_A = (V, E_A)$ and $G_B = (V, E_B)$ that describe CSS codes with check matrices

$ "Tanner graph " G_A ":" quad H_A^X = [A_2 + A_3 | B_3] quad "and" quad H_A^Z = [B_3^T | A_2^T + A_3^T] $

$ "Tanner graph " G_B ":" quad H_B^X = [A_1 | B_1 + B_2] quad "and" quad H_B^Z = [B_1^T + B_2^T | A_1^T] . $

Since $A = A_1 + A_2 + A_3$ and $B = B_1 + B_2 + B_3$, every edge of $G$ appears either in $G_A$ or $G_B$, where the two subgraphs are named by whether they contain more $A_i$ edges or more $B_i$ edges. Then $G_A$ and $G_B$ are regular degree-3 graphs (since $A_i$ and $B_j$ are permutation matrices).~◻

]

Consider the graph $G_A$. Each $X$-check vertex is connected to a pair of data vertices $i_1 , i_2 in L$ via the matrices $A_2 , A_3$ and a data vertex $i_3 in R$ via the matrix $B_3$. Each $Z$-check vertex is connected to a pair of data vertices $i_1 , i_2 in R$ via the matrices $A_2^T , A_3^T$ and a data vertex $i_3 in L$ via the matrix $B_3^T$.

We claim that each connected component of $G_A$ can be represented by a “wheel graph” illustrated in @fig:wheel_extraction. A wheel graph consists of two disjoint cycles of the same length $p$ interconnected by $p$ radial edges. The outer cycle alternates between $X$-check and $L$-data vertices.

Edges of the outer cycle alternate between those generated by $A_3$ (as one moves from a check to a data vertex) and $A_2^T$ (as one moves from a data to a check vertex). The length of the outer cycle is equal to the order of the matrix $A_3 A_2^T$, that is, the smallest integer $p$ such that $( A_3 A_2^T )^p = I_(ell m)$. For example, consider the code $[ [ 144 , 12 , 12 ] ]$ from @table:codes. Then $A = x^3 + y + y^2$, $A_2 = y$, and $A_3 = y^2$. Thus $A_3 A_2^T = y^2 y^(- 1) = y$ which has order $m = 6$. The inner cycle of a wheel graph alternates between $Z$-check and $R$-data vertices.

Edges of the inner cycle alternate between those generated by $A_3^T$ (as one moves from a check to a data vertex) and $A_2$ (as one moves from a data to a check vertex). The length of the inner cycle is equal to the order of the matrix $A_3^T A_2$ which is just the transpose of $A_3 A_3^T$ considered earlier. Thus both inner and outer cycles have the same length $m$. The two cycles are interconnected by $m$ radial edges as shown in A).

Radial edges are generated by the matrix $B_3$, as one moves towards the center of the wheel. The wheel graph contains $4$-cycles generated by tuples of edges $( B_3 , A_2 , B_3^T , A_2^T )$ and $( B_3^T , A_3 , B_3 , A_3^T )$. Commutativity between $A_i$ and $B_j$

ensures that traversing any of these $4$-cycles implements the identity matrix, that is, the graph is well defined.

Clearly, the wheel graph is planar. Since $G_A$ is a disjoint union of wheel graphs, $G_A$ is planar. The same argument shows that $G_B$ is planar: see @fig:wheel_extraction~B).

We empirically observed that BB codes reported in @table:codes have no weight-$4$ stabilizers. The presence of such stabilizers is known to have a negative impact on the performance of belief propagation decoders~@panteleev2021degenerate, which we use here.

The definition of code $sans("QC") ( A , B )$ does not guarantee that its Tanner graph is connected. Some choices of $A$ and $B$ lead to a code that is actually several separable code blocks. This manifests as a Tanner graph with several connected components. For instance, although all codes in @table:codes are connected, taking any of them with even $ell$ and replacing every instance of $x$ with $x^2$ creates a code with two connected components.

#lemma[The Tanner graph of the code $sans("QC") ( A , B )$ is connected if and only if $S = { A_i A_j^T : i , j in ( 1 , 2 , 3 ) } union { B_i B_j^T : i , j in ( 1 , 2 , 3 ) }$ generates the group $cal(M)$. The number of connected components in the Tanner graph is $ell m / | chevron.l S chevron.r |$, and all components are graph isomorphic to one another.] <lem:connected>
#block[
#emph[Proof.] @fig:navigation is helpful for following the arguments in this proof. We start by proving the reverse implication of the first statement. Note that there is a length 2 path in the Tanner graph from $L$ qubit $alpha in cal(M)$ to $L$ qubit $A_i A_j^T alpha$ and another length 2 path to $L$ qubit $B_i B_j^T alpha$. These travel through $X$ and $Z$ checks, respectively. Thus, because the $A_i A_j^T$ and $B_i B_j^T$ generate $cal(M)$, there is some path from $alpha$ to any other $L$ qubit $beta$. A similar argument shows the existence of a path connecting any pair of R qubits. Since each $X$ check and each $Z$ check are connected to at least one $L$ qubit and at least one $R$ qubit, this implies that the entire Tanner graph is connected. The forward implication of the first statement follows after noticing that, for all $T in ( L , R , X , Z )$, the path from a type $T$ node to any other $T$ node is necessarily described as a product of elements from $S$. Connectivity of the Tanner graph implies the existence of all such paths, and so $S$ must generate $cal(M)$.

If $S$ does not generate $cal(M)$, it necessarily generates a subgroup $chevron.l S chevron.r$ and nodes in connected components of the Tanner graph are labeled by elements of the cosets of this subgroup. This implies the theorem's second statement.

]

For the next part, we establish some terminology. A spanning sub-graph of a graph $G$ is a sub-graph containing all the vertices of $G$. Also, the undirected Cayley graph of a finite Abelian group $cal(G)$ (with identity element $0$) generated by set $S subset cal(G)$ is the graph with vertex set $cal(G)$ and undirected edges $( g , g + s )$ for all $g in cal(G)$ and all $s in S , s eq.not 0$. We say the Cayley graph of $bb(Z)_a times bb(Z)_b$ when we mean the Cayley graph of $bb(Z)_a times bb(Z)_b$ generated by $( ( 1 , 0 ) , ( 0 , 1 ) )$. The order $"ord" ( g )$ of an element $g$ in a multiplicative group is the smallest positive integer such that $g^("ord" ( g )) = 1$.

#dfn[Code $sans("QC") ( A , B )$ is said to have a toric layout if its Tanner graph has a spanning sub-graph isomorphic to the Cayley graph of $bb(Z)_(2 mu) times bb(Z)_(2 lambda)$ for some integers $mu$ and $lambda$.] <dfn:toric_layout>

Note that only codes with connected Tanner graphs can have a toric layout according to this definition. An example toric layout is depicted in @fig:2Dlayout~B).

#lemma[A code $sans("QC") ( A , B )$ has a toric layout if there exist $i , j , g , h in ( 1 , 2 , 3 )$ such that

+ $chevron.l A_i A_j^T , B_g B_h^T chevron.r = cal(M)$ and

+ $"ord" ( A_i A_j^T ) "ord" ( B_g B_h^T ) = ell m$.] <lem:toric_layout>
#block[
#emph[Proof.] We let $mu = "ord" ( A_i A_j^T )$ and $lambda = "ord" ( B_g B_h^T )$. We associate qubits and checks in the Tanner graph of $sans("QC") ( A , B )$ with elements of $cal(G) = bb(Z)_(2 mu) times bb(Z)_(2 lambda)$. For $L$ qubit with label $alpha in cal(M)$, because of (i), there is $( a , b ) in bb(Z)_mu times bb(Z)_lambda$ such that $alpha = ( A_i A_j^T )^a ( B_g B_h^T )^b$. Because of (ii) and the pigeonhole principle, this choice of $( a , b )$ is unique. We associate $L$ qubit $alpha$ with $( 2 a , 2 b ) in cal(G)$. Similarly, an $R$ qubit with label $alpha A_j^T B_g$ is associated with $( 2 a + 1 , 2 b + 1 ) in cal(G)$, $X$-check $alpha A_j^T$ with $( 2 a + 1 , 2 b )$, and $Z$-check $alpha B_g$ with $( 2 a , 2 b + 1 )$. Edges in the Tanner graph $A_i , A_j^T , B_g , $ and $B_h^T$ can now be drawn as in @fig:navigation (B) and correspond to edges in the Cayley graph of $cal(G)$. For instance, to get from $( 2 a + 1 , 2 b + 1 )$, an $R$ qubit, to $( 2 a + 2 , 2 b + 1 )$, a $Z$ check, we apply $A_i$, taking $R$ qubit labeled $alpha A_j^T B_g$ to the $Z$ check labeled $( alpha A_j^T B_g ) A_i = alpha ( A_i A_j^T ) B_g$.~◻

]

All codes in @table:codes have a toric layout with $mu = m$ and $lambda = ell$. Most of these codes satisfy @lem:toric_layout with $i = g = 2$ and $j = h = 3$. The exception is the $[ [ 90 , 8 , 10 ] ]$ code, for which we can take $i = 2 , g = 1$ and $j = h = 3$.

However, we also note two interesting cases. First, there are codes with connected Tanner graphs that do not satisfy the conditions for a toric layout given in @lem:toric_layout. One example of such a code is $sans("QC") ( A , B )$ with $ell , m = 28 , 14$, $A = x^(26) + y^6 + y^8$, and $B = y^7 + x^9 + x^(20)$ which has parameters $[ [ 784 , 24 , lt.eq 24 ] ]$. Second, for a code satisfying the conditions of @lem:toric_layout, it need not be the case that the set $( "ord" ( A_i A_j^T ) , "ord" ( B_g B_h^T ) )$ and the set $( ell , m )$ are equal. For example, the $[ [ 432 , 4 , lt.eq 22 ] ]$ code with $ell , m = 18 , 12$ and $A = x + y^(11) + y^3$, $B = y^2 + x^(15) + x$ only satisfies @lem:toric_layout with $mu , lambda = 36 , 6$ (take $i = g = 1$ and $j = h = 2$ for instance).

= Syndrome measurement circuit
<sec:syndrome_circuit>

The next step is to furnish the code $sans("QC") ( A , B )$ with a syndrome measurement (SM) circuit that repeatedly measures the syndrome of each check operator. Here we describe a SM circuit that requires $2 n$ physical qubits in total: $n$ data qubits and $n$ ancillary check qubits used to record the measured syndromes. The circuit only applies $sans("CNOT")$s to pairs of qubits that are connected in the Tanner graph.

The SM circuit is defined as a periodically repeated sequence of #emph[syndrome cycles] (SC). A single SC is responsible for measuring syndromes of all $n$ check operators of the code. Let $N_c$ be the number of syndrome cycles. We envision that $N_c thin > thin 1$. The circuit begins and ends with a special initialization and measurement cycle responsible for initializing logical qubits in a suitable initial state and measuring logical qubits in a suitable basis. Here we focus on the optimization of the SC circuit. Logical initialization and measurements are discussed in @sec:logicals.

The SC circuit is divided into $N_r$ #emph[rounds] such that each round is a depth-1 circuit composed of $sans("CNOT")$s and single-qubit operations. The latter include initializing a qubit in the $X$ or $Z$ basis and measuring a qubit in the $X$ or $Z$ basis. $sans("CNOT")$s can be applied only to pairs of qubits which are nearest neighbors in the Tanner graph. Some qubits remain idle during some rounds, although we try to minimize such occurrences by squeezing more useful computations in as little time as possible. Our notations are summarized in @table:tab3.

#figure(
  align(center)[#table(
    stroke: none,
    columns: 2,
    align: (center,center,),
    table.vline(x: 1, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header([Notation], [Operation],),
    table.hline(),
    [$sans("CNOT") quad c quad t$], [$sans("CNOT")$ with control qubit $c$ and target qubit $t$],
    [$sans("InitX") quad q$], [Initialize qubit $q$ in the state $| + chevron.r = ( | 0 chevron.r + | 1 chevron.r ) sqrt(2)$],
    [$sans("InitZ") quad q$], [Initialize qubit $q$ in the state $| 0 chevron.r$],
    [$sans("MeasX") quad q$], [Measure qubit $q$ in the $X$-basis $| + chevron.r , | - chevron.r$],
    [$sans("MeasZ") quad q$], [Measure qubit $q$ in the $Z$-basis $| 0 chevron.r , | 1 chevron.r$],
    [$sans("Idle") quad q$], [Identity gate on qubit $q$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Elementary operations used for syndrome measurements.]
  , kind: table
  )

 <table:tab3>

#figure(
  align(center)[#table(
    columns: 4,
    align: (center,left,center,left,),
    table.header([Round], [Circuit], [Round], [Circuit],),
    table.hline(),
    [1], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("InitX") quad q (X, i)$ \
      $sans("CNOT") quad q (R, A_1^T (i)) quad q (Z, i)$ \
      $ sans("Idle") quad q (L, i) $
    ]], [5], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("CNOT") quad q (X, i) quad q (R, B_3 (i))$ \
      $ sans("CNOT") quad q (L, B_3^T (i)) quad q (Z, i) $
    ]],
    [2], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("CNOT") quad q (X, i) quad q (L, A_2 (i))$ \
      $ sans("CNOT") quad q (R, A_3^T (i)) quad q (Z, i) $
    ]], [6], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("CNOT") quad q (X, i) quad q (L, A_1 (i))$ \
      $ sans("CNOT") quad q (R, A_2^T (i)) quad q (Z, i) $
    ]],
    [3], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("CNOT") quad q (X, i) quad q (R, B_2 (i))$ \
      $ sans("CNOT") quad q (L, B_1^T (i)) quad q (Z, i) $
    ]], [7], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("CNOT") quad q (X, i) quad q (L, A_3 (i))$ \
      $sans("MeasZ") quad q (Z, i)$ \
      $ sans("Idle") quad q (R, i) $
    ]],
    [4], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("CNOT") quad q (X, i) quad q (R, B_1 (i))$ \
      $ sans("CNOT") quad q (L, B_2^T (i)) quad q (Z, i) $
    ]], [8], [#block[
      For $i = 1$ to $n\/2$: \
      $sans("MeasX") quad q (X, i)$ \
      $sans("InitZ") quad q (Z, i)$ \
      $sans("Idle") quad q (L, i)$ \
      $ sans("Idle") quad q (R, i) $
    ]],
  )]
  , caption: [Depth-8 syndrome measurement cycle circuit.]
  , kind: table
  )
<table:syndromecircuit>

Below we describe a SC circuit with effectively $N_r thin = thin 8$ rounds#footnote[The operator $sans("InitZ") quad q ( Z , i )$ must be executed before the first application of this SC circuit, raising the depth of the first stage to 9. However, each following syndrome cycle takes Z-check initialization from the previous round. Last syndrome cycle needs not apply the Z-check state initialization. Total SM circuit depth with $N_c$ syndrome cycles is thus $8 N_c thin + thin 1$.]. Ignoring single-qubit initialization and measurement operations, the SC circuit is a depth-7 $sans("CNOT")$ circuit. By designing the circuit for an explicit family of LDPC codes we are able to leverage the symmetries and reduce computational depth to $7$ from what otherwise would be $14 thin = thin 2 dot.op 6 thin + thin 2$, as shown by previous authors @tremblay2022constant[Theorem 1]. Our notations are as follows. We divide $n$ data qubits into the left and the right registers $q ( L )$ and $q ( R )$ of size $n 2$ each. Each check operator acts on three data qubits from $q ( L )$ and three data qubits from $q ( R )$. The SM circuit uses $2 n$ physical qubits in total: $n$ data qubits and $n$ ancillary check qubits that record the syndrome of each check operator. Let $q ( X )$ and $q ( Z )$ be the ancillary registers of size $n 2$ that span $X$-check and $Z$-check qubits respectively. Thus the physical qubits are partitioned into four registers, $q ( X )$, $q ( L )$, $q ( R )$, and $q ( Z )$, of size $n 2$ each. Label qubits in each register by integers $i = 1 , 2 , dots.h , n 2$. We write $q ( X , i )$ for the $i$-th qubit of the register $q ( X )$ with similar notations for $q ( L )$, $q ( R )$, and $q ( Z )$. Each permutation matrix $A_p$ and $B_q$ from @AB defines a one-to-one map from the set $( 1 , 2 , dots.h , n 2 )$ onto itself.

We identify a permutation matrix and the corresponding one-to-one map. For example, we write $j thin = thin A_1 ( i )$ if the matrix $A_1$ has a one at row $i$ and column $j$ (this is well defined since $A_1$ is a permutation matrix). Likewise, we write $j thin = thin A_1^T ( i )$ if the transposed matrix $A_1^T$ has a one at the row $i$ and column $j$. In this notation, the $i$-th $X$-check operator acts on data qubits $q ( L , A_p ( i ) )$ and $q ( R , B_p ( i ) )$ with $p = 1 , 2 , 3$. The $i$-th $Z$-check operator acts on data qubits $q ( L , B_p^T ( i ) )$ and $q ( R , A_p^T ( i ) )$ with $p = 1 , 2 , 3$.

// [figvision] imgs/syndromecircuit.png
// Syndrome-extraction circuit drawn as horizontal qubit wires crossed by eight vertical
// "Round" lines (labels 1-8) in blue.
// Rows from top: six X-check ancillas initialized in |+> (pink X squares in the legend
// "checks"), then two data wires (blue L and orange R circles), then six Z-check
// ancillas initialized in |0> (teal Z squares). Filled black dots are CNOT controls,
// large open circles with a cross are targets. The pattern is a diagonal staircase:
// in round r the r-th X ancilla couples down to the L data wire, and in round r+6 the
// r-th Z ancilla couples up to the R data wire; the two data qubits are crossed by the
// ancilla chains in a "V" pattern (the thick black outline follows the light-cone).
// Two measurement boxes at the right (X for the X ancillas, Z for the Z ancillas), then
// a slanted block labelled "Next cycle".
#figure(image("imgs/syndromecircuit.png", height: 8cm),
  caption: [
    Depth-8 syndrome measurement cycle circuit.
  ]
)
<fig:syndromecircuit>

Our depth-8 SC circuit is described in and illustrated in @fig:syndromecircuit . Note that within each round all operations act over non-overlapping sets of qubits. In particular, each round applies at most one layer of $sans("CNOT")$ gates between $q ( X )$ and $q ( L )$ registers (Rounds 2, 6, and 7), at most one layer of $sans("CNOT")$s between $q ( X )$ and $q ( R )$ registers (Rounds 3, 4, and 5), at most one layer of $sans("CNOT")$s between $q ( Z )$ and $q ( L )$ registers (Rounds 3, 4, and 5), and at most one layer of $sans("CNOT")$s between $q ( Z )$ and $q ( R )$ registers (Rounds 1, 2, and 6). Qubits from $q ( Z )$ are always targets for $sans("CNOT")$s. Accordingly, $X$-type errors propagate from data qubits to check qubits in $q ( Z )$. The latter are measured in the $Z$-basis in Round 7 revealing the syndrome of $X$-type errors. Qubits from $q ( X )$ are always controls for $sans("CNOT")$s. Accordingly, $Z$-type errors propagate from data qubits to check qubits in $q ( X )$. The latter are measured in the $X$-basis in Round~8 revealing the syndrome of $Z$-type errors. We envision that the syndrome cycles are repeated periodically. This justifies applying $sans("CNOT")$s to $q ( Z )$ at Round~1 even though $q ( Z )$ is initialized only at Round~8. Indeed, Round~8 of the previous syndrome cycle goes immediately before Round~1 of the current cycle. Thus $q ( Z )$ has been already initialized at the beginning of Round~1. We were not able to find a depth-8 (or smaller depth) syndrome cycle in which $X$-check and $Z$-check qubits are initialized and measured synchronously.

Let us now prove that the above SC circuit has the desired functionality. Since the circuit involves only Clifford operations, its action can be compactly described using stabilizer tableau@aaronson2004improved. We track how the tableau changes as each layer of $sans("CNOT")$s in the circuit is applied. Since the $sans("CNOT")$ gates do not mix Pauli $X$ and $Z$ operators, one may consider tableau describing the action of the circuit on $X$-type and $Z$-type Pauli operators separately.

Let us begin with $X$-type Pauli. The corresponding tableau $T$ is a binary matrix of size $n thin times thin 2 n$ such that each row of $T$ defines an $X$-type stabilizer of the underlying quantum state. We partition columns of $T$ into four blocks that represent qubit registers $q ( X )$, $q ( L )$, $q ( R )$, and $q ( Z )$. We partition rows of $T$ into two blocks such that initially the top $n 2$ rows represent weight-$1$ check operators on qubits of the register $q ( X )$ initialized in the state $| + chevron.r$ while the bottom $n 2$ rows represent weight-$6$ check operators on data qubits associated with the chosen code $sans("QC") ( A , B )$. Thus, at the beginning of Round~1, when all check qubits in the register $q ( X )$ have been initialized in the state $| + chevron.r$, while data qubits are in some logical state of the code $sans("QC") ( A , B )$, the binary matrix is $mat(delim: "(", I, 0, 0, 0; 0, A, B, 0) .$ Here $I thin equiv thin I_(n 2)$ is the identity matrix. The SC circuit (ignoring qubit initialization and measurements) enacts the transformation $mat(delim: "(", I, 0, 0, 0; 0, A, B, 0) arrow.r^"SC circuit" mat(delim: "(", I, A, B, 0; 0, A, B, 0) .$ Indeed, the circuit must map a single-qubit $X$ stabilizer $X_j$ on a check qubit $j thin in thin q ( X )$ to a product of $X_j$ and the $j$-th $X$-type check operator on the data qubits determined by the $j$-th row of $H^X = [ A | B ]$. The eigenvalue measurement of $X_j$ at the final round then reveals the syndrome of the $j$-th check operator. The bottom $n 2$ rows must be unchanged since the check operators of the code must be the same before and after the syndrome measurement.

Let us verify that the circuit defined in @table:syndromecircuit enacts the desired transformation. To accomplish this, we rewrite the SC circuit by removing notations irrelevant to showing the correctness of $X$-checks. Specifically, we write each $sans("CNOT")$ in @table:syndromecircuit as $sans("CNOT")_M(a,b)$, where $a , b thin in thin ( 1 , 2 , 3 , 4 ) = ( q ( X ) , q ( L ) , q ( R ) , q ( Z ) )$, and $M thin in thin ( A_1 , A_2 , A_3 , B_1 , B_2 , B_3 )$. Note that the $sans("CNOT")$ instructions where the matrix $M^T$ is used instead of $M$ can be written using matrix $M$ by performing the variable renaming $i thin arrow.l thin M ( i )$ in the corresponding for loop in @table:syndromecircuit.

Using the above compact notation, the unitary part of the SC circuit becomes:

$
  "Round 1:" & sans("CNOT")_(A_1)(3,4) \
  "Round 2:" & sans("CNOT")_(A_2)(1,2), sans("CNOT")_(A_3)(3,4) \
  "Round 3:" & sans("CNOT")_(B_2)(1,3), sans("CNOT")_(B_1)(2,4) \
  "Round 4:" & sans("CNOT")_(B_1)(1,3), sans("CNOT")_(B_2)(2,4) \
  "Round 5:" & sans("CNOT")_(B_3)(1,3), sans("CNOT")_(B_3)(2,4) \
  "Round 6:" & sans("CNOT")_(A_1)(1,2), sans("CNOT")_(A_2)(3,4) \
  "Round 7:" & sans("CNOT")_(A_3)(1,2)
$ <SCunitary_part>

In the following we apply all seven unitary rounds to verify the correctness of the performed transformation:

$
  "Round 1:" quad mat(delim: "(", I, 0, 0, 0; 0, A, B, 0)
    arrow.r^(sans("CNOT")_(A_1)(3,4))
    mat(delim: "(", I, 0, 0, 0; 0, A, B, A_1 B)
$

$
  "Round 2:" quad arrow.r^(sans("CNOT")_(A_2)(1,2))
    mat(delim: "(", I, A_2, 0, 0; 0, A, B, A_1 B)
    arrow.r^(sans("CNOT")_(A_3)(3,4))
    mat(delim: "(", I, A_2, 0, 0; 0, A, B, (A_1 + A_3) B)
$

$
  "Round 3:" quad arrow.r^(sans("CNOT")_(B_2)(1,3))
    mat(delim: "(", I, A_2, B_2, 0; 0, A, B, (A_1 + A_3) B)
    arrow.r^(sans("CNOT")_(B_1)(2,4))
    mat(delim: "(", I, A_2, B_2, A_2 B_1; 0, A, B, (A_1 + A_3) B + A B_1)
$

$
  "Round 4:" quad arrow.r^(sans("CNOT")_(B_1)(1,3))
    mat(delim: "(", I, A_2, B_1 + B_2, A_2 B_1; 0, A, B, (A_1 + A_3) B + A B_1) \
  arrow.r^(sans("CNOT")_(B_2)(2,4))
    mat(delim: "(", I, A_2, B_1 + B_2, A_2 (B_1 + B_2); 0, A, B, (A_1 + A_3) B + A (B_1 + B_2))
    = mat(delim: "(", I, A_2, B_1 + B_2, A_2 (B_1 + B_2); 0, A, B, A_2 B + A B_3)
$

Here, we use the identity $(A_1 + A_3) B + A (B_1 + B_2) = A_2 B + A B_3$, which holds since the sum of first summands and second summands on both sides of the equation gives $A B$, and $A B + A B = 0$.

$
  "Round 5:" quad arrow.r^(sans("CNOT")_(B_3)(1,3))
    mat(delim: "(", I, A_2, B, A_2 (B_1 + B_2); 0, A, B, A_2 B + A B_3)
    arrow.r^(sans("CNOT")_(B_3)(2,4))
    mat(delim: "(", I, A_2, B, A_2 B; 0, A, B, A_2 B)
$

$
  "Round 6:" quad arrow.r^(sans("CNOT")_(A_1)(1,2))
    mat(delim: "(", I, A_1 + A_2, B, A_2 B; 0, A, B, A_2 B)
    arrow.r^(sans("CNOT")_(A_2)(3,4))
    mat(delim: "(", I, A_1 + A_2, B, 0; 0, A, B, 0)
$

$
  "Round 7:" quad arrow.r^(sans("CNOT")_(A_3)(1,2))
    mat(delim: "(", I, A, B, 0; 0, A, B, 0) .
$

This is the desired transformation.

So far, we have not considered the action of the SC circuit on the logical qubits of the code. Let us show that this action is trivial. Indeed, consider some $X$-type logical operator $X ( v )$, where $v in bb(F)_2^n$. Write $v thin = thin ( u , w )$ where $u$ and $w$ are restrictions of $v$ onto the registers 2 and 3 respectively. Commutativity between $X ( v )$ and any $Z$-type check operator implies $u B + w A = 0 .$ Here we consider $u$ and $w$ as row vectors. Extending $v$ by zeroes on registers 1 and 4 gives the row vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$, where $0$ stands for the all-zero row vector of length $n 2$. Let us follow the same chain of transformations as above starting from the initial vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$. All $sans("CNOT")$s controlled by the register 1, such as $sans("CNOT")_(A_2)(1,2)$ or $sans("CNOT")_(B_2)(1,3)$ in @SCunitary_part, have trivial action on the vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$ since all qubits of the control register are zeroes. Such $sans("CNOT")$s can be omitted. The remaining $sans("CNOT")$s in @SCunitary_part such as $sans("CNOT")_(A_1)(3,4)$ or $sans("CNOT")_(B_1)(2,4)$ map the initial vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$ to $( 0 #h(0em) u #h(0em) w #h(0em) t )$ for some vector $t$ since the registers 2 and 3 always serve as the controls and the register 4 always serves as the target. Rounds~1, 2, and 6 in @SCunitary_part are equivalent to XORing vectors $w A_1$, $w A_3$, and $w A_2$ respectively to the register 4. Rounds~3, 4, and 5 in @SCunitary_part are equivalent to XORing vectors $u B_1$, $u B_2$, and $u B_3$ respectively to the register 4. Thus $t = w ( A_1 + A_2 + A_3 ) + u ( B_1 + B_2 + B_3 ) = w A + u B = 0 .$ We have shown that the SC circuit maps the vector $( 0 #h(0em) u #h(0em) w #h(0em) 0 )$ to itself. Hence the circuit acts trivially on logical $X$-type operators.

To prove the correctness of $Z$-checks, observe that $Z$-checks can be mapped into $X$-checks by conjugation with Hadamards. When the unitary circuit in is conjugated with Hadamards, this flips controls and targets of all $sans("CNOT")$ gates. Thus, to verify $Z$-checks, it suffices to perform a very similar calculation to the one already shown for $X$-checks. We omit this calculation here.

The SC circuit shown in is not unique in the following sense: we found 935 depth-7 alternatives to the unitary part of the SC circuit via a computer search.

These alternatives are obtained from the circuit defined in @SCunitary_part by applying the gate layers $sans("CNOT")_(A_i)$ and $sans("CNOT")_(B_j)$ in a different order. In the special case of the $[ [ 144 , 12 , 12 ] ]$ code, numerical simulations show that all 936 variants of the syndrome cycle give rise to syndrome measurement circuits with distance $d_sans("circ") lt.eq 10$ explaining our focus on a specific circuit @SCunitary_part which we conjecture to have distance $d_sans("circ") {=} 10$. The short depth of the single cycle, relying on only seven computational stages, helps to keep the spread of errors under control. Details of calculating upper bounds on the circuit-level distance are provided in @sec:decoder.

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

$ mat(delim: "[", s^U; s^F) = sum_(j = 1)^M xi_j mat(delim: "[", s_j^U; s_j^F) quad ("mod" 2) $

is a binary vector that represents the error syndrome. The linearized model is a simplified version of the circuit-based noise that ignores possible cancellations among errors generated by two or more faulty operations in $cal(U)$. Note that such errors occur with the probability only $O(p^2)$. The decoder attempts to guess the final error $E$ acting on the data qubits based on the syndrome $s^U$ measured in the experiment making a simplifying assumption that that the pair $(s^U, E)$ was generated using the linearized noise model. We additionally assume that the decoder knows the syndrome $s^F$ of the final error $E$. This syndrome can be acquired by adding one noiseless cycle at the end of the syndrome measurement circuit, which is a common practice in numerical simulations of error correction. By definition, we have

$ D xi = mat(delim: "[", s^U; s^F) . $

Here $xi = (xi_1, xi_2, dots, xi_M)$ is a column vector and matrix-vector multiplication is modulo two. Define a minimum weight error $xi^* = xi^*(s) in {0, 1}^M$ as a solution of an optimization problem

$ xi^* = "arg" min_(xi in {0, 1}^M) sum_(j = 1)^M log(1/p_j) xi_j quad "subject to" quad D xi = mat(delim: "[", s^U; s^F) . $ <MWD>

This problem is equivalent to the minimum weight decoding for a length-$M$ linear code with the check matrix $D$, bit-flip error probabilities $p_1, p_2, dots, p_M$, and noiseless syndromes. Our guess of the unknown logical syndrome is

$ s^L = D^L xi^* . $

Let $E^*$ be any $n$-qubit Pauli operator with the syndrome $s^F$ and the logical syndrome $s^L$. Note that $E^*$ is defined uniquely modulo multiplication by check operators. The Pauli $E^*$ is our guess of the final error on the data qubits. Let $E$ be the actual final error on the data qubits generated by a noisy realization of $cal(U)$ without making any simplifications of the noise model. By definition, Pauli operators $E$ and $E^*$ have the same syndrome but they may differ by a logical Pauli operator. We declare a logical error if $E$ and $E^*$ differ by any non-identity logical operator (there are $4^k - 1$ choices of this logical operator). Otherwise the decoding is deemed successful.

It remains to explain how to solve the optimization problem @MWD. Since the minimum weight decoding for a linear code is known to be NP-hard problem~@berlekamp1978inherent, finding the exact solution of @MWD might be practically impossible for problem instances with several thousand variables that we have to deal with. Furthermore, estimation of the logical error probability $p_L$ by the Monte Carlo method requires solving $O(1/p_L)$ instances of the problem @MWD. This number can be quite large since $p_L$ is a small parameter. To address these challenges, we employ the BP-OSD algorithm~@panteleev2021degenerate @roffe2020decoding. Recall that belief propagation (BP) is a heuristic message passing algorithm aimed at computing single-bit marginals of a probability distribution

$ P(xi | sigma) = cases(
  frac(1, cal(Z)) product_(j = 1)^M (1 - p_j)^(1 - xi_j) p_j^(xi_j) & "if" quad D xi = sigma,
  0 & "otherwise" ,
) $

Here $xi in {0, 1}^M$ and $cal(Z)$ is a normalization factor chosen such that $sum_(xi in {0, 1}^M) P(xi | sigma) = 1$. In our case $xi$ represents an unknown error in the linearized noise model, $D$ is the decoding matrix constructed above, and $sigma = mat(delim: "[", s^U; s^F)$ is the measured error syndrome. Let $q_j in [0, 1]$ be an estimate of the marginal probability $"Pr"[xi_j = 1]$ obtained by the belief propagation method with some fixed number of message passing iterations. The ordered statistics post-processing step examines #emph[information sets] which are subsets of bits $I subset.eq [M]$ such that the linear system $D xi = sigma$ has a unique solution $xi$ supported on $I$, that is, $xi_j = 0$ for all $j in.not I$. Information sets are ranked according to their #emph[reliability] which is defined as

$ rho(I) = product_(j in I) max(q_j, 1 - q_j) . $

BP-OSD finds an information set $I$ with the largest reliability using a greedy algorithm~@panteleev2021degenerate. The final output of BP-OSD is a solution of the system $D xi = sigma$ supported on the most reliable information set $I$. We replace the minimum weight error $xi^*$ in @MWD by the solution $xi$ proposed by BP-OSD.

Since BB LDPC codes are of CSS-type, it is natural to decode $X$-type and $Z$-type errors independently. Accordingly, we solve the minimum weight decoding problem @MWD twice with a pair of decoding matrices $D_X$ and $D_Z$ constructed as above but including only the syndromes of $X$-type and $Z$-type check operators respectively. This results in guessed $X$-type and $Z$-type errors $E_X^*$ and $E_Z^*$. The guessed final error is $E^* = E_X^* E_Z^*$. We empirically observed that the resulting decoding matrices $D_X$ and $D_Z$ are $(6, 35)$-sparse for any BB code, meaning that there are at most $6$ nonzeros in each column and at most $35$ nonzeros in each row of $D_X$ and $D_Z$. The number of columns scales as $O(n N_c)$ where the constant coefficient depends on a particular code. For example, decoding matrices $D_X$ and $D_Z$ describing the code $[ [ 144, 12, 12 ] ]$ with $N_c = 12$ syndrome cycles have $8857$ and $8785$ columns respectively.

We also employed BP-OSD to compute an upper bound on the code distance $d$. Consider a CSS-type LDPC code $[ [ n, k, d ] ]$ with check matrices $H^X$ and $H^Z$. Assume for simplicity that this code has the same distance for $X$- and $Z$-type errors (this assumption is satisfied for BB LDPC codes due to @proof-of-lemma-1). Suppose $Z(xi)$ is a minimum weight logical $Z$-type operator. Then $xi in sans("ker") H^X$ and $xi in.not sans("rs")(H^Z)$. Let $X(eta)$ be any logical $X$-type operator. Here $eta in sans("ker") H^Z without sans("rs")(H^X)$. Consider the following optimization problem:

$ d(eta) = min_(xi in sans("ker") H^X) sum_(j = 1)^n xi_j quad "subject to" quad eta^T xi = 1 . $ <MWD2>

Then $d(eta) gt.eq d$ for any logical operator $X(eta)$ and $d(eta) = d$ if $X(eta)$ anti-commutes with some minimum-weight logical operator $Z(xi)$. The latter event occurs with the probability $1/2$ if one picks $eta in sans("ker") H^Z$ uniformly at random. In this case $d(eta) = d$ with the probability at least $1/2$ and $d(eta) gt.eq d$ with certainty. Let $d^sans("BP")(eta)$ be an upper bound on $d(eta)$ obtained by solving the optimization problem @MWD2 using BP-OSD method with a parity check matrix $mat(delim: "[", H^X; eta^T)$ and a syndrome $(0, 0, dots, 0, 1)^T$. We have $d^sans("BP")(eta) gt.eq d$ with certainty and $d^sans("BP")(eta) = d$ with the probability $1/2$ whenever BP-OSD finds the optimal solution. Choose the number trials $T gt.double 1$ and pick vectors $eta^1, eta^2, dots, eta^T in sans("ker") H^Z without sans("rs")(H^X)$ uniformly at random. Then

$ d^sans("BP") := min_(a = 1, 2, dots, T) d^sans("BP")(eta^a) $

is an upper bound on the distance $d$ that can be systematically improved by increasing the number of trials $T$.

Using the quantity $d^sans("BP")$ as an efficiently computable proxy for the code distance enabled us to search over a large number of candidate BB codes with $n = O(100)$ qubits. The vast majority of these candidates was discarded due to an insufficiently large upper bound $d^sans("BP")$. This left only a few viable candidates with a sufficiently large value of $d^sans("BP")$. The actual distance of each candidate code was computed using the integer linear programming method~@landahl2011fault.

We similarly computed an upper bound on the circuit-level distance $d_sans("circ")$. Since the SM circuit can break the symmetry between $X$- and $Z$-type errors, the circuit-level distance has to be computed for both types of errors. For concreteness, let us discuss the circuit-level distance $d_sans("circ")^Z$ for $Z$-type errors. The latter is defined as the minimum number of faulty operations in the SM circuit that can generate an undetectable $Z$-type logical error. The optimization problem @MWD2 is replaced by

$ d_sans("circ")^Z (eta) = min_(xi in sans("ker")(D_X)) sum_(j = 1)^M xi_j quad "subject to" quad eta^T xi = 1 , $ <MWD1>

where $D_X$ is the decoding matrix constructed above and $eta in {0, 1}^M$ is a random linear combination of rows of $D_X$ and rows of $D_L$ that represent logical $X$-type operators. Then $d_sans("circ")(eta) gt.eq d_sans("circ")^Z$ with certainty and $d_sans("circ")(eta) = d_sans("circ")^Z$ with the probability at least $1/2$. Solving the optimization problem @MWD1 using BP-OSD method for many random choices of the vector $eta$ and taking the minimum value of $d_sans("circ")^Z(eta)$ provides an upper bound on $d_sans("circ")^Z$. One can similarly compute an upper bound on the circuit-level distance $d_sans("circ")^X$ for $X$-type errors. This provides an upper bound on $d_sans("circ") = min(d_sans("circ")^X, d_sans("circ")^Z)$.

= Proof of Lemma 1
<proof-of-lemma-1>

For convenience of the reader we restate the lemma below.

#block[
The code $sans("QC") ( A , B )$ has parameters $[ [ n , k , d ] ]$, where $n = 2 ell m , quad k = 2 dot.op "dim" (sans("ker") ( A ) inter sans("ker") ( B )) , quad "and" quad d = min #scale(x: 120%, y: 120%)[(] | v | : thin thin v in sans("ker") ( H^X ) without sans("rs") ( H^Z ) #scale(x: 120%, y: 120%)[)] .$ The code offers equal distance for $X$-type and $Z$-type errors.

]
#block[
#emph[Proof.] It is known~@steane1996multiple @calderbank1996good that $ k = n - sans("rk") H^X - sans("rk") H^Z . $ We claim that $sans("rk") H^X = sans("rk") H^Z$. Indeed, define a self-inverse permutation matrix $C_ell$ of size $ell times ell$ such that the $i$-th column of $C_ell$ has a single nonzero entry equal to one at the row $j = -i med ("mod" ell)$. Define $C_m$ similarly and let $C = C_ell ⊗ C_m$. Since $C_ell S_ell C_ell = S_ell^T$ and $C_m S_m C_m = S_m^T$, one gets

$ A^T = C A C quad "and" quad B^T = C B C . $ <ABC2-supp>

Therefore one can write

$ H^Z = [B^T | A^T] = [C B C | C A C] = C [A | B] mat(delim: "[", 0, C; C, 0) = C H^X mat(delim: "[", 0, C; C, 0) . $

Thus $H^Z$ is obtained from $H^X$ by multiplying on the left and on the right by invertible matrices. This implies $sans("rk") H^X = sans("rk") H^Z$. Therefore

$ k & = n - 2 dot.op sans("rk") H^Z = n - 2 (n/2 - dim(sans("ker") (H^Z)^T)) \
  & = n - 2 (n/2 - dim(sans("ker") A inter sans("ker") B)) \
  & = 2 dot.op "dim" (sans("ker") A inter sans("ker") B) . $

Here we noted that $H^Z$ has size $(n/2) times n$ and $sans("ker") (H^Z)^T = sans("ker") A inter sans("ker") B$ since $H^Z = [B^T | A^T]$.~◻

It is known~@steane1996multiple @calderbank1996good that a CSS code with check matrices $H^X$ and $H^Z$ has distance $d = min(d^X, d^Z)$, where $d^X$ and $d^Z$ are the code distances for $X$-type and $Z$-type errors defined as

$ d^X = min { |v| : thin v in sans("ker") H^Z without sans("rs") H^X } quad "and" quad d^Z = min { |v| : thin v in sans("ker") H^X without sans("rs") H^Z } . $

We claim that $d^Z lt.eq d^X$. Indeed, let $X(f) = product_(j=1)^n X_j^(f_j)$ be a minimum weight logical $X$-type Pauli operator such that $|f| = d^X$. Then $H^Z f = 0$ and $f in.not sans("rs") H^X$. Thus there exists a logical $Z$-type operator $Z(g) = product_(j=1)^n Z_j^(g_j)$ anti-commuting with $X(f)$. In other words, $H^X g = 0$ and $f^T g = 1$. Here, $f$ and $g$ are length-$n$ binary vectors. Write $f = (alpha, beta)$ and $g = (gamma, delta)$, where $alpha, beta, gamma, delta$ are length-$(n/2)$ vectors. Conditions $H^Z f = 0$ and $H^X g = 0$ are equivalent to

$ B^T alpha = A^T beta quad "and" quad A gamma = B delta . $ <alpha_beta_gamma_delta-supp>

Here and below all arithmetics is modulo two. Define length-$n$ vectors

$ e = (C delta, C gamma) quad "and" quad h = (C beta, C alpha) . $

From @ABC2-supp, @alpha_beta_gamma_delta-supp one gets

$ H^X h = [A | B] mat(delim: "[", C beta; C alpha) = A C beta + B C alpha = C (A^T beta + B^T alpha) = 0 . $

Likewise,

$ H^Z e = [B^T | A^T] mat(delim: "[", C delta; C gamma) = B^T C delta + A^T C gamma = C (B delta + A gamma) = 0 . $

Furthermore,

$ h^T e = beta^T C C delta + alpha^T C C gamma = beta^T delta + alpha^T gamma = f^T g = 1 . $

Thus $X(e)$ and $Z(h)$ are non-identity logical operators. It follows that $d^Z lt.eq |h|$. We get

$ d^Z lt.eq |h| = |C beta| + |C alpha| = |beta| + |alpha| = |f| = d^X . $

Thus $d^Z lt.eq d^X$. Similar argument shows that $d^X lt.eq d^Z$, that is, $d^X = d^Z$.

]
We note that the equality $d^X = d^Z$ can also be established using the machinery of Ref.~@panteleev2021quantum by viewing $sans("QC") ( A , B )$ as a Lifted Product code.

= Numerical simulation details
<sec:numerics>

Data reported in @fig:numerics A) was generated using BP-OSD software developed by Roffe et al.~@roffe2020decoding @Roffe_LDPC_Python_tools_2022. The decoder was extended to the circuit-based noise model as described in @sec:decoder. The simulations were performed using MIN-SUM belief propagation with the limit of $10 , 000$ iterations and combination sweep version of OSD, as described in @roffe2020decoding. All data points except for those with the smallest error rate accumulated at least 100 logical errors to estimate the logical error rate $p_L$ with the error bars $approx p_L / 10$. The fitting formula $p_L(p)=p^(d_sans("circ")/2) e^(c_0 + c_1 p + c_2 p^2)$ with fitting parameters $c_0 , c_1 , c_2$ was proposed in~@bravyi2013simulation in the context of surface code simulations. We observed that the same fitting formula works well for BB LDPC codes. The fitting parameters $c_i$ of the considered codes are provided in @table:fit.

Surface code data reported in @fig:numerics~B) was generated using software developed by one of the authors and Alexander Vargo in@bravyi2013simulation. The simulation was performed for the rotated surface code with parameters $[ [ d^2 , 1 , d ] ]$, where $d in {9 , 11 , 13 , 15}$, and the standard SM circuit~@fowler2009high. Let $P_(L , 1)$ be the logical error probability for the surface code encoding one logical qubit and SM circuit with $N_c = d$ syndrome cycles. Encoding $k = 12$ logical qubits into $12$ separate patches of the surface code results in a logical error probability $P_(L , 12) = 1 - ( 1 - P_(L , 1) )^12 .$ @fig:numerics~B) shows the logical error rate $p_L$ defined as the logical error probability per syndrome cycle, $p_L = 1 - ( 1 - P_(L , 12) )^(1 N_c) = 1 - ( 1 - P_(L , 1) )^(12 d) .$

#figure(
  table(
    columns: 4,
    align: center + horizon,
    table.header([$[ [ n , k , d ] ]$], [$c_0$], [$c_1$], [$c_2$]),
    table.hline(stroke: 0.6pt),
    [$[ [ 72 , 12 , 6 ] ]$], [$11.09$], [$365.6$], [$- 16088$],
    [$[ [ 90 , 8 , 10 ] ]$], [$15.08$], [$524.8$], [$- 12670$],
    [$[ [ 108 , 8 , 10 ] ]$], [$13.91$], [$895$], [$- 46137$],
    [$[ [ 144 , 12 , 12 ] ]$], [$18.04$], [$1337$], [$- 96007$],
    [$[ [ 288 , 12 , 18 ] ]$], [$32.04$], [$3522$], [$- 294482$],
    table.hline(stroke: 0.6pt),
  ),
  caption: [Parameters $c_0, c_1, c_2$ in the fitting formula $p_L (p) = p^(d_sans("circ")/2) e^(c_0 + c_1 p + c_2 p^2)$ for BB LDPC codes shown in @table:codes_intro.],
  kind: table,
) <table:fit>

= Logical memory capabilities
<sec:logicals>

In this section we give evidence that BB LDPC codes have the required features for an effective quantum memory or storage unit. Although there are few ways of performing computations on stored qubits, there are fault tolerant operations for initialization and measurement of individual qubits, and most importantly transfer of data into and out of the code via quantum teleportation. These capabilities are based on a combination of two different techniques.

First, we follow @breuckmann2022foldtransversal to derive fault tolerant unitary operations that require only the connectivity already necessary to perform syndrome measurements. Second, we give low-overhead extensions of the Tanner graph based on work by @cohen2022lowoverhead which enable measurement of a single logical operator while preserving the thickness-2 implementability criterion. Together, these capabilities allow us to address any logical qubit.

// [figvision] imgs/0808_better_conceptual.png
// Two large 5x9 dot lattices side by side, labelled "Unprimed Block" (left) and
// "Primed Block" (right), each with six circled qubits q1..q6 (q1'..q6') at different
// positions. A double-headed arrow between the blocks is labelled "ZX Duality Gate:
// exchange blocks".
// Under the left block: an L-shaped pair of black arrows labelled "Automorphism gates:
// translate grid" (row and column translations). The bottom-right qubit q6 is wired down
// to two small check circles X and Z, which connect to a box labelled "Surface Code";
// an arrow labels these "Ancilla Systems: measure X and Z".
// Under the right block: arrows from the two lower-right qubits point to the text
// "Logical Qubit X and Z" / "Redundant Logical X and Z", i.e. the primed block carries a
// redundant pair of logical operators.
#figure(image("imgs/0808_better_conceptual.png", height: 7cm),
  caption: [
    Conceptual diagram depicting the manner by which logical operators can be loaded into and out of a BB LDPC code. In #ref(<ssec:logical_pauli_operators>, supplement: [Subsection]) we derive that there are two blocks of logical Pauli operators corresponding to a 2d grid. Some subset of these grid elements can be chosen as logical qubits (large dots) and the other elements correspond to various Pauli products (small dots). In #ref(<ssec:automorphisms>, supplement: [Subsection]) we show that there are fault tolerant logical gates based on automorphisms that translate the grid of operators within each block, and in #ref(<ssec:ZX_duality>, supplement: [Subsection]) we give a fault tolerant gate based on a ZX-duality @breuckmann2022foldtransversal that swaps the two blocks. Finally, in #ref(<ssec:logical_measurements>, supplement: [Subsection]) we show that there exists an ancilla system based on @cohen2022lowoverhead that can measure one logical $X$ operator. We can think of this system as a probe that can access one logical qubit. Together, these operations allow external access of every logical qubit and many of their products.
  ]
)

<fig:ops_summary>

A conceptual representation of the logical operators is shown in @fig:ops_summary . We first derive logical Pauli operators for BB LDPC codes, and find that the logical qubits divide into an "unprimed" and a "primed" block with equal size and symmetrical structure. We visualize the primed and unprimed block as two sheets featuring a 2D grid of logical operators. Some of these grid cells contain one of the $k 2$ logical qubits per sheet.

Next, we show that there exists a set of fault tolerant depth-four circuits that implement a small family of commuting logical $sans("CNOT")$ circuits. These gates are based on automorphisms of the code: permutations of the data qubits that commute with the stabilizer. Based on their group structure we can think of the automorphism gates as translations of a 2D grid of operators within each of the primed and unprimed blocks. Furthermore, we follow @breuckmann2022foldtransversal to derive a fault tolerant operation based on a ZX-duality that also allows us to swap the two blocks while also applying Hadamard gates to all qubits.

Finally, we show how to leverage techniques from @cohen2022lowoverhead to extend the Tanner graph to a larger Tanner graph allowing fault-tolerant measurement of one logical $X$ and one logical $Z$ operator. Various subgraphs of this extended Tanner graph contain either this logical $X$ or $Z$ operator as a stabilizer. This construction acts as a "probe" that gives us access to one of the logical qubits.

Measurements of both logical $X$ and $Z$ operators on any qubit can be realized by conjugating this measurement by gates based on automorphisms and the ZX-duality. We can think of this as shifting any desired qubit to be the target of the probe using translation and exchange of the two blocks.

Logical $X$ and $Z$ measurement of any logical qubit also enables transfer of data into and out of the code using a teleportation circuit. This teleportation can be realized through a product measurement of the logical Pauli in the BB code, and a logical Pauli in another quantum error correction code. While the Tanner graph of the BB code demands thickness-2, we show how the ancilla system corresponding to the logical $X$ measurement can be implemented in an "effectively planar" Tanner graph. This makes it possible two connect this ancilla system to another quantum error correction code, like a surface code, within a thickness-2 implementation. This capability indicates the suitability of BB LDPC codes as a fault tolerant quantum memory.

== Logical Pauli Operators
<ssec:logical_pauli_operators>

In this section we derive that the logical Pauli matrices of BB LDPC codes split into a "primed" and an "unprimed" block with $| cal(M) | = ell m$ many $X$ operators and $Z$ operators each. Operators in the primed block commute with operators in the unprimed block, and the two blocks have identical commutation structure.

We begin by introducing some new notation for Pauli matrices acting on the data qubits. We denote with $bb(F)_2^(cal(M))$ the set of polynomials over $bb(F)_2$ with monomials from $cal(M)$. This is equivalent to the quotient ring obtained from $bb(F)_2 [ x , y ]$ by identifying $x^ell = y^m = 1$. With $x = S_m ⊗ I$ and $y = I ⊗ S_ell$, the elements of $bb(F)_2^(cal(M))$ have natural matrix representations, and can also be interpreted as sets since the coefficient on any particular $x in cal(M)$ is either 0 or 1.

For $P , Q in bb(F)_2^(cal(M))$, we can consider the set of qubits $q ( L , alpha )$ for $alpha in P$ and $q ( R , beta )$ for $beta in Q$. We write $X ( P , Q )$ to denote a Pauli matrix acting as $X$ on this collection of qubits, and identity elsewhere. Similarly, $Z ( P , Q )$ denotes $Z$ acting on $q ( L , alpha )$ for $alpha in P$ and $q ( R , beta )$ for $beta in Q$. For example, we can recall that $q ( L , beta )$ is connected to $q ( X , alpha )$ whenever $beta in A alpha$, and see that the stabilizer corresponding to $q ( X , alpha )$ becomes $X ( alpha A , alpha B )$. Similarly, the stabilizer corresponding to $q ( Z , alpha )$ can be written as $Z ( alpha B^T , alpha A^T )$. There is also the following useful fact:

#block[
$X ( P , Q )$ anticommutes with $Z ( macron(P) , macron(Q) )$ if and only if $1 in P macron(P)^T + Q macron(Q)^T$.

]

#block[
#emph[Proof.] Write

$ P = sum_(alpha in cal(M)) p_alpha alpha, quad overline(P) = sum_(alpha in cal(M)) overline(p)_alpha alpha, quad Q = sum_(alpha in cal(M)) q_alpha alpha, quad overline(Q) = sum_(alpha in cal(M)) overline(q)_alpha alpha , $

where $p_alpha, overline(p)_alpha, q_alpha, overline(q)_alpha in bb(F)_2$ are coefficients. Pauli operators $X(P, Q)$ and $Z(overline(P), overline(Q))$ overlap on a qubit $q(L, alpha)$ iff $p_alpha overline(p)_alpha = 1$ and overlap on a qubit $q(R, alpha)$ iff $q_alpha overline(q)_alpha = 1$. Thus $X(P, Q)$ and $Z(overline(P), overline(Q))$ anti-commute iff $sum_(alpha in cal(M)) p_alpha overline(p)_alpha + q_alpha overline(q)_alpha$ is odd. We have

$ P overline(P)^T = sum_(alpha in cal(M)) p_alpha overline(p)_alpha 1 + dots quad "and" quad Q overline(Q)^T = sum_(alpha in cal(M)) q_alpha overline(q)_alpha 1 + dots $

where dots represent all monomials different from $1$. By linearity,

$ P overline(P)^T + Q overline(Q)^T = sum_(alpha in cal(M)) (p_alpha overline(p)_alpha + q_alpha overline(q)_alpha) 1 + dots . $

Thus $X(P, Q)$ and $Z(overline(P), overline(Q))$ anti-commute iff $P overline(P)^T + Q overline(Q)^T$ contains the monomial $1$.~◻

]

Without loss of generality, we can express logical Pauli matrices as either $X(P, Q)$ or $Z(Q^T, P^T)$ via a choice of $P, Q in bb(F)_2^(cal(M))$. The operator $X(P, Q)$ commutes with the stabilizer $Z(alpha B^T, alpha A^T)$ whenever $1 in.not P(alpha B^T)^T + Q(alpha A^T)^T = alpha^T (P B + Q A)$. This is equivalent to $alpha in.not P B + Q A$. Since we must have $alpha in.not P B + Q A$ for all $alpha$, we see that $X(P, Q)$ commutes with the stabilizer whenever $P B + Q A$ vanishes. Similarly we can derive that $Z(Q^T, P^T)$ commutes with the stabilizer when $P B + Q A = 0$.

We aim to construct a family of solutions to $P B + Q A = 0$ which give rise to a basis of logical qubits defined by a set of operators $(overline(X)_1, overline(X)_2, dots, overline(Z)_1, overline(Z)_2, dots)$ with the correct commutation relations. To do so, let us make some observations about Pauli operators defined via solutions to $P B + Q A = 0$. First, if $P, Q$ are a solution, then so are $alpha P, alpha Q$ for any $alpha in cal(M)$, so each $P, Q$ immediately gives rise to a family of $|cal(M)| = ell m$ logical operators for both $X$ and $Z$. Second, consider using the same $P, Q$ to define both $X(alpha P, alpha Q)$ and $Z(beta Q^T, beta P^T)$. Then these operators always commute because $beta alpha^T in P Q + Q P = 0$ never holds. So we require at least two solutions to $P B + Q A = 0$ to define a set of operators with nontrivial commutation relations.

For reasons described later in #ref(<ssec:logical_measurements>, supplement: [Subsection]), we would like a logical $X$ operator with no support on $q(R)$. To this end, we select $f, g, h in bb(F)_2^(cal(M))$ that satisfy $B f = 0$ and $g B + h A = 0$, yielding two solutions to the equation $P B + Q A = 0$ with $P, Q = f, 0$ and $P, Q = g, h$. These yield the following family of logical operators for all $alpha in cal(M)$:

$ overline(X)_alpha := X(alpha f, 0) quad overline(Z)_alpha := Z(alpha h^T, alpha g^T) \
  overline(X)'_alpha := X(alpha g, alpha h) quad overline(Z)'_alpha := Z(0, alpha f^T) $ <eq:logicalpaulis>

For all $alpha , beta$, we see that $macron(X)_alpha , macron(Z)'_beta$ always commute because $f 0^T + 0 f^T = 0$, and $macron(X)'_beta , macron(Z)_alpha$ always commute because $g h + h g = 0$. Furthermore, $macron(X)_alpha , macron(Z)_beta$ and $macron(X)'_alpha , macron(Z)'_beta$ form anticommuting pairs when $alpha^T beta in f h$. We see that we have constructed two independent blocks of logical operators with symmetrical structure. It follows that each of these blocks must contain a set of operators that define $k 2$ qubits. We name these the "unprimed" and "primed" logical blocks with $macron(X)_alpha , macron(Z)_beta$ and $macron(X)'_alpha , macron(Z)'_beta$ respectively.

Not all choices of $f , g , h$ span all $k$ logical qubits, but valid choices are readily enumerated in software. Solutions to $B f = 0$ and $g B + h A = 0$ correspond to null spaces of $B$ and $mat(delim: "[", B; A)$ respectively, which can be constructed by Gaussian elimination. Gaussian elimination can also be used to check if the operators $macron(X)_alpha , macron(Z)_alpha , macron(X)'_alpha , macron(Z)'_alpha$ together span $k$ qubits up to the stabilizer. We find all codes in @table:codes admit several such choices of $f , g , h$. In @table:f_polys we show a particularly favorable choice of $f , g , h$ for the $[ [ 144 , 12 , 12 ] ]$ code where the resulting logical operators have minimum weight.

To identify logical qubits we can enumerate choices of monomials $( n_1 , n_2 , dots.h , n_(k 2) )$ and $( m_1 , m_2 , dots.h , m_(k 2) )$ such that $n_i^T m_j in f h$ exactly when $i = j$. That way, $macron(X)_(n_i) , macron(Z)_(m_i)$ as well as $macron(X)'_(n_i) , macron(Z)'_(m_i)$ for $i = 1 . . . k 2$ form a set of $k$ logical qubits: $macron(X)_(n_i)$ anticommutes with $macron(Z)_(m_j)$ exactly when $i = j$. A brute force search readily finds choices of ${ n_i } , { m_i }$.

#let polygrid(dots) = cetz.canvas(length: 0.62cm, {
  import "@preview/cetz:0.4.2": draw
  for xx in range(-1, 12) {
    draw.line((xx / 2 + 0.5, -0.5), (xx / 2 + 0.5, 3.0), stroke: 0.3pt + luma(110))
  }
  for yy in range(-1, 6) {
    draw.line((-0.5, yy / 2 + 0.5), (6.0, yy / 2 + 0.5), stroke: 0.3pt + luma(110))
  }
  for xx in range(0, 12) {
    draw.content((xx / 2 + 0.25, -0.5), text(size: 4pt)[#xx], anchor: "south")
  }
  for yy in range(0, 6) {
    draw.content((-0.5, yy / 2 + 0.25), text(size: 4pt)[#yy], anchor: "west")
  }
  draw.content((-0.4, -0.75), text(size: 5pt)[$x$], anchor: "south-west")
  draw.content((-0.75, -0.45), text(size: 5pt)[$y$], anchor: "south-west")
  for (dx, dy) in dots {
    draw.circle((dx / 2 + 0.25, dy / 2 + 0.25), radius: 0.15, fill: black)
  }
})

#figure(
  table(
    columns: 3,
    align: center + horizon,
    table.header(table.cell(colspan: 3, align: center)[Polynomials for Logical Pauli Matrices in the $[ [ 144 , 12 , 12 ] ]$ Code]),
    table.hline(stroke: 0.6pt),
    [$f$], [$g$], [$h$],
    table.hline(stroke: 0.6pt),
    polygrid(((1, 0), (0, 0), (2, 0), (3, 0), (6, 0), (7, 0), (8, 0), (9, 0), (1, 3), (5, 3), (7, 3), (11, 3))),
    polygrid(((1, 2), (0, 4), (2, 3), (1, 0), (0, 2), (2, 1))),
    polygrid(((0, 3), (0, 2), (1, 3), (0, 1), (0, 0), (1, 1))),
    table.hline(stroke: 0.6pt),
    table.cell(colspan: 3)[],
  ),
  caption: [Choices of polynomials $f , g , h$ such that $macron(X)_alpha := X ( alpha f , 0 )$ and $macron(Z)_alpha = Z ( alpha h^T , alpha g^T )$ as defined in @eq:logicalpaulis are minimum-weight logical Pauli operators. The dots represent the monomials of the form $x^i y^j$ with coefficient 1. If we let ${ n_i } = ( 1 , y , x^2 y , x^2 y^5 , x^3 y^2 , x^4 )$ and ${ m_i } = ( y , y^5 , x y , 1 , x^4 , x^5 y^2 )$, then $macron(X)_(n_i) , macron(Z)_(m_j)$ anticommute exactly when $i = j$. When used to construct an ancilla system as in #ref(<ssec:logical_measurements>, supplement: [Subsection]), these polynomials give a system with 60 qubits per layer. ],
  kind: table,
) <table:f_polys>

== Logical Gates based on Automorphisms
<ssec:automorphisms>

An automorphism of an error correction code is a permutation of the physical qubits that is equivalent to a permutation of the checks

\(more generally, an automorphism can map a check operator to a product of check operators). We focus on permutations that are implementable using fault tolerant circuits within the connectivity already required for syndrome measurements.

The existing connectivity admits some natural fault tolerant circuits implementing a particular family of permutations on the data qubits. BB LDPC codes feature two data registers $q ( L ) , q ( R )$ and two

check registers $q ( X ) , q ( Z )$. We consider circuits that transfer the qubits from the data registers to the ancilla registers, and back again on a different path. The adjacency matrices describing the connectivity between the data and the ancilla registers are given by $A$ and $B$, which are the sum of three monomials $A_1 , A_2 , A_3$ and $B_1 , B_2 , B_3$ in $cal(M)$. Each monomial is a permutation and thus describes a vertex-disjoint set of edges between the data and ancilla block. Hence, all swaps along these edges can be parallelized. In a single circuit we can either swap along the edges defined by $A$ which are $q ( L ) arrow.l.r q ( X )$ and $q ( R ) arrow.l.r q ( Z )$, or along edges defined by $B$ which are $q ( L ) arrow.l.r q ( Z )$ and $q ( R ) arrow.l.r q ( X )$. See also A).

The monomial defining the particular set of edges in each of these sets of swaps can be chosen independently for each stage of the permutation (data $arrow.r$ ancilla or ancilla $arrow.r$ data), and on each side of the Tanner graph.

For example, we can select any $A_j , A_k , A_(j') , A_(k')$ and move $q ( L ) arrow.r_(A_j^T) q ( X ) arrow.r_(A_k) q ( L )$ and simultaneously move $q ( R ) arrow.r_(A_(k')) q ( Z ) arrow.r_(A_(j')^T) q ( R )$. However, we will see later that it is necessary to select $A_j = A_(j')$ and $A_k = A_(k')$. Furthermore, these swaps admit a standard optimization: if we initialize the check registers $q ( X ) , q ( Z )$ to the $| 0 chevron.r$ state, then circuits implementing these permutations have $sans("CNOT")$ depth four. If we also reset qubits to the $| 0 chevron.r$ state in between the swaps wherever possible, we obtain circuits whose errors cannot propagate between physical qubits, and are hence fault tolerant. See @table:automorphisms.

We now verify that the permutations implemented by the circuits described above are indeed automorphisms. After having applied an 'A' type permutation based on $A_j , A_k$, the qubits are permuted by $q ( L , alpha ) arrow.l.r q ( L , A_k^T A_j alpha )$ and $q ( R , alpha ) arrow.l.r q ( R , A_k^T A_j alpha )$. We see that this transforms a Pauli matrix by $X ( P , Q ) arrow.r X ( A_j A_k^T P , A_j A_k^T Q )$. Consequently, the stabilizers are transformed as $X ( alpha A , alpha B ) arrow.r X ( alpha A_j A_k^T A , alpha A_j A_k^T B )$, which is the same as permuting the $X$ checks by $alpha arrow.r alpha A_j A_k^T$. The $Z$ stabilizers are also permuted by $alpha arrow.r alpha A_j A_k^T$, so the described circuit indeed implements an automorphism. Notice also that this only works because the $q ( L )$ and $q ( R )$ blocks were transformed by the same $A_j A_k^T$. The 'B' type permutations can be verified to be automorphisms in the same manner, permuting the checks by some $B_j B_k^T$.

These automorphisms allow us to fault tolerantly implement a subgroup of the Clifford gates. As we saw in , shifts of the form $A_j A_k^T$ or $B_j B_k^T$ generate the entire group $cal(M)$ whenever the Tanner graph is connected.

Therefore, by leveraging these permutations as generators, we can perform all translations of the tori containing $q ( L ) , q ( R )$ using fault tolerant circuits of varying depth. An automorphism defined by an element $s in cal(M)$ transforms $macron(X)_(n_i) arrow.r macron(X)_(s n_i)$, $macron(Z)_(m_i) arrow.r macron(Z)_(s m_i)$ and similarly for the primed logical Pauli matrices. This capability is critical for addressing all logical qubits.

We can also comment on the nature of these operations as logical gates, although they are less useful in this sense. There is one such operation per element in $cal(M)$, and since $cal(M)$ is Abelian the subgroup of Clifford gates implemented by these automorphisms must be Abelian as well. A transformation of this form cannot act like the logical identity so all of these gates (except $s = 1$) are nontrivial. Since automorphism operations take $macron(X)$ to $macron(X)$ and $macron(Z)$ to $macron(Z)$, and they must hence be logical $sans("CNOT")$ circuits up to a logical Pauli correction. While it is not clear how to use these $sans("CNOT")$ circuits to facilitate useful computations, they may make for interesting test cases in an implementation.

#figure(
  align(center)[#table(
    columns: 2,
    align: (left,left,),
    table.cell(align: center, colspan: 2)['A' type automorphism based on any $A_j , A_k$],
    [#block[
      For $alpha in cal(M)$: \
      $sans("InitZ") quad q (X, alpha)$ \
      $sans("CNOT") quad q (L, A_j alpha) quad q (X, alpha)$ \
      $sans("CNOT") quad q (X, alpha) quad q (L, A_j alpha)$ \
      $sans("InitZ") quad q (L, A_k^T alpha)$ \
      $sans("CNOT") quad q (X, alpha) quad q (L, A_k alpha)$ \
      $ sans("CNOT") quad q (L, A_k alpha) quad q (X, alpha) $
    ]], [#block[
      For $alpha in cal(M)$: \
      $sans("InitZ") quad q (Z, alpha)$ \
      $sans("CNOT") quad q (R, alpha) quad q (Z, A_j alpha)$ \
      $sans("CNOT") quad q (Z, A_j alpha) quad q (R, alpha)$ \
      $sans("InitZ") quad q (R, A_k alpha)$ \
      $sans("CNOT") quad q (Z, A_k alpha) quad q (R, alpha)$ \
      $ sans("CNOT") quad q (R, alpha) quad q (Z, A_k alpha) $
    ]],
    table.cell(align: center, colspan: 2)['B' type automorphism based on any $B_j , B_k$],
    [#block[
      For $alpha in cal(M)$: \
      $sans("InitZ") quad q (X, alpha)$ \
      $sans("CNOT") quad q (R, B_j alpha) quad q (X, alpha)$ \
      $sans("CNOT") quad q (X, alpha) quad q (R, B_j alpha)$ \
      $sans("InitZ") quad q (R, B_k^T alpha)$ \
      $sans("CNOT") quad q (X, alpha) quad q (R, B_k alpha)$ \
      $ sans("CNOT") quad q (R, B_k alpha) quad q (X, alpha) $
    ]], [#block[
      For $alpha in cal(M)$: \
      $sans("InitZ") quad q (Z, alpha)$ \
      $sans("CNOT") quad q (L, alpha) quad q (Z, B_j alpha)$ \
      $sans("CNOT") quad q (Z, B_j alpha) quad q (L, alpha)$ \
      $sans("InitZ") quad q (L, B_k alpha)$ \
      $sans("CNOT") quad q (Z, B_k alpha) quad q (L, alpha)$ \
      $ sans("CNOT") quad q (L, alpha) quad q (Z, B_k alpha) $
    ]],
  )]
  , caption: [Circuits implementing automorphisms of a BB LDPC code within the connectivity already present for syndrome checks. These circuits are fault tolerant and have $sans("CNOT")$ depth four. If $s = A_j A_k^T$ or $s = B_j B_k^T$, then the logical gate implemented by these automorphisms performs the transformation $macron(X)_alpha , macron(Z)_alpha , macron(X)'_alpha , macron(Z)'_alpha arrow.r macron(X)_(s alpha) , macron(Z)_(s alpha) , macron(X)'_(s alpha) , macron(Z)'_(s alpha)$.]
  , kind: table
  ) <table:automorphisms>

== Accessing the Primed Block via a ZX-duality
<ssec:ZX_duality>

A ZX-duality is a permutation of the logical qubits that commutes with the stabilizer, except that it turns $X$ checks into $Z$ checks and $Z$ checks into $X$ checks. A physical circuit implementing this permutation and then applying Hadamard to all data qubits always acts as a logical gate @breuckmann2022foldtransversal. In this section we focus on the implementation of a particular ZX-duality with applications for readout. We leave discovery and implementation of other ZX-dualities for future work. In particular, we derive a general method for constructing fault tolerant circuits for implementing a particular ZX-duality that is present in all BB LDPC codes. While the circuits from this construction are generally quite expensive, they may be amenable to further optimization and can be used sparingly in practice.

Consider a permutation of data qubits that swaps $q ( L , alpha )$ with $q ( R , alpha^T )$ for all $alpha in cal(M)$. A check qubit $q ( X , beta )$ which previously implemented the stabilizer $X ( beta A , beta B )$ now is connected to the qubits $q ( L , ( beta B )^T )$ and $q ( R , ( beta A )^T )$ instead, corresponding to the check $Z ( beta^T B^T , beta^T A^T )$. We see that this permutation switches the stabilizer implemented by $q ( X , beta )$ with the stabilizer implemented by $q ( Z , beta^T )$, so this permutation is indeed a ZX-duality.

We can also see that implementing this permutation and applying Hadamard to all qubits takes logical Pauli matrices to logical Pauli matrices. In particular, the operation swaps $macron(X)_alpha = X ( alpha f , 0 )$ with $macron(Z)'_(alpha^T) = Z ( 0 , alpha^T f^T )$, as well as $macron(Z)_alpha = Z ( alpha h^T , alpha g^T )$ with $macron(X)'_(alpha^T) := X ( alpha^T g , alpha^T h )$. This operation swaps the primed and unprimed logical blocks, transposes the grid of operators, and applies logical Hadamard to all qubits. Since we can measure logical $X$ for all qubits in the unprimed block using the ancilla system described in #ref(<ssec:logical_measurements>, supplement: [Subsection]), we can use this operation to measure logical $Z$ for qubits in the primed block.

For the rest of this section we describe a fault tolerant method for implementing this operation. We begin with exchanging $q ( L )$ and $q ( R )$: since these blocks are connected by pairs of edges in $q ( X )$ and $q ( Z )$, for any $A_i in A$ and $B_j in B$ there exists a loop connecting the qubits $q ( L , alpha ) arrow.r q ( X , A_i^T alpha ) arrow.r q ( R , B_j A_i^T alpha ) arrow.r q ( Z , B_j alpha ) arrow.r q ( L , alpha )$. A circuit identical in shape to those in hence performs a fault tolerant exchange of $q ( L , alpha )$ and $q ( R , B_j A_i^T alpha )$ for all $alpha$. The additional shift of $B_j A_i^T$ can be removed via an additional automorphism gate. It remains to exchange $q ( L , alpha ) arrow.l.r q ( L , alpha^T )$, as well as $q ( R , alpha ) arrow.l.r q ( R , alpha^T )$ for all $alpha$, which is significantly more complicated. We focus on $q ( L , alpha ) arrow.l.r q ( L , alpha^T )$ in our discussion but it will be clear the exact same transformations are implementable on $q ( R )$ in parallel with those on $q ( L )$.

// [figvision] imgs/duality_implementation.png
// Four labelled groups (A-D) of small graph/presentation diagrams.
// (A) A four-node tree: a central node splits into left and right branches above and a
//     vertical stub below; edge labels A_i (left), A_j (vertical), A_k (right); node
//     labels q(L,alpha), q(L,A_j A_i^T alpha), q(X,A_i^T alpha) and
//     q(X,A_k (A_i^T)^2 alpha) - the local rule for translating the primal/dual lattice.
// (B) Six small three-node paths (A-B-C) numbered 1-6, each with a different pair of
//     directed (or doubled) edges, showing the six possible local edge orientations.
// (C) Group presentation for [[90,8,10]]: x^15=y^3=1, p^3=q^5=r^3=1, x=pq, y=r;
//     beside it three triangulated polygons whose vertices are labelled 1, p, p^2;
//     q, q^2, q^3, q^4; r, r^2 with directed arcs annotated by the corresponding
//     generators.
// (D) Same for [[144,12,12]]: x^12=y^6=1, p^4=q^3=r^2=s^3=1, x=pq, y=rs; beside it a
//     diamond (1, p, p^2, p^3), an alternative diamond with a p-loop, a triangle with
//     q, q^2, a single r edge, and a triangle with s, s^2 - the local relations encoded
//     graphically.
#figure(image("imgs/duality_implementation.png", height: 8cm),
  caption: [
    Diagrams for the description of the implementation of the ZX-duality permutation. A) A subgraph of the Tanner graph providing enough connectivity to fault tolerantly swap $q ( L , alpha )$ and $q ( L , A_j A_i^T alpha )$. B) A sequence of shifts of the data on the qubits in the $q ( L )$ block that performs the desired exchange without interacting qubits directly. A naive implementation of this sequence has $sans("CNOT")$ depth 12. C) D) Decomposition of the generators of $cal(M)$ via the classification of finite Abelian groups for two different codes. Drawing the Cayley graph of the subgroup for each generator reveals the ratios defining pairs of qubits that must be exchanged to implement the permutation $q ( L , alpha ) arrow.l.r q ( L , alpha^T )$.
  ]
)
<fig:duality_implementation>

Fault tolerant implementation of the permutation $q ( L , alpha ) arrow.l.r q ( L , alpha^T )$ can be achieved using a more sophisticated version of the fault tolerant circuits in @table:automorphisms used for implementing automorphisms. These circuits relied on the existence of a connected loop of alternating check and data qubits, enabling a short depth fault tolerant circuit implementing a cyclic permutation of the data qubits therein. The same connectivity can be leveraged to implement a fault tolerant nearest neighbor swap of two data qubits connected by a check qubit. The fault tolerance of these circuits relies on the same principle: while a swap gate acting on two qubits containing data is not fault tolerant, moving a data qubit onto a blank qubit is @fig:duality_implementation. A) shows a subgraph of the Tanner graph consisting of several connected qubits in the $q ( L )$ and $q ( X )$ block, and B) shows a sequence of operations where two data qubits can be exchanged without ever interacting directly. This gives us the following capability: whenever the circuits in @table:automorphisms can implement the cyclic permutation $q ( L , alpha ) arrow.r q ( L , s alpha )$ for all $alpha$, there also exists a circuit that can swap $q ( L , alpha )$ and $q ( L , s alpha )$ for a particular $alpha$. Matching circuits exist for $q ( R )$, and can be implemented simultaneously.

To decompose $q ( L , alpha ) arrow.l.r q ( L , alpha^T )$ into a sequence of swaps, it will be helpful to consider the group structure of $cal(M)$. Consider for example the $[ [ 90 , 8 , 10 ] ]$ code with $x^15 = y^3 = 1$.

Following the classification of finite Abelian groups we see that $cal(M) tilde.equiv bb(Z)_3 times bb(Z)_5 times bb(Z)_3$. We can re-express elements of $cal(M)$ using generators $p , q , r$ with $p^3 = q^5 = r^3 = 1$ where $x = p q$ and $y = r$. Transforming $alpha$ to $alpha^T$ amounts to decomposing $alpha$ as $alpha = p^i q^j r^k$ and exchanging the qubit with $alpha^T = p^(- i) q^(- j) r^(- k)$.

This exchange $p^i q^j r^k arrow.l.r p^(- i) q^(- j) r^(- k)$ can be split into a sequence of swaps that are implementable with the method described above using A) and B). It suffices to be able to exchange for any $alpha = q^j r^k$ the qubits $q ( L , p^i alpha ) arrow.l.r q ( L , alpha p^(- i) )$, as well as for any $alpha = p^i r^k$ the qubits $q ( L , q^j alpha ) arrow.l.r q ( L , alpha q^(- j) )$, and finally for any $alpha = p^i q^j$ the qubits $q ( L , r^k alpha ) arrow.l.r q ( L , alpha r^(- k) )$. This, for any $i , j , k$, creates a sequence of qubits $q ( L , p^i q^j r^k ) arrow.l.r q ( L , p^(- i) q^j r^k ) arrow.l.r q ( L , p^(- i) q^(- j) r^k ) arrow.l.r q ( L , p^(- i) q^(- j) r^(- k) )$ where swaps are possible along each nearest neighbor. This is sufficient for swapping the first and last qubit in the chain. The implementation of the individual generators like $q ( L , alpha q^i ) arrow.l.r q ( L , alpha q^(- i) )$ swaps may also involve additional intermediate qubits, but this only lengthens the chain and does not prohibit implementation.

The resources required for swapping $q ( L , p^i alpha ) arrow.l.r q ( L , alpha p^(- i) )$ where $p^3 = 1$ and similarly for other generators depends on the order of the generator $p$ as well as the ratios $A_i A_j^T$ that can be formed using terms $A_i , A_j in A$ or similar ratios from $B$. See C). Plotting the Cayley graph of the cyclic subgroup spanned by $p$ immediately reveals that since $p$ is order three, only a single ratio $B_i B_j^T = p$ is needed in order to swap any qubits marked $p^1$ and $p^2$, while leaving $p^0$ qubits in place. Indeed since $B = 1 + x^2 + x^7 = 1 + p^2 q^2 + p q^2$ we can implement $p = ( p^2 q^2 ) ( p q^2 )^T$ in a single layer of transforms in B).

The exchange $q ( L , alpha q^i ) arrow.l.r q ( L , alpha q^(- i) )$ with $q^5 = 1$ requires two such ratios $q$ and $q^2$, the minimal depth expression of which demands the chaining together of two such transforms each. In other codes, like the $[ [ 144 , 12 , 12 ] ]$ code, we encounter generators $p , q , r , s$ of order $p^4 = q^3 = r^2 = s^3 = 1$. Elements of order two like $r$ require no swaps at all, and elements of order four like $p$ can be implemented either using the ratio $p^2$ or just $p$, as shown in D). Numerical searches can quickly compute the most efficient decompositions of the required swaps. We give the orders of the generators, the ratios defining the required swaps, and the number of transforms required to implement them in @table:duality_implementations.

We emphasize that the swap $q ( L , p^i alpha ) arrow.l.r q ( L , alpha p^(- i) )$ can be performed for all $alpha = q^j r^k$ simultaneously in parallel. This stems from the structure of the exchange circuit in B). This circuit performs the swap $q ( L , alpha ) arrow.l.r q ( L , A_j A_i^T dot.op alpha )$ while using the qubit $q ( L , A_k A_i^T dot.op alpha )$ as scratch space. However, we can simultaneously want to swap $q ( L , A_k A_i^T dot.op alpha ) arrow.l.r q ( L , A_j A_i^T dot.op A_k A_i^T dot.op alpha )$ since the first step of the exchange circuit in B) is to move the data marked 'A' away from the qubit holding it, just as if it were a piece of data marked 'C' for a different exchange.

For clarity, we compute the total depth of the circuit for the $[ [ 144 , 12 , 12 ] ]$ code without any further optimization. The ratios $p , q , s$ can be implemented using two ratios each via $p = x^(- 3) y dot.op y^(- 2) y$, $q = y^(- 3) x^2 dot.op y^(- 3) x^2$ and $s = y^(- 2) y dot.op y^(- 2) y$. This results in a chain $q ( L , alpha ) arrow.l.r q ( L , alpha' ) arrow.l.r q ( L , alpha'' ) . . . arrow.l.r q ( L , alpha^T )$ of length six (counting the number of $arrow.l.r$s). We can swap the qubits at the ends of a chain of length $n$ using $2 n - 1$ many nearest neighbor swaps. Each swap circuit of the form B) can be implemented in $sans("CNOT")$ depth twelve, resulting in $sans("CNOT")$ depth $( 2 dot.op 6 - 1 ) dot.op 12 = 132$ to implement $q ( L , alpha ) arrow.l.r q ( L , alpha^T )$.

Despite its fault tolerance, the implementation of this logical operation is clearly significantly more expensive than that of the automorphisms. Since the intermediate permutations corresponding to each of the generators $p , q , r$ are not ZX dualities in general, it will not be possible in general to perform error correction during this long operation. However, the significant overhead of this operation may be worth such a large cost, since it grants us the capability of accessing the primed block of qubits, effectively doubling the storage capacity of the code. This operation can also be used significantly more sparingly than the automorphism gates, and may be amenable to additional optimization.

#block[
#figure(
  align(center)[#table(
    columns: 5,
    align: (center,center,center,center,center,),
    table.header([Code], [Base Order], [Reduced Order], [Required Ratios], [Swap Chain Length],),
    table.hline(),
    [$[ [ 72 , 12 , 6 ] ]$], [$x^6 , y^6$], [$p^2 , q^3 , r^2 , s^3$], [$q , s$], [4],
    [$[ [ 90 , 8 , 10 ] ]$], [$x^15 , y^3$], [$p^3 , q^5 , r^3$], [$p , q , q^2 , r$], [6],
    [$[ [ 108 , 8 , 10 ] ]$], [$x^9 , y^6$], [$p^9 , q^2 , r^3$], [$p , p^3 , p^5 , p^7 , r$], [9],
    [$[ [ 144 , 12 , 12 ] ]$], [$x^12 , y^6$], [$p^4 , q^3 , r^2 , s^3$], [$p , q , s$], [6],
    [$[ [ 288 , 12 , 18 ] ]$], [$x^12 , y^12$], [$p^4 , q^3 , r^4 , s^3$], [$p , q , r , s$], [10],
    [$[ [ 360 , 12 , lt.eq 24 ] ]$], [$x^30 , y^6$], [$p^2 , q^3 , r^5 , s^2 , t^3$], [$q , p s , p s r^2 , p s r^3 , t$], [11],
  )],
  caption: [Table deriving the steps in the circuit implementing the $q(L, alpha) arrow.l.r q(L, alpha^T)$ permutation for the ZX-duality for several codes. The generators of $cal(M)$ are decomposed into generators following the decomposition of finite Abelian groups. Following @fig:duality_implementation B) and C) these generators demand a set of ratios of terms in $A$ or $B$ which define fault tolerantly implementable exchanges of qubits with corresponding labels. The result is a decomposition of $q(L, alpha) arrow.l.r q(L, alpha^T)$ into a chain $q(L, alpha) arrow.l.r q(L, alpha') arrow.l.r q(L, alpha'') arrow.l.r dots arrow.l.r q(L, alpha^T)$ with length as shown (counting the number of arrows, $arrow.l.r$). Note the special implementation of the ratios in the $[ [ 360, 12, lt.eq 24 ] ]$ code: the ratios $r^2, r^3$ are not implementable, but $p s r^2, p s r^3$ are. This is fine if we can also perform the $p s$ ratio on its own to remove the additional transformation on some of the qubits.],
  kind: table,
  ) <table:duality_implementations>
]

== Logical Measurements
<ssec:logical_measurements>

// [figvision] imgs/dual_ancilla.png
// Two labelled parts describing the ancilla systems (conventions: blue L, orange R,
// pink X squares, teal Z squares).
// (A) "Topology for each Ancilla System Layer": left, "Full 'A' wheel" - a dotted circle
//     through alternating R/Z/L/X nodes with a central square arrangement, arrows down
//     to the label Z(h^T,g^T) and to X(f,0); right, "Full 'B' wheel" - the same nodes on
//     a solid circle with a different colour pattern, also mapping to Z(h^T,g^T) and
//     X(f,0). Below each wheel the corresponding expanded node-link graph is drawn (two
//     disconnected star/loop components), showing which layers form the Z and X
//     stabilizers.
// (B) "Implementation of Ancilla Systems in Thickness-2": a tall vertical bar labelled
//     "Surface Code" at the left, connected by horizontal grey lines (grey dots mark the
//     periodic continuation) to a stack of concentric dotted circles (left) or solid
//     circles (right) carrying the same L/R/X/Z nodes. The concentric rings realise the
//     two ancilla layers around the code patch, with a central pink X square and the
//     surrounding node pattern repeated ring by ring.
#figure(placement: top, image("imgs/dual_ancilla.png", width: 90.0%),
  caption: [
    of the thickness-2 property of the Tanner graph of BB LDPC codes. A) Planar embedding of each layer of the ancilla system from ~C) via truncating the 'A' and 'B' wheels. B) Implementation of the graph from ~C) within thickness-2 by nesting wheels. Wheels corresponding to $X ( f , 0 )$ are placed on the outside and wheels corresponding to $Z ( h^T , g^T )$ are placed on the inside. The $X ( f , 0 )$ system can be connected to a surface code in the 'A' plane. Here we only show one layer per system, but this construction can be repeated for arbitrarily many layers.
  ]
)

<fig:ancilla_system>

In this section we describe how to leverage methods from @cohen2022lowoverhead to implement fault-tolerant measurements of the operators $macron(X)_1 = X ( f , 0 )$ and $macron(Z)_1 = Z ( h^T , g^T )$. As described above, this capability suffices to measure $macron(X)$ and $macron(Z)$ for all logical qubits. We can also use this technique to measure various Pauli product operators by measuring $macron(X)_alpha , macron(Z)_alpha , macron(X)'_alpha , macron(Z)'_alpha$ for $alpha$ not corresponding to logical qubits.

The measurement is facilitated by an ancilla system that extends the Tanner graph of the original code. The code defined by this extended Tanner graph contains the logical operator of interest as a stabilizer, enabling its fault tolerant measurement. A sketch of the structure of this ancilla system is given in ~C). For the logical operator $X ( f , 0 )$, we consider a subgraph of the Tanner graph consisting of $q ( L , f )$ as well as $q ( Z , alpha )$ operators corresponding to checks with support on $q ( L , f )$. Similarly for the logical operator $Z ( h^T , g^T )$ we consider a subgraph consisting of $q ( L , h^T ) , q ( R , g^T )$ as well as $q ( X , alpha )$ for the relevant $alpha$. These subgraphs are copied several times and are connected together as shown in the figure: we call the resulting construction an ancilla system. With enough copies, the code defined by the extended Tanner graph has the same distance as the original code.

Furthermore, the ancilla system for measuring $X ( f , 0 )$ can be connected to another quantum error correction code, such as a surface code. This enables a joint $macron(X) macron(X)$ measurement between a surface code qubit and any qubit within the BB code. A subsequent measurement of $Z ( h^T , g^T )$ and some additional Pauli corrections then achieves a quantum teleportation circuit.

The main challenge of implementing these ancilla systems, in addition to minimizing their size, is to show that the extended Tanner graph satisfies the thickness-2 constraint. If our goal is to leverage the $X ( f , 0 )$ ancilla system to measure a Pauli product measurement with a surface code qubit, then arguably a thickness-2 extension of the Tanner graph does not suffice since there is no obvious way of connecting it to the surface code qubit as in ~C). To this end, we show how to make the subgraph corresponding to the $X ( f , 0 )$ ancilla system "effectively planar": while the graph has thickness-2, the planar graph in one plane consists entirely of connected components with two vertices. Given this property of the embedding of the $X ( f , 0 )$ ancilla system, a connection between this system and a surface code may be facilitated by a construction that is thickness-2 overall.

An effectively planar embedding of the ancilla system relies on the fact that the logical operator $X ( f , 0 )$ has no support on the $q ( R )$ block. An implementation of more general logical operators is possible, but would require a graph that renders many ancilla qubits inaccessible from the outside.

The ancilla system is constructed out of copies of 'primal layers' isomorphic to $cal(G)_(macron(X))$, and 'dual layers' isomorphic to $cal(G)_(macron(X))^T := ( V_(macron(X))^T , C_(macron(X))^T , E_(macron(X))^T )$ defined as follows: each $v in V_(macron(X))$ has a corresponding $v^T in C_(macron(X))^T$, each $c in C_(macron(X))$ has a corresponding $c^T in V_(macron(X))^T$, and each edge $( v , c ) in E_(macron(X))$ has a corresponding $( v^T , c^T ) in E_(macron(X))^T$. For some parameter $r$, the final Tanner graph is that of the BB code, plus $r$ additional copies of the dual graph labeled $cal(G)_(macron(X))^T [ j ]$ for $1 lt.eq j lt.eq r$, and $r - 1$ additional copies of the primal graph labeled $cal(G)_(macron(X)) [ j ]$ for $2 lt.eq j lt.eq r$. We regard the $cal(G)_(macron(X))$ within the original code as $cal(G)_(macron(X)) [ 1 ]$. We also add additional connections between $cal(G)_(macron(X)) [ j ]$ and $cal(G)_(macron(X))^T [ j ]$ for $j lt.eq r$, as well as $cal(G)_(macron(X))^T [ j ]$ and $cal(G)_(macron(X)) [ j + 1 ]$ for $j < r$: specifically, we connect the associated pairs of $v , v^T$ and $c , c^T$.

It is shown by @cohen2022lowoverhead that the resulting Tanner graph defines an error correction code of distance $d$ when $r = d$. We construct two such ancilla systems: one for $X := X(f,0)$ and one for $Z := Z(h^T,g^T)$.  f\_polys shows a choice of $f,g,h$ for the $[[144,12,12]]$ code, defining $X(f,0)$ and $Z(h^T,g^T)$ such that these operators are all minimum weight, and define $G_ X$ and $G_ Z$ with 30 qubits each.  To achieve $d = 12$ we hence require $2 30 (2d-1) = 1380$ additional qubits. We suspect that significantly more efficient variations of this constructions are possible, but leave their development for future work.

The construction presented above is complicated by the fact that vertices in the Tanner graph take on alternating roles in each layer: in the primal layers the vertices $v$ are physical qubits, whereas in the dual layers the $v^T$ are checks. However, for the purposes of giving a thickness-2 decomposition we need not concern ourselves with this. If we do not distinguish between checks and physical qubits, then the primal layers $cal(G)_(cal(X))$ and dual layers $cal(G)_(cal(X))^T$ have isomorphic Tanner graphs. Hence, for the purposes of the following, we view all layers as identical.

thickness-2 embedding of the $Z ( h^T , g^T )$ ancilla system, and an effectively planar embedding of the $X ( f , 0 )$ ancilla system is possible. This argument is best understood in reference to @fig:ancilla_system . We begin by understanding the thickness-2 decomposition of each layer of the ancilla systems, leveraging @fig:wheel_extraction . In A), we can see that the $Z ( h^T , g^T )$ system decomposes into 'hairy rings' in both the 'A' plane and the 'B' plane since it has no support on $q ( Z )$. the $X ( f , 0 )$ system is a collection of connected pairs in the 'A' plane and collection of rings in the 'B' plane, since it has no support on $q ( X )$.

B) shows how to connect several layers of the two ancilla systems to both the wheel graphs of the BB code, and also an ancillary surface code. We arrange the wheels of the BB code such that $q ( X ) , q ( L )$ are on the inside of the 'A' wheels, and that $q ( X ) , q ( R )$ are on the inside of the 'B' wheels. of the $Z ( h^T , g^T )$ system can be repeatedly nested inside of the wheels of the BB code. The $q ( L )$ qubits can be connected together on the 'A' plane, and the $q ( R )$ and $q ( X )$ qubits can be connected on the 'B' plane. As for $X ( f , 0 )$ system, the rings in the 'B' plane can be wrapped around the wheels of the BB code which already allows connection of the required $q ( L )$ and $q ( Z )$ qubits. This leaves the pairs of connected qubits in the 'A' plane completely free of any connections between the layers, making them available to be connected to a surface code system.

= Conclusion
<sec:conclusions>

In summary, we offered a new perspective on how a fault-tolerant quantum memory could be realized using near-term quantum processors with a small qubit overhead. Our approach complements a concatenation-based scheme by Pattison, Krishna, and Preskill ~@pattison2023hierarchical where each data qubit of a high-rate LDPC code is additionally encoded by the surface code. Although the concatenation approach makes use of the high error threshold of the surface code and its geometric locality to address quantum hardware limitations such as a relatively high noise rate and limited qubit connectivity, the additional surface code encoding incurs a significant qubit overhead, partially negating the advantages offered by LDPC codes. Here we have shown that the concatenation step can be avoided by introducing examples of high-rate LDPC codes which have nearly the same error threshold as the surface code itself. Although these LDPC codes are not geometrically local, qubit connectivity required for syndrome measurements is described by a thickness-two graph which can be implemented using two planar degree-3 layers of qubit couplers. This is a valid architectural solution for platforms based on superconducting qubits. Numerical simulations performed for the circuit-based noise model indicate that the proposed LDPC codes compare favorably with the surface code in the practically relevant range of error rates $p gt.eq 0.1 "%"$ offering the same level of error suppression with nearly 15 $"x"$ reduction in the qubit overhead.

The key hardware challenges to enable the new codes with superconducting qubits are:

+ the development of a low-loss second layer,

+ the development of qubits that can be coupled to 7 connections (6 buses and 1 control line), and

+ the development of long-range couplers.

These are all difficult to solve but not impossible. For the first challenge, we can imagine a small change to the packaging @bravyi2022future which was developed for the IBM Quantum Eagle processor @chow2021. The simplest would be to place the extra buses on the opposite side of the qubit chip. This would require the development of high Q through substrate vias (TSV) which would be part of the coupling buses and as such would require intensive microwave simulation to make sure these TSVs could support microwave propagation while not introducing large unwanted crosstalk.

The second challenge is an extension of the number of couplers from the heavy hex lattice arrangement @Nation2021 which is 4 (3 couplers and 1 control) to 7. The implication of this is that the cross-resonance gate, which has been the core gate used in large quantum systems for the past few years, would not be the path forward. This is due to the fact that the qubits in the cross-resonance gate are not tunable and as such for a large device with a large number of connections the probability of energy collisions (not just the qubit levels but also higher levels of the transmon) trends to one very fast @Hertzberg2021. This is because of frequency requirements for the gate to work properly and intrinsic device variability, which is fundamental to Josephson junction fabrication. However, with the tunable coupler @PhysRevApplied.6.064007 @PhysRevLett.127.080505, which was used in the IBM Quantum Egret and is now being developed for the IBM Quantum Heron, this problem no longer exists as the qubits can be designed to be further apart. This new gate is also similar to the gates used by Google Quantum AI @Arute2019, which have shown that a square lattice arrangement is possible. Extending the coupling map to 7 connections will require significant microwave modeling; however, typical transmons have about 60fF of capacitance and each gate is around 5fF to get the appropriate coupling strengths to the buses, so it is fundamentally possible to develop this coupling map without changing the properties of the transmon qubits which have been shown to have larger coherence and are stable.

The final challenge is the most difficult. For the buses that are short enough so that the fundamental mode can be used the standard circuit QED model holds. However, to demonstrate the 144-qubit code some of the buses will be long enough that we will require frequency engineering. One way to achieve this is with filtering resonators, and a proof of principle experiment was demonstrated in Ref.@McKay2015.

Our work leaves several open questions concerning BB LDPC codes and their applications.

+ What are the tradeoffs between the code parameters $n , k , d$ and can one achieve a constant non-zero encoding rate and a growing distance?

+ Are there more general LDPC codes compatible with our syndrome measurement circuit(s)? We expect that the same circuit applies to any two-block LDPC code based on an Abelian group~@lin2023quantum @wang2023abelian. However, our circuit analysis breaks down for non-Abelian groups.

+ Our work gives a depth-7 syndrome measurement circuit, as measured by the number of $sans("CNOT")$ layers. Is it possible to reduce the circuit depth? Numerical experiments performed for the code $[ [ 72 , 12 , 6 ] ]$ indicate that this code may have no depth-6 syndrome measurement (SM) circuit@AlexanderPrivateComm.

We observed that a depth-7 SM circuit is not unique. A natural next step is identifying a SM circuit that works best for a particular code. In addition, it may be possible to improve the circuit-level distance by using different SM circuits in different syndrome cycles. Even though some low-weight fault paths are not detectable by any single circuit, such fault paths may be detected if two circuits are used in tandem.

How much would the error threshold change for a noise biased towards measurement errors? Note that measurements are the dominant source of noise for superconducting qubits. Since the considered BB codes have a highly redundant set of check operators, one may expect that they offer extra protection against measurement errors.

The general-purpose BP-OSD decoder used here may not be fast enough to perform error correction in real time. Is there a faster decoder making use of the special structure of BB codes?

How to apply logical gates? While our work gives a fault-tolerant implementation of certain logical gates, these ga

tes offer very limited computational power and are primarily useful for implementing memory capabilities.

#heading(level: 1, numbering: none)[Acknowledgements]
<acknowledgements>
The authors thank Ben Brown, Oliver Dial, Alexander Ivrii, Tomas Jochym-O'Connor, Yunseong Nam, Matthias Steffen, Kevin Tien, and John Blue for stimulating discussions at various stages of this project. The authors acknowledge the IBM Research Cognitive Computing Cluster service for providing resources that have contributed to the research results reported within this paper.

#bibliography("refs.bib", style: "ieee", title: [References])
