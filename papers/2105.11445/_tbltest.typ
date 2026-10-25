#import "@preview/cetz:0.4.2"

// ---- document setup ----
#set text(font: ("Times New Roman", "Libertinus Serif"), size: 10pt, lang: "en")
#set page(numbering: "1", paper: "us-letter", margin: (left: 2.50cm, right: 2.50cm, top: 2.51cm, bottom: 2.88cm), columns: 2)
#set figure(placement: auto)
#show figure: set figure(scope: "parent")
#set heading(numbering: "1.1")
#set par(justify: true, spacing: 0.54em, first-line-indent: (amount: 1.2em, all: true))
#show figure: set block(above: 0.7em, below: 0.7em)
#show math.equation.where(block: true): set block(above: 1.5em, below: 1.0em)
#set par(leading: 0.54em)
#set figure.caption(position: bottom)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "edtable"): set figure.caption(position: top)
#show math.equation.where(block: true): set align(center)


#place(top + center, scope: "parent", float: true)[
#align(center)[
  #text(17pt, weight: "bold", [A repeating fast radio burst source in a globular cluster])   #v(1.2em)
  #text(10.5pt)[F. Kirsten, B. Marcote, K. Nimmo, J. W. T. Hessels, M. Bhardwaj, S. P. Tendulkar, A. Keimpema, J. Yang, M. P. Snelders, P. Scholz, A. B. Pearlman, C. J. Law, W. M. Peters, M. Giroletti, Z. Paragi, C. Bassa, D. M. Hewitt, U. Bach, V. Bezrukovs, M. Burgay, S. T. Buttaccio, J. E. Conway, A. Corongiu, R. Feiler, O. Forssén, M. P. Gawroński, R. Karuppusamy, M. A. Kharinov, M. Lindqvist, G. Maccaferri, A. Melnikov, O. S. Ould-Boukattine, A. Possenti, G. Surcis, N. Wang, J. Yuan, K. Aggarwal, R. Anna-Thomas, G. C. Bower, R. Blaauw, S. Burke-Spolaor, T. Cassanelli, T. E. Clarke, E. Fonseca, B. M. Gaensler, A. Gopinath, V. M. Kaspi, N. Kassim, T. J. W. Lazio, C. Leung, D. Z. Li, H. H. Lin, K. W. Masui, R. Mckinven, D. Michilli, A. Mikhailov, C. Ng, A. Orbidans, U. L. Pen, E. Petroff, M. Rahman, S. M. Ransom, K. Shin, K. M. Smith, I. H. Stairs, W. Vlemmings]
  
]

#v(1.2em)


#block[
]


#strong[Fast radio bursts (FRBs) are exceptionally luminous flashes of unknown physical origin, reaching us from other galaxies @petroff_2019_aarv. Most FRBs have only ever been seen once, while others flash repeatedly, though sporadically @spitler_2016_natur @chime_2021_arXiv. Many models invoke magnetically powered neutron stars (magnetars) as the engines producing FRB emission@margalit_2018_apjl @chime_2020_natur_587. Recently, CHIME/FRB announced the discovery@bhardwaj_2021_apjl of the repeating FRB~20200120E, coming from the direction of the nearby grand design spiral galaxy M81. Four potential counterparts at other observing wavelengths were identified@bhardwaj_2021_apjl but no definitive association with these sources, or M81, could be made. Here we report an extremely precise localisation of FRB~20200120E, which allows us to associate it with a globular cluster (GC) in the M81 galactic system and to place it $approx$2 pc offset from optical center of light of the GC. This confirms@bhardwaj_2021_apjl that FRB~20200120E is 40 times closer than any other known extragalactic FRB. Because such GCs host old stellar populations, this association strongly challenges FRB models that invoke young magnetars formed in a core-collapse supernova as powering FRB emission. We propose, instead, that FRB~20200120E is a highly magnetised neutron star formed via either accretion-induced collapse of a white dwarf or via merger of compact stars in a binary system@margalit_2019_apj. Alternative scenarios involving compact binary systems, efficiently formed inside globular clusters, could also be responsible for the observed bursts.]
]


M81 is one of the most massive nearby galaxies, at 3.6 Mpc@freedman_1994_apj. We targeted the previously best-known position@bhardwaj_2021_apjl of FRB~20200120E~several times during February to May 2021 with an array composed of up to eleven radio telescopes that are part of the European Very Long Baseline Interferometry (VLBI) Network (EVN; see Methods). We observed at a central radio frequency of $tilde 1.4$~GHz and recorded raw voltages from all telescopes. At Effelsberg and at the Sardinia Radio Telescope (SRT), we collected data in parallel using pulsar data recorders (Methods).


In total we detected five bursts from FRB~20200120E, with dispersion measures close to the previously reported@bhardwaj_2021_apjl $"DM" = "87.8"$ pc cm$""^(- 3)$. Two bursts were detected on 2021 February 20 (called B1 and B2 below), two bursts on 2021 March 7 (B3 and B4), and one burst on 2021 April 28 (B5). Bursts B2-B5 were found by blindly searching both the Effelsberg voltages and PSRIX@lazarus_2016_mnras data (Methods), while B1 was only detected in the voltage data as it occurred outside the recording times of the PSRIX instrument@nimmo_2021_arxiv. In @fig:bursts we show the dedispersed dynamic spectra and frequency averaged burst profiles. Burst fluences range from $0.13 - 0.71$ Jy~ms and total burst envelopes span only $tilde 100 - 300$ $mu$s (@tab:pol_properties). A detailed, ultra-high-time-resolution analysis of the burst properties and energetics is presented in a companion paper@nimmo_2021_arxiv.


Correlation of the data, in order to produce 'visibilities' for interferometric imaging, was performed at the Joint Institute for VLBI ERIC. To achieve the best-possible sensitivity, we used the coherent-dedispersion mode of the software correlator SFXC@keimpema_2015_exa, applying $"DM" = "87.77" thin "pc" thin "cm"^(-3)$, which we derived from a manual inspection of the bursts (Methods).


After an initial rough localisation via delay mapping (Methods, accurate to several arcseconds), we individually imaged the five bursts, where each data set spans only the width of each burst in time (@tab:pol_properties). Given the snapshot nature of the correlations, the rather sparse arrays in each run, and the fact that the bursts only covered a fraction of the observed bandwidth, the images from the individual bursts result in elongated fringe patterns, hindering an individual, unambiguous localisation of each burst at the level of the synthesised beam size (see #ref(<fig:localisation-maps>)a-d). Therefore, we created a data set that is the combination of the visibilities from all bursts except B1 --- as it was too faint to produce a useful image, and we therefore exclude it from the localization analysis. These data allowed us to unambiguously pinpoint the position of FRB~20200120E in the field (see #ref(<fig:localisation-maps>)e,f). The derived coordinates of FRB~20200120E in the International Celestial Reference Frame (ICRF)@charlot_2020_aanda are RA (J2000) $= 9^(upright(h)) 57^(upright(m)) 54.69935^(upright(s)) plus.minus 1.2 thin "mas"$~Dec (J2000) $= 68^compose 49' 0.8529^('') plus.minus 1.3 thin "mas"$ (see Methods). These coordinates coincide with the location of the globular cluster \[PR95\]~30244 @perelmuter_1995_aj_110, which is part of the M81 globular cluster system @perelmuter_1995_aj_109.


#ref(<fig:subaru-image>)a shows the position of FRB~20200120E with respect to \[PR95\]~30244 in a combined three-colour Subaru image made with $i'$, $r'$, and $g'$ filters mapped to red, green, and blue channels, respectively. The galaxy at the bottom-left of \[PR95\]~30244 is a background SDSS galaxy at redshift $z = 0.194$, i.e. at a $z$ much larger than the maximum possible@bhardwaj_2021_apjl value ($z < 0.03$) based on FRB~20200120E's dispersion measure. We performed radial fits to the brightness distribution of \[PR95\]~30244 using a Moffat profile @moffat_1969_aa in both RA and Dec for all three bands after fitting and subtracting a bilinearly varying background (to account for the presence of the background galaxy). The average position of the centroid of \[PR95\]~30244 is RA (J2000) $= 9^(upright(h)) 57^(upright(m)) 54.7135^(upright(s)) med plus.minus med 7$~mas, Dec (J2000) $= 68^compose 49' 0.766^('') med plus.minus med 4$~mas (statistical), well in agreement with previous measurements@perelmuter_1995_aj_110 and the position of the source in the #emph[Gaia] Early Data Release 3 Catalogue@gaia_2016_aanda @gaia_2021_aanda (Methods), in which positions are well aligned with the ICRF@gaia_2021_aanda.


The centre of the FRB localisation is $approx 116$ mas offset from the optical centre of light of \[PR95\]~30244 (#ref(<fig:subaru-image>)b, corresponding to $approx 54 "%"$ of its effective radius, Methods). Given the astrometric uncertainty of the FRB localisation ($approx 1.3$ mas) and the optical image registration error with respect to the ICRF ($approx 15 thin "mas"$\; see Methods), we conclude that FRB~20200120E is located significantly ($> 7 sigma$ confidence level) offset from the optical centre of light of \[PR95\]~30244. The optical angular size of \[PR95\]~30244 (0.77″; Methods) in combination with FRB~20200120E's offset from M81 (19.6$′$) and the number of GCs predicted@harris2013 to be part of the galaxy ($300 plus.minus 100$), allow us to estimate the probability of chance alignment $P_"cc" < 1.7 times 10^(- 4)$ (Methods). From such a very low $P_"cc"$ value, we conclude that the association of FRB~20200120E and \[PR95\]~30244 is robust.


#ref(<fig:continuum-images>)a shows a deep continuum map that was created from the combination of the data of all VLBI observations. We find no persistent source at the location of FRB~20200120E above a $5 sigma$ confidence level (rms background noise level of $"10" thin "mu" thin "Jy" thin "beam"^(-1)$). Also shown in @fig:continuum-images are continuum images obtained with the Karl G. Jansky Very Large Array (VLA) at $1.5 thin$GHz and at $340 thin$MHz between December 2020 to January 2021 (Methods). These maps have noise levels of $6.5 thin "mu" thin "Jy" thin "beam"^(-1)$ and $320 thin "mu" thin "Jy" thin "beam"^(-1)$, respectively. Also here, no persistent source is detected at the position of FRB~20200120E in either of the images. For a 1.5 GHz radio flux density limit of $20 thin "mu" thin "Jy"$ ($3 sigma$) and a distance of 3.6 Mpc, we limit the radio luminosity $L_nu < 3.1 times 10^23 thin "erg" thin "s"^(-1) thin "Hz"^(-1)$. This luminosity limit is $tilde 10^3$ times lower than that of any other extragalactic FRB @marcote_2020_natur and almost $10^6$ times lower than the radio luminosity of the persistent source in the vicinity of FRB~20121102A @marcote_2017_apjl.


We find no evidence of an X-ray source at the location of FRB~20200120E in archival #emph[Chandra] observations (Methods). This results in a 0.5--10 keV luminosity upper limit of $2 times 10^37$ erg s$""^(- 1)$ (3$sigma$) at the distance of 3.6 Mpc. A detailed analysis of ongoing X-ray follow-up observations of the region will be presented in Pearlman et al. (in prep.). Similarly, no sources are reported at the location of M81 in any of the #emph[Fermi]-LAT catalogues@ajello_2020_apj. The nearest catalogued source (at a separation of $52'$) is 4FGL J0955.7+6940, known to be associated with M82@abdo_2010_apjl.


Within the context of FRB models that invoke a young, highly magnetized neutron star (NS) powered primarily by the decay of its magnetic field@margalit_2018_apjl @chime_2020_natur_587, i.e. a magnetar, it is hard to reconcile FRB~20200120E's association with an old globular cluster using the standard core-collapse supernova formation channel of magnetars. Instead, because of their extreme stellar densities, globular clusters are known to form short-orbital-period binaries at a high specific rate @hut_1992_pasp @pooley_2003_apjl @verbunt_2003_aspc. We thus propose that FRB~20200120E~is a magnetar formed via accretion-induced collapse (AIC)@wang_2020_raa of a white dwarf (WD) or via merger-induced collapse (MIC) of a WD-WD, NS-WD or NS-NS binary@giacomazzo_2013_apjl @schwab_2016_mnras @zhong_2020_apj --- systems that are common in globular clusters and, like FRB~20200120E, are found concentrated towards their core@prager_2017_apj (Methods). The lack of a persistent radio or X-ray source at the position of FRB~20200120E is expected in an AIC/MIC scenario, as any emission generated during collapse fades on short time scales ($< 1$ yr)@margalit_2019_apj.


The globular cluster host of FRB~20200120E also suggests some alternatives to the magnetar class of FRB models. FRB~20200120E could be a compact binary system --- such as a tight WD-NS system in a pre-merger phase or a magnetised NS with a planetary companion @mottez_2014_aa @mottez_2020_aa --- in which the bodies are interacting magnetically. Similarly, a binary millisecond pulsar with a strong magnetic field formed via AIC and that was subsequently spun-up via accretion @ablimit_2015_apj @ye_2019_apj could act as an FRB engine. Such a system could also be observable as a low mass X-ray binary (LMXB)@heinke_2003_apj, as would an accreting black hole (BH). In such an LMXB model, the radio bursts could be generated via magnetic reconnection in a relativistic jet or where the jet shocks with the surrounding medium and creates a synchrotron maser @sridhar_2021_arxiv. Except for the most luminous LMXBs ($"L"_("X") approx "10"^("38") thin "erg" thin "s"^(-1)$), our observations cannot rule out such systems. However, none of the $tilde 200$ Galactic LMXBs has been seen to generate FRBs. In some cases, ultra-luminous X-ray sources (ULXs)@kaaret_2017_araa have been shown to be NSs accreting at hyper-Eddington rates @bachetti_2014_natur, though some may be systems with a more massive BH primary @webb_2012_sci. We note that ULXs have been associated with extragalactic globular clusters @dage_2020_mnras but such systems are ruled out by our X-ray limit unless their luminosity varies in time by more than two orders of magnitude. Additionally, the association with a globular cluster rules out a high mass X-ray binary origin of FRB~20200120E and the projected offset of $approx 2$ pc from the centre of light of \[PR95\]~30244 excludes the association of FRB~20200120E with, e.g., a massive ($gt.tilde thin "10" thin "M"_(⊙)$) stellar mass BH or a putative intermediate mass black hole at the core of \[PR95\]~30244.


The association of FRB~20200120E with a globular cluster adds to the diversity of environments in which repeating FRBs have been found. While FRB~20121102A resides in a dwarf galaxy@chatterjee_2017_natur, the host of FRB~20180916B is a spiral galaxy@marcote_2020_natur and FRB~20201124A was localised to a massive star forming galaxy@ravi_2021_arxiv. Previously localised repeaters have been associated with nearby star forming regions@bassa_2017_apjl @tendulkar_2021_apjl @piro_2021_arxiv @fong_2021_arxiv, favouring the core-collapse supernova channel for the formation of a young magnetars, as the rate of AIC and MIC is much lower. The lack of a persistent radio source for all but FRB~20121102A may suggest a range in the possible ages of such magnetars. In a globular cluster environment, however, the recent core-collapse of a massive star is very unlikely. Thus, this suggests a diversity in formation channels for magnetars as FRB engines.


// [figvision] imgs/KN_burstplot_nopol_M81R.png
// Panel a: This is a plot of signal-to-noise ratio (S/N). The y-axis ranges from 0 to 5, and the x-axis is not
// labelled but appears to represent time. There is one series, a black line representing the S/N of burst B1. A
// blue bar indicates the burst width. The trend shows a peak S/N of around 5. Panel b: This plot shows S/N
// versus time for burst B2. The y-axis ranges from 0 to 50. There is one series, a black line. A blue bar
// indicates the burst width. The trend shows a sharp peak S/N of around 40. Panel c: This plot shows S/N versus
// time for burst B3. The y-axis ranges from 0 to 50. There is one series, a black line. A blue bar indicates the
// burst width. The trend shows a sharp peak S/N of around 45. Panel d: This plot shows S/N versus time for burst
// B4. The y-axis ranges from 0 to 10. There is one series, a black line. A blue bar indicates the burst width.
// The trend shows a peak S/N of around 9. Panel e: This plot shows S/N versus time for burst B5. The y-axis
// ranges from 0 to 10. There is one series, a black line. A blue bar indicates the burst width. The trend shows
// a peak S/N of around 8. Panel f: This is a dynamic spectrum with frequency on the y-axis (ranging from 1300 to
// 1500 MHz) and time on the x-axis (ranging from -500 to 500 μs). The plot is a grayscale image. Red marks are
// at specific frequencies. There is no clear trend, but it appears to show some signal. Panel g: This dynamic
// spectrum shows frequency (1300-1500 MHz) versus time (-500 to 500 μs) for burst B2. The plot is a grayscale
// image with red marks at specific frequencies. There is a clear vertical signal around 0 μs. Panel h: This
// dynamic spectrum shows frequency (1300-1500 MHz) versus time (-500 to 500 μs) for burst B3. The plot is a
// grayscale image with red marks at specific frequencies. There is a clear vertical signal around 0 μs. Panel i:
// This dynamic spectrum shows frequency (1300-1500 MHz) versus time (-500 to 500 μs) for burst B4. The plot is a
// grayscale image with red marks at specific frequencies. There is a clear vertical signal around 0 μs. Panel j:
// This dynamic spectrum shows frequency (1300-1500 MHz) versus time (-500 to 500 μs) for burst B5. The plot is a
// grayscale image with red marks at specific frequencies. There is a less clear vertical signal around 0 μs.
#figure(scope: "parent", placement: top, [#box(image("imgs/KN_burstplot_nopol_M81R.png", width: 100%))

  ],
  caption: [
    #strong[Dispersion-corrected time series and dynamic spectra of the five FRB~20200120E bursts] Frequency-averaged time series of the bursts are displayed in panels #strong[a-e]. The top right corner of each panel shows the burst name used in this work. The blue-coloured bars highlight the $plus.minus$2$sigma$ burst width used to measure the burst fluence. The dynamic spectra of each burst are shown in panels #strong[f-j]. The red marks represent the edges of the subbands. Data that have been removed due to contamination by radio frequency interference have not been plotted. In all panels the data are plotted with 32 $mu$s and 2 MHz time and frequency resolution, respectively (with the exception of B1 and B5 which are plotted with 4 MHz frequency resolution).
  ]
)
<fig:bursts>



// [figvision] imgs/fig_final_localizations.png
// Panel a: This plot shows a normalised dirty image of burst B2. The x-axis represents RA (J2000) ranging from
// 54.6' to 54.8', and the y-axis represents Dec (J2000) ranging from 00' to 01'. The plot features a purple
// background with yellow and orange diagonal lines. A white circle is centred on the location of a globular
// cluster. The trend shows a peak near the centre of the circle. Panel b: This plot shows a normalised dirty
// image of burst B3. The x-axis represents RA (J2000) ranging from 54.6' to 54.8', and the y-axis represents Dec
// (J2000) ranging from 00' to 01'. The plot features a purple background with yellow and orange diagonal lines.
// A white circle is centred on the location of a globular cluster. The trend shows an offset peak. Panel c: This
// plot shows a normalised dirty image of burst B4. The x-axis represents RA (J2000) ranging from 54.6' to 54.8',
// and the y-axis represents Dec (J2000) ranging from 00' to 01'. The plot features a purple background with
// yellow and orange diagonal lines. A white circle is centred on the location of a globular cluster. The trend
// shows a peak near the centre of the circle. Panel d: This plot shows a normalised dirty image of burst B5. The
// x-axis represents RA (J2000) ranging from 54.6' to 54.8', and the y-axis represents Dec (J2000) ranging from
// 00' to 01'. The plot features a purple background with yellow and orange diagonal lines. A white circle is
// centred on the location of a globular cluster. The trend shows a peak near the bottom right. Panel e: This
// plot shows a normalised dirty image of the four bursts combined (B2B3B4B5). The x-axis represents RA (J2000)
// ranging from 54.6' to 54.8', and the y-axis represents Dec (J2000) ranging from 00' to 01'. The plot features
// a purple background with a yellow peak. A white circle is centred on the location of a globular cluster. The
// trend shows a strong central peak. Panel f: This plot shows a cleaned image. The x-axis represents RA (J2000)
// ranging from 54.6' to 54.8', and the y-axis represents Dec (J2000) ranging from 00' to 01'. The plot features
// a purple background with a small yellow peak inside the white circle. A white circle and a small white bar are
// centred on the location of a globular cluster. The trend shows a central peak.
#figure(placement: top, image("imgs/fig_final_localizations.png", width: 100%),
  caption: [#strong[Localisation plots for FRB~20200120E.] Normalised dirty images of the individual bursts (B2, B3, B4 and B5; #strong[a-d]) along with a dirty image of the four bursts combined (#strong[e]), produced by applying a natural weighting to the data. For visualisation purposes we clip the colour scale at zero, i.e. only positive peaks are displayed. The white circles are centred on the location of the globular cluster \[PR95\]~30244 as derived from the Subaru image in @fig:subaru-image. Their size indicates the region that contains 90\% of the globular cluster's optical emission. The synthesized beams of each image are displayed as grey ellipses in the bottom left corner of each panel. #strong[f]: The cleaned image and resulting localisation of FRB~20200120E, as derived from the combined data sets of four bursts. The resulting coordinates of FRB~20200120E (highlighted by the white marker) are RA (J2000) $= 9^(upright(h)) 57^(upright(m)) 54.69935^(upright(s)) plus.minus 1.2 thin "mas"$,~Dec (J2000) $= 68^compose 49' 0.8529^('') plus.minus 1.3 thin "mas"$.
  ]
)
<fig:localisation-maps>



// [figvision] imgs/plot_optical.png
// Panel a: This is an optical image. The x-axis is right ascension (RA) in units of hours, minutes, and seconds,
// ranging from 05:54:50 to 05:57:58. The y-axis is declination (Dec) in degrees, ranging from 48°50′ to
// 68°49′21′′. The image is in three bands, but colours are not specified. A small red ellipse marks the location
// of FRB~20200120E. The trend shows a bright central object, likely a galaxy, with several smaller objects
// nearby. Panel b: This is a zoomed-in intensity map or image. The x-axis is RA (J2000) in degrees, ranging from
// 54.5° to 54.8°, and the y-axis is Dec (J2000) in degrees, ranging from 00.0′ to 01.0′. The image has a colour
// gradient from blue (low intensity) to yellow (high intensity). A grey circle indicates the estimated centre of
// PR95~30244 with a 10 uncertainty. A small red dot marks a specific location within the image. Panel c (top and
// right): These are plots. The top plot has x-axis ranging from 68°49′01.5′′ to 68°49′21′′ and y-axis with no
// units, and the right plot has x-axis with no units and y-axis ranging from 48°50′ to 68°49′21′′. Both plots
// have two series with different line styles (solid and dashed). The plots appear to show a Gaussian-like
// distribution. The trend in both plots is a peak in the middle, indicating a central concentration or maximum
// value.
#figure(placement: top, image("imgs/plot_optical.png", width: 100%),
  caption: [ #strong[Optical images of the FRB~20200120E host and surrounding field.] Left (#strong[a]): 40$""^('')$ $times$ 40$""^('')$ $g'$, $r'$, and $i'$ band image of \[PR95\]~30244~acquired with Hyper Suprime-cam. The small red ellipse is centred at the location of FRB~20200120E. In panel #strong[b] we show the zoomed-in $r'$ band image of \[PR95\]~30244. The grey circle represents the estimated position of the centre of \[PR95\]~30244 and its 10$sigma$ uncertainty (dominated by the optical-to-radio reference frame tying). The small red ellipse is the same as in panel #strong[a], and also represents the 10$sigma$ positional uncertainty region of FRB~20200120E. Panels #strong[c] and #strong[d] show cross-sections of the brightness distribution of the cluster (blue solid lines) with the Moffat profile that we fit overlaid in black. Indicated in solid grey lines are the PSFs as measured from stars in the images. Note that scatter in the PSFs is smaller than the linewidth.
  ]
)
<fig:subaru-image>



// [figvision] imgs/fig_continuum_evn_vla.png
// Panel a: This is a 1.4-GHz EVN continuum image. The x-axis represents right ascension (RA) in J2000
// coordinates, ranging from 9h 37m 54.65s to 9h 37m 54.75s. The y-axis represents declination (Dec) in J2000
// coordinates, ranging from 68° 49' 00.6" to 68° 49' 01.0". The image is a plot with a grey-scale colour map
// representing continuum intensity. A red circle indicates the positional uncertainty region of FRB 20200120E. A
// black ellipse in the bottom-left corner represents the beam. The trend shows a faint source near the centre.
// Panel b: This is a 1.5-GHz Realfast continuum image. The x-axis represents RA in J2000 coordinates, ranging
// from 9h 37m 52s to 9h 37m 56s. The y-axis represents Dec in J2000 coordinates, ranging from 68° 48' 50" to 68°
// 49' 20". The image is a plot with a grey-scale colour map representing continuum intensity. A red circle
// indicates the positional uncertainty region of FRB 20200120E. A black ellipse in the bottom-left corner
// represents the beam. There are several dark patches, indicating absorption or low continuum intensity. Panel
// c: This is a 340-MHz VLITE continuum image. The x-axis represents RA in J2000 coordinates, ranging from 9h 37m
// 52s to 9h 37m 58s. The y-axis is not labelled but appears to represent Dec in J2000 coordinates. The image is
// a plot with a grey-scale colour map representing continuum intensity. A red circle indicates the positional
// uncertainty region of FRB 20200120E. There is a large dark patch on the left side, indicating low continuum
// intensity or absorption. The scales of the three panels are very different.
#figure(placement: top, [#block[
  #box(image("imgs/fig_continuum_evn_vla.png", width: 95.0%))
  ]],
  caption: [#strong[Continuum maps of the field around FRB~20200120E.] #strong[a:] 1.4-GHz EVN continuum image after combining the three epochs (EK048B, EK048C, and EK048F); #strong[b:] 1.5-GHz #emph[Realfast], and #strong[c:] 340-MHz VLITE continuum image. The red circles indicate the $10 sigma$ (for EVN) and $1000 sigma$ (for #emph[Realfast], VLITE) positional uncertainty region of FRB~20200120E. Note the very different scales between the three panels. We clip all values below zero and above $"60" thin "mu" thin "Jy" thin "beam"^(-1)$ (EVN), $"50" thin "mu" thin "Jy" thin "beam"^(-1)$ (#emph[Realfast]) and $"3" thin "mJy" thin "beam"^(-1)$ (VLITE) for visualisation purposes. The black ellipse in the bottom left corner of each panel indicates the synthesised beam size and position angle.
  ]
)
<fig:continuum-images>



#figure([
#align(center)[#table(
    stroke: none,
    columns: 7,
    align: (left,center,center,center,center,center,center,),
    table.hline(stroke: 0.8pt),
    [], [], [Fluence$""^(b , c)$], [], [Peak Flux], [Width$upright(""^d)$], [Gate width $""^(upright(e))$],
    [Burst], [MJD $upright(""^a)$], [ \[Jy ms\]], [Peak S/N$upright(""^c)$], [Density$""^(b , c)$ \[Jy\]], [\[$mu$s\]], [ \[$"mu" thin "s"$\]],
    table.hline(stroke: 0.5pt),
    [B1], [59265.88304437179], [$0.13 plus.minus 0.03$], [7.8], [$0.9 plus.minus 0.2$], [156 $plus.minus$ 1], [290],
    [B2], [59265.88600912486], [$0.63 plus.minus 0.12$], [54.9], [$6.6 plus.minus 1.3$], [62 $plus.minus$ 1, 93 $plus.minus$ 0.5 $upright(""^f)$], [150],
    [B3], [59280.69618745651], [$0.52 plus.minus 0.10$], [64.5], [$7.8 plus.minus 1.6$], [46.7 $plus.minus$ 0.1], [126],
    [B4], [59280.80173397988], [$0.71 plus.minus 0.14$], [47.0], [$5.7 plus.minus 1.2$], [117 $plus.minus$ 1], [386],
    [B5], [59332.50446581106], [0.09 $plus.minus$ 0.02], [11.6], [1.4 $plus.minus$ 0.3], [56.6 $plus.minus$ 0.1], [173],
    table.hline(stroke: 0.8pt),
    table.cell(align: left, colspan: 7)[$upright(""^a)$ Corrected to the Solar System Barycentre and to infinite frequency assuming a dispersion measure of $87.75$ pc cm$""^(- 3)$,],
    table.cell(align: left, colspan: 7)[reference frequency 1502 MHz and dispersion constant of 1/(2.41$times 10^(- 4)$) MHz$""^2$ pc$""^(- 1)$ cm$""^3$ s.],
    table.cell(align: left, colspan: 7)[The times quoted are dynamical times (TDB).],
    table.cell(align: left, colspan: 7)[$upright(""^b)$ The receiver temperature of Effelsberg is 20 K and the telescope gain is 1.54 K Jy$""^(- 1)$. We additionally consider],
    table.cell(align: left, colspan: 7)[a sky background temperature of 0.8 K, by extrapolating from the 408 MHz map @remazeilles_2015_mnras,],
    table.cell(align: left, colspan: 7)[using a spectral index of $-$2.7 @reich_1988_aa, and 3 K from the cosmic microwave background],
    table.cell(align: left, colspan: 7)[@mather_1994_apj. We take a conservative 20 \% error on these measurements, arising due to the uncertainty],
    table.cell(align: left, colspan: 7)[in the Effelsberg receiver temperature and gain.],
    table.cell(align: left, colspan: 7)[$upright(""^c)$ Computed using the frequency range over which the burst is bright.],
    table.cell(align: left, colspan: 7)[$upright(""^d)$Defined as $1 / sqrt(2)$ multiplied by the full-width at half-maximum of the autocorrelation function (ACF).],
    table.cell(align: left, colspan: 7)[Note we use the $plus.minus 2 sigma$ burst width region to determine the burst fluence (see Nimmo et al. (submitted) for details).],
    table.cell(align: left, colspan: 7)[$upright(""^e)$ Width of the gate used for the interferometric correlation of each burst. For B2 the gate was centered on the first, brighter],
    table.cell(align: left, colspan: 7)[component to maximise S/N.],
    table.cell(align: left, colspan: 7)[$upright(""^f)$ Width per burst component.],
)]],
  caption: [Burst properties.],
  kind: table,
)
<tab:pol_properties>





#heading(level: 1, numbering: none)[Methods]
<methods>


#heading(level: 2, numbering: none)[Observations and Data reduction]
<sec:observations>


#heading(level: 3, numbering: none)[VLBI observations]
<vlbi-observations>


As part of our ongoing very long baseline interferometry (VLBI) campaign called PRECISE (Pinpointing REpeating ChIme Sources with the EVN), we observed the field centred on the coordinates from the discovery@bhardwaj_2021_apjl of FRB~20200120E: RA (J2000) $= 09^(upright(h)) 57^(upright(m)) 56.688^(upright(s))$,~Dec (J2000) $= 68^compose 49' 31.8^('')$. The quoted 90\% confidence interval@bhardwaj_2021_apjl of radius $tilde 1.5'$~is well covered by the field of view of the #emph[ad-hoc] interferometric array we used to observe, which is comprised of dishes that are also part of the EVN. We observed the field 15 times between February and May 2021 (@tab:all-precise-runs-on-m81), with burst detections in the data that were taken on 2021 February 20 UT 17:00--22:00 (project code PR141A), 2021 March 7 UT 15:45--20:45 (PR143A), and 2021 April 28 UT 11:00--22:00 (PR158A). We observed in the 21-cm band ($tilde 1.4$ GHz) with slightly different array setups in each run. Depending on the capabilities at each station, we recorded either 128 or 256 MHz of total bandwidth, divided into 8 or 16 subbands of 16 MHz each. The participating stations and their respective frequency coverage are summarised in @tab:stations. We ran regular phase-referencing observations with a cycle time of 7.5 min; that is, 5.5 minutes on target and 2.0 minutes on the phase calibrator (J0955$+$6903, at $approx 0.32^compose$ separation). In total, we spent 2.93 hrs on the target field in each of PR141A and PR143A, and 6.73 hrs in PR158A. The calibrator source J1048$+$7143 served as fringe finder and bandpass calibrator and was observed twice for 5 minutes in each run. For verification and single-dish time-domain calibration purposes we observed the pulsar B0355$+$54 for 2 minutes in PR141A and PR143A. In PR158A the pulsar B2255$+$58 was observed for 5 minutes for the same reason.


We recorded raw voltages ('baseband' data, dual circular polarisation, 2-bit sampling) in VDIF @whitney_2010_ivs or Mark5B@whitney_2004_evn format at all stations. At Effelsberg we also recorded total intensity filterbanks with the PSRIX pulsar backend @lazarus_2016_mnras in parallel to the voltage data. These data span the frequency range of $1255$--$1505$ MHz with a time and frequency resolution of 102.4 $mu$s and 0.49 MHz, respectively. Similarly, at SRT we also recorded in parallel baseband data and total intensity filterbanks (with the local Digital Filter Bank system, DFB). These DFB-filterbanks have a time and frequency resolution of 128 $mu$s and 1 MHz, respectively, covering the frequency range of 1140.5--2163.5  MHz out of which we search the usable range of 1210.5--1739.5 MHz.


The data from both Effelsberg and SRT were searched for bursts in two independent pipelines. The baseband data were processed with the pipeline outlined in #cite(<kirsten_2021_natas>, form: "prose"), which converts the raw voltages to filterbank format (in this case, total intensity with time resolution 64 $mu$s~and frequency resolution 125 kHz) and searches those with `Heimdall` within $plus.minus 50 thin$pc cm$""^(- 3)$ of the expected $"DM" = "87.818"$pc cm$""^(- 3)$, as found by #cite(<bhardwaj_2021_apjl>, form: "prose"). The burst candidates are classified as either radio frequency interference (RFI) or potential FRBs using the neural network classifier FETCH @agarwal_2020_mnras. The filterbanks as recorded with the respective pulsar backends were searched with a pipeline that uses the PRESTO suite of tools @ransom_2001_phdt @ransom_2011_ascl and a classifier based on work by #cite(<michilli_2018_mnras>, form: "prose").


Correlation of the data was performed at the Joint Institute for VLBI ERIC (JIVE; in the Netherlands) under proposal EK048 (with codes EK048B for PR141A, EK048C for PR143A, and EK048F for PR158A). In total, we ran three correlator passes using the software correlator SFXC~@keimpema_2015_exa in the first run we correlate all scans containing the calibrator sources with a standard 2-s time integration and 64 channels per 16-MHz subband. A second correlation pass was performed only on the data containing bursts (their arrival times were determined via the search described above), with a higher frequency resolution (8 192 channels per subband) and time resolution (the correlation gates around the bursts were chosen manually to optimise the signal-to-noise for each burst, @tab:pol_properties). The strongest bursts allowed a direct fringe fit on their data, which provided a first estimate of their sky position to a level of a few arcseconds: RA (J2000) $approx 09^(upright(h)) 57^(upright(m)) 54.8^(upright(s))$,~Dec (J2000) $approx 68^compose 49' 03^('')$. We then used this position to re-correlate the burst data at the same frequency resolution as in the first correlation pass. This allowed us to directly apply the calibration performed on the first pass (containing the calibrator sources) to the data containing bursts.


The full data reduction was performed using the Astronomical Image Processing System @greisen_2003_assl and Difmap @shepherd_1994_baas following standard procedures. #emph[A-priori] amplitude calibration was performed using the known gain curves and system temperature measurements recorded at each station during the observation. These data were not available for Toruń and Irbene in EK048B, and for Urumqi in EK048C. We used nominal system equivalent flux density values and flat gain curves to perform the amplitude calibration in these cases. In EK048C, the data from Urumqi were flagged due to the impossibility to properly convert the locally-recorded linear polarizations into circular ones (as in the rest of the antennas). Ionospheric dispersive delays were calculated from maps of total electron content provided by the global positioning system satellites and removed via the `TECOR` task in `AIPS`. We first corrected for the instrumental delays and bandpass calibration using the calibrator source J1048+7143, and thereafter fringe-fit the data using all calibrator sources. The phase calibrator (J0955+6903; displaying a peak brightness of $tilde 73 thin "mJy" thin "beam"^(-1)$) was then imaged and self-calibrated to improve the final calibration of the data (for both phases and amplitudes). A common source model for the phase calibrator was used to improve the calibration of both epochs. The obtained solutions were then transferred to the burst data, which were finally imaged.


In the third, and final, correlator pass we processed the entire observation, correlating all scans from the target with the same time and frequency setup as in the first correlator pass, in order to obtain a deep continuum image of the field.


#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (left,center,center,center,),
    table.hline(stroke: 0.8pt),
    [Observation], [EVN], [], [],
    [Project code], [Project code], [Start MJD], [Stop MJD],
    table.hline(stroke: 0.5pt),
    [PR141A$""^(upright(a))$], [EK048B], [59265.708], [59265.916],
    [PR143A$""^(upright(a))$], [EK048C], [59280.656], [59280.864],
    [PR144A], [], [59283.792], [59284.000],
    [PR145A], [], [59289.750], [59289.958],
    [PR146A], [], [59295.667], [59295.875],
    [PR153A], [], [59314.887], [59314.972],
    [PR158A$""^(upright(a))$], [EK048F], [59332.458], [59332.916],
    [PR159A], [], [59336.708], [59337.000],
    [PR160A], [], [59341.833], [59342.072],
    [PR161A], [], [59344.771], [59344.875],
    [PR162A], [], [59346.646], [59346.895],
    [PR163A], [], [59347.417], [59347.625],
    [PR164A], [], [59351.917], [59352.166],
    [PR165A], [], [59358.917], [59359.166],
    [PR166A], [], [59360.708], [59360.916],
    table.cell(align: left, colspan: 3)[$""^(upright(a))$Epoch with detection], [],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Time ranges of PRECISE runs targeting FRB~20200120E between February and May 2021]
  , kind: table
  )
<tab:all-precise-runs-on-m81>



#figure([
#align(center)[#table(
    stroke: none,
    columns: 4,
    align: (left,center,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Telescope], [Frequency coverage \[MHz\]], [Station project code], [EVN project code],),
    table.hline(),
    [Effelsberg (Ef)], [$1254 - 1510$], [94-20], [EK048B/C/F$""^(upright(b))$],
    [Medicina (Mc)], [$1350 - 1478$], [44-20], [EK048B/C/F$""^(upright(c))$],
    [Noto (Nt)], [$1318 - 1574$], [44-20], [EK048C],
    [Irbene (Ir)], [$1382 - 1510$], [--], [EK048B/C/F],
    [Toruń (Tr)], [$1254 - 1510$], [DDT$""^(upright(a))$], [EK048B/C/F$""^(upright(b))$],
    [Westerbork (Wb)], [$1382 - 1510$], [DDT$""^(upright(a))$], [EK048B/C/F],
    [Urumqi (Ur)], [$1382 - 1510$], [DDT$""^(upright(a))$], [EK048C/F],
    [Sardinia (Sr)], [$1360 - 1488$], [44-20], [EK048F],
    [Onsala (O8)], [$1382 - 1510$], [DDT$""^(upright(a))$], [EK048BF$""^(upright(b))$],
    [Badary (Bd)], [$1382 - 1510$], [DDT$""^(upright(a))$], [EK048F],
    [Svetloe (Sv)], [$1382 - 1510$], [DDT$""^(upright(a))$], [EK048F],
    [Zelenchukskaya (Zc)], [$1382 - 1510$], [DDT$""^(upright(a))$], [EK048F],
    [VLA-VLITE], [$320 - 384$], [20B-280], [--],
    [VLA-#emph[Realfast]], [$1300 - 1700$], [20B-280], [--],
    table.hline(stroke: 0.8pt),
    table.cell(align: left, colspan: 4)[$""^(upright(a))$Director's Discretionary Time],
    table.cell(align: left, colspan: 4)[$""^(upright(b))$Only stations recording the part of the band where the burst (B5) was detected with significant emission.],
    table.cell(align: left, colspan: 4)[$""^(upright(c))$Only one subband overlapping with the part of the band where the burst (B5) was detected with significant emission.],
)]],
  caption: [Setups at the different stations during observations used in the analysis],
  kind: table,
)
<tab:stations>


#heading(level: 3, numbering: none)[VLA]
<vla>


We observed the field of FRB~20200120E with the Karl G. Jansky Very Large Array (VLA) as part of a program to localise repeating FRBs identified by CHIME/FRB (program 20B-280). The field was observed in five 1-hour blocks from 2020 December 29 through 2021 January 18. Data were recorded in parallel at both $1.5 thin$GHz and $340 thin$MHz. The VLA antennas were arranged in the A configuration, which provides baseline lengths up to 30 km and a typical spatial resolution of 1.3$""^('')$~and 6.0$""^('')$~at $1.5 thin$GHz and $340 thin$MHz, respectively. The total on-target integration time amounts to 200 minutes.


==== Realfast
<realfast>


Visibility data from the VLA observations were recorded with a sampling time of 3 seconds from 1 to 2 GHz. Simultaneously, a copy of the data with sampling time of 10 ms was streamed into the #emph[Realfast] system @law_2018_apjs. We used #emph[Realfast] to search this data stream for FRBs in real time. The typical $1 sigma$ sensitivity of the VLA is 5 mJy beam$""^(- 1)$ in 10 ms.


The standard (slow) visibility data were analyzed to search for persistent emission associated with the FRB location. We calibrated the data with the VLA calibration pipeline (version 2020.1) using 3C147 as a flux calibrator. Calibrated visibilities for all five epochs were combined and imaged with CASA (version 6.1).


We imaged the data with robust weighting of 0.5 and removed baselines shorter than $100 lambda$ to reduce the effects of RFI. This produced an image with a synthesized beam size of 2$""^('')$~by 1$""^('')$~with position angle of $126^compose$. The sensitivity in the combined image is $"6.5" thin "mu" thin "Jy" thin "beam"^(-1)$, which is consistent with expectations given the usable bandwidth of $400 thin$MHz.


==== VLITE
<vlite>


The VLA Low-band Ionosphere and Transient Experiment @polisensky_2016_apj @clarke_2016_spie is a commensal instrument on the VLA that records and correlates data from a 64-MHz subband at a central frequency of $tilde 340 thin$MHz. It operates on up to 18 antennas during nearly all regular VLA operations. All VLITE data were processed within the VLITE-Fast GPU-based real-time system to search the incoming voltage stream for dispersed transients @bethapudi_2021_rnaas. For imaging purposes, primary calibration and editing for each day of visibility data were carried out with the automated VLITE processing pipeline. Due to radio interference from satellites at the upper end of the band, the final usable bandwidth was 38.2 MHz centred at 340.85 MHz. The data were subsequently combined, imaged and self-calibrated in amplitude and phase using the `Obit` task `MFImage` @cotton_2008_pasp. In order to reduce artefacts from the bright extended radio galaxy M82 located $tilde 1^compose$ northwest of the target position, baselines shorter than 4.0 k$lambda$ were removed at this point. The final image was created in `WSClean` @offringa_2014_mnras, and corrected for the offset primary beam response of VLITE. The image has an rms of $"320" thin "mu" thin "Jy" thin "beam"^(-1)$, and a beam of 10.1$""^('')$~by 3.6$""^('')$~at a position angle of $132^compose$.


#heading(level: 3, numbering: none)[Archival optical and high energy data]
<archival-optical-and-high-energy-data>


==== Hyper Suprime-Cam
<hyper-suprime-cam>
The field around M81 has been well-observed over the years by multiple telescopes. We retrieved archival data from the Hyper Suprime-Cam on the 8.1-m Subaru telescope @miyazaki_2012_spie using the SMOKA interface. We chose images with seeing better than 0.7″. We processed the $g'$, $r'$, and $i'$ band images with the `hscpipev8.4` pipeline @bosch_pasj_2018. The pipeline uses the PanSTARRs catalogue @flewelling_2020_apjs as an astrometric and photometric reference. The typical astrometric residuals were $tilde 50$--60 mas, which is the uncertainty we have assumed to tie the optical and the radio reference frames.


==== #emph[Gaia]
<gaia>
\[PR95\]~30244 also appears in the #emph[Gaia] Early Data Release 3 Catalogue@gaia_2016_aanda @gaia_2021_aanda with Source ID 1070264274879949184, and position RA (J2000) $= 9^(upright(h)) 57^(upright(m)) 54.71402^(upright(s)) plus.minus 1.6 thin "mas"$,~Dec (J2000) $= 68^compose 49' 0.7775^('') plus.minus 1.7 thin "mas"$. This position is consistent (within $< 3 sigma$ confidence level) with the one we have derived from the Hyper Suprime-Cam data. The observed offset allowed us to estimate the possible systematic uncertainties in the optical image registration error ($15 thin "mas"$\; by adding in quadrature the observed offset between the the #emph[Gaia] position and the one we determined, plus the uncertainties on the positions).


==== #emph[Chandra] X-ray Observatory
<chandra-x-ray-observatory>


Several deep archival X-ray observations are available for the field around M81 from #emph[XMM] and #emph[Chandra]. We selected the archival observation with the longest exposure time that covers the location of FRB~20200120E, a 26 ks #emph[Chandra] observation @garmire_2003_spie to probe for an X-ray source. The data were reduced using CIAO version 4.12 @fruscione_2006_spie following standard procedures. As the source was located about 14$′$~off-axis, events were extracted in a large 10$""^('')$-radius region centred on the position of FRB~20200120E. We also extract events from a 60$""^('')$-radius region away from the source at a similar off-axis angle to estimate the background count rate. The X-ray count-rate in the source extraction region, $4.4 times 10^(- 6)$ counts s$""^(- 1)$ arcsec$""^(- 2)$, is consistent with the background region rate of $3.9 times 10^(- 6)$ counts s$""^(- 1)$ arcsec$""^(- 2)$. To place a limit on an X-ray source at the location of FRB~20200120E~we use the Bayesian method of #cite(<kraft_1991_apj>, form: "prose"), which results in a 0.5--10 keV source count rate upper limit of $1 times 10^(- 3)$ counts s$""^(- 1)$ (3$sigma$). Taking into account the spectral response for the off-axis location of the source (via an ancillary response file created by the CIAO tool `specextract`), and assuming a photoelectrically absorbed power-law source spectrum with a spectral index of $Gamma = 2$ and a hydrogen column density of $N_(upright(H)) = 10^21$ cm$""^(- 2)$, this count rate limit corresponds to a 0.5--10 keV absorbed flux upper limit of $1 times 10^(- 14)$ erg cm$""^(- 2)$ s$""^(- 1)$.


==== #emph[Fermi]-LAT
<fermi-lat>


The Large Area Telescope (LAT) onboard the #emph[Fermi] satellite provides a uniform sensitivity survey of the whole sky in the energy range between 100~MeV and 300~GeV. We searched all of the publicly available catalogues for counterparts up to the latest published@ballet_2020_arxiv release, 4FGL-DR2, with null results. However, even the most luminous known Galactic globular cluster (Terzan5), whose luminosity is $( 42.4 plus.minus 1.5 ) times 10^34$ erg s$""^(- 1)$ in the $0.1$--$100$ GeV energy range@abdo_2010_AandA, would have a gamma-ray flux of only $( 2.00 plus.minus 0.07 ) times 10^(- 16)$ erg cm$""^(- 2)$ s$""^(- 1)$ at the distance of M81. This is nearly three orders of magnitude dimmer than the faintest source detected in the 4FGL-DR2 catalogue.


#heading(level: 2, numbering: none)[Analysis]
<analysis>


#heading(level: 3, numbering: none)[Dispersion measure refinement]
<dispersion-measure-refinement>


To refine the DM for further analysis, we maximised the signal to noise ratio (S/N) of a very narrow spike in B3@nimmo_2021_arxiv (#ref(<fig:bursts>)g) and find $"DM" = "87.7527" plus.minus "0.0003"$pc cm$""^(- 3)$. This value is comparable to, but formally deviates from $"DM" = "87.818" plus.minus "0.007"$pc cm$""^(- 3)$~found by #cite(<bhardwaj_2021_apjl>, form: "prose"), where a weighted average of three bursts was used. Possible explanations for this discrepancy are the lack of short-timescale structure in the CHIME/FRB bursts@bhardwaj_2021_apjl, the potential for non-dispersive time-frequency drifting@hessels_2019_apjl or a time-variable DM.


#heading(level: 3, numbering: none)[Milliarcsecond localization of FRB~20200120E]
<milliarcsecond-localization-of-frb-20200120e>


We imaged both the individual bursts separately, as well as a data set produced by the combination of all individual burst visibilities. #ref(<fig:localisation-maps>)a-d display the dirty maps (i.e.~the inverse Fourier Transform of the visibilities without applying any deconvolution, i.e. 'CLEANing') of the bursts that were detectable in the correlated data, using a natural weighting of the data. B1 was too faint to produce a useful image, and we therefore exclude it from the localisation analysis. B5 was only detected in the lower half of the observed band, where most of the antennas were not recording (see @tab:stations). We therefore only used data from this part of the band. #ref(<fig:localisation-maps>)e shows the dirty map of the combined data of the visibilities from all bursts. In this map we obtained an emission pattern consistent with the one expected from the dirty beam (the inverse Fourier Transform of a point-like source), allowing us to unambiguously identify the position of FRB~20200120E. The observed emission reached a $12 sigma$ confidence level, with the secondary sidelobes in the fringe pattern being $tilde 66 "%"$ of the peak emission. This provided a robust localization in the map, as it would require a noise fluctuation of $gt.tilde 7 sigma$ to produce such peak emission. We also conducted different approaches during the imaging of the data: different weighting schemes, and selecting different subsets of antennas in the array. The derived position of FRB~20200120E was robust across all these approaches. #ref(<fig:localisation-maps>)f displays the final, 'CLEANed', image of the combined bursts.


The final coordinates of FRB~20200120E are RA (J2000) $= 9^(upright(h)) 57^(upright(m)) 54.69935^(upright(s)) plus.minus 1.2 thin "mas"$,~Dec (J2000) $= 68^compose 49' 0.8529^('') plus.minus 1.3 thin "mas"$. We note that the quoted uncertainties reflect the statistical uncertainties from the measured position of FRB~20200120E ($0.7$ and $0.4$ mas in RA and DEC, respectively), the uncertainties in the absolute International Celestial Reference Frame position of the phase calibrator (J0955$+$6903; 0.11 mas), and the systematic uncertainty associated with the phase-referencing technique@kirsten_2015_aanda of $tilde 0.9$ and $1.2$ mas, in RA and DEC, respectively.


We combined the continuum VLBI data from the three epochs to produce a deep image of the field around FRB~20200120E to search for persistent emission. No significant sources above a $5 sigma$ confidence level (with an rms of $10 thin "mu" thin "Jy" thin "beam"^(-1)$) are detected on milliarcsecond scales (#ref(<fig:continuum-images>)a). In the VLA data taken at $1.5 thin$GHz (#ref(<fig:continuum-images>)b), we did identify two sources with peak brightness of $110 thin "mu" thin "Jy" thin "beam"^(-1)$ and $73 thin "mu" thin "Jy" thin "beam"^(-1)$, and offset by $6 ""^('')$ and $9 ""^('')$, respectively. The projected density of radio sources of this brightness is roughly 1 000 to 3 000 per square degree @condon_2012_apj. Therefore, we expect between $1$--$3$ sources within $1 ′$ of FRB~20200120E by chance. The closer of the two nearby radio sources is within $0.2 ""^('')$ of a PS1 source with $i = 21.3 thin "mag"$. This host galaxy has a photometric redshift in the PS1 STRM catalogue @beck_2021_mnras of $0.67 plus.minus 0.2$, so it is most likely a background galaxy. The other identified radio source has no PS1 counterpart. We note that neither of these two sources exhibit significant compact emission on milliarcsecond scales.


#heading(level: 3, numbering: none)[\[PR95\]~30244 and chance coincidence probability]
<pr95-30244-and-chance-coincidence-probability>
We measured the full-width at half maximum (FWHM; "seeing") of the coadded $i'$, $r'$, and $g'$ images of \[PR95\]~30244 to be 0.63″, 0.57″, and 0.62″, respectively, using profile fits to bright, isolated stars. The brightness distribution of \[PR95\]~30244 has an FWHM of 0.77″, 0.70″, and 0.75″ in the same three images. Subtracting the FWHMs of the isolated stars in quadrature, we estimate that the intrinsic FWHM of \[PR95\]~30244 is about 0.42″, corresponding to about 7.4 pc at a distance of 3.63 Mpc.


To estimate the probability of chance coincidence@bloom_2002_aj for an M81 globular cluster in the FRB localisation region, we use a circular localisation region with a radius $R = max {2 R_"eff"}$ of \[PR95\]~30244, i.e. its maximum seeing-limited size in the Hyper Suprime-images, $R = 0.77″$. Perelmuter & Racine@perelmuter_1995_aj_109 parameterized the projected areal number density ($rho_"GC" / "arcmin"^2$) of the M81 globular clusters as a function of their angular offset from M81 ($r$, in arcmin) as, $log_10 ( rho_"GC" ) = - 2.07 times log_10 ( r ) + 0.82 plus.minus 0.05$, for $0 lt.eq log_10 ( r ) lt.eq 1.4$. At the offset of FRB~20200120E from M81 ($19.6 ′$), $rho_"GC" = 0.014 "arcmin"^(- 2) approx 3.8 times 10^(- 6) "arcsec"^(- 2)$. Assuming a Poisson distribution of M81 globular clusters at $r = 19.6 ′$, the probability of finding at least one globular cluster by chance within a radius $R$ is given by $P_"cc" = 1 - exp ( - pi R^2 rho_"GC" ) approx 7 times 10^(- 6)$. A more conservative estimate of $P_"cc"$ can be derived by assuming that all the predicted $300 plus.minus 100$ M81 globular clusters @harris2013 are uniformly distributed within the angular area of radius = $19.6 ′$ so that $rho_"GC" = 4.6$--$9.2 times 10^(- 5)$, and consequently $P_"cc"$ = 0.85$- 1.7 times 10^(- 4)$. From such a very low $P_"cc"$ value, we conclude that the association of FRB~20200120E and \[PR95\]~30244 is robust.


#heading(level: 3, numbering: none)[Modelling of \[PR95\]~30244]
<modelling-of-pr95-30244>


To estimate important physical properties of \[PR95\]~30244, such as its stellar mass, metallicity, stellar population age and V-band extinction, we used the `Prospector` code @Leja2017 @prospect2019 for stellar population inference. We modelled the SDSS photometry (#ref(<filter:maggies>, supplement: [Table]), from the SDSS DR12 catalogue@aaa2015) of \[PR95\]~30244 and fit a five-parameter (@tab:sfhmodel) 'delayed-tau' model for the star formation rate $"SFR" ( t ) prop t exp ( - t / tau )$, where $t$ is the time since the formation epoch of the galaxy, and $tau$ is the characteristic decay time of the star-formation history of \[PR95\]~30244 @simha2014 @carnall2019ApJ. As we are modelling a globular cluster, we did not include nebular line emission but only enabled a dust emission model@draine2007 in our fitting. The best-fit spectral energy distribution (SED) profile of \[PR95\]~30244 is shown in @fig:sed. `Prospector` also enables Markov Chain Monte Carlo (MCMC) sampling of the posterior to estimate uncertainty in the best-fit values of the physical properties of \[PR95\]~30244. We show the corner plot of the MCMC-analysis in @fig:mcmc and list the results in @tab:gc-properties. Using the relation@bertelli1994, \[Fe/H\] = 1.024 $times$ log(Z/Z$""_⊙$), we estimate the \[Fe/H\] of \[PR95\]~30244 = $- 1.83_(- 0.87)^(+ 0.86)$, which is in good agreement with earlier estimates@ma_2007_pasp @perelmuter_1995_aj_110. We can get an estimate of the velocity dispersion ($sigma_(upright(r))$) of \[PR95\]~30244 using the virial theorem: $sigma_(upright(r)) tilde sqrt((2 G M)/(3 R_(e f f)))$, where G is the gravitational constant. Using the M and R$""_"eff"$ values of \[PR95\]~30244 from @tab:gc-properties, we estimate $sigma_(upright(r)) tilde 22 thin "km" thin "s"^(-1)$.


#heading(level: 3, numbering: none)[Possible MIC-models for the formation of FRB~20200120E]
<possible-mic-models-for-the-formation-of-frb-20200120e>
The most likely of the MIC-models is that of a merging WD-WD system as those dominate the cores of globular clusters@kremer_2021_arxiv, while a NS-NS progenitor system is less probable @ye_2020_apjl. A typical globular cluster with a total mass of $tilde thin "2" times "10"^("5") thin "M"_(⊙)$ can host $10 - 20$ MSPs formed via AIC or MIC@ye_2019_apj. At birth, such NSs would be extreme objects with high rotation rates and strong magnetic fields, potentially capable or generating FRBs. We note that the metallicity limit ($"log" thin "[" thin "Fe" / "H" thin "]" > - "0.6"$) set for the formation of young NSs in globular clusters@boyles_2011_apj is much higher than the metallicity that we estimate for \[PR95\]~30244~($"log" thin "[" thin "Fe" / "H" thin "]" = - "1.83"$, @tab:gc-properties). Nevertheless, non-recycled pulsars have been found towards some globular clusters@hessels_2015_aska @lyne_1996_apjl @boyles_2011_apj. These young pulsars are formed at a comparable rate to MSPs in globular clusters, but they have much shorter active lifetimes (Myr versus Gyr).


#heading(level: 3, numbering: none)[Constraints on the Galactic halo DM and RM]
<constraints-on-the-galactic-halo-dm-and-rm>
Since FRB~20200120E~is extragalactic, its dispersive delay is probing the full extent of the Milky Way ISM ($"DM"_("ISM")^("MW")$) and halo ($"DM"_("Halo")^("MW")$) along this line of sight. There are also extragalactic contributions from the intergalactic medium $"DM"_("IGM")$ and the host galaxy ($"DM"_("M81")$), leading to the total observed $"DM" = "DM"_("ISM")^("MW") + "DM"_("Halo")^("MW") + "DM"_("IGM") + "DM"_("M81")$. The intergalactic medium between the Milky Way and M81 contributes on the order@macquart_2020_natur of DM$""_"IGM" tilde 1$ pc cm$""^(- 3)$. To estimate DM$""_"M81"$, we only consider the contribution from the halo of M81, as both the M81 disk and the globular cluster make negligible contributions to the measured DM. The M81 halo DM contribution is estimated@bhardwaj_2021_apjl to be $tilde 15$--$50$~pc cm$""^(- 3)$ depending on the choice of a halo density profile and baryon fraction in the M81 halo. For the Galactic contribution, models of the Milky Way ISM predict DM$""_"ISM"^"MW" = 30$--$40$ pc cm$""^(- 3)$~in this direction @cordes_2002_arxiv @yao_2017_apj (with a shallow spacial gradient in the region, @fig:dm_rm_map). Using these estimates, we limit the Milky Way halo contribution to the FRB sight-line, which is poorly constrained by current observations @keating_2020_mnras, to $"DM"_("Halo")^("MW") = "DM" - "DM"_("ISM")^("MW") - "DM"_("IGM") - "DM"_("M81") lt.tilde 32$--$42$pc cm$""^(- 3)$. This is well in line with the models of #cite(<yamasaki_2020_apj>, form: "prose"), which predict $"DM"_("Halo")^("MW") = 10$--$30$ pc cm$""^(- 3)$, but lower than predicted in some other models@prochaska_2019_mnras.


Similar considerations are also applicable for the rotation measure@bhardwaj_2021_apjl $"RM" = - "36.9" thin "rad" thin "m"^(-2)$ as determined in the companion paper by Nimmo et al. (submitted). The Galactic contribution@hutschenreuter_2021_arxiv along the line of sight to FRB~20200120E~is $"RM" = - "17" plus.minus "4" thin "rad" thin "m"^(-2)$ (@fig:dm_rm_map). The contribution of the IGM is most likely minor, leaving only the MW halo, the M81 halo and the local environment of FRB~20200120E as contributing sources. The RMs of the MW- and M81-halo are likely small ($"|" thin "RM" thin "|" < "20" thin "rad" thin "m"^(-2)$), constraining $"RM"_("Local")$ to the range $"[" + "20" thin "," - "60" thin "]" thin "rad" thin "m"^(-2)$. This is comparable to earlier results@chime_2019_apjl for FRB~20180916B ($"RM" = - "115" thin "rad" thin "m"^(-2)$) but three orders of magnitude lower than the (highly variable) RM of FRB~20121102A @michilli_2018_natur. This indicates that models of FRB sources do not necessarily require extreme magneto-ionic environments, unless the magnetic fields along the line of sight to both FRB~20200120E~and FRB~20180916B~are strongly tangled, such that they result in a low net RM. More likely though, FRB~20121102A~resides in a very different environment giving rise to its observed properties.


// [figvision] imgs/dm_rm_combined_ymw16_hutschenreuter_with_names.png
// Panel a: This is a plot showing the Dispersion Measure (DM) contribution. The x-axis represents Right
// Ascension, ranging from approximately 7 hours to 12 hours. The y-axis represents Declination, ranging from 50
// degrees to 80 degrees. The colour gradient in the background represents the expected Galactic DM contribution
// according to the YMW16 model, ranging from 10 to 100 pc cm^-3. There are several white circles representing
// known pulsars from the ATNF Pulsar Catalogue, labelled with their names (e.g., PSR J1137+7528). A green
// pentagon marks the position of FRB 20200120E. The trend shows that the DM contribution increases towards the
// top left of the panel. Panel b: This is a plot showing the physical Galactic Faraday depth. The x-axis
// represents Right Ascension, ranging from approximately 7 hours to 12 hours. The y-axis represents Declination,
// ranging from 50 degrees to 80 degrees. The colour gradient represents the Rotation Measure (RM), ranging from
// -60 to 60 rad m^-2, with red indicating positive values and blue indicating negative values. There are several
// white circles representing galactic pulsars with known RM values, labelled with their names (e.g., PSR
// J0814+7429). A grey pentagon marks the position of FRB 20200120E. The trend shows that the RM values vary
// across the panel, with some regions having positive values and others having negative values.
#figure(scope: "parent", [#block[
  #box(image("imgs/dm_rm_combined_ymw16_hutschenreuter_with_names.png", width: 50.0%))
  ]],
  caption: [ #strong[Dispersion measure (DM) and rotation measure (RM) maps around FRB~20200120E:] Panel #strong[a] shows the expected Galactic DM contribution (background) according to the YMW16 model @yao_2017_apj, the DM of FRB~20200120E (pentagon) and the DMs of known pulsars from the ATNF Pulsar Catalogue in this field @hobbs_2004_iaus. Panel #strong[b] shows the physical Galactic Faraday depth $phi.alt_"g"$ @hutschenreuter_2021_arxiv, the RM of FRB~20200120E (pentagon) and galactic pulsars with a known RM (circles). We assume that the RM@bhardwaj_2021_apjl of FRB~20200120E is $- "36.9" thin "rad" thin "m"^(-2)$ (also see Nimmo et al. (submitted) for details).
  ]
)
<fig:dm_rm_map>



#figure(placement: top, 
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,center,center,),
    table.hline(stroke: 0.8pt),
    table.header([Property], [Value], [Reference],),
    table.hline(),
    [Metallicity $"log" \[ "Z" / "Z"_⊙ \]$], [$- 1.74_(- 0.90)^0.80$], [this work],
    [Metallicity \[Fe/H\]], [-1.83$""_(- 0.87)^0.86$], [this work],
    [Stellar mass $"log" \[ "M" / "M"_(⊙) thin "]"$], [$5.77_(- 0.22)^0.19$], [this work],
    [Effective radius (R$""_"eff"$/pc)], [3.7], [this work],
    [Age (Gyr)], [9.13$""_(- 4.18)^3.27$], [this work],
    [$"(" thin "u" - "r" thin ")"_("0")^("a")$ (AB mag)], [1.96(2)], [@alam_2015_apjs],
    [E(V$-$B)$upright(""^b)$], [0.2$""_(- 0.1)^0.1$], [this work],
    [$sigma_(upright(r))$ (km s$""^(- 1)$)], [22], [this work],
    [Absolute r-band mag. (AB)], [$-$8.4], [--],
    [Luminosity distance (Mpc)], [3.6], [@karachentsev_2005_aj],
    table.hline(stroke: 0.8pt),
    table.cell(align: left, colspan: 3)[$upright(""^b)$ Milky Way extinction is corrected using a],
    table.cell(align: left, colspan: 3)[reddening map @sfd1998.],
    table.cell(align: left, colspan: 3)[$upright(""^c)$ Using R$""_v$ = 3.1.],
  )]
  , caption: [Notable properties of \[PR95\]~30244.]
  , kind: table
  )
<tab:gc-properties>



#figure(
  align(center)[#table(
    stroke: none,
    columns: 4,
    align: (left,left,left,left,),
    table.hline(stroke: 0.8pt),
    [], [], [Effective], [Flux density],
    [Instrument], [Filter], [Wavelength \[Å\]], [\[maggie\]$upright(""^a)$],
    table.hline(stroke: 0.5pt),
    [SDSS], [u], [3546], [2.92$times 10^(- 9)$],
    [], [$g$], [4670], [1.05 $times 10^(- 8)$],
    [], [$r$], [6156], [1.77$times 10^(- 8)$],
    [], [$i$], [7472], [2.04$times 10^(- 8)$],
    [], [$z$], [8917], [2.33$times 10^(- 8)$],
    table.cell(align: left, colspan: 4)[$upright(""^a)$ The flux densities are assigned a 20\% fractional],
    table.cell(align: left, colspan: 3)[uncertainty. Note that 1 maggie is defined], [],
    table.cell(align: left, colspan: 3)[as the flux density in Jansky divided by 3631.], [],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [Broadband SDSS filters used to model the SED of \[PR95\]~30244. ]
  , kind: table
  )
<filter:maggies>



#figure(
  align(center)[#table(
    stroke: none,
    columns: 3,
    align: (left,left,left,),
    table.hline(stroke: 0.8pt),
    table.header([Parameter], [Description], [Prior],),
    table.hline(),
    [log(M/M$""_⊙$)], [total stellar mass formed], [uniform: min=3, max=7],
    [log(Z/Z$""_⊙$)], [stellar metallicity], [top-hat: min=-3.5, max=0],
    [dust2], [diffuse V-band dust optical depth], [top-hat: min=0.0, max=2.0],
    [t$""_("age")$], [age of \[PR95\]~30244], [top-hat: min=0.1, max=13.8],
    [$tau$], [e-folding time of the SFH], [uniform: min=0.1, max=30],
    table.hline(stroke: 0.8pt),
  )]
  , caption: [ Free parameters and their associated priors for the Prospector 'delayed tau' model.]
  , kind: table
  )
<tab:sfhmodel>



// [figvision] imgs/M81R_model_SED_with_uncertainty.png
// Panel a: This is a plot showing the spectral energy distribution of a galaxy, PR95 ~30244. The x-axis
// represents wavelength in Angstroms, ranging from 3 × 10^3 to 10^4. The y-axis represents flux density, scaled
// by 3631 Jy, with a range of 10^-10 to 10^-8. The plot includes a blue line for the model spectrum, with a
// shaded region around it, and blue squares for model photometry. Red symbols with error bars represent observed
// photometry. Five grey filter response curves are shown for SDSS-u, g, r, i, and z bands. The model spectrum
// increases with wavelength, matching observed photometry points.
#figure(scope: "parent", image("imgs/M81R_model_SED_with_uncertainty.png", width: 95.0%),
  caption: [
    #strong[Modelling the SED of \[PR95\]~30244.] The Milky Way extinction corrected flux densities of \[PR95\]~30244 in different wavelength bands are plotted along with the best fit `Prospector` model spectrum. To assess the quality of the `Prospector` model, the modelled and actual photometric data are also shown. The best fit model profile is used to estimate the physical properties of \[PR95\]~30244 stated in @tab:gc-properties. Finally, the shaded region around the best fitted profile is the one-$sigma$ uncertainty region.
  ]
)
<fig:sed>



// [figvision] imgs/M81R_model_MCMC_new.png
// Panel a: This is a histogram plot of the posterior probability distribution of log(mass). The x-axis ranges
// from 4.4 to 6.0 and has units of log(mass). There is one series, a grey histogram. There are no symbols or
// line styles. The median of the parameter posterior, 5.77, is printed above the histogram, along with the
// one-error bars, extending from 5.55 to 5.96. The trend shows a peak in the posterior probability distribution
// around log(mass) = 5.7. Panel b: This is a histogram plot of the posterior probability distribution of
// logzsol. The x-axis ranges from -3.2 to -0.8 and has units of logzsol. There is one series, a grey histogram.
// There are no symbols or line styles. The median of the parameter posterior, -1.74, is printed above the
// histogram, along with the one-error bars, extending from -2.63 to -0.85. The trend shows a peak in the
// posterior probability distribution around logzsol = -1.7. Panel c: This is a contour plot showing the
// correlation between logzsol and log(mass). The x-axis ranges from 4.4 to 6.0 and has units of log(mass). The
// y-axis ranges from -3.2 to -0.8 and has units of logzsol. There are multiple series, each represented by a
// different contour level, shown in shades of grey. There are no symbols or line styles. The trend shows a
// negative correlation between logzsol and log(mass). Panel d: This is a histogram plot of the posterior
// probability distribution of dust2. The x-axis ranges from 0.2 to 0.8 and has units of dust2. There is one
// series, a grey histogram. There are no symbols or line styles. The median of the parameter posterior, 0.59, is
// printed above the histogram, along with the one-error bars, extending from 0.28 to 0.87. The trend shows a
// peak in the posterior probability distribution around dust2 = 0.6. Panel e: This is a contour plot showing the
// correlation between dust2 and logzsol. The x-axis ranges from -3.2 to -0.8 and has units of logzsol. The
// y-axis ranges from 0.2 to 0.8 and has units of dust2. There are multiple series, each represented by a
// different contour level, shown in shades of grey. There are no symbols or line styles. The trend shows no
// strong correlation between dust2 and logzsol. Panel f: This is a contour plot showing the correlation between
// dust2 and log(mass). The x-axis ranges from 4.4 to 6.0 and has units of log(mass). The y-axis ranges from 0.2
// to 0.8 and has units of dust2. There are multiple series, each represented by a different contour level, shown
// in shades of grey. There are no symbols or line styles. The trend shows a weak positive correlation between
// dust2 and log(mass). Panel g: This is a histogram plot of the posterior probability distribution of tage. The
// x-axis ranges from 3 to 12 and has units of tage. There is one series, a grey histogram. There are no symbols
// or line styles. The median of the parameter posterior, 9.13, is printed above the histogram, along with the
// one-error bars, extending from 4.95 to 13.40. The trend shows a peak in the posterior probability distribution
// around tage = 9. Panel h: This is a contour plot showing the correlation between tage and dust2. The x-axis
// ranges from 0.2 to 0.8 and has units of dust2. The y-axis ranges from 3 to 12 and has units of tage. There are
// multiple series, each represented by a different contour level, shown in shades of grey. There are no symbols
// or line styles. The trend shows a weak positive correlation between tage and dust2. Panel i: This is a contour
// plot showing the correlation between tage and logzsol. The x-axis ranges from -3.2 to -0.8 and has units of
// logzsol. The y-axis ranges from 3 to 12 and
#figure(scope: "parent", image("imgs/M81R_model_MCMC_new.png", width: 95.0%),
  caption: [
    #strong[MCMC simulation corner plot], where the posterior probability distributions are shown for each of the five model parameters along the diagonal panels, and the correlations between model parameter posteriors are shown along the columns. Above each probability distribution, the median of the parameter posterior is printed, along with the one-$sigma$ error bars.
  ]
)
<fig:mcmc>



#heading(level: 1, numbering: none)[Data availability]
<data-availability>
The datasets generated from the EVN observations and analysed in this study are available at the Public EVN Data Archive under the experiment codes EK048B, EK048C, and EK048F.


#heading(level: 1, numbering: none)[Code availability]
<code-availability>
The codes used to analyse the data are available at the following sites: AIPS (#link("http://www.aips.nrao.edu/index.shtml")), CASA (#link("https://casa.nrao.edu")), Difmap (#link("ftp://ftp.astro.caltech.edu/pub/difmap/difmap.html")), DSPSR (#link("http://dspsr.sourceforge.net/")), FETCH (#link("http://dspsr.sourceforge.net/")), Heimdall (#link("https://sourceforge.net/projects/heimdall-astro/")), IRAF (#link("http://ast.noao.edu/data/software")), PRESTO (#link("https://github.com/scottransom/presto")), PSRCHIVE (#link("http://psrchive.sourceforge.net")), and SpS (#link("https://github.com/danielemichilli/SpS")).





==== Acknowledgements
<acknowledgements>


We would like to thank the directors and staff at the various participating stations for allowing us to use their facilities and running the observations.


The European VLBI Network is a joint facility of independent European, African, Asian, and North American radio astronomy institutes. Scientific results from data presented in this publication are derived from the following EVN project code: EK048.


This work was also based on simultaneous EVN and PSRIX data recording observations with the 100-m telescope of the MPIfR (Max-Planck-Institut für Radioastronomie) at Effelsberg, and we thank the local staff for this arrangement.


We would like to express our gratitude to Willem van Straten for modifying the DSPSR software package to fit our needs.


We appreciate helpful discussions about magnetar formation scenarios in a globular cluster environment with E. P. J. van den Heuvel.


A.B.P is a McGill Space Institute (MSI) Fellow and a Fonds de Recherche du Quebec - Nature et Technologies (FRQNT) postdoctoral fellow.


B.M. acknowledges support from the Spanish Ministerio de Economía y Competitividad (MINECO) under grant AYA2016-76012-C3-1-P and from the Spanish Ministerio de Ciencia e Innovación under grants PID2019-105510GB-C31 and CEX2019-000918-M of ICCUB (Unidad de Excelencia "María de Maeztu" 2020-2023).


Basic research in radio astronomy at NRL is funded by 6.1 Base funding. Construction and installation of VLITE was supported by the NRL Sustainment Restoration and Maintenance fund.


C.J.L. acknowledges support from the National Science Foundation Grant 2022546.


C.L. was supported by the U.S. Department of Defense (DoD) through the National Defense Science & Engineering Graduate Fellowship (NDSEG) Program.


D.M. is a Banting Fellow.


E.P. acknowledges funding from an NWO Veni Fellowship.


F.K. acknowledges support from the Swedish Research Council via Grant No. 2014-05713.


FRB research at UBC is supported by an NSERC Discovery Grant and by the Canadian Institute for Advanced Research.


J.P.Y. is supported by the National Program on Key Research and Development Project (2017YFA0402602).


K.S. is supported by the NSF Graduate Research Fellowship Program.


K.W.M. is supported by an NSF Grant (2008031).


M.B. is supported by an FRQNT Doctoral Research Award.


N.W. acknowledges support from the National Natural Science Foundation of China (Grant 12041304 and 11873080)


P.S. is a Dunlap Fellow and an NSERC Postdoctoral Fellow. The Dunlap Institute is funded through an endowment established by the David Dunlap family and the University of Toronto.


Part of this research was carried out at the Jet Propulsion Laboratory, California Institute of Technology, under a contract with the National Aeronautics and Space Administration. The NANOGrav project receives support from National Science Foundation (NSF) Physics Frontiers Center award number 1430284.


The Dunlap Institute is funded through an endowment established by the David Dunlap family and the University of Toronto. B.M.G. acknowledges the support of the Natural Sciences and Engineering Research Council of Canada (NSERC) through grant RGPIN-2015-05948, and of the Canada Research Chairs program.


The National Radio Astronomy Observatory is a facility of the National Science Foundation operated under cooperative agreement by Associated Universities, Inc. SMR is a CIFAR Fellow and is supported by the NSF Physics Frontiers Center award 1430284.


This work is based in part on observations carried out using the 32-m radio telescope operated by the Institute of Astronomy of the Nicolaus Copernicus University in Toruń (Poland) and supported by a Polish Ministry of Science and Higher Education SpUB grant.


V.B. acknowledges support from the Engineering Research Institute Ventspils International Radio Astronomy Centre (VIRAC).


V.M.K. holds the Lorne Trottier Chair in Astrophysics & Cosmology and a Distinguished James McGill Professorship and receives support from an NSERC Discovery Grant and Herzberg Award, from an R. Howard Webster Foundation Fellowship from the Canadian Institute for Advanced Research (CIFAR), and from the FRQNT Centre de Recherche en Astrophysique du Quebec


We receive support from Ontario Research Fund---research Excellence Program (ORF-RE), Natural Sciences and Engineering Research Council of Canada (NSERC) \[funding reference number RGPIN-2019-067, CRD 523638-201, 555585-20\], Canadian Institute for Advanced Research (CIFAR), Canadian Foundation for Innovation (CFI), the National Science Foundation of China (Grants No. 11929301), Simons Foundation, Thoth Technology Inc, and Alexander von Humboldt Foundation. Computations were performed on the SOSCIP Consortium's \[Blue Gene/Q, Cloud Data Analytics, Agile and/or Large Memory System\] computing platform(s). SOSCIP is funded by the Federal Economic Development Agency of Southern Ontario, the Province of Ontario, IBM Canada Ltd., Ontario Centres of Excellence, Mitacs and 15 Ontario academic member institutions.


Based \[in part\] on data collected at Subaru Telescope, which is operated by the National Astronomical Observatory of Japan.


The National Radio Astronomy Observatory (NRAO) is a facility of the National Science Foundation operated under cooperative agreement by Associated Universities, Inc.


AIPS is a software package produced and maintained by the National Radio Astronomy Observatory (NRAO).


==== Author contributions
<author-contributions>
F.K. is the Principal Investigator of the PRECISE team, he organised the observations, found the five bursts in the raw voltages and coordinated writing of the manuscript. B.M. lead the analysis of the correlated data, performed the localisation and wrote parts of the manuscript. K.N. lead the time-domain analysis of the bursts. J.W.T.H. lead the interpretation of the results and wrote parts of the manuscript. M.B. lead and performed the modelling of \[PR95\]~30244. S.P.T. performed the data reduction and analysis of the Subaru data. A.K. wrote and modified the software correlator SFXC to allow for the highest time resolution data. J.Y. assisted with the data reduction, analysis and interpretation of the correlated data. M.P.S. helped with the manuscript and created @fig:dm_rm_map. P.S. and A.B.P. reduced and analyzed the archival Chandra data. C.J.L. reduced and analysed the Realfast data. W.M.P. reduced and analysed the VLITE data. M.G. searched the Fermi catalogues. Z.P. assisted with the reduction and analysis of the correlated data. C.B. assessed the optical registration errors of the Subaru images. D.M.H. searched the PSRIX and DFB data for bursts. U.B. coordinated and performed the observations at Effelsberg. V.B. coordinated and performed the observations at Irbene. M.B. helped commissioning the dual recording mode at SRT. S.T.B coordinated and performed the observations at Noto. J.E.C. supported the observations at Onsala. A.C. implemented the dual recording mode at SRT and performed some of the observations. R.F. supports the observations at Toruń. O.F. wrote observing schedules. M.P.G. coordinated and performed the observations at Toruń. R.K. assisted with the dual recording at Effelsberg. M.A.K. supports the observations at Badary, Svetloe and Zelenchukskaya. M.L. supported the observations at Onsala and assisted with the manuscript. G.M. coordinated and performed the observations at Medicina. A.M. coordinated and performed the observations at Badary, Svetloe and Zelenchukskaya. O.S.O-B wrote observing schedules. A.P. supported the observations at SRT. G.S. ran most of the observations at SRT. N.W. and J.Y. coordinated and performed the observations at Urumqi. V.M.K. played a significant coordination role that enabled these results. All other co-authors contributed to the CHIME/FRB discovery of the source or the interpretation of the analysis results and the final version of the manuscript.


==== Competing interests
<competing-interests>
The authors declare no competing interests.


==== Additional information
<additional-information>
==== Correspondence and requests for materials
<correspondence-and-requests-for-materials>
should be addressed to F.K.

#bibliography("refs.bib", title: [References])
