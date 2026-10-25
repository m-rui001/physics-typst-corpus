// Fast radio bursts at the dawn of the 2020s -- E. Petroff, J. W. T. Hessels, D. R. Lorimer
// Converted by hand from src/article_springer.tex (Springer svjour3, A&ARv review).
#set text(font: ("New Computer Modern", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "a4", margin: (left: 2.54cm, right: 6.58cm, top: 3.24cm, bottom: 7.06cm))
#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let e = it.element
  if e != none and e.func() == math.equation {
    [Eq. (#context counter(math.equation).at(e.location()).first())]
  } else { it }
}
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.caption: set align(left)
#set figure(placement: top)
#let figref(l) = ref(l)
#let secref(l) = ref(l)
#let eqref(l) = ref(l)
#show math.equation.where(block: true): set align(center)
#show heading.where(level: 3): set text(size: 10.5pt)

#align(center)[
  #text(13pt, weight: "bold", [Fast radio bursts at the dawn of the 2020s])
  #v(1em)
  #text(10.5pt)[E.~Petroff#super[\*]#super[1,2], J.~W.~T.~Hessels#super[1,3], D.~R.~Lorimer#super[4,5]]
  #v(0.8em)
  #text(8.5pt)[
    #super[1] Anton Pannekoek Institute, University of Amsterdam, Science Park 904, 1098 XH, Amsterdam, The Netherlands\
    #super[2] McGill Space Institute, McGill University, 3550 rue University, Montréal, QC H3A 2A7, Canada\
    #super[3] ASTRON, Netherlands Institute for Radio Astronomy, Oude Hoogeveensedijk 4, 7991 PD, Dwingeloo, The Netherlands\
    #super[4] Department of Physics and Astronomy, West Virginia University, PO Box 6315, Morgantown, WV, USA\
    #super[5] Center for Gravitational Waves and Cosmology, West Virginia University, Chestnut Ridge Research Building, Morgantown, WV, USA
  ]
  #v(0.4em)
  #text(8.5pt)[#super[\*] Corresponding author: E.~Petroff (#link("mailto:e.b.petroff@uva.nl")[e.b.petroff\@uva.nl])]
  #v(0.4em)
  #text(8.5pt)[Received: date / Accepted: date]
]
#v(1.2em)

#align(center)[
  #text(9.5pt)[*Abstract.* Since the discovery of the first fast radio burst (FRB) in 2007, and their confirmation as an abundant extragalactic population in 2013, the study of these sources has expanded at an incredible rate. In our 2019 review on the subject we presented a growing, but still mysterious, population of FRBs -- 60 unique sources, 2 repeating FRBs, and only 1 identified host galaxy. However, in only a few short years new observations and discoveries have given us a wealth of information about these sources. The total FRB population now stands at over 600 published sources, 24 repeaters, and 19 host galaxies. Higher time resolution data, sustained monitoring, and precision localisations have given us insight into repeaters, host galaxies, burst morphology, source activity, progenitor models, and the use of FRBs as cosmological probes. The recent detection of a bright FRB-like burst from the Galactic magnetar SGR~1935+2154 provides an important link between FRBs and magnetars. There also continue to be surprising discoveries, like periodic modulation of activity from repeaters and the localisation of one FRB source to a relatively nearby globular cluster associated with the M81 galaxy. In this review, we summarise the exciting observational results from the past few years. We also highlight their impact on our understanding of the FRB population and proposed progenitor models. We build on the introduction to FRBs in our earlier review, update our readers on recent results, and discuss interesting avenues for exploration as the field enters a new regime where hundreds to thousands of new FRBs will be discovered and reported each year.]
]

#v(0.8em)
#text(9.5pt)[*Keywords:* Fast Radio Burst, Pulsar, Magnetar, Radio Astronomy, Transient]
#v(1.2em)

#outline(title: [*Contents*], depth: 3)
#v(1em)

= Introduction <sec-intro>

Research into understanding the origins, mechanisms and applications of fast radio bursts (FRBs) is currently one of the most rapidly evolving areas in astrophysics. As a phenomenon, FRBs are characterised as short-duration (sub-second), relatively broad-band pulses which exhibit the frequency-dependent arrival time delay due to dispersion that is well known for Galactic radio pulsars @lorimer_2012_hpa Unlike pulsar emission, however, FRB pulses show much larger dispersive delays, consistent with an extragalactic origin; they also sometimes show characteristic time-frequency drifts, even after dedispersion @hessels_2019_apjl. In our previous review @lorimer_2012_hpa @petroff_2019_aarv[hereafter PHL19] we provided an extensive introduction to FRBs starting with their discovery @lorimer_2007_sci, and detailed their emergence as a cosmological source population whose origins are still poorly understood. Further insights, and a much more detailed examination of propagation effects, can be found in #cite(<cordes_2019_araa>, form: "prose").

// [figvision] figures/frb_sources_papers_graph.png
// Main panel: a line plot of cumulative unique fast radio burst sources versus observation date. The x axis
// spans 2000 to about 2022 with ticks at 2000, 2005, 2010, 2015 and 2020; the y axis runs from 0 to about 620
// with ticks every 100. A single thick black step curve begins near one source around 2001, stays nearly flat
// below ten through the 2000s, creeps to roughly fifteen by 2012 and about thirty by 2016, then steepens mildly
// to around sixty-five by late 2018, before an almost vertical jump to roughly 580 during 2019-2020 and a
// plateau near 600 through 2021. The message: FRB source discovery was slow until CHIME, then exploded and
// levelled off. Inset panel (upper-centre): a stacked bar chart of FRB-related articles per publication year,
// 2013 to 2021, with rotated year labels on the x axis and a y axis labelled Number of articles from 0 to about
// 350, ticks every 100. Each bar is blue for refereed articles with green stacked on top for non-refereed.
// Approximate totals: 2013 about five, 2014 about sixty-five, 2015 about sixty, 2016 about one hundred
// twenty-five, 2017 about one hundred seventy-five, 2018 about two hundred, 2019 about two hundred forty, 2020
// about three hundred thirty-five, and 2021 about three hundred sixty-five. Refereed counts rise from under ten
// to roughly two hundred, while non-refereed grows fastest after 2018. A boxed legend at upper left identifies
// the two colours.Main panel: a line plot of cumulative unique fast radio burst sources versus observation date.
// The x axis spans 2000 to about 2022 with ticks at 2000, 2005, 2010, 2015 and 2020; the y axis runs from 0 to
// just over 600 with ticks every 100. A single thick black step curve begins at one source around 2001, stays
// nearly flat below ten through the 2000s, creeps to roughly fifteen by 2012 and thirty by 2016, reaches about
// sixty-five by late 2018, then jumps almost vertically to roughly 580 during 2019-2020 before plateauing near
// 600 through 2021. The message: FRB discovery was slow until CHIME, then surged and levelled off. Inset panel
// (upper centre): a stacked bar chart of FRB articles per publication year, 2013 to 2021, with rotated year
// labels and a y axis labelled Number of articles from 0 to about 350, ticks every 100. Each bar is blue for
// refereed with green stacked above for non-refereed. Approximate totals: 2013 about five, 2014 about
// sixty-five, 2015 about sixty, 2016 about one hundred twenty-five, 2017 about one hundred seventy-five, 2018
// about two hundred, 2019 about two hundred forty, 2020 about three hundred thirty-five, 2021 about three
// hundred sixty-five, with refereed counts reaching roughly two hundred and non-refereed growing fastest after
// 2018. A boxed legend at upper left identifies the two colours.
// capstyle
#show figure.caption: it => {
  if it.supplement != none and it.supplement == [Table] { return it }
  if it.numbering == none { return it }
  [*Fig. #context it.counter.display(it.numbering)* #it.body]
}

#figure(placement: top, 
  image("figures/frb_sources_papers_graph.png", width: 100%),
  caption: [
    Cumulative number of published, unique FRB sources as a function of their arrival time at the Earth. Some of these predate the Lorimer burst @lorimer_2007_sci because they were subsequently found in other archival data from the Parkes radio telescope. The sample is dominated by the recent publication of the first CHIME/FRB catalogue of FRBs @chime_2021_arxiv_arxiv210604352. The leveling off in recent years reflects the rate at which new FRB sources are being published; they continue to be discovered at an ever increasing rate. Inset: publications with 'fast radio burst' in the abstract since 2013, the year in which the term was coined in #cite(<thornton_2013_sci>, form: "prose"). Source: NASA/ADS, TNS and FRBSTATS. Figure courtesy Mark Snelders.
  ]
) <fig-numbers>

Here, in this new, updated review, we provide a survey of the main developments from the last 2--3 years. Significant breakthroughs have been made in this period thanks to the emergence of new observational facilities, as well as a growing and dynamic group of active researchers with a wide range of backgrounds. #figref(<fig-numbers>) illustrates the large effect that this has had on the discovery rate of FRBs and research presented in the literature#footnote[See also FRBSTATS, #link("https://www.herta-experiment.org/frbstats")].

Below we briefly list the key areas to be discussed in this review:

- #strong[Overall sample size:] In PHL19, the published sample of FRBs totalled around 60. Thanks to the torrent of discoveries since that time, most notably with the release of the first catalogue from the Canadian Hydrogen Intensity Mapping Experiment Fast Radio Burst project (CHIME/FRB), the currently published sample now exceeds 600 unique sources. The observed properties of this population, which supersede those presented in PHL19, are shown in #figref(<fig-aitoff>) and #figref(<fig-distributions>). As is often the case in burgeoning research fields, such a quantum leap in the sample size inevitably leads to fundamental breakthroughs in our understanding.

- #strong[Repeating FRBs:] Since PHL19, where only two repeating FRBs were known, the sample of published repeating sources has now grown to 24. CHIME/FRB in particular --- with its wide field-of-view, repetitive coverage of the sky and good sensitivity --- has been very effective at finding these sources. Considering these, along with the apparently one-off FRBs, we discuss the evidence for and against there being multiple source populations with distinct physical origins.

- #strong[Periodic activity in repeating FRBs:] Due to their sporadic and generally unpredictable activity, monitoring repeating FRBs is a time intensive exercise. Nevertheless, thanks to the accumulation of long-term observing campaigns at multiple observatories, we now know that there is an underlying periodicity in activity windows for at least two repeating FRBs. Additionally, sub-second periodicity between sub-bursts within a single event has now been seen for at least one FRB. We place these results within the context of source models for FRBs.

- #strong[Burst energy and luminosity distributions:] The first-known repeater, FRB~20121102A#footnote[This source was originally named FRB~121102. The FRB community now follows the Transient Name Server (TNS) naming convention of 'FRB YYYYMMDDX', which includes the year, month, day, and and an additional letter to distinguish events that were reported on the same day. See #link("https://www.wis-tns.org")], has now been monitored extensively with a number of high-sensitivity instruments and has by far the largest number of bursts recorded. Recently, several groups have announced a significant increase in the number of bursts detected from FRB~20121102A. This sample, coupled with an accurate measurement of the source redshift now provides a relatively complete view of the burst energy and (isotropic equivalent) luminosity distribution of this source. We also discuss progress in our understanding of the FRB luminosity function for the population as a whole. The recent discoveries of repeating FRB sources associated with relatively nearby galaxies present an opportunity to study the faint end of the FRB luminosity distribution.

- #strong[Host galaxy identifications:] Since PHL19, at which point only one host galaxy identification (for the first-known repeater) was conclusively made, the sample of FRBs with accurate positions that allow for robust host galaxy association and redshift determination#footnote[For an up-to-date list of FRBs with host galaxy identifications, see #link("https://frbhosts.org").] has increased to 19. Among the new localizations are some exceptionally nearby FRBs, like a repeater associated with a globular cluster in the M81 galactic system, which provide strong constraints on multi-wavelength emission. The overall increase in the number of host galaxy identifications, in particular for one-off FRBs, is largely due to the interferometric capabilities and sky coverage of ASKAP (about a dozen one-offs localised). In addition, very long baseline interferometry (VLBI) with the European VLBI Network (EVN) is also providing milli-arcsecond localisations for an increasing number of repeating sources (six such localisations published or in preparation), and gives enough precision to match high-resolution #emph[Hubble Space Telescope] images of the hosts. These studies indicate that FRBs are produced in a wide variety of host galaxy types; a larger sample is needed to investigate potential systematic differences between the hosts and local environments of repeaters and apparent one-off FRBs.

- #strong[Probing the intergalactic medium:] Since PHL19, the emerging sample of FRBs with known redshift has been used to establish the so-called 'Macquart relationship'#footnote[Named in memory of our colleague and friend, J.-P. Macquart.] between dispersion measure (DM) and redshift. This has led to a best-ever quantification of the intergalactic baryon content.

- #strong[FRB-like pulses from a Galactic magnetar:] The diversity of FRB host galaxy types, mentioned above, includes spiral galaxies that are analogues of the Milky Way (e.g., the host of the nearby repeater FRB~20180916B). Shortly before the discovery of the Lorimer burst, it was also found that Galactic magnetars can have radio outbursts in which bright pulses are detected. In 2020, the Galactic magnetar SGR#footnote[SGR stands for soft gamma repeater.]~1935+2154 went into a highly active state in which a mega-Jansky burst was detected by STARE2 and CHIME/FRB. When placed into context with extragalactic FRBs, these detections are consistent with being part of the low end of a broad luminosity function, and provide strong circumstantial evidence linking magnetars and FRBs.

// [figvision] figures/Aitoff_all_update.png
// The figure is a single-panel Aitoff projection of the known FRB sample in Galactic coordinates. Galactic
// longitude labels run from 180° at the left limb through 120°, 90°, 60°, 0° at the centre, then −60°, −90°,
// −120°, −180° toward the right limb; latitude grid lines run from 75° to −75° in 15° steps with 0° along the
// Galactic equator. A legend on the right maps markers to surveys: CHIME/FRB are gray filled circles, Parkes red
// stars, ASKAP orange asterisks, Pushchino light-green plus signs, DSA-10 green squares, FAST cyan diamonds, GBT
// blue up-triangles, Arecibo blue down-triangles, UTMOST purple right-triangles, VLA magenta left-triangles, and
// Apertif magenta hexagons. Gray CHIME/FRB points dominate and are strongly concentrated in the northern
// Galactic hemisphere and along the plane near longitudes 120°–180°, reflecting CHIME's northern-sky
// sensitivity. Parkes and ASKAP points are more widely scattered, including southern skies. The raw sky
// distribution is visibly patchy rather than uniform; the caption notes that correcting for non-uniform sky
// coverage reveals an underlying isotropic distribution.
#figure(placement: top, 
  image("figures/Aitoff_all_update.png", width: 100%),
  caption: [
    Aitoff projection showing the currently known sample of FRBs in Galactic coordinates. The FRBs shown here are predominantly those found by CHIME/FRB, which is known to have significant variations in sensitivity over the sky and only views the northern celestial hemisphere. When corrected for non-uniform sky coverage, it has been shown that the underlying distribution is isotropic, as expected for a cosmological population.
  ]
) <fig-aitoff>

// [figvision] figures/dm_width_all_lofar_update.png
// The figure shows a scatter plot of pulse duration versus dispersion measure for FRBs. (a) This panel is not
// shown, but presumably it is a histogram of DMs for one-off bursts and first-detected bursts from observed
// repeaters. (b) This panel is not shown, but presumably it is a histogram of widths for one-off bursts and
// first-detected bursts from observed repeaters. (c) The plot shows pulse duration in milliseconds on the
// y-axis, ranging from 0.1 to 10^3 ms, and dispersion measure in cm^-3 pc on the x-axis, ranging from 0 to 3000.
// Each point represents a FRB detection, with different colours indicating the detection instrument: grey for
// CHIME/FRB, red for Parkes, orange for ASKAP, green for Pushchino, purple for UTMOST, cyan for FAST, blue for
// GBT, pink for Apertif, and dark green for LOFAR R3. The trend shows that pulse duration increases with
// dispersion measure for some instruments, but there is significant scatter. There is no clear correlation.
// [figvision] figures/excess_dm_all_update.png
// Panel (a) is a histogram showing the distribution of reported DMs. The x-axis represents the excess dispersion
// measure in units of cm^-3 pc, ranging from 0 to 3000. The y-axis represents the number of events, ranging from
// 0 to 160. There are two series: one in blue for one-off bursts and one in orange for the first-detected bursts
// from observed repeaters. The blue series has a large peak at low DM values, decreasing towards higher values,
// while the orange series has a small peak at low DM values. The trend shows that one-off bursts have a wider
// range of DMs than repeaters.
// [figvision] figures/width_distribution_all_update.png
// Panel (b) of the caption set, shown alone: a frequency histogram. The x axis, "Pulse duration (ms)", is
// logarithmic and spans 10^-1 to 10^2; the y axis, "Number", is linear from 0 to about 125 with ticks every 20.
// A solid blue histogram shows one-off FRBs: values rise from 13 at 0.1–0.15 ms through 18, 69, 107 and 104 to a
// peak of 125 near 0.7–1 ms, then decline through 65, 47, 25 and 9 to a sparse tail of 4 around 10–15 ms, ending
// by roughly 30 ms. A short solid orange histogram of first-detected repeater bursts spans about 0.4–11 ms,
// peaking at 8 near 0.8–1 ms. Both distributions are roughly log-normal and centred near 1 ms, with repeater
// first bursts far fewer and slightly narrower.
#figure(placement: top, [
// [figvision] figures/dm_width_all_lofar_update.png
// The figure shows panel (c), a scatter plot of pulse duration versus dispersion measure for fast radio bursts.
// The x-axis is Dispersion measure (cm⁻³ pc) on a linear scale from 0 to 3000; the y-axis is Pulse duration (ms)
// on a logarithmic scale from 10⁻¹ to 10³. CHIME/FRB points are small grey circles, densely clustered below 1000
// cm⁻³ pc and 10 ms. Parkes bursts are red stars scattered across low to high DM. ASKAP bursts are orange X
// markers concentrated at low DM. LOFAR R3 bursts are green stars forming a vertical sequence near DM ≈ 350 cm⁻³
// pc with durations from roughly 30 to 150 ms. Pushchino bursts are green plus signs at the top, spanning
// durations near 500–1000 ms at low DM. Additional series include DSA-10 (green squares), FAST (cyan diamonds),
// UTMOST (purple right triangles), VLA (magenta left triangles), GBT (blue upward triangles), Arecibo (blue
// downward triangles), and Apertif (magenta hexagons), each with a handful of points. Most bursts lie below 10
// ms duration, while long-duration outliers appear predominantly at low dispersion measure. The message is that
// pulse duration spans three orders of magnitude and shows no clear monotonic trend with DM across the sample.
// bars (one-off bursts, bins about 100-200 pc cm−3 wide) show roughly 73 bursts from 0-200, a peak of about 153
// in the 200-400 bin, about 139 at 400-600, then 79, 46 and 45 out to 1200, followed by a long tail of roughly
// 16, 9, 11, 7, 3 and 2 to 2000, with isolated bars of 1-3 bursts near 2250, 2450 and 2900-3000. Orange filled
// bars (first-detected bursts of repeaters) sit only at low DM: about 9-10 bursts between roughly 100 and 600,
// one near 700, and three near 1100-1250, vanishing beyond. The message: repeater first bursts cluster at low
// excess DM, while one-offs span the full range out to about 3000 cm−3 pc.
// to the negative one up to 10 cubed. Data points are color-coded by telescope: grey circles for CHIME/FRB, red
// stars for Parkes, orange crosses for ASKAP, green plus signs for Pushchino, and various shapes for DSA-10,
// FAST, GBT, Arecibo, UTMOST, VLA, Apertif, and LOFAR R3. Most data cluster between 1 and 10 milliseconds with
// dispersion measures under 1500, while high-duration outliers appear at low dispersion values.
  #grid(columns: (1fr, 1fr), gutter: 1.5em,
    align(center)[
      #image("figures/excess_dm_all_update.png", width: 100%)
      #linebreak()
      #text(size: 9pt)[(a) DM excess histogram]
    ],
    align(center)[
      #image("figures/width_distribution_all_update.png", width: 100%)
      #linebreak()
      #text(size: 9pt)[(b) Pulse duration histogram]
    ],
  )
  #v(0.6em)
  #align(center)[#image("figures/dm_width_all_lofar_update.png", width: 100%)]
  #v(-0.2em)
  #align(center)[#text(size: 9pt)[(c) Pulse duration versus DM]]
  ],
  caption: [
    Selected observed properties of the currently known sample of FRBs for one-off bursts (blue) and the first-detected bursts from observed repeaters (orange). (a) The distribution of reported DMs. (b) The distribution of reported widths. (c) The reported widths versus DM for all one-offs and first repeats from different detection instruments; here the repeat bursts from FRB~20180916B (R3) detected with LOFAR from #cite(<pleunis_2021_apjl>, form: "prose") are also plotted because they illustrate the large widths seen at low radio frequencies (likely dominated by scattering and time-frequency drift in this case).
  ]
) <fig-distributions>

These rapid advances within the FRB research community demonstrate the power of modern time-domain astrophysics, which has also seen significant developments in gravitational wave detection with ground-based instruments @miller_2019_natur and large-scale surveys of the sky at other wavebands @bloemen_2016_spie @bellm_2019_pasp @nir_2021_pasp. Together, these efforts are establishing the foundations for a cosmic census of compact object source populations. Further discussions of recent FRB results can be found in #cite(<zhang_2020_natur>, form: "prose"), #cite(<chatterjee_2021_ag>, form: "prose"), #cite(<bhandari_2021_univ>, form: "prose") and #cite(<xiao_2021_scpma>, form: "prose"). Summaries of the recent FRB annual conferences, FRB~2020 @keane_2020_natas and FRB~2021 @hessels_2021_natas, are also available.

= Recent observational breakthroughs <sec-observations>

Both the discovery of more FRBs and deeper characterisations of their properties are key to understanding their physical origins -- as well as for using them as astrophysical and cosmological probes. The past few years, since our original FRB review appeared, have provided important new observational insights at an accelerating pace, along with some major surprises. We now discuss these in more detail.

== Having lots of them <sec-lots-of-frbs>

The global effort to study FRBs has led to an explosion in the number of experiments running worldwide and, as a natural consequence, the number of known FRBs. The known population in the literature#footnote[See the Transient Name Server (#link("https://www.wis-tns.org")), and a summary of the statistics at FRBSTATS (#link("https://www.herta-experiment.org/frbstats")).] now stands at $tilde.op 600$ one-off events and two dozen repeaters, thanks in large part to CHIME/FRB @chime_2018_apj @chime_2021_arxiv_arxiv210604352, whose unprecedented $tilde.op 200$~sq.~deg. field of view and nearly continuous operation allow for the discovery of several new FRBs per day#footnote[These are now also being announced in near real time using VOEvents, enabling rapid multi-wavelength and multi-messenger follow-up.]. Repeating FRBs currently account for $tilde.op 4$% of the known population, but many repeaters have only been seen twice. This suggests that many currently one-off sources may be seen to produce a second (or third, etc.) burst, given enough follow-up.

Nonetheless, the large sample of known FRBs is starting to show trends that suggest sub-populations based on burst morphology and spectra. A paradigm for repeating FRBs is appearing to emerge: given enough S/N and time resolution, they often show a characteristic downward drift of sub-bursts in frequency @hessels_2019_apjl @fonseca_2020_apjl[this is colloquially referred to as the 'sad trombone' effect]; $tilde.op 100$% linear polarisation and negligible circular polarisation @nimmo_2021_natas, but not always @hilmarsson_2021_mnras @kumar_2021_arxiv; and two sources show a periodicity in their activity level @chime_2020_natur_582 @rajwade_2020_mnras @cruces_2021_mnras #cite(<pleunis_2021_apj>, form: "prose") study the sample of bursts from the first CHIME/FRB catalogue and find that repeaters are typically wider in time but narrower in bandwidth compared to one-offs. It thus appears that there are likely at least two types of FRBs, and that one-offs are not just simply less active sources. Whether this demonstrates different types of sources, or whether it can be accommodated by a different (and more sporadic) emission mechanism from the same type of source, is unknown.

As the known FRB population continues to increase rapidly, further sub-populations may become apparent. FRB~20191221A, the only known FRB to show a strict periodicity between sub-bursts (which are separated by 216.8~ms, see #figref(<fig-periodic-bursts>)), appears to be a rare type of event and one can speculate that it is different in origin compared to the vast majority of the observed FRB population.

// [figvision] figures/Michilli_2021_adapted.png
// Panel a shows FRB20191221A. The upper subplot is a black time-series flux curve spanning roughly -1,000 to
// 2,500 ms and containing about nine narrow peaks. The lower dynamic spectrum plots frequency from 400 to 800
// MHz on the y-axis against time from 0 to about 2,500 ms on the x-axis, with intensity colour-coded from teal
// (low) to yellow (high). A bright burst near t = 0 ms exhibits strong scattering as a downward-curving tail to
// lower frequencies. Red square markers line the left edge at several frequencies. The peaks recur with a strict
// period near 216.8 ms over nearly three seconds. Panel b shows FRB20210206A. The upper subplot is a black flux
// curve from about -5 to 18 ms with several narrow peaks. The lower dynamic spectrum covers frequency 400-800
// MHz versus time -5 to roughly 18 ms, intensity colour-coded teal (low) to yellow (high). Bright vertical
// striations repeat at intervals near 2.8 ms, giving the quasi-periodicity. A red square marker appears on the
// left edge near 750 MHz, and faint horizontal banding crosses the spectrum at fixed frequencies. Panel c shows
// FRB20210213A. The upper subplot is a black flux curve from 0 to 60 ms with several narrow peaks. The lower
// dynamic spectrum covers frequency 400-800 MHz versus time 0 to 60 ms, intensity colour-coded teal (low) to
// yellow (high). Emission concentrates in vertical structures repeating near 10.7 ms intervals, with additional
// power at low frequency around 400-450 MHz. A red square marker sits on the left edge near 750 MHz, and faint
// horizontal lines cross the band at fixed frequencies.
#figure(placement: top, 
  image("figures/Michilli_2021_adapted.png", width: 100%),
  caption: [
    Periodic and quasi-periodic bursts detected by CHIME/FRB. FRB~20191221A (left) is a remarkable event, lasting for nearly 3 seconds and showing 9 peaks separated by a strict period of 216.8~ms. It also shows a high level of scattering. The other two events, FRB~20210206A and FRB~20210213A, show quasi-periodicities at 2.8~ms and 10.7~ms, respectively --- though the statistical significance of these periods are marginal. We note that the sub-bursts of repeaters are sometimes also quasi-periodic @hessels_2019_apjl Figure from #cite(<chime_2021_arxiv_arxiv210708463>, form: "prose").
  ]
) <fig-periodic-bursts>

Large samples of bursts have also become available for some individual repeaters, especially FRB~20121102A, FRB~20180916B and FRB~20201124A. These allow us to study their individual burst energy distributions and average spectra, as well as how their activity and properties change with time (as discussed below). The isotropic equivalent energy distribution of FRB~20121102A~is multi-modal, and an apparent peak in the distribution is found at lower energies @li_2021_natur. This shows that repeaters can produce multiple types of bursts, some of which arguably appear more similar to those seen from one-off FRBs. The large sample of bursts found by FAST @li_2021_natur and Arecibo @hewitt_2021_arxiv has yet to demonstrate any strict or quasi-periodicity in the burst arrival times, like what is seen from pulsars. Nonetheless, the wait time between sub-bursts is characteristically about a few ms @hessels_2019_apjl @li_2021_natur, and there is also a broad peak in the wait times between closely spaced bursts at roughly a few tens of ms @hewitt_2021_arxiv --- in addition to a dominant peak related to the general burst rate. The large number of bursts per unit time also means that the available energy reservoir of the central engine is not easily exhausted. Indeed, FRB~20121102A~has been observed as an active repeater for now close to a decade @spitler_2014_apj @spitler_2016_natur, and this constrains the lifetime of such sources.

Overall, the much larger sample of known sources, and burst distributions for individual sources, is allowing for increasingly meaningful population studies @james_2022_mnras_1 @james_2022_mnras_2. These are beginning to better quantify how well the observed FRB population traces star formation as a function of redshift and allows for comparison of the volumetric rate with those of other types of astrophysical events (e.g., supernovae, binary mergers of compact objects) and sources @ravi_2019_natas @zhang_2021_mnras.

The applications of FRBs to broader problems in astrophysics and cosmology are greatly aided by these large samples (see #secref(<sec-probes>)). At the same time, we have entered the regime in which there is insufficient person-power and telescope resources to follow-up every FRB exhaustively.

== Knowing where they come from <sec-hosts>

Close to two dozen FRBs have now been localised to (sub-)arcsecond precision and robustly associated with a host galaxy. Interestingly, these studies have shown that FRBs can be hosted in a wide range of galaxy types and environments, though some trends are possibly emerging @heintz_2020_apj @mannings_2021_apj @li_2020_apjl @bhandari_2021_arxiv. The precisely localised repeaters have been shown, in some cases, to be close to star-forming regions in their host galaxies @bassa_2017_apjl @marcote_2020_natur @fong_2021_apjl @ravi_2021_arxiv @piro_2021_aa @nimmo_2021_arxiv_arxiv211101600. However, in the cases of FRB~20121102A~@bassa_2017_apjl and FRB~20180916B, @tendulkar_2021_apjl there is an offset of $tilde.op 2$00--250~pc between the FRB source and the closest peak of local star formation when comparing the milliarcsecond localisation from the EVN with #emph[Hubble Space Telescope imaging]. Additional localisations are needed to determine whether this is a common trend; does it indicate that repeaters are older than one might naively expect, or do they come from runaway OB stars that collapsed to a neutron star relatively far from their birthplace? Conversely, some non-repeaters have been found in galactic hosts with very low star-formation rates, and even in the outskirts of such galaxies @heintz_2020_apj @mannings_2021_apj @bhandari_2021_arxiv. This has led to the hypothesis that FRBs may be magnetars formed via a variety of channels including core collapse supernovae, binary mergers and accretion-induced collapse @gourdji_2020_mnras @margalit_2019_apj. They may also be older systems than assumed in young magnetar models --- e.g., high-mass binaries featuring a neutron star @tendulkar_2021_apjl.

// [figvision] figures/Bhandari_2021_adapted_1.png
// a. This is a plot showing star-formation rate (SFR) versus stellar mass for the host galaxies of FRBs. The
// x-axis ranges from 7.5 to 11.5 in units of log solar mass, and the y-axis ranges from -2.5 to 1.5 in units of
// log solar mass per year. There are two series: cyan and green diamonds for repeating and non-repeating FRBs,
// respectively. Dashed lines indicate SFR for different redshifts. The trend shows that FRB host galaxies have
// higher SFRs than quiescent galaxies but are similar to star-forming galaxies. Error bars are shown for each
// data point.
// [figvision] figures/Bhandari_2021_adapted_1.png
// Panel: scatter plot of host-galaxy star-formation rate versus stellar mass. Y-axis log SFR spans −2.5 to 1.5
// M⊙ yr⁻¹; x-axis log M* spans 7.5 to 11.5 M⊙. A grayscale density background shows the comparison galaxy
// population. Four dashed star-forming main-sequence lines run diagonally: cyan z=0, yellow z=0.2, green z=0.4,
// blue z=0.6. FRB hosts are plotted as diamonds (repeating) and circles (non-repeating), with point color
// indicating redshift to match the lines. Roughly 14–16 points carry black error bars, spanning log M* ≈
// 8.0–10.7 and log SFR ≈ −1.2 to 0.9. Diagonal text labels "Star forming" above the upper line and "Quiescent"
// below the lower line. Hosts cluster near or below the z≈0.2–0.6 sequences, including several low-SFR repeating
// outliers, showing FRB hosts span both star-forming and quiescent regimes.
#figure(placement: top, 
  table(
    columns: 2,
    align: center,
// [figvision] figures/Bhandari_2021_adapted_1.png
// Left panel: scatter plot of log SFR (M☉ yr⁻¹, −2.5 to 1.5) versus log M★ (M☉, 7.5–11.5). A greyscale density
// map of the comparison galaxy sample forms a diagonal star-forming main sequence, darkest near log M★ 9–10 and
// log SFR −0.5–0; rotated labels "Star forming" (upper left) and "Quiescent" (lower right) mark the regions.
// Four parallel dashed lines rise left to right, indexed z=0.6 (blue, highest), z=0.4 (green), z=0.2 (yellow),
// z=0 (cyan, lowest), keyed bottom right. Sixteen hosts: cyan diamonds = repeating, circles = non-repeating
// (legend top left); fills are cyan, yellow, green or dark blue matching the redshift colour scale, each with
// black edges and x/y error bars. Most hosts lie on or above the main sequence; repeatings at (8.15, −0.8) and
// (9.45, −1.25) sit in the quiescent region, while a non-repeater tops the sample at (10.65, 0.9).
    image("figures/Bhandari_2021_adapted_1.png", width: 100%),
    image("figures/Bhandari_2021_adapted_2.png", width: 100%),
  ),
  caption: [
    #emph[Left]: Star-formation rate versus stellar mass for the host galaxies of 16 FRBs with robust host associations. These are compared with a population of galaxies at $z < 0.6$. #emph[Right]: Rest-frame color-magnitude diagram of the host galaxies of 15 FRBs (all those in the left panel, with the exception of FRB~20171020A). These are compared with the same galaxy sample as in the left panel. Figure from #cite(<bhandari_2021_arxiv>, form: "prose").
  ]
) <fig-bhandari-hosts>

While the majority of localised FRBs are located in galaxies at Gpc distances, we are also fortunate to have detected a putative FRB in our own Milky Way galaxy. On 28 April 2020, CHIME/FRB and STARE2 simultaneously detected#footnote[To within the dispersive delay between their observing bands. Also, note that CHIME/FRB detected two sub-bursts in their 400--800~MHz band, whereas only one of these components was visible at 1.4~GHz with STARE2.] an exceptionally bright (1.5~MJy~ms at 1.4~GHz) burst from the Galactic magnetar SGR~1935+2154 @chime_2020_natur_587 @bochenek_2020_natur. This burst, referred to by some in the literature as FRB~200428, has a spectral luminosity that is only a factor of 30 less compared to the weakest known bursts from FRB~20180916B, which until recently was the nearest-known extragalactic FRB source, at $tilde.op 150$~Mpc @marcote_2020_natur. The MJy-ms event from SGR~1935+2154 is actually higher in spectral luminosity compared to some bursts seen from an exceptionally nearby FRB found to be associated with M81 (see below). SGR~1935+2154 has shown several other bursts, one with a fluence of only 60~mJy~ms @zhang_2020_atel, and others with fluences of about 10--100~Jy~ms. Together, these bursts span $tilde.op 7$ orders-of-magnitude in spectral luminosity, and the burst rate is remarkably similar across this range @kirsten_2021_natas. This bridges the luminosities of Galactic radio pulse emitters and the extragalactic FRBs (#figref(<fig-tps-zoom>)). As recently shown by #cite(<lin_2020_natur>, form: "prose"), however, with FAST observations of SGR~1935+2154 taken during a subsequent period of X-ray activity, no accompanying FRB-like radio pulses were detected in spite of a noise floor that is 8 orders of magnitude lower. This null result suggests that associations between SGR bursts and FRBs are very rare.

The exceptionally active FRB~20201124A has been localised by several interferometers, providing the best test yet of localisation accuracy, both within and between experiments @ravi_2021_arxiv @fong_2021_apjl @nimmo_2021_arxiv_arxiv211101600. Interestingly, the FRB source was shown to be coincident with a persistent radio source. However, VLBI observations with EVN and VLBA have demonstrated that this source is not compact @ravi_2021_arxiv @nimmo_2021_arxiv_arxiv211101600, unlike the persistent radio counterpart to FRB~20121102A. A VLA detection at 22~GHz demonstrates that this radio source is very likely due to star formation @piro_2021_aa; future #emph[Hubble Space Telescope] observations will better quantify where FRB~20201124A is located with respect to local knots of star-formation, by exploiting its milliarcsecond localisation. Bursts from FRB~20201124A can be exceptionally bright ($> 100$~Jy~ms), and coupled with its high activity rate, this has allowed for detections with $tilde.op 25$-m class @kirsten_2021_atel and even smaller radio dishes @farah_2021_atel, as well as one dish that is operated by amateur radio astronomers @herrmann_2021_atel.

The CHIME/FRB discovery of a low-DM repeater, FRB~20200120E, in the direction of the nearby M81 galaxy @bhardwaj_2021_apjl_910 has provided the opportunity to study an extragalactic FRB from nearby. #cite(<kirsten_2021_arxiv>, form: "prose") localised this source to a globular cluster in the M81 system at 3.6~Mpc, thereby ruling out that it is a Galactic halo source. The surprising association with an old globular cluster rules out a young source formed through core collapse of a massive star, and possibly points towards a young, highly magnetised neutron star formed via accretion-induced collapse or binary merger @kirsten_2021_arxiv @lu_2022_mnras @kremer_2021_apjl Alternatively, the bursts could be coming from an extreme millisecond pulsar @kremer_2021_apjl[though #cite(<lu_2022_mnras>, form: "prose") argue against this], or an accreting neutron star or black hole. The low burst luminosities and short burst durations of FRB~20200120E @nimmo_2021_arxiv_arxiv210511446 suggest that, perhaps, it is not representative of the broader population of repeating FRB sources.

// [figvision] figures/Tendulkar_2021_adapted.png
// Panel a (left): HST WFC3 F110W (near-infrared) image of the spiral host galaxy of FRB 20180916B with its
// surroundings. Both axes are celestial coordinates: RA (hh mm ss) increasing read as 04s, 02s, 58m00s, 58s,
// 1h57m56s left to right, and Dec (dd mm ss) from about 65d42m45s to 65d43m30s; tick labels 15" and 00" mark
// offsets. The display is a yellow-to-dark-purple/grey inverse colour scale: bright pixel intensity appears
// yellow, faint light dark, so the low-surface-brightness barred spiral sits as a diffuse dark blob near Dec
// 00", while foreground stars are dark spots with cross-shaped diffraction spikes. A small dashed black square
// just above the galaxy centre marks the field zoomed in panel b. Field stars and faint compact sources are
// scattered across the surrounding area. The message is the galaxy's morphology, size, and Location among
// contaminants. Panel b (right): zoom of the dashed square, again F110W, shown with an orange-yellow to
// dark-purple scale where dark equals faint. Axes: RA (hh mm ss) spanning 01.0s, 00.8s, 00.6s, 1h58m00.4s; Dec
// (dd mm ss) labelled 02", 01", 43'00", 59", 65d42'58" downward. A vertical blue scale bar reads 1 kpc. The
// galaxy's diffuse light fills the frame, pocked by dark blobs (compact clusters/dust). A green horizontal arrow
// points from the left to a tiny green dot, the EVN-determined FRB position, which lies just offset from an
// adjacent white/purple patch of local star formation. A white bent line traces that stellar-peak region, and
// dashed white lines maybe bracket the offset direction, communicating a pc-scale separation between-frb site
// and neareSt star-forming peak.
#figure(placement: top, 
  image("figures/Tendulkar_2021_adapted.png", width: 100%),
  caption: [
    #emph[Hubble Space Telescope] images of the host galaxy of FRB~20180916B. The left panel shows the full galaxy and its surroundings, while the right panel provides a zoom-in (defined by the dashed square in the left panel). The FRB position, as determined from EVN, is offset by $tilde.op 250$~pc from the closest peak of local star formation. Figure adapted from #cite(<tendulkar_2021_apjl>, form: "prose").
  ]
) <fig-r3-host>

Even more recently, #cite(<bhardwaj_2021_apjl_919>, form: "prose") presented the likely host of FRB~20181030A. Using CHIME/FRB voltage data, they were able to localise the source to a sky region of a few square arcminutes. Despite the relatively coarse localisation precision, the exceptionally low DM of the source and overlap with the prominent galaxy NGC~3252 suggest that the association is robust. NGC~3252 is a star-forming spiral galaxy at a distance of $tilde.op 20$~Mpc, placing FRB~20181030A at an intermediate distance between the other well-localised repeaters FRB~20200120E ($tilde.op 3.6$~Mpc) and FRB~20180916B ($tilde.op 150$~Mpc). Importantly, #cite(<bhardwaj_2021_apjl_919>, form: "prose") argue that young millisecond magnetars alone are insufficient to explain the observed volumetric rate of repeating FRBs.

Most recently, the FAST-discovered repeater FRB~20190520B has been shown to be coincident with a compact persistent radio source in a dwarf host galaxy. This makes FRB~20190520B a close analogue to the original repeater (FRB~20121102A) though, interestingly, the local and host DM contribution of $tilde.op 900$~$"cm"^(-3)$~pc is much higher than any other localised FRB (see also #secref(<sec-macquart>) and #figref(<fig-dmz>)). This may indicate that FRB~20190520B is a particularly young source, or at least that it was formed in an exceptionally dense environment. Active repeaters have been found both #emph[with] @chatterjee_2017_natur @marcote_2017_apjl @niu_2021_arxiv and #emph[without] @marcote_2020_natur @kirsten_2021_arxiv @nimmo_2021_arxiv_arxiv211101600 a compact persistent radio source (which is unrelated to star formation). #cite(<law_2021_arxiv>, form: "prose") discuss how such sources may comprise as much as 1% of the compact, luminous radio sources detected in the local Universe. Their nature remains unclear, however: e.g., do they represent magnetar wind nebulae, or perhaps a nearby accreting massive black hole @michilli_2018_natur @eftekhari_2019_apjl? FRBs from these compact persistent radio sources may be discoverable in targeted searches of superluminous supernovae @eftekhari_2019_apjl, long gamma-ray bursts @marcote_2019_apjl, or the population of 'wandering' black holes in dwarf galaxies @reines_2020_apj --- some of which may actually be related to repeating FRBs as opposed to AGN-like activity.

With close to two dozen precision localisations now in hand, FRB host galaxy associations are becoming relatively routine. However, our ability to associate the most distant FRBs to host galaxies is limited by the precision of the localisations themselves and the resulting chance coincidence probability. For example, for one particularly distant FRB, #cite(<law_2020_apj>, form: "prose") are only able to identify two potential host galaxies, perhaps neither of which is the true host, despite the high precision localisation of this source.

// [figvision] figures/TPS_review.png
// A single log-log scatter plot shows spectral luminosity (erg s^-1 Hz^-1, axis 10^13 to ~10^35) versus
// transient duration, νW in GHz s (axis 10^-9 to ~10^1). Grey dashed diagonals of constant brightness
// temperature run lower-left to upper-right, labeled 10^20 K to 10^44 K in 10^4 K steps. All series use
// semi-transparent markers whose overlap darkens dense regions. Pulsars: grey/black diamonds, dense cloud at
// durations ~10^-5 to 10^-1 and ~10^15-10^19 erg s^-1 Hz^-1 (averaged luminosities). RRATs: red circles with
// black rims just above, ~10^-3 to 10^-1 and 10^19-10^21. Crab GRPs: a small blue blob at ~10^-5 to 3x10^-4 and
// 10^21-10^23. Crab nanoshots: three cyan stars far left, ~10^-9 to 2x10^-8, 10^23-10^27. FRB 20200120E: purple
// crosses, main cluster near 1.5-2.5x10^-7 at ~10^30, plus scattered crosses out to 10^-3 at 10^28. SGR
// 1935+2154: orange stars around 10^-3, spanning 10^23-10^25 and two near 10^29. Extragalactic FRBs occupy the
// top: orange diamonds (FRB 20180916B) from ~3x10^-4 to 10^-2 at 10^30-10^31; magenta diamonds (FRB 20121102A)
// the densest, brightest cloud, ~10^-3 to 10^-1 at 10^32-10^34; a few green diamonds (FRB 20190711A) near 10^34.
// Series names appear as colored text labels matching marker colors. Message: all classes bridge ~20 decades in
// duration and luminosity, with implied brightness temperatures up to ~10^44 K indicating coherent emission.
#figure(placement: top, 
  image("figures/TPS_review.png", width: 100%),
  caption: [
    Radio transient phase space, focusing on the sub-second coherent radio flashes seen from Galactic pulsars (including the giant radio pulses, GRPs, and 'nanoshots' seen from the Crab), rotating radio transients (RRATs) and magnetars, as well as the extragalactic fast radio bursts. The pulsar luminosities plotted here are averaged and pulse-to-pulse variations can be significant. For both the pulsars and FRBs, the plotted luminosities are isotropic equivalent, because the beaming angle is unknown. Courtesy K.~Nimmo, adapted from #cite(<nimmo_2021_arxiv_arxiv210511446>, form: "prose").
  ]
) <fig-tps-zoom>

== Seeing them in fine detail --- in time, frequency and polarisation <sec-fine-detail>

The acquisition of full polarisation, voltage data for FRBs is becoming increasingly common. Voltage data provide excellent flexibility in exploring a range of time and frequency scales, and also allow for coherent dedispersion to be applied (see §~4.1.2 of PHL19 for a review). Both repeating and non-repeating FRBs have previously shown temporal structure as short as 20--30~µs @farah_2018_mnras @michilli_2018_natur #cite(<cho_2020_apjl>, form: "prose") investigate a one-off FRB in detail and find complicated polarimetric properties in four narrow sub-bursts. They also find variable apparent rotation measure (RM) and DM between these sub-bursts. #cite(<day_2020_mnras>, form: "prose") investigate the polarimetric properties of five ASKAP discoveries and find that the one repeating source in their sample is similar to other known repeaters (about 100% linearly polarized, with flat polarisation position angle and no evidence of circular polarisation), while the one-off sources are more heterogeneous in their polarimetric properties.

In contrast, #cite(<luo_2020_natur>, form: "prose") show polarisation angle swings in some of the bursts they observed from the repeater FRB~20180301A. These are reminiscent of the polarisation angle swings seen from pulsars, and suggest an origin in a rotating magnetosphere --- though other interpretations remain possible. Significant circular polarisation has now also been detected in some bursts from the repeater FRB~20201124A @hilmarsson_2021_mnras @kumar_2021_arxiv @xu_2021_arxiv. While some of the observed circular polarisation may have been converted from linear via propagation effects in the local medium, it appears that most of the signal must be related to the emission mechanism itself.

Other recent studies of repeaters have shown that their brightness varies on a wide range of timescales, from $< 100$~ns up to tens of milliseconds @majid_2021_apjl @nimmo_2021_arxiv_arxiv210511446 @nimmo_2021_natas Indeed, while #cite(<nimmo_2021_natas>, form: "prose")@nimmo_2021_arxiv_arxiv210511446 find nano- and microsecond structures in some repeater bursts, they also emphasise that not #emph[all] bursts display sub-millisecond temporal structure (or that such structure must be very closely spaced, as opposed to isolated microsecond shots). At typical observing frequencies of $tilde.op 1.4$~GHz these studies are limited by the Milky Way foreground, which imparts at least tens of nanoseconds of temporal broadening due to scattering for most lines of sight. Characterisation of (sub-)nanosecond FRB structure thus requires follow-up at higher radio frequencies ($gt.tilde 3$~GHz).

The narrow-band nature of repeaters @gourdji_2019_apjl has inspired searches that are better tuned to picking out FRBs in both the time and frequency dimensions. #cite(<kumar_2021_mnras>, form: "prose") used the Parkes Ultra-Wideband Low (UWL) receiver to discover a burst from FRB~20190711A whose spectral extent within the 0.7--4.0~GHz band was only 65~MHz. Simultaneous multi-band, multi-telescope observations have also demonstrated such behaviour @chawla_2020_apjl @majid_2020_apjl @pearlman_2020_apjl @pleunis_2021_apjl @pastormarazuela_2021_natur #cite(<levkov_2020_arxiv>, form: "prose") investigate periodic spectral structure in high-frequency data from FRB~20121102A~and discuss possible interpretations. FRBs also show the expected scintillation from the Milky Way ISM @schoen_2021_rnaas @marcote_2020_natur @hessels_2019_apjl.

Targeted observations of repeating FRBs have also expanded the range of radio frequencies over which FRBs have been detected, now from 110~MHz up to 8~GHz @pleunis_2021_apjl @pastormarazuela_2021_natur @chawla_2020_apjl @pilia_2020_apjl @majid_2020_apjl @michilli_2018_natur @gajjar_2018_apj. While the LOFAR detection of some bursts from FRB~20180916B shows 150-ms scattering at 110~MHz, the brightness of at least one burst at these low frequencies suggests that some FRBs may also be detectable below 100~MHz. Similarly, FRB emission is likely also to be detectable at frequencies $> 8$~GHz, but such searches are challenging because the small dispersive delay makes it more difficult to differentiate between astrophysical emission and human-made radio interference.

== Seeing them change in time <sec-time-evolution>

The detection of multiple bursts from repeaters allows properties like activity level, spectrum, DM, and RM to be measured as a function of time. The periodic activity level of the repeaters FRB~20180916B @chime_2020_natur_587 @pleunis_2021_apjl and FRB~20121102A~@rajwade_2020_mnras @cruces_2021_mnras is potentially an important insight into the nature of these sources (see #secref(<sec-system>)). The known gamma-ray binaries in the Milky Way @dubus_2013_aarv present a potential Galactic analogue; the recent discovery of a magnetar in such a system @yoneda_2020_phrvl adds weight to this possible link. Similarly, the 216.8-ms periodicity observed between sub-bursts in the one-off FRB~20191221A strongly suggests a neutron star link. At the same time, it is curious that only one out of hundreds of FRB sources has clearly shown this behaviour.

// [figvision] figures/Hilmarsson_2021_adapted.png
// Main panel: a scatter plot of rotation measure versus time. X-axis: MJD, spanning about 57750 to 58900 with
// ticks every 200 from 57800. Left axis: RM_obs in units of 10^5 rad m^-2, about 0.65 to 1.13, ticked at 0.7 to
// 1.1; the right axis gives source-frame RM_src, ticked 1.01, 1.15, 1.3, 1.44, 1.58. Dotted vertical lines with
// rotated labels mark the 2017, 2018, 2019 and 2020 year boundaries. A boxed legend lists red diamonds (AO),
// blue circles (EFF), gray squares (GBT) and orange stars (VLA). Data: a black-edged diamond plus red diamond
// near MJD 57780 at RM_obs about 1.03; a gray GBT square at MJD 58005, 0.937; an orange VLA star at MJD 58035,
// 0.866; a cluster at MJD 58230 to 58245 spanning 0.69 to 0.735 containing one blue EFF circle at 0.72; and
// diamonds around MJD 58685 to 58700 at 0.67 to 0.70, two of them black-edged. Overall the measurements decline
// by roughly a third over three years, with the drop steepest between 2017 and 2018; no error bars are visible.
// Inset: a smaller scatter plot embedded in the upper middle of the main panel, zooming on the 2018 cluster.
// X-axis MJD 58210 to 58250, ticked every 10; Y-axis RM_obs (10^5 rad m^-2) from 0.69 to 0.74, ticked every
// 0.01. Red diamonds sit at about MJD 58220 (0.708), 58226 (0.721), 58231 to 58232 (0.721 and 0.720), 58242 to
// 58243 (0.735 and 0.734), 58246 to 58247 (0.713 and 0.712) and 58250 (0.689); a single blue EFF circle lies at
// MJD 58233, 0.723. Values rise to a maximum near 0.735 then fall sharply to 0.689 within days, illustrating the
// 100 to 1000 rad m^-2 short-timescale fluctuations superposed on the secular decline.
#figure(placement: top, 
  image("figures/Hilmarsson_2021_adapted.png", width: 100%),
  caption: [
    Observed (left axis) and source frame (right axis) rotation measures of bursts from FRB~20121102A, as a function of time. The source has shown both a general decrease of $tilde.op 35000$~$"rad m"^(-2)$, over the course of 3 years, as well as smaller 100--1000~$"rad m"^(-2)$ variations on timescales of days to weeks (see, e.g., inset). Figure from #cite(<hilmarsson_2021_apjl>, form: "prose").
  ]
) <fig-rm-variations>

DM and RM variations have been seen from the original repeater, FRB~20121102A~@hessels_2019_apjl. In an 8-yr span (2012--2020), the DM has increased from $557$~$"cm"^(-3)$~pc to $564$~$"cm"^(-3)$~pc @spitler_2016_natur @hessels_2019_apjl @hilmarsson_2021_apjl. This increase is most likely associated with the local burst environment. Unfortunately, the local DM contribution is not well known, but it is very likely $< 100$~$"cm"^(-3)$~pc, meaning that the observed fractional DM change is enormous compared to what is typically seen from Galactic pulsars (where $Delta$DM is typically $tilde.op 10^(-3)$~$"cm"^(-3)$~pc~$"yr"^(-1)$). In contrast, From 2017--2020, the absolute RM has decreased from $-103 thin 000$~$"rad m"^(-2)$ to $-67 thin 000$~$"rad m"^(-2)$ @hilmarsson_2021_apjl[note that in the source frame this corresponds to $-148 thin 000$~$"rad m"^(-2)$ to $-96 thin 000$~$"rad m"^(-2)$]. FRB~20121102A~has also shown RM variations of 100s to 1000s of $"rad m"^(-2)$ on timescales of days to weeks @michilli_2018_natur. Other repeaters have also shown such short-timescale RM variations at a similar magnitude @luo_2020_natur @xu_2021_arxiv, while others have been considerably more stable, showing only subtle RM variations. Foreground and host galaxy ISM contributions are comparatively small, and hence such changes directly map variations in the local environment.

== Seeing them at other wavelengths <sec-other-wavelengths>

Despite being, until recently, the closest-known extragalactic FRB source, FRB~20180916B shows no evidence for prompt or persistent optical or high-energy X-ray or gamma-ray emission @scholz_2020_apj @pilia_2020_apjl. At 3.6~Mpc, FRB~20200120E provides the best opportunity yet for multi-wavelength detections, but no such emission has yet been found @kirsten_2021_arxiv @mereghetti_2021_apjl[these limits rule out giant flares that might be expected from a young hyper-active magnetar].

// [figvision] figures/LC_radio_X_03.png
// Single-panel light curve. X axis: seconds from 2020-04-28 14:34:24 UTC, about 0.36-0.65, labelled every 0.05;
// y axis: counts ms⁻¹, 0-27. Blue step histogram with error bars, labelled X-RAYS: the INTEGRAL burst is near
// 1-2 counts ms⁻¹ before 0.40 s, climbs to about 7, has a local peak near 12 at 0.425 s, dips, then the main
// peak of about 23 at 0.455 s, a secondary bump near 16 at 0.50 s, decaying to 1-4 after 0.53 s. Red RADIO trace
// (CHIME peaks, zero baseline elsewhere): narrow spikes near 17 at 0.42 s and 25 at 0.454 s, each leading its
// X-ray counterpart by a few milliseconds. Upper left: adapted from Mereghetti et al., ApJ 898, L29 (2020);
// upper right: SGR 1935+2154, 28 April 2020 burst.
#figure(placement: top, 
  image("figures/LC_radio_X_03.png", width: 100%),
  caption: [
    Hard X-ray burst detected from SGR~1935+2154 using #emph[INTEGRAL]. Peaks 1 and 2 roughly align with the two radio peaks seen from the CHIME/FRB detection @chime_2020_natur_587, though there is a lag of a few milliseconds. Figure courtesy S.~Mereghetti, adapted from #cite(<mereghetti_2020_apjl>, form: "prose").
  ]
) <fig-sgr-xray>

SGR~1935+2154 provides arguably the most interesting multi-wavelength information to date. INTEGRAL observations in the hard X-ray band (20--200~keV) show a burst#footnote[A number of other high-energy telescopes also detected this burst.] lasting for $tilde.op 0.6$~s, and superimposed on this broad feature are three narrow ($tilde.op 3$~ms) peaks separated by $tilde.op 29$~ms. Two of the narrow peaks match with radio bursts seen in the CHIME/FRB 400--800~MHz and STARE2 (1.4~GHz) bands, but with a delay of $6.5 plus.minus 1.0$~ms from the radio bursts @mereghetti_2020_apjl.

= Observational constraints on theory <sec-theory>

Prior to PHL19, the number of known FRBs and theories for their origins grew roughly at the same pace. Now, with the much larger sample, and more well-studied sources, observations can begin to better constrain theoretical models for FRB progenitor systems and emission. In the following subsections we discuss how measurements of the burst properties, host and local environments, and overall population statistics can constrain current models for radiation mechanisms and progenitors.

== Constraining the radiation mechanism <sec-radiation-mechanism>

While FRB emission is widely accepted to be generated in a coherent process, the exact radiation mechanism is the subject of debate. Most models center around an energetic neutron star or magnetar progenitor but place the location of emission at different radial distances from the surface of the star (#figref(<fig-emission-region>)). In some models the FRB is generated by reconnection in the neutron star magnetosphere @lyutikov_2020_arxiv @lyutikov_2021_apj or via coherent curvature radiation near the neutron star surface @kumar_2017_mnras; in both cases, the site of emission is at a radial distance of $lt.tilde 10^4$~km. In other models the FRB is generated via synchrotron maser emission in the forward shock of a propagating flare from the magnetar as it collides with the surrounding medium at radial distances of $gt.tilde 10^5$~km.

It is difficult to differentiate between these models based on most observed properties of FRBs, as both flavors of model have been able to explain most observations to-date with relative comfort. However, recent observations of microstructure within FRB pulses, on timescales $lt.tilde 10$~µs (see #secref(<sec-fine-detail>)) may rule out mechanisms where FRBs are generated at large radii from the central neutron star @majid_2021_apjl @nimmo_2021_arxiv_arxiv210511446 @nimmo_2021_natas. The minimum timescale for emission is constrained as

$ Delta t = (R zeta^2) / (2 c Gamma^2) $ <eq-min-timescale>

where $R$ is the radial distance from the central object, $zeta$ is the radiative efficiency, and $Gamma$ is the Lorentz factor @beniamini_2020_mnras. A conservative estimation of the Lorentz factor $Gamma tilde.op 10$ @beniamini_2020_mnras @waxman_2017_apj, $zeta lt.double 1$, and $R tilde.op 10^5$~km give $Delta t$ $tilde.op 10$~µs. Variability on shorter timescales than this would be difficult to explain for a model where the FRB is produced at large radii from the compact object. More observations of sub-microsecond structure in FRBs could differentiate between radiation mechanism models.

Similarly, the observed sub-pulse periodicity of FRB~20191221A from the CHIME/FRB sample, and two further bursts with tentative periodicity, provides additional support to a magnetospheric origin of FRB emission as strict periodicity between many sub-bursts is more difficult to achieve with propagating shocks @chime_2021_arxiv_arxiv210708463 Sub-burst periodicity has already been observed in a Galactic magnetar by #cite(<levin_2019_mnras>, form: "prose"). Additionally, #cite(<wadiasingh_2020_apjl>, form: "prose") have proposed that quasi-periodic oscillations of the neutron star crust could manifest as periodic separation between FRB sub-bursts on millisecond timescales. Future observations of burst trains may provide more detailed information about this phenomenon.

Further constraints on the radiative mechanism may be possible with the detection of individual FRB pulses over a decade or more in radio frequency. While bursts from FRB~20180916B have been seen from 110~MHz to 1.7~GHz @pleunis_2021_apjl @nimmo_2021_natas, no bursts have been seen simultaneously across a wide frequency range despite commensal searches at low and high radio frequencies @chawla_2020_apjl @pearlman_2020_apjl @pleunis_2021_apjl @pastormarazuela_2021_natur Dual-band (2.4~GHz and 8.3~GHz) observations of FRB~20121102A~have also found the bursts to be narrow band @majid_2020_apjl. The total emitted energy of FRBs, or rate of observed bursts above a nominal fluence threshold at low and high frequencies would provide a further useful discriminator between emission models. Most dual-frequency studies of FRBs to-date have been conducted on repeaters, but non-repeaters may ultimately prove more promising as the one-off population appears more broadband than the CHIME/FRB repeater sample @pleunis_2021_apj.

// [figvision] figures/Lu_alfven_waves.png
// (a) This is a schematic diagram showing the shock model of FRB emission. The central object, likely a neutron
// star or black hole, is depicted as a gray sphere with a green dotted line indicating a specific radius. Black
// lines emanating from the central object represent magnetic field lines. The diagram shows the layout of
// various components: thermal soft X-rays (red and yellow), Comptonized hard X-rays (blue), Alfvén waves (teal),
// charge starvation (orange), and the FRB emission (orange arrows). The objects are connected in a sequence from
// the central engine to the FRB emission. The trend suggests that the FRB is produced at large radii due to
// interactions between the central engine's emissions and the surrounding medium. (b) This is a schematic
// diagram showing the magnetospheric model of FRB emission. There is no plot or micrograph. The axes are not
// labeled, and there are no units. The diagram depicts a neutron star with its magnetosphere, where the FRB is
// produced. The layout shows the neutron star and its magnetic field lines, with the FRB emission occurring
// within the magnetosphere. The trend or message is that the FRB is produced in the neutron star's
// magnetosphere, implying a different emission mechanism compared to the shock model.
// [figvision] figures/cartoon_v3.png
// Panel a schematizes the shock model. A grey engine disc with spin axis Ω upward emits a relativistic flare of
// duration Δ ∼ cδt, driving a rightward shock train: orange reverse shock, contact discontinuity, then green ion
// shell with forward shock at radius r(t); density n_ext ∝ r^(−k) fades into a wind, n ∝ r^(−2), expanding at
// v_w across width v_wΔT to shock R_s; termination shock R_t bounds the yellow nebula (persistent radio,
// rotation measure RM), then blue SN ejecta out to R_ej moving at v_ej. A red sinusoid, the FRB, with E ⟂ k and
// B into the page (polarization label), suffers induced scattering and dispersion for ν < ν_max and escapes with
// ν ≥ ν_max; a purple sinusoid traces the γ-ray/x-ray afterglow; magnetization σ ∼ 0.1–1 spans shell to nebula.
#figure(placement: top, [#box(image("figures/cartoon_v3.png", width: 65.0%)) #box(image("figures/Lu_alfven_waves.png", width: 30.0%))
// [figvision] figures/Lu_alfven_waves.png
// Single panel a, a schematic of fast radio burst emission in a neutron star magnetosphere. A shaded grey sphere
// at centre is the neutron star, surrounded by black dipole magnetic field lines, open field lines fanning up
// top and bottom, and closed loops to the left. On the star's upper right, a small red-hot patch marks a crustal
// flare; green dashed nested ovals show field-line footprints anchored near it. Red squiggly arrows labelled
// "thermal soft X-rays" leave the patch, and blue squiggly arrows labelled "Comptonized hard X-rays" fill a blue
// glow around it. A teal wedge labeled "Alfvén waves" escapes along open field lines; within it a teal dashed
// arc marked "charge starvation" sits at radius, and above it two orange cone symbols show wave packets
// launching an orange bidirectional arrow labelled "FRB". Message: FRBs form where Alfvén flares from a magnetar
// surface reach charge-starved outer magnetosphere.
// Black lines curve outward from its poles to depict magnetic field lines. On the right side, red squiggly
// arrows labeled "thermal soft X-rays" emerge from the surface and scatter into a blue cloud labeled
// "Comptonized hard X-rays." Above this, a teal cone extends upward along the magnetic axis, labeled "Alfvén
// waves." Within this cone, orange zigzag lines represent the FRB signal, marked by an orange double-headed
// arrow at the top. A dashed blue line separates the wave region from a zone labeled "charge starvation,"
// indicating where particle density drops significantly. The overall layout shows energy propagating outward in
// distinct regions: thermal radiation near the star, scattered high-energy photons nearby, and coherent radio
// waves generated further out via plasma instabilities. Panel (b) is not present in the provided image; only
// panel (a) is shown. Therefore, no description can be given for panel (b). The caption references two models —
// shock (panel a) and magnetospheric (panel b) — but the visual content includes only the shock model schematic.
// Any attempt to describe panel (b) would require external knowledge beyond the image, which violates the
// instruction to reconstruct based solely on what is drawn. Thus, panel (b) remains unannotated here due to
// absence in the figure.

  ],
  caption: [
    Different models of FRB emission. (a) Shock model from #cite(<metzger_2019_mnras>, form: "prose") where the FRB is produced at large ($10^10$~cm) radii from the compact central engine (e.g., a magnetar or black hole). (b) Magnetospheric model from #cite(<lu_2020_mnras>, form: "prose") where the FRB is produced in the neutron star magnetosphere.
  ]
) <fig-emission-region>

== Constraining the progenitor <sec-progenitor>

Even more so than radiation mechanisms, the progenitor engines of FRBs are broadly debated in the literature. Most unique entries in the FRB Theory Catalogue#footnote[#link("https://frbtheorycat.org/index.php")] focus on the FRB progenitor @platts_2019_phr. These theories range broadly to encompass neutron star emission (both from isolated and binary systems), winds in ultra-luminous X-ray sources (ULXs), compact object mergers (neutron stars, white dwarfs, black holes), active galactic nuclei (AGN), and superconducting cosmic strings. See §~9 of PHL19 for more details on these models.

The strongest constraints on progenitors still come from the observed repetition of some FRBs @spitler_2016_natur, ruling out cataclysmic engines for these sources. Whether all FRBs repeat remains an open question @caleb_2019_mnras_484 @chime_2021_arxiv_arxiv210604352, but only a non-destructive process capable of producing bursts separated by seconds, minutes, and even years can explain repeaters. Repeating bursts also place lower limits on the total energy budget of the progenitor, which must be capable of powering all observed pulses, and potentially also additional pulses if emission is beamed and not always aligned towards the observer on Earth. The strongest constraints come from the longest-lived active source seen to date, FRB~20121102A. #cite(<margalit_2020_mnras>, form: "prose") estimate a total energy budget of $10^47$--$10^49$~erg for this source which they note is consistent with the magnetic energy reservoir of a magnetar; however, this number may change with the large samples of pulses from this source observed by the FAST and Arecibo telescopes @li_2021_natur @aggarwal_2021_apj @hewitt_2021_arxiv. More active repeaters, sources with larger burst energies, and longer monitoring of currently active repeaters could place further constraints on this reservoir through future observations, as could observations of fading or quiescence in currently active sources.

Now that a small subset of FRBs have been precisely localised to host galaxies (see #secref(<sec-observations>)), the properties of the FRB hosts can also be compared to other known populations of astrophysical transients and populations. Thus far, FRB distributions have been found to be inconsistent with long gamma-ray burst (GRB) offsets @heintz_2020_apj @mannings_2021_apj, and host galaxy stellar mass and star formation rates are for the most part inconsistent with channels such as hydrogen-poor superluminous supernovae @bochenek_2021_apjl. However, the FRB population remains consistent with being powered by magnetars formed in core-collapse supernovae (CCSNe) --- with the notable exception of FRB~20200120E, which was localised to a globular cluster by #cite(<kirsten_2021_arxiv>, form: "prose"). Further host galaxy studies may also compare the FRB source positions and host galaxy metallicities to those of ULXs, which tend to reside near (but not necessarily within) young stellar clusters in low metallicity hosts.

In the future, a direct association of an FRB event and another astrophysical transient would provide a conclusive link between their progenitors. Further insights into the FRB progenitor(s) could come from a larger sample of host galaxies, which might reveal sub-classes of FRBs associated with specific host types, or conclusive evidence that the FRB progenitor population evolves over cosmological time --- e.g., following the star formation rate or other host galaxy properties (metallicity, galaxy mass, etc.).

== Constraining the system <sec-system>

Since the discovery of periodic activity from FRB~20180916B, and likely periodicity in FRB~20121102A, more theories have focused on binary progenitor systems. Early cataclysmic theories also suggested mergers of compact objects; however, theories of persistent binary systems have risen in popularity. The periodicity could be induced by binary motion, rotation, or precession @levin_2020_apjl. In the case of a binary model, it could be that interaction between two orbiting bodies is a prerequisite for producing bursts @levin_2020_apjl @zhang_2017_apjl, though it has also been proposed that the modulation in activity level is due to absorption by intra-binary plasma. It has been shown that binary interaction dominates the evolution of massive stars @lyutikov_2020_apjl @sana_2012_sci, and if the burst engine of FRB~20180916B and FRB~20121102A is indeed a young magnetar then it would not be surprising to find such a source in an eccentric orbit with a massive (e.g. OB) stellar companion.

// [figvision] figures/Zhang_periodic_FRB.png
// a: A schematic on a dark navy background showing a binary system. At top centre sits a large glowing
// white-blue sphere labelled "Companion". Thin golden lines radiate outward through the panel, labelled
// "Companion's stellar wind", with small gold arrowheads pointing inward along the rays toward the neutron star
// below. A large white dashed circle, tagged "Orbit" by a short white leader line, encircles the companion, with
// a white arrowhead on its right limb marking the orbital direction clockwise as drawn. At the lowest point of
// this dashed orbit rests a smaller glowing white-blue sphere labelled "Neutron star". From it a fan of pale
// blue streaks spreads downward, labelled "Neutron star's wind", with blue arrows pointing down and outward. A
// wavy white arrow beneath the fan leads to the word "FRB", indicating bursts emitted along this direction each
// time the neutron star passes the conjunction. b: A second schematic on the same dark navy background
// illustrating a precessing isolated pulsar. At top sits a large glowing white-blue sphere labelled "Neutron
// star". From its lower hemisphere a translucent white conical beam extends downward, broadening slightly with
// distance. Near its lower end, a white dashed tilted ellipse, labelled "Precession orbit of beam", wraps around
// the beam axis; a white arrowhead on the ellipse traces the sense of precession, and a compact bright glow
// marks where the beam intersects the ring. From that glowing point a wavy white arrow points downward to the
// label "FRB", conveying that slow precession sweeps the beam periodically past our line of sight. The panel
// letters "a" and "b" appear as bold white characters in the upper-left corners, and a grey "©nature" watermark
// sits at the bottom right.
#figure(placement: top, 
  image("figures/Zhang_periodic_FRB.png", width: 90.0%),
  caption: [
    A diagram illustrating two systems that could produce periodic emission from FRBs, including (a) a neutron star and a binary companion, and (b) a precessing isolated neutron star. Figure from #cite(<zhang_2020_natur>, form: "prose").
  ]
) <fig-zhang-periodicity>

Constraints on the configuration of a binary system producing FRBs can be placed in a number of ways. The observation of wider and later peaks in the activity window at lower radio frequencies @pleunis_2021_apjl @pastormarazuela_2021_natur constrains simple binary wind models such that the periodicity might not arise from occultation of the emission by a wind. #cite(<wada_2021_apj>, form: "prose") argue that these constraints can be accommodated in a binary wind model. Some binary models such as #cite(<sridhar_2021_apj>, form: "prose") predict that FRB emission will shut off on timescales of years to decades due to the ULX binary becoming too tight. This model also predicts a luminous red nova in the years after the FRB emission shuts off, when the two stars merge.

Longer baselines of observations for highly active repeating FRBs may allow for FRB timing, either through periodic pulse arrival times (not yet observed for any repeating FRB), or evolution of periodic activity windows like those seen for FRB~20180916B. Long-term timing of these systems could shed more light on the nature of a binary system, analogous to @lorimer_2012_hpa pulsar timing experiments. Additionally, precise localisation of nearby repeaters could enable the identification of an optical stellar companion through deep imaging. In this case, a direct measurement of the binary companion and nature of the system would be possible; however, this would only be feasible for the very nearest FRBs. Deeper imaging of the globular cluster containing FRB~20200120E (see #secref(<sec-hosts>)) could provide more information about the dynamic interactions and environment of this FRB source.

== Constraining the environment <sec-environment>

Current FRB observations have already put direct constraints on the local environments of known repeating and one-off FRBs. Even for poorly localised sources, the RM excess of an FRB relative to the Galactic foreground can indicate a clean environment in the case of no excess, or a highly magnetised and highly ionised local environment in the case of high RM values. The canonical example is FRB~20121102A~(see §~5.4 of PHL19), however more than 10 FRBs have now been identified with significant RM excess. These sources indicate that substantial magneto-ionic material local to the source is relatively common for FRBs, even for those that have not been seen to repeat.

In the case of FRB~20121102A, the presence of a compact persistent radio source co-located with the FRB has also informed studies of the local environment @chatterjee_2017_natur @marcote_2017_apjl @tendulkar_2017_apjl @bassa_2017_apjl. The extremely high RM of the bursts has been attributed to this local radio source, hypothesised to be a nebula or accreting massive black hole (see §~5.4 of PHL19). Persistent radio sources associated with other FRBs may indicate similarly extreme environments. Only two other FRB sources have been found to be coincident with persistent radio sources, the repeaters FRB~20201124A and FRB~20190520B. In the case of FRB~20201124A, #cite(<fong_2021_apjl>, form: "prose") and #cite(<ravi_2021_arxiv>, form: "prose") attribute the radio emission to ongoing star formation, likely in the circumnuclear region, later confirmed by #cite(<piro_2021_aa>, form: "prose"). Observations of an FRB's direct environment require precise localisation, preferably to sub-arcsecond precision so as to identify the local environment within the host as has been done for several FRBs from ASKAP @bhandari_2020_apjl_895, as well as for FRBs~20180916B, 20200120E, and 20201124A @tendulkar_2021_apjl @kirsten_2021_arxiv @nimmo_2021_arxiv_arxiv211101600.

In the absence of localisation, radio observations of FRB pulses themselves still have incredible power to probe the local FRB environment. Observations at low radio frequencies ($tilde.op 100$~MHz) can put direct upper limits on the density of the local environment by constraining absorption in the local ionised medium @pleunis_2021_apjl @pastormarazuela_2021_natur.

Long-term monitoring of variations in DM, RM and scattering for repeating FRBs can also place constraints on the local magneto-ionic material in the FRB progenitor environment (see #secref(<sec-time-evolution>)). Significant variations in these parameters correspond to the transverse movement or dissipation of filaments, perhaps in a nebula or ionised wind. The classic example is FRB~20121102A~@hilmarsson_2021_apjl, although even smaller order variations are constraining @luo_2020_natur @pleunis_2021_apjl.

== Constraining the population <sec-population>

With a sample of hundreds to thousands of FRBs, we can also constrain the population properties of the sources and their distribution over cosmic distance. Thus far only the CHIME/FRB Catalogue sample has been of sufficient size for the purpose of studying distribution in DM, duration and scattering @Chawla_2021_arXiv, but the imprecise localisations and redshifts of the sample make studies of the intrinsic spatial distribution challenging.

Until a large sample of localised FRBs is available, population synthesis studies can model the FRB population and its distribution under a variety of assumptions such as if FRBs were to trace the star formation rate (SFR) history of the Universe. Population synthesis can also attempt to convolve these modeled populations with instrumental effects from telescopes, to estimate what the observed population distributions would look like over DM, pulse width, scattering, and fluence @gardenier_2019_aa @james_2022_mnras_1.

A recent population synthesis on a small sample of Parkes and ASKAP bursts suggests that the population evolves with SFR @james_2022_mnras_2. In their study, however, #cite(<zhang_2021_mnras>, form: "prose") cannot distinguish between a SFR model from one in which the population tracks compact binary mergers. Future studies with a larger and more precise sample could be used in turn to probe cosmic star formation. Additionally, population synthesis efforts that take into account properties of repeaters and apparent non-repeaters provide predictive models, for example: the fraction of sources seen to repeat as a function of time @gardenier_2021_aa. If repeating sources represent a separate sub-class of FRB progenitors, then the repeater fraction may plateau or decrease over time as the total number of FRBs increases (#figref(<fig-frbpoppy>)).

// [figvision] figures/rep_frac_perfect.png
// Panel a (left): A histogram showing input distributions of Poisson repeat rates, x-axis "Poisson Rate (day−1)"
// spanning 0 to about 0.55 with ticks at 0.0, 0.2, 0.4; y-axis "Fraction" from 0.0 to 1.0 in steps of 0.2. A
// legend titled Populations lists three series: blue "rep", orange "dist", green "mix". Blue and green overlap
// as identical spikes: narrow steps at 0 (fraction 0.5) and near 0.1 (fraction 1.0), forming a two-block
// distribution. Orange is a broad, right-skewed step histogram peaking near 0.05–0.07 at fraction about 0.09 and
// decaying continuously toward zero by 0.35 day−1. Message: the "dist" model gives sources a spread of repeat
// rates while others concentrate at fixed rates. Panel b (right): Line plot of the detected repeater fraction
// f_rep versus "Time (days)", x-axis 0 to 100 in steps of 20; y-axis logarithmic from 10−1 to 100 (10−1, 2×10−1,
// 3×10−1, 4×10−1, 6×10−1, 10−1... to 100). Same colour coding: blue "rep" rises steeply, reaching approximately
// 0.97–0.98 by 40–50 days and flattening; orange "dist" rises slightly faster initially, crossing blue near
// 10–15 days at about 0.75, then asymptotes just below blue at roughly 0.95 by 100 days; green "mix" rises more
// slowly, peaks near 0.56 at about 30 days, then declines gradually to about 0.35 at 100 days. Message: a
// distribution of repeat rates recovers most repeaters, while a mixed repeating/non-repeating population peaks
// and declines as one-off FRBs dilute the sample.
#figure(placement: top, 
  image("figures/rep_frac_perfect.png", width: 90.0%),
  caption: [
    Fraction of FRBs observed as repeaters (right) using the `frbpoppy` population synthesis code for various assumed intrinsic populations (left). For assumptions of a distribution of repeat rates, a 100% repeating population, and a mix of repeating and non-repeating FRBs, the fractional number of FRBs detected by telescopes as repeaters as a function of time will change and eventually asymptote or turn over. Modified from #cite(<gardenier_2021_aa>, form: "prose"), courtesy of J. van Leeuwen.
  ]
) <fig-frbpoppy>

Thus far, population synthesis methods have had limited ability to distinguish between progenitor models of FRBs. #cite(<james_2022_mnras_2>, form: "prose") have noted that their models are consistent with a population arising from magnetar bursts. However, conclusively ruling out progenitor classes based on population synthesis will likely have to wait until the observed sample being compared to models is of sufficient size to be robust, requiring hundreds and perhaps thousands of FRBs.

== What can we learn from SGR~1935+2154 and other known magnetars? <sec-magnetars>

The recent discovery of a MJy-ms radio burst from the Galactic magnetar SGR~1935+2154 (#secref(<sec-hosts>)) has given us potential new ways to explore the FRB---magnetar connection. Observations suggest that a bright SGR flare (such as might be seen from another galaxy as an FRB) might also be followed by several bursts, orders of magnitude weaker in fluence, in the days and weeks following the initial flare. @kirsten_2021_natas. Such bursts were seen in the case of SGR~1935+2154. Follow-up of nearby, bright FRBs of fluence $gt.tilde 10$ Jy-ms with sensitive telescopes like FAST, GBT, or (in the future) CHORD or the SKA, could detect these lower fluence aftershocks. Hard X-ray flares coincident with (or slightly lagging) radio-detected FRBs might also prove telling (See #figref(<fig-sgr-xray>)). Such follow-up is already ongoing with the nearest reported FRB~20200120E in M81 @bhardwaj_2021_apjl_910. Similarly, searches for FRBs with spectra similar to that of the radio burst from SGR~1935+2154, seen by CHIME/FRB to be double-peaked and perhaps upward drifting in frequency, could lead to further insights.

Recent studies of the short gamma-ray burst population suggest that a handful of these sources with particularly hard X-ray spectra post-burst are actually from extragalactic magnetar progenitors, and may be extragalactic versions of the 'giant flares' that have been seen from some Galactic magnetars @roberts_2021_natur @svinkin_2021_natur. These results, while as yet unrelated to FRBs, provide direct evidence for highly energetic, observable behaviour from distant magnetars. Searches for similar X-ray emission following radio bursts might also provide insight into any relationship between FRBs and magnetars.

Precise localisation of a larger number of FRBs will also help in this area, as milliarcsecond precision can help identify not only the source location in the host galaxy but also potentially associate it with a star forming region or other interesting area such as a globular cluster or H#smallcaps[ii] region when radio interferometric localization is combined with deep optical imaging. In the most nearby cases, it may even be possible to find FRBs co-located with a bright companion star through sensitive imaging with #emph[Hubble], #emph[James Webb Space Telescope], or ground-based optical instruments using adaptive optics.

Ultimately, if an FRB---magnetar connection exists, it may be necessary to find a handful of 'bridging sources' that bring together traditional FRB observations (radio bursts, repetition, polarisation) with recent developments in magnetar science (X-ray spectrum, flaring behaviour).

== What questions can we answer with future observations? <sec-open-questions>

At present, FRB observations constrain theoretical models, but no 'smoking guns' exist to conclusively support specific progenitor theories. As the FRB population grows and observations of the larger FRB phenomenon emerge, the discovery of a few main properties may prove to be particularly impactful, particularly related to each of the topics addressed in this section.

#emph[Emission physics]: What is the shortest-timescale structure in FRB bursts? Do many repeating FRBs have observable position angle (PA) swings that vary, either over a single burst or over an entire activity window? How do the polarimetric properties change with frequency, and is this due to intrinsic or extrinsic reasons?

#emph[Progenitors]: Does the FRB population evolve with star formation rate?

#emph[Progenitor systems]: Do all repeating FRBs vary in their activity in a periodic way? Do different repeat activity windows correspond to different binary system configurations?

#emph[Environment]: Are high RMs associated with persistent radio sources? Do the RMs of all repeaters vary over time?

#emph[FRB---magnetar connection]: Are FRB hosts and FRB locations in host galaxies consistent with magnetar distributions? Do other Galactic magnetars, besides SGR~1935+2154, also exhibit FRB-like emission?

= FRBs as astrophysical and cosmological probes <sec-probes>

Even though we do not currently fully understand the source populations and mechanisms for FRBs, as is the case for pulsars, we can use them as powerful astrophysical probes. We now briefly review some of their key uses, and look ahead to what might be possible in the future. Further details can be found in an extensive review on this topic by #cite(<bhandari_2021_univ>, form: "prose"). A recurring theme in the items below, and an area of intense ongoing study, is the DM distribution of FRBs (after accounting for observational biases). In particular, we would like to establish the true distribution in DM, and the prospects for probing this with current and emerging facilities. Recent studies on the DM distribution have been carried out by #cite(<walker_2020_aa>, form: "prose"), #cite(<arcus_2021_mnras>, form: "prose") and #cite(<james_2022_mnras_1>, form: "prose").

== Finding the missing baryons: The Macquart Relationship <sec-macquart>

The exciting potential of a population of radio bursts at cosmological distances as probes of the ionised intergalactic medium was originally predicted prior to FRBs by #cite(<ginzburg_1973_natur>, form: "prose") and later noted in the final sentences of the FRB discovery paper. An important application of such a population is to carry out a census of baryons in the Universe, primarily at $z < 2$ where a budget from a variety of sources only accounts for about half of the total expected. As has been subsequently developed, and described in detail in PHL19, by subtracting both the expected Milky Way contribution ($⟨"DM"_"MW"⟩$) for a given line of sight and the contribution from the host galaxy ($⟨"DM"_"host"⟩$), each FRB provides a measurement of the electron content from the intergalactic medium along a given line of sight,

$ "DM"_"IGM" = "DM"_"obs" - "DM"_"MW" - frac("DM"_"host", 1 + z) $ <eq-dmcosmic>

Adopting standard cosmological models @deng_2014_apjl @zhou_2014_phrvd, the average value of intergalactic dispersion measure

$ ⟨"DM"_"IGM"⟩ = Omega_b frac(3 H_0 c, 8 pi G m_p) integral_0^z frac((1 + z') f_"IGM" [3/4 X_("e,H")(z') + 1/8 X_("e,He")(z')], [Omega_"M" (1 + z')^3 + Omega_Lambda (1 + z')^(3[1 + w(z')])]^(1/2)) dif z' $ <eq-dmigm>

where $w$ is a dark energy equation of state parameter; and $Omega_b$, $Omega_"M"$ and $Omega_Lambda$ are the baryonic, matter and dark energy densities, respectively, relative to the critical density, $rho_c = (3 c^2 H_0^2)/(8 pi G)$. $f_"IGM"$ is the fraction of baryons produced in the Big Bang that remain in the IGM and $X_("e,H")$ and $X_("e,He")$ are, respectively, the ionisation fractions of hydrogen and helium.

The fundamental feature of the above expression is that $Omega_b$ serves as the constant of proportionality between the intergalactic medium DM and the FRB redshift. Adopting nominal values of these parameters, we find that $⟨"DM"_"IGM"⟩ ≃ 1000 f_"IGM" z$ for $z < 1$, and $⟨"DM"_"IGM"⟩ ≃ 850 z$ if a typical $f_"IGM"$ is adopted @zhang_2018_apjl. This relationship is shown alongside the observed DM values and redshifts for 14 of the FRBs currently associated with host galaxies in #figref(<fig-dmz>) The figure also shows the excess DM provided by the $⟨"DM"_"MW"⟩$ and $⟨"DM"_"host"⟩$ terms in #eqref(<eq-dmcosmic>) Though there are exceptions where the host and local environment contribution is large, the DMs of FRBs clearly track the expected relationship. A more detailed analysis on a smaller sample by #cite(<macquart_2020_natur>, form: "prose") was the first demonstration that FRBs probe the baryonic material in the IGM. In recognition of the pioneering work by the late J-P Macquart, who led the team that demonstrated this result, the DM--$z$ relation is now known as the Macquart Relation.

// [figvision] figures/fig_dmz_190520.png
// A single scatter plot shows host galaxy redshift z (0 to ~0.7, both vertical axes) versus dispersion measure
// in pc cm⁻³; the x-axis runs mirrored, from 300 through 0 on the left to 1200 on the right, with a vertical
// dotted line at DM=0 splitting Galactic contributions (left) from extragalactic excess (right). On the left,
// green filled circles with green lines crossing to 0 are the MW disk DM contributions, paired with blue
// horizontal error bars marking the MW halo DM, drawn as horizontal stacks at each of the 14 redshifts. On the
// right, dark red open circles (one-off FRBs) and filled squares (repeaters) plot excess DM with horizontal
// error bars. An orange straight line running from near (0, 0.05) up to about (650, 0.7), flanked by a broad
// light-orange shaded wedge, shows the expected DM–z relation with its 1σ range. A horizontal pink dashed line
// labelled FRB190520B excess extends from near (345, 0.24) to a repeater point near (1100, 0.24); the outlier at
// roughly (160, 0.036) is labelled FRB121102. Legend at lower right lists DM–z, MW disk, MW halo, One-offs,
// Repeaters; arrows labelled Galactic left and Extragalactic right appear above and below the dotted divider.
// Most extragalactic points track the DM–z trend.
#figure(placement: top, 
  image("figures/fig_dmz_190520.png", width: 100%),
  caption: [
    Host redshift as a function of dispersion measure (DM) for the current sample of 14 FRBs with redshift measurements. In this split-panel display, adapted from #cite(<niu_2021_arxiv>, form: "prose"), the Galactic DM contributions from the disk and the halo are shown on the left, while the remaining excess DMs are displayed in the main panel on the right. The shaded region shows the 1-$sigma$ range around the expected relation based on #eqref(<eq-dmigm>) The recent discovery of FRB~20190520B is shown as a clear outlier to this trend and indicates a significant contribution to the DM excess from the host galaxy and local environment @niu_2021_arxiv Figure kindly provided by S.~Chatterjee.
  ]
) <fig-dmz>

Going beyond the simple proportionality in the DM--$z$ plane, the observed variance contains important information about the baryonic halos of galaxies along the line of sight, which are governed by feedback processes from the galaxies themselves. As originally shown by #cite(<mcquinn_2014_apjl>, form: "prose"), from a sample of around 100 well-localised and redshift-identified FRBs, it should be possible to distinguish between different baryonic matter halo distributions in a way that is currently impossible to do by other means. For galaxies with predominantly extended baryonic halos, as shown in #figref(<fig-dms>) the DM distribution of FRBs becomes more Gaussian-like than for the case where galaxy halos are more compact, which leads to a more skewed distribution with a tail at high DMs. As demonstrated recently by #cite(<walters_2019_phrvd>, form: "prose"), a sample of around 100 FRBs with well-determined redshifts could constrain the diffuse gas fraction to the few percent level.

Another property of the missing baryons is their temperature, and how they probe the so-called 'warm hot intergalactic medium' (WHIM). #cite(<munoz_2018_phrvd>, form: "prose") showed through simulations of mock FRB samples that this is possible in combination with maps of the thermal Sunyaev-Zeldovich effect. The authors forecast that a measurement of the WHIM temperature would be possible at the 10% level with samples of $10^4$~FRBs and could definitively link the missing baryons with the WHIM.

// [figvision] figures/Cartoon.png
// This panel is a schematic diagram illustrating the effect of compact galaxy halos on dark matter distribution.
// The plot area contains numerous overlapping, semi-transparent blue circles representing these compact halos
// scattered across the background. Several solid colored lines in red, orange, pink, brown, yellow, green, cyan,
// and blue traverse the frame at various angles, representing randomized lines of sight. In the upper right
// corner, an inset histogram plots the number count N(DM) against DM. This histogram displays a distinct
// positive skew with a long tail extending to the right, indicating that the compact halo configuration results
// in a non-Gaussian distribution of observed dark matter values.
// [figvision] figures/Cartoon_puffier.png
// The main panel is a square schematic field of view framed by a thin black edge, with unnumbered tick marks
// along the left and bottom and a pale grey-violet background representing intergalactic space. Scattered
// through the field are dozens of translucent blue-violet discs of roughly equal radius, each representing a
// galaxy's compact baryonic halo; overlaps darken the colour. The discs cluster in the upper-left, centre and
// lower-left, while the upper-right and right-hand regions are comparatively empty. Roughly ten long straight
// solid lines coloured red, orange, olive-yellow, green, cyan, violet, brown, pink and grey cross edge to edge
// at arbitrary angles, depicting randomized lines of sight whose dispersion measure depends on how many halos
// each ray intersects. An inset box in the upper-right, a white rectangle with black border, shows the resulting
// distribution. Its vertical axis is labelled N(DM) in rotated text, the horizontal axis DM, both without
// numeric scales. A single solid steel-blue histogram of about fifteen bins rises steeply from left to a sharp
// peak slightly left of centre, roughly five times its base height, then declines in a gentler stepped staircase
// toward larger DM, forming a slightly right-skewed, near-normal bell shape.
#figure(placement: top, [#box(image("figures/Cartoon.png", width: 50.0%)) #box(image("figures/Cartoon_puffier.png", width: 50.0%))

// [figvision] figures/Cartoon.png
// The image shows a single panel, the compact-halo case of the caption. The main field is a schematic sky map on
// a pale lavender background, frame bordered with unlabelled tick marks (arbitrary units, no numbers). Roughly
// 70 semi-transparent purple circles of varying diameters, some overlapping, are scattered quasi-randomly across
// the field, representing compact baryonic halo clumps. About ten solid straight lines in distinct colours (dark
// blue, teal, green, olive, cyan, brown, pink, orange, red, grey, purple) cross the map at random angles and
// lengths; these are the randomized lines of sight, each threading between and through the circles. An inset in
// the upper right shows a histogram with x-axis labelled DM and rotated y-axis label N(DM), both in arbitrary
// units with unnumbered ticks: filled steel-blue bars rise steeply to a sharp peak near low DM, then step down
// in a staircase with a long right tail. The message is that sight lines through many compact clumps yield a
// strongly right-skewed DM distribution with a high-DM tail, unlike a normal distribution from extended halos.
  ],
  caption: [
    Schematic representation showing the dependence of the observed DM distribution on galaxy halo extent. The left panel shows a compact halo distribution, which leads to a tail in the DM distribution. The right panel shows the normal distribution, which is the result of more extended baryonic halos. The solid lines represent randomized lines of sight. Figure source: #cite(<bhandari_2021_univ>, form: "prose").
  ]
) <fig-dms>

== Cosmic rulers <sec-cosmic-rulers>

The dependence of $⟨"DM"_"IGM"⟩$ on various cosmological parameters seen in #eqref(<eq-dmcosmic>) highlights the value of a well-determined set of FRBs with redshift measurements in contributing to precision cosmology. Recently, using the sample of 9 FRBs from #cite(<macquart_2020_natur>, form: "prose"), #cite(<hagstotz_2021_arxiv>, form: "prose") use a likelihood analysis to measure $H_0 = 62 plus.minus 9$~$"km s"^(-1) "Mpc"^(-1)$. These authors forecast that a sample of 500 FRBs with redshift determinations expected to be available in the coming decade will be able to determine $H_0$ to a precision of a few per cent or better. Such a sample would provide an independent way to help resolve the current tension between the results obtained by $H_0$ analyses of the CMB @planckcollaboration_2020_aa and type Ia supernovae @riess_2019_apj. Similar predictions were also made prior to the #cite(<macquart_2020_natur>, form: "prose") sample by #cite(<wu_2020_apj>, form: "prose").

== Reionization history of the Universe <sec-reionization>

After recombination took place in the early Universe around redshift $z = 1089$, the intergalactic medium was fundamentally changed during the epoch of reionization as free electrons were liberated by ultraviolet radiation from stars and quasars in the redshift range $6 < z < 13$ for H#smallcaps[i] and He#smallcaps[i]. Due to the direct relationship between DM and electron density, cosmological FRBs offer new ways to probe these still poorly understood processes.

For hydrogen reionization, #cite(<beniamini_2021_mnras>, form: "prose") show that the maximum dispersion measure for an ensemble of FRBs ($⟨"DM"_"max"⟩$) can in principle be a powerful diagnostic of the IGM at high redshifts. They show that, for a sample of around 1000 FRBs with DMs above 6000~$"cm"^(-3)$~pc, a determination of $⟨"DM"_"max"⟩$ with a precision of better than 10% would provide tighter constraints on the reionization history than current measurements of CMB optical depth using Planck @pagano_2020_aa. For smaller samples of FRBs, which are more realisable with current and emerging facilities, #cite(<beniamini_2021_mnras>, form: "prose") estimate that useful constraints could be made from 40 FRBs in $6 < z < 10$ given redshift accuracies of 10%. In the absence of redshift information, any constraints on reionization at these epochs are strongly coupled to our (currently incomplete) knowledge of the FRB luminosity function.

While the Deep Synoptic Array @hallinan_2019_baas will allow for H#smallcaps[i] and He#smallcaps[i] reionization studies using high-redshift FRBs, in the near term, more progress is likely to be made for He#smallcaps[ii] reionization which is thought to have occurred at redshifts as low as $z = 3$ @fialkov_2016_jcap. In a recent study, #cite(<caleb_2019_mnras_485>, form: "prose") show that 1000--2000 FRBs are required to begin to probe the epoch of He#smallcaps[ii] reionization through their DM distribution. Further work on modeling the initial CHIME/FRB sample may well provide insights into this issue although the largest DM from that sample is 3038.06~$"cm"^(-3)$~pc.

== Cosmic turbulence and magnetism <sec-turbulence>

In addition to pulse dispersion, which probes the ionised intergalactic gas, a subset of FRBs with measurements or constraints on pulse scattering and Faraday rotation measure from polarimetry can be used to probe both the turbulent and magnetised nature of the intervening medium. As recently demonstrated by #cite(<xu_2020_apjl>, form: "prose"), the FRB sample is now beginning to be large enough to make meaningful statements on intergalactic turbulence. From a measurement of the structure function of DMs based on a sample of 112 FRBs, which probe length scales around $10^8$~pc, it is found that the DMs attributable to the intergalactic medium are consistent with a Kolmogorov model for the turbulent medium. A similar trend is seen in the interstellar medium based on pulsar measurements @armstrong_1981_natur on sub-pc length scales. A recent analysis by #cite(<zhu_2021_apj>, form: "prose") also considers the impacts of foreground galaxies on the overall turbulence and shows that, while the IGM is still the dominant factor, intervening galaxies and their halos contribute at about the 30% level.

== Gravitational lensing <sec-lensing>

Gravitational lensing, the phenomenon whereby the light from a distant celestial object follows curved geodesics due to the warping of spacetime by intervening objects, is now a well studied astrophysical phenomenon in samples of quasars @blandford_1992_araa. While a number of discussions of the potential for gravitational lensing within FRB observations can be found in the literature (one of the earliest being by #cite(<li_2014_scpma>, form: "prose") as a diagnostic for distinguishing between progenitor models), so far no examples of gravitational lensing of FRB signals in the classical sense of an intervening galaxy have been found.

Recently, #cite(<chen_2021_apj>, form: "prose") have investigated gravitational lensing in the context of double-peaked structures seen in some FRB profiles (e.g.~FRB~20130729A) which can potentially be explained in terms of a point mass (where the leading peak is always more magnified) with or without an external shear lens model. The presence of an external shear will change the relative amplitude of the two peaks. A conclusive demonstration of gravitational lensing, however, will require high-resolution radio imaging.

#cite(<liu_2019_phrvd>, form: "prose") and #cite(<wucknitz_2021_aa>, form: "prose") have examined the prospects for using gravitational lenses as cosmological probes. Considering a potential future sample of a few dozen repeating sources that exhibit strong lensing, #cite(<li_2018_natco>, form: "prose") and #cite(<liu_2019_phrvd>, form: "prose") show that constraints on both $H_0$ and the equation of state of dark energy are possible. #cite(<wucknitz_2021_aa>, form: "prose") discuss how measurements of time delays and their derivatives might be used to overcome limitations in conventional lensing interpretations, which typically require assumptions to be made about the unknown mass distribution of the lens. For multiply lensed sources, the images themselves might someday be utilised as an exquisitely sensitive intergalactic interferometer that could reveal structures on km scales.

Another novel application of lensed FRBs is their potential as dark matter probes, in particular the possible contribution from massive compact halo objects (MACHOs) which is poorly understood. #cite(<munoz_2016_phrvl>, form: "prose") show that, for masses in the 20--100~$M_⊙$ range, the lensing of FRBs by MACHOs in this regime naturally results in repeating FRBs with typical time delays of a few ms for a 30~$M_⊙$ lensing object. Searches for such events using existing instruments (in particular CHIME/FRB) could result in constraints on the fraction of dark matter in MACHOs to better than 10%.

== FRBs as probes of fundamental physics <sec-fundamental-physics>

For most studies, the time delay between the radio signal from an FRB at different frequencies is interpreted as being primarily due to plasma dispersion from ionized material along the line of sight. As discussed by #cite(<wei_2015_phrvl>, form: "prose"), from a fundamental physics perspective, additional contributions are possible due to Lorentz invariance violations, a non-zero rest mass of photons, and violations of the Einstein Equivalence Principle. A violation of the latter would mean that photons of different energies fall at different rates when traversing gravitational potentials, rather like lunar laser ranging experiments probe the Earth and Moon falling in the Sun's gravitational potential @nordvedt_1970_icar. A non-zero photon mass results in a dispersion relationship in pulse propagation as a function of frequency. Failure to detect such a delay, allows a direct constraint on the photon mass.

Initial attempts to apply these ideas @tingay_2016_apjl @wu_2016_apjl, turned out to be thwarted due to being based upon FRB~20150418A which was not convincingly established to be associated with a galaxy at $z = 0.492$ @keane_2016_natur. While subsequent constraints based on FRBs~20180924B and 20190523A, which have robustly determined host galaxies and redshift measurements, were found by #cite(<wang_2020_pdu>, form: "prose"), the current best limits are found by #cite(<xing_2019_apjl>, form: "prose"), who consider the time delay between downward drifting (sad trombone) pulses in FRB~20121102A. Using these pulses these authors limit equivalence principle violations to almost a part in $10^16$, while also placing a bound on the photon mass of $< 5 times 10^(-51)$~kg.

= Motivations for continued and future observations <sec-future-observations>

Here we outline the various ways in which future observations can help decipher the FRB mystery (while, inevitably, leading to new questions as well).

== Much larger burst sample <sec-burst-sample>

The coming 5 to 10 years of observations promise to deliver a sample of $>10 thin 000$ FRBs, which will easily surpass the known Galactic population of radio pulsars found in the past half century. Assuming that FRBs are related to neutron stars, we may thus soon know of more extragalactic neutron stars than those in our own Milky Way! This large sample is critical for population synthesis studies @james_2022_mnras_2, and for applications like galaxy cross-correlation to measure the statistical properties of the local environments @rafieiravandi_2021_apj and IGM. In fact, detailed studies of individual FRBs may be strongly limited by available time on other facilities, so statistical studies using archival optical/X-ray/gamma-ray survey data will be just as important as deep targeted studies of the most interesting individual sources.

With the availability of more known FRBs, sub-dominant populations --- beyond the current repeater versus one-off dichotomy, and the 4 burst archetypes identified in the first CHIME/FRB catalogue @pleunis_2021_apj --- may slowly appear. GRBs again provide an interesting precedent: beyond short and long gamma-ray bursts, it appears that some small fraction of the observed GRBs are from magnetar flares like those seen from SGRs. In addition to the temporal, spectral and polarimetric properties of the FRBs themselves @pleunis_2021_apj, sub-populations may be identifiable based on (periodic) activity level @chime_2020_natur_582, burst energy distribution @shannon_2018_natur, local environment @tendulkar_2021_apjl and coincidence with other multi-wavelength (or multi-messenger!) events.

As more FRBs are found with timescales of nanoseconds to hundreds of milliseconds, and distances of kiloparsecs to gigaparsecs, we will gain a much clearer view of how the transient parameter space is populated by short-duration coherent transients @nimmo_2021_arxiv_arxiv210511446 Beyond aiding in identifying different sub-populations of source type or emission mechanism, this will inform where the community might best invest in future instrumentation and observing campaigns --- either to maximize detection yield or, conversely, to explore for new phenomena. Current facilities are primarily focused on searching for FRBs at radio frequencies of 0.4--1.7~GHz and on timescales of $tilde.op 100$~µs--100~ms. This may be giving us a highly biased view of the population.

== Long-term monitoring <sec-monitoring>

It will soon be a decade since the first-known burst from the first-known repeater, FRB~20121102A, was detected by Arecibo @spitler_2014_apj Several CHIME/FRB, ASKAP, FAST and Parkes-discovered repeaters now also have multi-year spans of burst detections. DM, RM and $tau_"scatt"$ timeseries will trace the dynamic local environments of some repeaters @hilmarsson_2021_apjl. This can both inform progenitor models as well as whether the observed burst properties are predominantly intrinsic, or mainly reflect local propagation effects, like plasma lensing @cordes_2017_apj. We also need to determine whether the 'sad trombone' time-frequency drifting effect seen in repeaters @cordes_2017_apj evolves with time: e.g., a systematic change in drift rate during activity periods. Identifying correlations in the burst properties of repeaters can inform the emission mechanism @rajabi_2020_mnras, and this needs to be done for a larger sample of sources. Long-term monitoring of repeaters also opens interesting avenues for constraining cosmological parameters via gravitational lensing.

High-activity periods ('burst storms') will provide large burst numbers for statistical studies like burst energy distribution and wait times, and can also constrain models. The baseline of apparently one-off FRBs detected by CHIME/FRB @chime_2021_arxiv_arxiv210604352 is also important, since some of these sources may suddenly become very active compared to previous monitoring. FRB~20201124A is currently the best example of this as it was seen to repeat actively after years of non-detection in CHIME/FRB monitoring of the sky @Lanman_2021_arXiv. On the other hand, continued monitoring will place increasingly stringent constraints on the repetition rate of apparent one-off FRBs. For example, some apparently one-off FRBs may be associated with rare neutron star activity like the magnetar giant flares, which could potentially only recur once in decades for any individual source.

== Higher (and lower!) time resolutions and wider bandwidths <sec-time-resolution>

Observed FRB timescales extend over 8 orders of magnitude from $tilde.op 60$~ns to $tilde.op 3$~s. Nonetheless, there are still orders of magnitude to explore in the time dimension. Future experiments and surveys should endeavor to push the envelope in order to search for both 'ultra-fast radio bursts' (uFRBs; $Delta t < 10$~µs) and 'not-so-fast radio bursts' (nsFRBs; $Delta t > 100$~ms).

Nyquist-limited data can provide $tilde.op 1$~ns time resolution and can establish stronger observational links to phenomena seen from the young Crab pulsar @hankins_2016_apj and 'Crab twin' PSR~J0540$-$6919 @geyer_2021_mnras as well as the much older millisecond pulsars, like PSR~B1937+21 and PSR~B1821$-$24A, that emit giant pulses @johnston_2004_iaus. These short timescales may also reveal new sub-populations of FRB sources and provide new avenues for using FRBs as astrophysical and cosmological probes. To avoid scattering from the Galactic foreground, this must be done at relatively high radio frequencies ($> 2$~GHz) and/or at high Galactic latitude @nimmo_2021_arxiv_arxiv210511446. At comparably long timescales of $> 100$~ms, fast imaging searches will provide enhanced sensitivity compared to beam-formed techniques, since they provide a more stringent spatial filter.

While wide-band single-pixel feeds, and multi-band/multi-telescope campaigns, have better characterised the instantaneous spectra of FRBs @kumar_2021_mnras, there is still much to be explored: e.g., whether the broadband nature of FRBs correlates with their energy or other burst properties @metzger_2021_arxiv @hewitt_2021_arxiv. Such observations are also critical to determine whether the observed spectra are dominated by intrinsic or extrinsic effects. Multi-telescope simultaneous observations from tens of MHz to several GHz (or more) can map the burst width and spectral variations to determine whether these are consistent with scattering and scintillation, or demonstrably unrelated to propagation effects.

To date, there have been few attempts to detect FRBs at radio frequencies $> 3$~GHz @michilli_2018_natur @gajjar_2018_apj, but such efforts should increase since they provide access to the shortest-observable timescales and because the Crab pulsar demonstrates that a single source can produce remarkably different burst properties in different radio frequency bands. Identifying FRBs at high frequencies can be challenging because the short dispersive delay makes it harder to distinguish from radio frequency interference and higher frequency observations are restricted to small fields of view. Such observations can best be done using multiple geographically separated telescopes to verify the astrophysical nature of any detected events.

== A much larger host galaxy sample <sec-host-sample>

With close to two dozen FRB hosts known, it has become apparent that FRBs can be found in a wide range of galaxy types with different total stellar mass, metallicity and star-formation rate @heintz_2020_apj @mannings_2021_apj @bhandari_2021_arxiv. A much larger sample is needed, however, to look for preferences to certain galaxy types, which will also inform the possibility of FRB sub-populations with distinct physical origins. Thus far, no FRB has been found coincident with a starburst galaxy, but perhaps some exceptionally young, energetic and active sources can be found in such environments. Searches of nearby starburst galaxies, like M82, should continue since young and nearby FRBs may provide important multi-wavelength detections or constraints. Here too, higher radio frequencies may be needed to peer into the depths of star forming regions where young FRBs may live.

With a large ($> 100$--1000) sample of host galaxies, the statistical properties of the local environments and host DM contribution will also be better known. This is important for understanding how 'cleanly' FRBs can serve as cosmological probes @macquart_2020_natur. It may be the case that some FRBs are good probes of the IGM and CGM, while others are better probes of their local environment or reside in dense massive halos @rafieiravandi_2021_apj @niu_2021_arxiv.

== Zooming-in on the local environments of nearby FRBs <sec-local-environments>

In terms of characterising the local environments of FRBs, milliarcsecond localisations via VLBI only have added value, compared to $tilde.op$arcsecond localisations, for relatively nearby ($z lt.tilde 0.2$) sources where the host galaxy can be well resolved through photometry and spectroscopy by 8-m class ground-based facilities, or by #emph[Hubble]. Exceptionally nearby FRBs (within 100~Mpc) are more rare @bhardwaj_2021_apjl_910 @bhardwaj_2021_apjl_919 but increasing the known sample to a few dozen will provide a major step in comparing local environments. What fraction of FRBs are found in globular clusters @kirsten_2021_arxiv, what is their distribution with respect to local star forming regions @tendulkar_2021_apjl, and how many have compact persistent radio (or multi-wavelength) counterparts @chatterjee_2017_natur @marcote_2017_apjl @niu_2021_arxiv @law_2021_arxiv? Within the next 5 years, the 39-m European Extremely Large Telescope (E-ELT) will provide angular resolution that surpasses that of #emph[Hubble] by an order of magnitude. Coupled with its enormous collecting area, this may allow us to associate some FRBs with stellar companions in a binary system, a plausible scenario given the periodic activity of some repeaters. The imminent launch of the long anticipated #emph[James Webb Space Telescope] will provide another avenue for deep characterisation of FRB local environments.

== Targeted observations of potential FRB sites <sec-targeted-sites>

Linking FRBs to other known types of astrophysical sources and events can greatly inform their nature (and vice versa). Targeted observations of recent (superluminous) supernova and long GRB sites may eventually lead to the discovery of ultra-young FRBs observed just after birth, if formed in such scenarios @eftekhari_2019_apjl @marcote_2019_apjl. We should also be targeting the population of 'wandering' black holes in dwarf galaxies @reines_2020_apj, since some of these compact persistent radio sources may actually be related to repeating FRBs as opposed to AGN-like activity @eftekhari_2020_apj @law_2021_arxiv.

Automated, low-latency follow-up as soon as possible after a transient event @anderson_2021_pasa may reveal bursts from a central engine that later collapses to a black hole. Co-observing, or buffered data from low-frequency radio telescopes (where the large dispersive delay offers the opportunity to capture the signal later), will detect or constrain prompt coherent radio emission from such events. As the fields of view, and rapid, triggered repointing capabilities of radio telescopes increase, we may also find prompt FRB-like emission from cataclysmic events such as supernovae (SNe), tidal disruption events (TDEs), short/long GRBs, and gravitational wave (GW) events.

Targeted observations of magnetars, ULXs, microquasars, gamma-ray binaries, etc., may also yield important connections @sridhar_2021_apj Triggered observations are needed to catch these sources during active states; high-cadence monitoring is necessarily to find rare (but bright) events like the MJy-ms event from SGR~1935+2154 @chime_2020_natur_587 @bochenek_2020_natur. Because bright bursts are typically rare, and commonly occurring bursts are typically faint, a tiered approach, using multiple instruments with different trade-offs between sensitivity and on-sky time is needed. CHIME/FRB provides daily monitoring of the northern hemisphere, but with only $tilde.op 10$~min integration in the main beams. This can be complemented by low-sensitivity arrays, like STARE2 and the proposed GRex, that are observing (close to) the whole sky simultaneously @connor_2021_pasp, as well as high-cadence observations of known sources using 25-m class radio telescopes. The Galactic centre and bulge deserve particular attention; high-cadence X-ray monitoring has demonstrated the scientific potential of this approach @degenaar_2010_aa.

== Multi-wavelength and multi-messenger connections <sec-multi-messenger>

Thus far, extragalactic FRBs have appeared quiet at other wavelengths @scholz_2017_apj @scholz_2020_apj and via other messengers @aartsen_2020_apj. It is possible that the distances to FRBs are simply too large for there to be detectable multi-wavelength counterparts, given the sensitivities of existing telescopes observing above the radio band. We have only scratched the surface, however, since most multi-telescope studies have targeted repeaters and prompt observation of one-off FRBs is particularly challenging. Future FRB search machines would benefit from dedicated optical and high-energy instruments simultaneously observing the same field of view.

Assuming a scenario where FRBs originate from neutron star magnetospheres, #cite(<lyutikov_2016_apjl>, form: "prose") consider what electromagnetic counterparts might accompany them. In the case of flares associated with magnetospheric reconfigurations, contemporaneous bursts at other wavelengths, and/or an afterglow may be detectable. They argue that a short GRB-like burst, a millisecond-duration optical flash, and/or a high-energy afterglow are the most promising scenarios to pursue observationally. Radio interferometers like ASKAP that can both discover and localise one-off FRBs, can also place limits on precursor and afterglow radio emission @bhandari_2020_apjl_901.

== Linking to other observed radio phenomena <sec-radio-phenomena>

We may also come to a deeper understanding of FRBs by studying potentially related source types and emission processes. Though they have been studied for over a half century, there is still no broad consensus on the mechanism(s) by which radio pulsars produce their emission. Nonetheless, advanced numerical simulations are providing new insights into pulsar emission and how neutron star magnetospheres can create electromagnetic phenomena in general @philippov_2020_phrvl. Similar simulations focusing specifically on reproducing the phenomenology and much higher luminosities of FRBs are needed.

At the same time, we continue to discover new emission phenomena from Galactic pulsars and magnetars @lower_2021_mnras @bij_2021_apj. High-cadence observations of pulsar single pulses may reveal new phenomena that also give insight into FRBs. Wide-field FRB machines like CHIME/FRB, and high-sensitivity, high-cadence pulsar observations with MeerKAT can elucidate this. High-time-resolution studies of giant pulses from young pulsars and millisecond pulsars deserve increased attention in the context of understanding FRB emission. Lastly, continued studies of short-timescale radio emission from the Sun, active/flare stars, and (exo)planets are likely to reveal new phenomena and may provide interesting analogies for understanding FRBs.

= Future prospects <sec-future-prospects>

In this update to our 2019 review, we have focused on recent observational highlights in the rapidly evolving study of FRBs. These observations shed light on new aspects of the FRB phenomenon, constrain theoretical models from new angles, and show early promise for using FRBs as astrophysical and cosmological probes. As with our previous review, we anticipate that many elements of the summary presented here will fall rapidly out of date. This underscores the rapid rate of progress that is being made in the field!

Many aspects of the FRB phenomenon remain to be explored. Clear areas for progress identified while writing this review include: expanded searches for FRBs at high ($> 2$ GHz) and low ($< 300$ MHz) radio frequencies; higher time and frequency resolution exploration of burst and sub-burst morphology; and searches for periodic activity in a larger sample of regularly repeating sources. The future also holds promise at other wavelengths, including: the search for X-ray and optical counterparts associated with FRBs; deep optical imaging of host galaxies and local environments; rapid triggering of follow-up telescopes through FRB VOEvents; and coordinated campaigns with other facilities for targeting periodically active repeaters.

Existing radio facilities ramping up their search efforts provide complementary views of the FRB phenomenon: e.g., from the shallow, wide-field efforts of STARE2 @bochenek_2020_natur to the pinpoint precision of the EVN @marcote_2020_natur and the CHIME/FRB Outriggers @leung_2021_aj. A large sample of FRBs from telescopes around the world searching at different radio frequencies, sensitivities, time resolutions, and fields of view will offer more insight into the menagerie of FRB properties. Future facilities such as CHORD, DSA-2000, and the SKA are expected to build on these successes in the coming decade.

The future is indeed (radio) bright. As with our previous review, we conclude with our predictions for the state of the field five years from now.

== Predictions for 2027 <sec-predictions>
=== EP <pred-ep>

Looking back at my predictions from our previous review, it is easy to remember the state of the field at that time; the discovery space felt wide open for surprises. Some of my predictions have already come true -- FRBs over many decades of radio frequency, FRBs in nearby ($tilde.op$Mpc) galaxies, a large population from wide-field arrays. Some predictions have yet to be realised -- a high-redshift host, a better understanding of FRB polarisation -- and some of the most exciting results from the past few years surprised us all, like the dazzlingly bright burst from SGR~1935+2154. In the next $tilde.op 5$ years I predict we will see more FRB-like radio behavior from Galactic magnetars and establish a firm FRB---magnetar connection for at least a subset of the FRB population. I predict we will have over 100 host galaxies through the efforts of ASKAP, and other precision interferometers with the sample increasingly dominated by the tens of host galaxies per year from CHIME/FRB Outriggers. I predict that we will see more FRBs at low ($tilde.op 1$00~MHz) radio frequencies and we will also see FRBs at high ($gt.eq 10$~GHz) frequencies, if we look for them. I predict that we will identify two distinct populations -- FRBs that repeat and FRBs that do not -- and morphology will be an important predictor of an FRB source's probability of repeating. I am hopeful that a small sample of sources in nearby galaxies will give us insight into the environment, activity level, and multi-wavelength emission of FRBs that can be extended to our understanding of sources at greater distances. As before, I predict that our vibrant and diverse community will continue to grow and benefit from the expertise of observers and theorists from a wide range of astrophysical backgrounds. I look forward to seeing how right or wrong these predictions are found to be, and I also look forward to the next big surprises these curious sources have to offer us!

=== JWTH <pred-jwth>

Re-reading my predictions from the original version of our review in 2019, I can see that many of these things have come to pass, already in the last 2 years! This speaks volumes about the rate at which the field is progressing. I should have been more ambitious and wilder in my predictions. But there have also been many discoveries that we did not foresee at the time of our original review --- like periodic activity in repeaters and a globular cluster host for one nearby repeater. Most likely the safest prediction to make, moving forward, is that there are more surprises to come. As hoped, we have now detected (sub-)microsecond structure in FRBs. This has only been possible, so far, in follow-up observations of repeaters. I predict that in the next 5 years we will start blindly detecting 'ultra-fast radio bursts' (uFRBs) in searches that employ high radio frequencies and semi-coherent dedispersion trials. In a more general sense, I think that the transient phase space will continue to be filled-in on the shortest-observable timescales, and for the rarest forms of astrophysical events. Conversely, I also think that there are great prospects for uncovering a population of 'not-so-fast radio bursts' (nsFRBs) with durations of 100~ms to several seconds. Clusters in the short-duration transient phase space might hint at distinct populations, but given that some neutron stars (e.g., SGR~1935+2154) can produce radio bursts spanning many orders of magnitude in timescale and luminosity, this will require additional contextual information to justify any such groupings. Going more out on a limb, I predict that we #emph[will not] detect prompt X-ray or gamma-ray counterparts to #emph[extragalactic#footnote[The Galactic magnetar SGR~1935+2154 suggests that we should see this for extremely nearby sources, however.]] FRBs (or vice-versa) within the next 5 years --- though I do hold more hope for the detection of prompt optical flashes. By targeting the sites of known astrophysical explosions (various flavours of supernovae and kilonovae), I predict that we will directly link a longer-lived, repeating FRB source to the event that created the central engine.

=== DRL <pred-drl>

As we finalise this review, there are a number of exciting results emerging and it is clear that the CHIME/FRB sample and other experiments are going to guarantee a number of surprises in the coming five years. I am gratified my 2019 prediction, from our original review, that only 1% of all FRBs will show repeats is not too far off! At the time of writing, about 4% of the CHIME/FRB sample repeats. I predict this fraction will go down further as the survey runs out of repeating sources to find down to its flux limit. My prediction of 3000 FRBs by 2024 looks like it will easily be reached at the current pace of discoveries. With the plans for CHIME/FRB outrigger stations now well underway, and progress at many other sites, there are now very good reasons to be optimistic about getting a large number (perhaps 1000) robustly associated galaxies with FRBs over the next five years. For me, one of the most interesting of the current results are the morphological studies now being provided by the first CHIME/FRB catalogue. The clearly distinct classes emerging from this sample indicate to me strong evidence in favor of multiple source populations. We are clearly just scraping the surface right now, but I will boldly predict that a single source population for FRBs will no longer be viable by the middle of this decade. I am optimistic that prompt electromagnetic counterparts will soon be observed for some FRBs in the form of optical flashes. Spurred on by Bing Zhang, I also dare to dream of an association between an FRB and a gravitational wave source.

= Acknowledgements

#block[
The authors would like to dedicate this review to the late J.-P. Macquart, an esteemed friend, colleague, and mentor. Thank you, J.-P., for your insights and boundless enthusiasm for all things FRB-related, and beyond.

]

We thank Bridget Anderson, Anya Bilous, Joeri van Leeuwen, Kenzie Nimmo, Leon Oostrum, Inés Pastor-Marazuela, and Kendrick Smith for their feedback on drafts of this review. Bing Zhang, Jonathan Katz, Julian Muñoz, Daniele Michilli, Sandro Mereghetti, Shami Chatterjee and Mark Snelders provided much useful feedback on our initially submitted version of the manuscript. We additionally thank the two anonymous referees who improved the quality and clarity of the manuscript.

EP is supported by a Dutch Research Council (NWO) Veni Fellowship. JWTH is supported by an NWO Vici grant ('AstroFlash'; VI.C.192.045). DRL acknowledges support from the Research Corporation for Scientific Advancement and the National Science Foundation through award AAG-1616042.

#show bibliography: set text(size: 8pt)
#bibliography("refs.bib", style: "aas.csl", title: [References], full: true)