#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
// revtex4-2 [reprint]: full-width title/abstract, two-column body, and a single
// cross-column float (egin{figure*}) that spans both columns.
#set page(paper: "us-letter", numbering: none, margin: (x: 1.9cm, top: 1.85cm, bottom: 2.15cm), columns: 2)
// pagenum
#set page(header: context {
  if counter(page).get().first() > 1 {
    align(right, text(size: 10pt)[#counter(page).get().first()])
  }
})

#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("I.", p.at(0)) } else if p.len() == 2 { numbering("A.", p.at(1)) } else { numbering("1.1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 9pt, weight: "bold")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, leading: 0.45em)
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(spacing: 0.54em, first-line-indent: (amount: 1.5em, all: true))
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: auto)
#show math.equation.where(block: true): set align(center)

#place(top + center, scope: "parent", float: true)[
  #align(center)[
    #text(12pt, weight: "bold", [Quantum error correction below the surface code threshold])
    #v(0.5em)
    #text(8pt)[Google Quantum AI and Collaborators]
  ]
  #v(0.5em)

  #align(left)[
// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: August 27, 2024)]]

    #text(8.5pt)[Quantum error correction~@shor1995scheme@gottesman1997stabilizer@dennis2002topological@kitaev2003fault provides a path to reach practical quantum computing by combining multiple physical qubits into a logical qubit, where the logical error rate is suppressed exponentially as more qubits are added. However, this exponential suppression only occurs if the physical error rate is below a critical threshold. In this work, we present two surface code memories operating below this threshold: a distance-7 code and a distance-5 code integrated with a real-time decoder. The logical error rate of our larger quantum memory is suppressed by a factor of $Lambda = 2.14 plus.minus 0.02$ when increasing the code distance by two, culminating in a 101-qubit distance-7 code with 0.143% $plus.minus$ 0.003% error per cycle of error correction. This logical memory is also beyond break-even, exceeding its best physical qubit's lifetime by a factor of $2.4 plus.minus 0.3$. We maintain below-threshold performance when decoding in real time, achieving an average decoder latency of 63 μs at distance-5 up to a million cycles, with a cycle time of 1.1 μs. To probe the limits of our error-correction performance, we run repetition codes up to distance-29 and find that logical performance is limited by rare correlated error events occurring approximately once every hour, or $3 times 10^9$ cycles. Our results present device performance that, if scaled, could realize the operational requirements of large scale fault-tolerant quantum algorithms.]
  ]
]

= INTRODUCTION
<introduction>
Quantum computing promises computational speedups in quantum chemistry @aspuru2005simulated, quantum simulation @lloyd1996universal, cryptography @shor1999polynomial, and optimization #cite(<farhi2001quantum>). However, quantum information is fragile and quantum operations are error-prone. State-of-the-art many-qubit platforms have only recently demonstrated $99.9 %$ fidelity entangling gates @mckay2023benchmarking@decross2024computational, far short of the $< 10^(- 10)$ error rates needed for many applications @campbell2021early#cite(<kivlichan2020improved>). Quantum error correction is postulated to realize high-fidelity logical qubits by distributing quantum information over many entangled physical qubits to protect against errors. If the physical operations are below a critical noise threshold, the logical error should be suppressed exponentially as we increase the number of physical qubits per logical qubit. This behavior is expressed in the approximate relation $ epsilon_d prop (p / p_"thr")^( (d + 1) / 2 ) $ for error-corrected surface code logical qubits~@kitaev2003fault@dennis2002topological#cite(<fowler2012surface>). Here, $d$ is the code distance indicating $2 d^2 - 1$ physical qubits used per logical qubit, $p$ and $epsilon_d$ are the physical and logical error rates respectively, and $p_"thr"$ is the threshold error rate of the code. Thus, when $p lt.double p_"thr"$, the error rate of the logical qubit is suppressed exponentially in the distance of the code, with the error suppression factor $Lambda = epsilon_d/epsilon_(d + 2) approx p_"thr"/p$ representing the reduction in logical error rate when increasing the code distance by two. While many platforms have demonstrated different features of quantum error correction~@ryan2021realization@krinner2022realizing@sivak2023real@google2023suppressing@bluvstein2024logical@gupta2024encoding@da2024demonstration, no quantum processor has definitively shown below-threshold performance.

Although achieving below-threshold physical error rates is itself a formidable challenge, fault-tolerant quantum computing also imposes requirements beyond raw performance. These include features like stability over the hours-long timescales of quantum algorithms~@gidney2021factor and the active removal of correlated error sources like leakage~#cite(<terhal2005fault>). Fault-tolerant quantum computing also imposes requirements on classical coprocessors -- namely, the syndrome information produced by the quantum device must be decoded as fast as it is generated~#cite(<terhal2015quantum>). The fast operation times of superconducting qubits, ranging from tens to hundreds of nanoseconds, provide an advantage in speed but also a challenge for decoding errors both quickly and accurately.

In this work, we realize surface codes operating below threshold on two superconducting processors. Using a 72-qubit processor, we implement a distance-5 surface code operating with an integrated real-time decoder. In addition, using a 105-qubit processor with similar performance, we realize a distance-7 surface code. These processors demonstrate $Lambda > 2$ up to distance-5 and distance-7, respectively. Our distance-5 quantum memories are beyond break-even, with distance-7 preserving quantum information for more than twice as long as its best constituent physical qubit. To identify possible logical error floors, we also implement high-distance repetition codes on the 72-qubit processor, with error rates that are dominated by correlated error events occurring once an hour. These errors, whose origins are not yet understood, set a current error floor of $10^(- 10)$. Finally, we show that we can maintain below-threshold operation on the 72-qubit processor even when decoding in real time, meeting the strict timing requirements imposed by the processor's fast 1.1 μs cycle duration.

= A SURFACE CODE MEMORY BELOW THRESHOLD
<a-surface-code-memory-below-threshold>

We begin with results from our 105-qubit processor depicted in #ref(<surface_code>)a. It features a square grid of superconducting transmon qubits~@koch2007charge with improved operational fidelities compared to our previously reported processors~@arute2019quantum#cite(<google2023suppressing>). The qubits have a mean operating $T_1$ of 68 μs and $T_(2 , "CPMG")$ of 89 μs, which we attribute to improved fabrication techniques, participation ratio engineering, and circuit parameter optimization. Increasing coherence contributes to the fidelity of all of our operations which are displayed in #ref(<surface_code>)b.
// [figvision] imgs/fig1.png
// Panel a is a schematic of a distance-7 surface code on a 105-qubit processor. A square lattice alternates
// yellow data qubits and blue measure qubits, each measure qubit centred on a blue stabilizer tile. Small labels
// mark d=3, d=5 and d=7 across the top. A red outline encloses one of nine distance-3 codes arranged as an
// array; an orange outline marks one of four distance-5 codes at the corners; a thick black outline traces the
// full distance-7 code. Green features denote leakage removal, and leader lines label data qubit and measure
// qubit. Panel b plots cumulative distribution (y, 0 to 1) versus error probability on a logarithmic x-axis from
// 10^-4 to 10^-1. Four S-shaped curves run left to right: red 1Q, black CZ, orange Idle and cyan Meas. Vertical
// lines indicate each mean, labelled 1Q, CZ, Idle in orange, Det. and Meas. in cyan. The distributions span
// roughly 3×10^-4 to almost 10^-1, so readout (Meas.) error is broadest and shifted to the highest
// probabilities, while single-qubit (1Q) error is lowest. Panel c plots logical error probability p_L (y, 0.0 to
// 0.5) against quantum error correction cycle t (x, 0 to 250). Distance-3 uses downward triangles: gray filled
// d=3 (2023), red filled d=3 mean, light red open individual shots. Distance-5 uses black filled hexagons d=5
// (2023), cyan filled circles d=5 mean and light cyan open circles individual. Distance-7 is blue filled
// circles. A yellow dashed line marks the median physical qubit and a green dash-dot line the best physical
// qubit. Error grows with t and falls with distance: d=3 nears ~0.5, d=5 reaches ~0.41, while d=7 stays near
// ~0.23 at t=250. Panel d plots logical error per cycle ε_d on a logarithmic y-axis (10^-3 to 10^-2) versus
// surface code distance d on the x-axis at d = 3, 5 and 7. A red downward triangle at d=3, a cyan circle at d=5
// and a blue circle at d=7 decrease with distance, fitted by a blue line annotated Λ = 2.14 ± 0.02. The inset
// spans roughly d = 3 to 11 and y = 10^-4 to 10^-2, showing gray open circles marked Sim. connected by a line
// together with the measured points; text lists ε₃ = 2.15 ± 0.02, ε₅ and ε₇ = 2.12 ± 0.04.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering). #it.body]
}

#figure(placement: top, scope: "parent", image("imgs/fig1.png", width: 100%),
  caption: [
    #strong[Surface code performance.] #strong[a,] Schematic of a distance-7 surface code on a 105-qubit processor. Each measure qubit (blue) is associated with a stabilizer (blue colored tile). Red outline: one of nine distance-3 codes measured for comparison ($3 times 3$ array). Orange outline: one of four distance-5 codes measured for comparison (4 corners). Black outline: distance-7 code. We remove leakage from each data qubit (gold) via a neighboring qubit below it, using additional leakage removal qubits at the boundary (green). #strong[b,] Cumulative distributions of error probabilities measured on the 105-qubit processor. Red: Pauli errors for single-qubit gates. Black: Pauli errors for CZ gates. Blue: Average identification error for measurement. Gold: Pauli errors for data qubit idle during measurement and reset. Teal: weight-4 detection probabilities (distance-7, averaged over 250 cycles). #strong[c,] Logical error probability, $p_L$, for a range of memory experiment durations. Each datapoint represents $10^5$ repetitions decoded with the neural network and is averaged over logical basis ($X_L$ and $Z_L$). Black and grey: data from Ref.~@google2023suppressing for comparison. Curves: exponential fits after averaging $p_L$ over code and basis. To compute $epsilon_d$ values, we fit each individual code and basis separately. #strong[d,] Logical error per cycle, $epsilon_d$, reducing with surface code distance, $d$. Uncertainty on each point is less than $5 times 10^(- 5)$. Symbols match panel c. Means for $d = 3$ and $d = 5$ are computed from the separate $epsilon_d$ fits for each code and basis. Line: fit to Eq.~1, determining $Lambda$. Inset: simulations up to $d = 11$ alongside experimental points, both decoded with ensembled matching synthesis for comparison. Line: fit to simulation, $Lambda_"sim" = 2.25 plus.minus 0.02$.
  ]
)
<surface_code>


We also make several improvements to decoding, employing two types of offline high-accuracy decoders. One is a neural network decoder~@bausch2023learning, and the other is a harmonized ensemble~@shutty2024efficient of correlated minimum-weight perfect matching decoders~@fowler2013optimal augmented with matching synthesis~#cite(<jones2024improved>). These run on different classical hardware, offering two potential paths towards real-time decoding with higher accuracy. To adapt to device noise, we fine-tune the neural network with processor data~@bausch2023learning and apply a reinforcement learning optimization to the matching graph weights~#cite(<sivak2024optimization>).

We operate a distance-7 surface code memory comprising 49 data qubits, 48 measure qubits, and 4 additional leakage removal qubits, following the methods in Ref.~#cite(<google2023suppressing>). Summarizing, we initiate surface code operation by preparing the data qubits in a product state in either the $X_L$ or $Z_L$ basis of the #emph[ZXXZ] surface code~#cite(<bonilla2021xzzx>). We then repeat a variable number of cycles of error correction, during which measure qubits extract parity information from the data qubits to be sent to the decoder. Following each syndrome extraction, we run data qubit leakage removal (DQLR)~@miao2023overcoming to ensure that leakage to higher states is short-lived. We measure the state of the logical qubit by measuring the individual data qubits and then check whether the decoder's corrected logical measurement outcome agrees with the initial logical state.

From surface code data, we can characterize the physical error rate of the processor using the bulk error detection probability~#cite(<hesner2024using>). This is the proportion of weight-4 stabilizer measurement comparisons that detect an error. The surface code detection probabilities are $p_"det" = ( 7.7 % , 8.5 % , 8.7 % )$ for $d = ( 3 , 5 , 7 )$. We attribute the increase in detection probability with code size to finite size effects~@supplement and parasitic couplings between qubits. We expect both effects to saturate at larger processor sizes~#cite(<klimov2024optimizing>).

We characterize our surface code logical performance by fitting the logical error per cycle $epsilon_d$ up to 250 cycles, averaged over the $X$ and $Z$ bases. We average the performance of 9 different distance-3 subgrids and 4 different distance-5 subgrids to compare to the distance-7 code. Finally, we compute the error suppression factor $Lambda$ using linear regression of $ln ( epsilon_d )$ versus $d$. With our neural network decoder, we observe $Lambda = 2.14 plus.minus 0.02$ and $epsilon_7$ = $( 1.43 plus.minus 0.03 ) times 10^(- 3)$ (see #ref(<surface_code>)c-d). With ensembled matching synthesis, we observe $Lambda = 2.04 plus.minus 0.02$ and $epsilon_7$ = $( 1.71 plus.minus 0.03 ) times 10^(- 3)$.

Furthermore, we simulate logical qubits of higher distances using a noise model based on the measured component error rates in #ref(<surface_code>)b, additionally including leakage and stray interactions between qubits~@google2023suppressing#cite(<supplement>). These simulations are shown alongside the experiment in the inset of #ref(<surface_code>)d, both decoded with ensembled matching synthesis. We observe reasonable agreement with experiment and decisive error suppression, affirming that the surface codes are operating below threshold.

Thus far, we have focused on the error suppression factor $Lambda$, since below threshold performance guarantees that physical qubit lifetimes and operational fidelities can be surpassed with a sufficiently large logical qubit. In fact, our distance-7 logical qubit already has more than double the lifetime of its constituent physical qubits. While comparing physical and logical qubits is subtle owing to their different noise processes, we plot a direct comparison between logical error rate and physical qubit error rate averaged over $X$ and $Z$ basis initializations in #ref(<surface_code>)c. To quantify qubit lifetime itself, we average uniformly over pure states using the metric proposed in Refs.~@sivak2023real#cite(<supplement>). The distance-7 logical qubit lifetime is $291 plus.minus 6$ μs, exceeding the lifetimes of all the constituent physical qubits (median $85 plus.minus 7$ μs, best $119 plus.minus 13$ μs) by a factor of $2.4 plus.minus 0.3$. Our logical memory beyond break-even extends previous results using bosonic codes~@ofek2016extending@ni2023beating@sivak2023real to multi-qubit codes, and it is a critical step toward logical operation break-even.

= LOGICAL ERROR SENSITIVITY
<logical-error-sensitivity>
Equipped with below-threshold logical qubits, we can now probe the sensitivity of logical error to various error mechanisms in this new regime. We start by testing how logical error scales with physical error and code distance. As shown in #ref(<error_injection>)a, we inject coherent errors with variable strength on both data and measure qubits, and extract two quantities from each injection experiment. First, we use detection probability as a proxy for the total physical error rate. Second, we infer the logical error per cycle by measuring logical error probability at 10 cycles, decoding with correlated matching~#cite(<fowler2013optimal>).

In #ref(<error_injection>)b, we plot logical error per cycle versus detection probability for the distance-3, -5, and -7 codes. We find that the three curves cross near a detection probability of 20%, roughly consistent with the crossover regime explored in Ref.~#cite(<google2023suppressing>). The inset further shows that detection probability acts as a good proxy for $1/Lambda$. When fitting power laws below the crossing, we observe approximately 80% of the ideal value $(d + 1)/2$ predicted by Eq.~1. We hypothesize that this deviation is caused by excess correlations in the device. Nevertheless, higher distance codes show faster reduction of logical error, realizing the characteristic threshold behavior #emph[in situ] on a quantum processor.

// [figvision] imgs/fig2.png
// Panel a is a circuit diagram for one surface-code cycle with two horizontal lines: a top data qubit (yellow
// star) and a bottom measure qubit (blue circle). An orange Z^alpha coherent error is injected on the data
// qubit, then both lines receive H Hadamard gates. Vertical black bars are CZ entangling gates between the
// qubits. The data line then holds a yellow DD (dynamical decoupling) block, a Z^epsilon leakage-removal block,
// and H before M measurement and R reset; the measure line likewise ends H M R. A purple vertical arrow labeled
// Remove leakage spans the leakage-removal region, marking purple as data-qubit leakage removal (DQLR) and
// orange as injected coherent errors. Panel b is a log-log scatter of logical error per cycle epsilon_d versus
// mean detection probability p_det. Red downward triangles are d=3 mean, cyan diamonds d=5 mean, and blue
// circles d=7 mean, each with a black fit line; distance-3 averages over nine subset codes and distance-5 over
// four. p_det runs about 0.1 to 0.3 and epsilon_d from roughly 2e-3 to above 1e-1. All series collapse onto one
// rising line. An inset plots 1/Λ linearly versus p_det from 0 to 0.3 as black dots rising to about 2, with a
// 105Q annotation at lower left. Panel c is a horizontal stacked bar of the error budget plotted against 1/Λ
// from 0.0 to 0.5. From left to right the segments are black CZ (about 0.0–0.22), gray data idle (to about
// 0.28), then yellow, blue Meas., purple Leakage, and red IQ extending toward 0.5. Top labels read CZ stray int.
// over the left portion and Meas. and Leakage over the right; a small cz label sits under the black segment. CZ
// gates and stray interactions consume most of the error budget, with measurement and leakage smaller. Panel d
// plots logical error probability p_L from 0.00 to 0.20 versus QEC cycle t from 0 to 50, annotated 72Q at lower
// right. Four series appear: red down-triangles for d=3 without DQLR and d=3 with DQLR, cyan open circles for
// d=5 without DQLR, and cyan filled diamonds for d=5 with DQLR. All curves grow approximately linearly with
// cycle number; the d=3 curves reach about 0.20 at t=50, d=5 without DQLR reaches roughly 0.13, and d=5 DQLR
// filled diamonds stay lowest near 0.09. Leakage removal suppresses error accumulation, most strongly for
// distance five. Panel e plots logical error per cycle epsilon_d on a log axis from 1e-3 to 1e-2 versus time in
// hours from 0 to 15, annotated 72Q. Red filled down-triangles mark d=3 mean near roughly 8e-3 to 1e-2 at the
// top, red open down-triangles mark d=3 individual values scattered around 1e-2, and cyan diamonds mark d=5
// around 3e-3 to 5e-3 at the bottom. All series are essentially flat in time, showing a constant per-cycle
// logical error, with distance five about an order of magnitude below distance three over the 15-hour run.
#figure(placement: top, image("imgs/fig2.png", width: 100%),
  caption: [
    #strong[Error sensitivity in the surface code.] #strong[a,] One cycle of the surface code circuit, focusing on one data qubit and one measure qubit. Black bar: CZ, H: Hadamard, M: measure, R: reset, DD: dynamical decoupling. Orange: Injected coherent errors. Purple: Data qubit leakage removal (DQLR). #strong[b,] Error injection in the surface code. Distance-3 averages over 9 subset codes, and distance-5 averages over 4 subset codes, as in @surface_code. Logical performance is plotted against the mean weight-4 detection probability averaging over all codes, where increasing the error injection angle $alpha$ increases detection probability. Each experiment is 10 cycles with $2 times 10^4$ total repetitions. Lines: power law fits for data points at or below where the codes cross. Inset: Inverse error suppression factor, $1/Lambda$, versus detection probability. Line: fit to points with $1/Lambda < 1$. #strong[c,] Estimated error budget for the surface code based on component errors and simulations. CZ: CZ error, excluding leakage and stray interactions. CZ stray int.: CZ error from unwanted interactions. Data idle: Data qubit idle error during measurement and reset. Meas.: Measurement and reset error. Leakage: Leakage during CZs and due to heating. 1Q: Single-qubit gate error. #strong[d,] Comparison of logical performance with and without data qubit leakage removal each cycle. Distance-3 points (red triangles) are averaged over four quadrants. Each experiment is $10^5$ repetitions. Curves: exponential fits. #strong[e,] Repeating experiments to assess performance stability, comparing distance-3 and distance-5. Each point represents a sweep of logical performance versus experiment duration, up to 250 cycles.
  ]
)
<error_injection>

To quantify the impact of correlated errors along with more typical gate errors, we form an error budget. Following the method outlined in Refs.~@google2023suppressing@chen2021exponential, we estimate the relative contribution of different component errors to $1/Lambda$. We run simulations based on a detailed model of our 72-qubit processor. The model includes local noise sources due to gates and measurements, as well as two sources of correlated error: leakage, and stray interactions during our CZ gates which can induce correlated $Z Z$ and swap-like errors~#cite(<supplement>). #ref(<error_injection>)c shows our estimated error budget for $1/Lambda$ in the 72-qubit processor when decoding with correlated matching. Applying the same decoder to experimental data, the error budget overpredicts $Lambda$ by 20%, indicating that most but not all error effects in our processor have been captured. Correlated errors make up an estimated 17% of the budget, and while not a dominant contributor, we expect their importance to increase as error rates decrease. Overall, both local and correlated errors from CZ gates are the largest contributors to the error budget. Consequently, continuing to improve both coherence and calibration will be crucial to further reducing logical error.

One potential source of excess correlations that we actively mitigate is leakage to higher excited states of our transmon qubits. During logical qubit operation, we remove leakage from measure qubits using multi-level reset. For data qubits, DQLR swaps leakage excitations to measure qubits (or additional leakage removal qubits)~#cite(<miao2023overcoming>). To examine sensitivity to leakage, we measure logical error probability of distance-3 and distance-5 codes in our 72-qubit processor with and without DQLR, with the results shown in Fig.~2d. While activating DQLR does not strongly affect distance-3 performance, it substantially boosts distance-5 performance, resulting in a 35% increase in $Lambda$. Comparatively, the detection probability decreases by only 12%~@supplement, indicating that detection probability is only a good proxy for logical error suppression if errors are uncorrelated. Overall, we find that addressing leakage is crucial to operating surface codes with transmon qubits~@varbanov2020leakage@krinner2022realizing#cite(<miao2023overcoming>).

Finally, we test sensitivity to drift. Using our 72-qubit processor, we measure logical performance of one distance-5 and four distance-3 codes 16 times over 15 hours, with the results shown in #ref(<error_injection>)e. Prior to the repeated runs, we employ a frequency optimization strategy which forecasts defect frequencies of two-level systems (TLS). This helps to avoid qubits coupling to TLSs during the initial calibration as well as over the duration of the experiments. Additionally, between every four experimental runs, we recalibrate the processor to account for potential qubit frequency and readout signal drift. We observe an average $Lambda = 2.18 plus.minus 0.07$ (standard deviation) and best $Lambda = 2.31 plus.minus 0.02$~@supplement when decoding with the neural network. While the performance of the worst distance-3 quadrant appears to fluctuate due to a transient TLS moving faster than our forecasts, this fluctuation is suppressed in the distance-5 code, suggesting that larger codes are less sensitive to component-level fluctuations. Additionally, the logical error rates of experiments right after drift recalibration are not appreciably lower than those just prior, indicating that our logical qubit is robust to the levels of qubit frequency and readout drift present. These results show that superconducting processors can remain stable over the hours-long timescales required for large scale fault-tolerant algorithms~#cite(<gidney2021factor>).

= PROBING THE ULTRA-LOW ERROR REGIME WITH REPETITION CODES
<probing-the-ultra-low-error-regime-with-repetition-codes>
Despite realizing below-threshold surface codes, orders of magnitude remain between present logical error rates and the requirements for practical quantum computation. In previous work running repetition codes, we found that high-energy impact events occurred approximately once every 10 seconds, causing large correlated error bursts which manifested a logical error floor around $10^(- 6)$~@McEwen2022. Such errors would block our ability to run error-corrected algorithms in the future, motivating us to reassess repetition codes on our newer devices.

// [figvision] imgs/fig3.png
// Panel a is a log-log plot of logical error per cycle ε_d versus code distance d. The y-axis spans 10^-12 to
// 10^-2 and the x-axis spans about 3 to 30. Open grey circles mark Rep. (2023) data, while filled black circles
// show repetition-code results from 100-cycle experiments with smaller codes subsampled and averaged over
// subsamples. A grey line is the exponential-fit error suppression p_d ∝ exp(−αd). Error suppression is clear as
// ε_d falls from about 10^-2 at d≈4 to roughly 10^-10 near d≈25, with error bars growing at large d. A "72Q"
// label appears at lower left. Panel b plots logical error per cycle ε_d (10^-7 to 10^-1) versus mean detection
// probability p_det (about 0.05 to 0.5), both on logarithmic scales. Multiple series are colour-coded by code
// distance d, from purple and blue for small d (d = 3, 5, 7, 9 labelled on the left) through cyan, green and
// yellow to red for large d, ending near d = 29 and 72Q at the right. Each series stays low then rises steeply
// as p_det approaches a threshold, illustrating error scaling with distance; the 72Q data forms the rightmost
// cluster. Text labels mark d = 3, 5, 7, 9, d = 29, and 72Q. Panel c shows 1/Λ (0.0 to 1.0) versus mean
// detection probability p_det (0.00 to 0.50) as black filled circles. The points lie on an approximately
// straight line rising from near zero at low p_det to about 0.9 at p_det = 0.50. A "72Q" label sits at lower
// right, indicating these data are for the 72-qubit device. The linear trend relates the inverse correlation
// length to detection probability. Panel d plots detection probability p_det (0.0 to 0.6) versus time (0.0 to
// about 2.8 ms). Four traces correspond to detection-probability quartiles: Quartile 4 (green), Quartile 3
// (teal), Quartile 2 (blue), Quartile 1 (purple), per the legend at upper right. An inset shows a colour-coded
// qubit array with a p_det colourbar from 0 to 0.5. A grey shaded band near 1.4 to 1.6 ms highlights a spike
// where p_det reaches about 0.5 for Quartile 4 before decaying; thin vertical lines mark about 1.0 ms and 2.0
// ms. p_det is otherwise near 0.05 to 0.15.
#figure(placement: top, image("imgs/fig3.png", width: 100%),
  caption: [
    #strong[High-distance error scaling in repetition codes.] #strong[a,] Logical error per cycle, $epsilon_d$, versus code distance, $d$, when decoding with minimum-weight perfect matching. Repetition code points are from $d = 29$, $10^3$-cycle experiments, $10^7$ repetitions for each basis $X$ and $Z$. We subsample smaller codes from the same $d = 29$ dataset, averaging over subsamples. Line: fit of error suppression factor $Lambda$. We include data from Rep.~@google2023suppressing for comparison. #strong[b,] Logical error scaling with injected error. We inject a range of coherent errors on all qubits and plot against observed mean detection probability $p_"det"$. Each experiment is 10 cycles, and we average over $10^6$ repetitions. Smaller code distances are again subsampled from $d = 29$. Lines: power law fits $epsilon_d = A_d p_"det"^( (d + 1)/2 )$ (one fit parameter, $A_d$), restricted to $epsilon_d > 10^(- 7)$ and $p_"det" < 0.3$. #strong[c,] $1/Lambda$ scaling with injected error. Typical relative fit uncertainty is 2%. Line: fit. #strong[d,] Example event causing elevated detection probabilities which decay exponentially with time constant $369 plus.minus 6$ μs (gray dashed line). Three consecutive experimental shots are plotted, delimited by vertical gray lines. The 28 measure qubits are divided into four quartiles based on average detection probability in the gray-shaded window. Each trace represents the detection probability averaged over one quartile and a time window of 10 cycles. Inset: Average detection probability for each measure qubit (colored circle) within the gray-shaded window.
  ]
)
<repetition_code>

Using our 72-qubit processor, we run a distance-29 repetition code for 1000 cycles of error correction over $2 times 10^7$ shots split evenly between bit- and phase-flip codes. In total, we execute $2 times 10^10$ cycles of error correction comprising 5.5 hours of processor execution time. Given the logical error probability $p_L$ at 1000 cycles, we infer the logical error per cycle as $epsilon_d = frac(1, 2) (1 - (1 - 2 p_L)^(1/1000))$. To assess how the logical error per cycle scales with distance-$d$, we follow Ref.~@chen2021exponential and subsample lower distance repetition codes from the distance-29 data.

Averaging over bit- and phase-flip repetition codes, we obtain an error suppression factor $Lambda = 8.4 plus.minus 0.1$ when fitting logical error per cycle versus code distance between $d = 5$ and 11, as shown in #ref(<repetition_code>)a. Notably, the error per cycle is suppressed far below $10^(- 6)$, breaking past the error floor observed previously. We attribute the mitigation of high-energy impact failures to gap-engineered Josephson junctions~#cite(<mcewen2024resisting>). However, at code distances $d gt.eq 15$, we observe a deviation from exponential error suppression at high distances culminating in an apparent logical error floor of $10^(- 10)$. Although we do not observe any errors at distance-29, this is likely due to randomly decoding correctly on the few most damaging error bursts. While this logical error per cycle might permit certain fault-tolerant applications~@campbell2021early, it is still many orders of magnitude higher than expected and precludes larger fault-tolerant circuits~@gidney2021factor#cite(<kivlichan2020improved>).

When we examine the detection patterns for these high-distance logical failures, we observe two different failure modes. The first failure mode manifests as one or two detectors suddenly increasing in detection probability by over a factor of 3, settling to their initial detection probability tens or hundreds of cycles later~#cite(<supplement>). These less damaging failures could be caused by transient TLS's appearing near the operation frequencies of a qubit, or by coupler excitations, but might be mitigated using methods similar to Refs.~@varbanov2020leakage#cite(<strikis2023quantum>). The second and more catastrophic failure mode manifests as many detectors experiencing a larger spike in detection probability simultaneously; an example is shown in #ref(<repetition_code>)d. Notably, these anisotropic error bursts are spatially localized to neighborhoods of roughly 30 qubits (see inset). Over the course of our $2 times 10^10$ cycles of error correction, our processor experienced six of these large error bursts, which are responsible for the highest-distance failures. These bursts, such as the event shown in #ref(<repetition_code>)d, are different from previously observed high-energy impact events~#cite(<google2023suppressing>). They occur approximately once an hour, rather than once every few seconds, and they decay with an exponential time constant around 400 μs, rather than tens of milliseconds. We do not yet understand the cause of these events, but mitigating them remains vital to building a fault-tolerant quantum computer. These results reaffirm that long repetition codes are a crucial tool for discovering new error mechanisms in quantum processors at the logical noise floor.

Furthermore, while we have tested the scaling law in Eq.~1 at low distances, repetition codes allow us to scan to higher distances and lower logical errors. Following a similar coherent error injection method as in the surface code, we show the scaling of logical error versus physical error and code distance in #ref(<repetition_code>)b-c, observing good agreement with $O(p^((d + 1)/2))$ error suppression. For example, reducing detection probability by a factor of 2 manifests in a factor of 250 reduction in logical error at distance-15, consistent with the expected $O ( p^8 )$ scaling. This shows the dramatic error suppression that should eventually enable large scale fault-tolerant quantum computers, provided we can reach similar error suppression factors in surface codes.

= REAL-TIME DECODING
<real-time-decoding>
In addition to a high-fidelity processor, fault-tolerant quantum computing also requires a classical coprocessor that can decode errors in real time. This is because some logical operations are non-deterministic; they depend on logical measurement outcomes that must be correctly interpreted on the fly~#cite(<terhal2015quantum>). If the decoder cannot process measurements fast enough, an increasing backlog of syndrome information can cause an exponential blow-up in computation time. Real-time decoding is particularly challenging for superconducting processors due to their speed. The throughput of transmitting, processing, and decoding the syndrome information in each cycle must keep pace with the fast error correcting cycle time of 1.1 μs. Using our 72-qubit processor as a platform, we demonstrate below-threshold performance alongside this vital module in the fault-tolerant quantum computing stack.

Our decoding system begins with our classical control electronics, where measurement signals are classified into bits then transmitted to a specialized workstation via low-latency Ethernet. Inside the workstation, measurements are converted into detections and then streamed to the real-time decoding software via a shared memory buffer. We employ a specialized version of the Sparse Blossom algorithm~@higgott2023sparse optimized to quickly resolve local configurations of errors common in surface code decoding, using a parallelization strategy similar to Ref.~@Paler2023pipelinedcorrelated. The decoder operates on a constant-sized graph buffer which emulates the section of the error graph being decoded at any instant, but which does not grow with the total number of cycles used in the experiment. Different threads are responsible for different spacetime regions of the graph, processing their requisite syndrome information as it is streamed in~@skoric2023parallel@tan2023scalable@wu2023fusion#cite(<bombin2023modular>). These results are fused until a global minimum-weight perfect matching is found. The streaming decoding algorithm is illustrated in Fig.~4a-b. We also use a greedy edge reweighting strategy to increase accuracy by accounting for correlations induced by $Y$-type errors~@fowler2013optimal#cite(<paler2023pipelined>).

In #ref(<decoding>)d, we report the decoder latency, which we define as the time between the decoding software receiving the final cycle of syndrome measurements and the time when the decoder returns its correction. For our distance-5 surface code, we test different problem sizes by increasing the number of error correction cycles up to $10^6$. We observe that the average latency remains roughly constant at a net average of $63 plus.minus 17$ μs independent of the length of the experiment (up to 1.1 seconds), indicating that the decoding problem is being processed in real time. This latency will eventually determine the reaction time of the logical processor when enacting non-Clifford gates, but does not yet include feedback into the logical circuit.

Importantly, we are able to maintain below-threshold performance even under the strict timing requirements imposed by real-time decoding. We run a dedicated experiment on our 72-qubit processor to compare real-time decoding to high-accuracy offline neural network decoding of the same data, with the results shown in #ref(<decoding>)c. Our real-time decoder achieves $epsilon_5 = 0.35 % plus.minus 0.01 %$ and $Lambda = 2.0 plus.minus 0.1$ using a device-data-independent prior. Meanwhile, the neural network decoder achieves $epsilon_5 = 0.269 % plus.minus 0.008 %$ and $Lambda = 2.18 plus.minus 0.09$ when later decoding offline. The modest reduction in accuracy when comparing the real-time decoder to an offline decoder is expected as the real-time decoder must operate significantly faster. It requires a throughput of less than 1.1 μs per cycle compared to the neural network's 24  μs per cycle~#cite(<bausch2023learning>). However, we do expect that many of our high-accuracy decoding methods can eventually be made real-time by introducing techniques like layered or windowed decoding~@skoric2023parallel@tan2023scalable#cite(<shutty2024efficient>).

// [figvision] imgs/fig4.png
// Panel a is a schematic timeline of the streaming decoding algorithm. A repeating error-graph lattice runs
// horizontally from Past on the left to Future on the right. A central Graph buffer bracket spans processing
// cycles 0 through 5, with cycle boundaries marked 0, 1, 2, 3, 4, 5 along the top. Left of cycle 0 is labelled
// Complete; the buffer is Processing; immediately right is Now then Not started (red hatching). Colour bands
// denote completion status rather than data values. The message is that decoding proceeds in blocks within a
// sliding buffer while future blocks remain unstarted. Panel b is a task-graph schematic with three rows
// labelled Blossom, Fuse, Fuse and columns 0 to 5. Boxes are coloured blue (0,1), yellow (2,3), and pink (4,5),
// matching panel a. Arrows descend from Blossom boxes to the first Fuse row, pairing adjacent blocks (0,1),
// (2,3), (4,5); a second Fuse row fuses those pairs ((1,2), (3,4)) with ellipses indicating continuation (…0,
// 5…). The message is that detections may match block boundaries and are resolved in downstream fuse steps.
// Panel c is a scatter plot with logarithmic y-axis p_z from 10^-3 to 10^-2 and categorical x-axis labelled RT
// Ens. NN. Legend series distinguish distance d=3 (triangles) and d=5 (circles/pentagons) in blue, orange, and
// red, with a black d=3/d=5 marker key. Points occupy three horizontal p_z levels near 10^-2, several 10^-3, and
// 10^-3 across the x categories. The message is that logical error probability p_z is shown for ensemble and
// neural-network decoders at two distances. Panel d plots latency in microseconds (y-axis, log scale 30 to 300
// µs) against number of cycles (x-axis, log scale 10^3 to 10^6). Violin distributions with overlaid dots show
// Shot latency in blue and Sub-shot latency in orange at repeated cycle counts. Blue violins centre near 50 to
// 100 µs; orange violins centre higher, near 100 to 200 µs. Both are approximately flat across cycle counts.
// Label 72Q appears bottom right. The message is that latency is cycle-independent and sub-shot decoding is
// slower.
#figure(placement: top, image("imgs/fig4.png", width: 100%),
  caption: [
    #strong[Real-time decoding.] #strong[a,] Schematic of the streaming decoding algorithm. Decoding problems are subdivided into blocks, with different threads responsible for different blocks. #strong[b,] Task graph for processing blocks. Detections are allowed to match to block boundaries, which will then be processed downstream during a fuse step. If a configuration of detection events cannot be resolved by a future fuse step, the decoder heralds failure. We use 10-cycle blocks to ensure that the heralded failure rate is negligible compared to the logical failure rate. #strong[c,] Accuracy comparison for the surface code with three decoders. We include the real-time decoder (RT), ensembled matching synthesis (Ens.), and the neural network decoder (NN). Uncertainty on each point is less than $10^(- 4)$. #strong[d,] Decoder latency versus experiment duration. The blue points correspond to end-of-shot latencies (10 shots per duration, horizontal bar: median, blue shading: violin plot). The yellow histograms represent sub-shot latencies obtained by checking how long after each 10-cycle block's data is received that the block is completed by the decoder. The sub-shot latencies tend to be slightly longer than end-of-shot latencies as the decoder may need to wait to fuse with detection events in future cycles in order to process up to the current cycle.
  ]
)
<decoding>

= OUTLOOK
<outlook>
In this work, we have demonstrated a below-threshold surface code memory. Each time the code distance increases by two, the logical error per cycle is reduced by more than half, culminating in a distance-7 logical lifetime more than double its best constituent physical qubit lifetime. This signature of exponential logical error suppression with code distance forms the foundation of running large scale quantum algorithms with error correction.

Our error-corrected processors also demonstrate other key advances towards fault-tolerant quantum computing. We achieve repeatable performance over several hours and run experiments up to $10^6$ cycles without deteriorating performance, both of which are necessary for future large scale fault-tolerant algorithms. Furthermore, we have engineered a real-time decoding system with only a modest reduction in accuracy compared to our offline decoders.

Even so, many challenges remain ahead of us. Although we might in principle achieve low logical error rates by scaling up our current processors, it would be resource intensive in practice. Extrapolating the projections in #ref(<surface_code>)d, achieving a $10^(- 6)$ error rate would require a distance-27 logical qubit using 1457 physical qubits. Scaling up will also bring additional challenges in real-time decoding as the syndrome measurements per cycle increase quadratically with code distance. Our repetition code experiments also identify a noise floor at an error rate of $10^(- 10)$ caused by correlated bursts of errors. Identifying and mitigating this error mechanism will be integral to running larger quantum algorithms.

However, quantum error correction also provides us exponential leverage in reducing logical errors with processor improvements. For example, reducing physical error rates by a factor of two would improve the distance-27 logical performance by four orders of magnitude, well into algorithmically-relevant error rates~@campbell2021early#cite(<kivlichan2020improved>). We further expect these overheads will reduce with advances in error correction protocols~@litinski2022active@chamberland2022universal@bravyi2024high@xu2024constant@gidney2023yoked@gidney2024inplace@cain2024correlated and decoding~@smith2023local@barber2023real#cite(<liyanage2024fpga>).

The purpose of quantum error correction is to enable large scale quantum algorithms. While this work focuses on building a robust memory, additional challenges will arise in logical computation~@gidney2022stability#cite(<lin2024spatially>). On the classical side, we must ensure that software elements including our calibration protocols, real-time decoders, and logical compilers can scale to the sizes and complexities needed to run multi-surface-code operations~#cite(<bombin2023logical>). With below-threshold surface codes, we have demonstrated processor performance that can scale in principle, but which we must now scale in practice.

= AUTHOR CONTRIBUTIONS
<author-contributions>
The Google Quantum AI team conceived and designed the experiment. The theory and experimental teams at Google Quantum AI developed the data analysis, modeling and metrological tools that enabled the experiment, built the system, performed the calibrations, and collected the data. All authors wrote and revised the manuscript and the Supplementary Information.

= ACKNOWLEDGEMENTS
<acknowledgements>
We are grateful to S.~Brin, S.~Pichai, R.~Porat, and J.~Manyika for their executive sponsorship of the Google Quantum AI team, and for their continued engagement and support.

= ETHICS DECLARATIONS
<ethics-declarations>
The authors declare no competing interests.

= ADDITIONAL INFORMATION
<additional-information>
Supplementary Information is available for this paper. Correspondence and requests for materials should be addressed to H. Neven (neven\@google.com).

= DATA AVAILABILITY
<data-availability>
The data that support the findings of this study are available at~#link("https://doi.org/10.5281/zenodo.13273331").

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "ieee", title: [References])


#pagebreak()
#counter(heading).update(0)
#counter(math.equation).update(0)
#counter(figure).update(0)
#include "supplement.typ"