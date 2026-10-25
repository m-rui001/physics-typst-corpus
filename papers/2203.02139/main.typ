// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: none, paper: "us-letter", margin: (left: 1.90cm, right: 1.76cm, top: 1.87cm, bottom: 2.41cm), columns: 2)
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
#set figure(supplement: [Fig.])
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)

#place(top, float: true, scope: "parent", clearance: 1.2em)[
  #set par(justify: false, leading: 0.48em)
  #align(center)[#text(12pt, weight: "bold")[Search for the Majorana Nature of Neutrinos in the \ Inverted Mass Ordering Region with KamLAND-Zen]]
  #v(0.9em)
  #block(inset: (x: 14pt))[#set par(justify: false, leading: 0.56em)
  #align(center)[#text(10pt)[S. Abe,#super[1] S. Asami,#super[1] M. Eizuka,#super[1] S. Futagi,#super[1] A. Gando,#super[1] Y. Gando,#super[1] T. Gima,#super[1] A. Goto,#super[1] T. Hachiya,#super[1] K. Hata,#super[1] S. Hayashida,#super[1,∗] K. Hosokawa,#super[1,†] K. Ichimura,#super[1] S. Ieki,#super[1] H. Ikeda,#super[1] K. Inoue,#super[1, 2] K. Ishidoshiro,#super[1] Y. Kamei,#super[1] N. Kawada,#super[1] Y. Kishimoto,#super[1, 2] M. Koga,#super[1, 2] M. Kurasawa,#super[1] N. Maemura,#super[1] T. Mitsui,#super[1] H. Miyake,#super[1] T. Nakahata,#super[1] K. Nakamura,#super[1] K. Nakamura,#super[1] R. Nakamura,#super[1] H. Ozaki,#super[1, 3] T. Sakai,#super[1] H. Sambonsugi,#super[1] I. Shimizu,#super[1] J. Shirai,#super[1] K. Shiraishi,#super[1] A. Suzuki,#super[1] Y. Suzuki,#super[1] A. Takeuchi,#super[1] K. Tamae,#super[1] K. Ueshima,#super[1,‡] H. Watanabe,#super[1] Y. Yoshida,#super[1] S. Obara,#super[4,‡] A.K. Ichikawa,#super[5] D. Chernyak,#super[2,§] A. Kozlov,#super[2,¶] K.Z. Nakamura,#super[6] S. Yoshida,#super[7] Y. Takemoto,#super[8,†] S. Umehara,#super[8] K. Fushimi,#super[9] K. Kotera,#super[10] Y. Urano,#super[10] B.E. Berger,#super[2, 11] B.K. Fujikawa,#super[2, 11] J.G. Learned,#super[12] J. Maricic,#super[12] S.N. Axani,#super[13] J. Smolsky,#super[13] Z. Fu,#super[13] L.A. Winslow,#super[13] Y. Efremenko,#super[2, 14] H.J. Karwowski,#super[15] D.M. Markoff,#super[15] W. Tornow,#super[2, 15] S. Dell’Oro,#super[16] T. O’Donnell,#super[16] J.A. Detwiler,#super[2, 17] S. Enomoto,#super[2, 17] M.P. Decowski,#super[2, 18] C. Grant,#super[19] A. Li,#super[19, 15] and H. Song#super[19]]]]
  #v(0.75em)
  #align(center)[#text(10pt)[(KamLAND-Zen Collaboration)]]
  #v(0.55em)
  #set par(justify: false, leading: 0.48em, spacing: 0.0em)
  #align(center)[#text(9pt)[
    #super[1]Research Center for Neutrino Science, Tohoku University, Sendai 980-8578, Japan \
    #super[2]Kavli Institute for the Physics and Mathematics of the Universe (WPI), The University of Tokyo Institutes for Advanced Study, The University of Tokyo, Kashiwa, Chiba 277-8583, Japan \
    #super[3]Graduate Program on Physics for the Universe, Tohoku University, Sendai 980-8578, Japan \
    #super[4]Frontier Research Institute for Interdisciplinary Sciences, Tohoku University, Sendai, 980-8578, Japan \
    #super[5]Department of Physics, Tohoku University, Sendai, 980-8578, Japan \
    #super[6]Kyoto University, Department of Physics, Kyoto 606-8502, Japan \
    #super[7]Graduate School of Science, Osaka University, Toyonaka, Osaka 560-0043, Japan \
    #super[8]Research Center for Nuclear Physics, Osaka University, Ibaraki, Osaka 567-0047, Japan \
    #super[9]Department of Physics, Tokushima University, Tokushima 770-8506, Japan \
    #super[10]Graduate School of Integrated Arts and Sciences, Tokushima University, Tokushima 770-8502, Japan \
    #super[11]Nuclear Science Division, Lawrence Berkeley National Laboratory, Berkeley, California 94720, USA \
    #super[12]Department of Physics and Astronomy, University of Hawaii at Manoa, Honolulu, Hawaii 96822, USA \
    #super[13]Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, USA \
    #super[14]Department of Physics and Astronomy, University of Tennessee, Knoxville, Tennessee 37996, USA \
    #super[15]Triangle Universities Nuclear Laboratory, Durham, North Carolina 27708, USA; Physics Departments at Duke University, Durham, North Carolina 27708, USA; North Carolina Central University, Durham, North Carolina 27707, USA; and The University of North Carolina at Chapel Hill, Chapel Hill, North Carolina 27599, USA \
    #super[16]Center for Neutrino Physics, Virginia Polytechnic Institute and State University, Blacksburg, Virginia 24061, USA \
    #super[17]Center for Experimental Nuclear Physics and Astrophysics, University of Washington, Seattle, Washington 98195, USA \
    #super[18]Nikhef and the University of Amsterdam, Science Park, Amsterdam, the Netherlands \
    #super[19]Boston University, Boston, Massachusetts 02215, USA
  ]]
  #v(0.85em)
  #align(center)[#text(9pt)[(Dated: February 17, 2023)]]
  #v(1.05em)
  #block(inset: (left: 55pt, right: 55pt))[
    #set par(justify: true, leading: 0.64em)
    #text(9pt)[
      The KamLAND-Zen experiment has provided stringent constraints on the neutrinoless double-beta ($0 nu beta beta$) decay half-life in $""^"136""Xe"$ using a xenon-loaded liquid scintillator. We report an improved search using an upgraded detector with almost double the amount of xenon and an ultralow radioactivity container, corresponding to an exposure of $970$ kg yr of $""^"136""Xe"$. These new data provide valuable insight into backgrounds, especially from cosmic muon spallation of xenon, and have required the use of novel background rejection techniques. We obtain a lower limit for the $0 nu beta beta$ decay half-life of #box[$T_(1 slash 2)^(0 nu) > 2.3 times 10^26$] yr at 90% C.L., corresponding to upper limits on the effective Majorana neutrino mass of 36--156 meV using commonly adopted nuclear matrix element calculations.
    ]
  ]
]

#place(bottom + left, scope: "parent", float: true)[
  #block(width: 245pt, inset: (left: 0pt))[
    #set par(justify: true, leading: 0.2em, spacing: 0.18em)
    #text(8pt)[
      #super[∗]Present address: Imperial College London, Department of Physics, Blackett Laboratory, London SW7 2AZ, UK \
      #super[†]Present address: Kamioka Observatory, Institute for Cosmic-Ray Research, The University of Tokyo, Hida, Gifu 506-1205, Japan \
      #super[‡]Present address: National Institutes for Quantum and Radiologi- cal Science and Technology (QST), Sendai 980-8579, Japan \
      #super[§]Present address: Department of Physics and Astronomy, Univer- sity of Alabama, Tuscaloosa, AL 35487, USA \
      #super[¶]Present address: National Research Nuclear University “MEPhI” (Moscow Engineering Physics Institute), Moscow, 115409, Russia \
    ]
  ]
]

#pagebreak()

#v(0.6em)

The search for neutrinoless double-beta ($0 nu beta beta$) decay is the most practical way to probe the Majorana nature of neutrinos. In the context of light Majorana neutrino exchange between two nucleons, the decay rate is proportional to the square of the effective Majorana neutrino mass $⟨m_(beta beta)⟩ equiv |sum_i U_(e i)^2 m_(nu_i)|$, providing information on the absolute neutrino mass scale and mass eigenstate ordering. To date, KamLAND-Zen has provided the most stringent constraint on $⟨m_(beta beta)⟩$ of $gt.tilde$ 100 meV in the quasidegenerate neutrino mass region@Gando2016. An improved search probing $⟨m_(beta beta)⟩$ below 50 meV would provide a first test of the Majorana nature of neutrinos in the inverted mass ordering (IO) region beyond the quasidegenerate mass region. Such searches also test theoretical models predicting $⟨m_(beta beta)⟩$ in this range@Harigaya2012 @Asaka2020 @Asai2020.

#v(0.6em)
KamLAND-Zen@Gando2012a @Gando2012b @Gando2013a @Asakura2016 @Gando2016 @Gando2019 is a double-beta decay experiment that exploits the existing KamLAND neutrino detector. The $beta beta$ decay source is a Xe-loaded liquid scintillator (Xe-LS) contained in a spherical inner balloon (IB) at the center of the detector. The IB is surrounded by 1 kton of LS (Outer LS) contained in a 13-m-diameter spherical outer balloon made of 135-$mu$m-thick nylon/EVOH composite film. To detect scintillation light, 1,325 17-inch and 554 20-inch photomultiplier tubes (PMTs) are mounted on the inner surface of the stainless-steel containment tank (SST), providing 34% solid-angle coverage. The SST is surrounded by a 3.2~kton water-Cherenkov outer detector.

The previous search in KamLAND-Zen used 381 kg of enriched xenon (referred to as KamLAND-Zen~400) and probed $0 nu beta beta$ just above the IO region@Gando2016. To further improve this limit, the KamLAND-Zen collaboration upgraded the experiment to 745 kg of enriched xenon (referred to as KamLAND-Zen 800), nearly twice the target mass of the previous experiment. To hold the additional xenon, a larger and cleaner 3.80-m-diameter IB was constructed with better mitigation measures to avoid dust attachment to the balloon surface@Gando2021. The Xe-LS consists of 82% decane and 18% pseudocumene (1,2,4-trimethylbenzene) by volume, 2.4 g/liter of the fluor PPO (2,5-diphenyloxazole), and $(3.13 plus.minus 0.01)$% by weight of enriched xenon gas. The isotopic abundances in the enriched xenon were measured by a residual gas analyzer to be $(90.85 plus.minus 0.13) "%"$ $""^"136""Xe"$, $(8.82 plus.minus 0.01) "%"$ $""^"134""Xe"$.

Science data-taking started on January 2, 2019. The initial data contained $""^"222""Rn"$~($tau = 5.5$ day), introduced by radon emanation from storage tanks and pipelines during Xe-LS filling, and was used for detector calibration. Event positions and energies are reconstructed based on the timing and charge distributions of photoelectrons recorded by the PMTs. The detector Monte Carlo (MC) simulation is based on `GEANT4`@Agostinelli2003 @Allison2006 and is tuned to reproduce the timing and charge distributions observed in the data. The optical parameters related to the position dependence of the light yield are corrected based on monochromatic $""^"214""Po"$ $alpha$ decays in the $""^"222""Rn"$ decay chain. The parameters of the detector energy nonlinear response model describing effects from scintillator quenching and Cherenkov light production are constrained to reproduce the measured spectral shape of $""^"214""Bi"$ $beta + gamma$ decays. The estimated energy and vertex resolutions in the Xe-LS are 6.7%/$sqrt(E ( "MeV" ))$ and 13.7 cm/$sqrt(E ( "MeV" ))$, respectively. Using the 2.225 MeV $gamma$ rays from the muon-induced neutron captures on protons, the position- and time-dependent fluctuations of the absolute energy scale in the Xe-LS are determined to be less than 1%. We considered this deviation as a systematic uncertainty on the energy scale conservatively, while its impact is mitigated by the spectral fit for $2 nu beta beta$, as discussed later. The outer LS is 1.1 times brighter than the Xe-LS. The tuned MC reproduces the observed vertex distances between sequential #box[$""^"214""Bi"$-$""^"214""Po"$] decays ($tau = 237 thin mu "s"$) coming from $""^"222""Rn"$ in the Xe-LS; the average distances are 38.0 cm and 38.1 cm with the data and MC, respectively. It also reproduces the energy spectrum of $""^"214""Bi"$ decays including the high energy tail, indicating that the background contribution from energy reconstruction failure in $2 nu beta beta$ decays is negligible.

// [figvision] imgs/fig1a.png
// Panel (a) is a two-dimensional plot displaying the vertex distribution of candidate solar neutrino events
// overlaid on a background simulation. The horizontal axis represents the squared radial distance, X² + Y², in
// meters squared, ranging from 0 to approximately 6.5. The vertical axis denotes the Z coordinate in meters,
// spanning roughly -2.5 to 2.5. A color histogram indicates the simulated event rate for Bismuth-214, with a
// logarithmic scale from 1 to over 10⁴ events per bin shown on the right; colors transition from pale yellow
// (low density) to dark red and black (high density). Scattered black points represent the actual data
// candidates. Several geometric lines are superimposed: a solid black curve outlines the Inner Ball boundary,
// while concentric dotted black curves show spherical shells centered at the origin. A thick dashed line marks a
// 1.57-meter radius sphere, and a dot-dashed line traces a nylon belt structure. The data points cluster
// primarily near the origin and along the lower left region, correlating with high background rates in those
// areas.
// [figvision] imgs/fig1b.png
// Panel (b) is a histogram plot displaying event rates versus normalized radial volume. The vertical axis
// represents Events per Bin on a logarithmic scale ranging from 10^0 to 10^4. The horizontal axis shows the cube
// of the radius normalized by 1.90 meters, spanning from 0.0 to 2.0. Experimental data points are plotted as
// black crosses with error bars. Several background components are overlaid as step histograms: blue dashed for
// IB/External RI, green solid for Solar neutrino ES+CC, orange solid for Internal RI, brown dash-dot for Carbon
// spallation plus X-137, and magenta solid for X-136 two-neutrino double beta decay. A black solid line
// represents Xenon spallation products, while a red solid line indicates the total background sum. Vertical
// lines at approximately 0.58 and 1.0 mark specific detector boundaries.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [FIG. #context it.counter.display(it.numbering): #it.body]
}

#show figure.where(kind: table): set figure(numbering: "I")
// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [TABLE #context it.counter.display(it.numbering): #it.body]
}

#figure(placement: auto, 
  grid(
    columns: 1,
    gutter: 0.6em,
    image("imgs/fig1a.png", width: 100%),
    image("imgs/fig1b.png", width: 100%),
  ),
  caption: [
    (a) Vertex distribution of candidate SD events (black points) overlaid on $""^"214""Bi"$ background events from the MC simulation (color histogram) in the energy region $2.35 < E < 2.70 thin "MeV"$ ($0 nu beta beta$ window), with arbitrary normalization. The solid and thick dashed lines indicate the shape of the IB and the 1.57-m-radius spherical volume, respectively. The dot-dashed line indicates the nylon belt suspending the IB. The thin dashed lines illustrate the shape of the equal-volume spherical half-shells, which compose the 2.5-m-radius spherical fiducial volume. The high-count region at the IB bottom indicates the hot spot and is vetoed. (b) $R^3$ vertex distribution of candidate SD events in the $0 nu beta beta$ window. The curves show the best-fit background model components.
  ]
) <fig-vertex>

We use data collected between February 5, 2019 and May 8, 2021. Candidate events are selected by performing the following series of first-level cuts: (i) the events must be reconstructed within 2.5 m of the detector center and 0.7 m away from the bottom hot spot on the IB, which is outlined in @fig-vertex(a). (ii) Muons and events within 2 ms after muons are rejected. (iii) Sequential radioactive decays are eliminated by a delayed coincidence tag, requiring time and distance between the prompt and delayed events to be less than 1.9 ms and 1.7 m, respectively, and a double pulse identification inside a single event acquisition window. Those cuts remove $(99.89 plus.minus 0.03)$% of #box[$""^"214""Bi"$-$""^"214""Po"$] events, and $(97.7 plus.minus 0.5)$% of #box[$""^"212""Bi"$-$""^"212""Po"$]. (iv) Reactor $overline(nu)_e$ interactions identified by delayed coincidence are rejected. (v) Poorly reconstructed events are rejected to suppress electronic noise and accidental pileup. Real singles events are produced by isotropic scintillation from a single site. In this case, there are correlations between the vertex-to-PMT distance and photon travel time, and between the distance and charge, which can be approximated by simple functions. We define a discriminator based on $chi^2$ tests to assess the agreement with those approximate functions, and identify tag events with high discriminator values as poorly reconstructed events. The overall selection inefficiency is less than 0.1%.

Background sources for the $0 nu beta beta$ search are divided into four categories: (i) radioactive impurities (RI) in the Xe-LS; (ii) external to the Xe-LS, mainly from the IB material; (iii) neutrino interactions; and (iv) cosmogenic spallation products. The inferred contamination of $""^"238""U"$ and $""^"232""Th"$ in the Xe-LS is $(1.5 plus.minus 0.4) times 10^(-17)$ g/g and $(3.0 plus.minus 0.4) times 10^(-16)$ g/g, respectively, based on delayed coincidence measurements of #box[$""^"214""Bi"$-$""^"214""Po"$] and #box[$""^"212""Bi"$-$""^"212""Po"$] decays. Those reference calculations for $""^"238""U"$ and $""^"232""Th"$ assume secular equilibrium for comparison with the previously reported values, and are not used for background estimations. We did not find the background peak from $""^"110m""Ag"$ $beta^(-)$ decays ($tau = 360$ day, $Q = 3.01$ MeV) observed previously in KamLAND-Zen~400, caused by contamination from Fukushima-I fallout@Gando2013a. We conclude that $""^"110m""Ag"$ was significantly reduced due to radioactive decay, continued purification, and cleaner fabrication of the IB. The primary background sources external to the Xe-LS are $""^"238""U"$ and $""^"232""Th"$ in the IB. The contamination levels of $""^"238""U"$ and $""^"232""Th"$ are $(3 plus.minus 1) times 10^(-12)$ g/g and $(3.8 plus.minus 0.2) times 10^(-11)$ g/g, respectively, and are roughly a factor of 10 smaller compared to those measured on the previous IB@Gando2016. The backgrounds from the outer LS and surrounding detector materials are negligibly small.

In the later period of the dataset, we found an increase in the background rate at the IB bottom, possibly due to the settling of dust particles containing radioactive impurities. We performed a search for clusters of $gamma$-like events using a newly developed spatiotemporal deep neural network model, referred to as KamNet@Li2023, which is capable of resolving $gamma$ cascades from the resulting nonisotropic event topology due to multisite energy deposits. The search identified such an event cluster in the inner volume of the Xe-LS ($R < 1.57$ m) that is inconsistent with the average background rate, with a $p$~value of only 0.06% (including the trials penalty). Considering the limited likelihood of contamination during the construction phase, credible sources of time-varying backgrounds are $""^"60""Co"$ in stainless-steel shavings or $""^"214""Bi"$ in thick dust. To avoid this ambiguity in our background modeling, we remove this high-background period from the dataset. The boundaries of the period were defined from the times of the first and last events in the cluster, with an added period on either side corresponding to the average interevent time in the cluster, corresponding to a total of 30.4 days. However, we also performed the analysis with the high-background period included and report the impact on the final result, as discussed later.

Solar neutrinos are an intrinsic background source for the $0 nu beta beta$ search. The oscillated neutrino flux can be calculated based on the standard solar model prediction@Serenelli2011 with three-flavor mixing. The contribution from the elastic scattering (ES) of $""^"8""B"$ solar neutrinos on electrons is estimated to be $(4.9 plus.minus 0.2) times 10^(-3)$ $("ton day")^(-1)$~in the Xe-LS. In addition, $""^"136""Xe"$ captures $nu_e$ through charged-current (CC) interactions, primarily from $""^"7""Be"$ solar neutrinos, producing $e^(-)$, $""^"136""Cs"$, and $gamma$'s from the excited states. The subsequent $beta + gamma$ decays of $""^"136""Cs"$ ($tau = 19.0$ day, $Q = 2.548$ MeV) produce a background peak around 2.0 MeV in visible energy, mostly overlapping with the resolution tail of $2 nu beta beta$ decays. The interaction rate is expected to be $(0.8 plus.minus 0.1) times 10^(-3)$ $("ton day")^(-1)$~based on the cross section calculated in Ref.@Ejiri2014 @Frekers2013.

Radioactive isotopes produced through cosmic muon spallation of carbon and xenon represent the dominant backgrounds in this analysis. To suppress the spallation backgrounds, second-level cuts are performed with the discrimination parameters based on time intervals ($Delta T$) from preceding muons, space correlations with vertices of neutron capture $gamma$ rays (neutron vertices) induced by those muons, and reconstructed muon tracks and shower profiles@Gando2016 @Abe2010 @Li2014 @Li2015a @Li2015b @Zhang2016. We apply the following four rejection criteria: (a) events within 150 ms after muons passing through the LS are rejected. This cut removes 99.4% of $""^"12""B"$~($tau = 29.1 thin "ms"$, $Q = 13.4 thin "MeV"$). (b) To reduce short-lived carbon spallation backgrounds, mainly from $""^"10""C"$~($tau = 27.8 thin "s"$, $Q = 3.65 thin "MeV"$) and $""^"6""He"$~($tau = 1.16 thin "s"$, $Q = 3.51 thin "MeV"$), we remove events reconstructed within 1.6 m of neutron vertices with $Delta T < 180 thin "s"$. (c) Events likely to be spallation backgrounds, which have space and time correlations with the preceding muon-induced showers, are rejected. The muon track reconstructed from the timing of the first-arriving photons at the PMTs provides the transverse distance between muons and spallation backgrounds ($l_("trans")$). We apply a newly developed muon shower reconstruction to calculate light intensity profiles along the muon track based on the timing of all the photons. The light profile ($Q_("shower")$) is represented by a function of the longitudinal distance between muon entry and spallation backgrounds ($l_("long")$). We performed the cuts with a new likelihood discriminator, $L_1 = f_("spall") / f_("acc")$. Here $f_("spall")$ and $f_("acc")$ are the probability density functions (PDFs) for muon-spallation pairs and accidental pairs, respectively; both PDFs are functions of the three parameters: $Delta T$, $l_("trans")$, and $Q_("shower")$. The cut value of $L_1$ was optimized based on the PDFs created from $""^"12""B"$. The overall rejection efficiencies for $""^"10""C"$ and $""^"6""He"$ by cuts (a)--(c) are $>$99.3% and $(97.6 plus.minus 1.7) "%"$, respectively, including the uncertainties from the isotope dependence of the PDFs. (d) To reduce the $""^"137""Xe"$ ($tau = 5.5 thin "min"$, $Q = 4.17 thin "MeV"$) background, we remove events reconstructed within 1.6 m of the vertices identified as neutron captures on $""^"136""Xe"$ producing high energy $gamma$'s ($Q = 4.03 thin "MeV"$) with $Delta T < 27 thin "min"$. This cut removes $(74 plus.minus 7) "%"$ of $""^"137""Xe"$. The dead time introduced by the cuts (a)--(d) is $(14.6 plus.minus 0.1) "%"$.

The second-level cuts effectively reject carbon spallation backgrounds, however, most xenon spallation backgrounds remain after the cuts because their lifetimes are long (typically several hours). Xenon spallation can be characterized by detecting multiple neutrons emitted via the nucleon evaporation process in neutron-rich isotopes ($""^"136""Xe"$ primarily). To tag the long-lived products effectively, we define another likelihood discriminator, $L_2 = f_("ll") / f_("acc")$. Here $f_("ll")$ and $f_("acc")$ are the PDFs for long-lived muon-spallation pairs and accidental pairs, respectively, constructed from three parameters: neutron multiplicity, distance to neutron vertices, and $Delta T$. The cut value on the $L_2$ parameter is optimized using an MC simulation discussed later. Events that are not classified as coming from long-lived backgrounds are referred to as "singles data" (SD), and the others are referred to as "long-lived data" (LD). The total live time for SD and LD is $523.4$ days and $49.3$ days, respectively. The exposure of SD, sensitive to $0 nu beta beta$ signal, is $970$ kg yr of $""^"136""Xe"$.

The production yields for individual carbon spallation isotopes are well estimated with fits to the $Delta T$ curves within $10^3$ s for each isotope using the high statistics data in the large outer-LS volume. On the other hand, the same fit does not work for xenon spallation in the Xe-LS volume because there are many candidate long-lived isotopes whose individual yields are too small to be decomposed. To assess the total yields of all isotopes, we performed an MC simulation of muon-induced spallation using `FLUKA`@BOHLEN2014211 @Ferrari:898301 and of the subsequent radioactive decays by `GEANT4`. The expected $Delta T$ curve within $10^6$ s and energy spectrum are calculated by adding the contributions of all produced isotopes as well as their daughters. The primary contributions are from $""^"132""I"$, $""^"130""I"$, $""^"124""I"$, $""^"122""I"$, $""^"118""Sb"$, $""^"110""In"$, and $""^"88""Y"$. Considering potentially large uncertainties in the MC-based total yields, we introduced a parameter to scale the long-lived spallation background rate ($alpha_("BG")$) in the fit to $0 nu beta beta$ decay discussed later. The systematic uncertainties on the relative yields are estimated from isotopic production cross sections for $""^"136""Xe"$ spallation by protons at incident energies of 500 MeV and 1 GeV per nucleon@Giot2013 @Napolitani2007, giving an estimate of the energy spectral distortion from those errors. The MC study shows $(42.0 plus.minus 8.8) "%"$ of long-lived spallation backgrounds are classified as LD, whereas only 8.6% of uncorrelated events are mis-classified. This indicates that the LD analysis is useful for constraining $alpha_("BG")$.

// [figvision] imgs/fig2a.png
// Panel (a) displays the Singles Data energy spectrum as a histogram plot. The horizontal axis represents
// Visible Energy in MeV, ranging linearly from 0 to approximately 4.5 MeV. The vertical axis shows Event counts
// per 0.05 MeV bin on a logarithmic scale from 10^0 to over 10^4. Black crosses with error bars represent
// experimental data points. A solid red line indicates the total best-fit background model, which generally
// follows the data trend but dips below it between 2 and 3 MeV. A magenta solid line depicts the ^{136}Xe
// two-neutrino double beta decay (2), dominating the high count rate at low energies before dropping sharply
// near 2.5 MeV. Various colored lines show specific background components: black for Xenon spallation products,
// orange for Internal Radioactivity (RI), blue dashed for IB/External RI, green for Solar neutrinos, and brown
// dash-dot for Carbon spallation plus ^{137}Xe. A light blue step function marks the 90% Confidence Level upper
// limit for neutrinoless double beta decay (0). Panel (b) presents the Long-Lived Data (LD) energy spectrum
// using the same axes and units as panel (a). The x-axis spans Visible Energy from 0 to roughly 4.5 MeV, while
// the y-axis plots Events per 0.05 MeV on a log scale, though the overall magnitude is lower than in panel (a),
// reflecting the reduced exposure. Experimental data are shown as black crosses with error bars. The solid red
// line again represents the total background fit, closely tracking the data distribution across the energy
// range. The magenta line for ^{136}Xe 2 is present but significantly suppressed compared to panel (a),
// consistent with the selection criteria for long-lived events. Background contributions include the black line
// for Xenon spallation products, orange for Internal RI, blue dashed for IB/External RI, green for Solar
// neutrinos, and brown dash-dot for Carbon spallation plus ^{137}Xe. The light blue step function indicates the
// 90% C.L. upper limit for 0, appearing similar in shape to panel (a) but scaled to the lower statistics of the
// LD sample.
// [figvision] imgs/fig2b.png
// Panel (b) displays a semi-logarithmic plot of energy spectra for long-lived data. The vertical axis, labeled
// "Event/0.05 MeV," spans logarithmically from 10^0 to 10^4. The horizontal axis represents "Visible Energy
// (MeV)" linearly ranging from approximately 0.5 to 4.5. Black crosses with error bars represent the observed
// data points. A solid red line indicates the total background fit, while a dotted red line shows the total
// including the upper limit for neutrinoless double beta decay. Other curves detail specific backgrounds: a
// magenta line for two-neutrino double beta decay, a black step-line for xenon spallation products, an orange
// line for internal radioactive isotopes, and blue/green lines for external radiation and solar neutrinos
// respectively. A light blue line marks the 90% confidence level upper limit.
#figure(placement: auto, 
  grid(
    columns: 1,
    gutter: 0.6em,
    image("imgs/fig2a.png", width: 100%),
    image("imgs/fig2b.png", width: 100%),
  ),
  caption: [
    Energy spectra of selected $beta beta$ candidates within a 1.57-m-radius spherical volume drawn together with best-fit backgrounds, the $2 nu beta beta$ decay spectrum, and the 90% C.L. upper limit for $0 nu beta beta$ decay of (a) singles data (SD), and (b) long-lived data (LD). The LD exposure is about 10% of the SD exposure.
  ]
) <fig-energy>

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),
    [Background], [Estimated], table.cell(colspan: 2)[Best-fit],
    [], [], [Frequentist], [Bayesian],
    [$""^"136""Xe"$ $2 nu beta beta$], [-], [$11.98$], [$11.95$],
    table.cell(colspan: 4)[Residual radioactivity in Xe-LS],
    [$""^"238""U"$ series], [$0.14 plus.minus 0.04$], [$0.14$], [$0.09$],
    [$""^"232""Th"$ series], [-], [$0.85$], [$0.87$],
    table.cell(colspan: 4)[External (Radioactivity in IB)],
    [$""^"238""U"$ series], [-], [$3.05$], [$3.46$],
    [$""^"232""Th"$ series], [-], [$0.01$], [$0.01$],
    table.cell(colspan: 4)[Neutrino interactions],
    [$""^"8""B"$ solar $nu$ $e^(-)$ ES], [$1.65 plus.minus 0.04$], [$1.65$], [$1.65$],
    table.cell(colspan: 4)[Spallation products],
    [Long-lived], [$7.75 plus.minus 0.57$], [$12.52$], [$11.80$],
    [$""^"10""C"$], [$0.00 plus.minus 0.05$], [$0.00$], [$0.00$],
    [$""^"6""He"$], [$0.20 plus.minus 0.13$], [$0.22$], [$0.21$],
    [$""^"137""Xe"$], [$0.33 plus.minus 0.28$], [$0.34$], [$0.34$],
  ),
  caption: [Summary of the estimated and best-fit background contributions for the frequentist and Bayesian analyses in the energy region $2.35 < E < 2.70 thin "MeV"$ within the 1.57-m-radius spherical volume. In total, 24 events were observed.],
  kind: table,
  supplement: [Table],
) <tab-background>

#block[
  Estimation based on the spallation MC study. This event rate constraint is not applied to the spectrum fit.
]

The $0 nu beta beta$ decay rate is estimated from a simultaneous likelihood fit to the binned energy spectra of SD and LD between 0.5 and 4.8 MeV in hemispherical-shell volumes. The volumes are made by dividing the 2.5-m-radius fiducial volume into 20 equal-volume bins each in the upper and lower hemispheres. The contributions from major backgrounds in the Xe-LS, such as $""^"85""Kr"$, $""^"40""K"$, $""^"210""Bi"$, the #box[$""^"228""Th"$-$""^"208""Pb"$] subchain of the $""^"232""Th"$ series, and long-lived spallation products, are free parameters and are left unconstrained in the spectral fit. The contributions from the #box[$""^"222""Rn"$-$""^"210""Pb"$] subchain of the $""^"238""U"$ series and short-lived spallation products can vary but are constrained by their independent measurements. The parameters of the detector energy response model common to SD and LD are floated but are constrained by the $""^"222""Rn"$-induced $""^"214""Bi"$ data. The energy spectral distortion parameter changing the relative contributions of the long-lived spallation isotopes is allowed to float freely. The uncertainty on the energy scale parameter is stringently constrained by the fit to the high statistics $2 nu beta beta$ events, so its impact on the background estimate is negligible.

To visualize the fit to the $0 nu beta beta$ signal and long-lived spallation backgrounds, the energy spectra of selected candidate SD and LD events within a 1.57-m-radius spherical volume (inner 10 equal-volume bins illustrated in @fig-vertex(a)), together with the best-fit curves, are shown in @fig-energy. The radial dependences of candidate SD events and best-fit background contributions in the $0 nu beta beta$ window are illustrated in @fig-vertex(b). The exposure of $""^"136""Xe"$ for SD in this volume is 0.510 ton yr. The best-fit background contributions are summarized in @tab-background. We found no event excess over the background expectation. We obtained a 90% confidence level (C.L.) upper limit on the number of $""^"136""Xe"$ $0 nu beta beta$ decays of $< 7.9$ events ($< 6.2$ events in the range $2.35 < E < 2.70 thin "MeV"$), which corresponds to a limit of $< 15.5$ (ton yr)$""^(-1)$~in units of $""^"136""Xe"$ exposure, or $T_(1 / 2)^(0 nu beta beta) > 2.0 times 10^26$ yr (90% C.L.). An analysis based on the Feldman-Cousins procedure@PhysRevD.57.3873_FCmethod gives a slightly stronger limit of $2.3 times 10^26$ yr (90% C.L.), indicating a limited impact of the physical boundary on the $0 nu beta beta$ rate in low statistics. An MC simulation of an ensemble of experiments assuming the best-fit background spectrum and including the high-background-period identification scheme indicates a median sensitivity of $1.3 times 10^26$ yr. The probability of obtaining a limit stronger than that reported here is 24%. In addition to the frequentist analyses above, we also performed a statistical analysis within the Bayesian framework, assuming a flat prior for $1 / T_(1 / 2)^(0 nu beta beta)$. The Bayesian limit and sensitivity are $2.1 times 10^26$ yr and $1.5 times 10^26$ yr (90% C.L.), respectively.

We investigated the stability of the results by comparing the limits with different analysis conditions and background models. Alternatively, we also performed the analysis including the high-background period in the data with floated background contributions from $""^"60""Co"$ and $""^"214""Bi"$. This data is separated into $beta$-like and $gamma$-like events, using particle identification provided by KamNet, and simultaneously fit to provide slightly improved half-life limits of $T_(1 / 2)^(0 nu beta beta) > 2.7 times 10^26$ yr and $T_(1 / 2)^(0 nu beta beta) > 2.4 times 10^26$ yr (90% C.L.) for the background models with $""^"60""Co"$ and $""^"214""Bi"$, respectively.

// [figvision] imgs/fig3.png
// Panel a displays a plot of Effective Majorana mass on the y-axis, ranging from 0 to 200 meV, against Lightest
// neutrino mass on the x-axis, which spans logarithmically from 10^0 to over 10^2 meV. Two shaded bands
// represent theoretical predictions: a green band labeled IO for inverted ordering and a pink band labeled NO
// for normal ordering. Darker shades indicate best-fit values while lighter shades show uncertainty ranges. The
// IO band is relatively flat between approximately 15 and 50 meV before rising steeply at higher masses. The NO
// band starts near zero and curves upward exponentially. Horizontal lines intersect these bands, representing
// experimental upper limits from KamLAND-Zen using four nuclear models: QRPA (orange dotted), SM (green
// dash-dot), IBM (magenta dashed), and EDF (red solid). These lines generally fall below the IO prediction but
// cut through or lie above the NO curve depending on the model.
#figure(placement: auto, image("imgs/fig3.png", width: 100%),
  caption: [
    Effective Majorana neutrino mass $⟨m_(beta beta)⟩$ as a function of the lightest neutrino mass. The dark shaded regions are predictions based on best-fit values of neutrino oscillation parameters for the normal ordering (NO) and the inverted ordering (IO), and the light shaded regions indicate the $3 sigma$ ranges calculated from oscillation parameter uncertainties@DellOro2014 @NuFIT2020. The regions below the horizontal lines are allowed at 90% C.L. with $""^"136""Xe"$ from KamLAND-Zen (this work) considering an improved phase space factor calculation@Kotila2012 @Stoica2013 and commonly used nuclear matrix element estimates: energy-density functional (EDF) theory@PhysRevLett.111.142501 @PhysRevC.91.024316 @Rodriguez2010 (solid lines), interacting boson model (IBM)@Deppisch2020 @PhysRevC.91.034304 (dashed lines), shell model (SM)@PhysRevC.101.044315 @Horoi2015 @Menendez2009 (dot-dashed lines), and quasiparticle random-phase approximation (QRPA)@PhysRevC.102.044303 @PhysRevC.91.024613 @PhysRevC.87.045501 @PhysRevC.87.064302 @PhysRevC.97.045503 (dotted lines). The side panel shows the corresponding limits for $""^"136""Xe"$, $""^"76""Ge"$@Agostini2020, and $""^"130""Te"$~@Adams2022, and theoretical model predictions on $⟨m_(beta beta)⟩$, (a) Ref.@Harigaya2012, (b) Ref.~@Asaka2020, and (c) Ref.@Asai2020 (shaded boxes), in the IO region.
  ]
)
<fig-effective-mass>

The combined fit of the KamLAND-Zen 400 and 800 datasets with the frequentist analyses gives a limit of $2.3 times 10^26$ yr (90% C.L.) (see the Supplemental Material@SuppMat). The best-fit scaling parameter for the long-lived spallation background rate is $alpha_("BG") = 1.35 plus.minus 0.23$, indicating good consistency between the MC-based prediction and the LD analysis. This combined analysis has a sensitivity of $1.5 times 10^26$ yr, and the probability of obtaining a stronger limit is $23$%. From the combined half-life limits, we obtain a 90% C.L. upper limit of $⟨m_(beta beta)⟩ < ( 36 " – " 156) thin "meV"$ using the phase space factor calculation from@Kotila2012 @Stoica2013 and commonly used nuclear matrix element estimates@PhysRevLett.111.142501 @PhysRevC.91.024316 @Rodriguez2010 @Deppisch2020 @PhysRevC.91.034304 @PhysRevC.101.044315 @Horoi2015 @Menendez2009 @PhysRevC.102.044303 @PhysRevC.91.024613 @PhysRevC.87.045501 @PhysRevC.87.064302 @PhysRevC.97.045503 assuming the axial coupling constant $g_A tilde.eq 1.27$. @fig-effective-mass illustrates the allowed range of $⟨m_(beta beta)⟩$ as a function of the lightest neutrino mass. For the first time, this search with $""^"136""Xe"$ begins to test the IO band, and realizes the partial exclusion of several theoretical models~@Harigaya2012 @Asaka2020 @Asai2020, that estimate $⟨m_(beta beta)⟩$ based on predictions of the Majorana CP phases.

This Letter reported the first $""^"136""Xe"$ $0 nu beta beta$ search, at 1 ton yr exposure, in KamLAND-Zen 800 using almost double the amount of enriched xenon and a cleaner nylon balloon relative to KamLAND-Zen 400. Our improved sensitivity provides a limit that reaches below 50 meV for the first time with certain nuclear matrix element calculations@PhysRevLett.111.142501 @PhysRevC.91.024316 @Rodriguez2010, and is the first search for $0 nu beta beta$ in the inverted mass ordering region. Even though extensive efforts were made to analytically reject muon spallation, the sensitivity is limited mainly by long-lived spallation backgrounds. In the future, we plan to upgrade to dead-time-free electronics to detect muon-induced neutrons more effectively and enhance the rejection performance for xenon spallation backgrounds. Such improvements and continued observation in KamLAND-Zen will provide more stringent tests of the neutrino mass scale in the inverted mass ordering region.

#block[
The KamLAND-Zen experiment is supported by JSPS KAKENHI Grants No. 21000001, No. 26104002, and No. 19H05803; the U.S. National Science Foundation awards no. 2110720 and no. 2012964; the Heising-Simons Foundation; the Dutch Research Council (NWO); and under the U.S. Department of Energy (DOE) Grant No. DE-AC02-05CH11231, as well as other DOE and NSF grants to individual institutions. The Kamioka Mining and Smelting Company has provided service for activities in the mine. We acknowledge the support of NII for SINET4.

]

#show bibliography: set text(size: 9pt)
#bibliography("refs.bib", style: "ieee", title: none)