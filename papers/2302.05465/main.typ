#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.79cm, right: 1.76cm, top: 2.28cm, bottom: 2.57cm), columns: 2)
#set page(numbering: none, header-ascent: 15pt, header: context {
  let n = counter(page).get().first()
  if n > 1 {
    let num = text(10pt, counter(page).display())
    let mid = if calc.odd(n) [FRB Host Galaxies] else [Gordon et al.]
    grid(columns: (1fr, auto, 1fr),
      if calc.odd(n) { [] } else { num },
      align(center, text(10pt, mid)),
      if calc.odd(n) { align(right, num) } else { [] })
  }
})
#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("1.", p.at(0)) } else { numbering("1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 10pt, weight: "regular")[#num#it.body]])
}

#set figure(placement: auto)
#set par(justify: true, spacing: 0.59em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.59em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: table): set block(breakable: true)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)

#place(top, float: true, scope: "parent", clearance: 1.2em)[
#align(center)[
  #text(9pt, weight: "bold", [The Demographics, Stellar Populations, and Star Formation Histories of Fast Radio Burst Host Galaxies: Implications for the Progenitors])   #v(1.2em)
  #text(10.5pt)[Alexa C. Gordon#super[1], Wen-fai Fong#super[1], Charles D. Kilpatrick#super[1], Tarraneh Eftekhari#super[1,∗], Joel Leja#super[2,3,4], J. Xavier Prochaska#super[5,6,7], Anya E. Nugent#super[1], Shivani Bhandari#super[8,9,10,11], Peter K. Blanchard#super[1], Manisha Caleb#super[12,13], Cherie K. Day#super[14], Adam T. Deller#super[15], Yuxin Dong (董雨欣)#super[1], Marcin Glowacki#super[16], Kelly Gourdji#super[15], Alexandra G. Mannings#super[5], Elizabeth K. Mahoney#super[11], Lachlan Marnoch#super[11,13,17,18], Adam A. Miller#super[1], Kerry Paterson#super[19], Jillian C. Rastinejad#super[1], Stuart D. Ryder#super[17,18], Elaine M. Sadler#super[11,12], Danica R. Scott#super[16], Huei Sears#super[1], Ryan M. Shannon#super[15], Sunil Simha#super[5], Benjamin W. Stappers#super[20], and Nicolas Tejos#super[21]]
  
]
// affcenter
#align(center)[#set text(style: "italic")

  #text(9pt)[#super[1] Center for Interdisciplinary Exploration and Research in Astrophysics (CIERA) and Department of Physics and Astronomy, Northwestern University, Evanston, IL 60208, USA] \
  #text(9pt)[#super[2] Department of Astronomy \& Astrophysics, The Pennsylvania State University, University Park, PA 16802, USA] \
  #text(9pt)[#super[3] Institute for Computational \& Data Sciences, The Pennsylvania State University, University Park, PA, USA] \
  #text(9pt)[#super[4] Institute for Gravitation and the Cosmos, The Pennsylvania State University, University Park, PA 16802, USA] \
  #text(9pt)[#super[5] Department of Astronomy and Astrophysics, University of California, Santa Cruz, CA 95064, USA] \
  #text(9pt)[#super[6] Kavli Institute for the Physics and Mathematics of the Universe (Kavli IPMU), 5-1-5 Kashiwanoha, Kashiwa, 277-8583, Japan] \
  #text(9pt)[#super[7] Division of Science, National Astronomical Observatory of Japan,2-21-1 Osawa, Mitaka, Tokyo 181-8588, Japan] \
  #text(9pt)[#super[8] ASTRON, Netherlands Institute for Radio Astronomy, Oude Hoogeveensedijk 4, 7991 PD Dwingeloo, The Netherlands] \
  #text(9pt)[#super[9] Joint institute for VLBI ERIC, Oude Hoogeveensedijk 4, 7991 PD Dwingeloo, The Netherlands] \
  #text(9pt)[#super[10] Anton Pannekoek Institute for Astronomy, University of Amsterdam, Science Park 904, 1098 XH, Amsterdam, The Netherlands] \
  #text(9pt)[#super[11] CSIRO, Space and Astronomy, PO Box 76, Epping NSW 1710 Australia] \
  #text(9pt)[#super[12] Sydney Institute for Astronomy, School of Physics A28, University of Sydney, NSW 2006, Australia] \
  #text(9pt)[#super[13] ARC Centre of Excellence for All-Sky Astrophysics in 3 Dimensions (ASTRO 3D), Australia] \
  #text(9pt)[#super[14] Department of Physics, McGill University, Montreal, Quebec H3A 2T8, Canada] \
  #text(9pt)[#super[15] Centre for Astrophysics and Supercomputing, Swinburne University of Technology, Hawthorn, VIC, 3122, Australia] \
  #text(9pt)[#super[16] International Centre for Radio Astronomy Research (ICRAR), Curtin University, Bentley, WA 6102, Australia] \
  #text(9pt)[#super[17] School of Mathematical and Physical Sciences, Macquarie University, NSW 2109, Australia] \
  #text(9pt)[#super[18] Macquarie University Research Centre for Astronomy, Astrophysics \& Astrophotonics, Sydney, NSW 2109, Australia] \
  #text(9pt)[#super[19] Max-Planck-Institut für Astronomie, Königstuhl 17, 69117 Heidelberg, Germany] \
  #text(9pt)[#super[20] Department of Physics and Astronomy, University of Manchester, Oxford Road, M13 9PL, UK] \
  #text(9pt)[#super[21] Instituto de Física, Pontificia Universidad Católica de Valparaíso, Casilla 4059, Valparaíso, Chile] \
]
#v(1.2em)

#v(0.6em)
#align(center)[#smallcaps[Abstract]]
#v(0.4em)
We present a comprehensive catalog of observations and stellar population properties for 23 highly secure host galaxies of fast radio bursts (FRBs). Our sample comprises six repeating FRBs and 17 apparent non-repeaters. We present 82 new photometric and eight new spectroscopic observations of these hosts. Using stellar population synthesis modeling and employing non-parametric star formation histories (SFHs), we find that FRB hosts have a median stellar mass of $approx 10^9.9 thin M_⊙$, mass-weighted age $approx 5.1$~Gyr, and ongoing star formation rate $approx 1.3 thin M_⊙$~yr$""^(- 1)$ but span wide ranges in all properties. Classifying the hosts by degree of star formation, we find that 87\% (20/23 hosts) are star-forming, two are transitioning, and one is quiescent. The majority trace the star-forming main sequence of galaxies, but at least three FRBs in our sample originate in less active environments (two non-repeaters and one repeater). Across all modeled properties, we find no statistically significant distinction between the hosts of repeaters and non-repeaters. However, the hosts of repeating FRBs generally extend to lower stellar masses, and the hosts of non-repeaters arise in more optically luminous galaxies. While four of the galaxies with the most clear and prolonged rises in their SFHs all host repeating FRBs, demonstrating heightened star formation activity in the last $lt.tilde 100$~Myr, one non-repeating host shows this SFH as well. Our results support progenitor models with short delay channels (i.e., magnetars formed via core-collapse supernova) for most FRBs, but the presence of some FRBs in less active environments suggests a fraction form through more delayed channels.

#text(8pt)[#super[∗] NHFP Einstein Fellow]
]

= INTRODUCTION
<sec:intro>

Fast radio bursts (FRBs) are extremely bright ($approx 10$ mJy--$100$ Jy), (sub-)millisecond pulses of MHz--GHz emission. First discovered over a decade ago in 2007 @Lorimer07, it was not until 2017 that an FRB was precisely localized and traced back to its host galaxy at $z = 0.19$, providing the first direct evidence of their cosmological origins #cite(<Chatterjee-17>)#cite(<Marcote-17>)#cite(<Tendulkar-17>). While this first localization was facilitated by targeted observations made possible by the repeating nature of the source, an increasing number of FRBs are now being localized upon detection by fast transient searches using radio interferometers #cite(<Bannister-19>)#cite(<Ravi-19>). Over the last decade, the commissioning of sensitive and wide-field fast transient detection instrumentation has led to an enormous increase in the detected FRB population #cite(<CHIME-18>)#cite(<Macquart-10>). It is now established that some fraction (currently $tilde$4\% observed; #cite(<Petroff-22>, style: "aas_noparen.csl")) of the FRB population produce repeat bursts from the same cosmic source #cite(<Spitler-16>)@chime-repeater while the majority of discovered FRBs have not been observed to repeat to date @CHIME-catalog. Despite over 600 published FRBs to date #cite(<Petroff-22>), their origins and the nature of their repetition remains uncertain.

Due to their short durations and inferred high energies, many of the leading FRB progenitor models invoke a magnetically-powered neutron star, known as a magnetar #cite(<Platts-19>). The connection between FRBs and magnetars was bolstered with the detection of a bright radio burst from the Galactic magnetar SGR 1935+2154, which accompanied emission at higher energies @Bochenek20 @CHIME-magnetar#cite(<Mereghetti-20>). While the radio burst energies from that source fall a few orders of magnitude short of the typical extragalactic FRBs detected to date @Kirsten-SGR, they begin to bridge the gap between Galactic and extragalactic coherent radio sources (e.g., #cite(<Margalit20-Galacticmagnetar>, style: "aas_noparen.csl")#cite(<Nimmo-22>, style: "aas_noparen.csl")).

The FRB signal properties, namely their dispersion measure (DM), rotation measure (RM), duration, spectro-temporal morphology, and polarization, provide key information on their central engines, and serve as important probes of the intervening ionized matter @Michilli18#cite(<Hessels-19>)#cite(<Hilmarsson-21>)#cite(<Cook-2022>)#cite(<Mannings-2022>)@Ryder22 @Wu_McQuinn2022#cite(<Ocker-2023>). However, these signals alone provide only a highly model-dependent, low-precision estimate of the distance to the FRB, making it difficult or impossible to infer the parent stellar populations and FRB energetics directly. However, if a host galaxy can be identified, a wealth of information can be gleaned from their local and global environments -- precise redshifts, energy scales, and properties of the environment on local and galactic scales. Concurrent to the findings that repeater and non-repeater burst morphologies may be statistically distinct @Pleunis21, host properties may provide additional distinguishing power on the physical distinction between these classes. Aligned with this goal, advancements in FRB experiments have enabled routine (sub-)arcsecond localizations, making robust host galaxy associations feasible.

For FRBs, the first host associations were in seemingly distinct environments. The first repeating FRB 20121102A was found in a star-forming, metal-poor dwarf galaxy #cite(<Chatterjee-17>)#cite(<Tendulkar-17>), while the first well-localized apparently non-repeating FRB 20180924B resided in an older and more massive star-forming galaxy #cite(<Bannister-19>), providing early signs that they might arise from distinct populations. The next well-localized repeater FRB 20180916B was pinpointed to a massive spiral galaxy with a moderate star formation rate @Marcote_etal_2020, complicating the picture that their host properties alone could be discerning. One interesting feature that has only concerned two repeating FRBs thus far (FRBs 20121102A and 20190520B) are their co-location with persistent radio sources (PRSs; #cite(<Chatterjee-17>, style: "aas_noparen.csl")#cite(<Marcote-17>, style: "aas_noparen.csl")#cite(<Niu-22>, style: "aas_noparen.csl")): compact radio emission that cannot be attributed to star formation. Based on the size and brightness temperature ($lt.tilde$ 0.7 pc and $T_b gt.tilde 5 times 10^7$ K, respectively), #cite(<Marcote-17>, form: "prose") claim the PRS associated with FRB 20121102A is compact and directly linked to the FRB event, while the PRS associated with FRB 20190520B was too luminous to be explained by star formation #cite(<Niu-22>). Notably both bursts reside in dwarf host galaxies #cite(<Tendulkar-17>)#cite(<Niu-22>), with their PRSs coincident with or close to a star-forming knot in the galaxy. While no other FRBs have known PRSs to date, it is worth characterizing their host galaxies to connect to their multi-wavelength properties.

As a population, FRBs are generally found in star-forming galaxies across a wide range of masses (e.g., #cite(<Tendulkar-17>, style: "aas_noparen.csl")#cite(<Bannister-19>, style: "aas_noparen.csl")#cite(<Prochaska-19>, style: "aas_noparen.csl")#cite(<Marcote_etal_2020>, style: "aas_noparen.csl")#cite(<Fong-21>, style: "aas_noparen.csl")#cite(<Bhandari_210117>, style: "aas_noparen.csl") #cite(<Ravi22b>, style: "aas_noparen.csl")#cite(<Niu-22>, style: "aas_noparen.csl")). Based on early studies of a limited number of hosts, no statistically significant distinction was found between the stellar population properties of repeating and apparent non-repeating FRBs #cite(<Heintz-20>)#cite(<Bhandari-20>). In some cases, milliarcsecond-scale localizations pinpointed FRBs to very different sub-galactic environments, e.g., the discoveries of some repeating FRBs in or proximal to knots of star formation #cite(<Tendulkar-17>)#cite(<Bassa-17>)#cite(<Tendulkar-21>)#cite(<Piro-21>)#cite(<Niu-22>) or in non-star-forming environments altogether, such as the old $tilde 9$ Gyr globular cluster environment @Bhardwaj21 @Kirsten21. From a modest sample of sub-arcsecond localized FRBs, one finds the majority occur within or near the spiral arms of their hosts @Marcote_etal_2020 @Chittidi21#cite(<Mannings-21>)#cite(<Tendulkar-21>), although there are exceptions @Xu22.

While such sub-galactic details can be afforded by the fairly local $z lt.tilde 0.3$ FRB population, the bulk of newly-discovered FRBs will be found at higher redshift by more sensitive searches, and only integrated galaxy properties will be available in almost all cases. As spectral energy distribution (SED) modeling techniques diversify in their specific assumptions and methodologies #cite(<Pacifici-2022>, supplement: [for a comparison of 14 SED fitting codes]), it is necessary to compare the FRB host population to similarly-modeled field galaxies and to derive their individual star formation histories (SFHs). Thus, it is timely and complementary to more local studies to perform a uniform analysis of the population of FRB host galaxies, their SFHs, and derive implications for their progenitors.

In this work, we compile a sample of 23 highly secure FRB host galaxies, including the hosts of six repeating and 17 apparent non-repeating FRBs, discovered across a range of facilities, and perform uniform modeling of the stellar population properties and SFHs of their host galaxies. The FRBs in this sample were discovered over roughly a decade, November 2012--January 2022. In @sec:sample we discuss the sample selection. In @sec:observations we detail the data acquisition and processing. We detail our modeling assumptions and methodology using the `Prospector` SED modeling code #cite(<Johnson-21>) in @sec:prospector. We present our results of the stellar population properties and SFHs and compare to the general galaxy population in @sec:results and discuss the implications of these results in @sec:discussion. Finally, we summarize and conclude in @sec:conclusion.

= SAMPLE
<sec:sample>

Our sample is comprised of known FRB hosts from the literature as well as new FRBs and host identifications. We start with all FRBs localized before the end of January 2022 (FRB 20121102A to FRB 20220105A). As part of the Fast and Fortunate for FRB Follow-up#footnote[http:\/\/frb-f4.org/] (F$""^4$) collaboration, we receive the positional information of new FRBs from the Commensal Real-Time ASKAP Fast-Transients (`CRAFT`\; #cite(<mbb-10>, style: "aas_noparen.csl")) survey on the Australian Square Kilometre Array Pathfinder @ASKAP and the More TRansients and Pulsars (`MeerTRAP`\; #cite(<Rajwade-22>, style: "aas_noparen.csl")) project on the MeerKAT radio telescope @MeerKAT. We next search imaging archives such as the Sloan Digital Sky Survey (SDSS; #cite(<SDSS>, style: "aas_noparen.csl")), Pan-STARRS1 (PS1; #cite(<PS1>, style: "aas_noparen.csl")), and the Dark Enegy Camera Legacy Survey (DECaLS; #cite(<DECALS>, style: "aas_noparen.csl")) for any plausible host galaxies at or near the FRB position. If no host galaxy candidates are visible in these images, we obtain deep $r$- or $I$-band imaging with 4-meter to 10-meter class telescopes to aid with host galaxy identification (see #ref(<sec:-imaging>)). We also use known FRB host identifications from the literature, with the FRBs discovered by Arecibo #cite(<Spitler-14>)#cite(<Spitler-16>)#cite(<Scholz-16>), Parkes #cite(<Price-19>), the Canadian Hydrogen Intensity Mapping Experiment (CHIME; #cite(<CHIME-19>, style: "aas_noparen.csl")), and the Five-hundred-meter Aperture Spherical radio Telescope (FAST; #cite(<Niu-22>, style: "aas_noparen.csl")).

== Sample Selection
#<sec:-host-criteria>

We begin with a parent sample of 27 events that have been localized to $lt.tilde 1 - 2$, which is necessary for unambiguous host associations with luminous $L^(*)$ galaxies across the redshift range $z tilde 0.1 - 1$ @Eftekhari2017. We then apply the following criteria for inclusion in this work.

+ We require a PATH (Probabilistic Association of Transients to their Hosts; #cite(<path>, style: "aas_noparen.csl")) posterior probability $gt.eq 90 "%"$, following the same convention used in #cite(<bha-22>, form: "prose"). PATH employs a Bayesian framework to calculate the likelihood a transient is associated with a galaxy given the transient's localization, the galaxy's position on the sky and angular size, and its apparent magnitude. Combined with prior assumptions on the probability that the host is undetected (i.e., fainter than the flux limit of the imaging observations) and the offset of FRBs from the centers of their hosts, PATH reports the posterior probability of association to every galaxy in the field. Higher probabilities correspond to higher likelihood of association. By requiring the posterior probability to be $gt.eq 90 "%"$, we construct a sample of high probability host galaxy associations. We apply PATH to four FRBs -- 20190520B (using CFHT $r'$ archival data; #cite(<Niu-22>, style: "aas_noparen.csl") and #cite(<Gwyn08>, style: "aas_noparen.csl") for details on the $r'$ transmission curve), 20211203C, 20210410D, and 20220105A -- for which there are no published PATH probabilities. We otherwise use published PATH probabilities from #cite(<James-22>, form: "prose")@path, and #cite(<bha-22>, form: "prose"). This criterion removes the hosts of FRB 20190614D and FRB 20190523A.

+ There is no bright ($lt.tilde$ 10~AB~mag) foreground star within 5~of the FRB position. We employ this criterion to ensure that the observations are not contaminated by scattered light from a nearby bright star; in particular, this can inhibit accurate photometry of the host galaxy.

+ There are detections of the host galaxy in at least three photometric bands in the optical/IR or otherwise overlapping the observed spectrum's wavelength coverage. For our methodology used to model the FRB hosts, described in @sec:prospector, the absolute flux calibration of the spectrum depends on the photometry. We have found three photometric bands to be the minimum required in order to obtain a trustworthy model.

+ We exclude FRBs with burst spectral energies below 10$""^27$ erg Hz$""^(- 1)$, to exclude low-energy bursts that would be undetectable over the majority of the redshift range spanned by our sample. Assuming an ASKAP detection limit of 4.4 Jy ms #cite(<James-22>), this energy cut corresponds to excluding FRBs that can be seen to a maximum redshift of $z tilde 0.003$ by the telescope that contributed the bulk of our sample. This criterion excludes two very nearby FRBs/FRB-like signals: FRB 20200120E and the Galactic source SGR J1935+2154. These sources are significant outliers in luminosity space, as is clear from fluence-redshift diagrams such as the one in #cite(<Ryder22>, form: "prose"). We note that while all bursts seen to date from both of these sources are excluded by this cut, the highest energy bursts from the FRB-like SGR J1935+2154 are more energetic than the lowest energy bursts of FRB 20200120E #cite(<Nimmo-22>), making them more comparable to each other than to the higher-z FRB population.

+ A spectrum of the host galaxy is available and contains detectable spectral features (i.e., emission and absorption lines) for redshift determination and a signal-to-noise (S/N) $gt.tilde$ 3/Å in the continuum. We note that spectroscopy is essential for breaking the known degeneracy in age, dust, and metallicity in SED modeling (e.g., #cite(<Bell-01>, style: "aas_noparen.csl")#cite(<Leja-17>, style: "aas_noparen.csl")). Additionally, the thousands of data points inherent in a spectrum provide more information to fit than photometry alone. We note that even though there is relative difficulty in detecting high S/N features for quiescent versus star-forming galaxies, no hosts are excluded on this criterion alone.

While these sample criteria are enforced for the majority of the FRBs, we made two exceptions (requiring additional care in our data processing) to ensure that the small sample of repeating FRBs was not further reduced. The repeating FRB 20190520B #cite(<Niu-22>) fails the bright star criterion due to its $approx 1$ proximity to the bright, $r$$tilde$8 AB mag, variable star V1042 Sco B. In addition to being a repeating FRB, this host contains the second known PRS, making it especially noteworthy. We took appropriate steps during the data collection and reduction phases to ensure the photometry and spectroscopy were not contaminated by extra flux from the star (see #ref(<sec:-imaging>) and @sec:spectra for details). As mentioned above, we use archival CFHT $r'$ @Gwyn08 data for calculating the PATH probability of this host galaxy. Our analysis assigns the host identified in #cite(<Niu-22>, form: "prose") a posterior probability of nearly 100\%, robustly confirming the host association. The host galaxy of the repeating FRB 20190711A fails the spectroscopic continuum signal requirement; at a declination of $- 80^compose$, the source is always at high airmass for most available follow-up resources and is also quite faint, making observation challenging. While we use the existing Gemini South/Gemini Multi-Object Spectrograph (GMOS) spectrum (first reported in #cite(<mpm-20>, style: "aas_noparen.csl")) to determine the redshift, this spectrum does not have a high enough S/N for our subsequent modeling. In this case, we still include this host, and take advantage of the seven photometric data points for modeling.

When applying these criteria to the existing literature and new FRBs obtained from the ASKAP/`CRAFT` and MeerKAT/`MeerTRAP` collaborations, we obtain a sample of 23 FRB host galaxies (six repeating FRBs and 17 apparent non-repeaters). We list the properties of the FRBs, discovery surveys, and optical host magnitudes in #ref(<tab:-FRB-properties>). This compilation is the largest sample of highly secure localized FRB host galaxies to date and allows for a systematic study of their host properties and SFHs.

// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Figure #context it.counter.display(it.numbering).* #it.body]
}

// tabstyle
#show figure.caption.where(kind: table): it => {
  if it.numbering == none { return it }
  [*Table #context it.counter.display(it.numbering).* #it.body]
}

#figure(scope: "parent", [#table(
    stroke: none,
    columns: 9,
    align: (left,center,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    [FRB], [Survey/Facility$""^a$], [RA (FRB)], [Decl. (FRB)], [$z$], [Repeater], [Host Magnitude], [Filter], [Reference],
    table.hline(stroke: 0.5pt),
    [], [], [\[J2000\]], [\[J2000\]], [], [], [\[AB\]], [], [],
    [20121102A], [Arecibo/VLA/EVN], [05:31:58.70], [33:08:52.6], [0.1927], [Y], [23.73], [GMOS-N $r$], [1,2],
    [20180301A], [Parkes/VLA], [06:12:54.44], [04:40:15.8], [0.3304], [Y], [21.21], [NOT $r$], [3],
    [20180916B], [CHIME/EVN], [01:58:00.75], [65:43:00.3], [0.0337], [Y], [16.17], [SDSS $r$], [4,5],
    [20180924B], [CRAFT], [21:44:25.26], [$-$40:54:00.1], [0.3212], [N], [20.33], [DECaLS $r$], [6, This Work],
    [20181112A], [CRAFT], [21:49:23.63], [$-$52:58:15.4], [0.4755], [N], [21.68], [DES $r$], [7],
    [20190102C], [CRAFT], [21:29:39.76], [$-$79:28:32.5], [0.2912], [N], [20.77], [VLT/FORS2 $I$], [8, 10],
    [20190520B], [FAST/VLA], [16:02:04.27], [$-$11:17:17.3], [0.2418], [Y], [22.16], [SOAR $r$], [9, This Work],
    [20190608B], [CRAFT], [22:16:04.77], [$-$07:53:53.7], [0.1178], [N], [17.41], [DECaLS $r$], [8, This Work],
    [20190611B], [CRAFT], [21:22:58.94], [$-$79:23:51.3], [0.3778], [N], [22.15], [GMOS-S $r$], [4,8],
    [20190711A], [CRAFT], [21:57:40.62], [$-$80:21:28.8], [0.522], [Y], [23.54], [GMOS-S $r$], [4,8],
    [20190714A], [CRAFT], [12:15:55.13], [$-$13:01:15.6], [0.2365], [N], [20.34], [Pan-STARRS $r$], [4],
    [20191001A], [CRAFT], [21:33:24.31], [$-$54:44:51.9], [0.234], [N], [18.36], [DECaLS $r$], [10],
    [20200430A], [CRAFT], [15:18:49.54], [12:22:36.3], [0.1608], [N], [21.05], [DECaLS $r$], [4],
    [20200906A], [CRAFT], [03:33:59.08], [$-$14:04:59.5], [0.3688], [N], [19.95], [DES $r$], [3],
    [20201124A], [CHIME/ASKAP], [05:08:03.51], [26:03:38.5], [0.0979], [Y], [17.86], [Pan-STARRS $r$], [11],
    [20210117A], [CRAFT], [22:39:55.07], [$-$16:09:05.4], [0.2145], [N], [22.97], [DEIMOS $R$], [12, 13, This Work],
    [20210320C], [CRAFT], [13:37:50.60], [$-$16:07:21.7], [0.2797], [N], [19.47], [SOAR $r$], [13, 14, This Work],
    [20210410D], [MeerTRAP], [21:44:20.70], [$-$79:19:05.5], [0.1415], [N], [20.65], [SOAR $r$], [15, This Work],
    [20210807D], [CRAFT], [19:56:53.14], [$-$00:45:44.5], [0.1293], [N], [17.17], [Pan-STARRS $r$], [13, 16, This Work],
    [20211127I], [CRAFT], [13:19:13.97], [$-$18:50:16.1], [0.0469], [N], [14.97], [SOAR $r$], [13, 16, 17, This Work],
    [20211203C], [CRAFT], [13:38:15.00], [$-$31:22:48.2], [0.3439], [N], [19.64], [SOAR $r$], [13, 14, This Work],
    [20211212A], [CRAFT], [10:29:24.22], [01:21:39.4], [0.0707], [N], [16.44], [SOAR $r$], [13, 16, This Work],
    [20220105A], [CRAFT], [13:55:12.94], [22:27:59.4], [0.2785], [N], [21.19], [Pan-STARRS $r$], [13, 14, This Work],
    table.hline(stroke: 0.8pt),
  )], caption: [Basic FRB Properties ]
  , kind: table
  )

<tab:-FRB-properties>

= OBSERVATIONS AND DATA REDUCTION
<sec:observations>

== Imaging
#<sec:-imaging>

Once the host for a given FRB is identified, we first search for archival photometry from optical and near-infrared (NIR) surveys: the Sloan Digital Sky Survey (SDSS; #cite(<SDSS>, style: "aas_noparen.csl")), the Dark Energy Camera Legacy Survey (DECaLS; #cite(<DECALS>, style: "aas_noparen.csl")), the Dark Energy Survey (DES; #cite(<DES>, style: "aas_noparen.csl")), the Pan-STARRS 3$pi$ survey (PS1; #cite(<PS1>, style: "aas_noparen.csl")), the Two Micron All Sky Survey (2MASS; #cite(<2MASS>, style: "aas_noparen.csl")), the VISTA Hemisphere Survey (VHS; #cite(<VISTA>, style: "aas_noparen.csl")), and the Wide-field Infrared Survey Explorer (WISE; #cite(<WISE>, style: "aas_noparen.csl")). For the VHS data, we use a custom script to stack the available, reduced frames. This script implements `SWarp` @swarp to coadd the frames. We then set a default zero-point of 27.5 AB mag using the flux calibration from the European Southern Observatory (ESO) archive data reductions. For the WISE data, for which there is a choice of aperture, we select photometry values from the 'aperture 2' instrumental aperture (8.25~for W1, W2, and W3, and 16.5~for W4); these apertures were chosen as a balance between encompassing the entire host galaxy, allowing for the change in point spread function with wavelength, and avoiding flux from unassociated sources. We then convert all values to the AB magnitude system if needed.

For nine observations, particularly for FRBs in crowded regions or for hosts of large angular size which are not adequately encompassed by the default apertures, we perform manual photometry. We created a custom script that implements the `aperture‘_photometry` module of `photutils` @photutils#footnote[https:\/\/github.com/charliekilpatrick/photometry]. We determined the aperture and annuli sizes by loading the images into `SAOImageDS9` @DS9 and adjusting the region sizes to ensure the host and background were modeled accurately. In most cases, the zero-points were taken from the header of the images after verifying the values were consistent with nearby photometric standards, but in cases where no zero-point was provided, we performed point spread function (PSF) photometry on all point sources in the image using `DoPhot` @Schechter93 and compared their instrumental magnitudes to SkyMapper DR2 standard stars @Onken19 for southern fields ($delta < - 30^compose$) or Pan-STARRS DR2 standard stars @Flewelling16 for more northern fields ($delta > - 30^compose$). We then converted to the AB magnitude system if needed for consistency with the rest of the data. Finally, we corrected the values for Galactic extinction using the @Fitzpatrick:2007 extinction law. We report the data source, filters, photometry, uncertainties and references in Appendix #ref(<sec:-phot>, supplement: none).

To complement the existing archival data and fill out the host SEDs, we observed the fields of 10 FRBs with the Goodman High Throughput Spectrograph on the 4-m Southern Astrophysical Research Telescope (SOAR; PIs Fong, Gordon; #cite(<SOAR>, style: "aas_noparen.csl")); GMOS on the 8-m Gemini South Telescope (PI Tejos; #cite(<Gemini>, style: "aas_noparen.csl")); the Low Resolution Imaging Spectrometer (LRIS) on the 10-m Keck I Telescope (PI Nugent; #cite(<LRIS>, style: "aas_noparen.csl")); the MMT and Magellan Infrared Spectrograph (MMIRS) on the 6.5-m MMT (PI Nugent; #cite(<MMIRS>, style: "aas_noparen.csl")); and, the FOcal Reducer and low dispersion Spectrograph 2 (FORS2; #cite(<FORS2>, style: "aas_noparen.csl")) and High Acuity Wide-field K-band Imager (HAWK-I; #cite(<HAWKI>, style: "aas_noparen.csl")) on the 8-m Very Large Telescope (VLT; PIs Macquart, Shannon). Details of these observations, including the observation dates, filter, and corresponding magnitude, are reported in @tab:imaging. For six FRBs, we duplicate filters used in archival observations to increase the S/N of the detected host, or perform deeper searches if they were previously undetected.

We reduced the new Gemini, Keck, and MMT imaging data with the `POTPyRI`#footnote[https:\/\/github.com/CIERA-Transients/POTPyRI] pipeline. `POTPyRI` creates master bias, master dark, and master flat frames (depending on the types of calibrations available). These calibrations are applied to the science frames before alignment and stacking. A World Coordinate System (WCS) is calculated then applied by calibrating to the Gaia DR3 catalog @Gaia @GaiaDR3. In the case where automatic WCS alignment fails (i.e., the RMS of the astrometric fit is $gt.eq$ 0.5), we perform manual WCS alignment by interactively matching sources detected in the science image with known counterparts in either the Gaia DR3 (for optical images) or 2MASS (for NIR images) catalogs. Once the RMS of the astrometric fit is on order 0.2, we calculate the zero-point and proceed with PSF photometry as described above.

For the SOAR data, we use the `photpipe` pipeline #cite(<Rest-05>) for reduction. This pipeline performs bias correction and flat-fielding and aligns the WCS against the Gaia DR3 catalog. The science frames are then sky subtracted, stacked, and regridded to a common pixel scale and field center using `SWarp` @swarp. PSF photometry is performed on all point sources in the stacked image using a custom version of `DoPhot`. Finally, the pipeline calculates the zero-point of the final calibrated science image by comparing the instrumental PSF magnitudes to SkyMapper DR2 and Pan-STARRS DR2 standard stars using the same methods described above. We then applied these zero-points to aperture magnitudes obtained using `photutils`. The VLT data were reduced and further processed using the procedure detailed in #cite(<Bhandari_210117>, form: "prose").

We show representative images of all FRB hosts in the sample, including new observations and images from the literature #cite(<Heintz-20>)#cite(<mpm-20>)#cite(<Mannings-21>)#cite(<Tendulkar-21>)@Bhandari_210117#cite(<bha-22>)#cite(<Caleb-23>), in #ref(<fig:imaging-gallery>). In total, we present 29 new photometric measurements from our own imaging and 53 measurements from archival imaging. Finally, we collect 114 published photometric values from the literature and archives for 17 FRBs. These values and their references are listed in @tab:imaging.

For FRB 20190520B, we aligned the SOAR/Goodman field of view so that the bright, nearby star would not land on the detector. We then reduced the data with `photpipe` following the procedure described above. However, even with the care taken to avoid excess flux from the neighboring star, the background surrounding the host was still significantly greater than the rest of the field. In order to accurately calculate the photometry of the host, we applied a more complex background model to our photometry code#footnote[https:\/\/github.com/charliekilpatrick/photometry], assuming a spatially varying one-dimensional background that varies with the $x$, $y$, and $x * y$ pixel value from the center of the host galaxy. We then placed a 2.0~aperture around the host galaxy and all point-like sources of emission close to FRB 20190520B. The resulting values are within 0.1-0.3 AB magnitudes of the values derived from the original photometry script, but we proceed with the complex-background subtracted values in our modeling as these are more representative of the true brightness of the host.

// [figvision-cn] imgs/FRB20121102A_J_host.png
// 这是一张天文学显微照片，展示了快速射电暴（FRB）
// 20121102A的宿主星系区域。图像采用倒置灰度显示，其中白
// 色和浅灰色代表高辐射强度，黑色代表低辐射强度或背景噪声。
// 图像整体呈现模糊的云状结构，表明这是红外波段的观测数据，
// 分辨率受到衍射极限限制。 在图像的右上角，有三行加粗的
// 黑色文字标注。第一行为“FRB20121102A”，标识了该快速射电
// 暴的名称。第二行为“MMT MMIRS/J”，指明观测设备为多镜面
// 望远镜（MMT）及其近红外光谱成像仪（MMIRS），波段为J波
// 段。第三行为“Arecibo”，表示该FRB最初由阿雷西博射电望远
// 镜探测到。 图像中心偏右的位置有一个红色的十字标记（+），
// 其物理含义是FRB 20121102A的精确位置。由于该FRB具有毫角
// 秒级的定位精度，因此没有使用椭圆来表示误差范围，而是用
// 点状的十字标出。该红叉位于一团较亮的弥散光斑结构中，暗
// 示FRB可能起源于该宿主星系的某个特定区域。 在图像的中部，
// 有两条紫色的线段，分别呈水平和垂直方向排列，它们构成了
// 紫色十字准线的一部分，用于标示宿主星系的中心位置。水平
// 线段位于红色十字标记的左侧，垂直线段位于红色十字标记的
// 正下方。这两条线段与红色十字共同定义了FRB相对于宿主星
// 系中心的偏移关系。 在图像的左下角，有一条黑色的水平比
// 例尺线段。线段上方标注有“5 kpc”，表示该线段长度对应的
// 物理尺度为5千秒差距；线段下方标注有“1.55"”，表示该线段
// 在天空中的角距离为1.55角秒。这一比例尺提供了将图像上的
// 像素距离转换为物理距离或角距离的定量依据。 根据图注信
// 息，该图像的定向为北方朝上，东方朝左。从图中可见，红色
// 十字标记（FRB位置）相对于紫色十字准线（宿主星系中心）
// 略微偏向东北方向（即图像的右上方向）。整个宿主星系表现
// 为一个不规则的、延展的发光结构，周围散布着一些更暗的背
// 景源或前景源。
// [figvision-cn] imgs/FRB20180301A_r_host.png
// 这是一张针对快速射电暴FRB 20180301A宿主星系的显微照片。
// 图像采用倒置灰度显示，背景为白色，天体结构呈现为深灰色
// 至黑色的模糊光斑。画面中央垂直分布着一个不规则的星系主
// 体，其形态呈长条状，由几个紧密聚集的高亮（深色）核心区
// 域组成，并在左下角伴有一个独立的较暗团块。在星系主体的
// 正上方，绘制有一个红色的空心椭圆轮廓，该椭圆未与任何明
// 亮的星系结构重叠，代表该快速射电暴定位的68%置信区间。
// 在星系主体的左侧和下方分别绘制有两条紫色的短粗线段，这
// 两条线段共同构成一个十字标记，指示宿主星系的中心位置。
// 图像右上角包含三行黑色文字标注：第一行为“FRB20180301A”，
// 第二行为“NOT ALFOSC/r”，第三行为“Parkes”。图像左下角设
// 有一条黑色的水平比例尺，比例尺上方标注物理尺度为“10
// kpc”，下方标注对应的角尺度为“2.08"”。
// [figvision-cn] imgs/FRB20180916B_F110W_host_v2.png
// 这是一张针对快速射电暴FRB 20180916B宿主星系的哈勃太空
// 望远镜（HST）F110W波段成像图，图像整体为黑白反色显示，
// 即背景天空为白色，天体结构为黑色。 子图类型：天文显微
// 照片（倒像）。 坐标轴与范围：图像左下角设有物理尺度比
// 例尺和角度比例尺。一条黑色水平线段标注为“5 kpc”（千秒
// 差距），其正下方对应的另一条较短的黑色水平线段标注为“
// 7.61"”（角秒），表明该图像的视场范围约为数十角秒，对应
// 物理尺度约为数千秒差距。 图中主要物体及布局： 中心星系：
// 图像中央偏下位置展示了一个巨大的螺旋星系。由于是倒像，
// 星系最亮的核心区域呈现为深黑色的致密圆斑，周围环绕着较
// 暗的旋臂结构，旋臂上可见不规则的深色尘埃带或恒星形成区
// 纹理。星系整体形态呈倾斜状，主轴方向大致从左上延伸至右
// 下。 前景/背景恒星：画面中散布着多个大小不一的黑色圆形
// 光斑，这些是前景或背景中的恒星。其中右上角有一颗极亮的
// 恒星，呈现出明显的衍射十字星芒，其光芒向四周辐射，部分
// 遮挡了后方的星空背景。其他恒星多为无星芒的小黑点。 FRB
// 定位标记：在星系核心的左上方，叠加有一个红色的加号（+）
// 符号。根据图注说明，该红色加号代表快速射电暴FRB
// 20180916B的68%置信度定位中心。该位置位于星系旋臂延伸的
// 区域，并未直接落在星系最亮的光核中心。 辅助标记：图像
// 左侧中部和底部各有一条紫色的短粗直线段，分别呈水平和垂
// 直放置，用于指示方位或作为测量参考线。 文字标注： 图像
// 右上角有三行黑色大号无衬线字体文本，从上至下依次为：“
// FRB20180916B”（目标名称）、“HST/F110W”（观测设备与滤光
// 片波段）、“CHIME”（发现该信号的射电望远镜阵列名称）。
// 图像左下角有上述提到的比例尺数值“5 kpc”和“7.61"”。 结
// 论与趋势：该图像展示了FRB 20180916B与其宿主星系的相对
// 位置关系。通过高精度的光学成像，确认了该快速射电暴起源
// 于一个螺旋星系内部，且具体位置偏离星系中心，位于旋臂结
// 构中。
// [figvision-cn] imgs/FRB20180924B_r_host.png
// 该子图展示的是快速射电暴FRB 20180924B宿主星系的单张光
// 学波段成像照片。图像整体为灰度图，背景由不同深浅的灰色
// 像素构成，代表天体亮度分布。图像中央偏右位置有一个显著
// 的暗黑色圆形区域，这是因过曝光而饱和的主星系核心，其周
// 围环绕着较亮的弥散光晕结构，向外逐渐过渡到灰度较低的像
// 素背景。在黑色饱和核心的正上方紧邻处，叠加了一个红色的
// 空心椭圆符号，该符号代表快速射电暴FRB 20180924B的68%置
// 信区间定位误差框，表明爆发源位于此红色椭圆范围内。图像
// 中还包含两个紫色的粗线段标记：一条水平线段位于主星系核
// 心的左侧，另一条垂直线段位于主星系核心的下方，这两条线
// 段共同构成了一个十字准星光标的一部分，用于标示宿主星系
// 的中心位置。图像左下角标注有比例尺信息，包含两条黑线及
// 对应文字：上方文字为“10 kpc”，下方文字为“2.12"”，表示
// 物理尺度10千秒差距对应角尺度2.12角秒。图像右上角有三行
// 黑色文本标签，从上至下依次为“FRB20180924B”、“DeCALS
// DR8 DECam/r”和“ASKAP”。其中，“FRB20180924B”标识了目标
// 天体的名称；“DeCALS DR8 DECam/r”说明了图像的观测来源（
// Dark Energy Camera Legacy Survey第8版数据）及使用的r波
// 段滤光片；“ASKAP”指出了进行射电定位的望远镜阵列。根据
// 常规天文图像规范，该图的朝向为上北下南，左东右西。
// [figvision-cn] imgs/FRB20181112A_r_host.png
// 这是一张天文学领域的灰度显微照片，展示了快速射电暴
// FRB20181112A的宿主星系及其定位区域。图像整体为黑白反色
// 处理，即较亮的像素点代表较强的光信号（恒星或星系），较
// 暗的背景代表宇宙空间。 图像右上角包含三行黑色文字标注。
// 第一行为“FRB20181112A”，标识了该快速射电暴的名称；第二
// 行为“DES DR2 DECam/r”，说明图像数据来源于暗能量巡天项
// 目（DES）的第二期数据发布（DR2），使用的是DECam相机的r
// 波段滤镜；第三行为“ASKAP”，表明射电观测数据来源于澳大
// 利亚平方公里阵列探路者望远镜。 图像主体背景布满了噪点
// 状的灰色像素。画面中有三个明显的深黑色团块状结构，这些
// 是前景中的星系或恒星。位于画面上方偏左处有一个较大的、
// 形状不规则的黑色弥散光斑。在画面正中央，有一个较小且边
// 缘较为清晰的黑色光斑，这是被确认为FRB宿主星系的对象。
// 在画面下方偏右处，还有另一个较小的模糊黑色光斑。 在中
// 央那个较小的黑色光斑上叠加了两个几何图形标记。首先是一
// 个紫色的十字准线符号，由一条水平线段和一条垂直线段组成，
// 两条线段并未完全交叉于一点，而是分别位于中心点的左侧和
// 下方，共同指向该宿主星系的精确位置。其次是一个红色的空
// 心椭圆，该椭圆呈倾斜状态，长轴从左下角延伸至右上角，将
// 中央的宿主星系及紫色十字准线完全包围在内。根据图注信息，
// 这个红色椭圆代表了该快速射电暴位置的68%置信区间。 图像
// 左下角设有一个比例尺。上方是一条黑色的水平实线，旁边标
// 注有“10 kpc”，表示该线段长度对应物理距离10千秒差距。在
// 该黑线下方标注有“1.67"”，表示该线段对应的角直径为1.67
// 角秒。
// [figvision-cn] imgs/FRB20190102C_I_host.png
// 这是一张天文学领域的灰度显微照片，展示了快速射电暴 FRB
// 20190102C 的宿主星系及其定位区域。图像采用北向上、东向
// 左的定向方式。 子图类型：光学波段成像图（来自 VLT
// FORS2/I 仪器），叠加了射电定位信息（来自 ASKAP）。 图
// 像主体： 背景为像素化的灰度噪声场，代表天空背景。 中心
// 偏右位置有一个明显的暗色椭圆结构，这是宿主星系的主体，
// 呈现为负像（即亮区为深灰至黑色，暗区为浅灰至白色）。该
// 星系呈不规则或盘状形态，亮度分布不均匀，核心区域最暗（
// 对应实际最亮），向外逐渐变浅。 在星系核心区域上叠加一
// 个红色实线椭圆轮廓，表示 FRB 20190102C 的 68% 置信度定
// 位误差椭球投影。该椭圆长轴大致沿东北-西南方向倾斜，短
// 轴较短，表明定位精度较高但未达到毫角秒级。 图像左侧中
// 部有一条水平紫色短线段，下方中部有一条垂直紫色短线段，
// 二者共同构成十字准星标记，指示宿主星系的光学中心位置（
// 即紫色叉丝交点）。根据图注惯例，此十字应位于星系核区附
// 近，但在此图中未完整画出交叉点，仅显示两段分离线段，可
// 能因排版或裁剪所致；实际含义仍为标示宿主星系中心。 左
// 下角标注比例尺：一条黑色水平线段上方标有“10 kpc”，下方
// 标有“2.27"”，表示该线段长度对应物理尺度 10 千秒差距（
// kpc）和角尺度 2.27 角秒（arcseconds），用于将图像像素
// 转换为真实空间尺寸。 右上角有三行加粗黑色文字标题：“
// FRB20190102C”、“VLT FORS2/I”、“ASKAP”，分别标识目标源
// 名称、光学成像设备与滤光片（I 波段）、射电望远镜阵列。
// 颜色映射与通道： 图像为单通道灰度图，无彩色合成。亮度
// 反转处理：原始数据中较亮的天体区域在图中显示为深色（接
// 近黑），背景噪声为浅灰色至白色。这种负像处理常用于突出
// 低表面亮度结构。 红色椭圆为矢量叠加图形，非成像数据部
// 分，颜色恒定，线条粗细均匀。 紫色线段亦为矢量叠加，颜
// 色恒定，宽度一致。 趋势与结论： 宿主星系被成功识别并定
// 位于光学图像中心区域，其形态符合典型矮星系或不规则星系
// 特征。 FRB 定位椭圆完全覆盖星系核心区域，表明射电信号
// 很可能起源于该星系内部，支持其为宿主星系的结论。 比例
// 尺显示该星系物理尺度约为数十 kpc 量级（从图像跨度估算），
// 属于中等大小星系。 使用 I 波段成像有助于减少尘埃消光影
// 响，更清晰地揭示恒星分布结构。 ASKAP 提供的定位精度足
// 以将 FRB 限制在单个星系内，但未精确到星团或恒星形成区
// 级别。 所有标注文字及符号均已涵盖，无其他隐藏元素。图
// 像整体传达的核心信息是：FRB 20190102C 的空间位置与其宿
// 主星系高度吻合，且该星系可通过光学手段清晰辨识。
// [figvision-cn] imgs/FRB20190520B_r_host.png
// 这是一张天体物理领域的科学插图，展示了快速射电暴（FRB）
// 源 FRB 20190520B 及其宿主星系的成像观测结果。该图像为
// 一张经过灰度反转处理的显微照片或光学/近红外波段的天文
// 成像图，其中较暗的像素代表较高的光强（即星系主体），较
// 亮的像素代表背景天空。 图像的整体布局如下： 右上角包含
// 三行黑色粗体文字标注。第一行为“FRB20190520B”，标识了观
// 测目标的具体编号；第二行为“SOAR Goodman/r”，说明了数据
// 来源使用的是 SOAR 望远镜上的 Goodman 相机在 r 波段（红
// 波段）拍摄的图像；第三行为“FAST”，指代发现该信号的
// FAST 射电望远镜。 左下角设有一个比例尺区域，包含两条平
// 行的黑色水平线段及对应数值。上方较长的线段旁标注有“10
// kpc”，表示该长度对应的物理尺度为 10 千秒差距；下方较短
// 的线段旁标注有“2.60"”，表示该长度对应的角直径为 2.60
// 角秒。这两个数值建立了图像中的空间距离与实际物理尺寸之
// 间的定量关系。 图像的主体部分呈现了一个不规则的星系结
// 构，由不同灰度的像素块组成。星系核心区域呈现深黑色，表
// 明此处光强最强，形态上大致呈东西向延伸的不规则形状。背
// 景区域则由浅灰色和白色的噪点状像素构成，模拟了天空背景
// 噪声。 在星系图像之上叠加了两个关键的几何标记符号： 一
// 个红色的十字准星（+号），位于星系中心偏右的一个高亮（
// 深黑）区域附近。根据图注信息，这个红色十字标记代表了宿
// 主星系的精确位置。 一对紫色的线条，构成了一个类似直角
// 坐标轴或误差框的结构。一条垂直的紫色线段位于红色十字的
// 左上方，另一条水平的紫色线段位于红色十字的右侧并延伸至
// 星系边缘。结合图注中关于"68% confidence interval”的描
// 述，这两条紫色线段实际上勾勒出了 FRB 定位的置信区间范
// 围（通常表现为椭圆，但在此图中可能以正交投影线或特定边
// 界形式展示），指示了 FRB 信号来源的空间不确定性范围。
// 整幅图像传达了以下结论：通过 SOAR 望远镜的光学成像与
// FAST 射电数据的结合，研究人员成功将 FRB 20190520B 定位
// 到了其宿主星系内的特定区域（红色十字处），并利用紫色标
// 记展示了定位精度（68% 置信度）。图像的朝向遵循天文惯例，
// 即北方朝上，东方朝左。
// [figvision-cn] imgs/FRB20190608B_F160W_host.png
// 该子图展示的是快速射电暴FRB 20190608B宿主星系的哈勃太
// 空望远镜（HST）成像数据，属于光学波段显微照片。图像整
// 体为灰度显示，背景呈现高噪声颗粒状纹理，亮度分布不均。
// 中心区域为一个明显的暗色椭圆结构，代表星系核心或尘埃遮
// 蔽区，其周围环绕着较亮的弥散光晕，构成典型的旋涡或不规
// 则星系形态。 在图像右上角叠加有三行黑色粗体文字：第一
// 行为“FRB20190608B”，第二行为“HST/F160W”，第三行为“
// ASKAP”。这些标注表明观测对象编号、使用的滤光片（F160W
// 近红外波段）及射电定位数据来源（ASKAP阵列）。 图中包含
// 两个关键标记元素： 一个红色实心圆点位于星系中心偏右上
// 方约0.5角秒处，代表该FRB事件的68%置信度定位中心。根据
// 上下文，此位置对应于ASKAP提供的毫角秒级精确定位结果。
// 两条紫色直线段构成十字准线，分别水平与垂直放置于图像左
// 侧和底部边缘附近，用于指示北向上、东向左的方向基准；其
// 中水平线段位于左中部，垂直线段位于下中部，二者不交汇于
// 同一点，仅作为方向参考而非精确坐标轴。 左下角设有比例
// 尺标识：一条黑色短线下方标注“4.66"”（即4.66角秒），其
// 正上方另有一条稍长黑线标注“10 kpc”，表示该长度对应物理
// 尺度10千秒差距。由此可推算出图像空间分辨率约为每角秒约
// 2.15 kpc。 从视觉趋势看，红色定位点落在星系外围盘面上，
// 未处于最亮核区，暗示该FRB可能起源于恒星形成活跃区或金
// 属丰度较低的外围环境。整个图像无其他明显天体结构干扰，
// 主要聚焦于宿主星系本体及其FRB定位关系。
// [figvision-cn] imgs/FRB20190611B_r_host.png
// 该子图为一幅天文光学显微照片，展示了快速射电暴FRB
// 20190611B的宿主星系环境。图像采用倒置灰度映射，背景为
// 白色，天体呈现为黑色至深灰色的像素化光斑。图像右上角标
// 注有黑色粗体文字“FRB20190611B”，其下方依次排列两行说明
// 文字：“Gemini-S GMOS/r”和“ASKAP”，表明数据分别来源于双
// 子座南望远镜的GMOS相机r波段成像以及ASKAP射电望远镜。
// 图像中心偏左位置有一个橙红色空心圆圈，代表该快速射电暴
// 68%置信度的定位区域。圆圈内部可见一个微弱的、弥散的灰
// 色模糊斑块，对应于宿主星系的主体结构，其形态不规则且亮
// 度较低。在橙色圆圈的右侧，分布着两个显著的深黑色圆形光
// 斑，边缘清晰，应为前景恒星或明亮点源；其中上方较大的黑
// 色光斑位于圆圈右上方，下方较小的黑色光斑位于圆圈正右方。
// 此外，在两个黑色光斑之间及下方还散布着若干较暗淡的灰色
// 团块状结构。 图中包含两组紫色标记：一条垂直的紫色短线
// 段位于橙色圆圈与右侧较大黑色光斑之间；另一条水平的紫色
// 短线段位于右侧两个黑色光斑的中间偏上位置。这些紫色线段
// 可能用于指示特定方向或关联特征，但图中未提供明确图例说
// 明其物理含义。 图像左下角设有比例尺，由一条黑色水平线
// 段构成，线段上方标注“10 kpc”，表示该长度对应物理尺度10
// 千秒差距；线段下方标注“1.91"”，表示该长度在天球上的角
// 直径为1.91角秒。图像整体朝向为上北下南、左东右西。
// [figvision-cn] imgs/FRB20190711A_r_host.png
// 这是一张展示快速射电暴FRB20190711A宿主星系及其定位的天
// 文显微照片。图像采用反色灰度显示，背景为白色噪点纹理，
// 天体信号越强的区域颜色越深，最亮处呈现纯黑色。图像左下
// 角有一块不规则的黑色区域，代表探测器边缘或数据缺失部分。
// 在图像中央偏上位置，存在一个明亮的致密天体，其核心呈黑
// 色，周围被灰色光晕包围，这是FRB的宿主星系。该宿主星系
// 的中心位置由一对紫色的十字准线精确标出，其中垂直线段位
// 于天体正下方，水平线段位于天体右侧。围绕该紫色十字准线
// 的中心，绘制了一个红色的椭圆轮廓，表示FRB20190711A位置
// 的68%置信区间，该椭圆完全覆盖了宿主星系的明亮核心区域。
// 图像右上角有三行黑色文字标注：第一行为“FRB20190711A”，
// 第二行为“Gemini-S GMOS/r”，第三行为“ASKAP”。这表明图像
// 数据来源于双子南望远镜（Gemini-S）的GMOS相机r波段成像
// 以及ASKAP射电望远镜的定位数据。根据图注说明，图像的方
// 位为上北下南，左东右西。
// [figvision-cn] imgs/FRB20190714A_r_host.png
// 这是一张针对快速射电暴 FRB20190714A 宿主星系的显微天文
// 照片，图像采用反色灰度处理，即背景天空为白色，天体亮度
// 越高显示越黑。图像整体呈正方形像素化网格状。在画面中央
// 偏右位置，存在一个显著的暗色团块，代表宿主星系的光度分
// 布，其中心区域颜色最深接近纯黑，向外逐渐过渡为深灰色和
// 浅灰色，形态略呈不规则椭圆状。在星系团块的左上边缘区域，
// 叠加了一个红色的细线椭圆环，该椭圆环标记了快速射电暴
// FRB 的 68% 置信度定位范围。图像左侧中部有一条水平的紫
// 色粗短线，右侧下部有一条垂直的紫色粗短线，这两条线段共
// 同构成了十字准星的一部分，用于标示宿主星系的精确中心位
// 置。图像右上角有三行黑色文字标注，从上至下依次为“
// FRB20190714A”、“Pan-STARRS/r”和“ASKAP”，分别指代目标名
// 称、光学成像波段（Pan-STARRS r波段）以及射电观测设备（
// ASKAP）。图像左下角包含比例尺信息：上方是一条黑色水平
// 实线段，标注为“10 kpc”，表示物理距离；下方对应标注为“
// 2.64"”，表示角直径。整幅图展示了 FRB20190714A 的定位误
// 差椭圆与其宿主星系核心区域的相对空间关系，表明该射电暴
// 事件位于宿主星系内部靠近核心的位置。
// [figvision-cn] imgs/FRB20191001A_F160W_host.png
// 这是一张天文学领域的深空成像图，展示了快速射电暴
// FRB20191001A的宿主星系及其周围环境。图像整体为灰度反色
// 处理（即亮背景、暗前景），背景呈现颗粒状的噪点纹理。图
// 像右上角叠加有三行黑色粗体文字，从上至下依次为“
// FRB20191001A”、“HST/F160W”和“ASKAP”。图像的主体是位于
// 画面中右侧的一个双星系统或正在合并的星系对，由两个主要
// 的暗色团块组成。左侧的团块形状不规则，略呈椭圆状；右侧
// 的团块形状较圆，两者之间有弥散的暗物质连接。在左侧暗色
// 团块的边缘上方，有一个红色的空心椭圆圈，标记了快速射电
// 暴的位置。图像左下角设有一个黑色的水平比例尺线段，其下
// 方标注有“10 kpc”和“2.66"”，分别表示物理距离和角直径。
// 此外，图中还包含两条紫色的线条：一条较长的水平线位于左
// 侧团块的左边，另一条较短的垂直线位于两个团块之间偏下的
// 位置。
// [figvision-cn] imgs/FRB20200430A_J_host.png
// 该图像为单张天文观测显微照片，展示了快速射电暴
// FRB20200430A 的宿主星系。图像整体背景由灰度像素点阵构
// 成，呈现噪点状分布，中心区域存在一个明显的暗色天体结构。
// 图像右上角标注有黑色粗体文字“FRB20200430A”，其下方依次
// 为“MMT MMIRS/J”和“ASKAP”，表明数据来源分别为 MMT 望远
// 镜的 MMIRS/J 波段成像及 ASKAP 射电阵列定位结果。 图像
// 中心偏右位置有一个近似椭圆形的深色团块，代表宿主星系的
// 主体，颜色从中心纯黑向外渐变为深灰至浅灰，显示表面亮度
// 分布。在该深色团块右侧边缘叠加一个红色细线椭圆轮廓，表
// 示 FRB 68% 置信区间的本地化误差范围，椭圆长轴沿东北-西
// 南方向倾斜，短轴较短，覆盖区域约占总星系直径的三分之一。
// 在图像左侧中部有一条水平紫色短线段，位于宿主星系左方约
// 1.5 倍星系半径处；在图像底部中央偏右位置有一条垂直紫色
// 短线段，位于宿主星系正下方约 1 倍星系半径处。这两条紫
// 色线段共同构成十字准星标记，指示宿主星系的光学中心或参
// 考点，与图注中“purple crosshairs”对应。 图像左下角设有
// 比例尺：一条黑色实线横跨画面，上方标注“10 kpc”，下方标
// 注“3.59"”，表示该线段物理长度为 10 千秒差距，对应角尺
// 度 3.59 角秒，用于将图像像素转换为实际空间尺度。 整幅
// 图像无坐标轴，因属直接成像而非数据绘图。所有元素布局符
// 合天文学惯例：北向上、东向左。图像传达的核心信息是
// FRB20200430A 的精确位置（红椭圆）与其宿主星系（深色团
// 块+紫十字）的空间重合关系，证实该 FRB 起源于此星系内部，
// 且定位精度足以约束其在星系盘内的具体区域。
// [figvision-cn] imgs/FRB20200906A_r_host.png
// 这是一张展示快速射电暴FRB 20200906A宿主星系的天文显微
// 照片，图像采用反色灰度显示，即背景天空为白色，天体亮度
// 越高像素越黑。图像整体呈现为一个低分辨率的像素化网格结
// 构。在图像中央偏右位置，存在一个显著的黑色不规则团块，
// 这是宿主星系的形态，其形状大致呈椭圆形，长轴方向从左上
// 向右下倾斜，中心区域颜色最深（纯黑），向边缘逐渐过渡为
// 深灰色直至与背景融合。在该黑色星系团块的几何中心附近，
// 叠加了一个红色的空心椭圆环，代表该快速射电暴位置的68%
// 置信度误差椭圆。在红色椭圆的左侧和下方，分别有一条紫色
// 的水平短线段和一条紫色垂直短线段，这两条线段共同构成十
// 字准星，精确标记了宿主星系的中心位置。图像右上角有三行
// 黑色加粗无衬线字体文本，第一行为“FRB20200906A”，第二行
// 为“DES DR2 DECam”，第三行为“ASKAP”。图像左下角包含比例
// 尺信息：上方是一条黑色的水平实线段，标注文字为“10 kpc”；
// 在该线段正下方是对应的角尺度标注文字“1.94"”。根据图注
// 说明，图像方向为上北下南，左东右西。
// [figvision-cn] imgs/FRB20201124A_I_host.png
// 这是一张针对快速射电暴（FRB）宿主星系的成像图，属于天
// 文观测照片的负像处理形式。图像右上角标注了研究对象名称
// “FRB20201124A”，下方注明了观测设备为“Keck LRIS/I”以及
// 探测来源“CHIME”。图像中央显示一个深黑色的椭圆状天体结
// 构，代表宿主星系，其亮度分布从中心向外逐渐减弱，边缘呈
// 现弥散状过渡至背景噪声。该星系整体呈垂直方向拉长的椭圆
// 形，主轴大致沿南北方向延伸。在星系核心区域偏上位置，有
// 一个红色加号标记，指示FRB事件的空间定位点。图像右侧中
// 部有一条水平紫色短线段，正下方有一条垂直紫色短线段，二
// 者共同构成十字准线的一部分，用于标示方位或参考坐标，但
// 未闭合形成完整十字。左下角设有一条黑色比例尺线段，上方
// 标注“10 kpc”，下方标注“5.48"”，表明该线段对应的物理尺
// 度为10千秒差距，角尺度为5.48角秒。整幅图像以白色为背景，
// 天体结构以黑色及灰度渐变表现，符合天文图像处理中常见的
// 反转对比度风格，便于突出低表面亮度结构。根据图注说明，
// 此图中未显示68%置信度的椭圆定位区，因该FRB尚未达到毫角
// 秒级定位精度；同时，紫色十字准线在此图中仅部分展示，可
// 能用于辅助对齐或后续叠加分析。
// [figvision-cn] imgs/FRB20121102A_J_host.png
// 这是一张天文学显微照片，展示了快速射电暴（FRB）
// 20121102A的宿主星系区域。图像采用倒置灰度显示，其中白
// 色和浅灰色代表高辐射强度，黑色代表低辐射强度或背景噪声。
// 图像整体呈现模糊的云状结构，表明这是红外波段的观测数据，
// 分辨率受到衍射极限限制。 在图像的右上角，有三行加粗的
// 黑色文字标注。第一行为“FRB20121102A”，标识了该快速射电
// 暴的名称。第二行为“MMT MMIRS/J”，指明观测设备为多镜面
// 望远镜（MMT）及其近红外光谱成像仪（MMIRS），波段为J波
// 段。第三行为“Arecibo”，表示该FRB最初由阿雷西博射电望远
// 镜探测到。 图像中心偏右的位置有一个红色的十字标记（+），
// 其物理含义是FRB 20121102A的精确位置。由于该FRB具有毫角
// 秒级的定位精度，因此没有使用椭圆来表示误差范围，而是用
// 点状的十字标出。该红叉位于一团较亮的弥散光斑结构中，暗
// 示FRB可能起源于该宿主星系的某个特定区域。 在图像的中部，
// 有两条紫色的线段，分别呈水平和垂直方向排列，它们构成了
// 紫色十字准线的一部分，用于标示宿主星系的中心位置。水平
// 线段位于红色十字标记的左侧，垂直线段位于红色十字标记的
// 正下方。这两条线段与红色十字共同定义了FRB相对于宿主星
// 系中心的偏移关系。 在图像的左下角，有一条黑色的水平比
// 例尺线段。线段上方标注有“5 kpc”，表示该线段长度对应的
// 物理尺度为5千秒差距；线段下方标注有“1.55"”，表示该线段
// 在天空中的角距离为1.55角秒。这一比例尺提供了将图像上的
// 像素距离转换为物理距离或角距离的定量依据。 根据图注信
// 息，该图像的定向为北方朝上，东方朝左。从图中可见，红色
// 十字标记（FRB位置）相对于紫色十字准线（宿主星系中心）
// 略微偏向东北方向（即图像的右上方向）。整个宿主星系表现
// 为一个不规则的、延展的发光结构，周围散布着一些更暗的背
// 景源或前景源。
// 区域，并未直接落在星系最亮的光核中心。 辅助标记：图像
// 左侧中部和底部各有一条紫色的短粗直线段，分别呈水平和垂
// 直放置，用于指示方位或作为测量参考线。 文字标注： 图像
// 右上角有三行黑色大号无衬线字体文本，从上至下依次为：“
// FRB20180916B”（目标名称）、“HST/F110W”（观测设备与滤光
// 片波段）、“CHIME”（发现该信号的射电望远镜阵列名称）。
// 图像左下角有上述提到的比例尺数值“5 kpc”和“7.61"”。 结
// 论与趋势：该图像展示了FRB 20180916B与其宿主星系的相对
// 位置关系。通过高精度的光学成像，确认了该快速射电暴起源
// 于一个螺旋星系内部，且具体位置偏离星系中心，位于旋臂结
// 构中。
// 天体的名称；“DeCALS DR8 DECam/r”说明了图像的观测来源（
// Dark Energy Camera Legacy Survey第8版数据）及使用的r波
// 段滤光片；“ASKAP”指出了进行射电定位的望远镜阵列。根据
// 常规天文图像规范，该图的朝向为上北下南，左东右西。
// 两条线段并未完全交叉于一点，而是分别位于中心点的左侧和
// 下方，共同指向该宿主星系的精确位置。其次是一个红色的空
// 心椭圆，该椭圆呈倾斜状态，长轴从左下角延伸至右上角，将
// 中央的宿主星系及紫色十字准线完全包围在内。根据图注信息，
// 这个红色椭圆代表了该快速射电暴位置的68%置信区间。 图像
// 左下角设有一个比例尺。上方是一条黑色的水平实线，旁边标
// 注有“10 kpc”，表示该线段长度对应物理距离10千秒差距。在
// 该黑线下方标注有“1.67"”，表示该线段对应的角直径为1.67
// 角秒。
// 能因排版或裁剪所致；实际含义仍为标示宿主星系中心。 左
// 下角标注比例尺：一条黑色水平线段上方标有“10 kpc”，下方
// 标有“2.27"”，表示该线段长度对应物理尺度 10 千秒差距（
// kpc）和角尺度 2.27 角秒（arcseconds），用于将图像像素
// 转换为真实空间尺寸。 右上角有三行加粗黑色文字标题：“
// FRB20190102C”、“VLT FORS2/I”、“ASKAP”，分别标识目标源
// 名称、光学成像设备与滤光片（I 波段）、射电望远镜阵列。
// 颜色映射与通道： 图像为单通道灰度图，无彩色合成。亮度
// 反转处理：原始数据中较亮的天体区域在图中显示为深色（接
// 近黑），背景噪声为浅灰色至白色。这种负像处理常用于突出
// 低表面亮度结构。 红色椭圆为矢量叠加图形，非成像数据部
// 分，颜色恒定，线条粗细均匀。 紫色线段亦为矢量叠加，颜
// 色恒定，宽度一致。 趋势与结论： 宿主星系被成功识别并定
// 位于光学图像中心区域，其形态符合典型矮星系或不规则星系
// 特征。 FRB 定位椭圆完全覆盖星系核心区域，表明射电信号
// 很可能起源于该星系内部，支持其为宿主星系的结论。 比例
// 尺显示该星系物理尺度约为数十 kpc 量级（从图像跨度估算），
// 属于中等大小星系。 使用 I 波段成像有助于减少尘埃消光影
// 响，更清晰地揭示恒星分布结构。 ASKAP 提供的定位精度足
// 以将 FRB 限制在单个星系内，但未精确到星团或恒星形成区
// 级别。 所有标注文字及符号均已涵盖，无其他隐藏元素。图
// 像整体传达的核心信息是：FRB 20190102C 的空间位置与其宿
// 主星系高度吻合，且该星系可通过光学手段清晰辨识。
// 明此处光强最强，形态上大致呈东西向延伸的不规则形状。背
// 景区域则由浅灰色和白色的噪点状像素构成，模拟了天空背景
// 噪声。 在星系图像之上叠加了两个关键的几何标记符号： 一
// 个红色的十字准星（+号），位于星系中心偏右的一个高亮（
// 深黑）区域附近。根据图注信息，这个红色十字标记代表了宿
// 主星系的精确位置。 一对紫色的线条，构成了一个类似直角
// 坐标轴或误差框的结构。一条垂直的紫色线段位于红色十字的
// 左上方，另一条水平的紫色线段位于红色十字的右侧并延伸至
// 星系边缘。结合图注中关于"68% confidence interval”的描
// 述，这两条紫色线段实际上勾勒出了 FRB 定位的置信区间范
// 围（通常表现为椭圆，但在此图中可能以正交投影线或特定边
// 界形式展示），指示了 FRB 信号来源的空间不确定性范围。
// 整幅图像传达了以下结论：通过 SOAR 望远镜的光学成像与
// FAST 射电数据的结合，研究人员成功将 FRB 20190520B 定位
// 到了其宿主星系内的特定区域（红色十字处），并利用紫色标
// 记展示了定位精度（68% 置信度）。图像的朝向遵循天文惯例，
// 即北方朝上，东方朝左。
// 尺标识：一条黑色短线下方标注“4.66"”（即4.66角秒），其
// 正上方另有一条稍长黑线标注“10 kpc”，表示该长度对应物理
// 尺度10千秒差距。由此可推算出图像空间分辨率约为每角秒约
// 2.15 kpc。 从视觉趋势看，红色定位点落在星系外围盘面上，
// 未处于最亮核区，暗示该FRB可能起源于恒星形成活跃区或金
// 属丰度较低的外围环境。整个图像无其他明显天体结构干扰，
// 主要聚焦于宿主星系本体及其FRB定位关系。
// 可能用于指示特定方向或关联特征，但图中未提供明确图例说
// 明其物理含义。 图像左下角设有比例尺，由一条黑色水平线
// 段构成，线段上方标注“10 kpc”，表示该长度对应物理尺度10
// 千秒差距；线段下方标注“1.91"”，表示该长度在天球上的角
// 直径为1.91角秒。图像整体朝向为上北下南、左东右西。
// 事件位于宿主星系内部靠近核心的位置。
// 度 3.59 角秒，用于将图像像素转换为实际空间尺度。 整幅
// 图像无坐标轴，因属直接成像而非数据绘图。所有元素布局符
// 合天文学惯例：北向上、东向左。图像传达的核心信息是
// FRB20200430A 的精确位置（红椭圆）与其宿主星系（深色团
// 块+紫十字）的空间重合关系，证实该 FRB 起源于此星系内部，
// 且定位精度足以约束其在星系盘内的具体区域。
// 秒级定位精度；同时，紫色十字准线在此图中仅部分展示，可
// 能用于辅助对齐或后续叠加分析。
#figure(scope: "parent", [#box(image("imgs/FRB20121102A_J_host.png", width: 24.5%)) #box(image("imgs/FRB20180301A_r_host.png", width: 24.5%)) #box(image("imgs/FRB20180916B_F110W_host_v2.png", width: 24.5%)) #box(image("imgs/FRB20180924B_r_host.png", width: 24.5%)) #box(image("imgs/FRB20181112A_r_host.png", width: 24.5%)) #box(image("imgs/FRB20190102C_I_host.png", width: 24.5%)) #box(image("imgs/FRB20190520B_r_host.png", width: 24.5%)) #box(image("imgs/FRB20190608B_F160W_host.png", width: 24.5%)) #box(image("imgs/FRB20190611B_r_host.png", width: 24.5%)) #box(image("imgs/FRB20190711A_r_host.png", width: 24.5%)) #box(image("imgs/FRB20190714A_r_host.png", width: 24.5%)) #box(image("imgs/FRB20191001A_F160W_host.png", width: 24.5%)) #box(image("imgs/FRB20200430A_J_host.png", width: 24.5%)) #box(image("imgs/FRB20200906A_r_host.png", width: 24.5%)) #box(image("imgs/FRB20201124A_I_host.png", width: 24.5%)) #box(image("imgs/FRB20210117A_z_host.png", width: 24.5%))
  ],
  caption: [
    Imaging gallery of the 23 FRB hosts included in our sample, with images oriented North up and East to the left. The host galaxies are marked by the purple crosshairs and the 68\% confidence interval FRB localizations are denoted in red by an ellipse. For the three FRBs with milliarcsecond-scale localizations (FRB 20121102A, #cite(<Marcote-17>, style: "aas_noparen.csl")\; FRB 20180916B, #cite(<Marcote_etal_2020>, style: "aas_noparen.csl")\; and FRB 20201124A, #cite(<Nimmo-22>, style: "aas_noparen.csl")) and one with $tilde 0.1"arcsec"$ localization (FRB 20190520B; #cite(<Niu-22>, style: "aas_noparen.csl")), the position is indicated by a plus sign. The facility or survey which discovered the FRB is also listed.
  ]
)
#<fig:imaging-gallery>

// [figvision-cn] imgs/FRB20210320C_r_host.png
// 这是一张天文观测图像（显微照片/成像图），采用反相灰度
// 显示，即背景为白色和浅灰色噪点，天体信号显示为深灰至黑
// 色。图像呈像素化，无坐标轴。图像顶部右侧有三行黑色粗体
// 文字标注，从上到下分别为“FRB20210320C”、“SOAR Goodman/
// r”和“ASKAP”。图像中心偏右的位置有一个深灰至黑色的不规
// 则斑块，边缘模糊，呈像素化扩散。该斑块中心叠加有一个红
// 色空心圆圈。图像左侧中间有一条水平的紫色粗线段，图像中
// 下方有一条垂直的紫色粗线段。图像左下角有一条黑色水平比
// 例尺，上方标注“10 kpc”，下方标注“2.34"”。该图传达的结
// 论是：ASKAP定位的快速射电暴FRB20210320C在SOAR Goodman/
// r波段成像中对应一个延展的宿主星系，红色圆圈标记了射电
// 暴的位置，比例尺表明该星系在图像上的张角为2.34角秒，对
// 应物理尺度为10千秒差距。
// [figvision-cn] imgs/FRB20210410D_r_host.png
// 这是一幅天文观测图像（显微/成像类子图），采用灰度显示，
// 像素化明显。图像背景为白色至浅灰色，天体信号呈深灰至黑
// 色。右上角有三行标注文字：第一行粗体“FRB20210410D”，第
// 二行“SOAR Goodman/g”，第三行粗体“MeerTRAP”。图像中央偏
// 右有一个深色团块，其中心被一个红色椭圆圈出，该椭圆长轴
// 水平、短轴竖直。中央偏左有一个较暗的深色斑点；紧邻该斑
// 点右侧有一条水平的紫色线段。在中央深色团块正下方，有一
// 条竖直的紫色线段。图像右侧有一个大而深的黑色不规则团块，
// 其下方连着一个较小的深色团块。左下角有比例尺：一条黑色
// 水平线段，上方标注“10 kpc”，下方标注“3.99"”。该图传达
// 的趋势是：在给定天区中存在多个辐射源，红色椭圆标记了与
// FRB20210410D成协的候选体位置，紫色线段用于指示方位参考，
// 比例尺表明该区域的物理尺度约为10千秒差距。
// [figvision-cn] imgs/FRB20210807D_i_host.png
// 这是一张天文观测图像，属于叠加了定位标记的灰度星空图。
// 图像整体呈现为白底黑斑的负片效果，背景布满了像素化的噪
// 点，代表天空背景噪声。图中没有划分多个子图，而是一张单
// 一的视场图。 图像的主要内容如下： 右上角有三行黑色文字
// 标注：“FRB20210807D”为第一行，字号最大；“Pan-STARRS/i”
// 为第二行；“ASKAP”为第三行。这标明了该图观测的目标是快
// 速射电暴 FRB20210807D，背景图像来自 Pan-STARRS 巡天项
// 目的 i 波段，而定位信息来自 ASKAP 射电望远镜。 图像中
// 央偏右有一个巨大且形状不规则的黑色斑块，边缘模糊，中心
// 最黑，这是一个星系。 在该星系中心偏左的位置，有一个空
// 心橙红色圆圈，圈出了一个精确的点，这代表 ASKAP 探测到
// 的快速射电暴的射电定位位置。 在橙红色圆圈的左侧，有一
// 条水平的紫蓝色线段。 在图像右下方，有一个较小的黑色点
// 源，该点源被一条垂直的紫蓝色线段穿过。 图像中散布着多
// 个大小不一的黑色圆点，代表视场中的其他恒星或背景星系。
// 例如，图像正上方有一个较大的黑色圆点；目标星系左侧有两
// 颗靠得很近的黑点；左下角、右下角以及左侧边缘也有零星的
// 黑点。 左下角有一条水平的黑色比例尺，上方标注文字“10
// kpc”，下方标注文字“4.30”。这表示该图像在目标红移（4.30）
// 下的物理尺度，比例尺长度代表 10 千秒差距。
// [figvision-cn] imgs/FRB20211127I_r_host.png
// 这是一张天文观测图像，属于灰度显微/成像照片类型，展示
// 了快速射电暴FRB20211127I的光学对应体及其宿主星系环境。
// 图像整体为负片显示，即信号越强（越亮）的天体在图中显示
// 越黑。图像顶部右侧标有两行黑色粗体文字：“FRB20211127I”
// 和“SOAR Goodman/r ASKAP”，分别指示该快速射电暴的编号以
// 及所使用的望远镜（SOAR）和滤光片（Goodman/r）以及发现
// 该暴的射电望远镜（ASKAP）。图像中央是一个巨大的、大致
// 呈椭圆形的深黑色星系，其核心区域最黑且最密集，向外围逐
// 渐变淡并呈现不规则的晕和旋臂状结构。星系周围散布着几个
// 较小的黑色圆点，代表背景或前景恒星及其他天体。在星系核
// 心区域的正中心，有一个非常显眼的红色空心椭圆，这是科学
// 家用来标记快速射电暴FRB20211127I在宿主星系中精确位置的
// 光圈。此外，图像中还添加了两条蓝色粗线作为参考标记：一
// 条水平蓝线位于星系核心左侧稍偏上，指向左侧的一个小暗斑；
// 另一条垂直蓝线位于星系核心正下方，指向星系晕中的一个区
// 域。图像左下角给出了比例尺，上方标注“10 kpc”表示物理尺
// 度为10千秒差距，下方标注“10.80"”表示对应的视场角大小为
// 10.80角秒。右下角附近还有一个微小的黑色像素点，推测是
// 伪影或极暗弱天体。该图的主要目的是展示该快速射电暴在宿
// 主星系中的具体位置，从图中可以看出该爆发事件发生在星系
// 的核心区域。
// [figvision-cn] imgs/FRB20211203C_r_host.png
// 这是一幅天文观测图像（显微照片/成像图），展示了快速射
// 电暴FRB20211203C的光学对应体位置。图像为灰度图，背景为
// 带有噪点的灰白色像素，中央有一个深黑色、边缘模糊的不规
// 则圆形区域，代表目标天体（宿主星系或光学对应体）。在黑
// 色区域内部偏右下方，有一个橙红色空心圆圈标记，表示FRB
// 的位置。图像左上方有紫色水平线段，中央正下方有紫色垂直
// 线段，两者可能用于指示方向或作为参考标尺。右上角有黑色
// 文字标注“FRB20211203C”、“SOAR Goodman/r”和“ASKAP”，分
// 别表示目标名称、观测仪器/滤光片和射电望远镜。左下角有
// 比例尺，标注“10 kpc”和“2.03"”，表示图像的实际物理尺寸
// 和角尺寸。
// [figvision-cn] imgs/FRB20211212A_r_host.png
// 这是一张天文观测图像（显微/望远镜照片类）。图像为灰度
// 反色显示（背景为白色，天体信号越强颜色越深/越黑）。图
// 中没有子图编号。 文字标注：图像右上方有三行黑色粗体文
// 字，第一行为“FRB20211212A”，第二行为“SOAR Goodman/r”，
// 第三行为“ASKAP”。左下角标有黑色粗体文字“10 kpc”和“7.36
// "”，其下方有一条粗黑实线作为比例尺，表示该线段在物理尺
// 度上对应10千秒差距，在视角上对应7.36角秒。 图像内容与
// 布局：图像中心偏上位置为主星系，表现为一个呈椭圆形的弥
// 散状暗斑（灰度图），中心区域最黑（信号最强），向外逐渐
// 变淡。在主星系中心最黑区域的右下方边缘，叠加了一个橙红
// 色的空心圆圈，用于标记特定位置（FRB位置）。在主星系右
// 侧，有一个孤立的、较小的圆形黑色斑点（可能是伴星系或背
// 景/前景天体）。在主星系中心左侧，有一条水平的紫色粗实
// 线，长度与比例尺大致相当，似乎平行于主星系的长轴或用于
// 标识特定方向。在主星系下方偏右位置，有一条垂直的紫色粗
// 实线，长度明显长于水平紫线。 趋势/结论：图像展示了一个
// 宿主星系及其附近天体，通过红色圆圈精确定位了快速射电暴
// FRB20211212A在星系内的位置，并提供了10 kpc和7.36角秒的
// 比例尺以供尺度参考。
// [figvision-cn] imgs/FRB20211203C_r_host.png
// 这是一幅天文观测图像（显微照片/成像图），展示了快速射
// 电暴FRB20211203C的光学对应体位置。图像为灰度图，背景为
// 带有噪点的灰白色像素，中央有一个深黑色、边缘模糊的不规
// 则圆形区域，代表目标天体（宿主星系或光学对应体）。在黑
// 色区域内部偏右下方，有一个橙红色空心圆圈标记，表示FRB
// 的位置。图像左上方有紫色水平线段，中央正下方有紫色垂直
// 线段，两者可能用于指示方向或作为参考标尺。右上角有黑色
// 文字标注“FRB20211203C”、“SOAR Goodman/r”和“ASKAP”，分
// 别表示目标名称、观测仪器/滤光片和射电望远镜。左下角有
// 比例尺，标注“10 kpc”和“2.03"”，表示图像的实际物理尺寸
// 和角尺寸。
// 比例尺以供尺度参考。
#figure(scope: "parent", [#box(image("imgs/FRB20210320C_r_host.png", width: 24.5%)) #box(image("imgs/FRB20210410D_r_host.png", width: 24.5%)) #box(image("imgs/FRB20210807D_i_host.png", width: 24.5%)) #box(image("imgs/FRB20211127I_r_host.png", width: 24.5%)) #box(image("imgs/FRB20211203C_r_host.png", width: 24.5%)) #box(image("imgs/FRB20211212A_r_host.png", width: 24.5%)) #box(image("imgs/FRB20220105A_z_host.png", width: 24.5%))

  ],
  caption: [Figure 1 (Cont.).],
  numbering: none
)
// [figvision-cn] imgs/FRB20210320C_r_host.png
// 这是一张天文观测图像（显微照片/成像图），采用反相灰度
// 显示，即背景为白色和浅灰色噪点，天体信号显示为深灰至黑
// 色。图像呈像素化，无坐标轴。图像顶部右侧有三行黑色粗体
// 文字标注，从上到下分别为“FRB20210320C”、“SOAR Goodman/
// r”和“ASKAP”。图像中心偏右的位置有一个深灰至黑色的不规
// 则斑块，边缘模糊，呈像素化扩散。该斑块中心叠加有一个红
// 色空心圆圈。图像左侧中间有一条水平的紫色粗线段，图像中
// 下方有一条垂直的紫色粗线段。图像左下角有一条黑色水平比
// 例尺，上方标注“10 kpc”，下方标注“2.34"”。该图传达的结
// 论是：ASKAP定位的快速射电暴FRB20210320C在SOAR Goodman/
// r波段成像中对应一个延展的宿主星系，红色圆圈标记了射电
// 暴的位置，比例尺表明该星系在图像上的张角为2.34角秒，对
// 应物理尺度为10千秒差距。
// [figvision-cn] imgs/FRB20210410D_r_host.png
// 这是一幅天文观测图像（显微/成像类子图），采用灰度显示，
// 像素化明显。图像背景为白色至浅灰色，天体信号呈深灰至黑
// 色。右上角有三行标注文字：第一行粗体“FRB20210410D”，第
// 二行“SOAR Goodman/g”，第三行粗体“MeerTRAP”。图像中央偏
// 右有一个深色团块，其中心被一个红色椭圆圈出，该椭圆长轴
// 水平、短轴竖直。中央偏左有一个较暗的深色斑点；紧邻该斑
// 点右侧有一条水平的紫色线段。在中央深色团块正下方，有一
// 条竖直的紫色线段。图像右侧有一个大而深的黑色不规则团块，
// 其下方连着一个较小的深色团块。左下角有比例尺：一条黑色
// 水平线段，上方标注“10 kpc”，下方标注“3.99"”。该图传达
// 的趋势是：在给定天区中存在多个辐射源，红色椭圆标记了与
// FRB20210410D成协的候选体位置，紫色线段用于指示方位参考，
// 比例尺表明该区域的物理尺度约为10千秒差距。
// [figvision-cn] imgs/FRB20210807D_i_host.png
// 这是一张天文观测图像，属于叠加了定位标记的灰度星空图。
// 图像整体呈现为白底黑斑的负片效果，背景布满了像素化的噪
// 点，代表天空背景噪声。图中没有划分多个子图，而是一张单
// 一的视场图。 图像的主要内容如下： 右上角有三行黑色文字
// 标注：“FRB20210807D”为第一行，字号最大；“Pan-STARRS/i”
// 为第二行；“ASKAP”为第三行。这标明了该图观测的目标是快
// 速射电暴 FRB20210807D，背景图像来自 Pan-STARRS 巡天项
// 目的 i 波段，而定位信息来自 ASKAP 射电望远镜。 图像中
// 央偏右有一个巨大且形状不规则的黑色斑块，边缘模糊，中心
// 最黑，这是一个星系。 在该星系中心偏左的位置，有一个空
// 心橙红色圆圈，圈出了一个精确的点，这代表 ASKAP 探测到
// 的快速射电暴的射电定位位置。 在橙红色圆圈的左侧，有一
// 条水平的紫蓝色线段。 在图像右下方，有一个较小的黑色点
// 源，该点源被一条垂直的紫蓝色线段穿过。 图像中散布着多
// 个大小不一的黑色圆点，代表视场中的其他恒星或背景星系。
// 例如，图像正上方有一个较大的黑色圆点；目标星系左侧有两
// 颗靠得很近的黑点；左下角、右下角以及左侧边缘也有零星的
// 黑点。 左下角有一条水平的黑色比例尺，上方标注文字“10
// kpc”，下方标注文字“4.30”。这表示该图像在目标红移（4.30）
// 下的物理尺度，比例尺长度代表 10 千秒差距。
// [figvision-cn] imgs/FRB20211127I_r_host.png
// 这是一张天文观测图像，属于灰度显微/成像照片类型，展示
// 了快速射电暴FRB20211127I的光学对应体及其宿主星系环境。
// 图像整体为负片显示，即信号越强（越亮）的天体在图中显示
// 越黑。图像顶部右侧标有两行黑色粗体文字：“FRB20211127I”
// 和“SOAR Goodman/r ASKAP”，分别指示该快速射电暴的编号以
// 及所使用的望远镜（SOAR）和滤光片（Goodman/r）以及发现
// 该暴的射电望远镜（ASKAP）。图像中央是一个巨大的、大致
// 呈椭圆形的深黑色星系，其核心区域最黑且最密集，向外围逐
// 渐变淡并呈现不规则的晕和旋臂状结构。星系周围散布着几个
// 较小的黑色圆点，代表背景或前景恒星及其他天体。在星系核
// 心区域的正中心，有一个非常显眼的红色空心椭圆，这是科学
// 家用来标记快速射电暴FRB20211127I在宿主星系中精确位置的
// 光圈。此外，图像中还添加了两条蓝色粗线作为参考标记：一
// 条水平蓝线位于星系核心左侧稍偏上，指向左侧的一个小暗斑；
// 另一条垂直蓝线位于星系核心正下方，指向星系晕中的一个区
// 域。图像左下角给出了比例尺，上方标注“10 kpc”表示物理尺
// 度为10千秒差距，下方标注“10.80"”表示对应的视场角大小为
// 10.80角秒。右下角附近还有一个微小的黑色像素点，推测是
// 伪影或极暗弱天体。该图的主要目的是展示该快速射电暴在宿
// 主星系中的具体位置，从图中可以看出该爆发事件发生在星系
// 的核心区域。

== Spectroscopy
<sec:spectra>

We obtained long-slit optical spectroscopy for the host galaxies of seven FRBs (20180916B, 20210320C, 20210807D, 20211127I, 20211203C, 20211212A, and 20220105A) and one mask observation for the field of FRB 20190520B (with one of the slits centered on the host galaxy center, used in this work). The observations were taken with Keck/LRIS (PIs Miller, Blanchard; Programs O304, O314), Keck/DEIMOS (PI Blanchard; Programs O287, O300), and SOAR/Goodman (PI Fong; Programs SOAR2021A-010, SOAR2021B-002). We designed the observations to span wavelengths of $lambda approx$ 5000-10000Å. We list this new spectroscopy, along with the gratings/grisms, and slit widths for each data set in @tab:spectra.

For our subsequent host galaxy modeling (@sec:prospector), we require a S/N $gt.tilde$ 3/Å~in the continuum across most of the wavelength range. The slits were oriented to cover the center of the host galaxy and the center of the FRB position to search for possible anomalous emission at the FRB location. We manually inspected all of the spectra and found no additional continuum or line-emission detected at the FRB positions.

For the data taken with Keck, we obtained calibrations including arc lamps (Hg, Ne, Ar, Cd, Zn, Kr, Xe, or a subset of these), flat fields, bias frames, and spectrophotometric standard star spectra taken on the same night as the science data. For the SOAR data, we also obtained flat-field and arc lamp spectra (Hg, Ar, Ne) on the same night as the science data and at a similar airmass. In order to flux calibrate the SOAR data, we used spectrophotometric standards from the SOAR archive#footnote[#link("https://archive.lco.global")] that used the same spectral set-up and were observed as close to the date of the science observations as possible.

We reduced these data using the Python Spectroscopic Data Reduction Pipeline (`PypeIt`\; #cite(<pypeit:joss_pub>, style: "aas_noparen.csl")#cite(<pypeit:zenodo>, style: "aas_noparen.csl")). `PypeIt` performs bias-subtraction, flat-fielding, cosmic ray masking, and wavelength-calibration of the raw frames. After the initial processing to generate a calibrated 2D spectral image, the pipeline extracts 1D spectra using the standard Horne algorithm @Horne1986. At this step, we manually inspected the quality of the calibrated 1D and 2D spectra; in some cases, we implemented minor changes to default parameters to improve the extraction.

For instance, for SOAR/Goodman spectra, we include the flexure parameter `spec‘_method = boxcar` in the wavelength calibration module to account for instrumental flexure. In two cases, the host galaxy was too faint to be detected in the individual frames with the default S/N threshold settings and required us to lower `snr‘_thresh`#footnote[We note this was called `sig‘_thresh` in earlier versions.] in the object finding module to successfully identify the host trace. Finally, for two spectra, very strong emission lines in some of the host galaxies were misinterpreted as cosmic rays and masked in the extraction. If this was found to be the case during the manual inspection, we reran the pipeline with the profile masking turned off (`use_2dmodel_mask = False`).

After extraction, we apply relative flux calibration using spectrophotometric standard spectra. If multiple exposures were taken, we reduced each exposure separately and co-added the wavelength-calibrated 1D spectra. The final error spectrum generated by the pipeline is a combination of uncertainties propagated from each calibration step and shot noise in the electron counts. We then perform telluric correction on the co-added spectra using the corresponding atmospheric grids for each observatory site and apply correction for Galactic extinction according to the #cite(<Fitzpatrick:2007>, form: "prose") extinction law.

To measure a preliminary redshift, we use the XSpecGUI viewer from `linetools` @linetools included in `PypeIt` to determine the redshift of the host galaxies. This tool overlays the locations of common lines onto the observed spectrum after specifying a fiducial redshift. We adjust the redshift estimate until major features are matched. In particular, we base our initial redshift determination on the Balmer lines (H$alpha$, H$beta$), \[O iii\]$lambda 4959 , 5007$ emission features, and Ca II H&K absorption features when available. These serve as input redshifts for our full galaxy modeling (@sec:prospector).

We supplement our new spectra with those of 13 FRB hosts previously published in the literature. These include FRBs 20180301A, 20200430A, 20200906A #cite(<bha-22>), 20180924B #cite(<Bannister-19>), 20181112A #cite(<Prochaska-19>), 20190102C, 20190608B #cite(<Bhandari-20>), 20190611B, 20190714A, 20191001A #cite(<Heintz-20>), 20201124A #cite(<Fong-21>), 20210117A @Bhandari_210117, and 20210410D #cite(<Caleb-23>). These fully-reduced datasets are publicly available and accessible via the F4 Github repository (`FRBs/FRB`\; #cite(<F4_repo>, style: "aas_noparen.csl")). In addition, we retrieved archival Gemini North/GMOS spectroscopy for the host of FRB 20121102A (first published in #cite(<Tendulkar-17>, style: "aas_noparen.csl"), PI Tendulkar, Program GN-2016B-DD-2) from the Gemini Observatory Archive#footnote[#link("https://archive.gemini.edu")] and reduced the data with `PypeIt` as described above. As this host is faint, we reduced the S/N threshold so the host trace would be detectable in the individual frames and turned off the profile masking module.

In total, our sample comprises 22 FRB hosts with usable spectroscopy. Details of these observations and those taken from the literature are presented in @tab:spectra. We use all of these spectra in the modeling (@sec:prospector), with the exception of FRB 20190711A, which has insufficient S/N to include in the fitting. In #ref(<fig:new-spectra>), we show the spectra of all new observations presented in this work with major lines denoted and organized by chemical species (see @sec:prospector for more details on the normalization process).

#figure(scope: "parent", [#set text(size: 8.3pt)
  #table(
    stroke: none,
    columns: 8,
    inset: (y: 1.5pt),
    align: (left,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    [FRB], [Facility], [Instrument], [Observation Date], [Grating/Grism], [Slit Width], [Program ID], [Reference],
    table.hline(stroke: 0.5pt),
    [], [], [], [], [], [\[$"arcsec"$\]], [], [],
    [20121102A], [Gemini North], [GMOS], [2016 Nov 09 UT], [R400], [1.0], [GN-2016B-DD-2], [1],
    [20180301A], [Keck], [DEIMOS], [2020 Sept 17 UT], [600ZD], [1.0], [O298], [2],
    [20180916B], [Keck], [LRIS], [2020 Aug 18 UT], [R400/8500, B400/3400], [1.0], [O304], [This Work],
    [20180924B], [VLT], [MUSE], [2018 Nov 05 UT], [VPHG], [IFU], [2101.A-5005], [3],
    [20181112A], [VLT], [FORS2], [2018 Dec 05 UT], [GRIS\_300I], [1.0], [0102.A-0450(A)], [4],
    [20190102C], [VLT], [FORS2], [2019 Mar 25 UT], [GRIS\_300I], [1.3], [0102.A-0450(A)], [5],
    [20190520B], [Keck], [DEIMOS], [2022 Aug 28 UT], [600ZD], [1.0], [O287], [This Work],
    [20190608B], [SDSS 2.5-M], [SDSS], [2001 Oct 21 UT], [-], [-], [-], [5],
    [20190611B], [VLT], [FORS2], [2019 July 12 UT], [GRIS\_300I], [1.3], [0103.A-0101(A)], [6],
    [20190714A], [Keck], [LRIS], [2020 Jan 28 UT], [R600/7500], [1.0], [U180], [6],
    [20191001A], [Gemini South], [GMOS], [2019 Oct 04 UT], [R400], [1.0], [GS-2019B-Q-132], [6],
    [20200430A], [Keck], [DEIMOS], [2020 June 07 UT], [600ZD], [1.0], [E353], [2],
    [20200906A], [Keck], [DEIMOS], [2020 Sept 17 UT], [600ZD], [0.7], [O298], [2],
    [20201124A], [MMT], [Binospec], [2021 Apr 03 UT], [270l], [1.0], [UAO-G195-21A], [7],
    [20210117A], [VLT], [FORS2], [2021 Sept 06 UT], [GRIS\_300I], [1.0], [105.204W.003], [8],
    [20210320C], [SOAR], [Goodman], [2021 Apr 05 UT], [R400, M2], [1.0], [SOAR2021A-010], [This Work],
    [20210410D], [Gemini South], [GMOS], [2021 Oct 14 UT], [R400], [1.0], [GS-2021B-Q-138], [9],
    [20210807D], [Keck], [LRIS], [2021 Aug 11 UT], [R400/8500, B400/3400], [1.0], [O314], [This Work],
    [20211127I], [SOAR], [Goodman], [2022 Jan 01 UT], [R400, M2], [1.0], [SOAR2021B-002], [This Work],
    [20211203C], [SOAR], [Goodman], [2022 Feb 01 UT], [R400, M2], [1.0], [SOAR2021B-002], [This Work],
    [20211212A], [SOAR], [Goodman], [2021 Dec 08 UT], [R400, M2], [1.0], [SOAR2021B-002], [This Work],
    [20220105A], [Keck], [DEIMOS], [2022 Mar 31 UT], [600ZD], [1.0], [O300], [This Work],
    table.hline(stroke: 0.8pt),
  )], caption: [FRB Host Galaxy Spectroscopy Details ]
  , kind: table
  )
<tab:spectra>

// [figvision-cn] imgs/new_spectra_3x3.jpg
// 这是一幅包含 8 个子图（分别标注为 a 至 h）的光谱图阵列，
// 展示了 8 个不同快速射电暴（FRB）宿主星系的光学光谱观测
// 结果。所有子图的横轴均为观测波长 λ [Å]，纵轴均为流量密
// 度 Fν [μJy]。每个子图中，蓝色实线代表观测到的光谱，底
// 部附近的黑色实线代表对应的测量不确定度。子图右上角标注
// 了望远镜/仪器名称及 Prospector 导出的红移 z 值。主要发
// 射线和吸收线通过彩色竖线标注：巴耳末线为绿色，氧线为蓝
// 色，氮线为橙色，硫线为紫色，钙线为粉色。 子图 a（左上）：
// FRB 20180916B，望远镜为 Keck/LRIS，z=0.0327。横轴范围
// 约 6000-7600 Å，纵轴范围 0-3000 μJy。图中标注了绿色的
// Hα、橙色的 [NII] 和紫色的 [SII] 发射线。光谱在 Hα 处有
// 一个明显的尖峰，流量超过 2500 μJy。 子图 b（中上）：
// FRB 20190520B，望远镜为 Keck/DEIMOS，z=0.2417。横轴范
// 围约 6000-9300 Å，纵轴范围 -40 至 120 μJy。标注了蓝色
// 的 [OIII]、绿色的 Hα、紫色的 [SII]。光谱在 [OIII] 和 H
// α 处有较宽的发射特征，Hα 峰值约 80 μJy。 子图 c（右上）：
// FRB 20210320C，望远镜为 SOAR/Goodman，z=0.2976。横轴范
// 围约 5000-9000 Å，纵轴范围 0-700 μJy。标注了蓝色的 Hβ
// 和 [OIII]、橙色的 [NII]、紫色的 [SII] 以及绿色的 Hα。H
// α 发射线极强，峰值接近 650 μJy。 子图 d（左中）：FRB
// 20210807D，望远镜为 Keck/LRIS，z=0.1293。横轴范围约
// 4000-7800 Å，纵轴范围 0-1750 μJy。标注了粉色的 Ca H&K
// 吸收线、蓝色的 [OII] 和 [OIII]、绿色的 Hα、橙色的 [NII
// ] 和紫色的 [SII]。光谱呈现出明显的连续谱上升趋势，Hα
// 峰值为最高点。 子图 e（中中）：FRB 20211127I，望远镜为
// SOAR/Goodman，z=0.0469。横轴范围约 5000-7800 Å，纵轴范
// 围 0-16000 μJy。标注了蓝色的 Hβ 和 [OIII]、绿色的 Hα、
// 橙色的 [NII]、紫色的 [SII]。Hα 发射线非常强，峰值超过
// 14000 μJy。 子图 f（右中）：FRB 20211203C，望远镜为
// SOAR/Goodman，z=0.3437。横轴范围约 5500-9000 Å，纵轴范
// 围 0-500 μJy。标注了绿色的 Hγ、蓝色的 Hβ 和 [OIII]、橙
// 色的 [NII]、紫色的 [SII] 及绿色的 Hα。Hα 峰值为 450 μ
// Jy 左右。 子图 g（左下）：FRB 20211212A，望远镜为 SOAR
// /Goodman，z=0.0707。横轴范围约 5000-8000 Å，纵轴范围
// 0-4500 μJy。标注了橙色的 [NII]、绿色的 Hα 和紫色的 [
// SII]。Hα 发射线明显，峰值约 4200 μJy。 子图 h（中下）：
// FRB 20220105A，望远镜为 Keck/DEIMOS，z=0.2784。横轴范
// 围约 5500-9000 Å，纵轴范围 -20 至 140 μJy。标注了绿色
// 的 Hγ、蓝色的 [OII]、橙色的 [NII]、绿色的 Hα 和紫色的
// [SII]。Hα 峰值为 130 μJy 左右。 右下角图例说明了蓝色实
// 线为观测光谱，黑色实线为不确定度。整体趋势显示，这些光
// 谱在相应红移处均探测到了显著的发射线特征，尤其是 Hα 线，
// 这对于确认宿主星系的红移和研究其物理性质至关重要。
#figure(scope: "parent", image("imgs/new_spectra_3x3.jpg", width: 100%),
  caption: [
    New spectroscopic observations included in this work from SOAR/Goodman, Keck/DEIMOS, and Keck/LRIS. Major emission and absorption lines are denoted by colored lines: Balmer lines in green, oxygen lines in blue, nitrogen lines in orange, sulphur lines in purple, and calcium lines in pink. The spectra are normalized to the photometry in `Prospector`. The `Prospector`-derived redshifts are listed in each panel along with the facility/instrument of observation.
  ]
)
#<fig:new-spectra>

= HOST GALAXY MODELING
<sec:prospector>

To determine the host stellar population properties, we use the Bayesian modeling code `Prospector` #cite(<Johnson-21>). `Prospector` is a stellar population synthesis code that derives the posterior probability distributions of stellar population properties for a given observational data set. We use the stellar population synthesis library `python-fsps` to generate the model SEDs and `Prospector` to jointly fit the photometry and spectroscopy @Conroy2009 @Conroy2010. The posteriors are sampled using the dynamic nested sampling routine `dynesty` @Speagle2020. We initiate our fits with a number of assumptions. First, we employ a #cite(<Kroupa01>, form: "prose") initial mass function (IMF) and #cite(<KriekandConroy13>, form: "prose") dust attenuation curve. We also require that the fits roughly adhere to the #cite(<Gallazzi2005>, form: "prose") mass-metallicity ($M - Z$) relation by assuming a Gaussian scatter around the relationship with a standard deviation twice the measured scatter to allow for potential redshift evolution.

Unique to this work and the study of FRB host galaxies, we use a non-parametric SFH with a `continuity` prior (c.f., #cite(<Leja2019>, style: "aas_noparen.csl")) represented by eight age bins. While more computationally expensive than stellar population modeling with a parametric SFH, non-parametric modeling is more physically realistic due to the lack of strong priors dictating how and when galaxies form their mass #cite(<Leja-17>)@Leja2019. We provide further information on the implementation of the non-parametric SFH and the continuity prior in Appendix~#ref(<app:prospector>, supplement: none). Furthermore, we employ a spectral smoothing model, a model to normalize the spectrum to the photometry, a pixel outlier model to marginalize over poorly modeled noise, and a jitter model to deal with noise in the observed spectrum (see Appendix D of #cite(<Johnson-21>, style: "aas_noparen.csl") for further details of these procedures). For the spectrum normalization model, we use a 12$""^(upright("th"))$ order Chebyshev polynomial to fit the model spectrum to the observed spectrum.

In general, we fit for total mass formed (M$""_(upright(F))$), stellar metallicity (Z$""_(*)$), redshift ($z$), the dust attenuation of stellar light (`dust2`), the fraction of dust attenuation of young stellar light (`dust1‘_fraction`), the offset in slope from the #cite(<Calzetti00>, form: "prose") dust attenuation curve (`dust‘_index`), the velocity dispersion of the spectrum ($sigma_(upright("smooth"))$), and the ratios of star formation rate between each of the age bins (`logsfr‘_ratios`). If a spectrum is included, which is the case for all of our fits except the host of FRB 20190711A, we fit for the gas-phase metallicity (Z$""_(upright("gas"))$) and the gas ionization parameter ($U_(upright("min"))$). For galaxies with rest-frame infrared data $gt.eq$ 2 microns, we fit for the mass fraction of polycyclic aromatic hydrocarbons ($q_(upright("PAH"))$) and include a two-component active galactic nucleus (AGN) model in the fit: the fraction of total AGN luminosity relative to the bolometric stellar luminosity (`fagn`) and the optical depth of the AGN dust torus ($tau_(upright("AGN"))$). We list further details on the exact prior ranges and distributions used in Appendix #ref(<sec:-priors>, supplement: none).

To initiate the observations for fitting, we use the Galactic extinction-corrected photometry and spectroscopy and apply a mask to all spectra, which limits the rest-frame wavelength coverage to that of the MILES spectral library (masking everything above approximately 7500Å, rest-frame) and removes the Na #smallcaps[i]~D absorption lines from the fit. We apply additional masking as needed to regions where the error spectrum dominates the observed spectrum or to account for detector chip gaps. While the redshifts are known for each of the hosts in the sample (c.f., @sec:spectra), we treat redshift as a free but tightly constrained parameter, allowing a $plus.minus 0.01$ deviation from the initial value determined from our manual inspection of the spectral features. This freedom allows for some flexibility due to small uncertainties propagated from the data reduction and redshift determination. We report these redshifts in @tab:SPP_Results and in #ref(<fig:new-spectra>).

For the non-parametric SFH, we use eight age bins for the `continuity` SFH prior. #cite(<Leja2019>, form: "prose") found that varying the number of age bins between 4 and 14 bins produced little variation in the results. We choose eight bins to balance resolving features in the SFH (e.g., starburst events) and the computational resources required to run the models (which increase with the model dimensionality). The first two bins are fixed to 0--30 Myr and 30--100 Myr, and the maximum of the last bin is fixed to the age of the Universe at the redshift of the host. The remaining six bins are spaced evenly in logarithmic time. We then use the SFH combined with other parameters to determine a number of key inferred properties: the star formation rate integrated over the past 100~Myr ($upright("SFR")_(upright("0") - upright("100") thin upright("Myr"))$), the mass-weighted age ($t_(upright(m))$), dust attenuation of young and old stellar light ($A_(upright(V), upright("young"))$ and $A_(upright(V), upright("old"))$, respectively) and stellar mass (M$""_(*)$). In particular, the mass-weighted age is more sensitive to the older stars in the galaxy than light-weighted ages, which tend to be dominated by younger, brighter stars @Conroy2013. We allow `dust1‘_fraction`, to be a free parameter. We convert this to `dust1` by multiplying it by `dust2`. We then convert both `dust1` and `dust2` to extinction in $V$-band in magnitudes by multiplying by 1.086 to convert from optical depth to magnitudes of dust attenuation for $A_(upright(V), upright("young"))$ and $A_(upright(V), upright("old"))$, respectively. We use the total mass formed, combined with the SFH, IMF, and metallicity, to calculate stellar mass by multiplying M$""_F$ by the surviving mass fraction. For each of the inferred properties, we construct a posterior distribution and report the median, 16th, and 84th quantiles.

Finally, as part of the fits, we also self-consistently model and measure the strength of the emission lines using a nebular marginalization template. We refer the reader to Appendix~#ref(<app:prospector>, supplement: none) for further details on the `Prospector` fitting and conversions from fit to calculated parameters. We report the median of the posterior distributions of the stellar population properties for all 23 FRB hosts modeled, as well as the 68\% credible intervals in @tab:SPP_Results. As an example of our process, we present the SED for FRB 20211127I in @fig:exSED, while the remaining host SED fits are presented in Appendix~#ref(<sec:SEDs>, supplement: none).

#figure(scope: "parent", [#table(
    stroke: none,
    columns: 11,
    align: (left,center,center,center,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    [FRB], [$z$], [log(M$""_(upright(F))$/M$""_⊙$)], [log(Z$""_(*)$/Z$""_⊙$)], [A$""_(upright(V), upright("young"))$], [A$""_(upright(V), upright("old"))$], [AGN], [log(Z$""_(upright("gas"))$/Z$""_⊙$)], [$upright("SFR")_(upright("0") - upright("100") thin upright("Myr"))$], [log(M$""_(*)$/M$""_⊙$)], [$t_(upright(m))$],
    table.hline(stroke: 0.5pt),
    [], [], [], [], [\[mag\]], [\[mag\]], [], [], [\[M$""_⊙$~yr$""^(- 1)$\]], [], [\[Gyr\]],
    [20121102A], [$0.1931$], [$8.34_(- 0.11)^(+ 0.10)$], [$0.11_(- 0.11)^(+ 0.05)$], [$1.10_(- 0.26)^(+ 0.25)$], [$0.11_(- 0.06)^(+ 0.09)$], [N], [$- 0.62_(- 0.06)^(+ 0.07)$], [$0.05_(- 0.01)^(+ 0.02)$], [$8.14_(- 0.10)^(+ 0.09)$], [$5.71_(- 1.26)^(+ 0.96)$],
    [20180301A], [$0.3305$], [$9.84_(- 0.13)^(+ 0.12)$], [$- 0.99_(- 0.21)^(+ 0.27)$], [$1.18_(- 0.27)^(+ 0.28)$], [$0.31_(- 0.12)^(+ 0.17)$], [N], [$- 0.33_(- 0.04)^(+ 0.05)$], [$1.91_(- 0.55)^(+ 0.64)$], [$9.64_(- 0.11)^(+ 0.11)$], [$4.34_(- 1.29)^(+ 1.10)$],
    [20180916B], [$0.0330$], [$10.13_(- 0.05)^(+ 0.04)$], [$- 1.80_(- 0.11)^(+ 0.12)$], [$0.94_(- 0.25)^(+ 0.27)$], [$0.35_(- 0.01)^(+ 0.07)$], [N], [$0.18_(- 0.18)^(+ 0.18)$], [$0.04_(- 0.02)^(+ 0.03)$], [$9.91_(- 0.05)^(+ 0.03)$], [$7.73_(- 1.22)^(+ 0.86)$],
    [20180924B], [$0.3212$], [$10.60_(- 0.03)^(+ 0.02)$], [$- 0.14_(- 0.04)^(+ 0.04)$], [$1.10_(- 0.25)^(+ 0.30)$], [$0.11_(- 0.03)^(+ 0.03)$], [N], [$0.03_(- 0.08)^(+ 0.08)$], [$0.62_(- 0.24)^(+ 0.32)$], [$10.39_(- 0.02)^(+ 0.02)$], [$5.63_(- 0.75)^(+ 0.53)$],
    [20181112A], [$0.4755$], [$10.06_(- 0.08)^(+ 0.07)$], [$- 0.19_(- 0.32)^(+ 0.27)$], [$1.16_(- 0.31)^(+ 0.26)$], [$0.13_(- 0.08)^(+ 0.13)$], [N], [$- 0.17_(- 0.12)^(+ 0.12)$], [$1.54_(- 0.65)^(+ 0.99)$], [$9.87_(- 0.07)^(+ 0.07)$], [$3.82_(- 0.98)^(+ 0.84)$],
    [20190102C], [$0.2909$], [$9.90_(- 0.09)^(+ 0.09)$], [$- 1.15_(- 0.39)^(+ 0.37)$], [$1.09_(- 0.29)^(+ 0.29)$], [$0.20_(- 0.13)^(+ 0.18)$], [N], [$- 0.51_(- 0.51)^(+ 0.78)$], [$0.40_(- 0.11)^(+ 0.31)$], [$9.69_(- 0.11)^(+ 0.09)$], [$4.76_(- 1.47)^(+ 1.02)$],
    [20190520B], [$0.2417$], [$9.30_(- 0.11)^(+ 0.08)$], [$- 1.55_(- 0.29)^(+ 0.33)$], [$1.18_(- 0.33)^(+ 0.27)$], [$0.15_(- 0.10)^(+ 0.15)$], [N], [$- 0.68_(- 0.55)^(+ 0.45)$], [$0.04_(- 0.02)^(+ 0.04)$], [$9.08_(- 0.09)^(+ 0.08)$], [$5.27_(- 1.32)^(+ 1.02)$],
    [20190608B], [$0.1178$], [$10.78_(- 0.02)^(+ 0.02)$], [$- 0.03_(- 0.04)^(+ 0.04)$], [$1.09_(- 0.21)^(+ 0.22)$], [$0.08_(- 0.02)^(+ 0.02)$], [Y], [$0.02_(- 0.05)^(+ 0.05)$], [$7.03_(- 1.15)^(+ 1.43)$], [$10.56_(- 0.02)^(+ 0.02)$], [$7.13_(- 1.21)^(+ 0.70)$],
    [20190611B], [$0.3778$], [$9.77_(- 0.13)^(+ 0.13)$], [$- 0.84_(- 0.54)^(+ 0.55)$], [$1.20_(- 0.30)^(+ 0.28)$], [$0.45_(- 0.23)^(+ 0.35)$], [N], [$0.00_(- 0.42)^(+ 0.11)$], [$0.53_(- 0.26)^(+ 0.77)$], [$9.57_(- 0.12)^(+ 0.12)$], [$4.45_(- 1.34)^(+ 0.98)$],
    [20190711A], [$0.5218$], [$9.29_(- 0.25)^(+ 0.17)$], [$- 0.99_(- 0.54)^(+ 0.53)$], [$1.06_(- 0.28)^(+ 0.26)$], [$0.28_(- 0.16)^(+ 0.34)$], [N], [-], [$0.95_(- 0.50)^(+ 0.96)$], [$9.10_(- 0.23)^(+ 0.15)$], [$3.54_(- 1.36)^(+ 0.96)$],
    [20190714A], [$0.2365$], [$10.42_(- 0.05)^(+ 0.04)$], [$- 0.09_(- 0.55)^(+ 0.22)$], [$1.05_(- 0.27)^(+ 0.28)$], [$0.69_(- 0.19)^(+ 0.32)$], [Y], [$0.12_(- 0.21)^(+ 0.22)$], [$1.89_(- 0.72)^(+ 1.22)$], [$10.22_(- 0.04)^(+ 0.04)$], [$5.48_(- 1.02)^(+ 0.75)$],
    [20191001A], [$0.2342$], [$10.92_(- 0.09)^(+ 0.08)$], [$- 0.52_(- 0.10)^(+ 0.11)$], [$1.15_(- 0.25)^(+ 0.28)$], [$1.06_(- 0.10)^(+ 0.10)$], [N], [$- 0.08_(- 0.11)^(+ 0.11)$], [$18.28_(- 8.95)^(+ 17.24)$], [$10.73_(- 0.08)^(+ 0.07)$], [$3.89_(- 1.56)^(+ 1.68)$],
    [20200430A], [$0.1607$], [$9.51_(- 0.10)^(+ 0.07)$], [$- 0.99_(- 0.35)^(+ 0.32)$], [$1.08_(- 0.33)^(+ 0.32)$], [$0.38_(- 0.15)^(+ 0.14)$], [Y], [$- 0.12_(- 0.06)^(+ 0.06)$], [$0.11_(- 0.04)^(+ 0.06)$], [$9.30_(- 0.10)^(+ 0.07)$], [$5.99_(- 1.31)^(+ 0.96)$],
    [20200906A], [$0.3688$], [$10.57_(- 0.06)^(+ 0.05)$], [$- 0.39_(- 0.15)^(+ 0.18)$], [$1.09_(- 0.23)^(+ 0.27)$], [$0.20_(- 0.10)^(+ 0.10)$], [Y], [$- 0.26_(- 0.13)^(+ 0.14)$], [$4.93_(- 2.34)^(+ 3.46)$], [$10.37_(- 0.05)^(+ 0.05)$], [$4.30_(- 1.11)^(+ 0.86)$],
    [20201124A], [$0.0980$], [$10.43_(- 0.05)^(+ 0.05)$], [$- 0.58_(- 0.11)^(+ 0.11)$], [$1.25_(- 0.25)^(+ 0.27)$], [$0.73_(- 0.10)^(+ 0.10)$], [Y], [$0.18_(- 0.11)^(+ 0.19)$], [$2.72_(- 1.22)^(+ 1.65)$], [$10.22_(- 0.05)^(+ 0.05)$], [$6.13_(- 1.16)^(+ 0.95)$],
    [20210117A], [$0.2145$], [$8.80_(- 0.07)^(+ 0.05)$], [$- 1.82_(- 0.12)^(+ 0.18)$], [$1.19_(- 0.32)^(+ 0.26)$], [$0.05_(- 0.03)^(+ 0.06)$], [N], [$- 0.30_(- 0.08)^(+ 0.07)$], [$0.02_(- 0.01)^(+ 0.01)$], [$8.59_(- 0.06)^(+ 0.05)$], [$5.01_(- 1.21)^(+ 0.95)$],
    [20210320C], [$0.2796$], [$10.57_(- 0.06)^(+ 0.06)$], [$- 0.82_(- 0.17)^(+ 0.16)$], [$1.26_(- 0.26)^(+ 0.26)$], [$0.64_(- 0.17)^(+ 0.15)$], [N], [$0.01_(- 0.16)^(+ 0.12)$], [$3.51_(- 1.45)^(+ 2.44)$], [$10.37_(- 0.06)^(+ 0.05)$], [$4.56_(- 1.15)^(+ 0.99)$],
    [20210410D], [$0.1415$], [$9.70_(- 0.06)^(+ 0.05)$], [$- 1.04_(- 0.27)^(+ 0.19)$], [$1.14_(- 0.30)^(+ 0.28)$], [$0.39_(- 0.11)^(+ 0.13)$], [N], [$0.03_(- 0.23)^(+ 0.26)$], [$0.03_(- 0.01)^(+ 0.03)$], [$9.47_(- 0.05)^(+ 0.05)$], [$6.78_(- 1.48)^(+ 1.02)$],
    [20210807D], [$0.1293$], [$11.20_(- 0.02)^(+ 0.02)$], [$- 0.52_(- 0.05)^(+ 0.04)$], [$1.08_(- 0.15)^(+ 0.17)$], [$0.04_(- 0.03)^(+ 0.03)$], [Y], [$- 0.26_(- 0.07)^(+ 0.07)$], [$0.63_(- 0.17)^(+ 0.18)$], [$10.97_(- 0.02)^(+ 0.02)$], [$8.36_(- 1.84)^(+ 2.25)$],
    [20211127I], [$0.0469$], [$9.58_(- 0.02)^(+ 0.08)$], [$- 0.53_(- 0.02)^(+ 0.03)$], [$1.22_(- 0.31)^(+ 0.25)$], [$0.06_(- 0.01)^(+ 0.01)$], [Y], [$0.29_(- 0.12)^(+ 0.13)$], [$35.83_(- 1.46)^(+ 1.02)$], [$9.48_(- 0.02)^(+ 0.06)$], [$3.85_(- 3.65)^(+ 2.13)$],
    [20211203C], [$0.3437$], [$9.90_(- 0.10)^(+ 0.09)$], [$0.00_(- 0.19)^(+ 0.12)$], [$1.08_(- 0.25)^(+ 0.26)$], [$0.04_(- 0.02)^(+ 0.04)$], [N], [$- 0.25_(- 0.14)^(+ 0.15)$], [$15.91_(- 2.98)^(+ 2.82)$], [$9.76_(- 0.09)^(+ 0.07)$], [$2.47_(- 1.25)^(+ 2.00)$],
    [20211212A], [$0.0707$], [$10.49_(- 0.07)^(+ 0.06)$], [$- 0.77_(- 0.12)^(+ 0.11)$], [$1.19_(- 0.27)^(+ 0.26)$], [$0.19_(- 0.03)^(+ 0.04)$], [N], [$0.20_(- 0.26)^(+ 0.17)$], [$0.73_(- 0.39)^(+ 0.62)$], [$10.28_(- 0.06)^(+ 0.05)$], [$5.83_(- 1.16)^(+ 1.05)$],
    [20220105A], [$0.2784$], [$10.22_(- 0.07)^(+ 0.06)$], [$- 0.81_(- 0.14)^(+ 0.16)$], [$1.15_(- 0.28)^(+ 0.26)$], [$0.76_(- 0.17)^(+ 0.15)$], [Y], [$- 0.14_(- 0.13)^(+ 0.13)$], [$0.42_(- 0.19)^(+ 0.31)$], [$10.01_(- 0.07)^(+ 0.05)$], [$5.67_(- 1.24)^(+ 0.73)$],
    table.hline(stroke: 0.8pt),
  )], caption: [Stellar Population Properties ]
  , kind: table
  )
<tab:SPP_Results>

// [figvision-cn] imgs/FRB20211127I_SED_final.png
// 该图由上下两个面板组成，展示 FRB 20211127I 宿主星系的
// 示例光谱能量分布（SED）。整体标题为“FRB 20211127I”。
// 上方面板（Top panel）：这是一个光谱与测光联合拟合的对
// 数-线性坐标图。底部横轴为观测波长（Observed Wavelength
// [Å]），范围 5000 至 50000 Å；顶部横轴为静止系波长（
// Rest-Frame Wavelength [Å]），范围 10000 至 40000 Å。纵
// 轴为比通量 Fν [μJy]，对数刻度，范围 10^2 至 10^4 μJy。
// 图中包含以下元素： 浅蓝色实线表示观测光谱，浅灰色实线
// （围绕观测光谱的带状区域）表示观测光谱的误差谱；二者在
// 5000-8000 Å 范围内清晰可见，8000 Å 之后观测光谱中断，
// 仅剩模型延伸。黑色实线为最佳拟合的 Prospector 模型光谱，
// 从约 5000 Å 延伸至 50000 Å，整体呈缓慢下降趋势，在约
// 6900 Å 处可见明显发射线尖峰，在 34000 Å 附近有轻微凸起。
// 蓝色空心圆点（带误差棒）表示观测测光数据，分布在约
// 5000、5500、6000、6500、6800、7500、8000、21000、34000、
// 46000 Å 等位置。红色空心方块表示对应的模型测光数据，与
// 观测测光点在水平位置上基本对准（仅做微小水平错位以避让
// 显示），数值高度吻合。图例位于右下方，依次标注：浅蓝方
// 块=Observed spectrum，灰方块=Observed spectrum
// uncertainty，黑线段=Model spectrum，蓝圆=Observed
// photometry，红方块=Model photometry。 下方面板（Bottom
// panel）：为观测与模型光谱在 5000-7800 Å 范围的放大图。
// 横轴为观测波长 [Å]，范围 5000 至 7800 Å；纵轴为 Fν [μ
// Jy]，对数刻度，标注刻度为 3×10^3、4×10^3、6×10^3、10^4
// μJy。图中浅蓝色实线为观测光谱，浅灰色实线为误差谱，黑
// 色实线为模型光谱。左上角标注文字“z=0.0469”和“SDSS/
// Goodman”。光谱在约 6900 Å 处出现显著发射线（可能为 Hα），
// 峰值接近 10^4 μJy，其左侧约 6800 Å 处有较弱发射线；在
// 约 5200 Å 处有一个明显的吸收谷。 该图传达的趋势与结论：
// Prospector 模型光谱与观测光谱及多波段测光数据在宽波长
// 范围内高度一致，模型测光点与观测测光点几乎重合，表明拟
// 合结果良好；下方面板突出显示了静止系光学波段的发射线特
// 征，为宿主星系恒星形成及星族性质提供了定量约束。
#figure(scope: "parent", image("imgs/FRB20211127I_SED_final.png", width: 100%),
  caption: [
    Example SED for the host of FRB 20211127I. #strong[Top panel:] The observed spectrum (light blue) and its associated error spectrum (light grey) are modeled jointly with the observed photometry (blue circles). The best-fit `Prospector` model spectrum (black) and corresponding model photometry (red squares) are also displayed. #strong[Bottom panel:] Zoom-in of the observed and model spectra following the same color scheme as the top panel. As the nebular emission lines are self-consistently modeled, the `Prospector` model provides excellent agreement to the spectroscopic data. The remaining SEDs are in Appendix~#ref(<sec:SEDs>, supplement: none).
  ]
)
<fig:exSED>

= RESULTS
<sec:results>

== Stellar Population Properties
#<sec:-SPPs>

We now present the inferred stellar population properties of the 23~FRB host galaxies in our sample as a whole. To calculate population medians, we draw 1000 representative samples of log(M$""_(*)$/M$""_⊙$), log(Z$""_(*)$/Z$""_⊙$), $t_(upright(m))$, $A_(upright(V), upright("young"))$ and $A_(upright(V), upright("old"))$, and construct distributions of log($upright("SFR")_(upright("0") - upright("100") thin upright("Myr"))$) and specific star formation rate (star formation rate divided by stellar mass; log($upright("sSFR")_(upright("0") - upright("100") thin upright("Myr"))$)) as described above for each host galaxy. We chose 1000 draws as this constitutes a representative sample from which deviations in the median and 68\% confidence intervals are negligible with increasing numbers of draws. We then combine the distributions for each parameter and derive the medians and 68\% credible intervals for the total population.

We find that the FRB host population has a median $t_(upright(m)) approx 5.12$~Gyr (interquartile range of $3.72 - 6.30$~Gyr) and log(M$""_(*)$/M$""_⊙ ) approx 9.86$ (interquartile range of $9.46 - 10.33$). The two hosts with the lowest log(M$""_(*)$/M$""_⊙$) are those of the repeating FRB 20121102A and the non-repeating FRB 20210117A, with $approx 8.1$ and $8.6$, respectively; both fall in the dwarf galaxy class ($lt.tilde 10^9 med$M$""_⊙$\; #cite(<dwarf>, style: "aas_noparen.csl")). For comparison, these are an order of magnitude less massive than the Large Magellanic Cloud with log(M$""_(*)$/M$""_⊙ ) approx 9.43$ @LMC and closer to that of the Small Magellanic Cloud with log(M$""_(*)$/M$""_⊙ ) approx 8.49$ @SMC. The median SFR$""_(upright("0") - upright("100") thin upright("Myr")) approx 1.3 thin M_⊙$~yr$""^(- 1)$ (interquartile range of $0.20 - 4.0 thin M_⊙$~yr$""^(- 1)$, while the median log($upright("sSFR")_(upright("0") - upright("100") thin upright("Myr")) ) approx - 9.86$~yr$""^(- 1)$ (interquartile range of $- 10.69$ to $- 9.17$~yr$""^(- 1)$). We present the posterior distributions of a selection of stellar population properties and derived properties for the full host sample in @fig:prior-posterior_plot. We report these results numerically in @tab:SPP_stats.

// [figvision-cn] imgs/full_posteriors_WAP2.jpg
// 这是一张包含七个子图（上排四个，下排三个）的科学论文插
// 图，展示全样本中七个物理量的后验分布直方图。所有子图均
// 采用阶梯状直方图形式，纵轴统一为概率密度或相对频次（范
// 围0.00至0.40，刻度间隔0.05），图中三个分布叠加显示：黑
// 色实线轮廓代表“All FRBs”（全部快速射电暴），蓝色半透明
// 填充代表“Repeaters”（重复暴），粉色半透明填充代表“
// Non-repeaters”（非重复暴），蓝色与粉色重叠处呈紫色。图
// 例位于左上角子图内。 上排从左至右： 子图a：横轴为log(
// SFR₀₋₁₀₀Myr)，表示恒星形成率对数，单位M_⊙ yr⁻¹，范围-4
// 至4，刻度间隔2。蓝色重复暴分布在约-1.2处有峰值，并延伸
// 至2附近；粉色非重复暴峰值在0.5至1附近，分布较宽。 子图
// b：横轴为log(sSFR₀₋₁₀₀Myr)，表示比恒星形成率对数，单位
// yr⁻¹，范围-12至-7，刻度间隔1。两类分布高度重叠，均在约
// -10.5至-9处有主峰，非重复暴在-8附近有次要峰。 子图c：
// 横轴为log(M_*/M_⊙)，表示恒星质量对数，范围7至13，刻度
// 间隔1。黑色总样本峰值在10.5附近；粉色非重复暴在10.5附
// 近有尖锐峰值，蓝色重复暴在9.5至10附近有较宽峰值，提示
// 重复暴倾向于分布在较低质量端。 子图d：横轴为log(Z/Z_⊙)，
// 表示金属丰度对数，范围-2.0至0.0，刻度间隔0.5。两类分布
// 均在-0.5附近有峰值，非重复暴峰值更高更窄，重复暴分布更
// 宽且向低金属丰度端延伸。 下排从左至右： 子图e：横轴为
// t_m，单位Gyr，范围0至12.5，刻度间隔2.5。两类分布均集中
// 在5至7 Gyr，峰值在6 Gyr附近，形状相似。 子图f：横轴为
// Av,young，表示年轻星族尘埃消光，单位AB mag，范围0至2.0，
// 刻度间隔0.5。两类分布高度重合，峰值在1.0至1.2 AB mag。
// 子图g：横轴为Av,old，表示年老星族尘埃消光，单位AB mag，
// 范围0至2.0，刻度间隔0.5。两类分布均在0附近最高，随消光
// 值增大呈指数衰减，重复暴与非重复暴趋势一致。 整体趋势：
// 两组群体在大多数性质上分布相似，主要差异在于重复暴的
// log(M_*/M_⊙)分布峰值低于非重复暴，表明重复暴倾向于具有
// 较低恒星质量。
#figure(image("imgs/full_posteriors_WAP2.jpg", width: 100%),
  caption: [
    Posterior distributions of log($upright("SFR")_(upright("0") - upright("100") thin upright("Myr"))$), log($upright("sSFR")_(upright("0") - upright("100") thin upright("Myr"))$), log(M$""_(*)$/M$""_⊙$), log(Z$""_(*)$/Z$""_⊙$), $t_(upright(m))$, $A_(upright(V), upright("young"))$, and $A_(upright(V), upright("old"))$ for the full sample. We show the repeater (blue) and non-repeater (pink) populations separately. While the two populations are similar for most properties, repeaters tend to have lower log(M$""_(*)$/M$""_⊙$) than non-repeaters.
  ]
)
<fig:prior-posterior_plot>

#figure(
  align(center)[#table(
    stroke: none,
    columns: 9,
    align: (left,center,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    [Population], [log($upright("SFR")_(upright("0") - upright("100") thin upright("Myr"))$)], [log($upright("sSFR")_(upright("0") - upright("100") thin upright("Myr"))$)], [log(M$""_(upright(F))$/M$""_⊙$)], [log(M$""_(*)$/M$""_⊙$)], [log(Z$""_(*)$/Z$""_⊙$)], [$t_(upright(m))$], [A$""_(upright(V), upright("young"))$], [A$""_(upright(V), upright("old"))$],
    table.hline(stroke: 0.5pt),
    [], [\[M$""_⊙$~yr$""^(- 1)$\]], [\[yr$""^(- 1)$\]], [], [], [], [\[Gyr\]], [\[mag\]], [\[mag\] ],
    [Full Sample], [$0.11_(- 1.31)^(+ 0.81)$], [$- 9.86_(- 1.16)^(+ 1.26)$], [$10.06_(- 0.67)^(+ 0.55)$], [$9.86_(- 0.68)^(+ 0.55)$], [$- 0.63_(- 0.75)^(+ 0.54)$], [$5.12_(- 2.15)^(+ 1.97)$], [$1.13_(- 0.28)^(+ 0.28)$], [$0.23_(- 0.17)^(+ 0.46)$],
    [Repeaters], [$- 0.56_(- 0.95)^(+ 1.01)$], [$- 10.37_(- 0.77)^(+ 2.39)$], [$9.59_(- 1.11)^(+ 0.75)$], [$9.40_(- 1.11)^(+ 0.73)$], [$- 0.96_(- 0.80)^(+ 0.89)$], [$5.31_(- 1.83)^(+ 1.83)$], [$1.11_(- 0.29)^(+ 0.29)$], [$0.30_(- 0.2)^(+ 0.37)$],
    [Non-repeaters], [$0.26_(- 1.03)^(+ 0.84)$], [$- 9.77_(- 1.06)^(+ 0.86)$], [$10.23_(- 0.63)^(+ 0.50)$], [$10.01_(- 0.55)^(+ 0.54)$], [$- 0.56_(- 0.54)^(+ 0.48)$], [$5.07_(- 2.30)^(+ 1.99)$], [$1.13_(- 0.27)^(+ 0.28)$], [$0.20_(- 0.14)^(+ 0.51)$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [FRB Host Galaxy Stellar Population Property Statistics ]
  , kind: table
  )
<tab:SPP_stats>

We next compare the host galaxy properties of repeating and non-repeating FRBs by presenting their five-number summaries derived from the full posterior distributions as described above. These statistics are represented visually by boxplots in @fig:boxplot_R-NR. We find that their distributions of mass-weighted ages, stellar metallicities, and sSFR values are similar, spanning nearly the full range available to galaxies (although in the latter property, non-repeaters span a wider range). We also find that the hosts of non-repeaters tend to have slightly larger stellar masses (population median log(M$""_(*)$/M$""_⊙ ) approx 10.01$ versus $9.40$ for the hosts of repeaters). To test whether the stellar population properties of repeaters and non-repeaters could originate from the same underlying distribution, we perform an Anderson-Darling (AD) two sample test with a chosen cut-off p-value of 0.05 (95\% confidence). We find p-values~$>$~0.2 in all properties, with the exception of stellar mass for which we derive a p-value of 0.060 and stellar metallicity for which we derive a p-value of 0.164. Thus, we do not find any evidence that the stellar population properties of repeaters and non-repeaters are statistically distinct.

// [figvision-cn] imgs/boxplots_WAP2.jpg
// 该图由四个并排的箱线图子图组成，从左至右依次标记为 a、
// b、c、d（图内未显式标注字母，按顺序排列）。所有子图均
// 采用相同样式：箱体表示第一四分位数至第三四分位数范围，
// 箱内橙色横线表示中位数，须线延伸至最大值与最小值，空心
// 圆圈表示离群点。每个子图横轴均为两个分类：左侧为“
// Repeater”（重复暴），右侧为“Non-repeater”（非重复暴）。
// 数据基于宿主星系后验概率分布的 1000 个代表性样本。 子
// 图 a：纵轴为 t_m [Gyr]，表示恒星形成历史的时间尺度，范
// 围 0 至 12，主刻度间隔 2。重复暴箱体约在 4 至 6.5 Gyr，
// 中位数约 5 Gyr；须线范围约 0 至 11.5 Gyr，在 0 附近有
// 一个空心圆圈离群点，上须线顶端附近密集分布多个空心圆圈。
// 非重复暴箱体约在 3.5 至 6.2 Gyr，中位数约 5 Gyr；须线
// 范围约 0 至 10.5 Gyr，上须线顶端附近亦有密集空心圆圈离
// 群点。两组中位数接近，但重复暴的分布略宽。 子图 b：纵
// 轴为 log(M_*/M_⊙)，表示宿主星系恒星质量的对数（以太阳
// 质量为单位），范围 8.0 至 11.0，主刻度间隔 0.5。重复暴
// 箱体约在 9.1 至 9.9，中位数约 9.5；须线范围约 7.9 至
// 10.4。非重复暴箱体约在 9.5 至 10.3，中位数约 9.9；须线
// 范围约 8.5 至 11.0。非重复暴的恒星质量中位数明显高于重
// 复暴，且分布整体上移。 子图 c：纵轴为 log(Z/Z_⊙)，表示
// 宿主星系金属丰度的对数（以太阳金属丰度为单位），范围
// -2.0 至 0.0，主刻度间隔 0.5。重复暴箱体约在 -1.6 至
// -0.5，中位数约 -1.0；须线范围约 -2.0 至 0.2。非重复暴
// 箱体约在 -0.9 至 -0.3，中位数约 -0.5；须线范围约 -2.0
// 至 0.2，在 -2.0 处有一个空心圆圈离群点。非重复暴的金属
// 丰度中位数高于重复暴。 子图 d：纵轴为 log(sSFR_{
// 0-100Myr}) [yr^{-1}]，表示近 100 百万年内比恒星形成率
// 的对数，范围 -14 至 -8，主刻度间隔 2。重复暴箱体约在
// -11.0 至 -9.5，中位数约 -10.0；须线范围约 -12.2 至
// -7.5。非重复暴箱体约在 -10.2 至 -9.2，中位数约 -9.7；
// 须线范围约 -14.0 至 -7.3，下须线附近密集分布多个空心圆
// 圈离群点，最低至约 -14.2。非重复暴的比恒星形成率中位数
// 略高，但离群值向低值方向延伸更明显。 总体趋势：与非重
// 复暴相比，重复暴宿主星系倾向于具有更低的恒星质量、更低
// 的金属丰度，以及略低的比恒星形成率；两组在恒星形成历史
// 时间尺度 t_m 上的中位数相近，但重复暴分布略宽。
#figure(scope: "parent", image("imgs/boxplots_WAP2.jpg", width: 100%),
  caption: [
    Boxplots of the full sample of FRB hosts split by repeater and non-repeaters derived from 1000 representative samples of the hosts' posterior probability distributions. The box represents the range between the first and third quartiles, with the median denoted by an orange line. The whiskers denote the maxima and minima, and outliers are represented by circles.
  ]
)
<fig:boxplot_R-NR>

We also note a few outliers from this analysis. The host of the non-repeating FRB 20211127I has a $upright("sSFR")_(upright("0") - upright("100") thin upright("Myr")) approx 10^(- 8.29)$ yr$""^(- 1)$, over an order of magnitude higher than the next greatest FRB in the same redshift range -- the highly active FRB 20201124A at $10^(- 9.73)$ yr$""^(- 1)$. At $z = 0.0469$, FRB 20211127I is a relatively young ($approx 4$ Gyr), nearby spiral galaxy with an age and redshift among the lowest in the sample. This host additionally shows an elevated HI-to-stellar mass ratio and has a slight asymmetry in HI #cite(<Glowacki-23>). The other notable outlier is the host age of FRB 20210807D. This is the oldest and most massive FRB host ($8.36_(- 1.84)^(+ 2.25)$ Gyr and log(M$""_(*)$/M$""_⊙ ) approx 10.97$) and is also the only quiescent galaxy in the sample (c.f., @sec:discuss-SFMS) with a $upright("sSFR")_(upright("0") - upright("100") thin upright("Myr")) approx 10^(- 11.41)$ yr$""^(- 1)$, the lowest in the sample.

#cite(<Heintz-20>, form: "prose") and #cite(<bha-22>, form: "prose") were the first FRB host population studies based on 12 and 16 hosts, respectively. They found FRB hosts span log(M$""_(\*)$/M$""_⊙ ) approx 8 - 10.8$, $t_(upright(m)) approx 0.06 - 1.6$ Gyr, and SFRs $approx 0.05 - 10$ M$""_⊙$ yr$""^(- 1)$, essentially much of the parameter space expected for galaxies within the redshift ranges of their samples. Their SFRs were primarily derived from H$alpha$ emission line measurements, which trace more recent SF (timescales of 10-30 Myr). These previous studies performed stellar population modeling using the photometry-only code CIGALE @CIGALE, employing a parametric delayed-$tau$ SFH. One known difference between parametric and non-parametric SFHs is that non-parametric SFHs allow for older, more massive galaxies @Leja2019b, essentially giving the galaxies the freedom to form more mass over a longer time period, and are more physically realistic. In our analysis, the strength of the 4000Å break in the spectrum also drives the older ages, with more considerable breaks implying older stellar populations. Indeed, our new analysis finds significantly older ages by a factor of $approx$ 5 and slightly larger stellar masses compared to previous studies (see @sec:discuss-SPPs for further discussion). An additional difference between earlier works and this is the IMF used (Chabrier IMF in #cite(<Heintz-20>, style: "aas_noparen.csl") and #cite(<bha-22>, style: "aas_noparen.csl") versus Kroupa here). However, the expected differences in mass and SFR attributed to the assumed IMF between these models are very small @Conroy2013.

== The Relationship Between FRBs and Current Star Formation
#<sec:Star-Formation>

// [figvision-cn] imgs/SFMS_WAP2.jpg
// 这是一张由三个并排子图组成的科学论文插图，子图从左至右
// 标记为 a、b、c。整张图展示了宿主星系样本的近期恒星形成
// 率与恒星质量的关系，背景叠加了 COSMOS 天区星系分布（即
// 恒星形成主序带），并根据红移将样本分为三个区间。 全局
// 坐标轴与图例说明：三个子图共享相同的纵轴与横轴。纵轴标
// 签为 “log(sSFR\(_{10Myr}\) [M\(_\odot\) yr\(^{-1}\)])”，
// 表示 1000 万年前平均的比恒星形成率的对数，单位为太阳质
// 量每年，纵轴范围从 -5 到 3，主刻度间隔为 1。横轴标签为
// “log(M\(_*\) / M\(_\odot\))”，表示恒星质量的对数，单位
// 为太阳质量，横轴范围从 7 到 12，主刻度间隔为 1。所有子
// 图的左上角包含一个图例：星形符号（☆）表示“Repeater”（
// 重复暴源），方形符号（□）表示“Non-Repeater”（非重复暴
// 源）；蓝色填充代表 “Star Forming”（恒星形成星系），黄
// 色填充（带有黑色轮廓）代表 “Transitioning”（过渡星系），
// 红色填充代表 “Quiescent”（宁静星系）。 子图 a（左侧）：
// 顶部标题为 “z < 0.1”。该子图背景为浅灰色小点构成的散点
// 云，代表 COSMOS 天区星系，这些点在 log(M\(_*\)) 约 8.5
// 到 10.5 之间形成一个向右上倾斜的带状分布。前景中标记了
// 五个带误差棒的宿主星系符号：一个蓝色方形符号位于大约 (
// 10.1, 1.5)；一个星形符号位于 (10.2, 0.4)；两个星形符号
// 重叠位于 (10.2, -0.4)，其中一个为蓝色，另一个为黄色；
// 一个黄色方形符号位于 (9.9, -1.8)。所有星形和方形符号都
// 带有垂直方向的黑色误差棒。该子图传达出低红移样本中，过
// 渡星系和宁静星系可能偏离主序带。 子图 b（中间）：顶部
// 标题为 “0.1 < z ≤ 0.3”。背景灰色散点云比子图 a 更密集
// 且向右上方延伸，形成一条从 (8, -2.5) 到 (10.5, 1.5) 的
// 宽阔恒星形成主序带。前景中有八个带误差棒的宿主星系符号：
// 一个星形符号位于大约 (8.1, -1.1)；一个方形符号位于 (
// 8.6, -1.7)；一个星形符号位于 (9.3, -1.4)；一个星形符号
// 位于 (9.7, -1.1)；一个黄色方形符号位于 (9.9, -1.5)；一
// 个白色方形符号位于 (10.2, -0.4)；一个白色方形符号位于
// (10.5, 0.2)；一个星形符号位于 (10.8, 0.7)；一个蓝色方
// 形符号位于 (10.9, 1.3)；一个红色方形符号位于 (11.0,
// 0.1)。符号主要沿主序带分布，但有部分过渡和宁静星系位于
// 主序带下方。 子图 c（右侧）：顶部标题为 “0.3 < z ≤ 0.6
// ”。背景灰色散点云在 log(M\(_*\)) 约 9.5 处较为集中，并
// 向右上倾斜，但高红移端的散点整体向右侧偏移。前景中有七
// 个带误差棒的宿主星系符号：一个蓝色星形符号位于大约 (
// 8.9, 0.1)；一个白色星形符号位于 (9.2, 0.2)；一个蓝色星
// 形符号位于 (9.6, 0.0)；一个白色方形符号位于 (10.0, 0.1
// )；一个蓝色方形符号位于 (10.2, 0.7) 至 (10.2, 0.1) 之
// 间；一个白色星形符号位于 (10.4, 0.5)；一个白色方形符号
// 位于 (10.6, -0.1)。在这一红移区间，宿主星系符号更加紧
// 密地分布在恒星形成主序带的上方边缘附近。
#figure(scope: "parent", image("imgs/SFMS_WAP2.jpg", width: 100%),
  caption: [
    The recent star formation rate versus stellar mass for the full host sample plotted against the COSMOS field galaxies, tracing the star-forming main sequence. We split the sample into three redshift bins (individual panels) to account for evolution in the sequence. Repeaters and non-repeaters are denoted by stars and squares, respectively. The symbols are color-coded by their #cite(<Tacchella-22>, form: "prose") classification.
  ]
)
<fig:SFR-Mstar>

One of the main context clues for transients and their host galaxies is how they trace active star formation in galaxies. This is particularly important for FRBs given their potential association with magnetars @CHIME-magnetar @Bochenek20. To systematically classify the degree of star formation in FRB hosts, we use the mass-doubling number criterion from #cite(<Tacchella-22>, form: "prose") to classify the hosts into star-forming, transitioning (off the main sequence), or quiescent galaxies. From Equation 2 of #cite(<Tacchella-22>, form: "prose"),

$ cal(D) ( z ) = upright("sSFR") ( z ) times t_(upright(H)) ( z ) $

where $t_(upright(H)) ( z )$ is the age of the Universe at the redshift of the host galaxy. Following their classification, if $cal(D) ( z ) > 1 / 3$, the galaxy is star-forming; if $1 / 3 < cal(D) ( z ) < 1 / 20$, the galaxy is transitioning; and, if $cal(D) ( z ) < 1 / 20$, the galaxy is quiescent. To determine the classification, we take the distribution of log($upright("sSFR")_(upright("0") - upright("100") thin upright("Myr"))$) (generated from 1000 representative draws of $upright("sSFR")_(upright("0") - upright("100") thin upright("Myr"))$ and log(M$""_(*)$/M$""_⊙$)) and 1000 draws of $t_(upright(m))$, ensuring the values come from the same models. We then calculate the mass-doubling number for each of the 1000 models and take the mode to determine the most common classification. We find that the large majority of FRB hosts are star-forming (20 hosts), two are transitioning (FRBs 20180916B and 20210410D), and one is quiescent (FRB 20210807D). Two of the transitioning and/or quiescent hosts are associated with apparent non-repeating FRBs, although the repeating FRB 20180916B is classified as transitioning as well.

We next compare the SFRs and stellar masses of FRB hosts (specifically, the log($upright("SFR")_(upright("0") - upright("100") thin upright("Myr"))$)---log(M$""_(*)$/M$""_⊙$) phase space) to field galaxies from the COSMOS sample @Laigle_etal_2016, as shown in @fig:SFR-Mstar. We emphasize that these background galaxies were similarly modeled using `Prospector` with a non-parametric `continuity` SFH in #cite(<Leja_etal_2020>, form: "prose"), allowing for a direct comparison to our derived properties for FRB hosts. We divide the FRB hosts and COSMOS galaxies into three redshift bins, spanning $z < 0.1$, $0.1 < z lt.eq 0.3$, and $0.3 < z lt.eq 0.6$, to enable a proper comparison as there is redshift evolution in this phase space. The well-known star-forming main sequence of galaxies (SFMS; e.g., #cite(<Whitaker12>, style: "aas_noparen.csl")#cite(<Speagle14>, style: "aas_noparen.csl")#cite(<Leja-22>, style: "aas_noparen.csl")) is apparent; in general, galaxies below the SFMS are transitioning off or completely quiescent.

We find that the majority of FRB hosts trace the SFMS across all redshifts#footnote[We stress that this is not a selection effect in our data. Although the criteria outlined in §2.1 require that the host galaxy spectrum shows clear features such as optical emission lines, in practice, no quiescent galaxies were excluded from our sample by this requirement.]. This demonstrates that FRB hosts are forming stars at a similar rate to field galaxies at a given stellar mass. The one star-forming outlier is the host of the apparent non-repeating FRB 20211127I, which lies well above the main sequence and is the most active galaxy in our sample. We otherwise note that the classification of an FRB as a repeater or non-repeater does not appear to have an effect on the placement of star-forming hosts relative to the SFMS.

In previous works on FRB host galaxies, the majority of the FRB hosts were found to be slightly offset from the SFMS, with smaller star-forming rates than field galaxies of similar stellar mass (e.g., Figure 4 of #cite(<bha-22>, style: "aas_noparen.csl")). As discussed in #ref(<sec:-SPPs>), we find slightly larger stellar masses and otherwise similar SFRs. However, previous studies used the PRIMUS catalog @Moustakas_etal_2013 for their field galaxy comparison. When compared to that of COSMOS, the SFMS of PRIMUS is higher by an order of magnitude, effectively resulting in an upward shift in the background galaxy comparison sample and a relative downward shift in the locations of the FRB hosts. The specific interpretation of why the PRIMUS SFMS is significantly higher is beyond the scope of this work, but is likely due to their inclusion of a bursty SFH and lack of IR information. In this work, we use the analysis of the COSMOS dataset from #cite(<Leja_etal_2020>, form: "prose") derived using identical methodology to our FRB hosts, and are thus free of inter-code systematics. By performing a direct comparison for the first time and employing a quantitative criterion for degree of star formation, we find that only a few are formally "off" the SFMS. In other words, the primary difference is the field galaxy modeling, as opposed to any large systematic differences in stellar population properties.

We next examine the phase space of sSFR versus mass-weighted age (@fig:sSFR-MWA). This comparison is meaningful because for non-parametric SFHs, both of these parameters are moments of the SFH. Thus, this serves as a proxy for comparing the SFHs of the FRB hosts to those of field galaxies. We find the star-forming FRB hosts lie in the densest regions occupied by the majority of the COSMOS galaxies, and that there is no apparent distinction between the host galaxies of repeaters and non-repeaters in this phase space. This demonstrates that the SFHs of FRB hosts are also not unique among field galaxies (although we note the presence of outliers such as the host of the very star-forming and relatively young FRB 20211127I); we discuss further in @sec:discuss-SFMS.

// [figvision-cn] imgs/logsSFR_MWA_WAP2.jpg
// 这是一张由三个并排子图组成的科学论文插图，展示了快速射
// 电暴（FRB）宿主星系在“恒星形成历史参数空间”中的分布。
// 三个子图共享相同的纵轴，但各自拥有独立的横轴，并分别对
// 应不同的红移区间。图例位于左上角子图内，以星形符号表示
// 中继暴（Repeater），以方形符号表示非中继暴（
// Non-Repeater）。 三个子图的纵轴名称均为 log(sSFR_NUV −
// 10Myr) [yr⁻¹]，表示在1000万年前时间窗口内测量的比恒星
// 形成率的对数值。纵轴范围统一为 −13 到 −7，步长为 1。横
// 轴名称均为 t_m [Gyr]，表示质量加权年龄，单位为十亿年，
// 范围从 0 到 12，步长为 2。 所有子图的背景被水平虚线划
// 分为三个颜色区域，对应不同的星系演化阶段：顶部浅蓝色区
// 域标记为“Star-Forming”（恒星形成），纵轴范围大致为 −
// 10.4 至 −7；中间浅黄色区域标记为“Transitioning”（过渡），
// 范围大致为 −11.2 至 −10.4；底部浅粉色区域标记为“
// Quiescent”（宁静），范围大致为 −13 至 −11.2。背景中散
// 布着大量半透明的灰色小点，代表来自 COSMOS 天区的参考星
// 系样本分布。每个彩色数据点均带有表示 68% 置信区间的水
// 平和垂直误差棒。 子图 (a) 对应红移 z < 0.1，标题位于顶
// 部中央。图中标注了三个带名称的 FRB 宿主星系：一个蓝色
// 方形数据点位于 t_m ≈ 4.5 Gyr、纵轴 ≈ −8.2 处，标注为“
// 20211127I”；一个蓝色星形数据点位于 t_m ≈ 6.2 Gyr、纵轴
// ≈ −9.9 处，位于恒星形成区；一个黄色星形数据点位于 t_m
// ≈ 7.8 Gyr、纵轴 ≈ −11.0 处，恰好位于过渡区与宁静区的分
// 界线上，标注为“20180916B”。图例框位于右上角，分别画有
// 星形和方形符号并标注。 子图 (b) 对应红移 0.1 < z ≤ 0.3，
// 标题位于顶部中央。图中包含一个蓝色方形数据点位于 t_m ≈
// 4.5 Gyr、纵轴 ≈ −9.5 处；若干蓝色方形和星形数据点聚集
// 在 t_m ≈ 5 至 7 Gyr、纵轴 ≈ −9.8 至 −10.5 的区域。一个
// 黄色方形数据点位于 t_m ≈ 6.8 Gyr、纵轴 ≈ −10.9 处，标
// 注为“20210410D”，位于过渡区。一个红色方形数据点位于
// t_m ≈ 8.5 Gyr、纵轴 ≈ −11.5 处，标注为“20210807D”，该
// 点延伸出显著的水平误差棒，位于宁静区。每个数据点均带有
// 水平误差棒，部分带有垂直误差棒。背景灰色点云在 t_m ≈ 6
// 至 9 Gyr 区域呈现明显的向下聚集趋势。 子图 (c) 对应红
// 移 0.3 < z ≤ 0.6，标题位于顶部中央。图中包含一个蓝色方
// 形数据点位于 t_m ≈ 2.5 Gyr、纵轴 ≈ −8.5 处，标注为“
// 20211203C”。多个蓝色方形和星形数据点聚集在 t_m ≈ 4.5
// 至 5.5 Gyr、纵轴 ≈ −9 至 −10 的区域。一个蓝色方形数据
// 点位于 t_m ≈ 5.8 Gyr、纵轴 ≈ −10.3 处，标注为“
// 20180924B”，靠近恒星形成区与过渡区的分界线。每个数据点
// 均带有水平误差棒，部分带有垂直误差棒。背景灰色点云在
// t_m ≈ 5 至 8 Gyr、纵轴 ≈ −11 至 −13 区域呈现垂直分布。
// 整体趋势表明，大多数 FRB 宿主星系集中在恒星形成区，随
// 着红移增加，宿主星系的质量加权年龄普遍向更年轻的方向偏
// 移（即 t_m 值更小）；同时，不同分类的星系在参数空间中
// 呈现出明显的分层现象——恒星形成星系通常具有较高的比恒星
// 形成率和较年轻的质量加权年龄，宁静星系则相反。
#figure(scope: "parent", image("imgs/logsSFR_MWA_WAP2.jpg", width: 100%),
  caption: [
    log($upright("sSFR")_(upright("0") - upright("100") thin upright("Myr"))$) vs. $t_(upright(m))$ of FRB host galaxies compared to COSMOS field galaxies for three redshift bins. The parameter space is divided into Star-Forming, Transitioning, and Quiescent following the #cite(<Tacchella-22>, form: "prose") classification. Repeaters are denoted by stars and non-repeaters by squares. Both are color-coded by their classification type. Error bars correspond to 68\% confidence. While FRB 20210807D is on the borderline between transitioning (445 model draws) and quiescent (555 model draws), the mode favors a quiescent classification and is thus classified as such.
  ]
)
<fig:sSFR-MWA>

== Star Formation Histories
<sec:SFH>

Complementary to comparisons involving recent star formation in hosts, we can also leverage our derived SFHs. In particular, given the higher apparent activity of repeating FRBs, it is useful to examine if their progenitors might depend on the level of SF activity over time. In #ref(<fig:SFH-gallery>), we show the SFHs of the 23 hosts in our sample over look-back time ($t_(upright("lookback"))$), color-coded by SFH type. Specifically, we classify the FRB host SFHs into five types: rising (purple), delayed-$tau$ exponentially-declining (teal), $tau$-linear exponentially-declining (green), post-starburst (yellow), and rejuvenating (orange). Rising SFHs, which comprise five galaxies in the sample, are typically associated with dwarf and/or irregular galaxies, and naturally are classified by a consistent rise in SF over time #cite(<Papovich-11>). The exponentially-declining SFHs are characteristic of typical L$""_(*)$ galaxies. The delayed-$tau$ (10 hosts) and $tau$-linear (five hosts) exponentially-declining SFHs are functional forms commonly invoked for parametric SFH modeling (e.g., #cite(<Carnall-19>, style: "aas_noparen.csl")). Galaxies of both SFH types form most of their stars at early times and decrease in their activities to the present day, with the delayed-$tau$ model having an important "delay" in the onset of the peak of star formation (contributing to a "rise and fall" shape in the SFH). Post-starburst SFH galaxies have undergone a recent epoch of high star formation followed by a quenching event (e.g., #cite(<Wild-09>, style: "aas_noparen.csl")#cite(<Suess-20>, style: "aas_noparen.csl")#cite(<Suess-22>, style: "aas_noparen.csl")), and comprise two of the hosts. There is a singular possibly rejuvenating host galaxy, FRB 20210807D. This type of galaxy SFH is fairly rare and is characterized by a recent increase in SF activity after a period of quiescence (e.g., #cite(<Zhang-22>, style: "aas_noparen.csl")).

Overall, we find that the population of FRB hosts exhibits a diverse range of SFHs, with the majority of FRB hosts (43\%) falling into the delayed-$tau$ exponentially-declining class in which the peak of SF occurred in the last $tilde 0.1 - 1$~Gyr; this class includes potentially unexpected hosts like the dwarf-like FRB 20190520B. Notably, we find that the majority of hosts with clear and prolonged rising SFHs (e.g., increase in SFRs over time) are those of repeating FRBs (FRBs 20121102A, 20180301A, 20190711A, and 20201124A); however, the non-repeating FRB 20211203C shows this SFH type as well. We also find repeating FRB hosts with delayed-$tau$ and $tau$-linear SFHs. We find evidence of past starburst activity in two host galaxies, both of which originated non-repeating FRBs, corresponding to an occurrence rate of $9 "%"$ (2/23 hosts). This is in stark contrast to the rate of post-starburst galaxies in SDSS ($0.2 "%"$), although we note that the selection criteria for the SDSS sample may underestimate the total fraction of galaxies having undergone a starburst event @French2018. The SDSS criteria is also based on Balmer absorption lines, whereas ours is from the SFHs. Within the final $tilde$Gyr of lookback time, most FRB hosts are rising or at their peak SF activity; some exhibit this behavior even in the final $tilde 100$~Myr. Other than these distinctions, we otherwise find no clear patterns or correlations between the host SFHs of repeaters or non-repeaters.

// [figvision-cn] imgs/FRB_SFH_Gallery_WAP2.jpg
// 这是一张包含23个子图的科学论文插图，每个子图位于一个4
// 列6行的网格中（最后一行第4列空缺）。该图展示了23个快速
// 射电暴（FRB）宿主星系的恒星形成历史（SFH）。 所有子图
// 具有相同的坐标轴结构： x轴标记为“t_lookback (Gyr)”，即
// 回溯时间（单位：十亿年）。采用对数刻度，范围大致从0.1
// 到10（部分子图显示为13.8）。根据图注，左侧对应星系红移
// 处的宇宙年龄，右侧对应现在。从左到右，时间从早期宇宙流
// 向现代。 y轴标记为“SFR [M_⊙ yr⁻¹]”，即恒星形成率（单位：
// 太阳质量每年）。采用对数刻度，范围通常从10⁻²到10¹（个
// 别子图如FRB 20190714A、FRB 20201124A的y轴上限或刻度范
// 围略有不同，最高延伸至4×10⁻³或10¹）。 图中使用了不同颜
// 色的阶梯状阴影区域来表示不同类型的恒星形成历史模型，阴
// 影的宽度代表误差范围或置信区间，黑色实线是中心值拟合曲
// 线。图注中提到的颜色编码为：紫色（上升型，rising）、青
// 色（延迟指数衰减型，delayed-exponentially-declining）、
// 绿色（线性指数衰减型，linear exponentially-declining）、
// 黄色（星暴后型，post-starburst）。 以下是每个子图的详
// 细描述，按行从左至右排列： 第一行： 子图a：标题“FRB
// 20121102A (R)”。紫色（上升型）。曲线在回溯时间约6 Gyr
// 处从约10⁻¹.⁵开始下降，在2 Gyr附近达到谷值（约10⁻²），
// 随后迅速上升并在近期（<1 Gyr）保持在高水平（约10¹）。
// 子图b：标题“FRB 20180301A (R)”。紫色（上升型）。曲线在
// 回溯时间约10 Gyr处起始于约10⁻¹.⁵，随后呈阶梯状上升，在
// 约3 Gyr处达到峰值（近10⁰），随后在近期急剧下降至约10⁻¹
// .⁵。 子图c：标题“FRB 20180916B (R)”。绿色（线性指数衰
// 减型）。曲线在早期（回溯时间约10 Gyr）处于高位（近10⁰），
// 随后随着回溯时间减少（即越来越靠近现在）呈阶梯状单调下
// 降，在近期降至约10⁻²。 子图d：标题“FRB 20180924B”。绿
// 色（线性指数衰减型）。与子图c类似，早期处于高位（近10⁰），
// 随时间推移呈阶梯状下降，近期降至约10⁻²。 第二行： 子图
// e：标题“FRB 20181112A”。青色（延迟指数衰减型）。曲线在
// 回溯时间约10 Gyr处起始于约10⁻²，随后迅速上升并在约6-8
// Gyr达到峰值（近10⁰），之后在近期急剧下降至约10⁻¹.⁵。
// 子图f：标题“FRB 20190102C”。青色。曲线在约8 Gyr处起始
// 于约10⁻¹.⁵，上升至约4 Gyr处的峰值（近10⁰），随后在近期
// 呈阶梯状下降至约10⁻²。 子图g：标题“FRB 20190520B (R)”。
// 青色。曲线在早期（约12 Gyr）很高（近10¹），随后呈阶梯
// 状下降，在约6 Gyr处略有回升，之后继续下降至近期的约10⁻
// ¹.⁵。 子图h：标题“FRB 20190608B”。黄色（星暴后型）。曲
// 线在回溯时间约8-9 Gyr处有一个极高的峰值（接近10⁰），随
// 后在约5-7 Gyr处急剧下降至谷值（低于10⁻²），然后在近期
// （<2 Gyr）再次急剧上升至约10⁻¹。 第三行： 子图i：标题“
// FRB 20190611B”。青色。曲线在约10 Gyr处起始于10⁻²，上升
// 至约7 Gyr处的峰值（近10⁰），随后在近期下降至约10⁻²。
// 子图j：标题“FRB 20190711A (R)”。紫色。曲线呈现从早期（
// 约9 Gyr）的约10⁻¹.⁵持续、单调地阶梯状上升，直至近期达
// 到约10⁰。 子图k：标题“FRB 20190714A”。青色。y轴刻度范
// 围约为1×10⁻³至4×10⁻³。曲线在约9 Gyr处起始于2×10⁻³，在
// 约8-9 Gyr处达到峰值（接近4×10⁻³），随后在近期急剧下降
// 至约10⁻³。 子图l：标题“FRB 20191001A”。青色。曲线在约9
// Gyr处起始于近10⁻²，上升至约7 Gyr处的峰值（近10⁰），之
// 后呈阶梯状下降至近期的约10⁻²。 第四行： 子图m：标题“
// FRB20200430A”。绿色。曲线在约7 Gyr处起始于近10⁰，随后
// 呈阶梯状单调下降，在近期降至约10⁻²。 子图n：标题“FRB
// 20200906A”。青色。曲线在约9 Gyr处起始于约10⁻²，上升至
// 约5 Gyr处的峰值（近10⁰），随后在近期急剧下降至约10⁻²。
// 子图o：标题“FRB 20201124A (R)”。紫色。y轴刻度范围约为2
// ×10⁻³至4×10⁻³。曲线在回期至约0.8 Gyr期间保持在2×10⁻³左
// 右，随后急剧上升至约4×10⁻³，并在近期保持该高水平。 子
// 图p：标题“FRB 20210117A”。青色。曲线在约9 Gyr处起始于
// 约10⁻²，上升至约8 Gyr处的峰值（近10⁰），随后在近期下降
// 至约10⁻²。 第五行： 子图q：标题“FRB 20210320C”。青色。
// 曲线在约9 Gyr处起始于接近10¹的高位，随后呈阶梯状下降至
// 约5 Gyr处的谷值（约10⁻²），之后略有回升，再在近期下降
// 至约10⁻²。 子图r：标题“FRB 20210410D”。绿色。曲线在约
// 11 Gyr处起始于近10⁰，随后呈阶梯状单调下降，在近期降至
// 约10⁻²。 子图s：标题“FRB 20210807D”。橙色（图注未完全
// 说明，但根据曲线推测为某种特定类型）。曲线在约7 Gyr处
// 起始于接近10⁰，随后急剧下降至约10⁻²，之后保持平稳。 子
// 图t：标题“FRB 20211127I”。黄色。曲线在约10 Gyr处起始于
// 约10⁻²，随后呈阶梯状上升，在约1 Gyr处急剧上升至近10⁰，
// 近期保持在近10⁰的高位。 第六行： 子图u：标题“FRB
// 20211203C”。紫色。曲线从早期（约9 Gyr）的约10⁻¹.⁵呈阶
// 梯状单调上升，在约2 Gyr处达到峰值（近10⁰），随后在近期
// 急剧下降至约10¹（根据纵轴，实际上下降到了10¹以下，接近
// 10⁰）。 子图v：标题“FRB 20211212A”。青色。曲线在约9
// Gyr处起始于约10⁻¹.⁵，上升至约6 Gyr处的峰值（近10⁰），
// 随后在近期急剧下降至约10⁻²。 子图w：标题“FRB 20220105A
// ”。绿色。曲线在约8 Gyr处起始于近10⁰，随后呈阶梯状单调
// 下降，在近期降至约10⁻²。 总结来看，这张图展示了不同FRB
// 宿主星系在宇宙历史中恒星形成率的变化模式，通过颜色分类
// 反映了这些星系可能经历的不同的演化路径（如上升、延迟衰
// 减、线性衰减、星暴后等）。不同子图的变率、峰值位置和当
// 前水平差异显著。
#figure(scope: "parent", image("imgs/FRB_SFH_Gallery_WAP2.jpg", width: 100%),
  caption: [
    Star formation histories of all FRB host galaxies in the sample. The x-axis is the lookback time, such that the left-hand side is the age of the Universe at the redshift of the galaxy and the right-hand side is the present day. The SFHs are color-coded by SFH type: rising (purple), delayed-$tau$ exponentially-declining (teal), $tau$-linear exponentially-declining (green), post-starburst (yellow), and rejuvenating (orange). We denote repeating FRBs with an (R) in the titles.
  ]
)
#<fig:SFH-gallery>

== Optical Host Luminosities
<sec:lum-z>

Given the low luminosity of the first identified FRB host galaxy (FRB 20121102A; #cite(<Tendulkar-17>, style: "aas_noparen.csl")), it is worthwhile to compare the luminosities of repeating and non-repeating FRBs across redshift. We present the distribution of host optical luminosities ($nu L_nu$) and redshift in our sample in @fig:l-z, divided into repeaters and non-repeaters. We supplement our sample of 23 FRB hosts with identified hosts of seven FRBs from the literature that did not meet the criteria for inclusion in our sample (a combination of low PATH probabilities, were detected past the date cutoff of January 2022, or have burst energetics below our cutoff) but nonetheless have claimed host identifications and redshifts. These include the CHIME FRB 20190425A @Panther23, DSA FRB 20190523A #cite(<Ravi-19>), `realfast` FRB 20190614D #cite(<Law-20>), CHIME FRB 20190110C #cite(<Ibik-23>), CHIME FRB 20200120E @Kirsten21, CHIME FRB 20200223B #cite(<Ibik-23>), DSA FRB 20220319D @Ravi23, DSA FRB 20220509G #cite(<Connor-23>)#cite(<Sharma-23>), ASKAP/CRAFT FRB 20220610A @Ryder22, DSA FRB 20220912A @Ravi22, and DSA FRB 20220914A #cite(<Connor-23>)#cite(<Sharma-23>). We also plot a demarcation at $nu L_nu = 10^9 L_⊙$ below which a host can be classified as a dwarf galaxy (@fig:l-z).

First, we find that FRB hosts have a median luminosity of $approx$ 6$times 10^9 thin L_⊙$, and span a wide range from the faintest at $approx 2 times 10^8 thin L_⊙$ (FRB 20121102A) to the most luminous at $approx 3 times 10^10 thin L_⊙$ (FRB 20191001A). Next, we find that the hosts of repeaters extend to lower luminosities than those of non-repeaters. Moreover, no repeating FRB hosts in our sample have $nu L_nu gt.tilde 10^10 med L_⊙$ while 9 non-repeating FRB hosts (or 53\% of the total non-repeating host population in our sample) have luminosities in this range. This is consistent with the finding that non-repeaters also exist in galaxies with larger stellar masses (#ref(<sec:-SPPs>)). We also note that for $z lt.tilde 0.6$, repeating and non-repeating FRBs appear to have similar redshift distributions (@fig:l-z), although only non-repeating FRBs have been observed at higher redshifts.

Finally, the only repeating FRB whose host falls into the category of dwarf galaxy is FRB 20120112A, while two additional hosts of repeaters, FRBs 20190520B and 20220912A @Ravi22 sit just above the borderline at $approx 1.1 times 10^9 thin L_⊙$. FRB 20190520B has been described as a dwarf galaxy in the literature based on the $J$-band color #cite(<Niu-22>), but our modeling reveals it to be slightly more massive than a canonical dwarf galaxy. Notably, the dwarf galaxy luminosity space is not only occupied by repeating FRB hosts; indeed, two non-repeating FRB hosts (FRBs 20210117A and 20220319D) have low luminosities of $approx 4 times 10^8 thin L_⊙$ and can be classified as dwarfs @Bhandari_210117 @Ravi23. This is again consistent with their low stellar masses as discussed in #ref(<sec:-SPPs>).

// [figvision-cn] imgs/luminosity_redshift_final.jpg
// 该图由三个子图组成，中央为主散点图，上方和右侧分别为
// redshift 和 luminosity 的边缘分布直方图。 中央主散点图：
// 横轴为 Redshift（红移），范围 0.0 至 1.1，主刻度间隔
// 0.2；纵轴为对数光度 log(νLν) [L⊙]，范围 8.2 至 10.6，
// 主刻度间隔 0.5。图中用青色五角星表示 Repeater（重复暴），
// 用粉紫色正方形表示 Non-Repeater（非重复暴），文献中不
// 符合样本标准的宿主星系用空心符号表示。在纵轴 9.0 处有
// 一条水平灰色虚线，虚线下方右侧标注灰色文字“Dwarfs”。图
// 例位于右下角，标注 Repeater 和 Non-Repeater 的符号。散
// 点分布显示：红移主要集中在 0.0 至 0.4 之间，少数在 0.5
// 至 1.0；光度分布在 8.2 至 10.5 之间。大多数点位于虚线
// 之上，少数点（包括一个青色星和一个粉紫色方块）位于虚线
// 之下。 上方直方图：横轴与主图共享 Redshift，范围 -0.05
// 至 1.1；纵轴为频率密度（无标签），范围 0.0 至 0.3，主
// 刻度间隔 0.1。青色阶梯线表示 Repeater 的红移分布，峰值
// 在 0.1 附近，高度约 0.3；粉紫色阶梯线表示 Non-Repeater
// 的红移分布，峰值在 0.2 至 0.3 之间，高度约 0.25。两者
// 在 0.0 至 0.6 区间重叠，粉紫色线在 0.9 至 1.0 处有一个
// 小峰。 右侧直方图：纵轴与主图共享 log(νLν)，范围 8.2
// 至 10.6；横轴为频率密度（无标签），范围 0.00 至 0.25，
// 主刻度间隔 0.05。青色阶梯线表示 Repeater 的光度分布，
// 在 10.0 和 9.0 附近有两个峰；粉紫色阶梯线表示
// Non-Repeater 的光度分布，峰值在 9.5 附近。两者在 9.0
// 至 10.5 区间重叠。
#figure(image("imgs/luminosity_redshift_final.jpg", width: 50.0%),
  caption: [
    Luminosity--redshift distribution for all FRB hosts to date. We denote repeaters by blue stars and non-repeaters by pink squares. We also include FRB hosts from the literature that did not meet our sample criteria as open symbols.
  ]
)
<fig:l-z>

= DISCUSSION
<sec:discussion>

== The Relationship between FRBs, Star formation, and Implications for the Progenitors
<sec:discuss-SFMS>

Numerous lines of evidence support the scenario that at least some fraction of the FRB progenitor population is composed of magnetars: the FRBs' coherent emission @Katz14, energetics @Margalit20, durations #cite(<Nimmo-22>), rates @CHIME-catalog, stochastic cycles of strong activity or "burst storms" @Lanman22 @Marthi22, evidence for strongly magnetized local environments via their rotation measures @Wang22, and occasional detection of luminous persistent radio sources co-located with FRBs #cite(<Chatterjee-17>)#cite(<Marcote-17>)@Law21#cite(<Niu-22>)@Ravi22b. The possibility of magnetars as FRB progenitors was strengthened by the repeating FRB-like emission from a known Galactic magnetar SGR 1935+2154 @CHIME-magnetar @Bochenek20 @Zhang22. It is therefore natural to consider whether the observed FRB host galaxy population is consistent with all FRBs originating from a magnetar progenitor (although with present data it cannot be ruled out that there are multiple progenitors altogether).

The best-studied pathway to magnetar formation is through the core-collapse supernovae (CCSNe) of recently formed massive stars. Indeed, a young, massive star channel for the origins of Galactic magnetars is supported by observations of core-collapse supernova remnants @Gaensler04 @Vink08 @Zhou19 @Zhou20. In addition, isochrone dating of Galactic magnetars shows that they occur in stellar populations with a range of main-sequence turnoff masses from 17--50~$M_⊙$ @Muno06 @Bibby08 @Davies09 @Tendulkar12.

However, observations of FRB environments as a whole are difficult to reconcile with a single, young production channel for magnetars that is responsible for all observed FRBs. For instance, FRB 20200120E was pinpointed to a $tilde 9$ Gyr old globular cluster environment in M81 @Bhardwaj21 @Kirsten21, signifying that at least some FRBs can originate from delayed channels that do not rely on recent massive star formation. It is still viable that magnetars could be responsible for events that originate in older stellar populations, via close binary evolution or the accretion-induced collapse of a white dwarf @Moriya16 @Margalit19 @Kremer2021, although progenitors not involving magnetars could also be at play, especially for repeaters (i.e., a neutron star interacting with a companion #cite(<Ioka_and_Zhang_2020>, style: "aas_noparen.csl")#cite(<Lyutikov-20>, style: "aas_noparen.csl") or accreting black hole binaries #cite(<Sridhar-21>, style: "aas_noparen.csl")). It has also been predicted that the mergers of two neutron stars (NSs), which can experience potentially long delay times of several Gyr or more, could produce magnetars that may be indefinitely stable to collapse and eventually produce observable FRBs @Totani13 @Wang16 @Pan22. The recent claim of an association between the binary NS merger GW190425 and an FRB 20190425A would be definitive evidence for another such delayed channel #cite(<Moroianu-23>)@Panther23. These pieces of evidence are consistent with the results of #cite(<Li_Zhang_2020>, form: "prose") who find that the current sample of FRB host environments are consistent with magnetars formed through multiple formation channels. Multi-wavelength observations of the local environment were also informative for the repeating FRB 20180916B. Due to its relative proximity (149 Mpc), #cite(<Tendulkar-21>, form: "prose") found that the FRB was 250 pc from the nearest star-forming region, a location inconsistent with a young magnetar had the progenitor been kicked from this region. #cite(<Kaur-22>, form: "prose") performed HI mapping of the host and larger-scale environment, finding evidence for a past minor galaxy merger. While they find that the progenitor was likely born from a massive star originating in a burst of star-formation triggered by the merger, they still conclude that the progenitor likely travelled from the nearest star-forming knot identified in #cite(<Tendulkar-21>, form: "prose"). Studies of the local environments provide unique constraints on progenitor models, but are limited to the closest FRB hosts ($z < 0.05$). As the majority of hosts are at redshifts higher than this, we must also rely on the properties gleaned from global host studies.

It is thus instructive to examine the FRB host population and its relation to star formation and star formation history. On sub-galactic scales, high-resolution UV and NIR imaging of a smaller number of FRB hosts have demonstrated that several FRBs occur in or near the spiral arms of their host galaxies, and thus their locations track active star formation within their galaxies @Chittidi21#cite(<Mannings-21>). Additional studies based on global properties of FRB hosts have found the majority are near to or slightly below the SFMS, in the band typically occupied by galaxies that are transitioning off the main sequence #cite(<Heintz-20>)#cite(<bha-22>)@Ravi22b. A number of these also occur outside of the "blue cloud" of a color-magnitude diagram, although none to date had formally been categorized as quiescent.

Here, based on uniformly derived properties and an accurate comparison to like-modeled field galaxies, we find that the majority lie on the SFMS (i.e., they are forming stars at similar rates to field galaxies of the same stellar mass). Furthermore, based on quantitative criteria to classify galaxies by degree of star formation #cite(<Tacchella-22>), we find that 87\% (20/23) of FRB hosts are star-forming, two are transitioning, and one is quiescent. We also find a wide range of SFRs (integrated over the past 100 Myr), spanning $2 times 10^(- 2)$ M$""_⊙$ yr$""^(- 1) - 36$ M$""_⊙$ yr$""^(- 1)$. Two of the galaxies which are transitioning and quiescent host apparently non-repeating FRBs (FRBs 20210410D and 20210807D) although we note that the repeating FRB 20180916B host is transitioning as well. Both hosts additionally have older ages of $approx 7 - 8$ Gyr.

The SFH can also inform progenitor models of transients. For example, the declining SFHs of so-called Ca-rich transients indicate that core-collapse SNe progenitors are unlikely @Dong22, while the post-starburst nature of the hosts of tidal disruption events have been used to exclude O, B, and massive A type stars as likely progenitors @French2017. In our sample, we find that only a few have monotonically-declining SFHs (which signifies that the large majority of the host stellar mass formed early on in the first few Gyr). Instead, examining the last $tilde 1$ Gyr, most FRB hosts are either rising in SF activity or at their peak, while all four FRB hosts with prolonged rises are repeaters; see #ref(<sec:discuss-R-NR>) for a further discussion. We also find a few hosts with evidence of past starburst activity $tilde 100$ Myr, commensurate with H i mapping studies which have shown evidence for minor mergers @Michalowski21#cite(<Kaur-22>). While a complete analysis to determine probable progenitor rates would require constructing mass build-up histories and assumptions on delay time distributions, our results indicate that most FRB hosts were fairly active over the last $lt.tilde 0.1 - 1$ Gyr.

Finally we note that there are three hosts in our sample for which diffuse radio emission has been detected and attributed to star formation #cite(<Bhandari-20-191001>)#cite(<Bhandari-20>)#cite(<Fong-21>)@Ravi22, and in one case, possibly more localized to the burst site #cite(<Piro-21>). While these hosts are not distinct in their SFHs, we find that they all have generally larger SFRs from their SEDs, and two have higher extinction values (in particular, $A_(upright(V), upright("old"))$). While many bursts in our sample lack constraining radio observations, it would be useful to compare if bursts with more recent SF activity from their SFHs also have detectable radio emission.

Taken together, FRB hosts thus originate from galaxies of different levels of star formation activity, but have a clear preference for star-forming galaxies representative of those from the field. Our demographics and SFHs also imply that while the majority of FRB progenitor systems are unlikely to come from highly evolved stellar populations @Liebert88 @Wood92 or other transient events with long delay times @Zevin22, the existence of at least a couple of known hosts in less active environments leaves open this possibility. Already, more FRBs are being found in these types of environments. Recent analysis from #cite(<Sharma-23>, form: "prose") presented the first quiescent, elliptical FRB host galaxy association (FRB 20220509G), which is additionally part of the galaxy cluster Abell 2311. However, the connection between most FRBs and active star formation supports the young magnetar model theory, where magnetars are formed through the core-collapse supernovae of recently-formed massive stars in the past $100$ Myr, for the majority of FRBs.

== Comparison of the Host Properties for Repeating and Apparently Non-Repeating FRBs
#<sec:discuss-R-NR>

As the number of distinct FRB sources now exceeds 600#footnote[#link("https:\\\\#\\\\#/www.wis-tns.org/")], various properties have been proposed to distinguish repeating and non-repeating FRBs. For instance, repeaters first exhibited both a downward drift in frequency known as the "sad trombone" effect #cite(<Hessels-19>) and high linear polarization and/or no circular polarization #cite(<Nimmo-21>). However, as more apparent non-repeating FRBs were discovered, examples in this class also shared some of these properties (see #cite(<Petroff-22>, style: "aas_noparen.csl")#cite(<Zhang22>, style: "aas_noparen.csl") for a more detailed history). Recently, based on a sample of 18 repeating and 474 non-repeating CHIME FRBs, it was proposed that the populations may be distinct in the duration-bandwidth phase space. Specifically, repeating FRBs exhibit longer intrinsic durations (after de-dispersion) and narrower bandwidths ($tilde 100 - 200$ MHz) while apparent non-repeaters have shorter durations and wider bandwidths (e.g., Figure 5 of #cite(<Pleunis21>, style: "aas_noparen.csl")). #cite(<Pleunis21>, form: "prose") suggest this could be due to a propagation effect, a result of beaming #cite(<Connor-20>), different types of bursts from the same source, or factors intrinsic to the populations. #cite(<CHIME-23>, form: "prose") again performed a similar analysis with a larger sample of 25 repeaters and found a distinction in DM between the two populations (although they additionally find the burst rates between repeaters and non-repeaters are not distinctly bimodal, implying a portion of the non-repeaters may be eventually observed to repeat.) Thus, it is still unclear if the observed distinctions between repeaters and non-repeaters are intrinsic to the objects themselves or not.

Now, we have leveraged new surveys which have enabled a consistent stream of well-localized events (both repeating and non-repeating) and thus robust host associations. From our sample of 23 FRB host galaxies, we find that repeaters and non-repeaters share largely similar distributions of stellar population properties (e.g., mass-weighted age, stellar mass, stellar metallicity, SFH, and ongoing SF), with no statistically significant differences.

To test the statistical power of our sample, we simulate larger samples of FRBs with one major assumption that the current posterior distributions for repeaters and non-repeaters are representative of the true distributions. We double and triple the current sample while maintaining the same ratio of repeaters to non-repeaters (i.e., 12 repeaters and 34 non-repeaters for the doubled sample). For each stellar population property, we draw random samples from the total posterior distributions of the non-repeating and repeating FRBs. We then perform an AD test in which the null hypothesis is that the classes are from the same parent distribution in that stellar population property. A p-value of $0.05$ indicates the null hypothesis can be rejected. We then repeat this process 5000 times to obtain a distribution of AD test results. We choose 5000 tests because this is the point at which the percentage of statistically significant results are not dependent on the number of tests run. We find that with twice (three times) the current sample size, the null hypothesis is rejected for 84\% (96\%) of the tests in stellar mass, demonstrating that increasing the sample sizes by a modest amount produce statistically distinct distributions in this property. Indeed, even an increase in the sample size by 50\% result in a majority of AD tests with $p < 0.05$. Performing this same exercise for all other properties, we find that SFR and stellar metallicity could greatly benefit from sample sizes two and three times the current sample, respectively. Meanwhile, all other properties have distributions in which the repeating and non-repeating hosts remain statistically indistinguishable. We caution that these projections assume that the current posterior distributions of repeaters and non-repeaters are representative of the true parent distributions. Ultimately, continued follow-up and stellar population modeling of new, robustly-associated FRB host galaxies will be required to uncover the true population statistics.

While our current sample is not large enough to reveal statistically significant distinctions (if they do exist), it still shows a few noteworthy distinctions. For example, the repeating FRB host population as a whole tend to exist in hosts with lower stellar masses than those of non-repeating FRBs. Similarly, only non-repeating FRBs have been found in galaxies with optical luminosities $nu L_nu gt.tilde 10^10 thin L_⊙$. Additionally, two of the FRBs in the environments with the least star formation activity are apparent non-repeaters (FRBs 20210410D and 20210807D). Finally, the majority of galaxies with clear and prolonged rises in their star formation histories host repeating FRBs (FRBs 20121102A, 20180301A, 20190711A and 20201124A), indicating a heightened level of recent SF activity. While expected for low-mass galaxies like the hosts of FRBs 20121102A and 20190711A #cite(<Papovich-11>)@Leitner2012, this is particularly surprising for more massive galaxies like the hosts of FRBs 20201124A and possibly 20180301A. It is plausible that such distinctions in SFH could be enhanced in the context of a larger sample. Overall, with a sample of six repeaters and 17 non-repeaters, our findings are consistent with two possibilities: the progenitor is the same for both populations, or they have distinct progenitors but do not strongly select on any single galaxy property given the still small number of FRB hosts.

Finally, among the highly secure FRB host sample, we do not find significant differences in the redshift distribution of repeating and non-repeating FRBs. However, when including bursts detected after our date cut-off or with less secure host associations, there are three non-repeating FRB host galaxies identified at $z gt.tilde 0.6$ while no repeating FRB hosts in this regime are known. Actual interpretation is muddied by selection biases based on different discovery experiments with varied observational biases and inconsistent criteria for host galaxy follow-up. However, one might expect that repeating FRBs are easier to identify at low-$z$, as several bursts (presumably some with lower luminosities) must be detected, and we cannot rule out that apparent non-repeaters also have repeat bursts at lower fluences than the detected burst. Moreover, it might be more difficult to discover FRBs in star-forming environments which could potentially harbor foreground columns of ionized gas associated with the host galaxy. The increased dispersion contributions results in larger detected pulse widths which would result in a reduced sensitivity to repeating bursts. If these excess columns contain turbulent gas (as would be expected) scatter-broadening of the emission would also reduce search sensitivity to repeating FRBs.

With the advantage of a large sample of uniformly modeled hosts, we briefly investigate if repeating FRBs with unique burst properties correlate to unique host properties. FRB 20121102A has a PRS #cite(<Chatterjee-17>)#cite(<Marcote-17>), large and variable rotation measure @Michilli18, high burst rate @LiWang21, and a potential 160 day activity period @Rajwade20. Additionally, its RM is decreasing whereas its DM is increasing #cite(<Hilmarsson-21>, form: "prose"). FRB 20190520B is the second known host to feature a PRS #cite(<Niu-22>) and has a high and rapidly varying RM @Anna-Thomas22. Both hosts are notable for having lower stellar masses, optical luminosities, and gas-phase metallicities than the bulk of the population; FRB 20121102A also has a rise in SFH within the last $tilde 0.1$ Gyr. As a counter-example, #cite(<Bhandari_210117>, form: "prose") recently found the non-repeating FRB 20210117A to be in a dwarf galaxy and indeed this is one of the lowest-mass galaxies in our sample. However, this burst lacks a PRS and its environment was not found to be highly magnetized. There may be evidence for the sad-trombone effect commonly associated with repeaters, but it was not detected as strongly as in confirmed repeaters. The repeating FRB 20180916B has a quasi-periodic $approx$ 5 day activity window every 16.4 days @CHIME_FRB_2020, and resides in an old ($tilde 8$ Gyr) transitioning host with a lesser degree of star formation than most repeaters. However, as discussed above, it is possible the merger had some effect on local star formation at the site of the FRB despite its overall low global SFR and declining star formation history. Finally, the highly active repeating FRB 20201124A undergoes sudden high activity rates @Lanman22, showing 1863 bursts in 82 hours over 54 days, dramatic RM variations, circular polarization #cite(<Kumar-22>)@Xu22, and has the widest mean burst width of any repeater @Marthi22. It also has a rising SFH, but is otherwise unremarkable in terms of its galaxy properties.

At face value, there is no strong connection between outliers in FRB burst properties and outliers in host properties. Furthermore, FRB hosts that are outliers in their stellar population properties, such as FRBs 20210807D and 20211127I in regard to age and SFR, respectively, are unremarkable in their burst properties (Shannon+23 in prep.). The detailed interpretation of the connection between FRB burst properties and host properties may be a fruitful path towards constraining progenitor models.

== Comparison of Stellar Population Properties
<sec:discuss-SPPs>

To fully contextualize the stellar population properties we derive in this work, it is important to compare to previous studies of FRB host galaxies, as this can inform if there are any systematic biases in stellar population modeling and methodologies. While stellar population properties in some form exist for 16 of the hosts in our sample of 23 (e.g., #cite(<Tendulkar-17>, style: "aas_noparen.csl")#cite(<Bannister-19>, style: "aas_noparen.csl")#cite(<Prochaska-19>, style: "aas_noparen.csl")#cite(<Heintz-20>, style: "aas_noparen.csl")#cite(<Marcote_etal_2020>, style: "aas_noparen.csl")#cite(<Fong-21>, style: "aas_noparen.csl")#cite(<bha-22>, style: "aas_noparen.csl")#cite(<Bhandari_210117>, style: "aas_noparen.csl") #cite(<Ravi22b>, style: "aas_noparen.csl")#cite(<Niu-22>, style: "aas_noparen.csl")), our study presents uniform modeling, assumes non-parametric SFHs (an assumption which can percolate to systematic offsets in other stellar population properties; e.g., #cite(<Leja2019b>, style: "aas_noparen.csl")), and derives full posterior distributions in each property allowing for a realistic estimate of uncertainties which we make use of in our population distributions. In addition, while previous papers generally derive SFR and metallicity from nebular emission lines, we use the full SED.

For the $14$ hosts which are also modeled in these previous compilations, we compare their stellar population properties. For SFR, while those derived from H$alpha$ and the SED may track different timescales, we do not find that there are any systematic differences. We derive slightly larger stellar masses by $tilde 0.1 - 0.5$ dex (an expected byproduct of non-parametric versus parametric SFHs; #cite(<Leja2019b>, style: "aas_noparen.csl")). We also find systematically older mass-weighted ages than #cite(<Heintz-20>, form: "prose") by a factor of $approx$ 5 (previously ranging from $0.06 - 1.6$ Gyr, versus $2.47 - 8.36$ Gyr here). This is not surprising, as non-parametric SFH modeling is known to result in older ages than the parametric SFH assumption @Leja2019b as the flexible SFH gives galaxies more time to form mass. Since the non-parametric SFH is a more physically realistic assumption than parametric SFHs (the method employed by the majority of the literature), our ages can be considered more representative of the average age of a star in the galaxy. Furthermore, the placement of the FRB hosts in relation to field galaxies in @fig:sSFR-MWA shows that the ages we derive for the FRB hosts are consistent with the field galaxy population given the hosts' sSFRs. In fact, if the hosts have younger ages by an order of magnitude, as found in previous studies, they would occupy a phase space not probed by any galaxies in the COSMOS sample. As FRB hosts appear to track typical galaxies in the Universe in their stellar population properties, significantly younger ages than these galaxies would be highly unusual.

Finally, we emphasize the importance of a direct comparison field galaxy sample for an unambiguous interpretation of results. As discussed in @sec:discuss-SFMS, our finding that most FRB hosts trace the main sequence of star-forming galaxies (as opposed to offset from it) is primarily due to the background field galaxy catalog used. As each SED modeling code uses different frameworks and libraries for modeling the stellar populations, which introduces their own systematic uncertainties, one must somehow account for the systematic uncertainties in the codes' assumptions which is difficult to quantify. Instead, our work demonstrates the importance of modeling hosts in the same manner as the field galaxy population to perform direct comparisons.

= CONCLUSIONS AND FUTURE PROSPECTS
<sec:conclusion>

We have presented the largest collection of highly secure, uniformly modeled FRB host galaxies to date, totaling 23 hosts. We inferred the stellar population properties and star formation histories of the hosts of six repeaters and 17 non-repeaters using the `Prospector` stellar population synthesis code with non-parametric star formation histories. Our major conclusions are:

- FRB hosts have a range of stellar masses of $10^8.1 - 10^11.0 thin M_⊙$ with a median of $approx 10^9.9 thin M_⊙$. Their mass-weighted ages range from $2.5 - 8.4$~Gyr with a median of $approx 5.1$~Gyr. We find SFRs (integrated over the last $100$~Myr) ranging from $0.02 - 35.8 thin M_⊙$~yr$""^(- 1)$ with a median of $approx 1.3 thin M_⊙$~yr$""^(- 1)$.

- We find that of the 23 hosts, 87\% (20/23) are actively star-forming. Two hosts (FRB 20180916B and FRB 20210410D) are transitioning from star forming to quiescent, and another (FRB 20210807D) is quiescent.

- Compared to similarly modeled field galaxies in the COSMOS sample at comparable redshifts, star-forming hosts trace the SFMS, demonstrating that they form stars at similar rates compared to field galaxies of the same stellar mass. The one notable exception is FRB 20211127I which lies well above the SFMS.

- We find no statistically significant differences in the stellar population properties of repeating and non-repeating host galaxies. However, the hosts of repeaters tend to extend to lower stellar masses, and the hosts of non-repeaters tend to be more optically luminous. Moreover, the two hosts with the lowest degrees of star formation are both non-repeaters.

- FRBs show a diverse range of SFHs. We classify the SFHs into five categories: rising, delayed-$tau$ exponentially declining, $tau$-linear exponentially declining, post-starburst, and rejuvenating. The majority peak in star formation in the final Gyr. Repeaters tend to show a clear and prolonged rise in star formation over time indicating a heightened level of more recent activity (although there are also repeaters with delayed-$tau$ and falling SFHs and one non-repeater with a rising SFH).

- FRB hosts are not distinct from the SFH moments (e.g., sSFR and mass-weighted age) of field galaxies in the COSMOS sample. FRB hosts trace the main loci of these phase spaces across redshift evolution.

- The large percentage of actively star forming FRB host galaxies, coupled with recent star formation activity, support the young magnetar progenitor model in which the progenitors formed through core-collapse supernovae. However, the presence of transitioning and/or quiescent hosts imply at least a small fraction could originate in more delayed channels.

Our work takes advantage of state-of-the-art galaxy modeling techniques that utilize the full power of photometry and spectroscopy to model the parent stellar populations that host FRBs. While we have outlined several implications for their progenitors, the derived SFHs can be further leveraged to construct probabilistic progenitor rates assuming different delay time distributions. In addition, a full comparison of FRB host SFHs to field galaxy archetypes could further inform if there is anything unusual in their past star formation activity.

Thanks to concerted advancements in radio searches and instrumentation, the era of multiple (sub-)arcsecond host localizations per day is fast approaching, and the number of known FRB host galaxies will rapidly increase. Moreover, increases in sensitivity will push the FRB detection horizon to higher redshifts of $z gt.tilde 1$ (e.g., #cite(<Ryder22>, style: "aas_noparen.csl")). Our analysis can soon be extended to hundreds of well-localized FRB host galaxies, which will be crucial for understanding whether subtle differences between the hosts of repeating and non-repeating FRBs are robust, and hence indicative of distinct populations, or a result of small-number statistics. Furthermore, the first large-scale studies of FRB properties and rates as a function of redshift, as well as the FRB delay-time distributions with respect to cosmic star formation, will provide additional constraints on their progenitors and usage as cosmic probes. Spectroscopic redshifts and photometric coverage of FRB hosts to $z tilde 1$ and beyond are the only way to probe their progenitor systems in the cosmic era of peak star formation and uniformly short delay times. In parallel, high-quality stellar population parameter modeling of these galaxies will remain key to understanding the global environments of these events and placing unique constraints on progenitor models.

= ACKNOWLEDGEMENTS
<acknowledgements>
The authors thank Kyle Westfall for helpful discussions. A.C.G. and the Fong Group at Northwestern acknowledges support by the National Science Foundation under grant Nos. AST-1814782, AST-1909358 and CAREER grant No. AST-2047919. W.F. gratefully acknowledges support by the David and Lucile Packard Foundation, the Alfred P. Sloan Foundation, and the Research Corporation for Science Advancement through Cottrell Scholar Award \#28284. C.D.K. acknowledges support from a CIERA postdoctoral fellowship. S.B. is supported by a Dutch Research Council (NWO) Veni Fellowship (VI.Veni.212.058). A.T.D. and K.G. acknowledge support through ARC Discovery Project DP200102243. Y.D. is supported by the National Science Foundation Graduate Research Fellowship under Grant No. DGE-1842165. T.E. is supported by NASA through the NASA Hubble Fellowship grant HST-HF2-51504.001-A awarded by the Space Telescope Science Institute, which is operated by the Association of Universities for Research in Astronomy, Inc., for NASA, under contract NAS5-26555. M.G. is supported by the Australian Government through the Australian Research Council's Discovery Projects funding scheme (DP210102103). L.M. acknowledges the receipt of an MQ-RES scholarship from Macquarie University. R.M.S. acknowledges support through Australian Research Council Future Fellowship FT190100155 and Discovery Project DP220102305. M.C. acknowledges support of an Australian Research Council Discovery Early Career Research Award (project number DE220100819) funded by the Australian Government and the Australian Research Council Centre of Excellence for All Sky Astrophysics in 3 Dimensions (ASTRO 3D), through project number CE170100013. J.X.P., A.C.G., Y.D., W.F., T.E., N.T., C.D.K., S.S., and A.G.M. acknowledge support from NSF grants AST-1911140, AST-1910471 and AST-2206490 as members of the Fast and Fortunate for FRB Follow-up team. MeerTRAP received funding from the European Research Council (ERC) under the European Union's Horizon 2020 research and innovation programme (grant agreement No. 694745).

This research was supported in part through the computational resources and staff contributions provided for the Quest high performance computing facility at Northwestern University which is jointly supported by the Office of the Provost, the Office for Research, and Northwestern University Information Technology.

Based in part on observations obtained at the Southern Astrophysical Research (SOAR) telescope, which is a joint project of the Ministério da Ciência, Tecnologia e Inovações (MCTI/LNA) do Brasil, the US National Science Foundation's NOIRLab, the University of North Carolina at Chapel Hill (UNC), and Michigan State University (MSU).

Based in part on observations obtained at the international Gemini Observatory, a program of NSF's NOIRLab, which is managed by the Association of Universities for Research in Astronomy (AURA) under a cooperative agreement with the National Science Foundation on behalf of the Gemini Observatory partnership: the National Science Foundation (United States), National Research Council (Canada), Agencia Nacional de Investigación y Desarrollo (Chile), Ministerio de Ciencia, Tecnología e Innovación (Argentina), Ministério da Ciência, Tecnologia, Inovações e Comunicações (Brazil), and Korea Astronomy and Space Science Institute (Republic of Korea).

W. M. Keck Observatory and MMT Observatory access was supported by Northwestern University and the Center for Interdisciplinary Exploration and Research in Astrophysics (CIERA).

Some of the data presented herein were obtained at the W. M. Keck Observatory, which is operated as a scientific partnership among the California Institute of Technology, the University of California and the National Aeronautics and Space Administration. The Observatory was made possible by the generous financial support of the W. M. Keck Foundation.

The authors wish to recognize and acknowledge the very significant cultural role and reverence that the summit of Maunakea has always had within the indigenous Hawaiian community. We are most fortunate to have the opportunity to conduct observations from this mountain.

Observations reported here were obtained at the MMT Observatory, a joint facility of the Smithsonian Institution and the University of Arizona.

Based on observations collected at the European Southern Observatory under ESO programmes 2101.A-5005, 0102.A-0450, 0103.A-0101, and 105.204W.003.

This scientific work uses data obtained from Inyarrimanha Ilgari Bundara / the Murchison Radio-astronomy Observatory. We acknowledge the Wajarri Yamaji People as the Traditional Owners and native title holders of the Observatory site. CSIRO's ASKAP radio telescope is part of the Australia Telescope National Facility (https:\/\/ror.org/05qajvd42). Operation of ASKAP is funded by the Australian Government with support from the National Collaborative Research Infrastructure Strategy. ASKAP uses the resources of the Pawsey Supercomputing Research Centre. Establishment of ASKAP, Inyarrimanha Ilgari Bundara, the CSIRO Murchison Radio-astronomy Observatory and the Pawsey Supercomputing Research Centre are initiatives of the Australian Government, with support from the Government of Western Australia and the Science and Industry Endowment Fund.

This research has made use of the Keck Observatory Archive (KOA), which is operated by the W. M. Keck Observatory and the NASA Exoplanet Science Institute (NExScI), under contract with the National Aeronautics and Space Administration.

This research has made use of the NASA/IPAC Infrared Science Archive, which is funded by the National Aeronautics and Space Administration and operated by the California Institute of Technology.

This project used public archival data from the Dark Energy Survey (DES). Funding for the DES Projects has been provided by the U.S. Department of Energy, the U.S. National Science Foundation, the Ministry of Science and Education of Spain, the Science and Technology Facilities Council of the United Kingdom, the Higher Education Funding Council for England, the National Center for Supercomputing Applications at the University of Illinois at Urbana--Champaign, the Kavli Institute of Cosmological Physics at the University of Chicago, the Center for Cosmology and Astro-Particle Physics at the Ohio State University, the Mitchell Institute for Fundamental Physics and Astronomy at Texas A&M University, Financiadora de Estudos e Projetos, Fundação Carlos Chagas Filho de Amparo à Pesquisa do Estado do Rio de Janeiro, Conselho Nacional de Desenvolvimento Científico e Tecnológico and the Ministério da Ciência, Tecnologia e Inovação, the Deutsche Forschungsgemeinschaft and the Collaborating Institutions in the Dark Energy Survey.

The Collaborating Institutions are Argonne National Laboratory, the University of California at Santa Cruz, the University of Cambridge, Centro de Investigaciones Enérgeticas, Medioambientales y Tecnológicas--Madrid, the University of Chicago, University College London, the DES-Brazil Consortium, the University of Edinburgh, the Eidgenössische Technische Hochschule (ETH) Zürich, Fermi National Accelerator Laboratory, the University of Illinois at Urbana-Champaign, the Institut de Ciències de l'Espai (IEEC/CSIC), the Institut de Física d'Altes Energies, Lawrence Berkeley National Laboratory, the Ludwig-Maximilians Universität München and the associated Excellence Cluster Universe, the University of Michigan, the National Optical Astronomy Observatory, the University of Nottingham, The Ohio State University, the OzDES Membership Consortium, the University of Pennsylvania, the University of Portsmouth, SLAC National Accelerator Laboratory, Stanford University, the University of Sussex, and Texas A&M University.

Based in part on observations at Cerro Tololo Inter-American Observatory, National Optical Astronomy Observatory, which is operated by the Association of Universities for Research in Astronomy (AURA) under a cooperative agreement with the National Science Foundation.

Funding for SDSS-III has been provided by the Alfred P. Sloan Foundation, the Participating Institutions, the National Science Foundation, and the U.S. Department of Energy Office of Science. The SDSS-III web site is http:\/\/www.sdss3.org/.

SDSS-III is managed by the Astrophysical Research Consortium for the Participating Institutions of the SDSS-III Collaboration including the University of Arizona, the Brazilian Participation Group, Brookhaven National Laboratory, Carnegie Mellon University, University of Florida, the French Participation Group, the German Participation Group, Harvard University, the Instituto de Astrofisica de Canarias, the Michigan State/Notre Dame/JINA Participation Group, Johns Hopkins University, Lawrence Berkeley National Laboratory, Max Planck Institute for Astrophysics, Max Planck Institute for Extraterrestrial Physics, New Mexico State University, New York University, Ohio State University, Pennsylvania State University, University of Portsmouth, Princeton University, the Spanish Participation Group, University of Tokyo, University of Utah, Vanderbilt University, University of Virginia, University of Washington, and Yale University.

The Pan-STARRS1 Surveys (PS1) and the PS1 public science archive have been made possible through contributions by the Institute for Astronomy, the University of Hawaii, the Pan-STARRS Project Office, the Max-Planck Society and its participating institutes, the Max Planck Institute for Astronomy, Heidelberg and the Max Planck Institute for Extraterrestrial Physics, Garching, The Johns Hopkins University, Durham University, the University of Edinburgh, the Queen's University Belfast, the Harvard-Smithsonian Center for Astrophysics, the Las Cumbres Observatory Global Telescope Network Incorporated, the National Central University of Taiwan, the Space Telescope Science Institute, the National Aeronautics and Space Administration under Grant No. NNX08AR22G issued through the Planetary Science Division of the NASA Science Mission Directorate, the National Science Foundation Grant No. AST-1238877, the University of Maryland, Eotvos Lorand University (ELTE), the Los Alamos National Laboratory, and the Gordon and Betty Moore Foundation.

This publication makes use of data products from the Two Micron All Sky Survey, which is a joint project of the University of Massachusetts and the Infrared Processing and Analysis Center/California Institute of Technology, funded by the National Aeronautics and Space Administration and the National Science Foundation.

Based on observations obtained as part of the VISTA Hemisphere Survey, ESO Progam, 179.A-2010 (PI: McMahon)

This publication makes use of data products from the Wide-field Infrared Survey Explorer, which is a joint project of the University of California, Los Angeles, and the Jet Propulsion Laboratory/California Institute of Technology, and NEOWISE, which is a project of the Jet Propulsion Laboratory/California Institute of Technology. WISE and NEOWISE are funded by the National Aeronautics and Space Administration.

This research is based in part on data collected at the Subaru Telescope, which is operated by the National Astronomical Observatory of Japan. We are honored and grateful for the opportunity of observing the Universe from Maunakea, which has the cultural, historical, and natural significance in Hawaii.

This work has made use of data from the European Space Agency (ESA) mission #emph[Gaia] (#link("https://www.cosmos.esa.int/gaia")), processed by the #emph[Gaia] Data Processing and Analysis Consortium (DPAC, #link("https://www.cosmos.esa.int/web/gaia/dpac/consortium")). Funding for the DPAC has been provided by national institutions, in particular the institutions participating in the #emph[Gaia] Multilateral Agreement.

#pagebreak()
#set page(columns: 1)

= PROSPECTOR MODELING DETAILS
<app:prospector>

Here we present additional details on our `Prospector` modeling. For hosts with photometric coverage $gt.eq$ 2 microns in the rest-frame (i.e. WISE or #emph[Spitzer] coverage), we include additional parameters on IR dust emission and/or the presence of an AGN. To model IR dust emission, we use the three-component #cite(<DraineandLi07>, form: "prose") dust emission model included in `FSPS`. As the WISE and #emph[Spitzer] data available for these hosts do not extend into the FIR, we choose to only set `duste‘_qpah`, the polycyclic aromatic hydrocarbon mass fraction, as a free parameter and not include the other two components. This choice balances the dimensionality of the model with the available data, ensuring the model is not underconstrained by our dataset. For the AGN prior, we use the two-component AGN model from #cite(<Nenkova08>, form: "prose") with both components set free. We alternate turning the dust emission and AGN models on and off in various linear combinations with the other parameters in order to determine which model fits the data best. The final model is then chosen through a combination of visual inspection of the agreement between the model and data and the evidence value of the model, a statistical measure of the “goodness” of the fit.

For the fitting of nebular emission lines, `Prospector`'s nebular marginalization template fits a Gaussian to each emission line. The Gaussians have the same widths in velocity-space. As the marginalization procedure is purely mathematical (see Appendix E of #cite(<Johnson-21>, style: "aas_noparen.csl") for further details), there are no physics in place to prevent the prediction of negative emission lines; this more likely to happen for spectra with low S/N. In order to determine when to include this template in the final model, we use a combination of visual inspection of the model spectrum and the convergence of the `eline‘_sigma` parameter (which describes the emission line widths). 14 FRB hosts had spectra with high enough S/N to include nebular marginalization in the final model. For the remaining eight hosts with usable spectra, we instead use the `nebemlineinspec` prior, which adds the emission lines to the model spectrum following a pre-built CLOUDY grid #cite(<Byler-17>).

In this work, we use a non-parametric SFH, characterized by the `continuity` prior in `Prospector`. This prior prefers a flat SFH: in other words, any observed deviation from a constant SFH is driven by the data. By definition, a non-parametric SFH does not impose an #emph[a priori] functional form onto the galaxy's SFH. Instead, the galaxy is allowed to form mass as it sees fit within each age bin, leading to a data-driven SFH that is more physically realistic than parametric models.

As we use eight age bins in this work, the `continuity` prior outputs seven parameters describing the logarithm of the ratio of the star formation rates between adjacent age bins. To convert this to star formation rates in each age bin, we use the convenience function `logsfr‘_ratios‘_to‘_sfrs` in the `prospect.models.transforms` module of `Prospector`#footnote[https:\/\/ui.adsabs.harvard.edu/abs/2022zndo...6192136J/abstract]. We then construct the star formation history from these values. We calculate mass-weighted age by summing the product of the SFR for each age bin and the square of the length of the age bin, then dividing by the mass formed. This value is calculated for each model iteration, weighted by their likelihood weights. We then construct a distribution of these values and report the median, 16th, and 84th quantiles. Additionally, we report the 100 Myr integrated star formation rate ($log ( upright("SFR")_(upright("0") - upright("100") thin upright("Myr")) )$) -- the average of the two most recent age bins, spanning 0--30 Myr and 30--100 Myr, weighted by the width of the age bin. This calculation is done using 1000 representative samples of the model, weighted by their likelihood weights. This metric describes the current day star formation rate and is sensitive to both the older (30--100 Myr) and younger (0--30 Myr) recently formed stars.

To calculate the stellar mass formed, we retrieve the mass fraction by calling `model.predict` for a random sample of 1000 model iterations. We multiply by the total mass formed for the associated model iteration. The resulting 1000 values are thus a representative distribution of stellar masses, from which we report the median and 68% confidence intervals.

= SEDs
<sec:SEDs>

Here we present the SEDs of all hosts modeled in this work. See @sec:prospector for more details on the `Prospector` modeling.

// [figvision-cn] imgs/FRB20121102A_SED_final.png
// 该图由上下两个子图组成，共同展示快速射电暴 FRB
// 20121102A 的光谱能量分布（SED）。上方子图（a）为宽波段
// 光谱与测光数据综合图，下方子图（b）为 Gemini-N/GMOS 仪
// 器的局部光学光谱。 子图（a）类型为曲线图。标题为 FRB
// 20121102A，副标题为 Rest-Frame Wavelength [Å]。下方横
// 轴为 Observed Wavelength [Å]，范围自约 4000 至 40000，
// 主刻度间隔 5000；上方横轴为 Rest-Frame Wavelength [Å]，
// 刻度为 5000、10000、15000、20000、25000、30000。纵轴为
// Fν [μJy]，即通量密度，范围自 -10 至 100，主刻度间隔 20。
// 图例位于右上角：浅蓝色实心带表示观测光谱（Observed
// spectrum），灰色实心带表示观测光谱不确定度（Observed
// spectrum uncertainty），黑色实线表示模型光谱（Model
// spectrum），蓝色空心圆表示观测测光（Observed
// photometry），红色空心方块表示模型测光（Model
// photometry）。观测光谱浅蓝带在 5500–7000 Å 范围内具有
// 若干尖锐发射线，其中两个最高峰位于约 6100 Å 和 7100 Å，
// 峰值分别约 80 μJy 和 90 μJy；在 7000 Å 以上，观测光谱
// 主要贴近零线，伴有较小的波动。模型光谱黑色实线表现为平
// 滑的连续谱，在 5500–7500 Å 同样呈现两个宽峰但幅度明显
// 低于观测尖峰，其余波段缓慢变化并接近于零。观测测光点由
// 蓝色圆圈及误差棒表示，分布在约 6000、6500、7000、7500、
// 8000、10000、11000、12000、13000、15000、21000、22000
// 和 36000 Å 处，通量值大多在 0–8 μJy 之间；对应的模型测
// 光由红色方块表示，位于同一位置并具有相似的数值，两者误
// 差棒重叠。子图（a）传达的结论是：模型连续谱能够大致匹
// 配测光数据点的整体水平，但观测到的发射线强度远高于模型
// 预测的连续谱变化。 子图（b）类型为曲线图。纵轴为 Fν [μ
// Jy]，范围自 -10 至 100，主刻度为 0、50、100。横轴为
// Observed Wavelength [Å]，范围自约 5800 至 8800，主刻度
// 为 6000、6500、7000、7500、8000、8500。左上角标注文字
// 为 z=0.1930 与 Gemini-N/GMOS，表示该光谱的 redshift 和
// 观测仪器。该子图仅包含浅蓝色实心带表示的观测光谱及其灰
// 色不确定度。光谱在约 6000 Å 至 6150 Å 之间出现一组明显
// 的窄发射线，最高峰位于约 6120 Å，峰值约 70 μJy，其左侧
// 紧邻较小的峰约 6010 Å、6020 Å 处；在约 7800 Å 处出现另
// 一根孤立的尖发射线，峰值约 85 μJy；其余波段主要在 0 μ
// Jy 附近存在小幅噪声波动。子图（b）传达的趋势是：在光学
// 波段内存在若干显著的窄发射线，其中两根最强，分别位于
// 6120 Å 和 7800 Å 附近。
#figure(scope: "parent", [#box(image("imgs/FRB20121102A_SED_final.png", width: 100%)) <fig:121102_SED>

  ],
  caption: [
    SED of FRB 20121102A.
  ]
)
<fig:121102_SED>

// [figvision-cn] imgs/FRB20180301A_SED_final.png
// 该图由上下两个子图组成，总标题为 FRB 20180301A，展示该
// 快速射电暴宿主星系的光谱能量分布（SED）及光谱细节。 子
// 图 a（上图）为光谱能量分布曲线图。下横轴为观测波长（
// Observed Wavelength），单位为埃（Å），范围约 4000 至
// 25000 Å，主刻度 5000、10000、15000、20000、25000；上横
// 轴为静止波长（Rest-Frame Wavelength），范围 2000 至
// 18000 Å，主刻度 2000、4000、6000、8000、10000、12000、
// 14000、16000、18000。纵轴为流量密度 Fν，单位微央斯基（
// μJy），范围约 -30 至 120 μJy，刻度 0、50、100。浅青色
// 实线（带填充的噪声）表示观测光谱（Observed spectrum），
// 其下方灰色阴影区域表示观测光谱不确定性（Observed
// spectrum uncertainty）。黑色实线表示模型光谱（Model
// spectrum）。蓝色空心圆圈内带加号表示观测测光数据点（
// Observed photometry），红色空心方形表示模型测光数据点
// （Model photometry），两者在约 4500、5100、5500、6000、
// 6400、7500、8800、12000、16500、21500 Å 处成对出现，模
// 型点几乎完全重合于观测点。观测光谱在约 8800 Å 处出现一
// 个尖锐发射线峰，峰值约 120 μJy，在约 5000 至 8000 Å 之
// 间存在较宽的噪声包络。除该发射线外，模型光谱为一条平缓
// 变化的连续谱，由短波端约 5 μJy 缓慢上升至约 12000 Å 处
// 约 20 μJy，之后保持近乎平坦至 25000 Å 处。总体上，模型
// 连续谱与测光点吻合良好，而观测光谱在 8800 Å 处的强发射
// 线显著偏离模型连续谱。 子图 b（下图）为光谱细节曲线图。
// 横轴为观测波长（Observed Wavelength），单位 Å，范围约
// 4500 至 9200 Å，主刻度 5000、6000、7000、8000、9000。
// 纵轴为流量密度 Fν，单位 μJy，范围约 -40 至 110 μJy，刻
// 度 0、100。浅青色实线表示观测光谱，其噪声基线围绕 0 μ
// Jy 波动，在约 5000 Å 附近出现宽幅噪声起伏。黑色实线表
// 示模型光谱，整体接近 0 μJy 的平坦连续谱，但在约 5000、
// 5890、6560、8500、8800、9050 Å 处出现尖锐发射线峰，其
// 中 8800 Å 附近峰最高（约 100 μJy），6560 Å 附近次之（
// 约 30 μJy）。左上角标注文字为 “z=0.3303” 和 “Keck/
// DEIMOS”，表明该光谱由 Keck/DEIMOS 仪器观测，红移 z=
// 0.3303。该子图展示了观测光谱与模型光谱在静止波长对应位
// 置上的发射线特征，以及观测光谱的噪声水平。
#figure(scope: "parent", [#box(image("imgs/FRB20180301A_SED_final.png", width: 100%)) <fig:180301_SED>

  ],
  caption: [
    SED of FRB 20180301A.
  ]
)
<fig:180301_SED>

// [figvision-cn] imgs/FRB20180916B_SED_final.png
// 该图由上下两个子图组成，总标题为 FRB 20180916B。上方子
// 图顶部另标注 Rest-Frame Wavelength [Å]。两个子图的纵轴
// 均为 Fν [μJy]，采用对数刻度。 子图 a（上方主图）：类型
// 为光谱与测光数据叠加的曲线图。底部横轴为 Observed
// Wavelength [Å]，范围约 0 至 250000 Å，主刻度为 50000、
// 100000、150000、200000、250000；顶部横轴为 Rest-Frame
// Wavelength [Å]，主刻度为 50000、100000、150000、200000。
// 纵轴范围约 10^2 至 3×10^3 μJy，主刻度为 10^2、10^3。图
// 中有一条黑色实线表示 Model spectrum，呈现多个宽峰与吸
// 收谷的起伏；浅蓝色带表示 Observed spectrum，灰色带表示
// Observed spectrum uncertainty，二者在观测波段内与模型
// 谱线基本重合。带误差棒的蓝色空心圆点表示 Observed
// photometry，带误差棒的红色空心方块表示 Model
// photometry；这些测光点在观测波长约 1.5×10^4、3×10^4、5
// ×10^4、1.15×10^5、2.25×10^5 Å 处出现，且模型测光点与观
// 测测光点在对应波长处高度一致。图例位于右下角，包含上述
// 五个条目。该子图传达的趋势是：模型光谱在观测波段内与观
// 测光谱及测光点吻合良好，光谱在静止系约 60000–70000 Å
// 和 110000–120000 Å 附近出现明显起伏。 子图 b（下方局部
// 放大图）：类型为局部光谱放大曲线图。横轴为 Observed
// Wavelength [Å]，范围约 6100 至 7700 Å，主刻度为 6200、
// 6400、6600、6800、7000、7200、7400、7600。纵轴为 Fν [μ
// Jy]，范围约 5×10^2 至 3×10^3 μJy，主刻度为 6×10^2、10^
// 3、2×10^3、3×10^3。左上角标注文字为 z=0.0327 和 Keck/
// LRIS。图中浅蓝色折线为观测光谱，灰色带为其不确定度；黑
// 色实线为模型光谱，在约 6800 Å 处呈现一个尖锐的发射峰，
// 在约 6900 Å 和 7000 Å 附近有较小的峰。该子图传达的趋势
// 是：在局部波段内，模型光谱与观测光谱总体吻合，且模型在
// 6800 Å 附近捕捉到了观测光谱中的尖锐发射特征。
#figure(scope: "parent", [#box(image("imgs/FRB20180916B_SED_final.png", width: 100%)) <fig:180916_SED>

  ],
  caption: [
    SED of FRB 20180916B.
  ]
)
<fig:180916_SED>

// [figvision-cn] imgs/FRB20180924B_SED_final.png
// 该图由上下排列的两个子图组成，总标题为 FRB 20180924B，
// 整体展示该快速射电暴宿主星系的光谱能量分布（SED）。 上
// 方子图（子图 a）：曲线图，展示宽波段光谱能量分布及模型
// 拟合。 坐标轴：底轴为观测波长（Observed Wavelength），
// 单位埃（Å），范围 4000 至 40000；顶轴为静止系波长（
// Rest-Frame Wavelength），单位 Å，范围 5000 至 30000；
// 纵轴为流量密度 Fν，单位微央斯基（μJy），采用对数刻度，
// 范围 10^0 至略高于 10^2。 图例与数据内容：浅蓝色实线为
// 观测光谱（Observed spectrum）；灰色区域为观测光谱不确
// 定度（Observed spectrum uncertainty）；黑色实线为模型
// 光谱（Model spectrum）；带误差棒的蓝色圆点为观测测光数
// 据（Observed photometry）；带误差棒的红色方形为模型测
// 光数据（Model photometry）。 数据趋势：在观测波长约
// 4000 至 6000 Å 区间，流量密度从约 1.5 μJy 快速上升至约
// 30 μJy；在 6000 至 10000 Å 区间，模型光谱呈现平缓平台，
// 流量密度维持在 30 至 40 μJy，而观测光谱在此处出现剧烈
// 的锯齿状波动，并伴随显著的灰色不确定度带；在 10000 至
// 30000 Å 区间，模型光谱在约 10^2 μJy 附近保持相对平坦，
// 具有轻微的起伏，至 40000 Å 处略微下降至约 50 μJy。观测
// 测光点（蓝色圆点）与模型测光点（红色方形）在各个波段位
// 置高度重合，表明模型与观测数据吻合良好。 下方子图（子
// 图 b）：曲线图，展示局部波段的高分辨率光谱细节。 坐标
// 轴：横轴为观测波长，单位 Å，范围 4500 至 9500；纵轴为
// 流量密度 Fν，单位 μJy，采用对数刻度，范围 10^1 至 10^2。
// 标注文字：左上角标有“z=0.3212”以及“VLT/MUSE”，表明该数
// 据来自甚大望远镜（VLT）的 MUSE 仪器，且宿主星系红移为
// 0.3212。 数据内容：浅蓝色带表示观测光谱的误差范围或不
// 确定度，深青色折线表示观测光谱本身。 数据趋势：光谱在
// 整段波长范围内呈现出明显的起伏。在 5000 至 5500 Å 区间，
// 存在多个尖锐的吸收特征，流量密度降至约 10 μJy 以下；随
// 后流量密度逐渐上升，在 6000 Å 附近达到约 20 μJy，并在
// 6000 至 8000 Å 之间保持相对平稳的缓慢上升趋势。在 8000
// Å 之后，光谱出现数个显著的发射线尖峰，其中在约 8300 Å
// 处的尖峰最为突出，流量密度跃升至接近 10^2 μJy。
#figure(scope: "parent", [#box(image("imgs/FRB20180924B_SED_final.png", width: 100%)) <fig:180924_SED>

  ],
  caption: [
    SED of FRB 20180924B.
  ]
)
<fig:180924_SED>

// [figvision-cn] imgs/FRB20181112A_SED_final.png
// 该图由上下两个子图组成，顶部中央有总标题“FRB 20181112A
// ”。上子图横轴有两套刻度：顶部为静止系波长，范围3000至
// 9000埃米，主刻度间隔1000埃米；底部为观测波长，范围约
// 4000至14000埃米，主刻度间隔2000埃米。纵轴表示流量密度，
// 单位为微央斯基，范围约负10至135，主刻度间隔25微央斯基。
// 图中元素包括：浅蓝色细折线表示观测光谱，其噪声在观测波
// 长9000至10000埃米及右侧区间较大；灰色半透明阶梯带表示
// 观测光谱的不确定度；黑色实线表示模型光谱，在观测波长约
// 9800埃米处出现尖锐强发射峰，峰值约130微央斯基。散点符
// 号表示测光数据：蓝色空心圆点带竖向误差棒，表示观测测光，
// 位于约6500、7900、9800、9900、12600埃米处；红色空心方
// 块带竖向误差棒，表示模型测光，与观测测光位置接近但数值
// 略有差异。上方子图可见观测光谱在某些波长处有明显噪声尖
// 峰，而模型光谱整体平缓，仅在约9800埃米处出现强发射线。
// 下子图是上子图在观测波长6150至9800埃米区间的局部放大，
// 横轴为观测波长，范围约6150至9800埃米，主刻度间隔500埃
// 米；纵轴为流量密度，范围约负20至100微央斯基，主刻度间
// 隔50微央斯基。图中左上角标注“z=0.4753”和“VLT/FORS2”。
// 该子图中浅蓝色折线为观测光谱，黑色实线为模型光谱，黑色
// 曲线整体在0至20微央斯基附近波动，在约9300埃米处有一个
// 宽峰约15微央斯基，在约9700埃米处有一个尖峰约10微央斯基，
// 但观测光谱在9000至9800埃米区间噪声显著增大。该子图说明
// 观测光谱在红移后的静止系波长下与模型光谱整体一致，但观
// 测数据在较长波长处噪声较大，模型光谱在约9800埃米处有强
// 发射特征，而该特征在局部放大图中未显示。
#figure(scope: "parent", [#box(image("imgs/FRB20181112A_SED_final.png", width: 100%)) <fig:181112_SED>

  ],
  caption: [
    SED of FRB 20181112A.
  ]
)
<fig:181112_SED>

// [figvision-cn] imgs/FRB20190102C_SED_final.png
// 该图由上下两个面板组成，展示快速射电暴FRB 20190102C的
// 光谱能量分布（SED），总标题为“FRB 20190102C”。 上方面
// 板：横轴为观测波长（Observed Wavelength [Å]），范围
// 2000至17000 Å，底部刻度显示2000、4000、6000、8000、
// 10000、12000、14000、16000；顶部横轴标注静止参考系波长
// （Rest-Frame Wavelength [Å]），刻度为2000、4000、6000、
// 8000、10000、12000，刻度位置与底部对应（按红移换算）；
// 纵轴为流量密度 Fν [μJy]，范围-20至150，显示0、50、100、
// 150刻度。图中图例：浅蓝色（cyan）填充区域为“Observed
// spectrum”（观测光谱），深灰色（gray）水平带表示其不确
// 定性（“Observed spectrum uncertainty”），黑色实线为“
// Model spectrum”（模型光谱），蓝色空心圆圈为“Observed
// photometry”（观测测光），红色空心方块为“Model
// photometry”（模型测光）。观测光谱在观测波长约6000–9500
// Å（对应静止系约4700–7400 Å）范围内有显著信号，呈不规则、
// 噪声较大的宽包络并含尖锐发射峰，其中约8400 Å处有一个最
// 高的窄发射尖峰（Fν≈125 μJy）；模型光谱为一条平滑曲线，
// 带有若干小幅度发射线，整体水平略高于0，并在约8500 Å附
// 近有一个小峰。测光点分别位于观测波长约3500、4200、6300、
// 8000、8800、15500 Å处（对应红色空心方块和蓝色空心圆圈），
// 其中前两个测光点Fν接近0（约5 μJy以下），中间三个在0–20
// μJy之间，最后一个在15000 Å附近约15 μJy；观测测光点与模
// 型测光点基本重叠，模型测光点位于各观测测光点下方约几μ
// Jy。 下方面板：为上方光谱在观测波长约6200–8800 Å区域的
// 放大显示。横轴为观测波长（Observed Wavelength [Å]），
// 范围约6200–8800，显示6500、7000、7500、8000、8500刻度；
// 纵轴为Fν [μJy]，范围-30至100，显示0、50、100刻度。图中
// 左上角标注“z=0.2909”和“VLT/FORS2”，表明该光谱由VLT/
// FORS2仪器获得，红移z=0.2909；图例沿用上部：浅蓝色（
// cyan）为观测光谱，深灰色为不确定性，黑色实线为模型光谱。
// 该放大区域中观测光谱具有高频噪声，含多个窄发射/吸收特
// 征；最显著的窄发射峰位于约8400 Å处，峰值Fν约80 μJy；另
// 外在约7100 Å处有一个较小的发射峰（峰值约25 μJy），约
// 6700 Å处有微弱的局域峰；模型光谱在约8450 Å处有一个对应
// 的小发射峰，峰值约15–20 μJy，其余位置平缓。图下方横轴
// 刻度与上方一致，标明观测波长。
#figure(scope: "parent", [#box(image("imgs/FRB20190102C_SED_final.png", width: 100%)) <fig:190102_SED>

  ],
  caption: [
    SED of FRB 20190102C.
  ]
)
<fig:190102_SED>

// [figvision-cn] imgs/FRB20190520B_SED_final.png
// 这是一张上下双面板的光谱能量分布图，总标题为“FRB
// 20190520B”。图中展示的是该快速射电暴宿主星系的光学光谱
// 和测光数据。 上半部分子图：主光谱能量分布图。横轴有两
// 个刻度标尺。底部为观测波长，单位埃，范围从约3000到
// 15000，主刻度为4000、6000、8000、10000、12000、14000。
// 顶部为静止系波长，刻度为4000、6000、8000、10000、12000。
// 纵轴为通量密度，单位微 Jy，范围从-20到80，主刻度步长20。
// 图例位于右上角，包含五个条目：浅蓝色条带表示“观测光谱”，
// 灰色条带表示“观测光谱不确定度”，黑色实线表示“模型光谱”，
// 带圆圈的蓝色数据点（带误差棒）表示“观测测光”，带方框的
// 红色数据点表示“模型测光”。数据趋势为：观测光谱（浅蓝）
// 在观测波长6200至9000埃之间呈现密集的波动，包含数个明显
// 的发射线尖峰，最高峰约在8300埃附近接近80微 Jy；此波段
// 之外的观测光谱以水平线形式显示不确定度（灰色），中线为
// 零。模型光谱（黑线）是一条低而平缓的连续谱，从左至右从
// 约5微 Jy缓慢下降至约2微 Jy。观测测光点（蓝圈）和模型测
// 光点（红方框）在观测波长约4500、5000、6200、7200、9800、
// 12500埃处对应良好，与模型光谱水平一致；在约3500埃处有
// 一个独立的蓝色向下三角形数据点。 下半部分子图：局部放
// 大的观测光谱。左上角标注“z=0.2417”，下方标注“Keck/
// DEIMOS”，说明观测仪器。横轴为观测波长，单位埃，范围从
// 约6200到9300，主刻度为6500、7000、7500、8000、8500、
// 9000。纵轴为通量密度，单位微 Jy，范围从约-20到60，主刻
// 度为0和50。图中浅蓝色实线为观测光谱，灰色条带为其不确
// 定度，黑色实线为模型光谱。该局部图清晰展示出观测光谱中
// 在约6530埃、6860埃、7200埃、8200埃、8650埃、8850埃、
// 9050埃处存在多个尖锐的发射线，最高峰在约8200埃处超过60
// 微 Jy；模型光谱在此波段保持平坦在约2至5微 Jy。
#figure(scope: "parent", [#box(image("imgs/FRB20190520B_SED_final.png", width: 100%)) <fig:190520_SED>

  ],
  caption: [
    SED of FRB 20190520B.
  ]
)
<fig:190520_SED>

// [figvision-cn] imgs/FRB20190608B_SED_final.png
// 本图由上下排列的两个子图组成，总标题为 FRB 20190608B。
// 两个子图共享纵轴物理量流量密度 Fν，单位为微央斯基（μJy），
// 均采用对数刻度。 子图 a（上图）：光谱能量分布图（曲线
// 图）。下横轴为观测波长（Observed Wavelength），单位为
// 埃（Å），范围约从 3000 到 150000 Å；上横轴为静止系波长
// （Rest-Frame Wavelength），单位为埃（Å），标度从 20000
// 到 120000。纵轴 Fν 为对数刻度，范围从 10^1 到 10^3 以
// 上 μJy。 图中包含以下数据系列： 浅蓝色实线（Observed
// spectrum，观测光谱）：在短波长端（约 4000 Å 以下）数据
// 存在强烈波动，表现为多个尖锐的吸收/发射特征，随后逐渐
// 平稳升高。 灰色阴影区域（Observed spectrum uncertainty，
// 观测光谱不确定度）：围绕浅蓝色观测光谱，表示其误差范围，
// 在短波长端较宽，长波长端较窄。 黑色实线（Model
// spectrum，模型光谱）：从短波长端到长波长端贯穿整个图幅，
// 呈现平滑变化的趋势，在约 7000 Å、8500 Å、13000 Å 等位
// 置出现宽峰结构。 带误差棒的蓝色空心圆圈（Observed
// photometry，观测测光数据）：共约 10 个数据点，分布于观
// 测波长约 4000 至 120000 Å 之间，纵轴值在 10^2 至 10^3
// μJy 附近，误差棒为黑色垂直短线。 红色空心方块（Model
// photometry，模型测光数据）：与蓝色圆圈位置对应，表示模
// 型在相应波段的预期测光值。 趋势与结论：观测光谱与模型
// 光谱在整体趋势上一致，测光数据点紧贴模型光谱，说明模型
// 能够较好地拟合观测到的光谱能量分布。 子图 b（下图）：
// 局部放大的光谱图（曲线图）。横轴为观测波长（Observed
// Wavelength），单位为埃（Å），范围约从 3800 到 8500 Å。
// 纵轴 Fν 为对数刻度，范围从 10^2 到 10^3 以上 μJy。 图
// 中左上角标注文字：“z=0.1178”和“SDSS”。 图中包含以下数
// 据系列： 浅蓝色实线：表示该波段范围内的观测光谱，呈现
// 大量细密的波动，尤其在 4000–5000 Å 区间波动剧烈，包含
// 多个尖锐的吸收特征（向下凹陷）。 灰色阴影带：围绕浅蓝
// 色实线，表示观测光谱的误差范围，在短波长端较宽，向长波
// 长端逐渐变窄。 黑色实线：表示模型光谱，整体呈缓慢上升
// 趋势，并在约 4300 Å、5900 Å、7300 Å 等位置标出明显的窄
// 发射线峰。 趋势与结论：该子图展示了光学波段内光谱的细
// 节，模型光谱捕捉到了主要的发射线特征，而观测光谱在短波
// 长端表现出更强的噪声和吸收特征。
#figure(scope: "parent", [#box(image("imgs/FRB20190608B_SED_final.png", width: 100%)) <fig:190608_SED>

  ],
  caption: [
    SED of FRB 20190608B.
  ]
)
<fig:190608_SED>

// [figvision-cn] imgs/FRB20190611B_SED_final.png
// 该图由上下两个面板组成，展示快速射电暴 FRB 20190611B
// 的光谱能量分布（SED）。图中采用双横轴设计：底部横轴为
// 观测波长，顶部横轴为静止系波长。 图 a（上方面板）：标
// 题为“FRB 20190611B”，顶部横轴标有“Rest-Frame
// Wavelength [Å]”，刻度范围为 3000 至 7000 埃；底部横轴
// 标有“Observed Wavelength [Å]”，刻度范围为 3000 至
// 11000 埃；纵轴标有“Fν [μJy]”，刻度范围为 0 至 50 微央
// 斯基。图中包含四条信息：浅蓝色带显示观测光谱，包含大量
// 噪点；深灰色带显示观测光谱的不确定度，在观测波长约
// 6000 至 9500 埃区间内可见；黑色实线表示模型光谱，呈现
// 为一个平滑的连续谱，并在静止系波长约 5876 埃和 5007 埃
// 处出现两条明显发射线，在顶部坐标轴上其位置分别对应约
// 8100 埃和 6900 埃；蓝色圆圈带误差棒表示观测测光点，红
// 色方框表示模型测光点，观测测光点分别位于观测波长约
// 4600 埃、6300 埃、7800 埃和 7900 埃处，其中后三个观测
// 点与模型光谱预测的发射线位置吻合。该子图表明，模型光谱
// 在连续谱的基础上能较好地拟合观测到的测光点。 图 b（下
// 方面板）：左上角标注有“z=0.3778 VLT/FORS2”，表示该光谱
// 源于甚大望远镜（VLT）的 FORS2 仪器，红移值为 0.3778。
// 底部横轴标有“Observed Wavelength [Å]”，刻度范围为 6500
// 至 9000 埃；纵轴标有“Fν [μJy]”，刻度范围为 0 至 20 微
// 央斯基。图中有一条浅蓝色带，显示观测光谱数据，呈现连续
// 的噪声波动，并包含几个显著峰值：在观测波长约 6750 埃和
// 7050 埃处有较小的发射峰；在约 8450 埃处出现主发射峰，
// 最高峰值约为 20 微央斯基；在约 8550 埃处还有一个较小的
// 峰。该子图展示了该 FRB 宿主星系中特定发射线的观测光谱。
#figure(scope: "parent", [#box(image("imgs/FRB20190611B_SED_final.png", width: 100%)) <fig:190611_SED>

  ],
  caption: [
    SED of FRB 20190611B.
  ]
)
<fig:190611_SED>

// [figvision-cn] imgs/FRB20190711A_SED_new.png
// 这是一张单面板的科学曲线图，标题为“FRB 20190711A”，副
// 标题为“Rest-Frame Wavelength [Å]”。图的主横轴位于底部，
// 标签为“Observed Wavelength [Å]”，采用线性刻度，范围从
// 2000到18000，主刻度间隔为2000。顶部副横轴对应“
// Rest-Frame Wavelength [Å]”，同样为线性刻度，标注了2000、
// 4000、6000、8000、10000，其尺度与底部横轴对齐但数值范
// 围不同。纵轴标签为“F_ν [μJy]”，采用对数刻度，范围从10^
// -1到10^1，主刻度标注为10^-1、10^0、10^1。图中有一条灰
// 色连续曲线，在图例中标记为“Model spectrum”（模型光谱），
// 该曲线从左侧约2000 Å处约0.8 μJy起步，在4000–5000 Å之间
// 出现一个明显的阶跃上升，随后在6000–8000 Å之间呈现若干
// 尖锐的吸收/发射特征（表现为锯齿状的小幅波动），之后缓
// 慢上升并在10000–15000 Å区域趋于平缓，整体数值维持在约2
// –3 μJy。图中叠加了两组数据点：蓝色空心圆点带误差棒，图
// 例标记为“Observed photometry”（观测测光）；红色空心方
// 框，图例标记为“Model photometry”（模型测光）。观测测光
// 点大致位于观测波长约2800 Å（F_ν约0.8 μJy）、4800 Å（F_
// ν约1.2 μJy）、6300 Å（F_ν约0.9 μJy）和7900 Å（F_ν约1.6
// μJy）；模型测光方框大致位于观测波长约2800 Å（F_ν约0.8
// μJy）、4800 Å（F_ν约1.0 μJy）、6300 Å（F_ν约1.5 μJy）、
// 7900 Å（F_ν约1.8 μJy）和15100 Å（F_ν约2.5 μJy）。图例
// 位于右下角，包含灰色实线、蓝色空心圆和红色空心方框三个
// 条目。该图传达的趋势是：模型光谱在静止系约4000–5000 Å
// 处存在明显的通量跃变，观测测光点与模型测光点在大部分波
// 段吻合，但在6300 Å附近观测值略低于模型值，而在15100 Å
// 处仅有模型测光点而无对应观测点。
#figure(scope: "parent", [#box(image("imgs/FRB20190711A_SED_new.png", width: 100%)) <fig:190711_SED>

  ],
  caption: [
    SED of FRB 20190711A.
  ]
)
<fig:190711_SED>

// [figvision-cn] imgs/FRB20190714A_SED_final.png
// 本图由上下两个子图构成，顶部居中总标题为 FRB 20190714A，
// 整体展示该快速射电暴对应余辉或宿主星系的光谱能量分布（
// SED）。两子图均为曲线图，共享观测波长作为横轴方向，但
// 显示范围与纵轴数据不同。 子图 a 为上方大图，横轴为观测
// 波长 Observed Wavelength [Å]，采用对数刻度，从左至右范
// 围约 4000 至 60000 Å；顶部另设一平行横轴为静止系波长
// Rest-Frame Wavelength [Å]，刻度为 10000、20000、30000、
// 40000，对应下方的观测波长大约 10000、20000、30000、
// 40000 Å 的位置（受红移影响，两者略有偏移）。纵轴为 Fν
// [μJy]，采用对数刻度，范围从 10^0（1 μJy）至约 10^2 以
// 上。图例位于右下角，包含五个元素：浅青蓝色实线为
// Observed spectrum（观测光谱）；灰色实线为 Observed
// spectrum uncertainty（观测光谱不确定度）；黑色实线为
// Model spectrum（模型光谱）；蓝色空心圆圈为 Observed
// photometry（观测测光）；红色空心方块为 Model
// photometry（模型测光），并用红色带中心点的线穿过这些方
// 块表示模型测光值。图中黑线模型光谱显示：从 4000 Å 处约
// 3 μJy 起快速上升，在 8000 Å 附近达到约 20 μJy 并出现陡
// 峭下降（可能为吸收特征），随后在 10000 至 20000 Å 之间
// 升至约 100 μJy，之后在 20000 至 40000 Å 保持大致平坦的
// 百 μJy 水平，并有一个约 40000 Å 处的小鼓包，最后向
// 60000 Å 逐渐下降至约 20 μJy。浅青蓝观测光谱在 4000–
// 12000 Å 区间呈现密集、尖锐的噪声状起伏，部分峰谷达 10
// 倍以上，且与模型光谱有偏离；在 12000–60000 Å 区间该观
// 测光谱曲线变得极淡或几乎不可见，图例位置也覆盖了部分该
// 曲线。蓝色圆圈观测测光点分布约在 5000、6000、7000、
// 8500、10000、12000、16000、21000、33000、45000 Å 处，
// 测量值从约 2–3 μJy 逐步上升至约 100 μJy，并在长波段维
// 持约 70 μJy。红色方块的模型测光点与蓝色圆圈观测点位置
// 一致，且在短波段更贴近黑线模型，表明模型在 4000–16000
// Å 处拟合较好，而在 33000 和 45000 Å 处蓝色圆圈和红色方
// 块有误差棒，量值约分别为 70 μJy 和 50 μJy。黑色模型光
// 谱中包含一个尖锐的吸收特征（约 8000 Å 处）和数个吸收/
// 发射小齿（例如约 11000–12000 Å 附近及 40000 Å 附近的凸
// 起）。 子图 b 为下方小图，是上方 5500–8300 Å 观测光谱
// 范围的放大视图。横轴为 Observed Wavelength [Å]，线性刻
// 度，范围从 5500 到 8300 Å，主刻度为 5500、6000、6500、
// 7000、7500、8000。纵轴为 Fν [μJy]，线性刻度，主刻度标
// 有 10^2，从底部约 1–3 μJy 到顶部约 150 μJy。图左上方有
// 文字标注 z=0.2365 和 Keck/LRIS（即观测仪器为 Keck 望远
// 镜的 LRIS 光谱仪）。浅青蓝色实线为观测光谱，黑线为模型
// 光谱。黑线模型光谱在该波段相对平滑，在 6200 Å 附近有小
// 峰，在 8100–8250 Å 附近有数个明显尖峰（峰值约 120–150
// μJy），在 7600–7700 Å 附近有较小峰。浅青蓝色观测光谱叠
// 加于黑线模型光谱之上，整体围绕黑线波动，但在 6100–6250
// Å 区间出现明显的青色噪声尖峰；在 8000–8250 Å 区间观测
// 光谱显示出一系列尖锐的发射线状结构，强度与模型峰的形态
// 一致。总体趋势为观测光谱与模型光谱在 5500–8300 Å 范围
// 内大体符合，但观测光谱具有更显著的高频噪声；该子图明确
// 显示观测到的光谱具有显著的发射线特征，且模型光谱能复现
// 这些峰。
#figure(scope: "parent", [#box(image("imgs/FRB20190714A_SED_final.png", width: 100%)) <fig:190714_SED>

  ],
  caption: [
    SED of FRB 20190714A.
  ]
)
<fig:190714_SED>

// [figvision-cn] imgs/FRB20191001A_SED_final.png
// 这是一张标题为 FRB 20191001A 的光谱能量分布（SED）科学
// 插图，由上下两个子图组成。 子图类型为曲线图。上方主图
// 展示宽波段光谱能量分布：底部横轴为观测波长（Observed
// Wavelength [Å]），范围约 2000 到 25000 Å，刻度间隔
// 5000 Å；顶部横轴为静止参考系波长（Rest-Frame
// Wavelength [Å]），范围约 2500 到 20000 Å，刻度间隔
// 2500 Å。纵轴为流量密度 Fν [μJy]，采用对数坐标，范围 10
// ^1 到 10^3 μJy，刻度标有 10^1、10^2、10^3。图内包含五
// 种元素：浅蓝色（cyan）实线为观测光谱，灰色带为观测光谱
// 不确定度，黑色实线为模型光谱（整体呈上升后趋于平缓的趋
// 势，并在约 8000 Å 处出现一个尖锐的发射线峰），带蓝色内
// 点的蓝色空心圆圈为观测测光点，带红色内点的红色空心正方
// 形为模型测光点。观测测光点与模型测光点在约 4000、5000、
// 6000、7500、8500、10000、12000、15000、17000、21000 Å
// 等处密集分布，二者高度吻合，证明模型较好地拟合了观测数
// 据。灰色不确定度带在短波段（5500 Å 至 9500 Å 之间）波
// 动较大，表现出若干起伏；浅蓝观测光谱在 4000 至 7000 Å
// 区域呈现很强的噪声和剧烈波动。 下方子图展示可见光波段
// 的局部细节：横轴为观测波长 [Å]，范围 5000 到 9000 Å，
// 刻度间隔 500 Å；纵轴同样为流量密度 Fν [μJy]，对数坐标，
// 范围 10^1 到 10^3 μJy。图中绘有浅蓝色观测光谱曲线、灰
// 色不确定度带以及黑色模型光谱曲线。左上角标注文字为“z=
// 0.2342”和“Gemini-S/GMOS”。光谱曲线在 5000 到 9000 Å 之
// 间整体平缓上升，并在约 8100 至 8200 Å 处呈现一个尖锐的
// 双峰发射线特征（黑色模型线明显，浅蓝色观测线也有对应响
// 应）。此外，在约 5900 Å、6300 Å、6800 Å 附近可见较小的
// 发射线或吸收线痕迹。
#figure(scope: "parent", [#box(image("imgs/FRB20191001A_SED_final.png", width: 100%)) <fig:191001_SED>

  ],
  caption: [
    SED of FRB 20191001A.
  ]
)
<fig:191001_SED>

// [figvision-cn] imgs/FRB20200430A_SED_final.png
// 这是一张展示快速射电暴FRB 20200430A的光谱能量分布（SED）
// 的科学论文插图，由上下两个横向排列的面板组成，共用顶部
// 主标题“FRB 20200430A”。 上方主面板（光谱能量分布图）：
// 这是一个二维曲线图。下侧横轴为“Observed Wavelength [Å]
// ”（观测波长），以Å为单位，标注刻度从5000到25000，范围
// 约在3000至25000之间；上侧横轴为“Rest-Frame Wavelength
// [Å]”（静止系波长），标注刻度从5000到20000。左侧纵轴为“
// Fν [μJy]”（流量密度），以微焦每央斯基为单位，标注刻度
// 为0、50、100、150，范围从-10到150。 图中显示以下图层：
// 浅蓝色带（图例为“Observed spectrum”，观测光谱）在约
// 5000-7500Å区间内呈现高噪声的宽带波动；深灰色带（“
// Observed spectrum uncertainty”，观测光谱不确定度）紧随
// 观测光谱；一条黑色实线（“Model spectrum”，模型光谱）贯
// 穿全图，在约7600Å处有一个显著尖峰，在12500Å后平缓下降；
// 带蓝点的蓝色圆圈（“Observed photometry”，观测测光数据）
// 位于约4500、5500、7800、9200、12500、22000Å处；红色空
// 心方块（“Model photometry”，模型测光数据）位于4500、
// 5500、7800、9200、12500、22000Å处。图中蓝点与红方块在
// 大多数波段吻合，但在约12500Å处蓝点（约45μJy）高于红方
// 块（约20μJy），在约22000Å处蓝点（约5μJy）低于红方块（
// 约20μJy），模型在7600Å处的尖峰与观测光谱的最高峰相符。
// 下方局部面板（光谱放大图）： 这是一个二维曲线图，是上
// 方图在特定波段的放大。横轴为“Observed Wavelength [Å]”
// （观测波长），标注刻度从5500到7500，范围约在5200至7800
// 之间。纵轴为“Fν [μJy]”，标注刻度为0、50、100，范围从
// -30到100。 图中显示浅蓝色的高分辨率观测光谱曲线，波动
// 范围在0到30μJy之间，包含若干较弱的发射线（如在约5900Å、
// 6800Å处的小峰）。一条黑色实线叠加在光谱上，在7300Å之后
// 出现显著陡增的尖峰，最高峰位于约7600Å，峰后伴随较小的
// 波动。在左上角标注有黑色文字“z=0.1607”和“Keck/DEIMOS”，
// 说明该光谱来自凯克望远镜的DEIMOS仪器，红移值为0.1607，
// 峰值在静止系对应约6600Å，为Hα发射线。图中蓝色光谱与黑
// 色模型在低波长段吻合良好，在7600Å处的强发射峰也与模型
// 拟合一致。
#figure(scope: "parent", [#box(image("imgs/FRB20200430A_SED_final.png", width: 100%)) <fig:200430_SED>

  ],
  caption: [
    SED of FRB 20200430A.
  ]
)
<fig:200430_SED>

// [figvision-cn] imgs/FRB20200906A_SED_final.png
// 该图由上下两个子图组成，总标题为“FRB 20200906A”。上图
// 纵轴顶部的第一个刻度文字在图中被截断，但通过曲线最高峰
// 位于该纵轴附近，可推断其数值为1000，无其他可读内容。
// 子图a（上图）为光谱与测光数据曲线图，绘出了快速射电暴
// 余辉的光谱能量分布（SED）。横轴（下）为观测波长，单位
// 为埃（Å），范围约3000至60000，主刻度为10000、20000、
// 30000、40000、50000、60000。横轴（上）为静止系波长，范
// 围约2500至40000，主刻度为5000、10000、15000、20000、
// 25000、30000、35000、40000。纵轴为流量密度Fν，单位为微
// 央斯基（μJy），范围约-100至900，主刻度为0、200、400、
// 600、800。图例位于右上角：浅蓝色带表示观测光谱，灰色轮
// 廓表示观测光谱不确定度，黑色实线表示模型光谱，蓝色圆圈
// 带中心点及上下误差棒表示观测测光数据点，红色方框表示模
// 型测光数据点。观测光谱在观测波长约9000至10000 Å处呈现
// 一个显著的窄发射线峰，峰值接近800 μJy；模型光谱则呈现
// 平滑的连续谱形态，在观测波长约6000至10000 Å上升至约100
// μJy，随后向长波方向缓慢下降至约20 μJy。在观测波长约
// 3600、4500、6000、7700、21000、34000、46000 Å处分别标
// 有观测测光点，对应流量密度约为20、30、45、60、75、60、
// 45 μJy，误差棒较小；模型测光点在这些位置与观测值基本吻
// 合。子图传达的趋势是：在观测波长约9000至10000 Å处存在
// 强发射线，而模型光谱在长波方向呈现平缓下降的连续谱，观
// 测测光点与模型测光点在宽波段上一致。 子图b（下图）为局
// 部放大的光谱曲线图。横轴为观测波长，单位为Å，范围约
// 3000至9200，主刻度为5000、6000、7000、8000、9000。纵轴
// 为流量密度Fν，单位为μJy，范围约-100至900，主刻度为0、
// 500。左上角标注文字为“z=0.3688”和“Keck/DEIMOS”，表明该
// 光谱由凯克望远镜的DEIMOS仪器获取，红移为0.3688。图中浅
// 蓝色曲线表示观测光谱，灰色轮廓表示不确定度，可见多处窄
// 发射线或吸收线特征：在观测波长约3800、4400、5000、5900、
// 6900、7800、9000 Å处有较小的尖峰或下凹，其中在约9000 Å
// 处有一个非常显著的尖峰，峰值接近800 μJy，与上图观测光
// 谱的强发射线峰对应。子图传达的趋势是：该光谱在约9000 Å
// 处存在强发射线，且在其他波长处存在多个弱发射线或吸收线
// 特征，整体连续谱流量密度较低，多数在0至50 μJy之间波动。
#figure(scope: "parent", [#box(image("imgs/FRB20200906A_SED_final.png", width: 100%)) <fig:200906_SED>

  ],
  caption: [
    SED of FRB 20200906A.
  ]
)
<fig:200906_SED>

// [figvision-cn] imgs/FRB20201124A_SED_final.png
// 该图由上下两个子图组成，总标题为“FRB 20201124A”，用于
// 展示该快速射电暴余辉的光谱能量分布（SED）。 子图a位于
// 上方，是曲线图，标题为“Rest-Frame Wavelength [Å]”（静
// 止系波长，单位埃），刻度标注在顶部边框，范围从50000到
// 200000，主刻度间隔50000。左侧纵轴为“Fν [μJy]”（流量密
// 度，单位微央斯基），采用对数坐标，范围从约30到10000。
// 底部横轴为“Observed Wavelength [Å]”（观测波长，单位埃），
// 线性坐标，范围从约3000到250000，主刻度间隔50000。 图中
// 共有四类元素：浅蓝色宽线和深灰色阴影带分别表示观测光谱
// 及其不确定度，这些数据仅覆盖观测波长约3500至5000埃以及
// 约110000至120000埃的两个小区间；黑色细实线表示模型光谱，
// 它覆盖了整个静止系波长范围，从极紫外（约2000埃）延伸到
// 近红外（250000埃），形态呈现多个宽峰和吸收谷，在静止系
// 波长约100000埃和200000埃处有突出的宽发射特征。带有红色
// 中心点的蓝色圆圈是观测测光点，带有竖线误差棒，其位置与
// 观测光谱一致；红色方块是模型测光点，与蓝色圆圈重合。右
// 上角图例列出了这五种元素的符号和线型。该图传达的趋势是：
// 模型光谱需要在宽波段内拟合观测到的紫外到近红外的测光数
// 据，并在静止系约100000埃和200000埃处预测了显著的发射特
// 征，但观测数据仅覆盖了静止系波长约3000至4500埃和90000
// 至110000埃的部分。 子图b位于下方，是曲线图，横轴为“
// Observed Wavelength [Å]”，线性坐标，范围约从3800到8200
// 埃，主刻度间隔500埃。纵轴为“Fν [μJy]”，对数坐标，范围
// 约从50到2000。左上角标注文字为“z=0.0980”和“MMT/
// Binospec”，表明红移值和观测仪器。 图中数据由一条浅蓝色
// 细曲线表示观测光谱，附有深灰色不确定度带，整体基线在
// 100 μJy附近，在波长约4000、4200、4300、4400、4600、
// 4700、4800、4900、5000埃处有多个明显的吸收谷，流量降至
// 约50 μJy，在波长约7200、7450埃处有两个突出的尖峰，流量
// 升至约1000至2000 μJy。黑色实线表示模型光谱，与观测光谱
// 的整体趋势和吸收/发射特征吻合。该图传达的趋势是：在观
// 测波长4000至8200埃范围内，光谱在蓝端存在多个吸收特征，
// 红端存在两个强发射线，模型能较好地拟合观测数据。
#figure(scope: "parent", [#box(image("imgs/FRB20201124A_SED_final.png", width: 100%)) <fig:201124_SED>

  ],
  caption: [
    SED of FRB 20201124A.
  ]
)
<fig:201124_SED>

// [figvision-cn] imgs/FRB20210117A_SED_final.png
// 该图由上下两个子图组成，顶部总标题为 FRB 20210117A，两
// 个子图共同展示该快速射电暴对应宿主星系的光谱能量分布（
// SED）。 子图上方的是一张宽波段光谱能量分布曲线图及测光
// 数据点图。图有两个横轴：底部横轴为观测波长，名称为
// Observed Wavelength [Å]，范围为 2500 至 25000 埃；顶部
// 横轴为静止参考系波长，名称为 Rest-Frame Wavelength [Å]，
// 范围从 2500 至 20000 埃。纵轴为流量密度 Fν，单位为微央
// 斯基 [μJy]，范围从 0 到 25，主刻度间隔为 5，并标有 0、
// 5、10、15、20、25。图例位于右上角：浅蓝色实线和浅蓝色
// 半透明阴影带分别表示观测光谱（Observed spectrum）和观
// 测光谱不确定度（Observed spectrum uncertainty）；黑色
// 实线表示模型光谱（Model spectrum）；蓝色圆点加黑色误差
// 棒表示观测测光数据（Observed photometry）；红色空心方
// 块表示模型测光数据（Model photometry）。图中显示观测到
// 的浅蓝色光谱在观测波长约 5000 至 9000 埃之间、尤其是约
// 7900 埃附近出现强发射线尖峰；模型光谱黑色实线在 6000
// 至 9000 埃之间波动，并呈缓慢下降趋势，向长波方向延伸至
// 25000 埃。观测测光蓝色圆点分布在约 4800、6300、6500、
// 7900、8100、9800、12500、16300、21100 埃处，纵坐标在 0
// 至 5 μJy 之间，其中 7900 埃附近测光点误差棒较长、均值
// 最高；模型测光红色方块与对应波长处的观测点基本重合。总
// 体趋势是：该 FRB 宿主星系在静止参考系紫外至光学波段具
// 有明显发射线，在近红外波段流量较低且平缓。 子图下方的
// 是一张局部放大的光谱图，呈曲线图类型。横轴为观测波长
// Observed Wavelength [Å]，范围 6000 至 8800 埃，刻度标
// 有 6000、6500、7000、7500、8000、8500；纵轴为流量密度
// Fν [μJy]，范围从 -5 到 20，标有 0、10、20 刻度。左上角
// 标注文字为 z=0.2145 和 VLT/FORS2，说明这是使用甚大望远
// 镜 FORS2 光谱仪在红移 0.2145 下获得的数据。图中浅蓝色
// 曲线为观测光谱，浅蓝色阴影为不确定度带；黑色曲线为模型
// 拟合光谱。浅蓝色观测光谱在约 6100 埃处有一个小尖峰，在
// 约 6170 埃处有一个较明显的发射线峰；在 6500–7400 埃附
// 近存在多个高于连续谱的小峰和波动；黑色模型曲线在约
// 6160 埃和 7930 埃处呈现尖峰，后者峰值接近 18 μJy，另在
// 约 7890 埃和 8520 埃附近有较小的模型峰。该子图传达的结
// 论是：该目标在观测波长 6160 埃和 7930 埃附近存在显著的
// 发射线特征，其中 7930 埃（对应静止约 6530 埃）的发射线
// 最强，模型与观测在主要发射线位置基本一致。
#figure(scope: "parent", [#box(image("imgs/FRB20210117A_SED_final.png", width: 100%)) <fig:210117_SED>

  ],
  caption: [
    SED of FRB 20210117A.
  ]
)
<fig:210117_SED>

// [figvision-cn] imgs/FRB20210320C_SED_final.png
// 该图由上下两个子图组成，顶部冠以总体标题“FRB 20210320C
// ”，图注参考为“SED of FRB 20210320C”。两个子图均为曲线
// 图。 子图（上方的大图）： 这是FRB 20210320C的光谱能量
// 分布（SED）图。 底部横轴标注为“Observed Wavelength [Å]
// ”（观测波长，单位埃），范围从约5000到150000，主要刻度
// 为20000、40000、60000、80000、100000、120000、140000。
// 顶部横轴标注为“Rest-Frame Wavelength [Å]”（静止系波长，
// 单位埃），范围从约14000到110000以上，主要刻度为20000、
// 40000、60000、80000、100000。 纵轴标注为“Fν [μJy]”（通
// 量密度，单位微央斯基），采用对数坐标，显示刻度为10¹和
// 10²（即10到100 μJy），整体数据范围约在5 μJy到300 μJy之
// 间。 图中共有一个图例区域位于右下角： 青色粗线/区域表
// 示“Observed spectrum”（观测光谱），在短波长处波动剧烈，
// 在约15000埃以后呈较平缓下降趋势。 灰色粗线表示“
// Observed spectrum uncertainty”（观测光谱不确定度），主
// 要伴随青色观测光谱。 黑色实线表示“Model spectrum”（模
// 型光谱），呈现波浪状起伏，在约80000埃和130000埃附近有
// 峰值，在约60000至90000埃之间形成一个低谷后又回升。 蓝
// 色空心圆点带误差棒表示“Observed photometry”（观测测光
// 数据），共有约9个数据点，分布于观测波长约8000到115000
// 埃之间，纵轴值约20到200 μJy不等。 红色空心方块带误差棒
// 表示“Model photometry”（模型测光数据），与蓝色观测测光
// 点一一对应，纵轴值较为接近。 图中趋势显示：在观测波长
// 较短的区域（<20000埃），测量点密度较高且数据在短波段有
// 显著波动；在长波段（>100000埃）模型光谱预测了较大的起
// 伏，而测光点主要约束了中短波段能量分布。 子图（下方的
// 小图）： 这是观测光谱在较短波长范围内的局部放大图。 横
// 轴标注为“Observed Wavelength [Å]”（观测波长，单位埃），
// 范围从5000到约8800，主要刻度为5000、5500、6000、6500、
// 7000、7500、8000、8500。 纵轴标注为“Fν [μJy]”，对数坐
// 标，主要显示10²刻度。 图中显示了一条青色细线代表观测光
// 谱，在大部分波段内围绕约50-100 μJy的基线波动，存在多个
// 明显的发射线尖峰，例如在约6100、6400、6900、8150、8400、
// 8550埃附近出现窄峰。黑色实线为连续的模型/拟合基线，在
// 光谱中部略低，两端略高。 左上角有文本标注：“z=0.2796”
// （红移）和“SOAR/Goodman”（仪器/观测来源）。 该子图传达
// 的趋势是：在该局部波段内，观测光谱存在多个显著窄发射线，
// 红移和仪器信息被附注。
#figure(scope: "parent", [#box(image("imgs/FRB20210320C_SED_final.png", width: 100%)) <fig:210320_SED>

  ],
  caption: [
    SED of FRB 20210320C.
  ]
)
<fig:210320_SED>

// [figvision-cn] imgs/FRB20210410D_SED_final.png
// 该图由上下两个子图组成，顶部总标题为“FRB 20210410D”。
// 两个子图均为光谱能量分布（SED）曲线图，共享相同的物理
// 量表达：纵轴均为流量密度 Fν，单位为微央斯基 [μJy]；下
// 横轴均为观测波长，单位为埃 [Å]；上横轴为对应的静止系波
// 长，单位为埃 [Å]。 子图 a（上图）： 类型为宽波段光谱能
// 量分布曲线图。纵轴 Fν 范围约 -50 至 125 μJy，标注刻度
// 为 -25、0、25、50、75、100、125。下横轴观测波长范围约
// 3000 至 15000 Å，主刻度为 4000、6000、8000、10000、
// 12000、14000。上横轴静止系波长范围约 3400 至 15400 Å，
// 主刻度为 4000、6000、8000、10000、12000。图例位于右侧
// 中下部，包含五项：浅蓝色实线代表“Observed spectrum”，
// 深灰色粗实线代表“Observed spectrum uncertainty”，黑色
// 实线代表“Model spectrum”，蓝色空心圆圈代表“Observed
// photometry”，红色空心方块代表“Model photometry”。 数据
// 呈现：浅蓝色观测光谱在 5000 Å 至 8500 Å 之间最为密集，
// 噪声包络（深灰色不确定性带）在此波段最宽，峰值波动约在
// -40 至 80 μJy 之间。模型光谱（黑色实线）从左下角约
// 3800 Å 处的接近 0 μJy 平滑上升，穿过观测波段时呈现若干
// 吸收和发射特征，其中在约 7500 Å 处有一个明显的尖锐发射
// 峰，强度突增至约 110 μJy；随后曲线继续缓慢上升，至
// 15000 Å 处达到约 50 μJy。观测测光点（蓝色圆圈）和模型
// 测光点（红色方块）成对出现在约 4600、6200、7500、9800、
// 10100、12500 Å 处，除 9800 Å 处观测点略低于模型点（约
// 30 μJy）外，其他位置两者高度吻合，数值在 20 至 50 μJy
// 之间。模型测光点在长波段（>12000 Å）持续延伸。 子图 b
// （下图）： 类型为局部放大的光谱曲线图。纵轴 Fν 范围约
// -50 至 110 μJy，刻度为 0 和 100。下横轴观测波长范围约
// 5100 至 8600 Å，主刻度为 5500、6000、6500、7000、7500、
// 8000、8500。左上角标注文字为“z=0.1415”和“Gemini-S/GMOS
// ”，表明红移值和观测仪器。该子图未提供独立图例，但沿用
// 上图的颜色映射：浅蓝色为观测光谱，深灰色为不确定性，黑
// 色为模型光谱。 数据呈现：观测光谱（浅蓝色）在此波段极
// 为密集，深灰色不确定性带宽度与光谱波动幅度一致，主要在
// 0 至 60 μJy 之间波动。模型光谱（黑色实线）在 5100 Å 处
// 从约 -30 μJy 快速上升至 0 μJy 附近，随后在 5100 至
// 7400 Å 之间维持约 10 μJy 的平缓平台，伴随微弱波动；在
// 约 7500 Å 处出现一个尖锐的发射线峰，峰值约 105 μJy，随
// 后迅速回落至约 15 μJy 的基线，并在 7600 Å 之后呈现多个
// 较低的发射小峰（如 7800 Å 附近约 30 μJy）。该子图强调
// 了约 7500 Å 处最强发射线的细节以及模型与观测在局部波段
// 的拟合关系。 整体趋势：该图展示了 FRB 20210410D 宿主星
// 系在宽波段上的光谱能量分布，模型光谱与稀疏的测光点吻合
// 良好，并在静止系约 6600 Å（观测约 7500 Å）处存在显著的
// 发射线特征，红移测定为 z=0.1415。
#figure(scope: "parent", [#box(image("imgs/FRB20210410D_SED_final.png", width: 100%)) <fig:210410_SED>

  ],
  caption: [
    SED of FRB 20210410D.
  ]
)
<fig:210410_SED>

// [figvision-cn] imgs/FRB20210807D_SED_final.png
// 这是一张包含上下两个子图的科学论文插图，总标题为“FRB
// 20210807D”。该图展示了该快速射电暴对应余辉（或其他对应
// 天体）的光谱能量分布（SED）。 子图（上）： 类型：曲线
// 图（光谱能量分布图）。 坐标轴： 底部X轴为“Observed
// Wavelength [Å]”（观测波长，单位为埃），范围从约10000到
// 140000埃，主刻度分别为20000, 40000, 60000, 80000,
// 100000, 120000, 140000。 顶部X轴为“Rest-Frame
// Wavelength [Å]”（静止坐标系波长，单位为埃），主刻度分
// 别为20000, 40000, 60000, 80000, 100000, 120000。注意顶
// 部和底部刻度有相对偏移以反映红移。 Y轴为“\(F_\nu\) [\(
// \mu\)Jy]”（流量密度，单位为微央斯基），采用对数坐标，
// 范围从\(10^0\)（1 \(\mu\)Jy）到超过\(10^3\)（1000 \(\
// mu\)Jy），主刻度标注为\(10^0, 10^1, 10^2, 10^3\)。 图
// 例及内容： 浅蓝色条带（Observed spectrum）：代表观测到
// 的光谱。 灰色条带（Observed spectrum uncertainty）：代
// 表观测光谱的不确定性（误差范围）。 黑色实线（Model
// spectrum）：代表模型拟合光谱。曲线显示在观测波长约
// 10000至20000埃之间流量迅速上升至\(10^3 \mu\)Jy附近，随
// 后在20000至50000埃之间略有下降，之后随波长增加呈现缓慢
// 上升趋势直到140000埃。 蓝色圆圈内含黑点（Observed
// photometry）：代表观测到的测光数据点。共有8个点，横跨
// 观测波长约10000至120000埃，均带有误差棒。这些点集中在
// 波长较短（<60000埃）区域和波长约115000埃处，与模型曲线
// 走势相符。 红色方框内含黑点（Model photometry）：代表
// 模型预测的测光数据点。这些红框与蓝圈数据点位置高度重合。
// 子图（下）： 类型：曲线图（光谱细节图）。 坐标轴： X轴
// 为“Observed Wavelength [Å]”（观测波长，单位为埃），范
// 围从约4200到约7700埃，主刻度分别为4500, 5000, 5500,
// 6000, 6500, 7000, 7500。 Y轴为“\(F_\nu\) [\(\mu\)Jy]”
// （流量密度，单位为微央斯基），采用对数坐标，范围从\(10
// ^2\)（100 \(\mu\)Jy）到\(10^3\)（1000 \(\mu\)Jy）。 图
// 内标注：左上角标有“z=0.1293”（红移值）和“Keck/LRIS”（
// 观测仪器）。 内容：展示了一条黑色的高分辨率光谱曲线，
// 周围环绕着浅蓝色的误差/不确定性条带。曲线整体从左至右
// 呈缓慢上升趋势（从低于100 \(\mu\)Jy到接近1000 \(\mu\)
// Jy）。曲线上包含多处明显的波动特征，包括若干向下的吸收
// 槽和向上的发射峰，特别是在波长约7500埃附近有一个显著的
// 尖峰。
#figure(scope: "parent", [#box(image("imgs/FRB20210807D_SED_final.png", width: 100%)) <fig:210807_SED>

  ],
  caption: [
    SED of FRB 20210807D.
  ]
)
<fig:210807_SED>

// [figvision-cn] imgs/FRB20211127I_SED_final.png
// 该图由上下两个面板组成，展示 FRB 20211127I 宿主星系的
// 示例光谱能量分布（SED）。整体标题为“FRB 20211127I”。
// 上方面板（Top panel）：这是一个光谱与测光联合拟合的对
// 数-线性坐标图。底部横轴为观测波长（Observed Wavelength
// [Å]），范围 5000 至 50000 Å；顶部横轴为静止系波长（
// Rest-Frame Wavelength [Å]），范围 10000 至 40000 Å。纵
// 轴为比通量 Fν [μJy]，对数刻度，范围 10^2 至 10^4 μJy。
// 图中包含以下元素： 浅蓝色实线表示观测光谱，浅灰色实线
// （围绕观测光谱的带状区域）表示观测光谱的误差谱；二者在
// 5000-8000 Å 范围内清晰可见，8000 Å 之后观测光谱中断，
// 仅剩模型延伸。黑色实线为最佳拟合的 Prospector 模型光谱，
// 从约 5000 Å 延伸至 50000 Å，整体呈缓慢下降趋势，在约
// 6900 Å 处可见明显发射线尖峰，在 34000 Å 附近有轻微凸起。
// 蓝色空心圆点（带误差棒）表示观测测光数据，分布在约
// 5000、5500、6000、6500、6800、7500、8000、21000、34000、
// 46000 Å 等位置。红色空心方块表示对应的模型测光数据，与
// 观测测光点在水平位置上基本对准（仅做微小水平错位以避让
// 显示），数值高度吻合。图例位于右下方，依次标注：浅蓝方
// 块=Observed spectrum，灰方块=Observed spectrum
// uncertainty，黑线段=Model spectrum，蓝圆=Observed
// photometry，红方块=Model photometry。 下方面板（Bottom
// panel）：为观测与模型光谱在 5000-7800 Å 范围的放大图。
// 横轴为观测波长 [Å]，范围 5000 至 7800 Å；纵轴为 Fν [μ
// Jy]，对数刻度，标注刻度为 3×10^3、4×10^3、6×10^3、10^4
// μJy。图中浅蓝色实线为观测光谱，浅灰色实线为误差谱，黑
// 色实线为模型光谱。左上角标注文字“z=0.0469”和“SDSS/
// Goodman”。光谱在约 6900 Å 处出现显著发射线（可能为 Hα），
// 峰值接近 10^4 μJy，其左侧约 6800 Å 处有较弱发射线；在
// 约 5200 Å 处有一个明显的吸收谷。 该图传达的趋势与结论：
// Prospector 模型光谱与观测光谱及多波段测光数据在宽波长
// 范围内高度一致，模型测光点与观测测光点几乎重合，表明拟
// 合结果良好；下方面板突出显示了静止系光学波段的发射线特
// 征，为宿主星系恒星形成及星族性质提供了定量约束。
#figure(scope: "parent", [#box(image("imgs/FRB20211127I_SED_final.png", width: 100%)) <fig:211127_SED>

  ],
  caption: [
    SED of FRB 20211127I.
  ]
)
<fig:211127_SED>

// [figvision-cn] imgs/FRB20211203C_SED_final.png
// 这张图由上下两个子图组成，顶部居中总标题为 FRB
// 20211203C。 子图 a（上图）：这是一个光谱与测光数据联合
// 拟合的曲线图。 坐标轴：底部横轴为“观测波长 [Å]”，范围
// 从约 5000 Å 到 60000 Å，主刻度间隔为 10000 Å；顶部横轴
// 为“静止系波长 [Å]”，对应范围从约 5000 Å 到约 40000 Å，
// 主刻度间隔为 5000 Å。纵轴为“Fν [μJy]”，采用对数坐标，
// 范围从 10^1 到 10^3。 图例与数据： 浅蓝色锯齿状线（
// Observed spectrum）：表示观测到的光谱流量密度。 灰色锯
// 齿状带（Observed spectrum uncertainty）：表示观测光谱
// 的不确定度。 黑色实线（Model spectrum）：表示模型拟合
// 的光谱，整体趋势随波长增加而缓慢下降，在 5000 Å 附近有
// 陡增，在约 45000 Å 处有一个微小的隆起。 蓝色空心圆圈带
// 误差棒（Observed photometry）：表示观测测光数据点，分
// 布在横轴约 6000、7000、8000、10000、12000、21000、
// 34000、45000 Å 处，纵轴值在 20 到 80 μJy 之间。 红色空
// 心方块（Model photometry）：表示模型对应的测光值，与蓝
// 色圆圈对应，数值非常接近。 趋势结论：模型光谱在光学到
// 近红外波段较好地拟合了观测光谱和测光数据。 子图 b（下
// 图）：这是光谱局部放大图。 坐标轴：横轴为“观测波长 [Å]
// ”，范围从约 5200 Å 到 9100 Å，主刻度间隔为 500 Å。纵轴
// 为“Fν [μJy]”，采用对数坐标，范围从 10^1 到约 3×10^2。
// 数据：图中展示了一条浅蓝色的锯齿状光谱线（与子图 a 中
// 的观测光谱相同），包含大量窄吸收线和发射线特征。在约
// 8500-9000 Å 处有一组明显的发射线峰。 标注：左上角有文
// 字标注“z=0.3437”和“SOAR/Goodman”，分别表示红移值和观测
// 仪器。
#figure(scope: "parent", [#box(image("imgs/FRB20211203C_SED_final.png", width: 100%)) <fig:211203_SED>

  ],
  caption: [
    SED of FRB 20211203C.
  ]
)
<fig:211203_SED>

// [figvision-cn] imgs/FRB20211212A_SED_final.png
// 该图由上下两个子图组成，总标题为 FRB 20211212A。 子图
// a（上图）：为光谱能量分布（SED）曲线图。横轴为观测波长
// Observed Wavelength [Å]，范围从 10000 到 150000 以上；
// 顶部横轴为静止系波长 Rest-Frame Wavelength [Å]，范围从
// 20000 到 140000。纵轴为流量密度 Fν [μJy]，采用对数坐标，
// 主要刻度为 10^2、10^3、10^4。图中主要元素包括：浅蓝色
// 阴影带表示观测光谱及其不确定度；黑色实线表示模型光谱，
// 呈现多峰结构，在静止系 120000 Å 附近有一个显著的高峰；
// 带黑色圆点的蓝色圆圈表示观测测光数据点；红色方形表示模
// 型测光数据点。观测测光点在观测波长 10000–30000 Å 范围
// 内与模型吻合较好，但在较长波长（约 35000、50000、
// 115000 Å）处观测点低于模型预测。图例位于右下角，标注了
// observed spectrum、observed spectrum uncertainty、
// model spectrum、observed photometry 和 model
// photometry。 子图 b（下图）：为光谱放大图。横轴为观测
// 波长 Observed Wavelength [Å]，范围从 5000 到 8000；纵
// 轴为 Fν [μJy]，对数坐标，范围从 10^2 到 10^3 以上。左
// 上角文字标注 z=0.0707 和 SOAR/Goodman。浅蓝色阴影带表
// 示观测光谱及其不确定度，黑色实线表示模型光谱。该子图展
// 示了光谱在 5000–8000 Å 区间的细节，可见多处窄发射线（
// 例如观测波长约 7100 Å 处有一个尖峰），模型光谱在 7600
// Å 附近存在不连续。总体趋势表明，在近红外波段观测数据与
// 模型在连续谱水平上基本一致，但模型未能完全复现所有窄发
// 射线特征。
#figure(scope: "parent", [#box(image("imgs/FRB20211212A_SED_final.png", width: 100%)) <fig:211212_SED>

  ],
  caption: [
    SED of FRB 20211212A.
  ]
)
<fig:211212_SED>

// [figvision-cn] imgs/FRB20220105A_SED_final.png
// 整张图由上下两个横向排列的面板组成，总标题为FRB
// 20220105A，图注参考SED of FRB 20220105A，表示该图展示
// 快速射电暴20220105A宿主星系的光谱能量分布。 上方子图类
// 型为曲线图。具有上下两条横坐标轴。下方横坐标轴为观测波
// 长（Observed Wavelength），单位为埃（Å），范围从约4500
// 到25000 Å，主刻度间隔2500 Å；上方横坐标轴为静止系波长
// （Rest-Frame Wavelength），单位Å，范围从约4000到18000
// Å，主刻度间隔2000 Å。纵坐标轴为流量密度（Fν），单位为
// 微央斯基（μJy），范围从0到120 μJy，主刻度间隔20 μJy。
// 右上角图例列出五类元素：浅青色填充区域为观测光谱（
// Observed spectrum），灰色填充区域为观测光谱不确定性（
// Observed spectrum uncertainty），黑色实线为模型光谱（
// Model spectrum），蓝色空心圆带误差棒为观测光度（
// Observed photometry），红色空心方块带误差棒为模型光度
// （Model photometry）。图中浅青色观测光谱在观测波长约
// 5500–9500 Å区间显示，充满大量高频噪声并伴有数个尖锐发
// 射线峰，最强窄峰位于观测波长约8600 Å附近、纵轴约108 μ
// Jy，另有约6050 Å处约60 μJy的峰和约5700 Å处约50 μJy的峰，
// 浅青色区域整体在0–40 μJy间波动。黑色模型光谱为一条较平
// 滑曲线，从观测波长约5000 Å处约5 μJy起，随波长缓慢上升，
// 在约21000–22000 Å处达到约40 μJy的宽峰，随后在25000 Å下
// 降至约35 μJy。蓝色空心圆观测光度点有五个，分别位于约
// 5000、5700、6050、8600和21300 Å附近，对应流量约3、10、
// 18、23、43 μJy，各带垂直误差棒。红色空心方块模型光度点
// 与蓝色圆位置几乎重合，位于观测点内侧或略微偏移，也带误
// 差棒。图中传达的趋势为：观测光谱在短波段信噪比低，具有
// 明显发射线，模型光谱在短波段偏低，在中红外波段形成宽峰；
// 观测和模型光度在五个波段一致。 下方子图类型为曲线图，
// 为上方短波段观测光谱的局部放大。横坐标轴为观测波长（
// Observed Wavelength），单位Å，范围从约5250到9100 Å，主
// 刻度间隔500 Å。纵坐标轴为流量密度（Fν），单位μJy，范围
// 约从-10到110 μJy，主刻度为0、50、100 μJy。左上角标注红
// 移z=0.2784与仪器/数据来源Keck/DEIMOS。图中同样显示浅青
// 色观测光谱及灰色不确定性区域，在5250–9100 Å范围内，光
// 谱整体基线位于0–10 μJy，带有大量噪声，在约6050 Å处有一
// 个约45 μJy的窄峰，在约8150 Å处有一个约40 μJy的峰，在约
// 8450 Å处有一个约105 μJy的极强尖峰，另在约8500 Å处有约
// 45 μJy的峰。在这些峰的位置叠加有黑色短竖线，标记发射线
// 位置。该子图传达的结论是：在放大波段内，光谱信噪比低，
// 但存在明显的发射线特征，最强发射线位于观测波长约8450 Å。
#figure(scope: "parent", [#box(image("imgs/FRB20220105A_SED_final.png", width: 100%)) <fig:220105_SED>

  ],
  caption: [
    SED of FRB 20220105A.
  ]
)
<fig:220105_SED>

= PHOTOMETRY
#<sec:-phot>

Here we present all FRB host galaxy photometry used in our modeling. We include details on the facility, instrument, observation date, filter, photometry, and references. See #ref(<sec:-imaging>) for additional details about the observation and data reduction procedures.

#figure(placement: none, [#table(
    stroke: none,
    columns: 8,
    align: (left,center,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header(
      [FRB], [Facility], [Instrument], [Observation Date(s)], [Filter], [Magnitude], [Program ID], [Reference],
      [], [], [], [], [], [\[AB\]], [], [],
    ),
    table.hline(stroke: 0.5pt),
    [20121102A], [Gemini North], [GMOS], [2016 Dec 29 UT], [g], [23.33$plus.minus$0.12], [GN-2016B-DD-2], [1],
    [], [Gemini North], [GMOS], [2016 Dec 29 UT], [r], [23.73$plus.minus$0.14], [], [1],
    [], [Gemini North], [GMOS], [2016 Nov 02 UT], [i], [23.54$plus.minus$0.09], [], [2],
    [], [Gemini North], [GMOS], [2016 Nov 02 UT], [z], [23.49$plus.minus$0.13], [], [2],
    [], [MMT], [MMIRS], [2021 Dec 21, 22 UT], [J], [23.51$plus.minus$0.051], [UAO-G177-21B], [This Work],
    [], [MMT], [MMIRS], [2021 Dec 17 UT], [Ks], [23.73$plus.minus$0.59], [], [This Work],
    [], [HST], [WFC3], [2017 Feb 23 UT], [F110W], [23.08$plus.minus$0.01], [GO-14890], [1, 3],
    [], [HST], [WFC3], [2017 Feb 23 UT], [F160W], [22.96$plus.minus$0.03], [], [1, 3],
    [], [Spitzer], [IRAC], [2017 Jan 04 UT], [CH1], [23.79$plus.minus$0.20], [Obs ID 62322432], [1],
    [20180301A], [NOT], [ALFOSC], [2021 Oct 26-Dec 14 UT], [u], [21.77$plus.minus$0.30], [62-503], [4],
    [], [NOT], [ALFOSC], [2021 Oct 26-Dec 14 UT], [g], [21.64$plus.minus$0.09], [], [4],
    [], [NOT], [ALFOSC], [2021 Oct 26-Dec 14 UT], [r], [21.21$plus.minus$0.06], [], [4],
    [], [NOT], [ALFOSC], [2021 Oct 26-Dec 14 UT], [i], [21.11$plus.minus$0.06], [], [4],
    [], [NOT], [ALFOSC], [2021 Oct 26-Dec 14 UT], [z], [20.66$plus.minus$0.11], [], [4],
    [], [MMT], [MMIRS], [2021 Feb 27 UT], [J], [20.61$plus.minus$0.07], [UAO-G195-21A], [4],
    [], [MMT], [MMIRS], [2021 Feb 27 UT], [H], [20.43$plus.minus$0.08], [], [4],
    [], [MMT], [MMIRS], [2021 Feb 28 UT], [Ks], [20.53$plus.minus$0.08], [], [4],
    [20180916B], [SDSS], [], [], [g], [17.08$plus.minus$0.08], [], [5],
    [], [SDSS], [], [], [r], [16.17$plus.minus$0.03], [], [5],
    [], [SDSS], [], [], [i], [15.93$plus.minus$0.02], [], [5],
    [], [SDSS], [], [], [z], [15.85$plus.minus$0.06], [], [5],
    [], [HST], [WFC3], [2020 July 17 UT], [F110W], [15.30$plus.minus$0.01], [16072], [3,6],
    [], [WISE], [], [], [W1], [17.04$plus.minus$0.03], [], [7],
    [], [WISE], [], [], [W2], [17.73$plus.minus$0.05], [], [7],
    [], [WISE], [], [], [W3], [15.71$plus.minus$0.08], [], [7],
    [], [WISE], [], [], [W4], [15.67$plus.minus$0.52], [], [7],
    [20180924B], [DECaLS], [DECam], [], [g], [21.42$plus.minus$0.02], [], [8],
    [], [DECaLS], [DECam], [], [r], [20.33$plus.minus$0.01], [], [8],
    [], [DES], [DECam], [], [i], [20.01$plus.minus$0.01], [], [9],
    [], [DECaLS], [DECam], [], [z], [19.56$plus.minus$0.01], [], [8],
    [], [DES], [DECam], [], [Y], [19.65$plus.minus$0.05], [], [9],
    [], [HST], [WFC3], [2019 Nov 26 UT], [F300X], [23.37$plus.minus$0.06], [15878], [3],
    [], [HST], [WFC3], [2019 Nov 27 UT], [F160W], [19.34$plus.minus$0.002], [], [3],
    [], [VISTA], [VIRCAM], [], [J], [19.24$plus.minus$0.11], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [18.97$plus.minus$0.17], [], [10, This Work],
    [], [WISE], [], [], [W1], [19.46$plus.minus$0.22], [], [7],
    [20181112A], [DES], [DECam], [], [g], [22.64$plus.minus$0.09], [], [9],
    [], [DES], [DECam], [], [r], [21.68$plus.minus$0.05], [], [9],
    [], [DES], [DECam], [], [i], [21.46$plus.minus$0.06], [], [9],
    [], [DES], [DECam], [], [z], [21.42$plus.minus$0.11], [], [9],
    [], [DES], [DECam], [], [Y], [21.05$plus.minus$0.17], [], [9],
    [], [VISTA], [VIRCAM], [], [J], [20.96$plus.minus$0.02], [], [10, This Work],
    [20190102C], [VLT], [FORS2], [2019 Jun 17 UT], [u], [22.77$plus.minus$0.20], [0103.A-0101(A)], [4],
    [], [VLT], [FORS2], [2019 Jan 12 UT], [g], [21.87$plus.minus$0.10], [], [4],
    [], [VLT], [FORS2], [2019 Jan 12 UT], [I], [20.77$plus.minus$0.05], [], [4],
    [], [VLT], [FORS2], [2019 Jun 17 UT], [z], [20.54$plus.minus$0.20], [], [4],
    [], [HST], [WFC3], [2020 Jan 14 UT], [F160W], [20.45$plus.minus$0.01], [15878], [3],
    [20190520B], [SOAR], [Goodman], [2022 Sept 01 UT], [u], [$<$23.23], [SOAR2022B-007], [This Work],
    [], [SOAR], [Goodman], [2022 Sept 14 UT], [g], [23.03$plus.minus$0.14], [], [This Work],
    [], [SOAR], [Goodman], [2022 Aug 26 UT], [r], [22.16$plus.minus$0.06], [], [This Work],
    [], [SOAR], [Goodman], [2022 Aug 20 UT], [i], [21.85$plus.minus$0.07], [], [This Work],
    [], [SOAR], [Goodman], [2022 Sept 14,29 UT], [z], [21.95$plus.minus$0.16], [], [This Work],
    [], [Subaru], [MOIRCS], [2020 Aug 05 UT], [J], [21.88$plus.minus$0.14], [], [11],
    [20190608B], [SDSS], [], [], [u], [19.06$plus.minus$0.04], [], [5],
    [], [DECaLS], [DECam], [], [g], [17.98$plus.minus$0.001], [], [8],
    [], [DECaLS], [DECam], [], [r], [17.41$plus.minus$0.002], [], [8],
    [], [SDSS], [], [], [i], [17.12$plus.minus$0.01], [], [5],
    [], [DECaLS], [DECam], [], [z], [16.92$plus.minus$0.001], [], [8],
    [], [HST], [WFC3], [2019 Oct 11 UT], [F300X], [19.51$plus.minus$0.01], [15878], [3],
    [], [HST], [WFC3], [2019 Dec 01 UT], [F160W], [16.67$plus.minus$0.001], [], [3],
    [], [VISTA], [VIRCAM], [], [J], [16.76$plus.minus$0.02], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [16.55$plus.minus$0.04], [], [10, This Work],
    [], [WISE], [], [], [W1], [16.97$plus.minus$0.03], [], [7],
    [], [WISE], [], [], [W2], [17.13$plus.minus$0.06], [], [7],
    [], [WISE], [], [], [W3], [15.93$plus.minus$0.15], [], [7],
    [20190611B], [VLT], [FORS2], [2020 Sept 19 UT], [g], [23.36$plus.minus$0.09], [105.204W.001], [4],
    [], [Gemini South], [GMOS], [2019 Sept 26 UT], [r], [22.15$plus.minus$0.15], [GS-2019B-Q-132], [4],
    [], [Gemini South], [GMOS], [2019 Dec 27 UT], [i], [21.90$plus.minus$0.02], [], [4],
    [], [VLT], [FORS2], [2019 July 12 UT], [I], [22.07$plus.minus$0.07], [0103.A-0101(A)], [4],
    [20190711A], [Gemini South], [GMOS], [2019 Nov 28 UT], [g], [23.55$plus.minus$0.20], [GS-2019B-Q-132], [12],
    [], [Gemini South], [GMOS], [2019 Nov 23, 27 UT], [r], [23.54$plus.minus$0.15], [], [12],
    [], [Gemini South], [GMOS], [2019 Nov 28 UT], [i], [22.98$plus.minus$0.15], [], [12],
    [], [HST], [WFC3], [2020 May 09 UT], [F300X], [24.25$plus.minus$0.12], [16080], [3],
    [], [HST], [WFC3], [2020 May 11 UT], [F160W], [22.84$plus.minus$0.01], [], [3],
    [20190714A], [Pan-STARRS], [], [], [g], [20.91$plus.minus$0.04], [], [13],
    [], [Pan-STARRS], [], [], [r], [20.34$plus.minus$0.03], [], [13],
    [], [Pan-STARRS], [], [], [i], [19.84$plus.minus$0.02], [], [13],
    [], [Pan-STARRS], [], [], [z], [19.64$plus.minus$0.03], [], [13],
    [], [Pan-STARRS], [], [], [y], [19.44$plus.minus$0.06], [], [13],
    [], [HST], [WFC3], [2020 May 19 UT], [F300X], [22.68$plus.minus$0.05], [16080], [3],
    [], [HST], [WFC3], [2020 Apr 30 UT], [F160W], [18.88$plus.minus$0.002], [], [3],
    [], [VISTA], [VIRCAM], [], [Y], [19.48$plus.minus$0.02], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [J], [18.90$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [H], [18.80$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [18.79$plus.minus$0.01], [], [10, This Work],
    [], [WISE], [], [], [W1], [19.31$plus.minus$0.24], [], [7],
    [], [WISE], [], [], [W2], [19.11$plus.minus$0.33], [], [7],
    [20191001A], [DECaLS], [DECam], [], [g], [19.18$plus.minus$0.01], [], [8],
    [], [DECaLS], [DECam], [], [r], [18.36$plus.minus$0.003], [], [8],
    [], [DES], [DECam], [], [i], [17.92$plus.minus$0.002], [], [9],
    [], [DECaLS], [DECam], [], [z], [17.73$plus.minus$0.004], [], [8],
    [], [DES], [DECam], [], [Y], [17.64$plus.minus$0.01], [], [9],
    [], [HST], [WFC3], [2020 Apr 25 UT], [F300X], [21.07$plus.minus$0.02], [16080], [3],
    [], [HST], [WFC3], [2020 Apr 28 UT], [F160W], [17.12$plus.minus$0.001], [], [3],
    [], [VISTA], [VIRCAM], [], [J], [17.30$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [H], [17.09$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [16.90$plus.minus$0.01], [], [10, This Work],
    [20200430A], [DECaLS], [DECam], [], [g], [21.78$plus.minus$0.03], [], [8],
    [], [DECaLS], [DECam], [], [r], [21.05$plus.minus$0.02], [], [8],
    [], [Pan-STARRS], [], [], [i], [20.98$plus.minus$0.05], [], [13],
    [], [DECaLS], [DECam], [], [z], [20.52$plus.minus$0.03], [], [8],
    [], [Pan-STARRS], [], [], [y], [20.68$plus.minus$0.18], [], [13],
    [], [MMT], [MMIRS], [2022 June 12 UT], [J], [19.85$plus.minus$0.05], [UAO-G193-22A], [This Work],
    [], [MMT], [MMIRS], [2022 June 15 UT], [Ks], [21.26$plus.minus$0.25], [], [This Work],
    [20200906A], [DES], [DECam], [], [g], [20.84$plus.minus$0.01], [], [9],
    [], [DES], [DECam], [], [r], [19.95$plus.minus$0.01], [], [9],
    [], [DES], [DECam], [], [i], [19.69$plus.minus$0.01], [], [9],
    [], [DES], [DECam], [], [z], [19.43$plus.minus$0.02], [], [9],
    [], [DES], [DECam], [], [Y], [19.40$plus.minus$0.06], [], [9],
    [], [VISTA], [VIRCAM], [], [J], [19.36$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [18.84$plus.minus$0.01], [], [10, This Work],
    [], [WISE], [], [], [W1], [19.35$plus.minus$0.15], [], [7],
    [], [WISE], [], [], [W2], [19.36$plus.minus$0.23], [], [7],
    [20201124A], [Pan-STARRS], [], [], [g], [18.40$plus.minus$0.04], [], [13],
    [], [Keck], [LRIS], [2022 Oct 29 UT], [G], [18.26$plus.minus$0.02], [O287], [This Work],
    [], [Pan-STARRS], [], [], [r], [17.86$plus.minus$0.03], [], [13],
    [], [Pan-STARRS], [], [], [i], [17.53$plus.minus$0.03], [], [13],
    [], [Keck], [LRIS], [2022 Oct 29 UT], [I], [17.46$plus.minus$0.02], [O287], [This Work],
    [], [Pan-STARRS], [], [], [z], [17.36$plus.minus$0.03], [], [13],
    [], [Pan-STARRS], [], [], [y], [17.34$plus.minus$0.06], [], [13],
    [], [2MASS], [], [], [J], [16.92$plus.minus$0.12], [], [14],
    [], [2MASS], [], [], [H], [16.74$plus.minus$0.12], [], [14],
    [], [2MASS], [], [], [Ks], [16.74$plus.minus$0.12], [], [14],
    [], [WISE], [], [], [W1], [17.01$plus.minus$0.04], [], [7],
    [], [WISE], [], [], [W2], [17.34$plus.minus$0.05], [], [7],
    [], [WISE], [], [], [W3], [15.01$plus.minus$0.06], [], [7],
    [], [WISE], [], [], [W4], [14.59$plus.minus$0.26], [], [7],
    [20210117A], [VLT], [FORS2], [2021 June 12 UT], [g], [23.06$plus.minus$0.02], [105.204W.001], [15],
    [], [Keck], [DEIMOS], [2021 June 10, 11 UT], [R], [22.97$plus.minus$0.04], [O316], [15],
    [], [VLT], [FORS2], [2021 June 12 UT], [I], [22.23$plus.minus$0.05], [105.204W.001], [15],
    [], [SOAR], [Goodman], [2022 Nov 14 UT], [z], [22.20$plus.minus$0.16], [SOAR2022B-007], [This Work],
    [], [VLT], [HAWK-I], [2022 June 10 UT], [J], [22.69$plus.minus$0.08], [108.21ZF.005], [15],
    [], [VLT], [HAWK-I], [2022 June 10 UT], [H], [22.94$plus.minus$0.10], [], [15],
    [], [VLT], [HAWK-I], [2022 June 10 UT], [Ks], [22.80$plus.minus$0.10], [], [15],
    [20210320C], [Pan-STARRS], [], [], [g], [20.31$plus.minus$0.04], [], [13, This Work],
    [], [SOAR], [Goodman], [2022 Feb 02 UT], [r], [19.47$plus.minus$0.02], [SOAR2021B-002], [This Work],
    [], [VLT], [FORS2], [2021 Apr 15 UT], [I], [19.04$plus.minus$0.005], [105.204W.003], [This Work],
    [], [Gemini South], [GMOS], [2022 Jan 19 UT], [z], [19.04$plus.minus$0.03], [GS-2021B-Q-138], [This Work],
    [], [VISTA], [VIRCAM], [], [J], [19.09$plus.minus$0.04], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [H], [18.82$plus.minus$0.05], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [18.68$plus.minus$0.08], [], [10, This Work],
    [], [WISE], [], [], [W1], [18.77$plus.minus$0.07], [], [7],
    [], [WISE], [], [], [W2], [19.18$plus.minus$0.19], [], [7],
    [], [WISE], [], [], [W3], [18.10$plus.minus$0.42], [], [7],
    [20210410D], [SOAR], [Goodman], [2022 Aug 10, 20 UT], [g], [21.77$plus.minus$0.05], [SOAR2022B-007], [16],
    [], [SOAR], [Goodman], [2021 July 19 UT], [r], [20.65$plus.minus$0.03], [SOAR2021A-010], [16],
    [], [SOAR], [Goodman], [2022 Aug 20 UT], [i], [20.10$plus.minus$0.02], [SOAR2022B-007], [16],
    [], [SOAR], [Goodman], [2022 Sept 03 UT], [z], [20.23$plus.minus$0.04], [], [16],
    [], [VISTA], [VIRCAM], [], [Y], [19.76$plus.minus$0.16], [], [10, 16],
    [], [VISTA], [VIRCAM], [], [J], [20.02$plus.minus$0.21], [], [10, 16],
    [20210807D], [Pan-STARRS], [], [], [g], [17.76$plus.minus$0.01], [], [13, This Work],
    [], [Pan-STARRS], [], [], [r], [17.17$plus.minus$0.01], [], [13, This Work],
    [], [Pan-STARRS], [], [], [i], [16.77$plus.minus$0.01], [], [13, This Work],
    [], [Pan-STARRS], [], [], [z], [16.58$plus.minus$0.01], [], [13, This Work],
    [], [Pan-STARRS], [], [], [y], [16.46$plus.minus$0.02], [], [13, This Work],
    [], [VISTA], [VIRCAM], [], [J], [16.21$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [16.00$plus.minus$0.02], [], [10, This Work],
    [], [WISE], [], [], [W1], [16.88$plus.minus$0.04], [], [7],
    [], [WISE], [], [], [W2], [17.24$plus.minus$0.04], [], [7],
    [], [WISE], [], [], [W3], [16.11$plus.minus$0.10], [], [7],
    [20211127I], [SOAR], [Goodman], [2022 Jan 07, 27 UT], [g], [15.03$plus.minus$0.01], [SOAR2021B-002], [This Work],
    [], [SOAR], [Goodman], [2022 Jan 07, 27 UT], [r], [14.96$plus.minus$0.01], [], [This Work],
    [], [SOAR], [Goodman], [2022 Jan 07 UT], [i], [14.72$plus.minus$0.01], [], [This Work],
    [], [SOAR], [Goodman], [2022 Feb 02 UT], [z], [14.57$plus.minus$0.01], [], [This Work],
    [], [VISTA], [VIRCAM], [], [Y], [14.78$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [J], [14.66$plus.minus$0.01], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [14.70$plus.minus$0.01], [], [10, This Work],
    [], [WISE], [], [], [W1], [16.05$plus.minus$0.01], [], [7],
    [], [WISE], [], [], [W2], [16.62$plus.minus$0.02], [], [7],
    [], [WISE], [], [], [W3], [14.99$plus.minus$0.03], [], [7],
    [], [WISE], [], [], [W4], [14.17$plus.minus$0.11], [], [7],
    [20211203C], [SOAR], [Goodman], [2022 Feb 01 UT], [g], [20.32$plus.minus$0.02], [SOAR2021B-002], [This Work],
    [], [SOAR], [Goodman], [2022 Jan 28 UT], [r], [19.64$plus.minus$0.03], [], [This Work],
    [], [SOAR], [Goodman], [2022 Jan 27 UT], [i], [19.79$plus.minus$0.01], [], [This Work],
    [], [SOAR], [Goodman], [2022 Jan 27 UT], [z], [19.44$plus.minus$0.03], [], [This Work],
    [], [VISTA], [VIRCAM], [], [Y], [19.70$plus.minus$0.02], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [J], [19.64$plus.minus$0.02], [], [10, This Work],
    [], [VISTA], [VIRCAM], [], [Ks], [19.33$plus.minus$0.01], [], [10, This Work],
    [], [WISE], [], [], [W1], [19.45$plus.minus$0.20], [], [7],
    [], [WISE], [], [], [W2], [20.05$plus.minus$0.40], [], [7],
    [20211212A], [SDSS], [], [], [u], [18.30$plus.minus$0.03], [], [5],
    [], [SOAR], [Goodman], [2022 Jan 25 UT], [g], [16.88$plus.minus$0.01], [SOAR2021B-002], [This Work],
    [], [SOAR], [Goodman], [2022 Jan 25 UT], [r], [16.44$plus.minus$0.01], [], [This Work],
    [], [SOAR], [Goodman], [2022 Jan 25, 27 UT], [i], [16.14$plus.minus$0.01], [], [This Work],
    [], [Gemini South], [GMOS], [2022 Jan 18 UT], [z], [15.98$plus.minus$0.03], [GS-2021B-Q-138], [This Work],
    [], [2MASS], [], [], [J], [15.87$plus.minus$0.03], [], [14],
    [], [2MASS], [], [], [H], [15.89$plus.minus$0.03], [], [14],
    [], [2MASS], [], [], [Ks], [15.38$plus.minus$0.01], [], [14],
    [], [WISE], [], [], [W1], [16.72$plus.minus$0.02], [], [7],
    [], [WISE], [], [], [W2], [17.22$plus.minus$0.03], [], [7],
    [], [WISE], [], [], [W3], [15.89$plus.minus$0.05], [], [7],
    [20220105A], [Pan-STARRS], [], [], [g], [22.36$plus.minus$0.21], [], [13, This Work],
    [], [Pan-STARRS], [], [], [r], [21.19$plus.minus$0.08], [], [13, This Work],
    [], [Pan-STARRS], [], [], [i], [21.05$plus.minus$0.11], [], [13, This Work],
    [], [SOAR], [Goodman], [2022 Jan 25 UT], [z], [20.48$plus.minus$0.01], [SOAR2021B-002], [This Work],
    [], [VLT], [HAWK-I], [2022 Mar 24 UT], [Ks], [19.76$plus.minus$0.02], [108.21ZF.005], [This Work],
    table.hline(stroke: 0.8pt),
  )], caption: [Log of FRB Host Galaxy Imaging ]
  , kind: table
  )
<tab:imaging>

= PROSPECTOR PRIORS
#<sec:-priors>

Here we list the full details of the priors used in the `Prospector` modeling. We define each prior, list its range or fixed value, and note any additional relevant information.

#figure(placement: none,
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    stroke: 0.4pt,
    inset: 3.5pt,
    align: (left, left, left, left),
    table.header([Parameter], [Definition], [Prior Range or Value], [Notes]),
    [z], [Spectroscopic host redshift], [$cal(U)(z - 0.01, z + 0.01)$], [],
    [dust2], [Dust attenuation of stellar light], [$cal(C)cal(N)(mu = 0.3, sigma = 1, "min" = 0.0, "max" = 4.0)$], [],
    [dust1_fraction], [Optical depth of dust attenuating young stars and nebular emission], [$cal(C)cal(N)(mu = 0.3, sigma = 1, "min" = 0.0, "max" = 2.0)$], [],
    [dust1], [Dust attenuation of young stellar light], [dust2 $times$ dust1_fraction], [],
    [dust_index], [Power-law modification of slope from the @Calzetti00 attenuation curve], [$cal(U)(-1.0, 4.0)$], [],
    [logsfr_ratios], [Ratio of star formation rate between adjacent agebins], [$cal(T)(mu = 0, sigma = 0.3, nu = 2)$], [],
    [log(M/M$⊙$)], [Total mass formed], [(8.0, 12.0)], [Follows @Gallazzi2005 mass-metallicity relation],
    [log(Z/Z$⊙$)], [Metallicity], [(-2.0, 0.19)], [Follows @Gallazzi2005 mass-metallicity relation],
    [duste_qpah], [Grain size distribution of polycyclic aromatic hydrocarbons], [$cal(U)(0.5, 7.0)$], [Only included if data $>= 2 mu "m"$ are available],
    [fagn], [Fraction of total AGN luminosity relative to the bolometric stellar luminosity], [$cal(L)cal(U)(1 e - 5, 3.0)$], [Only included if data $>= 2 mu "m"$ are available],
    [agn_tau], [Optical depth of the AGN dust torus], [$cal(L)cal(U)(5.0, 150.0)$], [Only included if data $>= 2 mu "m"$ are available],
    [gas_logz], [Gas-phase metallicity], [$cal(U)(-2.0, 0.5)$], [Only included if spectrum is used],
    [gas_logu], [Gas ionization parameter], [$cal(U)(-4, -1)$], [Only included if spectrum is used],
    [eline_sigma], [Emission line width], [$cal(U)(30, 300)$], [Only included if spectrum and nebular marginalization used],
    [sigma_smooth], [Velocity dispersion in km $s^(-1)$], [$cal(U)(40.0, 400.0)$], [Only included if spectrum is used],
    [f_outlier_spec], [Fraction of spectral pixels that are considered outliers], [$cal(U)(1 e - 5, 0.5)$], [Only if spectrum used],
    [spec_jitter], [Multiplicative noise inflation term in spectroscopic pixels], [$cal(U)(1.0, 3.0)$], [Only if spectrum used],
    table.hline(),
    [SFH], [Continuity SFH], [3], [],
    [imf_type], [@Kroupa01 IMF], [2], [],
    [dust_type], [@KriekandConroy13 dust attenuation curve], [4], [],
    [smoothtype], [Type of spectral smoothing], [vel], [Smoothing in velocity dispersion],
    [fftsmooth], [Use Fast Fourier Transform to perform spectral smoothing], [True], [],
    [add_neb_emission], [Turn on nebular emission], [True], [],
    [add_neb_continuum], [Turn off nebular continuum], [True], [],
    [nebemlineinspec], [Add nebular emission lines to the model spectrum], [False], [Turned off if nebular marginalization is on],
    [marginalize_elines], [Fit and marginalize over observed emission lines], [True], [Only included if spectrum and nebular marginalization used],
    [use_eline_prior], [Use prior on width of nebular emission lines], [True], [Only included if spectrum and nebular marginalization used],
    [eline_prior_width], [Width of the prior on line luminosity in units of true luminosity divided by FSPS prediction], [1.0], [Only included if spectrum and nebular marginalization used],
    [lines_to_fit], [Specify which lines to marginalize over], [All], [Only included if spectrum and nebular marginalization used],
    [polyorder], [Chebyshev polynomial order for fitting the observed spectrum], [12], [Only if spectrum used],
    [poly_regularization], [Regularization of polynomial coefficients for the spectral calibration vector], [0], [Only if spectrum used],
    [spec_norm], [Normalization of the spectrum in units of true flux divided by observed flux], [1.0], [Only if spectrum used. This parameter is fixed if the spectral polynomial calibration vector is set to be optimized],
    [nsigma_outlier_spec], [Factor of inflation for errors determined by f_outlier_spec], [50], [Only if spectrum used],
    [f_outlier_phot], [Fraction of photometric bands considered outliers], [0], [],
    [nsigma_outlier_phot], [Factor of inflation for errors determined by f_outlier_phot], [50], [],
  ),
  caption: [Priors],
  kind: table,
)
#par(justify: true)[#text(size: 8.5pt)[_Details of the free and fixed `Prospector` priors used in this work. $cal(U)$ denotes a Uniform distribution. $cal(C)cal(N)$ denotes a Clipped Normal distribution. $cal(T)$ denotes a Student T-distribution. $cal(L)cal(U)$ denotes a Log Uniform distribution._]]

#set page(columns: 2)
#show bibliography: set text(size: 9pt)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 12pt, weight: "regular")
#bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)