#import "@preview/cetz:0.4.2"

// build: typst compile --no-pdf-tags main.typ
// Typst 0.14/0.15 PDF tag-tree crashes ("parent group") when a page carries
// several parent-scoped formula groups; --no-pdf-tags renders the same pages.

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(
  numbering: none,
  paper: "us-letter",
  margin: (left: 1.79cm, right: 1.76cm, top: 65.8pt, bottom: 2.57cm),
  columns: 2,
  header-ascent: 16.1pt,
  header: context {
    let p = counter(page).get().first()
    if p > 1 {
      set text(size: 10pt)
      if calc.even(p) {
        block(width: 100%)[#place(left)[#p]#align(center)[#smallcaps[Riley et al.]]]
      } else {
        block(width: 100%)[#place(right)[#p]#align(center)[#smallcaps[A _NICER_ VIEW OF THE MASSIVE PULSAR PSR~J0740+6620]]]
      }
    }
  },
)
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => block(width: 100%, above: 1.2em, below: 0.6em, align(center)[#if it.numbering != none [#text(size: 9pt, weight: "regular")[#numbering(it.numbering, ..counter(heading).at(it.location()))]. ]#text(size: 9.5pt, weight: "regular")[#it.body]])
#show heading.where(level: 2): it => block(above: 1.0em, below: 0.5em)[#text(size: 10pt)[#if it.numbering != none [#numbering(it.numbering, ..counter(heading).at(it.location()))]. ]#text(size: 10pt, weight: "regular", style: "italic")[#it.body]]
#show heading.where(level: 3): it => block(above: 0.9em, below: 0.4em)[#text(size: 10pt)[#if it.numbering != none [#numbering(it.numbering, ..counter(heading).at(it.location()))]. ]#text(size: 9pt, weight: "regular", style: "italic")[#it.body]]
#set figure(placement: auto)
#set par(justify: true, spacing: 0.79em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.463em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set block(breakable: true)
#set figure.caption(separator: [. ])
#show table: set text(size: 9pt)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#show math.equation.where(block: true): set text(size: 9.5pt)
#set math.equation(numbering: "(1)", supplement: none)


#place(top + left, scope: "parent", float: true)[
  #block(width: 511.4pt)[
  #place(top + left, dy: -5pt)[
    #set text(size: 8pt)
    #set par(justify: false, leading: 0.6em, first-line-indent: 0pt)
    #smallcaps[Draft version September 23, 2021] \
    Typeset using LaTeX in #text(weight: "bold")[twocolumn] style in AASTeX631
  ]

  #place(top + left, dy: 52.9pt)[
    #set par(justify: false, first-line-indent: 0pt, leading: 0.457em)
    #set text(size: 10pt, weight: "bold", hyphenate: false)
    #block(width: 100%)[#align(center)[A#h(1fr)_NICER_#h(1fr)VIEW#h(1fr)OF#h(1fr)THE#h(1fr)MASSIVE#h(1fr)PULSAR#h(1fr)PSR~J0740+6620#h(1fr)INFORMED#h(1fr)BY#h(1fr)RADIO#h(1fr)TIMING \
      AND _XMM-NEWTON_ SPECTROSCOPY]]
  ]

  #place(top + left, dy: 76.5pt)[
    #set text(size: 9pt)
    #set par(justify: false, first-line-indent: 0pt, leading: 0.472em)
    #block(width: 100%)[#align(center)[#smallcaps[Thomas E. Riley],#super[1] #smallcaps[Anna L. Watts],#super[1] #smallcaps[Paul S. Ray],#super[2] #smallcaps[Slavko Bogdanov],#super[3] #smallcaps[Sebastien Guillot],#super[4, 5] \
      #smallcaps[Sharon M. Morsink],#super[6] #smallcaps[Anna V. Bilous],#super[7] #smallcaps[Zaven Arzoumanian],#super[8] #smallcaps[Devarshi Choudhury],#super[1] #smallcaps[Julia S. Deneva],#super[9] \
      #smallcaps[Keith C. Gendreau],#super[8] #smallcaps[Alice K. Harding],#super[10] #smallcaps[Wynn C. G. Ho],#super[11] #smallcaps[James M. Lattimer],#super[12] #smallcaps[Michael Loewenstein],#super[13, 8] \
      #smallcaps[Renee M. Ludlam],#super[14, 15] #smallcaps[Craig B. Markwardt],#super[8] #smallcaps[Takashi Okajima],#super[8] #smallcaps[Chanda Prescod-Weinstein],#super[16] \
      #smallcaps[Ronald A. Remillard],#super[17] #smallcaps[Michael T. Wolff],#super[2] #smallcaps[Emmanuel Fonseca],#super[18, 19, 20, 21] #smallcaps[H. Thankful Cromartie],#super[22, 15] \
      #smallcaps[Matthew Kerr],#super[2] #smallcaps[Timothy T. Pennucci],#super[23, 24] #smallcaps[Aditya Parthasarathy],#super[25] #smallcaps[Scott Ransom],#super[23] #smallcaps[Ingrid Stairs],#super[26] \
      #smallcaps[Lucas Guillemot],#super[27, 28] and #smallcaps[Ismael Cognard]#super[27, 28]]]
  ]

  #place(top + left, dy: 160.9pt)[
    #set text(size: 8pt)
    #set par(justify: false, first-line-indent: 0pt, leading: 0.742em)
    #align(center)[#super[1]#text(style: "italic")[Anton Pannekoek Institute for Astronomy, University of Amsterdam, Science Park 904, 1090GE Amsterdam, the Netherlands] \
  #super[2]#text(style: "italic")[Space Science Division, U.S. Naval Research Laboratory, Washington, DC 20375, USA] \
  #super[3]#text(style: "italic")[Columbia Astrophysics Laboratory, Columbia University, 550 West 120th Street, New York, NY 10027, USA] \
  #super[4]#text(style: "italic")[IRAP, CNRS, 9 avenue du Colonel Roche, BP 44346, F-31028 Toulouse Cedex 4, France] \
  #super[5]#text(style: "italic")[Université de Toulouse, CNES, UPS-OMP, F-31028 Toulouse, France] \
  #super[6]#text(style: "italic")[Department of Physics, University of Alberta, 4-183 CCIS, Edmonton, AB, T6G 2E1, Canada] \
  #super[7]#text(style: "italic")[ASTRON, the Netherlands Institute for Radio Astronomy, Postbus 2, 7990 AA Dwingeloo, The Netherlands] \
  #super[8]#text(style: "italic")[X-Ray Astrophysics Laboratory, NASA Goddard Space Flight Center, Code 662, Greenbelt, MD 20771, USA] \
  #super[9]#text(style: "italic")[George Mason University, Resident at the U.S. Naval Research Laboratory, Washington, DC 20375, USA] \
  #super[10]#text(style: "italic")[Theoretical Division, Los Alamos National Laboratory, Los Alamos, NM 87545, USA] \
  #super[11]#text(style: "italic")[Department of Physics and Astronomy, Haverford College, 370 Lancaster Avenue, Haverford, PA 19041, USA] \
  #super[12]#text(style: "italic")[Department of Physics and Astronomy, Stony Brook University, Stony Brook, NY 11794-3800, USA] \
  #super[13]#text(style: "italic")[Department of Astronomy, University of Maryland, College Park, MD 207423] \
  #super[14]#text(style: "italic")[Cahill Center for Astronomy and Astrophysics, California Institute of Technology, Pasadena, CA 91125, USA] \
  #super[15]#text(style: "italic")[NASA Hubble Fellowship Program Einstein Postdoctoral Fellow] \
  #super[16]#text(style: "italic")[Department of Physics and Astronomy, University of New Hampshire, Durham, New Hampshire 03824, USA] \
  #super[17]#text(style: "italic")[MIT Kavli Institute for Astrophysics & Space Research, MIT, 70 Vassar St., Cambridge, MA 02139, USA] \
  #super[18]#text(style: "italic")[Department of Physics, McGill University, 3600 rue University, Montréal, QC H3A 2T8, Canada] \
  #super[19]#text(style: "italic")[McGill Space Institute, McGill University, 3550 rue University, Montréal, QC H3A 2A7, Canada] \
  #super[20]#text(style: "italic")[Department of Physics and Astronomy, West Virginia University, P.O. Box 6315, Morgantown, WV 26506, USA] \
  #super[21]#text(style: "italic")[Center for Gravitational Waves and Cosmology, West Virginia University, Chestnut Ridge Research Building, Morgantown, WV 26505, USA] \
  #super[22]#text(style: "italic")[Cornell Center for Astrophysics and Planetary Science and Department of Astronomy, Cornell University, Ithaca, NY 14853, USA] \
  #super[23]#text(style: "italic")[National Radio Astronomy Observatory, 520 Edgemont Road, Charlottesville, VA 22903, USA] \
  #super[24]#text(style: "italic")[Institute of Physics, Eötvös Loránd University, Pázmány P.s. 1/A, 1117 Budapest, Hungary] \
  #super[25]#text(style: "italic")[Max Planck Institute for Radio Astronomy, Auf dem Hügel 69, D-53121 Bonn, Germany] \
  #super[26]#text(style: "italic")[Dept. of Physics and Astronomy, University of British Columbia, 6224 Agricultural Road, Vancouver, BC V6T 1Z1 Canada] \
  #super[27]#text(style: "italic")[Laboratoire de Physique et Chimie de l'Environnement et de l'Espace - Université d'Orléans/CNRS, 45071, Orléans Cedex 02, France] \
  #super[28]#text(style: "italic")[Station de radioastronomie de Nançay, Observatoire de Paris, CNRS/INSU, 18330, Nançay, France]]
  ]

  #place(top + left, dy: 504pt)[
    #set par(justify: false, first-line-indent: 0pt)
    #set text(size: 9pt)
    #block(width: 100%)[#align(center)[(Received; Revised; Accepted; Published)]]
  ]

  #place(top + left, dy: 520.8pt)[
    #set par(justify: false, first-line-indent: 0pt)
    #set text(size: 10pt)
    #block(width: 100%)[#align(center)[Submitted to The Astrophysical Journal Letters]]
  ]

  #place(top + left, dy: 544.3pt)[
    #set par(justify: false, first-line-indent: 0pt)
    #set text(size: 10pt)
    #block(width: 100%)[#align(center)[ABSTRACT]]
  ]

  #place(top + left, dx: 33.9pt, dy: 558.5pt)[
    #set par(justify: true, first-line-indent: 0pt, leading: 0.467em)
    #set text(size: 10pt)
    #block(width: 442.4pt)[#h(9pt)We report on Bayesian estimation of the radius, mass, and hot surface regions of the massive millisecond pulsar PSR~J0740+6620, conditional on pulse-profile modeling of _Neutron Star Interior Composition Explorer_ X-ray Timing Instrument (_NICER_ XTI) event data. We condition on informative pulsar mass, distance, and orbital inclination priors derived from the joint NANOGrav and CHIME/Pulsar wideband radio timing measurements of #cite(<Fonseca20>, form: "prose"). We use _XMM-Newton_ European]
  ]

  #place(top + left, dy: 637.5pt)[
    #set par(justify: false, first-line-indent: 0pt, leading: 0.55em)
    #set text(size: 8pt)
    Corresponding author: T. E. Riley \
    #text(fill: rgb("#ec008c"))[t.e.riley\@uva.nl]
  ]

  ]
]
#pagebreak()

// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering).* #it.body]
}

#figure(
  placement: top,
  scope: "parent",
  supplement: none,
  caption: none,
  kind: "abstract",
  {
    set par(justify: true, first-line-indent: 0pt, leading: 0.467em)
    set text(size: 10pt)
    set align(left)
    block(width: 511.4pt)[#pad(left: 33.9pt)[#block(width: 442.4pt)[
      #v(1.3pt)
      Photon Imaging Camera spectroscopic event data to inform our X-ray likelihood function. The prior support of the pulsar radius is truncated at 16~km to ensure coverage of current dense matter models. We assume conservative priors on instrument calibration uncertainty. We constrain the equatorial radius and mass of PSR~J0740+6620 to be $12.39_(- 0.98)^(+ 1.30)$~km and $2.072_(- 0.066)^(+ 0.067)$~$M_⊙$ respectively, each reported as the posterior credible interval bounded by the 16% and 84% quantiles, conditional on surface hot regions that are non-overlapping spherical caps of fully-ionized hydrogen atmosphere with uniform effective temperature; _a posteriori_, the temperature is $log_10 ( T " [K]" ) = 5.99_(- 0.06)^(+ 0.05)$ for each hot region. All software for the X-ray modeling framework is open-source and all data, model, and sample information is publicly available, including analysis notebooks and model modules in the Python language. Our marginal likelihood function of mass and equatorial radius is proportional to the marginal joint posterior density of those parameters (within the prior support) and can thus be computed from the posterior samples.
      #v(21.5pt)
      #set par(hanging-indent: 48.6pt)
      #text(style: "italic")[Keywords:] dense matter --- equation of state --- pulsars: general --- pulsars: individual (PSR~J0740+6620) --- stars: neutron --- X-rays: stars
      #v(1.9pt)
    ]]]
  },
)






= INTRODUCTION <sec:intro>


The nature of supranuclear density matter, as found in neutron star cores, is highly uncertain. Possibilities include both neutron-rich nucleonic matter and stable states of strange matter in the form of hyperons or deconfined quarks @Oertel17 @Baym18 @Tolos20 @YangJ20 @Hebeler21. One way to determine the dense matter Equation of State (the EOS, a function of both composition and inter-particle interactions) is to measure neutron star masses and radii @Lattimer16 @Ozel16b. There are several possible methods, but in this Letter we focus on pulse-profile modeling @Watts16 @Watts19b[and references therein]. This requires precise phase-resolved spectroscopy, a technique that motivated the design and development of NASA's _Neutron Star Interior Composition Explorer_ (_NICER_).


The _NICER_ X-ray Timing Instrument (XTI) is a payload installed on the _International Space Station_. The primary observations carried out by _NICER_ are order megasecond exposures of rotation-powered X-ray millisecond pulsars (MSPs) that may be either isolated or in a binary system @bogdanov19a. Surface X-ray emission from the heated magnetic poles propagates to the _NICER_ XTI through the curved spacetime of the pulsar, and the compactness affects the signal registered by the instrument. However, these pulsars also spin at relativistic rates. So with a precisely measured spin frequency derived from radio timing and high-quality spectral-timing event data, we are also sensitive to rotational effects on surface X-ray emission, and therefore to the radius of the pulsar independent of the compactness @bogdanov19b[and references therein].


The first joint mass and radius inferences conditional#footnote[For an introduction to the concept of conditional probabilities within Bayesian inference see #cite(<Sivia06>, form: "prose")@Trotta08 @Hogg2012 @Gelman2013 @Clyde19 @Hogg2020.] on pulse-profile modeling of _NICER_ observations of a MSP were reported by #cite(<miller19>, form: "prose") and #cite(<riley19a>, form: "prose").


The target was PSR~J0030+0451, an isolated#footnote[No binary companion has ever been detected despite 20 years of intensive radio timing @Lommen00 @Arzoumanian18.] source spinning at approximately $205$~Hz. Being isolated, the radio timing model for this MSP has no dependence on its mass, in contrast to the radio timing model for an MSP in a binary. This meant that a wide prior on the mass had to be assumed in the pulse-profile modeling, which nevertheless - due to the high quality of the data set in terms of the number of pulsed counts - delivered credible intervals on the mass and radius posteriors at the $tilde 10 %$ level. These posterior distributions have been used to infer properties of the dense matter EOS (in combination with constraints from radio timing, gravitational wave observations, and nuclear physics experiments). To give a few examples, there have been follow-on studies constraining both parameterized EOS models @miller19 @raaijmakers19 @raaijmakers20 @Dietrich20 @Jiang20 @AlMamun21 and non-parameterized EOS models @Essick20 @Landry20, some focusing particularly on the neutron star maximum mass @LimY20 @Tews20b. Others have focused on specific nuclear physics questions: hybrid stars and phase transitions to quark matter @Tang20 @LiA20 @Christian20 @XieWJ20c @Blaschke20 @Alvarez20b; the three nucleon potential @Maselli20; relativistic mean-field models @Traversi20; muon fraction content @ZhangNB20; and the nuclear symmetry energy @Zimmerman20 @Biswas20. This is by no means an exhaustive review of the citing literature, but serves to give a flavor of how the previous _NICER_ result has been used.


Pulse-profile modeling also yields posterior distributions for the properties of the hot X-ray emitting regions on the star's surface, which are assumed to be related to the star's magnetic field structure @Pavlov97. The analysis of PSR~J0030+0451 implied a complex non-dipolar field @bilous19 and the posteriors have been used in follow-on studies of pulsar magnetospheres and radiation mechanisms @ChenAY20 @Suvorov20 @Kalapotharakos20.


The subject of this Letter is the rotation-powered millisecond pulsar PSR~J0740+6620, spinning at approximately 346~Hz as it orbits with a binary companion @Cromartie19. Being in a binary at a favorable inclination for measurement of the Shapiro delay allows the mass of this source to be measured independently via radio timing @HbkPulsAstro. #cite(<Cromartie19>, form: "prose") reported a mass of $2.14_(- 0.09)^(+ 0.10) M_⊙$, making this the highest (well-constrained) mass neutron star. High-mass neutron stars (with the highest central densities) are particularly powerful in terms of their potential to constrain the dense matter EOS. The mass alone can cut down parameter space, but a measurement of radius adds far more @HanS20 @XieWJ20.


The _North American Nanohertz Observatory for Gravitational Waves_ (NANOGrav) and _Canadian Hydrogen Intensity Mapping Experiment_ (CHIME) Pulsar collaborations recently joined forces to perform wideband radio timing of PSR~J0740+6620 @Fonseca20. They derived an updated measurement of the pulsar mass ($2.08 plus.minus 0.07 M_⊙$), its distance from Earth, and the orbital inclination. From these informative measurements and _NICER_ observations @Wolff20 comes the potential for synergistic constraints on X-ray pulse-profile parameters that do not appear in the wideband radio timing solution; in particular, the radius of PSR~J0740+6620 and the properties of the hot surface X-ray emitting regions conditional on a model. We report such inferences in this Letter.


We organize this Letter as follows. In @sec:modeling-procedure we summarize the pulse-profile model components; we provide additional detail about novel model components to augment the information in #cite(<riley19a>, form: "prose") and #cite(<bogdanov19b>, form: "prose"). @sec:modeling-procedure also covers the X-ray likelihood function---which is the probability of the _NICER_ XTI event data and the spectroscopic event data acquired by the _XMM-Newton_ European Photon Imaging Camera (EPIC)---and details about the prior probability density functions of model parameters that are fundamentally shared by all models or multiple models. In @sec:inferences we report model inferences and details about the prior probability density functions that are specific to a given surface hot region model. In @sec:discussion we discuss these inferences in detail, covering their physical implications and potential systematic errors. In @sec:conclusion we conclude by reporting the mass and radius constraints and commenting on the outlook for future pulse-profile modeling efforts. EOS inference using our derived mass-radius posterior is carried out in a companion paper @Raaijmakers21.


= MODELING PROCEDURE <sec:modeling-procedure>


The methodology in this Letter is largely shared with that of #cite(<riley19a>, form: "prose"), #cite(<bogdanov19b>, form: "prose"). In this section, we summarize that methodology and give a more detailed report of the new model components.


We formulate the general form of the likelihood function shared by all models and also the prior probability density functions (PDFs) of parameters that are shared by all models. We reserve definitions of prior PDFs of phenomenological surface hot region parameters for @sec:inferences where posterior inferences are reported. All posterior PDFs are computed using the _X-ray Pulse Simulation and Inference_ (_X-PSI_) `v0.7` framework @xpsi, an updated version of the package used by #cite(<riley19a>, form: "prose").#footnote[#link("https://github.com/ThomasEdwardRiley/xpsi")] The analysis files may be found in the persistent repository of #cite(<zenodo>, form: "prose"): the data products; the numeric model files including the telescope calibration products; model modules in the Python language using the _X-PSI_ framework; posterior sample files; and Jupyter analysis notebooks. We begin by introducing the data sets used in the analysis, including the most important aspects of the data selection and preparation.


== X-ray event data <x-ray-event-data>
In this section we summarize the event data sets reported by #cite(<Wolff20>, form: "prose"), including any pre-processing tailored to this present Letter.


=== _NICER_ XTI <nicer-xti>


The PSR J0740+6620 analysis is based on a sequence of exposures with _NICER_ XTI (hereafter _NICER_) acquired in the period 2018 September 21 -- 2020 April 17. The event data was obtained using similar filtering criteria to the previously analyzed _NICER_ data set of PSR J0030+0451. We only used good time intervals when all 52 active detectors were collecting data but rejected all events from DetID 34, as it often shows enhanced count rates relative to the other 51 detectors. We excluded time intervals when PSR J0740+6620 was situated at an angle $<= 80 degree$ from the Sun to reduce the increase in background in the lowest channels due to optical loading. We further excised events collected at low cut-off rigidity (COR\_SAX values $< 5$) to minimize particle background contamination. The resulting cleaned event list has an on-source exposure time of 1602683.761 s.


We model events registered in the PI channel subset $[ 30 , 150 )$, corresponding to the nominal photon energy range $[ 0.3 , 1.5 ]$~keV.#footnote[A photon that deposits all of its energy, $E in [ 0.3 , 1.5 )$~keV, in a detector with perfect energy resolution is registered in channel subset $[ 30 , 150 )$ after mapping according to the gain-scale calibration product.] The quoted nominal photon energy for a channel is the energy mid-point for that channel.


Below nominal energy $0.3$~keV, the instrument calibration products have greater _a priori_ uncertainty due to the sharp lower-energy threshold cutoff, as well as the presence of unrejected instrumental noise that can extend above 0.25~keV. We therefore neglect the information below channel $30$ in order to reduce the risk of inferential bias. #cite(<Wolff20>, form: "prose") detect pulsations with the highest significance when considering event data up to nominal energy $tilde  1.2$~keV; in this Letter we include the additional information at nominal energies in the range $[ 1.2 , 1.5 ]$~keV. The number of counts generated by the PSR~J0740+6620 hot regions in channels $150$ and above, however, is small and diminishes relative to the counts generated by background processes (including a non-thermal component from the environment in the near-vicinity of PSR~J0740+6620); we therefore neglect this higher-energy information, and focus energy resolution at nominal energies below $1.5$~keV.


The _NICER_ event data are phase-folded according to the NANOGrav radio timing solution presented in #cite(<Fonseca20>, form: "prose"). The phase-binned count numbers are displayed in #ref(<fig:J0740-count-data>).





// [figvision] imgs/f1.png
// a. The top panel is a plot of counts versus rotational phase. The y-axis ranges from 9400 to 10000 counts and
// the x-axis ranges from 0 to 2 cycles. There is one series, a black line with a step-like style. An error bar
// is shown in red. The trend shows a pulse profile with peaks and troughs, indicating variability in counts over
// rotational phase. b. The bottom panel is a 2D histogram or heatmap of counts versus channel and rotational
// phase. The y-axis ranges from channel 30 to 150 and the x-axis ranges from 0 to 2 cycles. The color scale
// ranges from 40 to 160 counts. There is one series, with colors ranging from dark blue (low counts) to yellow
// (high counts). The trend shows generally consistent counts across channels and phases, with some variation.
#figure(scope: "parent", placement: top, image("imgs/f1.png", width: 75.0%),
  caption: [
    Phase-folded PSR~J0740+6620 event data for two rotational cycles (for clarity): we use $32$ phase intervals (bins) per cycle and the count numbers in bins separated by one cycle---in a given channel---are identical. The total number of counts is given by the sum over all phase-channel pairs. The _top_ panel displays the pulse-profile summed over the contiguous subset of channels $[ 30 , 150 )$. We use the _red_ bar to indicate the typical standard deviation that an adequately performing Poisson count model will exhibit. The _bottom_ panel displays the phase-channel resolved count numbers for channel subset $[ 30 , 150 )$. For likelihood function evaluation we group all event data registered in a given channel into phase intervals spanning a single rotational cycle. The description in this caption is based on that given by #cite(<riley19a>, form: "prose") about the corresponding count-number figure for PSR~J0030+0451.
  ]
) <fig:J0740-count-data>






=== _XMM-Newton_ EPIC <xmm-newton-epic>


The _XMM-Newton_ (hereafter _XMM_) telescope observed PSR~J0740+6620 as part of a Director's Discretionary Time program in three visits: 2019 October 26 (ObsID 0851181601), 2019 October 28 (ObsID 0851181401), and 2019 November 1 (ObsID 0851181501). The European Photon Imaging Camera (EPIC) instruments (pn, MOS1, and MOS2) were employed in 'Full Frame' imaging mode with the 'Thin' optical blocking filters in place. Due to the insufficiently fast read-out times (73.4~ms for EPIC-pn and 2.6~s for EPIC-MOS1/2), the data do not provide useful pulse timing information, so only phase-averaged spectral information is available. The _XMM_ data were reduced using the Science Analysis Software (SAS#footnote[The _XMM-Newton_ SAS is developed and maintained by the Science Operations Centre at the European Space Astronomy Centre and the Survey Science Centre at the University of Leicester.]) using the standard set of analysis threads.


The event data were first screened for periods of strong soft proton background flaring. The resulting event lists were then further cleaned by applying the recommended PATTERN ($<= 12$ for MOS1/2 and $<= 4$ for pn) and FLAG ($0$) filters. The final source event lists were obtained by extracting events from a circular region of radius 25$''$ centered on the radio timing position of PSR~J0740+6620. This resulted in effective exposure times of 6.81, 17.96, and 18.7 ks for the pn, MOS1, and MOS2 instruments, respectively.


== Radiation propagation from surface to telescope <sec:radiation-propagation>


=== Design of the equatorial radius prior <sec:radius-prior-design>


One of the ultimate aims of this Letter is to report a likelihood function of mass and (equatorial) radius that can be used for EOS posterior computation. As highlighted by #cite(<Riley18>, form: "prose"), it is desirable to define a prior PDF which is jointly flat with respect to two parameters within the prior support; these parameters can simply be mass and radius, or some deterministically related variables, such as mass and compactness. The marginal joint posterior PDF of these parameters is then proportional to the marginal likelihood function of these parameters, meaning that the marginal likelihood function can be estimated from posterior samples, for use in subsequent inferential analyses.


In this Letter we follow #cite(<riley19a>, form: "prose") by defining a joint prior PDF of mass and radius that is flat within the prior support, which is maximally inclusive in regards to theoretical EOS predictions. The prior support is zero for $R > 16$~km because we are not aware of any EOS models predicting a radius higher than this limit that would be compatible with current constraints from nuclear physics, or with the constraints posed by the gravitational wave measurement of tidal deformability for the binary neutron star merger GW170817 @Reed21. A difference to #cite(<riley19a>, form: "prose") is that we define the prior support using a higher compactness limit as discussed in @sec:ray-tracing (see @table:-ST-U for the prior PDF and support). The prior support is also subject to the condition that the effective gravity lies within a bounded range at every point of the rotating oblate surface, in order to conform to bounds on the atmosphere models we condition on (see @sec:atmosphere-setup and @table:-ST-U).


In @sec:radio we introduce information about the mass in the form of a marginal PDF whose shape approximates the marginal likelihood function of mass derived in a recent radio timing analysis; we multiply this likelihood function with the jointly flat prior PDF of mass and radius described above, thereby defining an updated prior PDF for the X-ray pulse-profile modeling in this Letter. Our prior PDF for pulse-profile modeling is therefore not jointly flat with respect to mass and radius, but all shape information is likelihood-based, satisfying the requirements of #cite(<Riley18>, form: "prose").


=== Mass, inclination, and distance priors <sec:radio>


Radiation is transported from the oblate X-ray emitting surface to distant static telescopes by relativistic ray-tracing, as described by #cite(<bogdanov19b>, form: "prose") and references therein. The gravitational mass of PSR~J0740+6620, the distance of PSR~J0740+6620 from Earth, and the inclination of the Earth's line-of-sight to the PSR~J0740+6620 spin axis are all parameters of the source-receiver system that need to be specified in order to simulate an X-ray signal incident on a telescope, and can be inferred via pulsar radio timing. Note that these static model X-ray telescopes are fictitious constructs: the real telescopes are in motion relative to the pulsar @riley_thesis. The _NICER_ event data pre-processing operations include the phase-folding of on-board arrival times according to a NANOGrav radio timing solution; the phase-folded events are then the events that would be registered by a telescope that is static relative to the pulsar.


The NANOGrav and CHIME/Pulsar collaborations jointly performed wideband radio timing of PSR~J0740+6620 @Fonseca20 @FonsecaZen21. A product of this radio timing work was a joint posterior PDF of the pulsar gravitational mass, Earth distance, and the inclination Earth subtends to the orbital direction#footnote[The pulsar spin angular momentum is assumed to be parallel to the orbital angular momentum, but we also test sensitivity to an isotropic spin-direction prior.] that we can condition on as an informative prior PDF for joint _NICER_ and _XMM_ X-ray pulse-profile modeling. The synergy---due to degeneracy breaking---between radio timing and X-ray modeling yields a higher sensitivity to the pulsar radius and the parameters of a surface X-ray emission model. We used two sets of joint posterior PDFs provided by #cite(<Fonseca20>, form: "prose") as prior information over the course of our analysis: one set that was numerically estimated using a weighted least-squares solver, used in this Letter for an exploratory analysis (@sec:exploratory); and a second that instead used a generalized least-squares (GLS) algorithm for determining timing model parameters from wideband timing data, used in this Letter for a production analysis (@sec:production-analysis). #cite(<Fonseca20>, form: "prose") report on results obtained with GLS fitting of wideband timing data, though they publicly provide both sets of PDFs as they were used in this work.


Systematic error in the parameter estimates by NANOGrav and CHIME/Pulsar is dominated by sensitivity to the choice of the dispersion-measure variability (DMX) model. Posterior PDFs were computed for three DMX variants, and the systematic error implied by the posterior variation was substantially smaller than the formal posterior spread conditional on any one DMX model. We average (marginalize) the posterior PDFs over the three DMX models with a uniform weighting.#footnote[Equivalent to choosing a prior mass function of the DMX models that yields posterior probability ratios of unity between those models.]


The prior PDFs we implement for every model that conditions on joint NANOGrav and CHIME/Pulsar wideband radio timing are as follows. The distance is separable from the pulsar mass and the Earth inclination to the orbital axis, but the mass and (cosine of the) inclination are correlated. For the distance, we implement the NANOGrav~$times$~CHIME/Pulsar measurement by first marginalizing the PDFs over the DMX models and then reweighting from the flat distance prior conditioned on by NANOGrav and CHIME/Pulsar to a physical distance prior in the direction of PSR~J0740+6620 following the exemplar treatment of distance information by #cite(<Igoshev16>, form: "prose").#footnote[The ecliptic coordinates of PSR~J0740+6620 reported by #cite(<Arzoumanian18>, form: "prose") were transformed to galactic coordinates using Astropy @astropy2013 @astropy2018.] The physical distance prior, however, remains relatively flat in the context of the likelihood function---meaning the likelihood function is dominant in the measurement---and the modification to the original DMX-averaged PDF is entirely minor. Additional distance likelihood information derives from the Shklovskii effect which effectively truncates the PDF, putting an upper limit on the distance @Shklovskii70; such truncation however occurs well into the tail of the NANOGrav~$times$~CHIME/Pulsar distance distribution, so it is also an unimportant detail. Finally, we approximate the NANOGrav~$times$~CHIME/Pulsar marginal PDF of distance as a skewed and truncated Gaussian distribution (please see @table:-ST-U for details). We display the marginal distance PDF variants referenced above in #ref(<fig:marginal-distance-PDFs>).


For the mass and the (cosine of the) orbital inclination we implement a multi-variate Gaussian distribution with the covariance matrix of the DMX-averaged PDF. Implicit in this PDF is a prior PDF defined by the radio timing collaboration. The marginal prior PDF of the pulsar mass is _not_ flat: the prior PDF of the cosine of the orbital inclination and of the mass of the white dwarf companion of PSR~J0740+6620 is jointly flat, and these variables map deterministically to the pulsar mass through the binary mass function and (precise) radio timing of the system. We do not modify the joint prior PDF of the pulsar mass and the inclination despite the likelihood function of the pulsar mass (marginalized over all other radio timing parameters) being formally desirable for EOS parameter estimation (see @sec:radius-prior-design and #cite(<Riley18>, form: "prose")). In this case the posteriors are sufficiently dominated by the likelihood function to ignore the small structural modifications that would result from tweaking relatively diffuse priors. Moreover, changing the pulsar mass prior PDF would change the prior PDF of the companion, which may be undesirable.


Ultimately, handling the detailed structure#footnote[Please see @fig:marginal-distance-PDFs for reference. The form of the DMX-marginalized joint mass and inclination prior PDF is the dominating factor in the posterior PDF rendered in @fig:ST-U-spacetime-corner; for supplementary plots of the variation of the joint prior PDF of mass and inclination with DMX model, please refer to the analysis notebooks released with this Letter, in which the model components are constructed.] of these prior PDFs---i.e., beyond the location and marginal spread of the parameters---is not important because the _NICER_ likelihood function is not sufficiently sensitive to some combination of these radio-timing parameters and its native parameters (such as equatorial radius) for posterior inferences to change to any discernable degree. That is, the changes will be difficult to resolve from sampling noise and implementation error for instance @higson2018sampling @higson2019diagnostic, and relative to model-to-model systematic variations that, when marginalized over, further broaden the posteriors of shared parameters of interest. Also note that the distance only enters in the likelihood function in combination with the effective-area scaling parameter defined in @sec:response-models that operates on all X-ray instrument response models because of global calibration error; the distance to PSR~J0740+6620 could therefore be combined with this absolute scaling parameter, further diminishing the importance of treating fine details in the prior PDF of the distance.





// [figvision] imgs/f2.png
// The figure shows a plot with multiple series. The x-axis represents distance in kiloparsecs (kpc) and ranges
// from 0.6 to 2.0. The y-axis represents probability density and ranges from 0.0 to 2.5. There are seven series:
// DMX-6.5 (dot-dashed red), DMX-3.0 (dashed red), DMX-hybrid (dotted red), DMX-marginalized (solid red), prior
// (dot-dashed black), posterior (solid black), and approx. (dashed blue). The plot shows that the posterior and
// approx. distributions are very close, while the prior distribution is much flatter. The trend is that the
// probability density increases and then decreases as distance increases.
#figure(placement: top, image("imgs/f2.png", width: 100%),
  caption: [
    Implementation of the joint NANOGrav and CHIME/Pulsar posterior PDF of distance @Fonseca20 as a prior PDF in the context of joint _NICER_ and _XMM_ X-ray pulse-profile modeling. The _red_ distributions are marginal posterior PDFs of the distance derived by NANOGrav and CHIME/Pulsar, conditional on a flat prior PDF; the _solid red_ distribution is the posterior PDF marginalized over the three DMX models, and each of the lightweight _red_ distributions is a posterior PDF conditional on a particular DMX model. These posterior PDFs of distance are proportional to the marginal likelihood function of distance. The _black dash-dot_ PDF is the prior distribution of galactic pulsars in the direction of PSR~J0740+6620, adopted from #cite(<Igoshev16>, form: "prose") and renormalized to the interval $D in [ 0.6 , 2.0 ]$~kpc on which the NANOGrav~$times$~CHIME/Pulsar PDF is supported. The _black solid_ distribution is the posterior PDF of distance conditional on the _black dash-dot_ prior PDF. The _blue dashed_ distribution is an approximating PDF that we condition on as a prior PDF for the pulse-profile modeling in this Letter, after renormalizing to be supported on the interval $D in [ 0.0 , 1.7 ]$~kpc; please refer to @table:-ST-U for details needed to reproduce this approximating PDF.
  ]
) <fig:marginal-distance-PDFs>






=== Relativistic ray-tracing <sec:ray-tracing>


The original version of the _X-PSI_ package used to model PSR~J0030+0451 @riley19a via relativistic ray-tracing assumed that no more than one ray connected the telescope to each point on the stellar surface. However, photons emitted from a star with compactness greater than $G M / R c^2 = 0.284$ can have a deflection angle larger than $pi$, which makes multiple images of small regions at the “back” of the star possible. This was not an issue for the analysis of PSR~J0030+0451, because the 95% credible region only allowed compactness values in the range of $G M / R c^2 <= 0.171$. Additionally, the independent analysis by #cite(<miller19>, form: "prose") allowed for the possibility of multiply-imaged regions on the star but still led to a credible range on compactness that is too small to allow for multiple images.


The radio observations of Shapiro delay in the PSR~J0740+6620 binary system by NANOGrav and CHIME/Pulsar @Fonseca20 lead to the marginal 68% credible interval of $M = 2.08 plus.minus 0.07$~$M_⊙$. For reference, a small selection of EOS that cover a realistic range of stiffness are shown in @fig:compactness-vs-mass. The EOS shown include a set of three EOS (HLPS soft, intermediate, and stiff) constructed by #cite(<Hebeler13>, form: "prose") that span a range of stiffness allowed by nuclear experiments, as well as the A18$+ delta ( v )$+UIX\* EOS @Akmal98 (abbreviated to APR). Each of the four curves shows the values of the equatorial compactness and mass for stars rotating at the rate of 346~Hz, computed using the code `rns` @Stergioulas95. @fig:compactness-vs-mass shows that for this set of EOS, the large mass values ($> 2.0 M_⊙$) lead to a significant range of models that have large enough compactness (i.e., are above the horizontal line at 0.284) that multiple images of some part of the star are possible. Because the stars are oblate, the compactness at the spin poles is larger than the equatorial compactness, so the range of multiply-imaged stars extends to slightly lower values of compactness, however the change is not perceptible on this figure.


Due to the expectation that PSR~J0740+6620 could be very compact, the _X-PSI_ code was extended to allow multiple rays from any point to reach the telescope. This improvement to _X-PSI_ as well as details of code validation are discussed in #cite(<Bogdanov19c>, form: "prose"). _X-PSI_ sums over the primary and the visible higher-order images of any regions on a star that lie in a multiply-imaged region. The _X-PSI_ package can typically detect up to the quaternary, quinary, or senary order depending on resolution settings. In practice only secondary images, and potentially the tertiary images for some configurations, might be important; but omission of secondary images can lead to large errors of $cal(O) ( 10 % )$ in the light-curve calculation (see, e.g., the _X-PSI_ documentation#footnote[#link("https://thomasedwardriley.github.io/xpsi/multiple_imaging.html")]).





// [figvision] imgs/f3.png
// The figure is a plot showing the relationship between equatorial compactness and mass for stars spinning at
// 346 Hz. The y-axis represents equatorial compactness, ranging from 0.18 to 0.32, and the x-axis represents
// mass in solar masses (M), ranging from 1.8 to 2.8. There are four series, each representing a different
// equation of state (EOS) model: APR (red, solid), HLPS soft (black, dashed), HLPS int. (black, dash-dotted),
// and HLPS stiff (black, solid). The shaded regions indicate the 95% interval for the mass prior (purple) and
// the region above compactness 0.284 where multiple images of the equator can appear (teal). The trend shows
// that as mass increases, equatorial compactness also increases for all EOS models, with the APR model having
// the steepest slope. The plot suggests that the HLPS stiff model has the lowest compactness for a given mass,
// while the APR model has the highest.
#figure(placement: top, image("imgs/f3.png", width: 100%),
  caption: [
    Equatorial compactness ($G M / R c^2$) versus mass for stars spinning at a rate of 346~Hz. The relations for four example EOS models (see text for description) are shown. The 95% interval for the mass prior is shaded, as is the region above compactness 0.284 where multiple images of the equator can appear. Note that for a range of compactness below 0.284, non-equatorial surface regions are multiply imaged due to oblateness. For the high masses of interest, multiple imaging is clearly relevant.
  ]
) <fig:compactness-vs-mass>







=== Interstellar attenuation of X-rays <interstellar-attenuation-of-x-rays>


The X-ray signal is attenuated to some degree by the intervening interstellar medium along the line of sight to the pulsar. In all models, the attenuation physics is parameterized solely by the neutral hydrogen column density $N_(upright(H))$, relative to which the abundances of all other attenuating gaseous elements, dust, and grains are fixed by the state-of-the-art `TBabs` model @Wilms2000[updated in 2016]. We implement this attenuation model as a one-dimensional lookup table with respect to energy at a fiducial column density, and then raise the attenuation factor to the power of the ratio of the column density to the fiducial value.


The column density along the line of sight to PSR~J0740+6620 can be estimated using several techniques. The HEASARC neutral hydrogen map tool#footnote[#link("https://heasarc.gsfc.nasa.gov/cgi-bin/Tools/w3nh/w3nh.pl")] yields $N_(upright(H)) approx 3.5 times 10^20$~$"cm"^(-2)$ given the most modern map @HI4PIcollab2016.#footnote[Neutral hydrogen maps provide an integrated estimate along the line of sight through the Milky Way, and can therefore be interpreted as an approximate upper limit.].


Using the relation between dispersion measure (DM) and $N_(upright(H))$ from #cite(<He2013>, form: "prose") together with the DM measurement reported by #cite(<Cromartie19>, form: "prose"), $N_(upright(H)) approx 4.5 times 10^20$~$"cm"^(-2)$. Finally, estimates based on 3D $E (B - V)$ extinction maps @Lallement2018, together with the relation between extinction and $N_(upright(H))$ from #cite(<Foight2016>, form: "prose"), yield values of $N_(upright(H)) approx 4.5 times 10^20$~$"cm"^(-2)$.


Given that $N_(upright(H))$ could be as large as $4.5 times 10^20$~$"cm"^(-2)$ based on these estimates, and given the large uncertainties in the relations between $N_(upright(H))$ and other quantities such as the DM, a conservative prior of $N_(upright(H)) tilde U ( 0 , 10^21 )$~$"cm"^(-2)$ is warranted.


== Surface hot regions <surface-hot-regions>


=== Temperature field <sec:temp-field>


The surface effective temperature field of a rotation-powered MSP is one of---if not the---primary source of uncertainty _a priori_ regarding the physical processes that generate the X-ray event data. The image of a neutron star cannot be resolved with any current X-ray telescope, so all our knowledge about the surface temperature field comes from models. These models heavily rely on the assumptions about magnetic field configuration, which is a crucial part in calculating heating by space-like or return current in some sub-region of the open field line footprints @Kalapotharakos20 or anisotropic thermal conductivity of the outer star layers @Kondratyev20 @deGrandis20. There is, therefore, an essentially unknown degree of complexity in the structure of the temperature field.


A given likelihood function is insensitive to complexity beyond some degree. We focus on a simple model of the surface temperature field: two disjoint hot regions that are simply-connected spherical caps (when projected onto the unit sphere) wherein the effective temperature of the atmosphere is uniform. This model may be identified as `ST-U` in #cite(<riley19a>, form: "prose"). The phase-folded _NICER_ pulse-profile is suggestive of two phase-separated hot regions which may or may not be disjoint.


We could begin with an even simpler model that restricts the hot regions to be related via antipodal reflection symmetry @riley19a. Computing a posterior conditional on such a simple surface hot region model is justifiable, and it also delivers a lower-dimensional target distribution to check for egregious model implementation error @riley19a. However, for the analysis reported in this Letter, we immediately explored the `ST-U` model because antipodal reflection symmetry is physically unrealistic and the `ST-U` model is sufficiently simple and inexpensive to condition on; nevertheless, if one is interested in the question of whether we are sensitive to deviations from this symmetry, we open-source the entire analysis package for this Letter, and the online _X-PSI_ documentation offers guidance on how to condition on the `ST-S` model.


Nodes can be added to the model space by incrementing the complexity of the surface hot regions, following #cite(<riley19a>, form: "prose"), wherein symmetries between hot regions are broken#footnote[That is, the breaking of antipodal reflection symmetry and of shape symmetry.] and temperature components are added.#footnote[All models in #cite(<riley19a>, form: "prose"), two of which we condition on in this Letter, can be labeled by the number of disjoint hot regions they define. Note that in practice the prior PDFs of temperature and solid angle subtended at the stellar center are diffuse and permit the contribution of a hot region to be negligible _a posteriori_ in the _NICER_ and _XMM_ wavebands.] In this Letter we introduce a new binary flag for the atmosphere composition (hydrogen or helium as discussed in @sec:atmosphere-setup) within the (single-temperature) hot regions. However, we consider only one higher-complexity model than `ST-U`. We opt to do this because subject to limited (computational) resources, `ST-U` performs well and is ultimately determined to be sufficiently complex.


We now define prior PDFs that are shared by all models. Every hot region has one effective temperature component. The prior PDF of that effective temperature is flat in its logarithm, diffuse,#footnote[For example, with prior support bounds of $10^5.1$~K and $10^6.8$~K for the NSX fully-ionized hydrogen atmosphere---please see #ref(<sec:atmosphere-setup>).] and is separable from the joint prior PDF of all other model parameters. Every hot region also has a colatitude coordinate and an azimuth coordinate (i.e., phase shift) at the center of a constituent spherical cap with a finite effective temperature component @riley19a. The prior PDF of these coordinates is non-trivial because it is not separable from the prior PDF of other parameters when there are two surface hot regions in the model, as we proceed to explain.


In order to eliminate a trivial form of hot region exchange-degeneracy,#footnote[Where precisely the same hot region configuration exists twice in parameter space, only one of which the prior support should include.] we define the prior support by imposing that one hot region object in the _X-PSI_ model has a center colatitude that is always less than or equal to the center colatitude of the companion hot region. We also impose that the hot regions are disjoint, meaning that they cannot overlap in the prior support, because otherwise the model cannot always be characterized by the number of disjoint hot regions; the non-overlapping condition is a function of the center colatitudes, the center azimuths, and the hot region angular radii, meaning that the joint prior is not separable, and the marginal prior PDFs are modulated relative to the PDFs that were used to construct the form of the joint PDF in six dimensions. For instance, the joint prior PDF of the azimuthal coordinates exhibits rarefaction where the azimuths are close in value.


We now construct the prior PDF specifically for the `ST-U` model (@sec:production-analysis) that is the focus of this Letter. First, as a construction tool, define a flat PDF of the cosine of each hot region center colatitude, with support being the interval $cos ( Theta ) in [ - 1 , 1 ]$; such a PDF is founded on the argument of isotropy, _a priori_, of the direction to Earth (see below). Second, define the PDF of each hot region center azimuth#footnote[A periodic parameter, also referred to as cyclic or wrapped.] to be flat on the interval $2 pi phi.alt in [ 0 , 2 pi ]$~radians. Third, define a flat PDF of each angular radius on the interval $[ 0 , pi / 2 ]$. To calculate the marginal prior PDF of one of these parameters, marginalize over the other five parameters subject to the prior support condition of non-overlapping hot regions. For instance, the prior PDF of a hot region angular radius is given by marginalizing over the angular radius of the companion hot region, and the hot region center colatitudes and azimuths. Marginalization yields a marginal prior PDF that deviates in form from the initially flat PDF of the parameter---the support of the PDF remains unchanged however.


Our hot region models are phenomenological and to a degree, agnostic, despite being influenced by temperature fields implied by pulsar magnetospheric simulations. Our choice here is contrary to #cite(<riley19a>, form: "prose"), wherein the prior PDF of the colatitude at the center of a hot region in isolation---meaning one hot region on the surface---was flat. A flat PDF of colatitude, combined with a flat prior in azimuth yields an anisotropic probability density field on the unit sphere, weighted towards polar regions. One reason this might be a sub-optimal assumption is because of X-ray selection effects: pulsed emission from two hot regions will exhibit a larger amplitude if the hot regions are closer to the equatorial zone than a polar zone, for equatorial observers as is the case assumed for PSR~J0740+6620 based on the NANOGrav~$times$~CHIME/Pulsar wideband radio timing measurements (@sec:radio). However, such arguments are tenuous, taking no heed of radio selection effects and magnetospheric physics, for instance.


=== Atmosphere <sec:atmosphere-setup>


The specific intensity is determined from lookup tables generated using the `NSX` atmosphere code assuming either fully ionized hydrogen or helium @Ho01 or partially ionized hydrogen @Ho09.#footnote[Note that only the composition within the hot regions is explicitly defined for the purpose of signal generation.] In this work, we consider only fully ionized models since the limited parameter ranges of existing opacity tables @OPAL @OP @OPLIB reduce the accuracy of atmosphere models employing these tables (see #cite(<Bogdanov19c>, form: "prose") and #cite(<IMJ0740>, form: "prose") for further discussion and comparisons).


=== Exterior of the hot regions <sec:exterior-of-the-hot-regions>


The surface exterior to the hot regions does not explicitly radiate in any model we condition on. The signal that would be generated by a cooler exterior surface can be robustly subsumed in the phase-invariant count rate terms described in @sec:XTI-backgrounds, provided that the angular scale of the hot regions (whose images are explicitly integrated over) is small and that exterior emission is soft and thus dominated by other _NICER_ backgrounds in the channels with low nominal photon energies. Explicitly including radiation from the exterior surface would add a very weakly informative mode of dependence on the mass, radius, and other parameters of interest, and thus the likelihood function is assumed insensitive to its exact treatment. Explicit treatment would also require handling of the ionization state of the cooler atmosphere.


== Instrument response models <sec:response-models>


For _NICER_ and each of three _XMM_ EPIC cameras we use a tailored ancillary response file (ARF) and redistribution matrix file (RMF) to compose an on-axis response matrix. For each of the _XMM_ cameras, the ARF and RMF are those specific to the PSR~J0740+6620 extraction regions.


For _NICER_, we use the most recent calibration products made available by the instrument team, namely the nixtiref20170601v002 RMF and the nixtiaveonaxis20170601v004 ARF. For the latter, the effective areas per energy channel were rescaled by a factor of $51 / 52$ to account for the removal of all events from DetID 34. The instrument response products (RMF and ARF files) for the _XMM_ pn, MOS1, and MOS2 cameras tailored to the PSR~J0740+6620 observations were produced with the `rmfgen` and `arfgen` commands in SAS and products from the Current Calibration Files repository.


Calibration of the performance of _NICER_ is conducted mainly with observations of the Crab pulsar and nebula. The energy-dependent residuals in the fits to the Crab spectrum are generally $lt.tilde 2 %$#footnote[See #link("https://heasarc.gsfc.nasa.gov/docs/heasarc/caldb/nicer/docs/xti/NICER-xti20200722-Release-Notesb.pdf") for further details.]. The calibration accuracy for the _XMM_ MOS and pn instruments is reported to be less than 3% and 2% (at 1$sigma$), respectively #footnote[See in particular Table 1 in #link("https://xmmweb.esac.esa.int/docs/documents/CAL-TN-0018.pdf").] However, in the absence of a suitable absolute calibration source, the absolute energy-independent effective area of _NICER_ and the three _XMM_ detectors is uncertain at an estimated level of $plus.minus 10 %$.


We define a free parameter that operates as an energy-independent scaling factor shared by all instruments due to the lack of a perfect astrophysical calibration source. Further, for each of _NICER_ and _XMM_, we define a free parameter that also operates as an energy-independent effective area scaling. The _overall_ scaling factor for each telescope is a coefficient of the response matrix, defined as the product of the shared scaling factor and the _a priori_ statistically independent telescope-specific scaling factor. The overall scaling factors of different instruments are therefore correlated _a priori_ to simulate---in an albeit simple way---the absolute uncertainty of X-ray flux calibration and the instrument-to-instrument calibration product errors. However, the correlated prior PDF is such that the effective area for _NICER_ is permitted to decrease from the nominal effective area whilst the effective area for _XMM_ can increase from its respective nominal effective area, and vice versa. We choose the statistically independent telescope-specific scaling factors to have equal spread _a priori_ to the scaling factor shared by all instruments of $plus.minus 10 %$, therefore yielding a more conservative joint prior PDF of the overall scaling factors that we approximate as a bivariate Gaussian (see @table:-ST-U). We discuss posterior sensitivity to effective area prior information in #ref(<sec:XMM-constraining-power>).


The response models are implicitly assumed to accurately represent the time-averaged operation of the instruments during the (composite) exposures to PSR~J0740+6620.


== Likelihood function and backgrounds <likelihood-function-and-backgrounds>


In this section we formulate the likelihood function as the conditional probability of the _NICER_ and _XMM_ event data sets.#footnote[The domain of the likelihood function is a subset of the model parameter space (which is in general discrete-continuous mixed). The domain of the more general parameterized sampling distribution is a subset of the Cartesian product of the model parameter space and the data space; the likelihood function is the function that this sampling distribution reduces to when the data-space variables become fixed by observation.] The relative constraining power offered by the _XMM_ likelihood function is weak, but we provide detail about the methodology with the overarching aim of supporting the use of imaging observations in ongoing and future _NICER_ pulse-profile modeling efforts.


The expected photon specific flux signal generated by the surface hot regions is calculated as a function of rotational phase (over a single rotational cycle) and energy, by integrating over the photon specific intensity image on the sky of a distant static instrument @bogdanov19b. We then assume that an adequately performing model of both the _NICER_ and _XMM_ event data sets can be constructed by operating on the same incident signal. The count number statistics for both _NICER_ and all _XMM_ cameras is Poissonian: for every detector channel of the four instruments---and then for _NICER_ every phase interval associated with a channel---the sampling distribution from which the registered count-number variate is drawn is assumed to be a Poisson distribution with an expectation that is a function of parameters of the incident signal and parameters of the model instrument response.


The _NICER_ event time-tagging resolution is state-of-the-art, and PSR~J0740+6620 is sufficiently faint that in the absence of backgrounds, the event arrival process statistics would deviate in an entirely minor way from the incident photon Poisson point process; in reality we contend with background radiation, and deadtime corrections to the integrated exposure time are calculated during event data pre-processing. Pile-up, the registering of multiple photons as a single event during a detector readout interval, is not an issue for _XMM_ because the source is so faint.


As we expound upon in @sec:XTI-backgrounds~and~@sec:XMM-background, the background event data for all four instruments---after implementation of filters during data pre-processing---is modeled with a set of count rate variables, one per detector channel. As a corollary of the assumptions stated above, the background processes contributing to these events are also assumed to be Poissonian event arrival processes. The expectations of the sampling distributions of the registered count-number variates are simply sums of the expected count numbers from the PSR~J0740+6620 surface hot regions and the expected background count numbers. Refer to #cite(<riley19a>, form: "prose") for details about the _NICER_ count-number sampling distribution---the form of the _XMM_ camera count-number sampling distribution follows by a phase-averaging operation.


=== NICER <sec:XTI-backgrounds>


Let $d_(upright(N))$ be the _NICER_ count matrix over phase interval--channel pairs. We now define variables that the _NICER_ likelihood is a function of: let $s$ be a vector of parameters, collected from @sec:radiation-propagation above, of which the incident signal generated by the pulsar is a function; let #smallcaps[nicer] denote a (parameterized) model for the response of the instrument in response to incident radiation; and let ${ bb(E) [ b_(upright(N)) ] }$ be a set of statistically independent nuisance variables, one per detector channel that contains event data to be modeled, defined as the phase-invariant expected count rate. The _NICER_ event data is phase-resolved, so there are multiple random variates---distributed in phase---per background random variable. The background model with variables ${ bb(E) [ b_(upright(N)) ] }$ is free-form as discussed by #cite(<riley19a>, form: "prose"). The set of these variables is designed to handle complex channel-to-channel variations in the expected phase-invariant count rate. A physical background model should need (far) fewer random variables for the underlying background-generating process to capture these complexities. The likelihood function is denoted by $p ( d_(upright(N)) | s , { bb(E) [ b_(upright(N)) ] } , #smallcaps[nicer] )$.


We numerically marginalize over the variables ${ bb(E) [ b_(upright(N)) ] }$ to yield a marginal likelihood function that is combined with a joint prior PDF to define a target distribution to draw samples from. The count rate variables have separable flat prior PDFs that are strictly improper because we do not explicitly define upper-bounds on the prior support of each variable @riley19a; the posterior is considered integrable however, so these ill-defined prior PDFs do not result in posterior pathologies. The separable prior PDF of the count rate variables is overly-diffuse, with extremely high prior-predictive complexity, such that inferences will be insensitive to minor changes to the function: $bb(E) [ b_(upright(N)) ] tilde U ( 0 , cal(U) )$, where the upper-bound $cal(U)$ of the prior support is left unspecified.#footnote[The posterior should be integrable---without proof here---even if the prior is improper, but if an upper-bound were to be required, it could for instance be based on _NICER_ count rate limitations.]


The marginalization operation is separable over channels, yielding a product of one-dimensional integrals. We need to perform fast numerical marginalization over the ${ bb(E) [ b_(upright(N)) ] }$ in order to compress the dimensionality of the sampling space. The simpler the form of the integrands---the functions of the ${ bb(E) [ b_(upright(N)) ] }$---the more straightforward fast numerical marginalization is. If the prior PDF $p ( bb(E) [ b_(upright(N)) ] )$ is flat, the integrand has a single global maximum, and would be highly Gaussian if the peak of the conditional likelihood function $p ( d_(upright(N)) | s , bb(E) [ b_(upright(N)) ] , #smallcaps[nicer] )$ lies within the support of $p ( bb(E) [ b_(upright(N)) ] )$.


As discussed by #cite(<riley19a>, form: "prose"), a major open question regards the total expected spectral signal that is attributable to the surface hot regions in reality.#footnote[Assuming that the pulsed emission is dominated by rotationally modulated emission from the surface.] In lieu of a physical background model---which as discussed above is difficult to formulate for _NICER_---independent information conditional on data acquired with an imaging X-ray telescope such as _XMM_ can be fundamentally valuable for deriving robust inferences if the exposure time is sufficiently long---it will however be substantially shorter than the order megasecond exposures of the near-dedicated _NICER_ telescope.


Note that in order to infer the contribution from contaminating sources to the _NICER_ event data,#footnote[That is, contamination that cannot be robustly filtered out during event data pre-processing.] we would need to separate out the ${ bb(E) [ b_(upright(N)) ] }$ into an environmental background model---with some informative prior PDF including space weather contributions---and some model for the contribution from contaminating (point) sources in the field that cannot be resolved from the point-spread function (PSF) of PSR~J0740+6620. However, for the principal purpose of constraining the physical properties of the pulsar, we are uninterested in the distinction between _NICER_ backgrounds. Moreover, we do not have the statistical power to distinguish the contributions if the priors for the components are all rather diffuse. In other words, if some of the priors are informative, we do not have the statistical power to gain much information _a posteriori_.


=== _XMM-Newton_ <sec:XMM-background>


Information about the total background contribution to the _NICER_ event data---including contaminating (point) sources in the field @bogdanov19a[for a breakdown of components]---is encoded in the _XMM_ spectroscopic imaging event data. Due to the relatively brief exposure times of the observations, very few background counts are available for a reliable background estimate. Thus, we obtained representative background estimates with higher photon statistics from the blank-sky event files provided by the _XMM-Newton_ Science Operations Centre#footnote[See #link("https://www.cosmos.esa.int/web/xmm-newton/blank-sky").]. The blank-sky images were filtered in the same manner as the PSR~J0740+6620 field images and the background was extracted from the same location on the detector as the pulsar. The resulting background spectrum was then rescaled so that the exposure times and BACKSCAL factors match those of the PSR~J0740+6620 exposures.


Leveraging spatial resolving power, we can derive posterior inferences about the signal from the pulsar in isolation with little confusion about the expected contributions from the pulsar and background sources.#footnote[There remains confusion, however, about what contribution from the pulsar and its near vicinity is generated by surface hot regions.] When this information about the pulsar signal is injected into modeling of _NICER_ observations---either explicitly as a prior or as a likelihood factor---the contribution from the pulsar to the _NICER_ event data is informed; here we work towards a likelihood function factor for the _XMM_ telescope.


Let $d_(upright(X))$ be the _XMM_ time-integrated count vector (over detector channels) from a region $cal(S)$ of a CCD of a camera, that is some sufficiently large subset of the support of the PSF of the PSR~J0740+6620 whilst optimizing signal-to-noise.#footnote[Imaging observations are configured such that the target point source is confined to a single CCD, for instance to avoid masking part of the source PSF with gaps between CCDs.] We now define variables that the _XMM_ likelihood is a function of. The vector of parameters of the incident signal generated by the pulsar remains as $s$, shared with the _NICER_ likelihood function. Let #smallcaps[xmm] denote a (parameterized) model for the response of an _XMM_ camera in response to incident radiation. Once more, in lieu of a physical model for the underlying background-generating process, let us define one statistically independent random nuisance variable per detector channel: the expected count rate.#footnote[Where there is now one variate per channel because the count numbers are phase-averaged.] These variables are collectively denoted ${ bb(E) [ b_(upright(X)) ] }$. The likelihood function for each _XMM_ camera is denoted by $p ( d_(upright(X)) | s , { bb(E) [ b_(upright(X)) ] } , #smallcaps[xmm] )$. We numerically marginalize over these model variables in the same vein as for the _NICER_ background-marginalized likelihood function; however, to constrain the signal from PSR~J0740+6620 we are in need of a more informative prior PDF of ${ bb(E) [ b_(upright(X)) ] }$.


To form the prior PDF of ${ bb(E) [ b_(upright(X)) ] }$ for an _XMM_ camera, we consider a set of independent Poisson-random variates ${ cal(B)_(upright(X)) }$ defined as time-integrated astrophysical (sky) background count numbers in detector channels. The events constituting ${ cal(B)_(upright(X)) }$ are extracted from a blank-sky#footnote[That is, a region of sky devoid of any (bright) non-diffuse X-ray sources.] region $cal(B)$ of the camera CCD array that is disjoint from region $cal(S)$ associated with PSR~J0740+6620. The _XMM_ cameras are composed of multiple side-by-side CCD detectors. For each camera, it is preferable to choose the region $cal(B)$ on the same detector as $cal(S)$ because the different CCD detectors have slightly different responses to incident radiation and therefore exhibit slightly different astrophysical (sky) backgrounds. For blank-sky exposures, the conditional sampling distribution in the space of the data is $p ( { cal(B)_(upright(X)) } | { bb(E) [ cal(B)_(upright(X)) ] } )$, where the variables ${ bb(E) [ cal(B)_(upright(X)) ] }$ are per-channel expected count _numbers_.


To constrain the background in the _XMM_ images of PSR~J0740+6620, we use blank-sky estimates generated using the _XMM-Newton_ SAS tools. The blank-sky exposures are much longer in duration than the exposures to PSR~J0740+6620 by almost two orders of magnitude, allowing us to constrain the astrophysical (sky) background count rate in the on-source exposures more tightly (in the absence of systematic error) than possible from blank-sky extraction regions from the same CCD during the shorter on-source exposure. For each XMM camera the respective region $cal(B)$ is not only localized to the same CCD as the PSR~J0740+6620 PSF, but _is_ the same region of the CCD. However, the blank-sky estimates are based on an ensemble of pointings over the sky. Our cross-check of the sky background in these reference exposures against the sky background in the vicinity of PSR~J0740+6620 did not yield evidence of systematic difference.


We now formally derive the constraints on the expected number of background counts per detector channel registered within the source region $cal(S)$ of an XMM camera, ${ cal(B)_(upright(X)) }$, conditional on the counts registered in region $cal(B)$ over the ensemble of blank-sky exposures. A prior PDF of the variables ${ bb(E) [ cal(B)_(upright(X)) ] }$ is needed. In the same vein as for the _NICER_ background variables, we define a separable prior PDF $ bb(E) [ cal(B)_(upright(X)) ] tilde U ( 0 , cal(V) ) , $<eqn:blank-sky-prior> where the upper-bound $cal(V)$ of the prior support is left unspecified. This trivial model over-fits the background data, with posterior PDF $ p ( { bb(E) [ cal(B)_(upright(X)) ] } | { cal(B)_(upright(X)) } ) prop p ( { cal(B)_(upright(X)) } | { bb(E) [ cal(B)_(upright(X)) ] } )   $ the vector of random variates ${ cal(B)_(upright(X)) }$ is coincident in value with the maximum _a posteriori_ vector in the space of ${ bb(E) [ cal(B)_(upright(X)) ] }$.





// [figvision] imgs/f4.png
// The figure is a plot showing count number spectra. The x-axis represents nominal photon energy, ranging from
// 0.3 to 1 keV. The y-axis represents counts, on a log scale from 10^-3 to 10^4. There are five series: a black
// line for EPIC pn on-source, a blue line for EPIC pn scaled blank-sky, a red line for NICER XTI total spectrum,
// a red dashed line for NICER XTI pulsed, and an orange shaded region for flat prior support per channel. The
// trend shows that the NICER XTI total spectrum has the highest counts, while the EPIC pn scaled blank-sky and
// flat prior support per channel have lower counts. The plot compares the count number spectra of different
// instruments and backgrounds.
#figure(placement: top, image("imgs/f4.png", width: 100%),
  caption: [
    The _black_ step function is the _XMM_ pn camera PSR~J0740+6620 count number spectrum as a function of detector channel nominal photon energy. The _XMM_ events contain source events and events from diffuse background that can be estimated from blank-sky information. The _NICER_ count number spectrum is the _red_ solid step function, including PSR~J0740+6620 events and all backgrounds; the _red_ dashed step function is the empirical pulsed count number in each channel. The _XMM_ pn events are clearly sparse in comparison to the _NICER_ event data, but note that the number of pulsed _NICER_ counts is lower than indicated here, as shown in #ref(<fig:J0740-count-data>). The _blue_ step function is the count number spectrum derived from blank-sky exposure, scaled down to the exposure time on PSR~J0740+6620 and also scaled for the CCD extraction region area ratio $A_(cal(S)) / A_(cal(B))$ as described in the main text---please see @eqn:expected-count-rate-variable-transformation. The _orange_ shaded region is the support of the joint prior PDF of the expected count rate variables ${ bb(E) [ b_(upright(X)) ] }$, derived from the blank-sky exposures. The figure elements rendered here are representative of the corresponding information from the _XMM_ MOS1 and MOS2 cameras, as can be seen in the online figure set associated with #ref(<fig:XMM-background>).
  ]
) <fig:pn-count-spectrum>






As is the case for the _NICER_ background marginalization operation described in @sec:XTI-backgrounds, if the PDF $p ( { bb(E) [ cal(B)_(upright(X)) ] } | { cal(B)_(upright(X)) } )$ is flat, the marginalization is more straightforward to execute. For example, we could form a flat prior PDF spanning the highest-density $x %$ posterior credible interval in $bb(E) [ b_(upright(N)) ]$, given ${ cal(B)_(upright(X)) }$. We form a flat prior PDF in a simpler way. The PDF $p ( { bb(E) [ cal(B)_(upright(X)) ] } | { cal(B)_(upright(X)) } )$ has the approximate structure of a truncated Gaussian with deviation dependent on the number of counts $cal(B)_(upright(X))$. We let the lower- and upper-bounds of the support respectively be $cal(L) := "max" (0 , cal(B)_(upright(X)) - n sqrt(cal(B)_(upright(X))))$ and $cal(U) := cal(B)_(upright(X)) + n sqrt(cal(B)_(upright(X)))$, where $n$ is a setting that controls the degree of conservatism. For some channels the number of counts is low and the PDF $p ( { bb(E) [ cal(B)_(upright(X)) ] } | { cal(B)_(upright(X)) } )$ deviates substantially from being a truncated Gaussian, but we nevertheless adopt the same procedure---the lower-bound is pushed to zero or far into the lower-tail of the distribution, but the upper-bound remains sensible. For some channels, however, $cal(B)_(upright(X)) = 0$. In these cases, we simply set $cal(L) := 0$ and then iterate upwards in channel number to locate the next finite value of $cal(B)_(upright(X)) + n sqrt(cal(B)_(upright(X)))$.#footnote[This procedure is sufficient for the channel cuts we make because there is always a higher channel with a finite number of counts $cal(B)_(upright(X))$.] We choose $n = 4$. With the flat PDF of $bb(E) [ cal(B)_(upright(X)) ]$ defined, we transform variables to derive the prior PDF $p ( bb(E) [ b_(upright(X)) ] | { cal(B)_(upright(X)) } )$ according to $ bb(E) [ b_(upright(X)) ] = A_(cal(S)) / A_(cal(B)) frac(bb(E) [ cal(B)_(upright(X)) ], T_(cal(B))) , $<eqn:expected-count-rate-variable-transformation> where $T_(cal(B))$ is the blank-sky exposure time needed to transform to a count rate, and $A_(cal(S)) / A_(cal(B))$ is the ratio of the areas of the extraction regions $cal(S)$ (encompassing the PSR~J0740+6620 PSF) and region $cal(B)$.


In many respects this flat PDF of $bb(E) [ cal(B)_(upright(X)) ]$ is a remarkably conservative choice for the prior constraint on $p ( bb(E) [ b_(upright(X)) ] | { cal(B)_(upright(X)) } )$. A reason it is not conservative is the assumption of zero prior mass above an upper count-rate limit $cal(U)$ somewhere in the upper-tail of the true probability PDF $p ( { bb(E) [ cal(B)_(upright(X)) ] } | { cal(B)_(upright(X)) } )$, especially because the count-number data $d_(upright(X))$ for each _XMM_ camera are moderately consistent with being generated by background processes. The upper-limit $cal(U)$ can be decreased so that $p ( bb(E) [ b_(upright(X)) ] | { cal(B)_(upright(X)) } )$ is more informative at the risk of bias. On the other hand, $cal(U)$ can be increased, which naturally weakens the constraining power but can be justified as a safety precaution to capture a contribution such as a power-law component originating from the magnetosphere of PSR~J0740+6620 that is not explicitly modeled.#footnote[Note that the binary companion of PSR~J0740+6620 has been inferred to be an ultra-cool white dwarf @Beronya19 whose thermal surface emission would not contribute X-ray events, unless there is some interaction with higher-energy winds from PSR~J0740+6620.] Alternatively, we could justify a higher upper-limit in terms of systematic error due to blank-sky estimates derived from an ensemble of exposures over the sky and variation in time of the _XMM_ camera response matrices between the PSR~J0740+6620 exposure and blank-sky exposure ensemble. The setting of $n = 4$ seems like a reasonable---albeit arbitrary---choice to balance information loss versus bias; we probe posterior sensitivity to this hyperparameter and conclude our inferences are insensitive to its value (see @sec:inferences). We display the _XMM_ pn camera count number spectrum in @fig:pn-count-spectrum together with the blank-sky derived prior PDF of the expected count rate variables ${ bb(E) [ cal(B)_(upright(X)) ] }$; we also display the _NICER_ count number spectrum for data quality comparison.


=== The likelihood function <the-likelihood-function>


The likelihood function given the _NICER_ and _XMM_ data sets may be written as

#figure(
  kind: "eqwide", supplement: none, scope: "parent", placement: top,
  block(width: 100%)[
  $ p ( d_(upright(N)) , d_(upright(X)) , { cal(B)_(upright(X)) } | s , { bb(E) [ b_(upright(N)) ] } , { bb(E) [ b_(upright(X)) ] } ) = p ( d_(upright(N)) | s , { bb(E) [ b_(upright(N)) ] } , #smallcaps[nicer] ) quad p ( d_(upright(X)) | s , { bb(E) [ b_(upright(X)) ] } , #smallcaps[xmm] ) p ( { cal(B)_(upright(X)) } | { bb(E) [ b_(upright(X)) ] } ) , $

  #v(0.6em)

  where we combine the expected background count rate variables over the _XMM_ cameras into ${ bb(E) [ b_(upright(X)) ] }$, we combine the count numbers in the PSR~J0740+6620 exposures into $d_(upright(X))$, and we combine the blank-sky count numbers into ${ cal(B)_(upright(X)) }$. Introducing the flat prior densities from @eqn:blank-sky-prior, approximating the posterior PDF $p ( { bb(E) [ cal(B)_(upright(X)) ] } | { cal(B)_(upright(X)) } )$ as flat and bounded as described in @sec:XMM-background, and marginalizing over all expected background count rate variables yields the background-marginalized likelihood function


  #v(0.6em)
  $ p ( d_(upright(N)) , d_(upright(X)) , { cal(B)_(upright(X)) } | s ) prop integral_({ 0 })^({ cal(U) }) p ( d_(upright(N)) | s , { bb(E) [ b_(upright(N)) ] } , #smallcaps[nicer] ) d { bb(E) [ b_(upright(N)) ] } integral_({ cal(L) })^({ cal(U) }) p ( d_(upright(X)) | s , { bb(E) [ b_(upright(X)) ] } , #smallcaps[xmm] ) d { bb(E) [ cal(B)_(upright(X)) ] } . $<eqn:background-marginalized-likelihood>
  ],
)
The background-marginalized likelihood function is fed as a callback to a sampling process, together with a joint prior PDF callback for the pulsar signal parameters $s$ and parameters associated with the #smallcaps[nicer] and #smallcaps[xmm] instrument response models.


== Model space summary <model-space-summary>


All nodes in the model space share some underlying physics. Namely, the machinery for relativistic ray-tracing: an oblate surface is embedded in an ambient Schwarzschild spacetime, and the X-ray emission emergent from the atmosphere is attenuated by the interstellar medium as it is transported to a distant static telescope. The nodes in the model space differ first and foremost in their surface hot region parameterization complexities and atmosphere composition flag values, but also in terms of the prior PDF and the likelihood function factors. The prior PDFs for the parameters controlling the shared processes (i.e., mass, equatorial radius, viewing angle to the spin axis, distance, column density) are either informative---such as the joint NANOGrav and CHIME/Pulsar measurement of mass, distance, and viewing angle---or diffuse if there is limited prior knowledge or we aim to probe the consistency of likelihood function factors across telescopes.


== Posterior computation <sec:posterior-computation>
We implement nested sampling to compute the posterior distribution conditional on each model. Namely, we use _X-PSI_ to construct the likelihood function and the prior PDFs and then couple them to #smallcaps[MultiNest] @MultiNest_2008 @MultiNest_2009 @PyMultiNest. For the headline model we report in this Letter, including _NICER_ and _XMM_ likelihood factors, the dimensionality of the sampling space is $15$. Details about our nested sampling protocol are given in #cite(<riley19a>, form: "prose", supplement: [see the appendix matter in particular]) and also in #cite(<riley_thesis>, form: "prose", supplement: [see chapter 3 and the associated appendix]). In summary, our minimum resolution settings are as follows: $10^3$ live points; a bounding hypervolume expansion factor of $0.1^(- 1)$; and an estimated remaining log-evidence of $10^(- 1)$. Regarding live points, most posteriors for sensitivity analyses are computed with $2 times 10^3$ or $4 times 10^3$ live points, and production calculations used $4 times 10^4$ live points. The number of live points is the most fundamental parameter that should be changed to probe sampling resolution sensitivity---the expansion factor can be fixed at some value similar to those recommended in the literature @MultiNest_2009. Likelihood function evaluation time is the dominant sink, being several seconds per core for the processor speeds typical on a cluster or supercomputer. We do _not_ use the constant efficiency algorithm variant for any sampling process, and we do _not_ use the mode-separation algorithm variant unless stated otherwise.#footnote[For additional details about these variants, refer to #cite(<riley19a>, form: "prose") and references therein. We also do _not_ use the importance sampling algorithm variant @MultiNest_2013.] Regarding the mode-separation variant, if there are multiple modes of commensurate posterior mass, sampling resolution gets distributed between those modes. It follows that the bounding approximation to the constant likelihood hypersurfaces in each mode is lower than if the global resolution settings were consumed solely by that mode. We eliminate hot region exchange degeneracy from the prior support as discussed in @sec:temp-field, which eliminates mirrored modes and thus improves the resolution of that mode in terms of bounding approximation error.


For most posteriors reported in this work, the nested samples are considered high-resolution in the context of literature recommendations and, for the production analysis, were costly to generate given resource limitations. It is important to remark that our posterior computation procedure has not been validated in any meaningful way via simulation-based calibration because at present it is basically intractable for any one group to calibrate credible region coverage on a model-by-model basis (see the discussion in chapter 3 of #cite(<riley_thesis>, form: "prose") and in #cite(<riley19a>, form: "prose")). For discussion on the level of calibration we have attained by cross-checking against independent calculations performed by another group @miller19, we refer to #cite(<Bogdanov19c>, form: "prose"). However, we open-source the entire analysis package for this Letter, so another group with resources is free to modify, cross-check, and improve upon the posterior computation.






= INFERENCES <sec:inferences>


In this section we report our inferences. We first summarize the measures used to assess model performance. We then discuss an exploratory analysis that examined sensitivity to resolution settings and selected model assumptions, in particular the effects of different assumed atmospheric composition and hot region configuration. We then report high-resolution posterior inferences for the superior model.


== Performance measures <sec:performance-measures>


For pulse-profile modeling with _X-PSI_ a set of performance measures should be considered for each model in the model space, largely following the protocol of #cite(<riley19a>, form: "prose"). The first measure, given a set of posterior samples, is graphical and the most practical: basic posterior-checking by inspecting for inconsistency between the statistically independent _NICER_ count number variates and the separable sampling distribution from which those variates are assumed to be drawn _a posteriori_. We estimate the expectation with respect to the posterior of the expected count numbers and form Poisson sampling distributions from these expected count numbers. If there is clear structural difference---namely residual correlations in the joint space of energy and phase---then the model cannot generate data with the structure of the real count numbers. Supposing there are no discernable correlations, then because the sampling distribution for each variate is Poissonian with a sufficiently large expectation for the distribution to be well-approximated as Gaussian, we can inspect the distribution of the standardized residuals to identify any clear deviation from a normal distribution---e.g., too much or too little weight in the tails---that would be indicative of noise-model inaccuracies. If this check also passes, then the model has sufficient complexity to generate synthetic data with the structure of the _NICER_ PSR~J0740+6620 event data and is adequate for simulation purposes---e.g., for statistical forecasts of the constraining power achievable with future X-ray space telescope concepts such as the _enhanced X-ray Timing and Polarimetry mission_ @Zhang19 @Watts19 and the _Spectroscopic Time-Resolving Observatory for Broadband Energy X-rays_ @Ray19.


The second measure we inspect is the maximum likelihood estimate reported by a nested sampling process. Note that nested sampling does not target maximum likelihood estimation, but the drawing of samples from the typical set of a target distribution---the maximum likelihood estimate is therefore also subject to the concentration of prior mass in parameter space. More specifically, we are working with the estimated maximum of a background-marginalized likelihood function given by @eqn:background-marginalized-likelihood or one of the likelihood factors (i.e., the _NICER_ or _XMM_ likelihood function). We can use these point estimates to compare, in a simple way, models of the same count number variates. We only graduate to comparison of models using maximum likelihood estimates if the graphical posterior checking described above does not reveal failures. The model that reports the highest maximum likelihood estimate amongst those that model the same count number variates has a sampling distribution#footnote[Within the continuous set of such distributions associated with the model.] that captures the most structure in the set of count number variates. It is plausible, therefore, that a data-generating process defined by that model is the closest approximation of physical reality attained by the models considered. For models that can _a posteriori_ generate data with the structure of the real count number variates, the maximum likelihood estimate can be used to resolve small differences that human inspection fails to uncover.


The third measure that we examine when comparing models of the same set of count number variates is the evidence (the prior predictive probability distribution evaluated using the real count number variates). Whilst maximum likelihood estimates are mere point estimates, the evidence is the expectation of the likelihood function with respect to the joint prior PDF. In one respect, this is powerful because unwarranted prior predictive complexity is penalized: if too much complexity is added to model $cal(M)$ to construct model $cal(M)^(+)$, then for $cal(M)^(+)$ the likelihood function over a large swathe of prior mass is smaller than the expected likelihood (with respect to the prior) of model $cal(M)$, which can entirely negate any localized increases in the likelihood function. In other words, much of the additional complexity is unhelpful because the data generated does not have a similar structure to the real data. On the other hand, penalizing complexity in this way is arguably misleading if the model has phenomenological components: in this Letter the surface hot region models _are_ phenomenological.


The evidence, together with a prior mass function of nodes of the model space, may be a biased model selector in our context. Unfortunately, it is necessary in a formal Bayesian framework to use the evidence to marginalize over nodes of the model space in order to compute a posterior PDF of parameters of interest that are shared between nodes. Marginalizing over nodes that differ solely by the atmosphere composition is not problematic. If we do not formally marginalize in such a manner over all models, however, then we can only report the posterior distribution (marginalized over atmosphere composition) for each hot region model that satisfies the graphical posterior checking criterion, together with the maximum likelihood estimate. The reader is then free to interpret the model-to-model posterior variation as a systematic error estimate by, for instance, weighting the posteriors equally which would roughly lead to credible regions with near-maximum hypervolume (width in one dimension, area in two dimensions, and so on); formally, this is equivalent to defining an implicit prior mass distribution over model space nodes that happens to nullify evidence differences, leading to a uniform posterior mass function of models.#footnote[And more formally still, this would mean the prior mass function is dependent on the data, which is a fallacy.] Alternatively, any other weighting can be interpreted as the reader choosing their own prior mass function of model space nodes.


Lastly, when comparing models of the same set of count number variates, we also consider the tractability of the model. If two models pass graphical posterior predictive checks, and supposing one model is less complex, that model is almost by definition more straightforward to implement and to compute the posterior for. The adequately performing model that requires fewest resources to reproduce or prove erroneous---thereby increasing the robustness and potentially the computation accuracy---can be reasoned to be the most useful in practice.


== Exploratory analysis <sec:exploratory>


In this section we report on posterior sensitivity to various features of the analysis pipeline. Although one can attempt to probe sensitivity using importance sampling, we opted for nested sampling for every variant of interest. In our sensitivity analyses, our nested sampling resolution settings are lower than for the production analysis because we were ultimately resource-limited. We varied the number of nested sampling live-points and the bounding hypervolume expansion factor; we explored _XMM_ background prior hyperparameter variation; we switched the atmosphere composition from hydrogen to helium; and we varied likelihood function resolution settings. We have not probed sensitivity to event data set selection (namely, _NICER_ detector channel cuts) nor sensitivity to approximation of the atmosphere ionization state as fully-ionized.


The posteriors we report in this section were computed using at least $2 times 10^3$ live points and (except where explicitly noted) condition on the `ST-U` model and either the _NICER_ likelihood function or the _NICER_ and _XMM_ likelihood function. For a full description of this model, and a schematic diagram, see #cite(<riley19a>, form: "prose"). Briefly, however, `ST-U` assumes each hot region is a single-temperature spherical cap. The two regions can have completely independent properties (temperature and size) and are free to take any location on the star's surface provided that they do not overlap (see also the discussion in @sec:temp-field). Our exploratory analysis indicated that this model provided an adequate description of the PSR~J0740+6620 data set using the performance measures outlined in #ref(<sec:performance-measures>). Finally, note that posteriors reported in this section are conditional on a _NICER_ exposure time that was erroneously high by $tilde 2 %$. We corrected this number for a subset of posteriors reported in this section, and for the production analysis (@sec:production-analysis); our posteriors are however insensitive to this level of error in exposure time.


=== Impact of radio timing prior information <sec:radio-impact>


The informative joint NANOGrav and CHIME/Pulsar prior is critical for deriving a useful constraint on the radius of PSR~J0740+6620. For comparison, we compute a posterior conditional on a fully-ionized hydrogen atmosphere and a diffuse, separable prior PDF of the mass, the distance, and the cosine of inclination angle. The mass prior is such that the joint prior PDF of mass and radius is flat within the prior support (see @table:-ST-U). The distance prior PDF is adopted from #cite(<Igoshev16>, form: "prose") and displayed in @fig:marginal-distance-PDFs, with support $D in [ 0.1 , 10.0 ]$~kpc. The prior PDF of the cosine of the inclination angle is isotropic, meaning flat with support $cos i in [ 0 , 1 ]$.
































// [figvision] imgs/f5.png
// a. This panel shows a plot of a one-dimensional marginal probability density function (PDF). The x-axis
// represents the equatorial radius, R_{eq}, in kilometers, ranging from 6 to 14, and the y-axis represents the
// probability density, with a range of 0 to 2.8. There are three series: grey, blue, and red, corresponding to
// different combinations of prior PDFs and the NICER likelihood function. The grey series shows a broader, more
// diffuse distribution, while the blue and red series show narrower peaks. The trend shows that the addition of
// prior information sharpens the PDF. The 68\% confidence interval and D_{KL} divergence are annotated for each
// series. b. This panel shows a plot of a one-dimensional marginal PDF. The x-axis represents the gravitational
// mass, M, in solar masses (M_{}), ranging from 1.2 to 2.8, and the y-axis represents the probability density,
// with a range of 0 to 2.8. The series and line styles are as in panel a. The red series has a 68\% confidence
// interval of 2.118^{+0.065}_{-0.064} and D_{KL}=0.03. The trend shows that the PDFs are similar, but with
// slightly different peaks. c. This panel shows a plot of a one-dimensional marginal PDF. The x-axis represents
// the cosine of the viewing angle, (i), ranging from 0.015 to 0.06, and the y-axis represents the probability
// density, with a range of 0 to 2.8. The series and line styles are as in panel a. The red series has a 68\%
// confidence interval of 0.0438^{+0.0028}_{-0.0028} and D_{KL}=0.02. The trend shows that the PDFs are narrow
// and similar. d. This panel shows a plot of a two-dimensional marginal PDF as contours. The x-axis represents
// the distance, D, in kiloparsecs (kpc), ranging from 0.4 to 1.2, and the y-axis represents the gravitational
// mass, M, in solar masses (M_{}), ranging from 1.2 to 2.8. The series are as in panel a, with different colors
// and line styles. The contours show the 68\% confidence intervals for each series. The trend shows that the
// addition of prior information reduces the uncertainty in the mass and distance. e. This panel shows a plot of
// a one-dimensional marginal PDF. The x-axis represents the distance, D, in kiloparsecs (kpc), ranging from 0.4
// to 1.6, and the y-axis represents the probability density, with a range of 0 to 2.8. The series and line
// styles are as in panel a. The red series has a 68\% confidence interval of 1.13^{+0.15}_{-0.14} and
// D_{KL}=0.16. The trend shows that the PDFs have different peaks and widths. f. This panel shows a plot of a
// one-dimensional marginal PDF. The x-axis represents the column density, N_H, in units of 10^{20} cm^{-2},
// ranging from 0 to 8, and the y-axis represents the probability density, with a range of 0 to 2.8. The series
// and line styles are as in panel a. The red series has a 68\% confidence interval of 1.43^{+1.98}_{-1.00} and
// D_{KL}=0.99. The trend shows that the PDFs have different shapes and widths. g. This panel shows a plot of a
// two-dimensional marginal PDF as contours. The x-axis represents the column density, N_H, in units of 10^{20}
// cm^{-2}, ranging from 2 to 8, and the y-axis represents the equatorial radius, R_{eq}, in kilometers, ranging
// from 6 to 14. The series are as in panel a, with different colors and line styles. The contours show the 68\%
// confidence intervals for each series. The trend shows that the addition of prior information reduces the
// uncertainty in the radius and column density. h. This
#figure(scope: "parent", placement: top, image("imgs/f5.png", width: 91.0%),
  caption: [
    One- and two-dimensional marginal PDFs conditional on the `ST-U` model, the _NICER_ likelihood function alone, and one of three prior PDFs to probe the impact of radio timing information. From leftmost to rightmost in each panel, the parameters are the equatorial radius, the gravitational mass, the cosine of viewing angle subtended to pulsar spin axis, the distance, and the column density. We display the marginal prior PDFs for each parameter as the _dash-dot_ functions; the informative priors encode the information from NANOGrav~$times$~CHIME/Pulsar and #cite(<Cromartie19>, form: "prose", supplement: [denoted by the conditional argument C+$20$]), and the diffuse prior is described in #ref(<sec:radio-impact>). We report estimators for the _NICER_ posterior conditional on the joint NANOGrav and CHIME/Pulsar prior. We report the KL-divergence, $D_("KL")$, from prior to posterior in _bits_ for each parameter. The shaded credible intervals $"CI"_(68 %)$ for each parameter are symmetric in marginal posterior mass about the median, containing $68.3 %$ of the mass. The credible regions in the off-diagonal panels, on the other hand, are uniquely the _highest-density_---and thus the smallest possible---credible regions, containing $68.3 %$, $95.4 %$, and $99.7 %$ of the posterior mass. In the appendix of #cite(<riley19a>, form: "prose") we provide additional information regarding posterior kernel density estimation (KDE), error analysis, and the estimators displayed here; note that here we use an automated Gaussian KDE bandwith optimized by _GetDist_~@Lewis19. The complete figure set for the exploratory analysis ($7$ images) is available in the online journal.
  ]
) <fig:radio-prior-reversion>






The radius posterior conditional on the diffuse prior is much broader than when we condition on the joint NANOGrav and CHIME/Pulsar prior, and there is no independent indication from the pulse-profile modeling for a high mass (see @fig:radio-prior-reversion). Once the models are conditioned on the joint NANOGrav and CHIME/Pulsar prior PDF, we gain very little additional information _a posteriori_ from the X-ray likelihood function about the pulsar mass, distance, and inclination angle with respect to the spin axis. We can verify this by examining the marginal posterior distributions in comparison to the respective prior distributions, which is summarized for each parameter by the Kullback-Leibler divergence estimate @kullback1951.


=== Impact of X-ray telescopes <impact-of-x-ray-telescopes>


The _NICER_ likelihood function is sensitive to the basic configuration of the surface hot regions and their temperatures, despite the relatively small number of pulsed counts (those above the phase-invariant background). The _XMM_ likelihood function is less informative both due to the lack of phase information, and because the events are sparse for all three EPIC cameras and moderately consistent with the expected background signal derived from blank-sky exposures. However, the _XMM_ likelihood function acts to reduce the _NICER_ posterior mode volume substantially, affecting the inferred radius and geometry. The reason for this is because the _XMM_ likelihood is sensitive to the combined phase-averaged signal from the hot regions being too bright. Therefore, given the _NICER_ likelihood function, we constrain the contribution to the unpulsed portion of the pulse-profile that must be generated by the hot regions rather than the backgrounds. Posterior figures demonstrating this are reserved for #ref(<sec:production-analysis>).


=== Effect of atmospheric composition <effect-of-atmospheric-composition>


The atmospheric composition of PSR~J0740+6620 is not known _a priori_. We therefore compared `ST-U` posteriors for hydrogen and helium atmospheres assuming full ionization---see the discussion in #ref(<sec:atmosphere-setup>)---in the second online figure of the set associated with #ref(<fig:radio-prior-reversion>). The marginal radius posteriors were indistinguishable, although there were some small changes in the properties of the hot regions. However, given the apparent lack of sensitivity to atmospheric composition, inferences reported hereafter are conditioned on a fully-ionized hydrogen atmosphere---we do not need to marginalize over the binary atmosphere parameter. Both hot regions are inferred to have effective temperatures $T approx 10^6$~K, at which partial ionization effects should be small.


=== Hot region complexity <hot-region-complexity>


The #cite(<riley19a>, form: "prose") analysis of PSR~J0030+0451 reported a number of hot region models that provided an adequate description of the data according to their performance measures (largely adopted here). These included `ST-U` and variants in which one of the hot regions was permitted increasingly complex forms, including rings and crescents. The inferred radius changed as model complexity increased, but evidence calculations showed a substantial improvement in model performance. As a result of this, we deemed the `ST+PST` model---in which one hot region is a single temperature spherical cap and the other is, _a posteriori_, a crescent---to be superior for PSR~J0030+0451.


For PSR~J0740+6620 the `ST-U` model also provides an adequate description of the data. In order to assess whether additional complexity is useful we also condition on the `ST+PST` model. The posterior configuration and properties of the hot regions conditional on this more complex model (which includes the possibility of hot regions that are simply spherical caps) did not differ in an important way from the configuration inferred from `ST-U`: the hot region for which more complexity was permissible exhibited degeneracy _a posteriori_---we were not sensitive to the existence of additional emission structure beyond that of a simple spherical cap, and the evidence estimates are consistent. There was therefore no extended crescent as inferred for PSR~J0030+0451; the likelihood function degeneracy included some subset of possible crescent structures---those on smaller angular scales @riley19a[for discussion about hot region structure degeneracy]---which may be of interest to pulsar modelers. The inferred radius changed very little (see the third online figure of the set associated with @fig:radio-prior-reversion), and there was no increase in model performance. For this reason we hereafter report inferences exclusively for the `ST-U` model.


=== _XMM-Newton_ background prior sensitivity <xmm-newton-background-prior-sensitivity>


As described in @sec:XMM-background, the _XMM_ background is free-form, but each variable (one per channel) has a prior with compact support. For each variable, a flat prior PDF is defined whose width is controlled by a hyperparameter $n$. For the headline inferences reported in this Letter we used $n = 4$, having tested sensitivity to varying $n$ in the range $n in [ 0.01 , 8 ]$. In the limit that $n$ tends to zero, the background information would be treated as a point estimate of the _XMM_ background. The posterior distribution of the radius is insensitive to $n$ being varied through the range $n in [ 0.01 , 4 ]$; see the fourth online figure of the set associated with #ref(<fig:radio-prior-reversion>). It broadens slightly for $n = 8$ because fainter combined signals from the hot regions have greater background-marginalized likelihoods, yielding additional posterior weight for higher-radius configurations that reduce the unpulsed component whilst conserving the pulsed component to satisfy the _NICER_ event data. However, the value $n = 8$ is arguably too conservative even when considering potential systematic error.


=== Likelihood function resolution sensitivity <likelihood-function-resolution-sensitivity>


The _X-PSI_ likelihood function has a number of resolution settings, most notably settings that control the discretization of the computational domain for computation of signals (pulse-profiles) incident on telescopes. The photon specific flux signal we require is an integral over a distant observer's sky of the photon specific intensity from the hot regions, yielding a two-dimensional function of time (rotational phase) and photon energy. The level of discretization with respect to four variables in the domain of the incident photon specific intensity field generally controls the computational expense of likelihood evaluation. These variables are the number of rotational phases and energies the photon specific flux signal is computed at; the number of hot region surface elements; and the number of rays calculated. Please see the _X-PSI_ documentation#footnote[#link("https://thomasedwardriley.github.io/xpsi/")] for additional information.


We tested posterior sensitivity to increasing the discretization degrees for these variables by recomputing a posterior PDF with a new nested sampling process. We found that doubling these discretization degrees does not yield a change in the posterior PDF that is clearly distinguishable from Monte Carlo sampling noise;#footnote[The nested sampling seed was set based on the system clock for each sampling process and therefore not held constant as would be ideal.] see the fifth online figure of the set associated with #ref(<fig:radio-prior-reversion>).


=== Nested sampling resolution sensitivity <nested-sampling-resolution-sensitivity>


For a fixed bounding hypervolume expansion factor of $0.1^(- 1)$, the posterior PDFs were insensitive to doubling live-point number from $10^3$ up to $4 times 10^3$. Following sampler comparisons within the _NICER_ collaboration, we then increased resolution to $4 times 10^4$ live points, leading to broadening of the radius posterior; see the sixth and seventh online figures in the set associated with #ref(<fig:radio-prior-reversion>). Increasing the sampling resolution by using $8 times 10^4$ live points led to some further broadening, but doubled an already large computational cost. Given the computational resources required for posterior computation with such a large number of live points, we were not able to rigorously prove convergence with live-point number. We decided to adopt $4 times 10^4$ live points for the production analysis---all information necessary to reproduce and improve upon our posterior computation is available in open-source repositories.


Such posterior mode broadening with increased nested sampling resolution is naturally expected because nested sampling algorithms approximate hypersurfaces in parameter space of constant likelihood; these approximations improve with sampling resolution but their sufficiency is difficult to prove for non-trivial likelihood functions encountered in real problems and when subject to resource limitations. It is desirable to transform away non-linear modal degeneracies so that an approximation conforms more efficiently to structure in the sampling space; however, this can in practice be intractable task for a given problem. Moreover, when sampling from a target distribution with two or more modes of commensurate posterior mass, the live-point resolution is roughly split between the modes, reducing the resolution of a given mode due to the approximations alluded to above. For PSR~J0740+6620, posterior bimodality arises due to the near-equatorial inclination of the source, leading to two competitive geometric configurations of the hot regions (see @sec:production-analysis, where we discuss this further).


== Production analysis <sec:production-analysis>


Our exploratory analysis indicates that model `ST-U` provides an adequate description of the data and that the posteriors are largely insensitive to either atmospheric composition or increased hot region complexity. In this section, we present high-resolution posteriors---using $4 times 10^4$ live points---conditional on the `ST-U` model, and fully-ionized hydrogen atmosphere. For each posterior we use either the _NICER_ likelihood function alone, the _NICER_ and _XMM_ likelihood function, or the _XMM_ likelihood function alone. The posterior PDF conditional on the _NICER_ likelihood function alone is derived by importance-sampling another posterior PDF, thereby updating a deprecated radio timing prior PDF (see @sec:radio and #cite(<Fonseca20>, form: "prose")). The weighted and equally-weighted samples from the marginal joint posterior distribution of mass and radius may be found in the persistent repository of #cite(<zenodo>, form: "prose"), together with credible region contour point-sequences and marginal posterior PDFs of the radius (to facilitate plotting).


@fig:ST-U-residuals provides a simple graphical posterior predictive check on the model performance, demonstrating that the `ST-U` model can generate synthetic event data that is commensurate with the _NICER_ data. No unexpected structure---such as large deviations or correlations---is emergent in the residuals.


Marginal posterior distributions of the spacetime parameters---in particular the radius---are shown in #ref(<fig:ST-U-spacetime-corner>). The figure displays posteriors conditional on the _NICER_ data alone, conditional on the _XMM_ data alone, and conditional on both _NICER_ and _XMM_ data. As expected, the phase-resolved _NICER_ likelihood function is far more constraining, in isolation, than the phase-averaged _XMM_ likelihood function. However, the likelihood function product over telescopes excludes regions of the _NICER_ posterior modes where the contribution to the unpulsed component of the pulse-profile from the hot regions is too bright. The unpulsed component is brighter for models in the _NICER_ posterior modes where the star is more compact. Restricting to lower compactness increases the inferred radius for the combined data set by $tilde 1$~km.


The inferred hot region parameters, again comparing the likelihood functions in isolation to the likelihood function, are shown in #ref(<fig:ST-U-geometry-corner>). The effect of including the _XMM_ data can be seen in the joint posterior PDF of the stellar radius and the angular radii of the two hot regions ($zeta_p$ and $zeta_s$). The _NICER_-only posteriors (at the 99.7% level) include models with a smaller stellar radius ($< 10.5$ km) and hot regions with a larger angular radius ($zeta tilde 1.2$ rad). The large hot regions on very compact stars lead to a bright unpulsed component of the combined signal from those regions. The inclusion of the _XMM_ data means that more of the unpulsed signal is associated with the background instead of the hot regions. As a result, these smaller stars with large hot regions are excluded when the _XMM_ data is included.





// [figvision] imgs/f10.png
// a. This is a plot with a black background. The x-axis ranges from -1 to 1 and is labelled (x/Req)√(1 -
// r_eq/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/Req)√(1 - r_eq/R_eq). There is a white dot and a
// white ellipse. The text [0.00 cycles] is at the bottom. The trend shows the white dot and ellipse positioned
// in the lower left. b. This is a plot with a black background. The x-axis ranges from -1 to 1 and is labelled
// (x/Req)√(1 - r_eq/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/Req)√(1 - r_eq/R_eq). There is a
// white dot and a white ellipse. The text [0.04 cycles] is at the bottom. The trend shows the white dot and
// ellipse have moved right. c. This is a plot with a black background. The x-axis ranges from -1 to 1 and is
// labelled (x/Req)√(1 - r_eq/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/Req)√(1 - r_eq/R_eq).
// There is a white dot and a white ellipse. The text [0.08 cycles] is at the bottom. The trend shows the white
// dot and ellipse have moved right. d. This is a plot with a black background. The x-axis ranges from -1 to 1
// and is labelled (x/Req)√(1 - r_eq/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/Req)√(1 -
// r_eq/R_eq). There is a white dot and a white ellipse. The text [0.12 cycles] is at the bottom. The trend shows
// the white dot and ellipse have moved right. e. This is a plot with a black background. The x-axis ranges from
// -1 to 1 and is labelled (x/Req)√(1 - r_eq/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/Req)√(1 -
// r_eq/R_eq). There is a white dot and a white ellipse. The text [0.17 cycles] is at the bottom. The trend shows
// the white dot and ellipse have moved right. f. This is a plot with a black background. The x-axis ranges from
// -1 to 1 and is labelled (x/Req)√(1 - r_eq/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/Req)√(1 -
// r_eq/R_eq). There is a white dot. The text [0.21 cycles] is at the bottom. The trend shows the white dot is
// centred. g. This is a plot with a black background. The x-axis ranges from -1 to 1 and is labelled (x/Req)√(1
// - r_eq/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/Req)√(1 - r_eq/R_eq). There is a white dot.
// The text [0.25 cycles] is at the bottom. The trend shows the white dot is centred. h. This is a plot with a
// black background. The x-axis ranges from -1 to 1 and is labelled (x/Req)√(1 - r_eq/R_eq). The y-axis ranges
// from -1 to 1 and is labelled (y/Req)√(1 - r_eq/R_eq). There is a white dot and a thin white circle. The text
// [0.29 cycles] is at the bottom. The trend shows the white dot is centred. i. This is a plot with a black
// background. The x-axis ranges from -1 to 1 and is labelled (x/Req)√(1 - r_eq/R_eq). The y-axis ranges from -1
// to 1 and is labelled (y/Req)√(1 - r_eq/R_eq). There is a white dot. The text [0.33 cycles] is at the bottom.
// The trend shows the white dot is centred. j. This is a plot with a black background. The x-axis ranges from -1
// to 1
// [figvision] imgs/f11_1.png
// Panel a: This is a 2D color plot showing energy (E) in keV on the y-axis, ranging from 10^-1 to 10^0, and
// phase (ϕ) in cycles on the x-axis, ranging from 1e-3 to 1e-4 (though it appears to be a non-linear scale). The
// color bar represents photons/keV/cm^2/s, ranging from 0.8 to 3.2. There are no distinct series, symbols, or
// line styles. The trend shows a peak at low energies and phases around 0. Panel b: This plot shows phase (ϕ) in
// cycles on the x-axis, ranging from 0.0 to 2.0, and expected count rate in photons/cm^2/s on the y-axis,
// ranging from 0.2 to 0.8. The plot has multiple colored lines representing 1σ, 2σ, and 3σ confidence intervals
// for the expected count rate, with darker colors having lower expected values. The lines are smooth and wavy.
// Panel c: This 2D color plot shows channel on the y-axis, ranging from 3 × 10^1 to 6 × 10^1, and phase (ϕ) in
// cycles on the x-axis, ranging from 0.0 to 2.0. The color bar represents counts/s, ranging from 2 to 8. There
// are no distinct series, symbols, or line styles. The trend shows peaks at certain phases and channels. Panel
// d: This plot shows phase (ϕ) in cycles on the x-axis, ranging from 0.0 to 2.0, and expected count rate in
// counts/s on the y-axis, ranging from 0.025 to 0.100. The plot has multiple colored lines representing 1σ, 2σ,
// and 3σ confidence intervals for the expected count rate, with darker colors having lower expected values. The
// lines are smooth and wavy, similar to panel b.
// [figvision] imgs/f11_2.png
// Panel a: This is a 2D colour plot showing energy (E) on the y-axis, ranging from 10^-1 to 10^0 keV, and an
// unspecified quantity on the x-axis, ranging from 1e-4 to 2e-4. The colour bar on the right represents
// photons/keV/cm^2/s, ranging from 0.5 to 2.0. The plot shows a gradient-like distribution with higher values at
// lower energies and x-axis values around 1e-4 and 1.8e-4. Panel b: This is a 2D plot of phase (ϕ) in cycles on
// the x-axis, ranging from 0 to 2, and posterior-expected count numbers on the y-axis, ranging from 0.6 to 2.4
// photons/cm^2/s. The plot shows multiple lines with different colours, each representing a 1σ, 2σ, or 3σ range.
// The lines oscillate with a sinusoidal trend, with the darkest line in the middle and lighter lines around it.
// Panel c: This is another 2D colour plot showing channel on the y-axis, ranging from 3 x 10^1 to 6 x 10^1, and
// phase (ϕ) on the x-axis, ranging from 0 to 2. The colour bar on the right represents counts/s, ranging from
// 1.5 to 6.0. The plot shows two bright regions around ϕ = 0.5 and ϕ = 1.5, with a darker region in between.
// Panel d: This plot is similar to panel b, but with counts/s on the y-axis, ranging from 1 to 4. The plot shows
// a similar oscillating trend, with multiple coloured lines representing 1σ, 2σ, and 3σ ranges. The lines are
// more densely packed around ϕ = 0, 1, and 2, indicating a higher concentration of data points in these regions.
// [figvision] imgs/f12_1.png
// a. This is a plot showing the posterior-expected count numbers. The y-axis represents the energy spectrum in
// units of photons/keV/cm^2/s, ranging from 10^-8 to 10^-3. The x-axis represents the energy in keV, ranging
// from 10^-1 to 10^0. The plot shows a curved line with a color gradient indicating the probability density,
// with darker shades representing higher probabilities. The trend shows a decreasing energy spectrum with
// increasing energy. b. This is a 2D heatmap showing the count numbers in units of counts/s. The y-axis
// represents the phase in cycles, ranging from 0 to 2. The x-axis is not labeled but appears to represent a
// channel or time. The color bar on the right side indicates the count numbers, ranging from 2 to 5. The heatmap
// shows a gradual decrease in count numbers from top to bottom and left to right. c. This is a plot showing the
// Poisson residuals. The y-axis represents the counts/s, ranging from 10^-5 to 10^-3. The x-axis represents the
// channel, ranging from 3 x 10^1 to 10^2. The plot shows a curved line with a color gradient indicating the
// probability density, with darker shades representing higher probabilities. A green line is plotted on top,
// showing a relatively flat trend. The trend shows a decreasing count rate with increasing channel number.
// [figvision] imgs/f12_2.png
// a. This is a plot showing the posterior-expected photon flux. The y-axis represents photons/keV/cm²/s, ranging
// from 10⁻⁸ to 10⁻³, and the x-axis represents energy in keV, ranging from 10⁻¹ to 10⁰. A black line indicates
// the mean, and coloured regions represent 1, 2, and 3 sigma uncertainties. The trend shows a decreasing flux
// with increasing energy. b. This is a 2D heatmap showing count numbers. The y-axis represents phase in cycles,
// ranging from 0 to 2, and the x-axis is not labelled but appears to represent time or a similar variable. The
// colour bar indicates counts/s, ranging from 2 to 5 × 10⁻³. The trend shows higher counts at lower phases and
// lower counts at higher phases. c. This is a plot showing posterior-expected count numbers and residuals. The
// y-axis represents counts/s, ranging from 10⁻⁵ to 10⁻³. The x-axis represents channel numbers, ranging from 3 ×
// 10¹ to 10². A black line indicates the mean, and coloured regions represent 1, 2, and 3 sigma uncertainties. A
// green line appears to represent a different variable or model. The trend shows a peak in counts around channel
// 40 and a decrease at higher channels.
// [figvision] imgs/f13.png
// The figure has multiple panels but only one is visible. This panel is a plot. The y-axis is labeled "Mass
// (M☉)" and ranges from 1.6 to 2.6. The x-axis is labeled "Radius (km)" and ranges from 9 to 15. There are four
// series: APR (red solid), HLPS soft (black dashed), HLPS int. (black dash-dotted), and HLPS stiff (black
// solid). The plot contains a blue cross and two cyan ellipses. The trend shows that as radius increases, mass
// also increases for each series, with the cyan ellipses indicating a region of high probability.
// [figvision] imgs/f14.png
// Panel a: This is a plot showing probability density functions for R_{ eq}. The y-axis ranges from 0.5 to 1.75
// and has no units or label. The x-axis ranges from 8 to 16 km. There are two series: a blue line for "NICER x
// XMM ST-U + FI-H" and a red line for "NICER x XMM ST-U + FI-H | EAPC". The blue line peaks at 11.5 km and the
// red line at 12.5 km. There is a shaded region from 11.75 to 13.75 km. Panel b: This is a contour plot of _{
// XTI} vs R_{ eq}. The y-axis ranges from 0.5 to 1.75 and the x-axis from 8 to 16 km. There are two series of
// contours in blue and red corresponding to the two models. The contours are roughly centred on (11.5, 1) and
// (12.5, 1). Panel c: This is a plot showing probability density functions for _{ XTI}. The y-axis ranges from 0
// to 0.25 and has no units or label. The x-axis ranges from 0.5 to 1.75. There are two series: a blue line for
// "NICER x XMM ST-U + FI-H" and a red line for "NICER x XMM ST-U + FI-H | EAPC". The blue line peaks at 1 and
// the red line at 1. The shaded region is from 0.9 to 1.1. Panel d: This is a contour plot of _{ pn} vs R_{ eq}.
// The y-axis ranges from 0.5 to 1.75 and the x-axis from 8 to 16 km. There are two series of contours in blue
// and red corresponding to the two models. The contours are roughly centred on (11.5, 1) and (12.5, 1) but with
// different orientation. Panel e: This is a plot showing probability density functions for _{ pn}. The y-axis
// ranges from 0 to 0.25 and has no units or label. The x-axis ranges from 0.5 to 1.75. There are two series: a
// blue line for "NICER x XMM ST-U + FI-H" and a red line for "NICER x XMM ST-U + FI-H | EAPC". The blue line
// peaks at 1 and the red line at 1. The shaded region is from 0.9 to 1.1.
// [figvision] imgs/f15_1.png
// Panel a. This is a plot showing count number per channel versus channel number. The y-axis ranges from 3000 to
// 9000, and the x-axis ranges from 20 to 150. There are several series: a blue line representing "data", a black
// dashed line for "NICER ST-U + FI-H", a black line for "NICER x XMM ST-U + FI-H", an orange line for another
// "NICER x XMM ST-U + FI-H", a pink dashed line for "space weather", and a green line for "3C50". The trend
// shows a decrease in count number as channel number increases, with the data and some models closely following
// each other. There are no annotations or labels on the plot other than axis labels and a legend. The message is
// that the data and models have similar trends, but there are some discrepancies between them. No objects or
// connections are described in this plot.
// [figvision] imgs/f16_1.png
// Panel a: This is a plot showing count data. The y-axis represents Counts, ranging from 10^-3 to 10^4, and the
// x-axis represents Nominal photon energy in keV, ranging from 0.3 to 10. There are six series: a red line
// representing NICER XTI with a range of approximately 9,000 to 10,000 counts; a black line representing EPIC
// pn; a blue line representing EPIC pn scaled blank-sky; a green line representing source + MCL background |
// support; a pink line representing MCL background | support; and an orange area representing flat prior support
// per channel. The trend shows that the NICER XTI and EPIC pn have higher counts at lower photon energies, while
// the other series have lower counts. No other panels are visible.
// [figvision] imgs/f6.png
// a. This is a heatmap. The vertical axis represents channel and ranges from 30 to 100, and the horizontal axis
// represents phase cycles and ranges from 0 to 1. The colorbar on the right represents counts and ranges from 0
// to 150. The trend shows that counts decrease as channel increases, and there is a slight variation in counts
// across different phase cycles. The color scale goes from dark blue (low counts) to yellow (high counts). b.
// This is a heatmap. The vertical axis represents channel and ranges from 30 to 100, and the horizontal axis
// represents phase cycles and ranges from 0 to 1. The colorbar on the right represents counts and ranges from 0
// to 150. The trend shows that counts decrease as channel increases, with a smooth gradient of colors from dark
// blue (low counts) to yellow (high counts), indicating a more uniform distribution compared to panel a. c. This
// is a heatmap. The vertical axis represents channel and ranges from 30 to 100, and the horizontal axis
// represents phase cycles and ranges from 0 to 2, split into two sections by a vertical line at 1 cycle. The
// colorbar on the right represents the residuals, ranging from -3 to 3. The trend shows random fluctuations
// around zero, with no clear pattern, indicating that the residuals are evenly distributed. The color scale goes
// from dark blue (negative residuals) to dark red (positive residuals), with white indicating near-zero
// residuals.
// [figvision] imgs/f7.png
// a. This panel shows a plot of probability density. The y-axis is M in units of M_, ranging from 1.8 to 2.4.
// The x-axis is R_{eq} in units of km, ranging from 7.5 to 15. There are three series: grey, blue, and red,
// corresponding to XMM ST-U + FI-H, NICER ST-U + FI-H, and NICER XMM ST-U + FI-H. The trend shows that as R_{eq}
// increases, the probability density first increases and then decreases for all series. b. This panel shows a
// plot of probability density. The y-axis is M in units of M_, ranging from 1.8 to 2.4. The x-axis is M in units
// of M_, ranging from 1.8 to 2.4. There are three series: grey, blue, and red. The red and blue series have a
// CI_{68\%} of 2.072^{+0.067}_{-0.066} and D_{KL} of 0.01. The trend shows that as M increases, the probability
// density first increases and then decreases for all series. c. This panel shows a plot of probability density.
// The y-axis is (i), ranging from 0.03 to 0.054. The x-axis is M in units of M_, ranging from 1.8 to 2.4. There
// are three series: grey, blue, and red. The red series has a CI_{68\%} of 0.0424^{+0.0029}_{-0.0029} and D_{KL}
// of 0.01. The trend shows that as M increases, (i) remains relatively constant for all series. d. This panel
// shows a plot of probability density. The y-axis is D in units of kpc, ranging from 0.6 to 1.6. The x-axis is M
// in units of M_, ranging from 1.8 to 2.4. There are three series: grey, blue, and red. The trend shows that as
// M increases, D remains relatively constant for all series. e. This panel shows a plot of probability density.
// The y-axis is N_H in units of 10^{20} {cm}^{-2}, ranging from 2 to 8. The x-axis is R_{eq} in units of km,
// ranging from 7.5 to 15. There are three series: grey, blue, and red. The trend shows that as R_{eq} increases,
// N_H remains relatively constant for all series. f. This panel shows a plot of probability density. The y-axis
// is M in units of M_, ranging from 1.8 to 2.4. The x-axis is (i), ranging from 0.03 to 0.054. There are three
// series: grey, blue, and red. The trend shows that as (i) increases, M remains relatively constant for all
// series. g. This panel shows a plot of probability density. The y-axis is D in units of kpc, ranging from 0.6
// to 1.6. The x-axis is (i), ranging from 0.03 to 0.054. There are three series: grey, blue, and red. The trend
// shows that as (i) increases, D remains relatively constant for all series. h. This panel shows a plot of
// probability density. The y-axis is N_H in units of 10^{20} {cm}^{-2}, ranging from 2 to 8. The x-axis is (i),
// ranging from 0.03 to 0.054. There are three series: grey, blue, and red. The trend shows that as (i)
// increases, N_H remains relatively constant for all series. i. This panel shows a plot of probability density.
// The y-axis
// [figvision] imgs/f8.png
// a. The plot is a histogram. The x-axis represents no specific variable but likely shows a distribution range,
// and the y-axis shows counts, ranging from 0 to 3. There are two series: a blue curve and a red curve. The blue
// curve peaks at approximately 2.1 on the y-axis, and the red curve peaks at approximately 1.9 on the y-axis. A
// red shaded region spans from roughly 1.95 to 2.35 on the x-axis. The trend shows two distinct distributions.
// b. The plot is a histogram. The x-axis represents no specific variable but likely shows a distribution range,
// and the y-axis shows counts, ranging from 0 to 3. There are two series: a blue curve and a red curve. The blue
// curve peaks at approximately 1.05 on the y-axis, and the red curve peaks at approximately 0.95 on the y-axis.
// A red shaded region spans from roughly 0.9 to 1.15 on the x-axis. The trend shows two distinct distributions.
// c. The plot is a histogram. The x-axis represents no specific variable but likely shows a distribution range,
// and the y-axis shows counts, ranging from 0 to 3. There are two series: a blue curve and a red curve. The blue
// curve peaks at approximately -0.15 on the y-axis, and the red curve peaks at approximately -0.25 on the
// y-axis. A red shaded region spans from roughly -0.45 to 0.05 on the x-axis. The trend shows two distinct
// distributions. d. The plot is a 2D contour plot or scatter plot. The x-axis ranges from 7.5 to 15 and is
// labeled as R_{eq} [km]. The y-axis ranges from 0.4 to 3 and is labeled as _p [rad]. There are two series of
// contours or points: blue and red. The blue series has a more concentrated distribution, while the red series
// has a more dispersed distribution. The trend shows a correlation between the two variables. e. The plot is a
// 2D contour plot. The x-axis ranges from -0.4 to 0.4 and is labeled as _p [cycles]. The y-axis ranges from 0.4
// to 3 and is labeled as _p [rad]. There are two series of contours: blue and red. The contours show a similar
// pattern for both series. The trend shows a correlation between the two variables. f. The plot is a 2D contour
// plot. The x-axis ranges from 5.1 to 6.6 and is labeled as _{10}(T_p [K]). The y-axis ranges from 0.4 to 3 and
// is labeled as _p [rad]. There are two series of contours: blue and red. The contours show a similar pattern
// for both series. The trend shows a correlation between the two variables. g. The plot is a 2D contour plot.
// The x-axis ranges from 0.6 to 2.4 and is labeled as _s [rad]. The y-axis ranges from 0.4 to 3 and is labeled
// as _p [rad]. There are two series of contours: blue and red. The contours show a similar pattern for both
// series. The trend shows a correlation between the two variables. h. The plot is a 2D contour plot. The x-axis
// ranges from -0.4 to 0.4 and is labeled as _s [cycles]. The y-axis ranges from 0.4 to 3 and is labeled as _p
// [rad]. There are two series of contours: blue and red. The contours show a similar pattern for both series.
// The trend shows a correlation between the two variables. i. The plot is a 2D contour plot. The x-axis ranges
// from 5.4 to 6.6 and is labeled as _{10}(T_s [K]). The y-axis ranges from 0.4 to 3 and is labeled as _p [rad].
// There are two series of contours: blue and red. The contours show a similar pattern for both series. The trend
// shows a correlation between the two variables. j. The plot is a
// [figvision] imgs/f9_1.png
// ## Panel a This is a plot. The x-axis is (x/R_{{eq}}){1 - r_s/R_{{eq}}} and the range is from -1 to 1. The
// y-axis is (y/R_{{eq}}){1 - r_s/R_{{eq}}} and the range is from -1 to 1. There is one grayscale series, where
// darker shades indicate higher values. There are no symbols or line styles. There is an annotation at the
// bottom left that says "[0.01 keV]". The trend shows a bright region at the top and two horizontal bands in the
// middle of the plot. ## Panel b This is a plot. The x-axis is (x/R_{{eq}}){1 - r_s/R_{{eq}}} and the range is
// from -1 to 1. The y-axis is (y/R_{{eq}}){1 - r_s/R_{{eq}}} and the range is from -1 to 1. There is one
// grayscale series, where darker shades indicate higher values. There are no symbols or line styles. There is an
// annotation at the bottom right that says "[1.00 keV]". The trend shows a similar pattern to panel a, but with
// a different distribution of grayscale values. ## Panel c This is a plot. The x-axis is (x/R_{{eq}}){1 -
// r_s/R_{{eq}}} and the range is from -1 to 1. The y-axis is (y/R_{{eq}}){1 - r_s/R_{{eq}}} and the range is
// from -1 to 1. There is one grayscale series, where darker shades indicate higher values. There are no symbols
// or line styles. There is an annotation at the bottom left that says "[2.00 keV]". The trend shows a similar
// pattern to panels a and b, but with a different distribution of grayscale values. ## Panel d This is a plot.
// The x-axis is (x/R_{{eq}}){1 - r_s/R_{{eq}}} and the range is from -1 to 1. The y-axis is (y/R_{{eq}}){1 -
// r_s/R_{{eq}}} and the range is from -1 to 1. There is one grayscale series, where darker shades indicate
// higher values. There are no symbols or line styles. There is an annotation at the bottom right that says
// "[5.00 keV]". The trend shows a bright region at the right and a horizontal band in the middle of the plot.
// [figvision] imgs/f9_2.png
// ## Panel a This is a plot. The x-axis ranges from -1 to 1 and is labelled (x/R_eq)√(1 - r_s/R_eq). The y-axis
// ranges from -1 to 1 and is labelled (y/R_eq)√(1 - r_s/R_eq). There is one grayscale series, with darker shades
// indicating higher density. There are no symbols or line styles. The annotation "0.01 keV" is at the bottom
// left. The trend shows a bright ring at the bottom with a horizontal band across the middle, with the ring
// being more prominent. ## Panel b This is a plot. The x-axis ranges from -1 to 1 and is labelled (x/R_eq)√(1 -
// r_s/R_eq). The y-axis ranges from -1 to 1 and is labelled (y/R_eq)√(1 - r_s/R_eq). There is one grayscale
// series, with darker shades indicating higher density. There are no symbols or line styles. The annotation
// "1.00 keV" is at the bottom right. The trend shows a similar pattern to panel a but with a less prominent
// ring. ## Panel c This is a plot. The x-axis ranges from -1 to 1 and is labelled (x/R_eq)√(1 - r_s/R_eq). The
// y-axis ranges from -1 to 1 and is labelled (y/R_eq)√(1 - r_s/R_eq). There is one grayscale series, with darker
// shades indicating higher density. There are no symbols or line styles. The annotation "2.00 keV" is at the
// bottom left. The trend shows a similar pattern to panel b but with an even less prominent ring. ## Panel d
// This is a plot. The x-axis ranges from -1 to 1 and is labelled (x/R_eq)√(1 - r_s/R_eq). The y-axis ranges from
// -1 to 1 and is labelled (y/R_eq)√(1 - r_s/R_eq). There is one grayscale series, with darker shades indicating
// higher density. There are no symbols or line styles. The annotation "5.00 keV" is at the bottom right. The
// trend shows a similar pattern to panel c but with the ring and band being much less prominent and more
// vertical.
// [figvision] imgs/f9_3.png
// ## Panel a This is a plot. The y-axis is labelled (y/R_{{eq}}){1 - r_{{s}}/R_{{eq}}} and ranges from -1 to 1.
// The x-axis is labelled (x/R_{{eq}}){1 - r_{{s}}/R_{{eq}}} and ranges from -1 to 1. There is one grayscale
// series, with black indicating low values and white indicating high values. There is an annotation in the
// bottom-left corner reading [0.01 keV]. The trend shows a black hole with an accretion disk, with the disk
// appearing as a bright ring around the black hole. The intensity of the grayscale series decreases as the
// distance from the black hole increases. ## Panel b This is a plot. The y-axis is labelled (y/R_{{eq}}){1 -
// r_{{s}}/R_{{eq}}} and ranges from -1 to 1. The x-axis is labelled (x/R_{{eq}}){1 - r_{{s}}/R_{{eq}}} and
// ranges from -1 to 1. There is one grayscale series, with black indicating low values and white indicating high
// values. There is an annotation in the bottom-left corner reading [1.00 keV]. The trend shows a black hole with
// an accretion disk, with the disk appearing as a bright ring around the black hole. The intensity of the
// grayscale series decreases as the distance from the black hole increases. ## Panel c This is a plot. The
// y-axis is labelled (y/R_{{eq}}){1 - r_{{s}}/R_{{eq}}} and ranges from -1 to 1. The x-axis is labelled
// (x/R_{{eq}}){1 - r_{{s}}/R_{{eq}}} and ranges from -1 to 1. There is one grayscale series, with black
// indicating low values and white indicating high values. There is an annotation in the bottom-left corner
// reading [2.00 keV]. The trend shows a black hole with an accretion disk, with the disk appearing as a bright
// ring around the black hole. The intensity of the grayscale series decreases as the distance from the black
// hole increases. ## Panel d This is a plot. The y-axis is labelled (y/R_{{eq}}){1 - r_{{s}}/R_{{eq}}} and
// ranges from -1 to 1. The x-axis is labelled (x/R_{{eq}}){1 - r_{{s}}/R_{{eq}}} and ranges from -1 to 1. There
// is one grayscale series, with black indicating low values and white indicating high values. There is an
// annotation in the bottom-left corner reading [5.00 keV]. The trend shows a black hole with an accretion disk,
// with the disk appearing as a bright ring around the black hole. The intensity of the grayscale series
// decreases as the distance from the black hole increases.
// [figvision] imgs/f9_4.png
// The figure has four panels, labeled a, b, c, and d. Panel a: This is a grayscale plot showing a circular
// region with a bright ring at the bottom. The x-axis is labeled "(x/Req)√(1-rs/Req)" and ranges from -1 to 1.
// The y-axis is labeled "(y/Req)√(1-rs/Req)" and ranges from -1 to 1. There is a small text label in the
// bottom-left corner that reads "[0.01 keV]". The trend shows a bright ring at the bottom of the circle,
// indicating high intensity in this region. Panel b: This plot is similar to panel a, with the same axis labels
// and ranges. The small text label in the bottom-left corner reads "[1.00 keV]". The trend is similar to panel
// a, with a bright ring at the bottom of the circle. Panel c: This plot is also similar to panel a, with the
// same axis labels and ranges. The small text label in the bottom-left corner reads "[2.00 keV]". The trend is
// similar to panel a, with a bright ring at the bottom of the circle. Panel d: This plot is similar to panel a,
// with the same axis labels and ranges. The small text label in the bottom-left corner reads "[5.00 keV]". The
// trend is similar to panel a, with a bright ring at the bottom of the circle. In general, all panels show a
// circular region with a bright ring at the bottom, indicating high intensity in this region. The brightness of
// the ring decreases as the energy increases from 0.01 keV to 5.00 keV.
#figure(placement: top, image("imgs/f6.png", width: 75.0%),
  caption: [
    _NICER_ count data ${ d_(i k) }$, posterior-expected count numbers ${ c_(i k) }$, and (Poisson) residuals for `ST-U`. Note that we split the count numbers in the upper two panels over two rotational cycles, such that the information on phase interval $phi.alt in [ 0 , 1 ]$ is identical to the information on $phi.alt in ( 0 , 2 ]$; our data sampling distribution, however, is defined as the (conditional) joint probability of all event data grouped into phase intervals on $phi.alt in [ 0 , 1 ]$. We display the standardized (Poisson) residuals in the _bottom_ panel: the residuals for the rotational cycle $phi.alt in [ 0 , 1 ]$ were calculated in terms of all event data on that interval (as for likelihood definition), and simply cloned onto the interval $phi.alt in ( 1 , 2 ]$. In @sec:performance-measures and in the appendix of #cite(<riley19a>, form: "prose") we elaborate on the information displayed here.
  ]
) <fig:ST-U-residuals>









#figure(scope: "parent", placement: top, image("imgs/f7.png", width: 100%),
  caption: [
    One- and two-dimensional marginal PDFs for fundamental parameters, conditional on the `ST-U` model and either the _XMM_ likelihood function alone, the _NICER_ likelihood function alone, or the _NICER_ and _XMM_ likelihood function. From leftmost to rightmost in each panel, the parameters are the equatorial radius, the gravitational mass, the cosine of viewing angle subtended to pulsar spin axis, the distance, and the column density. We display the marginal prior PDFs for each parameter as the _dash-dot_ functions; the informative priors encode the NANOGrav~$times$~CHIME/Pulsar information. We report estimators for the _NICER_~$times$~_XMM_ posterior. We use an automated Gaussian KDE bandwith optimized by _GetDist_~@Lewis19. See the caption of @fig:radio-prior-reversion for additional details about the figure elements.
  ]
) <fig:ST-U-spacetime-corner>









#figure(scope: "parent", placement: top, image("imgs/f8.png", width: 100%),
  caption: [
    One- and two-dimensional marginal posterior distributions of hot region parameters conditional on the `ST-U` model. Three types of posterior distribution are rendered: one conditional only on the _NICER_ likelihood function; one conditional only on the _XMM_ likelihood function; and one conditional on the _NICER_ and _XMM_ likelihood function.
  ]
) <fig:ST-U-geometry-corner>









#figure(scope: "parent", placement: top, [#box(image("imgs/f9_3.png", width: 45.5%)) #box(image("imgs/f9_1.png", width: 45.5%)) #box(image("imgs/f9_4.png", width: 45.5%)) #box(image("imgs/f9_2.png", width: 45.5%))

  ],
  caption: [
    A novel type of figure rendering the phase-averaged expected (photon) specific intensity as a function of sky direction for the source-receiver configuration estimated to maximize the (background-marginalized) `ST-U` likelihood function given by @eqn:background-marginalized-likelihood, showing the two different posterior modes and the effect of _XMM_ likelihood function inclusion. _Top-left set of four panels_: _NICER_ likelihood function---mode one. _Bottom-left set of four panels_: _NICER_ likelihood function---mode two. _Top-right set of four panels_: product of _NICER_ and XMM likelihood functions---mode one. _Bottom-right set of four panels_: product of _NICER_ and _XMM_ likelihood functions---mode two. The expected photon specific flux spectrum registered by _NICER_ if we phase-average, and (when included) the _XMM_ cameras, is implicitly formed from a fine set of these images. These representative images at four photon energies include all relativistic effects in the likelihood function; note that we extend slightly beyond the _XMM_ waveband used for likelihood evaluation in order to render the (relativistic) rotational effects more vividly. Each panel is normalized to the maximum phase-average specific intensity over sky direction at that energy. The background sky has the same intensity---zero---as neighborhoods of the image that a hot region never traverses because the surface exterior of the hot regions is not explicitly radiating in the models (please see @sec:exterior-of-the-hot-regions). For animated (photon) specific intensity sky maps corresponding to these four variants (two posterior mode variants for each of two likelihood function variants), together with pulse-profile traces and spectral evolution, please refer to the online journal.
  ]
) <fig:ST-U-skymap>









#figure(scope: "parent", placement: top, [#block[
  #box(image("imgs/f10.png", width: 100%))

  ]],
  caption: [
    A summary of the animated figure available in the online journal. In the animated figure, the _top_ three panels show the (photon) specific intensity as a function of sky direction at three different photon energies as the star rotates. The _bottom-left_ panel displays the (photon) specific flux pulse-profiles traced out by the skymaps, each normalized to its respective maximum. The _bottom-right_ panel displays the (photon) specific flux spectrum, where the energy bounds each correspond to a skymap energy, as does the vertical line; the trace of the vertical line intersecting the spectrum is one of the pulse profiles. The star rotates 16 times during the 48 second animation. In this summary figure we aim to display the gravitationally lensed geometric configuration of the surface hot regions from our Earthly viewing perspective, over the course of one rotational cycle. We display the (photon) specific intensity as a function of sky direction at the lowest energy, as the star rotates through the panels from left to right and from top to bottom.
  ]
) <fig:animated>










#figure(scope: "parent", placement: top, [#box(image("imgs/f11_1.png", width: 45.5%)) #box(image("imgs/f11_2.png", width: 45.5%))

  ],
  caption: [
    Posterior-expected pulse-profiles conditional on the `ST-U` hot region model and either the _NICER_ likelihood function (_left_ panels) or the _NICER_ and _XMM_ likelihood function (_right_ panels). We show the signal incident on the telescopes (_top_ and _top-center_ panels) and as registered by _NICER_ (_bottom-center_ and _bottom_ panels). The signal in the _top_ panels has been integrated over the linearly-spaced instrument energy intervals, and is effectively proportional to the photon specific flux. The _black_ rate curves are the posterior-expected signals generated by the hot regions in combination. We also represent the conditional posterior distribution of the incident photon flux (_top-center_ panels) and the _NICER_ count rate (_bottom_ panels) at each phase as a set of one-dimensional highest-density credible intervals, and connect these intervals over phase via the contours; these distributions are denoted by $pi ("photons" \/ "cm"^2 \/ "s" | phi.alt)$ and $pi ("counts" \/ "s" | phi.alt)$. Note that the fractional width of the credible interval at each phase is usually higher for $pi ("photons" \/ "cm"^2 \/ "s" | phi.alt)$ than for $pi ("counts" \/ "s" | phi.alt)$ because of the variation permitted for the instrument model; in combination, the signal registered by the instrument is more tightly constrained. To generate the conditional posterior bands we apply the _X-PSI_ package, which in turn wraps the `fgivenx`~@fgivenx package.
  ]
) <fig:ST-U-pulse>









#figure(scope: "parent", placement: top, [#box(image("imgs/f12_1.png", width: 45.5%)) #box(image("imgs/f12_2.png", width: 45.5%))

  ],
  caption: [
    Posterior-expected spectra conditional on the `ST-U` hot region model and either the _NICER_ likelihood function (_left_ panels) or the _NICER_ and _XMM_ likelihood function (_right_ panels). We show the spectrum that would be incident on the telescopes if it were unattenuated by the interstellar medium (_top_ panels) and the signal as registered by _NICER_ (_center_ and _bottom_ panels). The _black_ rate curves are the posterior-expected spectra generated by the hot regions in combination. We represent the conditional posterior distribution $pi ("photons" \/ "keV" \/ "cm"^2 \/ "s" | E)$ of the unattenuated incident photon specific flux at each energy as a set of one-dimensional highest-density credible intervals, and connect these intervals over phase via the contours (_top_ panels); the energies displayed are those spanning the waveband of the _NICER_ channel subset $[ 30 , 150 )$. In the _center_ panels we display the background-marginalized posterior-expectation of the source count-rate signals, _plus_ the background count-rate terms that maximize the _conditional_ likelihood functions; the _center-right_ signal is equivalent to that displayed in the center panel of #ref(<fig:ST-U-residuals>). In the _bottom_ panels we display the posterior-expected count-rate spectra generated by the hot regions in combination and individually, together with the conditional posterior _NICER_ count rate distribution $pi ("counts" \/ "s" | "channel")$ for each channel. Moreover, the topmost _green_ step functions are the phase-average of the _center_ panels---each is effectively, but not exactly, the observed count-number spectrum divided by the total _NICER_ exposure time.
  ]
) <fig:ST-U-spectrum>






Interestingly there are two different posterior modes (due to the near-equatorial inclination),#footnote[Note that these are different geometric configurations because we expressly exclude hot region exchange degeneracy from the prior support (see @sec:temp-field).] which can be seen in more detail in the phase-averaged skymaps in @fig:ST-U-skymap and the animated skymap in @fig:animated. For neither mode are the two hot regions antipodal. The effect on the inferred signal (pulse-profile and phase-averaged spectrum) of combining the two data sets is shown in @fig:ST-U-pulse and @fig:ST-U-spectrum, respectively. The inclusion of the _XMM_ data reduces the contribution of the hot region emission to the unpulsed component of the pulse profile, leading to a lower count rate but an increased pulsation amplitude (see lower panels of @fig:ST-U-pulse) in the combined signal from the hot regions.


= DISCUSSION <sec:discussion>


== Radius measurement and implications for EOS <radius-measurement-and-implications-for-eos>


The inferred equatorial radius of the massive pulsar PSR~J0740+6620 is $R_("eq") = 12.39_(- 0.98)^(+ 1.30)$~km, where the credible interval bounds are approximately the 16% and 84% quantiles in marginal posterior mass, given relative to the median. The inferred mass, $2.072_(- 0.066)^(+ 0.067)$~$M_⊙$ is dominated by the mass prior from the radio timing, $2.08 plus.minus 0.07$~$M_⊙$. The 90% credible interval for the radius is $12.39_(- 1.50)^(+ 2.22)$~km and the 95% credible interval is $12.39_(- 1.68)^(+ 2.63)$~km. It is worth stressing that when we carried out pulse-profile modeling without using the mass prior from radio timing, we would not have inferred independently from the _NICER_ and _XMM_ data alone that PSR~J0740+6620 is a high-mass source (nor did we obtain any informative constraint on the radius; see @sec:radio-impact).


#figure(scope: "parent", placement: top, image("imgs/f13.png", width: 50%),
  caption: [
    Mass versus equatorial radius for several example EOS models from #cite(<Hebeler13>, form: "prose"), showing the difference between non-rotating stellar models and stars rotating at 346~Hz. For each EOS shown the right hand (heavier) curve is for a spin of 346~Hz, while the left-hand (lighter) curve is for zero rotation. The 68% and 95% credible regions for mass and radius inferred from our analysis of PSR~J0740+6620 are shown by the shaded _cyan_ contours. The blue crosshair shows the inferred median values.
  ]
) <fig:mass-vs-radius>

Rotation increases the equatorial radius of a neutron star. The increase in radius for fixed mass is small, as shown in @fig:mass-vs-radius, where mass-radius curves are plotted for four representative EOS that span a wide range of allowed stiffness @Hebeler13. Mass-radius curves for non-rotating stars and stars rotating at 346~Hz are shown for each EOS. For a 2.0~$M_⊙$ star, the equatorial radius increases by slightly more than 0.05~km for the softest EOS, while the increase is as large as 0.2~km for the stiffest EOS. These increases in radius due to spin are smaller than our uncertainty in measuring the neutron star's radius at present. The change in radius due to spin is already incorporated into our pulse-profile models, since we assume the shape of the rotating star is deformed into an oblate shape. While the shape function that we use is an approximation, #cite(<Silva20>, form: "prose") have shown that it is sufficiently accurate for all of the rotation-powered pulsars with spin frequencies less than 400~Hz that _NICER_ observes.












The radius inferred for PSR~J0740+6620 is very similar to the radius inferred from pulse-profile modeling of _NICER_ data for PSR~J0030+0451, although for the latter the inferred mass was lower: #cite(<riley19a>, form: "prose") found $R_("eq") = 12.71_(- 1.19)^(+ 1.14)$~km and $M = 1.34_(- 0.16)^(+ 0.15)$~$M_⊙$; the independent analysis of #cite(<miller19>, form: "prose") found $R_("eq") = 13.02_(- 1.06)^(+ 1.24)$~km and $M = 1.44_(- 0.14)^(+ 0.15)$~$M_⊙$. Note that the width of the credible interval on the radius for PSR~J0740+6620 is not smaller, despite the constraining mass prior: this is due to the lower number of source counts, which limits the precision of the radius measurement. The radius that we report for PSR~J0740+6620 is also consistent with the values inferred from the most recent phase-averaged spectral modeling of quiescent and bursting neutron stars @Nattila17 @Steiner18 @Baillot19 @Gonzalez19[noting that for some of these analyses a neutron star mass is assumed rather than inferred or known in advance], and with indirect constraints from the inner radii of accretion disks @Ludlam17.


The detection of gravitational waves from binary neutron star mergers provides an alternative method of constraining the dense matter EOS. A measurement of tidal deformability and neutron star masses from the late inspiral phase can be used to infer EOS parameters and hence the associated mass-radius relation. The posteriors on any mass-radius relation derived in this way depend on the EOS model and the priors on the model parameters, and this should be kept in mind when comparing them to the radii inferred directly (without reference to EOS models) from pulse profile modeling @Greif19. Nevertheless the radii derived from the tidal deformability of the binary neutron star merger GW170817 are (for a range of EOS models) lower then the value we derived for PSR~J0740+6620 @Abbott18 @Abbott19 @De18 @Most18 @Landry20 @Essick20 @LiA20. However, the credible intervals on the gravitational-wave derived radii are of similar extent, and thus the results are certainly consistent with those derived by _NICER_.


As is clear from @fig:mass-vs-radius, the radius of PSR~J0740+6620 is in the center of the range considered plausible for neutron stars $tilde 2$~$M_⊙$, and appears compatible with a wide range of EOS models @Hebeler13 @Greif19. However full Bayesian inference of EOS models is required to fully quantify the constraints arising. For this we refer the reader to the companion paper by #cite(<Raaijmakers21>, form: "prose"), which carries out EOS inference using results from _NICER_ both individually and in combination with constraints from gravitational wave observations and their electromagnetic counterparts. Using two different high density EOS parameterizations, and models that connect to microscopic calculations of neutron matter from chiral effective field theory interactions at nuclear densities, #cite(<Raaijmakers21>, form: "prose") show that the new _NICER_ results provide tight constraints, for example on the pressure of neutron star matter at around twice saturation density.


The measurement of radius for a high mass neutron star is also interesting for the properties of potential quark cores @Annala20. #cite(<HanS20>, form: "prose") consider the implications of such a measurement for our understanding of quark matter phases in neutron stars for different model types: self-bound strange quark star models; hybrid star models with different types of phase transition; and third family models where two branches with different radii are possible for the same mass @Schertler00. Our upper- and lower-bounds on the radius posterior at high mass disfavor some regions of quark matter parameter space: both the stiffness of the strange quark phase and the transition properties. The inferences are moreover quite restrictive for self-bound strange quark stars and third family stars, both of which typically have low radii at high mass.


We can also look at the implications of the change in radius as one moves from $M tilde 2.0$~$M_⊙$ to $M tilde 1.4$~$M_⊙$, an important distinguishing characteristic of different EOS models @Greif19 @HanS20 @XieWJ20 @Drischler20b. Generally, hadronic EOSs having symmetry energy parameters in the ranges predicted by nuclear mass fits and neutron matter studies and with $M_("max") lt.tilde 2.2 M_⊙$ would result in $Delta R = R_2.0 - R_1.4 lt.tilde - 1$ km. The above studies show that matter with a phase transition around $2 n_("sat")$ to a relatively soft phase with sound speed squared $c_s^2 tilde 1 / 3$ (such as to non-interacting quark matter) would also result in $Delta R lt.tilde - 1$ km. Such models also have $M_("max") lt.tilde 2.2 M_⊙$. In contrast, larger values of $Delta R lt.tilde 0.5$ km suggest either stiffer high-density matter without a phase transition having $M_("max") tilde 2.3 - 2.5 M_⊙$, or a transition to a relatively stiff phase at a transition density $>= 2.6 n_("sat")$ @Drischler20b. Even larger values of $Delta R > 0.5$ km would imply a transition at a lower density $<= 2 n_("sat")$ to similarly stiff matter. The companion paper by #cite(<Raaijmakers21>, form: "prose"), which utilizes parameterized EOS models constrained by theories of neutron matter, together with observations of pulsar masses, gravitational waves from mergers, and the _X-PSI_ _NICER_ results for PSR~J0030+0451 and PSR~J0740+6620, infers that $Delta R tilde.eq - 0.5_(- 1.5)^(+ 1.2)$ km averaged over EOS models. This is consistent with the direct observational value $R_(J 0740) - R_(J 0030) = - 0.3_(- 1.5)^(+ 1.2)$ km @riley19a. Although values of $Delta R < - 1$ km and $Delta R > + 1$ km cannot be ruled out, these results suggest more moderate values of $Delta R$ that favor relatively stiff dense matter with a large $M_("max")$ or an EOS with stiffening at a density $2 - 3 n_("sat")$, which could result from a first order phase transition or a crossover transition like that due to the appearance of quarkyonic matter @McLerran19. Observational upper limits to $M_("max")$, such as the value $M_("max") lt.tilde 2.2 - 2.3 M_⊙$ suggested by GW170817 @Margalit17, could help distinguish these possibilities.


The maximum mass of neutron stars, and hence the boundary between the neutron star and black hole populations, is also a function of the EOS. Currently feasible EOS models would permit a maximum neutron star mass in the range $2 - 3$~$M_⊙$; but stiffer EOS, with larger radii, are required to achieve higher masses. Analysis of the electromagnetic counterpart of the binary neutron star merger GW170817 has suggested a maximum neutron star mass somewhere in the range $2.0 - 2.3$~$M_⊙$ @Margalit17 @Rezzolla18 @Ruiz18 @Shibata19, but there is a strong dependence on how the kilonova is modeled. Nevertheless this range is consistent with the relatively soft EOS inferred from the tidal deformability for GW170817 (see above). The recent detection of GW190814, a binary compact object merger involving an object with mass $tilde 2.6$~$M_⊙$ @Abbott20, is however intriguing. There is considerable debate over whether this object could be a high-mass neutron star rather than a low mass black hole @Fattoyev20 @Sedrakian20 @HuangK20 @Drischler20b @TanH20 @Tsokaros20 @Dexheimer20 @Zhang20 @Tews20b @Godzieba20 and still be consistent with GW170817. The radius that we have inferred for PSR~J0740+6620 suggests a lower maximum mass, however @Raaijmakers21.


== Constraining power of _XMM-Newton_ <sec:XMM-constraining-power>


The likelihood function given _NICER_ and _XMM_ data sets is dominated by the information from the former. However, longer _XMM_ exposure times naturally yield greater constraining power. A deep exposure exists for the rotation-powered millisecond PSR~J0030+0451 @Bogdanov09, and as suggested by #cite(<riley19a>, form: "prose"), the associated spectroscopic (and timing) event data can be jointly modeled with the _NICER_ event data set to address the open question regarding the contribution of the model hot regions to that set of events, which #cite(<miller19>, form: "prose") and #cite(<riley19a>, form: "prose") inferred to be (close to) minimal. The term _minimal_ is used to mean that the hot regions contributed _only_ to the pulsed component of the pulse profile and did not contribute to the unpulsed component. This present Letter offers a demonstration of how this can be executed, albeit with a contribution from _XMM_ that is less informative than the contribution from _NICER_.


The _XMM_ data set for PSR~J0740+6620 is phase-averaged and sparse in terms of overall counts, which renders it less constraining than the _NICER_ data set. However, being an imaging telescope, _XMM_ facilitates better quantification of the contribution from the star (attributed to hot regions in our models) compared to the background, whereas the _NICER_ background is more difficult to constrain both _a priori_ and _a posteriori_. The contribution of the hot regions to the unpulsed component of the _NICER_ pulse-profile is constrained by jointly modeling the _NICER_ and _XMM_ event data.


For PSR~J0740+6620, the contribution from the hot regions is not minimal. Even when one considers only the _NICER_ data set, the hot regions are inferred to generate not only the pulsed component but also part of the unpulsed component of the pulse profile. The effect of including the _XMM_ data in the analysis is to increase the amplitude of the emission from the hot regions by reducing the contribution of the hot regions to the unpulsed component of the pulse profile. Smaller radius stars have larger gravitational fields and cause stronger gravitational lensing. The lensing makes it possible to see the hot regions for a larger fraction of the spin period, the resulting signal has a lower pulsed fraction than the signal from a larger star with less lensing. The samples where the _NICER_-only unpulsed signal is brighter are those where PSR~J0740+6620 is more compact; by weighting away from these, the inclusion of _XMM_ data pushes the posterior towards less compact stars, where the radius is higher @Miller16.


An interesting question is whether the analysis presented in this Letter tells us anything about the effect that a full joint inference analysis might have on the radius inferred for PSR~J0030+0451. The emission from the hot regions for PSR~J0030+0451 conditional on only _NICER_ event data was minimal, meaning the unpulsed component of the combined signal from the hot regions was small. It follows that the inclusion of the _XMM_ constraints can only increase the contribution from the hot regions. However, the magnitude of the increase in brightness and the effect on the inferred radius is hard to predict because several parameters in the model are degenerate and changes in radius can be offset by, e.g., changes in hot region parameters.





#figure(placement: top, image("imgs/f14.png", width: 100%),
  caption: [
    One- and two-dimensional marginal posterior distributions of the _NICER_ and _XMM_ energy-independent effective area scaling factors $alpha_("XTI")$ and $alpha_("pn")$ respectively, and the equatorial radius. The _XMM_ scaling factor $alpha_("pn")$ is shared by the three cameras and is denoted by $alpha_("XMM")$ in @table:-ST-U. The _blue_ _NICER_~$times$~_XMM_ posterior is shown in @fig:ST-U-spacetime-corner as the headline posterior; the properties of this posterior are reported in @table:-ST-U. The _red_ _NICER_~$times$~_XMM_~$\|$~EAPC is conditional on a compressed effective area prior that aims to approximate the telescope calibration uncertainties discussed in @sec:response-models; the acronym EAPC simply means _effective area prior compression_. The prior PDFs are displayed as the _dash-dot_ distributions in each on-diagonal panel.
  ]
) <fig:effective-area-prior-compression>






Finally, we explore sensitivity to prior information about the _NICER_ and _XMM_ energy-independent effective area scaling factors. We importance-sample our joint _NICER_ and _XMM_ posterior to compress the joint prior on these scaling factors, as shown as #ref(<fig:effective-area-prior-compression>). The compressed joint prior approximates published telescope calibration uncertainties (see @sec:response-models) by using telescope-specific scaling factors, each with a Gaussian prior whose standard deviation is $3 %$. By compressing the joint prior, the marginal posterior distribution of the _XMM_ scaling factor median shifts from $tilde 0.93$ up to $tilde 0.98$. Consequently, to conserve the normalization of the high-likelihood count number spectra registered by each _XMM_ camera---which _a posteriori_ have larger typical effective areas after compressing the prior---the brightness of the signal incident on the telescope must decrease. It follows that subject to conserving the pulsed component of the combined signal from the hot regions as required by the _NICER_ event data, the brightness of the unpulsed component of the combined signal decreases as the high-likelihood regions of parameter space shift to slightly less compact stars---and thus to slightly higher radii given the informative mass prior. The overall shift in the posterior PDF of the radius due to the compression ($tilde + 0.3$~km in the median, to $R = 12.71_(- 0.96)^(+ 1.25)$~km) is much smaller than the measurement uncertainty#footnote[Such a small shift is not expected to have any remarkable effect on EOS inference, given typical EOS priors @Greif19. This is demonstrated in #cite(<Raaijmakers21>, form: "prose"), where EOS inference is carried out using both our _NICER_-only inferred radius and our _NICER_~$times$~_XMM_ inferred radius. Despite an overall change in the median radius posterior inferred from the pulse profile modelling $tilde + 1.1$ km once the _XMM_ data set is included, the mass-radius band shifts by a much smaller amount than this, due to the strong influence of the priors on the EOS model.]. However it highlights that instrument cross-calibration is an important aspect of these analyses that warrants careful treatment.


Obtaining estimates of the absolute effective area of an X-ray instrument is a challenging task. Cross-calibration efforts by the International Astrophysical Consortium for High Energy Calibration (IACHEC) using observations from multiple concurrent X-ray telescopes have found offsets typically within $plus.minus 10 %$ but with occasional discrepancies reaching up to $tilde 20 %$ @2011PASJ...63S.657I @2017AandA...597A..35P @2017AJ....153....2M. The tails of the joint posterior PDF of the effective scaling parameters (see @fig:effective-area-prior-compression) go beyond what these calibration measurements indicate, so the resulting radius credible intervals should be taken as conservative estimates.


=== _NICER_ and _XMM-Newton_ backgrounds <sec:NICERXMM_backgrounds>


The _NICER_ background is difficult to estimate directly, but there are two tools available. @fig:background_spaceweather shows the _NICER_ background estimated using the 'space weather' model @SpaceWeather and the '3C50' model @3C50, see also #cite(<bogdanov19a>, form: "prose"). The former models background due to the space weather environment, which varies as _NICER_ moves through different geomagnetic latitudes, and depends on solar activity. The '3C50' model is empirical, taking into account two different types of particle-induced events, the cosmic X-ray background, and a soft X-ray noise component related to operation in sunlight. We also render a set of _NICER_ background estimates for comparison: using joint _NICER_ and _XMM_ posterior samples, we display the _NICER_ background spectrum that maximizes the conditional likelihood function, yielding a band that is a proxy for background variable posterior mass.


The background spectra displayed in @fig:background_spaceweather exceed the space weather model at low energies. This excess is not unreasonable given the presence of multiple other point sources in the _NICER_ field of view.#footnote[The _NICER_ background variables in principle also capture phase-invariant emission from the environment of PSR~J0740+6620 that does not originate from the surface hot regions in the _X-PSI_ model. The _XMM_ background prior information is conservative (see @sec:XMM-background) and can also in principle capture such phase-invariant emission. The _XMM_ likelihood function is not purely marginalized with respect to an informative blank-sky background prior, which could attribute too much emission to the hot regions in the _X-PSI_ model.] In higher channels, the background spectra appear to agree well with the space weather model. There is a possible small systematic under-prediction compared to the space weather model in channels 80$-$100, the level of agreement is satisfactory given the current uncertainties on the background modeling. The level of agreement with the '3C50' model, which exceeds the space weather model at low energies and is consistent with it at higher energies, also appears good. Neither background model includes off-axis X-ray sources that might contaminate the target spectrum, and therefore inferred backgrounds that exceed the two estimates are not in principle a problem.


Once the uncertainties on the two _NICER_ background models are understood more fully, we anticipate being able to use them to reduce systematic error in the pulse-profile modeling. The current radius measurement conditional on the _XMM_ data set---which yields an indirect _NICER_ background constraint---will therefore be superseded. Efforts are also ongoing to quantify the level of background due to any off-axis sources in the field of view.




















#figure(placement: top, image("imgs/f15_1.png", width: 100%),
  caption: [
    A comparison of the _NICER_ background conditional on the _NICER_ likelihood function to the _NICER_ background conditional on the _NICER_ and _XMM_ likelihood function. The _blue_ step function is the total _NICER_ count spectrum, assumed to be generated by the surface hot regions and the phase-invariant background in our modeling. The solid _black_ step function is the background that maximizes the conditional likelihood function given the parameter vector associated with the nested sample reporting the highest value of the background-marginalized likelihood function. The _orange_ step functions (of which there are $10^3$) that form a band are defined similarly, but each is conditional on a sample from the joint _NICER_ and _XMM_ posterior. To ensure tractability, we marginalize over background parameters in order to define a sampling space with $cal(O) ( 10 )$ dimensions; it follows that we cannot estimate marginal posterior PDFs from our posterior samples for each background variable due to information loss. Strictly, the _orange_ band should therefore _not_ be interpreted as a collection of posterior PDFs---one per background variable---but are indicative of where posterior mass will be concentrated. We compare the backgrounds to estimates of the _NICER_ background generated using the _NICER_ Space Weather background estimation tool @SpaceWeather and the '3C50' model @3C50. We provide a supplementary figure that shows the _NICER_ background for the $10^3$ highest-likelihood nested samples, given the _NICER_ and _XMM_ likelihood function; we also provide a figure that shows the _NICER_ background for a set of $10^3$ posterior samples after compression of the joint prior PDF of the telescope effective areas (see @fig:effective-area-prior-compression and associated text). The complete figure set ($3$ images) is available in the online journal.
  ]
) <fig:background_spaceweather>







In @fig:XMM-background we display the _XMM_ pn background spectra that maximize the conditional likelihood function given nested samples from the joint _NICER_ and _XMM_ posterior, together with supplementary information. Graphical checking of the spectra against the blank-sky estimate and the event data does not reveal any problems _a posteriori_.




















#figure(placement: top, image("imgs/f16_1.png", width: 100%),
  caption: [
    We add to @fig:pn-count-spectrum the _XMM_ pn background spectra that maximize the conditional likelihood function (denoted by MCL in the legend) given nested samples from the joint _NICER_ and _XMM_ posterior, but subject to the prior support of the background variables. That is, if the maximum of the conditional likelihood function is not within the prior support, the nearest value of the background to the maximum that is within the prior support is used in the spectrum. We also show the total spectra as the sum of the _XMM_ pn source spectra (given the nested samples from the joint _NICER_ and _XMM_ posterior) and the _XMM_ pn background spectra that maximize the conditional likelihood function. The complete figure set ($3$ images) for the three _XMM_ cameras is available in the online journal.
  ]
) <fig:XMM-background>






== Hot region configuration <hot-region-configuration>


The hot region configuration is assumed to be related to the star's magnetic field structure. In our previous analysis of PSR~J0030+0451, the superior model was `ST+PST`: one of the hot regions was a small spherical cap and the other a long extended arc. A configuration in which the hot regions were antipodal was strongly disfavored. Although the hot regions were separated by approximately 180$degree$ in longitude, both were in the same hemisphere of the star.


An antipodal configuration is also disfavored for PSR~J0740+6620, once again arguing against a simple dipolar model (although the configuration is closer to antipodal than it is for PSR~J0030+0451). The location of the emitting regions is however rather different. The expected number of counts contributing to the total expected _NICER_ signal for PSR~J0740+6620 is not (close to) minimal _a posteriori_, despite the diffuse _XMM_ likelihood function (@sec:XMM-constraining-power). Only one of the hot regions vanishes from sight during the rotational cycle; the other remains visible at all times. For PSR~J0030+0451, the expected number of counts contributing to the total expected _NICER_ signal is (close to) minimal _a posteriori_ for all models that passed graphical posterior predictive checking @riley19a; in all cases the hot regions were inferred to dance around the stellar limb, each being entirely non-visible for a substantial fraction of a rotational cycle.


We considered a range of shapes for the hot regions, from circles to rings and arcs. For PSR~J0740+6620 the `ST-U` model (in which both hot regions are circles) provides a reasonable description of the data in terms of e.g. residuals. A more complex model, `ST+PST` (the superior model for PSR~J0030+0451) did not offer any improvement in model quality measures nor did it lead to changes in the inferred radius or hot region geometry. For PSR~J0030+0451 `ST-U` provided a reasonable description of the data, but we were sensitive _a posteriori_ to additional complexity in the structure of one of the hot regions; consequently, a large shift in the inferred radius was reported. No extended arc structure is inferred for the secondary hot region for PSR~J0740+6620, although the hot region could well be a ring instead of a spherical cap.


The pulse profile modeling presented in this work constrains the location and shape of the hot regions on the neutron star surface. These regions arise either via heating by magnetospheric currents @Kalapotharakos20, or through complex magneto-thermal evolution in the stellar crust @deGrandis20. Thus, the information obtained can be used as input for modeling magnetic field structure both in the magnetosphere and inside the star, however, there are currently many unknowns in the picture.


Qualitatively, the pulsars which spin faster have more compact magnetospheres and larger (and more complex if the field has a substantial non-dipolar component) open field line regions. If heating happens at the open field line footprints, then one would expect heated regions of PSR~J0740+6620 (with the ratio of light cylinder to neutron star radii, $R_("LC") / R_("NS") = 11.1$) to be larger than those of PSR~J0030+0451 ($R_("LC") / R_("NS") = 18.3$), provided that both pulsars have field configurations of similar complexity (i.e. similar relative magnitude of higher-order components), contrary to what is being inferred from the data.


Detailed modeling of pulsar magnetic fields similar that performed by #cite(<Kalapotharakos20>, form: "prose"), together with an analysis of crustal thermal evolution would be interesting from an evolutionary point of view. PSR~J0740+6620 has a white dwarf companion while PSR~J0030+0451 is solitary and the difference in recent accretion history may play a role in field configuration and residual heating pattern. Their masses are also substantially different, and according to the population study by #cite(<Antoniadis16>, form: "prose"), such a large difference cannot be attributed to accretion alone and must stem partly from the difference in progenitor properties.


== Analysis cross-check <analysis-cross-check>


An independent analysis carried out within the _NICER_ collaboration by #cite(<IMJ0740>, form: "prose") reports a PSR~J0740+6620 radius of $13.71_(- 1.50)^(+ 2.62)$ km, derived from their combined _NICER_ and _XMM_ analysis. The 68% credible intervals overlap with those that we report in this Letter, but the differences deserve some explanation. Recall that our pulse-profile modeling involves several elements: the _NICER_ phase-resolved data set; the _XMM_ phase-averaged data set; a model for the generation of the count data (including priors on the model parameters); and statistical samplers.


Let us first focus on the analysis of the _NICER_ data. The two teams make different choices on what energy channels to include in the _NICER_ data set: we use channels [30,150) whereas #cite(<IMJ0740>, form: "prose") use channels [30,123] (although #cite(<IMJ0740>, form: "prose") report that including higher channels does not lead to notable changes in their results).


The two teams also make a number of different prior choices. #cite(<IMJ0740>, form: "prose") assume priors on the mass, distance, and inclination with larger spread to account for potential systematic error on top of the values reported by #cite(<Fonseca20>, form: "prose"). #cite(<IMJ0740>, form: "prose"), unlike us, do not impose a hard upper-limit on the prior support of the radius (see @sec:radius-prior-design): they assume a flat prior on the reciprocal of the compactness $R_("eq") / r_g ( M ) tilde U ( 3.2 , 8.0 )$.#footnote[The absence of prior support for high radii is effectively incorporated at a later stage, in the EOS analysis carried out by #cite(<IMJ0740>, form: "prose").] We define the prior support so as to exclude hot-region exchange degeneracy---thus halving the number of posterior modes---whereas #cite(<IMJ0740>, form: "prose") do not exclude exchange degeneracy. We also condition on different prior PDFs of the hot region center colatitudes and effective temperatures: the prior PDFs of our hot region center colatitudes are isotropic;#footnote[Meaning uniform in the cosine of the hot region center colatitude.] and our prior PDFs of the logarithms of the effective temperatures are uniform. Finally, we use a marginal prior distribution of the energy-independent _NICER_ effective area scaling factor that has a larger spread and broader prior support than #cite(<IMJ0740>, form: "prose"); as we discuss below, however, this is not thought to be important. Our prior PDFs are defined in @table:-ST-U.


The two teams implement different statistical sampling protocols. We use nested sampling (MultiNest) with high-resolution settings, whilst @IMJ0740 use a hybrid nested sampling (MultiNest) and parallel-tempering ensemble MCMC scheme; #cite(<IMJ0740>, form: "prose") use far more core hours during the ensemble sampling phase of their computations than during the nested sampling phase. Where both teams use MultiNest, our resolution settings are higher:#footnote[A caveat is that the performance of nested sampling with given resolution settings, on the same target distribution, is also dependent on the structure of the likelihood function in the native sampling space---the native sampling space is not however unique because different transformations can be defined to inverse-sample a particular joint prior PDF.] we use up to $8 times 10^4$ live-points with a bounding hypervolume expansion factor of $10$, and we eliminate hot-region exchange degeneracy. For the same target distribution, using a higher number of live-points and eliminating hot-region exchange degeneracy (and thus the halving the number of modes) both yield lower likelihood-isosurface bounding approximation error; a higher number of live points also yields finer sampling of the distribution. Potential variation arising from sampler choice is nicely illustrated in the exploratory study by #cite(<Bilby>, form: "prose"), which investigates the effect on estimation of parameters of gravitational wave signals from compact binary coalescences.


These different modeling choices lead to some minor differences in the reported spreads of the radius posterior PDFs conditional on _NICER_ data. However, the degree of overlap is high: we find $R = 11.29_(- 0.81)^(+ 1.20)$ km (see @table:-NICER-ST-U); #cite(<IMJ0740>, form: "prose") find $R = 11.51_(- 1.13)^(+ 1.87)$ km.


The radius posterior PDF differences become more pronounced once the _XMM_ data set is included. Our posterior is shifted down in radius relative to the #cite(<IMJ0740>, form: "prose") posteriors which extend to higher radii. Once again, the two groups make a number of different choices that have more of an impact for a smaller data set. We use different formulations of the prior on the _XMM_ background: #cite(<IMJ0740>, form: "prose") use a distribution based on the assumedly Poissonian observed numbers of blank-sky counts whereas we use a flat prior as described in #ref(<sec:XMM-background>). Our posterior is also conditional on a broader prior for the cross-calibration uncertainty of the two instruments than #cite(<IMJ0740>, form: "prose") (who restrict the maximum relative calibration offset to $plus.minus 10$ %); this permits lower inferred radii in our analysis (see @sec:XMM-constraining-power, where we study the effect of narrowing the cross-calibration uncertainty). And as already mentioned, #cite(<IMJ0740>, form: "prose") are more agnostic in terms of priors on the radius (allowing $R > 16$ km): the _XMM_ likelihood function permits larger radii (see @fig:ST-U-spacetime-corner) and hence their posterior PDF extends accordingly to higher radii.


Despite these differences, the inclusion of the _XMM_ data is still extremely valuable, because in both analyses there is a consistent increase in radius, with the lowest radii being ruled out. Moreover, there are good prospects for improving this: once the uncertainties on the _NICER_ background estimates mentioned in @sec:NICERXMM_backgrounds are clear, we anticipate being able to use those to supplement the indirect constraint on the _NICER_ background provided by the _XMM_ data set.


= CONCLUSIONS <sec:conclusion>


We have derived a posterior distribution of the radius of the massive rotation-powered millisecond pulsar PSR~J0740+6620, conditional on _NICER_ XTI pulse-profile modeling, joint NANOGrav and CHIME/Pulsar wideband radio timing, and _XMM_ EPIC spectroscopy. The radius that we infer for PSR~J0740+6620 is $12.39_(- 0.98)^(+ 1.30)$ km with an inferred mass (dominated by the radio-derived prior) of $2.072_(- 0.066)^(+ 0.067) M_⊙$. A measurement of radius for such a high-mass pulsar should provide a strong constraint on dense matter EOS models @Raaijmakers21, with the derived radius favoring models of intermediate stiffness. We anticipate being able to improve this measurement in the near future thanks to the ongoing development of detailed models of the _NICER_ background. This will be incorporated into future pulse-profile modeling, improving upon the current indirect constraint provided by the _XMM_ data set.


Pulse-profile modeling also enables us to infer the properties of the X-ray emitting hot regions, which are assumed to be linked to the magnetic field structure. The two hot regions are not antipodal, arguing against a simple dipole magnetic field. There is however no evidence for extended crescents, as indicated by pulse profile modeling for PSR~J0030+0451 @riley19a; simple circular hot regions (spherical caps) suffice to describe the PSR~J0740+6620 data adequately. How this relates to the evolutionary history of the two sources remains to be determined.


The analysis presented here also includes improvements to our pulse-profile modeling methodology and software, most notably the ability to include (in this case) phase-averaged X-ray data from _XMM_ EPIC. For PSR~J0740+6620, the inclusion of this data set led to a remarkable shift in the inferred radius. We have also investigated the sensitivity to uncertainties in instrumental cross-calibration, an area where we may be able improve our modeling in the future. _XMM_ EPIC data sets exist for other _NICER_ pulse-profile modeling targets, including the source analyzed in #cite(<riley19a>, form: "prose"), PSR~J0030+0451. In that analysis the _XMM_ EPIC data was used retrospectively, as a check on the consistency of the inferred model _a posteriori_; more formally this information should be used to form a likelihood function that is a product of likelihood function factors over telescopes, as in this present work. In future work, we will use the improved pipeline presented in this Letter to perform joint analysis of the _NICER_ and _XMM_ data sets for PSR~J0030+0451 and other sources.



#block[
This work was supported in part by NASA through the _NICER_ mission and the Astrophysics Explorers Program. T.E.R. and A.L.W. acknowledge support from ERC Consolidator Grant No.~865768 AEONS (PI: Watts). T.E.R. also acknowledges support from the Nederlandse Organisatie voor Wetenschappelijk Onderzoek (NWO) through the VIDI and Projectruimte grants (PI: Nissanke). This work was sponsored by NWO Exact and Natural Sciences for the use of supercomputer facilities, and was carried out on the Dutch national e-infrastructure with the support of SURF Cooperative. This work was granted access to the HPC resources of CALMIP supercomputing center under the allocation 2016- P19056. S.B.~was funded in part by NASA grants NNX17AC28G and 80NSSC20K0275. S.M.M. thanks NSERC for support. W.C.G.H. appreciates use of computer facilities at the Kavli Institute for Particle Astrophysics and Cosmology and acknowledges support through grant 80NSSC20K0278 from NASA. R.M.L. acknowledges the support of NASA through Hubble Fellowship Program grant HST-HF2-51440.001. Support for H.T.C. was provided by NASA through the NASA Hubble Fellowship Program grant \#HST-HF2-51453.001 awarded by the Space Telescope Science Institute, which is operated by the Association of Universities for Research in Astronomy, Inc., for NASA, under contract NAS5-26555. T.T.P. is a NANOGrav Physics Frontiers Center Postdoctoral Fellow funded by the National Science Foundation award number 1430284. The National Radio Astronomy Observatory is a facility of the National Science Foundation operated under cooperative agreement by Associated Universities, Inc. S.M.R. is a CIFAR Fellow and is supported by the NSF Physics Frontiers Center award 1430284. Pulsar research at UBC is supported by an NSERC Discovery Grant and by the Canadian Institute for Advanced Research. This research has made extensive use of NASA's Astrophysics Data System Bibliographic Services (ADS) and the arXiv. We would also like to acknowledge the administrative and facilities staff whose labor supports our work.


_Facility:_ NICER XTI #cite(<Gendreau16>), NANOGrav, Green Bank Telescope, CHIME/Pulsar, _XMM-Newton_ EPIC.

_Software:_ Python/C language #cite(<Python2007>), GNU Scientific Library (GSL; Gough 2009), NumPy #cite(<Numpy2011>), Cython #cite(<cython2011>), SciPy (Jones et al. 2001–), OpenMP #cite(<openmp>), MPI #cite(<MPI>), MPI for Python #cite(<mpi4py>), Matplotlib (Hunter 2007; Droettboom et al. 2018), IPython #cite(<IPython2007>), Jupyter #cite(<Kluyver:2016aa>), TEMPO2 (photons; #cite(<Hobbs06>, style: "aas_noparen.csl")), PINT (photonphase; #link("https://github.com/nanograv/PINT")), #box[#smallcaps[MultiNest]] #cite(<MultiNest_2009>), #box[#smallcaps[PyMultiNest]] #cite(<PyMultiNest>), _GetDist_ #cite(<Lewis19>, supplement: [#link("https://github.com/cmbant/getdist")]), _nestcheck_ (Higson 2018; Higson et al. 2018, 2019), _fgivenx_ #cite(<fgivenx>), NICERsoft (#link("https://github.com/paulray/NICERsoft")), _X-PSI_ `v0.7` (#link("https://github.com/ThomasEdwardRiley/xpsi"); #cite(<xpsi>, style: "aas_noparen.csl")).

]






















#show bibliography: set text(size: 9pt, font: "Latin Modern Roman 9")
#show bibliography: set par(leading: 0.794em)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 12pt, weight: "regular")
#bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)


#set page(columns: 1)

#[
  #show heading.where(level: 1): set text(size: 10pt)
  #heading(numbering: none, outlined: false)[APPENDIX]
]

#figure(
  placement: none,
  {
    show math.equation.where(block: true): set block(above: 0pt, below: 0pt)
    show math.equation.where(block: true): set align(left)
    show math.equation.where(block: true): set text(size: 8pt)
    set math.equation(numbering: none)
    text(size: 8pt, table(
    columns: (70pt, 159pt, 151pt, 43pt, 35pt, 45pt),
    inset: (x: 3.5pt, y: 2.5pt),
    align: (left,left,left,right,right,right),
    stroke: (x, y) => (
      top: 0.4pt,
      left: if x == 1 or x == 2 or x == 3 { 0.4pt },
    ),
    table.header(repeat: true, [_Parameter_], [_Description_], [_Prior PDF (density and support)_], [$hat("CI")_(68 %)$], [$hat(D)_("KL")$], [$hat("ML")$],),
    table.hline(stroke: 0.9pt),
    [$P$ [ms]], [coordinate spin period], [$P = 2.8857$,#footnote[Cromartie et al. (2020); Wolff et al. (2021)] fixed], [$-$], [$-$], [$-$],
    [$M$ $[ "M"_⊙ ]$], [gravitational mass], [$M , cos ( i ) tilde N ( bold(mu)^star.op , bold(Sigma)^star.op )$], [$2.072_(- 0.066)^(+ 0.067)$], [$0.01$], [$2.070$],
    [], [joint prior PDF $N ( bold(mu)^star.op , bold(Sigma)^star.op )$], [$bold(mu)^star.op = [ 2.082 , 0.0427 ]^top$], [], [], [],
    [], [], [$ bold(Sigma)^star.op = mat(delim: "[", 0.0703^2, 0.0131^2; 0.0131^2, 0.00304^2) $], [], [], [],
    [$R_("eq")$ [km]], [coordinate equatorial radius], [$R_("eq") tilde U ( 3 r_(upright(g)) ( 1 ) , 16 )$#footnote[The function $r_(upright(g)) ( M ) := G M / c^2$ denotes the gravitational radius with dimensions of length.]], [$12.39_(- 0.98)^(+ 1.30)$], [$0.58$], [$11.02$],
    [], [compactness condition#footnote[The coordinate polar radius of the source $2$-surface, $R_("polar") ( M , R_("eq") , Omega )$, is a quasi-universal function adopted from AlGendy and Morsink (2014), where $Omega := 2 pi / P$ is the coordinate angular rotation frequency.]], [$R_("polar") / r_(upright(g)) ( M ) > 3$], [], [], [],
    [], [effective gravity condition#footnote[The range of effective gravity from the equator (minimum gravity) to the pole (maximum gravity) must lie within `NSX limits`. A quasi-universal function is adopted from AlGendy and Morsink (2014) for effective gravity $g_("eff") ( theta   M , R_("eq") , Omega )$ in units of cm~$"s"^(-2)$ in the table, where $Omega := 2 pi / P$ is the coordinate angular rotation frequency.]], [$13.7 <= log_10 g_("eff") ( theta ) <= 15.0$,~$forall theta$], [], [], [],
    [$Theta_p$ [radians]], [$p$ region center colatitude], [$cos ( Theta_p ) tilde U ( - 1 , 1 )$], [$1.35_(- 0.39)^(+ 0.46)$], [$0.25$], [$1.622$],
    [$Theta_s$ [radians]], [$s$ region center colatitude], [$cos ( Theta_s ) tilde U ( - 1 , 1 )$], [$1.89_(- 0.46)^(+ 0.40)$], [$0.24$], [$2.303$],
    [$phi.alt_p$ [cycles]], [$p$ region initial phase#footnote[With respect to the meridian on which Earth lies.]], [$phi.alt_p tilde U ( - 0.5 , 0.5 )$, wrapped#footnote[The periodic boundary is admitted and handled by #smallcaps[MultiNest]. However, this is an unnecessary measure because we straightforwardly define the mapping from the native sampling space to the space of a phase parameter $phi.alt$ such that the likelihood function maxima are not in the vicinity of this boundary.]], [bimodal], [$3.52$], [$0.185$],
    [$phi.alt_s$ [cycles]], [$s$ region initial phase#footnote[With respect to the meridian on which the Earth antipode lies.]], [$phi.alt_s tilde U ( - 0.5 , 0.5 )$, wrapped], [bimodal], [$3.51$], [$0.243$],
    [$zeta_p$ [radians]], [$p$ region angular radius], [$zeta_p tilde U ( 0 , pi / 2 )$], [$0.147_(- 0.041)^(+ 0.070)$], [$2.18$], [$0.093$],
    [$zeta_s$ [radians]], [$s$ region angular radius], [$zeta_s tilde U ( 0 , pi / 2 )$], [$0.146_(- 0.042)^(+ 0.071)$], [$2.15$], [$0.127$],
    [], [no region-exchange degeneracy], [$Theta_s >= Theta_p$], [], [], [],
    [], [non-overlapping hot regions], [function of $( Theta_p , Theta_s , phi.alt_p , phi.alt_s , zeta_p , zeta_s )$], [], [], [],
    ))
    v(2pt)
    align(right)[_Continued on next page_]
  },
  caption: [Summary table for `ST-U` `NSX` fully-ionized hydrogen hot regions plugged into the _NICER_~$times$~_XMM_ likelihood function, conditional on the NANOGrav~$times$~CHIME/Pulsar prior PDF. The description in this caption is largely adopted from #cite(<riley19a>, form: "prose") for consistency. We provide: (i) the parameters that constitute the sampling space, with symbols, units, and short descriptions; (ii) any notable derived or fixed parameters; (iii) the joint prior distribution, including hard truncation bounds and constraint equations that define the hyperboundary of the support; (iv) one-dimensional (marginal) $68.3 %$ credible interval estimates symmetric in posterior mass about the _median_ ($hat("CI")_(68 %)$); (v) KL-divergence estimates in _bits_ ($hat(D)_("KL")$) representing prior-to-posterior information gain (see the appendix of #cite(<riley19a>, form: "prose") for high-level description of the divergence); and (vi) the parameter vector ($hat("ML")$) estimated to maximize the background-marginalized likelihood function, corresponding to a nested sample. Note that strictly, the target of nested sampling is not to generate a maximum likelihood estimator---it is a by-product of the sampling process for evidence estimation. Moreover, there is degeneracy in the likelihood function and high-likelihood solutions with remarkably different parameter values---such as a radius near or above the posterior median---may be retrieved from the public sample information. Constraint equations in terms of two or more parameters result in _marginal_ distributions that are not equivalent to those inverse-sampled.],
  kind: table,
) <table:-ST-U>

#pagebreak()

#block({
  show math.equation.where(block: true): set block(above: 0pt, below: 0pt)
  show math.equation.where(block: true): set align(left)
  show math.equation.where(block: true): set text(size: 8pt)
  set math.equation(numbering: none)
  [#align(center)[_Table 1--Continued from previous page_]]
  v(4pt)
  text(size: 8pt, table(
    columns: (70pt, 159pt, 151pt, 43pt, 35pt, 45pt),
    inset: (x: 3.5pt, y: 2.5pt),
    align: (left,left,left,right,right,right),
    stroke: (x, y) => (
      top: if y < 9 { 0.4pt },
      left: if (x == 1 or x == 2 or x == 3) and y < 9 { 0.4pt },
    ),
    [$log_10 (cal(T)_p thin [ "K" ])$], [$p$ region `NSX` effective temperature], [$log_10 (cal(T)_p) tilde U ( 5.1 , 6.8 )$, `NSX` limits], [$5.988_(- 0.059)^(+ 0.048)$], [$2.95$], [$6.080$],
    [$log_10 (cal(T)_s thin [ "K" ])$], [$s$ region `NSX` effective temperature], [$log_10 (cal(T)_s) tilde U ( 5.1 , 6.8 )$, `NSX` limits], [$5.992_(- 0.058)^(+ 0.047)$], [$2.98$], [$6.058$],
    [$cos ( i )$], [cosine Earth inclination to spin axis], [$M , cos ( i ) tilde N ( bold(mu)^star.op , bold(Sigma)^star.op )$], [$0.0424_(- 0.0029)^(+ 0.0029)$], [$0.01$], [$0.044$],
    [$D$ [kpc]], [Earth distance], [$D tilde "skewnorm" ( 1.7 , 1.0 , 0.23 )$#footnote[Specifically, the PDF defined as `scipy.stats.skewnorm.pdf(D, 1.7, loc=1.002, scale=0.227)`, truncated to the interval $D in [ 0 , 1.7 ]$~kpc.]], [$1.21_(- 0.15)^(+ 0.15)$], [$0.10$], [$0.995$],
    [$N_("H") [10^20 "cm"^(-2)]$], [interstellar neutral H column density], [$N_("H") tilde U ( 0 , 10 )$], [$1.587_(- 1.092)^(+ 1.953)$], [$0.91$], [$0.216$],
    [$alpha_("NICER")$], [NICER effective-area scaling], [$alpha_("NICER") , alpha_("XMM") tilde N ( bold(mu) , bold(Sigma) )$], [$1.026_(- 0.137)^(+ 0.136)$], [$0.03$], [$1.111$],
    [$alpha_("XMM")$], [_XMM_ effective-area scaling], [$alpha_("NICER") , alpha_("XMM") tilde N ( bold(mu) , bold(Sigma) )$], [$0.93_(- 0.13)^(+ 0.14)$], [$0.17$], [$0.638$],
    [], [joint prior PDF $N ( bold(mu) , bold(Sigma) )$], [$bold(mu) = [ 1.0 , 1.0 ]^top$], [], [], [],
    [], [], [$ bold(Sigma) = mat(delim: "[", 0.150^2, 0.106^2; 0.106^2, 0.150^2) $], [], [], [],
    table.hline(stroke: 0.4pt),
    [], [Sampling process information], [], [], [], [],
    [], [number of free parameters:#footnote[In the sampling space; the number of background count rate variables is equal to the number of channels defined by the _NICER_ and _XMM_ data sets.] $15$], [], [], [], [],
    [], [number of processes:#footnote[The mode-separation #smallcaps[MultiNest] variant was deactivated, meaning that isolated modes are not evolved independently and nested sampling threads contact multiple modes. In principle this also allows us to combine the processes in a post-processing phase using _nestcheck_~@higson2018nestcheck, if more than one process is available for a given posterior; the posteriors derived in the production analysis are high-resolution, so we neglect combining repeat processes.] $1$], [], [], [], [],
    [], [number of live points: $4 times 10^4$], [], [], [], [],
    [], [hypervolume expansion factor: $0.1^(- 1)$], [], [], [], [],
    [], [termination condition: $10^(- 1)$], [], [], [], [],
    [], [evidence:#footnote[Defined as the prior predictive probability $p ( d_(upright(N)) , d_(upright(X)) , { cal(B)_(upright(X)) } | "ST" - "U" )$. Note, however, that in order to complete the reported evidence for comparison to models other than those defined in this work, upper-bounds for the _NICER_ background parameters need to be specified.] $hat(ln cal(Z)) = - 20714.61 plus.minus 0.02$], [], [], [], [],
    [], [number of core#footnote[Intel® Xeon® E5-2697A v4.] hours: $28320$], [], [], [], [],
    [], [likelihood evaluations: $23710136$], [], [], [], [],
    [], [nested replacements: $1250386$], [], [], [], [],
    [], [effective sample size:#footnote[The effective sample size estimator invoked, following *DNest4*~@Brewer2018[#link("https://github.com/eggplantbren/DNest4")], is the _perplexity_ measure $hat("ESS") := exp(-sum_i^I w_i log w_i)$, where the ${ w_i }_(i = 1 , dots.h , I)$ are the sample weights @Martino2017.] $420281$], [], [], [], [],
    table.hline(stroke: 0.4pt),
    ))
})

#pagebreak()

#figure(
  placement: none,
  {
    show math.equation.where(block: true): set block(above: 0pt, below: 0pt)
    show math.equation.where(block: true): set align(left)
    show math.equation.where(block: true): set text(size: 8pt)
    set math.equation(numbering: none)
    text(size: 8pt, table(
    columns: (70pt, 159pt, 151pt, 43pt, 35pt, 45pt),
    inset: (x: 4pt, y: 2.5pt),
    align: (left,left,left,right,right,right),
    stroke: (x, y) => (
      top: if y < 20 { 0.4pt },
      left: if (x == 1 or x == 2 or x == 3) and y < 20 { 0.4pt },
    ),
    table.header(repeat: true, [_Parameter_], [_Description_], [_Prior PDF (density and support)_], [$hat("CI")_(68 %)$], [$hat(D)_("KL")$], [$hat("ML")$],),
    table.hline(stroke: 0.9pt),
    [$P$ [ms]], [coordinate spin period], [$P = 2.8857$, fixed], [$-$], [$-$], [$-$],
    [$M$ $[ "M"_⊙ ]$], [gravitational mass], [$M , cos ( i ) tilde N ( bold(mu) , bold(Sigma) )$], [$2.078_(- 0.063)^(+ 0.066)$], [$0.01$], [$2.125$],
    [], [joint prior PDF $N ( bold(mu)^star.op , bold(Sigma)^star.op )$], [$bold(mu)^star.op = [ 2.082 , 0.0427 ]^top$], [], [], [],
    [], [], [$ bold(Sigma)^star.op = mat(delim: "[", 0.0703^2, 0.0131^2; 0.0131^2, 0.00304^2) $], [], [], [],
    [$R_("eq")$ [km]], [coordinate equatorial radius], [$R_("eq") tilde U ( 3 r_(upright(g)) ( 1 ) , 16 )$], [$11.29_(- 0.81)^(+ 1.20)$], [$0.72$], [$10.90$],
    [], [compactness condition], [$13.7 <= log_10 g_("eff") ( theta ) <= 15.0$,~$forall theta$], [], [], [],
    [$Theta_p$ [radians]], [$p$ region center colatitude], [$cos ( Theta_p ) tilde U ( - 1 , 1 )$], [$1.13_(- 0.47)^(+ 0.63)$], [$0.13$], [$0.425$],
    [$Theta_s$ [radians]], [$s$ region center colatitude], [$cos ( Theta_s ) tilde U ( - 1 , 1 )$], [$1.98_(- 0.62)^(+ 0.49)$], [$0.13$], [$1.610$],
    [$phi.alt_p$ [cycles]], [$p$ region initial phase#footnote[With respect to the meridian on which Earth lies.]], [$phi.alt_p tilde U ( - 0.5 , 0.5 )$, wrapped], [bimodal], [$3.46$], [$- 0.267$],
    [$phi.alt_s$ [cycles]], [$s$ region initial phase#footnote[With respect to the meridian on which the Earth antipode lies.]], [$phi.alt_s tilde U ( - 0.5 , 0.5 )$, wrapped], [bimodal], [$3.47$], [$- 0.309$],
    [$zeta_p$ [radians]], [$p$ region angular radius], [$zeta_p tilde U ( 0 , pi / 2 )$], [$0.191_(- 0.057)^(+ 0.102)$], [$1.69$], [$0.233$],
    [$zeta_s$ [radians]], [$s$ region angular radius], [$zeta_s tilde U ( 0 , pi / 2 )$], [$0.189_(- 0.058)^(+ 0.104)$], [$1.68$], [$0.132$],
    [], [no region-exchange degeneracy], [$Theta_s >= Theta_p$], [], [], [],
    [], [non-overlapping hot regions], [function of $( Theta_p , Theta_s , phi.alt_p , phi.alt_s , zeta_p , zeta_s )$], [], [], [],
    [$log_10 (cal(T)_p thin [ "K" ])$], [$p$ region `NSX` effective temperature], [$log_10 (cal(T)_p) tilde U ( 5.1 , 6.8 )$, `NSX` limits], [$6.014_(- 0.063)^(+ 0.048)$], [$2.90$], [$6.068$],
    [$log_10 (cal(T)_s thin [ "K" ])$], [$s$ region `NSX` effective temperature], [$log_10 (cal(T)_s) tilde U ( 5.1 , 6.8 )$, `NSX` limits], [$6.017_(- 0.062)^(+ 0.048)$], [$2.89$], [$6.086$],
    [$cos ( i )$], [cosine Earth inclination to spin axis], [$M , cos ( i ) tilde N ( bold(mu)^star.op , bold(Sigma)^star.op )$], [$0.0426_(- 0.0028)^(+ 0.0029)$], [$0.01$], [$0.045$],
    [$D$ [kpc]], [Earth distance], [$D tilde "skewnorm" ( 1.7 , 1.0 , 0.23 )$#footnote[The PDF defined as `scipy.stats.skewnorm.pdf(D, 1.7, loc=1.002, scale=0.227)`, truncated to the interval $D in [ 0 , 1.7 ]$~kpc.]], [$1.19_(- 0.14)^(+ 0.14)$], [$0.08$], [$1.145$],
    [$N_("H") [10^20 "cm"^(-2)]$], [interstellar neutral H column density], [$N_("H") tilde U ( 0 , 10 )$], [$1.34_(- 0.93)^(+ 1.87)$], [$1.07$], [$0.029$],
    [$alpha_("NICER")$], [NICER effective-area scaling], [$alpha_("NICER") tilde N ( 1 , 0.15^2 )$], [$0.97_(- 0.13)^(+ 0.15)$], [$0.04$], [$1.083$],
    table.hline(stroke: 0.4pt),
    [], [Sampling process information], [], [], [], [],
    [], [number of free parameters:#footnote[In the sampling space; the number of background count rate variables is equal to the number of channels defined by the _NICER_ data set.] $14$], [], [], [], [],
    [], [number of processes:#footnote[The mode-separation #smallcaps[MultiNest] variant was deactivated, meaning that isolated modes are not evolved independently and nested sampling threads contact multiple modes.] $1$], [], [], [], [],
    [], [number of live points: $4 times 10^4$], [], [], [], [],
    [], [hypervolume expansion factor: $0.1^(- 1)$], [], [], [], [],
    [], [termination condition: $10^(- 1)$], [], [], [], [],
    [], [number of core#footnote[Intel® Xeon® E5-2697A v4.] hours: $24000$], [], [], [], [],
    [], [likelihood evaluations: $26858453$], [], [], [], [],
    [], [nested replacements: $1208371$], [], [], [], [],
    [], [effective sample size: $303905$], [], [], [], [],
    table.hline(stroke: 0.4pt),
    ))
  },
  caption: [Summary table for `ST-U` `NSX` fully-ionized hydrogen hot regions plugged into the _NICER_ likelihood function, conditional on the NANOGrav~$times$~CHIME/Pulsar prior PDF. See the caption of @table:-ST-U and the associated footnotes for details.],
  kind: table,
) <table:-NICER-ST-U>