#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.79cm, right: 1.76cm, top: 2.36cm, bottom: 2.50cm))
#set page(numbering: none, columns: 2, header-ascent: 18pt, header: context {
  let n = counter(page).get().first()
  if n > 1 {
    let num = text(10pt, counter(page).display())
    let mid = if calc.odd(n) [EOS and neutron star properties from NICER and multimessenger observations] else [Raaijmakers et al.]
    grid(columns: (1fr, auto, 1fr),
      if calc.odd(n) { [] } else { num },
      align(center, text(10pt, mid)),
      if calc.odd(n) { align(right, num) } else { [] })
  }
})
#let asup(b) = text(size: 6pt, baseline: 3.8pt, style: "normal", b)
#let fsup(b) = text(size: 6pt, baseline: 2.8pt, style: "normal", b)
#set math.equation(numbering: "(1)", supplement: [Equation])
#set heading(numbering: (..nums) => numbering("1.1", ..nums) + ".")
#show ref: it => {
  if it.element != none and it.element.func() == heading {
    let nums = counter(heading).at(it.target)
    let num = numbering("1.1", ..nums)
    if it.supplement == none { link(it.target)[#num] }
    else { link(it.target)[Section #num] }
  } else { it }
}
#show figure.caption: it => {
  set text(size: 9pt)
  [*#it.supplement #context it.counter.display(it.numbering).* #it.body]
}
#show figure.caption: set par(justify: true)
#show figure.caption: set align(left)
#show heading.where(level: 1): set text(size: 9pt, weight: "regular")
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set block(above: 1.5em, below: 1.1em)
#show heading.where(level: 2): set text(size: 10pt, weight: "regular")
#show heading.where(level: 2): set align(center)
#show heading.where(level: 2): set block(above: 1.2em, below: 0.4em)
#show heading.where(level: 3): set text(size: 10pt, weight: "regular")
#show heading.where(level: 3): set align(center)
#show heading.where(level: 3): set block(above: 1.2em, below: 0.4em)
#set par(justify: true, spacing: 0.56em, first-line-indent: (amount: 0.9em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.57em)
#set figure.caption(position: bottom)
#show math.equation.where(block: true): set align(center)

#place(top, float: true, scope: "parent", [
#set par(spacing: 0em)
#block(width: 100%, inset: (x: 9pt))[
  #set text(size: 8pt)
  #set par(leading: 0.5em, spacing: 0em)
  Draft version June 15, 2021 \
  Typeset using LaTeX twocolumn style in AASTeX62
]
#v(40pt)
#align(center)[
  #set text(size: 10pt)
  #set par(leading: 0.57em)
  Constraints on the dense matter equation of state and neutron star properties from \
  #emph[NICER's] mass-radius estimate of PSR~J0740$+$6620 and multimessenger observations
]
#v(6.5pt)
#align(center)[
  #set text(size: 9pt)
  #set par(justify: false, leading: 0.49em)
  G.~Raaijmakers,#asup[1] S.~K.~Greif,#asup[2, 3] K.~Hebeler,#asup[2, 3] T.~Hinderer,#asup[4] S.~Nissanke,#asup[1, 5] A.~Schwenk,#asup[2, 3, 6] T.~E.~Riley,#asup[7] A.~L.~Watts,#asup[7] J.~M.~Lattimer,#asup[8] and W.~C.~G.~Ho#asup[9]
]
#v(16.3pt)
#align(center)[
  #block(width: 515pt)[
    #set text(size: 8pt, style: "italic")
    #set par(justify: false, leading: 0.48em, spacing: 6pt)
    #fsup[1]GRAPPA, Anton Pannekoek Institute for Astronomy and Institute of High-Energy Physics, University of Amsterdam, Science Park 904, 1098 XH Amsterdam, Netherlands

    #fsup[2]Technische Universität Darmstadt, Department of Physics, 64289 Darmstadt, Germany

    #fsup[3]ExtreMe Matter Institute EMMI, GSI Helmholtzzentrum für Schwerionenforschung GmbH, 64291 Darmstadt, Germany

    #fsup[4]Institute for Theoretical Physics, Utrecht University, Princetonplein 5, 3584CC Utrecht, The Netherlands

    #fsup[5]Nikhef, Science Park 105, 1098 XG Amsterdam, The Netherlands

    #fsup[6]Max-Planck-Institut für Kernphysik, Saupfercheckweg 1, 69117 Heidelberg, Germany

    #fsup[7]Anton Pannekoek Institute for Astronomy, University of Amsterdam, Science Park 904, 1090GE Amsterdam, the Netherlands

    #fsup[8]Department of Physics and Astronomy, Stony Brook University, Stony Brook, NY 11794-3800, USA

    #fsup[9]Department of Physics and Astronomy, Haverford College, 370 Lancaster Avenue, Haverford, PA 19041, USA
  ]
]
#v(19pt)
#align(center)[#text(size: 10pt)[ABSTRACT]]
#v(8.5pt)
#align(center)[
  #block(width: 442pt)[
    #set text(size: 10pt)
    #set par(justify: true, leading: 0.59em, spacing: 0em, first-line-indent: (amount: 9pt, all: true))
    In recent years our understanding of the dense matter equation of state (EOS) of neutron stars has significantly improved by analyzing multimessenger data from radio/X-ray pulsars, gravitational wave events, and from nuclear physics constraints. Here we study the additional impact on the EOS from the jointly estimated mass and radius of PSR~J0740$+$6620, presented in #cite(<Riley21>, form: "prose") by analyzing a combined dataset from X-ray telescopes #emph[NICER] and #emph[XMM-Newton]. We employ two different high-density EOS parameterizations: a piecewise-polytropic (PP) model and a model based on the speed of sound in a neutron star (CS). At nuclear densities these are connected to microscopic calculations of neutron matter based on chiral effective field theory interactions. In addition to the new #emph[NICER] data for this heavy neutron star, we separately study constraints from the radio timing mass measurement of PSR~J0740$+$6620, the gravitational wave events of binary neutron stars GW190425 and GW170817, and for the latter the associated kilonova AT2017gfo. By combining all these, and the #emph[NICER] mass-radius estimate of PSR~J0030$+$0451, we find the radius of a $1.4 thin$M$""_⊙$ neutron star to be constrained to the 95% credible ranges $12.33_(- 0.81)^(+ 0.76) thin$km (PP model) and $12.18_(- 0.79)^(+ 0.56) thin$km (CS model). In addition, we explore different chiral effective field theory calculations and show that the new #emph[NICER] results provide tight constraints for the pressure of neutron star matter at around twice saturation density, which shows the power of these observations to constrain dense matter interactions at intermediate densities.
  ]
]
#v(15.1pt)
#align(center)[
  #block(width: 446pt)[
    #set text(size: 9.8pt, style: "italic")
    #set par(justify: false)
    Keywords: dense matter --- equation of state --- stars: neutron --- X-rays: stars --- gravitational waves
  ]
]
#v(15.1pt)
])


= Introduction
<sec:intro>
Our understanding of the dense matter equation of state (EOS) of neutron stars has made significant progress over the last few years due to the arrival of new avenues to measure observables like mass, radius and tidal deformability, that connect to the behavior of matter at supranuclear densities. Recently NASA's X-ray timing telescope, the #emph[Neutron Star Interior Composition Explorer] (#emph[NICER]), has delivered the first joint measurement of mass and radius through pulse profile modeling of the millisecond pulsar PSR~J0030$+$0451 @Riley19#cite(<Miller19>). The impact of this measurement on the dense matter EOS has been extensively studied in various EOS frameworks @Raaijmakers19@Miller19@Raaijmakers20@Essick20@Landry20@Dietrich20@Jiang20@AlMamun21, including EOS with phase transitions to quark matter @XieWJ20c@LiA20@Tang20@Blaschke20@Alvarez20b and models that explore the possibility of there being two stable neutron star branches #cite(<Christian20>).

Concurrently, the second and third observing runs of LIGO/Virgo have so far resulted in the confirmed gravitational wave detections of two (most-likely) binary neutron star mergers: GW170817 @GW170817discovery@GW170817sourceproperties and GW190425 #cite(<GW190425>). By accurately measuring the gravitational wave phase, limits can be put on the EOS-dependent tidal deformability of the neutron stars @Flanagan:2007ix#cite(<Hinderer10>). While for GW170817 the tidal deformability could be measured within a $90 %$ highest posterior density interval when adopting low spin priors @Abbott18@LIGO_161218_catalog, the low signal-to-noise ratio (SNR) of GW190425 resulted in only weak upper limits on the tidal deformability even when assuming low spins #cite(<GW190425>). We consider the $tilde.op 2.6$ M$""_⊙$ secondary object in GW190814 @Abbott20_GW190814 to be a black hole @Nathanail21, and will therefore not use this third event in our analysis.

At nuclear densities, the EOS is well constrained by nuclear theory and experiments @Tsan12esymm@Latt12esymm#cite(<Huth21>). In particular, many-body calculations based on chiral effective field theory (EFT) interactions have enabled systematic predictions for the neutron matter EOS up to nuclear saturation density including theoretical uncertainties @Hebeler13@Tews13@Lynn16@Drischler19#cite(<Drischler20>). Up to saturation density, the resulting symmetry energy and pressure of neutron matter are also consistent with extractions from nuclear experiments @Latt12esymm, including from measurements of the dipole polarizability of neutron-rich nuclei @Roca-Maza15@Birkhan17#cite(<Kaufmann2020>). Taking these results at nuclear densities, combined with standard crust EOS, different extrapolations to high densities have been found to lead to NS radii consistent with all multimessenger observations @Raaijmakers20@Essick20@Annala20@Dietrich20#cite(<Biswas20>). Recently, the results of PREX-II have pointed to higher pressures @Adhikari21@Reed21, but with very large uncertainties, so that in a combined analysis with astrophysical and chiral EFT constraints, the overall consistency still persists #cite(<Essick21>).

#emph[NICER] data has now enabled a joint estimate of the mass and radius of the high-mass rotation-powered millisecond pulsar PSR~J0740$+$6620. Since PSR~J0740$+$6620 (unlike PSR~J0030$+$0451) is in a binary with an inclination that allows measurement of the Shapiro delay, its mass can be measured independently via radio timing. #cite(<Cromartie19>, form: "prose") reported a mass of $2.14_(- 0.09)^(+ 0.10)$ M$""_⊙$, and a joint campaign by the #emph[North American Nanohertz Observatory for Gravitational Waves] (NANOGrav) and the #emph[Canadian Hydrogen Intensity Mapping Experiment] (CHIME)/Pulsar collaborations has now resulted in an updated mass of $2.08 plus.minus 0.07$ M$""_⊙$ #cite(<Fonseca21>).

#cite(<Riley21>, form: "prose") have used this mass measurement as an informative prior for pulse-profile modeling analysis that is joint over the phase-resolved spectroscopic data from #emph[NICER] and phase-averaged data from the #emph[XMM-Newton] European Photon Imaging Camera (EPIC). The inclusion of the smaller #emph[XMM-Newton] (hereafter #emph[XMM]) data set allows for better constraints on the proportion of the X-ray emission that is attributable to background rather than PSR~J0740$+$6620, ultimately acting to cut out solutions with high compactness. This results in an inferred radius of $12.39_(- 0.98)^(+ 1.30)$ km, and a mass of $2.072_(- 0.066)^(+ 0.067)$ M$""_⊙$ that is little changed from the radio prior. For a full description of the methodology employed in the mass-radius inference we refer the reader to #cite(<Riley21>, form: "prose").

In this Letter, we use the mass and radius from #cite(<Riley21>, form: "prose") for PSR~J0740$+$6620 as input for inferring the dense matter EOS, combining it with other constraints from nuclear theory and multi-messenger observations. It should be considered as a follow-up to our previous work that built on #emph[NICER]'s results for PSR~J0030$+$0451 @Raaijmakers19@Raaijmakers20, where in this work we explore also a broader range of multi-messenger constraints. As the high-density constraints from astrophysical observations get more precise, with the new #emph[NICER] results and future LIGO/Virgo measurements, it will be intriguing to see them play out with the present nuclear constraints. In this Letter, we also explore this for the new #emph[NICER] results and how they constrain the EOS above nuclear densities starting from different chiral EFT calculations#footnote[The posterior samples and scripts to make the plots in this Letter are available in a Zenodo repository at #cite(<plotdata2>, form: "prose").].

= Inference framework
<inference-framework>
In this work we will closely follow the analysis framework developed previously in #cite(<Greif19>, form: "prose"), #cite(<Raaijmakers19>, form: "prose") and #cite(<Raaijmakers20>, form: "prose"). Below, we summarize this method and highlight several updates to the framework.

We consider two EOS parameterizations: i) a piecewise polytropic (PP) model with three segments between varying transitions densities @Hebeler13, and ii) a speed-of-sound (CS) model first introduced in #cite(<Greif19>, form: "prose"). To capture the uncertainty in the EOS around nuclear saturation density ($n_0 = 0.16 thin "fm"^(- 3)$), both parameterizations are matched to a power law fit of a range of EOS calculated from chiral effective field theory interactions @Hebeler10a@Hebeler13 below $1.1 n_0$. At densities below $0.5 n_0$ this power law fit is connected to the BPS crust EOS #cite(<Baym71>).

// [figvision] imgs/MR_posteriors_updated_pulsarmass.png
// Panel a: This is a plot showing the mass-radius relation of neutron stars using the PP model. The y-axis
// represents mass in solar masses (M) and ranges from 1.0 to 3.0, while the x-axis represents radius in
// kilometers (km) and ranges from 9 to 15. There are four series: a black dashed line for the prior, an orange
// dashed-dotted line for PSR-J0740+6620 with a radio mass of 2.14 M, an orange dashed line for PSR-J0740+6620
// with a radio mass of 2.08 M, and two shaded regions (green and beige) corresponding to these masses. The
// credible regions are and . The trend shows that with the inclusion of new data, the mass-radius relation
// shifts and narrows. Panel b: This plot is similar to panel a but uses the CS model. The axes have the same
// ranges and units as panel a. The series and their meanings are the same as in panel a. The credible regions
// are also and . The trend is similar to panel a, with the mass-radius relation shifting and narrowing with new
// data. The black dashed line in both panels likely represents a boundary or a reference line for the
// mass-radius relation.

To constrain these EOS parameterizations, governed by the EOS parameters $bold(theta)$, we employ Bayes' theorem and write the posterior distributions of the EOS parameters and central energy densities $bold(epsilon)$ as $ p ( bold(theta) , bold(epsilon) thin \| thin bold(d) , bb(M) ) prop p ( bold(theta) thin \| thin bb(M) ) med p ( bold(epsilon) thin \| thin bold(theta) , bb(M) ) med p ( bold(d) thin \| thin bold(theta) , bb(M) ) thin , $<eq:eq1> where $bb(M)$ denotes the model including all assumed physics and $bold(d)$ the dataset used to constrain the EOS, consisting of, e.g., radio-, X-ray and gravitational wave data. When assuming each of these datasets to be independent of each other, we can separate the likelihoods and write $ p ( bold(theta) , bold(epsilon) thin \| thin & bold(d) , bb(M) ) prop p ( bold(theta) thin \| thin bb(M) ) med p ( bold(epsilon) thin \| thin bold(theta) , bb(M) )\
 & times product_i p ( Lambda_(1 , i) , Lambda_(2 , i) , M_(1 , i) , M_(2 , i) thin \| thin bold(d)_(G W , i) ( , bold(d)_(E M , i) ) )\
 & times product_j p ( M_j , R_j thin \| thin bold(d)_(N I C E R , j) )\
 & times product_k p ( M_k thin \| thin bold(d)_(r a d i o , k) ) thin . $<eq:eq2> Here the products run over the number of different observed stars, or mergers, in the case of the gravitational wave data. Furthermore, in Equation (#ref(<eq:eq2>, supplement: none)) we have equated the nuisance-marginalized likelihoods to the nuisance-marginalized posterior distributions derived in #cite(<Riley19>, form: "prose")@Fonseca21@Riley21@GW170817sourceproperties#cite(<GW190425>). This approximation is justifiable when the priors used in estimating these nuisance-marginalized posterior distributions are uninformative, which for simplicity we will assume to be a uniform prior in this case. The posterior distributions derived by #cite(<Riley19>, form: "prose") and #cite(<Riley21>, form: "prose") already use a jointly uniform prior in mass and radius. The posterior distributions derived by #cite(<GW170817sourceproperties>, form: "prose") and #cite(<GW190425>, form: "prose") use a jointly uniform prior in the tidal deformabilities of the two components $Lambda_i$ within the range $Lambda_i subset [ 0 , 5000 ]$ (for GW190425 the upper bound of $Lambda_2$ was set to $10^4$.). The prior on the detector frame masses, which are redshifted with respect to the source frame masses ($M_(upright("det")) = M_i ( 1 + z )$), is uniform within the range $M_(upright("det")) subset [ 0.5 , 7.7 ]$ and $M_(upright("det")) subset [ 1 , 5.31 ]$ for GW170817 and GW190425 respectively. However, the posterior distribution on component masses from gravitational waves is highly degenerate because of the accurately measured chirp mass $cal(M)_c = ( M_1 M_2 )^(3 / 5) / ( M_1 + M_2 )^(1 / 5)$. To speed up the convergence of our parameter estimation, we therefore transform the gravitational wave posterior distributions to include the two tidal deformabilities, chirp mass and mass ratio $q$, while reweighing such that the prior distribution on these parameters is uniform. Further, we also fix the chirp mass to its median value, since the small uncertainty in this parameter does not affect the EOS parameter estimation @Raaijmakers20, and thus have: $ p ( bold(theta) , bold(epsilon) thin \| thin & bold(d) , bb(M) ) prop p ( bold(theta) thin \| thin bb(M) ) med p ( bold(epsilon) thin \| thin bold(theta) , bb(M) )\
 & times product_i p ( Lambda_(1 , i) , Lambda_(2 , i) , q_i thin \| thin cal(M)_c , bold(d)_(G W , i) ( , bold(d)_(E M , i) ) )\
 & times product_j p ( M_j , R_j thin \| thin bold(d)_(N I C E R , j) )\
 & times product_k p ( M_k thin \| thin bold(d)_(r a d i o , k) ) thin . $<eq:eq3> Fixing the chirp mass means that the vector $bold(epsilon)$ only contains one central density per merger, where the tidal deformability of the second component is now set by $Lambda_2 = Lambda_2 ( bold(theta) ; q )$. If a gravitational wave event has an associated electromagnetic (EM) counterpart, the likelihood for that event becomes a product of the nuisance-marginalized posterior distribution from the gravitational wave data and the nuisance-marginalized posterior distribution from the EM analysis, such that: #text(size: 9pt)[$ p ( Lambda_1 , Lambda_2 , q thin \| thin cal(M)_c , bold(d)_("GW") , & bold(d)_("EM") ) prop p ( Lambda_1 , Lambda_2 , q thin \| thin cal(M)_c , bold(d)_("GW") )\
 & times p ( Lambda_1 , Lambda_2 , q thin \| thin cal(M)_c , bold(d)_("EM") ) thin . $] Obtaining the posterior distribution $p ( Lambda_1 , Lambda_2 , q thin \| thin cal(M)_c , bold(d)_("EM") )$ is discussed in @subsec:at2017gfo for the specific case of AT2017gfo, the kilonova associated with GW170817 @LVCmultimessenger@GW170817grb@Arcavi17@GW170817swope@Chornock17@Cowperthwaite17@Kasliwal17@Nicholl17#cite(<Tanvir17>).

We then sample from the posterior distribution $p ( bold(theta) , bold(epsilon) thin \| thin bold(d) , bb(M) )$, compute the corresponding $M$, $R$, and $Lambda$, and then evaluate the likelihood by applying a kernel density estimation to the posterior distributions from #cite(<Riley19>, form: "prose")@Riley21@GW170817sourceproperties@GW190425 using the nested sampling software #smallcaps[MultiNest]. The same prior distribution $p ( bold(theta) thin \| thin bb(M) )$ is used as in previous work; we refer the reader to Section 2.3 of #cite(<Raaijmakers20>, form: "prose") and references therein for a more detailed description.

#figure(
    align(center, image("imgs/MR_posteriors_updated_pulsarmass.png", width: 95%)),
    caption: [
    Constraints on the mass-radius relation of neutron stars, given the posterior distribution on EOS parameters $bold(theta)$ using the PP model (left) and CS model (right panel). The constraints from the updated radio timing mass of PSR~J0740$+$6620 from #cite(<Fonseca21>, form: "prose") (present work, green) are compared to the mass from #cite(<Cromartie19>, form: "prose") used in our previous works @Raaijmakers19@Raaijmakers20 (orange, dashed-dotted), showing both the $68 %$ and $95 %$ credible regions. The black dashed lines indicate the $95 %$ credible region of the prior distribution. Note that the slightly lower mass measurement does not have a significant impact on the EOS posterior.
    ],
  placement: top,
  scope: "parent",
) <fig:fig1>

= EOS constraints
<sec:eos>
In this Section we investigate the impact of the #cite(<Riley21>, form: "prose") mass-radius measurement for PSR~J0740$+$6620 on the dense matter EOS, both separately and when combined with previous constraints.

== Radio mass measurement of PSR~J0740$+$6620
<radio-mass-measurement-of-psr-j07406620>
Firstly, we constrain the EOS using the updated mass measurement of $2.08 plus.minus 0.07$ M$""_⊙$ for PSR~J0740$+$6620 derived using radio timing @Fonseca21, and compare this to the constraints from the previously published mass of $2.14_(- 0.09)^(+ 0.1)$ M$""_⊙$ #cite(<Cromartie19>). In Figure~#ref(<fig:fig1>, supplement: none) we show the posterior distribution on EOS parameters $bold(theta)$ when transformed to the mass-radius parameter space. We note that, as expected, the slightly lower updated mass measurement shifts the posterior distributions to lower maximum neutron star masses and lower radii, although the effect is almost negligible. Since the radio timing mass measurement is already incorporated in the joint mass-radius estimate from #emph[NICER] we will not use this measurement in the remainder of this work.

== GW170817 and GW190425
<gw170817-and-gw190425>
The gravitational wave events GW170817 and GW190425 have so far been the only confirmed neutron star binary mergers during the recent observing runs of the LIGO/Virgo collaboration #cite(<GWTC2>). Although both events have a non-negligible chance of being neutron star-black hole mergers (see, e.g., #cite(<Yang:2017gfb>, form: "prose")@Ascenzi19@Coughlin19@Hinderer19 for GW170817 and e.g., #cite(<Kyutoku20>, form: "prose")@Han20 for GW190425), in the following we will assume both objects to be neutron stars. We use the low-spin#footnote[The low-spin assumption is chosen to be consistent with measurements of spins in Galactic neutron star binaries that merge within a Hubble time.] posterior distributions on tidal deformability and mass ratio with the `IMRPhenomPv2_NRTidal`#footnote[See Table 1 of #cite(<GW170817sourceproperties>, form: "prose") for a description of the waveform model.] waveform model @Hannam:2013oca@Khan:2015jqa@Dietrich19a for GW170817 and GW190425. Furthermore we use the median chirp mass values of $cal(M)_c = 1.186$ M$""_⊙$ for GW170817#footnote[#link("https://dcc.ligo.org/LIGO-P1800370/public/")] and $cal(M)_c = 1.44$ M$""_⊙$ for GW190425#footnote[#link("https://dcc.ligo.org/LIGO-P2000223/public/")].

// [figvision] imgs/AT2017gfo_posterior.png
// The figure shows a plot of bolometric luminosity versus time. The y-axis represents bolometric luminosity in
// ergs per second, ranging from 10^40 to 10^42, while the x-axis represents time in days, ranging from 10^0 to
// 10^1. A red shaded area indicates the 95% credible region of the posterior distribution. Dark blue dots with
// error bars represent data from Kasliwal et al. (2017). The trend shows a decrease in bolometric luminosity
// over time, with the posterior distribution's credible region encompassing most data points. The message
// suggests a correlation between luminosity and time.
#figure(image("imgs/AT2017gfo_posterior.png", width: 100%),
  caption: [
    In blue we show the bolometric luminosity of GW170817 from the data compiled in #cite(<Kasliwal17>, form: "prose"). The red band contains $95 %$ of the light curves of the posterior distribution when fitted with the model described in @subsec:at2017gfo.
  ],
  placement: top,
  scope: "parent",
)
<fig:figEM>

// [figvision] imgs/MR_posteriors_GW170817_EM.png
// Panel a: This is a plot of mass versus radius for neutron stars. The y-axis represents mass in solar masses
// (M) and ranges from 1.0 to 3.0. The x-axis represents radius in kilometers (km) and ranges from 8 to 14. There
// are three series: a black dashed line for the prior, an orange dash-dot line for GW170817, and a green shaded
// area for GW170817 + AT2017gfo. The trend shows that with more data, the posterior distribution shifts to lower
// radii, indicating softer EOS. Panel b: This is another plot of mass versus radius for neutron stars, similar
// to panel a but for the CS model. The axes have the same ranges and units as panel a. The series and colors
// have the same meanings as panel a. The trend shows a similar shift in posterior distribution with more data,
// but with a different shape and location compared to the PP model in panel a.
// [figvision] imgs/MR_posteriors_GW170817_GW190425_v3.png
// Panel a: The plot shows the mass-radius relation of neutron stars using the PP model. The y-axis represents
// mass in solar masses (M), ranging from 1.0 to 3.0, and the x-axis represents radius in kilometers (km),
// ranging from 8 to 14. The plot contains four series: a black dashed line for the prior, an orange
// dashed-dotted line for GW170817, a blue dotted line for GW190425, and a green shaded area for the combination
// of GW170817 and GW190425. The trend shows that the posterior distribution shifts towards lower radii and
// masses when including GW170817. Panel b: The plot shows the mass-radius relation of neutron stars using the CS
// model. The y-axis represents mass in solar masses (M), ranging from 1.0 to 3.0, and the x-axis represents
// radius in kilometers (km), ranging from 8 to 14. The plot contains the same series as panel a, with similar
// line styles and colors. The trend shows a similar shift in posterior distribution as in panel a, but with a
// slightly different shape and location of the contours. There is no panel c.
#figure(
    align(center, stack(dir: ttb, spacing: 0.6em,
      image("imgs/MR_posteriors_GW170817_GW190425_v3.png", width: 95%),
      image("imgs/MR_posteriors_GW170817_EM.png", width: 95%))),
    caption: [
    #emph[Upper panels:] Constraints on the mass-radius relation of neutron stars, given the posterior distribution on EOS parameters $bold(theta)$ using the PP model (left) and CS model (right) when analyzing the gravitational wave events GW170817 @GW170817discovery and GW190425 @GW190425, both separately and combined. The estimated tidal deformability from GW170817 offers more posterior support for softer EOS, and thus lower radii. For GW190425 only weak upper limits could be set on the tidal deformability, but the relatively high estimated mass of the primary object disfavors softer EOS, as we are not considering any high-mass information from radio pulsars here. #emph[Lower panels:] The change in the posterior distribution on the EOS when including information from the kilonova associated with GW170817, AT2017gfo #cite(<Kasliwal17>). The estimated mass that was ejected during the merger favors higher tidal deformabilities, and thus constrains the mass-radius space at low radii.
    ],
  placement: top,
  scope: "parent",
) <fig:fig2>

The upper panels of Figure~#ref(<fig:fig2>, supplement: none) show the posterior distributions on the EOS for both events in the mass-radius space. We note that the constraints on tidal deformability from GW170817 give more support to softer EOS, although the $95 %$ credible region spans a relatively large range of radii. GW190425 only led to weak upper limits on the tidal deformability due to its low SNR and single-detector detection. The EOS is however constrained as a result of the high mass of the primary component (with $95 %$ credible range $1.60 - 1.87$ M$""_⊙$), excluding EOS that do not support these masses.

// [figvision] imgs/EP_posteriors_J0740_complete.png
// a. The plot is a pressure-density diagram showing the equation of state (EOS) for a neutron star. The x-axis
// represents the logarithm of density, log10(ε) (g/cm³), ranging from 14.4 to 15.2. The y-axis represents the
// logarithm of pressure, log10(P) (dyn/cm²), ranging from 33.0 to 36.0. There are several series: a green shaded
// region indicating the credible region, a black dashed line for the prior, an orange dashed-dotted line for
// radio mass measurement constraints, and a red contour for the posterior distribution. The trend shows that
// pressure increases with density. b. Inset in panel a is a plot of the Kullback-Leibler divergence (D_KL) in
// bits versus an unspecified variable, presumably related to density, ranging from 14.5 to 15.0. The plot shows
// a red line representing D_KL, starting at 0 and increasing to approximately 2.5 bits. c. The plot is similar
// to panel a but for the CS model. The x-axis and y-axis have the same ranges and units as panel a. The series
// and their meanings are also similar, with slight differences in the posterior distribution contour and the
// prior and constraint lines. The trend is similar, with pressure increasing with density. d. Inset in panel c
// is another plot of D_KL in bits versus an unspecified variable, with a similar range as panel b. The red line
// representing D_KL starts at 0, increases to approximately 2.7 bits, and then decreases.
// [figvision] imgs/MR_posteriors_J0740_complete_v3.png
// a. This is a plot showing mass versus radius. The y-axis ranges from 1.0 to 3.0 solar masses and the x-axis
// from 10 to 15 kilometers. There are four series: a black dashed line for the prior, an orange dashed-dotted
// line for PSR-J0740+6620 radio, a blue dotted line for PSR-J0740+6620 NICER, and a green shaded area for
// PSR-J0740+6620 NICER x XMM. The trend shows that as radius increases, mass increases then levels off, with the
// green area providing the most constrained region. b. This is a plot showing mass versus radius. The y-axis
// ranges from 1.0 to 3.0 solar masses and the x-axis from 10 to 15 kilometers. There are four series: a black
// dashed line for the prior, an orange dashed-dotted line for PSR-J0740+6620 radio, a blue dotted line for
// PSR-J0740+6620 NICER, and a green shaded area for PSR-J0740+6620 NICER x XMM. The trend shows that as radius
// increases, mass increases then levels off, with the green area providing the most constrained region.
#figure(
    align(center, stack(dir: ttb, spacing: 0.6em,
      image("imgs/EP_posteriors_J0740_complete.png", width: 95%),
      image("imgs/MR_posteriors_J0740_complete_v3.png", width: 95%))),
    caption: [
    #emph[Upper panels:] The $68 %$ and $95 %$ credible regions of the EOS given the mass-radius estimate of PSR~J0740$+$6620 by #cite(<Riley21>, form: "prose"), using the PP model (left) and CS model (right). The black dashed lines and orange dashed-dotted lines indicate the $95 %$ credible region of the prior and the constraints given the radio mass measurement of PSR~J0740$+$6620 by #cite(<Fonseca21>, form: "prose"), respectively. The red contour shows the posterior distribution on central energy density and pressure for this source, and in the inset we plot the KL-divergence as a function of energy density. #emph[Lower panels:] Same as upper panels but for the mass-radius space. Also shown in blue, dotted lines is the $95 %$ credible region of the EOS posterior distribution, when analyzing the result from #cite(<Riley21>, form: "prose") without the inclusion of the #emph[XMM]-dataset (so #emph[NICER] only). In addition, we show the mass-radius posterior for PSR~J0740$+$6620 by #cite(<Riley21>, form: "prose") as dark-green contours (68% and 95%). Note that when considering both #emph[NICER] and #emph[XMM] data, the posterior distribution (green shaded) is very close to the constraints obtained from the radio mass measurement of PSR~J0740$+$6620 (orange), due to this mass-radius posterior (dark green) showing support over an extended range of radii.
    ],
  placement: top,
  scope: "parent",
) <fig:fig6>

// [figvision] imgs/MR_posteriors_J0740_J0030.png
// a. This is a plot showing constraints on the mass-radius space of neutron stars. The x-axis represents radius
// (R) in kilometers, ranging from 10 to 15 km, and the y-axis represents mass (M) in solar masses, ranging from
// 1.0 to 3.0 M. There are four series: prior (black dashed), +PSR-J0030+0451 (blue dotted), +PSR-J0740+6620,
// NICER x XMM (orange dash-dotted), and +PSR-J0030+0451 + PSR-J0740+6620 (green shaded). The trend shows that
// the posterior distribution narrows down the possible mass and radius range when more data is included. b. This
// is a similar plot to panel a but for the CS model. The axes have the same ranges and units as panel a. The
// same four series are shown with the same line styles and colors. The credible regions for the CS model appear
// slightly different from the PP model, with a more constrained mass range for the combined data. The message is
// similar, with the combined data providing a tighter constraint on the neutron star's mass and radius.
// [figvision] imgs/MR_posteriors_combined_EM_diffJ0470.png
// Panel a: This is a plot of mass versus radius for neutron stars. The y-axis ranges from 1.0 to 3.0 solar
// masses (M), and the x-axis ranges from 10 to 15 kilometers (km). There are four series: a black dashed line
// representing the prior, an orange dashed line for data including GW170817, AT2017gfo, GW190425, J0030, and
// J0740 with radio data, and two shaded regions (green and beige) for data including these plus NICER x XMM
// data. The trend shows that with more data, the credible regions narrow. Panel b: This plot is similar to panel
// a but for the CS model. The axes have the same ranges as panel a. The series and their meanings are the same
// as in panel a. The credible regions are also similar but shifted compared to the PP model. The message is that
// the CS model constrains the mass-radius space differently than the PP model.
#figure(
    align(center, stack(dir: ttb, spacing: 0.6em,
      image("imgs/MR_posteriors_J0740_J0030.png", width: 95%),
      image("imgs/MR_posteriors_combined_EM_diffJ0470.png", width: 95%))),
    caption: [
    #emph[Upper panels:] Constraints on the mass-radius space of neutron stars, given the posterior distribution of EOS parameters $bold(theta)$ using the PP model (left) and CS model (right). Shown are the $68 %$ and $95 %$ credible regions when analyzing PSR~J0030$+$0451, PSR~J0740$+$6620 and the combination of the two pulsars. Note that the distribution of PSR~J0030$+$0451 is different than in #cite(<Raaijmakers19>, form: "prose"), because here we have not included any high-mass pulsar information. #emph[Lower panels:] Similar to upper panels, but when analyzing jointly mass-radius estimates from PSR~J0740$+$6620 @Riley21, PSR~J0030$+$0451 @Riley19, mass-tidal deformability estimates from GW170817 @GW170817sourceproperties and GW190425 @GW190425 and the kilonova data of #cite(<Kasliwal17>, form: "prose") as described in @subsec:at2017gfo. Combined, we find the radius of a $1.4 thin$M$""_⊙$ neutron star to be constrained to the 95% credible ranges $12.33_(- 0.81)^(+ 0.76) thin$km (PP model) and $12.18_(- 0.79)^(+ 0.56) thin$km (CS model). To show the impact of the radius measurement of PSR~J0740$+$6620 we also plot the posterior distribution when analyzing combined constraints with only the $2.08$M$""_⊙$ mass measurement of PSR~J0740$+$6620 (orange dashed-dotted lines).
    ],
  placement: top,
  scope: "parent",
) <fig:fig6a>

=== AT2017gfo
<subsec:at2017gfo>
Following the detection of GW170817 an EM counterpart was observed across the frequency spectrum (see, e.g., #cite(<LVCmultimessenger>, form: "prose")@GW170817grb and references therein; #cite(<GW170817swope>, form: "prose")@Chornock17@Drout17@Hallinan17@Kasliwal17@Kasliwal19@Margutti17@Pian17@Smartt17@Troja17). Of particular interest here is the thermal infrared-optical-ultraviolet transient powered by radioactive decay of r-process nucleosynthesis in the neutron-rich material ejected during merger; the so-called kilonova or macronova @Li98@Kulkarni05#cite(<2010MNRAS.406.2650M>). The kilonova properties depend on the mass, velocity, and composition of the ejected material, which in turn depend on the binary progenitor parameters such as the tidal deformability of the neutron stars. Using this connection it is possible to constrain the EOS from the kilonova light curve @Coughlin:2018miv@Radice:2018ozg@Hinderer19@Capano:2019eae#cite(<Dietrich20>).

Here we analyze the bolometric luminosity of GW170817 @Kasliwal17 via the new Bayesian framework outlined in #cite(<Raaijmakers21>, form: "prose"). We consider a two-component kilonova model, where the first component, the dynamical ejecta, is associated with material ejected through tidal forces and the shock interface between the two neutron stars #cite(<Radice18a>, supplement: [and references therein]). The second component is associated with neutrino-driven winds or material ejected through viscous forces. We connect the outflow properties of these components to the binary progenitor properties by using the formulae presented in #cite(<Kruger20>, form: "prose") for dynamical ejecta and disk mass, which are fitted to numerical simulations of compact mergers. The velocity of the dynamical ejecta is calculated using the formula in #cite(<Coughlin19a>, form: "prose"), while the velocity of the disk wind ejecta is left as a free parameter. The dynamical ejecta includes both material ejected through tidal forces and material ejected through shocks on the contact interface between the stars @Sekiguchi16@Dietrich17@Tanaka20#cite(<Nedora21>). To distinguish these we consider two different opacities in the dynamical ejecta, corresponding to tidal tail and shock ejecta , where the latter is less neutron-rich compared to the tidal tail and thus has a lower opacity (see @tab:tab1). For simplicity we take a single opacity for the disk wind ejecta. The outflow properties are then connected to a bolometric luminosity through the semi-analytic light curve model by #cite(<Hotokezaka19>, form: "prose"). The priors on all parameters are shown in @tab:tab1

The fit to the bolometric luminosity of AT2017gfo using the data compiled in #cite(<Kasliwal17>, form: "prose") is shown in Figure~#ref(<fig:figEM>, supplement: none), showing all datapoints to be contained within the $95 %$ credible region of the posterior distribution. In the lower panels of Figure~#ref(<fig:fig2>, supplement: none) we show the updated prior distribution for the EOS with GW170817 and with the inclusion of AT2017gfo. The EM data gives more posterior support to stiffer over softer EOS, due to the estimated ejected mass requiring a neutron star with larger tidal deformability. The estimated radius of a $1.4$ M$""_⊙$ neutron star for the PP and CS model is $12.12_(- 1.44)^(+ 1.10) thin$km and $11.53_(- 1.15)^(+ 1.16) thin$km, respectively, which is broadly consistent with multimessenger constraints obtained by other works @Coughlin19a@Dietrich20@Capano:2019eae@Breschi21b#cite(<Nicholl21>). Important to note is that the EM modeling of the kilonova here is simplified and relies on a few assumptions that are known to affect results, such as spherical ejecta geometry @Heinzel21@Korobkin21, fixed nuclear heating rate @Barnes20, and an incomplete mapping between properties of the binary system and the ejecta outflows. It is also dependent on the choice of light curve modeling, where the distinction can be made between semi-analytic modeling @Breschi21b@Nicholl21 and interpolating between radiative transfer simulations @Coughlin:2018miv#cite(<Dietrich20>). We use a semi-analytical model from #cite(<Hotokezaka19>, form: "prose"), which for the current statistical uncertainty in gravitational wave parameter estimation and uncertainty in light curve observations produces consistent results to full radiative transport models @Coughlin_2019@Coughlin_2020, although this will change in the future with improved gravitational wave detectors and optical telescopes.

#block[
#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,left,left,),
    table.hline(stroke: 0.8pt),
    table.header([Parameters], [Prior density and support], [],),
    table.hline(),
    table.cell(align: center, colspan: 2)[#emph[Binary properties]], [],
    [$cal(M)_c$ [M$""_⊙$]], [$tilde.op$ U(1.18, 1.2)], [],
    [q], [$tilde.op$ U(0.2, 1)], [],
    [$Lambda_1$], [$tilde.op$ U(0, 2500)], [],
    [$Lambda_2$], [$tilde.op$ U(0, 2500)], [],
    table.cell(align: center, colspan: 2)[#emph[Ejecta and light curve properties]], [],
    [M$""_(upright("dyn"))$ [M$""_⊙$]], [Eq. (2) ], [],
    [v$""_(upright("dyn"))$ [c]], [Eq. (D5) ], [],
    [$v_(m i n , d y n)$ [c]], [$tilde.op$ U(0.1, 1.0) v$""_(upright("dyn"))$], [],
    [$v_(m a x , d y n)$ [c]], [$tilde.op$ U(1.5, 2.5) v$""_(upright("dyn"))$], [],
    [v$""_kappa$ [c]], [$tilde.op$ U(v$""_(m i n , d y n)$, v$""_(m a x , d y n)$)], [],
    [$kappa_(upright("low"))$ [cm$""^2$ g$""^(- 1)$]], [$tilde.op$ U(0.1, 5)], [],
    [$kappa_(upright("high"))$ [cm$""^2$ g$""^(- 1)$]], [$tilde.op$ U(5, 30)], [],
    [M$""_(upright("wind"))$ [M$""_⊙$]], [Eq. (10) ], [],
    [v$""_(upright("wind"))$ [c]], [$tilde.op$ U(0.03, 0.15)], [],
    [$v_(m i n , w i n d)$ [c]], [$tilde.op$ U(0.1, 1.0) v$""_(upright("wind"))$], [],
    [$v_(m a x , w i n d)$ [c]], [$tilde.op$ U(1.5, 2.0) v$""_(upright("wind"))$], [],
    [$kappa_(upright("wind"))$ [cm$""^2$ g$""^(- 1)$]], [$tilde.op$ U(0.1, 5)], [],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [The parameters used in the model described in @subsec:at2017gfo and their prior support in the analysis of AT2017gfo. The notation $U ( a , b )$ here means uniformly drawn between boundaries $a$ and $b$.]
  , kind: table
  ) <tab:tab1>
]

== #emph[NICER] mass-radius and multimessenger constraints
<nicer-mass-radius-and-multimessenger-constraints>
Next we study the constraints on the EOS from the new mass-radius estimate of PSR~J0740$+$6620 using data from #emph[NICER] and #emph[XMM], presented in #cite(<Riley21>, form: "prose"). They find a radius of $12.39_(- 0.98)^(+ 1.30)$ km, and a mass of $2.072_(- 0.066)^(+ 0.067)$ M$""_⊙$, where the upper and lower limit bound the $68 %$ credible regions. The EOS results are shown in Figure~#ref(<fig:fig6>, supplement: none), both in energy density-pressure and mass-radius space. From the Kullback-Leibler (KL)-divergence @kullback1951 plotted as a function of energy density in the upper insets, we find that especially at higher energy densities there is a significant information gain from prior-to-posterior. Note that similar but, especially for the CS model, broader constraints are found for the posterior distribution when only using the radio mass measurement of PSR~J0740$+$6620, as indicated by the orange dashed-dotted lines. This is a result of the mass-radius estimate of PSR~J0740$+$6620 being very consistent with our prior ranges informed by low-density chiral EFT calculations. The chiral EFT calculations do exclude however stiffer EOS with radii $> 14$ km, where the mass-radius posterior of PSR~J0740$+$6620 has non-negligible posterior support. For the CS model this effect is stronger as additional constraints on the speed of sound at $1.5 n_0$ in the CS model lead to overall smaller radii than in the PP model (see Section 2.3 of #cite(<Raaijmakers20>, form: "prose")).

In the mass-radius space we also plot the EOS constraints given the joint #emph[NICER] mass-radius estimate excluding the #emph[XMM] data. For this analysis #cite(<Riley21>, form: "prose") report a value of $11.29_(- 0.81)^(+ 1.20)$ km for the radius, and $2.078_(- 0.063)^(+ 0.066)$ M$""_⊙$ for the mass. As this joint mass-radius estimate has slightly more posterior support for lower radii, the corresponding EOS constraints suggest a softening of the EOS at high densities. These results should be interpreted with caution however, because the #emph[NICER]-only analysis leads to an under-prediction of the background (the contribution from instrumental or astrophysical background to the unpulsed component of the pulse profile). This results in more of the unpulsed component being attributed to the hot regions via high compactness solutions. The #emph[XMM] data show that a larger component of the unpulsed emission must come from true background, eliminating these high compactness solutions and increasing the inferred radius in the joint #emph[NICER]-#emph[XMM] analysis (see also Section 4.2 in #cite(<Riley21>, form: "prose")).

Finally, in Figure~#ref(<fig:fig6a>, supplement: none) we show the constraints on the EOS from PSR~J0740$+$6620, PSR~J0030$+$0451 (first derived in #cite(<Raaijmakers19>, form: "prose"), but here no information on high-mass pulsars is included) and the combination of the two pulsars. Note that for the combined constraints, most of the information comes from PSR~J0740$+$6620, since the $68 %$ credible region of the mass-radius posterior of PSR~J0030$+$0451 covers a broad range in radii that are consistent with the EOS constraints from PSR~J0740$+$6620.

In the lower panels of Figure~#ref(<fig:fig6a>, supplement: none) we show the combined constraints on the EOS including mass-radius estimates from PSR~J0740$+$6620 @Riley21, PSR~J0030$+$0451 @Riley19 and mass-tidal deformability estimates from GW170817 @GW170817sourceproperties and GW190425 @GW190425 and the kilonova AT2017gfo #cite(<Kasliwal17>). We find that especially the pulsar mass-radius estimates by #emph[NICER] favor stiffer EOS, as well as GW170817 when the associated kilonova AT2017gfo @Kasliwal17 is included. The weak constraints from GW190425 on the tidal deformability are also broadly consistent with the constraints coming from the other sources. As a comparison we show the posterior distribution when combining all analyses excluding the mass-radius estimate of PSR~J0740$+$6620, but with the radio mass measurement of #cite(<Fonseca21>, form: "prose"). We note that the additional radius information on PSR~J0740$+$6620 constrains the softer EOS, especially for the CS model.

// [figvision] imgs/cEFT_fit_all.png
// The figure is a plot showing the pressure of neutron star matter versus density. The x-axis represents the
// density in units of saturation density n_0, ranging from 0.5 to 1.1. The y-axis represents the pressure P in
// units of {MeV}/{fm}^3, on a log base 10 scale, ranging from 10^0 to 10^1. There are four series, each with a
// different color: red for Hebeler et al. (2013), yellow for Tews et al. (2013), green for Lynn et al. (2016),
// and gray for Drischler et al. (2019). Each series has a solid line and a shaded region representing the
// uncertainty. The trend shows an increase in pressure with density for all series. Vertical dashed lines are at
// n/n_0 = 0.5 and 1.1.
#figure(image("imgs/cEFT_fit_all.png", width: 100%),
  caption: [
    Different chiral EFT bands for the pressure of neutron star matter at nuclear densities, $n / n_0$ in units of saturation density $n_0 = 0.16$ fm$""^(- 3)$, and their matching to the BPS crust EOS at $0.5 n_0$. The different bands are based on microscopic calculations of neutron matter from #cite(<Hebeler13>, form: "prose"), #cite(<Tews13>, form: "prose"), #cite(<Lynn16>, form: "prose") and #cite(<Drischler19>, form: "prose") and include beta equilibrium (with protons and electrons) following the construction in #cite(<Hebeler13>, form: "prose"). The four chiral EFT calculations are considered between $0.5 n_0$ and $1.1 n_0$ in the analyses presented in @sec:ceft. Also shown are examples of the fit we use to approximate the EOS within these uncertainty bands, see Eq.~(#ref(<eq:ceft>, supplement: none)), and connect to the BPS crust EOS. For a comparison of the chiral EFT bands in pure neutron matter, see Figure~1 in #cite(<Huth21>, form: "prose").
  ],
  placement: top,
  scope: "parent",
)
<fig:fig5>

// [figvision] imgs/EP_posterior_setvalues_v2.png
// The figure has two panels, a and b. Panel a: The plot is a probability density function (PDF) of _{10}(P)
// (dyn/cm^2). The y-axis ranges from 0.0 to 7.0 and the x-axis from 33.6 to 34.6. There are multiple series,
// each with a different color (red, orange, green, blue, yellow, grey), representing different chiral EFT
// calculations. The red dashed line corresponds to the credible region if the PP parameterization is used. A
// grey dashed line and a grey dotted line represent priors. The trend shows that the PDF peaks around 34.2 for n
// = 1.5n_0 with the PP model. Panel b: The plot is also a PDF of _{10}(P) (dyn/cm^2). The y-axis ranges from 0.0
// to 7.0 and the x-axis from 33.50 to 35.00. Similar to panel a, there are multiple series with different
// colors. The red dashed line represents the credible region if the PP parameterization is used. The trend shows
// that the PDF peaks around 34.5 for n = 2n_0 with the PP model. Comparing panels a and b, the peak shifts to a
// higher value of _{10}(P) as n increases from 1.5n_0 to 2n_0.
// [figvision] imgs/MR_posteriors_ceft_bands_CS.png
// Panel a: The plot shows the credible region for the mass-radius space given the mass-radius estimate of PSR
// J0740+6620 using the PP model. The y-axis represents mass in solar masses (M), ranging from 1.0 to 3.0 M, and
// the x-axis represents radius in kilometers (km), ranging from 10 to 16 km. The series are: Hebeler et al.
// (2013) in red, Tews et al. (2013) in yellow, Lynn et al. (2016) in green, Drischler et al. (2019) in dark
// gray, and without chiral EFT in red dashed line. The credible regions are shown as shaded areas. The trend
// shows that the credible regions for different calculations are similar but with some variations. Panel b: The
// plot shows the credible region for the mass-radius space given the mass-radius estimate of PSR J0740+6620
// using the CS model. The axes and series are the same as in panel a. The credible regions for different
// calculations are similar but with some variations, and the red dashed line shows the credible region without
// chiral EFT. The trend shows that the credible regions for CS model are slightly different from those for the
// PP model. No panel c is present in the figure.
#figure(
    align(center, stack(dir: ttb, spacing: 0.6em,
      image("imgs/MR_posteriors_ceft_bands_CS.png", width: 95%),
      image("imgs/EP_posterior_setvalues_v2.png", width: 95%))),
    caption: [
    #emph[Upper panels:] $95 %$ credible region for the mass-radius space given the mass-radius estimate of PSR~J0740$+$6620 by #cite(<Riley21>, form: "prose"), using the PP model (left) and CS model (right). The different results correspond to using the four different chiral EFT calculations between $0.5$ and $1.1 n_0$ as shown in Fig.~#ref(<fig:fig5>, supplement: none). Moroever, the red, dashed lines correspond to the $95 %$ credible region, if the PP or CS parameterization is used down to $0.5 n_0$, i.e., immediately following the BPS crust, so that no information from chiral EFT is used. #emph[Lower panels:] Marginalized posterior distributions for the pressure $P$ above saturation density, at density $n = 1.5 n_0$ (left) and $n = 2 n_0$ (right) above the chiral EFT bands.
    ],
  placement: top,
  scope: "parent",
) <fig:fig4>

= Sensitivity of posteriors to nuclear constraints at low densities
<sec:ceft>
To investigate the impact of the EOS constraints from nuclear physics we compare our analysis of PSR~J0740$+$6620 using four different chiral EFT uncertainty bands. All bands are based on microscopic calculations for pure neutron matter, which are then extended to neutron star matter in beta-equilibrium using the formalism discussed in #cite(<Hebeler13>, form: "prose"). In order to improve the description of all employed EOSs, we generalized the density dependence of the energy-density functional [see Eq.~(2) in #cite(<Hebeler13>, form: "prose")] by enlarging the range of the exponent $gamma$ to $gamma in [1.2 , 2.5]$.

The results from #cite(<Hebeler13>, form: "prose") formed the basis of our previous studies @Raaijmakers19#cite(<Raaijmakers20>). The calculations for pure neutron matter were initially performed in #cite(<Hebeler10a>, form: "prose") using many-body perturbation theory, while the uncertainty band results mainly from variations of the couplings involved in three-nucleon interactions. Second, in #cite(<Tews13>, form: "prose") the calculations for neutron matter were improved by including for the first time all three-, and four-neutron interactions to next-to-next-to-next-to-leading order (N$""^3$LO), which are predicted in a parameter-free way for neutron matter (see, e.g., #cite(<Hebe15ARNPS>, form: "prose")@Hebeler:2020ocj for reviews). Third, in #cite(<Drischler19>, form: "prose") the calculations were further optimized by improving the treatment of three-nucleon interactions and extending the many-body expansion to higher orders. In addition, the EOS uncertainty bands also include effects from variations of regulator scales in state-of-the-art nucleon-nucleon and three-nucleon interactions. In this work, we use the combined 450 MeV and 500 MeV N$""^3$LO uncertainty bands from #cite(<Drischler19>, form: "prose"). Finally, we include results of #cite(<Lynn16>, form: "prose"). These were obtained by nonperturbative quantum Monte-Carlo simulations of neutron matter at next-to-next-to-leading order (N$""^2$LO). This represents a completely different many-body method than those used for the other three bands, and the results of #cite(<Lynn16>, form: "prose") are also based on a different set of local two- and three-nucleon interactions derived from chiral EFT.

#figure(
  align(center)[#text(size: 6pt, table(
    columns: (auto,) * 10,
    align: (center,center,center,center,center,center,center,center,center,center,),
    [], table.cell(align: center, colspan: 4)[PSR~J0740$+$6620, #emph[NICER] x XMM], [PSR J0030], [GW170817], [GW170817], [Combined], [Combined],
    [], [Heb 13], [Tews 13], [Lynn 16], [Dri 19], [+0451], [+ GW190425], [+ AT2017gfo], [without], [with],
    table.cell(align: center, colspan: 9)[#emph[PP model]], [],
    [$R_1.4$], [$12.56_(- 0.91)^(+ 0.80)$], [$12.85_(- 0.95)^(+ 0.77)$], [$12.35_(- 0.98)^(+ 0.96)$], [$12.87_(- 0.98)^(+ 0.85)$], [$12.35_(- 1.99)^(+ 0.99)$], [$11.51_(- 1.47)^(+ 1.51)$], [$12.12_(- 1.44)^(+ 1.10)$], [$12.30_(- 0.76)^(+ 0.72)$], [$12.33_(- 0.81)^(+ 0.76)$],
    [R$""_1.6$], [$12.60_(- 1.00)^(+ 0.87)$], [$12.87_(- 1.05)^(+ 0.87)$], [$12.40_(- 1.04)^(+ 1.03)$], [$12.90_(- 1.08)^(+ 0.94)$], [$12.50_(- 2.08)^(+ 0.96)$], [$11.43_(- 1.53)^(+ 1.68)$], [$12.10_(- 1.69)^(+ 1.23)$], [$12.32_(- 0.99)^(+ 0.92)$], [$12.35_(- 0.90)^(+ 0.83)$],
    [R$""_1.8$], [$12.62_(- 1.19)^(+ 0.98)$], [$12.86_(- 1.26)^(+ 1.00)$], [$12.42_(- 1.19)^(+ 1.13)$], [$12.89_(- 1.29)^(+ 1.08)$], [$12.68_(- 1.99)^(+ 0.94)$], [$11.65_(- 1.80)^(+ 1.64)$], [$12.22_(- 1.91)^(+ 1.26)$], [$12.29_(- 1.19)^(+ 1.06)$], [$12.33_(- 1.06)^(+ 0.97)$],
    [$Delta R$], [$- 0.24_(- 1.04)^(+ 0.65)$], [$- 0.17_(- 1.21)^(+ 1.26)$], [$- 0.22_(- 1.05)^(+ 0.60)$], [$- 0.45_(- 1.07)^(+ 1.14)$], [$- 0.13_(- 1.02)^(+ 0.76)$], [$- 0.35_(- 1.09)^(+ 0.80)$], [$- 0.26_(- 1.14)^(+ 0.77)$], [$- 0.30_(- 1.06)^(+ 0.64)$], [$- 0.29_(- 0.98)^(+ 0.61)$],
    [M$""_("TOV")$], [$2.26_(- 0.23)^(+ 0.15)$], [$2.33_(- 0.30)^(+ 0.14)$], [$2.22_(- 0.21)^(+ 0.19)$], [$2.33_(- 0.31)^(+ 0.18)$], [$1.74_(- 0.57)^(+ 0.66)$], [$1.84_(- 0.17)^(+ 0.51)$], [$1.96_(- 0.44)^(+ 0.42)$], [$2.23_(- 0.23)^(+ 0.15)$], [$2.23_(- 0.23)^(+ 0.14)$],
    [$log_10 ( epsilon_c )$], [$14.99_(- 0.16)^(+ 0.27)$], [$14.99_(- 0.18)^(+ 0.28)$], [$15.00_(- 0.16)^(+ 0.26)$], [$14.99_(- 0.19)^(+ 0.28)$], [$14.86_(- 0.13)^(+ 0.28)$], [-], [-], [-], [],
    [$log_10$(P$""_c )$], [$35.39_(- 0.24)^(+ 0.39)$], [$35.37_(- 0.26)^(+ 0.41)$], [$35.41_(- 0.25)^(+ 0.37)$], [$35.37_(- 0.28)^(+ 0.43)$], [$34.92_(- 0.21)^(+ 0.30)$], [-], [-], [-], [],
    [K], [1.00], [0.89], [1.00], [0.85], [-], [-], [-], [-], [],
    table.cell(align: center, colspan: 9)[#emph[CS model]], [],
    [R$""_1.4$], [$12.27_(- 0.90)^(+ 0.54)$], [$12.49_(- 0.87)^(+ 0.49)$], [$12.16_(- 0.97)^(+ 0.63)$], [$12.56_(- 0.92)^(+ 0.51)$], [$11.51_(- 1.90)^(+ 1.12)$], [$11.18_(- 1.51)^(+ 1.33)$], [$11.53_(- 1.15)^(+ 1.16)$], [$11.98_(- 0.71)^(+ 0.63)$], [$12.18_(- 0.79)^(+ 0.56)$],
    [R$""_1.6$], [$12.25_(- 0.94)^(+ 0.59)$], [$12.43_(- 0.92)^(+ 0.55)$], [$12.16_(- 0.99)^(+ 0.66)$], [$12.50_(- 0.96)^(+ 0.55)$], [$11.48_(- 1.92)^(+ 1.20)$], [$10.92_(- 1.56)^(+ 1.58)$], [$11.33_(- 1.41)^(+ 1.38)$], [$11.91_(- 0.94)^(+ 0.78)$], [$12.14_(- 0.84)^(+ 0.61)$],
    [R$""_1.8$], [$12.14_(- 1.05)^(+ 0.69)$], [$12.27_(- 1.04)^(+ 0.66)$], [$12.08_(- 1.07)^(+ 0.74)$], [$12.33_(- 1.06)^(+ 0.65)$], [$11.52_(- 1.77)^(+ 1.23)$], [$10.85_(- 1.47)^(+ 1.73)$], [$11.34_(- 1.65)^(+ 1.44)$], [$11.72_(- 1.06)^(+ 0.96)$], [$12.00_(- 0.96)^(+ 0.74)$],
    [$Delta R$], [$- 0.69_(- 1.02)^(+ 1.10)$], [$- 0.72_(- 1.08)^(+ 1.12)$], [$- 0.58_(- 1.08)^(+ 1.03)$], [$- 1.06_(- 0.83)^(+ 1.46)$], [$- 0.93_(- 0.86)^(+ 1.31)$], [$- 0.93_(- 0.83)^(+ 1.36)$], [$- 0.81_(- 0.92)^(+ 1.22)$], [$- 0.91_(- 0.85)^(+ 1.15)$], [$- 0.74_(- 0.95)^(+ 1.09)$],
    [M$""_("TOV")$], [$2.13_(- 0.16)^(+ 0.33)$], [$2.13_(- 0.18)^(+ 0.29)$], [$2.14_(- 0.17)^(+ 0.34)$], [$2.12_(- 0.16)^(+ 0.31)$], [$1.46_(- 0.42)^(+ 0.82)$], [$1.81_(- 0.15)^(+ 0.45)$], [$1.85_(- 0.30)^(+ 0.56)$], [$2.09_(- 0.15)^(+ 0.26)$], [$2.11_(- 0.16)^(+ 0.29)$],
    [$log_10 ( epsilon_c )$], [$15.19_(- 0.20)^(+ 0.21)$], [$15.19_(- 0.20)^(+ 0.20)$], [$15.18_(- 0.21)^(+ 0.21)$], [$15.20_(- 0.20)^(+ 0.19)$], [$15.03_(- 0.21)^(+ 0.33)$], [-], [-], [-], [],
    [$log_10$(P$""_c )$], [$35.61_(- 0.27)^(+ 0.30)$], [$35.62_(- 0.28)^(+ 0.30)$], [$35.60_(- 0.28)^(+ 0.30)$], [$35.63_(- 0.29)^(+ 0.30)$], [$35.05_(- 0.24)^(+ 0.30)$], [-], [-], [-], [],
    [K], [1.00], [1.04], [0.92], [1.05], [-], [-], [-], [-], [],
  ))]
  , caption: [Key quantities from the posterior distributions obtained in Sections #ref(<sec:eos>, supplement: none) and #ref(<sec:ceft>, supplement: none): The radius of a $1.4$ M$""_⊙$, $1.6$ M$""_⊙$, and $1.8$ M$""_⊙$ neutron star, as well as $Delta R = R_2 - R_1.4$, and the maximum mass of a non-rotating neutron star M$""_("TOV")$. For the analyses of @sec:ceft, we also show the inferred central energy density $epsilon_c$, the corresponding central pressure P$""_c$, and the Bayes' factor $K$ comparing with the model using the chiral EFT band from #cite(<Hebeler13>, form: "prose"). The first four column results are for the different chiral EFT bands from #cite(<Hebeler13>, form: "prose") (Heb 13), #cite(<Tews13>, form: "prose") (Tews 13), #cite(<Lynn16>, form: "prose") (Lynn 16), and #cite(<Drischler19>, form: "prose") (Dri 19), while all other results are for the baseline inference using Heb 13. The column "Combined with" refers to the #emph[NICER] $times$ #emph[XMM] analysis of PSR~J0740$+$6620, the #emph[NICER] analysis of PSR~J0030$+$0451 and multimessenger constraints combined, while in the column "Combined without" the #emph[NICER] $times$ #emph[XMM] analysis of PSR~J0740$+$6620 is replaced with just the radio mass measurement by #cite(<Fonseca21>, form: "prose"). The radii are given in km, M$""_("TOV")$ in M$""_⊙$, and $epsilon_c$ and $P_c$ in $"g/cm"^3$ and $"dyn/cm"^2$, respectively. The upper and lower values correspond to the $95%$ credible interval.]
  , kind: table,
  scope: "parent",
  placement: top,
  )
 <tab:tab2>
Similar to #cite(<Raaijmakers20>, form: "prose") we approximate the EOS within these bands with a single polytrope $P = N n^Gamma$. However, to obtain a better fit to the additional bands considered here, we vary the polytropic index $Gamma$ as a function of the normalization $N$, $ Gamma ( N ) = frac(( N - N_(upright("min")) ), ( N_(upright("max")) - N_(upright("min")) )) ( Gamma_(upright("max")) - Gamma_(upright("min")) ) + Gamma_(upright("min")) thin , $<eq:ceft> where $N_(upright("min") / upright("max"))$ and $Gamma_(upright("min") / upright("max"))$ are determined by fitting a polytrope to the lower and upper bound of the band. In Figure~#ref(<fig:fig5>, supplement: none) we show the four different bands for the pressure of neutron star matter with an example of the fit through each band. This shows the consistency of these different chiral EFT calculations, with different methods, interactions, and approximations. The first point of the band where $n / n_0 > 0.5$ is matched to the BPS crust EOS at $0.5 n_0$ via a linear interpolation.

We study the dependence of the EOS constraints on the different chiral EFT bands by inferring the EOS from the mass-radius estimate of PSR~J0740$+$6620 using each band and both high-density parameterizations. The results are shown in Figure~#ref(<fig:fig4>, supplement: none). We also show the $95 %$ credible region of the updated prior distribution when directly joining the PP or CS high-density parameterization to the crust EOS at $0.5 rho_(n s)$. As expected the chiral EFT calculations mostly exclude stiffer EOS. While the different chiral EFT bands yield very good agreement on the upper bound of the radius estimates, the lower bound on the radius does slightly depend on the chiral EFT band used, especially at lower neutron star masses, depending on how soft the chiral EFT band is (see Figure~#ref(<fig:fig5>, supplement: none)).

In the lower panels of Figure~#ref(<fig:fig4>, supplement: none) we also show the posterior distributions on the pressure at densities $n = 1.5 n_0$ and $n = 2 n_0$ above the chiral EFT bands. These results demonstrate that the PSR~J0740$+$6620 mass-radius measurement systematically prefers higher pressures at these densities compared to the corresponding prior distributions of each chiral EFT band. Furthermore, the posteriors at $n = 2 n_0$ agree very well for all chiral EFT bands and are peaked around $P tilde.op 10^34.5 "dyn" / "cm"^2 tilde.op 20 thin "MeV" / "fm"^3$.

= Discussion
<discussion>
In this Letter, we have investigated the constraints on the EOS posed by the new joint mass-radius estimate from #emph[NICER] $times$ #emph[XMM] data @Riley21, and compared and combined with multimessenger EOS constraints from radio timing, gravitational wave mergers and their counterparts, and the previous PSR~J0030$+$0451 mass-radius estimate by #emph[NICER]. In @tab:tab2 we summarize the results obtained in Sections #ref(<sec:eos>, supplement: none) and #ref(<sec:ceft>, supplement: none) for the constraints on the radius of a $1.4 , 1.6$ and $1.8$ M$""_⊙$ neutron star, as well as $Delta R = R_2 - R_1.4$, and the maximum mass of a non-rotating neutron star M$""_("TOV")$, as well as the constraints on the central energy density and pressure for PSR~J0740$+$6620.

== Implications for nuclear physics
<implications-for-nuclear-physics>
We have studied the sensitivity of the EOS constraints from PSR~J0740$+$6620 using four different low-density EOS calculations from chiral EFT (see @sec:ceft). From the results presented in Figure~#ref(<fig:fig4>, supplement: none) and #ref(<tab:tab2>, supplement: none) we conclude that the constraints on the EOS are only weakly dependent on the choice of low-density calculations, although small differences exist at lower radii. Assuming all four low-density calculations to be equally probable, we can compute the Bayes' factor $K$ by taking the ratio of the evidence of each #smallcaps[MultiNest] run, and assess whether one model is preferred over another by the data of PSR~J0740$+$6620. We list the Bayes' factors in @tab:tab2, where each model is compared to using the chiral EFT band from #cite(<Hebeler13>, form: "prose"). All values are close to one, indicating that there is no substantial support for one model over the other, based on the mass-radius estimate of PSR~J0740$+$6620. These results are consistent with the observation that predictions for pure neutron matter are well constrained by modern nuclear forces derived within chiral EFT @Huth21#cite(<Hebeler:2020ocj>).

Also shown in @tab:tab2 are the values of $Delta R = R_2 - R_1.4$, the difference in radius of a $2$ M$""_⊙$ and $1.4$ M$""_⊙$ neutron star. As pointed out by #cite(<Drischler20a>, form: "prose"), the value of $Delta R$, if positive, can give an indication that possibly unusual stiffening happens at high densities. We find however all values to be consistent with the mean $Delta R$ being negative, but due to the broad uncertainty no conclusive statements can be made.

== Implications for maximum mass
<implications-for-maximum-mass>
An important quantity relating to the EOS is the maximum stable mass of a non-rotating neutron star, M$""_("TOV")$. Accurate knowledge of M$""_("TOV")$ can aid in classifying compact mergers and merger remnants. In Figure~#ref(<fig:fig8>, supplement: none) we show posterior distributions on M$""_("TOV")$ when analyzing the updated radio mass measurement of PSR~J0740$+$6620, the joint mass-radius estimate of PSR~J0740$+$6620 and combining GW170817, GW190425, AT2017gfo, PSR~J0740$+$6620 and PSR~J0030$+$0451. The latter results in 95% credible ranges for M$""_("TOV") = 2.23_(- 0.25)^(+ 0.15)$ M$""_⊙$ and M$""_("TOV") = 2.11_(- 0.16)^(+ 0.28)$ M$""_⊙$ for the PP and CS model, respectively. This is in agreement with values previous found #cite(<Nathanail21>, supplement: [and references therein]) when assuming the secondary component in GW190814 was a black hole #cite(<Abbott20_GW190814>). Note that the higher end of the distribution in Figure~#ref(<fig:fig8>, supplement: none) is very dependent on our choice of parameterization, as no information is included from sources with masses above $2.08$ M$""_⊙$. One could use information on the merger remnant of GW170817 to put an upper bound on M$""_("TOV")$ @Margalit17@Shibata17@Ruiz18, but that is beyond the scope of this Letter. The lower end of the distribution on the other hand is strongly correlated with the radio mass measurement of PSR~J0740$+$6620. The recently lowered mass distribution presented in #cite(<Fonseca21>, form: "prose") results in slightly lower values for M$""_("TOV")$ compared to the distributions found in #cite(<Raaijmakers20>, form: "prose").

// [figvision] imgs/maximum_mass_J0740_overlaid.png
// The figure has two panels, labeled PP model and CS model. a. The plot is a probability density function (PDF)
// of the maximum mass of a non-rotating neutron star. The y-axis ranges from 0 to 7 and represents the PDF, with
// no units specified. The x-axis ranges from 1.4 to 2.5 and represents the maximum mass in solar masses (M).
// There are five series: a black dashed line for the prior, an orange line for PSR J0740+6620 radio, a blue line
// for NICER x XMM, a green line for Combined, and a purple filled curve for Fonseca et al. (2021). The trend
// shows that the PDF increases and then decreases as the mass increases, with the Combined and Fonseca et al.
// (2021) series having the highest peak. b. The plot is similar to panel a but for the CS model. The axes and
// series have the same meaning as in panel a. The trend is similar, but the peak of the PDF is lower and shifted
// to a slightly lower mass compared to the PP model. The Combined and Fonseca et al. (2021) series have a
// similar peak, and the other series have lower peaks.
#figure(
    align(center, image("imgs/maximum_mass_J0740_overlaid.png", width: 95%)),
    caption: [
    Posterior distribution of the maximum mass of a non-rotating neutron star M$""_("TOV")$ for the PP model (left) and CS model (right) when considering only the radio mass measurement of PSR~J0740$+$6620, the joint mass-radius estimate of PSR~J0740$+$6620 (#emph[NICER] $times$ #emph[XMM]), and when combining #emph[NICER]'s results on PSR~J0740$+$6620 and PSR~J0030$+$0451 with GW170817 and GW190425, and AT2017gfo. For the latter ("Combined") we find a 95% credible range for M$""_("TOV") = 2.23_(- 0.23)^(+ 0.14) thin M_⊙$ and M$""_("TOV") = 2.11_(- 0.16)^(+ 0.29) thin M_⊙$ for the PP and CS model, respectively. Also shown in pink is the radio mass measurement of PSR~J0740$+$6620 from #cite(<Fonseca21>, form: "prose"), as the heaviest pulsar measured to date.
    ],
  placement: top,
  scope: "parent",
) <fig:fig8>

== Systematic uncertainties and framework comparisons
<systematic-uncertainties-and-framework-comparisons>
The analysis presented in this Letter is conditional on both the modeling choices of the dense matter EOS and on modeling choices within each analysis of the multimessenger sources considered here. The sensitivity to the EOS modeling is explored here by employing two different high-density parameterizations and four different low-density chiral EFT calculations (see @sec:ceft). From @tab:tab2 we conclude that the CS model systematically predicts lower radii, as a result of the additional constraints on the speed of sound that are not considered in the PP model. The discrepancy between the two models increases with increasing neutron star mass, as high-mass stars depend more sensitively on the choice of high-density parameterization. The two models considered here are however not exhaustive as many more high-density parameterizations exist @Lindblom18@Capano:2019eae#cite(<Boyle20>).

Furthermore, we do not consider the impact of any systematic effects present in estimating the posterior distributions on $M$, $R$ and $Lambda$. For example, the uncertainty in modeling the hot regions in pulse profile modeling and the effect on the EOS has been studied in #cite(<Raaijmakers20>, form: "prose") by using two different models to fit PSR~J0030$+$0451, which led to slightly different constraints. For PSR~J0740$+$6620, different assumptions and priors lead to a higher estimated radius in the independent analysis of @Miller21 (see the extensive discussion of this issue in Section 4.4 of #cite(<Riley21>, form: "prose")), and we refer the reader to that paper for an EOS analysis using those results. #footnote[Note however that one of the main reasons for the higher inferred radius reported by #cite(<Miller21>, form: "prose") is that they do not truncate the prior on radius during the pulse profile modelling step, which #cite(<Riley21>, form: "prose") do (truncating above 16 km, reflecting the lack of EOS models predicting higher radii, and thereby lowering the computational cost by reducing the parameter space). In the analysis by #cite(<Miller21>, form: "prose") the lack of prior support for high radii is effectively incorporated at a later stage, in the EOS analysis.].

Measurements in $Lambda$ from gravitational wave data are also sensitive to choice of priors and gravitational waveform models @Kastaun:2019bxo#cite(<Gamba20>). Lastly, many different kilonova models exist @Dietrich20@Nicholl21#cite(<Breschi21b>, supplement: [for recent analyses]) that derive slightly different constraints on the EOS due to differences in modeling assumptions on, e.g., geometry, composition and the connection between binary properties and outflow properties.

The inference framework employed in this Letter was first discussed in #cite(<Riley18>, form: "prose") and subsequently developed in #cite(<Greif19>, form: "prose")@Raaijmakers19@Raaijmakers20, which also introduced the chiral EFT constraints. Although an exhaustive comparison with other frameworks is out of the scope of this work, we will briefly mention similarities and differences with some commonly used frameworks in the field. Firstly, we make use of two particular high-density EOS parameterizations. Besides many different existing choices in these parameterizations, a completely different approach is to use non-parametric inference involving Gaussian Processes @Landry19@Essick:2019ldf@Han20, or discretely sampling a set of pre-computed EOS @Capano:2019eae#cite(<Dietrich20>). Secondly, we compute likelihoods by performing kernel density estimation on posterior samples of neutron star properties such as mass, radius and tidal deformability @Miller19#cite(<AlMamun21>). It is also possible to directly infer EOS properties from the observational data, for example X-ray or gravitational wave data. For the first, #cite(<Riley18>, form: "prose") argue that this approach would be computationally too expensive, while for the latter this has been done by, e.g., #cite(<Capano:2019eae>, form: "prose")#cite(<Dietrich20>). A slightly different approach is used by #cite(<HernandezVivanco20>, form: "prose"), where the likelihood is computed by interpolating marginalized likelihoods using machine learning.

== Summary and future prospects
<summary-and-future-prospects>
In summary, the new joint mass-radius estimate of PSR~J0740$+$6620 significantly constrains the EOS. For the PP model the information gain is mostly a result of the high mass of the pulsar, as the $68 %$ credible range of the radius estimate exactly encompasses our prior distribution, informed by chiral EFT calculations, in that mass range. For the CS model the relatively high radius estimate does constrain the model at lower radii on top of constraints coming from the mass estimate. Combined with other current observational data from gravitational waves and kilonova light curves, as well as the #emph[NICER] mass-radius estimate of PSR~J0030$+$0451, we find the 95% credible ranges $12.38_(- 0.97)^(+ 0.70) thin$km (PP model) and $12.23_(- 0.97)^(+ 0.48) thin$km (CS model) for the radius of a $1.4$ M$""_⊙$ neutron star.

In the near future, the detailed analysis of gravitational wave events observed during the second part of the third observing run of LIGO/Virgo are expected to be published, among them a few candidate events which, in an initial rapid classification, were identified as containing at least one neutron star. Any measured tidal deformability from these gravitational waves events will help constrain the EOS further. There were unfortunately no EM counterparts for the potential binary neutron star or black hole-neutron star events during this observing run. The fourth observing run is planned to start next year, with the LIGO and Virgo detectors close to their design sensitivity and KAGRA fully joining the network~#cite(<2020LRR....23....3A>). At design sensitivity, GW170817-like signals will have signal-to-noise ratios of 100 and enable measurements of tidal deformability with more than three times better accuracy~#cite(<Capano:2019eae>). Subsequent further detector improvements are already planned for the mid to late 2020s~@2020LRR....23....3A, and an ongoing worldwide effort is paving the way for next decade's third generation detectors. These will improve current measurements of tidal deformability by a factor of $tilde.op 10$ and observe the population of tens to hundreds of thousands of neutron star binaries, with EM counterparts detectable for a fraction of them @Maggiore:2019uih@Sathyaprakash:2019yqt#cite(<Sathyaprakash:2019rom>).

In the coming months, #emph[NICER] is expected to deliver mass-radius measurements for three additional pulsars: two for which independent mass constraints exist (the $tilde.op 1.4$ M$""_⊙$ pulsar PSR J0437-4715 and the $tilde.op 1.9$ M$""_⊙$ pulsar PSR J1614-2230); and the pulsar PSR J1231-1411, which has no independently known constraint on the mass. There will be an update to the inferred mass and radius of PSR J0030+0451, using a larger data set, taking into account improvements to our understanding of the #emph[NICER] instrument response, and including #emph[XMM] data in a joint analysis (as done for PSR J0740+6620). There are also good prospects for narrowing the mass-radius measurements for PSR J0740+6620, using models of the #emph[NICER] background. All of these promise further improvements to our understanding of the dense matter EOS.

#heading(level: 1, numbering: none)[Acknowledgments]
<acknowledgments>
This work was supported in part by NASA through the #emph[NICER] mission and the Astrophysics Explorers Program. G.R., T.H., S.N. and T.E.R. are grateful for support from the Nederlandse Organisatie voor Wetenschappelijk Onderzoek (NWO) through the VIDI and Projectruimte grants (PI Nissanke). T.H. also acknowledges support from the NWO sectorplan. T.E.R. and A.L.W. acknowledge support from ERC Consolidator Grant No.~865768 AEONS (PI: Watts). S.K.G., K.H., and A.S. acknowledge support from the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) -- Project-ID 279384907 -- SFB 1245. W.C.G.H. acknowledges support through grant 80NSSC20K0278 from NASA. This work was sponsored by NWO Exact and Natural Sciences for the use of supercomputer facilities, and was carried out on the Dutch national e-infrastructure with the support of SURF Cooperative. We thank Sharon Morsink and Renee Ludlam for comments on a draft manuscript. We thank Mansi Kasliwal for providing us with the data for AT2017gfo. We thank the anonynomous referee for providing useful feedback on the manuscript.

#show bibliography: set text(size: 9pt)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 12pt, weight: "regular")
#bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)

