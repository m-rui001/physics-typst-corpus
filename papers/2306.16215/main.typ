#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.79cm, right: 1.76cm, top: 2.36cm, bottom: 2.56cm), columns: 2)
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set heading(numbering: "1.1")
#set figure(placement: auto)
#set par(justify: true, spacing: 0.98em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.59em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: auto)
#show math.equation.where(block: true): set align(center)


#place(top, float: true, scope: "parent", clearance: 1.2em)[
  #align(center)[
    #text(17pt, weight: "bold", [Search for an isotropic
  gravitational-wave background with the Parkes Pulsar Timing Array])
    #v(1em)
  ]
  #v(1em)
    #v(0.5em)
    #text(8.8pt)[Daniel J. Reardon#super[1,2], Andrew Zic#super[3,4], Ryan M. Shannon#super[1,2], George B. Hobbs#super[3], Matthew Bailes#super[1,2], Valentina Di Marco#super[5,6], Agastya Kapur#super[4,3], Axl F. Rogers#super[7], Eric Thrane#super[5,6], Jacob Askew#super[1,2], N. D. Ramesh Bhat#super[8], Andrew Cameron#super[1,2], Małgorzata Curyło#super[9], William A. Coles#super[10], Shi Dai#super[11], Boris Goncharov#super[12,13], Matthew Kerr#super[14], Atharva Kulkarni#super[1,2], Yuri Levin#super[15,16,5], Marcus E. Lower#super[3], Richard N. Manchester#super[3], Rami Mandow#super[4,3], Matthew T. Miles#super[1,2], Rowina S. Nathan#super[5,6], Stefan Osowski#super[17], Christopher J. Russell#super[18], Renée Spiewak#super[19], Songbo Zhang#super[20,3], Xing-Jiang Zhu#super[21]]
    #v(0.6em)
    // affcenter
#align(center)[#set text(style: "italic")

      #super[1] Centre for Astrophysics and Supercomputing, Swinburne University of Technology, P.O. Box 218, Hawthorn, Victoria 3122, Australia \
      #super[2] OzGrav: The Australian Research Council Centre of Excellence for Gravitational Wave Discovery, Hawthorn VIC 3122, Australia \
      #super[3] Australia Telescope National Facility, CSIRO, Space and Astronomy, P.O. Box 76, Epping, NSW 1710, Australia \
      #super[4] Department of Physics and Astronomy and MQ Research Centre in Astronomy, Astrophysics and Astrophotonics, Macquarie University, NSW 2109, Australia \
      #super[5] School of Physics and Astronomy, Monash University, VIC 3800, Australia \
      #super[6] OzGrav: The Australian Research Council Centre of Excellence for Gravitational Wave Discovery, Clayton VIC 3800, Australia \
      #super[7] Institute for Radio Astronomy \& Space Research, Auckland University of Technology, Private Bag 92006, Auckland 1142, New Zealand \
      #super[8] International Centre for Radio Astronomy Research, Curtin University, Bentley, WA 6102, Australia \
      #super[9] Astronomical Observatory, University of Warsaw, Aleje Ujazdowskie 4, 00-478 Warsaw, Poland \
      #super[10] Electrical and Computer Engineering, University of California at San Diego, La Jolla, California, U.S.A. \
      #super[11] School of Science, Western Sydney University, Locked Bag 1797, Penrith South DC, NSW 2751, Australia \
      #super[12] Gran Sasso Science Institute (GSSI), I-67100 L'Aquila, Italy \
      #super[13] INFN, Laboratori Nazionali del Gran Sasso, I-67100 Assergi, Italy \
      #super[14] Space Science Division, US Naval Research Laboratory, 4555 Overlook Ave SW, Washington DC 20375, USA \
      #super[15] Physics Department and Columbia Astrophysics Laboratory, Columbia University, 538 West 120th Street, New York, NY 10027, USA \
      #super[16] Center for Computational Astrophysics, Flatiron Institute, 162 5th Ave, NY10011, USA \
      #super[17] Manly Astrophysics, 15/41-42 East Esplanade, Manly, NSW 2095, Australia \
      #super[18] CSIRO Scientific Computing, Australian Technology Park, Locked Bag 9013, Alexandria, NSW 1435, Australia \
      #super[19] Jodrell Bank Centre for Astrophysics, Department of Physics and Astronomy, University of Manchester, Manchester M13 9PL, UK \
      #super[20] Purple Mountain Observatory, Chinese Academy of Sciences, Nanjing 210008, China \
      #super[21] Advanced Institute of Natural Sciences, Beijing Normal University, Zhuhai 519087, China \
    ]
    #v(0.5em)
    #text(8pt)[E-mail: andrew.zic\@csiro.au, dreardon\@swin.edu.au]

  #align(center)[
// abshead
#align(center)[#text(10pt)[ABSTRACT]]

    #text(9.5pt)[Pulsar timing arrays aim to detect nanohertz-frequency gravitational waves (GWs). A background of GWs modulates pulsar arrival times and manifests as a stochastic process, common to all pulsars, with a signature spatial correlation.

  Here we describe a search for an isotropic stochastic gravitational-wave background (GWB) using observations of 30 millisecond pulsars from the third data release of the Parkes Pulsar Timing Array (PPTA), which spans 18 years.

  Using current Bayesian inference techniques we recover and characterize a common-spectrum noise process. Represented as a strain spectrum $h_c = A ( f\/1 "yr"^(- 1) )^alpha$, we measure $A = 3.1_(- 0.9)^(+ 1.3) times 10^(- 15)$ and $alpha = - 0.45 plus.minus 0.20$ respectively (median and 68% credible interval). For a spectral index of $alpha = - 2\/3$, corresponding to an isotropic background of GWs radiated by inspiraling supermassive black hole binaries, we recover an amplitude of $A = 2.04_(- 0.22)^(+ 0.25) times 10^(- 15)$. However, we demonstrate that the apparent signal strength is time-dependent, as the first half of our data set can be used to place an upper limit on $A$ that is in tension with the inferred common-spectrum amplitude using the complete data set. We search for spatial correlations in the observations by hierarchically analyzing individual pulsar pairs, which also allows for significance validation through randomizing pulsar positions on the sky. For a process with $alpha = - 2\/3$, we measure spatial correlations consistent with a GWB, with an estimated false-alarm probability of $p lt.eq 0.02$ (approx. $2 sigma$). The long timing baselines of the PPTA and the access to southern pulsars will continue to play an important role in the International Pulsar Timing Array.]
  ]

  #text(9.5pt)[*Keywords:* Gravitational waves --- Gravitational wave astronomy --- Millisecond pulsars --- Pulsar timing method --- Bayesian statistics]
]

= Introduction
<sec:intro>
The era of observational gravitational-wave (GW) astronomy commenced with the observation of a stellar-mass binary black hole merger #cite(<Abbott-16>). The growing catalog of GW events from ground-based observatories covers relatively high frequencies in a band spanning $tilde.op 10^1 thin$Hz to $cal(O) ( 10^3 ) thin$Hz #cite(<Abbott-21>). Pulsar timing array (PTA) experiments offer a complementary window into the GW landscape in the nanohertz-frequency band at frequencies $cal(O) ( 10^(- 9) ) thin$Hz. Sources of GWs at such low frequencies may include supermassive black hole binary (SMBHB) systems #cite(<Rajagopal-95>)#cite(<Wyithe-03>)@Sesana13#cite(<Ravi-15>)#cite(<Burke-Spolaor-19>), primordial quantum fluctuations amplified by inflation #cite(<Grishchuk-05>)#cite(<Lasky-16>), cosmic strings #cite(<Siemens-07>)#cite(<Olmez-10>), or cosmological phase transitions #cite(<Caprini-10>)#cite(<Xue-21>). The highest-amplitude (loudest) signal in this band is expected to be the stochastic background produced by the incoherent superposition of GWs radiated by inspiraling SMBHBs. An isotropic stochastic gravitational-wave background (GWB) is the primary target for GW searches by current PTA collaborations.

A PTA consists of a set of millisecond pulsars (MSPs) that are monitored regularly (cadences of many days to a few weeks), over decade timescales, to take advantage of their long-term rotational stability #cite(<Foster-90>). As GWs impart a strain on space-time, they slowly modulate the observed pulse times of arrival (ToAs) from MSPs in an achromatic manner @Sazhin78#cite(<Detweiler79>). The ToA modulations induced by an isotropic GWB are predicted to possess a steep power spectral density (PSD) $P prop f^(- gamma)$, where $f$ is the GW frequency. This spectrum is derived from the GW strain amplitude spectrum $h_c = A ( f\/1 "yr"^(- 1) )^alpha$, where $alpha = ( 3 - gamma )\/2$. The characteristic spectral index of an isotropic GWB from inspiraling SMBHBs is $alpha = - 2\/3$ and thus $gamma = 13\/3$ #cite(<Phinney01>). The challenge in detecting this signal is that MSPs are not perfectly stable in their spin and pulse properties and may show intrinsic low-frequency noise that could resemble a GWB for individual pulsars #cite(<Shannon-10>). Additionally, plasma in the interstellar medium has a significant effect on radio pulses as it imparts dispersion and scattering delays that depend on the radio wavelength as $lambda^2$ and $lambda^(tilde.op 4)$ respectively #cite(<You-07>)#cite(<Hemberger-08>). Variations in these propagation effects can also produce a red signal in the pulse arrival times #cite(<Cordes-10>)#cite(<Keith-13>). Other low-frequency noise sources can include errors in the solar system ephemeris (SSE), clock errors, unmodeled variability in the solar wind, or offsets induced by the observing instrumentation #cite(<Tiburzi-16>).

The distinct characteristic of an isotropic GWB, which separates it from intrinsic pulsar spin noise and other noise processes, is the spatial correlations in the arrival times. The Hellings--Downs function describes the expected correlation in the pulse arrival times between pairs of pulsars, as a function of their sky separation angle #cite(<HellingsDowns>). It is the #emph[fingerprint] of the GWB and is presently the most sought-after signal for a PTA experiment. The sensitivity of a PTA to such spatial correlations depends primarily on the number of pulsar pairs and their sky distribution #cite(<Siemens-13>)#cite(<Taylor-16>), which motivates the combination of global PTA datasets under the International Pulsar Timing Array #cite(<Hobbs-10>)@IPTA_dr2_gwb project. Future observations in the high signal-to-noise regime of the GWB may reveal anisotropy resulting from an unresolved local population of SMBHBs #cite(<Taylor-13>)#cite(<Mingarelli-17>). Individual supermassive black hole sources may also be observed, with orbital properties inferred through template matching of the GW waveform #cite(<Jenet-04>)#cite(<Corbin-10>)@Ellis13#cite(<Zhu-15>).

The Hellings--Downs signature cross correlation is relatively weak, with the average amplitude of the cross correlation being well under 0.25, depending on the distribution of the pulsars on the sky. As the number of pulsars in the array increases, along with the time span and advances in instrumentation that improve the timing precision, the sensitivity of a PTA also increases. We would expect, eventually, to see the same GWB spectrum in the power spectrum for each pulsar, rising above the noise level (which is different for each pulsar). However, the cross correlations may not become evident until the sensitivity of the PTA increases significantly #cite(<Pol-21>)#cite(<Romano-21>). Exactly this situation occurred when the North American Nanohertz Observatory for gravitational waves (NANOGrav) detected a “common-spectrum” process in their pulsars using $12.5 thin$yr of MSP timing data, but was unable to establish a significant cross correlation between pulsar pairs #cite(<NG12.5yrSGWB>). A similar common-spectrum process was also detected by the other PTAs without obvious cross correlations @PPTA_dr2_crn#cite(<EPTA_dr2_crn>). The IPTA, using a union of earlier data releases from each of these PTAs, also identified a common-spectrum process, notably with higher significance than the individual PTA constituents of the dataset #cite(<IPTA_dr2_gwb>).

The origin of the common-spectrum process is unclear, in part because these recent results were in apparent tension with the 95% confidence upper limits placed by some PTA analyses using earlier data releases #cite(<Shannon-15>)#cite(<NG11yrSGWB>). Unmodeled SSE errors @Bayesephem, choices of noise models and priors #cite(<Hazboun-20b>), and finite numbers of pulsars #cite(<Johnson-22>) have been proposed to have been factors in these earlier upper-limit results. The NANOGrav analysis, and earlier works @NG11yrSGWB@Bayesephem, demonstrated that SSE errors could be contributing to the measured common noise, and consequently, techniques were developed to account for such errors. The PPTA analysis found that the "common process" model does not discriminate between common and spectrally similar noise processes #cite(<Zic-22>), which was addressed in #cite(<Goncharov-22>, form: "prose"). Depending on the noise modeling framework, a recovered common-spectrum process could contain various non-GW sources of noise. For example, the common spectrum could include pulsar timing noise and/or errors in the correction of interstellar medium effects (dispersion and scattering), which would be uncorrelated between pulsars and could have a similar power-law red spectrum. It could also include SSE errors, which would be correlated between pulsars and could have a wide range of spectral distributions #cite(<Guo-19>)#cite(<Bayesephem>). Evidently, the origin of the common spectrum will not be resolved until a significant cross correlation is obtained.

For this work we have used the third data release of the PPTA @PPTA-DR3_data to search for and characterize a common-spectrum stochastic process and spatial correlations, with particular focus on the GWB. In a coordinated effort, the NANOGrav, EPTA and Indian Pulsar Timing Array @InPTA, and Chinese Pulsar Timing Array @CPTA collaborations have also recently searched their respective data sets for a GWB @ng_15yr_gwb@epta_inpta_gwb#cite(<cpta_gwb>). In @sec:methods, we describe the data analysis methods and the models we consider. The results are presented in @sec:results and the implications are discussed further in #ref(<sec:discussion>). We conclude in #ref(<sec:conclusions>). \

= Methods
<sec:methods>
The analysis presented here is performed on the third PPTA data release (PPTA-DR3) and individual pulsar noise analyses. The data release adds $tilde.op 3$ yr of timing baseline compared to PPTA-DR2 @ppta_dr2 and includes observations taken with the new ultrawide-band low receiver @uwl, which offers wider bandwidths than previous observations. This is useful for measuring interstellar medium effects and obtaining arrival times with higher precision. The data release @PPTA-DR3_data and noise analyses @PPTA-DR3_noise are presented in companion papers. While PPTA-DR3 contains observations from 32 pulsars, in this work we only consider 30 of them. The globular cluster MSP PSR~J1824$-$2452A was excluded as it contains steep-spectrum red noise that is too strong for this pulsar to be sensitive to a common process. The noise is likely intrinsic to the pulsar #cite(<Shannon-10>), although globular-cluster dynamics may contribute as well. We also exclude PSR~J1741$+$1351 from the analysis. It was only added to the PPTA as the UWL was commissioned, and observed with low priority. In the current data release, only $16$ observations were available, resulting in a data set that would not be sensitive to any GWB signal. These observations could, however, become useful as part of future IPTA data sets.

== Inference and PTA likelihood
<inference-and-pta-likelihood>
We use Bayesian inference#footnote[For an overview of the principles of Bayesian inference in gravitational-wave astronomy, see~#cite(<Thrane-19>) and~#cite(<Taylor21>).] to search for and characterize noise and signals in our data set, following previous PTA analyses @NG12.5yrSGWB@PPTA_dr2_crn@EPTA_dr2_crn#cite(<IPTA_dr2_gwb>). PTAs observe offsets between the measured pulse arrival times $bold(delta t)$ and the arrival times predicted by the models.

The time-domain likelihood of the observed residuals given a model is described by a Gaussian likelihood function, $cal(L) ( bold(delta t) \| bold(theta) )$, where $bold(theta)$ is the vector of model parameters #cite(<vanHaasteren-09>). The likelihood is multivariate with respect to the number of observations of timing residuals. The implementation of the likelihood is described in #cite(<NG9yr>, form: "prose") and #cite(<Taylor-17>, form: "prose"), and it is given by $ cal(L) ( bold(delta t) \| bold(theta) ) = frac(exp (- 1 \/ 2 ( bold(delta t) - bold(mu) )^T bold(C)^(- 1) ( bold(delta t) - bold(mu) )), sqrt(det (2 pi bold(C)))) , $ where $bold(mu) ( bold(theta) )$ represents the model prediction for timing residuals, and the covariance matrix is $bold(C) ( bold(theta) )$. The diagonal elements in the covariance matrix represent the temporally uncorrelated noise, which is referred to as white. Temporally correlated stochastic processes, referred to as red, could have been represented by off-diagonal elements in $bold(C)$. However, to avoid a computationally expensive matrix inversion, temporally correlated stochastic processes are modeled as Gaussian processes #cite(<Lentati-13>)#cite(<vanHaasteren-14>) in $bold(mu)$: $ bold(mu) = bold(F) bold(a) + bold(M) bold(epsilon.alt) . $<eqn:single_psr_likelihood> where the design matrix $bold(M)$ and the corresponding coefficients $bold(epsilon.alt)$ are the timing model contributions, and the red processes are modeled using the Fourier sine and cosine basis functions in $bold(F)$ and amplitudes $bold(a)$. We emphasize that $( bold(a)$ and $bold(epsilon.alt) )$ are a subset of the parameters in the model $bold(theta)$. They are nuisance parameters and can be analytically marginalized over a Gaussian prior $pi ( bold(a) , bold(epsilon.alt) \| bold(theta') )$. It is common to assume that there is a relationship between the amplitudes of the Fourier components. In this case, $bold(theta')$ are hyperparameters that govern the spectra of temporal correlations, such as the power-law amplitude and the slope of $P ( f )$ of pulsar-intrinsic red noise, or the gravitational-wave background. The prior on $bold(a)$ joins single-pulsar likelihoods into a joint posterior distribution $ cal(P) ( bold(theta) , bold(theta') \| bold(delta t) ) prop cal(L) ( bold(delta t) \| bold(theta) ) pi ( bold(a) , bold(epsilon.alt) \| bold(theta') ) pi ( bold(theta') ) . $ The covariance matrix of $pi ( bold(a) , bold(epsilon.alt) \| bold(theta') )$ has elements $ pi_( a i ) , ( b j ) = P_(a i) delta_(a b) delta_(i j) + Gamma_(a b) P_i delta_(i j) , $<eqn:covariance> where $a$ and $b$ are pulsar indices, and $i$ and $j$ are frequency indices. $P_(a i)$ is the PSD of the noise intrinsic to pulsar $a$ at a frequency bin $i$, $P_i$ is the PSD of a spatially correlated signal at the frequency $i$, and $Gamma_(a b)$ is the overlap reduction function that determines the degree of this correlation between pulsars $a$ and $b$.

In case of an isotropic GWB from circular SMBHBs, $Gamma_(a b)$, also referred to as the overlap reduction function, is given by the @HellingsDowns curve: $ Gamma_(a b) = 1 \/ 2 delta_(a b) + 1 \/ 2 - x_(a b) \/ 4 + 3 \/ 2 x_(a b) ln x_(a b) , $<eqn:hd> where $x_(a b) = ( 1 - cos zeta_(a b) )\/2$, $delta_(a b)$ is the Kronecker delta function, and $zeta_(a b)$ is the sky separation angle for a given pair of pulsars.

We evaluate the posterior probability $cal(P) ( bold(theta) , bold(theta') \| bold(delta t) )$ using the #smallcaps[enterprise] package @Enterprise and a parallel-tempered Markov Chain Monte Carlo (MCMC) algorithm #cite(<PTMCMC>). For more details about modeling Gaussian processes in PTAs, see #cite(<Lentati-13>, form: "prose") and #cite(<vanHaasteren-14>, form: "prose").

Previous GWB analyses have assessed the properties of the dominant temporally correlated and spatially uncorrelated #emph[common-spectrum] process. This process was considered as the null hypothesis in searches for the spatially correlated GWB signal. The PSD of temporal correlations can be modeled as a power law parameterized by an amplitude ($A$) and spectral index: $ P ( f ) = frac(A^2, 12 pi^2) (f \/ f_"yr")^(- gamma) , $<eqn:crn> where $gamma > 0$. The models of common noise in this form are added to the PTA likelihood and analyzed simultaneously with all red-noise processes identified in single pulsars. The support for the proposed common-noise processes is quantified primarily through the Bayesian odds ratio (equivalent to the Bayes factor $cal(B)$ for equal prior odds), which can be estimated using the product-space sampling method @NG9yr#cite(<Carlin-18>)

The number of Fourier frequency components used to model the common power-law processes can be set by the sensitivity of our PTA, which is white-noise dominated near $f tilde.op 1\/( 240 thin "days" )$ #cite(<NG12.5yrSGWB>). Accordingly we set the number of components as $N_"comp" = floor.l T_"span"\/( 240 thin "days" ) floor.r = 28$, where $T_"span" = 6605 thin "days"$ is the total observing span of PPTA-DR3. We note that the use of a broken power-law model to set the number of significant Fourier components @NG12.5yrSGWB could highlight excess unmodeled (non-power-law) noise at higher frequencies. If the noise is correctly characterized, and the signal is a power law, then the data will not favor a turnover frequency and should instead become insensitive to a turnover for frequencies that are white-noise dominated.

Under the model of a fixed spectral index $gamma = 13\/3$ @Phinney01 and zero spatial correlation, the PTA likelihood can be factorized into a product of likelihoods from individual pulsars #cite(<Taylor-22>). In this way, a $gamma = 13\/3$ process can be introduced to the noise models of individual pulsars and the resulting posterior probability density functions (PDFs) for the process amplitude can be multiplied to produce a posterior for the whole array. We use this factorized-likelihood approach to efficiently assess the preferred amplitude of a $gamma = 13\/3$ process in our data, and to estimate the model support under an assumed prior range using the Savage--Dickey method for computing the Bayes factor $cal(B)$ #cite(<Dickey71>).

Hereafter, when referring to specific models, we label the amplitude of an uncorrelated common-red-noise (CRN) process as $A^("CRN")$, and when the spectral index is fixed at $gamma = 13\/3$, we write $A_(13\/3)^("CRN")$. For a $gamma = 13\/3$ process in a single pulsar (i.e. not common to the PTA), we use $A_(13\/3)$. A process with Hellings--Downs correlations included in the covariance matrix is denoted $A^("HD")$ with a varied spectral index and $A^("GWB")$ when the index is $gamma = 13\/3$.

=== Defining prior ranges
<defining-prior-ranges>
The choice of prior has a dramatic effect on the Bayesian evidence of common-noise processes, and therefore Bayes factors used for model comparison #cite(<Zic-22>). It is important for priors to encompass the likelihood support, but prior ranges that are too broad have been shown to induce spurious support for certain models. This problem affects the inference of common uncorrelated noise processes in PTAs, and can lead to very high Bayesian support for a common process where none exists #cite(<Zic-22>). To mitigate the possibility of spurious support, we trialed different priors in our analysis. For the factorized-likelihood analysis we adopt a log-uniform prior on the amplitude in the range $- 20 lt.eq log_10 A_(13\/3) lt.eq - 11$ to be consistent with earlier analyses @NG12.5yrSGWB#cite(<PPTA_dr2_crn>). However, our data are not sensitive to signals below $log_10 A_(13\/3) lt.eq - 16.5$ even for very steep spectral indices ($gamma tilde.op 7$). We therefore adopt $log_10 A_(13\/3) gt.eq - 18$ as a conservative lower bound for the remainder of our analyses. The prior for the common-noise spectral index is uniform in $0 lt.eq gamma lt.eq 7$.

To set the prior ranges for the individual pulsar noise parameters, we take the central $99.7 %$ credible interval from our single-pulsar noise analysis posteriors @PPTA-DR3_noise, and add a generous buffer region such that pulsar noise properties are allowed to vary substantially under a common-noise model. These ranges are $log_10 A_0.15 - 2 lt.eq log_10 A lt.eq log_10 A_99.85 + 1$ and $gamma_0.15 - 0.5 lt.eq gamma lt.eq gamma_99.85 + 0.5$, where the parameter subscripts denote the percentile of the posterior distribution for this parameter. This ensures that we do not force any pulsars to have intrinsic noise if it is instead attributed to a common process and the prior range encompasses all likelihood support from the data. PSR~J1643$-$1224 is the only pulsar with a lower bound $log_10 A gt.eq - 17$, with a red noise prior constructed in this way of $- 15.2 < log_10 A < - 11.5$ as it is observed to have shallow-spectrum noise ($gamma lt.eq 2.3$ with 99.7% confidence). By restricting the prior ranges in this way, we reduce the risk of spurious measurements #cite(<Zic-22>) of common noise and are able to accelerate the inference. We are confident in the recovered parameters using this methodology as the shapes and values of the inferred marginal posterior PDFs using these prior ranges are consistent with those recovered using standard priors.

== Noise and Signal Models
<sec:models>
=== Common processes
<common-processes>
The term #emph[common noise] refers to any noise process (or potentially unmodeled deterministic signal), correlated or uncorrelated, that is characterized by the same power spectral density for all pulsars. However, common noise could be recovered from similar power spectral densities in most pulsars, and as such, examples include not only GWs but also potentially unmodeled instrumental offsets, the solar wind; or errors in the clock correction, Earth orientation parameters, or SSE. If intrinsic pulsar timing noise (rotational irregularities) is generated by the same physical mechanism in multiple pulsars, the spectral properties of this random process could be recovered via inference of a common-spectrum noise process but should be spatially uncorrelated, unlike the GWB. The variety of potential common-noise sources highlights the need to measure the signature spatial correlations in order to detect a GWB. The power spectrum of a power-law common uncorrelated process is given by #ref(<eqn:crn>).

=== Searching for spatial correlations
<sec:corr_method>
We conduct two distinct classes of searches for the Hellings--Downs correlations inherent to a GWB. First, we replicate the methods of some previous searches @NG12.5yrSGWB@PPTA_dr2_crn@EPTA_dr2_crn@IPTA_dr2_gwb, by constructing the global PTA likelihood for all pulsars and introducing a Hellings--Downs correlated noise term to the likelihood (see @eqn:covariance). For this model, both the autocorrelations and cross correlations are considered and inform the parameter inference. The sensitivity of the PPTA data set is predicted to be dominated by the autocorrelations #cite(<Spiewak-22>), so we could expect the spectral properties of such a model to closely resemble the uncorrelated common process. While pulsar white-noise terms are usually fixed at their maximum likelihood values (as they are less covariant with the GWB), we numerically marginalized over all red-noise terms for all pulsars in the array, as these noise terms could be highly covariant with any common signal. This results in a high-dimension parameter space that needs to be explored. In the case of PPTA-DR3 the parameter space spans 260 dimensions.

We also present a new search method that increases the efficiency of the inference with a hierarchical inference approach. This is important because with our large data volume ($tilde.op 1.2 times 10^5$ ToAs) and parameter space ($tilde.op 260$ free parameters) it takes of order CPU years to collect a sufficient number of independent MCMC samples for standard full-PTA correlation analyses, which makes it costly to determine false-alarm probabilities with bootstrap methods. We first search for common-spectrum noise process in pulsar pairs individually. We measure the $log_10 A_(13\/3)$ and correlation coefficient, $Gamma$, for each of the $435$ unique pulsar pairs ($N_"pair" = N_"psr" ( N_"psr" - 1 )\/2$, for $N_"psr"$ pulsars) in our data set. From the posterior samples, we derive a smooth PDF, $p ( log_10 A_(13\/3) , Gamma )$, using a two-dimensional Gaussian kernel density estimate (KDE). We account for the bounded domains $- 1 lt.eq Gamma lt.eq 1$, and $- 18 lt.eq log_10 A lt.eq - 14$ by mirroring the samples at these boundaries to partially overcome bias in the density estimator introduced by the boundary discontinuity #cite(<Schuster-85>).

The standard deviation of the Gaussian kernel (for all pairs) was $sigma_("KDE") ( log_10 A ) = 0.05$ for amplitude (the standard deviation of our measured common process) and $sigma_("KDE") ( Gamma ) = 0.27$ for correlation coefficient (the minimum observed standard deviation for an individual pair in our sample). We also tried using a different $sigma_("KDE") ( Gamma )$ kernel width for each pair, computed using Silverman's rule @Silverman86, and we observe consistent results.

From these resulting PDFs, we reweight the posterior samples #cite(<Gelman-95>)#cite(<Goncharov-22>)#cite(<Hourihane-22>)#cite(<Taylor-22>) to recover the probability density for $Gamma$ that corresponds to the posterior probability density of $log_10 A_(13\/3)^("CRN")$ that we measured from our factorized-likelihood analysis. After this reweighting, the $435$ PDFs for $Gamma$, denoted $p ( Gamma )$, assume a common distribution on $log_10 A$. These PDFs can then be analyzed to assess the model support for correlations such as the Hellings--Downs ORF expected of the isotropic GWB. The measurements will not be completely independent, and we address the implications of this below.

We also measure $p ( Gamma )$ for the amplitude fixed at our maximum likelihood $log_10 A_(13\/3)^("CRN")$, which is equivalent to the reweighted measurements if the correlations do not evolve across the uncertainty of the recovered common noise. These fixed-amplitude measurements are more computationally efficient, particularly for pulsars with low likelihood support at the amplitude of interest. We therefore obtain these fixed-amplitude correlation measurements from independent MCMC chains so that they can also serve as a consistency test, sensitive to errors in the KDE due to a finite number of samples.

We quantify the support for a Hellings--Downs ORF over uncorrelated common noise by computing the likelihood of each model. The Hellings--Downs likelihood is defined to be the product of the probabilities of observing $Gamma = Gamma_(a b)$ for each pair $ cal(L)^("HD") = product_(k = 1)^(N_"pair") p_k ( Gamma = Gamma_(a b) ) $ where the $k^"th"$ pair involves pulsars $a$ and $b$, $N_"pair" = 435$, and $Gamma_(a b)$ is given by #ref(<eqn:hd>). Similarly, the likelihood of zero correlations for the observed common noise is $ cal(L)^("CRN") = product_(k = 1)^(N_"pair") p_k ( Gamma = 0 ) . $ The support for Hellings--Downs over zero correlations can be quantified using the likelihood ratio $Delta cal(L)_("CRN")^("HD") = cal(L)^("HD")\/cal(L)^("CRN")$. This could be interpreted as an estimated Bayes Factor $cal(B)_("CRN")^("HD")$ because the ORFs are effectively zero-parameter models. However, because of the weaknesses in this method (e.g. assuming the measured correlations are independent, and KDE biases), the #emph[ad-hoc] estimator $Delta cal(L)_("CRN")^("HD")$ is not as well-defined as a Bayes factor, and we instead interpret its statistical significance by generating noise realizations from the data itself.

The method allows for the rapid computation of false-alarm probabilities by recalculating the likelihood statistics after assuming random positions for the pulsars on the sky. This process is referred to as sky scrambling #cite(<Cornish-16>)#cite(<Taylor-17>). The number of possible independent skies (leading to orthogonal sets of samples from the Hellings--Downs ORF) is limited to $N_"sky" = N_"psr" ( N_"psr" - 1 )$, for $N_"psr"$ pulsars with equal sensitivity. However, we are able to generate a larger number of skies by relaxing the strict requirement for independence. We instead consider randomized skies where the normalized inner product of the ORF samples from any two skies is $lt.eq 0.2$ #cite(<Cornish-16>)#cite(<Taylor-17>).

Our hierarchical inference scheme can also be simply extended to search for anisotropy in the GWB #cite(<Taylor-13>), or to search for a signal with a completely different spatial correlation signature. It could also be used to estimate the amplitude of a correlated signal independently from the autocorrelations (provided a reliable reconstruction of the full $( log_10 A , Gamma )$ parameter space can be made for each pair).

Pulsars have different sensitivities to common-noise processes due to variations in their timing precision and intrinsic red-noise properties. As a result, the effective number of pulsar pairs in the array is less than the total. We can also use the PDFs for $Gamma$ to compute the number of effective pulsar pairs $n_"eff"$ using $ n_"eff" = frac((sum_(k = 1)^(N_"pair") sigma_k^(- 2))^2, sum_(k = 1)^(N_"pair") sigma_k^(- 4)) , $<eqn:neff> where $sigma_k$ is the uncertainty in the angular correlation for the $k^"th"$ pulsar pair. We define $sigma_k$ as the half-width of the 68% credibility interval of the correlation coefficient posterior for pulsar pair $k$. This is more conservative than using the standard deviation of the posterior samples as $sigma_k$ because the distributions are often asymmetric.

= Results
<sec:results>
== Factorized-likelihood analysis
<factorized-likelihood-analysis>
// [figvision] imgs/all_factorlike_GWB.png
// Probability density (log scale, 1e-9..1e1) versus log10 A_GW (horizontal, -20..-11) for
// factorised per-pulsar posteriors. Histogram step curves are colour-coded: J0437-4715
// (blue), J1603-7202 (orange), J1713+0747 (green), J1744-1134 (yellow), J1909-3744
// (purple), J2145-0750 (brown). All sit at a flat pedestal of ~1e-1 between -20 and -15;
// each then rises sharply, with a peak between -15.3 and -14.2, and falls to zero within
// ~0.3 dex. A green dashed horizontal line at 1e-1 labelled "Prior" and a thick black
// "Total" curve that peaks at ~-14.6 (about 5) before dropping to 1e-9. Many faint grey
// curves extend the family to the right up to -12.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering).* #it.body]
}

#figure(scope: "parent", placement: auto, image("imgs/all_factorlike_GWB.png", width: 70.0%),
  caption: [
    Factorized-likelihood analysis on the $log_10 A_(13\/3)$ from the PPTA-DR3 pulsars. We highlight the three pulsars showing the highest (PSRs~J1909$-$3744, J0437$-$4715, and J2145$-$0750) and lowest (PSRs~J1744$-$1134, J1603$-$7202, and J1713$+$0747) consistency with the inferred common process with colored histograms. Other pulsars are presented as light-gray histograms. The prior density is shown with the green dashed line, and the total factorized-likelihood constraint for $log_10 A_(13\/3)^("CRN")$ (the product of all other histograms) is shown by the black line.
  ]
)
<fig:factorised_likelihood>

We first searched for a purported common red process using the factorized-likelihood technique #cite(<Taylor-22>). For each pulsar, we include an achromatic process with a fixed spectral index of $gamma = 13\/3$, while the (log) amplitude for this process, with a prior in the range $- 20 lt.eq log_10 A_(13\/3) lt.eq - 11$, was sampled simultaneously with the full single-pulsar noise models. The posterior probability density for each pulsar (light-gray and colored lines) is shown in #ref(<fig:factorised_likelihood>). The probability density for the log amplitude of a #emph[common process] is found by taking the product of these individual pulsar posteriors. In this way, the log amplitude can be interpreted as a probability-weighted mean. The resulting distribution gives $log_10 A_(13\/3)^("CRN") = - 14.69 plus.minus 0.05$, where, here and throughout, the uncertainties represent the central 68% credibility interval unless otherwise stated.

The PPTA data as a whole support the inclusion of a $gamma = 13\/3$ process at this amplitude, with a strong Savage--Dickey Bayes factor, $log_10 cal(B) = 6.8$. By reducing the prior range to our nominal $- 18 lt.eq log_10 A_(13\/3) lt.eq - 11$, we find that the evidence decreases to $log_10 cal(B) = 4.8$, indicating that this statistic alone is a poor metric for determining if a common-noise process is present in the array. We stress that, while the evidence for a common-noise process varies under different assumed prior ranges, the recovered characteristics do not, because the likelihood support under a common-noise model is encompassed for all pulsars for all prior ranges considered.

== Noise consistency metrics
<noise-consistency-metrics>
// [figvision] imgs/factorised_psr_log10_A_p_ratios_kde_3.png
// Two stacked panels, both versus 39 pulsars (labels rotated along the bottom, J1909-3744
// ... J1713+0747).
// Top: "Consistency metric" (log, 1e-2..1e2) as blue (filled/open) and orange
// (filled/open) dots. Blue values fall from 20-30 for the first pulsars to ~1 by the
// middle and to ~0.05-0.07 at the right; orange values follow about a factor 2 lower,
// from 40-50 down to ~0.02. Legend defines the four series as ratios of the posterior
// density at log10 A_13/3 = -14.69 to the prior density (open) or to the average
// probability with truncations at -18 / -16.5.
// Bottom: B^13/3_{10 13/3} process ratio (log, 1e-1..1e1): blue filled and open circles
// start near 3-4, flatten around 0.7-0.9 in the middle, and drop to 0.4-0.5 at the last
// pulsars; the open (log10 A > -18) series sits slightly below the filled one throughout.
// Dashed vertical gridlines mark each pulsar.
#figure(scope: "parent", placement: auto, image("imgs/factorised_psr_log10_A_p_ratios_kde_3.png", width: 95.0%),
  caption: [
    Statistics assessing the support for a noise process with $gamma = 13\/3$ for each pulsar in PPTA-DR3. Top: posterior probability density ratio for a $gamma = 13\/3$ process, at $log_10 A_(13\/3) = - 14.69$, relative to $log_10 A_(13\/3) < - 16.5$ (where the data are insensitive to a $gamma = 13\/3$ process) in blue, and the prior density in orange. Bottom: The Savage--Dickey Bayes factor $cal(B)$ for a $gamma = 13\/3$ process at any amplitude, which is also the ratio of the orange to blue points in the top panel. Filled and hollow circles correspond to prior range lower bounds on $log_10 A_(13\/3)$ of $- 20$ and $- 18$, respectively.
  ]
)
<fig:support>

Next, we assessed the consistency of each of the pulsars with the common red process. Using the posterior distributions in @fig:factorised_likelihood, we define metrics to assess the consistency of individual pulsars with the common process. We compute posterior probability density ratios, which compare the probability taken at the measured common amplitude $p ( log_10 A_(13\/3) = - 14.69 )$, against both the prior probability density $pi ( log_10 A_(13\/3)^("CRN") )$ and the mean probability at low (effectively zero) amplitude $p ( log_10 A_(13\/3) < - 16.5 )$. The probability ratios, shown in the top panel of @fig:support, are intended to portray similar information to the “dropout factors” used in previous works @NG12.5yrSGWB#cite(<PPTA_dr2_crn>). We also compute the Savage--Dickey Bayes factor, $cal(B) = pi ( log_10 A_(13\/3) )\/p ( log_10 A_(13\/3) < - 16.5 )$, which provides the support from each pulsar for a $- 13\/3$ process at any amplitude (bottom panel in @fig:support). The three pulsars with the highest $cal(B)$ and the three with the lowest $cal(B)$ are highlighted with unique colors in #ref(<fig:factorised_likelihood>). The three pulsars that show the highest support show evidence for red noise in single-pulsar noise analyses and also are likely to dominate the factorized likelihood. The three pulsars with the lowest $cal(B)$ show no evidence for red noise in single-pulsar analyses. The posterior distributions for these pulsars show negative support for the CRN at the inferred amplitude. This is discussed further below.

== Common uncorrelated process
<common-uncorrelated-process>
// [figvision] imgs/crn_ephem_comp.png
// Joint posterior of the common red-noise parameters: gamma (horizontal, 2.0..6.0) versus
// log10 A_CRN (vertical, -15.4..-14.0). Three nested contour sets: DE440 (green),
// DE438 (orange) and DE421 (blue), each with 1-sigma/2-sigma/3-sigma contours. All are
// elongated along a negative correlation (larger gamma with lower amplitude): the common
// core sits near (3.8, -14.45); DE421's outer contour extends to (5.4, -15.25), i.e. the
// older ephemeris gives the broadest posterior, while DE440/DE438 agree closely.
// Marginal histograms on top (gamma) and right (log10 A_CRN, with a filled green band)
// duplicate the 1D projections. A dashed vertical line at gamma ~ 4.33 marks the
// reference value. Legend at upper right.
#figure(scope: "parent", placement: auto, image("imgs/crn_ephem_comp.png", width: 70.0%),
  caption: [
    Marginal posterior probability distributions for the measured logarithmic amplitude and spectral index ($gamma$) of a common uncorrelated process assuming different solar system ephemerides (SSE). Using DE440 (green) we measure $gamma = 3.87 plus.minus 0.36$ and $log_10 A^("CRN") = - 14.50_(- 0.16)^(+ 0.14)$ (median and 68% credible interval; shaded regions in one-dimensional histograms). The contours on the two-dimensional marginal distribution show the 1$sigma$, 2$sigma$, and 3$sigma$ credible intervals for each of the SSEs.
  ]
)
<fig:curn_ephems>

We next search for a single uncorrelated common process with a variable spectral index. In contrast to the factorized-likelihood analysis discussed previously, this process is included for the PTA as a whole and sampled simultaneously with all red components of the single-pulsar noise models. The characteristics of this common process are considered for multiple SSEs from the Jet Propulsion Laboratory (JPL; DE421, DE438, and DE440), with our fiducial results generated with the most recent DE440 ephemeris #cite(<DE440>). The one and two-dimensional marginal posterior probability distributions for the (log) amplitude and spectral index for the recovered process are shown in #ref(<fig:curn_ephems>). All ephemerides return consistent constraints for the process, with DE440 providing $gamma = 3.9 plus.minus 0.4$ and $log_10 A^("CRN") = - 14.50_(- 0.16)^(+ 0.14)$. While DE421 is an obsolete SSE that is inaccurate for the Jovian system, the recovered common noise is consistent, suggesting that the spectral characteristics are dominated by another source. Under the assumption of a fixed spectral index of $gamma = 13\/3$ we recover the same amplitude constraint as the factorized-likelihood analysis, as expected.

We also searched for a common uncorrelated process using commonly used broad priors on single-pulsar noise terms ($- 20 lt.eq log_10 A lt.eq - 11$, $0 lt.eq gamma lt.eq 7$) under the DE440 ephemeris. We compare this with our distribution recovered under tailored priors for single-pulsar noise terms in #ref(<fig:crn_prior>). The distributions are consistent, and for the broader priors we recover $gamma = 4.0_(- 0.3)^(+ 0.3)$ and $log_10 A^("CRN") = - 14.52_(- 0.15)^(+ 0.14)$. The differences are comparable to those induced by SSE choice and much smaller than those induced by weakness in single-pulsar noise models #cite(<PPTA-DR3_noise>).

// [figvision] imgs/crn_prior_comp.png
// Same joint-posterior layout as the ephemeris comparison: gamma (horizontal, 2.5..5.5)
// versus log10 A_CRN (vertical, -15.2..-14.0), with three contour levels and marginal
// histograms on top and right.
// Two overlaid posteriors: "Tailored priors" (blue) and "Equal priors" (orange). Both
// are elongated negatively correlated bands centred near (3.9, -14.55); the blue
// contours are slightly wider and extend further to high gamma (to 5.1, -15.05) while
// the orange contour is more compact. The top marginal (gamma) peaks near 4.0-4.1 for
// both; the right marginal peaks near -14.45. A dashed vertical line at gamma ~ 4.33
// (the reference) lies inside both allowed regions. Legend at upper right.
#figure(placement: top, image("imgs/crn_prior_comp.png", width: 78%),
  caption: [
    Marginal posterior probability distributions for the logarithmic amplitude and spectral index ($gamma$) of a common uncorrelated process, under our tailored single-pulsar priors (blue) and broader equal priors (orange).
  ]
)
<fig:crn_prior>

== Time-dependence of the common process amplitude
<time-dependence-of-the-common-process-amplitude>
// [figvision] imgs/log10_A_time_uniformul2.png
// Two vertically stacked violin plots, both log10 A_CRN (vertical, -18..-13.5) versus
// Year (horizontal, 2005..2022), sharing the same style: orange violins for the earlier
// season (2005-2012) and blue violins for the later season (2012-2020), each violin a
// kernel density whose long tail is drawn as a thin grey line ending in an arrow at -18.
// Top: "6 yr slices"; bottom: "9 yr slices".
// In both panels the early orange violins are broad and centred near -14.7 to -14.9 with
// tails reaching -18; the later blue violins become progressively narrower and shift
// upward, centring at -14.6 to -14.5 and eventually losing the deep tail. Two horizontal
// reference lines: solid black at -14.67 and dashed at -14.87. The narrowing of the
// violins with time is the key feature (constraining amplitude from below).
#figure(image("imgs/log10_A_time_uniformul2.png", width: 50.0%),
  caption: [
    Posterior probability density #emph[violins] for the uncorrelated common-spectrum noise amplitude as a function of time, using a 6 yr (top) and 9 yr (bottom) sliding window (#emph[slices]) over the data set. The spectral index is fixed at $- 13\/3$. Slices with unconstrained (log) amplitude posteriors have been reweighted to have linear priors in $A_(13\/3)^("CRN")$ (orange), and the 95% confidence upper limits are denoted with vertical arrows. Slices with constrained measurements of $log_10 A_(13\/3)^("CRN")$ are colored in blue. For reference, the dashed horizontal line indicates the $1.2 times 10^(- 15)$ upper limit set by our first 9 yr slice. The solid horizontal line and gray band indicate the measured $log_10 A_(13\/3)^("CRN")$ of $- 14.69$ and its 68% credible interval from our full PPTA-DR3 analysis. Here and elsewhere, the violins represent the probability density of a parameter, with broader segments of a violin corresponding to higher probability density.
  ]
)
<fig:time_slices>

Next we search for any time evolution of the CRN process. With the longest multiwavelength timing baseline and high timing precision on many pulsars, the PPTA data provides the best opportunity to assess the stationarity of any purported common red signal. Our motivation is to investigate the reasons why the previous upper limits on the GWB from all PTAs were lower than the amplitude of the purported common noise being detected in recent and current data sets. This includes a limit of $A_(upright(13\/3))^("CRN") < 1.2 times 10^(- 15)$ (95% confidence), which we place using the first half of our data set (described below). This limit can be considered a replacement of the limit placed using a subarray of four PPTA pulsars with data extending to the beginning of 2015 #cite(<Shannon-15>), which used the now-obsolete DE421 SSE #cite(<DE421>).

We estimate the amplitude of the common noise in 6 and 9 yr sliding windows (#emph[slices]) assuming $gamma = 13\/3$ and present the results in #ref(<fig:time_slices>). In the early time windows, marked in orange, a common-noise process with the $gamma = 13\/3$ spectrum was not detected, and we have shown the 95%-confidence upper limit for the amplitude. In the later windows, marked in blue, a detection was made, and the full 95% credible interval was given. It is clear that these bounds on the common-noise increase with time, and in the earlier data, they are broadly consistent with earlier upper limits #cite(<Shannon-15>)#cite(<NG11yrSGWB>). The observational systems improved significantly with time, but it is hard to avoid the conclusion that, if the common noise represents a single distinct physical process such as a GWB, then the process is not time stationary. However, we cannot at this point rule out a nonastrophysical origin for this effect.

The earlier parts of the data used less powerful signal processing equipment, resulting in reduced sensitivity (and higher upper limits) due to lower received observing bandwidth and greater levels of digital artifacts in the data #cite(<Manchester-13>)#cite(<ppta_dr2>). In intermediate windows (dates centering between 2010 and 2012), which included data with the more sensitive last-generation narrowband (pre-UWL) digital receiving systems, we also find no evidence of a common red process. The 95% upper limits were computed by reweighting the posterior samples to a prior that is uniform in linear amplitude. We infer upper limits from these intermediate windows ranging from $A_(13\/3)^("CRN") < 1.2 times 10^(- 15)$ to $A_(13\/3)^("CRN") < 1.5 times 10^(- 15)$, which are below the measured $A_(13\/3)^("CRN") = 2.0 plus.minus 0.2 times 10^(- 15)$ from the full data set. The upper limit from the first 9 yr ($A_(13\/3)^("CRN") < 1.2 times 10^(- 15)$) slice corresponds with approximately the same data span and time range considered in #cite(<Shannon-15>, form: "prose"). The similarly tight bound that we derive consolidates this result and other similar upper limits #cite(<NG11yrSGWB>). The amplitude inferred from the most recent 6 yr slice is $A_(13\/3)^("CRN") = 2.7_(- 0.7)^(+ 0.8) times 10^(- 15)$. This is higher than, but still consistent with, the $A_(13\/3)^("CRN")$ measurement from the full data span. #cite(<Johnson-22>, form: "prose") found that the use of a small number of pulsars #cite(<Shannon-15>) can increase the chance of underestimating upper limits on the amplitude of a common process. However, this is not the origin for the apparent time variability that we observe, as we use all available pulsars in each slice (i.e. 23 pulsars for the first slice, and 30 pulsars in the last) and the same priors and noise models across the slices.

Using the first three 9 yr windows, the upper limits on the amplitude of the signal are inconsistent with the amplitude measured in the entire data set, and in later subsets. The measured uncorrelated common-spectrum amplitude $log_10 A_(13\/3)^("CRN") = - 14.69$ lies at the 99.8 percentile of the reweighted samples from the first 9 yr window. While some variability would be expected because of the stochasticity of the background #cite(<Hazboun-20a>), this level of variation is extreme, and the implications are discussed below.

== Common free spectrum
<common-free-spectrum>
// [figvision] imgs/common_freespec_factorised.png
// Free-spectrum posterior: log10 rho(s) (vertical, -9.0..-5.5) versus log10(f/Hz)
// (horizontal, -9.0..-7.3). A regular sequence of violin plots (green fill, black and
// yellow outlines) sits at frequency bins of 0.1 dex. The violin centres follow a
// straight descending black line from (-8.8, -6.4) to (-7.3, -9.0), i.e. a power-law
// spectrum. Early violins are broad (width ~0.3 dex, tails reaching -9.0); as frequency
// rises the density becomes increasingly spiky, with a few narrow high-amplitude peaks
// (e.g. near -7.5) and much longer thin tails. Grid lines at 0.2 dex.
#figure(scope: "parent", placement: auto, image("imgs/common_freespec_factorised.png", width: 80.0%),
  caption: [
    Free-spectrum common-noise inference for the PPTA-DR3. The textitviolins show the probability density of the power spectral density for the free spectrum of a common-noise process (the width of the violin represents the probability density, with a linear scale). Solid green violins are from a factorized-likelihood analysis using the achromatic noise in single pulsars. Black violins are from a common free-spectrum inference assuming no cross correlations. Gold violins show the free spectrum of a common-noise process with Hellings--Downs cross correlations.
  ]
)
<fig:freespec>

To assess whether or not the apparent common red signal is consistent with a power-law process, we formed the free spectrum. As with power-law processes, the free spectrum is modeled as a Fourier series but the variances of each Fourier coefficient are independent (i.e., not constrained to follow a power-law process).

We formed the free spectrum using multiple methods. First we modeled it as a common process both with zero correlations and with Hellings--Downs correlations. In addition, we formed the spectrum using a factorized-likelihood approach. The probability density for the PSD of individual Fourier components can be factorized in the same way as the power-law amplitude. We determine, for each pulsar, the probability density of the (achromatic) noise PSD for each Fourier component. The frequencies for the components are the same for each pulsar, and are the frequencies that the total dataset is sensitive to, from $1\/T_"span"$ to $60\/T_"span"$, where $T_"span"$ is the total length of the PPTA-DR3 dataset.

The different estimates of the free spectrum can be seen in #ref(<fig:freespec>). The results are consistent, showing that the common noise is well described as the probability-weighted mean of all achromatic noise processes in individual pulsars. Additionally, it is consistent with a power law, particularly at the lowest frequencies, which suggests that a single process may be dominating. The factorized-likelihood spectrum shows excess power at a frequency of 14.0 nHz, which corresponds to a period of 2.26 yr. The common free-spectra show reduced sensitivity for periods near 3 yr, which corresponds to the approximate time span of the new pulsars added to the array (with only UWL data). Including Hellings--Downs correlations does not significantly change the nature of the spectrum. We interpret this as a result of the spectral characteristics of the common noise being dominated by the autocorrelations #cite(<Spiewak-22>).

== Isotropic Stochastic Gravitational-wave Background
<isotropic-stochastic-gravitational-wave-background>
We searched for evidence of the correlations of an isotropic GWB by considering models that include the Hellings--Downs spatial correlations in the PTA likelihood. We first searched for a power-law process with an unknown spectral index and the DE440 SSE, recovering $gamma = 3.87 plus.minus 0.47$ and $log_10 A^("HD") = - 14.51_(- 0.20)^(+ 0.18)$, which is consistent with, but less precise than the measurement using the uncorrelated component alone. The agreement is unsurprising as the sensitivity of the PPTA data set is dominated by the autocorrelations. At a fixed spectral index for the assumed GWB from SMBHBs, we measure $log_10 A^("GWB") = - 14.68 plus.minus 0.06$, which is also consistent with the uncorrelated noise. We have also measured the common-noise free spectrum assuming Hellings--Downs correlations and find that it is consistent, at all Fourier frequencies considered, with the uncorrelated common noise (@fig:freespec, gold). Again this indicates that the cross correlations are dominated by the autocorrelated component.

To quantify whether the data supports the inclusion of these correlations, we estimate the Bayesian odds ratio for using product-space sampling @NG11yrSGWB#cite(<NG12.5yrSGWB>). Relative to a common uncorrelated process, we find no additional Bayesian support, for or against, the Hellings--Downs using this approach, with $cal(B)_("CRN")^("HD") tilde.op 1.5$ for a varied spectral index, and $cal(B)_("CRN")^("HD") tilde.op 2$ for $gamma = 13\/3$. These values are not significant.

== Search for the spatial correlations
<search-for-the-spatial-correlations>
We directly search for the spatial correlations using our technique described in @sec:corr_method, instead of assuming an ORF and testing for model support through a common-noise model. The measurement of interest here is the correlation coefficient $Gamma$ of a $gamma = 13\/3$ process, and we obtain one measurement (the posterior probability density) for each of the 435 unique pulsar pairs in our array. These measurements are informed by the cross correlations only and assume a common distribution for $log_10 A_(13\/3)$. The parameters in the single-pulsar noise models have also been accounted for in each pair. The numerically marginalized single-pulsar noise properties are self-consistent, meaning that the observed noise characteristics of a pulsar are independent of which pulsar it is paired with.

To visualize the correlations, we place our 435 pulsar-pair PDFs, $p ( Gamma )$, into eight independent and equally spaced bins in sky separation angle $zeta$. The PDFs in each bin are multiplied to give the total probability density for that bin. The resulting PDFs are shown in @fig:correlations, with a gray histogram representing the number of pulsar pairs in each angular bin. It should be noted that because the cross-correlation measurements are not completely independent, the apparent uncertainties will be underestimated (emphasizing the need for statistical validation using bootstrap noise realizations).

We show both the measurements assuming a common distribution of $log_10 A_(13\/3) = - 14.69 plus.minus 0.05$, and assuming a fixed amplitude of $log_10 A_(13\/3) = - 14.69$. The measurements were produced with independent posterior samples and the resulting correlations are nearly identical, which indicates that the effect of KDE uncertainty due to a finite number of samples is negligible. It can be clearly seen that the Hellings--Downs curve (solid black line, @eqn:hd) is a better description of the resulting PDFs than zero correlations (which we quantify below). It can also be seen that a monopole (with correlation coefficient, $Gamma = 1$) and dipolar correlations (with $Gamma = cos ( theta )$, i.e., $Gamma = 1$, at $zeta = 0^compose$, and $Gamma = - 1$, at $zeta = 180^compose$) are not the dominate source of the common noise at this assumed amplitude and spectral index. However, these alternative correlations must be present at some level in all PTA datasets.

We compute the model likelihoods for the correlations associated with the common noise and find a likelihood ratio $log_10 Delta cal(L)_("CRN")^("HD") = 1.1$ in support of Hellings--Downs over zero correlations. To interpret the significance of this result, we calibrate the false-alarm probability by generating noise from the $p ( Gamma )$ distributions themselves via sky scrambling. We generate $10^4$ random pulsar sky distributions with the criteria for near-independence described in #ref(<sec:corr_method>). As the sky distributions are not truly independent, the false-alarm probability is only an estimate #cite(<dimarco-23>). A histogram of the $log_10 Delta cal(L)_("CRN")^("HD")$ for Hellings--Downs over uncorrelated noise from these randomized skies is shown in @fig:scambles, from which we derive one-sided $p$-values of $p lt.eq 0.014$ and $p lt.eq 0.015$ for our observations from the varied and fixed-amplitude correlations, respectively. Using Silverman's rule @Silverman86 to set the kernel bandwidth for each pair, we observe consistent values of $p lt.eq 0.018$ and $p lt.eq 0.012$, respectively. We note that, while sky scrambling with this method is simple and efficient, other false-alarm probability calculations will be required for validating any future GWB detection claims #cite(<Taylor-17>).

The support for Hellings--Downs correlations can be efficiently quantified on a per-pulsar basis with our scheme. @fig:hdsupport shows, for each pulsar, the likelihood ratio (Bayes factor estimator) $Delta cal(L)_("CRN")^("HD")$ computed using only pairs involving the given pulsar. The pulsars are ordered by their support for the uncorrelated common noise in #ref(<fig:support>). The pairs involving PSR~J1744$-$1134 give the most discrepant $Delta cal(L)_("CRN")^("HD")$ between the two amplitude assumptions we consider. This pulsar has fewer independent posterior samples for the varied amplitude analysis than most others, because of its low likelihood support in this region of the parameter space (PSR~J1713$+$0747, with lower likelihood support, was analyzed including samples from additional MCMC chains to compensate). Therefore the difference likely reflects some small KDE uncertainty due to a finite number of samples.

// [figvision] imgs/corr_total_0_274_gaussian.png
// Angular correlation: correlation coefficient Gamma (left vertical, -1..1) versus sky
// separation angle zeta (horizontal, 0..180 degrees). Green violin plots at 20-degree
// bins (centres ~10..170) show the posterior of Gamma: widest at zeta~10 (spanning
// -1..1, centred near 0.5) and narrowing to +-0.3 by zeta~60-90. A thick black dashed
// curve starts at 0.5 at zeta=0, falls to a minimum of -0.15 at zeta~80-90, and rises
// again to 0.27 at 180 degrees (the Hellings-Downs shape). Grey histogram (right axis,
// "Number of pulsar pairs", 0..100) peaks at 45-60 degrees (about 100 pairs) and falls
// to below 10 beyond 150 degrees. Violins are outlined in black.
#figure(placement: auto, image("imgs/corr_total_0_274_gaussian.png", width: 80.0%),
  caption: [
    Measured spatial correlations as a function of the angular separation angle, $zeta$. The width of each #emph[violin] as a function of $Gamma$ is proportional to the inferred probability density, $p ( Gamma )$. Binned correlations are shown assuming a common-noise distribution of $log_10 A_(13\/3)^("CRN") = - 14.69 plus.minus 0.05$ (green, filled) and with amplitude fixed at the median (black, hollow). The dashed black line is the Hellings--Downs ORF. The gray histogram shows the number of pulsar pairs in each angular bin.
  ]
)
<fig:correlations>

// [figvision] imgs/scrambles_0_274_gaussian.png
// Histogram of the null distribution: number of randomized skies N_sky (vertical,
// 0..2100) versus log10 Delta L_CRN^HD (horizontal, -3.5..3.5). Green bars with thick
// black edges form a roughly Gaussian peak at -1.2..-0.8 (about 2100 skies per bin),
// decaying to ~350 at -2.2 and to a few at +1.5. A vertical dashed black line at +1.2
// marks the observed log-likelihood difference, far in the right tail (essentially no
// randomized sky reaches it). No legend.
#figure(image("imgs/scrambles_0_274_gaussian.png", width: 50.0%),
  caption: [
    False-alarm probability calculations from $10^4$ quasi-independent randomized pulsar sky distributions (sky scrambles). As with @fig:correlations, the green (filled) histogram corresponds to the measurements assuming $log_10 A_(13\/3)^("CRN") = - 14.69 plus.minus 0.05$ and the black (hollow) histogram assumes the median amplitude. The measured likelihood ratios $Delta cal(L)_("CRN")^("HD")$ from the data under the two assumptions about the amplitude are marked by dashed lines and correspond to a one-sided false-alarm probability of $p lt.eq 0.014$.
  ]
)
<fig:scambles>

We compute the number of effective pulsar pairs using $sigma_k$ from each pulsar pair $k$ using @eqn:neff, and find $n_"eff" = 355$.

== Marginalizing over solar system ephemeris errors
<marginalizing-over-solar-system-ephemeris-errors>
// [figvision] imgs/factorised_psr_log10_A_p_ratios_kde_hd.png
// Log-likelihood difference Delta L_CRN^HD (log scale, 1e-1..1e1) versus 33 pulsars
// (labels rotated along the bottom, J1909-3744 ... J1713+0747). Two series: filled dark
// green circles = "Common noise distribution"; open black circles = "Fixed-amplitude".
// Most points cluster around 1 (0.5-1.5) from the middle onwards, with a few large
// outliers early: J2124-3358 ~4, J1713+0747 (leftmost) ~3.5, J0437-4715 ~2.5, and two
// deep minima near 0.25 (J1600-3053, J1744-1134 ~2.3). Filled and open points nearly
// coincide; the largest separation is at J1730-2304 (~1.8 vs 2.2) and J1713+0747
// (rightmost, 1.8 vs 2.4). Dashed vertical gridlines mark each pulsar.
#figure(scope: "parent", placement: auto, image("imgs/factorised_psr_log10_A_p_ratios_kde_hd.png", width: 95.0%),
  caption: [
    Likelihood ratio for Hellings--Downs (HD) spatial correlations over zero correlations for a $gamma = 13\/3$ process, at an amplitude of $log_10 A_(13\/3) = - 14.69$. Each point is calculated using the 29 pulsar pairs involving the labeled pulsar, and therefore, the points are not independent.
  ]
)
<fig:hdsupport>

An accurate model for the position of the center of the solar system is paramount for the timing precision required by PTA experiments. Systematic errors in the positions or masses of the planets can add additional signals to pulsar timing data sets that could manifest as both spatial correlations, but also as a common-noise process. The most recent SSE from JPL, DE440, used data from the Juno mission and updated very-long-baseline interferometry measurements of the outer planets, and is described as having reduced systematic uncertainties #cite(<DE440>).

We investigated if the amplitude of the apparent CRN could be affected by systematic uncertainties by perturbing the masses of outer planets and the orbital elements of the Jovian system with #smallcaps[Bayesepehem] models @Bayesephem, with respect to the ephemerides DE421, DE438, and DE440. We find that in all ephemerides considered, our data recovers a nonzero (95% confidence) perturbation to at least one orbital element of the Jovian system. We note that there was no Bayesian evidence for perturbations in the DE438 ephemeris using PPTA-DR2 #cite(<PPTA_dr2_crn>).

If we marginalize over these potential perturbations, we recover a steeper spectral index for the common-noise process, $gamma = 4.02_(- 0.41)^(+ 0.81)$, with a log amplitude $log_10 A^("CRN") = - 14.56_(- 0.39)^(+ 0.16)$ with DE440. All ephemerides considered give consistent constraints for this process, as shown by the posterior densities in #ref(<fig:bayesephem>). While we observe weak evidence for SSE errors in the form of nonzero perturbations, it is assumed that if such errors were a significant source of common noise, they would manifest as a dipole-like feature in the inter-pulsar correlations #cite(<Tiburzi-16>). Our data shows that the measured common-noise process is not dominated by dipolar correlations, and we have therefore assumed that the DE440 SSE is sufficiently accurate for the purpose of our GWB search.

= Discussion
<sec:discussion>
The properties of the common noise are consistent, within reported uncertainties, with measurements from recent works by the PPTA and the constituent members of the IPTA. A previous analysis by the PPTA @PPTA_dr2_crn found a common uncorrelated process with $gamma = 4.11_(- 0.41)^(+ 0.52)$ and $log_10 A^("CRN") = - 14.55_(- 0.23)^(+ 0.10)$. The EPTA @EPTA_dr2_crn have reported a similarly consistent result of $gamma = 3.78_(- 0.59)^(+ 0.69)$ and $log_10 A^("CRN") = - 14.29_(- 0.33)^(+ 0.25)$. NANOGrav @NG12.5yrSGWB identified a common-spectrum process with a steeper median spectral index, remaining consistent through relatively larger uncertainties reported with the value $gamma = 5.52_(- 1.76)^(+ 1.26)$ and $log_10 A^("CRN") = - 14.71_(- 0.15)^(+ 0.14)$. This work used only the five lowest-frequency components, and a shallower process was recovered when more components were considered. This may be due to high-fluctuation-frequency processes present in the data set, such as unmodeled pulse-shape variations #cite(<Shannon-16>)@NG12.5yrSGWB#cite(<PPTA_dr2_noise>).

The search for a common-spectrum process through the combination of a previous generation of these data sets by the IPTA @IPTA_dr2_gwb also finds a consistent signal most closely resembling that identified by the EPTA, $gamma = 3.90_(- 0.90)^(+ 0.90)$ and $log_10 A^("CRN") = - 14.29_(- 0.36)^(+ 0.14)$. The PPTA used the DE436 SSE for the previous analysis, while other PTAs used DE438. The spectral index marginally steepens when we marginalize over the SSE errors modeled by Bayesephem, and becomes more consistent with the prediction for the background predicted by SMBHBs.

This common spectral noise may be caused by the GWB, or it may represent one or more other signals masquerading as a background #cite(<Tiburzi-16>)#cite(<Zic-22>). If the purported common-spectrum noise is a genuine signature of an isotropic, stochastic GWB, then we can expect the IPTA to make a detection using the current-generation data sets #cite(<Siemens-13>). In this scenario we need to convincingly explain (1) why three of our pulsars offer negative likelihood support for the existence of the GWB, (2) why the current detected amplitude is higher than previous upper bounds, and (3) why the apparent amplitude of the GWB in our data is measured to be increasing with time.

There are several reasons why individual pulsars may not exhibit the signature of the GWB at the same amplitude. This includes interaction between the GWB signal and intrinsic pulsar timing noise (although the probability of this decreases as data spans increase), misspecification of the intrinsic noise parameters in the modeling, errors in the pulsar timing model, or natural variance in the SMBHB source distribution and anisotropy.

In the PPTA-DR3 data set, the pulsars most discrepant with the inferred common noise are PSRs~J1744$-$1134, J1603$-$7202, and J1713$+$0747. Two of these (PSRs~J1744$-$1134 and J1713$+$0747) are observed by all of the constituent member PTAs of the IPTA, and hence it is key to determine whether they show positive or negative support for the GWB in other data sets, and to explain any discrepancies. Previous analyses have revealed similar effects, including PSR~J1713$+$0747, which exhibited low dropout factors in the previous NANOGrav GWB search analysis #cite(<NG12.5yrSGWB>). This may be attributed in part to imperfect modeling of the known timing events observed in this pulsar #cite(<Lam-18>). PSR~J1603$-$7202 is observed as part of the MeerKAT PTA @mpta, which has shorter, but significantly more sensitive measurements of this pulsar at greater cadence. The MeerKAT PTA has fortnightly observations and should be sensitive to the noise processes at higher fluctuation frequencies.

// [figvision] imgs/crn_ephem_comp_be.png
// Broad-prior version of the ephemeris comparison: gamma (horizontal, 2..7) versus
// log10 A_CRN (vertical, -16.5..-13.5), with marginal histograms on top (gamma) and right
// (log10 A_CRN, filled green band). Three contour sets: DE440 (green), DE438 (orange),
// DE421 (blue), each with three nested levels. All are strongly elongated along a
// negative correlation from (2.7, -14.0) down to (7, -16.3); DE421's outer contour is
// the most extended in gamma, DE438's reaches the lowest amplitudes. The core of all
// three is near (3.8, -14.4). A dashed vertical line at gamma ~ 4.33 marks the
// reference; the top histogram peaks at 3.9-4.0 and has a long right tail to 7.
#figure(scope: "parent", placement: auto, image("imgs/crn_ephem_comp_be.png", width: 70.0%),
  caption: [
    As with @fig:curn_ephems, but with #smallcaps[Bayesephem] used to marginalize over potential solar system ephemeris errors. We measure $gamma = 4.02_(- 0.41)^(+ 0.81)$ and $log_10 A^("CRN") = - 14.56_(- 0.39)^(+ 0.16)$ for DE440 (green).
  ]
)
<fig:bayesephem>

The time-dependence of the signal amplitude is puzzling under an isotropic GWB model. Limits placed on the amplitude of the signal in earlier subsets of the data are inconsistent with high probability ($log_10 A_(13\/3) < - 14.69$ with $99.8 %$ confidence) with the amplitudes of the signal measured in later data, and the data set in the entirety. As shown in @fig:time_slices, the amplitude obtained with the entire data set is consistent with that from the most recent 9 yr data span. This result is heavily influenced by the most dominant pulsar, PSR~J1909$-$3744. The noise characteristics of this pulsar are unusual, and reflect the recovered properties of the common-spectrum noise. When considering the entire data set, there is only modest evidence for a deviation in the common-spectrum process from a pure power law.

If our results do not represent the signal from a GWB, then we must consider the implications. The three pulsars that offer negative likelihood support for the existence of a $gamma = 13\/3$ process at the measured common amplitude could therefore be representing an approximate upper bound on the amplitude of the background. The amplitude and spectral slope of the GWB is poorly constrained, and so lower amplitudes are still plausible. We reiterate the findings of the previous PPTA analysis @PPTA_dr2_crn that the characterization of the common noise can be affected by misspecification, and it is not necessarily a noise floor. That is, the sensitive pulsars with zero red noise can be outweighted in the likelihood by a population of pulsars with similar (but not necessarily identical) noise characteristics #cite(<Zic-22>). As it is currently defined, the measured common noise is consistent with the probability-weighted mean of the achromatic noise in our sample of pulsars, across all frequency components.

In the PPTA-DR3 data set, the number of pulsar pairs is not highly sensitive to the correlated component of the GWB at the amplitude of the purported CRN. Using autocorrelations and cross correlations, we find no Bayesian support, for or against, the presence of a GWB. However, using our technique that hierarchically analyses the correlations of the common noise alone, we find a $log_10 Delta cal(L)_("CRN")^("HD") = 1.1$ in support of the Hellings--Downs over zero correlations. We computed the significance of this likelihood ratio via sky scrambling, which provides a reliable false-alarm probability through noise generated with the data itself. It is unclear why the latter method provides greater support than the former. It could be that the former method requires the autocorrelated and cross-correlated noise to have the same amplitude. If the pulsar noise is misspecified, a mismatch in the amplitude of these two terms could degrade the sensitivity of the statistic. From this result, we conclude that future GWB searches should use (Bayesian) statistical methods that search for the GWB in the cross correlations alone #cite(<NG12.5yrSGWB>). Confirmation of consistency of the amplitude in the cross correlations and autocorrelations will be necessary to build confidence in using the entire PTA signal for astrophysical interpretation.

= Conclusions
<sec:conclusions>
We have presented a search for an isotropic stochastic gravitational-wave background using the third data release of the PPTA. We have measured the characteristics of a common-spectrum process in the array. Using the pulsar autocorrelations only, we measure $log_10 A^("CRN") = - 14.5$ and $gamma = 3.87$, when using the DE440 SSE. By marginalizing over potential errors in the SSE, we find that the inferred process steepens with $log_10 A^("CRN") = - 14.56$ and $gamma = 4.02$, although there is only weak evidence for these errors. At a fixed spectral index of $gamma = 13\/3$ we find $log_10 A_(13\/3)^("CRN") = - 14.69 plus.minus 0.05$, which translates to a constraint on the linear strain amplitude of $A = 2.04_(- 0.22)^(+ 0.25) times 10^(- 15)$ for the model of an isotropic GWB. By analyzing only the spatial correlations using a new technique, we show that the process at this amplitude is consistent with an isotropic GWB at a level that may occur by chance with a probability of $p lt.eq 0.014$. This false-alarm probability corresponds to a one-tailed test significance of approximately $2 sigma$.

However, some of the apparent characteristics of this common-spectrum process are surprising under the model of an isotropic GWB, including the following:

- #strong[Three pulsars disfavor the presence of a $upright(bold(bold(gamma) = 13\/3))$ process at the measured #emph[common] amplitude.] The measured common-spectrum process, as it is defined, is not necessarily a #emph[noise floor] as would be expected of a GWB. We have demonstrated that the spectral characteristics of the common noise are nearly identical to the probability-weighted mean of all achromatic pulsar noise, which may have significant contributions from intrinsic spin noise. However, these same pulsars appear to contribute positively to the Hellings--Downs correlations when the measured common-noise process is introduced, which may suggest misspecification in the noise models of the pulsars.

- #strong[The apparent amplitude of the common noise changes as a function of time.] This observation cannot be explained simply by the growing sensitivity of the data. For approximately the first half of our dataset, we appear to be in a nondetection regime, where only upper limits can be placed on the amplitude of a common-spectrum process at $gamma = 13\/3$. The 95% confidence upper limits derived from these early parts of our dataset are in tension with the current measurements. For example, in the first 9 yr slice, we find $log_10 A_(13\/3)^("CRN") < - 14.92$ at $95 %$ confidence and $log_10 A_(13\/3)^("CRN") = - 14.69$ is ruled out at $99.8 %$ confidence.

  Similar results have been observed by NANOGrav and the PPTA during previous GWB searches. However, the significance of this tension has been debated, owing to differences in the data sets (e.g. differing numbers of pulsars) and analysis procedures (e.g. choice of SSEs, priors, and single-pulsar noise models). For this analysis, we used identical models, priors, and inference techniques on all subsets of the data. We cannot determine the origin of this apparent nonstationarity as the recovered common-noise amplitude (measured as a function of time) is not necessarily determined by a distinct physical process.

- #strong[There is no Bayesian support, for or against, the Hellings--Downs spatial correlations using both the autocorrelations and cross correlations.] Yet by analyzing only the cross correlations, using our computationally efficient method, we observe some model support $log_10 Delta cal(L)_("CRN")^("HD") = 1.1$ for the Hellings--Downs ORF, from which we derive the significance $p$-value above. If the signal is genuine, this result may indicate excess noise affecting the autocorrelations, or other weaknesses of the model.

Some of these findings may be resolved by invoking anisotropy in the SMBHB source distribution, as simulations suggest a large variance is possible in the spectrum of a GWB #cite(<Rosado-15>). The recovered amplitude of the common noise is close to the maximum value expected of a GWB from a population of SMBHBs #cite(<Zhu-19>). The eccentricity of a nearby source or an unresolved local population may result in apparent the nonstationarity of the common noise. An analysis with a larger number of pulsars, for example under the IPTA, should be able to help answer these questions. It will also be interesting to investigate if other PTA observations of our #emph[quiet] pulsars (e.g. J1713+0747, J1744$-$1134) yield similar results under consistent noise models, and whether the temporal properties of the common noise and its upper limits are observed with independent sets of pulsars. Most importantly, it will be interesting to see if the global IPTA combination of the constituent PTA datasets strengthens the significance of any spatial correlations, resulting in an unambiguous detection.

#block[
Murriyang, the Parkes 64 m radio telescope is part of the Australia Telescope National Facility (#link("https://ror.org/05qajvd42")), which is funded by the Australian Government for operation as a National Facility managed by CSIRO. We acknowledge the Wiradjuri People as the Traditional Owners of the Observatory site. We acknowledge the Wurundjeri People of the Kulin Nation and the Wallumedegal People of the Darug Nation as the Traditional Owners of the land where this work was primarily carried out. We thank the Parkes Observatory staff for their support of the project for nearly two decades. We thank the International Pulsar Timing Array Detection Committee for their contributions to the IPTA GW search papers. We also thank CSIRO Information Management and Technology High Performance Computing group for access and support with the petrichor cluster. We acknowledge the use of the Python packages #smallcaps[numpy] @numpy, #smallcaps[scipy] @scipy, #smallcaps[chainconsumer] @chainconsumer, #smallcaps[corner] @corner, and #smallcaps[KDEpy] @kdepy for parts of this work. Part of this research was undertaken as part of the Australian Research Council (ARC) Centre of Excellence for Gravitational Wave Discovery (OzGrav) under grant CE170100004. R.M.S acknowledges support through ARC Future Fellowship FT190100155. Work at Naval Research Laboratory (NRL) is supported by NASA. SD is the recipient of an Australian Research Council Discovery Early Career Award (DE210101738) funded by the Australian Government. Y.L. acknowledges support of the Simons Investigator Grant 827103

]

#show bibliography: set text(size: 9pt)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 12pt, weight: "regular")
#bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)
