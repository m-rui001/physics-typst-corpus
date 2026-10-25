#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10pt, lang: "en")
#set page(paper: "us-letter", numbering: "1", margin: (x: 1.9cm, top: 1.85cm, bottom: 2.15cm), columns: 2)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else if e != none and e.func() == figure and e.fields().at("kind") == table {
    [Table~S#context counter(figure.where(kind: table)).at(e.location()).first()]
  } else { it }
}
#set heading(numbering: (..n) => if n.pos().len() == 1 { numbering("I.", n.pos().at(0)) } else { numbering("A.", n.pos().at(1)) })
#set figure(numbering: n => "S" + str(n - 4))
#show figure.where(kind: table): set figure(numbering: "S1")
#show figure.where(kind: table): set figure.caption(position: top)
#set par(justify: true, leading: 0.49em)
#set figure.caption(position: bottom)
#set figure(placement: top)
#show math.equation.where(block: true): set align(center)

#place(top + center, scope: "parent", float: true)[
  #text(17pt, weight: "bold", [Supplementary Information for "Quantum error correction below the surface code threshold"])
  #v(1em)
  #text(10.5pt)[Google Quantum AI and Collaborators]
]
#pagebreak()

= Gates and Readout
<gates-and-readout>
Single-qubit gates are implemented using microwave $X Y$ rotations and virtual $Z$ rotations. On the 105-qubit processor, all $X Y$ rotations have 25 ns duration, while on the 72-qubit processor, $pi$ and $pi / 2$ rotations have 35 ns duration and 18 ns duration respectively. We implement our entangling operations using CZ gates. Our CZ gates are performed in 42 ns on the 105-qubit processor, and 37 ns on the 72-qubit processor.

Our measurement chain is similar to that of #cite(<google2023suppressing>), though with Lumped Element Snake Amplifiers (LESAs) #cite(<PhysRevApplied.20.054058>) replacing the previous impedance matched parametric amplifiers. The qubit frequency during readout, readout pulse duration, and readout pulse power are jointly optimized #cite(<PhysRevLett.132.100603>) to attain simultaneous high fidelity mid-circuit readout.

In main text Fig. ~1b, we show distributions of operation error probabilities for the 105-qubit processor. In @fig:edcfs, we repeat Fig. ~1b alongside equivalent measurements on the 72-qubit processor.

#figure(image("src/figures_sm/sup_72q_105q_ecdf.pdf"),
  caption: [
    #strong[Operation error probabilities.] See Fig. ~1b. Left: distribution of benchmark results for the 72-qubit processor configured to run the distance-5 surface code. Right: 105-qubit processor configured to run the distance-7 surface code (same as Fig. ~1b).
  ]
)
<fig:edcfs>

= Improvements in Control Techniques
<improvements-in-control-techniques>
== Frequency Optimization
<frequency-optimization>
We optimize single- and two-qubit gate frequency trajectories via the Snake optimizer #cite(<snake2020>). We leverage technology developed in Ref.~#cite(<snake2024>), highlighting two strategies that were especially helpful in boosting data qubit coherence. First, we constructed our optimization model directly around the error correction circuit. This strategy prioritizes data qubit coherence to a much greater extent than optimizing for interleaved layers of single- and two-qubit gates as in cross-entropy benchmarking. Second, we employed intermediate-dimensional optimization up to 9 dimensions. This strategy enables more complex trade-offs between data and measure qubits than lower dimensional optimization, without significantly compromising runtime.

To ensure that qubit coherence remained stable over multiple days of datataking, two stability optimization strategies were included into the Snake optimizer. Both were intended to mitigate catastrophic losses in coherence from frequency collisions with TLS, which are known to have time-dependent variations in their transition frequencies #cite(<Klimov:2018nem>). Both strategies leveraged information extracted from spectrally and temporally resolved qubit $T_1$ data. The first strategy modified the relaxation error component to penalize single-qubit gate frequencies which historically had reduced $T_1$. The second strategy sought to prevent frequency collisions with TLS by extracting frequency-temporal trajectories of TLS from historical $T_1$ data, forecasting them to future times, and excluding these frequencies from allowed single-qubit gate frequencies.

= Decoding
<decoding_supp>
== List of Decoders
<list-of-decoders>
#block[
#figure(
  align(center)[
    #set text(size: 8.5pt)
    #table(
    columns: (1.1cm, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (center,left,left,left,left,center,),
    stroke: 0.5pt,
    table.header(
      [], table.cell(colspan: 2)[#strong[Fig. 1d]], table.cell(colspan: 3)[#strong[Fig. 4c]],
      [], [Libra], [Neural network], [Real-time], [Libra], [Neural network],
    ),
    [$epsilon_3$], [$( 7.12 plus.minus 0.06 ) times 10^(- 3)$], [$( 6.50 plus.minus 0.06 ) times 10^(- 3)$], [$( 7.1 plus.minus 0.3 ) times 10^(- 3)$], [$( 6.1 plus.minus 0.2 ) times 10^(- 3)$], [$( 5.9 plus.minus 0.1 ) times 10^(- 3)$],
    [$epsilon_5$], [$( 3.49 plus.minus 0.04 ) times 10^(- 3)$], [$( 3.03 plus.minus 0.03 ) times 10^(- 3)$], [$( 3.5 plus.minus 0.1 ) times 10^(- 3)$], [$( 2.70 plus.minus 0.08 ) times 10^(- 3)$], [$( 2.69 plus.minus 0.08 ) times 10^(- 3)$],
    [$epsilon_7$], [$( 1.71 plus.minus 0.03 ) times 10^(- 3)$], [$( 1.43 plus.minus 0.03 ) times 10^(- 3)$], [], [], [],
  )]
  , caption: [
    #strong[Logical errors per cycle for different decoding schemes.] Here we report the logical error per cycle, $epsilon_d$, for different code distances $d$ and different decoding schemes (real-time, Libra #cite(<jones2024improved>), and neural network #cite(<bausch2023learning>)). These correspond to the values plotted in Fig.~1d and Fig.~4c of the main text.
  ]
  , kind: table
  ) <Suppl:table-logical-error-rates>

]
In this work, we use several different decoders depending on the context of the experiment. We use,

+ a neural network decoder introduced in Ref. #cite(<bausch2023learning>),

+ a matching synthesis decoder Libra recently introduced in Ref. #cite(<jones2024improved>) with an ensemble size of 51,

+ an ensembled matching decoder Harmony introduced in Ref. #cite(<shutty2024efficient>) with an ensemble size of 101 (unless otherwise specified),

+ a correlated matching decoder similar to that described in Ref.~#cite(<fowler2013optimalcomplexitycorrectioncorrelated>),

+ a real-time decoder with accuracy similar to Ref.~#cite(<Paler2023pipelinedcorrelated>).

Predictions for these decoders applied to various datasets reported in the paper, along with additional datasets not reported here, can be found at Ref.~#cite(<qec_datasets_zenodo_2024>). We note there are other accurate decoders that would be interesting to test on this data, including beliefmatching~#cite(<higgott2023improved>), BP+OSD~#cite(<roffe_decoding_2020>), and tensor network decoding~#cite(<google2023suppressing>).

== Decoder Priors
<decoder-priors>
We use two methods for configuring decoder priors. In experiments where maximizing the performance is not the main objective (error injection, real-time decoding demo), we use the SI1000 error model #cite(<gidney2021fault>). This error model is inspired by the typical hierarchy of error rates in superconducting qubits, but is otherwise agnostic to the device and decoder.

In experiments that require the highest accuracy, we use the learning-based approach for calibrating the decoder priors #cite(<sivak2024optimization>). In the learning-based approach, we adopt the hyperparameters from Ref. #cite(<sivak2024optimization>) for the surface code and train the prior on a “calibration dataset\" of duration 13 cycles, which precedes the rest of the experiment. The learned parameters of the prior are then used for decoding all datasets up to 250 cycles. Although we frequently decode the surface code using ensembles of matching decoders #cite(<shutty2024efficient>) #cite(<jones2024improved>), we use a faster correlated-matching decoder #cite(<higgott2023sparse>) for training. As was shown in #cite(<sivak2024optimization>), the learned priors generalize well across these two decoders.

Our optimization of the priors relies on the sensor technique detailed in Ref.~#cite(<sivak2024optimization>). For the distance-7 surface code, smaller patches of distance-3 and distance-5, shown in @fig:sub_grids_supplement(a,b), act as local sensors of the error landscape in the device. These sensor-codes are used to optimize the parameters of the prior, which is then applied to decoding the target distance-7 code. The sensor technique is especially important in the repetition code, as using the logical error rate (LER) of the target distance-29 code in the optimization loop becomes computationally infeasible. Instead, we optimize the prior with the help of 25 distance-5 sensors subsampled from the target code. For the minimum-weight perfect matching (MWPM) decoder, we find that training the prior results in $10 %$ average improvement of the LER at all distances relative to the SI1000 prior.

Additional characterization of decoders and priors on two datasets, `google_72Q_surface_code_d3_d5_set1` and `google_72Q_surface_code_d3_d5_set2`, is shown in @fig:super_weird_figure. The summary of the datasets, which we made publicly available in Ref.~#cite(<qec_datasets_zenodo_2024>), is presented in @Suppl:table-released-datasets.

On the first dataset, we find that the neural network decoder #cite(<bausch2023learning>) achieves the highest accuracy overall. Among the matching-based decoders we ran for @Suppl:table-released-datasets, the most performant configuration is Harmony #cite(<shutty2024efficient>), although we expect that augmenting with matching synthesis would further boost accuracy #cite(<jones2024improved>). We also use a reinforcement learning optimized prior #cite(<sivak2024optimization>). On the distance-5 code, just ensembling leads to a $1.14$ times lower LER on average than correlated matching with SI1000 prior. We expect this improvement will apply to real-time experiments as well, once ensembled matching is layered, parallelized, and incorporated into the real-time decoder, and if optimization of the prior can be done on a time scale faster than the device drift~#cite(<sivak2024optimization>). We consider both of these requirements feasible. We also note that while this characterization uses Harmony as described in #cite(<shutty2024efficient>), the main text uses the recently-developed ensembled matching-synthesis decoder Libra~#cite(<jones2024improved>).

#figure(
  table(
    columns: (6.5fr, 2.6fr, 1.3fr, 1.9fr, 1.9fr, 1.6fr),
    align: (left, center, center, center, center, center),
    table.header(
      [#strong[Dataset]],
      [#strong[Number of] \ #strong[experiments]],
      [#strong[Basis]],
      [#strong[Distance]],
      [#strong[Cycles]],
      [#strong[Shots]],
    ),
    [
      `google_72Q_surface_code_d3_d5_set1` \
      This surface code dataset corresponds to Fig. 2(e) in the main text, which represents the last 16 experiments that were run consecutively.
    ],
    [21], [$X$, $Z$], [3, 5], [$1$ to $250$], [$5 times 10^4$],
    [
      `google_72Q_surface_code_d3_d5_set2` \
      Samples in this surface code dataset capture different calibration states of the device, ranging from well-calibrated with LER of the distance-5 code smaller than $3 times 10^(- 3)$ to poorly calibrated with LER approaching $10^(- 2)$. This selection is intended for testing the decoding algorithms under a wide range of experimental conditions.
    ],
    [35], [$X$, $Z$], [3, 5], [$5$ to $50$], [$6 times 10^4$],
    [
      `google_105Q_surface_code_d3_d5_d7` \
      This surface code dataset corresponds to Fig. 1(c,d) in the main text.
    ],
    [1], [$X$, $Z$], [3, 5, 7], [$1$ to $250$], [$5 times 10^4$],
    [
      `google_72Q_repetition_code_d29` \
      This repetition code dataset corresponds to Fig. 3(a) in the main text.
    ],
    [100], [$X$, $Z$], [29], [$10^3$], [$10^5$],
  ),
  caption: [
    #strong[QEC datasets.] Brief summary of the QEC datasets released in Ref.~#cite(<qec_datasets_zenodo_2024>). Further details can be found in each dataset's `README.md` file, including examples of data processing with open-source tools such as Stim #cite(<gidney2021stim>) and PyMatching #cite(<higgott2022pymatching>).
  ],
) <Suppl:table-released-datasets>
#figure(image("src/figures_sm/prior_opt_two_datasets.pdf"),
  caption: [
    #strong[Characterization of offline decoding methods.] The decoder calibration methods benchmarked here are the same as in Ref. #cite(<sivak2024optimization>). The first dataset corresponds to the 15-hour sweep in Fig.~2(e) of the main text. The second dataset contains experiments in which the device was well calibrated and experiments in which the calibrations have not been refreshed for several days. This selection is intended for testing the decoding algorithms under a wide range of experimental conditions.
  ]
)
<fig:super_weird_figure>

== Neural Network Decoder Details
<neural-network-decoder-details>
The machine learning decoder is the recurrent attention-based neural network described in #cite(<bausch2023learning>) which is trained to predict the logical error based on the stabilizer measurements of a surface code experiment. The network processes one cycle of stabilizer measurements at a time, updating an internal state representation which consists of a vector for each stabilizer. At the end of the experiment the state vectors are combined to produce a calibrated error probability.

As before, the networks (for both the 72-qubit and 105-qubit processors) are trained in two stages. We first pretrain on synthetic data from a generic noise model (SI1000 at $p = 0.4 %$ in this case) generated by Stim #cite(<gidney2021stim>). Separate models are trained for $X$ and $Z$ bases for distance-3, distance-5 and distance-7 experiments. We trained 5 separate models with different random seeds for each condition, resulting in 10 pretrained models per code distance that were the basis for all subsequent fine-tuning.

After pretraining, each network is further trained to match a specific experiment by fine-tuning using a limited quantity of experimental data. This fine-tuning stage is broken up into two steps: a first step during which we fine-tune with samples from a $p_(i j)$ detector error model fitted to the 13 cycle dataset, taken before the actual experiment #cite(<google2023suppressing>). In a second step the model is fine-tuned on the experimental samples themselves.

For fine-tuning on experimental data, and as in previous experiments #cite(<bausch2023learning>), we split the experimental data into multiple partitions for cross-validation. We further subdivide each partition into a training and validation set to choose an early-stopping time to prevent overfitting. Test performance is measured on the held out partition. Hyperparameters are chosen based on previous datasets, so no other evaluations are performed on this data.

We utilize various splits of the data. For the synthetic dataset, of which there are two identical copies, we fine-tune on one and test on the other. For the realtime and distance-7 datasets, of which there is only one, we utilize an even/odd split. For the "stability" experiment with multiple temporally spaced repeated memory experiments, we chose a truly causal scenario: For the $N$#super[th] dataset, we fine-tune with the detector error model (DEM) data from the $N$#super[th] set (since it was dependent only on the 13-cycle data captured at the start of that set) but subsequently fine-tune on the previous $( N - 1 )$#super[th] dataset. We find that this strict temporal split leads to similar accuracy as an even/odd split.

We use the architecture from Ref. #cite(<bausch2023learning>) without attention bias, without the residual network before the recurrent neural network and with only two layers in the readout network. Because the experimental data in this paper is of much longer duration (250 cycles vs.~25 for the data in #cite(<google2023suppressing>)) we add gated recurrence to the state update #cite(<Cho2014-ne>). Instead of adding the state and incoming stabilizer representations, these are concatenated and projected through a 3-layer multilayer perceptron to compute element-wise update and reset gates. The reset-gated state and new embeddings are concatenated before projection and processing by the syndrome transformer layers. The final output and state are summed, weighted by the update gate. We find this made the training more stable for long-duration experiments. We mostly train the network on synthetic data of up to 25 cycles, but periodically sample examples of lengths up to 200 to ensure generalization to long experiments. The simulated SI1000 examples has logical observable labels for every cycle up to and including the total length.

#block[
#figure(
  align(center)[
    #set text(size: 7.5pt)
    #table(
    columns: (2.55cm, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (right,left,left,left,left,left,left,left,left,center,),
    inset: (x: 2pt, y: 3pt),
    column-gutter: 2pt,
    stroke: 0.5pt,
    table.header(
      [], table.cell(colspan: 3)[#strong[Pretrain]], table.cell(colspan: 3)[#strong[Fine-tune (DEM)]], table.cell(colspan: 3)[#strong[Fine-tune (Experimental)]],
      [], [$times$3], [$times$5], [$times$7], [$times$3], [$times$5], [$times$7], [$times$3], [$times$5], [7$times$7],
    ),
    [#strong[Parameter count]], [5.411M], [5.419M], [5.432M], [], [], [], [], [], [],
    [#strong[Channels]], [256], [256], [256], [], [], [], [], [], [],
    [#strong[Training steps]], [1.56M], [5.86M], [5.86M], [195k], [781k], [10.9M], [#box[234k/15k$""^(*)$]], [#box[234k/15k$""^(*)$]], [#box[234k/15k$""^(*)$]],
    [#strong[Batch size]], [256], [256], [256], [256], [256], [256], [64/1024$""^(*)$], [64/1024$""^(*)$], [64/1024$""^(*)$],
    [#strong[Training examples]], [400M], [1500M], [1500M], [50M], [200M], [2800M], [#box[15M$""^dagger$]], [#box[15M$""^dagger$]], [#box[15M$""^dagger$]],
    [#strong[Learning rate]], [5e-6], [5e-6], [5e-6], [1.7e-6], [1.3e-6], [2e-6], [2e-7], [2.5e-7], [3e-7],
    [#strong[Weight decay]], [1e-5], [1e-5], [1e-5], [1e-5], [1e-4], [1e-3], [7e-5], [7e-5], [7e-5],
    [#strong[Cosine cycle]], [250M], [300M], [500M], [40M], [160M], [640M], [30M], [80M], [200M],
    [#strong[EMA step]], [1e-4], [1e-4], [1e-4], [1e-4], [1e-4], [1e-4], [8e-4], [8e-4], [8e-4],
  )]
  , caption: [
    #strong[Hyperparameters for the machine learning decoder.] #super[∗]For fine-tuning on the realtime and simulated data we choose a batch size of 1024; for the others a batch size of 64. #super[#sym.dagger]For fine-tuning with the even-odd (causal) split, we train on 258,440 (583,440) unique experimental samples: we keep 5120 validation set samples of each of the 25,000 (50,000) shots per split for each of the 13 experiment durations (10, 30, …, 250 cycles). For the real-time experiment we only have 5,000 examples per duration, so we train on 1700 and tested on 800 from each split. Consequently, training presents each example many times. For pretraining and DEM fine-tuning we are sampling data from a simulator so each training example is different.
  ]
  , kind: table
  ) <Suppl:ML_decoding_table>

]
== Real-Time Decoding System 
<real-time-decoding-system>
=== Technical Requirements
<technical-requirements>
In this section we provide a brief overview of general technical requirements for a real-time syndrome decoding system and describe the key aspects of the specific system employed in this work.

In the simplest quantum error correction experiments, syndrome data is saved in a file and processed by a decoder offline after the quantum circuit is finished executing on the quantum processor. This offline mode of syndrome decoding is insufficient for experiments involving fault-tolerant constructions, such as gate teleportation #cite(<Gottesman1999>) that use feed-forward, i.e. the capability to condition quantum operations on measurement outcomes. In order to support these more advanced experiments, one needs a fast decoder capable of computing logical measurement outcomes in real-time during the execution of a quantum circuit.

A real-time syndrome decoding system must satisfy requirements concerning three key performance metrics: accuracy, latency, and throughput. Decoding accuracy is characterized by the per-cycle probability that the logical measurement outcome computed by the decoder is correct.

Decoding latency, $T_(upright("decode"))$, is the delay between when the measurement outcomes of the physical qubits comprising a logical qubit become known and when the measurement outcome of the logical qubit becomes known. This is an important contributor to the overall reaction time, $T_(upright("react"))$, which is the time it takes the quantum computer's control system to react to a logical measurement by executing a dependent logical operation #cite(<gidney2019flexiblelayoutsurfacecode>). Inverse reaction time is the rate at which quantum computer can execute logical operations that require feed-forward for fault-tolerance, such as the $T$-gate in the surface code. Thus, inverse reaction time plays the role of clock speed of a quantum computer.

In more detail, the reaction time is given by the sum $ T_(upright("react")) = T_(upright("decode")) + T_(upright("control")) $ of the decoding latency $T_(upright("decode"))$ and the time $T_(upright("control"))$ that the control system spends executing quantum gates, obtaining measurement outcomes for physical qubits, and reacting to the logical measurement outcomes provided by the real-time decoding system. In a non-error-corrected processor with feed-forward, we have $T_(upright("decode")) = 0$ and the reaction time is just $T_(upright("control"))$. Decoding latency $T_(upright("decode"))$ constitutes most of the overhead of the quantum error correction layer.

In a software-based real-time syndrome decoding system, we can break decoding latency down into software latency and I/O latencies, $ T_(upright("decode")) = T_(upright("input")) + T_(upright("software")) + T_(upright("output")) $ where $T_(upright("software"))$ is the latency of the software components of the decoding system, and $T_(upright("input"))$ and $T_(upright("output"))$ are the input and output latencies of the hardware-software interface which facilitates exchange of information between the quantum computer's control electronics and the decoding software.

Another requirement for a real-time decoding system concerns its throughput, i.e. the amount of syndrome information it is capable of processing per unit time. Decoding throughput must be at least as high as the amount of syndrome information generated per unit time. Failure to satisfy this requirement causes syndrome backlog to accumulate and leads to exponential slowdown of the quantum computer #cite(<RevModPhys.87.307>).

// [figvision] src/figures_sm/subshot_latency_v2.png
// Panel (a): Scatter plot of sub-shot latency versus cycle count for a distance-5 surface code over 10^6 cycles.
// The x-axis spans 0 to 10^6 cycles with ticks every 2×10^5. The y-axis spans 0 to 1200 μs in 200 μs increments,
// labelled Sub-shot Latency (μs). Blue dots mark individual latency measurements, mostly clustered below 200 μs
// with a baseline near 50–100 μs. A yellow moving-average line tracks the low baseline but rises during spikes.
// Sharp vertical latency spikes reach approximately 1000–1200 μs near cycles 0, 1.5×10^5, 2×10^5, 2.8×10^5,
// 4.2×10^5, 6.5×10^5, 7.2×10^5, and 8.5×10^5. The message is stable real-time decoding performance with
// occasional, brief latency spikes.
#figure(image("src/figures_sm/subshot_latency_v2.png"),
  caption: [
    #strong[Sub-shot latency as a function of cycles within a single experiment.] Sub-shot latency is defined as the delay from the moment a ten-cycle block of syndrome data is acquired by the software decoding system to the point when the block is fully processed by the decoder during a single experimental run. We observe stable real-time decoding performance with occasional, brief latency spikes from which the system recovers rapidly.
  ]
)
<fig:latency_vs_block_number_single_run>

In order to establish real-time performance of our decoding system we measured $T_(upright("software"))$ as a function of circuit depth, as shown for a single representative experiment using a quantum circuit with one million cycles in @fig:latency_vs_block_number_single_run. We see that $T_(upright("software"))$ is roughly constant as a function of time. Moreover, when the latency spikes the system is able to recover quickly. Measurements from many experiments with different number of cycles are shown in @fig:latency_vs_circuit_depth. Stability of $T_(upright("software"))$ together with evidence that all syndrome information has been analyzed by the decoder, proves that the system processes syndrome information at the rate at which it is generated.

Measurements indicate that in our current real-time decoding system $T_(upright("input")) < 10$ μs. In a hypothetical system with the addition of $T_(upright("output"))$ and $T_(upright("control"))$ in the range of a few microseconds, the reaction time would be within an order of magnitude from that assumed in Ref.~#cite(<Gidney2021howtofactorbit>). Improving decoding latency while scaling the system to larger code distances is an outstanding engineering challenge on the path to large-scale fault-tolerant quantum computing.

There are trade-offs between accuracy, latency, and throughput. For example, aggressive batching of syndrome or intermediate information may increase throughput at the expense of increased latency. Similarly, a decoder that short-circuits rare and computationally hard cases of syndrome decoding by making a random guess may achieve higher throughput and lower latency at the expense of reduced accuracy. The requirements interact in other ways, too. For example, in early fault-tolerance experiments, the logical circuit depth budget may be increased either by improving decoding accuracy or by reducing decoding latency.

A different kind of trade-off exists in the fundamental choice between decoders implemented in hardware and decoders implemented in software. The former promise greater performance while the latter offer greater flexibility. Our experiments demonstrate that a parallel and optimized C++ software decoder can achieve real-time performance when provided exclusive access to a subset of CPUs. The flexibility of software-based decoding facilitates ongoing research in decoding algorithms and fault-tolerant constructions. In particular, software syndrome decoding can handle broken or disabled components #cite(<Nagayama_2017>), allows easing of hardware requirements #cite(<McEwen2023relaxinghardware>), and promises support for novel and customized constructions for early fault-tolerant quantum algorithms.

// [figvision] src/figures_sm/RT_decoding_latency.png
// The single panel is titled "Surface code, distance 5". The y-axis plots Latency (μs) on a logarithmic scale
// from below 10^1 to above 10^3, with major ticks at 10^1, 10^2, and 10^3. The x-axis plots Number of Cycles
// logarithmically from 10^3 to 10^6, marked by vertical gridlines at each decade. Blue dots mark per-shot
// latency for ten shots at each cycle count, with light blue horizontal bars denoting medians and light blue
// shaded violins showing shot latency distributions. Orange histograms and thin vertical orange lines represent
// sub-shot latency distributions. Four mean lines are drawn: green (Sub-shot Latency Mean) stays nearly flat
// near 80 μs; purple (Latency Mean) hovers around 50–60 μs; red (Sub-shot Latency σ) sits near 20 μs and rises
// toward 40 μs at 10^6 cycles; light blue (Latency σ) drops from ~20 μs to ~9 μs then climbs to ~25 μs.
#figure(image("src/figures_sm/RT_decoding_latency.png"),
  caption: [
    #strong[Software decoding latency.] Here we show the latency associated with the software components, $T_(upright("software"))$, as a function of the number of cycles for ten independent experimental shot runs. Blue points indicate per shot latency (10 shots per number of cycles), with horizontal bars denoting the median, and the blue-shaded violin plot illustrating the shot latency distribution. The yellow histograms represent the distribution of sub-shot latencies, obtained by dividing each shot into sub-shots of ten-cycle blocks. Stable latency as a function of the number of cycles indicates the real-time decoding system achieves the required throughput.
  ]
)
<fig:latency_vs_circuit_depth>

=== Correlated Parallel Blossom
<correlated-parallel-blossom>
In this section we describe our real-time decoder, a multi-threaded implementation of a correlation-augmented minimum-weight perfect matching decoder capable of processing a stream of syndrome data, using a matching graph buffer that does not scale with the number of cycles. Our decoder uses Sparse Blossom as the matching engine (main subroutine) and upgrades it to an accurate real-time decoder by making the following major changes:

==== Preweight correlations.
<sec:preweight_corr>
Sparse Blossom, as described in Ref. #cite(<higgott2023sparse>), assumes that the noise model is graphlike (each error causes at most two detection events) and ignores "hyperedge" error mechanisms that can cause more than two detection events, such as $Y$ errors in the CSS surface code. We improve the accuracy of Sparse Blossom by reweighting the graph using a "preweight correlations" subroutine. This is similar to the reweight strategy introduced in Ref.~#cite(<Paler2023pipelinedcorrelated>), which itself is a fast approximation of the two-pass correlation strategy introduced in Ref.~#cite(<fowler2013optimalcomplexitycorrectioncorrelated>). Concretely, we iterate over the detection events and identify any edge satisfying either of the following conditions:

+ The edge has a detection event at both of its endpoints.

+ The edge is a boundary edge that has a detection event $v$ at its endpoint, and furthermore there are no detection events directly adjacent to $v$.

If an edge $e$ satisfies either of these conditions then we add it to the set $C$ of initially chosen edges. For each edge in $C$ we then condition on an assumption that the associated error mechanism occurred to obtain a posterior probability that other related errors occurred, updating edge weights accordingly. For example, if an edge $e$ in $C$ corresponds to an $X$ error at a particular location of a CSS surface code circuit, then from our knowledge of the noise model we know that a $Y$ error could have occurred at the same location and hence we lower the edge weight corresponding to a $Z$ error at the same circuit location.

==== Block-based parallelization.
<block-based-parallelization.>
We parallelize Sparse Blossom following a similar strategy to how Fusion Blossom parallelizes Parity Blossom~#cite(<wu2023fusionblossom>). Our decoder partitions the matching graph into #emph[blocks], where each block consists of $M$ syndrome measurement cycles. Each block is assigned to a thread, which first reweights the graph using the preweight correlations strategy described in @sec:preweight_corr. The same thread then runs Sparse Blossom on the block, with the Sparse Blossom timeline processed until every region is matched either to another region, the boundary of the graph, or the boundary of the block. Similar to Fusion Blossom~#cite(<wu2023fusionblossom>), neighbouring blocks are then #emph[fused] in stages, again using Sparse Blossom as the matching engine.

The fusion graph we use is different from the ones proposed in Fusion Blossom. Specifically, we apply two layers of fuses (our fusion graph has height three): we first fuse each even block with the odd block immediately following it, and then we fuse each odd block with the even block immediately following it. Here, a block is even or odd if its sequential index is even or odd, respectively. Rather than adding a root node to the fusion graph, we instead declare a heralded error if any regions remain matched to a block boundary once fusing has completed. We ensure that the rate of heralded failures is negligible relative to other contributions to the logical error rate by choosing a sufficiently large number of cycles per block $M$. We find it is sufficient to set $M = 10$ for the distance-3 and distance-5 surface codes and $M = 90$ for the distance-29 repetition code.

Finally, we extract the predicted logical observable from each block as a bitmask and undo the edge reweights. The overall prediction of the decoder is then the bitwise XOR of the predicted logical observable bitmask for each block.

==== Constant-sized graph buffer.
<constant-sized-graph-buffer.>
Rather than storing the full matching graph in memory, we instead use a constant-sized graph buffer. This graph buffer emulates the full matching graph while only storing 128 contiguous blocks at any instant. A separate #emph[grapher] thread maintains the graph buffer, ensuring that the buffer always contains the region of the graph being acted on by the decoder. The grapher exploits the repeating pattern of the memory experiment matching graph and does not rewrite any of the graph buffer in the bulk of the experiment, with the only significant work being done at the beginning and end of the experiment where the local structure of the graph changes.

= Understanding Fidelity
<understanding-fidelity>
== Error Budget Simulations
<error-budget-simulations>
=== Surface Code Simulation Details
<sec:sim_details>
We briefly summarize the methods and high-level workflow used to simulate the error correction experiments. Except when otherwise noted, the simulation details are equivalent to those discussed in Ref.~#cite(<google2023suppressing>). The gate sequence matching each memory experiment is first represented in a `cirq.Circuit`~#cite(<cirq_developers_2024_11398048>). The circuit is then dressed with additional channels corresponding to different error mechanisms. Each error channel is represented numerically using Kraus operators, which are compiled specifically for each noise model and qubit based on experimental characterizations. The following mechanisms are included:

- Decoherence, quantified by decay ($T_1$), pure dephasing ($T_phi.alt$), and passive heating of qubits to state $\| 2 chevron.r$.

- Readout and reset error.

- Dephasing-induced leakage of the higher frequency qubit during the CZ gate. (This is represented by a transition from state $\| 11 chevron.r$ to $\| 02 chevron.r$.)

- Stray coupling crosstalk between nearest-neighbor or diagonal-neighbor qubits during parallel CZ operation.

- Excess error (not accounted for by previous sources) on single-qubit and CZ gates, as well as during idling of data qubits during qubit measurement and reset.

- Transport of leakage between CZ-gate qubits through higher-excitation transitions (e.g., $\| 12 chevron.r arrow.r \| 30 chevron.r$).

Beyond these errors already included in Ref. #cite(<google2023suppressing>), we also allow for imperfect operation of the data-qubit leakage removal operation (DQLR)~#cite(<Miao2023>). For simplicity, this is modeled by a phenomenological model matching experimentally observed reset fidelity for state $\| 2 chevron.r$. The Kraus operators of this channel are given by

$ K_(i j) &= sqrt(P_(j arrow.r i)) |i chevron.r chevron.l j| \
  K_0 &= sqrt(I - sum_(i , j) K_(i j)^dagger K_(i j)) $ <Suppl:Kraus-DQLR> where $P_(j arrow.r i)$ is the probability that standard basis state $\| j chevron.r$ of the data qubit is reset to state $\| i chevron.r$. Notably, this channel acts trivially on the computational subspace.

#figure(image("src/figures_sm/suppl_scalability_plot.pdf"),
  caption: [
    #strong[Simulated logical error rates for larger code distances.] For a given code distance, the green open circles indicate the LERs of ten different non-uniform error models obtained by re-sampling (bootstrapping) the measured component error probabilities of our distance-5 surface code on the 72-qubit processor. Note that the circles are overlapping. The green solid line denotes the geometric mean of the LERs indicated by the green circles. The dashed lines depict LERs for error models that, except for stray crosstalk errors, are uniform over each qubit. The dashed green and black lines respectively show the LERs with and without data qubit leakage removal (DQLR) gates at the end of each error correction cycle. Finally, the dashed blue line shows the logical error rates expected for a device with twice better component error probabilities and with DQLR.
  ]
)
<fig:suppl_scalability_plot>

After the circuit is dressed with all relevant error channels, we apply a Generalized Pauli Twirling Approximation to each noise channel. This converts each noise channel to a generalized Pauli channel that also includes leakage, thereby making it compatible with Clifford simulation methods. Finally, the noisy circuit is parsed and passed to the `Pauli+` simulator, which generates samples of simulated experimental data.

=== Surface Code Performance at Large Code Distances
<sec:performance_of_larger_surf_codes>
In this section, we simulate the performance of surface codes at code distances larger than those realized experimentally. In particular, we discuss (a) the effect of non-uniform component errors on the logical error rate (LER) and the error suppression factor $Lambda$; (b) the achievable logical error rates if we improve our components' fidelity by a factor of two; (c) the effect on the exponential suppression of the logical error rate with code distance $d$ if we forego DQLR; and (d) the crossover regime where we can observe finite-size error suppression above threshold. We point out that, for efficiency, all results of this section (except when noted otherwise) are obtained using a correlated minimum-weight perfect matching decoder that is less accurate than the one used in the main text. Moreover, we carry out the simulations using the component error parameters of those of the 72-qubit processor.

==== Effect of non-uniform component errors on surface code performance.
<effect-of-non-uniform-component-errors-on-surface-code-performance.>
The component error probabilities of our devices are intrinsically non-uniform. To investigate the effect of the non-uniformity of component errors on the performance of surface codes at large code distances, we generate synthetic non-uniform error models by resampling (bootstrapping) the measured component errors of the $d = 5$ surface code grid. For codes of each distance $d = 3 , 5 , 7 , 9 , 11$ and 13, we generate ten statistically independent synthetic error models and compute the corresponding LERs.

The results are depicted by the open green circles in @fig:suppl_scalability_plot. The solid green line joins the geometric means of the computed LERs. For comparison, we also perform surface code simulations where, for each error type, we homogenize the component errors by taking the arithmetic mean. In these simulations, however, the stray coupling crosstalk errors are still non-uniform, since they depend on the qubit frequencies. The LERs for these (almost) uniform error models are shown by the dashed green line in @fig:suppl_scalability_plot. We find that these LERs show good agreement with the geometric means of the LERs from the non-uniform error models. Both dashed and solid green lines indicate that logical errors are exponentially suppressed at large code distances with a suppression factor $Lambda approx 2$. From the solid green line, we have $Lambda_(3 / 5) = 2.16 , Lambda_(5 / 7) = 2.2 , Lambda_(7 / 9) = 2.16 , Lambda_(9 / 11) = 2.12$ and $Lambda_(11 / 13) = 2.01$, where $Lambda_(d / d + 2) equiv "LER" ( d ) / "LER" ( d + 2 )$. We perform all these calculations with DQLR gates that remove leakage states $\| 2 chevron.r$ and $\| 3 chevron.r$ with 100% and 50% fidelities, respectively. In @Suppl:Kraus-DQLR, this corresponds to nonzero transition probabilities $P_(2 arrow.r 1) = 1 , P_(3 arrow.r 2) = 0.5 , P_(3 arrow.r 1) = 0.5$. These results show that the error non-uniformity of our surface code components induces a relatively small spread in the logical error rates at large code distances. Additionally, the observed logical error suppression factor $Lambda_(3 / 5) gt.eq 2$ holds at larger code distances, despite the non-uniformity of component errors.

==== Performance forecast for devices with twice better component errors.
<performance-forecast-for-devices-with-twice-better-component-errors.>
By fitting the data of the solid green line of @fig:suppl_scalability_plot with $"LER" ( d ) = C dot.op [ 1 / Lambda ]^(( d + 1 ) / 2)$, we obtain $Lambda approx 2.14$ and coefficient $C approx 3.0 times 10^(- 2)$. This implies that to achieve a logical error rate of, e.g., $"LER" = 10^(- 6)$ would require a device that could hold a surface code with a minimum distance $d = 27$ (1457 qubits). An alternative path to achieving a $"LER"$ of $10^(- 6)$ is to continue improving the surface code component fidelities. We perform a simulation to forecast the performance of surface codes with component errors that are twice better than what we have demonstrated in this work. The results are indicated by the blue dashed line in @fig:suppl_scalability_plot. The predicted logical error suppression factor is $Lambda approx 4.5$ and a $10^(- 6)$ logical error rate can be achieved with a $d = 13$ surface code (337 qubits). As shown in @sec:Lambda-budget, the most important component errors to improve are CZ errors and data qubit idle errors.

==== Importance of DQLR in surface codes.
<importance-of-dqlr-in-surface-codes.>
In this section, we demonstrate through numerical simulations the importance of the DQLR operation for logical device performance. In Ref.~#cite(<Miao2023>), it was shown that data qubit leakage removal is instrumental to achieving the exponential suppression of logical errors with code distance when physical errors are well below the error threshold. The reason for this is that leakage states (e.g. $\| 2 chevron.r$, $\| 3 chevron.r$, etc.) that survive over several error correction cycles create time correlations in error detection events that confuse the error decoder. DQLR limits the growth of leakage populations and the lifetime of leakage states (ideally to one cycle), recovering the exponential logical error suppression with code distance promised by quantum error correction.

The green and black dashed lines of @fig:suppl_scalability_plot show the logical error rate as a function of code distance with and without DQLR, respectively. We use component errors that are uniform, except for the errors due to stray coupling crosstalk. The error parameters used in these simulations correspond to experimental values of the 72-qubit processor. Without DQLR, we find that the logical error suppression factor $Lambda_(d / d + 2)$ saturates to a value around 1 at large code distances, while with DQLR, exponential suppression of logical errors holds to large code distances with a $Lambda_(d / d + 2)$ that does not exhibit a significant dependence on code distance, $d$.

==== The crossover regime.
<the-crossover-regime.>
It is worth noting that the assumption that $Lambda$ is distance-independent can break down at $Lambda_(3 / 5) approx 1$, as was reported in Ref.~#cite(<google2023suppressing>). This can occur even in a simple Pauli simulation, where one can achieve error suppression at finite sizes above threshold that will eventually turn around. To illustrate this crossover regime, we employ a simple Pauli simulation of the 72-qubit processor, see @fig:crossover. There, we observe that for $Lambda_(3 / 5) lt.eq 1.3$, the initial error suppression diminishes rapidly with distance. We note that the threshold is much better behaved when reporting the error rate per $d$ rounds~#cite(<stephens2014fault>), which is relevant to the logical operation of the surface code.

#figure(image("src/figures_sm/ler_vs_distance_comparing_lambda35.pdf"),
  caption: [
    #strong[The crossover regime.] A Pauli simulation based on the 72-qubit device detailed in @fig:edcfs using $3 d$ rounds and correlated matching. The factor $alpha$ scales the error rates of all the Pauli channels uniformly. We observe that for a $Lambda_(3 / 5) lt.eq 1.3$, error suppression eventually saturates with distance, before turning around. However, for $Lambda_(3 / 5) gt.eq 1.5$, we see the characteristic below-threshold error suppression continuing.
  ]
)
<fig:crossover>

=== Surface Code $1 / Lambda$ Error Budget
<sec:Lambda-budget>
We construct a $1 / Lambda$ error budget for our 72-qubit processor in a manner similar to Ref.~#cite(<google2023suppressing>). We write $( Lambda_(3 / 5) )^(- 1)$ as a sum of contributions from each error channel $i$ that is considered in the simulation:

$ ( Lambda_(3 / 5) )^(- 1) = sum_i w_i thin p_(upright(e x p t))^(( i )) . $<eq:1_Lambda_budget_formula>

#block[
#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (left,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header(table.cell(align: center)[Component], [$p_(upright(e x p t))^(( i ))$], [$w_i$], [$1 / Lambda$ contrib.],),
    table.hline(),
    [CZ gates (doesn't include CZ crosstalk & CZ leakage)], [$2.8 times 10^(- 3)$], [65], [0.182 (41%)],
    [CZ crosstalk], [$5.5 times 10^(- 4)$], [91], [0.05 (11%)],
    [CZ leakage], [$2.0 times 10^(- 4)$], [108], [0.022 (5%)],
    [Data qubit idle], [$0.9 times 10^(- 2)$], [10], [0.09 (20%)],
    [Readout], [$0.8 times 10^(- 2)$], [6], [0.048 (11%)],
    [Reset], [$1.5 times 10^(- 3)$], [6], [0.009 (2%)],
    [SQ gates], [$6.2 times 10^(- 4)$], [63], [0.039 (9%)],
    [Leakage (heating)], [$2.5 times 10^(- 4)$], [18], [0.005 (1%)],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [
    #strong[Error budget calculation for $( Lambda_(3 / 5) )^(- 1)$] using device parameters from the 72-qubit processor when decoding with correlated matching. We multiply the component errors $p_(upright(e x p t))^(( i ))$ by the sensitivities (weights) $w_i$ at the error operation point, resulting in the relative contributions to $( Lambda_(3 / 5) )^(- 1)$ shown in the right-most column.
  ]
  , kind: table
  ) <Suppl:1_Lambda_contributions_table>

]
The weights $w_i$ are the sensitivities of $( Lambda_(3 / 5) )^(- 1)$ to a uniform increase of the error probabilities of the $i$th error channel from the baseline error operation point. From @Suppl:1_Lambda_contributions_table, we find that errors related to CZ gates (the first three rows) contribute about 60% of the $1 / Lambda$ budget. The next important contributor to $1 / Lambda$ is data qubit idle errors (about 20%), followed by readout and reset errors (12%) and single-qubit gate errors (9%). We remark that the sensitivities ($w_i$) are obtained assuming perfect DQLR and using a correlated matching decoder for efficiency~#cite(<fowler2013optimalcomplexitycorrectioncorrelated>). The prediction from @eq:1_Lambda_budget_formula and @Suppl:1_Lambda_contributions_table yields $Lambda_(3 / 5) = 2.25$, while directly calculating the ratio of logical error rates from simulated distance-3 and distance-5 codes yields $Lambda_(3 / 5) = 2.17$.

== Comparison to Physical Qubit Lifetime
<comparison-to-physical-qubit-lifetime>
The average channel fidelity of a quantum channel $cal(E)$:~$rho arrow.r cal(E) ( rho )$ to a target identity channel is defined as $ overline(cal(F)) [ cal(E) ] = integral d psi chevron.l psi \| cal(E) ( \| psi chevron.r chevron.l psi \| ) \| psi chevron.r , $<average_gate_fidelity> where the integral is over the uniform measure on the state space, normalized so that $integral d psi = 1$. This fidelity characterizes the closeness of a quantum channel to the identity without giving preference to any particular axis on the Bloch sphere.

As shown in Ref.~#cite(<nielsen2002simple>), the uniform averaging in @average_gate_fidelity is equivalent to averaging over the six cardinal points on the qubit Bloch sphere, the eigenstates of the Pauli operators, $ overline(cal(F)) [ cal(E) ] = 1 / 12 sum_(P = X , Y , Z) upright(T r) [P cal(E) ( P )] + 1 / 2 , $<nice_formula> which becomes evident by using the linearity of the quantum channels, $cal(E) ( P ) = cal(E) ( \| + P chevron.r chevron.l + P \| ) - cal(E) ( \| - P chevron.r chevron.l - P \| )$. @nice_formula provides an experimental protocol for extracting fidelity of an #emph[arbitrary] channel to the identity.

The simplest way to implement an identity is via an idling operation. For the physical qubits subject to amplitude damping at rate $gamma_1$ and white-noise dephasing at rate $gamma_phi = gamma_2 - gamma_1 / 2$, idling for time $t$ results in $ overline(cal(F)) ( t ) = frac(e^(- gamma_1 t) + 2 e^(- gamma_2 t), 6) + 1 / 2 . $<fidelity_physical> On the other hand, for a qubit subject to Pauli channel with Pauli error rates $gamma_X$, $gamma_Y$ and $gamma_Z$, we have: $ overline(cal(F)) ( t ) = frac(e^(- 2 ( gamma_Y + gamma_Z ) t) + e^(- 2 ( gamma_X + gamma_Z ) t) + e^(- 2 ( gamma_X + gamma_Y ) t), 6) + 1 / 2 . $<fidelity_logical>

Hence, qubits subject to different error channels experience different decay of fidelity in time, which complicates their direct comparison. However, at short times this decay can be approximated as $ overline(cal(F)) ( delta t ) = 1 - 1 / 2 Gamma delta t , $ where $Gamma$ is an effective depolarization rate and $1 / Gamma$ is an effective lifetime of a uniformly sampled pure state. This quantity can be directly compared among qubits with different error channels. Note that this metric does not favor qubits with extremely biased noise #cite(<grimm2020stabilization>) #cite(<google2021exponential>) #cite(<reglade2024quantum>), for which $Gamma$ is dominated by the largest error rate. For physical qubits, from @fidelity_physical we obtain $ Gamma_(upright(p h y s i c a l)) = frac(gamma_1 + 2 gamma_2, 3) . $ For a qubit encoded in the surface code, we model a logical Pauli channel~#cite(<bravyi2018correcting>)~#cite(<sivak2023real>) with error probabilities $p_X$, $p_Y$ and $p_Z$ per cycle. When these error probabilities are small, the channel can be modeled as continuous in time, with rates $gamma_X approx p_X / t_c$, $gamma_Y approx p_Y / t_c$, and $gamma_Z approx p_Z / t_c$, where $t_c$ is the cycle duration. For such a continuous logical Pauli channel, from @fidelity_logical we obtain $ Gamma_(upright(l o g i c a l)) = 4 / 3 ( gamma_X + gamma_Y + gamma_Z ) $

Note that to first order $p_X + p_Y + p_Z = 2 epsilon_d - p_Y$, with $epsilon_d$ defined in the main text as the logical error probability per cycle averaged over the $X$ and $Z$ eigenstates. This equation allows us to establish a strict upper bound on $Gamma_(upright(l o g i c a l))$, since $p_X + p_Y + p_Z lt.eq 2 epsilon_d$, resulting in $ Gamma_(upright(l o g i c a l)) lt.eq frac(8 epsilon_d, 3 t_(upright(c))) . $ Simulations suggest  that in the surface code $p_Y tilde.op p_X p_Z$ is suppressed compared to $p_X$ and $p_Z$, because $Y$ errors predominantly occur as independent $X$ and $Z$ errors. Hence, we expect that this bound is also tight. One illustrative consequence of this is that the lifetime of $Y$ eigenstates in the surface code would be approximately twice shorter than the $X$ and $Z$ eigenstates, although due to a more complicated preparation, we do not measure this lifetime in our experiment.

Following Refs., we define the gain $G$ as an improvement of the effective lifetime of an error-corrected logical qubit over the best physical qubit in the same system (with the break-even point corresponding to $G = 1$). This metric represents the usefulness of QEC in protecting quantum information in time; however, it does not take into account the cost of state preparation, measurement, or gates.

In our system, comparing against the qubit with the longest measured physical lifetime, we have
$ 1 / Gamma_(upright("physical")) &= 119 plus.minus 13 "μs", \
  1 / Gamma_(upright("logical")) &= 291 plus.minus 6 "μs", $
which leads to $G = 2.4 plus.minus 0.3$. This demonstrates a beyond break-even quantum memory realized with a multi-qubit code, extending previous results with bosonic codes #cite(<sivak2023real>).

= Error Correction Experimental Details
<error-correction-experimental-details>
== Low Probability Events in the Repetition Code
<low-probability-events-in-the-repetition-code>
#figure(image("src/figures_sm/rep_code_supplement.pdf"),
  caption: [
    #strong[Repetition code.] #strong[a,] Detection probability as a function of time for the measure qubit corresponding to each detector (indexed along repetition code direction), during a burst event. Detections are smoothed with a $sigma = 2$ Gaussian filter. Vertical lines represent boundaries between shots. #strong[b,] Same as #strong[a], but for the case of a single noisy detector. #strong[c] and #strong[d,] Detection probability averaged over the first ~200 ns of the burst event and single noisy detector event, respectively, plotted on the qubit grid. Grey lines represent the repetition code gate direction.
  ]
)
<fig:repetition_supplement>

In the distance-29 repetition code experiment, we achieve $Lambda > 8$ and observe an apparent logical-error-per-cycle floor of $10^(- 10)$ at large distances. This result constitutes a four orders-of-magnitude improvement compared to the lowest logical error per cycle achieved in previous experiments #cite(<google2021exponential>). However, even this lower error rate floor will be limiting for larger fault-tolerant circuits. We find that the logical errors at high distances are caused by rare events with distinct detection event probability signatures. In this section, we report relevant metrics for these rare events.

One type of event presents as a correlated burst of detection event probability, with a sharp rise followed by an exponential decay to baseline levels over the course of several shots. An example is given in Fig.~3d, and another is presented in @fig:repetition_supplement. These events account for all the distance-27 logical errors we observe, and half of the distance-21 to distance-25 errors. The measure qubits corresponding to the firing detectors are grouped spatially, not necessarily in sequence with the snaking repetition code order. The bursts occur roughly once per hour, or once every $3 times 10^6$ shots, in both bit- and phase-flip codes. The decay timescale from fitting the detection fractions to a decaying exponential is around 400-700 μs. This is in stark contrast to the detection fraction bursts caused by quasiparticles observed in previous work , which happened once every $10$~seconds with a recovery time of $25 - 30$~ms.

The other type of limiting event presents as a single noisy detector, whose likelihood of firing rapidly increases and stays high for 1-2~ms. This event causes a high-distance (defined here as $d > 19$) error also about once per hour of data acquisition. The detector which is noisy varies from event to event. An example is presented in @fig:repetition_supplement.

== Grid and Circuit Details
<grid-and-circuit-details>
#figure(image("src/figures_sm/sup_sub_grids.pdf"),
  caption: [
    #strong[Surface code grid layout details.] #strong[a,] Layout of distance-3 grids used on the 105-qubit processor. #strong[b,] Layout of distance-5 grids used on the 105-qubit processor. #strong[c,] Layout of distance-3 grids used on the 72-qubit processor.
  ]
)
<fig:sub_grids_supplement>

#figure(image("src/figures_sm/sup_72q_error_vs_cycles.pdf"),
  caption: [
    #strong[Logical performance on the 72-qubit processor.] Here we show a similar result to Fig.~1c of the main text, except on the 72-qubit processor. Decoding is performed with the neural network. The neural network decoder achieves $epsilon_5 = 0.252 % plus.minus 0.002 %$ and $Lambda = 2.31 plus.minus 0.02$. It also achieves a break-even memory at distance-5, with a median and best physical qubit lifetime of approximately 73 μs and 113 μs, respectively, compared to a logical qubit lifetime of approximately 160 μs.
  ]
)
<fig:72q_error_vs_cycles>

In this section, we present experimental details associated with the qubit grids and quantum circuits used for the surface code experiments. @fig:sub_grids_supplement shows the placement of distance-3 and distance-5 grids on both processors. To compare smaller-distance codes to larger ones, we average over several smaller codes chosen to cover the larger code with minimal overlap, extending the methodology of Ref.~#cite(<google2023suppressing>).

@fig:72q_error_vs_cycles shows a representative dataset of logical error versus cycles for the 72-qubit processor taken prior to the time series shown in Fig. ~2e. This dataset gives $Lambda = 2.31 plus.minus 0.02$. @fig:det_fracs_supplement shows the detection event probabilities from various experiments, including distance-3 and distance-5 codes corresponding to @fig:72q_error_vs_cycles, distance-29 repetition codes on the 72-qubit processor, and distance-3, distance-5, and distance-7 codes on the 105-qubit processor. @fig:pauli_simulated_bulk_detection_probabilities shows the detection probabilities predicted from a Pauli simulation of the 105-qubit device. We see good agreement, with the simulation predicting detection probabilities for $d = ( 3 , 5 , 7 )$ of $p_(upright("det")) = ( 8.0 % , 8.5 % , 8.6 % )$ compared to experiment which has $p_(upright("det")) = ( 7.7 % , 8.5 % , 8.7 % )$. The natural rise in detection probability with system size can be ascribed to reducing finite size effects -- for example, each corner, edge, and bulk data qubit is involved in 2, 3, and 4 CZ gates, respectively. In @fig:dqlr_AB_test we show a comparison of detection probabilities from the data qubit leakage removal (DQLR) test from Fig.~2, noting the rise in detections for the experiments without DQLR, which we attribute to leakage accumulation.

@fig:qec_circuit_supplement outlines the steps of a surface code error correction circuit, broken down into layers of single- and two-qubit gates as well as dynamical decoupling and measurement operations.

For experiments sweeping over several codes and numbers of cycles, such as Fig.~1c, we interleave experiments of different codes, as in Ref.~#cite(<google2023suppressing>). We acquire one (number of cycles, basis, code) dataset at a time, each with 50,000 repetitions (10 initialization bitstrings times 5,000 repetitions). The initialization bitstrings are 5 random bitstrings and their complements; complementary bitstrings have opposite logical eigenvalues for odd-distance surface codes. We shuffle the order in which we measure each number of cycles. The order of enumeration is the following.

`for n in num_cycles:`

`    for basis in (Z, X):`

`        for code in codes:`

`            take_data(n, basis, code)`

#figure(image("src/figures_sm/sup_detfracs.pdf"),
  caption: [
    #strong[Detection event probabilities.] #strong[a,] Average detection probability as a function of error correction cycles for all detectors in the different grids in the 72-qubit processor. (top) Distance-3 grids, with weight-4 stabilizers in red and weight-2 stabilizers in orange. The average $X$ and $Z$ basis detectors are plotted in bold. (middle) Distance-5 grid, with weight-4 in dark blue and weight-2 in light blue. (bottom) distance-29 repetition code. #strong[b,] Detection probabilities for different grids in the 105-qubit processor; (top) distance-3 grids, (middle) distance-5 grids, (bottom) distance-7 grid. #strong[c,] Detection probability as a function of error correction cycles, run continuously for one million cycles, for (top) the distance-5 grid and (bottom) the distance-29 repetition code in the 72-qubit processor. Here we plot one shot, and apply a rolling average of 10,000 cycles.
  ]
)
<fig:det_fracs_supplement>

#figure(image("src/figures_sm/sup_dqlr_comparison.pdf"),
  caption: [
    #strong[Detection event probabilities without and with data qubit leakage removal.] #strong[a,] Average detection probability as a function of error correction cycles without data qubit leakage removal (DQLR) for all detectors in the distance-3 grids (top) and distance-5 grid (bottom) in the 72-qubit processor. We attribute the rise in detections to leakage accumulation. #strong[b,] Average detections as a function of error correction cycles with DQLR; the data qubit leakage removal step successfully removes the rise in detections.
  ]
)
<fig:dqlr_AB_test>

#figure(image("src/figures_sm/sup_circuit.pdf"),
  caption: [
    #strong[Distance-5 surface code circuit.] Spatial layout of data qubits (gold dots) and measure qubits (blue dots) are shown here on a distance-5 grid. 1. We reset all qubits to $\| 0 chevron.r$ and then prepare an initial bitstring state on the data qubits using $X$ gates. 2. We apply $H$ (Hadamard) gates to some of the data qubits to convert the initial bitstring (eigenstate of all $Z$ operators) into an eigenstate of half the #emph[ZXXZ] stabilizers, the half matching to logical operator of interest ($X_L$ or $Z_L$) for the specific experiment. Note steps (1) and (2) could be combined into a single moment of Clifford gates, but for simplicity we execute them in two moments as shown. 3. QEC cycle showing the explicit patterns for Hadamard gates and CZ gates as well as dynamical decoupling (DD) and measurement and reset operations (MR). Note that although all stabilizers measure #emph[ZXXZ], the “$X$” stabilizers and “$Z$” stabilizers apply their CZs in a different order (specifically in 3d and f). This pattern is carefully designed to manage “hook” errors. We modify this gate sequence with additional “echo” or “dynamical decoupling” gates, adding $X$ gates to all qubits in 3e (inserted between the middle two CZ moments). 4. For the final measurement, we replace 3i-j with a different Hadamard pattern (transforming the data qubit state to the appropriate basis for logical measurement) and measure all qubits simultaneously (M). This final measurement is used for detectors for the penultimate cycle (measure qubit results) and the final cycle (data qubit results, converted to parities in the relevant basis).
  ]
)
<fig:qec_circuit_supplement>

~

= Uncertainty Analysis
<uncertainty-analysis>
== Logical Performance
<logical-performance>
From a statistical point of view, the error suppression factor $Lambda$ is a random variable, defined with respect to a given collection of codes, whose randomness comes from sampling noise and performance drift for each of the given codes. Evaluating the uncertainty in our estimate of $Lambda$ involves evaluating the uncertainty in our estimates of the mean logical error per cycle for the collection of codes with a particular distance, and then propagating that through to uncertainty in that scaling with respect to depth, which we detail below.

In Fig.~1c of the main text, we consider logical error probability $p_L$ for a variety of codes for different numbers of error-correction cycles $t$. Each point has statistical uncertainty $sqrt(p_L ( 1 - p_L ) / N)$ with $N = 10^5$ repetitions. For example, $p_L = 0.1$ corresponds to statistical uncertainty $10^(- 3)$.

#block[
#figure(
  align(center)[#table(
    stroke: none,
    columns: 5,
    align: (center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([], table.cell(align: center, colspan: 2)[$X$ basis], table.cell(align: center, colspan: 2)[$Z$ basis],),
    table.hline(),
    [Grid], [Error rate], [Std. dev.], [Error rate], [Std. dev.],
    [distance-3 (0, 0)], [0.00561], [0.00013], [0.00516], [0.00008],
    [distance-3 (0, 4)], [0.00562], [0.00015], [0.00526], [0.00014],
    [distance-3 (0, 8)], [0.00519], [0.00012], [0.00475], [0.00021],
    [distance-3 (4, 0)], [0.00672], [0.00021], [0.00596], [0.00023],
    [distance-3 (4, 4)], [0.01044], [0.00045], [0.00800], [0.00030],
    [distance-3 (4, 8)], [0.00641], [0.00028], [0.00516], [0.00039],
    [distance-3 (8, 0)], [0.00678], [0.00030], [0.00724], [0.00024],
    [distance-3 (8, 4)], [0.00982], [0.00021], [0.00854], [0.00012],
    [distance-3 (8, 8)], [0.00507], [0.00015], [0.00533], [0.00014],
    [distance-5 (0, 0)], [0.00294], [0.00008], [0.00229], [0.00008],
    [distance-5 (0, 4)], [0.00311], [0.00007], [0.00238], [0.00009],
    [distance-5 (4, 0)], [0.00362], [0.00008], [0.00326], [0.00014],
    [distance-5 (4, 4)], [0.00352], [0.00008], [0.00309], [0.00009],
    [distance-7 (0, 0)], [0.00155], [0.00004], [0.00130], [0.00004],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [#strong[Logical errors per cycle for Fig. 1c.] Both logical error per cycle and standard deviation is shown for each grid and basis using the neural network decoder. Grid labels correspond to the open source #cite(<qec_datasets_zenodo_2024>) labeling, e.g. distance-$3$ $( 0 , 4 ) arrow.l.r$ d3\_0+4j. ]
  , kind: table
  ) <tab:fig_errors>

]
To determine the logical error per cycle $epsilon_d$, we fit exponentials to $p_L$ versus number of cycles $t$ (technically, by fitting a line to $ln (1 - 2 p_L)$ versus $t$) for each code. We typically see residuals greater than those expected by statistical uncertainty in $p_L$, which we attribute to system performance drift over the course of the experimental sweep. Along with uncertainty in the fitted log slope obtained from linear regression, we use the excess residuals to estimate the uncertainty in $epsilon_d$ including this drift. See Ref. #cite(<google2023suppressing>) for details. We compute $epsilon_d$ and an uncertainty for each code and logical basis and then average over basis and code for data reported in the manuscript. Since the suppression factor $Lambda$ is defined with respect to the mean logical error per cycle for each distance, we compute the uncertainty in the mean from each individual uncertainty $sigma_i$, specifically $sqrt(Sigma_i sigma_i^2) / n$. Note this amounts to considering the particular ensemble of codes as fixed, with all the randomness coming from noise in sampling from a given code rather than sampling different codes.

Note that $p_L$, and thus $epsilon_d$, depend on the decoding scheme used. In Fig.~1d, we plot $epsilon_d$ values for the neural network decoder. The specific values for the neural network decoder and the ensembled synthetic matcher Libra are reported in the left-hand column of @Suppl:table-logical-error-rates. Furthermore, the specific $epsilon_d$ for each grid and basis of the neural network decoder are reported in @tab:fig_errors.

Similarly, the values corresponding to the accuracy tests on our real-time data in Fig.~4c are reported in the right-hand column of @Suppl:table-logical-error-rates. Those experiments included sweeps from 10 to 250 cycles (as in Fig.~1c) but with fewer repetitions ($10^4$ for each code and each number of cycles, split over logical $X$ and $Z$ bases). The smaller number of repetitions increases statistical uncertainty. We fit $epsilon_d$ for cycles $t > 90$, reserving the shorter experiments for decoder training. The underlying logical error probability data is plotted in @fig:real-time-accuracy.

#figure(image("src/figures_sm/pauli_simulated_bulk_detection_probability.pdf"),
  caption: [
    #strong[Pauli simulated detection event probabilities.] Average detection probability for weight-4 stabilizers predicted from a Pauli simulation of the 105-qubit processor based on @fig:edcfs. Each point is $10^4$ shots of a 100 cycle experiment. Pauli error rates are obtained from the 105-qubit processor. All Pauli errors are scaled uniformly -- 1.0 corresponds to the device Pauli rates. There, for $d = ( 3 , 5 , 7 )$ we obtain predicted detection probabilities $p_(upright("det")) = ( 8.0 % , 8.5 % , 8.6 % )$. We attribute the upwards trend to diminishing finite-size effects. We see reasonable agreement with the experimental detection probabilities $p_(upright("det")) = ( 7.7 % , 8.5 % , 8.7 % )$.
  ]
)
<fig:pauli_simulated_bulk_detection_probabilities>

#figure(image("src/figures_sm/sup_error_vs_cycles_on_realtime_data.pdf"),
  caption: [
    #strong[Decoder accuracy on the real-time dataset.] Underlying logical error probability data for Fig. ~4c. Triangles: distance-3 (averaged over four quadrants and $X$ and $Z$ basis). Pentagons: distance-5 (averaged over $X$ and $Z$ basis). We compare the accuracy of three different decoding strategies. Fits begin from 90 cycles (rather than the usual 10) because these experiments only featured 5,000 shots per individual experiment, rather than the usual 50,000. Consequently, more of the early-cycle samples were used to train the decoder priors.
  ]
)
<fig:real-time-accuracy>

We compute $Lambda$ using linear regression of $y = ln epsilon_d$ versus $x = ( d + 1 ) / 2$, including the uncertainty of the $epsilon_d$ values. The slope $m = - ln Lambda$, from which we compute $Lambda = e^(- m)$. Regression gives us uncertainty $delta m$, and the uncertainty $delta Lambda = e^(- m) delta m$.

We use the same regression analysis for the repetition code $Lambda$. In this case, we consider each data qubit idle basis ($X$ and $Z$) separately, as those two cases are sensitive to different physical error mechanisms. Fitting for $d$ from 5 to 11 (see main text), we obtain $Lambda_x = 8.27 plus.minus 0.02$ and $Lambda_z = 8.55 plus.minus 0.02$. To report an overall value, we use the mean $Lambda = ( Lambda_x + Lambda_z ) / 2$ and estimate the uncertainty $\| Lambda_x - Lambda_z \| / 2$.

For the distance-5 experiments on the 72-qubit processor, we instead consider $Lambda_(3 / 5) = epsilon_3 / epsilon_5$, which is equivalent to the $Lambda$ fit discussed above for two points.

We compute uncertainties in physical qubit lifetimes by propagating uncertainties in $T_1$ and $T_(2 upright("CPMG"))$, obtained with `scipy.curve_fit`.

== Logical Error per Cycle From One Point
<logical-error-per-cycle-from-one-point>
#figure(image("src/figures_sm/one_point_ler.pdf"),
  caption: [
    #strong[Error rates from one-point fits.] Here we plot the data from the Fig.~1 of the main text decoded with the neural network. For each cycle count $r$, we compute the one-point estimate of the logical error per cycle at that cycle count as $epsilon.alt_d = 0.5 (1 - ( 1 - 2 p_L )^(1 / r))$, where $p_L$ is the logical error fraction at $r$ rounds, and average over basis and grid. We observe that the estimates remain relatively constant for different numbers of cycles, indicating that performance is not degrading for longer cycle counts.
  ]
)
<fig:one_point>

In Fig.~2b and 3 of the main text, we estimate the logical error per cycle from experiments with a single number of cycles. The error-injection experiments in Fig.~2b and 3b are 10 cycles long; we choose shorter experiments so we can resolve high logical error $epsilon_d tilde.op 0.1$. The repetition code experiments in Fig.~2a are 1000 cycles so we can resolve $epsilon_3 tilde.op 10^(- 3)$ while maximizing experiment length. To estimate the error per cycle $epsilon_d$ from a single point $( t , p_L )$, we consider a binomial problem with logical error probability $epsilon_d$ at each step. The cumulative error probability $p_L$ after $t$ cycles is the probability of an odd number of logical errors, giving this expression for $p_L$: $ p_L & = 1 / 2 (1 - ( 1 - 2 epsilon_d )^t) . $ Solving for $epsilon_d$, $ epsilon_d & = 1 / 2 (1 - ( 1 - 2 p_L )^(1 / t)) . $ We then propagate statistical uncertainties accordingly. The uncertainties become more noticeable for the low-error experiments (where relatively few errors are observed), such as the higher-distance points in Fig.~3a, where we have a statistical floor based on the total number of cycles in the dataset, $2 times 10^10$. We also plot the logical error per cycle for Fig.~1c estimated from one cycle count for different cycles, and then averaged over grid and basis, in @fig:one_point.

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "ieee", title: [References])
