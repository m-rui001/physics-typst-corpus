#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 12pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.74cm, right: 2.85cm, top: 4.73cm, bottom: 3.05cm))
#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 1.33em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 1.33em)
#set figure.caption(position: bottom)
#set figure(placement: top)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)


#align(center)[
  #text(20.7pt, weight: "bold", [Evidence for neutrino emission from the nearby active galaxy NGC 1068])   #v(1.2em)
  #text(10.5pt)[IceCube Collaboration#footnote[The full list of collaboration members and their affiliations is included in the supplementary material] \ #super[\*]E-mail: analysis\@icecube.wisc.edu.]
  
]

#v(1.2em)



#block[
We report three searches for high energy neutrino emission from astrophysical objects using data recorded with IceCube between 2011 and 2020. Improvements over previous work include new neutrino reconstruction and data calibration methods. In one search, the positions of 110 a priori selected gamma-ray sources were analyzed individually for a possible surplus of neutrinos over atmospheric and cosmic background expectations. We found an excess of $79_(- 20)^(+ 22)$ neutrinos associated with the nearby active galaxy NGC 1068 at a significance of 4.2$thin sigma$. The excess, which is spatially consistent with the direction of the strongest clustering of neutrinos in the Northern Sky, is interpreted as direct evidence of TeV neutrino emission from a nearby active galaxy. The inferred flux exceeds the potential TeV gamma-ray flux by at least one order of magnitude.

]


#heading(level: 1, numbering: none)[High energy cosmic neutrinos]
<high-energy-cosmic-neutrinos>
The observation of the highest-energy cosmic protons and nuclei @Abraham:2004dt @ThePierreAuger:2015rma @AbuZayyad:2012kk has revealed the existence of powerful cosmic particle accelerators but not their nature and location in the universe. Due to the presence of interstellar magnetic fields, charged cosmic particles change direction during their propagation to Earth. Thus, the quest to identify cosmic accelerators relies on high-energy photons and neutrinos. Both travel along straight paths and are produced wherever cosmic rays interact with ambient matter, mainly protons, or photons in or near the acceleration sites. Depending on the environment in which these interactions occur, gamma rays can rapidly lose energy via several processes, such as pair-production through the interaction with lower energy photons. Similarly, above TeV energies gamma rays are strongly absorbed over cosmological distances through interactions with the extragalactic background light and the cosmic microwave background @DeAngelis:2013jna. Neutrinos are not affected by absorption during their cosmic journey, and thus are excellent probes of the most extreme cosmic accelerators. Being among the most energetic and enigmatic astrophysical sources in the universe, active galaxies, i.e. galaxies that host an Active Galactic Nucleus (AGN) @Padovani:2017zpf, have long been considered as candidate neutrino emitters @1977Berezinsky @1979ApJ...232..106E @1981MNRAS.194....3B @1989AandA...221..211M @Halzen:1997hw. The accretion flow of matter into a central supermassive black hole (SMBH) powers the AGN, which is typically surrounded by an obscuring, dusty torus, and thus the observable characteristics of the AGN depend on the viewing angle. For example, Seyfert II galaxies @Seyfert:1943 are assumed to be viewed edge on with the line of sight passing directly through the obscuring torus @Antonucci:1993. In some cases, the AGN can launch a strong, narrow jet of accelerated plasma. If such a jet is oriented close to the line of sight, the AGN is also called a blazar @Urry:1995mg.


The IceCube Neutrino Observatory @Aartsen:2016nxy, based at the Amundsen-Scott South Pole Station in Antarctica, is currently the world's largest detector for neutrinos. Its construction was completed on December 18, 2010. The telescope uses one cubic kilometer of the optically transparent glacial ice as a detection medium to measure the Cherenkov light emitted by relativistic charged particles. These secondary particles are created when neutrinos interact in or near the instrument. In total, 5160 digital optical modules (DOMs) are installed on 86 vertical cables ("strings"), spaced 125 meters apart, thus forming a three-dimensional array in the ice. Each DOM records the number of induced photo-electrons, or charges, as a function of time. In 2013, IceCube announced the detection of high-energy neutrinos of extra-terrestrial origin @Aartsen:2013jdh. The measured flux of these astrophysical neutrinos appears largely isotropic, equally distributed among flavors, and can be described by a single power-law energy distribution that extends from $tilde$10 TeV to PeV energies @Aartsen:2016xlq @Aartsen:2020aqd @Abbasi:2020zmr @IceCube:2021rpz @PhysRevD.104.022002, but its origin remains largely unresolved. To date the most compelling evidence of a source of high-energy cosmic neutrinos was reported following the space and time coincidence of a high-energy IceCube neutrino @Aartsen:2016lmt with the gamma-ray flaring blazar TXS 0506+056 @IceCube:2018dnn @IceCube:2018cha @Padovani:2019xcv. TXS 0506+056 has recently been shown to host a standard accretion disk and a dusty torus, which has the peculiarity to be also an emitter of high-energy radiation and, possibly, cosmic rays @Padovani:2019xcv. Additionally, a recent IceCube study @Aartsen:2019fau suggests a correlation of IceCube neutrinos with a catalog composed of 110 known gamma-ray emitters at a significance of 3.3$thin sigma$. The main contributors are the active galaxy NGC 1068 and the blazars TXS 0506+056, PKS 1424+240 and GB6 J1542+6129. The significance of the neutrino excess from the direction of NGC 1068 was reported as 2.9$thin sigma$ @Aartsen:2019fau.


Here, we present an improved search for neutrino point sources based on new data processing, data calibration, and event reconstruction methods that lead to a more precise neutrino event characterization and thereby to better signal and background discrimination, as well as a more accurate estimate of the neutrino fluxes from potential neutrino sources.


#heading(level: 1, numbering: none)[Searching the Northern Sky for point-like neutrino emission]
<searching-the-northern-sky-for-point-like-neutrino-emission>
In this paper, we present analyses of data collected with IceCube between May 13, 2011, and May 29, 2020. This period covers all the data recorded with the full 86-string detector configuration. In contrast, a recently reported result from searches for cosmic neutrino sources@Aartsen:2019fau also included the partial detector configurations with fewer strings, going back to 2008, and stopping in spring 2018. In this analysis, we only use the full detector data as our methods depend on uniformly processed data. We have verified that the high-statistics Monte Carlo dataset agrees very well with the observed data. The IceCube dataset @Aartsen:2018ywr, constructed using selection criteria presented in @Aartsen:2016xlq, has been reprocessed uniformly, removing the data sample fragmentation in earlier results, aligning different data-taking conditions and calibrations, and improving event reconstructions and resolutions @note:Suppl-Mat. Specifically, for this reprocessing we consistently apply the most accurate version of the directional track reconstruction method (#emph[SplineReco] algorithm @AMANDA:2003vtt @IceCube:2021oqo @note:Suppl-Mat) to all events recorded throughout the entire data taking period @note:Suppl-Mat. Here, we use the latest calibration information that increase the accuracy in the extraction of the charges at each DOM and in the corresponding arrival times of Cherenkov photons, thus leading to small changes in the reconstructed event energies, and in some cases also to the reconstructed event directions @note:Suppl-Mat. To ensure a uniform detector response, DOMs of the DeepCore sub-array, commonly used to study $lt.tilde 100 thin upright("GeV")$ neutrinos, are excluded @Aartsen:2016xlq. The resulting dataset, optimised for $nu_mu$-induced track-like events, has a total livetime of 3186 days. The searches presented in this work focus on the Northern Sky ($delta gt.eq - 3^compose$), where IceCube sensitivity to individual astronomical objects is maximal. IceCube uses the Earth as a passive cosmic muon shield and as target material for neutrinos. Hence, by selecting upward-going events we efficiently reject the atmospheric muon background, which contributes less than $0.3 "%"$ to the final event sample @Aartsen:2016xlq. A total of around 670,000 neutrino-induced muon tracks pass the final event selection criteria @Aartsen:2016xlq. However, only a small fraction of these events originate from neutrinos produced in astrophysical sources. The vast majority arises from the decay of mesons which are produced in the interaction of cosmic radiation with nuclei of the Earth's atmosphere. To discriminate neutrinos that originate from individual astrophysical sources from the background of atmospheric and diffuse astrophysical neutrinos, we employ the maximum-likelihood method and likelihood ratio hypothesis testing based on the estimated energy, direction, and angular uncertainty of each event @note:Suppl-Mat. The median angular resolution of the single neutrino arrival direction, composed of reconstruction error and stochasticity of kinematic processes, is 1.2$""^compose$ at 1 TeV, 0.4$""^compose$ at 100 TeV, and 0.3$""^compose$ at 1 PeV. For the source emission, we assume in the tests a generic power-law energy spectrum, $Phi_(nu_mu + macron(nu)_mu) ( E_nu ) = Phi_0 dot.op ( E_nu / E_0 )^(- gamma)$, with $E_0 = 1 thin$TeV and the spectral index $gamma$ and the flux normalization $Phi_0$ as free parameters @note:Suppl-Mat. This corresponds to two correlated model parameters which are expressed as a pair ($mu_("ns")$, $gamma$), where $mu_("ns")$ is the mean number of astrophysical neutrino events associated with a given point in the sky. Using the declination-dependent effective area of the detector and the spectral index $gamma$, $mu_("ns")$ can be directly converted to $Phi_0$. Hence, the tuple of $mu_("ns")$ and $gamma$ fully determines the flux of muon neutrinos $Phi_(nu_mu + macron(nu)_mu)$ at any given energy.


Three different searches are presented here. The first search consists of three discrete scans of the Northern Sky to identify the location of the most significant excess of high-energy neutrino events using three different hypotheses on the spectral index: $gamma$ as a free parameter and $gamma$ fixed to 2.0 and 2.5. The other two tests are done on a list of 110 astronomical objects, all located in the Northern Hemisphere: one is the search for the most significant candidate neutrino source in the list, the second consists of a binomial test to evaluate the significance of observing an excess of $k$ sources with local p-value below or equal to a certain threshold, with $k$ going from 1 to 110. Similar to the sky scan, the binomial test is also repeated under the three spectral index hypotheses. All these searches are performed in the Northern Hemisphere from declination $delta = - 3^compose$ to $delta = 81^compose$. Higher declinations are excluded because low energy events tend to line-up completely with the strings of IceCube, complicating the numerical modeling of the signal and background in the likelihood. The resulting loss of sky coverage is less than $1 "%"$.


All analysis methods, including the selection of the hypotheses to be tested, were formulated #emph[a priori]. The analysis performance was evaluated using simulations, as well as randomized experimental data. The local p-values are determined as the fraction of simulated background-only experiments, yielding a test statistic greater than or equal to the one obtained from the actual experimental data. The global p-value is determined from the smallest local p-value after correcting for multiple testing @note:Suppl-Mat. It is used to assess the evidence the data provide against the background-only assumption, i.e., that the data consist purely of atmospheric and isotropic cosmic neutrinos.


The discrete scan of the sky maximizes the signal and background likelihood function at each point on a $tilde (0.2^compose times 0.2^compose)$ grid, thus obtaining the local value of the test statistic, the best-fit value of the mean number of astrophysical neutrino events ($hat(mu)_("ns")$), and the spectral index ($hat(gamma)$). The scan is repeated with fixed spectral indices $gamma$ = 2.0 and $gamma$ = 2.5 in order to reduce the impact of background fluctuations which arise from the conventional atmospheric neutrinos in the dataset. The conventional atmospheric spectrum follows a power law with $gamma approx 3.7$ and hence those fluctuations typically yield soft spectral indices with $gamma gt.tilde 3$. Fixing the spectral index therefore increases the sensitivity to astrophysical sources with harder spectra. For the 20 most significant hot-spots in each of the three searches, the vicinity is scanned with increased resolution of $tilde (0.03^compose times 0.03^compose)$ on a square grid of total size 1.5$""^compose times$ 1.5$""^compose$. Overall, the hottest spot is identified in the first scan with free spectral index at right ascension 40.69$""^compose$ and declination 0.09$""^compose$ (J2000) with $hat(gamma) = 3.2$ and $hat(mu)_("ns") = 81$.


The full skymap is shown in @fig:skymap. At the location of the hottest spot, the local p-value of 5 $times$ 10$""^(- 8)$ corresponds to a local significance of 5.3$thin sigma$. After including a penalty for the multiple tests performed, i.e. asking how likely it is to observe an equal or larger significance when scanning many independent positions in the sky under the three spectral index hypotheses, the global p-value corresponds @note:Suppl-Mat to a significance of 2.0$thin sigma$ and therefore is not significant when the entire Northern Sky is scanned without additional prior information. A high-resolution scan around the best-fit position of the hottest spot is shown in @fig:hotspot.


As part of the various inspections to be carried out #emph[a posteriori], we also searched for astrophysical counterparts in close proximity with the direction of the five locally most significant spots in each of the three skymaps (reported in Tab. 2 @note:Suppl-Mat). We note that the nearby Seyfert I galaxy NGC 4151 @Seyfert:1943 is located at $tilde$0.18 degrees distance from the fourth-hottest spot in the map obtained with $gamma$=2.5. Because possible neutrino emission from NGC 4151 is not one of the hypotheses that were formulated for this work, we cannot estimate a global p-value for this coincidence.


// [figvision] imgs/fig1.png
// This panel displays a skymap of the Northern Hemisphere using an Equatorial coordinate system with a
// Hammer-Aitoff projection. The horizontal axis represents Right Ascension, ranging from 24 hours on the left to
// 0 hours on the right. The vertical axis indicates Declination, marked at intervals of +25 degrees up to +75
// degrees. A color bar below the map quantifies the local p-value as negative log base 10, scaling from 1 (light
// green/white) to 7 (dark purple/black). The background texture shows statistical fluctuations in significance.
// Three specific objects are highlighted with black circles: PKS 1424+240 near the center, TXS 0506+056 in the
// lower right quadrant, and NGC 1068 near the bottom right edge. These circled regions represent the most
// significant point source candidates identified in the scan.
#figure(image("imgs/fig1.png", width: 100%),
  caption: [
    #strong[Skymap of the scan for point sources in the Northern Hemisphere]. The color scale represents the local p-value obtained from the maximum likelihood analysis evaluated (with the spectral index as free fit parameter) at each location in the sky, shown in Equatorial coordinates with Hammer-Aitoff projection. The black circles indicate the three most significant objects in the source list search. The circle of NGC 1068 also coincides with the overall hottest spot in the Northern Sky.
  ]
)
<fig:skymap>



Searching the entire Northern Hemisphere entails a strong penalty due to testing multiple locations. A standard way to mitigate this trial factor is to reduce the search to a list of #emph[a priori] selected positions in the sky based, for example, on known gamma-ray emission @Gaisser:2016uoy. Such a procedure has been followed by IceCube since the first analysis @IceCube:2009hni, and revised in 2018 using recent multi-wavelength information @Aartsen:2019fau. No indication of neutrino emission from NGC 1068 was noticeable at the time @Aartsen:2016oji when the selection method of candidate sources was updated @Aartsen:2019fau. To avoid confirmation bias the procedure from @Aartsen:2019fau was kept to select a total of 110 objects within the declination range of this analysis, $- 3^compose lt.eq delta lt.eq 81^compose$. The number of 110 objects was chosen such that a local $5 thin sigma$ detection will yield a final result above $4 thin sigma$ after accounting for trials. To select the 110 astronomical objects, we consider the gamma-ray flux above 1 GeV of the #emph[Fermi]-LAT sources in the 4FGL-DR2 catalog @Fermi-LAT:2019yla weighted by the IceCube sensitivity. The final catalog contains 59 BL Lacs, 34 FSRQs, 2 blazars of uncertain type, 5 AGNs, 9 galaxies, and one Galactic source from the TeVCAT catalog @2008ICRC....3.1341W, see also @note:Suppl-Mat. We do not further impose or require any relationship between the observed gamma-ray flux and the hypothesized neutrino flux when testing the selected objects for an association to neutrinos @note:Suppl-Mat.


// [figvision] imgs/fig2a.png
// This panel is a two-dimensional heatmap plot showing the sky region around a significant detection spot. The
// horizontal axis represents right ascension (r.a.) in degrees, ranging from 41.2 on the left to 40.2 on the
// right. The vertical axis represents declination (dec.) in degrees, spanning from -0.4 to 0.6. A color bar at
// the top indicates the negative logarithm of the local p-value, where lighter colors correspond to lower
// significance and dark blue or black corresponds to high significance values up to 7. A white plus sign marks
// the best-fit position of the hot spot near coordinates 40.7, 0.1. A red star marks the location of NGC 1068 at
// approximately 40.65, 0.0. Two white contours surround the center: an inner solid line labeled "68%" and an
// outer dashed line labeled "95%", representing confidence regions for the localization.
// [figvision] imgs/fig2b.png
// Panel a is a two-dimensional contour plot mapping the sky region around the most significant spot in the
// Northern Hemisphere. The horizontal and vertical axes represent angular coordinates, though specific units are
// not visible in this crop. A yellow cross marks the precise location of the hottest spot, while a red star
// indicates the position of NGC 1068. Overlaid on the background intensity map are black contour lines
// representing confidence regions for the hot spot localization; solid lines denote the 68% confidence interval,
// and dashed lines denote the 95% confidence interval. The contours form an elliptical shape centered near the
// yellow cross, narrowing toward the center to indicate higher statistical certainty at the peak emission point
// relative to the surrounding diffuse background. Panel b is a one-dimensional histogram plotting event counts
// against squared angular distance from the source center. The vertical axis is labeled "#Events" ranging from 0
// to 80, and the horizontal axis is "{}^2 [deg^2]" ranging from 0 to approximately 4.5. Black dots with vertical
// error bars represent observed data points. An orange filled area represents the estimated background
// contribution, which remains relatively flat around 45 events. A blue filled area at the bottom shows the
// expected signal component, which peaks sharply near zero and decays rapidly. A grey line traces the total
// model prediction (signal plus background), closely matching the data trend across the range.
#figure([#box(image("imgs/fig2a.png", width: 49.0%))
  #box(image("imgs/fig2b.png", width: 49.0%))],
  caption: [
    #strong[The sky region around the most significant spot in the Northern Hemisphere and NGC 1068]. The left plot shows a fine scan of the region around the hottest spot. The spot itself is marked by a yellow cross and the red star shows the position of NGC 1068. In addition, the solid and dashed contours show the 68\% (solid) and 95\% (dashed) confidence regions of the hot spot localization. The right plot shows the distribution of the squared angular distance between NGC 1068 and the reconstructed event direction. From Monte Carlo we estimate the background (orange) and the signal (blue) assuming the best-fit spectrum at the position of NGC 1068. The superposition of both components is shown in gray and provides an excellent match to the data (black). Note that this representation of the result neglects all the information on the energy and angular uncertainty of the events that is used in the unbinned maximum likelihood approach.
  ]
)
<fig:hotspot>



Among the 110 astronomical objects tested, NGC 1068 is the most significant with a local p-value of $1 times 10^(- 7)$ ($5.2 thin sigma$) and with best-fit values of spectral index $hat(gamma)$ = 3.2 and mean number of signal events $hat(mu)_("ns")$ = 79. NGC 1068 is contained within the 68\% confidence region around the hottest spot in the Northern Sky, located at a distance of 0.11$""^compose$. Thus, the hottest spot location is consistent with possible neutrino emission from NGC 1068 (@fig:hotspot). After correcting for having tested the 110 sources in the catalog, the global p-value for NGC 1068 is $1.1 times 10^(- 5)$, corresponding to a significance of 4.2$thin sigma$. \
To investigate the source catalog for an excess of $k$ sources with local p-value below or equal to a certain threshold, we also perform a binomial test @note:Suppl-Mat, as defined #emph[a priori]. By scanning the p-value threshold, we find the smallest background probability for an excess of $k = 3$ sources, tested under the free spectral index hypothesis, with local p-values smaller or equal to $4.6 times 10^(- 6)$. This results in a local significance of 3.7 $sigma$, a small increase with respect to what was reported in @Aartsen:2019fau that is independent of the increase of the significance at the location of NGC 1068. After correcting for having tested three different spectral index hypotheses, we obtain a final post-trial significance of 3.4$thin sigma$ for the binomial test. Besides NGC 1068, the other two objects contributing to the excess are the blazars PKS 1424+240 and TXS 0506+056, for which we find potential neutrino emission with local significance of 3.7$thin sigma$ and 3.5$thin sigma$, respectively. We emphasize that the significance of TXS 0506+056 reported here relates to a time-integrated signal, whereas previous analyses have provided evidence for transient emission @IceCube:2018dnn @IceCube:2018cha @Padovani:2018acg. Such emission has not been tested in this work, which is instead optimized to measure possible steady neutrino fluxes over the whole period of the data taking. Compared to the methods presented here, a search for transient emission has a lower effective background. The total number of contributing candidate sources ($k = 3$) in the binomal test has been reduced by one compared to @Aartsen:2019fau. While the local significance of PKS 1424+240 increased from $3.0 thin sigma$ to $3.7 thin sigma$, the local significance of GB6 J1542+61 decreased from $2.9 thin sigma$ to $2.2 thin sigma$, falling now below the threshold corresponding to the best binomial p-value. The results of all three searches are summarized in Tab. #ref(<Tab:final-results>, supplement: none). Additional details can be found in @Tab:final-results.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Test type], [Pre-trial p-value (p$""_(l o c a l)$)], [Post-trial p-value (p$""_(g l o b a l)$)],),
    table.hline(),
    [Northern Hemisphere scan], [$5.0 times 10^(- 8)$ (5.3$thin sigma$)], [$2.2 times 10^(- 2)$ (2.0$thin sigma$)],
    [List of candidate sources, single test], [$1.0 times 10^(- 7)$ (5.2$thin sigma$)], [$1.1 times 10^(- 5)$ ($4.2 thin sigma$)],
    [List of candidate sources, binomial test], [$4.6 times 10^(- 6)$ (4.4$thin sigma$)], [$3.4 times 10^(- 4)$ (3.4$thin sigma$)],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [#strong[Summary of final p-values.] For each of the three tests performed in this work, we report the local and global best p-values. ]
  , kind: table
  )
<Tab:final-results>



#heading(level: 1, numbering: none)[Neutrino emission from the direction of NGC 1068]
<neutrino-emission-from-the-direction-of-ngc-1068>
A high-resolution scan around the most significant spot in the Northern Hemisphere is shown in @fig:hotspot (left), with NGC 1068 located inside the 68\% confidence region. The excess at the position of NGC 1068 is produced by $hat(mu)_("ns")$=79$""_(- 20)^(+ 22)$ events above the expectation from the atmospheric and diffuse astrophysical neutrino backgrounds. The systematic error on $hat(mu)_("ns")$ is around $2$ events @note:Suppl-Mat. Among the 79 most contributing events, 63 were recorded during the time period that overlaps with the previous analysis @Aartsen:2019fau and all of them contributed to the previous result. @fig:hotspot shows the distribution of all events in the vicinity of NGC 1068, as well as the confidence contours for the source location obtained in this work. The measured spectral index is $hat(gamma) = 3.2_(- 0.2)^(+ 0.2)$ with an estimated systematic uncertainty of $0.07$ @note:Suppl-Mat and is thus consistent with the previous result reported in @Aartsen:2019fau. Systematic uncertainties arise mainly from the modeling of the photon propagation in the glacial ice, e.g. scattering and absorption, as well as the efficiency with which they are detected by the IceCube optical modules. Systematic uncertainties are sub-dominant to statistical ones for directional track reconstructions @note:Suppl-Mat, but have a non-negligible effect on the energy reconstructions, as the observed light yield is altered. The impact of these systematic uncertainties on the measured neutrino spectrum is estimated by analyzing simulated data, assuming a source with flux equal to the one measured for NGC 1068 but varying ice and detector properties correspondingly @note:Suppl-Mat.


A detailed characterization of the source spectrum is shown in @fig:profile, where we report the likelihood as a function of the model parameters ($Phi_0$, $gamma$) evaluated at the coordinates of NGC 1068. The conversion of $hat(mu)_("ns")$ to the flux $Phi_0$ also accounts for the contribution from tau neutrino interactions which produce muons in the final state assuming an equal neutrino flavor ratio. The best-fit flux averaged over the data-taking period at a neutrino energy of 1 TeV is $Phi_(nu_mu + macron(nu)_mu)^(1 thin "TeV")$ = $( 5.0 plus.minus 1.5_(s t a t) plus.minus 0.6_(s y s) ) times 10^(- 11) thin "TeV"^(- 1) . "cm"^(- 2) . s^(- 1)$. Here, the systematic uncertainty is estimated by varying the flux normalization under different ice and detector properties such that we reproduce the experimental result of $hat(gamma)$ and $hat(mu)_("ns")$ in the median case.


// [figvision] imgs/fig3.png
// The central panel is a two-dimensional contour plot displaying the joint confidence regions for flux
// parameters. The horizontal axis represents the Spectral Index, ranging from 2.5 to 3.5, while the vertical
// axis denotes the neutrino flux ^{1 {TeV}}_{_+{}_} in units of 10^{-11} { TeV}^{-1} { cm}^{-2} { s}^{-1},
// spanning approximately 1 to 11. A black cross marks the best-fit value at coordinates roughly (3.2, 5). Two
// nested contours define the confidence levels: an inner solid line labeled "68%" and an outer dashed line
// labeled "95%". These are superimposed on a blue density gradient that darkens toward the center. The top side
// panel displays the one-dimensional profile likelihood for the spectral index. The vertical axis measures -2
// {L} from 0 to 4. A black curve forms a parabolic shape with its minimum at zero. A light gray shaded region
// highlights the interval corresponding to the 68% confidence level, centered around the best-fit value of
// approximately 3.2. The right side panel shows the one-dimensional profile likelihood for the neutrino flux
// parameter. The vertical axis tracks -2 {L} from 0 to 15. A black curve opens horizontally, indicating the
// likelihood variation. A light gray shaded area marks the 68% confidence interval along the vertical axis,
// centered near the flux value of 5. A color bar adjacent to this panel indicates the likelihood magnitude,
// scaling from white at 0 to dark blue at 15.
#figure(image("imgs/fig3.png", width: 85.0%),
  caption: [
    #strong[Profile likelihood scan for the flux parameters of NGC 1068]. The cross shows the best-fit value, solid and dashed lines represent 68\% and 95\% confidence levels derived from Wilks' Theorem, respectively. The side panels show the corresponding one-dimensional profile likelihoods. All contours include only statistical uncertainties.
  ]
)
<fig:profile>



The unbroken power-law assumption used as spectral model in the likelihood is defined over the entire energy range of the dataset. However, the main contribution to the excess and thus the measured spectral index and flux normalization comes from neutrinos in an energy range from 1.5 TeV to 15 TeV. This energy range is defined as the range that contributes 68\% to the total test statistic value of the measurement. Outside of this energy range, the data does not strongly constrain the inferred flux properties. Our results significantly strengthen the suggestive results reported in @Aartsen:2019fau, where this source was also identified as the strongest association, albeit at reduced significance (2.9$thin sigma$) and larger separation from the hottest spot in the Northern sky (0.35$""^compose$).


The increased significance of the neutrino hotspot in spatial coincidence with NGC 1068 can be traced to several (sometimes small) improvements applied to the entire sample before unblinding the data. The principle contributions come from 1) the new data processing, 2) the new calibration methods, and 3) the improved analysis methods and tools including a significantly more accurate characterization of IceCube point spread function and better estimation of both the event energy and angular uncertainty @note:Suppl-Mat.


For instance, a reduced significance of $3.8 thin sigma$ would have been obtained had we analyzed this sample of events based on the same up-to-date data calibration methods and associated event directions, but without these new methods. This difference is expected and can be reproduced in Monte Carlo studies, see @note:Suppl-Mat. Incrementally removing the most significant events from the hot spot reveals that the excess persists, which demonstrates that the hot spot is not dominated by one or a few single events but is the result of an accumulation of neutrinos from this particular direction @note:Suppl-Mat. The neutrino events contributing to the excess from NGC 1068 have been visually inspected, and show well-reconstructed horizontal $tilde$TeV energy track events with no sign of unexpected contamination or anomalies @note:Suppl-Mat. Out of the 20 events contributing most to the results presented here, 19 were included in the previous analysis @Aartsen:2019fau. Although the hot spot is thus dominated by the same neutrinos, the new data reprocessing and improved modeling of the likelihood function slightly change the precise evaluation of the events' characteristics and therefore their contribution to the likelihood function. These small but consistent recalibrations and the effects of the refined reconstructions align the events more precisely with the direction of NGC 1068, thus significantly strengthening the neutrino association @note:Suppl-Mat.


#heading(level: 1, numbering: none)[NGC 1068 as a neutrino source]
<ngc-1068-as-a-neutrino-source>
The signal identified during the 3186 days period of IceCube data taking in the complete configuration consists of an estimated 79$""_(- 20)^(+ 22)$ muon-neutrino events that are present in addition to the expected background. Scaling the 1 TeV muon neutrino flux normalization $Phi_(nu_mu + macron(nu)_mu)^(1 thin upright("TeV"))$ = $( 5.0 plus.minus 1.5_(s t a t) ) times 10^(- 11) thin "TeV"^(- 1) . "cm"^(- 2) . s^(- 1)$ by a factor of 3 we obtain the #emph[all-flavor] neutrino flux, assuming equal contributions from all flavors, e.g. from pion decay dominated sources and neutrino oscillations over cosmic distances @Bustamante:2015waa @Arguelles:2015dca. In the following we adopt a distance of 14.4 Mpc for NGC 1068 @Bland-Hawthorn1997, as most commonly used in the literature, but note that there is some uncertainty with values ranging between $10.3 plus.minus 3 thin "Mpc"$ (from the NASA/IPAC Extragalactic Database) using the Tully-Fisher relation and 16.5 Mpc @2020A-A...634A...1G&A...634A...1G. The resulting redshift-corrected isotropic equivalent neutrino luminosity in the neutrino energy range from 1.5 TeV to 15 TeV is $L_nu$ = $( 2.9 plus.minus 1.1_(s t a t) ) times 10^42 thin "erg" . s^(- 1)$. This is significantly higher than the isotropic equivalent gamma-ray luminosity observed by #emph[Fermi]-LAT of $1.6 times 10^41 thin "erg" . s^(- 1)$ in the energy range between 100 MeV and 100 GeV @Fermi-LAT:2019pir, and higher than the upper limits recently reported by the MAGIC collaboration @Acciari:2019raw (see @fig:sed).


// [figvision] imgs/fig4.png
// Panel a presents a log-log plot displaying the spectral energy distribution of NGC 1068. The horizontal axis
// represents Energy in GeV, ranging from 10^{-15} to 10^6. The vertical axis indicates flux density (E^2) in TeV
// cm^{-2} s^{-1}, spanning 10^{-14} to 10^{-9}. Gray points with error bars denote archival multi-frequency
// measurements across lower energies. Dark green crosses represent Fermi-LAT gamma-ray data, while light green
// downward-pointing triangles indicate MAGIC upper limits at higher energies. Two theoretical neutrino models
// are overlaid: a solid gray line for Murase et al and a shaded light blue region for Inoue et al. A dark blue
// shaded band highlights the best-fit neutrino spectrum derived from IceCube data, peaking around 10^3 GeV.
#figure(image("imgs/fig4.png", width: 100.0%),
  caption: [
    #strong[Spectral energy distribution of NGC 1068]. Gray points show publicly available multi-frequency measurements @Chang:2019cdu. Dark and light green error bars refer to gamma-ray measurements from #emph[Fermi]-LAT @Ballet:2020hze @Fermi-LAT:2019yla and MAGIC@Acciari:2019raw, respectively. The solid, dark blue line shows the best-fit neutrino spectrum, and the corresponding blue band covers all powerlaw neutrino fluxes that are consistent with the data at $95 "%"$ C.L. It is shown in the energy range between 1.5 TeV and 15 TeV where the flux measurement is well constrained. Two theoretical AGN core models are shown for comparison: The light blue shaded region and the gray line show the NGC 1068 neutrino emission models from @Inoue:2019yfs and @Murase:2019vdl, respectively. Additional details on the model construction of the light blue shaded region can be found in @Inoue2019abc.
  ]
)
<fig:sed>



High-energy neutrinos are generated in or near astronomical sources as decay products of charged mesons produced in proton-proton interactions @Kelner:2006tc, or interactions between protons and low energy ambient radiation @Kelner:2008ke (for a review see @Ahlers:2018fkn). Along with those neutrinos, gamma rays are produced in the same processes through the decay of neutral mesons. After production, the neutrinos escape the site without further interactions. The photons, on the other hand, are prone to reactions depending on the optical depth of the environment. Hence the connection between neutrinos and gamma rays is highly dependent on the astrophysical environment in which the accelerated cosmic particles interact. NGC 1068 @Seyfert:1943 is one of the closest and best-studied Seyfert II galaxies. It hosts a Compton-thick AGN @Ricci:2015rzl @Marinucci:2015fqo @Zaino:2020elj, is also known for vigorous starburst activity @Romeo:2016hms @Eichmann:2015ama and outflows @1990ApJ...355...70C, and has therefore been discussed as a potential source of high-energy neutrinos@Shapiro:1979a @Yoast-Hull:2013qfa @Lamastra:2016axo. Recent neutrino emission models@Inoue:2019yfs @Murase:2019vdl renewed the interest in the production of neutrinos and gamma-rays within the heavily obscured environment around its core @Shapiro:1979a @Shapiro:1983a. In those models the supermassive black hole in the galaxy center provides the acceleration conditions, and the intrinsic X-ray photons generated through photon Comptonization from the accretion disk in the hot plasma above the disk, the so-called corona, provide the conditions for the production of neutrinos and at the same time also for the strong absorption of gamma rays.


// [figvision] imgs/fig5.png
// Panel a is a log-log plot comparing neutrino fluxes against energy. The x-axis represents Neutrino Energy (E_)
// in GeV, ranging from 10^3 to 10^7. The y-axis represents the differential flux (E_^2 _{+{}}) in units of TeV
// cm^{-2} s^{-1}, spanning 10^{-13} to 10^{-9}. A blue shaded band with dashed edges, representing NGC 1068,
// slopes downward from approximately 10^{3.5} GeV at a flux of 10^{-10.5} to 10^{4.5} GeV at 10^{-11.5}. An
// orange shaded band for TXS 0506+056 appears lower and flatter between 10^{4.5} and 10^{6.5} GeV, centered
// around a flux of 10^{-12.5}. A light grey band labeled "Astro. _" shows a gentle decline across the
// high-energy range from roughly 10^{4.5} to 10^{6.5} GeV, starting near 10^{-9.5}. Overlaid on this are dark
// red data points with error bars labeled "Astro. _e _", showing measured values or upper limits that generally
// track or sit below the grey diffuse flux band.
#figure(image("imgs/fig5.png", width: 100%),
  caption: [
    #strong[C]omparison of point-source fluxes for NGC 1068 and TXS 0506+056 from this analysis with the total diffuse astrophysical neutrino flux@Aartsen:2020aqd @Aartsen:2016xlq. Fluxes are given for a single flavor of neutrinos and anti-neutrinos assuming equal flavour ratio. The bands provide simultaneous coverage at 68\% C.L.
  ]
)
<fig:contribution_to_diffuse>



A comparison of the neutrino flux measurement and two recent model estimations @Inoue:2019yfs @Murase:2019vdl are reported in @fig:sed. Since NGC 1068 appears as a point-like neutrino source to IceCube, we cannot pinpoint directly which of its components is responsible for the neutrino emission.


The evidence of neutrino emission from NGC 1068 suggests that AGN could make a substantial contribution to the diffuse neutrino flux observed by IceCube. However, @fig:contribution_to_diffuse demonstrates that in their respective energy ranges the sources NGC 1068 and the blazar TXS 0506+056 contribute no more than $tilde 1 "%"$ to the overall diffuse flux of astrophysical neutrinos. A more quantitative comparison is challenging: for NGC 1068 the estimated flux ranges to energies not well covered by the measurements of the total diffuse flux, and, with a best-fit spectral index of $hat(gamma) = 3.2_(- 0.2)^(+ 0.2)$, the spectrum of NGC 1068 appears to be softer than the diffuse flux with $gamma = 2.53_(- 0.07)^(+ 0.07)$ @Aartsen:2020aqd. Nonetheless, it is evident that there is room for both additional bright and nearby sources, like NGC 1068, as well as a large population of faint sources. For example, the nearby Seyfert I galaxy NGC 4151 has been suggested as one plausible candidate @Inoue2019abc @PhysRevLett.66.2697 @1993ASIC..394...53S. Depending on the luminosity function and cosmological evolution of the underlying population of sources, the contribution from many faint sources at large distances ($z gt.tilde 1$) to the diffuse neutrino flux can be large @Murase:2016gly @Capel:2020txc.


The presented evidence of neutrinos from NGC 1068 is insufficient to further characterize the underlying source population, for example its luminosity function and cosmological evolution. However, the observation provides some limited information on the density $rho$ of objects with similar or greater neutrino luminosity in the local universe -- independent of the precise emission processes. Considering one source within a spherical volume of radius 14.4 Mpc @Bland-Hawthorn1997, the distance to NGC 1068, would lead to $rho approx 10^(- 4) thin "Mpc"^(- 3)$. Given that this density estimate relies on the observation of a single source, which may or may not be representative of the population, its uncertainty towards smaller densities is expected to be large and is difficult to quantify. Simulations of populations with various luminosity functions @Tung:2021npo show that it can reach well beyond an order of magnitude. Nevertheless, despite the intrinsic uncertainty in estimating the density, the nearness of NGC 1068 compared to TXS 0506+056, which is approximately 100 times farther away, indicates that there are at least two populations of neutrino sources that differ in both density and luminosity by orders of magnitude.


Thanks to new reprocessing, recalibration and reconstruction of the IceCube data, we have presented here experimental evidence of neutrino emission from the active galaxy NGC 1068 at the 4.2$thin sigma$ level of significance, which can be interpreted as a smoking gun signature of hadronic particle acceleration at this source. The evidence is supported by phenomenological scenarios@Inoue:2019yfs @Murase:2019vdl that also predict a significant absorption of gamma-ray photons. Including the blazar TXS 0506+056 @IceCube:2018cha, the active galaxy NGC 1068 is the next compelling source of high-energy neutrinos, albeit with possibly very different emission mechanisms, pointing to a population of neutrino sources with obscured gamma-ray emission.








#heading(level: 1, numbering: none)[Supplementary Materials]
<supplementary-materials>
Supplemental materials are freely available through the Science web portal. \
#link("https://www.science.org") \
#link("https://www.science.org/doi/10.1126/science.abg3395") \
#link("https://www.science.org/doi/suppl/10.1126/science.abg3395/suppl_file/science.abg3395_sm.pdf") \
Supplemental materials include:

- Materials and Methods

- Supplementary Text

- Figs. S1 to S30

- Tables S1 to S4.


#heading(level: 2, numbering: none)[Acknowledgments]
<acknowledgments>
We dedicate this work to our recently deceased colleagues, P. Buford Price and Thomas K. Gaisser. The IceCube collaboration acknowledges significant contributions to this manuscript from Hans Niederhausen and Theo Glauch. \


#strong[Funding:] The authors gratefully acknowledge the support from the following agencies and institutions: USA U.S. National Science Foundation-Office of Polar Programs, U.S. National Science Foundation-Physics Division, U.S. National Science Foundation-EPSCoR, Wisconsin Alumni Research Foundation, Center for High Throughput Computing (CHTC) at the University of WisconsinMadison, Open Science Grid (OSG), Extreme Science and Engineering Discovery Environment (XSEDE), Frontera computing project at the Texas Advanced Computing Center, U.S. Department of Energy-National Energy Research Scientific Computing Center, Particle astrophysics research computing center at the University of Maryland, Institute for Cyber-Enabled Research at Michigan State University, and Astroparticle physics computational facility at Marquette University; Belgium Funds for Scientific Research (FRS-FNRS and FWO), FWO Odysseus and Big Science programmes, and Belgian Federal Science Policy Office (Belspo); Germany Bundesministerium für Bildung und Forschung (BMBF), Deutsche Forschungsgemeinschaft (DFG), Helmholtz Alliance for Astroparticle Physics (HAP), Initiative and Networking Fund of the Helmholtz Association, Deutsches Elektronen Synchrotron (DESY), and High Performance Computing cluster of the RWTH Aachen; Sweden Swedish Research Council, Swedish Polar Research Secretariat, Swedish National Infrastructure for Computing (SNIC), and Knut and Alice Wallenberg Foundation; Australia Australian Research Council; Canada Natural Sciences and Engineering Research Council of Canada, Calcul Québec, Compute Ontario, Canada Foundation for Innovation, WestGrid, and Compute Canada; Denmark Villum Fonden and Carlsberg Foundation; New Zealand Marsden Fund; Japan Japan Society for Promotion of Science (JSPS) and Institute for Global Prominent Research (IGPR) of Chiba University; Korea National Research Foundation of Korea (NRF); Switzerland Swiss National Science Foundation (SNSF); United Kingdom Department of Physics, University of Oxford. \


#strong[Author contributions:] The IceCube Collaboration designed, constructed and now operates the IceCube Neutrino Observatory. Data processing and calibration, Monte Carlo simulations of the detector and of theoretical models, and data analyses were performed by a large number of collaboration members, who also discussed and approved the scientific results presented here. The manuscript was reviewed by the entire collaboration before publication, and all authors approved the final version. \


#strong[Competing interests:] There are no competing interests to declare. \


#strong[Data and materials availability:] Additional data and resources are available from the IceCube data archive at #link("https://icecube.wisc.edu/science/data-releases"). For each data sample these include the events, neutrino effective areas, background rates, and other supporting information in machine-readable formats.


#heading(level: 2, numbering: none)[IceCube Collaboration$""^(*)$:]
<icecube-collaborationast>


R. Abbasi$""^17$, M. Ackermann$""^61$, J. Adams$""^18$, J. A. Aguilar$""^12$, M. Ahlers$""^22$, M. Ahrens$""^51$, J.M. Alameddine$""^23$, C. Alispach$""^28$, A. A. Alves Jr.$""^31$, N. M. Amin$""^43$, K. Andeen$""^41$, T. Anderson$""^58$, G. Anton$""^26$, C. Argüelles$""^14$, Y. Ashida$""^39$, S. Axani$""^15$, X. Bai$""^47$, A. Balagopal V.$""^39$, A. Barbano$""^28$, S. W. Barwick$""^30$, B. Bastian$""^61$, V. Basu$""^39$, S. Baur$""^12$, R. Bay$""^8$, J. J. Beatty$""^(20 , med 21)$, K.-H. Becker$""^60$, J. Becker Tjus$""^11$, C. Bellenghi$""^27$, S. BenZvi$""^49$, D. Berley$""^19$, E. Bernardini$""^(61 , med 62)$, D. Z. Besson$""^34$, G. Binder$""^(8 , med 9)$, D. Bindig$""^60$, E. Blaufuss$""^19$, S. Blot$""^61$, M. Boddenberg$""^1$, F. Bontempo$""^31$, J. Borowka$""^1$, S. Böser$""^40$, O. Botner$""^59$, J. Böttcher$""^1$, E. Bourbeau$""^22$, F. Bradascio$""^61$, J. Braun$""^39$, B. Brinson$""^6$, S. Bron$""^28$, J. Brostean-Kaiser$""^61$, S. Browne$""^32$, A. Burgman$""^59$, R. T. Burley$""^2$, R. S. Busse$""^42$, M. A. Campana$""^46$, E. G. Carnie-Bronca$""^2$, C. Chen$""^6$, Z. Chen$""^52$, D. Chirkin$""^39$, K. Choi$""^53$, B. A. Clark$""^24$, K. Clark$""^33$, L. Classen$""^42$, A. Coleman$""^43$, G. H. Collin$""^15$, J. M. Conrad$""^15$, P. Coppin$""^13$, P. Correa$""^13$, D. F. Cowen$""^(57 , med 58)$, R. Cross$""^49$, C. Dappen$""^1$, P. Dave$""^6$, C. De Clercq$""^13$, J. J. DeLaunay$""^56$, D. Delgado López$""^14$, H. Dembinski$""^43$, K. Deoskar$""^51$, A. Desai$""^39$, P. Desiati$""^39$, K. D. de Vries$""^13$, G. de Wasseige$""^36$, M. de With$""^10$, T. DeYoung$""^24$, A. Diaz$""^15$, J. C. Dı́az-Vélez$""^39$, M. Dittmer$""^42$, H. Dujmovic$""^31$, M. Dunkman$""^58$, M. A. DuVernois$""^39$, E. Dvorak$""^47$, T. Ehrhardt$""^40$, P. Eller$""^27$, R. Engel$""^(31 , med 32)$, H. Erpenbeck$""^1$, J. Evans$""^19$, P. A. Evenson$""^43$, K. L. Fan$""^19$, A. R. Fazely$""^7$, A. Fedynitch$""^55$, N. Feigl$""^10$, S. Fiedlschuster$""^26$, A. T. Fienberg$""^58$, K. Filimonov$""^8$, C. Finley$""^51$, L. Fischer$""^61$, D. Fox$""^57$, A. Franckowiak$""^(11 , med 61)$, E. Friedman$""^19$, A. Fritz$""^40$, P. Fürst$""^1$, T. K. Gaisser$""^43$, J. Gallagher$""^38$, E. Ganster$""^1$, A. Garcia$""^14$, S. Garrappa$""^61$, L. Gerhardt$""^9$, A. Ghadimi$""^56$, C. Glaser$""^59$, T. Glauch$""^27$, T. Glüsenkamp$""^26$, A. Goldschmidt$""^9$, J. G. Gonzalez$""^43$, S. Goswami$""^56$, D. Grant$""^24$, T. Grégoire$""^58$, S. Griswold$""^49$, C. Günther$""^1$, P. Gutjahr$""^23$, C. Haack$""^27$, A. Hallgren$""^59$, R. Halliday$""^24$, L. Halve$""^1$, F. Halzen$""^39$, M. Ha Minh$""^27$, K. Hanson$""^39$, J. Hardin$""^39$, A. A. Harnisch$""^24$, A. Haungs$""^31$, D. Hebecker$""^10$, K. Helbing$""^60$, F. Henningsen$""^27$, E. C. Hettinger$""^24$, S. Hickford$""^60$, J. Hignight$""^25$, C. Hill$""^16$, G. C. Hill$""^2$, K. D. Hoffman$""^19$, R. Hoffmann$""^60$, B. Hokanson-Fasig$""^39$, K. Hoshina$""^(39 , med 63)$, F. Huang$""^58$, M. Huber$""^27$, T. Huber$""^31$, K. Hultqvist$""^51$, M. Hünnefeld$""^23$, R. Hussain$""^39$, K. Hymon$""^23$, S. In$""^53$, N. Iovine$""^12$, A. Ishihara$""^16$, M. Jansson$""^51$, G. S. Japaridze$""^5$, M. Jeong$""^53$, M. Jin$""^14$, B. J. P. Jones$""^4$, D. Kang$""^31$, W. Kang$""^53$, X. Kang$""^46$, A. Kappes$""^42$, D. Kappesser$""^40$, L. Kardum$""^23$, T. Karg$""^61$, M. Karl$""^27$, A. Karle$""^39$, U. Katz$""^26$, M. Kauer$""^39$, M. Kellermann$""^1$, J. L. Kelley$""^39$, A. Kheirandish$""^58$, K. Kin$""^16$, T. Kintscher$""^61$, J. Kiryluk$""^52$, S. R. Klein$""^(8 , med 9)$, R. Koirala$""^43$, H. Kolanoski$""^10$, T. Kontrimas$""^27$, L. Köpke$""^40$, C. Kopper$""^24$, S. Kopper$""^56$, D. J. Koskinen$""^22$, P. Koundal$""^31$, M. Kovacevich$""^46$, M. Kowalski$""^(10 , med 61)$, T. Kozynets$""^22$, E. Kun$""^11$, N. Kurahashi$""^46$, N. Lad$""^61$, C. Lagunas Gualda$""^61$, J. L. Lanfranchi$""^58$, M. J. Larson$""^19$, F. Lauber$""^60$, J. P. Lazar$""^(14 , med 39)$, J. W. Lee$""^53$, K. Leonard$""^39$, A. Leszczyńska$""^32$, Y. Li$""^58$, M. Lincetto$""^11$, Q. R. Liu$""^39$, M. Liubarska$""^25$, E. Lohfink$""^40$, C. J. Lozano Mariscal$""^42$, L. Lu$""^39$, F. Lucarelli$""^28$, A. Ludwig$""^(24 , med 35)$, W. Luszczak$""^39$, Y. Lyu$""^(8 , med 9)$, W. Y. Ma$""^61$, J. Madsen$""^39$, K. B. M. Mahn$""^24$, Y. Makino$""^39$, S. Mancina$""^39$, I. C. Mariş$""^12$, I. Martinez-Soler$""^14$, R. Maruyama$""^44$, K. Mase$""^16$, T. McElroy$""^25$, F. McNally$""^37$, J. V. Mead$""^22$, K. Meagher$""^39$, S. Mechbal$""^61$, A. Medina$""^21$, M. Meier$""^16$, S. Meighen-Berger$""^27$, J. Micallef$""^24$, D. Mockler$""^12$, T. Montaruli$""^28$, R. W. Moore$""^25$, R. Morse$""^39$, M. Moulai$""^15$, R. Naab$""^61$, R. Nagai$""^16$, R. Nahnhauer$""^61$, U. Naumann$""^60$, J. Necker$""^61$, L. V. Nguyễn$""^24$, H. Niederhausen$""^24$, M. U. Nisa$""^24$, S. C. Nowicki$""^24$, D. Nygren$""^(9 , med 4)$, A. Obertacke Pollmann$""^60$, M. Oehler$""^31$, B. Oeyen$""^29$, A. Olivas$""^19$, E. O'Sullivan$""^59$, H. Pandya$""^43$, D. V. Pankova$""^58$, N. Park$""^33$, G. K. Parker$""^4$, E. N. Paudel$""^43$, L. Paul$""^41$, C. Pérez de los Heros$""^59$, L. Peters$""^1$, J. Peterson$""^39$, S. Philippen$""^1$, S. Pieper$""^60$, M. Pittermann$""^32$, A. Pizzuto$""^39$, M. Plum$""^41$, Y. Popovych$""^40$, A. Porcelli$""^29$, M. Prado Rodriguez$""^39$, P. B. Price$""^8$, B. Pries$""^24$, G. T. Przybylski$""^9$, C. Raab$""^12$, J. Rack-Helleis$""^40$, A. Raissi$""^18$, M. Rameez$""^22$, K. Rawlins$""^3$, I. C. Rea$""^27$, A. Rehman$""^43$, P. Reichherzer$""^11$, R. Reimann$""^1$, G. Renzi$""^12$, E. Resconi$""^27$, S. Reusch$""^61$, W. Rhode$""^23$, M. Richman$""^46$, B. Riedel$""^39$, E. J. Roberts$""^2$, S. Robertson$""^(8 , med 9)$, G. Roellinghoff$""^53$, M. Rongen$""^40$, C. Rott$""^(50 , med 53)$, T. Ruhe$""^23$, D. Ryckbosch$""^29$, D. Rysewyk Cantu$""^24$, I. Safa$""^(14 , med 39)$, J. Saffer$""^32$, S. E. Sanchez Herrera$""^24$, A. Sandrock$""^23$, J. Sandroos$""^40$, M. Santander$""^56$, S. Sarkar$""^45$, S. Sarkar$""^25$, K. Satalecka$""^61$, M. Schaufel$""^1$, H. Schieler$""^31$, S. Schindler$""^26$, T. Schmidt$""^19$, A. Schneider$""^39$, J. Schneider$""^26$, F. G. Schröder$""^(31 , med 43)$, L. Schumacher$""^27$, G. Schwefer$""^1$, S. Sclafani$""^46$, D. Seckel$""^43$, S. Seunarine$""^48$, A. Sharma$""^59$, S. Shefali$""^32$, M. Silva$""^39$, B. Skrzypek$""^14$, B. Smithers$""^4$, R. Snihur$""^39$, J. Soedingrekso$""^23$, D. Soldin$""^43$, C. Spannfellner$""^27$, G. M. Spiczak$""^48$, C. Spiering$""^61$, J. Stachurska$""^61$, M. Stamatikos$""^21$, T. Stanev$""^43$, R. Stein$""^61$, J. Stettner$""^1$, A. Steuer$""^40$, T. Stezelberger$""^9$, R. Stokstad$""^9$, T. Stürwald$""^60$, T. Stuttard$""^22$, G. W. Sullivan$""^19$, I. Taboada$""^6$, S. Ter-Antonyan$""^7$, S. Tilav$""^43$, F. Tischbein$""^1$, K. Tollefson$""^24$, C. Tönnis$""^54$, S. Toscano$""^12$, D. Tosi$""^39$, A. Trettin$""^61$, M. Tselengidou$""^26$, C. F. Tung$""^6$, A. Turcati$""^27$, R. Turcotte$""^31$, C. F. Turley$""^58$, J. P. Twagirayezu$""^24$, B. Ty$""^39$, M. A. Unland Elorrieta$""^42$, N. Valtonen-Mattila$""^59$, J. Vandenbroucke$""^39$, N. van Eijndhoven$""^13$, D. Vannerom$""^15$, J. van Santen$""^61$, S. Verpoest$""^29$, C. Walck$""^51$, T. B. Watson$""^4$, C. Weaver$""^24$, P. Weigel$""^15$, A. Weindl$""^31$, M. J. Weiss$""^58$, J. Weldert$""^40$, C. Wendt$""^39$, J. Werthebach$""^23$, M. Weyrauch$""^31$, N. Whitehorn$""^(24 , med 35)$, C. H. Wiebusch$""^1$, D. R. Williams$""^56$, M. Wolf$""^27$, K. Woschnagg$""^8$, G. Wrede$""^26$, J. Wulff$""^11$, X. W. Xu$""^7$, J. P. Yanez$""^25$, S. Yoshida$""^16$, S. Yu$""^24$, T. Yuan$""^39$, Z. Zhang$""^52$, P. Zhelnin$""^14$ \
\
$""^1$ III. Physikalisches Institut, Rheinisch-Westfälische Technische Hochschule Aachen University, D-52056 Aachen, Germany \
$""^2$ Department of Physics, University of Adelaide, Adelaide, 5005, Australia \
$""^3$ Department of Physics and Astronomy, University of Alaska Anchorage, 3211 Providence Dr., Anchorage, AK 99508, USA \
$""^4$ Department of Physics, University of Texas at Arlington, 502 Yates St., Science Hall Rm 108, Box 19059, Arlington, TX 76019, USA \
$""^5$ The Center for Theoretical Studies of Physical Systems, Clark-Atlanta University, Atlanta, GA 30314, USA \
$""^6$ School of Physics and Center for Relativistic Astrophysics, Georgia Institute of Technology, Atlanta, GA 30332, USA \
$""^7$ Department of Physics, Southern University, Baton Rouge, LA 70813, USA \
$""^8$ Department of Physics, University of California, Berkeley, CA 94720, USA \
$""^9$ Lawrence Berkeley National Laboratory, Berkeley, CA 94720, USA \
$""^10$ Institut für Physik, Humboldt-Universität zu Berlin, D-12489 Berlin, Germany \
$""^11$ Fakultät für Physik & Astronomie, Ruhr-Universität Bochum, D-44780 Bochum, Germany \
$""^12$ Science Faculty CP230, Université Libre de Bruxelles, B-1050 Brussels, Belgium \
$""^13$ Physics Department, Vrije Universiteit Brussel, B-1050 Brussels, Belgium \
$""^14$ Department of Physics and Laboratory for Particle Physics and Cosmology, Harvard University, Cambridge, MA 02138, USA \
$""^15$ Department of Physics, Massachusetts Institute of Technology, Cambridge, MA 02139, USA \
$""^16$ Department of Physics and Institute for Global Prominent Research, Chiba University, Chiba 263-8522, Japan \
$""^17$ Department of Physics, Loyola University Chicago, Chicago, IL 60660, USA \
$""^18$ Department of Physics and Astronomy, University of Canterbury, Private Bag 4800, Christchurch, New Zealand \
$""^19$ Department of Physics, University of Maryland, College Park, MD 20742, USA \
$""^20$ Department of Astronomy, Ohio State University, Columbus, OH 43210, USA \
$""^21$ Department of Physics, Ohio State University, Columbus, OH 43210, USA \
$""^22$ Niels Bohr Institute, University of Copenhagen, DK-2100 Copenhagen, Denmark \
$""^23$ Department of Physics, Technical University Dortmund, D-44221 Dortmund, Germany \
$""^24$ Department of Physics and Astronomy, Michigan State University, East Lansing, MI 48824, USA \
$""^25$ Department of Physics, University of Alberta, Edmonton, Alberta, Canada T6G 2E1 \
$""^26$ Erlangen Centre for Astroparticle Physics, Friedrich-Alexander-Universität Erlangen-Nürnberg, D-91058 Erlangen, Germany \
$""^27$ Physik-department, Technische Universität München, D-85748 Garching, Germany \
$""^28$ Département de physique nucléaire et corpusculaire, Université de Genève, CH-1211 Genève, Switzerland \
$""^29$ Department of Physics and Astronomy, University of Gent, B-9000 Gent, Belgium \
$""^30$ Department of Physics and Astronomy, University of California, Irvine, CA 92697, USA \
$""^31$ Karlsruhe Institute of Technology, Institute for Astroparticle Physics, D-76021 Karlsruhe, Germany \
$""^32$ Karlsruhe Institute of Technology, Institute of Experimental Particle Physics, D-76021 Karlsruhe, Germany \
$""^33$ Department of Physics, Engineering Physics, and Astronomy, Queen's University, Kingston, ON K7L 3N6, Canada \
$""^34$ Department of Physics and Astronomy, University of Kansas, Lawrence, KS 66045, USA \
$""^35$ Department of Physics and Astronomy, University of California, Los Angeles, CA 90095, USA \
$""^36$ Centre for Cosmology, Particle Physics and Phenomenology, Université catholique de Louvain, Louvain-la-Neuve, Belgium \
$""^37$ Department of Physics, Mercer University, Macon, GA 31207-0001, USA \
$""^38$ Department of Astronomy, University of WisconsinMadison, Madison, WI 53706, USA \
$""^39$ Department of Physics and Wisconsin IceCube Particle Astrophysics Center, University of WisconsinMadison, Madison, WI 53706, USA \
$""^40$ Institute of Physics, University of Mainz, Staudinger Weg 7, D-55099 Mainz, Germany \
$""^41$ Department of Physics, Marquette University, Milwaukee, WI, 53201, USA \
$""^42$ Institut für Kernphysik, Westfälische Wilhelms-Universität Münster, D-48149 Münster, Germany \
$""^43$ Department of Physics and Astronomy, University of Delaware, Newark, DE 19716, USA \
$""^44$ Department of Physics, Yale University, New Haven, CT 06520, USA \
$""^45$ Department of Physics, University of Oxford, Parks Road, Oxford OX1 3PU, UK \
$""^46$ Department of Physics, Drexel University, 3141 Chestnut Street, Philadelphia, PA 19104, USA \
$""^47$ Physics Department, South Dakota School of Mines and Technology, Rapid City, SD 57701, USA \
$""^48$ Department of Physics, University of Wisconsin, River Falls, WI 54022, USA \
$""^49$ Department of Physics and Astronomy, University of Rochester, Rochester, NY 14627, USA \
$""^50$ Department of Physics and Astronomy, University of Utah, Salt Lake City, UT 84112, USA \
$""^51$ Oskar Klein Centre and Department of Physics, Stockholm University, SE-10691 Stockholm, Sweden \
$""^52$ Department of Physics and Astronomy, Stony Brook University, Stony Brook, NY 11794-3800, USA \
$""^53$ Department of Physics, Sungkyunkwan University, Suwon 16419, Korea \
$""^54$ Institute of Basic Science, Sungkyunkwan University, Suwon 16419, Korea \
$""^55$ Institute of Physics, Academia Sinica, Taipei, 11529, Taiwan \
$""^56$ Department of Physics and Astronomy, University of Alabama, Tuscaloosa, AL 35487, USA \
$""^57$ Department of Astronomy and Astrophysics, Pennsylvania State University, University Park, PA 16802, USA \
$""^58$ Department of Physics, Pennsylvania State University, University Park, PA 16802, USA \
$""^59$ Department of Physics and Astronomy, Uppsala University, Box 516, S-75120 Uppsala, Sweden \
$""^60$ Department of Physics, University of Wuppertal, D-42119 Wuppertal, Germany \
$""^61$ Deutsches Elektronen-Synchrotron, D-15738 Zeuthen, Germany \
$""^62$ Dipartimento di Fisica e Astronomia \"Galileo Galilei\", Università di Padova, I-35131 Padova, Italy \


$""^63$ Earthquake Research Institute, University of Tokyo, Bunkyo, Tokyo 113-0032, Japan \


$""^(*)$E-mail: analysis\@icecube.wisc.edu

#bibliography("refs.bib", style: "nature.csl", title: [References and Notes])
