#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.91cm, bottom: 2.31cm), columns: 2)
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
  block(width: 100%, above: 1.2em, below: 0.7em, [#text(size: 9pt, weight: "regular")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 1.19em, first-line-indent: (amount: 1.2em, all: true))
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
  #text(14.3pt, weight: "bold", [Quantum Error Mitigation])   #v(1.2em)
  #text(10.5pt)[Zhenyu Cai, Ryan Babbush, Simon C. Benjamin, Suguru Endo, William J. Huggins, Ying Li, Jarrod R. McClean, Thomas E. O’Brien]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Department of Materials, University of Oxford, Oxford, OX1 3PH, United Kingdom] \
  #text(9pt)[#super[2] Quantum Motion, 9 Sterling Way, London N7 9HJ, United Kingdom] \
  #text(9pt)[#super[3] Google Quantum AI, Venice, California 90291, USA] \
  #text(9pt)[#super[4] NTT Computer and Data Science Laboratories, NTT Corporation, Musashino 180-8585, Japan] \
  #text(9pt)[#super[5] Graduate School of China Academy of Engineering Physics, Beijing 100193, China] \
]
#v(1.2em)



     Submitted to  Reviews of Modern Physics.  Please address all correspondence to Zhenyu Cai.














// dated
#v(0.4em)
#align(center)[#text(9pt)[(Dated: January 1, 2024)]]

For quantum computers to successfully solve real-world problems, it is necessary to tackle the challenge of #emph[noise]: the errors which occur in elementary physical components due to unwanted or imperfect interactions. The theory of quantum fault tolerance can provide an answer in the long term, but in the coming era of 'NISQ' machines we must seek to mitigate errors rather than completely remove them. This review surveys the diverse methods that have been proposed for quantum error mitigation, assesses their in-principle efficacy, and then describes the hardware demonstrations achieved to date. We identify the commonalities and limitations among the methods, noting how mitigation methods can be chosen according to the primary type of noise present, including algorithmic errors. Open problems in the field are identified and we discuss the prospects for realising mitigation-based devices that can deliver quantum advantage with an impact on science and business.
]





= INTRODUCTION
<sec:intro>
The central promise of quantum computing is to enable algorithms that have been shown to provide both polynomial and super-polynomial speed-ups over the best-known classical algorithms for a special set of problems. These problems range from simulating quantum mechanics~@feynmanSimulatingPhysicsComputers1982 to purely algebraic problems such as factoring integers~@shorPolynomialTimeAlgorithmsPrime1999. The strongest challenge to the viability of practical quantum computing has always been its sensitivity to errors and noise. It was realised early on that the coupling of quantum systems to their environment sets an ultimate time limit and size limit for any quantum computation~@unruhMaintainingCoherenceQuantum1995. This constraint poses a formidable challenge to the ambitions of realising a quantum computer, since it set bounds on the scalability of any algorithm. With the advent of quantum error correction (QEC)~@shorSchemeReducingDecoherence1995 @steaneErrorCorrectingCodes1996 @calderbankGoodQuantumErrorcorrecting1996, this challenge has been solved at least in theory. The celebrated threshold theorem~@aharonovFaulttolerantQuantumComputation1997 @kitaevQuantumComputationsAlgorithms1997 showed that if errors in the quantum hardware could be reduced below a finite rate, known as the threshold, a fault-tolerant quantum computation could be carried out for arbitrary length even on noisy hardware. However, besides the technical challenge of building hardware that achieves the threshold, the implementation of a fault-tolerant universal gate set with current codes, such as the surface code~@fowlerSurfaceCodesPractical2012, generates a qubit overhead that seems daunting at the moment. For example, recent optimised approaches show that scientific applications that are classically intractable may require hundreds of thousands of qubits~@kivlichanImprovedFaultTolerantQuantum2020, while industrial applications will require millions of qubits~@leeEvenMoreEfficient2021. There is ongoing theoretical research to find alternative codes with a more favourable overhead, and recent progress gives reasons to be optimistic~@gottesmanFaultTolerantQuantumComputation2014 @breuckmannQuantumLowDensityParityCheck2021 @panteleevAsymptoticallyGoodQuantum2022 @dinurLocallyTestableCodes2022. Nevertheless the challenge of realising full-scale fault-tolerant quantum computing is a considerable one.


This of course motivates the question of whether other approaches, prior to the era of fully fault-tolerant systems, might achieve quantum advantage with significant practical impacts. One might hope so, given the continual and remarkable progress that has been made in quantum computational hardware. In recent years, it has become routine to see reports of experiments demonstrating high-quality control over multiple qubits \[see e.g. #cite(<xueQuantumLogicSpin2022>, form: "prose")@madjarovHighfidelityEntanglementDetection2020 @jurcevicDemonstrationQuantumVolume2021 @ebadiQuantumPhasesMatter2021 @asavanantGenerationTimedomainmultiplexedTwodimensional2019\], some even reaching beyond 50 qubits \[see e.g. #cite(<aruteQuantumSupremacyUsing2019>, form: "prose")@wuStrongQuantumComputational2021\]. Meanwhile other experiments have indeed demonstrated early-stage fault-tolerant potentials~\[see e.g. #cite(<ryan-andersonImplementingFaulttolerantEntangling2022>, form: "prose")@googlequantumaiSuppressingQuantumErrors2023 @krinnerRealizingRepeatedQuantum2022 @takedaQuantumErrorCorrection2022 @abobeihFaulttolerantOperationLogical2022 @postlerDemonstrationFaulttolerantUniversal2022 @eganFaulttolerantControlErrorcorrected2021\]. Of course, the works mentioned here are far from exhaustive as it is impossible to capture the all the breakthroughs on different fronts across the diverse range of platforms, we refer the reader to #cite(<acinQuantumTechnologiesRoadmap2018>, form: "prose")@altmanQuantumSimulatorsArchitectures2021 and the references therein for the key milestones in different platforms.


The primary goal of #emph[quantum error mitigation] (QEM) is to translate this continuous progress in quantum hardware into immediate improvements for quantum information processing. While accepting that the hardware imperfections will limit the complexity of quantum algorithms, nevertheless we can expect that every advance should enable this boundary to be pushed further. As this review will demonstrate, the mitigation approach indeed proves to be both practically effective and quite fascinating as an intellectual challenge.


It is challenging to find a universally acceptable definition of quantum error mitigation. For the purposes of this review, we will define the term '#emph[quantum error mitigation]' as algorithmic schemes that reduce the noise-induced bias in the expectation value by post-processing outputs from an ensemble of circuit runs, using circuits at the #emph[same noise level] as the original unmitigated circuit #emph[or above]. That is to say QEM will only reduce the effective damage due to noise for #emph[the whole ensemble of circuit runs] (with the help of post-processing), but when we zoom into each individual circuit run, the circuit noise level remains unchanged or even increases. This is in contrast to the other techniques like QEC which aim to reduce the effect of noise on the output in #emph[every single circuit run].


Since QEM performs post-processing using data directly from noisy hardware, it will become impractical if the amount of noise in the whole circuit is so large that it completely damages the output. In practice, this usually means that for a given hardware set-up, there is a maximum circuit size (circuit depth times qubit number) beyond which QEM will become impractical, usually due to an infeasible number of circuit repetitions. In contrast to QEC, there is no specific error threshold that one must surpass before QEM can be useful; different qubit operation error rates simply lead to different circuit sizes for which QEM will be practical. In other words, as quantum hardware continues to advance, we will be able to apply QEM to ever larger quantum circuits for more challenging applications, without requiring big jumps in the technologies.


There are certain desirable features for error mitigation; the methods reviewed here meet the following criteria to differing extents. First, the mitigation method should ideally only require a very modest qubit overhead to remain practical on current and near-term quantum hardware. Nevertheless, error mitigation techniques should provide an accuracy guarantee for the method. Such a guarantee should ideally provide a formal error bound on the mitigated expectation values that indicate how well the method works at varying levels of noise. The bounds would then indicate which concrete hardware improvements would lead to improved estimates. Needless to say, methods that are conceptually simple and easy to implement experimentally lead to practically feasible approaches. Lastly, a reliable error mitigation method should require few assumptions (or, no assumptions) about the final state that is prepared by the computation. Making strong assumptions about the final state, for example that the state is a product state, may restrict the method to scenarios where a computational advantage over classical approaches may not be given.


We will start by introducing the basic notion of QEM in @sec:qem_concepts, with the details of different QEM techniques presented in @sec:methods. The comparison and combinations of these individual techniques will then be discussed in @sec:compare_and_comb. In @sec:applications we will explore the application of QEM in different noise scenarios. Finally, we will discuss the open problems in the field in @sec:open_prob and offer a conclusion in @sec:concl


= CONCEPTS
<sec:qem_concepts>
== Narrative introduction to concepts and terminology
<narrative-introduction-to-concepts-and-terminology>
In this section we will introduce certain key concepts and terminology that are common to all the QEM methods. However, do note that the approach used in this section might not be the native way for introducing individual techniques in @sec:methods. In those cases, we will keep terminology that is unique to the given technique self-contained in the respective section.


Near-term quantum devices have imperfections that degrade the desired output information. A QEM protocol will aim to minimise this degradation. We will use the term #emph[primary circuit] to describe the process that, ideally, would produce the #emph[perfect output state] $rho_0$ whose properties we are interested in. In practice, due to the noise present in the primary circuit, the actual output state is some #emph[noisy state] $rho$ instead.


Typically the ideal output information we seek is the expectation value of some #emph[observable of interest] $O$ of the ideal output $rho_0$. Commonly we would obtain this information simply by averaging the measurement results of repeated execution, as opposed to, say, some phase estimation techniques that can obtain the result through single-shot measurements but require deeper circuits that are more relevant to the fault-tolerant computing era. Therefore, even if we had ideal hardware, we would still need to perform repeated executions to determine the average. We will use $N_(upright("cir"))$ to denote the #emph[number of circuit executions], or 'shots', that we employ -- this will include any executions of variant circuits called for in the QEM protocol. Even in the noiseless limit, the finite $N_(upright("cir"))$ will usually imply a finite inaccuracy in our estimated average, often called #emph[shot noise]. However, with perfect noiseless hardware, there would be zero #emph[bias]. In other words, there would be no systematic shift to the estimated mean versus the true value (the infinite sampling limit). Given that our hardware is not perfect, there will generally be finite bias. QEM protocols aim to reduce this bias, but this often means an increase in the variance (for a fixed number of circuit executions $N_(upright("cir"))$). One could increase $N_(upright("cir"))$ to compensate but this cost should be acknowledged; the cost is the #emph[sampling overhead] of that error-mitigation method versus the ideal noiseless case. In the following subsections we will make these terms and concepts more precise.


== Error-mitigated estimators
<sec:bias_variance>


Our goal is to estimate the expectation value $"Tr" \[ O rho_0 \]$ of some observable of interest $O$. Using the outputs of the primary circuit and its variants, we can construct an estimator $hat(O)$ for our target parameter $"Tr" \[ O rho_0 \]$. The quality of a given estimator can be assessed in different ways. One way is to use prediction intervals, which calculate the interval within which the outcome of the estimator will fall with a given probability, offering a rigorous bound on the worst-case deviation of the estimator. Here however, in order to see the different factors that contribute to the deviation of the estimator more clearly, we will instead focus on the expected (average-case) square deviation of our estimator $hat(O)$ from the true value $"Tr" \[ O rho_0 \]$, which is called the #emph[mean square error]:


$ upright("MSE") \[ hat(O) \] = upright(E) \[ ( hat(O) - "Tr" \[ O rho_0 \] )^2 \] . $<eqn:mse>


The ultimate goal of error mitigation is to reduce $upright("MSE") \[ hat(O) \]$ as much as possible, but this needs to be achieved using only finite resources. To quantify this, it is useful to decompose the mean square error of an estimator into two components, the bias and the variance of the estimator:


$ upright("MSE") \[ hat(O) \] = upright("Bias") \[ hat(O) \]^2 + upright("Var") \[ hat(O) \] $


with the bias and the variance defined as:


$ upright("Bias") \[ hat(O) \] & = upright(E) \[ hat(O) \] - "Tr" \[ O rho_0 \]\
upright("Var") \[ hat(O) \] & = upright(E) \[ hat(O)^2 \] - upright(E) \[ hat(O) \]^2 . $



In this review when we say “bias”, sometimes we are referring to the magnitude of the bias $| upright("Bias") \[ O \] |$, the exact meaning should be obvious from the context.


The simplest way to construct the estimator $hat(O)$ is by directly measuring $O$ on the #emph[noisy] output state of the primary circuit $rho$, and the measurement output is simply denoted using the random variable $hat(O)_rho$. After running the noisy primary circuit $N_(upright(c i r))$ times, we can take the average of these noisy outputs (obtaining the noisy sample mean) to estimate the ideal expectation value $"Tr" \[ O rho_0 \]$. This noisy sample mean estimator is denoted as $overline(O)_rho$ and its mean square error is given by


$ upright(M S E) \[ overline(O)_rho \] = ( underbrace("Tr" \[ O rho \] - "Tr" \[ O rho_0 \], upright(B i a s) \[ overline(O)_rho \] = upright(B i a s) \[ hat(O)_rho \]) )^2 + underbrace(frac("Tr" \[ O^2 rho \] - "Tr" \[ O rho \]^2, N_(upright(c i r))), upright(V a r) \[ overline(O)_rho \] = upright(V a r) \[ hat(O)_rho \] \/ N_(upright(c i r))) . $<eqn:mean_mse>


We can see that the error contribution due to the variance, which is often called #emph[shot noise], will reduce as we increase the number of circuit runs $N_(upright("cir"))$. In the limit of a large number of circuit executions, the mean square error $upright("MSE") \[ overline(O)_rho \]$ will be mainly limited by the bias of the estimator $lr(|upright("Bias") \[ overline(O)_rho \]|)$, which is a systematic error that cannot be reduced by increasing the number of circuit runs.


In order to reduce the bias, we can apply QEM using data obtained from the noisy primary circuit and its variants, as will be discussed in @sec:methods. We will construct an error-mitigated estimator $overline(O)_(upright("em"))$ using the #emph[same number of circuit runs] $N_(upright("cir"))$. We would want to construct the error-mitigated estimator $overline(O)_(upright("em"))$ in such a way that it can achieve a smaller bias than the naive noisy estimator $overline(O)_rho$,


$ abs(upright("Bias")\[overline(O)_"em"\]) <= abs(upright("Bias")\[overline(O)_rho\]) . $


This reduction in the bias is usually achieved by constructing a more complex estimator that extracts and amplifies the useful information buried within the noise. As a result, the error-mitigated estimator is also more sensitive to the variation in the sampled data, and thus its variance will usually increase,


$ upright("Var")\[overline(O)_"em"\] >= upright("Var")\[overline(O)_rho\] . $


Such a bias-variance trade-off is illustrated in @fig:bias_variance and can be found in almost all areas of parameter estimation. As we will see later, different ways of performing error mitigation often lead to different trade-offs between bias and variance, giving the user a choice between a quickly-converging QEM method with large residual error, and one that is more costly but more accurate.


We can define an 'one-shot' error-mitigated estimator $hat(O)_(upright("em"))$ that will satisfy $upright(E) \[ hat(O)_(upright("em")) \] = upright(E) \[ overline(O)_(upright("em")) \]$ and $upright("Var") \[ hat(O)_(upright("em")) \] = N_(upright("cir")) upright("Var") \[ overline(O)_(upright("em")) \]$. The number of circuit runs needed for given estimator $hat(X)$ to achieve the shot noise level $epsilon.alt$ is given by $N_(upright("shot"))^epsilon.alt ( hat(X) ) = upright("Var") \[ hat(X) \] / epsilon.alt^2$. To reach the same shot noise level as the original noisy estimator, the error-mitigated estimator will require more circuit runs. This factor of increase in the number of circuit runs is called the #emph[sampling overhead], which is given by:


$ C_(upright("em")) = frac(N_(upright("shot"))^epsilon.alt ( hat(O)_(upright("em")) ), N_(upright("shot"))^epsilon.alt ( hat(O)_rho )) = frac(upright("Var") \[ hat(O)_(upright("em")) \], upright("Var") \[ hat(O)_rho \]) . $
<eqn:samp_cost>


// [figvision] imgs/BiasVariancePlot.png
// This panel displays a line plot comparing two probability density distributions. The horizontal axis is
// labeled "Output value" and ranges from approximately -0.3 to 1.0 with major ticks at intervals of 0.2. The
// vertical axis represents "Probability density" ranging from 0.0 to 4.0 with major ticks at intervals of 0.5.
// An orange solid line depicts the unmitigated estimator, showing a sharp, narrow Gaussian peak centered near
// 0.1 with a maximum height of 4.0. A blue dashed line shows the mitigated estimator, which is a broader, lower
// Gaussian distribution centered near 0.4 with a peak height of 2.0. A red arrow points downward from the text
// "Ideal value: Tr(Oρ₀)" to the x-axis value of 0.5. Vertical dotted lines indicate the mean of each
// distribution, demonstrating that error mitigation shifts the estimate closer to the ideal value while
// increasing variance.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering) #it.body]
}

#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [TABLE #context it.counter.display(it.numbering) #it.body]
}

#figure(image("imgs/BiasVariancePlot.png", width: 48.0%),
  caption: [
    The probability density distributions of the unmitigated estimator and the error-mitigated estimator. We see a decrease of bias and an increase of variance after performing error mitigation.
  ]
)
<fig:bias_variance>



The sampling overhead can also be estimated using the range of the estimator through Hoeffding's inequality. The #emph[range] of a random variable $hat(X)$, denoted as $upright(R) \[ hat(X) \]$, is the difference between the maximum and minimum possible values taken by $hat(X)$. Using Hoeffding's inequality, the number of samples that is sufficient to guarantee an estimation of $upright(E) \[ hat(X) \]$ to $epsilon.alt$-precision with $1 - delta$ probability is given by


$ N_(upright("hff"))^(epsilon.alt , delta) ( hat(X) ) = frac(ln ( 2 / delta ), 2 epsilon.alt^2) upright(R) \[ hat(X) \]^2 $<eqn:samp_number_hoeff>


which can be used to estimate the sampling overhead required for the error-mitigated estimator $hat(O)_(upright("em"))$ to achieve the same $epsilon.alt$ and $delta$ as the unmitigated estimator $hat(O)_rho$:


$ C_(upright("em")) = frac(N_(upright("shot"))^epsilon.alt ( hat(O)_(upright("em")) ), N_(upright("shot"))^epsilon.alt ( hat(O)_rho )) tilde frac(N_(upright("hff"))^(epsilon.alt , delta) ( hat(O)_(upright("em")) ), N_(upright("hff"))^(epsilon.alt , delta) ( hat(O)_rho )) = upright(R) \[ hat(O)_(upright("em")) \]^2 / upright(R) \[ hat(O)_rho \]^2 . $<eqn:samp_cost_hoeff>


== Faults in the circuit
<sec:circuit_faults>
To gain intuition about the performance and costs of QEM, we need a way to quantify the damages due to noise in the circuit. Doing this by modelling noise in complete generality on a quantum system can be very challenging~@lidarIntroductionDecoherenceNoise2013. One useful approximation, which is widely employed in the field of quantum error correction, is to model noise as discrete, probabilistic events named #emph[faults] that can occur at the various #emph[locations] in the circuit including gates, idling steps and measurements~@gottesmanIntroductionQuantumError2009 @terhalQuantumErrorCorrection2015. For simplicity, we will assume all locations are afflicted with Pauli noise with the error probability of location $f$ given by $p_f$ #footnote[All of the arguments will still apply if we define $1 - p_f$ as the coefficient of the error-free part of the Kraus representation of some general noise (we will select the Kraus representation that gives the largest $1 - p_f$). In this case, $1 - p_f$ is #emph[not] the average gate fidelity. For example, for any non-identity unitary channel, $1 - p_f$ will always be $0$, which is not the case for average gate fidelity. More generally, we can always apply Pauli twirling to transform all noise to Pauli noise such that our arguments become valid.]. If we further assume the error events in all locations are #emph[independent], then the total probability that there is no fault in the circuit is given by


$ P_0 = product_f ( 1 - p_f ) , $<eqn:no_error_rate_1>


which we will simply call the #emph[fault-free probability] of the circuit. It decays exponentially with the increase of the number of fault locations in the circuit (and thus the number of qubits and the circuit depth). Do note that the fault-free probability is #emph[not] the fidelity of the output state, but it is a lower bound for the fidelity under our noise assumption.


We can also quantify the amount of noise in the circuit using the average number of faults in each circuit run, which is given by:


$ lambda = sum_f p_f , $<eqn:circ_fault_rate>


and will be called the #emph[circuit fault rate]. In the simple case that all $M$ fault locations in the circuit have the same error rate $p$, we then simply have $lambda = M p$. If the circuit contains a large number (more than dozens) of fault locations, and the circuit fault rate is of the order of unity $lambda tilde 1$, then the number of faults occurring in a given circuit run can be modelled using a #emph[Poisson distribution] with mean $lambda$ using the Le Cam's theorem~@lecamApproximationTheoremPoisson1960 @endoPracticalQuantumError2018 @caiMultiexponentialErrorExtrapolation2021, i.e. the probability that $ell$ faults occur in the circuit is given by $P_ell = e^(- lambda) lambda^ell / ell !$. In this way, the fault-free probability is given by


$ P_0 = e^(- lambda) , $<eqn:no_error_rate>


which decay exponentially with the circuit fault rate. Note that for the intuitive arguments made in the next subsection, and indeed for general estimation about the feasibility of error mitigation, approximate estimates of $P_0$ and $lambda$ are often good enough to be useful.


== Exponential scaling of the sampling overhead
<sec:exp_samp_cost>
We can perform #emph[bias-free] QEM if we are able to post-select for the fault-free circuit runs without needing any additional circuit components. The fraction of circuit runs that are selected is simply given by the fault-free probability $e^(- lambda)$ in @eqn:no_error_rate, which means that we will still require $e^lambda$ times more circuit runs to obtain the same number of "effective" circuit runs as a noise-free machine and achieve the same level of shot noise. Hence, even allowing for the "magical" post-selection of fault-free circuit runs, the sampling overhead $C_(upright("em")) = e^lambda$ will still increase exponentially with the circuit fault rate (and thus the circuit size). This implies a sampling overhead of $C_(upright("em")) tilde 150$ when $lambda = 5$ and $C_(upright("em")) tilde 10^4$ when $lambda = 9$, which provides intuition on why QEM is unlikely to be efficient when the circuit fault rate is beyond $cal(O) (1)$. Of course, this does not constitute a rigorous bound on the overhead of QEM.


Now let us move beyond trying to extract the error-free state and instead focus on obtaining the right expectation value for the observable of interest. #cite(<caiMultiexponentialErrorExtrapolation2021>, form: "prose")@wangNoiseinducedBarrenPlateaus2021 have shown that the expectation value of Pauli observables under Pauli gate noise is bounded by an exponential decay curve against the increase of the circuit fault rate $lambda$. In order to resolve such an exponentially small quantity at large $lambda$, we will need an exponential number of samples ($C_(upright("em")) = cal(O) (e^(beta lambda))$ for some positive $beta$). This exponential scaling of sample overhead still applies when we consider error-mitigated estimators that are linear combinations of the output of such noisy circuits (see @sec:monte_carlo_sampling_exp).


For a given noisy circuit with the circuit fault rate $lambda$, rather than performing active correction to reduce $lambda$ in each circuit run like in quantum error correction, QEM relies on post-processing the outputs from an ensemble of circuit runs with the same circuit fault rate $lambda$ or above. Hence, through the simple examples above, we see that QEM cannot efficiently tackle noisy circuits with large $lambda$ #emph[on its own] due to the exponential sampling overhead. However, as we will see later, due to the much lower implementation cost for QEM in terms of additional circuit components and qubits, it has become an effective means to stretch the application potential of near-term noisy devices and will be a useful tool to help alongside quantum error correction in the longer term.


= METHODS
<sec:methods>
After introducing the overall concept of QEM, we will now look at how the various error-mitigated estimators are actually constructed through performing different QEM methods.


== Zero-noise extrapolation
<sec:zne>


In this section, we will make use of noisy states obtained at different circuit fault rates. The state obtained at the circuit fault rate $lambda$ will be denoted as $rho_lambda$. The noisy expectation value $"Tr" \[ O rho_lambda \]$ can be viewed a function of $lambda$. In this way, the ideal expectation value we want is just the value of the function at $lambda = 0$. Trying to obtain this zero-noise value using data points at different circuit fault rates brings us to the concept of #emph[zero-noise extrapolation] (also called #emph[error extrapolation]), which was first introduced by #cite(<liEfficientVariationalQuantum2017>, form: "prose")@temmeErrorMitigationShortDepth2017.


Using $lambda_1$ to denote the smallest circuit fault rate we can achieve, we can probe $"Tr" \[ O rho_lambda \]$ at a range of #emph[boosted] error rate ${ lambda_m }$ with $lambda_m < lambda_(m + 1)$ to obtain a set of data points $( ( lambda_m , "Tr" \[ O rho_(lambda_m) \] ) )$. We can model $"Tr" \[ O rho_lambda \]$ using a parametrised function $f ( lambda arrow(theta) )$ and fit it to the data points to obtain a set of optimal parameters $arrow(theta)^(*)$. The error-mitigated estimate of the zero-noise output $"Tr" \[ O rho_0 \]$ is then given by


$ upright(E) \[ hat(O)_(upright("em")) \] = f ( 0 arrow(theta)^(*) ) . $


A simple illustration of zero-noise extrapolation is shown in @fig:zne.


// [figvision] imgs/ZNE.png
// This panel displays a two-dimensional scatter plot with an overlaid curve, illustrating the process of
// zero-noise extrapolation. The horizontal axis represents the "Circuit fault rate: " ranging from 0.0 to 1.5,
// while the vertical axis indicates the "Expectation value" from 0.0 to 0.5. Three solid blue circular markers
// denote noisy expectation values measured at circuit fault rates of 0.5, 1.0, and 1.5. A dashed black line
// connects these points and extends to the y-axis, representing the fitted error-mitigated function f(; {}^*).
// This trend shows a non-linear decay in expectation value as noise increases. At the origin where the fault
// rate is zero, a red cross marks the extrapolated error-mitigated estimate, located at approximately 0.42.
#figure(image("imgs/ZNE.png", width: 48.0%),
  caption: [
    Obtaining the error-mitigated estimate using zero-noise extrapolation. Here we are performing extrapolation using three noisy expectation values at the circuit fault rate of $lambda = 0.5 , ~ 1 , ~ 1.5$, where $0.5$ is the lowest circuit fault rate we can achieve and the other two are obtained through boosting the noise in the device.
  ]
)
<fig:zne>



If #emph[$lambda$ is small], #cite(<temmeErrorMitigationShortDepth2017>, form: "prose") showed that $"Tr" \[ O rho_lambda \]$ can be approximated using a polynomial function in the same spirit as truncated Taylor expansion:


$ "Tr" \[ O rho_lambda \] approx f ( lambda arrow(theta) ) = sum_(ell = 0)^(M - 1) theta_ell frac(lambda^ell, ell !) . $<eqn:poly_approx>


Here we have a polynomial of degree $M - 1$, which has $M$ different free parameters and the zero-noise estimate we want is $theta_0^(*) = f ( 0 arrow(theta)^(*) )$. The simplest case is linear extrapolation with $M = 2$~@liEfficientVariationalQuantum2017. If we try to fit @eqn:poly_approx with $M$ data points, which is the minimal number of data points needed, we can perform Richardson extrapolation as discussed in #cite(<temmeErrorMitigationShortDepth2017>, form: "prose"). The corresponding error-mitigated estimate obtained using the set of data points $( ( lambda_m , "Tr" \[ O rho_(lambda_m) \] ) )$ is~@giurgica-tironDigitalZeroNoise2020


$ upright(E) \[ hat(O)_(upright("em")) \] = theta_0^(*) = sum_(m = 1)^M "Tr" \[ O rho_(lambda_m) \] product_(k eq.not m) frac(lambda_k, lambda_k - lambda_m) . $<eqn:expect_richardson>


The bias in our estimate is mostly due to our omission of the higher degree terms in the polynomial approximation, and thus we should expect $upright("Bias") \[ hat(O)_(upright("em")) \] = cal(O) (lambda^M)$.


The error-mitigated expectation value in @eqn:expect_richardson is a linear combination of the set of noisy expectation values ${ "Tr" \[ O rho_(lambda_m) \] }$, thus it can be estimated using the Monte Carlo sampling method(see @sec:monte_carlo_sampling) and the corresponding sampling overhead for Richardson extrapolation is given by:


$ C_(upright("em")) tilde (sum_(m = 1)^M lr(|product_(k eq.not m) frac(lambda_k, lambda_k - lambda_m)|))^2 . $<eqn:ric_samp_cost>


We see that if any of the probed circuit fault rates $lambda_m$ is too big or the gap between any two data points $lr(|lambda_m - lambda_k|)$ is too small, then $C_(upright("em"))$ will blow up and the extrapolation would become infeasible. For the simple case of equal-gap Richardson extrapolation ($lambda_m = m lambda_1$), the sampling overhead in @eqn:ric_samp_cost becomes $C_(upright("em")) tilde ( 2^M - 1 )^2$, which grow #emph[exponentially] with the number of data points $M$. The example here is mainly for illustrating the scaling behaviour of the sampling overhead. In practice, Richardson extrapolation usually takes more general data gap $Delta$ with data points at $lambda_m = lambda_1 + ( m - 1 ) Delta$. Even more sophisticated Richardson extrapolation beyond the equal-gap variant is possible, which can reduce the sampling overhead~@krebsbachOptimizationRichardsonExtrapolation2022.


As mentioned, theoretically Richardson extrapolation will only be valid for small $lambda$ due to the approximation we made in @eqn:poly_approx. However, a recent experiment by #cite(<kimScalableErrorMitigation2023>, form: "prose") showed that Richardson extrapolation can be effective at large $lambda$ in practice. There they performed a 26-qubit simulation of the 2D transverse field Ising model in the limit of strong entanglement, and showed that the error-mitigated evolution of the magnetisation is competitive in comparison to standard tensor network methods. To look for an extrapolation method that is naturally compatible with large $lambda$, we can consider a large circuit with Pauli noise. Such a circuit in the limit of $lambda arrow.r oo$ will become a random circuit with #emph[zero] expectation value for bounded traceless observables as mentioned in @sec:exp_samp_cost. A polynomial extrapolation function diverges at $lambda arrow.r oo$ and thus does not fit the intuition above, which motivates the extrapolation schemes that use an exponential decay curve or even a multi-exponential decay curve instead. Exponential extrapolation has proven to be able to achieve smaller biases than Richardson and more generally polynomial extrapolation in some numerical simulations and cloud experiments~@endoPracticalQuantumError2018 @giurgica-tironDigitalZeroNoise2020, especially for Pauli noise~@caiMultiexponentialErrorExtrapolation2021. It is worth noting that going beyond Richardson extrapolation, the error-mitigated estimator obtained through least-square fitting often does not have a closed-form representation, and thus there are not yet analytical expressions for their biases and variance in most of the cases. It is possible to combine exponential and Richardson extrapolation by performing Richardson extrapolation on the function $e^lambda "Tr" \[ O rho_lambda \]$ instead of $"Tr" \[ O rho_lambda \]$, which can give explicit bounds on the sampling overheads and biases~@caiPracticalFrameworkQuantum2021.


When we try to boost the noise in the circuit, we must know the exact factor of increase in the circuit fault rate. Ideally, we would want to increase the error strength in the various fault locations without changing their error models, which can be challenging to implement in experiments. #cite(<temmeErrorMitigationShortDepth2017>, form: "prose") showed that under the assumption that the noise was time-invariant, the noise could be effectively amplified by stretching and recalibrating the gate pulses, which was demonstrated on a superconducting platform~@kandalaErrorMitigationExtends2019. When targeting only single-qubit gate errors, these experiments can successfully perform Richardson extrapolation up to the fourth order, highlighting the accuracy of the noise amplification. Rescaling noise for two-qubit cross-resonance gates in these architectures can be more challenging due to reasons like more complicated drive Hamiltonian and drive-dependent coherence times~@chowSimpleAllMicrowaveEntangling2011. Nevertheless, pulse-stretching experiments with slowed-down two-qubit cross-resonance gates have been shown to be effective with linear extrapolation~@kandalaErrorMitigationExtends2019, most recently demonstrated in experiments with up to 26 qubits and a depth of 120~@kimScalableErrorMitigation2023.


Alternatively, #cite(<dumitrescuCloudQuantumComputing2018>, form: "prose")@giurgica-tironDigitalZeroNoise2020 @heZeronoiseExtrapolationQuantumgate2020 tried to boost the circuit fault rate by inserting a sequence of abundant gates that are equivalent to the identity if operated noiselessly. This is easier to implement and calibrate compared to the pulse-stretching method. However, while this will work well with depolarising gate noise, it may change the gate error model for more general gate noise such that the factor of increase in the error strength is no longer well-defined~@kimScalableErrorMitigation2023. To address this, #cite(<henaoAdaptiveQuantumError2023>, form: "prose") replaced the gate-based inverse with a pulse-based inverse that is applicable beyond depolarising noise. They also adapted the weights of the noise-amplified circuits to the strength of the noise in order to extend beyond the weak noise assumption in Richardson Extrapolation. Note that for both pulse stretching and gate insertion, an $M$-time increase in the noise strength might lead to up to an $M$-time increase in the circuit runtime. If the error models at the various fault locations are completely known, #cite(<liEfficientVariationalQuantum2017>, form: "prose") suggested that it is possible to controllably amplify the noise by probabilistically inserting gates to simulate the faults. In fact, as first noted in #cite(<caiMultiexponentialErrorExtrapolation2021>, form: "prose") and later in #cite(<mariExtendingQuantumProbabilistic2021>, form: "prose"), it would be more efficient to use these probabilistically inserted gates to perform probabilistic error cancellation (@sec:pec) instead, which yields new data points at #emph[reduced] error strength. Of course, learning a representative noise model can be challenging for large-scale devices, especially for correlated noise.


Due to the simplicity of zero-noise extrapolation, it is one of the most widely implemented QEM methods. Very recently, #cite(<kimEvidenceUtilityQuantum2023>, form: "prose") have simulated the time dynamics of the Ising model up to a circuit size of 127 qubits and 60 layers of 2-qubit gates, and with the help of ZNE, they are able to produce results in agreement with state-of-the-art classical simulations for that circuit size~@tindallEfficientTensorNetwork2023 @begusicFastClassicalSimulation2023 @kechedzhiEffectiveQuantumVolume2023. In addition to the experiments mentioned above, it was also successfully demonstrated in a wide range of other experiments, especially through cloud platforms~\[see e.g. #cite(<klcoQuantumclassicalComputationSchwinger2018>, form: "prose")@tacchinoQuantumImplementationArtificial2020 @keenQuantumclassicalSimulationTwosite2020 @yeter-aydenizPracticalQuantumComputation2020 @garmonBenchmarkingNoiseExtrapolation2020\].


== Probabilistic error cancellation
<sec:pec>
An alternative quantum error mitigation method referred to as #emph[probabilistic error cancellation] was introduced by #cite(<temmeErrorMitigationShortDepth2017>, form: "prose"). A particular feature of this method is that it can fully remove the bias of expectation values of generic quantum circuits ($upright("Bias") \[ hat(O)_(e m) \] = 0$). This comes at the expense of a sampling overhead $C_(e m)$ that grows exponentially with the circuit fault rate $lambda$. The key idea is noting that the noise-free expectation value can be written as a linear combination of expectation values from a set of noisy quantum circuits. This real-valued, linear combination can be interpreted as a #emph[quasi-probability decomposition] which can be sampled, c.f. @sec:monte_carlo_sampling, according to a Monte Carlo procedure. In this review we formalise the method using the superoperator representation~@gilchristVectorizationQuantumOperations2011, in which density matrices $rho$ are vectorised into $| rho chevron.r chevron.r$ and quantum channels are written as matrices acting on $| rho chevron.r chevron.r$, denoted using the curly font like $cal(U)$. Taking the trace with the observable $O$ is then written as the inner product with the vectorised observable $"Tr" \[ O rho \] = chevron.l chevron.l O | rho chevron.r chevron.r$. In this section, we employ this representation over the standard density matrix formalism for clearer representations of the linear combination and decomposition of a set of noisy quantum circuits.


To construct an estimator for an ideal channel $cal(U)$ from noisy operations, we need to choose a set of #emph[noisy] basis operations ${ cal(B)_n }$ that we can implement in the physical hardware. These operations are for example noisy gates, state preparation operations and measurements. These operations are assumed to be learned from the noisy hardware in experiments through some form of tomography. An example of a complete set of basis operations is discussed in #cite(<endoPracticalQuantumError2018>, form: "prose"). With a sufficiently large basis, we can decompose the ideal operation into


$ cal(U) = sum_n alpha_n cal(B)_n . $<eqn:ideal_gate_decomp>


with real coefficients $alpha_n$. Some of the coefficients $alpha_n$ in this expansion can be negative, which means that this decomposition does not necessarily correspond to a probabilistic mixture of physical maps. The expansion therefore is often not a physical map that can be implemented directly. However, if we are applying $cal(U)$ on some input state $rho_(upright("in"))$ in order to measure some observable $O$ and obtain the the ideal expectation value $"Tr"\[O rho_0\] = chevron.l chevron.l O | rho_0 chevron.r chevron.r$, then the ideal expectation value can be decomposed into:


$ chevron.l chevron.l O | rho_0 chevron.r chevron.r = chevron.l chevron.l O | cal(U) | rho_"in" chevron.r chevron.r = sum_n alpha_n chevron.l chevron.l O | cal(B)_n | rho_"in" chevron.r chevron.r , $ <eqn:expect_pec>


i.e. the ideal expectation value $chevron.l chevron.l O |cal(U)| rho_("in") chevron.r chevron.r$ can be decomposed into a linear combination of noisy expectation values $\{chevron.l chevron.l O | cal(B)_n| rho_("in") chevron.r chevron.r\}$ that we can obtain individually.


When the expansion in @eqn:expect_pec has many terms, the linear combination of noisy expectation values in @eqn:expect_pec can be estimated using the Monte Carlo sampling method (@sec:monte_carlo_sampling). The method samples different basis operations $cal(B)_n$ according to their weight in the expansion, i.e. the noisy circuit corresponding to $cal(B)_n$ is chosen with the probability $| alpha_n | Q^(- 1)$, where $Q = sum_n lr(|alpha_n|)$, and the circuit output is multiplied with $upright("sign") ( alpha_n ) Q$ before being used to estimate the error-mitigated expectation value $upright(E) \[ hat(O)_(upright("em")) \]$. This multiplicative factor leads to an increase in the variance and correspondingly to a sampling overhead (given by @eqn:monte_cost):


$ C_(upright("em")) & tilde Q^2 = (sum_n lr(|alpha_n|))^2 . $<eqn:pec_samp_cost>


In practice, we can often implement the noisy version of the target operation, denoted as $cal(U)_p$, which can be written as $cal(U)_p = ( 1 - p ) cal(U) + p cal(N)$ where $p$ is the operation error rate and $cal(N)$ is the noise element. It can be rewritten as:


$ cal(U) & = frac(1, 1 - p) cal(U)_p - frac(p, 1 - p) cal(N) . $<eqn:ideal_gate_decomp_2>


Compared to @eqn:ideal_gate_decomp, we see that $cal(U)_p$ is one of the basis operations $cal(U)_p = cal(B)_1$. In the simple case that $cal(N)$ is also one of the basis operations that we can implement: $cal(N) = cal(B)_2$, the sampling overhead for removing the noise in $cal(U)_p$ is given by:


$ C_(upright("em")) tilde Q^2 = (frac(1, 1 - p) + frac(p, 1 - p))^2 = (frac(1 + p, 1 - p))^2 . $<eqn:pec_samp_cost_gate>


More generally, $cal(N)$ must be decomposed into the rest of the basis $cal(N) = sum_(n eq.not 1) w_n cal(B)_n$. For the common scenario in which $cal(U)_p$ suffers from Pauli noise and we can perform high fidelity Pauli gates to be used as our basis ${ cal(B)_n }$, the sampling overhead is still given by @eqn:pec_samp_cost_gate.


Up to now we are using the basis set to cancel out the noisy component $cal(N)$ in $cal(U)_p = ( 1 - p ) cal(U) + p cal(N)$. Alternatively, there is another means of decomposition to effectively "invert" the noise channel $cal(E)_p$ in $cal(U)_p = cal(E)_p cal(U)$ as discussed in #cite(<temmeErrorMitigationShortDepth2017>, form: "prose") and #cite(<endoPracticalQuantumError2018>, form: "prose") and its resultant sampling overhead is similar. However, this noise-inversion implementation requires inserting additional operations after every noisy operation and thus we might need up to twice the original circuit runtime.


To perform the error cancellation described above, we need to have the full description of the noisy operation $cal(U)_p$. This can only be efficiently characterised for individual local gates. Any circuit we want to implement can be decomposed into a sequence of $M$ ideal gates ${ cal(U)_m }$, and the ideal expectation value we want to obtain will be


$ chevron.l chevron.l O | rho_0 chevron.r chevron.r = chevron.l chevron.l O | product_(m = 1)^M cal(U)_m | rho_"in" chevron.r chevron.r . $


Similar to @eqn:expect_pec, we decompose the individual gates into the noisy basis using @eqn:ideal_gate_decomp


$ chevron.l chevron.l O | rho_0 chevron.r chevron.r = bb(E) \[ hat(O)_"em" \] & = chevron.l chevron.l O | product_(m = 1)^M (sum_(n_m) alpha_(m n_m) cal(B)_(n_m)) | rho_"in" chevron.r chevron.r \
  & = sum_(arrow(n)) alpha_(arrow(n)) chevron.l chevron.l O | cal(B)_(arrow(n)) | rho_"in" chevron.r chevron.r $ <eqn:pec_linear_sum>


where $arrow(n) = ( n_1 , n_2 , dots.h.c , n_M )$ is the set of labels for a sequence of basis elements, and we have defined $cal(B)_(arrow(n)) = product_(m = 1)^M cal(B)_(n_m)$, $alpha_(arrow(n)) = product_(m = 1)^M alpha_(m n_m)$ and $Q = sum_(arrow(n)) lr(|alpha_(arrow(n))|)$. Note that the set of noisy basis elements ${ cal(B)_n }$ here includes the basis for all the gates in the circuit, it is thus over-complete and contains the noisy version of all the target gates. Again we can obtain samples of $hat(O)_(upright("em"))$ using Monte Carlo sampling as discussed above with the label of a single basis $n$ replaced by the label of a sequence of basis $arrow(n)$.


The overall sampling overhead of mitigating the errors in the whole circuit is simply the product of the sampling overhead of each gate. As explored in #cite(<temmeErrorMitigationShortDepth2017>, form: "prose") and subsequently #cite(<endoPracticalQuantumError2018>, form: "prose"), if we assume all the gates suffer from Pauli noise with the same error rate $p$, the circuit size $M$ is large and the circuit fault rate $lambda = M p$ is finite, then taking the product of the gate-level sampling overhead in @eqn:pec_samp_cost_gate we have:


$ C_(upright("em")) = product_(m = 1)^M (frac(1 + p, 1 - p))^2 approx e^(4 M p) = e^(4 lambda) . $<eqn:pec_samp_cost_circ>


In fact, the overhead here is still valid even if the gates in the circuit have different error rates, as long as the circuit faults follow a Poisson distribution (see @sec:circuit_faults). More generally, as first discussed by #cite(<caiMultiexponentialErrorExtrapolation2021>, form: "prose") and later by #cite(<mariExtendingQuantumProbabilistic2021>, form: "prose"), it is possible to only apply probabilistic error cancellation partially. Denoting the resultant circuit fault rate as $lambda_(upright("em"))$, the corresponding sampling cost is simply $C_(upright("em")) = e^(4 (lambda - lambda_(upright("em"))))$, which grows exponentially with the reduction in the circuit fault rate.


As mentioned, to be able to perform the decomposition in @eqn:ideal_gate_decomp, we need to have a set of basis elements that span the ideal operations, and full characterisation of this basis. #cite(<endoPracticalQuantumError2018>, form: "prose") have shown that such basis can be constructed using single-qubit Clifford gates and $Z$-measurement with reasonable fidelity, while the characterisation can be carried out efficiently using gate set tomography. In practice, we usually supplement this set of basis elements with the noisy version of the target operation, such that it is over-complete as discussed. Only noisy operations with local noise can be efficiently characterised using the protocol above.


A recent experimental implementation of the probabilistic error cancellation method used a correlated Pauli-noise model that is supported over the full gate layer on the device~@vandenbergProbabilisticErrorCancellation2023. The noise model is given in terms of a sparse Pauli-Lindbladian $cal(L) ( rho ) = sum_k lambda_k (P_k rho P_k - rho)$ for a set of Pauli matrices $P_k$, which can be efficiently learned for a polynomial number of Pauli terms (usually low-weight Pauli terms). Although the noise model is correlated across the full circuit, it can be inverted efficiently and its quasi-probability distribution can be sampled exactly. A similar approach was also adopted by #cite(<ferracinEfficientlyImprovingPerformance2022>, form: "prose") which used cycle benchmarking to characterise the low-weight correlated Pauli noise components for performing probabilistic error cancellation. It is also possible to mitigate these correlated noise components by performing noise characterisation using matrix product operators~@guoQuantumErrorMitigation2022, or with the help of learning-based methods~@strikisLearningBasedQuantumError2021 as will be discussed in~@sec:learning-based.


From @eqn:ideal_gate_decomp,eqn:pec_samp_cost, we see that the sampling overhead of probabilistic error cancellation is highly dependent on the basis we choose. For the standard basis proposed in #cite(<endoPracticalQuantumError2018>, form: "prose"), it will perform well when the gates in the circuit suffer from Pauli noise (which can be achieved via Pauli twirling). Going beyond that, #cite(<takagiOptimalResourceCost2021>, form: "prose") has derived a lower bound for the sampling overhead under general noise models. Such a lower bound on the sampling overhead has proven to be a good measure for many properties of the noise channel that we try to mitigate~@jiangPhysicalImplementabilityLinear2021 @regulaOperationalApplicationsDiamond2021 @guoNoiseEffectsPurity2023, but the basis required to reach this lower bound may not be implementable by the given hardware. To find a better practical basis beyond the standard basis, #cite(<piveteauQuasiprobabilityDecompositionsReduced2022>, form: "prose") proposed to use variational circuits to construct the basis and the authors numerically tested this using real hardware noise models. For actual experiments, probabilistic error cancellation has been successfully demonstrated by #cite(<songQuantumComputationUniversal2019>, form: "prose")@zhangErrormitigatedQuantumGates2020 on superconducting and trapped-ion platforms. #cite(<sunMitigatingRealisticNoise2021>, form: "prose") has shown that probabilistic error cancellation can also be applied to continuous noise processes, for which partial mitigation is possible by expanding the noise process into a perturbation series~@hamaQuantumErrorMitigation2022. It is also possible to use the non-Markovianity in noise to reduce the sampling cost~@hakoshimaRelationshipCostsQuantum2021.


== Measurement error mitigation
<sec:meas_miti>


Depending on the error mitigation procedure it is necessary to make a distinction between the types of errors that occur during a calculation. Errors that occur during the state preparation and measurement stage are referred to as SPAM errors~@merkelSelfconsistentQuantumProcess2013 @linIndependentStateMeasurement2021. The error that occurs at the final measurement stage introduces an additional bias in the expectation value of interest. To put this into a more concrete form, let us continue to use the super-operator representation introduced in @sec:pec. When we perform measurements and obtain the binary string $x in ( 0 , 1 )^N$ as the output, ideally we want to perform projective measurements in the computational basis $\{chevron.l chevron.l x |\}$. However, some measurement noise $cal(A)$ might occur and transform the projective measurements into some positive operator-value measures (POVM) $\{chevron.l chevron.l E_(x) |\} = \{chevron.l chevron.l x |cal(A)\}$, leading to a different output statistic.


The origins of the measurement errors are as diverse as the hardware that is used to implement quantum processors. For example, a dominant error in the measurement of superconducting qubits is due to thermal excitations and $T_1$-decay~@wallraffStrongCouplingSingle2004 @blaisCavityQuantumElectrodynamics2004, while for ion traps a major source of uncertainty arises from the difficulty of detecting an ion's dark state and collisions in the trap~@nagourneyShelvedOpticalElectron1986 @bergquistObservationQuantumJumps1986 @sauterObservationQuantumJumps1986. Other architectures experience noise in the measurement stage from different sources~@harocheExploringQuantumAtoms2006. From the perspective of the measurement error protocols most frequently considered in the literature, it is sufficient to consider a simplified model that is agnostic regarding the actual origin of the noise. This model makes the assumption that the noise channel $cal(A)$ has the computational subspace $\{chevron.l chevron.l x | | x in (0,1)^N\}$ as its invariant subspace, i.e. the resultant POVM basis $\{chevron.l chevron.l E_(x) |\}$ lives within the computational subspace. This is not the most general measurement error model, but it is nonetheless the most frequently considered model as other coherent errors are usually assumed to be part of the computational stage instead of the measurement stage. Under this assumption, the POVM $chevron.l chevron.l E_(x) |$ can be decomposed into the computational basis:


$ chevron.l chevron.l E_x | = sum_y chevron.l chevron.l E_x | y chevron.r chevron.r chevron.l chevron.l y | = sum_y chevron.l chevron.l x | cal(A) | y chevron.r chevron.r chevron.l chevron.l y | = sum_y A_(x y) chevron.l chevron.l y | . $ <eqn:noisy_meas_decomp>


Here the #emph[assignment matrix] $A$ is a #emph[transition matrix] (stochastic matrix) whose entries $chevron.l chevron.l x |cal(A)| y chevron.r chevron.r$ represent the transition probability from the measurement result $y$ to $x$ due to the noise channel $cal(A)$~@chowDetectingHighlyEntangled2010. The entry $A_(x y) = chevron.l chevron.l x |cal(A)| y chevron.r chevron.r = chevron.l chevron.l E_(x) | y chevron.r chevron.r$ can be obtained by estimating the probability of the $x$ outcome when we prepare the computational state $| y chevron.r chevron.r$ (assumed to be almost perfect) and perform the set of noisy measurement $\{chevron.l chevron.l E_(x) |\}$. If $A$ is full rank, then we can invert @eqn:noisy_meas_decomp and obtain:


$ chevron.l chevron.l y | = sum_x A_(y x)^(-1) chevron.l chevron.l E_x | $ <eqn:ideal_meas_decomp>


i.e. we can simulate the behaviour of the ideal measurement $\{chevron.l chevron.l y |\}$ using a linear combination of the noisy measurements $\{chevron.l chevron.l E_(x) |\}$, just as we have done in probabilistic error cancellation in @sec:pec. Hence, the associated sampling overhead will increase exponentially with the measurement faults rate, similar to @eqn:pec_samp_cost_circ for probabilistic error cancellation.


For an incoming state $| rho chevron.r chevron.r$, the output distribution using the ideal measurements is given by the vector $arrow(p)_0 = \{chevron.l chevron.l y | rho chevron.r chevron.r\}$ while the output distribution using the noisy measurements is $arrow(p)_("noi") = \{chevron.l chevron.l E_(x) | rho chevron.r chevron.r\}$. Applying @eqn:noisy_meas_decomp,eqn:ideal-_meas-_decomp on $| rho chevron.r chevron.r$, we then have:


$ arrow(p)_(upright("noi")) = A arrow(p)_0 quad arrow.r.double quad arrow(p)_0 = A^(- 1) arrow(p)_(upright("noi")) . $<eqn:inverse_prob>


For a given observable $O$ with the spectrum $arrow(O) = { O_x }$, i.e. $chevron.l chevron.l O | = sum_(x) O_x chevron.l chevron.l x |$, its ideal expectation value is:


$ chevron.l chevron.l O | rho chevron.r chevron.r = arrow(O)^T arrow(p)_0 = arrow(O)^T A^(-1) arrow(p)_"noi" . $ <eqn:inverse_matrix_expect>


Hence, the ideal expectation value can be obtained once we know the assignment matrix $A$ and the noisy output distribution $arrow(p)_(upright("noi"))$.


In early experiments with only a few qubits, #cite(<kandalaHardwareefficientVariationalQuantum2017>, form: "prose") have performed a full readout tomography of the noisy output distribution $arrow(p)_(upright("noi"))$ in the computational basis. Then, all entries of the assignment matrix $A$ were estimated, which can be used to estimate the ideal expectation value using @eqn:inverse_matrix_expect. This approach is not efficiently scalable as the size of $A$ scales exponentially with the number of qubits $N$.


The simplest way to tackle the problem is to assume that the measurement errors of different qubits are not correlated, which implies that the assignment matrix is just the tensor product of the assignment matrices of the individual qubits $A = ⨂_(n = 1)^N A_n$. However, realistic noise encountered in experiments may not be captured accurately by this simplified model and it can be observed that correlations between individual bit-flips are in fact present~@heinsooRapidHighfidelityMultiplexed2018.


#cite(<bravyiMitigatingMeasurementErrors2021>, form: "prose") try to construct the assignment matrix using continuous-time Markov processes with the generators (transition rate matrices) ${ G_i }$ being single- and two-qubit operators:


$ A = e^G quad upright("with") quad G = sum_(i = 1)^(2 N^2) r_i G_i . $


The assignment matrix $A$ is now determined by $2 N^2$ positive coefficients ${ r_i }$ that can be learned by only considering a polynomial number of input bit strings. Once the coefficients are learned, we can easily construct the inverse matrix $A^(- 1) = e^(- G)$ for error mitigation.


As mentioned in @sec:twirling, we can perform Pauli twirling on the noise channel $cal(A)$ by conjugating it with random Pauli operators, which will remove all the off-diagonal elements of $cal(A)$ in the Pauli basis and produce a Pauli channel $cal(D)$. This can be used to simplify measurement error mitigation as discussed by #cite(<vandenbergModelfreeReadouterrorMitigation2022>, form: "prose")@chenRobustShadowEstimation2021. Since we are only interested in the action of $cal(A)$ on the computational subspace, we only need to consider Pauli basis elements that are the tensor products of $Z$ denoted as $\{chevron.l chevron.l Z^(x) |\}$ with $x$ being the bit string that marks the qubits that are acted by $Z$. Suppose ideally we would like to perform the Pauli measurement $chevron.l chevron.l Z^(x) |$, however we can only perform the noisy measurement $chevron.l chevron.l Z^(x) |cal(A)$. Now using Pauli twirling, we can transform the noisy measurement into


$ chevron.l chevron.l Z^x | cal(D) = D_x chevron.l chevron.l Z^x | $ <eqn:noisy_Z_decomp>


using the fact that the twirled channel $cal(D)$ is diagonal in the Pauli basis with the entries being $D_(x) = chevron.l chevron.l Z^(x) |cal(D) | Z^(x) chevron.r chevron.r = chevron.l chevron.l Z^(x) |cal(A) | Z^(x) chevron.r chevron.r$. Thus the noisy measurement $chevron.l chevron.l Z^(x) |cal(D)$ is simply the ideal measurement $chevron.l chevron.l Z^(x) |$ rescaled by the factor $D_x$. For a given input state $| rho chevron.r chevron.r$, we have:


$ underbrace(chevron.l chevron.l Z^x | rho chevron.r chevron.r, "ideal") & = D_x^(-1) underbrace(chevron.l chevron.l Z^x | cal(D) | rho chevron.r chevron.r, "twirled noisy") . $


Hence, by transforming the observable into $Z^x$ and performing Pauli twirling, we only need to rescale the noisy expectation value by the factor $D_x^(- 1)$ to obtain the ideal expectation value. Note that since conjugation with $Z$ will have trivial effects within the computational subspace, we only need to conjugate the noise channel with a random operator in $( I , X )^(⊗ N)$ (i.e. random bit-flips) to achieve the effect of Pauli twirling mentioned above.


In practice, the ideal output distribution $arrow(p)_0$ is often sparse. With weak measurement noise, we would expect the corresponding noisy output distribution $arrow(p)_(upright("noi"))$ to also be sparse and have non-zero probability at all positions that are non-zero in $arrow(p)_0$. Using this fact, #cite(<nationScalableMitigationMeasurement2021>, form: "prose") proposed to focus on the action of measurement noise $cal(A)$ within the subspace spanned by the basis of $arrow(p)_(upright("noi"))$ with non-zero probability, which gives an assignment matrix with a much smaller dimension. The ideal output distribution $arrow(p)_0$ can then be obtained by inverting the assignment matrix within this subspace. The inversion can be sped up by considering a matrix-free preconditioned iteration algorithm.


Due to sampling noise, the estimation of ideal distribution $arrow(p)_0$ we obtained using matrix inversion in @eqn:inverse_prob may contain negative values are thus is not a valid probability distribution. However, it is still able to provide an unbiased expectation value estimate using @eqn:inverse_matrix_expect~@bravyiMitigatingMeasurementErrors2021. On the other hand, instead of using matrix inversion, one might try to solve a constrained optimisation problem with the cost function $∥A arrow(p)_0 - arrow(p)_(upright("noi"))∥_2^2$ such that $arrow(p)_0$ is a valid probability distribution. This can be solved using maximum likelihood~@chenDetectorTomographyIBM2019 @gellerRigorousMeasurementError2020 @maciejewskiMitigationReadoutNoise2020 or iterative Bayesian unfolding~@nachmanUnfoldingQuantumComputer2020.


There is a wide range of other techniques for combating measurement errors. In #cite(<hamiltonScalableQuantumProcessor2020>, form: "prose"), a representation based on cumulant expansion is proposed to capture correlations between observables. #cite(<kwonHybridQuantumClassicalApproach2021>, form: "prose") look into the use of Clifford twirling in the context of measurement error mitigation. Measurement error protocols that are directly tailored to VQE type calculations are possible~@barronMeasurementErrorMitigation2020. Other approaches propose the use of final pre-measurement entangling circuits to combat noise~@hicksActiveReadouterrorMitigation2022. #cite(<tannuMitigatingMeasurementErrors2019>, form: "prose") propose to exploit a potential asymmetry in the noise strength of the assignment matrix $A$ by flipping bit-values into a configuration less likely to be affected by noise. The experimental observations have been used to train classical neural networks to infer predictions of the correct expectation values~@palmieriExperimentalNeuralNetwork2020. As measurement noise is a major obstacle in almost all experimental set-ups, implementation of measurement error mitigation is almost #emph[ubiquitous in all near-term experiments].


== Symmetry constraints
<sec:sym>


A simple but effective scheme for suppressing errors is to identify errors that break the symmetries of the ideal quantum state, and remove them via post-selection. This notion originates from quantum error correction~@gottesmanStabilizerCodesQuantum1997 @terhalQuantumErrorCorrection2015, in which we explicitly define a set of measurements to detect and correct all local errors at the cost of additional qubit overhead. Though explicitly correcting errors is required for scalability~@shorFaulttolerantQuantumComputation1996, #emph[quantum error detection] of artificially-added symmetries has been widely recognised as an important milestone towards this end goal~@niggQuantumComputationsTopologically2014 @kellyStatePreservationRepetitive2015 @corcolesDemonstrationQuantumError2015 @gottesmanQuantumFaultTolerance2016 @linkeFaulttolerantQuantumError2017. In practical applications, quantum circuits often possess inherent symmetries that can be used for error mitigation without the need to execute a quantum circuit on an error-detection code. Measuring these #emph[inherent symmetries] and discarding circuit runs that produce the wrong results produces a (post-selected) state $rho_(upright("sym"))$. The broad class of schemes that directly or indirectly measure $"Tr" \[ O rho_(upright("sym")) \]$ are known collectively as #emph[symmetry verification]~@mcardleErrorMitigatedDigitalQuantum2019 @bonet-monroigLowcostErrorMitigation2018. If the symmetry measurements are perfect, $rho_(upright("sym"))$ must have non-decreasing overlap on the ideal state $rho_0$ compared to the noisy state $rho$ as we have thrown away states with zero overlaps. In practice, symmetry measurements may themselves introduce errors into the state, thus choosing the right symmetries and optimising their measurements are at the core of symmetry verification.


#cite(<mcardleErrorMitigatedDigitalQuantum2019>, form: "prose")@bonet-monroigLowcostErrorMitigation2018 proposed various easily-accessible symmetry operators $S$ for symmetry verification, drawing from those that naturally emerge in physical systems. In this context, given a physical system, its symmetry operators $S$ are operators that commute with the system Hamiltonian $H$: $\[ H , S \] = H S - S H = 0$. When this is the case, $H$ and $S$ may be simultaneously diagonalized, i.e. energy eigenstates $| Psi_j chevron.r$ can be chosen in such a way that $S | Psi_j chevron.r = s | Psi_j chevron.r$, where $s$ is an eigenvalue of $S$. Thus, measuring $S$ on a prepared quantum state, and post-selecting on the correct symmetry eigenvalue $s$ for the target energy eigenstate, should project one closer to the said energy eigenstate. Furthermore, time evolution by $e^(i H t)$ leaves the eigenspaces of $S$ invariant, which means that dynamic properties of the physical system may be studied entirely within these eigenspaces as well. Common examples of symmetries are the parity ($product_i Z_i$) and the $Z$ component of the total spin ($sum_i Z_i$) of a spin system, or the particle number $sum_i n_i$ of a fermionic system. Note that the Jordan-Wigner transformation maps $sum_i n_i$ to $sum_i Z_i$, modulo a constant shift. Given an $N$-qubit simulation, the eigensubspaces of these symmetries have dimension $2^(N - 1)$, $binom(N, (N - s) / 2)$ and $binom(N, s)$, respectively, with $s$ being the eigenvalue of the given eigensubspace. With the right $s$, these subspaces are large enough for executing classically intractable quantum algorithms. Note though that it is not necessary to enforce symmetries during an entire circuit in order to verify them at the end~@dallaire-demersLowdepthCircuitAnsatz2019. Even when using a circuit that does not conserve the symmetry of the target physical problem, symmetry verification can still be used for projecting back into the appropriate spin or number sector~@yenExactApproximateSymmetry2019 @khamoshiCorrelatingAGPQuantum2020 @tsuchimochiSpinprojectionQuantumComputation2020, which can be viewed as mitigating algorithmic errors (@sec:algo_error).


As mentioned, the process of #emph[direct] symmetry verification is carried out by measuring both the symmetry operators $S$ and the target observable $O$ in every circuit run and discarding runs that produce the wrong output for $S$ (i.e. fail the symmetry check). Since symmetries $S$ are typically global observables, measuring them alongside the target observable $O$ is non-trivial. The additional circuit components required for their measurements can introduce additional errors, reducing or even nullifying the effect of error mitigation. Various ways to measure multiple operators (e.g. the symmetry operator and the target observable) in the same circuit run are discussed in @sec:meas_tech. One way is to use a Hadamard test to measure a Pauli symmetry like the number parity~@mcardleErrorMitigatedDigitalQuantum2019 @bonet-monroigLowcostErrorMitigation2018. Other practical schemes involve measuring qubit-wise commuting operators~@izmaylovRevisingMeasurementProcess2019, i.e. when both $S$ and $O$ can be obtained through post-processing the same set of single-qubit Pauli measurements across all qubits (see @sec:meas_tech). This implies that if we are using only single-qubit rotations and readout to perform the measurements, symmetries such as the $Z$-component of the total spin $sum_i Z_i$ or parity $product_i Z_i$ cannot be measured simultaneously with any operator that is not diagonal in the computational basis.


The issue of qubit-wise commutativity presents a specific problem in chemistry where the fermion hopping operator $c_i^dagger c_j + c_j^dagger c_i$ (our target observable) commutes with the particle number $sum_i n_i$ (the symmetry operator), but not qubit-wise. An identical problem presents in spin physics between the operators $X_i X_j + Y_i Y_j$ and $sum_i Z_i$. This may be solved by noting that the rotation


$ exp \[ i pi / 8 (X_i Y_j - Y_j X_i) \] $<eqn:fsim_rotation>


maps $X_i X_j + Y_i Y_j$ to $Z_i - Z_j$ while leaving $Z_i + Z_j$ invariant~@hugginsEfficientNoiseResilient2021. In terms of fermionic systems, this is the operator $e^(i pi / 2 upright("FSWAP")_(i , j))$, where $upright("FSWAP") = c_i^dagger c_j + c_j^dagger c_i - n_i - n_j$~@googlequantumaiandcollaboratorsHartreeFockSuperconductingQubit2020. In a spin system, this allows for the joint measurement of hopping terms and the $Z$-component of the total spin using only a constant depth circuit (assuming all-to-all coupling). However, this measurement does not parallelise efficiently; one can only measure hopping terms simultaneously between disjoint pairs of qubits, requiring $O ( N )$ distinct measurements to estimate all spin-spin hopping terms simultaneously with the $Z$-component of the total spin. In contrast, without the requirement to simultaneously measure the total spin-$Z$ component, all spin-spin hopping terms may be estimated by just two distinct choices of single-qubit rotation and readout. In a fermionic system, we need $O ( N )$ distinct measurements in the first place for estimating all fermionic hopping terms due to the lack of mutually commuting terms~@bonet-monroigNearlyOptimalMeasurement2020, and so simultaneous measurements of the particle number do not present a significant overhead.


Instead of constructing circuits to simultaneously diagonalise and measure the symmetry operators $S$ and the target observable $O$, #cite(<bonet-monroigLowcostErrorMitigation2018>, form: "prose") showed that it is possible to perform effective post-selection via #emph[post-processing] in symmetry verification, which turns out to be closely related to subspace expansion~@mccleanHybridQuantumclassicalHierarchy2017 (see @sec:sub_expand). Let us consider the simple example in which there is only one single Pauli symmetry operator $S$, and the ideal state lives within the $+ 1$-eigenspace of $S$ defined by the projector $Pi = 1 / 2 ( 1 + S )$. In this way, if the state prepared prior to the post-selection is $rho$, the post-selected state is then


$ rho_(upright("sym")) = frac(Pi rho Pi, "Tr" \[ Pi rho Pi \]) . $
<eqn:sym_state>


The symmetry-verified expectation value for the target observable $O$ is given by


$ "Tr" \[ O rho_(upright("sym")) \] = frac("Tr" \[ O Pi rho Pi \], "Tr" \[ Pi rho Pi \]) = frac("Tr" \[ O_(upright("sym")) rho \], "Tr" \[ Pi rho \]) , $


where $O_(upright("sym")) = Pi O Pi$ is the symmetrised observable, i.e. the verified expectation value $"Tr" \[ O rho_(upright("sym")) \]$ is simply the quotient between the noisy expectation value of $O_(upright("sym"))$ and $Pi$. The symmetrised observable $O_(upright("sym"))$ and the symmetry projector $Pi$ can be further decomposed into the Pauli basis, e.g. if $O$ is Pauli, the Pauli decomposition of $O_(upright("sym"))$ is simply $O_(upright("sym")) = Pi O Pi = 1 / 4 (O + S O + O S + S O S)$. In this way, the expectation values of $O_(upright("sym"))$ and $Pi$ can be obtained by measuring the expectation values of these Pauli basis operators (or via Monte Carlo sampling in @sec:monte_carlo_sampling). In the method described above, we only need to measure one Pauli observable in a given circuit run, which can be carried out using only single-qubit Pauli measurements without needing additional circuit components. The simple examples above can be further generalised into the cases of multiple symmetries and non-Pauli symmetries with a change in the definition of the projector $Pi$, reflecting a change in the symmetry subspace. We can also decompose the observables into bases beyond the Pauli basis, as long as the components are easy to measure. Instead of combining the measurement results of the basis to reconstruct the projected observable $O_(upright("sym"))$ and the projector $Pi$, #cite(<caiQuantumErrorMitigation2021>, form: "prose") showed that it is possible to achieve smaller biases by combining these measurement results with different weights at the cost of larger sampling overhead.


Note that as we try to describe different ways of performing symmetry verification above, we clearly separate post-selection away from post-processing (for a clear distinction between different methods) even though technically post-selection is a specific type of post-processing in the most general context of QEM.


For direct in-circuit symmetry verification, the fraction of circuit runs that are "useful" is simply the "pass rate" of the symmetry checks given by $"Tr" \[ Pi rho \]$. The corresponding sampling overhead is simply the #emph[inverse] of this "pass rate": $C_(upright("em")) tilde "Tr" \[ Pi rho \]^(- 1)$. The fault-free post-selection discussed in @sec:exp_samp_cost can be viewed as the ideal symmetry verification that can detect all faults. It can achieve zero bias, but correspondingly its sampling overhead also sets the upper bound for all possible direct symmetry verification. As discussed above, we can greatly simplify the measurement circuit through post-processing, but this will come at a higher sampling overhead, which scales as $C_(upright("em")) tilde "Tr" \[ Pi rho \]^(- 2)$~@hugginsEfficientNoiseResilient2021 @caiQuantumErrorMitigation2021.


Though it is simplest to rely on the native symmetries of a system for the purposes of error mitigation, one can consider adding more symmetries artificially, or unitarily transforming a system to improve the error mitigation power of a set of symmetries. This is important as symmetry-based methods cannot mitigate against errors that commute with all symmetries of the system. It was shown in #cite(<bonet-monroigLowcostErrorMitigation2018>, form: "prose") that one can unitarily transform chemistry Hamiltonians so that no single-qubit operator commutes with all symmetries, and that this can be preferable even to removing qubits from the system. They also described a basic scheme to add artificial symmetries to a system. However, this scheme makes local system operators highly non-local, and thus is relatively unscalable.


A solution to the above was found in the Bravyi-Kitaev superfast (BKSF) transformation, where artificial symmetries are used to transform local fermionic Hamiltonians to local qubit Hamiltonians~@bravyiFermionicQuantumComputation2002 @setiaBravyiKitaevSuperfastSimulation2018. These symmetries are necessary for implementing a geometrically-local fermion-to-qubit transformation in more than one dimension, and at the same time they also provide a natural boon for symmetry-based QEM. The list of fermion-to-qubit transformations has seen significant development and optimisation in recent years~@setiaSuperfastEncodingsFermionic2019 @steudtnerFermiontoqubitMappingsVarying2018 @steudtnerQuantumCodesQuantum2019, with attempts to optimise the number of local errors that can be mitigated~@jiangMajoranaLoopStabilizer2019 @derbyCompactFermionQubit2021a. It was pointed out in #cite(<jiangMajoranaLoopStabilizer2019>, form: "prose") that this need not be contained to fermionic lattice models; as time evolution on a fermionic system may be mapped to a series of operations that are local on a lattice (without any asymptotic growth in the circuit depth), one can implement this using a mapping intended for a local fermionic lattice without paying the price of some system observables being extensively large. #cite(<jiangMajoranaLoopStabilizer2019>, form: "prose") further found an encoding (the 'Majorana loop stabiliser code', or MLSC) that can mitigate or even correct all single-qubit errors, making it in effect an error correcting code of distance $3$. Unfortunately, it appears that these methods cannot be extended to construct codes of arbitrarily large distances due to the Eastin-Knill theorem~@eastinRestrictionsTransversalEncoded2009.


Encoding the qubits into QEC codes is also a way to add artificial symmetry. Performing direct in-circuit verification in this case is simply quantum error detection. However, if the symmetries (stabilisers) of the code are hard to be directly measured due to high weight or connectivity constraints, then as discussed above, one may instead perform post-processing verification for QEC codes~@mccleanDecodingQuantumErrors2020. This was later extended to include mid-circuit stabiliser checks~@tsubouchiVirtualQuantumError2023 and bosonic codes~@endoQuantumErrorMitigation2022a.


A large number of experiments have demonstrated stabiliser measurements in error correction codes throughout the 2010's;~@niggQuantumComputationsTopologically2014 @kellyStatePreservationRepetitive2015 @corcolesDemonstrationQuantumError2015 @linkeFaulttolerantQuantumError2017 @vuillotErrorDetectionHelpful2018. However, to the best of our knowledge the first experimental demonstration of symmetry verification using #emph[natural] symmetries ($product_i Z_i$) in a quantum algorithm was by #cite(<sagastizabalExperimentalErrorMitigation2019>, form: "prose") through post-processing, as low-cost techniques to measure natural symmetries were not known prior to this. Later, #cite(<googlequantumaiandcollaboratorsHartreeFockSuperconductingQubit2020>, form: "prose") made direct simultaneous measurement of the number operator and the fermionic 1-RDM using the FSWAP rotation (@eqn:fsim_rotation) and combined this with McWeeny purification (@sec:pur). #cite(<stanisicObservingGroundstateProperties2022>, form: "prose") has successfully demonstrated the verification of multiple symmetries (number, particle-hole symmetry, and total spin) and also combine it with learning-based methods (@sec:learning-based). Due to the simplicity and effectiveness of symmetry verification, it has been employed in a wide range of other experiments \[see e.g. #cite(<googlequantumaiandcollaboratorsObservationSeparatedDynamics2020>, form: "prose")@neillAccuratelyComputingElectronic2021 @stanisicObservingGroundstateProperties2022 @dborinSimulatingGroundstateDynamical2022 @googlequantumaiandcollaboratorsFormationRobustBound2022\].


== Purity constraints
<sec:pur>


Many quantum algorithms target the preparation of an ideal state $rho_0$ that is pure: $rho_0 = | psi_0 chevron.r chevron.l$|. Many common noise channels are stochastic, which will turn our ideal pure state $rho_0$ into some noisy mixed state $rho$. At a high level, error mitigation techniques based on purity constraints attempt to reduce the bias in the expectation value by trying to approximate the pure state closest to $rho$. If we look at the spectral decomposition of $rho$,


$ rho = sum_(i = 1)^(2^N) p_i | phi.alt_i chevron.r chevron.l , | $<eqn:spectral_decomp>


where the eigenvalues are ordered $p_i >= p_j$ for $i < j$ and we assume $p_1 > p_2$ for simplicity, then the closest pure state to $rho$ in the trace distance is simply the dominant eigenvector $| phi.alt_1 chevron.r chevron.l$|. In principle, one could use the quantum principle component analysis to sample from the eigenbasis of $rho$~@lloydQuantumPrincipalComponent2014. Combined with post-selection this would allow for the efficient preparation of the dominant eigenvector. However, the additional circuit required is too deep for mitigating errors in near-term devices and thus simpler strategies are needed.


One such strategy, referred to as #emph[virtual distillation] (VD)~@hugginsVirtualDistillationQuantum2021 or #emph[error suppression by derangement] (ESD)~@koczorExponentialErrorSuppression2021, uses collective measurements of $M$ copies of $rho$ in order to access expectation values with respect to the $M^(upright("th"))$ degree purified state


$ rho_(upright("pur"))^(( M )) = frac(rho^M, "Tr" \[ rho^M \]) = frac(1, sum_(i = 1)^(2^N) p_i^M) sum_(i = 1)^(2^N) p_i^M | phi.alt_i chevron.r chevron.l . | $<eqn:powers_of_rho>


We see that under the assumption $p_1$ is strictly greater than $p_2$, we have $lim_(M arrow.r oo) rho_(upright("pur"))^(( M )) = | phi.alt_1 chevron.r chevron.l$|. The rate at which this is achieved is exponential in the number of copies used for purification $M$. The remaining bias in the VD/ESD estimator at $M arrow.r oo$ comes from the deviation between $| phi.alt_1 chevron.r chevron.l$| and the target state $rho_0$, which is sometimes known as the #emph[coherent mismatch] or #emph[noise floor]~@koczorExponentialErrorSuppression2021 @hugginsVirtualDistillationQuantum2021. As the largest sources of noise in state-of-the-art quantum devices are typically incoherent, this coherent mismatch can be expected to be significantly smaller than the error in the unmitigated state. Indeed, numerical and analytic studies have confirmed that the error suppression from VD/ESD can be of multiple orders of magnitude for large systems, even using as little as $M = 2$ copies of the state~@koczorDominantEigenvectorNoisy2021 @koczorExponentialErrorSuppression2021 @hugginsVirtualDistillationQuantum2021.


It was shown by #cite(<koczorExponentialErrorSuppression2021>, form: "prose")@hugginsVirtualDistillationQuantum2021 that one can estimate expectation values of the purified states in @eqn:powers_of_rho without ever having to prepare them on a quantum device. The expectation value of this purified state with respect to the observable of interest $O$ is $"Tr"\[O"smash"{rho^((M))_("pur")}\] = "Tr"\[O rho^M\]/"Tr"\[rho^M\]$. In VD/ESD, this is obtained by estimating $"Tr" \[ O rho^M \]$ and $"Tr" \[ rho^M \]$ in separate measurements. Let $S_M$ be the cyclic permutation operator between $M$ copies of $rho$, the quantity $"Tr" \[ O rho^M \]$ can be estimated using


$ "Tr" \[ O rho^M \] = "Tr" \[ S_M O_m rho^(⊗ M) \] = "Tr" \[ S_M overline(O) rho^(⊗ M) \] $<eqn:shift>


where $O_m$ is the operator $O$ acting on the $m^(upright("th"))$ copy and $overline(O) = 1 / M sum_m O_m$ is the observable symmetrised under copy permutation. Thus $"Tr" \[ O rho^M \]$ can be obtained by measuring $S_M O_m$ or $S_M overline(O)$ on $M$ noisy copies of $rho$. A diagrammatic proof of @eqn:shift is shown in @fig:VD_proof. One can extend this to estimate $"Tr" \[ rho^M \]$ by putting $I$ in place of $O$.


// [figvision] imgs/VDProof.png
// Panel a: This is a tensor network diagram illustrating the trace of an operator acting on three copies of a
// density matrix. On the left, three vertically stacked square nodes represent the density matrices (ρ). The top
// node has an operator box (O) attached to its left side. A large loop connects the right output of the bottom ρ
// back to the left input of the top O, forming a closed cycle. A dashed rectangular box labeled S3 encloses the
// connections between the three ρ nodes, indicating a permutation operation where lines cross over each other.
// Below this structure is the label Tr[S3 O1 ρ⊗3]. Panel b: This panel displays the simplified result of the
// calculation shown in panel a, separated by an equivalence symbol. It consists of a single horizontal row of
// four connected square boxes. From left to right, they are labeled O, ρ, ρ, and ρ. A continuous line loops from
// the far right of the last ρ box back to the far left of the O box, representing the trace operation. Beneath
// this linear chain is the mathematical expression Tr[Oρ³], signifying that the complex permuted network
// simplifies to the trace of the operator multiplied by the cube of the density matrix.
#figure(image("imgs/VDProof.png", width: 48.0%),
  caption: [
    A diagrammatic proof of @eqn:shift for 3 copies ($M = 3$) with the observable acting on the first copy ($m = 1$). The proof here uses tensor network notations~@bridgemanHandwavingInterpretiveDance2017 and it can be easily extended to more copies and/or with $O$ acting on the $m^(upright("th"))$ copy rather than the first.
  ]
)
<fig:VD_proof>



Measuring a global operator like $S_M$ can be challenging, but it can be decomposed into transversal operations among different copies $S_M = ⨂_(n = 1)^N tilde(S)_M^(( n ))$ where $tilde(S)_M^(( n ))$ cyclically permute the $n^(upright("th"))$ qubits of different copies as shown in @fig:copy_swap. If the observable $O$ acts on a single qubit, then the symmetrised observable $overline(O)$ will commute with all $tilde(S)_M^(( n ))$, and thus $S_M overline(O)$ can be obtained by measuring low-weight operators $tilde(S)_M^(( n ))$ and $O_m$ for all $n$ and $m$ and then post-process. This requires only transversal operations among the identically-labelled qubits of each copy of $rho$, avoiding global measurement. Explicit circuits for $O = Z$ and $M = 2 , 3$ without ancilla qubits are given by #cite(<hugginsVirtualDistillationQuantum2021>, form: "prose")\; more general measurement may be achieved by a Hadamard test using ancilla qubits~@hugginsVirtualDistillationQuantum2021 @koczorExponentialErrorSuppression2021. If the observable $O$ is not single-qubit, but it is a tensor product of single-qubit operators: $O = ⨂_(n = 1)^N G^(( n ))$ (e.g. $O$ is Pauli), then the observable $S_M O_m$ in @eqn:shift can be decomposed into a tensor product of low-weight operators $⨂_(n = 1)^N tilde(S)_M^(( n )) G_m^(( n ))$ which can be measured in a transversal manner~@caiLoopedPipelinesEnabling2023. We can use Hadamard tests to measure each $tilde(S)_M^(( n )) G_m^(( n ))$, which require $N$ ancilla qubits in total. To efficiently carry out any of the low-weight measurement schemes above, we need transversal operations among different copies, which can be challenging to implement in practice and may involve long-range interactions. A hardware architecture with native transversal operations among different copies has been proposed~@caiLoopedPipelinesEnabling2023, in which an example implementation of VD/ESD is shown with almost no space-time overhead.


// [figvision] imgs/CopySwap.png
// Panel a displays a schematic diagram of the operator S2. On the left, two horizontal black lines represent
// qubits labeled "copy 1" (top) and "copy 2" (bottom). A vertical black line connects them, featuring an 'X'
// symbol at both intersection points. The label S_2 is centered on this vertical connector. This layout
// illustrates a direct swap operation between the two copies. Panel b depicts a circuit decomposition into
// transversal operators. It shows multiple parallel horizontal lines representing qubits across different
// layers. Three distinct sets of operations are stacked vertically, indicated by curly braces. The top set
// involves red lines and is labeled {S}_2^{(1)}. The middle set uses blue lines and is labeled {S}_2^{(2)}. The
// bottom set utilizes green lines and is labeled {S}_2^{(N)}. Each colored layer features 'X' symbols connecting
// adjacent horizontal lines, demonstrating how the global swap is broken down into local interactions.
#figure(image("imgs/CopySwap.png", width: 37.0%),
  caption: [
    Decomposition of the copy-swap operator $S_2$ into transversal qubit-swap operators $tilde(S)_2$. Similar decomposition also applies to other cyclic copy-permutation operators $S_M$ with $M > 2$.
  ]
)
<fig:copy_swap>



In the more general case, one can imagine either unitarily transforming $O$ to a single-qubit observable (if possible) or linearly decomposing it into a sum of simpler terms (which is always possible). One could additionally imagine decomposing $S_M O_m$ or $S_M overline(O)$ into a linear combination of Pauli operators and measuring the whole set of operators using shadow tomography~@huangPredictingManyProperties2020 @seifShadowDistillationQuantum2023 @huLogicalShadowTomography2022. This has the advantage that one may reuse a single copy of $rho$ rather than using multiple physical copies. However, the sampling cost in this case scale exponentially with the number of qubits and thus may be difficult to scale beyond small system sizes~@seifShadowDistillationQuantum2023.


Instead of estimating $"Tr" \[ O rho^2 \]$ using two copies of $rho$ separated in space, it is possible to do the estimation using two copies separated in time. This technique was given multiple names since its initial incarnations~@obrienErrorMitigationVerified2021 @huoDualstatePurificationPractical2022 @caiResourceefficientPurificationbasedQuantum2021, but here we refer to it as #emph[echo verification] (EV). To perform EV, ideally we would want to measure the ideal state projector $rho_0 = | psi_0 chevron.r chevron.l$| at the end of the circuit for post-selection, which will return $1$ if the output state is the ideal state and $0$ otherwise, just like a symmetry check. The measurement of the projector $rho_0$ is carried out by applying the inverse of the primary circuit~@obrienErrorMitigationVerified2021 and the noise in the inverse circuit means that we are effectively measuring the noisy operator $overline(rho)$ instead of $rho_0$. If we measure the observable of interest $O$ along with the noisy projector $overline(rho)$ in the same circuit run and post-select according to the outcome of $overline(rho)$, we are effectively performing measurement of $O$ on the state $( overline(rho) rho + rho overline(rho) ) / ( 2 "Tr" \[ overline(rho) rho \] )$~@huoDualstatePurificationPractical2022. Compared to @eqn:powers_of_rho, we see that this is simply the $2^(upright("nd"))$ degree purified state with $overline(rho)$ in place of $rho$. The measurement of $O$ alongside $overline(rho)$ is usually carried out using a Hadamard test~@obrienErrorMitigationVerified2021. Alternatively, it is possible to achieve a similar degree of error suppression without the ancilla by preparing a superposition of $rho_0$ with a known eigenstate of $O$ and applying the gate $O$ on the quantum state (assuming $O$ is unitary)~@luAlgorithmsQuantumSimulation2021 @obrienErrorMitigationVerified2021, though this is not formally equivalent to $2^(upright("nd"))$ degree purification. The error mitigation power of EV has been demonstrated in numerical simulation~@obrienErrorMitigationVerified2021 and a four-qubit experiment~@huoDualstatePurificationPractical2022. The results differ depending on the exact circuit implementation of the methods, even in simplified noise models~@obrienErrorMitigationVerified2021, indicating that further optimising the circuit implementation can be an interesting direction to investigate. #cite(<guNoiseResilientPhaseEstimation2023>, form: "prose") recently proved that applying EV to control-free phase estimation~@luAlgorithmsQuantumSimulation2021 @russoEvaluatingEnergyDifferences2021 @obrienErrorMitigationVerified2021 corrects any noise source with Hermitian Kraus operators to first-order.


Due to their similarity, EV and VD/ESD are directly comparable in terms of performance and resource requirements. If one wishes to suppress the incoherent contributions of $rho$ beyond $2^(upright("nd"))$ degree purification, then one can only use VD/ESD instead of EV. However, EV has a smaller qubit footprint and requires less circuit overhead for measurement (especially as it removes the need to perform operations across multiple copies of the same state). In fact, EV can be combined with VD/ESD to achieve a high degree of purification with a lower qubit and circuit overhead~@caiResourceefficientPurificationbasedQuantum2021. There is also a difference between these two approaches in terms of their sampling overhead, similar to the difference between the sampling overhead of direct and post-processing symmetry verification (@sec:sym). For EV, the error-mitigation is done through direct post-selection, and thus the sampling overhead is simply the inverse of the success probability $C_(upright("em")) tilde "Tr" \[ overline(rho) rho \]^(- 1) tilde "Tr" \[ rho^2 \]^(- 1)$. For the two-copy version of VD/ESD, the error-mitigation is done through effective post-selection (post-processing), and thus the sampling overhead increases more steeply, scaling as $C_(upright("em")) tilde "Tr" \[ rho^2 \]^(- 2)$. More generally, the sampling cost of VD/ESD scales exponentially in the number of copies $M$ (as $"Tr" \[ rho^M \]$ is exponentially small in $M$ unless $rho$ is pure). If the faults in the circuit follow a Poisson distribution (@sec:circuit_faults), we then have $"Tr" \[ rho^2 \] lt.tilde P_0^2 = e^(- 2 lambda)$ where $P_0$ is the fault-free probability of the circuit and $lambda$ is the circuit fault rate. This suggests that both EV and VD/ESD can incur a sampling cost growing exponentially with the circuit fault rate, just as we have discussed for general bias-free QEM in @sec:exp_samp_cost. Furthermore, both methods (in their standard form) lack the parallelisability of unmitigated expectation value estimation. As mentioned above VD/ESD typically estimates expectation values of only $N$ operators (rather than their products). EV is restricted further; it was shown in~@pollaOptimizingInformationExtracted2023 that EV cannot be efficiently parallelised for even commuting observables, reducing the information extracted by the method to a single bit per state preparation. Though this can be significantly optimised over a simple Pauli decomposition of a complex $O$~@pollaOptimizingInformationExtracted2023, it presents roughly an $O ( N )$ overhead in sampling compared to VD/ESD.


The original formulation of EV in terms of projection on the initial state gives a clear connection between purification- and (symmetry) projection-based techniques (@sec:sym). Though they are clearly not equivalent, this raises the question of whether a similar connection can be made to VD/ESD. Some connection was originally made in #cite(<hugginsVirtualDistillationQuantum2021>, form: "prose"), where it was pointed out that in the eigenbasis ${ | phi.alt_j chevron.r }$ of $rho$, the swap operator measurement has zero expectation value on terms in $rho ⊗ rho$ except for those of the form $| phi.alt_j chevron.r chevron.l phi.alt_j | ⊗ | phi.alt_j chevron.r chevron.l phi.alt_j |$. #cite(<caiQuantumErrorMitigation2021>, form: "prose") show that VD/ESD can naturally arise from the verification of copy-permutation symmetry by replacing the symmetry projector with a general linear combination of permutation operators, which is also connected to subspace expansion using symmetry operators (will be discussed in @sec:sub_expand). #cite(<yoshiokaGeneralizedQuantumSubspace2022>, form: "prose") further exploited the connection between VD/ESD and subspace expansion and looked at the effect of performing error mitigation using a linear combination of states with different degrees of purification. Both EV and VD/ESD have been successfully implemented experimentally in #cite(<obrienPurificationbasedQuantumError2023>, form: "prose"), where they have performed variational ground state energy estimation up to 20 qubits (2 copies of 10-qubit states for VD/ESD) and achieved 1-2 orders of magnitude error reduction by applying these QEM methods.


== Subspace expansions
<sec:sub_expand>


In some quantum tasks, one has knowledge of not only the ideal circuit and potential noise sources, but also the structure of the task at hand. One such class of methods that can take advantage of the knowledge of the problem are #emph[quantum subspace expansion] techniques~@mccleanHybridQuantumclassicalHierarchy2017 @mccleanDecodingQuantumErrors2020 @takeshitaIncreasingRepresentationAccuracy2020. Many tasks in quantum computing, such as optimisation or state preparation, can be phrased as the desire to minimise the objective function $chevron.l psi | H | psi chevron.r$ with respect to the state $| psi chevron.r$ for some known Hermitian operator $H$. Very often we are unable to directly prepare the optimal state, either due to a coherent error in our implementation of the ideal circuit, or a simple lack of knowledge of the ideal circuit. However, there is usually a set of $M$ different states ${ | phi.alt_i chevron.r }$ (linearly independent but not necessarily orthogonal to each other) that we can easily prepare, which can be used to construct our target state through linear combination $| psi_(arrow(w)) chevron.r = sum_(i = 0)^(M - 1) w_i | phi.alt_i chevron.r$. In this way, the problem of finding the optimal state becomes finding the optimal set of coefficients $arrow(w)^(*)$:


$ arrow(w)^(*) = "arg min"_(arrow(w)) chevron.l psi_(arrow(w)) | H | psi_(arrow(w)) chevron.r quad quad upright("s.t. ") chevron.l psi_(arrow(w)) | = chevron.r 1 . $<eqn:pure_state_expansion>


This has the well-known exact solution in the form of a generalised linear eigenvalue problem


$ overline(H) W = overline(S) W E , $<eqn:gen_eigen>


where


$ overline(H)_(i j) = chevron.l phi.alt_i | H | phi.alt_j chevron.r , quad quad overline(S)_(i j) = chevron.l phi.alt_i | phi.alt_j chevron.r , $


i.e. $overline(H)$ is the $M times M$ matrix representations of $H$ in the chosen basis set ${ | phi.alt_i chevron.r }$ and $overline(S)$ is the overlap matrix for the basis set. In @eqn:gen_eigen, $W$ and $E$ are the matrices of eigenvectors and eigenvalues, respectively, of the solved problem. The eigenvector in $W$ with the lowest eigenvalue is precisely the optimal combination of coefficients $arrow(w)^(*)$ for the state $| psi_(arrow(w)^(*)) chevron.r$.


If we want to obtain the improved expectation value of some observable $O$ with respect to our new found state $| psi_(arrow(w)^(*)) chevron.r$, it is simply given as:


$ chevron.l psi_(arrow(w)^(*)) | O | psi_(arrow(w)^(*)) chevron.r = sum_(i , j = 0)^(M - 1) w_i^(*) w_j^(*) chevron.l phi.alt_i | O | phi.alt_j chevron.r $


i.e. we can construct it using the optimal weight $arrow(w)^(*)$ and the measurement results of $chevron.l phi.alt_i | O | phi.alt_j chevron.r$, without needing to explicitly prepare $| psi_(arrow(w)^(*)) chevron.r$. For the special case of $O = H$, the improved expectation value is simply given by the smallest eigenvalue in $E$ when we solve @eqn:gen_eigen. If desired however, one could prepare the state $| psi_(arrow(w)^(*)) chevron.r$ via LCU methods~@childsHamiltonianSimulationUsing2012 in order to use it as the input state for a subsequent quantum routine.


If one takes the limit of choosing $| phi.alt_i chevron.r$ to be a complete basis for the whole Hilbert space, then solving the optimisation problem will return the ideal state, however choosing an exponentially large space to perform classical optimisation obviously defeats the purpose of using a quantum computer to begin with. Hence, how to choose the right set of basis state ${ | phi.alt_i chevron.r }$ is the key to the success of quantum subspace expansion. The first basis state $| phi.alt_0 chevron.r$ we select is usually the best state that we can prepare before performing quantum subspace expansion. In this way, in the worst case we will simply obtain back $| phi.alt_0 chevron.r$ through subspace expansion.


For the other basis states, the original work of #cite(<mccleanHybridQuantumclassicalHierarchy2017>, form: "prose") suggests that we can draw inspiration from the configuration interaction (CI) expansions~@helgakerMolecularElectronicStructureTheory2000 in quantum chemistry, which is commonly used for improving energy and properties of mean-field states as well as determining excited states for response properties. There each of the other basis states is generated by applying an #emph[expansion basis] operator $G_i$ on the original state such that $G_i | phi.alt_0 chevron.r = | phi.alt_i chevron.r$. Knowledge of a good set of expansion basis operators ${ G_i }$ can come from symmetry considerations, excitation operators, or simply knowing that correcting (as opposed to replacing) the state $| phi.alt_0 chevron.r$ requires that the additional states are connected directly or indirectly through $H$. In this way, the expanded state is now $| psi_(arrow(w)) chevron.r = Gamma_(arrow(w)) | phi.alt_0 chevron.r$ where $Gamma_(arrow(w)) = sum_(i = 0)^(M - 1) w_i G_i$ is the #emph[expansion operator], which is a weighted sum of expansion basis operators. Once the expansion basis operators are determined, the matrix elements required for solving the optimisation equation in @eqn:gen_eigen can be measured on a quantum computer through


$ overline(H)_(i j) & = chevron.l phi.alt_0 | G_i^dagger H G_j | phi.alt_0 chevron.r = "Tr" \[ G_i^dagger H G_j rho \]\
overline(S)_(i j) & = chevron.l phi.alt_0 | G_i^dagger G_j | phi.alt_0 chevron.r = "Tr" \[ G_i^dagger G_j rho \] $<eqn:expand_matrix>


without needing detailed knowledge of the original state $rho = | phi.alt_0 chevron.r chevron.l$|.


So far both the starting state $| phi.alt_0 chevron.r$ and the expanded state $| psi_(arrow(w)^(*)) chevron.r$ are pure states and thus any errors that we have removed are coherent errors. This is in stark contrast to our focus on incoherent errors in the last section (@sec:pur). The right-hand side of @eqn:expand_matrix is suggestive of the fact that we can apply expansion around some mixed state $rho$ for removing incoherent errors. This is indeed first conjectured in the original works of #cite(<mccleanHybridQuantumclassicalHierarchy2017>, form: "prose") and later confirmed by several experimental implementations of the method~@collessComputationMolecularSpectra2018 @sagastizabalExperimentalErrorMitigation2019 @urbanekChemistryQuantumComputers2020. These observations are put on more solid theoretical footing by #cite(<bonet-monroigLowcostErrorMitigation2018>, form: "prose")@mccleanDecodingQuantumErrors2020. The effective state after performing subspace expansion on a noisy state $rho$ is shown to be#cite(<mccleanDecodingQuantumErrors2020>):


$ rho_(upright("sub")) = frac(Gamma_(arrow(w)) rho Gamma_(arrow(w))^dagger, "Tr" \[ Gamma_(arrow(w)) rho Gamma_(arrow(w))^dagger \]) . $


We see that this is very similar to the symmetry-verified state in @eqn:sym_state with the symmetry projector $Pi$ replaced by the expansion operator $Gamma_(arrow(w))$. This implies that using the symmetry operators as our expansion basis operators, we can recover the symmetry subspace by performing subspace expansion. #cite(<caiQuantumErrorMitigation2021>, form: "prose") try to further generalise this by searching for expanded "states" of the form $Gamma_(arrow(w)) rho / "Tr" [ Gamma_(arrow(w)) rho ]$ instead, which allows us to also incorporate purification-based QEM in @sec:pur under this formalism.


A number of recent works have also looked into other possible sets of expansion basis operators ${ G_k }$. For example, when the operators ${ G_k }$ are chosen to be powers of the Hamiltonian ${ H^k }$, we see that these methods coincide with quantum Krylov subspace methods like qLanczos~@mottaDeterminingEigenstatesThermal2020 or other methods based on filtering the eigenspectrum via functions of the Hamiltonian~@suchslandAlgorithmicErrorMitigation2021. Another recent work that was mentioned before~@yoshiokaGeneralizedQuantumSubspace2022 has included the operators that are powers of the density matrix, making close ties to the purification-based QEM methods. By doing so, optimal combinations of states can now exploit problem-specific knowledge related to purity in addition to general knowledge.


== $N$-representability
<sec:nrep>


Often in the context of quantum simulation (and sometimes more broadly), the goal is ultimately to measure a set of observables corresponding to a marginal of the total density matrix known as a reduced density matrix (RDM). Given a general quantum state $rho$ on $N$ qubits, the set of $p$-qubit RDMs are obtained by integrating out $q$-qubits (such that $N - q = p$) of the joint distribution,


$ ""^p rho_(m_1 , . . . , m_p) = "Tr"_(n_1 , n_2 , . . . , n_q) \[rho\] $


resulting in $binom(n, p)$ different RDMs each of dimension $2^p times 2^p$. The coefficients $n_1 , . . . , n_q$ on the trace operator indicate which qubits are integrated out of $rho$ and coefficients $m_1 , . . . , m_p$ label the subsystem marginal. The result of this marginalization is a distribution over $p$-qubits.


The connection to error-mitigation is that these RDMs are known to have special geometric structures; not all marginals that one can write down are consistent with having come from a valid (or in the parlance of this field, "representable") wave function. In principle there exists a set of conditions that constrain the space of representable RDMs. Articulating and evaluating these equality and inequality constraints is known as the "$N$-representability problem" @mazziottiPureRepresentabilityConditions2016, and the problem is formally QMA-Complete @liuQuantumComputationalComplexity2007. However, for most RDMs of interest, one can write down and evaluate at least some of the $N$-representability conditions. That knowledge can often be used to mitigate errors, in a spirit similar to the application of symmetry constraints, but generally using different methods.


The focus on measuring RDMs is especially common when simulating many-body systems of identical particles. For example, because real fermions interact pairwise, most properties of interest can be obtained using just the 1-particle and 2-particle reduced density matrices (and because the particles are identical, there is only a single 1-RDM and a single 2-RDM). Using the second quantized fermionic creation and annihilation operators acting on site $p$, $a_p^dagger$ and $a_p$, the fermionic 1-RDM and 2-RDM can be expressed as


$ ""^1 D_j^i & = "Tr" \[ a_i^dagger a_j #h(0em)^n D \] = chevron.l psi | a_i^dagger a_j | psi chevron.r\
""^2 D_(r s)^(p q) & = "Tr" \[ a_p^dagger a_q^dagger a_s a_r #h(0em)^n D \] = chevron.l psi | a_p^dagger a_q^dagger a_s a_r | psi chevron.r $


where $zws^k D$ is the $k$-particle RDM and the equalities on the right correspond to the case of pure states. For a system of $N$ sites this 2-RDM is only of dimensions $N^2 times N^2$ (in contrast to $2^N times 2^N$ for the full density matrix), and yet completely determines the energy of a fermionic system with pairwise interactions.


Some of the simpler constraints we can express on the 1- and 2-RDMs are as follows:

+ Hermiticity of the density matrices $ ""^1 D_i^j & = (#h(0em)^1 D_j^i)^(*)\
  ""^2 D_(r s)^(p q) & = (#h(0em)^2 D_(p q)^(r s))^(*) $

+ Antisymmetry of the $2$-particle marginal $""^2 D_(r s)^(p q) = - #h(0em)^2 D_(s r)^(p q) = - #h(0em)^2 D_(r s)^(q p) = #h(0em)^2 D_(s r)^(q p)$

+ The $( p - 1 )$-marginal is related to the $p$-marginal by contraction--e.g. the $2$-marginal can be contracted to the $1$-marginal $""^1 D_j^i = frac(1, n - 1) sum_k #h(0em)^2 D_(j k)^(i k)$

+ The trace of each marginal is fixed by the number of particles in the system $ "Tr" \[ #h(0em)^1 D \] & = n\
  "Tr" \[ #h(0em)^2 D \] & = n ( n - 1 ) $

+ The marginals are proportional to density matrices and are thus positive semidefinite $( zws^1 D , zws^2 D ) succ.curly.eq 0 thin .$

This is not an exhaustive list of all $N$-representability constraints.


The work of #cite(<rubinApplicationFermionicMarginal2018>, form: "prose") first pointed out that knowledge of these constraints could be used for mitigating errors when measuring RDMs. The essential idea is that in the course of a NISQ simulation, one might measure an RDM that violates $N$-representability conditions as a consequence of errors corrupting the estimation of the tomography elements composing the RDM. However, one can use even a partial list of RDM conditions in order to project the noisy and unrepresentable RDM estimate back to the nearest RDM consistent with a list of RDM constraints. Because the RDM constraints all take the form of equality and inequality constraints, this can be performed using semidefinite programming. Such an approach was demonstrated numerically in #cite(<rubinApplicationFermionicMarginal2018>, form: "prose") and experimentally in #cite(<smartEfficientTwoelectronAnsatz2020>, form: "prose").


Of special interest for error-mitigation, there is a subdiscipline of the $N$-representability field known as "pure state $N$-representability" which is concerned with describing the geometry of pure density matrices (i.e. $N$-representability that must hold for pure states). In principle, using pure state representability would potentially allow one to measure the 2-RDM of a partially decohered state and then project that estimate back to the nearest RDM consistent with having come from a pure state. While this idea was first discussed in #cite(<rubinApplicationFermionicMarginal2018>, form: "prose"), it has been difficult to realise in practice since pure $N$-representability conditions are extremely difficult to compute. The state-of-the-art in the field is that specialised computer algebra systems are needed to generate the pure state conditions @klyachkoQuantumMarginalProblem2006 @deprinceVariationalOptimizationTwoelectron2016. Nevertheless, some work has succeeded in using some of these conditions in quantum simulations @smartQuantumclassicalHybridAlgorithm2019.


In the case when the 1-RDM of a fermionic system is expected to be idempotent ($D^2 = D$), a special type of purification known as McWeeny purification~@mcweenyRecentAdvancesDensity1960 is possible. This purification scheme is achieved by iterating on a non-idempotent 1-RDM estimate as


$ zws^1 D_(i + 1) = 3 (zws^1 D_i)^2 - 2 (zws^1 D_i)^3 $


until idempotency is restored. The only fermionic states with idempotent 1-RDMs are Slater determinants, which limits the applicability of this scheme in strongly-correlated systems. Despite the lack of theoretical justification, #cite(<mccaskeyQuantumChemistryBenchmark2019>, form: "prose") demonstrated moderate mitigation success from McWeeny purification in a correlated four-qubit chemistry simulation. The most notable success however, came from the application in #cite(<googlequantumaiandcollaboratorsHartreeFockSuperconductingQubit2020>, form: "prose") to a Hartree-Fock state, for which the idempotency assumption is justified. In this work McWeeny purification demonstrated between one and two orders of magnitude of error suppression, on top of the other mitigation methods used. The hope remains that similar results can be demonstrated in other experiments by enforcing the pure-state representability constraints discussed in the previous paragraph, or by applying purification-based QEM methods discussed in @sec:pur.


== Learning-based
<sec:learning-based>


Given the primary circuit $bold(P)$, its noisy expectation value is denoted as $E ( bold(P) )$ and we are trying to estimate its noiseless expectation value $E_0 ( bold(P) )$. To achieve this, we obtain the error-mitigated expectation value $E_(arrow(theta)) ( bold(P) )$ as a function of the primary circuit and a set of parameters $arrow(theta)$. In previous sections, we see that the function parameters $arrow(theta)$ in different QEM methods are obtained through different noise calibration processes. However, we can also obtain $arrow(theta)$ through #emph[learning-based methods]~@strikisLearningBasedQuantumError2021 @czarnikErrorMitigationClifford2021 using training circuits. We will construct a #emph[training circuit] $bold(T)$ that is

+ similar to $bold(P)$, usually in terms of circuit structures, so that it contains similar circuit faults as $bold(P)$\;

+ classically simulable, i.e. its ideal expectation value $E_0 ( bold(T) )$ can be obtained via classical simulation.

Knowing the exact value of $E_0 ( bold(T) )$ enables us to find a good good set of parameters $arrow(theta)$ for the error mitigation function $E_(arrow(theta))$ by minimising the difference between $E_0 ( bold(T) )$ and $E_(arrow(theta)) ( bold(T) )$. Then we will assume the error mitigation protocol $E_(arrow(theta))$ obtained from the training circuit $bold(T)$ also works well for the primary circuit $bold(P)$ due to their similarity, which give us the error-mitigated result $E_(arrow(theta)) ( bold(P) )$ as an estimate of the ideal result $E_0 ( bold(P) )$. More generally we can have more than one training circuit, which is denoted using the training set $bb(T)$. The simplest loss function we can construct to obtain the optimal $arrow(theta)$ is


$ L_(bb(T)) ( arrow(theta) ) = 1 / lr(|bb(T)|) sum_(bold(T) in bb(T)) ( E_0 ( bold(T) ) - E_(arrow(theta)) ( bold(T) ) )^2 . $<eqn:loss_func>


The whole process of learning-based QEM is summarised in @fig:learning_based. If the error-mitigated estimate $E_(arrow(theta)) ( bold(T) )$ is linear in $arrow(theta)$, which is the case for many QEM schemes, then the optimal $arrow(theta)$ can be obtained using linear least squares.


// [figvision] imgs/LearningBased.png
// This diagram illustrates a workflow for learning-based quantum error mitigation, organized into four main
// stages represented by dashed boxes. The process begins on the left with "Circuits," where a blue box labeled
// "Primary circuit P" is connected via a downward arrow to a red box of "Training circuits T." These training
// circuits are noted as having similar structure to P and being classically simulable. From here, the flow
// splits: the Primary circuit P proceeds horizontally via a blue path, while the Training circuits T branch into
// two paths—one horizontal (red) and one vertical (red). The blue path represents running circuits on noisy
// hardware to obtain "Noisy expectation values E(P)," which feeds into a "Parametrised error-mitigated
// estimates" function f(E(P); θ). Simultaneously, the horizontal red path from training circuits also yields
// noisy values E(T), processed similarly into E_θ(T). A separate vertical red path from training circuits goes
// through "Classical simulation" to produce "Noiseless expectation values E₀(T)." Both the simulated noiseless
// values and the parametrized mitigated estimates feed into a "Loss function" L_T(θ) = 1/|T| Σ(E₀(T) - E_θ(T))².
// This loss drives an "Optimisation" step that outputs "Optimal parameters θ*." Finally, these optimal
// parameters are fed back up to refine the primary circuit's estimate, yielding the final "Optimised
// error-mitigated estimates" in a green box: E[Ô_em] = E_θ*(P) = f(E(P); θ*).
#figure(scope: "parent", image("imgs/LearningBased.png", width: 90.0%),
  caption: [
    A diagram showing the process of learning-based quantum error mitigation. For the cases in which we need to construct variants of the input circuit for the error mitigation function like in @eqn:em_rsp, the whole process is similar, but instead of only running the input circuits on the quantum hardware, we need to run all the different variants of the input circuits.
  ]
)
<fig:learning_based>



The simplest error mitigation function simply rescales and shifts the noisy expectation value to approximate the ideal expectation value:


$ E_0 ( bold(A) ) approx E_(arrow(theta)) ( bold(A) ) = theta_0 + theta_1 E ( bold(A) ) . $<eqn:rescale_and_shift>


Here the input circuit $bold(A)$ can be the primary circuit $bold(P)$ or the training circuits $bold(T) in bb(T)$. #cite(<czarnikErrorMitigationClifford2021>, form: "prose") first proposed to use such a linear function to mitigate errors, whose coefficients can be obtained by training using the Clifford variants of the primary circuit. This has been shown to be effective in experiments~@miInformationScramblingQuantum2021 @urbanekMitigatingDepolarizingNoise2021. When performing fermion simulations, it is also possible to train using the closest free-fermion model as proposed and demonstrated by~#cite(<googlequantumaiandcollaboratorsObservationSeparatedDynamics2020>, form: "prose"), or using fermionic linear optics~@montanaroErrorMitigationTraining2021 as demonstrated experimentally by #cite(<stanisicObservingGroundstateProperties2022>, form: "prose"). In some particular use cases like measuring the out-of-time-order correlator~@miInformationScramblingQuantum2021, by simply removing/replacing a small number of gates of the primary circuit, one can analytically derive the output of the resultant circuits, which can also be used as the training circuits. #cite(<rosenbergExperimentalErrorMitigation2022>, form: "prose") have experimentally compared the different ways to perform such rescaling methods.


The linear error mitigation function in @eqn:rescale_and_shift can naturally arise when we assume all noise sources in the circuit are globally depolarising. In such a case, the resultant noisy state is just a mixture of the ideal state and the completely mixed state: $rho = P_0 rho_0 + ( 1 - P_0 ) I / 2^N$~@vovroshSimpleMitigationGlobal2021 @miInformationScramblingQuantum2021 where $P_0$ is the fault-free probability of the circuit (@sec:circuit_faults). Hence, the ideal expectation value takes the simple form of


$ underbrace("Tr" \[ O rho_0 \], E_0 ( bold(P) )) = 1 / P_0 underbrace("Tr" \[ O rho \], E ( bold(P) )) - frac(1 - P_0, P_02^N) "Tr" \[ O \] , $


which is in the same form as @eqn:rescale_and_shift. The assumption of global depolarising noise motivates the linear error mitigation function, but is #emph[not] a necessary assumption for applying this error mitigation function using training circuits. There is evidence that global depolarising noise is an effective phenomenological error model emerging from gate-wise error models when the gate number is large~@qinErrorStatisticsScalability2023. On the other hand, if indeed there is only global depolarising noise in the circuit, we can actually estimate the rescaling factor $P_0^(- 1)$ using @eqn:no_error_rate if we know the circuit fault rate, or obtain $P_0^(- 1)$ by measuring


$ "Tr" \[ rho^2 \] = P_0^2 + P_0 ( 1 - P_0 ) / 2^(N - 1) + ( 1 - P_0 )^2 / 2^(2 N) $


and solving the quadratic equation~@vovroshSimpleMitigationGlobal2021. Multiple ways to measure $"Tr" \[ rho^2 \]$ have been discussed in purification-based QEM (@sec:pur). These circuits for obtaining $P_0^(- 1)$ do #emph[not] have the same circuit structure as the primary circuit $bold(P)$, so instead of viewing them as the training circuits for applying learning-based rescaling and shifting, it may be more appropriate to view them as the noise calibration circuits for performing probabilistic error cancellation (@sec:pec) against global depolarising channels or for a special case of linear error extrapolation (@sec:zne)~@caiMultiexponentialErrorExtrapolation2021.


In @eqn:rescale_and_shift, $E_(arrow(theta)) ( bold(A) )$ is simply a function of the noisy expectation value $E ( bold(A) )$ of the input circuit $bold(A)$, thus only the input circuit $bold(A)$ needs to be run on the quantum hardware. This is not the case for many of the QEM methods we discussed before. In general for a given input circuit $bold(A)$, we need to construct a set of #emph[response measurement circuits] $( bold(A)_(upright("rsp") , i) )$ that are variants of the input circuit $bold(A)$ by adding/replacing gates and/or adding measurements. These circuits can be, e.g. circuits of different noise levels for zero-noise extrapolation, circuits with different added gates for probabilistic error cancellation and circuits with different added measurements for symmetry verification. The error-mitigated expectation value will be a function of the outputs of all of these response measurement circuits instead of just the input circuit:


$ E_(arrow(theta)) ( bold(A) ) = f ( ( E ( bold(A)_(upright("rsp") , i) ) ) arrow(theta) ) . $<eqn:em_rsp>


One such example would be the error mitigation estimate for probabilistic error cancellation in @eqn:pec_linear_sum:


$ bb(E) \[ hat(O)_"em" \] = sum_(arrow(n)) alpha_(arrow(n)) chevron.l chevron.l O | cal(B)_(arrow(n)) | rho_"in" chevron.r chevron.r mapsto E_(arrow(theta))(bold(A)) = sum_(arrow(n)) theta_(arrow(n)) E(bold(A)_("rsp", arrow(n))) . $


Here the response measurement circuit $bold(A)_(upright("rsp") , arrow(n))$ corresponds to preparing $rho_(upright("in"))$, applying the sequence of operation $cal(B)_(arrow(n))$ and measuring $O$, which as mentioned differs from $bold(A)$ by additions or replacements of some subset of gates. The parameters $theta_(arrow(n))$ can be obtained as $alpha_(arrow(n))$ through device calibration as discussed in @sec:pec. On the other hand, we can also obtain $theta_(arrow(n))$ via learning-based methods~@strikisLearningBasedQuantumError2021. Applying learning-based methods to probabilistic error cancellation implies that we do not have enough information about the gate errors in the primary circuit (otherwise we will apply probabilistic error cancellation directly). Hence, we would need to assume Pauli gate errors in the primary circuit or apply Pauli twirling, such that the set of response measurement circuits can simply be constructed by adding Pauli gates. Other than optimising over $theta_(arrow(n))$ directly, we see that the response circuit coefficient $alpha_(arrow(n))$ is actually the product of the coefficients for individual gates in @sec:pec. In a similar way, we can write $theta_(arrow(n))$ as the product of the coefficients for individual gates and optimise over the gate coefficients instead. This would greatly simplify the optimisation problem if the number of gate types in the circuit is small. By incorporating the appropriate response measurement circuit $bold(A)_(upright("rsp") , arrow(n))$, it is also possible to mitigate spatially and temporally correlated using learning-based methods.


Let us continue to use probabilistic error cancellation with Clifford training~@strikisLearningBasedQuantumError2021 as the example to illustrate how the training circuits can be constructed. In probabilistic error cancellation, we want to remove all faults in the circuit. To find a way to mitigate these faults using the training circuits, the same faults must exist in these training circuits. Such training circuits can be constructed by replacing gates in the primary circuit with gates that have the same error channels. If we compile the primary circuit such that all the multi-qubit gates in the primary circuit are Clifford, we then only need to replace the single-qubit gates to construct Clifford training circuits that are classically simulable. If we further assume that all the single-qubit gates have the same error channel #emph[or] they have negligible error rates compared to the multi-qubit gates, then the fault distribution of these Clifford training circuits will be the same as the primary circuit. We will use $bb(C)$ and $bb(U)$ to denote the set of all possible circuits generated by replacing the single-qubit gates in the primary circuit with random single-qubit Clifford and random single-qubit unitary, respectively (note that $bb(C) subset bb(U)$ and $bold(P) in bb(U)$). By constructing the training circuits in the way outlined above, the training loss function $L_(bb(T)) ( arrow(theta) )$ in @eqn:loss_func is a homogeneous polynomial of degree $2$ in matrix elements of the single-qubit gates in the circuits. Since the Clifford group is a unitary $2$-design, the loss function satisfies $L_(bb(C)) ( arrow(theta) ) = L_(bb(U)) ( arrow(theta) )$~@wangScalableEvaluationQuantumCircuit2021. Therefore, by training over the Clifford circuits and minimising $L_(bb(C)) ( arrow(theta) )$, we are minimising the errors in the more general unitary circuits in $bb(U)$. When $L_(bb(C)) ( arrow(theta) )$ goes to zero, we have $L_(bb(U)) ( arrow(theta) ) = 0$, which implies $E_(arrow(theta)) ( bold(A) ) = E_0 ( bold(A) )$, i.e. all errors are perfectly mitigated, for all $bold(A) in bb(U)$ including the primary circuit $bold(P)$.


Since the size of the Clifford set $bb(C)$ grows exponentially with the number of qubits, it is impractical to evaluate $E_0 ( bold(T) )$ and the corresponding noisy response measurements $( E ( bold(T)_(upright("rsp") , i) ) )$ for all Clifford training circuits $bold(T) in bb(C)$. Furthermore, the majority of noisy Clifford training circuits have near-zero expectation values which are costly to evaluate in terms of sampling overhead. One way to circumvent this is to truncate the Clifford training set by using only circuits with large noiseless expectation values $lr(|E_0 ( bold(T) )|)$ due to their more significant contribution to the loss function, which was shown to be effective in numerical simulations~@strikisLearningBasedQuantumError2021 @czarnikImprovingEfficiencyLearningbased2022. It is also possible to use Monte-Carlo sampling and variational update of the parameters $arrow(theta)$ to overcome the large size of $bb(C)$~@strikisLearningBasedQuantumError2021. Since it is possible to classically simulate circuits with a small number of non-Clifford gates, we can keep a few single-qubit gates in the primary circuit untouched when we define the training set. Alternative ways to truncate the Clifford set may be explored, e.g. based on their similarity to the primary circuits.


If the training set is large enough such that the training can target a wide range of application circuits (computational tasks), then the training can be carried out at the device calibration stage and the training sampling overhead may be omitted when considering a particular computational task. On the other hand, when the training set is small such that the training is targeting a small set of application circuits (computational tasks), then the training is best viewed as a part of a task itself and the training overhead needs to be included in any resource audit for that computational task. Note that a smaller training set usually also means a smaller sampling overhead for training. The relation between the size of the training set $lr(|bb(T)|)$ and the performance of applying the trained result onto the target circuit $bold(P)$ is only rigorously developed for the case of training using the full Clifford set $bb(C)$ for probabilistic error cancellation as discussed above. More general studies into the trade-off between them would be essential for different learning-based methods.


So far we have only explicitly talked about learning-based methods applied to rescaling and shifting the noisy result~(@eqn:rescale_and_shift) and to probabilistic error cancellation. However, learning-based methods are in general compatible with almost all QEM methods that we have discussed, e.g. error extrapolation~@loweUnifiedApproachDatadriven2021 and purification-based method~@bultriniUnifyingBenchmarkingStateoftheart2023. There are also suggestions that it can be applied to symmetry-based methods~@caiQuantumErrorMitigation2021. Some of the possible roles of learning-based methods in other QEM methods will be further discussed in the next section.


= COMPARISONS AND COMBINATIONS
<sec:compare_and_comb>


== Comparison among QEM methods
<sec:qem_compare>
In the last section, we have provided a detailed account of the individual QEM methods. In order to see the connections and differences among them more clearly and provide a discussion of their respective costs in a more coherent framework, #cite(<caiPracticalFrameworkQuantum2021>, form: "prose") divides the process of QEM into two stages:

+ #strong[Noise calibration:] measures the strength of some given noise components;

+ #strong[Response measurement:] measures how the observable of interest responds to changes in the noise components that were calibrated in the last step.

Combining both components will inform us about how the observable of interest changes due to the presence of the calibrated noise components, and thus will enable us to construct an error-mitigated estimator protected from the calibrated noise components. We have already discussed such a structure for QEM methods when introducing the learning-based methods (@sec:learning-based), there the noise calibration process is simply the training process. Of course the division between noise calibration and response measurement is not always clear-cut. For most of the QEM methods that we have discussed, the error-mitigated estimator will be a linear combination of the results obtained from the response measurement, and the way to combine them (the weightings of each term) will be determined by the noise calibration. Treating QEM as a two-stage process enables us to discuss the cost of noise calibration and response measurement separately.


=== Noise calibration overhead
<sec:QEM_two_stage>
In the previous sections when talking about sampling overhead, we are mostly referring to the response measurement sampling overhead. We often assumed certain knowledge about the noise without discussing the cost of obtaining it. Now let us look more closely into the cost of the noise calibration for various types of QEM methods.


==== Gate error mitigation
<gate-error-mitigation>
These QEM methods target the #emph[gate errors] in the primary circuit. Their noise calibration can simply be carried out using standard gate noise benchmarking/characterisation techniques~@klieschTheoryQuantumSystem2021 @eisertQuantumCertificationBenchmarking2020, e.g. gate infidelity estimation for #emph[zero-noise extrapolation] (@sec:zne), full gate error characterisation for #emph[probabilistic error cancellation] (@sec:pec) and detector error characterisation for #emph[measurement error mitigation] (@sec:meas_miti). These can all be done in the device calibration stage and if this is the case, then ideally noise calibration is effectively free at the stage of applying QEM. However, fully correlated noise models are exponentially expensive (in terms of qubit number) to characterise and various ways to circumvent this have been mentioned in @sec:pec,sec:meas_miti. Moreover, device parameters can drift in time and thus routine re-calibration might be needed. In such a case, the noise calibration cost is no longer negligible at the QEM application stage and low-cost device calibration techniques would be essential~ \[see e.g. #cite(<googlequantumaiandcollaboratorsObservationSeparatedDynamics2020>, form: "prose")\].


==== State error mitigation
<state-error-mitigation>
These QEM methods target the #emph[errors on the output state] of the primary circuit. Since we do not know the exact form of the ideal state, we will try to probe errors that violate known constraints on the output state like #emph[symmetry constraints] (@sec:sym) and #emph[purity constraints] (@sec:pur). Their noise calibration will measure the strength of the noise that violates these constraints, e.g. the fraction of the circuit runs that fail the symmetry verification. In these cases, both noise calibration and response measurement involve measuring additional operators on the unmitigated noisy state. Hence, in some settings, the noise calibration can be performed alongside response measurement by simply measuring additional operators without additional circuit runs~@bonet-monroigLowcostErrorMitigation2018 @caiQuantumErrorMitigation2021 @caiPracticalFrameworkQuantum2021, which means the noise calibration is essentially free.


==== Observable error mitigation
<observable-error-mitigation>
Not all errors in the primary circuit will affect our observable of interest, and this class of QEM methods only target the #emph[error components that are damaging to our observable]. Methods like #emph[subspace expansion] (@sec:sub_expand) and #emph[$N$-representability] (@sec:nrep) target error components that violate some given constraints on the noiseless observables (which can be the observable of interest or its components). For observable error mitigation, the noise calibration will be dependent on the observable of interest. Hence, the noise calibration accuracy required is highly dependent on the problems we try to solve and thus the associated cost has not been analytically derived.


As mentioned, #emph[learning-based methods]\(@sec:learning-based) are a means to perform the noise calibration process using training circuits. Compared to the circuits used in the original noise calibration process in different QEM methods, the training circuits are usually more closely related to the primary circuit, so that we can target faults that are more specific to the primary circuit and hopefully can reduce the calibration cost. For example, when trying to construct the training circuit, we can make use of the structure of the primary circuit for gate error mitigation, or we can make use of the known observable of interest for state error mitigation. The training cost for learning-based methods is thus highly problem-specific and usually hard to analytically quantify, just like the cost for noise calibration in observable error mitigation.


The categorisation of QEM methods above is mainly for providing better intuitions rather than a definitive guide. For example, the RDM measured in the $N$-representability method can be viewed as an observable and then the method is seen as a type of observable error mitigation; alternatively it can be viewed as a state in a reduced subspace, so that the method is a form of state error mitigation. After our discussion of the noise calibration requirements above, we can now move onto the more general comparisons between QEM methods beyond the noise calibration stage.


=== Mean square errors
<mean-square-errors>
As discussed in @sec:bias_variance, the most straightforward metric for comparing two different error-mitigated estimators is just to compare their mean square errors (@eqn:mse). However, general comparisons between two QEM methods cannot be made in a similar manner because for each QEM method, there is a wide range of error-mitigated estimators we can construct using different hyper-parameters (e.g. the degree of purification for purification-based QEM, the number of symmetries in symmetry-based QEM, the number of data points in zero-noise extrapolation, etc). Each of these estimators has a different trade-off between bias and variance and thus a different mean square error. Comparisons between two QEM methods are further complicated by their different sets of assumptions (e.g. whether there are known constraints to states, knowledge about the noise) and different hardware requirements (e.g. qubit number and connectivity). Hence, in order to compare two QEM methods, very often we need to know the exact primary circuit whose noise we try to mitigate and the set of experimental constraints we need to adhere to (on things like qubit numbers, runtime and hardware error rate), such that we can specify exact implementations of the two given QEM methods and deduce the corresponding mean square errors. Even in such cases, the bias and variance often can only be calculated analytically for some canonical implementations. Hence, in most of the QEM literature mentioned in this review, when trying to assess or compare the performance of QEM methods, their bias and variance are often obtained using numerical simulations or physical experiments by applying them to some specific use case. This is not a good indicator of the general performance of a given QEM method, but this can usually demonstrate key characteristics of the QEM methods like their target noise types, their scaling behaviour, etc.


While recognising that it is hard to make general comparisons between different QEM methods, nevertheless we endeavour to summarise the costs and performance of some #emph[canonical implementations] of typical QEM methods in @tab:qem_summary. The intention is to capture the essential distinguishing features of these QEM approaches.


== Benchmarking QEM from other perspectives
<sec:qem_other_persp>
Besides computing the mean square error for some specific implementation of a given QEM method, we can also look into other general characteristics of the QEM method by viewing the process of QEM from another perspective.


=== State discrimination
<sec:state_distinct_perf>
QEM allows us to better estimate the expectation values of the various noisy states output from a noisy system. However, the data-processing inequality never allows the distinguishability between these noisy states to increase~@nielsenQuantumComputationQuantum2010. This fact was used by #cite(<takagiFundamentalLimitsQuantum2022>, form: "prose") to obtain explicit bounds on the range that the error-mitigated estimator may take, which in turn determines the number of samples needed to achieve a given level of performance.


Their work considered an error-mitigation protocol in which the first step is obtaining $M$ noisy copies of the error-free state $rho_0$ through a process denoted as $cal(L)$:


$ cal(L) ( rho_0 ) = ⨂_(m = 1)^M cal(E)_m ( rho_0 ) $


where ${ cal(E)_m }$ are the different effective noise channels acting on different copies. The second step is constructing an error-mitigated observable $O_(upright("em"))$ based on the QEM technique and the observable of interest $O$, such that measuring $O_(upright("em"))$ on these noisy copies will output the error-mitigated estimator $hat(O)_(upright("em"))$:


$ upright(E) \[ hat(O)_(upright("em")) \] = "Tr" \[ O_(upright("em")) cal(L) ( rho_0 ) \] . $


The #emph[maximum bias] that can be achieved by the QEM method for all possible observables of interest $O$ and target states $rho_0$ is given as:


$ B_(upright("max")) = max_(O , rho_0) upright("Bias") \[ hat(O)_(upright("em")) \] = max_(O , rho_0) \["Tr" \[ O_(upright("em")) cal(L) ( rho_0 ) \] - "Tr" \[ O rho_0 \]\] . $


Using this, #cite(<takagiFundamentalLimitsQuantum2022>, form: "prose") managed to prove a lower bound for the range of the error-mitigated estimator:


$ upright(R) \[ hat(O)_(upright("em")) \] >= max_(rho_0 , sigma_0) frac(D_(upright("tr")) ( rho_0 , sigma_0 ) - 2 B_(upright("max")), D_(upright("tr")) ( cal(L) ( rho_0 ) , cal(L) ( sigma_0 ) )) $<eqn:samp_cost_trace_dist>


where $D_(upright("tr"))$ denotes the trace distance. The range $upright(R) \[ hat(O)_(upright("em")) \]$ can be used to obtain the #emph[sufficient] number of samples required via @eqn:samp_number_hoeff. Similar scaling relationship of $upright(R) \[ hat(O)_(upright("em")) \]$ for the case of depolarising noise was also proven by #cite(<wangCanErrorMitigation2021>, form: "prose").


Building on the framework above, #cite(<takagiUniversalSamplingLower2023>, form: "prose") have further obtained the explicit lower bound for the #emph[necessary] number of samples $M$ for achieving the target accuracy $delta$ (this deviation includes both the bias and shot noise) with success probability $1 - epsilon.alt$:


$ M >= max_(rho_0 , sigma_0\
D_(upright("tr")) ( rho_0 , sigma_0 ) >= 2 delta) min_(cal(E) in { cal(E)_m }) frac(2 ( 1 - 2 epsilon.alt )^2, ln 2 ~ S ( cal(E) ( rho_0 ) | | cal(E) ( sigma_0 ) )) . $<eqn:sample_lower_bound>


Here $S ( rho | | sigma ) = "Tr" ( rho log rho ) - "Tr" ( rho log sigma )$ is the relative entropy, which is related to the trace distance through the quantum Pinsker's inequality $D_(upright("tr")) ( rho , sigma ) <= sqrt(ln 2 ~ S ( rho | | sigma ) / 2)$~@hiaiSufficiencyKmsCondition2008. It has been shown that the relative entropy of between two output states from noisy circuits under local depolarizing noise decreases exponentially with the circuit depth~@muller-hermesEntropyProductionDoubly2016 @kastoryanoQuantumLogarithmicSobolev2013, which implies that the sampling cost in @eqn:sample_lower_bound will grow exponentially with the circuit depth in this case. Note that by using fidelity instead of relative entropy, a bound tigher than @eqn:sample_lower_bound can also be obtained as discussed in #cite(<takagiUniversalSamplingLower2023>, form: "prose").


#cite(<quekExponentiallyTighterBounds2022>, form: "prose") managed to construct a circuit structure for which the relative entropy of two different output states decreases exponentially in #emph[both circuit depth and the number of qubits], which allows them to prove that the worst-case sampling lower-bound for QEM scale exponentially with the circuit size (instead of just depth), confirming our intuition obtained in earlier sections like @sec:exp_samp_cost. They further showed that for geometrically local circuit, this exponential scaling is determined by the number of gates in the light-cone of observables rather than the circuit size. Note that the bounds obtained in this section are more for the purpose of demonstrating the fundamental limits on the performance of a given QEM setup, rather than to be used as a metric for comparing the practical performance of different QEM methods.


=== Quantum estimation theory
<sec:quantum_estimation_theory>
In estimation theory, the variance of any unbiased estimator can be lower-bounded by the inverse of the Fisher information through the Cramér-Rao inequality. Without loss of generality, we will assume that our goal is to estimate $"Tr" ( O rho_0 )$ for some traceless observable $O$, but the state is suffering from the noise channel $cal(E)$. We can still obtain the ideal expectation value if we have a way to measure the operator $Y = cal(E)^dagger ( O )$ on the noisy state $cal(E) ( rho_0 )$. #cite(<watanabeOptimalMeasurementNoisy2010>, form: "prose") showed that the quantum Fisher information for estimating the observable $O$ using the noisy state $cal(E) ( rho_0 )$ is given by $J_O = ( "Tr" ( cal(E) ( rho_0 ) Y^2 ) - "Tr" ( cal(E) ( rho_0 ) Y )^2 )^(- 1)$. Using the quantum Cramér-Rao inequality, the number of samples $M$ needed for evaluating the noiseless estimator with additive error $epsilon.alt$ can then be bounded as:


$ M >= frac(1, epsilon.alt^2 J_O) . $


Thus, they concluded that the cost-optimal strategy for obtaining the unbiased estimator of $"Tr" ( O rho_0 )$ from the noisy state $cal(E) ( rho_0 )$ is simply to measure $cal(E) ( rho_0 )$ with the observable $Y$.


#cite(<tsubouchiUniversalCostBound2023>, form: "prose") applied these arguments to the NISQ scenario with the estimator being an error-mitigated estimator and obtained two lower bounds on the sampling cost of QEM. Their first lower bound is for generic layered quantum circuits under a wide class of Markovian noise. By showing that the quantum Fisher information decays exponentially with the depth of the layered quantum circuit, they demonstrated the exponential growth of the sampling overhead as the depth of the circuit increases. In the special case of global depolarizing errors, the required number of samples $M$ for achieving an additive error $epsilon.alt$ in the standard deviation can be lower-bounded as $M gt.tilde frac("Tr" ( O^2 ), 2^N epsilon.alt^2) ( 1 - p )^(- 2 L)$, which can be saturated by simply rescaling the measurement result by a factor of $( 1 - p )^(- L)$ (see @sec:learning-based). For random quantum circuits under local noise, they further showed that the sampling cost grows exponentially with both the circuit depth and the number of qubits through both analytical arguments and numerical simulations. The scaling behaviour found here is consistent with @sec:state_distinct_perf.


=== State extraction
<sec:state_extract_perf>
In symmetry-based or purification-based QEM, it is natural to think of QEM as a process of extracting the symmetry-verified or purified state out of the noisy state~@mcardleErrorMitigatedDigitalQuantum2019 @bonet-monroigLowcostErrorMitigation2018 @koczorExponentialErrorSuppression2021 @hugginsVirtualDistillationQuantum2021. More generally in most of the QEM methods, the error-mitigated expectation value $upright(E) \[ hat(O)_(upright("em")) \]$ is a linear function of the observable of interest $O$, which can be written as


$ upright(E) \[ hat(O)_(upright("em")) \] = "Tr" \[ O rho_(upright("em")) \] . $


Here $rho_(upright("em"))$ can be viewed as the error-mitigated component that we try to extract out of the noisy state using the given QEM method~@caiPracticalFrameworkQuantum2021.


A higher fidelity of the error-mitigated state $rho_(upright("em"))$ against the ideal state $rho_0$, denoted as $F ( rho_0 , rho_(upright("em")) )$, is shown to correspond to lower biases in various numerical simulations~@caiQuantumErrorMitigation2021 @koczorExponentialErrorSuppression2021 @hugginsVirtualDistillationQuantum2021. More exactly, using results in #cite(<koczorDominantEigenvectorNoisy2021>, form: "prose") and the Fuchs-van de Graaf inequality~@fuchsCryptographicDistinguishabilityMeasures1999, the bias after error mitigation can be bounded by:


$ upright("Bias") \[ hat(O)_(upright("em")) \] & <= 2 ∥O∥_oo D_(upright("tr")) ( rho_0 , rho_(upright("em")) )\
 & <= 2 ∥O∥_oo sqrt(1 - F ( rho_0 , rho_(upright("em")) )) , $<eqn:bias_fid_bound>


where $∥O∥_oo$ is the largest absolute eigenvalue of $O$.


As discussed in #cite(<caiPracticalFrameworkQuantum2021>, form: "prose"), by assuming the ideal state $rho_0$ to be a #emph[pure] state, we can decompose the noisy state $rho$ into the error-mitigated component $rho_(upright("em"))$ and an erroneous component $rho_(upright("err"))$ (not necessarily a valid density matrix) that is orthogonal to the ideal state $rho_0$ ($"Tr" \[ rho_0 rho_(upright("err")) \] = 0$):


$ rho = p_(upright("em")) rho_(upright("em")) + ( 1 - p_(upright("em")) ) rho_(upright("err")) . $<eqn:noisy_state_decomp>


Here $p_(upright("em"))$ is the amount of error-mitigated component contained in the noisy state. Only a partial amount of this error-mitigated component can be successfully extracted using the given QEM method and this amount is denoted as $q_(upright("em"))$ with $q_(upright("em")) <= p_(upright("em"))$.


In this picture of extracting error-mitigated states, the factor of improvement in the fidelity, which we will call the #emph[fidelity boost], is given by:


$ B_(upright("em")) = frac("Tr" \[ rho_0 rho_(upright("em")) \], "Tr" \[ rho_0 rho \]) = p_(upright("em"))^(- 1) $


\(where $rho_0$ is assumed to be pure) and the corresponding sampling overhead is given as:


$ C_(upright("em")) tilde q_(upright("em"))^(- 2) . $<eqn:cost_extract>


#cite(<caiPracticalFrameworkQuantum2021>, form: "prose") has given a list of examples of how $p_(upright("em"))$ and $q_(upright("em"))$ can be calculated to obtain $B_(upright("em"))$ and $C_(upright("em"))$, with some of the results shown in @tab:qem_summary.


The fraction of the error-mitigated state that is successfully extracted using the QEM method is called the #emph[extraction rate]:


$ r_(upright("em")) = q_(upright("em")) / p_(upright("em")) = B_(upright("em")) / sqrt(C_(upright("em"))) . $


This is simply the ratio between the fidelity boost and the square root of the sampling overhead, and thus is a natural indicator for the #emph[cost-effectiveness] of a given QEM method. Successfully extraction of all of the error-mitigated components contained in the noisy state corresponds to the maximum extraction rate $r_(upright("em")) = 1$, which can be achieved by symmetry verification~@caiPracticalFrameworkQuantum2021, indicating its cost-effectiveness. Note that if we are able to perform direct post-selection instead post-processing to extract the error-mitigated state (like in direct symmetry verification and echo verification), then the sampling overhead will be $C_(upright("em")) tilde q_(upright("em"))^(- 1)$ instead and the extraction rate will be $r_("em") = B_("em") / C_("em")$. Similar to @sec:state_distinct_perf, the arguments in this section also do not apply to QEM techniques that non-linearly combine the results from response measurement.


== Combinations of QEM methods
<combinations-of-qem-methods>
Rather than trying to pick a better QEM method, one might try to combine different QEM methods instead, in the hope of being able to target more noise components and/or achieving a better trade-off between bias and variance. We have mentioned some possible connections and combinations of QEM methods when discussing individual techniques in @sec:methods, and we will try to provide additional insights in this section.


The simplest way of combining different QEM methods is applying them in parallel such that each of them targets a different noise source in the circuit. For example using zero-noise extrapolation or probabilistic error cancellation to target noise in the main computation while using measurement error mitigation to tackle noise at the measurement stage. For a circuit consisting of Pauli-symmetry-preserving components affected by Pauli noise, we can detect and partially mitigate the circuit faults that anti-commute with the symmetry using symmetry verification, while the rest of the circuit faults that commute with the symmetry and thus are immune to symmetry verification can be mitigated using zero-noise extrapolation (through only scaling these 'commuting' noise) or probabilistic error cancellation~@caiMultiexponentialErrorExtrapolation2021. As will be discussed in @sec:algo_error, QEM can be used to mitigate errors in the circuit compilation. Hence, it is possible to use one QEM method to mitigate these compilation errors, while using another QEM method to mitigate noise in the circuit. Note that we can also apply a given QEM method multiple times, each time targetting a different noise source, which has been demonstrated for zero-noise extrapolations~@ottenAccountingErrorsQuantum2019.


When the different QEM methods applied interfere with each other rather than working entirely independently, their order of application becomes important. The QEM method that is first applied will be called the #emph[base QEM method]. In a sense, applying one QEM method on top of another can be viewed as "concatenating" the QEM methods, and the overall sampling overhead is simply the product of the sampling overheads of both stages of QEM. If we want to apply symmetry- or purification-based QEM on top of another QEM method, we can simply view the base QEM method as a process of extracting error-mitigated states out of the noisy state as discussed in @sec:state_extract_perf, and then apply symmetry constraints or purity constraints to this error-mitigated state~@caiPracticalFrameworkQuantum2021. In this way, we are able to remove the remaining symmetry- or purity-violating noise that was not targeted by the base QEM method. In a similar way, for a given error-mitigated state, we can also perform subspace expansion around it or we can measure its RDM, which means that we can directly perform subspace expansion or $N$-representability on top of other QEM methods. #cite(<googlequantumaiandcollaboratorsHartreeFockSuperconductingQubit2020>, form: "prose") has experimentally demonstrated the application of $N$-representability on top of symmetry verification.


One may apply zero-noise extrapolation on top of another QEM method by performing extrapolation using error-mitigated expectation values~@mcardleErrorMitigatedDigitalQuantum2019. However, the error models of the circuit can be altered by the base QEM method, such that the noise scaling factor might not be well-defined anymore. Furthermore, the shape of the extrapolation curves may be altered by the base QEM method. It is possible to circumvent this by using probabilistic error cancellation as the base QEM method since it can be applied partially without changing the error models, yielding data points of reduced noise strength for extrapolation as mentioned before in @sec:zne~@caiMultiexponentialErrorExtrapolation2021. For other base QEM methods, as long as we know the effective noise scaling factor and the circuit fault rate is small after the base QEM, Richardson extrapolation will still be applicable, e.g. it has been applied on top of purification-based methods in numerical simulations~@koczorExponentialErrorSuppression2021 and on top of instances of probabilistic error cancellation that changes the error models~@sunMitigatingRealisticNoise2021. In some specific use cases, the new shape of the extrapolation curve can be analytically deduced, one such example is given in #cite(<caiMultiexponentialErrorExtrapolation2021>, form: "prose") with symmetry verification being the base QEM method. More generally, we can try to use learning-based methods to predict the shape of the extrapolation curves after performing the base QEM, especially for the special case of rescaling and shifting the noisy expectation value (see @sec:learning-based). Applying rescaling on top of symmetry verification has been demonstrated in numerical simulations~@stanisicObservingGroundstateProperties2022 and experiments~@googlequantumaiandcollaboratorsObservationSeparatedDynamics2020. As mentioned in @sec:learning-based, rescaling and shifting can be viewed as performing probabilistic error cancellation for mitigating global depolarising noise. However, probabilistic error cancellation in a more general context is difficult to perform on top of other QEM methods because the effective error model in the circuit will change due to the base QEM method.


Learning-based methods can be viewed as a way to perform the noise calibration process rather than a stand-alone QEM method as mentioned in @sec:QEM_two_stage. Hence, it can be easily combined with the other methods by replacing their noise calibration process~@loweUnifiedApproachDatadriven2021 @caiPracticalFrameworkQuantum2021, which we have mentioned above in several examples. We can also use learning-based methods to obtain the optimal hyper-parameters for various QEM methods~@bultriniUnifyingBenchmarkingStateoftheart2023.


There were also attempts to construct a unified framework containing hyper-parameters that can lead to different existing QEM methods when taking different values. Such frameworks give us access to a wide range of other possible QEM implementations by taking hyper-parameter values sitting in between existing QEM methods. We can think of this as "interpolating" between different QEM methods instead of "concatenating" different QEM methods. These new "interpolated" QEM implementations can achieve different bias-variance trade-offs beyond the existing QEM methods and often also target a different set of noise components. This allows us to choose the best implementation that fits our target problem and experimental constraints rather than being restricted to the existing QEM methods. We have mentioned some of these examples in the previous section (@sec:methods), e.g. the combination of purification-based methods with subspace expansion~@yoshiokaGeneralizedQuantumSubspace2022, the generalisation of symmetry verification and subspace expansion~@caiQuantumErrorMitigation2021 or the combination of zero-noise extrapolation and probabilistic error cancellation~@mariExtendingQuantumProbabilistic2021. Some QEM combinations mentioned earlier in this section can also be viewed as attempts to construct a unified framework~@loweUnifiedApproachDatadriven2021 @bultriniUnifyingBenchmarkingStateoftheart2023. Note that many QEM methods can also be natively combined with shadow tomography~@jnaneQuantumErrorMitigated2023, which may provide performance advantages when we want to estimate a large number of observables.


== Comparison to the other error suppression methods
<sec:comp_qem_qec>
Quantum error mitigation is one family of strategies for suppressing errors. It is natural to consider how it relates to other well-known error-suppression methods, such as decoherence-free subspace/subsystem (DFS), dynamical decoupling (DD) and quantum error correction (QEC). Symmetry is at the heart of all the methods mentioned here, thus we will first try to compare QEC against symmetry verification to gain some intuition.


In QEC, we perform regular symmetry (stabiliser) measurements to detect and correct errors accumulated in the quantum system. If we discard the quantum states that violate these symmetry checks instead of correcting them, we will have quantum error detection instead. Symmetry verification (@sec:sym) can usually be seen as an error-#emph[detection] scheme whose symmetries are given by the physical problem of interest and the detection can be carried out via post-processing. Such native symmetries and the possible use of post-processing detection typically mean that much fewer qubits and a much lower gate fidelity are required for symmetry verification compared to QEC to achieve the "break-even" point of performing better than the uncorrected/unmitigated circuit. Furthermore, performing logical operations in QEC code usually come with higher space-time overhead than the physical operations performed in QEM, leading to longer circuit run time and even more qubit overhead for QEC.


Even though we are talking about symmetry verification in the above comparison, many of the intuitions provided are applicable to general QEM methods. As mentioned in @sec:intro, general QEM methods aim to correct the output #emph[distribution] in an #emph[ensemble] of circuit runs, while QEC aims to correct the output in every single circuit run. If we are trying to remove (almost) all bias like in fault-tolerant QEC, the sampling overhead of general QEM will grow #emph[exponentially] with the circuit size as discussed in @sec:exp_samp_cost. Using all the arguments above, we can compile a rough guide for the differences between QEC and QEM as outlined in @tab:qec_and_qem. Note that there are intersections between QEC and symmetry-based QEM like post-processing quantum error detection and adding more symmetries to QEM (at the cost of adding more qubits) as discussed in @sec:sym. Adding onto what we have discussed, #cite(<caoNISQErrorCorrection2022>, form: "prose") also looked at the difference between QEM and QEC in the setting of communication instead of computation.

// ---- tab:qec_and_qem ----
#figure(
  align(center)[
    #text(size: 9pt)[#table(
      columns: (8em, 1fr, 1fr),
      align: (left, left, left),
      stroke: none,
      inset: (x: 4pt, y: 3pt),
      table.hline(stroke: 1pt),
      [], [*QEC*], [*QEM*],
      table.hline(stroke: 0.5pt),
      [Qubit overhead], [High], [Low],
      [Circuit runtime], [Often scale with code distance], [Similar to the unmitigated circuit],
      [Sampling overhead], [Const.], [Exponential in the circuit size #super[1]],
      [Error rate], [Must be below code threshold], [Important to keep it low; no threshold #super[2]],
      [Mid-circuit measurement], [Essential and frequent], [Infrequent or not required],
      table.hline(stroke: 1pt),
    )]
    #v(3pt)
    #text(size: 8pt)[#super[1] Assuming we try to construct an (nearly) unbiased estimator like in QEC and with fixed gate error rates. #super[2] Lower error rate means smaller sampling overheads. No threshold for the gate noise in the unmitigated circuit, but there might be requirements on the additional gates needed for QEM.]
  ],
  caption: [A rough guide on the differences between QEC and QEM. The exact difference will be dependent on the QEC codes, the QEM method and the exact application scenario.],
  kind: table,
  scope: "parent",
  placement: top,
) <tab:qec_and_qem>






Without knowing the specific application task, it will be difficult to compare the amount of resources required for QEC and QEM. There have been attempts to estimate the resource required to obtain #emph[classically intractable] Fermi-Hubbard ground state energy using variational eigensolver (VQE) with the help of symmetry verification and error extrapolation~@caiResourceEstimationQuantum2020. To overcome the sampling overhead, which is partly due to QEM, it was estimated that more than $100$ independent quantum processors are needed for parallelisation, each containing $50$ qubits and with a gate error rate of $10^(- 4)$. The gate fidelity and the total number of qubits required here are actually similar to those required for solving the problem using a fault-tolerant algorithm~@kivlichanImprovedFaultTolerantQuantum2020. However, given the same total number of qubits, building hundreds of identical quantum processors (cores) using commercial fabrication techniques is usually easier than building the single big integrated processor required for the fault-tolerant algorithm. Note that what we have discussed here is not a sheer comparison between QEC and QEM, but more of a comparison between a NISQ algorithm with the help of QEM and a fault-tolerant algorithm for a specific application.


In practice, QEC and QEM are more likely to be complementary rather than competing methods since in many practical applications we can apply QEM on top of QEC as will be further discussed in @sec:fault_tol_error. It is also possible to use QEM to mitigate compilation errors, which is not possible using QEC as will be discussed in @sec:algo_error.


Unlike QEC and QEM, both dynamical decoupling (DD) and decoherence-free subspace/subsystem (DFS) methods are #emph[open-loop] quantum control techniques whose action does not depend on the status of the quantum state and thus no measurements are needed for their implementation~@lidarReviewDecoherenceFreeSubspaces2014 @suterColloquiumProtectingQuantum2016. In fact, DFS is a passive technique that requires no action at all, we only need to choose the right symmetry subspace that is immune to the target set of noise. QEC and symmetry-based QEM all have some element of DFS in them in the sense that they are all immune to noise generated by the symmetry operators. DD on the other hand is achieved by applying a sequence of decoupling pulses to "average" out the harmful interaction between the quantum system and the environment. In the limit of many rounds of instantaneous decoupling pulse, group-based DD is shown to be equivalent to making continuous symmetry measurements to achieve the quantum Zeno effect~@facchiUnificationDynamicalDecoupling2004 @burgarthGeneralizedProductFormulas2019. Such a DD sequence can be applied using the native symmetry of the physical problem just like in symmetry-based QEM, which is shown to be effective in quantum simulation~@tranFasterDigitalQuantum2021.


= APPLICATIONS
<sec:applications>


So far we have discussed QEM mostly in the general context of expectation value estimation without over-specifying the application scenarios. There are a range of software packages for carrying out the various QEM techniques that we have mentioned. For example, Qermit, Mitiq and Qiskit each provide their own implementation of zero-noise extrapolation, probabilistic error cancellation and measurement error mitigation~@laroseMitiqSoftwarePackage2021 @cirstoiuVolumetricBenchmarkingError2023 @qiskitcontributorsQiskitOpensourceFramework2023. In additional, Qermit and Mitiq also contain the Clifford variants of the learning-based method. There are also a wide range of other packages providing measurement error mitigation like qCompute, Pennylane, QREM, etc~@baiduQCompute2023 @bergholmPennyLaneAutomaticDifferentiation2018 @maciejewskiQuantumReadoutErrors2020.


Through numerical experiments, QEM has been proven to be effective in a wide range of applications like linear equation solvers~@vazquezEnhancingQuantumLinear2022, quantum metrology~@yamamotoErrormitigatedQuantumMetrology2022 @conlonApproachingOptimalEntangling2023, Monte-carlo simulations~@yangAcceleratedQuantumMonte2021 and in numerous other examples that we mentioned before in @sec:methods. Moreover, many physical experiments have successfully employed QEM for noise suppression, with some pioneering and state-of-the-art examples summarised in @tab:application_examples, spanning across different applications scenarios like Fermi-Hubbard models~@stanisicObservingGroundstateProperties2022 and multi-particle bound states~@googlequantumaiandcollaboratorsFormationRobustBound2022, with a circuit size up to 127 qubits and 60 layers of 2-qubit gates~@kimEvidenceUtilityQuantum2023. Different application scenarios and hardware platforms will give rise to different types of noise. In this section, we will look into how to adapt the implementation of QEM to different noise types and the expected results.


#figure(
  align(center)[
    #text(size: 8pt)[#table(
      columns: (7fr, 3fr, 23fr, 12fr),
      align: left,
      stroke: (x: none, y: 0.4pt),
      inset: (x: 3pt, y: 2pt),
      table.header([QEM Methods], [Platform], [Applications], [Reference]),
      [ZNE], [SC], [Variational eigensolver], [Kandala et al. @kandalaErrorMitigationExtends2019, Dumitrescu et al. @dumitrescuCloudQuantumComputing2018],
      [ZNE], [SC], [Real-time dynamic simulation], [Kim et al. @kimScalableErrorMitigation2023, @kimEvidenceUtilityQuantum2023],
      [ZNE], [Ion], [Entanglement entropy measurement], [Foss-Feig et al. @foss-feigEntanglementTensorNetworks2022],
      [PEC], [SC], [Deterministic quantum computation with pure states], [Song et al. @songQuantumComputationUniversal2019],
      [PEC], [SC], [Real-time dynamic simulation], [van den Berg et al. @vandenbergProbabilisticErrorCancellation2023],
      [PEC], [Ion], [Gate fidelity estimation], [Zhang et al. @zhangErrormitigatedQuantumGates2020],
      [PEC], [Ion], [Real-time dynamic simulation], [Chen et al. @chenErrorMitigatedQuantumSimulation2023],
      [SYM], [SC], [Variational eigensolver], [Sagastizabal et al. @sagastizabalExperimentalErrorMitigation2019],
      [SYM], [Ion], [Variational state preparation], [Zhu et al. @zhuGenerationThermofieldDouble2020],
      [PUR], [SC], [Variational eigensolver], [O'Brien et al. @obrienPurificationbasedQuantumError2023],
      [SUB], [SC], [Variational eigensolver], [Colless et al. @collessComputationMolecularSpectra2018],
      [LEA], [SC], [Variational eigensolver], [Dborin et al. @dborinSimulatingGroundstateDynamical2022],
      [LEA], [SC], [Quantum information scrambling], [Mi et al. @miInformationScramblingQuantum2021],
      [SYM & NRP], [SC], [Variational state preparation], [Google Quantum AI and @googlequantumaiandcollaboratorsHartreeFockSuperconductingQubit2020],
      [SYM & LEA], [SC], [Variational eigensolver], [Stanisic et al. @stanisicObservingGroundstateProperties2022],
      [SYM & LEA], [SC], [Real-time dynamic simulation], [Google Quantum AI and @googlequantumaiandcollaboratorsObservationSeparatedDynamics2020],
    )]
    #v(4pt)
    #text(size: 8pt)[SC, Ion: superconducting qubits and trapped-ion qubits. \
      ZNE, PEC, SYM, PUR, SUB, NRP, LEA: zero-noise extrapolation, probabilistic error cancellation, symmetry constraints, purity constraints, subspace expansion, $N$-representability and learning-based methods. Note that measurement error mitigation is present in almost all experimental works and thus is not explicitly included here.]
  ],
  caption: [A list of examples of pioneering and state-of-the-art experimental applications of QEM.],
  kind: table,
  scope: "parent",
  placement: top,
) <tab:application_examples>


== Coherent errors
<sec:coherent_noise>
The degree of coherence in an error channel can be quantified by how well it preserves the purity of an average incoming state~@wallmanEstimatingCoherenceNoise2015. In this sense, the "most coherent" errors are just unitary errors, while incoherent errors usually refer to stochastic Pauli channels. More generally, the term #emph[coherent errors] refers to a broad spectrum of noise that sits closer to the unitary errors than the Pauli errors. There are cases in which coherent errors can be mitigated using coherent control solutions like dynamical decoupling~@lidarReviewDecoherenceFreeSubspaces2014 @suterColloquiumProtectingQuantum2016. The remnant coherent errors can be mitigated using most of the QEM techniques mentioned before (with the exception of purity-based methods). In fact, subspace expansion (@sec:sub_expand) was originally constructed to target coherent errors~@mccleanHybridQuantumclassicalHierarchy2017. However for many other QEM methods, Pauli errors can be far easier to mitigate compared to coherent errors as discussed in the previous sections. The advantages of mitigating Pauli noise are summarised below:

- Zero-noise extrapolation: arguments can be made that the expectation value of Pauli observable should decay following a multi-exponential curve under Pauli noise. Knowing the form of the extrapolation curve can lead to lower sampling costs and smaller biases.

- Probabilistic error cancellation: Pauli noise requires less overhead to be characterised and removed using the standard basis, similarly for measurement error mitigation.

- Symmetry constraints: when dealing with symmetry-preserving circuit components and Pauli symmetry, analytical arguments can be made about the proportion of noise removed when considering Pauli noise. This also enables us to select a good set of symmetries to use.

- Purity constraints: errors that are less coherent can improve the ultimate accuracy that can be reached using purity constraints.

- Learning-based: standardising error channels by transforming them into Pauli noises will result in a more similar error model between the training circuits and target circuits. The effects of Pauli noise on the observable are usually easier to be characterised and thus require less training.

Even for subspace expansion, though Pauli errors might not be easier to mitigate, they are certainly easier to analyse and thus enable us to select a better set of expansion operators. Furthermore, coherent errors usually accumulate at a faster rate than their Pauli counterpart~@sandersBoundingQuantumGate2015 @gutierrezComparisonQuantumErrorcorrection2015 @kuengComparingExperimentsFaultTolerance2016. Hence, #emph[one of the most effective ways to deal with coherent errors in the context of QEM is simply transforming them into Pauli errors.]


Any arbitrary quantum channel can be transformed into a Pauli channel using #emph[Pauli twirling], which originated from entanglement purification~@bennettPurificationNoisyEntanglement1996 @bennettMixedstateEntanglementQuantum1996 @knillFaultTolerantPostselectedQuantum2004 and is widely used in areas like quantum benchmarking~@klieschTheoryQuantumSystem2021 for transforming quantum states or noise channels into a standardised form. When applying Pauli twirling to environmental noise or noise from Clifford gates, we simply insert random Pauli gates during the circuit compilation (as discussed in @sec:twirling). Most of these random Pauli gates can in fact be absorbed into the existing Pauli gates~@wallmanNoiseTailoringScalable2016 and thus it can often be implemented with a relatively small gate cost.


It is also possible to twirl over the Clifford group, which will further homogenise the probability of different Pauli errors, resulting in a depolarising channel, which is even easier to analyse and mitigate. However, Clifford gates, especially multi-qubit ones, can be much harder to implement than Pauli gates.


== Logical errors in fault-tolerant quantum computation
<sec:fault_tol_error>
The ultimate goal of quantum computation is to have a fully scalable fault-tolerant quantum system in which we can suppress the logical errors to an arbitrary small level by increasing the size of the system. However, before we achieve that, it is likely that there will be an extended period of time in which quantum error correction is successfully implemented, but the minimum logical error rate achievable is still substantial due to reasons like hardware limitations in the system size, challenges in large-scale decoding, and/or insufficient resources for magic state distillation. In this 'early fault-tolerant' era, many tasks of interest requiring an effectively zero error rate will be impossible to perform. #emph[As long as the results of the fault-tolerant algorithm are obtained through expectation value estimation, the residual logical errors can be mitigated using all of the QEM methods mentioned before]. We can follow the exact same arguments outlined in the previous sections and simply replace the qubit registers, the operations and the error channels with their logical equivalents.


In particular, the role of probabilistic error cancellation in the Clifford$+ T$ paradigm of universal fault-tolerant quantum computation was studied extensively in several works~@suzukiQuantumErrorMitigation2022 @piveteauErrorMitigationUniversal2021 @lostaglioErrorMitigationQuantumAssisted2021. The logical noise associated with Clifford gates can be transformed into logical Pauli channels using Pauli twirling by inserting random Pauli gates as mentioned in @sec:coherent_noise. To mitigate the resultant logical Pauli noise using probabilistic error cancellation, we only need to insert Pauli gates into the unmitigated circuit. These additional logical Pauli gates required for error mitigation can be applied virtually and noiselessly through updating the Pauli frame~@suzukiQuantumErrorMitigation2022, boosting the effectiveness of probabilistic error cancellation in the fault-tolerant setting. The errors in the noisy logical $T$ gate can be mitigated in a similar way, but to twirl them we need to apply additional logical Clifford gates instead of just Pauli gates (see @sec:twirling). #cite(<suzukiQuantumErrorMitigation2022>, form: "prose") show that to achieve a logical circuit fault rate of $10^(- 3)$ with a sampling overhead of $100$, probabilistic error cancellation can reduce the physical qubit overhead by $80 "%"$ for some classically intractable problems and more than $45 "%"$ in many practical fault-tolerant applications.


The magic state distillation process needed for implementing fault-tolerant $T$ gates accounts for significant costs in fault-tolerant computation even with recent advances~@ogormanQuantumComputationRealistic2017 @litinskiMagicStateDistillation2019. Therefore, it makes sense to study the details of error mitigation for imperfect logical $T$ gates. #cite(<piveteauErrorMitigationUniversal2021>, form: "prose") consider logical $T$ gates implemented through either gate teleportation or code switching, and found that it is sufficient to consider the effective logical error as a dephasing channel (with the help of logical twirling), which is much easier to characterise and mitigate using probabilistic error cancellation. Assuming perfect Clifford gates, they showed that one can use probabilistic error cancellation to remove errors in a circuit that has $2000 T$ gates and a physical error rate of $10^(- 3)$ at a sampling overhead of $1000$. This is well beyond the classically tractable regime of $tilde 50 T$ gates~@bravyiImprovedClassicalSimulation2016. #cite(<lostaglioErrorMitigationQuantumAssisted2021>, form: "prose") also discuss applying QEM to noisy logical $T$ gates but with more emphasis on the resource theoretic aspect. There a resource measure called quantum-assisted robustness of magic is introduced, which indicates the speed up of quantum circuit simulation with noisy non-Clifford gates using probabilistic error cancellation.


Besides gate errors, there will also be compilation errors when we try to approximate an arbitrary unitary gate using the Clifford$+ T$ gate set. The form of the resultant compilation errors can be analytically computed for local gates, which can then be mitigated using probabilistic error cancellation~@suzukiQuantumErrorMitigation2022. The resultant compilation error will decrease exponentially with the increase of the number of $T$ gates used~@kitaevQuantumComputationsAlgorithms1997 @dawsonSolovayKitaevAlgorithm2006 @kliuchnikovAsymptoticallyOptimalApproximation2013 @rossOptimalAncillafreeClifford2016. Hence, there is a trade-off between the number of $T$ gates used and the cost of the QEM we need to apply. We will discuss more instances of compilation errors beyond the context of gate synthesis in the next section.


== Algorithmic (compilation) errors
<sec:algo_error>
To execute a unitary operation, we need to first compile it into a sequence of gates that the quantum computer can efficiently execute. The compiled circuit does not always exactly represent the target unitary (often due to a limited circuit depth), and any resultant mismatches will be called #emph[compilation errors]. This will lead to errors in the output expectation value that we will call #emph[algorithmic errors]. We have discussed one instance of compilation errors in the context of gate synthesis in @sec:fault_tol_error. In applications like variational eigensolver, the target unitary is represented using some parametrised ansatz circuit, which can lead to algorithmic errors due to wrong values of parameters or limited representation power of ansatz circuits. Algorithmic errors will be present even if all gates can be executed perfectly without any noise, and thus they #emph[cannot] be removed through QEC. On the other hand, algorithmic errors can be removed through some of the QEM techniques that we have mentioned and this is one of the areas where QEM is non-trivially different from QEC.


#cite(<endoMitigatingAlgorithmicErrors2019>, form: "prose") made the first attempt to mitigate such algorithmic errors via zero-noise extrapolation, which essentially operates in the same way as what we described in @sec:zne, but with algorithmic errors in place of physical errors. For a given application, there will be different ways to compile the target unitary using different circuit structures (e.g. different circuit depths) or different circuit parameters, which will output data points with different algorithmic errors. If we know the relative scaling of the algorithmic errors between these data points, we can then apply zero-noise extrapolation on them to remove the algorithmic errors.


#cite(<endoMitigatingAlgorithmicErrors2019>, form: "prose") looked at the specific problem of Hamiltonian simulation using Trotterisation~@suzukiFractalDecompositionExponential1990 @suzukiGeneralTheoryFractal1991. Higher-order Trotterisation will have fewer algorithmic errors but deeper circuits. Balancing these two aspects means there is an optimal order of Trotterisation in a given practical setting. Data points of different algorithmic errors can be obtained using different orders of Trotterisation up to the optimal order, using which we can apply Richardson extrapolation to estimate the result of infinite-order Trotterisation with zero algorithmic errors. Zero-noise extrapolation can also be used to mitigate algorithmic errors in energy minimisation algorithms (quantum optimisation algorithms) like quantum annealing and variational eigensolver by extrapolating to the infinite-annealing-time limit or the zero-energy-variance limit~@caoMitigatingAlgorithmicErrors2022.


Mitigating algorithmic errors is even more natural for QEM methods that are based on the known constraints of the ideal state or the ideal observables since algorithmic errors can also violate these constraints just like gate errors. One such example was discussed by #cite(<hugginsVirtualDistillationQuantum2021>, form: "prose"). There they look at the randomised Trotterisation~@childsFasterQuantumSimulation2019 @campbellRandomCompilerFast2019 @ouyangCompilationStochasticHamiltonian2020 in which the compiled circuit is inherently probabilistic while the ideal state is known to be pure. Hence, it is natural to apply purification-based QEM here to remove the stochastic errors due to the randomised compilation process. Another example is subspace expansion applied in the context of variational eigensolver~@mccleanHybridQuantumclassicalHierarchy2017 to overcome the limited representation power of the ansatz circuit.


= OPEN PROBLEMS
<sec:open_prob>
== Overarching problems
<overarching-problems>
Having thus surveyed the diverse concepts, implementations and applications of QEM in the previous sections, it is appropriate to now reflect on the key unanswered questions in the field. We identify several such questions below.

+ What is the full landscape of the zoo of QEM? In @sec:methods, we have discussed a set of QEM methods and their variants, which are grouped into three categories in @sec:QEM_two_stage. However, this is by no means the full landscape of QEM. Are there better classifications of the different QEM methods? Moreover, are there new methods waiting to be discovered?

+ What are some good performance metrics for QEM? In @sec:bias_variance, we identify the bias and variance of the error-mitigated estimator as its key performance metrics and in @sec:compare_and_comb, we further define some performance metrics by viewing QEM from other perspectives. However, these metrics are greatly dependent on the exact problem we try to solve and many of them can only be obtained analytically for some canonical cases. Are there other performance metrics for QEM that can better reflect their practical performance and/or can be analytically calculated for a wider range of methods? Can these metrics take into account the various additional information/resources required by different QEM methods? Instead of performance metrics, should we identify a set of well-defined use cases which can then be used to benchmark QEM methods through numerics or experiments, much like the MNIST or ImageNet database in computer vision research?

+ What is the optimal QEM strategy for some practical use case? This is a natural question that follows from the first two. After we have a full view of all possible QEM methods out there and good performance metrics for their practical performance, we can then identify the optimal QEM strategy for some practical use cases. This is most likely to be a hybrid of different QEM methods.

+ What is the connection between QEM and QEC? We have attempted to connect QEM to QEC in @sec:comp_qem_qec. There, most of the connection is made specifically for symmetry-based QEM. It would be interesting to see a more systemic approach to connect general QEM methods to QEC, or even to merge them under a larger common framework of error suppression. For this to happen, of course we would need a good description of the framework for QEM first, which is the first question we presented above.

+ Can we extend QEM beyond expectation value estimation? While expectation value estimation is at the heart of many useful algorithms to date, there are still many algorithms fall outside this paradigm, e.g. a repeat-until-success algorithm like Shor's algorithm, or algorithms that output a single-shot measurement, such as quantum phase estimation using the quantum Fourier transform. Can we identify an equivalent of QEM for these algorithms and usefully apply concepts such as those described in the present review? For example, it should be possible to improve single-shot algorithms via post-selection, in the same spirit of quantum error detection.


== Technical questions
<technical-questions>
There are also many other more technical questions about the implementations and applications of different QEM techniques, many of which we have mentioned in this review when talking about the individual techniques. We will further list some example questions here.


+ Are there general protocols to scale the noise without changing the error model? If yes, can we deduce the shape of the extrapolation curve from the error model? (@sec:zne)

+ How can we efficiently handle drifts in the error model when applying probabilistic error cancellation in practice? (@sec:pec)

+ What is the training cost for learning-based QEM? (@sec:learning-based)

+ Various quantum computing hardware architectures have been realised, at least at the prototype level, with differing connectivities and native gate sets. What is the interplay between the hardware feature set and the suitable choices of QEM strategy?


= CONCLUSION
<sec:concl>
In this review, we have provided a comprehensive survey of QEM which has ranged from the basic concepts and motivations, through to the implementation details of specific techniques. Due to the low hardware requirements of QEM compared to QEC, as well as the broad range of mitigation techniques available to target diverse application scenarios, QEM has already become an integral part of many recent experimental demonstrations of quantum hardware. Even though we cannot rely on QEM alone to suppress #emph[all] errors in all cases, especially when the circuit fault rate is large, we can always aim for a sweet spot between the amount of noise removed and the resource required. Consequently we can expect that QEM techniques will continue to establish themselves as indispensable enablers, vital to maximising the reach of each generation of hardware. We anticipate that this will remain true even into the fault-tolerant era, since recent works have shown that it is possible to reduce the hardware requirements of fault-tolerance by applying QEM alongside QEC. Indeed there are applications of QEM concepts entirely beyond handling physical device imperfections and instead mitigating compilation (algorithmic) imperfections, i.e. honing the performance of algorithms which of necessity produce only approximate answers.


Despite already playing a significant role in practical applications, the current landscape of QEM is still dynamic and complex, with many unexplored territories. While we have made every effort to present the rather tangled threads of this topic in a clear way in this review, it is evident that a more systematic and unified structure for QEM is desirable as the field matures further. There are still many open problems left unanswered as summarised in @sec:open_prob. Solving these problems may be the key to a clearer and more structured view of QEM and its role in the grand scheme of error suppression. We hope that the community of theoretical and experimental researchers who will drive the field forwards, may find that the survey of ideas and methods presented in this review provides useful guidance along the way.


#block[
We thank Kristan Temme, Abhinav Kandala, and Jay Gambetta for their valuable insights and useful discussions. ZC and SE are grateful to Bálint Koczor, Ryuji Takagi, and Nobuyuki Yoshioka for helpful discussions. SE is also grateful for useful discussions with Yasunari Suzuki, Kento Tsubouchi, and Raam Uzdin. RB thanks Nicholas Rubin for helpful discussions about pure state $N$-representability. ZC is supported by the Junior Research Fellowship from St John's College, Oxford. SCB acknowledges financial support from EPSRC Hub grants under agreement No. EP/T001062/1, and from the IARPA funded LogiQ project. ZC and SCB also acknowledge support from EPSRC's Robust and Reliable Quantum Computing (RoaRQ) project (EP/W032635/1). SE is supported by Moonshot R&D, JST, Grant No. JPMJMS2061; MEXT Q-LEAP Grant No. JPMXS0120319794, and PRESTO, JST, Grant No.  JPMJPR2114. YL acknowledges the support of the National Natural Science Foundation of China (Grants No. 11875050 and No. 12088101) and NSAF (Grant No. U1930403).

]


#heading(level: 1, numbering: none)[List of Symbols]
<list-of-symbols>





#figure(
  align(center)[#table(
    stroke: none,
    columns: 2,
    align: (left,left,),
    table.hline(stroke: 0.8pt),
    [$C_(upright("em"))$], [error mitigation sampling overhead],
    table.hline(stroke: 0.5pt),
    [$N$], [number of qubits],
    [$N_(upright("cir"))$], [number of circuit runs],
    [$O$], [observable of interest],
    [$hat(O)_(upright("em"))$], [error-mitigated estimator],
    [$hat(O)_rho$], [random variable from measuring $O$ on state $rho$],
    [$p$], [physical gate error rate],
    [$P_0$], [circuit fault-free probability],
    [$lambda$], [circuit fault rate, the average number of faults per circuit run],
    [$rho$], [unmitigated noisy state],
    [$rho_0$], [ideal noiseless state],
    table.hline(stroke: 0.8pt),
  )]
  , kind: table
  )









= PRACTICAL TECHNIQUES IN IMPLEMENTATIONS
<sec:prac_tech>


== Monte carlo sampling
<sec:monte_carlo_sampling>
In many QEM techniques, very often the error-mitigated expectation value $upright(E) \[ hat(O)_(upright("em")) \]$ is a linear sum of the expectation values of a set of $K$ random variables ${ hat(O)_n }$ (that are the outputs of the set of response measurement circuits for the QEM technique):


$ upright(E) \[ hat(O)_(upright("em")) \] = sum_(n = 1)^K alpha_n upright(E) \[ hat(O)_n \] , $<eqn:em_est_decomp>


where ${ alpha_n }$ are real coefficients. A naive way for estimating $upright(E) \[ hat(O)_(upright("em")) \]$ would be performing estimation for the individual terms $upright(E) \[ hat(O)_n \]$ up to a certain precision, then combine the results. In such a way, the variance of the error-mitigated estimator $hat(O)_(upright("em"))$ is given as:


$ upright("Var") \[ hat(O)_(upright("em")) \] = sum_(n = 1)^K lr(|alpha_n|)^2 upright("Var") \[ hat(O)_n \] , $


The component random variables $hat(O)_n$, being generated from circuits that are variants of the primary circuit, can be expected to have a similar variance as the unmitigated estimator $hat(O)_rho$ generated from the noisy primary circuit: $upright("Var") \[ hat(O)_n \] tilde upright("Var") \[ hat(O)_rho \]$. Hence, we have:


$ upright("Var") \[ hat(O)_(upright("em")) \] = (sum_(n = 1)^K lr(|alpha_n|)^2) upright("Var") \[ hat(O)_rho \] , $


Therefore, each component observable $hat(O)_n$ is associated with a sampling overhead of $sum_(n = 1)^K lr(|alpha_n|)^2$. Since there are $K$ of them, the total sampling overhead is


$ C_(upright("em"))^(upright("naive")) = K sum_(n = 1)^K lr(|alpha_n|)^2 . $<eqn:naive_cost>


Such a method is not scalable if the number of terms $K$ is large, which is the case for many QEM methods. Instead, we can construct the estimator $hat(O)_(upright("em"))$ using Monte Carlo methods. We can rewrite @eqn:em_est_decomp into


$ upright(E) \[ hat(O)_(upright("em")) \] = A sum_(n = 1)^K lr(|alpha_n|) / A "sgn" ( alpha_n ) upright(E) \[ hat(O)_n \] = A upright(E) \[ hat(O)_(upright("mix")) \] , $<eqn:lin_comb_err_miti>


where $A = sum_(n = 1)^K lr(|alpha_n|)$. Here we have define a new random variable $hat(O)_(upright("mix"))$ which is a probabilistic mixture of the set of random variables ${ "sgn" ( alpha_n ) hat(O)_n }$ with $"sgn" ( alpha_n ) hat(O)_n$ being chosen with the probability $lr(|alpha_n|) / A$. Each sample of $hat(O)_(upright("em"))$ is just a sample of $hat(O)_(upright("mix"))$ scaled by the factor $A$


$ hat(O)_(upright("em")) = A hat(O)_(upright("mix")) . $


Using the same $upright("Var") \[ hat(O)_n \] tilde upright("Var") \[ hat(O)_rho \]$ assumption, we then have $upright("Var") \[ hat(O)_(upright("mix")) \] tilde upright("Var") \[ hat(O)_rho \]$ and thus


$ upright("Var") \[ hat(O)_(upright("em")) \] = A^2 upright("Var") \[ hat(O)_(upright("mix")) \] tilde A^2 upright("Var") \[ hat(O)_rho \] . $


Hence, the sampling overhead (@eqn:samp_cost) of performing error-mitigated estimation using $hat(O)_(upright("em"))$ instead of $hat(O)_rho$ is then


$ C_(upright("em"))^(upright("MC")) = A^2 = ( sum_(n = 1)^K lr(|alpha_n|) )^2 . $<eqn:monte_cost>


Using the Cauchy--Schwarz inequality to compare the sampling cost in @eqn:naive_cost and @eqn:monte_cost, we have


$ ( sum_(n = 1)^K lr(|alpha_n|) )^2 & <= K sum_(n = 1)^K lr(|alpha_n|)^2\
arrow.r.double.long C_(upright("em"))^(upright("MC")) & <= C_(upright("em"))^(upright("naive")) . $


i.e. the Monte Carlo method is always more sample efficient under our assumptions.


Instead of making assumptions about the variance of the component random variables $hat(O)_n$, we can also obtain a similar sampling overhead using Hoeffding's inequality as shown in @eqn:samp_cost_hoeff. This uses the fact that the component random variables $hat(O)_n$ usually have the same range as $hat(O)_rho$ since they are usually obtained from the measurement of the same observable, or even if the observables are different, they are often all Pauli observables which have the same range.


Here we have talked about using Monte Carlo sampling for estimating the error-mitigated expectation value. Similar arguments can also be applied to the estimation of loss functions in learning-based methods and other similar situations.


=== Exponential sampling overhead
<sec:monte_carlo_sampling_exp>
As mentioned in @sec:exp_samp_cost, if the component random variables ${ hat(O)_n }$ are obtained from measuring Pauli observables on circuits suffering from Pauli gate noise with a circuit fault rate of $lambda$ or more, then its expectation value will decay exponentially with $lambda$:


$ upright(E) \[ hat(O)_n \] = cal(O) (e^(- beta_n lambda)) $


for some positive $beta_n$. We also have:


$ upright("Var") \[ hat(O)_n \] = upright(E) \[ hat(O)_n^2 \] - upright(E) \[ hat(O)_n \]^2 = 1 - cal(O) (e^(- 2 beta_n lambda)) $


where we have used $hat(O)_n^2 = 1$ for Pauli observable.


As mentioned above, $hat(O)_(upright("mix"))$ is the probabilistic mixture of the set of random variable ${ "sgn" ( alpha_n ) hat(O)_n }$ with the probability distribution ${ p_n = lr(|alpha_n|) / A }$. Using the properties of random variables from mixture distribution, we have:


$ upright(E) \[ hat(O)_(upright("mix")) \] = sum_n p_n "sgn" ( alpha_n ) upright(E) \[ hat(O)_n \] = cal(O) (e^(- beta lambda)) $


with $beta = min_n beta_n$ and we also have:


$ upright("Var") \[ hat(O)_(upright("mix")) \] & = upright(E) \[ hat(O)_(upright("mix"))^2 \] - upright(E) \[ hat(O)_(upright("mix")) \]^2\
 & = sum_n p_n upright(E) \[ hat(O)_n^2 \] - upright(E) \[ hat(O)_(upright("mix")) \]^2\
 & = 1 - cal(O) (e^(- 2 beta lambda)) $


where we have again used $hat(O)_n^2 = 1$. This shows that when we are considering Pauli observable under Pauli circuit noise, the assumption $upright("Var") \[ hat(O)_(upright("mix")) \] tilde upright("Var") \[ hat(O)_n \]$ mentioned in the last section is valid at large $lambda$ even without needing to consider how the various $hat(O)_n$ are exactly constructed.


Since the error-mitigated estimator is $hat(O)_(upright("em")) = A hat(O)_(upright("mix"))$, we then have:


$ upright(E) \[ hat(O)_(upright("em")) \] & = A upright(E) \[ hat(O)_(upright("mix")) \] = cal(O) (A e^(- beta lambda)) $


In order to ensure the expectation value of the error-mitigated estimator does not decay with the noise level $lambda$, we need to have $A = cal(O) (e^(beta lambda))$, which implies that the sampling cost using @eqn:monte_cost is


$ C_(upright("em")) = A^2 = cal(O) (e^(2 beta lambda)) $


i.e. it increases exponentially with $lambda$.


== Pauli twirling
<sec:twirling>
Given a noise process $cal(N)$, twirling it over a symmetry group $bb(G)$ means conjugating $cal(N)$ with random elements in $bb(G)$:


$ upright(bold(T))_(bb(G)) ( cal(N) ) = 1 / lr(|bb(G)|) sum_(cal(G) in bb(G)) cal(G) cal(N) cal(G) . $


Note that here we are using the super-operator formalism. Twirling over the Pauli group, which is called Pauli twirling, will remove all the off-diagonal elements of $cal(N)$ in the Pauli basis, transforming the error channel into Pauli noise.


Now suppose we have a noisy Clifford gate $cal(C)_epsilon.alt$ that is simply the ideal Clifford Channel $cal(C)$ followed by the noise channel $cal(N)$: $cal(C)_epsilon.alt = cal(N) cal(C)$. If we want to twirl the noise channel $cal(N)$ of the noisy Clifford gate $cal(C)_epsilon.alt$, we can apply $cal(C)_epsilon.alt$ with a random Pauli $cal(G)$ and its corresponding Pauli $cal(C) cal(G) cal(C)^dagger$ in each circuit run:


$ upright(bold(T))'_(bb(G)) ( cal(C)_epsilon.alt ) & = 1 / lr(|bb(G)|) sum_(cal(G) in bb(G)) (cal(C) cal(G) cal(C)^dagger) cal(C)_epsilon.alt cal(G) = 1 / lr(|bb(G)|) sum_(cal(G)' in bb(G)) cal(G)' cal(C)_epsilon.alt (cal(C)^dagger cal(G)' cal(C))\
 & = (1 / lr(|bb(G)|) sum_(cal(G) in bb(G)) cal(G) cal(N) cal(G)) cal(C) . $


To twirl the error of a sequence of Clifford gates $product_(m = M)^1 cal(C)_m$, the random Pauli for twirling consecutive Clifford gates can be merged.


To twirl a noisy $T$ gate: $cal(T)_epsilon.alt = cal(N) cal(T)$, we then need to apply the following circuit


$ upright(bold(T))'_(bb(G)) ( cal(T)_epsilon.alt ) & = 1 / lr(|bb(G)|) sum_(cal(G)' in bb(G)) cal(G) cal(T)_epsilon.alt (cal(T)^dagger cal(G) cal(T)) = (1 / lr(|bb(G)|) sum_(cal(G) in bb(G)) cal(G) cal(N) cal(G)) cal(T) , $


where $cal(T)^dagger cal(G) cal(T)$ is some Clifford gates.


== Measurement techniques
<sec:meas_tech>
To measure an arbitrary operator, we can always measure its Pauli basis and then combine the results. Hence, without loss of generality, we will be mostly focusing on Pauli measurements in this section.


In practical experiments, it is often the case that we can only perform single-qubit $Z$ measurements to high accuracy. Hence, one way to measure a Pauli operator is by transforming it into single-qubit $Z$ using Clifford circuits. Given linear qubit connectivity, the additional Clifford circuits needed will require long-range gates of depth $cal(O) (log ( N ))$ or local gates of depth $cal(O) (N)$, which is discussed in the context of symmetry verification by #cite(<bonet-monroigLowcostErrorMitigation2018>, form: "prose"). Alternatively, for a given Pauli operator $O$, if we can implement controlled-$O$ gates, we can also #emph[indirectly] measure $O$ through the Hadamard test as shown in @fig:Htest. The controlled-$O$ gate can be implemented using a Clifford circuit that transforms $O$ to single-qubit $Z$ along with a controlled-$Z$ gate. The cost of this is similar to the direct measurement discussed above.


// [figvision] imgs/Htest.png
// Panel a: This panel displays a schematic diagram defining an operator. On the left, a horizontal line
// representing a quantum state labeled with the Greek letter rho enters a rounded rectangular box containing the
// capital letter O. An equals sign connects this to the right side, which depicts a Hadamard test circuit. The
// top wire starts with the state ket-plus, passes through a control dot, and ends at a measurement gate labeled
// X. The bottom wire starts with state rho, passes through a target box labeled O, and continues out. A vertical
// line links the control dot on the top wire to the target box on the bottom wire.
#figure(image("imgs/Htest.png", width: 44.0%),
  caption: [
    Hadamard test circuit for performing Pauli $O$ measurement. If $O$ is some general unitary, then the Hadamard test circuit above in which we measure $X ⊗ I$ will output the expectation value $Re ( "Tr" \[ O rho \] )$, while measuring $Y ⊗ I$ will output the expectation value $Im ( "Tr" \[ O rho \] )$.
  ]
)
<fig:Htest>



Any given Pauli operator $O$ can be written as the tensor product of single-qubit Pauli operators $O = ⨂_(n = 1)^N G_n$ where $G_n$ is the action of $O$ on the $n^(upright("th"))$ qubit. Hence, the controlled-$O$ in the Hadamard test can also be decomposed into low-weight controlled-$G_n$ gates instead. In fact, we can measure $O$ directly by performing single-qubit Pauli measurements of its components ${ G_n }$ and multiplying the results. In this way, the additional circuitry needed for measuring $O$ is only one layer of single-qubit Clifford for changing the measurement basis.


Now suppose we want to measure #emph[two commuting] Pauli operators in the same circuit run, which can be useful in for example symmetry verification, we can use the single-qubit measurements plus post-processing scheme mentioned above, but we must make sure the two Pauli operators #emph[qubit-wise] commute~@izmaylovRevisingMeasurementProcess2019, i.e. for every qubit, the single-qubit Pauli components acting on it from different observables commute. For example, $X X I$ and $I X Z$ are qubit-wise commuting, but $X X$ and $Y Y$ are not. Note that for a set of operators to qubit-wise commute, their actions on a given qubit must be the same Pauli operator or the identity. More generally, the set of operators that are linear combinations of a set of qubit-wise commuting Pauli operators are also qubit-wise commuting and can be measured simultaneously using single-qubit Pauli measurements in the same circuit run. Whenever two Pauli operators commute, we can make them qubit-wise commuting using a suitable choice of Clifford circuit. Examples of this have been discussed in direct symmetry verification in @sec:sym.


In some other cases, we are more interested in the expectation values of a set of commuting operators instead of their exact measurement results in any given circuit run. In these scenarios, instead of trying to measure multiple observables in every circuit run, it is possible to obtain these expectation values through #emph[shadow tomography]~@huangPredictingManyProperties2020 using random single-qubit Pauli measurement and post-processing.


Now let us move beyond measuring commuting Pauli operators and consider the case in which we want to measure the #emph[product] of a Pauli operator $O$ and some general Hermitian operator $S$ that does not necessarily commute with $O$. For the circuits shown in @fig:HtestProd, if we perform a projective measurement of the Pauli operator $O$ first, and then measure the operator $S$, then the latter measurement is equivalent to measuring the components of $S$ that commute with $O$, which is simply $S_(+) = frac(S + O S O, 2)$~@mitaraiMethodologyReplacingIndirect2019 @caiResourceefficientPurificationbasedQuantum2021 @huoDualstatePurificationPractical2022. Taking the product of the two measurements, we can obtain the expectation value of the symmetrised product $O S_(+) = frac(O S + S O, 2)$, which is useful in symmetry verification in @sec:sym (in which $S$ is the symmetry) and echo verification in @sec:pur (in which $S$ is the dual state).


// [figvision] imgs/HtestProd.png
// Panel a shows a schematic quantum circuit diagram. On the left, an input state labeled rho enters a box
// labeled O, followed by a second box labeled S. An equivalence symbol equals is placed to the right of this
// sequence. This represents a direct measurement protocol where the operator O acts on the state rho, and then S
// acts on the result. The layout is linear, moving from left to right, indicating the temporal order of
// operations in the quantum process described as measuring Pauli and Hermitian operators. Panel b depicts the
// equivalent Hadamard test circuit corresponding to the left side. It consists of two parallel horizontal lines
// representing qubits. The top line starts with a ket vector label plus sign enclosed in angle brackets. A black
// dot control gate appears on this top line, connected vertically to a square gate labeled O on the bottom line.
// The bottom line begins with the state rho entering the O gate. After the interaction, the top line passes
// through a rounded rectangle labeled X, while the bottom line passes through a rounded rectangle labeled S.
#figure(image("imgs/HtestProd.png", width: 44.0%),
  caption: [
    Circuits for measuring $O S_(+) = frac(O S + S O, 2)$ in which $O$ is Pauli and $S$ is Hermitian. On the left circuit, we first perform a non-destructive measurement of $O$ and then measure $S$ and take the product of the measurement results. On the right circuit, the non-destructive measurement of $O$ is carried out using Hadamard tests and the expectation value of $O S_(+)$ is simply obtained by measuring $X ⊗ S$ at the end.
  ]
)
<fig:HtestProd>



The component of $S$ that anti-commute with $O$, denoted as $S_(-) = frac(S - O S O, 2)$, can be obtained by first applying the Pauli rotation $exp ( - i pi / 4 O )$ and then measuring $S$~@mitaraiMethodologyReplacingIndirect2019 @caiResourceefficientPurificationbasedQuantum2021 @huoDualstatePurificationPractical2022. Combined with the measurement of $S_(+)$ above, we can obtain the expectation value of the product observable $O S$. Alternatively, if we can implement controlled-$O$ and controlled-$S$, then they can be composed to give controlled-$O S$, which can be used to measure $O S$ using the Hadamard test.







     /Rotate



 90


#block[
]







#figure(
  align(center)[
    #text(size: 7.5pt)[#table(
      columns: (7em, 8.5em, 9em, 10em, 12em, 10em),
      align: (left, left, left, left, left, left),
      stroke: (x: none, y: 0.5pt),
      inset: (x: 3pt, y: 3pt),
      table.header(
        [Methods], [Probabilistic Error Cancellation], [Richardson Extrapolation (Equal-gap #super[\#])], [Symmetry Verification], [Virtual Distillation], [Echo Verification],
      ),
      [Main assumptions], [Full knowledge of the noise.], [Ability to scale the noise. Small $lambda$#super[§].], [The ideal state contains inherent symmetry.], table.cell(colspan: 2)[The ideal state $rho_0$ is pure. The noise is stochastic such that $rho_0$ is the dominant eigenvector of the noisy state $rho$. #super[§]],
      [Hyper-parameters], [Circuit fault rate #emph[after] mitigation: $lambda_"em"$], [Number of data points: $M$], [The projector of the symmetry subspace: $Pi$], [Degree of purification: $M$], [Nil],
      [Qubit overhead], [$1$], [$1$], [$1$#super[‡]], [$M$], [$1$],
      [Circuit runtime overhead], [up to $tilde 2$], [up to $tilde M$], [$1$], [$tilde 1$#super[‖]], [$2$],
      [Sampling overhead ($C_"em"$)], [$e^(4 (lambda - lambda_"em"))$], [$(2^M - 1)^2$], [Post-selection: $upright("Tr")[Pi rho]^(-1)$ \ Post-processing: $upright("Tr")[Pi rho]^(-2)$], [$upright("Tr")[rho^M]^(-2) gt.tilde frac(e^(2 M lambda), [1 + (e^lambda - 1)^M]^2)$], [$upright("Tr")[rho^2]^(-1) gt.tilde frac(e^(2 lambda), 1 + (e^lambda - 1)^2)$],
      [Fidelity boost#super[$*$]], [$e^(lambda - lambda_"em")$], [$e^lambda + cal(O)(lambda^M)$], [$upright("Tr")[Pi rho]^(-1)$], [$frac(upright("Tr")[rho_0 rho]^(M - 1), upright("Tr")[rho^M]) gt.tilde frac(e^lambda, 1 + (e^lambda - 1)^M)$], [Same as VD with $M = 2$],
      [Bias], [Can reach $0$ when $lambda_"em" = 0$.], [$cal(O)(lambda^M)$], table.cell(colspan: 3)[Can be upper-bounded using the error-mitigated fidelity using @eqn:bias_fid_bound, which in turns is related to the fidelity boost achieved.],
    )]
    #v(4pt)
    #text(size: 7.5pt)[#super[$*$] Fidelity boost is the factor of increase in the fidelity against the ideal state $rho_0$ after applying error mitigation (see #ref(<sec:state_extract_perf>, supplement: "Sec.")). \
    #super[§] There are successful experiments operating beyond the small-$lambda$ assumption. The small-$lambda$ assumption is not needed for some other extrapolation methods. (see #ref(<sec:zne>, supplement: "Sec.")) \
    #super[\#] There are other variants of Richardson extrapolation that may provide better scalings for the overheads @sidiPracticalExtrapolationMethods2003. \
    #super[‡] Assuming only the inherent symmetries of the physical problems are used. Additional qubit overhead might be needed if we want to introduce additional symmetries. \
    #super[‖] Additional circuit components are needed to swap in between the noisy copies and the corresponding additional runtime required will depend on the connectivity of the hardware.]
  ],
  caption: [A table summarising the assumptions, costs and performances associated with some of the QEM methods mentioned in this review. Some of the expressions of the sampling overhead and the fidelity boost are derived under the assumption that the occurrence of faults in the circuit follows a Poisson distribution with the circuit fault rate being $lambda$ as discussed in Sec. #ref(<sec:circuit_faults>, supplement: none). We use $rho$ and $rho_0$ to denote the unmitigated noisy state and the ideal noiseless state, respectively. Only a specific instance of error extrapolation is included here. Measurement error mitigation is not included here since it can be viewed as the special case of probabilistic error cancellation focusing on the measurement noise. Quantum subspace expansion and $N$-representability are also not included in here since their implementation costs and performance are highly problem-specific.],
  kind: table,
  scope: "parent",
  placement: top,
) <tab:qem_summary>


#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "apa", title: [References])