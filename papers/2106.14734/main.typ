#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.86cm, bottom: 2.38cm), columns: 2)
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
#set par(justify: true, spacing: 0.49em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.49em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)

#place(top + center, scope: "parent", float: true)[
#align(center)[
  #text(12pt, weight: "bold", [Strong quantum computational advantage using a superconducting quantum processor])   #v(1.2em)
  #text(10.5pt)[Yulin Wu#super[1], Wan-Su Bao#super[4], Sirui Cao#super[1], Fusheng Chen#super[1], Ming-Cheng Chen#super[1], Xiawei Chen#super[2], Tung-Hsun Chung#super[1], Hui Deng#super[1], Yajie Du#super[2], Daojin Fan#super[1], Ming Gong#super[1], Cheng Guo#super[1], Chu Guo#super[1], Shaojun Guo#super[1], Lianchen Han#super[1], Linyin Hong#super[5], He-Liang Huang#super[1], Yong-Heng Huo#super[1], Liping Li#super[2], Na Li#super[1], Shaowei Li#super[1], Yuan Li#super[1], Futian Liang#super[1], Chun Lin#super[6], Jin Lin#super[1], Haoran Qian#super[1], Dan Qiao#super[2], Hao Rong#super[1], Hong Su#super[1], Lihua Sun#super[1], Liangyuan Wang#super[2], Shiyu Wang#super[1], Dachao Wu#super[1], Yu Xu#super[1], Kai Yan#super[2], Weifeng Yang#super[5], Yang Yang#super[2], Yangsen Ye#super[1], Jianghan Yin#super[2], Chong Ying#super[1], Jiale Yu#super[1], Chen Zha#super[1], Cha Zhang#super[1], Haibin Zhang#super[2], Kaili Zhang#super[1], Yiming Zhang#super[1], Han Zhao#super[2], Youwei Zhao#super[1], Liang Zhou#super[5], Qingling Zhu#super[1], Chao-Yang Lu#super[1], Cheng-Zhi Peng#super[1], Xiaobo Zhu#super[1], Jian-Wei Pan#super[1]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Hefei National Laboratory for Physical Sciences at the Microscale and Department of Modern Physics, University of Science and Technology of China, Hefei 230026, China] \
  #text(9pt)[#super[2] Shanghai Branch, CAS Center for Excellence in Quantum Information and Quantum Physics, University of Science and Technology of China, Shanghai 201315, China] \
  #text(9pt)[#super[3] Shanghai Research Center for Quantum Sciences, Shanghai 201315, China] \
  #text(9pt)[#super[4] Henan Key Laboratory of Quantum Information and Cryptography, Zhengzhou 450000, China] \
  #text(9pt)[#super[5] QuantumCTek Co., Ltd., Hefei 230026, China] \
  #text(9pt)[#super[6] Shanghai Institute of Technical Physics, Chinese Academy of Sciences, Shanghai 200083, China] \
]
#v(1.2em)
]

#v(0.8em)
// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: June 29, 2021)]]

#align(center)[#text(9pt, weight: "bold")[#smallcaps[Abstract]]]

Scaling up to a large number of qubits with high-precision control is essential in the demonstrations of quantum computational advantage to exponentially outpace the classical hardware and algorithmic improvements. Here, we develop a two-dimensional programmable superconducting quantum processor, #emph[Zuchongzhi], which is composed of 66 functional qubits in a tunable coupling architecture. To characterize the performance of the whole system, we perform random quantum circuits sampling for benchmarking, up to a system size of 56 qubits and 20 cycles. The computational cost of the classical simulation of this task is estimated to be 2-3 orders of magnitude higher than the previous work on 53-qubit Sycamore processor \[Nature #strong[574], 505 (2019)\]. We estimate that the sampling task finished by #emph[Zuchongzhi] in about 1.2 hours will take the most powerful supercomputer at least 8 years. Our work establishes an unambiguous quantum computational advantage that is infeasible for classical computation in a reasonable amount of time. The high-precision and programmable quantum computing platform opens a new door to explore novel many-body phenomena and implement complex quantum algorithms.





= INTRODUCTION
<introduction>
In the past years, encouraging progress has been made in the physical realizations of quantum computers~@bruzewicz2019trapped @huang2020superconducting @slussarenko2019photonic @gong2021quantum, indicating a transition of quantum computing from a theoretical picture to a nascent technology. A major milestone along the way is the demonstration of quantum computational advantage, which is also known as quantum supremacy. It is defined by a quantum device that can implement a well-defined task overwhelmingly faster than any classical computer to an extent that no classical computer can complete the task within a reasonable amount of time.


To this end, recent experiments using 53 superconducting qubits and 76 photons have provided strong evidence to demonstrate the quantum computational advantage and subsequently disprove the extended Church-Turing thesis~@aaronson2011computational @boixo2018characterizing @bouland2019complexity @aaronson2016complexity. Due to continuous improvements in the classical algorithm and hardware ~@pednault2019leveraging @HuangChen2020 @pan2021simulating to compete the quantum computers, the demonstration of quantum computational advantage is not a single-shot achievement but the quantum hardware has to be upgraded. It should be emphasized that the increase of qubits is expected to exponentially outpace the classical performance.


Simultaneously increasing the number of qubits and high-fidelity quantum logic gates are also crucial for the rapid development of noisy intermediate scale quantum (NISQ) technology~@preskill2018quantum and the demonstration of logic qubit through surface code error correction ~@fowler2012surface @shor1996fault @erhard2021entangling @andersen2020repeated @marques2021logical @chen2021exponential. Indeed, a wide range of near-term applications are being investigated, including quantum chemistry~@google2020hartree @mcardle2020quantum @aspuru2005simulated, quantum many-body physics~@bernien2017probing @zhang2017observation @zhu2021observation @chen2021observation @zha2020ergodic, and quantum machine learning~@huang2020experimental @havlivcek2019supervised @harrigan2021quantum @huang2018demonstration @saggio2021experimental @cong2019quantum.


Scaling up high-fidelity superconducting quantum processors faces major challenges in the chip fabrication and qubit control. In this work, we make progress toward building a larger-scale and high-performance superconducting quantum computing system, named #emph[Zuchongzhi]. The quantum processor is designed and fabricated with a two-dimensional and tunable coupling architecture, which contains a total of 66 qubits. High-fidelity single-qubit gate (average 99.86\%) and two-qubit gate (average 99.41\%), as well as readout (average 95.48\%), are achieved with this processor, while performing simultaneous gate operations on multiple qubits. We use random quantum circuit sampling~@boixo2018characterizing as a metric to evaluate the overall power of the quantum processor. Experimental results show that our processor is able to complete the sampling task with a system size up to 56 qubits and 20 cycles. We estimate that the classical computational overhead to simulate #emph[Zuchongzhi] is 2-3 orders of magnitude higher than the task implemented on Google's 53-qubit Sycamore processor~@arute2019quantum. Therefore, our experiment unambiguously established a computational task that can be completed by a quantum computer in 1.2 hours but will take at least an unreasonable time for any supercomputers.


= HIGH-PERFORMANCE QUANTUM PROCESSOR
<high-performance-quantum-processor>


The #emph[Zuchongzhi] quantum processor consists of 66 qubits, arrayed in 11 rows and 6 columns forming a two dimensional rectangular lattice pattern as depicted in the device schematic in @fig1\(a). The quantum processor uses Transmon qubits~@koch:042319, which are essentially non-linear oscillators with their non-linearity originating from superconducting Josephson effect. The lowest two energy levels of the non-linear oscillator are singled out to form the computational space of a qubit, encoded as $| 0 chevron.r$ and $| 1 chevron.r$. Each qubit has two control lines to provide full control of the qubit: a microwave drive line to drive excitations between $| 0 chevron.r$ and $| 1 chevron.r$, and a magnetic flux bias line to tune the qubit resonance frequency. Each qubit, except those at the boundaries, has four tunable couplers to couple to its nearest neighbors~@yysCouplerCZ, with tunable coupling that can be turned on and off with fast control.


The tunable couplers are also Transmon qubits (@fig1\(b)), with frequencies several GHz higher than that of the data qubits and always stays at ground states ~@yan2018tunable. A magnetic flux bias line is provided for each coupler to fast tune the coupling strength $g$ between neighboring qubits continually from $tilde + 5 med upright("MHz")$ to $tilde - 50 med upright("MHz")$.


Each qubit dispersively couples to a readout resonator which couples to a Purcell filter shared between six qubits, frequency multiplexing~@ISI:000243867300038 @PhysRevLett.112.190504 is used to readout the qubit states simultaneously.


All the quantum circuit components of our quantum processor are fabricated on two separate sapphire chips, which are then stacked together with the indium bump flip-chip technique. The quantum processor chip is wire bounded to a circuit board, mounted into a well shielded cryostat, and connected to room temperature control electronics through various microwave components in the wiring.


All the 66 qubits and 110 couplers on the quantum processor function properly. Rough calibration results for all these 66 qubits, including their decoherence time $T_1$ (average 30.6$mu$s at idle frequencies), single-qubit gate (average 99.86\%), two-qubit gate (average 99.24\%), readout (average 95.23\%), are provided in the Supplemental Material. In this work, we select 56 qubits to demonstrate the random circuit sampling, which are optimized to achieve an optimal computational complexity in the classical simulation.


// [figvision] imgs/fig1.png
// Panel (a) presents a 3D schematic rendering of the Zuchongzhi quantum processor assembly. It depicts two
// rectangular sapphire chips stacked vertically and aligned. The bottom chip is dark blue, featuring intricate
// gold-colored circuit traces radiating from the center toward the edges, with Chinese characters inscribed on
// the left surface. Small gold bumps protrude from its top surface to connect with the upper layer. The top chip
// is translucent cyan, revealing an internal grid structure representing qubits and couplers. A circular
// university logo is visible on the right side of the base chip. This layout illustrates the physical
// integration of the qubit array and control electronics via indium bump bonding. Panel (b) displays a
// simplified logical diagram of the qubit lattice and a corresponding electrical circuit. On the left, a grid of
// plus signs represents the qubit arrangement, where gray rectangles between them indicate couplers. A dashed
// box highlights a central unit cell containing two qubits and one coupler. Dotted lines connect this cell to a
// detailed circuit schematic on the right enclosed in a dashed border. The schematic shows three parallel
// vertical branches labeled Qubit 1, Coupler, and Qubit 2. Each branch contains capacitors and Josephson
// junctions symbolized by X marks within boxes, illustrating the superconducting components and their
// connectivity for tunable coupling.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure([#block[
  #box(image("imgs/fig1.png", width: 100%))
  ]],
  caption: [
    #strong[Device schematic of the #emph[Zuchongzhi] quantum processor.] (a) The #emph[Zuchongzhi] quantum processor consists of two saphire chips. One carries 66 qubits and 110 couplers, and each qubit couples to four neighboring qubits except those at the boundaries. The other hosts the readout components and control lines as well as wiring. These two chips are aligned and bounded together with indium bumps. (b) Simplified circuit schematic of the qubit and coupler.
  ]
)
<fig1>



We start by calibrating the single-qubit gates. Single-qubit gates are implemented with radio-frequency (RF) pulses as the qubit frequencies are in the range of 4-6 GHz. Coherent RF pulses resonant with the qubit frequency are fed to the qubits through the microwave control lines to excite the qubits. Pulse shaping is calibrated to prevent leakage outside of the computational space~@PhysRevLett.103.110501. To enable parallel execution of gates, all the couplers are turned off when single-qubit gates are applied to isolate each qubit. Single-qubit gate performance is susceptible to a number of conditions like coupling to two-level system (TLS), coupling to microwave resonance, microwave crosstalk and residual coupling between qubits. These conditions are mostly qubit frequency dependent, we use an error model to account for a bucket of gate error sources and learn an optimal qubit frequency configuration for all qubits through an optimization process. With the optimal qubit frequency configuration, we are able to obtain high performance single-qubit gates for all qubits. We use parallel cross-entropy benchmarking (XEB)~@boixo2018characterizing @Neill195 to benchmark single-qubit gate performance. Results show an average single-qubit gate pauli error $e_1$ of $0.14 "%"$ when gates are applied simultaneously (@fig2\(a)).


// [figvision] imgs/fig2.png
// Panel (a) is a heatmap showing single-qubit gate Pauli error rates for 56 qubits. The layout consists of
// rectangular cells arranged in an irregular grid pattern, with each cell containing a numerical value
// representing the percentage error. A vertical color bar on the right maps values from blue at 0.1% to red at
// 0.25%. Most errors are below 0.18%, but two cells show 0.27%. Text at the bottom states the average error e1
// is 0.14%. Panel (b) displays a heatmap of qubit state readout error percentages for the same 56 qubits. The
// grid structure mirrors panel (a). Numerical values inside the cells range from 1.34% to 9.92%. The
// accompanying color scale runs from blue at 2% to red at 8%, though the highest value exceeds this range. One
// cell shows a distinct peak of 9.92%. The caption indicates an average readout error er of 4.52%. Panel (c)
// presents a heatmap of two-qubit gate Pauli error rates for 94 couplers. The grid is larger and denser than the
// previous panels. Values range from 0.29% to 1.25%. The color bar spans from blue at 0.3% to red at 1.1%. While
// most couplers have low errors under 0.6%, specific cells highlight higher values like 1.25% and 1.14%. The
// text notes an average error e2 of 0.59%.
#figure([#block[
  #box(image("imgs/fig2.png", width: 100%))
  ]],
  caption: [
    #strong[Single-qubit gate, two-qubit gate and readout performance of the selected 56 qubits.] Single-qubit gate pauli error $e_1$ (a), qubit state readout error $e_r$ (b) and two qubit gate pauli error $e_e$ (c) of the 56 qubits and the 94 couplers used in the random circuit sampling task. The values are provided for all qubits operating simultaneously. See Supplemental Material for the rough calibration results of all 66 qubits and 110 couplers.
  ]
)
<fig2>



For the random circuit sampling task, iSWAP-like gate~@arute2019quantum is used as the two-qubit gate. We bias neighboring qubits into resonance and turn on a coupling of $g tilde 10 med upright("MHz")$ for a time duration $tilde 32 "ns"$, which introduces swap between the qubits, as well as controlled phase interaction and single qubit phase accumulations. All these effects can be modeled as the following unitary#cite(<arute2019quantum>):


$ mat(delim: "[", 1, 0, 0, 0; 0, e^(i ( Delta_(+) + Delta_(-) )) upright("cos") theta, - i e^(i ( Delta_(+) - Delta_(- , upright("off")) )) upright("sin") theta, 0; 0, - i e^(i ( Delta_(+) + Delta_(- , upright("off")) )) upright("sin") theta, e^(i ( Delta_(+) - Delta_(-) )) upright("cos") theta, 0; 0, 0, 0, e^(i ( 2 Delta_(+) - phi.alt ))) $


Parallel XEB is also employed to benchmark the iSWAP-like gate performance, an optimization process is used to learn the five parameters $theta , phi.alt , Delta_(+) , Delta_(-)$ and $Delta_(- , upright("off"))$ by maximizing the XEB fidelities. The length of the flux bias pulses are chosen to minimize leakage to higher energy levels, pulse distortion and timing are carefully calibrated. The qubit frequencies at which two-qubit gates are performed are also optimized following a similar procedure as setting the single-qubit operation frequencies to mitigate the influences of TLS, crosstalk and pulse distortion on gate performance. Average two-qubit gate pauli error $e_2$ of our processor is $0.59 "%"$ when all gates are applied simultaneously (@fig2\(c)).


To optimize readout fidelity and reduce readout crosstalk, a different frequency setting for the qubits and couplers is used when performing readout. We calibrate the readout fidelities by preparing all qubits at $| 0 chevron.r ( | 1 chevron.r )$ and count the events of successfully identify the readout result as $| 0 chevron.r ( | 1 chevron.r )$. The average single-qubit state readout error of our processor is $4.52 "%"$ (@fig2\(b)). We also compare the fidelity results with that obtained from preparing the qubits in random bit strings as a sanity check, see Suplementary Material for details.

= RANDOM QUANTUM CIRCUIT BENCHMARKING
<random-quantum-circuit-benchmarking>


// [figvision] imgs/main_3.png
// This figure illustrates the architecture of a 56-qubit random quantum circuit, divided into three distinct
// sections: a lattice topology map, a legend defining gate types, and a temporal circuit diagram. Panel (a)
// displays the qubit connectivity as a diamond-shaped grid graph. The active hardware consists of 56 nodes,
// numbered 1 through 64 with specific gaps, depicted as solid black or blue circles containing white numerals.
// Inactive or boundary nodes are shown in faint pink. These nodes are interconnected by colored lines
// representing two-qubit interaction channels. The connections form a diagonal mesh where orange, blue, green,
// and red links crisscross between adjacent qubits. A translucent orange box highlights a four-qubit cluster
// near the bottom center to indicate the local region expanded in the lower panel. Panel (b) serves as a
// schematic legend located on the right side. It defines the components used in the circuit. The top section,
// labeled Single-Qubit Gate, shows a blue rectangle branching into three options: square-root X, square-root Y,
// and W gates, indicating these are selected randomly. The bottom section, Two-Qubit Gate, visualizes four
// distinct interaction patterns labeled A, B, C, and D. These are represented as thick vertical bars in orange,
// blue, green, and dark red respectively, corresponding to the link colors in the main lattice. Panel (c)
// presents a quantum circuit diagram detailing the temporal sequence of operations for the highlighted
// four-qubit subset. Four horizontal black lines represent the qubit timelines progressing from left to right.
// The process is divided into discrete time steps called cycles, marked by dashed brackets. Each cycle comprises
// a layer of single-qubit gates, shown as light blue rectangles, followed by layers of two-qubit gates. The
// two-qubit gates appear as thick vertical bars connecting pairs of lines, matching the colors defined in the
// legend. The sequence follows a specific pattern of interactions before concluding at cycle m with measurement
// symbols.
#figure([#block[
  #box(image("imgs/main_3.png", width: 100%))
  ]],
  caption: [
    #strong[56-qubit random quantum circuit operations.] The circuit can be divided into $m$ cycles, and each cycle has a layer of single-qubit gates and two-qubit gates. The single-qubit gates are chosen randomly from the set of $( sqrt(X) , sqrt(Y) , sqrt(W) )$, while the two-qubit gates are chosen from the patterns of A, B, C, and D in the sequence of ABCDCDAB. The circles in the upper left corner of the diagram represent qubits, and the discarded qubits are marked with a shaded colour. The orange, blue, green, and red lines represent the two-qubit gates of the four patterns A, B, C, and D respectively.
  ]
)
<main_3>




// [figvision] imgs/fig4.png
// Panel (a) is a scatter plot showing fidelity versus the number of qubits on logarithmic and linear scales
// respectively. The x-axis ranges from 15 to 60 qubits, while the y-axis spans 10^{-4} to 10^0. Three
// experimental datasets are plotted: full circuit results as green plus signs, elided circuit as blue crosses,
// and patch circuit as red circles. All data points cluster tightly around a solid black line representing the
// estimated fidelity, which decreases exponentially as qubit count increases. An inset schematic at the bottom
// illustrates the three circuit types using hexagonal lattice diagrams with colored nodes indicating different
// gate layers or regions. Panel (b) displays fidelity against cycle depth, with the x-axis ranging from 12 to 20
// cycles and the y-axis on a log scale from 10^{-4} to 10^{-2}. Experimental data for elided circuits appear as
// blue filled circles with vertical error bars, closely following a downward-sloping black line that represents
// the estimated fidelity trend. A shaded orange band labeled “estimated ± σ” indicates one standard deviation
// uncertainty around the prediction. An inset in the upper right corner zooms into the region near 10^{-3}
// fidelity, highlighting how the blue data points fluctuate within the predicted bounds across multiple cycle
// depths.
#figure(
  image("imgs/fig4.png", width: 100%),
  caption: [
    #strong[Experimental results of random quantum circuits.] (a) Results of random quantum circuits with 15-56 qubits and 10 cycles. Each data point, including the results from full circuit, patch circuit, and elided circuit, is an average over six quantum circuit instances. The predicted fidelity result is shown as a black line, which is determined by the product of three types of errors, single-qubit error, two-qubit gate error and readout error. The results from the patch and elided circuits can be in good agreement with the results of the full circuit. (b) Results of random quantum circuits with 56 qubits and 12-20 cycles. For each cycle, we have sampled ten distinct random quantum circuit instances for patch, elided and full circuits. We calculate the average fidelity of the patch and elided circuits as an estimation of the fidelity of the full circuit. The error bar denotes three standard deviations.
  ]
)
<fig4>

It cost about 230s to sampling 1 million bitstrings. For each 56-qubit 20-cycle circuit instance, about 19 million bitstrings are sampled in 1.2 hours and the XEB fidelity is shown in the inset. The averaged XEB fidelity of 56-qubit 20-cycle circuit over ten instances is $( 6.62 plus.minus 0.72 ) times 10^(- 4)$.


To characterize the overall performance of the quantum processor, we employ the task of random quantum circuit sampling for benchmarking. Random quantum circuit is outstanding candidate to demonstrate quantum computational advantages,


and has potential applications in certified random bits~@aaronson2018certified, error correction~@gullans2020quantum, and hydrodynamics simulation~@richter2020simulating.


Figure~#ref(<main_3>, supplement: none) shows the gate sequence of our random quantum circuit. Each random quantum circuit is composed of $m$ cycles, and each cycle is composed of a single-qubit gate layer and a two-qubit gate layer. In the single-qubit gate layer, single-qubit gates are applied on all qubits and chosen randomly from the set of $( sqrt(X) , sqrt(Y) , sqrt(W) )$, where $sqrt(X) upright(=) R_X ( pi / 2 )$, $sqrt(Y) upright(=) R_Y ( pi / 2 )$, and $sqrt(W) upright(=) R_(( X + Y )) ( pi / 2 )$ are $pi / 2$-rotation around specific axis. Each single-qubit gate on a qubit in subsequent cycle is independently and randomly chosen from the subset of $( sqrt(X) , sqrt(Y) , sqrt(W) )$, which does not include the single-qubit gate to this qubit in the preceding cycle. In the two-qubit gate layer, two-qubit gates are applied according to a specified pattern, labeled by A, B, C, and D, in sequence of ABCDCDAB. Finally, an additional single-qubit gate layer is applied after $m$ cycles and before measurement.


With just a few cycles, the random quantum circuit could generate a highly entangled state.


Two variant circuits, patch circuit and elided circuit, are utilized to estimate the XEB fidelity of quantum circuits within our classical computing capabilities. The “patch” circuits are designed by removing a slice of two-qubit gates, while the “elided” circuits only remove a fraction of the gates between the patches. In this two variant circuits, the amount of entanglement involved is reduced so that it is feasible to classically simulate the experiments and thus determine $F_(upright("XEB"))$. We test the linear XEB fidelities of these two variant circuits and full version of the circuits ranging from 15 qubits to 56 qubits with 10 cycles (see Fig. #ref(<fig4>, supplement: none)\(a)). Over all of these circuits, the fidelities derived from patch and elided circuits are in good agreement with the fidelities obtained with the corresponding full circuits, with average deviations of $tilde 5 "%"$ and $tilde 10 "%"$, respectively, dominated by system fluctuations. The achieved results indicate that patch circuits and elided circuits could used as performance estimators for large systems.


We now turn to test 56-qubit circuits increasingly with more cycles. The output bitstrings of full, patch, and elided circuits from 12 to 20 cycles are all sampled in our experiments. However, the verification of full circuit becomes challenging in this regime due to our limited classical computing resources. Therefore, we use the previously tested patch and elided circuits to assess performance. Figure. #ref(<fig4>, supplement: none)\(b) shows the linear XEB results for patch circuits and elided circuits. For each cycle, a total of ten randomly generated circuit instances are executed and sampled. We collect approximately $1.9 times 10^7$ bitstrings for each 56-qubit circuit with 20 cycles, the fidelities for these ten elided circuits are given in the inset of Fig. #ref(<fig4>, supplement: none)\(b). Each individual circuit instance fidelity is nearly inside the $plus.minus sigma$ statistical error band for a single instance, indicating the stability of the system and the unbiasedness of noise. We then apply inverse-variance weighting over these ten random circuits, yielding $F = ( 6.62 plus.minus 0.72 ) times 10^(- 4)$ for the combined linear XEB fidelity of the 56-qubit 20-cycle circuit. The null hypothesis of uniform sampling ($F = 0$) is thus rejected with a significance of $9 sigma$.


In addition, the observed fidelity of each circuit, as well as the decay of XEB fidelities with qubits $n$ and cycles $m$, match the predicted fidelity calculated from a simple multiplication of individual operations quite well.


This result provides convincing evidence to confirm the low correlation of errors of each individual operation, including single- and two-qubit gates, as well as readout, which is a critical aspect for quantum error correction.


= COMPUTATIONAL COST ESTIMATION
<computational-cost-estimation>


We finally estimate the classical computational cost of our hardest circuits, i.e. 56-qubit random quantum circuit with 20 cycles. The estimation is based on two types of classical algorithms which are considered state-of-the-art for classically simulating quantum circuits, namely tensor network algorithm and the Schr$dot.double(upright("o"))$dinger-Feynman algorithm.


Tensor network algorithm reduces the problem of computing amplitudes into contracting tensor networks. It is a single-amplitude algorithm in that the complexity grows linearly with the number of amplitudes, which has been shown to perform excelently for relatively shallow quantum circuits~@MarkovShi2008 @GuoWu2019 @VillalongaMandra2019 @villalonga2020establishing @HuangChen2020 @pan2021simulating @guo2021verifying. The computational cost of tensor networks algorithms is determined by the tensor contract path. To identify an optimal tensor contract path, we use the python package cotengra~@cotengra, which has been shown to be capable of reproducing state-of-the-art results in Ref.~@HuangChen2020 @pan2021simulating. The number of floating point operations to generate one perfect sample from the $53$-qubit 20-cycle random circuit used in Ref.~@arute2019quantum and our 56-qubit and 20-cycle random circuit are thus estimated as $1.63 times 10^18$ and $1.65 times 10^20$, respectively. Given that $3 times 10^6$ samples were collected over one circuit instance with $0.224 "%"$ fidelity in Ref.~@arute2019quantum, while we have collected $1.9 times 10^7$ samples with $0.0662 "%"$ fidelity, so theoretically it would cost a total of $1.10 times 10^22$ and $2.08 times 10^24$ floating point operations, respectively, to reproduce the same results as Ref.~@arute2019quantum and our work using classical computer (see Supplemental Material for details).


In comparison, the Schr$dot.double(upright("o"))$dinger-Feynman algorithm is a full-amplitude algorithm in that computing an arbitrarily chosen branch of amplitudes is almost as hard as computing a single amplitude. Similar to Ref.~@arute2019quantum, we estimate that it would cost $5.76 times 10^17$ core-hours for the task of simulating 56-qubtit 20-cycle random quantum circuit sampling with $0.0662 "%"$ fidelity using the Schr$dot.double(upright("o"))$dinger-Feynman algorithm, while simulating the previous task on the 53-qubit 20-cycle circuit ($0.224 "%"$ fidelity~@arute2019quantum) would cost $8.90 times 10^13$ core-hours (see Supplemental Material for details).


Therefore, using the tensor network algorithm or Schr$dot.double(upright("o"))$dinger-Feynman algorithm, the classical computational cost of our sample task with 56-qubit and 20-cycle is about 2-3 orders of magnitude greater than that of the previous task with 53-qubit and 20-cycle~@arute2019quantum. This indicates that our work significantly enlarges the gap between the computational advantages of quantum devices and the classical simulations. In particular, as discussed in the Supplemental Material, it is estimated that it will take 15.9 days to simulate the previous sampling task in Ref.~@arute2019quantum using tensor network algorithm on Summit, whereas simulating our sampling task will take 8.2 years. We anticipate the development of more efficient classical simulation approaches. On the one hand, the competition between


quantum and classical computing will continue; on the other hand, more efficient classical simulation methods are necessary for large-scale quantum computing benchmarking.


= CONCLUSION
<sec:summary>


In conclusion, we have reported the design, fabrication, measurement, and benchmarking of a state-of-the-art 66-qubit superconducting quantum processor that is fully programmable through electric control. We are able to achieve high-fidelity logic operations of the full quantum circuit and eliminate the unwanted cross talk. Our experimental results of random quantum circuit with 56 qubits and 20 cycles on #emph[Zuchongzhi] quantum processor established a new record to challenge the classical computing capability. We note that the performance of the whole system behaves as predicted when system size grows from small to large, confirming our high-fidelity quantum operations and low correlated errors on the #emph[Zuchongzhi] processor. The quantum processor has a scalable architecture that is compatible with surface-code error correction, which can act as the test-bed for fault-tolerant quantum computing. We also expect this large-scale, high-performance quantum processor could enable us to pursue valuable NISQ quantum applications beyond classical computers in the near future.


#block[
We thank Run-Ze Liu, Wen Liu, Chenggang Zhou, Pan Zhang, Junjie Wu for very helpful discussions and assistance. The classical calculations were performed on the supercomputing system in the Supercomputing Center of University of Science and Technology of China. The authors thank the USTC Center for Micro- and Nanoscale Research and Fabrication for supporting the sample fabrication. The authors also thank QuantumCTek Co., Ltd., for supporting the fabrication and the maintenance of room-temperature electronics. #strong[Funding:] This research was supported by the National Key R&D Program of China (Grant No. 2017YFA0304300), the Chinese Academy of Sciences, Anhui Initiative in Quantum Information Technologies, Technology Committee of Shanghai Municipality, National Natural Science Foundation of China (Grants No. 11905217, No. 11774326, Grants No. 11905294), Shanghai Municipal Science and Technology Major Project (Grant No. 2019SHZDZX01), Natural Science Foundation of Shanghai (Grant No. 19ZR1462700), Key-Area Research and Development Program of Guangdong Provice (Grant No. 2020B0303030001), and the Youth Talent Lifting Project (Grant No. 2020-JCJQ-QT-030).

]


The authors' names appear in alphabetical order by last name.




#heading(numbering: none)[Acknowledgments]

#{
  show bibliography: set text(size: 9pt)
  bibliography("refs.bib", title: none)
}

#pagebreak()
#counter(heading).update(0)
#counter(math.equation).update(0)
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)
#set heading(numbering: "1.1")
#set figure(numbering: n => "S" + str(n))
#set math.equation(numbering: n => "(S" + str(n) + ")")

// The SM bibliography restarts at [1] in the original (separate revtex bibliography);
// Typst numbers citeproc entries document-wide, so shift the SM range back.
#show regex("\[[0-9]+\]"): m => {
  let n = int(m.text.slice(1, -1))
  if n > 49 { "[" + str(n - 49) + "]" } else { m }
}

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(17pt, weight: "bold", [Supplemental Material for \ "Strong quantum computational advantage using a superconducting quantum processor"])   #v(1.2em)
    #text(10.5pt)[Yulin Wu#super[1], Wan-Su Bao#super[4], Sirui Cao#super[1], Fusheng Chen#super[1], Ming-Cheng Chen#super[1], Xiawei Chen#super[2], Tung-Hsun Chung#super[1], Hui Deng#super[1], Yajie Du#super[2], Daojin Fan#super[1], Ming Gong#super[1], Cheng Guo#super[1], Chu Guo#super[1], Shaojun Guo#super[1], Lianchen Han#super[1], Linyin Hong#super[5], He-Liang Huang#super[1], Yong-Heng Huo#super[1], Liping Li#super[2], Na Li#super[1], Shaowei Li#super[1], Yuan Li#super[1], Futian Liang#super[1], Chun Lin#super[6], Jin Lin#super[1], Haoran Qian#super[1], Dan Qiao#super[2], Hao Rong#super[1], Hong Su#super[1], Lihua Sun#super[1], Liangyuan Wang#super[2], Shiyu Wang#super[1], Dachao Wu#super[1], Yu Xu#super[1], Kai Yan#super[2], Weifeng Yang#super[5], Yang Yang#super[2], Yangsen Ye#super[1], Jianghan Yin#super[2], Chong Ying#super[1], Jiale Yu#super[1], Chen Zha#super[1], Cha Zhang#super[1], Haibin Zhang#super[2], Kaili Zhang#super[1], Yiming Zhang#super[1], Han Zhao#super[2], Youwei Zhao#super[1], Liang Zhou#super[5], Qingling Zhu#super[1], Chao-Yang Lu#super[1], Cheng-Zhi Peng#super[1], Xiaobo Zhu#super[1], Jian-Wei Pan#super[1]]
  
  ]
  #block(spacing: 0.45em)[
    #text(9pt)[#super[1] Hefei National Laboratory for Physical Sciences at the Microscale and Department of Modern Physics, University of Science and Technology of China, Hefei 230026, China] \
    #text(9pt)[#super[2] Shanghai Branch, CAS Center for Excellence in Quantum Information and Quantum Physics, University of Science and Technology of China, Shanghai 201315, China] \
    #text(9pt)[#super[3] Shanghai Research Center for Quantum Sciences, Shanghai 201315, China] \
    #text(9pt)[#super[4] Henan Key Laboratory of Quantum Information and Cryptography, Zhengzhou 450000, China] \
    #text(9pt)[#super[5] QuantumCTek Co., Ltd., Hefei 230026, China] \
    #text(9pt)[#super[6] Shanghai Institute of Technical Physics, Chinese Academy of Sciences, Shanghai 200083, China] \
  ]
  #v(1.2em)
]

= QUANTUM PROCESSOR DESIGN AND FABRICATION
<quantum-processor-design-and-fabrication>
We designed a state of the art programmable quantum processor, consists of 66 Transmon~@koch:042319 qubits in a two-dimensional array, with another 110 Transmon qubits as couplers for adjustable coupling between neighboring qubits, as illustrated in Fig.~1 in the main text. The 66 qubits are divided into 11 groups, with 6 qubits in a group sharing a readout Purcell filter~@PhysRevLett.112.190504. Taking advantage of the flip-chip technology, all qubits and couplers are placed on the same layer, and all readout and control lines are on the other layer. Each qubit is controlled by an control line which combines both microwave drive (XY control) and flux bias (Z control), and capacitively coupled to a quarter wave resonator which is coupled to a Purcell filter for dispersive readout. The qubit-qubit coupling of nearest-neighbor qubits are contributed by two parts: direct capacitive coupling and indirect coupling through the coupler. Each coupler has an individual flux bias line, with which the effective qubit-qubit coupling strength can be tuned from $tilde + 5 upright("MHz")$ to $tilde - 50 upright("MHz")$ by changing the coupler frequency. The two-qubit gates are implemented with a coupling strength of about $10 upright("MHz")$.


Our quantum processor consists of two separate chips, the top chip and the bottom chip. High purity aluminum thin film are grown on sapphire substrate by molecular beam epitaxy (MBE) for both chips~@megrant2012planar. Control and readout circuits are fabricated on the bottom chip using optical lithography. To suppress crosstalk, airbridges are fabricated to shield critical circuits~@dunsworth2018method. 66 qubits and 110 adjustable couplers are fabricated on the top chip using an aluminum evaporation and lift-off process. After dicing and testing, the two separated chips are bonded together with indium bumps~@foxen2017qubit @rosenberg20173d. After chip fabrication, the processor is wire-bounded to a printed circuit board inside a sample box with gold-plated shielding inside and $mu -$metal shielding outside. Finally, the packaged processor is mounted to the cold plate of a dilution refrigerator and connected to room temperature electronics through alternators, filters and amplifiers.


= EXPERIMENTAL SETUP
<experimental-setup>
The experimental wiring setup for qubit/coupler controls and frequency-multiplexed readouts is shown in @fig.wiring. The control and readout signals are generated by digital-to-analog converters (DAC) at room temperature, then attenuated by a series of attenuators and filtered by several low-pass filters.


In order to improve the signal-to-noise ratio of the readout signal, we use the Josephson parametric amplifier (JPA) for the first stage amplification at base temperature. Then the readout signal is amplified by a high-electron mobility transistor (HEMT) amplifier at the 4 K stage and further amplified by a room-temperature amplifiers after getting out of the dilution refrigerator.


The room temperature electronic equipment in this experiment includes 330 DAC channels, 11 ADC modules, 11 DC channels and 34 microwave source channels.


// [figvision] imgs/fig_wiring.png
// This schematic illustrates the control electronics and wiring for a quantum processor, organized vertically by
// temperature stages within a dilution refrigerator. The top section shows room-temperature components: JPA
// control (DC source and microwave source), Readout (ADC, DAC, IQ mixers), Qubit control (DACs, IQ mixer), and
// Coupler control (DAC). These connect via cables to the cryostat. Inside the refrigerator, signal lines pass
// through five thermal stages labeled 50K, 4K, Still, Cold plate, and MC. At each stage, green boxes represent
// attenuators with specified decibel values (e.g., 1dB, 3dB, 10dB, 20dB) or 0dB for no attenuation. Blue boxes
// denote low-pass filters with cutoff frequencies like 8GHz, 16GHz, 1GHz, or 80MHz. Orange bias tees combine DC
// and RF signals near the chip. Red triangles indicate amplifiers: one HEMT at 4K on the readout line, and one
// JPA at the mixing chamber (MC) after circulators. Circulators (brown squares with arrows) direct signal flow
// around the JPA. All lines converge at the bottom into a gray box labeled “Quantum processor.” A legend
// identifies all symbols: attenuator, filter, bias tee, amplifier, circulator, DC/microwave sources, ADC/DAC,
// and IQ mixer. The layout emphasizes noise suppression via cascaded attenuation and filtering as signals
// descend in temperature toward the qubits.
#figure([#block[
  #box(image("imgs/fig_wiring.png", width: 95.0%))
  ]],
  caption: [
    #strong[The schematic diagram of control electronics and wiring.] Each qubit has a XY control line and and a Z control line, which are combined together via a bias tee before connected to the quantum processor. In the dilution refrigerator, attenuators and filters are installed at various stages to reduce noise. Josephson parametric amplifiers (JPA) , high electron mobility transistors (HEMT) and room-temperature amplifiers are used to amplify the readout signals. At room temperature, digital-to-analog converters (DAC), microwave sources and mixers are used to generate pulses for qubit XY control, readout probing pulses and JPA pump. Qubit Z and coupler control pulses are also generated by DACs. DC sources are used to provide the flux bias of JPAs. The readout signals amplified by the room-temperature amplifiers are digitized and demodulated by ADC modules.
  ]
)
<fig.wiring>



= GATE AND READOUT CALIBRATION
<gate-and-readout-calibration>
== Part1: Rough calibration on 66 qubits
<part1-rough-calibration-on-66-qubits>
=== Basic Calibration
<basic-calibration>


After cooling down, we perform basic calibrations to determine whether the processor can work properly, this process involves all 66 qubits, 110 couplers, 66 readout resonators and 11 JPAs. The calibration procedure is listed bellow.

- Identify the the readout resonator frequency for each qubit, measure the dispersive frequency shift and measure its dependency with the qubit flux bias.

- Find a JPA DC bias, pump frequency and pump power configuration that produces high signal-to-noise ratio for the corresponding readout signals.

- Measure the response of readout resonator versus coupler bias, then bias the coupler to a safe point where coupling strength of neighboring qubits is small, $tilde + 5$MHz typically.

- Run Rabi experiments to calibrate $pi$ and $pi / 2$ pulse amplitudes.

- Perform coarse readout calibration to improve readout fidelity by optimizing readout frequency, length and amplitude.

- Tune coupler bias to minimize the qubit-qubit coupling via $| 10 chevron.r$ - $| 01 chevron.r$ swap experiment.

- Perform qubit spectroscopy measurements and extract the mapping between the qubit bias amplitude and the qubit frequency.

- Measure $T_1$, $T_2$ versus qubit frequency.

- Measure the step response of the bias control line to characterize the Z pulse distortion by running a Ramsey experiment~@2019Strongly.

- Perform XY-crosstalk measurement.

- Synchronise the timing between the qubit microwave drive, qubit bias, and coupler bias.


As qubit idle frequency arrangement and coupling between qubits are not yet optimized at this stage, we typically divide the qubits into 2 groups and couplers into 4 groups for some calibration experiments, calibration for each group are performed in parallel. Basic calibration results indicates that the quantum processor can work properly and we proceed to optimize the frequency arrangement with the coherence and XY-crosstalk data. There are three types of operating frequencies: idle, interaction and readout. When optimizing the frequency arrangement, we have to consider the following factors: coherence, two-level-system (TLS), residual coupling between qubits, XY-crosstalk and Z pulse distortions.


After the optimal operating frequencies are determined, we proceed to


calibrate and optimize single-qubit gate, readout and two-qubit gate parameters in parallel.


=== Readout, Single-Qubit Gate and Two-Qubit Gate Calibration
<readout-single-qubit-gate-and-two-qubit-gate-calibration>
~ \
#strong[i. Single-Qubit Gate Calibration]


The optimized idle frequency arrangement is displayed in @66qubit\(a). We set all qubit idle frequencies to the target idle frequencies by adjusting qubit flux biases. Next, we turn off the qubit-qubit coupling by adjusting the coupler flux bias. Then we fine tune the XY drive pulse amplitudes, pulse shaping parameters of the cosine-envelop microwave of 25ns length. Finally, we benckmark the fidelities of single qubit gates with single-qubit cross-entropy benchmarking (XEB)~@arute2019quantum.


Gate errors of some qubits are still too high($> 0.3 "%"$) for the random quantum circuit benchmarking tasks after this first round of calibration.


For these qubits, we measure XEB gate fidelity versus idle frequencies around initial idle frequency and choose a new optimal idle frequency.


After the above calibration procedure, we obtained high fidelity single-qubit gates with an average XEB pauli error 0.14\% when applied simultaneously. Complete XEB pauli error data of each single-qubit gates are shown in @66error\(a).


~ \
#strong[ii. Readout Calibration]


To improve readout fidelity and reduce readout crosstalk, we set the qubit readout frequencies to a different frequency arrangement optimized for readout, which is displayed in @66qubit\(e). At this new frequency setting, we rerun the basic readout calibrations to optimize readout frequency, length and amplitude. After this calibration procedure, the readout error is mainly limited by qubit relaxation. To reduce the influence of the relaxation, we enhance the effective qubit lifetime by driving the qubit to higher levels during the readout~@Elder_2020.


We calibrate the readout fidelities by preparing all qubits at $| 0 chevron.r ( | 1 chevron.r )$ and count the events of successfully identify the readout result as $| 0 chevron.r ( | 1 chevron.r )$. Simultaneous readout error of $| 0 chevron.r$ and $| 1 chevron.r$ are 3.46\% and 6.08\% respectively, average readout fidelity is 95.23\%, as shown in @66error\(b).


We also compare the fidelity results with that obtained from preparing the qubits at random bit strings as a sanity check. The results of random bit string measurement show that identification error of a single qubit has increased by an average of $0.14 "%"$ and the 56-qubit state readout fidelity is lower with a factor of $0.93$. This factor is used to correct the estimated fidelities in the random quantum circuit benchmarking tasks.


// [figvision] imgs/66qubit_error.png
// Panel a is a heatmap showing single-qubit gate Pauli error rates for 66 qubits arranged in an 11-row by
// 6-column grid. Each cell contains a percentage value ranging from 0.08% to 0.28%, with colors transitioning
// from dark blue (low error) through light blue and beige to red (high error). A vertical color bar on the right
// maps values from 0.1% to 0.25%. The average error e₁ is labeled below as 0.14%. Most cells are under 0.15%,
// but three exceed 0.20%, including one at 0.28% in row 7, column 3. Panel b displays two-qubit gate Pauli error
// rates across 110 couplers, also in an 11x6 grid layout. Values range from 2.2% to 8.4%, colored similarly:
// dark blue for low errors, red for high. The color scale runs from 3% to 7%. Average error eᵣ is noted as
// 4.77%. Several cells exceed 6%, notably 8.4% in row 9, column 6 and 8.1% in row 8, column 6. Errors cluster
// higher in bottom rows and rightmost columns. Panel c presents readout error percentages for the same 66 qubits
// in identical spatial arrangement. Values span 0.31% to 2.43%, mapped via a color gradient from dark blue
// (0.4%) to red (2.0%). Color bar ranges 0.4–2.0%. Average error e₂ is 0.76%. Highest errors appear in
// top-middle region: 2.43% (row 2, col 2), 2.39% (row 5, col 2), and 2.29% (row 1, col 3). Most other cells stay
// below 1.0%, indicating generally lower readout noise compared to gate errors.
#figure(scope: "parent", [#block[
  #box(image("imgs/66qubit_error.png", width: 100%))
  ]],
  caption: [
    #strong[Single-qubit gate pauli error $e_1$, two-qubit gate pauli error $e_2$ and readout error $e_r$ of the 66 qubits and 110 couplers of the #emph[Zuchongzhi] processor.] 
  ]
)
<66error>


// [figvision] imgs/66qubit_T1.png
// Panel a is a heatmap displaying the relaxation time (T1) for 66 qubits arranged in an 11-row by 6-column grid.
// Each cell contains a numerical value representing the T1 time in microseconds, ranging from 15.6 to 46.6. A
// vertical color bar on the right maps values from 16 to 46 μs, transitioning from blue (low) through white to
// red (high). The text "Average T1: 30.6 μs" appears below the grid. Panel b shows a similar heatmap for the
// dephasing time (T2*) of the same 66 qubits. The grid layout matches panel a. Values range from 1.8 to 16.0 μs.
// The color scale runs from 4 to 16 μs, using the same blue-to-red gradient. Below this grid, the label reads
// "Average T2*: 5.3 μs". Both panels use identical spatial organization to allow direct comparison of coherence
// times across the processor array.
#figure(scope: "parent", [#block[
  #box(image("imgs/66qubit_T1.png", width: 65.0%))
  ]],
  caption: [
    #strong[The relaxation time $T_1$ and dephasing time $T_2^(*)$ of the 66 qubits of the #emph[Zuchongzhi] processor.] 
  ]
)
<66T1>


// [figvision] imgs/66qubit.png
// Panel a is a heatmap displaying the Qubit Idle Frequency in GHz for a 10 by 7 grid of qubits. The vertical
// color bar ranges from 4.45 to 4.85, with deep blue indicating lower frequencies and deep red indicating higher
// frequencies. Most values cluster between 4.6 and 4.8. Specific numerical labels are centered in each cell; for
// example, the top-left value is 4.764, while the highest visible value is 4.875 in the fourth row, second
// column. Panel b presents a heatmap of Qubit Maximum Frequency in GHz over the same 10 by 7 grid layout. The
// color scale extends from 4.6 to 5.1, using the same blue-to-red gradient. A distinct outlier exists at the
// second row, first column, marked as 5.123 in deep red. Other cells generally range between 4.7 and 5.0. For
// instance, the bottom-right cell shows 4.875, and the top-right is 4.923. Panel c illustrates Nonlinearity in
// MHz via a 10 by 7 heatmap. The vertical axis spans from -262 to -240. Colors shift from blue (lower magnitude
// negative values) to red (higher magnitude negative values). The grid is filled with values like -255, -240,
// and -262. Notably, two cells in the second and fifth rows show -240 in dark red, representing the least
// negative nonlinearity, while the bottom-right corner is -262 in dark blue. Panel d maps Detuning From Maximum
// Frequency in MHz across the 10 by 7 grid. The color bar ranges from -500 to -50, where red indicates smaller
// detuning magnitudes and blue indicates larger ones. There is significant variation compared to previous
// panels. The second row, first column shows a strong blue -500, while the third row, second column is a deep
// red -7. Most other values fall between -100 and -200. Panel e shows the Qubit Readout Frequency in GHz on a 10
// by 7 grid. The color scale runs from 3.4 to 4.8. Red denotes higher frequencies around 4.7, while blue
// represents lower frequencies near 3.4. The data shows a mix of values; for example, the top-left is 4.410, and
// the second row, last column is 4.700. The bottom-left corner displays 3.360 in dark blue, indicating the
// lowest frequency in this set. Panel f depicts Readout Drive Frequency in GHz across the 10 by 7 array. The
// vertical color bar ranges from 6.25 to 6.55. High frequencies appear in red, such as 6.572 in the second row,
// last column. Low frequencies appear in blue, such as 6.239 in the bottom-right corner. The majority of the
// grid falls between 6.3 and 6.5, with specific values like 6.544 in the top-left corner clearly labeled.
#figure(scope: "parent", [#block[
  #box(image("imgs/66qubit.png", width: 58.0%))
  ]],
  caption: [
    #strong[The typical distribution of 66-qubit parameters over the #emph[Zuchongzhi] processor.] 
  ]
)
<66qubit>


~ \
#strong[iii. Two-Qubit Gate Calibration]


The two-qubit gate of our experiment, the iSWAP-like gate~@arute2019quantum, is realized by tuning the two qubits from their idle frequencies into resonance and turning on the coupling.


Considering the effects of decoherence and leakage, we set the total time duration of the iSWAP-like gates to 32ns, which includes the pulse rise/fall time of 3ns and interaction time of 26ns. With this setting, we finely calibrate the detuning of the two qubits and the coupling strength of the corresponding coupler to obtain a full swap from one qubit to another. After that, we optimize the interaction time in order to minimize leakage to higher energy levels. We generally perform these calibration steps iteratively until the parameters converge, typically within two or three iterations.


After the calibration of iSwap-like gate paramegters, we benchmark gate performance with XEB. Unlike single qubit gates, iSwap-like gates are parameterized gates each with four parameters as described by the unitary model in the main text, with the experimental results of XEB and the generic unitary model, we learn these parameters through an optimization process to maximize the overall fidelity of XEB. With the optimized parameters, we fit the final XEB error and speckle purity benchmarking(SPB) error @arute2019quantum. We obtained high fidelity two-qubit gates with an average XEB pauli error 0.76\% over all 110 couplers when applied simultaneously, which is shown in @66error\(c).


== Part2: Fine-tune on 56 qubits
<part2-fine-tune-on-56-qubits>


// [figvision] imgs/56_interactionFreq.png
// This panel is a heatmap displaying the interaction frequencies for 94 two-qubit gates among 56 selected
// qubits. The data is presented as a grid of colored squares, where each square represents a specific gate
// frequency in Gigahertz (GHz), explicitly labeled with numerical values to three decimal places. A vertical
// color bar on the right indicates the scale, ranging from approximately 4.45 GHz at the bottom to above 4.75
// GHz at the top. The colormap transitions from dark blue for lower frequencies, through light gray and beige
// for intermediate values around 4.60 GHz, to deep red for the highest frequencies. The layout reveals clusters
// of high-frequency interactions, notably a dark red peak of 4.795 GHz in the upper left region, contrasted with
// distinct blue regions indicating lower frequencies near 4.413 GHz in the lower right quadrant.
#figure([#block[
  #box(image("imgs/56_interactionFreq.png", width: 95.0%))
  ]],
  caption: [
    #strong[The qubit interaction frequencies of the 94 two-qubit gate of the 56 selected qubits.]
  ]
)
<InteractionFreq>



After rough calibrations on 66 qubits, we can estimate the XEB fidelity of a specific quantum circuit with $n$ qubits and $m$ cycles according to @fidelitycal. For random quantum circuit sampling, as the circuit scale increases its fidelity decreases, a large number of samples is required to ensure the uncertainty of the fidelity is much less than the fidelity itself in case of low fidelity. As a trade-off between number of samples and sampling time, we only compile our random circuit sampling tasks to a subset of the processor of up to 56 qubits. We achieved 56-qubit 20-cycle random circuit sampling, an intractable task for classical simulation, within an acceptable sampling time.


To switch from the 66-qubit pattern to the 56-qubit pattern, we just turn off the couplings between the selected qubits and the unused qubits. Then, we recalibrate the readout, single-qubit gate and two-qubit gate parameters. In addition, for the qubits on which two-qubit XEB pauli error is higher than 1.5\%, we sweep their SPB fidelities at a fixed depth of 20 cycles with 70 random circuit instances at different interaction frequencies to optimize the two-qubit gate fidelities. The best interaction frequencies of the 94 two qubit gates are illustrated in @InteractionFreq. Finally, we use per-layer simultaneous two-qubit gate XEB to benchmark the gate errors~@arute2019quantum.


After all the calibrations and optimizations, the average readout error is 4.52\%, the average XEB pauli errors of sinlge-qubit gates and two-qubit gates are 0.14\% and 0.59\%, respectively, as illustrated in Fig.~2 in the main text.


== Summary of system parameters
<summary-of-system-parameters>
The system parameters of our quantum processor are summarized in @tableSummary.


#figure(scope: "parent", [#table(
    stroke: none,
    columns: 5,
    align: (left,left,left,left,left,),
    table.hline(stroke: 0.8pt),
    table.header([Parameters], [Median], [Mean], [Stdev.], [Figure],),
    table.hline(),
    [Qubit maximum frequency (GHz)], [4.811], [4.809], [0.096], [@66qubit],
    [Qubit idle frequency (GHz)], [4.653], [4.653], [0.095], [@66qubit],
    [Qubit anharmonicity (MHz)], [-246.5], [-248.2], [5.3], [@66qubit],
    [Qubit readout frequency (GHz)], [4.400], [4.083], [0.492], [@66qubit],
    [Readout drive frequency (GHz)], [6.409], [6.407], [0.103], [@66qubit],
    [$T_1$ at idle frequency ($mu$s)], [30.8], [30.6], [7.1], [@66T1],
    [$T_2^(*)$ at idle frequency ($mu$s)], [5.1], [5.3], [2.7], [@66T1],
    [66-qubit readout $e_r$ (\%)], [4.52], [4.77], [1.35], [@66error],
    [66-qubit 1Q XEB $e_1$ (\%)], [0.14], [0.14], [0.05], [@66error],
    [66-qubit 2Q XEB $e_2$ (\%)], [0.67], [0.76], [0.43], [@66error],
    [56-qubit readout $e_r$ (\%)], [4.50], [4.52], [1.43], [Fig.~2(main)],
    [56-qubit 1Q XEB $e_1$ (\%)], [0.13], [0.14], [0.05], [Fig.~2(main)],
    [56-qubit 2Q XEB $e_2$ (\%)], [0.53], [0.59], [0.20], [Fig.~2(main)],
    table.hline(stroke: 0.8pt),
  )], caption: [#strong[Summary of system parameters.]]
  , kind: table
  )
<tableSummary>






= SOFTWARE SYSTEM
<software-system>
A 66-qubit superconducting quantum processor is a high-dimensional, highly constrained analogy system with system parameters susceptible to environmental changes and often drifts with time, to execute high fidelity quantum circuits, more than 400 DAC, ADC, microwave source and DC source channels need to be controlled with cutting edge precision. Operating such a complex quantum system requires considerable advancement in software as compared to operating small quantum systems. We have developed a software system for intermediate scale superconducting quantum systems called #emph[QOS(Quantum Operating System)] that is capable of operating quantum systems of more than 1000 qubits.


// [figvision] imgs/fig_s_software_1.png
// This schematic illustrates the software architecture of the QOS system, organized as a vertical stack of four
// major modules labeled from top to bottom: Service, Routine, Kernel, and Hardware. At the very base lies a gray
// rectangular block representing the physical "Hardware." Above this is the "Hardware" module containing three
// internal components: a full-width box for the "Hardware Abstraction Layer(HAL)" stacked above two smaller
// side-by-side boxes labeled "Lower Level Driver" and "Mock Driver." The next layer up is the "Kernel" module,
// which features "User" and "QThread" in separate boxes at its top. Below these sits a large container labeled
// "Quantum Processor(QPU)," which encloses a nested box for the "Quantum Agent." A final box for the "Hardware
// Adapter" sits at the bottom of the Kernel section. The third layer is the "Routine" module, consisting of
// three vertically stacked equal-sized boxes labeled "Calibration Controller," "Calibrator," and "Sampler." The
// topmost "Service" module contains three horizontally arranged boxes labeled "RPC Service," "Web Service," and
// "Cloud Service."
#figure([#block[
  #box(image("imgs/fig_s_software_1.png", width: 55.0%))
  ]],
  caption: [
    #strong[Software architecture.] The #emph[QOS] system consists of four major modules, the #emph[Hardware] module , the #emph[Kernel] module, the #emph[Routine] module and the #emph[Service] module. Other supporting modules are not shown.
  ]
)
<software_architecture>



The major functionalities of #emph[QOS] are abstract away hardware details, manage resources and implement quantum operations. The first two functionalities are similar to that of a classical computer operating system, the last is unique to a quantum operating system.


As mentioned before, a large scale quantum processor is a complicated system, directly managing such a complex system is intractable for experiment users, the #emph[QOS] system abstract away system details and manages all the resources for the user. Resources of a quantum computer system includes hardware and software. We categorize hardware into two categories, #emph[classical hardware] and #emph[quantum hardware]. #emph[Classical hardware] includes DAC, ADC, microwave source, DC source and all other control electronics, #emph[quantum hardware] includes the quantum processor and the quantum amplifiers. To mange all the resources, #emph[QOS] manages a #emph[registry] system to represent and keep track of the settings/configurations of all the resources. The #emph[registry] is organized in a tree structure and holds all the settings of the #emph[classical hardware], #emph[quantum hardware] and software configurations. Each user maintains independent #emph[registry] settings for their own experiments. About 20k entries of #emph[registry] settings are used to run the quantum processor in this work.


@software_architecture shows the basic architecture of the the QOS system, it consists of four major modules, the #emph[Hardware] module, the #emph[Kernel] module, the #emph[Routine] module and the #emph[Service] module. Other supporting modules includes the #emph[Data Storage] module, the #emph[Registry] module, the #emph[Waveform] module and the #emph[Utility] module etc. Most of the software components are abstractions of the hardware system components.


The #emph[Hardware] module hosts a library of drivers of classical hardware, on top of this, a hardware abstraction layer(#emph[HAL]) is introduced to provide an unified API for the #emph[Kernel] module to interface with hardware, making upper stream modules hardware model agnostic and can be adapted to hardware provided by differ vendors with minimum effort. Mock drivers are also provided to facilitate #emph[off-line] testing without real hardware.


Unlike a classical processor, on which all the basic computing units like logical gates and registers are hardware components, a superconducting quantum processor is just a physical quantum system, all computing units like quantum gates and quantum registers have to be implemented by software. The most essential functionality of a quantum software system is to implement quantum operations and transform a quantum physical device into a quantum computing processor. This is done by the #emph[Kernel] module and makes it the most important module. The #emph[Kernel] module is an abstraction of the physical system, including the quantum processor device and the controlling electronics, it consists of the following sub-modules, the #emph[Quantum Processor(QPU)], the #emph[Hardware Adapter], the #emph[User] and the #emph[QThread].


Controlling superconducting qubits to implement high fidelity quantum gates is a complex task, when the system size scales up, the requirement on software performance is very demanding. To be scalable, the software system has to be able parse quantum operations in parallel. Entanglement is an intrinsic feature of a quantum system, implement parallel operation on an entangled system is a non trivial task. We use the #emph[Actor Model]~@hewitt1973universal for the implementation of the #emph[kernel] module. Each hardware component is modeled as an actor, called #emph[Agent] with those representing quantum components called #emph[QAgent] in particular, types of #emph[agent] used in this work are listed below:


- #emph[Transmon], of the #emph[QAgent] class, each represents a Transmon~@koch:042319 type or Transmon type compatible qubit, responsible for managing all the settings of the qubit and implementing single qubit quantum operations.

- #emph[TTG], tunable coupler of the Transmon qubit as used on the #emph[Zuchongzhi] processor, responsible for managing all the settings of the coupler and implementing two qubit quantum operations.

- #emph[MuxReadout], represents a multiplexed qubit state readout unit.

- #emph[IMPA], represents an impedance matched parameter amplifier~@mutus2014strong.

- #emph[QProcessor], a controlling #emph[agent] of all the agents, including qubits, couplers, readouts, amplifiers, hardware manager etc.

- #emph[Hardware Adapter], represents one piece of classical hardware, DAC, ADC, microwave source etc.

- #emph[Hardware Manager], a controlling #emph[agent] of all the classical hardware agents.

- #emph[QThread], a software abstraction that represents a quantum thread or quantum process on a quantum processor.

- #emph[User], a software abstraction that is responsible for managing user specific resources, conducting user transactions like authentication and authorization etc.


#figure(placement: top, scope: "parent", [
  #set text(size: 8pt)
  #set table(inset: (x: 4pt, y: 2pt))
  #table(
    columns: 3,
    align: (left,left,left,),
    table.header([#strong[Opcode]], [#strong[Example]], [#strong[Meaning]],),
    table.hline(),
    [SET], [SET Q01 2 3.14], [Set value of the selected setting entry of index 2 of Q01 to 3.14],
    [CMT], [CMT Q01 0], [Commit settings change, waveforms regenerated, caches refreshed etc.],
    [], [], [Example: commit settings change of type 0 for Q01],
    [I], [I Q01 50], [Idle gate. Example: Q01 idle for time duration 50],
    [X, Y, Z], [X2M Q01], [XY gates. Example: -X/2 gate on Q01],
    [X2P, X2M, Y2P, Y2M], [], [],
    [H], [H Q01], [H gate],
    [XY], [XY Q01 0.785], [$pi$ rotation around the axis of azimuth 0.785 rad in the XY plane],
    [XY2P, XY2M], [XY2P Q01 0.785], [$+ pi / 2$\($- pi / 2$) rotation around the axis of azimuth 0.785 rad],
    [], [XY2M Q01 0.785], [in the XY plane],
    [X12], [X12 Q01], [$| 1 chevron.r arrow.l.r | 2 chevron.r$ driving gate],
    [X23], [X23 Q01], [$| 2 chevron.r arrow.l.r | 3 chevron.r$ driving gate],
    [Z], [Z Q01], [Z gate on Q01],
    [S, SD], [SD Q01], [$S$, $S^dagger$ gate],
    [T, TD], [T Q01], [$T$, $T^dagger$ gate],
    [RX, RY, RZ], [RY Q01 0.785], [Arbitrary rotation around the X, Y or Z axis with the specified angle],
    [RXY], [RXY Q01 0.785 3.14], [Q01 rotation of 3.14 rad around the the axis of azimuth angle 0.785],
    [], [], [in the XY-plane],
    [AXY], [AXY Q01 20 0.75 0.785 -1e6 0.55], [Arbitary XY rotation. Example: Q01 arbitrary rotation around the the axis of],
    [], [], [azimuth angle 0.785 in the XY-plane with pulse length 20,],
    [], [], [pulse amplitude 0.75, -1e6 detuning and 0.55 DRAG alpha],
    [CZ, CNOT, SWP, ISWP], [CZ G0701], [Two qubit gates. Example: CZ gate on coupler G0701],
    [SISWP], [], [],
    [CP, FSIM], [FSIM G0701 1], [Parameterized two qubit gates, with an index to indicate which],
    [], [], [parameter set to use. Example: FSIM gate of index 1 on coupler G0701],
    [DTN], [DTN Q01 100 -2e6 0], [Detune Q01 -2e6MHz for a duration 100 at time offset 0],
    [MEASURE, M], [M Q01], [Measure qubit Q01],
    [PLS, PLSXY], [PLS Q01 1 100 10 0.8 0 0 1], [Put a pulse of a waveform index 1 at time 100 with the specified],
    [], [], [parameters for Q01],
    [B], [B Q01 R01], [Establish a time barrier between Q01 and R01],
    [SWD, SWA], [SWA Q01 0.8], [SET work bias duration, amplitude. The work bias amplitude],
    [], [], [determines $f_01$],
    [MOV,~...], [MOV G0701 0 1], [Classical instructions. Example: set value 1 to classical register 0 of G0701],
  )], caption: [#strong[Quantum Control Instruction Set (QCIS)]]
  , kind: table
  )
<qcis>






By introducing the concept of #emph[agent], we decouple the highly entangle quantum processor as well as the shared classical controlling electronics into a collections of separated components, with all the entanglement resolved by the related agents and transparent to upper stream modules. We use a highly decentralized architecture for the agents, all agents function concurrently and directly communicate with each other when necessary. For the only tow central agents, the #emph[QProcessor] and the #emph[Hardware Manager], they only assume minimum light weighted functionalities like instruction dispatching and synchronization to avoid any performance bottle neck. With this architecture, we can process large scale complex quantum operations in a fully concurrent manner, pushing software performance to its limits.


Multi-processing or multi-threading is supported through #emph[QThread], one can run multiple experiments concurrently, new experiments can be created and executed immediately without waiting for previous experiments to finished. When an experiment is started, typically one #emph[QThread] is created with a new #emph[context] holding a view of the #emph[registry] and other dynamic settings in each involved #emph[QAgent], exposing only a few selected setting entries to be dynamically set for parameter sweeping. Tasks of this experiment is configured with settings from these contexts and executed through time slicing with other #emph[QThread]s with round-robin scheduling. Several #emph[QThread]s operating upon distinct #emph[agent] sets can be configured to run simultaneously to save hardware time. A #emph[QThread] will go into hibernation after idling for some time to yield resources, and will be awakened upon arrival of new tasks. Multi-user is also support through #emph[user], multiple users can run experiments concurrently with completely different settings. works in a server-client mode, a dedicated RPC(Remote Procedure Call) framework is developed for users to interface with , web service and cloud service are also supported.


We introduce the #emph[Quantum Control Instruction Set(QCIS)] for the full control of a superconducting quantum processor as list in @qcis. #emph[QCIS] offers a unified API for operating a quantum processor, with #emph[QCIS], we can control the #emph[Zuchongzhi] system exactly the same way as programming a classical computer. Program written with #emph[QCIS] are called #emph[QProgram]. All experiments in this work are implemented with this instruction set. As an example, sweep with the following code snippet executes a tuning of all the iSWAP-like gate related parameters for a swap experiment on #emph[G0701], the #emph[TTG QAgent] between qubits #emph[Q01] and #emph[Q07]:


morekeywords=SET, X2P, Y2P, XY2P, MOV, CMT, X, FSIM, B, M, basicstyle=,


numberstyle=, frame=tb, tabsize=4, columns=fixed, showstringspaces=false, showtabs=false, keepspaces, commentstyle=, comment=\[l\]\/\/, morecomment=\[s\]/\*\*/, commentstyle=,


keywordstyle=#strong[]







```
[
```


basicstyle=, \] SET G0701 0 30 \/\/ set FSIM gate duration to 30\*


SET G0701 1 6 \/\/ set qubit pulse rise/fall edge duration to 6 SET G0701 2 2 \/\/ set coupler pulse rise/fall edge duration to 2 SET G0701 3 -10e6 \/\/ set FSIM gate qubit\_0 detune to -10e6


SET G0701 4 20e6 \/\/ set FSIM gate qubit\_1 detune to 20e6 SET G0701 5 15e6 \/\/ set coupler coupling strength to 15e6 MOV G0701 0 1 \/\/ set value 1 to classical register 0 to indicate that the \/\/ index of the FSIM gate for the following CMT action is 1


CMT G0701 0 \/\/ commit settings change, waveforms will be regenerated, \/\/ caches refreshed etc. X Q07 \/\/ X gate on Q07 FSIM G0701 1 \/\/ execute the FSIM gate indexed 1 on G0701\*\* B Q07 Q01 \/\/ establish a time barrier before measurement


B Q07 R01 \/\/ establish a time barrier before measurement M Q07 \/\/ measure Q07 M Q01 \/\/ measure Q01 /\*


\*: at the creation of QThread, related setting entries are selected and indexed


\*\*: a coupler can implement multiple FSIM gates of different parameters


\*/






The following #emph[QProgram] executes one of the random circuit sampling task in this work:


```
X2P Q01
Y2P Q02
X2P Q03
Y2P Q04
XY2P Q07 0.785398163397448
X2P Q08
Y2P Q09
XY2P Q10 0.785398163397448
X2P Q11
XY2P Q12 0.785398163397448
XY2P Q13 0.785398163397448
X2P Q14
XY2P Q15 0.785398163397448
X2P Q16
XY2P Q17 0.785398163397448
XY2P Q19 0.785398163397448
X2P Q20
XY2P Q21 0.785398163397448
XY2P Q22 0.785398163397448
Y2P Q23
XY2P Q25 0.785398163397448
XY2P Q26 0.785398163397448
// ... 30 lines not shown
XY2P Q61 0.785398163397448
XY2P Q62 0.785398163397448
Y2P Q63
Y2P Q64
FSIM G1003 1
FSIM G1104 1
FSIM G1408 1
FSIM G1509 1
// ... 1809 lines not shown
M Q50
M Q51
M Q52
M Q53
M Q55
M Q56
M Q57
M Q58
M Q59
M Q61
M Q62
M Q63
M Q64
```


The #emph[Routine] module is a standard library of quantum experiments, implemented mainly for bringing up a superconducting quantum processor. Basic routines are called #emph[Sampler]s. A #emph[sampler] creates a #emph[QThread], provides a task generator for the #emph[QThread] which then throttles tasks to #emph[QPU] to be executed. Measured results are send back as an asynchronous stream, which can be subscribed by data handlers to do data processing on the fly. Data handlers could be simple data saving routines, data visualizers or sophisticated pattern recognition routines in data analyzers of a calibrator. All #emph[sampler]s except a few special cases are implemented to run experiments for multiple #emph[QAgent]s in parallel. Upon #emph[sampler]s, #emph[calibrator]s are build to implement a specific calibration task, a #emph[calibrator] builds one or several #emph[sampler]s with parameters like sweep ranges defined by the specific calibration task, run the sampling tasks, analyze the sampled data and generate a calibration result #emph[CalResult] for each of its calibration target. The calibration results are then validate by one or several #emph[Validator]s to check whether they are solid. On top of #emph[calibrator]s, a #emph[Calibration Controller] manages all the #emph[calibrator]s and schedules then to run in a specific scheme, collects calibration results from different calibrators, render results into #emph[Calibration Report] and update related setting entries according to the results. The #emph[calibration controller] can run in several modes, fully automated run as a directed graph~@kelly2018physical, run selected #emph[calibrators] in a specified series or just run a single #emph[calibrator]. High flexibly is provided in calibration mode to meet the needs of experiments, a #emph[calibrator] can be triggered to run a partial calibration on a subset of its responsible #emph[agents] or run a series of calibration dividing then into subgroups as opposed to calibrate all #emph[agents] in parallel. With #emph[calibrator]s and #emph[calibration controller], the bring up/calibration procedure can be largely automated.


// [figvision] imgs/fig_s_software_2.png
// This schematic diagram illustrates the architecture of the QOS system, organized into three vertical sections
// enclosed by dashed lines: QThreads on the left, QPU in the center, and Hardware Adapter on the right. A
// standalone box labeled Hardware sits to the far right. The upper data flow path moves from right to left:
// arrows connect Hardware to the DAQ block, then to Data Collection/Dispatch, and finally to a stack of boxes
// labeled Data Handlers within the QThreads section. The lower control path flows left to right: arrows connect
// the Task Generator stack to Parallel Parsing, then to Control, and finally to Hardware. Both forward paths are
// marked with "throttle" labels inside the arrows. Two curved feedback loops at the bottom connect adjacent
// stages back to their upstream neighbors, explicitly labeled as "backpressure control."
#figure([#block[
  #box(image("imgs/fig_s_software_2.png", width: 95.0%))
  ]],
  caption: [
    #strong[Experiment workflow.] The #emph[QOS] system works in a pipe-lined mode with back pressure control, together with parallel processing at all pipeline stages, software overhead is greatly reduced.
  ]
)
<fig_s_software_2>



As a superconducting quantum system is unstable and its parameters drifts with time, fast calibration is key to success. Performance is not just crucial for the #emph[kernel], we also designed all the #emph[sampler]s and #emph[calibrator]s with high performance in mind. We use a pipe-lined workflow for the whole system as show in @fig_s_software_2 to minimize software processing overhead. As a result, #emph[QOS] can run heavy weight experiments like parallel randomized benchmarking on large scale quantum processor with negligible software time overhead. In this work of 66 qubits and 110 couplers, we can perform one round of routine calibration in less than one hour, which includes single qubit gate calibration, single qubit gate XEB fidelity calibration for all the qubits, two qubit gate calibration, two qubit gate XEB fidelity calibration and learn iSWAP-like gate parameters for all the couplers. This experiment time consumption will not grow considerably as it is only limited by hardware time.


= RANDOM QUANTUM CIRCUITS
<random-quantum-circuits>


In each cycle of the random quantum circuit, single-qubit gates chosen randomly from $( sqrt(X) , sqrt(Y) , sqrt(W) )$ are first applied on all qubits, and then two-qubit gates, iSWAP-like gate, are applied to pairs of qubits. There are four types of patterns for two-qubit gate, labeled by A, B, C and D respectively, which determine which two-qubit gates are executed on each layer. Different from the single-qubit gates, the four patterns of A, B, C, and D are implemented in the sequence of ABCDCDAB.


In our experiments, we implement random quantum circuits (RQCs) on the quantum processor, and evaluate the time consumption of simulating these quantum circuits on the traditional supercomputer. So far, there are mainly two types of algorithms for simulating large RQCs: (1) tensor network algorithms~@MarkovShi2008 @GuoWu2019 @VillalongaMandra2019 @villalonga2020establishing @HuangChen2020 @pan2021simulating @guo2021verifying and (2) Schrödinger-Feynman algorithm (SFA). The time-consuming of the SFA is significantly connected to the structure of four patterns A, B, C, and D, which could be regarded as a criteria for designing the structure of RQCs. The basic procedure of SFA can be summarized as follows: (1) Firstly, cut a $n$-qubit quantum circuit into two partitions with $n_1$ and $n_2$ qubits. (2) Then by summing all simulation paths that are the product of the terms of the Schmidt decomposition of all cross-partition gates, one could obtain the output state of the quantum circuit. The computational complexity of the algorithm is proportional to $( 2^(n_1) + 2^(n_2) ) r^g$, where $r$ is the Schmidt rank, and $g$ is the number of the cross-partition gates. The iSWAP-like gate used in our scheme has the Schmidt rank of $r = 4$. Thus, when evaluating the runtime of the SFA, one needs to find the optimal cut with $n_1$, $n_2$ and $g$ that makes the simulation task to become the easiest. In addition, for a circuit cut, if the following formations occur, both $r$ and $g$ may be reduced, resulting in a reduction in the computational complexity of the SFA algorithm:


1) #emph[Wedge formation]. As shown in @wedge, a wedge formation is formed when two consecutive cross-partition gates share a qubit, which can reduce the Schmidt decomposition of resulting three-qubit unitary to only four terms. Equivalently, every wedge reduces a cross-partition gate, and provides a speedup of a factor of 4.


2) #emph[DCD formation]. The DCD formation often happens at the boundary. Specifically, the DCD formation appears when there are three successive two-qubit gates acting on the qubit pairs $( a , b )$, $( b , c )$ and $( a , b )$, and these three gates can be fused in one (the two gates on qubit pairs $( a , b )$ can be fused). A DCD formation provides a speedup of a factor of 4.


3) #emph[Formation of iSWAP-like gates at the start and end of the circuit]. The iSWAP-like gate is the product of a iSWAP and controlled phase gate, and the iSWAP gate can be applied either at the beginning or at the end of the sequence. We apply this transformation to all iSWAP-like gates at the beginning (end) of the circuit that affect qubits that are not affected by any other two-qubit gate before (after) in the circuit. The iSWAP is then applied to the input (output) qubits and their respective one-qubit gates trivially, and the bond dimension remaining from this iSWAP-like gate is 2, corresponding to a controlled phase gate, as opposed to the bond dimension 4 of the original iSWAP-like gate. Thus, A iSWAP-like gate that appears at the same time in the cross-partition and the beginning (or end) of the circuit can provide a speedup of a factor of 2.


// [figvision] imgs/wedge.png
// This schematic diagram illustrates the formation of a wedge in a qubit lattice. The structure consists of dark
// gray circular nodes representing qubits, arranged in a grid and connected by straight gray lines indicating
// couplings. A vertical dashed red line traverses the center, marking a cut line that separates the lattice into
// two regions. Two specific nodes intersected by this cut line are highlighted as crosspartition gates: one is
// colored solid cyan, and another directly below it has a lime green outline. These two gates share a single
// physical connection (edge) across the cut line. This shared connectivity between consecutive crosspartition
// gates constitutes the "wedge" formation described in the caption.
#figure([#block[
  #box(image("imgs/wedge.png", width: 60.0%))
  ]],
  caption: [
    #strong[Wedge formation.] The gate highlighted in blue and green on the cut line are crosspartition gates. A wedge is formed when two consecutive crosspartition gates share a qubit.
  ]
)
<wedge>



To ensure the computational complexity and classical hardness with low depth, the number of cross-partition gates $g$ on the optimal cut should be large enough, and the four patterns should be carefully designed to avoid the occurrence of above three formations as much as possible.


@ABCD\(a) shows an example of the topology of a quantum processor. The red dot represents the qubit, and the black line represents the two-qubit gate between two qubits. These two-qubit gates can be divided into two categories: $G_(45^compose)$ and $G_(135^compose)$, which are represented as 45 degree lines (see @ABCD\(b)) and 135 degree lines (see @ABCD\(b)), respectively. For efficient implementation on the quantum hardware, every two different two-qubit gates in each pattern should not share the same qubit. Thus, pattern $G_(45^compose)$ is split into pattern A and pattern B (see @ABCD\(c)). Similarly, pattern $G_(135^compose)$ is split into pattern C and pattern D (see @ABCD\(d)). Patterns A, B, C, and D could have different structures, and once pattern A (or C) is determined, then the structure of pattern B (or D) is determined. To design the optimal patterns of A, B, C, and D for a specific quantum processor, a search strategy is proposed as shown below:


\(1) Set constraints, including the topology of the processor, the circuit depth of RQC, the sequence of four patterns (usually ABCDCDAB), and the maximum permissible number of two-qubit gates in the partition.


\(2) Set the structures of patterns of A, B, C, and D.


\(3) According to the conditions in (1) and (2), search for the optimal cuts with the least number of effective crosspartition gates, where the number of effective crosspartition gates $L$ is determined using the following formula,


$ L = g_(upright("cut")) - g_(upright("wedge")) - g_(upright("DCD")) - g_(upright("start") , upright("end")) / 2 $<eq:1>


where $g_(upright("cut"))$ is the number of crosspartition gates, $g_(upright("wedge"))$ is the number of wedge formations, $g_(upright("DCD"))$ is the number of DCD formations, and $g_(upright("start") , upright("end"))$ is the number of the formations of iSWAP-like gates at the start and end of the circuit. Step (3) outputs the optimal cut and the number of corresponding effective crosspartition gates, denoted as $upright("Min")_L$, which determines the computational complexity of SFA for simulating the circuit designed with the set patterns.


Repeat steps (2) and (3) to search for the optimal patterns that have the maximum $upright("Min")_L$. @66circuit and #ref(<Qubit-ordering>) show the optimal patterns of A, B, C, and D that we have searched for 56-qubit RQC with 20 cycles and the corresponding promising cut, respectively.


// [figvision] imgs/ABCD.png
// Panel (a) presents a schematic diagram of a quantum processor's topology. It displays a 5x5 grid of red
// circular dots, representing qubits, connected by black lines indicating two-qubit gates. The connections form
// a dense lattice where each internal node links to its immediate horizontal, vertical, and diagonal neighbors.
// This visualization establishes the full connectivity graph used as the basis for subsequent pattern
// decompositions shown in later panels. Panel (b) illustrates a mathematical decomposition using three
// schematics arranged horizontally with plus and equals signs. Red dots represent qubits and black lines
// represent gates. The first diagram, labeled G_45°, shows only diagonal gates running from bottom-left to
// top-right. The second, G_135°, shows diagonal gates running from top-left to bottom-right. The third, G_all,
// combines both sets, reproducing the full lattice seen in panel (a). Panel (c) depicts an additive relationship
// between three specific gate patterns labeled A, B, and G_45°. All diagrams feature red qubit nodes on a 5x5
// grid. Pattern A consists of parallel black lines connecting nodes diagonally from bottom-left to top-right.
// Pattern B contains fewer parallel lines oriented in the same direction but shifted spatially. Their sum equals
// G_45°, demonstrating that combining these two sparse sub-patterns reconstructs the complete set of 45-degree
// gates. Panel (d) follows the same additive logic for the 135-degree orientation, showing Patterns C and D
// summing to G_135°. Below the equation, a bracket connects to a beige box titled "Some examples of Pattern C."
// Inside are four small grids showing variations of Pattern C, illustrating that while the orientation remains
// constant, the specific arrangement of gates can vary, followed by ellipses indicating further possibilities.
#figure([#block[
  #box(image("imgs/ABCD.png", width: 100.0%))
  ]],
  caption: [
    #strong[The relationship of A, B, C, and D patterns.] (a) An example of the topology of a quantum processor. The red dot represents the qubit, and the black line represents the two-qubit gate between two qubits. (b) These two-qubit gates can be divided into two categories: $G_(45^compose)$ and $G_(135^compose)$, which are represented as 45 degree lines and 135 degree lines, respectively. (c) The pattern $G_(45^compose)$ is split into pattern A and pattern B. (d) The pattern $G_(135^compose)$ is split into pattern C and pattern D. Patterns A, B, C, and D could have different structures, here we list some examples of pattern C.
  ]
)
<ABCD>



// [figvision] imgs/66circuit.png
// Panel A is a schematic of a qubit interaction grid. White circles represent 56 qubits, numbered 1 to 53 in the
// main array, with faint pink circles indicating potential neighbors outside this set. Black lines connect
// adjacent qubits to show possible links. Thick orange lines highlight specific couplers that are active in this
// cycle. These active couplers form diagonal stripes running from top-left to bottom-right, connecting pairs
// such as qubits 3 and 4, 8 and 9, and 13 and 14. This pattern dictates which qubits interact simultaneously.
// Panel B displays the same qubit grid layout as Panel A, but with a different activation scheme. Here, thick
// blue lines indicate the active couplers. Similar to the previous panel, these active links create diagonal
// stripes oriented from top-left to bottom-right. However, the position of these stripes is shifted relative to
// Panel A. For instance, the blue lines connect qubits 2 and 3, 7 and 8, and 12 and 13. The black background
// connections remain constant, while the blue overlays define the specific interaction constraints for this
// cycle. Panel C presents the identical qubit network structure. In this variation, the active couplers are
// marked by thick green lines. These green lines also follow the diagonal orientation seen in Panels A and B,
// running from top-left to bottom-right. The specific coupling pairs include qubits 4 and 5 (implied by
// position), 9 and 10, and 14 and 15. The consistent geometry across panels suggests a systematic rotation or
// shifting of the active interaction window across the processor's architecture. Panel D shows the final
// configuration in the series using the standard grid of white circles and black connection lines. Thick red
// lines denote the active couplers for this specific cycle. Like the other panels, the red lines form diagonal
// bands moving from top-left to bottom-right. This particular pattern activates couplers between pairs like
// qubits 1 and 2, 6 and 7, and 11 and 12. Collectively, the four panels illustrate distinct, non-overlapping
// sets of simultaneous interactions allowed within the 56-qubit system.
#figure(scope: "parent", [#block[
  #box(image("imgs/66circuit.png", width: 95.0%))
  ]],
  caption: [
    #strong[Coupler activation patterns for 56 qubits.] Coupler activation pattern for 56 qubits that determines which qubits are allowed to interact simultaneously in a cycle. 
  ]
)
<66circuit>


// [figvision] imgs/Qubit_ordering.png
// This panel displays a schematic diagram of a qubit connectivity graph arranged in a staggered grid. The nodes
// represent individual qubits, labeled with integers from 0 to 55, and are connected by lines representing
// couplings. The qubits are divided into two distinct groups based on color: the upper section contains
// twenty-eight blue-outlined nodes (including 36, 24, 16, 0), while the lower section contains twenty-eight
// black-outlined nodes (including 1, 39, 37). A specific set of seven green lines connects these two groups,
// forming an optimal cut that separates the circuit. These green edges link node pairs 0-1, 2-3, 6-7, 8-27,
// 42-47, 44-51, and 54-51. Faint pink nodes and connections appear along the left and right periphery,
// indicating boundary conditions or excluded elements.
#figure([#block[
  #box(image("imgs/Qubit_ordering.png", width: 85.0%))
  ]],
  caption: [
    #strong[Qubit ordering and optimal cut for 56-qubit circuit with 20 cycles.] This order determines which qubits are used for $n$ qubits experiments. The green lines form the optimal cut for 56-qubit circuit with 20 cycles. 
  ]
)
<Qubit-ordering>


= XEB RESULT ANALYSIS
<xeb-result-analysis>
== XEB fidelity
<xeb-fidelity>


For a set of bitstrings ${ q_i }$, the cross-entropy benchmarking (XEB) fidelity is estimated from the ideal probabilities ${ p_i = p_s ( q_i ) }$ as


$ F_l = chevron.l D p chevron.r - 1 $<linearXEB>


$ F_c = chevron.l log ( D p ) chevron.r + gamma $<logarithmicXEB>


where $F_l$ is the linear XEB, $F_c$ is logarithmic XEB, and $gamma approx 0.577$ is the Euler-Mascheroni constant.


== Prediction of circuit fidelity
<prediction-of-circuit-fidelity>
As shown in Ref.~@arute2019quantum, the predicted fidelity $F$ could be calculated from a simple multiplication of individual operation fidelities as


$ F upright(=) product_(g in G_1) ( 1 - e_g ) product_(g in G_2) ( 1 - e_g ) product_(q in Q) ( 1 - e_q ) $<fidelitycal>


where $e_g$ are the individual gate Pauli errors, $G_1$ and $G_2$ are the set of single-qubit gates and two-qubit gates, respectively, $Q$ is the set of qubits, and $e_q$ are the state preparation and measurement errors of individual qubits.


== Performance of patch circuits and elided circuits
<performance-of-patch-circuits-and-elided-circuits>


Considering that it is unrealistic to verify the fidelity of the large-scale quantum circuits on current supercomputer, thus two verifiable quantum circuits, patch circuits and elided circuits, are introduced to provide approximate predictions of system performance. In the patch circuits, all two-qubit gates across the partitions are elided, which is essentially two disconnected circuits running in parallel. Compared to patch circuits, only a fraction of the two-qubit gates along the cut during a few early cycles of the sequence is elided in the elided circuits.


We evaluate the efficacy of using patch circuits and elided circuits for performance estimation via a direct comparison with full circuits. In @XEB_Patch, the XEB fidelities measured by full, patch and elided circuit of systems from 15 to 56 qubits with 10 cycles are displayed. The fidelities derived from patch and elided circuits exhibit a consistent exponential decay with system size, and are in good agreement with the fidelities obtained with the corresponding full circuits. The average ratio of patch circuit and elided circuit fidelity to full circuit fidelity over all verification circuits are found to be 1.05 and 1.10, with a standard deviation of 8\% and 9\%, dominated by system fluctuations.


// [figvision] imgs/XEB_Patch.png
// This panel is a 2D line plot with a logarithmic vertical axis and a linear horizontal axis, set against a
// white background with light gray grid lines. The horizontal axis is labeled "Number of qubits" and ranges from
// 10 to 56, with major tick marks at intervals of 10. The vertical axis is labeled "XEB fidelity" and spans from
// 10^-3 to 10^0 on a log scale. Three data series are plotted, each represented by a solid line with circular
// markers: green for "Full circuits," blue for "Elided circuits," and red for "Patch circuits." All three curves
// show a downward trend as the number of qubits increases, starting near a fidelity of 0.3 at 15 qubits and
// dropping to approximately 0.005 at 56 qubits. The blue and red lines track closely together and generally stay
// slightly above the green line, indicating that elided and patch circuits maintain fidelity comparable to full
// circuits across the tested range.
#figure([#block[
  #box(image("imgs/XEB_Patch.png", width: 90.0%))
  ]],
  caption: [
    #strong[Performance of patch circuits and elided circuits.] Patch, elided and full circuit XEB fidelity from 15 to 56 qubits with 10 cycles, showing patch and elided circuits yields a fidelity value that is in good agreement with the one obtained with the corresponding full circuits. Each data point is averaged over 6 quantum circuit instances.
  ]
)
<XEB_Patch>



== Distribution of bitstring probabilities
<distribution-of-bitstring-probabilities>


For a circuit with sufficient depth, the distribution should be consistent with the theoretical prediction. For the bitstrings with fidelity using linear XEB, the theoretical PDF for the bitstring probability $p$ is


$ P_l ( x | hat(F_l) ) = ( hat(F_l) x + ( 1 - hat(F_l) ) ) e^(- x) $


where $x equiv D p$ is bitstring probability scaled by the dimension $D$.


The PDF for logarithmic XEB is


$ P_c ( x | hat(F_c) ) = ( 1 + hat(F_c) ( e^x - 1 ) ) e^(x - e^x) $


where $x equiv l o g ( D p )$.


For our elided quantum circuit with 56 qubits and 20 cycles, we sample around $1.9 times 10^7$ bitstrings from each of 10 instances and calculate the linear XEB $hat(F_l)$ or logarithmic XEB $hat(F_c)$. Then we calculate the ideal probability $p$ of each bitstring to check whether it fits the theoretical curve $P_l ( x | hat(F_l) )$ and $P_c ( x | hat(F_c) )$. The result of one circuit instance is shown in @Fig.1.


// [figvision] imgs/probdist.png
// Panel (a) is a histogram plot showing the distribution of bitstring probabilities. The vertical axis, labeled
// "Counts," uses a logarithmic scale ranging from 10^-1 to 10^7. The horizontal axis, labeled "x = Dp," spans
// linearly from 0.0 to 20.0. A solid red line represents the theoretical curve P_I with an estimated fidelity
// F_I-hat of 0.00072, while light pink bars represent the experimental data. Both datasets exhibit an
// exponential decay trend; counts start near 10^6 at x=0 and decrease steadily as x increases, demonstrating a
// strong agreement between the theoretical model and experimental results. Panel (b) displays a histogram
// plotting the distribution of the logarithm of bitstring probabilities. The vertical "Counts" axis is
// logarithmic, spanning 10^0 to 10^7. The horizontal axis, labeled "x = logDp," ranges linearly from -15.0 to
// 5.0. A solid red line depicts the theoretical curve P_C with an estimated fidelity F_C-hat of 0.00073,
// overlaid on light pink bars representing experimental data. Unlike panel (a), this distribution rises from low
// counts at negative values to a distinct peak near x=0.0 with approximately 10^6 counts, before dropping
// sharply after x=2.5.
#figure([#block[
  #box(image("imgs/probdist.png", width: 90.0%))
  ]],
  caption: [
    #strong[Distribution of bitstring probabilities from a 56-qubit 20 -cycle circuit.] The theoretical curve is computed with the experimental XEB fidelity and experimental data is counted by histogram. (a) The theoretical curve $P_l ( x | hat(F_l) )$ and experimental distribution of $D p$. (b) The theoretical curve $P_c ( x | hat(F_c) )$ and experimental distribution of log($D p$).
  ]
)
<Fig.1>






// [figvision] imgs/fig2.png
// Panel (a) is a heatmap of Kolmogorov-Smirnov test p-values for linear XEB, arranged in an irregular grid of 49
// cells. Each cell contains a numerical value between 0.08 and 0.27, colored according to the vertical color bar
// on the right: blue shades indicate lower values (~0.1), white near 0.15–0.2, and red up to 0.27%. The average
// error e₁ is labeled below as 0.14%. No axes are shown; layout follows experimental or circuit index order.
// Reddest cells (e.g., 0.27) appear scattered, suggesting localized deviations from uniformity. Panel (b)
// displays another heatmap with 36 cells showing KS test p-values for log XEB, ranging from 1.34% to 9.92%.
// Color scale spans blue (low ~2%) to red (high ~8%), with one deep-red cell at 9.92% indicating strongest
// deviation. Average error eᵣ = 4.52% is noted below. Grid is rectangular but incomplete — some rows have fewer
// columns. Values increase toward center-right, peaking at row 5, column 4. Suggests systematic bias in
// logarithmic estimation under certain conditions. Panel (c) presents a 10x8 heatmap (80 cells) of KS test
// p-values for a third metric, likely related to error e₂. Values range from 0.29% to 1.25%, with color bar
// spanning blue (0.3%) to red (1.1%). One prominent red cell shows 1.25%. Average error e₂ = 0.59% is annotated
// beneath. Layout appears structured by input parameters or circuit depth/width. Highest deviations cluster
// mid-grid, implying sensitivity to specific configurations. All panels use consistent coloring scheme: low
// probability → blue, high → red.

We further use Kolmogorov-Smirnov test (K-S test)~@lehmann2006testing to quantify the agreements between experiment data and theoretical curve. K-S test quantifies a distance between the empirical cumulative distribution and the hypothetic cumulative distribution function, denoted as $D_(K S)$. $D_(K S)$ can be converted to $p$-value according to Kolmogorov distribution function. We use $p$-value to judge whether the hypothesis is good. We use kstest function in the scipy package~@jones2001scipy with the null hypothesis of $F = hat(F)$. For comparison, we implement KS-test with the null hypothesis of $F = 0$ as well.


We measure the XEB and do KS-test with bitstrings from ten instances combined. The linear XEB and logarithmic XEB fidelities from the combined bitstrings are $hat(F_l) = 6.60 times 10^(- 4)$ and $hat(F_c) = 5.80 times 10^(- 4)$, respectively. The KS-test results are shown in @tab1. With null hypothesis of $F = 0$, the p-value is around $9.7 times 10^(- 11)$. We can reject the null hypothesis confidently.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 7,
    align: (center,center,center,center,center,left,left,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.vline(x: 4, stroke: 0.4pt),
    table.vline(x: 5, stroke: 0.4pt),
    table.vline(x: 6, stroke: 0.4pt),
    table.vline(x: 7, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header(table.cell(align: left)[], table.cell(align: center, colspan: 2)[linear XEB], table.cell(align: center, colspan: 4)[log XEB],),
    table.hline(),
    [hypothesis], [$F = hat(F_l)$], [$F = 0$], [$F = hat(F_c)$], table.cell(align: center, colspan: 3)[$F = 0$],
    [$p$-value], [0.23], [$9.7 times 10^(- 11)$], [0.66], table.cell(align: center, colspan: 3)[$9.7 times 10^(- 11)$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [#strong[Results of combined Kolmogorov-Smirnov test for random circuits with 56-qubit, 20 cycles.]]
  , kind: table
  )
<tab1>



== Statistical uncertainties
<statistical-uncertainties>


We estimate the statistical uncertainty of XEB measurements with standard error-on-mean formula $  & hat(sigma)_(F_l) = D sqrt("Var" ( p ) / N_s) , \
    & hat(sigma)_(F_c) = sqrt("Var" ( log D p ) / N_s) , $<eq.3> where Var($x$) is the variance estimator of sample${ x_i }$. We use inverse-variance weighting to estimate the fidelity and statistical uncertainty of all nine 56-qubit and 20-cycle random circuits, yields the results of$hat(F_l) = ( 6.62 plus.minus 0.72 ) times 10^(- 4)$for linear XEB and$hat(F_c) = ( 5.82 plus.minus 0.92 ) times 10^(- 4)$for logarithmic XEB. The theoretical prediction of the statistical uncertainty of linear XEB$hat(F_l)$and logarithmic XEB$hat(F_c)$ are


$  & hat(sigma)_(F_l) = sqrt(( 1 + 2 F - F^2 ) / N_s) , \
    & hat(sigma)_(F_c) = sqrt(( pi^2 / 6 - F^2 ) / N_s) , $which are calculated as$hat(sigma)_(F_l) = 7.2 times 10^(- 5)$and$hat(sigma)_(F_c) = 9.2 times 10^(- 5)$, respectively, indicating good agreements between experiment and theory.


We further use bootstrap method to verify the estimate of statistical uncertainties. For a 56-qubit 20-cycle circuit, we sample bitstrings from experiment and calculate their ideal probabilities to be the original sample. We acquire 2500 bootstrap samples from the original one and compute $F = hat(F_l)$, $F = hat(F_c)$ of every sample. We expect the set of $F = hat(F)$ follow Gaussian distribution under the central limit theorem. The fidelity distribution of bootstrap samples with Gaussian fit are shown in @Fig.3. We compare the statistical uncertainty obtained from equation (@eq.3), Gaussian fit and the standard deviation of the bootstrap distribution. The results are $2.41 , 2.40 , 2.36 ( times 10^(- 4) )$ for $hat(sigma)_(F_l)$ and $3.09 , 3.16 , 3.07 ( times 10^(- 4) )$ for $hat(sigma)_(F_c)$. It indicates great consistency within $3 "%"$ relative difference.


// [figvision] imgs/fig3.png
// Panel (a) displays a histogram plot titled "Distribution of bootstrapping fidelities" with the subtitle "(a)
// Linear XEB distribution." The vertical axis, labeled "Counts," uses a logarithmic scale ranging from 10^0 to
// slightly above 10^2. The horizontal axis represents "Linear cross entropy fidelity" on a linear scale,
// spanning approximately -3 to 13, with a multiplier label 10^{-4} indicating the values are in the range of
// roughly -3 10^{-4} to 1.3 10^{-3}. Light pink bars represent the data histogram, showing a bell-shaped
// frequency distribution that peaks near an x-value of 4. A solid red line overlays the bars, representing a
// Gaussian fit that closely tracks the central trend of the histogram data. Panel (b) presents a similar
// histogram plot labeled "(b) Log XEB distribution." The y-axis is identical to panel (a), labeled "Counts" on a
// log scale from 10^0 to over 10^2. The x-axis is labeled "Cross entropy fidelity" and ranges from approximately
// -5 to 17, also scaled by a factor of 10^{-4}. The light pink histogram bars depict the data distribution,
// which forms a symmetric curve peaking around an x-value of 5 or 6. A solid red line indicates the Gaussian
// fit, matching the shape of the underlying data distribution effectively.
#figure([#block[
  #box(image("imgs/fig3.png", width: 90.0%))
  ]],
  caption: [
    #strong[Fidelity distribution of bootstrap samples.] (a) Linear XEB distribution. (b) Log XEB distribution.
  ]
)
<Fig.3>



= CLASSICAL SIMULATION
<classical-simulation>
== The efficiency of Schrödinger simulator
<the-efficiency-of-schr-dinger-simulator>
In the hybrid SchrödingerFeynman algorithm (SFA) simulator, each path is simulated using the Schrödinger algorithm (SA). The Schrödinger algorithm is a full state vector simulator for simulating quantum circuit. It computes all $2^n$ amplitudes, where $n$ is the number of qubits. In this section, we will test the performance of the Schrödinger simulator.


Following the work in Ref.~@arute2019quantum, gate fusion~@smelyanskiy2016qhipster and single precision arithmetic are used in our simulator. We simulate quantum circuits on a single node server that has 1536 GB memory and four CPUs (Intel-Xeon-Gold-6254, 3.1G) with 18 cores each. To compare with the performance of the Schrödinger simulator in Ref.~@arute2019quantum, we test random circuits with different sizes at depth 14. The run times are listed in #ref(<tab:Schrodinger-simulator>). Results show that the performance of our simulator is basically the same as that of Google~@arute2019quantum.


#figure(
  align(center)[#table(
    columns: 3,
    align: (center,center,center,),
    table.header([number of qubits], [#block[
      #figure(
        align(center)[#table(
          columns: 1,
          align: (center,),
          [run time in seconds],
          [\(ours)],
        )]
        , caption: [#strong[Circuit simulation run times using Schrödinger simulator.] ]
        , kind: table
        )

      ] ], [#block[
      #figure(
        align(center)[#table(
          columns: 1,
          align: (center,),
          [run time in seconds],
          [\(Google's~@arute2019quantum)],
        )]
        , caption: [#strong[Circuit simulation run times using Schrödinger simulator.] ]
        , kind: table
        )

      ] ],),
    table.hline(),
    [$30$], [24], [NA],
    [$32$], [93], [111],
    [$33$], [190], [NA],
    [$34$], [362], [473],
    [$36$], [1836], [1954],
  )]
  , caption: [#strong[Circuit simulation run times using Schrödinger simulator.] ]
  , kind: table
  )

<tab:Schrodinger-simulator>



== Tensor network simulator
<tensor-network-simulator>


Tensor network contraction (TNC) algorithm translates the task of computing a single or a branch of amplitudes into contracting a tensor network, where each tensor corresponds to a quantum gate operation. The complexity of TNC algorithm is controled by the largest intermediate tensor which appears during the contraction, which is also related to the tree width of the line graph corresponding to the tensor network. As a result the ultimate performance of TNC algorithm is determined by the underlying tensor contract path. In this work we use the python package cotengra to find an optimal tensor contraction path, which has been demonstrated to be able to reproduce the state of the art results in Ref.~@HuangChen2020 @pan2021simulating. For each random quantum circuit, we repeated the 100 path search procedure to determine the optimal tensor contraction path and use its corresponding number of floating point operations for contraction as the estimated computational cost.


In the main text, the modified frugal rejection sampling~@arute2019quantum @markov2018quantum with acceptance probability $1$ is used to estimate the cost of tensor network algorithm on specific circuits~@VillalongaMandra2019 @HuangChen2020. In Ref.~@pan2021simulating, a subspace sampling trick is proposed, which has been proven to be able to fool linear XEB. However, it is easy to distinguish this type of sampling, since some positions in the sampled bitstrings are fixed to 0, such as $x_1 x_2 x_3 x_400000000$, where $x_i$ is a variable bit.


In Ref.~@HuangChen2020 @pan2021simulating, the actual cost of tensor network contraction using GPU is provided, which could be regard as reference to estimate the actual cost of our circuit in supercomputer, such as Summit (Summit has 27,648 GPUs in total, but Fugaku has no GPUs, therefore we utilize Summit to determine the actual cost). Take the results in Ref.~@HuangChen2020 as an example, it would cost 833.75s to generate one perfect sample for a tensor network with $6.66 times 10^18$ contraction cost using Summit. Thus, it would cost $frac(1.10 times 10^22, 6.66 times 10^18) times 833.75 upright("s") upright(=) 15.9$ days and $frac(2.08 times 10^24, 6.66 times 10^18) times 833.75 upright("s") upright(=) 8.24$ years to reproduce the same results as the 53-qubit 20-cycle circuit in Ref.~@arute2019quantum and our 56-qubit 20-cycle circuit using Summit.


== Computational cost estimation of SFA for the sampling task
<computational-cost-estimation-of-sfa-for-the-sampling-task>
Here, we estimate the computational cost of simulating 56 qubit full-circuits using SFA. For the 56-qubit random circuit with 20 cycles, there are 42 gates cross the cut. The iSWAP-like gate has a Schmidt rank of 4. However, the first one and last three iSWAP-like gates can be simplified to cphase with a Schmidt rank of 2. In the case of simulating quantum circuit with $100 "%"$ fidelity, a total of $4^38 times 2^4$ paths must be calculated. By using the technique of #emph[prefix]~@markov2018quantum to optimize the simulator, we set a prefix of 35 cross gates (a cross gate can be simplified to a cphase gate), thus requiring $4^34 times 2^1$ separate runs.


We simulate the quantum circuit for the first 10 prefix values on a single node server that has 1536 GB memory and four CPUs (Intel-Xeon-Gold-6254, 3.1G) with 18 cores each.


The average execution time for each prefix is 19560 seconds using single core and single thread. Thus, it is estimated that it will consume $1.06 times 10^18$ core (two hyperthreads) hours to simulate the 56-qubit 20-cycle circuit with 0.0662\% fidelity. @tab:qsimhruntime also shows the extrapolated run times for Google's 53-qubit 20-cycle circuit ~@arute2019quantum using our SFA simulator ($8.9 times 10^13$ core hours).


#figure(
  align(center)[#table(
    stroke: none,
    columns: 5,
    align: (center,center,center,center,center,),
    table.vline(x: 0, stroke: 0.4pt),
    table.vline(x: 1, stroke: 0.4pt),
    table.vline(x: 2, stroke: 0.4pt),
    table.vline(x: 3, stroke: 0.4pt),
    table.vline(x: 4, stroke: 0.4pt),
    table.vline(x: 5, stroke: 0.4pt),
    table.hline(stroke: 0.8pt),
    table.header([\# of qubits], [cycle], [number of paths], [fidelity], [run time (years)],),
    table.hline(),
    [$53$], [20], [$4^31 times 2^4$], [0.224$"%"$], [1,332],
    [$56$], [20], [$4^38 times 2^4$ (balance)], [0.0662$"%"$], [15,887,738],
    [$56$], [20], [$4^35 times 2^6$ (imbalance)], [0.0662$"%"$], [8,612,623],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [#strong[Run times of SFA using 7,630,848 CPU cores] (the most powerful supercomputer Fugaku has a total of 7,630,848 cores). ]
  , kind: table
  )
<tab:qsimhruntime>



We note that in the results in @tab:qsimhruntime, we also provide a result of using the imbalance cut shown in @imbalanced_cut, which consumes less time ($5.76 times 10^17$ core hours) but consumes more storage space. In addition, we did not consider the DCD formation in our estimation. The DCD formation appears twice in our 56-qubit 20-cycle circuit, and also twice in Google's 53-qubit 20-cycle circuits. Thus, after considering the simulating speedup by DCD formation, we have


$ T_(56 _ 20) / T_(53 _ 20) = frac(8612623 med upright("years"), 4^2) / frac(1332 med upright("years"), 4^2) approx 6466 $


where $T_(56 _ 20)$ and $T_(53 _ 20)$ are the run time of simulating our 56-qubit 20 cycle circuit and Google's 53-qubit 20-cycle circuit, respectively. That is, using the SFA algorithm, the computational cost of simulating our 56-qubit 20-cycle circuit is about 6466 times that of Google's 53-qubit 20-cycle circuit.


// [figvision] imgs/imbalanced_cut.png
// Panel a displays a schematic diagram of a graph partitioned into three distinct regions based on node and edge
// styling. The graph consists of circular nodes numbered 0 through 65, arranged in a staggered grid topology
// where each node connects to neighbors above and below it. The upper region contains nodes 1 through 40,
// depicted with white fills and dark blue outlines, connected by solid dark blue edges. This group represents
// the first partition containing 32 qubits. The lower region includes nodes 31, 36, 37, 41, and all nodes from
// 43 to 64, rendered with black outlines and white fills, connected by solid black edges; this constitutes the
// second partition of 24 qubits. Along the far left and right peripheries, faint pink nodes (0, 5, 6, 18, 24,
// 30, 42, 54, 60, 65) appear with light pink connections, indicating excluded or boundary elements. A jagged cut
// separates the two main partitions, highlighted by bright green edges connecting specific boundary pairs:
// 25-31, 32-37, 38-44, 39-45, 40-46, and 35-41. These green links represent the interface between the balanced
// partitions under an allowed imbalance constraint of 20.
#figure([#block[
  #box(image("imgs/imbalanced_cut.png", width: 85.0%))
  ]],
  caption: [
    #strong[Imbalance cut.] We set the allowed imbalance of two partitions to 20 ($n_1 - n_2 lt.eq 20$), and employ the search strategy in Section IV to find the optimal cut. The number of qubits in the two partitions are 32 and 24, respectively.
  ]
)
<imbalanced_cut>



== Classical speedup for imbalanced gates
<classical-speedup-for-imbalanced-gates>
The iSWAP-like$( theta , phi.alt )$ gate has the following Schmidt singular values:


$ lambda_1 & = sqrt(1 + 2 dot.op | c o s ( phi.alt / 2 ) c o s theta | + c o s^2 theta) ,\
lambda_2 & = sin ( theta ) ,\
lambda_3 & = sin ( theta ) ,\
lambda_4 & = sqrt(1 - 2 dot.op | c o s ( phi.alt / 2 ) c o s theta | + c o s^2 theta) , $


We have $theta approx pi / 2$ and $phi.alt approx pi / 6$ in our experiment, so $lambda_i approx 1 , forall i in ( 1 , 2 , 3 , 4 )$. When simulating the random circuit sampling with a target fidelity using SFA simulator, inbalanced iSWAP-like gates can provide acceleration for the simulation. According to the Ref.~@arute2019quantum,~


if $100 "%"$ fidelity is required, a total of $4^g$ paths must be calculated. However, given a target fidelity, $F$, one need consider only the top $S$ paths with the highest weight, making


$ F = sum_(i = 1)^S W_i / 4^g , $


where $W_i = lambda_(i_1)^2 lambda_(i_2)^2 dots.h lambda_(i_g)^2$ is the weight of each path arising from this decomposition. For comparison, if all iSWAP-like gates are balanced with $theta upright(=) pi / 2$, the number of paths needs to be considered is $F times 4^g$. Thus, imbalanced gates provides a speedup equal to $frac(S, F times 4^g)$.


// [figvision] imgs/fSim_gates_distribution.png
// Panel a displays a cumulative probability distribution plot for the absolute deviation |δθ| of iSWAP-like
// gates. The horizontal axis represents |δθ| ranging from 0.00 to 0.07, while the vertical axis indicates
// proportion from 0.0 to 1.0. A single blue step function illustrates the data trend, starting flat near zero
// until approximately 0.012. The curve then rises steadily, crossing the 0.5 proportion mark around 0.034 and
// reaching saturation at 1.0 near 0.068. This visualization demonstrates that the majority of experimental gate
// deviations are concentrated below 0.05, indicating high consistency in gate performance relative to the
// theoretical ideal.
#figure([#block[
  #box(image("imgs/fSim_gates_distribution.png", width: 100%))
  ]],
  caption: [
    #strong[Cumulative probability distribution of $| delta_theta |$ for iSWAP-like gates.] In experiment, we have an average $| delta_theta | approx 0.036$ for all iSWAP-like gates. The resulted speedup of classical simulation is less than an order.
  ]
)
<fSimgatesdistribution>



// [figvision] imgs/imbalanced_gates.png
// Panel a is a line plot showing speedup versus the absolute value of delta theta. The vertical axis, labeled
// Speedup, uses a logarithmic scale ranging from 10^0 to 10^2. The horizontal axis, labeled |delta_theta|, spans
// linearly from 0.00 to 0.12. Six distinct series represent different fidelity values (F), plotted as colored
// lines with circular markers: blue for F=0.0001, orange for F=0.0003, green for F=0.0005, red for F=0.0008,
// purple for F=0.001, and brown for F=0.0014. All curves originate near the coordinate (0,1) and exhibit an
// upward exponential trend. An annotation in the bottom right corner specifies g=42. Lower fidelity values
// correspond to steeper slopes, indicating greater speedup. Panel b is a line plot displaying speedup against
// the absolute value of delta theta. The y-axis, labeled Speedup, follows a logarithmic scale from 10^0 to 10^2,
// while the x-axis, labeled |delta_theta|, ranges linearly from 0.00 to 0.12. Seven series are depicted using
// colored lines with circular markers, representing varying g values: blue for g=10, orange for g=15, green for
// g=20, red for g=25, purple for g=30, brown for g=35, and pink for g=42. Each curve starts at approximately
// (0,1) and rises exponentially. A label in the lower right indicates F=0.0662%. Higher g values result in
// steeper curves, demonstrating that increased g leads to significantly higher speedup for a given deviation.
#figure([#block[
  #box(image("imgs/imbalanced_gates.png", width: 110.0%))
  ]],
  caption: [
    #strong[Classical speedup given by the imbalance gates.] We assume all iSWAP-like gates deviate from $pi / 2$ by the same $delta_theta$ and calculate the speedup with given $g$ and $F$. #emph[Left:] speedup with varied fidelity $F$ and fixed $g = 42$. #emph[Right:] speedup with varied g and fixed $F = 0.0662 "%"$.
  ]
)
<imbalancedgates>




// [figvision] imgs/0.figr.png
// Panel (a) is a log-log plot showing the runtime advantage region for a 2x error rate. The horizontal axis
// represents the number of qubits, m, ranging from 5 to 1000, and the vertical axis represents circuit depth, n,
// ranging from 10 to 5000. A light blue shaded area in the bottom-left corner indicates the Supercomputer
// Advantage (SA) region, while a pink shaded area on the right indicates the Scalable Fault-Tolerant Advantage
// (SFA) region. Three black contour lines curve downwards across the plot, labeled "1s", "1d", and "1y" to
// represent quantum computer runtimes of one second, one day, and one year respectively. Panel (b) displays the
// same log-log coordinate system with axes for qubits (m) and circuit depth (n) spanning 5 to 1000 and 10 to
// 5000, respectively. This panel corresponds to a 1x error rate. The light blue SA region is slightly larger
// than in the previous panel, extending further along the x-axis. The pink SFA region remains on the right side.
// The three black quantum runtime contours ("1s", "1d", "1y") are shifted upwards compared to panel (a),
// indicating that higher circuit depths are sustainable at this lower error rate for the same runtime duration.
// Panel (c) illustrates the scenario for a 0.5x error rate using the identical log-log axes for qubits (m) and
// circuit depth (n). The light blue SA region expands significantly towards the center of the graph compared to
// panels (a) and (b). The pink SFA region persists on the far right. The black contour lines representing
// quantum runtimes of 1 second, 1 day, and 1 year are positioned highest in this sequence, demonstrating that
// halving the error rate allows for much deeper circuits before classical simulation becomes more efficient.
#figure(
  image("imgs/0.figr.png", width: 100%),
  caption: [
    #strong[Runtime advantage region of different error rates.] The colored regions indicate classical runtime advantage beyond the quantum computer within the limit of supercomputer memory. Runtime advantage depends on the circuit depth $m$ and number of qubits $n$. Red and blue region indicates SA advantage and SFA advantage, respectively. The black contours indicate runtime of quantum computer. From (a) to (c), the average error rates of quantum computer are $2 times$, $1 times$, $0.5 times$ our current experimental error rates.
  ]
)
<Fig.6>


In our experiment, the iSWAP-like gate that need to be decomposed is iSWAP-like$( pi / 2 plus.minus delta_theta , phi.alt approx pi / 6 )$, and $| delta_theta |$ has values of around 0.036 radians (see @fSimgatesdistribution). The speedup can be achieved from the imbalanced gates is shown in @imbalancedgates. For the case of random circuit sampling with $n = 56$ qubits and $m = 20$ cycles, the fidelity is around $F = 0.0662 "%"$ and the number of iSWAP-like gate need to be decomposed is $g = 42$ using SFA simulator, the speedup estimated would be well below an order of magnitude (see @imbalancedgates).


== Quantum runtime advantage region
<quantum-runtime-advantage-region>


Tensor network algorithms may have higher simulation efficiency at low depths. However, for large-scale quantum circuit with high depth, SFA is still the most efficient algorithm at present. In this section, we first analyze the scaling of the computational cost of SA and SFA, then we give a rough estimate of the quantum runtime advantage region. There may be other classical simulator with better performance, but this estimate is just to illustrate the importance of improving the fidelity of quantum operations, including quantum gates and readouts.


For a $n$-qubit quantum circuit with $m$ cycles, the runtime of SA is estimated as


$ T_(upright("SA")) = C_(upright("SA"))^(- 1) dot.op m n dot.op 2^n $


where the constant $C_(upright("SA"))$ is fit to the actual runtime of a state-of-the-art supercomputer. SA needs $2^(n + 1)$ bytes to store the complex state vector. Considering that state-of-the-art supercomputers have less than 3 PB of memory, the maximum number of qubits that can be simulated using the SA simulator is 51 at most.


For SFA, the runtime is proportional to the number of paths and the time to simulate patches. In Ref.~@arute2019quantum, the circuit is cut into 2 patches.


However, for larger-scale quantum circuits, we can cut the circuit into more than 2 patches. According to the Ref.~@zlokapa2020boundaries, we need to simulate the $2^(k p B m sqrt(n)) F$ paths for $p$ patches, where $k = 1 / 2 + 1 / p$, $B = 0.24$, and $F$ is the fidelity of circuit. The time to simulate each patch scales with $2^(n / p)$. In addition, we compute the partial amplitudes of min$( F^(- 2) , 2^n )$ bitstrings after simulating each patch. In total, the runtime is~@zlokapa2020boundaries


$ T_(upright("SFA")) = C_(upright("SFA"))^(- 1) 2^(k p B m sqrt(n)) F ( p 2^(n / p) + upright("min") ( F^(- 2) , 2^n ) ) , $


where $C_(upright("SFA"))$ is fit to the actual runtime of a state-of-the-art supercomputer. We can optimize the runtime with $F^(- 2) = p 2^(n / p)$ for $n > upright("log")_2 ( p ) / ( 1 - 1 / p )$. SFA requires $2 p 2^(n / p)$ bytes per path. Assuming that each path is simulated by a single core, then we estimate the total memory footprint to be $10^6 dot.op 2 p 2^(n / p)$ for a supercomputer with 1M cores. Memory usage limits the number of patches, which should be taken into account when optimizing the runtime of SFA.


We compare the runtime of classical simulation with quantum runtime to give a rough estimate of the quantum runtime advantage region. For this purpose, we use the classical fitting constants in Ref.~@arute2019quantum to continue the discussion.


$  & C_(upright("SA")) = 0.015 times 10^6 upright("GHz")\
 & C_(upright("SFA")) = 3.3 times 10^6 upright("GHz") $<eq.9>


The runtime of quantum computer is proportional to the number of samples. To ensure the standard deviation is less than the fidelity, i.e. $sigma lt.eq F_(upright("XEB"))$, at least $1 / F^2$ samples are required. The runtime of quantum computer scales as


$ T_(upright("Q")) = frac(1, C_(upright("QC")) dot.op F^2) $


where $C_(upright("QC")) = 1 / 230$MHz is the actual sampling rate of our quantum computer.


To compare the runtime of different methods, we fit constants in @eq.9 and $F$ from @fidelitycal into the runtime estimation discussed above and optimize the runtime of SFA. In addition, the memory constraint is taken into account. The result is shown in Fig.~#ref(<Fig.6>, supplement: none). The quantum advantage region (white) indicates the ability of quantum computer beyond classical computer. It is worth mentioning that the quantum advantage region enlarges rapidly when error rates decline, indicating the importance of low error rates.

#{
  show bibliography: set text(size: 9pt)
  bibliography("refs_supp.bib", title: none)
}