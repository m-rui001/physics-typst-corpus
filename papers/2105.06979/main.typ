#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 12pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 1.79cm, right: 1.76cm, top: 2.44cm, bottom: 2.55cm))
#set page(numbering: none, header-ascent: 21pt, header: context {
  let n = counter(page).get().first()
  if n > 1 {
    let num = text(12pt, counter(page).display())
    let mid = if calc.odd(n) [The Radius of PSR J0740+6620] else [Miller, Lamb, Dittmann, et al.]
    grid(columns: (1fr, auto, 1fr),
      if calc.odd(n) { [] } else { num },
      align(center, text(12pt, mid)),
      if calc.odd(n) { align(right, num) } else { [] })
  }
})
#set heading(numbering: (..n) => { let p = n.pos(); if p.len() == 1 { numbering("1.", p.at(0)) } else { numbering("1.1", ..p) } })
// headstyle
#show heading.where(level: 1): it => {
  let num = if it.numbering == none { [] } else { [#numbering(it.numbering, ..counter(heading).at(it.location())) ] }
  block(width: 100%, above: 1.2em, below: 0.7em, align(center)[#text(size: 11.7pt, weight: "regular")[#num#it.body]])
}

#set par(justify: true, spacing: 0.58em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.58em)
#set figure.caption(position: bottom)
#set figure(placement: top)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)
#set math.equation(numbering: "(1)", supplement: none)


#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}

#align(center)[
  #text(12pt, weight: "bold", [THE RADIUS OF PSR J0740$+$6620 FROM NICER AND XMM-NEWTON DATA])   #v(1.2em)
  #text(10.5pt)[M. C. Miller#super[1], F. K. Lamb#super[2], A. J. Dittmann#super[1], S. Bogdanov#super[4], Z. Arzoumanian#super[5], K. C. Gendreau#super[5], S. Guillot#super[6], W. C. G. Ho#super[6], J. M. Lattimer#super[7], M. Loewenstein#super[8], S. M. Morsink#super[10], P. S. Ray#super[11], M. T. Wolff#super[11], C. L. Baker#super[12], T. Cazeau#super[5], S. Manthripragada#super[13], C. B. Markwardt#super[14], T. Okajima#super[5], S. Pollard#super[5], I. Cognard#super[15], H. T. Cromartie#super[17], E. Fonseca#super[19], L. Guillemot#super[15], M. Kerr#super[23], A. Parthasarathy#super[24], T. T. Pennucci#super[25], S. Ransom#super[25], I. Stairs#super[27]]
  
]
#block(spacing: 0.45em)[
  #text(9pt)[#super[1] Department of Astronomy and Joint Space-Science Institute, University of Maryland, College Park, MD 20742-2421 USA] \
  #text(9pt)[#super[2] Illinois Center for Advanced Studies of the Universe and Department of Physics, University of Illinois at Urbana-Champaign, 1110 West Green Street, Urbana, IL 61801-3080, USA] \
  #text(9pt)[#super[3] Department of Astronomy, University of Illinois at Urbana-Champaign, 1002 West Green Street, Urbana, IL 61801-3074, USA] \
  #text(9pt)[#super[4] Columbia Astrophysics Laboratory, Columbia University, 550 West 120th Street, New York, NY 10027, USA] \
  #text(9pt)[#super[5] X-Ray Astrophysics Laboratory, NASA Goddard Space Flight Center, Code 662, Greenbelt, MD 20771, USA] \
  #text(9pt)[#super[6] Department of Physics and Astronomy, Haverford College, 370 Lancaster Avenue, Haverford, PA 19041, USA] \
  #text(9pt)[#super[7] Department of Physics and Astronomy, Stony Brook University, Stony Brook, NY 11794-3800, USA] \
  #text(9pt)[#super[8] Department of Astronomy, University of Maryland, College Park, MD 20742-2421 USA] \
  #text(9pt)[#super[9] Center for Research and Exploration in Space Science and Technology, NASA/GSFC, Greenbelt, MD 20771] \
  #text(9pt)[#super[10] Department of Physics, University of Alberta, 4-183 CCIS, Edmonton, AB T6G 2E1, Canada] \
  #text(9pt)[#super[11] Space Science Division, U.S. Naval Research Laboratory, Washington, DC 20375, USA] \
  #text(9pt)[#super[12] Applied Engineering and Technology Directorate, NASA Goddard Space Flight Center, Greenbelt, MD 20771, USA] \
  #text(9pt)[#super[13] Instrument Systems and Technology Division, NASA Goddard Space Flight Center, Greenbelt, MD 20771, USA] \
  #text(9pt)[#super[14] Astrophysics Science Division, NASA Goddard Space Flight Center, Greenbelt, MD 20771, USA] \
  #text(9pt)[#super[15] Station de Radioastronomie de Nan cay, Observatoire de Paris, CNRS/INSU, Université d’Orléans, 18330, Nan cay, France] \
  #text(9pt)[#super[16] 9 Laboratoire de Physique et Chimie de l’Environnement, CNRS, 3A Avenue de la Recherche Scientifique, 45071, Orléans Cedex 2, France] \
  #text(9pt)[#super[17] Cornell Center for Astrophysics and Planetary Science and Department of Astronomy, Cornell University, Ithaca, NY 14853, USA] \
  #text(9pt)[#super[18] NASA Hubble Fellowship Program Einstein Postdoctoral Fellow] \
  #text(9pt)[#super[19] Department of Physics, McGill University, 3600 rue University, Montréal, QC H3A 2T8, Canada] \
  #text(9pt)[#super[20] McGill Space Institute, McGill University, 3550 rue University, Montréal, QC H3A 2A7, Canada] \
  #text(9pt)[#super[21] Department of Physics and Astronomy, West Virginia University, P.O. Box 6315, Morgantown, WV 26506, USA] \
  #text(9pt)[#super[22] Center for Gravitational Waves and Cosmology, West Virginia University, Chestnut Ridge Research Building, Morgantown, WV 26505, USA] \
  #text(9pt)[#super[23] Space Science Division, Naval Research Laboratory, Washington, DC 20375 5352, USA] \
  #text(9pt)[#super[24] Max-Planck-Institut für Radioastronomie, Auf dem Hügel 69, D-53121 Bonn, Germany] \
  #text(9pt)[#super[25] National Radio Astronomy Observatory, 520 Edgemont Road, Charlottesville, VA 22903, USA] \
  #text(9pt)[#super[26] Institute of Physics, Eötvös Loránd University, Pázmány P.s. 1/A, 1117 Budapest, Hungary] \
  #text(9pt)[#super[27] Department of Physics and Astronomy, University of British Columbia, 6224 Agricultural Road, Vancouver, BC V6T 1Z1, Canada] \
]
#v(1.2em)




























































































PSR~J0740$+$6620 has a gravitational mass of $2.08 plus.minus 0.07 ~ M_⊙$, which is the highest reliably determined mass of any neutron star. As a result, a measurement of its radius will provide unique insight into the properties of neutron star core matter at high densities. Here we report a radius measurement based on fits of rotating hot spot patterns to #emph[Neutron Star Interior Composition Explorer] (#emph[NICER]) and #emph[X-ray Multi-Mirror] (#emph[XMM-Newton]) X-ray observations. We find that the equatorial circumferential radius of PSR~J0740$+$6620 is $13.7_(- 1.5)^(+ 2.6)$~km (68\%). We apply our measurement, combined with the previous #emph[NICER] mass and radius measurement of PSR~J0030$+$0451, the masses of two other $tilde 2 ~ M_⊙$ pulsars, and the tidal deformability constraints from two gravitational wave events, to three different frameworks for equation of state modeling, and find consistent results at $tilde 1.5 - 3$~times nuclear saturation density. For a given framework, when all measurements are included the radius of a $1.4 ~ M_⊙$ neutron star is known to $plus.minus 4$\% (68\% credibility) and the radius of a $2.08 ~ M_⊙$ neutron star is known to $plus.minus 5$\%. The full radius range that spans the $plus.minus 1 sigma$ credible intervals of all the radius estimates in the three frameworks is $12.45 plus.minus 0.65$~km for a $1.4 ~ M_⊙$ neutron star and $12.35 plus.minus 0.75$~km for a $2.08 ~ M_⊙$ neutron star.





= INTRODUCTION
<sec:introduction>


Neutron stars are unique laboratories for the study of dense matter. Their cores consist of matter that is believed to be catalyzed to the ground state, at a few times nuclear saturation density (a mass density $rho_s approx 2.7 - 2.8 times 10^14 ~ upright("g") thin upright("med") thin upright("cm")^(- 3)$, or a baryonic number density $n_s approx 0.16$~fm$""^(- 3)$). The combination of high density and the expected large neutron-proton asymmetry in neutron star cores cannot be duplicated in laboratories. Hence, observations of neutron stars can provide us with a valuable window into an otherwise inaccessible realm of nuclear physics.


Over the last several years great strides have been made in neutron star observations, and thus in our understanding of the equation of state (EOS: pressure as a function of energy density) of neutron star matter at high densities (see, e.g., #cite(<1997ApJ...490L..91P>, form: "prose")@2005ApJ...619..483B @2010ApJ...722...33S @2013arXiv1312.0029M @2016EPJA...52...63M @2016ApJ...820...28O @1997ApJ...490L..91P @2017A-A...608A..31N &A...608A..31N for earlier perspectives). Three neutron stars have a gravitational mass established to be $M tilde 2 ~ M_⊙$: PSR~1614--2230 with $M = 1.908 plus.minus 0.016 ~ M_⊙$ (the uncertainties here and below are for the 68\% credible region) @2010Natur.467.1081D @2016ApJ...832..167F @2018ApJ...859...47A\; PSR~J0348+0432 with $M = 2.01 plus.minus 0.04 ~ M_⊙$ @2013Sci...340..448A\; and PSR~J0740$+$6620 with $M = 2.08 plus.minus 0.07 ~ M_⊙$ (#cite(<2020NatAs...4...72C>, form: "prose")@2021arXiv210400880F). The existence of such high-mass neutron stars indicates that the EOS of neutron star matter is relatively hard, i.e., that it yields high pressures at a few times $rho_s$. The lack of a clear signature of tidal deformation in gravitational wave observations of GW170817 @2017PhRvL.119p1101A @2018PhRvL.121p1101A @2018PhRvL.121i1102D and GW190425 @2020ApJ...892L...3A indicates that the EOS is not too hard. When taken together, these high measured masses and the upper limits on the tidal deformability derived from these gravitational wave observations have already narrowed significantly the range of allowed EOS models. The neutron star radius and mass measurements made using data from the #emph[Neutron Star Interior Composition Explorer] (#emph[NICER]) are potentially even more informative.


The first simultaneous measurements of the mass and radius of a neutron star made using #emph[NICER] data were those of the millisecond pulsar PSR~J0030$+$0451, which was determined to have a gravitational mass of $M approx 1.44 plus.minus 0.15 ~ M_⊙$ and an equatorial circumferential radius of $R_e approx 13 plus.minus 1$~km (#cite(<2019ApJ...887L..24M>, form: "prose")@2019ApJ...887L..21R\; compare with the $11.9 plus.minus 1.4$~km radius inferred for the two $tilde 1.4 ~ M_⊙$ neutron stars in the gravitational wave event GW170817 \[#cite(<2018PhRvL.121p1101A>, form: "prose")@2018PhRvL.121i1102D\]). Assuming that systematic errors in the #emph[NICER] measurements are unimportant, and hence that the fractional uncertainty of each of these measurements decreases as the inverse square root of the observing time devoted to each pulsar, we expect these uncertainties to become $tilde 30$\%---40\% smaller within the next few years. A precision this high will improve significantly our understanding of neutron star matter. It is also important to determine whether the masses and radii, and the EOS of neutron star matter, determined using #emph[NICER] observations of other neutron stars are consistent with those determined using #emph[NICER] observations of PSR~J0030$+$0451.


In particular, it is valuable to measure the radii of higher-mass neutron stars. Such stars have higher central densities than a $tilde 1.4 ~ M_⊙$ star, which means that a radius measurement will probe the EOS in a higher-density regime. For example, whereas the measurement of the radius of a $1.4 ~ M_⊙$ star has its greatest impact on our understanding of matter at 1.6 times nuclear saturation density, the measurement of the radius of a $2.0 ~ M_⊙$ star tells us primarily about matter at 2.2 times nuclear saturation density (see Section IV.D of #cite(<2020arXiv200906441D>, form: "prose"), and also see #cite(<2020ApJ...899....4X>, form: "prose") for additional perspectives on the importance of radius measurements for high-mass neutron stars). As pointed out in the context of the $tilde 1.9 ~ M_⊙$ pulsar PSR~J1614$-$2230, even a low-precision radius measurement of a high-mass pulsar, or indeed even a solid lower limit to the radius, will be useful in the construction of more accurate EOS for dense matter @2016ApJ...822...27M.


Here we report our analysis of X-ray data for the $tilde 2.1 ~ M_⊙$ pulsar PSR~J0740$+$6620, which has a rotational frequency of 346.53~Hz @2020NatAs...4...72C. In contrast to PSR~J0030$+$0451, which is an isolated neutron star, PSR~J0740$+$6620 is in a binary and therefore we have independent measurements of the mass and orbital inclination. This improves the precision of the fits. The challenge presented by PSR~J0740$+$6620 is that its #emph[NICER] count rate is only $tilde 5$\% that of PSR~J0030$+$0451. As a result, counts in #emph[NICER] data from PSR~J0740$+$6620 are dominated by sources unassociated with the pulsar, to a far greater degree than is true for PSR~J0030$+$0451. This significantly reduces the modulation fraction and harmonic structure in the X-ray pulse waveform, which in turn reduces the information we have about the emitting regions (which we henceforth call “spots”) and the mass and radius of the star. If we had precise and reliable information about the background in #emph[NICER] observations we could use this to improve our mass and radius estimates, but at present we need to turn to other sources of information.


In this paper we therefore present an analysis of PSR~J0740$+$6620 based on both #emph[NICER] and #emph[X-ray Multi-Mirror] (#emph[XMM-Newton]) data. The #emph[NICER] data provide information about the modulated emission from the star, which is produced from hot spots on the star as the star rotates. The #emph[XMM-Newton] data have a far smaller rate of background counts than the #emph[NICER] data and are therefore informative about the total flux from the star. Combined, the #emph[NICER] and #emph[XMM-Newton] data sets thus yield an improved measurement of the modulation fraction and the harmonic structure from PSR~J0740$+$6620, and hence improve the precision with which we can measure the radius. In particular, stronger gravitational lensing allows more of the star to be visible, which lowers the modulation of the signal. Since gravitational lensing depends on the ratio of mass to radius, for fixed mass, an increase in the pulsed fraction means that a larger radius will be inferred if all other parameters are fixed.


In @sec:observations we describe the selection of the #emph[NICER] and #emph[XMM-Newton] data, including blank-sky #emph[XMM-Newton] data that have been accumulated over the duration of the #emph[XMM-Newton] mission and that help us refine further our estimate of the stellar flux. In @sec:methods we discuss our analysis methods. These are based on the approaches described in previous #emph[NICER] papers @2019ApJ...887L..26B @2019ApJ...887L..24M @2021arXiv210406928B, but are augmented here by the extra data sets and our inclusion of background information from the #emph[XMM-Newton] blank-sky observations. In @sec:fits-to-data we present our analysis results including tests of the adequacy of our models; we find that the radius of PSR~J0740$+$6620 is $R_e = 13.7_(- 1.5)^(+ 2.6)$~km at 68% credibility. We also describe several differences between our analysis and the analysis in the parallel paper #cite(<2021..............R>, form: "prose"), in @sec:differences. In @sec:EOS we present the implications of our PSR~J0740$+$6620 analysis, combined with our previous results on PSR~J0030+0451 and other data, for the EOS of cold dense matter. Our conclusions are in @sec:conclusions. We present our full corner plots and tables of posteriors in the appendices. Samples from our full posterior probability distributions are available at https:\/\/zenodo.org/record/4670689.


= OBSERVATIONS
<sec:observations>


== Data Used
<sec:data-used>


We base our analysis of PSR J0740+6620 on #emph[NICER] event data that included individual event times, event energies, and event pulsation phase. Our observing strategy and data reduction resulted in a data set with very low noise properties, as was necessary because of the faintness of this pulsar.


Our analysis of the X-ray data on PSR~J0740$+$6620 comes from a series of 215 observations obtained with #emph[NICER]~XTI collected between 2018 September 21 and 2020 April 17, with a net exposure time of 1602.68 ksec (after all filtering was applied, as described below). The final event data was obtained using the following filtering criteria: (i) we only included ObsIDs when all 52 #emph[NICER] detectors are active; (ii) we excluded events with energies outside the range 0.3 to 3.0 keV; (iii) we excluded events from DetID 34 (which frequently exhibits elevated count rates compared to the average); (iv) we only considered time intervals when PSR~J0740$+$6620 was situated at least $80^compose$ from the Sun to minimize optical loading and scattered solar X-ray background photons; and (v) we rejected data obtained at low cut-off rigidities (COR\_SAX$< 5$) to minimize particle background contamination. The filtered events were assigned pulse phases using the PSR~J0740$+$6620 ephemeris from #cite(<2021arXiv210400880F>, form: "prose"). This event list ultimately consisted of 7334 separate good time intervals (GTIs). We then searched this event list for the pulsar signal. If the events in a particular GTI did not increase the pulsar signal to noise we rejected that GTI. The pulsar detection significance was highest in the energy range 0.31 to 1.18 keV. Ultimately, after all filtering and other exclusions were finished, we ended up with 521004 #emph[NICER]~XTI events. The details of the #emph[NICER] observations and pulse detection for PSR~J0740$+$6620 can be found in #cite(<2021..............W>, form: "prose").


We use the latest available calibration products, namely the nixtiref20170601v002 redistribution matrix file (RMF) and the nixtiaveonaxis20170601v004 ancillary response file (ARF). For the latter, the effective areas per energy channel were corrected by a factor of $51 / 52$ to account for the removal of all events from DetID 34. The response properties of #emph[NICER] incorporated in these calibration products represented the best effort by the instrument modeling team that were available in August 2020 when the analysis presented in this paper was begun.


PSR~J0740$+$6620 was also targeted with #emph[XMM-Newton] on three separate occasions: 2019 October 26 (ObsID 0851181601), 2019 October 28 (ObsID 0851181401), and 2019 November 1 (ObsID 0851181501) as part of a Director's Discretionary Time program. All three European Photon Imaging Camera (EPIC) instruments (pn, MOS1, and MOS2) were operated in 'Full Frame' imaging mode with the 'Thin' filters in the optical path. Due to the long detector read-out times (73.4~ms for EPIC-pn and 2.6~s for EPIC-MOS1/2), the data do not permit a pulse-phase-resolved analysis. Data summed over phase are used in the analysis that follows. The #emph[XMM-Newton] data were processed with the Science Analysis Software (SAS#footnote[The #emph[XMM-Newton] SAS is developed and maintained by the Science Operations Centre at the European Space Astronomy Centre and the Survey Science Centre at the University of Leicester.]) using the recommended procedures. We employed the recommended event grade PATTERN and FLAG values that ensured only real photon events recorded by the instruments were included in our analysis ($lt.eq 12$ for MOS1/2 and $lt.eq 4$ for pn). All three of these #emph[XMM-Newton] observations were obtained while the satellite was in a part of its orbit that suffered from intense particle flaring effects. Only 6.8 ksec of the total 20.8 ksec of EPIC-pn exposure had sufficiently low background to be used in our analysis, and only 18.0/18.7 ksec of the total 26.7/34.3 ksec of MOS1/2 exposures could be utilized. A circular extraction region of radius 25\" centered on the radio timing position of PSR~J0740$+$6620 was used to produce clean source event lists. The #emph[XMM-Newton] instrument response files specific to the PSR J0740+6620 observations were then generated using the rmfgen and arfgen tools in SAS.


Under normal observing circumstances, one uses regions nearby to the target source in the instrument image plane from the same observations to estimate the observational background. In our case, however, due to the short durations of these observations, very few background counts are available to estimate the background. As an alternative, we obtained representative background estimates with longer exposures from the blank sky event files provided by the #emph[XMM-Newton] Science Operations Centre. The blank sky images were filtered in the same manner as the PSR~J0740$+$6620 images and the background was extracted from the same location on the detector image plane as the pulsar. The resulting background spectrum was then rescaled so that the exposure times and pixel-area factors match those of the PSR~J0740$+$6620 exposures.


== Calibration of the Instruments
<sec:calibration>


The effective area of the #emph[NICER] XTI is determined primarily using observations of the Crab pulsar and nebula. The energy-dependent residuals in the fits to the Crab spectrum are typically at the level of $lt.tilde 2 "%"$#footnote[See #link("https://heasarc.gsfc.nasa.gov/docs/heasarc/caldb/nicer/docs/xti/NICER-xti20200722-Release-Notesb.pdf") for further details.]. The calibration accuracy for the #emph[XMM-Newton] EPIC-MOS and EPIC-pn cameras is determined to better than 3\% and 2\% (at 1$sigma$), respectively #footnote[See in particular Table 1 in #link("https://xmmweb.esac.esa.int/docs/documents/CAL-TN-0018.pdf").]. However, in the absence of a suitable absolute calibration source, the uncertainties in the absolute energy-independent effective areas that we use for the #emph[NICER] XTI and the three #emph[XMM-Newton] detectors are estimated to be no more than $plus.minus 10$\% (e.g., Figure C2 in #cite(<2021arXiv210205666R>, form: "prose")\; see @sec:relative-normalization for further discussion).


= METHODS
<sec:methods>


Our approach to modeling the X-ray data is largely the same as it was in #cite(<2019ApJ...887L..24M>, form: "prose"), except that for our analysis of PSR~J0740$+$6620 we used both #emph[NICER] and #emph[XMM-Newton] data, and we use blank-sky observations to estimate the non-source counts in the #emph[XMM-Newton] data. In @sec:modeling-the-emission through @sec:waveform-models, we summarize briefly the approaches used in #cite(<2019ApJ...887L..24M>, form: "prose"), and refer the reader to that paper for details and tests of our procedures. In @sec:fitting-procedure we discuss the new aspects of our fitting procedure, which include analyzing multiple data sets and incorporating independent estimates of the background made using the #emph[XMM-Newton] data. We conclude this section with short discussions of our parameter estimation procedure in @sec:parameter-estimation (which is the same as was described in #cite(<2019ApJ...887L..24M>, form: "prose")), our choice of energy channels in @sec:energy-channels (which is different from the choice made in #cite(<2019ApJ...887L..24M>, form: "prose") because we are using an updated energy calibration for #emph[NICER] and because we also use #emph[XMM-Newton] data in our analysis), and the effects of a possible difference in the absolute calibration of #emph[NICER] and #emph[XMM-Newton] in @sec:relative-normalization.


== Modeling the Emission from the Stellar Surface
<sec:modeling-the-emission>


The soft X-ray emission from old, non-accreting pulsars such as PSR J0740$+$6620 is believed to be generated when particles with large ($gt.double 100$) Lorentz factors are produced in pair cascades and deposit their energy deep in the atmosphere of the neutron star (#cite(<1974RvMP...46..815T>, form: "prose")@2001ApJ...556..987H @2002ApJ...568..862H @2007ApJ...670..668B\; see #cite(<2019ApJ...872..162B>, form: "prose") and #cite(<2020A-A...641A..15S>, form: "prose") for explorations of the consequences for the beaming pattern of emission from the stellar surface if significant energy is in particles with lower Lorentz factors). The specific intensity as a function of the angle between the photon propagation direction and the local surface normal depends on the assumed composition, the ionization state, and the strength (and potentially the orientation) of the surface magnetic field at the point of emission.


We follow #cite(<2019ApJ...887L..24M>, form: "prose") in assuming that the atmosphere is pure hydrogen and that the magnetic field can be neglected. In more detail:


#emph[Composition of the upper atmosphere].---The surface gravity of a neutron star is great enough that the lightest element present is expected to float to the top within seconds to minutes (based on extrapolations of the calculations in #cite(<1980ApJ...235..534A>, form: "prose")). As hydrogen is also the most abundant element in the universe and PSR~J0740$+$6620 likely underwent prolonged accretion to reach its current rotational frequency, it is probable that the atmosphere is pure hydrogen @1992ApJ...399..634B @2019MNRAS.484..974W @2020MNRAS.493.4936W. Note that there are some accreting neutron star binaries in which the transferred matter is thought to have little to no hydrogen (such as 4U~1820$-$30; see, e.g., #cite(<2002ApJ...566.1045S>, form: "prose")), but such binaries have extremely short orbital periods (e.g., #cite(<1987ApJ...312L..17S>, form: "prose") find that the orbital period of 4U~1820$-$30 is just 685 seconds). Thus the binary is very compact and as a result the hydrogen envelope is believed to have been completely stripped off. In contrast, the binary containing PSR~J0740$+$6620 has an orbital period of 4.77 days @2020NatAs...4...72C and the companion could therefore have had a significant hydrogen envelope. Even if the accreted elements were primarily heavier than hydrogen, spallation might create enough hydrogen to dominate the atmosphere @1992ApJ...384..143B @2019ApJ...887..100R.


#emph[Ionization fraction].---The hot spots on PSR~J0030$+$0451 were inferred to have effective temperatures (i.e., the temperature of blackbody that would produce a bolometric photon flux equal to the bolometric photon flux produced by the model atmosphere we are considering, which is not a blackbody) $k T_(upright("eff")) > 0.1$~keV @2019ApJ...887L..24M @2019ApJ...887L..21R, which implies that essentially all atmospheric hydrogen is completely ionized. The fits we find for PSR~J0740$+$6620 have effective temperatures $k T_(upright("eff")) > 0.08$~keV for both spots, which also implies nearly full ionization. However, the atmospheric densities are high enough that some neutral atoms may be present. We therefore performed fits using the NSX code for model atmospheres assuming full ionization @2001MNRAS.327.1081H and also with partial ionization (#cite(<2009Natur.462...71H>, form: "prose")\; see #cite(<2005MNRAS.360..458B>, form: "prose") for the relevant opacity tables). We find no significant difference in the inferred mass and radius between the results obtained using our two different ionization assumptions. This is consistent with previous work @2013ApJ...776...19L @2015ApJ...808...31M, which finds that in analyses of phase-channel X-ray data such as is collected using #emph[NICER], even if the assumptions used in the fit deviate from the properties of the star there is no significant bias in the mass and radius if the fit appears to be statistically good (as measured by, e.g., $chi^2 / upright("dof")$ or other standard statistics). Here we report only on runs that allow for the possibility of partial ionization.


#emph[Effect of the magnetic field on the soft X-ray emission from the stellar surface].---Using Equation~(12) of #cite(<2006ApJ...643.1139C>, form: "prose"), assuming a magnetic field inclination of $pi / 2$ and $alpha = 0$ for the magnetic field configuration, the period $P = 0.00289$~seconds and period derivative $dot(P) = 1.219 times 10^(- 20)$ of PSR~J0740$+$6620 @2020NatAs...4...72C imply that for a centered dipole the polar magnetic field at the surface is $B approx 3 times 10^8$~G. The electron cyclotron energy at that field strength is $approx 3$~eV, which has a small effect on atomic structure @2001RvMP...73..629L @2014PhyU...57..735P and is $tilde 100$ times lower than the lowest energies we consider in our fits. The spot configuration resulting from our analysis is close enough to a centered dipole that it is plausible that the effects of the field on radiative transfer are negligible. For example, in our best fit the two spots are separated by $approx 2$~radians on the surface. The chord length is therefore $approx sin ( 1 ) approx 0.84$ times smaller than a diameter, so if the magnetic field is a dipole centered between the two spots then the field strength at the surface is $approx 1 / 0.84^3 approx 1.7$ times larger than it would be if the field were centered at the center of the star. Thus in this example the surface magnetic field at the spots would increase only to $approx 5 times 10^8$~G. We follow #cite(<2019ApJ...887L..24M>, form: "prose") in noting that if the field is strong enough to change significantly the spectrum and beaming pattern, then fits assuming a negligible field would likely be statistically poor and/or would yield unreasonable parameter values. Thus the good quality of our fits could be considered an argument in favor of our assumption that the field can be neglected. However, this conclusion is not certain and a rigorous resolution of this question would require the construction, and use in fits, of atmospheric models with a fine grid of magnetic field strengths and orientations to the local surface normal. Such models are challenging to compute at the needed $B tilde 10^9 - 10^10$~G because at those field strengths Coulomb and magnetic effects are comparable to each other.


== Our Approach to Modeling the Soft X-ray Waveform
<sec:waveform-modeling>


Our modeling of the #emph[NICER] pulse waveform of PSR~J0740$+$6620 builds on the modeling of the waveform of PSR~J0030$+$0451 discussed in #cite(<2019ApJ...887L..24M>, form: "prose")\; see #cite(<2019ApJ...887L..26B>, form: "prose")@2021arXiv210406928B for detailed descriptions of how we computed pulse waveforms and tested their accuracy. The waveform of PSR~J0740$+$6620 has two clear peaks and therefore cannot be modeled using a star with a single circular hot spot. Unlike for PSR~J0030$+$0451, and possibly related to the faintness of PSR J0740+6620, and hence the much smaller number of counts in its pulse waveform, we find that a model with two uniform circular hot spots produces a waveform that adequately fits the data, and that adding complexity to the temperature pattern on the stellar surface does not improve the fit. For example, adding a third hot spot to the model or allowing the spots to be oval rather than circular did not improve the fit. We therefore fit the #emph[NICER] and #emph[XMM-Newton] data for PSR~J0740$+$6620 using a pulse waveform produced by two uniform-temperature circular spots.


Once the number of spots to be considered and their allowed shapes (e.g., oval or circular) are specified, our spot modeling algorithm automatically explores the full parameter space, to find the configurations with the highest likelihoods (see #cite(<2019ApJ...887L..24M>, form: "prose")). The algorithm not only considers configurations in which the spots are disjoint or in contact, but also configurations in which they partially or completely overlap. This allows the algorithm to model approximately spots with temperature gradients, if these are favored by the data, by allowing spots with different temperatures to partially or completely overlap. This is done by assigning a number to each of the spots. For example, for the two-spot model used here, the spots are labeled 1 and 2. Points on the stellar surface that are covered by both spots are assumed to emit with the effective temperature of the lower-numbered spot. This labeling, and the precedence given to the emission by the lower-numbered spot, is not related to any other property of the spot. For example, the effective temperature of spot 1 could be either higher or lower than the effective temperature of spot 2. This approach is highly flexible, and can be generalized to any number of spots (see #cite(<2019ApJ...887L..24M>, form: "prose") for details). For example, in addition to the best-fit solution we feature in this paper, our algorithm also found a lower-likelihood solution with a large, crescent-shaped emitting region that it modeled using a spot with a temperature so low that it is essentially dark lying on top of a hotter spot. This solution is disfavored by a Bayes factor greater than 3000 as measured by MultiNest \[see Section 3.5\], so we have set it aside for the purposes of this paper.


Section 4 of #cite(<2019ApJ...887L..24M>, form: "prose") reported the results of an analysis of synthetic #emph[NICER] pulse waveform data constructed assuming two, uniform-temperature, circular hot spots, and separately, an analysis of synthetic data assuming two, uniform-temperature, oval hot spots. In both cases, the values of the model parameters inferred from the analysis was consistent with the values assumed in the constructing the synthetic pulse waveform data. As another test of our analysis algorithm, in @sec:synthetic of this paper we report a joint analysis of synthetic #emph[NICER] and #emph[XMM-Newton] pulse waveform data sets that were generated using the hot spot model that we found provides a good description of the actual #emph[NICER] and #emph[XMM-Newton] data on PSR~J0740$+$6620. This analysis includes analyses of four separate data sets, each with a realistic background.


== Waveform Models
<sec:waveform-models>


The parameters used in the pulse waveform modeling we report here are listed and defined in @tab:wf-primary-parameters, with their assumed priors. We assume that the effective temperature is uniform over a given spot.


Because PSR~J0740$+$6620 is in a binary system, we have additional information on some of the parameters, beyond that provided by the #emph[NICER] and #emph[XMM-Newton] data. In particular, #cite(<2021arXiv210400880F>, form: "prose") find that at 68\% credibility the mass is $M = 2.08_(- 0.069)^(+ 0.072) ~ M_⊙$, the distance is $1.136_(- 0.152)^(+ 0.174)$~kpc, and our line of sight makes an angle of $87.5^compose plus.minus 0.17^compose$ to the orbital axis of the system.


We caution that other lines of evidence imply that PSR~J0740$+$6620 has a lower mass. Prominent among these is that there is an observationally established correlation between the white dwarf mass and the orbital period in white-dwarf binaries @1999A-A...350..928T @2014ApJ...781L..13T&A...350..928T@2014ApJ...781L..13T, which would suggest a strong upper limit of $2 ~ M_⊙$ to the mass of PSR~J0740$+$6620. If the mass is indeed less than our current best estimate, the main effect will be to decrease our estimate of the radius. Although it is not generally true that the compactness $G M / ( R c^2 )$ is measured to better fractional precision than the radius (see Section~4 of #cite(<2021arXiv210406928B>, form: "prose")), this is true for PSR~J0740$+$6620 because, as we discuss in more detail below, the most important information about the radius comes from the modulation fraction. A star that is more compact will deflect light rays coming from its surface by a larger angle, allowing a given observer to see more of the surface, which reduces the modulation fraction the observer sees. As a result, this estimate of the radius of PSR J0740+6620 is roughly proportional to its mass. Because the fractional uncertainty in the compactness of PSR~J0740$+$6620 is large, even an estimated mass of (for example) $1.8 ~ M_⊙$ would produce a radius posterior that largely overlaps the posterior we report here.


We use the radio observations of #cite(<2021arXiv210400880F>, form: "prose") to impose a Gaussian prior on the mass of $M = 2.08 plus.minus 0.09 ~ M_⊙$, where we have linearly added an estimated systematic error of $0.02 ~ M_⊙$ to the mass estimate from #cite(<2021arXiv210400880F>, form: "prose") (E. Fonseca, personal communication), and an asymmetric Gaussian prior probability distribution centered at $d = 1.136$~kpc with 68\% cumulative probability points at $d = 0.956$~kpc and $d = 1.336$~kpc, where we have placed the 68\% cumulative probability points 0.03~kpc further from the central value than the quoted statistical uncertainty, to reflect the 0.03~kpc estimated systematic error (E. Fonseca, personal communication).


Our analysis depends on the inclination of our line of sight to the pulsar's rotational axis. Millisecond pulsars such as PSR~J0740$+$6620 are believed to be recycled by accreting matter from their companion stars (see, e.g., #cite(<1991PhR...203....1B>, form: "prose")). Consequently, the orientation of their rotational axis is thought to be determined by the angular momentum of the matter accreted from the companion; accretion of this matter is expected to gradually align the pulsar's rotational axis with the orbital axis of the system. However, this alignment is not expected to be perfect, and the current rotational axis of the pulsar may therefore be tilted by a few degrees relative to the orbital axis of the binary system. For the analyses reported in this paper, we have adopted a prior on the angle between the observer's line of sight and the pulsars rotation axis that is flat within $5^compose$ of the best estimate of the system's orbital inclination, which is $87.5^compose$, and zero outside this range. We find that the inferred mass and radius of PSR~J0740$+$6620 are insensitive to the precise value of the orbital inclination with this range (see the corner plots in the appendices and the discussion in @sec:priors).


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

#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (center,left,center,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [Definition], [Assumed Prior ],),
    table.hline(),
    [$c^2 R_e / ( G M )$], [Inverse of stellar compactness], [$3.2 - 8.0$],
    [$M$], [Gravitational mass], [$exp [ - ( M - 2.08 ~ M_⊙ )^2 / 2 ( 0.09 ~ M_⊙ )^2 ]$],
    [$theta_(upright("c1"))$], [Colatitude of spot 1 center], [$0$ to $pi$ radians],
    [$Delta theta_1$], [Spot 1 radius], [$0 - 3$ radians],
    [$k T_(upright("eff"), upright(1))$], [Spot 1 effective temperature], [$0.011 - 0.5$~keV],
    [$Delta phi.alt_2$], [Spot 2 longitude difference], [$0 - 1$ cycles],
    [$theta_(upright("c2"))$], [Colatitude of spot 2 center], [$0$ to $pi$ radians],
    [$Delta theta_2$], [Spot 2 radius], [$0 - 3$ radians],
    [$k T_(upright("eff"), upright(2))$], [Spot 2 effective temperature], [$0.011 - 0.5$~keV],
    [$theta_(upright("obs"))$], [Observer inclination], [$1.44 - 1.62$ radians],
    [$N_H$], [Neutral H column density], [$0 - 20 times 10^20$~cm$""^(- 2)$],
    [$d$], [Distance], [$exp [ - ( d - 1.136 ~ upright("kpc") )^2 / 2 ( 0.2 ~ upright("kpc") )^2 ]$, $d gt.eq 1.136 ~ upright("kpc")$],
    [], [], [$exp [ - ( d - 1.136 ~ upright("kpc") )^2 / 2 ( 0.18 ~ upright("kpc") )^2 ]$, $d lt.eq 1.136 ~ upright("kpc")$],
    [$A_(upright("XMM"))$], [#emph[XMM-Newton] effective area], [],
    [], [divided by nominal area], [$0.9 - 1.1$],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Primary parameters of the pulse waveform models considered in this work.]
  , kind: table
  )
<tab:wf-primary-parameters>






== Our Waveform Modeling Procedure
<sec:fitting-procedure>


For PSR~J0030$+$0451 we had only #emph[NICER] data to analyze. In contrast, for PSR~J0740$+$6620 we also have #emph[XMM-Newton] imaging data from pn, MOS1, and MOS2. We therefore need to model all four data sets jointly. Once we have full models including backgrounds for all four data sets, then the log likelihood of the data given the model is simply the sum of the log likelihoods of each of the individual data sets. Thus


$ ln cal(L)_(upright("tot")) = ln cal(L)_(upright("NICER")) + ln cal(L)_(upright("XMM") - upright("pn")) + ln cal(L)_(upright("XMM") - upright("MOS1")) + ln cal(L)_(upright("XMM") - upright("MOS2")) #h(0em) . $


In writing the total log likelihood this way, we are assuming that the data sets are uncorrelated with each other. This assumption is clearly justified for the independent #emph[NICER] and #emph[XMM-Newton] data. It is also reasonable for the three #emph[XMM-Newton] data sets because the pn, MOS1, and MOS2 cameras are all separately mounted and read out on #emph[XMM-Newton]\; there is no plausible mechanism that would link counts in one detector with counts in another detector.


For each individual data set we compute the log likelihood by summing the log Poisson likelihood of the data given the model in all of the phase bins and energy channels, neglecting the log factorial term that is common to all models. That is, if we have broken the data into bins $phi.alt_i$ in rotational phase, and energy channels $E_j$, and in each phase-channel bin the model predicts $m_(i j)$ counts (a positive real number) and $d_(i j)$ counts are observed (a nonnegative integer) then the Poisson likelihood of the data given the model in that phase-channel bin is $[ m_(i j)^(d_(i j)) / d_(i j) ! ] e^(- m_(i j))$. However, the factor $1 / d_(i j) !$ is common to all models and hence can be neglected in both parameter estimation and model comparison. The log likelihood we use is therefore


$ ln cal(L) = sum_(phi.alt_i) sum_(E_j) (d_(i j) ln m_(i j) - m_(i j)) #h(0em) , $


where there is an implied sum over all four instruments. The #emph[NICER] data have 32 phase bins. In contrast, for each of the three #emph[XMM-Newton] data sets, we have only one bin in rotational phase because the timing resolution is insufficient to divide the data further.


We now discuss the two components of the calculation of $m_(i j)$ for each phase-channel bin in each data set: the computation of the model counts from the spots for each of the four instruments, which is straightforward, and the incorporation of phase-independent background counts, which is more involved and requires different treatments for the #emph[NICER] and for the #emph[XMM-Newton] data. ~


=== Calculation of the model counts from the spots
<calculation-of-the-model-counts-from-the-spots>


Suppose that we are considering a particular parameter combination, i.e., we have some combination of $M$, $R_e$, $theta_(upright("obs")) , dots.h$ to assess. Given the specified observation time, this gives us a spots-only waveform that is unique up to an arbitrary definition of the time corresponding to phase 0. As described in Section~3.4 of #cite(<2019ApJ...887L..24M>, form: "prose"), once we have a candidate waveform that includes both the contribution from the spots and the contribution from the phase-independent background, we marginalize over the overall phase by fitting a Gaussian to the likelihood as a function of phase (this is equivalent to simply fitting a parabola to the log likelihood near its peak). We only need to carry out this process for the #emph[NICER] data, because the #emph[XMM-Newton] data have only one phase.


=== Inclusion of unmodulated background
<sec:background>


By “background” we mean any X-ray counts that are not contributed by the spots. This could include space weather, optical loading, resolved or unresolved background or foreground sources, the instruments themselves, or in the case of a binary such as PSR~J0740$+$6620, the companion star (e.g., interactions of the neutron star particle wind with the companion star could produce X-rays). What these have in common is that those X-rays are not modulated at the rotational frequency of the star and hence with enough exposure time they contribute equally at all rotational phases.


#cite(<2019ApJ...887L..24M>, form: "prose") therefore treated all non-stellar X-rays with a single approach, which we adopt here for the #emph[NICER] data: for each energy channel independently we allow there to be a phase-independent component of any magnitude. We therefore do not assume any particular spectral form for the non-stellar emission, but in practice this results in an estimated background that varies smoothly with energy channel. The assumption of independence between channels means that we can fit a Gaussian to the likelihood of each energy channel as a function of added background, and can then analytically integrate the likelihood to marginalize over the background. See #cite(<2019ApJ...887L..24M>, form: "prose") for more details. We also note (see #ref(<sec:estimating-J0740-mass-radius>) for a more thorough discussion) that future analyses may be able to incorporate estimates of the #emph[NICER] background rather than letting the background be completely free.


The #emph[XMM-Newton] data must be treated differently, because there is only one phase bin, in contrast to the 32 rotational phase bins that we use for the #emph[NICER] data. To understand why, suppose that we treat the #emph[XMM-Newton] background, for any instrument, in the same way that we treat the #emph[NICER] background: each energy channel (with its single phase) can have added to it any number of background counts. Then the best model for the #emph[XMM-Newton] data would have zero counts from the spots, and the background would equal the observed number of counts. This would automatically maximize the log likelihood. The #emph[NICER] data are not driven to this pathological fit because there is clear modulation in the data; a phase-independent, background-only fit cannot reproduce this modulation.


Therefore, we instead assume that the blank-sky background is a Poisson realization of the full #emph[XMM-Newton] background. Each of the #emph[XMM-Newton] instruments has had, throughout the course of the mission, significant exposure to portions of the sky with no known X-ray sources (see @sec:observations). The total blank-sky count rate in the #emph[XMM-Newton] energy channels of interest is $tilde 20 - 30$% of the count rate in our #emph[XMM-Newton] observations of PSR~J0740$+$6620, so incorporation of this background is expected to make a meaningful difference to our analysis. We note that there are other possible contributions than the blank sky to the phase-independent background. For example, as mentioned above, the interactions of the pulsar wind with the binary companion could produce X-rays. Because the total count rate is fixed, if the background is larger then the estimated total count rate from the neutron star is reduced. As a result, the modulation fraction is increased because the modulated count rate is fixed by the #emph[NICER] observations. In turn, this would increase the inferred radius for PSR~J0740$+$6620. In our treatment we effectively assume that these other contributions can be neglected.


Even with hundreds of thousands of seconds of total exposure time, the total number of counts from the blank sky observations is too small in many of the energy channels to use Gaussian statistics. Therefore we need to use Poisson statistics. Our approach to the pn, MOS1, and MOS2 backgrounds is as follows.


Consider some particular #emph[XMM-Newton] energy channel $n$ for one of the three instruments. Suppose that the blank-sky observation had duration $T_(upright("back"))$ and yielded $b_(upright("back"))$ counts. If the prior on the background counts is flat, then the Poisson probability distribution for the time-averaged number of counts $b_(upright("avg"))$ for an interval $T_(upright("back"))$ is


$ P ( b_(upright("avg")) ) d b_(upright("avg")) = ( 1 / b_(upright("back")) ! ) b_(upright("avg"))^(b_(upright("back"))) exp ( - b_(upright("avg")) ) d b_(upright("avg")) #h(0em) . $<eq:avgrate>


Now suppose that for the #emph[XMM-Newton] instrument under consideration the PSR~J0740$+$6620 observation has a duration of $T_(upright("obs"))$. Then a given $b_(upright("avg"))$ implies an expected number of counts $b_(upright("obs")) = b_(upright("avg")) ( T_(upright("obs")) / T_(upright("back")) )$ counts in that observation. Then because $b_(upright("avg")) = ( T_(upright("back")) / T_(upright("obs")) ) b_(upright("obs"))$, @eq:avgrate implies that the normalized probability distribution for $b_(upright("obs"))$ is


$ P ( b_(upright("obs")) ) d b_(upright("obs")) = ( 1 / b_(upright("back")) ! ) [ b_(upright("obs")) ( T_(upright("back")) / T_(upright("obs")) ) ]^(b_(upright("back"))) exp [ - b_(upright("obs")) ( T_(upright("back")) / T_(upright("obs")) ) ] ( T_(upright("back")) / T_(upright("obs")) ) d b_(upright("obs")) #h(0em) . $


If the energy channel had $d$ observed counts in our PSR~J0740$+$6620 observation, then the probability of obtaining that in a model with $m$ expected counts is


$ p ( d | m ) = m^d / d ! ~ exp ( - m ) #h(0em) . $


If in our model we have $s$ expected counts from the spots, then given a background $b$ we expect a total number of counts $m = s + b$. Setting $b = b_(upright("obs"))$ as above, we find that the final likelihood of the data $d$ given the spot counts $s$ and the distribution $P ( b_(upright("obs")) ) d b_(upright("obs"))$ is


$ p ( d | s , upright("back") ) = integral_0^oo [ ( s + b_(upright("obs")) )^d / d ! ] exp [ - ( s + b_(upright("obs")) ) ] P ( b_(upright("obs")) ) d b_(upright("obs")) #h(0em) . $


We find that we achieve sufficient precision for this integral by (1) setting a scale for $b_(upright("obs"))$ that is $T_(upright("obs")) / T_(upright("back"))$ if $b_(upright("back")) = 0$, or $b_(upright("back")) ( T_(upright("obs")) / T_(upright("back"))$) otherwise, and (2) performing a Simpson's rule integration from 0 to 6.8 times that scale, in intervals of 0.1 times that scale.


== Parameter Estimation and Model Evaluation
<sec:parameter-estimation>


As in #cite(<2019ApJ...887L..24M>, form: "prose"), we began our sampling of parameter space using the publicly available nested sampler MultiNest @2009MNRAS.398.1601F, typically with 1000 live points, a target efficiency of 0.01 (with variable efficiency), and a tolerance of 0.1. The inverse of the efficiency parameter determines the factor by which the bounding hyperellipsoids constructed by MultiNest are expanded before samples are drawn from within them (see Section 5.2 of #cite(<2009MNRAS.398.1601F>, form: "prose")). Lower efficiency means more thorough sampling, and better accommodation of isolikelihood surfaces that are not well-described by ellipsoids. We chose an efficiency of 0.01, which is more than an order of magnitude below the standard recommendation, because we found in early tests that when we fixed the number of live points to 1000 and used efficiencies of 0.1 and 0.03 the $plus.minus 1 sigma$ credible regions for the radius were, respectively, 45% and 22% narrower than for our efficiency=0.01 runs, and thus that the sampling at these higher efficiencies with 1000 live points was incomplete.


MultiNest is designed to estimate the Bayesian evidence for a model, and can also provide a quick characterization of parameter space. However, the purpose of nested samplers such as MultiNest is to compute the evidence; convergence of that calculation does not guarantee convergence of the posteriors of the parameters. Studies have shown that nested samplers of this type can give incorrectly small credible regions if isolikelihood surfaces cannot be well-represented by overlapping hyperellipsoids @2014SaC...2014.1B @2020AJ....159...73N @2021arXiv210109675B. This appears be the case for our PSR~J0740$+$6620 parameter estimation; we found that the parameter space was not completely explored even at the lowest efficiencies and largest number of live points that we employed. As one example, when we used MultiNest to analyze just the #emph[NICER] data with 1000 live points, a target efficiency of 0.01, and a tolerance of 0.1, the $plus.minus 1$ standard deviation range in the radius posterior had 67% of the width we obtained using parallel-tempered emcee (see the next paragraph). When we used 3000 live points, a target efficiency of 0.01, and a tolerance of 0.1 the width increased, but only to 79% of the emcee width.


We therefore use a kernel density estimate of the MultiNest posteriors to produce the initial positions of the walkers, which we find expedites convergence, especially for multi-modal posteriors, in the parallel-tempered Markov chain Monte Carlo (MCMC) sampler PT-emcee that is included in the publicly available emcee package, version 2.2.1 @2013PASP..125..306F. Because MCMC samplers are designed to satisfy detailed balance, there is a theoretical expectation that the samples will represent the posterior. For the PT-emcee runs we had 1000 walkers per parallel-tempering temperature rung; exploratory runs with 2000 walkers per rung produced results that were consistent with what we report here. We started with five temperature rungs, but found that the number of rungs was not critical and reduced the number to two later in the sampling.


== Choice of Energy Channels
<sec:energy-channels>


In their analysis of the PSR~J0030$+$0451 data, #cite(<2019ApJ...887L..24M>, form: "prose") used only #emph[NICER] energy channels 40 and above, because they found that inclusion of lower-energy channels biased the inferred distance. For our analysis of the PSR~J0740$+$6620 data we use the updated July 2020 #emph[NICER] response (see https:\/\/heasarc.gsfc.nasa.gov/docs/heasarc/caldb/nicer/). With this response there does not appear to be any bias in distance or other quantities when we use data down to energy channel 30. Analysis of the #emph[NICER] data showed that the detection significance is optimized when we use channels up to 118 (see @sec:data-used), but there is also an excess of counts relative to the background up to channel $tilde 150$. We used a range between these (channels 30 through 123 inclusive), but exploratory runs including channels up to 150 did not produce palpably different results. Given that the width of the #emph[NICER] channels is $0.001$~keV, our energy channel choice corresponds approximately to photon energies between $0.3$~keV and $1.23$~keV. For the #emph[XMM-Newton] data, we used channels 57$-$299 inclusive for pn, channels 20$-$99 inclusive for MOS1, and channels 20$-$99 inclusive for MOS2.


== Relative Normalization of #emph[NICER] and #emph[XMM-Newton]
<sec:relative-normalization>


In addition to the uncertainty in the energy-dependent response of an instrument, there is inevitably some uncertainty in the overall response. That is, the overall normalization of the response is not known perfectly. A conservative upper limit on the fractional uncertainty of the relative normalization between #emph[NICER] and the three #emph[XMM-Newton] instruments is $tilde 10$%#footnote[For the cross-calibration as of December 2018 see the lower panel of Figure C2 in #cite(<2021arXiv210205666R>, form: "prose"). For the cross-calibration as of November 2020 see slide 7 of http:\/\/iachec.org/wp-content/presentations/2020/NICER-CrossCal-IACHEC-Markwardt-2020b.pdf and note in particular that in the energy range relevant to our analyses, $0.3 - 1$~keV, the flux inferred from 3C~273 agrees between #emph[NICER] and #emph[XMM-Newton] to much better than 10%.]. The three #emph[XMM-Newton] instruments are thought to have the same overall normalization to $tilde 2 - 3$%, which are differences small enough to be neglected. Errors in the overall normalization of #emph[NICER] are absorbed in the $> 15$% half-width of our prior on the distance. However, there is still a question of whether the overall normalizations of #emph[NICER] and #emph[XMM-Newton] could affect our fits.


To explore this, we report in #ref(<sec:estimating-J0740-mass-radius>) an additional fit in which we add one more parameter: $A_(upright("XMM"))$, which is a single number that multiplies the ARFs of all three #emph[XMM-Newton] instruments that we consider. We explore the consequences of allowing $A_(upright("XMM"))$ to be between $0.9$ and $1.1$, i.e., the largest possible range. We therefore account for a possible inaccuracy in the ARF of #emph[NICER] by the freedom in the fit to the distance to the source, and for an additional independent inaccuracy of the ARF of the #emph[XMM-Newton] instruments using $A_(upright("XMM"))$. We find that introduction of the parameter $A_(upright("XMM"))$ does not produce a significant change in the posteriors of any of our parameters (for example, the radius limits are changed by at most 0.1~km) and the value of $A_(upright("XMM"))$ that we infer is consistent with 1.


= RESULTS OF THE ANALYSIS OF THE #emph[NICER] AND #emph[XMM-Newton] PULSE WAVEFORM DATA
<sec:fits-to-data>


Our joint fit of our two-circular-spot model to the #emph[NICER] and #emph[XMM-Newton] data yields an equatorial circumferential radius of $R_e = 13.7_(- 1.5)^(+ 2.6)$~km at 68% credibility for PSR~J0740$+$6620. In this section we describe how we reach this conclusion. In @sec:synthetic we demonstrate that our method produces statistically expected results when we fit our model to a synthetic data set that is drawn from a good fit to the PSR~J0740$+$6620 data including backgrounds, and is therefore realistic. In #ref(<sec:estimating-J0740-mass-radius>) we present our fits to just the #emph[NICER] data on PSR~J0740$+$6620, and to the #emph[NICER] and #emph[XMM-Newton] data combined. We show that although the radius posteriors in the two analyses have significant overlap, inclusion of the #emph[XMM-Newton] data favors larger radii. In @sec:convergence we show that our sampling of the parameter space has converged. In @sec:priors we address the effects of priors, and show that other choices for the upper limit of the radius and the allowed range of the observer inclination have little effect on the $- 1 sigma$ radius, which is particularly important in EOS inference (see @sec:EOS). In @sec:adequacy we address the adequacy of our model. We show that our model provides acceptable fits to the phase-channel #emph[NICER] data, the bolometric #emph[NICER] data, and the #emph[XMM-Newton] data from all three cameras. There is therefore no indication that our model for the PSR~J0740$+$6620 data is deficient. Finally, in @sec:differences we note some differences between our analysis method and that of #cite(<2021..............R>, form: "prose"), and suggest which of those differences could be important in producing different radius posteriors between the two groups.


In this section consider values of $R_(upright("eq")) c^2 / ( G M )$ up to 8.0, which corresponds to a radius $tilde 24$~km at $M tilde 2 ~ M_⊙$. We find that the radius posterior does not have significant probability near this boundary, and thus that this boundary does not bias our radius estimates. When we explore the implications of results for the EOS in @sec:EOS, we include information from nuclear theory and previous measurements.


== Fits to Synthetic #emph[NICER] and #emph[XMM-Newton] Data
<sec:synthetic>


Joint analyses of #emph[NICER] and #emph[XMM-Newton] data have not previously been performed in the context of neutron star mass and radius estimation. It is therefore important to demonstrate that our method yields the expected results when similar synthetic data are analyzed, because for synthetic data we know the parameter values used to construct the data and can therefore judge the quality of the fit.


To generate the data we started from a good model of the PSR~J0740$+$6620 #emph[NICER] and #emph[XMM-Newton] data, including all backgrounds. We then produced the synthetic data by drawing integer numbers of counts from our (in general non-integer) model expectation in each phase-channel bin for #emph[NICER], and in each energy channel for each of the three #emph[XMM-Newton] cameras. We emphasize that this leads to synthetic data with fully realistic backgrounds; previous synthetic data analyses (e.g., #cite(<2013ApJ...776...19L>, form: "prose")@2015ApJ...808...31M @2019ApJ...887L..24M @2021arXiv210406928B) have instead typically used power-law backgrounds. This is therefore the most realistic synthetic data test that has been performed in the radius estimation context.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Sampler], [$plus.minus 1 sigma$ (68.3%)], [$plus.minus 2 sigma$ (95.4%)], [$plus.minus 3 sigma$ (99.7%) ],),
    table.hline(),
    [PT-emcee], [6], [11], [12],
    [MultiNest], [4], [7], [9],
    [\(Nlive=1000, efficiency=0.01,
    table.hline(stroke: 0.8pt))], [], [], [],
    [MultiNest], [4], [8], [11],
    [\(Nlive=2000, efficiency=0.01)], [], [], [],
  )]
  , caption: [Verification of Fits to Synthetic #emph[NICER] and #emph[XMM-Newton] Data]
  , kind: table
  )
<tab:synth>






The results of our analysis of the synthetic data are summarized in @tab:synth, and more detail on our PT-emcee analysis is shown in @tab:crediblesynthetic and @fig:full-posteriors-for-synthetic in Appendix~#ref(<sec:corner-plot-Synthetic>, supplement: none). We see that the PT-emcee sampling yields results that are entirely consistent with statistical expectations. In contrast, MultiNest sampling with Nlive=1000 and an efficiency of 0.01 is not adequate; for example, 3 of the 12 parameters have $plus.minus 3 sigma$ credible regions that exclude the parameter value used to construct the data. The MultiNest sampling with Nlive=2000 and an efficiency of 0.01 is better but the credible regions are still too narrow: 1 of the 12 true parameter values is excluded at $> 3 sigma$, and 4 of the 12 are excluded at $> 2 sigma$. It is possible that, with more live points and/or lower efficiency, MultiNest analysis of our synthetic data would lead to the statistically expected outcomes, but results such as these form part of our motivation to use PT-emcee to determine posterior probabilities.


In summary, even with realistic backgrounds and even when analyzing jointly the #emph[NICER] and #emph[XMM-Newton] synthetic data, our analysis method yields statistically acceptable results.


== The Mass and Radius of PSR J0740$+$6620
<sec:estimating-J0740-mass-radius>


// [figvision] imgs/J0740_NICER_XMM_mr.png
// a. This panel shows a histogram plot with a dotted line. The y-axis ranges from 0.00 to 0.30 and is labelled
// "probability density". The x-axis ranges from 5 to 25 and is labelled "R_e (km)". The histogram is grey and
// the dotted line is dark blue-green. The trend shows a decreasing probability density as R_e increases. b. This
// panel shows a 2D plot with a colorbar. The y-axis ranges from 1.8 to 2.2 and is labelled "M (M_)". The x-axis
// ranges from 8 to 26 and is labelled "R_e (km)". The colorbar ranges from 0 to 3 and is labelled "credibility
// ()". There are white contour lines. The trend shows a peak in credibility around M = 2.0 and R_e = 13. c. This
// panel shows a histogram plot with a dashed line. The y-axis ranges from 0 to 4 and is labelled "probability
// density". The x-axis ranges from 1.7 to 2.45 and is labelled "M (M_)". The histogram is grey and the dashed
// line is black. The trend shows a peak in probability density around M = 2.1.
// [figvision] imgs/J0740_noXMM_mr.png
// a. This panel shows a histogram plot of probability density versus R_e (km). The x-axis ranges from 0 to 25 km
// and the y-axis from 0 to 0.3. There is one series, a grey histogram. There are no annotations or labels other
// than axis labels. The trend shows a peak at around 10 km, decreasing to almost 0 at 20 km and above. b. This
// panel shows a 2D plot of M (M_) versus R_e (km). The x-axis ranges from 6 to 26 km and the y-axis from 1.6 to
// 2.4 M_. The plot is coloured by credibility (), with a colour bar on the right ranging from 0 to 3 . There are
// white contour lines enclosing areas of high credibility. There are no annotations or labels other than axis
// labels. The trend shows a peak at around 11 km, 2 M_. c. This panel shows a histogram plot of probability
// density versus M (M_). The x-axis ranges from 1.6 to 2.4 M_ and the y-axis from 0 to 4. There is one series, a
// grey histogram, and a black dashed line. There are no annotations or labels other than axis labels. The trend
// shows a peak at around 2 M_, symmetrical and decreasing to almost 0 at 1.8 and 2.4 M_.
#figure([#box(image("imgs/J0740_noXMM_mr.png", width: 49.0%)) #box(image("imgs/J0740_NICER_XMM_mr.png", width: 49.0%))

  ],
  caption: [
    Comparison of the $M - R_e$ corner plots obtained using two circular spots, fit to only the #emph[NICER] data (left panels) and to both the #emph[NICER] and the #emph[XMM-Newton] data with the nominal #emph[XMM-Newton] calibration (right panels). All of the results that we present use pure hydrogen model atmospheres that allow for the possibility of partial ionization. The mass prior is represented by the dashed line in each of the one-dimensional mass posterior plots. In the mass-radius plots, brighter colors indicate higher posterior probability densities; the inner contour in these plots contains 68.3% of the posterior probability whereas the outer contour contains 95.4%. In the #emph[NICER]+#emph[XMM-Newton] one-dimensional radius posterior plot, the dotted line shows the posterior obtained using only the #emph[NICER] data. The two radius posteriors have substantial overlap, but the effect of including the #emph[XMM-Newton] data is to increase the favored radius by roughly 2~km.
  ]
)
<fig:MR-comparison>



// [figvision] imgs/mollweide_J0740_diffhemi.png
// Panel a: This is a schematic diagram in an equal-area Mollweide projection. The horizontal axis represents
// longitude, ranging from 0 to 360 degrees, and the vertical axis represents latitude, ranging from -90 to 90
// degrees. A black horizontal bar spans the figure at 0 degrees latitude. Two blue spots are plotted: one near 0
// longitude and 0 latitude, and the other near 90 longitude and -60 latitude. The spots have different shapes,
// one being circular and the other elliptical. Grid lines are shown in grey, with lines spaced 30 degrees apart.
// The trend shows two distinct spot locations.
#figure([#block[
  #box(image("imgs/mollweide_J0740_diffhemi.png", width: 100%))
  ]
  #block[
  ]],
  caption: [
    Spot locations for a representative fit, in an equal-area Mollweide projection. The horizontal bar indicates the colatitude of the observer. Because we observe from close to the rotational equator, and because the spots do not overlap, there is an approximate four-fold degeneracy in solutions.
  ]
)
<fig:spot-locations>



In this section we present fits to (1)~just the #emph[NICER] data (see @tab:credibleNICERonly in Appendix~#ref(<sec:corner-plot-NICERonly>, supplement: none) for the best fit and uncertainties, and the left hand panels of @fig:MR-comparison for the mass and radius posteriors), (2)~the #emph[NICER] data and the data from the three #emph[XMM-Newton] instruments, assuming the nominal calibration for #emph[XMM-Newton] (see @tab:credibleNICERXMM in Appendix~#ref(<sec:corner-plot-NICERXMM>, supplement: none) for the best fit and uncertainties, and the right hand panels of @fig:MR-comparison for the mass and radius posteriors), and (3)~the #emph[NICER] data and the data from the three #emph[XMM-Newton] instruments, with an additional energy-independent factor $0.9 < A_(upright("XMM")) < 1.1$ that multiplies the effective area of the #emph[XMM-Newton] instruments (see @tab:credibleNICERXMMnorm in Appendix~#ref(<sec:corner-plot-NICERXMMcalib>, supplement: none) for the best fit and uncertainties). The appendices have the full corner plots for each of the three fits. In all cases we use atmosphere tables for pure hydrogen that accommodate partial ionization.


@fig:spot-locations shows a representative spot pattern. We note that because the observer inclination is very close to the rotational equator, there is a near-symmetry between spots in the northern hemisphere (which we define to be the hemisphere of the observer) and the southern hemisphere. In addition, because the spots do not overlap, their labeling (i.e., which is spot 1 and which is spot 2) can be swapped without affecting the solution, unlike what would be the case if the spots overlapped. Thus there is an approximate four-fold degeneracy in the solution.


The inclusion of #emph[XMM-Newton] data increases the radius estimates: for example, with the #emph[NICER] data alone the $plus.minus 1 sigma$ range in radius is 10.382~km to 13.380~km, whereas when we add the #emph[XMM-Newton] data the range becomes 12.209~km to 16.326~km. This is because the prime source of information about the compactness is the modulation fraction (see #cite(<2016ApJ...822...27M>, form: "prose")). The #emph[NICER] data are dominated by background counts, which means that from that data set alone it could be that the modulation fraction is low. If other parameters such as the observer inclination and spot locations are fixed, then because light deflection increases with increasing compactness $G M / ( R_e c^2 )$, for a more compact star the light from spots is spread out more and thus the modulation fraction is reduced. As a result, the #emph[NICER] data alone can be fit with very compact stars. But when the #emph[XMM-Newton] data are included, we have a measure of the total flux from the star. This total flux is significantly less than the total flux in the #emph[NICER] data, because the #emph[NICER] data include significant background. Thus, the modulation fraction is higher than it appears to be from the #emph[NICER] data alone, and hence the compactness of the star must be lower. Because the mass is known with some precision, a lower compactness implies a larger radius.


We also note that, for the same reason, if reliable information about the non-spot #emph[NICER] flux were included in the #emph[NICER] data then the inferred radius would increase. That is, any information that places an upper limit on the flux from the spots, whether it comes from observations of the source (in our case, using #emph[XMM-Newton]) or a model of some part of the the non-spot flux (which we would obtain with a background model), increases the inferred modulation fraction and thus increases the inferred radius. Hence analysis of only the #emph[NICER] data on PSR~J0740$+$6620, if augmented with #emph[NICER] background data that (critically) have reliable estimates of the field-to-field variance as well as statistical uncertainties, is likely to result in an inferred radius that is close to the radius inferred when we also use #emph[XMM-Newton] data. The 3C50 #emph[NICER] background model of Remillard et al. (2021, submitted; see https:\/\/heasarc.gsfc.nasa.gov/docs/nicer/tools/nicer\_bkg\_est\_tools.html) is a good step in this direction, but the variance between the background in different sky pointings is not well understood.


We stress that despite the clear shift of the radius posterior distribution to larger radii when the #emph[XMM-Newton] data are included, this distribution is still broadly consistent with the distribution obtained using the #emph[NICER] data alone, even without background information. One indication of this is that there is a substantial overlap between the two $plus.minus 1 sigma$ ranges. To quantify this overlap we can compute, e.g., the Bhattacharyya coefficient @1943BCMS..35...99B


$ B C ( p , q ) = integral sqrt(p ( x ) q ( x )) d x $


for two normalized probability distributions $p ( x )$ and $q ( x )$. $B C = 1$ for identical distributions, whereas $B C = 0$ for distributions with zero overlap. In our case, $B C = 0.77$ when $p$ is the radius posterior using only the #emph[NICER] data and $q$ is the radius posterior when the #emph[XMM-Newton] data are also included, and when we represent those distributions using histograms with bin widths of 0.1~km. For context, $B C = 0.77$ for two unit-variance Gaussians whose centers are separated by roughly 1.5 times their standard deviations. This indicates that there is a significant overlap between the two distributions.


// [figvision] imgs/convergence.png
// a. This is a line plot showing the evolution of radius posterior values. The y-axis ranges from 11 to 16 km
// and the x-axis from 0 to 1500 sample set numbers. There are three series: a red line for the median, and blue
// lines for -1σ and +1σ. All lines are solid. A dashed vertical line is at sample set number 1000. The trend
// shows an increase in radius values that levels off after 1000 sample sets. b. This is a line plot showing the
// evolution of radius posterior values. The y-axis ranges from 11 to 16 km and the x-axis from 0 to 1000 sample
// set numbers. There are three series: a red line for the median, and blue lines for -1σ and +1σ. All lines are
// solid. A dashed vertical line is at sample set number 500. The trend shows stable radius values.
#figure(image("imgs/convergence_crop.png", width: 82%),
  caption: [
    Evolution of the $- 1 sigma$, median, and $+ 1 sigma$ values of the radius posterior as our PT-emcee sampling of the #emph[NICER]+#emph[XMM-Newton] data progressed. Each point in the plots indicates the estimated values of these three radii given by a single set of 20,000 contiguous, non-overlapping samples. The number of sets included in each estimate is shown by the numbers on the horizontal axis. Left: Evolution of these three radii as sampling proceeds, starting from the final posterior distribution provided by MultiNest, and assuming the nominal ratio of the #emph[NICER] overall effective area relative to that of #emph[XMM-Newton]. As sampling proceeded, all three radii increased rapidly and then converged to values that are larger, with a broader spread, than was obtained from the MultiNest sampling. The sample sets to the right of the dashed vertical line were used to construct the final posterior distribution from this run (a total of $10^7$ samples), which is what we used in our parameter estimation. Right: Evolution of the three radii as sampling proceeded, starting with a kernel density estimate of the posterior distribution obtained at the end of the previous run, but now including the overall effective area $A_(upright("XMM"))$ of #emph[XMM-Newton] as a parameter in the fit. The change in the treatment of the effective area produced a small shift in the values of these three radii relative to their final values in the left panel. As sampling progressed, the three radii rapidly approached the values they had at the end of the run shown in the left panel. The $10^7$ samples to the right of the dashed vertical line were used to construct the posterior distribution for this run. See the main text for more details.
  ]
)
<fig:convergence>



// [figvision] imgs/frame.png
// ## Panel a This panel shows a scatterplot of mass versus equatorial radius. The y-axis represents mass in
// solar masses (M), ranging from 1.75 to 2.25 M. The x-axis represents equatorial radius in kilometers, but the
// exact range is not shown. The points are black and densely clustered, with no visible line styles or symbols.
// There is a grey text box at the top right reading "First 200 iterations". The points appear concentrated in a
// small region, indicating a constrained range of values. ## Panel b This panel also shows a scatterplot of mass
// versus equatorial radius. The y-axis has the same range and units as panel a, 1.75 to 2.25 M. The x-axis
// represents equatorial radius in kilometers, with values from 10 to 25 km. The points are again black and
// densely clustered, but shifted and more spread out compared to panel a. There is a grey text box at the top
// right reading "Final 200 iterations". The points appear more dispersed than in panel a, indicating a wider
// range of values.
#figure([#block[
  #box(image("imgs/frame.png", width: 100%))
  ]
  #block[
  ]],
  caption: [
    Another view of the evolution of the sampling in our analysis of the #emph[NICER] and #emph[XMM-Newton] data on PSR~J0740$+$6620. The top panel shows the positions of the walkers in mass-radius space during the first 200 iterations of our PT-emcee sampling; these points were drawn from the posterior of an Nlive=1000, efficiency=0.01 MultiNest run, using a kernel density estimate. The bottom panel shows the positions of the walkers during the final 200 iterations, after the PT-emcee sampling had converged. These panels correspond to the beginning and end of the left panel of @fig:convergence, and demonstrate the difference in the sampling between the two stages.
  ]
)
<fig:conv2>



== Convergence of Sampling
<sec:convergence>


As we discussed in @sec:parameter-estimation, we started our PT-emcee sampling of the posterior using an initial distribution of points that had previously been obtained by using MultiNest (with Nlive=1000 and efficiency=0.01) to sample the posterior; as usual, MultiNest had run until the evidence estimate converged. The left panel of @fig:convergence shows the evolution of the $- 1 sigma$, median, and $+ 1 sigma$ values of the radius posterior as our PT-emcee sampling of the #emph[NICER]+#emph[XMM-Newton] data using the nominal calibration progressed, starting with the initial parameter distribution provided by MultiNest. Each point in this plot indicates the estimates of these three radii given by a single set of 20,000 samples; the individual sets are contiguous and non-overlapping. The evolution shown was computed using approximately 1700 such sample sets; we show another view of the progressive mass-radius sampling in @fig:conv2. The left panel in @fig:convergence shows that as the sampling by PT-emcee proceeded, the values of all three characteristic radii increased rapidly at first, indicating that the sampling achieved by MultiNest was insufficient and that the estimated values of the parameters it provided were inaccurate. Eventually the values of the three parameters ceased increasing and begin wandering up and down stochastically by small amounts, indicating that the PT-emcee estimates of the three radii had converged.


The dashed vertical line indicates the beginning of the sample sets that we used to construct our final posterior distributions (a total of $10^7$ samples). The effective number of independent samples can be estimated by dividing the total number of samples by the average integrated autocorrelation time. Using typical methods for calculating the autocorrelation time for each walker (e.g., #cite(<sokal1997>, form: "prose")) yields an estimate of $tilde 4$ iterations, suggesting a total of $tilde 2.5 times 10^6$ independent samples. From sample set to sample set in the converged part of the evolution, the median, $plus.minus 1 sigma$, and $plus.minus 2 sigma$ radii vary with a standard deviation of only a few hundredths of a kilometer.


The right panel of @fig:convergence shows the evolution of the three radii in our PT-emcee sampling of the model for the #emph[NICER]+#emph[XMM-Newton] data when a calibration parameter is included. Again we show the three radius values computed using contiguous and non-overlapping sets of 20,000 samples. This sampling was initiated using kernel density estimation based on 10% of the final posterior samples from the PT-emcee analysis of #emph[NICER]+#emph[XMM-Newton] data performed using the nominal #emph[XMM-Newton] calibration. As a result, the initial values of the three radii did not match perfectly the final values of the three radii in the left panel, indicating that the initial posterior distribution in the right panel does not quite match the final posterior distribution from the run shown in the left panel. However, as @fig:convergence shows, these three radius estimates rapidly approached the values they had at the end of the run shown in the left panel, indicating that as the PT-emcee sampling progressed, the posterior distribution converged quickly to the final posterior distribution in the run shown in the left panel.


We note that both our MultiNest and our PT-emcee analyses of only the #emph[NICER] data, and of the #emph[NICER] plus #emph[XMM-Newton] data that were performed using the nominal #emph[XMM-Newton] calibration, assumed a mass prior of $2.11 plus.minus 0.09 ~ M_⊙$, consistent with a preliminary radio-based mass measurement. The posterior function that was sampled to produce the three radius values plotted in the left panel of @fig:convergence was computed assuming this prior. However, the posterior function that was sampled to produce the three radius values plotted in the right panel assumed a different mass prior of $2.08 plus.minus 0.09 ~ M_⊙$, consistent with the current radio-based mass measurement. As a result, the radius values plotted in the right panel of the figure differ by about 1.5% from the radius values plotted in the left panel. The numbers in the tables and figures that summarize the posteriors produced by our analyses of the #emph[NICER]-only and the #emph[NICER] and #emph[XMM-Newton] data assuming the nominal calibration have been re-weighted using the updated mass.


== Effect of Priors
<sec:priors>


#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (center,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Prior], [$- 1 sigma$~(km)], [Median (km)], [$+ 1 sigma$~(km) ],),
    table.hline(),
    [#strong[#emph[NICER]+#emph[XMM-Newton] (featured result)]], [#strong[12.209]], [#strong[13.713]], [#strong[16.326]],
    [#emph[NICER]+#emph[XMM-Newton], $A_(upright("XMM"))$], [12.153], [13.705], [16.298],
    [#emph[NICER]+#emph[XMM-Newton], $theta_(upright("obs"))$=radio], [12.236], [13.750], [16.416],
    [#emph[NICER] only], [10.382], [11.512], [13.380],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Summary of Inferred Radii Using Different Priors]
  , kind: table
  )
<tab:priors>






As summarized in @tab:priors, our posteriors are robust against several different choices of priors. In @tab:priors we compare the $plus.minus 1 sigma$ radii when we analyze the #emph[NICER] and #emph[XMM-Newton] data using our standard priors with the $plus.minus 1 sigma$ radii when we (1)~include a parameter $A_(upright("XMM"))$ that models the relative calibration of #emph[NICER] and #emph[XMM-Newton] (as discussed before, our flat prior $0.9 lt.eq A_(upright("XMM")) lt.eq 1.1$ is broader that the expected uncertainty around $A_(upright("XMM")) = 1$ by a factor $tilde 2$), and (2)~restrict our inclination prior to being flat within $plus.minus 0.5^compose$ of the radio measurement, rather than our standard $plus.minus 5^compose$. In each case the $- 1 sigma$ radius (which has especially important implications for the EOS; see @sec:EOS) is close to our standard value. For comparison we also show in this table the $plus.minus 1 sigma$ radii when we use only the #emph[NICER] data, with no assumed knowledge of the #emph[NICER] background.


== Adequacy of the Models
<sec:adequacy>


// [figvision] imgs/NICER_XMM_chi.png
// The figure is a heatmap showing the value of in each of the 3008 NICER phase-energy bins. The x-axis
// represents phase bins, ranging from 0 to 30, and the y-axis represents energy channels, ranging from 40 to
// 120. The colorbar on the right side indicates the values, ranging from -3 to 3. The heatmap displays a mix of
// colors, with no clear pattern or trend, indicating that the values of are randomly distributed across phase
// bins and energy channels. There are no symbols, line styles, or annotations on the plot, apart from axis
// labels and a title. The message is that there are no evident patterns in the values of as a function of phase
// or energy.
#figure([#block[
  #box(image("imgs/NICER_XMM_chi.png", width: 100%))
  ]
  #block[
  ]],
  caption: [
    The value of $chi$ in each of the 3008 #emph[NICER] phase-energy bins (32~phase bins and 94~energy channels), for the best fit of our energy-resolved waveform model to the #emph[NICER] plus the #emph[XMM-Newton] data. As is expected for a good fit, no patterns in the values of $chi$ are evident as a function of phase or energy. The $chi^2 / upright("dof")$ is 2912.37/2901, which has a probability of 0.437 if the model is correct.
  ]
)
<fig:chi-plot>



#figure([#image("figures/J0740boloresiduals.pdf", width: 69%)],
  caption: [
    Top: Comparison of the 32-phase bolometric waveform constructed using the #emph[NICER] data on PSR~J0740$+$6620 with the bolometric waveform model that best fits the #emph[NICER] plus the #emph[XMM-Newton] data. The dashed blue line shows the unmodulated background that was added to the counts produced by the two hot spots as part of the fitting procedure (see @sec:background). Bottom: The resulting value of $chi$ as a function of phase. The $chi^2 / upright("dof")$ is 21.85/18, which has a probability of 0.239 if the model is correct.
  ]
)
<fig:bolo-waveform-residuals>


// [figvision] imgs/backgrounds.png
// The figure has one panel. The plot shows counts on the y-axis, ranging from 0 to 10^4, and energy channel on
// the x-axis, ranging from 0 to 120. There are three series: a blue line for total NICER counts, a black line
// for J0740 model background, and a pink band for 3C50 ±1σ statistical. The trend shows that the counts decrease
// as the energy channel increases. Above channel 80, the black line and pink band overlap, indicating
// consistency between the inferred background and the 3C50 model. Below channel 80, the black line is above the
// pink band, indicating an excess in the inferred background.
#figure(image("figures/backgrounds.pdf", width: 43%),
  caption: [
    The inferred non-spot counts as a function of #emph[NICER] energy channel in our best model (black line) compared with the $plus.minus 1 sigma$ range of the 3C50 background model (pink band) of Remillard et al. (2021, submitted). For comparison, we also show the total #emph[NICER] counts per channel (blue line). Above channel 80 our inferred background is consistent with the 3C50 model. The excess in our inferred background at lower energies is likely due to the presence of other sources in the #emph[NICER] field, which can be seen in #emph[XMM-Newton] images.
  ],
  placement: top,
)
<fig:backgrounds>



As in #cite(<2019ApJ...887L..24M>, form: "prose"), we performed $chi^2$ tests to assess the adequacy of our models in describing the data. This is a one-way test: if $chi^2 tilde upright("dof")$ for $upright("dof")$ degrees of freedom this does not guarantee that the model is correct, but if $chi^2$ is enough larger than $upright("dof")$ that the probability is very low, it indicates that the model is deficient. We focus on the results of the joint fit to the #emph[NICER] and #emph[XMM-Newton] data using the nominal #emph[XMM-Newton] calibration, given that the #emph[XMM-Newton] data refine the solution substantially and that allowance for a shift in the effective area of #emph[XMM-Newton] does not make a significant difference to the posterior credible regions.


In @fig:chi-plot we show the value of $chi$ over each of the #emph[NICER] phase-channel bins we used in our analysis, for our best fit to the #emph[NICER] plus the #emph[XMM-Newton] data. There are no obvious patterns, and the $chi^2 / upright("dof")$ is 2912.37/2901 for the #emph[NICER] data alone, which has a probability of 0.437 if the model is correct. In #ref(<fig:bolo-waveform-residuals>) we compare to the data our bolometric model waveform for our best fit, and also display the residuals. Here $chi^2 / upright("dof") = 21.85 / 18$ (probability of 0.239) for the #emph[NICER] data alone.


Our final comparison to the #emph[NICER] data is in @fig:backgrounds, which compares the non-spot background in our best model (black line) with the blank-sky #emph[NICER] background inferred using the 3C50 model of Remillard et al. (2021, submitted; see https:\/\/heasarc.gsfc.nasa.gov/docs/nicer/tools/nicer\_bkg\_est\_tools.html). Because the 3C50 model is for a blank sky, i.e., directions where there are no known sources, it should provide a lower limit to the background in the direction of a particular source such as PSR~J0740$+$6620. Indeed, we see that our estimated background counts, while consistent with the 3C50 model at energy channels $approx 80$ and higher, is above the model at lower energy channels. This is likely to be due to particular sources within the #emph[NICER] field of view that can be identified in the #emph[XMM-Newton] image of the field (see #cite(<2021..............W>, form: "prose")).


Our model is therefore a good fit to the #emph[NICER] data.


#figure([#image("figures/XMMchannel.pdf", width: 79%)],
  caption: [
    Comparison of the data from the three #emph[XMM-Newton] cameras (labeled at the top of each plot) with our best #emph[NICER]+#emph[XMM-Newton] model. In each plot the black histogram is the data, the dotted blue line is the blank-sky background scaled to the duration of the observations, and the red line is the best model including the background. In each case the energy channel range is the range we use in our analysis. As described in the text, our model provides a good fit to the data.
  ]
)
<fig:XMMchannel>



In @fig:XMMchannel we compare our best #emph[NICER]+#emph[XMM-Newton] model with the #emph[XMM-Newton] data. Because there are few counts per energy channel, we evaluated the quality of our fit by generating $10^5$ synthetic data sets by performing Poisson draws using our best model (including the blank-sky counts) in every energy channel in all three instruments. We then compared our model to the J0740 data, and placed that in the context of the comparison of our model to the synthetic data sets, in two ways:


- We computed the total log likelihood of all three #emph[XMM-Newton] data sets for PSR~J0740$+$6620 given our model. We also computed the distribution of the total log likelihoods of each synthetic data set given our model. The total log likelihood of the real data is at the 75th percentile of the log likelihoods from the synthetic set (98th percentile for the pn data alone; 17th percentile for the MOS1 data alone; and 12th percentile for the MOS2 data alone).

- We also calculated the Kolmogorov-Smirnov (K-S) probability that the cumulative counts in our model, as a function of the energy channel, are drawn from the same distribution as the PSR~J0740$+$6620 data. We then calculated the distribution of the K-S probabilities for the synthetic data set. We found that K-S probability for the #emph[XMM-Newton] pn data on PSR~J0740$+$6620 is at the 10th percentile of the corresponding probabilities for the synthetic data sets; the K-S probability for the MOS1 data on PSR~J0740$+$6620 is at the 50th percentile; and the K-S probability for the MOS2 data on PSR~J0740$+$6620 is at the 31st percentile.


As a final check, we note that the #emph[XMM-Newton] DDT data have 94 counts in the pn camera in the energy range we investigate, 59 counts in the MOS1 camera, and 67 counts in the MOS2 camera. In our best fit, we have respectively 114.88 counts (1.95 standard deviations high), 49.85 counts (1.30 standard deviations low), and 59.78 counts (0.93 standard deviations low). Neither the total count numbers nor the comparisons with synthetic data indicate a problem. Thus, at least based on these tests, our model is fully consistent with all three #emph[XMM-Newton] data sets.


== Potentially important differences between our analysis and that of #cite(<2021..............R>, form: "prose")
<sec:differences>


The parallel analysis of the #emph[NICER] and #emph[XMM-Newton] data by #cite(<2021..............R>, form: "prose") finds a smaller credible interval for the radius estimate and, most important for the inferred constraints on the EOS, a value for the radius at the $- 1 sigma$ contour that is $approx 0.8$~km smaller than the value we report here. There are a number of differences between their analysis procedure and ours. For example, #cite(<2021..............R>, form: "prose") assume that the inclination of the observer's line of sight to the pulsar's rotational axis is identical to the measured inclination of the observer's line of sight to the orbital axis of the binary system, whereas we allow the inclination of the observer's line of sight to the pulsar's rotational axis to differ by as much as $plus.minus 5^compose$ from the measured inclination of the observer's line of sight to the orbital axis. However, as we have discussed in Section 4.4, this difference between the priors on the inclination of the observer's line of sight to the pulsar's rotational axis used in the two analyses does not produce a significant difference in the value of the radius at the $- 1 sigma$ credibility contour. Another unimportant difference is the ionization fraction of our hydrogen atmospheres: we use tables that allow for the possibility of partial ionization, whereas #cite(<2021..............R>, form: "prose") used atmospheres with fully ionized hydrogen. As we indicate in @sec:modeling-the-emission, we found negligible changes in the radius posteriors when we used fully ionized hydrogen atmospheres.


There appear to be four differences in the analysis procedures used by the two groups that could contribute to the difference of $approx 0.8$~km in the values of the radius at the $- 1 sigma$ credibility contour that the two groups report in their headline results ($R = 12.2$~km at $- 1 sigma$ reported here and $R = 11.4$~km at $- 1 sigma$ reported by #cite(<2021..............R>, form: "prose")):


+ We allow the relative calibration between #emph[NICER] and #emph[XMM-Newton] to deviate by up to $plus.minus 10$% from its nominal value, a deviation that is a factor $tilde 2$ times larger than the measured deviation (again see slide 7 of http:\/\/iachec.org/wp-content/presentations/2020/NICER-CrossCal-IACHEC-Markwardt-2020b.pdf and focus in particular on the energy range $0.3 - 1$~keV that is relevant for the present analysis; here the deviation is $< 4$%). In contrast, #cite(<2021..............R>, form: "prose") allow the relative calibration to deviate by several tens of percent, which is many times larger than the measured deviation. Elsewhere in their paper, #cite(<2021..............R>, form: "prose") show that when they restrict the relative calibration to a range consistent with the measured range, they find $R = 11.75$~km at the $- 1 sigma$ contour. Thus, when they require the relative calibration between #emph[NICER] and #emph[XMM-Newton] to have a value consistent with the measured values, the difference between their value of the radius estimate at the $- 1 sigma$ contour and our value is reduced by almost a factor of two.

+ When estimating the radius of PSR~J0740$+$6620, we allowed $R_(upright("eq")) c^2 / ( G M )$ to be as large as 8.0 (corresponding to $R_(upright("eq")) approx 24.5$~km at $M = 2.08 ~ M_⊙$) and found that the posterior radius probability density is negligible near this boundary. Hence, this choice for the boundary of our search volume did not affect our estimate of the radius of PSR~J0740$+$6620. In contrast, when #cite(<2021..............R>, form: "prose") estimated the radius of PSR~J0740$+$6620, they sampled the radius parameter space only at radius values $< 16$~km. To investigate the results we would have found if we had sampled the radius parameter space only at $R < 16$~km as they did, we required $R < 16$~km in a test analysis and found $R = 12.06$~km, $13.28$~km, and $14.82$~km at the $- 1 sigma$ contour, the median value, and the $+ 1 sigma$ contour. Even when we imposed $R < 16$~km and also allowed the relative calibration factor $A_(upright("XMM"))$ to vary freely in the range $0.9 < A_(upright("XMM")) < 1.1$, a factor $> 2$ deviation larger than its measured value, we found that this had only a very small effect on the position and width of the credible interval of the radius, which changed only slightly to $R = 12.00$~km, $13.28$~km, and $14.80$~km at the $- 1 sigma$ contour, the median value, and the $+ 1 sigma$ contour. Thus, these two differences between our analysis procedure and the analysis procedure used by #cite(<2021..............R>, form: "prose") (the different breadths of the allowed deviation of the relative calibration of the #emph[NICER] and #emph[XMM-Newton] instruments and artificially limiting or not limiting the sampling of the radius parameter volume) account for $approx 0.55$~km of the 0.8~km difference between the value of the radius at the $- 1 sigma$ contour reported by #cite(<2021..............R>, form: "prose") and the value of the radius at the $- 1 sigma$ contour that we found.

+ We used PT-emcee to thoroughly sample the multi-dimensional posterior, using MultiNest only to create an initial rough sample that we then used to speed up the sampling using PT-emcee. In our analysis of synthetic pulse waveform data constructed to mimic the actual #emph[NICER] and #emph[XMM-Newton] data (see @sec:synthetic), we found that when we used only MultiNest, even with values of the MultiNest parameters chosen to try to achieve thorough sampling, the credible regions it generated were too small, i.e., they too often failed to include the values of the pulse waveform parameters that had been used to generate the synthetic pulse waveform data. In contrast, when we used PT-emcee we found credible regions that were consistent with the values of the parameters chosen when generating the synthetic data (see @tab:synth for more details). @fig:convergence shows the detailed evolution of the $- 1 sigma$, median, and $+ 1 sigma$ radii throughout the course of our PT-emcee sampling. #cite(<2021..............R>, form: "prose") used only MultiNest for all of their analyses and found that their posteriors continued to broaden with more thorough sampling for all of the live point numbers that they explored.

+ We treated the distribution of the blank-sky counts in each energy channel as a realization of a Poisson distribution for the observed number of counts. #cite(<2021..............R>, form: "prose") instead assumed a flat prior for the distribution of the blank-sky counts in each energy channel, centered on the flux implied by the observed number of counts with a variety of widths equal to various multiples of the standard deviation of the observed number of counts.


= IMPLICATIONS FOR THE EOS
<sec:EOS>


Our aim is to combine multiple lines of data relevant to the properties of cold, catalyzed, dense matter, using a Bayesian procedure that is both statistically rigorous and computationally practical. In this section we divide our approach into two subtasks: (1)~likelihood computation and parameter estimation for a given EOS family (@sec:statistical), and (2)~different approaches to generating candidate EOS (@sec:models). Finally, we show in @sec:results that with the inclusion of the mass and radius estimates for PSR~J0030$+$0451 and PSR~J0740$+$6620, the constraints on the EOS depend relatively weakly on the EOS parameterization assumed in the analysis, up to a few times nuclear saturation density.


== Statistical Method
<sec:statistical>


There is a growing number of papers on EOS inference from astronomical and/or laboratory data (e.g., #cite(<2015PhRvD..91d3002L>, form: "prose")@2015PhRvD..92b3012A @2016EPJA...52...69A @2017ApJ...850L..19M @PhysRevLett.120.172703 @PhysRevLett.120.261103 @2018ApJ...852L..25R @2018ApJ...852L..29R @2018MNRAS.478.1093R @PhysRevC.98.045804 @2019MNRAS.485.5363G @2019ApJ...876L..31K @2019PhRvD..99h4049L @PhysRevD.100.023015 @2020NatAs...4..625C @2020EPJST.229.3663C @2020Sci...370.1450D @2020PhRvC.102d5807L @2020PhRvC.102e5803E @2020PhRvD.101l3007L @PhysRevResearch.2.033514 @2020ApJ...893L..21R @2020ApJ...893...61Z @2021PhRvC.103c5802X). Here we follow the procedure described in #cite(<2020ApJ...888...12M>, form: "prose"). Their procedure is fast and flexible enough to incorporate multiple types of data.


To elaborate, suppose that we have $i$ different types of measurements, which might include laboratory experiments, or the measurement of a high mass from a pulsar, or the measurement of a tidal deformability, a radius, a moment of inertia, and so on. Suppose also that for measurement type $i$ we have $j = 1 , 2 , dots.h , j ( i )$ independent measurements of that type; these could be different measurements of the same source, or measurements of different sources#footnote[For example, here we present our radius measurements, which are based on X-ray data, using a prior on the mass given by radio observations. This prior, however, is obtained by starting with a flat mass prior and then updating the mass distribution using the radio data. Thus our procedure is equivalent to starting with a flat mass prior and then computing the joint likelihood of the radio and X-ray data given candidate masses and radii.]. We wish to evaluate a set $k$ of EOS; in the next section we discuss the selection of $k$. If the likelihood of data set $( i , j )$ given EOS $k$ is $cal(L)_k ( i , j )$, then the likelihood of all of the data sets given EOS $k$ is simply the product of the likelihoods:


$ cal(L)_k = product_i [product_(j = 1)^(j ( i )) cal(L)_k ( i , j )] #h(0em) . $


Note that in some cases one may need to marginalize over extra parameters. For example, to compute the likelihood of a #emph[NICER] posterior in mass and radius it is necessary to integrate over the prior for the central density, which is not the same for all EOS because different EOS have different maximum stable central densities.


Given the calculation of the likelihood $cal(L)_k$ of the full set of data assuming a specific EOS $k$ (see #cite(<2020ApJ...888...12M>, form: "prose") for more details), then as usual in a Bayesian analysis the posterior probability $P_k$ of the EOS is proportional to the prior probability $q_k$ of the EOS times the likelihood:


$ P_k prop q_k cal(L)_k #h(0em) . $


We could use this procedure to compare individual EOS from the literature. However, our primary goal is to produce a posterior probability distribution for, say, the pressure $P$ as a function of the total energy density $epsilon.alt$ or of the number density $n$ of baryons. To do this, we simply calculate the pressure at specified $epsilon.alt$ or $n$ for each EOS $k$, weight it by $P_k$, and then sum over all $k$ to find the final distribution of $P$ at a given $epsilon.alt$ or $n$.


For each specific EOS selected from a given EOS family we need to compute the likelihood of all relevant data sets for that EOS. We largely follow the procedure of #cite(<2019ApJ...887L..24M>, form: "prose") in our treatment of our data sets. In particular, we apply kernel density estimation (other methods exist, e.g., random forest regressors; see #cite(<PhysRevD.100.103009>, form: "prose")) to produce an estimated continuous probability distribution from our discrete samples. When we do so, we use the standard bandwidth from #cite(<silverman1986>, form: "prose") for our samples in mass and tidal deformability, but multiply this bandwidth by 0.1 for our mass-radius samples because we found previously that the standard bandwidth significantly broadened the radius posterior (see #cite(<2019ApJ...887L..24M>, form: "prose") for more details, and see #cite(<2020PhRvD.101f3007E>, form: "prose") for a more detailed approach to selecting the bandwidth). We modify the procedure of #cite(<2020ApJ...888...12M>, form: "prose") in two ways:


+ In #cite(<2020ApJ...888...12M>, form: "prose") and #cite(<2019ApJ...887L..24M>, form: "prose") the prior on the central density was flat between the density that produces a $1 ~ M_⊙$ star and the density that produces the maximum-mass nonrotating neutron star for the EOS under consideration. Because the central density changes rapidly near the maximum mass, this gives relatively greater prior weight to higher-mass stars. Here our prior on the central density is instead quadratic in the central density between the $1 ~ M_⊙$ density, $rho_(upright("min"))$ and the maximum-mass density $rho_(upright("max"))$. That is, we select uniformly in $0 lt.eq x lt.eq 1$, where the central density is $rho_c = rho_(upright("min")) + x^2 ( rho_(upright("max")) - rho_(upright("min")) )$. This produces a more even prior distribution on the masses. However, we assign zero prior weight to any densities between $rho_(upright("min"))$ and $rho_(upright("max"))$ that produce unstable stars; in this way we explicitly treat EOS that have two stable ranges of central density separated by an unstable range of central density (these are sometimes called “twin stars”), when they arise. In practice, the different prior distribution for the central density does not change the EOS posteriors significantly compared with the approach in #cite(<2019ApJ...887L..24M>, form: "prose").

+ Because we include the high-mass binary merger GW190425 @2020ApJ...892L...3A in our analysis, and the total mass of the binary is high enough that one of the compact objects might have been a black hole, we treat tidal deformabilities differently than in #cite(<2020ApJ...888...12M>, form: "prose") and #cite(<2019ApJ...887L..24M>, form: "prose") (although we also note that the large distance to and high mass of GW190425 mean that it adds only a small amount of information). Our approach is to select the central density of the lower-mass star, up to the central density such that the implied mass of the other star equals that of the lower-mass star. Given the mass of the lower-mass star, and given that the chirp mass (equal to $( m_1 m_2 )^(3 / 5) / ( m_1 + m_2 )^(1 / 5)$ for stellar masses $m_1$ and $m_2$ in a binary) is known with high precision, we know the mass of the higher-mass object to the precision that we know the chirp mass. We marginalize over the chirp mass as in Equation~(15) of #cite(<2020ApJ...888...12M>, form: "prose"). If for the EOS and central density under consideration the higher-mass object is a neutron star, then we compute the tidal deformabilities of both stars, using the same EOS, following the prescription of #cite(<2008ApJ...677.1216H>, form: "prose") (see the erratum at #cite(<2009ApJ...697..964H>, form: "prose")). If instead for the EOS and central density under consideration the higher-mass object is a black hole, then we assume that its tidal deformability is zero @2009PhRvD..80h4018B @2009PhRvD..80h4035D. Note that for rotating black holes the tidal deformability may not be exactly zero (see #cite(<2020arXiv200700214L>, form: "prose")@2020arXiv201007300C @2020arXiv201015795L for an ongoing discussion), but it is small enough that the difference from zero is not important for our calculations.


To implement our analysis, we need a mechanism to select a set of EOS. We now discuss our three different approaches to this selection.


== EOS Models
<sec:models>


There exist many different nuclear physics computations of the EOS of cold, catalyzed matter both below and above nuclear saturation density. It is usually agreed that our understanding of matter below saturation density is fairly good, based on the idea that we can perform laboratory experiments that probe this density regime. One caveat is in order: the matter that can be examined in laboratories has roughly equal numbers of neutrons and protons (the most asymmetric stable nuclei, such as $""^208$Pb, have roughly 50\% more neutrons than protons). In contrast, neutron star matter in the vicinity of saturation density is more than 90\% neutrons. Thus although from the standpoint of density the regime is familiar, theoretical arguments not directly supported by experiment are necessary to extrapolate to very asymmetric matter.


Nonetheless, we will follow standard procedure and assume that we know the EOS up to a threshold density, which we take to be half of saturation density because this is approximately the crust-core transition density @2013ApJ...773...11H. Note that some calculations suggest that different treatments of the crustal EOS could introduce radius uncertainties as large as 0.3~km @2016PhRvC..94c5804F @2020CQGra..37b5008G. Below half of nuclear saturation density we use the QHC19 EOS @2019ApJ...885...42B. Above half of nuclear saturation density, we then need to model the EOS, where there are well motivated and carefully constructed models, but where the models have not been validated by laboratory measurements.


A necessary output of our EOS analysis is an understanding of how strongly our conclusions depend on the type of EOS model that we employ. Therefore, in the rest of this section we discuss the three EOS model families that we use in our analysis. First we present two parameterizations which have been widely used in the literature. We then turn our attention to a newer method using Gaussian processes (GPs) that was introduced in this context by #cite(<2019PhRvD..99h4049L>, form: "prose").


=== Parametric models
<sec:parametric>


The most common approach to EOS inference has used parameterized models. That is, we assume that there is some set of parameters $upright(bold(alpha))$ that completely describe the EOS at high densities. Given priors on $upright(bold(alpha))$, we can generate a large number of sample EOS for which we then compute the likelihood of the assembled data. As discussed above, this allows us to compute posteriors for $P ( epsilon.alt )$ or $P ( n )$. The two parameterizations we use are:


#emph[Piecewise polytrope.]---In this model, above a number density $n = n_s / 2$ the pressure is given by a series of polytropes: $P = K_1 n^(Gamma_1)$ for $n_s / 2 lt.eq n lt.eq n_2$, $P = K_2 n^(Gamma_2)$ for $n_2 lt.eq n lt.eq n_3$, and so on, where the coefficients $K_i$ are chosen to ensure continuity of pressure between density segments. Variants of this model differ in the number of segments, the priors on the polytropic indices $Gamma_i$, and whether the transition densities $n_1 , n_2 , dots.h$ are fixed or can vary. We use the following assumptions (compare with #cite(<2019ApJ...887L..24M>, form: "prose"), which used the same assumptions except for restricting the first polytropic index to the range $[ 2 , 3 ]$): the polytropic index from $n_s / 2$ to $n_2 in [ 3 / 4 , 5 / 4 ] n_s$ is $Gamma_1 in [ 0 , 5 ]$\; from $n_2$ to $n_3 in [ 3 / 2 , 5 / 2 ] n_s$ is $Gamma_2 in [ 0 , 5 ]$\; from $n_3$ to $n_4 in [ 3 , 5 ] n_s$ is $Gamma_3 in [ 0 , 5 ]$\; from $n_4$ to $n_5 in [ 6 , 10 ] n_s$ is $Gamma_4 in [ 0 , 5 ]$\; and from $n_5$ to $oo$ is $Gamma_4 in [ 0 , 5 ]$ (all priors are uniform in the listed range). When $Gamma$ is close to zero, the pressure is nearly independent of the density, which is what one expects near a phase transition and which can produce the twin stars discussed earlier. If at some density below $n_5$ the implied adiabatic sound speed $c_s = (d P / d epsilon.alt)^(1 / 2) > c$, the speed of light, then we set $d P / d epsilon.alt = c^2$ at that density.


#emph[Spectral parameterization.]---A different parameterization was introduced by #cite(<2010PhRvD..82j3011L>, form: "prose") and #cite(<2018PhRvD..97l3019L>, form: "prose"). In this approach, the polytropic index is a continuous function of the pressure, $Gamma ( P )$:


$ Gamma ( P ) = exp (sum_i gamma_i x^i) #h(0em) . $


Here $x equiv log ( P / P_0 )$ and $P_0$ is the pressure at $n_s / 2$. We follow #cite(<2018PhRvD..98f3004C>, form: "prose"), #cite(<2018PhRvL.121p1101A>, form: "prose"), and #cite(<2019ApJ...887L..24M>, form: "prose") in expanding to $O ( x^3 )$, and in using uniform priors $gamma_0 in [ 0.2 , 2 ]$, $gamma_1 in [ - 1.6 , 1.7 ]$, $gamma_2 in [ - 0.6 , 0.6 ]$, and $gamma_3 in [ - 0.02 , 0.02 ]$. As with the piecewise polytrope, if $c_s > c$ at some density then we set $c_s = c$ at that density. Unlike the piecewise polytropic parameterization, the spectral parameterization with these ranges of $gamma_i$ cannot easily simulate a phase transition. However, in other ways it is more flexible, with fewer parameters, than the piecewise polytropic model.


=== Models using Gaussian processes
<sec:Gaussian>


A newer approach to EOS modeling using GPs was introduced in #cite(<2019PhRvD..99h4049L>, form: "prose") (see also the subsequent work in #cite(<2020PhRvD.101f3007E>, form: "prose"), #cite(<2020PhRvD.101l3007L>, form: "prose"), and #cite(<2020PhRvC.102e5803E>, form: "prose")). Because this method is currently less commonly used in the community than the parametric approach, we will summarize it in more detail.


The essence of GP estimation of a function $f$ (see #cite(<2006gpml.book.....R>, form: "prose") for an excellent introduction) is that we would like to have the outcome of our analysis be the joint probability density for the function values $f ( arrow(x) )$ at inputs $arrow(x)$ (which we can represent as $x_i$), which we assume to be a multivariate Gaussian distribution with means $arrow(mu) = mu_i$ and covariance matrix $Sigma = Sigma_(i j)$. That is, we would ultimately like to obtain


$ f ( arrow(x) ) tilde cal(N) ( arrow(mu) , Sigma ) #h(0em) , $


where $cal(N)$ indicates a normal distribution.


A key assumption made in GP estimation is that correlations between the function values $f_i$, $f_i$ at inputs $x_i$, $x_j$ can be represented using a covariance kernel $K$ that is a function of $x_i$ and $x_j$. That is, if our joint distribution is


$ f_i | x_i tilde cal(N) ( chevron.l f_i chevron.r , Sigma ( f_i , f_j ) ) #h(0em) , $


where $chevron.l f_i chevron.r$ is the expectation value for $f$ at $x_i$ and $Sigma ( f_i , f_j )$ is the covariance matrix, then we assume we can write $Sigma ( f_i , f_j ) = K ( x_i , x_j )$.


It is reasonable to assume that when $x_i$ and $x_j$ are closer to each other, $K$ is larger. Given that covariance matrices are symmetric, it also must be that $K ( x_i , x_j ) = K ( x_j , x_i )$ for any $x_i$ and $x_j$. A common and much more drastic simplification is to assume that $K$ depends on only the distance between the points: $K ( x_i , x_j ) = K ( | x_i - x_j | )$. We use a Gaussian kernel, which in this context is called a “squared-exponential kernel”:


$ K_(upright("se")) ( x , x' ) = sigma^2 exp (- frac(( x - x' )^2, 2 ell^2)) #h(0em) , $<eq:kernel>


which has the properties listed above. Here the hyperparameter $sigma$ determines the strength of the overall correlation and the hyperparameter $ell$ gives the correlation length scale. For example, $ell arrow.r 0$ would mean that all of the points are independent of each other, and $sigma arrow.r 0$ would mean that there is negligible variance.


#emph[Transformation of dependent variable.]---There is one additional important qualitative aspect of the analysis of EOS using GPs. A true Gaussian has a domain of $- oo$ to $+ oo$. However, if we think about an equation of state as $epsilon.alt ( P )$, then because $epsilon.alt$ is nonnegative it cannot range from $- oo$ to $+ oo$. We could instead use $log ( epsilon.alt )$ as a function of $log ( P )$, because if we express $epsilon.alt$ in some units, e.g., cgs units, $log ( epsilon.alt )$ can range from $- oo$ to $+ oo$. However, this approach is also sub-optimal because it could lead to unstable ($d p / d epsilon.alt < 0$) or acausal ($d p / d epsilon.alt > c^2$) EOS. In principle one could simply discard such EOS when they are drawn from the GP, but this would be inefficient.


Therefore, we follow #cite(<2010PhRvD..82j3011L>, form: "prose") and #cite(<2019PhRvD..99h4049L>, form: "prose") in defining a new variable:


$ phi.alt equiv ln (c^2 frac(d epsilon.alt, d P) - 1) #h(0em) . $


Because the adiabatic speed of sound $c_s$ is given by $c_s^2 = d P / d epsilon.alt$, at the boundary of thermodynamic stability ($c_s^2 arrow.r 0$), $phi.alt arrow.r + oo$, and at the boundary of causality ($c_s^2 arrow.r c^2$), $phi.alt arrow.r - oo$. Thus if we construct a GP in $phi.alt ( log P )$, all values of $phi.alt$ correspond to stable and causal EOS.


The next choice we need to make is how closely we wish to follow tabulated EOS in our function $phi.alt ( log P )$. #cite(<2019PhRvD..99h4049L>, form: "prose") define two approximate limits: the “model-informed” EOS prior, in which the GP is strongly conditioned on a set of EOS proposed in the literature, and the “model-agnostic” EOS prior, in which the GP is only loosely related to existing EOS proposals. The model-agnostic approach is much less computationally demanding and is less biased by existing EOS, so it is the path that we follow.


We then need to choose the parameters that describe our GP. #cite(<2019PhRvD..99h4049L>, form: "prose") note that it is advantageous to look for approximate trends in the function we wish to model (here $phi.alt ( log P )$) and then to produce a GP for the residuals. We find from sets of tabulated EOS (e.g., those at the CompOSE website https:\/\/compose.obspm.fr/table/families/3/) that in the log pressure range of interest ($log_10 P ( upright("erg") thin upright("med") thin upright("cm")^(- 3) ) tilde 32 - 36$) the trend is roughly linear. We use $phi.alt_0 = 5.5 - 2.0 ( log_10 P - 32.7 )$ as our approximate trend, but construction of the GP does not require an exact fit. For our kernel, we use the squared-exponential kernel of @eq:kernel and, based on the spread between the EOS above in the $log_10 P ( upright("erg") thin upright("med") thin upright("cm")^(- 3) ) tilde 32 - 36$ range, we choose $sigma = 1$ and $ell = 1$.


We note that the Gaussian process framework allows for substantial flexibility beyond our particular choice (see, e.g., #cite(<2020PhRvD.101f3007E>, form: "prose")). For example, although $sigma = 1$ and $ell = 1$ matches well most existing EOS in the density range that has a discernible impact on the maximum mass, radius, and tidal deformability of neutron stars, when combined with our $phi.alt_0 = 5.5 - 2.0 ( log_10 P - 32.7 )$ trend it leads to sound speeds approaching the speed of light at densities several times nuclear saturation density. A different choice of hyperparameters, e.g., a larger $sigma$, would not necessarily require such high sound speeds; see for example Figure~2 of #cite(<2020PhRvD.101l3007L>, form: "prose").


~


== EOS results
<sec:results>


#figure([#image("figures/EOSallfullprior.pdf", width: 82.5%)],
  caption: [
    Comparison of the pressure ranges as a function of number density for the three EOS models described in the text, as a function of the data sets included in the analysis. For each line type and color in each panel, the lower line shows the 5th percentile, and the upper line shows the 95th percentile, of the pressure as a function of density. Colors indicate the EOS model used in the analysis: black for a piecewise polytrope (see the first part of @sec:parametric), blue for the spectral model (see the second part of @sec:parametric), and red for a model based on Gaussian processes (see @sec:Gaussian). We show the results for our priors (dotted lines in each panel); our priors plus symmetry energy measurements, the existence of three high-mass pulsars, and two tidal deformability upper limits (dash-dotted lines in each panel); those plus the mass-radius posteriors on PSR~J0030$+$0451 from #cite(<2019ApJ...887L..24M>, form: "prose") (dashed lines in each panel); and finally all of those plus the mass-radius measurement of PSR~J0740$+$6620 that we report here (solid lines in each panel). The lower right panel shows the full set of constraints, including our PSR~J0740$+$6620 radius measurement, for each of our three EOS families. Inclusion of the masses and radii of PSR~J0030$+$0451 and PSR~J0740$+$6620 tightens significantly the EOS models in the vicinity of $n / n_s tilde 1.5 - 3$ \[$log_10 ( n / n_s ) tilde 0.2$--0.5\]. This indicates that with the #emph[NICER] and #emph[XMM-Newton] data added, in this density range the posterior is now dominated by the data rather than by the priors.
  ]
)
<fig:EOSall>



#figure([#image("figures/muall.pdf", width: 85%)],
  caption: [
    The 5th to 95th percentile range of the pressure as a function of the baryon chemical potential, including the neutron rest mass-energy, for all three of our models of the EOS: the red line is for the Gaussian process EOS, the blue line is for the spectral EOS, and the black line is for the piecewise polytropic EOS. Here we include all measurements: symmetry energy, high-mass pulsars, tidal deformability from gravitational wave measurements, and measurements of the mass and radius of PSR~J0030$+$0451 and PSR~J0740$+$6620.
  ]
)
<fig:mu>



#figure([#image("figures/EOS-MR.pdf", width: 80%)],
  caption: [
    The 25th to 75th percentile range (blue shading) and the 5th to 95th percentile range (pink shading) of the radius as a function of mass, for nonrotating neutron stars. The faint lines show the mass-radius relations of representative individual EOS (see text for details). At each mass only EOS that can reach that mass contribute to the radius posterior; thus at high masses, which require hard EOS, the radii become larger. We use the Gaussian process EOS model for the same progression of measurements as in @fig:EOSall, where $S$ is the symmetry energy, $M$ refers to the high masses of three pulsars, and $Lambda$ indicates the gravitational wave measurements of tidal deformability for GW170817 and GW190425. In each panel, we only include masses below the 95th percentile of the maximum mass for nonrotating neutron stars (see @fig:Mmax for a closer investigation of the maximum mass). See @tab:mmaxrad for details of how our radius bounds change between EOS models and when including different observations. The agreement between the methods, particularly at the $plus.minus 1 sigma$ level, is another indication of improving convergence between models.
  ]
)
<fig:RM>



#figure([#image("figures/Mmax.pdf", width: 86.6%)],
  caption: [
    The posterior probability distribution for the maximum gravitational mass of a nonrotating neutron star, normalized in each case so that the integral of the probability density in the $M_(upright("max")) = 1.8 - 3.0 ~ M_⊙$ range is 1. The highest maximum mass allowed in our analysis was $3.0 ~ M_⊙$. We use the Gaussian process model for the same progression of measurements as in @fig:EOSall, where $S$ is the symmetry energy, $M$ refers to the high masses of three pulsars, and $Lambda$ indicates the gravitational wave measurements of tidal deformability for GW170817 and GW190425. See @tab:mmaxrad for details of how our maximum mass bounds change between EOS models and when including different observations.
  ]
)
<fig:Mmax>



#figure(
  align(center)[
    #text(size: 8pt)[#table(
      columns: 11,
      align: center,
      stroke: (x: none, y: 0.4pt),
      inset: (x: 3pt, y: 2pt),
      table.header(
        [EOS Model], [Measurements],
        table.cell(colspan: 3)[$M_"max" ~ (M_⊙)$],
        table.cell(colspan: 3)[$R_e (1.4 ~ M_⊙)$, km],
        table.cell(colspan: 3)[$R_e (2.08 ~ M_⊙)$, km],
      ),
      table.hline(),
      [], [], [$-1 sigma$], [Median], [$+1 sigma$], [$-1 sigma$], [Median], [$+1 sigma$], [$-1 sigma$], [Median], [$+1 sigma$],
      [Gaussian], [$S, M, Lambda$], [2.12], [2.27], [2.52], [10.92], [12.23], [12.93], [10.80], [11.97], [12.86],
      [], [+J0030], [2.13], [2.30], [2.54], [11.88], [12.51], [13.02], [11.39], [12.27], [12.95],
      [], [+J0740], [2.08], [2.23], [2.47], [12.17], [12.63], [13.11], [11.60], [12.28], [12.88],
      table.hline(),
      [Spectral], [$S, M, Lambda$], [2.28], [2.55], [2.88], [10.41], [11.43], [12.40], [10.79], [11.81], [12.97],
      [], [+J0030], [2.39], [2.78], [2.93], [11.52], [12.22], [12.67], [11.56], [12.77], [13.11],
      [], [+J0740], [2.23], [2.74], [2.92], [11.79], [12.30], [12.84], [11.83], [12.78], [13.11],
      table.hline(),
      [Piecewise], [$S, M, Lambda$], [2.13], [2.37], [2.64], [11.26], [12.32], [12.89], [11.04], [12.21], [12.90],
      [Polytrope], [+J0030], [2.14], [2.41], [2.65], [11.95], [12.47], [12.94], [11.42], [12.35], [12.94],
      [], [+J0740], [2.09], [2.27], [2.61], [12.16], [12.56], [13.01], [11.67], [12.36], [12.91],
      table.hline(),
    )]
    #v(4pt)
    #text(size: 8pt)[Maximum gravitational masses and equatorial circumferential radii at $M = 1.4 ~ M_⊙$ and $M = 2.08 ~ M_⊙$ (the best estimate of the mass of PSR~J0740$+$6620), all at $plus.minus 1 sigma$ for nonrotating stars, inferred using our three EOS frameworks with three different sets of measurements. The $S, M, Lambda$ set includes constraints on the symmetry energy, the high masses of three pulsars, and the two LIGO/Virgo tidal deformability measurements. The +J0030 set also includes the #cite(<2019ApJ...887L..24M>, form: "prose") measurement of the radius and mass of PSR~J0030$+$0451. The +J0740 data adds our measurement of the radius of PSR~J0740$+$6620. We see that the radius estimates tighten with addition of more data, and in particular that the final $plus.minus 1 sigma$ radius range for a $2.08 ~ M_⊙$ star, spanning all three EOS frameworks ($11.60 - 13.11$~km), is very similar to the final $plus.minus 1 sigma$ radius range for a $1.4 ~ M_⊙$ star, spanning all three EOS frameworks ($11.79 - 13.11$~km).]
  ],
  caption: [Summary of Maximum Mass and Radii at $1.4 ~ M_⊙$ and $2.08 ~ M_⊙$],
  kind: table,
) <tab:mmaxrad>





The constraints we obtain on the EOS at different densities depend both on the EOS model and priors and on the data sets that we include. Here we present the EOS constraints for each of our three models, with progressive incorporation of more data. We also plot the distributions of mass versus radius and the maximum mass for nonrotating neutron stars for different amounts of data and using the Gaussian process model. For a given EOS and central density, we solve the Tolman-Oppenheimer-Volkoff equation @1939PhRv...55..374O @1939PhRv...55..364T to obtain the mass and radius. Thus for the purpose of calculating stellar structure we implicitly treat the star as nonrotating. This is an excellent approximation at the 346.53~Hz rotation frequency of this pulsar @2020NatAs...4...72C, because this is only $tilde 20 "%"$ of the mass-shedding frequency and thus the expected deviation from the structure of a nonrotating star is much smaller than our measurement precision (e.g., see Figure~13 of #cite(<2019ApJ...887L..24M>, form: "prose")\; at this mass and rotation frequency, the radius increase is at most 0.2~km compared with a nonrotating star).


In @fig:EOSall we show, for each EOS model, the middle 90% range for the pressure as a function of number density when we incorporate successively more constraining measurements. The upper left hand panel shows the results using the piecewise polytropic model, the upper right hand panel shows the results using the spectral model, and the lower left hand panel shows the results using the GP model. Our first constraints (dotted lines) use only the prior for each EOS model. The next constraints include a Gaussian prior of $S = 32 plus.minus 2$~MeV for the symmetry energy at nuclear saturation density (see #cite(<2012PhRvC..86a5803T>, form: "prose")\; note that the symmetry energy is the difference between the total energy per nucleon of pure neutron matter, which is close to $epsilon.alt / n$ because our matter is close to pure neutrons, and the energy per nucleon of symmetric nuclear matter), the existence of three high-mass pulsars @2018ApJ...859...47A @2013Sci...340..448A @2020NatAs...4...72C, and the tidal deformability posteriors from gravitational wave observations of GW170817 @2017PhRvL.119p1101A @2018PhRvL.121p1101A @2018PhRvL.121i1102D and GW190425 @2020ApJ...892L...3A. Other constraints on the symmetry energy are possible; for example, #cite(<2020PhRvL.125t2702D>, form: "prose") find a tighter range for the symmetry energy of $S = 31.7 plus.minus 1.1$~MeV and analyses of PREX-II data @2021arXiv210210767A @2021arXiv210103193R @2021arXiv210205267Y suggest a significantly higher symmetry energy of $S approx 38 plus.minus 4$~MeV. The third set of constraints also include the mass-radius posteriors from the #cite(<2019ApJ...887L..24M>, form: "prose") analysis of #emph[NICER] data on PSR~J0030$+$0451. Finally, the last set of constraints also includes our mass-radius posteriors for PSR~J0740$+$6620. The bottom right panel collects the final set of constraints for all three EOS models. In each case, we only display the results for our fit to both the #emph[NICER] and the #emph[XMM-Newton] data using the nominal #emph[XMM-Newton] calibration. When we include our mass-radius posteriors for PSR~J0740$+$6620, we use only the masses of PSR~1614--2230 and PSR~J0348$+$0432 in our high-pulsar-mass data, i.e., we do not double-count the high mass of PSR~J0740$+$6620.


Several trends are evident in this figure:


+ The 5%-95% pressure range at densities $n approx (1.5 - 3) n_s$, after incorporation of all measurements, depends relatively weakly on the EOS model. This is encouraging, because it means that for this density range the posterior is now dominated by the data rather than by the priors.

+ This convergence of constraints requires the #emph[NICER] data on PSR~J0030$+$0451 and the #emph[NICER] and #emph[XMM-Newton] data on PSR~J0740$+$6620. Without these data, the pressure ranges differ significantly among the three models.

+ As expected, there is much less convergence at higher densities ($> 5n_s$) and at lower densities ($< 1.5n_s$). This is because low and high densities contribute less to the radius, mass, or tidal deformability of neutron stars. See #cite(<2007PhR...442..109L>, form: "prose")@2016PhR...621..127L @2020arXiv200906441D @2020ApJ...899....4X for the detailed theoretical context.

+ Finally, we note that the constraining power of our measurement of PSR~J0740$+$6620 comes entirely from the strong lower limit on its radius. Other measurements, particularly the nondetection of tidal deformability from GW170817, already strongly exclude radii as large as even our $+ 1 sigma$ value of $> 16$~km. However, the evidence that the radius is $> 12$~km at $1 sigma$, and $> 11$~km at $2 sigma$, adds significantly to our understanding of dense matter.


In @fig:mu we present another view of the equation of state, after all measurements are incorporated. Here we show the pressure versus the baryon chemical potential $mu = ( epsilon.alt + P ) / n$ (including the baryon rest mass-energy) for all three of our EOS models.


In @fig:RM we present the 5th to 95th percentile range, and the 25th to 75th percentile range, of the radius as a function of mass, using our Gaussian process model, for the same set of measurements as in @fig:EOSall. In this figure we also plot (faint lines) representative mass-radius relations drawn from our set of EOS, where in each panel the probability of drawing an individual EOS is proportional to its statistical weight given the measurements considered in that panel. Here we only plot masses below the 95th percentile of the maximum gravitational mass of a nonrotating neutron star, given the measurements being considered. The radius and mass of PSR~J0030$+$0451, and our current measurement of the radius of PSR~J0740$+$6620, tighten the allowed radius significantly at all neutron star masses greater than $1.0 ~ M_⊙$. See @tab:mmaxrad for details. In particular, the $plus.minus 1 sigma$ radius range at $M = 1.4 ~ M_⊙$, spanning all three EOS frameworks, is just $11.79 - 13.11$~km, or $plus.minus 5.3$%. In addition, although the direction measurement that we report of the radius of PSR~J0740$+$6620 has a $plus.minus 1 sigma$ range of $approx 12.2 - 16.3$~km, when we include other measurements the $plus.minus 1 sigma$ range, spanning all three EOS frameworks, narrows to $11.60 - 13.11$~km at $M = 2.08 ~ M_⊙$. This is dramatically improved compared with the prior $plus.minus 1 sigma$ range of $10.47 - 14.27$~km over all of our EOS frameworks.


In @fig:Mmax we see that the maximum mass range shifts slightly when we include our radius measurement of PSR~J0740$+$6620; see @tab:mmaxrad for details. The maximum mass range still depends on the EOS model. However, consider for context the lighter object in the gravitational wave coalescence GW190814, which has a best mass estimate of $2.59 ~ M_⊙$ @2020ApJ...896L..44A. Using our Gaussian process EOS model, without our PSR~J0740$+$6620 measurement, there is a 12.1% probability that this object is a slowly rotating neutron star. With our PSR~J0740$+$6620 measurement, the probability drops to 7.5%.


= CONCLUSIONS
<sec:conclusions>


#emph[NICER] measurements of PSR~J0030$+$0451 and PSR~J0740$+$6620, complemented with #emph[XMM-Newton] measurements of PSR~J0740$+$6620, have reduced the uncertainty about the EOS of high-density, cold catalyzed matter. This is especially true in the density range $n tilde 1.5 - 3 n_s$. These two radius measurements also shift slightly the credible region for the maximum gravitational mass of a nonrotating neutron star.


Most importantly, our new measurement narrows significantly the inferred radius range for $1.4 ~ M_⊙$ neutron stars. For instance, prior to our measurement, when we used our Gaussian process EOS model, inclusion of nuclear data, information about neutron star tidal deformability from the gravitational wave event GW170817, and our previous mass and radius measurement of PSR~J0030$+$0451 had constrained the radius to $11.2 - 13.3$~km at 90% credibility and $11.9 - 13.0$~km at 68% credibility. When we also include our PSR~J0740$+$6620 measurement, these ranges shrink to $11.8 - 13.4$~km (90%) and $12.2 - 13.1$~km (68%). That is, as expected, the main effect of our PSR~J0740$+$6620 measurement is to increase the lower limit to the radius. Indeed, even when we consider the radius range spanned by all three of our EOS models, the range is $11.8 - 13.1$~km at 68% credibility, for a fractional uncertainty of $plus.minus 5.3$%. This is broadly consistent with previous radius estimates based both on nuclear theory and tidal deformabilities inferred from gravitational wave observations @2017PhRvL.119p1101A @2018PhRvL.121i1102D @2020ApJ...892L...3A and on the #emph[NICER] mass and radius estimates for PSR~J0030$+$0451 @2019ApJ...887L..24M #cite(<2019ApJ...887L..21R>): the total radius range spanned by all the computed $plus.minus 1 sigma$ radius bounds, prior to our measurement of the radius of PSR~J0740$+$6620, for $1.4 ~ M_⊙$ neutron stars is $approx 11 - 13.5$~km (e.g., #cite(<2020EPJST.229.3615A>, form: "prose")@2020Sci...370.1450D @2020PhRvC.102e5803E @2020ApJ...901..155G @2020ApJ...892...55J @2020arXiv200912571L @2020PhRvD.102b3021Z @2021arXiv210305408H @2021arXiv210315119L @2021Symm...13..144S @2021arXiv210406141S).


Data are still being taken actively; for example, it is likely that by the end of the #emph[NICER] mission the exposure times on PSR~J0030$+$0451 and PSR~J0740$+$6620 will roughly double compared with the times used in current analyses, and an analysis of #emph[NICER] data on PSR~J0437$-$4715 (which has the highest X-ray flux of any non-accreting neutron star) is in progress. This gives reason for optimism that future #emph[NICER] observations, and in the coming years more gravitational-wave observations of tidal deformability, will provide even clearer insight into a realm of matter which cannot be explored in laboratories.





This work was supported by NASA through the #emph[NICER] mission and the Astrophysics Explorers Program. The authors acknowledge the University of Maryland supercomputing resources (http:\/\/hpcc.umd.edu) that were made available for conducting the research reported in this paper. The authors also thank Felix Fuerst for facilitating the #emph[XMM-Newton] director's discretionary time observations of PSR~J0740+6620, and Brad Cenko for early #emph[Swift] observations. MCM thanks the Radboud Excellence Initiative for supporting his stay at Radboud University, and thanks Gordon Baym, Cecilia Chirenti, and Sanjay Reddy for comments on an earlier version of this manuscript. WCGH appreciates use of computer facilities at the Kavli Institute for Particle Astrophysics and Cosmology and acknowledges support through grant 80NSSC20K0278 from NASA. TTP is a NANOGrav Physics Frontiers Center Postdoctoral Fellow funded by the National Science Foundation award number 1430284. IHS is supported by an NSERC Discovery Grant and by the Canadian Institute for Advanced Research. Support for HTC was provided by NASA through the NASA Hubble Fellowship Program grant \#HST-HF2-51453.001 awarded by the Space Telescope Science Institute, which is operated by the Association of Universities for Research in Astronomy, Inc., for NASA, under contract NAS5-26555. SMM thanks the Natural Sciences and Engineering Research Council of Canada for funding. Portions of this work performed at NRL were funded by NASA. The authors acknowledge the use of NASA's Astrophysics Data System (ADS) Bibliographic Services and the arXiv.











= POSTERIOR DISTRIBUTIONS FROM ANALYSIS OF SYNTHETIC J0740-LIKE #emph[NICER] AND #emph[XMM-Newton] DATA
<sec:corner-plot-Synthetic>


#figure([#table(
    stroke: none,
    columns: 7,
    align: (center,right,right,right,right,right,right,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [Median], [$- 1 sigma$], [$+ 1 sigma$], [$- 2 sigma$], [$+ 2 sigma$], [Assumed value ],),
    table.hline(),
    [$R_e$ (km)], [13.933], [12.344], [17.396], [11.342], [22.215], [13.378],
    [$G M / c^2 R_e$], [0.221], [0.177], [0.248], [0.139], [0.267], [0.230],
    [$M ~ ( M_⊙$)], [2.081], [1.991], [2.174], [1.895], [2.261], [2.080],
    [$theta_(upright("c1"))$ (rad)], [1.618], [0.892], [2.341], [0.583], [2.602], [1.820],
    [$Delta theta_1$ (rad)], [0.121], [0.078], [0.180], [0.051], [0.259], [0.061],
    [$k T_(upright("eff"), upright(1))$ (keV)], [0.085], [0.076], [0.097], [0.068], [0.111], [0.107],
    [$theta_(upright("c2"))$ (rad)], [1.574], [0.881], [2.313], [0.586], [2.604], [2.280],
    [$Delta theta_2$ (rad)], [0.121], [0.078], [0.179], [0.050], [0.262], [0.086],
    [$k T_(upright("eff"), upright(2))$ (keV)], [0.085], [0.076], [0.097], [0.068], [0.111], [0.100],
    [$Delta phi.alt_2$ (cycles)], [0.554], [0.422], [0.578], [0.409], [0.592], [0.422],
    [$theta_(upright("obs"))$ (rad)], [1.526], [1.467], [1.585], [1.444], [1.610], [1.463],
    [$N_H ~ ( 10^20 ~ upright("cm")^(- 2)$)], [3.067], [1.377], [4.389], [0.302], [4.915], [0.226],
    [$d$ (kpc)], [1.211], [1.025], [1.400], [0.840], [1.598], [1.099],
    table.hline(stroke: 0.8pt),
  )], caption: [Fits to synthetic #emph[NICER] and #emph[XMM-Newton] data]
  , kind: table
  )
<tab:crediblesynthetic>












#figure([#image("figures/syntheticMarg.pdf", width: 100%)],
  caption: [
    Posterior probability density distributions for a model with two, uniform, circular spots that is fit jointly to the synthetic #emph[NICER] and #emph[XMM-Newton] data. The dotted lines in the one-dimensional plots for gravitational mass and distance indicate the priors that we applied. The vertical dashed lines in the one-dimensional plots indicate the value of the associated parameter that was assumed in the construction of the synthetic data. Similarly, the star symbols in the two-dimensional plots show the assumed values of both parameters. In this and the other corner plots in the appendices, brighter colors in the two-dimensional plots indicate higher posterior probability densities.
  ]
)
<fig:full-posteriors-for-synthetic>






= POSTERIOR DISTRIBUTIONS FROM ANALYSIS OF ONLY #emph[NICER] DATA
<sec:corner-plot-NICERonly>


#figure(
  align(center)[#table(
    stroke: none,
    columns: 7,
    align: (center,right,right,right,right,right,right,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [Median], [$- 1 sigma$], [$+ 1 sigma$], [$- 2 sigma$], [$+ 2 sigma$], [Best fit ],),
    table.hline(),
    [$R_e$ (km)], [11.512], [10.382], [13.380], [9.642], [16.256], [11.008],
    [$G M / c^2 R_e$], [0.266], [0.229], [0.293], [0.188], [0.308], [0.278],
    [$M ~ ( M_⊙$)], [2.072], [1.978], [2.159], [1.885], [2.247], [2.071],
    [$theta_(upright("c1"))$ (rad)], [1.655], [0.667], [2.541], [0.292], [2.858], [0.494],
    [$Delta theta_1$ (rad)], [0.329], [0.205], [0.541], [0.132], [0.899], [0.328],
    [$k T_(upright("eff"), upright(1))$ (keV)], [0.072], [0.064], [0.079], [0.057], [0.087], [0.078],
    [$theta_(upright("c2"))$ (rad)], [1.582], [0.641], [2.510], [0.310], [2.847], [1.803],
    [$Delta theta_2$ (rad)], [0.326], [0.204], [0.539], [0.132], [0.854], [0.208],
    [$k T_(upright("eff"), upright(2))$ (keV)], [0.072], [0.064], [0.079], [0.057], [0.087], [0.079],
    [$Delta phi.alt_2$ (cycles)], [0.527], [0.441], [0.560], [0.422], [0.578], [0.550],
    [$theta_(upright("obs"))$ (rad)], [1.528], [1.468], [1.586], [1.444], [1.610], [1.535],
    [$N_H ~ ( 10^20 ~ upright("cm")^(- 2)$)], [1.833], [0.599], [3.414], [0.094], [4.667], [0.858],
    [$d$ (kpc)], [1.213], [1.025], [1.407], [0.843], [1.596], [1.086],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Fits to only #emph[NICER] data]
  , kind: table
  )
<tab:credibleNICERonly>









#figure([#image("figures/J0740_noXMM_all.pdf", width: 100%)],
  caption: [
    Posterior probability density distributions for a model with two, uniform, circular spots that is fit to only the #emph[NICER] data. Note that because the spots do not overlap with each other, their roles can be swapped. Moreover, because the observer inclination is close to the equator, there is a near-degeneracy between spots in the northern hemisphere and spots in the southern hemisphere. The dotted lines in the one-dimensional plots for gravitational mass and distance indicate the priors that we applied.
  ]
)
<fig:full-posteriors-for-NICER-only>






= POSTERIOR DISTRIBUTIONS FROM ANALYSIS OF #emph[NICER] AND #emph[XMM-Newton] DATA
<sec:corner-plot-NICERXMM>


#figure([#table(
    stroke: none,
    columns: 7,
    align: (center,right,right,right,right,right,right,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [Median], [$- 1 sigma$], [$+ 1 sigma$], [$- 2 sigma$], [$+ 2 sigma$], [Best fit ],),
    table.hline(),
    [$R_e$ (km)], [13.713], [12.209], [16.326], [11.243], [20.051], [13.823],
    [$G M / c^2 R_e$], [0.222], [0.187], [0.249], [0.151], [0.267], [0.221],
    [$M ~ ( M_⊙$)], [2.062], [1.971], [2.152], [1.883], [2.242], [2.067],
    [$theta_(upright("c1"))$ (rad)], [1.600], [0.900], [2.319], [0.586], [2.631], [0.834],
    [$Delta theta_1$ (rad)], [0.098], [0.065], [0.145], [0.044], [0.219], [0.087],
    [$k T_(upright("eff"), upright(1))$ (keV)], [0.094], [0.083], [0.105], [0.073], [0.118], [0.098],
    [$theta_(upright("c2"))$ (rad)], [1.612], [0.917], [2.297], [0.572], [2.618], [1.223],
    [$Delta theta_2$ (rad)], [0.096], [0.064], [0.143], [0.042], [0.213], [0.066],
    [$k T_(upright("eff"), upright(2))$ (keV)], [0.094], [0.083], [0.106], [0.073], [0.120], [0.103],
    [$Delta phi.alt_2$ (cycles)], [0.558], [0.422], [0.579], [0.409], [0.592], [0.577],
    [$theta_(upright("obs"))$ (rad)], [1.527], [1.467], [1.586], [1.444], [1.610], [1.561],
    [$N_H ~ ( 10^20 ~ upright("cm")^(- 2)$)], [1.137], [0.315], [2.549], [0.043], [4.174], [0.006],
    [$d$ (kpc)], [1.215], [1.027], [1.404], [0.852], [1.593], [1.151],
    table.hline(stroke: 0.8pt),
  )], caption: [Fits to #emph[NICER] and #emph[XMM-Newton] data]
  , kind: table
  )
<tab:credibleNICERXMM>












#figure([#image("figures/J0740_NICER+XMM_all.pdf", width: 100%)],
  caption: [
    Posterior probability density distributions for a model with two, uniform, circular spots that is fit to the #emph[NICER] and #emph[XMM-Newton] data. The dotted lines in the one-dimensional plots for gravitational mass and distance indicate the priors that we applied.
  ]
)
<fig:full-posteriors-for-NICER-and-XMM>






= POSTERIOR DISTRIBUTIONS FROM ANALYSIS OF #emph[NICER] AND #emph[XMM-Newton] DATA WITH AN #emph[XMM-Newton] CALIBRATION PARAMETER
<sec:corner-plot-NICERXMMcalib>


#figure([#table(
    stroke: none,
    columns: 7,
    align: (center,right,right,right,right,right,right,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [Median], [$- 1 sigma$], [$+ 1 sigma$], [$- 2 sigma$], [$+ 2 sigma$], [Best fit ],),
    table.hline(),
    [$R_e$ (km)], [13.705], [12.153], [16.298], [11.140], [20.199], [13.524],
    [$G M / c^2 R_e$], [0.223], [0.187], [0.250], [0.151], [0.270], [0.227],
    [$M ~ ( M_⊙$)], [2.064], [1.973], [2.154], [1.882], [2.244], [2.082],
    [$theta_(upright("c1"))$ (rad)], [1.635], [0.895], [2.324], [0.575], [2.634], [2.399],
    [$Delta theta_1$ (rad)], [0.097], [0.064], [0.144], [0.042], [0.214], [0.106],
    [$k T_(upright("eff"), upright(1))$ (keV)], [0.095], [0.084], [0.107], [0.074], [0.120], [0.098],
    [$theta_(upright("c2"))$ (rad)], [1.647], [0.910], [2.327], [0.573], [2.632], [1.876],
    [$Delta theta_2$ (rad)], [0.097], [0.065], [0.143], [0.044], [0.212], [0.076],
    [$k T_(upright("eff"), upright(2))$ (keV)], [0.095], [0.084], [0.106], [0.074], [0.119], [0.102],
    [$Delta phi.alt_2$ (cycles)], [0.551], [0.422], [0.578], [0.409], [0.591], [0.571],
    [$theta_(upright("obs"))$ (rad)], [1.525], [1.467], [1.586], [1.444], [1.610], [1.536],
    [$N_H ~ ( 10^20 ~ upright("cm")^(- 2)$)], [1.081], [0.293], [2.489], [0.040], [4.116], [0.033],
    [$d$ (kpc)], [1.209], [1.023], [1.403], [0.845], [1.599], [1.206],
    [$A_(upright("XMM"))$], [0.969], [0.919], [1.043], [0.902], [1.090], [0.917],
    table.hline(stroke: 0.8pt),
  )], caption: [Fits to #emph[NICER] and #emph[XMM-Newton] data with a parameterized normalization for the #emph[XMM-Newton] calibration.]
  , kind: table
  )
<tab:credibleNICERXMMnorm>












#figure([#image("figures/J0740_calibration_all.pdf", width: 100%)],
  caption: [
    Posterior probability density distributions for a model with two, uniform, circular spots that is fit to the #emph[NICER] and #emph[XMM-Newton] data, where we allow the #emph[XMM-Newton] effective area to be multiplied by an energy-independent parameter $A_(upright("XMM"))$. The dotted lines in the one-dimensional plots for gravitational mass and distance indicate the priors that we applied.
  ]
)
<fig:full-posteriors-for-NICER-and-XMMcalib>

#pagebreak()
#set page(columns: 2)

#show bibliography: set text(size: 10.9pt)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 12pt, weight: "regular")
#bibliography("refs.bib", style: "aas.csl", title: [REFERENCES], full: true)